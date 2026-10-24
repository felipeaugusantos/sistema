{***************************}
{* qryConOpe -> CADOPE     *}
{************************JB*}
unit untGarantiaRecCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Menus, Buttons, ExtCtrls, Grids, untZClient,
  DBGridCitel, DBGrids, Mask, MaskEditFocus, DB, UniClientDataSet, StrUtils, Uni, untGarant, Math,
  AppEvnts, BitBtnLockedIncrem, untFuncFat, untFuncoesSimples, untCadLote,
  cxProgressBar, untTypesSistema, frxClass, frxExportCSVTestabilidade, frxDBSet,
  Datasnap.DBClient, untLiberacao, untMsgLiberacao, System.Generics.Collections,
  untFuncFatTypes,
  untAuditoriaGravacaoSaldo;

Type
  {$SCOPEDENUMS ON}
  TOperacaoGarantia = (ogNaoDefinido = -1, ogReposicao, ogCredito);
  {$SCOPEDENUMS OFF}

  TNotifyEventCheckBox = procedure(pSender: TObject; Var pblnValor: Boolean) of object;

  TCheckBox = Class(StdCtrls.TCheckBox)
  private
    FAntesMarcar: TNotifyEventCheckBox;
  protected
    procedure SetChecked(Value: Boolean); override;
    procedure Click;override;
  public
    property AntesMarcar: TNotifyEventCheckBox Read FAntesMarcar Write FAntesMarcar;
  end;

  TArrCheckBox = Array[0..1] of TCheckBox;

  TModoGarantia = class
  private
    FArrCheckBox: TArrCheckBox;
    procedure pAntesMarcar(pSender: TObject; Var pblnValor: Boolean);
    procedure pDesmarcarChkIrmaos(pCheckBox: TCheckBox);
  public
    procedure pLimparSelecao;
    procedure pSetCheckBox(pOperacaoGarantia: TOperacaoGarantia; pValue: TCheckBox);
    function fSelecionado: TOperacaoGarantia;
  end;

  TRecParGravaCADREC = Record
    strCodCli,
    strNomFrmLogCtr,
    strNumDup,
    strEspecie,
    strCodVen,
    strCodDig,
    strCodPor,
    Historico1,
    Historico2,
    strIncGer: String;
    pdtaDtaCad: TDateTime;
    fltValDup: Double;
    procedure pInicializar;
    constructor Create(pstrNumDup: String);
  end;

  {$SCOPEDENUMS ON}
  TTipoGarantia = (Padrao, IndustriaProprio, IndustriaRevenda);
  {$SCOPEDENUMS OFF}
  {$SCOPEDENUMS ON}
  TRespSelecaoDocumento = (Selecionado, NaoSelecionado, NaoEncontrado);
  {$SCOPEDENUMS OFF}

Type
 TTipoGarantiaHelper = record helper for TTipoGarantia
    function fEhGarantiaIndustria: Boolean;
    function fEhGarantiaIndustriaBoolAsString: String;
 end;
{$Region 'Record - Item Sistema anterior'}
  TItemSemDocumento = class
  Public
    strCodIte: String;
    strDesIte: String;
    strUnidade: String;
    fltQtdIte: Double;
    strCodFab: String;
  End;

  TListaItensSemDocumento = TObjectList<TItemSemDocumento>;

{$Endregion}

  TPessoaRec = Record
    strCodigo,
    strNome: String;
  end;

  TPessoasOperacaoRec = Record
    recVendedor,
    recDigitador: TPessoaRec;
  End;


Type
  TLiberacaoVariacaoCredito = Class
  private
    CONST DIREITO_ACESSO_LIBERACAO_CREDITO_SEM_DOCUMENTO: String = 'GPCSDV';
  public
    class function fLiberar(pstrCodCli, pstrNomCli, pstrCodOpe, pstrDigOpe: String; pfltValorCredito: Double): Boolean;
  end;

type
  TRecDocumentoVenda = record
    strTabela: String;
    strCodIte: String;
    strSeqDoc: String;
    strNumDoc: String;
    strEmpDoc: String;
    strCodVenOri: String;
    fltDispon: Double;
    fltQtdIte: Double;
    fltValIte: Double;
    fltDesAceD: Double;
    strDocFat: String;
    strIncOri: String;
    strDataVenda: String;
    Det_EspDoc: String;
    Det_NumDoc: String;
    fltQtdSel: Double;
    fltUniCrd: Double;
    fltDET_UNITAR,
    fltDET_DESESP,
    fltDET_DESCFF: Double;
    procedure pInicializar;
    constructor Create(pStrCodIte: String);
  end;

Type
  TTipoMov = (tmEntrada, tmSaida);

type
  TRecDados = Record
    strCodVen,
    strCodCli,
    strCodIte: String;
    fltQteIte: Double;
  End;

  TRecDocGarantia = Record
  private
    FstrAutoincrem,
    FstrNumDoc,
    FstrEspDoc,
    FstrCodCli,
    FstrCodEmp,
    FstrSerie_,
    FstrTip_FC: String;
    procedure pInicialiar;
  public
    constructor pDefinir(pstrNumDoc: String; pstrEspDoc: String = '';
      pstrCodEmp: String = ''; pstrCodCli: String = ''; pstrSerie_: String = ''; pstrTip_FC: String = 'C');
    function fAsString: String;
    property strNumDoc: String Read FstrNumDoc;
    property strEspDoc: String Read FstrEspDoc;
    property strCodCli: String Read FstrCodCli;
    property strCodEmp: String Read FstrCodEmp;
    property strSerie_: String Read FstrSerie_;
    property strTip_FC: String Read FstrTip_FC;
    property strAutoincrem: String Read FstrAutoincrem Write FstrAutoincrem;
  end;


  TfrmGarantiaRecCliente = class(TfrmPai)
    pnlGarantia: TPanel;
    edtSenVen: TEditFocus;
    edtNomVen: TEditFocus;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    pnlProdutos: TPanel;
    mskDtaEnt: TMaskEditFocus;
    dtsItens: TDataSource;
    cdsItens: TUniClientDataSet;
    cdsItensNUMENT: TStringField;
    cdsItensDTAENT: TDateTimeField;
    cdsItensCODVEN: TStringField;
    cdsItensCODCLI: TStringField;
    cdsItensCODFOR: TStringField;
    cdsItensCODITE: TStringField;
    cdsItensDESITE: TStringField;
    cdsItensNUMDOC: TStringField;
    cdsItensQTDITE: TFloatField;
    cdsItensVALITE: TFloatField;
    cdsItensREPOST: TStringField;
    cdsItensREFERE: TStringField;
    cdsItensDESUNI: TStringField;
    cdsItensOBSP_1: TStringField;
    cdsItensOBSP_2: TStringField;
    cdsItensAUTINC: TStringField;
    dbgItens: TDBGridCitel;
    cdsItensQTDDEV: TFloatField;
    cdsItensDTAENV: TDateTimeField;
    cdsItensJA_GRAVADO: TStringField;
    cdsItensEMPDOC: TStringField;
    btnConfirmar: TBitBtnLocked;
    cdsItensCODFAB: TStringField;
    cdsItensPRECUS: TFloatField;
    cdsItensTABPRE: TStringField;
    cdsItensNUMLOT: TStringField;
    cdsItensGARFIL: TStringField;
    frxReportEti: TfrxReport;
    frxDadosEti: TfrxDBDataset;
    cdsItensDESACE: TFloatField;
    btnImportarXML: TBitBtnLocked;
    btnNotEle: TBitBtnLocked;
    chkReposicao: TCheckBox;
    chkCredito: TCheckBox;
    cdsItensLOTSAI: TStringField;
    mskPlaVei: TMaskEditFocus;
    lblPlaVei: TLabel;
    cdsItensDOCFAT: TStringField;
    cdsItensINCORI: TStringField;
    cdsItensSEQDOC: TStringField;
    pnlFavorecidoCredito: TPanel;
    lblNomeFavorecido: TLabel;
    edtFavorecido: TEditFocus;
    edtNomeFavorecido: TEditFocus;
    pnlProdutoPrincipal: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    lblNumLot: TLabel;
    edtCodIte: TEditFocus;
    edtReferencia: TEditFocus;
    edtDesUni: TEditFocus;
    edtDesIte: TEditFocus;
    edtQtdIte: TEditFocus;
    edtObsP_2: TEditFocus;
    edtObsP_1: TEditFocus;
    btnCancelar: TBitBtnLocked;
    btnAdicionar: TBitBtnLocked;
    edtNumLot: TEditFocus;
    lblIndGarantiaPropriaEmpresa: TLabel;
    btnInformarLoteItem: TBitBtnLocked;
    cdsItensITE_CODATC: TStringField;
    btnAssistenciaTecnica: TBitBtnLocked;
    cdsItensUNICRD: TFloatField;
    pnlVlrCredito: TPanel;
    edtUniCrd: TEditFocus;
    lblVlrCredito: TLabel;
    cdsItensUNICRDORI: TFloatField;
    cdsItensDET_UNITAR: TFloatField;
    cdsItensDET_DESESP: TFloatField;
    cdsItensDET_DESCFF: TFloatField;
    cdsItensDESCONTOS: TFloatField;
    cdsItensTOTLIQ: TFloatField;
    cdsItensTOTITE: TFloatField;
    cdsItensBXSBIT: TStringField;
    cdsItensTABELA: TStringField;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure   FormCreate(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteExit(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure cdsItensREPOSTGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgItensKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dbgItensCellClick(Column: TColumn);
    procedure btnImportarXMLClick(Sender: TObject);
    procedure btnNotEleClick(Sender: TObject);
    procedure chkReposicaoClick(Sender: TObject);
    procedure edtNumLotKeyPress(Sender: TObject; var Key: Char);

    procedure edtFavorecidoKeyPress(Sender: TObject; var Key: Char);
    procedure edtFavorecidoExit(Sender: TObject);
    procedure chkCreditoClick(Sender: TObject);
    procedure cdsItensAfterDelete(DataSet: TDataSet);
    procedure cdsItensBeforePost(DataSet: TDataSet);
    procedure cdsItensBeforeDelete(DataSet: TDataSet);
    procedure btnInformarLoteItemClick(Sender: TObject);
    procedure ValidarLoteSaidaSelecionado(Sender: TField);
    procedure cdsItensAfterPost(DataSet: TDataSet);
    procedure cdsItensAfterCancel(DataSet: TDataSet);
    procedure cdsItensBeforeInsert(DataSet: TDataSet);
    procedure btnAssistenciaTecnicaClick(Sender: TObject);
    procedure edtUniCrdExit(Sender: TObject);
    procedure dbgItensDblClick(Sender: TObject);
    procedure cdsItensNewRecord(DataSet: TDataSet);

  private
    { Private declarations }
    FblnEspDev: Boolean;
    FPerguntarAplicarVendedorTodosItens: Boolean;
    FblnTemItemBaixarEstrutura: Boolean;
    FblnBaixaEstrutura: Boolean;
    FblnCarrergarEstrutura: Boolean;
    FModoGarantia: TModoGarantia;
    FfltVariacaoCredito: Double;

    FEditandoItem,
    FHabilitarDigitarValorCredito,
    FHabilitarLimiteCredito: Boolean;
    FRecDocGarantia,
    FRecDocReposicao: TRecDocGarantia;

    blnRefEnt: Boolean;
    strNumRet: String;
    qryConOpe: TUniQuery;
    qryAD    : TUniQuery;
    strSeqGerNE : String;

    objMovGag : TMovGag;

    recDadSav: TRecDados;
    fatVenda : TFatVenda;
    fatVenda2: TFatVenda;
    cdsGroup : TUniClientDataSet;
    qryItePed: TUniQuery;
    strClaFisEnt: String;
    strClaFisSub: String;
    strCliEst   : String;

    strNomPro: String;
    strRefere: String;
    strMarca : String;
    strUnidad: String;
    strCodVen: String;

    strDocsSelCRM,
    strCodVenCRM,
    strCodRepCRM,
    strCodCliCRM: String;

    strItensExcluidos : String;
    strAutIncExcluidos: String;

    strSeqDoc,
    strNumDoc: String;
    strTabela: String;
    strEmpDoc: String;
    strCodVenOri: String;
    strCodVenDig: String;
    strIncOri: String;
    strDocFat: String;
    strDataVenda: String;
    fltDispon: Double;
    fltQtdIte: Double;
    fltValIte: Double;
    fltUniCrd,
    fltDetUnitar,
    fltDetDesEsp,
    fltDetDesCFF,
    fltUniCrdOri: Double;
    strNumLote: String;

    blnLerCodigoBarras: Boolean;

    objCadLot : TCadLot;

    strAutIncE,
    strAutIncDetE,
    strAutInc,
    strAutIncS,
    strObs1,
    strObs2: String;
    strEspDocAnt : String;
    fltTotCre    : Double;
    fltTotPro    : Double;
    blnLanCre    : Boolean;
    blnGarSep    : Boolean;
    strPortad    : String;
    strNumDup    : String;
    strCodCliCre : String;

    FstrNumRetornoCliente: String;
    FListaItensSemDocumento: TListaItensSemDocumento;

    blnEmpGar: Boolean;
    blnGeraCreditoNoRecebimento : Boolean;

    cdsAdeDet : TZClient;
    blnReabreAD : Boolean;
    blnTemST : Boolean;
    blnClienteFilial: Boolean;

    fltDesAceD, //despesa acessoria do item
    fltDesAce: Double;

    recNotEle: TRecInfoNotaEletronica;
    blnResEdtCodIteExit : Boolean;

    objLiberacao : TLiberacao;

    strCodCliAnt : String;

    blnCFG_GARIND: Boolean; //PERMITE MODO GARANTIA INDÚSTIAS
    blnCFG_RCFECF: Boolean; //Forçar exibir cliente favorecido quando informado cliente filial
    blnInformarEntregaRetiraGC: Boolean;
    FEntregaRetira: TReposicaoEntregaRetira;
    FenuTipoGarantia: TTipoGarantia;
    strFornecedorFilial: String;

    blnUtilizaChecklistGarantia: Boolean;
    blnPermitirLiberarSemNotaVenda: Boolean;
    blnSolicitarLiberacaoItemSemNotaVenda: Boolean;
    blnImportandoXML : Boolean;
    blnHabilitarOpcaoReposicao : Boolean;
    blnLiberouADComSenha : Boolean;
    blnInfCli: Boolean;
    FCarregarFreteImportarXML: Boolean;
    blnUtiAd: Boolean;
    intQtdCasasDecimaisValorUnitario: Integer;
    blnPermiteInserirItens: boolean;
    arrDocumentosVendas: array of TRecDocumentoVenda;
    recPessoasOperacao: TPessoasOperacaoRec;

    objAuditoriaSaldo: IAuditoriaGravacaoSaldo;

    function fRetQtdDigitada: Double;
    procedure pEstornarEntrada(pRecDocEntrada: TRecDocGarantia);
    function fVerificaQtdEstoque(fltQuantidade: Double; Out pblnBXSBIT: Boolean): Boolean;
    function fRetornaSaldoProduto(strCodIte, strNumLot: String): Double;
    function fAlterouDados: Boolean;
    function fGravaEntradaEstoque(strAutInc, strAutIncDet:String; pgbStatus: TcxProgressBar = nil):Boolean;
    function fGravaSaidaEstoque(strAutInc, strAutIncDet:String; pgbStatus: TcxProgressBar = nil):Boolean;
    function fRetSequencialReposicao: String;
    function fAtuSequencial(strValor: String): Boolean;
    function fGravaCreditoCliente(strNumDup, strCodCli, strCodVen, strCodDig, strPortad, strAutIncGer: String; fltValDup: Double): Boolean;
    function fRetTotalCreditoCliente(out blnTemVarCrd: Boolean): Double;
    procedure pGeraLogRepProcessoUtilizado(strProcesso: String; strAutInc: String);

    procedure pLimpaEdits(blnGarantia: Boolean = False; blnProdutos: Boolean = False);
    procedure pCarregaDocVendas(qryTmp: TUniQuery; cdsTmp: TUniClientDataSet);
    procedure pCarregaItensAlteracao(pHabilitarEdicao: Boolean);
    procedure pLimpaDados;
    procedure pHabilitaOBS;
    procedure pHabilitaForm(blnStatus: Boolean);
    procedure pHabilitaBotoes(DataSet: TDataSet);
    function fRetCodItem(strCodIte: String): String;
    function fDigDadosConsumidor(cdsTmp: TUniClientDataSet; blnCarregaTela: Boolean): Boolean;overload;
    function fDigDadosConsumidor(const strNumDoc, strEspDoc, strCodEmp: String; blnCarregaTela: Boolean): Boolean;overload;
    function fExisteDocNaoFiscal: Boolean;

    function fIncluiItens(fatVenda: TFatVenda; strRepos: String; pblnSomenteBXSBIT: Boolean = False): Boolean;
    function fGetTipoFaturamento(fatVendaP: TFatVenda; tmEntSai: TTipoMov): Boolean;
    function fGetCfopRecCliente(fatVendaP: TFatVenda; blnFaturamento: Boolean; tmEntSai: TTipoMov): Boolean;
    procedure pInicializaTemporaria;

    procedure pCreateFatVendas;
    procedure pCarregaDadosFatVendas;
    procedure pDestroyFatVendas;

    function fOutrasEntradasFaturamento: Boolean;
    function fEntradaNF(strNumEnt: String): Boolean;
    function fOutrasSaidasFaturamento: Boolean;

    function fGravaArquivos(objfatVenda : TFatVenda): Boolean;

    function fVerificaLoteProduto(var strNumLot: String): Boolean;
    Function fGravaEntradaGA(pgbStatus: TcxProgressBar = Nil): Boolean;
    Function fGravaSaidaGA(pgbStatus: TcxProgressBar = Nil): Boolean;

    procedure pInfoStatusGravacao(strInformacao: String; pgbProgresso: TcxProgressBar);
    procedure pStepStatusGravacao(pgbProgresso: TcxProgressBar);

    function fDigitaObs:Boolean;
    function fDigitaObsItem:Boolean;

    function fTrataRecebimentoCliente:Boolean;
    function fSeDerFalhaMasGravouAEntrada(const pstrAutIncGAG: String; var pRecDocGarantia: TRecDocGarantia): Boolean;
    function fGetVlrConNE(strAutInc: String): Double;
    function fTrataReposicaoCliente:Boolean;
    function fGravaPedidoEmpresaMatriz: Boolean;
    function fGerarPedidoEmpGarComGarPes: Boolean;
    procedure pImprimeEtiqueta;
    function fGetSqlItemEtiqueta(strCodIte: String; intQtdIte: Integer;
                                 strDtaEnt: String = '';
                                 strNumGar: String = '';
                                 strObser1: String = '';
                                 strObser2: String = '';
                                 strCodCli: String = '';
                                 strCodFor: String = ''): String;
    procedure pGravaADE;
    procedure pCarregaNFEXML;
    procedure pCarregaItensXML;
    function fQtdFornecedoresItem(strCodIte: String): Integer;
    function fRetPrecoTE(strCodIte : String) : Double;
    function fDescricaoCampoRetPrecoTE: String;
    procedure pAjustaLoteSaida;
    procedure pMarcarReposicao(blnReposto: Boolean);
    function fVerificaLotes : Boolean;
    function fVaiUtilizarAD: Boolean;
    function fEspeciePermitidaDevolucao: Boolean;
    function fValidaDevolucaoEmpresa: Boolean;
    procedure pExibirFavorecido(blnVisivel: Boolean = True);
    function fExigirFavorecido(Const strCodCliente, strNomeCliente: String; blnCredito: Boolean; blnFaturamentoEmiteNF: Boolean = False): Boolean;
    function fValidarFavorecido: Boolean;
    function fObterLiberacaoCredito(Out blnDuplicataLiberada: boolean): Boolean;

    function fClienteValidoParaCreditoOuNotaFiscal(const strCodCli: String; strNomCli: String = ''; blnFaturamentoEmiteNF: Boolean = False): Boolean;
    
    procedure pSetTipoGarantia(Value: TTipoGarantia);
    procedure pCarregarCFGs;
    function fPermitirInserirItemDofornecedorParaTipoGarantia(const strCodFor: String): Boolean;
    procedure pMensagemNaoPermitirItemFornecedorTipoGarantia;
    function fObterTipoGarantia(const strCodFor, strForFil: String): TTipoGarantia;
    function fLiberarInserirItemSemDocumentoVenda: Boolean;
    procedure pAddItemListaSemDocumento(const strCodIte, strDesIte, strUnidade, strCodFab: String; fltQtdIte: double);
    procedure pRemoverItemListaSemDocumento(const strCodIte: String; fltQtdIte: double);
    function fLocalizarItemListaSemDocumento(const strCodIte: string): Integer;
    function fCriarLinhaMsgLiberacaoItemSemDocumentoVenda(const aItem: TItemSemDocumento): String;overload;
    function fCriarLinhaMsgLiberacaoItemSemDocumentoVenda(blnTitulo: Boolean = True; strCodIte: String = ''; strDesIte: String = '';
        strUnidade: String = ''; strQtdIte: String = ''; strCodFab: String = ''): String;overload;
    function fPermitirItemSemDocumentoVenda: Boolean;
    function fLiberarRecebimentoClienteFilial(const blnProdutoComDefeito: Boolean): Boolean;
    function fSelecionarDocumentoVenda(const strCodAde, strCodCli, strNomCli, strCodIte, strDesIte,
              strDesUni, strPlaVei: String): TRespSelecaoDocumento;
    procedure pSelecionarDocumentoItem;

    function fValidarAoConfirmarRecebiemento: Boolean;
    function fEntraConsultaDocumento(var chrKey: Char): Boolean;
    function fObterVendedorOperacao: String;
    procedure pSelecionarLote;
    procedure pLimparClienteMovGag;
    {$Region 'arrDocumentosVendas'}
    function fAdicionarNovoDocumentoVenda: Integer;
    procedure pInicializarArrDocumentosVendas;
    procedure pReceberDocumentoSelecionado(pstrTabela, pstrCodIte, strSeqDoc, strNumDoc, strEmpDoc, strCodVenOri, strDocFat, strIncOri,strDataVenda,
      strEspDocDet, strNumDocDet: String; const fltDispon, fltQtdIte, fltValIte, fltDesAceD, fltQtdSel, pfltUniCrd,
      pfltDET_UNITAR, pfltDET_DESESP, pfltDET_DESCFF: Double);
    function fTemDocumentoVendaSelecionado: Boolean;
    function fValidarQuantidadeSelecionada(const fltQtdIte: Double): Boolean;
    {$Endregion}
    procedure pConfigurarUtilizaCheckList;
    function fExibirEdtUniCrd: Boolean;
    procedure pExibirEdtUniCrd;overload;
    procedure pExibirEdtUniCrd(blnVisible: Boolean);overload;
    procedure pSetValorUniCrd(pfltUniCrd: Double);overload;
    procedure pSetValorUniCrd(pfltUniCrdOri, pfltUniCrd: Double);overload;
    procedure pSetSolicitarLiberacaoItemSemNotaVenda(blnValue: Boolean);
    function fImportouXml: Boolean;
    procedure pDefinirPessoasOperacao;
    procedure pIncluirOcorrenciaCRM;
    function fGerarOrdProItensEstrutura(var item: TDadosFechamento): Boolean;
    procedure pVerificarTemItemBaixarEstrutura;
    function fDefinirVendedorItemGarantia(const pstrCodVen: String): String;
    function fAntesConfirmarEntrada(Sender: TObject; pstrAutInc: String): Boolean;
    procedure pAdicionarChavesReferenciadas(const pcdsItens: TDataSet;
                                            const pfatVenda: TFatVenda);
  public
    procedure pRecebeItemNaoLiberado(Const strCodIte, strNumDoc, strSeqDoc: String);
    { Public declarations }

  protected

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pEscapePressed; override;
    function fValidarVariacaoCredito(pfltUniCrd: Double; Out pstrMsgResult: String): Boolean;

  public //class
    class function fGravaCreditoClienteExec(pRecParGravaCADREC: TRecParGravaCADREC; Out pstrAutInc: String): Boolean;

  end;

implementation

uses untLibCancelamentoDocumentosGarantia,
     untController.CheckListGarantia,
     untEntDadosFiscaisResumo,
     untFuncoes, untConsultas, untPesqAux, untListaDocsGarantia,
     untMovGer, untCadIte, untCadRec, untDigCliente, untFuncoesConsulta,
     untFatDadosCliConsumidor, untFatDigDadosGarantia, untFatDadosFiscais,
     untGravando,untEntMercadorias, untObsGarantia,
     untControleChavesGarantia,
     untOrdPro,
     untDigOperador,
     untFuncoesRel, untFuncoesRel2, untFatGor, TypesRel, untCfgRel, untFuncoesEtiquetas,
     untEntSelItensDevolucao, untFuncoesCRM, untAtualizaOcorrenciasCRM,
     untTestabilidade, untConstantes, untEntImportacaoNotaEletronica, untFuncoesGenerica,
     untTipoEntregaRetiraExpedicao, Garantia.TfrmValidacaoEspelhoXMLView,
     Faturamento.Devolucao.TNotaDevolucaoPessoaJuridica,
     untGarantiaRecCliente.LiberacaoCredito, untFatTipoFaturamento, untGarantiaLibDiversos,
     untFatImpressao, untTCRMGarantia;

{$R *.dfm}



function TfrmGarantiaRecCliente.fAdicionarNovoDocumentoVenda: Integer;
begin
  //Adiciona um novo documento de vendas ao array de documentos de vendas e retorna o indice;
  SetLength(arrDocumentosVendas, length(arrDocumentosVendas)+1);
  Result := Length(arrDocumentosVendas)-1;
end;

function TfrmGarantiaRecCliente.fAlterouDados: Boolean;
Begin
  Result := (Not SameText(recDadSav.strCodVen,strCodVen)) Or
            (Not SameText(recDadSav.strCodCli,edtCodCli.Text)) Or
//            (Not SameText(recDadSav.strCodFor,edtCodFor.Text)) Or
            (Not SameText(recDadSav.strCodIte,fRetCodItem(edtCodIte.Text))) Or
            (RoundTo(recDadSav.fltQteIte,-2) <> RoundTo(fStrToFloat(edtQtdIte.Text),-2));
End;

function TfrmGarantiaRecCliente.fAntesConfirmarEntrada(Sender: TObject;
  pstrAutInc: String): Boolean;
Var
  strCodVenCredito: String;
  lEntDadosFiscaisResumo: TfrmEntDadosFiscaisResumo absolute Sender;
begin

  Result := True;

  {**********************************************}
  {* REALIZA GRAVAÇÃO DE CRÉDITO PARA O CLIENTE *}
  {*******************************************PZ*}
  if (fltTotCre > 0) And (blnLanCre) And blnGeraCreditoNoRecebimento  then
  begin
    if (Not objMovGag.fCreditoGerado) then
    begin
      {********************************}
      {* GRAVA CRÉDITO PARA O CLIENTE *}
      {*****************************PZ*}

      if Sender is TfrmEntDadosFiscaisResumo then
        strNumRet := lEntDadosFiscaisResumo.strNumDoc;

      strCodVenCredito := fObterVendedorOperacao;
      If fatVenda.strEspDoc = 'NF' Then
        fltTotCre :=  fatVenda.fltTotGer
      Else If fatVenda.strEspDoc = 'NE' Then
        fltTotCre :=  fGetVlrConNE(pstrAutInc);

      Result := fGravaCreditoCliente(strNumDup,
                                     objMovGag.strCodFav,
                                     strCodVenCredito,
                                     strLoginUsuarioLogado,
                                     strPortad,
                                     '',
                                     fltTotCre);
    end;

    if Result then
      Result := objMovGag.fVincularGarantiaACADREC(pstrAutInc, objMovGag.strIncCTR);


    if Not Result then
    begin
      fMensagem('ATENÇÃO!', 'O crédito da garantia não foi gerado. Tente repetir o processo ' +
                            'e se não conseguir, entre em contato com a Citel!', ['&OK']);

    end;
  end;

end;

function TfrmGarantiaRecCliente.fAtuSequencial(strValor: String): Boolean;
  Var
    strSQL   : String;
    qryGenCfg: TUniQuery;
begin
  Try

    Result := True;

    qryGenCfg := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  CFGSIS ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '   SIS_VALCFG = :VALOR ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   SIS_CODCFG = ' + QuotedStr('CFG_PROGEC') + ' AND ';
    strSQL := strSQL + '   SIS_CODEMP = ' + QuotedStr(VS_strCodEmp);

    Try
      With qryGenCfg Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('VALOR').AsString  := strValor;
        ExecSQL;
        Close;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
      End;
    End;

  Finally
    FreeAndNil(qryGenCfg);
  End;

end;

procedure TfrmGarantiaRecCliente.pExibirEdtUniCrd;
begin
  pExibirEdtUniCrd(fExibirEdtUniCrd);
end;

procedure TfrmGarantiaRecCliente.pExibirEdtUniCrd(blnVisible: Boolean);
begin
  if pnlVlrCredito.Visible = blnVisible then
    Exit;

  pnlVlrCredito.Visible := blnVisible;

  if pnlVlrCredito.Visible then
    pnlProdutos.Height := pnlProdutos.Height + pnlVlrCredito.Height
  else
    pnlProdutos.Height := pnlProdutos.Height - pnlVlrCredito.Height ;

end;

procedure TfrmGarantiaRecCliente.pExibirFavorecido(blnVisivel: Boolean = True);
Const
  ALTURA: Integer = 26;
{$Region 'Métodos locais'}
  procedure LimparCampos;
  begin
    edtFavorecido.text := EmptyStr;
    edtNomeFavorecido.text := EmptyStr;
  end;
  procedure ExibirFilhos;
  begin
    edtFavorecido.Visible := pnlFavorecidoCredito.Visible;
    edtNomeFavorecido.Visible := pnlFavorecidoCredito.Visible;
    lblNomeFavorecido.Visible := pnlFavorecidoCredito.Visible;
  end;
  procedure pMostrarFavorecido;
  begin
    with pnlFavorecidoCredito do
    begin
      Parent.Height := Parent.Height + ALTURA;
      Visible := True;
    end;
  end;
  procedure pOcultarFavorecido;
  begin
    With pnlFavorecidoCredito do
    begin
      Parent.Height := Parent.Height - ALTURA;
      Visible := False;
      LimparCampos;
    end;
  end;
{$Endregion}
  Var
    blnExibir: boolean;
begin
  blnExibir := False;

  if  blnInfCli then
  begin
    if Not fClienteValidoParaCreditoOuNotaFiscal(edtCodCli.Text,  edtNomCli.Text) then
      blnExibir :=  True;
  end;

  if blnExibir and (blnVisivel) then
  begin
    if Not pnlFavorecidoCredito.Visible then
    begin
      pMostrarFavorecido;
      ExibirFilhos;
    end;
  end
  else
  begin
    if pnlFavorecidoCredito.Visible then
    begin
      pOcultarFavorecido;
      ExibirFilhos;
    end;
  end;
  pExibirEdtUniCrd;
end;


function TfrmGarantiaRecCliente.fExibirEdtUniCrd: Boolean;
begin
  Result := (blnGeraCreditoNoRecebimento and chkCredito.checked) or (Not blnGeraCreditoNoRecebimento);
  Result := Result and FHabilitarDigitarValorCredito;
  Result := Result and blnSolicitarLiberacaoItemSemNotaVenda;
end;

function TfrmGarantiaRecCliente.fExigirFavorecido(const strCodCliente, strNomeCliente: String; blnCredito: Boolean; blnFaturamentoEmiteNF: Boolean): Boolean;
Var
  blnClienteInvalido: Boolean;
  blnLiberarCreditoFuturo: Boolean;
begin
  blnLiberarCreditoFuturo := (chkReposicao.Checked = False) and (blnGeraCreditoNoRecebimento = False);

  if Not blnInfCli then
    Exit(False);

  if blnCredito xor  (blnLiberarCreditoFuturo and (blnFaturamentoEmiteNF = False)) then
    blnClienteInvalido := Not fClienteValidoParaCreditoOuNotaFiscal(strCodCliente, strNomeCliente)
  else
  begin
    blnClienteInvalido := Not fClienteValidoParaCreditoOuNotaFiscal(strCodCliente, strNomeCliente, blnFaturamentoEmiteNF);
  end;

  Result :=  blnCredito or blnLiberarCreditoFuturo or blnFaturamentoEmiteNF;
  Result := Result and blnClienteInvalido;
end;



function TfrmGarantiaRecCliente.fDefinirVendedorItemGarantia(
  const pstrCodVen: String): String;
Var
  i: integer;
begin
  if fEmptyStr(pstrCodVen) then
  begin
    Result := TfrmDigOperador.fGetCodOperador('', 'Informe o vendedor do item');
    if fEmptystr(Result) then
    begin
     i :=  fMensagem('',
                     'É necessário informar o vendedor do item. Escolha uma das opções:',
                     ['Selecionar o vendedor', 'Vendedor do recebimento', 'Cancelar'],
                     1,
                     True,
                     1 ,
                     200,
                     False,
                     0,
                     False,
                     False,
                     True,
                     0,
                     800);

      case i of
        1: Result := fDefinirVendedorItemGarantia(pstrCodVen);
        2: Result := edtSenVen.Text;
      else
         Abort;
      end;
    end;
  end
  else
    Result := pstrCodVen;
end;

function TfrmGarantiaRecCliente.fDescricaoCampoRetPrecoTE: String;
Var
   strCampo: String;
Begin

  strCampo := fCfgSis('TEPREV', varString);

  If strCampo = 'CUS' Then
    Result := 'Preço de Custo'

  Else If strCampo = 'ULT' Then
    Result := 'Preço de Última Compra'

  Else If strCampo = 'IMP' Then
    Result := 'Preço de Última Compra + Impostos'

  Else If strCampo = 'MED' Then
    Result := 'Preço Médio'

  Else If LeftStr(strCampo, 2) = 'VE' Then
    Result := 'Preço de Venda ' + RightStr(strCampo, 1);
End;

function TfrmGarantiaRecCliente.fDigDadosConsumidor(cdsTmp: TUniClientDataSet; blnCarregaTela: Boolean): Boolean;
begin
  if Assigned(cdsTmp) then
  begin
    Result := fDigDadosConsumidor(cdsTmp.FieldByName('DET_NUMDOC').AsString, cdsTmp.FieldByName('DET_ESPDOC').AsString,
          cdsTmp.FieldByName('EMPDOC').AsString,blnCarregaTela);
  end
  else
    Result := fDigDadosConsumidor('', '', '',blnCarregaTela);
end;

function TfrmGarantiaRecCliente.fEntraConsultaDocumento(var chrKey: Char): Boolean;
begin
  if fEntraCons(chrKey) then
    Result := blnPermitirLiberarSemNotaVenda and (Not cdsItens.IsEmpty) and (Not fVaiUtilizarAD)
  else
    Result := False;

  if Result then
    chrKey := #0;
end;

function TfrmGarantiaRecCliente.fEntradaNF(strNumEnt: String): Boolean;
  Var
    strOrdIte,
    strCodCli: String;
    frmEntMercadorias : TfrmEntMercadorias;
begin
  Result := True;

  If (objMovGag.strCodCli <> objMovGag.strCodFav) And (Not fEmptyStr(objMovGag.strCodFav))  Then
    strCodCli := objMovGag.strCodFav
  Else
    strCodCli := objMovGag.strCodCli;


  If Result And ((not fEmptyStr(recNotEle.strAutInc)) or fCarregaItensGarantia(VS_strCodEmp,qryItePed,True,strNumEnt, False, strClaFisEnt)) Then
  Begin
    Try
      pCriarFormularios(TfrmEntMercadorias, frmEntMercadorias);
      frmEntMercadorias.recNotEle      := recNotEle;
      frmEntMercadorias.strClaFisGar   := strClaFisEnt;
      if FCarregarFreteImportarXML Then
        frmEntMercadorias.fltValFre      := recNotEle.fltValFre;
      frmEntMercadorias.strClaFisSub   := strClaFisSub;
      frmEntMercadorias.qryItePed      := qryItePed;
      frmEntMercadorias.blnSemInc      := False;
      frmEntMercadorias.strCodFor      := strCodCli;
      frmEntMercadorias.strOrdIte      := strOrdIte;
      frmEntMercadorias.blnRecCliGarantia := True;
      frmEntMercadorias.blnRecCliGarantiaComGeracaoDeCredito := chkCredito.Checked;
      frmEntMercadorias.blnPrecoPraticado := True;
      frmEntMercadorias.cdsMovGad      := cdsItens;
      frmEntMercadorias.edtEspDoc.Text := 'NF';
      frmEntMercadorias.fAoConfirmarEntrada := fAntesConfirmarEntrada;
      frmEntMercadorias.ShowModal;

      Result    := frmEntMercadorias.blnConfirma;
      strNumRet := frmEntMercadorias.strNumDoc;
      strSeqGerNE  := frmEntMercadorias.strSeqGer;

      If Result And fVaiUtilizarAD Then
        pMarcaDocumentoDevAD(qryAD.FieldByName('GER_CODADE').AsString, VS_strCodEmp, frmEntMercadorias.strNumDoc, 'NF', VS_strCodEmp);
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmGarantiaRecCliente.fEntradaNF]');
      End;
    End;
    pFreeAndNil(frmEntMercadorias);
  End;
end;

function TfrmGarantiaRecCliente.fExisteDocNaoFiscal: Boolean;
  Var
    bkmMarca: TBookmark;
    intTam: Integer;
begin
  Result := False;

  With cdsItens Do
  Begin
    bkmMarca := GetBookmark;
    DisableControls;

    First;
    While Not Eof Do
    Begin
      intTam := Length(FieldByName('NUMDOC').AsString);

      If (Pos(Copy(FieldByName('NUMDOC').AsString, intTam-1, intTam), 'MI_FF_') > 0) And (fEmptyStr(FieldByName('DOCFAT').AsString)) Then
      Begin
        Result := True;
        Break;
      End;

      Next;
    End;

    GotoBookmark(bkmMarca);
    FreeBookmark(bkmMarca);
    EnableControls;
  End;
end;

function TfrmGarantiaRecCliente.fGetCfopRecCliente(fatVendaP: TFatVenda; blnFaturamento: Boolean; tmEntSai: TTipoMov): Boolean;
  Var
    strClaFisGar,
    strClaFisInd: String;
begin
  Result := True;

  If Assigned(fatVendaP) And ((fatVendaP.strEspDoc = 'GA') Or (fatVendaP.strOpcDoc = 'DV')) Then
    Exit;

  If tmEntSai = tmEntrada Then
  Begin
    strClaFisGar := fCfgSis('CRECGC');

    If SameText(strCliEst, fCadEmp('ESTADO')) Then
      strClaFisInd := '1'
    Else
      strClaFisInd := '2';
  End
  Else
  Begin
    strClaFisGar := fCfgSis('CREPGC');

    If SameText(strCliEst, fCadEmp('ESTADO')) Then
      strClaFisInd := '5'
    Else
      strClaFisInd := '6';
  End;

  Try
    If (Length(strClaFisGar) = 3) Then
    Begin
      strClaFisEnt := strClaFisInd + strClaFisGar;
      strClaFisSub := strClaFisInd + strClaFisGar;
      If blnFaturamento Then
      Begin
        fatVendaP.strClaFis := strClaFisInd + strClaFisGar;
        fatVendaP.strDesCla := fRetDesCla(fatVendaP.strClaFis);
      End;
    End
    Else
    Begin
      pCriarFormularios(TfrmFatDigDadosGarantia, frmFatDigDadosGarantia);
      Try

        frmFatDigDadosGarantia.edtClaFis.Enabled := True;
        frmFatDigDadosGarantia.edtDesCla.Enabled := True;

        If blnFaturamento Then
        Begin
          frmFatDigDadosGarantia.fatVenda    := fatVendaP;

          If tmEntSai = tmEntrada Then
            frmFatDigDadosGarantia.strOpcDoc := 'OE'
          Else
            frmFatDigDadosGarantia.strOpcDoc := 'OU';
        End
        Else
          frmFatDigDadosGarantia.strOpcDoc   := 'NE';

        frmFatDigDadosGarantia.blnTemST := blnTemST or (FblnEspDev And (frmFatDigDadosGarantia.strOpcDoc = 'OE'));
        frmFatDigDadosGarantia.ShowModal;
        Result := frmFatDigDadosGarantia.ModalResult = mrOk;

        If (Result) Then
        Begin
          strClaFisEnt := frmFatDigDadosGarantia.edtClaFis.Text;
          strClaFisSub := frmFatDigDadosGarantia.edtClaSub.Text;
        End
        else
        begin
          pMensagemOk('É necesário informar a classificação fiscal da operação!');
          Exit;
        end;
      Finally
        pFreeAndNil(frmFatDigDadosGarantia);
      End;

    End;

    If blnFaturamento Then
    Begin
      fatVendaP.strClaFisRecGarantia   := strClaFisEnt;
      fatVendaP.strClaFisRecGarantiaST := strClaFisSub;

      If (tmEntSai = tmEntrada) And (StrToInt(fatVendaP.strClaFisRecGarantia[1]) >= 5) Then
      Begin
        If SameText(strCliEst, fCadEmp('ESTADO')) Then
          fatVendaP.strClaFisRecGarantia := '1' + Copy(fatVendaP.strClaFisRecGarantia, 2, 3)
        Else
          fatVendaP.strClaFisRecGarantia:= '2' + Copy(fatVendaP.strClaFisRecGarantia, 2, 3);

        fatVendaP.strClaFis := fatVendaP.strClaFisRecGarantia;
      End;

    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmGarantiaRecCliente.fGetCfopRecCliente]');
    End;
  End;
end;

function TfrmGarantiaRecCliente.fGetTipoFaturamento(fatVendaP: TFatVenda; tmEntSai: TTipoMov): Boolean;
  Var
    intTipMov : Integer;
    intTipEmissao : Integer;
    arrEmiNF : Array Of String;
Begin
  Result := True;

  If tmEntSai = tmEntrada Then
  Begin

    If Not fExisteDocNaoFiscal Then
    Begin
      intTipMov := fMensagem('', 'Escolha o tipo de movimento que deseja realizar:', ['Entrada de Mercadorias', 'Emissão de Nota de Entrada'],
                             1, True, 1 , 230, False, 0, False, False, True, 0, 530);

      If (intTipMov = 1) Then
      Begin
        (*Entrada de Mercadorias *)
        fatVendaP.strEspDoc := 'NE';
      End
      Else If (intTipMov = 2) Then
      Begin
        (*Emissão de Nota Fiscal de Entrada *)

        SetLength(arrEmiNF, 2);
        arrEmiNF[0] := 'NF de Devolução';
        arrEmiNF[1] := 'NF de Outras Entradas';

        If fCfgSis('PREMGA', varBoolean) Then
        Begin
          SetLength(arrEmiNF, Length(arrEmiNF)+1);
          arrEmiNF[2] := 'Garantia Cliente (GA)';
        End;

        intTipEmissao := fMensagem('', 'Escolha o tipo de movimento de entrada que deseja realizar:', arrEmiNF, 1, True, 1 , 200, False, 0, False, False, True, 0, 640);

        If (intTipEmissao in [1,2]) Then
        Begin
          (* NF de Devolução *)
          fatVendaP.strOpcDoc := 'OE';
          fatVendaP.strEspDoc := 'NF';
          If (intTipEmissao  = 1) Then
          Begin
            fatVendaP.strOpcDoc := 'DV';
            fatVendaP.strClaFisRecGarantia := '5999'; //Apenas para retornar true na TFatVenda.fEhRecGarantia;
          End;
        End
        Else
        If (intTipEmissao  = 3) Then
        Begin
          (* GA *)
          fatVendaP.strOpcDoc := 'GA';
          fatVendaP.strEspDoc := 'GA';
        End
        Else
          Result := False;

      End
      Else
        Result := False;
    End
    Else
    Begin
      (* Se tem documento sem NF, a operação sempre será sem NF *)
      fatVendaP.strOpcDoc := 'GA';
      fatVendaP.strEspDoc := 'GA';
    End;

  End;

End;
function TfrmGarantiaRecCliente.fGetVlrConNE(strAutInc: String): Double;
var qryConsulta : TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT GER_VLRCON FROM MOVGER');
    qryConsulta.SQL.Add(' WHERE AUTOINCREM = "'+strAutInc+'"');
    qryConsulta.open;

    If qryConsulta.IsEmpty Then
      Result := fltTotCre
    Else
      Result := qryConsulta.FieldByName('GER_VLRCON').AsFloat;
  Finally
    FreeAndNil(qryConsulta);
  End;

end;

(*  Var
    arrOpcoes: TOpcoesFaturamentoArray;
    intPos: Integer;
Begin
  Result := False;

  intPos := 0;
  SetLength(arrOpcoes, 1);

  If tmEntSai = tmEntrada Then
  Begin
    If Not fExisteDocNaoFiscal Then
    Begin
      arrOpcoes[intPos].strDesCri := 'Nota Fiscal (Outras Entradas)';
      arrOpcoes[intPos].strEspDoc := 'NF';
      arrOpcoes[intPos].strOpcLet := 'O';
      arrOpcoes[intPos].strMosMen := 'S';
      Inc(intPos);
      SetLength(arrOpcoes, 2);

      arrOpcoes[intPos].strDesCri := 'Nota Fiscal (Entrada de Mercadorias)';
      arrOpcoes[intPos].strEspDoc := 'NE';
      arrOpcoes[intPos].strOpcLet := 'N';
      arrOpcoes[intPos].strMosMen := 'S';
      Inc(intPos);
      SetLength(arrOpcoes, 3);
    End;
  End
  Else
  Begin
    If Not fExisteDocNaoFiscal Then
    Begin
      arrOpcoes[intPos].strDesCri := 'Nota Fiscal (Outras Saídas)';
      arrOpcoes[intPos].strEspDoc := 'NF';
      arrOpcoes[intPos].strOpcLet := 'O';
      arrOpcoes[intPos].strMosMen := 'S';
      Inc(intPos);
      SetLength(arrOpcoes, 2);
    End;
  End;

  arrOpcoes[intPos].strDesCri := 'Garantia';
  arrOpcoes[intPos].strEspDoc := 'GA';
  arrOpcoes[intPos].strOpcLet := 'G';
  arrOpcoes[intPos].strMosMen := 'N';

  Try
    pCriarFormularios(TfrmFatTipoFaturamento, frmFatTipoFaturamento);
    frmFatTipoFaturamento.Caption   := strCaption;
    frmFatTipoFaturamento.strOpcDoc := 'VN';
    frmFatTipoFaturamento.fatVenda  := fatVenda;
    frmFatTipoFaturamento.arrOpcoes := arrOpcoes;
    frmFatTipoFaturamento.showModal;

    If frmFatTipoFaturamento.blnConfirma Then
    Begin
      If (arrOpcoes[frmFatTipoFaturamento.intPosAtual].strEspDoc = 'NF') And
         (tmEntSai = tmEntrada) Then
        fatVenda.strOpcDoc := 'OE'
      Else If (arrOpcoes[frmFatTipoFaturamento.intPosAtual].strEspDoc = 'NF') And
         (tmEntSai = tmSaida) Then
        fatVenda.strOpcDoc := 'OU';

      fatVenda.strEspDoc := arrOpcoes[frmFatTipoFaturamento.intPosAtual].strEspDoc;
      fatVenda.strTipFat := arrOpcoes[frmFatTipoFaturamento.intPosAtual].strDesCri;

      If fVerificaSeImpNFAvulsa(fatVenda.strEspDoc, teNaoPermite) Then
        Result := False
      Else
        Result := True;

      If (arrOpcoes[frmFatTipoFaturamento.intPosAtual].strEspDoc = 'NE') And
         (Pos('CONSUMIDOR', fRetNomCliente(edtCodCli.Text)) > 0) Then
      Begin
        Result := False;
        fMensagem('', 'A Entrada de Mercadorias não permite cliente consumidor, cadastre o cliente!', ['&OK']);
      End;

    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmGarantiaRecCliente.fGetTipoFaturamento]');
    End;
  End;

  pFreeAndNil(frmFatTipoFaturamento);

  SetLength(arrOpcoes, 0);

end;*)

function TfrmGarantiaRecCliente.fGravaArquivos(objfatVenda : TFatVenda): Boolean;
begin
  Try
    objfatVenda.cdsMovGad  := cdsItens;

    if objfatVenda.strOpcDoc = 'OU' then
      objfatVenda.blnDTEXREP := True;

    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.strChave            := 'FATFATURA';
    frmGravando.fExecutarAcao       := objfatVenda.fGravaArquivos;
    frmGravando.lblGravando.Caption := 'Aguarde, Gravando Recebimento Cliente (Garantia)...';
    frmGravando.ShowModal;
    Result                          := frmGravando.blnConfirma;

    pFreeAndNil(frmGravando);

    If (Not Result) Then
    Begin
      pInicializaTemporaria;
      Exit;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fConfirmaVenda - frmGravando]');
      pFreeAndNil(frmGravando);
    End;
  End;

  pInicializaTemporaria;
end;

function TfrmGarantiaRecCliente.fGravaCreditoCliente(strNumDup, strCodCli,
  strCodVen, strCodDig, strPortad, strAutIncGer: String; fltValDup: Double): Boolean;
  Var
    lstrAutInc,
    lstrNumDup,
    strDocOri,
    strDocumentos,
    strObservacao,
    strNumDocumento,
    strNumGA,
    strEspecie,
    strEmpDoc,
    strCodIte,
    strDesIte,
    strDesUniMedida,
    strQtd: String;
    lRecParGravaCADREC: TRecParGravaCADREC;
Begin
  {$Region 'Preparando dados'}
  If (Pos(fatVenda.strEspDoc, 'NE_NF_') > 0) Then
  Begin
    strDocumentos := '';

    cdsItens.First;
    While not cdsItens.Eof Do
    Begin
      strDocOri := Copy(cdsItens.FieldByName('NUMDOC').AsString, 1, fTamDocCadRec) + '-' +
                   Copy(cdsItens.FieldByName('NUMDOC').AsString, IfThen(fTamDocCadRec = 6, 8, 14), 2) + '-' +
                   cdsItens.FieldByName('EMPDOC').AsString;

      If Pos(strDocOri, strDocumentos) = 0 Then
      Begin
        If not fEmptyStr(strDocumentos) Then
          strDocumentos := strDocumentos + ', ';

        strDocumentos := strDocumentos + strDocOri;
      End;

      cdsItens.Next;
    End;

  End;

  If (Pos(fatVenda.strEspDoc, 'GA') > 0) Then
  Begin
    strObservacao := 'REF. LANC. CREDITO ( GARANTIA ) '+#$A;

    cdsItens.First;
    strNumDocumento:= Copy(cdsItens.FieldByName('NUMDOC').AsString, 1, fTamDocCadRec);
    strEspecie     := Copy(cdsItens.FieldByName('NUMDOC').AsString, IfThen(fTamDocCadRec = 6, 8, 14), 2);
    strNumGA       := objMovGag.strNumEnt;
    strEmpDoc      := cdsItens.FieldByName('EMPDOC').AsString;
    strDataVenda    := FormatDateTime('dd/mm/yyyy', cdsItens.FieldByName('DTAENT').AsDateTime);
    strObservacao := strObservacao + 'DT.VENDA: '+strDataVenda+' - ';
    strObservacao := strObservacao + 'NF VENDA: '+strNumDocumento+'-'+strEspecie+'-'+strEmpDoc+' - ';
    strObservacao := strObservacao + 'Documento: '+strNumGA+'-GA-'+VS_strCodEmp + ' - ';
    While not cdsItens.Eof Do
    Begin
      strCodIte      := cdsItensCODITE.AsString;
      strDesIte      := cdsItensDESITE.AsString;
      strDesUniMedida:= cdsItensDESUNI.AsString;
      strQtd         := cdsItensQTDITE.AsString;
      strObservacao := strObservacao + 'PRODUTO: '+strCodIte+'-'+strDesIte+'-'+strDesUniMedida+'-Qtd: '+strQtd+' '+#$A;

      cdsItens.Next;
    End;
  End;


  strDocumentos := 'DOCUMENTO DE VENDA: ' + strDocumentos;

  lstrNumDup := IfThen(fatVenda.strEspDoc = 'NF',fatVenda.strNumDoc, IfThen( (fatVenda.strEspDoc = 'NE'), strNumRet, strNumDup));
  {$Endregion}

  lRecParGravaCADREC.Create(lstrNumDup);
  lRecParGravaCADREC.strCodCli := strCodCli;
  lRecParGravaCADREC.strNomFrmLogCtr := Self.Name;
  lRecParGravaCADREC.strEspecie := IfThen((Pos(fatVenda.strEspDoc, 'NE_NF_') > 0), 'NF', 'CC');
  lRecParGravaCADREC.strCodVen := recPessoasOperacao.recVendedor.strCodigo;
  lRecParGravaCADREC.strCodDig := recPessoasOperacao.recDigitador.strCodigo;
  lRecParGravaCADREC.strCodPor := strPortad;
  lRecParGravaCADREC.Historico1 := IfThen((Pos(fatVenda.strEspDoc, 'NE_NF_') > 0), strDocumentos, strObservacao);
  lRecParGravaCADREC.Historico2 := IfThen((Pos(fatVenda.strEspDoc, 'NE_NF_') > 0), strObservacao, '');
  lRecParGravaCADREC.strIncGer := strAutIncGer;
  lRecParGravaCADREC.pdtaDtaCad := VS_Date;
  lRecParGravaCADREC.fltValDup := -fltValDup;

  if fGravaCreditoClienteExec(lRecParGravaCADREC, lstrAutInc) then
    Result := objMovGag.fVincularCredito(objMovGag.strAutInc, lstrAutInc)
  else
    Result := False;

end;

function TfrmGarantiaRecCliente.fGravaEntradaEstoque(strAutInc, strAutIncDet:String;
pgbStatus: TcxProgressBar = nil): Boolean;
  Var
    blnTemLot : Boolean;
    strLotGar,
    strCodCli,
    lstrCodVen : String;
    recServicos: TDadosServicos;
    arrDuplic : TarrDuplicata;
begin
  pInfoStatusGravacao('Aguarde... Gravando a Entrada', pgbStatus);

  pgbStatus.Position := 0;
  pgbStatus.Properties.Max := (cdsItens.RecordCount * 2) + 1;

  pStepStatusGravacao(pgbStatus);
  FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

  If (objMovGag.strCodCli <> objMovGag.strCodFav) And (Not fEmptyStr(objMovGag.strCodFav))  Then
    strCodCli := objMovGag.strCodFav
  Else
    strCodCli := objMovGag.strCodCli;


  Result := fGravaMovGer(strAutInc,
                         objMovGag.strNumEnt,
                         'GA',
                         VS_strCodEmp,
                         '',
                         recPessoasOperacao.recDigitador.strCodigo,
                         '', //objMovGag.strCodFor,
                         strCodCli,
                         'C',
                         VS_Date,
                         fTime(),
                         VS_Date,
                         '',
                         '',
                         objMovGag.strNomCon,
                         objMovGag.strEndCon,
                         objMovGag.strBaiCon,
                         objMovGag.strCepCon,
                         objMovGag.strCidCon,
                         objMovGag.strEstCon,
                         objMovGag.strTelCon,
                         0,
                         IntToStr(objMovGag.intCgcCpf),
                         objMovGag.strCgcCon,
                         objMovGag.strIesCon,
                         objMovGag.strRg_Con,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         '',
                         0.0,
                         0.0,
                         0.0,
                         0,
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         False,
                         '',
                         '',
                         '', // Empresa do Faturamento
                         0,
                         '',
                         '',
                         False,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         arrDuplic,
                         '',
                         'N',
                         '1999',
                         '',
                         '',
                         '',
                         0.0,
                         '',
                         '',
                         '',
                         0.0,
                         recServicos,
                         0.0,
                         '',
                         '',
                         '',
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         '',
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         '',
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         '',
                         0.0,
                         0.0,
                         0,
                         '',
                         'N',
                         '',
                         '',      // Operador da Expedição
                         '',      // Separador da Expedição
                         '',
                         '',
                         'N',     // Entrega Futura
                         FALSE,  // Baixa de Entrega Futura
                         0,      // Margem de Lucro
                         0.0,    // Base do retido (caso tivesse) com ipi e frete de entrada
                         0.0,    // Valor do retido considerando a base acima.
                         'N',    // Gerar produção fora da loja
                         '',     // Numero do Registro - Correios ou Transportadora
                         VS_Date,// Data de Entrega no Romaneio
                         '',     // Classificação fiscal 4
                         'N',    // AUTO-SERVIÇO
                         '',     // Evento
                         '',     // AUTINC ENDEREÇO DE ENTREGA
                         '',     // Conteúdo do CNFNFE
                         '',     // Motivo da Devolução
                         '',
                         True);  // Imprime Duplicatas na NF-e

  If Not Result Then
  Begin
    Exit;
  End;

  objAuditoriaSaldo.Adicionar(strAutInc, 'MOVGER');

  With cdsItens Do
  Begin

    First;

    While Not Eof Do
    Begin
      blnTemLot := objCadLot.fExisteLote(FieldByName('CODITE').AsString, vs_strCodEmp, '', False, False);

      if (blnTemLot) then
        strLotGar := objCadLot.fRetArmazemPrincipalGarantia(FieldByName('CODITE').AsString)
      else
        strLotGar := '';

      If blnTemLot And fEmptyStr(strLotGar) Then
        strLotGar := 'A DEFINIR';

      pInfoStatusGravacao('Aguarde... Gravando Produtos', pgbStatus);
      pStepStatusGravacao(pgbStatus);

      strAutIncDet := '';

      if fEmptyStr(FieldByName('CODVEN').AsString) then
        lstrCodVen := recPessoasOperacao.recDigitador.strCodigo
      else
        lstrCodVen := FieldByName('CODVEN').AsString;

      Result := fGravaMovDet(strAutIncDet,
                             strAutInc,
                             objMovGag.strNumEnt,
                             'GA',
                             objMovGag.strCodEmp,
                             FieldByName('CODITE').AsString,
                             lstrCodVen,
                             '',
                             fRetMarcaItem(FieldByName('CODITE').AsString),
                             '',
                             strCodCli,
                             VS_Date,
                             fTime(),
                             VS_Date,
                             '',
                             'C',
                             '',
                             FieldByName('DESITE').AsString,
                             FieldByName('REFERE').AsString,
                             fRetUnidadeItem(FieldByName('CODITE').AsString),
                             '', //objMovGag.strCodFor,
                             FieldByName('QTDITE').AsFloat,
                             FieldByName('VALITE').AsFloat / FieldByName('QTDITE').AsFloat,
                             FieldByName('VALITE').AsFloat / FieldByName('QTDITE').AsFloat,
                             FieldByName('VALITE').AsFloat / FieldByName('QTDITE').AsFloat,
                             FieldByName('VALITE').AsFloat,
                             (FieldByName('VALITE').AsFloat) + FieldByName('DESACE').AsFloat,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             '',
                             '',
                             0.0,
                             0.0,
                             0.0,
                             '1999',
                             '',
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             False,
                             '',
                             '',
                             '', // Empresa do Faturamento
                             0,
                             '',
                             '',
                             0.0,
                             'NOR',
                             '',
                             '',
                             FieldByName('DESACE').AsFloat,
                             'N',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             0.0,
                             0.0,
                             '',
                             0.0,
                             0.0,
                             0,
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             0,
                             'N',
                             '',
                             0.0,
                             '',
                             '',
                             '',
                             '',
                             '',
                             0,
                             '',

                             '',

                             '',

                             0,

                             0,

                             0.0,
                             '',
                             '',
                             False,
                             False,
                             '',                                                             //  Especie da Entrega Fututa
                             '',                                                             //  Documento da Entrega Fututa
                             '',
                             '',                                                             //  Empresa da Entrega Fututa
                             '',
                             '',
                             '',
                             '',
                             0.0,
                             '',
                             0.0,
                             0.0,
                             0,
                             'N',
                             '',
                             0,
                             0,
                             0,
                             0,
                             '',
                             IIF(blnTemLot, strLotGar, ''), // strNumLot ** RL **
                             // IIF(blnTemLot And (objCadLot.tplTipLot = tplArmazem), strLotGar, ''),   // strNumLot // ANTIGO
                             'N',  // strPigBas
                             0,
                             0,
                             0,
                             0,
                             0,
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
                             '',
                             '',
                             0,
                             0,
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
                             'P',
                             0,
                             0,
                             0,
                             '',
                             '',
                             '',
                             FieldByName('AUTINC').AsString);

      If Not Result Then
      Begin
        Exit;
      End;

      pInfoStatusGravacao('Aguarde... Atualizando Estoque', pgbStatus);
      pStepStatusGravacao(pgbStatus);

      fAtualizaEstoqueCadIte(FieldByName('CODITE').AsString,
                             'E',
                             FieldByName('QTDITE').AsFloat,
                             fRetPreUve(objMovGag.strCodEmp, FieldByName('CODITE').AsString),
                             IIF(blnTemLot, strLotGar, '')
                             );

      if Not TMovGag.fInsereMovGrc(FieldByName('AUTINC').AsString, strAutIncDet, 'GA', 'G', FieldByName('INCORI').AsString ) Then
      begin
        Result := False;
        Break;
      end;

      Next;
    End;

  End;

  if Result then
    Result := fAntesConfirmarEntrada(Nil, strAutInc);

  If Result And fVaiUtilizarAD Then
    pMarcaDocumentoDevAD(qryAD.FieldByName('GER_CODADE').AsString, VS_strCodEmp, objMovGag.strNumEnt, 'GA', VS_strCodEmp);

  TTestabilidade.fGetTestabilidade.NumeroDocumento  := objMovGag.strNumEnt;
end;

function TfrmGarantiaRecCliente.fGravaEntradaGA(
  pgbStatus: TcxProgressBar): Boolean;
var
  strCodErrosAuditoria: String;
begin
  Try
    objAuditoriaSaldo.Limpar;

    fStartTransaction;

    Result := fGravaEntradaEstoque(strAutIncE, strAutIncDetE, pgbStatus);

    if Result And (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
    Begin
      Result := False;
      fRollBack;
      pMostraErrosAuditoria(strCodErrosAuditoria);
    End;

    if Result Then
      fCommit
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

function TfrmGarantiaRecCliente.fGravaSaidaEstoque(strAutInc, strAutIncDet:String; pgbStatus: TcxProgressBar = nil): Boolean;
  Var
    strNumero,
    strCodCli  : String;
    recServicos: TDadosServicos;
    arrDuplic : TarrDuplicata;
begin
  strNumero := fRetSequencialReposicao;
  FstrNumRetornoCliente := strNumero;
  FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

  If Assigned(pgbStatus) Then
  Begin
    pInfoStatusGravacao('Aguarde... Gravando a Saída', pgbStatus);
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := (cdsItens.RecordCount * 2) + 1;
    pStepStatusGravacao(pgbStatus);
  End;

  If (objMovGag.strCodCli <> objMovGag.strCodFav) And (Not fEmptyStr(objMovGag.strCodFav))  Then
    strCodCli := objMovGag.strCodFav
  Else
    strCodCli := objMovGag.strCodCli;

  FRecDocReposicao.pDefinir(strNumero, 'GC', VS_strCodEmp, strCodCli);

  Result := fGravaMovGer(strAutInc,
                         strNumero,
                         'GC',
                         VS_strCodEmp,
                         '',
                         recPessoasOperacao.recVendedor.strCodigo,
                         '', //objMovGag.strCodFor,
                         strCodCli,
                         'C',
                         VS_Date,
                         fTime(),
                         VS_Date,
                         '',
                         '',
                         objMovGag.strNomCon,
                         objMovGag.strEndCon,
                         objMovGag.strBaiCon,
                         objMovGag.strCepCon,
                         objMovGag.strCidCon,
                         objMovGag.strEstCon,
                         objMovGag.strTelCon,
                         0,
                         IntToStr(objMovGag.intCgcCpf),
                         objMovGag.strCgcCon,
                         objMovGag.strIesCon,
                         objMovGag.strRg_Con,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         '',
                         0.0,
                         0.0,
                         0.0,
                         0,
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         False,
                         '',
                         '',
                         '', // Empresa do Faturamento
                         0,
                         '',
                         '',
                         False,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         arrDuplic,
                         '',
                         'N',
                         '5999',
                         '',
                         '',
                         '',
                         0.0,
                         '',
                         '',
                         '',
                         0.0,
                         recServicos,
                         0.0,
                         '',
                         '',
                         '',
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         '',
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         '',
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         '',
                         0.0,
                         0.0,
                         0,
                         '',
                         FEntregaRetira.AsString_S_N,
                         '',
                         '',      // Operador da Expedição
                         '',      // Separador da Expedição
                         '',
                         '',
                         'N',     // Entrega Futura
                         FALSE,  // Baixa de Entrega Futura
                         0,      // Margem de Lucro
                         0.0,    // Base do retido (caso tivesse) com ipi e frete de entrada
                         0.0,    // Valor do retido considerando a base acima.
                         'N',    // Gerar produção fora da loja
                         '',     // Numero do Registro - Correios ou Transportadora
                         VS_Date,// Data de Entrega no Romaneio
                         '',     // Classificação fiscal 4
                         'N',    // AUTO-SERVIÇO
                         '',     // Evento
                         '',     // AUTINC ENDEREÇO DE ENTREGA
                         '',     // Conteúdo do CNFNFE
                         '',     // Motivo da Devolução
                         '',
                         True,  // Imprime Duplicatas na NF-e
                         0,
                         0,
                         '',
                         0,
                         0,
                         Nil,
                         '',
                         '',
                         '',
                        'N',
                         '',
                         '',
                         0,
                         '',
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
                         '',
                         0,
                         0,
                         0,
                         False,
                         True);
  If Not Result Then
    Exit;

  objAuditoriaSaldo.Adicionar(strAutInc, 'MOVGER');

  With cdsItens Do
  Begin

    First;

    While Not Eof Do
    Begin
      If (FieldByName('REPOST').AsString = 'S') Then
      Begin

        If Assigned(pgbStatus) Then
        Begin
          pInfoStatusGravacao('Aguarde... Gravando Produtos', pgbStatus);
          pStepStatusGravacao(pgbStatus);
        End;

        strAutIncDet := '';

        Result := fGravaMovDet(strAutIncDet,
                               strAutInc,
                               strNumero,
                               'GC',
                               objMovGag.strCodEmp,
                               FieldByName('CODITE').AsString,
                               recPessoasOperacao.recVendedor.strCodigo,
                               '',
                               fRetMarcaItem(FieldByName('CODITE').AsString),
                               '',
                               strCodCli,
                               VS_Date,
                               fTime(),
                               VS_Date,
                               '',
                               'C',
                               '',
                               FieldByName('DESITE').AsString,
                               FieldByName('REFERE').AsString,
                               fRetUnidadeItem(FieldByName('CODITE').AsString),
                               '', //objMovGag.strCodFor,
                               FieldByName('QTDITE').AsFloat,
                               FieldByName('VALITE').AsFloat / FieldByName('QTDITE').AsFloat,
                               FieldByName('VALITE').AsFloat / FieldByName('QTDITE').AsFloat,
                               FieldByName('VALITE').AsFloat / FieldByName('QTDITE').AsFloat,
                               FieldByName('VALITE').AsFloat,
                               FieldByName('VALITE').AsFloat,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               '',
                               '',
                               0.0,
                               0.0,
                               0.0,
                               '5999',
                               '',
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               False,
                               '',
                               '',
                               '', // Empresa do Faturamento
                               0,
                               '',
                               '',
                               0.0,
                               'NOR',
                               '',
                               '',
                               0.0,
                               'N',
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               0.0,
                               0.0,
                               '',
                               0.0,
                               0.0,
                               0,
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               0,
                               'N',
                               '',
                               0.0,
                               '',
                               '',
                               '',
                               '',
                               '',
                               0,
                               '',
                               '',
                               '',
                               0,
                               0,
                               0.0,
                               '',
                               '',
                               False,
                               False,
                               '',                                                             //  Especie da Entrega Fututa
                               '',                                                             //  Documento da Entrega Fututa
                               '',
                               '',                                                             //  Empresa da Entrega Fututa
                               '',
                               '',
                               '',
                               '',
                               0.0,
                               '',
                               0.0,
                               0.0,
                               0,
                               'N',
                               '',
                               0,
                               0,
                               0,
                               0,
                               '',
                               Trim(FieldByName('LOTSAI').AsString),   // strNumLot ** RL **
                               // '',   // strNumLot // ANTIGO
                               'N',  // strPigBas
                               0,
                               0,
                               0,
                               0,
                               0,
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
                               '',
                               '',
                               0,
                               0,
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
                               'P',
                               0,
                               0,
                               0,
                               '',
                               '',
                               '',
                               FieldByName('AUTINC').AsString);

        If Not Result Then
          Exit;

        If Assigned(pgbStatus) Then
        Begin
          pInfoStatusGravacao('Aguarde... Atualizando Estoque', pgbStatus);
          pStepStatusGravacao(pgbStatus);
        End;

        {fAtualizaEstoqueCadIte(FieldByName('CODITE').AsString,
                               'S',
                               FieldByName('QTDITE').AsFloat,
                               fRetPreUve(objMovGag.strCodEmp, FieldByName('CODITE').AsString)); ANTIGO }

        fAtualizaEstoqueCadIte(FieldByName('CODITE').AsString,
                               'S',
                               FieldByName('QTDITE').AsFloat,
                               fRetPreUve(objMovGag.strCodEmp,FieldByName('CODITE').AsString),
                               Trim(FieldByName('LOTSAI').AsString),
                               False);

        TMovGag.fInsereMovGrc(FieldByName('AUTINC').AsString, strAutIncDet, 'GC', 'G', FieldByName('INCORI').AsString);

      End;

      Next;

    End;

  End;

  TTestabilidade.fGetTestabilidade.NumeroDocumento  := strNumero;
end;

function TfrmGarantiaRecCliente.fGravaSaidaGA(
  pgbStatus: TcxProgressBar): Boolean;
var
  strCodErrosAuditoria: String;
  i: Integer;
begin

  Result := False;
  if chkReposicao.Checked And  FblnBaixaEstrutura then
  begin
    pVerificarTemItemBaixarEstrutura;
    if FblnTemItemBaixarEstrutura then
    begin
      if Not fIncluiItens(fatVenda2,'S', True) then
        Exit;

     if length(fatVenda2.arrMatItens) = 0 then
      Exit;
    end;
  end;

  Try
    objAuditoriaSaldo.Limpar;

    fStartTransaction;



    if fGravaSaidaEstoque(strAutIncS, strAutInc, pgbStatus) Then
    begin
      Result := True;
      if FblnTemItemBaixarEstrutura then
      begin
        for i := 0 to length(fatVenda2.arrMatItens) -1 do
        begin
          if Not fGerarOrdProItensEstrutura(fatVenda2.arrMatItens[i]) then
          begin
            Result := False;
            Break;
          end;
        end;
      end;
    end;

    If Result And (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
    Begin
      Result := False;
      fRollBack;
      pMostraErrosAuditoria(strCodErrosAuditoria);
    End;

    If Result Then
      fCommit
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '');
    End;
  End;

end;

function TfrmGarantiaRecCliente.fImportouXml: Boolean;
begin
  Result := (Not fEmptyStr(recNotEle.str_Chave)) And (Not fEmptyStr(recNotEle.strAutInc));
end;

function TfrmGarantiaRecCliente.fIncluiItens(fatVenda: TFatVenda; strRepos: String; pblnSomenteBXSBIT: Boolean = False): Boolean;
  Var
    qryGenIte   : TUniQuery;
    intContador : Integer;
    recForTin   : TForTin;
    recMadeira  : TDadosMadeira;
    strIteDes   : String;
    strClaFisGar: String;
    lblnBXSBIT: Boolean;
    lIncluirItem: Boolean;
    lstrIncDev: String;
    lstrTabDev: String;
    lblnDVOEEspelho: Boolean;
begin
  lblnDVOEEspelho := FblnEspDev And (pos(fatVenda.strOpcDoc, 'DV_OE') > 0);
  Try
    qryGenIte := fCriaQuery;
    cdsGroup.EmptyDataSet;
    strClaFisGar  := fatVenda.strClaFisRecGarantia;
    If Not fEmptyStr(objMovGag.strNomCon) Then
    Begin
      fatVenda.strCliNom := objMovGag.strNomCon; // Nome do Consumidor
      fatVenda.strCliEnd := objMovGag.strEndCon; // Endereço do Consumidor
      fatVenda.strCliBai := objMovGag.strBaiCon; // Bairro do Consumidor
      fatVenda.strCliCep := objMovGag.strCepCon; // Cep do Consumidor
      fatVenda.strCodCid := objMovGag.strCidCon; // Cidade do Consumidor
      fatVenda.strCliEst := objMovGag.strEstCon; // Estado do Consumidor
      fatVenda.strCliTel := objMovGag.strTelCon; // Telefone do Consumidor
      fatVenda.intCgcCpf := objMovGag.intCgcCpf; // CNPJ / CGC
      fatVenda.strCliCgc := objMovGag.strCgcCon; // CNPJ / CGC do consumidor
      fatVenda.strCliIes := objMovGag.strIesCon; // Inscrição estadual do Consumidor
      fatVenda.strCli_Rg := objMovGag.strRg_Con; // Rg do Consumidor
      fatVenda.strCliEma := objMovGag.strEmaCon;
      If (fCfgSis('PRECAD', varBoolean)) Then
        fatVenda.strCodAti := objMovGag.strCodAti;
    End;

    With cdsItens Do
    Begin
      DisableControls;
      First;

      While Not Eof Do
      Begin
        cdsGroup.Close;
        cdsGroup.Open;

        If (FieldByName('REPOST').AsString = 'S') Or
           (FieldByName('REPOST').AsString = strRepos) Then
        Begin
          If Not cdsGroup.Locate('CODITE;NUMDOC;INCORI;LOTSAI', VarArrayOf([FieldByName('CODITE').AsString,
                                                                            FieldByName('NUMDOC').AsString,
                                                                            FieldByName('INCORI').AsString,
                                                                            FieldByName('LOTSAI').AsString]), []) Then
          Begin
            cdsGroup.Insert;
            cdsGroup.FieldByName('NUMENT').AsString     := FieldByName('NUMENT').AsString;
            cdsGroup.FieldByName('DTAENT').AsDateTime   := FieldByName('DTAENT').AsDateTime;
            cdsGroup.FieldByName('CODVEN').AsString     := FieldByName('CODVEN').AsString;
            cdsGroup.FieldByName('CODCLI').AsString     := FieldByName('CODCLI').AsString;
            cdsGroup.FieldByName('CODFOR').AsString     := FieldByName('CODFOR').AsString;
            cdsGroup.FieldByName('CODITE').AsString     := FieldByName('CODITE').AsString;
            cdsGroup.FieldByName('LOTSAI').AsString     := FieldByName('LOTSAI').AsString;
            cdsGroup.FieldByName('DESITE').AsString     := FieldByName('DESITE').AsString;
            cdsGroup.FieldByName('NUMDOC').AsString     := FieldByName('NUMDOC').AsString;
            cdsGroup.FieldByName('EMPDOC').AsString     := FieldByName('EMPDOC').AsString;
            cdsGroup.FieldByName('QTDITE').AsFloat      := FieldByName('QTDITE').AsFloat;
            cdsGroup.FieldByName('VALITE').AsFloat      := FieldByName('VALITE').AsFloat;
            cdsGroup.FieldByName('REPOST').AsString     := FieldByName('REPOST').AsString;
            cdsGroup.FieldByName('REFERE').AsString     := FieldByName('REFERE').AsString;
            cdsGroup.FieldByName('DESUNI').AsString     := FieldByName('DESUNI').AsString;
            cdsGroup.FieldByName('OBSP_1').AsString     := FieldByName('OBSP_1').AsString;
            cdsGroup.FieldByName('OBSP_2').AsString     := FieldByName('OBSP_2').AsString;
            cdsGroup.FieldByName('AUTINC').AsString     := FieldByName('AUTINC').AsString;
            cdsGroup.FieldByName('QTDDEV').AsFloat      := FieldByName('QTDDEV').AsFloat;
            cdsGroup.FieldByName('DTAENV').AsDateTime   := FieldByName('DTAENV').AsDateTime;
            cdsGroup.FieldByName('JA_GRAVADO').AsString := FieldByName('JA_GRAVADO').AsString;
            cdsGroup.FieldByName('CODFAB').AsString     := FieldByName('CODFAB').AsString;
            cdsGroup.FieldByName('PRECUS').AsFloat      := FieldByName('PRECUS').AsFloat;
            cdsGroup.FieldByName('TABPRE').AsString     := FieldByName('TABPRE').AsString;
            cdsGroup.FieldByName('NUMLOT').AsString     := FieldByName('NUMLOT').AsString;
            cdsGroup.FieldByName('DESACE').AsFloat      := FieldByName('DESACE').AsFloat;
            cdsGroup.FieldByName('INCORI').AsString     := FieldByName('INCORI').AsString;
            cdsGroup.FieldByName('BXSBIT').AsString     := cdsItens.FieldByName('BXSBIT').AsString;
            cdsGroup.FieldByName('TOTITE').AsFloat      := FieldByName('TOTITE').AsFloat;
            cdsGroup.FieldByName('TABELA').AsString     := FieldByName('TABELA').AsString;
            fltDesAce :=  fltDesAce + FieldByName('DESACE').AsFloat ;

            cdsGroup.Post;
          End
          Else
          Begin
            cdsGroup.Edit;
            cdsGroup.FieldByName('QTDITE').AsFloat := cdsGroup.FieldByName('QTDITE').AsFloat +
                                                      FieldByName('QTDITE').AsFloat;

            cdsGroup.FieldByName('DESACE').AsFloat := cdsGroup.FieldByName('DESACE').AsFloat +
                                                      FieldByName('DESACE').AsFloat;

            cdsGroup.FieldByName('TOTITE').AsFloat := cdsGroup.FieldByName('TOTITE').AsFloat +
                                                      FieldByName('TOTITE').AsFloat;

            fltDesAce :=  fltDesAce + FieldByName('DESACE').AsFloat ;

            cdsGroup.Post;
          End;
        End;

        Next;
      End;

      EnableControls;
    End;

    With cdsGroup Do
    Begin
      DisableControls;

      fatVenda.fltDesEsp := 0;

      intContador := 0;
      First;

      While Not Eof Do
      Begin
        lblnBXSBIT := False;
        if pblnSomenteBXSBIT then
        begin
          if (strRepos = 'S') Then
            lblnBXSBIT := FieldByName('BXSBIT').AsString = 'S';

          lIncluirItem := (FieldByName('QTDITE').AsFloat > 0) And lblnBXSBIT;
        end
        else
        begin
          lIncluirItem := (FieldByName('QTDITE').AsFloat > 0);
        end;

        If lIncluirItem Then
        Begin
          inc(intContador);

          If (intContador = 1) Then
          Begin
            fatVenda.strCodVen    := recPessoasOperacao.recVendedor.strCodigo;
            fatVenda.strNomVen    := recPessoasOperacao.recVendedor.strNome;
          End;

          fGetItem(qryGenIte,FieldByName('CODITE').AsString);

          strIteDes := FieldByName('DESITE').AsString;
          If (fCfgSis('IMPREF', varBoolean)) Then
            If (fCfgSis('MONDES', varString) = '1') Then
              strIteDes := FieldByName('DESITE').AsString +
                           IIF(Not fEmptyStr(FieldByName('REFERE').AsString),' ' + FieldByName('REFERE').AsString, '') +
                           IIF(Not fEmptyStr(FieldByName('CODFAB').AsString),' ' + FieldByName('CODFAB').AsString, '')
            Else
              strIteDes := IIF(Not fEmptyStr(FieldByName('CODFAB').AsString),FieldByName('CODFAB').AsString + ' ', '') +
                           IIF(Not fEmptyStr(FieldByName('REFERE').AsString),FieldByName('REFERE').AsString + ' ', '') +
                           FieldByName('DESITE').AsString;
         fatVenda.blnRaiseError := True;

          lstrIncDev := EmptyStr;
          lstrTabDev := '';
          if lblnDVOEEspelho then
          begin
            lstrIncDev := FieldByName('INCORI').AsString;
            lstrTabDev := iif(FieldByName('TABELA').AsString = 'NOTGER','NOTDET','MOVDET');
          end;

         fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
                                               Nil,
                                               'NOR',
                                               qryGenIte.FieldByName('ITE_CODGRU').AsString,
                                               FieldByName('CODITE').AsString,
                                               qryGenIte.FieldByName('ITE_DESITE').AsString,
                                               strIteDes,
                                               qryGenIte.FieldByName('ITE_DESFAB').AsString,
                                               qryGenIte.FieldByName('UNI_CODUNI').AsString,
                                               qryGenIte.FieldByName('UNI_CODUNI').AsString,
                                               qryGenIte.FieldByName('ITE_CODMAR').AsString,
                                               FieldByName('CODFOR').AsString,
                                               qryGenIte.FieldByName('ITE_REFERE').AsString,
                                               ifthen(lblnDVOEEspelho, FieldByName('TOTITE').AsFloat, FieldByName('VALITE').AsFloat) / FieldByName('QTDITE').AsFloat, //uniori
                                               ifthen(lblnDVOEEspelho, FieldByName('TOTITE').AsFloat, FieldByName('VALITE').AsFloat) / FieldByName('QTDITE').AsFloat, //uniVis
                                               ifthen(lblnDVOEEspelho, FieldByName('TOTITE').AsFloat, FieldByName('VALITE').AsFloat) / FieldByName('QTDITE').AsFloat, //unitar
                                               0.0,
                                               0.0,
                                               FieldByName('QTDITE').AsFloat,
                                               ifthen(lblnDVOEEspelho, FieldByName('TOTITE').AsFloat, FieldByName('VALITE').AsFloat), //totite
                                               IfThen(StrToIntDef(RightStr(fatVenda.strClaFis,1),0) >= 5,'S','E'),
                                               FieldByName('PRECUS').AsFloat,
                                               fFormataFloat(FieldByName('PRECUS').AsFloat * FieldByName('QTDITE').AsFloat, 2),
                                               qryGenIte.FieldByName('ITE_COMLUB').AsString,
                                               qryGenIte.FieldByName('ITE_IPISAI').AsFloat,
                                               qryGenIte.FieldByName('ITE_DESMAX').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREVE1').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREVE2').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREVE3').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREVE4').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREVE5').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREVE6').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREVE7').AsFloat,
                                               0.0,
                                               qryGenIte.FieldByName('ITE_SALDOS').AsFloat,
                                               'N',
                                               qryGenIte.FieldByName('ITE_COMVAR').AsFloat,
                                               qryGenIte.FieldByName('ITE_COMATA').AsFloat,
                                               qryGenIte.FieldByName('ITE_COMDIS').AsFloat,
                                               Copy(FieldByName('NUMDOC').AsString, 1, fTamDocCadRec),                    //strDocDev,
                                               Copy(FieldByName('NUMDOC').AsString, IfThen(fTamDocCadRec = 6, 8, 14), 2), //strEspDev,
                                               FieldByName('EMPDOC').AsString,                                            //strEmpDev: String;
                                               0,
                                               0,
                                               lstrIncDev,
                                               qryGenIte.FieldByName('ITE_PREULT').AsFloat * FieldByName('QTDITE').AsFloat,
                                               qryGenIte.FieldByName('ITE_IMPULT').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREULT').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREMED').AsFloat,
                                               qryGenIte.FieldByName('ITE_CLAIPI').AsString,
                                               '',
                                               '',
                                               '',
                                               '',
                                               0,
                                               '',
                                               0,
                                               0,
                                               0.00,
                                               0.00,
                                               0.00,
                                               'N',
                                               '',
                                               0,
                                               0,
                                               qryGenIte.FieldByName('ABF_CODABF').AsString,
                                               qryGenIte.FieldByName('ITE_PESOIT').AsFloat,
                                               qryGenIte.FieldByName('ITE_PESLIQ').AsFloat,
                                               'N',
                                               0,
                                               0,
                                               0,
                                               0,
                                               '',
                                               fatVenda.fRetPerComGrupo(qryGenIte.FieldByName('ITE_CODGRU').AsString),
                                               qryGenIte.FieldByName('ITE_CODFAB').AsString,
                                               -1,
                                               0,
                                               '',
                                               '',
                                               '',
                                               qryGenIte.FieldByName('ITE_MARMIN').AsFloat,
                                               qryGenIte.FieldByName('ITE_MARMSG').AsFloat,
                                               qryGenIte.FieldByName('ITE_MARMGE').AsFloat,
                                               fRetNomMarca(qryGenIte.FieldByName('ITE_CODMAR').AsString),
                                               '',
                                               0,
                                               0,
                                               '',
                                               '',
                                               '',
                                               0,
                                               '',
                                               '',
                                               '',
                                               qryGenIte.FieldByName('ITE_PRECOM').AsFloat,
                                               ifthen(lblnDVOEEspelho, FieldByName('TOTITE').AsFloat, FieldByName('VALITE').AsFloat) / FieldByName('QTDITE').AsFloat, //unidig
                                               qryGenIte.FieldByName('ITE_QTPPRO').AsFloat,
                                               '',
                                               '',
                                               qryGenIte.FieldByName('ITE_OBRCPF').AsString,
                                               '',
                                               '',
                                               fRetSiglaUnidade(qryGenIte.FieldByName('UNI_CODUNI').AsString),
                                               0.00,
                                               intContador,
                                               '',
                                               '',
                                               '',
                                               False,
                                               '',
                                               '',
                                               '',
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               '',
                                               '',
                                               '',
                                               IIF(fEmptyStr(FieldByName('TABPRE').AsString),'1',FieldByName('TABPRE').AsString),
                                               qryGenIte.FieldByName('ITE_IPIENT').AsFloat,
                                               qryGenIte.FieldByName('ITE_FREENT').AsFloat,
                                               '',
                                               0.0,
                                               '',
                                               0.0,
                                               'R',
                                               '',
                                               'N',
                                               '',
                                               0,
                                               FieldByName('QTDITE').AsFloat,
                                               0.0,
                                               0,
                                               qryGenIte.FieldByName('ITE_IMPDIR').AsString,
                                               '',
                                               0.00,
                                               0.00,
                                               0.00,
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               recForTin,
                                               '',
                                               '',
                                               IIF(fEmptyStr(strRepos) or (strRepos = 'S'),
                                                   FieldByName('LOTSAI').AsString,
                                                   FieldByName('NUMLOT').AsString),
                                               '',
                                               '',
                                               lblnBXSBIT,
                                               'N',
                                               'NOR',
                                               0,
                                               lstrTabDev,
                                               qryGenIte.FieldByName('ITE_CODBAR').AsString,
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
                                               FieldByName('PRECUS').AsFloat,
                                               '',
                                               '',
                                               recMadeira,
                                               qryGenIte.FieldByName('ITE_IMPULT').AsFloat * FieldByName('QTDITE').AsFloat,
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
                                               FieldByName('CODVEN').AsString,
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
                                               strClaFisGar,
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
                                               0,
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
                                               0,
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
                                               0,
                                               0,
                                               0,
                                               qryGenIte.FieldByName('ITE_MARMMV').AsFloat,
                                               qryGenIte.FieldByName('ITE_MARMMS').AsFloat,
                                               qryGenIte.FieldByName('ITE_MARMMG').AsFloat);
        End;

        Next;

      End;

      EnableControls;
    End;

    Result := True;

    FreeAndNil(qryGenIte);

  Except

    On E: Exception Do
    Begin
      Result := False;
      If E.Message <> 'Falha FuncFat' Then
  			pMensagensErro(E.Message,'[TfrmGarantiaRecCliente.fIncluiItens]');
    End;

  End;
end;

{*******************************************}
{* VALIDA CAMPOS                           *}
{****************************************RL*}
function TfrmGarantiaRecCliente.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    qryAdeDet: TUniQuery;
    qryCadFor: TUniQuery;
    chrKey   : Char;
    intResposta : Integer;
    frmValidacaoEspelhoXMLView: TfrmValidacaoEspelhoXMLView;
    strCodFor: String;
    Key : Char;
    strWhere,
    strMsg  : String;
    arrSel : TConsultasArray;

    blnEncontrouXML : Boolean;

    function fPedeSenhaMultiploVenda: Boolean;
    begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Item ' + fRetCodItem(edtCodIte.Text) + ' - ' +  LeftStr(edtDesIte.Text,50) + ' com quantidade fora do Múltiplo de Vendas.');

      objLiberacao.strDirAce := 'SENMTP';
      objLiberacao.strSenLib := fCfgSis('SENMTP');
      objLiberacao.strMsgSen := 'Senha para liberação de venda de item com quantidade fora do múltiplo de venda';
      objLiberacao.strCodOpe := fRetCodVendedor(edtSenVen.Text);
      objLiberacao.strCodDig := fRetCodVendedor(edtSenVen.Text);
      objLiberacao.strCliente := edtCodCli.Text + '-' + edtNomCli.Text;
      objLiberacao.strCpfCnpj := fRetCgcCpf(edtCodCli.Text);

      Result := objLiberacao.fLibera;
    end;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    blnEncontrouXML := (Not fEmptyStr(recNotEle.str_Chave)) And (Not fEmptyStr(recNotEle.strAutInc));
{$REGION 'Data de Entrada'}
      {*****************************************}
      {* VALIDA DATA DE ENTRADA                *}
      {**************************************RL*}
      If (Sender = mskDtaEnt) Then
      Begin

        If fEmptyStr(fTiraCaracEspeciais(mskDtaEnt.Text)) Then
        Begin
          fMensagem('ATENÇÃO!','A data de entrada deve ser preenchida!', ['&Ok']);
          Result := False;
        End
        Else
        Try
          StrToDate(mskDtaEnt.Text);
        Except
          fMensagem('ATENÇÃO!', 'Data inválida!', ['&Ok']);
          Result := False;
        End;

      End
{$ENDREGION}

{$REGION 'Vendedor'}
      {*****************************************}
      {* VALIDA VENDEDOR                       *}
      {**************************************RL*}
      Else If (Sender = edtSenVen) Then
      Begin

        If fEmptyStr(edtSenVen.Text) Then
        Begin

          fMensagem('ATENÇÃO!', 'O vendedor deve ser preenchido!' , ['&Ok']);
          Result := False;

        End
        Else
        Begin

          pPesquisaCadOpe(qryConOpe, qryConOpe, edtSenVen.Text, True);
          edtNomVen.Text := qryConOpe.FieldByName('OPE_NOMOPE').AsString;
          strCodVen      := qryConOpe.FieldByName('OPE_CODOPE').AsString;

          If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Vendedor não encontrado!', ['&O k']);
            Result := False;
          End

        End;

        If Result And (not fEmptyStr(recNotEle.strAutInc)) And blnBuscaPorChave Then
        Begin
          If cdsItens.IsEmpty Then
          Begin
            If fMensagem('', 'Deseja Carregar os Itens do XML?', ['&Sim', '&Não'], 1) = 2 Then
            Begin
              Result := False;
              pLimpaDados;
              blnMudarFoco := False;
              pSetFocus(mskDtaEnt);
              Exit;
            End;

            pCarregaItensXML;

          End;
        End

      End
{$ENDREGION}

{$REGION 'Cliente'}
      {*****************************************}
      {* VALIDA CLIENTE                        *}
      {**************************************RL*}
      Else If (Sender = edtCodCli) Then
      Begin

        If fEmptyStr(edtCodCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O cliente deve ser preenchido!' , ['&Ok']);
          Result := False;
        End
        Else
          Result := fDigDadosConsumidor(nil, False);

        If blnBuscaPorChave Then
        Begin

          if edtCodCli.Text <> strCodCliAnt then
          begin
            chkReposicao.Enabled := True;
            chkCredito.Enabled := True;
            If (fClienteFilial(edtCodCli.Text)) Then
            Begin
              intResposta := fMensagem('', 'Os Produtos estavam em estoque e foi detectado um problema/defeito?' + #13 + #13 +
                                           'Se SIM, ao confirmar a operação, a quantidade inserida em garantia será retirada do estoque disponível e será' + #13 +
                                           'reservada em garantia, para que possa ser enviada ao fornecedor.' + #13 + #13 +
                                           'Se NÃO, ao confirmar a operação,  o saldo disponível não sofrerá alteração. A quantidade inserida entrará no estoque' + #13 +
                                           'e será automaticamente reservada em garantia, mantendo o saldo disponível do produto.', ['&Sim', '&Não', '&Cancelar'], 1, False, 1, 0, False, 0, False, False, False, 300);

              Case intResposta Of
                1: begin
                    if fLiberarRecebimentoClienteFilial(True) then
                    begin
                      pMarcarReposicao(True);
                      chkReposicao.Enabled := False;
                      chkCredito.Enabled := False;
                      chkCredito.checked := False;
                    end
                    else
                      Result := False;
                   end;
                2: begin
                    if fLiberarRecebimentoClienteFilial(False) then
                    begin
                      pMarcarReposicao(False);
                      chkReposicao.Enabled := False;
                      chkCredito.Enabled := False;
                      chkCredito.checked := False;
                    end
                    else
                      Result := False;
                   end;
                3: Result := False;
              End;
              if Not Result then
              begin
                edtNomCli.Clear;
                edtCodCli.Clear;
                Exit;
              end;

              if Result then
                blnClienteFilial := True;

            End
            Else
              blnClienteFilial := False;

            strCodCliAnt := edtCodCli.Text;
          end;

          pnlProdutos.Visible := Not fVaiUtilizarAD;
          btnImportarXML.Visible := Not fVaiUtilizarAD;
          btnNotEle.Visible := Not fVaiUtilizarAD;

          fltDesAce := 0;

          If fVaiUtilizarAD And (cdsItens.IsEmpty) Then
          Begin
            fMensagem('', 'Escolha a AD para fazer o recebimento de garantia do cliente!', ['OK']);
            chrKey   := '/';
            If fPesqAD(Self, Nil, qryAD, chrKey, edtCodCli.Text, True, 'S', True)  Then
            Begin
              pCriarFormularios(TfrmEntSelItensDevolucao, frmEntSelItensDevolucao);
              Try
                pRetornaDadosAD(qryAD.FieldByName('GER_CODADE').AsString,
                                qryAD.FieldByName('GER_CODEMP').AsString, strDocsSelCRM, strCodVenCRM, strCodRepCRM, strCodCliCRM);
                recNotEle.strAutInc := '';

                If fEmptyStr(strDocsSelCRM) then
                Begin
                  pMensagemOk('Não foi indentificado o documento vinculado com esta AD ['+qryAD.FieldByName('GER_CODADE').AsString+']. Não será possível continuar!');
                  Exit(False);
                End;

                if fCfgSis('ESP_AD', varBoolean) then
                begin

                  intResposta := fMensagem('', 'Deseja informar o XML da nota de entrada?', ['Não Informar', 'Importar XML', 'Carregar XML'], 1, False, 1 , 150, False, 0, False, False, True, 0, 650);

                  if intResposta <> 1 then
                  begin


                    case intResposta of
                      2: btnImportarXML.Click;
                      3: btnNotEle.Click;
                    end;

                    if (fEmptyStr(recNotEle.strAutInc)) then
                    begin
                      pLimpaDados();
                      exit();
                    end
                    else
                    begin
                      pCriarFormularios(TfrmValidacaoEspelhoXMLView, frmValidacaoEspelhoXMLView);
                      try
                        frmValidacaoEspelhoXMLView.strCodigoAD := qryAD.FieldByName('GER_CODADE').AsString;
                        frmValidacaoEspelhoXMLView.strAutoincremGERELE := recNotEle.strAutInc;
                        if frmValidacaoEspelhoXMLView.ShowModal = mrOk then
                          pCarregaItensXML
                        else
                        begin
                          pLimpaDados();
                          exit();
                        end;

                      finally
                        pFreeAndNil(frmValidacaoEspelhoXMLView);
                      end;
                    end;

                  end;

                end;


                if (fEmptyStr(recNotEle.strAutInc)) then
                begin
                  frmEntSelItensDevolucao.pCarregaCDSItens(strDocsSelCRM,
                                                           qryAD.FieldByName('GER_CODADE').AsString,
                                                           True,
                                                           qryAD.FieldByName('GER_CODEMP').AsString);
                  If Not frmEntSelItensDevolucao.blnTemItensDisponiveis Then
                  Begin
                    fMensagem('Atenção', 'Todos os itens deste documento já foram devolvidos.', ['&OK']);
                    Exit;
                  End;

                  frmEntSelItensDevolucao.ShowModal;

                  If frmEntSelItensDevolucao.ModalResult = mrOk Then
                  Begin
                    With frmEntSelItensDevolucao.cdsItensDev Do
                    Begin
                      cdsAdeDet.EmptyDataSet;
                      blnReabreAD := frmEntSelItensDevolucao.blnReabreAD;

                      First;
                      Try
                        cdsItensLOTSAI.OnValidate := Nil;
                        While Not Eof Do
                        Begin
                          If frmEntSelItensDevolucao.fInLista Then
                          Begin
                            If (fCfgSis('FORREC', varInteger) = 2) and (Not fCfgSis('TABPRF', varBoolean)) And (btnAdicionar.Tag = 0) And (fQtdFornecedoresItem(fRetCodItem(FieldByName('DET_CODITE').AsString)) > 1) Then
                            Begin
                              Try
                                qryCadFor := fCriaQuery(Self);
                                key := '?';
                                strWhere := ' FOR_CODFOR IN (SELECT ITE_CODFOR FROM ITEFOR WHERE ITE_CODITE = ' + QuotedStr(fRetCodItem(FieldByName('DET_CODITE').AsString))+
                                                                 'UNION ALL SELECT ITE_CODFOR FROM CADITE WHERE ITE_CODITE = ' + QuotedStr(fRetCodItem(FieldByName('DET_CODITE').AsString))+')';

                                fMensagem('', 'Esse produto possui mais de 1 fornecedor, selecione o fornecedor do produto!', ['&OK']);
                                If fPesqFornecedor(conForUltimaCompra, Self, nil, nil, qryCadFor, Key, arrSel, True, Nil, strWhere,
                                                   fRetCodItem(FieldByName('DET_CODITE').AsString)) Then
                                  strCodFor := qryCadFor.FieldByName('FOR_CODFOR').AsString
                                Else
                                Begin
                                  fMensagem('', 'É obrigatório escolher um fornecedor para continuar!', ['&Ok']);
                                  Exit;
                                End;
                              Finally
                                FreeAndNil(qryCadFor);
                              End;

                            End
                            Else
                              strCodFor := fRetFornecedorItem(fRetCodItem(FieldByName('DET_CODITE').AsString));

                            blnPermiteInserirItens := True;
                            cdsItens.Append;

                            cdsItens.FieldByName('NUMENT').AsString   := '';
                            cdsItens.FieldByName('CODITE').AsString   := FieldByName('DET_CODITE').AsString;
                            cdsItens.FieldByName('CODFOR').AsString   := strCodFor;
                            cdsItens.FieldByName('NUMLOT').AsString   := objCadLot.fRetArmazemPrincipalGarantia(FieldByName('DET_CODITE').AsString);
                            cdsItens.FieldByName('EMPDOC').AsString   := FieldByName('DET_CODEMP').AsString;
                            cdsItens.FieldByName('DESITE').AsString   := FieldByName('DET_DESCRI').AsString;
                            cdsItens.FieldByName('REFERE').AsString   := fRetReferenciaProd(FieldByName('DET_CODITE').AsString);
                            cdsItens.FieldByName('DESUNI').AsString   := fRetSiglaUni(fRetUnidadeItem(FieldByName('DET_CODITE').AsString));
                            cdsItens.FieldByName('QTDITE').AsFloat    := FieldByName('QTDDEV').AsFloat;
                            cdsItens.FieldByName('VALITE').AsFloat    := FieldByName('QTDDEV').AsFloat * (FieldByName('DET_UNITAR').AsFloat - (FieldByName('DET_DESESP').AsFloat/FieldByName('QTDORI').AsFloat));
                            cdsItens.FieldByName('UNICRD').AsFloat    := FieldByName('UNICRD').AsFloat;
                            cdsItens.FieldByName('NUMDOC').AsString   := FieldByName('DET_NUMDOC').AsString + '-' +FieldByName('DET_ESPDOC').AsString;
                            cdsItens.FieldByName('REPOST').AsString   := IfThen(chkReposicao.Checked, 'S', 'N');
                            cdsItens.FieldByName('OBSP_1').AsString   := FieldByName('OBSP_1').AsString;
                            cdsItens.FieldByName('OBSP_2').AsString   := FieldByName('OBSP_2').AsString;
                            cdsItens.FieldByName('CODFAB').AsString   := fCampoTabela('ITE_CODFAB', 'CADITE', ['ITE_CODITE'], [fRetCodItem(edtCodIte.Text)]);
                            cdsItens.FieldByName('PRECUS').AsFloat    := fCampoTabela('ITE_PRECUS', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [fRetCodItem(edtCodIte.Text), VS_strCodEmp]);
                            cdsItens.FieldByName('TABPRE').AsString   := fCampoTabela('CLI_TABPRE', 'CADCLI', ['CLI_CODCLI'], [edtCodCli.Text], False);
                            cdsItens.FieldByName('CODVEN').AsString   := FieldByName('CODVEN').AsString;
                            cdsItens.FieldByName('SEQDOC').AsString   := FieldByName('INCORI').AsString;
                            cdsItens.FieldByName('INCORI').AsString   := FieldByName('INCORI').AsString;
                            cdsItens.FieldByName('TABELA').AsString   := 'MOVGER';

                            cdsItens.FieldByName('DET_UNITAR').AsFloat := FieldByName('DET_UNITAR').AsFloat;
                            cdsItens.FieldByName('DET_DESESP').AsFloat := FieldByName('DET_DESESP').AsFloat;
                            cdsItens.FieldByName('DET_DESCFF').AsFloat := 0;


                            {*******************************************}
                            {* CAMPO UTILIZADO PARA AUXILIAR NO CÁLCULO*}
                            {* DA QUANTIDADE DA DISPONOIBILIDADE DOS   *}
                            {* PRODUTOS DA NOTA.                       *}
                            {* SE JA_GRAVADO = N, ENTÃO QUER DIZER QUE *}
                            {* AINDA NAO FOI GRAVADO NO BANCO E PRECISA*}
                            {* SER CONSIDERADO NO CÁLCULO DA QUANTIDADE*}
                            {* DISPONÍVEL PARA O USUÁRIO SELECIONAR    *}
                            {****************************************RL*}
                            cdsItens.FieldByName('JA_GRAVADO').AsString := 'N';

                            If cdsItens.FieldByName('REPOST').AsString = 'S' Then
                              cdsItens.FieldByName('QTDDEV').AsFloat  := FieldByName('QTDDEV').AsFloat;

                            cdsItens.FieldByName('GARFIL').AsString := fCampoTabela('ITE_GARFIL', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [FieldByName('DET_CODITE').AsString, VS_strCodEmp]);
                            cdsItens.FieldByName('DESACE').AsFloat  := FieldByName('DET_DESACE').AsFloat;

                            fltDesAce :=  fltDesAce + cdsItens.FieldByName('DESACE').AsFloat ;

                            If chkReposicao.Checked then
                              cdsItens.FieldByName('LOTSAI').AsString
                                := objCadLot.fRetArmazemPrincipalVenda(cdsItens.FieldByName('CODITE').AsString);

                            cdsItens.Post;
                          End;

                          If blnReabreAD Then
                          Begin
                            Try
                              qryAdeDet := fCriarQuery(' SELECT * FROM ADEDET WHERE AUTOINCREM = :AUTINC ');
                              qryAdeDet.ParamByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
                              qryAdeDet.Open;

                              If (not qryAdeDet.IsEmpty) And
                                 (( frmEntSelItensDevolucao.fInLista And (qryAdeDet.FieldByName('DET_QTDDEV').AsFloat - FieldByName('QTDDEV').AsFloat > 0)) Or
                                 (not frmEntSelItensDevolucao.fInLista)) Then
                              Begin
                                cdsAdeDet.Append;
                                cdsAdeDet.FieldByName('DET_CODITE').AsString   := qryAdeDet.FieldByName('DET_CODITE').AsString;
                                cdsAdeDet.FieldByName('DET_CODMOT').AsString   := qryAdeDet.FieldByName('DET_CODMOT').AsString;
                                If not frmEntSelItensDevolucao.fInLista Then
                                  cdsAdeDet.FieldByName('DET_QTDDEV').AsFloat    := qryAdeDet.FieldByName('DET_QTDDEV').AsFloat
                                Else
                                  cdsAdeDet.FieldByName('DET_QTDDEV').AsFloat    := qryAdeDet.FieldByName('DET_QTDDEV').AsFloat - FieldByName('QTDDEV').AsFloat;
                                cdsAdeDet.FieldByName('DET_UNIDEV').AsString   := qryAdeDet.FieldByName('DET_UNIDEV').AsString;
                                cdsAdeDet.FieldByName('DET_CODEMP').AsString   := qryAdeDet.FieldByName('DET_CODEMP').AsString;
                                cdsAdeDet.FieldByName('DET_NUMDOC').AsString   := qryAdeDet.FieldByName('DET_NUMDOC').AsString;
                                cdsAdeDet.FieldByName('DET_ESPDOC').AsString   := qryAdeDet.FieldByName('DET_ESPDOC').AsString;
                                cdsAdeDet.FieldByName('DET_DTAMOV').AsDateTime := qryAdeDet.FieldByName('DET_DTAMOV').AsDateTime;
                                cdsAdeDet.FieldByName('DET_QTDORI').AsFloat    := qryAdeDet.FieldByName('DET_QTDORI').AsFloat;
                                cdsAdeDet.FieldByName('DET_FORCLI').AsString   := qryAdeDet.FieldByName('DET_FORCLI').AsString;
                                cdsAdeDet.FieldByName('DET_TIP_FC').AsString   := qryAdeDet.FieldByName('DET_TIP_FC').AsString;
                                cdsAdeDet.FieldByName('DET_SERIE_').AsString   := qryAdeDet.FieldByName('DET_SERIE_').AsString;
                                cdsAdeDet.FieldByName('DET_GARANT').AsString   := qryAdeDet.FieldByName('DET_GARANT').AsString;
                                cdsAdeDet.Post;
                              End;
                            Finally
                              FreeAndNil(qryAdeDet);
                            End;
                          End;

                          Next;
                        End;
                      Finally
                        cdsItensLOTSAI.OnValidate := ValidarLoteSaidaSelecionado;
                      End;
                    End;

                   End;
                end;
              Finally
                FreeAndNil(frmEntSelItensDevolucao);
              End;
            End;
          End;
        End;
        If Result then
          pExibirFavorecido;
      End
{$ENDREGION}

{$REGION 'Produto'}
    {*****************************************}
    {* VALIDA PRODUTO                        *}
    {**************************************RL*}
    Else If (Sender = edtCodIte) Then
    Begin
      If fEmptyStr(edtCodIte.Text) Then
      Begin

        If (cdsItens.IsEmpty) Then
        Begin
          If blnLerCodigoBarras Then
            fMensagem('ATENÇÃO!', 'O código de barras do produto deve ser preenchido!', ['&Ok'])
          Else
            fMensagem('ATENÇÃO!', 'O código do produto deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          pSetFocus(dbgItens);
            blnMudarFoco := False;
            Result := False;
          End;

        End
        Else
        Begin
          pAjustaLoteSaida;
          strNumLote := '';
          Result := fVerificaLoteProduto(strNumLote);

          {Válida se o preço de transferência não está zerado, se caso estiver zerado, gera problem na expedição}
          If Result And fCfgSis('GARMAT', varBoolean) And (fCfgSis('EMPGAR', varString) <> VS_strCodEmp) Then
          Begin

            If fRetPrecoTE(fRetCodItem(edtCodIte.Text)) <= 0.00 Then
            Begin
              strMsg := 'O item não pode ser selecionado porque seu valor é igual a zero.';
              strMsg := strMsg + sLineBreak + 'O valor do campo %s deve ser maior que zero.';
              strMsg := strMsg + sLineBreak + 'Altere o valor no cadastro de produto ou informe outro campo de referência alterando a configuração [CFG_TEPREV].';
              strMsg := Format(strMsg, [fDescricaoCampoRetPrecoTE]);
              fMensagem('ATENÇÃO!', strMsg, ['&O k']);
              Result := False;
            End;
          End;
        End;
      End
{$ENDREGION}

{$REGION 'Quantidade de Produtos'}
    {*****************************************}
    {* VALIDA QUANTIDADE DE PRODUTOS         *}
    {**************************************RL*}
    Else If (Sender = edtQtdIte) Then
    Begin
  
      If fEmptyStr(edtQtdIte.Text) Then
      Begin
  
        fMensagem('ATENÇÃO!', 'A quantidade do produto deve ser preenchida!', ['&Ok']);
        Result := False;
  
      End
      Else If fStrToFloat(edtQtdIte.Text) <= 0 Then
      Begin
  
        fMensagem('ATENÇÃO!', 'O valor deve ser maior que Zero!', ['&O k']);
        Result := False;
  
      End
      Else If (Not fClienteFilial(edtCodCli.Text)) And (fStrToFloat(edtQtdIte.Text) > fltDispon) Then
      Begin
        if blnSolicitarLiberacaoItemSemNotaVenda or (Not fValidarAoConfirmarRecebiemento) then
          fltDispon := strToFloat(edtQtdIte.Text)
        else begin
          fMensagem('', 'A quantidade informada para devolução é maior que a disponivel no documento selecionado!' + #13 +
                        'Disponível: ' + FloatToStrF(fltDispon, ffFixed, 12, 2), ['&Ok']);
          Result := False;
        end;
      End
      Else
      Begin
        (*
        If blnBuscaPorChave Or fAlterouDados Then
          Result := fValidaQtdMultipoVenda;
        *)
        If Result Then
        Begin
          If blnBuscaPorChave Or fAlterouDados Then
          Begin
            recDadSav.strCodVen := strCodVen;
            recDadSav.strCodCli := edtCodCli.Text;
//            recDadSav.strCodFor := edtCodFor.Text;
            recDadSav.strCodIte := fRetCodItem(edtCodIte.Text);
            recDadSav.fltQteIte := fStrToFloat(edtQtdIte.Text);
          End;
        End;
      End;
    End
{$ENDREGION}

{$REGION 'edtNumLot'}
    Else If (Sender = edtNumLot) Then
    Begin
      If edtNumLot.Visible Then
      Begin
        If fEmptyStr(edtNumLot.Text)  Then
        begin
          if blnEncontrouXML then
          begin
            edtNumLot.Text := objCadLot.fRetArmazemPrincipalVenda(edtCodIte.Text);

            if fEmptyStr(edtNumLot.Text) then
            begin
              fMensagem('ATENÇÃO!', 'Cadastre um lote principal para garantia!', ['&Ok']);
              Result := False;
            end;
          end
          else
          Begin
            fMensagem('ATENÇÃO!', 'Informe o número do ' + fatVenda.objCadLot.strTitLab + '!', ['&Ok']);
            Result := False;
          End
        end
        Else if not objCadLot.fExisteLote(fRetCodItem(edtCodIte.Text),VS_strCodEmp, edtNumLot.Text) Then
        Begin
          fMensagem('ATENÇÃO!', objCadLot.strTitLab + ' não encontrado!', ['&Ok']);
          Result := False;
        End

        Else If SameText(edtNumLot.Text ,'A DEFINIR') Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse ' + objCadLot.strTitLab + ' somente pode ser utilizado com entrega Futura!', ['&Ok']);
          Result := False;
        End;
      end;
    end
{$ENDREGION}

{$REGION 'edtFavorecido'}
    {*****************************************}
    {* VALIDA FAVORECIDO                     *}
    {**************************************RL*}
    Else if (Sender = edtFavorecido) then
    begin
      if edtFavorecido.visible then
      begin
        Result := fValidarFavorecido;
        if (Not Result) and (fEmptyStr(edtFavorecido.Text)) then
            fMensagem('','O Favorecido deve ser preenchido.',['&Ok']);
      end;
    end
{$ENDREGION}


{$REGION 'edtUniCrd'}
      Else if (Sender = edtUniCrd) then
      begin
        if edtUniCrd.visible then
        begin
          If fEmptyStr(edtUniCrd.Text) Then
          Begin

            fMensagem('ATENÇÃO!', 'O valor unitário de crédito deve ser preenchido!', ['&Ok']);
            Result := False;
          End
          Else If fStrToFloat(edtUniCrd.Text) <= 0 Then
          Begin

            fMensagem('ATENÇÃO!', 'O valor unitário de crédito deve ser maior que Zero!', ['&O k']);
            Result := False;

          End
          else
          begin
            Result := fValidarVariacaoCredito(fStrToFloat(edtUniCrd.Text), strMsg);
            if (Not Result)  then
              fMensagem('','Valor unitário de crédito inválido! '+strMsg,['&Ok']);
          end;
        end;
      end;
{$EndREGION 'edtUniCrd'}

  End;

  If Not (Result) Then
    pSetFocus(Sender);

end;

procedure TfrmGarantiaRecCliente.FormCreate(Sender: TObject);
Var
  objCodIteDef: TFieldDef;
begin
  inherited;
  FPerguntarAplicarVendedorTodosItens := True;
  FEditandoItem := False;
  blnUtilizaChecklistGarantia := False;
  blnPermiteInserirItens := False;
  pCarregarCFGs;
  pSetTipoGarantia(TTipoGarantia.Padrao);
  strFornecedorFilial := fObterFornecedorFilial(VS_strCodEmp);

  pSetaCodIte( edtCodIte );

  blnTemST := False;
  strCodCliCre := '';
  qryAD     := fCriaQuery;
  objMovGag := TMovGag.Create(Self);
  objLiberacao := TLiberacao.Create;

  pSetaCodIte(cdsItensCODITE);
  objCodIteDef := cdsItens.FieldDefs.Find('CODITE');
  If assigned(objCodIteDef) Then
    pSetaCodIte(objCodIteDef);

  strCodCliAnt := '';
  cdsItens.CreateDataSet;
  cdsItens.AfterScroll := pHabilitaBotoes;

  mskDtaEnt.Text := DateToStr(VS_Date);

  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);

  pCreateFatVendas;

  objCadLot := TCadLot.Create(Self);
  lblNumLot.Caption := objCadLot.strTitLab + ' Saída:';

  cdsGroup           := TUniClientDataSet.Create(Self);
  cdsGroup.FieldDefs := cdsItens.FieldDefs;
  cdsGroup.CreateDataSet;

  strCliEst := fCadEmp('ESTADO');

  btnAdicionar.Tag   := 0;
  edtCodIte.ReadOnly := False;

  chkCredito.Visible := blnGeraCreditoNoRecebimento;
  chkReposicao.Visible :=  blnHabilitarOpcaoReposicao;

  FModoGarantia:= TModoGarantia.Create;
  FModoGarantia.pSetCheckBox(TOperacaoGarantia.ogReposicao, chkReposicao);
  FModoGarantia.pSetCheckBox(TOperacaoGarantia.ogCredito, chkCredito);

  If fVaiUtilizarAD Then
  Begin
    pnlProdutos.Visible := False;
    btnImportarXML.Visible := False;
    btnNotEle.Visible := False;
  End;

  cdsAdeDet := TZClient.Create(Self, 'SELECT * FROM ADEDET WHERE FALSE');;
  cdsAdeDet.fAbreClient(True, '');
  blnReabreAD := False;

  fltDesAce := 0;

  pAjustaLoteSaida;

  if fCfgSis('AUTCEN', varBoolean) then
  begin
    mskPlaVei.Visible := True;
    lblPlaVei.Visible := True;
    pRedimensionaObj(edtNomCli, lblPlaVei, rdDiminui)
  end
  else
  begin
    mskPlaVei.Visible := False;
    lblPlaVei.Visible := False;
    pRedimensionaObj(edtNomCli, mskPlaVei, rdAumenta);
  end;

  blnLiberouADComSenha := False;
  FListaItensSemDocumento := TListaItensSemDocumento.create;
  blnImportandoXML := False;
  pExibirFavorecido(False);

  objAuditoriaSaldo := TAuditoriaGravacaoSaldo.New;
end;

procedure TfrmGarantiaRecCliente.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FModoGarantia);
  FreeAndNil(FListaItensSemDocumento);
  FreeAndNil(objCadLot);
  FreeAndNil(objMovGag);
  FreeAndNil(qryConOpe);
  FreeAndNil(qryAD);
  FreeAndNil(cdsAdeDet);
  pDestroyFatVendas;
  pFreeCdsVenda;
  inherited;
end;

{*******************************************}
{* CONSULTA CLIENTE                        *}
{****************************************RL*}
procedure TfrmGarantiaRecCliente.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;

begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
    begin
      SelectNext((ActiveControl), True, True);
    end;
  End;
end;

{*******************************************}
{* CONSULTA PRODUTOS                       *}
{****************************************RL*}
procedure TfrmGarantiaRecCliente.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    strTabPre: String;
    arrSel : TConsultasArray;
begin
  inherited;

  If (blnLerCodigoBarras) Or (edtCodIte.ReadOnly = True) Then
    Exit;

  If fEntraCons(Key) Then
  Begin
    strTabPre := fRetTabPrecoCliente(edtCodCli.Text);
     Try
      if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, Nil, Key, arrSel, True, nil, 'Consulta de Itens', strTabPre, '', 0, False, False, 3) then
      Begin
        If fValidaCampos(edtCodIte, True) Then
          SelectNext((ActiveControl), True, True);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[edtCodIteKeyPress]');
      End;
    End;
  End;
end;

procedure TfrmGarantiaRecCliente.edtFavorecidoExit(Sender: TObject);
Var
    strNomeFavorecido: String;
    strFavorecido: String;
begin
  inherited;
  strFavorecido := EmptyStr;
  strNomeFavorecido := EmptyStr;

  strFavorecido := edtFavorecido.Text;

  if fEmptyStr(strFavorecido) then
  begin
    Exit;
  end;
  edtNomeFavorecido.Text := EmptyStr;
  strNomeFavorecido := fRetNomCliente(edtFavorecido.Text);

  If Not fEmptyStr(strNomeFavorecido) then
  Begin
    edtNomeFavorecido.Text := strNomeFavorecido;
    if Not fValidarFavorecido then
    begin
      abort;
    end;
  End
  Else
  begin
    fMensagem('','Cliente favorecido não encontrado!',['&Ok']);
    Abort;
  end;
end;

procedure TfrmGarantiaRecCliente.edtFavorecidoKeyPress(Sender: TObject; var Key: Char);
Var
    arrClientes: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtFavorecido, edtNomeFavorecido, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtFavorecido, True) Then
    begin
      SelectNext((ActiveControl), True, True);
    end;
  End;
end;

procedure TfrmGarantiaRecCliente.edtNumLotKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrNumLot : TConsultasArray;
begin
  inherited;
  If fPesqLoteItens(Self,                             {Self       : TForm;}
                    edtNumLot,                        {edtNumLote : TCustomEdit;}
                    nil,                              {edtCodIte  : TCustomEdit;}
                    intQtdCasasDecimaisValorUnitario, {intDecUni  : Integer;}
                    Nil,                              {qryTabela  : TUniQuery;}
                    Key,                              {Var chrKey : Char;}
                    arrNumLot,                        {Var arrSel : TConsultasArray;}
                    True,                             {blnConSim  : Boolean = True;}
                    fRetCodItem(edtCodIte.Text),      {strCodIte  : String = '';}
                    '',                               {strCodEmp  : String = '';}
                    False,                            {blnSoAtivos: Boolean = False;}
                    False,                            {blnRetNumLot: Boolean = False;}
                    Nil,                              {stlItensComLoteSemLocalizacao : TStringList = nil;}
                    False,                            {blnConsiderarLoteGarantia : Boolean = True;}
                    False) Then                       {blnConsiderarADefinir: Boolean = True;}
  Begin
    If fValidaCampos(edtNumLot, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGarantiaRecCliente.edtUniCrdExit(Sender: TObject);
  Var
    lstrMsg: String;
    lfltUniCrd: Double;
begin
  inherited;
  lfltUniCrd := fStrToFloat(edtUniCrd.Text);
  if lfltUniCrd <> fltUniCrdOri then
  begin
    if fValidarVariacaoCredito(lfltUniCrd, lstrMsg) then
      fltUniCrd := fStrToFloat(edtUniCrd.Text)
    else
      edtUniCrd.Text := formatFloat('#0.00', fltUniCrdOri);
  end;
end;

procedure TfrmGarantiaRecCliente.edtCodIteExit(Sender: TObject);
  Var
    RespSelecaoDocumento: TRespSelecaoDocumento;
    strCodAde: String;
    blnFaltaDocVenda: Boolean;
    strMsg: String;
begin
  inherited;

  If Not fEmptyStr(edtCodIte.Text) Then
  Begin
    if FEditandoItem then
      Exit;

    pSetSolicitarLiberacaoItemSemNotaVenda(False);

    blnFaltaDocVenda := True;
    pRetDadosItem(fRetCodItem(edtCodIte.Text),
                  strNomPro,
                  strRefere,
                  strMarca,
                  strUnidad);

    edtDesIte.Text     := strNomPro;
    edtReferencia.Text := strRefere;
    edtDesUni.Text     := fRetNomUnidade(strUnidad);

    if edtNumLot.Visible then
    begin
      edtNumLot.Text := objCadLot.fRetArmazemPrincipalVenda(edtCodIte.Text);
    end;

    If fEmptyStr(strNomPro) Then
    Begin
      pLimpaEdits(False, True);
      fMensagem('', 'Produto não encontrado !', ['&Ok']);
      pSetFocus(edtCodIte);
      blnResEdtCodIteExit := False;
      Exit;
    End;

    If Not IsItemAtivo(fRetCodItem(edtCodIte.Text)) Then
    Begin
      pLimpaEdits(False, True);
      fMensagem('ATENÇÃO!', 'Esse item está Inativo!', ['&O k']);
      pSetFocus(edtCodIte);
      blnResEdtCodIteExit := False;
      Exit;
    End;

    Try
      {*******************************************}
      {* CARREGA TELA DE DOCUMENTOS DE VENDA     *}
      {****************************************RL*}
      strCodVenOri:= '';
      strSeqDoc := '';
      fltUniCrd := 0;
      fltUniCrdOri := 0;
      strDocFat := '';
      strNumDoc := '';
      strEmpDoc := '';
      strIncOri := '';
      fltDispon := 0;
      fltQtdIte := 0;
      fltValIte := 0;
      fltDesAceD:= 0;

      fltDetUnitar := 0;
      fltDetDesEsp := 0;
      fltDetDesCff := 0;

      pSetValorUniCrd(0);
      If Not fClienteFilial(edtCodCli.Text) Then
      Begin
        if fVaiUtilizarAD and (Assigned(qryAD) and Not QryAd.IsEmpty) then
          strCodAde := qryAD.FieldByName('GER_CODADE').AsString
        else
          strCodAde := EmptyStr;

        If (Not fValidarAoConfirmarRecebiemento) then
          RespSelecaoDocumento := TRespSelecaoDocumento.NaoSelecionado
        else
          RespSelecaoDocumento := fSelecionarDocumentoVenda(strCodAde, edtCodCli.Text, edtNomCli.Text, edtCodIte.Text,
              edtDesIte.Text, edtDesUni.Text, mskPlaVei.Text);

        case RespSelecaoDocumento of
          TRespSelecaoDocumento.Selecionado:
            Begin
              blnFaltaDocVenda := False;
              strSeqDoc := arrDocumentosVendas[0].strSeqDoc;
              strNumDoc := arrDocumentosVendas[0].strNumDoc;
              strEmpDoc := arrDocumentosVendas[0].strEmpDoc;
              strCodVenOri := arrDocumentosVendas[0].strCodVenOri;
              fltDispon := arrDocumentosVendas[0].fltDispon;
              fltQtdIte := arrDocumentosVendas[0].fltQtdIte;
              fltValIte := arrDocumentosVendas[0].fltValIte;
              fltUNICRD := arrDocumentosVendas[0].fltUNICRD;
              fltUniCrdOri := fltUNICRD;
              edtUniCrd.Text := FormatFloat('#0.00',fltUNICRD);
              fltDesAceD:= arrDocumentosVendas[0].fltDesAceD;
              strDocFat := arrDocumentosVendas[0].strDocFat;
              strIncOri := arrDocumentosVendas[0].strIncOri;
              strTabela := arrDocumentosVendas[0].strTabela;
              strDataVenda := arrDocumentosVendas[0].strDataVenda;

              fltDetUnitar := arrDocumentosVendas[0].fltDET_UNITAR;
              fltDetDesEsp := arrDocumentosVendas[0].fltDET_DESESP;
              fltDetDesCff := arrDocumentosVendas[0].fltDET_DESCFF;

              if Not (edtFavorecido.Visible
                      and Not fEmptyStr(edtFavorecido.Text)) then
              begin
                if Not fExigirFavorecido(edtCodCli.Text,
                                         edtNomCli.Text,
                                         chkCredito.Checked) then
                   fDigDadosConsumidor(arrDocumentosVendas[0].Det_NumDoc,
                                       arrDocumentosVendas[0].Det_EspDoc,
                                       arrDocumentosVendas[0].strEmpDoc,
                                       True);
              end;

            End;

          TRespSelecaoDocumento.NaoEncontrado:
            Begin
              strMsg := 'Não foi encontrado nenhum documento dentro do prazo' + #13 +'de garantia para o produto informado!';
            End;

          TRespSelecaoDocumento.NaoSelecionado:
            Begin
              strMsg := 'É preciso selecionar o documento dentro do prazo de' + #13 + 'garantia referente ao produto informado para prosseguir!';
            End;
        end;

        {$REGION 'Falta Documento de Venda'}
        if blnFaltaDocVenda and blnPermitirLiberarSemNotaVenda then
        begin
          pSetSolicitarLiberacaoItemSemNotaVenda(True);
          pExibirEdtUniCrd;
          pSetValorUniCrd(fRetPreCus(VS_strCodEmp, edtCodIte.Text));

        end
        else if blnFaltaDocVenda then
        begin
          fMensagem('', strMsg, ['&Ok']);
          blnResEdtCodIteExit := False;
          edtCodIte.Clear;
          edtNumLot.Clear;
          pSetFocus(edtCodIte);
        end;
        {$ENDREGION}
      End
      Else
      Begin
        pSetValorUniCrd(fRetPreCus(VS_strCodEmp, edtCodIte.Text));
        strEmpDoc := VS_strCodEmp;
      End;

      if blnUtilizaChecklistGarantia then
        TCheckListGarantiaController.pImprimirCheckListGarantiaMercadoriaItem(edtCodIte.Text, VS_strCodEmp, True);

      pHabilitaOBS;
    Except
      On E: Exception Do
      Begin
        blnResEdtCodIteExit := False;
        pMensagensErro(E.Message,'[TfrmGarantiaRecCliente.edtCodIteExit]');
      End;
    End;

  End
  Else
    pLimpaEdits(False, True);

end;

{*******************************************}
{* LIMPA CONTEÚDO DOS EDITS                *}
{****************************************RL*}
procedure TfrmGarantiaRecCliente.pLimpaEdits(blnGarantia,
  blnProdutos: Boolean);
begin

  If blnGarantia Then
  Begin

    edtSenVen.Clear;
    edtNomVen.Clear;
    edtCodCli.Clear;
    edtNomCli.Clear;
    mskPlaVei.Clear;

  End;

  If blnProdutos Then
  Begin
    FEditandoItem := False;
    pSetValorUniCrd(0);
    edtCodIte.Clear;
    edtNumLot.Clear;
    edtDesIte.Clear;
    edtReferencia.Clear;
    edtDesUni.Clear;
    edtQtdIte.Text := '0,00';

    edtObsP_1.Clear;
    edtObsP_2.Clear;

    If Not edtObsP_1.ReadOnly Then
    Begin
      edtObsP_1.Color   := $00FFDFB8;
      edtObsP_1.ReadOnly:= True;
      edtObsP_1.TabStop := False;
      edtObsP_2.Color   := $00FFDFB8;
      edtObsP_2.ReadOnly:= True;
      edtObsP_2.TabStop := False;

    End;

  End;
  pSetSolicitarLiberacaoItemSemNotaVenda(False);
end;

procedure TfrmGarantiaRecCliente.pLimparClienteMovGag;
begin
  objMovGag.strNomCon := EmptyStr;
  objMovGag.strEndCon := EmptyStr;
  objMovGag.strBaiCon := EmptyStr;
  objMovGag.strCepCon := EmptyStr;
  objMovGag.strCidCon := EmptyStr;
  objMovGag.strEstCon := EmptyStr;
  objMovGag.strTelCon := EmptyStr;
  objMovGag.strCgcCon := EmptyStr;
  objMovGag.strRg_Con := EmptyStr;
  objMovGag.strNomCid := EmptyStr;
  objMovGag.strCodAti := EmptyStr;
  objMovGag.strNomCid := EmptyStr;
  objMovGag.intCgcCpf := 0;
  objMovGag.strIesCon := EmptyStr;
  objMovGag.strEmaCon := EmptyStr;
end;

procedure TfrmGarantiaRecCliente.pStepStatusGravacao(
  pgbProgresso: TcxProgressBar);
begin
  If Assigned(pgbProgresso) Then
  Begin
    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;
end;



procedure TfrmGarantiaRecCliente.ValidarLoteSaidaSelecionado(Sender: TField);
  Var
    blnAbortar: Boolean;
    strCodIte: String;

begin
  inherited;

  blnAbortar := False;
  strCodIte := fRetCodItem(cdsItensCODITE.Text);

  if Not objCadLot.fExisteLote(strCodIte, VS_strCodEmp) then
  begin
    fMensagem('ATENÇÃO!', 'Não existe lote cadastrado para o produto!', ['&Ok']);
    blnAbortar := True;
  end

  else  If fEmptyStr(Sender.asString)  Then
  begin
    fMensagem('ATENÇÃO!', 'Informe um lote para o produto!', ['&Ok']);
    blnAbortar := True;
  end

  else if Not objCadLot.fExisteLote(strCodIte,VS_strCodEmp, Sender.AsString) then
  Begin
    fMensagem('ATENÇÃO!', objCadLot.strTitLab + ' não encontrado!', ['&Ok']);
    blnAbortar := True;
  End

  Else If SameText(Sender.Text ,'A DEFINIR') Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse ' + objCadLot.strTitLab + ' somente pode ser utilizado com entrega Futura!', ['&Ok']);
    blnAbortar := True;
  End;

  if blnAbortar then
    Abort;
end;

function TfrmGarantiaRecCliente.fVerificaLoteProduto(Var strNumLot: String): Boolean;
  Var
    qryTmp : TUniQuery;
    strCodIte: String;
begin

  Result := False;
  strCodIte := fRetCodItem(edtCodIte.Text);

  If Not fClienteFilial(edtCodCli.Text) Then
  Begin
    qryTmp := fCriaQuery;
    Try
      If Not objMovGag.objMovGad.fCarregaDocVendas(qryTmp, edtCodCli.Text, strCodIte , True, mskPlaVei.Text) Then
      Begin
        If Not fPermitirItemSemDocumentoVenda Then
        begin
          fMensagem('', 'Não foi encontrado nenhum documento dentro do prazo' + #13 +
                        'de garantia para o produto informado!', ['&Ok']);

          edtCodIte.Clear;
          edtNumLot.Clear;
          edtDesIte.Clear;
          pSetFocus(edtCodIte);
          Exit;
        end; 
      End;
    Finally
      FreeAndNil(qryTmp)
    End;
  End;

  if Not objCadLot.fExisteLotePrincipalGarantia(edtCodIte.Text, vs_strCodEmp) then
  begin
    If not objCadLot.fExisteLoteGarantia(edtCodIte.Text, vs_strCodEmp) Then
      objCadLot.fGeraLotePrincipalGarantiaWMS(edtCodIte.Text, vs_strCodEmp);
  end;

  If (fatVenda.objCadLot.fExisteLote(strCodIte, VS_strCodEmp, '', False, False)) Then
  Begin
    if (Not fatVenda.objCadLot.fExisteLotePrincipalGarantia(strCodIte, Vs_strCodEmp)) then
    begin
      If fPermitirItemSemDocumentoVenda Then
      begin
        TCadLot.pGerarLoteGarantia(strCodIte, VS_strCodEmp);
        strNumLot := fatVenda.objCadLot.fRetArmazemPrincipalGarantia(strCodIte);
      end
      else
      begin
        pMensagemOk('O produto informado possui vínculo com ' + fatVenda.objCadLot.strTitImp + Chr(13) +
                                   'Favor informar um ' + fatVenda.objCadLot.strTitImp + ' principal para Recebimento de Garantia do Cliente! ' + Chr(13) +
                                   'Caminho: Principal -> Manutenção de Cadastros -> Produtos - ' + fatVenda.objCadLot.strTitImp);
        edtCodIte.Clear;
        edtNumLot.Clear;
        edtDesIte.Clear;
        pSetFocus(edtCodIte);
        Exit;
      end;
    end
    else
      strNumLot := fatVenda.objCadLot.fRetArmazemPrincipalGarantia(strCodIte);

    If fEmptyStr(strNumLot) Then
      strNumLot := 'A DEFINIR';
  End;
  Result := True;
end;

procedure TfrmGarantiaRecCliente.pAddItemListaSemDocumento(const strCodIte, strDesIte, strUnidade, strCodFab: String; fltQtdIte: double);
Var
  intIndex: Integer;
  aItem : TItemSemDocumento;
begin
  intIndex :=  fLocalizarItemListaSemDocumento(strCodIte);
  if intIndex >= 0 then
  begin
    aItem :=  FListaItensSemDocumento[intIndex];
    aItem.fltQtdIte := aItem.fltQtdIte + fltQtdIte;
  end
  else
  begin
    aItem := TItemSemDocumento.Create;
    aItem.strCodIte   := strCodIte;
    aItem.strDesIte   := strDesIte;
    aItem.strUnidade  := strUnidade;
    aItem.fltQtdIte   := fltQtdIte;
    aItem.strCodFab   := strCodFab;
    FListaItensSemDocumento.add(aItem);
  end;
end;

procedure TfrmGarantiaRecCliente.pAdicionarChavesReferenciadas(const pcdsItens: TDataSet;
                                                               const pfatVenda: TFatVenda);
Var
  lstrSql,
  lstrSqlBase: String;
  lstrChave: String;
  lstlChaves,
  lstlChavesNOTDET: TStringList;
  lqry: TUniQuery;

begin
  if Not (Assigned(pcdsItens) And (pcdsItens.RecordCount > 0)) then
    Exit;

  if Not Assigned(pcdsItens.FindField('INCORI')) then
    Exit;

  if Not Assigned(pfatVenda) then
    Exit;

  lstrSqlBase :=               ' SELECT DISTINCT F.FIS_ACESSO ';
  lstrSqlBase := lstrSqlBase + ' FROM %s D ';
  lstrSqlBase := lstrSqlBase + ' JOIN CADFIS F ON F.FIS_NUMDOC = D.DET_NUMDOC ';
  lstrSqlBase := lstrSqlBase + '              AND F.FIS_ESPDOC = D.DET_ESPDOC ';
  lstrSqlBase := lstrSqlBase + '              AND F.FIS_CODEMP = D.DET_CODEMP ';
  lstrSqlBase := lstrSqlBase + '              AND F.FIS_FORCLI = D.DET_CODCLI ';
  lstrSqlBase := lstrSqlBase + '              AND F.FIS_SERIE_ = D.DET_SERIE_ ';
  lstrSqlBase := lstrSqlBase + '              AND F.FIS_TIP_FC = D.DET_TIP_FC ';
  lstrSqlBase := lstrSqlBase + ' WHERE D.AUTOINCREM IN (%s) AND IFNULL(F.FIS_ACESSO,"") <> "" ';

  lqry := Nil;
  lstlChaves := Nil;
  lstlChavesNOTDET := Nil;
  lstrSql := '';
  Try
    lstlChaves := TStringList.Create;
    lstlChavesNOTDET := TStringList.Create;
    pcdsItens.First;
    While Not pcdsItens.Eof do
    begin
      lstrChave := pcdsItens.FieldByName('INCORI').AsString;
      if Not fEmptyStr(lstrChave) then
      begin
        lstrChave := QuotedStr(lstrChave);

        if (pcdsItens.FieldByname('TABELA').AsString = 'NOTGER') then
        begin
          if lstlChavesNOTDET.IndexOf(lstrChave) = -1 then
            lstlChavesNOTDET.Add(lstrChave);
        end
        else
        begin
          if lstlChaves.IndexOf(lstrChave) = -1 then
            lstlChaves.Add(lstrChave);
        end;
      end;
      pcdsItens.Next;
    end;

    if (lstlChaves.Count = 0) And (lstlChavesNOTDET.Count = 0) then
      Exit;

    if lstlChaves.count > 0 then
      lstrSql := Format(lstrSqlBase,['MOVDET', lstlChaves.CommaText]);

    if lstlChavesNOTDET.Count > 0 then
    begin
      if Not fEmptyStr(lstrSql) then
        lstrSql := lstrSql + ' UNION ';
      lStrSql := lstrSql + Format(lstrSqlBase,['NOTDET', lstlChavesNOTDET.CommaText]);
    end;

    lQry := fCriaQuery;
    lQry.Sql.Clear;
    lQry.Sql.Add(lstrSql);
    lQry.Open;

    if lQry.IsEmpty then
      Exit;

    lQry.First;
    While Not lQry.Eof do
    Begin
      SetLength(pfatVenda.arrChaveNFReferenciaDocumentos, Length(pfatVenda.arrChaveNFReferenciaDocumentos) + 1);
      pfatVenda.arrChaveNFReferenciaDocumentos[High(pfatVenda.arrChaveNFReferenciaDocumentos)] := lQry.FieldByName('FIS_ACESSO').AsString;
      lQry.Next;
    End;
  Finally
    if Assigned(lQry) then
      FreeAndNil(lQry);

    if Assigned(lstlChaves) then
      FreeAndNil(lstlChaves);

    if Assigned(lstlChavesNOTDET) then
      FreeAndNil(lstlChavesNOTDET);
  End;
end;

procedure TfrmGarantiaRecCliente.pAjustaLoteSaida;
begin

  if chkReposicao.checked and objCadLot.fExisteLote(fRetCodItem(edtCodIte.Text), VS_strCodEmp, '', False, False) then
  begin
    lblNumLot.Visible := True;
    edtNumLot.Visible := True;
    pRedimensionaObj(edtDesIte, lblNumLot, rdDiminui);
  end
  else
  begin
    lblNumLot.Visible := False;
    edtNumLot.Visible := False;
    pRedimensionaObj(edtDesIte, edtNumLot, rdAumenta);
  end;

end;

{***********************************************}
{* ADICIONA ITEM NA TABELA TEMPORÁRIA CSDITENS *}
{********************************************RL*}
procedure TfrmGarantiaRecCliente.btnAdicionarClick(Sender: TObject);
  Var
    fltValDis: Double;
    strCodFor : String;
    qryCadFor : TUniQuery;
    strWhere  : String;
    arrSel : TConsultasArray;
    Key : Char;
    blnPermitirSelecionarFornecedor: boolean;
    strCodIte: String;
    dtaDtaEnt: TDateTime;
    lblnBXSBIT: Boolean;
    lstrCodVenItem: String;
begin
  inherited;
  strCodIte := fRetCodItem(edtCodIte.Text);
  {*******************************************}
  {* VALIDAÇÃO                               *}
  {****************************************RL*}
  //Devido a entrada de mercadorias usar a pre-nota para fazer o retorno nao pode duplicar os itens no recebimento
  //ai tem que fazer 2 recebimentos. revisao 189768
  If blnRefEnt Then
  Begin
    If cdsItens.Locate('CODITE',fRetCodItem(edtCodIte.Text), []) Then
      cdsItens.Delete;
  End
  Else
  Begin
    If cdsItens.Locate('CODITE;NUMDOC;SEQDOC',VarArrayOf([strCodIte, strNumDoc, strSeqDoc]), []) Then
      cdsItens.Delete;
  End;

  if fExigirFavorecido(edtCodCli.text, edtNomCli.Text, chkCredito.Checked) and  (Not fValidarFavorecido) then
  begin
    fmensagem('Informação',' É obrigatório informar o cliente favorecido!',['&Ok']);
    Exit;
  end;

  If (chkReposicao.Checked) And (Not fVerificaQtdEstoque(fStrToFloat(edtQtdIte.Text), lblnBXSBIT)) Then
    Exit;

  If Not fValidaPanel(pnlGarantia, False) Then
    Exit;

  If fEmptyStr(edtCodCli.Text) Then
    fValidaCampos(edtCodCli, True);


   If Not fValidaPanel(pnlProdutos, False) Then
     Exit;

  If Not fVerificaCampos Then
  begin
    Exit;
  end;

  strCodFor := fRetFornecedorItem(strCodIte);
  if Not  fPermitirInserirItemDofornecedorParaTipoGarantia(strCodFor) then
  begin
    pMensagemNaoPermitirItemFornecedorTipoGarantia;
    Exit;
  end;

  blnPermitirSelecionarFornecedor := Not (blnCFG_GARIND and (strCodFor = strFornecedorFilial));
  if blnPermitirSelecionarFornecedor then
  begin
    If (fCfgSis('FORREC', varInteger) = 2) and (Not fCfgSis('TABPRF', varBoolean)) And (btnAdicionar.Tag = 0) And (fQtdFornecedoresItem(strCodIte) > 1) Then
    Begin
      Try
        qryCadFor := fCriaQuery(Self);
        key := '?';
        strWhere := ' FOR_CODFOR IN (SELECT ITE_CODFOR FROM ITEFOR WHERE ITE_CODITE = ' + QuotedStr(strCodIte)+
                                         'UNION ALL SELECT ITE_CODFOR FROM CADITE WHERE ITE_CODITE = ' + QuotedStr(strCodIte)+')';

        fMensagem('', 'Esse produto possui mais de 1 fornecedor, selecione o fornecedor do produto!', ['&OK']);
        If fPesqFornecedor(conForUltimaCompra, Self, nil, nil, qryCadFor, Key, arrSel, True, Nil, strWhere, fRetCodItem(edtCodIte.Text)) Then
          strCodFor := qryCadFor.FieldByName('FOR_CODFOR').AsString
        Else
        Begin
          fMensagem('', 'É obrigatório escolher um fornecedor para continuar!', ['&Ok']);
          Exit;
        End;
      Finally
        FreeAndNil(qryCadFor);
      End;

      if Not  fPermitirInserirItemDofornecedorParaTipoGarantia(strCodFor) then
      begin
        pMensagemNaoPermitirItemFornecedorTipoGarantia;
        Exit;
      end;
    End;
  end;
  {$Region 'Validando vendedor do item recebido em garantia'}
  Try
    if fEmptyStr(strCodVenOri) And
         fEmptyStr(strNumdoc) And
            blnSolicitarLiberacaoItemSemNotaVenda then
    begin
      if  fEmptyStr(strCodVenDig) then
      begin
        lstrCodVenItem := fDefinirVendedorItemGarantia(strCodVenOri);

        if (Not fEmptyStr(lstrCodVenItem)) And FPerguntarAplicarVendedorTodosItens then
        begin
          FPerguntarAplicarVendedorTodosItens := False;
          If fMensagem('',
                       'Deseja aplicar o código do vendedor para os demais itens, se houver?',
                       ['&Sim', '&Não']) = 1 then
          begin
            strCodVenDig := lstrCodVenItem;
          end;
        end;

      end
      else
        lstrCodVenItem := strCodVenDig;
    end
    else
    begin
      if fEmptyStr(strCodVenOri) then
        lstrCodVenItem := strCodVen
      else
        lstrCodVenItem := strCodVenOri;
    end;
  Except
    On E: EAbort do
    begin
      Exit;
    end;
  end;
  {$EndRegion 'Validando vendedor do item recebido em garantia'}
    {*******************************************}
    {* ADICIONA ITEM                           *}
    {****************************************RL*}
  Try
    cdsitensLotSai.OnValidate := Nil;
    With cdsItens Do
    Begin
      blnPermiteInserirItens := True;
      If (btnAdicionar.Tag = 1) Then
      Begin
        If Locate('NUMDOC;CODITE;SEQDOC',VarArrayOf([strCodIte, strNumDoc, strSeqDoc]), []) Then
        Begin
          Edit
        End
        Else
        Begin
          Insert;
          FieldByName('CODITE').AsString := strCodIte;
        End;
      End
      Else
      Begin
        Insert;
        FieldByName('CODITE').AsString := strCodIte;
      End;

      FieldByName('BXSBIT').AsString := ifthen(lblnBXSBIT,'S','N');
      FieldByName('QTDITE').AsFloat    := fStrToFloat(edtQtdIte.Text);
      FieldByName('PRECUS').AsFloat    := fCampoTabela('ITE_PRECUS', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [strCodIte, VS_strCodEmp]);
      FieldByName('DESITE').AsString   := edtDesIte.Text;
      FieldByName('REFERE').AsString   := edtReferencia.Text;
      FieldByName('DESUNI').AsString   := edtDesUni.Text;
      FieldByName('CODFOR').AsString   := strCodFor;

      FieldByName('ITE_CODATC').AsString := fCampoTabela('ITE_CODATC', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [strCodIte, VS_strCodEmp]);

      if blnSolicitarLiberacaoItemSemNotaVenda then
      begin
        if (Not blnImportandoXML) then
        begin
         fltQtdIte := FieldByName('QTDITE').AsFloat;
         fltDispon  := FieldByName('QTDITE').AsFloat;
         fltValIte  := (FieldByName('PRECUS').AsFloat * fltQtdIte);
         fltDesAceD := 0;
        end;

        if fEmptyStr(strEmpDoc) then
          strEmpDoc := VS_strCodEmp;

        if fEmptystr(strNumLote) then
        begin
          fVerificaLoteProduto(strNumLote);
        end;
      end;

      FieldByName('NUMLOT').AsString   := strNumLote;

      FieldByName('EMPDOC').AsString   := strEmpDoc;

      If fClienteFilial(edtCodCli.Text) Then
        fltValDis := fRetPrecoTE(FieldByName('CODITE').AsString)
      Else If (fltDispon = 0) Then
      begin
          fltValDis := 0
      end
      Else
        fltValDis := fltValIte/fltQtdIte;

      If (fltValDis <= 0) And ( Pos(edtCodCli.Text, fRetClientesFilial) > 0) Then
        fltValDis := fRetPreCus(VS_strCodEmp, strCodIte);

      FieldByName('UNICRD').AsFloat := fltUniCrd;
      FieldByName('UNICRDORI').AsFloat := fltUniCrdOri;
      FieldByName('VALITE').AsFloat    := fStrToFloat(edtQtdIte.Text) * fltValDis;
      FieldByName('SEQDOC').AsString   := strSeqDoc;
      FieldByName('NUMDOC').AsString   := strNumDoc;
      FieldByName('REPOST').AsString   := IfThen(chkReposicao.Checked, 'S', 'N');
      FieldByName('CODVEN').AsString   := lstrCodVenItem;
      FieldByName('DOCFAT').AsString   := strDocFat;
      FieldByName('INCORI').AsString   := strIncOri;
      FieldByName('TABELA').AsString   := strTabela;

      if blnClienteFilial or
          ((Not blnImportandoXML) and (blnSolicitarLiberacaoItemSemNotaVenda)) then
      begin
        FieldByName('DET_UNITAR').AsFloat := fltValDis;
        FieldByName('DET_DESESP').AsFloat := 0; //VALOR UNITÁRIO
        FieldByName('DET_DESCFF').AsFloat := 0;  //VALOR UNITÁRIO
      end
      Else Begin
        FieldByName('DET_UNITAR').AsFloat := fltDetUnitar;
        FieldByName('DET_DESESP').AsFloat := fltDetDesEsp / fltQtdIte; //VALOR UNITÁRIO
        FieldByName('DET_DESCFF').AsFloat := fltDetDesCFF / fltQtdIte;  //VALOR UNITÁRI
      End;

      FieldByName('OBSP_1').AsString   := edtObsP_1.Text;
      FieldByName('OBSP_2').AsString   := edtObsP_2.Text;
      FieldByName('CODFAB').AsString   := fCampoTabela('ITE_CODFAB', 'CADITE', ['ITE_CODITE'], [strCodIte]);

      FieldByName('TABPRE').AsString   := fCampoTabela('CLI_TABPRE', 'CADCLI', ['CLI_CODCLI'], [edtCodCli.Text], False);

      If fEmptyStr(FieldByName('TABPRE').AsString) And fCfgSis('HIETAB', VarBoolean) Then
          FieldByName('TABPRE').AsString := fCampoTabela('OPE_TABPRE', 'CADOPE', ['OPE_CODOPE'], [FieldByName('CODVEN').AsString], False);

      FieldByName('DESACE').AsFloat    := fltDesAceD * fStrToFloat(edtQtdIte.Text);
      if TrystrToDatetime(strDataVenda, dtaDtaEnt) then
        FieldByName('DTAENT').AsDateTime := dtaDtaEnt;
      {*******************************************}
      {* CAMPO UTILIZADO PARA AUXILIAR NO CÁLCULO*}
      {* DA QUANTIDADE DA DISPONOIBILIDADE DOS   *}
      {* PRODUTOS DA NOTA.                       *}
      {* SE JA_GRAVADO = N, ENTÃO QUER DIZER QUE *}
      {* AINDA NAO FOI GRAVADO NO BANCO E PRECISA*}
      {* SER CONSIDERADO NO CÁLCULO DA QUANTIDADE*}
      {* DISPONÍVEL PARA O USUÁRIO SELECIONAR    *}
      {****************************************RL*}
      FieldByName('JA_GRAVADO').AsString := 'N';

      If chkReposicao.Checked Then
      begin
        FieldByName('QTDDEV').AsFloat  := fStrToFloat(edtQtdIte.Text);
        if edtNumLot.Visible then
        FieldByName('LOTSAI').AsString := edtNumLot.Text;
      end;

      FieldByName('GARFIL').AsString := fCampoTabela('ITE_GARFIL', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [strCodIte, VS_strCodEmp]);
      Post;

      if (Not blnImportandoXML) and (blnSolicitarLiberacaoItemSemNotaVenda) then
      begin
        pAddItemListaSemDocumento(FieldByName('CODITE').AsString, FieldByName('DESITE').AsString, FieldByName('DESUNI').AsString,
              FieldByName('CODFAB').AsString,
              FieldByName('QTDITE').AsFloat);
      end;
    End;
  Finally
    cdsItensLOTSAI.OnValidate := ValidarLoteSaidaSelecionado;;
  End;

  btnAdicionar.Tag   := 0;
  edtCodIte.ReadOnly := False;
  pLimpaEdits(False, True);
  pSetFocus(edtCodIte);

  pnlGarantia.Enabled := cdsItens.IsEmpty;

end;

procedure TfrmGarantiaRecCliente.cdsItensAfterCancel(DataSet: TDataSet);
begin
  inherited;
  blnPermiteInserirItens := False;
  if FEditandoItem then
     FEditandoItem := False;
end;

procedure TfrmGarantiaRecCliente.cdsItensAfterDelete(DataSet: TDataSet);
begin
  inherited;
  if DataSet.IsEmpty then
    pSetTipoGarantia(TTipoGarantia.Padrao);

  if FEditandoItem then
     FEditandoItem := False;
end;

procedure TfrmGarantiaRecCliente.cdsItensAfterPost(DataSet: TDataSet);
begin
  inherited;
  blnPermiteInserirItens := False;
  if FEditandoItem then
    FEditandoItem := False;
end;

procedure TfrmGarantiaRecCliente.cdsItensBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if fEmptyStr(cdsItensNUMDOC.AsString) then
  begin
    pRemoverItemListaSemDocumento(cdsItensCODITE.AsString, cdsItensQTDITE.AsFloat);
  end;
end;

procedure TfrmGarantiaRecCliente.cdsItensBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  if blnPermiteInserirItens = False then
    Abort;
end;

procedure TfrmGarantiaRecCliente.cdsItensBeforePost(DataSet: TDataSet);
Var
  strCodFor: String;
  lfltUnitarioLiquido: Double;
begin
  inherited;

   //Vl. Total
   cdsItens.FieldByName('TOTITE').AsFloat :=
     cdsItens.FieldByName('QTDITE').AsFloat *
       cdsItens.FieldByName('DET_UNITAR').AsFloat;

   lfltUnitarioLiquido :=
     cdsItens.FieldByName('DET_UNITAR').AsFloat -
       (cdsItens.FieldByName('DET_DESESP').AsFloat +
          cdsItens.FieldByName('DET_DESCFF').AsFloat);

   //Vl. Total Líq.
   cdsItens.FieldByName('TOTLIQ').AsFloat :=
     cdsItens.FieldByName('QTDITE').AsFloat *
       lfltUnitarioLiquido;

   //Descontos.
   cdsItens.FieldByName('DESCONTOS').AsFloat :=
     cdsItens.FieldByName('TOTITE').AsFloat -
       cdsItens.FieldByName('TOTLIQ').AsFloat;

  if (DataSet.State = dsinsert) and (DataSet.Recordcount = 0) then
  begin
    strCodFor := cdsItensCodFor.AsString;
    if fEmptyStr(strCodFor) then
      strCodFor := fRetFornecedorItem(fRetCodItem(edtCodIte.Text));
    pSetTipoGarantia(fObterTipoGarantia(strCodFor, strFornecedorFilial));
  end;
end;

procedure TfrmGarantiaRecCliente.cdsItensNewRecord(DataSet: TDataSet);
begin
  inherited;
  if FEditandoItem then
     FEditandoItem := False;
end;

procedure TfrmGarantiaRecCliente.cdsItensREPOSTGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  inherited;

  Text := UpperCase(String(TStringField(Sender).Value));

end;

procedure TfrmGarantiaRecCliente.chkCreditoClick(Sender: TObject);
begin
  inherited;
  pExibirFavorecido;
end;

procedure TfrmGarantiaRecCliente.pVerificarTemItemBaixarEstrutura;
begin
  FblnTemItemBaixarEstrutura := False;
  cdsItens.DisableControls;
  Try
    cdsItens.First;
    While Not cdsItens.Eof do
    begin
      if cdsItensBXSBIT.AsString = 'S' then
      begin
        FblnTemItemBaixarEstrutura := True;
        Break;
      end;
      cdsItens.Next;
    end;
  Finally
    cdsItens.EnableControls;
  End;
end;

procedure TfrmGarantiaRecCliente.chkReposicaoClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  pAjustaLoteSaida;
  btnInformarLoteItem.Enabled := chkReposicao.Checked;
  for i := 0 to Pred(dbgItens.Columns.Count) do
  begin
    if dbgItens.Columns[i].FieldName = cdsItensLOTSAI.FieldName then
    begin
      dbgItens.Columns[i].ReadOnly := Not chkReposicao.Checked;
      Break;
    end;
  end;

  pExibirFavorecido;
end;

procedure TfrmGarantiaRecCliente.pEscapePressed;
begin

  If (edtCodIte.Focused) And (btnAdicionar.Tag = 1) Then
  Begin

    btnAdicionar.Tag   := 0;
    edtCodIte.ReadOnly := False;
    pLimpaEdits(False, True);
    pSetFocus(dbgItens);

  End

  Else If (edtCodIte.Focused) Then
  Begin

    btnCancelar.Click;
    pSetFocus(mskDtaEnt);

  End

  Else If (ActiveControl.Parent = pnlProdutoPrincipal) Then
    btnCancelar.Click

  Else If (ActiveControl.Parent = pnlGarantia) And cdsItens.Active And (not cdsItens.IsEmpty)Then
  Begin
    pLimpaDados;
    pSetFocus(mskDtaEnt);
  End

  Else
    inherited;

  pnlGarantia.Enabled := cdsItens.IsEmpty;
end;



procedure TfrmGarantiaRecCliente.pEstornarEntrada(pRecDocEntrada: TRecDocGarantia);
begin
  TLibCancelamentoDocGarantia
    .pEstornarEntradaMercadoriaRecCliente(pRecDocEntrada.strAutoincrem, Self.Name);
end;

procedure TfrmGarantiaRecCliente.btnAssistenciaTecnicaClick(Sender: TObject);
begin
  inherited;
  if (cdsItens.IsEmpty) or fEmptyStr(cdsItensITE_CODATC.AsString) then
    Exit;
  TCheckListGarantiaController.pImprimirFichaAssistenciaTecnica(cdsItensITE_CODATC.AsString);
end;

procedure TfrmGarantiaRecCliente.btnCancelarClick(Sender: TObject);
begin
  inherited;

  If ActiveControl.Parent = pnlProdutoPrincipal Then
  Begin
    If edtCodIte.Focused Then
      cdsItens.EmptyDataSet
    Else
      cdsItens.Cancel;

    btnAdicionar.Tag   := 0;
    edtCodIte.ReadOnly := False;
    pLimpaEdits(((ActiveControl) = edtCodIte), True);
    pSetFocus(edtCodIte);
  End;
end;

procedure TfrmGarantiaRecCliente.pCarregaDadosFatVendas;
begin
  fatVenda.strOriDoc := 'V';
  fatVenda.strConPag := '01000';
  fatVenda.strCodVen := recPessoasOperacao.recVendedor.strCodigo;
  fatVenda.strNomVen := recPessoasOperacao.recVendedor.strNome;
  fatVenda.strCodDig := recPessoasOperacao.recDigitador.strCodigo;
  fatVenda.strNomDig := recPessoasOperacao.recDigitador.strNome;

  fatVenda2.strOriDoc := 'V';
  fatVenda2.strCodVen := fatVenda.strCodVen;
  fatVenda2.strNomVen := fatVenda.strNomVen;
  fatVenda2.strConPag := '01000';
  fatVenda2.strEntFut := 'N';
  fatVenda2.strEntFat := 'N';
  fatVenda2.strCodDig := fatVenda.strCodDig;
  fatVenda2.strNomDig := fatVenda.strNomDig;
end;

{*******************************************}
{* CARREGA DOCUMENTOS                      *}
{****************************************RL*}
procedure TfrmGarantiaRecCliente.pCarregaDocVendas(qryTmp: TUniQuery;
  cdsTmp: TUniClientDataSet);
  Var
    RecNo : Integer;
    fltQtd: Double;
    lNotifyEvent: TDataSetNotifyEvent;

    blnDesCFF: Boolean;
begin

  RecNo  := cdsItens.RecNo;
  if FEditandoItem then
    FEditandoItem := False;
  lNotifyEvent := cdsItens.AfterScroll;
  Try
    cdsItens.AfterScroll := Nil;
    cdsItens.DisableControls;

    blnDesCFF := Assigned(QryTmp.FindField('DET_DESCFF'));

    With cdsTmp Do
    Begin

      CreateDataSet;

      While Not qryTmp.Eof Do
      Begin

        fltQtd := 0;

        cdsItens.First;

        Insert;
        FieldByName('QTDSEL').AsFloat    := 0;
        FieldByName('TABELA').AsString   := QryTmp.FieldByName('TABELA').AsString;
        FieldByName('SEQDOC').AsString   := qryTmp.FieldByName('SEQDOC').AsString;
        FieldByName('NUMDOC').AsString   := qryTmp.FieldByName('NUMDOC').AsString;
        FieldByName('EMPDOC').AsString   := qryTmp.FieldByName('EMPDOC').AsString;
        FieldByName('DTAENT').AsDateTime := qryTmp.FieldByName('DTAENT').AsDateTime;
        FieldByName('DTAFIN').AsDateTime := qryTmp.FieldByName('DTAFIN').AsDateTime;
        FieldByName('VENDA_').AsFloat    := qryTmp.FieldByName('VENDA_').AsFloat;
        FieldByName('VALITE').AsFloat    := qryTmp.FieldByName('TOTITE').AsFloat;
        FieldByName('VALUNT').AsFloat    := qryTmp.FieldByName('VALUNT').AsFloat;
        FieldByName('DISPON').AsFloat    := qryTmp.FieldByName('DISPON').AsFloat;
        FieldByName('FORNEC').AsFloat    := qryTmp.FieldByName('FORNEC').AsFloat;
        FieldByName('REPOR_').AsFloat    := qryTmp.FieldByName('REPOR_').AsFloat;
        FieldByName('REFUGO').AsFloat    := qryTmp.FieldByName('REFUGO').AsFloat;
        FieldByName('PREJUI').AsFloat    := qryTmp.FieldByName('PREJUI').AsFloat;
        FieldByName('MARDES').AsString   := qryTmp.FieldByName('MARDES').AsString;
        FieldByName('TMPGAR').AsInteger  := qryTmp.FieldByName('TMPGAR').AsInteger;
        FieldByName('DOCFAT').AsString   := qryTmp.FieldByName('DOCFAT').AsString;
        FieldByName('INCORI').AsString   := qryTmp.FieldByName('INCORI').AsString;
        FieldByName('DOCVEN').AsString   := qryTmp.FieldByName('DOCVEN').AsString;

        FieldByName('DET_ESPDOC').AsString   := qryTmp.FieldByName('DET_ESPDOC').AsString;
        FieldByName('DET_NUMDOC').AsString   := qryTmp.FieldByName('DET_NUMDOC').AsString;
        FieldByName('DET_DESACE').AsFloat    := qryTmp.FieldByName('DET_DESACE').AsFloat;

        FieldByName('DEVOLU').AsFloat := fRetQuantidadeDevolvida(FieldByName('DET_NUMDOC').AsString,
                                                                 FieldByName('DET_ESPDOC').AsString,
                                                                 FieldByName('EMPDOC').AsString,
                                                                 fRetCodItem(edtCodIte.Text),
                                                                 False,
                                                                 qryTmp.FieldByName('TABELA').AsString);

        FieldByName('DISPON').AsFloat    :=  FieldByName('DISPON').AsFloat - FieldByName('DEVOLU').AsFloat;
        FieldByName('CODVEN').AsString   := QryTmp.FieldByName('CODVEN').AsString;
        FieldByName('SERIE_').AsString   := QryTmp.FieldByName('DET_SERIE_').AsString;
        FieldByName('UNICRD').AsFloat   := QryTmp.FieldByName('UNICRD').AsFloat;

        FieldByName('DET_UNITAR').AsFloat := QryTmp.FieldByName('DET_UNITAR').AsFloat;
        FieldByName('DET_DESESP').AsFloat := QryTmp.FieldByName('DET_DESESP').AsFloat;

        if blnDesCFF then
          FieldByName('DET_DESCFF').AsFloat := QryTmp.FieldByName('DET_DESCFF').AsFloat
        else
          FieldByName('DET_DESCFF').AsFloat := 0;

        While Not cdsItens.Eof do
        Begin

           {*******************************************}
           {* VERIFICA SE EXISTE PRODUTO SELECIONADO  *}
           {* QUE AINDA NÃO FORAM GRAVADO NO BANCO.   *}
           {* SE EXISTIR, CONSIDERA O PRODUTO NO      *}
           {* CÁLCULO DA QTD. DISPONÍVEL DO PRODUTO   *}
           {* QUE É MOSTRADA PARA O USUÁRIO           *}
           {****************************************RL*}
           If (cdsItens.FieldByName('NUMDOC').AsString = qryTmp.FieldByName('NUMDOC').AsString) And
              (cdsItens.FieldByName('EMPDOC').AsString = qryTmp.FieldByName('EMPDOC').AsString) And
              (cdsItens.FieldByName('JA_GRAVADO').AsString <> 'S') Then
           Begin

             fltQtd := fltQtd + cdsItens.FieldByName('QTDITE').AsFloat;

             FieldByName('DISPON').AsFloat := qryTmp.FieldByName('DISPON').AsFloat;

            { If SameText(cdsItens.FieldByName('REPOST').AsString,'S') Then
               FieldByName('REPOR_').AsFloat := FieldByName('REPOR_').AsFloat +
                                                 cdsItens.FieldByName('QTDITE').AsFloat;}


           End;

          cdsItens.Next;

        End;

        If FieldByName('DISPON').AsFloat = 0 Then
          Cancel
        Else
          Post;

        qryTmp.Next;
      End;

    End;
  Finally
    cdsItens.RecNo := RecNo;
    cdsItens.EnableControls;
    cdsItens.AfterScroll := lNotifyEvent;
  End;
end;

procedure TfrmGarantiaRecCliente.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case key of
    VK_F10: Begin
              Key := 0;

              If Not btnConfirmar.Enabled Then
                Exit;

              btnConfirmar.Click;

            End;
    VK_F3: btnInformarLoteItem.Click;

    VK_F4: begin
             if btnAssistenciaTecnica.Visible then
              btnAssistenciaTecnica.Click;
           end;
  end;

end;

procedure TfrmGarantiaRecCliente.FormShow(Sender: TObject);
begin
  inherited;
  If blnLerCodigoBarras Then
  Begin
    edtCodIte.MaxLength := 20;
    edtCodIte.TamCampo  := 0;
    edtCodIte.CompZeros := False;
  End;

  If fEmptyStr(fCfgSis('CRECGC', varString)) Then
  Begin
    fMensagem('', '"A configuracao [CFG_CRECGC - Classificacao Fiscal para Recebimento de Garantia do Cliente] não está preenchida.' +
                  ' Acessar grupo de GARANTIA nas configurações do sistema para preencher este parametro."', ['&O K']);
    blnFecharFormPai := True;
    Close;
  End;

  If fEmptyStr(fCfgSis('CREPGC', varString)) Then
  Begin
    fMensagem('', '"A configuracao [CFG_CREPGC - Classificacao Fiscal para Reposição de Garantia ao Cliente] não está preenchida.' +
                  ' Acessar grupo de GARANTIA nas configurações do sistema para preencher este parametro."', ['&O K']);
    blnFecharFormPai := True;
    Close;
  End;

  blnEmpGar := (fCfgSis('EMPGAR', varString) = VS_strCodEmp);

  pSetFocus(mskDtaEnt);

  if (VS_strHabilitarCRM) And blnUtiAd then
  begin
    if (fGetMenu('Escolha o Tipo de Liberação:', ['Liberação com AD', 'Digitar senha de liberação'], 1) = 2) then
    begin
      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'EDSUAD';
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('Entrada de Devolução/Garantia sem vinculo de uma Autorização de Devolução (AD).');

      blnLiberouADComSenha := objLiberacao.fLibera;
    end;
  end;
  if blnUtilizaChecklistGarantia then
    pConfigurarUtilizaCheckList;
end;

{*******************************************}
{* CARREGA ITENS DA GRID PARA ALTERAÇÃO    *}
{****************************************RL*}
procedure TfrmGarantiaRecCliente.pCarregaItensAlteracao(pHabilitarEdicao: Boolean);
begin
  if cdsItens.IsEmpty then
    Exit;

  pSetSolicitarLiberacaoItemSemNotaVenda(fEmptyStr(cdsItensNUMDOC.AsString));
  pExibirEdtUniCrd;
  edtCodIte.Text := cdsItens.FieldByName('CODITE').AsString;
  edtDesIte.Text := cdsItens.FieldByName('DESITE').AsString;
  edtReferencia.Text := cdsItens.FieldByName('REFERE').AsString;
  edtDesUni.Text := cdsItens.FieldByName('DESUNI').AsString;
  edtQtdIte.Text := FloatToStrF(cdsItens.FieldByName('QTDITE').AsFloat, ffFixed, 12, 2);
  fltQtdIte      := cdsItens.FieldByName('QTDITE').AsFloat;
  strIncOri := cdsItens.FieldByName('INCORI').AsString;
  strTabela := cdsItens.FieldByName('TABELA').AsString;
  fltDetUnitar := cdsItens.FieldByName('DET_UNITAR').AsFloat;
  fltDetDesEsp := cdsItens.FieldByName('DET_DESESP').AsFloat;
  fltDetDesCFF := cdsItens.FieldByName('DET_DESCFF').AsFloat;

  edtObsP_1.Text := cdsItens.FieldByName('OBSP_1').AsString;
  edtObsP_2.Text := cdsItens.FieldByName('OBSP_2').AsString;
  pSetValorUniCrd(cdsItens.FieldByName('UNICRDORI').AsFloat, cdsItens.FieldByName('UNICRD').AsFloat);

  if edtNumLot.Visible then
    edtNumLot.Text  :=  cdsItens.FieldByName('LOTSAI').AsString;

  if not (fVaiUtilizarAD or fImportouXml) then
    pHabilitaOBS;

  if Not pHabilitarEdicao then
  begin
    btnAdicionar.Tag   := 1;
    edtCodIte.ReadOnly := True;
    Exit;
  end;

  if fVaiUtilizarAD or fImportouXml then
  begin
    fDigitaObsItem;
    Exit;
  end;

  pSetFocus(btnAdicionar);


  FEditandoItem := True;
  If (btnAdicionar.Tag = 1) Then
    btnAdicionar.Tag   := 0;

  if btnConfirmar.Enabled then
    btnConfirmar.Enabled  := False;
end;

procedure TfrmGarantiaRecCliente.pCreateFatVendas;
begin
  pCriarCdsVenda(Self);
  fatVenda                := TFatVenda.CreateInstance('VN', False);
  fatVenda.strOpcDocTrue  := 'NW';
  fatVenda.blnVerEstOrc   := False;
  fatVenda.strNomeForm    := 'frmFatVendas';
  fatVenda.blnComTansacao := True;
  fatVenda.strEntFat      := 'N';
  fatVenda.fAntesEmitirNotaFiscal := fAntesConfirmarEntrada;

  fatVenda2                := TFatVenda.CreateInstance('VN');
  fatVenda2.strOpcDocTrue   := 'GC';
  fatVenda2.blnVerEstOrc   := False;
  fatVenda2.strNomeForm    := 'frmFatVendas';
  fatVenda2.blnComTansacao := True;
  fatVenda2.strEntFat      := 'N';
end;

procedure TfrmGarantiaRecCliente.pDestroyFatVendas;
begin
  If Assigned(fatVenda) Then
    FreeAndNil(fatVenda);
  If Assigned(fatVenda2) Then
    FreeAndNil(fatVenda2);

end;

function TfrmGarantiaRecCliente.fDigitaObsItem:Boolean;
Begin
  Result := True;

  If cdsItens.IsEmpty Or (not cdsItens.Active) Then
    Exit;

  Try
    pCriarFormularios(TfrmObsGarantia, frmObsGarantia);
    frmObsGarantia.edtObs1.Text := cdsItens.FieldByName('OBSP_1').AsString;
    frmObsGarantia.edtObs2.Text := cdsItens.FieldByName('OBSP_2').AsString;
    frmObsGarantia.ShowModal;
    Result := (frmObsGarantia.ModalResult = mrOk);

    If Result Then
    Begin
      cdsItens.Edit;
      cdsItens.FieldByName('OBSP_1').AsString := frmObsGarantia.edtObs1.Text;
      cdsItens.FieldByName('OBSP_2').AsString := frmObsGarantia.edtObs2.Text;
      cdsItens.Post;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmGarantiaRecCliente.fDigitaObsItem]');
    End;
  End;
  pFreeAndNil(frmObsGarantia);
End;

function TfrmGarantiaRecCliente.fDigDadosConsumidor(const strNumDoc, strEspDoc,
  strCodEmp: String; blnCarregaTela: Boolean): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  Result := True;
  Try
    If blnCarregaTela And (fEmptyStr(objMovGag.strNomCon)) Then
    Begin
      strCodCliCre := '';
      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   GAG_NUMENT, ';
      strSQL := strSQL + '   COALESCE(GAG_CODCLI, GER_CODCLI) AS GER_CODCLI, ';
      strSQL := strSQL + '   COALESCE(GAG_NOMCON, GER_NOMCON) AS GAG_NOMCON, ';
      strSQL := strSQL + '   COALESCE(GAG_ENDCON, GER_ENDCON) AS GAG_ENDCON, ';
      strSQL := strSQL + '   COALESCE(GAG_BAICON, GER_BAICON) AS GAG_BAICON, ';
      strSQL := strSQL + '   COALESCE(GAG_CEPCON, GER_CEPCON) AS GAG_CEPCON, ';
      strSQL := strSQL + '   COALESCE(GAG_CIDCON, GER_CIDCON) AS GAG_CIDCON, ';
      strSQL := strSQL + '   CID_NOMCID, ';
      strSQL := strSQL + '   COALESCE(GAG_ESTCON, GER_ESTCON) AS GAG_ESTCON, ';
      strSQL := strSQL + '   COALESCE(GAG_TELCON, GER_TELCON) AS GAG_TELCON, ';
      strSQL := strSQL + '   COALESCE(GAG_CGCCPF, GER_CGCCPF) AS GAG_CGCCPF, ';
      strSQL := strSQL + '   COALESCE(GAG_CGCCON, GER_CGCCON) AS GAG_CGCCON, ';
      strSQL := strSQL + '   COALESCE(GAG_IESCON, GER_IESCON) AS GAG_IESCON, ';
      strSQL := strSQL + '   COALESCE(GAG_R_GCON, GER_R_GCON) AS GAG_R_GCON, ';
      strSQL := strSQL + '   COALESCE(GAG_EMLCON, GER_EMLCON) AS GAG_EMLCON, ';
      strSQL := strSQL + '   GAG_CODATI, ';
      strSQL := strSQL + '   ATI_DESATI, ';
      strSQL := strSQL + '   CLI_NOMCLI ';
      strSQL := strSQL + ' FROM MOVGER ';
      strSQL := strSQL + ' LEFT JOIN MOVGAD ON MOVGER.GER_NUMDOC = MOVGAD.GAD_NUMDOC AND  ';
      strSQL := strSQL + '                MOVGER.GER_ESPDOC = MOVGAD.GAD_ESPDOC AND  ';
      strSQL := strSQL + '                MOVGER.GER_CODEMP = MOVGAD.GAD_CODEMP ';
      strSQL := strSQL + ' LEFT JOIN MOVGAG ON MOVGAD.GAD_SEQGAG = MOVGAG.AUTOINCREM ';
      strSQL := strSQL + ' LEFT JOIN CADCID ON CADCID.CID_CODCID = COALESCE(GAG_CIDCON, GER_CIDCON) ';
      strSQL := strSQL + ' LEFT JOIN CADCLI ON CADCLI.CLI_CODCLI = COALESCE(GAG_CODCLI, GER_CODCLI) ';
      strSQL := strSQL + ' LEFT JOIN CADATI ON CADATI.ATI_CODATI = GAG_CODATI ';
      strSQL := strSQL + ' WHERE GER_NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + '       GER_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '       GER_ESPDOC = :ESPDOC ';

      qryGen := fCriaQuery(Self);

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;

        If Not IsEmpty Then
        Begin
          pCriarFormularios(TfrmFatDadosCliConsumidor, frmFatDadosCliConsumidor);

          If fClienteConsumidor(FieldByName('CLI_NOMCLI').AsString, False, True) Then
          Begin
            With frmFatDadosCliConsumidor Do
            Begin
              strCodCli      := FieldByName('GER_CODCLI').AsString;
              edtNomCli.Text := IIF(fEmptyStr(objMovGag.strNomCon), FieldByName('GAG_NOMCON').AsString, objMovGag.strNomCon);
              edtEndere.Text := IIF(fEmptyStr(objMovGag.strEndCon), FieldByName('GAG_ENDCON').AsString, objMovGag.strEndCon);
              edtBairro.Text := IIF(fEmptyStr(objMovGag.strBaiCon), FieldByName('GAG_BAICON').AsString, objMovGag.strBaiCon);
              mskNumCep.Text := IIF(fEmptyStr(objMovGag.strCepCon), FieldByName('GAG_CEPCON').AsString, objMovGag.strCepCon);
              edtCodCid.Text := IIF(fEmptyStr(objMovGag.strCidCon), FieldByName('GAG_CIDCON').AsString, objMovGag.strCidCon);
              edtNomCid.Text := IIF(fEmptyStr(objMovGag.strNomCid), FieldByName('CID_NOMCID').AsString, objMovGag.strNomCid);
              edtEstado.Text := IIF(fEmptyStr(objMovGag.strEstCon), FieldByName('GAG_ESTCON').AsString, objMovGag.strEstCon);
              mskTelCon.Text := IIF(fEmptyStr(objMovGag.strTelCon), FieldByName('GAG_TELCON').AsString, objMovGag.strTelCon);
              edtCgcCpf.Text := IIF(objMovGag.intCgcCpf = 0, FieldByName('GAG_CGCCPF').AsString, IntToStr(objMovGag.intCgcCpf));
              mskNumCgc.Text := IIF(fEmptyStr(objMovGag.strCgcCon), FieldByName('GAG_CGCCON').AsString, objMovGag.strCgcCon);
              edtInsEst.Text := IIF(fEmptyStr(objMovGag.strIesCon), FieldByName('GAG_IESCON').AsString, objMovGag.strIesCon);
              edtRgCli.Text  := IIF(fEmptyStr(objMovGag.strRg_Con), FieldByName('GAG_R_GCON').AsString, objMovGag.strRg_Con);

              If fEmptyStr(IIF(fEmptyStr(objMovGag.strEstCon), FieldByName('GAG_ESTCON').AsString, objMovGag.strEstCon)) Then
                strEstado    := fCadEmp('ESTADO')
              Else
                strEstado    := IIF(fEmptyStr(objMovGag.strEstCon), FieldByName('GAG_ESTCON').AsString, objMovGag.strEstCon);

              blnCGCRep      := False;
              edtEmail_.Text := IIF(fEmptyStr(objMovGag.strEmaCon), FieldByName('GAG_EMLCON').AsString, objMovGag.strEmaCon);

              If (fCfgSis('PRECAD', varBoolean)) Then
              Begin
                edtCodAtividade.Text := IIF(fEmptyStr(objMovGag.strCodAti), FieldByName('GAG_CODATI').AsString, objMovGag.strCodAti);
                edtNomAtividade.Text := IIF(fEmptyStr(objMovGag.strNomAti), FieldByName('ATI_DESATI').AsString, objMovGag.strNomAti);
              End;

              blnUtilizarPreCadastroConsumidor := False;

              ShowModal;

              Result := blnConfirma;

              If Result Then
              Begin
                objMovGag.strNomCon := edtNomCli.Text;
                objMovGag.strEndCon := edtEndere.Text;
                objMovGag.strBaiCon := edtBairro.Text;
                objMovGag.strCepCon := mskNumCep.Text;
                objMovGag.strCidCon := edtCodCid.Text;
                objMovGag.strEstCon := edtEstado.Text;
                objMovGag.strTelCon := mskTelCon.Text;
                objMovGag.strCgcCon := mskNumCgc.Text;
                objMovGag.strRg_Con := edtRgCli.Text;
                objMovGag.strNomCid := edtNomCid.Text;
                If (fCfgSis('PRECAD', varBoolean)) Then
                Begin
                  objMovGag.strCodAti := edtCodAtividade.Text;
                  objMovGag.strNomCid := edtNomAtividade.Text;
                End;

                If fEmptyStr(edtCgcCpf.Text) Then
                  objMovGag.intCgcCpf := 0
                Else
                  objMovGag.intCgcCpf := StrToInt(edtCgcCpf.Text);

                objMovGag.strIesCon := edtInsEst.Text;
                objMovGag.strEmaCon := edtEmail_.Text;
              End;
            End;
          End;
        End;
      End;
    End;

    If Not fEmptyStr(objMovGag.strNomCon) and  Not (chkCredito.Checked and blnInfCli) Then
    Begin
      edtNomCli.Text := objMovGag.strNomCon;
      strCliEst      := objMovGag.strEstCon;
    End
    Else
    Begin
      If Not fEmptyStr(edtCodCli.Text) Then
      Begin
        edtNomCli.Text := fRetNomCliente(edtCodCli.Text);

        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('', 'Cliente não encontrado!', ['&Ok']);
          pSetFocus(edtCodCli);
          Result := False;
          Exit;
        End;

        strCliEst := fRetEstadoCliente(edtCodCli.Text);
      End;
    End;

    pHabilitaOBS;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmGarantiaRecCliente.fDigDadosConsumidor');
    End;
  End;

  pFreeAndNil(frmFatDadosCliConsumidor);
end;

function TfrmGarantiaRecCliente.fDigitaObs: Boolean;
begin
  Result := False;

  Try
    pCriarFormularios(TfrmObsGarantia, frmObsGarantia);
    frmObsGarantia.ShowModal;
    Result := (frmObsGarantia.ModalResult = mrOk);

    If Result Then
    Begin
      strObs1 := frmObsGarantia.edtObs1.Text;
      strObs2 := frmObsGarantia.edtObs2.Text;
    End
    else
    Begin
      strObs1 := '';
      strObs2 := '';
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmGarantiaRecCliente.pDigitaObs]');
    End;
  End;
  pFreeAndNil(frmObsGarantia);
end;

procedure TfrmGarantiaRecCliente.dbgItensCellClick(Column: TColumn);
begin
  inherited;
  pCarregaItensAlteracao(False)
end;

procedure TfrmGarantiaRecCliente.dbgItensDblClick(Sender: TObject);
begin
  inherited;
  pCarregaItensAlteracao(True);
end;

procedure TfrmGarantiaRecCliente.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (cdsItens.FieldByName('CODITE').IsNull) Then
  Begin
    cdsItens.Cancel;
    Exit;
  End;

  if dbgItens.SelectedField = cdsItensLOTSAI then
    exit;

  If cdsItens.State = dsEdit Then
    cdsItens.Post;

  case key of
    VK_ESCAPE:
      begin
        If dbgItens.ReadOnly Then
        Begin
          pHabilitaForm(True);
          pLimpaDados;
          pSetFocus(mskDtaEnt);
          Exit;
        End;
        pSetFocus(edtCodIte);
      end;
    Vk_Return:
      begin
        pCarregaItensAlteracao(True);
      end;
    VK_DELETE:
      begin
        If fVaiUtilizarAD Then
          Exit;

        If (Not cdsItens.FieldByName('CODITE').IsNull) Then
        Try

          strItensExcluidos  := strItensExcluidos + QuotedStr(cdsItens.FieldByName('CODITE').AsString) + ',';

          If Not fEmptyStr(cdsItens.FieldByName('AUTINC').AsString) Then
            strAutIncExcluidos := strAutIncExcluidos + QuotedStr(cdsItens.FieldByName('AUTINC').AsString) + ',';

          fltDesAce := fltDesAce - cdsItens.FieldByName('DESACE').AsFloat;

          cdsItens.Delete;

          pnlGarantia.Enabled := cdsItens.IsEmpty;

          If cdsItens.IsEmpty Then
            pSetFocus(edtCodIte)
          Else
            pSetFocus(dbgItens);

        Except
          On E: Exception Do
          pMensagensErro(E.Message,'[TfrmGarantiaRecCliente.dbgItensKeyDown]');
        End
        Else
          pSetFocus(edtCodIte);
      end;
  end;
end;

{*****************************************}
{* VERIFICA SE HÁ ESTOQUE SUFICIENTE     *}
{**************************************RL*}
function TfrmGarantiaRecCliente.fVerificaQtdEstoque(fltQuantidade: Double; Out pblnBXSBIT: Boolean): Boolean;
  Var
    strNTrava: String;
    strCodIte: String;
    strNumLot: String;
    objMsg : TMensagemLiberacao;
    lblnPediuSenha: Boolean;
begin
  pblnBXSBIT := False;
  Result    := True;

  If (fltQuantidade <= 0) Then
  Begin
    Result := False;
    Exit;
  End;

  fltQuantidade := fltQuantidade + fRetQtdDigitada;

  {*****************************************}
  {* CASO ESTEJA ALTERANDO UM ITEM, NAO    *}
  {* CONSIDERA A QUANTIDADE JA CADASTRADA  *}
  {**************************************RL*}
  If btnAdicionar.Tag > 0 Then
    fltQuantidade := fltQuantidade - cdsItens.FieldByName('QTDITE').AsFloat;

  If (Pos(fCfgSis('SLD_VN'), 'AT') > 0) Then
  Begin

    If fEmptyStr(edtCodIte.Text) then
    begin
      strCodIte := cdsItens.FieldByName('CODITE').AsString;
      strNumLot := cdsItens.FieldByName('LOTSAI').AsString;
    end
    else
    begin
      strCodIte := fRetCodItem(edtCodIte.Text);
      strNumLot := edtNumLot.Text;
    end;



    If fltQuantidade > fRetornaSaldoProduto(strCodIte, strNumLot) Then
    Begin
      objMsg := TMensagemLiberacao.Create(Self);
      Try
        if FblnBaixaEstrutura And (Not FblnCarrergarEstrutura) And fItemEstrutura(strCodIte) then
        begin
          pblnBXSBIT := True;
          Result :=
              fatVenda2.fVerificaQtdEstoqueSubItensEstrutura(fatVenda2.strOpcDoc,//strOpcao,
                                                             strCodIte,          //strIteEst,
                                                             '',                 //strAutInc: String;
                                                             fltQuantidade,      //fltQtdIte: Double;
                                                             False,              //blnComSenha: Boolean;
                                                             objMsg,             //objMsgSubItensSemEst: TMensagemLiberacao;
                                                             lblnPediuSenha,     //Var blnPediuSenha: Boolean;
                                                             True,               //blnVerQtdDig: Boolean = True;
                                                             VS_strCodEmp);      //strEmpIte: Integer = -1): Boolean;

        end
        else
          Result := False;

        if Not Result then
        begin
          fMensagem('', 'Este produto não possui saldo suficiente!', ['&Ok']);

          If (fCfgSis('SLD_VN') = 'T') Then
          Begin
            objMsg.pAddTexto('Este produto não possui saldo suficiente!');
            Result := fSenhaLiberacaoSemSaldoVN(strCodVen, '', strNtrava, Nil, objMsg, '', TRUE, 'GA')
          End;
        end;
      Finally
       FreeAndNil(objMsg);
      End;

    End;

  End;

end;

function TfrmGarantiaRecCliente.fObterLiberacaoCredito(Out blnDuplicataLiberada: boolean): Boolean;
Var
  LiberacaoCredito : TLiberacaoCreditos;
begin
  inherited;
  LiberacaoCredito := Nil;
  Try
    cdsItens.DisableControls;
    LiberacaoCredito := TLiberacaoCreditos.Create;
    if fExigirFavorecido(edtCodcli.Text, edtNomCli.Text, chkCredito.Checked) then
      LiberacaoCredito.pInserirCliente(edtCodcli.Text, edtNomCli.Text, edtFavorecido.Text, edtNomeFavorecido.Text)
    else
      LiberacaoCredito.pInserirCliente(edtCodCli.Text, edtNomCli.Text);

    LiberacaoCredito.RetornaItemNaoAutorizado := pRecebeItemNaoLiberado;

    cdsItens.First;
    while Not cdsItens.EOF do
    begin
      LiberacaoCredito.pInserirItem(cdsItens.FieldByName('CODITE').AsString,
                                    cdsItens.FieldByName('DESITE').AsString,
                                    cdsItens.FieldByName('SEQDOC').AsString,
                                    cdsItens.FieldByName('NUMDOC').AsString,
                                    cdsItens.FieldByName('EMPDOC').AsString,
                                    cdsItens.FieldByName('VALITE').AsCurrency);
      cdsItens.Next;
    end;

    Result := LiberacaoCredito.fExecutar;
    blnDuplicataLiberada := LiberacaoCredito.blnTemDuplicata;

    if Not Result then
    begin
      LiberacaoCredito.pDevolverItensNaoAutorizados;
    end;

  Finally
    cdsItens.EnableControls;
    if Assigned(LiberacaoCredito) then
    begin
      LiberacaoCredito.Free;
    end;
  End;
end;

{*******************************************}
{* RETORNA A QUANTIDADE JÁ INFORMADA DE UM *}
{* DETERMINADO PRODUTO                     *}
{****************************************RL*}
function TfrmGarantiaRecCliente.fRetQtdDigitada: Double;
  Var
    intRecNo: Integer;
begin

  Result := 0.0;

  With cdsItens Do
  Begin
    DisableControls;
    intRecNo := RecNo;

    First;

    While Not Eof Do
    Begin
      If FieldByName('CODITE').AsString = fRetCodItem(edtCodIte.Text) Then
        Result := Result + FieldByName('QTDITE').AsFloat;
      Next;
    End;

    RecNo := intRecNo;
    EnableControls;
  End;

end;

{*****************************************}
{* RETORNA O SEQUENCIAL DE GARANTIA PARA *}
{* O ENVIO DO DOCUMENTO AO CLIENTE       *}
{**************************************MM*}
function TfrmGarantiaRecCliente.fRetSequencialReposicao: String;
  Var
    strSQL   : String;
    qryCadGen: TUniQuery;
begin
  Try
    qryCadGen := fCriaQuery(nil);

    Try
      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   SIS_VALCFG AS VALOR ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   CFGSIS ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   SIS_CODCFG = ' + QuotedStr('CFG_PROGEC') + ' AND ';
      strSQL := strSQL + '   SIS_CODEMP = ' + QuotedStr(VS_strCodEmp);

      With qryCadGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

        If FieldByName('VALOR').IsNull Then
          strSQL := '0'
        Else
          strSQL := FieldByName('VALOR').AsString;

        Close;
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create('Não consegui pegar o proximo sequencial. Tente novamente!');
      End;
    End;

    Result := fStrZero(strSQL, fTamDocCadRec);
    If StrToInt64(Result) = 0 Then
      Result := fStrZero(IntToStr(StrToInt64(Result)+1), fTamDocCadRec);

    fAtuSequencial(fStrZero(IntToStr(StrToInt64(Result)+1), fTamDocCadRec));

  Finally
    FreeAndNil(qryCadGen);
  End;
end;

function TfrmGarantiaRecCliente.fRetTotalCreditoCliente(out blnTemVarCrd: Boolean): Double;
Var
  cdsIteTmp: TUniClientDataSet;
  fltTotDes: Double;
  fltCreditoItem: Double;
begin
  fltTotDes := 0;
  Try
    blnTemVarCrd := False;
    cdsIteTmp := TUniClientDataSet.Create(Self);
    cdsIteTmp.Data := cdsItens.Data;
    cdsIteTmp.Open;

    cdsIteTmp.Filter   := 'REPOST = ' + QuotedStr('N');
    cdsIteTmp.Filtered := True;

    Result := 0;
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Senha para liberar a geração de crédito para o cliente');
    objLiberacao.objMsgLibera.pAddTexto('referente a garantia dos itens abaixo:');
    objLiberacao.objMsgLibera.pAddQuebra;

    With cdsIteTmp Do
    Begin
      First;

      While Not Eof Do
      Begin
        If (FieldByName('REPOST').AsString = 'N') Then
        Begin
          fltCreditoItem := FieldByName('QTDITE').AsFloat * FieldByName('UNICRD').AsFloat;
          Result := Result + fltCreditoItem;
          fltTotDes :=  fltTotDes +  FieldByName('DESACE').AsFloat;
          if Not blnTemVarCrd then
            blnTemVarCrd := FieldByName('UNICRD').AsFloat <> FieldByName('UNICRDORI').AsFloat;

          objLiberacao.objMsgLibera.pAddTexto(FieldByName('CODITE').AsString + '-' + FieldByName('DESITE').AsString);
          objLiberacao.objMsgLibera.pAddTextoCaption('Crédito sobre o item', FormatFloat('#,##0.00', fltCreditoItem));
          objLiberacao.objMsgLibera.pAddSeparador(62);
        End;

        Next;
      End;

      objLiberacao.objMsgLibera.pAddTextoCaption('Valor total do Produto: ', FormatFloat('#,##0.00', Result));
      if fltTotDes > 0 Then
        objLiberacao.objMsgLibera.pAddTextoCaption('Valor total da Despesas Acessórias: ', FormatFloat('#,##0.00', fltTotDes ));
      objLiberacao.objMsgLibera.pAddTextoCaption('Valor total do crédito a ser gerado: ', FormatFloat('#,##0.00', Result));
      {Result := Result + fltTotDes;}
    End;

  Finally
    FreeAndNil(cdsIteTmp);
  End;

end;

function TfrmGarantiaRecCliente.fSelecionarDocumentoVenda(const strCodAde, strCodCli, strNomCli, strCodIte, strDesIte,
  strDesUni, strPlaVei: String): TRespSelecaoDocumento;
  Var
    sqlFormulaValIte, sqlFormulaValCredito: String;
    QryTmp: TUniQuery;
    lstrCodIte: String;
    lfltQtdIte: Double;
    lstrAux: String;
    i: Integer;
begin
  QryTmp := Nil;
  frmListaDocsGarantia := Nil;
  lstrCodIte := fRetCodItem(strCodIte);
  lfltQtdIte := StrToFloatDef(edtQtdIte.Text,0);
  pInicializarArrDocumentosVendas;
  Result := TRespSelecaoDocumento.NaoSelecionado;
  Try
    qryTmp := fCriaQuery;
    {$REGION 'Tem Nota Eletrônica e fVaiUtilizarAd'}
    if (not fEmptyStr(recNotEle.strAutInc)) and fVaiUtilizarAD then
    begin
      sqlFormulaValIte := fScriptValIte('MOVDET');
      sqlFormulaValCredito := fScriptValCredito('MOVDET', 'T');

      qryTmp.SQL.Clear;
      qryTmp.SQL.Add('SELECT                                                                                                                         ');
      qryTmp.SQL.Add('  CONCAT(DET_NUMDOC, "-", DET_ESPDOC) AS NUMDOC,                                                                               ');
      qryTmp.SQL.Add('  DET_SEQDET AS SEQDOC,                                                                                                        ');
      qryTmp.SQL.Add('  DET_CODEMP AS EMPDOC,                                                                                                        ');
      qryTmp.SQL.Add('  GER_CODVEN AS CODVEN,                                                                                                        ');
      qryTmp.SQL.Add('  ESPDET.DET_QTDITE AS DISPON,                                                                                                 ');
      qryTmp.SQL.Add('  MOVDET.DET_QTDITE AS VENDA_,                                                                                                 ');


      //         (IF((CONDICAO), (VERDADEIRO),(FALSO))/DET_QTDITE) AS UNICRD
      lstrAux := Format('(IF( LEFT(MOVDET.DET_CLAFIS,1) < 5, - (%0:s), (%0:s) ) / MOVDET.DET_QTDITE) ',[sqlFormulaValCredito]);
      qryTmp.SQL.Add('('+ lstrAux + ') AS UNICRD,                                                                                                      ');

      //VALITE
      //     (IF((CONDICAO), (VERDADEIRO),(FALSO)) AS VALITE
      lstrAux := Format('IF( LEFT(MOVDET.DET_CLAFIS,1) < 5, - (%0:s), (%0:s) ) ',[sqlFormulaValIte]);
      qryTmp.SQL.Add('('+ lstrAux + ') AS VALITE,                                                                                                      ');

      qryTmp.SQL.Add('  (MOVDET.DET_DESACE / MOVDET.DET_QTDITE) AS DET_DESACE,                                                                       ');
      qryTmp.SQL.Add('  CONCAT(MOVDET.DET_NUMFAT, "-", MOVDET.DET_TIPFAT, "-", MOVDET.DET_EMPFAT) AS DOCFAT,                                         ');
      qryTmp.SQL.Add('  DET_SEQDET AS INCORI, GER_DTAENT AS "DTAENT",                                                                                ');
      qryTmp.SQL.Add('  MOVDET.DET_UNITAR,                                                                                                           ');
      qryTmp.SQL.Add('  IFNULL(MOVDET.DET_DESESP,0) AS "DET_DESESP",                                                                                 ');
      qryTmp.SQL.Add('  0.0 AS "DET_DESCFF"                                                                                                          ');
      qryTmp.SQL.Add('FROM                                                                                                                           ');
      qryTmp.SQL.Add('  ESPGER                                                                                                                       ');
      qryTmp.SQL.Add('  INNER JOIN ESPDET ON DET_SEQGER = ESPGER.AUTOINCREM                                                                          ');
      qryTmp.SQL.Add('  INNER JOIN MOVDET ON MOVDET.AUTOINCREM = DET_SEQDET                                                                          ');
      qryTmp.SQL.Add('  INNER JOIN MOVTRI T ON T.DET_SEQGER = MOVDET.AUTOINCREM                                                                      ');
      qryTmp.SQL.Add('  INNER JOIN MOVGER ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER                                                                   ');
      qryTmp.SQL.Add('WHERE GER_CODADE = :CODADE                                                                                                     ');
      qryTmp.SQL.Add('  AND ESPDET.DET_CODITE = :CODITE                                                                                              ');

      qryTmp.ParamByName('CODADE').AsString := strCodAde;
      qryTmp.ParamByName('CODITE').AsString := strCodIte;
      qryTmp.Open;

      if not qryTmp.isEmpty then
      begin
        i := fAdicionarNovoDocumentoVenda;
        arrDocumentosVendas[i].Create(strCodIte);
        arrDocumentosVendas[i].strSeqDoc := qryTmp.FieldByName('SEQDOC').AsString;
        arrDocumentosVendas[i].strNumDoc := qryTmp.FieldByName('NUMDOC').AsString;
        arrDocumentosVendas[i].strEmpDoc := qryTmp.FieldByName('EMPDOC').AsString;
        arrDocumentosVendas[i].strCodVenOri := qryTmp.FieldByName('CODVEN').AsString;
        arrDocumentosVendas[i].fltDispon := qryTmp.FieldByName('DISPON').AsFloat;
        arrDocumentosVendas[i].fltQtdIte := qryTmp.FieldByName('VENDA_').AsFloat;
        arrDocumentosVendas[i].fltValIte := qryTmp.FieldByName('VALITE').AsFloat;
        arrDocumentosVendas[i].fltDesAceD:= qryTmp.FieldByName('DET_DESACE').AsFloat;
        arrDocumentosVendas[i].strDocFat := qryTmp.FieldByName('DOCFAT').AsString;
        arrDocumentosVendas[i].strIncOri := qryTmp.FieldByName('INCORI').AsString;
        arrDocumentosVendas[i].strTabela := 'MOVGER';
        arrDocumentosVendas[i].strDataVenda := FormatDateTime('dd/mm/yyyy', qryTmp.FieldByName('DTAENT').AsDateTime);
        arrDocumentosVendas[i].fltUniCrd := qryTmp.FieldByName('UNICRD').AsFloat;
        arrDocumentosVendas[i].fltDET_UNITAR := qryTmp.FieldByName('DET_UNITAR').AsFloat;
        arrDocumentosVendas[i].fltDET_DESESP := qryTmp.FieldByName('DET_DESESP').AsFloat;
        arrDocumentosVendas[i].fltDET_DESCFF := qryTmp.FieldByName('DET_DESCFF').AsFloat;
      end;

      qryTmp.Close;
    end;
    {$ENDREGION}
    {$REGION 'Se strNumDoc vazio (não tem documento) procurar documento de venda'}
    if strNumDoc = '' then
    begin
      qryTmp.SQL.Clear;
      If Not objMovGag.objMovGad.fCarregaDocVendas(qryTmp, strCodCli, lstrCodIte, False, strPlaVei) Then
        Exit;
    End;
    {$ENDREGION}
    {$REGION 'Exibir Documentos para selecionar'}
    frmListaDocsGarantia := TfrmListaDocsGarantia.Create(Self);
    frmListaDocsGarantia.pSetCallBackDocumentoSelecionado(pReceberDocumentoSelecionado);
    frmListaDocsGarantia.blnImportandoXML := blnImportandoXML;
    frmListaDocsGarantia.strCodIte := lstrCodIte;
    frmListaDocsGarantia.strDesIte := strDesIte;
    frmListaDocsGarantia.strCodCli := strCodCli;
    frmListaDocsGarantia.strNomCli := strNomCli;

    if lfltQtdIte < 1 then
    begin
      frmListaDocsGarantia.fltQtdRec := 1;
    end
    else
      frmListaDocsGarantia.fltQtdRec := lfltQtdIte;

    pCarregaDocVendas(qryTmp, frmListaDocsGarantia.cdsDocumentos);

    If frmListaDocsGarantia.cdsDocumentos.IsEmpty Then
      Exit;

    frmListaDocsGarantia.cdsDocumentos.First;
    frmListaDocsGarantia.strCodCli := strCodCli;

    If (frmListaDocsGarantia.ShowModal = mrOk) Then
    Begin
      frmListaDocsGarantia.pEnviarDocumentosSelecionados;
      Result := TRespSelecaoDocumento.Selecionado;
    End
    else
      Result := TRespSelecaoDocumento.NaoSelecionado;

    frmListaDocsGarantia.cdsDocumentos.Close;
   {$ENDREGION}
  Finally
    if Assigned(QryTmp) then
      QryTmp.Free;

    if Assigned(frmListaDocsGarantia) then
      frmListaDocsGarantia.Free;
  end;
end;

procedure TfrmGarantiaRecCliente.pGeraLogRepProcessoUtilizado(strProcesso: String; strAutInc: String);
var qryConsulta : TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('/*'+ strProcesso + '*/ UPDATE MOVGAG SET GAG_PROCES = "'+strProcesso+'" WHERE AUTOINCREM = "' + strAutInc + '"');
    qryConsulta.ExecSQL;
  Finally
    freeAndNil(qryConsulta);
  End;
end;



function TfrmGarantiaRecCliente.fTemDocumentoVendaSelecionado: Boolean;
begin
  Result := Length(arrDocumentosVendas) >= 1;
end;

function TfrmGarantiaRecCliente.fTrataRecebimentoCliente: Boolean;
Var
  NumeroDoc: String;
  Especiedoc: String;
  ClienteDoc: String;
  strProcessoEscolhido: String;
begin
  Try
    Result := True;
    fatVenda.strCliOri  := '';

    strEspDocAnt := fatVenda.strEspDoc;

    If (fatVenda.strEspDoc <> 'NE') Then
    begin
      if edtFavorecido.visible and (Not fEmptyStr(edtFavorecido.Text)) then
        pCarregaDadosClienteGarantia(edtFavorecido.Text, fatVenda)
      else
        pCarregaDadosClienteGarantia(edtCodCli.Text, fatVenda);
    end;
    {*****************************}
    {* EXLCUIR ITENS DA GARANTIA *}
    {**************************RL*}
    If (Not fEmptyStr(strItensExcluidos)) And (Not fEmptyStr(strAutIncExcluidos)) Then
    Begin
      strItensExcluidos  := Copy(strItensExcluidos, 1, Length(strItensExcluidos) - 1);
      strAutIncExcluidos := Copy(strAutIncExcluidos, 1, Length(strAutIncExcluidos) - 1);
      objMovGag.objMovGad.fDeletaMovGad(objMovGag.strAutInc, strAutIncExcluidos, strItensExcluidos);
    End;

    strProcessoEscolhido := '';
    If Result And
       SameText(fatVenda.strEspDoc, 'NF') And
       (Pos(fatVenda.strOpcDoc, 'OE_DV_') > 0) then
    Begin
      strProcessoEscolhido  := 'fOutrasEntradasFaturamento';

      If FblnEspDev Then
      Begin
        if Not Assigned(fatVenda.objItensNotaEspelho) then
          fatVenda.objItensNotaEspelho := TItensNotaEspelho.Create(fatVenda);
        fatVenda.objItensNotaEspelho.strOpcDoc := fatVenda.strOpcDoc;
        fatVenda.objItensNotaEspelho.blnRecCliGarantia := True;
      End;

      Result := fOutrasEntradasFaturamento;
    End
    Else If SameText(fatVenda.strEspDoc, 'NE') then
    begin
      strProcessoEscolhido  := 'fEntradaNF';
      Result := fEntradaNF(objMovGag.strNumEnt);
    End
    Else If SameText(fatVenda.strEspDoc, 'GA') Then
    Begin
      {************************************************}
      {* GRAVA MOVGER E MOVDET PARA ENTRAR NO ESTOQUE *}
      {*********************************************MM*}
      Try
        pCriarFormularios(TfrmGravando, frmGravando);
        strProcessoEscolhido  := 'fGravaEntradaGA';
        frmGravando.fExecutarAcao := fGravaEntradaGA;
        frmGravando.ShowModal;
        Result := frmGravando.blnConfirma;
        pFreeAndNil(frmGravando);
      Except
        On E: Exception Do
        Begin
          if Result then
            Result := False;
          pFreeAndNil(frmGravando);
          pMensagensErro(E.Message, '');
        End;
      End;

    End;

    If Result Then
      pGeraLogRepProcessoUtilizado(strProcessoEscolhido + ' - Concluido', objMovGag.strAutInc)
    Else
      pGeraLogRepProcessoUtilizado(strProcessoEscolhido + ' - Falha', objMovGag.strAutInc);

    If (Not Result) Then
      If SameText(fatVenda.strEspDoc, 'NE') Then
        If (fSeDerFalhaMasGravouAEntrada(objMovGag.strAutInc, FRecDocGarantia)) then
        begin
          pMensagensErro('Houve falha na conclusão deste documento, entre em contato com a Citel!',
                         'TfrmGarantiaRecCliente.fTrataRecebimentoCliente');
          Exit;
        end;

    {*********************************}
    {* OUTRAS ENTRADAS (FATURAMENTO) *}
    {*******************************FC}
    If Result And
       SameText(fatVenda.strEspDoc, 'NF') And
       (Pos(fatVenda.strOpcDoc, 'OE_DV_') > 0) then
    Begin
      Result    := fGravaArquivos(fatVenda);

      If Result And fVaiUtilizarAD Then
        pMarcaDocumentoDevAD(qryAD.FieldByName('GER_CODADE').AsString, VS_strCodEmp, fatVenda.strNumDoc, fatVenda.strEspDoc, VS_strCodEmp);

    End;

    if fatVenda.strEspDoc = 'GA' then
    begin
      NumeroDOc := ObjMovGag.strNumEnt;
      EspecieDoc := 'GA';
      ClienteDoc := ObjMovGag.strCodCli;
    end
    else begin
      NumeroDOc := fatVenda.strNumDoc;
      EspecieDoc := fatVenda.strEspDoc;
      ClienteDoc := fatVenda.strCodCli;
    end;

    if fatVenda.strEspDoc = 'GA' then
      FRecDocGarantia.pDefinir(ObjMovGag.strNumEnt, 'GA', VS_strCodEmp, ObjMovGag.strCodCli)
    else
    begin
      if fEmptyStr(strNumRet) then
        FRecDocGarantia.pDefinir(fatVenda.strNumDoc, fatVenda.strEspDoc, VS_strCodEmp, fatVenda.strCodCli)
      else
        FRecDocGarantia.pDefinir(strNumRet, fatVenda.strEspDoc, VS_strCodEmp, fatVenda.strCodCli)
    end;

    If Result Then
      Result := fGravaPedidoEmpresaMatriz;

  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TfrmGarantiaRecCliente.fTrataRecebimentoCliente');
    End;
  End;

end;

function TfrmGarantiaRecCliente.fTrataReposicaoCliente: Boolean;
 const
  MSG: String = 'Documento de saída não foi gerado! '+slineBreak+
                'A ausência do registro irá anular a reposição para cliente e '+slinebreak+
                'a garantia ficará pendente.'+slineBreak+
                'Deseja tentar emitir o documento novamente?';
  SIM_TENTAR_EMITIR: Integer = 1;


  //quando eh cancelado a reposiçao tem que voltar produtos para nao reposto para poder fazer a devolução do mesmo.
  procedure pVoltaProdutosParaNaoReposto;
    Var
      qryUpdate : TUniQuery;
  Begin
    qryUpdate := fCriaQuery;
    Try
      With qryUpdate,SQL Do
      Begin
        Close;
        Clear;
        Add(' UPDATE MOVGAD SET GAD_REPOST = "N", ');
        Add('                   GAD_SCREDI = 1,   ');
        Add('                   GAD_QTDDEV = 0    ');
        Add(' WHERE GAD_SEQGAG = :AUTOINCREM      ');

        ParamByName('AUTOINCREM').AsString := objMovGag.strAutInc;
        ExecSQL;
      End;
    Finally
      FreeAndNil(qryUpdate);
    End;

  End;


 var
  blnFalha: Boolean;
begin
  blnFalha := False;
  Try
    Result := True;
    fatVenda2.strCliOri := '';

    If fatVenda.strEspDoc = 'NE' Then
      fatVenda2.strEspDoc := 'NF'
    Else
      fatVenda2.strEspDoc := fatVenda.strEspDoc; //Se foi com NF será com nota, se foi GA será GC.
    fatVenda2.strOpcDoc := 'OU'; // Se for GA nao chama o fGravaArquivos

    fatVenda2.strEntFat := FEntregaRetira.AsString_S_N;

    If fGetCfopRecCliente(fatVenda2, True, tmSaida) Then
    Begin
      if edtFavorecido.visible and (Not fEmptyStr(edtFavorecido.Text)) then
        pCarregaDadosClienteGarantia(edtFavorecido.Text, fatVenda2)
      else
        pCarregaDadosClienteGarantia(edtCodCli.Text, fatVenda2);


      If SameText(fatVenda2.strEspDoc, 'GA') Then
      Begin
        {************************************************}
        {* GRAVA MOVGER E MOVDET PARA SAIR DO ESTOQUE   *}
        {*********************************************RL*}
        Try
          pCriarFormularios(TfrmGravando, frmGravando);
          frmGravando.fExecutarAcao := fGravaSaidaGA;
          frmGravando.ShowModal;
          Result := frmGravando.blnConfirma;
          pFreeAndNil(frmGravando);
        Except
          On E: Exception Do
          Begin
            Result := False;
            blnFalha := True;
            pFreeAndNil(frmGravando);
            pMensagensErro(E.Message, '');
          End;
        End;
      End
      {*********************************************************************************}
      {* SE HOUVER REPOSIÇÃO E FOI EMITIDO UMA NOTA FISCAL OUTRAS ENTRADAS OU          *}
      {* FOI DADO UMA ENTRADA DE UMA NF NA ENTRADA DE MERCADORIAS, SOLICITA O TIPO     *}
      {* DE FATURAMENTO PARA EMITIR UMA NOTA DE SAIDA PARA O CLIENTE, POIS ELE PODE    *}
      {* TER DEIXAR O ITEM PARA TROCAR E JÁ HAVIA NO ESTOQUE E JÁ FOI EFETUADO A TROCA *}
      {*******************************************************************************FC}
      Else
      Begin
        Result := fOutrasSaidasFaturamento;
        If Result Then
          Result := fGravaArquivos(fatVenda2);
      End;

      if not Result Then
      begin
        if Not blnFalha then
        begin
          if fMensagem('Atenção!',MSG,['&Sim','&Não'],1) = SIM_TENTAR_EMITIR then
          begin
            Result := fTrataReposicaoCliente;
          end;
        end;
      end;

      if Not Result then
      begin
        pVoltaProdutosParaNaoReposto;
      end;

    End
    Else
      pVoltaProdutosParaNaoReposto;
  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TfrmGarantiaRecCliente.fTrataReposicaoCliente')
    End;
  End;
end;

{*******************************************}
{* RETORNA SALDO DO PRODUTO INFORMADO      *}
{****************************************RL*}
function TfrmGarantiaRecCliente.fRetornaSaldoProduto(strCodIte, strNumLot: String): Double;
begin
  Result := fRetornaSaldoDisponivel(strCodIte, False, True, strNumLot);
end;

procedure TfrmGarantiaRecCliente.btnConfirmarClick(Sender: TObject);
  Var
    Result       : Boolean;
    intQtdImp    : Integer;
    strMsgLot    : String;
    blnAbortou   : Boolean;
    strNomeArquivo: String;
    blnPeiMse : Boolean;
    fltPerIcm : Double;
    strCodSit : String;
    blnExigeFavorecido: Boolean;
    ClienteCredito: TConsultas;
    blnLiberadoDuplicata: boolean;
    lstrNumDoc : String;
    lstrEspDoc : String;
    blnLiberarVariacaoCredito: Boolean;
begin
  inherited;

  if Not fLiberarInserirItemSemDocumentoVenda then
    Exit;

  strNumRet := '';
  blnAbortou := False;
  blnPeiMse := fCfgSis('PEIMSE', varBoolean);
  blnExigeFavorecido := ((fExigirFavorecido(edtCodcli.Text, edtNomCli.Text, chkCredito.Checked))
                          Or (edtFavorecido.visible and (Not fEmptyStr(edtFavorecido.Text)))) ;
  ClienteCredito.strCodigo := edtCodCli.Text;
  ClienteCredito.strdescri := edtNomCli.text;
  objMovGag.strcodfav := edtCodCli.Text;
  objMovGag.strGarInd := FenuTipoGarantia.fEhGarantiaIndustriaBoolAsString;
  Result := True;
  FstrNumRetornoCliente := '';

  If cdsItens.State = dsEdit Then
    cdsItens.Cancel;

  If Not fValidaPanel(pnlGarantia, True) Then
    Exit;

  if blnInformarEntregaRetiraGC AND chkReposicao.checked Then
  begin
    FEntregaRetira := fReposicaoEntregaRetira;
  end
  else
    FEntregaRetira := TReposicaoEntregaRetira.trRetira;

  if blnExigeFAvorecido then
  begin
    If Not fValidarFavorecido then
    begin
      if fEmptyStr(edtFavorecido.Text) then
      begin
        fMensagem('Atenção!','Favorecido é obrigatório e não foi informado.',['&Ok']);
      end;
      Exit;
    end;
    ClienteCredito.strCodigo := edtFavorecido.Text;
    ClienteCredito.strdescri := edtNomeFavorecido.text;
    objMovGag.strCodFav := ClienteCredito.strCodigo;
  end;

  If cdsItens.IsEmpty Then
  Begin

    fMensagem('', 'Nenhum produto foi adicionado na garantia!', ['&Ok']);
    pSetFocus(edtCodIte);
    Exit;

  End;

  strMsgLot := '';
  if objCadLot.tplTipLot = tplArmazem Then
  Begin
    With cdsItens Do
    Begin

      First;

      While Not Eof Do
      Begin
        if objCadLot.fExisteLote(FieldByName('CODITE').AsString, vs_strCodEmp, '', False, False) And
           fEmptyStr(objCadLot.fRetArmazemPrincipalGarantia(FieldByName('CODITE').AsString)) Then
             strMsgLot := strMsgLot + FieldByName('CODITE').AsString + ' - ' + FieldByName('DESITE').AsString + #13;
        Next;
      End
    End;

    if not fEmptyStr(strMsgLot) Then
    Begin
      pMensagemOk('O(s) item(ns) abaixo não possuem "Armazém Principal para' + #13#10 +
                  'Recebimento de Garantia do Cliente". Verifique o "Cadastro'  + #13#10 +
                  'de Produtos - Armazéns" antes de continuar.' + #13#10 + strMsgLot);
      Exit;
    End;

  End;

  If (fClienteFilial(edtCodCli.Text)) and chkReposicao.checked Then
  Begin
    if not fVerificaLotes Then
      Exit;
  End;

  If fMensagem('ATENÇÃO!', 'Confirma o Recebimento do Cliente?', ['&Sim', '&Não']) = 2 Then
    Exit;

  {*****************************************}
  {* RETORNA O TOTAL DO CRÉDITO DO CLIENTE *}
  {**************************************PZ*}
  fltTotCre := fRetTotalCreditoCliente(blnLiberarVariacaoCredito);
  blnLanCre := chkCredito.Checked and (fltTotCre > 0);

  {********************************************************}
  {* PEDE SENHA PARA LANÇAMENTO DE CRÉDITO PARA O CLIENTE *}
  {*****************************************************PZ*}

  If blnLanCre and (Not fClienteFilial(ClienteCredito.strcodigo)) And blnGeraCreditoNoRecebimento Then
  Begin
    blnLanCre := False;
    If (fEmptyStr(strPortad)) Then
    Begin
      fMensagem('ATENÇÃO!','O Portador para geração de crédito para o cliente não está configurado!' + #13#10 +
                '"CFG_PORGAR" - ABA "GARANTIA".', ['&O k']);
      Exit;
    End;

    if (FListaItensSemDocumento.Count > 0) and blnLiberarVariacaoCredito then
    begin
      if Not TLiberacaoVariacaoCredito.fLiberar(ClienteCredito.strCodigo,
                                                ClienteCredito.strDescri,
                                                strLoginUsuarioLogado,
                                                strLoginUsuarioLogado,
                                                fltTotCre) then
        Exit;
      blnLanCre := True;
    end;

    if chkCredito.Checked and (Not fClienteFilial(ClienteCredito.strcodigo))then
    begin
      if fObterLiberacaoCredito(blnLiberadoDuplicata) then
      begin
        if Not blnLiberadoDuplicata then
        begin
          // mensagem montada em fRetTotalCreditoCliente
          objLiberacao.strDirAce  := 'SECDGA';
          objLiberacao.strSenLib  := fCfgSis('SECDGA');
          objLiberacao.strMsgSen  := 'Liberação de crédito Cliente(Garantia)';
          objLiberacao.strCodOpe  := strLoginUsuarioLogado;
          objLiberacao.strCodDig  := strLoginUsuarioLogado;
          objLiberacao.strCliente := ClienteCredito.strCodigo + '-' + ClienteCredito.strDescri;

          If (Not fatVenda.fFatMensagemLiberacao(objLiberacao)) Then
            Exit
          Else
            blnLanCre := True;
        end
        else
          blnLanCre := True;
      end
      else
        Exit;
    end;

  End;

  pDefinirPessoasOperacao;

  strEspDocAnt := '';

  Try

    pInicializaTemporaria;

    pCarregaDadosFatVendas;

    if not fDigitaObs then
      Exit;

    fatVenda.strCodCli := edtCodCli.Text;
    fatVenda.strCliEst := fRetEstadoCliente(edtCodCli.Text);

    if edtFavorecido.visible and (Not fEmptyStr(edtFavorecido.Text)) then
    	fatVenda.strCliIes := fCampoTabela('CLI_I_E_S_', 'CADCLI', ['CLI_CODCLI'], [edtFavorecido.Text], False)
    else
    	fatVenda.strCliIes := fCampoTabela('CLI_I_E_S_', 'CADCLI', ['CLI_CODCLI'], [edtCodCli.Text], False);

    If (fltTotCre > 0) And (blnLanCre) Then
    Begin
      strNumDup := fRetSequencial('PROCCO', VS_strCodEmp, fTamDocCadRec);

      strCodCliCre := ClienteCredito.strcodigo;
      If fClienteConsumidor(fRetNomCliente(clienteCredito.strcodigo) , False, True) And (fEmptyStr(strCodCliCre)) and (Not blnExigeFavorecido) Then
      Begin

        Try
          fMensagem('', 'Para gerar os créditos é necessário informar um cliente cadastrado!' + #13 + 'Os documentos serão gerados com o código do cliente selecionado!', ['&Ok']);
          pCriarFormularios(TfrmDigCliente, frmDigCliente);
          If frmDigCliente.ShowModal = mrOk Then
          begin
            strCodCliCre := frmDigCliente.edtCodCli.Text;
          end;
        Finally
          pFreeAndNil(frmDigCliente);
        End;

        If fEmptyStr(strCodCliCre) Then
          Exit;

        objMovGag.strCodCli := strCodCliCre;
        objMovGag.strCodFav := StrCodCliCre;
        edtCodCli.Text      := strCodCliCre;
        recDadSav.strCodCli := strCodCliCre;
      End;

    End
    Else
      strNumDup := '';

    {**********************************************}
    {* SELECIONA O TIPO DE FATURAMENTO (GARANTIA) *}
    {* HOJE EXISTE 3 OPÇÕES PARA ENTRDA:          *}
    {* OE - NOTA FISCAL (OUTRAS ENTRADAS)         *}
    {* NE - NOTA FISCAL (ENTRADA DE MERCADORIA)   *}
    {* GA - GARANTIA (DOCUMENTO NAO FISCAL)       *}
    {*                                            *}
    {* E HOJE EXISTE 2 OPÇÕES PARA SAÍDA:         *}
    {* OU - NOTA FISCAL (OUTRAS SAÍDAS)           *}
    {* GC = GARANTIA (DOCUMENTO NÃO FISCAL)       *}
    {********************************************FC}

    With cdsItens Do
    Begin
      First;
      While Not Eof Do
      Begin
        fatVenda.pRetornaAliquotaItem(FieldByName('CODITE').AsString, VS_strCodEmp, fltPerIcm, strCodSit);
        blnTemST := (Pos(strCodSit, CST_SUBSTITUICAO + CST_ANTECIPACAO_ICMS) > 0);

        If blnTemST Then
          Break;

        Next;
      End;
    End;

    If Result And
       ((not fEmptyStr(recNotEle.strAutInc)) or fGetTipoFaturamento(fatVenda, tmEntrada)) And
       fGetCfopRecCliente(fatVenda, (fatVenda.strEspDoc = 'NF'), tmEntrada) Then
    Begin
    {$Region 'Criando Garantia MovGag/MovGad'}
      Try

        If (not fEmptyStr(recNotEle.strAutInc)) Then
          fatVenda.strEspDoc := 'NE';

        fStartTransaction;

        {*******************************************}
        {* GRAVA MOVGAG E MOVGAD                   *}
        {****************************************RL*}
        Result := objMovGag.fGravaMovGag(StrToDate(mskDtaEnt.Text),
                                         strCodVen,
                                         edtCodCli.Text,
                                         objMovGag.strCodFav,
                                         strNumDup,
                                         True,
                                         '',
                                         strObs1,
                                         strObs2);
        fltTotPro := 0;
        If Result Then
        Begin
          TControleChavesGarantia.pInicializar;
          With cdsItens Do
          Begin

            First;

            While Not Eof Do
            Begin

              strAutInc := FieldByName('AUTINC').AsString;

              lstrNumDoc := Copy(FieldByName('NUMDOC').AsString, 1, fTamDocCadRec);
              lstrEspDoc := Copy(FieldByName('NUMDOC').AsString, IfThen(fTamDocCadRec = 6, 8, 14), 2);

              objMovGag.objMovGad.fGravaMovGad(objMovGag.strAutInc,
                                               strAutInc,
                                               lstrNumDoc,                           //3
                                               lstrEspDoc,        //4
                                               FieldByName('EMPDOC').AsString,
                                               FieldByName('REPOST').AsString,
                                               FieldByName('CODITE').AsString,
                                               FieldByName('VALITE').AsFloat,
                                               FieldByName('QTDITE').AsFloat,
                                               IIF(blnLanCre, FieldByName('QTDITE').AsFloat, FieldByName('QTDDEV').AsFloat),
                                               0,
                                               0,
                                               0,
                                               FieldByName('OBSP_1').AsString,
                                               FieldByName('OBSP_2').AsString,
                                               FieldByName('GARFIL').AsString,
                                               FieldByName('NUMLOT').AsString, // NUMERO DO LOTE DO PRODUTO ****RL****);
                                               blnLanCre,
                                               FieldByName('CODFOR').AsString,
                                               FieldByName('SEQDOC').AsString,
                                               FieldByName('UNICRD').AsFloat);

              Edit;

              FieldByName('AUTINC').AsString := strAutInc;
              Post;

              fltTotPro := fltTotPro + FieldByName('VALITE').AsFloat;

              TControleChavesGarantia.pAdicionarChaveGarantia(cdsItens.FieldByName('CODITE').AsString,
                                                              strAutInc,
                                                              cdsItens.FieldByName('SEQDOC').AsString,
                                                              cdsItens.FieldByName('QTDITE').AsFloat);
              Next;
            End;
          End;
        End;

        if Result Then
          fCommit
        Else
          fRollBack;

      Except
        on E: EGarantQtdReqInvalido do
        begin
          Result := False;
          fRollBack;
          pMensagemOk(e.message);
        end;
        On E : Exception do
        Begin
          Result := False;
          fRollBack;
          pMensagensErro(E.Message, 'TfrmGarantiaRecCliente.btnConfirmarClick');
        End;
      End;

    {$Endregion}
    End
    Else
      Result := False;

    If Result Then
    Begin
      //Obter AutoIncrem movger

      If fTrataRecebimentoCliente Then
      Begin
        If chkReposicao.Checked Then
          fTrataReposicaoCliente;

        if FModoGarantia.fSelecionado = TOperacaoGarantia.ogReposicao then
        begin
          FRecDocReposicao.pDefinir(IIF(fatVenda2.strEspDoc = 'NF',
                                        fatVenda2.strNumDoc,
                                        FstrNumRetornoCliente),
                                    IIF( fatVenda2.strEspDoc = 'NF', 'NF', 'GC'),
                                    objMovGag.strCodEmp,
                                    objMovGag.strcodfav);
        end;

        pIncluirOcorrenciaCRM;

        If blnReabreAD Then
          pGravaADE;
      End
      Else
      Begin
          objMovGag.pDeletaGarantia(objMovGag.strAutInc);
          objMovGag.pCarregaMovGag(objMovGag.strNumEnt);
          objMovGag.pAtuDadosGag;
          If SameText(fatVenda.strEspDoc, 'NE') And Not fEmptyStr(FRecDocGarantia.strNumDoc) Then
            pEstornarEntrada(FRecDocGarantia);
          Result := False;
          blnAbortou := True;

        pLimpaDados;

        pDestroyFatVendas;
        pCreateFatVendas;

        pHabilitaForm(True);
        pSetFocus(mskDtaEnt);

      End;
    End;
    {$Endregion}

    If Result And fCfgSis('IMETGR', varBoolean) Then
      pImprimeEtiqueta;

    If Result And (POS(strEspDocAnt, '_GA_NE__NF') > 0) Then
    Begin
      If fMensagem('', 'Deseja imprimir o comprovante da garantia?', ['&Sim', '&Não']) = 1 Then
      Begin
          intQtdImp := fGetMenu('Qtd. Vias', ['Não Imprimir','1 Via', '2 Vias', '3 Vias', '4 Vias'], 1);

          intQtdImp := intQtdImp - 1;

          if intQtdImp > 0 Then
          Begin
            pImprimeFatImp('MOVGAD',
                           objMovGag.strNumEnt,
                           'GA',
                           objMovGag.strCodEmp,
                           objMovGag.strCodCli,
                           'C',
                           '',
                           False,
                           strNomeArquivo,
                           False,
                           'I',
                           intQtdImp,
                           impSemPrecoGeral);
          End;
        End;

      End;

      If (Result) And blnGarSep And
         (chkReposicao.Checked) And
         ((Not blnPeiMse) Or (fMensagem('', 'Deseja imprimir separação?', ['&Sim', '&Não']) = 1)) Then
      Begin
        intQtdImp := 1;

        If (fCfgSis('VIA_SE') = 'S') Then
        Begin
          intQtdImp := fGetMenu('Qtd. Vias', ['Não Imprimir','1 Via', '2 Vias', '3 Vias', '4 Vias'], 1);

          If intQtdImp = 1 Then
            intQtdImp := -1
          Else
            intQtdImp := intQtdImp - 1;
        End
        Else
        Begin
          If fCfgSis('QTDVSE') > 1 Then
            intQtdImp := fCfgSis('QTDVSE');
        End;

        pImprimeFatImp('MOVDET',
                       IIF( fatVenda2.strEspDoc = 'NF', fatVenda2.strNumDoc, FstrNumRetornoCliente),
                       IIF( fatVenda2.strEspDoc = 'NF', 'NF', 'GC'),
                       objMovGag.strCodEmp,
                       objMovGag.strCodCli,
                       'C',
                       IIF( fatVenda2.strEspDoc = 'NF', 'V', ''),
                       False,
                       strNomeArquivo,
                       False,
                       'I',
                       intQtdImp,
                       impSemPrecoGeral,
                       0,
                       True,
                       False,
                       True,
                       True,
                       '',
                       '',
                       False,
                       False,
                       False,
                       False,
                       False,
                       False,
                       False,
                       opcTodos,
                       False,
                       False,
                       False,
                       False,
                       False,
                       '',
                       '',
                       Nil,
                       True);

        FstrNumRetornoCliente := '';
      End;

      If Result Then
      Begin
        If fMensagem('ATENÇÃO!', 'Mostrar Documentos...', ['Na &Tela', 'No &Excel']) = 2 Then
        begin

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(211, 7656, [],
                              ['NUMENT','CODEMP'],
                              [objMovGag.strNumEnt,
                              vs_strCodEmp],
                              nil,
                              ['NUMENT','CODEMP'],
                              False);
          End;

        end
        else
        begin

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(210, 7655, [],
                              ['NUMENT','CODEMP'],
                              [objMovGag.strNumEnt,
                              vs_strCodEmp],
                              nil,
                              nil,
                              True);
          End;

        end;

      end;

    if Result then
    begin

      pLimpaDados;

      pDestroyFatVendas;
      pCreateFatVendas;
    End;

  Finally
    TControleChavesGarantia.pInicializar;
    If Result Then
    Begin
      pSetFocus(mskDtaEnt);
    End
    Else If not blnAbortou then
      pSetFocus(edtCodIte)
    Else
      pMensagemOk('Operação não Realizada!');
  End;

end;

procedure TfrmGarantiaRecCliente.btnImportarXMLClick(Sender: TObject);
begin
  inherited;
  recNotEle := TfrmEntImportacaoNotaEletronica.fImportar(xmlGarantiaRecCliente, edtCodCli.Text, True);
  If not fEmptyStr(recNotEle.str_Chave) Then
  Begin
    recNotEle.strAutInc := fCampoTabela('AUTOINCREM', 'GERELE', ['PR07_CHNFE'], [recNotEle.str_Chave]);
    recNotEle.strCodCli := fCampoTabela('GER_CODCLI', 'GERELE', ['AUTOINCREM'], [recNotEle.strAutInc]);
  End;

  If fImportouXml Then
    pCarregaNFEXML;

end;

procedure TfrmGarantiaRecCliente.btnInformarLoteItemClick(Sender: TObject);
begin
  inherited;
  pSelecionarLote;
end;

procedure TfrmGarantiaRecCliente.btnNotEleClick(Sender: TObject);
  Var
    blnEncontrouXML : Boolean;
    qryGerEle: TUniQuery;
    chrKey: Char;
    arrDigNota: TConsultasArray;
begin
  inherited;
  blnEncontrouXML := False;

  Try
    qryGerEle := fCriaQuery(Self);

    chrKey := '/';

    If (fPesqGereleDigPedido(Self, Nil, qryGerEle, recNotEle, chrKey, arrDigNota, True, xmlGarantiaRecCliente, False, edtCodCli.Text)) Then
    Begin
      blnEncontrouXML := (Not fEmptyStr(recNotEle.str_Chave)) And (Not fEmptyStr(recNotEle.strAutInc));
    End;

  Finally
    FreeAndNil(qryGerEle);
  End;

  If blnEncontrouXML Then
    pCarregaNFEXML;

end;

function TfrmGarantiaRecCliente.fGravaPedidoEmpresaMatriz : Boolean;
  Var
    strNumPed : String;
    strCodCli : String;
    strTipPed : String;
    strAutIncDet : String;
    recServicos: TDadosServicos;
    fltUnitar : Double;
    fltTotPro : Double;
    objTipoEntregaRetiraExpedicao : TTipoEntregaRetiraExpedicao;
    strEntRet : String;
    arrDuplic : TarrDuplicata;
    fltPerIcm: Double;
    strCodSit: String;
    blnTemST: Boolean;
Begin
  Result := True;
  {************************************************}
  {* GRAVA FATGOR E FATDOR (PEDIDO DE TRANSF.)    *}
  {*********************************************MM*}
  If fUsaRotinaGarantiaPelaMatriz Or
     fGerarPedidoEmpGarComGarPes  Then
  Begin
    strNumPed := fRetSequencialPedido;
    strCodCli := fRetornaClienteFilial(fCfgSis('EMPGAR', varString));
    strTipPed := fCfgSis('TPPDGA',varString);
    If fEmptyStr(strTipPed) Then
      strTipPed := 'B';

    if fUsaRotinaGarantiaItensPesados Then
    Begin
      cdsItens.Filtered := False;
      cdsItens.Filter   := 'GARFIL = ' + QuotedStr('N');
      cdsItens.Filtered := True;
    End;

    fltTotPro := 0.00;
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      fatVenda.pRetornaAliquotaItem(cdsItens.FieldByName('CODITE').AsString, VS_strCodEmp, fltPerIcm, strCodSit);
      blnTemST := CST_SUBSTITUICAO.Contains(strCodSit);

      fltTotPro := fltTotPro + fFormataFloat((fGetValorVendaParaFilial(strCodCli, cdsItens.FieldByName('CODITE').AsString, blnTemST) *
                               cdsItens.FieldByName('QTDITE').AsFloat),2);
      cdsItens.Next;
    End;
    cdsItens.First;

    objTipoEntregaRetiraExpedicao := TTipoEntregaRetiraExpedicao.Create;
    FillChar(arrDuplic, Sizeof(arrDuplic) , #0);
    try
      strEntRet := 'E';
      if objTipoEntregaRetiraExpedicao.fGetTipo <> objTipoEntregaRetiraExpedicao.TODOS then
        strEntRet := objTipoEntregaRetiraExpedicao.fGetTipo;

      Result := fGravaFatGor(strAutInc,
                             VS_strCodEmp,
                             strNumPed,
                             'PD',
                             strCodCli,
                             objMovGag.strCodVen,
                             '',
                             '',
                             VS_Date,
                             fTime(),
                             IIF(Not fEmptyStr(fCfgSis('TMACND')), fRetConPag(fCfgSis('TMACND')), IIf(fEmptyStr(fCfgSis('TMACON')), '01001', fCfgSis('TMACON'))), // PADRÃO DA HIDROMAR
                             fRetNomCidade(fRetNomGeral('CLI_CODCID', 'CLI_CODCLI', 'CADCLI', fStrToFloat(strCodCli)), 1),
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             0,
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
                             0,
                             0,
                             0,
                             0,
                             fltTotPro,
                             fltTotPro,
                             0,
                             0,
                             '',
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             arrDuplic,
                             '',
                             '',
                             'GARANTIA' + IIF(blnEmpGar,'','(TE)'),
                             '',
                             False,
                             '',
                             '',
                             '',
                             0,
                             '',
                             '',
                             0.0,
                             0,
                             objMovGag.strCodVen,
                             IIF(fEmptyStr(fCfgSis('TMACND')), IIF(Not fEmptyStr(fRetConPag('039')),'039',fRetCodCndAVista), fCfgSis('TMACND')), // PADRÃO DA HIDROMAR
                             IIF(fEmptyStr(fCfgSis('TMAFPG')), IIF(Not fEmptyStr(fRetConPag('039')),'008','001'), fCfgSis('TMAFPG')),            // PADRÃO DA HIDROMAR
                             recServicos,
                             '',
                             VS_Date,
                             0,
                             0,
                             '',
                             strTipPed,
                             '',
                             0,
                             'S',
                             0,
                             '1',
                             '',
                             0,
                             '',
                             '',
                             False,
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             False,
                             VS_Date,
                             'N',
                             'V',
                             VS_Date,
                             '',
                             0,
                             '',
                             '',
                             '',
                             False,
                             '',
                             Nil,
                             '',
                             '',
                             0,
                             0,
                             0,
                             '',
                             Nil,
                             '',
                             0,
                             0,
                             '',
                             '',
                             0,
                             '',
                             0,
                             '',
                             '0',
                             'N',
                             'N');

      If (Result) Then
      Begin

        With cdsItens Do
        Begin

          First;

          While Not Eof Do
          Begin
            fatVenda.pRetornaAliquotaItem(cdsItens.FieldByName('CODITE').AsString, VS_strCodEmp, fltPerIcm, strCodSit);
            blnTemST := CST_SUBSTITUICAO.Contains(strCodSit);

            fltUnitar := fGetValorVendaParaFilial(strCodCli, FieldByName('CODITE').AsString, blnTemST);

            strAutIncDet := '';
            Result := fGravaFatDor(strAutIncDet,
                                   strAutInc,
                                   objMovGag.strCodEmp,
                                   strCodCli,
                                   FieldByName('CODVEN').AsString,
                                   FieldByName('CODITE').AsString,
                                   fRetMarcaItem(FieldByName('CODITE').AsString),
                                   '',
                                   strNumPed,
                                   'PD',
                                   '',
                                   VS_Date,
                                   fTime(),
                                  IIF(Not fEmptyStr(fCfgSis('TMACND')), fRetConPag(fCfgSis('TMACND')), IIf(fEmptyStr(fCfgSis('TMACON')), '01001', fCfgSis('TMACON'))), // PADRÃO DA HIDROMAR
                                   '',
                                   FieldByName('DESITE').AsString,
                                   FieldByName('REFERE').AsString,
                                   fRetUnidadeItem(FieldByName('CODITE').AsString),
                                   FieldByName('CODFOR').AsString,
                                   FieldByName('QTDITE').AsFloat,
                                   fFormataFloat(fltUnitar,2),
                                   fFormataFloat(fltUnitar,2),
                                   fFormataFloat(fltUnitar,2),
                                   fFormataFloat(fltUnitar * FieldByName('QTDITE').AsFloat,2),
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   fRetCodRepresCliente(fRetornaClienteFilial(objMovGag.strCodEmp)),
                                   '',
                                   0,
                                   0,
                                   0,
                                   '5999',
                                   '',
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   False,
                                   '',
                                   '',
                                   '',
                                   0,
                                   '',
                                   '',
                                   0,
                                   'NOR',
                                   '',
                                   '',
                                   IIF(fEmptystr(fCfgSis('TMACND')), IIF(Not fEmptyStr(fRetConPag('039')),'039',fRetCodCndAVista), fCfgSis('TMACND')), // PADRÃO DA HIDROMAR
                                   '',
                                   IIF(fEmptyStr(fCfgSis('TMAFPG')), IIF(Not fEmptyStr(fRetConPag('039')),'008','001'), fCfgSis('TMAFPG')),            // PADRÃO DA HIDROMAR
                                   '',
                                   '',
                                   '',
                                   '',
                                   0,
                                   0,
                                   '',
                                   0,
                                   0,
                                   0,
                                   '',
                                   '',
                                   0,
                                   '',
                                   '',
                                   0.0,
                                   0,
                                   0,
                                   fFormataFloat(fltUnitar,2),
                                   '',
                                   0,
                                   '',
                                   '',
                                   False,
                                   '1',
                                   '',
                                   '',
                                   '',
                                   0,
                                   '',
                                   0,
                                   strEntRet,
                                   '',
                                   'N',
                                   '',
                                   0,
                                   0,
                                   0,
                                   0,
                                   '',
                                   objCadLot.fRetArmazemPrincipalGarantia(FieldByName('CODITE').AsString),
                                   '',
                                   False,
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   0,
                                   0,
                                   '',
                                   '',
                                   0,
                                   '',
                                   '',
                                   0,
                                   0,
                                   0);

            If (Result) Then
            Begin
              Result := objMovGag.objMovGad.fAtualizaSeqGarantia('SEQ_MOVGAD', FieldByName('AUTINC').AsString, 'SEQ_MOVGAD', FieldByName('AUTINC').AsString);

              If (Result) Then
                Result := objMovGag.objMovGad.fAtualizaSeqGarantia('SEQ_FDO_TE', strAutIncDet, 'SEQ_MOVGAD', FieldByName('AUTINC').AsString);
            End;

            If (Not Result) Then
              Break;

            Next;

          End;

        End;

      End;

      if fUsaRotinaGarantiaItensPesados Then
      Begin
        cdsItens.Filtered := False;
        cdsItens.Filter   := '';
      End;

    finally
      FreeAndNil(objTipoEntregaRetiraExpedicao);
    end;

  End;
End;

{**************************************}
{* LIMPA DADOS PARA UMA NOVA GARANTIA *}
{***********************************RL*}
procedure TfrmGarantiaRecCliente.pLimpaDados;
begin
  FPerguntarAplicarVendedorTodosItens := True;
  strCodVenDig := EmptyStr;
  blnClienteFilial := False;
  pLimpaEdits(True, True);
  strCodCliAnt := '';
  cdsItens.Cancel;
  cdsItens.EmptyDataSet;
  strItensExcluidos  := '';
  strAutIncExcluidos := '';
  objMovGag.qryMovGag.Close;
  objMovGag.objMovGad.qryMovGad.Close;
  objMovGag.strNumEnt := '';
  strCodCliCre := '';
  pnlProdutos.Enabled := True;
  edtCodCli.Enabled := True;
  pnlGarantia.Enabled := (not cdsItens.Active) Or (cdsItens.IsEmpty);
  FillChar(recNotEle, SizeOf(TRecInfoNotaEletronica), #0);
  pExibirFavorecido(False);
  pExibirEdtUniCrd(False);
  objMovGag.strGarInd := TTipoGarantia.Padrao.fEhGarantiaIndustriaBoolAsString;
  pSetTipoGarantia(TTipoGarantia.Padrao);
  FListaItensSemDocumento.clear;
  pLimparClienteMovGag;

  recPessoasOperacao.recVendedor.strCodigo := EmptyStr;
  recPessoasOperacao.recVendedor.strNome   := EmptyStr;
  recPessoasOperacao.recDigitador.strCodigo := EmptyStr;
  recPessoasOperacao.recDigitador.strNome := EmptyStr;
  FRecDocGarantia.pDefinir('');
  FRecDocReposicao.pDefinir('');
  FModoGarantia.pLimparSelecao;
end;

{*******************************************}
{* HABILITA / DESABILITA EDITS DE OBS.     *}
{****************************************RL*}
procedure TfrmGarantiaRecCliente.pHabilitaOBS;
begin
  edtObsP_1.ReadOnly:= False;
  edtObsP_1.TabStop := True;
  edtObsP_1.Color   := clWhite;
  edtObsP_2.ReadOnly:= False;
  edtObsP_2.TabStop := True;
  edtObsP_2.Color   := clWhite;
end;

procedure TfrmGarantiaRecCliente.pIncluirOcorrenciaCRM;
Var
  lrecDadosGarantiaCRM: TDadosGarantiaCRM;

begin
  If Not VS_strHabilitarCRM Then
    Exit;

  if fVaiUtilizarAD and Not qryAD.IsEmpty then
    lrecDadosGarantiaCRM.strCodAde := qryAD.FieldByName('GER_CODADE').AsString
  else
    lrecDadosGarantiaCRM.strCodAde := '';

  lrecDadosGarantiaCRM.strNumEnt := FRecDocGarantia.strNumDoc;
  lrecDadosGarantiaCRM.strEspDoc := FRecDocGarantia.strEspDoc;
  lrecDadosGarantiaCRM.strCodCli := objMovGag.strCodCli;
  lrecDadosGarantiaCRM.strNomCli := objMovGag.strNomCli;
  lrecDadosGarantiaCRM.strCodEmp := VS_strCodEmp;
  lrecDadosGarantiaCRM.strNomFrm := 'TfrmGarantiaRecCliente';
  lrecDadosGarantiaCRM.blnGeraCreditoNoRecebimento := blnGeraCreditoNoRecebimento;

  if FModoGarantia.fSelecionado = TOperacaoGarantia.ogReposicao then
    lrecDadosGarantiaCRM.strDescri := 'Número da NF de Saida: ' + FRecDocReposicao.strNumDoc
  else
    lrecDadosGarantiaCRM.strDescri := '';

  TCRMGarantia.pIncluirOcorrenciaRecebimentoCliente(lrecDadosGarantiaCRM, FModoGarantia.fSelecionado);
end;

procedure TfrmGarantiaRecCliente.pInfoStatusGravacao(strInformacao: String;
  pgbProgresso: TcxProgressBar);
begin
  If Assigned(pgbProgresso) And (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strInformacao;
    Application.ProcessMessages;
  End;
end;

procedure TfrmGarantiaRecCliente.pInicializarArrDocumentosVendas;
begin
  if Length(arrDocumentosVendas) > 0 then
    Finalize(arrDocumentosVendas);
  SetLength(arrDocumentosVendas, 0);
end;

procedure TfrmGarantiaRecCliente.pInicializaTemporaria;
begin
  cdsVenda.EmptyDataSet;
  fatVenda.strMen001 := '';
  fatVenda.strMen002 := '';
end;

{*******************************************}
{* SE A GARANTIA POSSUI ALGUM PRODUTO JÁ   *}
{* ENVIADO PARA O FORNECEDOR, HABILITA O   *}
{* FORM. APENAS PARA CONSULTA              *}
{****************************************RL*}
procedure TfrmGarantiaRecCliente.pHabilitaForm(blnStatus: Boolean);
begin
  pnlGarantia.Enabled  := blnStatus;
  pnlProdutos.Enabled  := blnStatus;
  dbgItens.ReadOnly    := (Not blnStatus);

  if blnPermitirLiberarSemNotaVenda then
    dbgItens.ReadOnly := False;

  btnConfirmar.Enabled := blnStatus;

  If fVaiUtilizarAD Or (Not fEmptyStr(recNotEle.strAutInc)) Then
  Begin
    pnlProdutos.Enabled := False;
    pnlProdutos.TabStop := False;
  End;

end;

{*******************************************}
{* HABILITA / DESABILITA BOTÕES            *}
{****************************************RL*}
procedure TfrmGarantiaRecCliente.pHabilitaBotoes(DataSet: TDataSet);
begin
  FEditandoItem := False;
  If dbgItens.Focused Then
  Begin
    pCarregaItensAlteracao(False);
    Exit;
  End;

  btnConfirmar.Enabled  := (Not DataSet.IsEmpty);
end;

procedure TfrmGarantiaRecCliente.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaEnt);
end;

procedure TfrmGarantiaRecCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  cdsItens.AfterScroll := Nil;
  cdsItens.Close;

  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  pDestroyFatVendas;
end;

procedure TfrmGarantiaRecCliente.pSelecionarLote;
  Var
    arrNumLot : TConsultasArray;
    edtNumLotTmp: TEditFocus;
    strCodIte: String;
    Key: Char;
    strNumLotTmp: String;

begin
  Key := '/';
  if cdsItens.IsEmpty then
    Exit;

  strCodIte := cdsItens.FieldByName('CODITE').AsString;
  if Not objCadLot.fExisteLote(fRetCodItem(strCodIte),VS_strCodEmp, edtNumLot.Text) then
  begin
    fMensagem('','O produto não possui lote!',['&Ok']);
    exit;
  end;

  edtNumLotTmp := Nil;
  Try
    edtNumLotTmp := TEditFocus.Create(Self);
    edtNumLotTmp.Name := 'edtNumLotTmp';
    edtNumLotTmp.Tag := 99;
    edtNumLotTmp.TipoTexto := ttAlfanumerico;
    edtNumLotTmp.CompZeros := False;
    edtNumLotTmp.Text := EmptyStr;

    If fPesqLoteItens(Self, edtNumLotTmp, nil, intQtdCasasDecimaisValorUnitario, Nil,Key, arrNumLot, True, fRetCodItem(strCodIte)) Then
      strNumLotTmp := edtNumLotTmp.Text;

  finally
    edtNumLotTmp.Free;
  end;

  cdsItens.Edit;
  cdsItensLOTSAI.AsString := strNumLotTmp;
  cdsItens.Post;
end;

procedure TfrmGarantiaRecCliente.dbgItensKeyPress(Sender: TObject;
  var Key: Char);


begin
  inherited;
  if dbgItens.SelectedField = cdsItensLOTSAI then
    Exit;

  if fEntraConsultaDocumento(Key) then
    pSelecionarDocumentoItem
  else  If ((UpperCase(Key) <> 'N') And (UpperCase(Key) <> 'S')) And (Key <> #13) Then
    Key := #0;

end;

function TfrmGarantiaRecCliente.fOutrasEntradasFaturamento: Boolean;
  Var
    blnConfirma: Boolean;
    strEstEmp: String;

    strNumDocRef,
    strEspDocRef,
    strCodEmpRef: String;
    qryCupom: TUniQuery;

begin
  Result := False;
  blnConfirma := fIncluiItens(fatVenda, 'N');
  Try
    If (blnConfirma) Then
    Begin
      if (fatVenda.strOpcDoc = 'DV') and (not fValidaDevolucaoEmpresa) then
          exit(False);

      //Colocando referencia no documento de outras entradas (NF Selecionada)
      cdsGroup.First;
      strNumDocRef := Copy(cdsGroup.FieldByName('NUMDOC').AsString, 1, fTamDocCadRec);
      strEspDocRef := Copy(cdsGroup.FieldByName('NUMDOC').AsString, IfThen(fTamDocCadRec = 6, 8, 14), 2);
      strCodEmpRef := cdsGroup.FieldByName('EMPDOC').AsString;

      If strEspDocRef = 'IF' Then
      Begin
        qryCupom := fCriaQuery;
        Try
          With qryCupom, SQL Do
          Begin
            Close;
            Clear;
            Add(' SELECT AUX_NUMCOO,                             ');
            Add('        AUX_NUMSER,                             ');
            Add('        AUX_NUMUSU                              ');
            Add(' FROM MOVGER                                    ');
            Add('   INNER JOIN AUXMOV ON AUX_SEQGER = AUTOINCREM ');
            Add(' WHERE GER_NUMDOC = :NUMDOC                     ');
            Add('   AND GER_ESPDOC = :ESPDOC                     ');
            Add('   AND GER_CODCLI = :CODCLI                     ');
            Add('   AND GER_CODEMP = :CODEMP                     ');

            ParamByName('NUMDOC').AsString := strNumDocRef;
            ParamByName('ESPDOC').AsString := strEspDocRef;
            ParamByName('CODCLI').AsString := edtCodCli.Text;
            ParamByName('CODEMP').AsString := strCodEmpRef;

            Open;

            fatVenda.strNumCOONFeRefDevolucao := FieldByName('AUX_NUMCOO').AsString;
            fatVenda.strNumSerNFeRefDevolucao := FieldByName('AUX_NUMSER').AsString;
            fatVenda.strNumUSUNFeRefDevolucao := FieldByName('AUX_NUMUSU').AsString;
          End;
        Finally
          FreeAndNil(qryCupom);
        End;
      End;


      pAdicionarChavesReferenciadas(cdsGroup, fatVenda);

      fatVenda.pCarregaAliquotasRetencao;

      fatVenda.pPreencheMatrizFechamento;

      fatVenda.pCalculaPesBruLiq;

      fatVenda.pCalculaTotGer(False, False);

      If fatVenda.fAplicaDescontoIcmsOrgaoPublicoNoDescontoEspecial Then
      Begin
        If (fatVenda.fltDesEsp <= 0.00) And (fatVenda.fltIcmOrg > 0) Then
          fatVenda.fltDesEsp := fatVenda.fltIcmOrg;
      End;

      fatVenda.pCalculaTotGer(False, False);

      fatVenda.pCalculaTotGer;

      fatVenda.strClaFis := fatVenda.strClaFisRecGarantia;
      fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

      fatVenda.pDestacaRetencoes;
      fatVenda.pRetemImpostosNoDescontoEspecial;
      fatVenda.pCalculaTotalParaCadRec;

      fatVenda.pRateiaValores;
      fatVenda.pSintetizaClassificacoes;

      If (fatVenda.strEspDoc = 'NF') Then
      Begin
        Try
          pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);

          strEstEmp := fRetUFEmpresa;

          frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text    := fatVenda.strClafis;
          frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Text    := fatVenda.strDesCla;
          frmFatDadosFiscais.fltOUTDesAce      := fltDesAce;
          frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled := False;
          frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Enabled := (fCfgSis('OPCCFO', varInteger) = 1);
          frmFatDadosFiscais.blnForcaEdiBas    := True;
          frmFatDadosFiscais.fatVenda := fatVenda;

          frmFatDadosFiscais.Caption := frmFatDadosFiscais.Caption;
          frmFatDadosFiscais.ShowModal;

          blnConfirma := frmFatDadosFiscais.blnConfirma;

        Except
          On E: Exception Do
          Begin
            blnConfirma := False;
            pMensagensErro(E.Message, '[TfrmGarantiaRecCliente.fOutrasEntradasFaturamento_1]');
          End;
        End;

        pFreeAndNil(frmFatDadosFiscais);
      End;

      {**************************************}
      {* CASO NÃO TENHA CONFIRMADO          *}
      {* DADOS FISCAIS OU CFOP DA GARANTIA  *}
      {***********************************FC*}
      If (Not blnConfirma) Then
      Begin
        pInicializaTemporaria;
        Exit;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmGarantiaRecCliente.fOutrasEntradasFaturamento_2]');
      pInicializaTemporaria;
    End;
  End;

  Result := blnConfirma;
end;

function TfrmGarantiaRecCliente.fOutrasSaidasFaturamento: Boolean;
  Var
    blnConfirma: Boolean;
    strEstEmp: String;
begin
  Result := False;

  Try
    blnConfirma := fIncluiItens(fatVenda2, 'S');
    If (blnConfirma) Then
    Begin
      fatVenda2.pCarregaAliquotasRetencao;

      fatVenda2.pPreencheMatrizFechamento;

      fatVenda2.pCalculaPesBruLiq;

      fatVenda2.pCalculaTotGer(False, False, nil, False); { req 313492 ajustei para não recalcular a CFOP }

      If Not (SameText(fatVenda2.strCliOrg,'S') And (fatVenda2.fltDesEsp > 0)) Then
        fatVenda2.fltDesEsp := fatVenda2.fltDesEsp + fatVenda2.fltIcmOrg;

      fatVenda2.pCalculaTotGer(False, False, Nil, False); { req 313492 ajustei para não recalcular a CFOP }

      fatVenda2.pCalculaTotGer(False, True, Nil, False); { req 313492 ajustei para não recalcular a CFOP }
                                                         {untCFOPReposicaoClienteGarantia - GetClassificacao não está preparada para quando há mais de um cfop informada na cfg CREPGC }

      //fatVenda2.strClaFis := fatVenda2.strClaFisRecGarantia;
      //fatVenda2.strDesCla := fRetDesCla(fatVenda2.strClaFis);

      fatVenda2.strClaFis := strClaFisEnt;
      fatVenda2.strDesCla := fRetDesCla(strClaFisEnt);

      fatVenda2.pDestacaRetencoes;
      fatVenda2.pRetemImpostosNoDescontoEspecial;
      fatVenda2.pCalculaTotalParaCadRec;

      fatVenda2.pRateiaValores;
      fatVenda2.pSintetizaClassificacoes(False); { req 313492 ajustei para não recalcular a CFOP }

      If (fatVenda2.strEspDoc = 'NF') Then
      Begin
        Try
          pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);

          strEstEmp := fRetUFEmpresa;

          frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text    := fatVenda2.strClafis;
          frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Text    := fatVenda2.strDesCla;
          frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled := False;
          frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Enabled := (fCfgSis('OPCCFO', varInteger) = 1);
          frmFatDadosFiscais.blnForcaEdiBas    := True;
          frmFatDadosFiscais.fatVenda := fatVenda2;

          frmFatDadosFiscais.Caption := frmFatDadosFiscais.Caption;
          frmFatDadosFiscais.ShowModal;

          blnConfirma := frmFatDadosFiscais.blnConfirma;

        Except
          On E: Exception Do
          Begin
            blnConfirma := False;
            pMensagensErro(E.Message, '[TfrmGarantiaRecCliente.fOutrasSaidasFaturamento_1]');
          End;
        End;

        pFreeAndNil(frmFatDadosFiscais);
      End;

      {**************************************}
      {* CASO NÃO TENHA CONFIRMADO          *}
      {* DADOS FISCAIS OU CFOP DA GARANTIA  *}
      {***********************************FC*}
      If (Not blnConfirma) Then
      Begin
        pInicializaTemporaria;
        Exit;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '[TfrmGarantiaRecCliente.fOutrasSaidasFaturamento_2]');
      pInicializaTemporaria;
    End;
  End;

  Result := blnConfirma;
end;

function TfrmGarantiaRecCliente.fPermitirInserirItemDofornecedorParaTipoGarantia(const strCodFor: String): Boolean;
begin
  Result := Not blnCFG_GARIND;

  if Not Result then
    Result := fEmptyStr(strFornecedorFilial);

  if Result then
    Exit;


  case Self.FenuTipoGarantia of
    TTipoGarantia.IndustriaProprio: Result := strCodFor = strFornecedorfilial;
    TTipoGarantia.IndustriaRevenda: Result := strCodFor <> strFornecedorfilial;
  else
    Result := True;
  end;
end;



function TfrmGarantiaRecCliente.fRetCodItem(strCodIte: String): String;
begin
  Result := strCodIte;

  If blnLerCodigoBarras and fEmptyStr(recNotEle.strAutInc) Then
  Begin
    Result := fCampoTabela('ITE_CODITE', 'CADITE', ['ITE_CODBAR'], [strCodIte]);
    If fEmptyStr(Result) Then
      Result := fCampoTabela('BAR_CODITE', 'ITEBAR', ['BAR_CODBAR'], [strCodIte]);
  End;
end;

procedure TfrmGarantiaRecCliente.pImprimeEtiqueta;
var
  i, x, intIndex  : Integer;
  qryIteEti : TUniQuery;
  cdsIteEti : TZClient;
  strNomFil : String;
  prmDllEtq : TParamDllEtiquetas;
  strArquivo: String;
begin
  inherited;

  pCarregaConfImpr(qryCfgRel, Self.Name);
  strNomFil := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

  strArquivo := IncludeTrailingPathDelimiter(fCfgSis('PATETI', varString)) + 'eti_garantia_rec_cliente.fr3';
  if FileExists( strArquivo ) And (fMensagem('ATENÇÃO', 'Imprimir Etiquetas ?', ['&Sim', '&Não']) = 1) then
  begin
    cdsIteEti := TZClient.Create(Self);

    With cdsIteEti, qryQuery.SQL Do
    Begin
      Add(' SELECT GAD_NUMDOC AS NUMDOC,                          ');
      Add('        GAD_ESPDOC AS ESPDOC,                          ');
      Add('        GAG_CODEMP AS CODEMP,                          ');
      Add('        GAG_DTAENT AS DTAENT,                          ');
      Add('        GAD_CODFOR AS CODFOR,                          ');
      Add('        GAD_CODITE AS CODITE,                          ');
      Add('        GAD_QTDREQ AS QTDITE,                          ');
      Add('        GAG_NUMENT AS NUMGAR,                          ');
      Add('        GAG_CODCLI AS CODCLI,                          ');
      Add('        IF( LOCATE("CONSUMIDOR", CLI_NOMCLI) > 0, GAG_NOMCON, CLI_NOMCLI) AS NOMCLI, ');
      Add('        C.ITE_DESITE AS DESITE,                        ');
      Add('        C.ITE_DESFAB AS DESFAB,                        ');
      Add('        C.ITE_REFERE AS REFERE,                        ');
      Add('        C.ITE_CODFAB AS CODFAB,                        ');
      Add('        C.ITE_CODBAR AS CODBAR,                        ');
      Add('        G.ITE_LOCSUP AS LOCSUP,                        ');
      Add('        UNI_SIGUNI AS SIGUNI,                          ');
      Add('        GAG_OBSER1 AS OBSER1,                          ');
      Add('        GAG_OBSER2 AS OBSER2,                          ');
      Add('        GAD_OBSP_1 AS OBSP_1,                          ');
      Add('        GAD_OBSP_2 AS OBSP_2,                          ');
      Add(QuotedStr(strLoginUsuarioLogado) + ' AS OPEIMP, ');
      Add(QuotedStr(fRetNomeOperador(strLoginUsuarioLogado)) + ' AS NOMOPE, ');
      Add('        FOR_NOMFOR AS NOMFOR                           ');
      Add(' FROM MOVGAD                                           ');
      Add('   INNER JOIN MOVGAG ON MOVGAG.AUTOINCREM = GAD_SEQGAG ');
      Add('   INNER JOIN CADITE C ON C.ITE_CODITE = GAD_CODITE ');
      Add('   INNER JOIN CADUNI ON CADUNI.UNI_CODUNI = ITE_CODUNI ');
      Add('   INNER JOIN CADCLI ON CADCLI.CLI_CODCLI = GAG_CODCLI ');
      Add('   LEFT JOIN CADFOR ON FOR_CODFOR = GAD_CODFOR         ');
      Add('   INNER JOIN ITEGER G ON G.ITE_CODITE = GAD_CODITE AND G.ITE_CODEMP = GAG_CODEMP ');

      Add(' WHERE GAG_NUMENT = ' + QuotedStr(objMovGag.strNumEnt)  );
      Add('   AND GAG_CODEMP = ' + QuotedStr(VS_strCodEmp)         );

      fAbreClient(True, 'TfrmGarantiaRecCliente.pImprimeEtiqueta');

      If not IsEmpty Then
      Begin

        EmptyDataSet;
        qryQuery.First;
        While Not qryQuery.Eof Do
        Begin
          For intIndex := 1 to Ceil(qryQuery.FieldByName('QTDITE').AsFloat) Do
          Begin
            cdsIteEti.Insert;
            FieldByName('NUMDOC').AsString := qryQuery.FieldByName('NUMDOC').AsString;
            FieldByName('ESPDOC').AsString := qryQuery.FieldByName('ESPDOC').AsString;
            FieldByName('CODEMP').AsString := qryQuery.FieldByName('CODEMP').AsString;
            FieldByName('DTAENT').AsString := qryQuery.FieldByName('DTAENT').AsString;
            FieldByName('CODFOR').AsString := qryQuery.FieldByName('CODFOR').AsString;
            FieldByName('CODITE').AsString := qryQuery.FieldByName('CODITE').AsString;
            FieldByName('QTDITE').AsFloat  := qryQuery.FieldByName('QTDITE').AsFloat;
            FieldByName('NUMGAR').AsString := qryQuery.FieldByName('NUMGAR').AsString;
            FieldByName('CODCLI').AsString := qryQuery.FieldByName('CODCLI').AsString;
            FieldByName('NOMCLI').AsString := qryQuery.FieldByName('NOMCLI').AsString;
            FieldByName('DESITE').AsString := qryQuery.FieldByName('DESITE').AsString;
            FieldByName('DESFAB').AsString := qryQuery.FieldByName('DESFAB').AsString;
            FieldByName('REFERE').AsString := qryQuery.FieldByName('REFERE').AsString;
            FieldByName('CODFAB').AsString := qryQuery.FieldByName('CODFAB').AsString;
            FieldByName('CODBAR').AsString := qryQuery.FieldByName('CODBAR').AsString;
            FieldByName('SIGUNI').AsString := qryQuery.FieldByName('SIGUNI').AsString;
            FieldByName('OBSER1').AsString := qryQuery.FieldByName('OBSER1').AsString;
            FieldByName('OBSER2').AsString := qryQuery.FieldByName('OBSER2').AsString;
            FieldByName('OBSP_1').AsString := qryQuery.FieldByName('OBSP_1').AsString;
            FieldByName('OBSP_2').AsString := qryQuery.FieldByName('OBSP_2').AsString;
            FieldByName('NOMOPE').AsString := qryQuery.FieldByName('NOMOPE').AsString;
            FieldByName('OPEIMP').AsString := qryQuery.FieldByName('OPEIMP').AsString;
            FieldByName('NOMFOR').AsString := qryQuery.FieldByName('NOMFOR').AsString;
            FieldByName('LOCSUP').AsString := qryQuery.FieldByName('LOCSUP').AsString;

            Post;
          End;


          qryQuery.Next;
        End;

        frxReportEti.LoadFromFile(strArquivo);
        frxDadosEti.DataSet := cdsIteEti;

        if not fEmptyStr(strNomFil) Then
        Begin
          frxReportEti.PrintOptions.Printer := AnsiReplaceStr(strNomFil,'\\' + fRetNomeRede + '\','');
          frxReportEti.PrintOptions.ShowDialog := False;
          pPrintReport(Self.Name, 'Garantia - ' + Self.Caption, strNomFil, frxReportEti);
        End
        Else
          pPreviewReport(Self.Name, 'Garantia - ' + Self.Caption, frxReportEti);
      End;
    End;

    FreeAndNil(cdsIteEti);
    Exit;
  End;

  qryIteEti := fCriaQuery(Self);
  prmDllEtq := TParamDllEtiquetas.Create;
  prmDllEtq.tpeTipEtq := tpeItensArgoxCodBarSPre;
  prmDllEtq.intTabPre := 1;
  prmDllEtq.dtsImpres := qryIteEti;
  prmDllEtq.strNomFil := strNomFil;
  prmDllEtq.strNomFrm := Self.Name;
  prmDllEtq.intNumCop := 1;
  prmDllEtq.blnImpEti := True;

  Try
    Try
      With cdsItens Do
      Begin
        First;
        While Not Eof Do
        Begin
          cdsIteEti := TZClient.Create(nil, fGetSqlItemEtiqueta(cdsItens.FieldByName('CODITE').AsString,
                                                   cdsItens.FieldByName('QTDITE').AsInteger,
                                                   FormatDateTime('dd/mm/yyyy', objMovGag.dtaDtaEnt),
                                                   objMovGag.strNumEnt,
                                                   cdsItens.FieldByName('OBSP_1').AsString,
                                                   cdsItens.FieldByName('OBSP_2').AsString,
                                                   cdsItens.FieldByName('CODCLI').AsString,
                                                   cdsItens.FieldByName('CODFOR').AsString));
          Try


            qryIteEti.Close;
            qryIteEti.SQL.Clear;
            qryIteEti.SQL.Add( fGetSqlItemEtiqueta(cdsItens.FieldByName('CODITE').AsString,
                                                   cdsItens.FieldByName('QTDITE').AsInteger,
                                                   FormatDateTime('dd/mm/yyyy', objMovGag.dtaDtaEnt),
                                                   objMovGag.strNumEnt,
                                                   cdsItens.FieldByName('OBSP_1').AsString,
                                                   cdsItens.FieldByName('OBSP_2').AsString,
                                                   cdsItens.FieldByName('CODCLI').AsString,
                                                   cdsItens.FieldByName('CODFOR').AsString));
            qryIteEti.Open;
            cdsIteEti.fAbreClient(False, 'TfrmGarantiaRecCliente.pImprimeEtiqueta');
            for i := 2 To cdsItens.FieldByName('QTDITE').AsInteger do
            begin
              cdsIteEti.Insert;
              For x := 0 to qryIteEti.Fields.Count -1 do
                cdsIteEti.Fields[x].Value := qryIteEti.Fields[x].Value;
              cdsIteEti.Post;
            end;
            prmDllEtq.dtsImpres := cdsIteEti;
            fImprimeEtiqueta(prmDllEtq, 'fImprimeEtiquetaGeral');
          finally
            FreeAndNil(cdsIteEti);
          end;

          Next;
        End;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmGarantiaRecCliente.pImprimeEtiqueta]');
      End;
    End;
  Finally
    FreeAndNil(prmDllEtq);
    FreeAndNil(qryIteEti);
  End;
End;

function TfrmGarantiaRecCliente.fGetSqlItemEtiqueta(strCodIte: String; intQtdIte: Integer;
                                                    strDtaEnt: String = '';
                                                    strNumGar: String = '';
                                                    strObser1: String = '';
                                                    strObser2: String = '';
                                                    strCodCli: String = '';
                                                    strCodFor: String = ''): String;

var
  intContador : Integer;
  strSQL      : String;
begin
  Result := '';
  Result := Result + ' SELECT                      ';
  Result := Result + '     EMP_C_G_C_ AS EMPCGC,   ';
  Result := Result + '     EMP_NOMEMP AS NOMEMP,   ';
  Result := Result + '     EMP_FONDA1 AS FONDA1,   ';
  Result := Result + '     EMP_FONDA2 AS FONDA2,   ';
  Result := Result + '   G.ITE_LOCFIS AS LOCFIS,   ';
  Result := Result + '   G.ITE_LOCSUP AS LOCSUP,   ';
  Result := Result + '   G.ITE_ESTMIN AS ESTMIN,   ';
  Result := Result + '   G.ITE_ESTMAX AS ESTMAX,   ';
  Result := Result + '   I.ITE_CODITE AS CODITE,   ';
  Result := Result + '   I.ITE_CODGRU AS CODGRU,   ';
  Result := Result + '   I.ITE_DESITE AS DESITE,   ';
  Result := Result + '   I.ITE_REFERE AS REFERE,   ';
  Result := Result + '   I.ITE_EMBALA AS EMBALA,   ';
  Result := Result + '   I.ITE_APLICA AS APLICA,   ';
  Result := Result + '     ITE_COMPOS AS COMPOS,   ';
  Result := Result + '     ITE_CODFOR AS CODFOR,   ';
  Result := Result + '   I.ITE_ATICOM AS ATICOM,   ';
  Result := Result + '     UNI_SIGUNI AS SIGUNI,   ';
  Result := Result + '   I.ITE_CODFAB AS CODFAB,   ';
  Result := Result + '   I.ITE_CODBAR AS CODBAR,   ';
  Result := Result + '   I.ITE_MLTVEN AS MLTVEN,   ';
  Result := Result + '   I.ITE_DESSIM AS DESSIM, ';
  Result := Result + '   G.ITE_EMBFEC AS EMBFEC, ';
  Result := Result + '   G.ITE_SALDOS AS SALDOS,  ';
  Result := Result + '   ITEETI.ETI_QTDETI AS QTDETI, ';
  Result := Result + '   ITEETI.ETI_OBSERV AS OBSIMP, ';
  Result := Result + '     ITE_ITESAC AS ITESAC, ';
  Result := Result + '  ""  AS NUMDOC, ';
  Result := Result + '  ""  AS ESPDOC, ';
  Result := Result + '  ""  AS SERIE_, ';
  Result := Result + '  0   AS PREVIS, ';
  Result := Result + '  0   AS QTDPAR, ';

  For intContador := 0 To 9 Do
  Begin
    Result := Result + ' ( SELECT ITB_QTDEMB                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intContador) +',1) AS QTDEM'+ IntToStr(intContador) + ', ';

    Result := Result + ' ( SELECT ITB_DESCON                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE           ';
    Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP           ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intContador) +',1) AS DESCO'+ IntToStr(intContador) + ', ';

    Result := Result + ' ( SELECT ITB_TABPRE                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE           ';
    Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP           ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intContador) +',1) AS TABPR'+ IntToStr(intContador) + ', ';

  End;


  Result := Result + '     MAR_DESMAR AS DESMAR,   ';
  Result := Result + '     IPR_PREVEN AS PROMOC,   ';
  Result := Result + ' IFNULL(IPR_PERDES, 0) AS PERDES, ';
  Result := Result + ' IFNULL(IPR_QTDMIN, 0) AS QTDMIN, ';

  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '1') + ' AS ITE_PREVE1, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '1') +  ' AS PREVE1, ';

  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '2') + ' AS ITE_PREVE2, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '2') + ' AS PREVE2, ';

  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '3') + ' AS ITE_PREVE3, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '3') + ' AS PREVE3, ';

  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '4') + ' AS ITE_PREVE4, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '4') + ' AS PREVE4, ';

  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '5') + ' AS ITE_PREVE5, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '5') + ' AS PREVE5, ';

  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '6') + ' AS ITE_PREVE6, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '6') + ' AS PREVE6, ';

  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '7') + ' AS ITE_PREVE7, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '7') + ' AS PREVE7, ';

  Result := Result + '  (SELECT GROUP_CONCAT(CADSEM.SEM_CODSEM) ';
  Result := Result + '     FROM CADSEM ';
  Result := Result + '    WHERE CADSEM.SEM_CODITE = I.ITE_CODITE ';
  Result := Result + '      AND CADSEM.SEM_CODEMP = I.ITE_CODEMP)AS CODSEM, ';


  Result := Result + '  "" AS LOTECR,   ';
  Result := Result + '   0 AS IBPIT1,   ';
  Result := Result + '   0 AS IBPIT2,   ';
  Result := Result + '   0 AS IBPIT3,   ';
  Result := Result + '   0 AS IBPIT4,   ';
  Result := Result + '   0 AS IBPIT5,   ';
  Result := Result + '   0 AS IBPIT6,   ';
  Result := Result + '   0 AS IBPIT7,   ';

  Result := Result + '   0 AS IBPFT1,   ';
  Result := Result + '   0 AS IBPFT2,   ';
  Result := Result + '   0 AS IBPFT3,   ';
  Result := Result + '   0 AS IBPFT4,   ';
  Result := Result + '   0 AS IBPFT5,   ';
  Result := Result + '   0 AS IBPFT6,   ';
  Result := Result + '   0 AS IBPFT7,   ';

  Result := Result + '   0 AS IBPET1,   ';
  Result := Result + '   0 AS IBPET2,   ';
  Result := Result + '   0 AS IBPET3,   ';
  Result := Result + '   0 AS IBPET4,   ';
  Result := Result + '   0 AS IBPET5,   ';
  Result := Result + '   0 AS IBPET6,   ';
  Result := Result + '   0 AS IBPET7,   ';

  Result := Result + '   0 AS IBPMT1,   ';
  Result := Result + '   0 AS IBPMT2,   ';
  Result := Result + '   0 AS IBPMT3,   ';
  Result := Result + '   0 AS IBPMT4,   ';
  Result := Result + '   0 AS IBPMT5,   ';
  Result := Result + '   0 AS IBPMT6,   ';
  Result := Result + '   0 AS IBPMT7,   ';

  Result := Result + '   I.ITE_MENFIS AS MENFIS,       ';
  Result := Result + '   I.ITE_MSGLV1 AS MSGLV1,       ';
  Result := Result + '   I.ITE_MSGLV2 AS MSGLV2,       ';

  Result := Result + QuotedStr(strLoginUsuarioLogado) + ' AS OPEIMP, ';
  Result := Result + QuotedStr(fRetNomeOperador(strLoginUsuarioLogado)) + ' AS NOMOPE, ';

  Result := Result + '   0.0000 AS VALITE,         ';
  Result := Result + '   0.0000 AS VALVIS,         ';
  Result := Result + '   CONCAT(I.ITE_CODFAB, " ", MAR_DESMAR) AS FABMAR,  ';
  Result := Result + '   "" AS DESEMB,             ';
  Result := Result + '   I.AUTOINCREM,             ';
  Result := Result + '   F.FOR_C_G_C_ AS CGCFOR,   ';
  Result := Result + '   "" AS QRCODE,             ';
  Result := Result + '   "" AS URLIMG,             ';
  Result := Result + '   '+QuotedStr(strDtaEnt)+' AS DTAENT, ';
  Result := Result + '   '+QuotedStr(strNumGar)+' AS NUMGAR, ';
  Result := Result + '   '+QuotedStr(strObser1)+' AS OBSER1, ';
  Result := Result + '   '+QuotedStr(strObser2)+' AS OBSER2, ';
  Result := Result + '   '+QuotedStr(strCodCli)+' AS CODCLI, ';

  if not fEmptyStr(strCodCli) then
    Result := Result + ' C.CLI_NOMCLI AS NOMCLI, '
  else
    Result := Result + ' ""           AS NOMCLI, ';

  Result := Result + '   F.FOR_CODFOR AS CODFOR, ';
  Result := Result + '   F.FOR_NOMFOR AS NOMFOR, ';

  Result := Result + '   '+QuotedStr(strCodFor)+' AS FORGAR, ';

  if not fEmptyStr(strCodFor) then
    Result := Result + ' FG.FOR_NOMFOR AS NOFOGA, '
  else
    Result := Result + ' CAST("" AS CHAR(1)) AS NOFOGA, ';


  Result := Result + ' @QTDEMB := ( SELECT ITB_QTDEMB                         ';
  Result := Result + '   FROM ITEEMB                               ';
  Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE      ';
  Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP      ';
  Result := Result + '     AND ITB_PRIROM = "S"                    ';
  Result := Result + '   ORDER BY ITB_QTDEMB LIMIT 1) AS QTDEMR, ';

  Result := Result + ' @DESCOR := ( SELECT ITB_DESCON                         ';
  Result := Result + '   FROM ITEEMB                               ';
  Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE      ';
  Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP      ';
  Result := Result + '     AND ITB_PRIROM = "S" LIMIT 1 ) AS DESCOR, ';

  Result := Result + '@PROMOC :=  IFNULL(IPR_PREVEN, ' + fGetSQLConsultaItensPrecoValidandoEstrutura('G', IntToStr(1)) + '),';
  Result := Result + '@UNITAR := ROUND(@PROMOC - (@PROMOC * @DESCOR) / 100,' + IntToStr(fCfgSis('DECUNI', varInteger)) + ') AS EMBFUN,';
  Result := Result + '@TOTAL := ROUND((@PROMOC - (@PROMOC * @DESCOR) / 100),'+ IntToStr(fCfgSis('DECUNI', varInteger)) + ') * @QTDEMB AS EMBFTO,';

  Result := Result + 'IF(@QTDEMB > 0,  CONCAT("LEVE ", ROUND(@QTDEMB) ," ", IFNULL(CADUNI.UNI_SIGUNI, "UND"), " POR R$ ", ROUND(@UNITAR, 2), " CADA, TOTAL R$ ", ROUND(@TOTAL, 2)), "") AS EXPEMB ';

  Result := Result + ' FROM                        ';
  Result := Result + '   CADITE I  ';
  Result := Result + '   INNER JOIN CADUNI ON I.ITE_CODUNI = UNI_CODUNI ';

  Result := Result + '   LEFT JOIN CADFOR F ON F.FOR_CODFOR = I.ITE_CODFOR ';

  if not fEmptyStr(strCodCli) then
    Result := Result + ' LEFT JOIN CADCLI C ON C.CLI_CODCLI = ' + QuotedStr(strCodCli);

  if not fEmptyStr(strCodFor) then
    Result := Result + ' LEFT JOIN CADFOR FG ON FG.FOR_CODFOR = ' + QuotedStr(strCodFor);

  Result := Result + '   INNER JOIN CADEMP ON EMP_CODEMP = ' + QuotedStr(VS_strCodEmp);

  Result := Result + '   INNER JOIN ITEGER G ON          ';
  Result := Result + '     I.ITE_CODITE = G.ITE_CODITE AND ';
  Result := Result + '     G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  Result := Result + '   INNER JOIN CADMAR ON       ';
  Result := Result + '     MAR_CODMAR = ITE_CODMAR  ';

  Result := Result + '   LEFT JOIN ITEETI ON ETI_CODITE = I.ITE_CODITE AND ETI_CODOPE = ' + QuotedStr(strLoginUsuarioLogado) + ' ';
  Result := Result + '   LEFT JOIN (SELECT IPR_PREVEN, IPR_CODITE, IPR_PERDES, IPR_QTDMIN FROM CADPRO JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
  Result := Result + '   WHERE  ';
  Result := Result + '   PRO_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND ' + fCurrentDate + ' BETWEEN PRO_DTAINI AND PRO_DTAFIN) AS TMP ON IPR_CODITE = G.ITE_CODITE ';

  Result := Result + ' WHERE                      ';
  Result := Result + '   I.ITE_CODITE = ' + QuotedStr(strCodIte);

  strSQL := Result;

end;

function TfrmGarantiaRecCliente.fGerarPedidoEmpGarComGarPes : Boolean;
Begin
  Result := False;
  if not fUsaRotinaGarantiaItensPesados Then
    Exit;

  Try
    cdsItens.DisableControls;
    cdsItens.Filtered := False;
    cdsItens.Filter   := 'GARFIL = ' + QuotedStr('N');
    cdsItens.Filtered := True;

    Result := not cdsItens.IsEmpty;
  Finally
    cdsItens.Filtered := False;
    cdsItens.Filter   := '';
    cdsItens.EnableControls;
  End;
End;

procedure TfrmGarantiaRecCliente.pGravaADE;
  Var
    qryAdeGer : TUniQuery;
    strNumDevP : String;
    strSeqGer : String;
    objOcoCrm : TAtuOcoCrm;

  procedure pLimparParametros;
  begin
    With qryAdeGer Do
    Begin
      ParamByName('CODADE').Value   := null;
      ParamByName('CODITE').Value   := null;
      ParamByName('CODMOT').Value   := null;
      ParamByName('QTDDEV').Value   := null;
      ParamByName('UNIDEV').Value   := null;
      ParamByName('CODEMP').Value   := null;
      ParamByName('AUTOIN').Value   := null;
      ParamByName('SEQGER').Value   := null;
      ParamByName('NUMDOC').Value   := null;
      ParamByName('ESPDOC').Value   := null;
      ParamByName('DTAMOV').Value   := null;
      ParamByName('FORCLI').Value   := null;
      ParamByName('TIP_FC').Value   := null;
      ParamByName('SERIE_').Value   := null;
      ParamByName('GARANT').Value   := null;
    End;
  end;

Begin
  Try
    qryAdeGer := fCriaQuery;

    qryAdeGer.Close;
    qryAdeGer.SQL.Clear;
    qryAdeGer.SQL.Add('INSERT INTO ADEGER ');
    qryAdeGer.SQL.Add('(                  ');
    qryAdeGer.SQL.Add('  GER_CODADE,      ');
    qryAdeGer.SQL.Add('  GER_CODOCO,      ');
    qryAdeGer.SQL.Add('  GER_CODEMP,      ');
    qryAdeGer.SQL.Add('  GER_GERCOL,      ');
    qryAdeGer.SQL.Add('  AUTOINCREM       ');
    qryAdeGer.SQL.Add(') VALUES (         ');
    qryAdeGer.SQL.Add('  :CODADE,         ');
    qryAdeGer.SQL.Add('  :CODOCO,         ');
    qryAdeGer.SQL.Add('  :CODEMP,         ');
    qryAdeGer.SQL.Add('  :GERCOL,         ');
    qryAdeGer.SQL.Add('  :AUTOIN)         ');

    strNumDevP := fAtualizaProCod('ADEGER', 'GER_CODADE');
    strSeqGer := fRetAutoIncrem('ADEGER', VS_strCodEmp);

    qryAdeGer.ParamByName('CODADE').AsString := strNumDevP;
    qryAdeGer.ParamByName('CODOCO').AsString := qryAD.FieldByName('GER_CODOCO').AsString;
    qryAdeGer.ParamByName('CODEMP').AsString := qryAD.FieldByName('GER_CODEMP').AsString;
    qryAdeGer.ParamByName('GERCOL').AsString := qryAD.FieldByName('GER_GERCOL').AsString;
    qryAdeGer.ParamByName('AUTOIN').AsString := strSeqGer;
    qryAdeGer.ExecSQL;
    qryAdeGer.Close;

    qryAdeGer.Close;
    qryAdeGer.SQL.Clear;
    qryAdeGer.SQL.Add('INSERT INTO ADEDET ');
    qryAdeGer.SQL.Add('(                  ');
    qryAdeGer.SQL.Add('  DET_CODADE,      ');
    qryAdeGer.SQL.Add('  DET_CODITE,      ');
    qryAdeGer.SQL.Add('  DET_CODMOT,      ');
    qryAdeGer.SQL.Add('  DET_QTDDEV,      ');
    qryAdeGer.SQL.Add('  DET_UNIDEV,      ');
    qryAdeGer.SQL.Add('  DET_CODEMP,      ');
    qryAdeGer.SQL.Add('  AUTOINCREM,      ');
    qryAdeGer.SQL.Add('  DET_SEQGER,      ');
    qryAdeGer.SQL.Add('  DET_NUMDOC,      ');
    qryAdeGer.SQL.Add('  DET_ESPDOC,      ');
    qryAdeGer.SQL.Add('  DET_DTAMOV,      ');
    qryAdeGer.SQL.Add('  DET_QTDORI,      ');
    qryAdeGer.SQL.Add('  DET_FORCLI,      ');
    qryAdeGer.SQL.Add('  DET_TIP_FC,      ');
    qryAdeGer.SQL.Add('  DET_SERIE_,      ');
    qryAdeGer.SQL.Add('  DET_GARANT       ');
    qryAdeGer.SQL.Add(') VALUES (         ');
    qryAdeGer.SQL.Add('  :CODADE,         ');
    qryAdeGer.SQL.Add('  :CODITE,         ');
    qryAdeGer.SQL.Add('  :CODMOT,         ');
    qryAdeGer.SQL.Add('  :QTDDEV,         ');
    qryAdeGer.SQL.Add('  :UNIDEV,         ');
    qryAdeGer.SQL.Add('  :CODEMP,         ');
    qryAdeGer.SQL.Add('  :AUTOIN,         ');
    qryAdeGer.SQL.Add('  :SEQGER,         ');
    qryAdeGer.SQL.Add('  :NUMDOC,         ');
    qryAdeGer.SQL.Add('  :ESPDOC,         ');
    qryAdeGer.SQL.Add('  :DTAMOV,         ');
    qryAdeGer.SQL.Add('  :QTDORI,         ');
    qryAdeGer.SQL.Add('  :FORCLI,         ');
    qryAdeGer.SQL.Add('  :TIP_FC,         ');
    qryAdeGer.SQL.Add('  :SERIE_,         ');
    qryAdeGer.SQL.Add('  :GARANT)         ');

    cdsAdeDet.First;
    while not cdsAdeDet.Eof do
    begin
      pLimparParametros;

      qryAdeGer.ParamByName('CODADE').AsString := strNumDevP;
      qryAdeGer.ParamByName('CODITE').AsString := cdsAdeDet.FieldByName('DET_CODITE').AsString;
      qryAdeGer.ParamByName('CODMOT').AsString := cdsAdeDet.FieldByName('DET_CODMOT').AsString;
      qryAdeGer.ParamByName('QTDDEV').AsFloat  := cdsAdeDet.FieldByName('DET_QTDDEV').AsFloat;
      qryAdeGer.ParamByName('UNIDEV').AsFloat  := cdsAdeDet.FieldByName('DET_UNIDEV').AsFloat;
      qryAdeGer.ParamByName('CODEMP').AsString := qryAD.FieldByName('GER_CODEMP').AsString;
      qryAdeGer.ParamByName('AUTOIN').AsString := fRetAutoIncrem('ADEDET', VS_strCodEmp);
      qryAdeGer.ParamByName('SEQGER').AsString := strSeqGer;

      if not fEmptyStr(cdsAdeDet.FieldByName('DET_NUMDOC').AsString) then
        qryAdeGer.ParamByName('NUMDOC').AsString := cdsAdeDet.FieldByName('DET_NUMDOC').AsString;

      if not fEmptyStr(cdsAdeDet.FieldByName('DET_ESPDOC').AsString) then
        qryAdeGer.ParamByName('ESPDOC').AsString := cdsAdeDet.FieldByName('DET_ESPDOC').AsString;

      if cdsAdeDet.FieldByName('DET_DTAMOV').AsDateTime > 0 Then
        qryAdeGer.ParamByName('DTAMOV').AsDateTime := cdsAdeDet.FieldByName('DET_DTAMOV').AsDateTime;

      if not fEmptyStr(cdsAdeDet.FieldByName('DET_FORCLI').AsString) then
        qryAdeGer.ParamByName('FORCLI').AsString := cdsAdeDet.FieldByName('DET_FORCLI').AsString;

      if not fEmptyStr(cdsAdeDet.FieldByName('DET_TIP_FC').AsString) then
        qryAdeGer.ParamByName('TIP_FC').AsString := cdsAdeDet.FieldByName('DET_TIP_FC').AsString;

      if not fEmptyStr(cdsAdeDet.FieldByName('DET_SERIE_').AsString) then
        qryAdeGer.ParamByName('SERIE_').AsString := cdsAdeDet.FieldByName('DET_SERIE_').AsString
      Else
        qryAdeGer.ParamByName('SERIE_').AsString := '';

      qryAdeGer.ParamByName('QTDORI').AsFloat  := cdsAdeDet.FieldByName('DET_QTDORI').AsFloat;
      qryAdeGer.ParamByName('GARANT').AsString := cdsAdeDet.FieldByName('DET_GARANT').AsString;
      qryAdeGer.ExecSQL;
      qryAdeGer.Close;

      cdsAdeDet.Next;
    end;

    //Grava Historico de ocorrencia.
    objOcoCrm := TAtuOcoCrm.Create(self);
    With objOcoCrm Do
    Begin
      strCodEmp := qryAD.FieldByName('GER_CODEMP').AsString;
      strCodOco := qryAD.FieldByName('GER_CODOCO').AsString;
      strCodToc := fCfgSis('VENDEV', varString);
      strCodOpe := strLoginUsuarioLogado;
      strDtaInc := VS_Date;
      strHorInc := fTime();
      strDtaAge := strDtaInc;
      strHorAge := strHorInc;
      strOpeHis := strLoginUsuarioLogado;
      strDescri := 'Baixa Parcial da AD: ' + qryAD.FieldByName('GER_CODADE').AsString + '<<csq>>' +
                   'Nova AD com produtos nao recebidos: ' + strNumDevP + '<<csq>>' +
                   'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                   DateToStr(fNow) + ' ' + TimeToStr(fNow) + ' - ' + strLoginUsuarioLogado + ' - ' + fRetNomeOperador(strLoginUsuarioLogado);
      strNomFrm := Self.Name;
      pInsereHistoricoOcorrencia;
      pAtualizaOcorrencia;
    End;
  Finally
    FreeAndNil(qryAdeGer);
  End;

End;

function TfrmGarantiaRecCliente.fQtdFornecedoresItem(strCodIte : String) : Integer;
  Var
    qryDados : TUniQuery;
Begin
  qryDados := fCriaQuery(Self);
  Try
    With qryDados, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT DISTINCT ITE_CODFOR    ');
      Add(' FROM (                        ');
      Add(' SELECT ITE_CODFOR FROM ITEFOR ');
      Add(' WHERE ITE_CODITE = :CODITE    ');
      Add(' UNION ALL                     ');
      Add(' SELECT ITE_CODFOR FROM CADITE ');
      Add(' WHERE ITE_CODITE = :CODITE ) A');

      ParamByName('CODITE').AsString := strCodIte;
      Open;

      Result := RecordCount;
      Close;

    End;
  Finally
    FreeAndNil(qryDados);
  End;

End;

Procedure TfrmGarantiaRecCliente.pCarregaNFEXML;
Begin
  edtCodCli.Text := recNotEle.strCodCli;
  If fValidaCampos(edtCodCli, False) Then
  Begin
    pnlProdutos.Enabled := False;
    edtCodCli.Enabled := False;
    SelectNext(ActiveControl, True, True);
  End;

End;


Procedure TfrmGarantiaRecCliente.pCarregaItensXML;
{$Region 'Tipos locais'}
  Type
    TItemXML = Record
      strCodIte: String;
      strDesIte: String;
      strRefere: String;
      strDesUni: String;
      strNumLote: String;
      fltQtdIte: Double;
      fltValIte: Double;
      fltDesAceD: Double;
    end;

  Type
    TResultadoImportacao = (Sucesso, DivergenciaQtdItemImportado, FaltaItem, Outro);
    TProcResultado = reference to procedure(pResultadoImportacao: TResultadoImportacao);

  {$Endregion}
  Var
    qryItens : TUniQuery;
    strCodFab: String;
    lItemXml: TItemXml;
    i: Integer;
    blnParar: Boolean;
    intQtdIteImp: Integer;
    enuResultadoImportacao: TResultadoImportacao;
    lSaidaForcada: TProcResultado;

Begin
   enuResultadoImportacao := Sucesso;
  {$Region 'Métodos locais'}
  lSaidaForcada := procedure(pResultadoImportacao: TResultadoImportacao)
                         Var
                          strMsg: String;
                        begin
                          case pResultadoImportacao of
                            DivergenciaQtdItemImportado: strMsg := 'É obrigatório receber todos os itens do XML!';

                            FaltaItem: strMsg := 'O total selecionado para item é diferente da quantidade do XML. '+slineBreak+
                                                  'É obrigatório selecionar a mesma quantidade a receber para o item no XML!'
                            else
                              strMsg := EmptyStr;
                          end;

                          if strMsg <> EmptyStr then
                            fMensagem('', strMsg, ['&Ok']);

                          pLimpaDados;
                          pSetFocus(mskDtaEnt);
                        end;
  {$Endregion}
  Try
    intQtdIteImp := 0;
    blnImportandoXML := True;

    cdsItens.AfterScroll := Nil;
    qryItens := fCriaQuery;
    qryItens.Close;

    qryItens.Sql.Clear;
    qryItens.Sql.Add(' SELECT DET_CODITE, SUM(I10_QCOM) AS I10_QCOM, SUM(I11_VPROD) AS I11_VPROD, SUM(I17A_VOUTRO) AS I17A_VOUTRO, SUM(I16_VSEG) AS I16_VSEG  ');
    qryItens.Sql.Add(' FROM DETELE                 ');
    qryItens.Sql.Add(' WHERE DET_SEQGER = :AUTINC  ');
    qryItens.Sql.Add(' GROUP BY DET_CODITE  ');

    qryItens.ParamByName('AUTINC').AsString := recNotEle.strAutInc;
    qryItens.Open;

    While Not qryItens.Eof Do
    Begin
      pSetSolicitarLiberacaoItemSemNotaVenda(False);
      lItemXml.strCodIte := qryItens.FieldByName('DET_CODITE').AsString;
      lItemXml.fltQtdIte := qryItens.FieldByName('I10_QCOM').AsFloat;
      lItemXml.fltValIte := qryItens.FieldByName('I11_VPROD').AsFloat;
      lItemXml.fltDesAceD := qryItens.FieldByName('I17A_VOUTRO').AsFloat + qryItens.FieldByName('I16_VSEG').AsFloat;
      lItemXml.strNumLote := EmptyStr;

      edtCodIte.Text := lItemXml.strCodIte;
      edtQtdIte.Text := FormatFloat(edtQtdIte.EditFormat, lItemXml.fltQtdIte);
      pAjustaLoteSaida;
      if edtNumLot.Visible then
      begin
        lItemXml.strNumLote := objCadLot.fRetArmazemPrincipalVenda(edtCodIte.Text);
        edtNumLot.Text := lItemXml.strNumLote;
      end;
      blnResEdtCodIteExit := True;

      edtCodIteExit(edtCodIte);

      lItemXml.strDesIte := edtDesIte.Text;
      lItemXml.strDesUni := edtDesUni.Text;
      lItemXml.strRefere := edtReferencia.Text;

      if (Not blnSolicitarLiberacaoItemSemNotaVenda) and fTemDocumentoVendaSelecionado then
      begin
        if Not fValidarQuantidadeSelecionada(lItemXml.fltQtdIte) then
        begin
          enuResultadoImportacao := FaltaItem;
          Exit;
        end;
      end;

      i := -1;
      Repeat

        If  blnSolicitarLiberacaoItemSemNotaVenda Then
        begin
          fltDispon := lItemXml.fltQtdIte;
          fltQtdIte := lItemXml.fltQtdIte;
          fltValIte := lItemXml.fltValIte;
          fltDesAceD:= lItemXml.fltDesAceD;
          fltDetUnitar := fltValIte;
          fltDetDesEsp := 0;
          fltDetDesCff := 0;
          strCodFab := fCampoTabela('ITE_CODFAB', 'CADITE', ['ITE_CODITE'], [fRetCodItem(edtCodIte.Text)]);
          pAddItemListaSemDocumento(lItemXml.strCodIte, lItemXml.strDesIte, edtDesUni.Text, strCodFab, lItemXml.fltQtdIte);
        end
        else if fTemDocumentoVendaSelecionado then
        begin
          if (i = -1) then
            i := Low(arrDocumentosVendas);

          edtQtdIte.Text := FormatFloat(edtQtdIte.Editformat, arrDocumentosVendas[i].fltQtdSel);
          fltDispon := arrDocumentosVendas[i].fltDispon;

          fltQtdIte := arrDocumentosVendas[i].fltQtdIte;
          fltValIte := arrDocumentosVendas[i].fltValIte;
          fltDesAceD:= arrDocumentosVendas[i].fltDesAceD;

          strSeqDoc := arrDocumentosVendas[i].strSeqDoc;
          strNumDoc := arrDocumentosVendas[i].strNumDoc;
          strEmpDoc := arrDocumentosVendas[i].strEmpDoc;
          strCodVenOri := arrDocumentosVendas[i].strCodVenOri;

          strDocFat := arrDocumentosVendas[i].strDocFat;
          strIncOri := arrDocumentosVendas[i].strIncOri;
          strTabela := arrDocumentosVendas[i].strTabela;
          fltDetUnitar := arrDocumentosVendas[1].fltDET_UNITAR;
          fltDetDesEsp := arrDocumentosVendas[1].fltDET_DESESP;
          fltDetDesCff := arrDocumentosVendas[1].fltDET_DESCFF;
          fltUNICRD := arrDocumentosVendas[0].fltUNICRD;
          fltUniCrdOri := fltUNICRD;
          edtUniCrd.Text := FormatFloat('#0.00',fltUNICRD);

          inc(i);
        end;

        If Not (blnResEdtCodIteExit And fValidaCampos(edtCodIte, True) And fValidaCampos(edtQtdIte, True)) Then
        begin
          enuResultadoImportacao := Outro;
          Exit;
        end;

        btnAdicionar.Click;

        blnParar := blnSolicitarLiberacaoItemSemNotaVenda or (i = -1);

        if Not blnParar then
          blnParar := (i > High(arrDocumentosVendas));

        if (Not blnParar) then
        begin
          edtCodIte.Text := lItemXml.strCodIte;
          edtDesIte.Text := lItemXml.strDesIte;
          edtDesUni.Text := lItemXml.strDesUni;
          edtNumLot.Text := lItemXml.strNumLote;
          edtReferencia.Text := lItemXml.strRefere;
          edtQtdIte.Text := FormatFloat(edtQtdIte.EditFormat, arrDocumentosVendas[i].fltQtdSel);
        end;
      Until blnParar;
      Inc(intQtdIteImp);
      qryItens.Next;
    End;


    If intQtdIteImp <> qryItens.RecordCount Then
      enuResultadoImportacao := DivergenciaQtdItemImportado;

  Finally
    if enuResultadoImportacao <> Sucesso then
      lSaidaForcada(enuResultadoImportacao);

    FreeAndNil(qryItens);
    cdsItens.AfterScroll := pHabilitaBotoes;
    btnConfirmar.Enabled  := (Not cdsItens.IsEmpty);
    blnImportandoXML := False;
    pInicializarArrDocumentosVendas;
  End;

End;

function TfrmGarantiaRecCliente.fRetPrecoTE(strCodIte : String) : Double;
  Var
    strCampo : String;
Begin
  strCampo := fCfgSis('TEPREV');

  If fEmptyStr(strCampo) Then
    strCampo := 'ITE_PRECUS'

  Else If strCampo = 'IMP' Then
    strCampo := 'ITE_IMPULT'

  Else If strCampo = 'SIC' Then
    strCampo := 'ITE_MEDSIC'

  Else
    strCampo := 'ITE_PRE' + strCampo;

  Result := fCampoTabela(strCampo, 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [strCodIte, VS_strCodEmp]);
End;

procedure TfrmGarantiaRecCliente.pMarcarReposicao(blnReposto : Boolean);
Begin
  Try
    cdsItens.DisableControls;
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      cdsItens.Edit;
      cdsItens.FieldByName('REPOST').AsString := IfThen(blnReposto, 'S', 'N');
      cdsItens.Post;
      cdsItens.Next;
    End;

  Finally
    chkReposicao.Checked := blnReposto;
    pExibirFavorecido;
    cdsItens.First;
    cdsItens.EnableControls;
  End;

End;

procedure TfrmGarantiaRecCliente.pRemoverItemListaSemDocumento(const strCodIte: String; fltQtdIte: double);
Var
  aItem : TItemSemDocumento;
  intIndex: Integer;
begin
  intIndex := fLocalizarItemListaSemDocumento(strCodIte);
  if intIndex <= -1 then
    Exit;
  aItem := FListaItensSemDocumento[intIndex];
  aItem.fltQtdIte := aItem.fltQtdIte - fltQtdIte;
  if aItem.fltQtdIte <= 0 then
  begin
    FListaItensSemDocumento.Remove(aItem);
  end;
end;

function TfrmGarantiaRecCliente.fVerificaLotes : Boolean;
Begin
  Try
    Result := True;
    cdsItens.DisableControls;
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      If objCadLot.fExisteLote(cdsItens.FieldByName('CODITE').AsString, VS_strCodEmp, '', False, False) And
         fEmptyStr(cdsItens.FieldByName('LOTSAI').AsString) Then
      Begin
        Result := False;
        fMensagem('','Para realizar a baixa do saldo reservado, é preciso informar os lotes dos produtos com defeito, revise os itens e informe os lotes!', ['&OK']);
        Exit;
      End;

      cdsItens.Next;
    End;

  Finally
    cdsItens.First;
    cdsItens.EnableControls;
  End;

End;

function TfrmGarantiaRecCliente.fVaiUtilizarAD : Boolean;
Begin
  Result := VS_strHabilitarCRM And blnUtiAd and (fCadEmp('CLIFIL') <> edtCodCli.text) and (not blnLiberouADComSenha);
End;


function TfrmGarantiaRecCliente.fEspeciePermitidaDevolucao(): Boolean;
  Var
    cdsDados: TUniClientDataSet;
begin
  if (cdsVenda.RecordCount = 0) then
    exit(False);

  cdsDados := TUniClientDataSet.Create(Self);
  try
    cdsDados.Data := cdsVenda.Data;
    cdsDados.LogChanges := False;

    cdsDados.Filter   := TNotaDevolucaoPessoaJuridica.fFiltroItensEspecieNaoValidaIES;
    cdsDados.Filtered := True;

    Result := (cdsDados.RecordCount <= 0);
  finally
    FreeAndNil(cdsDados);
  end;

end;


function TfrmGarantiaRecCliente.fValidaDevolucaoEmpresa() : Boolean;
var
  objNotaDevolucaoJuridica : TNotaDevolucaoPessoaJuridica;
begin
  Result := True;
  objNotaDevolucaoJuridica := TNotaDevolucaoPessoaJuridica.Create();
  objNotaDevolucaoJuridica.pEspecieItensPermiteDevolucao := fEspeciePermitidaDevolucao;
  objNotaDevolucaoJuridica.pPessoaJuridicaSemIES := fPessoaJuridicaSemIES;
  objNotaDevolucaoJuridica.pPessoaJuridicaComIES := fPessoaJuridicaComIES;
  objNotaDevolucaoJuridica.pVerificaAcesso := fVerificaAcessoSistema;

  try
    If objNotaDevolucaoJuridica.fVerificaSePermiteDevolucaoEmpresaComIES( edtCodCli.Text ) Then
    Begin

      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Não é permitido emitir devolução para pessoa jurídica com inscrição estadual cadastrada.');

      objLiberacao.strDirAce := TNotaDevolucaoPessoaJuridica.DIREITO_DEVOLUCAO_COM_IE;
      objLiberacao.strSenLib := fCfgSis( TNotaDevolucaoPessoaJuridica.CONFIGURACAO_DEVOLUCAO_COM_IE );
      objLiberacao.strMsgSen := 'Devolução Para Pessoa Jurídica';
      objLiberacao.strCodOpe := fatVenda.strCodVen;
      objLiberacao.strCodDig := fatVenda.strCodDig;
      objLiberacao.strCliente := edtCodCli.Text + '-' + edtNomCli.Text;
      objLiberacao.strCpfCnpj := fatVenda.strCliCgc;

      If Not fatVenda.fFatMensagemLiberacao(objLiberacao) Then
        Exit(False);

    End;


    If objNotaDevolucaoJuridica.fVerificaSePermiteDevolucaoEmpresaSemIES( edtCodCli.Text ) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Não é permitido emitir devolução para pessoa jurídica sem inscrição estadual cadastrada.');

      objLiberacao.strDirAce := TNotaDevolucaoPessoaJuridica.DIREITO_DEVOLUCAO_SEM_IE;
      objLiberacao.strSenLib := fCfgSis( TNotaDevolucaoPessoaJuridica.CONFIGURACAO_DEVOLUCAO_SEM_IE );
      objLiberacao.strMsgSen := 'Devolução Para Pessoa Jurídica';
      objLiberacao.strCodOpe := fatVenda.strCodVen;
      objLiberacao.strCodDig := fatVenda.strCodDig;
      objLiberacao.strCliente := edtCodCli.Text + '-' + edtNomCli.Text;
      objLiberacao.strCpfCnpj := fatVenda.strCliCgc;

      If Not fatVenda.fFatMensagemLiberacao(objLiberacao) Then
        Exit(False);
    End;
  finally
    FreeAndNil(objNotaDevolucaoJuridica)
  end;

end;


function TfrmGarantiaRecCliente.fSeDerFalhaMasGravouAEntrada(const pstrAutIncGAG: String; var pRecDocGarantia: TRecDocGarantia): Boolean;
var qryValida: TUniquery;
begin
  pRecDocGarantia.pDefinir('');
  Result := False;
  qryValida := fCriaQuery;
  Try
    qryValida.SQL.Add('SELECT D.DET_NUMDOC, ');
    qryValida.SQL.Add('       D.DET_CODEMP, ');
    qryValida.SQL.Add('       D.DET_TIP_FC, ');
    qryValida.SQL.Add('       IF(D.DET_TIP_FC = "C", D.DET_CODCLI, D.DET_CODFOR) AS DET_CLIFOR, ');
    qryValida.SQL.Add('       D.DET_CODCLI, ');
    qryValida.SQL.Add('       D.DET_ESPDOC, ');
    qryValida.SQL.Add('       D.DET_SERIE_, ');
    qryValida.SQL.Add('       D.DET_SEQGER  ');
    qryValida.SQL.Add(' FROM MOVGAD GA');
    qryValida.SQL.Add(' INNER JOIN MOVGRC R ON R.GRC_SEQGAD = GA.AUTOINCREM');
    qryValida.SQL.Add(' INNER JOIN MOVDET D ON D.AUTOINCREM = R.GRC_SEQDET');
    qryValida.SQL.Add(' WHERE GA.GAD_SEQGAG = :AUTINC ');
    qryValida.ParamByName('AUTINC').AsString := pstrAutIncGAG;
    qryValida.Open;

    if qryValida.IsEmpty then
      Exit
    else
    begin
      Result := True;
      qryValida.First;
      pRecDocGarantia.pDefinir(qryValida.FieldByName('DET_NUMDOC').AsString,
                               qryValida.FieldByName('DET_ESPDOC').AsString,
                               qryValida.FieldByName('DET_CODEMP').AsString,
                               qryValida.FieldByName('DET_CLIFOR').AsString,
                               qryValida.FieldByName('DET_SERIE_').AsString,
                               qryValida.FieldByName('DET_TIP_FC').AsString);
      pRecDocGarantia.strAutoincrem := qryValida.FieldByName('DET_SEQGER').AsString;
    End;
  Finally
    qryValida.Free;
  End;
End;

function TfrmGarantiaRecCliente.fValidarAoConfirmarRecebiemento: Boolean;
Var
  FQryTmp: TUniQuery;
begin
  Result := True;
  FQryTmp := fCriaQuery;
  Try
    If blnImportandoXML Then
    Begin
      Result := objMovGag.objMovGad.fCarregaDocVendas(FQryTmp, edtCodCli.Text, edtCodIte.Text, False, mskPlaVei.Text);

      If Not Result Then
        Result := blnPermitirLiberarSemNotaVenda;
    End;
  Finally
    FreeAndNil(FQryTmp);
  End;
end;

function TfrmGarantiaRecCliente.fValidarFavorecido: Boolean;
Var
  strFavorecido: String;
  strNomeFavorecido: String;
begin
  strFavorecido := EmptyStr;
  strFavorecido := edtFavorecido.Text;
  strNomeFavorecido:= edtNomeFavorecido.Text;
  Result := False;


  if fEmptyStr(strFavorecido) then
  begin
    Exit(Result);
  end;

  if strFavorecido = edtCodCli.Text then
  begin
    fMensagem('','O Favorecido deve ser diferente do Cliente.',['&Ok']);
    Exit(Result);
  end;

  if fClienteConsumidor(strNomeFavorecido, False) then
  begin
    fMensagem('','O cliente favorecido não pode ser um "consumidor genérico". Selecione outro cliente.',['&Ok']);
    Exit(Result);
  end;

  if fClienteFilial(strFavorecido) then
  begin
    fMensagem('','O cliente favorecido não pode ser um cliente filial. Selecione outro cliente.',['&Ok']);
    Exit(Result);
  end;
  Result := True;
end;

function TfrmGarantiaRecCliente.fValidarQuantidadeSelecionada(const fltQtdIte: Double): Boolean;
  Var
    i: Integer;
    fltAcumulado: Double;
    strAcum, strQtdIte: String;
begin
  fltAcumulado := 0;
  for i := low(arrDocumentosVendas) to High(arrDocumentosVendas) do
  begin
    fltAcumulado := fltAcumulado + arrDocumentosVendas[i].fltQtdSel;
  end;
  strAcum := FloatToStr(RoundTo(fltAcumulado, -6));
  strQtdIte := FloatToStr(RoundTo(fltQtdIte, -6));
  Result := strAcum = strQtdIte;
end;

function TfrmGarantiaRecCliente.fValidarVariacaoCredito(
  pfltUniCrd: Double; Out pstrMsgResult: String): Boolean;
  Var
    lVariacao: Double;
begin
  Result := pfltUniCrd >= 0;
  if Result then
  begin
    if (FfltVariacaoCredito > 0) then
    begin
      pstrMsgResult := EmptyStr;
      if fltUniCrdOri = 0 then
      begin
        pstrMsgResult := 'Foi definido limite de variação [CFG_VVCSDV] para alteração de crédito o item não tem custo definido para comparação!';
        Exit
      end;
      lVariacao := (abs((pfltUniCrd / fltUniCrdOri) -1)* 100);

      if lVariacao > FfltVariacaoCredito then
      begin
        Result := False;
        pstrMsgResult := Format('O novo valor de crédito excedeu o limite de variação [%s] sobre o custo atual [%s] .',
                                [FormatFloat('#0.00%', FfltVariacaoCredito),
                                 FormatFloat('R$ #0.00', fltUniCrdOri)]);
      end;
    end;
  end
  else
    pstrMsgResult := Format('O valor de crédito deve ser maior ou igual zero [R$ %s] ',
                            [FormatFloat('#0.00', fltUniCrd)]);
end;

procedure TfrmGarantiaRecCliente.pRecebeItemNaoLiberado(const strCodIte, strNumDoc, strSeqDoc: String);
begin
  Try
    cdsItens.DisableControls;
    if cdsItens.Locate('CODITE;NUMDOC;SEQDOC',VarArrayOf([strCodIte, strNumDoc, strSeqDoc]), []) then
    begin
      cdsItens.Delete;
    end;
  Finally
    cdsItens.EnableControls;
  End;
end;

procedure TfrmGarantiaRecCliente.pReceberDocumentoSelecionado(pstrTabela, pstrCodIte, strSeqDoc, strNumDoc, strEmpDoc, strCodVenOri, strDocFat,
  strIncOri, strDataVenda, strEspDocDet, strNumDocDet: String; const fltDispon, fltQtdIte, fltValIte, fltDesAceD,
  fltQtdSel, pfltUniCRD, pfltDET_UNITAR, pfltDET_DESESP, pfltDET_DESCFF: Double);

  Var
    i: Integer;
begin
  i := fAdicionarNovoDocumentoVenda;
  arrDocumentosVendas[i].create(pstrCodIte);
  arrDocumentosVendas[i].strSeqDoc := strSeqDoc;
  arrDocumentosVendas[i].strNumDoc := strNumDoc;
  arrDocumentosVendas[i].strEmpDoc := strEmpDoc;
  arrDocumentosVendas[i].strCodVenOri := strCodVenOri;
  arrDocumentosVendas[i].Det_EspDoc := strEspDocDet;
  arrDocumentosVendas[i].Det_NumDoc := strNumDocDet;
  arrDocumentosVendas[i].strDataVenda := strDataVenda;
  arrDocumentosVendas[i].strDocFat := strDocFat;
  arrDocumentosVendas[i].strIncOri := strIncOri;
  arrDocumentosVendas[i].strTabela := pstrTabela;
  arrDocumentosVendas[i].fltDispon := fltDispon;
  arrDocumentosVendas[i].fltQtdIte := fltQtdIte;
  arrDocumentosVendas[i].fltValIte := fltValIte;
  arrDocumentosVendas[i].fltDesAceD := fltDesAceD;
  arrDocumentosVendas[i].fltQtdSel := fltQtdSel;
  arrDocumentosVendas[i].fltUniCrd := pfltUniCRD;
  arrDocumentosVendas[i].fltDET_UNITAR := pfltDET_UNITAR;
  arrDocumentosVendas[i].fltDET_DESESP := pfltDET_DESESP;
  arrDocumentosVendas[i].fltDET_DESCFF := pfltDET_DESCFF;
end;

function TfrmGarantiaRecCliente.fClienteValidoParaCreditoOuNotaFiscal(const strCodCli: String; strNomCli: String = ''; blnFaturamentoEmiteNF: Boolean = False): Boolean;
Var
  blnClienteFilial,
  blnClienteConsumidor,
  blnLiberacaoCreditoFuturo,
  blnGerarCreditoAnt: Boolean;
  blnPermiteClienteFilial: boolean;
begin
  Result := True;
  if (Not blnInfCli) then
    Exit;

  //gerar crédito no faturamento não pode indicar cliente filial
  blnClienteFilial := fClienteFilial(strCodCli);

  if Not blnClienteFilial then
  begin
    if fEmptyStr(strNomCli) then
      blnClienteConsumidor := fClienteConsumidor(fRetNomCliente(strCodCli))
    else
      blnClienteConsumidor := fClienteConsumidor(strNomCli);
  end
  else
    blnClienteConsumidor := False;

  blnGerarCreditoAnt := (chkCredito.Visible and chkCredito.Checked ) and (chkReposicao.Checked = False);
  blnLiberacaoCreditoFuturo := (blnGeraCreditoNoRecebimento = False) and (chkReposicao.Checked = False);

  if blnGeraCreditoNoRecebimento then
    blnPermiteClienteFilial := (blnGerarCreditoAnt = False) and (Not blnCFG_RCFECF)
  else
    blnPermiteClienteFilial := (blnLiberacaoCreditoFuturo = False) and (Not blnCFG_RCFECF);

  if  blnGerarCreditoAnt and (blnFaturamentoEmiteNF = False) then
  begin
    Result := Not (blnClienteFilial or blnClienteConsumidor);
  end
  else
  begin
    If blnFaturamentoEmiteNF  then
    begin
      if blnClienteFilial then
        Result := blnPermiteClienteFilial
      else
        Result := (not blnClienteConsumidor) or (blnClienteConsumidor and (Not fEmptyStr(objMovGag.strNomCon)));
    end
    else begin
      if blnGerarCreditoAnt then
        Result := (Not ((blnPermiteClienteFilial = False) and blnClienteFilial)) and (blnClienteConsumidor = False)
      else if blnClienteFilial then
        Result := blnPermiteClienteFilial
      else
        Result := (not blnClienteConsumidor) or (blnClienteConsumidor and (Not fEmptyStr(objMovGag.strNomCon)));
    end;
  end;
end;

procedure TfrmGarantiaRecCliente.pCarregarCFGs;
begin
  FblnEspDev := (fCfgSis('ESPDEV', varString) = 'S') And (fCfgSis('ESPDNW', varString) = 'S') ;
  FCarregarFreteImportarXML := fCfgSis('RCXMLF', varString) = 'S';
  FblnBaixaEstrutura  := fCfgSis('BXSBIT', varString) = '2';
  FblnCarrergarEstrutura := Not (fCfgSis('CAREST', varString) = 'N');
  blnInformarEntregaRetiraGC  := fCfgSis('GGCDEF', varString) = 'S';
  blnCFG_RCFECF               := fCfgSis('RCFECF', varString) = 'S';
  blnCFG_GARIND               := fCfgSis('GARIND', varString) = 'S';
  blnRefEnt                   := fCfgSis('REFENT', varBoolean, fCfgSis('EMPGAR', varString) );
  blnLerCodigoBarras          := fCfgSis('BARGAR', varBoolean);
  blnGarSep                   := fCfgSis('GARSEP', varBoolean);
  blnGeraCreditoNoRecebimento := (fCfgSis('CREGAR', varString) = '1');
  strPortad := fCfgSis('PORGAR', varString);
  blnPermitirLiberarSemNotaVenda := fCfgSis('LRGCSA', varString) = 'S';
  blnHabilitarOpcaoReposicao  := fCfgSis('HORORC', varString) = 'S';
  blnInfCli := fCfgSis('INFCLI') = 'S';
  blnUtiAd := fCfgSis('UTI_AD', varBoolean);
  intQtdCasasDecimaisValorUnitario := fCfgSis('DECUNI',varInteger);
  blnUtilizaChecklistGarantia := TCheckListGarantiaController.fUtilizaCadastroCheckListGarantia;

  FHabilitarLimiteCredito := blnPermitirLiberarSemNotaVenda and (fCfgSis('HDCISD', varString) = 'S');
  FHabilitarDigitarValorCredito := FHabilitarLimiteCredito and (fCfgSis('HLVCSD', varString) = 'S');
  if FHabilitarDigitarValorCredito then
    FfltVariacaoCredito := fCfgSis('VVCSDV', varDouble)
  else
    FfltVariacaoCredito := 0;


end;


procedure TfrmGarantiaRecCliente.pConfigurarUtilizaCheckList;
  Var
    i: Integer;
begin
  btnAssistenciaTecnica.Enabled := blnUtilizaChecklistGarantia;
  btnAssistenciaTecnica.Visible := btnAssistenciaTecnica.Enabled;
  for i := 0 to dbgItens.Columns.Count -1 do
  begin
    if dbgItens.Columns.Items[i].FieldName = cdsItensITE_CODATC.FieldName then
    begin
      dbgItens.Columns.Items[i].Visible := blnUtilizaChecklistGarantia;
      Exit;
    end
  end;
end;

procedure TfrmGarantiaRecCliente.pMensagemNaoPermitirItemFornecedorTipoGarantia;
Var
  strMsg: String;
begin
  case Self.FenuTipoGarantia of
    TTipoGarantia.IndustriaProprio:
    begin
      strMsg := '"Garantia Própria Empresa" - Só são permitidos itens da própria empresa.' ;
    end;
    TTipoGarantia.IndustriaRevenda:
    begin
      strMsg := 'Não são são permitidos itens "Garantia é Própria Empresa".' ;
    end;
  end;
  fMensagem('',strMsg,['&OK']);
end;


procedure TfrmGarantiaRecCliente.pSelecionarDocumentoItem;
  Var
    strCodAde: String;
    RespSelecaoDocumento: TRespSelecaoDocumento;
    blnSemDocumento: Boolean;
begin
  if fVaiUtilizarAD and (Assigned(qryAD) and (qryAD.IsEmpty)) then
    strCodAde := qryAD.FieldByName('GER_CODADE').AsString
  else
    strCodAde := EmptyStr;

  blnSemDocumento := fEmptyStr(cdsItensNUMDOC.AsString);

  RespSelecaoDocumento := fSelecionarDocumentoVenda(strCodAde, edtCodCli.Text, edtNomCli.Text, cdsItensCODITE.AsString,
    cdsItensDESITE.AsString, cdsItensDESUNI.AsString, mskPlaVei.Text);

  if (RespSelecaoDocumento =  TRespSelecaoDocumento.Selecionado) then
    IF (cdsItensQTDITE.AsFloat > arrDocumentosVendas[0].fltDispon) then
    begin
      fMensagem('', 'A quantidade informada para devolução é maior que a disponivel no documento selecionado!' + #13 +
                    'Disponível: ' + FloatToStrF(fltDispon, ffFixed, 12, 2), ['&Ok']);
    end
    else begin
      cdsItens.Edit;
      cdsItensNUMDOC.AsString := arrDocumentosVendas[0].strNumDoc;
      cdsItensEMPDOC.AsString := arrDocumentosVendas[0].strEmpDoc;
      cdsItens.Post;
    end;

  case RespSelecaoDocumento of
    TRespSelecaoDocumento.Selecionado: pRemoverItemListaSemDocumento(cdsItensCODITE.AsString, cdsItensQTDITE.AsFloat);
  else
    begin
      if (blnSemDocumento = False) then
      begin
        pAddItemListaSemDocumento(cdsItens.FieldByName('CODITE').AsString,
                                  cdsItens.FieldByName('DESITE').AsString,
                                  cdsItens.FieldByName('DESUNI').AsString,
                                  cdsItens.FieldByName('CODFAB').AsString,
                                  cdsItens.FieldByName('QTDITE').AsFloat);
      end;
    end;
  end;

end;

procedure TfrmGarantiaRecCliente.pSetSolicitarLiberacaoItemSemNotaVenda(
  blnValue: Boolean);
begin
  blnSolicitarLiberacaoItemSemNotaVenda := blnValue;
end;

procedure TfrmGarantiaRecCliente.pSetTipoGarantia(Value: TTipoGarantia);
begin
  FenuTipoGarantia := Value;
  lblIndGarantiaPropriaEmpresa.Visible := FenuTipoGarantia.fEhGarantiaIndustria;
end;



procedure TfrmGarantiaRecCliente.pSetValorUniCrd(pfltUniCrd: Double);
begin
  fltUniCrdOri := pfltUniCrd;
  fltUniCrd := fltUniCrdOri;
  pSetValorUniCrd(fltUniCrdOri, fltUniCrd);
end;

procedure TfrmGarantiaRecCliente.pSetValorUniCrd(pfltUniCrdOri,
  pfltUniCrd: Double);
begin
  fltUniCrdOri := pfltUniCrdOri;
  fltUniCrd := pfltUniCrd;
  edtUniCrd.Text := FormatFloat('#0.00',pfltUniCrd);
end;


function TfrmGarantiaRecCliente.fObterTipoGarantia(const strCodFor, strForFil: String): TTipoGarantia;
begin
  if blnCFG_GARIND then
  begin
    if strCodFor = strForFil then
      Result := TTipoGarantia.IndustriaProprio
    else
      Result := TTipoGarantia.IndustriaRevenda;
  end
  else begin
    Result := TTipoGarantia.Padrao;
  end;
end;

function TfrmGarantiaRecCliente.fObterVendedorOperacao: String;

begin
  Result := EmptyStr;

  cdsItens.First;
  While (Not cdsItens.Eof) and fEmptyStr(Result)  do
  begin
    Result := cdsItensCodVen.AsString;
    cdsItens.Next;
  end;

  if fEmptyStr(Result) then
  begin
    if Not fEmptyStr(strCodVen) = False then
      Result := strCodVen
    else
      Result := strLoginUsuarioLogado;
  end;
end;

{ TTipoGarantiaHelper }

function TTipoGarantiaHelper.fEhGarantiaIndustria: Boolean;
begin
  Result := Self = TTipoGarantia.IndustriaProprio;
end;

function TTipoGarantiaHelper.fEhGarantiaIndustriaBoolAsString: String;
CONST
  SIM: String = 'S';
  NAO: String = 'N';
begin
  if Self.fEhGarantiaIndustria then
    Result := SIM
  else
    Result := NAO;
end;

function TfrmGarantiaRecCliente.fLiberarInserirItemSemDocumentoVenda: Boolean;
Const
  TITULO: Boolean = True;
  LARGURA_LINHA: Integer = 136;
Var
  intIndex: Integer;
begin
  if (FListaItensSemDocumento.Count = 0) then
    Exit(True)
  else
  begin
    if (Not blnPermitirLiberarSemNotaVenda )then
    begin
      pMensagemOk('Não é permitido inserir item sem informar o documento de venda!');
      Exit(False);
    end;
  end;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('LIBERACAO DE RECEBIMENTO DE GARANTIA DO CLIENTE DO SISTEMA ANTERIOR OU SEM DOCUMENTO DE VENDA');
  objLiberacao.objMsgLibera.pAddTexto(Format('Cliente: %s - %s',[edtCodCli.Text, edtNomCli.Text]));
  objLiberacao.objMsgLibera.pAddTexto(Format('Vendedor: %s - %s',[ strCodVen, edtNomVen.Text]));

  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddSeparador(LARGURA_LINHA);
  objLiberacao.objMsgLibera.pAddTexto(fCriarLinhaMsgLiberacaoItemSemDocumentoVenda(TITULO));
  objLiberacao.objMsgLibera.pAddSeparador(LARGURA_LINHA);
  for intIndex := 0 to FListaItensSemDocumento.Count -1 do
  begin
    objLiberacao.objMsgLibera.pAddTexto(fCriarLinhaMsgLiberacaoItemSemDocumentoVenda(FListaItensSemDocumento[intIndex]));
  end;
  objLiberacao.objMsgLibera.pAddSeparador(LARGURA_LINHA);
  objLiberacao.strDirAce := 'GASEVE';
  objLiberacao.strMsgSen := 'Senha para liberação de recebimento de garantia de cliente de sistema anterior ou sem documento de venda';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strCodVen;
  Result := objLiberacao.fLibera;
end;

function TfrmGarantiaRecCliente.fLiberarRecebimentoClienteFilial(
  const blnProdutoComDefeito: Boolean): Boolean;

  resourcestring
    RSMsgSenhaLiberacaoComDefeito = 'Senha para liberação de recebimento de garantia de cliente filial p/ produto com problema/defeito';
    RSMsgSenhaLiberacaoSemDefeito = 'Senha para liberação de recebimento de garantia de cliente filial p/ produto sem problema/defeito';
    RSMsgLiberarComDefeito = 'e aumentará o estoque ruim, diminuindo o estoque disponível.';
    RSMsgLiberarSemDefeito = 'e será somada ao estoque físico e estoque ruim, mantendo o estoque disponível igual.';
    RSMsg = 'Ação: Recebimento de cliente para a propria empresa cliente filial, informando que uma peça foi %0:s ';

  Const
    DIREITOACESSO_PRODUTO_COM_DEFEITO: String = 'GCFPDS';
    DIREITOACESSO_PRODUTO_SEM_DEFEITO: String = 'GCFPDN';

begin

 //ATENÇÃO
 //não tem relação com processo de garantia própria empresa. É garantia cliente filial e a mensagem foi colocada conforme solicitado no altera
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('GARANTIA - RECEBIMENTO DE CLIENTE PARA PRÓPRIA EMPRESA');
  objLiberacao.objMsgLibera.pAddTexto(Format('Data de Entrada: %s',[mskDtaEnt.Text]));
  objLiberacao.objMsgLibera.pAddTexto(Format('Cliente filial : %s - %s',[edtCodCli.Text, edtNomCli.Text]));
  objLiberacao.objMsgLibera.pAddTexto(Format('Usuário logado : %s-%s',[ strLoginUsuarioLogado, strDescriUsuarioLogado]));
  objLiberacao.objMsgLibera.pAddQuebra;

  if blnProdutoComDefeito then
  begin
    objLiberacao.objMsgLibera.pAddTexto(Format(RSMsg,['danificada']));
    objLiberacao.objMsgLibera.pAddTexto(RSMsgLiberarComDefeito);
    objLiberacao.strDirAce := DIREITOACESSO_PRODUTO_COM_DEFEITO;
    objLiberacao.strMsgSen := RSMsgSenhaLiberacaoComDefeito;
  end
  else begin
    objLiberacao.objMsgLibera.pAddTexto(Format(RSMsg,['encontrada']));
    objLiberacao.objMsgLibera.pAddTexto(RSMsgLiberarSemDefeito);
    objLiberacao.strDirAce := DIREITOACESSO_PRODUTO_SEM_DEFEITO;
    objLiberacao.strMsgSen := RSMsgSenhaLiberacaoSemDefeito;
  end;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strCodVen;
  Result := objLiberacao.fLibera;
end;

function TfrmGarantiaRecCliente.fCriarLinhaMsgLiberacaoItemSemDocumentoVenda(blnTitulo: Boolean; strCodIte, strDesIte, strUnidade,
  strQtdIte: String; strCodFab: String): String;
Const
  LINHA_MSG: String = '| %0:s | %1:s | %2:s | %3:s | %4:s |';
  LARGURA_PRODUTO : Integer = 7;
  LARGURA_DESCRICAO: Integer = 43;
  LARGURA_UNIDADE: Integer = 10;
  LARGURA_QUANTIDADE: Integer =  10;
  LARGURA_COD_FABRICA: Integer = 50;
Var
  lstrCodIte: String;
  lstrDesIte: String;
  lstrUnidade: String;
  lstrQtdIte: String;
  lstrCodFab: String;
begin
{$Region 'Exemplo'}
  (*
--------------------------------------------------------------------------------------------------------------------------------------
| Produto | Descrição                                  | unidade    | Quantidade |                                                   |
--------------------------------------------------------------------------------------------------------------------------------------
| xxxxx   | xxxxxxxxxx                                 |   xx       |      99.99 |                                                   |
--------------------------------------------------------------------------------------------------------------------------------------
  *)
{$Endregion}
  if blnTitulo then
  begin
    lstrCodIte  := leftstr(fPadR('Produto',   LARGURA_PRODUTO), LARGURA_PRODUTO);
    lstrDesIte  := leftstr(fPadR('Descrição',   LARGURA_DESCRICAO), LARGURA_DESCRICAO);
    lstrUnidade := leftstr(fPadR('Unidade',  LARGURA_UNIDADE), LARGURA_UNIDADE);
    lstrQtdIte  := Rightstr(fPadL('Quantidade',LARGURA_QUANTIDADE),LARGURA_QUANTIDADE);
    lstrCodFab  := leftstr(fPadR('Código Fábrica',  LARGURA_COD_FABRICA), LARGURA_COD_FABRICA);
  end
  else begin
    lstrCodIte  := leftstr(fPadR(strCodIte,   LARGURA_PRODUTO), LARGURA_PRODUTO);
    lstrDesIte  := leftstr(fPadR(strDesIte,   LARGURA_DESCRICAO), LARGURA_DESCRICAO);
    lstrUnidade := leftstr(fPadR(strUnidade,  LARGURA_UNIDADE), LARGURA_UNIDADE);
    lstrQtdIte  := Rightstr(fPadL(strQtdIte,LARGURA_QUANTIDADE),LARGURA_QUANTIDADE);
    lstrCodFab  := leftstr(fPadR(strCodFab,   LARGURA_COD_FABRICA), LARGURA_COD_FABRICA);
  end;
  Result := format(LINHA_MSG,[lstrCodIte, lstrDesIte, lstrUnidade, lstrQtdIte, lstrCodFab]);
end;

function TfrmGarantiaRecCliente.fCriarLinhaMsgLiberacaoItemSemDocumentoVenda(const aItem: TItemSemDocumento): String;
const
  MASCARA_QTD : String = '#0';
var
  strQtdIte: String;
begin
  strQtdIte := FormatFloat(MASCARA_QTD,aItem.fltQtdIte);
  Result := fCriarLinhaMsgLiberacaoItemSemDocumentoVenda(False, aItem.strCodIte, aItem.strDesIte, aItem.strUnidade, strQtdIte, aItem.strCodFab);
end;

function TfrmGarantiaRecCliente.fPermitirItemSemDocumentoVenda: Boolean;
begin
  Result :=  blnPermitirLiberarSemNotaVenda and (blnSolicitarLiberacaoItemSemNotaVenda or (Not blnImportandoXML))
end;

function TfrmGarantiaRecCliente.fLocalizarItemListaSemDocumento(const strCodIte: string): Integer;
Var
  intCont: Integer;
begin
  Result := -1;
  if FListaItensSemDocumento.count = 0 then
    Exit(Result);

  for intCont := 0 to FListaItensSemDocumento.count -1 do
  begin
    if FListaItensSemDocumento[intCont].strCodIte = strCodIte then
      Result := intCont;
  end;

end;

class function TfrmGarantiaRecCliente.fGravaCreditoClienteExec(pRecParGravaCADREC: TRecParGravaCADREC; Out pstrAutInc: String): Boolean;
  Var
    lQry : TUniQuery;
    strParcel   : String;
Begin
  lQry := fCriaQuery(Nil);
  Try
    lQry.Close;
    lQry.Sql.Clear;
    lQry.Sql.Add(' SELECT SQL_NO_CACHE              ');
    lQry.Sql.Add('        MAX(CTR_PARCEL) AS PARCEL ');
    lQry.Sql.Add(' FROM CADREC                      ');
    lQry.Sql.Add(' WHERE CTR_NUMDUP = :NUMDUP       ');
    lQry.Sql.Add('   AND CTR_SEQBAI = :SEQBAI       ');
    lQry.Sql.Add('   AND CTR_ESPDOC = :ESPDOC       ');
    lQry.Sql.Add('   AND CTR_CODCLI = :CODCLI       ');
    lQry.Sql.Add('   AND CTR_CODEMP = :CODEMP       ');

    lQry.ParamByName('NUMDUP').AsString := pRecParGravaCADREC.strNumDup;
    lQry.ParamByName('SEQBAI').AsString := '0';
    lQry.ParamByName('ESPDOC').AsString := pRecParGravaCADREC.strEspecie;
    lQry.ParamByName('CODCLI').AsString := pRecParGravaCADREC.strCodCli;
    lQry.ParamByName('CODEMP').AsString := VS_strCodEmp;

    lQry.Open;

    If lQry.IsEmpty or fEmptystr(lQry.FieldByName('PARCEL').AsString) Then
      strParcel := 'A'
    Else
      strParcel := Chr(Ord(lQry.FieldByName('PARCEL').AsString[1]) + 1);
  Finally
    FreeAndNil(lQry);
  End;

  Result := fGravaCadRec(pstrAutInc,
                         pRecParGravaCADREC.strNomFrmLogCtr,
                         'INCLUSÃO',
                         pRecParGravaCADREC.strNumDup,  // Duplicata
                         strParcel,                           // Parcela
                         0,                             // Sequencial de Baixa
                         pRecParGravaCADREC.strEspecie, //Espécie
                         pRecParGravaCADREC.strCodCli,  // Cliente
                         VS_strCodEmp,                  // Empresa
                         pRecParGravaCADREC.strCodVen,  // Vendedor
                         pRecParGravaCADREC.strCodDig,  // Digitador
                         pRecParGravaCADREC.strCodPor,  // Portador
                         pRecParGravaCADREC.pdtaDtaCad, // Data de Cadastro
                         pRecParGravaCADREC.pdtaDtaCad, // Data de Vencimento
                         pRecParGravaCADREC.fltValDup,  // Valor da Duplicata
                         pRecParGravaCADREC.fltValDup,  // Valor Original
                         0.0,                           // Despesa de Cobrança
                         'N',                           // Desconto
                         pRecParGravaCADREC.Historico1, // Histórico 1
                         pRecParGravaCADREC.Historico2, // Histórico 2
                         '',                            // Portador da Baixa
                         '',                            // Centro de Custo da Baixa
                         '',                            // Operador da Baixa
                         '',                            // Documento da Baixa
                         0.0,                           // Valor do Recebimento
                         0,                             // Data do Recebimento
                         'N',
                         '',                            // Código do Evento
                         '',                            // Código Velho (CONVERSÃO)
                         '',                            // Tipo de Fora (Condição de Pagamento)
                         '',                            // Código da Condição de Pagamento
                         False,
                         '',                            // Codigo do Centro de Custo
                         0,                             // Sequencial de Controle
                         0,
                         '',                            // Observação de Agrupamento 1
                         '',                            // Observação de Agrupamento 2
                         '',                            // Observação de Agrupamento 3
                         '',    //   strCtaSer
                         0,     //   fltValSer
                         0,     //   intResCai
                         0,     //   fltVlrCom
                         0,     //   fltFatCom
                         '',    //   strEmpBai
                         '',    //   strEmp_PD
                         '',    //   strDocDiv
                         '',    //   strEspDiv
                         '',    //   strEmpDiv
                         '',    //   strCliDiv
                         0,     //   fltVlrRep
                         0,     //   fltFatRep
                         '',    //   strCodRep
                         0,     //   fltValIPI
                         0,     //   fltValRet
                         'N',   //   strOriF11
                         0,     //   fltDesSuj
                         0,     //   fltJurSuj
                         0,     //   fltValCqP
                         0,     //   fltValCqV
                         0,     //   fltValDin
                         0,     //   fltValCar
                         0,     //   fltValOrd
                         0,     //   fltValFin
                         '',    //   strBarCon
                         0,     //   fltPerDPo
                         0,     //  intQtdDAV
                         0,     //   fltVrTrDv
                         '',    //   strHisBai
                         0,     //   fltValAce
                         0,     //   fltValFre
                         0,     //   fltDifOri
                         0,     //   fltValAnt
                         0,     //   fltComDiv
                         0,     //   fltFatDiv
                         '',    //   strCodDiv
                         0,     //   fltValFCP
                         'INCLUSÃO', //     strStatusDEPS:
                         '',  //    strOpcDoc:
                         '',  //     strAutincMovGerFC:
                         pRecParGravaCADREC.strIncGer); //   strINCDOC:
end;

{ TLiberacaoVariacaoCredito }

class function TLiberacaoVariacaoCredito.fLiberar(pstrCodCli,
  pstrNomCli, pstrCodOpe, pstrDigOpe: String; pfltValorCredito: Double): Boolean;
  Var
    lstrMsg: String;
    objLiberacao: TLiberacao;
begin
  Result := pfltValorCredito = 0;
  if Result then
    exit;

  objLiberacao := Nil;
  Try
    lstrMsg := Format('Valor total do crédito R$ %s', [FormatFloat('#0.00', pfltValorCredito)]);
    objLiberacao := TLiberacao.Create;
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Liberação de alteração do valor de crédito para garantia de venda do sistema anterior e/ou sem documento de venda.');
    objLiberacao.objMsgLibera.pAddTexto(lstrMsg);
    objLiberacao.strDirAce := DIREITO_ACESSO_LIBERACAO_CREDITO_SEM_DOCUMENTO;
    objLiberacao.strMsgSen := 'Senha para liberação de alteração de crédito de venda do sistema anterior e/ou sem documento de venda.';
    objLiberacao.strCodOpe := pstrCodOpe;
    objLiberacao.strCodDig := pstrDigOpe;
    objLiberacao.strCliente := pstrCodCli + '-' + pstrNomCli;
    objLiberacao.strCpfCnpj := fRetCgcCpf(pstrNomCli);
    Result := objLiberacao.fLibera;
  Finally
    if Assigned(objLiberacao) then
      FreeAndNil(objLiberacao);
  End;
end;

{ TRecDocumentoVenda }

constructor TRecDocumentoVenda.Create(pStrCodIte: String);
begin
  Self.pInicializar;
  Self.strCodIte := pStrCodite
end;


procedure TRecDocumentoVenda.pInicializar;
begin
  strSeqDoc := EmptyStr;
  strNumDoc := EmptyStr;
  strEmpDoc := EmptyStr;
  strCodVenOri := EmptyStr;
  fltDispon := 0;
  fltQtdIte := 0;
  fltValIte := 0;
  fltDesAceD := 0;
  strDocFat := EmptyStr;
  strTabela := 'MOVGER';
  strIncOri := EmptyStr;
  strDataVenda := EmptyStr;
  Det_EspDoc := EmptyStr;
  Det_NumDoc := EmptyStr;
  fltQtdSel := 0;
  fltUniCrd := 0;
  fltDET_UNITAR := 0;
  fltDET_DESESP := 0;
  fltDET_DESCFF := 0;
end;

procedure TfrmGarantiaRecCliente.pDefinirPessoasOperacao;
begin
  recPessoasOperacao.recVendedor.strCodigo := fObterVendedorOperacao;
  recPessoasOperacao.recVendedor.strNome   := fRetNomVendRep(recPessoasOperacao.recVendedor.strCodigo);

  recPessoasOperacao.recDigitador.strCodigo := strCodVen;
  recPessoasOperacao.recDigitador.strNome := edtNomVen.Text;
end;

function TfrmGarantiaRecCliente.fGerarOrdProItensEstrutura(var item: TDadosFechamento): Boolean;
  Var
    objOrdPro: TOrdPro;
begin
 
  Result := True;
  objOrdPro := TOrdPro.Create(Nil, True);
  Try
    Try
      objOrdPro.pSetRecItemDadosFechamento(item);
 
      objOrdPro.strClaFis := '1999';
      objOrdPro.dtaDtaEnt := StrToDate(mskDtaEnt.Text);

      objOrdPro.blnTransacao := False;
      item.blnGerOrd := False;

      {CASO NAO TENHA GERADO A ORDEM DE PRODUCAO - CRIA UMA NOVA, SENAO SOMENTE BAIXA}

      {ATRIBUI AS VARIAVEIS}
      objOrdPro.strNumDoc := FRecDocReposicao.strNumDoc;
      objOrdPro.strEspDoc := FRecDocReposicao.strEspDoc;
      objOrdPro.strCodEmp := VS_strCodEmp;
      objOrdPro.strCodCli := FRecDocReposicao.strCodCli;
      objOrdPro.strEndEnt := '';
      objOrdPro.strCodIte := item.strCodIte;
      objOrdPro.strQtdApr := FloatToStrF(item.fltQtdIte, ffFixed, 12, 4);
      objOrdPro.strQtdPro := '0.0';
      objOrdPro.strConfer := fRetNomVendedor(strLoginUsuarioLogado);
      objOrdPro.strDtaPro := mskDtaEnt.Text;
      objOrdPro.strDtaCad := mskDtaEnt.Text;

      objOrdPro.strObs001 := 'GERADO PELO GARANTIA - ' + FRecDocReposicao.strNumDoc;
      objOrdPro.strObs002 := 'DOCUMENTO: ' + FRecDocReposicao.strNumDoc + '-' + FRecDocReposicao.strEspDoc;

      {GERA A ORDEM DE PRODUCAO}
      Result := objOrdPro.fInsereOrdemProducao;

      If Result Then
      Begin
        {ATRIBUI O NUMERO DA ORDEM DE PRODUCAO A MATRIZ DE ITENS PARA GRAVACAO NO MOVDET/X}
        item.strOrdPro := objOrdPro.strCodPro;
        item.blnGerOrd := True;
      End;

      If Result Then
      Begin
        Result := objOrdPro.fCarregaOrdPro(item.strOrdPro);
        if Result then
        begin
          Result := objOrdPro.fBaixaOrdPro(fFormataFloat(item.fltQtdIte, 4), objOrdPro.strConfer, True);

          if not Result then
            raise Exception.Create('Não foi possível baixar a ordem de produção ' + item.strOrdPro);
        end
        else
          raise Exception.Create('Não foi possível encontrar a ordem de produção ' + item.strOrdPro);
      End;

    Except
      On E: EBaixaOrdemProducao Do
        Raise EBaixaOrdemProducao.Create(E.Message);
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TFatVendaBase.fGerarOrdProItensEstrutura]');
      End;
    End;
  Finally
  {DESTROI A CLASSE ORDEM DE PRODUCAO}
    FreeAndNil(objOrdPro);
  End

end;

{ TRecParGravaCADREC }

constructor TRecParGravaCADREC.Create(pstrNumDup: String);
begin
  Self.pInicializar;
  strNumDup := pstrNumDup;
end;

procedure TRecParGravaCADREC.pInicializar;
begin
  strCodCli := EmptyStr;
  strNomFrmLogCtr := EmptyStr;
  strNumDup  := EmptyStr;
  strEspecie := EmptyStr;
  strCodVen  := EmptyStr;
  strCodDig  := EmptyStr;
  strCodPor  := EmptyStr;
  Historico1 := EmptyStr;
  Historico2 := EmptyStr;
  strIncGer  := EmptyStr;
  pdtaDtaCad := 0;
  fltValDup  := 0;
end;

{ TCheckBox }

procedure TCheckBox.Click;
Var
  lChecked: Boolean;
begin
  lChecked := Self.Checked;
  if Assigned(FAntesMarcar) then
    FAntesMarcar(Self, lChecked);
  inherited;
end;

procedure TCheckBox.SetChecked(Value: Boolean);
begin
  if Assigned(FAntesMarcar) then
    FAntesMarcar(Self, Value);

  inherited SetChecked(Value);
end;

{ TModoGarantia }

function TModoGarantia.fSelecionado: TOperacaoGarantia;
Var
  lOperacao: TOperacaoGarantia;
begin
  Result := TOperacaoGarantia.ogNaoDefinido;
  for lOperacao in [TOperacaoGarantia.ogReposicao..TOperacaoGarantia.ogCredito] do
  begin
    if FArrCheckBox[ord(lOperacao)].Checked then
    begin
      Result := lOperacao;
      Break;
    end;
  end;
end;

procedure TModoGarantia.pAntesMarcar(pSender: TObject; Var pblnValor: Boolean);
begin
  if Not (pSender is TCheckBox) then
    Exit;

  if pblnValor then
    pDesmarcarChkIrmaos(TCheckBox(pSender));
  end;

procedure TModoGarantia.pDesmarcarChkIrmaos(pCheckBox: TCheckBox);
Var
  i: Integer;
begin
  for i := Low(FArrCheckBox) to High(FArrCheckBox) do
  begin
    if Assigned(pCheckBox) And (FArrCheckBox[i] = pCheckBox) then
      continue
    else
    begin
      if FArrCheckBox[i].Checked then
        FArrCheckBox[i].Checked := False;
    end;
  end;
end;

procedure TModoGarantia.pLimparSelecao;
begin
  Self.pDesmarcarChkIrmaos(Nil);
end;

procedure TModoGarantia.pSetCheckBox(pOperacaoGarantia: TOperacaoGarantia;
  pValue: TCheckBox);
begin
  FArrCheckBox[ord(pOperacaoGarantia)] := pValue;
  FArrCheckBox[ord(pOperacaoGarantia)].AntesMarcar := Self.pAntesMarcar;
end;

{ TRecDocGarantia }

function TRecDocGarantia.fAsString: String;
begin
  Result := FstrNumDoc+FstrEspDoc+FstrCodEmp;
end;

constructor TRecDocGarantia.pDefinir(pstrNumDoc, pstrEspDoc, pstrCodEmp,
  pstrCodCli, pstrSerie_, pstrTip_FC: String);
begin
  pInicialiar;
  if fEmptyStr(pstrNumDoc) Then
    Exit;

  if fEmptyStr(pstrEspDoc) Then
    Exit;

  if fEmptyStr(pstrCodEmp) Then
    Exit;

  if fEmptyStr(pstrCodCli) Then
    Exit;

  FstrNumDoc := pstrNumDoc;
  FstrEspDoc := pstrEspDoc;
  FstrCodCli := pstrCodCli;
  FstrCodEmp := pstrCodEmp;
  FstrSerie_ := pstrSerie_;
  FstrTip_FC := pstrTip_FC;
end;

procedure TRecDocGarantia.pInicialiar;
begin
  FstrNumDoc := EmptyStr;
  FstrEspDoc := EmptyStr;
  FstrCodCli := EmptyStr;
  FstrCodEmp := EmptyStr;
  FstrSerie_ := EmptyStr;
  FstrTip_FC := EmptyStr;
  FstrAutoincrem := EmptyStr;
end;

end.
















