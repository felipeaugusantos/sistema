unit untEntMercadorias;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, Uni,
  Grids, DBGridCitel, DBGrids, EditFocus, Mask, MaskEditFocus, DB, QColorLabel, Menus,
  AppEvnts, untFuncoesSimples, BitBtnLockedIncrem, UniClientDataSet, untCadLote,
  DBCtrls, frxClass, StrUtils, untFatorPreco, untTypesSistema, untConsertoEquipMeqMer,
  untFuncoesGenerica, untEntEmbalagens, frxExportCSVTestabilidade, Math,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxProgressBar, untLiberacao, untMsgLiberacao, untTLock, System.DateUtils,
  Faturamento.Consignacao.Classes, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, untCfgCfopCst, FulFillment.Classes,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, MemoFocus, untAuditoriaGravacaoSaldo,
  untTPerfilDespachanteAduaneiro, untLogCancelamento;

type
  TRecDadosFCP = Record
    blnTemST: Boolean;

    fltAliFcp,
    fltValIVA,
    fltBCFCP,
    fltValFCP,
    fltPFCPST,
    fltBCFCPST,
    fltVFCPST: Double;
    constructor Create(pfltAliFcp: Double);
    procedure pInicializar;
    procedure pCalcular;
  end;

  TfrmEntMercadorias = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    pnlBotoesEnt: TPanel;
    pnlDetalhe: TPanel;
    Label1: TLabel;
    mskDtaEnt: TMaskEditFocus;
    Label2: TLabel;
    lblCliFor: TLabel;
    edtNumDoc: TEditFocus;
    Label4: TLabel;
    edtSerie: TEditFocus;
    Label5: TLabel;
    mskDtaDoc: TMaskEditFocus;
    Label6: TLabel;
    edtEspDoc: TEditFocus;
    edtCodFor: TEditFocus;
    Label28: TLabel;
    Label29: TLabel;
    Label32: TLabel;
    shpUnitarGarantia : TShape;
    btnConfirma: TBitBtnLocked;
    pgbCalculoFiscal: TProgressBar;
    pnlItem: TPanel;
    Label7: TLabel;
    edtCodIte: TEditFocus;
    Label10: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    lblCodAbf: TLabel;
    edtCodAbf: TEditFocus;
    edtQtdIte: TEditFocus;
    edtUnitar: TEditFocus;
    edtTotIte: TEditFocus;
    Label12: TLabel;
    Label15: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label30: TLabel;
    edtBasIPI: TEditFocus;
    edtAlqIPI: TEditFocus;
    Label26: TLabel;
    edtBasIcm: TEditFocus;
    edtAlqIcm: TEditFocus;
    edtValIcm: TEditFocus;
    edtvalIpi: TEditFocus;
    edtNomFor: TEditFocus;
    edtDesIte: TEditFocus;
    edtRefere: TEditFocus;
    edtUnidad: TEditFocus;
    edtDesAbf: TEditFocus;
    edtTotIpi: TEditFocus;
    edtTotal: TEditFocus;
    edtTotGer: TEditFocus;
    lblTotSub: TLabel;
    edtTotSub: TEditFocus;
    Label8: TLabel;
    edtEntDev: TEditFocus;
    ColorLabel1: TColorLabel;
    rdbCodFab: TRadioButton;
    rdbCodIte: TRadioButton;
    edtSaldo: TEditFocus;
    Label3: TLabel;
    rdbProdAcabado: TRadioButton;
    edtSigla: TEditFocus;
    lblSigla: TLabel;
    lblNumLot: TLabel;
    edtNumLot: TEditFocus;
    lblEmbala: TLabel;
    edtEmbala: TEditFocus;
    pnlInfAdi: TPanel;
    Label9: TLabel;
    dbeCodFab: TDBEdit;
    edtClaIpi: TEditFocus;
    lbl1: TLabel;
    lblTotAnt: TLabel;
    edtTotAnt: TEditFocus;
    btnAlterPrecos: TBitBtnLocked;
    btnApaga: TBitBtnLocked;
    btnLocProx: TBitBtnLocked;
    btnIniBus: TBitBtnLocked;
    btnCadLot: TBitBtnLocked;
    btnCadProduto: TBitBtnLocked;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    btnCancelarEntrada: TBitBtnLocked;
    lblCgcCpf: TLabel;
    edtCgcCpf: TEditFocus;
    Label11: TLabel;
    edtCodCest: TEditFocus;
    FlwPnlBotoesEntrada: TFlowPanel;
    lblCotDol: TLabel;
    edtCotDol: TEditFocus;
    dbgItensGrid: TcxGrid;
    dbgItens: TcxGridDBTableView;
    dbgItensColumItem: TcxGridDBColumn;
    dbgItensColumDesc: TcxGridDBColumn;
    dbgItensColumRef: TcxGridDBColumn;
    dbgItensColumUnid: TcxGridDBColumn;
    dbgItensColumEmb: TcxGridDBColumn;
    dbgItensColumQuant: TcxGridDBColumn;
    dbgItensColumValUnit: TcxGridDBColumn;
    dbgItensColumValorTotal: TcxGridDBColumn;
    dbgItensColumValorIPI: TcxGridDBColumn;
    dbgItenslv: TcxGridLevel;
    dbgItensColumALTITEM: TcxGridDBColumn;
    dbgItensDesMarca: TcxGridDBColumn;
    pnlObsFornecedor: TPanel;
    lblObsFornecedor: TLabel;
    mmoObsFornecedor: TMemoFocus;
    dbgItensColumNROITE: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarEntradaClick(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtUnitarExit(Sender: TObject);
    procedure edtTotIteExit(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure edtCodAbfKeyPress(Sender: TObject; var Key: Char);
    procedure edtQtdIteExit(Sender: TObject);
    procedure btnAlterPrecosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnApagaClick(Sender: TObject);
    procedure edtCodIteEnter(Sender: TObject);
    procedure edtCodIteKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodIteExit(Sender: TObject);
    procedure rdbCodIteClick(Sender: TObject);
    procedure rdbCodFabClick(Sender: TObject);
    procedure btnIniBusClick(Sender: TObject);
    procedure btnLocProxClick(Sender: TObject);
    procedure rdbProdAcabadoClick(Sender: TObject);
    procedure edtUnidadKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumLotKeyPress(Sender: TObject; var Key: Char);
    procedure btnCadLotClick(Sender: TObject);
    procedure mskDtaEntExit(Sender: TObject);
    procedure mskDtaDocExit(Sender: TObject);
    procedure edtvalIpiExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtEmbalaExit(Sender: TObject);
    procedure btnCadProdutoClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtNumDocExit(Sender: TObject);
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
    procedure edtvalIpiEnter(Sender: TObject);
    procedure edtCodCestKeyPress(Sender: TObject; var Key: Char);
    procedure edtDesIteEnter(Sender: TObject);
    procedure edtNumLotEnter(Sender: TObject);
    procedure edtQtdIteEnter(Sender: TObject);
    procedure edtUnitarEnter(Sender: TObject);
    procedure edtEmbalaEnter(Sender: TObject);
    procedure edtCodCestEnter(Sender: TObject);
    procedure edtClaIpiEnter(Sender: TObject);
    procedure edtCodAbfEnter(Sender: TObject);
    procedure edtBasIPIEnter(Sender: TObject);
    procedure edtAlqIPIEnter(Sender: TObject);
    procedure edtBasIcmEnter(Sender: TObject);
    procedure edtAlqIcmEnter(Sender: TObject);
    procedure edtSiglaEnter(Sender: TObject);
    procedure edtTotIteEnter(Sender: TObject);
    procedure edtRefereEnter(Sender: TObject);
    procedure edtUnidadEnter(Sender: TObject);
    procedure dbgItensDblClick(Sender: TObject);
    procedure dbgItensGridEnter(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtEspDocExit(Sender: TObject);
    procedure dbgItensEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure dbgItensCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    type
      TStatusNfe = record
        ClienteFornecedor : String;
        TipoClienteFornecedor : String;
        Status : String;
      End;
  private
    { Private declarations }
    arrDuplicata: TarrDuplicata;
    blnIFCPST: Boolean;
    blnTravarFinanceiroEstaDuplicado: Boolean;
    blnAdicionando,
    blnCarregadoParaVisualizacao,
    blnAtuIpi,
    blnAtuSub,
    blnAtuIcm,
    blnAtuIcS: Boolean;

    blnValidaLoteDevolucao: Boolean;

    objExcecaoCfopCst: TCfgCfopCst;

    blnAtpVmb : array[1..7] of Boolean;

    blnUsaEnder: Boolean;
    blnPedFilialGarantia:Boolean;
    blnExbObsFornecedor: Boolean;
    fltValIpiAnt,
    fltClcAux: Double;

    strConCla,
    strConSub: String;

    strFrmCus: String;

    blnZonFra: Boolean;

    strClaSub: String;
    qryIteFor: TUniQuery;

    strCnvEmb: String;

    objEmbala: TEntEmbalagens;

    blnSenDif: Boolean;
    blnTemAnt: Boolean;
    fltQtdAnt: Double;
    strSugPen: String;

    blnCotDor,
    blnFecharForm: Boolean;

    strKeyLck: String;
    blnSimPau: Boolean;
    blnPeIcms: Boolean;
    objFatPre: TFatorPreco;
    blnFatPre: Boolean;
    blnEscape: Boolean;
    qryEntMer: TUniQuery;
    dtsEntMer: TDataSource;

    FPais: TPais;

    qryCnfGen: TUniQuery;

    objCadLot: TCadLot;
    strCodFis: String;
    fltPerBas: Double;
    fltPeBaST: Double;
    fltValTot: Double;
    strFabAut: String;
    objLock  : TLock;

    qryConIte: TUniQuery;
    qryConAbf: TUniQuery;
    qryConCit: TUniQuery;
    qryCadUni: TUniQuery;

    fltDesEsp: Double;
    fltValRet: Double;
    fltValAnt: Double;

    fltAliSte: Double;
    fltAliFCP: Double;
    stlCamposIte: TStringList;
    stlCamIndIte: TStringList;
    stlDesIndIte: TStringList;

    strValorFiltro: String;
    strCampoFiltro: String;

    blnForFil: Boolean;
    blnPreMat: Boolean;

    blnBuscarCodFab: Boolean;

    strCodUni: String;
    strUniEmb: String;
    strAbfAnt: String;

    strCodAca: String;
    strEmpAca: String;
    strProAca: String;
    strDesAca: String;
    fltPreAca: Double;
    fltSalAca: Double;
    intDEQTPC: Integer;

    strCodEve: String;
    strCodCcu: String;
    strCtaPed,
    strCodCta: String;
    strPagFor: String;

    blnUsaLotePrecos: Boolean;

    strClaFis: String;

    strNomImp,
    strNomPro,
    strDesPro: String;

    intColAtu: Integer;
    intAUTOINCREMENTO_GRAVACAO: Integer;
    cpuCampos: TCamposUso;
    arrLinEti: Array Of String;

    FNomEmp: String;
    FFonEmp: String;
    FNumDoc: String;
    FCidEmp: String;
    FSeqNum: String;
    FCGCEmp: String;

    FMeqMer: TMeqMer;

    fltMaxDev: Double;
    fltQtdXml: Double;

    blnAltMai: Boolean;

    blnManterIpi: Boolean;
    blnObterConfirmacaoIpi: Boolean;

    blnEncargosNoFrete,
    blnNotaImp : Boolean;

    objLiberacao : TLiberacao;

    FDtaDocParaTrava: TDate;

    FblnAcessadoViaRetornoConsignacao : Boolean;
    FTipoRetornoConsignacao           : tTipoRetornoConsignacao;
    FFulFillmentLogBuilder            : TFulFillmentLogBuilder;
    FClaFisEntPorGarantia: String;
    strCLARGR: String;
    strChaNFe: String;

    objAuditoriaSaldo: IAuditoriaGravacaoSaldo;

    objLogCancelamento : TLogCancelamento;

    Function fValidaRegitrosXML: Boolean;

    Procedure pHabilitaCotacao(blnHabilita: Boolean);

    Function fEhRetornoGarantiaFornecedorInterno(blnClaRGR: Boolean = False): Boolean;
    Function fVerificaVariacaoPrecosFinal: Boolean;

    Function fTemPreNota: Boolean;

    Function fRetKeyLck: String;
    Function fCarregaNumPedCom: Boolean;

    Function fTravaItem(strCodIte: String): Boolean;
    Function fTravaItensLote(pgbProgresso: TcxProgressBar): Boolean;

    procedure pAjustaEspecie;

    procedure pCarregaItensAlteracao(blnVisualizacaoPainel: Boolean = False);
    procedure pCarregaItensVis;

    procedure pAtribuiTabelas;
    procedure pLimpaDadosItem;

    procedure pAlteraItem;
    procedure pDeletaItem(AItem: integer);

    procedure pAtualizaTabela;
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);

    procedure pCarregaFornecedor(blnValidaPlanoDeContas: Boolean = True);
    procedure pCarregaItem(strIteAlt: String; blnBuscaPorChave, blnAtualizaEdits: Boolean; blnRepesquisa: Boolean = False; blnCarregarVis: Boolean = False);

    procedure pCarregaProdutoAcabado(strCodBar: String);

    procedure pCarregaAbrevFiscal(blnBuscaPorChave, blnCarregarIcms: Boolean; strCodite: String = '');
    procedure pCarregaAbrevFiscalIcms(blnBuscaPorChave, blnCarregarIcms: Boolean);

    procedure pHabilitaCampos(Owner: TWinControl; blnHabilita: Boolean);

    procedure pCalculaTotais;
    procedure pCalculaTotIte(Sender: TObject);
    procedure pCalculaValIpi(blnRecalculaAliquota: Boolean = False);

    procedure pConsultaCadFor;
    procedure pConsultaCadCli;

    procedure pAtualizaDados(Dataset: TDataset);
    Procedure pDestravaItensLote;
    Procedure pDestravaDocumento;

    Function  fVerificaLotes: Boolean;

    function  fVerifExisteItem: Boolean;

    function fVerificaDocumentoExiste: Boolean;
    function fVerificaDocumentoExisteCtp: Boolean;
    function fVerificaDocumentoExisteCtr: Boolean;
    function fVerificaDocumentoExisteFis: Boolean;

    function fCalculaItensPedido(pgbProgresso: TcxProgressBar): Boolean;
    function fValidaConfigNotImp: Boolean;
    function fEhNFEEntrada: Boolean;

    function fValidaCabecalho: Boolean;
    procedure pAtuTabelaGrid;

    function fCarregaDadosPedido: Boolean;

    function fVerificaDataBalanco: Boolean;

    function fConsultaProdAcabados(edtCodIte: TEditFocus): Boolean;

    Function fedtCodIteKeyPressGer(Sender: TObject; var Key: Char; strCodFab: String = ''): Boolean;
    Function fItemCarregadoParaVisualizacao: Boolean;
    procedure pAlteraItemNfe;

    procedure pMostraLote(blnMostrar: Boolean; strReaEnd: String; blnMarmore: Boolean = False);
    function fPrecoUnitarioEspecialFornecedor(strCodFor,
      strCodIte: String): Double;

    procedure pCarregaDadosAdicPedido(strCodFor, strNumPed: String);

    procedure pImprimeFichaProdutos;
    procedure pImpEtiquetaMatricial;

    procedure pAtualizaCamposUso;
    procedure pAtribuiCamposUso;
    procedure pFinalizaCamposUso;
    procedure pImpRegistro;
    procedure pImpArrLinEti;
    procedure pAtualizaIpiOriginal;

    Function  fInicializaArmazemLoteADefinir(blnFiltrarComLotes: Boolean = False): Boolean;

    function fRetTopo(strTipEti: String): Integer;
    function fCondicaoPagamentoDevolucao: String;

    function fRetornaMotivoAD: String;
    function fCarregaPrecoFornecedor(strCodIte, strCodFor : String; qryPreco : TUniQuery ): Boolean;
    Function fRetReaEnd(strCodIte: String): String;

    procedure pHabilitaIcms(blnHabilita: Boolean);
    function fGerarPedidoVenda(strNumPed, strCodEmp: String): Boolean;

    Function fValidaPrecosDevolucao: Boolean;
    function fDesabilitaItensConEquXML: Boolean;

    Function fSQLItem(blnAtuIcS: Boolean): String;

    Function fPedeCotacao: Boolean;
    function fEspecieInvalida: Boolean;

    Function fTemProdutosEmDolar: Boolean;
    function fCarregaClienteConsumidor: Boolean;

    function fAvisarDataDocumentoMaiorQueDataEntrada: Boolean;
    function fLiberouTravaDataDocumentoMaiorQueDataEntrada: Boolean;
    procedure pConfirmarIpi;
    procedure pInicializaVariaveisManterIpi;

    procedure pHabilitaCampoNaGridEspeciePD(blnHabilita: Boolean);

    Function fExisteItemAlteradoManualmenteGrid: Boolean;

  	function fGarantiaPermitirEditarLote: Boolean;
    function fLiberarEntradaGarantia: Boolean;
    function fValidarEntradaGarantia: Boolean;
    procedure pSetClaFisEntPorGarantia(Value: String = '');
    function fEntPedidoPorGarantia: Boolean;
    procedure pMensagem(Const strMensagem: String);
    function fCalcularFcp(pfltBasIcm, pfltAliFcp, pfltPeBaST: Double; pstrCodFor, pstrCodAbf, pstrTipAbf: String): TRecDadosFCP;
    function fObterFcpItem: TRecDadosFCP;
    function fCalcularFcpDevolucao: Boolean;
    function fValidouAutorizacaoDoDocumentoDeTransferencia : Boolean;
    function fValidouCancelamentoDoDocumento : Boolean;
    function fGetStatusNfe(const strChaveAcesso : String) : TStatusNfe;
  published
    property strNomEmp: String Read FNomEmp;
    property strCGCEmp: String Read FCGCEmp;
    property strFonEmp: String Read FFonEmp;
    property strCidEmp: String Read FCidEmp;
    property strNumDoc: String Read FNumDoc;
    property strSeqNum: String Read FSeqNum;
    property objMeqMer: TMeqMer Read FMeqMer;
  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fVerificaItemServicoDivergenteJaUsado(AstrCodIte: String): Boolean;
    function fVerificaDataEntradaMenorQueBalanco(DtaEnt: TDate): Boolean;
  public
    fAoConfirmarEntrada: TAoConfirmarDocumento;
    PerfilDespachanteAduaneiro: TPerfilDespachanteAduaneiro;
    blnAutomatico,
    blnRedIcmsParana,
    blnBonificacao,
    blnInformouCotacao,
    blnPrecoPraticado: Boolean;
    strSeqGer: String;
    strMatRev: String;

    fltCotDol: Double;

    { Public declarations }
    recNotEle: TRecInfoNotaEletronica;
    qryItePed: TUniQuery;
    fltOciVlr: Double;
    blnOcilaP: Boolean;
    blnFulFillment: Boolean;

    fltValFre: Double;
    fltDesAce: Double;

    qryConCli: TUniQuery;

    (**************************************************************)
    (* NUMERO DO PEDIDO DE DEVOLUÇÃO (FATGOR)                     *)
    (***********************************************************LA*)
    strPedDev: String;

    strOrdIte: String;
    strDocSel: String;
    blnConfirma: Boolean;

    blnGarantia: Boolean;
    cdsMovGad: TUniClientDataSet;
    blnRecCliGarantia: Boolean;
    blnRecCliGarantiaComGeracaoDeCredito:  Boolean;

    fltAlqFor: Double;
    fltTotPis: Double;
    fltTotCof: Double;
    fltTotGPC: Double;
    strIncPis: String;
    strEstFor: String;
    strCodFaz: String;
    strCodFor: String;
    strIesFor: String;
    strTipFor: String;
    strCgcCpf: String;
    strTipCgcCpf: String;
    strCodRep: String;
    strCodVen: String;
    strClaFisGar: String;
    strClaFisSub: String; // Classificação de Garantia quando Produto Substituido
    blnDevolu: Boolean;
    blnSemInc: Boolean; // SE NAO PODE INCLUIR ITENS (TRUE = SEM INCLUSAO)
    blnDocOri: Boolean; //DOCUMENTO ORIUNDO
    blnForSta: Boolean;

    blnPresencial,
    blnConEqu: Boolean;
    blnLocEqu: Boolean;

    arrDocOri: TStringArrayArray;

    strMotDev: String;

    strConPag: String;

    {**************************************}
    {* PEDIDOS SELECIONADOS               *}
    {***********************************MV*}
    stlPedidos: TStringList;
    blnCarregProd: Boolean;

    strAutDev: String;

    strItensEntradaMercadoriaDev: String;

    blnFornJaAtualizado: Boolean;

    arrLinDigCodbar: TarrLinDigCodbar;
    //blnRetornoForn: Boolean; // VERIFICA SE É RETORNO PARA MONTAR O FSQLITENSGARANTIA, POIS VERIFICA QUAL LOTE VAI RECEBER O SALDO **RL**

    onBeforeConfirmaEntrada : TGenericProcedure;
    onAfterConfirmaEntrada : TGenericProcedure;

    arrClienteConsumidor: TStringArray;
    blnBaixaPedidoDev: Boolean;
    procedure pCarregaItemDevolucao(strCodIte: String);
    procedure pShow;
    procedure pCarregaCliente(strCodCli: String);
    procedure pAdicionaItem(fltUnitar, fltQtdIte, fltTotIte,
                            fltAlqIpi, fltBasIPI, fltValIpi,
                            fltAlqIcm, fltBasIcm, fltValIcm: Double;
                            strCodIte, strCodGru, strDesIte, strRefere, strUnidade,
                            strCodAbf, strDesAbf,
                            {*********************************************************************}
                            {* AUTOINCREMENTO DO ITEM CORRESPONDETE A VENDA QUANDO FOR DEVOLUÇÃO *}
                            {******************************************************************LA*}
                            strAutVen,
                            strTabVen,
                            strCodFab,
                            strNumPed,
                            strEspDoc,
                            strCodEmp,
                            strCodCli,
                            strNumLot,
                            strRprEnt,
                            strCodAca,
                            strEmpAca,
                            strProAca,
                            strDesAca: String;
                            fltPreAca,
                            fltSalAca: Double;
                            strClaIpi: String;
                            fltEmbala: Double;
                            strUniEmb: String;
                            strCodMot: String;
                            strCodDiv: String='';
                            fltDEsUni: Double=0;   // Desconto Especial Unitario, Utilizado na Devolução
                            strEmp_Pd: String = '';
                            strCDCEST: String = '';
                            strIncPisDev: string = '';
                            strCstCofDev: string = '';
                            strCstPisDev: string = '';
                            strNR_PisDev: string = '';
                            strNR_CofDev: string = '';
                            strCodFisDev: string = '';
                            fltValRetDev: Double = 0;
                            fltBasRetDev: Double = 0;
                            fltVal_RtDev: Double = 0;
                            fltPerBasDev: Double = 0;
                            fltPeBaSTDev: Double = 0;
                            fltPerRedDev: Double = 0;
                            fltAlqRetDev: Double = 0;
                            fltValCofDev: Double = 0;
                            fltBasPisDev: Double = 0;
                            fltValPisDev: Double = 0;
                            fltBasCofDev: Double = 0;
                            fltDesAceDev: Double = 0;
                            fltAlqCofDev: Double = 0;
                            fltAlqPisDev: Double = 0;
                            fltDesEsp   : Double = -1;
                            fltValFre   : Double = -1;
                            fltQtdOri   : Double = -1;
                            strProEmb: String = 'N';
                            strImpDir: String = '';
                            fltBFCPST: Double = 0;
                            fltPFCPST: Double = 0;
                            fltVFCPST: Double = 0;
                            fltVBCFCP: Double = 0;
                            fltPERFCP: Double = 0;
                            fltVALFCP: Double = 0;
                            strIdePro: string = '';
                            strIteTin: String = '';
                            intnItem: Integer = 0;
                            strDesMar: String = '';
                            strIncFut: String = '');

  property blnAcessadoViaRetornoConsignacao : Boolean                 read FblnAcessadoViaRetornoConsignacao write FblnAcessadoViaRetornoConsignacao;
  property TipoRetornoConsignacao           : tTipoRetornoConsignacao read FTipoRetornoConsignacao           write FTipoRetornoConsignacao;
  property objFulFillmentLogBuilder         : TFulFillmentLogBuilder  read FFulFillmentLogBuilder            write FFulFillmentLogBuilder;

  end;


implementation
{$R+}

uses  untFuncoes, untPesqAux, untConsultas,
      untPai, untConstantes, untEntAlteraPrecos,
      untEntDadosFiscais, untEntDadosCaixa2,
      untFuncIns, untFuncIns2, untModuloEntMercadorias, untCfgRel,
      untParCalculaPrecoCusto, untBuscaItem,
      untCadLoteItens, SysConst, untDigOcorrencia, untPcmGer,
      untFuncMacro, untCadProdutos, untPnlDadosItem, untCalculoPisCofins,
      untTConfiguracao,  untEntIcmsAntecipado,
      untPanelCxItem, untEntDivergenciaOscilacao,untEntPedIcmsAntecipado,
       untFuncFat, untEntEtiquetas, untIteBar, untEntradaAutomatizada,
      untEntTestaCFOPS, untMensagemTravaLote, untGravando,
      untVinculoBaixaEntregaFuturaEdocVenda, untLotePrecosEfetivacaoCx,
      untLiberacaoFactory, untIFatEntregaFutura, untTFatEntregaFutura,
      untMensagemExplicativa, untPedeCotacaoMoeda, untEntradaValidacoes,
      untItensInconsistentesEntrada, untDefineBaixaPedido,
      untZClient,
      untFatDigDadosGarantia,
      untMsgGridGenerica, untTMensagem;

{$R *.dfm}

Function TfrmEntMercadorias.fRetReaEnd(strCodIte: String): String;
Begin
  Result := 'N';
  If Not (fCfgSis('USACON', varBoolean)) Then
    Exit;
  If Not (Pos(fCfgSis('CONFME'), '1_3_') > 0) Then
    Exit;

  If fCfgSis('ENTEND', varBoolean) Then
    Result := fCampoTabela('IFNULL(ITE_REAEND,"N")', 'CADITE', ['ITE_CODITE'], [strCodIte]);
End;

procedure TfrmEntMercadorias.pMostraLote(blnMostrar: Boolean; strReaEnd: String; blnMarmore: Boolean = False);
Begin
  if recNotEle.finalidadeXML = xmlDevolucaoEntradaEmitidaFornecedor Then
  Begin
    lblNumLot.Visible := False;
    edtNumLot.Visible := False;
    Exit;
  End;

  lblNumLot.Visible := blnMostrar;
  edtNumLot.Visible := blnMostrar;

  {********************************************************}
  {* SE UTILIZA ENDEREÇAMENTO E ARMAZÉM NÃO DEIXA EDITAR  *}
  {*****************************************************AL*}
  edtNumLot.ReadOnly := ((objCadLot.tplTipLot = tplArmazem) and blnUsaEnder And (strReaEnd <> 'N')) Or fUsaRotinaWMS;
  if edtNumLot.ReadOnly then
  begin
    edtNumLot.ReadOnly := Not fGarantiaPermitirEditarLote;
  end;


  If (Not edtNumLot.ReadOnly) And (blnMarmore) Then
    edtNumLot.ReadOnly := True;


  edtNumLot.TabStop  := Not edtNumLot.ReadOnly;

  If edtNumLot.ReadOnly Then
  Begin
    edtNumLot.Color := $00FFDFB8;
    edtNumLot.FocusColor := $00FFDFB8;
  End;

  If Not edtNumLot.Visible Then
    edtNumLot.Clear;
End;

procedure TfrmEntMercadorias.FormCreate(Sender: TObject);
  Var
    strSQL   : String;
    intCont: Integer;
begin
  inherited;
  fAoConfirmarEntrada := Nil;
  blnBaixaPedidoDev := False;
  blnTravarFinanceiroEstaDuplicado := False;
  blnIFCPST := fCfgSis('IFCPST', varBoolean);
  pZeraDigDuplic(arrDuplicata);
  edtCodAbf.MaxLength := fTamCodAbfIcm;
  edtCodAbf.TamCampo := fTamCodAbfIcm;
  strCLARGR := fTransform(fCfgSis('CLARGR'), 4);
  pSetClaFisEntPorGarantia;

  pInicializaVariaveisManterIpi;
  FblnAcessadoViaRetornoConsignacao := False;

  blnAutomatico := False;
  onBeforeConfirmaEntrada := nil;
  onAfterConfirmaEntrada := nil;

  blnRedIcmsParana := False;
  blnBonificacao := False;
  fltCotDol := 0;
  blnCotDor := fCfgSis('COTDOR', varBoolean);
  blnCarregadoParaVisualizacao := False;
  intDEQTPC := fCfgSis('DEQTPC', varInteger);

  strConCla := fCfgSis('CONCLA');
  strConSub := fCfgSis('CONSUB');

  For intCont := 1 to 7 Do
    blnAtpVmb[intCont] := (fCfgSis( IIF( intCont = 1, 'ATPVMB', 'ATPVM' + IntToStr(intCont) )) = 'P');

  intAUTOINCREMENTO_GRAVACAO := 0;
  blnPrecoPraticado := False;

  blnPresencial := False;

  blnAtuSub := fCfgSis('ATUSUB', varBoolean);
  blnAtuIpi := fCfgSis('ATUIPI', varBoolean);
  blnAtuIcm := fCfgSis('ATUICE', varBoolean);
  blnAtuIcS := fCfgSis('ATUICS', varBoolean);

  objLiberacao := TLiberacao.Create;
  objLock := TLock.Create;

  SetLength(arrDocOri, 0, 0);
  SetLength(arrClienteConsumidor, 11);

  strFrmCus := fCfgSis('FRMCUS', varString);

  blnZonFra := False;

  strClaSub := fRegimeSubstituicaoTributaria;

  qryIteFor := fCriaQuery(Self);

  blnTemAnt := fTemAntecipacaoIcms;

  blnGarantia := False;
  blnRecCliGarantia := False;
  blnRecCliGarantiaComGeracaoDeCredito := False;
  blnNotaImp := False;
  blnFulFillment := False;

  FblnAcessadoViaRetornoConsignacao := False;

//  lblTotAnt.Visible := blnTemAnt;
//  edtTotAnt.Visible := blnTemAnt;

  lblTotAnt.Visible := False;
  edtTotAnt.Visible := False;

  strAutDev := '';

  blnFecharForm := False;

  FPais     := fSetaPais;
  qryItePed := Nil;

  fltOciVlr := fCfgSis('OCIVLR', varDouble);
  blnOcilaP := fCfgSis('VALOCI', varBoolean);

  strKeyLck := '';
  blnUsaLotePrecos := (fCfgSis('LOTPRE', varBoolean));

  blnEscape := False;
  objCadLot := TCadLot.Create(Self);
  pMostraLote(False, '');

  FillChar(recNotEle, SizeOf(recNotEle), #0);
  strOrdIte     := '';
  strPedDev     := '';
  strCodVen     := '';
  edtSigla.Text := '';

  blnDocOri       := False;
  blnBuscarCodFab := True;
  blnSemInc       := False;

  blnPreMat := fPreMat;

  If (Not fCfgSis('EXITCU', varBoolean)) Or (blnPreMat) Or
     fCfgSis('LOTPRE', varBoolean) Then
  Begin
    btnAlterPrecos.Enabled := False;
    btnAlterPrecos.Visible := False;
  End;

  blnConfirma := False;

  edtEspDoc.Text := 'NF';

  fltValFre := 0.0;
  fltDesAce := 0.0;
  fltDesEsp := 0.0;

  strEstFor := '';
  strCodFaz := '';
  fltAlqFor := 0.0;

  fltMaxDev := 0.0;

  pAtribuiTabelas;

  dbgItens.DataController.DataSource  := Nil;
  dbeCodFab.DataSource := Nil;
  dbeCodFab.DataField  := '';

  qryEntMer := fCriaQuery(Self);
  qryEntMer.OnFilterRecord := pFilterRecord;
  dtsEntMer := fCriaDataSource(qryEntMer);

  pHabilitaCampos(pnlCabecalho, True);
  pHabilitaCampos(pnlItem, False);
  dbgItensGrid.Enabled := False;

  strAbfAnt := '';

  stlPedidos := TStringList.Create;

  strCnvEmb := fCfgSis('CNVEMB');

  If Not fCfgSis('ALTEMB', varBoolean) Then
  Begin
    edtEmbala.Enabled  := False;
    edtEmbala.ReadOnly := True;
    edtEmbala.TabStop  := False;
  End;


  If (strCnvEmb = 'N') Or blnDevolu Then
  Begin
    lblEmbala.Visible := False;
    edtEmbala.Visible := False;
    dbgItensColumEmb.Visible := False; //ENT_EMBALA
    //    dbgItens.Columns.Items[4].Visible := False; //ENT_EMBALA
  End
  Else
  Begin
    dbgItensColumUnid.Caption:= 'UN-Emb'; //ENT_UNIEMB
    dbgItensColumUnid.DataBinding.FieldName:= 'ENT_UNIEMB'; //ENT_UNIEMB

  //    dbgItens.Columns.Items[3].Title.Caption := 'UN-Emb'; //ENT_UNIEMB
  //    dbgItens.Columns.Items[3].FieldName := 'ENT_UNIEMB'; //ENT_UNIEMB

  End;

  If (strCnvEmb <> 'N') And (Not blnDevolu) Then
    objEmbala := TEntEmbalagens.Create(Self)
  Else
    objEmbala := Nil;

  objFatPre := Nil;
  blnFatPre := fCfgSis('FATPRE', varBoolean);

  If blnFatPre Then
    objFatPre := TFatorPreco.Create;

  {**************************************************}
  {* VARIÁVEIS UTILIZADAS NA IMPRESSÃO DE ETIQUETAS *}
  {***********************************************RV*}
  FNomEmp := fRetNomeEmpresa;
  FCGCEmp := fFormataCpfCgc(fRetCGCEmpresa(VS_strCodEmp), FPais);
  FFonEmp := fRetFoneEmpresa(VS_strCodEmp);
  FCidEmp := fRetNomCidade(fRetNomGeral('EMP_CODCID', 'EMP_CODEMP', 'CADEMP', fStrToFloat(VS_strCodEmp)), 0) + '-' +
             fRetNomCidade(fRetNomGeral('EMP_CODCID', 'EMP_CODEMP', 'CADEMP', fStrToFloat(VS_strCodEmp)), 1);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CNFETI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CNF_TIPETI = :TIPETI AND';
  strSQL := strSQL + '  CNF_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  CNF_TIPETI, CNF_IDENTI, CNF_LINIMP, CNF_COL001 ';

  qryCnfGen := fCriaQuery(Self);
  qryCnfGen.SQL.Clear;
  qryCnfGen.SQL.Add(strSQL);

  fltQtdAnt := 0;

  blnConEqu    := False;
  blnLocEqu    := False;
  blnAdicionando := False;

  FDtaDocParaTrava := 0;

  objExcecaoCfopCst := TCfgCfopCst.Create(Self, True);
  objExcecaoCfopCst.fCarregaDados;

  objAuditoriaSaldo := TAuditoriaGravacaoSaldo.New;

  strItensEntradaMercadoriaDev := EmptyStr;

  objLogCancelamento := TLogCancelamento.Create;
end;

procedure TfrmEntMercadorias.FormDestroy(Sender: TObject);
begin
  inherited;

  If Assigned(objFatPre) Then  FreeAndNil(objFatPre);
  If Assigned(FMeqMer) Then FreeAndNil(FMeqMer);
  If Assigned(objLiberacao) Then FreeAndNil(objLiberacao);
  If Assigned(objLock) Then FreeAndNil(objLock);
  If Assigned(objCadLot) Then FreeAndNil(objCadLot);
  If Assigned(objExcecaoCfopCst) Then FreeAndNil(objExcecaoCfopCst);
  If Assigned(objLogCancelamento) Then FreeAndNil(objLogCancelamento);

end;

procedure TfrmEntMercadorias.btnCancelarEntradaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

Function TfrmEntMercadorias.fTemPreNota: Boolean;
  Var
    qryNota: TUniQuery;
Begin
  qryNota := fCriaQuery;
  qryNota.SQL.Text := Concat('SELECT COUNT(*) AS QTD FROM PEDELE WHERE PEL_SEQELE = ', QuotedStr(recNotEle.strAutInc));
  qryNota.Open;

  Result := qryNota.FieldByName('QTD').AsInteger > 0;

  FreeAndNil(qryNota);
End;

Function TfrmEntMercadorias.fVerificaVariacaoPrecosFinal: Boolean;
  Var
    fltUnitar: Double;
    blnControlar: Boolean;
Begin

  Result := True;

  If blnDevolu Then
    Exit;

  If (Not blnOcilaP) Then
    Exit;

  // SE JA JOI VALIDADO NA PRE-NOTA
  If fTemPreNota Then
    Exit;

  With qryEntMer Do
  Begin
    If Assigned(qryItePed) And qryItePed.Active Then
    Begin
      blnControlar := Not qryEntMer.ControlsDisabled;
      Try
        pCriarFormularios(TfrmEntDivergenciaOscilacao, frmEntDivergenciaOscilacao);
        if blnControlar then
          DisableControls;
        First;
        While Not Eof Do
        Begin
          fltUnitar := ((FieldByName('ENT_UNITAR').AsFloat - RoundTo(FieldByName('ENT_DESESP').AsFloat / FieldByName('ENT_QTDITE').AsFloat, -2))
                          / IIF((FieldByName('ENT_EMBALA').AsFloat <> 0) And (fCfgSis('CNVEMB') = 'S') , FieldByName('ENT_EMBALA').AsFloat, 1));

          Result := fVerificaVariacaoPreco(qryItePed,
                                           FieldByName('ENT_CODITE').AsString,
                                           fltUnitar,
                                           fltOciVlr);

          If Not Result Then
          Begin
            With frmEntDivergenciaOscilacao Do
              fAddItemDivergente(FieldByName('ENT_CODITE').AsString + ' - ' + FieldByName('ENT_DESITE').AsString,
                                 qryItePed.FieldByName('ENT_UNITAR').AsFloat / IIF((qryItePed.FieldByName('ENT_EMBALA').AsFloat <> 0) And (fCfgSis('CNVEMB') = 'S') ,
                                                                            qryItePed.FieldByName('ENT_EMBALA').AsFloat, 1),
                                 fltUnitar);
          End;

          Next;
        End;

        Result := frmEntDivergenciaOscilacao.fValidaUsuario;

      Finally
        FreeAndNil(frmEntDivergenciaOscilacao);
        First;
        if blnControlar then
          EnableControls;
      End;
    End;
  End;

End;

function TfrmEntMercadorias.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    blnAtuEdits: Boolean;
    strCodSit: String;
    strTipAbf: String;
    fltQtdNov,
    fltQtdOri: Double;

    Function fTravaDocumento: Boolean;
    Begin
      Result := True;

      If (Not SameText(strKeyLck, fRetKeyLck)) Then
      Begin
        objLock.fLock_Unlock(strKeyLck, False);
        strKeyLck := fRetKeyLck;

        If Not objLock.fLock_Unlock(strKeyLck, True, False) Then
        Begin
          fMensagem('ATENÇÃO!', 'Um documento com os mesmos dados está sendo digitado em outra estação: ' + fGetHostLock(strKeyLck + '%'), ['&Ok']);
          Result := False;
        End
      End;
    End;

begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA A DATA DE ENTRADA              *}
    {**************************************MV*}
    If (Sender = mskDtaEnt) Then
    Begin
      Result := TEntradaAutomatizada.fValidaDataEntrada(mskDtaEnt.Text, blnDevolu, 0 {dtaDtaVen}, edtEspDoc.Text);

      If Not Result Then
      Begin
        pHabilitaCampos(pnlCabecalho, True);
        pHabilitaCampos(pnlItem, False);
        dbgItensGrid.Enabled := False;
      End;

    End

   // Código Cest;
    Else If (Sender = edtCodCest) Then
    Begin
      If Not fEmptyStr(edtCodCest.Text) Then
      Begin
        If fEmptyStr(fRetDesCDCEST(edtCodCest.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Classificação CEST não cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
    End
    {*****************************************}
    {* VALIDA A DATA DO DOCUMENTO            *}
    {**************************************MV*}
    Else If (Sender = mskDtaDoc) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaDoc.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data do Documento deve ser preenchida!', ['&O k']);
        pHabilitaCampos(pnlCabecalho, True);
        pHabilitaCampos(pnlItem, False);
        dbgItensGrid.Enabled := False;
        Result := False;
      End

      Else If StrToDateDef(mskDtaDoc.Text,0) > StrToDateDef(mskDtaEnt.Text,0) Then
      Begin
        Case AnsiIndexStr(UpperCase(fCfgSis('DEMQDD', varString)), ['A', 'T']) Of
          0: Result := fAvisarDataDocumentoMaiorQueDataEntrada; //AVisa;
          1: Result := fLiberouTravaDataDocumentoMaiorQueDataEntrada; //Trava;
        End;
      End

      Else If (StrToDate(mskDtaDoc.Text) < StrToDate('01/01/2000')) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data do Documento não pode ser menor que 01/01/2000!', ['&O k']);
        Result := False;
      End

      Else If recNotEle.finalidadeXML = xmlEntradaMercadoriasSistemaAnteriorDevolucao Then
      Begin
        Result := fVerificaDataEntradaMenorQueBalanco(StrToDate(mskDtaDoc.Text));
      End

      Else If StrToDateDef(mskDtaDoc.Text, -1) = -1 Then
      Begin
        fMensagem('ATENÇÃO!', 'Data do Documento inválida!', ['&O k']);
        pHabilitaCampos(pnlCabecalho, True);
        pHabilitaCampos(pnlItem, False);
        dbgItensGrid.Enabled := False;
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA A NÚMERO DO DOCUMENTO          *}
    {**************************************MV*}
    Else If (Sender = edtNumDoc) Then
    Begin
      If fEmptyStr(edtNumDoc.Text) Or SameText(edtNumDoc.Text, fStrZero('0', edtNumDoc.TamCampo)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Número do Documento deve ser preenchido!', ['&O k']);
        pHabilitaCampos(pnlCabecalho, True);
        pHabilitaCampos(pnlItem, False);
        dbgItensGrid.Enabled := False;
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA A SÉRIE DO DOCUMENTO           *}
    {**************************************MV*}
    Else If (Sender = edtSerie) Then
    Begin
      if (fEmptyStr(edtSerie.Text)) and SameText(edtEspDoc.Text, 'NF') then
      Begin
        fMensagem('ATENÇÃO!', 'É Obrigatório informar uma Série!', ['&Ok']);
        Result := False;
      End
      Else If (Not fEmptyStr(edtSerie.Text)) Then
      Begin
        Result := (TrimLeft(edtSerie.Text) = edtSerie.Text);
        If Not Result Then
        Begin
          fMensagem('ATENÇÃO!', ' O número da Série é inválido!', ['&Ok']);
          Result := False;
        End;
      End;

      If Result Then
        pAjustaEspecie;
    End

    {*****************************************}
    {* VALIDA A ESPÉCIE                      *}
    {**************************************MV*}
    Else If (Sender = edtEspDoc) Then
    Begin
      If fEmptyStr(edtEspDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Espécie do Documento deve ser preenchida!', ['&O k']);
        Result := False;
      End;

      If fEspecieInvalida Then
      Begin
        fMensagem('ATENÇÃO!', 'Espécie inválida!', ['&O k']);
        Result := False;
      End;

      If (edtEspDoc.Text = 'PD') And blnGarantia And (Not blnRecCliGarantia) Then
      Begin
        fMensagem('', 'Espécie não permitida para Retorno de Fornecedor, utilize a espécie "GR"!', ['&OK']);
        edtEspDoc.Text := 'GR';
      End;

      //Casos Garantia:
      // Recebimento por entrada só permite NF (sem documento fiscal é GA)
      // Retorno de Fornecedor, pode ser NF ou GR (Garantia Retorno Fornecedor)
      If Pos(edtEspDoc.Text, IfThen(blnRecCliGarantia Or blnConEqu or blnLocEqu or FblnAcessadoViaRetornoConsignacao, 'NF', IfThen(blnGarantia And (Not blnRecCliGarantia),'NF_GR_', 'NF_PD_'))) = 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Espécie inválida!', ['&O k']);
        Result := False;
      End;

      If Result Then
      Begin

        If (blnBuscaPorChave) And (Not edtCodFor.Enabled) Then
          Result := fTravaDocumento And fCarregaDadosPedido;

      End Else
      Begin
        pHabilitaCampos(pnlCabecalho, True);
        pHabilitaCampos(pnlItem, False);
        dbgItensGrid.Enabled := False;
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO FORNECEDOR         *}
    {**************************************MV*}
    Else If (Sender = edtCodFor) Then
    Begin

      If fEmptyStr(edtCodFor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do ' + IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu Or blnLocEqu, 'Cliente', 'Fornecedor') + ' deve ser preenchido!', ['&O k']);
        pHabilitaCampos(pnlCabecalho, True);
        pHabilitaCampos(pnlItem, False);
        dbgItensGrid.Enabled := False;
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin

        If (blnDevolu) Or (blnRecCliGarantia) Or (blnConEqu) Or blnLocEqu or (FblnAcessadoViaRetornoConsignacao) Then
        Begin
          pCarregaCliente(edtCodFor.Text);
          If qryConCli.FieldByName('CLI_CODCLI').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&O k']);
            Result := False;
          End;
        End
        Else
        Begin

          If ( Not fFornecedorTemCentroCusto(edtCodFor.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse fornecedor não possui Plano de Contas vinculados ao seu cadastro!', ['&O k']);
            Result := False;
          End Else
          Begin
             pCarregaFornecedor;
            If qryConCli.FieldByName('FOR_CODFOR').IsNull Then
            Begin
              fMensagem('ATENÇÃO!', 'Esse fornecedor não está cadastrado!', ['&O k']);
              Result := False;
            End;
          End;

        End;

        If (Result) And (blnForFil) Then
        Begin
          Result := fVerificaClaFisForFil(edtCodFor.Text);
        End;

        If Result Then
          Result := fTravaDocumento;

        If (Result) And qryEntMer.IsEmpty Then
        Begin
          strMatRev := IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu Or blnLocEqu, '',
                           fCampoTabela('FOR_MATREV', 'CADFOR', ['FOR_CODFOR'], [strCodFor]));

          Result := fCarregaDadosPedido;
        End;

      End;

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
    
    Else If (Sender = edtEntDev) Then
    Begin

    End

    Else If (Sender = edtCodIte) Then
    Begin
      If (edtCodIte.ReadOnly) Then
      Begin
        if blnRecCliGarantia Or blnGarantia or FblnAcessadoViaRetornoConsignacao Then
            Result := True
        Else
          Result := False;
      End
      Else If fEmptyStr(edtCodIte.Text) Then
      Begin

        If blnBuscaPorChave Then
        Begin
          blnMudarFoco := False;
          pSetFocus(dbgItensGrid);
        End
        Else
        Begin
          fMensagem('ATENÇÃO!', 'O Código do Item deve ser preenchido!', ['&O k']);
          Result := False;
        End;

      End
      Else
      Begin
        blnAtuEdits := ((blnBuscaPorChave) And (btnAdicionar.Tag <= 0))  Or
                       ((qryConCit.Active) And (qryConCit.FieldByName('ITE_CODITE').AsString <> edtCodIte.Text)) ;

        pCarregaItem(edtCodIte.Text, blnBuscaPorChave, blnAtuEdits, True);

        If qryConCit.FieldByName('ITE_CODITE').IsNull Then
        Begin

          fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
          Result := False;

        End
        Else If (qryConCit.FieldByName('ITE_ITEATI').AsString <> 'S') And (recNotEle.finalidadeXML <> xmlEntradaMercadoriasSistemaAnteriorDevolucao) Then
        Begin
          pLimpaDadosItem;
          fMensagem('ATENÇÃO!', 'Esse item está Inativo!', ['&O k']);
          Result := False;
        End
        Else If (recNotEle.finalidadeXML <> xmlEntradaMercadoriasSistemaAnteriorDevolucao) And (qryConCit.FieldByName('ITE_ATICOM').AsString <> 'S') And (Not blnDevolu) Then
        Begin
          if fCfgSis('ITEINA', varBoolean) then
          begin
            fMensagem('ATENÇÃO!', 'Esse item não está ativo para compras, Será preciso liberar!', ['&O k']);
          end
          else
          begin
            pLimpaDadosItem;
            fMensagem('ATENÇÃO!', 'Esse item não está ativo para compras, verifique o cadastro!', ['&O k']);
            Result := False;
          end;
        End
        Else If (recNotEle.finalidadeXML <> xmlEntradaMercadoriasSistemaAnteriorDevolucao) And (qryConIte.FieldByName('ITE_DTABAL').AsDateTime >= StrToDate(mskDtaEnt.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido dar entrada um item com data de balanço ' + DateToStr(qryConIte.FieldByName('ITE_DTABAL').AsDateTime) + '. Verifique!', ['&O k']);
          Result := False;
          btnCancelaItem.Click;
        End
        Else If (Not fCfgSis('EMIESP', varBoolean))                                      And
                (Pos('ITEM ESPECIAL', qryConCit.FieldByName('ITE_DESITE').AsString) > 0) And
                (btnAdicionar.Tag <= 0)                                                  Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido utilizar Item especial na Entrada de Mercadoria', ['&O k']);
          Result := False;
        End

        Else If fUsaRotinaWMS And Not objCadLot.fExisteLote(qryConCit.FieldByName('ITE_CODITE').AsString, VS_strCodEmp, 'A DEFINIR', False) And
        (Not ( Sametext(edtCodIte.Text, fCfgSis('ITESER', VarString)) Or
               Sametext(edtCodIte.Text, fCfgSis('SERTER', VarString)) Or
               Sametext(edtCodIte.Text, fCfgSis('PROMAT', VarString)) )) Then
        Begin
          pMensagemOk('Produto ' + qryConCit.FieldByName('ITE_CODITE').AsString + '-' +
            qryConCit.FieldByName('ITE_DESITE').AsString + ' não possui Lote A DEFINIR cadastrado!');
          Result := False;
        End

{        Else if ((qryConCit.FieldByName('ITE_CODITE').AsString = fCfgSis('ITESER')) Or
                (qryConCit.FieldByName('ITE_CODITE').AsString = fCfgSis('SERTER'))) And
                fVerificaItemServicoDivergenteJaUsado(qryConCit.FieldByName('ITE_CODITE').AsString) Then
        Begin
          pMensagemOk('Apenas um item serviço configurado pode ser usado ' +   fCfgSis('ITESER') + ' ou ' + fCfgSis('SERTER') +'.');
          Result := False
        end}

        Else If blnBuscaPorChave And fEmptyStr(edtNumLot.Text) And edtNumLot.Visible And (Not fUsaRotinaWMS) And
                (fRetReaEnd(qryConCit.FieldByName('ITE_CODITE').AsString) = 'S') And
                objCadLot.fExisteLote(qryConCit.FieldByName('ITE_CODITE').AsString, VS_strCodEmp, '', False) Then
         edtNumLot.Text := 'A DEFINIR'
        Else if (fCfgSis('MARMOR', varBoolean)) And fItemMarmore(qryConCit.FieldByName('ITE_CODITE').AsString) then
          edtNumLot.Text := 'A DEFINIR'
      End;

    End

    Else If (Sender = edtNumLot) Then
    Begin

      If edtNumLot.Visible Then
      Begin
        If fEmptyStr(edtNumLot.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe o número do ' + objCadLot.strTitLab + '!', ['&Ok']);
          Result := False;
        End

        Else If Not objCadLot.fExisteLote(edtCodIte.Text, VS_strCodEmp, edtNumLot.Text) Then
        Begin
          fMensagem('ATENÇÃO!', objCadLot.strTitLab + ' não encontrado!', ['&Ok']);
          Result := False;
        End

        Else If SameText(edtNumLot.Text, 'A DEFINIR') And (fRetReaEnd(edtCodIte.Text) = 'N') and (Not fItemMarmore(edtCodIte.Text))Then
        Begin
          fMensagem('ATENÇÃO!', 'O lote não pode ser "A DEFINIR" porque esse produto não realiza endereçamento!', ['&Ok']);
          Result := False;
        End

        Else If (SameText(edtNumLot.Text, 'A DEFINIR')) And (Not fItemMarmore(edtCodIte.Text)) And (blnDevolu) And (Not (fCfgSis('DEVEND', varBoolean))) And (Not fUsaRotinaWMS) Then
        Begin
          fMensagem('ATENÇÃO!', 'O lote não pode ser "A DEFINIR" porque entrada por devolução não realiza endereçamento!', ['&Ok']);
          Result := False;
        End

        Else
        Begin
          edtSaldo.Text  := FormatFloat('#,##0.000', objCadLot.qryCadLot.FieldByName('LOT_SALDOS').AsFloat);
        End;

      End;
    End

    Else If (Sender = edtQtdIte) Then
    Begin

      If blnPrecoPraticado Then
      Begin
        Result := True;
      End

      Else If (edtQtdIte.ReadOnly) Then
      Begin
        if blnRecCliGarantia Or blnGarantia or FblnAcessadoViaRetornoConsignacao Then
          Result := True
        Else
          Result := False;
      End
      Else If fEmptyStr(edtQtdIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Quantidade deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If fStrToFloat(edtQtdIte.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Quantidade deve ser maior que Zero!', ['&O k']);
        Result := False;
      End
      Else If (blnDevolu) And fEmptyStr(strAutDev) And (fltMaxDev > 0) And (fStrToFloat(edtQtdIte.Text) > fltMaxDev) Then
      Begin
        fMensagem('ATENÇÃO!', 'Em Devolução a quantidade não pode ser maior que o permitido.' + #13#10 +
                              'Quantidade máxima permitida deste item é de ' + FormatFloat('#,##0.00', fltMaxDev) + '!', ['&O k']);
        Result := False;
      End

      Else If (Not blnDevolu) Then
      Begin
        If btnAdicionar.Tag = 0 Then
          fltQtdAnt := 0;


        If (Not blnAltMai) And (Not fVerificaQuantidadeAMaior(edtCodIte.Text,
                                                              fStrToFloat(edtQtdIte.Text) * IIF(fStrToFloat(edtEmbala.Text) <> 0, fStrToFloat(edtEmbala.Text), 1),
                                                              fltQtdAnt,
                                                              Nil,
                                                              qryItePed,
                                                              fltQtdOri,
                                                              fltQtdNov)) Then
        Begin
          Result := False;

          If strCnvEmb = 'N' Then
            fMensagem('ATENÇÃO!', 'A quantidade total do item deve ser menor ou igual a ' + FormatFloat('#0.00', fltQtdOri) + '!', ['&O k'])
          Else
            fMensagem('ATENÇÃO!', 'A quantidade total do item multiplicada por sua embalagem deve ser menor ou igual a ' + FormatFloat('#0.00', fltQtdOri) + '!', ['&O k']);

        End;

        If fUsaRotinaWMS And fConferenciaDepoisDaEntrada And (strCnvEmb <> 'N') and ((Not fEmptyStr(recNotEle.strAutInc)) And (fltQtdXML > 0)) Then
        Begin
          If (RoundTo((fStrToFloat(edtQtdIte.Text) * fStrToFloat(edtEmbala.Text)), intDEQTPC *  -1))  <> RoundTo(fltQtdXML, intDEQTPC *  -1) Then
          Begin
            Result := False;
            fMensagem('ATENÇÃO!', 'A quantidade total do item multiplicada por sua embalagem deve ser igual a ' + FormatFloat('#0.00', fltQtdXML) + '!', ['&O k']);
          End;
        End;

      End;

    End

    Else If (Sender = edtUnitar) Then
    Begin
      If (edtUnitar.ReadOnly) Then
      Begin
        Result := False;
      End
      Else If fEmptyStr(edtUnitar.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor Unitário deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If fStrToFloat(edtUnitar.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor Unitário deve ser maior que Zero!', ['&O k']);
        Result := False;
      End;


    End

    Else If (Sender = edtTotIte) Then
    Begin

      If (edtTotIte.ReadOnly) Then
      Begin
        if blnRecCliGarantia Or blnGarantia or FblnAcessadoViaRetornoConsignacao Then
        Begin
          Result := True;
          pCalculaTotIte(edtTotIte);
        End
        Else
          Result := False;
      End;

    End

    Else If (Sender = edtClaIpi) Then
    Begin
      If (fEmptyStr(edtClaIpi.Text)) And (blnConEqu) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Classificação de IPI deve ser informada!', ['&OK']);
        Result := False;
      End
      Else If (Not fEmptyStr(edtClaIpi.Text)) And (Length(edtClaIpi.Text) <> MAX_CLAIPI) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Classificação de IPI deve ter ' + IntToStr(MAX_CLAIPI) +  ' caracteres!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodAbf) Then
    Begin

      If blnPrecoPraticado Then
      Begin
        Result := True;
      End

      Else If SameText(edtEspDoc.Text, 'NF') And ((edtCodAbf.Text <> strAbfAnt) Or fEmptyStr(edtCodAbf.Text))Then
      Begin
        If (edtCodAbf.ReadOnly) Then
        Begin
          Result := False;
        End
        Else
        If fEmptyStr(edtCodAbf.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O código da abreviação fiscal deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If (blnDevolu) Or (blnConEqu) Or blnLocEqu or (blnRecCliGarantia) or (FblnAcessadoViaRetornoConsignacao) Then
            strTipAbf := fGetTipoAbfCliente(strCodFor)
          Else
            strTipAbf := fGetTipoAbfFornecedor(strCodFor);

          pCarregaAbrevFiscal(blnBuscaPorChave, (edtCodAbf.Text <> strAbfAnt), edtCodIte.Text);
          If qryConAbf.FieldByName('ABF_CODABF').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa Abreviação Fiscal não está cadastrada!', ['&O k']);
            Result := False;
          End
          Else If (Not(fValidaCodAbf(qryConAbf.FieldByName('ABF_CODABF').AsString, strEstFor, strTipAbf, strCodSit))) Then
          Begin
            fMensagem('ATENÇÃO!','Essa Abreviação Fiscal está com o Código da Situação Tributária' + #13#10 + 
                                 'em branco para o Estado de ' + strEstFor + '.' +  #13#10 +
                                 'Favor corrigir o seu cadastro antes de continuar.', ['&O k']);
            Result := False;
          End
          Else If (Not fValidaCodTri(strCodSit)) Then
          Begin
            fMensagem('ATENÇÃO!','A Situação Tributária(' + strCodSit + ') dessa Abreviação Fiscal não está cadastrada.' + #13#10 +
                                 'Favor cadastrá-la na tela de cadastro de Situações Tributárias.', ['&O k']);
            Result := False;
          End
          Else If blnBuscaPorChave Then
          Begin

            If (btnAdicionar.Tag <= 0) Then
            Begin

              If SameText(strSugPen, '1') Then
              Begin
                If (fStrToFloat(edtAlqIPI.Text) > 0) And (fStrToFloat(edtBasIPI.Text) > 0) Then
                  edtBasIPI.Text := edtTotIte.Text;
              End
              Else
                edtBasIPI.Text := edtTotIte.Text;

            End;

          End;

        End;

        If Result Then
        Begin
          strAbfAnt := edtCodAbf.Text;
        End;

      End
      Else If SameText(edtEspDoc.Text, 'PD') Then
      Begin
        pCarregaAbrevFiscal(blnBuscaPorChave, (edtCodAbf.Text <> strAbfAnt));
        If Result Then
        Begin
          strAbfAnt := edtCodAbf.Text;
        End;
      End;
    End

    Else If (Sender = edtBasICM) Then
    Begin

      If blnPrecoPraticado Then
      Begin
        Result := True;
      End

      Else If (Not edtBasICM.ReadOnly) And blnBuscaPorChave Then
      Begin

        If fStrToFloat(edtBasICM.Text) < 0 Then
        Begin
          pMensagemOk('A Base de ICMS deve ser maior ou igual a zero!');
          Result := False;
        End  Else
        Begin
          edtValIcm.Text := FormatFloat('#0.00', fStrToFloat(edtBasICM.Text) * (fStrToFloat(edtAlqIcm.Text) / 100));
        End;

      End;

    End

    Else If (Sender = edtAlqIcm) Then
    Begin

      If blnPrecoPraticado Then
      Begin
        Result := True;
      End

      Else If (Not edtAlqIcm.ReadOnly) And blnBuscaPorChave Then
      Begin

        If fStrToFloat(edtAlqIcm.Text) < 0 Then
        Begin
          pMensagemOk('A Base de ICMS deve ser maior ou igual a zero!');
          Result := False;
        End  Else
        Begin
          If fStrToFloat(edtAlqIcm.Text) = 0 Then
            edtBasIcm.Text := FormatFloat('#0.00', 0);

          edtValIcm.Text := FormatFloat('#0.00', fStrToFloat(edtBasICM.Text) * (fStrToFloat(edtAlqIcm.Text) / 100));
        End;

      End;

    End

    Else If (Sender = edtBasIPI) Then
    Begin

      If blnPrecoPraticado Then
      Begin
        Result := True;
      End

      Else If (edtBasIPI.ReadOnly) Then
      Begin
        if blnRecCliGarantia Or blnGarantia or FblnAcessadoViaRetornoConsignacao Then
          Result := True
        Else
          Result := False;
      End
      Else If (fEmptyStr(edtBasIPI.Text))       Or
              (fStrToFloat(edtBasIPI.Text) <= 0) Then
      Begin

        edtBasIPI.Text    := '0,00';
        edtAlqIpi.Text    := '0,00';
        edtvalIpi.Text    := '0,00';
        edtvalIpi.Enabled := False;
        edtAlqIpi.Enabled := False;

      End
      Else
      Begin
        If fEmptyStr(recNotEle.strAutInc) Then
        Begin
          edtAlqIpi.Enabled := True;
          edtvalIpi.Enabled := True;
        End;
      End;
    End

    Else If (Sender = edtAlqIPI) Then
    Begin

      If blnPrecoPraticado Then
      Begin
        Result := True;
      End

      Else If (edtAlqIPI.ReadOnly) Then
      Begin
        if blnRecCliGarantia Or blnGarantia or FblnAcessadoViaRetornoConsignacao Then
          Result := True
        Else
          Result := False;
      End
      Else If (edtAlqIPI.Enabled) Then
      Begin

        If (fEmptyStr(edtAlqIPI.Text))       Or
           (fStrToFloat(edtAlqIPI.Text) <= 0) Then
        Begin
          edtAlqIPI.Text := '0,00';
          edtvalIpi.Text := '0,00';
          edtAlqIPI.SelectAll;
          Result := False;
        End
        Else
        Begin
          pCalculaValIpi;
        End;

      End;

    End

    Else If (Sender = edtUnidad) Then
    Begin

      If blnPrecoPraticado Then
      Begin
        Result := True;
      End

      Else If (Not fEmptyStr(edtCodIte.Text)) Then
      Begin

        If (fEmptyStr(edtUnidad.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A unidade deve ser preenchida!', ['&Ok']);
          Result := False;
        End
        Else If (fEmptyStr(fRetNomUnidade(edtUnidad.Text))) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa unidade não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If (Not fEmptyStr(fRetNomUnidade(edtUnidad.Text))) Then
        Begin
           edtSigla.Text := fRetSiglaUnidade(edtUnidad.Text);
           strCodUni     := edtUnidad.Text;
        End;

      End;
    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmEntMercadorias.pCarregaFornecedor(blnValidaPlanoDeContas: Boolean = True);
  Var
    arrCta: TConsultasArray;
    chrKey: Char;
    qryCta: TUniQuery;
    recDadFor: TRecDadosFornecedor;
begin
  recDadFor.strCodFor := edtCodFor.Text;

  TEntradaAutomatizada.pCarregaFornecedor(qryConCli, recDadFor);

  strCodFor := recDadFor.strCodFor;
  blnSimPau := recDadFor.blnSimPau;
  blnPeIcms := recDadFor.blnPeIcms;
  blnZonFra := recDadFor.blnZonFra;
  blnForSta := recDadFor.blnForSta;
  blnForFil := recDadFor.blnForFil;

  strEstFor := recDadFor.strEstFor;
  strCgcCpf := recDadFor.strCgcCpf;
  strTipCgcCpf := recDadFor.strTipCgcCpf;
  strIesFor := recDadFor.strIesFor;
  strTipFor := fBuscaMatRevGerele(edtNumDoc.Text, edtEspDoc.Text, edtSerie.Text, VS_strCodEmp, edtCodFor.Text, False);



  With qryConCli Do
  Begin
    edtCgcCpf.Text    := fFormataCpfCgc(FieldByName('FOR_C_G_C_').AsString, FPais);
    lblCgcCpf.Caption := recDadFor.strCgcCpfLablel;
    edtNomFor.Text    := recDadFor.strNomFor;

    If blnExbObsFornecedor Then
      mmoObsFornecedor.Lines.Text := AnsiReplaceStr(qryConCli.FieldByName('FOR_OBSERV').AsString, '<<csq>>', #13#10);

    If fEmptyStr(recNotEle.strAutInc) And  (stlPedidos.Count <= 0)  then
      strPagFor      := qryConCli.FieldByName('FOR_CNDPAG').AsString
    Else
      strPagFor := '';

    If blnValidaPlanoDeContas Then
    Begin
      If fCfgSis('USACTF', varBoolean) And (Not blnFulfillment) And
         fEmptyStr(fCampoTabela('CTF_CODCTA', 'CTAFOR', ['CTF_CODCTA', 'CTF_CODFOR'], [strCtaPed, edtCodFor.Text])) Then
      Begin

        fMensagem('', 'Selecione um Plano de Contas!', ['&O K']);


        qryCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE');

        chrKey := '/';

        If  fPesqCentroCusto(Self, Nil, Nil, qryCta, chrKey, arrCta, True, True, edtCodFor.Text) Then
        Begin
          strCodCta := qryCta.FieldByName('CTA_CODCTA').AsString;
          If Not PlanoDeContasAtivo(strCodCta) Then
            strCodCta := ''
        End
        Else
          strCodCta := '';


      End Else
      Begin

        If fEmptyStr(strCtaPed) Then
        Begin

          strCodCta := FieldByName('FOR_CODCTA').AsString;

        End;

      End;
    End;

  End;
end;

function TfrmEntMercadorias.fVerificaDocumentoExiste: Boolean;
  Var
    strSQL   : String;
    qryGenGer: TUniQuery;
begin
  Try

    Result := False;

    qryGenGer := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  GER_NUMDOC ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  IFNULL(GER_SERIE_, "") = :SERIE_ AND ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';

    If (blnDevolu) Or (blnRecCliGarantia) Or (blnConEqu) Or (blnLocEqu) or (FblnAcessadoViaRetornoConsignacao) Then
      strSQL := strSQL + '  GER_CODCLI = :CODFOR '
    Else
      strSQL := strSQL + '  GER_CODFOR = :CODFOR ';

    With qryGenGer Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := edtNumDoc.Text;
      ParamByName('ESPDOC').AsString := edtEspDoc.Text;
      ParamByName('SERIE_').AsString := edtSerie.Text;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODFOR').AsString := edtCodFor.Text;
      Open;

      If IsEmpty Then
      Begin
        Close;
        ParamByName('SERIE_').AsString := RightStr('000' + edtSerie.Text, 3);
        Open;
      End;

      If Not IsEmpty Then
        Result := True;

      Close;

      If (not Result) and (not blnDevolu) And (Not blnConEqu) And (Not blnLocEqu) Then
      Begin

        strSQL := '';
        strSQL := strSQL + 'SELECT ';
        strSQL := strSQL + '  GER_CLAFIS, IMP_PERFIL ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  NOTGER ';
        strSQL := strSQL + '    INNER JOIN NOTDET ON DET_SEQGER = NOTGER.AUTOINCREM ';
        strSQL := strSQL + '    LEFT JOIN DOCIMP ON IMP_SEQDET = NOTDET.AUTOINCREM ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
        strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
        strSQL := strSQL + '  IFNULL(GER_SERIE_, "") = :SERIE_ AND ';
        strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '  GER_CODFOR = :CODFOR ';

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := RightStr(edtNumDoc.Text, edtNumDoc.TamCampo);
        ParamByName('ESPDOC').AsString := edtEspDoc.Text;
        ParamByName('SERIE_').AsString := edtSerie.Text;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODFOR').AsString := edtCodFor.Text;
        Open;

        If IsEmpty Then
        Begin
          Close;
          ParamByName('SERIE_').AsString := RightStr('000' + edtSerie.Text, 3);
          Open;
        End;

        blnNotaImp := Not IsEmpty and (LeftStr(FieldByName('GER_CLAFIS').AsString, 1) = '3');
        blnEncargosNoFrete := (fCfgSis('ENCIMP') = '2') And blnNotaImp;

        If Not blnNotaImp Then
          blnEncargosNoFrete := fCfgSis('OUDVFR', varBoolean);
        If blnNotaImp then
        begin
          PerfilDespachanteAduaneiro := TPerfilDespachanteAduaneiro.Create(Self);
          If not fEmptyStr(qryGenGer.FieldByName('IMP_PERFIL').AsString) then
            PerfilDespachanteAduaneiro.CodigoPerfil := qryGenGer.FieldByName('IMP_PERFIL').AsString
          Else
            PerfilDespachanteAduaneiro.pSetaPerfilDefault;
        end;

      End;


    End;

  Finally
    FreeAndNil(qryGenGer);
  End;

end;

procedure TfrmEntMercadorias.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) And (Not edtCodFor.ReadOnly) Then
  Begin

    Key := #0;

    If (blnDevolu) Or (blnRecCliGarantia) Or (blnConEqu) Or (blnLocEqu) or (FblnAcessadoViaRetornoConsignacao) Then
      pConsultaCadCli
    Else
      pConsultaCadFor;

  End;
end;

function TfrmEntMercadorias.fAvisarDataDocumentoMaiorQueDataEntrada: Boolean;
begin
  fMensagem('', 'A Data do Documento não pode ser maior que Data de Entrada!', ['&O k']);
  pHabilitaCampos(pnlCabecalho, True);
  pHabilitaCampos(pnlItem, False);
  dbgItensGrid.Enabled := False;
  Result := False;
end;

{*****************************************}
{* CALCULA DADOS FISCAIS E PRECOS DE UM  *}
{* PEDIDO DE COMPRA                      *}
{**************************************MV*}
function TfrmEntMercadorias.fCalculaItensPedido(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strClaFisLocal: String;
    strCodFis: String;
    blnComLub: Boolean;
    fltVlrCon: Double;
    fltPerBas: Double;
    fltPeBaST: Double;
    fltBasIcm: Double;
    fltAlqIcm: Double;
    fltAlqIcmRed: Double;
    fltValIcm: Double;

    fltBasIpi: Double;
    fltAlqIpi: Double;
    fltValIpi: Double;

    fltIsento: Double;
    fltBasRet: Double;
    fltValRet: Double;
    fltBasAnt: Double;
    fltValAnt: Double;
    fltOutras: Double;
    fltVFCPST: Double;

    fltValIVA: Double;

    fltPreCom: Double;
    fltPreCus: Double;

    recPrecos: Array[1..7] Of TRecPrecos;


    fltPERFCP,
    fltVALFCP,
    fltVBCFCP,


    fltBkp_BasIcm: Double;
    fltBkp_AlqIcm: Double;
    fltBkp_ValIcm: Double;

    fltMarMin: Double;
    fltMarMSG: Double;
    fltMarMGe: Double;

    strEmpEst: String;
    strTipAbf: String;
    blnContribuinteIPI: Boolean;

    strSQL   : String;
    strUpd   : String;
    qryGenMer: TUniQuery;
    qryPcmDet: TUniQuery;
    strIteSer: String;
    strSerTer: String;
    strDESMAR: String;


    blnRedCargaMedia: Boolean;
    cpcParams: TParCalculaPrecoCusto;
    blnIsentas,
    blnSubstituido: Boolean;
    blnAntecipado : Boolean;

    IntCont: Integer;

    fltBasPis,
    fltBasCof,
    fltTotPis,
    fltTotCof,
    fltPerPis,
    fltPerCof: Double;
    blnCREIPI,
    blnCLASUB: Boolean;
    tmp: TCalculoPisCofins;
    CalcResult: TResultPisCofins;
    strSitP_C: String;

    function fTempEnt(strCampo: String): TField;
    begin
      Result := qryEntMer.FieldByName('ENT_' + strCampo);
    end;

    function fZeraICMSDevolucao: Boolean;
    Begin
      Result := fCfgSis('IMPDIR') = 'N';
      If  fCfgSis('IMPDIR') = 'S'  Then
        Result := qryEntMer.FieldbyName('ENT_IMPDIR').AsString = 'N'
    End;

begin

  cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);
  qryGenMer := fCriaQuery(Self);

  Try
    strIteSer := fCfgSis('ITESER');
    strSerTer := fCfgSis('SERTER');
    blnCREIPI := fCfgSis('CREIPI', varBoolean);
    blnCLASUB := fRegimeSubstituicaoTributaria = '2';

    strTipFor := fBuscaMatRevGerele(edtNumDoc.Text, edtEspDoc.Text, edtSerie.Text, VS_strCodEmp, edtCodFor.Text, False);
    strSitP_C := fDefineSit_P_C(VS_strCodEmp, strCodFor);

    {**********************************************}
    {* EFETUA O LINK COM O TMP_CODACA             *}
    {*******************************************GB*}
    if stlPedidos.Count > 0 then
    Begin
      qryPcmDet := fCriaQuery(Self);
      With qryPcmDet, Sql do
      Begin
        Add(' SELECT           ');
        Add('   PCD_CODACA,    ');
        Add('   PCD_EMPACA,    ');
        Add('   IF(PCD_CODACA = "" OR PCD_CODACA IS NULL, "N", "S") AS PCD_PROACA , ');
        Add('   AG.ACA_SALDOS, ');
        Add('   AG.ACA_PRECUS, ');
        Add('   AC.ACA_DESCRI  ');
        Add(' FROM PCMDET      ');

        Add('  LEFT JOIN ACAGER AG ON AG.ACA_CODACA = PCD_CODACA AND ');
        Add('                         AG.ACA_CODEMP = PCD_EMPACA AND ');
        Add('                         AG.ACA_EMPEST = PCD_CODEMP     ');

        Add('  LEFT JOIN CADACA AC ON AC.ACA_CODACA = PCD_CODACA     ');
        Add('                     AND AC.ACA_CODEMP = PCD_EMPACA     ');

        Add(' WHERE ( ');

        For IntCont := 0 to stlPedidos.Count -1 do
        Begin
          Add(' ( ');
          Add(' PCD_NUMPED = "' + LeftStr(stlPedidos[IntCont], fTamDocCadRec())  + '" AND ');
          Add(' PCD_CODEMP = "' + RightStr(stlPedidos[IntCont],3) + '"     ');
          Add(' ) ');
          if IntCont < stlPedidos.Count -1 then
            Add(' OR ');
        End;
        Add(' ) ');
        Add('   AND PCD_DESITE = :DESITE ')

      End;
    End;

    strEmpEst          := fCadEmp('ESTADO');
    blnContribuinteIPI := (fCfgSis('CONIPI', varBoolean));

    If Not fTabelaExiste('TMP_ENTMER') Then
    Begin
      Result := False;
      Exit;
    End;

      Result := True;

    strUpd := '';
    strUpd := strUpd + 'UPDATE ';
    strUpd := strUpd + '  TMP_ENTMER ';
    strUpd := strUpd + 'SET ';
    strUpd := strUpd + '  ENT_CLAFIS = :CLAFIS, ';
    strUpd := strUpd + '  ENT_CODFIS = :CODFIS, ';
    strUpd := strUpd + '  ENT_PREEM1 = :PREEM1, ';
    strUpd := strUpd + '  ENT_PREEM2 = :PREEM2, ';
    strUpd := strUpd + '  ENT_PREEM3 = :PREEM3, ';
    strUpd := strUpd + '  ENT_PREEM4 = :PREEM4, ';
    strUpd := strUpd + '  ENT_PREEM5 = :PREEM5, ';
    strUpd := strUpd + '  ENT_PREEM6 = :PREEM6, ';
    strUpd := strUpd + '  ENT_PREEM7 = :PREEM7, ';

    strUpd := strUpd + '  ENT_VLRCON = :VLRCON, ';
    strUpd := strUpd + '  ENT_PERBAS = :PERBAS, ';
    strUpd := strUpd + '  ENT_BASICM = :BASICM, ';
    strUpd := strUpd + '  ENT_ALQICM = :ALQICM, ';
    strUpd := strUpd + '  ENT_VALICM = :VALICM, ';

    strUpd := strUpd + '  ENT_BASIPI = :BASIPI, ';
    strUpd := strUpd + '  ENT_ALQIPI = :ALQIPI, ';
    strUpd := strUpd + '  ENT_VALIPI = :VALIPI, ';

    strUpd := strUpd + '  ENT_BAEIPI = :BASIPI, ';
    strUpd := strUpd + '  ENT_ALEIPI = :ALQIPI, ';
    strUpd := strUpd + '  ENT_VAEIPI = :VALIPI, ';

    strUpd := strUpd + '  ENT_IPISUB = :VALIPI, ';
    strUpd := strUpd + '  ENT_ISENTO = :ISENTO, ';
    strUpd := strUpd + '  ENT_PEBAST = :PEBAST, ';
    strUpd := strUpd + '  ENT_BASRET = :BASRET, ';
    strUpd := strUpd + '  ENT_VALRET = :VALRET, ';
    strUpd := strUpd + '  ENT_RETORI = :VALRET, ';

    strUpd := strUpd + '  ENT_BAERET = :BAERET, ';
    strUpd := strUpd + '  ENT_VAERET = :VAERET, ';

    strUpd := strUpd + '  ENT_BASANT = :BASANT, ';
    strUpd := strUpd + '  ENT_VALANT = :VALANT, ';

    strUpd := strUpd + '  ENT_OUTRAS = :OUTRAS, ';
    strUpd := strUpd + '  ENT_MARMIN = :MARMIN, ';
    strUpd := strUpd + '  ENT_MARMSG = :MARMSG, ';
    strUpd := strUpd + '  ENT_MARMGE = :MARMGE, ';

    strUpd := strUpd + '  ENT_CLAIPI = :CLAIPI, ';
    strUpd := strUpd + '  ENT_CDCEST = :CDCEST, ';

    strUpd := strUpd + '  ENT_CODACA = :CODACA, ';
    strUpd := strUpd + '  ENT_EMPACA = :EMPACA, ';
    strUpd := strUpd + '  ENT_PROACA = :PROACA, ';
    strUpd := strUpd + '  ENT_SALACA = :SALACA, ';
    strUpd := strUpd + '  ENT_PREACA = :PREACA, ';
    strUpd := strUpd + '  ENT_DESACA = :DESACA, ';
    strUpd := strUpd + '  ENT_DESITE = :DESITE, ';
    strUpd := strUpd + '  ENT_RICMPR = :RICMPR, ';

    strUpd := strUpd + '  BKP_BASICMS = :BKP_BASICMS, ';
    strUpd := strUpd + '  BKP_ALQICMS = :BKP_ALQICMS, ';
    strUpd := strUpd + '  BKP_VALICMS = :BKP_VALICMS, ';

    strUpd := strUpd + '  ENT_PERFCP = :PERFCP, ';
    strUpd := strUpd + '  ENT_VALFCP = :VALFCP, ';
    strUpd := strUpd + '  ENT_VBCFCP = :VBCFCP, ';
    strUpd := strUpd + '  ENT_DESMAR = :DESMAR ';

    If blnDevolu And (fCfgSis('ICMCDV', varBoolean)) Then
    Begin
      strUpd := strUpd + '  ,ENT_ALQPIS = IFNULL(:ALQPIS, ENT_ALQPIS)  ';
      strUpd := strUpd + '  ,ENT_BASPIS = IFNULL(:BASPIS, ENT_BASPIS)  ';
      strUpd := strUpd + '  ,ENT_VALPIS = IFNULL(:VALPIS, ENT_VALPIS)  ';
      strUpd := strUpd + '  ,ENT_ALQCOF = IFNULL(:ALQCOF, ENT_ALQCOF)  ';
      strUpd := strUpd + '  ,ENT_BASCOF = IFNULL(:BASCOF, ENT_BASCOF)  ';
      strUpd := strUpd + '  ,ENT_VALCOF = IFNULL(:VALCOF, ENT_VALCOF)  ';
    End;

    If (fCfgSis('ATPRAU', varBoolean)) And ((Pos(edtCodFor.Text, fRetForFilialTodos) = 0) Or (fCfgSis('ATPREN', varBoolean))) Then
    Begin
      strUpd := strUpd + '  ,ENT_PRECOM = :PRECOM, ';
      strUpd := strUpd + '  ENT_PRECUS = :PRECUS, ';
      {*******************************************}
      {* VERIFICA SE ALTERA PREÇO DE VENDA OU    *}
      {* MARGEM BRUTA                            *}
      {****************************************MV*}
      For IntCont := 1 To Length(recPrecos) Do
      Begin

        strUpd := strUpd + '  ENT_COMTB' + IntToStr(IntCont) + ' = :COMTB' + IntToStr(IntCont) + ', ';

        If (Not blnFatPre) Or (intCont = 1) Then
        Begin
          If blnAtpVmb[IntCont] Then
            strUpd := strUpd + '  ENT_PREVE' + IntToStr(IntCont) + ' = :PREVE' + IntToStr(IntCont) + ', '
          Else
            strUpd := strUpd + '  ENT_MARBR' + IntToStr(IntCont) + ' = :MARBR' + IntToStr(IntCont) + ', ';
        End Else
        Begin
          strUpd := strUpd + '  ENT_PREVE' + IntToStr(IntCont) + ' = :PREVE' + IntToStr(IntCont) + ', ';
          strUpd := strUpd + '  ENT_MARBR' + IntToStr(IntCont) + ' = :MARBR' + IntToStr(IntCont) + ', ';
        End;

        If IntCont = Length(recPrecos) Then
          strUpd := Copy(strUpd, 1, Length(strUpd) - 2);
      End;
    End;

    strUpd := strUpd + ' ';
    strUpd := strUpd + 'WHERE ';
    strUpd := strUpd + '  ENT_CODITE = :CODITE AND ';
    strUpd := strUpd + '  ENT_NUMPED = :NUMPED AND ';
    strUpd := strUpd + '  AUTOINCREM = :AUTOINCREM ';

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  TMP_ENTMER ';
    if Not fEmptyStr(strOrdIte) Then
      strSQL := strSQL + 'ORDER BY ' + strOrdIte;

    With qryEntMer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      strMatRev :=  qryEntMer.FieldByName('ENT_MATREV').AsString;

      pgbCalculoFiscal.Visible  := True;
      pgbCalculoFiscal.Position := 0;
      pgbCalculoFiscal.Max      := RecordCount;

      If (blnDevolu) Or (blnConEqu) Or blnLocEqu or (blnRecCliGarantia) or (FblnAcessadoViaRetornoConsignacao) Then
        strTipAbf := fGetTipoAbfCliente(strCodFor)
      Else
        strTipAbf := fGetTipoAbfFornecedor(strCodFor);
      If Assigned(pgbProgresso) Then
        pgbProgresso.Properties.Max := qryEntMer.RecordCount;

      While Not (Eof) And (Result) Do
      Begin
        fltValIVA := fRetornaPercIVA(FieldByName('ENT_CODABF').AsString,strEstFor,strTipAbf);

        fltBasIpi := 0.0;
        fltAlqIpi := FieldByName('ENT_PERIPI').AsFloat;
        fltValIpi := 0.0;

        fltBasRet := 0.0;

        fltBasAnt := 0.0;
        fltValAnt := 0.0;

        fltMarMin := FieldByName('ENT_MARMIN').AsFloat;
        fltMarMSG := FieldByName('ENT_MARMSG').AsFloat;
        fltMarMGe := FieldByName('ENT_MARMGE').AsFloat;

        fltPERFCP := FieldByName('ENT_PERFCP').AsFloat;
        fltVALFCP := FieldByName('ENT_VALFCP').AsFloat;
        fltVBCFCP := FieldByName('ENT_VBCFCP').AsFloat;
        strDESMAR := FieldByName('ENT_DESMAR').AsString;
        

        fltVlrCon := FieldByName('ENT_TOTITE').AsFloat;

        If Not SameText(edtEspDoc.Text, 'NF') Then
        Begin
          fltAlqIpi := 0;
        End;

        If (fltAlqIpi > 0.0) Or ((Not fEmptyStr(recNotEle.strAutInc)) And SameText(edtEspDoc.Text, 'NF')) Or
           (blnDevolu And blnPrecoPraticado) Then
        Begin
          {*****************************************}
          {* CASO FOR NOTA ELETRONICA, PEGA A BASE *}
          {* DE IPI DO ARQUIVO XML.                *}
          {**************************************MV*}
          If (Not fEmptyStr(recNotEle.strAutInc)) Or (blnDevolu And blnPrecoPraticado) Then
          Begin
            fltBasIpi := FieldByName('ENT_BASIPI').AsFloat
          End Else
          Begin
            fltBasIpi := FieldByName('ENT_TOTITE').AsFloat;
          End;

          fltValIpi := FieldByName('ENT_VALIPI').AsFloat;
        End;
        blnComLub := fCampotabela('ITE_COMLUB', 'CADITE', ['ITE_CODITE'], [qryEntMer.FieldByname('ENT_CODITE').AsString]) = 'S';
        If fRetornaDadosFiscais(strEmpEst,
                                blnContribuinteIPI,
                                FieldbyName('ENT_ANTPRO').AsString = 'S',
                                FieldByName('ENT_CODABF').AsString,
                                fltVlrCon,
                                fltAlqFor,
                                strEstFor,
                                strCodFor,
                                fItemRevInd(qryEntMer.FieldByname('ENT_CODITE').AsString, VS_StrCodEmp) = 'R',
                                strClaFisLocal,
                                strCodFis,
                                fltBasIcm,
                                fltAlqIcm,
                                fltAlqIcmRed,
                                fltValIcm,
                                fltPerBas,
                                fltPeBaST,
                                fltAliSte,
                                fltAliFCP,
                                blnRedCargaMedia,
                                blnDevolu,
                                True,
                                blnGarantia,
                                blnRecCliGarantia,
                                blnNotaImp,
                                qryEntMer.FieldByName('ENT_I08CFO').AsString,
                                blnConEqu Or blnLocEqu,
                                ((qryEntMer.FieldByName('ENT_INDPRES').AsInteger = 1) Or (qryEntMer.FieldByName('ENT_IDDEST').AsInteger = 1) Or (blnPresencial)),
                                nil,
                                FblnAcessadoViaRetornoConsignacao,
                                blnComLub,
                                recNotEle.finalidadeXML = xmlDevolucaoEntradaEmitidaFornecedor) Then
        Begin
          blnRedIcmsParana := fltAlqIcmRed > 0;

          If (FieldByName('ENT_CODITE').AsString = strIteSer) Or
             (FieldByName('ENT_CODITE').AsString = strSerTer) Or
             (FieldByName('ENT_TIPPRO').AsString = TIPO_PRODUTO_SPED[9,0]) Then
              strClaFisLocal := strClaFisLocal[1] + '933'
          Else
            If (strTipFor = 'M') And (Not fEmptyStr(strClaFisLocal)) Then
          Begin

            If (qryEntMer.FieldByName('ENT_VALRET').AsFloat + qryEntMer.FieldByName('ENT_VAERET').AsFloat) > 0 Then
              strClaFisLocal := strClaFisLocal[1] + strConSub
            Else
              strClaFisLocal := strClaFisLocal[1] + strConCla;

          End;

          If (Not fEmptyStr(recNotEle.strAutInc)) Then
          Begin
            If (Not fEmptyStr(recNotEle.strClaBri)) And (String(qryEntMer.FieldByName('ENT_I08CFO').AsString).Substring(1,3) = '910') Then
              strClaFisLocal := recNotEle.strClaBri;

            If (strTipFor <> 'M') And
               (Not (Pos(qryEntMer.FieldByName('ENT_SITXML').AsString, '_201_202_101_102') > 0)) And
               ((Not ((fCfgSis('SIMPAU',varBoolean)) And (fCfgSis('IGNSIM') = '1'))) Or (Not (Pos(qryEntMer.FieldByName('ENT_SITXML').AsString, '500') > 0))) And
               (qryEntMer.FieldByName('ENT_CSTCAD').AsString = 'N') Then
              strCodFis := qryEntMer.FieldByName('ENT_SITXML').AsString;
          End;

          If fEhRetornoGarantiaFornecedorInterno Then
          Begin
            strCodFis := '041';

            fltPerBas := 0.0;
            fltBasIcm := 0.0;
            fltAlqIcm := 0.0;
            fltValIcm := 0.0;

            fltPERFCP := 0.0;
            fltVALFCP := 0.0;
            fltVBCFCP := 0.0;


            fltPeBaST := 0.0;
            fltBasRet := 0.0;
            //fltValRet := 0.0;

            if FieldByName('ENT_VALIPI').AsFloat > 0 then
            begin
              if blnManterIpi then
              begin
                fltValIpi := (fltBasIpi * fltAlqIpi) / 100;
              end;
            end;

            if Not blnManterIpi then
            begin
              fltBasIpi := 0.0;
              fltAlqIpi := 0.0;
              fltValIpi := 0.0;
            end;
          End;

          {*****************************************}
          {* CASO FOR NOTA ELETRONICA, PEGA A BASE *}
          {* DE IPI DO ARQUIVO XML.                *}
          {**************************************LA*}
          fltBkp_BasIcm := 0;
          fltBkp_AlqIcm := 0;
          fltBkp_ValIcm := 0;
          If (Not fEmptyStr(recNotEle.strAutInc)) Or (blnDevolu And blnPrecoPraticado) Then
          Begin

            If (fCfgSis('SIMPAU',varBoolean)) And
               (fCfgSis('IGNSIM') = '1') Then
            Begin
              fltBkp_BasIcm := FieldByName('ENT_BAIXML').AsFloat;
              fltBkp_AlqIcm := FieldByName('ENT_ALIXML').AsFloat;
              fltBkp_ValIcm := FieldByName('ENT_ICMXML').AsFloat;

              fltBasIcm := 0.00;
              fltAlqIcm := 0.00;
              fltValIcm := 0.00;
              fltPERFCP := 0.0;
              fltVALFCP := 0.0;
              fltVBCFCP := 0.0;
            End
            Else
            Begin
              fltBasIcm := FieldByName('ENT_BASICM').AsFloat;
              fltAlqIcm := FieldByName('ENT_ALQICM').AsFloat;
              fltValIcm := FieldByName('ENT_VALICM').AsFloat;

              {Req 296281}
              If (Not fEmptyStr(recNotEle.strAutInc)) And
                 (Not ((blnDevolu) Or (blnRecCliGarantia) Or (blnConEqu) or (FblnAcessadoViaRetornoConsignacao))) And
                 (blnSimPau)      And // Fornecedor Simples
                 (blnPeIcms)      And // Forneceedor Permitir Creditar ICMS
                 (fltBasIcm > 0)  And // Tem base de icms
                 (fltValIcm = 0) Then // Mas não tem valor de icms na nota
               Begin
                 fltBasIcm := 0;
               End;
            End;

          End;

          If (edtEspDoc.Text = 'PD') and blnBonificacao Then
            strClaFisLocal := strClaFisLocal[1] + '910';

          {*****************************************}
          {* CALCULA BASE RETIDO                   *}
          {**************************************MV*}
          blnSubstituido := False;
          If Pos(strCodFis,CST_SUBSTITUICAO) > 0 Then
          Begin
            fltBasRet := fFormataFloat(((((fltValIpi + fltVlrCon) * fltPeBaST) / 100) * fltValIVA), 2);
            blnSubstituido := True;
          End;

          fltValRet := fRetornaValRet(strEmpEst, fltBasRet, fltValIcm, fltAliSte);

          If (Not fEmptyStr(recNotEle.strAutInc)) Or (blnDevolu And blnPrecoPraticado) Then
          Begin
            fltBasRet := FieldByName('ENT_BASRET').AsFloat;
            fltValRet := FieldByName('ENT_VALRET').AsFloat;
          End;

          blnAntecipado := False;
          If blnDevolu Then
          Begin
            If blnSubstituido And fZeraICMSDevolucao And (fEmptyStr(strDocSel))Then
            Begin
              fltPerBas := 0.0;
              fltBasIcm := 0.0;
              fltAlqIcm := 0.0;
              fltValIcm := 0.0;
              fltPERFCP := 0.0;
              fltVALFCP := 0.0;
              fltVBCFCP := 0.0;
            End;
          End
          Else
          If (blnSubstituido Or blnAntecipado or ((blnSimPau) and Not(blnPeIcms))) Then
          Begin
            fltPerBas := 0.0;
            fltBasIcm := 0.0;
            fltAlqIcm := 0.0;
            fltValIcm := 0.0;
            fltPERFCP := 0.0;
            fltVALFCP := 0.0;
            fltVBCFCP := 0.0;
          End;

          {*****************************************}
          {* CALCULA VALOR DE 'OUTRAS/ISENTAS'     *}
          {*****************************************}
          fltVFCPST := FieldByName('ENT_VFCPST').AsFloat;

          fltClcAux:=fRetornaValorOutras(fltVlrCon, fltBasIcm, fltValIpi, fltValRet, 0, 0, fltVFCPST);

          fltPreCom := fTempEnt('UNITAR').AsFloat;

          {**********************************}
          {* CALCULA PREÇOS DE CUSTO        *}
          {*******************************JB*}
          With cpcParams Do
          Begin
            curPreCom := fltPreCom;
            curDesF01 := fTempEnt('DESF01').AsFloat;
            curDesF02 := fTempEnt('DESF02').AsFloat;
            curDesF03 := fTempEnt('DESF03').AsFloat;
            curDesF04 := fTempEnt('DESF04').AsFloat;
            curDesF05 := fTempEnt('DESF05').AsFloat;
            curDesF06 := fTempEnt('DESF06').AsFloat;
            curICMSEnt:= fTempEnt('ICMENT').AsFloat;
            curIPIEnt := fTempEnt('IPIENT').AsFloat;
            curFrete  := fTempEnt('FREENT').AsFloat;
            curValFre := fTempEnt('FREITE').AsFloat;
            curAcrFin := fTempEnt('ACRFIN').AsFloat;
            curSubsti := fTempEnt('SUBSTI').AsFloat;
            curDesAdb := fTempEnt('DESADB').AsFloat;
            curSubFed := fTempEnt('SUBFED').AsFloat;

            if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
            begin
              curTCIFCu := fTempEnt('TCIFCU').AsFloat;
              curTSCust := fTempEnt('TSCUST').AsFloat;
              curDePiCo := fTempEnt('DEPICO').AsFloat;
              curDeICMS := fTempEnt('DEICMS').AsFloat;
              curFatReg := fTempEnt('FATREG').AsFloat;
            end
            else
            begin
              curTCIFCu := 0;
              curTSCust := 0;
              curDePiCo := 0;
              curDeICMS := 0;
              curFatReg := 0;
            end;
          End;

          fltPreCus := cpcParams.fCalculaPrecoCusto();

          For IntCont := 1 To Length(recPrecos) Do
          Begin
            recPrecos[IntCont].blnEmbala := False;

            recPrecos[IntCont].fltComiss := fTempEnt('COMTB' + IntToStr(IntCont)).AsFloat;

            {*******************************************}
            {* CALCULA OS NOVOS PREÇOS DE VENDA        *}
            {****************************************MV*}
            If ((Not blnFatPre) Or (blnFatPre And (Not objFatPre.fTabelaAtiva(IntCont)))) Or (IntCont = 1) Then
            Begin
              recPrecos[IntCont].blnEmbala := True;

              recPrecos[IntCont].fltPreVen := fCalculaPrecoVenda(1,
                                                                 fltPreCus + fTempEnt('OUTVAL').AsFloat,
                                                                 0,
                                                                 fTempEnt('MARBR' + IntToStr(IntCont)).AsFloat,
                                                                 fTempEnt('ICMSAI').AsFloat,
                                                                 fTempEnt('IMPFED').AsFloat,
                                                                 fTempEnt('DESOPE').AsFloat,
                                                                 recPrecos[IntCont].fltComiss);


            End Else
            Begin
                recPrecos[IntCont].fltPreVen := objFatPre.fCalculaPrecoVendaFator(recPrecos[1].fltPreVen, intCont);
            End;

            {*******************************************}
            {* CALCULA AS NOVAS MARGENS BRUTAS         *}
            {****************************************MV*}
            If ((Not blnFatPre) Or (blnFatPre And (Not objFatPre.fTabelaAtiva(IntCont)))) Or (IntCont = 1) Then
              recPrecos[IntCont].fltMarBru := fCalculaPrecoVenda(2,
                                                                 fltPreCus + fTempEnt('OUTVAL').AsFloat,
                                                                 recPrecos[IntCont].fltPreVen * fTempEnt('EMBALA').AsFloat,
                                                                 0,
                                                                 fTempEnt('ICMSAI').AsFloat,
                                                                 fTempEnt('IMPFED').AsFloat,
                                                                 fTempEnt('DESOPE').AsFloat,
                                                                 recPrecos[IntCont].fltComiss)
            Else
              recPrecos[IntCont].fltMarBru := fCalculaPrecoVenda(2,
                                                                 fltPreCus + fTempEnt('OUTVAL').AsFloat,
                                                                 recPrecos[IntCont].fltPreVen,
                                                                 0,
                                                                 fTempEnt('ICMSAI').AsFloat,
                                                                 fTempEnt('IMPFED').AsFloat,
                                                                 fTempEnt('DESOPE').AsFloat,
                                                                 recPrecos[IntCont].fltComiss);
          End;

          Try

            qryGenMer.Close;
            qryGenMer.SQL.Clear;
            qryGenMer.SQL.Add(strUpd);

            {*****************************************}
            {* DADOS QUE SERÃO ATUALIZADOS           *}
            {**************************************MV*}
            If fValorTabelaCFOPEntrada(qryEntMer.FieldByName('ENT_I08CFO').AsString,
                                   strCodFis,
                                   qryEntMer.FieldByName('ENT_TIPPRO').AsString,
                                   strClaFisLocal) and (Not fEntPedidoPorGarantia) then
                qryGenMer.ParamByName('CLAFIS').AsString := strClaFisLocal
            Else
            Begin
              if fEntPedidoPorGarantia then
                 qryGenMer.ParamByName('CLAFIS').AsString := FClaFisEntPorGarantia
              else If blnGarantia Or blnRecCliGarantia Then
              Begin
                If (Pos(strCodFis, CST_SUBSTITUICAO) > 0) Then
                begin
                  if blnRecCliGarantia And fEmptyStr(strClaFisSub) then
                    qryGenMer.ParamByName('CLAFIS').AsString := strClaFisGar
                  else
                    qryGenMer.ParamByName('CLAFIS').AsString := strClaFisSub;
                end
                Else
                  qryGenMer.ParamByName('CLAFIS').AsString := strClaFisGar;
              End
              Else
                qryGenMer.ParamByName('CLAFIS').AsString := strClaFisLocal;
            End;

            If objExcecaoCfopCst.fExcecaoDefinida(strClaFisLocal, strCodFis) Then
              blnIsentas := objExcecaoCfopCst.blnIsentas
            Else
              blnIsentas := fCodFisGravaIsentoDocEnt(strClaFisLocal, strCodFis);

            If blnIsentas Then
            Begin
              fltIsento := fltClcAux;
              fltOutras := 0;
            End Else
            Begin
              fltIsento := 0;
              fltOutras := fltClcAux;
            End;

            qryGenMer.ParamByName('CODFIS').AsString := strCodFis;
            qryGenMer.ParamByName('VLRCON').AsFloat  := fltVlrCon;
            qryGenMer.ParamByName('PERBAS').AsFloat  := fltPerBas;
            qryGenMer.ParamByName('BASICM').AsFloat  := fltBasIcm;
            qryGenMer.ParamByName('ALQICM').AsFloat  := fltAlqIcm;
            qryGenMer.ParamByName('VALICM').AsFloat  := fltValIcm;
            qryGenMer.ParamByName('BASIPI').AsFloat  := fltBasIpi;
            qryGenMer.ParamByName('ALQIPI').AsFloat  := fltAlqIpi;
            qryGenMer.ParamByName('VALIPI').AsFloat  := fltValIpi;
            qryGenMer.ParamByName('ISENTO').AsFloat  := fltIsento;

            qryGenMer.ParamByName('BKP_BASICMS').AsFloat  := fltBkp_BasIcm;
            qryGenMer.ParamByName('BKP_ALQICMS').AsFloat  := fltBkp_AlqIcm;
            qryGenMer.ParamByName('BKP_VALICMS').AsFloat  := fltBkp_ValIcm;

            qryGenMer.ParamByName('PERFCP').AsFloat  := fltPERFCP;
            qryGenMer.ParamByName('VALFCP').AsFloat  := fltVALFCP;
            qryGenMer.ParamByName('VBCFCP').AsFloat  := fltVBCFCP;
            qryGenMer.ParamByName('DESMAR').AsString := strDESMAR;



            {SE A EMPRESA FOR SUBSTITUTO }
            if (strClaSub <> '1') Then
            Begin

              If (Not fEmptyStr(recNotEle.strAutInc)) Or (blnDevolu And blnPrecoPraticado) THen
              Begin
                qryGenMer.ParamByName('PEBAST').AsFloat  := fTempEnt('PEBAST').AsFloat;
                qryGenMer.ParamByName('BASRET').AsFloat  := fTempEnt('BASRET').AsFloat;
                qryGenMer.ParamByName('VALRET').AsFloat  := fTempEnt('VALRET').AsFloat;
              End
              Else
              Begin
                qryGenMer.ParamByName('PEBAST').AsFloat  := fltPeBaST;
                qryGenMer.ParamByName('BASRET').AsFloat  := fltBasRet;
                qryGenMer.ParamByName('VALRET').AsFloat  := fltValRet;
              End;

              qryGenMer.ParamByName('BAERET').AsFloat := 0;
              qryGenMer.ParamByName('VAERET').AsFloat := 0;

            End
            Else
            Begin

              {SE A EMPRESA FOR SUBSTITUIDO }
              If (Not fEmptyStr(recNotEle.strAutInc)) Or (blnDevolu And blnPrecoPraticado) THen
              Begin
                qryGenMer.ParamByName('PEBAST').AsFloat  := fTempEnt('PEBAST').AsFloat;
                qryGenMer.ParamByName('BAERET').AsFloat  := fTempEnt('BAERET').AsFloat;
                qryGenMer.ParamByName('VAERET').AsFloat  := fTempEnt('VAERET').AsFloat;
              End
              Else
              Begin
                qryGenMer.ParamByName('PEBAST').AsFloat  := fltPeBaST;
                qryGenMer.ParamByName('BAERET').AsFloat  := fltBasRet;
                qryGenMer.ParamByName('VAERET').AsFloat  := fltValRet;
              End;

              qryGenMer.ParamByName('BASRET').AsFloat := 0;
              qryGenMer.ParamByName('VALRET').AsFloat := 0;
            End;

            qryGenMer.ParamByName('BASANT').AsFloat  := fltBasAnt;
            qryGenMer.ParamByName('VALANT').AsFloat  := fltValAnt;

            qryGenMer.ParamByName('OUTRAS').AsFloat  := fltOutras;
            qryGenMer.ParamByName('MARMIN').AsFloat  := fltMarMin;
            qryGenMer.ParamByName('MARMSG').AsFloat  := fltMarMSG;
            qryGenMer.ParamByName('MARMGE').AsFloat  := fltMarMGe;

            qryGenMer.ParamByName('CLAIPI').AsString  := fTempEnt('CLAIPI').AsString;
            qryGenMer.ParamByName('CDCEST').AsString  := fTempEnt('CDCEST').AsString;
            qryGenMer.ParamByName('RICMPR').AsString  :=  IIf(blnRedIcmsParana, 'S', 'N');

            If (fCfgSis('ATPRAU', varBoolean)) And ((Pos(edtCodFor.Text, fRetForFilialTodos) = 0) Or (fCfgSis('ATPREN', varBoolean))) Then
            Begin
              qryGenMer.ParamByName('PRECOM').AsFloat := fltPreCom;
              qryGenMer.ParamByName('PRECUS').AsFloat := fltPreCus;

              For IntCont := 1 To Length(recPrecos) Do
              Begin
                qryGenMer.ParamByName('PREEM' + IntToStr(IntCont)).AsString := 'N';

                qryGenMer.ParamByName('COMTB' + IntToStr(IntCont)).AsFloat := recPrecos[IntCont].fltComiss;

                If (Not blnFatPre) Or (intCont = 1) Then
                Begin

                  If blnAtpVmb[intCont] Then
                  Begin

                    qryGenMer.ParamByName('PREVE' + IntToStr(IntCont)).AsFloat  := recPrecos[IntCont].fltPreVen;
                    qryGenMer.ParamByName('PREEM' + IntToStr(IntCont)).AsString := IIF(recPrecos[IntCont].blnEmbala, 'S', 'N');

                  End Else
                  Begin

                    qryGenMer.ParamByName('MARBR' + IntToStr(IntCont)).AsFloat := recPrecos[IntCont].fltMarBru;

                  End;

                End Else
                Begin
                  qryGenMer.ParamByName('PREVE' + IntToStr(IntCont)).AsFloat  := recPrecos[IntCont].fltPreVen;
                  qryGenMer.ParamByName('PREEM' + IntToStr(IntCont)).AsString := IIF(recPrecos[IntCont].blnEmbala, 'S', 'N');

                  qryGenMer.ParamByName('MARBR' + IntToStr(IntCont)).AsFloat := recPrecos[IntCont].fltMarBru;
                End;

              End;

            End;


            {*****************************************}
            {* DADOS DO FILTRO                       *}
            {**************************************JB*}
            qryGenMer.ParamByName('NUMPED').AsString     := FieldByName('ENT_NUMPED').AsString;
            qryGenMer.ParamByName('CODITE').AsString     := FieldByName('ENT_CODITE').AsString;
            qryGenMer.ParamByName('AUTOINCREM').AsString := FieldByName('AUTOINCREM').AsString;

            if (stlPedidos.Count > 0) then
            Begin
              qryPcmDet.Close;
              qryPcmDet.ParamByName('DESITE').AsString     :=  Copy(FieldByName('ENT_DESACA').AsString,1, 57);
              qryPcmDet.Open;
            End;

            if (stlPedidos.Count > 0) and (not qryPcmDet.IsEmpty) And (not fEmptyStr(qryPcmDet.FieldByName('PCD_CODACA').AsString)) then
            Begin
              qryGenMer.ParamByName('CODACA').AsString := qryPcmDet.FieldByName('PCD_CODACA').AsString;
              qryGenMer.ParamByName('EMPACA').AsString := qryPcmDet.FieldByName('PCD_EMPACA').AsString;
              qryGenMer.ParamByName('PROACA').AsString := qryPcmDet.FieldByName('PCD_PROACA').AsString;
              qryGenMer.ParamByName('SALACA').AsFloat := qryPcmDet.FieldByName('ACA_SALDOS').AsFloat;
              qryGenMer.ParamByName('PREACA').AsFloat := qryPcmDet.FieldByName('ACA_PRECUS').AsFloat;
              qryGenMer.ParamByName('DESACA').AsString := qryPcmDet.FieldByName('ACA_DESCRI').AsString;
              qryGenMer.ParamByName('DESITE').AsString := qryPcmDet.FieldByName('ACA_DESCRI').AsString;
            End
            Else
            Begin
              {*  SE NÃO ENCONTRAR NÃO VAI ATUALIZAR NADA ! *}
              qryGenMer.ParamByName('CODACA').AsString := FieldByName('ENT_CODACA').AsString;
              qryGenMer.ParamByName('EMPACA').AsString := FieldByName('ENT_EMPACA').AsString;
              qryGenMer.ParamByName('PROACA').AsString := FieldByName('ENT_PROACA').AsString;
              qryGenMer.ParamByName('SALACA').AsFloat := FieldByName('ENT_SALACA').AsFloat;
              qryGenMer.ParamByName('PREACA').AsFloat := FieldByName('ENT_PREACA').AsFloat;
              qryGenMer.ParamByName('DESACA').AsString := FieldByName('ENT_DESACA').AsString;
              qryGenMer.ParamByName('DESITE').AsString := FieldByName('ENT_DESITE').AsString;
            End;

            // devolucao -> Ajusta PisCofins
            If blnDevolu And (fCfgSis('ICMCDV', varBoolean)) And (RoundTo(fltValIcm,-4) > RoundTo(0,-4)) Then
            begin

              tmp := TCalculoPisCofins.Create;
              Try
                CalcResult := tmp.fCalculoPisCofins(VS_strCodEmp,
                                                    qryEntMer.FieldByName('ENT_CODITE').AsString,
                                                    strClaFisLocal,
                                                    strCodFis,
                                                    strCodFor,
                                                    IIf(fCfgSis('SIMPAU',varBoolean) and (fCfgSis('IGNSIM') = '1'), 'S', 'N'),
                                                    edtEspDoc.Text,
                                                    qryEntMer.FieldByName('ENT_TOTITE').AsFloat,
                                                    qryEntMer.FieldByName('ENT_DESESP').AsFloat,
                                                    IIf(blnCREIPI, fltValIpi, 0),
                                                    IIf(blnCREIPI, fltValRet, 0),
                                                    qryEntMer.FieldByName('ENT_VALFRE').AsFloat,
                                                    qryEntMer.FieldByName('ENT_DESACE').AsFloat,
                                                    fltValIcm,
                                                    0,
                                                    IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu Or FblnAcessadoViaRetornoConsignacao,'C','F'),
                                                    FieldByName('ENT_INCPIS').AsString,
                                                    strSitP_C,
                                                    '',
                                                    StrToDate(mskDtaEnt.Text),
                                                    '',
                                                    False,
                                                    False,
                                                    '',
                                                    '',
                                                    '',
                                                    '',
                                                    False,
                                                    FieldByName('ENT_SITXML').AsString,
                                                    FieldByName('ENT_ICMXML').ASFloat,
                                                    FieldByName('ENT_CSTPIS').AsString,
                                                    FieldByName('ENT_CSTCOF').AsString,
                                                    FieldByName('ENT_VALPIS').AsFloat,
                                                    FieldByName('ENT_VALCOF').AsFloat);
              Finally
                tmp.Destroy;
              End;

              If CalcResult.dblBasePis > 0 Then
              Begin
                qryGenMer.ParamByName('ALQPIS').AsFloat := CalcResult.dblAlqPis;
                qryGenMer.ParamByName('ALQCOF').AsFloat := CalcResult.dblAlqCof;
                qryGenMer.ParamByName('BASPIS').AsFloat := CalcResult.dblBasePis;
                qryGenMer.ParamByName('BASCOF').AsFloat := CalcResult.dblBaseCof;
                qryGenMer.ParamByName('VALPIS').AsFloat := CalcResult.dblValorPis;
                qryGenMer.ParamByName('VALCOF').AsFloat := CalcResult.dblValorCof;
              End
              Else
              Begin
                qryGenMer.ParamByName('ALQPIS').AsFloat := 0;
                qryGenMer.ParamByName('ALQCOF').AsFloat := 0;
                qryGenMer.ParamByName('BASPIS').AsFloat := 0;
                qryGenMer.ParamByName('BASCOF').AsFloat := 0;
                qryGenMer.ParamByName('VALPIS').AsFloat := 0;
                qryGenMer.ParamByName('VALCOF').AsFloat := 0;
               End;
            End
            Else If blnDevolu And (fCfgSis('ICMCDV', varBoolean)) Then
            Begin
              qryGenMer.ParamByName('ALQPIS').Value := null;
              qryGenMer.ParamByName('ALQCOF').Value := null;
              qryGenMer.ParamByName('BASPIS').Value := null;
              qryGenMer.ParamByName('BASCOF').Value := null;
              qryGenMer.ParamByName('VALPIS').Value := null;
              qryGenMer.ParamByName('VALCOF').Value := null;
            End;

            qryGenMer.ExecSQL;
            qryGenMer.Close;

            pgbCalculoFiscal.StepBy(1);
            qryEntMer.Next;
            If Assigned(pgbProgresso) Then
              pgbProgresso.Position := pgbProgresso.Position + 1;

            Application.ProcessMessages;

          Except
            On E: Exception Do
            Begin
              pMensagensErro(E.Message, '[fCalculaItensPedido]');
              Result := False;
            End;
          End;

        End;

      End;

    End;

    pgbCalculoFiscal.Visible := False;

  Finally
    FreeAndNil(cpcParams);
    FreeAndNil(qryGenMer);
    If Assigned(qryPcmDet) Then 
      FreeAndNil(qryPcmDet);

  End;
end;

{*****************************************}
{* HABILITA = TRUE: READONLY := FALSE E  *}
{* TABSTOP := TRUE                       *}
{**************************************MV*}
procedure TfrmEntMercadorias.pHabilitaCampoNaGridEspeciePD(
  blnHabilita: Boolean);
begin
  dbgItensColumQuant.Options.Editing  := blnHabilita; // Quantidade
  dbgItensColumQuant.Options.Focusing := blnHabilita; // Quantidade

  dbgItensColumValUnit.Options.Editing := blnHabilita; // Unitario
  dbgItensColumValUnit.Options.Focusing:= blnHabilita;// Unitario

  dbgItensColumValorTotal.Options.Editing := blnHabilita; // Total
  dbgItensColumValorTotal.Options.Focusing:= blnHabilita; // Total
end;

procedure TfrmEntMercadorias.pHabilitaCampos(Owner: TWinControl; blnHabilita: Boolean);
  Var
    intContador: Integer;
    edtTemp: TEdit;
    mskTemp: TMaskEdit;
    btnTemp: TBitBtnLocked;
begin
  For intContador := 0 To Owner.ControlCount -1 Do
  Begin

    If (Owner.Controls[intContador] Is TEdit) Then
    Begin

      edtTemp := (Owner.Controls[intContador] As TEdit);

      If edtTemp.Tag = 99 Then
      Begin

        If blnHabilita Then
        Begin
          edtTemp.ReadOnly := False;
          edtTemp.TabStop  := True;
        End
        Else
        Begin
          edtTemp.ReadOnly := True;
          edtTemp.TabStop  := False;
        End;

      End;

    End
    Else If (Owner.Controls[intContador] Is TMaskEdit) Then
    Begin

      mskTemp := (Owner.Controls[intContador] As TMaskEdit);

      If mskTemp.Tag = 99 Then
      Begin

        If blnHabilita Then
        Begin
          mskTemp.ReadOnly := False;
          mskTemp.TabStop  := True;
        End
        Else
        Begin
          mskTemp.ReadOnly := True;
          mskTemp.TabStop  := False;
        End;

      End;

    End
    Else If (Owner.Controls[intContador] Is TBitBtnLocked) Then
    Begin

      btnTemp := (Owner.Controls[intContador] As TBitBtnLocked);
      btnTemp.Enabled := blnHabilita;

    End;

  End;
end;

procedure TfrmEntMercadorias.pImpArrLinEti;
  Var
    intContador1: Integer;
    intLength1  : Integer;
    blnUltimoReg: Boolean;
    strLinhaAtu : String;
    blnImprime  : Boolean;
begin
  strLinhaAtu  := '';
  blnUltimoReg := False;
  intLength1   := Length(arrLinEti);
  blnImprime   := False;

  For intContador1 := 0 To intLength1 - 1 Do
  Begin
    If (arrLinEti[intContador1] <> '') Then
    Begin
      blnImprime := True;
      Break;
    End;
  End;

  If Not blnImprime Then
  Begin
    Exit;
  End;

  For intContador1 := 0 To intLength1 - 1 Do
  Begin
    If (intContador1 = intLength1 - 1) Then
      blnUltimoReg := True;

    pEscreveLinha(strArqTxt, AnsiString(arrLinEti[intContador1]), blnUltimoReg, strNomImp, strNomPro, strDesPro);
    strLinhaAtu := '';
  End;

  SetLength(arrLinEti, 0);
end;

procedure TfrmEntMercadorias.pImpEtiquetaMatricial;
  Var
    intContador: Integer;
    intQtdTopo : Integer;
    intSeqNum  : Integer;
begin
  pCarregaConfImpr(qryCfgRel, Self.Name);
  strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  strNomPro := qryCfgRel.FieldByName('REL_NOMPRO').AsString;
  strDesPro := qryCfgRel.FieldByName('REL_DESPRO').AsString;

  If Not fVerificaImpressora(strNomImp) Then
  Begin
    fMensagem('','Impressora configurada incorretamente!',['&OK']);
    Exit;
  End;
  With qryEntMer Do
  Begin
    intQtdTopo := fRetTopo('EPC');
    For intContador := 1 to intQtdTopo Do
    Begin
      pEscreveLinha(untFuncMacro.strArqTxt, ' ', False, strNomImp, strNomPro, strDesPro);
    End;
    First;
    intSeqNum := 1;
    While Not Eof Do
    Begin
      Application.ProcessMessages;
      FSeqNum := FormatFloat('00', intSeqNum);
      pAtualizaCamposUso;
      Application.ProcessMessages;
      pImpRegistro;
      Application.ProcessMessages;
      Inc(intSeqNum);
      Next;
    End;
    pImpArrLinEti;
    First;
  End;
end;

procedure TfrmEntMercadorias.pImpRegistro;
  Var
    intQtdCol: Integer;
    intQtdColOri: Integer;
    intContador: Integer;
    intLinhaAtu: Integer;
    intLinha : Integer;

    intTamLinAnt: Integer;

    intNumCol: Integer;
    intQtdEti: Integer;
    intLinhaEti: Integer;
    strNumCol: String;
    strLinha : String;
begin

  intLinhaAtu := 1;
  intLinha    := 0;

  intLinhaEti := 0;

  With qryCnfGen Do
  Begin
    Close;
    ParamByName('TIPETI').AsString := 'EPC';
    Open;
    intQtdEti := 1;

    While (intQtdEti > 0) Do
    Begin
      First;

      intQtdColOri := FieldByName('CNF_QTDCOL').AsInteger;
      intQtdCol := intQtdColOri;

      If (intQtdCol > intQtdEti) And (intColAtu <= 1) Then
        intQtdCol := intQtdEti;

      {*****************************************}
      {* LÊ E INTERPRETA O ID = '00'           *}
      {**************************************MV*}
      If intColAtu <= 1 Then
      Begin
        pI_LinhasEti(Self, cpuCampos, strLinha, intLinhaAtu, intLinha, strNomImp, strNomPro, strDesPro, 0, qryCnfGen);
        {*****************************************}
        {* ESCREVE COM WRITE, MAS NÃO IMPRIME    *}
        {**************************************MV*}
        pEscreveLinha(strArqTxt, AnsiString(strLinha), not VS_SpoolImpressaoCitel, '');
      End;
      Next;

      If (Length(arrLinEti) = 0) Then
      Begin
        If RecordCount > 0 Then
          SetLength(arrLinEti, RecordCount - 1)
        Else
          SetLength(arrLinEti, 0);
      End;

      While (Not Eof) Do
      Begin

        pAtualizaCamposUso;

        strLinha := '';

        For intContador := intColAtu To IIF(intQtdEti = 1, intColAtu, intQtdCol) Do
        Begin

          strNumCol := fStrZero(IntToStr(intContador), 03);
          intNumCol := FieldByName('CNF_COL' + strNumCol).AsInteger;

          intTamLinAnt := Length(arrLinEti[intLinhaEti]);
          pI_LinhasEti(Self, cpuCampos, strLinha, intLinhaAtu, intLinha, strNomImp, strNomPro, strDesPro, (intNumCol - intTamLinAnt), qryCnfGen);

          arrLinEti[intLinhaEti] := arrLinEti[intLinhaEti] + strLinha;
          strLinha := ''; //Se desistir da matriz, tirar essa linha

        End;
        Inc(intLinhaEti);

        {*****************************************}
        {* NEXT NO ARQUIVO DE CNF                *}
        {**************************************MV*}
        Next;

      End;

      intLinhaEti := 0;
      Inc(intColAtu, intQtdEti);
      Dec(intQtdEti, (intQtdColOri + 1) - (intColAtu - intQtdEti));

      If (intColAtu > intQtdColOri) Then
      Begin
        pImpArrLinEti;
        intColAtu := 1;
      End;

    End;

  End;
end;

procedure TfrmEntMercadorias.pImprimeFichaProdutos;
begin
  Try
    pCriarFormularios(TfrmModuloEntMercadorias, frmModuloEntMercadorias);
    With frmModuloEntMercadorias Do
    Begin
      frxRelatorio.DataSet := qryEntMer;
      TfrxMemoView(frxFichaJ.FindObject('rllZebra')).Highlight.Color := fCfgSis('CORZEB');

      TfrxMemoView(frxFichaJ.FindObject('rllNomEmp')).Text := 'EMPRESA.: ' + fRetNomeEmpresa;
      TfrxMemoView(frxFichaJ.FindObject('rllCGCEmp')).Text := 'C.N.P.J.: ' + fFormataCpfCgc(fRetCGCEmpresa(VS_strCodEmp), FPais);
      TfrxMemoView(frxFichaJ.FindObject('rllEndEmp')).Text := 'ENDERECO: ' + fRetEnderecoEmpresa(VS_strCodEmp);
      TfrxMemoView(frxFichaJ.FindObject('rllNomFor')).Text := 'FORNECEDOR: ' + edtCodFor.Text + '-' + edtNomFor.Text;
      TfrxMemoView(frxFichaJ.FindObject('rllNumDoc')).Text := edtNumDoc.Text + '-' + edtEspDoc.Text;

      pPreviewReport(Self.Name, Self.Caption + ' (Ficha de Produtos)', frxFichaJ);
    End;
    FreeAndNil(frmModuloEntMercadorias);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmEntMercadorias.pEscapePressed;
Var
  blnTemItensInseridos: Boolean;
begin
  blnEscape := True;

  blnTemItensInseridos := False;
  If Assigned(dbgItens.DataController) Then
    If Assigned(dbgItens.DataController.DataSource) Then
      If Assigned(dbgItens.DataController.DataSource.DataSet) Then
        If dbgItens.DataController.DataSource.DataSet.Active Then
          blnTemItensInseridos := (dbgItens.DataController.DataSource.DataSet.RecordCount > 0);
  
  If (ActiveControl.Parent = pnlItem) Then
  Begin

    If blnDocOri Then
      Inherited;

    If (edtCodIte.Focused) And (Not blnTemItensInseridos) Then
    Begin

      btnCancelaItem.Click;
      pHabilitaCampos(pnlCabecalho, True);
      pHabilitaCampos(pnlItem, False);
      btnConfirma.Enabled    := False;
      btnAlterPrecos.Enabled := False;
      btnLocProx.Enabled := False;
      btnIniBus.Enabled  := False;

      If edtCodFor.Enabled Then
      Begin
        pSetFocus(edtCodFor);
      End
      Else
      Begin
        If edtSerie.CanFocus Then
          pSetFocus(edtSerie)
        Else
          btnCancelarEntrada.Click;
      End;
      dbgItensGrid.Enabled := False;

      fltAlqFor := 0.0;
      strEstFor := '';

    End
    Else
    Begin

      btnCancelaItem.Click;

      If blnSemInc And edtSerie.CanFocus Then
        pSetFocus(edtSerie);

    End;

  End
  Else If (ActiveControl.Parent = pnlCabecalho) Then
  Begin
    inherited;
  End;
end;

procedure TfrmEntMercadorias.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaEnt);
end;

procedure TfrmEntMercadorias.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If blnEscape And (Not fPergunta('Deseja abandonar a tarefa?')) Then
  Begin
    Action := caNone;
    Exit;
  End;

  inherited;
  If fTabelaExiste('TMP_ENTMER') And (Not blnRecCliGarantia) Then
    pDeletaTabelaEntradaMercadorias;

  FreeAndNil(stlCamposIte);
  FreeAndNil(stlCamIndIte);
  FreeAndNil(stlDesIndIte);
  FreeAndNil(stlPedidos);
  FreeAndNil(qryCadUni);
  FreeAndNil(qryCnfGen);

  pDestravaItensLote;
  pDestravaDocumento;

  If Assigned(qryItePed) Then
    qryItePed.Close;

  If Assigned(objEmbala) Then
    FreeAndNil(objEmbala);
end;

procedure TfrmEntMercadorias.pCalculaTotais;
  Var
    strSQL   : String;
    qryGenMer: TUniQuery;

begin
  Try

    qryGenMer := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  SUM(ENT_TOTITE) AS TOTITE, ';
    strSQL := strSQL + '  SUM(IF(ENT_ANTPRO <> "S", ENT_VALRET, 0)) + SUM(IF(ENT_ANTPRO <> "S", ENT_VAERET, 0)) AS TOTSUB, ';
    strSQL := strSQL + '  SUM(ENT_VALANT) AS TOTANT, ';
    strSQL := strSQL + '  SUM(ENT_VALIPI) AS TOTIPI, ';
    strSQL := strSQL + '  SUM(ENT_TOTITE) + SUM(IFNULL(ENT_VALIPI, 0)) + SUM(IFNULL(IF(ENT_ANTPRO <> "S", ENT_VALRET, 0), 0)) + ';
    strSQL := strSQL + '  SUM(IFNULL(IF(ENT_ANTPRO <> "S", ENT_VAERET, 0), 0)) AS TOTGER ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  TMP_ENTMER ';

    With qryGenMer Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      edtTotal.Text  := FormatFloat('#,##0.00', FieldByName('TOTITE').AsFloat);
      edtTotSub.Text := FormatFloat('#,##0.00', FieldByName('TOTSUB').AsFloat);
      edtTotAnt.Text := FormatFloat('#,##0.00', FieldByName('TOTANT').AsFloat);
      edtTotIpi.Text := FormatFloat('#,##0.00', FieldByName('TOTIPI').AsFloat);
      edtTotGer.Text := FormatFloat('#,##0.00', FieldByName('TOTGER').AsFloat);

      Close;

    End;

  Finally
    FreeAndNil(qryGenMer);
  End;
end;

Function TfrmEntMercadorias.fedtCodIteKeyPressGer(Sender: TObject;
  var Key: Char; strCodFab: String = ''): Boolean;
  Var
    arrSel: TConsultasArray;
    objfrmPnl: TPanelCxItem;
begin
  If (fEntraCons(Key))                                                       And
     (Not edtCodIte.ReadOnly)                                                And
     ( (fEmptyStr(edtCodIte.Text)) or (edtCodIte.SelText = edtCodIte.Text) ) Then
  Begin
    {******************************************************************}
    {* NÃO CHAMA MAIS A COSULTA ESPECÍFICA, AGORA CHAMA A NOVA FUNÇÃO *}
    {***************************************************************AC*}

    Try
      objfrmPnl := TPanelCxItem.New();
      objFrmPnl.blnExibirVrUnitarioPedCompraGrid := True;

      If rdbProdAcabado.Checked Then
      Begin
        fConsultaProdAcabados(edtCodIte);
        If Not fEmptyStr(edtCodIte.Text) Then
        Begin
          pCarregaItem(edtCodIte.Text, True, True);
          SelectNext(ActiveControl, True, True);
        End;
      End
      Else
      Begin
        Try
          objFrmPnl.strNomForm := Self.Name;
          objFrmPnl.recParametros.strCodCli  := '';
          objFrmPnl.strCodVen  := '';
          objFrmPnl.strCodDig  := '';
          objFrmPnl.intPraMedio:= 0;
          objFrmPnl.recParametros.strTabPre  := '1';
          objfrmPnl.strNumOrc  := '';
          objfrmPnl.strEspOrc  := '';

          if fPesqItem(conIteCompleta,
                       Self,
                       edtCodIte,
                       edtDesIte,
                       qryConCit,
                       Key,
                       arrSel,
                       True,
                       objfrmPnl,
                       'Consulta de Itens',
                       objFrmPnl.recParametros.strTabPre,
                       '',
                       0,
                       false,
                       false,
                       0,
                       cdrCodIte,
                       '',
                       False,
                       '',
                       '',
                       True,
                       False,
                       False,
                       '',
                       False,
                       False,
                       False,
                       False,
                       False,
                       False,
                       True,
                       False,
                       '',
                       -1,
                       False,
                       strCodFab,
                       True,
                       '',
                       '',
                       '',
                       '',
                       '',
                       '',
                       True,
                       blnConEqu Or blnLocEqu,
                       False,
                       Nil,
                       Nil,
                       '',
                       '',
                       '',
                       '',
                       '',
                       '',
                       '',
                       '',
                       False,
                       False,
                       True,
                       False,
                       False,
                       strItensEntradaMercadoriaDev) Then
          Begin
            If (qryConCit.FindField('Preço de Custo') <> Nil) Then
            Begin
              qryConCit.FieldByName('Preço de Custo').DisplayWidth := 14;
            End;

            If (rdbCodIte.Checked) Or (fEmptyStr(qryConCit.FieldByName('ITE_CODFAB').AsString)) Or
               (Not fEmptyStr(strCodFab)) Then
            Begin
              edtCodIte.Text := qryConCit.FieldByName('ITE_CODITE').AsString;
              blnBuscarCodFab := False;
            End
            Else
            Begin
              edtCodIte.Text := qryConCit.FieldByName('ITE_CODFAB').AsString;
              strFabAut      := qryConCit.FieldByName('AUTOINCREM').AsString;
            End;

            pCarregaItem(edtCodIte.Text, True, True);
            If fEmptyStr(strCodFab) Then
              SelectNext(ActiveControl, True, True);
          End;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[frmEntMercadorias.edtCodIte]');
          End;
        End;

      End;

    Finally
      FreeAndNil(objfrmPnl);
    End;

  End;

  Result := True;

end;

function TfrmEntMercadorias.fEhNFEEntrada: Boolean;
begin
  Result := (Not fEmptyStr(recNotEle.strAutInc));
end;

function TfrmEntMercadorias.fEhRetornoGarantiaFornecedorInterno(blnClaRGR: Boolean = False): Boolean;
begin
  Result := fEhRetornoGarantiaFornecedor(strClaFisGar, fEhNFEEntrada, blnGarantia);
  if (Not Result) and blnClaRGR then
  begin
    if pos(strClaFisGar, strCLARGR) > 0 Then
      Result := blnGarantia;
  end;
end;

function TfrmEntMercadorias.fEntPedidoPorGarantia: Boolean;
begin
  Result := Not fEmptyStr(FClaFisEntPorGarantia);
end;

function TfrmEntMercadorias.fEspecieInvalida: Boolean;
begin
  Result :=  Not((edtEspDoc.Text = 'NF') Or
             (edtEspDoc.Text = 'GR') Or
             (edtEspDoc.Text = 'PD'));
end;

procedure TfrmEntMercadorias.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);

begin
  inherited;

  fedtCodIteKeyPressGer(Sender, Key);

end;

Function TfrmEntMercadorias.fSQLItem(blnAtuIcS: Boolean): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  I.*,  ';

  strSQL := strSQL + '  CONCAT(IFNULL(MAR_CODMAR,""),"-",IFNULL(MAR_DESMAR,"")) AS MAR_DESMAR, ';

  If blnAtuIcS Then
    strSQL := strSQL + ' ROUND(ABF_ALQICM_SAI_CNC * (ABF_BASICM_SAI_CNC / 100), 2) AS ITE_ICMSAIDA '
  Else
    strSQL := strSQL + ' I.ITE_ICMSAI AS ITE_ICMSAIDA ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ITEGER I ';
  strSQL := strSQL + '  INNER JOIN CADITE C ON C.ITE_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '  LEFT JOIN CADMAR ON MAR_CODMAR = C.ITE_CODMAR ';

  If blnAtuIcS Then
  Begin
    If fCfgSis('TIPABF') = '1' Then
    Begin

      strSQL := strSQL + '  INNER JOIN ABFICM   ON   ABF_CODABF = C.ITE_CODABF AND ';
    End Else
    Begin
      strSQL := strSQL + '  INNER JOIN ABFICM   ON   ABF_CODABF = I.ITE_CODABF AND ';
    End;

    strSQL := strSQL + '                             ABF_ESTADO = ' + QuotedStr(fCadEmpDes('ESTADO', VS_strCodEmp)) + ' ';
  End;

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  I.ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '  I.ITE_CODEMP = :CODEMP ';

  Result := strSQL;
End;

procedure TfrmEntMercadorias.pCarregaItemDevolucao(strCodIte: String);
Begin
  With qryConIte Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(fSQLItem(False));
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
  End;
End;

procedure TfrmEntMercadorias.pCarregaItem(strIteAlt: String; blnBuscaPorChave, blnAtualizaEdits: Boolean; blnRepesquisa: Boolean = False; blnCarregarVis: Boolean = False);

  Var
    strSQL   : String;
    strCodIte: String;
    blnIteEsp: Boolean;
    chrKey   : Char;

    blnBuscaCodBar: Boolean;

    flEmbala,
    fltPreFor: Double;

    qryPreco  : TUniQuery;
    qryVlrFor : TUniQuery;
begin
  blnBuscaCodBar := True;
  qryVlrFor := fCriaQuery(Self);

  strSQL := fSQLItem(blnAtuIcS);

  If (rdbProdAcabado.Checked) And (blnBuscaPorChave) Then
  Begin
    pCarregaProdutoAcabado(strIteAlt);
  End
  Else
  Begin
    If (Length(Trim(strCodIte)) <= fTamCodIte) Or (rdbCodFab.Checked) Then
    Begin
      If (Not rdbCodFab.Checked) Or blnCarregarVis Then
        edtCodIte.Text := fStrZero(strIteAlt, fTamCodIte);

      blnBuscaCodBar := False;
    End;

    pPesquisaCadSem(qryConCit, qryConCit, strIteAlt, edtCodFor.Text,
      blnBuscaCodBar, (rdbCodFab.Checked And blnBuscarCodFab) And (blnBuscaPorChave),strFabAut, False, False, False,
                       '', {strCodEmp}
                      (rdbCodFab.Checked And blnBuscarCodFab) And (blnBuscaPorChave) {blnSomenteCodFabrica});

    If blnRepesquisa And rdbCodFab.Checked And blnBuscarCodFab And (qryConCit.RecordCount > 1) Then
    Begin
      chrKey := '?';
      strCodIte := edtCodIte.Text;
      edtCodIte.Clear;

      utcRegistros.fRetRegistro(self.Name + 'CADITE');
      utcRegistros.pLimparCampos;

      If Not fedtCodIteKeyPressGer(edtCodIte,chrKey,strCodIte) Then
      Begin
        pSetFocus(edtCodIte);
        utcRegistros.pLimparCampos;
        Exit;
      End;

      utcRegistros.pLimparCampos;

    End;

  End;

  blnBuscarCodFab := True;

  With qryConCit Do
  Begin

    {***********************************}
    { ITEM ESPECIAL                     }
    {********************************JB*}
    blnIteEsp := (Pos('ITEM ESPECIAL', FieldByName('ITE_DESITE').AsString) > 0);

    If blnAtualizaEdits Then
    Begin
      edtCodIte.Text  := FieldByName('ITE_CODITE').AsString;
      edtDesIte.Text  := FieldByName('ITE_DESITE').AsString;
      edtRefere.Text  := FieldByName('ITE_REFERE').AsString;

      If (strCnvEmb <> 'N') And
         fCarregaTabelaPrecoAtiva(edtCodFor.Text, FieldByName('ITE_CODITE').AsString, qryIteFor)Then
      Begin
        edtUnidad.Text  := qryIteFor.FieldByName('ITE_UNICOM').AsString;
        edtSigla.Text   := fRetSiglaUnidade(qryIteFor.FieldByName('ITE_UNICOM').AsString);
        strCodUni       := qryIteFor.FieldByName('ITE_UNICOM').AsString;
        strUniEmb       := qryIteFor.FieldByName('ITE_UNICOM').AsString;

        If qryIteFor.FieldByName('ITE_CNVCUS').AsFloat <> 0 Then
          edtEmbala.Text  := FormatFloat(fMskDigitos(DEC_EMBALAGEM), qryIteFor.FieldByName('ITE_CNVCUS').AsFloat)
        Else
         edtEmbala.Text  := FormatFloat(fMskDigitos(DEC_EMBALAGEM), 1);

      End Else
      Begin

        edtUnidad.Text  := FieldByName('ITE_CODUNI').AsString;
        edtSigla.Text   := fRetSiglaUnidade(FieldByName('ITE_CODUNI').AsString);
        strCodUni       := FieldByName('ITE_CODUNI').AsString;
        strUniEmb       := FieldByName('ITE_UNICOM').AsString;

        If blnDevolu Then
          flEmbala := 0
        Else
          flEmbala := TIteBar.fRetEmbalagemFornecedor(FieldByName('ITE_CODITE').AsString, strCodFor);

        If flEmbala > 0 Then
          edtEmbala.Text  := FormatFloat(fMskDigitos(DEC_EMBALAGEM), flEmbala)

        Else If FieldByName('BAR_EMBALA').AsFloat > 0 Then
          edtEmbala.Text  := FormatFloat(fMskDigitos(DEC_EMBALAGEM), FieldByName('BAR_EMBALA').AsFloat)

        Else If FieldByName('ITE_EMBALA').AsFloat > 0 Then
          edtEmbala.Text  := FormatFloat(fMskDigitos(DEC_EMBALAGEM), FieldByName('ITE_EMBALA').AsFloat)

        Else
          edtEmbala.Text  := FormatFloat(fMskDigitos(DEC_EMBALAGEM), 1);

      End;

      If fEmptyStr(recNotEle.strAutInc) Then
      Begin
        If fCfgSis('ENTPIS', varBoolean) Then
          strIncPis := FieldByName('ITE_INCPIS').AsString
        Else
          strIncPis := 'N';

        If fEmptyStr(edtQtdIte.Text) Then
          edtQtdIte.Text := FormatFloat(fMskDigitos(fCfgSis('DEQTEM', varInteger)), 0);

        If fEmptyStr(edtTotIte.Text) Then
          edtTotIte.Text := '0,00';

        If fEmptyStr(edtUnitar.Text) Then
          edtUnitar.Text := '0,0000';
      End;

    End;

  End;

  If Not (qryConCit.IsEmpty) Then
  Begin

    {***********************************}
    { CASO FOR ITEM ESPECIAL HABILITA   }
    { AS EDITS DE DESCRIACAO E UNIDADE  }
    {********************************JB*}
    If ((blnIteEsp) And fCfgSis('EMIESP', varBoolean)) Or fCfgSis('EDUNEM', varBoolean) Or blnConEqu Or blnLocEqu Then
    Begin
      edtDesIte.ReadOnly  := False;
      edtDesIte.TabStop   := True;

      If Not blnConEqu Then
      Begin
        edtUnidad.ReadOnly  := False;
        edtUnidad.TabStop   := True;
      End;
    End
    Else
    Begin
      edtDesIte.ReadOnly  := True;
      edtDesIte.TabStop   := False;
      edtUnidad.ReadOnly  := True;
      edtUnidad.TabStop   := False;
    End;

    With qryConIte Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := qryConCit.FieldByName('ITE_CODITE').AsString;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If SameText(edtEspDoc.Text, 'NF') And (blnBuscaPorChave) Then
      Begin
        If fCfgSIs('TIPABF') = '1' Then
          edtCodAbf.Text := qryConCit.FieldByName('ITE_CODABF').AsString
        Else
          edtCodAbf.Text := qryConIte.FieldByName('ITE_CODABF').AsString;
      End;

      If fEmptyStr(edtClaIpi.Text) or blnAtualizaEdits Then
        edtClaIpi.Text := qryConCit.FieldByName('ITE_CLAIPI').AsString;

      If fEmptyStr(edtCodCest.Text) or blnAtualizaEdits Then
         edtCodCest.Text := fRetCodCestItem(qryConCit.FieldByName('ITE_CODITE').AsString);

      If Not fUsaQtdPendenteEntregaFutura Then
        edtSaldo.Text := FormatFloat('#,##0.000', FieldByName('ITE_SALDOS').AsFloat )
      Else
        edtSaldo.Text := FormatFloat('#,##0.000', (FieldByName('ITE_SALDOS').AsFloat +
                           TEntregaFutura.New(
                             TParamEF.New()
                               .CodIte(edtCodIte.Text)
                               .CodEmp(VS_strCodEmp)
                               .TipoTE(tteTodas)
                             ).Total()));

      If (Not fEmptyStr(strCodAca)) Then
      Begin
        strProAca      := 'S';
        edtDesIte.Text := strDesAca;
        edtSaldo.Text  := FloatToStrF(fltSalAca, ffFixed, 12, 3);

        If (fEmptyStr(edtUnitar.Text)) Or (fStrToFloat(edtUnitar.Text) = 0.0) Then
          edtUnitar.Text := FloatToStrF(fltPreAca, ffFixed, 12, 4);

      End;

      If (blnForFil) Then
      Begin
        If fEmptyStr(edtUnitar.Text) Or (fStrToFloat(edtUnitar.Text) = 0) Then
          edtUnitar.Text := FloatToStrF(FieldByName('ITE_PRECUS').AsFloat, ffFixed, 12, 4);
      End Else
      Begin

        fltPreFor := fPrecoUnitarioEspecialFornecedor(edtCodFor.Text, qryConCit.FieldByName('ITE_CODITE').AsString);

        If fltPreFor > 0 Then
        Begin
          If fEmptyStr(edtUnitar.Text) Or (fStrToFloat(edtUnitar.Text) = 0) Then
            edtUnitar.Text := FloatToStrF(fltPreFor, ffFixed, 12, 4);
        End

        Else
        Begin
          if fCarregaPrecoFornecedor(qryConIte.FieldByName('ITE_CODITE').AsString, edtCodFor.Text, qryVlrFor) Then
            qryPreco := qryVlrFor
          Else
            qryPreco := qryConIte;

          Case strSugPen[1] Of
            '1':  If fEmptyStr(edtUnitar.Text) Or (fStrToFloat(edtUnitar.Text) = 0) Then
                    edtUnitar.Text := FloatToStrF(qryPreco.FieldByName('ITE_PRECOM').AsFloat, ffFixed, 12, 4);

            '2':  If fEmptyStr(edtUnitar.Text) Or (fStrToFloat(edtUnitar.Text) = 0) Then
                    edtUnitar.Text := FloatToStrF(qryPreco.FieldByName('ITE_PRECUS').AsFloat, ffFixed, 12, 4);

            '4':  If fEmptyStr(edtUnitar.Text) Or (fStrToFloat(edtUnitar.Text) = 0) Then
                    edtUnitar.Text := FloatToStrF(qryPreco.FieldByName('ITE_PRECOM').AsFloat *
                            (1 - qryPreco.FieldByName('ITE_DESF01').AsFloat / 100) *
                            (1 - qryPreco.FieldByName('ITE_DESF02').AsFloat / 100) *
                            (1 - qryPreco.FieldByName('ITE_DESF03').AsFloat / 100) *
                            (1 - qryPreco.FieldByName('ITE_DESF04').AsFloat / 100) *
                            (1 - qryPreco.FieldByName('ITE_DESF05').AsFloat / 100) *
                            (1 - qryPreco.FieldByName('ITE_DESF06').AsFloat / 100), ffFixed, 12, 4);

          End;

        End;

      End;

      If fEmptyStr(edtAlqIPI.Text)  Or (fStrToFloat(edtAlqIPI.Text) = 0) Then
         edtAlqIPI.Text := FormatFloat('#,####0.00', qryConIte.FieldByName('ITE_IPIENT').AsFloat);

    End;

  End
  Else
  Begin

    qryConIte.Close;

  End;

  If SameText(strProAca, 'S') Then
    pMostraLote(False, '')
  Else
    pMostraLote(objCadLot.fExisteLote(edtCodIte.Text, VS_strCodEmp, '', False), fRetReaEnd(edtCodIte.Text), fItemMarmore(edtCodIte.Text));

  If ((objCadLot.tplTipLot = tplArmazem) Or fUsaRotinaWMS) And (edtNumLot.Visible) Then
  Begin
    //Se usa rotina wms
    If fUsaRotinaWMS Then
    Begin
      //Se nao realiza enderecamento e possuir lote principal para compras
      //deve carregar este lote para o produto e nao realizar o enderecamento
      If (fRetReaEnd(edtCodIte.Text) = 'N') And
         (objCadLot.fRetArmazemPrincipalCompra(edtCodIte.Text) <> '') Then
      Begin
        edtNumLot.Text := objCadLot.fRetArmazemPrincipalCompra(edtCodIte.Text);
      End
      Else
        edtNumLot.Text := 'A DEFINIR';
    End
    //Se nao usa rotina wms
    Else
    Begin
      If (edtNumLot.ReadOnly) Then
        edtNumLot.Text := 'A DEFINIR'
      Else If fEmptyStr(edtNumLot.Text) Then
        edtNumLot.Text := objCadLot.fRetArmazemPrincipalCompra(edtCodIte.Text);
    End;
  End;

  FreeAndNil(qryVlrFor);
end;

procedure TfrmEntMercadorias.pAtribuiCamposUso;
begin
  If Assigned(cpuCampos) THen
    FreeAndNil(cpuCampos);

  cpuCampos := TCamposUso.Create;
  cpuCampos.AdicionaCampos(qryEntMer, 'ENTMER');
end;

procedure TfrmEntMercadorias.pAtribuiTabelas;
begin
  qryConCli := fCriaQuery(Self);
  qryConAbf := fCriaQuery(Self);

  qryConCit := fCriarQuery('SELECT CADITE.*, BAR_CODBAR, BAR_EMBALA FROM CADITE LEFT JOIN ITEBAR ON BAR_CODITE = ITE_CODITE WHERE FALSE', Self);
//  qryConIte := fCriarQueryIteGer(Self);
  qryConIte := fCriaQuery(Self);
  qryCadUni := fCriaQuery(Self);
end;

{******************************************}
{* (RE)CALCULA O TOTAL / UNITARIO DO ITEM *}
{***************************************MV*}
procedure TfrmEntMercadorias.pCalculaTotIte(Sender: TObject);
  Var
    fltQtdIte: Double;
    fltUnitar: Double;
    fltTotIte: Double;
begin

  If fEmptyStr(edtQtdIte.Text) Then
    edtQtdIte.Text := FormatFloat(fMskDigitos(fCfgSis('DEQTEM', varInteger)), 0);

  If fEmptyStr(edtUnitar.Text) Then
    edtUnitar.Text := '0,0000';

  If fEmptyStr(edtTotIte.Text) Then
    edtTotIte.Text := '0,00';

  fltQtdIte := RoundTo(fStrToFloat(edtQtdIte.Text), fCfgSis('DEQTEM', varInteger) * -1);
  fltUnitar := RoundTo(fStrToFloat(edtUnitar.Text), -4);
  fltTotIte := fStrToFloat(edtTotIte.Text);

  If Not fEmptyStr(recNotEle.strAutInc) Then
    fltUnitar := fltTotIte/fltQtdIte
  Else
    edtTotIte.Text := FloatToStr(fFormataFloat( fltQtdIte * fltUnitar, 2 ));

  If (Sender = edtTotIte) And (Not blnDevolu) Then
  Begin

    If fltQtdIte <> 0.0 Then
      fltUnitar := fltTotIte / fltQtdIte;

  End;

  edtQtdIte.Text := FloatToStrF(fltQtdIte, ffFixed, 12, fCfgSis('DEQTEM', varInteger));
  edtUnitar.Text := FloatToStrF(fltUnitar, ffFixed, 12, 4 );

  edtTotIte.Text := FloatToStrF(fltQtdIte* fltUNitar, ffFixed, 12, 2);
end;

procedure TfrmEntMercadorias.edtUnitarEnter(Sender: TObject);
begin
  inherited;
  If fItemCarregadoParaVisualizacao Then
    pCarregaItensAlteracao;

end;

procedure TfrmEntMercadorias.edtUnitarExit(Sender: TObject);
begin
  inherited;

  pCalculaTotIte(Sender);
end;

procedure TfrmEntMercadorias.pHabilitaIcms(blnHabilita: Boolean);
Begin
  edtBasIcm.ReadOnly := Not blnHabilita;
  edtAlqIcm.ReadOnly := Not blnHabilita;

  edtBasIcm.TabStop  := blnHabilita;
  edtAlqIcm.TabStop  := blnHabilita;

  If blnHabilita Then
  Begin
    edtBasIcm.Color := clWindow;
    edtAlqIcm.Color := clWindow;
    edtBasIcm.NormalColor := clWindow;
    edtAlqIcm.NormalColor := clWindow;
    edtBasIcm.RequeridoColor := clWindow;
    edtAlqIcm.RequeridoColor := clWindow;
  End Else
  Begin
    edtBasIcm.Color := $00FFDFB8;
    edtAlqIcm.Color := $00FFDFB8;
    edtBasIcm.NormalColor := $00FFDFB8;
    edtAlqIcm.NormalColor := $00FFDFB8;
    edtBasIcm.RequeridoColor := $00FFDFB8;
    edtAlqIcm.RequeridoColor := $00FFDFB8;
  End;
End;

procedure TfrmEntMercadorias.pCarregaAbrevFiscal(blnBuscaPorChave, blnCarregarIcms: Boolean; strCodite: String = '');
  Var
   fltBasIcm: Double;
   fltAlqIcm: Double;
   fltAlqIcmRed: Double;
   fltValIcm: Double;
   blnComLub,
   blnRedCargaMedia: Boolean;

   strEmpEst: String;
   blnContribuinteIPI: Boolean;
begin

  If (fEmptyStr(strCodite)) Then
    strCodite := qryEntMer.FieldByname('ENT_CODITE').AsString;

  strEmpEst          := fCadEmp('ESTADO');
  blnContribuinteIPI := (fCfgSis('CONIPI', varBoolean));

  pCalculaTotIte(edtTotIte);

  pPesquisaAbfIcm(qryConAbf, qryConAbf, edtCodAbf.Text);
  With qryConAbf Do
  Begin

    edtDesAbf.Text := FieldByName('ABF_DESABF').AsString;
    blnComLub := fCampotabela('ITE_COMLUB', 'CADITE', ['ITE_CODITE'], [strCodite]) = 'S';

    fRetornaDadosFiscais(strEmpEst,
                         blnContribuinteIPI,
                         False,
                         FieldByName('ABF_CODABF').AsString,
                         fStrToFloat(edtTotIte.Text),
                         fltAlqFor,
                         strEstFor,
                         strCodFor,
                         fItemRevInd(strCodite, VS_StrCodEmp) = 'R',
                         strClaFis,
                         strCodFis,
                         fltBasIcm,
                         fltAlqIcm,
                         fltAlqIcmRed,
                         fltValIcm,
                         fltPerBas,
                         fltPeBaST,
                         fltAliSte,
                         fltAliFCP,
                         blnRedCargaMedia,
                         blnDevolu,
                         True,
                         blnGarantia,
                         blnRecCliGarantia,
                         blnNotaImp,
                         '',
                         blnConEqu Or blnLocEqu,
                         ((qryEntMer.FieldByName('ENT_INDPRES').AsInteger = 1) Or (qryEntMer.FieldByName('ENT_IDDEST').AsInteger = 1) Or (blnPresencial)),
                         nil,
                         FblnAcessadoViaRetornoConsignacao,
                         blnComLub,
                         recNotEle.finalidadeXML = xmlDevolucaoEntradaEmitidaFornecedor);

    blnRedIcmsParana := fltAlqIcmRed > 0;


    If blnGarantia Then
            If blnGarantia or blnRecCliGarantia Then
    Begin
      If (Pos(strCodFis, CST_SUBSTITUICAO) > 0) Then
        strClaFis := strClaFisSub
      Else
        strClaFis := strClaFisGar;
    End;

    pHabilitaIcms((Pos(strCodFis, CST_SUBSTITUICAO) <= 0) And blnZonFra);

    If (Not fEmptyStr(recNotEle.strAutInc)) Then
    Begin
      If (Not fEmptyStr(recNotEle.strClaBri)) And (String(qryEntMer.FieldByName('ENT_I08CFO').AsString).Substring(1,3) = '910') Then
        strClaFis := recNotEle.strClaBri;

      If (strTipFor <> 'M') And
         (Not fEmptyStr(qryEntMer.FieldByName('ENT_SITXML').AsString)) And
         (Not (Pos(qryEntMer.FieldByName('ENT_SITXML').AsString, '_201_202_101_102') > 0)) And
         ((Not ((fCfgSis('SIMPAU',varBoolean)) And (fCfgSis('IGNSIM') = '1'))) Or (Not (Pos(qryEntMer.FieldByName('ENT_SITXML').AsString, '500') > 0))) And
         (qryEntMer.FieldByName('ENT_CSTCAD').AsString = 'N') Then
        strCodFis := qryEntMer.FieldByName('ENT_SITXML').AsString;
    End;

    If SameText(edtEspDoc.Text, 'NF') And (Not fEhRetornoGarantiaFornecedorInterno) Then
    Begin
      If blnBuscaPorChave Then
      Begin
        If fEmptyStr(recNotEle.strAutInc) Then
        Begin

          If blnCarregarIcms Or (Pos(strCodFis, CST_SUBSTITUICAO) > 0) Then
          Begin
            edtBasIcm.Text := FloatToStrF(fltBasIcm, ffFixed, 12, 2);
            edtAlqIcm.Text := FloatToStrF(fltAlqIcm, ffFixed, 12, 2);
            edtValIcm.Text := FloatToStrF(fltValIcm, ffFixed, 12, 2);
          End;

          If (Not qryConIte.Active) Or (Not SameText(qryConIte.FieldByName('ITE_CODITE').AsString, edtCodIte.Text)) Then
            pCarregaItem(edtCodIte.Text, True, True);

          If (qryConIte.FieldByName('ITE_IPIENT').AsFloat > 0) Or (fStrToFloat(edtAlqIPI.Text) > 0) Then
            edtBasIPI.Text := edtTotIte.Text;
        End;
        If qryConCit.FieldByName('ITE_DIFICM').AsString = 'S' Then
        Begin
          edtBasIcm.Text := '0,00';
          edtAlqIcm.Text := '0,00';
          edtValIcm.Text := '0,00';
        End;
      End;
    End
    Else
    Begin
      edtBasIcm.Text := '0,00';
      edtAlqIcm.Text := '0,00';
      edtValIcm.Text := '0,00';

      edtBasIPI.Text := '0,00';

      If fEhRetornoGarantiaFornecedorInterno Then
        strCodFis := '041';
    End;

  End;
end;

procedure TfrmEntMercadorias.pCarregaAbrevFiscalIcms(blnBuscaPorChave, blnCarregarIcms: Boolean);
  Var
   fltBasIcm: Double;
   fltAlqIcm: Double;
   fltAlqIcmRed: Double;
   fltValIcm: Double;
   strIteSer,
   strSerTer,
   strEmpEst: String;
   blnComLub,
   blnRedCargaMedia: Boolean;
   blnContribuinteIPI: Boolean;
begin
  strIteSer := fCfgSis('ITESER');
  strSerTer := fCfgSis('SERTER');

  strEmpEst          := fCadEmp('ESTADO');
  blnContribuinteIPI := (fCfgSis('CONIPI', varBoolean));

//  pCalculaTotIte(edtTotIte);

  pPesquisaAbfIcm(qryConAbf, qryConAbf, edtCodAbf.Text);
  With qryConAbf Do
  Begin

    edtDesAbf.Text := FieldByName('ABF_DESABF').AsString;
    blnComLub := fCampotabela('ITE_COMLUB', 'CADITE', ['ITE_CODITE'], [qryEntMer.FieldByname('ENT_CODITE').AsString]) = 'S';

    fRetornaDadosFiscais(strEmpEst,
                         blnContribuinteIPI,
                         False,
                         FieldByName('ABF_CODABF').AsString,
                         fStrToFloat(edtTotIte.Text),
                         fltAlqFor,
                         strEstFor,
                         strCodFor,
                         fItemRevInd(qryEntMer.FieldByname('ENT_CODITE').AsString, VS_StrCodEmp) = 'R',
                         strClaFis,
                         strCodFis,
                         fltBasIcm,
                         fltAlqIcm,
                         fltAlqIcmRed,
                         fltValIcm,
                         fltPerBas,
                         fltPeBaST,
                         fltAliSte,
                         fltAliFCP,
                         blnRedCargaMedia,
                         blnDevolu,
                         True,
                         blnGarantia,
                         blnRecCliGarantia,
                         blnNotaImp,
                         '',
                         blnConEqu Or blnLocEqu,
                         ((qryEntMer.FieldByName('ENT_INDPRES').AsInteger = 1) Or (qryEntMer.FieldByName('ENT_IDDEST').AsInteger = 1) Or (blnPresencial)),
                         nil,
                         FblnAcessadoViaRetornoConsignacao,
                         blnComLub,
                         recNotEle.finalidadeXML = xmlDevolucaoEntradaEmitidaFornecedor);

    blnRedIcmsParana := fltAlqIcmRed > 0;


    If blnGarantia Then
    Begin
      If (Pos(strCodFis, CST_SUBSTITUICAO) > 0) Then
        strClaFis := strClaFisSub
      Else
        strClaFis := strClaFisGar;
    End;


    If (qryEntMer.FieldByName('ENT_CODITE').AsString = strIteSer) Or
       (qryEntMer.FieldByName('ENT_CODITE').AsString = strSerTer) Or
       (qryEntMer.FieldByName('ENT_TIPPRO').AsString = TIPO_PRODUTO_SPED[9,0]) Then
       strClaFis := strClaFis[1] + '933';
    If (Not fEmptyStr(recNotEle.strAutInc)) Then
    Begin
      If (Not fEmptyStr(recNotEle.strClaBri)) And (String(qryEntMer.FieldByName('ENT_I08CFO').AsString).Substring(1,3) = '910') Then
        strClaFis := recNotEle.strClaBri;

      If (strTipFor <> 'M') And
         (Not fEmptyStr(qryEntMer.FieldByName('ENT_SITXML').AsString)) And
         (Not (Pos(qryEntMer.FieldByName('ENT_SITXML').AsString, '_201_202_101_102') > 0)) And
         ((Not ((fCfgSis('SIMPAU',varBoolean)) And (fCfgSis('IGNSIM') = '1'))) Or (Not (Pos(qryEntMer.FieldByName('ENT_SITXML').AsString, '500') > 0))) And
         (qryEntMer.FieldByName('ENT_CSTCAD').AsString = 'N') Then
        strCodFis := qryEntMer.FieldByName('ENT_SITXML').AsString;
    End;

    If SameText(edtEspDoc.Text, 'NF') And (Not fEhRetornoGarantiaFornecedorInterno) Then
    Begin
      If blnBuscaPorChave And (blnCarregarIcms Or (Pos(strCodFis, CST_SUBSTITUICAO) > 0)) Then
      Begin
        edtBasIcm.Text := FloatToStrF(fltBasIcm, ffFixed, 12, 2);
        edtAlqIcm.Text := FloatToStrF(fltAlqIcm, ffFixed, 12, 2);
        edtValIcm.Text := FloatToStrF(fltValIcm, ffFixed, 12, 2);
      End;
    End
    Else
    Begin
      edtBasIcm.Text := '0,00';
      edtAlqIcm.Text := '0,00';
      edtValIcm.Text := '0,00';

      If fEhRetornoGarantiaFornecedorInterno Then
        strCodFis := '041';
    End;
  End;
end;

procedure TfrmEntMercadorias.pCalculaValIpi(blnRecalculaAliquota: Boolean = False);
  Var
    fltBasIpi: Double;
    fltAlqIpi: Double;
begin

  If fEmptyStr(edtBasIpi.Text) Then
    edtBasIpi.Text := '0,00';

  If fEmptyStr(edtAlqIpi.Text) Then
    edtAlqIpi.Text := '0,00';

  If fEmptyStr(edtvalIpi.Text) Then
    edtvalIpi.Text := '0,00';

  fltBasIpi := fStrToFloat(edtBasIpi.Text);
  fltAlqIpi := fStrToFloat(edtAlqIpi.Text);

  {***********************************************}
  {* NÃO PERMITIR > Q 999% DEVIDO A ERRO NO SPED *}
  {********************************************GB*}
  If (fltAlqIpi > 999) Then
  Begin
    fMensagem('ATENÇÃO', 'A Aliquota de IPI não deve ser Maior que 999%!', ['&OK']);
    Abort;
  End;

  edtBasIPI.Text := FloatToStrF(fltBasIpi, ffFixed, 12, 2);
  edtAlqIpi.Text := FloatToStrF(fltAlqIpi, ffFixed, 12, 2);

  If (blnRecalculaAliquota) And (fltBasIpi > 0) Then
  Begin
    fltAlqIpi      := fFormataFloat( (fStrToFloat(edtvalIpi.Text) * 100) / fltBasIpi, 2);
    edtAlqIPI.Text := FloatToStrF(fltAlqIpi, ffFixed, 12, 2);
  End;

  edtValIpi.Text := FloatToStrF((fltBasIpi * fltAlqIpi) / 100, ffFixed, 12, 2);
end;

procedure TfrmEntMercadorias.edtTotIteEnter(Sender: TObject);
begin
  inherited;
  If fItemCarregadoParaVisualizacao Then
    pCarregaItensAlteracao;

end;

procedure TfrmEntMercadorias.edtTotIteExit(Sender: TObject);
begin
  inherited;
  pCalculaTotIte(Sender);
end;

procedure TfrmEntMercadorias.pMensagem(Const strMensagem: String);
begin
  TMensagem.New(
    TMensagemParams.New
      .Texto(strMensagem)
      .FulFillmentLog(Self.objFulFillmentLogBuilder)
  ).Show;
end;

Function TfrmEntMercadorias.fVerificaLotes: Boolean;
Var
  strIteSer,
  strSerTer,
  strProMat: String;
  blnControlar: Boolean;
Begin
  Result := True;

  if recNotEle.finalidadeXML = xmlDevolucaoEntradaEmitidaFornecedor Then
    Exit;


  If (blnConEqu) Then
    Exit;

  If (blnLocEqu) Then
    Exit;

  strIteSer := fCfgSis('ITESER', VarString);
  strSerTer := fCfgSis('SERTER', VarString);
  strProMat := fCfgSis('PROMAT', VarString);

  fInicializaArmazemLoteADefinir(True);
  blnControlar := Not qryEntMer.controlsDisabled;
  Try
    if blnControlar then
      qryEntMer.DisableControls;

    With qryEntMer Do
    Begin
      qryEntMer.First;
      While Not Eof Do
      Begin
        If (Sametext(FieldByName('ENT_CODITE').AsString, strIteSer) Or
            Sametext(FieldByName('ENT_CODITE').AsString, strSerTer) Or
            Sametext(FieldByName('ENT_CODITE').AsString, strProMat)) Then
        Begin
          Next;
          Continue;
        End;

        If fEmptyStr(FieldByName('ENT_NUMLOT').AsString) And
           objCadLot.fExisteLote(FieldByName('ENT_CODITE').AsString, VS_strCodEmp) Then
        Begin
          Result := False;
          pMensagem('Informe o ' + objCadLot.strTitLab + ' para o produto ' + FieldByName('ENT_CODITE').AsString + ' !');
          Break;
        End;

        If (Not fItemMarmore(FieldByName('ENT_CODITE').AsString)) And
           (Not fEmptyStr(qryEntMer.FieldByName('ENT_NUMLOT').AsString)) And
           (Not objCadLot.fExisteLote(FieldByName('ENT_CODITE').AsString, VS_strCodEmp, FieldByName('ENT_NUMLOT').AsString, False)) Then
        Begin
          Result := False;
          pMensagem('O ' + objCadLot.strTitLab + ' do produto ' + FieldByName('ENT_CODITE').AsString + ' não existe ou não está ativo. Favor verificar!');
          Break;
        End;

        If SameText(FieldByName('ENT_NUMLOT').AsString, 'A DEFINIR') And (fRetReaEnd(FieldByName('ENT_CODITE').AsString) = 'N') and
        not((FblnAcessadoViaRetornoConsignacao) and fUsaRotinaWMS ) Then
        Begin
          If (Not fItemMarmore(FieldByName('ENT_CODITE').AsString)) Then
          Begin
            Result := False;
            pMensagem('O lote do produto ' + FieldByName('ENT_CODITE').AsString + ' não pode ser "A DEFINIR" porque esse produto não realiza endereçamento!');
            Break;
          end;
        End;

        If SameText(edtNumLot.Text, 'A DEFINIR') And (Not fItemMarmore(edtCodIte.Text)) And (blnDevolu) And (Not (fCfgSis('DEVEND', varBoolean))) And (Not fUsaRotinaWMS) Then
        Begin
          Result := False;
          pMensagem('O lote do produto ' + FieldByName('ENT_CODITE').AsString + ' não pode ser "A DEFINIR" porque entrada por devolução não realiza endereçamento');
          Break;
        End;

        If fUsaRotinaWMS Then
        Begin

          If fEmptyStr(FieldByName('ENT_NUMLOT').AsString)  Then
          Begin
            Result := False;
            pMensagem('Somente é permitido entrada de mercadorias para produtos que possuem Lote cadastrado. ' +
                      'Verifique o Cadastro de Lotes para o produto ' +
                      FieldByName('ENT_CODITE').AsString + ' - ' +  FieldByName('ENT_DESITE').AsString + ' !');
            Break;
          End

          Else If (Not objCadLot.fExisteLote(FieldByName('ENT_CODITE').AsString, VS_strCodEmp, 'A DEFINIR', False)) And
                  (fRetReaEnd(FieldByName('ENT_CODITE').AsString) <> 'N') Then
          Begin
            Result := False;
            pMensagem('Produto ' + FieldByName('ENT_CODITE').AsString + '-' +
                      FieldByName('ENT_DESITE').AsString + ' não possui o Lote A DEFINIR cadastrado!');
            break;
          End

          Else If (not (blnDevolu and fCfgSis('MANEND', varBoolean))) and (not blnRecCliGarantia ) And (FieldByName('ENT_NUMLOT').AsString <> 'A DEFINIR')
            And (fRetReaEnd(FieldByName('ENT_CODITE').AsString) <> 'N') and (not FblnAcessadoViaRetornoConsignacao ) Then
          Begin
            Result := False;
            pMensagem('Somente é permitido realizar entrada de mercadorias com o Lote A DEFINIR. Verifique o Lote ' +
                      'do produto ' + FieldByName('ENT_CODITE').AsString + ' - ' + FieldByName('ENT_DESITE').AsString + ' !');
            Break;
          End;
        End;

        Next;
      End;
    End;
  finally
    if blnControlar then
      qryEntMer.EnableControls
  End;
End;

procedure TfrmEntMercadorias.btnAdicionarClick(Sender: TObject);
  Var
    intRecNo, intPosicaoGrid: Integer;
    blnEdtUnidade, blnEdicao: Boolean;
    strCodMot: String;
    Key : Word;
    Shift: TShiftState;

    lrecFCP: TRecDadosFCP;
    strProximoItem: String;
begin
  If fItemCarregadoParaVisualizacao Then
    pCarregaItensAlteracao;
  blnAdicionando := True;
  blnEdicao := True;
  Try
    If blnSemInc And (btnAdicionar.Tag = 0) Then
    Begin
      pLimpaDadosItem;
      pMensagemOk('Inclusão de novos itens não permitida!');
      Exit;
    End;

    If blnConEqu And (btnAdicionar.Tag = 0) And (edtCodIte.Text <> fCfgSis('ITECON', VarString)) Then
    Begin
      pLimpaDadosItem;
      pMensagemOk('Só é possível informar o item ' + fCfgSis('ITECON', VarString) + '-' +
                  fRetNomProduto(fCfgSis('ITECON', VarString)) + ' para este tipo de operação!');
      Exit;
    End;

    If (btnAdicionar.Tag = 0) And (Not fTravaItem(edtCodIte.Text)) Then
    Begin
      Exit;
    End;

    // pego o próximo item.
    intPosicaoGrid := qryEntMer.RecNo;
    dbgItens.NavigatorButtons.Next.Click;
    strProximoItem := qryEntMer.FieldByName('ENT_CODITE').AsString;
    qryEntMer.RecNo := intPosicaoGrid;
    //fim

    If btnAdicionar.Tag <= 0 Then
      intRecNo := dbgItens.DataController.DataSource.DataSet.RecordCount + 1
    Else
      intRecNo := dbgItens.DataController.DataSource.DataSet.RecNo;

    strCodMot := '';

    inherited;

    blnEdtUnidade := fCfgSis('EDUNEM', varBoolean);

    If (((Not fEmptyStr(recNotEle.strAutInc)) And
         fValidaCampos(edtUnidad, True) and
         fValidaCampos(edtQtdIte, True) and
         fValidaCampos(edtEmbala, True) and
         fValidaCampos(edtUnitar, True) And
         (edtBasIcm.ReadOnly Or fValidaCampos(edtBasIcm, True)) And
         (edtAlqIcm.ReadOnly Or fValidaCampos(edtAlqIcm, True))
        ) Or

        (blnPrecoPraticado And fValidaCampos(edtNumLot, True)) Or

       fVerificaCampos) And

       fVerificaQuantidadeDiferente(edtCodIte.Text,
                                    fStrToFloat(edtQtdIte.Text) * IIF(fStrToFloat(edtEmbala.Text) <> 0, fStrToFloat(edtEmbala.Text), 1),
                                    fltQtdAnt,
                                    Nil,
                                    qryItePed,
                                    blnSenDif) Then
    Begin

      If blnOcilaP And (Not blnDevolu) And
         (Not fVerificaVariacaoPreco(qryItePed, edtCodIte.text,
                                    fStrToFloat(edtUnitar.Text) / IIF(fStrToFloat(edtEmbala.Text) <> 0, fStrToFloat(edtEmbala.Text), 1) , fltOciVlr)) Then
        pMensagemOk('Você está alterando o valor unitário do produto para um limite fora da tolerancia de ' + FormatFloat('#0.00', fltOciVlr) + ', confirme com seu gerente se o procedimento está correto, pois será solicitado senha de liberação no fechamento do documento.');


      strAbfAnt := '';

      pCalculaTotIte(edtTotIte);
      pCalculaValIpi;

      If (Not SameText(edtEspDoc.Text, 'NF')) And fEmptyStr(recNotEle.strAutInc) Then
      Begin
        edtBasIcm.Text := '0,00';
        edtAlqIcm.Text := '0,00';
        edtValIcm.Text := '0,00';
      End;

      If Not fEmptyStr(recNotEle.strAutInc) Then
      Begin
        If RoundTo(fStrToFloat(edtTotIte.Text), -2) <> RoundTo(fltValTot, -2) Then
        Begin
          fMensagem('','O valor total deve ser R$ ' + FloatToStrF(fltValTot,ffNumber,12,2),['&OK']);
          edtTotIte.Text := FloatToStrF(fltValTot,ffNumber,12,2);
          pSetFocus(edtTotIte);
          Exit;
        End;
      End;

      If btnAdicionar.Tag <= 0 Then
      Begin
        If fCalcularFcpDevolucao Then
          lrecFCP := fCalcularFcp(fStrToFloat(edtBasIcm.Text), fltAliFCP, fltPeBaST, strCodFor, edtCodAbf.Text, '')
        else
          lrecFCP.Create(0);

        blnEdicao := False;
        //se estiver adicionando um novo item na AD entao pede o motivo para esse item.
        If blnDevolu And (Not fEmptyStr(strAutDev)) Then
          strCodMot := fRetornaMotivoAD;

        pAdicionaItem(fStrToFloat(edtUnitar.Text), fStrToFloat(edtQtdIte.Text), fStrToFloat(edtTotIte.Text),
                      fStrToFloat(edtAlqIpi.Text), fStrToFloat(edtBasIPI.Text), fStrToFloat(edtvalIpi.Text),
                      fStrToFloat(edtAlqIcm.Text), fStrToFloat(edtBasIcm.Text), fStrToFloat(edtValIcm.Text),
                      edtCodIte.Text, qryConCit.fieldbyname('ITE_CODGRU').AsString,
                      edtDesIte.Text, edtRefere.Text, strCodUni, edtCodAbf.Text, edtDesAbf.Text,'', '',
                      qryConCit.FieldByName('ITE_CODFAB').AsString, '', '', '', '', edtNumLot.Text,
                      qryConCit.FieldByName('ITE_RPRENT').AsString,
                      strCodAca,
                      strEmpAca,
                      strProAca,
                      strDesAca,
                      fltPreAca,
                      fltSalAca,
                      edtClaIpi.Text,
                      IIF(fStrToFloat(edtEmbala.Text) = 0, 1, fStrToFloat(edtEmbala.Text)), strUniEmb,
                      strCodMot,
                      '',
                      0,
                      '',
                      edtCodCest.Text,
                      '',
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
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      -1,
                      -1
                      -1,
                      -1,
                      'N',
                      '',
                      lrecFCP.fltBCFCPST,                                //  fltBFCPST: Double = 0;
                      lrecFCP.fltPFCPST,                                 //  fltPFCPST: Double = 0;
                      lrecFCP.fltVFCPST,                                 //  fltVFCPST: Double = 0;
                      lrecFCP.fltBCFCP,                                  //  fltVBCFCP: Double = 0;
                      lrecFCP.fltAliFcp,                                 //  fltPERFCP: Double = 0;
                      lrecFCP.fltValFCP,                                 //  fltVALFCP: Double = 0;
                      '',
                      '',
                      intRecNo,
                      qryConIte.FieldByName('MAR_DESMAR').AsString);

      End
      Else
      Begin
        If fEmptyStr(recNotEle.strAutInc) Then
          pAlteraItem
        Else
        Begin
          pAlteraItemNfe;
          edtCodAbf.Enabled := True;
          edtBasIPI.Enabled := True;
          edtAlqIPI.Enabled := True;
          edtvalIpi.Enabled := True;
          pnlItem.Enabled   := False;
          pSetFocus(dbgItensGrid);
        End;
      End;

      strCodAca := '';
      strDesAca := '';
      strEmpAca := '';
      strProAca := 'N';
      fltPreAca := 0.0;
      fltSalAca := 0.0;

      pAtualizaTabela;

  //    If Not blnSemInc Then
      pLimpaDadosItem;
    
      pCalculaTotais;

      pSetFocus(edtCodIte);

    End;

    qryEntMer.RecNo := intPosicaoGrid;

    edtSigla.Text := '';

    edtDesIte.ReadOnly := True;
    edtDesIte.TabStop  := False;

    edtUnidad.ReadOnly := Not blnEdtUnidade;
    edtUnidad.TabStop  := blnEdtUnidade;

    If blnEdicao Then
    Begin
      //encontro o próximo item
      qryEntMer.Locate('ENT_CODITE', strProximoItem, []);
      Key := VK_Return;
      dbgItensKeyDown(Sender, Key, Shift);

      If edtEspDoc.Text = 'PD' then
      Begin
        pSetFocus(dbgItensGrid);
        dbgItens.Controller.FocusedColumnIndex  := 5;
      End
    End;

  Finally
    blnAdicionando := False;
  End
end;

procedure TfrmEntMercadorias.pAdicionaItem(fltUnitar, fltQtdIte, fltTotIte,
                                           fltAlqIpi, fltBasIPI, fltValIpi,
                                           fltAlqIcm, fltBasIcm, fltValIcm: Double;
                                           strCodIte, strCodGru, strDesIte, strRefere, strUnidade,
                                           strCodAbf, strDesAbf,
                                          {*********************************************************************}
                                          {* AUTOINCREMENTO DO ITEM CORRESPONDETE A VENDA QUANDO FOR DEVOLUÇÃO *}
                                          {******************************************************************LA*}
                                           strAutVen,
                                           strTabVen,
                                           strCodFab,
                                           strNumPed,
                                           strEspDoc,
                                           strCodEmp,
                                           strCodCli,
                                           strNumLot,
                                           strRprEnt,
                                           strCodAca,
                                           strEmpAca,
                                           strProAca,
                                           strDesAca: String;
                                           fltPreAca,
                                           fltSalAca: Double;
                                           strClaIpi: String;
                                           fltEmbala: Double;
                                           strUniEmb: String;
                                           strCodMot: String;
                                           strCodDiv: String='';
                                           fltDEsUni: Double=0;
                                           strEmp_Pd: String = '';
                                           strCDCEST: string = '';

                                           strIncPisDev: string = '';
                                           strCstCofDev: string = '';
                                           strCstPisDev: string = '';
                                           strNR_PisDev: string = '';
                                           strNR_CofDev: string = '';
                                           strCodFisDev: string = '';
                                           fltValRetDev: Double = 0;
                                           fltBasRetDev: Double = 0;
                                           fltVal_RtDev: Double = 0;
                                           fltPerBasDev: Double = 0;
                                           fltPeBaSTDev: Double = 0;
                                           fltPerRedDev: Double = 0;
                                           fltAlqRetDev: Double = 0;
                                           fltValCofDev: Double = 0;
                                           fltBasPisDev: Double = 0;
                                           fltValPisDev: Double = 0;
                                           fltBasCofDev: Double = 0;
                                           fltDesAceDev: Double = 0;
                                           fltAlqCofDev: Double = 0;
                                           fltAlqPisDev: Double = 0;
                                           fltDesEsp   : Double = -1;
                                           fltValFre   : Double = -1;
                                           fltQtdOri   : Double = -1;
                                           strProEmb: String = 'N';
                                           strImpDir: String = '';
                                           fltBFCPST: Double = 0;
                                           fltPFCPST: Double = 0;
                                           fltVFCPST: Double = 0;
                                           fltVBCFCP: Double = 0;
                                           fltPERFCP: Double = 0;
                                           fltVALFCP: Double = 0;
                                           strIdePro: string = '';
                                           strIteTin: String = '';
                                           intnItem: Integer = 0;
                                           strDesMar: String = '';
                                           strIncFut: String = '');

  Var
    strSQL: String;
    strTipAbf: String;
    fltBasRet: Double;
    fltValRet: Double;

    fltBasAnt: Double;
    fltValAnt: Double;

    fltValIVA: Double;

    fltPreCom: Double;
    fltPreCus: Double;

    cpcParams: TParCalculaPrecoCusto;
    qryGenMer: TUniQuery;
    blnIsentas,
    blnSubstituido: Boolean;
    blnAntecipado : Boolean;

    recPrecos: Array[1..7] Of TRecPrecos;
    intCont  : Integer;

    intTabPrc: Integer;

    function fItem(strCampo: String): TField;
    begin
      Result := qryConIte.FieldByName('ITE_' + strCampo);
    end;

    function fZeraICMSDevolucao: Boolean;
    Begin
      If strImpDir = '' Then
        strImpDir := 'N';
      Result := fCfgSis('IMPDIR') = 'N';
      If  fCfgSis('IMPDIR') = 'S'  Then
        Result := strImpDir = 'N';
    End;

begin
  cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);
  qryGenMer := fCriaQuery(Self);
  Try
    If (blnDevolu) Or (blnConEqu) Or (blnLocEqu) or blnRecCliGarantia or (FblnAcessadoViaRetornoConsignacao) Then
      strTipAbf := fGetTipoAbfCliente(strCodFor)
    Else
      strTipAbf := fGetTipoAbfFornecedor(strCodFor);

    fltValIVA := fRetornaPercIVA(strCodAbf,strEstFor,strTipAbf);

    If strImpDir = '' Then
    Begin
      If fCfgSis('IMPDIG') = '2' Then
        strImpDir := fItem('IMPDIR').AsString
      Else
        strImpDir := fCampotabela('ITE_IMPDIR', 'CADITE', ['ITE_CODITE'], [fItem('CODITE').AsString]);
    End;

    fltBasRet := 0.0;
    blnSubstituido := False;

    If blnPrecoPraticado Then
    Begin
      strCodFis := strCodFisDev;
    End;

    If Pos(strCodFis, CST_SUBSTITUICAO) > 0 Then
    Begin
      fltBasRet := fFormataFloat((((fltTotIte + fltValIpi) * fltPeBaST) /100) * fltValIVA, 2);
      blnSubstituido := True;
    End;

    fltValRet := fRetornaValRet(fCadEmp('ESTADO'), fltBasRet, fltValIcm, fltAliSte);

    // ANTECIPADO
    fltBasAnt := 0.0;
    fltValAnt := 0.0;
    blnAntecipado := False;

    If blnDevolu Then
    Begin
      If (blnSubstituido) And fZeraICMSDevolucao And (fEmptyStr(strDocSel)) Then
      Begin
        fltPerBas := 0.0;
        fltBasIcm := 0.0;
        fltAlqIcm := 0.0;
        fltValIcm := 0.0;
      End;
    End
    Else
    If (blnSubstituido Or blnAntecipado or ((blnSimPau) and not(blnPeIcms))) Then
    Begin
      fltPerBas := 0.0;
      fltBasIcm := 0.0;
      fltAlqIcm := 0.0;
      fltValIcm := 0.0;
    End;

    If blnPrecoPraticado Then
    Begin
      strIncPis := strIncPisDev;
      strCodFis := strCodFisDev;
      fltDesAce := fltDesAceDev;
      fltValRet := fltValRetDev;
      fltPerBas := fltPerBasDev;
      fltPeBaST := fltPeBaSTDev;
      fltBasRet := fltBasRetDev;
    End;

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO ';
    strSQL := strSQL + '  TMP_ENTMER ';
    strSQL := strSQL + '( ENT_IVA_ST,';
    strSQL := strSQL + '  ENT_N_ITEM,';
    strSQL := strSQL + '  ENT_N_ITEM_TELA,';
    strSQL := strSQL + '  ENT_NUMPED, ';
    strSQL := strSQL + '  ENT_ESPDOC, ';
    strSQL := strSQL + '  ENT_CODEMP, ';
    strSQL := strSQL + '  ENT_CODFOR, ';
    strSQL := strSQL + '  ENT_DIFICM, ';
    strSQL := strSQL + '  ENT_CODITE, ';
    strSQL := strSQL + '  ENT_CODGRU, ';
    strSQL := strSQL + '  ENT_DESITE, ';
    strSQL := strSQL + '  ENT_REFERE, ';
    strSQL := strSQL + '  ENT_CODUNI, ';
    strSQL := strSQL + '  ENT_CODABF, ';
    strSQL := strSQL + '  ENT_DESABF, ';
    strSQL := strSQL + '  ENT_QTDITE, ';
    strSQL := strSQL + '  ENT_UNITAR, ';
    strSQL := strSQL + '  ENT_PERIPI, ';
    strSQL := strSQL + '  ENT_TOTITE, ';
    strSQL := strSQL + '  ENT_PRECOM, ';
    strSQL := strSQL + '  ENT_DESF01, ';
    strSQL := strSQL + '  ENT_DESF02, ';
    strSQL := strSQL + '  ENT_DESF03, ';
    strSQL := strSQL + '  ENT_DESF04, ';
    strSQL := strSQL + '  ENT_DESF05, ';
    strSQL := strSQL + '  ENT_DESF06, ';
    strSQL := strSQL + '  ENT_ICMENT, ';
    strSQL := strSQL + '  ENT_SUBFED, ';
    strSQL := strSQL + '  ENT_IPIENT, ';
    strSQL := strSQL + '  ENT_FREENT, ';
    strSQL := strSQL + '  ENT_FREITE, ';
    strSQL := strSQL + '  ENT_ACRFIN, ';
    strSQL := strSQL + '  ENT_SUBSTI, ';
    strSQL := strSQL + '  ENT_OUTVAL, ';
    strSQL := strSQL + '  ENT_IMPFED, ';
    strSQL := strSQL + '  ENT_DESOPE, ';
    strSQL := strSQL + '  ENT_DESADB, ';
    strSQL := strSQL + '  ENT_PRECUS, ';
    strSQL := strSQL + '  ENT_ICMSAI, ';
    strSQL := strSQL + '  ENT_DESMAX, ';
    strSQL := strSQL + '  ENT_DESMGE, ';    
    strSQL := strSQL + '  ENT_DESMSU, ';
    strSQL := strSQL + '  ENT_TCIFCU, ';
    strSQL := strSQL + '  ENT_TSCUST, ';
    strSQL := strSQL + '  ENT_DEPICO, ';
    strSQL := strSQL + '  ENT_DEICMS, ';
    strSQL := strSQL + '  ENT_FATREG, ';

    For intTabPrc := 1 To Length(VS_strTabPrc) Do
    Begin
      strSQL := strSQL + '  ENT_MARBR' + IntToStr(intTabPrc) + ', ';
      strSQL := strSQL + '  ENT_PREVE' + IntToStr(intTabPrc) + ', ';
      strSQL := strSQL + '  ENT_COMTB' + IntToStr(intTabPrc) + ', ';
    End;

    strSQL := strSQL + '  ENT_MARMIN, ';
    strSQL := strSQL + '  ENT_MARMSG, ';
    strSQL := strSQL + '  ENT_MARMGE, ';
    strSQL := strSQL + '  ENT_CLAIPI, ';    
    strSQL := strSQL + '  ENT_CLAFIS, ';
    strSQL := strSQL + '  ENT_CODFIS, ';
    strSQL := strSQL + '  ENT_VLRCON, ';
    strSQL := strSQL + '  ENT_PERBAS, ';
    strSQL := strSQL + '  ENT_BASICM, ';
    strSQL := strSQL + '  ENT_ALQICM, ';
    strSQL := strSQL + '  ENT_VALICM, ';

    strSQL := strSQL + '  ENT_BASIPI, ';
    strSQL := strSQL + '  ENT_ALQIPI, ';
    strSQL := strSQL + '  ENT_VALIPI, ';

    strSQL := strSQL + '  ENT_BAEIPI, ';
    strSQL := strSQL + '  ENT_ALEIPI, ';
    strSQL := strSQL + '  ENT_VAEIPI, ';

    strSQL := strSQL + '  ENT_IPISUB, ';
    strSQL := strSQL + '  ENT_ISENTO, ';
    strSQL := strSQL + '  ENT_PEBAST, ';
    strSQL := strSQL + '  ENT_BASRET, ';
    strSQL := strSQL + '  ENT_VALRET, ';
    strSQL := strSQL + '  ENT_RETORI, ';

    strSQL := strSQL + '  ENT_BAERET, ';
    strSQL := strSQL + '  ENT_VAERET, ';

    strSQL := strSQL + '  ENT_BASANT, ';
    strSQL := strSQL + '  ENT_VALANT, ';
    strSQL := strSQL + '  ENT_OUTRAS, ';
    strSQL := strSQL + '  ENT_DTABAL, ';
    strSQL := strSQL + '  ENT_LOCFIS, ';
    strSQL := strSQL + '  ENT_NUMSEL, ';
    strSQL := strSQL + '  ENT_CODACA, ';
    strSQL := strSQL + '  ENT_EMPACA, ';
    strSQL := strSQL + '  ENT_PROACA, ';
    strSQL := strSQL + '  ENT_DESACA, ';
    strSQL := strSQL + '  ENT_SALACA, ';
    strSQL := strSQL + '  ENT_PREACA, ';
    strSQL := strSQL + '  ENT_CODFAB, ';
    strSQL := strSQL + '  ENT_RPRENT, ';

    strSQL := strSQL + '  ENT_QTDMXD, ';

    strSQL := strSQL + '  ENT_EMP_PD, ';

    If Not SameText(strAutVen,'') Then
      strSQL := strSQL + '  ENT_AUTVEN, ';
    If Not SameText(strTabVen,'') Then
      strSQL := strSQL + '  ENT_TABELA, ';

    strSQL := strSQL + '  ENT_CODMOT, ';  //Cód. Motivo dos itens da AD CRM

    strSQL := strSQL + '  ENT_INCPIS, ';
    strSQL := strSQL + '  ENT_NUMLOT, ';
    strSQL := strSQL + '  ENT_IDEPRO, ';
    strSQL := strSQL + '  ENT_ITETIN, ';
    strSQL := strSQL + '  ENT_GRAMAR, ';
    strSQL := strSQL + '  ENT_EMBALA, ';
    strSQL := strSQL + '  ENT_CODDIV, ';
    strSQL := strSQL + '  ENT_UNIEMB, ';
    strSQL := strSQL + '  ENT_CDCEST, ';

    If blnPrecoPraticado Then
    Begin
      strSQL := strSQL + ' ENT_VAL_RT, ';
      strSQL := strSQL + ' ENT_PERRED, ';
      strSQL := strSQL + ' ENT_ALQRET, ';

      strSQL := strSQL + ' ENT_VALCOF, ';
      strSQL := strSQL + ' ENT_BASPIS, ';
      strSQL := strSQL + ' ENT_VALPIS, ';
      strSQL := strSQL + ' ENT_BASCOF, ';
      strSQL := strSQL + ' ENT_DESACE, ';
      strSQL := strSQL + ' ENT_ALQCOF, ';
      strSQL := strSQL + ' ENT_ALQPIS, ';

      strSQL := strSQL + ' ENT_CSTCOF, ';
      strSQL := strSQL + ' ENT_CSTPIS, ';
      strSQL := strSQL + ' ENT_NR_PIS, ';
      strSQL := strSQL + ' ENT_NR_COF, ';
    End;

    If fltDesEsp >= 0 Then
      strSQL := strSQL + ' ENT_DESESP, ';

    If fltValFre >= 0 Then
      strSQL := strSQL + ' ENT_VALFRE, ';

    If fltQtdOri >= 0 Then
      strSQL := strSQL + ' ENT_QTDORI, ';

    strSQL := strSQL + '  ENT_DESUNI, AUTOINCREMENTO_GRAVACAO, ';
    strSQL := strSQL + '  ENT_EXISTELOTE, ';
    strSQL := strSQL + '  ENT_SIGUNI, ';
    strSQL := strSQL + '  ENT_SALDOS, ';
    strSQL := strSQL + '  ENT_PROEMB, ';
    strSQL := strSQL + '  ENT_RICMPR, ';
    strSQL := strSQL + '  ENT_IMPDIR, ';

    strSQL := strSQL + '  ENT_BFCPST, ';
    strSQL := strSQL + '  ENT_PFCPST, ';
    strSQL := strSQL + '  ENT_VFCPST, ';

    strSQL := strSQL + '  ENT_TIPPRO, ';
    strSQL := strSQL + '  ENT_PERFCP, ';
    strSQL := strSQL + '  ENT_VALFCP, ';
    strSQL := strSQL + '  ENT_VBCFCP, ';
    strSQL := strSQL + '  ENT_DESMAR, ';
    strSQL := strSQL + '  ENT_MATREV, ';
    strSQL := strSQL + '  ENT_ALQSTI, ';
    strSQL := strSQL + '  ENT_INCFUT ) ';

    strSQL := strSQL + '  VALUES ( ';
    strSQL := strSQL + ' :IVA_ST, ';
    strSQL := strSQL + ' :N_ITEM, ';
    strSQL := strSQL + ' :N_ITEM_TELA, ';
    strSQL := strSQL + ' :NUMPED, ';
    strSQL := strSQL + ' :ESPDOC, ';
    strSQL := strSQL + ' :CODEMP, ';
    strSQL := strSQL + ' :CODFOR, ';
    strSQL := strSQL + ' :DIFICM, ';
    strSQL := strSQL + ' :CODITE, ';
    strSQL := strSQL + ' :CODGRU, ';
    strSQL := strSQL + ' :DESITE, ';
    strSQL := strSQL + ' :REFERE, ';
    strSQL := strSQL + ' :CODUNI, ';
    strSQL := strSQL + ' :CODABF, ';
    strSQL := strSQL + ' :DESABF, ';
    strSQL := strSQL + ' :QTDITE, ';
    strSQL := strSQL + ' :UNITAR, ';
    strSQL := strSQL + ' :PERIPI, ';
    strSQL := strSQL + ' :TOTITE, ';
    strSQL := strSQL + ' :PRECOM, ';
    strSQL := strSQL + ' :DESF01, ';
    strSQL := strSQL + ' :DESF02, ';
    strSQL := strSQL + ' :DESF03, ';
    strSQL := strSQL + ' :DESF04, ';
    strSQL := strSQL + ' :DESF05, ';
    strSQL := strSQL + ' :DESF06, ';
    strSQL := strSQL + ' :ICMENT, ';
    strSQL := strSQL + ' :SUBFED, ';
    strSQL := strSQL + ' :IPIENT, ';
    strSQL := strSQL + ' :FREENT, ';
    strSQL := strSQL + ' :FREITE, ';
    strSQL := strSQL + ' :ACRFIN, ';
    strSQL := strSQL + ' :SUBSTI, ';
    strSQL := strSQL + ' :OUTVAL, ';
    strSQL := strSQL + ' :IMPFED, ';
    strSQL := strSQL + ' :DESOPE, ';
    strSQL := strSQL + ' :DESADB, ';
    strSQL := strSQL + ' :PRECUS, ';
    strSQL := strSQL + ' :ICMSAI, ';
    strSQL := strSQL + ' :DESMAX, ';
    strSQL := strSQL + ' :DESMGE, ';
    strSQL := strSQL + ' :DESMSU, ';
    strSQL := strSQL + ' :TCIFCU, ';
    strSQL := strSQL + ' :TSCUST, ';
    strSQL := strSQL + ' :DEPICO, ';
    strSQL := strSQL + ' :DEICMS, ';
    strSQL := strSQL + ' :FATREG, ';

    For intTabPrc := 1 To Length(VS_strTabPrc) Do
    Begin
      strSQL := strSQL + ' :MARBR' + IntToStr(intTabPrc) + ', ';
      strSQL := strSQL + ' :PREVE' + IntToStr(intTabPrc) + ', ';
      strSQL := strSQL + ' :COMTB' + IntToStr(intTabPrc) + ', ';
    End;

    strSQL := strSQL + ' :MARMIN, ';
    strSQL := strSQL + ' :MARMSG, ';
    strSQL := strSQL + ' :MARMGE, ';
    strSQL := strSQL + ' :CLAIPI, ';
    strSQL := strSQL + ' :CLAFIS, ';
    strSQL := strSQL + ' :CODFIS, ';
    strSQL := strSQL + ' :VLRCON, ';
    strSQL := strSQL + ' :PERBAS, ';
    strSQL := strSQL + ' :BASICM, ';
    strSQL := strSQL + ' :ALQICM, ';
    strSQL := strSQL + ' :VALICM, ';

    strSQL := strSQL + ' :BASIPI, ';
    strSQL := strSQL + ' :ALQIPI, ';
    strSQL := strSQL + ' :VALIPI, ';

    strSQL := strSQL + ' :BASIPI, ';
    strSQL := strSQL + ' :ALQIPI, ';
    strSQL := strSQL + ' :VALIPI, ';

    strSQL := strSQL + ' :VALIPI, ';
    strSQL := strSQL + ' :ISENTO, ';
    strSQL := strSQL + ' :PEBAST, ';
    strSQL := strSQL + ' :BASRET, ';
    strSQL := strSQL + ' :VALRET, ';
    strSQL := strSQL + ' :VALRET, ';
    strSQL := strSQL + ' :BAERET, ';
    strSQL := strSQL + ' :VAERET, ';
    strSQL := strSQL + ' :BASANT, ';
    strSQL := strSQL + ' :VALANT, ';
    strSQL := strSQL + ' :OUTRAS, ';
    strSQL := strSQL + ' :DTABAL, ';
    strSQL := strSQL + ' :LOCFIS, ';
    strSQL := strSQL + ' :NUMSEL, ';
    strSQL := strSQL + ' :CODACA, ';
    strSQL := strSQL + ' :EMPACA, ';
    strSQL := strSQL + ' :PROACA, ';
    strSQL := strSQL + ' :DESACA, ';
    strSQL := strSQL + ' :SALACA, ';
    strSQL := strSQL + ' :PREACA, ';
    strSQL := strSQL + ' :CODFAB, ';
    strSQL := strSQL + ' :RPRENT, ';

    strSQL := strSQL + ' :QTDMXD, ';

    strSQL := strSQL + ' :EMP_PD, ';

    If Not SameText(strAutVen,'') Then
      strSQL := strSQL + ' :AUTVEN, ';

    If Not SameText(strTabVen,'') Then
      strSQL := strSQL + ' :TABVEN, ';
    strSQL := strSQL + ' :CODMOT, ';

    strSQL := strSQL + ' :INCPIS, ';
    strSQL := strSQL + ' :NUMLOT, ';
    strSQL := strSQL + ' :IDEPRO, ';
    strSQL := strSQL + ' :ITETIN, ';
    strSQL := strSQL + ' :GRAMAR, ';
    strSQL := strSQL + ' :EMBALA, ';
    strSQL := strSQL + ' :CODDIV, ';
    strSQL := strSQL + ' :UNIEMB, ';
    strSQL := strSQL + ' :CDCEST, ';

    If blnPrecoPraticado Then
    Begin
      strSQL := strSQL + ' :VAL_RT, ';
      strSQL := strSQL + ' :PERRED, ';
      strSQL := strSQL + ' :ALQRET, ';

      strSQL := strSQL + ' :VALCOF, ';
      strSQL := strSQL + ' :BASPIS, ';
      strSQL := strSQL + ' :VALPIS, ';
      strSQL := strSQL + ' :BASCOF, ';
      strSQL := strSQL + ' :DESACE, ';
      strSQL := strSQL + ' :ALQCOF, ';
      strSQL := strSQL + ' :ALQPIS, ';

      strSQL := strSQL + ' :CSTCOF, ';
      strSQL := strSQL + ' :CSTPIS, ';
      strSQL := strSQL + ' :NR_PIS, ';
      strSQL := strSQL + ' :NR_COF, ';
    End;

    If fltDesEsp >= 0 Then
      strSQL := strSQL + ' :DESESP, ';

    If fltValFre >= 0 Then
      strSQL := strSQL + ' :VALFRE, ';

    If fltQtdOri >= 0 Then
      strSQL := strSQL + ' :QTDORI, ';

    strSQL := strSQL + ' :DESUNI, :AUTOINCREMENTO_GRAVACAO, ';
    strSQL := strSQL + ' :EXISTELOTE, ';
    strSQL := strSQL + ' :SIGUNI, ';
    strSQL := strSQL + ' :SALDOS, ';
    strSQL := strSQL + ' :PROEMB, ';
    strSQL := strSQL + ' :RICMPR, ';
    strSQL := strSQL + ' :IMPDIR, ';
    strSQL := strSQL + ' :BFCPST, ';
    strSQL := strSQL + ' :PFCPST, ';
    strSQL := strSQL + ' :VFCPST, ';
    strSQL := strSQL + ' :TIPPRO, ';
    strSQL := strSQL + ' :PERFCP, ';
    strSQL := strSQL + ' :VALFCP, ';
    strSQL := strSQL + ' :VBCFCP, ';
    strSQL := strSQL + ' :DESMAR, ';
    strSQL := strSQL + ' :MATREV, ';
    strSQL := strSQL + ' :ALQSTI, ';
    strSQL := strSQL + ' :INCFUT )';


    With qryGenMer Do
    Begin
      If (Not qryConIte.Active) Or (qryConIte.FieldByName('ITE_CODITE').AsString <> strCodIte) Then
        pCarregaItemDevolucao(strCodIte);

      fltPreCom := fltUnitar;

      {**********************************}
      {* CALCULA PREÇOS DE CUSTO        *}
      {*******************************JB*}
      With cpcParams Do
      Begin
        curPreCom := fltPreCom;

        curDesF01 := fItem('DESF01').AsFloat;
        curDesF02 := fItem('DESF02').AsFloat;
        curDesF03 := fItem('DESF03').AsFloat;
        curDesF04 := fItem('DESF04').AsFloat;
        curDesF05 := fItem('DESF05').AsFloat;
        curDesF06 := fItem('DESF06').AsFloat;

        curSubsti := fItem('SUBSTI').AsFloat;
        curICMSEnt:= fItem('ICMENT').AsFloat;

        If blnAtuIpi Then
          curIPIEnt := fltAlqIpi
        Else
          curIPIEnt := fItem('IPIENT').AsFloat;

        If blnUsaLotePrecos Then
        Begin

          If blnAtuSub Then
          Begin
            If fltTotIte <= 0 Then
              curSubsti := 0
            Else
              curSubsti := fFormataFloat(((fltValRet + fltValAnt)/ fltTotIte * 100), 2);
          End;

          If blnAtuIcm Then
            curICMSEnt := fltAlqIcm;
        End;

        curFrete  := fItem('FREENT').AsFloat;
        curValFre := fItem('VALFRE').AsFloat;
        curAcrFin := fItem('ACRFIN').AsFloat;
        curDesAdb := fItem('DESADB').AsFloat;
        curSubFed := fItem('SUBFED').AsFloat;

        if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
        begin
          curTCIFCu := fItem('TCIFCU').AsFloat;
          curTSCust := fItem('TSCUST').AsFloat;
          curDePiCo := fItem('DEPICO').AsFloat;
          curDeICMS := fItem('DEICMS').AsFloat;
          curFatReg := fItem('FATREG').AsFloat;
        end
        else
        begin
          curTCIFCu := 0;
          curTSCust := 0;
          curDePiCo := 0;
          curDeICMS := 0;
          curFatReg := 0;
        end;
      End;

      fltPreCus := cpcParams.fCalculaPrecoCusto();

      For intCont := 1 To Length(recPrecos) Do
      Begin
        recPrecos[intCont].fltComiss := fItem('COMTB' + IntToStr(intCont)).AsFloat;

        If ((Not blnFatPre) Or (blnFatPre And (Not objFatPre.fTabelaAtiva(IntCont)))) Or (IntCont = 1) Then
          recPrecos[intCont].fltPreVen := fCalculaPrecoVenda(1,
                                                             fltPreCus + fItem('OUTVAL').AsFloat,
                                                             0,
                                                             fItem('MARBR' + IntToStr(intCont)).AsFloat,
                                                             fItem('ICMSAIDA').AsFloat,
                                                             fItem('IMPFED').AsFloat,
                                                             fItem('DESOPE').AsFloat,
                                                             recPrecos[intCont].fltComiss)
        Else
          recPrecos[intCont].fltPreVen :=
            objFatPre.fCalculaPrecoVendaFator(recPrecos[1].fltPreVen, intCont);

       If ((Not blnFatPre) Or (blnFatPre And (Not objFatPre.fTabelaAtiva(IntCont)))) Or (IntCont = 1) Then
          recPrecos[intCont].fltMarBru := fCalculaPrecoVenda(2,
                                                             fltPreCus + fItem('OUTVAL').AsFloat,
                                                             recPrecos[intCont].fltPreVen * fltEmbala,
                                                             0,
                                                             fItem('ICMSAIDA').AsFloat,
                                                             fItem('IMPFED').AsFloat,
                                                             fItem('DESOPE').AsFloat,
                                                             recPrecos[intCont].fltComiss)
        Else
          recPrecos[intCont].fltMarBru := fCalculaPrecoVenda(2,
                                                             fltPreCus + fItem('OUTVAL').AsFloat,
                                                             recPrecos[intCont].fltPreVen,
                                                             0,
                                                             fItem('ICMSAIDA').AsFloat,
                                                             fItem('IMPFED').AsFloat,
                                                             fItem('DESOPE').AsFloat,
                                                             recPrecos[intCont].fltComiss);
      End;

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not SameText(strAutVen,'') Then
        ParamByName('AUTVEN').AsString := strAutVen;
      If Not SameText(strTabVen,'') Then
        ParamByName('TABVEN').AsString := strTabVen;


      ParamByName('IVA_ST').AsFloat :=  fltValIVA;
      ParamByName('ALQSTI').AsFloat := fltAliSte;
      ParamByName('N_ITEM').AsInteger:= intnItem;
      ParamByName('N_ITEM_TELA').AsInteger:= intnItem;
      ParamByName('NUMPED').AsString := strNumPed;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODFOR').AsString := strCodFor;
      ParamByName('DIFICM').AsString := qryConCit.FieldByName('ITE_DIFICM').AsString;
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODGRU').AsString := strCodGru;
      ParamByName('DESITE').AsString := strDesIte;
      ParamByName('REFERE').AsString := strRefere;
      ParamByName('CODUNI').AsString := strUnidade;
      ParamByName('CODABF').AsString := strCodAbf;
      ParamByName('DESABF').AsString := strDesAbf;
      ParamByName('QTDITE').AsFloat  := fltQtdIte;
      ParamByName('UNITAR').AsFloat  := fltUnitar;
      ParamByName('PERIPI').AsFloat  := fltAlqIpi;
      ParamByName('TOTITE').AsFloat  := fltTotIte;

      If (fCfgSis('ATPRAU', varBoolean)) And ((Pos(edtCodFor.Text, fRetForFilialTodos) = 0) Or (fCfgSis('ATPREN', varBoolean))) Then
        ParamByName('PRECOM').AsFloat  := fltPreCom
      Else
        ParamByName('PRECOM').AsFloat  := fItem('PRECOM').AsFloat;

      ParamByName('DESF01').AsFloat  := fItem('DESF01').AsFloat;
      ParamByName('DESF02').AsFloat  := fItem('DESF02').AsFloat;
      ParamByName('DESF03').AsFloat  := fItem('DESF03').AsFloat;
      ParamByName('DESF04').AsFloat  := fItem('DESF04').AsFloat;
      ParamByName('DESF05').AsFloat  := fItem('DESF05').AsFloat;
      ParamByName('DESF06').AsFloat  := fItem('DESF06').AsFloat;

      ParamByName('SUBFED').AsFloat  := fItem('SUBFED').AsFloat;
      ParamByName('FREENT').AsFloat  := fItem('FREENT').AsFloat;
      ParamByName('FREITE').AsFloat  := fItem('VALFRE').AsFloat;
      ParamByName('ACRFIN').AsFloat  := fItem('ACRFIN').AsFloat;

      ParamByName('SUBSTI').AsFloat  := fItem('SUBSTI').AsFloat;
      ParamByName('ICMENT').AsFloat  := fItem('ICMENT').AsFloat;

      If blnAtuIpi Then
        ParamByName('IPIENT').AsFloat  := fltAlqIpi
      Else
        ParamByName('IPIENT').AsFloat  := fItem('IPIENT').AsFloat;

      If blnUsaLotePrecos Then
      Begin

        If blnAtuSub Then
        Begin
          If fltTotIte <= 0 Then
            ParamByName('SUBSTI').AsFloat  := 0

          Else if strFrmCus = '1' Then
            ParamByName('SUBSTI').AsFloat  := fFormataFloat(((fltValRet + fltValAnt)/ (fltTotIte + fltValIpi) * 100), 2)

          Else
            ParamByName('SUBSTI').AsFloat  := fFormataFloat(((fltValRet + fltValAnt)/ fltTotIte * 100), 2);
        End;

        If blnAtuIcm Then
          ParamByName('ICMENT').AsFloat  := fltAlqIcm;
      End;

      ParamByName('DESADB').AsFloat  := fItem('DESADB').AsFloat;
      ParamByName('OUTVAL').AsFloat  := fItem('OUTVAL').AsFloat;
      ParamByName('IMPFED').AsFloat  := fItem('IMPFED').AsFloat;
      ParamByName('DESOPE').AsFloat  := fItem('DESOPE').AsFloat;
      ParamByName('TCIFCU').AsFloat  := fItem('TCIFCU').AsFloat;
      ParamByName('TSCUST').AsFloat  := fItem('TSCUST').AsFloat;
      ParamByName('DEPICO').AsFloat  := fItem('DEPICO').AsFloat;
      ParamByName('DEICMS').AsFloat  := fItem('DEICMS').AsFloat;
      ParamByName('FATREG').AsFloat  := fItem('FATREG').AsFloat;
      ParamByName('CODFAB').AsString := strCodFab;
      ParamByName('RPRENT').AsString := strRprEnt;

      ParamByName('QTDMXD').AsFloat  := fltQtdIte;

      ParamByName('EMP_PD').AsString := strEmp_Pd;

      If (fCfgSis('ATPRAU', varBoolean)) And ((Pos(edtCodFor.Text, fRetForFilialTodos) = 0) Or (fCfgSis('ATPREN', varBoolean))) Then
        ParamByName('PRECUS').AsFloat  := fltPreCus
      Else
        ParamByName('PRECUS').AsFloat  := fItem('PRECUS').AsFloat;

      ParamByName('ICMSAI').AsFloat  := fItem('ICMSAIDA').AsFloat;
      ParamByName('DESMAX').AsFloat  := fItem('DESMAX').AsFloat;
      ParamByName('DESMGE').AsFloat  := fItem('DESMGE').AsFloat;
      ParamByName('DESMSU').AsFloat  := fItem('DESMSU').AsFloat;
      ParamByName('MARMIN').AsFloat  := fItem('MARMIN').AsFloat;
      ParamByName('MARMSG').AsFloat  := fItem('MARMSG').AsFloat;
      ParamByName('MARMGE').AsFloat  := fItem('MARMGE').AsFloat;
      ParamByName('CLAIPI').AsString := strClaIpi; //qryConCit.FieldByName('ITE_CLAIPI').AsString;
      ParamByName('CDCEST').AsString := strCDCEST; //CDCEST do produto
      ParamByName('DESMAR').AsString := strDESMAR; // Descricao da Marca do Produto


      For intCont := 1 To Length(recPrecos) Do
      Begin
        ParamByName('COMTB' + IntToStr(intCont)).AsFloat := fItem('COMTB' + IntToStr(intCont)).AsFloat;
        ParamByName('MARBR' + IntToStr(intCont)).AsFloat := fItem('MARBR' + IntToStr(intCont)).AsFloat;
        ParamByName('PREVE' + IntToStr(intCont)).AsFloat := fItem('PREVE' + IntToStr(intCont)).AsFloat;
      End;

      If (fCfgSis('ATPRAU', varBoolean)) And ((Pos(edtCodFor.Text, fRetForFilialTodos) = 0) Or (fCfgSis('ATPREN', varBoolean))) Then
      Begin
        For intCont := 1 To Length(recPrecos) Do
        Begin
          ParamByName('COMTB' + IntToStr(intCont)).AsFloat := recPrecos[intCont].fltComiss;

          If (Not blnFatPre) Or (intCont = 1) Then
          Begin
            If blnAtpVmb[intCont] Then
              ParamByName('PREVE' + IntToStr(intCont)).AsFloat := recPrecos[intCont].fltPreVen
            Else
              ParamByName('MARBR' + IntToStr(intCont)).AsFloat := recPrecos[intCont].fltMarBru;
          End Else
          Begin
            ParamByName('PREVE' + IntToStr(intCont)).AsFloat := recPrecos[intCont].fltPreVen;
            ParamByName('MARBR' + IntToStr(intCont)).AsFloat := recPrecos[intCont].fltMarBru;
          End;

        End;
      End;

      ParamByName('CLAFIS').AsString := strClaFis;
      ParamByName('CODFIS').AsString := strCodFis;
      ParamByName('VLRCON').AsFloat  := fltTotIte;
      ParamByName('PERBAS').AsFloat  := fltPerBas;
      ParamByName('BASICM').AsFloat  := fltBasIcm;
      ParamByName('ALQICM').AsFloat  := fltAlqIcm;
      ParamByName('VALICM').AsFloat  := fltValIcm;
      ParamByName('BASIPI').AsFloat  := fltBasIPI;
      ParamByName('ALQIPI').AsFloat  := fltAlqIPI;
      ParamByName('VALIPI').AsFloat  := fltValIpi;

      ParamByName('BFCPST').AsFloat  := fltBFCPST;
      ParamByName('PFCPST').AsFloat  := fltPFCPST;
      ParamByName('VFCPST').AsFloat  := fltVFCPST;


      If (strClaSub  <> '1') Then
      Begin
        ParamByName('PEBAST').AsFloat  := fltPeBaST;
        ParamByName('BASRET').AsFloat  := fltBasRet;
        ParamByName('VALRET').AsFloat  := fltValRet;
        ParamByName('BAERET').AsFloat  := 0;
        ParamByName('VAERET').AsFloat  := 0;
      End
      Else
      Begin
        ParamByName('PEBAST').AsFloat  := fltPeBaST;
        ParamByName('BAERET').AsFloat  := fltBasRet;
        ParamByName('VAERET').AsFloat  := fltValRet;
        ParamByName('BASRET').AsFloat  := 0;
        ParamByName('VALRET').AsFloat  := 0;
      End;

      ParamByName('BASANT').AsFloat  := fltBasAnt;
      ParamByName('VALANT').AsFloat  := fltValAnt;

      fltClcAux := fRetornaValorOutras(fltTotIte, fltBasIcm, fltValIpi, 0.0, 0, 0, 0);

      If objExcecaoCfopCst.fExcecaoDefinida(strClaFis, strCodFis) Then
        blnIsentas := objExcecaoCfopCst.blnIsentas
      Else
        blnIsentas := fCodFisGravaIsentoDocEnt(strClaFis, strCodFis);

      If blnIsentas Then
      Begin
        ParamByName('ISENTO').AsFloat  := fltClcAux;
        ParamByName('OUTRAS').AsFloat  := 0;
      End Else
      Begin
        ParamByName('ISENTO').AsFloat  := 0;
        ParamByName('OUTRAS').AsFloat  := fltClcAux;
      End;

      ParamByName('DTABAL').AsDateTime := fItem('DTABAL').AsDateTime;

      If fEmptyStr(strNumLot) Then
        ParamByName('LOCFIS').AsString   := fItem('LOCFIS').AsString
      Else
        ParamByName('LOCFIS').AsString   := fCampoTabela( 'LOT_LOCFIS', 'CADLOT',
                    ['LOT_CODITE', 'LOT_CODEMP'],  [strCodIte, VS_strCodEmp]);




      ParamByName('NUMSEL').AsInteger  := fGetProxNumSelEntradaMerc;

      If fCfgSis('ENTPIS', varBoolean) Then
        ParamByName('INCPIS').AsString   := qryConCit.FieldByName('ITE_INCPIS').AsString
      Else
        ParamByName('INCPIS').AsString   := 'N';

      ParamByName('CODACA').AsString := strCodAca;
      ParamByName('EMPACA').AsString := strEmpAca;
      ParamByName('PROACA').AsString := strProAca;
      ParamByName('DESACA').AsString := strDesAca;
      ParamByName('PREACA').AsFloat  := fltPreAca;
      ParamByName('SALACA').AsFloat  := fltSalAca;
      ParamByName('GRAMAR').AsString := 'N';
      If fItemMarmore(strCodIte) Then
      Begin
        ParamByName('NUMLOT').AsString := 'A DEFINIR';
        ParamByName('GRAMAR').AsString := 'S';
      End
      Else
        ParamByName('NUMLOT').AsString := strNumLot;
      ParamByName('NUMLOT').AsString := strNumLot;
      ParamByName('IDEPRO').AsString := strIdePro;
      ParamByName('ITETIN').AsString := strIteTin;
      ParamByName('EMBALA').AsFloat  := fltEmbala;
      ParamByName('CODDIV').AsString := strCodDiv;
      ParamByName('UNIEMB').AsString := strUniEmb;
      ParamByName('IMPDIR').AsString := strImpDir;
      ParamByName('CODMOT').AsString := strCodMot;
      ParamByName('DESUNI').AsFloat  := fltDEsUni;

      If blnPrecoPraticado Then
      Begin
        ParamByName('TOTITE').AsFloat  := fltTotIte;
        ParamByName('VALRET').AsFloat  := fltValRet;
        ParamByName('BASRET').AsFloat  := fltBasRet;
        ParamByName('VAL_RT').AsFloat  := fltVal_RtDev;
        ParamByName('PERBAS').AsFloat  := fltPerBas;
        ParamByName('PEBAST').AsFloat  := fltPeBaST;
        ParamByName('PERRED').AsFloat  := fltPerRedDev;
        ParamByName('ALQRET').AsFloat  := fltAlqRetDev;

        ParamByName('VALCOF').AsFloat  := fltValCofDev;
        ParamByName('BASPIS').AsFloat  := fltBasPisDev;
        ParamByName('VALPIS').AsFloat  := fltValPisDev;
        ParamByName('BASCOF').AsFloat  := fltBasCofDev;
        ParamByName('DESACE').AsFloat  := fltDesAce;
        ParamByName('ALQCOF').AsFloat  := fltAlqCofDev;
        ParamByName('ALQPIS').AsFloat  := fltAlqPisDev;

        ParamByName('CODFIS').AsString := strCodFis;
        ParamByName('INCPIS').AsString := strIncPis;
        ParamByName('CSTCOF').AsString := strCstCofDev;
        ParamByName('CSTPIS').AsString := strCstPisDev;
        ParamByName('NR_PIS').AsString := strNR_PisDev;
        ParamByName('NR_COF').AsString := strNR_CofDev;
      End;

      If fltDesEsp >= 0 Then
        ParamByName('DESESP').AsFloat  := fltDesEsp;

      If fltValFre >= 0 Then
        ParamByName('VALFRE').AsFloat  := fltValFre;

      If fltQtdOri >= 0 Then
        ParamByName('QTDORI').AsFloat  := fltQtdOri;

      inc(intAUTOINCREMENTO_GRAVACAO);
      ParamByName('AUTOINCREMENTO_GRAVACAO').AsInteger := intAUTOINCREMENTO_GRAVACAO;

      ParamByName('EXISTELOTE').AsString :=  IIf(objCadLot.fExisteLote(ParamByName('CODITE').AsString, VS_strCodEmp, '', False), 'S', 'N');
      ParamByName('SIGUNI').AsString  := edtSigla.Text;
      ParamByName('SALDOS').AsFloat := fStrToFloat(edtSaldo.Text);
      ParamByName('PROEMB').AsString := strProEmb;
      ParamByName('RICMPR').AsString :=  IIf(blnRedIcmsParana, 'S', 'N');
      ParamByName('TIPPRO').AsString :=  fItem('TIPPRO').AsString;

      ParamByName('VBCFCP').AsFloat  := fltVBCFCP;
      ParamByName('PERFCP').AsFloat  := fltPERFCP;
      ParamByName('VALFCP').AsFloat  := fltVALFCP;
      ParamByName('DESMAR').AsString := strDESMAR;
      ParamByName('MATREV').AsString := strMatRev;
      ParamByName('INCFUT').AsString := strIncFut;


      ExecSQL;
      Close;

    End;

  Finally
    FreeAndNil(cpcParams);
    FreeAndNil(qryGenMer);
  End;
end;

procedure TfrmEntMercadorias.pLimpaDadosItem;
  Var
    intContador: Integer;
    edtTemp: TEdit;
    lblTemp: TLabel;
begin
  For intContador := 0 To pnlItem.ControlCount -1 Do
  Begin

    If (pnlItem.Controls[intContador] Is TEdit) Then
    Begin
      edtTemp := (pnlItem.Controls[intContador] As TEdit);
      edtTemp.Clear;
    End
    Else If (pnlItem.Controls[intContador] Is TLabel) Then
    Begin
      lblTemp := (pnlItem.Controls[intContador] As TLabel);

      If lblTemp.Tag = 99 Then
        lblTemp.Caption := '';
        
    End;

  End;

  If Not blnSemInc Then
    edtCodIte.Enabled := True;

  If blnDevolu Then
    fltMaxDev := 0;

  pMostraLote(False, '');
end;

procedure TfrmEntMercadorias.pAtualizaTabela;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TMP_ENTMER ';

  if Not fEmptyStr(strOrdIte) Then
    strSQL := strSQL + 'ORDER BY ' + strOrdIte;

  With qryEntMer Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
    (FieldByName('ENT_QTDITE') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DEQTEM', varInteger));
    (FieldByName('ENT_EMBALA') As TFloatField).DisplayFormat := fMskDigitos(DEC_EMBALAGEM);
    (FieldByName('ENT_UNITAR') As TFloatField).DisplayFormat := '#,####0.0000';
    (FieldByName('ENT_TOTITE') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ENT_VALIPI') As TFloatField).DisplayFormat := '#,##0.00';
  End;
end;

function TfrmEntMercadorias.fVerifExisteItem: Boolean;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;
begin
  If fEmptyStr(edtCodIte.Text) Then
  Begin
    Result := False;
    Exit;
  End;

  If not fTabelaExiste('TMP_ENTMER') then
  Begin
    Result := False;
    Exit;
  End;

  qryGenTmp := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TMP_ENTMER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ENT_CODITE = :CODITE';

  With qryGenTmp Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := edtCodIte.Text;
    Open;

    If IsEmpty Then
      Result := False
    Else
      Result := True;

  End;

  FreeAndNil(qryGenTmp);
end;

procedure TfrmEntMercadorias.pCarregaItensVis;
begin
  If (Not blnAdicionando) And (qryEntMer.RecordCount > 0) And
     (Not (SameText(qryEntMer.FieldByName('ENT_CODITE').AsString, edtCodIte.Text))) Then
  Begin
    pCarregaItensAlteracao(True);
  End;
end;

procedure TfrmEntMercadorias.pCarregaItensAlteracao(blnVisualizacaoPainel: Boolean = False);
Var
  strSQL : String;
  qryGen : TUniQuery;
  blnPodeAterarItemDaNota: Boolean;
begin
   blnCarregadoParaVisualizacao := blnVisualizacaoPainel;

  // ANTES DE QUALQUER ALTERAÇÃO DEVE ATUALIZAR A QUERY DO ITEM
  If (Not  blnVisualizacaoPainel) Then
    If (qryEntMer.Active And (Not qryEntMer.IsEmpty) And
       (qryConCit.IsEmpty Or (qryConCit.FieldByName('ITE_CODITE').AsString <> qryEntMer.FieldByName('ENT_CODITE').AsString))) Then
      pCarregaItem(qryEntMer.FieldByName('ENT_CODITE').AsString, False, False, True);

  With qryEntMer Do
  Begin

    If Not Active Then
    Begin
      pSetFocus(edtCodIte);

      Exit;
    End;

    If RecordCount <= 0 Then
    Begin
      pSetFocus(edtCodIte);

      Exit;
    End;

    If blnDocOri And (fCfgSis('USACON', varBoolean)) Then
    Begin
      pHabilitaCampos(pnlItem, (Not blnConEqu));
      dbgItensGrid.Enabled := True;
      (***************************************************************)
      (* É POSSÍVEL ENTRAR COM UMA QUANTIDADE MENOR QUE A CONFERIDA  *)
      (* E FAZER A ENTRADA EM MAIS DE UMA NOTA                       *)
      (************************************************************LA*)
      edtQtdIte.Enabled := True;
      edtEmbala.Enabled := False;
    End Else
    Begin
      edtQtdIte.Enabled := True;
    End;

    edtCodIte.Text  := FieldByName('ENT_CODITE').AsString;
    edtDesIte.Text  := FieldByName('ENT_DESITE').AsString;
    edtRefere.Text  := FieldByName('ENT_REFERE').AsString;

    edtQtdIte.Text  := FloatToStrF(FieldByName('ENT_QTDITE').AsFloat, ffFixed, 12, fCfgSis('DEQTEM', varInteger));
    edtEmbala.Text  := FloatToStrF(FieldByName('ENT_EMBALA').AsFloat, ffFixed, 20, DEC_EMBALAGEM);
    fltQtdAnt       := fStrToFloat(edtQtdIte.Text) * IIF(fStrToFloat(edtEmbala.Text) <> 0, fStrToFloat(edtEmbala.Text), 1);

    edtUnitar.Text  := FloatToStrF(FieldByName('ENT_UNITAR').AsFloat, ffFixed, 12, 4);
    edtTotIte.Text  := FloatToStrF(FieldByName('ENT_TOTITE').AsFloat, ffFixed, 12, 2);
    fltValTot       := FieldByName('ENT_TOTITE').AsFloat;
    edtCodAbf.Text  := FieldByName('ENT_CODABF').AsString;
    edtClaIpi.Text  := FieldByName('ENT_CLAIPI').AsString;
    edtCodCest.Text := FieldByName('ENT_CDCEST').AsString;
    edtDesAbf.Text  := FieldByName('ENT_DESABF').AsString;
    edtBasIcm.Text  := FloatToStrF(FieldByName('ENT_BASICM').AsFloat, ffFixed, 12, 2);
    edtAlqIcm.Text  := FloatToStrF(FieldByName('ENT_ALQICM').AsFloat, ffFixed, 12, 2);
    edtValIcm.Text  := FloatToStrF(FieldByName('ENT_VALICM').AsFloat, ffFixed, 12, 2);
    edtBasIPI.Text  := FloatToStrF(FieldByName('ENT_BASIPI').AsFloat, ffFixed, 12, 2);
    edtAlqIPI.Text  := FloatToStrF(FieldByName('ENT_ALQIPI').AsFloat, ffFixed, 12, 2);
    edtValIpi.Text  := FloatToStrF(FieldByName('ENT_VALIPI').AsFloat, ffFixed, 12, 2);
    edtNumLot.Text  := FieldByName('ENT_NUMLOT').AsString;
    objCadLot.strLotAnt := FieldByName('ENT_NUMLOT').AsString;

    strCodAca       := FieldByName('ENT_CODACA').AsString;
    strEmpAca       := FieldByName('ENT_EMPACA').AsString;
    strProAca       := FieldByName('ENT_PROACA').AsString;
    strDesAca       := FieldByName('ENT_DESACA').AsString;

    If (strProAca = 'S') Then
      edtDesIte.Text := strDesAca;

    fltPreAca       := FieldByName('ENT_PREACA').AsFloat;
    fltSalAca       := FieldByName('ENT_SALACA').AsFloat;

    strClaFis       := FieldByName('ENT_CLAFIS').AsString;
    strCodFis       := FieldByName('ENT_CODFIS').AsString;
    fltPerBas       := FieldByName('ENT_PERBAS').AsFloat;
    fltPeBaST       := FieldByName('ENT_PEBAST').AsFloat;

    fltMaxDev       := FieldByName('ENT_QTDMXD').AsFloat;
    fltQtdXml       := FieldByName('ENT_QTDITE').AsFloat * FieldByName('ENT_EMBALA').AsFloat;
    If blnVisualizacaoPainel then
    Begin
      edtUnidad.Text := FieldByName('ENT_CODUNI').AsString;
      edtSigla.Text  := FieldByName('ENT_SIGUNI').AsString;
      edtSaldo.Text  := FormatFloat('#,##0.000', FieldByName('ENT_SALDOS').AsFloat);
    End;

    If Not blnVisualizacaoPainel then
    Begin
      pCarregaAbrevFiscalIcms(True, False);

      qryGen := fCriaQuery(Self);

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  C.ITE_CODUNI, ';
      strSQL := strSQL + '  I.ITE_SALDOS, ';
      strSQL := strSQL + '  C.ITE_CNV_ML  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADITE C, ';
      strSQL := strSQL + '  ITEGER I ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  C.ITE_CODITE = I.ITE_CODITE AND ';
      strSQL := strSQL + '  C.ITE_CODITE = :CODITE AND ';
      strSQL := strSQL + '  I.ITE_CODEMP = :CODEMP ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODITE').AsString := edtCodIte.Text;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        Open;

        edtSaldo.Text  := FormatFloat('#,##0.000', FieldByName('ITE_SALDOS').AsFloat);

        If Not fEmptyStr(strCodAca) Then
          edtSaldo.Text   := FormatFloat('#,##0.000', fltSalAca);

      End;

      FreeAndNil(qryGen);

      {*****************************************}
      {* ATRIBUI O AUTO INCREMENTO DO REGISTRO *}
      {* QUE SERÁ USADO COMO CHAVE PARA A ALTE-*}
      {* RAÇÃO                                 *}
      {**************************************MV*}
      btnAdicionar.Tag   := FieldByName('AUTOINCREM').AsInteger;

      edtUnidad.Text := FieldByName('ENT_CODUNI').AsString;
      strCodUni      := FieldByName('ENT_CODUNI').AsString;
      edtSigla.Text  := fRetSiglaUnidade(FieldByName('ENT_CODUNI').AsString);

      If blnPrecoPraticado Then
        pMostraLote(objCadLot.fExisteLote(edtCodIte.Text, VS_strCodEmp, '', False), fRetReaEnd(edtCodIte.Text));

      If ((not blnRecCliGarantia) And blnPrecoPraticado And ((Not edtNumLot.Visible) Or edtNumLot.ReadOnly)) Then
      Begin
        pnlItem.Enabled := False;
        pSetFocus(dbgItensGrid);
      End
      Else
      Begin

        If blnRecCliGarantia Or blnGarantia or FblnAcessadoViaRetornoConsignacao Then
        Begin
          If blnRecCliGarantia or FblnAcessadoViaRetornoConsignacao Then
          Begin
            edtBasIPI.Enabled := False;
            edtAlqIPI.Enabled := False;
            edtvalIpi.Enabled := False;

            pHabilitaCampos(pnlItem, False);
            pnlItem.Enabled    := (Not fDesabilitaItensConEquXML());

            edtUnidad.Enabled  := False;
            edtUnidad.ReadOnly := True;
            edtUnidad.TabStop  := False;

            edtEmbala.Enabled  := False;
            edtEmbala.ReadOnly := True;
            edtEmbala.TabStop  := False;

            edtCodAbf.Enabled  := True;
            edtCodAbf.ReadOnly := False;
            edtCodAbf.TabStop  := True;

            If fVerificaAcessoSistema('GEMTVU') Then
            Begin
              edtUnitar.Enabled  := True;
              edtUnitar.ReadOnly := False;
              edtUnitar.TabStop  := True;
            End
            Else
            Begin
              edtUnitar.Enabled  := False;
              edtUnitar.ReadOnly := True;
              edtUnitar.TabStop  := False;
            End;

          End;

          edtQtdIte.Enabled  := False;
          edtQtdIte.ReadOnly := True;
          edtQtdIte.TabStop  := False;

          btnAdicionar.Enabled   := True;
          btnAdicionar.TabStop   := True;
          btnCancelaItem.Enabled := True;
          btnCancelaItem.TabStop := True;

          pSetFocus(edtUnitar);
        End
        Else

        If blnPrecoPraticado Then
        Begin
          pHabilitaCampos(pnlItem, False);
          pnlItem.Enabled        := (Not fDesabilitaItensConEquXML());

          edtNumLot.Enabled      := True;
          btnAdicionar.Enabled   := True;
          btnAdicionar.TabStop   := True;
          btnCancelaItem.Enabled := True;
          btnCancelaItem.TabStop := True;

          pSetFocus(edtNumLot);
        End

        Else If Not fEmptyStr(recNotEle.strAutInc) Then
        Begin
          edtBasIPI.Enabled := False;
          edtAlqIPI.Enabled := False;
          edtvalIpi.Enabled := False;

          pHabilitaCampos(pnlItem, False);
          pnlItem.Enabled    := (Not fDesabilitaItensConEquXML());

          edtDesIte.Enabled  := True;
          edtDesIte.ReadOnly := False;
          edtDesIte.TabStop  := True;

          edtUnidad.Enabled  := True;
          edtUnidad.ReadOnly := False;
          edtUnidad.TabStop  := True;


          If fCfgSis('ALTEMB', varBoolean) Then
          Begin
            edtEmbala.Enabled  := True;
            edtEmbala.ReadOnly := False;
            edtEmbala.TabStop  := True;
          End;

          blnPodeAterarItemDaNota := fCfgSis('ENFPQT', varBoolean); //Permite alterar a quantidade quando nota eletrônica

          edtQtdIte.ReadOnly := Not blnPodeAterarItemDaNota;
          edtQtdIte.Enabled  := blnPodeAterarItemDaNota;
          edtQtdIte.TabStop  := blnPodeAterarItemDaNota;


          edtUnitar.Enabled  := True;
          edtUnitar.ReadOnly := False;
          edtUnitar.TabStop  := True;

          btnAdicionar.Enabled   := True;
          btnAdicionar.TabStop   := True;
          btnCancelaItem.Enabled := True;
          btnCancelaItem.TabStop := True;

          pSetFocus(edtDesIte);
        End
        Else
        Begin
          edtCodIte.Enabled  := False;

          pSetFocus(edtQtdIte);
        End;
      End;
    End;
  End;

  If blnVisualizacaoPainel And ( Not fEmptyStr(qryEntMer.FieldByName('ENT_EXISTELOTE').AsString)) Then
    pMostraLote(qryEntMer.FieldByName('ENT_EXISTELOTE').AsString = 'S', fRetReaEnd(edtCodIte.Text))
  Else
    pMostraLote(objCadLot.fExisteLote(edtCodIte.Text, VS_strCodEmp, '', False), fRetReaEnd(edtCodIte.Text));

  If Not blnVisualizacaoPainel then
  Begin
    pHabilitaIcms((Pos(strCodFis, CST_SUBSTITUICAO) <= 0) And blnZonFra);
    If (Not edtCodIte.Focused) And edtNumLot.CanFocus And Not edtNumLot.ReadOnly Then
      pSetFocus(edtNumLot)
    Else If edtDesIte.CanFocus Then
        pSetFocus(edtDesIte)
    Else If edtUnidad.CanFocus Then
      pSetFocus(edtUnidad);
  End
end;

procedure TfrmEntMercadorias.pAlteraItem;
  Var
    strSQL: String;
    strTipAbf: String;
    fltBasRet: Double;
    fltBasAnt: Double;
    fltValIVA: Double;

    fltPreCom: Double;
    fltPreCus: Double;

    cpcParams: TParCalculaPrecoCusto;
    qryGenMer: TUniQuery;

    recPrecos: Array[1..7] Of TRecPrecos;
    intCont  : Integer;

    blnIsentas: Boolean;

    lRecFCP: TRecDadosFCP;
    blnAntecipado: Boolean;
    blnSubstituido: Boolean;
    strImpDir: String;

    function fItem(strCampo: String): TField;
    begin
      Result := qryConIte.FieldByName('ITE_' + strCampo);
    end;

    function fZeraICMSDevolucao: Boolean;
    Begin
      If strImpDir = '' Then
        strImpDir := 'N';
      Result := fCfgSis('IMPDIR') = 'N';
      If  fCfgSis('IMPDIR') = 'S'  Then
        Result := strImpDir = 'N';
    End;
begin
  qryGenMer := fCriaQuery(Self);
  cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  TMP_ENTMER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

    With qryGenMer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      qryGenMer.ParamByName('AUTINC').AsInteger := btnAdicionar.Tag;
      Open;
      strImpDir := qryGenMer.FieldByName('ENT_IMPDIR').AsString;
    End;

    If (blnDevolu) Or (blnConEqu) Or (blnLocEqu) or blnRecCliGarantia or (FblnAcessadoViaRetornoConsignacao) Then
      strTipAbf := fGetTipoAbfCliente(strCodFor)
    Else
      strTipAbf := fGetTipoAbfFornecedor(strCodFor);

    fltValIVA := fRetornaPercIVA(edtCodAbf.Text,strEstFor, strTipAbf);

    fltBasRet := 0.0;

    If blnPrecoPraticado Then
    With qryGenMer Do
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT * FROM ';
      strSQL := strSQL + '  TMP_ENTMER ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTINC').AsInteger := btnAdicionar.Tag;
      Open;

      fltBasRet := FieldByName('ENT_BASRET').AsFloat;
      fltvalRet := FieldByName('ENT_VALRET').AsFloat;
      fltPerBas := FieldByName('ENT_PERBAS').AsFloat;
      fltPeBaST := FieldByName('ENT_PEBAST').AsFloat;
      strCodFis := FieldByName('ENT_CODFIS').AsString;
    End Else
    Begin
      If Pos(strCodFis, CST_SUBSTITUICAO) > 0 Then
        fltBasRet := fFormataFloat((((fStrToFloat(edtTotIte.Text) + fStrToFloat(edtvalIpi.Text)) * fltPeBaST) / 100) * fltValIVA, 2);

      fltValRet := fRetornaValRet(fCadEmp('ESTADO'), fltBasRet, fStrToFloat(edtValIcm.Text), fltAliSte);
    End;

    fltBasAnt := 0.0;
    fltValAnt := 0.0;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  TMP_ENTMER ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  ENT_N_ITEM = :N_ITEM, ';
    strSQL := strSQL + '  ENT_N_ITEM_TELA = :N_ITEM_TELA, ';
    strSQL := strSQL + '  ENT_DESITE = :DESITE, ';
    strSQL := strSQL + '  ENT_NUMLOT = :NUMLOT, ';
    strSQL := strSQL + '  ENT_CODABF = :CODABF, ';
    strSQL := strSQL + '  ENT_DESABF = :DESABF, ';
    strSQL := strSQL + '  ENT_QTDITE = :QTDITE, ';
    strSQL := strSQL + '  ENT_UNITAR = :UNITAR, ';
    strSQL := strSQL + '  ENT_TOTITE = :TOTITE, ';
    strSQL := strSQL + '  ENT_CLAFIS = :CLAFIS, ';
    strSQL := strSQL + '  ENT_CODFIS = :CODFIS, ';
    strSQL := strSQL + '  ENT_VLRCON = :VLRCON, ';
    strSQL := strSQL + '  ENT_PERBAS = :PERBAS, ';
    strSQL := strSQL + '  ENT_BASICM = :BASICM, ';
    strSQL := strSQL + '  ENT_ALQICM = :ALQICM, ';
    strSQL := strSQL + '  ENT_VALICM = :VALICM, ';

    strSQL := strSQL + '  ENT_BASIPI = :BASIPI, ';
    strSQL := strSQL + '  ENT_ALQIPI = :ALQIPI, ';
    strSQL := strSQL + '  ENT_PERIPI = :ALQIPI, ';
    strSQL := strSQL + '  ENT_VALIPI = :VALIPI, ';
    strSQL := strSQL + '  ENT_CLAIPI = :CLAIPI, ';

    strSQL := strSQL + '  ENT_BAEIPI = :BASIPI, ';
    strSQL := strSQL + '  ENT_ALEIPI = :ALQIPI, ';
    strSQL := strSQL + '  ENT_VAEIPI = :VALIPI, ';

    strSQL := strSQL + '  ENT_IPISUB = :VALIPI, ';
    strSQL := strSQL + '  ENT_ISENTO = :ISENTO, ';
    strSQL := strSQL + '  ENT_PEBAST = :PEBAST, ';
    strSQL := strSQL + '  ENT_BASRET = :BASRET, ';
    strSQL := strSQL + '  ENT_VALRET = :VALRET, ';
    strSQL := strSQL + '  ENT_RETORI = :VALRET, ';

    strSQL := strSQL + '  ENT_BAERET = :BAERET, ';
    strSQL := strSQL + '  ENT_VAERET = :VAERET, ';

    strSQL := strSQL + '  ENT_BASANT = :BASANT, ';
    strSQL := strSQL + '  ENT_VALANT = :VALANT, ';
    
    strSQL := strSQL + '  ENT_EMBALA = :EMBALA, ';
    strSQL := strSQL + '  ENT_OUTRAS = :OUTRAS,  ';

    strSQL := strSQL + '  ENT_BFCPST = :BFCPST, ';
    strSQL := strSQL + '  ENT_PFCPST = :PFCPST, ';
    strSQL := strSQL + '  ENT_VFCPST = :VFCPST, ';
    strSQL := strSQL + '  ENT_VBCFCP = :VBCFCP, ';
    strSQL := strSQL + '  ENT_PERFCP = :PERFCP, ';
    strSQL := strSQL + '  ENT_VALFCP = :VALFCP  ';

    If blnAtuIpi Then
      strSQL := strSQL + '  ,ENT_IPIENT = :IPIENT  ';

    If blnUsaLotePrecos Then
    Begin
      strSQL := strSQL + '  ,ENT_SUBSTI = :SUBSTI  ';
    End;

    If (fCfgSis('ATPRAU', varBoolean)) And ((Pos(edtCodFor.Text, fRetForFilialTodos) = 0) Or (fCfgSis('ATPREN', varBoolean))) Then
    Begin
      strSQL := strSQL + '  ,ENT_PRECOM = :PRECOM, ';
      strSQL := strSQL + '  ENT_PRECUS = :PRECUS, ';
      {*******************************************}
      {* VERIFICA SE ALTERA PREÇO DE VENDA OU    *}
      {* MARGEM BRUTA                            *}
      {****************************************MV*}
      For intCont := 1 To Length(recPrecos) Do
      Begin
        strSQL := strSQL + '  ENT_COMTB' + IntToStr(intCont) + ' = :COMTB' + IntToStr(intCont) + ', ';

        If (Not blnFatPre) Or (intCont = 1) Then
        Begin
          If blnAtpVmb[intCont] Then
            strSQL := strSQL + '  ENT_PREVE' + IntToStr(intCont) + ' = :PREVE' + IntToStr(intCont) + ', '
          Else
            strSQL := strSQL + '  ENT_MARBR' + IntToStr(intCont) + ' = :MARBR' + IntToStr(intCont) + ', ';
        End Else
        Begin
          strSQL := strSQL + '  ENT_PREVE' + IntToStr(intCont) + ' = :PREVE' + IntToStr(intCont) + ', ';
          strSQL := strSQL + '  ENT_MARBR' + IntToStr(intCont) + ' = :MARBR' + IntToStr(intCont) + ', ';
        End;

        If IntCont = Length(recPrecos) Then
          strSQL := Copy(strSQL, 1, Length(strSQL) - 2);
      End;
    End;

    strSQL := strSQL + ' ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

    With qryGenMer Do
    Begin

      {**********************************}
      {* CALCULA PREÇOS DE CUSTO        *}
      {*******************************JB*}
      fltPreCom := fStrToFloat(edtUnitar.Text);
      With cpcParams Do
      Begin
        curPreCom := fltPreCom;

        curDesF01 := fItem('DESF01').AsFloat;
        curDesF02 := fItem('DESF02').AsFloat;
        curDesF03 := fItem('DESF03').AsFloat;
        curDesF04 := fItem('DESF04').AsFloat;
        curDesF05 := fItem('DESF05').AsFloat;
        curDesF06 := fItem('DESF06').AsFloat;

        curSubsti := fItem('SUBSTI').AsFloat;
        curICMSEnt:= fItem('ICMENT').AsFloat;

        If blnAtuIpi Then
          curIPIEnt := fStrToFloat(edtAlqIpi.Text)
        Else
          curIPIEnt := fItem('IPIENT').AsFloat;

        If blnUsaLotePrecos Then
        Begin

          If blnAtuSub Then
          Begin
            If fStrToFloat(edtTotIte.Text) <= 0 Then
              curSubsti := 0

            Else if strFrmCus = '1' Then
              curSubsti := fFormataFloat(((fltValRet + fltValAnt)/ (fStrToFloat(edtTotIte.Text) + fStrToFloat(edtValIpi.Text))) * 100, 2)

            Else
              curSubsti := fFormataFloat(((fltValRet + fltValAnt)/ fStrToFloat(edtTotIte.Text) * 100), 2);
          End;

          If blnAtuIcm Then
            curICMSEnt := fStrToFloat(edtAlqIcm.Text);
        End;

        curFrete  := fItem('FREENT').AsFloat;
        curValFre := fItem('VALFRE').AsFloat;
        curAcrFin := fItem('ACRFIN').AsFloat;
        curDesAdb := fItem('DESADB').AsFloat;
        curSubFed := fItem('SUBFED').AsFloat;

        if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
        begin
          curTCIFCu := fItem('TCIFCU').AsFloat;
          curTSCust := fItem('TSCUST').AsFloat;
          curDePiCo := fItem('DEPICO').AsFloat;
          curDeICMS := fItem('DEICMS').AsFloat;
          curFatReg := fItem('FATREG').AsFloat;
        end
        else
        begin
          curTCIFCu := 0;
          curTSCust := 0;
          curDePiCo := 0;
          curDeICMS := 0;
          curFatReg := 0;
        end;
      End;

      fltPreCus := cpcParams.fCalculaPrecoCusto();

      For intCont := 1 To length(recPrecos) Do
      Begin
        recPrecos[intCont].fltComiss := fItem('COMTB' + IntToStr(intCont)).AsFloat;

        {*******************************************}
        {* CALCULA OS NOVOS PREÇOS DE VENDA        *}
        {****************************************MV*}
        If ((Not blnFatPre) Or (blnFatPre And (Not objFatPre.fTabelaAtiva(IntCont)))) Or (IntCont = 1) Then
          recPrecos[intCont].fltPreVen := fCalculaPrecoVenda(1,
                                                             fltPreCus + fItem('OUTVAL').AsFloat,
                                                             0,
                                                             fItem('MARBR' + IntToStr(intCont)).AsFloat,
                                                             fItem('ICMSAIDA').AsFloat,
                                                             fItem('IMPFED').AsFloat,
                                                             fItem('DESOPE').AsFloat,
                                                             recPrecos[intCont].fltComiss)
        Else
            recPrecos[intCont].fltPreVen :=
              objFatPre.fCalculaPrecoVendaFator(recPrecos[1].fltPreVen, intCont);

        {*******************************************}
        {* CALCULA AS NOVAS MARGENS BRUTAS         *}
        {****************************************MV*}
        If ((Not blnFatPre) Or (blnFatPre And (Not objFatPre.fTabelaAtiva(IntCont)))) Or (IntCont = 1) Then
          recPrecos[intCont].fltMarBru := fCalculaPrecoVenda(2,
                                                             fltPreCus + fItem('OUTVAL').AsFloat,
                                                             recPrecos[intCont].fltPreVen *
                                                               qryEntMer.FieldByName('ENT_EMBALA').AsFloat,
                                                             0,
                                                             qryEntMer.FieldByName('ENT_ICMSAI').AsFloat,
                                                             fItem('IMPFED').AsFloat,
                                                             fItem('DESOPE').AsFloat,
                                                             recPrecos[intCont].fltComiss)
        Else
          recPrecos[intCont].fltMarBru := fCalculaPrecoVenda(2,
                                                             fltPreCus + fItem('OUTVAL').AsFloat,
                                                             recPrecos[intCont].fltPreVen,
                                                             0,
                                                             qryEntMer.FieldByName('ENT_ICMSAI').AsFloat,
                                                             fItem('IMPFED').AsFloat,
                                                             fItem('DESOPE').AsFloat,
                                                             recPrecos[intCont].fltComiss)

      End;

      If fCalcularFcpDevolucao Then
      begin
        lRecFCP.Create(fltAliFCP);
        lRecFCP.blnTemST := (Pos(strCodFis, CST_SUBSTITUICAO) > 0);
        lRecFCP.fltValIVA := fltValIVA;
        lRecFCP.fltBCFCP := fStrToFloat(edtBasIcm.Text);
        lRecFCP.pCalcular;
      end
      else
      begin
        lRecFCP := fObterFcpItem;
      end;

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      {*****************************************}
      {* DADOS QUE SERÃO ALTERADOS             *}
      {**************************************MV*}
      ParamByName('DESITE').AsString  := edtDesIte.Text;
      ParamByName('NUMLOT').AsString  := edtNumLot.Text;
      objCadLot.strLotAnt := edtNumLot.Text;

      ParamByName('EMBALA').AsFloat   := fStrToFloat(edtEmbala.Text);
      ParamByName('CODABF').AsString  := edtCodAbf.Text;
      ParamByName('DESABF').AsString  := edtDesAbf.Text;
      ParamByName('QTDITE').AsFloat   := fStrToFloat(edtQtdIte.Text);
      ParamByName('UNITAR').AsFloat   := fStrToFloat(edtUnitar.Text);
      ParamByName('TOTITE').AsFloat   := fStrToFloat(edtTotIte.Text);
      ParamByName('CLAFIS').AsString  := strClaFis;
      ParamByName('CODFIS').AsString  := strCodFis;
      ParamByName('VLRCON').AsFloat   := fStrToFloat(edtTotIte.Text);
      ParamByName('PERBAS').AsFloat   := fltPerBas;
      ParamByName('N_ITEM').AsInteger := qryEntMer.FieldByName('ENT_N_ITEM').AsInteger;
      ParamByName('N_ITEM_TELA').AsInteger := qryEntMer.FieldByName('ENT_N_ITEM_TELA').AsInteger;

      blnAntecipado:= False;
      blnSubstituido := (Pos(strCodFis, CST_SUBSTITUICAO) > 0);
      If blnDevolu Then
      Begin
        If blnSubstituido And fZeraICMSDevolucao And (fEmptyStr(strDocSel))Then
        Begin
          ParamByName('BASICM').AsFloat := 0.0;
          ParamByName('ALQICM').AsFloat := 0.0;
          ParamByName('VALICM').AsFloat := 0.0;
        End
        Else
        Begin
          ParamByName('BASICM').AsFloat := fStrToFloat(edtBasIcm.Text);
          ParamByName('ALQICM').AsFloat := fStrToFloat(edtAlqIcm.Text);
          ParamByName('VALICM').AsFloat := fStrToFloat(edtValIcm.Text);
        End;
      End
      Else
      If (blnSubstituido Or blnAntecipado or ((blnSimPau) and Not(blnPeIcms))) Then
      Begin
        ParamByName('BASICM').AsFloat := 0.0;
        ParamByName('ALQICM').AsFloat := 0.0;
        ParamByName('VALICM').AsFloat := 0.0;
      End
      Else
      Begin
        ParamByName('BASICM').AsFloat := fStrToFloat(edtBasIcm.Text);
        ParamByName('ALQICM').AsFloat := fStrToFloat(edtAlqIcm.Text);
        ParamByName('VALICM').AsFloat := fStrToFloat(edtValIcm.Text);
      End;

      ParamByName('BASIPI').AsFloat   := fStrToFloat(edtBasIpi.Text);
      ParamByName('ALQIPI').AsFloat   := fStrToFloat(edtAlqIpi.Text);
      ParamByName('VALIPI').AsFloat   := fStrToFloat(edtValIpi.Text);
      ParamByName('ISENTO').AsFloat   := 0.0;
      ParamByName('CLAIPI').AsString  := edtClaIpi.Text;

      If (strClaSub  <> '1') Then
      Begin
        ParamByName('PEBAST').AsFloat   := fltPeBaST;
        ParamByName('BASRET').AsFloat   := fltBasRet;
        ParamByName('VALRET').AsFloat   := fltValRet;
        ParamByName('BAERET').AsFloat   := 0;
        ParamByName('VAERET').AsFloat   := 0;
      End
      Else
      Begin
        ParamByName('PEBAST').AsFloat   := fltPeBaST;
        ParamByName('BAERET').AsFloat   := fltBasRet;
        ParamByName('VAERET').AsFloat   := fltValRet;
        ParamByName('BASRET').AsFloat   := 0;
        ParamByName('VALRET').AsFloat   := 0;
      End;

      ParamByName('BASANT').AsFloat   := fltBasAnt;
      ParamByName('VALANT').AsFloat   := fltValAnt;

      fltClcAux:=fRetornaValorOutras(fStrToFloat(edtTotIte.Text),
                                     fStrToFloat(edtBasIcm.Text),
                                     fStrToFloat(edtValIpi.Text),
                                     0.0, 0, 0, 0);

      If objExcecaoCfopCst.fExcecaoDefinida(strClaFis, strCodFis) Then
        blnIsentas := objExcecaoCfopCst.blnIsentas
      Else
        blnIsentas := fCodFisGravaIsentoDocEnt(strClaFis, strCodFis);

      If blnIsentas Then
      Begin
        ParamByName('ISENTO').AsFloat   := fltClcAux;
        ParamByName('OUTRAS').AsFloat   := 0;
      End Else
      begin
        ParamByName('ISENTO').AsFloat   := 0;
        ParamByName('OUTRAS').AsFloat   := fltClcAux;
      End;

      ParamByName('BFCPST').AsFloat :=  lRecFCP.fltBCFCPST;
      ParamByName('PFCPST').AsFloat :=  lRecFCP.fltPFCPST;
      ParamByName('VFCPST').AsFloat :=  lRecFCP.fltVFCPST;
      ParamByName('VBCFCP').AsFloat :=  lRecFCP.fltBCFCP;
      ParamByName('PERFCP').AsFloat :=  lRecFCP.fltAliFcp;
      ParamByName('VALFCP').AsFloat :=  lRecFCP.fltValFCP;

      If (fCfgSis('ATPRAU', varBoolean)) And ((Pos(edtCodFor.Text, fRetForFilialTodos) = 0) Or (fCfgSis('ATPREN', varBoolean))) Then
      Begin
        ParamByName('PRECOM').AsFloat := fltPreCom;
        ParamByName('PRECUS').AsFloat := fltPreCus;

        For intCont := 1 To Length(recPrecos) Do
        Begin
          ParamByName('COMTB' + IntToStr(intCont)).AsFloat := recPrecos[intCont].fltComiss;

          If (Not blnFatPre) Or (intCont = 1) Then
          Begin
            If blnAtpVmb[intCont] Then
              ParamByName('PREVE' + IntToStr(intCont)).AsFloat := recPrecos[intCont].fltPreVen
            Else
              ParamByName('MARBR' + IntToStr(intCont)).AsFloat := recPrecos[intCont].fltMarBru;
          End Else
          Begin
            ParamByName('PREVE' + IntToStr(intCont)).AsFloat := recPrecos[intCont].fltPreVen;
            ParamByName('MARBR' + IntToStr(intCont)).AsFloat := recPrecos[intCont].fltMarBru;
          End;
          
        End;

      End;

      If blnAtuIpi Then
        ParamByName('IPIENT').AsFloat   := fStrToFloat(edtAlqIPI.Text);

      If blnUsaLotePrecos Then
      Begin

        If blnAtuSub Then
        Begin
          If fStrToFloat(edtTotIte.Text) <= 0 Then
            ParamByName('SUBSTI').AsFloat  := 0
          Else
            ParamByName('SUBSTI').AsFloat  := fFormataFloat(((fltValRet + fltValAnt)/ fStrToFloat(edtTotIte.Text) * 100), 2);
        End

        Else ParamByName('SUBSTI').AsFloat := fItem('SUBSTI').AsFloat;
      End;

      {*****************************************}
      {* DADOS DO FILTRO                       *}
      {**************************************MV*}
      ParamByName('AUTINC').AsInteger := btnAdicionar.Tag;

      ExecSQL;
      Close;

    End;

    btnAdicionar.Tag := 0;

  Finally
    FreeAndNil(cpcParams);
    FreeAndNil(qryGenMer);
  End;
end;

procedure TfrmEntMercadorias.pAlteraItemNfe;
  Var
    strSQL: String;

    fltPreCom: Double;
    fltPreCus: Double;

    cpcParams: TParCalculaPrecoCusto;
    qryGenMer: TUniQuery;

    recPrecos: Array[1..7] Of TRecPrecos;
    intCont  : Integer;

    function fItem(strCampo: String): TField;
    begin
      Result := qryConIte.FieldByName('ITE_' + strCampo);
    end;
begin
  cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);
  qryGenMer := fCriaQuery(Self);
  Try
   If (qryEntMer.Active And (Not qryEntMer.IsEmpty) And
      ((Not qryConIte.Active) Or (qryConCit.IsEmpty) Or (qryConCit.FieldByName('ITE_CODITE').AsString <> qryEntMer.FieldByName('ENT_CODITE').AsString))) Then
      pCarregaItem(qryEntMer.FieldByName('ENT_CODITE').AsString, False, False, True);

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  TMP_ENTMER ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  ENT_NUMLOT = :NUMLOT, ';
    strSQL := strSQL + '  ENT_EMBALA = :EMBALA, ';
    strSQL := strSQL + '  ENT_UNIEMB = :UNIEMB, ';
    strSQL := strSQL + '  ENT_CODITE = :CODITE, ';
    strSQL := strSQL + '  ENT_CODGRU = :CODGRU, ';
    strSQL := strSQL + '  ENT_DESITE = :DESITE, ';
    strSQL := strSQL + '  ENT_REFERE = :REFERE, ';
    strSQL := strSQL + '  ENT_CODUNI = :CODUNI, ';
    strSQL := strSQL + '  ENT_QTDITE = :QTDITE, ';
    strSQL := strSQL + '  ENT_UNITAR = :UNITAR, ';
    strSQL := strSQL + '  ENT_TOTITE = :TOTITE, ';
    strSQL := strSQL + '  ENT_CLAIPI = :CLAIPI, ';

    If Not edtBasIcm.ReadOnly Then
    Begin
      strSQL := strSQL + '  ENT_BASICM = :BASICM,  ';
      strSQL := strSQL + '  ENT_ALQICM = :ALQICM,  ';
      strSQL := strSQL + '  ENT_VALICM = :VALICM,  ';
    End;

    strSQL := strSQL + '  ENT_VLRCON = :VLRCON  ';

    If (fCfgSis('ATPRAU', varBoolean)) And ((Pos(edtCodFor.Text, fRetForFilialTodos) = 0) Or (fCfgSis('ATPREN', varBoolean))) Then
    Begin
      strSQL := strSQL + '  ,ENT_PRECOM = :PRECOM, ';
      strSQL := strSQL + '  ENT_PRECUS = :PRECUS, ';
      {*******************************************}
      {* VERIFICA SE ALTERA PREÇO DE VENDA OU    *}
      {* MARGEM BRUTA                            *}
      {****************************************MV*}
      For intCont := 1 to Length(recPrecos) Do
      Begin
        strSQL := strSQL + '  ENT_COMTB' + IntToStr(intCont) + ' = :COMTB' + IntToStr(intCont) + ', ';

        If (Not blnFatPre) Or (intCont = 1) Then
        Begin
          If blnAtpVmb[intCont] Then
            strSQL := strSQL + '  ENT_PREVE' + IntToStr(intCont) + ' = :PREVE' + IntToStr(intCont) + ', '
          Else
            strSQL := strSQL + '  ENT_MARBR' + IntToStr(intCont) + ' = :MARBR' + IntToStr(intCont) + ', ';
        End Else
        Begin
          strSQL := strSQL + '  ENT_PREVE' + IntToStr(intCont) + ' = :PREVE' + IntToStr(intCont) + ', ';
          strSQL := strSQL + '  ENT_MARBR' + IntToStr(intCont) + ' = :MARBR' + IntToStr(intCont) + ', ';
        End;

        If IntCont = Length(recPrecos) Then
          strSQL := Copy(strSQL, 1, Length(strSQL) - 2);
      End;
    End;

    If blnAtuIpi Then
      strSQL := strSQL + '  ,ENT_IPIENT = :IPIENT  ';

    If blnUsaLotePrecos Then
    Begin
      strSQL := strSQL + '  ,ENT_SUBSTI = :SUBSTI  ';
    End;

    strSQL := strSQL + ' ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

    With qryGenMer Do
    Begin
      {**********************************}
      {* CALCULA PREÇOS DE CUSTO        *}
      {*******************************JB*}
      fltPreCom := fStrToFloat(edtUnitar.Text);
      With cpcParams Do
      Begin
        curPreCom := fltPreCom;

        curDesF01 := fItem('DESF01').AsFloat;
        curDesF02 := fItem('DESF02').AsFloat;
        curDesF03 := fItem('DESF03').AsFloat;
        curDesF04 := fItem('DESF04').AsFloat;
        curDesF05 := fItem('DESF05').AsFloat;
        curDesF06 := fItem('DESF06').AsFloat;

        curSubsti := fItem('SUBSTI').AsFloat;
        curICMSEnt:= fItem('ICMENT').AsFloat;

        If blnAtuIpi Then
          curIPIEnt := fStrToFloat(edtAlqIPI.Text)
        Else
          curIPIEnt := fItem('IPIENT').AsFloat;

        If blnUsaLotePrecos Then
        Begin

          If blnAtuSub Then
          Begin
            If qryEntMer.FieldByName('ENT_TOTITE').AsFloat <= 0 Then
              curSubsti := 0
            Else
              curSubsti := fFormataFloat(((qryEntMer.FieldByName('ENT_VALRET').AsFloat +
                                           qryEntMer.FieldByName('ENT_VALANT').AsFloat) /
                  (qryEntMer.FieldByName('ENT_TOTITE').AsFloat + IIF(strFrmCus = '1', qryEntMer.FieldByName('ENT_VALIPI').AsFloat, 0))) * 100, 2);
           End;

          If blnAtuIcm Then
            curICMSEnt := qryEntMer.FieldByName('ENT_ALQICM').AsFloat;
        End;

        curFrete  := fItem('FREENT').AsFloat;
        curAcrFin := fItem('ACRFIN').AsFloat;
        curDesAdb := fItem('DESADB').AsFloat;
        curSubFed := fItem('SUBFED').AsFloat;

        if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
        begin
          curTCIFCu := fItem('TCIFCU').AsFloat;
          curTSCust := fItem('TSCUST').AsFloat;
          curDePiCo := fItem('DEPICO').AsFloat;
          curDeICMS := fItem('DEICMS').AsFloat;
          curFatReg := fItem('FATREG').AsFloat;
        end
        else
        begin
          curTCIFCu := 0;
          curTSCust := 0;
          curDePiCo := 0;
          curDeICMS := 0;
          curFatReg := 0;
        end;
      End;

      fltPreCus := cpcParams.fCalculaPrecoCusto();

      For intCont := 1 to Length(recPrecos) Do
      Begin
        recPrecos[intCont].fltComiss := fItem('COMTB' + IntToStr(intCont)).AsFloat;

        {*******************************************}
        {* CALCULA OS NOVOS PREÇOS DE VENDA        *}
        {****************************************MV*}
        If ((Not blnFatPre) Or (blnFatPre And (Not objFatPre.fTabelaAtiva(IntCont)))) Or (IntCont = 1) Then
          recPrecos[intCont].fltPreVen := fCalculaPrecoVenda(1,
                                                             fltPreCus + fItem('OUTVAL').AsFloat,
                                                             0,
                                                             fItem('MARBR' + IntToStr(intCont)).AsFloat,
                                                             fItem('ICMSAIDA').AsFloat,
                                                             fItem('IMPFED').AsFloat,
                                                             fItem('DESOPE').AsFloat,
                                                             recPrecos[intCont].fltComiss)
        Else
            recPrecos[intCont].fltPreVen :=
              objFatPre.fCalculaPrecoVendaFator(recPrecos[1].fltPreVen, intCont);

        {*******************************************}
        {* CALCULA AS NOVAS MARGENS BRUTAS         *}
        {****************************************MV*}
        If ((Not blnFatPre) Or (blnFatPre And (Not objFatPre.fTabelaAtiva(IntCont)))) Or (IntCont = 1) Then
          recPrecos[intCont].fltMarBru := fCalculaPrecoVenda(2,
                                                             fltPreCus + fItem('OUTVAL').AsFloat,
                                                             recPrecos[intCont].fltPreVen * qryEntMer.FieldByName('ENT_EMBALA').AsFloat,
                                                             0,
                                                             qryEntMer.FieldByName('ENT_ICMSAI').AsFloat,
                                                             fItem('IMPFED').AsFloat,
                                                             fItem('DESOPE').AsFloat,
                                                             recPrecos[intCont].fltComiss)
        Else
          recPrecos[intCont].fltMarBru := fCalculaPrecoVenda(2,
                                                             fltPreCus + fItem('OUTVAL').AsFloat,
                                                             recPrecos[intCont].fltPreVen,
                                                             0,
                                                             qryEntMer.FieldByName('ENT_ICMSAI').AsFloat,
                                                             fItem('IMPFED').AsFloat,
                                                             fItem('DESOPE').AsFloat,
                                                             recPrecos[intCont].fltComiss);
      End;

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      {*****************************************}
      {* DADOS QUE SERÃO ALTERADOS             *}
      {**************************************MV*}
      ParamByName('NUMLOT').AsString  := edtNumLot.Text;
      objCadLot.strLotAnt := edtNumLot.Text;

      If Not edtBasIcm.ReadOnly Then
      Begin
        ParamByName('BASICM').AsFloat := fStrToFloat(edtBasIcm.Text);
        ParamByName('ALQICM').AsFloat := fStrToFloat(edtAlqIcm.Text);
        ParamByName('VALICM').AsFloat := fStrToFloat(edtValIcm.Text);
      End;

      ParamByName('EMBALA').AsFloat   := fStrToFloat(edtEmbala.Text);
      ParamByName('UNIEMB').AsString  := qryConCit.FieldByName('ITE_UNICOM').AsString;
      ParamByName('CODITE').AsString  := edtCodIte.Text;
      ParamByName('CODGRU').AsString  := qryConCit.FieldByName('ITE_CODGRU').AsString;
      ParamByName('DESITE').AsString  := edtDesIte.Text;
      ParamByName('REFERE').AsString  := edtRefere.Text;
      ParamByName('CODUNI').AsString  := edtUnidad.Text;
      ParamByName('QTDITE').AsFloat   := fStrToFloat(edtQtdIte.Text);
      ParamByName('UNITAR').AsFloat   := fStrToFloat(edtUnitar.Text);
      ParamByName('TOTITE').AsFloat   := fStrToFloat(edtTotIte.Text);
      ParamByName('CLAIPI').AsString  := edtClaIpi.Text;
      ParamByName('VLRCON').AsFloat   := fStrToFloat(edtTotIte.Text);

      If (fCfgSis('ATPRAU', varBoolean)) And ((Pos(edtCodFor.Text, fRetForFilialTodos) = 0) Or (fCfgSis('ATPREN', varBoolean))) Then
      Begin
        ParamByName('PRECOM').AsFloat := fltPreCom;
        ParamByName('PRECUS').AsFloat := fltPreCus;

        For intCont := 1 to Length(recPrecos) Do
        Begin
          ParamByName('COMTB' + IntToStr(intCont)).AsFloat := recPrecos[intCont].fltComiss;

          If (Not blnFatPre) Or (intCont = 1) Then
          Begin
            If blnAtpVmb[intCont] Then
              ParamByName('PREVE' + IntToStr(intCont)).AsFloat := recPrecos[intCont].fltPreVen
            Else
              ParamByName('MARBR' + IntToStr(intCont)).AsFloat := recPrecos[intCont].fltMarBru;
          End Else
          Begin
            ParamByName('PREVE' + IntToStr(intCont)).AsFloat := recPrecos[intCont].fltPreVen;
            ParamByName('MARBR' + IntToStr(intCont)).AsFloat := recPrecos[intCont].fltMarBru;
          End;
          
        End;
      End;

      If blnAtuIpi Then
        ParamByName('IPIENT').AsFloat := fStrToFloat(edtAlqIPI.Text);

      If blnUsaLotePrecos Then
      Begin

        If blnAtuSub Then
        Begin
          If qryEntMer.FieldByName('ENT_TOTITE').AsFloat <= 0 Then
            ParamByName('SUBSTI').AsFloat  := 0
          Else
            ParamByName('SUBSTI').AsFloat  :=
              fFormataFloat(((qryEntMer.FieldByName('ENT_VALRET').AsFloat +
                              qryEntMer.FieldByName('ENT_VAERET').AsFloat +
                              qryEntMer.FieldByName('ENT_VALANT').AsFloat) /
                              qryEntMer.FieldByName('ENT_TOTITE').AsFloat * 100), 2);
        End

        Else ParamByName('SUBSTI').AsFloat := fItem('SUBSTI').AsFloat;
      End;

      {*****************************************}
      {* DADOS DO FILTRO                       *}
      {**************************************MV*}
      ParamByName('AUTINC').AsInteger := btnAdicionar.Tag;

      ExecSQL;
      Close;

    End;

//    If Not blnSemInc Then
      btnAdicionar.Tag := 0;

  Finally
    FreeAndNil(cpcParams);
    FreeAndNil(qryGenMer);
  End;
end;

procedure TfrmEntMercadorias.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  If fItemCarregadoParaVisualizacao Then
    pCarregaItensAlteracao;


  If Not blnSemInc Then
  Begin
    pLimpaDadosItem;
    edtCodIte.Enabled := True;
    pSetFocus(edtCodIte);
    btnAdicionar.Tag := 0;
  End Else
  Begin
    btnAdicionar.Tag := 0;
    pLimpaDadosItem;
  End;
end;

procedure TfrmEntMercadorias.edtAlqIcmEnter(Sender: TObject);
begin
  inherited;
  If fItemCarregadoParaVisualizacao Then
    pCarregaItensAlteracao;

end;

procedure TfrmEntMercadorias.edtAlqIPIEnter(Sender: TObject);
begin
  inherited;
  If fItemCarregadoParaVisualizacao Then
    pCarregaItensAlteracao;

end;

procedure TfrmEntMercadorias.edtBasIcmEnter(Sender: TObject);
begin
  inherited;
  If fItemCarregadoParaVisualizacao Then
    pCarregaItensAlteracao;

end;

procedure TfrmEntMercadorias.edtBasIPIEnter(Sender: TObject);
begin
  inherited;
  If fItemCarregadoParaVisualizacao Then
    pCarregaItensAlteracao;

end;

procedure TfrmEntMercadorias.edtClaIpiEnter(Sender: TObject);
begin
  inherited;
  If fItemCarregadoParaVisualizacao Then
    pCarregaItensAlteracao;

end;

procedure TfrmEntMercadorias.edtCodAbfEnter(Sender: TObject);
begin
  inherited;
  If fItemCarregadoParaVisualizacao Then
    pCarregaItensAlteracao;

end;

procedure TfrmEntMercadorias.edtCodAbfKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrAbf: TConsultasArray;
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If (not edtCodAbf.ReadOnly) And fPesqAbrevFiscal(Self, edtCodAbf, edtDesAbf, Nil, Key, arrAbf) Then
  Begin
    If fValidaCampos(edtCodAbf, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEntMercadorias.edtCodCestEnter(Sender: TObject);
begin
  inherited;
  If fItemCarregadoParaVisualizacao Then
    pCarregaItensAlteracao;

end;

procedure TfrmEntMercadorias.edtCodCestKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqCest(Self,  edtCodCest,  nil,  nil, Key, arrSel) Then
      SelectNext(ActiveControl, True, True);

end;

procedure TfrmEntMercadorias.edtQtdIteEnter(Sender: TObject);
begin
  inherited;
  If fItemCarregadoParaVisualizacao Then
    pCarregaItensAlteracao;
end;

procedure TfrmEntMercadorias.edtQtdIteExit(Sender: TObject);
begin
  inherited;
  pCalculaTotIte(Sender);
end;

procedure TfrmEntMercadorias.edtRefereEnter(Sender: TObject);
begin
  inherited;
  If fItemCarregadoParaVisualizacao Then
    pCarregaItensAlteracao;
end;

procedure TfrmEntMercadorias.edtSiglaEnter(Sender: TObject);
begin
  inherited;
  If fItemCarregadoParaVisualizacao Then
    pCarregaItensAlteracao;

end;

procedure TfrmEntMercadorias.pDeletaItem(AItem: integer);
  Var
    strSQL   : String;
    qryGenMer: TUniQuery;
begin
  Try

    qryGenMer := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  TMP_ENTMER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  AUTOINCREM = :AUTINC; ';

    With qryGenMer Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTINC').AsInteger := qryEntMer.FieldByName('AUTOINCREM').AsInteger;
      ExecSQL;


      qryGenMer.SQL.Clear;
      qryGenMer.SQL.Add('UPDATE TMP_ENTMER');
      qryGenMer.SQL.Add('SET ENT_N_ITEM = ENT_N_ITEM_TELA -1,');
      qryGenMer.SQL.Add('    ENT_N_ITEM_TELA = ENT_N_ITEM_TELA -1');
      qryGenMer.SQL.Add(' WHERE ENT_N_ITEM_TELA > ' + AItem.ToString);
      ExecSQL;


      Close;

      objLock.fLock_Unlock(STR_TRAVA_LOTE + qryEntMer.FieldByName('ENT_CODITE').AsString, False, True, False, '', True, 'ENTRADA');

    End;

    pCalculaTotais;

    fltMaxDev := 0;

  Finally
    FreeAndNil(qryGenMer);
  End;
end;

procedure TfrmEntMercadorias.btnAlterPrecosClick(Sender: TObject);
  Var
    ctrAtual: TWinControl;
    frmEntAlteraPrecos : TfrmEntAlteraPrecos;
begin
  ctrAtual := ActiveControl;

  If (Not btnAlterPrecos.Visible) Or (Not btnAlterPrecos.Enabled) Then
    Exit;

  If (qryEntMer.Active)          And
     (qryEntMer.RecordCount > 0) Then
  Begin
    Try
      qryEntMer.First;
      pCriarFormularios(TfrmEntAlteraPrecos, frmEntAlteraPrecos);
      frmEntAlteraPrecos.strCodFor := edtCodFor.Text;
      frmEntAlteraPrecos.qryEntMer := qryEntMer;
      frmEntAlteraPrecos.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmEntMercadorias.btnAlterPrecosClick]');
      End;
    End;
    pFreeAndNil(frmEntAlteraPrecos);

    pAtualizaTabela;
    btnCancelaItem.Click;

    pSetFocus(ctrAtual);
  End;
end;

procedure TfrmEntMercadorias.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  blnEscape := False;

  Case Key Of
    VK_INSERT:
      If (edtCodFor.Focused) And
         ((blnDevolu) Or (blnRecCliGarantia) Or (blnConEqu) Or (blnLocEqu) or (FblnAcessadoViaRetornoConsignacao)) And
         fVerificaAcessoSistema('frmCadClientes') Then
      Begin
        TLiberacaoFactory.pSetLiberacao( TLiberacao.Create );
        edtCodFor.Text := fChamaCadCli(Key);
      End
      Else
      If (edtCodFor.Focused) And fVerificaAcessoSistema('frmCadFornecedores') Then
      Begin
        TLiberacaoFactory.pSetLiberacao( TLiberacao.Create );
        edtCodFor.Text := untFuncIns.fChamaCadFor(Key);
      End;
  End;

  If (Key = VK_F5) Then
  Begin
    btnAlterPrecos.Click;
  End

  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
    Key := 0;
  End

  Else If (Key = VK_F6) Then
  Begin
    btnIniBus.Click;
  End

  Else If (Key = VK_F7) Then
  Begin
    btnLocProx.Click;
  End

  Else If (Key = VK_F8) Then
  Begin
    btnCadLot.Click;
  End
  Else If (Key = VK_F9) Then
    btnCadProduto.Click

  Else If (Key = VK_ESCAPE) Then
  Begin
    //btnCancelarEntrada.Click;
  End;
end;

procedure TfrmEntMercadorias.FormPaint(Sender: TObject);
begin
  inherited;

  If blnFecharForm Then
    Close;
end;

Function TfrmEntMercadorias.fCarregaNumPedCom: Boolean;
  Var
    oleItensPedidos: OleVariant;
    cdsPedidos: TUniClientDataSet;
    strUpd: String;
    qryGen: TUniQuery;
    blnBaiPed: Boolean;
    blnControlar: Boolean;
Begin
  Result := True;
  (******************************************************************)
  (* SE NAO CARREGOU OS ITENS DO PEDIDO PROCURA O PRIMEIRO ITEM QUE *)
  (* ENCONTRAR PARA PEGAR O NUMERO DO PEDIDO                        *)
  (***************************************************************LA*)
  If Not blnCarregProd Then
  Begin
    oleItensPedidos := fDefinePedidosABaixar(blnBaiPed, qryEntMer, stlPedidos, recNotEle.strAutInc);

    If Not blnBaiPed then
    Begin
      Result := False;
      Exit;
    End;

    If oleItensPedidos <> Null Then
    Begin
      cdsPedidos := TUniClientDataSet.Create(Self);
      cdsPedidos.Data := oleItensPedidos;
      cdsPedidos.Filtered := False;
      cdsPedidos.First;

      qryGen := fCriaQuery;
      strUpd := '';
      strUpd := strUpd + 'UPDATE ';
      strUpd := strUpd + '  TMP_ENTMER ';
      strUpd := strUpd + 'SET ';
      strUpd := strUpd + '  ENT_NUMPED = :NUMPED, ';
      strUpd := strUpd + '  ENT_CODEMP = :CODEMP, ';
      strUpd := strUpd + '  ENT_SEQPCD = :SEQPCD ';
      strUpd := strUpd + 'WHERE ';
      strUpd := strUpd + '  AUTOINCREM = :AUTINC ';
      qryGen.SQL.Text := strUpd;
      blnControlar := Not qryEntMer.ControlsDisabled;
      Try
        With qryEntMer Do
        Begin

          if blnControlar then
            qryEntMer.DisableControls;

          First;
          While Not Eof Do
          Begin
            qryGen.Close;

            If cdsPedidos.Locate('CODITE', FieldByName('ENT_CODITE').AsString, []) Then
            Begin
              qryGen.ParamByName('NUMPED').AsString := cdsPedidos.FieldByName('NUMPED').AsString;
              qryGen.ParamByName('CODEMP').AsString := cdsPedidos.FieldByName('CODEMP').AsString;
              qryGen.ParamByName('SEQPCD').AsString := cdsPedidos.FieldByName('AUTINC').AsString;
            End
            Else
              qryGen.ParamByName('NUMPED').AsString := '';

            qryGen.ParamByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;

            qryGen.ExecSQL;

            Next;
          End;

          pAtualizaTabela;
        End;
      Finally
        if blnControlar then
          qryEntMer.EnableControls;
        FreeAndNil(cdsPedidos);

        FreeAndNil(qryGen);
      End;
    End;

  End;
End;

function TfrmEntMercadorias.fCarregaPrecoFornecedor(strCodIte,
  strCodFor: String; qryPreco : TUniQuery): Boolean;
begin
  With qryPreco, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT ');
    Add('  D.* ');
    Add('FROM ITEFOR FX');

    Add(' INNER JOIN TABPRE TAB ON TAB.TAB_CODTAB = FX.ITE_CODTAB ');

    Add(' INNER JOIN TABDET D ON D.ITE_CODTAB = FX.ITE_CODTAB ');
    Add('                    AND D.ITE_CODITE = FX.ITE_CODITE ');
    Add('                    AND D.ITE_CODEMP = :CODEMP ');

    Add('WHERE');
    Add('  FX.ITE_CODFOR = :CODFOR AND   ');
    Add('  FX.ITE_CODITE = :CODITE AND   ');
    Add('  TAB.TAB_ATICMP = "S"  ');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODFOR').AsString := strCodFor;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    Result := (Not IsEmpty) ;
  End;

end;

procedure TfrmEntMercadorias.pAtualizaIpiOriginal;
  Var
    qryAux: TUniQuery;
Begin
  qryAux := fCriaQuery(Self);

  With qryAux Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' UPDATE TMP_ENTMER SET ');
    SQL.Add('   ENT_BASIPU = ENT_BASIPI ');
    ExecSQL;
    Close;
    pAtualizaTabela;
  End;

  FreeAndNil(qryAux);
End;

Function TfrmEntMercadorias.fValidaPrecosDevolucao: Boolean;
  Var
    qryDiferencas: TUniQuery;

    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;

    fltTotPra: Double;
    fltTotSug: Double;

    intAgrupador : Integer;

    Function fRetDocsVenda: String;

      Function FSQLNotas(strTabela: String): String;
        Var
          strSQL: String;
      Begin
        strSQL := '';
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   GROUP_CONCAT(DISTINCT CONCAT(DET_NUMDOC, "-", DET_ESPDOC, "-", DET_CODEMP)) AS NOTAS ';
        strSQL := strSQL + ' FROM ';
        strSQL := strSQL + '   TMP_ENTMER ';
        strSQL := strSQL + ' INNER JOIN ' + strTabela + ' D ON D.AUTOINCREM = ENT_AUTVEN ';
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '   ROUND(DET_UNITAR, 2) <>  ROUND(ENT_UNITAR, 2) ';
        strSQL := strSQL + '   AND IF(IFNULL(ENT_TABELA, "") <> "", ENT_TABELA = "'+strTabela+'" , TRUE)';

        Result := strSQL;
      End;

      Var
        qryNotas: TUniQuery;
    Begin
      qryNotas := fCriaQuery;
      With qryNotas Do
      Begin
        SQL.Text := fSQLNotas('MOVDET');
        Open;

        If IsEmpty Or fEmptyStr(FieldByName('NOTAS').AsString) then
        Begin
          Close;
          SQL.Clear;
          SQL.Add(fSQLNotas('NOTDET'));
          Open;
        End;

        Result := FieldByName('NOTAS').AsString;
      End;

      FreeAndNil(qryNotas);
    End;

    Function fSQLItens(strTabela: String): String;
      Var
        strSQL: String;
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   T.AUTOINCREM AS AUTINC, ';
      strSQL := strSQL + '   ENT_CODITE AS CODITE, ';
      strSQL := strSQL + '   ENT_DESITE AS DESITE, ';
      strSQL := strSQL + '   ITE_CODMAR AS CODMAR, ';
      strSQL := strSQL + '   UNI_SIGUNI AS SIGUNI, ';
      strSQL := strSQL + '   ENT_QTDITE AS QTDDEV, ';
      strSQL := strSQL + '   DET_UNITAR AS PRESUG, ';
      strSQL := strSQL + '   ENT_UNITAR AS PREPRA, ';
      strSQL := strSQL + '   ENT_QTDITE * DET_UNITAR AS TOTSUG, ';
      strSQL := strSQL + '   ENT_QTDITE * ENT_UNITAR AS TOTPRA   ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   TMP_ENTMER T ';
      strSQL := strSQL + ' INNER JOIN CADITE ON ITE_CODITE = ENT_CODITE ';
      strSQL := strSQL + ' INNER JOIN CADUNI ON UNI_CODUNI = ENT_CODUNI ';
      strSQL := strSQL + ' INNER JOIN ' + strTabela + ' D ON D.AUTOINCREM = ENT_AUTVEN ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   ROUND(DET_UNITAR, 2) <>  ROUND(ENT_UNITAR, 2) ';
      strSQL := strSQL + '   AND IF(IFNULL(ENT_TABELA, "") <> "", ENT_TABELA = "'+strTabela+'" , TRUE)';


      Result := strSQL;
    End;

Begin
  Result := True;

  If fVerificaAcessoSistema('LIBPREDEV', strLoginUsuarioLogado) Then
    Exit;

  qryDiferencas := fCriaQuery;
  With qryDiferencas Do
  Begin
    SQL.Add(fSQLItens('MOVDET'));
    SQL.Add(' ORDER BY AUTINC ');

    Open;

    If IsEmpty then
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fSQLItens('NOTDET'));
      SQL.Add(' ORDER BY AUTINC ');
      Open;
    End;

    If (Not IsEmpty) then
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('ENTRADA POR DEVOLUCAO, COM PREÇOS ALTERADOS');
      objLiberacao.objMsgLibera.pAddSeparador(113);

      objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'         , edtCodFor.Text + '-' + fRetNomCliente(edtCodFor.Text)              , 15);
      objLiberacao.objMsgLibera.pAddTextoCaption('Documento Venda' , fRetDocsVenda                                                      , 15);
      objLiberacao.objMsgLibera.pAddTextoCaption('Operador'        , strLoginUsuarioLogado + '-' + fRetNomVendRep(strLoginUsuarioLogado), 15);

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'Cod.'              , fTamCodIte + 1  , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'Descrição'         , 10 , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'Quantidade'        , 12 , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'Pr.Unit.Sugerido'  , 17 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'Pr.Unit.Praticado' , 18 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'Pr.Tot.Sugerido'   , 17 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'Pr.Tot.Praticado'  , 18 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      fltTotPra := 0;
      fltTotSug := 0;
      intAgrupador := -1;

      while Not Eof do
      Begin
        inc(intAgrupador);

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.intAgrupador := intAgrupador;
        objLinha.pAddColuna('Cod.'       , FieldByName('CODITE').AsString , fTamCodIte + 1   , alCentro);
        objLinha.pAddColuna( 'Descrição' , FieldByName('DESITE').AsString , 102 , alEsquerda);
        objTabela.lstLinhas.Add(objLinha);

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.intAgrupador := intAgrupador;
        objLinha.pAddColuna('Cod.'  , ''                                                                                  , fTamCodIte + 1  , alCentro  , teAutcom);
        objLinha.pAddColuna('Marca' , FieldByName('CODMAR').AsString + '-' + fRetNomeMarca(FieldByName('CODMAR').AsString), 102 , alEsquerda, teAmbos, True);
        objTabela.lstLinhas.Add(objLinha);

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.intAgrupador := intAgrupador;
        objLinha.pAddColuna('Cod.'              , ' '                                                    , fTamCodIte + 1  , alCentro   , teAutcom);
        objLinha.pAddColuna('Unid.'             , FieldByName('SIGUNI').AsString                         , 10 , alEsquerda , teAmbos , True);
        objLinha.pAddColuna('Quantidade'        , FormatFloat('#,##0.00', FieldByName('QTDDEV').AsFloat) , 12 , alEsquerda , teAmbos);
        objLinha.pAddColuna('Pr.Unit.Sugerido'  , FormatFloat('#,##0.00', FieldByName('PRESUG').AsFloat) , 17 , alDireita  , teAmbos);
        objLinha.pAddColuna('Pr.Unit.Praticado' , FormatFloat('#,##0.00', FieldByName('PREPRA').AsFloat) , 18 , alDireita  , teAmbos);
        objLinha.pAddColuna('Pr.Tot.Sugerido'   , FormatFloat('#,##0.00', FieldByName('TOTSUG').AsFloat) , 17 , alDireita  , teAmbos);
        objLinha.pAddColuna('Pr.Tot.Praticado'  , FormatFloat('#,##0.00', FieldByName('TOTPRA').AsFloat) , 18 , alDireita  , teAmbos);
        objTabela.lstLinhas.Add(objLinha);


        fltTotPra := fltTotPra + FieldByName('TOTPRA').AsFloat;
        fltTotSug := fltTotSug + FieldByName('TOTSUG').AsFloat;
        Next;
      End;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlTotal;
      objLinha.pAddColuna(''                 , 'Totais'                           , 71 , alDireita  , teAutcom);
      objLinha.pAddColuna('Pr.Tot.Sugerido'  , FormatFloat('#,##0.00', fltTotSug) , 17 , alDireita);
      objLinha.pAddColuna('Pr.Tot.Praticado' , FormatFloat('#,##0.00', fltTotPra) , 18 , alDireita);
      objTabela.lstLinhas.Add(objLinha);

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      objLiberacao.strDirAce := 'LIBPREDEV';
      objLiberacao.strMsgSen := 'Devolução com Preço Divergente';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;

      Result := objLiberacao.fLibera;
    End;

  End;
  FreeAndNil(qryDiferencas);
End;

Function TfrmEntMercadorias.fTemProdutosEmDolar: Boolean;
  Var
    strSQL: String;
    qryItens: TUniQuery;
Begin
  Result := False;

  If Not fTabelaExiste('TMP_ENTMER') Then
    Exit;

  strSQL := '';
  strSQL := strSQL + ' SELECT COUNT(*) AS QTD FROM TMP_ENTMER ';
  strSQL := strSQL + ' INNER JOIN ITEGER G ON G.ITE_CODITE = ENT_CODITE  ';
  strSQL := strSQL + ' WHERE G.ITE_CODEMP = :CODEMP AND G.ITE_PREDOL = "S" ';

  qryItens := fCriaQuery;
  qryItens.SQL.Text := strSQL;

  qryItens.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryItens.Open;

  Result := qryItens.FieldByName('QTD').AsInteger > 0;

  FreeAndNil(qryItens);
End;

Function TfrmEntMercadorias.fPedeCotacao: Boolean;
Begin
  Result := True;

  If blnCotDor And (Not blnInformouCotacao) And
     fCfgSis('ATPRAU', VarBoolean) And fTemProdutosEmDolar Then
  Begin
    Result := TfrmPedeCotacaoMoeda.fPedeCotacaoMoeda(fltCotDol, infoItemEmDolar);
  End;

End;

Function TfrmEntMercadorias.fExisteItemAlteradoManualmenteGrid: Boolean;
Begin
  Result:= False;
  qryEntMer.First;
  While Not(qryEntMer.Eof) Do
  Begin
    Result:= qryEntMer.FieldByName('ENT_ALTITEM').AsString = 'S';
    If Result Then
      Exit
    Else
      qryEntMer.Next;
  End;

End;


procedure TfrmEntMercadorias.btnConfirmaClick(Sender: TObject);
  Var
    strEtiPCT,
    strListaItens,
    strVeiBol  : String;
    strDeposi  : String;
    strBcoFor  : String;
    qryGenMer  : TUniQuery;
    oleItensPedidos: OleVariant;
    blnBaiPed: Boolean;
    CalcResult: TResultPisCofins;
    tmp: TCalculoPisCofins;
    fltBasPis,
    fltBasCof,
    fltTotPis,
    fltTotCof,
    fltPerPis,
    fltPerCof,
    fltValIpi,
    fltValRet: Double;
    strDesIte : String;
    objAntIte : TIcmsAntecipado;
    strAutIncMovGer,
    strAutIncCadFis : String;
    intCtpCon: Longint;
    blnCREIPI: Boolean;
    blnCLASUB: Boolean;
    blnGravouMovDet: Boolean;
    blnGerouLotDePreco: Boolean;
    frmEntDadosCaixa2 : TfrmEntDadosCaixa2;
    frmEntDadosFiscais : TfrmEntDadosFiscais;
    frmLotePrecosEfetivacaoCx: TfrmLotePrecosEfetivacaoCx;
    frmMensagem: TfrmMensagemExplicativa;
    strSitP_C: string;
    ArrCteMov: TArrCteMov;
    objDefBaixa: TDefineBaixaPedido;
    blnResult: Boolean;
    strCodErrosAuditoria: String;
begin
  inherited;
  {* Req. 455181 - locais de ponteiro de form sempre inicializadas: os     *}
  {* pFreeAndNil no fim dos blocos operariam sobre lixo de pilha se uma    *}
  {* falha ocorresse antes de pCriarFormularios.                          *}
  frmEntDadosCaixa2  := nil;
  frmEntDadosFiscais := nil;

  objDefBaixa := nil;
  If Not (btnConfirma.Visible) Then
    Exit;
  qryEntMer.DisableControls;
  Try
    qryGenMer := fCriaQuery(Self);

    If Not (btnConfirma.Enabled) Then
      Exit;

    If qryEntMer.RecordCount <= 0 Then
      Exit;

    If (Not fVerificaDataBalanco) Then
      Exit;

    If Not fValidaCampos(mskDtaEnt, True) Then
      Exit;

    If Not fValidaCampos(mskDtaDoc, True) Then
      Exit;

    If Not fValidaCampos(edtSerie, True) Then
      Exit;

    If Not fVerificaLotes Then
      Exit;

    If edtEspDoc.Text = 'PD' Then
    Begin
      If fExisteItemAlteradoManualmenteGrid Then
      Begin
        If fMensagem('ATENÇÃO', 'Itens foram alterados. Deseja continuar?', ['&Sim', '&Não'], 2) = 2 Then
          Exit;
        qryEntMer.First;
      End;
    End;

    pCriarFormularios(TfrmMensagemExplicativa, frmMensagem);
    Try
      frmMensagem.Caption := 'Atenção';

      frmMensagem.mmoInstru.Lines.Clear;
      frmMensagem.mmoInstru.Lines.Add('Os itens abaixo não podem ter Aliquota de IPI Acima de 999%!');
      If not fValidaAliqIPI(strDesIte, frmMensagem.mmoInstru.Lines) Then
      Begin
        frmMensagem.Showmodal;
        Exit;
      End;
      frmMensagem.mmoInstru.Lines.Clear;
      frmMensagem.mmoInstru.Lines.Add('Os itens abaixo estão inativos! Verifique o cadastro.');
      If (recNotEle.finalidadeXML <> xmlEntradaMercadoriasSistemaAnteriorDevolucao) And ( Not fItemAtivo(strDesIte,frmMensagem.mmoInstru.Lines)) Then
      Begin
        frmMensagem.Showmodal;
        Exit;
      End;

      frmMensagem.mmoInstru.Lines.Clear;
      frmMensagem.mmoInstru.Lines.Add('Os itens abaixo não estão ativos para compras! Verifique o cadastro.');
      If (recNotEle.finalidadeXML <> xmlEntradaMercadoriasSistemaAnteriorDevolucao) And (Not fItemAtivoCompra(strDesIte,frmMensagem.mmoInstru.Lines)) Then
      Begin
        if fCfgSis('ITEINA', varBoolean) then
        begin
          if not TEntradaValidacoes.fLiberouItensInativos then
          begin
            frmMensagem.Showmodal;
            Exit;
          end;
        end
        else
        begin
          frmMensagem.Showmodal;
          Exit;
        end;
      End;
    Finally
      FreeAndNil(frmMensagem);
    End;

    {*******************************************}
    {* SE A DATA DE ENTRADA DIFERENTE DA DATA  *}
    {* DO DIA, ENTAO FAÇO A PERGUNTA.          *}
    {****************************************AC*}
    If StrToDate(mskDtaEnt.Text) <> VS_Date Then
    Begin
      If fMensagem('ATENÇÃO', 'A Data de Entrada é diferente da Data de Hoje.'#13#10'Deseja realmente continuar ?', ['&Sim', '&Não'], 2) = 2 Then
        Exit;
    End;

    If TEntradaValidacoes.fDataDeEntradaDeMesesAnteriores(mskDtaEnt.Text) Then
    Begin
      If Not TEntradaValidacoes.fLiberouDataDeEntradaDeMesesAnteriores(
        edtNumDoc.Text, edtCodFor.Text, edtNomFor.Text, mskDtaEnt.Text, mskDtaDoc.Text, edtTotGer.Text) Then
        Exit;
    End;

    btnCancelaItem.Click;

    If Not fCarregaNumPedCom Then
      Exit;

    If (Not blnForSta) And (Not blnDevolu) And (Not blnRecCliGarantia) And (Not blnConEqu) And (Not blnLocEqu) And (not FblnAcessadoViaRetornoConsignacao) Then
    Begin
      fMensagem('ATENÇÃO!', 'Fornecedor está Inativo!', ['&O k']);
      Exit;
    End;

    If Not fPedeCotacao Then
      Exit;

    If Not fVerificaVariacaoPrecosFinal Then
    Begin
      Exit;
    End;

    If (Not blnAltMai) And (Not fVerificaVariacaoQuantidadeFinal(qryEntMer, qryItePed)) Then
    Begin
      Exit;
    End;

    If Assigned(objEmbala) And (Not objEmbala.fVerificaEmbalagens(qryEntMer, qryItePed)) Then
      Exit;


    If blnDevolu And (Not fValidaPrecosDevolucao) Then
      Exit;

    {************************************************}
    {* CARREGA DADOS ADICIONAIS DO PEDIDO DE COMPRA *}
    {*********************************************PZ*}
    If (Not fEmptyStr(qryEntMer.FieldByName('ENT_NUMPED').AsString)) Then
      pCarregaDadosAdicPedido(edtCodFor.Text, qryEntMer.FieldByName('ENT_NUMPED').AsString);

    pAtualizaIpiOriginal;

    If SameText(edtEspDoc.Text, 'NF') Then
    Begin
      If blnTemAnt And (Not blnDevolu) And (Not blnForFil) Then
      Begin
        objAntIte := TIcmsAntecipado.Create(Self, strCodFor, strEstFor, blnGarantia, blnRecCliGarantia, fltAlqFor, blnConEqu Or blnLocEqu);
        Try
          If Not objAntIte.IsEmpty Then
          Begin
            pCriarFormularios(TfrmEntPedIcmsAntecipado, frmEntPedIcmsAntecipado);
            Try
              frmEntPedIcmsAntecipado.Height   := Self.Height;
              frmEntPedIcmsAntecipado.Width    := Self.Width;
              frmEntPedIcmsAntecipado.Top      := Self.Top;

              frmEntPedIcmsAntecipado.cdsItens := objAntIte;

              frmEntPedIcmsAntecipado.ShowModal;

              If Not frmEntPedIcmsAntecipado.blnConfirma Then
              Begin
                pFreeAndNil(frmEntPedIcmsAntecipado);
                Exit;
              End;

              pCalculaTotais;
            Finally
              pFreeAndNil(frmEntPedIcmsAntecipado);
            End;
          End;
        Finally
          FreeAndNil(objAntIte);
        End;
      End;

      Try
        fltPerPis := 0;
        fltPerCof := 0;
        fltBasPis := 0;
        fltBasCof := 0;
        fltTotPis := 0;
        fltTotCof := 0;

        if blnDevolu then
        Begin
          fltDesEsp := 0;
          fltValFre := 0;
          fltDesACe := 0;
        End;

        if blnRecCliGarantia then
          fltDesEsp := 0;

        strSitP_C := fDefineSit_P_C(VS_strCodEmp, strCodFor);

        With qryEntMer Do
        Begin
          First;

          blnCREIPI := fCfgSis('CREIPI', varBoolean);
          blnCLASUB := fRegimeSubstituicaoTributaria = '2';

          fltTotGPC := 0;
          While Not Eof Do
          Begin

            if blnCREIPI then
              fltValIpi := FieldByName('ENT_VALIPI').AsFloat
            else
              fltValIpi := 0;

            if blnCLASUB then
              fltValRet := FieldByName('ENT_VALRET').AsFloat
            else
              fltValRet := 0;

            tmp := TCalculoPisCofins.Create;
            Try
              CalcResult := tmp.fCalculoPisCofins(VS_strCodEmp,FieldByName('ENT_CODITE').AsString,
                                                        FieldByName('ENT_CLAFIS').AsString,
                                                        FieldByName('ENT_CODFIS').AsString,
                                                        strCodFor,IIf(fCfgSis('SIMPAU',varBoolean) and (fCfgSis('IGNSIM') = '1'), 'S', 'N'),
                                                        edtEspDoc.Text,FieldByName('ENT_TOTITE').AsFloat,
                                                        FieldByName('ENT_DESESP').AsFloat,fltValIpi,
                                                        fltValRet,FieldByName('ENT_VALFRE').AsFloat,
                                                        FieldByName('ENT_DESACE').AsFloat,
                                                        FieldByName('ENT_VALICM').AsFloat,
                                                        0,
                                                        IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu Or blnLocEqu Or FblnAcessadoViaRetornoConsignacao,'C','F'),
                                                        FieldByName('ENT_INCPIS').AsString,strSitP_C,'',
                                                        StrToDate(mskDtaEnt.Text),
                                                        '',
                                                        False,
                                                        False,
                                                        '',
                                                        '',
                                                        '',
                                                        '',
                                                        False,
                                                        FieldByName('ENT_SITXML').AsString,
                                                        FieldByName('ENT_ICMXML').ASFloat,
                                                        qryEntMer.FieldByName('ENT_CSTPIS').AsString,
                                                        qryEntMer.FieldByName('ENT_CSTCOF').AsString,
                                                        qryEntMer.FieldByName('ENT_VALPIS').AsFloat,
                                                        qryEntMer.FieldByName('ENT_VALCOF').AsFloat);
            Finally
              tmp.Destroy
            End;

            If Not CalcResult.blnResult Then
              Exit;

            If CalcResult.dblBasePis > 0 Then
            Begin
              fltPerPis := CalcResult.dblAlqPis;
              fltPerCof := CalcResult.dblAlqCof;
            End;

            fltBasPis := fltBasPis + CalcResult.dblBasePis;
            fltBasCof := fltBasCof + CalcResult.dblBaseCof;
            fltTotPis := fltTotPis + CalcResult.dblValorPis;
            fltTotCof := fltTotCof + CalcResult.dblValorCof;

            if blnDevolu then
            Begin
              fltDesEsp := fltDesEsp + FieldByName('ENT_DESUNI').AsFloat * FieldByName('ENT_QTDITE').AsFloat;
              fltValFre := fltValFre + FieldByName('ENT_VALFRE').AsFloat;
              fltDesAce := fltDesAce + FieldByName('ENT_DESACE').AsFloat;
            End;

            if blnRecCliGarantia then
              fltDesEsp := fltDesEsp + FieldByName('ENT_DESESP').AsFloat * FieldByName('ENT_QTDITE').AsFloat;

            Next;
          End;
        End;


        TEntTestaCFOPS.fVerificaCFOPS(False);
        qryEntMer.EnableControls;
        pCriarFormularios(TfrmEntDadosFiscais, frmEntDadosFiscais);
        frmEntDadosFiscais.blnZeraIcmsDevolucao := fEmptyStr(strDocSel);
          frmEntDadosFiscais.objExcecaoCfopCst := objExcecaoCfopCst;
          frmEntDadosFiscais.blnManterIpi   := blnManterIpi;
          frmEntDadosFiscais.fltCotDol      := fltCotDol;
          frmEntDadosFiscais.blnPresencial  := ((qryEntMer.FieldByName('ENT_INDPRES').AsInteger = 1) Or (qryEntMer.FieldByName('ENT_IDDEST').AsInteger = 1) Or (blnPresencial));
          frmEntDadosFiscais.blnPrecoPraticado := blnPrecoPraticado;
          frmEntDadosFiscais.blnZonFra      := blnZonFra;
          frmEntDadosFiscais.blnGarantia    := blnGarantia;
        frmEntDadosFiscais.strAutDev      := strAutDev;
        frmEntDadosFiscais.objEmbala      := objEmbala;
        frmEntDadosFiscais.blnSimPau      := blnSimPau;
        frmEntDadosFiscais.blnCarPro      := blnCarregProd;
        frmEntDadosFiscais.blnRecCliGarantia := blnRecCliGarantia;
        frmEntDadosFiscais.recNotEle      := recNotEle;
        frmEntDadosFiscais.blnTravarFinanceiroEstaDuplicado := blnTravarFinanceiroEstaDuplicado;
        frmEntDadosFiscais.strCodCta      := strCodCta;
        frmEntDadosFiscais.strOrdIte      := strOrdIte;
          frmEntDadosFiscais.edtTotIte.Text := edtTotal.Text;
          frmEntDadosFiscais.fltTotOri      := fStrToFloat( Trim( edtTotal.Text ) );
          frmEntDadosFiscais.strMatRev      := strMatRev;
          frmEntDadosFiscais.PerfilDespachanteAduaneiro := PerfilDespachanteAduaneiro;

          if blnRecCliGarantia then
          begin
          frmEntDadosFiscais.fltDesEspRecCliGarantia := fltDesEsp;
          frmEntDadosFiscais.fltTotOri := frmEntDadosFiscais.fltTotOri + fltDesEsp;
          frmEntDadosFiscais.edtTotIte.Text := FloatToStrF((frmEntDadosFiscais.fltTotOri), ffFixed, 12, 2);
        end;

        frmEntDadosFiscais.edtTotLiq.Text := FloatToStrF((frmEntDadosFiscais.fltTotOri - fltDesEsp), ffFixed, 12, 2);


        frmEntDadosFiscais.edtTotIpi.Text := edtTotIpi.Text;
        frmEntDadosFiscais.fltTotIpi      := fStrToFloat( Trim( edtTotIpi.Text ) );

          frmEntDadosFiscais.edtTotRet.Text := edtTotSub.Text;
          frmEntDadosFiscais.fltRetIte      := fStrToFloat( Trim( edtTotSub.Text ) );

        frmEntDadosFiscais.edtTotAnt.Text := edtTotAnt.Text;
        frmEntDadosFiscais.fltTotAnt      := fStrToFloat( Trim( edtTotAnt.Text ) );

        frmEntDadosFiscais.edtValFre.Text := FloatToStrF(fltValFre, ffFixed, 12, 2);
        frmEntDadosFiscais.strFreOri      := frmEntDadosFiscais.edtValFre.Text;
        frmEntDadosFiscais.fltValFre      := fltValFre;
        frmEntDadosFiscais.edtDesAce.Text := FloatToStrF(fltDesAce, ffFixed, 12, 2);
        frmEntDadosFiscais.fltDesAce      := fltDesAce;
        frmEntDadosFiscais.edtDesEsp.Text := FloatToStrF(fltDesEsp, ffFixed, 12, 2);

        frmEntDadosFiscais.edtAlqPis.Text := FloatToStrF(fltPerPis, ffFixed, 12, 2);
        frmEntDadosFiscais.edtAlqCof.Text := FloatToStrF(fltPerCof, ffFixed, 12, 2);
        frmEntDadosFiscais.edtBasPis.Text := FloatToStrF(fltBasPis, ffFixed, 12, 2);
        frmEntDadosFiscais.edtBasCof.Text := FloatToStrF(fltBasCof, ffFixed, 12, 2);
        frmEntDadosFiscais.edtTotPis.Text := FloatToStrF(fltTotPis, ffFixed, 12, 2);
        frmEntDadosFiscais.edtTotCof.Text := FloatToStrF(fltTotCof, ffFixed, 12, 2);

        {*******************************************}
        {* DADOS QUE SERAO REPASSADOS PARA O LIVRO *}
        {****************************************MV*}
        frmEntDadosFiscais.strNumDoc := edtNumDoc.Text;
        frmEntDadosFiscais.strSerie  := edtSerie.Text;
        frmEntDadosFiscais.strEspDoc := edtEspDoc.Text;
        frmEntDadosFiscais.strCodFor := edtCodFor.Text;
        frmEntDadosFiscais.strCodRep := strCodRep;
        frmEntDadosFiscais.strCodVen := strCodVen;
        frmEntDadosFiscais.dtaDtaDoc := StrToDate(mskDtaDoc.Text);
        frmEntDadosFiscais.dtaDtaent := StrToDate(mskDtaEnt.Text);

        frmEntDadosFiscais.strEstFor := strEstFor;
        frmEntDadosFiscais.strCodFaz := strCodFaz;
        frmEntDadosFiscais.fltTotRetOri := fStrToFloat( Trim( edtTotSub.Text ) );
        frmEntDadosFiscais.blnPedFilialGarantia := blnPedFilialGarantia;
        frmEntDadosFiscais.blnAutomatico := blnAutomatico;
        If (blnDevolu) Or (blnRecCliGarantia) Or (blnConEqu) Or (blnLocEqu) or (FblnAcessadoViaRetornoConsignacao) Then
        Begin
          pCarregaCliente(edtCodFor.Text);
          frmEntDadosFiscais.arrClienteConsumidor := arrClienteConsumidor;
        frmEntDadosFiscais.strIesFor            := Self.strIesFor;
        frmEntDadosFiscais.strTipFor            := '';
        frmEntDadosFiscais.strCgcCpf            := Self.strCgcCpf;
        frmEntDadosFiscais.strTipCgcCpf         := Self.strTipCgcCpf
      End
      Else
      Begin
          //pCarregaFornecedor;
        frmEntDadosFiscais.strIesFor := Self.strIesFor;
        frmEntDadosFiscais.strTipFor := Self.strTipFor;
        frmEntDadosFiscais.strCgcCpf := Self.strCgcCpf;
        frmEntDadosFiscais.strTipCgcCpf := Self.strTipCgcCpf
      End;

      If blnDevolu And fCfgSis('DVVORI', varBoolean) Then
          strConPag := fCondicaoPagamentoDevolucao;

        frmEntDadosFiscais.fltAlqFor := fltAlqFor;
        frmEntDadosFiscais.blnDevolu := blnDevolu;
        frmEntDadosFiscais.strPedDev := strPedDev;
        frmEntDadosFiscais.qryEntMer := qryEntMer;
        frmEntDadosFiscais.stlPedidos:= stlPedidos;
        If fEmptyStr(strConPag) then
          frmEntDadosFiscais.strConpag := strPagFor
        Else
          frmEntDadosFiscais.strConpag := strConPag;
        frmEntDadosFiscais.strCodEve := strCodEve;
        frmEntDadosFiscais.blnNotaImp:= blnNotaImp;
        frmEntDadosFiscais.blnEncargosNoFrete := blnEncargosNoFrete;
        frmEntDadosFiscais.blnConEqu := blnConEqu;
        frmEntDadosFiscais.blnLocEqu := blnLocEqu;
        frmEntDadosFiscais.blnFornJaAtualizado:= blnFornJaAtualizado;
        frmEntDadosFiscais.arrDocOri := arrDocOri;
          frmEntDadosFiscais.cdsMovGad := cdsMovGad;
          frmEntDadosFiscais.strDocSel := strDocSel;
          frmEntDadosFiscais.blnFulfillment := blnFulfillment;
      
      frmEntDadosFiscais.onBeforeConfirmaEntrada := onBeforeConfirmaEntrada;
      frmEntDadosFiscais.onAfterConfirmaEntrada  := onAfterConfirmaEntrada;
      frmEntDadosFiscais.fAoConfirmarEntrada := fAoConfirmarEntrada;
      frmEntDadosFiscais.arrDuplicata := @Self.arrDuplicata;

      if FblnAcessadoViaRetornoConsignacao then
          Begin
            frmEntDadosFiscais.blnAcessadoViaRetornoConsignacao := FblnAcessadoViaRetornoConsignacao;
            frmEntDadosFiscais.TipoRetornoConsignacao           := FTipoRetornoConsignacao;
        End;

        (*If {(blnGarantia) Or }(blnRecCliGarantia) Then
        Begin
          frmEntDadosFiscais.FormShow(Nil);
          frmEntDadosFiscais.btnConfirma.Enabled := True;
          frmEntDadosFiscais.btnConfirma.Click;
          qryEntMer.AfterScroll := pAtualizaDados;
        End
        Else *)
        If blnAutomatico Then
        Begin
          frmEntDadosFiscais.pShow;
          frmEntDadosFiscais.btnCalculaImpostos.Click;
          frmEntDadosFiscais.btnConfirma.Click;
          blnConfirma := frmEntDadosFiscais.blnConfirma;
          {* Req. 455181 - este Exit sai antes do pFreeAndNil no fim do    *}
          {* metodo; sem liberar aqui o form sobrevive pertencendo a       *}
          {* Application, com ponteiro pendurado para @Self.arrDuplicata.  *}
          pFreeAndNil(frmEntDadosFiscais);
          Close;
          Exit;
        End
        Else
        Begin
          frmEntDadosFiscais.ShowModal;

          if (FblnAcessadoViaRetornoConsignacao) and (FTipoRetornoConsignacao = ttrImportacaoXML) then
          Begin
            blnConfirma := frmEntDadosFiscais.blnConfirma;
            {* Req. 455181 - mesmo caso do Exit acima. *}
            pFreeAndNil(frmEntDadosFiscais);
            Close;
            Exit;
          End;

        End;

        blnConfirma := frmEntDadosFiscais.blnConfirma;
        qryEntMer.DisableControls;
        If blnConfirma Then
        Begin
          strSeqGer   := frmEntDadosFiscais.strSeqGer;
          fltValFre   := frmEntDadosFiscais.fltValFre;
          fltDesAce   := frmEntDadosFiscais.fltDesAce;
          fltDesEsp   := frmEntDadosFiscais.fltDesEsp;
          //fltValRet   := frmEntDadosFiscais.fltTotRet; Valor não utilizado
          fltValAnt   := frmEntDadosFiscais.fltTotAnt;
          strVeiBol   := frmEntDadosFiscais.strVeiBol;
          strDeposi   := frmEntDadosFiscais.strDeposi;
          strBcoFor   := frmEntDadosFiscais.strBcoFor;
          strChaNFe   := frmEntDadosFiscais.strChaNFe;
        End
        Else
        Begin
          qryEntMer.AfterScroll := pAtualizaDados;
          pCarregaItensAlteracao(True);
          If fItemCarregadoParaVisualizacao Then
          begin
            pCarregaItensAlteracao;
            edtDesIte.SelectAll;
          End;

        End;

      Except
        On E: Exception Do
        Begin
          blnConfirma := False;
          pMensagensErro(E.Message, '[frmEntMercadorias.btnConfirmaClick]');
        End;
      End;

      pFreeAndNil(frmEntDadosFiscais);
    End
    Else
    Begin

      If (fCfgSis('ENTCTP', varBoolean)) Then
      Begin

        Try
          qryEntMer.EnableControls;
          pCriarFormularios(TfrmEntDadosCaixa2, frmEntDadosCaixa2);
          frmEntDadosCaixa2.onBeforeConfirmaEntrada := onBeforeConfirmaEntrada;
          frmEntDadosCaixa2.onAfterConfirmaEntrada  := onAfterConfirmaEntrada;
          frmEntDadosCaixa2.arrDuplicata := @Self.arrDuplicata;
          frmEntDadosCaixa2.blnEncargosNoFrete := blnEncargosNoFrete;
          frmEntDadosCaixa2.blnTravarFinanceiroEstaDuplicado := blnTravarFinanceiroEstaDuplicado;
          frmEntDadosCaixa2.objExcecaoCfopCst := objExcecaoCfopCst;
          frmEntDadosCaixa2.fltCotDol      := fltCotDol;
          frmEntDadosCaixa2.blnPrecoPraticado := blnPrecoPraticado;
          frmEntDadosCaixa2.blnGarantia    := blnGarantia;
          frmEntDadosCaixa2.strAutDev      := strAutDev;
          frmEntDadosCaixa2.objEmbala      := objEmbala;
          frmEntDadosCaixa2.blnCarPro      := blnCarregProd;
          frmEntDadosCaixa2.recNotEle      := recNotEle;
          frmEntDadosCaixa2.fraPlanoDeContas.MskCodCta.Text := strCodCta;
          frmEntDadosCaixa2.strOrdIte      := strOrdIte;
          frmEntDadosCaixa2.edtTotIte.Text := edtTotal.Text;
          frmEntDadosCaixa2.edtValFre.Text := FloatToStrF(fltValFre, ffFixed, 12, 2);
          frmEntDadosCaixa2.edtDesAce.Text := FloatToStrF(fltDesAce, ffFixed, 12, 2);
          frmEntDadosCaixa2.strPedDev      := strPedDev;
          frmEntDadosCaixa2.blnRecCliGarantia := blnRecCliGarantia;
          frmEntDadosCaixa2.cdsMovGad      := cdsMovGad;

          frmEntDadosCaixa2.strNumDoc      := edtNumDoc.Text;
          frmEntDadosCaixa2.strEspDoc      := edtEspDoc.Text;
          frmEntDadosCaixa2.dtaDtaEnt      := StrToDate(mskDtaEnt.Text);
          frmEntDadosCaixa2.dtaDtaDoc      := StrToDate(mskDtaDoc.Text);
          frmEntDadosCaixa2.strSerie       := edtSerie.Text;
          frmEntDadosCaixa2.strCodFor      := edtCodFor.Text;

          frmEntDadosCaixa2.strEstFor      := strEstFor;
          frmEntDadosCaixa2.strCodFaz      := strCodFaz;
          frmEntDadosCaixa2.fltAlqFor      := fltAlqFor;
          frmEntDadosCaixa2.blnDevolu      := blnDevolu;
          frmEntDadosCaixa2.blnConEqu      := blnConEqu;
          frmEntDadosCaixa2.blnLocEqu      := blnLocEqu;

          frmEntDadosCaixa2.intNumIte      := dbgItens.DataController.DataSource.DataSet.RecordCount;

          frmEntDadosCaixa2.edtCodRep.Text := strCodRep;
          frmEntDadosCaixa2.blnManterCFOPBonificao := (edtEspDoc.Text = 'PD') and blnBonificacao;

         If blnDevolu And fCfgSis('DVVORI', varBoolean) Then
            strConPag := fCondicaoPagamentoDevolucao;

          frmEntDadosCaixa2.stlPedidos  := stlPedidos;
          If fEmptyStr(strConPag) then
            frmEntDadosCaixa2.strConpag := strPagFor
          Else
            frmEntDadosCaixa2.strConpag   := strConPag;
          frmEntDadosCaixa2.qryEntMer   := qryEntMer;

          If (Not fEmptyStr(strCodEve)) Then
          Begin
            frmEntDadosCaixa2.fraCentroCusto.edtCodEve.Text := strCodEve;
            frmEntDadosCaixa2.fraCentroCusto.edtDesEve.Text := fRetNomEvento(strCodEve);
          End;

          If (Not fEmptyStr(strCodCcu)) Then
          Begin
            frmEntDadosCaixa2.fraPlanoDeContas.MskCodCta.Text := strCodCcu;
            frmEntDadosCaixa2.fraPlanoDeContas.edtDesCta.Text := fRetDescCentroCusto(strCodCcu);
          End;

          frmEntDadosCaixa2.fEntPedidoPorGarantia := Nil;
          If (blnDevolu) Or (blnConEqu) Or (blnLocEqu) Then
            pCarregaCliente(edtCodFor.Text)
          Else begin
            pCarregaFornecedor;
            if (edtEspDoc.Text = 'PD') then
              frmEntDadosCaixa2.fEntPedidoPorGarantia := Self.fValidarEntradaGarantia;
          end;

          frmEntDadosCaixa2.blnPedFilialGarantia := blnPedFilialGarantia;

          frmEntDadosCaixa2.showModal;
          blnConfirma := frmEntDadosCaixa2.blnConfirma;
          qryEntMer.DisableControls;
          If blnConfirma Then
          Begin
            fltValFre := 0.0;
            fltDesAce := 0.0;

            If Not fEmptyStr(frmEntDadosCaixa2.edtValFre.Text) Then
              fltValFre := fStrToFloat(frmEntDadosCaixa2.edtValFre.Text);

            If Not fEmptyStr(frmEntDadosCaixa2.edtDesAce.Text) Then
              fltDesAce := fStrToFloat(frmEntDadosCaixa2.edtDesAce.Text);
          End;

        Except
          On E: Exception Do
          Begin
            blnConfirma := False;
            pMensagensErro(E.Message, '[frmEntMercadorias.btnConfirmaClick_1]');
          End;
        End;

        pFreeAndNil(frmEntDadosCaixa2);

      End
      Else
      Begin
        qryEntMer.DisableControls;
        blnConfirma := False;

        If fMensagem('', 'Confirma gravação?', ['&Sim', '&Não']) = 1 Then
        Begin

          blnConfirma := True;

          If (Not blnDevolu) And (Not blnForFil) Then
            objDefBaixa := TDefineBaixaPedido.Create(Self);

          pnlInfo.Caption := 'Aguarde, calculando impostos...';
          Application.ProcessMessages;

          With qryGenMer Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(' UPDATE TMP_ENTMER SET ');
            SQL.Add('   ENT_DESACE = :DESACE, ');
            SQL.Add('   ENT_VALFRE = :VALFRE  ');
            ParamByName('DESACE').AsFloat := 0;
            ParamByName('VALFRE').AsFloat := 0;
            ExecSQL;
            Close;
          End;
          Try
            pRateiaImpostos(qryEntMer,
                            recNotEle.finalidadeXML,
                            objExcecaoCfopCst,
                            fStrToFloat(edtTotal.Text),
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            fRetornaTotIteRet,
                            pgbCalculoFiscal,
                            fltAlqFor,
                            strEstFor,
                            strCodFor,
                            strTipFor,
                            0.0,
                            0,
                            blnDevolu,
                            False,
                            PerfilDespachanteAduaneiro,
                            '',
                            0,
                            True,
                            '',
                            False,
                            '',
                            False,
                            False,
                            False,
                            False,
                            'NF',
                            blnConEqu or blnLocEqu,
                            False,
                            trfPropValorItem,
                            False,
                            False,
                            False,
                            False,
                            False,
                            blnManterIpi);

          Except



            On E: Exception Do
            Begin
              pMensagensErro(E.Message,'[TfrmEntMercadorias.btnConfirmaClick]');
              pnlInfo.Caption := '';
              Exit;
            End;
          End;


          pnlInfo.Caption := 'Aguarde, confirmando Itens...';
          Application.ProcessMessages;

          If (Not blnDevolu) And (Not blnForFil) Then
            oleItensPedidos := fDefinePedidosABaixar(blnBaiPed, qryEntMer, stlPedidos, recNotEle.strAutInc, False, False, objDefBaixa)
          Else
            oleItensPedidos := fDefinePedidosABaixar(blnBaiPed, qryEntMer, stlPedidos, recNotEle.strAutInc);

          If Not blnBaiPed then
          Begin
            pnlInfo.Caption := '';
            Application.ProcessMessages;
            Exit;
          End;

          intCtpCon := fRetCtpCon;

          objAuditoriaSaldo.Limpar;

          fStartTransaction;
          fillchar(arrLinDigCodbar,sizeof(arrLinDigCodbar),#0);

          blnResult := fConfirmaEntradaMercadorias(strSeqGer,
                                         strListaItens,
                                         ArrCteMov,
                                         blnGravouMovDet,
                                         blnGerouLotDePreco,
                                         strMatRev,
                                         blnNotaImp,
                                         Nil,
                                         TDefineBaixaPedido(IIF(((Not blnDevolu) And (Not blnForFil)) , objDefBaixa, Nil)),
                                         arrLinDigCodbar,
                                         1,
                                         0,
                                         '',          {Vendedor}
                                         '',
                                         '',
                                         '',
                                         edtCodFor.Text,
                                         strCodFaz,
                                         edtNumDoc.Text,
                                         edtEspDoc.Text,
                                         StrToDate(mskDtaEnt.Text),
                                         StrToDate(mskDtaDoc.Text),
                                         0,
                                         edtSerie.Text,
                                         strEstFor,
                                         strVeiBol,
                                         strDeposi,
                                         recNotEle.strEspVol,
                                         recNotEle.fltQtdVol,
                                         fltAlqFor,
                                         pgbCalculoFiscal,
                                         '',
                                         blnDevolu,
                                         '',           {digitador}
                                         '',           {representante DET_CODREP}
                                         True,
                                         True,
                                         '',
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         '',
                                         oleItensPedidos,
                                         strOrdIte,
                                         Self.Name,
                                         blnCarregProd,
                                         recNotEle.strAutInc,
                                         '',
                                         '',
                                         strMotDev,
                                         qryEntMer,
                                         Nil,
                                         Nil,
                                         Nil,
                                         strAutIncCadFis,
                                         arrDuplicata,
                                         objEmbala,
                                         Nil,
                                         '',
                                         0,
                                         '',
                                         intCtpCon,
                                         strAutIncMovGer,
                                         0,
                                         0,
                                         '',
                                         0,
                                         0,
                                         False,
                                         False,
                                         Nil,
                                         Nil,
                                         False,
                                         False,
                                         False,
                                         False,
                                         False,
                                         Nil,
                                         False,
                                         strBcoFor,
                                         '',
                                         nil,
                                         '',
                                         nil,
                                         onBeforeConfirmaEntrada,
                                         onAfterConfirmaEntrada,
                                         xmlEntradaMercadoria,
                                         Nil,
                                         False,
                                         ttrImportacaoXML,
                                         '',
                                         '',
                                         False,
                                         nil,
                                         '',
                                         False,
                                         tcCFOPNormal,
                                         blnFornJaAtualizado);

          If blnResult Then
          Begin
            objAuditoriaSaldo.Adicionar(strAutIncMovGer, 'MOVGER');

            If (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
            Begin
              blnResult := False;
              fRollBack;
              pMostraErrosAuditoria(strCodErrosAuditoria);
            End;
          End;

          If blnResult Then
          Begin
            Close;
            fCommit;

            If fVerificaAcessoSistema('frmLotePrecosEfetivacao') And
               fCfgSis('ENTEFE', varBoolean) And
               blnGerouLotDePreco Then
            Begin
              pCriarFormularios(TfrmLotePrecosEfetivacaoCx, frmLotePrecosEfetivacaoCx);
              Try
                frmLotePrecosEfetivacaoCx.pSetDocumentoDeEntradaLotePreco(edtNumDoc.Text,
                                                                          edtEspDoc.Text,
                                                                          edtSerie.Text,
                                                                          strCodFor,
                                                                          '',
                                                                          fltCotDol);
                frmLotePrecosEfetivacaoCx.ShowModal;
              Finally
                FreeAndNil(frmLotePrecosEfetivacaoCx);
              End;
            End;

          End
          Else
          Begin
            fRollBack;
            pnlInfo.Caption := '';
            Application.ProcessMessages;
          End;

        End;

      End;

    End;

    intColAtu := 1;

    FNumDoc := edtNumDoc.Text + '-' + edtEspDoc.Text;

    If fCfgSis('FPCETI', varBoolean) And (Not blnDevolu) And blnConfirma Then
    Begin
      pImprimeFichaProdutos;

      strEtiPCT := fCfgSis('ETIPCT');

      If strEtiPCT <> 'M' Then
        TfrmEntEtiquetas.pImpEtiEntradaMercadorias(edtNumDoc.Text, edtEspDoc.Text, edtCodFor.Text, edtSerie.Text, True)
      Else
        pImpEtiquetaMatricial;
    End;

    pAtribuiTabelas;

    If blnConfirma Then
    Begin
      If blnConEqu Then
      Begin
        FMeqMer := TMeqMer.Create;
        FMeqMer.strAutGer := strSeqGer;
        FMeqMer.strNumDoc := edtNumDoc.Text;
        FMeqMer.strEspDoc := edtEspDoc.Text;
        FMeqMer.strEmpGer := VS_strCodEmp;
        FMeqMer.strSerie_ := edtSerie.Text;
        FMeqMer.strCodCli := edtCodFor.Text;
        FMeqMer.strTipOpe := 'E';
        FMeqMer.dtaDtaGer := StrToDateDef(mskDtaEnt.Text, -1);
        FMeqMer.strChaveAcesso := strChaNFe;
      End;

      Close;
    End;

    If blnDevolu Or blnRecCliGarantia Or blnConEqu Or blnLocEqu or FblnAcessadoViaRetornoConsignacao Then
      pCarregaCliente(edtCodFor.Text);
  //  Else
     // pCarregaFornecedor;

    pAtualizaTabela;
    pCalculaTotais;
  Finally
    qryEntMer.EnableControls;
    pSetFocus(edtCodIte);

    FreeAndNil(qryGenMer);
  End;

end;

procedure TfrmEntMercadorias.dbgItensCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  dbgItensColumALTITEM.Index]) = 'S' Then
  Begin
    ACanvas.Brush.Color := clYellow;
    ACanvas.Font.Color := clBlue;
  End
  Else
  Begin
    ACanvas.Brush.Color := clWhite;
    ACanvas.Font.Color := clBlack;
  End;

end;

procedure TfrmEntMercadorias.dbgItensDblClick(Sender: TObject);
  Var
    Key: Word;
    Shift: TShiftState;
begin
  inherited;
  Key := VK_Return;
  dbgItensKeyDown(Sender, Key, Shift);
end;

procedure TfrmEntMercadorias.dbgItensEditKeyDown(Sender: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_RETURN Then
  Begin
    If (edtEspDoc.Text = 'PD') Then
    Begin
      If (dbgItensColumQuant.Editing Or dbgItensColumValUnit.Editing Or dbgItensColumValorTotal.Editing) Then
      Begin

        If dbgItensColumQuant.Focused Then // Quantidade
        Begin

          dbgItensColumValUnit.Focused:= True;
          dbgItensColumValUnit.Editing:= True;
          edtQtdIte.Text:= dbgItensColumQuant.DataBinding.Field.Value;

          If Not(dbgItens.DataController.DataSource.DataSet.State in ([DsEdit])) Then
            dbgItens.DataController.DataSource.DataSet.Edit;
          dbgItens.DataController.DataSource.DataSet.FieldByName('ENT_ALTITEM').AsString:= 'S';

          dbgItens.DataController.DataSource.DataSet.FieldByName('ENT_TOTITE').AsCurrency:=
          (dbgItensColumQuant.DataBinding.Field.Value *
          dbgItensColumValUnit.DataBinding.Field.Value);

          dbgItens.DataController.DataSource.DataSet.Post;

        End

        Else

        If dbgItensColumValUnit.Focused Then // Unitario
        Begin

          dbgItensColumValorTotal.Focused:= True;
          dbgItensColumValorTotal.Editing:= True;
          edtUnitar.Text:= dbgItensColumValUnit.DataBinding.Field.Value;

          If Not(dbgItens.DataController.DataSource.DataSet.State in ([DsEdit])) Then
            dbgItens.DataController.DataSource.DataSet.Edit;

          dbgItens.DataController.DataSource.DataSet.FieldByName('ENT_TOTITE').AsFloat:=
                                               dbgItensColumQuant.DataBinding.Field.Value *
                                               dbgItensColumValUnit.DataBinding.Field.Value;

          dbgItens.DataController.DataSource.DataSet.FieldByName('ENT_ALTITEM').AsString:= 'S';
          dbgItens.DataController.DataSource.DataSet.Post;

        End

        Else

        If dbgItensColumValorTotal.Focused Then // Total
        Begin

          dbgItensColumQuant.Focused:= True;
          dbgItensColumQuant.Editing:= True;
          edtTotIte.Text:= dbgItensColumValorTotal.DataBinding.Field.Value;

          If Not(dbgItens.DataController.DataSource.DataSet.State in ([DsEdit])) Then
            dbgItens.DataController.DataSource.DataSet.Edit;
          dbgItens.DataController.DataSource.DataSet.FieldByName('ENT_ALTITEM').AsString:= 'S';
          dbgItens.DataController.DataSource.DataSet.Post;

        End;

        edtQtdIteExit(edtQtdIte);
        edtUnitarExit(edtUnitar);
        edtTotIteExit(edtTotIte);

        btnAdicionar.Tag := dbgItens.DataController.DataSource.DataSet.FieldByName('AUTOINCREM').AsInteger;
        btnAdicionarClick(Nil);
        btnAdicionar.Tag := 0;
      End;
    End;
  End;
end;

procedure TfrmEntMercadorias.dbgItensGridEnter(Sender: TObject);
begin
  inherited;
  btnApaga.Visible := fEmptyStr(recNotEle.strAutInc);
  If Not blnAdicionando Then
   pCarregaItensVis;
end;

procedure TfrmEntMercadorias.dbgItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var
    intRecNo: Integer;
    nItem: Integer;
    lAfterScrollEntMer: TDataSetNotifyEvent;
    strNextCodIte: String;
begin
  inherited;

  If (Key = VK_Escape) Then
  Begin
    If blnDocOri Then
      pEscapePressed;

    If (Not edtCodIte.Enabled) And (Not blnSemInc) Then
      edtCodIte.Enabled := True;

    pSetFocus(edtCodIte);

    If Not fEmptyStr(recNotEle.strAutInc) Then
      btnCancelarEntrada.Click;
  End
  Else If (Key = VK_Return) Then
  Begin
    If (blnConEqu) Or (blnLocEqu) And (Not fEmptyStr(recNotEle.strAutInc)) Then Begin
      fMensagem('ATENÇÃO!', 'Entrada de remessa de equipamento realizada via XML da NF-e não permite alteração dos itens!', ['&OK']);
      Exit;
    End;

    pCarregaItensAlteracao;

  End
  Else If (Key = VK_Delete) And fEmptyStr(recNotEle.strAutInc) Then
  Begin
    If (blnConEqu) or (blnLocEqu) And (Not fEmptyStr(recNotEle.strAutInc)) Then Begin
      fMensagem('ATENÇÃO!', 'Entrada de remessa de equipamento realizada via XML da NF-e não permite exclusão de itens!', ['&OK']);
      Exit;
    End;

    if fEhRetornoGarantiaFornecedorInterno(blnGarantia) then
    begin
      fMensagem('ATENÇÃO!', 'Entrada de retorno do fornecedor não permite exclusão de itens!', ['&OK']);
      Exit;
    end;

    If (Not blnGarantia) Or (Not blnRecCliGarantia) or (not FblnAcessadoViaRetornoConsignacao) Then
    Begin
      If Not qryEntMer.Active Then
      Begin

        pSetFocus(edtCodIte);

        Exit;
      End;

      lAfterScrollEntMer := qryEntMer.AfterScroll;

      Try
        qryEntMer.DisableControls;

        intRecNo := qryEntMer.RecNo;

        dbgItens.NavigatorButtons.Next.Click;
        strNextCodIte := qryEntMer.FieldByName('ENT_CODITE').AsString;

        qryEntMer.RecNo := intRecNo;

        nItem := qryEntMer.FieldByName('ENT_N_ITEM_TELA').AsInteger;

        pDeletaItem(nItem);


        pAtualizaTabela;
        qryEntMer.AfterScroll := Nil;


      Finally
        qryEntMer.Locate('ENT_CODITE', strNextCodIte, []);
        pAtualizaDados(qryEntMer);
        qryEntMer.EnableControls;
        qryEntMer.AfterScroll := lAfterScrollEntMer;
      End;


    End
    Else
      fMensagem('ATENÇÃO!', 'Exclusão não permitida!', ['&O k']);

  End;
end;

function TfrmEntMercadorias.fValidaCabecalho: Boolean;
  Var
    intContador: Integer;
begin
  Result := True;
  For intContador := 0 To pnlCabecalho.ControlCount -1 Do
  Begin

    If pnlCabecalho.Controls[intContador].Tag = 99 Then
    Begin

      Result := fValidaCampos(TWinControl(pnlCabecalho.Controls[intContador]), False);

      If Not Result Then
      Begin

        If (pnlCabecalho.Controls[intContador] Is TEditFocus) Then
        Begin
          If (pnlCabecalho.Controls[intContador] As TEditFocus).CanFocus Then
            pSetFocus((pnlCabecalho.Controls[intContador] As TEditFocus));
        End

        Else If (pnlCabecalho.Controls[intContador] Is TMaskEditFocus) Then
        Begin
          If (pnlCabecalho.Controls[intContador] As TMaskEditFocus).CanFocus Then
            pSetFocus((pnlCabecalho.Controls[intContador] As TMaskEditFocus));
        End;

        blnMudarFoco := False;
        Break;
      End;

    End;

  End;
end;

Function TfrmEntMercadorias.fValidaRegitrosXML: Boolean;
  Var
    qryDetEle: TUniQuery;
    frmItensInconsistentesEntrada: TfrmItensInconsistentesEntrada;
    cdsDetEle: TZClient;
Begin
  Result := True;

  qryDetEle := fCriaQuery;
  qryDetEle.SQL.Text := 'SELECT COUNT(*) AS QTDITE FROM DETELE WHERE DET_SEQGER = ' + QuotedStr(recNotEle.strAutInc);
  qryDetEle.Open;

  If qryDetEle.FieldByName('QTDITE').AsInteger > qryEntMer.RecordCount Then
  Begin
    Result := False;

    cdsDetEle := TZClient.Create(Nil,
                                 ' SELECT D.AUTOINCREM, D.DET_CODITE, ITE_DESITE FROM DETELE D ' +
                                 ' LEFT JOIN CADITE ON ITE_CODITE = D.DET_CODITE ' +
                                 ' WHERE D.DET_SEQGER = ' + QuotedStr(recNotEle.strAutInc));

    cdsDetEle.fLeDados('TfrmEntMercadorias.fValidaRegitrosXML', True, 'Carregando xml...');

    While Not cdsDetEle.Eof Do
    Begin
      If qryEntMer.Locate('ENT_AUTELE',cdsDetEle.FieldByName('AUTOINCREM').AsString, []) Then
        cdsDetEle.Delete
      Else
        cdsDetEle.Next;
    End;

    pCriarFormularios(TfrmItensInconsistentesEntrada, frmItensInconsistentesEntrada);
    frmItensInconsistentesEntrada.cxvItens.DataController.DataSource := cdsDetEle.dtsSource;
    frmItensInconsistentesEntrada.ShowModal;
    FreeAndNil(frmItensInconsistentesEntrada);

    FreeAndNil(cdsDetEle);

  End;

  qryDetEle.Close;
  FreeAndNil(qryDetEle);
End;

function TfrmEntMercadorias.fValidarEntradaGarantia: Boolean;
begin
  Result := False;

  if pos(strClaFis, strCLARGR) > 0 then
    exit(True);

  if  (fLiberarEntradaGarantia = False) then
    Exit;

  pSetClaFisEntPorGarantia;
  frmFatDigDadosGarantia := Nil;
  Try
    pCriarFormularios(TfrmFatDigDadosGarantia, frmFatDigDadosGarantia);
    frmFatDigDadosGarantia.edtClaFis.Enabled := True;
    frmFatDigDadosGarantia.edtDesCla.Enabled := True;
    frmFatDigDadosGarantia.strOpcDoc := 'GR';
    frmFatDigDadosGarantia.blnEntPedGarantia := True;
    frmFatDigDadosGarantia.blnOperacaoInterEstadual := SameText(strEstFor, fCadEmp('ESTADO')) = false;
    frmFatDigDadosGarantia.ShowModal;
    Result := frmFatDigDadosGarantia.ModalResult = mrOk;

    if Not Result then
      Exit;

    pSetClaFisEntPorGarantia(frmFatDigDadosGarantia.edtClaFis.Text);
  Finally
    if Assigned(frmFatDigDadosGarantia) then
      FreeAndNil(frmFatDigDadosGarantia);
  end;
  strClaFis := FClaFisEntPorGarantia;
  pAtuTabelaGrid;
end;

procedure TfrmEntMercadorias.pAtuTabelaGrid;
  var blnProcessou: boolean;
      qryConsulta: TUnIQuery;
begin
  If fTabelaExiste('TMP_ENTMER') Then
  Begin
    if blnGarantia And blnObterConfirmacaoIpi And Self.Showing then
    begin
      qryConsulta := fCriaQuery;
      try
        qryConsulta.SQL.Clear;
        qryConsulta.SQL.Add('SELECT ENT_VALIPI FROM TMP_ENTMER WHERE ENT_VALIPI > 0');
        qryConsulta.Open;
        If not qryConsulta.IsEmpty then
          pConfirmarIpi;
      finally
        FreeAndNil(qryConsulta);
      end;
    end;

    fStartTransaction;

    {************************************************************}
    {* Quando devolução não entra na função fCalculaItensPedido *}
    {*********************************************************LA*}

    pCriarFormularios(TfrmGravando,frmGravando);
    Try
      frmGravando.strChave := 'ATUALIZANDO TABELA ';
      frmGravando.lblGravando.Caption := 'Aguarde enquanto o sistema calcula os itens do pedido.';
      frmGravando.fExecutarAcao := fCalculaItensPedido;
      frmGravando.ShowModal;
      blnProcessou := frmGravando.blnConfirma;
    Finally
      FreeAndNil(frmGravando);
    End;
 
    If blnRecCliGarantia or blnDevolu Or blnProcessou or FblnAcessadoViaRetornoConsignacao Then
    Begin
      fCommit;

      pAtualizaTabela;

      If Not recNotEle.strAutInc.IsEmpty Then
        If Not fValidaRegitrosXML Then
          btnConfirma.Visible := False;

      {*****************************************}
      {* "DESABILITA O PANEL DO DOCUMENTO      *}
      {**************************************MV*}
      If fEmptyStr(recNotEle.strAutInc) Then
        pHabilitaCampos(pnlCabecalho, False);

      pnlItem.Enabled := (Not fDesabilitaItensConEquXML());
      pHabilitaCampos(pnlItem, (Not fDesabilitaItensConEquXML()));
      dbgItensGrid.Enabled := True;

      If blnDocOri And fCfgSis('USACON', varBoolean) Then
      Begin
        (***************************************************************)
        (* É POSSÍVEL ENTRAR COM UMA QUANTIDADE MENOR QUE A CONFERIDA  *)
        (* E FAZER A ENTRADA EM MAIS DE UMA NOTA                       *)
        (************************************************************LA*)
        edtQtdIte.Enabled := True;

        edtEmbala.Enabled := False;
      End;

      With qryEntMer Do
      Begin
        (FieldByName('ENT_QTDITE') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DEQTEM', varInteger));
        (FieldByName('ENT_UNITAR') As TFloatField).DisplayFormat := '#,####0.0000';
        (FieldByName('ENT_TOTITE') As TFloatField).DisplayFormat := '#,##0.00';
      End;
      pCalculaTotais;
      pSetFocus(rdbCodIte);
      blnMudarFoco           := False;
      btnConfirma.Enabled    := True;

      If Not blnPreMat Then
        btnAlterPrecos.Enabled := True;

      btnLocProx.Enabled     := True;
      btnIniBus.Enabled      := True;

    End
    Else
    Begin
      fRollBack;
    End;

  End
  Else
  Begin

    pCriaTabelaEntradaMercadorias;
    pAtualizaTabela;

    {*****************************************}
    {* "DESABILITA O PANEL DO DOCUMENTO      *}
    {**************************************MV*}
    If fEmptyStr(recNotEle.strAutInc) Then
      pHabilitaCampos(pnlCabecalho, False);

    pnlItem.Enabled := (Not fDesabilitaItensConEquXML());
    pHabilitaCampos(pnlItem, (Not fDesabilitaItensConEquXML()));
    dbgItensGrid.Enabled := True;

    With qryEntMer Do
    Begin
      (FieldByName('ENT_QTDITE') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DEQTEM', varInteger));
      (FieldByName('ENT_UNITAR') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ENT_TOTITE') As TFloatField).DisplayFormat := '#,##0.00';
    End;
    pCalculaTotais;
    pSetFocus(rdbCodIte);
    blnMudarFoco           := False;
    btnConfirma.Enabled    := True;

    If Not blnPreMat Then
      btnAlterPrecos.Enabled := True;

    btnLocProx.Enabled     := True;
    btnIniBus.Enabled      := True;

  End;

  dbgItens.DataController.DataSource  := dtsEntMer;
  dbeCodFab.DataSource := dtsEntMer;
  dbeCodFab.DataField  := 'ENT_CODFAB';
  qryEntMer.AfterScroll := pAtualizaDados;
End;

procedure TfrmEntMercadorias.pAjustaEspecie;
Begin
  If SameText(edtEspDoc.Text, 'NF') Then
  Begin
    edtBasIPI.Enabled     := True;
    edtBasIPI.NormalColor := clWhite;
    edtAlqIPI.Enabled     := True;
    edtAlqIPI.NormalColor := clWhite;
    edtvalIpi.Enabled     := True;
    edtvalIpi.NormalColor := clWhite;
    edtCodAbf.Enabled     := True;
    edtCodAbf.NormalColor := clWhite;
  End Else
  Begin
    edtBasIPI.Enabled     := False;
    edtBasIPI.NormalColor := $00FFDFB8;
    edtAlqIPI.Enabled     := False;
    edtAlqIPI.NormalColor := $00FFDFB8;
    edtvalIpi.Enabled     := False;
    edtvalIpi.NormalColor := $00FFDFB8;
    edtCodAbf.Enabled     := False;
    edtCodAbf.NormalColor := $00FFDFB8;
  End;

End;

Procedure TfrmEntMercadorias.pHabilitaCotacao(blnHabilita: Boolean);
Begin
  lblCotDol.Visible := blnHabilita;
  edtCotDol.Visible := blnHabilita;

  If blnHabilita Then
    edtCotDol.Text := FormatFloat(fMskDigitos(4), fltCotDol);
End;

procedure TfrmEntMercadorias.FormShow(Sender: TObject);
Begin
  Inherited;
  pShow;
End;

procedure TfrmEntMercadorias.pSetClaFisEntPorGarantia(Value: String = '');
begin
  FClaFisEntPorGarantia := Value;
end;

procedure TfrmEntMercadorias.pShow;
  var
    blnUsaConfPreNot: Boolean;

  procedure pCarregarCodigoCta;
  var qryConsulta: TUniQuery;
      IntCont: Integer;
  Begin
    strCodCta := '';
    strCtaPed := '';

    If stlPedidos.Count = 0 Then
    Begin
      Exit;
    End;

    qryConsulta := fCriaQuery;
    Try
      For IntCont := 0 to stlPedidos.Count -1 do
      Begin
        If IntCont > 0 Then
          qryConsulta.SQL.Add('UNION');

        qryConsulta.SQL.Add('SELECT DISTINCT(PCG_CODCTA) AS CODCTA ');
        qryConsulta.SQL.Add('  FROM PCMGER ');
        qryConsulta.SQL.Add(' WHERE PCG_NUMPED = "' + LeftStr(stlPedidos[IntCont], fTamDocCadRec()) + '"');
        qryConsulta.SQL.Add('   AND PCG_CODEMP = "' + RightStr(stlPedidos[IntCont],3) + '"' );
      End;

  	  qryConsulta.Open;
      strCodCta := IfThen(QryConsulta.RecordCount = 1, qryConsulta.FieldByName('CODCTA').AsString, '');
      If (Not fEmptyStr(strCodCta)) Then
        strCtaPed := strCodCta;


    Finally
      FreeAndNil(qryConsulta);
    End;
  End;

  function fPedidosPreNota: String;
  begin
    Result := AnsiReplaceStr(
      fCampoTabela('GROUP_CONCAT(CONCAT(PEL_NUMDOC, PEL_CODEMP))', 'PEDELE', ['PEL_SEQELE'], [recNotEle.strAutInc]), ',', #13#10);
  end;

  function fCondicaoPagamentoSugestao: String;
  begin
    Result := '';

    If Assigned(stlPedidos) And (stlPedidos.Count > 0) Then
    Begin
      Result := fCampoTabela( 'PCG_CONPAG',
                              'PCMGER',
                             ['PCG_NUMPED', 'PCG_ESPDOC', 'PCG_CODEMP'],
                             [LeftStr(stlPedidos[0], fTamDocCadRec()), 'PD', RightStr(stlPedidos[0], 3)]);
  End;

  If (Not recNotEle.strAutInc.IsEmpty) And (Not recNotEle.strEspNot.IsEmpty)
     And (edtEspDoc.Text <> recNotEle.strEspNot) Then
  Begin
    edtEspDoc.Text := recNotEle.strEspNot;
    pAjustaEspecie;
  End;

end;


  function fUsaEnderecamentoEntMer: Boolean;
  begin
    Result := fCfgSis('DEVEND', varBoolean);

    If Not Result Then
      Result := (Not fEmptyStr(recNotEle.strAutInc)) And (fCfgSis('USACON', varBoolean)) And (Pos(fCfgSis('CONFME'), '1_3_') > 0);
  End;

  Var
    intCorre : Integer;
    qryAuxi  : TUniQuery;
    stlListaItens: TStringList;
begin
  inherited;

  pHabilitaCotacao(blnInformouCotacao);

  blnPedFilialGarantia := False;

  blnExbObsFornecedor := fCfgSis('EXOBFE', varBoolean);

  If blnExbObsFornecedor Then
    pnlObsFornecedor.Visible := True
  Else
  Begin
    pnlCabecalho.Height := pnlCabecalho.Height - pnlObsFornecedor.Height;
    Self.Height := Self.Height - pnlObsFornecedor.Height;
  End;

  If blnPrecoPraticado Then
  Begin
    lblCodAbf.Visible := False;
    edtCodAbf.Visible := False;
    edtDesAbf.Visible := False;
  End;

  blnUsaEnder := fUsaEnderecamentoEntMer;

  pCarregarCodigoCta;

  If blnDevolu Then
  Begin
    edtNumDoc.TamCampo  := fTamDocCadRec;
    edtNumDoc.MaxLength := fTamDocCadRec;
  End Else
  Begin
    edtNumDoc.TamCampo  := fTamNumDoc;
    edtNumDoc.MaxLength := fTamNumDoc;
  End;

  blnAltMai := fCfgSis('ALTMAI', varBoolean);
  strSugPen := fCfgSis('SUGPEN');
  If fEmptyStr(strSugPen) Then
    strSugPen := '3'; // NENHUM

  blnUsaConfPreNot := fCfgSis('USACON', varBoolean) And
                      ((fCfgSis('CONFME') = '1') Or ((fCfgSis('CONFME') = '3') And (Not fEmptyStr(recNotEle.strAutInc))));

  If (blnUsaConfPreNot) And (Not fEmptyStr(recNotEle.strAutInc)) And fEmptyStr(fCadEmp('CLIFIL')) Then
  Begin
    FillChar(recNotEle, SizeOf(recNotEle), #0);
    pMensagemOk('O cliente filial da empresa deve ser informado, pois o mesmo será utilizado para ' +
                'gerar o pedido de reserva de estoque para a Pré-Nota!');
  End;

  stlCamposIte := TStringList.Create;
  stlCamIndIte := TStringList.Create;
  stlDesIndIte := TStringList.Create;

  mskDtaEnt.Text := DateToStr(VS_Date);
  mskDtaDoc.Text := DateToStr(VS_Date);

  If Not fEmptyStr(recNotEle.strAutInc) Then
  Begin
    If (recNotEle.finalidadeXML in [xmlEntradaMercadoria,
                                    xmlGarantiaRetFornecedor,
                                    xmlEntradaMercadoriasSistemaAnteriorDevolucao,
                                    xmlRetornoSimbolico,
                                    xmlDevolucaoEntradaEmitidaFornecedor,
                                    xmlCFG_IMPXGRGarantiaRetFornecedor]) Then
      strCodFor := recNotEle.strCodFor
    Else
      strCodFor := recNotEle.strCodCli;
  End;

  If (Not fEmptyStr(strCodFor)) Then
  Begin
    lblTotSub.Visible := True;
    edtTotSub.Visible := True;
    edtCodFor.Text    := strCodFor;
    edtCodFor.Enabled := False;

    If (blnDevolu) Or (blnRecCliGarantia) Or (blnConEqu) Or blnLocEqu or (FblnAcessadoViaRetornoConsignacao) Then
      pCarregaCliente(strCodFor)
    Else
      pCarregaFornecedor(fEmptyStr(recNotEle.strAutInc));

  End;

  If (Not fValidouAutorizacaoDoDocumentoDeTransferencia) Then
  Begin
    recNotEle := Default(TRecInfoNotaEletronica);
    fMensagem('ATENÇÃO!', 'Documento Fiscal de Transferência não está autorizado!', ['&OK']);
    blnFecharForm := True;
    Close;
    Exit;
  End;

  If (Not fValidouCancelamentoDoDocumento) Then
  Begin
    recNotEle := Default(TRecInfoNotaEletronica);
    fMensagem('ATENÇÃO!', 'Documento Fiscal se encontra em processo de cancelamento (LOGCAN)!', ['&OK']);
    blnFecharForm := True;
    Close;
    Exit;
  End;

  If (blnDevolu) Or (blnRecCliGarantia) Or (blnConEqu) Or (blnLocEqu) or (FblnAcessadoViaRetornoConsignacao) Then
  Begin
    lblCliFor.Caption := 'Cliente:';
    lblCgcCpf.Caption := 'CPF' + IfThen(blnConEqu or blnLocEqu, '/CNPJ', '') + ':';
  End;

  If blnSemInc Then
    EdtCodIte.Enabled := False;

  pAjustaEspecie;

  If (VS_strUsaTmq <> 'S') Or (blnConEqu) Or (blnLocEqu) Then
    rdbProdAcabado.Visible := False;

  If Not fEmptyStr(recNotEle.strAutInc) Then
  Begin
    stlListaItens := TStringList.Create;
    pCriarFormularios(TfrmMensagemExplicativa , frmMensagemExplicativa);
    Try
      If  (recNotEle.finalidadeXML <> xmlEntradaMercadoriasSistemaAnteriorDevolucao) Then
      Begin
        If fExisteItemInativoNotaEntrada(recNotEle.strAutInc, stlListaItens) Then
        Begin
          frmMensagemExplicativa.Caption := 'Itens Inativos.';
          frmMensagemExplicativa.mmoInstru.Lines.Text := stlListaItens.Text;
          frmMensagemExplicativa.ShowModal;
          blnFecharForm := True;
          Close;
          Exit;
        End;
      End;

    Finally
      FreeAndNil(stlListaItens);
      FreeAndNil(frmMensagemExplicativa);
    End;

    if Not blnGarantia then
      fCarregaItensNotaEletronica(recNotEle.strAutInc, VS_strCodEmp, recNotEle.finalidadeXML);

    edtNumDoc.Text := recNotEle.strNumDoc;
    edtSerie.Text  := recNotEle.strSerDoc;
    mskDtaDoc.Text := DateToStr(recNotEle.dtaDtaDoc);


    If recNotEle.finalidadeXML = xmlEntradaMercadoriasSistemaAnteriorDevolucao Then
    Begin
      mskDtaEnt.Text := DateToStr(recNotEle.dtaDtaDoc);
      mskDtaDoc.Enabled := False;
    End;

    edtNumDoc.Enabled := FALSE;
    edtSerie.Enabled  := FALSE;

    btnApaga.Visible := FALSE;

    pnlItem.Enabled := FALSE;

    If (Not fCarregaDadosPedido) Then
    Begin
      blnFecharForm := True;
      Close;
      Exit;
    End;

    blnCarregProd := FALSE;

    If blnUsaConfPreNot Then
    Begin
      stlPedidos.Text := fPedidosPreNota;
      pCarregarCodigoCta;
    End;

    If (Not ((blnDevolu) Or (blnRecCliGarantia) Or (blnConEqu) or (FblnAcessadoViaRetornoConsignacao))) Then
      pCarregaFornecedor;
  End;

  If blnPrecoPraticado Then
    pnlItem.Enabled := FALSE;

  strConPag := fCondicaoPagamentoSugestao;

  If fEmptyStr(recNotEle.strAutInc) Or blnNotaImp Then
  Begin
    Try
      qryAuxi := fCriaQuery(Self);
      With qryAuxi, SQL Do
      Begin
        qryAuxi.SQL.Clear;

        Add(' SELECT * FROM PCMGER       ');
        Add(' WHERE PCG_NUMPED = :NUMPED ');
        Add('   AND PCG_CODEMP = :CODEMP ');
        Add('   AND PCG_NUMCTN = "0"     ');
        Add('   AND PCG_PEDIMP = "S"     ');
        For intCorre := 0 To stlPedidos.Count -1 Do
        Begin
          Close;
          ParamByName('NUMPED').AsString := LeftStr(stlPedidos[intcorre], fTamDocCadRec());
          ParamByName('CODEMP').AsString := RightStr(stlPedidos[intcorre], 3);
          Open;

          if (Not fEmptyStr(FieldByName('PCG_DOCEMI').AsString)) And
             (Not fEmptyStr(FieldByName('PCG_DTAEMI').AsString)) And
             (Not SameText('000000000000', FieldByName('PCG_DOCEMI').AsString)) And
             (Not SameText('000000', FieldByName('PCG_DOCEMI').AsString)) Then
          Begin
            edtNumDoc.Text := RightStr(('000000000000' + FieldByName('PCG_DOCEMI').AsString), edtNumDoc.TamCampo);
            edtSerie.Text  := FieldByName('PCG_SEREMI').AsString;
            Break;
          End;
        End;
      End;
    Finally
      FreeAndNil(qryAuxi);
    End;
  End;

  If blnCarregProd Then
  Begin
    stlPedidos.Clear;
  End;

  If Not (blnDevolu) And blnCarregProd And (fCfgSis('USACON', varBoolean)) Then
  Begin
    blnDocOri := True;
    blnSemInc := True;
  End;

  If (blnGarantia) Or (blnRecCliGarantia) or (FblnAcessadoViaRetornoConsignacao) Or (blnBaixaPedidoDev) Then
    blnSemInc := True;

  lblNumLot.Caption := objCadLot.strTitLab + ':';


  blnValidaLoteDevolucao := blnDevolu and fCfgSis('MANEND', varBoolean);

  If {((objCadLot.tplTipLot = tplArmazem) Or fUsaRotinaWMS) And} (Not fInicializaArmazemLoteADefinir(blnValidaLoteDevolucao)) Then
  Begin
    blnFecharForm := True;
  End;

  blnSenDif := fCfgSis('SENDIF', varBoolean) And (Not blnCarregProd) And (Not blnDevolu) And
               fEmptyStr(recNotEle.strAutInc);

  If ((Not blnAltMai) Or blnSenDif Or (fCfgSis('CNVEMB') <> 'N')) And
      Assigned(qryItePed) Then
    If (Not qryItePed.Active) Then
  Begin
    If fEmptyStr(recNotEle.strAutInc) Then
      pCarregaItensPedidosTolerancia(fltCotDol, qryItePed)
    Else
      pCarregaItensPedidosTolerancia(fltCotDol, qryItePed, stlPedidos);
  End;

  If rdbCodIte.Checked Then
    pSetaCodIte(edtCodIte);

  pCriarFormularios(TfrmGravando,frmGravando);
  Try
    frmGravando.strChave := 'ENTRADA DE MERCADORIA - PRODUTOS ';
    frmGravando.lblGravando.Caption := 'Aguarde carregando os produtos';
    frmGravando.fExecutarAcao := fTravaItensLote;
    frmGravando.ShowModal;
    If not frmGravando.blnConfirma Then
      blnFecharForm := True;
  Finally
    FreeAndNil(frmGravando);
  End;

  If blnRecCliGarantia Or blnGarantia Then
  Begin
    shpUnitarGarantia.Visible := True;
    If fVerificaAcessoSistema('GEMTVU') Then
      shpUnitarGarantia.Brush.Color := clGreen
    Else
      shpUnitarGarantia.Brush.Color := clRed;
  End;

  If (Not fDesabilitaItensConEquXML()) Then Begin
    pnlItem.Enabled := False;
  End;

  if (FblnAcessadoViaRetornoConsignacao) and (FTipoRetornoConsignacao = ttrImportacaoXML) then
    blnAutomatico := False;
end;

Function TfrmEntMercadorias.fTravaItem(strCodIte: String): Boolean;
Begin
  Result := objLock.fLock_Unlock(STR_TRAVA_LOTE + strCodIte, True, False, False, '', True, 'ENTRADA');

  If Not Result Then
    TfrmMensagemTravaLote.pMostraTravaLote('O item ' + strCodIte + ' está sendo utilizado na estação: ' + fGetHostLock(STR_TRAVA_LOTE + strCodIte));
End;

Function TfrmEntMercadorias.fTravaItensLote(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryEntMer: TUniQuery;
Begin
  Result := True;

  If Not fTabelaExiste('TMP_ENTMER') Then
    Exit;

  qryEntMer := fCriaQuery;
  With qryEntMer, SQL Do
  Begin
    Add('SELECT ENT_CODITE FROM TMP_ENTMER');
    Open;
    If Assigned(pgbProgresso) Then
      pgbProgresso.Properties.Max := qryEntMer.RecordCount;


    While Not Eof Do
    Begin
      If Not fTravaItem(FieldByName('ENT_CODITE').AsString) Then
      Begin
        Result := False;
        Exit;
      End;

      Next;
      If Assigned(pgbProgresso) Then
        pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;
  End;
  FreeAndNil(qryEntMer);
End;

function TfrmEntMercadorias.fLiberarEntradaGarantia: Boolean;
  CONST
   LARGURA_LINHA = 124;
   LARGURA_CODIGO: Integer = 7;
   LARGURA_DESCRICAO: Integer = 67;
   LARGURA_UN: Integer = 4;
   LARGURA_QTD: Integer = 12;
   LARGURA_VLR_UNI: Integer = 12;
   LARGURA_TOTAL: Integer = 12;

   CAPA_LINHA1: String = 'Dt.Entrada : %0:s Dt.Documento: %1:s';
   CAPA_LINHA2: String = 'N.Documento: %0:s Série: %1:s Espécie: %2:s';
   CAPA_LINHA3: String = 'Fornecedor : %0:s-%1:s';

  Var
    objTabela : TRegistroMsgLiberaTabela;
  	objLinha  : TLinhaMsgLibera;
    strCapaLinha1, strCapaLinha2, strCapaLinha3: String;

begin
  objLiberacao.Clear;
  objTabela :=  TRegistroMsgLiberaTabela.Create;
  objlinha := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna('','ENTRADA POR GARANTIA SENHA AUXILIAR', LARGURA_LINHA, alCentro, teAutcom);
  objTabela.lstLinhas.Add(objLinha);

 {$Region 'Montando Capa'}
  strCapaLinha1 := Format(CAPA_LINHA1,[leftStr(fPadR(mskDtaEnt.Text,24),24),
                                  leftStr(fPadR(mskDtaEnt.Text,74),74)]);

  strCapaLinha2 := Format(CAPA_LINHA2,[leftStr(fPadR(edtNumDoc.Text,24),24),
                                       leftStr(fPadR(edtSerie.Text,24),24),
                                       leftStr(fPadR(edtEspDoc.Text,51),51)]);

  strCapaLinha3 := Format(CAPA_LINHA3,[edtCodFor.Text,
                                       leftStr(fPadR(edtNomFor.Text,101),101)]);

  objLinha := TLinhaMsgLibera.create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLInha.pAddColuna('',leftstr(strCapaLinha1,LARGURA_LINHA), LARGURA_LINHA, alEsquerda, teAutcom);
  objTabela.lstLinhas.Add(objLinha);

  objLinha := TLinhaMsgLibera.create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLInha.pAddColuna('',leftstr(strCapaLinha2,LARGURA_LINHA), LARGURA_LINHA, alEsquerda, teAutcom);
  objTabela.lstLinhas.Add(objLinha);

  objLinha := TLinhaMsgLibera.create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLInha.pAddColuna('',leftstr(strCapaLinha3,LARGURA_LINHA), LARGURA_LINHA, alEsquerda, teAutcom);
  objTabela.lstLinhas.Add(objLinha);
 {$EndRegion}
 {$Region 'Dados'}
  objLinha := TLinhaMsgLibera.create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLInha.pAddColuna('', 'COD.', LARGURA_CODIGO, alEsquerda, teAutcom);
  objLInha.pAddColuna('', 'DESCRIÇÃO', LARGURA_DESCRICAO, alEsquerda, teAutcom);
  objLInha.pAddColuna('', 'UN', LARGURA_UN, alCentro, teAutcom);
  objLInha.pAddColuna('', 'QUANTIDADE', LARGURA_QTD, alDireita, teAutcom);
  objLInha.pAddColuna('', 'VR.UNITÁRIO', LARGURA_VLR_UNI, alDireita, teAutcom);
  objLInha.pAddColuna('', 'VR.TOTAL', LARGURA_TOTAL, alDireita, teAutcom);
  objTabela.lstLinhas.Add(objLinha);

  qryEntMer.first;
  While Not qryEntMer.Eof do
  begin
    objLinha := TLinhaMsgLibera.create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLInha.pAddColuna('COD.',
                        qryEntMer.FieldByName('ENT_CODITE').AsString,
                        LARGURA_CODIGO,
                        alEsquerda,
                        teAutcom);

    objLInha.pAddColuna('DESCRIÇÃO',
                        qryEntMer.FieldByName('ENT_DESITE').AsString,
                        LARGURA_DESCRICAO,
                        alEsquerda,
                        teAutcom);

    objLInha.pAddColuna('UN',
                        qryEntMer.FieldByName('ENT_CODUNI').AsString,
                        LARGURA_UN,
                        alCentro,
                        teAutcom);

    objLInha.pAddColuna('QUANTIDADE',
                        FloatToStr(qryEntMer.FieldByName('ENT_QTDITE').AsFloat),
                        LARGURA_QTD,
                        alDireita,
                        teAutcom);

    objLInha.pAddColuna('VR.UNITÁRIO',
                        FormatFloat('###,##0.00',qryEntMer.FieldByName('ENT_UNITAR').AsFloat),
                        LARGURA_VLR_UNI,
                        alDireita,
                        teAutcom);

    objLInha.pAddColuna('VR.TOTAL',
                        FormatFloat('###,##0.00',qryEntMer.FieldByName('ENT_TOTITE').AsFloat),
                        LARGURA_TOTAL,
                        alDireita,
                        teAutcom);

    objTabela.lstLinhas.Add(objLinha);


    qryEntMer.Next;
  end;
  {$Endregion}

  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  objLiberacao.strDirAce := 'ETMRGF';
  objLiberacao.strMsgSen := 'Senha para liberação de entrada de mercadoria';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strCodVen;
  Result :=   objLiberacao.fLibera;
  objLiberacao.Clear;
end;

function TfrmEntMercadorias.fLiberouTravaDataDocumentoMaiorQueDataEntrada: Boolean;
begin
  Result := True;

  If StrToDate(mskDtaDoc.Text) = FDtaDocParaTrava Then
    Exit;

  If TEntradaValidacoes.fLiberouDataDocumentoMaiorQueDataEntrada(mskDtaEnt.Text, mskDtaDoc.Text) Then
  Begin
    FDtaDocParaTrava := StrToDate(mskDtaDoc.Text);
    Exit;
  End;

  pHabilitaCampos(pnlCabecalho, True);
  pHabilitaCampos(pnlItem, False);
  dbgItensGrid.Enabled := False;
  Result := False;
end;

procedure TfrmEntMercadorias.pDestravaDocumento;
begin
  If SameText(strKeyLck, fRetKeyLck) Then
  Begin
    If Assigned(objLock) Then
      objLock.fLock_Unlock(strKeyLck, False, True, False, '', True, 'ENTRADA');
  End;
end;

Procedure TfrmEntMercadorias.pDestravaItensLote;
Begin
  With qryEntMer Do
  Begin
    If Not Active Then
      Exit;

    First;
    While Not Eof Do
    Begin
      objLock.fLock_Unlock(STR_TRAVA_LOTE + FieldByName('ENT_CODITE').AsString, False, True, False, '', True, 'ENTRADA');
      Next;
    End;
  End;
End;

Function TfrmEntMercadorias.fInicializaArmazemLoteADefinir(blnFiltrarComLotes: Boolean = False): Boolean;
  Var
    qryEntrada: TUniQuery;
    stlProdutosSemADefinir: TStringList;
    strArmPri: String;
    blnPosLote: Boolean;
    strNumeroLote,
    strMensagem,
    strIteSer,
    strSerTer,
    strProMat: String;
Begin
  Result := True;

  if blnRecCliGarantia Then
    Exit;

  if (FblnAcessadoViaRetornoConsignacao) and (FTipoRetornoConsignacao = ttrEntradaManual) then
    Exit;

  If Not fTabelaExiste('TMP_ENTMER') Then
    Exit;

  strIteSer := fCfgSis('ITESER', VarString);
  strSerTer := fCfgSis('SERTER', VarString);
  strProMat := fCfgSis('PROMAT', VarString);

  stlProdutosSemADefinir := TStringList.Create;
  qryEntrada := fCriaQuery;
  Try
    With qryEntrada, SQL Do
    Begin
      Clear;
      Add('SELECT * FROM TMP_ENTMER');
      Open;

      If blnFiltrarComLotes Then
      Begin
        Filter   := '(ENT_NUMLOT IS NULL) OR ENT_NUMLOT = ' + QuotedStr('');
        Filtered := True;
        First;
      End;

      While Not Eof Do
      Begin
        If (Sametext(FieldByName('ENT_CODITE').AsString, strIteSer) Or
            Sametext(FieldByName('ENT_CODITE').AsString, strSerTer) Or
            Sametext(FieldByName('ENT_CODITE').AsString, strProMat) Or
           (recNotEle.finalidadeXML = xmlDevolucaoEntradaEmitidaFornecedor)) Then
        Begin
          Next;
          Continue;
        End;

        If (fItemMarmore(qryEntrada.FieldByName('ENT_CODITE').AsString)) Then
        begin
          Edit;
          FieldByName('ENT_NUMLOT').AsString := 'A DEFINIR';
          Post;
          If blnFiltrarComLotes Then
            Continue;
        End;

        If (objCadLot.tplTipLot = tplArmazem) Or fUsaRotinaWMS Then
        Begin

          blnPosLote := False;

          If (fRetReaEnd(qryEntrada.FieldByName('ENT_CODITE').AsString) = 'N') Then
          Begin
            //Se nao realiza enderecamento e possuir lote principal para compras
            //deve carregar este lote para o produto e nao realizar o enderecamento
            strArmPri := objCadLot.fRetArmazemPrincipalCompra(FieldByName('ENT_CODITE').AsString);

            If Not fEmptyStr(strArmPri) then
            Begin
              Edit;
              FieldByName('ENT_NUMLOT').AsString := strArmPri;
              Post;
              blnPosLote := True;
            End;
          End;

          If Not blnPosLote then
          Begin
            If objCadLot.fExisteLote(FieldByName('ENT_CODITE').AsString, VS_strCodEmp, 'A DEFINIR', False) Then
            Begin
              Edit;
              FieldByName('ENT_NUMLOT').AsString := 'A DEFINIR';
              Post;
              If blnFiltrarComLotes Then
                Continue;
            End
            Else
              stlProdutosSemADefinir.Add(FieldByName('ENT_CODITE').AsString);
          End
          Else If blnFiltrarComLotes Then
            Continue;

        End

        Else If (fRetReaEnd(FieldByName('ENT_CODITE').AsString) = 'S') And
                ((fCfgSis('USACON', varBoolean)) And (Pos(fCfgSis('CONFME'), '1_3_') > 0)) And
                objCadLot.fExisteLote(FieldByName('ENT_CODITE').AsString, VS_strCodEmp, '', False) Then
        Begin

          If Not objCadLot.fExisteLote(FieldByName('ENT_CODITE').AsString, VS_strCodEmp, 'A DEFINIR', False) Then
          Begin
            stlProdutosSemADefinir.Add(FieldByName('ENT_CODITE').AsString);
            Result := False;
          End Else
          Begin
            Edit;
            FieldByName('ENT_NUMLOT').AsString := 'A DEFINIR';
            Post;
            If blnFiltrarComLotes Then
              Continue;
          End;

        End

        Else If blnFiltrarComLotes And fEmptyStr(FieldByName('ENT_NUMLOT').AsString) And
           objCadLot.fExisteLote(FieldByName('ENT_CODITE').AsString, VS_strCodEmp) And
           (objCadLot.fQtdDeLotes(FieldByName('ENT_CODITE').AsString, VS_strCodEmp) = 1 ) Then
        Begin
          Edit;
          FieldByName('ENT_NUMLOT').AsString := objCadLot.fRetPrimeiroLote(FieldByName('ENT_CODITE').AsString, VS_strCodEmp);
          Post;
          If blnFiltrarComLotes Then
            Continue;
        End

        Else If (fRetReaEnd(FieldByName('ENT_CODITE').AsString) = 'N') And
                ((fCfgSis('USACON', varBoolean)) And (Pos(fCfgSis('CONFME'), '1_3_') > 0)) And
                (objCadLot.fExisteLote(FieldByName('ENT_CODITE').AsString, VS_strCodEmp, '', False)) And
                (Not fEmptyStr(objCadLot.fExisteLotePrincipalCompra(FieldByName('ENT_CODITE').AsString, VS_strCodEmp))) Then
        Begin
          Edit;
          FieldByName('ENT_NUMLOT').AsString := objCadLot.fExisteLotePrincipalCompra(FieldByName('ENT_CODITE').AsString, VS_strCodEmp);
          Post;
          If blnFiltrarComLotes Then
            Continue;
        End;

        if (FblnAcessadoViaRetornoConsignacao) and (FTipoRetornoConsignacao = ttrImportacaoXML) then
        Begin
          Edit;

          if (fUsaRotinaWMS) and
             (fCampoTabela( 'ITE_RASTRE', 'CADITE', ['ITE_CODITE'], [FieldByName('ENT_CODITE').AsString]) = 'N') then
            FieldByName('ENT_NUMLOT').AsString := 'A DEFINIR'
          Else
          Begin
            Result := TRetornoConsignacaoBuilder.fDefineLoteParaRetornoConsignacaoViaXML(FieldByName('ENT_AUTELE').AsString,
                                                                                         FieldByName('ENT_CODITE').AsString,
                                                                                         strNumeroLote,
                                                                                         strMensagem);
            if Result then
              FieldByName('ENT_NUMLOT').AsString := strNumeroLote
            else
            begin
              if Pos('Chave de referência', strMensagem) > 0 then
              begin
                pMensagemSonora(strMensagem, False, 15);
                Abort;
              end
              else
                pMensagemSonora(strMensagem);
            end;
          End;

          Post;
        End;

        Next;
      End;
    End;

    If {fUsaRotinaWMS And} (stlProdutosSemADefinir.Count > 0) And (Not blnFiltrarComLotes) Then
    Begin
      Result := False;
      pMensagemSonora('Existem produtos sem o Lote A DEFINIR, não será possível continuar ' +
                      'com a entrada de mercadorias.' + #13#10 + 'Produtos: ' + stlProdutosSemADefinir.CommaText + '.');
    End;
  Finally
    FreeAndNil(qryEntrada);
    FreeAndNil(stlProdutosSemADefinir);
  End;

  pAtualizaTabela;
End;

procedure TfrmEntMercadorias.btnApagaClick(Sender: TObject);
  Var
    Key: Word;
    Shift: TShiftState;
begin
  inherited;
  If (Not btnApaga.Enabled) Or (Not btnApaga.Visible) Then
    Exit;

  Key := VK_Delete;
  dbgItensKeyDown(Sender, Key, Shift);
end;

procedure TfrmEntMercadorias.edtCodIteEnter(Sender: TObject);
begin
  inherited;
  If fItemCarregadoParaVisualizacao Then
    pCarregaItensAlteracao;

  blnMudarFoco := True;
  strFabAut := '';
  btnApaga.Visible := False;
  pnlInfo.Caption := 'INSERT para fazer um novo cadastro';

  If fEmptyStr(recNotEle.strAutInc) Then
  Begin
    edtQtdIte.Text := FormatFloat(fMskDigitos(fCfgSis('DEQTEM', varInteger)), 0);
    edtTotIte.Text := '0,00';
    edtUnitar.Text := '0,00';
    edtAlqIPI.Text := '0,00';
    edtvalIpi.Text := '0,00';
  End;
end;

function TfrmEntMercadorias.fCarregaDadosPedido: Boolean;
begin
  pInicializaVariaveisManterIpi;
  Result := True;

  If (fCfgSis('ETDCTP') = 'N') and (Not blnDevolu) And (Not blnRecCliGarantia) And (Not blnConEqu) And (Not blnLocEqu)  And(not FblnAcessadoViaRetornoConsignacao) And (fVerificaDocumentoExisteCtp) Then
     blnTravarFinanceiroEstaDuplicado := True;

  If fVerificaDocumentoExiste Then
  Begin
    fMensagem('ATENÇÃO!', 'Já existe um documento com esses dados!', ['&O k']);
    Result := False;
  End

  Else If fVerificaDocumentoExisteFis Then
  Begin
    fMensagem('ATENÇÃO!', 'Já existe um documento com esses dados no livro fiscal!', ['&O k']);
    Result := False;
  End

  Else  If (fCfgSis('ETDCTP') = 'S') And (Not blnDevolu) And (Not blnRecCliGarantia) And (Not blnConEqu) And (Not blnLocEqu)  And(not FblnAcessadoViaRetornoConsignacao) And (fVerificaDocumentoExisteCtp) Then
  Begin
    fMensagem('ATENÇÃO!', 'Já existe uma duplicata no contas a pagar com esses dados!', ['&O k']);
    Result := False;
  End

  Else If ((blnDevolu) Or (blnRecCliGarantiaComGeracaoDeCredito)) And (fVerificaDocumentoExisteCtr) Then
  Begin
    fMensagem('ATENÇÃO!', 'Já existe uma duplicata no contas a receber com esses dados!', ['&O k']);
    Result := False;
  End

  Else If blnNotaImp And (Not fValidaConfigNotImp) Then
  Begin
    Result := False;
  End

  Else
  Begin

    If (Not blnDevolu) And (Not blnRecCliGarantia) And (Not blnConEqu) And (Not blnLocEqu) And (Not FblnAcessadoViaRetornoConsignacao) Then
    Begin
      Try
        strEstFor := qryConCli.FieldByName('FOR_ESTADO').AsString;
        fltAlqFor := fRetornaAlqFor(strEstFor,
                                    qryConCli.FieldByName('FOR_I_E_S_').AsString);
      Except
        fMensagem('ATENÇÃO!', 'Aconteceu uma falha ao carregar os dados do fornecedor. Entre em contato com a Citel!', ['&O k']);
        Result := False;
      End;
    End
    Else
    Begin
      Try
        strEstFor := qryConCli.FieldByName('CLI_ESTADO').AsString;
        fltAlqFor := fRetornaAlqFor(strEstFor,
                                    qryConCli.FieldByName('CLI_I_E_S_').AsString);
      Except
        fMensagem('ATENÇÃO!', 'Aconteceu uma falha ao carregar os dados do cliente. Entre em contato com a Citel!', ['&O k']);
        Result := False;
      End;
    End;

    If fValidaCabecalho Then
    Begin

      pAtuTabelaGrid;

    End;

    If (Not(blnDevolu)) Then
      blnPedFilialGarantia := qryEntMer.Active And fGerarPedidoVenda(qryEntMer.FieldByName('ENT_NUMPED').AsString,
                                                                     qryEntMer.FieldByName('ENT_CODEMP').AsString);

    dbgItens.DataController.DataSource  := dtsEntMer;
    dbeCodFab.DataSource := dtsEntMer;
    dbeCodFab.DataField  := 'ENT_CODFAB';

    If blnSemInc Then
      pCarregaItensAlteracao;
  End;
end;

function TfrmEntMercadorias.fItemCarregadoParaVisualizacao: Boolean;
begin
  Result := blnCarregadoParaVisualizacao;
end;

procedure TfrmEntMercadorias.edtCodIteKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If fIsInsert(Key) Then
  Begin
    edtCodIte.Text := fChamaCadIte(Key);
  End;
end;

procedure TfrmEntMercadorias.edtDesIteEnter(Sender: TObject);
begin
  inherited;
  If fItemCarregadoParaVisualizacao Then
  begin
    pCarregaItensAlteracao;
    edtDesIte.SelectAll;
  End;
end;

procedure TfrmEntMercadorias.edtEmbalaEnter(Sender: TObject);
begin
  inherited;
  If fItemCarregadoParaVisualizacao Then
    pCarregaItensAlteracao;

end;

procedure TfrmEntMercadorias.edtEmbalaExit(Sender: TObject);
begin
  inherited;
  edtEmbala.Text := FloatToStrF(fStrToFloat(edtEmbala.Text), ffFixed, 20, DEC_EMBALAGEM)
end;

procedure TfrmEntMercadorias.edtEspDocExit(Sender: TObject);
begin
  inherited;
  pHabilitaCampoNaGridEspeciePD(edtEspDoc.Text = 'PD');
end;

procedure TfrmEntMercadorias.edtCodIteExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';

  If btnAdicionar.Tag > 0 Then
    Exit;

  {***********************************}
  {* VERIFICA SE JA EXISTE O ITEM    *}
  {********************************JB*}
  If fVerifExisteItem And (Not fIsItemEspecial(edtCodIte.Text)) Then
    fMensagem('AVISO', 'O Item ( ' + edtCodIte.Text + ' )' + ' já existe!', ['&Ok']);

end;

function TfrmEntMercadorias.fVerificaDataBalanco: Boolean;
var ArrRecordFields: TArrRecordFields;
    cdsItensDtBalanco : TUniClientDataSet;
  procedure pCriaItensDataBalancoNaoPermitido;
  Begin

    cdsItensDtBalanco := TUniClientDataSet.Create(Self);

    With cdsItensDtBalanco.FieldDefs.AddFieldDef Do
    Begin
      Name := 'ITE_CODITE';
      DataType := ftString;
      Size := fTamCodIte;
    End;

    With cdsItensDtBalanco.FieldDefs.AddFieldDef Do
    Begin
      Name := 'ITE_DTABAL';
      DataType := ftDate;
    End;

    cdsItensDtBalanco.CreateDataSet;
    cdsItensDtBalanco.IndexFieldNames := 'ITE_CODITE';
  End;

  procedure pInsereItensDataBalancoNaoPermitido(strItem : string; strDtBal : TDate);
  Begin
    cdsItensDtBalanco.insert;
    cdsItensDtBalanco.FieldByName('ITE_CODITE').AsString := strItem;
    cdsItensDtBalanco.FieldByName('ITE_DTABAL').AsDateTime := strDtBal;
    cdsItensDtBalanco.post;
  End;
begin
  Result := True;

  If (recNotEle.finalidadeXML = xmlEntradaMercadoriasSistemaAnteriorDevolucao) Then
    Exit;

  try

    pCriaItensDataBalancoNaoPermitido;

    qryEntMer.First;

    While (Not qryEntMer.Eof) Do
    Begin
      If (qryEntMer.FieldByName('ENT_DTABAL').AsDateTime >= StrToDate(mskDtaEnt.Text)) Then
      Begin
        Result := False;
        pInsereItensDataBalancoNaoPermitido(qryEntMer.FieldByName('ENT_CODITE').AsString, qryEntMer.FieldByName('ENT_DTABAL').AsDateTime)
      End;

      qryEntMer.Next;
    End;

    If (Not Result) Then
    Begin

      SetLength(ArrRecordFields, 2);

      ArrRecordFields[0].strFieldName    := 'ITE_CODITE';
      ArrRecordFields[0].strFieldCaption := 'Item       ';
      ArrRecordFields[1].strFieldName    := 'ITE_DTABAL';
      ArrRecordFields[1].strFieldCaption := 'Data Balanço  ';

      //Abre tela genérica e exibe os itens no grid
      TfrmMsgGridGenerica.fMontaGridGenerico(ArrRecordFields, cdsItensDtBalanco, 'Os itens abaixo estão com data de balanço maior que a data documento. Verifique!',
                                               false, true, '&Confirmar', '&Sair');
      //fMensagem('', 'Não é permitido dar entrada em um item com data de balanço ' + qryEntMer.FieldByName('ENT_DTABAL').AsString + '. Verifique!', ['&Ok']);
    End;

  finally
    FreeAndNil(cdsItensDtBalanco);
  end;

  qryEntMer.First;
end;

function TfrmEntMercadorias.fVerificaDataEntradaMenorQueBalanco(DtaEnt: TDate): Boolean;
var qryConsulta: TUniQuery;
begin
  If Not fTabelaExiste('TMP_ENTMER') Then
    Exit(False);

  qryConsulta:= fCriaQuery();
  Try
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add(' SELECT                                  ');
    qryConsulta.SQL.Add('   MIN(ITE_DTABAL) AS DTABAL             ');
    qryConsulta.SQL.Add(' FROM                                    ');
    qryConsulta.SQL.Add('  ITEGER                                 ');
    qryConsulta.SQL.Add('  INNER JOIN TMP_ENTMER ON               ');
    qryConsulta.SQL.Add('             ITE_CODITE = ENT_CODITE AND ');
    qryConsulta.SQL.Add('             ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + '');

    qryConsulta.Open;

    Result := DtaEnt < qryConsulta.FieldByName('DTABAL').AsDateTime;

    If Not Result Then
      pMensagemOk('A Nota tem a data de entrada maior que a Data de Balanço');

  Finally
    FreeAndNil(qryConsulta)
  End;

end;


function TfrmEntMercadorias.fVerificaDocumentoExisteCtp: Boolean;
  Var
    strSQL   : String;
    qryGenPag: TUniQuery;
begin
  Try
    qryGenPag := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPAG CP ';
    strSQL := strSQL + ' LEFT JOIN PGOFIS PF ON PGF_SEQPAG = CP.AUTOINCREM ';
    strSQL := strSQL + ' LEFT JOIN PGOGER PG ON PGO_SEQPAG = CP.AUTOINCREM ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';
    strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';

    If (fEmptyStr(edtSerie.Text)) Then
      strSQL := strSQL + '  ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) '
    Else
      strSQL := strSQL + '  CTP_SERIE_ = :SERIE ';

    strSQL := strSQL + ' AND (CTP_PAGANT = :PAGANTN ';
    strSQL := strSQL + ' OR (CTP_PAGANT = :PAGANTS AND (PG.AUTOINCREM IS NOT NULL OR PF.AUTOINCREM IS NOT NULL)))';

    With qryGenPag Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := fStrZero(edtNumDoc.Text, edtNumDoc.TamCampo);
      ParamByName('CODFOR').AsString := edtCodFor.Text;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('PAGANTN').AsString := 'N';
      ParamByName('PAGANTS').AsString := 'S';
      If (Not fEmptyStr(edtSerie.Text)) Then
      Begin
        ParamByName('SERIE').AsString := edtSerie.Text;
      End;
      Open;
      Result := FieldByName('QTD').AsInteger > 0;
      Close;
    End;

  Finally
    FreeAndNil(qryGenPag);
  End;
end;

procedure TfrmEntMercadorias.pCarregaCliente(strCodCli: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CADCLI.*, ';
  strSQL := strSQL + '  CID_ESTADO AS CLI_ESTADO ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCLI, ';
  strSQL := strSQL + '  CADCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CLI_CODCID = CID_CODCID AND ';
  strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';

  If Not fEmptyStr(strCodFaz) And fCfgSis('CADFAZ', varBoolean) Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  FAZ_CGCCPF AS CLI_CGCCPF, ';
    strSQL := strSQL + '  FAZ_C_G_C_ AS CLI_C_G_C_, ';
    strSQL := strSQL + '  FAZ_I_E_S_ AS CLI_I_E_S_, ';
    strSQL := strSQL + '  CADCLI.*, ';
    strSQL := strSQL + '  CID_ESTADO AS CLI_ESTADO ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCLI ';
    strSQL := strSQL + '  INNER JOIN CADFAZ ON FAZ_CODCLI = CLI_CODCLI AND FAZ_CODFAZ = :CODFAZ ';
    strSQL := strSQL + '  INNER JOIN CADCID ON CID_CODCID = FAZ_CODCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';
  End;

  With qryConCli Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := strCodCli;

    If Not fEmptyStr(strCodFaz) And fCfgSis('CADFAZ', varBoolean) Then
      ParamByName('CODFAZ').AsString := strCodFaz;

    Open;
    blnSimPau      := False;
    If (fClienteConsumidor(qryConCli.FieldByName('CLI_NOMCLI').AsString)) And fCarregaClienteConsumidor Then
    Begin
      edtNomFor.Text := arrClienteConsumidor[0];                                //GER_NOMCON
      strCodFor      := qryConCli.FieldByName('CLI_CODCLI').AsString;
      strEstFor      := arrClienteConsumidor[5];                                //GER_ESTCON
      strCgcCpf      := arrClienteConsumidor[7];                                //GER_CGCCON
      strIesFor      := arrClienteConsumidor[9];                                //GER_IESCON
      strTipFor      := '';
      edtCgcCpf.Text := fFormataCpfCgc(arrClienteConsumidor[7], FPais);         //GER_CGCCON
      lblCgcCpf.Caption := IIF(arrClienteConsumidor[8] = '2', 'CPF:', 'CNPJ:' );//GER_CGCCPF
      strTipCgcCpf   := arrClienteConsumidor[8];
    End
    Else
    Begin
      edtNomFor.Text := qryConCli.FieldByName('CLI_NOMCLI').AsString;
      strCodFor      := qryConCli.FieldByName('CLI_CODCLI').AsString;
      strEstFor      := qryConCli.FieldByName('CLI_ESTADO').AsString;
      strCgcCpf      := qryConCli.FieldByName('CLI_C_G_C_').AsString;
      strIesFor      := qryConCli.FieldByName('CLI_I_E_S_').AsString;
      strTipFor      := '';

      edtCgcCpf.Text := fFormataCpfCgc(FieldByName('CLI_C_G_C_').AsString, FPais);
      lblCgcCpf.Caption := IIF(FieldByName('CLI_CGCCPF').AsString = '2', 'CPF:', 'CNPJ:' );
      strTipCgcCpf   := FieldByName('CLI_CGCCPF').AsString;
    End;

    {********************************************************************************************************}
    {* SE JÁ INICIALIZOU COM O REPRESENTANTE COM O QUAL FOI GRAVADA A VENDA NAO SOBRESCREVE O REPRESENTANTE *}
    {*****************************************************************************************************LA*}
    If (Not blnSemInc) Or SameText(strCodRep,'') Then
      strCodRep    := qryConCli.FieldByName('CLI_CODREP').AsString;

    If (blnDevolu) Or (blnRecCliGarantia) Or (blnConEqu) Or (blnLocEqu) or (FblnAcessadoViaRetornoConsignacao) Then
      blnForFil := False
    Else
      blnForFil := fFornecedorFilial(strCodCli);
  End;
end;

function TfrmEntMercadorias.fCarregaClienteConsumidor: Boolean;
var
  qryAux : TUniquery;
  stlDocSel   : TStringList;
begin
  Result := False;
  If fEmptyStr(strDocSel) Then
    Exit;

  stlDocSel := TStringList.Create;
  stlDocSel.CommaText := Trim(AnsiReplaceStr(AnsiReplaceStr(strDocSel,#39,''),'"',''));
  qryAux := fCriaQuery;
  Try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT        ');
    qryAux.SQL.Add('  GER_NOMCON, ');
    qryAux.SQL.Add('  GER_ENDCON, ');
    qryAux.SQL.Add('  GER_BAICON, ');
    qryAux.SQL.Add('  GER_CEPCON, ');
    qryAux.SQL.Add('  GER_CIDCON, ');
    qryAux.SQL.Add('  GER_ESTCON, ');
    qryAux.SQL.Add('  GER_TELCON, ');
    qryAux.SQL.Add('  GER_CGCCON, ');
    qryAux.SQL.Add('  GER_CGCCPF, ');
    qryAux.SQL.Add('  GER_IESCON, ');
    qryAux.SQL.Add('  GER_R_GCON  ');
    qryAux.SQL.Add('FROM          ');
    qryAux.SQL.Add('  MOVGER      ');
    qryAux.SQL.Add('WHERE         ');
    qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  GER_CODCLI = :CODCLI ');
    qryAux.SQL.Add('UNION ALL     ');
    qryAux.SQL.Add('SELECT        ');
    qryAux.SQL.Add('  GER_NOMCON, ');
    qryAux.SQL.Add('  GER_ENDCON, ');
    qryAux.SQL.Add('  GER_BAICON, ');
    qryAux.SQL.Add('  GER_CEPCON, ');
    qryAux.SQL.Add('  GER_CIDCON, ');
    qryAux.SQL.Add('  GER_ESTCON, ');
    qryAux.SQL.Add('  GER_TELCON, ');
    qryAux.SQL.Add('  GER_CGCCON, ');
    qryAux.SQL.Add('  GER_CGCCPF, ');
    qryAux.SQL.Add('  GER_IESCON, ');
    qryAux.SQL.Add('  GER_R_GCON  ');
    qryAux.SQL.Add('FROM          ');
    qryAux.SQL.Add('  NOTGER      ');
    qryAux.SQL.Add('WHERE         ');
    qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  GER_CODCLI = :CODCLI     ');
    qryAux.ParamByName('NUMDOC').AsString := Copy(stlDocSel[0], 01, fTamDocCadRec());
    qryAux.ParamByName('ESPDOC').AsString := Copy(stlDocSel[0], fTamDocCadRec() + 1, 2);
    qryAux.ParamByName('CODEMP').AsString := Copy(stlDocSel[0], fTamDocCadRec() + 3, 3);
    qryAux.ParamByName('CODCLI').AsString := Copy(stlDocSel[0], fTamDocCadRec() + 6, 8);
    qryAux.Open;
    If Not qryAux.IsEmpty Then
    Begin
      arrClienteConsumidor[0] :=  qryAux.FieldByName('GER_NOMCON').AsString;
      arrClienteConsumidor[1] :=  qryAux.FieldByName('GER_ENDCON').AsString;
      arrClienteConsumidor[2] :=  qryAux.FieldByName('GER_BAICON').AsString;
      arrClienteConsumidor[3] :=  qryAux.FieldByName('GER_CEPCON').AsString;
      arrClienteConsumidor[4] :=  qryAux.FieldByName('GER_CIDCON').AsString;
      arrClienteConsumidor[5] :=  qryAux.FieldByName('GER_ESTCON').AsString;
      arrClienteConsumidor[6] :=  qryAux.FieldByName('GER_TELCON').AsString;
      arrClienteConsumidor[7] :=  qryAux.FieldByName('GER_CGCCON').AsString;
      arrClienteConsumidor[8] :=  qryAux.FieldByName('GER_CGCCPF').AsString;
      arrClienteConsumidor[9] :=  qryAux.FieldByName('GER_IESCON').AsString;
      arrClienteConsumidor[10]:=  qryAux.FieldByName('GER_R_GCON').AsString;
      Result := True;
    End
  Finally
    FreeAndNil(qryAux);
    FreeAndNil(stlDocSel);
  End;
end;

function TfrmEntMercadorias.fVerificaDocumentoExisteCtr: Boolean;
  Var
    strSQL   : String;
    qryGenRec: TUniQuery;

begin
  Try

    qryGenRec := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  CTR_CODEMP = "' + VS_strCodEmp + '"';

    With qryGenRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := AnsiRightStr(edtNumDoc.Text, fTamDocCadRec);
      ParamByName('CODCLI').AsString := edtCodFor.Text;
      ParamByName('ESPDOC').AsString := edtEspDoc.Text;

      Open;
      Result := FieldByName('QTD').AsInteger > 0;
      Close;
    End;

  Finally
    FreeAndNil(qryGenRec);
  End;
end;

function TfrmEntMercadorias.fVerificaDocumentoExisteFis: Boolean;
  Var
    strSQL   : String;
    qryGenFis: TUniQuery;

begin
  Try
    Result := False;

    qryGenFis := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + ' SELECT                    ';
    strSQL := strSQL + '  FIS_NUMDOC,              ';
    strSQL := strSQL + '  FIS_ESPDOC,              ';
    strSQL := strSQL + '  FIS_CODEMP,              ';
    strSQL := strSQL + '  FIS_FORCLI,              ';
    strSQL := strSQL + '  FIS_SERIE_,              ';
    strSQL := strSQL + '  FIS_TIP_FC,              ';
    strSQL := strSQL + '  FIS_DTAENT               ';
    strSQL := strSQL + ' FROM                      ';
    strSQL := strSQL + '  CADFIS                   ';
    strSQL := strSQL + ' WHERE                     ';
    strSQL := strSQL + '  FIS_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  FIS_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  FIS_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  FIS_FORCLI = :FORCLI AND ';
    strSQL := strSQL + '  FIS_SERIE_ = :SERIE_     ';
    // Exclui notas de importação
    strSQL := strSQL + '  AND LEFT(FIS_CLFSC1, 1) <> "3"';

    If (blnDevolu) Or (blnRecCliGarantia) Or (blnConEqu) Or blnLocEqu or (FblnAcessadoViaRetornoConsignacao) Then
      strSQL := strSQL + '  AND FIS_TIP_FC = ''C'' '
    Else
      strSQL := strSQL + '  AND FIS_TIP_FC = ''F'' ';

    With qryGenFis Do
    Begin

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := edtNumDoc.Text;
        ParamByName('ESPDOC').AsString := edtEspDoc.Text;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('FORCLI').AsString := edtCodFor.Text;
        ParamByName('SERIE_').AsString := edtSerie.Text;
        Open;

        If Not IsEmpty Then
          Result := True
    End;

  Finally
    FreeAndNil(qryGenFis);
  End;

end;

function TfrmEntMercadorias.fVerificaItemServicoDivergenteJaUsado(AstrCodIte: String): Boolean;
var qryConsulta: TUniQuery;
  strIteSer,
  strSerTer: String;
begin
  strIteser :=  fCfgSis('ITESER');
  strSerTer :=  fCfgSis('SERTER');
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT ENT_CODITE FROM TMP_ENTMER');
    If AstrCodIte = strIteSer Then
      qryConsulta.SQL.Add(' WHERE ENT_CODITE = "' + strSerTer + '"')
    Else
      qryConsulta.SQL.Add(' WHERE ENT_CODITE = "' + strIteSer + '"');

    qryConsulta.Open;

    Result := Not qryConsulta.IsEmpty;

  Finally
    FreeAndNil(qryConsulta);
  End;

end;

procedure TfrmEntMercadorias.pConsultaCadCli;
  Var
    blnConfirma: Boolean;
    arrSel : TConsultasArray;
    chrKey : Char;

begin

  chrKey := '/';

  Try
    blnConfirma := fPesqCliente(conCliSimples, Self, nil, nil, qryConCli, chrKey, arrSel);
  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '[frmEntMercadorias.pConsultaCadCli]');
    End;
  End;

  If (blnConfirma) Then
  Begin

    edtCodFor.Text := qryConCli.FieldByName('CLI_CODCLI').AsString;

    If fValidaCampos(edtCodFor, True) Then
      blnMudarFoco   := True;

  End;

end;

procedure TfrmEntMercadorias.pConsultaCadFor;
  Var
    arrFornec: TConsultasArray;
    chrKey: Char;
Begin
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  chrKey := '/';
  If fPesqFornecedor(conForCompleta, Self, edtCodFor, edtNomFor, Nil, chrKey, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
  
end;

procedure TfrmEntMercadorias.rdbCodIteClick(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodIte);
end;

procedure TfrmEntMercadorias.rdbCodFabClick(Sender: TObject);
begin
  inherited;
  edtCodIte.TipoTexto := EditFocus.TControlTipoTexto(ttAlfanumerico);
  edtCodIte.MaxLength := TAM_CODIGO_FABRICA;
  edtCodIte.TamCampo  := TAM_CODIGO_FABRICA;
  edtCodIte.CompZeros := False;
end;

procedure TfrmEntMercadorias.btnIniBusClick(Sender: TObject);
  Var
    frmBuscaItem : TfrmBuscaItem;
begin
  inherited;
  If (Not qryEntMer.Active) Or
     (qryEntMer.IsEmpty)    Then
  Begin
    Exit;
  End;

  Try
    pCriarFormularios(TfrmBuscaItem, frmBuscaItem);

    With frmBuscaItem Do
    Begin
      If rdbCodIte.Checked Then
        busTipBus := busCodIte
      Else If rdbCodFab.Checked Then
        busTipBus := busCodFab
      Else If rdbProdAcabado.Checked Then
        busTipBus := busProAca;
    End;

    frmBuscaItem.ShowModal;

    If (Not fEmptyStr(frmBuscaItem.strValorFiltro)) Then
    Begin
      strValorFiltro := frmBuscaItem.strValorFiltro;
      strCampoFiltro := frmBuscaItem.strCampoFiltro;
      qryEntMer.FindFirst;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmEntMercadorias.btnIniBusClick]');
    End;
  End;

  pFreeAndNil(frmBuscaItem);
end;

procedure TfrmEntMercadorias.btnLocProxClick(Sender: TObject);
begin
  inherited;
  If (qryEntMer.Active) And (Not fEmptyStr(strCampoFiltro)) Then
    qryEntMer.FindNext;
end;

procedure TfrmEntMercadorias.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);

end;

procedure TfrmEntMercadorias.pFinalizaCamposUso;
begin
  If (cpuCampos <> Nil) Then
    FreeAndNil(cpuCampos);
end;

{***********************************}
{* CARREGA OS DADOS DO PRODUTO, A  *}
{* PARTIR DO AUTOINCREM DO CADACA  *}
{********************************MV*}
procedure TfrmEntMercadorias.pCarregaProdutoAcabado(strCodBar: String);
  Var
    qryAux: TUniQuery;
    strCodIte: String;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  * ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  CADACA A ');
  qryAux.SQL.Add('JOIN ACAGER G ON G.ACA_CODACA = A.ACA_CODACA AND ');
  qryAux.SQL.Add('                 G.ACA_CODEMP = A.ACA_CODEMP ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  G.ACA_EMPEST = :EMPEST AND ');
  qryAux.SQL.Add('  A.ACA_CODBAR = :CODBAR ');

  qryAux.ParamByName('EMPEST').AsString := VS_strCodEmp;
  qryAux.ParamByName('CODBAR').AsString := strCodBar;
  qryAux.Open;

  strCodIte := qryAux.FieldByName('ACA_CODITE').AsString;
  strDesAca := qryAux.FieldByName('ACA_DESCRI').AsString;
  strCodAca := qryAux.FieldByName('ACA_CODACA').AsString;
  strEmpAca := qryAux.FieldByName('ACA_CODEMP').AsString;
  fltPreAca := qryAux.FieldByName('ACA_PRECUS').AsFloat;
  fltSalAca := qryAux.FieldByName('ACA_SALDOS').AsFloat;

  qryAux.Close;
  FreeAndNil(qryAux);

  pPesquisaCadIte(qryConCit, qryConCit, strCodIte);
end;

procedure TfrmEntMercadorias.rdbProdAcabadoClick(Sender: TObject);
begin
  inherited;
  edtCodIte.TipoTexto := EditFocus.TControlTipoTexto(ttNumerico);
  edtCodIte.MaxLength := 15;
  edtCodIte.TamCampo  := 15;
  edtCodIte.CompZeros := False;
end;

function TfrmEntMercadorias.fConsultaProdAcabados(edtCodIte: TEditFocus): Boolean;
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
begin
  chrKey := '?';
  Result := fPesqProdAcabado(Self, edtCodIte, Nil, Nil, chrKey, arrSel, '', VS_strCodEmp, True, 'Consulta de Produtos Acabados', False, True);
end;

function TfrmEntMercadorias.fDesabilitaItensConEquXML: Boolean;
begin
  Result := ( (blnConEqu) or (blnLocEqu) )And (Not fEmptyStr(recNotEle.strAutInc));
end;

procedure TfrmEntMercadorias.pAtualizaCamposUso;
begin
  pFinalizaCamposUso;
  pAtribuiCamposUso;
end;

procedure TfrmEntMercadorias.pAtualizaDados(Dataset: TDataset);
begin

  If (Not Assigned(Dataset)) Then
    Exit;
  pCarregaItensVis;

  If (Dataset.FieldByName('ENT_PROACA').AsString = 'S') Then
  Begin
    btnAlterPrecos.Enabled := False;
  End
  Else
  Begin

    If Not blnPreMat Then
      btnAlterPrecos.Enabled := True;
  End;

end;

procedure TfrmEntMercadorias.edtUnidadEnter(Sender: TObject);
begin
  inherited;
  If fItemCarregadoParaVisualizacao Then
    pCarregaItensAlteracao;

end;

procedure TfrmEntMercadorias.edtUnidadKeyPress(Sender: TObject;
  var Key: Char);
var
  arrUnidades: TConsultasArray;
begin
  inherited;
  If edtUnidad.ReadOnly Then
    Exit;

  {*****************************}
  {* NOVA CONSULTA DE UNIDADES *}
  {**************************AC*}
  if fPesqUnidade(Self, edtUnidad, Nil, edtSigla, qryCadUni, Key, arrUnidades) then
  begin
    If fValidaCampos(edtUnidad, True) Then
      SelectNext(ActiveControl, True, True);
  end;

end;

procedure TfrmEntMercadorias.edtNumDocExit(Sender: TObject);
begin
  inherited;
  edtNumDoc.Text := fStrZero(edtNumDoc.Text, edtNumDoc.TamCampo);
end;

procedure TfrmEntMercadorias.edtNumDocKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  if Key = '-' then
    Key := #0;
end;

procedure TfrmEntMercadorias.edtNumLotEnter(Sender: TObject);
begin
  inherited;
  If fItemCarregadoParaVisualizacao Then
    pCarregaItensAlteracao;

end;

procedure TfrmEntMercadorias.edtNumLotKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If edtNumLot.ReadOnly Then
    Exit;
    
  If objCadLot.fedtNumLotKeyPress(edtCodIte.Text, Sender, Key, edtNumLot, Self, False) Then
  Begin
    If fValidaCampos(edtNumLot, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEntMercadorias.btnCadLotClick(Sender: TObject);
Var
  intPosicaoGrid: Integer;
  strCodite: String;
begin
  inherited;
  intPosicaoGrid := qryEntMer.RecNo;
  strCodite := edtCodIte.Text;
  Try
    pCriarForm(TfrmCadLoteItens);

    fInicializaArmazemLoteADefinir(True);

    If Not fEmptyStr(strCodite) Then
      pMostraLote(objCadLot.fExisteLote(strCodite, VS_strCodEmp, '', False), fRetReaEnd(edtCodIte.Text));
  Finally
    If qryEntMer.Recordcount > 0 Then
      qryEntMer.RecNo := intPosicaoGrid;
    If (Not edtCodIte.Focused) And (edtNumLot.Visible) Then
      pSetFocus(edtNumLot)
    Else If (Not fEmptyStr(edtCodIte.Text)) And (Not edtCodIte.Focused) Then
      pSetFocus(edtCodIte);
  End;
end;

procedure TfrmEntMercadorias.btnCadProdutoClick(Sender: TObject);
begin
  inherited;
  If fVerificaAcessoSistema('ITEENT') Then
    pCriarForm(TfrmCadProdutos, frmCadProdutos);
end;

procedure TfrmEntMercadorias.mskDtaEntExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyDate(mskDtaEnt.Text) Then
    mskDtaEnt.Text := FormatDateTime('dd/mm/yyyy',StrToDate(mskDtaEnt.Text));
end;

procedure TfrmEntMercadorias.mskDtaDocExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyDate(mskDtaDoc.Text) Then
    mskDtaDoc.Text := FormatDateTime('dd/mm/yyyy',StrToDate(mskDtaDoc.Text));
end;

procedure TfrmEntMercadorias.edtvalIpiEnter(Sender: TObject);
begin
  inherited;
  If fItemCarregadoParaVisualizacao Then
    pCarregaItensAlteracao;

  fltValIpiAnt := fStrToFloat(edtvalIpi.Text);
end;

procedure TfrmEntMercadorias.edtvalIpiExit(Sender: TObject);
begin
  inherited;

  pCalculaValIpi((RoundTo(fltValIpiAnt, -2) <> RoundTo(fStrToFloat(edtvalIpi.Text), -2)) Or
                 (FloatToStrF((fStrToFloat(edtBasIpi.Text) * fStrToFloat(edtAlqIpi.Text)) / 100, ffFixed, 12, 2) <> edtvalIpi.Text));
end;

function TfrmEntMercadorias.fPrecoUnitarioEspecialFornecedor(strCodFor,
  strCodIte: String): Double;
begin
  Result := fCampoTabela('FPR_VALITE',
                         'FORPRE',
                         ['FPR_CODFOR', 'FPR_CODITE'],
                         [strCodFor, strCodIte]);
end;

function TfrmEntMercadorias.fRetTopo(strTipEti: String): Integer;
  Var
    strSQL   : String;
    qryGenEti: TUniQuery;
begin
  Try
    qryGenEti := fCriaQuery(Self);

    Result := 0;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CNF_LINTOP ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '  CNFETI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CNF_TIPETI = :TIPETI AND ';
    strSQL := strSQL + '  CNF_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
    strSQL := strSQL + 'ORDER BY ';
    strSQL := strSQL + '  CNF_IDENTI, CNF_LINIMP ';
    strSQL := strSQL + '  LIMIT 1   ';

    With qryGenEti Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName( 'TIPETI' ).AsString := strTipEti;
      Open;

      If Not IsEmpty Then
        Result := FieldByName( 'CNF_LINTOP' ).AsInteger;

      Close;
    End;

  Finally
    FreeAndNil(qryGenEti);
  End;
end;

procedure TfrmEntMercadorias.pCarregaDadosAdicPedido(strCodFor,
  strNumPed: String);
Var
  strSQL   : String;
  qryGenPed: TUniQuery;
begin

  Try

    qryGenPed := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  PCG_CODEVE, ';
    strSQL := strSQL + '  PCG_CODCTA  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  PCMGER ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  PCG_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCG_CODFOR = :CODFOR AND ';
    strSQL := strSQL + '  PCG_CODEMP = :CODEMP     ';

    With qryGenPed Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMPED').AsString := strNumPed;
      ParamByName('CODFOR').AsString := strCodFor;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      strCodEve := FieldByName('PCG_CODEVE').AsString;
      strCodCcu := FieldByName('PCG_CODCTA').AsString;
    End;

  Finally
    FreeAndNil(qryGenPed);
  End;

end;

Function TfrmEntMercadorias.fCondicaoPagamentoDevolucao: String;
  Var
    qryGenVen: TUniQuery;
begin
  Result := strConPag;

  If Not blnDevolu Then
    Exit;

  qryGenVen := fCriaQuery(Nil);

  With qryGenVen, SQL Do
  Begin
    Clear;
    Add('SELECT SQL_NO_CACHE ');
    Add('  DET_DTAENT, ');
    Add('  DET_CONPAG ');
    Add('FROM ');
    if qryEntMer.FieldByName('ENT_TABELA').AsString <> '' Then
      Add(qryEntMer.FieldByName('ENT_TABELA').AsString)
    Else
      Add('  MOVDET ');
    Add('WHERE ');
    Add('  AUTOINCREM = :AUTINC ');

    if qryEntMer.FieldByName('ENT_TABELA').AsString = 'MOVDET' Then
    ParamByName('AUTINC').AsString := qryEntMer.FieldByName('ENT_AUTVEN').AsString;

    Open;

    If IsEmpty Then
    Begin
      Close;
      Text := AnsiReplaceStr(Text, 'MOVDET', 'NOTDET');

      ParamByName('AUTINC').AsString := qryEntMer.FieldByName('ENT_AUTVEN').AsString;

      Open;
    End;

    If Not IsEmpty Then
      Result := fRetCondicaoDevolucao(FieldByName('DET_DTAENT').AsDateTime,
                                      FieldByName('DET_CONPAG').AsString);
  End;

  FreeAndNil(qryGenVen);
end;

Function TfrmEntMercadorias.fRetKeyLck: String;
Begin
  Result := TEntradaAutomatizada.fRetKeyLckNota(edtNumDoc.Text, edtEspDoc.Text, edtCodFor.Text, edtSerie.Text);
End;

function TfrmEntMercadorias.fRetornaMotivoAD: String;
begin
  Try
    pCriarFormularios(TfrmDigOcorrencia, frmDigOcorrencia);
    frmDigOcorrencia.ShowModal;
    If (frmDigOcorrencia.ModalResult = mrOk) Then
    Begin
      Result := frmDigOcorrencia.strCodOco;
    End
    Else
    Begin
      Result := '';
    End;
  Finally
    pFreeAndNil(frmDigOcorrencia);
  End;
end;

function TfrmEntMercadorias.fGerarPedidoVenda(strNumPed, strCodEmp: String): Boolean;
Var
  strSQL: String;
  qryGen: TUniQuery;
begin

  Try

    qryGen := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  PCG_OBS001 ';
    strSQL := strSQL + 'FROM         ';
    strSQL := strSQL + '  PCMGER     ';
    strSQL := strSQL + 'WHERE        ';
    strSQL := strSQL + '  PCG_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCG_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  PCG_CODEMP = :EMPDES     ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMPED').AsString := strNumPed;
      ParamByName('ESPDOC').AsString := 'PD';
      ParamByName('EMPDES').AsString := strCodEmp;
      Open;

      Result := (FieldByName('PCG_OBS001').AsString = 'GARANTIA(TE)');
    End;

  Finally
    FreeAndNil(qryGen);
  End;

end;

function TfrmEntMercadorias.fGarantiaPermitirEditarLote: Boolean;
begin
  Result := (blnGarantia or blnRecCliGarantia)
end;

function TfrmEntMercadorias.fValidaConfigNotImp: Boolean;
  Var
    strCfgs: String;
Begin
  strCfgs := '';

  If fEmptyStr(fRetNomeConta(fCfgSis('CCPROD'))) Then
    strCfgs := strCfgs + ' CFG_CCPROD';

  If fEmptyStr(fRetNomeConta(fCfgSis('CCIMPO'))) Then
    strCfgs := strCfgs + ' CFG_CCIMPO';

  If fEmptyStr(fRetNomeConta(fCfgSis('CCVIPI'))) Then
    strCfgs := strCfgs + ' CFG_CCVIPI';

  If fEmptyStr(fRetNomeConta(fCfgSis('CCVPIS'))) Then
    strCfgs := strCfgs + ' CFG_CCVPIS';

  If fEmptyStr(fRetNomeConta(fCfgSis('CCVCOF'))) Then
    strCfgs := strCfgs + ' CFG_CCVCOF';

  If fEmptyStr(fRetNomeConta(fCfgSis('CCSICO'))) Then
    strCfgs := strCfgs + ' CFG_CCSICO';

  If fEmptyStr(fRetNomeConta(fCfgSis('CCAFRM'))) Then
    strCfgs := strCfgs + ' CFG_CCAFRM';

  If fEmptyStr(fRetNomeConta(fCfgSis('CCICMS'))) Then
    strCfgs := strCfgs + ' CFG_CCICMS';

  Result := fEmptyStr(strCfgs);

  If Not Result Then
    pMensagemOk('Informe o Plano de Contas para rateio do Contas a Pagar de ' + #13#10 +
                'Notas de Importação em Configurações \ Entrada de Mercadorias' + #13#10 +
                ' para as variáveis: ' + strCfgs + '.');

end;

procedure TfrmEntMercadorias.pConfirmarIpi;
Const
  OP_SIM: Integer  = 1;
  OP_NAO: Integer  = 2;
begin
  if blnObterConfirmacaoIpi then
  begin
   blnManterIpi := fMensagem('Atenção!','A operação contém IPI. Deseja considerar o valor do tributo?', ['&Sim','&Não'], OP_NAO) = OP_SIM;
   blnObterConfirmacaoIpi := False;
  end;
end;

procedure TfrmEntMercadorias.pInicializaVariaveisManterIpi;
begin
  blnManterIpi := False;
  blnObterConfirmacaoIPI := True;
end;

function TfrmEntMercadorias.fCalcularFcp(pfltBasIcm, pfltAliFcp, pfltPeBaST: Double; pstrCodFor, pstrCodAbf,
  pstrTipAbf: String): TRecDadosFCP;
begin
  if Not blnDevolu then
  begin
    Result.Create(0);
    Exit;
  end
  else
    Result.Create(pfltAliFcp);

  if fEmptyStr(pstrTipAbf) then
    pstrTipAbf := fGetTipoAbfCliente(pstrCodFor);

  Result.blnTemST := (Pos(strCodFis, CST_SUBSTITUICAO) > 0);
  Result.fltValIVA := fRetornaPercIVA(pstrCodAbf,strEstFor, pstrTipAbf);
  Result.fltBCFCP := (pfltBasIcm * pfltPeBaST)/100;
  Result.pCalcular;
end;

function TfrmEntMercadorias.fObterFcpItem: TRecDadosFCP;
begin
  Result.Create(QryEntMer.FieldByName('ENT_PERFCP').AsFloat);
  Result.fltBCFCPST := QryEntMer.FieldByName('ENT_BFCPST').AsFloat;
  Result.fltPFCPST  := QryEntMer.FieldByName('ENT_PFCPST').AsFloat;
  Result.fltVFCPST  := QryEntMer.FieldByName('ENT_VFCPST').AsFloat;
  Result.fltBCFCP   := QryEntMer.FieldByName('ENT_VBCFCP').AsFloat;
  Result.fltValFCP  := QryEntMer.FieldByName('ENT_VALFCP').AsFloat;
  Result.blnTemST := (Result.fltBCFCPST > 0) or (Result.fltPFCPST > 0);
end;

function TfrmEntMercadorias.fCalcularFcpDevolucao: Boolean;
begin
  Result := blnDevolu and  fEmptyStr(strDocSel);
end;


{ TRecDadosFCP }

constructor TRecDadosFCP.Create(pfltAliFcp: Double);
begin
  pInicializar;
  Self.fltAliFcp := pfltAliFcp;
  Self.fltPFCPST := pfltAliFcp;
end;

procedure TRecDadosFCP.pCalcular;
begin
  Self.fltValFcp := (Self.fltBCFCP * Self.fltAliFCP) /100;

  if Self.blnTemSt then
  begin
    Self.fltBCFCPST := (Self.fltBCFCP * Self.fltValIVA);
    Self.fltVFCPST :=  ((Self.fltBCFCPST * Self.fltPFCPST)/100) - Self.fltValFcp;
  end
  else
  begin
    fltPFCPST := 0;
    fltBCFCPST := 0;
    fltVFCPST := 0;
  end;
end;

procedure TRecDadosFCP.pInicializar;
begin
  Self.fltValIVA := 0;
  Self.fltBCFCP := 0;
  Self.fltValFCP := 0;
  Self.fltPFCPST := 0;
  Self.fltBCFCPST := 0;
  Self.fltVFCPST := 0;;
end;

function TfrmEntMercadorias.fValidouAutorizacaoDoDocumentoDeTransferencia : Boolean;
  Var
    LStatusNfe : TStatusNfe;
    blnEhFilial : Boolean;
begin
  Result := True;

  If (fEmptyStr(recNotEle.strAutInc)) Then
    Exit;

  If (fEmptyStr(recNotEle.str_Chave)) Then
    Exit;

  If (Self.blnAcessadoViaRetornoConsignacao) Then
    Exit;

  LStatusNfe := fGetStatusNfe(recNotEle.str_Chave);

  If fEmptyStr(LStatusNfe.Status) Then
    Exit;

  If fEmptyStr(LStatusNfe.TipoClienteFornecedor) Then
    Exit;

  If (LStatusNfe.Status = 'AT') Then
    Exit;

  If (LStatusNfe.TipoClienteFornecedor = 'C') Then
    blnEhFilial := fClienteFilial(LStatusNfe.ClienteFornecedor)
  Else
    blnEhFilial := fFornecedorFilial(LStatusNfe.ClienteFornecedor);

  If (Not blnEhFilial) Then
    Exit;

  Result := False;
end;

function TfrmEntMercadorias.fValidouCancelamentoDoDocumento : Boolean;
begin
  Result := True;

  If (fEmptyStr(recNotEle.strAutInc)) Then
    Exit;

  If (fEmptyStr(recNotEle.str_Chave)) Then
    Exit;

  If Not objLogCancelamento.fExisteCancelamentoPendentePorChaveAcesso(recNotEle.str_Chave) Then
    Exit;

  Result := False;
end;

function TfrmEntMercadorias.fGetStatusNfe(const strChaveAcesso : String) : TStatusNfe;
  Var
    qryLogNfe : TUniQuery;
begin
  qryLogNfe := fCriaQuery;
  Try
    FillChar(Result, SizeOf(Result), #0);
    qryLogNfe.Close;
    qryLogNfe.SQL.Clear;
    qryLogNfe.SQL.Add(' SELECT NFE_STATUS, NFE_CODCLI, NFE_TIP_FC ');
    qryLogNfe.SQL.Add('   FROM LOGNFE ');
    qryLogNfe.SQL.Add('  WHERE NFE_ACESSO = :ACESSO ');
    qryLogNfe.ParamByName('ACESSO').AsString := strChaveAcesso;
    qryLogNfe.Open;
    If (qryLogNfe.IsEmpty) Then
      Exit;
    Result.ClienteFornecedor := qryLogNfe.FieldByName('NFE_CODCLI').AsString;
    Result.TipoClienteFornecedor := qryLogNfe.FieldByName('NFE_TIP_FC').AsString;
    Result.Status := qryLogNfe.FieldByName('NFE_STATUS').AsString;
  Finally
    FreeAndNil(qryLogNfe);
  End;
end;

end.
