unit untFatExpedicaoItens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, untTipoTinta,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids,
  EditFocus, DB, Uni, UniDataSetProvider, UniClientDataSet, StrUtils, untFuncFat,
  MaskUtils, AppEvnts, frxClass, frxDBSet, untZClient, untLibNfe, untTSituacaoPedidoVenda,
  untIteBar, BitBtnLockedIncrem, cxGraphics, cxControls, untCfgSugExp, cxProgressBar,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, untGravando,
  cxMaskEdit, cxDropDownEdit, cxImageComboBox, untTFaturamentoMercadoLivre,
  untMontagemCaixas, ImgList, MemDS, DBAccess, Provider, untFatGor, untExpDigVolumesCompostos,
  frxExportCSVTestabilidade, Datasnap.DBClient, untMovCdb, System.ImageList, untLiberacao,
  untMsgLiberacao, TypesRel, untFuncoesEtiquetas, untCfgColExpItensCaixa, untTProcessaEtiqueta,
  Vcl.DBCtrls, DBMemoFocus, Generics.Collections, Faturamento.View.DadosCTe, untTypesSistema,
  untFatSeriesItem, untFuncFatTypes, Winapi.UxTheme, CobrancaEletronica.Lib.Types,
  CobrancaEletronica.Lib.Facade, untSEPDOR_CONDOR, untTFatReprocessarSaldoItem;

const
  strAutomotivas: String = '_LAZ_SKY_GEN_PPG_ZYN_STA_WAN_WCP_SAL_GLA_DUP_AUT_FAR_GLA_MZA_NEX_BZC_BZA_DOX_STW_AJT_ROB_ALK_COA_LCA_PFA_ALA_BLA_';

Type
  TDadosProduto = Record
    strCodIte,
    strEntRet    : String;
    fltQtdIte,
    fltUnitar,
    fltUniOri    : Double;
    strPromoc    : String;
    fltDesCnd    : Double;
    blnBaixaSubItemEstrutura : Boolean;
    intSeqInclusaoEstrutura  : Integer;
    strNumOrc    : String;
    strEspOrc    : String;
    strEmpOrc    : String;
  end;

type
  THackDBGrid = class(TDBGridCitel);

  TJaExpedido = Record
    strAutInc: string;
    fltQtdExp: Double;
  End;

  TJaExpedidoList = Array of TJaExpedido;

  TTotaisPeso = Record
    strAutInc: string;
    fltPesBru: Double;
    fltPesLiq: Double;
  End;

  TTotaisPesoList = Array of TTotaisPeso;

  TEtiquetaImpressaoMultiSelecao = Record
    blnImprime: Boolean;
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strCodCli: String;
    strNomCli: String;
    fltPesBru: Double;
    fltPesLiq: Double;
    intVolume: Integer;
    intVolSepExc: Integer;
    intVolSepNExc: Integer;
  End;

  TArrEtiquetaImpressaoMultiSelecao = Array of TEtiquetaImpressaoMultiSelecao;

  TfrmFatExpedicaoItens = class(TfrmPai)
    pnlGeral: TPanel;
    dbgItens: TDBGridCitel;
    pnlRodape: TPanel;
    lblCodBar: TLabel;
    edtCodIte: TEditFocus;
    lblQtde: TLabel;
    edtQtdIte: TEditFocus;
    qryItens: TUniQuery;
    dtsItens: TDataSource;
    cdsItens: TUniClientDataSet;
    dspItens: TUniDataSetProvider;
    cdsSelecao: TUniClientDataSet;
    cdsSelecaoCODBAR: TStringField;
    cdsSelecaoCODITE: TStringField;
    cdsSelecaoDESITE: TStringField;
    cdsSelecaoNUMDOC: TStringField;
    cdsSelecaoQTDITE: TFloatField;
    cdsSelecaoUNITAR: TFloatField;
    cdsSelecaoTOTITE: TFloatField;
    cdsSelecaoUNIDAD: TStringField;
    qrySelecaoNOMEMP: TStringField;
    qrySelecaoNOMCLI: TStringField;
    qrySelecaoTIPEMB: TStringField;
    qrySelecaoNRODOC: TStringField;
    cdsSelecaoNOMVEN: TStringField;
    cdsSelecaoENDENT: TStringField;
    cdsSelecaoCIDENT: TStringField;
    cdsSelecaoSIGLA_: TStringField;
    cdsSelecaoIDEPRO: TStringField;
    cdsSelecaoDTAENT: TDateField;
    cdsSelecaoDTAVAL: TDateField;
    cdsSelecaoMENSAG: TStringField;
    cdsSelecaoCODVEN: TStringField;
    cdsSelecaoVOLQTE: TStringField;
    lblLimparExpedido: TLabel;
    shpSemSal: TShape;
    lblSemSal: TLabel;
    btnConfirma: TBitBtnLocked;
    btnQuantidade: TBitBtnLocked;
    btnExpAut: TBitBtnLocked;
    btnEtiqueta: TBitBtnLocked;
    pnlCaixas: TPanel;
    pnlCaixa: TPanel;
    lbl1: TLabel;
    lbl6: TLabel;
    lbl2: TLabel;
    btnMontarCaixas: TSpeedButton;
    btnPesarCaixa: TSpeedButton;
    cximgCaixas: TcxImageComboBox;
    staQtdItens: TStaticText;
    pnlItensCaixa: TPanel;
    dbgEtiCaixa: TDBGridCitel;
    pnl1: TPanel;
    pnlInfCaixa: TPanel;
    dtsEtiCaixa: TDataSource;
    cdsEtiCaixa: TUniClientDataSet;
    fldEtiCaixaid: TStringField;
    fldEtiCaixapedido: TStringField;
    fldEtiCaixacodigo: TStringField;
    strngfldEtiCaixadescricao: TStringField;
    cdsEtiCaixaquantidade: TFloatField;
    fldEtiCaixaunidade: TStringField;
    tmrLePeso: TTimer;
    imglsCaixas: TImageList;
    btnMarcarTudo: TBitBtnLocked;
    pnlFoto: TPanel;
    imgFotoProd: TImage;
    Label1: TLabel;
    pnlEstrutura: TPanel;
    Label3: TLabel;
    dbgDetMat: TDBGridCitel;
    pnlPicEstrutura: TPanel;
    imgFotoEstru: TImage;
    Panel1: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    edtPesBru: TEditFocus;
    cdsEtiCaixapeso: TFloatField;
    cdsEtiCaixapestot: TAggregateField;
    cdsEtiCaixaSeqCx: TSmallintField;
    cdsEtiCaixacodfab: TStringField;
    btnLimpaExp: TBitBtnLocked;
    cdsEtiCaixafgoinc: TStringField;
    cdsEtiCaixafdoinc: TStringField;
    btnReabreCaixa: TSpeedButton;
    cdsSelecaoLOCFIS: TStringField;
    cdsSelecaoDESFIS: TStringField;
    cdsSelecaoCODFAB: TStringField;
    pnlVlrMin: TPanel;
    lblTitVlrExpTot: TLabel;
    lblTitVlrMinEnt: TLabel;
    lblTitVlrMinRet: TLabel;
    lblVlrExpTot: TLabel;
    lblVlrMinEnt: TLabel;
    lblVlrMinRet: TLabel;
    lblErrImg: TLabel;
    btnSelMan: TBitBtnLocked;
    btnEtqSepFaltante: TBitBtnLocked;
    btnMostrarCortados: TBitBtnLocked;
    lblEAN39: TLabel;
    tmrClose: TTimer;
    btnCfgExpItens: TBitBtnLocked;
    pnlAplicacao: TPanel;
    pnlAplica: TPanel;
    mmoAplica: TDBMemoFocus;
    tmrConfirmarAutomaticamente: TTimer;
    btnNumSeries: TBitBtnLocked;
    btnItensNaoExpedidos: TBitBtnLocked;
    cdsSelecaoREFERE: TStringField;
    cdsSelecaoCODCLI: TStringField;
    btnImpEtiCaixa: TSpeedButton;
    chkTodasAsCaixas: TCheckBox;
    btnDigCodBarLocFis: TBitBtnLocked;
    cdsValoresCli: TUniClientDataSet;
    cdsValoresCliCLI_CODCLI: TStringField;
    cdsValoresCliCLI_NOMCLI: TStringField;
    cdsValoresCliCLI_VLMINE: TFloatField;
    cdsValoresCliCLI_VLMINR: TFloatField;
    dtsValoresCli: TDataSource;
    btnVisualizarVlrMinEnt: TBitBtnLocked;
    pnlQtdVariasChapasLote: TPanel;
    lblQtdChapa: TLabel;
    edtQtdChapas: TEditFocus;
    btnEditarMensagem: TBitBtnLocked;
    chkCaixaRapida: TCheckBox;
    grbImpSeq: TGroupBox;
    edtVolume: TEditFocus;
    lblVolume: TLabel;
    chkImpSeq: TCheckBox;
    pnlResumoUnidadeItens: TPanel;
    pnlResumo: TPanel;
    mmoResumoUnidades: TMemo;
    lblStatusCaixa: TLabel;
    lblDimensaoCaixa: TLabel;
    cxImgDimensaoCaixa: TcxImageComboBox;
    pnlTotalExpedido: TPanel;
    edtTotalExpedido: TEditFocus;
    lblTotalExpedido: TLabel;
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnQuantidadeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExpAutClick(Sender: TObject);
    procedure dbgItensEnter(Sender: TObject);
    procedure dbgItensExit(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnEtiquetaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnMontarCaixasClick(Sender: TObject);
    procedure cximgCaixasClick(Sender: TObject);
    procedure btnPesarCaixaClick(Sender: TObject);
    procedure tmrLePesoTimer(Sender: TObject);
    procedure btnImpEtiCaixaClick(Sender: TObject);
    procedure btnPesarCaixaMouseEnter(Sender: TObject);
    procedure btnPesarCaixaMouseLeave(Sender: TObject);
    procedure btnImpEtiCaixaMouseLeave(Sender: TObject);
    procedure btnImpEtiCaixaMouseEnter(Sender: TObject);
    procedure btnMontarCaixasMouseLeave(Sender: TObject);
    procedure btnMontarCaixasMouseEnter(Sender: TObject);
    procedure dbgEtiCaixaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgEtiCaixaMouseEnter(Sender: TObject);
    procedure dbgEtiCaixaMouseLeave(Sender: TObject);
    procedure btnMarcarTudoClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cdsItensAfterScroll(DataSet: TDataSet);
    procedure dbgDetMatDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgDetMatMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure edtPesBruChange(Sender: TObject);
    procedure cdsEtiCaixaAfterPost(DataSet: TDataSet);
    procedure btnLimpaExpClick(Sender: TObject);
    procedure btnReabreCaixaClick(Sender: TObject);
    procedure btnSelManClick(Sender: TObject);
    procedure btnEtqSepFaltanteClick(Sender: TObject);
    procedure btnMostrarCortadosClick(Sender: TObject);
    procedure tmrCloseTimer(Sender: TObject);
    procedure imgFotoProdDblClick(Sender: TObject);
    procedure imgFotoEstruDblClick(Sender: TObject);
    procedure btnCfgExpItensClick(Sender: TObject);
    procedure pGravarConfiguracoesExpedicaoItens;
    procedure FormDestroy(Sender: TObject);
    procedure tmrConfirmarAutomaticamenteTimer(Sender: TObject);
    procedure btnNumSeriesClick(Sender: TObject);
    procedure btnItensNaoExpedidosClick(Sender: TObject);
    procedure btnDigCodBarLocFisClick(Sender: TObject);
    procedure btnVisualizarVlrMinEntClick(Sender: TObject);
    procedure btnEditarMensagemClick(Sender: TObject);
    procedure chkCaixaRapidaClick(Sender: TObject);
    procedure chkImpSeqClick(Sender: TObject);
  private
    { Private declarations }
    FParams: TExpedicaoParams;
    FConfirmou: Boolean;
    FFdoSeqGerExpPar: String;
    FFdoSeqGerComExp: String;
    FFdoAutIncComExp: String;

    strIndexField  : String;
    strAKZTraPed : String;
    strAKZTabPre : String;
    strAKZClaFis : String;
    blnIgnorarScroll: Boolean;
    blnImprimindoEtiquetaCaixa: Boolean;
    blnMarcandoTodos: Boolean;

    intSemaforoExpAut: Integer;

    intCorZeb    : Integer;
    blnFecharForm: Boolean;
    strCodIte    : String;
    strNumLot    : String;
    strCodDig    : String;
    strCamBus    : String;
    blnOndaSepComCodBar : Boolean;
    fatVenEst    : TFatVenda;
    fatVenCCR    : TFatVenda;
    stlItens     : TStringList;
    strNomImp    : String;
    qryEtique    : TUniQuery;
    VS_strTipDEx : String;
    blnImpEti    : Boolean;
    blnEtiVol    : Boolean;
    objIteBar    : TIteBar;
    intDecQtd    : Integer;
    strMsgSel    : String;
    strCodIteFor : String;
    strUltAutIncExp: String;
    blnCamBusRetira: Boolean;

    strInfoAnt: String;
    frmFechamentoVenda : TfrmGravando;

    strCodBarComplementar: String;
    strCmpBusComplementar: String;

    strLogFileName: String;

    strOrdExi: String;
    strOrdDoc: String;

    objMontarCaixas: TMontarCaixas;

    strBarBal: String;

    objCodBar: TCodigoBarras;

    cdsDetMat : TZClient;
    strPrefixCx : String;
    strWhereComItensFgoCai : String;
    qryItensSemCaixa : TUniQuery;

    blnUsaPafEcf: Boolean;

    blnTemItensTintas : Boolean;
    blnTemItensRetira : Boolean;
    blnItemConferido  : Boolean;
    blnSeparacaoErrada: Boolean;
    blnInsParcial     :Boolean;
    blnExiApl         :Boolean;

    objLiberacao : TLiberacao;

    dtaInicioConferencia : TDateTime;
    dtaFinalConferencia  : TDateTime;

    strTodosNumSer: string;
    strTodosCodIte: string;
    strTodosPedidos: string;
    blnInformouNumSer: Boolean;
    blnIncluirNumSer: Boolean;
    blnAlterouVolumes: Boolean;
    blnValidouLotePeloCodigoBarrasDoLote: Boolean;

    objFatSerieItem: TFatSerieItem;

    arrJaExpedidoList: TJaExpedidoList;
    arrTotaisPeso: TTotaisPesoList;

    arrEtiquetaImpressaoMultiSelecao: TArrEtiquetaImpressaoMultiSelecao;

    cdsSetores: TUniClientDataSet;

    strTipPedMultiplos : String;
    blnImpEtiDespachoVolumeComposto: Boolean;
    stlListaCondicaoPagamento: TStringList;

    arrDocumentoGerados: TArray<String>;

    blnSitFinPedsSelOK : Boolean;

    strCodConferente: String;
    strCodSeparador: String;

    blnValidaNumeroSerie: Boolean;
    stlItensNumSerieExpAut: TStringList;

    objConDor : TConDor;
    blnUtilizaSeparacaoExclusiva: Boolean;

    blnJaExibiuTelaDigVolumesCompostos: Boolean;
    blnCarregandoDadosItemEstrutura : Boolean;

    procedure pCarregarDadosItemEstrutura;
    function fRetornaCelCli: String;

    function fQtdIteDisponivelParaExpedicao: Double;
    function fValidaDireitoAcesso: boolean;
    function fCodBarEmbUn :String;
    function fUsaMontagemCaixas: Boolean;
    procedure pPreencheListaCaixas;
    procedure pPrencheGridItensCaixa(blnRelatorio : Boolean = False);
    procedure pSetaBotaoMontarCaixas(strCaption: String);
    procedure pCalculaPesoBrutoLiqExpedicao(fatVenda: TFatVenda);

    procedure pExpedeItem(blnExpAut: Boolean = False; blnValidaBarExp: Boolean = True);
    procedure pExpedeItemOndaSep;

    procedure pMarcarTodos;
    procedure pExpedicaoAutomatica;

    procedure pOnCalculaTotGer(const item: TDadosFechamento; index, count: Integer; AInfo: String = '');
    procedure pCalculaTotGer(fatVenda: TFatVenda;
                             blnZeraPercentuaisDesconto: Boolean = False;
                             blnCalculaImpostos: Boolean = True;
                             blnPegaClassificacaoItem: Boolean = True);

    procedure pConfirmandoExpedicao(pgbStatus: TcxProgressBar = nil);

    function fEhFaturamentoDePedidoOriundoDeConsignacao : Boolean;

    function fAlterarTransportadora(fatVenda: TFatVenda) : Boolean;

    {Estrutura}
    function fCarregaEstrutura(Item : TDadosFechamento;
                               blnBaixaSubItemEstrutura : Boolean) : Boolean;

    function fInserirProduto(dadosProduto : TDadosProduto;
                             fatVenda     : TFatVenda): Boolean;

    procedure pImprimirEtiquetas;
    procedure pLimparExpedicao;
    function fTemInconsistenciaVarValRecOuValAdt(out strMsgErr: String): Boolean;

    procedure pCarregaItensPedido(blnReimpressaoVolumes : Boolean = False);
    function fSQLQuantidadeEntregaFutura: String;
    procedure pSelecionaItem;
    procedure pPedeDigVolumes(fatVenda: TFatVenda; blnValidaImpressaoDespacho: Boolean = False);

    procedure pCarregaItensDocumento;
    function fConfirmaDocumento(strSepExp: String = ''; blnParcial: Boolean = False; strOpeExp: String = ''; blnSolicitouConfSep: Boolean = False; cdsSetores: TClientDataSet = NIL; strObsExp: String = ''; strCodEmb: String = ''): Boolean;
    function fVaiGravarCONDOR_AUTCOM_DocVenda():Boolean;

    procedure pAtualizaTemporaria(fatVenda: TFatVenda);

    procedure pEdtCodIteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pOnFilter(DataSet: TDataSet; var Accept: Boolean);
    function fEncontraItem(Var strMensagem : String;
                           blnAtualizaQtde : Boolean = True): Boolean;

    procedure pAdicionaItemSelecao;
    procedure pRemoveItemSelecao;
    procedure pCarregaSaldosColorantes;

    function fSelecionado: Boolean;
    function fImprimeEtiquetas(strNomImp: String): Boolean;
    function fRetQtdDigitada(strCodIte: String): Double;
    function fRetQtdDigitadaPorLote(strCodIte: String; strNumLot: String = ''): Double;
    function fRetQtdPendente(strCodIte: String): Double;
    function fRetQtdPendenteItemPosicionado(): Double;

    function fTodosItensForamExpedidos(): Boolean;

    function fExcedeLimiteItensNFe: Boolean;

    function fSolicitaConferenteSeparador(Var strCodCon: String; Var strCodSep: String; Var strObsExp: String; Var strCodEmb: String; Var blnSeparadorApareceuDesabilitado: Boolean): Boolean;
    function fExpedePedido(fltQtdExp: Double): Boolean;
    function fMarcaPedidoExpedido(strCodCon, strCodSep, strObsExp: String; blnAtualizarSeparadorSomenteSeVazio: Boolean = False; cdsSetores: TClientDataSet = Nil; strEmbExp: String=''): Boolean;

    procedure pAtualizaExpedicaoItens(const strCodCon, strCodSep, strObsExp, strEmbExp: string; const blnAtualizaQtdExp: Boolean; fatVenda: TFatVenda = Nil);

    procedure pImprimirDANFE(strNumDoc, strEspDoc, strCodCli, strCodEmp, strSerie: String; const AblnEtiquetaUnificadaSemDanfe: Boolean);

    procedure pImprimeEtiquetaDespacho(strNumDoc, strEspDoc, strCodCli: String; intQtdTra: Integer; strCodEmp: String; out AResultadoUnificacao: TResultadoEtiquetaUnificada;
      blnImpEtiDespachoVolumeComposto: Boolean = False; intQtdTraSepExc: Integer = 0; intQtdTraSepNaoExc: Integer = 0; strMultPed: String = ''; strSerie: String = '');
    procedure pImprimePedidosQtdePendente;
    procedure pMarcarTodosProdutos(blnExpAut: Boolean = False; blnMarcaRegAtual : Boolean = False; fltQtdPar: Double = 0; blnVerificaNecessidadeDeExpedicaoDoProduto: Boolean = False);
    procedure pOrdenarItens;

    procedure pOrdenarItensConfigurado;

    function fTemPedidoComFrete: Boolean;
    function fTemPedidoFaturadoParcialmente: Boolean;
    Function fTemQuantidadePendente(strNumDoc,
                                    strEspDoc,
                                    strCodEmp: String): Boolean;

    procedure pApagaDigitacaoLotesWMS(fatVenda : TFatVenda);
    function fGetSQLDetMat: String;
    procedure cdsDetMatAfterScroll(DataSet: TDataSet);
    procedure pImprimeListaCaixas(blnAvisaSemMov : Boolean = False);
    function fLimparExpedido: boolean;
    procedure pSalvaCaixas;
    procedure pCarregaCaixas(blnNaoFaturados: Boolean = True);
    function fAtualizaOcorrenciaCRM: Boolean;
    procedure pSetarFiltroEstoque(stlItens: TStrings);
    procedure pAtualizaInformacaoDoTotalExpedido;
    function fTemItensTintas: Boolean;
    function fTemItensRetira: Boolean;
    function fTemSomenteItensRetira: Boolean;
    function fTemItensExpedidos: Boolean;
    procedure pImprimeEntrega(fatVenda: TFatVenda);
    procedure pGravarConfiguracaoColunas;

    procedure pFaturarCaixasPedidos(stlLstPed: TStringList; strNumFat, strTipFat, strEmpFat: String);
    procedure pFatCaixaPedidoAutInc(stlLstPed: TStringList; strAutInc: String);
    function fCarregaConfiguracoesAKZNobel: Boolean;

    procedure pAmpliaFoto(strCodIte: String);
    function fValidaPesoCaixa: Boolean;
    procedure pBaixaBoxWMS;
    procedure pExpedirSubItensEstruturaOndaSeparacao();
    function fImpEtiquetaSepErrada(strCodIte, strNomSep: String):Boolean;
    procedure pGeraLogSepErrada(strNumDoc, strEspDoc, strCodEmp, strCodOpe,
      strCodSep: String; dtaDtaCad: TDateTime; horHorCad: TTime;
      strCodIte: String; fltQtdBip, fltQtdPed: Double);
    procedure pImprimirSeparacaoErrada(cdsDocumento: TUniClientDataSet);
    procedure pTocarAlertaSonoro(blnAchou: Boolean);
    function fVaiFaturarAposExpedirTodosOsItens: Boolean;
    function fValidaSituacaoFinanceiraPedidosSelecionados: Boolean;
    procedure pOcorrenciaSeparacaoErrada(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodSep, strCodOco, strCodToc: String;hrsImpSep:TTime);
    function fDescricaoResumidaLocFis: String;
    function fTemControleNumeroSerie(const strCodBar: string; var strCodIte: string): Boolean;
    function fExisteNumeroSerie(strNumSer, strCodIte: string): Boolean;
    procedure pUtilizaNumeroSerie(strNumDoc, strNumSer, strCodIte: string);
    function fImpEtiqCodBarrasProduto(cdsItens: TUniClientDataSet; intQtdEti: Integer = 1) : Boolean;
    function fItemTemRetira(strCodIte: string; fltQtdDig: Double): Boolean;

    function fVerificaConPagMaiorPrazo(const fltTotGer: Double; var strCodCnd, strConPag, strCodFpg: String): Boolean;

    procedure pCarregaSeriesItens;
    function fAbreFormSeries(const fltQuantidade : Double; const blnIncrementarQtdItemPedDosExistentes : Boolean = False): Boolean;
    function fValidaQuantSerieItens: Boolean;
    function fGravaSeriesNseDor: Boolean;
    procedure pCarregaPesoItens(var fltPesoBru, fltPesoLiq: Double);
    procedure pCarregaRecordItensExpedidos;
    procedure pGravaPesoExpedicao(fltPesBru, fltPesLiq: Double; intQtdPedido: integer);
    procedure pRetPesoItemFaturamento(var fltPesBru, fltPesLiq: Double);
    procedure pLimpaPesoTempItens;
    procedure pCarregaTotaisPesoItensExpedidos;
    procedure pZeraPesoExpedido;

    procedure pVerificarPromocaoBrindes(strNumDoc, strEspDoc, strCodCli, strNomCli: String);

    function fRetNumLotesSep: String;

    function fVerificaOSItemReserv: Boolean;
    function fConfirmarExpedicao(pgbStatus: TcxProgressBar = nil): Boolean;
    function fRetCodBarraCliPro: String;
    procedure pMontaListaClientes;
    Procedure pValorMinimoNotaFiscalEntregaLista(var fltVlwMinEnt : Double);
    Procedure pValorMinimoNotaFiscalRetiraLista(var fltVlwMinRet : Double);
    procedure pMensagemGarantiaEnvioClienteExp;
    procedure pMontaListaGrupos;
    procedure pAlimentarDatasetValoresMinimos;
    procedure pLiberarExpedidos;
    procedure pImprimirEtiqVendasProdutosControlados;
    function fSelecaoMultipla : Boolean;
    function fValidaEstoqueSubItensEstrutura(strCodIte: String; fltQtdIte: Double; strNumDoc: String): Boolean;
    function fGetQuantidadeRegistrosExpedidos(const cdsDados: TUniClientDataSet) : Integer;
    procedure pGravarInformacoesSeparacao;
    procedure pGravaControleLALAMOVE(strNumDoc, strEspDoc, strCodEmp, strCodCli: String);
    procedure pMontaListaCondicaoPagamento(stlPedidos : TStringlist);
    function fAgrupaPedidoPorCondicaoPagamento: Boolean;

    function fMaisDeUmPedidoDoMesmoClienteComAdiantamento(const stlDocumentosSelecionados : TStringList) : Boolean;

    function fAbrirCaixa():Boolean;
    function fFecharCaixa():Boolean;

    function fValidaVolume(blnShowMsg : Boolean = True):Boolean;
    function fPodeAdicionarCaixaImpSeq(blnShowMsg : Boolean = True):Boolean;
    function fTemCaixaAberta():Boolean;
    function fTemCaixasNaExpedicao():Boolean;

    function fConsiderarTodasAsCaixas():Boolean;
    function fUtilizaCaixaRapida():Boolean;
    function fUtilizaImpressaoSequencial():Boolean;
    function fEscondeMensagensAberturaEFechamentoCaixa():Boolean;
    function fRetCodigoAbrirFecharCaixa():String;

    function fExpedicaoJaIniciada():Boolean;

    procedure pSetEnabledImpSeq(blnEnabledImpSeq : Boolean);
    procedure pCarregaImpSeq();
    procedure pMostraTelaImpressaoDespachoMultiSelecao;
    procedure pAtualizaPesoImpressaoDespachoMultiSelecao(strNumDoc, strEspDoc, strCodEmp, strCodCli: String; fltPesBru, fltPesLiq: Double);

    function fMarcaProdutoSemNecessidadeDeExpedicao: Boolean;
    function fProdutoComControleDeNumeroSerie(strCodIte, strCodEmp: String): Boolean;

    function fExpedindoMaisDeUmPedido():Boolean;
    procedure pCarregaResumoUnidadesItens;
    procedure pAtualizarTipoBuscaItensPedido(fatVenda: TFatVenda);

    function fValidarNumeroSerieProdutos: Boolean;
    function fGravarNumeroSerieProdutosExpedidos: Boolean;

    function fExisteCaixaAbertaEmMontagem: Boolean;

    function fRetornaEmpresaExpedicaoSePedidoOutraLoja: String;
    procedure pDefinirEmpresaFaturamentoPedido(var strEmpOriRegEsp: string; var blnRegEsp: Boolean);

    procedure pCarregarDadosListaPedidos;
    procedure pCarregarListaAutIncPedidosItensExpedidos;
    function fVaiImprimirMultiplosPedidosNaEtiquetaDeDespacho(var strMultPed, strMultNumDoc, strMultEspDoc, strMultCodEmp, strMultCodCli: String; stlPedidos: TStringList): Boolean;
    function fUtilizaImpressaoMultiplosPedidos(stlPedidos: TStringList): Boolean;
    procedure pVinculaPedidosComMesmoClienteExpedidosJuntos(stlPedidos: TStringList);
    function fRetornaTotalVolumePedidosExpedidosJuntos(stlPedidos: TStringList; intQtdOri: Integer): integer;
    procedure pEhDocumentoDeEmpresaPrioridade(var strCodEmpPrioridade: String; strAutInc, strEspdoc: String);
    function fContemPedidosEmpresaPrioridade: Boolean;

    procedure pImprimeTicketIF(fatVenda: TFatVenda);
    function fImprimirTicketIFExpedicao(fatVenda: TFatVenda): Boolean;
    function fIdentificadorDoItemNoPedidoDaCaixaAberta: String;
    procedure pAtualizaItemPertencenteACaixaAberta(strAutoIncrem: String; Var strMensagem: String);
    function fControlarMontagemDeCaixaPorPedido: Boolean;
    function fQuantidadeDeEtiquetas: Integer;
    procedure pMudaStatusCaixa;
    function fSair: Boolean;

    function fRetAutIncMovdet(strAutIncFdo: String): String;
    function fSomenteFaturarParcialEmFF(var blnAbortarFaturamento: Boolean): Boolean;

    procedure pPreencheListaDimensaoCaixa;
    procedure pSelecionaListaDimensaoCaixa;
    procedure pGravarDadosEtiqueta(const cdsCaixa: TUniClientDataSet;
      const caixa: TCaixa);
    function fRetornaSeparadorColetor (strNumdoc, strEmpDoc, strEspDoc : String): String;

    function fCarregaEtiquetaVolumeCompostoPedidos(stlPedidos: TStringList;
                                                   Var strCodVol: String): TUniQuery;
    procedure pVinculaEtiquetaVolumeCompostoAosPedidos(stlPedidos: TStringList;
                                                       strCodigoVolume: String);
    function fLiberacaoExpedicaoAutomatica: Boolean;
    function fRetornaSeparadorColetorSepDor: String;
    function fPedidoGarantiaTE(stlDocumentosSelecionados: TStringList): Boolean;
    function fPedidoDoMesmoCliente(const stlDocumentosSelecionados: TStringList): Boolean;
    function fVaiCompararQuantidadeComColetor():Boolean;
    function fValidaQTDSEPWMS():Boolean;
    function fMarcadaOpcaoEtiquetasDespacho(blnVolumeComposto: Boolean): Boolean;
    function fHabilitarManutencaoDeSerie: Boolean;
    procedure pLimparDigitacaoDeSeries(const cdsItens : TUniClientDataSet);
    function fSomenteExpedirSemFaturar: Boolean;
    function fValidaQuantidadeItensCaixasItensExpedidos: Boolean;
    function fProcessouNoColetor(strAutInc: String): Boolean;
    procedure pEnableCdsItens();
    function fFaturamentoParcialUtilizandoLocTransitoria(const ASeqFGO: String): Boolean;
    function fValidouObjetosDaConfirmacao : Boolean;
  protected
    objEtiqueta: TProcessaEtiqueta;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    class var strCodSepOnda: String;
    class var strCodConOnda: String;
    class var strObsExpOnda: String;

    class procedure pReimprimeListaCaixas(objPedido : TPedidoVenda);

    class procedure pSqlFrom(stlItens: TStrings;
                             blnReimpressaoVolumes,
                             blnExiPedRetiraExpAntFat,
                             blnApenasFaturarJaExpedidos,
                             blnApenasConferenciaProdutosRetiraCaixa: Boolean;
                             strOrdExi  : String;
                             stlPedidos : TStringList;
                             blnUsaImpressaoSeparacaoPorLocal: Boolean;
                             blnPedidoContemItemPrioridade: Boolean = False;
                             blnFiltroEntregaERetira: Boolean = False);

    class procedure pSqlParams(qryItens: TUniQuery; strCodEmp: String = '');

    property Params: TExpedicaoParams read FParams write FParams;

    property strFdoSeqGerExpPar: String read FFdoSeqGerExpPar;
    property strFdoSeqGerComExp: String read FFdoSeqGerComExp;
    property strFdoAutIncComExp: String read FFdoAutIncComExp;

    property blnConfirmou: Boolean read FConfirmou;
  end;

implementation

uses  untFuncoes, System.UITypes, untAdiantamentoCliente,
      untConstantes, untFatDadosFiscais, untFatTipoExpedicao,
      untExpDigVolumes, untImpEtiDespacho, untFuncTinta,untFuncoesSimples,
      untTMatrizSaldosColorantes, untFatDigSepConferente, untCfgRel,
      untModuloSPR, Math, untEmissaoNotaEspecial, untMovGer, untObservacao,
      untFatExpedicao, untFatDigDadosConcreto, untCadProFoto, Faturamento.Classes.TValidarVenda,
      untAtualizaOcorrenciasCRM, untFuncoesCRM, untProdAcabado,
      untModuloFatExpedicaoItens, untFatExpSelManual, untFatResolveConflitoPedidos,
      untDuplicatas, untQckFatImpNFCe, untDisparaEmailAut, untFuncoesImagem,
      untFatExpedicaoItensCortados, untInputDialog, untImagens, untConsultas,
      MMSystem, untFuncFatImp, untConfigExpedicaoItens, untTypesCRM,
      untIFatEntregaFutura, untTFatEntregaFutura, untFatExpedicaoSubItens,
      untValidaSituacaoFinanceiraPedido, untVinculacaoNotaCompra,
      untValidadorDaRegraValorEmissaoNFCePorEstado, untFatMultiSerie, untAlpe,
      untFatSeparadorConferente, untPromocaoBrindes, untFatPromocaoBrindes, untGarant,
      untFuncoesRel, untFuncoesRel2, untParCalculaPrecoCusto, untTConfiguracao ,untExpDigVolumesSelecaoMultipla,
      untDllOpeProd, untDllOpeProdFuncoes, untFatVerItensDocRom, untLinkPagamentoCitelUtil, untFatMensagemExpedicao,
      untCadLote, untJadlog, untDigTransportadora, untBancos, untDigQtdEti,
      untValidaCondicaoPagamento, untTConsultaCadastroFit, untFatImpressao,
      untMensagemExplicativa;

{$R *.dfm}

function TfrmFatExpedicaoItens.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtCodIte) Then
  Begin
    Result := True;

    If VS_strTipDEx = '1' Then
      blnMudarFoco := False;
  End

  Else If (Sender = edtQtdIte) Then
  Begin
    If (fEmptyStr(edtQtdIte.Text)) Then
    Begin
      pMensagemSonora('A quantidade deve ser preenchida!');
      Result := False;
    End
    Else If (fStrToFloat(edtQtdIte.Text) <= 0.0) Then
    Begin
      pMensagemSonora('A quantidade deve ser maior que Zero!');
      Result := False;
    End
    Else If (Frac(fStrToFloat(edtQtdIte.Text)) <> 0) And Assigned(edtQtdIte.OnKeyPress) Then
    Begin
      {**********************************************************************}
      { CHECAGEM ADICIONAL, CASO O USUÁRIO TENTE DIGITAR UM VALOR FRACIONADO }
      { SEM APAGAR A VÍRGULA DA MÁSCARA                                      }
      {*******************************************************************VA*}
      fMensagem('ATENÇÃO!', 'Não é permitido informar valor fracionado para esse item!', ['&O k']);
      Result := False;
    End
    Else
    Begin
      blnMudarFoco := False;
      if pnlQtdVariasChapasLote.Visible then
        pSetFocus(edtQtdChapas)
      else
        pSetFocus(edtCodIte);

      if not pnlQtdVariasChapasLote.Visible then
        If VS_strTipDEx = '1' Then
        begin
          edtQtdIte.Enabled := False;
          edtQtdChapas.Enabled := False;
        end
        Else
        Begin
          pExpedeItem;
          edtQtdIte.Text := FloatToStrF(1, ffFixed, 12, intDecQtd);
        End;
    End;
  End
  else if (Sender = edtQtdChapas) and
          (blnBuscaPorChave) and
          (pnlQtdVariasChapasLote.Visible) then
  begin
    if (fStrToFloat(edtQtdChapas.Text) < 0) Then
    begin
      fMensagem('ATENÇÃO!', 'A quantidade de chapas precisa ser preenchida com um valor positivo.', ['&Ok']);
      Result := False;
    end
    else
    begin
      blnMudarFoco := False;
      pSetFocus(edtCodIte);

       If VS_strTipDEx = '1' Then
      begin
        edtQtdIte.Enabled := False;
        edtQtdChapas.Enabled := False;
      end
      Else
      Begin
        pExpedeItem;
        edtQtdIte.Text    := FloatToStrF(1, ffFixed, 12, intDecQtd);
        edtQtdChapas.Text := FloatToStrF(0, ffFixed, 12, intDecQtd);
       End;
    end;
  end;


  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmFatExpedicaoItens.fPedidoDoMesmoCliente(
  const stlDocumentosSelecionados: TStringList): Boolean;
var
  intContador  : Integer;
  strCodCli : String;
begin

  Result := True;

  If Not fPermitirMarcarPedidosDeClientesDiferentesNaExpedicao Then
    Exit;

  If Not (stlDocumentosSelecionados.Count > 1) Then
    Exit;

  If Not (FParams.stlListaClientes.Count = 1) Then
    Exit;

  strCodCli := TPedidoVenda(stlDocumentosSelecionados.Objects[0]).strCodCli;

  For intContador := 1 To stlDocumentosSelecionados.Count -1 Do
  Begin
    If TPedidoVenda(stlDocumentosSelecionados.Objects[intContador]).strCodCli <> strCodCli Then
      Result := False;
  End;

end;

function TfrmFatExpedicaoItens.fPedidoGarantiaTE(
  stlDocumentosSelecionados: TStringList): Boolean;
begin
  Result := False;

  If (Not Assigned(stlDocumentosSelecionados)) Then
    Exit;

  If (stlDocumentosSelecionados.Count = 0) Then
    Exit;

  Try
    Result := TPedidoVenda(stlDocumentosSelecionados.Objects[0]).blnGaraTE;
  Except
    Result := False;
  End;
end;

function TfrmFatExpedicaoItens.fPodeAdicionarCaixaImpSeq(blnShowMsg : Boolean = True): Boolean;
begin
  Result := True;

  If (chkImpSeq.Checked) Then
  Begin
    If (cximgCaixas.Properties.Items.Count >= StrToIntDef(edtVolume.Text, 0)) Then
    Begin
      Result := False;

      If (blnShowMsg) Then
        fMensagem('ATENÇÃO!', 'Não é possível adicionar mais caixas, limite de volume atingido!', ['&O k']);
    End;
  End;
end;

function TfrmFatExpedicaoItens.fProdutoComControleDeNumeroSerie(strCodIte,
  strCodEmp: String): Boolean;
begin
  Result := Not fEmptyStr((fCampoTabela(' DISTINCT SER_NUMSER','PROSER',['SER_CODITE','SER_CODEMP'],[strCodIte,strCodEmp])));
end;

procedure TfrmFatExpedicaoItens.pExpedeItem(blnExpAut: Boolean = False; blnValidaBarExp: Boolean = True);
var
  strMensagem  : String;
  blnAchou,
  blnBarExp    : Boolean;
  strCodSem    : String;
  strCodIteUni : String;
  strCodGruUni : String;
  fltQtdIteUni : Double;
  strTxtCap    : String;

  strCodIteAux : String;
  strCodDigAux : String;
  strCamBusAux : String;

  fltQtdBal : Double;
  intQtdBal : Integer;

  strCodCliPro : String;

  strIndexFieldNames : String;

  lstrCodIte: string;
  strNumSer: string;
  intQuantITEBAR: integer;
  strCodIteRet: string;
  strNumLotRet: string;

  function fTitBusMsg: String;
  begin
    Result := IIF(strCamBus='CODITE', 'Produto', 'Código de Barras');
  end;

  procedure pInverteLabelBusca;
  begin
    If (strCamBus='CODBAT') Then
    Begin
      strTxtCap:=CAP_CODBAR_EMB;
      lblCodBar.Caption:=CAP_CODBAR_FOR;
    End
    Else
    Begin
      strTxtCap:=CAP_CODBAR_FOR;
      lblCodBar.Caption:=CAP_CODBAR_EMB;
    End;
  end;

  procedure pArmazenaCondicaoBusca(chrAcao:char);
  begin
    Case chrAcao Of
    'A':Begin
          strCodIteAux := strCodIte;
          strCodDigAux := strCodDig;
          strCamBusAux := strCamBus;
        End;
    'V':Begin
          strCodIte := strCodIteAux;
          strCodDig := strCodDigAux;
          strCamBus := strCamBusAux;
        End;
    End;
  end;

  function fSenhaParaProsseguirExpedicaoQuandoItemNaoEncontrado(strMsg: String): Boolean;
    Var
      strNTrava: String;
      objLiberacao : TLiberacao;
  begin
    If fVerificaAcessoSistema('PRITNAEN') Then
      Exit(True);

    objLiberacao := TLiberacao.Create;
    try
      objLiberacao.objMsgLibera.pAddTexto(strMsg);
      objLiberacao.strDirAce := 'PRITNAEN';
      objLiberacao.blnTraTel := True;
      objLiberacao.strSenLib := '';
      objLiberacao.strMsgSen := 'Expedição - Prosseguir expedição quando item não encontrado!';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := '';

      Result := fMensagemLiberacao(objLiberacao, strNTrava, nil);

    Finally
      FreeAndNil(objLiberacao);
    End;
  end;

  procedure pIdentificaPreparaExpedicaoTintometrica;
    Var
      blnExpedicaoItemTintometrico,
      blnAchou: Boolean;
  Begin
    If (blnTemItensTintas) And (Length(edtCodIte.Text) > fTamCodIte) Then
    Begin
      blnExpedicaoItemTintometrico := False;
      pArmazenaCondicaoBusca('A'); //ARMAZENA
      strCodIte := edtCodIte.Text;
      Try
        strCamBus := 'CODBAR'; //CÓDIGO DE BARRAS EMBALAGEM
        blnAchou  := cdsItens.FindFirst;
        blnExpedicaoItemTintometrico := blnAchou And (cdsItens.FieldByName('IDEPRO').AsString <> 'NOR');
        If (blnExpedicaoItemTintometrico) And (fCfgSis('EXPTIN') = '2') Then
        Begin
          pInverteLabelBusca;
          strCmpBusComplementar := 'CODBAT';
          strCodBarComplementar := Trim(InputBox('AutCom', strTxtCap, ''));
          strCodIteFor          := strCodBarComplementar;
        End;

        If (Not blnAchou) Then
        Begin
          strCamBus := 'BAREMB'; //CÓDIGO DE BARRAS EMBALAGEM
          blnAchou  := cdsItens.FindFirst;
          blnExpedicaoItemTintometrico := blnAchou And (cdsItens.FieldByName('IDEPRO').AsString <> 'NOR');
          If (blnExpedicaoItemTintometrico) And (fCfgSis('EXPTIN') = '2') Then
          Begin
            pInverteLabelBusca;
            strCmpBusComplementar := 'CODBAT';
            strCodBarComplementar := Trim(InputBox('AutCom', strTxtCap, ''));
            strCodIteFor          := strCodBarComplementar;
          End;
        End;

        If (Not blnAchou) And (fCfgSis('EXPTIN') = '2') Then
        Begin
          strCamBus := 'CODBAT'; //CÓDIGO DE BARRAS FÓRMULA
          blnAchou  := cdsItens.FindFirst;
          blnExpedicaoItemTintometrico := blnAchou And (cdsItens.FieldByName('IDEPRO').AsString <> 'NOR');
          If (blnExpedicaoItemTintometrico) Then
          Begin
            If (Pos(cdsItens.FieldByName('IDEPRO').AsString, strAutomotivas) <= 0) Then
            Begin
              pInverteLabelBusca;
              strCmpBusComplementar := 'CODBAR;BAREMB';
              strCodBarComplementar := Trim(InputBox('AutCom', strTxtCap, ''));
              strCodIteFor          := strCodBarComplementar;
            End;
          End;
        End;
      Finally
        If (Not blnExpedicaoItemTintometrico) Then
          pArmazenaCondicaoBusca('A'); //VOLTA
      End;
    End;
  End;

begin
  pSetEnabledImpSeq((Not fExpedicaoJaIniciada()));

  If fEmptyStr(edtCodIte.Text) Then
    Exit;

  If (Not fValidaVolume()) Then
  Begin
    edtCodIte.Clear;
    Exit;
  End;

  blnSeparacaoErrada := False;
  blnInformouNumSer := False;
  blnIncluirNumSer := True;

  strCodBarComplementar := '';
  strCmpBusComplementar := '';
  strCodIteFor := '';
  strNumLot    := '';
  blnValidouLotePeloCodigoBarrasDoLote := False;

  If (fUsaMontagemCaixas) And (Not fTemCaixaAberta()) And (chkCaixaRapida.Checked) Then
  Begin
    If (Not fAbrirCaixa()) Then
    Begin
      pMensagemOk('Não foi possível abrir uma caixa rápida.');
      edtCodIte.Clear;
      Exit;
    End;
  End
  Else If (fUsaMontagemCaixas()) And (Not chkCaixaRapida.Checked) And (SameText(edtCodIte.Text,  fRetCodigoAbrirFecharCaixa())) Then
  Begin
    If (fTemCaixaAberta()) Then
    Begin
      fFecharCaixa()
    End
    Else
      fAbrirCaixa();

    edtCodIte.Clear;
    Exit;
  End;

  If (fUsaMontagemCaixas) And (Not Assigned(objMontarCaixas.CaixaAberta)) And (fCfgSis('OACEXP', varBoolean)) Then
  Begin
    pMensagemOk('Para iniciar a conferência de um produto, é necessário estar com uma caixa aberta.');
    edtCodIte.Clear;
    Exit;
  End;

  if (FParams.VS_strTipExpInterna = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) and (fCfgSis('NUMSER', varString) = 'S') and (fTemControleNumeroSerie(Trim(edtCodIte.Text), lstrCodIte)) and (not blnExpAut) then
  begin
    edtQtdChapas.Text := '0';

    If fCfgSis('NSERQT', varBoolean) Then
    Begin
      If fEmptyStr(edtQtdIte.Text) Then
        edtQtdIte.Text := '1';

      strCodIte := lstrCodIte;
      strCamBus := 'CODITE';

      If cdsItens.FindFirst Then
      Begin
        Repeat
          objFatSerieItem.AutoincItem := cdsItens.FieldByName('AUTOINCREM').AsString;
          objFatSerieItem.pFiltraDataSet;

          If Not SameValue(fFormataFloat(objFatSerieItem.fGetTotQuant, intDecQtd),
                           fFormataFloat(cdsItens.FieldByName('QTDTOT').AsFloat, intDecQtd)) Then
          Begin
            If Not fAbreFormSeries(Int(fStrToFloat(edtQtdIte.Text)), True) Then
            Begin
              edtCodIte.Clear;
              Exit;
            End;
          End;

          If fRetQtdPendenteItemPosicionado > 0 Then
            Break;

        Until Not cdsItens.FindNext;
      End;

    End
    Else
    Begin
      edtQtdIte.Text := '1';
      strNumSer := InputBox('Número de série','Informe o número de série:','');

      if fEmptyStr(strNumSer) then
      begin
        pMensagemOk('Número de série não foi preenchido!');
        edtCodIte.Clear;
        Exit;
      end;

      if Pos(',' + strNumSer, strTodosNumSer) > 0 then
      begin
        pMensagemOk('Número de série já foi utilizado!');
        edtCodIte.Clear;
        Exit;
      end;

      if not fExisteNumeroSerie(strNumSer, lstrCodIte) then
      begin
        pMensagemOk('Número de série não foi localizado para o item: ' + lstrCodIte + ' ou já foi utilizado!');
        edtCodIte.Clear;
        Exit;
      end
      else
      begin
        blnInformouNumSer := True;
      end;
    End;
  end;

  if (not blnExpAut) and
     (fCfgSis('ITEBAR', varString) = 'S') and
     (MatchStr(fCfgSis('TIPEXP'), [TIPEXP_POR_DOCUMENTO_DE_VENDA,
                                   TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO,
                                   TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO])) then
  begin
    strCamBus := 'CODITE';

    edtCodIte.Text := fBuscaItemITEBAR(edtCodIte.Text, intQuantITEBAR);

    if fEmptyStr(edtCodIte.Text) then
    begin
      pMensagemSonora('Item não encontrado na tabela ITEBAR! Favor verificar.');
      edtCodIte.Clear;
      Exit;
    end
    else
    if intQuantITEBAR > 1 then
    begin
      pMensagemSonora('O código de barras retornou mais de um item! Favor verificar.');
      edtCodIte.Clear;
      Exit;
    end;
  end
  else
  If ((Length(edtCodIte.Text) > fTamCodIte) Or (FParams.blnAutSer)) And (Not fBarrasBalanca(edtCodIte.Text, strBarBal)) Then
  Begin
    strCamBus := 'BAREMB';

    If Assigned(objEtiqueta) And (Length(edtCodIte.Text) > 20) Then
    begin
      If objEtiqueta.blnEtiquetaIdentificada Then
      begin
        objEtiqueta.pLeEtiqueta(edtCodIte.Text);
        If (Not fEmptyStr(objEtiqueta.Campo['CODBAR'].Valor)) then
          edtCodIte.Text := objEtiqueta.Campo['CODBAR'].Valor;
      End;
    End;
  End
  Else
  Begin
    strCamBus := 'CODITE';

    If fBarrasBalanca(edtCodIte.Text, strBarBal) Then
    Begin
      intQtdBal := StrToIntDef(Copy(edtCodIte.Text, 8, 5),0);
      edtQtdIte.Text := FormatFloat(edtQtdIte.EditFormat, intQtdBal);
      edtCodIte.Text := Copy(edtCodIte.Text, 3, 5);

      If fCfgSis('DVQBAL') = 'S' Then
      Begin
        fltQtdBal := intQtdBal / 1000;
        edtQtdIte.Text := FormatFloat(edtQtdIte.EditFormat, fltQtdBal);
      End;
    End
    Else
      edtCodIte.Text := fStrZero(edtCodIte.Text, fTamCodIte);

    blnBarExp := (fCampoTabela('ITE_BAREXP', 'CADITE', ['ITE_CODITE'], [edtCodIte.Text]) = 'S') and fCfgSis('BAREXP', varBoolean);

    If blnValidaBarExp And blnBarExp And (Not blnExpAut) Then
    Begin
      If Not fPermiteCodigoProdutoExpedicaoItensMedianteSenha(edtCodIte.Text, objLiberacao) Then
      Begin
        pMensagemSonora('Para expedir o produto '+ edtCodIte.Text +' é necessário informar o código de barras. Esta informação é obrigatória para este item. '+
                        'Verifique o cadastro de produtos - Aba "Dados de Saída" - Campo "Obrig. Cód. Barras Expedição"');
        edtCodIte.Clear;
        Exit;
      End;
    End;
  End;

  if fVerificaOSItemReserv then
    Exit;

  If MatchStr(FParams.VS_strTipExpInterna, [TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO, TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO]) And
     (fValidarLotePeloCodigoBarrasDoLote(strCodIteRet, strNumLotRet, edtCodIte.Text)) Then
  Begin
    edtCodIte.Text := strCodIteRet;
    strNumLot := strNumLotRet;
    strCamBus := 'CODITE';
    blnValidouLotePeloCodigoBarrasDoLote := True;
  End;

  strMensagem := '';
  strUltAutIncExp := '';

  strCodIte := edtCodIte.Text;
  strCodDig := edtCodIte.Text;

  strIndexFieldNames := cdsItens.IndexFieldNames;
  If (Not FParams.blnOndaSeparacao) And (Not blnExpAut) Then
    cdsItens.IndexFieldNames := 'AUTOINCREM';

  cdsItens.DisableControls;
  Try
    pIdentificaPreparaExpedicaoTintometrica;

    blnCamBusRetira := False;
    If blnTemItensRetira And (Not FParams.blnOndaSeparacao) And (Not blnMarcandoTodos) Then
      blnCamBusRetira := fItemTemRetira(strCodIte, StrToFloatDef(edtQtdIte.Text,1));
    blnAchou := fEncontraItem(strMensagem);

    if (not blnAchou) and (blnCamBusRetira) then
    begin
      blnCamBusRetira := False;
      blnAchou := fEncontraItem(strMensagem);
    end;

    If (Not blnAchou) And fCfgSis('ETIDIF', varBoolean) And (strCamBus = 'BAREMB') Then
    Begin
      If objIteBar.fLerCodigoBarrasUnidades(edtCodIte.Text, strCodIteUni, strCodGruUni, fltQtdIteUni) Then
      Begin
        strCamBus := 'CODITE';
        strCodIte := strCodIteUni;
        edtCodIte.Text := strCodIteUni;
        edtQtdIte.Text := FloatToStrF(fltQtdIteUni, ffFixed, 12, intDecQtd);
        blnAchou := fEncontraItem(strMensagem);
      End;
    End;

    If (Not blnAchou) And (Length(edtCodIte.Text) > fTamCodIte) Then
    Begin
      blnAchou := fEncontraItem(strMensagem);

      If (Not blnAchou) And fProcuraSemelhante(edtCodIte.Text, strCodSem) Then
      Begin
        strCamBus := 'CODITE';
        edtCodIte.Text := strCodSem;
        strCodIte      := strCodSem;
        blnAchou := fEncontraItem(strMensagem);
      End;

      If (Not blnAchou) And pnlQtdVariasChapasLote.Visible Then
      Begin
        strCamBus := 'CODITE';
        strCodIte := Copy(edtCodIte.Text, 1, fTamCodIte);
        strNumLot := Copy(edtCodIte.Text, 1 + fTamCodIte, Length(edtCodIte.Text) - fTamCodIte - 3);
        edtCodIte.Text := strCodIte;
        blnAchou := fEncontraItem(strMensagem);
      End;
    End;

    If (Not blnAchou) And fCfgSis('CLIPRO', varBoolean) And (Assigned(FParams.stlPedidos)) And fCfgSis('APRBAR', varBoolean) Then
    Begin
      If (FParams.stlPedidos.Count > 0) Then
      Begin
        strCodCliPro := fRetCodBarraCliPro;
        If Not fEmptyStr(strCodCliPro) Then
        Begin
          strCamBus := 'CODITE';
          edtCodIte.Text := strCodCliPro;
          strCodIte      := strCodCliPro;
          blnAchou := fEncontraItem(strMensagem);
        End;
      End;
    End;

    if (blnAchou) and (blnInformouNumSer) and (blnIncluirNumSer) then
    begin
      strTodosNumSer := strTodosNumSer + ',' + strNumSer;
      strTodosCodIte := strTodosCodIte + ',' + lstrCodIte;
      strTodosPedidos := strTodosPedidos + ',' + cdsItens.FieldByName('NUMDOC').AsString;
    end;
  Finally
    cdsItens.IndexFieldNames := strIndexFieldNames;
    If (Not blnExpAut) And (cdsItens.FindField('AUTOINCREM') <> Nil) And (Not fEmptyStr(strUltAutIncExp)) Then
      cdsItens.Locate('AUTOINCREM', strUltAutIncExp, []);
    pEnableCdsItens();
  End;

  If (Not blnAchou) And (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And fCfgSis('EXPETG', varBoolean) And (cdsItens.FieldByName('ENTSAI').AsString = 'S') Then
  Begin
    If (Length(edtCodIte.Text) > fTamCodIte) Then
      blnSeparacaoErrada := (fCampoTabela('COUNT(0)', 'CADITE', ['ITE_CODBAR'], [edtCodIte.Text]) > 0)
    Else
      blnSeparacaoErrada := (fCampoTabela('COUNT(0)', 'CADITE', ['ITE_CODITE'], [edtCodIte.Text]) > 0);

    If blnSeparacaoErrada Then
      strMensagem := fTitBusMsg + ' (' + edtCodIte.Text + iif(fEmptyStr(strCodIteFor),'',' - '+strCodIteFor) + ') não encontrado!'+#13+
                     'Será impressa a etiqueta para guarda-lo.'
    Else
      strMensagem := fTitBusMsg + ' (' + edtCodIte.Text + iif(fEmptyStr(strCodIteFor),'',' - '+strCodIteFor) + ') não existe!';
  End
  Else If (Not blnAchou) Then
  Begin
    strMensagem := fTitBusMsg + ' (' + edtCodIte.Text
           + iif(fEmptyStr(strCodIteFor),'',' - '+strCodIteFor) + ') não encontrado!';
  End;

  pTocarAlertaSonoro(blnAchou);

  If (Not fEmptyStr(strMensagem)) Then
  Begin
    If fCfgSis('TPMSEX', varBoolean) Then
      pMensagemSonora(strMensagem)
    Else
      pMensagemOk(strMensagem);

    If (Not blnAchou) Then
      edtCodIte.Text := '';
  End;

  If (Not blnAchou) And (Not blnSeparacaoErrada) Then
  Begin
    If fSenhaParaProsseguirExpedicaoQuandoItemNaoEncontrado(strMensagem) Then
    Begin
      edtCodIte.Clear;
      Exit;
    End;
  End;

  If blnSeparacaoErrada Then
  Begin
    If fImpEtiquetaSepErrada(edtCodIte.Text, fRetNomVendRep(cdsItens.FieldByName('SEPEXP').AsString)) Then
      pGeraLogSepErrada(cdsItens.FieldByName('NUMDOC').AsString,
                        cdsItens.FieldByName('ESPDOC').AsString,
                        cdsItens.FieldByName('CODEMP').AsString,
                        strLoginUsuarioLogado,
                        cdsItens.FieldByName('SEPEXP').AsString,
                        Date,
                        fTime(),
                        edtCodIte.Text,
                        fFormataFloat(fStrToFloat(edtQtdIte.Text), 2),
                        cdsItens.FieldByName('QTDITE').AsFloat);
  End;

  If (blnAchou) Then
    pAtualizaInformacaoDoTotalExpedido;

  If blnAchou And fCfgSis('BOXWMS', varBoolean) Then
  Begin
    If Not blnItemConferido Then
    Begin
      blnItemConferido := True;
      pBaixaBoxWMS;
    End;
  End;

  edtCodIte.Clear;
  lblCodBar.Caption:=CAP_CODBAR_EMB;
  pOrdenarItensConfigurado;

  If (fUsaMontagemCaixas) And (fTemCaixaAberta()) And (chkCaixaRapida.Checked) Then
  Begin
    If (Not fFecharCaixa) Then
      pMensagemOk('Não foi possível fechar uma caixa rápida.');
  End;

  If (fUsaMontagemCaixas) And
     (fTemCaixaAberta()) And
     (fTodosItensForamExpedidos) And
     (fCfgSis('FCXUIE', varBoolean)) Then
  Begin
    If (Not fFecharCaixa) Then
      pMensagemOk('Não foi possível fechar a caixa após conclusão do último item expedido.');
  End;

  pSetEnabledImpSeq((Not fExpedicaoJaIniciada()));

  If (blnAchou) And (pnlResumoUnidadeItens.Visible) Then
    pCarregaResumoUnidadesItens;
end;

procedure TfrmFatExpedicaoItens.pExpedeItemOndaSep;
Var
  fltQtdRes: Double;
  fltQtdPen: Double;
  fltTotAnt: Double;
  fltEmbala: Double;
  blnAchou : Boolean;
  blnDigBar: Boolean;
  blnBarExp: Boolean;
  strCodItemLocalizado: String;
begin
  pOrdenarItens;

  If (Length(edtCodIte.Text) < fTamCodIte) Then
    edtCodIte.Text := fStrZero(edtCodIte.Text, fTamCodIte);

  blnDigBar := Length(edtCodIte.Text) > fTamCodIte;
  strCodIte := edtCodIte.Text;
  strCodDig := edtCodIte.Text;
  fltQtdRes := fStrToFloat(edtQtdIte.Text);

  strCamBus := 'CODITE';
  blnAchou  := cdsItens.FindFirst;

  blnOndaSepComCodBar := False;
  If (Not blnAchou) And (Length(edtCodIte.Text) > fTamCodIte) Then
  Begin
    strCamBus := 'CODBAR';
    blnAchou  := cdsItens.FindFirst;
    blnOndaSepComCodBar := True;
  End;

  If (Not blnAchou) And (Length(edtCodIte.Text) > fTamCodIte) Then
  Begin
    strCamBus := 'BAREMB';
    blnAchou  := cdsItens.FindFirst;
  End;

  If (Not blnAchou) Or (cdsItens.FieldByName('IDEPRO').AsString <> 'NOR') Then
  Begin
    pExpedeItem;
    Exit;
  End;

  strCodItemLocalizado := cdsItens.FieldByName('CODITE').AsString;

  blnBarExp := (fCampoTabela('ITE_BAREXP', 'CADITE', ['ITE_CODITE'], [strCodItemLocalizado]) = 'S') and fCfgSis('BAREXP', varBoolean);

  If (blnBarExp) And (Not blnDigBar) Then
  Begin
    edtCodIte.Clear;
    pMensagemSonora('Para expedir o produto '+strCodItemLocalizado+' é necessário informar o código de barras. '+
                    'Esta informação é obrigatória para este item. '+
                    'Verifique o cadastro de produtos - Aba "Dados de Saída" - Campo "Obrig. Cód. Barras Expedição"');
    Exit;
  End;

  If strCamBus = 'BAREMB' Then
    fltEmbala := objIteBar.fQuantidadeEmbalagem(strCodItemLocalizado, strCodDig)
  Else
    fltEmbala := 1;

  fltQtdRes := fltQtdRes * fltEmbala;

  edtCodIte.Text := strCodItemLocalizado;
  edtQtdIte.Text := FloatToStrF(fltQtdRes, ffFixed, 12, intDecQtd);

  If fFormataFloat(fltQtdRes, intDecQtd) <= 0 Then
  Begin
    pMensagemOk('Quantidade do produto deve ser maior que zero!');
    Exit;
  End;

  If fFormataFloat(fRetQtdPendente(strCodItemLocalizado), intDecQtd) = 0 Then
  Begin
    blnIncluirNumSer := False;
    pMensagemOk('Produto (' + strCodItemLocalizado + ') já foi totalmente expedido!');
    Exit;
  End;

  If fFormataFloat(fRetQtdPendente(strCodItemLocalizado), intDecQtd) < fFormataFloat(fltQtdRes, intDecQtd) Then
  Begin
    blnIncluirNumSer := False;
    pMensagemOk('Quantidade não permitida para o produto (' + strCodItemLocalizado + ').');
    Exit;
  End;

  While fFormataFloat(fltQtdRes, intDecQtd) > 0 Do
  Begin
    strCamBus := 'CODITE';
    strCodIte := strCodItemLocalizado;
    strCodDig := strCodItemLocalizado;
    fltTotAnt := fRetQtdPendente(strCodItemLocalizado);

    If (cdsItens.FindFirst) Then
    Begin
      Repeat
        fltQtdPen := fRetQtdPendenteItemPosicionado;

        If fFormataFloat(fltQtdPen, intDecQtd) = 0 Then
          Continue;

        If fltQtdPen <= fltQtdRes Then
          fltQtdRes := fltQtdRes - fltQtdPen
        Else
        Begin
          fltQtdPen := fltQtdRes;
          fltQtdRes := 0;
        End;

        Break;
      Until (Not cdsItens.FindNext);

      edtCodIte.Text := strCodItemLocalizado;
      edtQtdIte.Text := FloatToStrF(fltQtdPen, ffFixed, 12, intDecQtd);

      If fFormataFloat(fltQtdPen, intDecQtd) > 0 Then
        pExpedeItem(False, False);
    End;

    If fFormataFloat(fltTotAnt, intDecQtd) = fFormataFloat(fRetQtdPendente(strCodItemLocalizado), intDecQtd) Then
    Begin
      pMensagemOk('Não foi possível expedir a quantidade total informada para o produto (' + strCodItemLocalizado + ')!');
      Exit;
    End;
  End;

  If FParams.blnOndaSeparacao And fTodosItensForamExpedidos Then
  Begin
    tmrConfirmarAutomaticamente.Enabled := True;
  End;

end;

procedure TfrmFatExpedicaoItens.dbgDetMatDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  With TDBGridCitel(Sender) Do
  Begin
    if (DataSource = Nil) Or (Not DataSource.DataSet.Active) Or (DataSource.DataSet.RecordCount <= 0) Then
      Exit;

    if Odd(DataSource.DataSet.RecNo) Then
    Begin
      Canvas.Brush.Color := intCorZeb;
      Canvas.Font.Color := clBlack;
    End;

    if (Tag = THackDBGrid(Sender).DataLink.ActiveRecord + 1) then
    begin
      Canvas.Brush.Color := clSilver;
      Canvas.Font.Color := clNavy;
    end;

    Canvas.FillRect(Rect);
    DefaultDrawColumnCell(Rect, DataCol, Column, State);

  End;
end;

procedure TfrmFatExpedicaoItens.dbgDetMatMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
  Var
    objCord: TGridCoord;
begin
  inherited;
  objCord := dbgDetMat.MouseCoord(X,Y);
  dbgDetMat.Tag := objCord.Y;
  dbgDetMat.Repaint;
end;

procedure TfrmFatExpedicaoItens.dbgEtiCaixaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
  Var
    caixa: TCaixa;
begin
  inherited;
  Case Key Of
    VK_DELETE: If Not cdsItens.IsEmpty Then
               Begin
                 caixa := objMontarCaixas.fBuscaCaixa(cximgCaixas.Properties.Items[cximgCaixas.ItemIndex].Value);

                 If caixa.blnFechada Then
                   pMensagemOk('Não é permitido remover um produto de uma caixa já fechada!')

                 Else If fPergunta('Deseja realmente remover o produto ' +
                                   cdsEtiCaixa.FieldByName('codigo').AsString + ' da caixa ' + caixa.strID + '?') Then
                 Begin
                   caixa.pRemoverItem(cdsEtiCaixa.FieldByName('id').AsString);

                   //Apos remover o produto selecionado da caixa também remove a quantidade expedida do mesmo
                   If cdsItens.Locate('AUTOINCREM', cdsEtiCaixa.FieldByName('id').AsString, []) Then
                   Begin
                     cdsItens.Edit;
                     cdsItens.FieldByName('QTDEXP').AsFloat := cdsItens.FieldByName('QTDEXP').AsFloat -
                                                               cdsEtiCaixa.FieldByName('quantidade').AsFloat;
                     cdsItens.Post;
                   End;

                   pMensagemOk('Produto removido com sucesso!');
                   pPrencheGridItensCaixa;
                 End;
               End;
  End;
end;

procedure TfrmFatExpedicaoItens.dbgEtiCaixaMouseEnter(Sender: TObject);
begin
  inherited;
  pnlInfCaixa.Caption := 'Pressione [Delete] sobre um produto na caixa para remover o mesmo, permitido somente para caixas em aberto.';
end;

procedure TfrmFatExpedicaoItens.dbgEtiCaixaMouseLeave(Sender: TObject);
begin
  inherited;
  pnlInfCaixa.Caption := '';
end;

function TfrmFatExpedicaoItens.fQtdIteDisponivelParaExpedicao: Double;
begin
  If FParams.blnUsaImpressaoSeparacaoPorLocal or fPermiteImprimirSeparacaoParcial Then
    Result := cdsItens.FieldByName('QTDDIS').AsFloat
  Else
    Result := cdsItens.FieldByName('QTDITE').AsFloat;
end;

procedure TfrmFatExpedicaoItens.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
  Var
    bmpCaixa: TBitmap;
    strItemID: String;
begin
  inherited;

  If (Not cdsItens.Active) Or (cdsItens.IsEmpty) Then
    Exit;

  If fSelecionado Then
  Begin
    If dbgItens.Canvas.Brush.Color = clHighlight Then
      dbgItens.Canvas.Font.Color := clLime
    Else
      dbgItens.Canvas.Brush.Color := clAqua;
  End;

  If (fFormataFloat(fQtdIteDisponivelParaExpedicao, intDecQtd) = fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat, intDecQtd)) Then
  Begin
    If dbgItens.Canvas.Brush.Color = clHighlight Then
      dbgItens.Canvas.Font.Color := clWhite;

    dbgItens.Canvas.Brush.Color := $0096CFA7;
  End
  Else
  Begin
    If (fFormataFloat(fQtdIteDisponivelParaExpedicao, intDecQtd) > fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat, intDecQtd)) And
       (fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat, intDecQtd) <> 0) Then
    Begin

      If (IsThemeActive) Or (dbgItens.Canvas.Brush.Color = clHighlight) Then
        dbgItens.Canvas.Font.Color := clBlack;

      dbgItens.Canvas.Brush.Color := $00CCFFFF;
    end;
  End;

  If (cdsItens.FindField('SALEST') <> Nil) And shpSemSal.Visible Then
  Begin
    If cdsItens.FindField('SALEST').AsFloat <= 0 Then
      dbgItens.Canvas.Font.Color := shpSemSal.Brush.Color;
  End;

  dbgItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  If (Column.FieldName = 'MONCAI') And fUsaMontagemCaixas Then
  Begin
    strItemID := cdsItens.FieldByName('AUTOINCREM').AsString;

    With objMontarCaixas, dbgItens.Canvas, Rect Do
    Begin
      Brush.Color := clWhite;
      FillRect(Rect);
      bmpCaixa := TBitmap.Create;
      Try
        If Assigned(CaixaAberta) And (CaixaAberta.fFindItemByID(strItemID) > -1) Then
        Begin
          If imglsCaixas.GetBitmap(1, bmpCaixa) Then
            Draw(Left + (Column.Width div 2 - bmpCaixa.Width div 2), Top + 1, bmpCaixa);
        End
        Else If fBuscaItemNasCaixas(strItemID) Then
        Begin
          If imglsCaixas.GetBitmap(0, bmpCaixa) Then
            Draw(Left + (Column.Width div 2 - bmpCaixa.Width div 2), Top + 1, bmpCaixa);
        End;
      Finally
        FreeAndNil(bmpCaixa);
      End;
    End;
  End;

end;

procedure TfrmFatExpedicaoItens.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If blnImprimindoEtiquetaCaixa Then
  Begin
    Key := 0;
    Exit;
  End;

  If (Shift = [ssCtrl]) And (Key = VK_F4) And btnEtqSepFaltante.Visible Then
    pImprimirSeparacaoErrada(cdsItens)
  Else If (Shift = [ssCtrl]) And (Key = VK_F6) And btnCfgExpItens.Visible Then
    btnCfgExpItens.Click
  Else If (Shift = [ssCtrl]) And (Key = VK_F8) Then
    btnDigCodBarLocFis.Click
  Else If (Shift = [ssAlt]) And (Key = VK_F6) Then
    btnEditarMensagem.Click
  Else If (Shift = [ssCtrl]) And (Key = VK_F5) And btnImpEtiCaixa.Visible Then
    btnImpEtiCaixa.Click
  Else
    Case Key Of
      VK_F1 : btnMostrarCortados.Click;
      VK_F2 : If btnReabreCaixa.Enabled Then btnReabreCaixa.Click;
      VK_F3 : Begin
                If Shift = [ssCtrl] Then
                  btnNumSeries.Click
                Else
                  btnPesarCaixa.Click;
              End;
      VK_F4 : btnEtiqueta.Click;
      VK_F5 : pLiberarExpedidos;
      VK_F6 : If (VS_strTipDEx = '1')  Then btnQuantidade.Click;
      VK_F7 : btnExpAut.Click;
      VK_F8 : If (btnMontarCaixas.Enabled) Then btnMontarCaixas.Click;
      VK_F9 : btnMarcarTudo.Click;
      VK_F10: Begin
                Key := 0;
                If btnConfirma.Enabled Then
                  btnConfirma.Click;
              End;
      VK_F11: If btnLimpaExp.Visible Then btnLimpaExp.Click;
      VK_F12: Begin

                If Shift = [ssCtrl] Then
                Begin
                  btnItensNaoExpedidos.Click;
                End
                Else
                Begin
                  If btnSelMan.Visible Then btnSelMan.Click;
                End;

              End;
      VK_ESCAPE : Begin
                    If fSair Then
                      btnSair.Click
                    Else
                      Key := 0;
                  End;
      Else
        inherited;
    End;
end;

procedure TfrmFatExpedicaoItens.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If blnImprimindoEtiquetaCaixa Then
  Begin
    Key := #0;
    Exit;
  End;

  inherited;

  If ((ActiveControl) <> edtCodIte)    And
     ((ActiveControl) <> cximgCaixas)  And
     ((ActiveControl) <> staQtdItens)  And
     ((ActiveControl) <> edtQtdIte)    And
     ((ActiveControl) <> edtPesBru)    And
     ((ActiveControl) <> edtQtdChapas) And
     ((ActiveControl) <> edtVolume)    And
      CharInSet(Key, ['0'..'9'])       And
     (VS_strTipDEx = '1')              Then
  Begin
    edtCodIte.Text := edtCodIte.Text + Key;
    pSetFocus(edtCodIte);
    edtCodIte.SelStart := Length(edtCodIte.Text);
  End;
end;

procedure TfrmFatExpedicaoItens.btnQuantidadeClick(Sender: TObject);
var
  blnAcesso: boolean;
begin
  inherited;

  If (Not btnQuantidade.Enabled) Then
    Exit;

  if pnlQtdVariasChapasLote.Visible then
    edtQtdChapas.Enabled := True;

  blnAcesso := fVerificaAcessoSistema('QTDEXP');

  if not blnAcesso then
    blnAcesso := fValidaDireitoAcesso;

  If blnAcesso Then
  Begin
    edtQtdIte.Enabled := True;
    pSetFocus(edtQtdIte);
  End;

end;

procedure TfrmFatExpedicaoItens.btnReabreCaixaClick(Sender: TObject);
  Var
    intIndex : Integer;
begin
  inherited;
  If blnImprimindoEtiquetaCaixa Then
    Exit;

  If (cximgCaixas.ItemIndex <> -1) and (cximgCaixas.ItemIndex < cximgCaixas.Properties.Items.Count) Then
  begin
    intIndex               := cximgCaixas.ItemIndex;
    objMontarCaixas.fBuscaCaixa(cximgCaixas.Properties.Items[cximgCaixas.ItemIndex].Value).pAbreCaixa;
    pPreencheListaCaixas;
    cximgCaixas.ItemIndex  := intIndex;
    pSetaBotaoMontarCaixas(CAP_FECHAR_CAIXA);
    btnReabreCaixa.Enabled := False;
    pMudaStatusCaixa;
  end;
end;

procedure TfrmFatExpedicaoItens.btnSelManClick(Sender: TObject);
  Var
    cdsClone : TUniClientDataSet;
begin
  inherited;
  cdsClone := TUniClientDataSet.Create(Self);
  pCriarFormularios(TfrmFatExpSelManual, frmFatExpSelManual);
  Try
    pCloneDataSet(cdsClone, cdsItens);

    frmFatExpSelManual.procMarcTodos := pMarcarTodosProdutos;
    frmFatExpSelManual.cdsItens := cdsItens;
    frmFatExpSelManual.cdsClone := cdsClone;
    frmFatExpSelManual.ShowModal;

    If (Not frmFatExpSelManual.blnConfirma) And
       (frmFatExpSelManual.blnHouveModificacao) Then
    Begin
      cdsItens.DisableControls;
      Try
        cdsItens.EmptyDataSet;
        cdsClone.First;
        While Not cdsClone.Eof Do
        Begin
          pCopiaRegistroDataSet(cdsClone, cdsItens);
          cdsClone.Next;
        End;
      Finally
        pEnableCdsItens();
      End;
    End;

  Finally
    FreeAndNil(cdsClone);
    pFreeAndNil(frmFatExpSelManual);
  End;
end;

procedure TfrmFatExpedicaoItens.pEnableCdsItens();
begin
  cdsItens.EnableControls;
  cdsItens.AfterScroll(cdsItens);
end;

procedure TfrmFatExpedicaoItens.cdsItensAfterScroll(DataSet: TDataSet);
begin
  inherited;

  If DataSet.ControlsDisabled Then
    Exit;

  If blnIgnorarScroll Then
    Exit;

  If pnlFoto.Visible Then
  Begin
    Case fCarregaImagemProduto(cdsItens.FieldByName('CODITE').AsString, imgFotoProd.Picture) of
      riOk   :
      Begin
        imgFotoProd.Visible := True;
        lblErrImg.Visible := False;
      End;
      riErro :
      Begin
        imgFotoProd.Visible := False;
        lblErrImg.Visible := True;
      End;
      riNulo :
      Begin
        imgFotoProd.Visible := False;
        lblErrImg.Visible := False;
      End;
    End;
  End;

  pCarregarDadosItemEstrutura;

  If fLimparExpedido And fUsaMontagemCaixas Then
    lblLimparExpedido.Visible := (Not objMontarCaixas.fBuscaItemNasCaixas(cdsItens.FieldByName('AUTOINCREM').AsString) );

  If btnNumSeries.Visible Then
    btnNumSeries.Enabled := fHabilitarManutencaoDeSerie;

end;

function TfrmFatExpedicaoItens.fHabilitarManutencaoDeSerie: Boolean;
begin
  Result := False;

  If Not cdsItens.Active Then
    Exit;

  If cdsItens.IsEmpty Then
    Exit;

  If (Not Assigned(cdsItens.FindField('USASER'))) Then
    Exit;

  If (Not Assigned(cdsItens.FindField('QTDTOT'))) Then
    Exit;

  If (Not Assigned(cdsItens.FindField('QTDEXP'))) Then
    Exit;

  If (cdsItens.FieldByName('USASER').AsString <> 'S') Then
    Exit;

  Result := (fFormataFloat(cdsItens.FieldByName('QTDTOT').AsFloat, intDecQtd) = fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat, intDecQtd));
end;

procedure TfrmFatExpedicaoItens.chkCaixaRapidaClick(Sender: TObject);
begin
  inherited;

  btnMontarCaixas.Enabled := (Not chkCaixaRapida.Checked);
end;

procedure TfrmFatExpedicaoItens.chkImpSeqClick(Sender: TObject);
begin
  inherited;

  lblVolume.Enabled := chkImpSeq.Checked;
  edtVolume.Enabled := chkImpSeq.Checked;

  If chkImpSeq.Checked Then
    chkTodasAsCaixas.Checked := False
  Else
    chkTodasAsCaixas.Checked := fConsiderarTodasAsCaixas();

  chkTodasAsCaixas.Enabled := (Not chkImpSeq.Checked);
end;

procedure TfrmFatExpedicaoItens.cdsDetMatAfterScroll(DataSet: TDataSet);
Begin
  Case fCarregaImagemProduto(cdsDetMat.FieldByName('ITESUB').AsString, imgFotoEstru.Picture) of
    riOk   :
    Begin
      imgFotoEstru.Visible := True;
      lblErrImg.Visible := False;
    End;
    riErro :
    Begin
      imgFotoEstru.Visible := False;
      lblErrImg.Visible := True;
    End;
    riNulo :
    Begin
      imgFotoEstru.Visible := False;
      lblErrImg.Visible := False;
    End;
  End;
End;

procedure TfrmFatExpedicaoItens.pAmpliaFoto(strCodIte : String);
Begin
  TfrmImagens.pAbrirImagens(tiProduto, strCodIte, True);
End;

procedure TfrmFatExpedicaoItens.cdsEtiCaixaAfterPost(DataSet: TDataSet);
begin
  inherited;
  If (fCfgSis('COMBAL', varString) = 'G') Then
    edtPesBru.Text := FormatFloat('#,##0.00', fDoubleAggregate( cdsEtiCaixa, 'pestot') );
end;

procedure TfrmFatExpedicaoItens.cximgCaixasClick(Sender: TObject);
begin
  inherited;
  pPrencheGridItensCaixa;
  pSelecionaListaDimensaoCaixa;
end;

class procedure TfrmFatExpedicaoItens.pSqlFrom(stlItens: TStrings;
                                               blnReimpressaoVolumes,
                                               blnExiPedRetiraExpAntFat,
                                               blnApenasFaturarJaExpedidos,
                                               blnApenasConferenciaProdutosRetiraCaixa: Boolean;
                                               strOrdExi  : String;
                                               stlPedidos : TStringList;
                                               blnUsaImpressaoSeparacaoPorLocal: Boolean;
                                               blnPedidoContemItemPrioridade: Boolean = False;
                                               blnFiltroEntregaERetira: Boolean = False);
  Var
    intContador: Integer;
    objPedido: TPedidoVenda;
Begin
  With stlItens Do
  Begin
    Add('FROM                                                                                   ');
    Add('  FATDOR                                                                               ');
    Add('  INNER JOIN CADITE I  ON I.ITE_CODITE = FDO_CODITE                                    ');

    If blnPedidoContemItemPrioridade Then
      Add('  INNER JOIN ITEGER G  ON I.ITE_CODITE = G.ITE_CODITE AND G.ITE_CODEMP = FDO_EMPITE  ')
    Else
      Add('  INNER JOIN ITEGER G  ON I.ITE_CODITE = G.ITE_CODITE AND G.ITE_CODEMP = :EMPITE     ');

    Add('  INNER JOIN CADUNI    ON   UNI_CODUNI = I.ITE_CODUNI                                  ');
    Add('  LEFT  JOIN CADACA    ON   ACA_CODACA = FDO_CODACA AND ACA_CODEMP = FDO_EMPACA        ');
    Add('  INNER JOIN CADGRU GR ON GR.GRU_CODGRU = I.ITE_CODGRU                                 ');
    Add('  LEFT  JOIN FORTIN ON FATDOR.FDO_CODACA = FORTIN.FOR_CODACA AND                       ');
    Add('                       FORTIN.FOR_EMPACA = FATDOR.FDO_EMPACA                           ');
    Add('  INNER JOIN FATGOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER                           ');
    Add('  LEFT  JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO                           ');
    Add('  LEFT  JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO                           ');
    Add('  LEFT  JOIN ITEGER GL ON GL.ITE_CODITE = FDO_CODITE AND                               ');
    Add('                          GL.ITE_CODEMP = IF(FGO_EMP_TE <> "",FGO_EMP_TE,FDO_CODEMP)   ');
    Add('  LEFT  JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI                                         ');
    Add('  LEFT  JOIN CADTRA ON TRA_CODTRA = FGO_CODTRA                                         ');
    Add('  LEFT  JOIN CADAMZ ON (CADAMZ.AMZ_CODAMZ = FATDOR.FDO_NUMLOT AND CADAMZ.AMZ_CODEMP = FATDOR.FDO_CODEMP) ');

    If fCfgSis('MAREXP', VarBoolean) Then
      Add('  LEFT JOIN CADMAR ON (MAR_CODMAR = ITE_CODMAR) ');

    Add('  LEFT JOIN CADLOT ON  FDO_CODITE = LOT_CODITE AND ');
    Add('                       FDO_CODEMP = LOT_CODEMP AND ');
    Add('                       FDO_NUMLOT = LOT_NUMLOT     ');

    If strOrdExi = '5' Then
      Add('  LEFT JOIN CADDEP ON DEP_CODIGO = I.ITE_CODDEP');

    Add('  LEFT JOIN ENTREG ER ON ER.ENT_CODIGO = EXTGOR.FGO_CODROT ');
    if fCfgSis('ROTEMP', varBoolean) then
    begin
      Add(' AND ER.ENT_CODEMP = FATGOR.FGO_CODEMP ');
    end;

    Add('LEFT JOIN CADREG ON CADREG.REG_CODREG = ER.ENT_CODREG ');

    If fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica Then
    Begin
      Add('LEFT JOIN CADLOC ON LOC_CODLOC = G.ITE_LOCFIS AND LOC_CODEMP = G.ITE_CODEMP ');
      Add('LEFT JOIN CADLSE ON LSE_CODIGO = LOC_CODLSE ');
    End
    Else
      Add('LEFT JOIN CADLSE ON LSE_CODIGO = G.ITE_CODLSE ');

    Add('LEFT JOIN AUXGOR AG ON FATGOR.AUTOINCREM = AG.AUX_SEQGER    ');
    Add('LEFT JOIN ENTCLI EC ON EC.ETC_CODCLI = FATGOR.FGO_CODCLI    ');
    Add('                   AND IF(IFNULL(AG.AUX_ENTGER, "") <> "",                       ');
    Add('                          EC.AUTOINCREM = AG.AUX_ENTGER,                         ');
    Add('                          EC.ETC_SEQIND =(SELECT                                 ');
    Add('                                           MIN(ETC_SEQIND)                       ');
    Add('                                          FROM                                   ');
    Add('                                           ENTCLI                                ');
    Add('                                          WHERE ETC_CODCLI = FATGOR.FGO_CODCLI)) ');
    Add('LEFT JOIN CADCID CC ON CC.CID_CODCID = FATGOR.FGO_CIDCON    ');
    Add('LEFT JOIN CADCID CE ON CE.CID_CODCID = EC.ETC_CIDENT        ');
    Add('LEFT JOIN CADCID CF ON CF.CID_CODCID = CADCLI.CLI_CODCID    ');

    Add('WHERE TRUE ');

    Add(fFiltroProdutosExpedicaoItens(blnReimpressaoVolumes,
                                      blnUsaImpressaoSeparacaoPorLocal,
                                      blnExiPedRetiraExpAntFat,
                                      blnApenasFaturarJaExpedidos,
                                      blnApenasConferenciaProdutosRetiraCaixa,
                                      'FDO_QTDBAI',
                                      '0',
                                      blnFiltroEntregaERetira));

    If Assigned(stlPedidos) And (stlPedidos.Count > 0) Then
    Begin
      Add(' AND ');
      Add('  (                                                                                    ');
      For intContador := 0 To stlPedidos.Count -1 Do
      Begin
        objPedido  := TPedidoVenda(stlPedidos.Objects[intContador]);

        Add(' (FDO_NUMDOC = ' + QuotedStr(objPedido.strNumDoc) + ' AND ');
        Add('  FDO_SEQGER = ' + QuotedStr(objPedido.strSeqGer) + ' AND ');
        Add('  FDO_ESPDOC = ' + QuotedStr(objPedido.strEspDoc) + ' AND ');
        Add('  FDO_CODEMP = ' + QuotedStr(objPedido.strCodEmp) + ' AND ');
        Add('  FDO_CODCLI = ' + QuotedStr(objPedido.strCodCli) + ') ');

        If intContador < stlPedidos.Count -1 Then
          Add(' OR ');
      End;
      Add('  )                                                          ');
    End;
  End;
End;

procedure TfrmFatExpedicaoItens.tmrCloseTimer(Sender: TObject);
begin
  inherited;
  tmrClose.Enabled := False;
  Self.Close;
end;

procedure TfrmFatExpedicaoItens.tmrConfirmarAutomaticamenteTimer(
  Sender: TObject);
begin
  inherited;
  tmrConfirmarAutomaticamente.Enabled := False;
  btnConfirma.Click;
end;

procedure TfrmFatExpedicaoItens.tmrLePesoTimer(Sender: TObject);
  Var
    caixa: TCaixa;
begin
  inherited;
  If fCfgSis('COMBAL', varString) <> 'S' Then
    Exit;

  If cximgCaixas.ItemIndex <> -1 Then
  Begin
    caixa := objMontarCaixas.fBuscaCaixa(cximgCaixas.Properties.Items[cximgCaixas.ItemIndex].Value);

    If caixa.blnFechada Then
      edtPesBru.Text := FormatFloat('#,##0.00', caixa.fltPesoTotal)
    Else
      edtPesBru.Text := FormatFloat('#,##0.00', objMontarCaixas.fPesarCaixa(caixa, False));
  End;
end;

function TfrmFatExpedicaoItens.fSQLQuantidadeEntregaFutura: String;
  Var
    blnConsiderarCfgCalSal: Boolean;
begin
  blnConsiderarCfgCalSal := True; //DEFAULT DA fUsaQtdPendenteEntregaFutura
  If (Self.FParams.blnBaiEntFut) Then
    blnConsiderarCfgCalSal := False; //MESMA REGRA DA TELA DE BAIXA DE ENTREGA FUTURA

  If fUsaQtdPendenteEntregaFutura(blnConsiderarCfgCalSal) Then
    Result := ' ( ' + fGetSQLSomaCamposEntregaFutura('G', True) + ' ) '
  Else
    Result := ' 0.00 ';
end;

procedure TfrmFatExpedicaoItens.pCarregaItensPedido(blnReimpressaoVolumes : Boolean = False);
  Const
    STR_DESMAR = ', IF(IFNULL(MAR_DESMAR, "") <> "", CONCAT(" - ", IFNULL(MAR_DESMAR, "")), "") ';
    STR_COMPLE = ', IF(IFNULL(FDO_COMPLE, "") <> "", CONCAT(" - ", IFNULL(FDO_COMPLE, "")), "") ';

  function STR_LOCFIS : String;
  begin
    Result := ', IF(IFNULL(FDO_NUMLOT,"")<>"", CONCAT(" - ' + fDescricaoResumidaLocFis + ' ", IFNULL(FDO_NUMLOT,"")), "") ';
  end;

begin

  With qryItens Do
  Begin

    Close;
    SQL.Clear;

    SQL.Add('SELECT                                                                                 ');
    SQL.Add('  FATDOR.*,                                                                            ');
    SQL.Add('  FDO_ORDITE AS ORDITE,                                                                ');
    SQL.Add('  FDO_PEGOU_ AS PEGOU_,                                                                ');
    SQL.Add('  CONCAT(FDO_CODITE, "-", FDO_DESCRI' + IIF(fCfgSis('FATCOM', VarBoolean), STR_COMPLE, '') +
                                                     IIF(fCfgSis('CADLOC', VarBoolean), STR_LOCFIS, '') +
                                                     IIF(fCfgSis('MAREXP', VarBoolean), STR_DESMAR, '') + ') AS DESITE, ');
    SQL.Add('  CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC, "-", FGO_CODEMP) AS DOCUME,                      ');
    SQL.Add('  FGO_PREVIS AS PREVIS,                                                                ');
    SQL.Add('  FDO_DESCRI AS DESCRI,                                                                ');
    SQL.Add('  FDO_CODITE AS CODITE,                                                                ');
    If (blnExiApl) And (fCampoExiste('CADITE', 'ITE_APLICA', True)) Then
      SQL.Add(' I.ITE_APLICA AS APLICA, ')
    Else
      SQL.Add(' CAST("" AS CHAR(255)) AS APLICA, ');
    SQL.Add('  IF(FDO_CODACA =  "" OR FDO_CODACA IS NULL, " ", FDO_CODACA) AS CODACA,               ');
    SQL.Add('  IF(FDO_EMPACA =  "" OR FDO_EMPACA IS NULL, " ", FDO_EMPACA) AS EMPACA,               ');
    SQL.Add('  IF(FDO_EMPPRD =  "" OR FDO_EMPPRD IS NULL, " ", FDO_EMPPRD) AS EMPPRD,               ');
    SQL.Add('  IF(FDO_IDEPRO =  "" OR FDO_IDEPRO IS NULL, " ", FDO_IDEPRO) AS IDEPRO,               ');
    SQL.Add('  IF(FDO_ENTFUT =  "" OR FDO_ENTFUT IS NULL, " ", FDO_ENTFUT) AS ENTFUT,               ');
    SQL.Add('  IF(FDO_MOTFUT =  "" OR FDO_MOTFUT IS NULL, " ", FDO_MOTFUT) AS MOTFUT,               ');
    SQL.Add('  IF(FDO_ENTRET =  "" OR FDO_ENTRET IS NULL, " ", FDO_ENTRET) AS ENTRET,               ');
    SQL.Add('  GR.GRU_CODGRU AS CODGRU,                                                             ');
    SQL.Add('  FDO_NUMDOC AS NUMDOC,                                                                ');
    SQL.Add('  (FDO_QTDITE - FDO_QTDBAI) AS QTDITE,                                                 ');
    SQL.Add('  ((FDO_QTDITE - FDO_QTDBAI) - (FDO_QTDITE - FDO_QTDSEP)) AS QTDDIS,                   ');
    If FParams.blnUsaImpressaoSeparacaoPorLocal Then
    Begin
      If (FParams.blnSepPorArmazem) Then
        SQL.Add(' (SELECT AMZ_DESCRI FROM CADAMZ WHERE AMZ_CODAMZ = FDO_NUMLOT AND AMZ_CODEMP = FDO_CODEMP LIMIT 1) AS DESLOC, ')
      Else
      begin
        if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
        begin
          SQL.Add('IF(IFNULL(FDO_NUMLOT, "") = "", ');
          SQL.Add('  (SELECT LSE_DESCRI FROM CADLSE WHERE LSE_CODIGO = G.ITE_CODLSE LIMIT 1), ');
          SQL.Add('  (SELECT LSE_DESCRI FROM CADLOT LT ');
          SQL.Add('     LEFT JOIN CADLOC CL1 ON CL1.LOC_CODLOC = LT.LOT_LOCFIS AND CL1.LOC_CODEMP = LT.LOT_CODEMP ');
          SQL.Add('     LEFT JOIN CADLSE LS1 ON LS1.LSE_CODIGO = CL1.LOC_CODLSE ');
          SQL.Add('    WHERE LT.LOT_CODITE = FDO_CODITE ');
          SQL.Add( '     AND LT.LOT_CODEMP = FDO_CODEMP ');
          SQL.Add( '     AND LT.LOT_NUMLOT = FDO_NUMLOT ');
          SQL.Add('   LIMIT 1) ');
          SQL.Add(') AS DESLOC, ');
        end
        else
          SQL.Add(' (SELECT LSE_DESCRI FROM CADLSE WHERE LSE_CODIGO = G.ITE_CODLSE LIMIT 1) AS DESLOC, ');
      end;
    End
    Else
    Begin
      SQL.Add(' " " AS DESLOC, ');
    End;

    SQL.Add('  FDO_EMPITE AS EMPITE,                                                                ');
    SQL.Add('  FDO_QTDITE AS QTDTOT,                                                                ');
    SQL.Add('  FDO_QTDBAI AS QTDBAI,                                                                ');
    SQL.Add('  FDO_DESESP AS DESESP,                                                                ');
    SQL.Add('  FDO_DESBAI AS DESBAI,                                                                ');
    SQL.Add('  UNI_SIGUNI AS UNIDAD,                                                                ');

    If Not FParams.blnCarregarQtdExpedida Then
      SQL.Add('  0.0000 AS QTDEXP, ')
    Else
      SQL.Add('  FDO_QTDEXP AS QTDEXP, ');

    //Somente deve expedir a quantidade que foi separada quando rotina WMS
    If FParams.blnUsaRotinaWMS Then
    begin
      SQL.Add(' (CASE WHEN (FDO_PROACA = "S") THEN ');
      SQL.Add('    FDO_QTDITE ');
      SQL.Add('  ELSE ');
      SQL.Add('   (SELECT IFNULL(SUM(LDO_QTDSEP),0) FROM LOTDOR WHERE LDO_SEQFDO = FATDOR.AUTOINCREM) ');
      SQL.Add('  END) AS QTDCOL,');

      SQL.Add(' (CASE WHEN (FDO_PROACA = "S") THEN ');
      SQL.Add('    FDO_QTDITE ');
      SQL.Add('  ELSE ');
      SQL.Add('   (SELECT IFNULL(SUM(LDO_QTDITE),0) FROM LOTDOR WHERE LDO_SEQFDO = FATDOR.AUTOINCREM) ');
      SQL.Add('  END) AS QTDSEP,');

      SQL.Add(' (SELECT GROUP_CONCAT(LDO_CODSEP, "#", LDO_QTDITE, "##" SEPARATOR "") FROM LOTDOR WHERE LDO_SEQFDO = FATDOR.AUTOINCREM GROUP BY LDO_SEQFDO) AS SEPDAD, '); //Dados dos operadores de separaçao para gravar na tabela DETSEP
    End
    else
      SQL.Add('  FDO_QTDSEP AS QTDSEP,                                                              ');

    SQL.Add('  (FDO_TOTCUS / FDO_QTDITE) AS VALCUS,                                                 ');
    SQL.Add('  (FDO_TOTCU2 / FDO_QTDITE) AS VALCU2,                                                 ');
    SQL.Add('  EXTDOR.FDO_FRERAT AS FRERAT,                                                         ');

    If (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And (fCfgSis('EXPATE', varBoolean)) Then
    Begin
      SQL.Add('  G.ITE_SALDOS + ' + fSQLQuantidadeEntregaFutura +
                            ' - ' + fGetSQLSomaExpedidos('G.ITE_CODITE', 'G.ITE_CODEMP') + ' AS SALEST, ');

      SQL.Add('  G.ITE_SALDOS + ' + fSQLQuantidadeEntregaFutura + ' AS SALDOS, ');
    End
    Else
    Begin
      SQL.Add('  G.ITE_SALDOS + ' + fSQLQuantidadeEntregaFutura + ' AS SALEST, ');
      SQL.Add('  G.ITE_SALDOS + ' + fSQLQuantidadeEntregaFutura + ' AS SALDOS, ');
    End;

    SQL.Add('  FATDOR.AUTOINCREM AS AUTOINCREM,                                                     ');
    SQL.Add('  FATDOR.FDO_SEQGER AS SEQGER,                                                         ');
    SQL.Add('  IF(LEFT(FDO_CLAFIS, 1) < "5", "E", "S") AS ENTSAI,                                   ');
    SQL.Add('  FDO_IDEPRO AS IDEPRO,                                                                ');

    If (fCfgSis('EXPTIN',varString) = '1') Then
      SQL.Add('  IF(FDO_CODACA IS NOT NULL AND FDO_CODACA <> "", ACA_CODBAR, I.ITE_CODBAR) AS CODBAR, ')
    Else
    Begin
      SQL.Add('  I.ITE_CODBAR AS CODBAR,                                                            ');
      SQL.Add('  ACA_CODBAR   AS CODBAT,                                                            ');
    End;

    SQL.Add('  EXTGOR.FGO_SEPEXP AS SEPEXP, ');
    SQL.Add('  I.ITE_PESOIT AS PESOIT,                                                              ');
    SQL.Add('  I.ITE_CODFAB AS CODFAB,                                                              ');
    SQL.Add('  I.ITE_REFERE AS REFERE,                                                              ');
    SQL.Add('  FDO_CODCLI AS CODCLI,                                                                ');
    SQL.Add('  CLI_NOMCLI AS NOMCLI,                                                                ');
    SQL.Add('  CLI_FANSOB AS FANSOB,                                                                ');
    SQL.Add('  CLI_ENDERE AS ENDERE,                                                                ');
    SQL.Add('  CLI_ENDNUM AS ENDNUM,                                                                ');
    SQL.Add('  CLI_ENDCOM AS ENDCOM,                                                                ');
    SQL.Add('  CLI_BAIRRO AS BAICLI,                                                                ');
    SQL.Add('  CLI_CODCID AS CODCID,                                                                ');
    SQL.Add('  CLI_C_E_P_ AS C_E_P_,                                                                ');
    SQL.Add('  FGO_CELCON AS CELCLI,                                                                ');
    SQL.Add('  FGO_CODTRA AS CODTRA,                                                                ');
    SQL.Add('  FGO_ORIGEM AS ORIGEM,                                                                ');
    SQL.Add('  TRA_NOMTRA AS NOMTRA,                                                                ');
    If (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And FParams.blnApenasFaturarJaExpedidos Then
      SQL.Add('  IFNULL(NULLIF(FDO_TIPBUS,""),"B") AS TIPBUS,                                         ')
    Else
      SQL.Add('  "B" AS TIPBUS,                                                                       ');
    SQL.Add('  "N" AS EXP_CX,                                                                       ');
    SQL.Add('  FDO_NUMDOC AS NUMDOC,                                                                ');
    SQL.Add('  FDO_ESPDOC AS ESPDOC,                                                                ');
    SQL.Add('  FDO_CODEMP AS CODEMP,                                                                ');

    SQL.Add('  (SELECT GROUP_CONCAT(CONCAT("-", BAR_CODBAR, "-")) FROM                              ');
    SQL.Add('   ITEBAR WHERE I.ITE_CODITE = BAR_CODITE) AS BAREMB,                                  ');

    SQL.Add('  I.ITE_EMBALA AS EMBALA,                                                              ');
    SQL.Add('  FGO_ENT_CD AS ENT_CD,                                                                ');
    SQL.Add('  IFNULL(FGO_EMP_CD, ' + QuotedStr(fCfgSis('EMP_CD')) + ') AS EMP_CD,                  ');
    SQL.Add('  FGO_OPRFLJ AS OPRFLJ,                                                                ');
    SQL.Add('  FGO_TIPFIN AS TIPFIN,                                                                ');
    SQL.Add('  FGO_DESFIN AS DESFIN,                                                                ');
    SQL.Add('  FDO_DESCND AS DESCND,                                                                ');

    If (blnUsaPafEcf) And (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
    Begin
      SQL.Add(' (SELECT IF(COUNT(*) > 0, "S", "N")        ');
      SQL.Add('     FROM DAVPVG                           ');
      SQL.Add('     WHERE                                 ');
      SQL.Add('       DPG_NUMDOC = FGO_NUMDOC AND         ');
      SQL.Add('       DPG_ESPDOC = FGO_ESPDOC AND         ');
      SQL.Add('       DPG_CODEMP = FGO_CODEMP) AS TEMDAV, ');
    End
    Else
    Begin
      SQL.Add(' "N" AS TEMDAV, ');
    End;

    SQL.Add('  FGO_VPAR01 AS VPAR01, ');
    SQL.Add('  FGO_VPAR02 AS VPAR02, ');
    SQL.Add('  FGO_VPAR03 AS VPAR03, ');
    SQL.Add('  FGO_VPAR04 AS VPAR04, ');
    SQL.Add('  FGO_VPAR05 AS VPAR05, ');
    SQL.Add('  FGO_VPAR06 AS VPAR06, ');
    SQL.Add('  FGO_VPAR07 AS VPAR07, ');
    SQL.Add('  FGO_VPAR08 AS VPAR08, ');
    SQL.Add('  FGO_VPAR09 AS VPAR09, ');
    SQL.Add('  FGO_VPAR10 AS VPAR10, ');
    SQL.Add('  FGO_VPAR11 AS VPAR11, ');
    SQL.Add('  FGO_VPAR12 AS VPAR12, ');

    SQL.Add('  G.ITE_PREULT AS PREULT, ');
    SQL.Add('  G.ITE_IMPULT AS IMPULT, ');

    SQL.Add('  CAST( IF(IFNULL(FDO_NUMLOT, "") <> "", LOT_LOCFIS, CONCAT( GL.ITE_LOCFIS, ",", ');
    SQL.Add('    (IFNULL((SELECT GROUP_CONCAT(DISTINCT LOC_LOCFIS) FROM LOCFIS ');
    SQL.Add('      WHERE LOC_CODITE = FDO_CODITE AND LOC_CODEMP = IF(IFNULL(EXTGOR.FGO_EMP_TE, "") <> "", ');
    SQL.Add('     EXTGOR.FGO_EMP_TE, FDO_CODEMP)), "")))) AS CHAR(50) ) AS LOCFIS, ');

    If strOrdExi = '5' Then
      SQL.Add('  DEP_DESCRI,');

    SQL.Add('  ITE_CODUNI, ');
    SQL.Add('  FDO_ENTRET AS RETENT, ');
    SQL.Add('  G.ITE_USASER AS USASER, ');

    SQL.Add('  IFNULL(I.ITE_MLTVEN, 0) AS MLTVEN, ');

    SQL.Add('  IF(FORTIN.FOR_EMPACA = "" OR FORTIN.FOR_EMPACA IS NULL, " ", FORTIN.FOR_EMPACA) FOR_EMPACA, ');
    SQL.Add('  IF(FORTIN.FOR_MODDIL = "" OR FORTIN.FOR_MODDIL IS NULL, 0,   FORTIN.FOR_MODDIL) FOR_MODDIL, ');
    SQL.Add('  IF(FORTIN.FOR_TEXBAS = "" OR FORTIN.FOR_TEXBAS IS NULL, " ", FORTIN.FOR_TEXBAS) FOR_TEXBAS, ');
    SQL.Add('  IF(FORTIN.FOR_TIPCOR = "" OR FORTIN.FOR_TIPCOR IS NULL, " ", FORTIN.FOR_TIPCOR) FOR_TIPCOR, ');
    SQL.Add('  IF(FORTIN.FOR_ITECOB = "" OR FORTIN.FOR_ITECOB IS NULL, " ", FORTIN.FOR_ITECOB) FOR_ITECOB, ');
    SQL.Add('  IF(FORTIN.FOR_CODACA = "" OR FORTIN.FOR_CODACA IS NULL, " ", FORTIN.FOR_CODACA) FOR_CODACA, ');
    SQL.Add('  IF(FORTIN.FOR_CATALI = "" OR FORTIN.FOR_CATALI IS NULL, " ", FORTIN.FOR_CATALI) FOR_CATALI, ');
    SQL.Add('  FATGOR.AUTOINCREM AS FGOINC,                                                                ');
    SQL.Add('  FATDOR.AUTOINCREM AS FDOINC,                                                                ');
    SQL.Add('  FATGOR.FGO_PEDSIT,                                                                          ');
    SQL.Add('  FGO_FATTOT AS FATTOT,                                                                       ');
    SQL.Add('  FGO_COTLAL AS COTLAL,                                                                       ');
    SQL.Add('  FATDOR.FDO_PROACA AS PROACA,                                                                ');
    SQL.Add('  IFNULL(NULLIF('+ IIF(fCfgSis('GRUSEP') = 'S', 'LSE_DESCRI', 'G.ITE_LOCFIS') +', ""), "'+ strSetorDefault +'") AS SETOR_, ');

    If FParams.blnControlePorArmazem Then
    Begin
      SQL.Add('  CONCAT(FATDOR.FDO_NUMLOT, "-", CADAMZ.AMZ_DESCRI) AS ARMAZE, ');
    End
    Else
    Begin
      If FParams.blnUsaRotinaWMS Then
        SQL.Add('  (SELECT CONVERT(SUBSTRING(GROUP_CONCAT(IFNULL(LOTDOR.LDO_NUMLOT, "")), 1, 209), CHAR(209)) FROM LOTDOR WHERE LOTDOR.LDO_SEQFDO = FATDOR.AUTOINCREM) AS ARMAZE, ')
      Else
        SQL.Add('  FATDOR.FDO_NUMLOT AS ARMAZE, ');
    End;

    SQL.Add('  CADCLI.CLI_CODCID AS CODCID,                                                                ');
    SQL.Add('  CADCLI.CLI_CODREG AS CODREG,                                                                ');
    SQL.Add('  FATDOR.FDO_CODVEN AS CODVEN,                                                                ');
    SQL.Add('  FATDOR.FDO_CODVE2 AS CODVE2,                                                                ');
    SQL.Add('  DATE_FORMAT(ER.ENT_DTAENT,"%d/%m") AS DTAENT,                                               ');
    SQL.Add('  FATGOR.FGO_VOLUME AS VOLUME,                                                                ');
    SQL.Add('  EXTGOR.FGO_OPEEXP AS OPEEXP,                                                                ');
    SQL.Add('  FATDOR.FDO_CODCND,                                                                          ');
    SQL.Add('  CADREG.REG_DESREG AS NOMROT,                                                                ');
    SQL.Add('  EXTDOR.FDO_NUMCMP AS NUMCMP,                                                                ');
    SQL.Add('  I.ITE_GRAMAR AS GRAMAR,                                                                     ');
    SQL.Add('  FATDOR.FDO_NUMLOT AS NUMLOT,                                                                ');
    SQL.Add('  CADREG.REG_CODREG AS CODROT                                                                 ');
    SQL.Add('  , CASE                                                                                      ');
    SQL.Add('      WHEN FDO_ENTRET = "R" AND IFNULL(FDO_LOCRET, "") = ""   THEN "R"                        ');
    SQL.Add('      WHEN FDO_ENTRET = "R" AND IFNULL(FDO_LOCRET, "") = "E"  THEN "R.E."                     ');
    SQL.Add('      WHEN FDO_ENTRET = "E" AND IFNULL(FDO_LOCRET, "") = ""   THEN "E.I."                     ');
    SQL.Add('      WHEN FDO_ENTRET = "R" AND IFNULL(FDO_LOCRET, "") = "B"   THEN "R.B."                    ');
    SQL.Add('      WHEN FDO_ENTRET = "R" AND IFNULL(FDO_LOCRET, "") = "B2"   THEN "R.B2."                  ');
    SQL.Add('    END AS DESTINO                                                                            ');

    SQL.Add('    ,IF(FATGOR.FGO_NOMCON IS NULL OR FATGOR.FGO_NOMCON = "",                                  ');
    SQL.Add('     IF(EC.ETC_ENDENT IS NULL OR EC.ETC_ENDENT = "", CADCLI.CLI_ENDERE, EC.ETC_ENDENT),       ');
    SQL.Add('     FATGOR.FGO_ENDCON) AS ENDENT                                                             ');

    SQL.Add('    ,IF(FATGOR.FGO_NOMCON IS NULL OR FATGOR.FGO_NOMCON = "",                                  ');
    SQL.Add('      IF(EC.ETC_ENDENT IS NULL OR EC.ETC_ENDENT = "", CADCLI.CLI_C_E_P_,EC.ETC_CEPENT),       ');
    SQL.Add('      FATGOR.FGO_CEPCON) AS CEPENT                                                            ');

    SQL.Add('    ,IF(FATGOR.FGO_NOMCON IS NULL OR FATGOR.FGO_NOMCON = "",                                  ');
    SQL.Add('      IF(EC.ETC_ENDENT IS NULL OR EC.ETC_ENDENT = "", CF.CID_NOMCID,CE.CID_NOMCID),           ');
    SQL.Add('      CC.CID_NOMCID) AS CIDENT                                                                ');

    SQL.Add('    ,IF(FATGOR.FGO_NOMCON IS NULL OR FATGOR.FGO_NOMCON = "",                                  ');
    SQL.Add('     IF(EC.ETC_ENDENT IS NULL OR EC.ETC_ENDENT = "", CF.CID_ESTADO,CE.CID_ESTADO),            ');
    SQL.Add('     CC.CID_ESTADO) AS ESTENT                                                                 ');

    SQL.Add('    ,IF(FATGOR.FGO_NOMCON IS NULL OR FATGOR.FGO_NOMCON = "",                                  ');
    SQL.Add('     IF(EC.ETC_BAIENT IS NULL OR EC.ETC_BAIENT = "", CADCLI.CLI_BAIRRO,EC.ETC_BAIENT),        ');
    SQL.Add('     FATGOR.FGO_BAICON) AS BAIENT                                                             ');

    pSqlFrom(qryItens.SQL,
             blnReimpressaoVolumes,
             FParams.blnExiPedRetiraExpAntFat,
             FParams.blnApenasFaturarJaExpedidos,
             FParams.blnApenasConferenciaProdutosRetiraCaixa,
             strOrdExi,
             FParams.stlPedidos,
             FParams.blnUsaImpressaoSeparacaoPorLocal,
             fContemPedidosEmpresaPrioridade,
             FParams.blnExibirRetiraEntregaPedidosTransfFaturamentoAntExp);

    pSetarFiltroEstoque(qryItens.SQL);

    SQL.Add(' ORDER BY ');

    If FParams.blnOndaSeparacao Then
      SQL.Add('  FDO_DESCRI, FGO_PREVIS ')
    Else
    Case strOrdExi[1] Of
      '1': SQL.Add('  FDO_DESCRI ');
      '2': SQL.Add('  UNIDAD, FDO_DESCRI ');
      '3': SQL.Add('  ORDITE, FATDOR.AUTOINCREM ');
      '4': SQL.Add('  LOCFIS,  FDO_DESCRI ');
      '5': SQL.Add('  DEP_DESCRI, FDO_DESCRI ');
      '6': SQL.Add('  IF(IFNULL(FDO_ENTRET, "R") = "R",0, IF(IFNULL(FDO_ENTFUT, "N") = "N", 1, 2)), FDO_DESCRI ');
    End;

    pSqlParams(qryItens, fRetornaEmpresaExpedicaoSePedidoOutraLoja);

    Open;

    pSetaClient(qryItens);

  End;

  pSetaClient(qryItens);

  cdsItens.Close;
  cdsItens.Open;

  blnTemItensRetira := fTemItensRetira;
  blnTemItensTintas := fTemItensTintas;

  pCarregaSaldosColorantes;

  If fCfgSis('NSERQT', varBoolean) Then
    pCarregaSeriesItens;

  cdsItens.OnFilterRecord := pOnFilter;

  //Se nao existir a dll da tinta especifica entao nao deixa expedir;
  If blnFecharForm Then
    Exit;

  blnFecharForm := cdsItens.IsEmpty;

  If (blnFecharForm) Then
    fMensagem('ATENÇÃO!', 'Não há itens neste pedido!', ['&Ok']);

  If FParams.blnUsaRotinaWMS And (cdsItens.FieldByName('ORIGEM').AsString = 'AKZO NOBEL') Then
  Begin
    blnFecharForm := not fCarregaConfiguracoesAKZNobel;

    If not blnFecharForm Then
      fMensagem('ATENÇÃO!', 'O cliente do(s) pedido(s) selecionado(s) é BROKER "AKZO NOBEL"' + #13 +
                            'Os valores serão recalculados conforme as configurações.', ['&O k']);
  End;

  If (pnlResumoUnidadeItens.Visible) Then
    pCarregaResumoUnidadesItens;

end;

procedure TfrmFatExpedicaoItens.pCarregaPesoItens(var fltPesoBru,
  fltPesoLiq: Double);
var
  recJaExpedido: TJaExpedido;
  fltQtdExpMomento: Double;
begin
  fltPesoBru := 0;
  fltPesoLiq := 0;

  cdsItens.DisableControls;

  try
    cdsItens.First;

    while not cdsItens.Eof do
    begin
      for recJaExpedido in arrJaExpedidoList do
      begin
        if cdsItens.FieldByName('AUTOINCREM').AsString = recJaExpedido.strAutInc then
        begin
          fltQtdExpMomento := cdsItens.FieldByName('QTDEXP').AsFloat - recJaExpedido.fltQtdExp;
          fltPesoBru := fltPesoBru + fFormataFloat((fltQtdExpMomento * fRetPesBru(cdsItens.FieldByName('CODITE').AsString)),3);

          if (fCfgSis('PESLIQ') = 'SOMA') then
          begin
            fltPesoLiq := fltPesoLiq + fFormataFloat((fltQtdExpMomento * fRetPesLiq(cdsItens.FieldByName('CODITE').AsString)),3);
          end
          else
          begin
            fltPesoLiq := fltPesoLiq + fFormataFloat((fltPesoBru * fStrToFloat(fCfgSis('FATPLI', varDouble))),3);
          end;

          Break;
        end;
      end;

      cdsItens.Next;
    end;
  finally
    cdsItens.First;
    pEnableCdsItens();
  end;
end;

procedure TfrmFatExpedicaoItens.pCarregaRecordItensExpedidos;
begin
  if (not fCfgSis('PESEXP', varBoolean)) then
    Exit;

  If (cdsItens.Active) And (Not cdsItens.IsEmpty) And (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And (FParams.VS_strTipExpInterna = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
  Begin
    cdsItens.DisableControls;
    try
      cdsItens.First;

      while not cdsItens.Eof do
      begin
        SetLength(arrJaExpedidoList, Length(arrJaExpedidoList) + 1);
        arrJaExpedidoList[Length(arrJaExpedidoList) - 1].strAutInc := cdsItens.FieldByName('AUTOINCREM').AsString;
        arrJaExpedidoList[Length(arrJaExpedidoList) - 1].fltQtdExp := cdsItens.FieldByName('QTDEXP').AsFloat;
        cdsItens.Next;
      end;

    finally
      cdsItens.First;
      pEnableCdsItens();
    end;
  End;
end;

procedure TfrmFatExpedicaoItens.pCarregaResumoUnidadesItens;
  Var
    cdsClone: TUniClientDataSet;
    strSiglaUnidade: string;
    fltQtdUnidade: Double;

begin

  cdsClone := TUniClientDataSet.Create(Self);

  Try
    pCloneDataSet(cdsClone, cdsItens);
    cdsClone.IndexFieldNames := 'UNIDAD';

    cdsClone.First;

    strSiglaUnidade := cdsClone.FieldByName('UNIDAD').AsString;
    fltQtdUnidade := 0;
    mmoResumoUnidades.Clear;

    while not cdsClone.Eof do
    begin

      fltQtdUnidade := fltQtdUnidade + cdsClone.FieldByName('QTDEXP').AsFloat;
      cdsClone.Next;

      if (strSiglaUnidade <> cdsClone.FieldByName('UNIDAD').AsString) or
        (cdsClone.Eof) then
      begin
        mmoResumoUnidades.Lines.Add(strSiglaUnidade + ' - ' + FloatToStr(fFormataFloat(fltQtdUnidade, 3)));
        fltQtdUnidade := 0;
        strSiglaUnidade := cdsClone.FieldByName('UNIDAD').AsString;
      end;

    end;

  Finally
    FreeAndNil(cdsClone);
  End;

end;

procedure TfrmFatExpedicaoItens.pCarregaSaldosColorantes;
  Var
    matrizSaldosAux: TClassMatrizSaldosColorantes;
    qryItens: TUniQuery;
    blnLocFor: Boolean;
Begin
  Try
    qryItens := fCriaQuery;
    With qryItens Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT      ');
      SQL.Add('  FATDOR.*, ');
      SQL.Add('  IFNULL(FORTIN.FOR_EMPACA, " ") FOR_EMPACA, ');
      SQL.Add('  IFNULL(FORTIN.FOR_MODDIL, 0)   FOR_MODDIL, ');
      SQL.Add('  IFNULL(FORTIN.FOR_TEXBAS, " ") FOR_TEXBAS, ');
      SQL.Add('  IFNULL(FORTIN.FOR_TIPCOR, " ") FOR_TIPCOR, ');
      SQL.Add('  IFNULL(FORTIN.FOR_ITECOB, " ") FOR_ITECOB, ');
      SQL.Add('  IFNULL(FORTIN.FOR_CODACA, " ") FOR_CODACA, ');
      SQL.Add('  IFNULL(FORTIN.FOR_UNIVER, " ")  FOR_UNIVER, ');
      SQL.Add('  IFNULL(FORTIN.FOR_CATALI, " ")  FOR_CATALI  ');

      pSqlFrom(qryItens.SQL,
               False,
               FParams.blnExiPedRetiraExpAntFat,
               FParams.blnApenasFaturarJaExpedidos,
               FParams.blnApenasConferenciaProdutosRetiraCaixa,
               strOrdExi,
               FParams.stlPedidos,
               FParams.blnUsaImpressaoSeparacaoPorLocal,
               False,
               FParams.blnExibirRetiraEntregaPedidosTransfFaturamentoAntExp);

      pSqlParams(qryItens);

      Open;
    End;

    With qryItens Do
    Begin
      First;
      While Not Eof Do
      Begin
        If FieldByName('FDO_IDEPRO').AsString <> 'NOR' Then
        Begin

          If (Not IsTintaExistente(FieldByName('FDO_IDEPRO').AsString)) Then
          Begin
            blnFecharForm := True;
            FreeAndNil(qryItens);
            Exit;
          End;

          matrizSaldosAux := fDesfragmentaTintaSaldosOR(qryItens, blnLocFor);
          matrizSaldosAux.pZerarQuantidadeFormulacao;

          If Not blnLocFor then
          Begin
            FreeAndNil(qryItens);
            blnFecharForm := True;
            Exit;
          End;

          fatVenEst.dicFormulas.AdicionarObjeto(FieldByName('AUTOINCREM').AsString, matrizSaldosAux);

        End;

        Next;
      End;

      First;
    End;

    FreeAndNil(qryItens);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'pCarregaSaldosColorantes');
    End;
  End;

End;

procedure TfrmFatExpedicaoItens.pCarregaSeriesItens;
begin
  cdsItens.DisableControls;
  Try
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      If cdsItens.FieldByName('USASER').AsString = 'S' Then
      Begin
        objFatSerieItem.AutoincItem := cdsItens.FieldByName('AUTOINCREM').AsString;
        objFatSerieItem.pCarregaSeriesItem(cdsItens.FieldByName('CODITE').AsString,
                                           cdsItens.FieldByName('EMPITE').AsString,
                                           cdsItens.FieldByName('AUTOINCREM').AsString,
                                           cdsItens.FieldByName('SEQGER').AsString);
      End;
      cdsItens.Next;
    End;
  Finally
    pEnableCdsItens();
  End;
end;

procedure TfrmFatExpedicaoItens.pCarregaTotaisPesoItensExpedidos;
var
  qryPeso: TUniQuery;
  intIndice: integer;
begin
  if (not fCfgSis('PESEXP', varBoolean)) then
    Exit;

  if (VS_strTipExp <> TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) then
    Exit;

  if not Assigned(FParams.stlPedidos) then
    Exit;

  qryPeso := fCriaQuery;

  try
    qryPeso.Close;
    qryPeso.SQL.Clear;
    qryPeso.SQL.Add('SELECT FGO_PEBRTE, FGO_PELITE');
    qryPeso.SQL.Add('FROM EXTGOR');
    qryPeso.SQL.Add('WHERE FGO_SEQFGO = :AUTINC');

    for intIndice := 0 to FParams.stlPedidos.Count - 1 do
    begin
      qryPeso.Close;
      qryPeso.ParamByName('AUTINC').AsString := TPedidoVenda(FParams.stlPedidos.Objects[intIndice]).strSeqGer;
      qryPeso.Open;

      if qryPeso.IsEmpty then
        Continue;

      SetLength(arrTotaisPeso, Length(arrTotaisPeso) + 1);
      arrTotaisPeso[Length(arrTotaisPeso) - 1].strAutInc := TPedidoVenda(FParams.stlPedidos.Objects[intIndice]).strSeqGer;
      arrTotaisPeso[Length(arrTotaisPeso) - 1].fltPesBru := qryPeso.FieldByName('FGO_PEBRTE').AsFloat;
      arrTotaisPeso[Length(arrTotaisPeso) - 1].fltPesLiq := qryPeso.FieldByName('FGO_PELITE').AsFloat;
    end;
  finally
    FreeAndNil(qryPeso);
  end;
end;

function TfrmFatExpedicaoItens.fLiberacaoExpedicaoAutomatica: Boolean;
begin
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Utilização de Expedição Automática.');
  objLiberacao.objMsgLibera.pAddSeparador(95);
  objLiberacao.objMsgLibera.pAddTexto('Operador: ' + strLoginUsuarioLogado + ' - ' + fRetNomeOperador(strLoginUsuarioLogado));
  objLiberacao.objMsgLibera.pAddTexto('Documento: ' + cdsItens.FieldByName('NUMDOC').AsString + ' - ' + cdsItens.FieldByName('ESPDOC').AsString + ' - ' + cdsItens.FieldByName('CODEMP').AsString);
  objLiberacao.objMsgLibera.pAddTexto('Cliente: ' + cdsItens.FieldByName('CODCLI').AsString + ' - ' + cdsItens.FieldByName('NOMCLI').AsString);
  objLiberacao.objMsgLibera.pAddSeparador(95);
  objLiberacao.objMsgLibera.pAddTexto('Itens que estão sendo expedidos:');
  objLiberacao.objMsgLibera.pAddSeparador(95);
  objLiberacao.objMsgLibera.pAddTexto('|Código  |Descrição                                                             |Quantidade  |');

  cdsItens.First;
  While Not cdsItens.Eof Do
  Begin
    objLiberacao.objMsgLibera.pAddTexto('|' + fPadR(cdsItens.FieldByName('CODITE').AsString,  8, ' ') +
                                        '|' + fPadR(cdsItens.FieldByName('DESCRI').AsString, 70, ' ') +
                                        '|' + fPadL(cdsItens.FieldByName('QTDITE').AsString, 12, ' ') + '|');

    cdsItens.Next;
  End;
  objLiberacao.objMsgLibera.pAddSeparador(95);

  objLiberacao.strDirAce := 'EXPAUT';
  objLiberacao.strMsgSen := 'Utilização de Expedição Automática.';
  objLiberacao.blnMosMen := True;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.pInformaNumDocEspDocCodEmp(cdsItens.FieldByName('NUMDOC').AsString, cdsItens.FieldByName('ESPDOC').AsString, VS_strCodEmp);

  Result := objLiberacao.fLibera;
end;

function TfrmFatExpedicaoItens.fLimparExpedido : boolean;
Begin
  Result := (FParams.VS_strTipExpInterna = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Or
            (fVerificaAcessoSistema('EXPMTD', strLoginUsuarioLogado));
End;

procedure TfrmFatExpedicaoItens.pGravarConfiguracaoColunas;
begin
  TCfgColExpItensCaixa.pSalvarEstado(dbgItens, TCfgColExpItensCaixa.arrColsOri);
  TCfgColExpItensCaixa.pSalvarEstadoCaixa(dbgEtiCaixa, TCfgColExpItensCaixa.arrColsOriCaixa);
end;

procedure TfrmFatExpedicaoItens.FormShow(Sender: TObject);
  Var
    fltValMinRet : Double;
    fltValMinEnt : Double;
begin
  inherited;

  If Not Assigned(objConDor) Then
    objConDor := TConDor.Create;

  objConDor.pIniciou;

  edtQtdIte.Text := FloatToStrF(1, ffFixed, 12, intDecQtd);
  edtQtdChapas.Text := FloatToStrF(0, ffFixed, 12, intDecQtd);

  If fEmptyStr(FParams.VS_strTipExpInterna) Then
    FParams.VS_strTipExpInterna := VS_strTipExp;

  FParams.blnApenasFaturarJaExpedidos := FParams.blnCarregarQtdExpedida And (FParams.VS_strTipExpInterna = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO);

  lblLimparExpedido.Visible := fLimparExpedido;

  btnEtqSepFaltante.Visible := (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And (fCfgSis('EXPETG', varBoolean));

  stlItens  := TStringList.Create;
  qryEtique := fCriaQuery;

  cdsSelecao.CreateDataSet;
  cdsSelecao.Open;
  cdsSelecao.EmptyDataSet;
  cdsSelecao.Filter   := '';
  cdsSelecao.Filtered := FALSE;

  blnFecharForm := False;
  FConfirmou  := False;

  strTodosNumSer := '';
  strTodosCodIte := '';
  strTodosPedidos := '';

  pnlResumoUnidadeItens.Visible := (fCfgSis('RESUNE') = 'S');

  If (FParams.VS_strTipExpInterna = TIPEXP_POR_DOCUMENTO_DE_VENDA) Then
  Begin
    pCarregaItensDocumento;
  End
  Else
  Begin

    pCarregaItensPedido;

    If fUsaMontagemCaixas Then
      pCarregaCaixas;

    FParams.qryFatGor := fCriaQuery(Self);
    With FParams.qryFatGor Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fSelectFromFatgorLeftAuxiliares(False));
      SQL.Add('WHERE ');
      SQL.Add('  F.FGO_NUMDOC = :NUMDOC AND ');
      SQL.Add('  F.FGO_ESPDOC = :ESPDOC AND ');
      SQL.Add('  F.FGO_CODEMP = :CODEMP ');

      ParamByName('NUMDOC').AsString := FParams.strNumDoc;
      ParamByName('ESPDOC').AsString := 'PD';
      ParamByName('CODEMP').AsString := FParams.strCodEmp;

      Open;
    End;

    If fCfgSis('USACCR', varBoolean) And ((fCfgSis('TPNFCR') = SECOL) Or (fCfgSis('TPNFCR') = J_A_MASSA_CONCRETO)) Then
    Begin
      FParams.blnSimplesRemessaConcreto :=
        fDocumentoPossuiItemConcreto(cdsItens.FieldByName('NUMDOC').AsString,
                                     cdsItens.FieldByName('ESPDOC').AsString,
                                     cdsItens.FieldByName('CODEMP').AsString);
    End;
  End;

  if (Assigned(FParams.stlPedidos)) and (FParams.stlPedidos.Count > 0) Then
  Begin
    pMontaListaClientes;
    pMontaListaCondicaoPagamento(FParams.stlPedidos);
    {Para as demais travas, verificar a configuração pois elas só
     serão utilizadas na confirmação da expedição - KM}
    If (fPermitirMarcarPedidosDeClientesDiferentesNaExpedicao) Or (fPermiteSelecionarPedidoComCondicaoPagamentoDiferenteNaExpedicao) Then
    Begin
      pMontaListaGrupos;
    End;
  End;

  If (Not FParams.blnApenasFaturarJaExpedidos) And MatchStr(VS_strTipExp, [TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO, TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO]) And (Not FParams.blnExpedicaoDocumentoFaturadoAutomaticamente) Then
  Begin
    {Exibir botão que mostrará uma tela contendo os valores para cada cliente - KM}
    If (FParams.stlListaClientes.Count > 1) And (fPermitirMarcarPedidosDeClientesDiferentesNaExpedicao) Then
    Begin
      pValorMinimoNotaFiscalRetiraLista(fltValMinRet);
      pValorMinimoNotaFiscalEntregaLista(fltValMinEnt);
      lblVlrMinEnt.Visible           := False;
      lblVlrMinRet.Visible           := False;
      btnVisualizarVlrMinEnt.Visible := (fltValMinEnt > 0);
      btnVisualizarVlrMinEnt.Left    := lblVlrMinEnt.Left;
    End
    Else
    Begin
      fltValMinRet := fValorMinimoNotaFiscalRetira(FParams.strCodCli);
      fltValMinEnt := fValorMinimoNotaFiscalEntrega(FParams.strCodCli);

      lblVlrMinEnt.Caption           := FloatToStrF(fltValMinEnt, ffFixed, 12, 2);
      lblVlrMinRet.Caption           := FloatToStrF(fltValMinRet, ffFixed, 12, 2);
      lblVlrExpTot.Caption           := FloatToStrF(0,            ffFixed, 12, 2);
      lblVlrMinEnt.Visible           := (fltValMinEnt > 0);
      lblVlrMinRet.Visible           := (fltValMinRet > 0) And (blnTemItensRetira);
      btnVisualizarVlrMinEnt.Visible := False;
    End;
    lblTitVlrMinEnt.Visible := (fltValMinEnt > 0);
    lblTitVlrMinRet.Visible := (fltValMinRet > 0) And (blnTemItensRetira);

    pnlVlrMin.Visible := (lblTitVlrMinEnt.Visible) Or (lblTitVlrMinRet.Visible);
  End;

  fFindColumnByName(dbgItens,'DOCUME').Visible := FParams.blnOndaSeparacao And FParams.VS_strTipExpInterna.Equals(TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO);
  fFindColumnByName(dbgItens,'PREVIS').Visible := FParams.blnOndaSeparacao And FParams.VS_strTipExpInterna.Equals(TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO);

  If fCfgSis('QTDEXP',varBoolean) Then
  Begin
    fFindColumnByName(dbgItens,'QTDITE').Visible := True;

    If FParams.blnUsaImpressaoSeparacaoPorLocal or fPermiteImprimirSeparacaoParcial Then
       fFindColumnByName(dbgItens,'QTDDIS').Visible := True;

    fFindColumnByName(dbgItens,'DESITE').Width := fFindColumnByName(dbgItens,'DESITE').Width - fFindColumnByName(dbgItens,'QTDITE').Width;

    If FParams.blnUsaImpressaoSeparacaoPorLocal or fPermiteImprimirSeparacaoParcial Then
      fFindColumnByName(dbgItens,'DESITE').Width := fFindColumnByName(dbgItens,'DESITE').Width - fFindColumnByName(dbgItens,'QTDDIS').Width;
  End
  Else
    fFindColumnByName(dbgItens,'QTDITE').Visible := False;

  If (blnExiApl) And (fCampoExiste('CADITE', 'ITE_APLICA', True)) Then
  Begin
    pnlAplicacao.Visible := True;
    mmoAplica.DataSource := dtsItens;
  End;

  {**********************************}
  { EXIBI SALDO DO ESTOQUE           }
  {*******************************JB*}
  If fCfgSis('EXISEE',varBoolean) Then
  Begin
    If (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And (fCfgSis('EXPATE', varBoolean)) Then
    Begin
      fFindColumnByName(dbgItens,'SALDOS').Visible := True;
      fFindColumnByName(dbgItens,'SALDOS').Title.Caption := 'Estoque';
      fFindColumnByName(dbgItens,'DESITE').Width   := fFindColumnByName(dbgItens,'DESITE').Width - fFindColumnByName(dbgItens,'SALDOS').Width;

      fFindColumnByName(dbgItens,'SALEST').Visible := True;
      fFindColumnByName(dbgItens,'SALEST').Title.Caption := 'Saldo Disp.';
      fFindColumnByName(dbgItens,'DESITE').Width   := fFindColumnByName(dbgItens,'DESITE').Width - fFindColumnByName(dbgItens,'SALEST').Width;
    End
    Else
    Begin
      fFindColumnByName(dbgItens,'SALEST').Visible := True;
      fFindColumnByName(dbgItens,'DESITE').Width   := fFindColumnByName(dbgItens,'DESITE').Width - fFindColumnByName(dbgItens,'SALEST').Width;
    End;
  End
  Else
    fFindColumnByName(dbgItens,'SALDOS').Visible := False;

  fFindColumnByName(dbgItens,'LOCFIS').Visible := (Not FParams.blnUsaRotinaWMS);

  fFindColumnByName(dbgItens,'DESLOC').Visible := False;
  If FParams.blnUsaImpressaoSeparacaoPorLocal Then
  Begin
    fFindColumnByName(dbgItens,'DESLOC').Visible := True;
    If (FParams.blnSepPorArmazem) Then
    Begin
      fFindColumnByName(dbgItens,'DESLOC').Title.Caption := 'Armazém'
    End
    Else
    Begin
      fFindColumnByName(dbgItens,'DESLOC').Title.Caption := 'Loc. Sep.'
    End;
  End;

  fFindColumnByName(dbgItens,'ARMAZE').Visible := FParams.blnControlePorArmazem;

  fFindColumnByName(dbgItens,'QTDSEP').Visible := fCfgSis('EQSEXP', varBoolean);
  If FParams.blnUsaRotinaWMS Then
  Begin
    If (fCfgSis('BPUNSP', varBoolean)) Or (fCfgSis('TPLREC', varString) <> 'N') Then
    Begin
      fFindColumnByName(dbgItens,'QTDCOL').Visible := fCfgSis('EQSEXP', varBoolean);
      fFindColumnByName(dbgItens,'QTDSEP').Title.Caption := 'Separado (Solicitado)';
      fFindColumnByName(dbgItens,'QTDCOL').Title.Caption := 'Separado (Coletor)';
    End;
  End;

  If VS_strTipDEx = '2' Then
    pSetFocus(dbgItens);

  If FParams.blnApenasFaturarJaExpedidos Then
  Begin
    If (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And (FParams.blnBaiEntFut) Then
    Begin
      lblLimparExpedido.Visible := False;
      btnMarcarTudo.Visible     := False;
    End;

    btnQuantidade.Visible := False;
    btnExpAut.Visible := False;
    btnEtiqueta.Visible := False;
    pnlRodape.Visible := False;
    btnLimpaExp.Visible := False;
    btnSelMan.Visible := False;
  End;

  shpSemSal.Visible := (FParams.VS_strTipExpInterna = TIPEXP_POR_DOCUMENTO_DE_VENDA);
  lblSemSal.Visible := (FParams.VS_strTipExpInterna = TIPEXP_POR_DOCUMENTO_DE_VENDA);

  pOrdenarItens;
  cdsItens.First;

  TCfgColExpItensCaixa.strTipExp := FParams.VS_strTipExpInterna;
  TCfgColExpItensCaixa.pIniciar(dbgItens);
  TCfgColExpItensCaixa.pIniciarCaixa(dbgEtiCaixa);

  If FParams.blnControlePorArmazem Then
    fFindColumnByName(dbgItens,'ARMAZE').Title.Caption := 'Armazém'
  Else
    fFindColumnByName(dbgItens,'ARMAZE').Title .Caption:= 'Lote';

  pGravarConfiguracaoColunas;

  If FParams.blnFaturandoTodosAutomaticamente Then
    FParams.blnExpAut := True;

  If FParams.blnExpAut Then
  Begin
    dtsItens.DataSet := nil;
    TfrmGravando.fExecutarModalA(pExpedicaoAutomatica, 'Aguarde, Realizando Expedição Automática ...', '');
    dtsItens.DataSet := cdsItens;
  End;

  If FParams.blnOndaSeparacao Then
  Begin
    If Not fEmptyStr(FParams.strCodBarrasExp) Then
    Begin
      If FParams.TipoItemDoPedidoOndaSeparacao <> opSubItemDeItemInseridoNoPedido Then
      Begin
        edtCodIte.Text := FParams.strCodBarrasExp;
        edtQtdIte.Text := FloatToStrF(1, ffFixed, 12, intDecQtd);
        edtQtdChapas.Text := FloatToStrF(0, ffFixed, 12, intDecQtd);
        pExpedeItemOndaSep;
      End;
    End
    Else If FParams.blnApenasFaturarJaExpedidos Then
      tmrConfirmarAutomaticamente.Enabled := True;
  End;

  If FParams.blnOndaSeparacao Then
    pOrdenarItens;

  If MatchStr(FParams.VS_strTipExpInterna, [TIPEXP_POR_DOCUMENTO_DE_VENDA, TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO]) Then
    pMensagemGarantiaEnvioClienteExp;

  strIndexField  := cdsItens.IndexName;

  btnNumSeries.Visible := (FParams.VS_strTipExpInterna <> TIPEXP_POR_DOCUMENTO_DE_VENDA) And
    fCfgSis('NSERQT', varBoolean) And Not FParams.blnApenasFaturarJaExpedidos;
  If (btnNumSeries.Visible) Then
    btnNumSeries.Enabled := fHabilitarManutencaoDeSerie;

  pCarregaRecordItensExpedidos;

  pCarregaTotaisPesoItensExpedidos;

  pnlQtdVariasChapasLote.Visible := (fCfgSis('MARMOR') = 'S') and
                                    (fCfgSis('CTRLCH') = '2') and
                                    cdsItens.Locate('GRAMAR', 'S', []);

  TFloatField(cdsItens.FieldByName('MLTVEN')).DisplayFormat := '#,####0.0000';

  pCarregaImpSeq();
  pSetEnabledImpSeq((Not fExpedicaoJaIniciada()));



  cdsItens.First;

  If fMarcaProdutoSemNecessidadeDeExpedicao Then
    pMarcarTodosProdutos(False, False, 0, True);

  If (fCfgSis('FTPDEX', varBoolean)) Then
    blnSitFinPedsSelOK := fValidaSituacaoFinanceiraPedidosSelecionados();

  btnMostrarCortados.Visible := (Assigned(FParams.stlPedidos)) And (FParams.stlPedidos.Count > 0);

  pnlTotalExpedido.Visible := fFindColumnByName(dbgItens, 'QTDEXP').Visible;
  pAtualizaInformacaoDoTotalExpedido;
end;

procedure TfrmFatExpedicaoItens.FormPaint(Sender: TObject);
begin
  inherited;
  If (blnFecharForm) Then
    Close;
end;

procedure TfrmFatExpedicaoItens.pEdtCodIteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_RETURN) Then
    If FParams.blnOndaSeparacao Then
      pExpedeItemOndaSep
    Else
      pExpedeItem;
end;

procedure TfrmFatExpedicaoItens.FormActivate(Sender: TObject);
begin
  inherited;

  If (edtCodIte.Visible) And (edtCodIte.Enabled) And (Not edtCodIte.ReadOnly) Then
    pSetFocus(edtCodIte);

  If VS_strTipDEx = '1' Then
    edtCodIte.OnKeyDown := pEdtCodIteKeyDown;

  If FParams.blnColetor And (Self.Tag <> 1) Then
  Begin
    Self.Tag := 1;
    btnExpAut.Visible     := False;
    btnEtiqueta.Visible   := False;
    btnMarcarTudo.Visible := False;

    fFindColumnByName(dbgItens,'DESITE').Width := 200;

    btnSair.Left := btnConfirma.Left + btnConfirma.Width + 2;

    pnlRodape.Height := pnlRodape.Height + edtQtdIte.Height + 2;
    edtQtdIte.Left   := edtCodIte.Left;
    edtQtdIte.Top    := edtQtdIte.Top + edtQtdIte.Height + 1;

    lblQtde.Left     := lblCodBar.Left;
    lblQtde.Width    := lblCodBar.Width;
    lblQtde.Top      := edtQtdIte.Top + ( (edtQtdIte.Height - edtQtdIte.Height) Div 2) + 1;

    pnlQtdVariasChapasLote.Top := edtQtdIte.Top - 1;
    pnlQtdVariasChapasLote.Left := edtQtdIte.Left + edtQtdIte.Width + 20;

    lblLimparExpedido.Height := lblLimparExpedido.Height * 2;

    Self.Position    := poDesigned;
    Self.WindowState := wsMaximized;
  End;

  pExpedirSubItensEstruturaOndaSeparacao;
end;

procedure TfrmFatExpedicaoItens.pExpedirSubItensEstruturaOndaSeparacao();
Var
  LFrmExpSubItens: TfrmFatExpedicaoSubItens;
begin
  If Not FParams.blnOndaSeparacao Then
    Exit;

  If FParams.blnApenasFaturarJaExpedidos Then
    Exit;

  If VS_strTipExp <> TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO Then
    Exit;

  If FParams.blnExpedicaoDocumentoFaturadoAutomaticamente Then
    Exit;

  If fCfgSis('EMOPPD', VarBoolean) Then
    Exit;

  pCriarFormularios(TfrmFatExpedicaoSubItens, LFrmExpSubItens);
  Try
    LFrmExpSubItens.strNumDoc := TPedidoVenda(FParams.stlPedidos.Objects[0]).strNumDoc;
    LFrmExpSubItens.strEspDoc := TPedidoVenda(FParams.stlPedidos.Objects[0]).strEspDoc;
    LFrmExpSubItens.strCodEmp := TPedidoVenda(FParams.stlPedidos.Objects[0]).strCodEmp;

    If FParams.TipoItemDoPedidoOndaSeparacao = opSubItemDeItemInseridoNoPedido Then
      LFrmExpSubItens.strCodBarrasExp := FParams.strCodBarrasExp;

    LFrmExpSubItens.strSQLFiltroProdutosExpedicaoItens := fFiltroProdutosExpedicaoItens(False,
                                                                                        FParams.blnUsaImpressaoSeparacaoPorLocal,
                                                                                        FParams.blnExiPedRetiraExpAntFat,
                                                                                        FParams.blnApenasFaturarJaExpedidos);

    LFrmExpSubItens.ShowModal;

    If Not LFrmExpSubItens.blnConferido Then
    Begin
      tmrClose.Enabled := True;
      Exit;
    End;

    LFrmExpSubItens.cdsSubitens.First;
    While Not LFrmExpSubItens.cdsSubitens.Eof Do
    Begin
      If cdsItens.Locate('FDOINC', LFrmExpSubItens.cdsSubitens.FieldByName('SEQFDO').AsString, []) Then
      Begin
        pMarcarTodosProdutos(True, True);
      End;
      LFrmExpSubItens.cdsSubitens.Next;
    End;

  Finally
    pFreeAndNil(LFrmExpSubItens);
  End;

  If FParams.blnOndaSeparacao And fTodosItensForamExpedidos Then
  Begin
    tmrConfirmarAutomaticamente.Enabled := True;
  End;

end;

procedure TfrmFatExpedicaoItens.btnVisualizarVlrMinEntClick(Sender: TObject);
begin
  inherited;
  pCriarFormularios(TfrmFatVerItensDocRom, frmFatVerItensDocRom);
  try
    frmFatVerItensDocRom.blnClientesExpedicao := True;
    frmFatVerItensDocRom.pConfiguraGridClientesExpedicao;
    pAlimentarDatasetValoresMinimos;
    frmFatVerItensDocRom.dbgItens.DataSource := dtsValoresCli;
    frmFatVerItensDocRom.ShowModal;
  finally
    pFreeAndNil(frmFatVerItensDocRom);
  end;
end;

procedure TfrmFatExpedicaoItens.btnCfgExpItensClick(Sender: TObject);
  Var
    frmConfigExpedicaoItens : TfrmConfigExpedicaoItens;
begin
  inherited;
  If Not btnCfgExpItens.Visible Then
    Exit;
  pCriarFormularios(TfrmConfigExpedicaoItens, frmConfigExpedicaoItens);
  try
    frmConfigExpedicaoItens.frmFatExpedicaoItens := Self;
    frmConfigExpedicaoItens.ShowModal;
    if frmConfigExpedicaoItens.blnConfirma then
    begin
      TFrmGravando.fExecutarModal( pGravarConfiguracoesExpedicaoItens, 'Aguarde... Gravando Configurações!', '');
      dbgItens.Font.Size    := frmConfigExpedicaoItens.speTamanhoFonte.Value;
      dbgEtiCaixa.Font.Size := frmConfigExpedicaoItens.speTamanhoFonte.Value;

      strIndexField := cdsItens.IndexName;
      pnlTotalExpedido.Visible := fFindColumnByName(dbgItens, 'QTDEXP').Visible;
    end;
  finally
    pFreeAndNil(frmConfigExpedicaoItens);
  end;
end;

procedure TfrmFatExpedicaoItens.btnConfirmaClick(Sender: TObject);
begin
  dtsItens.DataSet := nil;

  pCriarFormularios(TfrmGravando, frmFechamentoVenda);
  Try
    untBancos.pInformarReutilizarImpressoraSelecionadaBoleto(True);
    frmFechamentoVenda.fExecutarAcao := fConfirmarExpedicao;
    frmFechamentoVenda.ShowModal;
  Finally
    untBancos.pInformarReutilizarImpressoraSelecionadaBoleto(False);
    pFreeAndNil(frmFechamentoVenda);
  End;

  dtsItens.DataSet := cdsItens;
end;

procedure TfrmFatExpedicaoItens.btnDigCodBarLocFisClick(Sender: TObject);
var
  varParametro : TOpeProdParam;
begin
  inherited;
  if (not btnDigCodBarLocFis.Enabled) or (not btnDigCodBarLocFis.Visible) then
    Exit;

  If (Not cdsItens.Active) Or (cdsItens.IsEmpty) Then
  Begin
    Exit;
  End;

  varParametro.blnTraBar := False;
  varParametro.strCodBar := cdsItens.FieldByName('CODITE').AsString;
  pOpeProdParam(DigCodBarLocFis, varParametro);
end;

procedure TfrmFatExpedicaoItens.pOnCalculaTotGer(const item: TDadosFechamento; index, count: Integer; AInfo: String = '');
  Var
    strInfoProcessamento: String;
begin
  If Assigned(frmFechamentoVenda) Then
  Begin
    strInfoProcessamento := 'Aguarde, Recalculando valor do produto %s...';

    If AInfo.IsEmpty Then
      AInfo := strInfoProcessamento;

    pInformacao(Format(AInfo, [item.strCodIte + '-' + fPadR(item.strDesIte, 10)]), frmFechamentoVenda.pgbStatus);
    pProgresso(Succ(index), count -1, frmFechamentoVenda.pgbStatus);
  End;
end;

function TfrmFatExpedicaoItens.fRetornaCelCli: String;
begin
   Result := cdsItens.FieldByName('CELCLI').AsString;
end;

function TfrmFatExpedicaoItens.fRetornaSeparadorColetor (strNumdoc, strEmpDoc, strEspDoc : String): String;
  Var
    qryAuxSep: TUniQuery;
begin
  qryAuxSep := fCriaQuery(Self);
  qryAuxSep.SQL.Clear;
  qryAuxSep.SQL.Text := 'SELECT L.LDO_CODSEP '+
                     'FROM LOTDOR L '+
                     'INNER JOIN FATDOR F ON F.AUTOINCREM = L.LDO_SEQFDO '+
                     'WHERE F.FDO_NUMDOC = :NUMDOC '+
                     '  AND F.FDO_CODEMP = :CODEMP '+
                     '  AND F.FDO_ESPDOC = :ESPDOC ';

  qryAuxSep.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAuxSep.ParamByName('CODEMP').AsString := strEmpDoc;
  qryAuxSep.ParamByName('ESPDOC').AsString := strEspDoc;

  qryAuxSep.Open;

  Result :=  qryAuxSep.FieldByName('LDO_CODSEP').AsString;
end;

function TfrmFatExpedicaoItens.fRetornaSeparadorColetorSepDor: String;
  Var
    qryAuxSep: TUniQuery;
begin
  Result := '';
  qryAuxSep := fCriaQuery(Self);

  Try
    qryAuxSep.Close;
    qryAuxSep.SQL.Clear;
    qryAuxSep.SQL.Text := 'SELECT                            '+
                          '  SEP_OPECON                      '+
                          'FROM                              '+
                          '  SEPDOR                          '+
                          '  INNER JOIN FATDOR F             '+
                          '    ON F.AUTOINCREM = SEP_SEQFDO  '+
                          'WHERE F.FDO_NUMDOC = :NUMDOC      '+
                          '  AND F.FDO_CODEMP = :CODEMP      '+
                          '  AND F.FDO_ESPDOC = :ESPDOC      ';

    qryAuxSep.ParamByName('NUMDOC').AsString := FParams.strNumDoc;
    qryAuxSep.ParamByName('CODEMP').AsString := FParams.strCodEmp;
    qryAuxSep.ParamByName('ESPDOC').AsString := FParams.strEspDoc;

    qryAuxSep.Open;

    If (Not qryAuxSep.IsEmpty) Then
      Result := qryAuxSep.FieldByName('SEP_OPECON').AsString;
  Finally
    FreeAndNil(qryAuxSep);
  End;
end;

function TfrmFatExpedicaoItens.fProcessouNoColetor(strAutInc: String):Boolean;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT COUNT(C.AUTOINCREM) AS COLETADOS ');
    qryGen.SQL.Add(' FROM FATGOR F ');
    qryGen.SQL.Add(' INNER JOIN FATDOR D ON D.FDO_SEQGER = F.AUTOINCREM ');
    qryGen.SQL.Add(' INNER JOIN CONDOR C ON C.CON_SEQFDO = D.AUTOINCREM ');
    qryGen.SQL.Add(' WHERE F.AUTOINCREM = :AUTINC ');
    qryGen.ParamByName('AUTINC').AsString := strAutInc;
    qryGen.Open;

    Result := qryGen.FieldByName('COLETADOS').AsInteger > 0;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmFatExpedicaoItens.pConfirmandoExpedicao(pgbStatus: TcxProgressBar = nil);
  Var
    fatVenda      : TFatVenda;
    stlItensNaoExp: TStringList;
    objPedido     : TPedidoVenda;
    intIdxPed     : Integer;
    fltDesCon     : Double;
    fltQtdExp     : Double;
    strObsExp     : String;
    strCodEmb     : String;
    fltTotDup     : Double;
    blnExpedicaoPedidoBaixaEntregaFuturaComTipPedPreenchido: Boolean;
    blnUsaValorDeFltTotalFreteNaExpedicao: Boolean;
    fltTotalFreteNaExpedicao: Double;
    fltTotalDesEspNaExpedicao: Double;
    fltTotalDesAceNaExpedicao: Double;

    fltTotalItensNaExpedicao: Double;
    strEspDocSav  : String;
    objOcoCrm     : TAtuOcoCrm;

    blnDesmembrarVenda: Boolean;

    objEmiNFEsp   : TEmissaoNotaEspecial;
    blnSolicitouTelaSepOpeExp: Boolean;
    dtaDtaBas: TDateTime;
    qryUpdate     : TUniQuery;

    blnResolveuConflitos : Boolean;
    intIdxCmbAux : Integer;

    strNumPedTmp: String;
    strEmpPedTmp: String;

    blnEhUmaExpedicaoTotalDeMaisDeUmPedidoDiferente: Boolean;

    strCodCnd: String;
    strConPag: String;
    strCodFpg: String;

    blnUtilizarValorTotalAdiantamento: Boolean;
    blnFretePorTranspRegiao: Boolean;
    blnFretePorTranspCidade: Boolean;

    blnEhNotaEspecialFatorPorValor: Boolean;

    blnCliCon,
    blnCliBal: Boolean;

    blnRecalcularCX : Boolean;
    blnRecalcularVL : Boolean;

    LblnUtilizarDataEmissaoCalcularDiaVencimento: boolean;

    frmDigTransportadora : TfrmDigTransportadora;
    fltFrete : Double;
    blnAbortarFaturamento: Boolean;
    blnVaiFaturarParcialEmFF: Boolean;

    fltPesBru: Double;
    fltPesLiq: Double;
    blnOcorreuErroAoGerarNotaEspecial: Boolean;
    LMensagem: String;
    intIndice: Integer;

    function fPermiteCupomFiscalComIPI: Boolean;
    begin
      Result := False;

      If not Assigned(fatVenda) Then
        Exit;

      If not (fatVenda.strEspDoc = 'IF') Then
        Exit;

      If not fCfgSis('IMPDIR', varBoolean) Then
        Exit;

      If not fCfgSis('CUPIPI', varBoolean) Then
        Exit;

      Result := True;
    end;

    function fVerificaSituacaoRegular: Boolean;
    var strMsgRetorno: string;
    begin
      Result := True;

      If fatVenda.strEspDoc <> 'NF' Then
        Exit;

      If fatVenda.intCgcCpf <> 1 Then
        Exit;

      If fClienteConsumidor(fatVenda.strCliOri, True, False) Then
        Result := TConsultaCadastroFit.VerificaSituacaoRegularConfirmacao(fatVenda.strCliCgc, fatVenda.strCliEst, fatVenda.strCliIes, strMsgRetorno)
      Else
        Result := TConsultaCadastroFit.VerificaSituacaoRegularConfirmacao(fatVenda.strCodCli, False, strMsgRetorno);

      If Not Result Then
      Begin
        If fEmptyStr(strMsgRetorno) Then
          strMsgRetorno := 'Erro ao realizar consulta da situação regular do cliente.';

        fMensagem('ATENÇÃO!', strMsgRetorno, ['&Ok']);
      End;
    end;

    function fSetaSeparadorConferente: Boolean;
      Var
        blnAuxiliar: Boolean;
        strSepCol  : String;
    begin
      Result := True;
      strSepCol := EmptyStr;

      iF fSelecaoMultipla Then
        Exit;

      If (fCfgSis('SEPCOL') = 'S') And ((FParams.VS_strTipExpInterna = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or
                                        (FParams.VS_strTipExpInterna = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO )) Then
      Begin
        strSepCol := fRetornaSeparadorColetor(FParams.strNumDoc, FParams.strCodEmp, FParams.strEspDoc);

        If (fEmptyStr(strSepCol)) Then
          strSepCol := fRetornaSeparadorColetorSepDor;

        If not fEmptyStr(strSepCol) Then
          fatVenda.FSepExp := strSepCol;
      End;

      If (fCfgSis('EXSECO') = 'S') And (Not FParams.blnApenasFaturarJaExpedidos) Then
      Begin
        If (fSolicitaConferenteSeparador(fatVenda.FOpeExp, fatVenda.FSepExp, strObsExp, strCodEmb, blnAuxiliar)) Then
        Begin
          blnSolicitouTelaSepOpeExp := True;
          fatVenda.strNomExp := fRetNomVendRep(fatVenda.strOpeExp);
          fatVenda.strNomSep := fRetNomVendRep(fatVenda.strSepExp);
          strCodConferente := fatVenda.strOpeExp;
          strCodSeparador  := fatVenda.strSepExp;

          If Assigned(objConDor) Then
            objConDor.pSetOpeCon(fatVenda.FOpeExp);
        End
        Else
        Begin
          fMensagem('ATENÇÃO!', 'O Separador e o Conferente não estão preenchidos! Favor verificar.', ['&Ok']);
          Result := False;
        End;
      End;
    end;

    procedure pAtualizaSepOpeExpPedido(strAutInc, strCodCon, strCodSep, strObsExp: String);
      var
        qryAux: TUniQuery;
    begin
      qryAux := fCriaQuery(Nil);
      Try
        qryAux.Close;
        qryAux.SQL.Text := ' UPDATE FATGOR INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ' +
                           '    SET FGO_OPEEXP = :OPEEXP, ' +
                           '        FGO_SEPEXP = :SEPEXP  ' +
         IIF(strObsExp.IsEmpty,'',',FGO_OBSEXP = :OBSEXP  ')+
                           '  WHERE FATGOR.AUTOINCREM = :AUTINC ';
        qryAux.ParamByName('AUTINC').AsString := strAutInc;

        If (Not strCodCon.IsEmpty) Then
          qryAux.ParamByName('OPEEXP').AsString := strCodCon;

        If (Not strCodSep.IsEmpty) Then
          qryAux.ParamByName('SEPEXP').AsString := strCodSep;

        If (Not strObsExp.IsEmpty) Then
          qryAux.ParamByName('OBSEXP').AsString := strObsExp;

        qryAux.ExecSQL;
        qryAux.Close;
      Finally
        FreeAndNil(qryAux);
      End;
    end;

    procedure pSetarLotesParaSeparacaoRomaneio;
    begin
      fatVenda.strNumLotSep := fRetNumLotesSep;
    end;

    procedure pAtualizarQuantidadeExpedidaItensPedido;
    begin
      If (FParams.VS_strTipExpInterna = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) And blnSolicitouTelaSepOpeExp And (cdsSetores.Active) and (not cdsSetores.IsEmpty) Then
        pAtualizaExpedicaoItens(fatVenda.FOpeExp, fatVenda.FSepExp, strObsExp, strCodEmb, False, fatVenda);
    end;

    procedure pLimparPesoDigitadoExpedicao;
    begin
      if (fCfgSis('PESEXP', varBoolean)) and (fCfgSis('TIPEXP', varString) = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) and (FParams.VS_strTipExpInterna = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) then
        pLimpaPesoTempItens;
    end;

    procedure pVerificarSeClienteTemPontosParaBrindes;
    var
      strNomCli: string;
    begin
      If blnDesmembrarVenda Then
        Exit;

      If FParams.blnOndaSeparacao Then
        Exit;

      If FParams.blnFaturandoTodosAutomaticamente Then
        Exit;

      If fatVenda.fEhVendaConcreto And FParams.blnSimplesRemessaConcreto Then
        Exit;

      Try
        strNomCli := fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [fatVenda.strCodCli]);
        blnCliCon := fClienteConsumidor(strNomCli, False, True);
        blnCliBal := fClienteConsumidor(strNomCli, True, False);
        If (Not blnCliCon) And (Not blnCliBal) Then
          pVerificarPromocaoBrindes('','', fatVenda.strCodCli, strNomCli)
        Else
        Begin
          pVerificarPromocaoBrindes(fatVenda.strNumDoc, fatVenda.strEspDoc, fatVenda.strCodCli, strNomCli);
        End;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmFatExpedicaoItens.pConfirmandoExpedicao: pVerificarSeClienteTemPontosParaBrindes]');
        End
      End;
    end;

    procedure pImprimirPedidosQuantidadePendente;
    begin
      {*********************************************}
      {* IMPRIME PEDIDOS COM A QUANTIDADE PENDENTE *}
      {******************************************PZ*}
      If (fCfgSis('UTIPEN', VarBoolean)) Then
      Begin
        If  (fCfgSis('TIPEXP') = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) Or
           ((fCfgSis('TIPEXP') = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And FParams.blnApenasFaturarJaExpedidos) Then
        Begin
          pImprimePedidosQtdePendente;
        End;
      End;
    end;

    procedure pMarcarDataExpedicaoPedidoFaturamentoAutomatico;
    var
      intContador: Integer;
    begin
      If fCfgSis('FATAUT', varBoolean) Then
      Begin
        If (Not FParams.blnExpPar) Then
        Begin
          For intContador := 0 To FParams.stlPedidos.Count -1 Do
          Begin
            objPedido := TPedidoVenda(FParams.stlPedidos.Objects[intContador]);
            pMarcarDataExpedicaoFaturamentoAutomatico('','','','',VS_Date,
                                                      objPedido.strNumDoc,
                                                      objPedido.strEspDoc,
                                                      objPedido.strCodEmp);
          End;
        End;
      End;
    end;

    procedure pEmitirNotaEspecialAposFaturamento;
    Var
      intContador: Integer;
    begin
      {**************************************}
      {* CASO JA FATUROU OS ITENS EXPEDIDOS *}
      {**********************************JC**}
      If (fatVenda.fEmiteNotaEspecialAposFaturamento(strEspDocSav)) Then
      Begin
        objEmiNFEsp := TEmissaoNotaEspecial.Create;
        Try
          For intContador := 0 To fatVenda.objFatVendaImp.ItemsCount -1 Do
            With fatVenda.objFatVendaImp[intContador] Do
              If Not objEmiNFEsp.fEmitirNotaEspecial(strNumDoc, strEspDoc, strEmpDoc,
                       fatVenda.strTipFatNEs, fatVenda.fltFatNot, fltPesBru,
                       fltPesLiq, Not blnAlterouVolumes, '', intQtdTra, blnImpEti, fltValAdt, fatVenda) Then
              Begin
                blnOcorreuErroAoGerarNotaEspecial := True;
              End;
        Finally
          objEmiNFEsp.Destroy;
        End;
      End;
    end;

    procedure pImprimirEtiquetaProdutosControlados;
    begin
      if (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) And (fCfgSis('EPCVEX', varBoolean)) then
        pImprimirEtiqVendasProdutosControlados;
    end;

    procedure pImprimirEtiquetasDespacho;
    var
      intContador: Integer;
      tpeResultadoEtiqueta: TResultadoEtiquetaUnificada;
    begin
      If (blnImpEti) And (Not fatVenda.blnEmitindoFFDaNotaEspecialFatorPorValor) And (Not fatVenda.blnGerarEtiquetaDespachoNFEspecialFatorSemDUPREC) Then
      Begin
        If (fSelecaoMultipla) And (FParams.stlListaClientes.Count > 1) And (Length(arrEtiquetaImpressaoMultiSelecao) > 0) Then
        Begin
          arrEtiquetaImpressaoMultiSelecao[Length(arrEtiquetaImpressaoMultiSelecao) - 1].strNumDoc := fatVenda.strNumDoc;
          arrEtiquetaImpressaoMultiSelecao[Length(arrEtiquetaImpressaoMultiSelecao) - 1].strEspDoc := fatVenda.strEspDoc;
          arrEtiquetaImpressaoMultiSelecao[Length(arrEtiquetaImpressaoMultiSelecao) - 1].strCodEmp := fatVenda.strEmpDoc;
          arrEtiquetaImpressaoMultiSelecao[Length(arrEtiquetaImpressaoMultiSelecao) - 1].strCodCli := fatVenda.strCodCli;
          arrEtiquetaImpressaoMultiSelecao[Length(arrEtiquetaImpressaoMultiSelecao) - 1].strNomCli := fRetNomCliente(fatVenda.strCodCli);
        End
        Else
        Begin
          For intContador := 0 To fatVenda.objFatVendaImp.ItemsCount -1 Do
          Begin
            With fatVenda.objFatVendaImp[intContador] Do
              If intQtdTra > 0 Then
                pImprimeEtiquetaDespacho(strNumDoc, strEspDoc, strCodCli, intQtdTra, strEmpDoc, tpeResultadoEtiqueta,
                                         False, intQtdTraSepExc, intQtdTraSepNExc, '', strSerFsc);
          End;
        End;
      End;

      If (blnImpEtiDespachoVolumeComposto) And
         (Not fatVenda.blnGerarEtiquetaDespachoNFEspecialFatorSemDUPREC) And
         (Not fatVenda.blnEmitindoFFDaNotaEspecialFatorPorValor) Then
      Begin
        For intContador := 0 To fatVenda.objFatVendaImp.ItemsCount -1 Do
        Begin
          With fatVenda.objFatVendaImp[intContador] Do
            pImprimeEtiquetaDespacho(strNumDoc, strEspDoc, strCodCli, intQtdTra, strEmpDoc, tpeResultadoEtiqueta,
                                     blnImpEtiDespachoVolumeComposto, intQtdTraSepExc, intQtdTraSepNExc, '', strSerFsc);
        End;
      End;
    end;

    procedure pMensagemDocumentoGeradoComSucesso;
    begin
      If blnDesmembrarVenda Then
        Exit;

      If FParams.blnOndaSeparacao Then
        Exit;

      If FParams.blnFaturandoTodosAutomaticamente Then
        Exit;

      If fatVenda.fEhVendaConcreto And FParams.blnSimplesRemessaConcreto Then
        Exit;

      If (FParams.stlListaClientes.Count = 1) Then
        fMensagem('', 'Documento ' + fatVenda.strNumDoc + '-' + fatVenda.strEspDoc + ' gerado com sucesso!', ['&O k']);

      SetLength(arrDocumentoGerados, Length(arrDocumentoGerados)+1);
      arrDocumentoGerados[Length(arrDocumentoGerados)-1] := fatVenda.strNumDoc + '-' + fatVenda.strEspDoc;
    end;

    procedure pLimparQuantidadeExpedidaParaContinuarExpedindo;
    begin
      {***************************************************************************************}
      {* CASO JA FATUROU OS ITENS EXPEDIDOS, LIMPA A QTD PARA CONTINUAR EXPEDINDO O RESTANTE *}
      {************************************************************************************JC*}
      If FParams.blnApenasFaturarJaExpedidos Then
      Begin
        cdsItens.First;
        While (Not cdsItens.Eof) Do
        Begin
          If Not fManterItensConferidos Then
            pAtualizaQtdExpItemPedido(cdsItens.FieldByName('AUTOINCREM').AsString, 0);

          pFatCaixaPedidoAutInc(FParams.stlPedidos, cdsItens.FieldByName('AUTOINCREM').AsString);
          cdsItens.Next;
        End;
        pFaturarCaixasPedidos(FParams.stlPedidos, fatVenda.strNumDoc, strEspDocSav, fatVenda.strEmpDoc);
      End;
    end;

    procedure pSetarEspecieParaEmissaoNotaEspecial;
    begin
      If (fatVenda.fMeiaNotaComNotaNormalGerandoApenasNF(fatVenda.blnDesmembrarMeiaNotaComNotaNormal, fatVenda.arrMatItens[0].blnMeiaNotaFatorExpedicao)) Then
        fatVenda.strEspDoc := 'NF';
    end;

    procedure pGravarCONDOR_AUTCOM;
    begin
      If ((fCfgSis('TIPEXP') = (TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO)) OR (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO)) And (Assigned(cdsItens)) Then
      Begin
        objConDor.pSetClientItens(cdsItens);
        objConDor.pGravar;
      End;
    end;

    procedure pGravarSEPDOR_AUTCOM;
      Var
        objSepDor : TSepDor;
    begin
      objSepDor := TSepDor.Create;
      Try
        objSepDor.pIniciou;
        objSepDor.pSetOpeCon(strCodSeparador);
        objSepDor.pSetNumDoc(FParams.strNumDoc);
        objSepDor.pSetEspDoc('PD');
        objSepDor.pSetEmpDoc(FParams.strCodEmp);
        objSepDor.pGravar;
      Finally
        If Assigned(objSepDor) Then
          FreeAndNil(objSepDor);
      End;
    end;

    procedure pSucessoGravarArquivos;
    begin
      SetLength(arrLogLib, 0);
      Self.FConfirmou := True;
      Self.Close;
    end;

    procedure pAtualizarSeparadorConferentePedido;
    var
      intContador: Integer;
    begin
      If (FParams.VS_strTipExpInterna = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) And blnSolicitouTelaSepOpeExp Then
      Begin
        For intContador := 0 To FParams.stlPedidos.Count -1 Do
        Begin
          objPedido := TPedidoVenda(FParams.stlPedidos.Objects[intContador]);
          pAtualizaSepOpeExpPedido(objPedido.strSeqGer, fatVenda.FOpeExp, fatVenda.FSepExp, strObsExp);
        End;
      End;
    end;

    procedure pDeletaItensNaoExp;
    begin

      If (stlItensNaoExp.Count > 0) Then
      Begin

        While Not cdsVenda.Eof Do
        Begin
          If stlItensNaoExp.IndexOf(cdsVenda.FieldByName('AUTOINCREM').AsString) >= 0 Then
            cdsVenda.Delete;
          cdsVenda.Next;
        End;

        pAtualizaTemporaria(fatVenda);
      End;
    end;

    procedure pDesalibitarCampos;
    begin
      cdsItens.DisableControls;
      cdsItens.First;

      edtCodIte.Enabled     := False;
      edtQtdIte.Enabled     := False;
      edtQtdChapas.Enabled  := False;
      btnConfirma.Enabled   := False;
      If btnExpAut.Visible Then
        btnExpAut.Enabled   := False;
      btnQuantidade.Enabled := False;
    end;

    procedure pHabilitaCampos;
    Begin
      pEnableCdsItens();
      edtCodIte.Enabled     := True;
      edtQtdIte.Enabled     := fVerificaAcessoSistema('QTDEXP');
      edtQtdChapas.Enabled  := True;
      btnConfirma.Enabled   := True;
      If btnExpAut.Visible Then
        btnExpAut.Enabled   := True;
      btnQuantidade.Enabled := True;
      pSetFocus(edtCodIte);
    End;

    function fGravarArquivos: Boolean;
    var
      frmGravando: TfrmGravando;
    begin
      Result := False;
      Try
        pCriarFormularios(TfrmGravando,frmGravando);
        frmGravando.strChave := 'FATVENDAS';

        If fatVenda.cdsExpIte.Active Then
          fatVenda.cdsExpIte.EmptyDataSet;

        pCloneDataSet(fatVenda.cdsExpIte, cdsItens);

        If fatVenda.fEhVendaConcreto And FParams.blnSimplesRemessaConcreto And (fatVenda.strEspDoc = 'NF') Then
        Begin
          fatVenCCR := fatVenda;
          fatVenda.fCarregaEstrutura := fCarregaEstrutura;
          frmGravando.fExecutarAcao  := fatVenda.fGravaNotaDeConcreto;
        End
        Else
          frmGravando.fExecutarAcao := fatVenda.fGravaArquivosDesmembrandoVenda;

        frmGravando.ShowModal;

        Result := frmGravando.blnConfirma;

        if (Result) and (fCfgSis('TIPEXP') <> TIPEXP_NAO_UTILIZAR_EXPEDICAO) and (Not FParams.blnApenasFaturarJaExpedidos) then
          pGravarInformacoesSeparacao;

        if Result then
          pGravaControleLALAMOVE(fatVenda.strNumDoc, fatVenda.strEspDoc, fatVenda.strEmpDoc, fatVenda.strCodCli);

        If (frmGravando.blnConfirma) Then
        Begin
          If VS_blnPainelEcommerce And (StrToIntDef(cdsItens.FieldByName('FGO_PEDSIT').AsString,0) > 0) Then
          Begin
            qryUpdate := fCriaQuery(Self);
            Try
              With qryUpdate, SQL Do
              Begin
                Close;
                Clear;
                Add(' UPDATE FATGOR SET          ');
                Add(' FGO_LIBCOM = :LIBCOM,      ');
                Add(' FGO_OPELIC = :OPELIC,      ');
                Add(' FGO_DIGLIC = :DIGLIC,      ');
                Add(' FGO_HORLIC = :HORLIC,      ');
                Add(' FGO_DTALIC = :DTALIC,      ');
                Add(' FGO_LIBERA = :LIBCOM,      ');
                Add(' FGO_OPELIB = :OPELIC,      ');
                Add(' FGO_DIGLIB = :DIGLIC,      ');
                Add(' FGO_HORLIB = :HORLIC,      ');
                Add(' FGO_DTALIB = :DTALIC       ');
                Add(' WHERE AUTOINCREM <> :AUTINC');
                Add('   AND FGO_PEDSIT = :PEDSIT ');
                Add('   AND FGO_LIBCOM = 0       ');

                qryUpdate.ParamByName('LIBCOM').AsInteger  := 1;
                qryUpdate.ParamByName('OPELIC').AsString   := strLoginUsuarioLogado;
                qryUpdate.ParamByName('DIGLIC').AsString   := strLoginUsuarioLogado;
                qryUpdate.ParamByName('HORLIC').AsDateTime := fNow;
                qryUpdate.ParamByName('DTALIC').AsDateTime := fNow;
                qryUpdate.ParamByName('AUTINC').AsString   := cdsItens.FieldByName('FGOINC').AsString;
                qryUpdate.ParamByName('PEDSIT').AsInteger  := cdsItens.FieldByName('FGO_PEDSIT').AsInteger;
                qryUpdate.ExecSQL;

              End;

            Finally
              FreeAndNil(qryUpdate);
            End;
          End;
        End;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message,'[btnConfirmaClick - frmGravando]');
        End;
      End;
      pFreeAndNil(frmGravando);
    end;

    function fCarregaValorRecebido(): Boolean;
    var
      strMsgErr: String;
    begin
      Result := True;

      If fTemInconsistenciaVarValRecOuValAdt(strMsgErr) Then
      Begin
        fMensagem('ATENÇÃO!','Houve uma falha ao carregar o valor de '+strMsgErr+'.'+#10#13+
                             'Feche a tela de expedição e carregue novamente o pedido. Se o problema persistir, entre em contato com a Citel!', ['&Ok']);
        Result := False;
        Exit;
      End;

      If FParams.blnTemRec Then
        fatVenda.fltDupRec := fatVenda.fTotalDuplicataQuitada(FParams.strCtrNumDup,
                                                              FParams.strCtrEspDoc,
                                                              FParams.strCtrCodEmp,
                                                              FParams.strCtrCodCli);
      If FParams.blnTemAdt Then
      Begin
        fatVenda.recValAdt := TAdiantamento.fGetTotaisAdiantamento(FParams.strCtrNumDup, FParams.strCtrEspDoc, FParams.strCtrCodEmp);
        fatVenda.fltValAdt := fatVenda.recValAdt.fltValLan;

        fatVenda.blnResCaiAdt := TAdiantamento.fGetResCaiAdiantamento(FParams.strCtrNumDup, FParams.strCtrEspDoc, FParams.strCtrCodEmp, FParams.strCtrCodCli);
      End;
    End;

    function fGetTotalParcelasPedido: Double;
      Var
        intContador: Integer;
    begin
      Result := 0;
      For intContador := 0 To 23 Do
        Result := Result + fatVenda.arrDuplicataCND[intContador].curValor
    End;

    function fPedeDadosFiscais: Boolean;
    begin
      Result := (((fatVenda.strTipPed = 'A') And (fCfgSis('ADIEXP') = 'S') And (Not FParams.blnOndaSeparacao) And (Not FParams.blnFaturandoTodosAutomaticamente)) Or (blnEhNotaEspecialFatorPorValor));
    end;

    procedure pIniciarVariaveis;
    begin
      strCodIte:= EmptyStr;

      FConfirmou := False;

      FParams.strCodTraSel := EmptyStr;
      FParams.strConPagSel := EmptyStr;
      FParams.strForPagSel := EmptyStr;
      FParams.strCodCndSel := EmptyStr;

      FParams.blnCodTraDif := False;
      FParams.blnConPagDif := False;
      FParams.blnForPagDif := False;
      FParams.blnCodCndDif := False;

      blnSolicitouTelaSepOpeExp := False;
      dtaFinalConferencia := fNow;
      blnOcorreuErroAoGerarNotaEspecial := False;

      FParams.strNumPok := EmptyStr;
      FParams.strPedSit := EmptyStr;
      FParams.blnExpPar := False;
      FParams.blnExpediMult := fSelecaoMultipla;
      FParams.intQtdTraTmp := 0;
    end;

    procedure pImprimirEtiquetaDespachoExpedicaoDocumentoVenda;
    var
      tpeResultadoEtiqueta: TResultadoEtiquetaUnificada;
    begin
      If FParams.blnExpedicaoDocumentoFaturadoAutomaticamente Then
      Begin
        // Etiqueta antes da DANFE: com CFG_EDUNIF a DANFE pode sair embutida na
        // etiqueta, e so depois de imprimi-la se sabe se a separada e necessaria.
        // A decisao fica aqui, e nao na etiqueta, para a reimpressao pela tela de
        // etiqueta continuar imprimindo so a etiqueta.
        // A DANFE fica no Finally: uma excecao na etiqueta (hub, rede, gravacao do ZPL) e
        // relancada no faturamento automatico, e nao pode impedir a DANFE da nota autorizada.
        tpeResultadoEtiqueta := reuNaoAplicavel;
        Try
          If (fCfgSis('IEDFAU') = 'S') Then
            pImprimeEtiquetaDespacho(FParams.strNumDoc, FParams.strEspDoc, FParams.strCodCli, 0, Vs_strCodEmp, tpeResultadoEtiqueta);
        Finally
          If (tpeResultadoEtiqueta <> reuUnificada) Then
            pImprimirDANFE(FParams.strNumDoc, FParams.strEspDoc, FParams.strCodCli, Vs_strCodEmp, fCfgSis('SERFSC'),
                           tpeResultadoEtiqueta = reuNaoUnificada);
        End;
      End
      Else If (fCfgSis('IEDAEX') = 'S') Then
      Begin
        pImprimeEtiquetaDespacho(FParams.strNumDoc, FParams.strEspDoc, FParams.strCodCli, 0, Vs_strCodEmp, tpeResultadoEtiqueta);
      End;
    end;

    procedure pNotificarClienteBaixaEntregaFutura;
    begin
      if (FParams.blnBaiEntFut) then
      begin
        fDisparaWhatsappAutomatico(FParams.strNumDoc, 'EF', FParams.strEspDoc, EmptyStr, EmptyStr, EmptyStr, FParams.strCodCli, '', True, '', Nil, '', '', '', Self.UnitName);
        fDisparaEmailAutomatico(FParams.strNumDoc, 'EF', FParams.strEspDoc, EmptyStr, EmptyStr, EmptyStr, FParams.strCodCli);
        fDisparaSMSAutomatico(FParams.strNumDoc, 'EF', FParams.strEspDoc, EmptyStr, EmptyStr, EmptyStr, FParams.strCodCli);
      end;
    end;

    procedure pNotificarClienteExpedicaoDocumentoVenda;
    begin
      pRetNumeroPedidoVenda(FParams.strNumDoc, FParams.strEspDoc, Vs_strCodEmp, FParams.strCodCli, strNumPedTmp, strEmpPedTmp);
      fDisparaWhatsappAutomatico(FParams.strNumDoc, 'E2', FParams.strEspDoc, strNumPedTmp, 'PD', strEmpPedTmp, FParams.strCodCli, '', True, '', Nil, '', '', '', Self.UnitName);
      fDisparaEmailAutomatico(FParams.strNumDoc, 'E2', FParams.strEspDoc, strNumPedTmp, 'PD', strEmpPedTmp, FParams.strCodCli);
      fDisparaSMSAutomatico(FParams.strNumDoc, 'E2', FParams.strEspDoc, strNumPedTmp, 'PD', strEmpPedTmp, FParams.strCodCli);
    end;

    procedure pNotificarClienteFaturamentoPedidoExpedicao;
    var
      intContador: Integer;
    begin
      For intContador := 0 To FParams.stlPedidos.Count -1 Do
      Begin
        objPedido := TPedidoVenda(FParams.stlPedidos.Objects[intContador]);
        fDisparaWhatsappAutomatico(objPedido.strNumDoc, 'E4', objPedido.strEspDoc, '', 'CF', '', FParams.strCodCli, '', True, '', Nil, '', '', '', Self.UnitName);
        fDisparaEmailAutomatico(objPedido.strNumDoc, 'E4', objPedido.strEspDoc, '', 'CF', '', FParams.strCodCli);
        fDisparaSMSAutomatico(objPedido.strNumDoc, 'E4', objPedido.strEspDoc, '', 'CF', '', FParams.strCodCli);

        objConDor.pSetNumDoc(objPedido.strNumDoc);
        objConDor.pSetEspDoc(objPedido.strEspDoc);
        objConDor.pSetEmpDoc(objPedido.strCodEmp);
        objConDor.pGravar;
      End;
    end;

    procedure pGerarOcorrenciaCrmPedidoConferido;
    var
      intContador: Integer;
    begin
      If (VS_strHabilitarCRM) And (Not fEmptyStr(fCfgSis('VENORC', varString))) And (Not fEmptyStr(fCfgSis('VENPED', varString))) Then
      Begin
        For intContador := 0 To FParams.stlPedidos.Count -1 Do
        Begin
          objPedido := TPedidoVenda(FParams.stlPedidos.Objects[intContador]);
          objOcoCrm := fAtualizaInformacoesCRM(objPedido.strNumDoc, objPedido.strEspDoc, objPedido.strCodEmp, objPedido.strCodCli, objPedido.strNumDoc, objPedido.strEspDoc, strLoginUsuarioLogado,afcPedidoConferido);
          objOcoCrm.pProcessaFatOcorrenciasCRM;
          FreeAndNil(objOcoCrm);
        End;
      End;
    end;

    procedure pCriarObjetoFatVenda;
    begin
      pCriarCdsVenda(Self);

      if FParams.blnExpedicaoDePedidoDeConsignacao then
        fatVenda := TFatVenda.CreateInstance('CS')
      else
        fatVenda := TFatVenda.CreateInstance('CP');

      if (fCfgSis('NUMSER', varBoolean)) then
        begin
          pCloneDataSet(fatVenda.objFatSerieItem.cdsFatSeries, objFatSerieItem.cdsFatSeries);
          pCloneDataSet(fatVenda.objFatSerieItem.cdsSeries, objFatSerieItem.cdsSeries);
        end;

      fatVenda.strOpFaEx := strLoginUsuarioLogado;
      fatVenda.strOpcDocTrue := 'EI';
      fatVenda.blnExpedi := True;
      fatVenda.objExpedicao := Self.FParams;
      fatVenda.blnVerEstOrc := False;
      pAtualizaTemporaria(fatVenda);
      fatVenda.strNomeForm := 'frmFatVendas';
      fatVenda.blnEhFechamentoVenda := False;

      fatVenda.blnImprimeSep := fCfgSis('SEPAUT', varBoolean);

      fatVenda.fltDesEsp := 0.0;

      fatVenda.fltValMor := fCfgSis('TAXDIA', varDouble);

      fatVenda.strPedExp := '';
      fatVenda.strDocExp := '';

      fatVenda.strCliCel := fRetornaCelCli;

      fatVenda.strOpeExp := strLoginUsuarioLogado;
      fatVenda.strSepExp := IIF(FParams.blnFatAut, FParams.strSeparador, '');

      fatVenda.objCodBar := objCodBar;
    end;

    procedure pLiberarObjetoFatVenda;
    begin
      If Assigned(fatVenda) Then
      Begin
        FreeAndNil(fatVenda);
        pFreeCdsVenda;
      End;
    end;

    function fConfirmarExpedicaoDocumentoVenda: Boolean;
    begin
      Result := True;

      If (Self.FConfirmou) Then
        Exit(True);

      If (Not fSetaSeparadorConferente) Then
        Exit(False);

      If fConfirmaDocumento(fatVenda.strSepExp, FParams.blnExpPar, fatVenda.strOpeExp, blnSolicitouTelaSepOpeExp, cdsSetores, strObsExp, strCodEmb) Then
      Begin
        pGravarInformacoesSeparacao;
        pImprimirEtiquetaDespachoExpedicaoDocumentoVenda;
        pNotificarClienteExpedicaoDocumentoVenda;
      End
      Else
        fMensagem('', 'Não foi possível confirmar o documento! Por favor, verifique.', ['&Ok']);
    end;

    procedure pCriarFormularioResolveConflitoPedidos;
    begin
      frmFatResolveConflitoPedidos := nil;
      If (fExpedicaoPorPedido) And
         ( (fCfgSis('TREXCP') = 'S') Or (AnsiMatchStr(fCfgSis('CNEXCP'), ['S', 'C'])) ) Then
      Begin
        pCriarFormularios(TfrmFatResolveConflitoPedidos, frmFatResolveConflitoPedidos);
        frmFatResolveConflitoPedidos.fatVenda := fatVenda;
        frmFatResolveConflitoPedidos.strOpcDoc := 'EX';
      End;
      FParams.objResolveConflitosPedido := frmFatResolveConflitoPedidos;
    end;

    procedure pLimparVariaveisNumeroPedidoFatVenda;
    begin
      If (fatVenda.strTipOpe <> 'C') Or
         (Not fEhDocumentoContaOrdemComRemessa(
                fatVenda.strNumOrc, fatVenda.strEspOrc)) Then
      Begin
        fatVenda.strNumOrc := '';
        fatVenda.strEspOrc := '';
        fatVenda.strEmpOri := '';
      End;
    end;

    function fResolverConflitosCondicaoFormaPagamento: Boolean;
    begin
      Result := True;
      If Assigned(frmFatResolveConflitoPedidos) and
         ((FParams.blnConPagDif) Or (FParams.blnForPagDif)) and
         (fCfgSis('CNEXCP') = 'C' {Permitir maior prazo}) Then
      Begin
        if fVerificaConPagMaiorPrazo(fatVenda.fltTotGer, strCodCnd, strConPag, strCodFpg) then
        begin
          fatVenda.strCodCnd := strCodCnd;
          fatVenda.strConPag := strConPag;
          fatVenda.strCodFpg := strCodFpg;
        end
        else
        begin
          frmFatResolveConflitoPedidos.tipConflPedido := cpCondicao;
          frmFatResolveConflitoPedidos.ShowModal;
          blnResolveuConflitos := frmFatResolveConflitoPedidos.blnConfirma;

          If (blnResolveuConflitos) Then
          Begin
            intIdxCmbAux := frmFatResolveConflitoPedidos.cmbConPag.ItemIndex;

            fatVenda.strCodCnd := frmFatResolveConflitoPedidos.arrConflitos[intIdxCmbAux].strCodCnd;
            fatVenda.strConPag := frmFatResolveConflitoPedidos.arrConflitos[intIdxCmbAux].strConPag;
            fatVenda.strCodFpg := frmFatResolveConflitoPedidos.arrConflitos[intIdxCmbAux].strCodFpg;
            fatVenda.blnCndEsp := frmFatResolveConflitoPedidos.arrConflitos[intIdxCmbAux].blnCndEsp;
          End;

          If (Not blnResolveuConflitos) Then
          Begin
            fatVenda.blnResolveuConflitoDeTransportadora := False;
            Result := False;
          End;
        end;
      End;
    end;

    function fResolverConflitosPedido: Boolean;
    begin
      Result := True;
      fatVenda.blnResolveuConflitoDeTransportadora := False;

      If Assigned(frmFatResolveConflitoPedidos) Then
      Begin
        If (FParams.blnCodTraDif) Or (FParams.blnConPagDif) Or (FParams.blnForPagDif) Then
        Begin
          blnResolveuConflitos := True;

          If (blnResolveuConflitos) And (fCfgSis('TREXCP') = 'S' {Pedir senha}) And (FParams.blnCodTraDif) Then
          Begin
            frmFatResolveConflitoPedidos.tipConflPedido := cpTransportadora;
            frmFatResolveConflitoPedidos.ShowModal;
            blnResolveuConflitos := frmFatResolveConflitoPedidos.blnConfirma;

            If (blnResolveuConflitos) Then
            Begin
              fatVenda.strCodTra := frmFatResolveConflitoPedidos.edtCodTra.Text;
              fatVenda.blnResolveuConflitoDeTransportadora := True;
            End;
          End;

          If (blnResolveuConflitos) And (fCfgSis('CNEXCP') = 'S' {Pedir senha}) And (FParams.blnConPagDif Or FParams.blnForPagDif) Then
          Begin
            frmFatResolveConflitoPedidos.tipConflPedido := cpCondicao;
            frmFatResolveConflitoPedidos.ShowModal;
            blnResolveuConflitos := frmFatResolveConflitoPedidos.blnConfirma;

            If (blnResolveuConflitos) Then
            Begin
              intIdxCmbAux := frmFatResolveConflitoPedidos.cmbConPag.ItemIndex;

              fatVenda.strCodCnd := frmFatResolveConflitoPedidos.arrConflitos[intIdxCmbAux].strCodCnd;
              fatVenda.strConPag := frmFatResolveConflitoPedidos.arrConflitos[intIdxCmbAux].strConPag;
              fatVenda.strCodFpg := frmFatResolveConflitoPedidos.arrConflitos[intIdxCmbAux].strCodFpg;
              fatVenda.blnCndEsp := frmFatResolveConflitoPedidos.arrConflitos[intIdxCmbAux].blnCndEsp;
            End;
          End;

          If (Not blnResolveuConflitos) Then
          Begin
            fatVenda.blnResolveuConflitoDeTransportadora := False;
            Result := False;
          End;
        End;
      End;
    end;

    procedure pCalcularValorUnitarioRateioServicos;
    begin
      If ((fatVenda.fltTotSer > 0) Or (fatVenda.fGetTotalServNaoTerc('R') > 0))  And fUsaRateioDeServicos Then
      Begin
        fatVenda.pCalculaValUniRateioServico;
      End;
    end;

    procedure pVerificarCondicoesZerarFreteExpedicao;
    begin
      If fRateiaFreteItensTransportadora(fatVenda.strCodTra, fatVenda.strTipFre) Or (FParams.blnBaiEntFut And FParams.blnFreteRateado) Then
      Begin
        fatVenda.fltFreDig := 0;
        fatVenda.fltValFre := 0;
        fatVenda.fltFreRat := 0;
        fatVenda.blnUsaTotFreExpCalc := False;
      End;
    end;

    function fDefineEspecie : Boolean;
    begin

      Result := True;

      If blnVaiFaturarParcialEmFF Then
        Exit(False);

      If ((fatVenda.strEspOrc = 'PD') And (fatVenda.strOpcDoc = 'VN')) Then
        Exit;

      If ((Not fEmptyStr(fatVenda.strOpeExp)) And (fatVenda.strOpcDoc = 'CP')) Then
        Exit;

      If fEhFaturamentoDePedidoOriundoDeConsignacao Then
        Exit;

      Result := False;

    end;

    function fDefinirTipoFaturamento: Boolean;
    begin
      Result := True;

      If fatVenda.fEhVendaConcreto And FParams.blnSimplesRemessaConcreto Then
      Begin
        fatVenda.strTipPed := 'A';
        fatVenda.strEspDoc := 'NF';
      End;

      If (fSelecaoMultipla) And (not fEmptyStr(strTipPedMultiplos)) Then
        fatVenda.strTipPed := strTipPedMultiplos;

      If (fDefineEspecie) Then
      Begin

        If ((FParams.VS_strTipExpInterna = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) And (fCfgSis('TPDCEX') = '1')) And (fEmptyStr(fatVenda.strTipPed)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O tipo do pedido não está preenchido! Favor verificar.', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          blnExpedicaoPedidoBaixaEntregaFuturaComTipPedPreenchido := (Pos(fatVenda.strTipPed, 'A_B_C_') > 0) And FParams.blnBaiEntFut;

          If ((FParams.VS_strTipExpInterna = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) And (fCfgSis('TPDCEX') = '2')) And
             (fEmptyStr(fatVenda.strTipPed) Or (fCfgSis('LOCRET', VarBoolean) And ((fEmptyStr(strTipPedMultiplos)) And (fSelecaoMultipla)) And (Not blnExpedicaoPedidoBaixaEntregaFuturaComTipPedPreenchido))) And
             (Not fEmptyStr(fatVenda.strOpeExp)) Then
          Begin

            Try
              pCriarFormularios(TfrmFatTipoExpedicao, frmFatTipoExpedicao);
              frmFatTipoExpedicao.fatVenda := fatVenda;
              frmFatTipoExpedicao.blnEhFaturamentoDePedidoOriundoDeConsignacao := fEhFaturamentoDePedidoOriundoDeConsignacao;
              frmFatTipoExpedicao.ShowModal;
              Result := frmFatTipoExpedicao.blnConfirma;
            Except
              On E: Exception Do
              Begin
                Result := False;
                pMensagensErro(E.Message, '[TFatVenda.fGravaArquivos]');
              End;
            End;

            pFreeAndNil(frmFatTipoExpedicao);

            If Not Result Then
            Begin
              fMensagem('ATENÇÃO!', 'O tipo do pedido não está preenchido! Favor verificar.', ['&Ok']);
            End
            Else
            Begin
              If fSelecaoMultipla Then
                strTipPedMultiplos := fatVenda.strTipPed;
            End;
          End;
        End;

        fatVenda.pDefineTipoFaturamentoExpedicao(fEhFaturamentoDePedidoOriundoDeConsignacao);

        If (Not fatVenda.fValidarTipoFaturamentoRetencoes) Then
          Result := False;
      End;

      if (Not fDefineEspecie) And (fatVenda.strOpcDoc = 'CS') then
      Begin
        fatVenda.strEspDoc := 'NF';
        fatVenda.strTipFat := 'Nota Fiscal';
      End;

      if (Not fDefineEspecie) And (fatVenda.strOpcDoc = 'CP') And (blnVaiFaturarParcialEmFF) then
      begin
        fatVenda.strTipPed := 'B';
        fatVenda.strEspDoc := 'FF';
        fatVenda.blnVaiFaturarParcialEmFF := fCfgSis('IGNPER', varBoolean);
      end;

      strEspDocSav := fatVenda.strEspDoc;
    end;

    procedure pVerificarSeHaveraDesmembramentoVenda(var blnResult: Boolean);
    begin
      blnResult := fatVenda.fHaveraDesmembramentoVenda(fatVenda.arrMatItens);
    end;

    procedure pDefinirPlacaTransportadoraFaturamento;
    begin
      If (Not fPedeDadosFiscais) And (Not fEmptyStr(fatVenda.strCodTra)) And (fEmptyStr(AnsiReplaceStr(fatVenda.strPlaFat, '-', ''))) Then
        fatVenda.strPlaFat := fCampoTabela('TRA_NUMPLA', 'CADTRA', ['TRA_CODTRA'], [fatVenda.strCodTra]);
    end;

    procedure pSolicitarQuantidadeVolumes;
      Var
        blnPedVol: Boolean;
    begin
      If (fCfgSis('VOLEXP') = 'S') And
        ((FParams.VS_strTipExpInterna = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) Or FParams.blnApenasFaturarJaExpedidos) And
        ((not fSelecaoMultipla) Or
        ((fSelecaoMultipla) And (FParams.stlListaClientes.Count > 1))) Then
      Begin

        If (Not ((fatVenda.strTipPed = 'A') And (fCfgSis('ADIEXP') = 'S'))) And (fCfgSis('EXVOPD', varBoolean)) Then
          FParams.intQtdTra := FParams.intQtdTraTmp
        Else If (fCfgSis('ADIEXP') <> 'S') And (fatVenda.intQtdTra = 0) Then
        Begin
          FParams.intQtdTra := Floor(fatVenda.fRetVolumes);
          If blnUtilizaSeparacaoExclusiva Then
          Begin
            FParams.intQtdTraSepExc  := Floor(fatVenda.fRetVolumesSepExc);
            FParams.intQtdTraSepNExc := (FParams.intQtdTra - FParams.intQtdTraSepExc);
          End;
        End
        Else
        Begin
          FParams.intQtdTra := fatVenda.intQtdTra;
          If blnUtilizaSeparacaoExclusiva Then
          Begin
            FParams.intQtdTraSepExc  := fatVenda.intQtdTraSepExc;
            FParams.intQtdTraSepNExc := fatVenda.intQtdTraSepNExc;
          End;
        End;

        blnEtiVol := True;

        blnPedVol := True;
        If (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
          blnPedVol := AnsiMatchText(fCfgSis('SLDVT4', varString), ['S', 'F']);

        If blnPedVol Then
          pPedeDigVolumes(fatVenda, True);

        fatVenda.intQtdTra := FParams.intQtdTra;

        fatVenda.strEspTra := FParams.strEspTra;
        If blnUtilizaSeparacaoExclusiva Then
        Begin
          fatVenda.intQtdTraSepExc  := FParams.intQtdTraSepExc;
          fatVenda.intQtdTraSepNExc := FParams.intQtdTraSepNExc;
        End;
      End
      Else
        blnImpEti := False;
    end;

    procedure pRealizarRateioFreteNosProdutos;
    begin
      If (fRateiaFreteItensTransportadora(fatVenda.strCodTra, fatVenda.strTipFre) Or (FParams.blnBaiEntFut And FParams.blnFreteRateado)) And (fatVenda.fltValFre > 0) Then
      Begin
        fatVenda.fltFreRat := fatVenda.fltValFre;
        fatVenda.fltValFre := 0.00;
        fatVenda.fltFreDig := 0.00;
        fatVenda.blnUsaTotFreExpCalc := False;

        pCalculaTotGer(fatVenda);
      End;
    end;

    procedure pCalculaVolumeImpressaoMultiplosPedidos;
    begin
      If (fCfgSis('EXVOPD', varBoolean)) And (fUtilizaImpressaoMultiplosPedidos(FParams.stlPedidos)) Then
      Begin
        fatVenda.intQtdTra := fRetornaTotalVolumePedidosExpedidosJuntos(FParams.stlPedidos, fatVenda.intQtdTra);
      End;
    end;

    procedure pRecalcularQuantidadeCaixasVolumes;
    begin
      blnRecalcularCX := (fUsaMontagemCaixas) And (fCfgSis('CFVLCB', varBoolean));
      blnRecalcularVL := (blnRecalcularCX) Or (fCfgSis('CALVEX', varBoolean) And (Not fPedeDadosFiscais));

      If (blnRecalcularCX) Then
        fatVenda.intQtd_Cx := Length(objMontarCaixas.Caixas);

      If (blnRecalcularVL) Then
      Begin
        FParams.intQtdTra := Floor(fatVenda.fRetVolumes);
        fatVenda.intQtdTra := FParams.intQtdTra;

        If blnUtilizaSeparacaoExclusiva Then
        Begin
          FParams.intQtdTraSepExc  := Floor(fatVenda.fRetVolumesSepExc);
          FParams.intQtdTraSepNExc := (FParams.intQtdTra - FParams.intQtdTraSepExc);

          fatVenda.intQtdTraSepExc  := FParams.intQtdTraSepExc;
          fatVenda.intQtdTraSepNExc := FParams.intQtdTraSepNExc;
        End;
      End;
    end;

    function fCalcularTotalFinanceiro: Boolean;
    var
      intContador: Integer;
    begin
      Result := True;

      If Not fCarregaValorRecebido Then
        Result := False;

      If fatVenda.fPedidoAPrazoComEntradaQuitada(FParams.strCtrNumDup, FParams.strCtrEspDoc, FParams.strCtrCodEmp, fatVenda.FConPag) Then
        fatVenda.pAlteraCondicaoPagamentoRemovendoEntrada(fatVenda.FConPag);

      {*********************************************************************************}
      {* CASO FOR UM PEDIDO GERADO PELO F11 COM MODALIDADE "013-UTILIZACAO DE CREDITO" *}
      {* E "015-A RECEBER", ENTAO DEVE ALTERAR A FORMA DE PAGAMENTO DE 009 PARA 015    *}
      {* PARA GERAR O CONTAS A RECEBER A VISTA EM ABERTO                               *}
      {*****************************************************************************JC**}
      If fatVenda.fPedidoRecebidoModalidadesCreditoeAReceberF11(FParams.strCtrNumDup, FParams.strCtrEspDoc, FParams.strCtrCodEmp) Then
      Begin
        fatVenda.strCodFpg := '015';
        fatVenda.strDesFpg := fRetDesFpg('015');
      End;

      fatVenda.pCalculaTotalParaCadRec;

      If (Not FParams.blnExpParcial) And (FParams.stlPedidos.Count > 0) And (fatVenda.strConPag = '01000') And
         (fatVenda.fltValAdt > 0) And (fatVenda.fltValAdt < fatVenda.fltTotCadRec) Then
      Begin
        If fJaUsouCreditoDeAdiantamento(TPedidoVenda(FParams.stlPedidos.Objects[0]).strNumDoc,
                                        TPedidoVenda(FParams.stlPedidos.Objects[0]).strEspDoc,
                                        TPedidoVenda(FParams.stlPedidos.Objects[0]).strCodEmp)
           And
           ((fatVenda.fltTotCadRec - fatVenda.fltValAdt) <= TOLERANCIA_DIFERENCA_EXPEDICAO_PARCIAL) Then
        Begin
          fatVenda.fltDesEsp := fFormataFloat(fatVenda.fltDesEsp + (fatVenda.fltTotCadRec - fatVenda.fltValAdt), 2);
          pCalculaTotGer(fatVenda);
          fatVenda.pCalculaTotalParaCadRec;
        End;
      End;

      {*****************************************************************************}
      {* QUANDO FOR SIMPLES REMESSA DE CONCRETO (SECOL) NAO GRAVA CONTAS A RECEBER *}
      {**************************************************************************JC*}
      If fatVenda.fEhVendaConcreto And FParams.blnSimplesRemessaConcreto Then
      Begin
        FParams.blnManPar     := False;
        fatVenda.fltDupRec    := 0.00;
        fatVenda.fltValAdt    := 0.00;
        fatVenda.fltTotCadRec := 0.00;
        FillChar(fatVenda.recValAdt, SizeOf(fatVenda.recValAdt), #0);
      End;

      dtaDtaBas := VS_Date;
      LblnUtilizarDataEmissaoCalcularDiaVencimento := fatVenda.fUtilizarDataEmissaoCalcularDiaVencimento ;
      {***************************************************************************************}
      {* UTILIZA A DATA DA EMISSÃO DO PEDIDO COMO BASE PARA CALCULO DA CONDIÇÃO DE PAGAMENTO *}
      {************************************************************************************PZ*}
      If (fUtilizarComoDataBaseCtrDataEmissaoPedido(fatVenda.fFaturandoPedido, LblnUtilizarDataEmissaoCalcularDiaVencimento)) Then
      Begin
        {**********************************************************************************************}
        {* CASO O PEDIDO ESTEJA SENDO FATURADO ANTECIPADAMENTE À DATA DE PREVISÃO, UTILIZAR ESSA DATA *}
        {* PARA REMONTAR A CONDIÇÃO DE PAGAMENTO                                                      *}
        {*******************************************************************************************KM*}
        If (fUtilizarComoDataBaseCtrDataPrevisaoPedido(fatVenda.fFaturandoPedido)) And (fatVenda.dtaPreVis <> 0) And (VS_Date < fatVenda.dtaPreVis) Then
          dtaDtaBas := fatVenda.dtaPreVis
        Else
          dtaDtaBas := fatVenda.dtaDtaEntOri;
      End
      Else If fatVenda.fUtilizarDataPrvDataFatComoDataBaseParaCalculoVencimento Then
        dtaDtaBas := fRetDataBaseCalculoCondicaoPagto(fatVenda.dtaPreVis, fatVenda.fFaturandoPedido, fatVenda.dtaDtaEntOri, fatVenda.fUtilizarDataEmissaoCalcularDiaVencimento);

      fltTotDup := fatVenda.fltTotCadRec - fatVenda.fltValAdt;

      If (fatVenda.fltBolAdt > 0) And
         (fatVenda.fltTotalBoletosAdiantamentoJaEnviados + fatVenda.fltTotalBoletosAdiantamentoJaImpressos > 0) Then
      Begin
        fltTotDup := fltTotDup - fatVenda.fltBolAdt;

        If Not FParams.blnEhUmaExpedicaoParcialOuTemPedidosFaturadosParcialmente Then
          If fFormataFloat(fatVenda.fltTotCadRec, 2) <> fFormataFloat(fGetTotalParcelasPedido, 2) Then
          Begin
            pMensagemOk('Pedido de venda possui boletos de adiantamento porém o valor financeiro '+
              'do documento sendo emitido está divergente do valor financeiro do pedido, não é possível faturar o mesmo!');
            Result := False;
          End;

        If Not FParams.blnEhUmaExpedicaoParcialOuTemPedidosFaturadosParcialmente Then
          If fFormataFloat(fltTotDup, 2) <> 0.00 Then
          Begin
            pMensagemOk('Pedido de venda possui boletos de adiantamento porém o valor financeiro '+
              'do documento sendo emitido está divergente do valor total dos boletos emitidos, não é possível faturar o mesmo!');
            Result := False;
          End;

        If FParams.blnEhUmaExpedicaoParcialOuTemPedidosFaturadosParcialmente Then
        Begin
          fltTotDup := 0;
          fatVenda.fltDupRec := fatVenda.fltTotCadRec;
        End;

        FParams.blnManPar := False;
      End;

      blnUtilizarValorTotalAdiantamento := False;

      If ((fltTotDup < 0) And (fatVenda.fltValAdt <> 0)) Then
        fltTotDup := 0;

      If ((fatVenda.fltValAdt > 0) And (Abs(fltTotDup) <= TOLERANCIA_DIFERENCA_EXPEDICAO_PARCIAL)) Then
      Begin
        fltTotDup := 0;

        If TFaturamentoMercadoLivre.NFeSeraEmitidaPeloFaturador(fatVenda) Then
        Begin
          If FParams.blnEhUmaExpedicaoParcialOuTemPedidosFaturadosParcialmente Then
          begin
            fMensagem('Atenção!', 'Pedidos oriundos do Mercado Livre com nota emitida pelo faturador, não podem ser expedidos parcialmente!', ['&Ok']);
            Result := False;
          end
          Else
            blnUtilizarValorTotalAdiantamento := True;
        End;
      End;

      fDigDuplic(fatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses( fatVenda.strConPag ), 0, fltTotDup,
                                               FAlse, False, False, dtaDtaBas, False, fatVenda.fltImpFre,
                                               'N', fCfgSis('DUPRED', varBoolean), False, 0, False,
                                               Nil, '', fCfgSis('FSDUDP', varBoolean), True, Nil, '', False, True, '', '', Nil, fatVenda.fFaturandoPedido,
                                               False, Nil, False, False, 0, '', fatVenda.strCodCid,
                                               '', False, LblnUtilizarDataEmissaoCalcularDiaVencimento);


      fatVenda.strConPag := fRetornaCndPag(fatVenda.arrDuplicata, VS_Date);

      pCarregaDuplicatasCND(1,cdsItens.FieldByName('FGOINC').AsString, fatVenda.arrDuplicataCND);

      If Result And (fatVenda.fltValAdt > 0) Then
      Begin
        Result := fatVenda.fAdicionaAdiantamentoPrimeiraParcela(blnUtilizarValorTotalAdiantamento);
        FParams.blnManPar   := False;
      End;

      If fFormataFloat(fatVenda.fltTotCadRec, 2) <> fFormataFloat(fGetTotalParcelasPedido, 2) Then
        FParams.blnManPar := False;

      If FParams.blnManPar And (Not FParams.blnExpPar) Then
      Begin

        For intContador := 0 To 23 Do
        Begin
          If (fEmptyStr(fatVenda.arrDuplicata[intContador].strSequen)) Then
            Break;
          fatVenda.arrDuplicata[intContador].curValor := fatVenda.arrDuplicataCND[intContador].curValor;
        End;

      End;

      fatVenda.pRateiaValores;
    end;

    function fDigitarTransportadora: Boolean;
    begin
      Result := True;
      If (Not fPedeDadosFiscais) And (fatVenda.fEmiteNotaEspecialAposFaturamento(strEspDocSav) Or fatVenda.blnMeiaNotaComNotaNormal) Then
      Begin
        If fAlterarTransportadora(fatVenda) Then
        Begin
          pCriarFormularios(TfrmDigTransportadora, frmDigTransportadora);
          Try
            fltFrete := fatVenda.fltValFre;
            frmDigTransportadora.objVenda := fatVenda;
            If (frmDigTransportadora.ShowModal <> mrOk) Then
            Begin
              Exit(False);
            End
            Else If (frmDigTransportadora.objVenda.fltValFre < fltFrete) Then
            Begin
              fMensagem('ATENÇÃO!', 'Só é permitido informar um valor de frete maior ou igual ao que foi definido no pedido.', ['&Ok']);
              Exit(False);
            End
            Else If (frmDigTransportadora.objVenda.fltValFre > fltFrete) Then
            Begin
              pCalculaTotGer(fatVenda);
              fatVenda.pCalculaTotalParaCadRec;
              fDigDuplic(fatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses(fatVenda.strConPag), 0, (fatVenda.fltTotCadRec - fatVenda.fltValAdt), False, False, False, dtaDtaBas, False);
              If (fatVenda.fltValAdt > 0) Then
                fatVenda.fAdicionaAdiantamentoPrimeiraParcela;
            End;
          Finally
            pFreeAndNil(frmDigTransportadora);
          end;
        End;
      End;
    end;

    function fDigitarDadosCTe: Boolean;
      Var
        blnCondicaoObrigatoriaParaCte : Boolean;
    begin
      blnCondicaoObrigatoriaParaCte := (not fEmptyStr(fatVenda.strCodTra)) and
                                       (fCfgSis('UTICTE', varString) = 'S') and
                                       (fCampoTabela('TRA_CONHAB', 'CADTRA', ['TRA_CODTRA'], [fatVenda.strCodTra]) = 'S') and
                                       (Not FParams.blnFaturandoTodosAutomaticamente) And
                                       (Not FParams.blnOndaSeparacao);

      Result := True;
      if (blnCondicaoObrigatoriaParaCte) And
         (((fatVenda.strTipPed = 'A') And (fatVenda.strEspDoc = 'NF')) or (fatVenda.blnEmitindoNotaEspecialAposFaturamento)) then
      begin
        try
          Result := TfrmFatDadosCTe.Exibir(fatVenda);
        except
          On E: Exception do
          begin
            Result := False;
            pMensagensErro(E.Message, '[btnConfirmaClick_CTe]');
          end;
        end;
      end
      else
        fatVenda.objDadosCte.blnGrava := False;
    end;

    function fDigitarDadosFiscais: Boolean;
    begin
      Result := True;
      {*********************************************************}
      {* CASO SEJA NOTA FISCAL, CHAMA A TELA DOS DADOS FISCAIS *}
      {******************************************************LU*}
      blnEhNotaEspecialFatorPorValor := (fatVenda.strTipPed = 'B') And (fCfgSis('ADIEXP') = 'S') And fatVenda.blnEmitindoNotaEspecialAposFaturamento;
      If (fPedeDadosFiscais) Then
      Begin
        Try
          pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);
          try
            frmFatDadosFiscais.fatVenda := fatVenda;
            frmFatDadosFiscais.blnExpedicao := True;
            frmFatDadosFiscais.blnEhNotaEspecialFatorPorValor := blnEhNotaEspecialFatorPorValor;

            If (fCfgSis('PESEXP', VarBoolean)) Then
            Begin
              pRetPesoItemFaturamento(fltPesBru, fltPesLiq);

              frmFatDadosFiscais.fatVenda.fltPesBru := fltPesBru;
              frmFatDadosFiscais.fatVenda.fltPesLiq := fltPesLiq;
            End;

            frmFatDadosFiscais.showModal;
            Result := frmFatDadosFiscais.blnConfirma;

            if (Result) and (Pos(fatVenda.strOpcDoc, 'VN_CP_') > 0) and (fVerificaDETEXPORTOuDrawback(fatVenda.strClaFis)) then
            begin
              Result := fatVenda.fInformarDrawbackPorItem(True);
            end;
          finally
            pFreeAndNil(frmFatDadosFiscais);
          end;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[btnConfirmaClick_DadosFiscais]');
          End;
        End;
      End
      Else
      Begin
        fatVenda.pSetarCentroCustoFaturamento;
        If (fatVenda.strTipPed = 'A') And (fatVenda.fZerarIcmsNotaTransferenciaEstadosEspecificos(fatVenda.strClaFis)) Then
          fatVenda.pZerarIcmsNotaTransferenciaEstadosEspecificos;
      End;
    end;

    function fDigitarDadosSimplesRemessaConcreto: Boolean;
    begin
      Result := True;
      If fatVenda.fEhVendaConcreto And FParams.blnSimplesRemessaConcreto Then
      Begin
        Try
          pCriarFormularios(TfrmFatDigDadosConcreto, frmFatDigDadosConcreto);
          frmFatDigDadosConcreto.fatVenda := fatVenda;
          frmFatDigDadosConcreto.ShowModal;
          Result := frmFatDigDadosConcreto.blnConfirma;
        Except
          On E: Exception Do
          Begin
            Result := False;
            pMensagensErro(E.Message, 'Fechamento Concreto');
          End;
        End;
        pFreeAndNil(frmFatDigDadosConcreto);
      End;
    end;

    procedure pVerificaSeInsereItemFreteNoCupomFiscal;
    begin
      If (fatVenda.strEspDoc <> 'IF') Then
        Exit;
      If (Not fCfgSis('FRECUP', VarBoolean)) Then
        Exit;
      If (fFormataFloat(fatVenda.fltValFre, 2) <= 0) Then
        Exit;
      pVerificarSeHaveraDesmembramentoVenda(blnDesmembrarVenda);
      If (Not blnDesmembrarVenda) Then
        fatVenda.pInsereItemFreteNoCupomFiscal;
    end;

    function fRetemImpostosNoDescontoEspecial: Boolean;
    begin
      Result := True;

      If not fatVenda.blnUsaDesEspExpCalc Then
        Exit;

      If not (fatVenda.fltDesEsp > 0) Then
        Exit;

      Result := False;
    end;

    procedure pRetemImpostosNoDescontoEspecial;
    begin
      fatVenda.blnAplicouDescontoIcmsOrgaoPublicoNoDescontoEspecial := False;
      fatVenda.blnDestacouRetencao := False;
      fatVenda.blnReteveImpostoNoDescontoEspecial := False;

      If fatVenda.fAplicaDescontoIcmsOrgaoPublicoNoDescontoEspecial Then
      Begin
        If (fatVenda.fltDesEsp <= 0.00) And (fatVenda.fltIcmOrg > 0) Then
        Begin
          fatVenda.fltDesEsp := fatVenda.fltIcmOrg;
          fatVenda.blnAplicouDescontoIcmsOrgaoPublicoNoDescontoEspecial := True;
        End;
      End;

      fatVenda.pDestacaRetencoes;

      If fRetemImpostosNoDescontoEspecial Then
        fatVenda.pRetemImpostosNoDescontoEspecial;

      If (fatVenda.fPrecisaCalcularTotGer) Then
      Begin
        pCalculaTotGer(fatVenda, False, False);
        fatVenda.blnDestacouRetencao := False;
        fatVenda.blnReteveImpostoNoDescontoEspecial := False;
        fatVenda.blnAplicouDescontoIcmsOrgaoPublicoNoDescontoEspecial := False;
      End;
    end;

    procedure pAtualizarTaxaEntrega;
    begin
      If (Pos(fatVenda.strOpcDoc, 'PD_OR_VN_CP_') > 0) And (fCfgSis('TAXENT', varBoolean)) Then
      Begin
        fatVenda.blnAplicaTaxaEntrega := True;
        fatVenda.pAtualizaValorTaxaEntrega;
      End;
    end;

    procedure pAtualizarValorFrete;
    begin
      blnFretePorTranspRegiao  := (fCfgSis('FRETRA') = FRETRA_POR_TRANSPORTADORA_REGIAO);
      blnFretePorTranspCidade  := (fCfgSis('FRETRA') = FRETRA_POR_TRANSPORTADORA_CIDADE);

      blnUsaValorDeFltTotalFreteNaExpedicao := (fltTotalFreteNaExpedicao > 0) Or ((fltTotalFreteNaExpedicao = 0) And fTemSomenteItensRetira);
      If (Not blnUsaValorDeFltTotalFreteNaExpedicao) Then
        blnUsaValorDeFltTotalFreteNaExpedicao := fTemPedidoComFrete;

      fatVenda.blnUsaTotFreExpCalc := False;

      If (FParams.blnEhUmaExpedicaoParcialOuTemPedidosFaturadosParcialmente Or blnEhUmaExpedicaoTotalDeMaisDeUmPedidoDiferente) And
         (Not fRateiaFreteItensTransportadora(fatVenda.strCodTra, fatVenda.strTipFre)) And
         (blnUsaValorDeFltTotalFreteNaExpedicao) And
         (fltTotalFreteNaExpedicao <> fatVenda.fltValFre) Then
      Begin
        If (fltTotalFreteNaExpedicao > 0) And (blnFretePorTranspRegiao Or blnFretePorTranspCidade) Then
        Begin
          fatVenda.fCalculaSugestaoFreteTransportadora(fatVenda.strCodTra, False, blnFretePorTranspRegiao);

          If fFormataFloat(fltTotalItensNaExpedicao, 2) >= fFormataFloat(fatVenda.fltVlMinF, 2) Then
            fltTotalFreteNaExpedicao := 0.00;
        End;

        If (fatVenda.fltFreRat > 0) Then
          fatVenda.fltFreRat := fltTotalFreteNaExpedicao;
        fatVenda.fltValFre := fltTotalFreteNaExpedicao;
        fatVenda.fltFreDig := fltTotalFreteNaExpedicao;
      End
      Else
      Begin
        If fatVenda.fEhMarketPlace Then
          fatVenda.blnUsaTotFreExpCalc := True;
      End;
    end;

    procedure pAtualizarDescontoEspecial;
    begin
      FParams.blnEhUmaExpedicaoParcialOuTemPedidosFaturadosParcialmente := ((fCfgExpedicaoParcialHabilitada) And FParams.blnExpParcial) Or fTemPedidoFaturadoParcialmente;

      blnEhUmaExpedicaoTotalDeMaisDeUmPedidoDiferente := (Not FParams.blnEhUmaExpedicaoParcialOuTemPedidosFaturadosParcialmente) And
                                                         (fltTotalFreteNaExpedicao > 0) And
                                                         (FParams.stlPedidos.Count > 1);

      fatVenda.blnUsaDesEspExpCalc := False;
      If (fltTotalDesEspNaExpedicao > 0) And (Not FParams.blnDescontoComercialZonaFranca) Then
      Begin
        If (FParams.blnEhUmaExpedicaoParcialOuTemPedidosFaturadosParcialmente) Or (fatVenda.blnPedidoOrigemAgrupamento) Or
           (FParams.stlPedidos.Count > 1) Or (fatVenda.fEhMarketPlace) Or (fatVenda.fEhDocumentoBaixaEntregaFuturaComMaisDeUmaOrigem) Then
        Begin
          fatVenda.blnUsaDesEspExpCalc := True;
          fatVenda.fltDesEsp := fFormataFloat(fltTotalDesEspNaExpedicao, 2);
        End;
      End;

      fltTotalItensNaExpedicao := (fltTotalItensNaExpedicao - fatVenda.fltDesEsp);
    end;

    procedure pAtualizarDespesasAcessorias;
    begin
      fatVenda.blnUsaDesAceExpCalc := False;
      If (fltTotalDesAceNaExpedicao > 0) Then
      Begin
        If (fatVenda.fEhMarketPlace) Then
        Begin
          fatVenda.blnUsaDesAceExpCalc := True;
        End;
      End;
    end;

    procedure pAtualizarTaxaJuros;
       function fRetTaxJurPd: Double;
       begin
         Result := 0;
         If (FParams.qryFatGor.FindField('FGO_TAXJUR') <> Nil) And (FParams.qryFatGor.FindField('FGO_TAXJUR').AsFloat > 0) Then
           Result := FParams.qryFatGor.FindField('FGO_TAXJUR').AsFloat;
       end;
    begin
      fatVenda.blnDeCndF := (fCfgSis('CNDVEN') = 'F');
      If fatVenda.blnTaxVpr Then
      Begin
        fatVenda.pCalculaTaxVpr;

        { Se tem boleto de adiantamento a taxa de juros
          deve ser exatamente a calculada na emissão do
          pedido de venda para não haver divergencia do
          valor emitido no boleto e o valor faturado. }
        If (fatVenda.fltBolAdt > 0) And (fRetTaxJurPd > 0) Then
        Begin
          fatVenda.fltTaxVpr := FParams.qryFatGor.FindField('FGO_TAXJUR').AsFloat;
        End
        Else If (fatVenda.blnBaiEntFut) Then
        Begin
          If (fRetTaxJurPd > 0) Then
            fatVenda.fltTaxVpr := fRetTaxJurPd
          Else If (fatVenda.fTaxJurMatrizItens > 0) Then
            fatVenda.fltTaxVpr := fatVenda.fTaxJurMatrizItens;
        End;
      End;
    end;

    procedure pRemoverItensNaoExpedidos;
    var
      intContador: Integer;
      intContador2: Integer;
    begin
      {*****************************************}
      {* CASO SEJA EXPEDIÇÃO PARCIAL, REMOVE OS*}
      {* PRODUTOS QUE NÃO FORAM EXPEDIDOS.     *}
      {**************************************MV*}
      If (fCfgExpedicaoParcialHabilitada) Then
      Begin
        intContador := 0;
        stlItensNaoExp  := TStringList.Create;
        While (intContador < Length(fatVenda.arrMatItens)) Do
        Begin

          If (fatVenda.arrMatItens[intContador].fltQtdIte = 0.0) Then
          Begin

            stlItensNaoExp.Add(IntToStr(fatVenda.arrMatItens[intContador].intAutInc));
            For intContador2 := intContador+1 To High(fatVenda.arrMatItens) Do
            Begin
              fatVenda.arrMatItens[intContador2-1] := fatVenda.arrMatItens[intContador2];
            End;
            intContador := 0;

            SetLength(fatVenda.arrMatItens, Length(fatVenda.arrMatItens)-1);

          End
          Else
            Inc(intContador);

        End;

        If (stlItensNaoExp.Count > 0) Then
        Begin
          FParams.blnExpParcialTipExp4 := True;
          pDeletaItensNaoExp;
        End;

        FreeAndNil(stlItensNaoExp);
      End;

      FParams.blnExpParcial := (FParams.blnExpParcial Or FParams.blnExpParcialTipExp4);
    end;

    procedure pAtualizarItensExpedidos;
    var
      intContador: Integer;
    begin
      fatVenda.fltTotCus := 0;

      fltTotalFreteNaExpedicao := 0;
      fltTotalDesEspNaExpedicao := 0;
      fltTotalDesAceNaExpedicao := 0;
      fltTotalItensNaExpedicao := 0;

      cdsItens.Filtered := False;
      cdsItens.Filter := '';
      For intContador := Low(fatVenda.arrMatItens) To High(fatVenda.arrMatItens) Do
      Begin
        cdsItens.First;
        If Not cdsItens.Locate('AUTOINCREM', fatVenda.arrMatItens[intContador].strSeqDet, []) Then
        Begin
          fatVenda.arrMatItens[intContador].fltQtdIte := 0;
          Continue;
        End;

        fatVenda.arrMatItens[intContador].strTipBus := cdsItens.FieldByName('TIPBUS').AsString;
        fatVenda.arrMatItens[intContador].fltQtdIte := cdsItens.FieldByName('QTDEXP').AsFloat;
        If Pos(fatVenda.arrMatItens[intContador].strIdePro, strAutomotivas) > 0 Then
          fatVenda.arrMatItens[intContador].fltQtdEmb := cdsItens.FieldByName('QTDEXP').AsFloat;

        fatVenda.arrMatItens[intContador].strNumOrc := cdsItens.FieldByName('NUMDOC').AsString;
        fatVenda.arrMatItens[intContador].strEspOrc := cdsItens.FieldByName('ESPDOC').AsString;
        fatVenda.arrMatItens[intContador].strEmpOrc := cdsItens.FieldByName('CODEMP').AsString;
        fatVenda.arrMatItens[intContador].fltPreCus := cdsItens.FieldByName('VALCUS').AsFloat;
        fatVenda.arrMatItens[intContador].fltTotCus := cdsItens.FieldByName('VALCUS').AsFloat * cdsItens.FieldByName('QTDEXP').AsFloat;

        If fRateiaFreteItensTransportadora(fatVenda.strCodTra, fatVenda.strTipFre) Or (FParams.blnBaiEntFut And FParams.blnFreteRateado) Then
        Begin
          fatVenda.arrMatItens[intContador].fltFreRat := cdsItens.FieldByName('FRERAT').AsFloat / cdsItens.FieldByName('QTDTOT').AsFloat * cdsItens.FieldByName('QTDEXP').AsFloat;
          fatVenda.fltFreDig := fatVenda.fltFreDig + fatVenda.arrMatItens[intContador].fltFreRat;
          fatVenda.fltValFre := fatVenda.fltValFre + fatVenda.arrMatItens[intContador].fltFreRat;
          fatVenda.arrMatItens[intContador].fltFreRat := 0.00;
        End;
        fatVenda.arrMatItens[intContador].fltValFreExp := cdsItens.FieldByName('FDO_TOTFRE').AsFloat / cdsItens.FieldByName('QTDTOT').AsFloat * cdsItens.FieldByName('QTDEXP').AsFloat;
        fltTotalFreteNaExpedicao := fltTotalFreteNaExpedicao + fatVenda.arrMatItens[intContador].fltValFreExp;

        fatVenda.arrMatItens[intContador].fltDesAceExp := cdsItens.FieldByName('FDO_DESACE').AsFloat / cdsItens.FieldByName('QTDTOT').AsFloat * cdsItens.FieldByName('QTDEXP').AsFloat;
        fltTotalDesAceNaExpedicao:= fltTotalDesAceNaExpedicao + fatVenda.arrMatItens[intContador].fltDesAceExp;

        fltTotalItensNaExpedicao := fltTotalItensNaExpedicao + fatVenda.arrMatItens[intContador].fltTotIte / cdsItens.FieldByName('QTDTOT').AsFloat * cdsItens.FieldByName('QTDEXP').AsFloat;

        fatVenda.arrMatItens[intContador].fltTotUlt :=
          IfThen((fatVenda.arrMatItens[intContador].strIdePro = 'NOR') And (Not fatVenda.arrMatItens[intContador].blnProAca), cdsItens.FieldByName('PREULT').AsFloat * cdsItens.FieldByName('QTDEXP').AsFloat, fatVenda.arrMatItens[intContador].fltTotUlt);

        fatVenda.arrMatItens[intContador].fltImpUlt :=
          IfThen((fatVenda.arrMatItens[intContador].strIdePro = 'NOR') And (Not fatVenda.arrMatItens[intContador].blnProAca), cdsItens.FieldByName('IMPULT').AsFloat, fatVenda.arrMatItens[intContador].fltImpUlt);

        fatVenda.arrMatItens[intContador].fltTotImp :=
          IfThen((fatVenda.arrMatItens[intContador].strIdePro = 'NOR') And (Not fatVenda.arrMatItens[intContador].blnProAca), cdsItens.FieldByName('IMPULT').AsFloat, fatVenda.arrMatItens[intContador].fltImpUlt) * cdsItens.FieldByName('QTDEXP').AsFloat;


        fatVenda.arrMatItens[intContador].fltPreCu2 := cdsItens.FieldByName('VALCU2').AsFloat;
        fatVenda.arrMatItens[intContador].fltTotCu2 := cdsItens.FieldByName('VALCU2').AsFloat * cdsItens.FieldByName('QTDEXP').AsFloat;

        fatVenda.fltTotCus := fatVenda.fltTotCus + fatVenda.arrMatItens[intContador].fltTotCus;

        {*****************************************}
        {* APLICA O DESCONTO EM %                *}
        {**************************************MV*}
        intIdxPed := FParams.stlPedidos.IndexOf(cdsItens.FieldByName('SEQGER').AsString);
        objPedido := TPedidoVenda(FParams.stlPedidos.Objects[intIdxPed]);
        fltDesCon := objPedido.fltDesCon;

        If fatVenda.blnBaiEntFut Then
          fatVenda.arrMatItens[intContador].fltPorDesExp := fRetPorDesPeloAutIncFdo(fatVenda.arrMatItens[intContador].strSeqDet)
        Else
          fatVenda.arrMatItens[intContador].fltPorDesExp := fltDesCon;

        If (cdsItens.FieldByName('QTDEXP').AsFloat + cdsItens.FieldByName('QTDBAI').AsFloat) =
           (cdsItens.FieldByName('QTDTOT').AsFloat) Then
        Begin
          fatVenda.arrMatItens[intContador].fltDesEspExp := fFormataFloat(cdsItens.FieldByName('DESESP').AsFloat -
                                                                          cdsItens.FieldByName('DESBAI').AsFloat, 2);
        End
        Else
          fatVenda.arrMatItens[intContador].fltDesEspExp := fFormataFloat((cdsItens.FieldByName('DESESP').AsFloat /
                                                                           cdsItens.FieldByName('QTDTOT').AsFloat) *
                                                                           cdsItens.FieldByName('QTDEXP').AsFloat, 2);

        fltTotalDesEspNaExpedicao := fltTotalDesEspNaExpedicao + fatVenda.arrMatItens[intContador].fltDesEspExp;

        fatVenda.arrMatItens[intContador].fltDesCndExp := 0.00;
        If FParams.blnCodCndDif Then
          fatVenda.arrMatItens[intContador].fltDesCndExp := cdsItens.FieldByName('DESCND').AsFloat;

        fatVenda.arrMatItens[intContador].strTipFin := cdsItens.FieldByName('TIPFIN').AsString;
        fatVenda.arrMatItens[intContador].fltDesFin := cdsItens.FieldByName('DESFIN').AsFloat;

        if FParams.blnUsaRotinaWMS then
          fatVenda.arrMatItens[intContador].strDadosSeparadorWms := cdsItens.FieldByName('SEPDAD').AsString;

        If fUsaMontagemCaixas Then
          fatVenda.arrMatItens[intContador].blnExp_CX := objMontarCaixas.fBuscaItemNasCaixas(cdsItens.FieldByName('AUTOINCREM').AsString);

        fatVenda.fltPorDes := 0;
      End;

    end;

    procedure pAtualizaMsgMovGerAgrupadosporCliente(stlPedidos: TStringlist);
      var
        strMen001, strMen002, strMen003, strMen004, strMen005: String;
        strMenExp, strMenEx2, strMenEx3, strMenEx4: String;
        intCont: Integer;
    begin
      strMen001 := '';
      strMen002 := '';
      strMen003 := '';
      strMen004 := '';
      strMen005 := '';

      strMenExp := '';
      strMenEx2 := '';
      strMenEx3 := '';
      strMenEx4 := '';

      For intCont := 0 To stlPedidos.Count -1 Do
      Begin
        If fatVenda.objExpedicao.cdsExpedicao.Locate('NUMDOC;ESPDOC;CODEMP', VarArrayOf([TPedidoVenda(stlPedidos.Objects[intCont]).strNumDoc,
                                                                                         TPedidoVenda(stlPedidos.Objects[intCont]).strEspDoc,
                                                                                         TPedidoVenda(stlPedidos.Objects[intCont]).strCodEmp]), []) Then
        Begin
          If Not fEmptyStr(fatVenda.objExpedicao.cdsExpedicao.FieldByName('MEN001').AsString) Then
            strMen001 := strMen001 + IIF(strMen001.Length > 0 , '; ', '') + fatVenda.objExpedicao.cdsExpedicao.FieldByName('MEN001').AsString.Trim;

          If Not fEmptyStr(fatVenda.objExpedicao.cdsExpedicao.FieldByName('MEN002').AsString) Then
            strMen002 := strMen002 + IIF(strMen002.Length > 0 , '; ', '') + fatVenda.objExpedicao.cdsExpedicao.FieldByName('MEN002').AsString.Trim;

          If Not fEmptyStr(fatVenda.objExpedicao.cdsExpedicao.FieldByName('MEN003').AsString) Then
            strMen003 := strMen003 + IIF(strMen003.Length > 0 , '; ', '') + fatVenda.objExpedicao.cdsExpedicao.FieldByName('MEN003').AsString.Trim;

          If Not fEmptyStr(fatVenda.objExpedicao.cdsExpedicao.FieldByName('MEN004').AsString) Then
            strMen004 := strMen004 + IIF(strMen004.Length > 0 , '; ', '') + fatVenda.objExpedicao.cdsExpedicao.FieldByName('MEN004').AsString.Trim;

          If Not fEmptyStr(fatVenda.objExpedicao.cdsExpedicao.FieldByName('MEN005').AsString) Then
            strMen005 := strMen005 + IIF(strMen005.Length > 0 , '; ', '') + fatVenda.objExpedicao.cdsExpedicao.FieldByName('MEN005').AsString.Trim;

          If Not fEmptyStr(fatVenda.objExpedicao.cdsExpedicao.FieldByName('MENEXP').AsString) Then
            strMenExp := strMenExp + IIF(strMenExp.Length > 0 , '; ', '') + fatVenda.objExpedicao.cdsExpedicao.FieldByName('MENEXP').AsString.Trim;

          If Not fEmptyStr(fatVenda.objExpedicao.cdsExpedicao.FieldByName('MENEX2').AsString) Then
            strMenEx2 := strMenEx2 + IIF(strMenEx2.Length > 0 , '; ', '') + fatVenda.objExpedicao.cdsExpedicao.FieldByName('MENEX2').AsString.Trim;

          If Not fEmptyStr(fatVenda.objExpedicao.cdsExpedicao.FieldByName('MENEX3').AsString) Then
            strMenEx3 := strMenEx3 + IIF(strMenEx3.Length > 0 , '; ', '') + fatVenda.objExpedicao.cdsExpedicao.FieldByName('MENEX3').AsString.Trim;

          If Not fEmptyStr(fatVenda.objExpedicao.cdsExpedicao.FieldByName('MENEX4').AsString) Then
            strMenEx4 := strMenEx4 + IIF(strMenEx4.Length > 0 , '; ', '') + fatVenda.objExpedicao.cdsExpedicao.FieldByName('MENEX4').AsString.Trim;
        End;
      End;

      fatVenda.strMen001 := strMen001;
      fatVenda.strMen002 := strMen002;
      fatVenda.strMen003 := strMen003;
      fatVenda.strMen004 := strMen004;
      fatVenda.strMen005 := strMen005;

      fatVenda.strMenExp := strMenExp;
      fatVenda.strMenEx2 := strMenEx2;
      fatVenda.strMenEx3 := strMenEx3;
      fatVenda.strMenEx4 := strMenEx4;
    end;

    procedure pAtualizaValorDoImpostoDeImportacaoZonaFranca;
    begin
      If fatVenda.fltDesAce > 0 Then
      Begin
        fatVenda.fltTiiZfm := fatVenda.fRetornaValorDoImpostoDeImportacaoZonaFranca;
        fatVenda.fltDesAce := IIF(fatVenda.fltTiiZfm > 0, fatVenda.fltTiiZfm, fatVenda.fltDesAce);
      End;
    end;

begin
  pIniciarVariaveis;

  inherited;

  If (Not btnConfirma.Enabled) Then
    Exit;

  if (not blnValidaNumeroSerie) and (stlItensNumSerieExpAut.Count > 0) then
  begin
    LMensagem := 'Os itens abaixo contém número de série e não podem ser expedidos automaticamente:';

    for intIndice := 0 to stlItensNumSerieExpAut.Count - 1 do
    begin
      LMensagem :=  LMensagem + sLineBreak + Concat(stlItensNumSerieExpAut[intIndice], '-', fRetNomProduto(stlItensNumSerieExpAut[intIndice]));
    end;

    pMensagemOk(LMensagem);
  end;

  If fExisteCaixaAbertaEmMontagem Then
    Exit;

  If Not fValidarNumeroSerieProdutos Then
    Exit;

  blnIgnorarScroll := True;
  Try
    pDefinirEmpresaFaturamentoPedido(FParams.strEmpOriRegEsp, FParams.blnRegEsp);
    pDesalibitarCampos;
    pCarregarDadosListaPedidos;
    pRetornaQuantidadeExpedidaTotal(FParams, fltQtdExp);
    pCarregarListaAutIncPedidosItensExpedidos;

    If Not fPreValidacoesFaturamentoExpedicao(FParams) Then
    Begin
      pHabilitaCampos;
      Exit;
    End;

    if fSomenteFaturarParcialEmFF(blnAbortarFaturamento) then
    begin
      blnVaiFaturarParcialEmFF := True;
    end
    else
    begin
      blnVaiFaturarParcialEmFF := False;
      if blnAbortarFaturamento then
      begin
        pHabilitaCampos;
        Exit;
      end;
    end;

    cdsItens.First;
    pEnableCdsItens();

    If (FParams.blnOndaSeparacao) And
       (FParams.VS_strTipExpInterna = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) Then
    Begin
      If (Not fGravaSeriesNseDor) Then
      Begin
        pHabilitaCampos;
        Exit;
      End;
    End;

    FParams.blnGravouNumerosSeries := False;

    If (FParams.VS_strTipExpInterna = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
    Begin
      If (Not fExpedePedido(fltQtdExp)) Then
      Begin
        pHabilitaCampos;
      End
      Else
      Begin
        pNotificarClienteFaturamentoPedidoExpedicao;

        If Not fGravarNumeroSerieProdutosExpedidos Then
        Begin
          pHabilitaCampos;
          Exit;
        End
        Else
        Begin
          FParams.blnGravouNumerosSeries := True;
        End;

        FParams.blnFaturarAposExpedirTodosOsItens := fVaiFaturarAposExpedirTodosOsItens;

        If FParams.blnFaturarAposExpedirTodosOsItens And Assigned(frmFatExpedicao) Then
          FParams.blnFaturarAposExpedirTodosOsItens := frmFatExpedicao.fValidaPedidosAguardandoComplemento;

        If (FParams.blnFaturarAposExpedirTodosOsItens) Then
        Begin
          FParams.blnApenasFaturarJaExpedidos := True;
          FParams.VS_strTipExpInterna := TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO;
        End;
      End;

      If Not fValidaQuantidadeItensCaixasItensExpedidos Then
      Begin
        pHabilitaCampos;
        Exit;
      End;

      pGerarOcorrenciaCrmPedidoConferido;

      If fUsaMontagemCaixas Then
      Begin
        If (objMontarCaixas.fValidarNumeracaoCaixas) Then
          pSalvaCaixas
        Else
        Begin
          fMensagem('ATENÇÃO!', 'Houve uma inconsistência na gravação dos sequenciais de caixa. Por favor, entre em contato com a citel imeditamente!', ['&O k']);
          pHabilitaCampos;
          Exit;
        End;
      End;

      pImprimeListaCaixas;

      pAtualizarTipoBuscaItensPedido(fatVenda);

      If fSomenteExpedirSemFaturar Then
      Begin
        Self.FConfirmou := True;
        Self.Close;
        Exit;
      End;
    End;

    If (FParams.blnFaturarAposExpedirTodosOsItens) Then
    Begin
      If (FParams.blnApenasFaturarJaExpedidos) Then
      Begin
        If (Not FParams.blnGravouNumerosSeries) Then
        Begin
          If (Not fGravarNumeroSerieProdutosExpedidos) Then
          Begin
            pHabilitaCampos;
            Exit;
          End
        End;
      End;
    End;

    {*****************************************************************************}
    {* O PEDIDO COM DAV PODERÁ SER SER EXPEDIDO MAS NÃO PODERÁ SER FATURADO      *}
    {**************************************************************************VA*}
    If FParams.blnTemPedidoComDAV Then
    Begin
      Self.FConfirmou := True;
      Self.Close;
      Exit;
    End;

    If FParams.blnDescontoComercialZonaFranca And FParams.blnExpParcial Then
    Begin
      fMensagem('ATENÇÃO!', 'Pedido com Desconto Comercial para Zona Franca não permite faturamento parcial!', ['&Ok']);

      pHabilitaCampos;
      Exit;
    End;

    pCriarObjetoFatVenda;
    Try
      If (FParams.VS_strTipExpInterna = TIPEXP_POR_DOCUMENTO_DE_VENDA) Then
      Begin
        If fConfirmarExpedicaoDocumentoVenda Then
        Begin
          Self.Close;
          Self.FConfirmou := True;
          Exit;
        End
        Else
        Begin
          pHabilitaCampos;
          Exit;
        End;
      End;

      pCriarFormularioResolveConflitoPedidos;

      If Not fCarregarPedidosExpedicao(fatVenda, FParams, pgbStatus) Then
      Begin
        pHabilitaCampos;
        Exit;
      End;

      If (Not fSetaSeparadorConferente) Then
      Begin
        pHabilitaCampos;
        Exit;
      End;

      If Not fResolverConflitosPedido Then
      Begin
        pHabilitaCampos;
        Exit;
      End;

      pLimparVariaveisNumeroPedidoFatVenda;

      fatVenda.pAtualizaDocumentoEntregaFutura;

      If Not fatvenda.fPreencheMatrizFechamento Then
      Begin
        pHabilitaCampos;
        Exit;
      End;

      pCalcularValorUnitarioRateioServicos;

      pVerificarCondicoesZerarFreteExpedicao;

      pAtualizarItensExpedidos;

      pRemoverItensNaoExpedidos;

      If (Not FParams.blnAbastecimentoDeposito) And
         (((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) And
           (fatVenda.objExpedicao.strBotaoAcionado = 'F10')) or
          ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And
           (fatVenda.objExpedicao.strBotaoAcionado = 'F11'))) And
         (Not fPermitirFaturarComLoteADefinir(fatVenda.objExpedicao.stlPedidos)) Then
      Begin
        pHabilitaCampos;
        Exit;
      End;

      If Not fRevalidarQuantidadeSeparadaVsExpedidaWMS(FParams) Then
      Begin
        pHabilitaCampos;
        Exit;
      End;

      fatVenda.pDesmembrarMatrizItensProdutosRastreaveisWMS;

      pAtualizarTaxaJuros;

      pAtualizarDescontoEspecial;

      pAtualizarDespesasAcessorias;

      pAtualizarValorFrete;

      pAtualizarTaxaEntrega;

      pCalculaPesoBrutoLiqExpedicao(fatVenda);

      pCalculaTotGer(fatVenda, False, False);

      pRetemImpostosNoDescontoEspecial;

      If Not fDefinirTipoFaturamento Then
      Begin
        pHabilitaCampos;
        Exit;
      End;

      If Not fCarregaValorRecebido Then
      Begin
        pHabilitaCampos;
        Exit;
      End;

      fatVenda.pPreparaParaEmitirMeiaNotaNotaNormal;

      pVerificaSeInsereItemFreteNoCupomFiscal;

      If fPermiteCupomFiscalComIPI Then
      Begin
        pCalculaTotGer(fatVenda, False, False);
        fatVenda.blnEhFechamentoVenda := True;
      End;

      If Not fVerificaSituacaoRegular Then
      Begin
        pHabilitaCampos;
        Exit;
      End;

      fatVenda.pAplicarFreteComoAcrescimoNFCe;
      fatVenda.blnPedidoContemItemPrioridade := fContemPedidosEmpresaPrioridade;

      pAtualizaValorDoImpostoDeImportacaoZonaFranca;

      pCalculaTotGer(fatVenda);

      fatVenda.pPreencherMsgDadosAdicMsgCFOP;
      fatVenda.pPreencherMsgDadosAdicBaixaEntFutNF;

      If Not fResolverConflitosCondicaoFormaPagamento Then
      Begin
        pHabilitaCampos;
        Exit;
      End;

      If Not fDigitarDadosSimplesRemessaConcreto Then
      Begin
        pHabilitaCampos;
        Exit;
      End;

      pCalculaVolumeImpressaoMultiplosPedidos;

      pRecalcularQuantidadeCaixasVolumes;

      If (fPedidoDoMesmoCliente(fatVenda.objExpedicao.stlPedidos)) And (Not fPedidoGarantiaTE(fatVenda.objExpedicao.stlPedidos)) Then
      Begin
        pAtualizaMsgMovGerAgrupadosporCliente(fatVenda.objExpedicao.stlPedidos);
      End;

      If Not fDigitarDadosFiscais Then
      Begin
        pHabilitaCampos;
        Exit;
      End;

      If Not fDigitarDadosCTe Then
      Begin
        pHabilitaCampos;
        Exit;
      End;

      pRealizarRateioFreteNosProdutos;

      pDefinirPlacaTransportadoraFaturamento;

      If Not fatVenda.fSolicitaDataHoraEntradaSaidaNotaFiscal Then
      Begin
        pHabilitaCampos;
        Exit;
      End;

      pSolicitarQuantidadeVolumes;

      If Not fCalcularTotalFinanceiro Then
      Begin
        pHabilitaCampos;
        Exit;
      End;

      If Not TValidarFaturamento.Validate(fatVenda) Then
      Begin
        pHabilitaCampos;
        Exit;
      End;

      pAtualizarQuantidadeExpedidaItensPedido;

      pVerificarSeHaveraDesmembramentoVenda(blnDesmembrarVenda);

      pSetarLotesParaSeparacaoRomaneio;

      pGravarCONDOR_AUTCOM;

      If (fCfgSis('EXSECO') = 'S') And
         (Not FParams.blnApenasFaturarJaExpedidos) And
         (Not fEmptyStr(strCodSeparador)) Then
      Begin
        pGravarSEPDOR_AUTCOM;
      End;

      If (fatVenda.fEhExpedicaoEDeveGravarCaixaOrdemPagamento) And
         (Not fatVenda.fPedeDadosDoCaixa) Then
      Begin
        pHabilitaCampos;
        Exit;
      End;

      If Not fDigitarTransportadora Then
      Begin
        pHabilitaCampos;
        Exit;
      End;

      If Not fGravarArquivos Then
      Begin
        FParams.blnLimparExpedidos := True;
        fCarregarPedidosExpedicao(fatVenda, FParams, pgbStatus);
        pHabilitaCampos;
        Exit;
      End;

      pSucessoGravarArquivos;
      pAtualizarSeparadorConferentePedido;
      pSetarEspecieParaEmissaoNotaEspecial;
      pImprimeEntrega(fatVenda);
      pLimparPesoDigitadoExpedicao;
      pMensagemDocumentoGeradoComSucesso;
      pVerificarSeClienteTemPontosParaBrindes;
      pImprimirEtiquetasDespacho;
      pImprimirEtiquetaProdutosControlados;
      pEmitirNotaEspecialAposFaturamento;

      if not blnOcorreuErroAoGerarNotaEspecial then
      begin
        pApagaDigitacaoLotesWMS(fatVenda);
        pLimparQuantidadeExpedidaParaContinuarExpedindo;
      end;

      pImprimirPedidosQuantidadePendente;
      pImprimeListaCaixas;
      pImprimeTicketIF(fatVenda);
      pMarcarDataExpedicaoPedidoFaturamentoAutomatico;
      pNotificarClienteBaixaEntregaFutura;
      pHabilitaCampos;
    Finally
      pLiberarObjetoFatVenda;
    End;

  Finally
    blnIgnorarScroll := False;

    If Not fEmptyStr(FParams.strEmpOriRegEsp) Then
    Begin
      pSetaEmpresaLogada(FParams.strEmpOriRegEsp);

      If Assigned(pSetaEmpresaLogadaTinta) Then
        pSetaEmpresaLogadaTinta(FParams.strEmpOriRegEsp);
    End;

    FParams.objResolveConflitosPedido := nil;
    if Assigned(frmFatResolveConflitoPedidos) then
      pFreeAndNil(frmFatResolveConflitoPedidos);
  End;
end;

function TfrmFatExpedicaoItens.fRetornaEmpresaExpedicaoSePedidoOutraLoja: String;
begin
  Result := '';

  If fCfgSis('EXOULJ', varBoolean) Then
  Begin
    If (Assigned(FParams.stlPedidos)) And (FParams.stlPedidos.Count > 0) Then
      Result := TPedidoVenda(FParams.stlPedidos.Objects[0]).strEmpExp
    Else
      Result := FParams.strEmpExp;
  End;
end;

procedure TfrmFatExpedicaoItens.pDefinirEmpresaFaturamentoPedido(var strEmpOriRegEsp: string; var blnRegEsp: Boolean);
  Var
    blnAbastecimentoDeposito: Boolean;
begin
  blnAbastecimentoDeposito := False;
  If (Assigned(FParams.stlPedidos)) And (FParams.stlPedidos.Count > 0) Then
  Begin
    blnAbastecimentoDeposito := (fCampoTabela('FGO_ABADEP',
                                              'FATGOR INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO=FATGOR.AUTOINCREM ',
                                              ['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP','FGO_CODCLI'],
                                              [TPedidoVenda(FParams.stlPedidos.Objects[0]).strNumDoc,
                                               TPedidoVenda(FParams.stlPedidos.Objects[0]).strEspDoc,
                                               TPedidoVenda(FParams.stlPedidos.Objects[0]).strCodEmp,
                                               TPedidoVenda(FParams.stlPedidos.Objects[0]).strCodCli]) = 'S');
  End;

  FParams.blnAbastecimentoDeposito := blnAbastecimentoDeposito;

  strEmpOriRegEsp := EmptyStr;
  blnRegEsp := False;
  if fCfgSis('EXOULJ', varBoolean) then
  begin
    strEmpOriRegEsp := VS_strCodEmp;
    pSetaEmpresaLogada(fRetornaEmpresaExpedicaoSePedidoOutraLoja);
  end
  else if fCfgSis('UTI_RE', varBoolean) and (not fClienteFilial(Self.FParams.strCodCli)) and FParams.blnDesmembraPedRegEsp then
  begin
    strEmpOriRegEsp := VS_strCodEmp;
    if FParams.strRegimeEspecial = 'S' then
      pSetaEmpresaLogada(fCfgSis('EMPRES', varString))
    else if FParams.strRegimeEspecial = 'N' then
      pSetaEmpresaLogada(fCfgSis('EMPREN', varString));
    blnRegEsp := True;
  end
  else if blnAbastecimentoDeposito then
  begin
    strEmpOriRegEsp := VS_strCodEmp;

    If (VS_strCodEmp = TPedidoVenda(FParams.stlPedidos.Objects[0]).strCodEmp) And
       (Not fEmptyStr(FParams.strEmpresaSolicitanteAbastecimentoDeposito)) Then
      pSetaEmpresaLogada(FParams.strEmpresaSolicitanteAbastecimentoDeposito)
    Else
      pSetaEmpresaLogada(TPedidoVenda(FParams.stlPedidos.Objects[0]).strCodEmp);
  end;
end;

procedure TfrmFatExpedicaoItens.pApagaDigitacaoLotesWMS(fatVenda : TFatVenda);
  Var
    LItem: TDadosFechamento;
    LEmpresa: String;
    LEmpresas: TArray<String>;
    LLisIncFatDor : String;
    LobjReprocessarSaldoItens: IReprocessarSaldoItem;
Begin
  If Not FParams.blnUsaRotinaWMS Then
     Exit;

  LobjReprocessarSaldoItens := TReprocessarSaldoItem.New();
  LLisIncFatDor := '';

  For LItem in fatVenda.arrMatItens Do
  Begin
    If fProdutoRastreavel(LItem.strCodIte) Then
    Begin
      pIncrementaListaStr(LItem.strSeqDet, LLisIncFatDor, True, True);

      LEmpresas := fGetEmpresasReprocessarItemPedido(LItem.strSeqDet);

      For LEmpresa In LEmpresas Do
        LobjReprocessarSaldoItens.AddItem(TItemReprocessarSaldo.New.Codigo(LItem.strCodIte).Empresa(LEmpresa));
    End;
  End;

  If (LLisIncFatDor <> '') Then
  Begin
    pEnviaLotDorParaDelLotDor(LLisIncFatDor);
    fExecutaSQL('DELETE FROM LOTDOR WHERE LDO_SEQFDO IN (' +LLisIncFatDor+ ')');
  End;

  LobjReprocessarSaldoItens.NotificarRoboParaReprocessarSaldos;
End;

procedure TfrmFatExpedicaoItens.pCalculaPesoBrutoLiqExpedicao(fatVenda: TFatVenda);
  Var
    itensPesar: TMatrizFechamento;
    intItem: Integer;
    itemIndexCaixa: Integer;
    caixa: TCaixa;
begin
  //Caso nao utilize montagem de caixas
  If (Not fUsaMontagemCaixas) Or (fCfgSis('COMBAL', varString) <> 'S') Then
    fatVenda.pCalculaPesBruLiq
  Else
  Begin
    //Faz uma copia da Matriz de Itens da Venda
    SetLength(itensPesar, Length(fatVenda.arrMatItens));
    For intItem := Low(itensPesar) To High(itensPesar) Do
      itensPesar[intItem] := fatVenda.arrMatItens[intItem];

    //Processa os produtos da copia da Matriz de Itens da Venda
    For intItem := Low(itensPesar) To High(itensPesar) Do
    Begin
      //Procura pelo produto dentro das caixas Fechadas (Já pesadas)
      For caixa In objMontarCaixas.Caixas Do
      Begin
        itemIndexCaixa := caixa.fFindItemByID(itensPesar[intItem].strSeqDet);
        //Caso encontre o produto na caixa fechada Deduz a quantidade do mesmo
        If itemIndexCaixa > -1 Then
          itensPesar[intItem].fltQtdIte := itensPesar[intItem].fltQtdIte - caixa.Itens[itemIndexCaixa].fltQuantidade;
      End;
    End;

    //Calcula o peso Bruto e Liquido deduzindo os produtos que estao em caixas fechadas
    fatVenda.pCalculaPesBruLiq(itensPesar);

    //Soma o peso das caixas fechadas ao peso total do documento de Venda
    For caixa In objMontarCaixas.Caixas Do
    Begin
      fatVenda.fltPesBru := fatVenda.fltPesBru + caixa.fltPesoTotal;
      fatVenda.fltPesLiq := fatVenda.fltPesLiq + caixa.fltPesoTotal;
    End;

  End;
end;

procedure TfrmFatExpedicaoItens.pCalculaTotGer(fatVenda: TFatVenda;
                                               blnZeraPercentuaisDesconto: Boolean = False;
                                               blnCalculaImpostos: Boolean = True;
                                               blnPegaClassificacaoItem: Boolean = True);
begin
  If Assigned(frmFechamentoVenda) Then
  Begin
    strInfoAnt := fRetInformacao(frmFechamentoVenda.pgbStatus);
    pInformacao('Aguarde, Recalculando valor dos produtos ...', frmFechamentoVenda.pgbStatus);
  End;

  fatVenda.pCalculaTotGer(blnZeraPercentuaisDesconto, blnCalculaImpostos, pOnCalculaTotGer, blnPegaClassificacaoItem);
  fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

  If Assigned(frmFechamentoVenda) Then
  Begin
    pProgresso (0, 0, frmFechamentoVenda.pgbStatus);
    pInformacao(strInfoAnt, frmFechamentoVenda.pgbStatus);
  End;
end;

procedure TfrmFatExpedicaoItens.pAtualizaTemporaria(fatVenda: TFatVenda);
begin
  cdsVenda.Filtered := False;
  cdsVenda.Filter := '';
end;

procedure TfrmFatExpedicaoItens.FormClose(Sender: TObject; var Action: TCloseAction);
  Var
    qryUpdate,
    qryCadBox : TUniQuery;
    chrKey : Char;
    arrSel: TConsultasArray;

    intContador: Integer;
    objPedido: TPedidoVenda;

    blnBoxWms : Boolean;
    strNumDoc,
    strEspDoc,
    strCodEmp : String;
begin
  blnBoxWms := fCfgSis('BOXWMS', varBoolean);

  If ((not FConfirmou) And blnBoxWms) And Assigned(FParams.stlPedidos) And (FParams.stlPedidos.Count > 0) Then
  Begin
    Try
      qryUpdate := fCriaQuery;
      qryCadBox := fCriaQuery;

      With qryUpdate, SQL Do
      Begin
        Close;
        Clear;
        Add(' SELECT FGO_NUMDOC,         ');
        Add('        FGO_ESPDOC,         ');
        Add('        FGO_CODEMP          ');
        Add(' FROM FATGOR                ');
        Add(' WHERE AUTOINCREM = :AUTINC ');

        ParamByName('AUTINC').AsString := FParams.stlPedidos[0];

        Open;

        strNumDoc := FieldByName('FGO_NUMDOC').AsString;
        strEspDoc := FieldByName('FGO_ESPDOC').AsString;
        strCodEmp := FieldByName('FGO_CODEMP').AsString;

        Close;
        Clear;

        Add(' SELECT * FROM CADBOX       ');
        Add(' WHERE BOX_EMPDOC = :CODEMP ');
        Add('   AND BOX_ESPDOC = :ESPDOC ');
        Add('   AND BOX_NUMDOC = :NUMDOC ');

        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('NUMDOC').AsString := strNumDoc;

        Open;

      End;

      If (qryUpdate.IsEmpty) Then
      Begin

        fMensagem('', 'Informe o Box que o Pedido será Alocado!', ['OK']);
        chrKey := '?';

        If fPesqBoxWms(Self, Nil, qryCadBox, chrKey, arrSel, True, True) Then
        Begin
          With qryUpdate, SQL Do
          Begin
            Close;
            Clear;
            Add(' UPDATE CADBOX SET BOX_EMPDOC = :EMPDOC, ');
            Add('                   BOX_ESPDOC = :ESPDOC, ');
            Add('                   BOX_NUMDOC = :NUMDOC  ');
            Add(' WHERE AUTOINCREM = :AUTINC              ');

            ParamByName('EMPDOC').AsString := strCodEmp;
            ParamByName('ESPDOC').AsString := strEspDoc;
            ParamByName('NUMDOC').AsString := strNumDoc;
            ParamByName('AUTINC').AsString := qryCadBox.FieldByName('AUTOINCREM').AsString;

            ExecSQL;
          End;

        End
        Else
        Begin
          Action := caNone;
          Exit;
        End;

      End
      Else
        fMensagem('', 'Devolva o Documento no Box: ' + qryUpdate.FieldByName('BOX_CODIGO').AsString, ['&OK']);
    Finally
      FreeAndNil(qryCadBox);
      FreeAndNil(qryUpdate);
    End;

  End;

  If FConfirmou And Assigned(FParams.stlPedidos) And (FParams.stlPedidos.Count > 0) Then
  Begin
    For intContador := 0 To FParams.stlPedidos.Count -1 Do
    Begin
      objPedido  := TPedidoVenda(FParams.stlPedidos.Objects[intContador]);

      TUpdateStatus.New(TParamStatus.New()
                          .NumDoc(objPedido.strNumDoc)
                          .EspDoc(objPedido.strEspDoc)
                          .CodEmp(objPedido.strCodEmp)).pExecute();
    End;
  End;

  inherited;

  pEsvaziaArrayCfgDes;

  If Assigned(cdsSetores) Then
    FreeAndNil(cdsSetores);

  If Assigned(fatVenEst) Then
    FreeAndNil(fatVenEst);

  If Assigned(qryEtique) Then
    FreeAndNil(qryEtique);

  If Assigned(stlItens) Then
    FreeAndNil(stlItens);

  If Assigned(objMontarCaixas) Then
    FreeAndNil(objMontarCaixas);

  If Assigned(qryItensSemCaixa) Then
    FreeAndNil(qryItensSemCaixa);

  If Assigned(objCodBar) Then
    FreeAndNil(objCodBar);

  If Assigned(FParams.stlListaClientes) Then
    FreeAndNil(FParams.stlListaClientes);

  If Assigned(FParams.stlListaGrupos) Then
    FreeAndNil(FParams.stlListaGrupos);

  If Assigned(stlListaCondicaoPagamento) Then
    FreeAndNil(stlListaCondicaoPagamento);

  If FileExists(ExtractFilePath(Application.ExeName) + '\LogExp\' + strLogFileName) Then
    DeleteFile(ExtractFilePath(Application.ExeName) + '\LogExp\' + strLogFileName);

  FreeAndNil(objIteBar);

  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  If Assigned(objConDor) Then
    FreeAndNil(objConDor);

end;

procedure TfrmFatExpedicaoItens.pOcorrenciaSeparacaoErrada(strNumDoc, strEspDoc,
  strCodEmp, strCodCli, strCodSep, strCodOco, strCodToc: String;
  hrsImpSep: TTime);
Var
  objOcoCrm : TAtuOcoCrm;
  qryUpdate : TUniQuery;
  strHeader,
  strBody,

  strDtaEnt,
  strCodVen,
  strNomVen,
  strNomSep,
  strCodCnd,
  strDesCnd,
  strCodFpg,
  strDesFpg,

  strCodIte,
  strDesIte,
  strRefere,
  strMarca,
  strUnidad,
  strQtdPed,
  strQtdSep,
  strTotGer: String;

begin
  If fEmptyStr(strCodOco) Then
    Exit;

  strHeader := '';
  strBody   := '';

  Try
    qryUpdate := fCriaQuery(Self);
    With qryUpdate, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT DISTINCT LOG_CODOPE, LOG_CODSEP, LOG_DTACAD, LOG_HRACAD, LOG_CODITE, LOG_QTDBIP, LOG_QTDPED,');
      Add('       ITE_DESITE, ITE_REFERE, MAR_DESMAR, UNI_DESUNI, FGO_DTAENT, FGO_CODVEN, FGO_CODCND, FGO_CODFPG, FGO_VLRCON');
      Add('FROM LOGSPE ');
      Add('INNER JOIN FATGOR ON FGO_NUMDOC = LOG_NUMDOC AND');
      Add('                     FGO_ESPDOC = LOG_ESPDOC AND');
      Add('                     FGO_CODEMP = LOG_CODEMP');
      Add('INNER JOIN CADITE ON ITE_CODITE = LOG_CODITE');
      Add('LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR');
      Add('LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI');
      Add('WHERE LOG_DTACAD = CURRENT_DATE');
      Add('  AND LOG_HRACAD = :HRACAD ');
      Add('  AND LOG_NUMDOC = :NUMDOC ');
      Add('  AND LOG_ESPDOC = :ESPDOC ');
      Add('  AND LOG_CODEMP = :CODEMP ');
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('HRACAD').AsTime   := hrsImpSep;
      Open;

      strCodVen := FieldByName('FGO_CODVEN').AsString;
      strNomVen := fRetNomVendRep(FieldByName('FGO_CODVEN').AsString);
      strDtaEnt := FieldByName('FGO_DTAENT').AsString;
      strNomSep := fRetNomeOperador(strCodSep);
      strCodCnd := FieldByName('FGO_CODCND').AsString;
      strDesCnd := fFormataCondPag( fRetConPagCodCnd(FieldByName('FGO_CODCND').AsString) );
      strCodFpg := FieldByName('FGO_CODFPG').AsString;
      strDesFpg := fRetDesFpg(FieldByName('FGO_CODFPG').AsString);
      strTotGer := FormatFloat('#,##0.00',FieldByName('FGO_VLRCON').AsFloat);

      strHeader :=  ' +--------------------------------------------------------------------------------------+' + '<<csq>>' +
                    ' |                      Separação Errada de Pedidos de venda                            |' + '<<csq>>' +
                    ' +--------------------------------------------------------------------------------------+' + '<<csq>>' +
                    '  Pedido       : '+strNumDoc+'-'+strEspDoc+'-'+strCodEmp+' Dt.Emissao: '+ strDtaEnt + '<<csq>>' +
                    '  Vendedor     : '+strCodVen+'-'+strNomVen + '<<csq>>' +
                    '  Separador    : '+strCodSep+'-'+strNomSep + '<<csq>>' +
                    '  Operador     : '+strLoginUsuarioLogado+ ' - ' + fRetNomeOperador(strLoginUsuarioLogado)+ '<<csq>>' +
                    '  Cond.Pagto   : '+strCodCnd+'-'+strDesCnd + '<<csq>>' +
                    '  Forma Pagto  : '+strCodFpg+'-'+strDesFpg + '<<csq>>' +
                    '  Vr.Pedido    : '+strTotGer + '<<csq>>' +
                    '  Dt.Impressão : '+DateToStr(VS_Date)+'  Hr.Impressão: '+ TimeToStr(hrsImpSep) + '<<csq>>' +
                    ' ---------------------------------------------------------------------------------------';

      While not eof Do
      Begin
        strCodIte := FieldByName('LOG_CODITE').AsString;
        strDesIte := FieldByName('ITE_DESITE').AsString;
        strRefere := FieldByName('ITE_REFERE').AsString;
        strMarca  := FieldByName('MAR_DESMAR').AsString;
        strUnidad := FieldByName('UNI_DESUNI').AsString;
        strQtdPed := FieldByName('LOG_QTDPED').AsString;
        strQtdSep := FieldByName('LOG_QTDBIP').AsString;

        strBody := strBody + '  Produto       : '+strCodIte + '-' + strDesIte + '<<csq>>' +
                             '  Referência    : '+strRefere  + '<<csq>>' +
                             '  Marca         : '+strMarca  + '<<csq>>' +
                             '  Unidade       : '+strUnidad + '<<csq>>' +
                             '  Qtde Pedido   : '+strQtdPed + '<<csq>>' +
                             '  Qtde Separada : '+strQtdSep + '<<csq>>' +
                             ' ---------------------------------------------------------------------------------------'+ '<<csq>>';
        Next;
      End;
    End;
  Finally
    FreeAndNil(qryUpdate);
  End;

  If not fEmptyStr(strBody) Then
  Begin
    objOcoCrm := fAtualizaInformacoesCRM(strNumDoc,
                                         strEspDoc,
                                         strCodEmp,
                                         strCodCli,
                                         strNumDoc,
                                         strEspDoc,
                                         strLoginUsuarioLogado,
                                         afcNenhum);
    Try
      objOcoCrm.strCodOco := strCodOco;
      objOcoCrm.strDtaInc := VS_Date;
      objOcoCrm.strHorInc := fRetHoraServidor();
      objOcoCrm.strDtaAge := objOcoCrm.strDtaInc;
      objOcoCrm.strHorAge := objOcoCrm.strHorInc;
      objOcoCrm.strOpeHis := strLoginUsuarioLogado;
      objOcoCrm.strDtaCon := VS_Date;
      objOcoCrm.strHorCon := fNow;
      objOcoCrm.strCodToc := strCodToc;
      objOcoCrm.strDescri := strHeader + '<<csq>>' + strBody;
      objOcoCrm.pInsereHistoricoOcorrencia;
      objOcoCrm.pAtualizaOcorrencia;
    Finally
      FreeAndNil(objOcoCrm);
    End;
  End;
end;

procedure TfrmFatExpedicaoItens.pOnFilter(DataSet: TDataSet; var Accept: Boolean);

  function fAtendeBuscaComplementar: Boolean;
  begin
    Result := True;

    If (Not fEmptyStr(strCmpBusComplementar) And Not fEmptyStr(strCmpBusComplementar)) Then
    Begin
      If SameText(strCmpBusComplementar, 'CODBAR;BAREMB') Then
      begin
        Result := (Pos('-' + strCodBarComplementar + '-', DataSet.FieldByName('BAREMB').AsString) > 0) Or
                  ((DataSet.FieldByName('CODBAR').AsString = strCodBarComplementar))
      end
      Else If SameText(strCmpBusComplementar, 'BAREMB') Then
      begin
        Result := (Pos('-' + strCodBarComplementar + '-', DataSet.FieldByName(strCmpBusComplementar).AsString) > 0)
      end
      Else
      begin
        Result := (DataSet.FieldByName(strCmpBusComplementar).AsString = strCodBarComplementar)
      end;
    End;
  end;

begin
  If SameText(strCamBus, 'BAREMB') Then
  begin
    if (not blnCamBusRetira) then
      Accept := Pos('-' + strCodIte + '-', DataSet.FieldByName(strCamBus).AsString) > 0
    else
      Accept := (Pos('-' + strCodIte + '-', DataSet.FieldByName(strCamBus).AsString) > 0) and (DataSet.FieldByName('RETENT').AsString = 'R');
  end
  Else
  begin
    if (not blnCamBusRetira) then
      Accept := (DataSet.FieldByName(strCamBus).AsString = strCodIte)
    else
      Accept := (DataSet.FieldByName(strCamBus).AsString = strCodIte) and (DataSet.FieldByName('RETENT').AsString = 'R');
  end;

  Accept := Accept And fAtendeBuscaComplementar;
end;

procedure TfrmFatExpedicaoItens.pPedeDigVolumes(fatVenda: TFatVenda; blnValidaImpressaoDespacho: Boolean = False);
var
  fltPesBru,
  fltPesLiq: Double;
  frmExpDigVolumesCompostos: TfrmExpDigVolumesCompostos;
  strProCodVolumeComposto: String;
  strCodVol: String;
  qryEtiquetaVolumeComposto: TUniQuery;

  function fEhPesoInformadoNaDigitacaoPesosVolumes: Boolean;
  begin
    If (Not Assigned(frmExpDigVolumes)) Or
       (Not Assigned(fatVenda)) Then
      Exit(True);

    Result := (fatVenda.blnDesmembrarMeiaNotaComNotaNormal) Or
              ((frmExpDigVolumes.fltPesBruOri > 0) And (fFormataFloat(frmExpDigVolumes.fltPesBruOri, 3) <> fFormataFloat(frmExpDigVolumes.fltNovoPesBru, 3))) Or
              ((frmExpDigVolumes.fltPesLiqOri > 0) And (fFormataFloat(frmExpDigVolumes.fltPesLiqOri, 3) <> fFormataFloat(frmExpDigVolumes.fltNovoPesLiq, 3)));
  end;
begin
  Try
    if blnValidaImpressaoDespacho then
    begin
      if (fCfgSis('TIPEXP') = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) and
         (fCfgSis('IEDAEX', varBoolean)) and
         (not fCfgSis('IMETDE', varBoolean)) and
         (fCfgSis('EXVOPD', varBoolean)) and
         (fCfgSis('SLDVT4', varString) = 'N') and
         (fCfgSis('VOLEXP', varBoolean)) then
      begin
        Exit;
      end;

    end;

    blnImpEtiDespachoVolumeComposto := False;
    blnJaExibiuTelaDigVolumesCompostos := False;

    pCriarFormularios(TfrmExpDigVolumes, frmExpDigVolumes);

    If Assigned(fatVenda) Then
      frmExpDigVolumes.edtQtdVol.Enabled := (not fUsaJadLog(Copy(fatVenda.strDocExp, 01, 12),
                                                            Copy(fatVenda.strDocExp, 14, 02),
                                                            Copy(fatVenda.strDocExp, 17, 03)))
    else
      frmExpDigVolumes.edtQtdVol.Enabled := (not fUsaJadLog(FParams.strNumDoc, FParams.strEspDoc, FParams.strCodEmp));

    frmExpDigVolumes.edtQtdVol.Text := FormatFloat('#,##0', FParams.intQtdTra);
    If blnUtilizaSeparacaoExclusiva Then
    Begin
      frmExpDigVolumes.edtQtdVolSepExc.Text  := FormatFloat('#,##0', FParams.intQtdTraSepExc);
      frmExpDigVolumes.edtQtdVolSepNExc.Text := FormatFloat('#,##0', FParams.intQtdTraSepNExc);
    End;

    If Assigned(fatVenda) Then
      frmExpDigVolumes.edtEspTra.Text := IIF(fEmptyStr(fatVenda.strEspTra),fCfgSis('ESPTRA'),fatVenda.strEspTra)
    Else
    Begin
      frmExpDigVolumes.edtEspTra.Text := fCfgSis('ESPTRA');

      If fCfgSis('EXVOPD', varBoolean) And (FParams.stlPedidos.Count > 0) Then
      Begin
        With TPedidoVenda(FParams.stlPedidos.Objects[0]) Do
        Begin
          frmExpDigVolumes.edtQtdVol.Text := FormatFloat('#,##0', Floor(fGetVolumePDOR(strNumDoc, strEspDoc, strCodEmp)));

          If blnUtilizaSeparacaoExclusiva Then
          Begin
            frmExpDigVolumes.edtQtdVolSepExc.Text  := FormatFloat('#,##0', Floor(fGetVolumeSepExcPDOR(strNumDoc, strEspDoc, strCodEmp)));
            frmExpDigVolumes.edtQtdVolSepNExc.Text := FormatFloat('#,##0', Floor(fGetVolumeSepNaoExcPDOR(strNumDoc, strEspDoc, strCodEmp)));
          End;

          frmExpDigVolumes.edtEspTra.Text := fCampoTabela('FGO_ESPECI',
            'FATGOR', ['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP'], [strNumDoc, strEspDoc, strCodEmp]);
        End;
      End;
    End;

    If Assigned(fatVenda) Then
    Begin
      if (fCfgSis('PESEXP', varBoolean)) and (fCfgSis('TIPEXP', varString) = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) and (FParams.VS_strTipExpInterna = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) then
      begin
        pRetPesoItemFaturamento(fltPesBru, fltPesLiq);
        frmExpDigVolumes.fltPesBruOri := fltPesBru;
        frmExpDigVolumes.fltPesLiqOri := fltPesLiq;
      end
      else
      begin
        frmExpDigVolumes.fltPesBruOri := fatVenda.fltPesBru;
        frmExpDigVolumes.fltPesLiqOri := fatVenda.fltPesLiq;
      end;
    End
    Else
    Begin
      if (fCfgSis('PESEXP', varBoolean)) and (fCfgSis('TIPEXP', varString) = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) and (FParams.VS_strTipExpInterna = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) then
      begin
        pCarregaPesoItens(fltPesBru, fltPesLiq);

        frmExpDigVolumes.fltPesBruOri := fltPesBru;
        frmExpDigVolumes.fltPesLiqOri := fltPesLiq;

        frmExpDigVolumes.lblPesBru.Visible := True;
        frmExpDigVolumes.edtPesBru.Visible := True;
        frmExpDigVolumes.lblPesLiq.Visible := True;
        frmExpDigVolumes.edtPesLiq.Visible := True;
      end
      else
      begin
        frmExpDigVolumes.fltPesBruOri := 0;
        frmExpDigVolumes.fltPesLiqOri := 0;

        frmExpDigVolumes.lblPesBru.Visible := False;
        frmExpDigVolumes.edtPesBru.Visible := False;
        frmExpDigVolumes.lblPesLiq.Visible := False;
        frmExpDigVolumes.edtPesLiq.Visible := False;
      end;
    End;

    If (fCfgSis('IDCTRA', varBoolean)) Then
      frmExpDigVolumes.chkEtiDes.Checked := fRetImpDesCadTra(cdsItens.FieldByName('CODTRA').AsString)
    Else
      frmExpDigVolumes.chkEtiDes.Checked := (fMarcadaOpcaoEtiquetasDespacho(False) Or FParams.blnOndaSeparacao) And (Not FParams.blnFaturandoTodosAutomaticamente);

    frmExpDigVolumes.chkEtiDes.Visible := blnEtiVol;
    frmExpDigVolumes.chkEtiDesVolComp.Visible := fMarcaProdutoSemNecessidadeDeExpedicao;

    if frmExpDigVolumes.chkEtiDesVolComp.Visible then
      frmExpDigVolumes.chkEtiDesVolComp.Checked := fMarcadaOpcaoEtiquetasDespacho(True);

    If ((FParams.blnOndaSeparacao And (cdsItens.FieldByName('QTDEXP').AsFloat = 1)) Or FParams.blnFaturandoTodosAutomaticamente) Or
       ((fSelecaoMultipla) And (FParams.stlListaClientes.Count > 1)) Then
    Begin
      frmExpDigVolumes.pOnShow;

      If strToIntDef(frmExpDigVolumes.edtQtdVol.Text, 0) = 0 Then
      Begin
        If (FParams.blnFaturandoTodosAutomaticamente) And (Assigned(fatVenda)) Then
        Begin
          frmExpDigVolumes.edtQtdVol.Text := Floor(fatVenda.fRetVolumes).ToString();
          If blnUtilizaSeparacaoExclusiva Then
          Begin
            frmExpDigVolumes.edtQtdVolSepExc.Text  := Floor(fatVenda.fRetVolumesSepExc).ToString;
            frmExpDigVolumes.edtQtdVolSepNExc.Text := (fStrToFloat(frmExpDigVolumes.edtQtdVol.Text) -
                                                       fStrToFloat(frmExpDigVolumes.edtQtdVolSepExc.Text)).ToString;
          End;
        End
        Else
        Begin
          frmExpDigVolumes.edtQtdVol.Text := '1';
          frmExpDigVolumes.edtQtdVolSepExc.Text  := '0';
          frmExpDigVolumes.edtQtdVolSepNExc.Text := '1';
        End;
      End;

      If fEmptyStr(frmExpDigVolumes.edtEspTra.Text) And (Assigned(fatVenda)) Then
        frmExpDigVolumes.edtEspTra.Text := IIF(fEmptyStr(fatVenda.strEspTra),fCfgSis('ESPTRA'),fatVenda.strEspTra);

      If (Not frmExpDigVolumes.fValidarCampos) Or (FParams.blnSolicitaTelaDeVolume) Then
        frmExpDigVolumes.ShowModal;

      If (fSelecaoMultipla) And (FParams.stlListaClientes.Count > 1) Then
      Begin
        SetLength(arrEtiquetaImpressaoMultiSelecao, Length(arrEtiquetaImpressaoMultiSelecao) + 1);
        arrEtiquetaImpressaoMultiSelecao[Length(arrEtiquetaImpressaoMultiSelecao) - 1].blnImprime := True;
        arrEtiquetaImpressaoMultiSelecao[Length(arrEtiquetaImpressaoMultiSelecao) - 1].fltPesBru := fStrToFloat(frmExpDigVolumes.edtPesBru.Text, 0);
        arrEtiquetaImpressaoMultiSelecao[Length(arrEtiquetaImpressaoMultiSelecao) - 1].intVolume := StrToIntDef(frmExpDigVolumes.edtQtdVol.Text, 1);
        If blnUtilizaSeparacaoExclusiva Then
        Begin
          arrEtiquetaImpressaoMultiSelecao[Length(arrEtiquetaImpressaoMultiSelecao) -1].intVolSepExc  := StrToIntDef(frmExpDigVolumes.edtQtdVolSepExc.Text, 0);
          arrEtiquetaImpressaoMultiSelecao[Length(arrEtiquetaImpressaoMultiSelecao) -1].intVolSepNExc := StrToIntDef(frmExpDigVolumes.edtQtdVolSepNExc.Text, 1);
        End;

        If fCfgSis('PESLIQ') = 'FATOR' Then
        Begin
          arrEtiquetaImpressaoMultiSelecao[Length(arrEtiquetaImpressaoMultiSelecao) - 1].fltPesLiq := fFormataFloat(arrEtiquetaImpressaoMultiSelecao[Length(arrEtiquetaImpressaoMultiSelecao) - 1].fltPesBru * fStrToFloat(fCfgSis('FATPLI', varDouble)), 3);
        End
        Else
        Begin
          arrEtiquetaImpressaoMultiSelecao[Length(arrEtiquetaImpressaoMultiSelecao) - 1].fltPesLiq := fStrToFloat(frmExpDigVolumes.edtPesLiq.Text, 0);
        End;
      End;
    End
    Else
      frmExpDigVolumes.ShowModal;

    blnAlterouVolumes := frmExpDigVolumes.intQtdVol <> FParams.intQtdTra;

    blnImpEti := frmExpDigVolumes.blnImpEti;
    FParams.intQtdTra := frmExpDigVolumes.intQtdVol;
    FParams.strEspTra := frmExpDigVolumes.strEspTra;

    If blnUtilizaSeparacaoExclusiva Then
    Begin
      FParams.intQtdTraSepExc  := frmExpDigVolumes.intQtdVolSepExc;
      FParams.intQtdTraSepNExc := frmExpDigVolumes.intQtdVolSepNExc;
    End;

    If Assigned(fatVenda) Then
    Begin
      fatVenda.blnInformouPeso := fEhPesoInformadoNaDigitacaoPesosVolumes;
      fatVenda.fltPesBru := frmExpDigVolumes.fltNovoPesBru;
      fatVenda.fltPesLiq := frmExpDigVolumes.fltNovoPesLiq;
      If fCfgSis('PESLIQ') = 'FATOR' Then
        fatVenda.fltPesLiq := fFormataFloat(fatVenda.fltPesBru * fStrToFloat(fCfgSis('FATPLI', varDouble)), 3);
    End
    Else If (fCfgSis('PESEXP', varBoolean)) and (fCfgSis('TIPEXP', varString) = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) and (FParams.VS_strTipExpInterna = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
    Begin
      fltPesBru := frmExpDigVolumes.fltNovoPesBru;
      fltPesLiq := frmExpDigVolumes.fltNovoPesLiq;
      pGravaPesoExpedicao(fltPesBru, fltPesLiq, FParams.stlPedidos.Count);
    End;

    If (frmExpDigVolumes.chkEtiDesVolComp.Visible) And (frmExpDigVolumes.chkEtiDesVolComp.Checked) Then
    Begin
      pCriarFormularios(TfrmExpDigVolumesCompostos, frmExpDigVolumesCompostos);

      try
        cdsItens.First;
        while not cdsItens.Eof do
        begin
          if fProdutoSemNecessidadeDeExpedicao(cdsItens.FieldByName('CODITE').AsString) then
          begin
            frmExpDigVolumesCompostos.pAddProduto(cdsItens.FieldByName('CODITE').AsString + '-' + cdsItens.FieldByName('DESCRI').AsString,
                                                  cdsItens.FieldByName('UNIDAD').AsString,
                                                  cdsItens.FieldByName('QTDITE').AsFloat);
          end;

          cdsItens.Next;
        end;

        qryEtiquetaVolumeComposto := fCarregaEtiquetaVolumeCompostoPedidos(FParams.stlPedidos, strCodVol);

        if (Assigned(qryEtiquetaVolumeComposto)) and (qryEtiquetaVolumeComposto <> Nil) and (Not fEmptyStr(qryEtiquetaVolumeComposto.SQL.Text)) then
        begin
          qryEtiquetaVolumeComposto.Open;

          if not qryEtiquetaVolumeComposto.IsEmpty then
          begin
            qryEtiquetaVolumeComposto.First;

            while not qryEtiquetaVolumeComposto.Eof do
            begin
              frmExpDigVolumesCompostos.pAddEtiquetaVolume(qryEtiquetaVolumeComposto.FieldByName('EVC_DESCRI').AsString,
                                                           qryEtiquetaVolumeComposto.FieldByName('EVC_SIGLA_').AsString,
                                                           qryEtiquetaVolumeComposto.FieldByName('EVC_VOLUME').AsInteger);

              qryEtiquetaVolumeComposto.Next;
            end;
          end;

          FreeAndNil(qryEtiquetaVolumeComposto);
        end;

        frmExpDigVolumesCompostos.ShowModal;

        if frmExpDigVolumesCompostos.ModalResult = mrOk then
        begin
          if not fEmptyStr(strCodVol) then
            pExcluiEtiquetaVolumeComposto(strCodVol);

          frmExpDigVolumesCompostos.cdsVolume.First;
          strProCodVolumeComposto := fAtualizaProCod('ETIEVC', 'EVC_CODIGO');

          while not frmExpDigVolumesCompostos.cdsVolume.Eof do
          begin
            pInsereEtiquetaVolumeComposto(strProCodVolumeComposto,
                                          frmExpDigVolumesCompostos.cdsVolumeTIPVOL.AsString,
                                          frmExpDigVolumesCompostos.cdsVolumeSIGVOL.AsString,
                                          frmExpDigVolumesCompostos.cdsVolumeQTDVOL.AsInteger);

            frmExpDigVolumesCompostos.cdsVolume.Next;
          end;

          pVinculaEtiquetaVolumeCompostoAosPedidos(FParams.stlPedidos, strProCodVolumeComposto);
          blnImpEtiDespachoVolumeComposto := True;
          blnJaExibiuTelaDigVolumesCompostos := True;
        end;
      finally
        cdsItens.First;
        pFreeAndNil(frmExpDigVolumesCompostos);
      end;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[frmFatExpedicaoItens -> frmExpDigVolumes]');
  End;

  pFreeAndNil(frmExpDigVolumes);
end;

procedure TfrmFatExpedicaoItens.pCarregaImpSeq;
const
  STR_SEPDET = 'SELECT DET_VOLEXP VOLUME, DET_IMPSEQ IMPSEQ FROM SEPDET WHERE DET_SEQGER = :SEQDET';
  STR_SEPFDO = 'SELECT FDO_VOLEXP VOLUME, FDO_IMPSEQ IMPSEQ FROM SEPFDO WHERE FDO_SEQFDO = :SEQDET';
Var
  qrySep: TUniQuery;
begin
  qrySep := fCriaQuery;
  Try
    Case StrToIntDef(FParams.VS_strTipExpInterna, 0) Of
      2:
        Begin
          qrySep.SQL.Text := STR_SEPDET;
        End;
      3,4:
        Begin
          qrySep.SQL.Text := STR_SEPFDO;
        End;
    End;

    qrySep.ParamByName('SEQDET').AsString := cdsItens.FieldByName('AUTOINCREM').AsString;
    qrySep.Open;

    If (Not qrySep.IsEmpty) Then
    Begin
      chkImpSeq.Checked := IIF(qrySep.FieldByName('IMPSEQ').AsString = 'S', True, False);
      edtVolume.Text    := IntToStr(qrySep.FieldByName('VOLUME').AsInteger);
    End;
  Finally
    FreeAndNil(qrySep)
  End;
end;

procedure TfrmFatExpedicaoItens.pCarregaItensDocumento;
  Const
    STR_DESMAR = ', IF(IFNULL(MAR_DESMAR, "") <> "", CONCAT(" - ", IFNULL(MAR_DESMAR, "")), "") ';
  function STR_LOCFIS: String;
  begin
    Result := ', IF(IFNULL(D.DET_NUMLOT,"")<>"", CONCAT(" - ' + fDescricaoResumidaLocFis + ' ", IFNULL(D.DET_NUMLOT,"")), "") ';
  end;
begin
  With qryItens Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add('SELECT                                                 ');
    SQL.Add('  DET_DESCRI AS DESCRI,                                ');
    SQL.Add('  CONCAT(DET_CODITE, "-", DET_DESCRI' + IIF(fCfgSis('CADLOC', VarBoolean), STR_LOCFIS, '') +
                                                     IIF(fCfgSis('MAREXP', VarBoolean), STR_DESMAR, '') + ') AS DESITE, ');
    SQL.Add('  D.DET_DESCRI AS DESCRI,                              ');
    If (blnExiApl) And (fCampoExiste('CADITE', 'ITE_APLICA', True)) Then
      SQL.Add(' I.ITE_APLICA AS APLICA, ')
    Else
      SQL.Add(' CAST("" AS CHAR(255)) AS APLICA, ');
    SQL.Add('  D.DET_CODITE AS CODITE,                              ');
    SQL.Add('  D.DET_ESPDOC AS ESPDOC,                              ');
    SQL.Add('  D.DET_CODEMP AS CODEMP,                              ');
    SQL.Add('  I.ITE_CODGRU AS CODGRU,                              ');
    SQL.Add('  D.DET_NUMDOC AS NUMDOC,                              ');
    SQL.Add('  (D.DET_QTDITE - IFNULL(T.DET_QTDEXP, 0)) AS QTDITE,  ');
    SQL.Add('  ((DET_QTDITE - DET_QTDEXP) - (DET_QTDITE - DET_QTDSEP)) AS QTDDIS, ');
    If FParams.blnUsaImpressaoSeparacaoPorLocal Then
    Begin
      If (FParams.blnSepPorArmazem) Then
        SQL.Add(' (SELECT AMZ_DESCRI FROM CADAMZ WHERE AMZ_CODAMZ = DET_NUMLOT AND AMZ_CODEMP = DET_CODEMP LIMIT 1) AS DESLOC, ')
      Else
      begin
        if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
        begin
          SQL.Add('IF(IFNULL(DET_NUMLOT, "") = "", ');
          SQL.Add('  (SELECT LSE_DESCRI FROM CADLSE WHERE LSE_CODIGO = ITE_CODLSE LIMIT 1), ');
          SQL.Add('  (SELECT LSE_DESCRI FROM CADLOT LT ');
          SQL.Add('     LEFT JOIN CADLOC CL1 ON CL1.LOC_CODLOC = LT.LOT_LOCFIS AND CL1.LOC_CODEMP = LT.LOT_CODEMP ');
          SQL.Add('     LEFT JOIN CADLSE LS1 ON LS1.LSE_CODIGO = CL1.LOC_CODLSE ');
          SQL.Add('    WHERE LT.LOT_CODITE = DET_CODITE ');
          SQL.Add('      AND LT.LOT_CODEMP = DET_CODEMP ');
          SQL.Add('      AND LT.LOT_NUMLOT = DET_NUMLOT ');
          SQL.Add('   LIMIT 1) ');
          SQL.Add(') AS DESLOC, ');
        end
        else
          SQL.Add(' (SELECT LSE_DESCRI FROM CADLSE WHERE LSE_CODIGO = ITE_CODLSE LIMIT 1) AS DESLOC, ');
      end;
    End
    Else
    Begin
      SQL.Add(' " " AS DESLOC, ');
    End;
    SQL.Add('  UNI_SIGUNI AS UNIDAD,                                ');
    SQL.Add('  0.0000 AS QTDEXP,                                    ');
    SQL.Add('  G.ITE_SALDOS + ' + fSQLQuantidadeEntregaFutura + ' AS SALEST,    ');
    SQL.Add('  D.AUTOINCREM AS AUTOINCREM,                          ');
    SQL.Add('  IF(LEFT(D.DET_CLAFIS, 1) < "5", "E", "S") AS ENTSAI, ');
    SQL.Add('  D.DET_IDEPRO AS IDEPRO,                              ');
    SQL.Add('  " " ENTRET,                                          ');
    SQL.Add('  IF(D.DET_ENTFUT = "" OR D.DET_ENTFUT IS NULL, " ", D.DET_ENTFUT) AS ENTFUT, ');

    If (fCfgSis('EXPTIN',varString) = '1') Then
      SQL.Add('  IF(D.DET_CODACA IS NOT NULL AND D.DET_CODACA <> "", ACA_CODBAR, I.ITE_CODBAR) AS CODBAR, ')
    Else
    Begin
      SQL.Add('  I.ITE_CODBAR AS CODBAR, ');
      SQL.Add('  ACA_CODBAR   AS CODBAT, ');
    End;

    SQL.Add('  "B" AS TIPBUS,                                       ');
    SQL.Add('  "N" AS EXP_CX,                                       ');

    SQL.Add('  (SELECT GROUP_CONCAT(CONCAT("-", BAR_CODBAR, "-")) FROM                              ');
    SQL.Add('   ITEBAR WHERE I.ITE_CODITE = BAR_CODITE) AS BAREMB,                                  ');

    SQL.Add('  I.ITE_EMBALA AS EMBALA,                              ');
    SQL.Add('  " " AS TIPFIN,                                       ');

    SQL.Add('  GER_VPAR01 AS VPAR01,                                ');
    SQL.Add('  GER_VPAR02 AS VPAR02,                                ');
    SQL.Add('  GER_VPAR03 AS VPAR03,                                ');
    SQL.Add('  GER_VPAR04 AS VPAR04,                                ');
    SQL.Add('  GER_VPAR05 AS VPAR05,                                ');
    SQL.Add('  GER_VPAR06 AS VPAR06,                                ');
    SQL.Add('  GER_VPAR07 AS VPAR07,                                ');
    SQL.Add('  GER_VPAR08 AS VPAR08,                                ');
    SQL.Add('  GER_VPAR09 AS VPAR09,                                ');
    SQL.Add('  GER_VPAR10 AS VPAR10,                                ');
    SQL.Add('  GER_VPAR11 AS VPAR11,                                ');
    SQL.Add('  GER_VPAR12 AS VPAR12,                                ');
    SQL.Add('  IF(GER_ENTFUT = "S", "F", IF(GER_ENTFAT = "S", "E", "R")) AS RETENT, ');
    SQL.Add('  G.ITE_USASER AS USASER, ');
    SQL.Add('  I.ITE_MLTVEN AS MLTVEN, ');
    SQL.Add('  I.ITE_GRAMAR AS GRAMAR, ');
    SQL.Add('  D.DET_NUMLOT AS NUMLOT, ');

    SQL.Add('  ITE_PESOIT AS PESOIT,                                ');
    SQL.Add('  ITE_CODFAB AS CODFAB,                                ');
    SQL.Add('  ITE_REFERE AS REFERE,                                ');

    If (FParams.blnUsaRotinaWMS) And (FParams.blnOndaSeparacao) Then
      SQL.Add('  (D.DET_QTDITE - IFNULL(T.DET_QTDEXP, 0)) AS QTDSEP,  ')
    Else
      SQL.Add('  DET_QTDSEP AS QTDSEP,                                ');

    SQL.Add('  D.DET_SEQGER AS SEQGER,                              ');

    SQL.Add('  DET_CODCLI AS CODCLI,                                ');
    SQL.Add('  CLI_NOMCLI AS NOMCLI,                                ');
    SQL.Add('  CLI_CELULA AS CELCLI,                                ');
    SQL.Add('  GER_CODTRA AS CODTRA,                                ');
    SQL.Add('  TRA_NOMTRA AS NOMTRA,                                ');
    SQL.Add('  ITE_CODUNI, ');
    SQL.Add('  0.00 AS DESFIN,                                      ');
    SQL.Add('  0.00 AS DESCND,                                      ');
    SQL.Add('  "N"  AS TEMDAV,                                      ');
    SQL.Add('  "N"  AS FATTOT,                                      ');
    SQL.Add('  CAST(" " AS CHAR(30)) AS COTLAL,                     ');
    SQL.Add('  D.DET_PROACA AS PROACA,                              ');
    SQL.Add('  D.DET_CODEMP AS EMPITE,                              ');
    SQL.Add('  IFNULL(IF(IFNULL(DET_NUMLOT, "") = "", G.ITE_LOCFIS, LOT_LOCFIS), " ") AS LOCFIS, ');
    SQL.Add('  IFNULL(NULLIF('+ IIF(fCfgSis('GRUSEP') = 'S', 'LSE_DESCRI', 'G.ITE_LOCFIS') +', ""), "'+ strSetorDefault +'") AS SETOR_, ');

    If FParams.blnControlePorArmazem Then
      SQL.Add('  CONCAT(D.DET_NUMLOT, "-", CADAMZ.AMZ_DESCRI) AS ARMAZE ')
    Else
      SQL.Add('  D.DET_NUMLOT AS ARMAZE ');

    If strOrdDoc = '4' Then
      SQL.Add('  ,DEP_DESCRI                                         ');

    SQL.Add(',  (SELECT F.AUTOINCREM FROM FATGOR F     ');
    SQL.Add('    WHERE FGO_NUMDOC = DET_NUM_PD         ');
    SQL.Add('      AND FGO_ESPDOC = DET_ESP_PD         ');
    SQL.Add('      AND FGO_CODEMP = DET_EMP_PD) FGOINC ');

    If fVaiGravarCONDOR_AUTCOM_DocVenda() Then
      SQL.Add(',  A.DET_INC_PD AS FDOINC  ');

    SQL.Add('  ,CLI_BAIRRO AS BAICLI                                ');
    SQL.Add('  ,CLI_C_E_P_ AS C_E_P_                                ');
    SQL.Add('  ,CLI_CODCID AS CODCID                                ');
    SQL.Add('  ,CLI_ENDCOM AS ENDCOM                                ');
    SQL.Add('  ,CLI_ENDERE AS ENDERE                                ');
    SQL.Add('  ,CLI_ENDNUM AS ENDNUM                                ');
    SQL.Add('  ,CLI_FANSOB AS FANSOB                                ');

    SQL.Add('  ,IF(MOVGER.GER_NOMCON IS NULL OR MOVGER.GER_NOMCON = "",                             ');
    SQL.Add('   IF(EC.ETC_BAIENT IS NULL OR EC.ETC_BAIENT = "", CADCLI.CLI_BAIRRO,EC.ETC_BAIENT),   ');
    SQL.Add('   MOVGER.GER_BAICON) AS BAIENT                                                        ');

    SQL.Add('  ,IF(MOVGER.GER_NOMCON IS NULL OR MOVGER.GER_NOMCON = "",                                  ');
    SQL.Add('   IF(EC.ETC_ENDENT IS NULL OR EC.ETC_ENDENT = "", CADCLI.CLI_ENDERE, EC.ETC_ENDENT),       ');
    SQL.Add('   MOVGER.GER_ENDCON) AS ENDENT                                                             ');

    SQL.Add('  ,IF(MOVGER.GER_NOMCON IS NULL OR MOVGER.GER_NOMCON = "",                                  ');
    SQL.Add('   IF(EC.ETC_ENDENT IS NULL OR EC.ETC_ENDENT = "", CADCLI.CLI_C_E_P_,EC.ETC_CEPENT),        ');
    SQL.Add('   MOVGER.GER_CEPCON) AS CEPENT                                                             ');

    SQL.Add('  ,IF(MOVGER.GER_NOMCON IS NULL OR MOVGER.GER_NOMCON = "",                                  ');
    SQL.Add('   IF(EC.ETC_ENDENT IS NULL OR EC.ETC_ENDENT = "", CF.CID_NOMCID,CE.CID_NOMCID),            ');
    SQL.Add('   CC.CID_NOMCID) AS CIDENT                                                                 ');

    SQL.Add('  ,IF(MOVGER.GER_NOMCON IS NULL OR MOVGER.GER_NOMCON = "",                                  ');
    SQL.Add('   IF(EC.ETC_ENDENT IS NULL OR EC.ETC_ENDENT = "", CF.CID_ESTADO,CE.CID_ESTADO),            ');
    SQL.Add('   CC.CID_ESTADO) AS ESTENT                                                                 ');
    SQL.Add('  ,"N"  AS CODROT                                       ');
    SQL.Add('  ,D.DET_CODVEN AS CODVEN                               ');
    SQL.Add('  ,D.DET_CODVE2 AS CODVE2                               ');
    SQL.Add('  ,DATE_FORMAT(D.DET_DTAENT,"%d/%m") AS DTAENT          ');
    SQL.Add('  ,CAST("" AS CHAR(1)) AS NOMROT                        ');
    SQL.Add('  ,(SELECT ');
    SQL.Add('      EXTDOR.FDO_NUMCMP ');
    SQL.Add('     FROM EXTDOR ');
    SQL.Add('     LEFT JOIN FATDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ');
    SQL.Add('     WHERE D.DET_NUM_PD = FATDOR.FDO_NUMDOC ');
    SQL.Add('     	AND D.DET_ESP_PD = FATDOR.FDO_ESPDOC ');
    SQL.Add('     	AND D.DET_EMP_PD = FATDOR.FDO_CODEMP ');
    SQL.Add('     	AND D.DET_CODCLI = FATDOR.FDO_CODCLI ');
    SQL.Add('     	AND D.DET_CODITE = FATDOR.FDO_CODITE ');
    SQL.Add('     	AND D.DET_IND_PD = FATDOR.FDO_SEQIND ');
    SQL.Add('     LIMIT 1 ');
    SQL.Add('    ) AS NUMCMP                        ');

    SQL.Add('  ,(SELECT ');
    SQL.Add('      EXTGOR.FGO_OPEEXP ');
    SQL.Add('     FROM EXTGOR ');
    SQL.Add('     LEFT JOIN FATDOR ON FATDOR.FDO_SEQGER = EXTGOR.FGO_SEQFGO ');
    SQL.Add('     WHERE D.DET_NUM_PD = FATDOR.FDO_NUMDOC ');
    SQL.Add('     	AND D.DET_ESP_PD = FATDOR.FDO_ESPDOC ');
    SQL.Add('     	AND D.DET_EMP_PD = FATDOR.FDO_CODEMP ');
    SQL.Add('     	AND D.DET_CODCLI = FATDOR.FDO_CODCLI ');
    SQL.Add('     	AND D.DET_CODITE = FATDOR.FDO_CODITE ');
    SQL.Add('     	AND D.DET_IND_PD = FATDOR.FDO_SEQIND ');
    SQL.Add('     LIMIT 1 ');
    SQL.Add('    ) AS OPEEXP                        ');

    SQL.Add('  ,(SELECT ');
    SQL.Add('      EXTGOR.FGO_SEPEXP ');
    SQL.Add('     FROM EXTGOR ');
    SQL.Add('     LEFT JOIN FATDOR ON FATDOR.FDO_SEQGER = EXTGOR.FGO_SEQFGO ');
    SQL.Add('     WHERE D.DET_NUM_PD = FATDOR.FDO_NUMDOC ');
    SQL.Add('     	AND D.DET_ESP_PD = FATDOR.FDO_ESPDOC ');
    SQL.Add('     	AND D.DET_EMP_PD = FATDOR.FDO_CODEMP ');
    SQL.Add('     	AND D.DET_CODCLI = FATDOR.FDO_CODCLI ');
    SQL.Add('     	AND D.DET_CODITE = FATDOR.FDO_CODITE ');
    SQL.Add('     	AND D.DET_IND_PD = FATDOR.FDO_SEQIND ');
    SQL.Add('     LIMIT 1 ');
    SQL.Add('    ) AS SEPEXP                        ');

    SQL.Add('FROM                                                   ');
    SQL.Add('  MOVDET D                                             ');
    SQL.Add('  INNER JOIN CADITE I ON I.ITE_CODITE = D.DET_CODITE       ');
    SQL.Add('  INNER JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE       ');
    SQL.Add('  INNER JOIN CADUNI   ON UNI_CODUNI   = I.ITE_CODUNI       ');
    SQL.Add('  INNER JOIN MOVGER ON MOVGER.AUTOINCREM = D.DET_SEQGER ');
    SQL.Add('  LEFT  JOIN CADCLI ON CLI_CODCLI = GER_CODCLI             ');
    SQL.Add('  LEFT  JOIN CADTRA ON TRA_CODTRA = GER_CODTRA             ');
    SQL.Add('  LEFT  JOIN CADAMZ ON (CADAMZ.AMZ_CODAMZ = D.DET_NUMLOT AND CADAMZ.AMZ_CODEMP = D.DET_CODEMP) ');
    SQL.Add('  LEFT  JOIN AUXMOV ON AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM ');
    SQL.Add('  LEFT  JOIN ENTCLI EC ON EC.ETC_CODCLI = MOVGER.GER_CODCLI    ');
    SQL.Add('                      AND IF(IFNULL(AUXMOV.AUX_ENTGER, "") <> "",                       ');
    SQL.Add('                             EC.AUTOINCREM = AUXMOV.AUX_ENTGER,                         ');
    SQL.Add('                             EC.ETC_SEQIND =(SELECT                                     ');
    SQL.Add('                                              MIN(ETC_SEQIND)                           ');
    SQL.Add('                                             FROM                                       ');
    SQL.Add('                                              ENTCLI                                    ');
    SQL.Add('                                             WHERE ETC_CODCLI = MOVGER.GER_CODCLI))     ');
    SQL.Add('  LEFT  JOIN CADCID CC ON CC.CID_CODCID = MOVGER.GER_CIDCON    ');
    SQL.Add('  LEFT  JOIN CADCID CE ON CE.CID_CODCID = EC.ETC_CIDENT        ');
    SQL.Add('  LEFT  JOIN CADCID CF ON CF.CID_CODCID = CADCLI.CLI_CODCID    ');

    SQL.Add('LEFT JOIN CADACA ON ACA_CODACA = DET_CODACA AND        ');
    SQL.Add('                    ACA_CODEMP = DET_EMPACA            ');

    SQL.Add('LEFT JOIN MOVTRI  T ON T.DET_SEQGER = D.AUTOINCREM ');

    If fCfgSis('MAREXP', VarBoolean) Then
      SQL.Add('  LEFT JOIN CADMAR ON (MAR_CODMAR = ITE_CODMAR) ');

    If strOrdDoc = '4' Then
      SQL.Add('  LEFT JOIN CADDEP ON DEP_CODIGO = I.ITE_CODDEP');

    SQL.Add('  LEFT JOIN CADLOT ON  DET_CODITE = LOT_CODITE AND ');
    SQL.Add('                       DET_CODEMP = LOT_CODEMP AND ');
    SQL.Add('                       DET_NUMLOT = LOT_NUMLOT     ');

    If fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica Then
    Begin
      SQL.Add('LEFT JOIN CADLOC ON LOC_CODLOC = G.ITE_LOCFIS AND LOC_CODEMP = G.ITE_CODEMP ');
      SQL.Add('LEFT JOIN CADLSE ON LSE_CODIGO = LOC_CODLSE ');
    End
    Else
      SQL.Add('LEFT JOIN CADLSE ON LSE_CODIGO = G.ITE_CODLSE ');

    If fVaiGravarCONDOR_AUTCOM_DocVenda() Then
      SQL.Add('  LEFT JOIN MOVAUX A ON D.AUTOINCREM = A.DET_SEQGER  ');

    SQL.Add('WHERE                                                  ');
    SQL.Add('  G.ITE_CODEMP = :CODEMP      AND                      ');
    SQL.Add('  D.DET_PROEMB <> "S"         AND                      ');

    If Not fEmptyStr(fCfgSis('ITEMAN', varString)) Then
      SQL.Add('  D.DET_CODITE <> :ITEMAN     AND ');

    If Not fEmptyStr(fCfgSis('ITELAN', varString)) Then
      SQL.Add('  D.DET_CODITE <> :ITELAN     AND ');

    If Not fEmptyStr(fCfgSis('ITEBOM', varString)) Then
      SQL.Add('  D.DET_CODITE <> :ITEBOM     AND ');
    If Not fEmptyStr(fCfgSis('ITETAX', varString)) Then
      SQL.Add('  D.DET_CODITE <> :ITETAX     AND ');
    SQL.Add('  D.DET_CODITE <> :ITESER     AND                      ');
    SQL.Add('  D.DET_CODITE <> :SERTER     AND                      ');
    SQL.Add('  D.DET_TIP_FC = "C"          AND                      ');
    SQL.Add('  D.DET_NUMDOC = :NUMDOC      AND                      ');
    SQL.Add('  D.DET_ESPDOC = :ESPDOC      AND                      ');
    SQL.Add('  D.DET_CODEMP = :CODEMP                               ');

    If ((FParams.stlListaClientes.Count <= 1) And (Not fPermitirMarcarPedidosDeClientesDiferentesNaExpedicao)) Or
       ((FParams.blnFatAut) And (Not fEmptyStr(FParams.strCodCli)) And (Not FParams.blnOndaSeparacao)) Then
      SQL.Add(' AND D.DET_CODCLI = :CODCLI ');

    If FParams.blnUsaImpressaoSeparacaoPorLocal or fPermiteImprimirSeparacaoParcial Then
      SQL.Add(' AND ((DET_QTDITE - DET_QTDEXP) - (DET_QTDITE - DET_QTDSEP)) > 0 ');

    SQL.Add(' AND DET_CODEXT IS NULL '); 

    SQL.Add('HAVING (QTDITE > 0) ');
    If Pos(VS_strExpRetiraEntregaDocFat, 'R_E_') > 0 Then
     SQL.Add('  AND (RETENT = '+QuotedStr(VS_strExpRetiraEntregaDocFat)+')');

    ParamByName('NUMDOC').AsString := FParams.strNumDoc;
    ParamByName('ESPDOC').AsString := FParams.strEspDoc;

    If FindParam('ITEMAN') <> Nil Then
      ParamByName('ITEMAN').AsString := fCfgSis('ITEMAN', varString);

    If FindParam('ITELAN') <> Nil Then
      ParamByName('ITELAN').AsString := fCfgSis('ITELAN', varString);

    If FindParam('ITEBOM') <> Nil Then
      ParamByName('ITEBOM').AsString := fCfgSis('ITEBOM', varString);
    If FindParam('ITETAX') <> Nil Then
      ParamByName('ITETAX').AsString := fCfgSis('ITETAX', varString);
    ParamByName('ITESER').AsString := fCfgSis('ITESER');
    ParamByName('SERTER').AsString := fCfgSis('SERTER');
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    If Assigned(FindParam('CODCLI')) Then
      ParamByName('CODCLI').AsString := FParams.strCodCli;

    Open;
  End;

  pSetaClient(qryItens);

  cdsItens.Close;
  cdsItens.Open;

  blnTemItensTintas := fTemItensTintas;

  cdsItens.OnFilterRecord := pOnFilter;

  blnFecharForm := cdsItens.IsEmpty;

  If (blnFecharForm) Then
    fMensagem('ATENÇÃO!', 'Não há itens neste documento!', ['&Ok']);

  If (pnlResumoUnidadeItens.Visible) Then
    pCarregaResumoUnidadesItens;

end;

function TfrmFatExpedicaoItens.fVaiGravarCONDOR_AUTCOM_DocVenda():Boolean;
begin
  Result := (FParams.VS_strTipExpInterna = TIPEXP_POR_DOCUMENTO_DE_VENDA) And
            (FParams.blnFatAut);
end;

function TfrmFatExpedicaoItens.fConfirmaDocumento(strSepExp: String = ''; blnParcial: Boolean = False; strOpeExp: String = ''; blnSolicitouConfSep: Boolean = False; cdsSetores: TClientDataSet = NIL; strObsExp: String = ''; strCodEmb: String = ''): Boolean;
  var
    strCodConAux,
    strCodSepAux,
    strObsExpAux,
    strEmbExpAux: String;

  procedure pGravarCONDOR_AUTCOM;
  begin
    If Assigned(cdsItens) And (Not cdsItens.IsEmpty) And fVaiGravarCONDOR_AUTCOM_DocVenda() Then
    Begin
      objConDor.pSetClientItens(cdsItens);
      objConDor.pGravar;
    End;
  end;

begin
  Result := True;
  Try
    fStartTransaction;

    cdsItens.DisableControls;
    cdsItens.First;
    While (Not cdsItens.Eof) Do
    Begin
      strCodSepAux := '';
      strEmbExpAux := '';
      strCodConAux := '';
      strObsExpAux := '';

      If (cdsItens.FieldByName('QTDEXP').AsFloat > 0) Then
      Begin
        strCodSepAux := strSepExp;
        strEmbExpAux := strCodEmb;
        strCodConAux := strLoginUsuarioLogado;
        strObsExpAux := strObsExp;

        TFatSeparadorConferente.pSetSetoresParaExp(cdsSetores,
                           cdsItens.FieldByName('CODITE').AsString,
                           strCodConAux,
                           strCodSepAux,
                           strObsExpAux,
                           strEmbExpAux);
      End;

      Result := Result And fAtualizaQtdExpedida(strCodSepAux, strCodConAux, strEmbExpAux, strObsExpAux, cdsItens.FieldByName('AUTOINCREM').AsString, cdsItens.FieldByName('QTDEXP').AsFloat);

      If (FParams.VS_strTipExpInterna = TIPEXP_POR_DOCUMENTO_DE_VENDA) Then
      Begin
        If (fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat, intDecQtd) > 0) Then
          Result := Result And fAtualizaTipBus(cdsItens.FieldByName('AUTOINCREM').AsString, cdsItens.FieldByName('TIPBUS').AsString);
      End;

      cdsItens.Next;
    End;
    pEnableCdsItens();

    If (blnSolicitouConfSep) Or (FParams.blnFatAut) Then
      Result := Result And fSetaOperadorESeparadorDaExpedicao(strSepExp, strOpeExp, FParams.strNumDoc, FParams.strEspDoc, VS_strCodEmp);

    If (Not blnParcial) Then
      Result := Result And fMarcaDocumentoComoExpedido(strSepExp, FParams.strNumDoc, FParams.strEspDoc, VS_strCodEmp, FParams.strCodCli, FParams.strSerie_);

    If (MatchStr(FParams.VS_strTipExpInterna, [TIPEXP_POR_DOCUMENTO_DE_VENDA, TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO])) Then
      Result := Result And fAtualizaOcorrenciaCRM;

    If Result Then
      pGravarCONDOR_AUTCOM();

    If Result Then
      fCommit
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pEnableCdsItens();
      pMensagensErro(E.Message, '[TfrmFatExpedicaoItens.fConfirmaDocumento]');
    End;
  End;
end;

function TfrmFatExpedicaoItens.fGravarNumeroSerieProdutosExpedidos: Boolean;
var
  strNumSerExp: string;
  strCodIteExp: string;
  strNumDocNumSer: string;
begin
  Result := True;
  If btnNumSeries.Visible Then
  Begin
    Result := fGravaSeriesNseDor;
  End
  Else
  Begin
    while (strTodosNumSer <> '') and (strTodosCodIte <> '') and (strTodosPedidos <> '') do
    begin
      Delete(strTodosNumSer,1,1);
      Delete(strTodosCodIte,1,1);
      Delete(strTodosPedidos,1,1);

      strNumSerExp  := Copy(strTodosNumSer,1,Pos(',',strTodosNumSer)-1);
      Delete(strTodosNumSer,1,Pos(',',strTodosNumSer)-1);

      if strNumSerExp = '' then
      begin
        strNumSerExp  := Copy(strTodosNumSer,1,Length(strTodosNumSer));
        Delete(strTodosNumSer,1,Length(strTodosNumSer));
      end;

      strCodIteExp := Copy(strTodosCodIte,1,Pos(',',strTodosCodIte)-1);
      Delete(strTodosCodIte,1,Pos(',',strTodosCodIte)-1);

      if strCodIteExp = '' then
      begin
        strCodIteExp := Copy(strTodosCodIte,1,Length(strTodosCodIte));
        Delete(strTodosCodIte,1,Length(strTodosCodIte));
      end;

      strNumDocNumSer := Copy(strTodosPedidos, 1, Pos(',', strTodosPedidos) - 1);
      Delete(strTodosPedidos, 1, Pos(',', strTodosPedidos) - 1);

      if strNumDocNumSer = '' then
      begin
        strNumDocNumSer := Copy(strTodosPedidos, 1, Length(strTodosPedidos));
        Delete(strTodosPedidos , 1, Length(strTodosPedidos));
      end;

      pUtilizaNumeroSerie(strNumDocNumSer, strNumSerExp, strCodIteExp);
    end;
  End;
end;

function TfrmFatExpedicaoItens.fDescricaoResumidaLocFis: String;
begin
  Result := '';
  If fCfgSis('CTLEST') = '1' Then
    Result := 'LOT:'
  Else If fCfgSis('CTLEST') = '2' Then
    Result := 'AMZ:'
end;

procedure TfrmFatExpedicaoItens.pAtualizaExpedicaoItens(const strCodCon, strCodSep, strObsExp, strEmbExp: string; const blnAtualizaQtdExp: Boolean; fatVenda: TFatVenda = Nil);
var
  strCodConAux,
  strCodSepAux,
  strObsExpAux,
  strEmbExpAux: String;
  intContador: Integer;
begin
  cdsItens.DisableControls;
  try
    cdsItens.First;
    While (Not cdsItens.Eof) Do
    Begin
      strCodConAux := '';
      strCodSepAux := '';
      strObsExpAux := '';
      strEmbExpAux := '';

      If (cdsItens.FieldByName('QTDEXP').AsFloat > 0) Then
      Begin
        strCodConAux := strCodCon;
        strCodSepAux := strCodSep;
        strObsExpAux := strObsExp;
        strEmbExpAux := strEmbExp;

        TFatSeparadorConferente.pSetSetoresParaExp(cdsSetores,
                           cdsItens.FieldByName('CODITE').AsString,
                           strCodConAux,
                           strCodSepAux,
                           strObsExpAux,
                           strEmbExpAux);
      End;

      pAtualizaQtdExpItemPedido(cdsItens.FieldByName('AUTOINCREM').AsString,
                                IIF(blnAtualizaQtdExp, cdsItens.FieldByName('QTDEXP').AsFloat, 0),
                                True,
                                strCodConAux,
                                strCodSepAux,
                                strObsExpAux,
                                strEmbExpAux);

      if Assigned(fatVenda) then
      begin
        For intContador := Low(fatVenda.arrMatItens) To High(fatVenda.arrMatItens) Do
          If fatVenda.arrMatItens[intContador].strSeqDet = cdsItens.FieldByName('AUTOINCREM').AsString Then
          Begin
            fatVenda.arrMatItens[intContador].strOpSeEx := strCodSepAux;
            fatVenda.arrMatItens[intContador].strConExp := strCodConAux;
            fatVenda.arrMatItens[intContador].strEmbExp := strEmbExpAux;
            fatVenda.arrMatItens[intContador].strObsExp := strObsExpAux;
            Break
          End;
      end;

      cdsItens.Next;
    End;
  finally
    pEnableCdsItens();
  end;
end;

procedure TfrmFatExpedicaoItens.pAtualizaInformacaoDoTotalExpedido;
  Var
    fltDesEsp : Double;
    fltTotIte : Double;
    fltTotExp : Double;
    cdsClone : TUniClientDataSet;
begin
  fltDesEsp := 0;
  fltTotIte := 0;
  fltTotExp := 0;

  cdsClone := TUniClientDataSet.Create(Nil);
  pCloneDataSet(cdsClone, cdsItens);
  Try
    cdsClone.Filtered := False;
    cdsClone.Filter   := '(QTDEXP > 0)';
    cdsClone.Filtered := True;
    cdsClone.First;

    cdsClone.First;
    While (Not cdsClone.Eof) Do
    Begin
      If fFormataFloat(cdsClone.FieldByName('QTDEXP').AsFloat, intDecQtd) > 0 Then
      Begin
        fltTotExp := fltTotExp + cdsClone.FieldByName('QTDEXP').AsFloat;

        If (pnlVlrMin.Visible) Then
        Begin
          fltTotIte := fltTotIte + (cdsClone.FieldByName('FDO_UNITAR').AsFloat * cdsClone.FieldByName('QTDEXP').AsFloat);

          If (cdsClone.FieldByName('QTDEXP').AsFloat + cdsClone.FieldByName('QTDBAI').AsFloat) =
             (cdsClone.FieldByName('QTDTOT').AsFloat) Then
          Begin
            fltDesEsp := fltDesEsp + cdsClone.FieldByName('DESESP').AsFloat - cdsClone.FieldByName('DESBAI').AsFloat;
          End
          Else
            fltDesEsp := fltDesEsp + ((cdsClone.FieldByName('DESESP').AsFloat / cdsClone.FieldByName('QTDTOT').AsFloat) *  cdsClone.FieldByName('QTDEXP').AsFloat);
        End;
      End;

      cdsClone.Next;
    End;

    If (fltDesEsp < 0) Then
      fltDesEsp := 0;

    //Sempre que recalcular o desconto especial devemos formatar com 2 decimais
    fltDesEsp := fFormataFloat(fltDesEsp, 2);

    lblVlrExpTot.Caption  := FloatToStrF(fltTotIte-fltDesEsp, ffFixed, 12, 2);
    edtTotalExpedido.Text := FloatToStrF(fltTotExp, ffFixed, 12, 2);
  Finally
    FreeAndNil(cdsClone);
  End;
end;

function TfrmFatExpedicaoItens.fAtualizaOcorrenciaCRM: Boolean;
  Var
    objOcoCrm: TAtuOcoCrm;
Begin
  Result := True;
  Try
    If (VS_strHabilitarCRM) And (Not fEmptyStr(fCfgSis('VENORC', varString))) And (Not fEmptyStr(fCfgSis('VENPED', varString))) Then
    Begin
      objOcoCrm := fAtualizaInformacoesCRM(FParams.strNumDoc, FParams.strEspDoc, FParams.strCodEmp, FParams.strCodCli,'','',strLoginUsuarioLogado,afcExpedicao);
      objOcoCrm.pProcessaFatOcorrenciasCRM;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fAtualizaOcorrenciaCRM]');
    End;
  End;
End;

function TfrmFatExpedicaoItens.fRetQtdDigitada(strCodIte: String): Double;
Begin
  Result := 0;
  cdsItens.DisableControls;
  If (cdsItens.FindFirst) Then
  Begin
    Repeat
      Result := Result + cdsItens.FieldByName('QTDEXP').AsFloat;
    Until (Not cdsItens.FindNext);
  End;
  pEnableCdsItens();
End;

function TfrmFatExpedicaoItens.fRetQtdDigitadaPorLote(strCodIte,
  strNumLot: String): Double;
var
  cdsDados : TUniClientDataSet;
begin
  Result := 0;
  cdsDados := TUniClientDataSet.Create(Self);

  try
    pCloneDataSet(cdsDados, cdsItens);
    cdsDados.Filtered := False;
    cdsDados.Filter   := 'CODITE=' + QuotedStr(strCodIte) + ' AND NUMLOT=' + QuotedStr(strNumLot);
    cdsDados.Filtered := True;
    cdsDados.First;

    while not cdsDados.Eof do
    begin
      Result := Result + cdsDados.FieldByName('QTDEXP').AsFloat;
      cdsDados.Next;
    end;
  finally
    FreeAndNil(cdsDados);
  end;
end;

function TfrmFatExpedicaoItens.fRetQtdPendente(strCodIte: String): Double;
begin
  Result := 0;
  cdsItens.DisableControls;
  If (cdsItens.FindFirst) Then
  Begin
    Repeat
      Result := Result + fRetQtdPendenteItemPosicionado;
    Until (Not cdsItens.FindNext);
  End;
  pEnableCdsItens();
end;

function TfrmFatExpedicaoItens.fRetQtdPendenteItemPosicionado: Double;
begin
  If Not FParams.blnUsaRotinaWMS Then
  Begin
    If FParams.blnUsaImpressaoSeparacaoPorLocal or fPermiteImprimirSeparacaoParcial Then
      Result := cdsItens.FieldByName('QTDDIS').AsFloat - cdsItens.FieldByName('QTDEXP').AsFloat
    Else
      Result := cdsItens.FieldByName('QTDITE').AsFloat - cdsItens.FieldByName('QTDEXP').AsFloat
  End
  Else
    Result := cdsItens.FieldByName('QTDSEP').AsFloat - cdsItens.FieldByName('QTDEXP').AsFloat;
end;

procedure TfrmFatExpedicaoItens.pEhDocumentoDeEmpresaPrioridade(
  var strCodEmpPrioridade: String; strAutInc, strEspdoc: String);
begin
  if fEmptyStr(strCodEmpPrioridade) then
    strCodEmpPrioridade := VS_strCodEmp;

  if strEspdoc <> 'PD' then
    Exit;

  if fCampoTabela('FGO_UPSEML', 'EXTGOR', ['FGO_SEQFGO'], [strAutInc], False) = 'S' then
  begin
    strCodEmpPrioridade := fCampoTabela('FGO_EMP_CD', 'EXTGOR', ['FGO_SEQFGO'], [strAutInc], False);
  end;
end;

function TfrmFatExpedicaoItens.fEhFaturamentoDePedidoOriundoDeConsignacao: Boolean;
begin

  Result := False;

  If Not (FParams.stlPedidos.Count > 0) Then
    Exit;

  If Not TPedidoVenda(FParams.stlPedidos.Objects[0]).strEspDoc.Equals('PD') Then
    Exit;

  If Not (fEhPedidoOriginadoPelaConsignacao(TPedidoVenda(FParams.stlPedidos.Objects[0]).strNumDoc,
                                            TPedidoVenda(FParams.stlPedidos.Objects[0]).strEspDoc,
                                            TPedidoVenda(FParams.stlPedidos.Objects[0]).strCodEmp)) Then
    Exit;

  Result := True;

end;

function TfrmFatExpedicaoItens.fEncontraItem(Var strMensagem : String;
                                             blnAtualizaQtde : Boolean = True): Boolean;
  Var
    fltSaldoItemAtu,
    fltQtdDig,
    fltQtdIte,
    fltEmbala: Double;
    strNumLotEst: String;
    strSemEst: String;
    blnPedSen: Boolean;
    blnSemEst: Boolean;
    recForTin: TForTin;
    itemCaixa: TItemDaCaixa;
    blnBaiSubIte: Boolean;
    blnLimparNumOrc: Boolean;
    blnAchou: Boolean;
    intTentativa: Integer;
    strEmpCar: String;
    strAutoIncremItemCaixa: String;
    fltMltVen: Double;

    strEmpSaldoBaseImobiliaria: String;
    arrLogLibAnt: TArrLogLib;

    objCadLot: TCadLot;
    fltQuanti: Double;
    strCodEmpPrioridade: String;

    function fEhMultiploValido: Boolean;
      Var
        fltMultiplo : Double;
        fltMultUsado: Double;
    begin
      Result := True;

      fltMultiplo  := 0;
      fltMultUsado := 0;

      If (Not blnMarcandoTodos) Then
      Begin
        If fCfgSis('EMBEXP',varBoolean) Then
          fltMultUsado := fltEmbala
        Else
          fltMultUsado := fltMltVen;
      End;

      If (Pos(fCfgSis('DIVMVR', varString), 'A_T_') > 0) Then
      Begin
        If (Not fMultiploValido(cdsItens.FieldByName('CODITE').AsString, fltMultUsado * fStrToFloat(edtQtdIte.Text), fltMultiplo)) Then
        Begin
          If fCfgSis('DIVMVR', varString) = 'A' Then
          Begin
            strMensagem := 'A quantidade de entrega deste produto'+ #13#10 +'diverge de seu múltiplo de venda ( ' + FloatToStrF(fltMultiplo, ffNumber, 12, 2) + ' )!';
            pMensagemSonora(strMensagem);
          End
          Else
          Begin
            strMensagem := 'A quantidade de entrega deve ser múltiplo de ' + FloatToStrF(fltMultiplo, ffNumber, 12, 2) + '!';
            Result := False;
          End;
        End;
      End;
    end;

  function fRetornaSaldoVerificaoEstoqueBaseImobiliaria(strEmpPrdBase: String; fltSaldoBase: Double; strCodIteBase: String): Double;
      function fRetornaSaldoEstoqueEmpresa(strCodEmpBase: String): Double;
      begin
        Result := fCampoTabela('ITE_SALDOS',
                               'ITEGER',
                               ['ITE_CODITE', 'ITE_CODEMP'],
                               [strCodIteBase, strCodEmpBase]);
      end;
  begin
    Result := fltSaldoBase;

    If strEmpPrdBase <> VS_strCodEmp Then
      Result := fRetornaSaldoEstoqueEmpresa(strEmpPrdBase);
  end;
begin
  cdsItens.First;
  Result    := False;
  blnAchou := False;
  fltQtdDig := 0.0;
  strUltAutIncExp := '';

  If ((FParams.VS_strTipExpInterna = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) Or (FParams.VS_strTipExpInterna = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) Then
    fltQtdDig := fRetQtdDigitada(strCodIte);

  arrLogLibAnt := arrLogLib;
  SetLength(arrLogLib, 0);
  Try
    intTentativa := 0;
    Repeat

      Inc(intTentativa);

      If intTentativa = 2 Then
      Begin
        cdsItens.First;
        Result := False;
      End;

      If (cdsItens.FindFirst) Then
      Begin

        Result := True;

        Repeat
          If SameText(strCamBus, 'BAREMB') Then
            fltEmbala := objIteBar.fQuantidadeEmbalagem(cdsItens.FieldByName('CODITE').AsString, strCodDig)
          Else
            fltEmbala := 1;

          fltMltVen := cdsItens.FieldByName('MLTVEN').AsFloat;

          if fltMltVen = 0 then
            fltMltVen := 1;

          fltQtdIte := fFormataFloat(fStrToFloat(edtQtdIte.Text), intDecQtd);

          if fStrToFloat(edtQtdChapas.Text) > 0 then
          begin
            if (cdsItens.FieldByName('GRAMAR').AsString <> 'S') then
            begin
              edtCodIte.Clear;
              strMensagem := 'Quantidade de chapas não permitida para item que não seja mármore/granito';
              Break;
            end;

            objCadLot := TCadLot.Create(Nil, Nil);
            try
              objCadLot.fExisteLote(
                edtCodIte.Text,
                cdsItens.FieldByName('CODEMP').AsString,
                cdsItens.FieldByName('NUMLOT').AsString);

              fltQtdIte := fFormataFloat(fStrToFloat(edtQtdChapas.Text)
                                         * objCadLot.qryCadLot.FieldByName('LOT_MEDL_A').AsFloat
                                         * objCadLot.qryCadLot.FieldByName('LOT_MEDL_L').AsFloat, intDecQtd);
            finally
              FreeAndNil(objCadLot);
            end;
          end;

          If (fCfgSis('EMBEXP',varBoolean)) Then
          begin
            fltQuanti := fFormataFloat(fltEmbala * fltQtdIte, intDecQtd);
            If blnMarcandoTodos Then
              fltQtdIte := fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat + fltQtdIte, intDecQtd)
            Else
              fltQtdIte := fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat + (fltEmbala * fltQtdIte), intDecQtd);
          end
          else
          begin
            fltQuanti := fFormataFloat(fltMltVen * fltQtdIte, intDecQtd);
            If blnMarcandoTodos Then
              fltQtdIte := fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat + fltQtdIte, intDecQtd)
            Else
              fltQtdIte := fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat + (fltMltVen * fltQtdIte), intDecQtd);
          end;

          strCodEmpPrioridade := IfEmptyStr(fRetornaEmpresaExpedicaoSePedidoOutraLoja, VS_strCodEmp);

          If (fExpedicaoPorPedido) And (Assigned(cdsItens.FindField('FDO_SEQGER'))) Then
            pEhDocumentoDeEmpresaPrioridade(strCodEmpPrioridade, cdsItens.FieldByName('FDO_SEQGER').AsString, cdsItens.FieldByName('ESPDOC').AsString);

          If (fEmptyStr(strNumLot) or (cdsItens.FieldByName('NUMLOT').AsString = strNumLot)) Then
          Begin
            If ((intTentativa = 1) And (fFormataFloat(cdsItens.FieldByName('QTDITE').AsFloat, intDecQtd) = fFormataFloat(fltQtdIte, intDecQtd))) Or
               ((intTentativa = 2) And (fFormataFloat(cdsItens.FieldByName('QTDITE').AsFloat, intDecQtd) >= fFormataFloat(fltQtdIte, intDecQtd))) Then
            Begin
              blnAchou := True;

              If fExcedeLimiteItensNFe Then
              Begin
                blnAtualizaQtde := False
              End
              Else If (FParams.blnUsaImpressaoSeparacaoPorLocal or fPermiteImprimirSeparacaoParcial) And
                ((cdsItens.FieldByName('QTDDIS').AsFloat > 0) And (fltQtdIte > cdsItens.FieldByName('QTDDIS').AsFloat)) Then
              Begin
                strMensagem := 'Quantidade informada para expedição excede a quantidade separada ('+FormatFloat('#,##0.0000',cdsItens.FieldByName('QTDDIS').AsFloat)+'), para esse item!';
                Break;
              End
              Else If (FParams.VS_strTipExpInterna = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) Or (FParams.VS_strTipExpInterna = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
              Begin

                If (Not fValidaQTDSEPWMS()) Then
                Begin
                  strMensagem := 'Não é possível expedir o item (' + cdsItens.FieldByName('CODITE').AsString + ') '+
                                 'porque o sistema está configurado para usar WMS e não tem nenhum lote com saldo '+
                                 'vinculado na impressão da separação desse pedido (LOTDOR) e é obrigatório ter pelo '+
                                 'menos 1 lote selecionado. Se for o caso, realize a expedição e o faturamento parcial '+
                                 'ou, peça para o responsável revisar o cadastro e saldos dos lotes desse produto e reimprima a separação.';
                  Break;
                End;

                fatVenEst.strIdePro := cdsItens.FieldByName('IDEPRO').AsString;
                fatVenEst.strCodCli := cdsItens.FieldByName('CODCLI').AsString;
                fatVenEst.strCliNom := cdsItens.FieldByName('NOMCLI').AsString;

                strNumLotEst := IIF(FParams.blnUsaRotinaWMS, '', IIF(cdsItens.FieldByName('NUMLOT').AsString='A DEFINIR','',cdsItens.FieldByName('NUMLOT').AsString));

                If ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And (fCfgSis('EXPATE', varBoolean))) Or (strCodEmpPrioridade <> VS_strCodEmp) Then
                Begin
                  fltSaldoItemAtu := cdsItens.FieldByName('SALDOS').AsFloat;

                  If (Not fEmptyStr(strNumLotEst)) Then
                  Begin
                    objCadLot := TCadLot.Create(Nil, Nil);
                    Try
                      If objCadLot.fExisteLote(cdsItens.FieldByName('CODITE').AsString, strCodEmpPrioridade, strNumLotEst) Then
                      begin
                        fltSaldoItemAtu := objCadLot.qryCadLot.FieldByName('LOT_SALDOS').AsFloat;
                        fltQtdDig := fRetQtdDigitadaPorLote(cdsItens.FieldByName('CODITE').AsString, strNumLotEst);
                      end;
                    Finally
                      FreeAndNil(objCadLot);
                    End;
                  End;

                End
                Else
                Begin
                  fltSaldoItemAtu := cdsItens.FieldByName('SALEST').AsFloat;

                  If (Not fEmptyStr(strNumLotEst)) Then
                  Begin
                    objCadLot := TCadLot.Create(Nil, Nil);
                    Try
                      If objCadLot.fExisteLote(cdsItens.FieldByName('CODITE').AsString, VS_strCodEmp, strNumLotEst) Then
                      begin
                        fltSaldoItemAtu := objCadLot.qryCadLot.FieldByName('LOT_SALDOS').AsFloat;
                        fltQtdDig := fRetQtdDigitadaPorLote(cdsItens.FieldByName('CODITE').AsString, strNumLotEst);
                      end;
                    Finally
                      FreeAndNil(objCadLot);
                    End;
                  End;
                End;

                If (cdsItens.FieldByName('PROACA').AsString = 'S') Then
                Begin
                  fltSaldoItemAtu := TProdAcabado.fRetornaSaldo(cdsItens.FieldByName('CODACA').AsString,
                                                                cdsItens.FieldByName('EMPACA').AsString,
                                                                cdsItens.FieldByName('CODEMP').AsString);

                  fltQtdDig := cdsItens.FieldByName('QTDEXP').AsFloat;
                End;

                {*REQ.148688**********RP*}
                strEmpCar := fatVenEst.fRetEmpCarregamento(cdsItens.FieldByName('CODITE').AsString, (cdsItens.FieldByName('ENTRET').AsString = 'E'));

                If fatVenEst.fEmpCarPreenchidaEmpDif(strEmpCar, VS_strCodEmp) Then
                  fltSaldoItemAtu := fRetSaldosEmpresa(cdsItens.FieldByName('CODITE').AsString, strEmpCar);

                If (cdsItens.FieldByName('IDEPRO').AsString <> 'NOR') Then
                Begin
                  blnLimparNumOrc := False;
                  If fEmptyStr(fatVenEst.strNumOrc) Then
                  Begin
                    blnLimparNumOrc     := True;
                    //Preenche o numero do pedido para poder retornar o saldo reservado
                    //do item, porem <> do pedido que esta sendo expedido
                    fatVenEst.strNumOrc := cdsItens.FieldByName('NUMDOC').AsString;
                  End;

                  If (cdsItens.FieldByName('OPRFLJ').AsString = 'N') And
                     (cdsItens.FieldByName('ENT_CD').AsString = 'S') Then
                    strEmpSaldoBaseImobiliaria := cdsItens.FieldByName('EMP_CD').AsString
                  Else
                    strEmpSaldoBaseImobiliaria := cdsItens.FieldByName('EMPPRD').AsString;

                  If blnLimparNumOrc Then
                    fatVenEst.strNumOrc := '';

                  recForTin.intModDil   := IfNull(cdsItens.FieldByName('FOR_MODDIL').Value, 0);
                  recForTin.strTextBase := IfNull(cdsItens.FieldByName('FOR_TEXBAS').Value, '');
                  recForTin.strTipCor   := IfNull(cdsItens.FieldByName('FOR_TIPCOR').Value, '');
                  recForTin.Formulas    := TClassMatrizSaldosColorantes(fatVenEst.dicFormulas.RetornaObjeto(cdsItens.FieldByName('AUTOINCREM').AsString));

                  If (recForTin.Formulas = nil) Then
                  Begin
                    strMensagem := 'Não será possível expedir o item ' + cdsItens.FieldByName('CODITE').AsString + ', tinta de máquina,' + #13#10 +
                                   'pois sua formulação não foi encontrada, favor verificar !';
                    Exit;
                  End;

                  If cdsItens.FindField('FOR_CATALI') <> Nil Then
                    recForTin.strCatali   := IfNull(cdsItens.FieldByName('FOR_CATALI').Value, '');

                  If (cdsItens.FieldByName('OPRFLJ').AsString = 'N') And
                     (cdsItens.FieldByName('ENT_CD').AsString = 'S') Then
                  Begin
                    recforTin.Formulas.fRecalculaSaldos(cdsItens.FieldByName('EMP_CD').AsString, fltQtdIte, cdsItens.FieldByName('NUMDOC').AsString, FParams.blnUsaRotinaWMS);
                  End
                  Else
                  Begin
                    recforTin.Formulas.fRecalculaSaldos(cdsItens.FieldByName('EMPPRD').AsString, fltQtdIte, cdsItens.FieldByName('NUMDOC').AsString, FParams.blnUsaRotinaWMS);
                  End;
                End;

                blnBaiSubIte := (fCfgSis('BXSBIT') <> '1');

                If (blnBaiSubIte) And
                   (fItemEstrutura(cdsItens.FieldByName('CODITE').AsString)) And
                   (fCfgSis('BXSBIT') = '3') And
                   (fatVenEst.fRetornaSaldoDisponivelItemNormal('',
                                                                cdsItens.FieldByName('CODITE').AsString,
                                                                '',
                                                                cdsItens.FieldByName('AUTOINCREM').AsString,
                                                                cdsItens.FieldByName('CODACA').AsString,
                                                                cdsItens.FieldByName('EMPACA').AsString,
                                                                fltSaldoItemAtu,
                                                                False) >= fltQtdIte) Then
                Begin
                  blnBaiSubIte := False;
                End;

                If (blnBaiSubIte) And (fItemEstrutura(cdsItens.FieldByName('CODITE').AsString)) Then
                Begin
                  blnLimparNumOrc := False;
                  If fEmptyStr(fatVenEst.strNumOrc) Then
                  Begin
                    blnLimparNumOrc     := True;
                    fatVenEst.strNumOrc := cdsItens.FieldByName('NUMDOC').AsString;
                  End;

                  If (Not fatVenEst.fVerificaQtdEstoqueSubItensEstrutura(fatVenEst.strOpcDoc,
                                                                         cdsItens.FieldByName('CODITE').AsString,
                                                                         cdsItens.FieldByName('AUTOINCREM').AsString,
                                                                         fltQtdIte,
                                                                         True,
                                                                         nil,
                                                                         blnPedSen,
                                                                         False,
                                                                         '',
                                                                         cdsItens.FieldByName('ENTRET').AsString,
                                                                         cdsItens.FieldByName('ENTFUT').AsString,
                                                                         cdsItens.FieldByName('MOTFUT').AsString)) Then
                  Begin
                    Exit;
                  End
                  Else
                  Begin
                    If (Length(arrLogLib) > 0) Then
                    Begin
                      pGeraLogLiberacao(cdsItens.FieldByName('NUMDOC').AsString,
                                        cdsItens.FieldByName('ESPDOC').AsString,
                                        cdsItens.FieldByName('CODEMP').AsString);
                      SetLength(arrLogLib, 0);
                    End;
                  End;

                  If blnLimparNumOrc Then
                    fatVenEst.strNumOrc := '';
                End

                Else If Not fatVenEst.fVerificaQtdEstoque(strCodEmpPrioridade,
                                                          'VN',
                                                          'S',  // EntSai
                                                          cdsItens.FieldByName('NUMDOC').AsString,
                                                          cdsItens.FieldByName('AUTOINCREM').AsString,
                                                          cdsItens.FieldByName('CODITE').AsString,
                                                          cdsItens.FieldByName('CODACA').AsString,
                                                          cdsItens.FieldByName('EMPACA').AsString,
                                                          cdsItens.FieldByName('DESCRI').AsString,
                                                          cdsItens.FieldByName('ENTRET').AsString,
                                                          cdsItens.FieldByName('ENTFUT').AsString,
                                                          cdsItens.FieldByName('MOTFUT').AsString,
                                                          fltQtdIte,
                                                          fltQtdDig,
                                                          cdsItens.FieldByName('QTDEXP').AsFloat,//Quantidade Anterior
                                                          fltSaldoItemAtu,
                                                          cdsItens.FieldByName('QTDEXP').AsFloat > 0,//Alterando
                                                          strSemEst,
                                                          TRUE,
                                                          blnPedSen,
                                                          blnSemEst,
                                                          recForTin,
                                                          False,
                                                          strNumLotEst,
                                                          True,
                                                          '',
                                                          IIF(fatVenEst.fEmpCarPreenchidaEmpDif(strEmpCar, VS_strCodEmp), strEmpCar, ''),
                                                          '',
                                                          strCodEmpPrioridade <> VS_strCodEmp) Then
                  Exit
                Else
                Begin
                  If (Length(arrLogLib) > 0) Then
                  Begin
                    pGeraLogLiberacao(cdsItens.FieldByName('NUMDOC').AsString,
                                      cdsItens.FieldByName('ESPDOC').AsString,
                                      cdsItens.FieldByName('CODEMP').AsString);
                    SetLength(arrLogLib, 0);
                  End;
                End;
              End;

              If blnAtualizaQtde Then
              Begin
                If (Not fEhMultiploValido) Then
                Begin
                  Break;
                End
                Else If (Frac(fStrToFloat(edtQtdIte.Text)) <> 0) And
                        (fItemNaoFracionavel('VN', cdsItens.FieldByName('ITE_CODUNI').AsString)) Then
                Begin
                  {**********************************************************************}
                  { CHECAGEM ADICIONAL, CASO O USUÁRIO TENTE DIGITAR UM VALOR FRACIONADO }
                  { SEM APAGAR A VÍRGULA DA MÁSCARA                                      }
                  {*******************************************************************VA*}
                  strMensagem := 'Não é permitido informar valor fracionado para esse item!';
                  Break;
                End
                Else
                Begin
                  If (fControlarMontagemDeCaixaPorPedido) Then
                  Begin
                    strAutoIncremItemCaixa := fIdentificadorDoItemNoPedidoDaCaixaAberta;

                    If (fEmptyStr(strAutoIncremItemCaixa)) Then
                    Begin
                      edtCodIte.Clear;
                      strMensagem := 'Não é permitido incluir um item de um pedido em uma caixa com sequencial de outro pedido.';
                      Break;
                    End
                    Else If (Not cdsItens.FieldByName('AUTOINCREM').AsString.Equals(strAutoIncremItemCaixa)) Then
                    Begin
                      pAtualizaItemPertencenteACaixaAberta(strAutoIncremItemCaixa, strMensagem);
                      Break;
                    End;
                  End;

                  cdsItens.Edit;

                  if dtaInicioConferencia = 0 then
                    dtaInicioConferencia := fNow;

                  cdsItens.FieldByName('QTDEXP').AsFloat := fltQtdIte;

                  If (strCamBus = 'CODITE') And (Not blnOndaSepComCodBar) Then
                    cdsItens.FieldByName('TIPBUS').AsString := 'C';

                  If fUsaMontagemCaixas And Assigned(objMontarCaixas.CaixaAberta) Then
                    cdsItens.FieldByName('EXP_CX').AsString := 'S'
                  Else
                    cdsItens.FieldByName('EXP_CX').AsString := 'N';

                  blnInsParcial := cdsItens.FieldByName('QTDEXP').AsFloat < cdsItens.FieldByName('QTDITE').AsFloat;

                  cdsItens.Post;

                  If (cdsItens.FindField('AUTOINCREM') <> Nil) Then
                    strUltAutIncExp := cdsItens.FieldByName('AUTOINCREM').AsString;

                  If fUsaMontagemCaixas And Assigned(objMontarCaixas.CaixaAberta) Then
                  Begin
                    With itemCaixa Do
                    Begin
                      strID           := cdsItens.FieldByName('AUTOINCREM').AsString;
                      strCodigo       := cdsItens.FieldByName('CODITE').AsString;
                      strDescricao    := cdsItens.FieldByName('DESCRI').AsString;
                      strSiglaUnidade := cdsItens.FieldByName('UNIDAD').AsString;
                      strPedido       := cdsItens.FieldByName('NUMDOC').AsString;
                      fltQuantidade   := fltQuanti;
                      fltPeso         := cdsItens.FieldByName('PESOIT').AsFloat;
                      strCodFab       := cdsItens.FieldByName('CODFAB').AsString;
                      strFgoInc       := cdsItens.FieldByName('FGOINC').AsString;
                    End;

                    If itemCaixa.fltQuantidade > 0 Then
                    Begin
                      objMontarCaixas.CaixaAberta.pAdicionarItem(itemCaixa);
                      pPrencheGridItensCaixa;
                    End;
                  End;

                End;

                If Assigned(objCodBar) Then
                Begin
                  objCodBar.pAddCodBar(strCodDig, cdsItens.FieldByName('CODITE').AsString, fltQuanti);
                End;

              End;

              edtQtdIte.Text := FloatToStrF(1, ffFixed, 12, intDecQtd);
              edtQtdChapas.Text := FloatToStrF(0, ffFixed, 12, intDecQtd);
              strMensagem := '';
              blnIncluirNumSer := True;
              Break;
            End
            Else If intTentativa = 2 Then
            Begin
              blnIncluirNumSer := False;
              If fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat, intDecQtd) >=
                 fFormataFloat(cdsItens.FieldByName('QTDITE').AsFloat, intDecQtd) Then
                strMensagem := 'Produto (' + edtCodIte.Text + iif(fEmptyStr(strCodIteFor),'',' - '+strCodIteFor) + ') já foi totalmente expedido!'
              Else
                strMensagem := 'Quantidade não permitida para o produto (' + edtCodIte.Text + iif(fEmptyStr(strCodIteFor),'',' - '+strCodIteFor) + ').';
            End;
          End
          Else
          Begin
            If blnValidouLotePeloCodigoBarrasDoLote Then
              strMensagem := fMensagemValidacaoPeloCodigoBarrasDoLote(edtCodIte.Text, strNumLot, cdsItens)
            Else
              strMensagem := 'Lote ' + strNumLot + ' não encontrado para o produto (' + edtCodIte.Text + iif(fEmptyStr(strCodIteFor),'',' - '+strCodIteFor) + ').';
          End;

        Until (Not cdsItens.FindNext);

      End;

    Until (intTentativa = 2) Or (blnAchou);
  Finally
    arrLogLib := arrLogLibAnt;
  End;

  If Result And (not fEmptyStr(strMensagem)) And (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And fCfgSis('EXPETG', varBoolean) And (cdsItens.FieldByName('ENTSAI').AsString = 'S') Then
  Begin
    blnSeparacaoErrada := True;
    strMensagem := 'Produto (' + edtCodIte.Text + iif(fEmptyStr(strCodIteFor),'',' - '+strCodIteFor) + ') foi separado a mais!'+#13+
                             'Será impressa a etiqueta para guarda-lo.';
  End;
end;

procedure TfrmFatExpedicaoItens.btnExpAutClick(Sender: TObject);
begin
  inherited;

  If (Not btnExpAut.Visible) Or (Not btnExpAut.Enabled) Then
    Exit;

  If (Not btnConfirma.Enabled) Then
    Exit;

  If InterlockedIncrement(intSemaforoExpAut) = 0 Then
  Begin
    Try
      dtsItens.DataSet := nil;
      TfrmGravando.fExecutarModalA(pExpedicaoAutomatica, 'Aguarde, Realizando Expedição Automática ...', '');
      dtsItens.DataSet := cdsItens;
    Finally
      InterlockedDecrement(intSemaforoExpAut);
    End;
  End
  Else
    InterlockedDecrement(intSemaforoExpAut);
end;

procedure TfrmFatExpedicaoItens.pExpedicaoAutomatica;
begin
  If Not fVerificaAcessoSistema('EXPAUT', strLoginUsuarioLogado) Then
  Begin
    If fCfgSis('BQEXPA', varBoolean) Then
    Begin
      If Not fLiberacaoExpedicaoAutomatica Then
        Exit;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!', ['&Ok']);
      Exit;
    End;
  End;

  If (fUsaMontagemCaixas) And (Not Assigned(objMontarCaixas.CaixaAberta)) And (fCfgSis('OACEXP', varBoolean)) Then
  Begin
    pMensagemOk('Para iniciar a conferência de um produto, é necessário estar com uma caixa aberta.');
    Exit;
  End;

  btnExpAut.Enabled := False;
  btnExpAut.Tag := 1;
  blnValidaNumeroSerie := False;

  try
    pMarcarTodosProdutos(True);
    btnConfirma.Click;
  finally
    btnExpAut.Tag := 0;
    blnValidaNumeroSerie := True;
    btnExpAut.Enabled := True;
  end;

  If FParams.blnExpAut Then
    tmrClose.Enabled := True;
End;

procedure TfrmFatExpedicaoItens.pFatCaixaPedidoAutInc(stlLstPed: TStringList; strAutInc: String);
  Var
    qryFgoCai : TUniQuery;
    intCnt : Integer;
    objPedido : TPedidoVenda;
begin
  If Not fUsaMontagemCaixas Then
    Exit;

  qryFgoCai := fCriaQuery(Self);
  Try
    For intCnt := 0 To stlLstPed.Count -1 Do
    Begin
      objPedido := TPedidoVenda(stlLstPed.Objects[intCnt]);
      If (Assigned(objPedido)) And (Not fEmptyStr(objPedido.strSeqGer)) Then
      Begin
        qryFgoCai.Close;
        qryFgoCai.SQL.Clear;
        qryFgoCai.SQL.Add(' UPDATE FGOCAI ');
        qryFgoCai.SQL.Add('    SET FGC_DETINC = :DETINC  ');
        qryFgoCai.SQL.Add('  WHERE FGC_FGOINC = :FGOINC  ');
        qryFgoCai.SQL.Add('    AND FGC_FDOINC = :FDOINC  ');

        qryFgoCai.ParamByName('FGOINC').AsString := objPedido.strSeqGer;
        qryFgoCai.ParamByName('FDOINC').AsString := strAutInc;

        qryFgoCai.ParamByName('DETINC').AsString := fRetAutIncMovdet(strAutInc);

        qryFgoCai.ExecSQL;
      End;
    End;
  Finally
    FreeAndNil(qryFgoCai);
  End;
end;

procedure TfrmFatExpedicaoItens.pFaturarCaixasPedidos(stlLstPed: TStringList;
  strNumFat, strTipFat, strEmpFat: String);
  Var
    qryFgoCai : TUniQuery;
    intCnt : Integer;
    objPedido : TPedidoVenda;
begin
  If Not fUsaMontagemCaixas Then
    Exit;

  qryFgoCai := fCriaQuery(Self);
  Try
    For intCnt := 0 To stlLstPed.Count -1 Do
    Begin
      objPedido := TPedidoVenda(stlLstPed.Objects[intCnt]);
      If (Assigned(objPedido)) And (Not fEmptyStr(objPedido.strSeqGer)) Then
      Begin
        qryFgoCai.Close;
        qryFgoCai.SQL.Clear;
        qryFgoCai.SQL.Add(' UPDATE FGOCAI ');
        qryFgoCai.SQL.Add('    SET FGC_NUMFAT = :NUMFAT, ');
        qryFgoCai.SQL.Add('        FGC_TIPFAT = :TIPFAT, ');
        qryFgoCai.SQL.Add('        FGC_EMPFAT = :EMPFAT  ');
        qryFgoCai.SQL.Add('  WHERE FGC_FGOINC = :FGOINC  ');
        qryFgoCai.ParamByName('NUMFAT').AsString := strNumFat;
        qryFgoCai.ParamByName('TIPFAT').AsString := strTipFat;
        qryFgoCai.ParamByName('EMPFAT').AsString := strEmpFat;
        qryFgoCai.ParamByName('FGOINC').AsString := objPedido.strSeqGer;
        qryFgoCai.ExecSQL;
      End;
    End;
  Finally
    FreeAndNil(qryFgoCai);
  End;
end;

function TfrmFatExpedicaoItens.fFaturamentoParcialUtilizandoLocTransitoria(const ASeqFGO: String): Boolean;
var
  LQry: TUniQuery;
begin
  Result := False;

  if (not fGuardarItensSeparadosQuandoUtilizarLocTransitoriaVAGAO) then
    Exit;

  LQry := fCriaQuery;

  try
    LQry.SQL.Add('SELECT F.AUTOINCREM, FDO_QTDEXP ');
    LQry.SQL.Add('FROM LOTDOR L ');
    LQry.SQL.Add('INNER JOIN EXTDOR ON LDO_SEQFDO = FDO_SEQFDO ');
    LQry.SQL.Add('INNER JOIN FATDOR F ON F.AUTOINCREM = FDO_SEQFDO ');
    LQry.SQL.Add('WHERE FDO_SEQGER = :SEQFGO ');
    LQry.SQL.Add('GROUP BY F.AUTOINCREM ');
    LQry.SQL.Add('HAVING SUM(LDO_QTDSEP) <> FDO_QTDEXP ');
    LQry.ParamByName('SEQFGO').AsString := ASeqFGO;
    LQry.Open;

    Result := (not LQry.IsEmpty);
  finally
    FreeAndNil(LQry);
  end;
end;

function TfrmFatExpedicaoItens.fFecharCaixa():Boolean;
Var
  blnResp:Boolean;
begin
  Result := False;

  If fAtivadoMontagemCaixaConferenciaAUTCOMColetor Then
  Begin
    If (cximgCaixas.ItemIndex <> -1) And
       (cxImgDimensaoCaixa.ItemIndex = 0) Then
    Begin
      pMensagemOk('Selecione uma dimensão para caixa.');
      Exit;
    End;
  End;

  If Not fTemCaixaAberta() Then
  Begin
    If (Not fEscondeMensagensAberturaEFechamentoCaixa()) And (Not chkCaixaRapida.Checked) Then
      pMensagemOk('Não há caixa em montagem para ser fechada!');

    Result := True;
  End
  Else If Not objMontarCaixas.CaixaAberta.blnTemItens Then
  Begin
    If (Not fEscondeMensagensAberturaEFechamentoCaixa()) And (Not chkCaixaRapida.Checked) Then
      blnResp := fPergunta('Não foram inseridos produtos na caixa ' + objMontarCaixas.CaixaAberta.strID + ', ' +
                           'portanto ainda não é possível fechar a mesma. ' +
                           'Deseja cancelar a montagem desta caixa?')
    Else
      blnResp := True;

    If (blnResp) Then
    Begin
      objMontarCaixas.pCancelarMontagemCaixa;
      pPreencheListaCaixas;
      cximgCaixas.ItemIndex := cximgCaixas.Properties.Items.Count -1;
      pPrencheGridItensCaixa;
      pSetaBotaoMontarCaixas(CAP_MONTAR_CAIXA);

      Result := (Not fTemCaixaAberta());
    End;
  End
  Else
  Begin
    If (Not fEscondeMensagensAberturaEFechamentoCaixa()) And (Not chkCaixaRapida.Checked) Then
      blnResp := fPergunta('Confirma o fechamento da caixa?')
    Else
      blnResp := True;

    If (blnResp) Then
    Begin
      if fValidaPesoCaixa then
      Begin
        If Not fTemCaixaAberta() Then
        Begin
          pPreencheListaCaixas;
          pSetaBotaoMontarCaixas(CAP_MONTAR_CAIXA);
          Result := True;
          Exit;
        End;

        If fAtivadoMontagemCaixaConferenciaAUTCOMColetor Then
        Begin
          objMontarCaixas.CaixaAberta.strCodMcx :=
            cxImgDimensaoCaixa.Properties.Items[cxImgDimensaoCaixa.ItemIndex].Value;
        End;

        objMontarCaixas.pFecharCaixa;
        pPreencheListaCaixas;
        cximgCaixas.ItemIndex := cximgCaixas.Properties.Items.Count -1;
        pPrencheGridItensCaixa;
        pSetaBotaoMontarCaixas(CAP_MONTAR_CAIXA);

        Result := (Not fTemCaixaAberta());

        If (Result) And (chkImpSeq.Checked) Then
          btnImpEtiCaixa.Click;
      End;
    End;
  End;
end;

procedure TfrmFatExpedicaoItens.btnMarcarTudoClick(Sender: TObject);
begin
  inherited;

  If Not btnMarcarTudo.Visible Then
    Exit;

  If Not fVerificaAcessoSistema('EXPMTD', strLoginUsuarioLogado) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!', ['&Ok']);
    Exit;
  End;

  dtsItens.DataSet := nil;
  TfrmGravando.fExecutarModalA(pMarcarTodos, 'Aguarde, Marcando Produtos ...', '');
  dtsItens.DataSet := cdsItens;
end;

procedure TfrmFatExpedicaoItens.pMarcarTodos;
var LMensagem: String;
    intIndice: Integer;
begin
  pMarcarTodosProdutos;

  If (stlItensNumSerieExpAut.Count > 0) Then
  Begin
    LMensagem := 'Os itens abaixo contém número de série e não podem ser marcados automaticamente:';

    for intIndice := 0 to stlItensNumSerieExpAut.Count - 1 do
    begin
      LMensagem :=  LMensagem + sLineBreak + Concat(stlItensNumSerieExpAut[intIndice], '-', fRetNomProduto(stlItensNumSerieExpAut[intIndice]));
    end;

    pMensagemOk(LMensagem);
  end;
end;

procedure TfrmFatExpedicaoItens.pMarcarTodosProdutos(blnExpAut: Boolean = False; blnMarcaRegAtual : Boolean = False; fltQtdPar: Double = 0; blnVerificaNecessidadeDeExpedicaoDoProduto: Boolean = False);
  var
    intRecNo: Integer;
    fltQtdIte: Double;
    strIndexFieldNames,
    strIndexName: String;
    blnBaiSubIte: Boolean;
begin
  intRecNo := 0;
  cdsItens.DisableControls;
  blnIgnorarScroll := True;
  blnMarcandoTodos := True;
  stlItensNumSerieExpAut.Clear;
  Try
    If VS_strTipDEx = '1' Then
    Begin
      With cdsItens Do
      Begin
        cdsItens.IndexFieldNames := 'AUTOINCREM';

        If (Not blnMarcaRegAtual) Then
          First;

        While (Not Eof) Or (blnMarcaRegAtual) Do
        Begin
          If (blnVerificaNecessidadeDeExpedicaoDoProduto) And (Not fProdutoSemNecessidadeDeExpedicao(cdsItens.FieldByName('CODITE').AsString)) Then
          Begin
            Next;
            Continue;
          End;

          if (fProdutoComControleDeNumeroSerie(cdsItens.FieldByName('CODITE').AsString, cdsItens.FieldByName('EMPITE').AsString)) then
          Begin
            stlItensNumSerieExpAut.Add(cdsItens.FieldByName('CODITE').AsString);
            Next;
            Continue;
          End;


          If (blnMarcaRegAtual) And (fltQtdPar > 0) Then
            fltQtdIte := fltQtdPar
          //Somente deve expedir a quantidade que foi separada quando rotina WMS
          Else If Not FParams.blnUsaRotinaWMS Then
          Begin
            If FParams.blnUsaImpressaoSeparacaoPorLocal or fPermiteImprimirSeparacaoParcial Then
              fltQtdIte := cdsItens.FieldByName('QTDDIS').AsFloat
            Else
              fltQtdIte := cdsItens.FieldByName('QTDITE').AsFloat
          End
          Else If Assigned(cdsItens.FindField('PEGOU_')) And (cdsItens.FieldByName('PEGOU_').AsString = 'S') Then
            fltQtdIte := cdsItens.FieldByName('QTDITE').AsFloat
          Else If FParams.VS_strTipExpInterna <> TIPEXP_POR_DOCUMENTO_DE_VENDA Then
          Begin
            fltQtdIte := cdsItens.FieldByName('QTDSEP').AsFloat;

            If fVaiCompararQuantidadeComColetor() Then
              fltQtdIte := cdsItens.FieldByName('QTDCOL').AsFloat;
          End
          Else
            fltQtdIte := cdsItens.FieldByName('QTDITE').AsFloat;

          {************************************************************}
          { Se estiver configurado para usar "Liberar somente produtos }
          { com saldo suficiente", então só liberará esses produtos.   }
          {*********************************************************RV*}
          If (fCfgSis('LIBSAL') = 'S') Then
          Begin
            blnBaiSubIte := (fCfgSis('BXSBIT') <> '1');

            If (blnBaiSubIte) And
               (fItemEstrutura(cdsItens.FieldByName('CODITE').AsString)) And
               (fCfgSis('BXSBIT') = '3') And
               (cdsItens.FieldByName('SALEST').AsFloat >= fltQtdIte) Then
            Begin
              blnBaiSubIte := False;
            End;

            If (blnBaiSubIte) And (fItemEstrutura(cdsItens.FieldByName('CODITE').AsString)) Then
            Begin
              If Not fValidaEstoqueSubItensEstrutura(cdsItens.FieldByName('CODITE').AsString, fltQtdIte,
                                                     cdsItens.FieldByName('NUMDOC').AsString) Then
                fltQtdIte := 0;
            End
            Else If (cdsItens.FieldByName('SALEST').AsFloat < fltQtdIte) Then
              fltQtdIte := cdsItens.FieldByName('SALEST').AsFloat;

            If fltQtdIte <= 0 Then
            Begin

              If Not blnMarcaRegAtual Then
              Begin
                Next;
                Continue;
              End
              Else
                Break;

            End;
          End;

          If fExcedeLimiteItensNFe Then
            Break;

          Try
            intRecNo := RecNo;
            strIndexFieldNames := cdsItens.IndexFieldNames;
            strIndexName := cdsItens.IndexName;

            If FieldByName('QTDEXP').AsFloat < fltQtdIte Then
            Begin
              edtCodIte.Text := cdsItens.FieldByName('CODITE').AsString;
              edtQtdIte.Text := FloatToStrF(fltQtdIte - cdsItens.FieldByName('QTDEXP').AsFloat, ffFixed, 12, intDecQtd);
              pExpedeItem(blnExpAut);
            End;
          Finally

            if not fEmptyStr(strIndexFieldNames) then
              cdsItens.IndexFieldNames := strIndexFieldNames
            else if not fEmptyStr(strIndexName) then
              cdsItens.IndexName := strIndexName;

            RecNo := intRecNo;
          End;

          If Not blnMarcaRegAtual Then
            Next
          Else
            Break;

        End;

      End;
    End
    Else
    Begin
      With cdsItens Do
      Begin
        cdsItens.IndexFieldNames := 'AUTOINCREM';

        If Not blnMarcaRegAtual Then
          First;

        While (Not Eof) Or (blnMarcaRegAtual) Do
        Begin
          If (blnVerificaNecessidadeDeExpedicaoDoProduto) And (Not fProdutoSemNecessidadeDeExpedicao(cdsItens.FieldByName('CODITE').AsString)) Then
          Begin
            Next;
            Continue;
          End;

          if (fProdutoComControleDeNumeroSerie(cdsItens.FieldByName('CODITE').AsString, cdsItens.FieldByName('EMPITE').AsString)) then
          Begin
            stlItensNumSerieExpAut.Add(cdsItens.FieldByName('CODITE').AsString);
            Next;
            Continue;
          End;

          intRecNo := RecNo;
          strIndexFieldNames := cdsItens.IndexFieldNames;
          strIndexName := cdsItens.IndexName;

          If (blnMarcaRegAtual) And (fltQtdPar > 0) Then
            fltQtdIte := fltQtdPar
          //Somente deve expedir a quantidade que foi separada quando rotina WMS
          Else If Not FParams.blnUsaRotinaWMS Then
          Begin
            If FParams.blnUsaImpressaoSeparacaoPorLocal or fPermiteImprimirSeparacaoParcial Then
              fltQtdIte := cdsItens.FieldByName('QTDDIS').AsFloat
            Else
              fltQtdIte := cdsItens.FieldByName('QTDITE').AsFloat
          End
          Else If Assigned(cdsItens.FindField('PEGOU_')) And (cdsItens.FieldByName('PEGOU_').AsString = 'S') Then
            fltQtdIte := cdsItens.FieldByName('QTDITE').AsFloat
          Else If FParams.VS_strTipExpInterna <> TIPEXP_POR_DOCUMENTO_DE_VENDA Then
            fltQtdIte := cdsItens.FieldByName('QTDSEP').AsFloat
          Else
            fltQtdIte := cdsItens.FieldByName('QTDITE').AsFloat;

          Try
            If FieldByName('QTDEXP').AsFloat < fltQtdIte Then
            Begin
              If fExcedeLimiteItensNFe Then
                Break;

              edtCodIte.Text := FieldByName('CODITE').AsString;
              edtQtdIte.Text := FloatToStrF(fltQtdIte - FieldByName('QTDEXP').AsFloat, ffFixed, 12, intDecQtd);
              pExpedeItem(blnExpAut);
            End;
          Finally

            if not fEmptyStr(strIndexFieldNames) then
              cdsItens.IndexFieldNames := strIndexFieldNames
            else if not fEmptyStr(strIndexName) then
              cdsItens.IndexName := strIndexName;

            RecNo := intRecNo;
          End;

          If Not blnMarcaRegAtual Then
            Next
          Else
            Break;

        End;

      End;
    End;

    If fCfgSis('LIBSAL', varBoolean) And (Not fTemItensExpedidos) Then
    Begin
      pMensagemOk('Nenhum produto possui saldo suficiente para ser expedido.');
    End;

  Finally
    blnIgnorarScroll := False;
    blnMarcandoTodos := False;
    pOrdenarItens;
    pEnableCdsItens();
  End;
end;

procedure TfrmFatExpedicaoItens.pImprimeListaCaixas(blnAvisaSemMov : Boolean);
  Var
    caixa: TCaixa;
    item: TItemDaCaixa;
    stlPed: TStringList;
    intIndex : Integer;
    blnImprime : Boolean;
    strTipImp : String;
    frmModuloFatExpedicaoItens: TfrmModuloFatExpedicaoItens;
begin
  inherited;

  If Not (fCfgSis('MONCAI', varBoolean) And (fCfgSis('IMPCAI', varString) = '2')) Then
    Exit;

  If Not fUsaMontagemCaixas Then
    Exit;

  pPrencheGridItensCaixa(True);

  If cdsEtiCaixa.RecordCount <= 0 Then
  Begin
    If blnAvisaSemMov Then
      fMensagem('','Não existe caixas para esse pedido!', ['&OK']);
    Exit;
  End;

  pCarregaConfImpr(qryCfgRel, Self.Name + '_caixas');
  blnImprime := fPreImpressao(qryCfgRel, strNomImp, strTipImp, False, 'I');

  If not blnImprime Then
    Exit;

  caixa := Nil; //hint
  For intIndex := 0 To cximgCaixas.Properties.Items.Count - 1 Do
  Begin
    caixa := objMontarCaixas.fBuscaCaixa(cximgCaixas.Properties.Items[intIndex].Value);

    stlPed := TStringList.Create;

    stlPed.Sorted := True;
    stlPed.Duplicates := dupIgnore;

    For item In caixa.Itens Do
      If stlPed.IndexOf(item.strPedido) < 0 Then
        stlPed.Add(item.strPedido);
  End;

  If Not qryItensSemCaixa.SQL.Text.IsEmpty Then
  Begin
    qryItensSemCaixa.Close;
    qryItensSemCaixa.Open;
    qryItensSemCaixa.First;
    While Not qryItensSemCaixa.Eof Do
    Begin
      cdsEtiCaixa.AppendRecord(['',
                                qryItensSemCaixa.FieldByName('FDO_NUMDOC').AsString,
                                qryItensSemCaixa.FieldByName('FDO_CODITE').AsString,
                                qryItensSemCaixa.FieldByName('FDO_DESCRI').AsString,
                                qryItensSemCaixa.FieldByName('FDO_QTDVOL').AsFloat,
                                qryItensSemCaixa.FieldByName('UNI_SIGUNI').AsString,
                                qryItensSemCaixa.FieldByName('ITE_PESOIT').AsFloat,
                                11111,
                                qryItensSemCaixa.FieldByName('ITE_CODFAB').AsString]);
      qryItensSemCaixa.Next;
    End;
  End;

  pCriarFormularios(TfrmModuloFatExpedicaoItens, frmModuloFatExpedicaoItens);
  Try
    frmModuloFatExpedicaoItens.frxListCaixa.Script.Variables['CAIXA']    := caixa.strID;
    frmModuloFatExpedicaoItens.frxListCaixa.Script.Variables['PEDIDOS']  := stlPed.CommaText;
    frmModuloFatExpedicaoItens.frxListCaixa.Script.Variables['CLIENTE']  := cdsItens.FieldByName('CODCLI').AsString + ' - ' + cdsItens.FieldByName('NOMCLI').AsString;
    frmModuloFatExpedicaoItens.frxListCaixa.Script.Variables['TRANSPORTADORA']  := cdsItens.FieldByName('CODTRA').AsString + ' - ' + cdsItens.FieldByName('NOMTRA').AsString;
    frmModuloFatExpedicaoItens.frxListCaixa.Script.Variables['FATOR']    := fCfgSis('FATPLI');

    If FileExists( fCfgSis('PATLOG',varString) ) Then
      TfrxPictureView( frmModuloFatExpedicaoItens.frxListCaixa.FindObject('imgLogo') ).Picture.LoadFromFile( fCfgSis('PATLOG',varString) );

    cdsEtiCaixa.First;
    cdsEtiCaixa.IndexFieldNames := 'SeqCx';

    If Not fEmptyStr(Self.strNomImp) Then
      frmModuloFatExpedicaoItens.frxListCaixa.PrintOptions.Printer    := Self.strNomImp;

    frmModuloFatExpedicaoItens.frxListCaixa.PrintOptions.Copies := fCfgSis('QTDCVO', varInteger);

    If (frmModuloFatExpedicaoItens.frxListCaixa.PrintOptions.Copies = 0) Then
      frmModuloFatExpedicaoItens.frxListCaixa.PrintOptions.Copies := 1;

    frmModuloFatExpedicaoItens.frxDBEtiqCaixa.DataSet := cdsEtiCaixa;

    If fMensagem('Volumes', 'Selecione a opção desejada:', ['&Imprimir', '&Visualizar']) = 1 Then
    Begin
      frmModuloFatExpedicaoItens.frxListCaixa.PrintOptions.ShowDialog := False;
      If frmModuloFatExpedicaoItens.frxListCaixa.PrepareReport Then
        pPrintReport(Self.Name + '_caixas', Self.Caption + ' (Lista Caixas)', strNomImp, frmModuloFatExpedicaoItens.frxListCaixa);
    End
    Else
      pPreviewReport(Self.Name + '_caixas', Self.Caption + ' (Lista Caixas)', frmModuloFatExpedicaoItens.frxListCaixa);

    cdsEtiCaixa.Filtered := False;
    cdsEtiCaixa.Filter := 'SeqCx = '+QuotedStr('11111');
    cdsEtiCaixa.Filtered := True;
    While Not cdsEtiCaixa.IsEmpty Do
      cdsEtiCaixa.Delete;
    cdsEtiCaixa.Filtered := False;

    FreeAndNil(stlPed);
  Finally
    pFreeAndNil(frmModuloFatExpedicaoItens);
  End;
End;

procedure TfrmFatExpedicaoItens.btnImpEtiCaixaClick(Sender: TObject);
var
  strLayout: String;
  strModelo: String;

  procedure pProcessaItensCaixa(Var stlLstIte: TStringList; Var caixa: TCaixa);
  var
    intNumItensEtiq: Integer;
    strLstIte: String;
  begin
    caixa := objMontarCaixas.fBuscaCaixa(cximgCaixas.Properties.Items[cximgCaixas.ItemIndex].Value);

    pPrencheGridItensCaixa;

    stlLstIte.Clear;
    intNumItensEtiq := 0;
    strLstIte := '';

    cdsEtiCaixa.DisableControls;
    Try
      cdsEtiCaixa.First;

      While Not cdsEtiCaixa.Eof Do
      Begin
        strLstIte := strLstIte +
                     fldEtiCaixacodigo.AsString +' - '+
                     FormatFloat('#,##0.00', cdsEtiCaixaquantidade.AsFloat) +' '+
                     fldEtiCaixaunidade.AsString +' '+
                     strngfldEtiCaixadescricao.Text +#13;

        cdsEtiCaixa.Next;
        Inc(intNumItensEtiq);

        If (fCfgSis('IMPCAI', varInteger) = 3) And (intNumItensEtiq = fCfgSis('QIETCX', varInteger)) Then
        Begin
          intNumItensEtiq := 0;
          stlLstIte.Add(strLstIte);
          strLstIte := '';
        End;
      End;

      If Not fEmptyStr(strLstIte) Then
        stlLstIte.Add(strLstIte);
    finally
      cdsEtiCaixa.EnableControls;
    End;
  end;

  procedure pEtiquetaGerado;
  var
    caixa: TCaixa;
    item: TItemDaCaixa;
    stlPed: TStringList;
    cdsCaixa: TUniClientDataSet;
    blnPreview: Boolean;
    intVolumes: Integer;
    intCaixaFechada: Integer;
    intTotCaixaFecha: Integer;
    intTotalDeCaixas: Integer;
    intCols: Integer;
    intCont: Integer;
    intNumEtiq: Integer;
    stlLstIte: TStringList;
    strTexto: String;
    strValue: String;
    strTextoDes: String;
    strValueDes: String;
    strTextoDun : string;
    strValueDun : string;
    strTextoQuc : string;
    strValueQuc : string;
  Begin

    If cximgCaixas.ItemIndex <> -1 Then
    Begin

      stlLstIte := TStringList.Create;

      stlPed := TStringList.Create;
      stlPed.Sorted := True;
      stlPed.Duplicates := dupIgnore;

      cdsCaixa := TUniClientDataSet.Create(Self);
      TMontarCaixas.pCriarCamposDataSetEtiquetaMontagemCaixas(cdsCaixa);

      intCaixaFechada  := 0;
      intTotCaixaFecha := 0;

      Try
        (*  criar loop para any número de volumes *)
        if ( fCfgSis('IMPCAI', varInteger) = 3) or
           ( fCfgSis('IMPCAI', varInteger) = 4) then
        begin

          if chkTodasAsCaixas.Checked then
          begin
            // Apenas as caixas que foram fechadas
            for intTotalDeCaixas := 0 to cximgCaixas.Properties.Items.Count -1 do
            begin
              cximgCaixas.ItemIndex := intTotalDeCaixas;
              If objMontarCaixas.fBuscaCaixa(cximgCaixas.Properties.Items[cximgCaixas.ItemIndex].Value).blnFechada Then
                Inc(intTotCaixaFecha);
            end;

            // Impressão de todas as caixas
            for intTotalDeCaixas := 0 to cximgCaixas.Properties.Items.Count -1 do
            begin
              cximgCaixas.ItemIndex := intTotalDeCaixas;

              pProcessaItensCaixa(stlLstIte, caixa);

              If objMontarCaixas.fBuscaCaixa(cximgCaixas.Properties.Items[cximgCaixas.ItemIndex].Value).blnFechada Then
              Begin
                If (intCaixaFechada = 0) And (intTotalDeCaixas >= 1) Then // foi feito assim, para o contador não se perder na somatória
                  intCaixaFechada := intTotalDeCaixas
                Else
                  Inc(intCaixaFechada)
              End
              Else
                intCaixaFechada  := 0;

              cdsEtiCaixa.DisableControls;
              Try
                cdsEtiCaixa.Last;
                intVolumes := cdsEtiCaixa.RecordCount;

                for intNumEtiq := 0 to stlLstIte.Count - 1 do
                begin
                  cdsCaixa.Append;

                  if ( fCfgSis('IMPCAI', varInteger) = 4 ) Then
                  Begin
                    If fCfgSis('MTACAX', varString) = 'Z' Then
                      cdsCaixa.FieldByName('CAIXA').AsString  := Copy(cximgCaixas.Properties.Items[intTotalDeCaixas].Value, Pos('-', cximgCaixas.Properties.Items[intTotalDeCaixas].Value) + 1, 3);
                  End
                  Else
                    cdsCaixa.FieldByName('CAIXA').AsString  := caixa.strID;

                  cdsCaixa.FieldByName('BAICLI').AsString := cdsItens.FieldByName('BAICLI').AsString;
                  cdsCaixa.FieldByName('CEPCLI').AsString := cdsItens.FieldByName('C_E_P_').AsString;
                  cdsCaixa.FieldByName('CIDCLI').AsString := fRetNomCidade(cdsItens.FieldByName('CODCID').AsString,0);
                  cdsCaixa.FieldByName('CODFAB').AsString := cdsItens.FieldByName('CODFAB').AsString;
                cdsCaixa.FieldByName('ENDCLI').AsString := cdsItens.FieldByName('ENDERE').AsString + ', ' +
                                                           cdsItens.FieldByName('ENDNUM').AsString + '- ' +
                                                           cdsItens.FieldByName('ENDCOM').AsString;

                cdsCaixa.FieldByName('BAIENT').AsString := cdsItens.FieldByName('BAIENT').AsString;
                cdsCaixa.FieldByName('CEPENT').AsString := cdsItens.FieldByName('CEPENT').AsString;
                cdsCaixa.FieldByName('CIDENT').AsString := cdsItens.FieldByName('CIDENT').AsString;
                cdsCaixa.FieldByName('ENDENT').AsString := cdsItens.FieldByName('ENDENT').AsString;
                cdsCaixa.FieldByName('ESTENT').AsString := cdsItens.FieldByName('ESTENT').AsString;

                cdsCaixa.FieldByName('ESTCLI').AsString := fRetNomCidade(cdsItens.FieldByName('CODCID').AsString,1);
                cdsCaixa.FieldByName('FANSOB').AsString := cdsItens.FieldByName('FANSOB').AsString;
                cdsCaixa.FieldByName('NUMDOC').AsString := cdsItens.FieldByName('NUMDOC').AsString;
                  cdsCaixa.FieldByName('NUMCMP').AsString := cdsItens.FieldByName('NUMCMP').AsString;
                  cdsCaixa.FieldByName('NOMROT').AsString := cdsItens.FieldByName('NOMROT').AsString;
                  cdsCaixa.FieldByName('DTAROT').AsString := cdsItens.FieldByName('DTAENT').AsString;
                  cdsCaixa.FieldByName('NOMTRA').AsString := cdsItens.FieldByName('NOMTRA').AsString;
                  cdsCaixa.FieldByName('NOMCLI').AsString := cdsItens.FieldByName('NOMCLI').AsString;
                  cdsCaixa.FieldByName('NOMCID').AsString := fRetNomCidade(cdsItens.FieldByName('CODCID').AsString,0)+'-'+
                                                             fRetNomCidade(cdsItens.FieldByName('CODCID').AsString,1);

                  if ( fCfgSis('IMPCAI', varInteger) = 4 ) Then
                  Begin
                    If fCfgSis('MTACAX', varString) = 'Z' Then
                    Begin
                      caixa := objMontarCaixas.fBuscaCaixa(cximgCaixas.Properties.Items[intTotalDeCaixas].Value);
                      caixa.fltPesoTotal := 0;
                      for intCont := 0 to Length(caixa.Itens)-1 do
                      Begin
                        caixa.fltPesoTotal := caixa.fltPesoTotal +
                                             (caixa.Itens[intCont].fltQuantidade *
                                              caixa.Itens[intCont].fltPeso);
                      End;

                      cdsCaixa.FieldByName('TOTPES').AsFloat := caixa.fltPesoTotal;
                    End
                  End
                  Else
                    cdsCaixa.FieldByName('TOTPES').AsString := FormatFloat('#,##0.00 KG', caixa.fltPesoTotal);

                  cdsCaixa.FieldByName('NUMPED').AsString := cdsItens.FieldByName('NUMDOC').AsString;
                  cdsCaixa.FieldByName('NOMSEP').AsString := cdsItens.FieldByName('SEPEXP').AsString+'-'+
                                                             fRetNomVendRep(cdsItens.FieldByName('SEPEXP').AsString);
                  cdsCaixa.FieldByName('NOMCNF').AsString := cdsItens.FieldByName('OPEEXP').AsString+'-'+
                                                             fRetNomVendRep(cdsItens.FieldByName('OPEEXP').AsString);
                  cdsCaixa.FieldByName('NOMVD1').AsString := cdsItens.FieldByName('CODVEN').AsString+'-'+
                                                             fRetNomVendRep(cdsItens.FieldByName('CODVEN').AsString);
                  cdsCaixa.FieldByName('NOMVD2').AsString := cdsItens.FieldByName('CODVE2').AsString+'-'+
                                                             fRetNomVendRep(cdsItens.FieldByName('CODVE2').AsString);
                  cdsCaixa.FieldByName('NUMVOL').AsString := FormatFloat('00', intVolumes);
                  cdsCaixa.FieldByName('CODBAR').AsString := cdsItens.FieldByName('BAREMB').AsString;
                  cdsCaixa.FieldByName('CLICOD').AsString := cdsItens.FieldByName('CODCLI').AsString;
                  cdsCaixa.FieldByName('PESPED').AsString := FParams.strPesoPedido;
                  cdsCaixa.FieldByName('CODOPE').AsString := strLoginUsuarioLogado;
                  cdsCaixa.FieldByName('NOMOPE').AsString := fRetNomeOperador(strLoginUsuarioLogado);
                  cdsCaixa.FieldByName('TCAXFE').AsString := FormatFloat('00/', intCaixaFechada) + FormatFloat('00', intTotCaixaFecha);

                  cdsEtiCaixa.First;
                  intCols := 1;
                  strValue := StringOfChar(' ' , 54);
                  strTexto := '';
                  strValueDes := EmptyStr;
                  strTextoDes := EmptyStr;
                  strValueDun := EmptyStr;
                  strTextoDun := EmptyStr;
                  strValueQuc := EmptyStr;
                  strTextoQuc := EmptyStr;

                  while not cdsEtiCaixa.Eof do
                  begin

                    If intCols = 4 Then
                       intCols:= 1;
                    insert(fPadL(FormatFloat('##0', cdsEtiCaixaquantidade.AsFloat), 4), strValue, Trunc(IIF(intCols = 1, 1, (intCols-1)*18)));
                    insert(Copy(fPadR(cdsEtiCaixacodfab.asString, 13), 1 , 13) , strValue, Trunc((IIF(intCols = 1, 1, (intCols-1)*18) + 5)));
                    strValue := Copy(strValue, 1,54);

                    strValueDes := FormatFloat('##0', cdsEtiCaixaquantidade.AsFloat) + ' - ' +
                                   fldEtiCaixacodigo.asString + ' - ' + strngfldEtiCaixadescricao.asString;
                    strValueDes := Copy(strValueDes, 1, 54);
                    strValueDes := strValueDes + #13;

                    strTextoDes := strTextoDes + strValueDes;

                    strValueDun := FormatFloat('##0', cdsEtiCaixaquantidade.AsFloat) + ' - ' +
                                                      fldEtiCaixacodigo.asString + ' - ' +
                                                      strngfldEtiCaixadescricao.asString + ' - ' +
                                                      fldEtiCaixaunidade.AsString;

                    strValueDun := strValueDun + #13;
                    strTextoDun := strTextoDun + strValueDun;

                    strValueQuc := FormatFloat('##0', cdsEtiCaixaquantidade.AsFloat) + ' - ' +
                                                      fldEtiCaixaunidade.AsString + ' - ' +
                                                      fldEtiCaixacodigo.asString + ' - ' +
                                                      strngfldEtiCaixadescricao.asString ;

                    strValueQuc := strValueQuc + #13;
                    strTextoQuc := strTextoQuc + strValueQuc;

                    cdsEtiCaixa.Next;

                    inc(intCols);
                    if intCols = 4 then
                    Begin
                      strTexto := strTexto + strValue + #13;
                      strValue := StringOfChar(' ' , 54);
                    End;
                  End;
                  if intCols < 4 then
                    strTexto := strTexto + strValue;

                  cdsCaixa.FieldByName('LSTFAB').AsString := strTexto;
                  cdsCaixa.FieldByName('LSTDES').AsString := strTextoDes;
                  cdsCaixa.FieldByName('LSTDUN').AsString := strTextoDun;
                  cdsCaixa.FieldByName('LSTQUC').AsString := strTextoQuc;
                  cdsCaixa.FieldByName('LSTITE').AsString := stlLstIte[intNumEtiq];
                  cdsCaixa.FieldByName('CODROT').AsString := cdsItens.FieldByName('CODROT').AsString;
                  cdsCaixa.FieldByName('CAI_ID').AsString := Copy(caixa.strID,14,3);

                  cdsCaixa.FieldByName('FANEMP').AsString := fRetNomeEmpresa(cdsItens.FieldByName('CODEMP').AsString);
                  cdsCaixa.FieldByName('NOMEMP').AsString := fRetFantasiaEmpresa(cdsItens.FieldByName('CODEMP').AsString);

                  pGravarDadosEtiqueta(cdsCaixa, caixa);
                  if cdsCaixa.State in [dsEdit, dsInsert] then
                    cdsCaixa.Post;
                end;
              Finally
                cdsEtiCaixa.EnableControls;
              End;
            end;
          end
          else
          begin
            // Impressão da caixa selecionada
            cdsEtiCaixa.DisableControls;
            Try
              cdsEtiCaixa.Last;
              intVolumes := cdsEtiCaixa.RecordCount;

              If objMontarCaixas.fBuscaCaixa(cximgCaixas.Properties.Items[cximgCaixas.ItemIndex].Value).blnFechada Then
                Inc(intCaixaFechada);

              pProcessaItensCaixa(stlLstIte, caixa);

              for intNumEtiq := 0 to stlLstIte.Count - 1 do
              begin
                cdsCaixa.Append;

                if ( fCfgSis('IMPCAI', varInteger) = 4 ) Then
                Begin
                  if fCfgSis('MTACAX', varString) = 'Z' Then
                    cdsCaixa.FieldByName('CAIXA').AsString  := Copy(caixa.strID, Pos('-', caixa.strID) + 1, 3);
                End
                Else
                  cdsCaixa.FieldByName('CAIXA').AsString  := caixa.strID;

                cdsCaixa.FieldByName('BAICLI').AsString := cdsItens.FieldByName('BAICLI').AsString;
                cdsCaixa.FieldByName('CEPCLI').AsString := cdsItens.FieldByName('C_E_P_').AsString;
                cdsCaixa.FieldByName('CIDCLI').AsString := fRetNomCidade(cdsItens.FieldByName('CODCID').AsString,0);
                cdsCaixa.FieldByName('CODFAB').AsString := cdsItens.FieldByName('CODFAB').AsString;
                  cdsCaixa.FieldByName('ENDCLI').AsString := cdsItens.FieldByName('ENDERE').AsString + ', ' +
                                                             cdsItens.FieldByName('ENDNUM').AsString + '- ' +
                                                             cdsItens.FieldByName('ENDCOM').AsString;

                  cdsCaixa.FieldByName('BAIENT').AsString := cdsItens.FieldByName('BAIENT').AsString;
                  cdsCaixa.FieldByName('CEPENT').AsString := cdsItens.FieldByName('CEPENT').AsString;
                  cdsCaixa.FieldByName('CIDENT').AsString := cdsItens.FieldByName('CIDENT').AsString;
                  cdsCaixa.FieldByName('ENDENT').AsString := cdsItens.FieldByName('ENDENT').AsString;
                  cdsCaixa.FieldByName('ESTENT').AsString := cdsItens.FieldByName('ESTENT').AsString;

                  cdsCaixa.FieldByName('ESTCLI').AsString := fRetNomCidade(cdsItens.FieldByName('CODCID').AsString,1);
                  cdsCaixa.FieldByName('FANSOB').AsString := cdsItens.FieldByName('FANSOB').AsString;
                  cdsCaixa.FieldByName('NUMDOC').AsString := cdsItens.FieldByName('NUMDOC').AsString;
                cdsCaixa.FieldByName('NUMCMP').AsString := cdsItens.FieldByName('NUMCMP').AsString;
                cdsCaixa.FieldByName('TOTPES').AsString := FormatFloat('#,##0.00 KG', caixa.fltPesoTotal);
                cdsCaixa.FieldByName('NOMROT').AsString := cdsItens.FieldByName('NOMROT').AsString;
                cdsCaixa.FieldByName('DTAROT').AsString := cdsItens.FieldByName('DTAENT').AsString;
                cdsCaixa.FieldByName('NOMTRA').AsString := cdsItens.FieldByName('NOMTRA').AsString;
                cdsCaixa.FieldByName('NOMCLI').AsString := cdsItens.FieldByName('NOMCLI').AsString;
                cdsCaixa.FieldByName('NOMCID').AsString := fRetNomCidade(cdsItens.FieldByName('CODCID').AsString,0)+'-'+
                                                           fRetNomCidade(cdsItens.FieldByName('CODCID').AsString,1);

                If ( fCfgSis('IMPCAI', varInteger) = 4 ) Then
                Begin
                  if fCfgSis('MTACAX', varString) = 'Z' Then
                  Begin
                    caixa.fltPesoTotal := 0;
                    for intCont := 0 to Length(caixa.Itens)-1 do
                    Begin
                      caixa.fltPesoTotal := caixa.fltPesoTotal +
                                           (caixa.Itens[intCont].fltQuantidade *
                                            caixa.Itens[intCont].fltPeso);
                    End;

                    cdsCaixa.FieldByName('TOTPES').AsFloat := caixa.fltPesoTotal;
                  End;
                End
                Else
                  cdsCaixa.FieldByName('TOTPES').AsString := FormatFloat('#,##0.00 KG', caixa.fltPesoTotal);

                cdsEtiCaixa.First;
                intCols := 1;
                strValue := StringOfChar(' ' , 54);
                strTextoDes := EmptyStr;
                strValueDes := EmptyStr;
                strTextoDun := EmptyStr;
                strValueDun := EmptyStr;
                strValueQuc := EmptyStr;
                strTextoQuc := EmptyStr;

                while not cdsEtiCaixa.Eof do
                begin

                  If intCols = 4 Then
                     intCols:= 1;
                  insert(fPadL(FormatFloat('##0', cdsEtiCaixaquantidade.AsFloat), 4), strValue, Trunc(IIF(intCols = 1, 1, (intCols-1)*18)));
                  insert(Copy(fPadR(cdsEtiCaixacodfab.asString, 13), 1 , 13) , strValue, Trunc((IIF(intCols = 1, 1, (intCols-1)*18) + 5)));
                  strValue := Copy(strValue, 1,54);

                  strValueDes := FormatFloat('##0', cdsEtiCaixaquantidade.AsFloat) + ' - ' +
                                   fldEtiCaixacodigo.asString + ' - ' + strngfldEtiCaixadescricao.asString;
                  strValueDes := Copy(strValueDes, 1, 54);
                  strValueDes := strValueDes + #13;

                  strTextoDes := strTextoDes + strValueDes;

                  strValueDun := FormatFloat('##0', cdsEtiCaixaquantidade.AsFloat) + ' - ' +
                                                    fldEtiCaixacodigo.asString + ' - ' +
                                                    strngfldEtiCaixadescricao.asString + ' - ' +
                                                    fldEtiCaixaunidade.AsString;

                  strValueDun := strValueDun + #13;
                  strTextoDun := strTextoDun + strValueDun;

                  strValueQuc := FormatFloat('##0', cdsEtiCaixaquantidade.AsFloat) + ' - ' +
                                                    fldEtiCaixaunidade.AsString + ' - ' +
                                                    fldEtiCaixacodigo.asString + ' - ' +
                                                    strngfldEtiCaixadescricao.asString ;

                  strValueQuc := strValueQuc + #13;
                  strTextoQuc := strTextoQuc + strValueQuc;

                  cdsEtiCaixa.Next;

                  inc(intCols);
                  if intCols = 4 then
                  Begin
                    strTexto := strTexto + strValue + #13;
                    strValue := StringOfChar(' ' , 54);
                  End;
                End;
                if intCols < 4 then
                  strTexto := strTexto + strValue;

                cdsCaixa.FieldByName('LSTFAB').AsString := strTexto;
                cdsCaixa.FieldByName('LSTDES').AsString := strTextoDes;
                cdsCaixa.FieldByName('LSTDUN').AsString := strTextoDun;
                cdsCaixa.FieldByName('LSTQUC').AsString := strTextoQuc;
                cdsCaixa.FieldByName('NUMPED').AsString := cdsItens.FieldByName('NUMDOC').AsString;
                cdsCaixa.FieldByName('NOMSEP').AsString := cdsItens.FieldByName('SEPEXP').AsString+'-'+
                                                           fRetNomVendRep(cdsItens.FieldByName('SEPEXP').AsString);
                cdsCaixa.FieldByName('NOMCNF').AsString := cdsItens.FieldByName('OPEEXP').AsString+'-'+
                                                           fRetNomVendRep(cdsItens.FieldByName('OPEEXP').AsString);
                cdsCaixa.FieldByName('NOMVD1').AsString := cdsItens.FieldByName('CODVEN').AsString+'-'+
                                                           fRetNomVendRep(cdsItens.FieldByName('CODVEN').AsString);
                cdsCaixa.FieldByName('NOMVD2').AsString := cdsItens.FieldByName('CODVE2').AsString+'-'+
                                                           fRetNomVendRep(cdsItens.FieldByName('CODVE2').AsString);
                cdsCaixa.FieldByName('NUMVOL').AsString := FormatFloat('00', intVolumes);
                cdsCaixa.FieldByName('CODBAR').AsString := cdsItens.FieldByName('BAREMB').AsString;
                cdsCaixa.FieldByName('CLICOD').AsString := cdsItens.FieldByName('CODCLI').AsString;
                cdsCaixa.FieldByName('PESPED').AsString := FParams.strPesoPedido;
                cdsCaixa.FieldByName('CODOPE').AsString := strLoginUsuarioLogado;
                cdsCaixa.FieldByName('NOMOPE').AsString := fRetNomeOperador(strLoginUsuarioLogado);

                If chkImpSeq.Checked Then
                  cdsCaixa.FieldByName('TCAXFE').AsString := FormatFloat('00/', (cximgCaixas.ItemIndex+1)) + FormatFloat('00', StrToInt(edtVolume.Text))
                Else
                  cdsCaixa.FieldByName('TCAXFE').AsString := FormatFloat('00/', intCaixaFechada) + FormatFloat('00', intCaixaFechada);

                cdsCaixa.FieldByName('LSTITE').AsString := stlLstIte[intNumEtiq];
                cdsCaixa.FieldByName('CODROT').AsString := cdsItens.FieldByName('CODROT').AsString;
                cdsCaixa.FieldByName('CAI_ID').AsString := Copy(caixa.strID,14,3);

                cdsCaixa.FieldByName('FANEMP').AsString := fRetNomeEmpresa(cdsItens.FieldByName('CODEMP').AsString);
                cdsCaixa.FieldByName('NOMEMP').AsString := fRetFantasiaEmpresa(cdsItens.FieldByName('CODEMP').AsString);

                pGravarDadosEtiqueta(cdsCaixa, caixa);
                if cdsCaixa.State in [dsEdit, dsInsert] then
                  cdsCaixa.Post;
              end;
            Finally
              cdsEtiCaixa.EnableControls;
            End;
          end;
        end
        else if ( fCfgSis('IMPCAI', varInteger) = 1 ) then
        begin
          pProcessaItensCaixa(stlLstIte, caixa);

          For item In caixa.Itens Do
            stlPed.Add(item.strPedido);

          cdsCaixa.Append;
          cdsCaixa.FieldByName('CAIXA').AsString   := caixa.strID;
          cdsCaixa.FieldByName('PESO').AsString    := FormatFloat('#,##0.00 KG', caixa.fltPesoTotal);
          cdsCaixa.FieldByName('CLIENTE').AsString := cdsItens.FieldByName('CODCLI').AsString + '-' + cdsItens.FieldByName('NOMCLI').AsString;
          cdsCaixa.FieldByName('PEDIDO').AsString  := stlPed.CommaText;
          cdsCaixa.FieldByName('CAI_ID').AsString  := Copy(caixa.strID,14,3);

          pGravarDadosEtiqueta(cdsCaixa, caixa);
          cdsCaixa.Post;
        end;

        If chkImpSeq.Checked Then
          blnPreview := False
        Else
          blnPreview := (fMensagem('Etiqueta', 'Selecione a opção desejada:', ['&Imprimir', '&Visualizar']) = 2);

        pGeraEtiquetaMontagemCaixas(cdsCaixa, blnPreview);

      Finally
        FreeAndNil(stlPed);
        FreeAndNil(stlLstIte);
        FreeAndNil(cdsCaixa);
      End

    End
    Else
      pMensagemOk('Nenhuma caixa foi selecionada para impressão da etiqueta!');

  End;

  procedure pEtiquetaFr3;
  var caixa: TCaixa;
       item: TItemDaCaixa;
     stlPed: TStringList;
     blnPreview: Boolean;
     frmModuloFatExpedicaoItens : TfrmModuloFatExpedicaoItens;
     intTotalCaixas: Integer;
     intIdx: Integer;
  Begin
    If cximgCaixas.ItemIndex <> -1 Then
    Begin
      blnPreview := False;

      pCarregaConfImpr(qryCfgRel, Self.Name);
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      If Not fVerificaImpressora(strNomImp) Then
      Begin
        fMensagem('','Impressora configurada incorretamente para a fila "' + Self.Name + '"!',['&OK']);
        Exit;
      End;

      If chkTodasAsCaixas.Checked Then
      Begin
        intTotalCaixas := cximgCaixas.Properties.Items.Count;
      End
      Else
      Begin
        intTotalCaixas := 1;
      End;

      For intIdx := 0 To intTotalCaixas -1 Do
      Begin
        If chkTodasAsCaixas.Checked Then
          cximgCaixas.ItemIndex := intIdx;

        caixa := objMontarCaixas.fBuscaCaixa(cximgCaixas.Properties.Items[cximgCaixas.ItemIndex].Value);

        pPrencheGridItensCaixa;

        stlPed := TStringList.Create;
        Try
          stlPed.Sorted := True;
          stlPed.Duplicates := dupIgnore;

          For item In caixa.Itens Do
            stlPed.Add(item.strPedido);

          pCriarFormularios(TfrmModuloFatExpedicaoItens,frmModuloFatExpedicaoItens);
          Try
            If FileExists(fCfgSis('PATETI') + '\etiqueta_expedicao_caixa_fechada.fr3') Then
              frmModuloFatExpedicaoItens.frxEtiqCaixa.LoadFromFile(fCfgSis('PATETI') + '\etiqueta_expedicao_caixa_fechada.fr3');

            frmModuloFatExpedicaoItens.frxEtiqCaixa.Script.Variables['CAIXA']    := caixa.strID;
            frmModuloFatExpedicaoItens.frxEtiqCaixa.Script.Variables['PEDIDOS']  := stlPed.CommaText;
            frmModuloFatExpedicaoItens.frxEtiqCaixa.Script.Variables['CLIENTE']  := cdsItens.FieldByName('CODCLI').AsString + '-' + cdsItens.FieldByName('NOMCLI').AsString;
            frmModuloFatExpedicaoItens.frxEtiqCaixa.Script.Variables['PESO']     := FormatFloat('#,##0.00 KG', caixa.fltPesoTotal);

            cdsEtiCaixa.First;

            If Not fEmptyStr(Self.strNomImp) Then
            Begin
              frmModuloFatExpedicaoItens.frxEtiqCaixa.PrintOptions.Printer    := Self.strNomImp;
              frmModuloFatExpedicaoItens.frxEtiqCaixa.PrintOptions.ShowDialog := False;
            End;

            frmModuloFatExpedicaoItens.frxDBEtiqCaixa.DataSet := cdsEtiCaixa;

            If chkImpSeq.Checked Then
              blnPreview := False
            Else If intIdx = 0 Then
              blnPreview := (fMensagem('Etiqueta', 'Selecione a opção desejada:', ['&Imprimir', '&Visualizar']) = 2);


            If blnPreview Then
            Begin
              pPreviewReport(Self.Name, Self.Caption + ' (Etiqueta Caixa)', frmModuloFatExpedicaoItens.frxEtiqCaixa);
            End
            Else
            Begin
              If frmModuloFatExpedicaoItens.frxEtiqCaixa.PrepareReport Then
                pPrintReport(Self.Name, Self.Caption + ' (Etiqueta Caixa)', Self.strNomImp, frmModuloFatExpedicaoItens.frxEtiqCaixa);
            End;
          Finally
            pFreeAndNil(frmModuloFatExpedicaoItens);
          End;
        Finally
          FreeAndNil(stlPed);
        End;
      End;
    End
    Else
      pMensagemOk('Nenhuma caixa foi selecionada para impressão da etiqueta!');

  End;

begin
  inherited;
  If blnImprimindoEtiquetaCaixa Then
    Exit;

  If Not fUsaMontagemCaixas Then
    Exit;

  If Not (cximgCaixas.Properties.Items.Count > 0) Then
  Begin
    pMensagemOk('Não existe caixas para impressão de etiquetas!');
    Exit;
  End;

  if ( fCfgSis('IMPCAI', varInteger) = 1 ) then
  begin

    If fCfgSis('MTACAX', varString) = 'L' Then
      strModelo:= '130'
    Else
    If fCfgSis('MTACAX', varString) = 'A' Then
      strModelo:= '200'
    Else
    If fCfgSis('MTACAX', varString) = 'Z' Then
      strModelo:= '201';

    strLayout := VarToStrDef(fCampoTabela('LAY_RELFR3', 'LAYETI', ['LAY_TIPLAY','LAY_CODEMP'], [strModelo, Vs_strCodEmp]), '');
  end
  else if ( fCfgSis('IMPCAI', varInteger) = 3 ) then
  begin
    strLayout := VarToStrDef(fCampoTabela('LAY_RELFR3', 'LAYETI', ['LAY_TIPLAY','LAY_CODEMP'], ['165', Vs_strCodEmp]), '');
  end
  else if ( fCfgSis('IMPCAI', varInteger) = 4 ) then
  begin
    strLayout := VarToStrDef(fCampoTabela('LAY_RELFR3', 'LAYETI', ['LAY_TIPLAY','LAY_CODEMP'], ['209', Vs_strCodEmp]), '');
  end;

  blnImprimindoEtiquetaCaixa := True;
  Try
    if fEmptyStr(strLayout) then
    begin
      pEtiquetaFr3;
    end
    else
    begin
       pEtiquetaGerado;
    end;
  Finally
    blnImprimindoEtiquetaCaixa := False;
  End;

end;

procedure TfrmFatExpedicaoItens.btnImpEtiCaixaMouseEnter(Sender: TObject);
begin
  inherited;
  pnlInfCaixa.Caption := 'Pressione [F5] para imprimir a etiqueta da caixa selecionada.';
end;

procedure TfrmFatExpedicaoItens.btnImpEtiCaixaMouseLeave(Sender: TObject);
begin
  inherited;
  pnlInfCaixa.Caption := '';
end;

procedure TfrmFatExpedicaoItens.btnItensNaoExpedidosClick(Sender: TObject);
Var
  strDocumentos: String;
begin
  If Not fVerificaAcessoSistema('PATEXPITE', strLoginUsuarioLogado) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!', ['&Ok']);
    Exit;
  End;

  If Not btnItensNaoExpedidos.Visible Then
    Exit;

  If Not btnItensNaoExpedidos.Enabled Then
    Exit;

  strDocumentos := '';

  cdsItens.first;
  While not cdsItens.eof do
  Begin
    strDocumentos := strDocumentos + cdsItens.FieldByName('NUMDOC').AsString + '_' + cdsItens.FieldByName('ESPDOC').AsString + '_' + cdsItens.FieldByName('CODEMP').AsString + '_' + cdsItens.FieldByName('CODCLI').AsString + '|';
    cdsItens.Next;
  End;

  If Assigned(prcExecutaRelatorio) Then
  Begin
      prcExecutaRelatorio(297, 9584, [],
                          ['FILDOC'],
                          [strDocumentos],
                          Sender,
                          nil,
                          True);
  End;

end;

procedure TfrmFatExpedicaoItens.btnLimpaExpClick(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModalA(pLimparExpedicao, 'Aguarde, Limpando Expedição ...', '');
end;

procedure TfrmFatExpedicaoItens.pLiberarExpedidos;
var
  strOperador: string;
  blnTemAcessoMarcarTudo: Boolean;
begin
  If (lblLimparExpedido.Visible) And (cdsItens.RecNo > 0) And
     ((Not fUsaMontagemCaixas) Or (fLimparExpedido And fUsaMontagemCaixas And (Not objMontarCaixas.fBuscaItemNasCaixas(cdsItens.FieldByName('AUTOINCREM').AsString)))) Then
  Begin
    blnTemAcessoMarcarTudo := fVerificaAcessoSistema('EXPMTD', strLoginUsuarioLogado);
    If (blnTemAcessoMarcarTudo) Or
       (ffrmSenha(strOperador)) Then
    Begin
      If (blnTemAcessoMarcarTudo) Or
         (fVerificaAcessoSistema('LIMEXP', fRetCodVendedor(strOperador))) Then
      Begin
        cdsItens.Edit;
        cdsItens.FieldByName('QTDEXP').AsFloat := 0;
        cdsItens.Post;
        objCodBar.pDelCodBar(cdsItens.FieldByName('CODITE').AsString);
      End
      Else
        fMensagem('', 'Operador informado não possui direitos de acesso para ' + #13#10 +
                      'limpar a quantidade expedida do produto!', ['&Ok']);
    End;
  End;
end;

procedure TfrmFatExpedicaoItens.pLimpaPesoTempItens;
var
  qryPeso: TUniQuery;
  intIndice: integer;
begin
  qryPeso := fCriaQuery;

  try
    qryPeso.Close;
    qryPeso.SQL.Clear;
    qryPeso.SQL.Add('UPDATE EXTGOR');
    qryPeso.SQL.Add('SET FGO_PEBRTE = 0.00,');
    qryPeso.SQL.Add('    FGO_PELITE = 0.00 ');
    qryPeso.SQL.Add('WHERE FGO_SEQFGO = :AUTINC');

    for intIndice := 0 to FParams.stlPedidos.Count - 1 do
    begin
      qryPeso.Close;
      qryPeso.ParamByName('AUTINC').AsString := TPedidoVenda(FParams.stlPedidos.Objects[intIndice]).strSeqGer;
      qryPeso.ExecSQL;
    end;
  finally
    FreeAndNil(qryPeso);
  end;
end;

procedure TfrmFatExpedicaoItens.pLimparDigitacaoDeSeries(const cdsItens : TUniClientDataSet);
begin
  If Not Assigned(objFatSerieItem) Then
    Exit;
  If (Not cdsItens.Active) Then
    Exit;
  If (cdsItens.IsEmpty) Then
    Exit;
  objFatSerieItem.AutoincItem := cdsItens.FieldByName('AUTOINCREM').AsString;
  objFatSerieItem.pLimparDigitacaoDeSeries;
end;

procedure TfrmFatExpedicaoItens.pLimparExpedicao;
  Var
    strOperador : String;
    blnTemAcessoMarcarTudo : Boolean;
begin
  inherited;
  blnTemAcessoMarcarTudo := fVerificaAcessoSistema('EXPMTD', strLoginUsuarioLogado);
  If (blnTemAcessoMarcarTudo) Or
     (ffrmSenha(strOperador)) Then
  Begin
    If (blnTemAcessoMarcarTudo) Or
       (fVerificaAcessoSistema('LIMEXP', fRetCodVendedor(strOperador))) Then
    Begin

      With cdsItens Do
      Begin
        blnIgnorarScroll := True;
        Try
          DisableControls;
          First;
          While Not Eof Do
          Begin
            Edit;
            FieldByName('QTDEXP').AsFloat := 0;
            Post;
            pLimparDigitacaoDeSeries(cdsItens);
            Next;
          End;

          strTodosNumSer := '';
          strTodosCodIte := '';
          strTodosPedidos := '';

          If (pnlVlrMin.Visible) Then
            lblVlrExpTot.Caption := FloatToStrF(0, ffFixed, 12, 2);

          edtTotalExpedido.Text := FloatToStrF(0, ffFixed, 12, 2);

          If fUsaMontagemCaixas Then
          Begin
            objMontarCaixas.Destroy;
            cximgCaixas.Properties.Items.Clear;
            objMontarCaixas := TMontarCaixas.Create;
            pPrencheGridItensCaixa;
            pSetaBotaoMontarCaixas(CAP_MONTAR_CAIXA);
            lblEAN39.Caption := 'Cód.Barras: ';
          End;
          pZeraPesoExpedido;
          FParams.blnLimparExpedidos := True;
        Finally
          blnIgnorarScroll := False;
          First;
          pEnableCdsItens();
        End;

      End;
    End;
  End;

  pCarregaImpSeq();
  pSetEnabledImpSeq((Not fExpedicaoJaIniciada()));
end;

procedure TfrmFatExpedicaoItens.btnMontarCaixasClick(Sender: TObject);
var
  itemAnteriorcxImgDimensaoCaixa : Integer;
begin
  inherited;
  If blnImprimindoEtiquetaCaixa Then
    Exit;

  itemAnteriorcxImgDimensaoCaixa := -1;

  If Not fUsaMontagemCaixas Then
    Exit;

  pSetEnabledImpSeq((Not fExpedicaoJaIniciada()));

  If fCfgSis('PESOBR', varBoolean) Then
    If ( not objMontarCaixas.fBalancaConectada) Then
      Exit;

  If fAtivadoMontagemCaixaConferenciaAUTCOMColetor Then
    itemAnteriorcxImgDimensaoCaixa := cxImgDimensaoCaixa.ItemIndex;

  If btnMontarCaixas.Caption = CAP_MONTAR_CAIXA Then
    chkCaixaRapida.Enabled := (Not fAbrirCaixa())
  Else
    chkCaixaRapida.Enabled     := fFecharCaixa();

  pMudaStatusCaixa;
  dbgItens.Repaint;

  pSetEnabledImpSeq((Not fExpedicaoJaIniciada()));

  If fAtivadoMontagemCaixaConferenciaAUTCOMColetor Then
  Begin
    If itemAnteriorcxImgDimensaoCaixa > 0 Then
      cxImgDimensaoCaixa.ItemIndex := itemAnteriorcxImgDimensaoCaixa;
  End;
end;

procedure TfrmFatExpedicaoItens.pSetaBotaoMontarCaixas(strCaption: String);
begin
  btnMontarCaixas.Caption := strCaption;
  btnMontarCaixas.Font.Color := IIF(strCaption = CAP_MONTAR_CAIXA, clGreen, clMaroon);
  imglsCaixas.GetBitmap(IIF(strCaption = CAP_MONTAR_CAIXA, 1, 0), btnMontarCaixas.Glyph);
end;

class procedure TfrmFatExpedicaoItens.pSqlParams(qryItens: TUniQuery; strCodEmp: String = '');
begin
  If (qryItens.Params.FindParam('EMPITE') <> Nil) Then
    qryItens.ParamByName('EMPITE').AsString  := IfEmptyStr(strCodEmp, VS_strCodEmp);
end;

procedure TfrmFatExpedicaoItens.pCarregarListaAutIncPedidosItensExpedidos;
begin
  FFdoSeqGerExpPar := '';
  FFdoSeqGerComExp := '';
  FFdoAutIncComExp := '';
  FParams.blnTemPedidoComDAV := False;

  if (FParams.VS_strTipExpInterna <> TIPEXP_POR_DOCUMENTO_DE_VENDA) then
  begin
    //EXPEDINDO PEDIDOS
    cdsItens.First;
    while (not cdsItens.Eof) do
    begin
      if (fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat, intDecQtd) <> 0) and
         (fFormataFloat(cdsItens.FieldByName('QTDITE').AsFloat, intDecQtd) <> fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat, intDecQtd)) and
         (not fFaturamentoParcialUtilizandoLocTransitoria(cdsItens.FieldByName('FDO_SEQGER').AsString)) then
      begin
        pIncrementaListaStr(cdsItens.FieldByName('FDO_SEQGER').AsString, FFdoSeqGerExpPar, True);
      end;

      if (fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat, 2) <> 0) then
      begin
        pIncrementaListaStr(cdsItens.FieldByName('FGOINC').AsString, FFdoSeqGerComExp, True);
        pIncrementaListaStr(cdsItens.FieldByName('FDOINC').AsString, FFdoAutIncComExp, True);
      end;

      if (cdsItens.FieldByName('TEMDAV').AsString = 'S') then
        FParams.blnTemPedidoComDAV := True;
      cdsItens.Next;
    end;
  end;
end;

procedure TfrmFatExpedicaoItens.pCarregarDadosListaPedidos;
begin
  {Alimentando a variável principal de código de cliente, com o código vindo da FParams.stlPedidos tratada
    Pois existem varios locais onde essa variável é considerada - KM}
  if ((FParams.stlListaClientes.Count > 1) or (FParams.blnMaisDeUmPedidoDoMesmoClienteComAdiantamento)) and (fPermitirMarcarPedidosDeClientesDiferentesNaExpedicao) then
  begin
    Self.FParams.strCodCli := TPedidoVenda(FParams.stlPedidos.Objects[0]).strCodCli;
    Self.FParams.strCtrNumDup := TPedidoVenda(FParams.stlPedidos.Objects[0]).strNumDoc;
    Self.FParams.strCtrEspDoc := TPedidoVenda(FParams.stlPedidos.Objects[0]).strEspDoc;
    Self.FParams.strCtrCodEmp := TPedidoVenda(FParams.stlPedidos.Objects[0]).strCodEmp;
    Self.FParams.blnTemAdt := TPedidoVenda(FParams.stlPedidos.Objects[0]).strTemADT.Equals('S');
  end;
end;

procedure TfrmFatExpedicaoItens.pAtualizarTipoBuscaItensPedido(fatVenda: TFatVenda);
begin
  cdsItens.DisableControls;
  cdsItens.First;
  while (not cdsItens.Eof) do
  begin
    fatVenda.fAtualizaTipoBusca(cdsItens.FieldByName('AUTOINCREM').AsString, cdsItens.FieldByName('TIPBUS').AsString);
    cdsItens.Next;
  end;
  pEnableCdsItens();
end;

procedure TfrmFatExpedicaoItens.pSetarFiltroEstoque(stlItens: TStrings);
  Var
    intCnt : Integer;
    strSeqGer : String;
    objPedido : TPedidoVenda;
begin
  If Assigned(FParams.stlPedidos) And (Assigned(FParams.cdsFilEst)) And (FParams.cdsFilEst.Active) And (Not FParams.cdsFilEst.IsEmpty) Then
  Begin
    strSeqGer := '';

    For intCnt := 0 To FParams.stlPedidos.Count -1 Do
    Begin
      objPedido  := TPedidoVenda(FParams.stlPedidos.Objects[intCnt]);

      FParams.cdsFilEst.Filtered := False;
      FParams.cdsFilEst.Filter := 'SEQGER = ' + QuotedStr(objPedido.strSeqGer);
      FParams.cdsFilEst.Filtered := True;

      FParams.cdsFilEst.First;
      While (Not FParams.cdsFilEst.Eof) Do
      Begin
        If fEmptyStr(strSeqGer) Then
          strSeqGer := ' (FDO_SEQGER = ' + QuotedStr(objPedido.strSeqGer) +
                       '  AND FDO_CODITE = ' + QuotedStr(FParams.cdsFilEst.FieldByName('CODITE').AsString) + ') '
        Else
          strSeqGer := strSeqGer + ' OR (FDO_SEQGER = ' + QuotedStr(objPedido.strSeqGer) +
                                   '     AND FDO_CODITE = ' + QuotedStr(FParams.cdsFilEst.FieldByName('CODITE').AsString) + ') ';
        FParams.cdsFilEst.Next;
      End;
    End;

    If Not fEmptyStr(strSeqGer) Then
      stlItens.Add(' AND (' + strSeqGer + ') ');
  End;
end;

procedure TfrmFatExpedicaoItens.pSetEnabledImpSeq(blnEnabledImpSeq: Boolean);
begin
  chkImpSeq.Enabled := blnEnabledImpSeq;
  lblVolume.Enabled := blnEnabledImpSeq;
  edtVolume.Enabled := blnEnabledImpSeq;
end;

procedure TfrmFatExpedicaoItens.btnMontarCaixasMouseEnter(Sender: TObject);
begin
  inherited;
  pnlInfCaixa.Caption := 'Pressione [F8] para iniciar a montagem de uma caixa ou após serem inseridos produtos para fechar a mesma.';
end;

procedure TfrmFatExpedicaoItens.btnMontarCaixasMouseLeave(Sender: TObject);
begin
  inherited;
  pnlInfCaixa.Caption := '';
end;

procedure TfrmFatExpedicaoItens.btnMostrarCortadosClick(Sender: TObject);
  var
    frmFatExpedicaoItensCortados : TfrmFatExpedicaoItensCortados;
begin
  If (Not btnMostrarCortados.Visible) Then
    Exit;

  If (Not cdsItens.Active) Then
    Exit;

  If (Not Assigned(FParams.stlPedidos)) Then
    Exit;

  pCriarFormularios(TfrmFatExpedicaoItensCortados, frmFatExpedicaoItensCortados);
  Try
    Try
      frmFatExpedicaoItensCortados.stlPedidos.Assign(FParams.stlPedidos);
      frmFatExpedicaoItensCortados.cdsIteExp.Data := cdsItens.Data;
      frmFatExpedicaoItensCortados.blnVendaPerdidaAutomatica := FParams.blnVendaPerdidaAutomatica;
      frmFatExpedicaoItensCortados.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmFatExpedicaoItens.btnMostrarCortadosClick]');
    End;
  Finally
    pFreeAndNil(frmFatExpedicaoItensCortados);
  End;
end;

procedure TfrmFatExpedicaoItens.btnNumSeriesClick(Sender: TObject);
begin
  inherited;
  If Not btnNumSeries.Visible Then
    Exit;

  If Not btnNumSeries.Enabled Then
    Exit;

  fAbreFormSeries(fFormataFloat(cdsItens.FieldByName('QTDTOT').AsFloat, intDecQtd));
end;

procedure TfrmFatExpedicaoItens.btnPesarCaixaClick(Sender: TObject);
  Var
    caixa: TCaixa;
begin
  inherited;
  If Not fUsaMontagemCaixas Then
    Exit;

  If cximgCaixas.ItemIndex <> -1 Then
  Begin
    caixa := objMontarCaixas.fBuscaCaixa(cximgCaixas.Properties.Items[cximgCaixas.ItemIndex].Value);

    If (Not caixa.blnFechada) Or fPergunta('Esta caixa já foi fechada. Deseja pesar novamente?') Then
    Begin
      edtPesBru.Text := FormatFloat('#,##0.00', objMontarCaixas.fPesarCaixa(caixa));
    End;
  End
  Else
    pMensagemOk('Selecione uma caixa para pesar!');
end;

procedure TfrmFatExpedicaoItens.btnPesarCaixaMouseEnter(Sender: TObject);
begin
  inherited;
  pnlInfCaixa.Caption := 'Pressione [F3] caso precise pesar novamente uma caixa fechada, a caixa em aberto será pesada automaticamente.';
end;

procedure TfrmFatExpedicaoItens.btnPesarCaixaMouseLeave(Sender: TObject);
begin
  inherited;
  pnlInfCaixa.Caption := '';
end;

procedure TfrmFatExpedicaoItens.dbgItensEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := strMsgSel;
end;

procedure TfrmFatExpedicaoItens.dbgItensExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';

end;

procedure TfrmFatExpedicaoItens.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If ((Key = VK_RETURN) And (VS_strTipDEx = '1')) Or
          ((Key = VK_SPACE ) And (VS_strTipDEx = '2')) Then
  Begin
    pSelecionaItem;
  End
  Else If ((Key = VK_RETURN) And (VS_strTipDEx = '2')) Then
  Begin
    edtCodIte.Text := cdsItens.FieldByName('CODITE').AsString;
    pSetFocus(edtQtdIte);
  End;
end;

procedure TfrmFatExpedicaoItens.edtPesBruChange(Sender: TObject);
  Var
    Caixa: TCaixa;
begin
  inherited;
  If cximgCaixas.ItemIndex <> -1 Then
  Begin
    Caixa := objMontarCaixas.fBuscaCaixa(cximgCaixas.Properties.Items[cximgCaixas.ItemIndex].Value);
    Caixa.fltPesoTotal := fStrToFloat(edtPesBru.Text);
  End;
end;

procedure TfrmFatExpedicaoItens.pPrencheGridItensCaixa(blnRelatorio : Boolean = False);
  Var
    intIdx : Integer;

  Procedure pAddCx(intIndex : integer);
    Var
      item: TItemDaCaixa;
      Caixa: TCaixa;
  Begin
    Caixa := objMontarCaixas.fBuscaCaixa(cximgCaixas.Properties.Items[intIndex].Value);

    If (Length(caixa.Itens) > 0) Then
    Begin
      For item In caixa.Itens Do
      Begin
        cdsEtiCaixa.AppendRecord([item.strID, item.strPedido, item.strCodigo,
                                  item.strDescricao, item.fltQuantidade, item.strSiglaUnidade, item.fltPeso, intIndex+1, item.strCodFab]);
      End;

      staQtdItens.Caption  := IntToStr(Length(caixa.Itens));
      FParams.intQtdTra := Length(objMontarCaixas.Caixas);

      If Assigned(objMontarCaixas.CaixaAberta) And (objMontarCaixas.CaixaAberta.strID = Caixa.strID) And (fCfgSis('COMBAL', varString) = 'S') Then
        edtPesBru.Text := FormatFloat('#,##0.00', objMontarCaixas.fPesarCaixa(caixa))
      Else
        edtPesBru.Text := FormatFloat('#,##0.00', caixa.fltPesoTotal);

      lblEAN39.Caption := 'Cód.Barras: '+caixa.strCodBar;
    End;
  End;
begin
  cdsEtiCaixa.EmptyDataSet;

  If blnRelatorio Then
  Begin
    For intIdx := 0 To cximgCaixas.Properties.Items.Count -1 Do
      pAddCx( intIdx ) ;
  End
  Else
  If cximgCaixas.ItemIndex <> -1 Then
  Begin
    pAddCx( cximgCaixas.ItemIndex ) ;
  End
  Else
  Begin
    staQtdItens.Caption  := '0';
    edtPesBru.Text := '0,00';
  End;

  If fLimparExpedido And fUsaMontagemCaixas And (cdsItens.FindField('AUTOINCREM') <> Nil) Then
    lblLimparExpedido.Visible := (Not objMontarCaixas.fBuscaItemNasCaixas(cdsItens.FieldByName('AUTOINCREM').AsString) );

  btnReabreCaixa.Enabled := (cximgCaixas.ItemIndex > -1) And
                            objMontarCaixas.fBuscaCaixa(cximgCaixas.Properties.Items[cximgCaixas.ItemIndex].Value).blnFechada And
                            (objMontarCaixas.CaixaAberta = Nil);

  pMudaStatusCaixa;
end;

procedure TfrmFatExpedicaoItens.pMudaStatusCaixa;
Begin

  If (Not cximgCaixas.ItemIndex >= 0) Then
  Begin
    lblStatusCaixa.Visible := False;
    Exit;
  End;

  If (Not lblStatusCaixa.Visible) Then
    lblStatusCaixa.Visible := True;

  If (Not objMontarCaixas.fBuscaCaixa(cximgCaixas.Properties.Items[cximgCaixas.ItemIndex].Value).blnFechada) Then
  Begin
    lblStatusCaixa.Caption     := 'CAIXA ABERTA';
    lblStatusCaixa.Font.Color       := clGreen;
    cxImgDimensaoCaixa.Enabled := True;
  End
  Else
  Begin
    lblStatusCaixa.Caption     := 'CAIXA FECHADA';
    lblStatusCaixa.Font.Color       := clRed;
    cxImgDimensaoCaixa.Enabled := False;
  End;
End;

procedure TfrmFatExpedicaoItens.pPreencheListaCaixas;
  Var
    caixa: TCaixa;
begin
  cximgCaixas.Properties.Items.Clear;
  For caixa In objMontarCaixas.Caixas Do
  Begin
    With cximgCaixas.Properties.Items.Add, objMontarCaixas Do
    Begin
      Value := caixa.strID;
      Description := 'Caixa ' + caixa.strID + ' - ' + IIF(caixa.blnFechada, 'Fechada', 'Aberta');

      ImageIndex := 0;

      If Assigned(CaixaAberta) And (CaixaAberta.strID = caixa.strID) Then
        ImageIndex := 1;
    End;

    If cximgCaixas.ItemIndex = -1 Then
      cximgCaixas.ItemIndex := 0;
  End;
end;

procedure TfrmFatExpedicaoItens.pPreencheListaDimensaoCaixa;
var
  qryMontagemCaixa : TUniQuery;
  item             : TcxImageComboBoxItem;
begin
  If Not cxImgDimensaoCaixa.Visible Then
    Exit;

  If Not fAtivadoMontagemCaixaConferenciaAUTCOMColetor Then
    Exit;

  qryMontagemCaixa := fCriaQuery;
  Try
    cxImgDimensaoCaixa.Properties.Items.Clear;
    item := cxImgDimensaoCaixa.Properties.Items.Add;
    item.Value       := EmptyStr;
    item.Description := '--SELECIONE UMA OPÇÃO--';

    qryMontagemCaixa.SQL.Text := 'SELECT '
                               + '       MCX_CODIGO '
                               + '     , MCX_DESCRI '
                               + '     , MCX_ALTURA '
                               + '     , MCX_LARGUR '
                               + '     , MCX_PROFUN '
                               + '  FROM MNTCXA '
                               + ' ORDER BY '
                               + '       MCX_DESCRI '
                               + '     , MCX_ALTURA '
                               + '     , MCX_LARGUR '
                               + '     , MCX_PROFUN ';

    qryMontagemCaixa.Open;
    qryMontagemCaixa.First;
    While Not qryMontagemCaixa.Eof Do
    Begin
      item := cxImgDimensaoCaixa.Properties.Items.Add;
      item.Value       := qryMontagemCaixa.FieldByName('MCX_CODIGO').AsString;
      item.Description := qryMontagemCaixa.FieldByName('MCX_DESCRI').AsString
                        + ' - A:'+FormatFloat(',0.00',qryMontagemCaixa.FieldByName('MCX_ALTURA').AsFloat)
                        + ' X L:'+FormatFloat(',0.00',qryMontagemCaixa.FieldByName('MCX_LARGUR').AsFloat)
                        + ' X P:'+FormatFloat(',0.00',qryMontagemCaixa.FieldByName('MCX_PROFUN').AsFloat);

      qryMontagemCaixa.Next;
    End;

    cxImgDimensaoCaixa.ItemIndex := 0;
  Finally
    FreeAndNil(qryMontagemCaixa);
  End;
end;

procedure TfrmFatExpedicaoItens.pSalvaCaixas;
  Var
    qryFgoCai : TUniQuery;
    objItem   : TItemDaCaixa;
    objCaixa  : TCaixa;
    LAutInc: String;
    LQtdIns: Integer;
begin
  qryFgoCai := fCriaQuery;
  LQtdIns := 0;
  Try
    With qryFgoCai, SQL Do
    Begin
      Close;
      Clear;
      Add(' DELETE FROM FGOCAI ' + strWhereComItensFgoCai );
      ExecSQL;

      Close;
      Clear;
      Add(' REPLACE INTO FGOCAI ( ');
      Add('         AUTOINCREM, ');
      Add('         FGC_FGOINC, ');
      Add('         FGC_FDOINC, ');
      Add('         FGC_CAI_ID, ');
      Add('         FGC_CODBAR, ');
      Add('         FGC_QUANTD, ');
      Add('         FGC_CODMCX) ');
      Add(' VALUES (:AUTINC,    ');
      Add('         :FGOINC,    ');
      Add('         :FDOINC,    ');
      Add('         :CAI_ID,    ');
      Add('         :CODBAR,    ');
      Add('         :QUANTD,    ');
      Add('         :CODMCX)    ');

      For objCaixa in objMontarCaixas.Caixas Do
        LQtdIns := LQtdIns + Length(objCaixa.Itens);

      If LQtdIns > 0 Then
        LAutInc := fRetAutoIncrem('FGOCAI', VS_strCodEmp, LQtdIns);

      For objCaixa in objMontarCaixas.Caixas Do
      Begin
        For objItem in objCaixa.Itens Do
        Begin
          ParamByName('AUTINC').AsString := LAutInc;
          ParamByName('FGOINC').AsString := objItem.strFgoInc;
          ParamByName('FDOINC').AsString := objItem.strID;
          ParamByName('CAI_ID').AsString := objCaixa.strID;
          ParamByName('CODBAR').AsString := objCaixa.strCodBar;
          ParamByName('CODMCX').AsString := objCaixa.strCodMcx;
          ParamByName('QUANTD').AsFloat  := objItem.fltQuantidade;
          ExecSQL;

          LAutInc := fNextAutoIncrem(LAutInc)
        End;
      End;
    End;
  Finally
    FreeAndNil(qryFgoCai);
  End;
end;

procedure TfrmFatExpedicaoItens.pSelecionaItem;
Begin
  If Not fSelecionado Then
    pAdicionaItemSelecao
  Else
    pRemoveItemSelecao;

  dbgItens.Repaint;
End;

procedure TfrmFatExpedicaoItens.pSelecionaListaDimensaoCaixa;
var
  caixa       : TCaixa;
  intContador : Integer;
begin
  If Not fAtivadoMontagemCaixaConferenciaAUTCOMColetor Then
    Exit;

  If (cximgCaixas.Properties.Items.Count = 0) Then
    Exit;

  caixa := objMontarCaixas.fBuscaCaixa(
             cximgCaixas.Properties.Items[cximgCaixas.ItemIndex].Value);

  If fEmptyStr(caixa.strCodMcx) Then
    Exit;

  For intContador := 0 To Pred(cxImgDimensaoCaixa.Properties.Items.Count) Do
  Begin
    If (cxImgDimensaoCaixa.Properties.Items[intContador].Value = caixa.strCodMcx) Then
    Begin
      cxImgDimensaoCaixa.ItemIndex := intContador;
      Break;
    End;
  End;
end;

function TfrmFatExpedicaoItens.fSelecionado: Boolean;
Begin
  If (Assigned(stlItens)) And (Assigned(cdsItens)) Then
    Result := (stlItens.IndexOf(cdsItens.FieldByName('AUTOINCREM').AsString) > -1)
  Else
    Result := False;
End;

function TfrmFatExpedicaoItens.fAbrirCaixa():Boolean;
Var
  strCodBar: String;
  strDesCai: String;
  intAuxCai: Integer;
begin
  Result := False;

  If (fTemCaixaAberta()) Then
  Begin
    If (Not fEscondeMensagensAberturaEFechamentoCaixa()) And (Not chkCaixaRapida.Checked) Then
      pMensagemOk('Já possui uma caixa em montagem!');

    Result := True;
    Exit;
  End;

  If (Not fValidaVolume()) Then
    Exit;

  If (Not fPodeAdicionarCaixaImpSeq()) Then
    Exit;

  If fCfgSis('CFVLCB', varBoolean) And fCfgSis('CFVBCX', varBoolean) then
  Begin
    strCodBar := fInputDialog('Montagem de Caixas',
                              'Informe o código de barras da caixa:', '', 20);

    strCodBar := Trim(strCodBar);

    If fEmptyStr(strCodBar) Or (Pos('CXSEQ', strCodBar) = 0) Then
    Begin
      pMensagemOk('Código de barras inválido!');
      Exit;
    End;

    If Assigned(objMontarCaixas.fBuscaCaixaCodBar(strCodBar)) Then
    Begin
      pMensagemOk('Este código de barras [ '+strCodBar+' ] já foi utilizado ' + #13 +
                  ' na abertura da caixa [ '+ objMontarCaixas.fBuscaCaixaCodBar(strCodBar).strID +' ]' + #13 +
                  'Não poderá ser reutilizado.');

      Exit;
    End;

    If not fValidaCaixaCodBar(strCodBar) Then
    Begin
      pMensagemOk('Código de barras já utilizado!');
      Exit;
    End;
  End;

  pSetaBotaoMontarCaixas(CAP_FECHAR_CAIXA);

  If fCfgSis('CSQCAI', varString) = '1' Then
    objMontarCaixas.pNovaCaixa('',strCodBar)
  Else
  Begin
    strPrefixCx := cdsItens.FieldByName('NUMDOC').AsString;

    If (Self.fExpedindoMaisDeUmPedido()) Then
      intAuxCai := objMontarCaixas.fNroCaixasPrefixo(strPrefixCx)
    Else
      intAuxCai := Length(objMontarCaixas.Caixas);

    Repeat
       Inc(intAuxCai);
       strDesCai := strPrefixCx + '-' + fStrZero(intAuxCai, 3);
    Until objMontarCaixas.fBuscaCaixa(strDesCai) = Nil;

    objMontarCaixas.pNovaCaixa(strDesCai, strCodBar);
  End;

  pPreencheListaCaixas;
  cximgCaixas.ItemIndex := cximgCaixas.Properties.Items.Count -1;
  staQtdItens.Caption := '0';
  edtPesBru.Text      := '0,00';
  pPrencheGridItensCaixa;

  If (Not fEscondeMensagensAberturaEFechamentoCaixa) And (Not chkCaixaRapida.Checked) Then
    pMensagemOk('Iniciada a montagem da caixa ' + objMontarCaixas.CaixaAberta.strID + ' com sucesso!');

  Result := fTemCaixaAberta();
end;

function TfrmFatExpedicaoItens.fAgrupaPedidoPorCondicaoPagamento: Boolean;
begin
  Result := False;

  If fPermiteSelecionarPedidoComCondicaoPagamentoDiferenteNaExpedicao Then
    If stlListaCondicaoPagamento.Count > 1 Then
      Result := True;
end;

procedure TfrmFatExpedicaoItens.pAdicionaItemSelecao;
Begin
  stlItens.Add(cdsItens.FieldByName('AUTOINCREM').AsString);
End;

procedure TfrmFatExpedicaoItens.pRemoveItemSelecao;
  Var
    objItem : TObject;
    intIndex: Integer;
Begin
  intIndex := stlItens.IndexOf(cdsItens.FieldByName('AUTOINCREM').AsString);
  If intIndex > -1 Then
  Begin
    objItem := stlItens.Objects[intIndex];
    stlItens.Delete(intIndex);
    If Assigned(objItem) Then
      FreeAndNil(objItem);
  End;
End;

procedure TfrmFatExpedicaoItens.pRetPesoItemFaturamento(var fltPesBru, fltPesLiq: Double);
var
  qryPeso: TUniQuery;
  intIndice: integer;
begin
  fltPesBru := 0;
  fltPesLiq := 0;

  qryPeso := fCriaQuery;

  try
    qryPeso.Close;
    qryPeso.SQL.Clear;
    qryPeso.SQL.Add('SELECT F.AUTOINCREM, E.FGO_PEBRTE, E.FGO_PELITE, F.FGO_PESBRU, F.FGO_PESLIQ ');
    qryPeso.SQL.Add('FROM EXTGOR E ');
    qryPeso.SQL.Add('INNER JOIN FATGOR F ON F.AUTOINCREM = E.FGO_SEQFGO ');
    qryPeso.SQL.Add('WHERE E.FGO_SEQFGO = :AUTINC ');

    for intIndice := 0 to FParams.stlPedidos.Count - 1 do
    begin
      qryPeso.Close;
      qryPeso.ParamByName('AUTINC').AsString := TPedidoVenda(FParams.stlPedidos.Objects[intIndice]).strSeqGer;
      qryPeso.Open;

      if qryPeso.IsEmpty then
        Continue;

      If Not fProcessouNoColetor(qryPeso.FieldByName('AUTOINCREM').AsString) Then
      Begin
        if qryPeso.FieldByName('FGO_PEBRTE').AsFloat > 0 then
          fltPesBru := fltPesBru + qryPeso.FieldByName('FGO_PEBRTE').AsFloat;

        if qryPeso.FieldByName('FGO_PELITE').AsFloat > 0 then
          fltPesLiq := fltPesLiq + qryPeso.FieldByName('FGO_PELITE').AsFloat;
      End
      Else
      Begin
        if qryPeso.FieldByName('FGO_PESBRU').AsFloat > 0 then
          fltPesBru := fltPesBru + qryPeso.FieldByName('FGO_PESBRU').AsFloat;

        if qryPeso.FieldByName('FGO_PESLIQ').AsFloat > 0 then
          fltPesLiq := fltPesLiq + qryPeso.FieldByName('FGO_PESLIQ').AsFloat;
      End
    end;

  finally
    FreeAndNil(qryPeso);
  end;
end;

procedure TfrmFatExpedicaoItens.btnEditarMensagemClick(Sender: TObject);
var
  frmFatMensagemExpedicao : TfrmFatMensagemExpedicao;
begin
  if not btnEditarMensagem.Visible then
    Exit;

  pCriarFormularios(TfrmFatMensagemExpedicao, frmFatMensagemExpedicao);
  Try
    frmFatMensagemExpedicao.CdsExpedicao := FParams.cdsExpedicao;
    frmFatMensagemExpedicao.stlPedidos.Assign(FParams.stlPedidos);
    frmFatMensagemExpedicao.blnExpedicaoItens := True;
    frmFatMensagemExpedicao.ShowModal;
  Finally
    pFreeAndNil(frmFatMensagemExpedicao);
  End;
end;

procedure TfrmFatExpedicaoItens.btnEtiquetaClick(Sender: TObject);
begin
  TfrmGravando.fExecutarModalA(pImprimirEtiquetas, 'Aguarde, Impressão Etiquetas ...', '');
end;

procedure TfrmFatExpedicaoItens.btnEtqSepFaltanteClick(Sender: TObject);
begin
  inherited;
  pImprimirSeparacaoErrada(cdsItens);
end;

procedure TfrmFatExpedicaoItens.pImprimirDANFE(strNumDoc, strEspDoc, strCodCli, strCodEmp, strSerie: String; const AblnEtiquetaUnificadaSemDanfe: Boolean);
Var
  libNFe: TLibNfe;
  strErro: String;
  strAcesso: String;
  strImpressora: String;
  strPontoImpressao: String;

  procedure pAtualizarPontoImpressaoNFe;
  begin
    fExecutaSQL(Format(
      ' UPDATE LOGNFE SET NFE_PONIMP = "%s" ' +
      ' WHERE NFE_NUMDOC = "%s" ' +
      '   AND NFE_ESPDOC = "%s" ' +
      '   AND NFE_CODEMP = "%s" ' +
      '   AND NFE_CODCLI = "%s" ' +
      '   AND NFE_SERIE_ = "%s" ', [strPontoImpressao, strNumDoc, strEspDoc,  strCodEmp, strCodCli, strSerie]));
  end;

begin
  strAcesso := fRetChaveAcesso(strNumDoc, strEspDoc, strCodCli, strCodEmp, strSerie);

  If fEmptyStr(strAcesso) Then
  Begin
    pMensagemOk('Este documento não é uma NFe ou ainda não foi autorizada.');
    Exit;
  End;

  libNFe := TLibNfe.Create(VS_strCodEmp);
  Try

    strImpressora := libNFe.fCarregarImpressoraPontoImpressaoGravado(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, 'C');
                                {Deve definir o ponto de impressao na expedicao}
    If strImpressora.IsEmpty Or FParams.blnExpedicaoDocumentoFaturadoAutomaticamente Then
    Begin
      strPontoImpressao := libNFe.fRetPontoImpressao(strEspDoc, VS_strCodEmp);
      pAtualizarPontoImpressaoNFe;
      strImpressora := libNFe.fRetornaNomeImpressora(strPontoImpressao);
    End;

    // Fora deste caso, ponto "nao imprimir" e escolha legitima do cliente, e
    // avisar em toda expedicao seria ruido. Quem ajusta ponto e fila e o TI, nao
    // o operador: por isso so informa, sem oferecer reconfiguracao.
    If AblnEtiquetaUnificadaSemDanfe Then
    Begin
      If fEmptyStr(strImpressora) Then
      Begin
        pMensagemOk('A etiqueta de despacho saiu sem a DANFE simplificada e não há ponto de impressão definido para esta estação.' + sLineBreak + sLineBreak +
                    'A DANFE da nota ' + strNumDoc + ' não foi impressa. Solicite ao responsável a configuração do ponto de impressão.');
        Exit;
      End;

      If Not TImpressaoDiretaCitel.fImpressoraEhParaImprimir(strImpressora) Then
      Begin
        pMensagemOk('A etiqueta de despacho saiu sem a DANFE simplificada e o ponto de impressão "' + strPontoImpressao + '" está configurado para não imprimir.' + sLineBreak + sLineBreak +
                    'A DANFE da nota ' + strNumDoc + ' não foi impressa. Solicite ao responsável a revisão do ponto de impressão.');
        Exit;
      End;
    End;

    If fCfgSis('CITINF', varBoolean) Then
    Begin
      TImpressaoDiretaCitel.pImprimir(VS_strCodEmp, strImpressora, strAcesso, 'NFE');
    End
    Else
    Begin
      Try
        libNFe.pReimprimirDanfe(strAcesso, strImpressora, strSerie);
      Except
        On E: Exception Do
        Begin
          strErro := E.Message;
          strErro := strErro.Replace(#13, ' ').Replace(#10, ' ').Replace('Erro ao reimprimir:', '');
          strErro := Trim(strErro);

          If Length(strErro) > 60 Then
            strErro := Copy(strErro, 1, 59) + sLineBreak +
              fPadR(Copy(strErro, 60, 56) + '...', 59);

          pMensagemSonora(
            '------------------------------------------------------------' + sLineBreak +
            'Não é possível recuperar a DANFE na SEFAZ.                  ' + sLineBreak +
            'Verifique se existe acesso à Internet no seu computador.    ' + sLineBreak +
            'Caso o erro persista, procure o departamento de TI.         ' + sLineBreak +
            '                                                            ' + sLineBreak +
            '------------------------------------------------------------' + sLineBreak +
            'Mensagem retornada:                                         ' + sLineBreak +
            strErro                                                      + sLineBreak +
            '------------------------------------------------------------' , False, 11, 600);
        End;
      End;
    End;
  Finally
    FreeAndNil(libNFe);
  End;
end;

procedure TfrmFatExpedicaoItens.pImprimirEtiquetas;
  Var
    strSQL: String;
    intCon: Integer;
    objPedido: TPedidoVenda;
    intCont: Integer;
    intConta: Integer;
begin
  inherited;

  If (Not fEmptyStr(stlItens.Text)) Then
  Begin
    If (fMensagem('', 'Confirma impressão das etiquetas?', ['&Sim', '&Não']) = 1) Then
    Begin
      pCarregaConfImpr(qryCfgRel, Self.Name);
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      If Not fVerificaImpressora(strNomImp) Then
      Begin
        fMensagem('','Impressora configurada incorretamente!',['&OK']);
        Exit;
      End;

      cdsSelecao.EmptyDataSet;
      For intCont := 0 To stlItens.Count - 1 Do
      Begin

        If (FParams.VS_strTipExpInterna <> TIPEXP_POR_DOCUMENTO_DE_VENDA) Then
        Begin
          strSQL := '';
          strSQL := strSQL + 'SELECT ';
          strSQL := strSQL + '  FDO_DESCRI AS DESITE,                           ';
          strSQL := strSQL + '  FDO_CODITE AS CODITE,                           ';
          strSQL := strSQL + '  FDO_NUMDOC AS NUMDOC,                           ';
          strSQL := strSQL + '  CONCAT(FDO_NUMDOC, "-", FDO_ESPDOC, "-", FDO_CODEMP) AS NRODOC, ';
          strSQL := strSQL + '  (FDO_QTDITE - FDO_QTDBAI) AS QTDITE,            ';
          strSQL := strSQL + '  FDO_UNITAR AS UNITAR,                           ';
          strSQL := strSQL + '  FDO_TOTITE AS TOTITE,                           ';
          strSQL := strSQL + '  FDO_CODVEN AS CODVEN,                           ';
          strSQL := strSQL + '  FDO_TIPEMB AS TIPEMB,                           ';
          strSQL := strSQL + '  FATDOR.AUTOINCREM AS AUTOINCREM,                ';
          strSQL := strSQL + '  FATDOR.FDO_SEQGER AS SEQGER,                    ';
          strSQL := strSQL + '  IF(FDO_CODACA IS NOT NULL AND FDO_CODACA <> "", ';
          strSQL := strSQL + '     ACA_CODBAR, I.ITE_CODBAR) AS CODBAR,         ';
          strSQL := strSQL + '  FDO_ESPDOC AS ESPDOC,                           ';
          strSQL := strSQL + '  FDO_CODEMP AS CODEMP,                           ';
          strSQL := strSQL + '  FDO_UNIDAD AS UNIDAD,                           ';
          strSQL := strSQL + '  EMP_SIGLA_ AS SIGLA_,                           ';
          strSQL := strSQL + '  OPE_NOMOPE AS NOMVEN,                           ';
          strSQL := strSQL + '  CLI_NOMCLI AS NOMCLI,                           ';
          strSQL := strSQL + '  CLI_ENDENT AS ENDENT,                           ';
          strSQL := strSQL + '  CLI_CODCLI AS CODCLI,                           ';
          strSQL := strSQL + '  CID_NOMCID AS CIDENT,                           ';
          strSQL := strSQL + '  FDO_IDEPRO AS IDEPRO,                           ';

          strSQL := strSQL + '  I.ITE_CODFAB AS CODFAB, ';
          strSQL := strSQL + '  I.ITE_REFERE AS REFERE, ';
          strSQL := strSQL + '  IF(IFNULL(FDO_NUMLOT, "") = "", ITE_LOCFIS, LOT_LOCFIS) AS LOCFIS, ';
          strSQL := strSQL + '  IF(IFNULL(FDO_NUMLOT, "") = "", L2.LOC_DESCRI, L1.LOC_DESCRI) AS DESFIS, ';

          strSQL := strSQL + '  FDO_DTAENT AS DTAENT,                           ';
          strSQL := strSQL + '  DATE_ADD(FDO_DTAENT, INTERVAL ' + fCfgSis('VALTIN') + ' MONTH) AS DTAVAL         ';


          strSQL := strSQL + 'FROM                                              ';
          strSQL := strSQL + '  FATDOR                                          ';
          strSQL := strSQL + '  INNER JOIN CADITE I ON I.ITE_CODITE = FDO_CODITE      ';

          strSQL := strSQL + '  LEFT JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE AND G.ITE_CODEMP = FDO_CODEMP ';

          strSQL := strSQL + '  LEFT JOIN CADEMP ON EMP_CODEMP = FDO_CODEMP     ';
          strSQL := strSQL + '  LEFT JOIN CADOPE ON OPE_CODOPE = FDO_CODVEN     ';
          strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = FDO_CODCLI     ';
          strSQL := strSQL + '  LEFT JOIN CADCID ON CLI_CIDENT = CID_CODCID     ';

          strSQL := strSQL + ' LEFT JOIN CADLOT ON FDO_NUMLOT = LOT_NUMLOT AND ';
          strSQL := strSQL + '                     FDO_CODITE = LOT_CODITE AND ';
          strSQL := strSQL + '                     IF(IFNULL(FDO_EMPITE, "") = "", FDO_CODEMP, FDO_EMPITE) = LOT_CODEMP ';
          strSQL := strSQL + ' LEFT JOIN CADLOC L1 ON L1.LOC_CODLOC = CADLOT.LOT_LOCFIS AND L1.LOC_CODEMP = CADLOT.LOT_CODEMP ';
          strSQL := strSQL + ' LEFT JOIN CADLOC L2 ON L2.LOC_CODLOC = G.ITE_LOCFIS AND L2.LOC_CODEMP = G.ITE_CODEMP ';

          strSQL := strSQL + '  LEFT JOIN CADACA ON ACA_CODACA = FDO_CODACA AND ';
          strSQL := strSQL + '                      ACA_CODEMP = FDO_EMPACA     ';
          strSQL := strSQL + 'WHERE                                             ';
          strSQL := strSQL + '  FDO_QTDITE > FDO_QTDBAI       AND               ';
          strSQL := strSQL + '  IFNULL(FDO_PROEMB,"N") <> "S" AND               ';

          strSQL := strSQL + '  (   ';
          For intCon := 0 To FParams.stlPedidos.Count -1 Do
          Begin
            objPedido  := TPedidoVenda(FParams.stlPedidos.Objects[intCon]);

            strSQL := strSQL + '  (FDO_NUMDOC = ' + QuotedStr(objPedido.strNumDoc) + ' AND ';
            strSQL := strSQL + '   FDO_ESPDOC = ' + QuotedStr(objPedido.strEspDoc) + ' AND ';
            strSQL := strSQL + '   FDO_CODEMP = ' + QuotedStr(objPedido.strCodEmp) + ') ';

            If intCon < FParams.stlPedidos.Count -1 Then
              strSQL := strSQL + ' OR ';
          End;
          strSQL := strSQL + '  )   ';
          strSQL := strSQL + '  AND  ';
          strSQL := strSQL + '  (    ';

          For intConta := 0 To stlItens.Count - 1 do
          Begin
            strSQL := strSQL + ' FATDOR.AUTOINCREM = "'+ stlItens[intConta]+ '" ';

            If intConta < stlItens.Count -1 Then
              strSQL := strSQL + ' OR ';
          End;
          strSQL := strSQL + '  ) ';

        End
        Else
        Begin
          strSQL := '';
          strSQL := strSQL + 'SELECT ';
          strSQL := strSQL + '  DET_DESCRI AS DESITE,                           ';
          strSQL := strSQL + '  DET_CODITE AS CODITE,                           ';
          strSQL := strSQL + '  DET_NUMDOC AS NUMDOC,                           ';
          strSQL := strSQL + '  CONCAT(DET_NUMDOC, "-", DET_ESPDOC, "-", DET_CODEMP) AS NRODOC, ';
          strSQL := strSQL + '  (DET_QTDITE - IFNULL(DET_QTDEXP, 0)) AS QTDITE, ';
          strSQL := strSQL + '  DET_UNITAR AS UNITAR,                           ';
          strSQL := strSQL + '  DET_TOTITE AS TOTITE,                           ';
          strSQL := strSQL + '  DET_TIPEMB AS TIPEMB,                           ';
          strSQL := strSQL + '  DET_CODVEN AS CODVEN,                           ';
          strSQL := strSQL + '  MOVDET.AUTOINCREM AS AUTOINCREM,                ';
          strSQL := strSQL + '  MOVDET.DET_SEQGER AS SEQGER,                    ';
          strSQL := strSQL + '  IF(DET_CODACA IS NOT NULL AND DET_CODACA <> "", ';
          strSQL := strSQL + '     ACA_CODBAR, I.ITE_CODBAR) AS CODBAR,         ';
          strSQL := strSQL + '  DET_ESPDOC AS ESPDOC,                           ';
          strSQL := strSQL + '  DET_CODEMP AS CODEMP,                           ';
          strSQL := strSQL + '  DET_UNIDAD AS UNIDAD,                           ';
          strSQL := strSQL + '  EMP_SIGLA_ AS SIGLA_,                           ';
          strSQL := strSQL + '  OPE_NOMOPE AS NOMVEN,                           ';
          strSQL := strSQL + '  CLI_NOMCLI AS NOMCLI,                           ';
          strSQL := strSQL + '  CLI_ENDENT AS ENDENT,                           ';
          strSQL := strSQL + '  CID_NOMCID AS CIDENT,                           ';
          strSQL := strSQL + '  CLI_CODCLI AS CODCLI,                           ';
          strSQL := strSQL + '  DET_IDEPRO AS IDEPRO,                           ';

          strSQL := strSQL + '  I.ITE_CODFAB AS CODFAB, ';
          strSQL := strSQL + '  I.ITE_REFERE AS REFERE, ';
          strSQL := strSQL + '  IF(IFNULL(DET_NUMLOT, "") = "", ITE_LOCFIS, LOT_LOCFIS) AS LOCFIS, ';
          strSQL := strSQL + '  IF(IFNULL(DET_NUMLOT, "") = "", L2.LOC_DESCRI, L1.LOC_DESCRI) AS DESFIS, ';

          strSQL := strSQL + '  DET_DTAENT AS DTAENT,                           ';
          strSQL := strSQL + '  DATE_ADD(DET_DTAENT, INTERVAL ' + fCfgSis('VALTIN') + ' MONTH) AS DTAVAL         ';
          strSQL := strSQL + 'FROM                                              ';
          strSQL := strSQL + '  MOVDET                                          ';
          strSQL := strSQL + '  INNER JOIN CADITE I ON I.ITE_CODITE = DET_CODITE   ';

          strSQL := strSQL + '  LEFT JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE AND G.ITE_CODEMP = DET_CODEMP ';

          strSQL := strSQL + '  LEFT JOIN CADEMP ON EMP_CODEMP = DET_CODEMP     ';
          strSQL := strSQL + '  LEFT JOIN CADOPE ON OPE_CODOPE = DET_CODVEN     ';
          strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = DET_CODCLI     ';
          strSQL := strSQL + '  LEFT JOIN CADCID ON CLI_CIDENT = CID_CODCID     ';

          strSQL := strSQL + '  LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';

          strSQL := strSQL + ' LEFT JOIN CADLOT ON DET_NUMLOT = LOT_NUMLOT AND ';
          strSQL := strSQL + '                     DET_CODITE = LOT_CODITE AND ';
          strSQL := strSQL + '                     DET_CODEMP = LOT_CODEMP     ';
          strSQL := strSQL + ' LEFT JOIN CADLOC L1 ON L1.LOC_CODLOC = CADLOT.LOT_LOCFIS AND L1.LOC_CODEMP = CADLOT.LOT_CODEMP  ';
          strSQL := strSQL + ' LEFT JOIN CADLOC L2 ON L2.LOC_CODLOC = G.ITE_LOCFIS AND L2.LOC_CODEMP = G.ITE_CODEMP  ';


          strSQL := strSQL + '  LEFT JOIN CADACA ON ACA_CODACA = DET_CODACA AND ';
          strSQL := strSQL + '                      ACA_CODEMP = DET_EMPACA     ';
          strSQL := strSQL + 'WHERE                                             ';
          strSQL := strSQL + '  IFNULL(DET_PROEMB,"N") <> "S" AND               ';

          strSQL := strSQL + '  DET_NUMDOC = ' + QuotedStr(FParams.strNumDoc) + ' AND ';
          strSQL := strSQL + '  DET_ESPDOC = ' + QuotedStr(FParams.strEspDoc) + ' AND ';
          strSQL := strSQL + '  DET_CODEMP = ' + QuotedStr(FParams.strCodEmp) + ' AND ';

          strSQL := strSQL + '  ( ';

          For intConta := 0 To stlItens.Count - 1 do
          Begin
            strSQL := strSQL + ' MOVDET.AUTOINCREM = "'+ stlItens[intConta]+ '" ';

            If intConta < stlItens.Count -1 Then
              strSQL := strSQL + ' OR ';
          End;
          strSQL := strSQL + '  ) ';

          strSQL := strSQL + ' HAVING QTDITE > 0 ';
        End;

        With qryEtique Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          Open;

          If (IsEmpty) Then
          Begin
            Close;
            fMensagem('ATENÇÃO!', 'É necessário selecionar pelo menos um Item', ['&Ok']);
            Exit;
          End
          Else
          Begin

            cdsSelecao.EmptyDataSet;

            While Not Eof Do
            Begin
              cdsSelecao.Insert;
              cdsSelecao.FieldByName('CODBAR').AsString := FieldByName('CODBAR').AsString;
              cdsSelecao.FieldByName('CODITE').AsString := FieldByName('CODITE').AsString;
              cdsSelecao.FieldByName('DESITE').AsString := FieldByName('DESITE').AsString;
              cdsSelecao.FieldByName('NUMDOC').AsString := FieldByName('NUMDOC').AsString;
              cdsSelecao.FieldByName('NRODOC').AsString := FieldByName('NRODOC').AsString;
              cdsSelecao.FieldByName('QTDITE').AsString := FieldByName('QTDITE').AsString;
              cdsSelecao.FieldByName('UNITAR').AsString := FieldByName('UNITAR').AsString;
              cdsSelecao.FieldByName('CODVEN').AsString := FieldByName('CODVEN').AsString;
              cdsSelecao.FieldByName('TOTITE').AsString := FieldByName('TOTITE').AsString;
              cdsSelecao.FieldByName('UNIDAD').AsString := fRetSiglaUnidade(FieldByName('UNIDAD').AsString);

              cdsSelecao.FieldByName('SIGLA_').AsString := FieldByName('SIGLA_').AsString;
              cdsSelecao.FieldByName('NOMVEN').AsString := FieldByName('NOMVEN').AsString;
              cdsSelecao.FieldByName('NOMCLI').AsString := FieldByName('NOMCLI').AsString;
              cdsSelecao.FieldByName('ENDENT').AsString := FieldByName('ENDENT').AsString;
              cdsSelecao.FieldByName('CIDENT').AsString := FieldByName('CIDENT').AsString;
              cdsSelecao.FieldByName('LOCFIS').AsString := FieldByName('LOCFIS').AsString;
              cdsSelecao.FieldByName('DESFIS').AsString := FieldByName('DESFIS').AsString;
              cdsSelecao.FieldByName('CODFAB').AsString := FieldByName('CODFAB').AsString;

              If (FieldByName('IDEPRO').AsString = 'NOR') Then
              Begin
                cdsSelecao.FieldByName('MENSAG').AsString := 'Emissão/Validade:Consulte Emb.do Fabricante';
                cdsSelecao.FieldByName('VOLQTE').AsString := 'Quantidade: ' + FieldByName('QTDITE').AsString;
              End
              Else
              Begin
                cdsSelecao.FieldByName('MENSAG').AsString := 'Emissão: ' + FieldByName('DTAENT').AsString +
                                                             'Validade: ' + FieldByName('DTAVAL').AsString;
                cdsSelecao.FielDByName('VOLQTE').AsString := 'Vol('+ fRetSiglaUnidade(FieldByName('UNIDAD').AsString) + '): ' + FieldByName('QTDITE').AsString;
              End;

              cdsSelecao.FieldByName('NOMEMP').AsString := fRetNomeEmpresaSelec(FieldByName('CODEMP').AsString);
              cdsSelecao.FieldByName('TIPEMB').AsString := FieldByName('TIPEMB').AsString;
              cdsSelecao.FieldByName('REFERE').AsString := FieldByName('REFERE').AsString;
              cdsSelecao.FieldByName('CODCLI').AsString := FieldByName('CODCLI').AsString;
              cdsSelecao.FieldByName('DTAENT').AsString := FieldByName('DTAENT').AsString;
              cdsSelecao.Post;

              Next;
            End;

          End;

        End;

      End;
      cdsSelecao.First;

      fImprimeEtiquetas(strNomImp);
    End;

  End
  Else
  Begin
    fMensagem('','Nenhum item foi selecionado para impressão !'+#13+strMsgSel,['&OK']);
  End;

  pSetFocus(dbgItens);
End;

function TfrmFatExpedicaoItens.fImprimeEtiquetas(strNomImp: String): Boolean;
  Var
    strPatEti : String;
    intQtdEti: Integer;
    frmModuloFatExpedicaoItens: TfrmModuloFatExpedicaoItens;
begin
  strPatEti := fCfgSis('PATETI');
  Result := True;
  intQtdEti := fQuantidadeDeEtiquetas;

  If (intQtdEti = 0) Then
    Exit(False);

  If FileExists(strPatEti + '\etiqueta_expedicao_codbarra.fr3') Then
  Begin
    pCriarFormularios(TfrmModuloFatExpedicaoItens, frmModuloFatExpedicaoItens);
    Try
      frmModuloFatExpedicaoItens.frxEtiqItens.LoadFromFile(strPatEti + '\etiqueta_expedicao_codbarra.fr3');

      frmModuloFatExpedicaoItens.frxDBImpEti.DataSet := cdsSelecao;
      frmModuloFatExpedicaoItens.frxEtiqItens.PrintOptions.Copies := intQtdEti;

      If Not fEmptyStr(Self.strNomImp) Then
      Begin
        frmModuloFatExpedicaoItens.frxEtiqItens.PrintOptions.Printer    := Self.strNomImp;
        frmModuloFatExpedicaoItens.frxEtiqItens.PrintOptions.ShowDialog := False;
      End;

      If frmModuloFatExpedicaoItens.frxEtiqItens.PrepareReport Then
        pPrintReport(Self.Name, Self.Caption + ' (Etiqueta Itens)', Self.strNomImp, frmModuloFatExpedicaoItens.frxEtiqItens);
    Finally
      pFreeAndNil(frmModuloFatExpedicaoItens);
    End;
  End
  Else
    fImpEtiqCodBarrasProduto(cdsSelecao, intQtdEti);
End;

function TfrmFatExpedicaoItens.fInserirProduto(dadosProduto : TDadosProduto;
                                               fatVenda     : TFatVenda): Boolean;
Var
  recForTin    : TForTin;
  recMadeira   : TDadosMadeira;
  qryDadosItem : TUniQuery;
  parPreCus    : TParCalculaPrecoCusto;

  function fGetIcmsSaida: Double;
  begin
    With qryDadosItem Do
    Begin
      If (fCfgSis('IMPCF4') = 'S') Then
        Result := fatVenda.fCalculaAliquota(FieldByName('ITE_CODITE').AsString, VS_strCodEmp, FieldByName('ITE_IMPDIR').AsString)
      Else
        Result := FieldByName('ITE_ICMSAI').AsFloat;
    End;
  end;

begin

  qryDadosItem := fCriaQuery(Self);
  Try
    Try
      With qryDadosItem, SQL Do
      Begin

        Add(' SELECT ');
        Add('   ITE_CLAIPI, ');

        If fCfgSis('TIPABF') = '1' Then
          Add('   CADITE.ITE_CODABF AS ITE_CODABF, ')
        Else
          Add('   ITEGER.ITE_CODABF AS ITE_CODABF, ');

        Add('   ITE_CODBAR, ');
        Add('   ITE_CODFAB, ');
        Add('   ITE_CODFOR, ');
        Add('   ITE_CODGRU, ');
        Add('   CADITE.ITE_CODITE, ');
        Add('   ITE_CODMAR, ');
        Add('   ITE_CODUNI, ');
        Add('   ITE_COMATA, ');
        Add('   ITE_COMDIS, ');
        Add('   ITE_COMLUB, ');
        Add('   ITE_COMTB1, ');
        Add('   ITE_COMTB2, ');
        Add('   ITE_COMTB3, ');
        Add('   ITE_COMTB4, ');
        Add('   ITE_COMTB5, ');
        Add('   ITE_COMTB6, ');
        Add('   ITE_COMTB7, ');
        Add('   ITE_COMVAR, ');
        Add('   ITE_DESFAB, ');
        Add('   ITE_DESITE, ');
        Add('   ITE_DESMAX, ');
        Add('   ITE_DESMGE, ');
        Add('   ITE_DESOPE, ');
        Add('   ITE_DESSIM, ');
        Add('   ITE_FREENT, ');
        Add('   ITE_ICMSAI, ');

        If (fCfgSis('IMPDIG') = '1') Then
          Add('   CADITE.ITE_IMPDIR AS ITE_IMPDIR, ')
        Else
          Add('   ITEGER.ITE_IMPDIR AS ITE_IMPDIR, ');

        Add('   ITE_IMPFED, ');
        Add('   ITE_IMPULT, ');
        Add('   ITE_INCPIS, ');
        Add('   ITE_IPIENT, ');
        Add('   ITE_IPISAI, ');
        Add('   ITE_LOCFIS, ');
        Add('   ITE_MARMGE, ');
        Add('   ITE_MARMIN, ');
        Add('   ITE_MARMSG, ');

        Add('   ITE_DESMVM, ');
        Add('   ITE_DESMSM, ');
        Add('   ITE_DESMGM, ');

        Add('   ITE_MARMMV, ');
        Add('   ITE_MARMMS, ');
        Add('   ITE_MARMMG, ');

        Add('   ITE_OBRCPF, ');
        Add('   ITE_OUTVAL, ');
        Add('   ITE_PESLIQ, ');
        Add('   ITE_PESOIT, ');
        Add('   ITE_PRECOM, ');
        Add('   ITE_PRECUS, ');
        Add('   ITE_PREMED, ');
        Add('   ITE_PREULT, ');
        Add('   ITE_PREVE1, ');
        Add('   ITE_PREVE2, ');
        Add('   ITE_PREVE3, ');
        Add('   ITE_PREVE4, ');
        Add('   ITE_PREVE5, ');
        Add('   ITE_PREVE6, ');
        Add('   ITE_PREVE7, ');
        Add('   ITE_QTPPRO, ');
        Add('   ITE_REFERE, ');
        Add('   ITE_SALDOS, ');
        Add('   ITE_EMBALA  ');
        Add(' FROM CADITE ');
        Add('   INNER JOIN ITEGER ');
        Add(' ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE ');
        Add('     AND ITEGER.ITE_CODEMP = :CODEMP ');
        Add('     AND CADITE.ITE_CODITE = :CODITE ');

        Close;
        ParamByName('CODEMP').AsString := fatVenda.fGetEmpCalculoItem();
        ParamByName('CODITE').AsString := dadosProduto.strCodIte;
        Open;

        parPreCus := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);
        Try
          fatVenda.pCarregaValoresCusto(dadosProduto.strCodIte, fatVenda.fGetEmpCalculoItem(), fatVenda.strTabPre);

          fatVenda.fltPreCus := fatVenda.fRetPreCus(FieldByName('ITE_PRECUS').AsFloat);
          fatVenda.fltPreCu2 := parPreCus.fCalculaPrecoCustoRealVenda(dadosProduto.fltUnitar,
                                                                      fatVenda.fRetPreCus(FieldByName('ITE_PRECUS').AsFloat),
                                                                      fatVenda.fRetOutVal(FieldByName('ITE_OUTVAL').AsFloat),
                                                                      fatVenda.fRetIcmSai(fGetIcmsSaida),
                                                                      fatVenda.fRetImpFed(FieldByName('ITE_IMPFED').AsFloat),
                                                                      fatVenda.fRetDesOpe(FieldByName('ITE_DESOPE').AsFloat) + fatVenda.fltDesOpeCli,
                                                                      0.0, 0.0);
        Finally
          FreeAndNil(parPreCus);
        End;

        fatVenda.pAdicionaRegistroTemporaria( cdsVenda,
                                              Nil,
                                              'NOR',
                                              FieldByName('ITE_CODGRU').AsString,
                                              dadosProduto.strCodIte,
                                              FieldByName('ITE_DESITE').AsString,
                                              FieldByName('ITE_DESITE').AsString + IIF(fCfgSis('IMPREF', varBoolean), ' ' + FieldByName('ITE_REFERE').AsString, ''),
                                              FieldByName('ITE_DESFAB').AsString,
                                              FieldByName('ITE_CODUNI').AsString,
                                              FieldByName('ITE_CODUNI').AsString,
                                              FieldByName('ITE_CODMAR').AsString,
                                              FieldByName('ITE_CODFOR').AsString,
                                              FieldByName('ITE_REFERE').AsString,
                                              dadosProduto.fltUniOri,
                                              dadosProduto.fltUniOri,
                                              dadosProduto.fltUnitar,
                                              dadosProduto.fltUnitar,
                                              0.00,
                                              dadosProduto.fltQtdIte,
                                              dadosProduto.fltQtdIte * dadosProduto.fltUnitar,
                                              'S',
                                              fatVenda.fltPreCus,
                                              fatVenda.fltPreCus * dadosProduto.fltQtdIte,
                                              FieldByName('ITE_COMLUB').AsString,
                                              FieldByName('ITE_IPISAI').AsFloat,
                                              FieldByName('ITE_DESMAX').AsFloat,
                                              FieldByName('ITE_PREVE1').AsFloat,
                                              FieldByName('ITE_PREVE2').AsFloat,
                                              FieldByName('ITE_PREVE3').AsFloat,
                                              FieldByName('ITE_PREVE4').AsFloat,
                                              FieldByName('ITE_PREVE5').AsFloat,
                                              FieldByName('ITE_PREVE6').AsFloat,
                                              FieldByName('ITE_PREVE7').AsFloat,

                                              fCalculaPrecoVenda(2, fatVenda.fRetPreCus(FieldByName('ITE_PRECUS').AsFloat) + fatVenda.fRetOutVal(FieldByName('ITE_OUTVAL').AsFloat),
                                                                    dadosProduto.fltUnitar,
                                                                    0,
                                                                    fatVenda.fRetIcmSai(fGetIcmsSaida),
                                                                    fatVenda.fRetImpFed(FieldByName('ITE_IMPFED').AsFloat),
                                                                    fatVenda.fRetDesOpe(FieldByName('ITE_DESOPE').AsFloat) + fatVenda.fltDesOpeCli,
                                                                    FieldByName('ITE_COMTB' + fatVenda.strTabPre).AsFloat, fatVenda.VS_strMARMKP),

                                              FieldByName('ITE_SALDOS').AsFloat,
                                              FieldByName('ITE_INCPIS').AsString,
                                              FieldByName('ITE_COMVAR').AsFloat,
                                              FieldByName('ITE_COMATA').AsFloat,
                                              FieldByName('ITE_COMDIS').AsFloat,
                                              '',
                                              '',
                                              '',
                                              0.0,
                                              0.0,
                                              '',
                                              FieldByName('ITE_PREULT').AsFloat * dadosProduto.fltQtdIte,
                                              FieldByName('ITE_IMPULT').AsFloat,
                                              FieldByName('ITE_PREULT').AsFloat,
                                              FieldByName('ITE_PREMED').AsFloat,
                                              FieldByName('ITE_CLAIPI').AsString,
                                              '',
                                              '',  //CODIGO DA TINTA
                                              '',
                                              '',
                                              0,
                                              '',
                                              0.0,
                                              0.0,
                                              0.0,
                                              0.0,
                                              0.0,
                                              'N',
                                              '',
                                              0.0,
                                              0.0,

                                              FieldByName('ITE_CODABF').AsString,
                                              FieldByName('ITE_PESOIT').AsFloat,
                                              FieldByName('ITE_PESLIQ').AsFloat,
                                              dadosProduto.strPromoc,
                                              0.0,
                                              0.0,
                                              0.0,
                                              0.0,
                                              '',
                                              0.0,
                                              FieldByName('ITE_CODFAB').AsString,
                                              cdsVenda.RecordCount + 1,
                                              0.0,
                                              dadosProduto.strNumOrc,
                                              dadosProduto.strEspOrc,
                                              dadosProduto.strEmpOrc,
                                              FieldByName('ITE_MARMIN').AsFloat,
                                              FieldByName('ITE_MARMSG').AsFloat,
                                              FieldByName('ITE_MARMGE').AsFloat,
                                              FatVenda.strDesMar,
                                              fatVenda.strStatus,
                                              0.0,
                                              0.0,
                                              '',
                                              '',
                                              '',
                                              FieldByName('ITE_EMBALA').AsFloat,
                                              '',
                                              '',
                                              '',
                                              FieldByName('ITE_PRECOM').AsFloat,
                                              dadosProduto.fltUnitar,
                                              FieldByName('ITE_QTPPRO').AsFloat,
                                              '',
                                              '',
                                              FieldByName('ITE_OBRCPF').AsString,
                                              '',
                                              '',
                                              fRetSiglaUnidade(FieldByName('ITE_CODUNI').AsString),
                                              0.0,
                                              fatVenda.fOrdemItem(cdsVenda,'Adiciona',nil),
                                              '',
                                              '',
                                              '',
                                              False,
                                              '',
                                              '',
                                              '',
                                              fatVenda.fRetOutVal(FieldByName('ITE_OUTVAL').AsFloat),
                                              FieldByName('ITE_COMTB' + fatVenda.strTabPre).AsFloat,
                                              fatVenda.fRetDesOpe(FieldByName('ITE_DESOPE').AsFloat),
                                              fatVenda.fRetIcmSai(fGetIcmsSaida),
                                              fatVenda.fRetImpFed(FieldByName('ITE_IMPFED').AsFloat),
                                              FieldByName('ITE_DESMGE').AsFloat,
                                              '',
                                              '',
                                              '',
                                              fatVenda.strTabPre,
                                              FieldByName('ITE_IPIENT').AsFloat,
                                              FieldByName('ITE_FREENT').AsFloat,
                                              '',
                                              0.0,
                                              '',
                                              0.0,
                                              dadosProduto.strEntRet,
                                              '',
                                              'N',
                                              '',
                                              IIF(dadosProduto.strEntRet = 'E', fatVenda.dtaPreVis, 0),
                                              dadosProduto.fltQtdIte,
                                              0,
                                              0,
                                              FieldByName('ITE_IMPDIR').AsString,
                                              FieldByName('ITE_LOCFIS').AsString,
                                              fatVenda.fltPreCu2,
                                              fatVenda.fltPreCu2 * dadosProduto.fltQtdIte,
                                              0,
                                              0,
                                              0,
                                              0,
                                              0,
                                              0,
                                              recForTin,
                                              '',
                                              '',
                                              '',
                                              '',
                                              '',
                                              False,
                                              IIF(dadosProduto.blnBaixaSubItemEstrutura, 'S', 'N'),
                                              'NOR',
                                              0,
                                              '',
                                              FieldByName('ITE_CODBAR').AsString,
                                              '',
                                              0,
                                              0,
                                              0,
                                              '',
                                              1,
                                              True,
                                              '',
                                              '',
                                              '',
                                              0,
                                              fatVenda.fRetPreCus(FieldByName('ITE_PRECUS').AsFloat),
                                              FieldByName('ITE_DESSIM').AsString,
                                              '',
                                              recMadeira,
                                              FieldByName('ITE_IMPULT').AsFloat * dadosProduto.fltQtdIte,
                                              0,
                                              0,
                                              '',
                                              0,
                                              '',
                                              '',
                                              0,
                                              0,
                                              '',
                                              '',
                                              0,
                                              '',
                                              'N',
                                              0,
                                              0,
                                              0,
                                              False,
                                              False,
                                              'N',
                                              '',
                                              0,
                                              0,
                                              '',
                                              'N',
                                              0,
                                              '',
                                              '',
                                              '',
                                              '',
                                              '',
                                              0.00,
                                              '',
                                              '',
                                              '',
                                              'S',
                                              'N',
                                              '',
                                              '',
                                              '',
                                              '',
                                              False,
                                              -1,
                                              -1,
                                              'N',
                                              '',
                                              'N',
                                              0,
                                              0,
                                              0,
                                              '',
                                              0,
                                              0,
                                              dadosProduto.intSeqInclusaoEstrutura,
                                              '',
                                              0,
                                              0,
                                              0,
                                              '',
                                              '',
                                              0,
                                              0,
                                              0,
                                              False,
                                              '',
                                              '',
                                              '',
                                              '',
                                              '',
                                              0,
                                              0,
                                              0,
                                              0,
                                              0,
                                              0,
                                              0,
                                              '',
                                              '',
                                              0,
                                              dadosProduto.fltDesCnd,
                                              '',
                                              '',
                                              'N',
                                              'N',
                                              '',
                                              0,
                                              0,
                                              '',
                                              '',
                                              '',
                                              '',
                                              '',
                                              '',
                                              '',
                                              '',
                                              '',
                                              FieldByName('ITE_DESMVM').AsFloat,
                                              FieldByName('ITE_DESMSM').AsFloat,
                                              FieldByName('ITE_DESMGM').AsFloat,
                                              FieldByName('ITE_MARMMV').AsFloat,
                                              FieldByName('ITE_MARMMS').AsFloat,
                                              FieldByName('ITE_MARMMG').AsFloat);

      End;

      Result := True;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '');
      End;
    End;
  Finally
    FreeAndNil(qryDadosItem);
  End;
end;

function TfrmFatExpedicaoItens.fItemTemRetira(strCodIte: string;
  fltQtdDig: Double): Boolean;
  Var
    cdsClone : TUniClientDataSet;
begin
  Result := False;

  If SameText(strCamBus, 'BAREMB') Then
    strCodIte := fCampoTabela('ITE_CODITE', 'CADITE', ['ITE_CODBAR'], [strCodIte]);

  If fEmptyStr(strCodIte) Then
    Exit;

  cdsClone := TUniClientDataSet.Create(Nil);
  Try
    pCloneDataSet(cdsClone, cdsItens);
    cdsClone.Filtered := False;
    cdsClone.Filter   := '((CODITE = ' + QuotedStr(strCodIte) + ') AND (RETENT = ' + QuotedStr('R') + '))';
    cdsClone.Filtered := True;
    cdsClone.First;

    While Not cdsClone.Eof Do
    Begin
      If ((cdsClone.FieldByName('QTDEXP').AsFloat + fltQtdDig) <= cdsClone.FieldByName('QTDITE').AsFloat) Then
      Begin
        Result := True;
        Break;
      End;
      cdsClone.Next;
    End;
  Finally
    FreeAndNil(cdsClone);
  End;
end;

function TfrmFatExpedicaoItens.fGetSQLDetMat : String;
Begin
  Result := '';
  Result := Result + ' SELECT DMT_ITESUB AS ITESUB,                          ';
  Result := Result + '        ITE_DESITE AS DESITE,                          ';
  Result := Result + '        DMT_QTDITE AS QTDITE                           ';
  Result := Result + ' FROM DETMAT                                           ';
  Result := Result + '   INNER JOIN GERMAT ON GERMAT.AUTOINCREM = DMT_SEQGER ';
  Result := Result + '   INNER JOIN CADITE ON ITE_CODITE = DMT_ITESUB        ';
  Result := Result + ' WHERE GMT_CODITE = :CODITE                            ';
End;

function TfrmFatExpedicaoItens.fAbreFormSeries(const fltQuantidade : Double; const blnIncrementarQtdItemPedDosExistentes : Boolean = False): Boolean;
  Var
    frmFatMultiSerie: TfrmFatMultiSerie;
begin
  pCriarFormularios(TfrmFatMultiSerie, frmFatMultiSerie);
  Try
    objFatSerieItem.AutoincItem := cdsItens.FieldByName('AUTOINCREM').AsString;
    objFatSerieItem.pFiltraDataSet;
    frmFatMultiSerie.fltQtdItemPed := IIF(fltQuantidade <=0 , 1, fltQuantidade);
    frmFatMultiSerie.pAlimentaCdsSeries(objFatSerieItem.cdsFatSeries, blnIncrementarQtdItemPedDosExistentes);
    frmFatMultiSerie.ShowModal;

    Result := frmFatMultiSerie.ModalResult = mrOk;

    If Not Result Then
      Exit;

    objFatSerieItem.pApagaSeries;
    objFatSerieItem.pApagaSeriesGravacao;

    frmFatMultiSerie.cdsSeries.First;
    While Not frmFatMultiSerie.cdsSeries.Eof Do
    Begin
      objFatSerieItem.pInsereSerie(frmFatMultiSerie.cdsSeriesNUMSER.AsString,
                                   frmFatMultiSerie.cdsSeriesQTDSER.AsFloat);

      If (frmFatMultiSerie.cdsSeriesQTDSER.AsFloat > 0) Then
      Begin
        objFatSerieItem.pInsereSerieParaGravacao(frmFatMultiSerie.cdsSeriesNUMSER.AsString,
                                                 frmFatMultiSerie.cdsSeriesQTDSER.AsFloat);
      End;

      frmFatMultiSerie.cdsSeries.Next;
    End;
  Finally
    pFreeAndNil(frmFatMultiSerie);
  End;
end;

function TfrmFatExpedicaoItens.fGravaSeriesNseDor: Boolean;
var
  blnGravouSerie: Boolean;
begin
  blnGravouSerie := False;
  Result := True;
  cdsItens.DisableControls;
  Try
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      If cdsItens.FieldByName('USASER').AsString = 'S' Then
      Begin
        objFatSerieItem.AutoincItem := cdsItens.FieldByName('AUTOINCREM').AsString;
        objFatSerieItem.pFiltraDataSet;

        objFatSerieItem.cdsFatSeries.First;
        While Not objFatSerieItem.cdsFatSeries.Eof Do
        Begin
          Result := fGravaNseDor(cdsItens.FieldByName('AUTOINCREM').AsString,
                                 objFatSerieItem.cdsFatSeries.FieldByName('NUMSER').AsString,
                                 objFatSerieItem.cdsFatSeries.FieldByName('QTDSER').AsFloat);

          If Not Result Then
            Exit;

          blnGravouSerie := (blnGravouSerie) Or (objFatSerieItem.cdsFatSeries.FieldByName('QTDSER').AsFloat > 0);

          objFatSerieItem.cdsFatSeries.Next;
        End;

        If Result Then
          fExecutaSQL('UPDATE EXTDOR SET FDO_TEMNSE = "' + IIF(blnGravouSerie, 'S', 'N') + '" WHERE FDO_SEQFDO = '+ QuotedStr(cdsItens.FieldByName('AUTOINCREM').AsString));
      End;

      cdsItens.Next;
    End;
  Finally
    pEnableCdsItens();
  End;
end;

function TfrmFatExpedicaoItens.fValidaQuantidadeItensCaixasItensExpedidos: Boolean;
var
  strLinha              : String;
  cdsClone              : TUniClientDataSet;
  objItem               : TItemDaCaixa;
  objCaixa              : TCaixa;
  intDecQtd             : Integer;
  fltQtdeItemCaixa      : Double;
  fltQtdeItemExpedido   : Double;
  stlMensagem           : TStringList;
  blnTemDivergencia     : Boolean;

  procedure pMostrarMensagemDivergencia;
  var
    frmMensagemExplicativa : TfrmMensagemExplicativa;
  begin
    pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);

    Try
      stlMensagem.Insert(0, 'ATENÇÃO! Foram encontradas divergências ao gravar '
                          + 'as caixas do pedido. A quantidade do item na caixa '
                          + 'não bate com a quantidade expedida. Por Favor, entre '
                          + 'em contato com a Citel. Relação: ');

      stlMensagem.Insert(1, '');

      stlMensagem.Insert(2, DupeString('-', 98));
      stlMensagem.Insert(3, fstrEspaco('Descrição', 50)
                          + fstrEspaco('| Qtde Expedida', 15)
                          + fstrEspaco('| Caixa', 18)
                          + fstrEspaco('| Qtde Caixa', 12));

      stlMensagem.Insert(4, DupeString('-', 98));

      frmMensagemExplicativa.Caption := 'Inconsistências';
      frmMensagemExplicativa.Width   := 950;
      frmMensagemExplicativa.Height  := 400;
      frmMensagemExplicativa.mmoInstru.Lines.Text := stlMensagem.Text;
      frmMensagemExplicativa.ShowModal;
    Finally
      pFreeAndNil(frmMensagemExplicativa);
    End;
  end;
begin
  If Not fUsaMontagemCaixas Then
    Exit(True);

  If (fCfgSis('VALCAI', varString) <> 'S') Then
    Exit(True);

  intDecQtd := fCfgSis('DECQTD', VarInteger);
  blnTemDivergencia := False;

  cdsClone := TUniClientDataSet.Create(Self);
  stlMensagem := TStringList.Create;
  Try
    stlMensagem.Clear;

    pCloneDataSet(cdsClone, cdsItens);

    cdsClone.First;
    While Not cdsClone.Eof Do
    Begin
      fltQtdeItemCaixa    := fFormataFloat(objMontarCaixas.fSomaQtdItemNasCaixas(cdsClone.FieldByName('AUTOINCREM').AsString), intDecQtd);
      fltQtdeItemExpedido := fFormataFloat(cdsClone.FieldByName('QTDEXP').AsFloat, intDecQtd);

      If (fltQtdeItemCaixa = 0) Then
      Begin
        cdsClone.Next;
        Continue;
      End;

      If (fltQtdeItemCaixa <> fltQtdeItemExpedido) Then
      Begin
        blnTemDivergencia := True;

        strLinha := Copy(fstrEspaco(cdsClone.FieldByName('DESITE').AsString, 50),1,50)
                  + '| '
                  + fstrEspaco(FormatFloat(',0.00', cdsClone.FieldByName('QTDEXP').AsFloat), 13, 2);

        For objCaixa In objMontarCaixas.Caixas Do
        Begin
          For objItem In objCaixa.Itens Do
          Begin
            If cdsClone.FieldByName('AUTOINCREM').AsString = objItem.strID Then
            Begin
              strLinha := strLinha
                        + '| '
                        + fstrEspaco(objCaixa.strID, 13)
                        + '| '
                        + fstrEspaco(FormatFloat(',0.00', objItem.fltQuantidade), 13, 2);

              stlMensagem.Add(strLinha);

              strLinha := fstrEspaco(EmptyStr, 50)
                        + '| '
                        + fstrEspaco(EmptyStr, 13);
            End;
          End;
        End;

        stlMensagem.Add(DupeString('-', 98));
      End;

      cdsClone.Next;
    End;

    Result := (Not blnTemDivergencia);

    If (Not Result) Then
      pMostrarMensagemDivergencia;
  Finally
    FreeAndNil(cdsClone);
    FreeAndNil(stlMensagem);
  End;
end;

function TfrmFatExpedicaoItens.fValidaQuantSerieItens: Boolean;
begin
  Result := True;
  cdsItens.DisableControls;
  Try
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      If cdsItens.FieldByName('USASER').AsString = 'S' Then
      Begin
        pLimpaNseDor(cdsItens.FieldByName('AUTOINCREM').AsString);
        objFatSerieItem.AutoincItem := cdsItens.FieldByName('AUTOINCREM').AsString;
        objFatSerieItem.pFiltraDataSet;

        If Not SameValue(fFormataFloat(objFatSerieItem.fGetTotQuant, intDecQtd),
                         fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat, intDecQtd)) Then
        Begin
          Result := False;
          Break;
        End;
      End;

      cdsItens.Next;
    End;
  Finally
    pEnableCdsItens();
  End;
end;

procedure TfrmFatExpedicaoItens.FormCreate(Sender: TObject);
Begin
  inherited;

  frmFechamentoVenda := Nil;

  blnCarregandoDadosItemEstrutura := False;
  blnOndaSepComCodBar := False;

  FParams := TExpedicaoParams.Create;
  FParams.cdsItens := Self.cdsItens;

  pSetaCodIte(cdsSelecaoCODITE);
  pEsvaziaArrayCfgDes;
  FParams.blnBaiEntFut := False;
  FParams.blnExpAut := False;
  FParams.cdsFilEst := Nil;
  dtaInicioConferencia := 0;
  blnIgnorarScroll := False;
  blnMarcandoTodos := False;
  FParams.strCfgENFUOP := '';
  FParams.blnFreteRateado := False;
  FParams.strRegimeEspecial := '';
  FParams.blnDesmembraPedRegEsp := False;
  FParams.strEmpresaSolicitanteAbastecimentoDeposito := '';
  FParams.blnAbastecimentoDeposito := False;

  FParams.strSeparador := '';
  strPrefixCx := '';

  intSemaforoExpAut := -1;

  intCorZeb := fCfgSis('CORZEB',varInteger);

  pnlFoto.Visible := (fCfgSis('FOTEXP') = 'S');
  If Not pnlFoto.Visible Then
    Self.Width := Self.Width - pnlFoto.Width;

  cdsDetMat    := TZClient.Create(Self, fGetSQLDetMat);
  objLiberacao := TLiberacao.Create;
  dbgDetMat.DataSource := cdsDetMat.dtsSource;

  pnlEstrutura.Visible    := (fCfgSis('ESTEXP') = 'S');
  pnlPicEstrutura.Visible := pnlEstrutura.Visible;
  If not pnlEstrutura.Visible Then
    Self.Height := Self.Height - pnlEstrutura.Height;

  strBarBal      := fCfgSis('DIGBAL');
  strLogFileName := fNomeDoComputador + '_' + FormatDateTime('yyyyMMddhhmmss', VS_Date + fTime()) + '.txt';

  VS_strTipDEx := fCfgSis('TIPDEX');

  If VS_strTipDEx = '1' Then
    strMsgSel := '[ENTER] Marca / Desmarca Item'
  Else
    strMsgSel := '[BARRA DE ESPAÇO] Marca / Desmarca Item';

  objIteBar     := TIteBar.Create(opcFuncoes);
  FParams.blnAutSer := False;
  FParams.blnTemRec := False;
  FParams.blnTemAdt := False;
  FParams.blnBolAdt := False;
  FParams.strCtrNumDup  := '';
  FParams.strCtrEspDoc  := '';
  FParams.strCtrCodEmp  := '';
  FParams.strCtrCodCli  := '';
  FParams.strEspTra     := '';

  FParams.blnSimplesRemessaConcreto := False;
  FParams.blnApenasConferenciaProdutosRetiraCaixa := False;

  blnTemItensRetira := False;
  blnTemItensTintas := False;
  FParams.blnUsaImpressaoSeparacaoPorLocal := False;
  FParams.blnSepPorArmazem := False;
  FParams.blnControlePorArmazem := (fCfgSis('CTLEST') = '2');

  if Assigned(frmFatExpedicao) then
  begin
    if frmFatExpedicao.dtsPedidos.DataSet.FieldByName('PEDPAR').AsString <> 'R' then
      FParams.blnReposicao := False
    else
      FParams.blnReposicao := True;
  end
  else
    FParams.blnReposicao := False;

  FParams.blnCarregarQtdExpedida := False;

  fatVenEst   := TFatVenda.CreateInstance('VN', False);
  fatVenEst.blnExpedi := True;
  fatVenEst.blnEmpFat := fatVenEst.blnEmpFat Or fPermiteInformarEmpresaNoItem('PD');//Necessario para filtrar a reserva de saldo pelo campo FDO_EMPITE

  intDecQtd := fCfgSis('DECQTD', varInteger);
  edtQtdIte.EditFormat := fMskDigitos(intDecQtd);

  pnlCaixas.Visible          := fUsaMontagemCaixas;
  lblDimensaoCaixa.Visible   := (pnlCaixas.Visible) And
                                (fAtivadoMontagemCaixaConferenciaAUTCOMColetor);

  cxImgDimensaoCaixa.Visible := lblDimensaoCaixa.Visible;

  fFindColumnByName(dbgItens, 'MONCAI').Visible := pnlCaixas.Visible;

  If pnlCaixas.Visible Then
  Begin
    qryItensSemCaixa := fCriaQuery;
    objMontarCaixas := TMontarCaixas.Create;
    cdsEtiCaixa.CreateDataSet;
    pSetaBotaoMontarCaixas(CAP_MONTAR_CAIXA);
    pPreencheListaCaixas;
    pPrencheGridItensCaixa;

    If fCfgSis('COMBAL', varString) = 'S' Then
      tmrLePeso.Enabled := True;

    If lblDimensaoCaixa.Visible Then
      pPreencheListaDimensaoCaixa;
  End;

  If (VS_strTipDEx = '1') Then
  Begin
    btnQuantidade.Visible := True;
    edtQtdIte.Enabled := False;
    edtQtdChapas.Enabled := False;
  End
  Else
    btnQuantidade.Visible := False;

  strOrdExi := fCfgSis('ORDEXI');
  strOrdDoc := fCfgSis('ORDDOC');

  objCodBar := TCodigoBarras.Create;

  btnPesarCaixa.Enabled := fCfgSis('COMBAL', varString) = 'S';
  edtPesBru.Enabled     := fCfgSis('COMBAL', varString) = 'N';
  btnImpEtiCaixa.Visible:= ( (fCfgSis('IMPCAI', varInteger) = 1) Or
                             (fCfgSis('IMPCAI', varInteger) = 3) Or
                             (fCfgSis('IMPCAI', varInteger) = 4) );
  btnLimpaExp.Visible   := MatchStr(VS_strTipExp, [TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO, TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO]);
  btnSelMan.Visible     := (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And (fCfgSis('EXPATE', varBoolean));
  FParams.blnExpParcialTipExp4  := False;
  FParams.blnLimparExpedidos    := False;
  blnUsaPafEcf          := fCfgSis('PAFECF', varBoolean);
  FParams.blnUsaRotinaWMS := fUsaRotinaWMS;
  btnItensnaoExpedidos.Visible := True;
  blnItemConferido := False;
  btnCfgExpItens.Visible := fVerificaAcessoSistema('EXBCEX');
  dbgItens.Font.Size := TCfgSugExp.fCarregaTAmanhoFonte('speTamanhoFonte');
  if dbgItens.Font.Size <= 0 then
  begin
    dbgItens.Font.Size := 8;
  end;
  dbgEtiCaixa.Font.Size := dbgItens.Font.Size;
  If fCfgSis('BARLOT', varBoolean) Then
    objEtiqueta := TProcessaEtiqueta.Create('FRMFATEXPEDICAOITENS');

  blnExiApl := fCfgSis('EXIAPL', varBoolean);
  FParams.blnPermiteExpParcial := False;

  objFatSerieItem := TFatSerieItem.Create(Self);
  SetLength(arrJaExpedidoList, 0);
  SetLength(arrTotaisPeso, 0);

  cdsSetores := TUniClientDataSet.Create(Self);
  btnDigCodBarLocFis.Visible := fVerificaAcessoSistema('PERMDIGCODBARLOCFIS');
  FParams.stlListaClientes := TStringList.Create;
  FParams.stlListaGrupos   := TStringList.Create;
  stlListaCondicaoPagamento := TStringList.Create;
  cdsValoresCli.CreateDataSet;

  strTipPedMultiplos := '';
  FParams.blnVendaPerdidaAutomatica := False;

  blnValidouLotePeloCodigoBarrasDoLote := False;
  FParams.blnMaisDeUmPedidoDoMesmoClienteComAdiantamento := False;

  SetLength(arrEtiquetaImpressaoMultiSelecao, 0);

  chkCaixaRapida.Checked   := False;
  chkCaixaRapida.Visible   := fUtilizaCaixaRapida();
  chkTodasAsCaixas.Checked := fConsiderarTodasAsCaixas();
  grbImpSeq.Visible        := fUtilizaImpressaoSequencial();

  If (grbImpSeq.Visible) Then
    chkImpSeq.Checked := (fCfgSis('PIMPSQ', varString) = 'M');

  blnImpEtiDespachoVolumeComposto := False;

  FParams.strBotaoAcionado := '';
  FParams.blnFatAut := False;
  FParams.blnPermiteExpedirPedidoAVistaCaixaFechado := False;
  FParams.blnExibirRetiraEntregaPedidosTransfFaturamentoAntExp := False;

  blnValidaNumeroSerie := True;

  stlItensNumSerieExpAut := TStringList.Create;

  blnUtilizaSeparacaoExclusiva := fCfgSis('SEPEXC', varBoolean);

  If fCfgSis('TIPBAR', varString) = '2' Then
    edtCodIte.MaxLength := 43;

  blnJaExibiuTelaDigVolumesCompostos := False;
end;

procedure TfrmFatExpedicaoItens.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FParams);

  pEsvaziaArrayCfgDes;

  If Assigned(objEtiqueta) Then
    FreeAndNil(objEtiqueta);

  If Assigned(objFatSerieItem) Then
    FreeAndNil(objFatSerieItem);

  If Assigned(stlItensNumSerieExpAut) Then
    FreeAndNil(stlItensNumSerieExpAut);

  inherited;
end;

function TfrmFatExpedicaoItens.fExpedePedido(fltQtdExp: Double): Boolean;
Var
  strCodCon  : String;
  strCodSep  : String;
  strObsExp  : String;
  strEmbExp  : String;
  blnConfirma: Boolean;
  blnSeparadorApareceuDesabilitado: Boolean;
  blnPedVol  : Boolean;
begin

  blnConfirma := True;

  strCodSep := '';

  If (fCfgSis('SEPCOL') = 'S') And ((FParams.VS_strTipExpInterna = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or
                                    (FParams.VS_strTipExpInterna = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO )) Then
  Begin
    strCodSep := fRetornaSeparadorColetor(FParams.strNumDoc, FParams.strCodEmp, FParams.strEspDoc);

    If (fEmptyStr(strCodSep)) Then
      strCodSep := fRetornaSeparadorColetorSepDor;
  End;

  If (strCodSep = '') Then
    strCodSep := FParams.strSeparador;

  {*******************************************}
  {* INFORMA SEPARADOR E CONFERENTE          *}
  {****************************************PZ*}
  If (fltQtdExp > 0) And (fCfgSis('EXSECO') = 'S') Then
  Begin
    blnConfirma := False;
    If (fSolicitaConferenteSeparador(strCodCon, strCodSep, strObsExp, strEmbExp, blnSeparadorApareceuDesabilitado)) Then
    Begin
      blnConfirma := True;

      If Assigned(objConDor) Then
        objConDor.pSetOpeCon(strCodCon);
    End;
  End;

  If (fltQtdExp > 0) And (fCfgSis('EXSECO') = 'N') And (fEmptyStr(strCodCon)) Then
    strCodCon := strLoginUsuarioLogado;

  blnPedVol := True;
  If (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
    blnPedVol := AnsiMatchText(fCfgSis('SLDVT4', varString), ['S', 'C']);

  If (blnPedVol) And (fCfgSis('VOLEXP') = 'S') And ((Not fVaiFaturarAposExpedirTodosOsItens) Or (fCfgSis('EXVOPD') = 'S')) Then
  Begin
    blnEtiVol := (fCfgExpedicaoParcialHabilitada);
    pPedeDigVolumes(Nil);
  End;

  If (blnConfirma) Then
    blnConfirma := fMarcaPedidoExpedido(strCodCon, strCodSep, strObsExp, ((fltQtdExp=0) Or blnSeparadorApareceuDesabilitado), cdsSetores, strEmbExp);

  Result := blnConfirma;
end;

function TfrmFatExpedicaoItens.fExpedindoMaisDeUmPedido: Boolean;
Var
  intRecNo      : Integer;
  intIndex      : Integer;
  stlDocumentos : TStringList;
  blnEncontrou  : Boolean;
  strChave      : String;
begin
  Result := False;

  If (Not cdsItens.Active) Then
    Exit;

  If (cdsItens.RecordCount = 0) Then
    Exit;

  stlDocumentos := TStringList.Create;
  intRecNo := cdsItens.RecNo;
  cdsItens.DisableControls;

  Try
    cdsItens.First;
    While (Not cdsItens.Eof) Do
    Begin
      blnEncontrou := False;

      strChave := cdsItens.FieldByName('NUMDOC').AsString + cdsItens.FieldByName('ESPDOC').AsString + cdsItens.FieldByName('CODEMP').AsString;

      For intIndex := 0 To Pred(stlDocumentos.Count) Do
      Begin
        If (stlDocumentos[intIndex] = strChave) Then
        Begin
          blnEncontrou := True;
          Break;
        End;
      End;

      If (Not blnEncontrou) Then
        stlDocumentos.Add(strChave);

      cdsItens.Next;
    End;

    Result := (stlDocumentos.Count > 1);
  Finally
    FreeAndNil(stlDocumentos);

    cdsItens.RecNo := intRecNo;
    pEnableCdsItens();
  End;
end;

function TfrmFatExpedicaoItens.fExpedicaoJaIniciada: Boolean;
begin
  Result := (fTemCaixasNaExpedicao() Or fTemItensExpedidos());
end;

function TfrmFatExpedicaoItens.fSolicitaConferenteSeparador(Var strCodCon,
  strCodSep, strObsExp, strCodEmb: String; Var blnSeparadorApareceuDesabilitado: Boolean): Boolean;
begin
  If FParams.blnOndaSeparacao And (Not fEmptyStr(strCodSepOnda)) And (Not fEmptyStr(strCodConOnda)) Then
  Begin
    strCodSep := strCodSepOnda;
    strCodCon := strCodConOnda;
    strObsExp := strObsExpOnda;
    Exit(True);
  End;

  If FParams.blnFaturandoTodosAutomaticamente Then
  Begin
    strCodSep := strLoginUsuarioLogado;
    strCodCon := strLoginUsuarioLogado;
    strObsExp := 'Expedição e faturamento automático';
    Exit(True);
  End;

  Result := TFatSeparadorConferente.New
    .Coletor(FParams.blnColetor)
    .CarregaConferente(False)
    .MostrarObs(False)
    .Solicitar(strCodCon, strCodSep, strObsExp, strCodEmb, blnSeparadorApareceuDesabilitado, cdsSetores, cdsItens);

  If FParams.blnOndaSeparacao And Result Then
  Begin
    strCodSepOnda := strCodSep;
    strCodConOnda := strCodCon;
    strObsExpOnda := strObsExp;
  End;

end;

function TfrmFatExpedicaoItens.fSomenteExpedirSemFaturar: Boolean;
begin
  Result := True;

  If FParams.blnFaturarAposExpedirTodosOsItens Then
  Begin
    Result := False;

    If (fCfgSis('UIESCP', varBoolean)) Then
      Result := (fMensagem('', 'Confirma emissão de faturamento?', ['&Sim', '&Não']) = 2);
  End;
end;

function TfrmFatExpedicaoItens.fSomenteFaturarParcialEmFF(var blnAbortarFaturamento: Boolean): Boolean;
var
  qryPedido: TUniQuery;
  strDocumentos: String;
  strMensagem: String;
  strSeqGer: String;
  intContador: Integer;
begin
  Result := False;

  blnAbortarFaturamento := False;

  if not fCfgSis('EXFPFF', varBoolean) then
    Exit;

  if not Params.blnFaturarExpedidos then
    Exit;

  if fCfgSis('TIPEXP') <> TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO then
    Exit;

  if FParams.stlPedidos.Count <= 0 then
    Exit;

  if fClienteFilial(TPedidoVenda(FParams.stlPedidos.Objects[0]).strCodCli) then
    Exit;

  qryPedido := fCriaQuery;

  try
    strDocumentos := EmptyStr;
    strMensagem := EmptyStr;
    strSeqGer := EmptyStr;

    for intContador := 0 to FParams.stlPedidos.Count - 1 do
    begin
      pIncrementaListaStr(TPedidoVenda(FParams.stlPedidos.Objects[intContador]).strSeqGer, strSeqGer, True);
    end;

    qryPedido.Close;
    qryPedido.SQL.Clear;
    qryPedido.SQL.Add('SELECT F.FDO_CODCLI, F.FDO_NUMDOC, F.FDO_ESPDOC, F.FDO_CODEMP, ');
    qryPedido.SQL.Add('       D.DET_NUMDOC, D.DET_ESPDOC, D.DET_CODEMP');
    qryPedido.SQL.Add('FROM FATDOR F');
    qryPedido.SQL.Add('INNER JOIN MOVDET D');
    qryPedido.SQL.Add('ON(F.FDO_NUMDOC = D.DET_NUM_PD AND ');
    qryPedido.SQL.Add('   F.FDO_ESPDOC = D.DET_ESP_PD AND ');
    qryPedido.SQL.Add('   F.FDO_CODEMP = D.DET_EMP_PD AND ');
    qryPedido.SQL.Add('   F.FDO_CODCLI = D.DET_CODCLI AND');
    qryPedido.SQL.Add('   F.FDO_SEQIND = D.DET_IND_PD AND ');
    qryPedido.SQL.Add('   F.FDO_CODITE = D.DET_CODITE) ');
    qryPedido.SQL.Add('WHERE F.FDO_SEQGER IN ('+strSeqGer+')');
    qryPedido.SQL.Add('GROUP BY F.FDO_CODCLI, F.FDO_NUMDOC, F.FDO_ESPDOC, F.FDO_CODEMP,');
    qryPedido.SQL.Add('         D.DET_NUMDOC, D.DET_ESPDOC, D.DET_CODEMP');
    qryPedido.Open;

    if qryPedido.IsEmpty then
    begin
      if not FParams.blnExpParcialTipExp4 then
        Exit;

      strMensagem := strMensagem + 'O pedido está sendo faturado parcialmente e conforme a configuração ' + sLineBreak;
      strMensagem := strMensagem + '"CFG_EXFPFF - Expedição - Ao fazer faturamento parcial, emitir apenas FF ?", será emitida uma FF.' + sLineBreak;
      strMensagem := strMensagem + 'Deseja continuar?';

      If fMensagem('Atenção!', strMensagem, ['&Sim', '&Não'], 1, False, 1, 0, False, 0, False, False, False, 200, 400) = 1 Then
        Result := True
      Else
        blnAbortarFaturamento := True;
    end
    else
    begin
      while not qryPedido.Eof do
      begin
        if FParams.stlPedidos.Count > 1 then
        begin
          if not fEmptyStr(strDocumentos) then
            strDocumentos := strDocumentos + sLineBreak;

          strDocumentos := strDocumentos + 'Documento(s) emitido(s) anteriormente: Pedido: ' + qryPedido.FieldByName('FDO_NUMDOC').AsString + '-' +
                                                                                               qryPedido.FieldByName('FDO_ESPDOC').AsString + '-' +
                                                                                               qryPedido.FieldByName('FDO_CODEMP').AsString + ' - ' +
                                                                                   'Faturamento: ' + qryPedido.FieldByName('DET_NUMDOC').AsString + '-' +
                                                                                                     qryPedido.FieldByName('DET_ESPDOC').AsString + '-' +
                                                                                                     qryPedido.FieldByName('DET_CODEMP').AsString;
        end
        else
        begin
          if not fEmptyStr(strDocumentos) then
            strDocumentos := strDocumentos + ', ';

          strDocumentos := strDocumentos + qryPedido.FieldByName('DET_NUMDOC').AsString + '-' +
                                           qryPedido.FieldByName('DET_ESPDOC').AsString + '-' +
                                           qryPedido.FieldByName('DET_CODEMP').AsString;
        end;

        qryPedido.Next;
      end;

      if FParams.stlPedidos.Count > 1 then
      begin
        strMensagem := strMensagem + 'Atenção! Entre os pedidos selecionados, existem pedidos que estão sendo ou foram faturados parcialmente e conforme a configuração ' + sLineBreak;
        strMensagem := strMensagem + '"CFG_EXFPFF - Expedição - Ao fazer faturamento parcial, emitir apenas FF ?", será emitida uma FF.' + sLineBreak + sLineBreak;
        strMensagem := strMensagem + strDocumentos + sLineBreak + sLineBreak;
        strMensagem := strMensagem + 'Deseja continuar?';
      end
      else
      begin
        strMensagem := strMensagem + 'O pedido selecionado já foi faturado parcialmente anteriormente e conforme a configuração ' + sLineBreak;
        strMensagem := strMensagem + '"CFG_EXFPFF - Expedição - Ao fazer faturamento parcial, emitir apenas FF ?", será emitida uma FF.' + sLineBreak + sLineBreak;
        strMensagem := strMensagem + 'Documento(s) emitido(s) anteriormente: ' + strDocumentos + sLineBreak + sLineBreak;
        strMensagem := strMensagem + 'Deseja continuar?';
      end;

      If fMensagem('Atenção!', strMensagem, ['&Sim', '&Não'], 1, False, 1, 130, False, 0, False, False, False, 300, 800) = 1 Then
        Result := True
      Else
        blnAbortarFaturamento := True;
    end;
  finally
    FreeAndNil(qryPedido);
  end;
end;

function TfrmFatExpedicaoItens.fUsaMontagemCaixas: Boolean;
begin
  if not FParams.blnReposicao then
    Result := (fCfgSis('MONCAI', varString) = 'S') And MatchStr(VS_strTipExp, [TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO, TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO])
  else
    Result := False;
end;

function TfrmFatExpedicaoItens.fUtilizaCaixaRapida: Boolean;
begin
  Result := fCfgSis('FDECXR', VarBoolean);
end;

function TfrmFatExpedicaoItens.fUtilizaImpressaoMultiplosPedidos(
  stlPedidos: TStringList): Boolean;
var
  objPed: TPedidoVenda;
  intPed: integer;
  strCodCli: String;
begin
  Result := False;

  if not fCfgSis('ETIUNI', varBoolean) then
    Exit;

  if VS_strTipExp <> '4' then
    Exit;

  if stlPedidos.Count <= 1 then
    Exit;

  objPed := TPedidoVenda(stlPedidos.Objects[0]);
  strCodCli := objPed.strCodCli;

  for intPed := 0 To stlPedidos.Count - 1 do
  begin
    objPed := TPedidoVenda(stlPedidos.Objects[intPed]);

    if strCodCli <> objPed.strCodCli then
      Exit;
  end;

  Result := True;
end;

function TfrmFatExpedicaoItens.fUtilizaImpressaoSequencial: Boolean;
begin
  Result := fCfgSis('FDEUIS', VarBoolean);
end;

function TfrmFatExpedicaoItens.fMaisDeUmPedidoDoMesmoClienteComAdiantamento(const stlDocumentosSelecionados : TStringList): Boolean;
var
  intContador  : Integer;
  intQtdDocADT : Integer;
begin

  Result := False;

  If Not fPermitirMarcarPedidosDeClientesDiferentesNaExpedicao Then
    Exit;

  If Not (stlDocumentosSelecionados.Count > 1) Then
    Exit;

  If Not (FParams.stlListaClientes.Count = 1) Then
    Exit;

  intQtdDocADT := 0;

  For intContador := 0 To stlDocumentosSelecionados.Count -1 Do
    intQtdDocADT := intQtdDocADT + IIF(TPedidoVenda(stlDocumentosSelecionados.Objects[intContador]).strTemADT.Equals('S'), 1, 0);

  If Not (intQtdDocADT >= 1) Then
    Exit;

  Result := True;

end;

function TfrmFatExpedicaoItens.fMarcadaOpcaoEtiquetasDespacho(blnVolumeComposto: Boolean): Boolean;
begin
  If (fCfgSis('TIPEXP') = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And (Params.blnFaturarExpedidos) Then
  Begin
    If blnVolumeComposto Then
      Result := fCfgSis('VOLCFE', varBoolean)
    Else
      Result := fCfgSis('IMPDFE', varBoolean);
  End
  Else
  Begin
    If blnVolumeComposto Then
      Result := fCfgSis('VOLCOM', varBoolean)
    Else
      Result := fCfgSis('IMPDES', varBoolean);
  End;
end;

function TfrmFatExpedicaoItens.fMarcaPedidoExpedido(strCodCon, strCodSep, strObsExp: String; blnAtualizarSeparadorSomenteSeVazio: Boolean = False; cdsSetores: TClientDataSet= Nil; strEmbExp: String=''): Boolean;
  Var
    objPed: TPedidoVenda;
    intPed: Integer;
    blnComitou : Boolean;
    strMultPed: String;
    strMultNumDoc: String;
    strMultEspDoc: String;
    strMultCodEmp: String;
    strMultCodCli: String;
    tpeResultadoEtiqueta: TResultadoEtiquetaUnificada;

  function fAlterarVolumeEspeci: Boolean;
  Begin
    Result := True;

    If (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
      Result := AnsiMatchText(fCfgSis('SLDVT4', varString), ['S', 'C']);
  End;
begin
  Result := False;
  blnComitou := False;
  Try
    fStartTransaction;

    pAtualizaExpedicaoItens(strCodCon, strCodSep, strObsExp, strEmbExp, True);

    For intPed := 0 To FParams.stlPedidos.Count - 1 Do
    Begin
      objPed := TPedidoVenda(FParams.stlPedidos.Objects[intPed]);
      pAtualizaPedidoDadosExpedicao(strCodCon, strCodSep, strObsExp, objPed, fPedidoExpedido(objPed), False,
        dtaInicioConferencia, dtaFinalConferencia, FParams.intQtdTra, FParams.strEspTra, blnAtualizarSeparadorSomenteSeVazio,
        FParams.intQtdTraSepExc, FParams.intQtdTraSepNExc, fAlterarVolumeEspeci);
    End;

    If fUtilizaImpressaoMultiplosPedidos(FParams.stlPedidos) Then
    Begin
      pVinculaPedidosComMesmoClienteExpedidosJuntos(FParams.stlPedidos);
    End;

    strCodConferente := strCodCon;
    strCodSeparador  := strCodSep;

    pGravarInformacoesSeparacao;

    fCommit;
    blnComitou := True;

    If (blnImpEti) And (FParams.intQtdTra > 0) Then
    Begin
      If fVaiImprimirMultiplosPedidosNaEtiquetaDeDespacho(strMultPed, strMultNumDoc, strMultEspDoc, strMultCodEmp, strMultCodCLi, FParams.stlPedidos) Then
      Begin
        pImprimeEtiquetaDespacho(strMultNumDoc, strMultEspDoc, strMultCodCLi, FParams.intQtdTra, strMultCodEmp, tpeResultadoEtiqueta, False, FParams.intQtdTraSepExc, FParams.intQtdTraSepNExc, strMultPed);
      End
      Else
      Begin
        For intPed := 0 To FParams.stlPedidos.Count - 1 Do
        Begin
          objPed := TPedidoVenda(FParams.stlPedidos.Objects[intPed]);
          pImprimeEtiquetaDespacho(objPed.strNumDoc, objPed.strEspDoc, objPed.strCodCli, FParams.intQtdTra,
                                   objPed.strCodEmp, tpeResultadoEtiqueta, False, FParams.intQtdTraSepExc, FParams.intQtdTraSepNExc);
        End;
      End;
    End;

    If (blnImpEtiDespachoVolumeComposto) Then
    Begin
      If fVaiImprimirMultiplosPedidosNaEtiquetaDeDespacho(strMultPed, strMultNumDoc, strMultEspDoc, strMultCodEmp, strMultCodCLi, FParams.stlPedidos) Then
      Begin
        pImprimeEtiquetaDespacho(strMultNumDoc, strMultEspDoc, strMultCodCLi, 1, strMultCodEmp, tpeResultadoEtiqueta, blnImpEtiDespachoVolumeComposto, 0, 0, strMultPed);
      End
      Else
      Begin
        For intPed := 0 To FParams.stlPedidos.Count - 1 Do
        Begin
          objPed := TPedidoVenda(FParams.stlPedidos.Objects[intPed]);
          pImprimeEtiquetaDespacho(objPed.strNumDoc, objPed.strEspDoc, objPed.strCodCli, 1, objPed.strCodEmp, tpeResultadoEtiqueta, blnImpEtiDespachoVolumeComposto);
        End;
      End
    End;

    Result := True;
  Except
    On E: Exception Do
    Begin
      pEnableCdsItens();
      fRollBack;
      pMensagensErro(E.Message, '[TfrmFatExpedicaoItens.fMarcaPedidoExpedido]');
      If (blnComitou) Then
        Result := True;
    End;
  End;

end;

function TfrmFatExpedicaoItens.fMarcaProdutoSemNecessidadeDeExpedicao: Boolean;
begin
  Result := ((fCfgSis('ETIDCE', varBoolean)) And (Pos(fCfgSis('TIPEXP'), '3_4_') > 0));
end;

function TfrmFatExpedicaoItens.fEscondeMensagensAberturaEFechamentoCaixa: Boolean;
begin
  Result := fCfgSis('FDEUMA', VarBoolean);
end;

procedure TfrmFatExpedicaoItens.pImprimeEntrega(fatVenda: TFatVenda);
Var
  intContador, intVia: Integer;
begin
  If (fCfgSis('CUPEET', varBoolean)) And
     (fCfgSis('USNFCE', varBoolean) Or fUsaSat) And
     (fatVenda.strEspDoc = 'IF') Then
  Begin
    If fPergunta('Deseja imprimir os dados da entrega?') Then
    Begin
      For intContador := 0 To fatVenda.objFatVendaImp.ItemsCount -1 Do
        For intVia := 1 To fCfgSis('QTDVEE', varInteger) Do
          pImprimirDadosEntregaNFCe(fatVenda.objFatVendaImp[intContador]);
    End;
  End;
end;

procedure TfrmFatExpedicaoItens.pImprimeEtiquetaDespacho(strNumDoc, strEspDoc, strCodCli: String; intQtdTra: Integer; strCodEmp: String; out AResultadoUnificacao: TResultadoEtiquetaUnificada;
  blnImpEtiDespachoVolumeComposto: Boolean = False; intQtdTraSepExc: Integer = 0; intQtdTraSepNaoExc: Integer = 0; strMultPed: String = ''; strSerie: String = '');
  Var
    frmImpEtiDespacho : TfrmImpEtiDespacho;
    intTentativas: Integer;
    blnImprimeEtiqueta: Boolean;
begin
  AResultadoUnificacao := reuNaoAplicavel;
  Try
    If Pos(strEspDoc, 'NF_EL_IF_IV_D1_MI_FF_TE_TR_BR_UC_PD_OR_') <= 0 Then
    begin
      Exit;
    end;

    blnImprimeEtiqueta := True;

    If (fCfgSis('ETISEF', varBoolean)) And (Pos(strEspDoc, 'NF_IF_') > 0) And (Not fEmptyStr(strSerie)) Then
    Begin
      blnImprimeEtiqueta := False;
      For intTentativas := 1 To 10 Do
      Begin
        Sleep(1000);

        If (not fEmptyStr(fRetChaveAcesso(strNumDoc, strEspDoc, strCodCli, strCodEmp))) And (fPainelNFeStatusDocumento(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie) = 'AT') Then
        Begin
          blnImprimeEtiqueta := True;
          Break;
        End;
      End;
    End;

    If (Not blnImprimeEtiqueta) Then
    Begin
      pMensagemOk('O documento ainda não foi autorizado, portanto a etiqueta de despacho não será impressa. [CFG_ETISEF]');
      Exit;
    End;

    pCriarFormularios(TfrmImpEtiDespacho, frmImpEtiDespacho);
    Try
      frmImpEtiDespacho.edtNumDoc.Text   := strNumDoc;
      frmImpEtiDespacho.edtEspDoc.Text   := strEspDoc;
      frmImpEtiDespacho.edtCodEmp.Text   := strCodEmp;
      frmImpEtiDespacho.edtCodCli.Text   := strCodCli;
      frmImpEtiDespacho.strCodCli        := strCodCli;
      frmImpEtiDespacho.strBotaoAcionado := FParams.strBotaoAcionado;

      If (intQtdTra = 0) And FParams.blnExpedicaoDocumentoFaturadoAutomaticamente Then
        intQtdTra := strToIntDef(frmImpEtiDespacho.fCarregaVolume, 1);

      frmImpEtiDespacho.edtQtdVol.Text := IntToStr(intQtdTra);
      frmImpEtiDespacho.blnImpEti      := True;
      frmImpEtiDespacho.blnExpedi      := True;
      frmImpEtiDespacho.strMultPed    := strMultPed;

      if blnImpEtiDespachoVolumeComposto then
        frmImpEtiDespacho.rdgTipoEtiq.ItemIndex := 2;

      frmImpEtiDespacho.fCarregaVolume; //Caso use Sigep precisa chamar essa funçao para carregar os dados do correio.

      If blnUtilizaSeparacaoExclusiva Then
      Begin
        frmImpEtiDespacho.edtQtdVolSepExc.Text  := IntToStr(intQtdTraSepExc);
        frmImpEtiDespacho.edtQtdVolSepNExc.Text := IntToStr(intQtdTraSepNaoExc);
      End;

      If FParams.blnExpedicaoDocumentoFaturadoAutomaticamente Then
      Begin
        If strToIntDef(frmImpEtiDespacho.edtQtdVol.Text, 0) = 0 Then
        Begin
          frmImpEtiDespacho.edtQtdVol.Text := '1';
          If blnUtilizaSeparacaoExclusiva Then
          Begin
            frmImpEtiDespacho.edtQtdVolSepExc.Text  := '0';
            frmImpEtiDespacho.edtQtdVolSepNExc.Text := '1';
          End;
        End;
      End;

      frmImpEtiDespacho.blnExibeTelaDigVolumesCompostos := not blnJaExibiuTelaDigVolumesCompostos;

      If (intQtdTra <= 0) Or (Not frmImpEtiDespacho.fValidarTodosCampos) Then
        frmImpEtiDespacho.ShowModal
      Else
        frmImpEtiDespacho.btnConfirma.Click;

      AResultadoUnificacao := frmImpEtiDespacho.tpeResultadoUnificacao;
    Finally
      pFreeAndNil(frmImpEtiDespacho);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[frmFatExpedicaoItens -> frmImpEtiDespacho]');
  End;
end;

function TfrmFatExpedicaoItens.fTemCaixaAberta: Boolean;
begin
  Result := Assigned(objMontarCaixas.CaixaAberta);
end;

function TfrmFatExpedicaoItens.fTemCaixasNaExpedicao: Boolean;
begin
  Result := (cximgCaixas.Properties.Items.Count > 0);
end;

function TfrmFatExpedicaoItens.fTemControleNumeroSerie(const strCodBar: string;
  var strCodIte: string): Boolean;
  Var
    qryNumeroSerie : TUniQuery;
    strSQL : string;
begin
  qryNumeroSerie := fCriaQuery(nil);
  try
    strCodIte  := EmptyStr;
    Result := False;

    strSQL := EmptyStr;
    strSQL := strSQL + 'SELECT B.BAR_CODITE, I.ITE_USASER ';
    strSQL := strSQL + 'FROM ITEBAR B ';
    strSQL := strSQL + 'INNER JOIN ITEGER I ';
    strSQL := strSQL + 'ON (B.BAR_CODITE = I.ITE_CODITE) ';
    strSQL := strSQL + 'WHERE B.BAR_CODBAR = :CODBAR ';
    strSQL := strSQL + 'AND I.ITE_CODEMP = :CODEMP ';

    qryNumeroSerie.Close;
    qryNumeroSerie.SQL.Clear;
    qryNumeroSerie.SQL.Add(strSQL);
    qryNumeroSerie.ParamByName('CODBAR').AsString := strCodBar;
    qryNumeroSerie.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryNumeroSerie.Open;

    if not qryNumeroSerie.IsEmpty then
    begin
      strCodIte := qryNumeroSerie.FieldByName('BAR_CODITE').AsString;
      Result := qryNumeroSerie.FieldByName('ITE_USASER').AsString = 'S';
    end
    else If (fCfgSis('NSERQT', varString) = 'S') And (Length(strCodBar) <= fTamCodIte) Then
    begin
      strCodIte := fStrZero(strCodBar, fTamCodIte);
      Result := fProdutoUsaNumeroDeSerie(strCodIte, VS_strCodEmp);
    end;
  finally
    FreeAndNil(qryNumeroSerie);
  end;
end;

function TfrmFatExpedicaoItens.fTemItensTintas: Boolean;
  Var
    cdsClone : TUniClientDataSet;
begin
  cdsClone := TUniClientDataSet.Create(Nil);
  pCloneDataSet(cdsClone, cdsItens);
  Try
    cdsClone.Filtered := False;
    cdsClone.Filter   := '(IDEPRO <> ' + QuotedStr('NOR') + ')';
    cdsClone.Filtered := True;
    cdsClone.First;
    Result := Not cdsClone.IsEmpty;
  Finally
    FreeAndNil(cdsClone);
  End;
End;

function TfrmFatExpedicaoItens.fTemItensExpedidos: Boolean;
  Var
    cdsClone : TUniClientDataSet;
begin
  cdsClone := TUniClientDataSet.Create(Nil);
  pCloneDataSet(cdsClone, cdsItens);
  Try
    cdsClone.Filtered := False;
    cdsClone.Filter   := '(QTDEXP > 0)';
    cdsClone.Filtered := True;
    cdsClone.First;
    Result := Not cdsClone.IsEmpty;
  Finally
    FreeAndNil(cdsClone);
  End;
end;

function TfrmFatExpedicaoItens.fTemItensRetira: Boolean;
  Var
    cdsClone : TUniClientDataSet;
begin
  cdsClone := TUniClientDataSet.Create(Nil);
  pCloneDataSet(cdsClone, cdsItens);
  Try
    cdsClone.Filtered := False;
    cdsClone.Filter   := '(RETENT = ' + QuotedStr('R') + ')';
    cdsClone.Filtered := True;
    cdsClone.First;
    Result := Not cdsClone.IsEmpty;
  Finally
    FreeAndNil(cdsClone);
  End;
end;

function TfrmFatExpedicaoItens.fTemSomenteItensRetira: Boolean;
  Var
    cdsClone : TUniClientDataSet;
begin
  cdsClone := fCriaClientDatSet(cdsItens);
  Try
    cdsClone.Filtered := False;
    cdsClone.Filter   := '(QTDEXP > 0) AND (RETENT = ' + QuotedStr('R') + ')';
    cdsClone.Filtered := True;
    cdsClone.First;
    Result := Not cdsClone.IsEmpty;

    If Result Then
    Begin
      cdsClone.Filtered := False;
      cdsClone.Filter   := '(QTDEXP > 0) AND (RETENT <> ' + QuotedStr('R') + ')';
      cdsClone.Filtered := True;
      cdsClone.First;
      Result := cdsClone.IsEmpty;
    End;
  Finally
    FreeAndNil(cdsClone);
  End;
end;

function TfrmFatExpedicaoItens.fTodosItensForamExpedidos: Boolean;
Var
  LRecNo: Integer;
begin
  If cdsItens.IsEmpty Then
    Exit(False);

  LRecNo := cdsItens.RecNo;
  cdsItens.DisableControls;
  Try
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      If fFormataFloat(fRetQtdPendenteItemPosicionado, 4) <> 0 Then
        Exit(False);
      cdsItens.Next;
    End;
  Finally
    cdsItens.RecNo := LRecNo;
    pEnableCdsItens();
  End;

  Result := True;
end;

function TfrmFatExpedicaoItens.fTemInconsistenciaVarValRecOuValAdt(out strMsgErr: String): Boolean;
  Var
    qryGen: TUniQuery;
    intContador: Integer;
    objPedido: TPedidoVenda;

    function fTemAdiantamento : Boolean;
    begin
      Result := IIF(fPermitirMarcarPedidosDeClientesDiferentesNaExpedicao, objPedido.strTemADT.Equals('S'), Self.FParams.blnTemAdt);
    end;

begin
  Result := False;
  strMsgErr := '';

  If (Not Assigned(FParams.stlPedidos)) Then
    Exit;

  If (FParams.stlPedidos.Count <= 0) Then
    Exit;

  qryGen := fCriaQuery(Nil);
  Try
    With qryGen Do
    Begin
      SQL.Text :=
           'SELECT '
         + ' (SELECT '
         + '    SUM(CTR_VALREC - IFNULL(CTR_VALJUR, 0) - IFNULL(CTR_VALCOB, 0) + IFNULL(CTR_VALDES, 0)) '
         + '  FROM '
         + '    CADREC '
         + '  WHERE '
         + '    CTR_NUMDUP = FGO_NUMDOC AND '
         + '    CTR_ESPDOC = FGO_ESPDOC AND '
         + '    CTR_CODEMP = FGO_CODEMP AND '
         + '    CTR_CODCLI = FGO_CODCLI AND '
         + '    CTR_DTAREC IS NOT NULL) AS VALREC, '

         + ' (SELECT '
         + '      SUM(IF(ADT_TIPLAN = "C", ADT_VALLAN, -ADT_VALLAN)) '
         + '  FROM '
         + '     ADTCLI '
         + '  WHERE '
         + '     ADT_NUMDOC = FGO_NUMDOC AND '
         + '     ADT_ESPDOC = FGO_ESPDOC AND '
         + '     ADT_CODEMP = FGO_CODEMP AND '
         + '     ADT_CODCLI = FGO_CODCLI) AS VALADT '

         + ' FROM FATGOR '
         + ' WHERE  '
         + '   FGO_NUMDOC = :NUMDOC AND '
         + '   FGO_ESPDOC = :ESPDOC AND '
         + '   FGO_CODEMP = :CODEMP AND '
         + '   FGO_CODCLI = :CODCLI ';

      For intContador := 0 To FParams.stlPedidos.Count -1 Do
      Begin
        objPedido  := TPedidoVenda(FParams.stlPedidos.Objects[intContador]);

        qryGen.Close;
        ParamByName('NUMDOC').AsString := objPedido.strNumDoc;
        ParamByName('ESPDOC').AsString := objPedido.strEspDoc;
        ParamByName('CODEMP').AsString := objPedido.strCodEmp;
        ParamByName('CODCLI').AsString := objPedido.strCodCli;
        qryGen.Open;

        If Not IsEmpty Then
        Begin
          If ((fFormataFloat(FieldByName('VALREC').AsFloat, 2) > 0) And (Not FParams.blnTemRec)) Then
          Begin
             Result := True;
             strMsgErr := 'DUPLICATAS RECEBIDAS DO PEDIDO'
          End
          Else If ((fFormataFloat(FieldByName('VALADT').AsFloat, 2) > 0) And (Not fTemAdiantamento)) Then
          Begin
            Result := True;
            strMsgErr := 'ADIANTAMENTO'
          End;
        End;

      End;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmFatExpedicaoItens.fTemPedidoComFrete: Boolean;
  Var
    qryGen: TUniQuery;
    intContador: Integer;
    objPedido: TPedidoVenda;
begin
  Result := False;

  If (Not Assigned(FParams.stlPedidos)) Then
    Exit;

  If (FParams.stlPedidos.Count <= 0) Then
    Exit;

  qryGen := fCriaQuery;
  Try
    With qryGen Do
    Begin
      SQL.Add(' SELECT COUNT(*) QTD FROM FATDOR WHERE ');

      For intContador := 0 To FParams.stlPedidos.Count -1 Do
      Begin
        objPedido  := TPedidoVenda(FParams.stlPedidos.Objects[intContador]);
        SQL.Add(' ( ');
        SQL.Add('  FDO_TOTFRE > 0 AND ');
        SQL.Add('  FDO_NUMDOC = ' + QuotedStr(objPedido.strNumDoc) + ' AND ');
        SQL.Add('  FDO_ESPDOC = ' + QuotedStr(objPedido.strEspDoc) + ' AND ');
        SQL.Add('  FDO_CODEMP = ' + QuotedStr(objPedido.strCodEmp) + ' AND ');
        SQL.Add('  FDO_CODCLI = ' + QuotedStr(objPedido.strCodCli));
        SQL.Add(' ) ');
        If intContador < FParams.stlPedidos.Count -1 Then
          SQL.Add(' OR ');
      End;
    End;
    qryGen.Open;
    Result := qryGen.FieldByName('QTD').AsInteger > 0;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmFatExpedicaoItens.fTemPedidoFaturadoParcialmente: Boolean;
  Var
    qryGen: TUniQuery;
    intContador: Integer;
    objPedido: TPedidoVenda;
begin
  Result := False;

  If (Not Assigned(FParams.stlPedidos)) Then
    Exit;

  If (FParams.stlPedidos.Count <= 0) Then
    Exit;

  qryGen := fCriaQuery;
  Try
    With qryGen Do
    Begin
      SQL.Add(' SELECT COUNT(*) QTD FROM FATDOR WHERE ');

      For intContador := 0 To FParams.stlPedidos.Count -1 Do
      Begin
        objPedido  := TPedidoVenda(FParams.stlPedidos.Objects[intContador]);
        SQL.Add(' ( ');
        SQL.Add('  (FDO_JAFATU = "1" OR FDO_QTDBAI > 0) AND ');
        SQL.Add('  FDO_NUMDOC = ' + QuotedStr(objPedido.strNumDoc) + ' AND ');
        SQL.Add('  FDO_ESPDOC = ' + QuotedStr(objPedido.strEspDoc) + ' AND ');
        SQL.Add('  FDO_CODEMP = ' + QuotedStr(objPedido.strCodEmp) + ' AND ');
        SQL.Add('  FDO_CODCLI = ' + QuotedStr(objPedido.strCodCli));
        SQL.Add(' ) ');
        If intContador < FParams.stlPedidos.Count -1 Then
          SQL.Add(' OR ');
      End;
    End;
    qryGen.Open;
    Result := qryGen.FieldByName('QTD').AsInteger > 0;
  Finally
    FreeAndNil(qryGen);
  End;
end;

Function TfrmFatExpedicaoItens.fTemQuantidadePendente(strNumDoc,
                                                      strEspDoc,
                                                      strCodEmp: String): Boolean;
  Var
    qryItens: TUniQuery;
Begin
  qryItens := fCriaQuery;
  Try
    With qryItens, SQL Do
    Begin
      Clear;
      Add('SELECT SUM(ROUND(IFNULL(FDO_QTDITE, 0), 2) - ROUND(IFNULL(FDO_QTDBAI, 0), 2)) AS QTDPEN ');
      Add('FROM ');
      Add('  FATDOR ');
      Add('WHERE ');
      Add('  FDO_NUMDOC = :NUMDOC AND ');
      Add('  FDO_ESPDOC = :ESPDOC AND ');
      Add('  FDO_CODEMP = :CODEMP     ');

      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;

      Open;

      Result := FieldByName('QTDPEN').AsFloat > 0;

      Close;
    End;
  Finally
    FreeAndNil(qryItens);
  End;
End;

procedure TfrmFatExpedicaoItens.pImprimePedidosQtdePendente;
Var
  intContador: Integer;
  objPedido  : TPedidoVenda;
  strGerPen  : String;
  strNomeArquivo: String;
begin

  Try

    For intContador := 0 To FParams.stlPedidos.Count -1 Do
    Begin
      objPedido := TPedidoVenda(FParams.stlPedidos.Objects[intContador]);

      {***************************************}
      {* RETORNA SE IRÁ IMPRIMIR A PENDENCIA *}
      {************************************PZ*}
      strGerPen := fRetGerarPendencia(objPedido.strNumDoc,
                                      objPedido.strEspDoc,
                                      objPedido.strCodEmp);

      If (strGerPen = 'S') And (Not fTemQuantidadePendente(objPedido.strNumDoc,
                                                           objPedido.strEspDoc,
                                                           objPedido.strCodEmp)) Then
        strGerPen := 'N';

      If (strGerPen = 'S') And (fCfgSis('IMPDPN', varBoolean)) Then
        pImprimeFatImp('FATDOR',
                       objPedido.strNumDoc,
                       objPedido.strEspDoc,
                       objPedido.strCodEmp,
                       objPedido.strCodCli,
                       'C',
                       'V',
                       True,
                       strNomeArquivo,
                       False,
                       'I',
                       1,
                       impComPrecoGeral,
                       0,
                       False,
                       False,
                       True,
                       False,
                       '',
                       '',
                       False,
                       True,
                       False,
                       False,
                       False,
                       False,
                       False,
                       opcTodos,
                       False,
                       False,
                       True,
                       False,
                       False,
                       '',
                       '',
                       Nil,
                       False,
                       '',
                       '',
                       '',
                       False,
                       opcNaoAgrupa,
                       False,
                       '',
                       '',
                       False,
                       False,
                       False,
                       '',
                       False,
                       False,
                       True);
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.message, '[TfrmFatExpedicaoItens.pImprimePedidosQtdePendente]');
  End;

end;

function TfrmFatExpedicaoItens.fExcedeLimiteItensNFe: Boolean;
  Var
    strEntRet, strEntFut: String;
    strInformacao: String;
    intQtdItens: Integer;
begin
  With TUniClientDataSet.Create(nil) Do
  Begin
    Data := cdsItens.Data;

    Filter := cdsItens.Filter;

    If Not fEmptyStr(Filter) Then
      Filter := Filter  + ' AND ';

    strEntRet := cdsItens.FieldByName('ENTRET').AsString;
    strEntFut := cdsItens.FieldByName('ENTFUT').AsString;

    Filter := Filter + 'QTDEXP > 0 AND ';
    Filter := Filter + 'ENTRET = ' + QuotedStr(strEntRet) + ' AND ';
    Filter := Filter + 'ENTFUT = ' + QuotedStr(strEntFut);

    Filtered := True;

    If cdsItens.FieldByName('QTDEXP').AsInteger > 0 Then
      intQtdItens := RecordCount
    Else
      intQtdItens := RecordCount + 1;

    If strEntRet = 'R' Then
      Result := TFatVenda.fUltrapassouLimiteItensNFe(intQtdItens, 'Retira', strInformacao)

    Else If strEntFut = 'N' Then
      Result := TFatVenda.fUltrapassouLimiteItensNFe(intQtdItens, 'Entrega Imediata', strInformacao)

    Else
      Result := TFatVenda.fUltrapassouLimiteItensNFe(intQtdItens, 'Entrega Futura', strInformacao);

    Destroy;
  End;

  If Result Then
    pMensagemSonora(strInformacao);
end;

function TfrmFatExpedicaoItens.fExisteCaixaAbertaEmMontagem: Boolean;
begin
  Result := False;
  If fUsaMontagemCaixas And Assigned(objMontarCaixas.CaixaAberta) Then
  Begin
    pMensagemOk('Existe uma caixa em aberto! ' + #13#10 +
                'Realize o fechamento da mesma antes de finalizar a expedição!');
    Result := True;
  End;
end;

function TfrmFatExpedicaoItens.fExisteNumeroSerie(strNumSer,
  strCodIte: string): Boolean;
var
  qryNumeroSerie: TUniQuery;
  strSQL: string;
begin
  qryNumeroSerie := fCriaQuery(nil);
  try
    strSQL := '';
    strSQL := strSQL + 'SELECT SER_NUMSER ';
    strSQL := strSQL + 'FROM PROSER ';
    strSQL := strSQL + 'WHERE SER_NUMSER = :NUMSER ';
    strSQL := strSQL + 'AND SER_CODITE = :CODITE ';
    strSQL := strSQL + 'AND SER_CODEMP = :CODEMP ';
    strSQL := strSQL + 'AND SER_NUMDOC IS NULL ';

    qryNumeroSerie.Close;
    qryNumeroSerie.SQL.Clear;
    qryNumeroSerie.SQL.Add(strSQL);
    qryNumeroSerie.ParamByName('NUMSER').AsString := strNumSer;
    qryNumeroSerie.ParamByName('CODITE').AsString := strCodIte;
    qryNumeroSerie.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryNumeroSerie.Open;

    Result := not qryNumeroSerie.IsEmpty;
  finally
    FreeAndNil(qryNumeroSerie);
  end;
end;

procedure TfrmFatExpedicaoItens.pOrdenarItens;
begin
  cdsItens.IndexFieldNames := 'AUTOINCREM';

  If (FParams.VS_strTipExpInterna = TIPEXP_POR_DOCUMENTO_DE_VENDA) Then
  Begin
    If FParams.blnOndaSeparacao Then
      cdsItens.IndexFieldNames := 'DESCRI;AUTOINCREM'
    Else
    Case strOrdDoc[1] Of
      '1': cdsItens.IndexFieldNames := 'DESCRI;AUTOINCREM';
      '2': cdsItens.IndexFieldNames := 'AUTOINCREM';
      '3': cdsItens.IndexFieldNames := 'UNIDAD;DESCRI;AUTOINCREM';
      '4': cdsItens.IndexFieldNames := 'DEP_DESCRI;DESCRI';
      '5': cdsItens.IndexFieldNames := 'LOCFIS;DESCRI;AUTOINCREM';
      '6': Begin
             cdsItens.IndexFieldNames := '';
             cdsItens.IndexDefs.Clear;
             With cdsItens.IndexDefs.AddIndexDef Do
             Begin
               Name       := 'IDX_ORDEM';
               Fields     := 'ENTRET;ENTFUT;DESCRI';
               DescFields := 'ENTRET';
             End;

             cdsItens.IndexName := 'IDX_ORDEM';
           End;
    End;
  End
  Else
  Begin
    If FParams.blnOndaSeparacao Then
      cdsItens.IndexFieldNames := 'FDO_DESCRI;PREVIS'
    Else
    Case strOrdExi[1] Of
      '1': cdsItens.IndexFieldNames := 'FDO_DESCRI;AUTOINCREM';
      '2': cdsItens.IndexFieldNames := 'UNIDAD;FDO_DESCRI;AUTOINCREM';
      '3': cdsItens.IndexFieldNames := 'ORDITE;AUTOINCREM';
      '4': cdsItens.IndexFieldNames := 'LOCFIS;FDO_DESCRI;AUTOINCREM';
      '5': cdsItens.IndexFieldNames := 'DEP_DESCRI;FDO_DESCRI';
      '6': Begin
             cdsItens.IndexFieldNames := '';
             cdsItens.IndexDefs.Clear;
             With cdsItens.IndexDefs.AddIndexDef Do
             Begin
               Name       := 'IDX_ORDEM';
               Fields     := 'ENTRET;ENTFUT;FDO_DESCRI';
               DescFields := 'ENTRET';
             End;

             cdsItens.IndexName := 'IDX_ORDEM';
           End;
    End;
  End;

end;

procedure TfrmFatExpedicaoItens.pOrdenarItensConfigurado;
var
  strAutIncSelecionado: String;
begin
  if Not fEmptyStr(strIndexField) Then
  begin
    strAutIncSelecionado := cdsItens.FieldByName('AUTOINCREM').AsString;

    cdsItens.IndexName := strIndexField;

    If (Not fEmptyStr(strAutIncSelecionado)) And
       (cdsItens.FieldByName('AUTOINCREM').AsString <> strAutIncSelecionado) Then
      cdsItens.Locate('AUTOINCREM', strAutIncSelecionado, []);
  end;
end;

procedure TfrmFatExpedicaoItens.pCarregaCaixas(blnNaoFaturados: Boolean = True);
  Var
    strFdoInc : String;
    qryFgoCai : TUniQuery;
    strUltCai : String;
    item      : TItemDaCaixa;
begin
  If cdsItens.isEmpty Then
    Exit;

  qryFgoCai := fCriaQuery;
  Try
    cdsItens.DisableControls;
    cdsItens.First;

    strFdoInc := '';
    While Not cdsItens.Eof Do
    Begin
      strFdoInc := strFdoInc + IIF(strFdoInc.IsEmpty,'',', ') + '"' + cdsItens.FieldByName('FDOINC').AsString + '"';

      cdsItens.Next;
    End;

    With qryItensSemCaixa, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT VW.*, ');
      Add('        IF(FGC_QUANTD=0,FDO_QTDITE,FDO_QTDITE-FGC_QUANTD) AS FDO_QTDVOL ');
      Add(' FROM (SELECT "" AS FGC_FGOINC, ');
      Add('       "" AS FGC_FDOINC, ');
      Add('       "" AS FGC_CAI_ID, ');
      Add('       "" AS FGC_CODBAR, ');
      Add('       IFNULL((SELECT SUM(IFNULL(FGC_QUANTD,0)) FROM FGOCAI WHERE FATDOR.AUTOINCREM = FGOCAI.FGC_FDOINC),0) AS FGC_QUANTD, ');
      Add('       FDO_QTDITE, ');
      Add('       FDO_CODITE, ');
      Add('       UNI_SIGUNI, ');
      Add('       FDO_NUMDOC, ');
      Add('       FDO_DESCRI, ');
      Add('       ITE_PESOIT, ');
      Add('       ITE_CODFAB ');
      Add('         FROM FATDOR ');
      Add('        INNER JOIN CADITE ON CADITE.ITE_CODITE = FDO_CODITE ');
      Add('         LEFT JOIN CADUNI ON CADUNI.UNI_CODUNI = ITE_CODUNI ');
      Add('        WHERE FATDOR.AUTOINCREM IN ( '+strFdoInc+' ) '+IIF(blnNaoFaturados,' AND FDO_JAFATU = 0 ',''));
      Add('      ) AS VW ');
      Add(' WHERE (FGC_QUANTD = 0) OR (FGC_QUANTD <> FDO_QTDITE) ');
    End;

    With qryFgoCai, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT FGC_FGOINC, ');
      Add('        FGC_FDOINC, ');
      Add('        FGC_CAI_ID, ');
      Add('        FGC_QUANTD, ');
      Add('        FDO_CODITE, ');
      Add('        UNI_SIGUNI, ');
      Add('        FDO_NUMDOC, ');
      Add('        FDO_DESCRI, ');
      Add('        ITE_PESOIT, ');
      Add('        ITE_CODFAB, ');
      Add('        FGC_CODBAR, ');
      Add('        FGC_CODMCX  ');
      Add(' FROM FGOCAI        ');
      Add(' INNER JOIN FATDOR ON FATDOR.AUTOINCREM = FGC_FDOINC ');
      Add(' INNER JOIN CADITE ON CADITE.ITE_CODITE = FDO_CODITE ');
      Add('  LEFT JOIN CADUNI ON CADUNI.UNI_CODUNI = ITE_CODUNI ');

      strWhereComItensFgoCai :=  ' WHERE FGC_FDOINC IN ( '+strFdoInc+' ) ';

      If (blnNaoFaturados) Then
        strWhereComItensFgoCai := strWhereComItensFgoCai + ' AND FGC_NUMFAT IS NULL ';

      Add(strWhereComItensFgoCai);
      Add(' ORDER BY FGC_CAI_ID ');

      Open;

      strUltCai := '';
      While Not Eof Do
      Begin
        If strUltCai <> FieldByName('FGC_CAI_ID').AsString Then
        Begin
          If objMontarCaixas.CaixaAberta <> Nil then
            objMontarCaixas.CaixaAberta.pFecharCaixa;
          objMontarCaixas.pNovaCaixa( FieldByName('FGC_CAI_ID').AsString, FieldByName('FGC_CODBAR').AsString );
        End;

        item.strID           := FieldByName('FGC_FDOINC').AsString;
        item.strPedido       := FieldByName('FDO_NUMDOC').AsString;
        item.strCodigo       := FieldByName('FDO_CODITE').AsString;
        item.strDescricao    := FieldByName('FDO_DESCRI').AsString;
        item.strSiglaUnidade := FieldByName('UNI_SIGUNI').AsString;
        item.fltQuantidade   := FieldByName('FGC_QUANTD').AsFloat;
        item.fltPeso         := FieldByName('ITE_PESOIT').AsFloat;
        item.strCodFab       := FieldByName('ITE_CODFAB').AsString;
        item.strFgoInc       := FieldByName('FGC_FGOINC').AsString;
        item.strCodMcx       := FieldByName('FGC_CODMCX').AsString;

        objMontarCaixas.CaixaAberta.pAdicionarItem(item);

        strUltCai := FieldByName('FGC_CAI_ID').AsString;

        Next;
      End;

      If objMontarCaixas.CaixaAberta <> Nil Then
        objMontarCaixas.CaixaAberta.pFecharCaixa;

      pPreencheListaCaixas;
      pPrencheGridItensCaixa;
      pSelecionaListaDimensaoCaixa;
    End;

  Finally
    pEnableCdsItens();
    FreeAndNil(qryFgoCai);
  End;

end;

class procedure TfrmFatExpedicaoItens.pReimprimeListaCaixas(objPedido : TPedidoVenda);
  var
    frmFatExpedicaoItens: TfrmFatExpedicaoItens;
begin
  If Not (fCfgSis('MONCAI', varBoolean) And (fCfgSis('IMPCAI', varString) = '2')) Then
    Exit;

  pCriarFormularios(TfrmFatExpedicaoItens, frmFatExpedicaoItens);
  Try
    With frmFatExpedicaoItens Do
    Begin
      If not fUsaMontagemCaixas Then
        Exit;

      FParams.stlPedidos := TStringList.Create;
      FParams.stlPedidos.AddObject(objPedido.strSeqGer, objPedido);
      pCarregaItensPedido(True);
      pCarregaCaixas(False);
      pImprimeListaCaixas(True);

    End;

  Finally
    FreeAndNil(frmFatExpedicaoItens.FParams.stlPedidos);
    pFreeAndNil(frmFatExpedicaoItens);
  End;

end;

procedure TfrmFatExpedicaoItens.pAtualizaPesoImpressaoDespachoMultiSelecao(
  strNumDoc, strEspDoc, strCodEmp, strCodCli: String; fltPesBru,
  fltPesLiq: Double);
var
  qryAtualizaPeso: TUniQuery;
begin
  qryAtualizaPeso := fCriaQuery;
  try
    qryAtualizaPeso.Close;
    qryAtualizaPeso.SQL.Clear;
    qryAtualizaPeso.SQL.Add('UPDATE MOVGER');
    qryAtualizaPeso.SQL.Add('SET GER_PESBRU = :PESBRU,');
    qryAtualizaPeso.SQL.Add('GER_PESLIQ = :PESLIQ');
    qryAtualizaPeso.SQL.Add('WHERE GER_NUMDOC = :NUMDOC');
    qryAtualizaPeso.SQL.Add('AND GER_ESPDOC = :ESPDOC');
    qryAtualizaPeso.SQL.Add('AND GER_CODEMP = :CODEMP');
    qryAtualizaPeso.SQL.Add('AND GER_CODCLI = :CODCLI');

    qryAtualizaPeso.ParamByName('PESBRU').AsFloat := fltPesBru;
    qryAtualizaPeso.ParamByName('PESLIQ').AsFloat := fltPesLiq;
    qryAtualizaPeso.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAtualizaPeso.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAtualizaPeso.ParamByName('CODEMP').AsString := strCodEmp;
    qryAtualizaPeso.ParamByName('CODCLI').AsString := strCodCli;

    qryAtualizaPeso.ExecSQL;
  finally
    FreeAndNil(qryAtualizaPeso);
  end;
end;

function TfrmFatExpedicaoItens.fCarregaConfiguracoesAKZNobel: Boolean;
Begin
  strAKZTraPed  := fCfgSis('AKZTRA');
  strAKZTabPre  := fCfgSis('AKZPRE');
  strAKZClaFis  := fCfgSis('AKZCFO');

  If (fEmptyStr(strAKZTraPed)) Then
  Begin
    fMensagem('ATENÇÃO', 'Favor preencher a transportadora para importação do arquivo!'+#13+
                         'CFG_AKZTRA Transportadora para pedido Akzo Nobel' , ['&OK']);
    Exit(False);
  End
  Else If (fEmptyStr(strAKZTabPre)) Then
  Begin
    fMensagem('ATENÇÃO', 'Favor preencher o preço para importação do arquivo!'+#13+
                         'CFG_AKZPRE Preço praticado nos pedidos Akzo Nobel' , ['&OK']);
    Exit(False);
  End
  Else If (fEmptyStr(strAKZClaFis)) Then
  Begin
    fMensagem('ATENÇÃO', 'Favor preencher a classificação fiscal para importação do arquivo!'+#13+
                         'CFG_AKZCFO Classificação Fiscal para emissão de documentos de venda Akzo Nobel' , ['&OK']);
    Exit(False);
  End;

  Result := True;

End;

function TfrmFatExpedicaoItens.fCarregaEstrutura(Item : TDadosFechamento;
                                                 blnBaixaSubItemEstrutura : Boolean) : Boolean;
Var
  objItensEstrutura             : TItensEstrutura;
  intSeqInclusaoEstrutura       : Integer;
  strCodItemEstrutura           : String;
  fltQuantidadeSubItemEstrutura : Double;
  fltUnitarioSubItemEstrutura   : Double;
  subItem                       : TSubItemEstrutura;
  intItem                       : Integer;
  qryItePai                     : TUniQuery;
  fltPrePai                     : Double;
  fltTaxJur                     : Double;
  fltUniVis                     : Double;
  DadosProduto                  : TDadosProduto;
Begin

  Result := False;

  strCodItemEstrutura     := Item.strCodIte;
  intSeqInclusaoEstrutura := fRetornaSequencialUnico('SINCPD');

  Try
    objItensEstrutura := TItensEstrutura.Create;
    qryItePai := fCriaQuery(Nil);

    If fatVenCCR.fCalculaPrecoEstrutura(False,
                                        Preco_de_Venda,
                                        strCodItemEstrutura,
                                        VS_strCodEmp,
                                        'S',
                                        fatVenCCR.strTabPre,
                                        fatVenCCR.fltMargem,
                                        Item.fltQtdIte,
                                        objItensEstrutura ) > 0 Then
    Begin

      With qryItePai Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP');
        ParamByName('CODITE').AsString := strCodItemEstrutura;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        Open;
      End;

      fltPrePai := fatVenCCR.fPegaPrecoVenda(qryItePai, VS_strCodEmp,
                                            'S',
                                             0,
                                             False,
                                             'NOR',
                                             fatVenCCR.strTabPre,
                                             True,
                                             fltTaxJur,
                                             fltUniVis);

      If fltPrePai > 0 Then
        objItensEstrutura.pAcertarPrecos(fltPrePai);

      For intItem := 0 To objItensEstrutura.ItemsCount -1 Do
      Begin

        subItem := objItensEstrutura[intItem];

        //Carrega o preco de venda do item estrutura para utilizar na trava de preco
        fltQuantidadeSubItemEstrutura := subItem.fltQtdTot / objItensEstrutura.fltQuantidadeItemEstrutura;
        fltUnitarioSubItemEstrutura   := subItem.fltPreVen;

        DadosProduto.strCodIte := subItem.strCodigo;
        DadosProduto.fltQtdIte := fltQuantidadeSubItemEstrutura;
        DadosProduto.strEntRet := Item.strEntRet;
        DadosProduto.fltUnitar := fltUnitarioSubItemEstrutura;
        DadosProduto.fltUniOri := fltUnitarioSubItemEstrutura;
        DadosProduto.strPromoc := Item.strPromoc;
        DadosProduto.fltDesCnd := Item.fltDesCnd;
        DadosProduto.blnBaixaSubItemEstrutura := blnBaixaSubItemEstrutura;
        DadosProduto.intSeqInclusaoEstrutura  := intSeqInclusaoEstrutura;
        DadosProduto.strNumOrc := Item.strNumOrc;
        DadosProduto.strEspOrc := Item.strEspOrc;
        DadosProduto.strEmpOrc := Item.strEmpOrc;

        Result := fInserirProduto(DadosProduto, fatVenCCR);

        If Not Result Then
          Break;

      End;

      {Na nota de simples remessa não tem
       taxa de bombeamento!}
      fatVenCCR.fltTotBom := 0.0;
      fatVenCCR.fltPrcBom := 0.0;
      fatVenCCR.fltQtdBom := 0.0;

    End;

  Finally
    FreeAndNil(objItensEstrutura);
    FreeAndNil(qryItePai);
  End;

  If Not Result Then
    fMensagem('ATENÇÃO!', 'A ESTRUTURA NÃO FOI CARREGADA TOTALMENTE!', ['&Ok']);

End;

function TfrmFatExpedicaoItens.fAlterarTransportadora(fatVenda: TFatVenda) : Boolean;
begin

  Result := False;

  If Not fCfgSis('FREEXP', varBoolean) Then
    Exit;

  If Not MatchStr(fCfgSis('TIPEXP'), [TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO, TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO]) Then
    Exit;

  If Not (fatVenda.strTipPed <> 'A') Then
    Exit;

  Result := True;

end;

function TfrmFatExpedicaoItens.fValidaPesoCaixa:Boolean;
Var
  caixa: TCaixa;
  fltPesoCaixa,
  fltPesoBalanca,
  fltTara,
  fltTolerancia,
  fltPesoInicial,
  fltPesoFinal: Double;
begin
  Result         := True;

  If (Not fCfgSis('PESOBR', varBoolean)) Then
    Exit;

  If (cximgCaixas.ItemIndex = -1) Then
    Exit;

  caixa := objMontarCaixas.fBuscaCaixa(cximgCaixas.Properties.Items[cximgCaixas.ItemIndex].Value);

  fltTara        := fCfgSis('PESTAR', varDouble);
  fltTolerancia  := fCfgSis('PESPER', varDouble);

  fltPesoCaixa   := objMontarCaixas.fPesoProdCaixa(caixa);
  fltPesoInicial := fltPesoCaixa - ((fltTolerancia * (fltPesoCaixa + fltTara)) / 100);
  fltPesoFinal   := fltPesoCaixa + ((fltTolerancia * (fltPesoCaixa + fltTara)) / 100);

  fltPesoBalanca := objMontarCaixas.fPesoCaixa(False);

  If (fltPesoBalanca = 0) Then
  Begin
    Result := False;
    pMensagemOk('Não foi possível pesar a caixa. Verifique!');
  End;

  if Result And ((fltPesoBalanca < fltPesoInicial) or (fltPesoBalanca > fltPesoFinal)) Then
  Begin
    Result := False;

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Existe divergência de peso entre os itens da caixa e a balança.');

    objLiberacao.strDirAce := 'PESEXD';
    objLiberacao.strMsgSen := 'Existe divergência de peso entre os itens da caixa e a balança.';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    If objLiberacao.fLibera Then
      Result := True;
  End;
end;

function TfrmFatExpedicaoItens.fValidaSituacaoFinanceiraPedidosSelecionados: Boolean;
Var
  strPenFin : String;
  intIndex  : Integer;

begin
  Result := True;

  For intIndex := 0 To Pred(FParams.stlPedidos.Count) Do
  Begin
    If Not fValidaSituacaoFinanceiraPedido(TPedidoVenda(FParams.stlPedidos.Objects[intIndex]).strNumDoc,
                                           TPedidoVenda(FParams.stlPedidos.Objects[intIndex]).strEspDoc,
                                           TPedidoVenda(FParams.stlPedidos.Objects[intIndex]).strCodEmp,
                                           strPenFin) Then
    Begin
      Exit(False);
    End;
  End;
end;

function TfrmFatExpedicaoItens.fValidaVolume(blnShowMsg : Boolean = True):Boolean;
begin
  Result := True;

  If (Not chkImpSeq.Checked) Then
    Exit;

  If (StrToIntDef(edtVolume.Text, 0) <= 0) Then
  Begin
    If (blnShowMsg) Then
      fMensagem('ATENÇÃO!', 'Volume é obrigatório maior que 0 (zero)!', ['&O k']);

    pSetFocus(edtVolume);
    Result := False;
  End;
end;

function TfrmFatExpedicaoItens.fVerificaConPagMaiorPrazo(const fltTotGer: Double; var strCodCnd, strConPag, strCodFpg: String): Boolean;
var
  qryAux: TUniQuery;
  intRecNoMaior: Integer;
  intContador: Integer;
  intMaior: Integer;
  objPedido: TPedidoVenda;
  fltValorParcela: Double;

  strCndPag: String;
  strMaiorCndPag : String;
begin
  Result := False;
  intRecNoMaior := 0;
  strMaiorCndPag := '';

  qryAux := fCriaQuery;
  try
    qryAux.SQL.Add('SELECT FGO_CONPAG, FGO_CODCND, FGO_CODFPG, CND_PARMIN');
    qryAux.SQL.Add('FROM FATGOR');
    qryAux.SQL.Add('LEFT JOIN CADCND ON CND_CODIGO = FGO_CODCND');
    qryAux.SQL.Add('WHERE TRUE');
    qryAux.SQL.Add(' AND ');
    qryAux.SQL.Add('  (');
    For intContador := 0 To FParams.stlPedidos.Count -1 Do
    Begin
      objPedido  := TPedidoVenda(FParams.stlPedidos.Objects[intContador]);

      qryAux.SQL.Add(' (FGO_NUMDOC = ' + QuotedStr(objPedido.strNumDoc) + ' AND ');
      qryAux.SQL.Add('  FGO_ESPDOC = ' + QuotedStr(objPedido.strEspDoc) + ' AND ');
      qryAux.SQL.Add('  FGO_CODEMP = ' + QuotedStr(objPedido.strCodEmp) + ')    ');

      If intContador < FParams.stlPedidos.Count -1 Then
        qryAux.SQL.Add(' OR ');
    End;
    qryAux.SQL.Add('  )');

    qryAux.Open;
    while not qryAux.Eof do
    begin
      strCndPag := qryAux.FieldByName('FGO_CONPAG').AsString;

      If fEmptyStr(strMaiorCndPag) Then
      Begin
        strMaiorCndPag := strCndPag;
        intRecNoMaior := qryAux.RecNo;
      End;

      if TValidaCondicaoPagamento.fValidaConPagMaiorPrazo(strMaiorCndPag, strCndPag) then
      begin
        strMaiorCndPag := strCndPag;
        intRecNoMaior := qryAux.RecNo;
      end;

      qryAux.Next;
    end;

    qryAux.RecNo := intRecNoMaior;

    intMaior := StrToInt(Copy(strMaiorCndPag, 1, 2));

    fltValorParcela := fltTotGer / intMaior;
    if fltValorParcela > qryAux.FieldByName('CND_PARMIN').AsFloat then
    begin
      Result := True;
      strCodCnd := qryAux.FieldByName('FGO_CODCND').AsString;
      strConPag := qryAux.FieldByName('FGO_CONPAG').AsString;
      strCodFpg := qryAux.FieldByName('FGO_CODFPG').AsString;
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

function TfrmFatExpedicaoItens.fValidarNumeroSerieProdutos: Boolean;
begin
  Result := True;

  If Not btnNumSeries.Visible Then
    Exit;

  If Not blnValidaNumeroSerie Then
    Exit;

  If fValidaQuantSerieItens Then
    Exit;

  Result := False;
  pMensagemOk('A quantidade total das séries está divergente da quantidade do item "'+ cdsItens.FieldByName('DESITE').AsString +'".'+
    sLineBreak + '-Quantidade informada: '+ FloatToStrF(objFatSerieItem.fGetTotQuant, ffFixed, 12, intDecQtd) +
    sLineBreak + '-Quantidade do Pedido: '+ FloatToStrF(cdsItens.FieldByName('QTDTOT').AsFloat, ffFixed, 12, intDecQtd) +
    sLineBreak + 'Utilize o botão "[Ctrl+F3] Núm. Séries" para corrigir.');
end;

function TfrmFatExpedicaoItens.fVerificaOSItemReserv: Boolean;
var
  strNumOse: String;
  stlItensOS: TStringList;
begin
  Result := False;

  if fEmptyStr(edtCodIte.Text) then
    Exit;

  if (edtCodIte.Text <> cdsItens.FieldByName('CODITE').AsString) then
  begin
    if not cdsItens.Locate('CODITE', edtCodIte.Text, []) then
      Exit;
  end;

  stlItensOS := TStringList.Create;
  try
    if (fOSItensNaoReservados(cdsItens.FieldByName('NUMDOC').AsString,
                              cdsItens.FieldByName('ESPDOC').AsString,
                              cdsItens.FieldByName('CODEMP').AsString,
                              cdsItens.FieldByName('CODITE').AsString,
                              strNumOse, stlItensOS)) then
    begin
      Result := True;
      edtCodIte.Clear;
      fMensagem('Atenção', 'Não é permitido faturar/expedir o item ' + cdsItens.FieldByName('CODITE').AsString + '-' + cdsItens.FieldByName('DESITE').AsString +
                      ' do pedido ' + cdsItens.FieldByName('NUMDOC').AsString + '-' + cdsItens.FieldByName('ESPDOC').AsString + '-' + cdsItens.FieldByName('CODEMP').AsString +
                      ' pois ele não está reservando estoque. OS: ' + strNumOse + '. Acesse a rotina "Liberação de Reserva de Estoque Itens de Pedido de Venda - OS",'+
                      ' realize a liberação da reserva do estoque e depois, tente novamente.', ['&Ok']);
    end;
  finally
    FreeAndNil(stlItensOS);
  end;
end;

procedure TfrmFatExpedicaoItens.imgFotoEstruDblClick(Sender: TObject);
begin
  inherited;
  pAmpliaFoto(cdsDetMat.FieldByName('ITESUB').AsString);
end;

procedure TfrmFatExpedicaoItens.imgFotoProdDblClick(Sender: TObject);
begin
  inherited;
  pAmpliaFoto(cdsItens.FieldByName('CODITE').AsString);
end;

procedure TfrmFatExpedicaoItens.pBaixaBoxWMS;
  Var
    intIndex : Integer;
    qryQuery : TUniQuery;
Begin
  qryQuery := fCriaQuery;
  Try
    With qryQuery, SQL Do
    Begin
      Close;
      Clear;
      Add(' UPDATE CADBOX SET BOX_NUMDOC = NULL, ');
      Add('                   BOX_ESPDOC = NULL, ');
      Add('                   BOX_EMPDOC = NULL  ');
      Add(' WHERE BOX_NUMDOC = :NUMDOC           ');
      Add('   AND BOX_ESPDOC = :ESPDOC           ');
      Add('   AND BOX_EMPDOC = :EMPDOC           ');

    End;

    For intIndex := 0 To FParams.stlPedidos.Count - 1 Do
    Begin

      qryQuery.ParamByName('NUMDOC').AsString := TPedidoVenda(FParams.stlPedidos.Objects[intIndex]).strNumDoc;
      qryQuery.ParamByName('ESPDOC').AsString := TPedidoVenda(FParams.stlPedidos.Objects[intIndex]).strEspDoc;
      qryQuery.ParamByName('EMPDOC').AsString := TPedidoVenda(FParams.stlPedidos.Objects[intIndex]).strCodEmp;
      qryQuery.ExecSQL;

    End;
  Finally
    FreeAndNil(qryQuery);
  End;
End;

procedure TfrmFatExpedicaoItens.pTocarAlertaSonoro(blnAchou: Boolean);
  Var
    strCfgSom,
    strEmbUn : String;
begin
  strEmbUn := fCodBarEmbUn;

  If (Not blnAchou) Or (fEmptyStr(strEmbUn)) Then
    strCfgSom := 'ALBINE'

  Else If blnInsParcial Then
  Begin
    If strEmbUn = 'UN' Then
      strCfgSom := 'ALBPUN'

    Else If strEmbUn = 'EMB' Then
      strCfgSom := 'ALBPEM'

    Else
      Exit;
  End
  Else
    strCfgSom := 'ALBSCO';

  pMensagemSonora('', strCfgSom);
end;

procedure TfrmFatExpedicaoItens.pUtilizaNumeroSerie(strNumDoc, strNumSer,
  strCodIte: string);
var
  qryNumeroSerie: TUniQuery;
  strSQL: string;
begin
  qryNumeroSerie := fCriaQuery(nil);
  try
    strSQL := '';
    strSQL := strSQL + 'UPDATE PROSER ';
    strSQL := strSQL + 'SET SER_NUMDOC = :NUMDOC ';
    strSQL := strSQL + 'WHERE SER_CODITE = :CODITE ';
    strSQL := strSQL + 'AND SER_NUMSER = :NUMSER ';
    strSQL := strSQL + 'AND SER_CODEMP = :CODEMP ';

    qryNumeroSerie.Close;
    qryNumeroSerie.SQL.Clear;
    qryNumeroSerie.SQL.Add(strSQL);
    qryNumeroSerie.ParamByName('NUMDOC').AsString := strNumDoc;
    qryNumeroSerie.ParamByName('CODITE').AsString := strCodIte;
    qryNumeroSerie.ParamByName('NUMSER').AsString := strNumSer;
    qryNumeroSerie.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryNumeroSerie.ExecSQL;
  finally
    FreeAndNil(qryNumeroSerie);
  end;
end;

procedure TfrmFatExpedicaoItens.pVerificarPromocaoBrindes(strNumDoc, strEspDoc, strCodCli, strNomCli: String);
var
  dtaMin, dtaMax: TDateTime;
  blnPedeBrindes,
  blnApenasPromoVigente: Boolean;
  frmFatPromocaoBrindes : TfrmFatPromocaoBrindes;
begin
  blnApenasPromoVigente := (not fCfgSis('PEBRFA', varBoolean));

  If (TPromocaoBrindes.fTemPromocaoDeBrindeEmVigencia) And
     (TFatEmitirBrindePromocao.fClienteTemPontosParaBrindes(
      strCodCli, strNumDoc, strEspDoc, dtaMin, dtaMax, blnApenasPromoVigente)) Then
  Begin
    If fEmptyStr(strNumDoc) Then
      blnPedeBrindes := fPergunta('Cliente possui direito a brinde por pontos acumulados ' +
                                  'por produto vendido. ' +
                                  'Deseja emitir o documento de brinde?')
    Else
      blnPedeBrindes := fPergunta('Cliente possui direito a brinde por pontos acumulados ' +
                                  'por produto vendido (' + strNumDoc + '-' + strEspDoc + '). ' +
                                  'Deseja emitir o documento de brinde?');

    If blnPedeBrindes Then
    Begin
      pCriarFormularios(TfrmFatPromocaoBrindes, frmFatPromocaoBrindes);
      Try
        Try
          frmFatPromocaoBrindes.strOperador    := strLoginUsuarioLogado;
          frmFatPromocaoBrindes.edtCodCli.Text := strCodCli;
          frmFatPromocaoBrindes.edtNomCli.Text := strNomCli;
          frmFatPromocaoBrindes.edtNumDoc.Text := strNumDoc;
          frmFatPromocaoBrindes.edtEspDoc.Text := strEspDoc;
          frmFatPromocaoBrindes.mskDtaIni.Text := DateToStr(dtaMin);
          frmFatPromocaoBrindes.mskDtaFin.Text := DateToStr(dtaMax);
          frmFatPromocaoBrindes.edtCodEmp.Text := VS_strCodEmp;
          frmFatPromocaoBrindes.edtDesEmp.Text := fRetNomeEmpresa;
          frmFatPromocaoBrindes.blnFatVenda    := True;
          frmFatPromocaoBrindes.ShowModal;
        Except
          On E: Exception Do
            pMensagensErro(E.Message, '');
        End;
      Finally
        pFreeAndNil(frmFatPromocaoBrindes);
      End;
    End;
  End;
end;

procedure TfrmFatExpedicaoItens.pVinculaPedidosComMesmoClienteExpedidosJuntos(
  stlPedidos: TStringList);
var
  qryVincula: TUniQuery;
  objPed: TPedidoVenda;
  intPed: integer;
  strNumDoc: String;
  strEspDoc: String;
  strCodEmp: String;
  strCodCli: String;
  strCodigo: String;
begin
  if not fCfgSis('ETIUNI', varBoolean) then
    Exit;

  if VS_strTipExp <> '4' then
    Exit;

  if stlPedidos.Count <= 1 then
    Exit;

  objPed := TPedidoVenda(stlPedidos.Objects[0]);
  strNumDoc := EmptyStr;
  strEspDoc := objPed.strEspDoc;
  strCodEmp := objPed.strCodEmp;
  strCodCli := objPed.strCodCli;

  for intPed := 0 To stlPedidos.Count - 1 do
  begin
    objPed := TPedidoVenda(stlPedidos.Objects[intPed]);

    if strCodCli <> objPed.strCodCli then
      Exit;

    pIncrementaListaStr(objPed.strNumDoc, strNumDoc, True);
  end;

  qryVincula := fCriaQuery;

  try
    strCodigo := fStrZero(fRetSequencial('PROSMP', VS_strCodEmp, 10), 10);
    qryVincula.Close;
    qryVincula.SQL.Clear;
    qryVincula.SQL.Add('UPDATE EXTGOR E');
    qryVincula.SQL.Add('INNER JOIN FATGOR F');
    qryVincula.SQL.Add('ON(E.FGO_SEQFGO = F.AUTOINCREM)');
    qryVincula.SQL.Add('SET E.FGO_MULPED = :MULPED');
    qryVincula.SQL.Add('WHERE F.FGO_CODCLI = :CODCLI');
    qryVincula.SQL.Add('AND F.FGO_CODEMP = :CODEMP');
    qryVincula.SQL.Add('AND F.FGO_ESPDOC = :ESPDOC');
    qryVincula.SQL.Add('AND F.FGO_NUMDOC IN('+strNumDoc+')');

    qryVincula.ParamByName('MULPED').AsString := strCodigo;
    qryVincula.ParamByName('CODCLI').AsString := strCodCli;
    qryVincula.ParamByName('CODEMP').AsString := strCodEmp;
    qryVincula.ParamByName('ESPDOC').AsString := strEspDoc;

    qryVincula.ExecSQL;
  finally
    FreeAndNil(qryVincula);
  end;
end;
procedure TfrmFatExpedicaoItens.pZeraPesoExpedido;
var
  intIndice: integer;
begin
  if (not fCfgSis('PESEXP', varBoolean)) then
    Exit;

  for intIndice := 0 to Length(arrJaExpedidoList) - 1 do
  begin
    arrJaExpedidoList[intIndice].fltQtdExp := 0;
  end;

  for intIndice := 0 to Length(arrTotaisPeso) - 1 do
  begin
    arrTotaisPeso[intIndice].fltPesBru := 0;
    arrTotaisPeso[intIndice].fltPesLiq := 0;
  end;
end;

function TfrmFatExpedicaoItens.fCodBarEmbUn: String;
  Var
    qryCodBarIte: TUniQuery;
Begin
  qryCodBarIte := fCriaQuery(Self);
  Try
    With qryCodBarIte, SQL Do
    Begin
      Clear;
      Add(' SELECT ITE_CODBAR, ITE_BAREMB, ITE_CODITE ');
      Add('   FROM CADITE ');
      Add('  WHERE (ITE_CODBAR = :CODBAR) ');
      Add('     OR (ITE_BAREMB = :CODBAR) ');
      Add('     OR (ITE_CODITE = :CODBAR) ');
      ParamByName('CODBAR').AsString := strCodDig;
      Open;

      If (FieldByName('ITE_CODBAR').AsString = strCodDig) Or
         (FieldByName('ITE_CODITE').AsString = strCodDig) Then
        Result := 'UN'
      Else If FieldByName('ITE_BAREMB').AsString = strCodDig Then
        Result := 'EMB'
      Else If fCodigoDeBarrasToCodIte(strCodDig) <> '' Then
        Result := 'EMB'
      Else
        Result := '';

      Close;
    End;
  Finally
    FreeAndNil(qryCodBarIte);
  End;
end;

function TfrmFatExpedicaoItens.fImpEtiquetaSepErrada(strCodIte, strNomSep: String):Boolean;
Var prmDllEtq: TParamDllEtiquetas;
    qryEtique: TUniQuery;
Begin
  qryEtique := fCriaQuery(Self);
  Try
    Result := False;

    If Length(strCodIte) > fTamCodIte Then
      strCodIte := fCampoTabela('ITE_CODITE', 'CADITE', ['ITE_CODBAR'], [strCodIte]);

    With qryEtique, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT                                              ');
      Add('  A.ITE_CODITE AS CODITE,                           ');
      Add('  A.ITE_REFERE AS REFERE,                           ');
      Add('  A.ITE_DESITE AS DESITE,                           ');
      Add('  C.MAR_DESMAR AS DESMAR,                           ');
      Add('  B.ITE_LOCFIS AS LOCFIS,                           ');
      Add('  :NOMSEP      AS NOMSEP                            ');
      Add('FROM CADITE A                                       ');
      Add('INNER JOIN ITEGER B ON B.ITE_CODITE = A.ITE_CODITE  ');
      Add('LEFT  JOIN CADMAR C ON C.MAR_CODMAR = A.ITE_CODMAR  ');
      Add('WHERE B.ITE_CODEMP = :CODEMP                        ');
      Add('  AND A.ITE_CODITE = :CODITE                        ');

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('NOMSEP').AsString := strNomSep;

      Open;
    End;

    Result := (not qryEtique.IsEmpty);

    If Result Then
    Begin
      prmDllEtq := TParamDllEtiquetas.Create;
      Try
        prmDllEtq.tpeTipEtq := tpeSepErrLaser;
        prmDllEtq.dtsImpres := qryEtique;
        fImprimeEtiqueta(prmDllEtq, 'fimprimeetiquetas');
      Finally
        FreeAndNil(prmDllEtq);
      End;
    End;

  Finally
    FreeAndNil(qryEtique);
  End;

End;

function TfrmFatExpedicaoItens.fImpEtiqCodBarrasProduto(cdsItens: TUniClientDataSet;
  intQtdEti: Integer = 1): Boolean;
  Var
    prmDllEtq: TParamDllEtiquetas;
Begin
  Result := (not cdsItens.IsEmpty);

  If Result Then
  Begin
    prmDllEtq := TParamDllEtiquetas.Create;
    Try
      prmDllEtq.tpeTipEtq := tpeCodBarrasProduto;
      prmDllEtq.dtsImpres := cdsItens;
      prmDllEtq.intQtdEti := intQtdEti;
      fImprimeEtiqueta(prmDllEtq, 'fimprimeetiquetas');
    Finally
      FreeAndNil(prmDllEtq);
    End;
  End;

End;

procedure TfrmFatExpedicaoItens.pGeraLogSepErrada(strNumDoc, strEspDoc, strCodEmp, strCodOpe, strCodSep: String;
                                                  dtaDtaCad: TDateTime; horHorCad: TTime; strCodIte: String;
                                                  fltQtdBip, fltQtdPed: Double);
Var qryLog: TUniQuery;
Begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  qryLog := fCriaQuery;
  Try
    With qryLog Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' INSERT INTO LOGSPE ');
      SQL.Add('   (LOG_NUMDOC,     ');
      SQL.Add('    LOG_ESPDOC,     ');
      SQL.Add('    LOG_CODEMP,     ');
      SQL.Add('    LOG_CODOPE,     ');
      SQL.Add('    LOG_CODSEP,     ');
      SQL.Add('    LOG_DTACAD,     ');
      SQL.Add('    LOG_HRACAD,     ');
      SQL.Add('    LOG_CODITE,     ');
      SQL.Add('    LOG_QTDBIP,     ');
      SQL.Add('    LOG_QTDPED)     ');
      SQL.Add(' VALUES             ');
      SQL.Add('   (:NUMDOC,        ');
      SQL.Add('    :ESPDOC,        ');
      SQL.Add('    :CODEMP,        ');
      SQL.Add('    :CODOPE,        ');
      SQL.Add('    :CODSEP,        ');
      SQL.Add('    :DTACAD,        ');
      SQL.Add('    :HRACAD,        ');
      SQL.Add('    :CODITE,        ');
      SQL.Add('    :QTDBIP,        ');
      SQL.Add('    :QTDPED)        ');

      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODOPE').AsString := strCodOpe;
      ParamByName('CODSEP').AsString := strCodSep;
      ParamByName('DTACAD').AsDate   := dtaDtaCad;
      ParamByName('HRACAD').AsTime   := horHorCad;
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('QTDBIP').AsFloat  := fltQtdBip;
      ParamByName('QTDPED').AsFloat  := fltQtdPed;

      ExecSQL;
      Close;
    End;
  Finally
    FreeAndNil(qryLog);
  End;
End;

procedure TfrmFatExpedicaoItens.pGravaControleLALAMOVE(strNumDoc, strEspDoc, strCodEmp, strCodCli: String);
var
  qryDocumento: TUniQuery;
  qryLalaMove: TUniQuery;
begin
  if not fCfgSis('USALAL', varBoolean) then
    Exit;

  if fEmptyStr(cdsItens.FieldByName('COTLAL').AsString) then
    Exit;

  qryDocumento := fCriaQuery;
  qryLalaMove := fCriaQuery;

  try
    qryDocumento.Close;
    qryDocumento.SQL.Clear;
    qryDocumento.SQL.Add('SELECT M.AUTOINCREM, F.FGO_NUMDOC, F.FGO_ESPDOC, F.FGO_CODEMP, E.FGO_COTLAL, M.GER_TIP_FC, M.GER_ORIDOC');
    qryDocumento.SQL.Add('FROM MOVGER M');
    qryDocumento.SQL.Add('INNER JOIN FATGOR F');
    qryDocumento.SQL.Add('ON(M.GER_NUMDOC = F.FGO_NUMFAT AND M.GER_ESPDOC = F.FGO_TIPFAT AND M.GER_CODEMP = F.FGO_EMPFAT)');
    qryDocumento.SQL.Add('INNER JOIN EXTGOR E');
    qryDocumento.SQL.Add('ON(F.AUTOINCREM = E.FGO_SEQFGO)');
    qryDocumento.SQL.Add('WHERE M.GER_NUMDOC = :NUMDOC');
    qryDocumento.SQL.Add('AND M.GER_ESPDOC = :ESPDOC');
    qryDocumento.SQL.Add('AND M.GER_CODEMP = :CODEMP');
    qryDocumento.SQL.Add('AND M.GER_CODCLI = :CODCLI');

    qryDocumento.ParamByName('NUMDOC').AsString := strNumDoc;
    qryDocumento.ParamByName('ESPDOC').AsString := strEspDoc;
    qryDocumento.ParamByName('CODEMP').AsString := strCodEmp;
    qryDocumento.ParamByName('CODCLI').AsString := strCodCli;

    qryDocumento.Open;

    if qryDocumento.IsEmpty then
      Exit;

    qryLalaMove.Close;
    qryLalaMove.SQL.Clear;
    qryLalaMove.SQL.Add('INSERT INTO MOVLAL(AUTOINCREM, LAL_SEQGER, LAL_NUMDOC, LAL_ESPDOC, LAL_CODEMP, LAL_CODCLI, LAL_TIP_FC, ');
    qryLalaMove.SQL.Add('                   LAL_ORIDOC, LAL_NUMPED, LAL_ESPPED, LAL_EMPPED, LAL_ID_COT, LAL_SITUAC)');
    qryLalaMove.SQL.Add('VALUES(:AUTINC, :SEQGER, :NUMDOC, :ESPDOC, :CODEMP, :CODCLI, :TIP_FC, ');
    qryLalaMove.SQL.Add('       :ORIDOC, :NUMPED, :ESPPED, :EMPPED, :ID_COT, :SITUAC)');

    while not qryDocumento.Eof do
    begin
      qryLalaMove.Close;
      qryLalaMove.ParamByName('AUTINC').AsString := fRetAutoIncrem('MOVLAL', VS_strCodEmp);
      qryLalaMove.ParamByName('SEQGER').AsString := qryDocumento.FieldByName('AUTOINCREM').AsString;
      qryLalaMove.ParamByName('NUMDOC').AsString := strNumDoc;
      qryLalaMove.ParamByName('ESPDOC').AsString := strEspDoc;
      qryLalaMove.ParamByName('CODEMP').AsString := strCodEmp;
      qryLalaMove.ParamByName('CODCLI').AsString := strCodCli;
      qryLalaMove.ParamByName('TIP_FC').AsString := qryDocumento.FieldByName('GER_TIP_FC').AsString;
      qryLalaMove.ParamByName('ORIDOC').AsString := qryDocumento.FieldByName('GER_ORIDOC').AsString;
      qryLalaMove.ParamByName('NUMPED').AsString := qryDocumento.FieldByName('FGO_NUMDOC').AsString;
      qryLalaMove.ParamByName('ESPPED').AsString := qryDocumento.FieldByName('FGO_ESPDOC').AsString;
      qryLalaMove.ParamByName('EMPPED').AsString := qryDocumento.FieldByName('FGO_CODEMP').AsString;
      qryLalaMove.ParamByName('ID_COT').AsString := qryDocumento.FieldByName('FGO_COTLAL').AsString;
      qryLalaMove.ParamByName('SITUAC').AsString := 'PEN';
      qryLalaMove.ExecSQL;

      qryDocumento.Next;
    end;
  finally
    FreeAndNil(qryDocumento);
    FreeAndNil(qryLalaMove);
  end;
end;

procedure TfrmFatExpedicaoItens.pGravaPesoExpedicao(fltPesBru,
  fltPesLiq: Double; intQtdPedido: integer);
var
  qryPeso: TUniQuery;
  recTotaisPeso: TTotaisPeso;
  intContador: integer;
  fltPesBruDoc: Double;
  fltPesLiqDoc: Double;
  blnPESEXP: Boolean;
begin
  intContador := 0;
  fltPesBruDoc := fFormataFloat(IIF(fltPesBru > 0, fltPesBru / intQtdPedido, 0.00),3);
  fltPesLiqDoc := fFormataFloat(IIF(fltPesLiq > 0, fltPesLiq / intQtdPedido, 0.00),3);

  blnPESEXP := fCfgSis('PESEXP', VarBoolean);

  qryPeso := fCriaQuery;

  try
    qryPeso.Close;
    qryPeso.SQL.Clear;
    qryPeso.SQL.Add('UPDATE EXTGOR');
    qryPeso.SQL.Add('SET FGO_PEBRTE = :PESBRU,');
    qryPeso.SQL.Add('    FGO_PELITE = :PESLIQ');
    qryPeso.SQL.Add('WHERE FGO_SEQFGO = :AUTINC');

    for recTotaisPeso in arrTotaisPeso do
    begin
      Inc(intContador);
      qryPeso.Close;
      if intContador = intQtdPedido then
      Begin
        If (blnPESEXP) Then
        Begin
          qryPeso.ParamByName('PESBRU').AsFloat := fltPesBru;
          qryPeso.ParamByName('PESLIQ').AsFloat := fltPesLiq;
        End
        Else
        Begin
          qryPeso.ParamByName('PESBRU').AsFloat := fltPesBru + recTotaisPeso.fltPesBru;
          qryPeso.ParamByName('PESLIQ').AsFloat := fltPesLiq + recTotaisPeso.fltPesLiq;
        End;
      End
      else
      begin
        If (blnPESEXP) Then
        Begin
          qryPeso.ParamByName('PESBRU').AsFloat := fltPesBruDoc;
          qryPeso.ParamByName('PESLIQ').AsFloat := fltPesLiqDoc;
        End
        Else
        Begin
          qryPeso.ParamByName('PESBRU').AsFloat := fltPesBruDoc + recTotaisPeso.fltPesBru;
          qryPeso.ParamByName('PESLIQ').AsFloat := fltPesLiqDoc + recTotaisPeso.fltPesLiq;
        End;

        fltPesBru := fltPesBru - fltPesBruDoc;
        fltPesLiq := fltPesLiq - fltPesLiqDoc;
      end;
      qryPeso.ParamByName('AUTINC').AsString := recTotaisPeso.strAutInc;
      qryPeso.ExecSQL;
    end;

  finally
    FreeAndNil(qryPeso);
  end;
end;

procedure TfrmFatExpedicaoItens.pGravarConfiguracoesExpedicaoItens;
begin
  TCfgColExpItensCaixa.pCarregarDadosSalvosItens(dbgItens);
  TCfgColExpItensCaixa.pCarregarDadosSalvosCaixa(dbgEtiCaixa);
end;

procedure TfrmFatExpedicaoItens.pGravarDadosEtiqueta(
  const cdsCaixa: TUniClientDataSet; const caixa: TCaixa);
var
  qryAuxiliar: TUniQuery;
begin
  If Not fAtivadoMontagemCaixaConferenciaAUTCOMColetor Then
    Exit;

  qryAuxiliar := fCriaQuery;
  Try
    qryAuxiliar.SQL.Text := 'SELECT * FROM MNTCXA '
                          + ' WHERE MCX_CODIGO = :CODIGO ';
    qryAuxiliar.ParamByName('CODIGO').AsString := caixa.strCodMcx;
    qryAuxiliar.Open;

    cdsCaixa.FieldByName('ALTURA').AsFloat       := qryAuxiliar.FieldByName('MCX_ALTURA').AsFloat;
    cdsCaixa.FieldByName('LARGURA').AsFloat      := qryAuxiliar.FieldByName('MCX_LARGUR').AsFloat;
    cdsCaixa.FieldByName('PROFUNDIDADE').AsFloat := qryAuxiliar.FieldByName('MCX_PROFUN').AsFloat;
  Finally
    FreeAndNil(qryAuxiliar);
  End;
end;

function TfrmFatExpedicaoItens.fGetQuantidadeRegistrosExpedidos(const cdsDados: TUniClientDataSet) : Integer;
  Var
    cdsClone : TUniClientDataSet;
begin
  cdsClone := TUniClientDataSet.Create(Self);
  Try
    pCloneDataSet(cdsClone, cdsItens);
    cdsClone.Filter := 'QTDEXP > 0';
    cdsClone.Filtered := True;
    Result := cdsClone.RecordCount;
  Finally
    FreeAndNil(cdsClone);
  End;
end;

procedure TfrmFatExpedicaoItens.pGravarInformacoesSeparacao;
const
  STR_SEPDET = 'SELECT * FROM SEPDET WHERE DET_SEQGER = :SEQDET';
  STR_SEPFDO = 'SELECT * FROM SEPFDO WHERE FDO_SEQFDO = :SEQDET';
Var
  qryGravaSep: TUniQuery;
  strTabela: String;
  intQtdRegExpedidos : Integer;
  strAutIncSep : String;
  blnIniciaTransacao : Boolean;
Begin
  qryGravaSep := fCriaQuery;
  Try
    Try
      Case StrToIntDef(FParams.VS_strTipExpInterna, 0) Of
        2:
          Begin
            qryGravaSep.SQL.Text := STR_SEPDET;
            strTabela := 'SEPDET';
          End;
        3,4:
          Begin
            qryGravaSep.SQL.Text := STR_SEPFDO;
            strTabela := 'SEPFDO';
          End;
      End;

      blnIniciaTransacao := Not fInTransaction;
      If (blnIniciaTransacao) Then
        fStartTransaction;

      intQtdRegExpedidos := fGetQuantidadeRegistrosExpedidos(cdsItens);
      strAutIncSep := EmptyStr;
      If (intQtdRegExpedidos > 0) Then
        strAutIncSep := fRetAutoIncrem(strTabela, VS_strCodEmp, intQtdRegExpedidos);

      cdsItens.First;
      while not cdsItens.Eof Do
      Begin
        qryGravaSep.Close;
        qryGravaSep.ParamByName('SEQDET').AsString := cdsItens.FieldByName('AUTOINCREM').AsString;
        qryGravaSep.Open;

        If (cdsItens.FieldByName('QTDEXP').AsFloat > 0) Then
        Begin
          If Assigned(cdsSetores) And cdsSetores.Active Then
          Begin
            If cdsSetores.Locate('SETOR_', cdsItens.FieldByName('SETOR_').AsString, []) Then
            Begin
              strCodSeparador  := cdsSetores.FieldByName('CODSEP').AsString;
              strCodConferente := fRetCodVendedor(cdsSetores.FieldByName('CODCON').AsString);
            End;
          End;

          If (strTabela = 'SEPDET') Then
          Begin
            qryGravaSep.Append;
            qryGravaSep.FieldByName('AUTOINCREM').AsString   := strAutIncSep;
            qryGravaSep.FieldByName('DET_SEQGER').AsString   := cdsItens.FieldByName('AUTOINCREM').AsString;
            qryGravaSep.FieldByName('DET_QTDITE').AsFloat    := cdsItens.FieldByName('QTDITE').AsFloat;
            qryGravaSep.FieldByName('DET_QTDSEP').AsFloat    := cdsItens.FieldByName('QTDEXP').AsFloat;
            qryGravaSep.FieldByName('DET_CODSEP').Value      := IIF(Not strCodSeparador.IsEmpty, strCodSeparador, Null);
            qryGravaSep.FieldByName('DET_CODCON').Value      := IIF(Not strCodConferente.IsEmpty, strCodConferente, Null);
            qryGravaSep.FieldByName('DET_OPELOG').AsString   := strLoginUsuarioLogado;
            qryGravaSep.FieldByName('DET_DTASEP').AsDateTime := VS_Date;
            qryGravaSep.FieldByName('DET_HORSEP').AsDateTime := fTime();
            qryGravaSep.FieldByName('DET_IMPSEQ').AsString   := IIF(chkImpSeq.Checked, 'S', 'N');
            qryGravaSep.FieldByName('DET_VOLEXP').AsInteger  := StrToIntDef(edtVolume.Text, 0);
            qryGravaSep.Post;
            strAutIncSep := fNextAutoIncrem(strAutIncSep);
          End
          Else
          Begin
            If FParams.blnCarregarQtdExpedida And
               qryGravaSep.Locate('FDO_QTDITE;FDO_QTDSEP',
                 VarArrayOf([cdsItens.FieldByName('QTDITE').AsFloat,
                             cdsItens.FieldByName('QTDEXP').AsFloat]), []) Then
            Begin
              cdsItens.Next;
              Continue;
            End;

            qryGravaSep.Append;
            qryGravaSep.FieldByName('AUTOINCREM').AsString   := strAutIncSep;
            qryGravaSep.FieldByName('FDO_SEQFDO').AsString   := cdsItens.FieldByName('AUTOINCREM').AsString;
            qryGravaSep.FieldByName('FDO_QTDITE').AsFloat    := cdsItens.FieldByName('QTDITE').AsFloat;
            qryGravaSep.FieldByName('FDO_QTDSEP').AsFloat    := cdsItens.FieldByName('QTDEXP').AsFloat;
            qryGravaSep.FieldByName('FDO_CODSEP').Value      := IIF(Not strCodSeparador.IsEmpty, strCodSeparador, Null);
            qryGravaSep.FieldByName('FDO_CODCON').Value      := IIF(Not strCodConferente.IsEmpty, strCodConferente, Null);
            qryGravaSep.FieldByName('FDO_OPELOG').AsString   := strLoginUsuarioLogado;
            qryGravaSep.FieldByName('FDO_DTASEP').AsDateTime := VS_Date;
            qryGravaSep.FieldByName('FDO_HORSEP').AsDateTime := fTime();
            qryGravaSep.FieldByName('FDO_IMPSEQ').AsString   := IIF(chkImpSeq.Checked, 'S', 'N');
            qryGravaSep.FieldByName('FDO_VOLEXP').AsInteger  := StrToIntDef(edtVolume.Text, 0);
            qryGravaSep.Post;
            strAutIncSep := fNextAutoIncrem(strAutIncSep);
          End;
        End
        Else If FParams.blnLimparExpedidos Then
        Begin
          qryGravaSep.First;
          While Not qryGravaSep.Eof Do
          Begin
            fVerificaIntegridade(Self.Name, strTabela, qryGravaSep, True);
            qryGravaSep.Delete;
          End;
        End;

        cdsItens.Next;
      end;

      If (blnIniciaTransacao) Then
        fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        Raise;
      End;
    End;
  Finally
    FreeAndNil(qryGravaSep);
  End;
end;

procedure TfrmFatExpedicaoItens.pImprimirSeparacaoErrada(cdsDocumento: TUniClientDataSet);
Var
  objFatImp : TFatVendaImp;
  documento : TDadosImpressaoVenda;
  qryUpdate : TUniQuery;
  strSepExp : String;
  strOcoSep : String;
  hrsImpSep : TTime;

  procedure pQtdExp(strAutinc: String; fltQtdExp: Double);
  Begin
    qryUpdate := fCriaQuery(Self);
    Try
      With qryUpdate, SQL Do
      Begin
        Close;
        Clear;
        Add('UPDATE EXTDOR SET FDO_QTDEXP = :QTDEXP ');
        Add('WHERE FDO_SEQFDO = :AUTOINC ');
        ParamByName('AUTOINC').AsString := strAutinc;
        ParamByName('QTDEXP').AsFloat   := fltQtdExp;
        ExecSQL;
      End;
    Finally
      FreeAndNil(qryUpdate);
    End;
  End;

begin
  strSepExp := cdsDocumento.FieldByName('SEPEXP').AsString;
  strOcoSep := fCfgSis('OCOSEP', varString);
  hrsImpSep := fTime();

  If (Assigned(frmFatExpedicao)) Then
  Begin
    If (fEmptyStr(strSepExp)) And frmFatExpedicao.fUtilizaSolicitacaoSeparador Then
    Begin
      strSepExp := frmFatExpedicao.fPedeSeparador(TTipoImpressaoSeparacao.tisWMSTodos);

      If fEmptyStr(strSepExp) Then
        Exit;
    End;
  End;

  If (Not fEmptyStr(strSepExp)) Then
  Begin
    cdsDocumento.first;
    While not cdsDocumento.eof do
    Begin
      pQtdExp(cdsDocumento.FieldByName('AUTOINCREM').AsString,
              cdsDocumento.FieldByName('QTDEXP').AsFloat);

      If fFormataFloat(cdsDocumento.FieldByName('QTDEXP').AsFloat, intDecQtd) <
         fFormataFloat(cdsDocumento.FieldByName('QTDITE').AsFloat, intDecQtd) Then
      Begin
        pGeraLogSepErrada(cdsDocumento.FieldByName('NUMDOC').AsString,
                          cdsDocumento.FieldByName('ESPDOC').AsString,
                          cdsDocumento.FieldByName('CODEMP').AsString,
                          strLoginUsuarioLogado,
                          cdsDocumento.FieldByName('SEPEXP').AsString,
                          VS_Date,
                          hrsImpSep,
                          cdsDocumento.FieldByName('CODITE').AsString,
                          fFormataFloat(cdsDocumento.FieldByName('QTDEXP').AsFloat, 2),
                          cdsDocumento.FieldByName('QTDITE').AsFloat);
      End;
      cdsDocumento.Next;
    End;

    If VS_strHabilitarCRM And (not fEmptyStr(strOcoSep)) Then
    Begin
      pOcorrenciaSeparacaoErrada(cdsDocumento.FieldByName('NUMDOC').AsString,
                                 cdsDocumento.FieldByName('ESPDOC').AsString,
                                 cdsDocumento.FieldByName('CODEMP').AsString,
                                 cdsDocumento.FieldByName('CODCLI').AsString,
                                 strSepExp,
                                 fRetornaCodigoOcorrencia(cdsDocumento.FieldByName('NUMDOC').AsString,
                                                          cdsDocumento.FieldByName('ESPDOC').AsString,
                                                          cdsDocumento.FieldByName('CODCLI').AsString,
                                                          cdsDocumento.FieldByName('CODEMP').AsString,
                                                         ''),
                                strOcoSep,
                                hrsImpSep);
    End;

    objFatImp := TFatVendaImp.Create;
    Try
      With documento Do
      Begin
        strNumDoc := cdsDocumento.FieldByName('NUMDOC').AsString;
        strEspDoc := cdsDocumento.FieldByName('ESPDOC').AsString;
        strEmpDoc := cdsDocumento.FieldByName('CODEMP').AsString;
        strCodCli := cdsDocumento.FieldByName('CODCLI').AsString;
        blnEnt_CD := (cdsDocumento.FieldByName('ENT_CD').AsString = 'S');
        blnExpedi := True;
      End;

      objFatImp.Add(documento);

      objFatImp.fImprimeSeparacao(objFatImp[0],
                                  '',
                                  '',
                                  False,
                                  -1,
                                  TFatVendaImp.fItensDocumento(documento.strNumDoc,
                                                               documento.strEspDoc,
                                                               documento.strEmpDoc,
                                                               documento.strCodCli));

      cdsDocumento.first;
      While not cdsDocumento.eof do
      Begin
        pQtdExp(cdsDocumento.FieldByName('AUTOINCREM').AsString, 0);

        cdsDocumento.Next;
      End;
    Finally
      If Assigned(objFatImp) Then
        objFatImp.Destroy;
    End;
  End
  Else
  Begin
    pMensagemOk('Ainda não foi informado nenhum separador para este pedido!');
    Exit;
  End;

end;

function TfrmFatExpedicaoItens.fVaiFaturarAposExpedirTodosOsItens: Boolean;
begin
  Result := (blnSitFinPedsSelOK) And (fCfgSis('FTPDEX', varBoolean)) And (Not FParams.blnExpParcial);
end;

function TfrmFatExpedicaoItens.fVaiImprimirMultiplosPedidosNaEtiquetaDeDespacho(
  var strMultPed, strMultNumDoc, strMultEspDoc, strMultCodEmp,
  strMultCodCli: String; stlPedidos: TStringList): Boolean;
var
  objPed: TPedidoVenda;
  intPed: integer;
begin
  Result := False;

  if not fCfgSis('ETIUNI', varBoolean) then
    Exit;

  if VS_strTipExp <> '4' then
    Exit;

  if stlPedidos.Count <= 1 then
    Exit;

  strMultPed := EmptyStr;

  objPed := TPedidoVenda(stlPedidos.Objects[0]);
  strMultNumDoc := objPed.strNumDoc;
  strMultEspDoc := objPed.strEspDoc;
  strMultCodEmp := objPed.strCodEmp;
  strMultCodCli := objPed.strCodCli;

  for intPed := 0 To stlPedidos.Count - 1 do
  begin
    objPed := TPedidoVenda(stlPedidos.Objects[intPed]);

    if strMultCodCli <> objPed.strCodCli then
      Exit;

    pIncrementaListaStr(objPed.strNumDoc, strMultPed, True);
  end;

  Result := True;
end;

function TfrmFatExpedicaoItens.fRetNumLotesSep: String;
var
  intContador: Integer;
  objPedido: TPedidoVenda;
  strSql: String;
  qrySelect: TUniQuery;
begin
  Result := '';
  If not Assigned(FParams.stlPedidos) or (FParams.stlPedidos.Count = 0) Then
    Exit;

  strSql := '';

  strSql := strSql + 'SELECT GROUP_CONCAT(DISTINCT ROMLGE.RLG_NUMLOT) ';
  strSql := strSql + 'FROM ROMLGE ';
  strSql := strSql + 'INNER JOIN ROMLDE ON RLD_SEQRLG = ROMLGE.AUTOINCREM ';
  strSql := strSql + 'INNER JOIN ROMLIT ON RLI_SEQRLD = ROMLDE.AUTOINCREM ';
  strSql := strSql + 'WHERE RLI_JAFATU = 0 AND ';
  strSql := strSql + '( ';

  For intContador := 0 To FParams.stlPedidos.Count -1 Do
  Begin
    objPedido  := TPedidoVenda(FParams.stlPedidos.Objects[intContador]);

    strSql := strSql + '  (RLD_NUMDOC = ' + QuotedStr(objPedido.strNumDoc) + ' AND ';
    strSql := strSql + '   RLD_CODEMP = ' + QuotedStr(objPedido.strCodEmp) + ' AND ';
    strSql := strSql + '   RLD_ESPDOC = ' + QuotedStr(objPedido.strEspDoc) + ') ';

    If intContador < FParams.stlPedidos.Count -1 Then
      strSql := strSql + ' OR ';
  End;
  strSql := strSql + ') ';

  qrySelect := fCriaQuery;
  try
    qrySelect.SQL.Add(strSql);
    qrySelect.Open;

    Result := qrySelect.Fields[0].AsString;

  finally
    FreeAndNil(qrySelect);
  end;
end;

function TfrmFatExpedicaoItens.fRetornaTotalVolumePedidosExpedidosJuntos(
  stlPedidos: TStringList; intQtdOri: Integer): integer;
var
  qryVolume: TUniQuery;
  objPed: TPedidoVenda;
  intPed: integer;
  strNumDoc: String;
  strEspDoc: String;
  strCodEmp: String;
  strCodCli: String;
begin
  Result := intQtdOri;

  if not fCfgSis('ETIUNI', varBoolean) then
    Exit;

  if VS_strTipExp <> '4' then
    Exit;

  if stlPedidos.Count <= 1 then
    Exit;

  objPed := TPedidoVenda(stlPedidos.Objects[0]);
  strNumDoc := EmptyStr;
  strEspDoc := objPed.strEspDoc;
  strCodEmp := objPed.strCodEmp;
  strCodCli := objPed.strCodCli;

  for intPed := 0 To stlPedidos.Count - 1 do
  begin
    objPed := TPedidoVenda(stlPedidos.Objects[intPed]);

    if strCodCli <> objPed.strCodCli then
      Exit;

    pIncrementaListaStr(objPed.strNumDoc, strNumDoc, True);
  end;

  qryVolume := fCriaQuery;

  try
    qryVolume.Close;
    qryVolume.SQL.Clear;
    qryVolume.SQL.Add('SELECT F.FGO_VOLUME');
    qryVolume.SQL.Add('FROM FATGOR F');
    qryVolume.SQL.Add('INNER JOIN EXTGOR E');
    qryVolume.SQL.Add('ON(F.AUTOINCREM = E.FGO_SEQFGO)');
    qryVolume.SQL.Add('WHERE F.FGO_CODCLI = :CODCLI');
    qryVolume.SQL.Add('AND F.FGO_CODEMP = :CODEMP');
    qryVolume.SQL.Add('AND F.FGO_ESPDOC = :ESPDOC');
    qryVolume.SQL.Add('AND F.FGO_NUMDOC IN('+strNumDoc+')');
    qryVolume.SQL.Add('GROUP BY E.FGO_MULPED, F.FGO_VOLUME');

    qryVolume.ParamByName('CODCLI').AsString := strCodCli;
    qryVolume.ParamByName('CODEMP').AsString := strCodEmp;
    qryVolume.ParamByName('ESPDOC').AsString := strEspDoc;

    qryVolume.Open;

    if qryVolume.IsEmpty then
      Exit;

    Result := 0;

    while not qryVolume.Eof do
    begin
      Result := Result + Floor(qryVolume.FieldByName('FGO_VOLUME').AsFloat);
      qryVolume.Next;
    end;
  finally
    FreeAndNil(qryVolume);
  end;
end;

function TfrmFatExpedicaoItens.fValidaDireitoAcesso: boolean;
begin
  objLiberacao.Clear;
  objLiberacao.strDirAce    := 'QTDEXP';
  objLiberacao.strMsgSen    := 'Expedição - Permitir alterar a quantidade conferida através do botão "[F6] Qtde"';
  objLiberacao.strCodOpe    := strLoginUsuarioLogado;
  objLiberacao.objMsgLibera.pAddTexto('Expedição - Permitir alterar a quantidade conferida através do botão "[F6] Qtde"' + sLineBreak +
                                      'Produto: ' + cdsItens.FieldByName('DESITE').AsString);
  objLiberacao.pInformaNumDocEspDocCodEmp(
                    cdsItens.FieldByName('NUMDOC').AsString,
                    cdsItens.FieldByName('ESPDOC').AsString,
                    VS_strCodEmp);

  Result := objLiberacao.fLibera;
end;


function TfrmFatExpedicaoItens.fValidaEstoqueSubItensEstrutura(strCodIte: String;
  fltQtdIte: Double; strNumDoc: String): Boolean;
  Var
    objItensEstrutura: TItensEstrutura;
    subItem: TSubItemEstrutura;
    intCont: Integer;
    fltSaldo: Double;
begin
  Result := True;
  objItensEstrutura := TItensEstrutura.Create;
  Try
    objItensEstrutura.pCarregarEstrutura(strCodIte, fltQtdIte);

    For intCont := 0 To objItensEstrutura.ItemsCount -1 Do
    Begin
      subItem := objItensEstrutura[intCont];

      fltSaldo := fRetornaSaldoDisponivel(subItem.strCodigo, False, True, '', True, VS_strCodEmp, strNumDoc);

      If (fltSaldo < subItem.fltQtdTot) Then
      Begin
        Result := False;
        Break;
      End;
    End;
  Finally
    FreeAndNil(objItensEstrutura);
  End;
end;

function TfrmFatExpedicaoItens.fConfirmarExpedicao(pgbStatus: TcxProgressBar = nil): Boolean;
{Trata a expedição quando for selecionado mais de um cliente ou grupos de campos
que anterioremente travavam a expedição e hoje caso a CLIXCP = "SIM",
ficam liberados para serem expedidos em conjunto, porém gerando notas
separadas - KM

 * MESMO CLIENTE, MESMO VENDEDOR, MESMA TRANSPORTADORA, MESMO DESTINO ( RETIRA/ENTREGA ) - UMA NOTA SOMENTE
 * CLIENTES DIFERENTES / FAZENDAS DIFERENTES OU EMBARCAÇÕES DIFERENTES - UMA NOTA PARA CADA AGRUPAMENTO
 }
Var LPedidosGrupo, LPedidosCopia, LPedidoComADT  : TStringList;
    intContador,
    intContadorCli,
    intContadorCnd,
    intContadorGrup : Integer;
    strCodCliAnt,
    strCodCndAnt,
    strCodGrupoAnt : String;
    objPedidoCopia : TPedidoVenda;
    objPedidoGrupo : TPedidoVenda;
    objPedidoCondicao: TPedidoVenda;
    strMensagem    : String;
Begin
  If (blnFecharForm) Then
  Begin
    Result := False;
    Exit;
  End;

  Result := True;
  SetLength(arrEtiquetaImpressaoMultiSelecao, 0);
  SetLength(arrDocumentoGerados, 0);
  strMensagem := '';

  pInformacao('Aguarde, Confirmando Expedição ...', pgbStatus);

  If (Not fValidouObjetosDaConfirmacao) Then
  Begin
    pMensagemOk('Não carregou corretamente o(s) documento(s), feche a expedição e faça o processo novamente!');
    Result := False;
    Exit;
  End;

  FParams.blnMaisDeUmPedidoDoMesmoClienteComAdiantamento := fMaisDeUmPedidoDoMesmoClienteComAdiantamento(FParams.stlPedidos);

  {Somente se um dos stringlist´s agrupadores tiverem mais de 1 linha, senão expedir como era feito antes}
  If (fSelecaoMultipla Or FParams.blnMaisDeUmPedidoDoMesmoClienteComAdiantamento) Then
  Begin

    LPedidosCopia := TStringList.Create;
    LPedidosGrupo := TStringList.Create;
    LPedidoComADT := TStringList.Create;

    LPedidosCopia.Assign(FParams.stlPedidos);

    Try

      {Agrupa pedidos que serão faturados juntos:
      Por Cliente
      Por Demais Grupos}

      For intContadorCli := 0 To FParams.stlListaClientes.Count -1 Do
      Begin
        strCodCliAnt    := TPedidoVenda(FParams.stlListaClientes.Objects[intContadorCli]).strCodCli;

        For intContadorGrup := 0 To FParams.stlListaGrupos.Count -1 Do
        Begin
          objPedidoGrupo := TPedidoVenda(FParams.stlListaGrupos.Objects[intContadorGrup]);
          strCodGrupoAnt := objPedidoGrupo.strCodFaz + objPedidoGrupo.strCodEmb;

          For intContadorCnd := 0 To stlListaCondicaoPagamento.Count - 1 Do
          Begin
            objPedidoCondicao := TPedidoVenda(stlListaCondicaoPagamento.Objects[intContadorCnd]);
            strCodCndAnt := fCampoTabela('FGO_CODCND', 'FATGOR', ['AUTOINCREM'], [objPedidoCondicao.strSeqGer], False);

            For intContador := 0 To LPedidosCopia.Count -1 Do
            Begin
              objPedidoCopia := TPedidoVenda(LPedidosCopia.Objects[intContador]);

              {*** Pedidos com ADIANTAMENTO são faturados SEPARADAMENTE ***}
              If (objPedidoCopia.strTemADT.Equals('S')) Then
              Begin

                If (strCodCliAnt.Equals(objPedidoCopia.strCodCli)) Then
                Begin

                  LPedidoComADT.AddObject(objPedidoCopia.strSeqGer, objPedidoCopia);
                  FParams.stlPedidos.Assign(LPedidoComADT);

                  pConfirmandoExpedicao(pgbStatus);
                  LPedidoComADT.Clear;

                End;

              End
              Else
              Begin
                {Pedidos do cliente e Grupo}
                If (strCodCliAnt = objPedidoCopia.strCodCli) And
                   (strCodCndAnt = fCampoTabela('FGO_CODCND', 'FATGOR', ['AUTOINCREM'], [objPedidoCopia.strSeqGer], False)) And
                   (strCodGrupoAnt = objPedidoCopia.strCodFaz + objPedidoCopia.strCodEmb) Then
                  LPedidosGrupo.AddObject(objPedidoCopia.strSeqGer, objPedidoCopia);
              End;

            End;

            If LPedidosGrupo.Count > 0 Then
            Begin
              FParams.stlPedidos.Assign(LPedidosGrupo);

              {Expedindo com a sltPedidos já tratada}
              pConfirmandoExpedicao(pgbStatus);

              LPedidosGrupo.Clear;
            End;
          End;
        End;
      End;

      If (FParams.stlListaClientes.Count > 1) And (Length(arrDocumentoGerados) > 0) Then
      Begin
        For intContador := 0 to Length(arrDocumentoGerados) - 1 Do
        Begin
          strMensagem := strMensagem + arrDocumentoGerados[intContador];

          If IntContador < Length(arrDocumentoGerados)-1 Then
            strMensagem := strMensagem + ', ';
        End;

        fMensagem('', 'Documentos gerados com sucesso: '+ sLineBreak + strMensagem+'!', ['&Ok']);
      End;

      If (fSelecaoMultipla) And (Length(arrEtiquetaImpressaoMultiSelecao) > 0) Then
      Begin
        pMostraTelaImpressaoDespachoMultiSelecao;
      End;
    Finally

      FParams.stlPedidos.Assign(LPedidosCopia);

      If Assigned(LPedidosCopia) Then
        FreeAndNil(LPedidosCopia);

      If Assigned(LPedidosGrupo) Then
        FreeAndNil(LPedidosGrupo);

      If Assigned(LPedidoComADT) Then
        FreeAndNil(LPedidoComADT);

    End;
  End
  Else
    pConfirmandoExpedicao(pgbStatus);
End;

function TfrmFatExpedicaoItens.fConsiderarTodasAsCaixas: Boolean;
begin
  Result := (fCfgSis('FDECTC', VarString) = 'M');
end;

function TfrmFatExpedicaoItens.fRetAutIncMovdet(strAutIncFdo: String): String;
Var
  qryAutInc : TUniQuery;
begin

  Result := '';
  qryAutInc := fCriaQuery;
  Try
    qryAutInc.Close;
    qryAutInc.SQL.Clear;
    qryAutInc.SQL.Add(' SELECT MD.AUTOINCREM AS AUTOINC');
    qryAutInc.SQL.Add('   FROM MOVAUX MX ');
    qryAutInc.SQL.Add(' LEFT JOIN MOVDET MD ');
    qryAutInc.SQL.Add('   ON MD.AUTOINCREM = MX.DET_SEQGER ');
    qryAutInc.SQL.Add(' LEFT JOIN FATDOR FD ');
    qryAutInc.SQL.Add('   ON MX.DET_INC_PD = FD.AUTOINCREM ');
    qryAutInc.SQL.Add(' WHERE FD.AUTOINCREM = :AUTINC ');

    qryAutInc.ParamByName('AUTINC').AsString := strAutIncFdo;

    qryAutInc.Open;

    Result := qryAutInc.FieldByName('AUTOINC').AsString;
  finally
    FreeAndNil(qryAutInc);
  End;

end;

function TfrmFatExpedicaoItens.fRetCodBarraCliPro: String;
Var intContador    : Integer;
Begin
  Result := '';

  If (FParams.stlListaClientes.Count > 1) And (fPermitirMarcarPedidosDeClientesDiferentesNaExpedicao) Then
  Begin
    For intContador := 0 To FParams.stlListaClientes.Count -1 Do
    Begin
     {VERIFICA O CODIGO DE BARRAS TRAZIDO PELO CLIENTE AGRUPADO }
      Result := fBarCliProToCodIte(TPedidoVenda(FParams.stlListaClientes.Objects[intContador]).strCodCli, edtCodIte.Text);
      If not fEmptyStr(Result) Then
        Break;
    End;
  End
  Else
    Result := fBarCliProToCodIte(TPedidoVenda(FParams.stlPedidos.Objects[0]).strCodCli, edtCodIte.Text);
End;


function TfrmFatExpedicaoItens.fRetCodigoAbrirFecharCaixa: String;
begin
  Result := fCfgSis('CODCAI', VarString);
end;

procedure TfrmFatExpedicaoItens.pMontaListaClientes;
Var intContador    : Integer;
    strCodCliAnt   : String;
    objPedidoCli   : TPedidoVenda;
Begin
  strCodCliAnt    := '';

  For intContador := 0 To FParams.stlPedidos.Count -1 Do
  Begin
    objPedidoCli := TPedidoVenda(FParams.stlPedidos.Objects[intContador]);
    If (strCodCliAnt <> objPedidoCli.strCodCli) And (FParams.stlListaClientes.IndexOf(objPedidoCli.strCodCli) = -1) Then
    Begin
      FParams.stlListaClientes.AddObject(objPedidoCli.strCodCli, objPedidoCli);
      strCodCliAnt := objPedidoCli.strCodCli;
    End;
  End;
End;

procedure TfrmFatExpedicaoItens.pMontaListaCondicaoPagamento(
  stlPedidos: TStringlist);
var
  intIndice: Integer;
  strCodCnd: String;
  strCodCndAnt: String;
  objPedidoCodCnd: TPedidoVenda;
begin
  strCodCndAnt := EmptyStr;

  for intIndice := 0 to stlPedidos.Count - 1 do
  begin
    objPedidoCodCnd := TPedidoVenda(stlPedidos.Objects[intIndice]);
    strCodCnd := fCampoTabela('FGO_CODCND', 'FATGOR', ['AUTOINCREM'], [objPedidoCodCnd.strSeqGer], False);

    if (strCodCndAnt <> strCodCnd) and (stlListaCondicaoPagamento.IndexOf(strCodCnd) = -1) then
    begin
      stlListaCondicaoPagamento.AddObject(strCodCnd, objPedidoCodCnd);
      strCodCndAnt := strCodCnd;
    end;
  end;
end;

Procedure TfrmFatExpedicaoItens.pValorMinimoNotaFiscalRetiraLista(var fltVlwMinRet : Double);
Var
  intContador : Integer;
Begin
  For intContador := 0 To FParams.stlListaClientes.Count -1 Do
  Begin
    fltVlwMinRet :=  fValorMinimoNotaFiscalRetira(TPedidoVenda(FParams.stlPedidos.Objects[intContador]).strCodCli);
    If (fltVlwMinRet > 0) then
      Break;
  End;
End;

Procedure TfrmFatExpedicaoItens.pValorMinimoNotaFiscalEntregaLista(var fltVlwMinEnt : Double);
Var
  intContador : Integer;
Begin
  For intContador := 0 To FParams.stlListaClientes.Count -1 Do
  Begin
    fltVlwMinEnt :=  fValorMinimoNotaFiscalEntrega(TPedidoVenda(FParams.stlPedidos.Objects[intContador]).strCodCli);
    If (fltVlwMinEnt > 0) then
      Break;
  End;
End;

procedure TfrmFatExpedicaoItens.pMensagemGarantiaEnvioClienteExp;
Var
  intContador : Integer;
Begin
  If (FParams.stlListaClientes.Count > 1) And (fPermitirMarcarPedidosDeClientesDiferentesNaExpedicao) Then
  Begin
    For intContador := 0 To FParams.stlListaClientes.Count -1 Do
    Begin
      TFatVenda.pMensagemGarantiaEnvioCliente(TPedidoVenda(FParams.stlPedidos.Objects[intContador]).strCodCli);
    End;
  End
  Else
    TFatVenda.pMensagemGarantiaEnvioCliente(FParams.strCodCli);
End;

procedure TfrmFatExpedicaoItens.pMontaListaGrupos;
{Neste proceso é criado uma stringlist com outros campos que poderão separar a geração
de Nota, caso CLIXCP = "SIM".
É possível acrescentar mais campos nesta rotina, caso for necessário, hoje ela cuida
dos agrupamentos por:

* FAZENDA
* EMBARCACAO

Ps: Foi necessária a inclusão também com valores vazios, pois anteriormente não era
    possível expedir quando um dos pedidos, por ex, tinha uma fazenda informada e o outro não,
    portanto também precisamos separar as notas nesse caso.

KM}
Var intContador    : Integer;
    strCodFazAnt,
    strCodEmbAnt   : String;
    objPedidoGrupo : TPedidoVenda;
Begin
  strCodFazAnt := '';
  strCodEmbAnt := '';

  For intContador := 0 To FParams.stlPedidos.Count -1 Do
  Begin
    objPedidoGrupo := TPedidoVenda(FParams.stlPedidos.Objects[intContador]);

    If (((strCodFazAnt <> objPedidoGrupo.strCodFaz) Or (strCodEmbAnt <> objPedidoGrupo.strCodEmb)) Or
        ((fEmptyStr(objPedidoGrupo.strCodFaz)) And (fEmptyStr(objPedidoGrupo.strCodFaz)))) And
        (FParams.stlListaGrupos.IndexOf(objPedidoGrupo.strCodFaz + objPedidoGrupo.strCodEmb) = -1) Then
    Begin
      FParams.stlListaGrupos.AddObject(objPedidoGrupo.strCodFaz + objPedidoGrupo.strCodEmb, objPedidoGrupo);
      strCodFazAnt := objPedidoGrupo.strCodFaz;
      strCodembAnt := objPedidoGrupo.strCodEmb;
    End;
  End;
End;

procedure TfrmFatExpedicaoItens.pMostraTelaImpressaoDespachoMultiSelecao;
var
  frmExpDigVolumesSelecaoMultipla: TfrmExpDigVolumesSelecaoMultipla;
  intIndice: integer;
  tpeResultadoEtiqueta: TResultadoEtiquetaUnificada;
begin
  pCriarFormularios(TfrmExpDigVolumesSelecaoMultipla, frmExpDigVolumesSelecaoMultipla);

  try
    frmExpDigVolumesSelecaoMultipla.cdsEtiquetas.DisableControls;

    try
      frmExpDigVolumesSelecaoMultipla.cdsEtiquetas.EmptyDataSet;

      for intIndice := 0 to Length(arrEtiquetaImpressaoMultiSelecao) - 1 do
      begin
        if (not fEmptyStr(arrEtiquetaImpressaoMultiSelecao[intIndice].strNumDoc)) then
        begin
          frmExpDigVolumesSelecaoMultipla.cdsEtiquetas.Append;
          frmExpDigVolumesSelecaoMultipla.cdsEtiquetasIMPETI.AsBoolean := arrEtiquetaImpressaoMultiSelecao[intIndice].blnImprime;
          frmExpDigVolumesSelecaoMultipla.cdsEtiquetasNUMDOC.AsString := arrEtiquetaImpressaoMultiSelecao[intIndice].strNumDoc;
          frmExpDigVolumesSelecaoMultipla.cdsEtiquetasESPDOC.AsString := arrEtiquetaImpressaoMultiSelecao[intIndice].strEspDoc;
          frmExpDigVolumesSelecaoMultipla.cdsEtiquetasDOCESP.AsString := frmExpDigVolumesSelecaoMultipla.cdsEtiquetasNUMDOC.AsString + '-' + frmExpDigVolumesSelecaoMultipla.cdsEtiquetasESPDOC.AsString;
          frmExpDigVolumesSelecaoMultipla.cdsEtiquetasCODEMP.AsString := arrEtiquetaImpressaoMultiSelecao[intIndice].strCodEmp;
          frmExpDigVolumesSelecaoMultipla.cdsEtiquetasCODCLI.AsString := arrEtiquetaImpressaoMultiSelecao[intIndice].strCodCli;
          frmExpDigVolumesSelecaoMultipla.cdsEtiquetasNOMCLI.AsString := arrEtiquetaImpressaoMultiSelecao[intIndice].strNomCli;
          frmExpDigVolumesSelecaoMultipla.cdsEtiquetasCODNOM.AsString := frmExpDigVolumesSelecaoMultipla.cdsEtiquetasCODCLI.AsString + '-' + frmExpDigVolumesSelecaoMultipla.cdsEtiquetasNOMCLI.AsString;
          frmExpDigVolumesSelecaoMultipla.cdsEtiquetasPESBRU.AsFloat := arrEtiquetaImpressaoMultiSelecao[intIndice].fltPesBru;
          frmExpDigVolumesSelecaoMultipla.cdsEtiquetasPESLIQ.AsFloat := arrEtiquetaImpressaoMultiSelecao[intIndice].fltPesLiq;
          frmExpDigVolumesSelecaoMultipla.cdsEtiquetasVOLUME.AsInteger := arrEtiquetaImpressaoMultiSelecao[intIndice].intVolume;
          If blnUtilizaSeparacaoExclusiva Then
          Begin
            frmExpDigVolumesSelecaoMultipla.cdsEtiquetasVOLEXS.AsInteger := arrEtiquetaImpressaoMultiSelecao[intIndice].intVolSepExc;
            frmExpDigVolumesSelecaoMultipla.cdsEtiquetasVOLEXN.AsInteger := arrEtiquetaImpressaoMultiSelecao[intIndice].intVolSepNExc;
          End;
          frmExpDigVolumesSelecaoMultipla.cdsEtiquetas.Post;
        end;
      end;

      frmExpDigVolumesSelecaoMultipla.cdsEtiquetas.First;
      frmExpDigVolumesSelecaoMultipla.cdsEtiquetas.Open;
    finally
      frmExpDigVolumesSelecaoMultipla.cdsEtiquetas.EnableControls;
    end;

    if (frmExpDigVolumesSelecaoMultipla.cdsEtiquetas.RecordCount <= 0) then
      Exit;

    frmExpDigVolumesSelecaoMultipla.ShowModal;
    if frmExpDigVolumesSelecaoMultipla.ModalResult = mrOk then
    begin
      frmExpDigVolumesSelecaoMultipla.cdsEtiquetas.DisableControls;

      try
        frmExpDigVolumesSelecaoMultipla.cdsEtiquetas.First;

        while not frmExpDigVolumesSelecaoMultipla.cdsEtiquetas.Eof do
        begin
          if (frmExpDigVolumesSelecaoMultipla.cdsEtiquetasIMPETI.AsBoolean) then
          begin
            pAtualizaPesoImpressaoDespachoMultiSelecao(frmExpDigVolumesSelecaoMultipla.cdsEtiquetasNUMDOC.AsString,
                                                       frmExpDigVolumesSelecaoMultipla.cdsEtiquetasESPDOC.AsString,
                                                       frmExpDigVolumesSelecaoMultipla.cdsEtiquetasCODEMP.AsString,
                                                       frmExpDigVolumesSelecaoMultipla.cdsEtiquetasCODCLI.AsString,
                                                       frmExpDigVolumesSelecaoMultipla.cdsEtiquetasPESBRU.AsFloat,
                                                       frmExpDigVolumesSelecaoMultipla.cdsEtiquetasPESLIQ.AsFloat);

            pImprimeEtiquetaDespacho(frmExpDigVolumesSelecaoMultipla.cdsEtiquetasNUMDOC.AsString,
                                     frmExpDigVolumesSelecaoMultipla.cdsEtiquetasESPDOC.AsString,
                                     frmExpDigVolumesSelecaoMultipla.cdsEtiquetasCODCLI.AsString,
                                     frmExpDigVolumesSelecaoMultipla.cdsEtiquetasVOLUME.AsInteger,
                                     frmExpDigVolumesSelecaoMultipla.cdsEtiquetasCODEMP.AsString,
                                     tpeResultadoEtiqueta,
                                     False,
                                     frmExpDigVolumesSelecaoMultipla.cdsEtiquetasVOLEXS.AsInteger,
                                     frmExpDigVolumesSelecaoMultipla.cdsEtiquetasVOLEXN.AsInteger);
          end;

          frmExpDigVolumesSelecaoMultipla.cdsEtiquetas.Next;
        end;
      finally
        frmExpDigVolumesSelecaoMultipla.cdsEtiquetas.EnableControls;
      end;
    end;

  finally
    pFreeAndNil(frmExpDigVolumesSelecaoMultipla);
  end;
end;

procedure TfrmFatExpedicaoItens.pAlimentarDatasetValoresMinimos;
var
  intContador : Integer;
Begin
  cdsValoresCli.Close;
  cdsValoresCli.Open;
  cdsValoresCli.EmptyDataset;
  for intContador := 0 to FParams.stlListaClientes.Count - 1 do
  Begin
    cdsValoresCli.Insert;
    cdsValoresCli.FieldByName('CLI_CODCLI').asString := TPedidoVenda(FParams.stlListaClientes.Objects[intContador]).strCodCli;
    cdsValoresCli.FieldByName('CLI_NOMCLI').asString := fRetNomCliente(TPedidoVenda(FParams.stlListaClientes.Objects[intContador]).strCodCli);
    cdsValoresCli.FieldByName('CLI_VLMINE').asFloat  := fValorMinimoNotaFiscalEntrega(TPedidoVenda(FParams.stlListaClientes.Objects[intContador]).strCodCli);
    cdsValoresCli.FieldByName('CLI_VLMINR').asFloat  := fValorMinimoNotaFiscalRetira(TPedidoVenda(FParams.stlListaClientes.Objects[intContador]).strCodCli);
    cdsValoresCli.Post;
  End;
  TFloatField(cdsValoresCli.FieldByName('CLI_VLMINE')).DisplayFormat := '#,##0.00';
  TFloatField(cdsValoresCli.FieldByName('CLI_VLMINR')).DisplayFormat := '#,##0.00';
  cdsValoresCli.First;
End;

procedure TfrmFatExpedicaoItens.pImprimirEtiqVendasProdutosControlados;
var
  prmDllEtq: TParamDllEtiquetas;
  LQuery : TUniQuery;
begin
  inherited;

  prmDllEtq := TParamDllEtiquetas.Create;
  LQuery := fCriaQuery(Self);

  Try

    prmDllEtq.strCodEmp := ShortString(String(VS_strCodEmp));
    prmDllEtq.dtsImpres := LQuery;

    if fCfgSis('ETICVE', varString) = 'L' then
      prmDllEtq.tpeTipEtq := tpeProdutosControladosVendasLaser
    else if fCfgSis('ETICVE', varString) = 'A' then
      prmDllEtq.tpeTipEtq := tpeProdutosControladosVendasArgox
    else if fCfgSis('ETICVE', varString) = 'Z' then
      prmDllEtq.tpeTipEtq := tpeProdutosControladosVendasZebra;

    LQuery.Close;
    LQuery.SQL.Clear;
    LQuery.SQL.Add(fGetSqlProdControlado(FParams.stlPedidos));
    LQuery.Open;

    fImprimeEtiqueta(prmDllEtq);

  Finally
    FreeAndNil(prmDllEtq);
    FreeAndNil(LQuery);
  End;

end;

function TfrmFatExpedicaoItens.fSelecaoMultipla : Boolean;
Begin
  Result := (((FParams.stlListaClientes.Count > 1) Or (FParams.stlListaGrupos.Count > 1)) And (fPermitirMarcarPedidosDeClientesDiferentesNaExpedicao)) Or (fAgrupaPedidoPorCondicaoPagamento);
End;

procedure TfrmFatExpedicaoItens.pImprimeTicketIF(fatVenda: TFatVenda);
  var
    objDadosDocImpressao: TDadosImpressaoVenda;
    objFatVendaImp : TFatVendaImp;
begin
  If (fatVenda = nil) or (Not fImprimirTicketIFExpedicao(fatVenda)) Then
    Exit;

  If Assigned(frmFechamentoVenda) Then
    pInformacao('Aguarde, montando impressão de ticket...', frmFechamentoVenda.pgbStatus);
  objFatVendaImp := TFatVendaImp.Create;

  try
    objDadosDocImpressao.strNumDoc := fatVenda.strNumDoc;
    objDadosDocImpressao.strEspDoc := fatVenda.strEspDoc;
    objDadosDocImpressao.strEmpDoc := VS_strCodEmp;
    objDadosDocImpressao.strCodCli := fatVenda.strCodCli;
    objFatVendaImp.pImprimeTicketIF(objDadosDocImpressao);
  finally
    FreeAndNil(objDadosDocImpressao);
    FreeAndNil(objFatVendaImp);
  end;
end;

function TfrmFatExpedicaoItens.fImprimirTicketIFExpedicao(fatVenda: TFatVenda): Boolean;
begin
  Result := False;

  If (Not fCfgSis('IMTKEX', varBoolean)) Then
    Exit;

  If (Pos(fatVenda.strEspDoc, 'IF') <= 0) Then
    Exit;

  If (Not fCfgSis('IMPTCK', varBoolean)) Then
    Exit;

  Result := True;
end;

function TfrmFatExpedicaoItens.fIdentificadorDoItemNoPedidoDaCaixaAberta: String;
  Var
    strNumDocCaixa: String;
    strCodItemAtual: String;
    strAutoIncrem: String;
    cdsClone: TUniClientDataSet;
begin
  Result := '';
  strNumDocCaixa := '';
  strAutoIncrem := '';
  cdsClone := TUniClientDataSet.Create(Self);

  Try
    pCloneDataSet(cdsClone, cdsItens);

    If (objMontarCaixas.CaixaAberta.strID.Length >= 12) Then
      strNumDocCaixa := Copy(objMontarCaixas.CaixaAberta.strID, 0, 12);

    strCodItemAtual := cdsItens.FieldByName('CODITE').AsString;

    cdsClone.Filtered := False;
    cdsClone.Filter   := ' CODITE = ' + QuotedStr(strCodItemAtual) + ' AND ' +
                         ' NUMDOC = ' + QuotedStr(strNumDocCaixa)  + ' AND ' +
                         ' QTDEXP + QTDBAI < QTDTOT';
    cdsClone.Filtered := True;

    If (cdsClone.RecordCount > 0) Then
      strAutoIncrem := cdsClone.FieldByName('AUTOINCREM').AsString;

    Result := strAutoIncrem;
  Finally
    FreeAndNil(cdsClone);
  End;
end;

procedure TfrmFatExpedicaoItens.pAtualizaItemPertencenteACaixaAberta(strAutoIncrem: String; Var strMensagem: String);
  Var
    blnCdsFiltrado: Boolean;
    strFiltroOriginal: String;
begin
  blnCdsFiltrado := cdsItens.Filtered;
  strFiltroOriginal := cdsItens.Filter;

  cdsItens.DisableControls;
  cdsItens.Filtered := False;
  cdsItens.Filter   := ' AUTOINCREM = ' + QuotedStr(strAutoIncrem);
  cdsItens.Filtered := True;

  fEncontraItem(strMensagem);

  cdsItens.Filtered := False;
  cdsItens.Filter   := strFiltroOriginal;

  If (blnCdsFiltrado) Then
    cdsItens.Filtered := True;

  pEnableCdsItens();
end;

function TfrmFatExpedicaoItens.fContemPedidosEmpresaPrioridade: Boolean;
var
  objPedido: TPedidoVenda;
  intIndice: Integer;
begin
  Result := False;

  if FParams.stlPedidos.Count <= 0 then
    Exit;

  for intIndice := 0 to FParams.stlPedidos.Count - 1 do
  begin
    objPedido := TPedidoVenda(FParams.stlPedidos.Objects[intIndice]);

    if fCampoTabela('FGO_UPSEML', 'EXTGOR', ['FGO_SEQFGO'], [objPedido.strSeqGer], False) = 'S' then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

function TfrmFatExpedicaoItens.fControlarMontagemDeCaixaPorPedido: Boolean;
begin
  Result := False;

  If (Not fUsaMontagemCaixas) Then
    Exit;

  If (Not Assigned(objMontarCaixas)) Or (Not Assigned(objMontarCaixas.CaixaAberta)) Then
    Exit;

  If (FParams.stlPedidos.Count <= 1) Then
    Exit;

  If (fCfgSis('CSQCAI', varString) <> '2') Then
    Exit;

  Result := True;
end;

function TfrmFatExpedicaoItens.fQuantidadeDeEtiquetas: Integer;
  Var
    frmDigQtdEti: TfrmDigQtdEti;
begin
  Result := 0;
  pCriarFormularios(TfrmDigQtdEti, frmDigQtdEti);

  Try
    Try
      frmDigQtdEti.ShowModal;

      If frmDigQtdEti.blnConfirma Then
        Result := frmDigQtdEti.intQtdEti;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, 'pSolicitaQuantidadeDeEtiquetas');
    End;
  Finally
    pFreeAndNil(frmDigQtdEti);
  End;
end;

function TfrmFatExpedicaoItens.fSair: Boolean;
  Var
    intFoco: Integer;
begin
  intFoco := IIF(fCfgSis('FCSAEX', varString) = 'S', 1, 2);

  Result := (fMensagem('', 'Deseja sair?', ['&Sim', '&Não'], intFoco) = 1);
end;

procedure TfrmFatExpedicaoItens.pVinculaEtiquetaVolumeCompostoAosPedidos(stlPedidos: TStringList;
                                                                         strCodigoVolume: String);
var
  objPedido: TPedidoVenda;
  intContador: Integer;
begin
  If (Not Assigned(stlPedidos)) Then
    Exit;

  If (stlPedidos.Count <= 0) Then
    Exit;

  For intContador := 0 To PRed(stlPedidos.Count) Do
  Begin
    objPedido  := TPedidoVenda(stlPedidos.Objects[intContador]);

    pVinculaEtiquetaVolumeCompostoAoPedido(objPedido.strNumDoc,
                                           objPedido.strEspDoc,
                                           objPedido.strCodEmp,
                                           objPedido.strCodCli,
                                           strCodigoVolume);
  End;
end;

function TfrmFatExpedicaoItens.fCarregaEtiquetaVolumeCompostoPedidos(stlPedidos: TStringList;
                                                                     Var strCodVol: String): TUniQuery;
Var
  objPedido: TPedidoVenda;
  intContador: Integer;
begin
  Result := Nil;

  if (Not Assigned(stlPedidos)) then
    Exit;

  If (stlPedidos.Count <= 0) then
    Exit;

  strCodVol := EmptyStr;

  for intContador := 0 to stlPedidos.Count - 1 do
  begin
    objPedido  := TPedidoVenda(stlPedidos.Objects[intContador]);

    pCarregaEtiVolPedido(objPedido.strNumDoc,
                         objPedido.strEspDoc,
                         objPedido.strCodEmp,
                         objPedido.strCodCli,
                         strCodVol);
  end;

  Result := fCarregaEtiquetaVolumeComposto(strCodVol);
end;

function TfrmFatExpedicaoItens.fVaiCompararQuantidadeComColetor():Boolean;
begin
  Result := (FParams.blnUsaRotinaWMS) And
            (FParams.VS_strTipExpInterna = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) And
            (fCfgSis('CPQTCF') = COMPARAR_QTDSEP_COLETOR) And
            (cdsItens.FieldByName('QTDCOL').AsFloat > 0);
end;

function TfrmFatExpedicaoItens.fValidaQTDSEPWMS():Boolean;
begin
  Result := True;

  If FParams.blnUsaRotinaWMS Then
  Begin
    If Assigned(cdsItens.FindField('PEGOU_')) Then
    Begin
      If (cdsItens.FieldByName('PEGOU_').AsString = 'S') Then
        Exit;
    End;

    If (cdsItens.FieldByName('PROACA').AsString = 'S') Then
    Begin
      Exit;
    End;

    If (cdsItens.FieldByName('NUMLOT').AsString = 'A DEFINIR') Then
    Begin
      If fVaiCompararQuantidadeComColetor() Then
        Result := (cdsItens.FieldByName('QTDCOL').AsFloat > 0)
      Else
        Result := (cdsItens.FieldByName('QTDSEP').AsFloat > 0);
    End;
  End;
end;

procedure TfrmFatExpedicaoItens.pCarregarDadosItemEstrutura;
begin
  If (blnCarregandoDadosItemEstrutura) Then
    Exit;
  If Not pnlEstrutura.Visible Then
    Exit;
  blnCarregandoDadosItemEstrutura := True;
  Try
    If cdsDetMat.Active Then
      cdsDetMat.Close;
    cdsDetMat.qryQuery.ParamByName('CODITE').AsString := cdsItens.FieldByName('CODITE').AsString;
    cdsDetMat.fAbreClient(True, 'TfrmFatExpedicaoItens.cdsItensAfterScroll');
    cdsDetMat.AfterScroll := cdsDetMatAfterScroll;
    TFloatField(cdsDetMat.FieldByName('QTDITE')).DisplayFormat := '#,##0.00';
  Finally
    blnCarregandoDadosItemEstrutura := False;
  End;
end;

function TfrmFatExpedicaoItens.fValidouObjetosDaConfirmacao : Boolean;
begin
  Result := False;
  If Not Assigned(FParams) Then
    Exit;
  If Not Assigned(FParams.stlPedidos) Then
    Exit;
  If Not Assigned(FParams.stlListaClientes) Then
    Exit;
  If Not Assigned(FParams.stlListaGrupos) Then
    Exit;
  If (FParams.VS_strTipExpInterna <> TIPEXP_POR_DOCUMENTO_DE_VENDA) And
     (Not Assigned(FParams.qryFatGor)) Then
    Exit;
  Result := True;
end;

End.
