{ ********************************************* }
{ * INSERÇÃO DE ITENS MODELO FRENTE DE CAIXA  * }
{ *                                           * }
{ * DATA......: 19/09/2011                    * }
{ * AUTOR.....: ALEXANDRE OLIVEIRA FERRI      * }
{ *                                           * }
{ ******************************************AF* }
unit untCaixa;

interface

uses
  Windows, Classes, Controls, Forms, untPai, Menus, StdCtrls, Buttons, ExtCtrls,
  DB, UniClientDataSet, CurrencyEditFocus, EditFocus, Grids, DBGridCitel,
  DBGrids, DBCtrls, System.Types, System.UITypes, System.ImageList,
  DBEditFocus, jpeg, Uni, AppEvnts, untFuncFat, untFuncoesSimples, untGravando,
  cxProgressBar, BitBtnLockedIncrem, Graphics, Mask, untTypesSistema, frxClass,
  frxExportCSVTestabilidade, untMovCdb, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Datasnap.DBClient, cxTextEdit,
  cxCurrencyEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDBData, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxClasses, cxGridLevel,
  cxGrid, System.Variants, untIteBar, untRetificarPrecoCheckout,
  cxDataControllerConditionalFormattingRulesManagerDialog, untLiberacao, untFuncFatTypes,
  dxGDIPlusClasses, Vcl.ImgList, cxImageList, untRegrasRestricaoVendaProdutos,
  untCadPro, untFatSeriesItem;

Type
  TFuncaoDesconto = function(Var fltPorDes, fltDesEsp, fltTotGer: Double; cdsItensNovos: TUniClientDataSet; blnConcomitante: Boolean; blnFechamentoComDesconto: Boolean;
    strTabPre: String; pgbStatus: TcxProgressBar): Boolean of object;

Type
  TPrcCarregaCliente = procedure(blnVerEnd: Boolean = False; strParCli: String = '') of object;

type
  TTipoItem = (itePedido, iteDigitado, iteEstrutura, iteRetificacaoPreco);

  TfrmCaixa = class(TfrmPai)
    pnlInfoGeralItens: TPanel;
    pnlOperacoes: TPanel;
    pnlBotoesCaixa: TPanel;
    pnlTotais: TPanel;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    pnlItens: TPanel;
    btnFecharVenda: TSpeedButton;
    btnFecharCaixa: TSpeedButton;
    Label1: TLabel;
    Label3: TLabel;
    pnlInfoItens: TPanel;
    edtCodBarra: TEditFocus;
    edtQtd: TCurrencyEditFocus;
    StaticText6: TStaticText;
    StaticText7: TStaticText;
    StaticText8: TStaticText;
    pnlInfoGeral: TPanel;
    imgLogo: TImage;
    tmrRelogio: TTimer;
    cdsItens: TUniClientDataSet;
    dtsItens: TDataSource;
    sttOperador: TStaticText;
    sttData: TStaticText;
    sttHora: TStaticText;
    cdsItensITE_TOTITE: TFloatField;
    cdsItensAGG_VALTOT: TAggregateField;
    cdsItensAGG_QTDTOT: TAggregateField;
    Panel1: TPanel;
    Shape1: TShape;
    Panel2: TPanel;
    Shape2: TShape;
    dbeQtdTotal: TDBEditFocus;
    dbeValorTotal: TDBEditFocus;
    cdsItensUNI_DESUNI: TStringField;
    cdsItensITE_REFERE: TStringField;
    cdsItensITE_CODITE: TStringField;
    cdsItensITE_DESITE: TStringField;
    cdsItensITE_CODBAR: TStringField;
    cdsItensITE_CODGRU: TStringField;
    cdsItensITE_CODMAR: TStringField;
    cdsItensITE_DESORI: TStringField;
    cdsItensITE_CODUNI: TStringField;
    cdsItensITE_CODFOR: TStringField;
    cdsItensITE_COMLUB: TStringField;
    cdsItensITE_IDEPRO: TStringField;
    cdsItensITE_INCPIS: TStringField;
    cdsItensITE_IPISAI: TFloatField;
    cdsItensITE_VAL_RT: TFloatField;
    cdsItensITE_UNITAR: TFloatField;
    cdsItensITE_UNIORI: TFloatField;
    cdsItensITE_UNIVIS: TFloatField;
    cdsItensITE_TAXJUR: TFloatField;
    cdsItensITE_UNITMP: TFloatField;
    cdsItensITE_ENTSAI: TStringField;
    cdsItensITE_PRECUS: TFloatField;
    cdsItensITE_TOTCUS: TFloatField;
    cdsItensITE_DESCON: TFloatField;
    cdsItensITE_DESESP: TFloatField;
    cdsItensITE_DESACE: TFloatField;
    cdsItensITE_VALFRE: TFloatField;
    cdsItensITE_PREMED: TFloatField;
    cdsItensITE_TOTMED: TFloatField;
    cdsItensITE_ALQIPI: TFloatField;
    cdsItensITE_VALIPI: TFloatField;
    cdsItensITE_BASIPI: TFloatField;
    cdsItensITE_CLAFIS: TStringField;
    cdsItensABF_CODMEN: TStringField;
    cdsItensITE_PERBAS: TFloatField;
    cdsItensITE_ALQITE: TStringField;
    cdsItensITE_ALQICM: TFloatField;
    cdsItensITE_BASICM: TFloatField;
    cdsItensITE_VALICM: TFloatField;
    cdsItensABF_CODABF: TStringField;
    cdsItensABF_CODFIS: TStringField;
    cdsItensITE_VALRET: TFloatField;
    cdsItensITE_BASRET: TFloatField;
    cdsItensITE_ALQRET: TFloatField;
    cdsItensITE_PERRED: TFloatField;
    cdsItensITE_COMVAR: TFloatField;
    cdsItensITE_PESOIT: TFloatField;
    cdsItensITE_PESLIQ: TFloatField;
    cdsItensITE_DOCDEV: TStringField;
    cdsItensITE_ESPDEV: TStringField;
    cdsItensITE_EMPDEV: TStringField;
    cdsItensITE_CLAIPI: TStringField;
    cdsItensITE_LETIPI: TStringField;
    cdsItensITE_ITECHA: TStringField;
    cdsItensITE_PROEMB: TStringField;
    cdsItensITE_COMFOR: TFloatField;
    cdsItensITE_PROCUS: TFloatField;
    cdsItensITE_PROMOC: TStringField;
    cdsItensITE_PROVEN: TFloatField;
    cdsItensITE_PROCVA: TFloatField;
    cdsItensITE_AUTINC: TIntegerField;
    cdsItensITE_GPECOM: TFloatField;
    cdsItensITE_SEQIND: TIntegerField;
    cdsItensITE_NUMORC: TStringField;
    cdsItensITE_ESPORC: TStringField;
    cdsItensITE_EMPORC: TStringField;
    cdsItensITE_QTDBAI: TFloatField;
    cdsItensITE_TIPPRE: TStringField;
    btnCancelarCupom: TSpeedButton;
    Label2: TLabel;
    edtValUnitario: TCurrencyEditFocus;
    pnlStatusCaixa: TPanel;
    cdsItensAGG_AUTINC: TAggregateField;
    cdsItensITE_QTDITE: TFloatField;
    cdsItensITE_PREVE1: TFloatField;
    cdsItensITE_PREVE2: TFloatField;
    cdsItensITE_PREVE3: TFloatField;
    cdsItensITE_PREVE4: TFloatField;
    cdsItensITE_PREVE5: TFloatField;
    cdsItensITE_PREVE6: TFloatField;
    cdsItensITE_PREVE7: TFloatField;
    cdsItensITE_DESMAX: TFloatField;
    cdsItensITE_UNIDIG: TFloatField;
    cdsItensABF_CODSIT: TStringField;
    cdsItensABF_ALQICM: TFloatField;
    cdsItensABF_BASICM: TFloatField;
    cdsItensABF_MENS01: TStringField;
    cdsItensITE_ITEPED: TStringField;
    cdsItensITE_APAREL: TStringField;
    cdsItensITE_PERAPA: TFloatField;
    cdsItensITE_BENEFI: TStringField;
    cdsItensITE_PERBEN: TFloatField;
    cdsItensITE_QTDPEC: TFloatField;
    cdsItensITE_COMPEC: TFloatField;
    cdsItensITE_LARPEC: TFloatField;
    cdsItensITE_ESPPEC: TFloatField;
    cdsItensITE_QTDEXP: TFloatField;
    StaticText1: TStaticText;
    cdsItensITE_TABPRE: TStringField;
    cdsItensITE_MARMIN: TFloatField;
    cdsItensITE_MARMSG: TFloatField;
    cdsItensITE_MARMGE: TFloatField;
    cdsItensITE_DESMGE: TFloatField;
    cdsItensITE_PREULT: TFloatField;
    cdsItensITE_IMPULT: TFloatField;
    Shape6: TShape;
    StaticText2: TStaticText;
    cdsItensITE_COMATA: TFloatField;
    cdsItensITE_COMDIS: TFloatField;
    cdsItensITE_BAREMB: TStringField;
    cdsItensITE_ENTRET: TStringField;
    cdsItensITE_LOCRET: TStringField;
    cdsItensITE_NUMITE: TIntegerField;
    cdsItensITE_NUMLOT: TStringField;
    cdsItensITE_IMPFED: TFloatField;
    cdsItensITE_DESOPE: TFloatField;
    cdsItensITE_ICMSAI: TFloatField;
    cdsItensITE_OUTVAL: TFloatField;
    cdsItensITE_E_X___: TStringField;
    pnlImgPro: TPanel;
    pnlTitImgPro: TPanel;
    Panel4: TPanel;
    imgPro: TImage;
    lblTitImgPro: TLabel;
    lblErrImg: TLabel;
    cdsItensITE_DESMSU: TFloatField;
    cdsItensITE_CODVEN: TStringField;
    pnlInfVen: TPanel;
    lblInfVen: TLabel;
    btnInfVen: TSpeedButton;
    dbgItensLvl1: TcxGridLevel;
    dbgItensView: TcxGridDBTableViewCitel;
    dbgItens: TcxGridCitel;
    dbgItensCODVEN: TcxGridDBColumn;
    dbgItensCODBAR: TcxGridDBColumn;
    dbgItensDESITE: TcxGridDBColumn;
    dbgItensDESUNI: TcxGridDBColumn;
    dbgItensQTDITE: TcxGridDBColumn;
    dbgItensUNITAR: TcxGridDBColumn;
    dbgItensTOTITE: TcxGridDBColumn;
    dbgItensQTDEXP: TcxGridDBColumn;
    dbgItensITEPED: TcxGridDBColumn;
    cdsItensITE_OBRCPF: TStringField;
    cdsItensITE_PROCAT: TFloatField;
    cdsItensITE_PROCDI: TFloatField;
    cdsItensITE_SEQDET: TStringField;
    cdsItensITE_BXSBIT: TStringField;
    cdsItensITE_SEQEST: TIntegerField;
    cdsItensITE_ITEEST: TStringField;
    cdsItensITE_UNIEST: TFloatField;
    cdsItensITE_QTDSBI: TFloatField;
    cdsItensITE_UNISBI: TFloatField;
    cdsItensITE_COMPRO: TStringField;
    cxStyleRepository1: TcxStyleRepository;
    cxHeader: TcxStyle;
    cdsItensITE_DESF07: TFloatField;
    dbgItensUNIORI: TcxGridDBColumn;
    dbgItensDESCON: TcxGridDBColumn;
    cdsItensITE_SALDOS: TFloatField;
    dbgItensSALDOS: TcxGridDBColumn;
    dbgItensPROMOC: TcxGridDBColumn;
    StaticText3: TStaticText;
    shpItemPromocao: TShape;
    shpItemSemEstoque: TShape;
    StaticText9: TStaticText;
    cdsItensITE_IPIENT: TFloatField;
    cdsItensITE_FREENT: TFloatField;
    cdsItensITE_CHKOUT: TStringField;
    cdsItensITE_AGRUPA: TStringField;
    cdsItensITE_DESMVM: TFloatField;
    cdsItensITE_DESMSM: TFloatField;
    cdsItensITE_DESMGM: TFloatField;
    cdsItensITE_MARMMV: TFloatField;
    cdsItensITE_MARMMS: TFloatField;
    cdsItensITE_MARMMG: TFloatField;
    cdsIteDesEmb: TUniClientDataSet;
    cdsIteDesEmbITE_CODITE: TStringField;
    cdsIteDesEmbITB_DESCON: TFloatField;
    cdsIteDesEmbITB_QTDEMB: TFloatField;
    cdsIteDesEmbITE_QTDITE: TFloatField;
    cdsIteDesEmbITE_TABPRE: TStringField;
    cdsItensITE_QTPPRO: TFloatField;
    dbgItensTABPRE: TcxGridDBColumn;
    cdsItensITE_COMDIG: TFloatField;
    cdsItensITE_COMTB1: TFloatField;
    cdsItensITE_COMTB2: TFloatField;
    cdsItensITE_COMTB3: TFloatField;
    cdsItensITE_COMTB4: TFloatField;
    cdsItensITE_COMTB5: TFloatField;
    cdsItensITE_COMTB6: TFloatField;
    cdsItensITE_COMTB7: TFloatField;
    cdsItensITE_IMPDIR: TStringField;
    imgIndica: TcxImageList;
    cdsItensITE_QTDEMB: TFloatField;
    procedure tmrRelogioTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodBarraKeyPress(Sender: TObject; var Key: Char);
    procedure cdsItensCalcFields(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharCaixaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnFecharVendaClick(Sender: TObject);
    procedure btnCancelarCupomClick(Sender: TObject);
    procedure edtQtdKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cdsItensBeforePost(DataSet: TDataSet);
    procedure cdsItensAfterScroll(DataSet: TDataSet);
    procedure btnInfVenClick(Sender: TObject);
    procedure dbgItensViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgItensViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure imgProDblClick(Sender: TObject);
    procedure dbgItensPROMOCGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure dbgItensSALDOSGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
  private

    const
      PESO    = 'P';
      UNIDADE = 'U';

  private
    { Private declarations }
    blnFechamentoNormal: Boolean;
    blnCancelarItem: Boolean;
    blnItemEspecial: Boolean;
    blnPediuSenha: Boolean;

    intSemaforoConfirma: Integer;
    intSemaforoRegistraItem: Integer;

    strDigIni: String;
    intNumItem: Integer;

    blnSolicitaTelaDigVendedorNoF11: Boolean;
    blnPermiteMaisUmVendedorNoPedido: Boolean;

    strCodVenPedido: String;
    strVenF11: String;

    objLiberacao : TLiberacao;

    blnCarregouPedido : Boolean;
    blnVendaPresencial : Boolean;

    FcdsChkOut: TUniClientDataSet ;
    FcdsLogChk: TUniClientDataSet ;
    fatVendas: TFatVenda;

    strValGrdOri: String;

    objPromVlrMinTotalProdutos: TPromocaoVlrMinTotalProdutos;

    function fExpedicaoPendente: Boolean;
    function fCarregaEstrutura(strCodIte: String; fltQtdIte: Double; blnBaixaSubItemEstrutura: Boolean): Boolean;
    function fIniciaVenda: Boolean;

    function fConsiderarTipoDeVendaUnidadeOuPeso : Boolean;
    function fTipoDeVendaUnidadeOuPeso(strCodIte : String) : String;
    function fEhItemBalancaComDivisaoPorMil(strCodIte : String) : Boolean;

    function fProcessaItemGeral(iteTipIte    : TTipoItem;
                                strCodItePar : String;
                                fltUnitarPar,
                                fltQtdItePar : Double;
                                strFdoPromoc : String;
                                strTabPrePar : String = '';
                                strItePedPar : String = '';
                                strIdentPro  : String = 'NOR';
                                strIteEntFut : String = 'N';
                                strEntRet    : String = '';
                                strLocRet    : String = '';
                                strMotFut    : String = '';
                                strVenIte    : String = '';
                                strSeqDet    : String = '';
                                blnBaixaSubItemEstrutura : Boolean = False;
                                blnRateioProdutoEstrutura: Boolean = False;
                                intSeqInclusaoEstrutura: Integer = 0;
                                strCodItemEstrutura: String = '';
                                fltUnitarioItemEstrutura: Double = 0;
                                fltQuantidadeSubItemEstrutura: Double = 0;
                                fltUnitarioSubItemEstrutura: Double = 0;
                                strBarEmbOri: String = '';
                                strDesIteTin: String = '';
                                strCodAcaAca: String = '';
                                strCodEmpAca: String = '';
                                strAutIncFdo: String = ''): Boolean;

    procedure pCarregarFoto(strCodIte, strDesIte: String);

    Procedure pExpedeItem(strCodIte, strCodBarExp: String; fltQtdIte: Double; Out fltQtdResParaInc: Double);
    procedure pPreparaDataSet;
    procedure pCancelaItemEspecial;
    function fItemExpedicao(strCodIte, strCodBarExp: String; Out outStrCodVen: String): Boolean;
    function fPedirDesconto: Boolean;
    function fPedirDesconto_Interna(pgbStatus: TcxProgressBar): Boolean;
    function fValidaQuantidade(qryItem: TUniQuery; LfltQtdIte: Double): Boolean;
    function fGridVendaVazio: Boolean;
    function fPermiteFechar(blnItePed: Boolean = False): Boolean;

    procedure pDigitaCpfCnpj;

    function fAbrirCupom: Boolean;
    function fRegistrarItem(strCodIte, strDesIte, strUnidad: String; fltAlqIcm, fltQtdIte, fltUnitar: Double; strCodFis: String; fltTotal: Double): Boolean;
    function fCancelarCupom: Boolean;
    function fCancelarItem(intNumItem: Integer; fltQtdIte, fltUnitar: Double): Boolean;
    function fConcomitante: Boolean;

    procedure pRetificarPrecoDoItem;

    procedure pCancelaCupomCasoEstejaAberto;
    procedure pAbrirGaveta;
    procedure pFecharComDesconto;
    function fSenhaResponsavel: Boolean;
    procedure pConsultaPrecos;
    function fNaoPodeFecharForm: Boolean;
    function fInformouVendedor: Boolean;
    function fVendedorJaInformadoItensCheckout: String;

    procedure pGravarLogExclusaoItem(const strCodIte: String; const fltQtdIte: Double; strCodOpeLib: String);
    procedure pGravarLogExclusaoCancelaCupom(const strCodOpeLib: String);
    procedure pAjustaStringTransicaoCampos(Var strValGrd: String; blnLendo: Boolean);
    Procedure pCarregaConfiguracoesGrid;
    Procedure pSalvaConfiguracoesGrid;
    procedure pCarregaInformacoesParaCalculoDaAliquota(AfatVendas: TFatVenda);

    function fItemPendenteExp(Const strCodIte, strCodBarExp: String): Boolean;
    function fGetQuantRestanteExp(Const strCodIte, strCodBarExp: String): Double;
    procedure pDescontoEmbFechada(strCodIte, strTabPre: String);

    procedure pItemPdEhProAca(strCodBar: String; var strCodAcaAca, strCodEmpAca: String);
    function fRetCodIteCadAca(strCodAcaAca, strCodEmpAca: String; var strCodBarAca: String): String;
    procedure pDeletaSubItensEstrutura;
    function fPermiteConsultaNoCheckout: Boolean;
    function fValidaSaldoItem(strCodIte, strCodLot: String; fltSaldo, fltQuant: Double): Boolean;
    function fBuscaSaldoLote(strCodItem, strCodLot: String): Double;
    function fVerificaSaldoItem(strConf: String; fltSaldo, fltQuantDig: Double; strMensAviso: String): Boolean;
    function fMensagemLiberacaoProdutoSemSaldo(strNumLot, strCodIte: String; fltSaldo, fltQuant: Double): Boolean;
    function fQtdInseridaDoItem(strCodIte: String): Double;
    function fRecalculaItensPromocaoValorMinTotProdutos(strCodIte,
      strCodigoUnidadeMedida: String; blnDel: Boolean; strRshDel, strRshAut: String): Boolean;
    procedure pRecalcularItensPromocaoValorMinTotProdutos(const strCodIte, strCodUni: String;
      blnDel: Boolean; strRshDel, strRshAut: String; strRshTinAtual: String);
    procedure pAddItemSemPromocaoProValorMinTotProdutos(const strCodIte: String);
    function fVerificaPodeExcluirItemPromVlrMin(const strCodIte: String): Boolean;
    function fExcluirItensPromocaoValorMinTotProdutos(strCodIte,
      strCodigoUnidadeMedida: String; strRshDel, strRshAut: String): Boolean;
    function fAtualizarItensPromocaoVlrMin(const strCodIte, strCodigoUnidadeMedida, strRshAut: String): Boolean;
    function fAbreFormSeries(strCodIte: String; strCodEmp: String; strAutInd: String; fltQtdIte: Double): Boolean;
    procedure pExcluiSerieAposExcluirItem(strAutInc: String);
  public
    { Public declarations }
    blnConfirma: Boolean;
    strEspCfo: String;
    strCodCli: String;
    strEstCli: String;
    strTabPre: String;
    strCodCnd: String;
    strConPag  : String;
    strCodCaixa: String;
    blnCndEsp  : Boolean;
    strAutFgo: String;
    funcaoDesconto: TFuncaoDesconto;
    prcCarregaCliente: TPrcCarregaCliente;
    fltDesEspCx: Double;
    fltPorDesCx: Double;
    fltTotGerCx: Double;
    blnCalculaTaxCndF3InicioCx: Boolean;
    blnVendaPresencialSemCarregarPedOrc: Boolean;
    blnConcomitante: Boolean;
    blnDestroiObjetos: Boolean;
    objFatSerieItem: TFatSerieItem;

    intCgcCpfDigitado: Integer;
    strCpfDigitado: String;

    objCodBar: TCodigoBarras;
    strOpeRcx: String;

    qryCadCli : TUniQuery;
    strCodVen: String;

    stlItensPromoPorQtdMinQtdLim,
    stlItensParaRecalcular: TStringList;
    blnRecalcularPrecos : Boolean;
    blnUsaPromocaoComSugestaoPrecoTabelaSemPedidoCarregado: Boolean;
    blnManterPrecoDigitado: Boolean;
    blnCarregamentoSubItensConcretoAutomaticamente : Boolean;
    cdsIteCfo: TUniClientDataSet;

    function fItensExcecaoCampanha: TArrString;
    procedure pSetaCondicaoDePagamento(const strCodCnd: String);
    function fProcessaItem: Boolean;

    procedure pIniciaVenda;
    function fCarregaPedido: Boolean;
    function fRetVenSugestao: String;

    procedure pTranfereDadosCdsChkOutCdsVendas;
    procedure pDestroiObjetos;
    procedure pRecalculaPrecosSomenteItensPromo;
    procedure pRecalculaPrecosSomenteStringList(stlItens: TStringList);
    procedure pRecalculaPrecosSomentPromoVlrMin;
    procedure pRecalculaPrecos;
    function fRecalculaPrecosInterna(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pVerificaSeItensTeraoModificacaoAposCondicaoPagamento(Var blnItensEntraramOuSairamDePromocao: Boolean;
                                                                    Var blnItensTiveramUnitarModificados: Boolean);

    procedure pSetarTaxVpr(blnTaxVpr: Boolean);
    Property cdsChkOut: TUniClientDataSet read FcdsChkOut write FcdsChkOut ;
    Property cdsLogChk: TUniClientDataSet read FcdsLogChk write FcdsLogChk ;
    procedure pTransfereDadosPromocaoVlrMinAtiva;
  protected

    procedure pOnKeyDownEdits(Sender: TObject; var Key: Word; Shift: TShiftState); Override;
    procedure pEscapePressed; Override;

  end;

const
  MSG_TRAVA_PICKING_CHECKOUT = 'Para incluir itens no check-out usando wms é preciso ter um lote vinculado a uma localização Picking Check-out.' + #13 +
                               'Acerte os cadastros antes de continuar.';

var
  frmCaixa: TfrmCaixa;
  frmGravandoFechamentoVenda: TfrmGravando;

implementation

uses SysUtils, Math, untAjuda, untPanelCxItem, untConsultas,
  untPesqAux, untPnlDadosItem, untFuncoes, untFatDigCnpj, untFiscal,
  untConsultaPreco, untCadProFoto, untDigPortador, untFuncoesGenerica,
  untConstantes, untCdsDigMultLoja, untFuncoesImagem, untMostraEstruturas,
  untImagens, untIFatReservaSaldo, untTFatReservaSaldo, untIFatEntregaFutura,
  untTFatEntregaFutura, untCaixaLogCheckOut, untCaixaRecalcPrecosCheckOut,
  untCustoItemFaturamento, StrUtils, untTPickingCheckOut, untCadLote, untMsgLiberacao,
  untFatMultiSerie;

{$R *.dfm}

procedure TfrmCaixa.tmrRelogioTimer(Sender: TObject);
begin
  inherited;

  sttData.Caption := FormatDateTime('dd/mm/yyyy', VS_Date);
  sttHora.Caption := FormatDateTime('hh:mm:ss', fTime());
  FormatSettings.ThousandSeparator := #0;
end;

procedure TfrmCaixa.FormCreate(Sender: TObject);
Var
  intCont: Integer;
begin
  inherited;
  pSetaCodIte(cdsItensITE_CODITE);
  blnCarregamentoSubItensConcretoAutomaticamente := False;

  stlItensPromoPorQtdMinQtdLim := TStringList.Create;
  stlItensPromoPorQtdMinQtdLim.Sorted := True ;

  Self.stlItensParaRecalcular := Nil;

  blnCarregouPedido := False;
  blnVendaPresencial := False;
  blnVendaPresencialSemCarregarPedOrc := False;

  strOpeRcx := '';
  strCodVen := '';

  strDigIni := fCfgSis('DIGBAL');

  objLiberacao := TLiberacao.Create;

  pnlImgPro.Visible := fCfgSis('IMGPRO', VarBoolean);

  intSemaforoConfirma := -1;
  intSemaforoRegistraItem := -1;
  blnConcomitante := False;
  blnDestroiObjetos := True;
  blnUsaPromocaoComSugestaoPrecoTabelaSemPedidoCarregado := False;
  blnManterPrecoDigitado := False;
  blnCalculaTaxCndF3InicioCx := False;

  intCgcCpfDigitado := 0;
  strCpfDigitado := '';
  blnPediuSenha := False;

  blnRecalcularPrecos := False;

  { *************************************** }
  { * SOBRESCREVE AS FUNÇÕES DE KEY PRESS * }
  { ************************************AF* }
  For intCont := 0 To Self.ComponentCount - 1 Do
  Begin

    If (Self.Components[intCont] Is TDBEditFocus) Then
      TDBEditFocus(Self.Components[intCont]).OnKeyDown := pOnKeyDownEdits
    Else If (Self.Components[intCont] Is TEditFocus) Then
      TEditFocus(Self.Components[intCont]).OnKeyDown := pOnKeyDownEdits
    Else If (Self.Components[intCont] Is TCurrencyEditFocus) Then
    Begin
      If TCurrencyEditFocus(Self.Components[intCont]).Tag = 97 Then
        TCurrencyEditFocus(Self.Components[intCont]).OnKeyDown := pOnKeyDownEdits;
    End;

  End;

  blnSolicitaTelaDigVendedorNoF11 := fCfgSis('DVEF11', VarBoolean);
  strVenF11 := fCfgSis('VENF11', varString);
  blnPermiteMaisUmVendedorNoPedido := fCfgSis('VNDSPD', varBoolean);

  prcCarregaCliente := Nil;

  If fCfgSis('TIPBAR', varString) = '2' Then
    edtCodBarra.MaxLength := 43;

  cdsIteCfo := Nil;

  objPromVlrMinTotalProdutos := TPromocaoVlrMinTotalProdutos.Create;
  objPromVlrMinTotalProdutos.OpcSys := tRegSysCaixa;
end;

procedure TfrmCaixa.FormDestroy(Sender: TObject);
begin

  inherited;

  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  FreeAndNil(stlItensPromoPorQtdMinQtdLim);

  TProQtdColetiva.pLimpar;
  TProQtdColetiva.OpcSys := tRegSysGeral;

  If Assigned(objPromVlrMinTotalProdutos) Then
    FreeAndNil(objPromVlrMinTotalProdutos);
end;

procedure TfrmCaixa.edtCodBarraKeyPress(Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
  objfrmPnl: TPanelCxItem;

  qryGen: TUniQuery;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    If (Not fPermiteConsultaNoCheckout) Then
      Exit;

    Try
      qryGen := fCriaQuery(Nil);

      objfrmPnl := TPanelCxItem.New();
      objfrmPnl.strNomForm := Self.Name;
      objfrmPnl.recParametros.strCodCli := strCodCli;
      objfrmPnl.strCodVen := '';
      objfrmPnl.strCodDig := '';
      objfrmPnl.intPraMedio := 0;

      If ((fCfgSis('PRZPRO') = 'S') And (fCfgSis('USACND') = 'S')) Then
      Begin
        objFrmPnl.intPraMedio := fFloatToInt(fCalcMediaPagto(Self.strConPag));
        objFrmPnl.recParametros.strCodCnd := Self.strCodCnd;
      End;

      objfrmPnl.recParametros.strTabPre := strTabPre;
      // verificar pois de inicio vai ser fixo tabela 1

      // objfrmPnl := Nil;

      If fPesqItem(conIteCompleta, Self, edtCodBarra, Nil, qryGen, Key, arrSel, True, objfrmPnl, 'Consulta de Itens Caixa', strTabPre, '', fCampoTabela('CND_TXJURO', 'CADCND', ['CND_CODIGO'], [strCodCnd]), False, False, 0, cdrCodIte, '', False, strCodCli, strCodVen,
        True, False, True, '', False, False, False, False, True, False, False, False, '', -1, False, '', True, '', '', '', '', '', '', True, False, False, Nil, Nil,
        Self.strCodCnd) Then
      Begin

        If TPickingCheckOut.fWMSUtilizaPickingCheckOut Then
        Begin
          If TPickingCheckOut.fRetornaLotePickingCheckOut(qryGen.FieldByName('ITE_CODITE').AsString, VS_strCodEmp).IsEmpty Then
          Begin
            pMensagemSonora('', CHECKOUT_SEM_SUCESSO);
            fMensagem('ATENÇÃO!', MSG_TRAVA_PICKING_CHECKOUT, ['&Ok']);
            Exit;
          End;
        End;

        edtCodBarra.Text := fCampoTabela('BAR_CODBAR', 'ITEBAR', ['BAR_CODITE', 'BAR_PRINCI'], [qryGen.FieldByName('ITE_CODITE').AsString, 1]);

        If fEmptyStr(edtCodBarra.Text) Then
        Begin
          pMensagemSonora('', CHECKOUT_SEM_SUCESSO);
          fMensagem('ATENÇÃO!', 'Este item não possui código de barras cadastrado!', ['&O k']);
        End;
      End
      Else
        edtCodBarra.Clear;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[frmFatVendas.edtCodIteKeyPress]');
    End;

    FreeAndNil(objfrmPnl);
    FreeAndNil(qryGen);
  End;

end;

procedure TfrmCaixa.edtQtdKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If (Key = #13) Or (Key = #27) Then
  Begin
    edtQtd.Enabled := False;
    pnlStatusCaixa.Caption := 'Passe o Produto Desejado';

    If edtQtd.Value <= 0 Then
      edtQtd.Value := 1;

    If (Key = #27) And (blnItemEspecial) Then
      pCancelaItemEspecial
    Else If (blnItemEspecial) Then
      pSetFocus(edtValUnitario)
    Else
      pSetFocus(edtCodBarra);
  End;

end;

procedure TfrmCaixa.cdsItensAfterScroll(DataSet: TDataSet);
begin
  inherited;
  pCarregarFoto(DataSet.FieldByName('ITE_CODITE').AsString, DataSet.FieldByName('ITE_DESITE').AsString);
end;

procedure TfrmCaixa.cdsItensBeforePost(DataSet: TDataSet);
begin
  inherited;
  Inc(intNumItem);
  DataSet.FieldByName('ITE_NUMITE').AsInteger := intNumItem;
end;

procedure TfrmCaixa.cdsItensCalcFields(DataSet: TDataSet);
begin
  inherited;

  With DataSet Do
  Begin
    If Assigned(VS_ObjFiscal) Then
      FieldByName('ITE_TOTITE').AsFloat := VS_ObjFiscal.fCalculaTotalSistema(FieldByName('ITE_QTDITE').AsFloat, FieldByName('ITE_UNITAR').AsFloat)
    Else
      FieldByName('ITE_TOTITE').AsFloat := fFormataFloat(FieldByName('ITE_QTDITE').AsFloat * FieldByName('ITE_UNITAR').AsFloat, 2);
  End;

end;

procedure TfrmCaixa.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodBarra);
end;

procedure TfrmCaixa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  If (ModalResult <> mrOk) And (fNaoPodeFecharForm) Then
  Begin
    pMensagemOk('O cupom está aberto. Favor cancelar.');
    Action := caNone;
    Exit;
  End;

  If (Not fPermiteFechar) And (ModalResult <> mrOk) Then
  Begin
    fMensagem('ATENÇÃO!', 'VENDA NÃO FECHADA! EFETUE O FECHAMENTO DA VENDA PARA PROSSEGUIR.', ['&Ok']);
    pSetFocus(edtCodBarra);
    Action := caNone;
    Exit;
  End;

  If blnDestroiObjetos Then
    pDestroiObjetos;

  If (fVerificaAcessoSistema('frmConsultaCxGridNova', strOpeRcx)) Then
    pSalvaConfiguracoesGrid();
end;

procedure TfrmCaixa.btnFecharCaixaClick(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(strAutFgo)) And (Not fPermiteFechar(True)) Then
  Begin
    fMensagem('ATENÇÃO!', 'VENDA NÃO FECHADA! EFETUE O FECHAMENTO DA VENDA PARA PROSSEGUIR.', ['&Ok']);
    Exit;
  End;

  If fNaoPodeFecharForm Then
  Begin
    pMensagemOk('O cupom está aberto. Favor cancelar.');
    Exit;
  End;

  Close;
end;

procedure TfrmCaixa.pEscapePressed;
begin

  If Not cdsItens.IsEmpty Then
    btnFecharCaixa.Click
  Else If fNaoPodeFecharForm Then
  Begin
    pMensagemOk('O cupom está aberto. Favor cancelar.');
  End
  Else
    inherited;

end;

function TfrmCaixa.fNaoPodeFecharForm: Boolean;
begin
  Result := (fConcomitante) And (VS_ObjFiscal.EstadoECF = ecfCupomAberto);
end;

function TfrmCaixa.fCarregaPedido: Boolean;
Var
  qryFatDor: TUniQuery;
Begin
  blnCarregouPedido := False;
  Try
    Result := True;

    qryFatDor := fCriaQuery(Nil);
    qryFatDor.SQL.Clear;
    qryFatDor.SQL.Add(' SELECT FATDOR.*, EXTDOR.FDO_ENTRET, EXTDOR.FDO_LOCRET, BRIDOR.BRI_SEQDET, EXTGOR.FGO_VENPRE, EXTDOR.FDO_BAREMB ');
    qryFatDor.SQL.Add('   FROM FATDOR ');
    qryFatDor.SQL.Add('   LEFT JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ');
    qryFatDor.SQL.Add('   LEFT JOIN BRIDOR ON BRIDOR.BRI_SEQDET = FATDOR.AUTOINCREM ');
    qryFatDor.SQL.Add('   LEFT JOIN EXTGOR ON FATDOR.FDO_SEQGER = EXTGOR.FGO_SEQFGO ');
    qryFatDor.SQL.Add('  WHERE FDO_SEQGER = :SEQGER AND FDO_CODITE <> :ITESER AND FDO_CODITE <> :SERTER ');
    qryFatDor.ParamByName('SEQGER').AsString := strAutFgo;
    qryFatDor.ParamByName('ITESER').AsString := fCfgSis('ITESER');
    qryFatDor.ParamByName('SERTER').AsString := fCfgSis('SERTER');
    qryFatDor.Open;

    if (not qryFatDor.isEmpty) then
    begin
      blnCarregouPedido := True;
      blnVendaPresencial := (qryFatDor.FieldByName('FGO_VENPRE').AsString = 'S');
    end;

    qryFatDor.First;
    While Not qryFatDor.Eof Do
    Begin

      If (Not fEmptyStr(qryFatDor.FieldByName('BRI_SEQDET').AsString)) Then
      Begin
        qryFatDor.Next;
        Continue;
      End;

      If fEmptyStr(fRetCodBarra(qryFatDor.FieldByName('FDO_CODITE').AsString)) Then
      Begin
        pMensagemOk('O item: ' + qryFatDor.FieldByName('FDO_CODITE').AsString + ' está com o código de barra em branco!');
        Result := False;
        Break;
      End;

      strCodVenPedido := qryFatDor.FieldByName('FDO_CODVEN').AsString;
      
      If Not fProcessaItemGeral(itePedido,
                                qryFatDor.FieldByName('FDO_CODITE').AsString,
                                qryFatDor.FieldByName('FDO_UNITAR').AsFloat,
                                qryFatDor.FieldByName('FDO_QTDITE').AsFloat,
                                qryFatDor.FieldByName('FDO_PROMOC').AsString,
                                qryFatDor.FieldByName('FDO_TABPRE').AsString,
                                '',
                                qryFatDor.FieldByName('FDO_IDEPRO').AsString,
                                qryFatDor.FieldByName('FDO_ENTFUT').AsString,
                                qryFatDor.FieldByName('FDO_ENTRET').AsString,
                                qryFatDor.FieldByName('FDO_MOTFUT').AsString,
                                qryFatDor.FieldByName('FDO_LOCRET').AsString,
                                qryFatDor.FieldByName('FDO_CODVEN').AsString,
                                qryFatDor.FieldByName('AUTOINCREM').AsString,
                                False,
                                False,
                                0,
                                '',
                                0,
                                0,
                                0,
                                qryFatDor.FieldByName('FDO_BAREMB').AsString,
                                qryFatDor.FieldByName('FDO_DESCRI').AsString,
                                qryFatDor.FieldByName('FDO_CODACA').AsString,
                                qryFatDor.FieldByName('FDO_EMPACA').AsString,
                                qryFatDor.FieldByName('AUTOINCREM').AsString) Then
      Begin
        pMensagemOk('Ocorreu um problema na inserção dos itens');
        Result := False;
        Break;
      End;

      qryFatDor.Next;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmCaixa.fCarregaPedido]');
    End;
  End;

  FreeAndNil(qryFatDor);
End;

procedure TfrmCaixa.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Not Self.Enabled Then
    Key := 0;

  Case Key Of
    VK_F1: pCriarForm(TfrmAjuda);

    VK_F2: pConsultaPrecos;

    VK_F3: Begin
             edtQtd.Enabled := True;
             pSetFocus(edtQtd);
           End;

    VK_F4: btnCancelarCupom.Click;

    VK_F5: If Not cdsItens.IsEmpty Then
           Begin
             blnCancelarItem := True;
             pnlStatusCaixa.Caption := 'Pressione Delete para cancelar um item!';
             pSetFocus(dbgItens);
           End;

    VK_F6: btnInfVen.Click;

    VK_F7: pFecharComDesconto;

    VK_F10: Begin
              Key := 0;
              btnFecharVenda.Click;
            End;

    VK_F11: pRetificarPrecoDoItem;

    VK_F12: pAbrirGaveta;
  End;

end;

function TfrmCaixa.fInformouVendedor: Boolean;
  Var
    frmDigPortador : TfrmDigPortador;
begin
  Result := False;
  Try
    pCriarFormularios(TfrmDigPortador, frmDigPortador);
    frmDigPortador.Caption := 'Informe o vendedor para os produtos';
    frmDigPortador.edtPorBai.Enabled := False;
    frmDigPortador.edtPorBai.Visible := False;
    frmDigPortador.edtCodPorBai.Enabled := False;
    frmDigPortador.edtCodPorBai.Visible := False;
    frmDigPortador.lblPor.Visible := False;
    frmDigPortador.edtCodVen.Top := frmDigPortador.edtPorBai.Top;
    frmDigPortador.edtNomVen.Top := frmDigPortador.edtCodPorBai.Top;
    frmDigPortador.lbl1.Top := frmDigPortador.lblPor.Top;
    frmDigPortador.Height := frmDigPortador.Height - frmDigPortador.edtPorBai.Height;
    frmDigPortador.edtCodVen.Text := strVenF11;
    frmDigPortador.edtNomVen.Text := IIF(fEmptyStr(strVenF11), '', fRetNomVendRep(strVenF11));
    frmDigPortador.ShowModal;
    If (frmDigPortador.blnConfirma) And (Not fEmptyStr(frmDigPortador.edtCodVen.Text)) Then
    Begin
      strCodVen := frmDigPortador.edtCodVen.Text;
      If Assigned(fatVendas) Then
        fatVendas.strTipVen := fRetTipoOperador(strCodVen);

      if pnlInfVen.Visible then
      begin
        if Not blnPermiteMaisUmVendedorNoPedido then
        begin
          cdsItens.First;
          while not cdsItens.Eof do
          begin
            cdsItens.Edit;
            cdsItensITE_CODVEN.AsString := strCodVen;
            cdsItens.Post;

            cdsItens.Next;
          end;
        end;
      end;

      Result := True;
      If (blnConcomitante) And Assigned(VS_ObjFiscal) Then
        VS_ObjFiscal.strNomVen := strCodVen + '-' + fRetNomVendRep(strCodVen);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmCaixa.fInformouVendedor]');
    End;
  End;
  pFreeAndNil(frmDigPortador);
end;

{ *************** }
{ * INICIA TELA * }
{ ************AF* }
function TfrmCaixa.fIniciaVenda;
begin

  Try
    cdsItensITE_REFERE.Size := fTamRefere;
    cdsItens.CreateDataSet;
    cdsItens.EmptyDataSet;

    cdsIteDesEmb.CreateDataSet;
    cdsIteDesEmb.EmptyDataSet;

    pnlStatusCaixa.Caption := 'Passe o Produto Desejado!';

    edtCodBarra.ReadOnly := False;

    Result := True;

  Except
    On E: Exception Do
    Begin
      pMensagensErro('Ocorreu um erro na iniciação da tela! ' + E.Message, '');
      pnlStatusCaixa.Caption := 'E R R O! - ' + E.Message;
      edtCodBarra.ReadOnly := True;

      Result := False;
    End;
  End;

end;

procedure TfrmCaixa.FormShow(Sender: TObject);
  Var
    strPathLogo: String;
begin
  inherited;

  pCarregaConfiguracoesGrid();

  pnlInfVen.Visible := ((blnSolicitaTelaDigVendedorNoF11 And Not blnPermiteMaisUmVendedorNoPedido) And (Not blnCarregouPedido)) Or
                       ((blnSolicitaTelaDigVendedorNoF11 And blnPermiteMaisUmVendedorNoPedido));
  
  If fCfgSis('DESCND',varBoolean) Then
  Begin
    dbgItensUNIORI.Visible := True;
    dbgItensDESCON.Visible := True;
  End
  Else
  Begin
    dbgItensUNIORI.Visible := False;
    dbgItensDESCON.Visible := False;
  End;

  If fEmptyStr(strOpeRcx) Then
    strOpeRcx := strLoginUsuarioLogado;

  // Nos casos onde não solicita a tela do vendedor:
  If (Not blnSolicitaTelaDigVendedorNoF11) Or ((Not blnPermiteMaisUmVendedorNoPedido) And blnCarregouPedido) Then
  Begin
    // se importou um pedido pega o vendedor dos itens já informados
    if blnCarregouPedido then
      strCodVen := strCodVenPedido
    // Se tem sugestão usa, senão usa o operador logado no caixa!    
    else                                                                   
      strCodVen := IIF(fEmptyStr(strVenF11), strOpeRcx, strVenF11);  
      
    If (blnConcomitante) And Assigned(VS_ObjFiscal) Then
      VS_ObjFiscal.strNomVen := strCodVen + '-' + fRetNomVendRep(strCodVen);
  End
  Else If Not fEmptyStr(fVendedorJaInformadoItensCheckout()) Then
    strCodVen := fVendedorJaInformadoItensCheckout;

  sttOperador.Caption := 'Operador: ' + fRetNomVendRep(strOpeRcx);

  strPathLogo := fCfgSis('PATLOG', varString);
  If (Not fEmptyStr(strPathLogo)) Then
  Begin 
    Try
      imgLogo.Picture.LoadFromFile(strPathLogo);
    Except

    End;
  End;

  cdsItensITE_QTDITE.DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  cdsItensITE_UNITAR.DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));

  edtValUnitario.Properties.DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  edtValUnitario.Properties.EditFormat    := fMskDigitos(fCfgSis('DECUNI', varInteger));
  edtValUnitario.Properties.DecimalPlaces := fCfgSis('DECUNI', varInteger);

  pSetFocus(edtCodBarra);

  If Not fEmptyStr(VS_strTabPreCheckOut) Then
  Begin
    strTabPre := VS_strTabPreCheckOut;
    If Assigned(fatVendas) Then
      fatVendas.strTabPre := VS_strTabPreCheckOut;
  End;

  If Not fEmptyStr(strCodCnd) Then
  Begin
    If Assigned(fatVendas) Then
    Begin
      fatVendas.strCodCnd := strCodCnd;
      fatVendas.strConPag := strConPag;
      fatVendas.blnCndEsp := blnCndEsp;
      fatVendas.pAtualizaInformacoesCondPagamento;
      fatVendas.pCalculaTaxVpr;
      fatVendas.blnCarregouPedidoEAdicionandoItensF3 := blnCarregouPedido;
    End;
  End;

  If blnRecalcularPrecos Then
  Begin
    pRecalculaPrecos
  End
  Else If blnUsaPromocaoComSugestaoPrecoTabelaSemPedidoCarregado And (fCfgSis('CND_F3') = 'I') Then
  Begin
    pRecalculaPrecosSomenteItensPromo;
  End;
end;

{ **************************************** }
{ * FUNÇÃO QUE FOI SOBRESCRITA DOS EDITS * }
{ *************************************AF* }
procedure TfrmCaixa.pOnKeyDownEdits(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  If (Key = VK_Return) Then
  Begin

    If (Sender is TDBEditFocus) Or (Sender is TEditFocus) Then
    Begin

      If TDBEditFocus(Sender).Tag = 98 Then
        fProcessaItem
      Else
        pProximoControle(Sender);

    End
    Else If Sender Is TCurrencyEditFocus Then
    Begin

      If TCurrencyEditFocus(Sender).Tag = 97 Then
        // pAlteraPreco;

    End;

  End
  Else If (Key = VK_Escape) Then
  Begin

    If (Sender = edtValUnitario) And (blnItemEspecial) Then
      pCancelaItemEspecial
    Else
      pEscapePressed;

  End;

  // inherited;
end;

procedure TfrmCaixa.pDeletaSubItensEstrutura;
  Var
    intSeqEst: Integer;
    strCodIteDel: String;
begin
  cdsItens.DisableControls;
  intSeqEst := cdsItens.FieldByName('ITE_SEQEST').AsInteger;
  Try
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      If (cdsItens.FieldByName('ITE_SEQEST').AsInteger = intSeqEst) And
         //quando CFG_VENSUB = 'P', apaga somente os itens marcados com ITE_VENSUB = 'N'
         (Not fPermiteVenderSubItemEstruturaAvulso(cdsItens.FieldByName('ITE_CODITE').AsString)) Then
      Begin
        strCodIteDel := cdsItens.FieldByName('ITE_CODITE').AsString;
        pGravarLogExclusaoItem(cdsItens.FieldByName('ITE_CODITE').AsString,
                               cdsItens.FieldByName('ITE_QTDITE').AsFloat,
                               objLiberacao.strOperador);
        cdsItens.Delete;
        If (stlItensPromoPorQtdMinQtdLim.IndexOf(strCodIteDel) >= 0) Then
        Begin
          fatVendas.pLimpaDeletadosDoArrPromocaoQtdeColetiva(-1, 'PD', fGridVendaVazio, cdsItens);
          pRecalculaPrecosSomenteStringList(stlItensPromoPorQtdMinQtdLim);
        End;
      End
      Else
        cdsItens.Next;
    End;
  Finally
    cdsItens.EnableControls;
  End;
end;

procedure TfrmCaixa.pDescontoEmbFechada(strCodIte, strTabPre: String);
var
  intCnt,
  intRecNo   : Integer;
  intQtdIns,
  intQtdRes  : Double;
  strFilter  : String;
  blnFiltered: Boolean;
  prcScroll  : TprcScroll;

  function fFormataUnitarEmb(fltValEmb: Double): Double;
    Var
      strValAux: String;
  begin
    strValAux := FloatToStrF(fltValEmb, ffFixed, 12, fCfgSis('DECUNI', varInteger));
    Result := fStrToFloat(strValAux);
  end;

begin
  if fatVendas.strPromoc = 'S' then
    Exit;

  if fFormataFloat(cdsItens.FieldByName('ITE_QTDITE').AsFloat, 4) <> 1 then
    Exit;

  if fFormataFloat(cdsItens.FieldByName('ITE_QTDEMB').AsFloat, 4) <> 0 then
    Exit;

  if fatVendas.fCarregaDescontoEmbFechada(strCodIte, strTabPre, cdsIteDesEmb) then
  begin
    intRecNo    := cdsItens.RecNo;
    strFilter   := cdsItens.Filter;
    blnFiltered := cdsItens.Filtered;
    pDisableControls(cdsItens, prcScroll);
    Try
      cdsItens.Filtered := False;
      cdsItens.Filter   := 'ITE_CODITE = ' + strCodIte + ' AND ITE_ITEPED = ''N''';
      cdsItens.Filtered := True;

      intQtdIns := 0;
      For intCnt := 0 to cdsItens.RecordCount-1 do
      begin
        intQtdIns := intQtdIns + cdsItens.FieldByName('ITE_QTDITE').AsFloat;

        cdsItens.Edit;
        cdsItens.FieldByName('ITE_AGRUPA').AsString := 'N';
        cdsItens.Post;

        cdsItens.Next;
      end;

      cdsItens.Filtered := False;
      cdsItens.Filter   := 'ITE_CODITE = ' + strCodIte + ' AND ITE_ITEPED = ''N'' AND ITE_AGRUPA = ''N'' ';
      cdsItens.Filtered := True;

      cdsIteDesEmb.First;
      while not cdsIteDesEmb.Eof do
      begin
        if intQtdIns >= cdsIteDesEmb.FieldByName('ITB_QTDEMB').AsFloat then
        begin
          cdsItens.Edit;
          cdsItens.FieldByName('ITE_AGRUPA').AsString := 'S';
          cdsItens.FieldByName('ITE_QTDITE').AsFloat := cdsIteDesEmb.FieldByName('ITB_QTDEMB').AsFloat;
          cdsItens.FieldByName('ITE_UNITAR').AsFloat := fFormataUnitarEmb(edtValUnitario.Value * (1 - (fPercDescEmbalagemFechadaItem(strCodIte, strTabPre, cdsIteDesEmb.FieldByName('ITB_QTDEMB').AsFloat, '') / 100)));
          cdsItens.Post;

          intQtdIns := intQtdIns - cdsIteDesEmb.FieldByName('ITB_QTDEMB').AsFloat;

          if intQtdIns = 0 then
            Break;

          cdsIteDesEmb.First;
        end
        else
          cdsIteDesEmb.Next;
      end;

      intQtdRes := intQtdIns;

      While (intQtdRes > 0) Do
      begin
        If (cdsItens.RecordCount > 0) Then
        Begin
          intQtdRes := intQtdRes - IIF(cdsItens.RecordCount = 1, intQtdIns, 1);

          cdsItens.Edit;
          cdsItens.FieldByName('ITE_AGRUPA').AsString := 'S';
          cdsItens.FieldByName('ITE_QTDITE').AsFloat := IIF(cdsItens.RecordCount = 1, intQtdIns, 1);
          cdsItens.FieldByName('ITE_UNITAR').AsFloat := fFormataUnitarEmb(edtValUnitario.Value * (1 - (fPercDescEmbalagemFechadaItem(strCodIte, strTabPre, 1, '') / 100)));
          cdsItens.Post;

          intQtdIns := intQtdRes;
        End;
      end;

      For intCnt := 0 To cdsItens.RecordCount-1 Do
        cdsItens.Delete;
    Finally
      cdsItens.Filter   := strFilter;
      cdsItens.Filtered := blnFiltered;
      cdsItens.RecNo    := intRecNo;

      pEnableControls(cdsItens, prcScroll);
    End;
  end;
end;

procedure TfrmCaixa.pDestroiObjetos;
begin
  If cdsItens.Active Then
    cdsItens.Close;

  If cdsIteDesEmb.Active Then
    cdsIteDesEmb.Close;

  If Assigned(fatVendas) Then
    FreeAndNil(fatVendas);
end;

procedure TfrmCaixa.pExcluiSerieAposExcluirItem(strAutInc: String);
begin
  if not fCfgSis('NUMSER', varBoolean) then
    Exit;

  if not fCfgSis('NSERQT', varBoolean) then
    Exit;

  objFatSerieItem.cdsSeries.Filtered := False;
  objFatSerieItem.cdsSeries.Filter := 'AUTINC = '+ strAutInc.QuotedString + ' AND QTDSER > 0 ';
  objFatSerieItem.cdsSeries.Filtered := True;

  if objFatSerieItem.cdsSeries.RecordCount > 0 then
    objFatSerieItem.cdsSeries.Delete;

  objFatSerieItem.cdsFatSeries.Filtered := False;
  objFatSerieItem.cdsFatSeries.Filter := 'AUTINC = '+ strAutInc.QuotedString + ' AND QTDSER > 0 ';
  objFatSerieItem.cdsFatSeries.Filtered := True;

  if objFatSerieItem.cdsFatSeries.RecordCount > 0 then
    objFatSerieItem.cdsFatSeries.Delete;
end;

Procedure TfrmCaixa.pExpedeItem(strCodIte, strCodBarExp: String; fltQtdIte: Double; Out fltQtdResParaInc: Double);
Var
  prcScroll: TprcScroll;
  fltQtdRes: Double;
  fltQtqDif: Double;
  blnExpedi: Boolean;
Begin

  {*REQ.165525**********RP*}
  fltQtdRes := fGetQuantRestanteExp(strCodIte, strCodBarExp);

  If CompareValue(fltQtdIte, fltQtdRes) = GreaterThanValue Then
  Begin
    If fCfgSis('EXPF03', varBoolean) Then
    Begin
      If fMensagem('ATENÇÃO!', 'A quantidade informada é superior à quantidade restante ('+ FloatToStrF(fltQtdRes, ffNumber, 12, 4) +').'+ sLineBreak +
                   'Continua mesmo assim?', ['&Sim','&Não'], 2) = 2 Then
        Exit;
    End
    Else
    Begin
      pMensagemOk('A quantidade informada é superior à quantidade restante ('+ FloatToStrF(fltQtdRes, ffNumber, 12, 4) +').');
      Exit;
    End;
  End;

  With cdsItens Do
  Begin
    fltQtdResParaInc := 0;
    fltQtdRes := fltQtdIte;
    blnExpedi := False;

    pDisableControls(cdsItens, prcScroll);
    Try
      First;
      While Not Eof Do
      Begin
        If (fltQtdRes > 0.00) Then
        Begin
          If fItemPendenteExp(strCodIte, strCodBarExp) Then
          Begin
            If fCfgSis('EXPF03', varBoolean) Then
              blnExpedi := True;
            
            Edit;

            fltQtqDif := fFormataFloat(FieldByName('ITE_QTDITE').AsFloat, 4) -
                         fFormataFloat(FieldByName('ITE_QTDEXP').AsFloat, 4);
                         
            If (fltQtdRes > fltQtqDif) Then            
            Begin
              FieldByName('ITE_QTDEXP').AsFloat := FieldByName('ITE_QTDEXP').AsFloat + fltQtqDif;
              fltQtdRes := fltQtdRes - fltQtqDif;
            End
            Else
            Begin
              FieldByName('ITE_QTDEXP').AsFloat := FieldByName('ITE_QTDEXP').AsFloat + fltQtdRes;
              fltQtdRes := 0;
            End;

            //SÓ PARA GARANTIR
            If (fFormataFloat(FieldByName('ITE_QTDEXP').AsFloat, 4) > fFormataFloat(FieldByName('ITE_QTDITE').AsFloat, 4)) Then
            Begin
              FieldByName('ITE_QTDEXP').AsFloat := FieldByName('ITE_QTDITE').AsFloat;
            End;

            Post;
          End;
        End;

        Next;
      End;
      
    Finally
      pEnableControls(cdsItens, prcScroll);

      If blnExpedi Then
        fltQtdResParaInc := fltQtdRes;
    End;
  End;
End;

function TfrmCaixa.fRetCodIteCadAca(strCodAcaAca, strCodEmpAca: String; var strCodBarAca: String): String;
var
  qryCodIte: TUniQuery;
begin
  Result := '';

  qryCodIte := fCriaQuery;
  try
    qryCodIte.Close;
    qryCodIte.SQL.Clear;

    qryCodIte.SQL.Text :=
    ' SELECT '+
    '   ACA_CODITE, '+
    '   ACA_CODBAR  '+
    ' FROM '+
    '   CADACA '+
    ' WHERE '+
    '   ACA_CODACA = :CODACA AND '+
    '   ACA_CODEMP = :CODEMP ';

    qryCodIte.ParamByName('CODACA').AsString := strCodAcaAca;
    qryCodIte.ParamByName('CODEMP').AsString := strCodEmpAca;
    qryCodIte.Open;

    if not qryCodIte.IsEmpty then
    begin
      Result := qryCodIte.FieldByName('ACA_CODITE').AsString;
      strCodBarAca := qryCodIte.FieldByName('ACA_CODBAR').AsString;
    end;

  finally
    FreeAndNil(qryCodIte);
  end;

end;

function TfrmCaixa.fAbreFormSeries(strCodIte: String; strCodEmp: String; strAutInd: String; fltQtdIte: Double):Boolean;
  Var
    frmFatMultiSerie: TfrmFatMultiSerie;
begin
  Result := False;
  pCriarFormularios(TfrmFatMultiSerie, frmFatMultiSerie);
  Try
    objFatSerieItem.AutoincItem := strAutInd;
    objFatSerieItem.pFiltraDataSet;

    If objFatSerieItem.cdsFatSeries.IsEmpty Then
    Begin
      objFatSerieItem.cdsSeries.Filtered := False;
      objFatSerieItem.pCarregaSeriesItem(strCodIte, strCodEmp);
    End;

    frmFatMultiSerie.pAlimentaCdsSeries(objFatSerieItem.cdsFatSeries);
    frmFatMultiSerie.fltQtdItemPed := fltQtdIte;
    frmFatMultiSerie.ShowModal;

    If frmFatMultiSerie.ModalResult <> mrOk Then
      Exit;

    objFatSerieItem.pApagaSeries;

    frmFatMultiSerie.cdsSeries.First;
    While Not frmFatMultiSerie.cdsSeries.Eof Do
    Begin
      If (frmFatMultiSerie.cdsSeriesQTDSER.AsFloat > 0) Then
      Begin
        objFatSerieItem.pInsereSerie(frmFatMultiSerie.cdsSeriesNUMSER.AsString,
                                     frmFatMultiSerie.cdsSeriesQTDSER.AsFloat);

        objFatSerieItem.pInsereSerieParaGravacao(frmFatMultiSerie.cdsSeriesNUMSER.AsString,
                                                 frmFatMultiSerie.cdsSeriesQTDSER.AsFloat);

        Result := True;
      End;

      frmFatMultiSerie.cdsSeries.Next;
    End;
  Finally
    pFreeAndNil(frmFatMultiSerie);
  End;
end;

{ ********************** }
{ * INSERE ITEM NO CDS * }
{ *******************AF* }
function TfrmCaixa.fProcessaItemGeral(iteTipIte    : TTipoItem;
                                      strCodItePar : String;
                                      fltUnitarPar,
                                      fltQtdItePar : Double;
                                      strFdoPromoc : String;
                                      strTabPrePar : String = '';
                                      strItePedPar : String = '';
                                      strIdentPro  : String = 'NOR';
                                      strIteEntFut : String = 'N';
                                      strEntRet    : String = '';
                                      strLocRet    : String = '';
                                      strMotFut    : String = '';
                                      strVenIte    : String = '';
                                      strSeqDet    : String = '';
                                      blnBaixaSubItemEstrutura : Boolean = False;
                                      blnRateioProdutoEstrutura: Boolean = False;
                                      intSeqInclusaoEstrutura: Integer = 0;
                                      strCodItemEstrutura: String = '';
                                      fltUnitarioItemEstrutura: Double = 0;
                                      fltQuantidadeSubItemEstrutura: Double = 0;
                                      fltUnitarioSubItemEstrutura: Double = 0;
                                      strBarEmbOri: String = '';
                                      strDesIteTin: String = '';
                                      strCodAcaAca: String = '';
                                      strCodEmpAca: String = '';
                                      strAutIncFdo: String = ''): Boolean;
Var
  qryPesqItens: TUniQuery;
  qryPesqItGer: TUniQuery;
  qryConAbf: TUniQuery;
  strCodBar: String;
  strTipAbf: String;
  blnUniEspecial: Boolean;

  fltPreCus: Double;
  fltUnitar: Double;
  fltUniVis: Double;
  fltTaxJur: Double;
  fltUniOri: Double;
  fltVal_RT: Double;
  fltQtdIte: Double;
  fltDesCon: Double;

  blnPromoColet: Boolean;
  blnParticiona: Boolean;
  blnPromo: Boolean;
  fltQtdDis: Double;
  blnBuscaCodBar: Boolean;
  fltDesMax: Double;
  strNumLot: String;
  blnLoteOK: Boolean;
  intResMen: Integer;
  fltSaldos: Double;
  strLotePR: String;
  objIteBar: TIteBar;
  strCodIteUni, strCodGruUni: String;
  fltQtdIteUni: Double;
  intPrzMed: Integer;
  strCodVenLocal: String;
  strCodBarExp: String;
  fltQtdIteExp: Double;

  blnCodBarEmb : Boolean;
  strConPagAux : String;
  fltQtdResParaInc: Double;

  LintChkOut : Integer ;

  fltQtdIteEmb: Double;

  strCodBarAca: String;

  dadosPromocao: TDadosPromocao;

  prcScroll: TprcScroll;
  fltUniLot : Double;

  Function fImprimeLista: String;
  Begin
    Result := fCampoTabela('ITE_IMPLIS', 'ITEGER', ['ITE_CODITE','ITE_CODEMP'], [qryPesqItens.FieldByName('ITE_CODITE').AsString, VS_strCodEmp]);
  End;

  function fUsouExpedicaoServicos: Boolean;
  begin
    Result := False;
    If fCfgSis('AUTCEN', VarBoolean) And fCfgSis('USAEXS', VarBoolean) Then
      Result := Not fEmptyStr(fCampoTabela('FGO_CODS01', 'FATGOR', ['AUTOINCREM'], [strAutFgo]));
  end;

  procedure pAplicaRegrasCondicoesDePagamento;
  var
    fltJuros: Double;
    fltUnitarNovo: Double;
  begin
    if fltTaxJur <> 0 then
      Exit;

    If (fatVendas.fZerarTaxaDeJurosValorAPrazo()) Then
      Exit;

    if (fCfgSis('CNDVEN') = 'I') then
      Exit;

    fatVendas.pAtualizaInformacoesCondPagamento;
    If fatVendas.fPermiteAplicarJurosNaPromocao(fatVendas.strPromoc) And (fAplicarTaxaJurosPrecoDigitado) Then
      Exit;

    if fatVendas.fltTxJCnd = 0 then
      Exit;

    fltJuros := fltUniOri * (fatVendas.fltTxJCnd / 100.0);
    fltJuros := fFormataFloatInterna(fltJuros, 2);

    fltUnitarNovo := edtValUnitario.Value + fltJuros;
    fltUnitar := fltUnitarNovo;

    edtValUnitario.Text := FloatToStrF(fltUnitarNovo, ffFixed, 12, fCfgSis('DECUNI', varInteger));
  end;

  function fVerificarSeFormaPagamentoPedidoEhCartao: Boolean;
  const
    strFORMA_PAGAMENTO_CARTAO = '007';
  begin
    if not fatVendas.strCodFpg.IsEmpty then
      exit(False);

    if not fCfgSis('USAFPG', varBoolean) then
      exit(False);

    if fatVendas.strCodCnd.IsEmpty then
      exit(False);

    result := strFORMA_PAGAMENTO_CARTAO = fCampoTabela('CND_CODFPG',
                                                       'CADCND',
                                                       ['CND_CODIGO'],
                                                       [fatVendas.strCodCnd]);
  end;

  function fRetLoteItem(strCodIte : String) : String;
  begin

    If TPickingCheckOut.fWMSUtilizaPickingCheckOut Then
      Exit(TPickingCheckOut.fRetornaLotePickingCheckOut(strCodIte, VS_strCodEmp));

    Result := fatVendas.objCadLot.fRetArmazemPrincipalVenda(strCodIte);

  end;

begin
  Result := True;
  blnBuscaCodBar := True;
  blnUniEspecial := False;
  strNumLot := '';
  blnLoteOK := False;

  Try
    Try
      qryPesqItens := fCriaQuery(Nil);
      qryPesqItGer := fCriaQuery(Nil);
      qryConAbf := fCriaQuery(Nil);

      If (Not fEmptyStr(strCodItePar)) And (strCodItePar <> '000000000000000') Then
      Begin

        if (not fEmptyStr(strCodAcaAca)) and (not fEmptyStr(strCodEmpAca)) then
          strCodBar := fRetCodIteCadAca(strCodAcaAca, strCodEmpAca, strCodBarAca)
        else
          strCodBar := strCodItePar;

        // É Codigo de barras Originado da Balança.
        If (iteTipIte = iteDigitado) And (strCodBar[1] = strDigIni) And (fItemBalanca(Copy(strCodBar, 3, 5))) Then
        Begin
          edtQtd.Value := StrToIntDef(Copy(strCodBar, 8, 5), 0);
          strCodBar := Copy(strCodBar, 3, 5);
          blnBuscaCodBar := False;

          If fEhItemBalancaComDivisaoPorMil(strCodBar) Then
          Begin
            edtQtd.Value := edtQtd.Value / 1000;
          End;

        End;

        If (iteTipIte In [iteDigitado, iteRetificacaoPreco]) Then
        Begin
          If (Not fCfgSis('VENVID', varBoolean)) And
             (Not fCfgSis('VENMAD', varBoolean)) Then
          Begin
            If (fStrToFloat(edtQtd.Text) > 999999) Then
            Begin
              Result := False;
              pMensagemSonora('', CHECKOUT_SEM_SUCESSO);
              fMensagem('ATENÇÃO!', 'Quantidade não permitida.', ['&Ok']);
              Exit;
            End;
          End;
        End;

        If (iteTipIte = itePedido) Then
          blnBuscaCodBar := False;

        If (fCfgSis('ETIDIF', varBoolean)) And blnBuscaCodBar Then
        Begin
          try
          objIteBar := TIteBar.Create;
          If objIteBar.fLerCodigoBarrasUnidades(strCodBar,strCodIteUni, strCodGruUni, fltQtdIteUni) Then
          Begin
            blnBuscaCodBar := false;
            edtQtd.Text    := floattostr(fltQtdIteUni);
          End;
          finally
            freeAndNil(objIteBar);
          end;
          if blnBuscaCodBar then
            strCodIteUni := strCodBar;
          pPesquisaCadIte(Nil, qryPesqItens, strCodIteUni, '', blnBuscaCodBar, False, True, True, False, False, False, False, True);
        End
        Else
        Begin
          If (iteTipIte = iteDigitado) And (Not fPermiteConsultaNoCheckout) And (Length(strCodBar) <= fTamCodIte) Then
          Begin
            Result := False;
            fMensagem('', 'Digite um código de barras válido!', ['&OK']);
            Exit;
          End;

          pPesquisaCadIte(Nil, qryPesqItens, strCodBar, '', blnBuscaCodBar, False, True, True, False, False, False, False, True);
        End;

        If Not qryPesqItens.IsEmpty Then
        Begin
          blnCodBarEmb := blnBuscaCodBar And (qryPesqItens.RecordCount = 1) And
                          (qryPesqItens.FieldByName('BAR_EMBALA').AsFloat > 1);

          If TPickingCheckOut.fWMSUtilizaPickingCheckOut Then
          Begin
            If TPickingCheckOut.fRetornaLotePickingCheckOut(strCodItePar, VS_strCodEmp).IsEmpty Then
            Begin
              pMensagemSonora('', CHECKOUT_SEM_SUCESSO);
              fMensagem('ATENÇÃO!', MSG_TRAVA_PICKING_CHECKOUT, ['&Ok']);
              Exit(False);
            End;
          End;

          If (fCfgSis('ILIEMP', VarBoolean)) And (fImprimeLista='N') Then
          Begin
            Result := False;
            pMensagemSonora('', CHECKOUT_SEM_SUCESSO);
            fMensagem('', 'Este produto ( ' + strCodItePar + ' ) não está autorizado a ser vendido por esta empresa ( '+ VS_strCodEmp +' ).', ['&ESC-Cancela'], 1, True);
            Exit;
          End;

          If (fCfgSis('EXIACA', VarBoolean)) Then
          Begin
            If SameText(qryPesqItens.FieldByName('DEP_PROACA').AsString, 'N') Then
            Begin
              Result := False;
              pMensagemSonora('', CHECKOUT_SEM_SUCESSO);
              fMensagem('', 'Não é possível vender o produto (' + strCodItePar + ') pois ele não é um produto acabado!', ['&ESC-Cancela'], 1, True);
              Exit;
            End;
          End;

          If (iteTipIte In [iteDigitado, iteRetificacaoPreco]) Then
          Begin
            If (Frac(fStrToFloat(edtQtd.Text)) <> 0) And fItemNaoFracionavel('VN', qryPesqItens.FieldByName('ITE_CODUNI').AsString) Then
            Begin
              Result := False;
              pMensagemSonora('', CHECKOUT_SEM_SUCESSO);
              fMensagem('', 'Não é permitido informar valor fracionado para esse item!', ['&ESC-Cancela'], 1, True);
              Exit;
            End;
            If (Not fPermiteFazerVenda(qryPesqItens.FieldByName('ITE_CODITE').AsString, VS_strCodEmp)) Then
            Begin
              Result := False;
              pMensagemSonora('', CHECKOUT_SEM_SUCESSO);
              fMensagem('', MSG_TRAVA_PRECO_VENDA_DINAMICA, ['&OK']);
              Exit;
            End;
          End;

          If fCfgSis('UTIFMP', varBoolean) And fFornecedorNaoPermitidoParaCliente(strCodCli, qryPesqItens.FieldByName('ITE_CODFOR').AsString) Then
          Begin
            pMensagemOk('Fornecedor: ' + qryPesqItens.FieldByName('ITE_CODFOR').AsString + ' - ' +
                        fRetNomFornecedor(qryPesqItens.FieldByName('ITE_CODFOR').AsString) +
                        ' não permitido para o Cliente!');
            Result := False;
            Exit;
          End;

          If fCfgSis('UTIFMP', varBoolean) And fMarcaNaoPermitidoParaCliente(strCodCli, qryPesqItens.FieldByName('ITE_CODMAR').AsString) Then
          Begin
            pMensagemOk('Marca: ' + qryPesqItens.FieldByName('ITE_CODMAR').AsString + ' - ' +
                        fRetNomMarca(qryPesqItens.FieldByName('ITE_CODMAR').AsString) +
                        ' não permitida para o Cliente!');
            Result := False;
            Exit;
          End;

          If fUsaRotinaWMS Then
          Begin

            strLotePR := fRetLoteItem(qryPesqItens.FieldByName('ITE_CODITE').AsString);

            If (Not fatVendas.objCadLot.fExisteLote(qryPesqItens.FieldByName('ITE_CODITE').AsString, VS_strCodEmp)) Or
               (Not fatVendas.objCadLot.fExisteLotePrincipalVenda(qryPesqItens.FieldByName('ITE_CODITE').AsString, VS_strCodEmp)) Then
            Begin
              Result := False;
              pMensagemSonora('', CHECKOUT_SEM_SUCESSO);
              fMensagem('', 'O produto informado possui vinculo com ' + fatVendas.objCadLot.strTitImp + Chr(13) +
                            'Favor informar um ' + fatVendas.objCadLot.strTitImp + ' principal para vendas no check-out! ' + Chr(13) +
                            'Caminho: Principal -> Manutenção de Cadastros -> Produtos - ' + fatVendas.objCadLot.strTitImp, ['&OK']);
              Exit;
            End;

            If strLotePR = 'A DEFINIR' Then
            Begin
              Result := False;
              pMensagemSonora('', CHECKOUT_SEM_SUCESSO);
              fMensagem('', 'O ' + fatVendas.objCadLot.strTitImp + ' do produto informado esta definido como "A DEFINIR"'+  Chr(13) +
                            'Favor informar um ' + fatVendas.objCadLot.strTitImp + ' principal para vendas válido no check-out! ' + Chr(13) +
                            'Caminho: Principal -> Manutenção de Cadastros -> Produtos - ' + fatVendas.objCadLot.strTitImp, ['&OK']);
              Exit;
            End;

            fltSaldos := fatVendas.objCadLot.fSaldoLote(qryPesqItens.FieldByName('ITE_CODITE').AsString, VS_strCodEmp, strLotePR);

            If fUsaQtdPendenteEntregaFutura Then
              fltSaldos := fltSaldos + TEntregaFutura.New(
                                         TParamEF.New()
                                           .CodIte(qryPesqItens.FieldByName('ITE_CODITE').AsString)
                                           .CodEmp(VS_strCodEmp)
                                           .Lote(strLotePR)
                                           .Faturamento(True)
                                         ).Total();

              fltSaldos := fltSaldos - TSaldoReservado.New(
                                       TReservaParametros.New()
                                         .EmpresaItem(VS_strCodEmp)
                                         .CodigoItem(qryPesqItens.FieldByName('ITE_CODITE').AsString)
                                         .NumeroLote(strLotePR)
                                         .CodEmpresa(VS_strCodEmp)
                                         .NumeroDocumento(fatVendas.strNumOrc)
                                         .TipoFiltroDocumento(tfdIgnorarDocumento)
                                         .DesconsideraPedidosCorte(Not fatVendas.blnPedCorte)
                                         .DesconsideraPedidosEnderecamento(True)
                                         .TipoReserva(trsPedidoVenda)
                                       ).fGetQuantidade();

            If fStrToFloat(edtQtd.Text) > fltSaldos Then
            Begin
              Result := False;
              pMensagemSonora('', CHECKOUT_SEM_SUCESSO);
              fMensagem('', 'Verifique o saldo do ' + fatVendas.objCadLot.strTitImp + ': "'+strLotePR+'" do produto informado', ['&OK']);
              Exit;
            End;

          End;


          If (fCfgSis('CNDPES', VarBoolean)) Then
          Begin
            If Assigned(fatVendas) Then
            Begin
              If (Not fEmptyStr(fatVendas.strCodCnd)) and (fatVendas.blnCndEsp) then
              Begin
                if (not fatVendas.fItemCondicaoEspecial(qryPesqItens.FieldByName('ITE_CODITE').AsString,strCodCnd)) then
                Begin
                  fMensagem('', 'Este produto não poderá ser vendido na condição de pagamento escolhida. Favor Verificar.', ['&OK']);
                  Exit;
                End;
              End;
            End;
          End;

          Repeat
            If (fatVendas.objCadLot.fExisteLote(qryPesqItens.FieldByName('ITE_CODITE').AsString, VS_strCodEmp)) And
              (Not fatVendas.objCadLot.fExisteLotePrincipalVenda(qryPesqItens.FieldByName('ITE_CODITE').AsString, VS_strCodEmp)) Then
            Begin
              Result := False;
              intResMen := fMensagem('', 'O produto informado possui vinculo com ' + fatVendas.objCadLot.strTitImp + Chr(13) + 'Favor informar um ' + fatVendas.objCadLot.strTitImp +
                ' principal para vendas no check-out! ' + Chr(13) + 'Caminho: Principal -> Manutenção de Cadastros -> Produtos - ' + fatVendas.objCadLot.strTitImp + Chr(13) +
                'Pressione [ENTER] para continuar ou [ESC] para cancelar', ['&Continuar', 'C&ancelar'], 1, True);

              Case intResMen Of
                0,
                2: blnLoteOK := True
              Else
                blnLoteOK := False;
              End;
            End

            Else If (fCfgSis('VINAF3', varBoolean)) And (fatVendas.objCadLot.fExisteLote(qryPesqItens.FieldByName('ITE_CODITE').AsString, VS_strCodEmp)) Then
            Begin
              If (Not fatVendas.objCadLot.fExisteLote(qryPesqItens.FieldByName('ITE_CODITE').AsString, VS_strCodEmp, fCampoTabela('CAX_CODAMZ', 'CADCAX', ['CAX_CODCAX', 'CAX_CODEMP'], [strCodCaixa, VS_strCodEmp]))) Then
              Begin
                Result := False;
                fMensagem('', 'Item '+qryPesqItens.FieldByName('ITE_CODITE').AsString+' não possui o Armazém configurado para o Caixa '+strCodCaixa+' (CADCAX.CAX_CODCAX).', ['&OK']);
                Exit;
              End
              Else
              Begin
                Result := True;
                blnLoteOK := True;
                strNumLot := fCampoTabela('CAX_CODAMZ', 'CADCAX', ['CAX_CODCAX', 'CAX_CODEMP'], [strCodCaixa, VS_strCodEmp]);
              End;
            End

            Else If (fatVendas.objCadLot.fExisteLote(qryPesqItens.FieldByName('ITE_CODITE').AsString, VS_strCodEmp)) Then
            Begin
              Result := True;
              blnLoteOK := True;
              strNumLot := fatVendas.objCadLot.fRetArmazemPrincipalVenda(qryPesqItens.FieldByName('ITE_CODITE').AsString);
            End
            Else
            Begin
              Result := True;
              blnLoteOK := True;
            End;
          Until (blnLoteOK = True);

          If (Result) Then
          Begin

            With qryPesqItGer Do
            Begin
              Close;
              SQL.Clear;
              SQL.Add('SELECT * FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP');
              ParamByName('CODITE').AsString := qryPesqItens.FieldByName('ITE_CODITE').AsString;
              ParamByName('CODEMP').AsString := VS_strCodEmp;
              Open;
            End;

            blnUniEspecial := False;
            If (Not blnItemEspecial) Then
              blnItemEspecial := (Pos('ITEM ESPECIAL', qryPesqItens.FieldByName('ITE_DESITE').AsString) > 0)
            Else
            Begin
              blnItemEspecial := False;
              blnUniEspecial := True;
            End;

            If (iteTipIte = iteDigitado) And (blnItemEspecial) Then
            Begin
              edtQtd.Enabled := True;
              edtValUnitario.Enabled := True;
              edtValUnitario.Properties.ReadOnly := False;
              edtValUnitario.Value := qryPesqItGer.FieldByName('ITE_PREVE1').AsFloat;
              pSetFocus(edtQtd);
              Exit;
            End;
          End;

          fltUnitar := 0;
          fltQtdIte := 0;

          Case iteTipIte Of
            iteDigitado: fltQtdIte := fStrToFloat(edtQtd.Text);
            itePedido,
            iteEstrutura,
            iteRetificacaoPreco: Begin
                                   fltQtdIte := fltQtdItePar;
                                   fltUnitar := fltUnitarPar;
                                 End;
          End;

          strCodBarExp := '';
          fltQtdIteExp := fltQtdIte;

          If (Not (fCfgSis('EXPF11', VarBoolean))) Then
          Begin
            If (iteTipIte In [iteDigitado]) Then
            Begin
              If (blnBuscaCodBar) And (Not fEmptyStr(strCodBar)) Then
              Begin
                strCodBarExp := strCodBar;
                If (qryPesqItens.FieldByName('BAR_EMBALA').AsFloat > 0.00) Then
                  fltQtdIteExp := fltQtdIteExp * qryPesqItens.FieldByName('BAR_EMBALA').AsFloat;
              End;
            End;
          End;

          fltQtdResParaInc := 0;
          Repeat
            If fCfgSis('EXPF03', varBoolean) Then
              strCodBarExp := '';

            If fItemExpedicao(qryPesqItens.FieldByName('ITE_CODITE').AsString, IIF(fEmptyStr(strCodBarAca), strCodBarExp, strCodBarAca), strCodVenLocal) And
              (iteTipIte In [iteDigitado]) Then
              pExpedeItem(qryPesqItens.FieldByName('ITE_CODITE').AsString, IIF(fEmptyStr(strCodBarAca), strCodBarExp, strCodBarAca), fltQtdIteExp, fltQtdResParaInc)
            Else
            Begin
              If (iteTipIte = iteDigitado) And (not fEmptyStr(strCodBarAca)) Then
              Begin
                fMensagem('Atenção', 'Não é permitido adicionar um produto acabado através do Check-Out!', ['&Ok']);
                Break;
              End;

              If fCfgSis('TIPABF') = '1' Then
                pPesquisaAbfIcm(Nil, qryConAbf, qryPesqItens.FieldByName('ITE_CODABF').AsString, strEstCli)
              Else
                pPesquisaAbfIcm(Nil, qryConAbf, qryPesqItGer.FieldByName('ITE_CODABF').AsString, strEstCli);

              strTipAbf := fGetTipoAbfCliente(strCodCli);

              pnlStatusCaixa.Caption := qryPesqItens.FieldByName('ITE_DESITE').AsString;

              If fItemExpedicao(qryPesqItens.FieldByName('ITE_CODITE').AsString, strCodBarExp, strCodVenLocal) And (iteTipIte In [iteDigitado]) Then
                pExpedeItem(qryPesqItens.FieldByName('ITE_CODITE').AsString, strCodBarExp, fltQtdIteExp, fltQtdResParaInc)
              Else
              Begin
                fltQtdIteEmb := 0;

                If (iteTipIte = iteDigitado) Then
                Begin
                  If (qryPesqItens.FieldByName('BAR_EMBALA').AsFloat > 0.00) Then
                    fltQtdIteEmb := fltQtdIte * qryPesqItens.FieldByName('BAR_EMBALA').AsFloat;

                  If (Not fValidaSaldoItem(qryPesqItens.FieldByName('ITE_CODITE').AsString,
                    strNumLot, qryPesqItens.FieldByName('ITE_SALDOS').AsFloat-IIF(qryPesqItens.FieldByName('ITE_SALEXT').AsFloat < 0, 0, qryPesqItens.FieldByName('ITE_SALEXT').AsFloat), IIF(fltQtdIteEmb > 0, fltQtdIteEmb, fltQtdIte))) Then
                  Begin
                    Result := False;
                    Exit;
                  End;
                End;

                if cdsItens.IsEmpty then
                  cdsIteDesEmb.EmptyDataSet;

                If (fCfgSis('NUMSER', VarBoolean) And fCfgSis('NSERQT', VarBoolean) And (iteTipIte = iteDigitado)) Then
                Begin
                  If fProdutoUsaNumeroDeSerie(qryPesqItens.FieldByName('ITE_CODITE').AsString, VS_strCodEmp) Then
                  Begin
                    If Assigned(fatVendas) Then
                    Begin
                      If (Not fAbreFormSeries(qryPesqItens.FieldByName('ITE_CODITE').AsString,
                                              VS_strCodEmp,
                                              IntToStr(IfNull(cdsItensAGG_AUTINC.Value, 0) +1),
                                              fStrToFloat(edtQtd.Text))) Then
                      Begin
                        fMensagem('', 'Nenhuma série foi selecionada!', ['&OK']);
                        Result := False;
                        Exit;
                      End;
                    End;
                  End;
                End;

                pDisableControls(cdsItens, prcScroll);
                try
                  With cdsItens Do
                  Begin

                    fatVendas.pCarregaValoresCusto(qryPesqItGer.FieldByName('ITE_CODITE').AsString,
                                                   qryPesqItGer.FieldByName('ITE_CODEMP').AsString,
                                                   IIF(fEmptyStr(strTabPrePar), strTabPre, strTabPrePar));

                    cdsItens.Append;
                    cdsItens.FieldByName('ITE_AUTINC').AsInteger:= IfNull(cdsItensAGG_AUTINC.Value, 0) +1;
                    cdsItens.FieldByName('ITE_BXSBIT').AsString := IIF(blnBaixaSubItemEstrutura, 'S', 'N');
                    cdsItens.FieldByName('ITE_ITEEST').AsString := strCodItemEstrutura;
                    cdsItens.FieldByName('ITE_SEQEST').AsInteger:= intSeqInclusaoEstrutura;
                    cdsItens.FieldByName('ITE_UNIEST').AsFloat  := fltUnitarioItemEstrutura;
                    cdsItens.FieldByName('ITE_QTDSBI').AsFloat  := fltQuantidadeSubItemEstrutura;
                    cdsItens.FieldByName('ITE_UNISBI').AsFloat  := fltUnitarioSubItemEstrutura;
                    cdsItens.FieldByName('ITE_CODVEN').AsString := strVenIte;
                    cdsItens.FieldByName('ITE_NUMLOT').AsString := strNumLot;
                    cdsItens.FieldByName('ITE_CODITE').AsString := qryPesqItens.FieldByName('ITE_CODITE').AsString;
                    cdsItens.FieldByName('ITE_CODGRU').AsString := qryPesqItens.FieldByName('ITE_CODGRU').AsString;
                    cdsItens.FieldByName('ITE_DESORI').AsString := qryPesqItens.FieldByName('ITE_DESITE').AsString;
                    cdsItens.FieldByName('ITE_IMPDIR').AsString := qryPesqItGer.FieldByName('ITE_IMPDIR').AsString;

                    If (iteTipIte = itePedido) Then
                    Begin
                      if not fEmptyStr(strCodBarAca) then
                        cdsItens.FieldByName('ITE_CODBAR').AsString := strCodBarAca
                      else
                        cdsItens.FieldByName('ITE_CODBAR').AsString := IIF(fEmptyStr(strBarEmbOri), fRetCodBarra(strCodBar), strBarEmbOri)
                    End
                    Else
                      cdsItens.FieldByName('ITE_CODBAR').AsString := strCodBar;

                    cdsItens.FieldByName('ITE_CODMAR').AsString := qryPesqItens.FieldByName('ITE_CODMAR').AsString;
                    cdsItens.FieldByName('ITE_DESITE').AsString := ifthen(((strIdentPro <> 'NOR') or (not fEmptyStr(strCodAcaAca)) ), strDesIteTin, qryPesqItens.FieldByName('ITE_DESITE').AsString);
                    cdsItens.FieldByName('ITE_REFERE').AsString := qryPesqItens.FieldByName('ITE_REFERE').AsString;
                    cdsItens.FieldByName('UNI_DESUNI').AsString := fRetSiglaUnidade(qryPesqItens.FieldByName('ITE_CODUNI').AsString);

                    If fCfgSisL('IMPREF', VarBoolean) And (Not fEmptyStr(cdsItens.FieldByName('ITE_REFERE').AsString)) Then
                    Begin
                      If (fCfgSis('MONDES', varString) = '1') Then
                        cdsItens.FieldByName('ITE_DESITE').AsString := cdsItens.FieldByName('ITE_DESITE').AsString + ' - ' + cdsItens.FieldByName('ITE_REFERE').AsString
                      Else
                        cdsItens.FieldByName('ITE_DESITE').AsString := cdsItens.FieldByName('ITE_REFERE').AsString + ' - ' + cdsItens.FieldByName('ITE_DESITE').AsString;
                    End;

                    if (fCfgSis('ALTCOM', varBoolean)) and (fCfgSis('TCOPRO') = '3') then
                    begin
                      cdsItens.FieldByName('ITE_QTPPRO').AsFloat := qryPesqItGer.FieldByName('ITE_QTPPRO').AsFloat;
                    end
                    else
                    begin
                      cdsItens.FieldByName('ITE_QTPPRO').AsFloat := 0;
                    end;

                    cdsItens.FieldByName('ITE_CODUNI').AsString := qryPesqItens.FieldByName('ITE_CODUNI').AsString;
                    cdsItens.FieldByName('ITE_CODFOR').AsString := qryPesqItens.FieldByName('ITE_CODFOR').AsString;
                    cdsItens.FieldByName('ITE_ENTSAI').AsString := 'S';
                    cdsItens.FieldByName('ITE_IDEPRO').AsString := 'NOR';
                    cdsItens.FieldByName('ITE_PREULT').AsFloat := qryPesqItGer.FieldByName('ITE_PREULT').AsFloat;
                    cdsItens.FieldByName('ITE_IMPULT').AsFloat := qryPesqItGer.FieldByName('ITE_IMPULT').AsFloat;
                    cdsItens.FieldByName('ITE_PREVE1').AsFloat := qryPesqItGer.FieldByName('ITE_PREVE1').AsFloat;
                    cdsItens.FieldByName('ITE_PREVE2').AsFloat := qryPesqItGer.FieldByName('ITE_PREVE2').AsFloat;
                    cdsItens.FieldByName('ITE_PREVE3').AsFloat := qryPesqItGer.FieldByName('ITE_PREVE3').AsFloat;
                    cdsItens.FieldByName('ITE_PREVE4').AsFloat := qryPesqItGer.FieldByName('ITE_PREVE4').AsFloat;
                    cdsItens.FieldByName('ITE_PREVE5').AsFloat := qryPesqItGer.FieldByName('ITE_PREVE5').AsFloat;
                    cdsItens.FieldByName('ITE_PREVE6').AsFloat := qryPesqItGer.FieldByName('ITE_PREVE6').AsFloat;
                    cdsItens.FieldByName('ITE_PREVE7').AsFloat := qryPesqItGer.FieldByName('ITE_PREVE7').AsFloat;

                    cdsItens.FieldByName('ITE_DESMAX').AsFloat := qryPesqItGer.FieldByName('ITE_DESMAX').AsFloat;
                    cdsItens.FieldByName('ITE_DESMGE').AsFloat := qryPesqItGer.FieldByName('ITE_DESMGE').AsFloat;
                    cdsItens.FieldByName('ITE_DESMSU').AsFloat := qryPesqItGer.FieldByName('ITE_DESMSU').AsFloat;
                    cdsItens.FieldByName('ITE_DESMVM').AsFloat := qryPesqItGer.FieldByName('ITE_DESMVM').AsFloat;
                    cdsItens.FieldByName('ITE_DESMSM').AsFloat := qryPesqItGer.FieldByName('ITE_DESMSM').AsFloat;
                    cdsItens.FieldByName('ITE_DESMGM').AsFloat := qryPesqItGer.FieldByName('ITE_DESMGM').AsFloat;

                    cdsItens.FieldByName('ITE_MARMIN').AsFloat := qryPesqItGer.FieldByName('ITE_MARMIN').AsFloat;
                    cdsItens.FieldByName('ITE_MARMSG').AsFloat := qryPesqItGer.FieldByName('ITE_MARMSG').AsFloat;
                    cdsItens.FieldByName('ITE_MARMGE').AsFloat := qryPesqItGer.FieldByName('ITE_MARMGE').AsFloat;
                    cdsItens.FieldByName('ITE_MARMMV').AsFloat := qryPesqItGer.FieldByName('ITE_MARMMV').AsFloat;
                    cdsItens.FieldByName('ITE_MARMMS').AsFloat := qryPesqItGer.FieldByName('ITE_MARMMS').AsFloat;
                    cdsItens.FieldByName('ITE_MARMMG').AsFloat := qryPesqItGer.FieldByName('ITE_MARMMG').AsFloat;

                    cdsItens.FieldByName('ITE_COMDIG').AsFloat := qryPesqItGer.FieldByName('ITE_COMDIG').AsFloat;
                    cdsItens.FieldByName('ITE_COMTB1').AsFloat := qryPesqItGer.FieldByName('ITE_COMTB1').AsFloat;
                    cdsItens.FieldByName('ITE_COMTB2').AsFloat := qryPesqItGer.FieldByName('ITE_COMTB2').AsFloat;
                    cdsItens.FieldByName('ITE_COMTB3').AsFloat := qryPesqItGer.FieldByName('ITE_COMTB3').AsFloat;
                    cdsItens.FieldByName('ITE_COMTB4').AsFloat := qryPesqItGer.FieldByName('ITE_COMTB4').AsFloat;
                    cdsItens.FieldByName('ITE_COMTB5').AsFloat := qryPesqItGer.FieldByName('ITE_COMTB5').AsFloat;
                    cdsItens.FieldByName('ITE_COMTB6').AsFloat := qryPesqItGer.FieldByName('ITE_COMTB6').AsFloat;
                    cdsItens.FieldByName('ITE_COMTB7').AsFloat := qryPesqItGer.FieldByName('ITE_COMTB7').AsFloat;

                    cdsItens.FieldByName('ITE_OUTVAL').AsFloat  := fatVendas.fRetOutVal(qryPesqItGer.FieldByName('ITE_OUTVAL').AsFloat);

                    If (Not blnCarregouPedido) And (blnVendaPresencialSemCarregarPedOrc) Then
                       fatVendas.blnVendaPresencial := True;

                    If (fCfgSis('IMPCF4') = 'S') Then
                    begin
                      if (blnCarregouPedido) then
                        fatVendas.blnVendaPresencial := blnVendaPresencial;

                      pCarregaInformacoesParaCalculoDaAliquota(fatVendas);

                      if (fCfgSis('IMPDIG') = '1') then
                        cdsItens.FieldByName('ITE_ICMSAI').AsFloat := fatVendas.fCalculaAliquota(qryPesqItens.FieldByName('ITE_CODITE').AsString,
                                                                                                 qryPesqItGer.FieldByName('ITE_CODEMP').AsString,
                                                                                                 qryPesqItens.FieldByName('ITE_IMPDIR').AsString)
                      else
                        cdsItens.FieldByName('ITE_ICMSAI').AsFloat := fatVendas.fCalculaAliquota(qryPesqItens.FieldByName('ITE_CODITE').AsString,
                                                                                                 qryPesqItGer.FieldByName('ITE_CODEMP').AsString,
                                                                                                 qryPesqItGer.FieldByName('ITE_IMPDIR').AsString);
                    end
                    else
                      cdsItens.FieldByName('ITE_ICMSAI').AsFloat := fatVendas.fRetIcmSai(qryPesqItGer.FieldByName('ITE_ICMSAI').AsFloat);

                    fltPreCus := fatVendas.fRetPreCus(qryPesqItGer.FieldByName('ITE_PRECUS').AsFloat);

                    Case iteTipIte Of
                      iteDigitado: fltQtdIte := fStrToFloat(edtQtd.Text);
                      itePedido,
                      iteEstrutura,
                      iteRetificacaoPreco:
                                    Begin
                                      fltQtdIte := fltQtdItePar;
                                      fltUnitar := fltUnitarPar;
                                    End;
                    End;

                    intPrzMed := 0;
                    If ((fCfgSis('PRZPRO') = 'S') And (fCfgSis('USACND') = 'S')) Then
                    Begin
                      intPrzMed := fFloatToInt(fCalcMediaPagto(Self.strConPag));
                    End;

                    strConPagAux := '';
                    fatVendas.blnCalculaTaxCndF3Inicio := False;
                    If (fCfgSis('USACND') = 'S') And (Self.blnCalculaTaxCndF3InicioCx) Then
                    Begin
                      strConPagAux := Self.strConPag;
                      fatVendas.blnCalculaTaxCndF3Inicio := Self.blnCalculaTaxCndF3InicioCx;
                    End;

                    { ********************************* }
                    { * VERIFICA PROMOÇÃO DO PRODUTO  * }
                    { ******************************AF* }
                    fatVendas.strPromoc := 'N';
                    fatVendas.strCodPro := '';
                    cdsItens.FieldByName('ITE_PROMOC').AsString := 'N';
                    cdsItens.FieldByName('ITE_PROCUS').AsFloat  := 0;
                    cdsItens.FieldByName('ITE_PROVEN').AsFloat  := 0;
                    cdsItens.FieldByName('ITE_PROCVA').AsFloat  := 0;
                    cdsItens.FieldByName('ITE_DESF07').AsFloat  := 0;
                    cdsItens.FieldByName('ITE_PROCAT').AsFloat  := 0;
                    cdsItens.FieldByName('ITE_PROCDI').AsFloat  := 0;
                    If (fRetornaPrecosPromocao(qryPesqItens.FieldByName('ITE_CODITE').AsString,
                                               strCodCli,
                                               VS_Date,
                                               IIF((fltQtdIteEmb > 0), fltQtdIteEmb, fStrToFloat(edtQtd.Text)),
                                               0,
                                               0,
                                               intPrzMed,
                                               fatVendas.fltProPreCus,
                                               fatVendas.fltProPreVen,
                                               fatVendas.fltProComVar,
                                               fatVendas.fltProComAta,
                                               fatVendas.fltProComDis,
                                               fltQtdDis,
                                               fatVendas.fltProDesF07,
                                               fatVendas.strComPro,
                                               fatVendas.strCodPro,
                                               blnParticiona,
                                               blnPromo,
                                               strTabPre,
                                               fatVendas.strCodCnd,
                                               '',
                                               '',
                                               True,
                                               False,
                                               '-1',
                                               ((strEntRet = 'E') And (strIteEntFut = 'N')),
                                               ((strEntRet = 'E') And (strIteEntFut = 'S')),
                                               strMotFut,
                                               '', '', '', Nil, False,
                                               '',
                                               objPromVlrMinTotalProdutos)) Then
                    Begin

                      If Not blnParticiona Then
                      Begin
                        cdsItens.FieldByName('ITE_PROMOC').AsString := 'S';
                        cdsItens.FieldByName('ITE_COMPRO').AsString  := fatVendas.strComPro;
                        cdsItens.FieldByName('ITE_CODPRO').AsString  := fatVendas.strCodPro;
                        cdsItens.FieldByName('ITE_PROCUS').AsFloat   := fatVendas.fltProPreCus;
                        cdsItens.FieldByName('ITE_PROVEN').AsFloat   := fatVendas.fltProPreVen;
                        cdsItens.FieldByName('ITE_PROCVA').AsFloat   := fatVendas.fltProComVar;
                        cdsItens.FieldByName('ITE_DESF07').AsFloat   := fatVendas.fltProDesF07;
                        cdsItens.FieldByName('ITE_PROCAT').AsFloat   := fatVendas.fltProComAta;
                        cdsItens.FieldByName('ITE_PROCDI').AsFloat   := fatVendas.fltProComDis;

                        fatVendas.strPromoc := 'S';
                      End;

                    End;

                    blnPromoColet := False;
                    If (Length(TProQtdColetiva.ArrItemPro) > 0) Then
                      blnPromoColet := (Not fEmptyStr(TProQtdColetiva.fGetCodPro(qryPesqItens.FieldByName('ITE_CODITE').AsString)));

                    If (Not fEmptyStr(fatVendas.strCodPro)) Or (blnPromoColet) Then
                    Begin
                      If (stlItensPromoPorQtdMinQtdLim.IndexOf(qryPesqItens.FieldByName('ITE_CODITE').AsString) = -1) Then
                      Begin
                        dadosPromocao := fDadosPromocao(qryPesqItens.FieldByName('ITE_CODITE').AsString, VS_strCodEmp, strCodCli, strTabPre, '', '', '', fatVendas.strCodPro);
                        If (dadosPromocao.fltQtdLim > 0) Or (dadosPromocao.fltQtdMin > 1) Or (blnPromoColet) Then
                        Begin
                          stlItensPromoPorQtdMinQtdLim.Add(qryPesqItens.FieldByName('ITE_CODITE').AsString);
                        End;
                      End;
                    End;

                    If (fatVendas.strPromoc = 'S') And (fatVendas.fltProPreCus > 0) Then
                      fltPreCus := fatVendas.fltProPreCus;

                    fltUniVis := fltUnitar;
                    fltUniOri := fltUnitar;
                    fltTaxJur := 0.00;
                    fltVal_RT := 0.00;
                    fltDesCon := 0.00;

                    If (iteTipIte in [iteDigitado, iteRetificacaoPreco, iteEstrutura]) Then
                    Begin

                      If (Not fEmptyStr(strNumLot)) And
                         (fatVendas.objCadLot.fExisteLote(qryPesqItens.FieldByName('ITE_CODITE').AsString, VS_strCodEmp, strNumLot)) And
                         (fatVendas.fCalculaPrecosLote(fStrToFloat(edtQtd.Text), fltUniLot, '')) Then
                      Begin
                        fltUnitar := fltUniLot;
                      End
                      Else If (SameText(fCfgSis('SUGVLE'), '1') Or (Not fItemEstrutura(qryPesqItens.FieldByName('ITE_CODITE').AsString)))  Then
                      Begin
                        if fCfgSis('RATEST', varString) <> 'C' then
                          fltUnitar := fatVendas.fPegaPrecoVenda(qryPesqItGer, VS_strCodEmp,
                                                                 'S',
                                                                 0,
                                                                 blnItemEspecial,
                                                                 'NOR',
                                                                 fatVendas.strTabPre,
                                                                 True,
                                                                 fltTaxJur,
                                                                 fltUniVis,
                                                                 False,
                                                                 0,
                                                                 'F',
                                                                 strConPagAux);
                      End
                      Else
                      Begin
                        fltUnitar := fatVendas.fCalculaPrecoEstrutura(False,
                                                                      Preco_de_Venda,
                                                                      qryPesqItens.FieldByName('ITE_CODITE').AsString,
                                                                      VS_strCodEmp,
                                                                      'S',
                                                                      fatVendas.strTabPre,
                                                                      0);

                        fltPreCus := fatVendas.fRetornaPrecoCusto(Preco_de_Custo,
                                                                  qryPesqItens.FieldByName('ITE_CODITE').AsString,
                                                                  VS_strCodEmp,
                                                                  qryPesqItGer.FieldByName('ITE_PRECUS').AsFloat,
                                                                  '',
                                                                  Nil,
                                                                  (Pos('ITEM ESPECIAL', qryPesqItens.FieldByName('ITE_DESITE').AsString) > 0));
                      End;

                      fatVendas.pCalculaValorRT(fltUnitar, fltVal_RT);

                      fltUniOri := fltUnitar;

                      If iteTipIte In [iteRetificacaoPreco] Then
                        fltUnitar := fltUnitarPar;

                      If fCfgSis('DESCND',varBoolean) Then
                        fatVendas.strDstCnd := qryPesqItens.FieldByName('ITE_DESCND').AsString;

                      If blnBuscaCodBar And (iteTipIte = iteDigitado) And fCfgSis('PRVEMB', VarBoolean) Then
                      Begin
                        cdsItens.FieldByName('ITE_BAREMB').AsString := qryPesqItens.FieldByName('BAR_CODBAR').AsString;

                        If (Not fEmptyStr(qryPesqItens.FieldByName('BAR_DESCRI').AsString)) Then
                          cdsItens.FieldByName('ITE_DESITE').AsString := qryPesqItens.FieldByName('BAR_DESCRI').AsString;

                        If (blnCodBarEmb) And
                           (Not fEmptyStr(qryPesqItens.FieldByName('BAR_TABPRE').AsString)) And
                           (Not SameText(qryPesqItens.FieldByName('BAR_TABPRE').AsString, 'F')) And
                           (fCfgSis('PREEMB', VarInteger) = 2) Then
                        Begin
                          If (SameText(VS_strTabVen[StrToInt(qryPesqItens.FieldByName('BAR_TABPRE').AsString)], 'N')) Then
                          Begin
                            pMensagemSonora('', CHECKOUT_SEM_SUCESSO);
                            Result := False;
                            edtCodBarra.Clear;
                            edtCodBarra.Enabled := True;

                            fMensagem('', 'Esta embalagem está configurada para utilizar uma tabela de preço inválida!', ['&Ok']);

                            If cdsItens.State In [dsInsert, dsEdit] Then
                              cdsItens.Cancel;

                            pSetFocus(edtCodBarra);

                            Exit;
                          End;
                          fatVendas.strTabPre := qryPesqItens.FieldByName('BAR_TABPRE').AsString;
                          fltUnitar := fRetornaPrecoCodBarraEmb(qryPesqItens.FieldByName('ITE_CODITE').AsString,
                                                                qryPesqItens.FieldByName('BAR_CODBAR').AsString,
                                                                VS_strCodEmp,
                                                                fatVendas.strTabPre,
                                                                False);
                          fltUniOri := fltUnitar;

                          cdsItens.FieldByName('ITE_TABPRE').AsString := qryPesqItens.FieldByName('BAR_TABPRE').AsString;
                        End;

                        If (not blnCodBarEmb) And
                           (Not fEmptyStr(qryPesqItens.FieldByName('BAR_TABPRE').AsString)) And
                           (Not SameText(qryPesqItens.FieldByName('BAR_TABPRE').AsString, 'F')) And
                           (fCfgSis('PREEMB', VarInteger) = 2) Then
                        Begin
                          fatVendas.strTabPre := qryPesqItens.FieldByName('BAR_TABPRE').AsString;
                          fltUnitar := fatVendas.fPegaPrecoVenda(qryPesqItGer, VS_strCodEmp, 'S', 0, blnItemEspecial, 'NOR', fatVendas.strTabPre, True, fltTaxJur, fltUniVis, False, 0, 'F', strConPagAux);
                          fltUniOri := fltUnitar;

                          cdsItens.FieldByName('ITE_TABPRE').AsString := qryPesqItens.FieldByName('BAR_TABPRE').AsString;
                        End;

                        If (qryPesqItens.FieldByName('BAR_PREVEN').AsFloat > 0.00) And (fCfgSis('PREEMB', VarInteger) = 1) Then
                          fltUnitar := qryPesqItens.FieldByName('BAR_PREVEN').AsFloat;

                        If (iteTipIte = iteDigitado) And (fltQtdResParaInc > 0) Then
                        Begin
                          fltQtdIte := fltQtdResParaInc;
                          fltQtdResParaInc := 0;
                        End
                        Else If (qryPesqItens.FieldByName('BAR_EMBALA').AsFloat > 0.00) Then
                        Begin
                          fltQtdIte := fltQtdIte * qryPesqItens.FieldByName('BAR_EMBALA').AsFloat;
                        End;

                        fatVendas.pCalculaValorRT(fltUnitar, fltVal_RT);

                        strTabPre := fatVendas.strTabPre;
                      End;

                      If (iteTipIte = iteDigitado) And (fltQtdResParaInc > 0) Then
                      Begin
                        fltQtdIte := fltQtdResParaInc;
                        fltQtdResParaInc := 0;
                      End
                      Else If blnBuscaCodBar And (iteTipIte = iteDigitado) And (Not fCfgSis('PRVEMB', VarBoolean)) Then
                      Begin
                        If fCfgSis('PRVQTE', varBoolean) And (qryPesqItens.FieldByName('BAR_EMBALA').AsFloat > 0.00) Then
                          fltQtdIte := fltQtdIte * qryPesqItens.FieldByName('BAR_EMBALA').AsFloat;
                      End;

                      If (fatVendas.stlItensNaoTemQtdeEmbFec.IndexOf(qryPesqItens.FieldByName('ITE_CODITE').AsString) = -1) And
                        (Not fTemQuantEmbalagemFechada(qryPesqItens.FieldByName('ITE_CODITE').AsString)) Then
                      Begin
                        fatVendas.stlItensNaoTemQtdeEmbFec.Add(qryPesqItens.FieldByName('ITE_CODITE').AsString);
                      End;
                      { ************************************************ }
                      { * VERIFICA SE EH MULTIPLO DE EMBALAGEM FECHADA * }
                      { * APLICA O DESCONTO PARA EMBALAGEM FECHADA     * }
                      { ********************************************JC** }
                      If (fatVendas.stlItensNaoTemQtdeEmbFec.IndexOf(qryPesqItens.FieldByName('ITE_CODITE').AsString) = -1) And
                         (fEhEmbalagemFechadaItem(qryPesqItens.FieldByName('ITE_CODITE').AsString, IIF(fEmptyStr(strTabPrePar), strTabPre, strTabPrePar), fltQtdIte)) And
                         (fatVendas.strPromoc <> 'S') Then
                      Begin
                        fltUnitar := fltUnitar * (1 - (fPercDescEmbalagemFechadaItem(qryPesqItens.FieldByName('ITE_CODITE').AsString, IIF(fEmptyStr(strTabPrePar), strTabPre,
                          strTabPrePar), fltQtdIte, '') / 100));

                        cdsItens.FieldByName('ITE_QTDEMB').AsFloat := fltQtdIte;
                      End;
                    End;

                    cdsItens.FieldByName('ITE_ITEPED').AsString := 'N';
                    If (iteTipIte = itePedido) Then
                      cdsItens.FieldByName('ITE_ITEPED').AsString := 'S';

                    If iteTipIte = iteDigitado Then
                    Begin
                      If (blnUniEspecial) Then
                      Begin
                        fltUnitar := edtValUnitario.Value;
                        fltUniVis := fltUnitar;
                        fltUniOri := fltUnitar;
                        fltTaxJur := 0.00;
                        fltVal_RT := 0.00;
                      End;

                      { ******************************************* }
                      { * CASO ABATE O DESCONTO AUTOMATICAMENTE,  * }
                      { * APLICA O PERCENTUAL DE DESCONTO         * }
                      { ****************************************MV* }
                      If (fatVendas.strCAbDes = 'S') And
                         ((fatVendas.strPromoc <> 'S') Or (fatVendas.fRegraPrecoSugestaoAtiva = TRegraPrecoSugestao.PrecoDeTabela)) And
                         (Not fAplicarTaxaJurosPrecoDigitado) And
                         (Not fatVendas.fUsandoF3PuroComCondicaoNoFinal) Then
                      Begin
                        { ******************************************************************** }
                        { * CASO ESTEJA CONFIGURADO PARA UTILIZAR DESC. MÁX POR LINHA/GRUPO  * }
                        { * DO PRODUTO E CONDIÇÃO INFORMADOS, ALTERA fltDMGCnd/fltDMVCnd     * }
                        { ****************************************************************MM** }
                        fltDesMax := fatVendas.fRetornaDescLinGru(qryPesqItens.FieldByName('ITE_CODITE').AsString, fatVendas.strCodCnd);

                        If fCfgSis('DESCND',varBoolean) Then
                        Begin
                          If (fatVendas.strDstCnd = 'S') Then
                          Begin
                            fltDesCon := fatVendas.fRetornaVrDesconto(2, fltUnitar, fltDesMax);
                            fltUnitar := fltUnitar - fatVendas.fRetornaVrDesconto(2, fltUnitar, fltDesMax);
                          End;
                        End
                        Else If (fatVendas.strCodFpg = '007') or (fVerificarSeFormaPagamentoPedidoEhCartao) Then
                        Begin
                          If (fatVendas.strAbDeCc = 'S') Then
                            fltUnitar := fltUnitar - fatVendas.fRetornaVrDesconto(2, fltUnitar, fltDesMax);
                        End
                        Else
                          fltUnitar := fltUnitar - fatVendas.fRetornaVrDesconto(2, fltUnitar, fltDesMax);
                      End;

                      If fatVendas.fCarregaValorBrutoParaAplicarDescontoProfissional((fatVendas.strPromoc='N')) Then
                      Begin
                        fltDesCon := fltDesCon + fatVendas.fltDescProfissional;
                        fltUnitar := fFormataFloat(fltUniOri * (100 - fltDesCon) / 100, fatVendas.fMaxDecUni);
                      End;

                      edtValUnitario.Text := FloatToStrF(fltUnitar, ffFixed, 12, fCfgSis('DECUNI', varInteger));

                      pAplicaRegrasCondicoesDePagamento;

                      fltUnitar := fStrToFloat(edtValUnitario.Text);
                    End;

                    If (fltUnitar <= 0.0) Or ((iteTipIte = iteDigitado) And (Not fValidaQuantidade(qryPesqItens, fltQtdIte))) Then
                    Begin
                      pMensagemSonora('', CHECKOUT_SEM_SUCESSO);

                      Result := False;
                      edtCodBarra.Clear;
                      edtCodBarra.Enabled := True;

                      If (fltUnitar <= 0.0) Then
                        fMensagem('', 'Não é permitido inserir produtos com valor zerado!', ['&Ok']);

                      If cdsItens.State In [dsInsert, dsEdit] Then
                        cdsItens.Cancel;
                      pSetFocus(edtCodBarra);

                      Exit;
                    End;

                    If fItemEstrutura(qryPesqItens.FieldByName('ITE_CODITE').AsString) And blnBaixaSubItemEstrutura And (iteTipIte = iteDigitado) Then
                    Begin
                      If (Not fatVendas.fVerificaQtdEstoqueSubItensEstrutura(fatVendas.strOpcDoc,
                                                                             qryPesqItens.FieldByName('ITE_CODITE').AsString,
                                                                             '',
                                                                             fStrToFloat(edtQtd.Text),
                                                                             True,
                                                                             nil,
                                                                             blnPediuSenha,
                                                                             False)) Then
                      Begin
                        If cdsItens.State In [dsInsert, dsEdit] Then
                          cdsItens.Cancel;

                        Result := False;
                        edtCodBarra.Clear;
                        edtCodBarra.Enabled := True;
                        pSetFocus(edtCodBarra);

                        Exit;
                      End;
                    End;

                    If (fltPreCus <= 0.0) And (iteTipIte In [iteDigitado, iteRetificacaoPreco]) Then
                    Begin
                      pMensagemSonora('', CHECKOUT_SEM_SUCESSO);

                      Result := False;
                      edtCodBarra.Clear;
                      edtCodBarra.Enabled := True;

                      fMensagem('', 'produto com valor de custo inválido!', ['&Ok']);

                      If cdsItens.State In [dsInsert, dsEdit] Then
                        cdsItens.Cancel;
                      pSetFocus(edtCodBarra);

                      Exit;
                    End;

                    cdsItens.FieldByName('ITE_DESOPE').AsFloat := fatVendas.fRetDesOpe(qryPesqItGer.FieldByName('ITE_DESOPE').AsFloat);
                    cdsItens.FieldByName('ITE_IMPFED').AsFloat := fatVendas.fRetImpFed(qryPesqItGer.FieldByName('ITE_IMPFED').AsFloat);

                    cdsItens.FieldByName('ITE_QTDITE').AsFloat := fltQtdIte;
                    cdsItens.FieldByName('ITE_UNIORI').AsFloat := fltUniOri;
                    cdsItens.FieldByName('ITE_UNIVIS').AsFloat := fltUniVis;
                    cdsItens.FieldByName('ITE_UNITAR').AsFloat := fltUnitar;
                    cdsItens.FieldByName('ITE_DESCON').AsFloat := fltDesCon;
                    cdsItens.FieldByName('ITE_TAXJUR').AsFloat := fltTaxJur;
                    cdsItens.FieldByName('ITE_VAL_RT').AsFloat := fltVal_RT;
                    cdsItens.FieldByName('ITE_TOTITE').AsFloat := (fltQtdIte * fltUnitar);
                    cdsItens.FieldByName('ITE_TOTCUS').AsFloat := (fltQtdIte * fltPreCus);
                    cdsItens.FieldByName('ITE_PRECUS').AsFloat := fatVendas.fRetPreCus(qryPesqItGer.FieldByName('ITE_PRECUS').AsFloat);
                    cdsItens.FieldByName('ITE_COMLUB').AsString := qryPesqItens.FieldByName('ITE_COMLUB').AsString;
                    cdsItens.FieldByName('ITE_IPISAI').AsFloat := qryPesqItGer.FieldByName('ITE_IPISAI').AsFloat;
                    cdsItens.FieldByName('ITE_INCPIS').AsString := qryPesqItens.FieldByName('ITE_INCPIS').AsString;
                    cdsItens.FieldByName('ITE_COMVAR').AsFloat := qryPesqItGer.FieldByName('ITE_COMVAR').AsFloat;
                    cdsItens.FieldByName('ITE_COMATA').AsFloat := qryPesqItGer.FieldByName('ITE_COMATA').AsFloat;
                    cdsItens.FieldByName('ITE_COMDIS').AsFloat := qryPesqItGer.FieldByName('ITE_COMDIS').AsFloat;
                    cdsItens.FieldByName('ITE_PREMED').AsFloat := qryPesqItGer.FieldByName('ITE_PREMED').AsFloat;
                    cdsItens.FieldByName('ITE_CLAIPI').AsString := qryPesqItens.FieldByName('ITE_CLAIPI').AsString;
                    cdsItens.FieldByName('ITE_E_X___').AsString := qryPesqItens.FieldByName('ITE_EXCIPI').AsString;

                    cdsItens.FieldByName('ABF_CODABF').AsString := qryConAbf.FieldByName('ABF_CODABF').AsString;
                    cdsItens.FieldByName('ABF_CODSIT').AsString := qryConAbf.FieldByName('ABF_CODSIT' + strTipAbf).AsString;
                    cdsItens.FieldByName('ABF_ALQICM').AsFloat := qryConAbf.FieldByName('ABF_ALQICM' + strTipAbf).AsFloat;
                    cdsItens.FieldByName('ABF_BASICM').AsFloat := qryConAbf.FieldByName('ABF_BASICM' + strTipAbf).AsFloat;
                    cdsItens.FieldByName('ABF_MENS01').AsString := qryConAbf.FieldByName('ABF_MENS01' + strTipAbf).AsString;

                    cdsItens.FieldByName('ITE_SALDOS').AsFloat := qryPesqItens.FieldByName('ITE_SALDOS').AsFloat;

                    { ******************************************* }
                    { * CASO FOR CUPOM(IF) APLICAR A REDUÇÃO DE * }
                    { * BASE NA ALIQUOTA                        * }
                    { ***29/04/2008***************************MV* }
                    If fConcomitante And (fFormataFloat(cdsItens.FieldByName('ABF_BASICM').AsFloat, 2) > 0.00) Then
                    Begin
                      If (fatVendas.fTemAliqEcf(fFormataFloat(cdsItens.FieldByName('ABF_ALQICM').AsFloat * cdsItens.FieldByName('ABF_BASICM').AsFloat / 100, 2))) Then
                        cdsItens.FieldByName('ABF_ALQICM').AsFloat := fFormataFloat(cdsItens.FieldByName('ABF_ALQICM').AsFloat * cdsItens.FieldByName('ABF_BASICM').AsFloat / 100, 2);

                      cdsItens.FieldByName('ABF_BASICM').AsFloat := 100;
                    End;

                    cdsItens.FieldByName('ITE_PESOIT').AsFloat := qryPesqItens.FieldByName('ITE_PESOIT').AsFloat;
                    cdsItens.FieldByName('ITE_PESLIQ').AsFloat := qryPesqItens.FieldByName('ITE_PESLIQ').AsFloat;

                    If (iteTipIte = itePedido) Then
                    Begin
                      If (fCfgSis('EXPF11', VarBoolean) Or (strIteEntFut = 'S') Or fUsouExpedicaoServicos) Then
                        cdsItens.FieldByName('ITE_QTDEXP').AsFloat := fltQtdIte;

                      cdsItens.FieldByName('ITE_SEQDET').AsString := strSeqDet;
                    End;

                    If (Assigned(cdsIteCfo)) And
                       (cdsIteCfo.Locate('AUTOINCREM', strAutIncFdo, [])) And
                       (Not fCfgSis('EXPF11', VarBoolean)) Then
                      cdsItens.FieldByName('ITE_QTDEXP').AsFloat := cdsIteCfo.FieldByName('QTDLIB').AsFloat;

                    If fEmptyStr(cdsItens.FieldByName('ITE_TABPRE').AsString) Then
                      cdsItens.FieldByName('ITE_TABPRE').AsString := IIF(fEmptyStr(strTabPrePar), strTabPre, strTabPrePar);

                    { ********************************* }
                    { * ITENS DO F3 SEMPRE SÃO RETIRA * }
                    { ******************************RN* }
                    If (iteTipIte <> itePedido) Then
                      cdsItens.FieldByName('ITE_ENTRET').AsString := 'R'
                    Else
                      cdsItens.FieldByName('ITE_ENTRET').AsString := strEntRet;

                    If fCfgSis('LOCRET', VarBoolean) Then
                    Begin
                      If (iteTipIte <> itePedido) Then
                        cdsItens.FieldByName('ITE_LOCRET').AsString := 'C'
                      Else
                        cdsItens.FieldByName('ITE_LOCRET').AsString := strLocRet;
                    End;

                    cdsItens.FieldByName('ITE_OBRCPF').AsString := qryPesqItens.FieldByName('ITE_OBRCPF').AsString;

                    If blnRateioProdutoEstrutura Then
                    Begin
                      cdsItens.FieldByName('ITE_QTDITE').AsFloat := fltQtdItePar;
                      cdsItens.FieldByName('ITE_UNIORI').AsFloat := fltUnitarPar;
                      cdsItens.FieldByName('ITE_UNIVIS').AsFloat := fltUnitarPar;
                      cdsItens.FieldByName('ITE_UNITAR').AsFloat := fltUnitarPar;
                      cdsItens.FieldByName('ITE_TOTITE').AsFloat := (fltQtdItePar * fltUnitarPar);
                      cdsItens.FieldByName('ITE_TOTCUS').AsFloat := (fltQtdItePar * fltPreCus);
                    End;

                    cdsItens.FieldByName('ITE_IPIENT').AsFloat := qryPesqItGer.FieldByName('ITE_IPIENT').AsFloat;
                    cdsItens.FieldByName('ITE_FREENT').AsFloat := qryPesqItGer.FieldByName('ITE_FREENT').AsFloat;

                    If fRegistrarItem(qryPesqItens.FieldByName('ITE_CODITE').AsString, qryPesqItens.FieldByName('ITE_DESITE').AsString,
                      fRetSiglaUnidadeIF(qryPesqItens.FieldByName('ITE_CODUNI').AsString), cdsItens.FieldByName('ABF_ALQICM').AsFloat,
                      fFormataFloat(fltQtdIte, fCfgSis('DECQTD', VarInteger)), fFormataFloat(fltUnitar, fCfgSis('DECUNI', VarInteger)), cdsItens.FieldByName('ABF_CODSIT').AsString,
                      cdsItens.FieldByName('ITE_TOTITE').AsFloat) Then
                    Begin
                      cdsItens.Post;
                      pMensagemSonora('', CHECKOUT_COM_SUCESSO);
                      pCarregarFoto(qryPesqItens.FieldByName('ITE_CODITE').AsString, qryPesqItens.FieldByName('ITE_DESITE').AsString);

                      If Assigned(objCodBar) Then
                      begin
                        if (iteTipIte = itePedido) or ((iteTipIte = iteDigitado) And (length(strCodBar) <= 5))  then
                          objCodBar.pAddCodBar(fRetCodBarra(strCodBar), qryPesqItens.FieldByName('ITE_CODITE').AsString, fltQtdIte)
                        else
                          objCodBar.pAddCodBar(strCodBar, qryPesqItens.FieldByName('ITE_CODITE').AsString, fltQtdIte);
                      End;

                      if cdsItens.FieldByName('ITE_ITEPED').AsString <> 'S' then
                      begin
                        LintChkOut := fGravaCheckout(0,
                                                    strOpeRcx,
                                                    strCodCli,
                                                    strCodVen,
                                                    cdsItensITE_CODBAR.AsString,
                                                    cdsItensITE_CODITE.AsString,
                                                    cdsItensITE_DESITE.AsString,
                                                    cdsItensUNI_DESUNI.AsString,
                                                    cdsItensITE_QTDITE.AsFloat,
                                                    cdsItensITE_UNITAR.AsFloat,
                                                    cdsItensITE_TOTITE.AsFloat,
                                                    VS_ComputerNetName,
                                                    VS_IPAddressAsString,
                                                    VS_UserFromWindows,
                                                    'I',
                                                    False,
                                                    FcdsChkOut,
                                                    FcdsLogChk);

                        if LintChkOut <> 0 then
                        begin
                          cdsItens.Edit;
                          cdsItens.FieldByName('ITE_CHKOUT').AsString := IntToStr(LintChkOut);
                          cdsItens.Post;
                        end;
                      end;

                      If (stlItensPromoPorQtdMinQtdLim.IndexOf(cdsItens.FieldByName('ITE_CODITE').AsString) >= 0) Then
                        pRecalculaPrecosSomenteStringList(stlItensPromoPorQtdMinQtdLim);

                      pRecalcularItensPromocaoValorMinTotProdutos(cdsItensITE_CODITE.AsString,
                                                                  cdsItensITE_CODUNI.AsString,
                                                                  False, '', '', '');

                    End
                    Else
                    Begin
                      cdsItens.Cancel;
                    End;
                    If (fCfgSis('DESEMB', VarBoolean)) And (cdsItens.FieldByName('ITE_ITEPED').AsString = 'N') Then
                      pDescontoEmbFechada(cdsItens.FieldByName('ITE_CODITE').AsString, cdsItens.FieldByName('ITE_TABPRE').AsString)
                  End;
                finally
                  pEnableControls(cdsItens, prcScroll);
                end ;
              End;

              If iteTipIte In [iteDigitado, iteRetificacaoPreco] Then
              Begin
                pnlStatusCaixa.Caption := 'Passe o Produto Desejado';
                edtCodBarra.Enabled := True;
              End;
            End;
          Until ((fltQtdResParaInc = 0) And (iteTipIte = iteDigitado)) Or (iteTipIte <> iteDigitado);

        End
        Else
        Begin
          pMensagemSonora('', CHECKOUT_SEM_SUCESSO);
          Result := False;
          fMensagem('', 'Produto (' + strCodItePar + ') não cadastrado!' + #13 + '[ ESC-Cancela ]', ['&ESC-Cancela'], 1, True, 1, 0, False, 0, True, True);
        End;

      End;

    Except
      On E: Exception Do
      Begin
        pMensagemSonora('', CHECKOUT_SEM_SUCESSO);
        pnlStatusCaixa.Caption := 'Erro na leitura do produto!';
        cdsItens.Cancel;
        Result := False;
      End;
    End;

  Finally

    If (Not Result) And (qryPesqItens.Active) And (Not qryPesqItens.IsEmpty) Then
    Begin
      pRecalcularItensPromocaoValorMinTotProdutos(qryPesqItens.FieldByName('ITE_CODITE').AsString,
                                                  qryPesqItens.FieldByName('ITE_CODUNI').AsString,
                                                  True, '', '', '');
    End;

    FreeAndNil(qryPesqItens);
    FreeAndNil(qryPesqItGer);
    FreeAndNil(qryConAbf);

    blnItemEspecial := False;

    If iteTipIte In [iteDigitado, iteRetificacaoPreco] Then
    Begin
      If Not edtQtd.Enabled Then
      Begin
        edtCodBarra.Clear;
        pSetFocus(edtCodBarra);

        edtQtd.Value := 1;
        edtValUnitario.Value := 0;
      End;
    End;

  End;
end;

function TfrmCaixa.fRetVenSugestao: String;
begin
  Result := IIF(fEmptyStr(strCodVen), IIF(fEmptyStr(strVenF11), strOpeRcx, strVenF11), strCodVen);
end;

function TfrmCaixa.fCarregaEstrutura(strCodIte: String; fltQtdIte: Double; blnBaixaSubItemEstrutura: Boolean): Boolean;
Var
  objItensEstrutura: TItensEstrutura;
  intSeqInclusaoEstrutura: Integer;
  strCodItemEstrutura: String;
  fltUnitarioItemEstrutura: Double;
  fltQuantidadeSubItemEstrutura: Double;
  fltUnitarioSubItemEstrutura: Double;
  subItem: TSubItemEstrutura;
  intItem: Integer;
  qryItePai: TUniQuery;
  fltPrePai: Double;
  fltTaxJur: Double;
  fltUniVis: Double;
Begin
  Result := False;

  strCodItemEstrutura := strCodIte;
  intSeqInclusaoEstrutura := fRetornaSequencialUnico('SINCPD');

  If Assigned(fatVendas) Then
    fatVendas.strPromoc := 'N';

  Try
    objItensEstrutura := TItensEstrutura.Create;
    qryItePai := fCriaQuery(Nil);

    If fatVendas.fCalculaPrecoEstrutura(False,
                                        Preco_de_Venda,
                                        strCodIte,
                                        VS_strCodEmp,
                                        'S',
                                        fatVendas.strTabPre,
                                        fatVendas.fltMargem,
                                        fltQtdIte,
                                        objItensEstrutura ) > 0 Then
    Begin
      qryItePai.Close;
      qryItePai.SQL.Clear;
      qryItePai.SQL.Add('SELECT * FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP');
      qryItePai.ParamByName('CODITE').AsString := strCodIte;
      qryItePai.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryItePai.Open;

      If (fCfgSis('SUGVLE', VarString) = '1') Then
      Begin
        fltPrePai := fatVendas.fPegaPrecoVenda(qryItePai, VS_strCodEmp,
                                               'S',
                                                0,
                                                False,
                                                'NOR',
                                                fatVendas.strTabPre,
                                                True,
                                                fltTaxJur,
                                                fltUniVis);

        fltPrePai := fFormataFloat(fltPrePai * fltQtdIte, 2);

        If fltPrePai > 0 Then
          objItensEstrutura.pAcertarPrecos(fltPrePai);
      End;

      fltUnitarioItemEstrutura := objItensEstrutura.fltUnitarioItemEstrutura;

      For intItem := 0 To objItensEstrutura.ItemsCount -1 Do
      Begin
        subItem := objItensEstrutura[intItem];

        //Carrega o preco de venda do item estrutura para utilizar na trava de preco
        fltQuantidadeSubItemEstrutura := subItem.fltQtdTot / objItensEstrutura.fltQuantidadeItemEstrutura;
        fltUnitarioSubItemEstrutura   := subItem.fltPreVen;

        Result := fProcessaItemGeral(iteEstrutura,
                                     subItem.strCodigo ,
                                     IIF((fCfgSis('RATEST', varString) = 'S') Or (fCfgSis('RATEST', varString) = 'C'), subItem.fltPreVen, 0),
                                     subItem.fltQtdTot,
                                     '',
                                     '',
                                     '',
                                     'NOR',
                                     'N',
                                     '',
                                     '',
                                     '',
                                     strCodVen,
                                     '',
                                     blnBaixaSubItemEstrutura,
                                     (fCfgSis('RATEST', varString) = 'S'),
                                     intSeqInclusaoEstrutura,
                                     strCodItemEstrutura,
                                     fltUnitarioItemEstrutura,
                                     fltQuantidadeSubItemEstrutura,
                                     fltUnitarioSubItemEstrutura);

        If Not Result Then
          Break;
      End;
    End;
  Finally
    FreeAndNil(objItensEstrutura);
    FreeAndNil(qryItePai);
  End;

  edtCodBarra.Clear;
  pSetFocus(edtCodBarra);
  edtQtd.Value := 1;
  edtValUnitario.Value := 0;

  If Not Result Then
    fMensagem('ATENÇÃO!', 'A ESTRUTURA NÃO FOI CARREGADA TOTALMENTE!', ['&Ok']);

End;

procedure TfrmCaixa.pItemPdEhProAca(strCodBar: String; var strCodAcaAca, strCodEmpAca: String);
var
  qryProAca: TUniQuery;
begin
  qryProAca := fCriaQuery;
  try
    qryProAca.Close;
    qryProAca.SQL.Clear;

    qryProAca.SQL.Text :=
    ' SELECT '+
    '   FDO_CODACA, '+
    '   FDO_EMPACA '+
    ' FROM '+
    '   FATDOR '+
    ' INNER JOIN CADACA '+
    '   ON FDO_CODITE = ACA_CODITE AND '+
    '      FDO_CODACA = ACA_CODACA AND '+
    '      FDO_EMPACA = ACA_CODEMP '+
    ' WHERE '+
    '   FDO_SEQGER =  :SEQGER AND '+
    '   FDO_CODITE <> :ITESER AND '+
    '   FDO_CODITE <> :SERTER AND '+
    '   ACA_CODBAR =  :CODBAR ';

    qryProAca.ParamByName('SEQGER').AsString := strAutFgo;
    qryProAca.ParamByName('ITESER').AsString := fCfgSis('ITESER');
    qryProAca.ParamByName('SERTER').AsString := fCfgSis('SERTER');
    qryProAca.ParamByName('CODBAR').AsString := strCodBar;
    qryProAca.Open;

    if not qryProAca.IsEmpty then
    begin
      strCodAcaAca := qryProAca.FieldByName('FDO_CODACA').AsString;
      strCodEmpAca := qryProAca.FieldByName('FDO_EMPACA').AsString;
    end;

  finally
    FreeAndNil(qryProAca);
  end;

end;

function TfrmCaixa.fProcessaItem: Boolean;
Var
  fltQtdIte: Double;
  strCodIte: String;
  strCodVenLocal: String;
  blnValida: Boolean;
  blnItemEstrutu: Boolean;
  blnBaixaSubItemEstrutura : Boolean;
  blnProcessou : Boolean;
  ItemEstrutura : TItemEstru;
  strCodAcaAca,
  strCodEmpAca: String;
  objRestricaoVenda: TRegrasRestricaoVendaProdutos;
  intQuantITEBAR : Integer;

  function fProdEstrutura(strCodIte:String): Boolean;
  begin
    Result := (fCampoTabela('ITE_CAREST', 'CADITE', ['ITE_CODITE'], [strCodIte]) = 'S');
  end;

  function fRetCodItem(strCodItePar: String; blnParBuscaCodBar: boolean = True): String;
    Var
      blnBuscaCodBar: Boolean;
      strCodBar: String;
      qryPesqItens: TUniQuery;
  begin
    qryPesqItens := fCriaQuery(Nil);
    Result := '';
    Try
      If (Not fEmptyStr(strCodItePar)) And (strCodItePar <> '000000000000000') Then
      Begin
        strCodBar := strCodItePar;
        blnBuscaCodBar := blnParBuscaCodBar;

        //É Codigo de barras Originado da Balança.
        If (strCodBar[1] = strDigIni) And (fItemBalanca(Copy(strCodBar, 3, 5))) Then
        Begin
          strCodBar := Copy(strCodBar, 3, 5);
          blnBuscaCodBar := False;
        End;

        pPesquisaCadIte(Nil, qryPesqItens, strCodBar, '', blnBuscaCodBar, False, True, True, False, False, False, False, True);

        If Not qryPesqItens.IsEmpty Then
          Result := qryPesqItens.FieldByName('ITE_CODITE').AsString;
      End;
    Finally
      FreeAndNil(qryPesqItens);
    End;
  end;

  function fEmbalagemNaoMostraFaturamento(strCodEmb, strCodIte: String): Boolean;
    Var
      strAux: String;
  begin
    Result := True;

    If (Not fEmptyStr(strCodEmb)) And (Not fEmptyStr(strCodIte)) Then
    Begin
      strAux := fCampoTabela('COALESCE(BAR_EXBFAT, "S")', 'ITEBAR', ['BAR_CODITE', 'BAR_CODBAR'], [strCodIte, strCodEmb]);
      Result := IfEmptyStr(strAux, 'S') = 'S';
    End;
  end;

Begin
  Result := False;
  blnProcessou := False;
  blnBaixaSubItemEstrutura := False;

  If InterlockedIncrement(intSemaforoRegistraItem) = 0 Then
  Begin
    Try
      If (fCfgSis('ITEBAR', varString) = 'S') Then
      Begin
        strCodIte := fBuscaItemITEBAR(edtCodBarra.Text, intQuantITEBAR);

        if fEmptyStr(strCodIte) then
        begin
          pMensagemSonora('Item não encontrado na tabela ITEBAR! Favor verificar.');
          edtCodBarra.Clear;
          Exit;
        end
        else
        if intQuantITEBAR > 1 then
        begin
          pMensagemSonora('O código de barras retornou mais de um item! Favor verificar.');
          edtCodBarra.Clear;
          Exit;
        end;
      End
      Else
      Begin
        strCodAcaAca := '';
        strCodEmpAca := '';
        if (blnCarregouPedido) and (Length(edtCodBarra.Text) > 5) then
          pItemPdEhProAca(edtCodBarra.Text, strCodAcaAca, strCodEmpAca);

        if (Length(edtCodBarra.Text) < fTamCodIte) and (not fEmptyStr(edtCodBarra.Text)) then
          edtCodBarra.Text := fStrZero(edtCodBarra.Text, fTamCodIte);

        strCodIte := fRetCodItem(edtCodBarra.Text, Length(edtCodBarra.Text) > fTamCodIte);
      End;

      If (Not fEmbalagemNaoMostraFaturamento(edtCodBarra.Text, strCodIte)) Then
      Begin
        pMensagemSonora('Embalagem informada não é permitida no faturamento. Verifique!');
        edtCodBarra.Clear;
        Exit;
      End;

      fltQtdIte := edtQtd.Value;

      Try
        objRestricaoVenda := TRegrasRestricaoVendaProdutos
                               .New
                               .EspecieDocumento(fatVendas.strOpcDoc)
                               .CodigoCliente(fatVendas.strCodCli)
                               .fLimpar
                               .fAdicionarCodigoProduto(strCodIte);

        If objRestricaoVenda.fPossuiRestricaoVenda Then
        Begin
          Result := False;
          Exit;
        End;
      Finally
        FreeAndNil(objRestricaoVenda);
      End;

      blnItemEstrutu := fItemEstrutura(strCodIte);

      If (Not fPermiteVenderSubItemEstruturaAvulso(strCodIte)) Then
      Begin
        ItemEstrutura := fEhOuCompoeEstrutura(strCodIte, VS_strCodEmp);
        If (ItemEstrutura.blnEstrutura) And (Not ItemEstrutura.blnPrincipal) Then
        Begin
          pMensagemSonora('', CHECKOUT_SEM_SUCESSO);
          pMensagemOk('Sub-Produto ' + strCodIte + '-' +
                                       fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [strCodIte]) + ' não permitido para venda em separado! Somente estrutura completa.');
          Result := False;
          Exit;
        End;
      End;

      If (Not blnItemEstrutu) And (Not fEmptyStr(strCodVenLocal)) And (fItemExpedicao(fRetCodItem(edtCodBarra.Text), '', strCodVenLocal)) Then
      Begin
        blnValida := True
      End
      Else If (fEmptyStr(strCodVen)) Then
      Begin
        blnValida := fInformouVendedor;
        strCodVenLocal := strCodVen;
      End
      Else
      Begin
        blnValida := True;
        strCodVenLocal := strCodVen;
      End;

      If (blnValida) Then
      Begin
        If Assigned(fatVendas) And fEmptyStr(fatVendas.strTipVen) Then
          fatVendas.strTipVen := fRetTipoOperador(strCodVenLocal);

        pDigitaCpfCnpj;

        If blnItemEstrutu And blnCarregamentoSubItensConcretoAutomaticamente Then
          Result := fCarregaEstrutura(strCodIte, fltQtdIte, True)

        Else

        If fAbrirCupom Then
        Begin
          If cdsItens.IsEmpty Then
          Begin
            intNumItem := 0;
          End;

          Try
            If blnItemEstrutu Then
            Begin

              If fCfgSis('CAREST', varString) = 'R' Then
              Begin
                If fProdEstrutura(strCodIte) Then
                Begin
                  blnProcessou := True;
                  Result := fCarregaEstrutura(strCodIte, fltQtdIte, blnBaixaSubItemEstrutura);
                End
                Else
                  blnBaixaSubItemEstrutura := fCfgSis('BXSBIT') <> '1';
              End
              Else
              If fCfgSis('CAREST', varString) = 'S' Then
              Begin
                If fMensagem('', 'Carregar os itens da estrutura?', ['&Sim', '&Não']) = 1 Then
                Begin
                  blnProcessou := True;
                  Result := fCarregaEstrutura(strCodIte, fltQtdIte, blnBaixaSubItemEstrutura);
                End
                Else
                  blnBaixaSubItemEstrutura := fCfgSis('BXSBIT') <> '1';
              End
              Else If fCfgSis('CAREST', varString) = 'N' Then
              Begin
                blnBaixaSubItemEstrutura := fCfgSis('BXSBIT') <> '1';
              End
              Else If fCfgSis('CAREST', varString) = 'P' Then
              Begin
                blnProcessou := True;
                Result := fCarregaEstrutura(strCodIte, fltQtdIte, blnBaixaSubItemEstrutura);
              End;
            End;

            If (Not blnProcessou) Then
              Result := fProcessaItemGeral(iteDigitado,
                                           edtCodBarra.Text,
                                           edtValUnitario.Value,
                                           edtQtd.Value,
                                           '',
                                           '',
                                           '',
                                           'NOR',
                                           'N',
                                           '',
                                           '',
                                           '',
                                           strCodVenLocal,
                                           '',
                                           blnBaixaSubItemEstrutura,
                                           False,
                                           0,
                                           '',
                                           0,
                                           0,
                                           0,
                                           '',
                                           '',
                                           strCodAcaAca,
                                           strCodEmpAca);

          Except
            On E: Exception Do
            Begin
              Result := False;
              pMensagensErro(E.Message, '[TfrmCaixa.fProcessaItem]');
            End;
          End;
        End;
      End;
    Finally
      InterlockedDecrement(intSemaforoRegistraItem);
    End;
  End
  Else
    InterlockedDecrement(intSemaforoRegistraItem);
End;

procedure TfrmCaixa.btnFecharVendaClick(Sender: TObject);
begin
  If InterlockedIncrement(intSemaforoConfirma) = 0 Then
  Begin
    Try

      If cdsItens.IsEmpty Then
      Begin
        pMensagemOk('É necessário informar pelo menos 1 item.');
      End
      Else
      Begin
        If Not fExpedicaoPendente Then
        Begin
          Self.blnFechamentoNormal := True;

          If fPedirDesconto Then
          Begin
            Close;
            ModalResult := mrOk;
          End;

        End;
      End;

      InterlockedDecrement(intSemaforoConfirma);

    Except
      On E: Exception Do
      Begin
        InterlockedDecrement(intSemaforoConfirma);
        pMensagensErro(E.Message, '[pConfirma]');
      End;
    End;
  End
  Else
  Begin
    InterlockedDecrement(intSemaforoConfirma);
  End;
end;

procedure TfrmCaixa.btnInfVenClick(Sender: TObject);
begin
  inherited;
  If (pnlInfVen.Visible) And (btnInfVen.Visible) Then
    fInformouVendedor;
end;

function TfrmCaixa.fEhItemBalancaComDivisaoPorMil(strCodIte: String): Boolean;
  var
    blnDividirQtdEtiquetaPorMil : Boolean;
begin

  Result := False;

  blnDividirQtdEtiquetaPorMil := fCfgSis('DVQBAL') = 'S';

  If fConsiderarTipoDeVendaUnidadeOuPeso Then
  Begin

    If (fTipoDeVendaUnidadeOuPeso(strCodIte) <> PESO) Then
      Exit;

  End;

  Result := blnDividirQtdEtiquetaPorMil;

end;

function TfrmCaixa.fExcluirItensPromocaoValorMinTotProdutos(strCodIte,
  strCodigoUnidadeMedida, strRshDel, strRshAut: String): Boolean;
Var
  blnRecalcular: Boolean;
begin
  Try
    If (fVerificaPodeExcluirItemPromVlrMin(strCodIte)) Then
    Begin
      objPromVlrMinTotalProdutos.pDelItem(strCodIte, strCodigoUnidadeMedida, strRshDel);
      blnRecalcular := True;
    End
    Else
    Begin
      blnRecalcular := fAtualizarItensPromocaoVlrMin(strCodIte, strCodigoUnidadeMedida, strRshAut);
    End;

    If (Not objPromVlrMinTotalProdutos.fPossuiItensPromocaoVlrMinimo) Then
      Exit(False);

    Result := blnRecalcular;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'');
    End;
  End;
end;

function TfrmCaixa.fExpedicaoPendente: Boolean;
Var
  cdsAux: TUniClientDataSet;
Begin
  cdsAux := TUniClientDataSet.Create(Nil);
  cdsAux.Data := cdsItens.Data;

  With cdsAux Do
  Begin
    DisableControls;
    Filter := 'ITE_QTDITE > ITE_QTDEXP AND ITE_ITEPED = ' + QuotedStr('S');
    Filtered := True;

    Result := Not IsEmpty;

    Filtered := False;
    Filter := '';

    EnableControls;
  End;

  If Result Then
    fMensagem('', 'Há itens ainda não expedidos!', ['&OK']);

  FreeAndNil(cdsAux);
End;

function TfrmCaixa.fPedirDesconto: Boolean;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravandoFechamentoVenda);
    frmGravandoFechamentoVenda.fExecutarAcao := fPedirDesconto_Interna;
    frmGravandoFechamentoVenda.ShowModal;
    Result := frmGravandoFechamentoVenda.blnConfirma;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
  pFreeAndNil(frmGravandoFechamentoVenda);
end;

function TfrmCaixa.fPedirDesconto_Interna(pgbStatus: TcxProgressBar): Boolean;
Var
  blnConcomitante: Boolean;
begin
  If (Not fEmptyStr(strCodCli)) And (Assigned(qryCadCli)) And ((Not qryCadCli.Active) Or (qryCadCli.IsEmpty) Or (qryCadCli.FieldByName('CLI_CODCLI').AsString <> strCodCli)) And (Assigned(prcCarregaCliente)) Then
    prcCarregaCliente(True, strCodCli);

  If (Not Assigned(funcaoDesconto)) Then
  Begin
    Result := False;
    Exit;
  End;

  If fConcomitante Then
    blnConcomitante := Self.blnFechamentoNormal
  Else
    blnConcomitante := False;

  Result := (funcaoDesconto(fltPorDesCx, fltDesEspCx, fltTotGerCx, cdsItens, blnConcomitante, (Not Self.blnFechamentoNormal), strTabPre, pgbStatus));

  If Not Result Then
  Begin
    fltDesEspCx := 0;
    fltPorDesCx := 0;
    fltTotGerCx := 0;
  End;
end;

function TfrmCaixa.fGridVendaVazio: Boolean;
begin
  Result := (cdsItens.RecordCount = 0) Or (cdsItens.IsEmpty);
end;

function TfrmCaixa.fPermiteFechar(blnItePed: Boolean = False): Boolean;
begin
  pnlImgPro.Visible := False;
  cdsItens.Filtered := False;

  If blnItePed Then
    cdsItens.Filter := 'ITE_ITEPED = ' + QuotedStr('S')
  Else
    cdsItens.Filter := 'ITE_ITEPED = ' + QuotedStr('N');

  cdsItens.Filtered := True;

  Result := (cdsItens.RecordCount = 0);

  cdsItens.Filtered := False;
  cdsItens.Filter := '';
  pnlImgPro.Visible := fCfgSis('IMGPRO', VarBoolean);
end;

procedure TfrmCaixa.pCarregarFoto(strCodIte, strDesIte: String);
Begin
  If Not pnlImgPro.Visible Then
    Exit;

  If fEmptyStr(strCodIte) Then
    Exit;

  lblTitImgPro.Caption := strDesIte;

  Case fCarregaImagemProduto(strCodIte, imgPro.Picture) of
    riOk   :
    Begin
      imgPro.Visible := True;
      lblErrImg.Visible := False;
    End;
    riErro :
    Begin
      imgPro.Visible := False;
      lblErrImg.Visible := True;
    End;
    riNulo :
    Begin
      imgPro.Visible := False;
      lblErrImg.Visible := False;
    End;
  End;
end;

procedure TfrmCaixa.btnCancelarCupomClick(Sender: TObject);
Var
  blnFechar: Boolean;
begin
  inherited;
  blnFechar := False;

  If Not fSenhaResponsavel Then
    Exit;

  If cdsItens.IsEmpty Then
  Begin
    pCancelaCupomCasoEstejaAberto;
    Exit;
  End;

  If Not fConcomitante Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Iniciado um PD/OR no F11 ou Cancelamento de item no check-out');
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'        , strCodCli + '-' + fRetNomCliente(strCodCli)             , 14);
    objLiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ'       , fFormataCpfCgc(fRetCgcCpf(strCodCli), fSetaPais)        , 14);
    objLiberacao.objMsgLibera.pAddTextoCaption('Nome Fantasia'  , fRetNomFantasia(strCodCli)                              , 14);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor da Venda' , FormatFloat('#,##0.00', fStrToFloat(dbeValorTotal.Text)), 14);

    objLiberacao.strDirAce := 'CANCF4C';
    objLiberacao.strSenLib := fCfgSis('SENLBD');
    objLiberacao.strMsgSen := 'Iniciado um PD/OR no F11 ou Cancelamento de item no check-out';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := IIF(fEmptyStr(strCodVen), strOpeRcx, strCodVen);
    objLiberacao.strCodDig := strOpeRcx;
    objLiberacao.strCodIte := cdsItens.FieldByName('ITE_CODITE').AsString;
    objLiberacao.strSenLibNv2 := fCfgSis('SENLN2');
    objLiberacao.blnUsarSenhaFixa := False;


    If (Not blnPediuSenha) And (Not objLiberacao.fLibera) Then
    Begin
      Exit;
    End;

    If Not fPermiteFechar Then
    Begin
      If fMensagem('', 'Deseja cancelar dados?' + sLineBreak + '**Os itens carregados do pedido/orçamento não serão cancelados.', ['&Sim', '&Não'], 2) = 2 Then
      Begin
        blnPediuSenha := False;
        Exit;
      End;

      blnPediuSenha := True;
      blnFechar := False;
    End
    Else
      blnFechar := True;
  End;

  If fCancelarCupom Then
  Begin
    // Grava log dos produtos que serão excluídos
    pGravarLogExclusaoCancelaCupom(objLiberacao.strOperador);

    intNumItem := 0;
    pPreparaDataSet;

    If Not blnFechar Then
    Begin  
      If Not fEmptyStr(strCodCnd) Then
      Begin
        If Assigned(fatVendas) Then
        Begin
          fatVendas.strCodCnd := strCodCnd;
          fatVendas.strConPag := strConPag;
          fatVendas.blnCndEsp := blnCndEsp;
          fatVendas.pAtualizaInformacoesCondPagamento;
          fatVendas.pCalculaTaxVpr;
        End;
      End;
    End;
  End;

  If blnFechar Then
    Close;
End;

{ ******************************************* }
{ * PREPARA O DATASET PARA UMA NOVA VENDA   * }
{ ****************************************RL* }
procedure TfrmCaixa.pPreparaDataSet;
Var
  prcScroll: TprcScroll;
begin
  Try
    TProQtdColetiva.pLimpar;
    TProQtdColetiva.OpcSys := tRegSysCaixa;

    If Assigned(fatVendas) Then
      FreeAndNil(fatVendas);

    fatVendas := TFatVenda.CreateInstance('VN');
    fatVendas.strOpcDocTrue := 'F3';
    fatVendas.blnConfOrcamento := True;
    fatVendas.blnVerEstOrc := False;
    fatVendas.strNomeForm := 'frmFatVendas';
    fatVendas.strIdePro := 'NOR';
    fatVendas.strTabPre := strTabPre;
    fatVendas.strCodCli := strCodCli;
    fatVendas.strCliEst := strEstCli;
    fatVendas.blnExisteCampanha := fatVendas.objCamGer.fExisteCampanha(VS_Date);
    fatVendas.blnExisteBonus := fatVendas.objBonGer.fExisteBonus(VS_Date);

    fatVendas.strOriF11 := 'S';
    fatVendas.blnOriF3  := True;

    fatVendas.fltDescProfissional := fRetDescontoCliente(fatVendas.strCodCli);
    fatVendas.fltDescFidelidade := fRetDescontoFidelidade(fatVendas.strCodCli);

    pDisableControls(cdsItens, prcScroll);

    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin

      If cdsItens.FieldByName('ITE_ITEPED').AsString <> 'S' Then
      Begin
        objCodBar.pDelCodBar(cdsItens.FieldByName('ITE_CODITE').AsString);

        pExcluiSerieAposExcluirItem(cdsItens.FieldByName('ITE_AUTINC').AsString);

        fGravaCheckout(cdsItens.FieldByName('ITE_CHKOUT').AsInteger,
                       strOpeRcx,
                       strCodCli,
                       strCodVen,
                       cdsItensITE_CODBAR.AsString,
                       cdsItensITE_CODITE.AsString,
                       cdsItensITE_DESITE.AsString,
                       cdsItensUNI_DESUNI.AsString,
                       cdsItensITE_QTDITE.AsFloat,
                       cdsItensITE_UNITAR.AsFloat,
                       cdsItensITE_TOTITE.AsFloat,
                       VS_ComputerNetName,
                       VS_IPAddressAsString,
                       VS_UserFromWindows,
                       'E',
                       False,
                       FcdsChkOut,
                       FcdsLogChk);

        cdsItens.Delete;
        Continue;
      End;

      cdsItens.Next;
    End;

    //persiste o controle.
    pPersisteChkOut(FcdsChkOut, 'CHKOUT') ;
    pPersisteChkOut(FcdsLogChk, 'LOGCHK') ;

    pEnableControls(cdsItens, prcScroll);

    edtCodBarra.Clear;
    edtCodBarra.Enabled := True;

    pnlStatusCaixa.Caption := 'Passe o Produto Desejado!';

    blnItemEspecial := False;
  Except
    On E: Exception Do
      fMensagem('ATENÇÃO!', 'Ocorreu um erro na liberação do caixa!' + E.Message, ['&OK']);
  End;

end;

procedure TfrmCaixa.dbgItensPROMOCGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  Atext := NullAsStringValue;
end;

procedure TfrmCaixa.dbgItensSALDOSGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  Atext := NullAsStringValue;
end;

function TfrmCaixa.fRecalculaItensPromocaoValorMinTotProdutos(strCodIte,
  strCodigoUnidadeMedida: String; blnDel: Boolean; strRshDel, strRshAut: String): Boolean;
Var
  strCodPro: String;
  blnRecalcular: Boolean;
  blnAtvPro: Boolean;
begin
  Try
    pAddItemSemPromocaoProValorMinTotProdutos(strCodIte);

    If (Not objPromVlrMinTotalProdutos.fPossuiItensPromocaoVlrMinimo) Then
      Exit(False);

    blnRecalcular := fAtualizarItensPromocaoVlrMin(strCodIte, strCodigoUnidadeMedida, strRshAut);

    strCodPro := objPromVlrMinTotalProdutos.fGetCodPro(strCodIte);
    blnAtvPro := objPromVlrMinTotalProdutos.fAtivaPromocao(strCodPro, strCodIte, strCodigoUnidadeMedida);

    Result := blnRecalcular or blnAtvPro;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'');
    End;
  End;
end;

function TfrmCaixa.fVerificaPodeExcluirItemPromVlrMin(const strCodIte: String): Boolean;
var
  fltVlrTotIte: Double;
  blnDisabled: Boolean;
  blnFiltered: Boolean;
  strFilter: String;
  intRecNo: Integer;
  prcScroll: TprcScroll;
Begin
  blnDisabled := False;
  blnFiltered := cdsItens.Filtered;
  strFilter := cdsItens.Filter;
  intRecNo := cdsItens.RecNo;
  fltVlrTotIte := 0;

  If (Not cdsItens.ControlsDisabled) Then
  Begin
    blnDisabled := True;
    pDisableControls(cdsItens, prcScroll);
  End;

  Try

    cdsItens.Filtered := False;
    cdsItens.Filter   := 'ITE_CODITE = ' + QuotedStr( strCodIte );
    cdsItens.Filtered := True;

    If (Not cdsItens.IsEmpty) Then
    Begin
      cdsItens.First;
      While Not cdsItens.Eof Do
      Begin
        fltVlrTotIte := fltVlrTotIte + cdsItens.FieldByName('ITE_TOTITE').AsFloat;
        cdsItens.Next;
      End;
    End;

    Result := (fltVlrTotIte = 0);

  Finally

    cdsItens.Filter := strFilter;
    cdsItens.Filtered := blnFiltered;
    cdsItens.RecNo := intRecNo;

    If (blnDisabled) Then
      pEnableControls(cdsItens, prcScroll, True);

  End;
End;

function TfrmCaixa.fRecalculaPrecosInterna(pgbStatus: TcxProgressBar = Nil): Boolean;
  Const
    INT_PROGRESSO_MAX = 2;
  var
    objRecalculaPrecos : TRecalcPrecosCheckOut;
    intProgresso : Integer;
begin
  Result := False;

  if cdsItens.IsEmpty then
    Exit;

  intProgresso := 0;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Recalculando Preços, Aguarde...', pgbStatus);

  objRecalculaPrecos := TRecalcPrecosCheckOut.Create;

  try
    If Assigned(fatVendas) Then
    begin
      objRecalculaPrecos.fatVendas := fatVendas;
      objRecalculaPrecos.cdsItens  := cdsItens;

      objRecalculaPrecos.stlItensParaRecalcular := Nil;
      If Assigned(Self.stlItensParaRecalcular) Then
        objRecalculaPrecos.stlItensParaRecalcular := Self.stlItensParaRecalcular;

      objRecalculaPrecos.pRecalculaPrecosItens(Self.strConPag,
                                               Self.blnCalculaTaxCndF3InicioCx,
                                               Self.strCodCli,
                                               Self.strTabPre,
                                               blnItemEspecial,
                                               'N',
                                               '',
                                               '',
                                               blnManterPrecoDigitado,
                                               objPromVlrMinTotalProdutos);
    end;
  finally
    FreeAndNil(objRecalculaPrecos);
  end;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Finalizando Recalculo dos Preços, Aguarde...', pgbStatus);
end;

procedure TfrmCaixa.pVerificaSeItensTeraoModificacaoAposCondicaoPagamento(Var blnItensEntraramOuSairamDePromocao: Boolean;
                                                                          Var blnItensTiveramUnitarModificados: Boolean);
  var
    objRecalculaPrecos : TRecalcPrecosCheckOut;
    oleCdsItens: OleVariant;
    oleCdsVenda: OleVariant;
begin
  if cdsItens.IsEmpty then
    Exit;

  objRecalculaPrecos := TRecalcPrecosCheckOut.Create;

  oleCdsItens  := cdsItens.Data;
  oleCdsVenda  := cdsVenda.Data;
  Try
    If Assigned(fatVendas) Then
    begin
      fatVendas.strCodCnd := strCodCnd;
      fatVendas.strConPag := strConPag;
      fatVendas.blnCndEsp := blnCndEsp;
      fatVendas.pCalculaTaxVpr;

      objRecalculaPrecos.fatVendas := fatVendas;
      objRecalculaPrecos.cdsItens  := cdsItens;
      objRecalculaPrecos.pRecalculaPrecosItens(Self.strConPag,
                                               Self.blnCalculaTaxCndF3InicioCx,
                                               Self.strCodCli,
                                               Self.strTabPre,
                                               blnItemEspecial,
                                               'N',
                                               '',
                                               '',
                                               False,
                                               objPromVlrMinTotalProdutos);

      blnItensEntraramOuSairamDePromocao := objRecalculaPrecos.blnItensEntraramOuSairamDePromocao;
      blnItensTiveramUnitarModificados   := objRecalculaPrecos.blnItensTiveramUnitarModificados;
    end;
  Finally
    FreeAndNil(objRecalculaPrecos);

    cdsItens.Data := oleCdsItens;
    cdsVenda.Data := oleCdsVenda;
  End;
end;

procedure TfrmCaixa.pRecalculaPrecos;
  var
    intRecNo : Integer;
    prcScroll: TprcScroll;
begin
  intRecNo := 0;

  Try
    pDisableControls(cdsItens, prcScroll);
    intRecNo := cdsItens.RecNo;

    Try
      fChamaTelaGravando(fRecalculaPrecosInterna);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

  Finally

    If (intRecNo <= cdsItens.RecordCount) Then
      cdsItens.RecNo := intRecNo
    Else
      cdsItens.Last;

    pEnableControls(cdsItens, prcScroll);
  End;
end;

procedure TfrmCaixa.pRecalculaPrecosSomenteStringList(stlItens: TStringList);
begin
  Self.stlItensParaRecalcular := stlItens;
  Try
    pRecalculaPrecos;
  Finally
    Self.stlItensParaRecalcular := Nil;
  End;
end;

procedure TfrmCaixa.pRecalculaPrecosSomentPromoVlrMin;
Var
    stlItens: TStringList;
begin
  stlItens := TStringList.Create;

  Self.stlItensParaRecalcular := stlItens;
  Try
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      If objPromVlrMinTotalProdutos.fCodItePossuiPromo(cdsItens.FieldByName('ITE_CODITE').AsString) Then
        stlItens.Add(cdsItens.FieldByName('ITE_CODITE').AsString);

     cdsItens.Next;
    End;

    pRecalculaPrecos;
  Finally
    Self.stlItensParaRecalcular := Nil;

    FreeAndNil(stlItens);
  End;
end;

procedure TfrmCaixa.pRecalcularItensPromocaoValorMinTotProdutos(const strCodIte,
  strCodUni: String; blnDel: Boolean; strRshDel, strRshAut,
  strRshTinAtual: String);
Var
  blnRecalcular: Boolean;
begin
  If Not fCfgSis('UTIVMP', varBoolean) Then
    Exit;

  If blnDel Then
    blnRecalcular := fExcluirItensPromocaoValorMinTotProdutos(strCodIte,
                                                              strCodUni,
                                                              strRshDel,
                                                              strRshAut)
  Else
    blnRecalcular := fRecalculaItensPromocaoValorMinTotProdutos(strCodIte,
                                                                strCodUni,
                                                                blnDel,
                                                                strRshDel,
                                                                strRshAut);

  If blnRecalcular Then
  Begin
    pRecalculaPrecosSomentPromoVlrMin;
  End;
end;

procedure TfrmCaixa.pRecalculaPrecosSomenteItensPromo;
  Var
    stlItens: TStringList;
begin
  stlItens := TStringList.Create;

  Self.stlItensParaRecalcular := stlItens;
  Try
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      If (Not fItemSemNenhumaPromocao(cdsItens.FieldByName('ITE_CODITE').AsString, VS_strCodEmp)) Then
        stlItens.Add(cdsItens.FieldByName('ITE_CODITE').AsString);

     cdsItens.Next;
    End;

    pRecalculaPrecos;
  Finally
    Self.stlItensParaRecalcular := Nil;

    FreeAndNil(stlItens);
  End;
end;

procedure TfrmCaixa.pRetificarPrecoDoItem;
Var
  strSenOpe: String;
  strCodOpe: String;
  strCodIte: String;
  fltQtdIte: Double;
  fltUnitar: Double;
begin
  If Not fCfgSis('RETPF3', VarBoolean) Then
    Exit;

  If Not ffrmSenha(strSenOpe) Then
    Exit;

  strCodOpe := fRetCodVendedor(strSenOpe);

  If fEmptyStr(strCodOpe) Then
    Exit;

  If Not fVerificaAcessoSistema('RETPREF3', strCodOpe) Then
  Begin
    pMensagemOk('Usuário não tem permissão para retificar preço de item!');
    Exit;
  End;

  If (fEmptyStr(strCodVen)) And Not fInformouVendedor() Then
    Exit;

  If Not TfrmRetificarPrecoCheckout.fRetificarPreco(strCodOpe, strCodCli,
      strTabPre, strCodIte, fltQtdIte, fltUnitar) Then
    Exit;

  If Not fProcessaItemGeral(iteRetificacaoPreco, strCodIte, fltUnitar, fltQtdIte, '',
      '', '', 'NOR', 'N', '', '', '', strCodVen) Then
    Exit;

  pMensagemOk('Retificação de preço foi realizada com sucesso!');
end;

procedure TfrmCaixa.dbgItensViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Var
  fltQTDEXP, fltQTDITE, fltSALDOS: Double;
  strITEPED, strPROMOC: String;
  AImage: TdxSmartImage;
  ARect: TRect;

  procedure pDesenhaIndicador(intIndex: Integer);
  begin
    Try
      AImage := TdxSmartImage.Create;
      Try
        imgIndica.GetImage(intIndex, AImage);
        ARect := AViewInfo.Bounds;
        ACanvas.FillRect(ARect, ACanvas.Brush.Color);
        ARect.Left := ARect.Left + (ARect.Width div 2) - (imgIndica.Width div 2);
        ARect.Right := ARect.Left + imgIndica.Width;
        ARect.Top := ARect.Top + (ARect.Height div 2) - (imgIndica.Height div 2);
        ARect.Bottom := ARect.Top + imgIndica.Height;
        AImage.StretchDraw(ACanvas.Handle, ARect);
      Finally
        AImage.Free;
      End;
    Except
      //
    End;

    ADone := True;
  end;

begin
  inherited;

  If Assigned(dbgItensView.DataController.DataSource.DataSet) And (Not dbgItensView.DataController.DataSource.DataSet.IsEmpty) Then
  Begin
    If (AViewInfo.GridRecord.Selected) and
       (AViewInfo.GridView.Site.Focused) and
       (not AViewInfo.Item.Focused) then
    begin
      ACanvas.Brush.Color := clHighlight;
      ACanvas.Font.Color := clHighlightText;
    end
    else if Odd(AViewInfo.GridRecord.Index) then
    begin
      ACanvas.Brush.Color := clMoneyGreen;
      ACanvas.Font.Color := clWindowText;
    end
    else
    begin
      ACanvas.Brush.Color := clWindow;
      ACanvas.Font.Color := clWindowText;
    end;

    strITEPED := VarAsType(IfNull(dbgItensView.ViewData.Records[AViewInfo.GridRecord.Index].Values[dbgItensITEPED.Index], 'N'), varString);
    fltSALDOS := VarAsType(IfNull(dbgItensView.ViewData.Records[AViewInfo.GridRecord.Index].Values[dbgItensSALDOS.Index], 0), varDouble);
    strPROMOC := VarAsType(IfNull(dbgItensView.ViewData.Records[AViewInfo.GridRecord.Index].Values[dbgItensPROMOC.Index], 'N'), varString);

    If (strITEPED = 'S') Then
    Begin
      fltQTDITE := VarAsType(IfNull(dbgItensView.ViewData.Records[AViewInfo.GridRecord.Index].Values[dbgItensQTDITE.Index], 0), varDouble);
      fltQTDEXP := VarAsType(IfNull(dbgItensView.ViewData.Records[AViewInfo.GridRecord.Index].Values[dbgItensQTDEXP.Index], 0), varDouble);

      If (fltQTDEXP = 0) Then
        ACanvas.Font.Color := clRed

      Else If (fFormataFloat(fltQTDEXP, 4) < fFormataFloat(fltQTDITE, 4)) Then
        ACanvas.Font.Color := clBlue

      Else If (fFormataFloat(fltQTDEXP, 4) >= fFormataFloat(fltQTDITE, 4)) Then
        ACanvas.Font.Color := clGreen;
    End;

    //ATENÇÃO: SEMPRE DEIXAR ESSE BLOCO POR ÚLTIMO...
    If (AViewInfo.Item = dbgItensSALDOS) And (fltSALDOS <= 0) Then
    Begin
      pDesenhaIndicador(0);
    End;

    If (AViewInfo.Item = dbgItensPROMOC) And (strPROMOC = 'S') Then
    Begin
      pDesenhaIndicador(1);
    End;
    //...ATENÇÃO: SEMPRE DEIXAR ESSE BLOCO POR ÚLTIMO
  End;
end;

procedure TfrmCaixa.dbgItensViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
Var
  blnPodeCancelar: Boolean;
  strCodIteDel,
  strCodUniDel: String;
  ItemEstrutura: TItemEstru;
begin
  inherited;

  If (Not blnCancelarItem) Then
  Begin
    pSetFocus(edtCodBarra);
    Exit;
  End;

  Try

    If (Key = VK_Delete) And blnCancelarItem Then
    Begin

      If cdsItens.FieldByName('ITE_ITEPED').AsString = 'S' Then
      Begin
        fMensagem('', 'Não é possivel a exclusão de itens do pedido!', ['&OK']);
        Exit;
      End;

      If (cdsItens.FieldByName('ITE_SEQEST').AsInteger > 0) And
         (Not fPermiteVenderSubItemEstruturaAvulso(cdsItens.FieldByName('ITE_CODITE').AsString)) Then
      Begin
        ItemEstrutura := fEhOuCompoeEstrutura(cdsItens.FieldByName('ITE_CODITE').AsString, VS_strCodEmp);
        If (ItemEstrutura.blnEstrutura) And (Not ItemEstrutura.blnPrincipal) Then
        Begin
          If fPergunta('Não é permitido excluir sub-produto da estrutura em separado, somente a estrutura completa.' + sLineBreak +
                       IIF(fCfgSis('VENSUB') = 'P', 'Serão excluídos os sub-produtos que não são permitidos informar separadamente na venda. ',
                                                    'Serão excluídos todos os sub-produtos da estrutura. ') +
                       'Deseja prosseguir?', False) Then
            pDeletaSubItensEstrutura;
          Exit;
        End;
      End;

      If fMensagem('', 'Deseja remover o produto selecionado?', ['&Sim', '&Não'], 2) = 1 Then
      Begin

        If fConcomitante Then
        Begin
          blnPodeCancelar := fSenhaResponsavel;
        End
        Else
        Begin
          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('Não é permitido a exclusão de itens na confirmação ' + IIF(strEspCfo = 'PD', 'pedido', 'orçamento') + '/venda.');

          objLiberacao.strDirAce := 'EXITF11';
          objLiberacao.strSenLib := fCfgSis('SENLBD');
          objLiberacao.strMsgSen := 'Exclusão Itens na confirmação ' + IIF(strEspCfo = 'PD', 'pedido', 'orçamento') +            '/venda pelo resumo caixa';
          objLiberacao.blnMosMen := True;
          objLiberacao.strCodOpe := IIF(fEmptyStr(strCodVen), strOpeRcx, strCodVen);
          objLiberacao.strCodDig := strOpeRcx;
          objLiberacao.strCodIte := cdsItens.FieldByName('ITE_CODITE').AsString;
          objLiberacao.strSenLibNv2 := fCfgSis('SENLN2');
          objLiberacao.strCliente := strCodCli;
          objLiberacao.strCpfCnpj := fRetCgcCpf(strCodCli);
          objLiberacao.blnUsarSenhaFixa := False;

          blnPodeCancelar := objLiberacao.fLibera;
        End;

        If blnPodeCancelar Then
        Begin
          If fCancelarItem(cdsItens.FieldByName('ITE_NUMITE').AsInteger, cdsItens.FieldByName('ITE_QTDITE').AsFloat, cdsItens.FieldByName('ITE_UNITAR').AsFloat) Then
          Begin
            strCodIteDel := cdsItens.FieldByName('ITE_CODITE').AsString;
            strCodUniDel := cdsItensITE_CODUNI.AsString;
            // Grava log de exclusão de itens
            pGravarLogExclusaoItem(cdsItens.FieldByName('ITE_CODITE').AsString,
                                   cdsItens.FieldByName('ITE_QTDITE').AsFloat,
                                   objLiberacao.strOperador);

            pExcluiSerieAposExcluirItem(cdsItens.FieldByName('ITE_AUTINC').AsString);

            fGravaCheckout(cdsItens.FieldByName('ITE_CHKOUT').AsInteger,
                           strOpeRcx,
                           strCodCli,
                           strCodVen,
                           cdsItensITE_CODBAR.AsString,
                           cdsItensITE_CODITE.AsString,
                           cdsItensITE_DESITE.AsString,
                           cdsItensUNI_DESUNI.AsString,
                           cdsItensITE_QTDITE.AsFloat,
                           cdsItensITE_UNITAR.AsFloat,
                           cdsItensITE_TOTITE.AsFloat,
                           VS_ComputerNetName,
                           VS_IPAddressAsString,
                           VS_UserFromWindows,
                           'E',
                           False,
                           FcdsChkOut,
                           FcdsLogChk);

            cdsItens.Delete;
            If (stlItensPromoPorQtdMinQtdLim.IndexOf(strCodIteDel) >= 0) Then
            Begin
              fatVendas.pLimpaDeletadosDoArrPromocaoQtdeColetiva(-1, 'PD', fGridVendaVazio, cdsItens);
              pRecalculaPrecosSomenteStringList(stlItensPromoPorQtdMinQtdLim);
            End;
          End;

          pRecalcularItensPromocaoValorMinTotProdutos(strCodIteDel,
                                                      strCodUniDel,
                                                      True, '', '', '');
        End;

      End;
    End
    Else If (Key = VK_Escape) Then
    Begin
      pnlStatusCaixa.Caption := 'Passe o Produto Desejado!';
      blnCancelarItem := False;
      pSetFocus(edtCodBarra);
    End;

  Except
    On E: Exception Do
    Begin
      blnCancelarItem := False;
      pSetFocus(edtCodBarra);
    End;
  End;

  If cdsItens.IsEmpty Then
    pSetFocus(edtCodBarra);
end;

function TfrmCaixa.fConcomitante: Boolean;
begin
  Result := blnConcomitante And Assigned(VS_ObjFiscal);
end;

function TfrmCaixa.fConsiderarTipoDeVendaUnidadeOuPeso: Boolean;
begin
  Result := fCfgSis('TIPBAL', varBoolean);
end;

function TfrmCaixa.fAbrirCupom: Boolean;
  procedure pCarregaDadosCadastraisConsumidor;
  Var
    qryCliCon: TUniQuery;
    strCodCli, strCodCid: String;
  begin
    qryCliCon := fCriaQuery;

    With qryCliCon Do
    Begin
      pPesquisaCadCliCon(qryCliCon, qryCliCon, strCpfDigitado);

      If (Not IsEmpty) And (Not fEmptyStr(FieldByName('CON_C_P_F_').AsString)) Then
      Begin
        VS_ObjFiscal.strNomCli := FieldByName('CON_NOMCON').AsString;
        VS_ObjFiscal.strEndCli := FieldByName('CON_ENDERE').AsString;
        VS_ObjFiscal.strBaiCli := FieldByName('CON_BAIRRO').AsString;
        VS_ObjFiscal.strCepCli := FieldByName('CON_C_E_P_').AsString;

        strCodCid := FieldByName('CON_CODCID').AsString;

        If intCgcCpfDigitado = 1 Then
          VS_ObjFiscal.strRG_Cli := FieldByName('CON_I_E_S_').AsString
        Else
          VS_ObjFiscal.strRG_Cli := FieldByName('CON_NUMR_G').AsString;

        VS_ObjFiscal.strTelCli := FieldByName('CON_FONE01').AsString;
      End
      Else
      Begin
        strCodCli := fRetClientePorCgcCpf(intCgcCpfDigitado, fTiraCaracEspeciais(strCpfDigitado));

        If Not fEmptyStr(strCodCli) Then
        Begin
          pPesquisaCadCli(qryCliCon, qryCliCon, strCodCli);

          If (Not IsEmpty) And (Not fEmptyStr(FieldByName('CLI_C_G_C_').AsString)) Then
          Begin
            VS_ObjFiscal.strCodCli := strCodCli;
            VS_ObjFiscal.strNomCli := FieldByName('CLI_NOMCLI').AsString;
            VS_ObjFiscal.strEndCli := FieldByName('CLI_ENDERE').AsString + ' ' + FieldByName('CLI_ENDNUM').AsString + ' ' + FieldByName('CLI_ENDCOM').AsString;
            VS_ObjFiscal.strBaiCli := FieldByName('CLI_BAIRRO').AsString;
            VS_ObjFiscal.strCepCli := FieldByName('CLI_C_E_P_').AsString;

            strCodCid := FieldByName('CLI_CODCID').AsString;

            If intCgcCpfDigitado = 1 Then
              VS_ObjFiscal.strRG_Cli := FieldByName('CLI_I_E_S_').AsString
            Else
              VS_ObjFiscal.strRG_Cli := FieldByName('CLI_NUMR_G').AsString;

            VS_ObjFiscal.strTelCli := FieldByName('CLI_FONE01').AsString;
          End;
        End;
      End;
    End;

    VS_ObjFiscal.strCidCli := fCampoTabela('CID_NOMCID','CADCID',['CID_CODCID'],[strCodCid], False);
    VS_ObjFiscal.strEstCli := fCampoTabela('CID_ESTADO','CADCID',['CID_CODCID'],[strCodCid], False);

    FreeAndNil(qryCliCon);

  end;

begin
  Result := True;
  If Not fConcomitante Then
    Exit;

  If cdsItens.IsEmpty Then
  Begin
    If VS_ObjFiscal.EstadoECF = ecfPronta Then
      pCarregaDadosCadastraisConsumidor;

    VS_ObjFiscal.strCgcCpf := strCpfDigitado;
    VS_ObjFiscal.strCpfCupomFiscal := strCpfDigitado;
    VS_ObjFiscal.strCpfClie := strCpfDigitado;

    If VS_ObjFiscal.EstadoECF = ecfPronta Then
      Result := VS_ObjFiscal.fAbreCupom;
  End;
end;

function TfrmCaixa.fAtualizarItensPromocaoVlrMin(const strCodIte,
  strCodigoUnidadeMedida, strRshAut: String): Boolean;
var
  strCodPro: String;
  blnDisabled : Boolean;
  strFilter : String;
  blnFiltered : Boolean;
  fltVlrTotIte : Double;
  intRecNo : Integer;
  prcScroll: TprcScroll;
  intCnt : Integer;
Begin
  Result := False;

  blnDisabled := False;
  blnFiltered := cdsItens.Filtered;
  strFilter := cdsItens.Filter;
  intRecNo := cdsItens.RecNo;

  If (Not cdsItens.ControlsDisabled) Then
  Begin
    blnDisabled := True;
    pDisableControls(cdsItens, prcScroll);
  End;

  Try
    strCodPro := objPromVlrMinTotalProdutos.fGetCodPro(strCodIte);

    For intCnt := Low(objPromVlrMinTotalProdutos.ArrItemPro) To High(objPromVlrMinTotalProdutos.ArrItemPro) Do
    Begin
      If objPromVlrMinTotalProdutos.ArrItemPro[intCnt].strCodIte <> strCodIte Then
        Continue;

      cdsItens.Filtered := False;
      cdsItens.Filter   := 'ITE_CODITE = ' + QuotedStr( objPromVlrMinTotalProdutos.ArrItemPro[intCnt].strCodIte );
      cdsItens.Filtered := True;

      fltVlrTotIte := 0;
      If (Not cdsItens.IsEmpty) Then
      Begin
        cdsItens.First;
        While Not cdsItens.Eof Do
        Begin
          fltVlrTotIte := fltVlrTotIte + cdsItens.FieldByName('ITE_TOTITE').AsFloat;

          cdsItens.Next;
        End;

        If objPromVlrMinTotalProdutos.fCodIteExiste(strCodPro, strCodIte, strCodigoUnidadeMedida) Then
          Result := Result Or objPromVlrMinTotalProdutos.fAddOrUpdateItem(objPromVlrMinTotalProdutos.ArrItemPro[intCnt].strCodIte,
                                                                          objPromVlrMinTotalProdutos.ArrItemPro[intCnt].strCodUnidade,
                                                                          objPromVlrMinTotalProdutos.ArrItemPro[intCnt].strCodPro,
                                                                          strRshAut,
                                                                          fltVlrTotIte,
                                                                          objPromVlrMinTotalProdutos.ArrItemPro[intCnt].fltQtdLim,
                                                                          fltVlrTotIte);
      End;
    End;

  Finally
    cdsItens.Filter := strFilter;
    cdsItens.Filtered := blnFiltered;
    cdsItens.RecNo := intRecNo;

    If (blnDisabled) Then
      pEnableControls(cdsItens, prcScroll, True);
  End;
End;
function TfrmCaixa.fRegistrarItem(strCodIte, strDesIte, strUnidad: String; fltAlqIcm, fltQtdIte, fltUnitar: Double; strCodFis: String; fltTotal: Double): Boolean;
begin
  Result := True;
  If Not fConcomitante Then
    Exit;

  Result := VS_ObjFiscal.fRegistraItem(strCodIte, strDesIte, strUnidad, fltAlqIcm, fltQtdIte, fltUnitar, strCodFis, 0, fltTotal);
end;

function TfrmCaixa.fCancelarCupom: Boolean;
begin
  Result := True;
  If Not fConcomitante Then
    Exit;

  Result := VS_ObjFiscal.fCancelaCupom;
end;

function TfrmCaixa.fCancelarItem(intNumItem: Integer; fltQtdIte, fltUnitar: Double): Boolean;
begin
  Result := True;
  If Not fConcomitante Then
    Exit;

  Result := VS_ObjFiscal.fCancelaItem(IntToStr(intNumItem), fltQtdIte, fltUnitar);
end;

procedure TfrmCaixa.pCancelaCupomCasoEstejaAberto;
begin
  If fConcomitante Then
  Begin
    If (VS_ObjFiscal.EstadoECF = ecfCupomAberto) Then
    Begin
      VS_ObjFiscal.fCancelaCupom;
    End;
  End;
end;

procedure TfrmCaixa.pCancelaItemEspecial;
begin
  edtValUnitario.Properties.ReadOnly := True;
  edtValUnitario.Enabled := False;
  pSetFocus(edtCodBarra);
  blnItemEspecial := False;

  edtCodBarra.Clear;
  edtQtd.Value := 1;
  edtValUnitario.Value := 0;
end;

procedure TfrmCaixa.pDigitaCpfCnpj;
begin
  If (cdsItens.IsEmpty) And (blnConcomitante) And (Not fEmptyStr(edtCodBarra.Text)) Then
  Begin
    If (Assigned(VS_ObjFiscal)) And (VS_ObjFiscal.EstadoECF = ecfPronta) Then
    Begin
      intCgcCpfDigitado := 0;
      strCpfDigitado := '';

      pCriarFormularios(TfrmFatDigCnpj, frmFatDigCnpj);
      frmFatDigCnpj.edtCgcCpf.Text := '2';
      frmFatDigCnpj.blnCGCRep := False;
      frmFatDigCnpj.blnPermiteBranco := True;

      Try
        If frmFatDigCnpj.ShowModal = mrOk Then
        Begin
          intCgcCpfDigitado := StrToIntDef(frmFatDigCnpj.edtCgcCpf.Text, 0);
          strCpfDigitado := frmFatDigCnpj.edtNumCgc.Text;
        End;
      Finally
        pFreeAndNil(frmFatDigCnpj);
      End;
    End;
  End;
end;

function TfrmCaixa.fItemExpedicao(strCodIte, strCodBarExp: String; Out outStrCodVen: String): Boolean;
Var
  cdsAux: TUniClientDataSet;
Begin
  cdsAux := TUniClientDataSet.Create(Nil);
  outStrCodVen := '';
  Try
    cdsAux.Data := cdsItens.Data;
    cdsAux.Filter := 'ITE_CODITE = ' + QuotedStr(strCodIte) + ' AND ITE_ITEPED = ' + QuotedStr('S') + ' AND ITE_QTDEXP < ITE_QTDITE';
    If (Not fEmptyStr(strCodBarExp)) Then
      cdsAux.Filter := cdsAux.Filter + ' AND ITE_CODBAR = ' + QuotedStr(strCodBarExp);
    cdsAux.Filtered := True;
  Finally
    Result := Not cdsAux.IsEmpty;
    If Result Then
      outStrCodVen := cdsAux.FieldByName('ITE_CODVEN').AsString;
    FreeAndNil(cdsAux);
  End;
End;

function TfrmCaixa.fVendedorJaInformadoItensCheckout(): String;
Var
  cdsAux: TUniClientDataSet;
Begin
  Result := '';

  If Not Assigned(cdsItens) Then
    Exit;

  If Not cdsItens.Active Then
    Exit;

  cdsAux := TUniClientDataSet.Create(Nil);
  Try
    cdsAux.Data := cdsItens.Data;
    cdsAux.Filter := 'ITE_ITEPED <> ' + QuotedStr('S');
    cdsAux.Filtered := True;
  Finally
    If Not cdsAux.IsEmpty Then
      Result := cdsAux.FieldByName('ITE_CODVEN').AsString;
    FreeAndNil(cdsAux);
  End;
End;

procedure TfrmCaixa.pIniciaVenda;
begin
  fIniciaVenda;
  pPreparaDataSet;
  fltDesEspCx := 0;
  fltPorDesCx := 0;
  fltTotGerCx := 0;
end;

function TfrmCaixa.fItemPendenteExp(const strCodIte, strCodBarExp: String): Boolean;
begin
  Result := False;

  If cdsItens.FieldByName('ITE_ITEPED').AsString <> 'S' Then
    Exit;

  If cdsItens.FieldByName('ITE_CODITE').AsString <> strCodIte Then
    Exit;

  If Not fEmptyStr(strCodBarExp) Then
  Begin
    If cdsItens.FieldByName('ITE_CODBAR').AsString <> strCodBarExp Then
      Exit;
  End;

  If fFormataFloat(cdsItens.FieldByName('ITE_QTDEXP').AsFloat, 4) >=
     fFormataFloat(cdsItens.FieldByName('ITE_QTDITE').AsFloat, 4) Then
    Exit;

  Result := True;
end;

function TfrmCaixa.fItensExcecaoCampanha: TArrString;
  Var
    intCnt : Integer;
begin
  SetLength(Result, 0);

  If Not Assigned(fatVendas) Then
    Exit;

  SetLength(Result, fatVendas.objCamGer.objCamDet.stlItensNaoTemCampanha.Count);
  For intCnt := 0 To Pred(fatVendas.objCamGer.objCamDet.stlItensNaoTemCampanha.Count) Do
    Result[intCnt] := fatVendas.objCamGer.objCamDet.stlItensNaoTemCampanha.Strings[intCnt];
end;

function TfrmCaixa.fMensagemLiberacaoProdutoSemSaldo(strNumLot, strCodIte: String; fltSaldo, fltQuant: Double): Boolean;
  Var
    strCodOpe: String;
begin
  strCodOpe := IIF(fEmptyStr(strCodVen), strOpeRcx, strCodVen);

  objLiberacao.Clear;

  If (Not fEmptyStr(strNumLot)) Then
  Begin
    objLiberacao.objMsgLibera.pAddTexto('Produto ' + strCodIte + '-' + fRetNomProduto(strCodIte) + ' não possui saldo suficiente no seu lote de cadastro para saída check-out!');
    objLiberacao.objMsgLibera.pAddTextoCaption('Lote'                        , strNumLot                                                                        , 29);
  End
  Else
    objLiberacao.objMsgLibera.pAddTexto('Produto ' + strCodIte + '-' + fRetNomProduto(strCodIte) + ' não possui saldo suficiente!');
  objLiberacao.objMsgLibera.pAddTextoCaption('Marca'                         , fRetNomMarcaItem(strCodIte)                                                      , 29);
  objLiberacao.objMsgLibera.pAddTextoCaption('Qtd. Digitada'                 , FloatToStrF(fltQuant, ffNumber, 12, fCfgSis('DECQTD', varInteger))              , 29);
  objLiberacao.objMsgLibera.pAddTextoCaption('Saldo Atual'                   , FloatToStrF(fltSaldo, ffNumber, 12, fCfgSis('DECQTD', varInteger))        , 29);

  objLiberacao.strDirAce := 'LBSDVN';
  objLiberacao.blnTraTel := True;
  objLiberacao.strMsgSen := 'Liberação de produto sem saldo - Confirmação de Orçamentos';
  objLiberacao.strCodOpe := IIF(fEmptyStr(strCodVen), strOpeRcx, strCodVen);
  objLiberacao.strCodDig := strOpeRcx;
  objLiberacao.strCodIte := cdsItens.FieldByName('ITE_CODITE').AsString;
  objLiberacao.strCliente := strCodCli;

  If (fCfgSis('TRAEST', varString) = '2') Then
  Begin
    objLiberacao.objMsgLibera.pAddTextoCaption('Empresa', VS_strCodEmp + '-' + fRetNomeEmpresa);
    objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor', strCodOpe   + '-' + fRetNomeOperador(strCodOpe));
  End;

  Result := objLiberacao.fLibera;
end;

function TfrmCaixa.fGetQuantRestanteExp(Const strCodIte, strCodBarExp: String): Double;
  Var
    prcScroll: TprcScroll;
begin
  Result := 0.00;
  pDisableControls(cdsItens, prcScroll);
  Try
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      If fItemPendenteExp(strCodIte, strCodBarExp) Then
      Begin
        Result := Result + fFormataFloat(cdsItens.FieldByName('ITE_QTDITE').AsFloat -
                                         cdsItens.FieldByName('ITE_QTDEXP').AsFloat, 4);
      End;

      cdsItens.Next;
    End;
  Finally
    pEnableControls(cdsItens, prcScroll);
  End;
end;

function TfrmCaixa.fBuscaSaldoLote(strCodItem, strCodLot: String): Double;
var
  objCadLote: TCadLot;
begin
  objCadLote := TCadLot.Create(nil);
  try
    Result := objCadLote.fSaldoLote(strCodItem, VS_strCodEmp, strCodLot);
  finally
    FreeAndNil(objCadLote);
  end;
end;

function TfrmCaixa.fVerificaSaldoItem(strConf: String; fltSaldo: Double;
  fltQuantDig: Double; strMensAviso: String): Boolean;
begin
  Result := False;

  If (CompareValue(fltQuantDig, fltSaldo) = GreaterThanValue) Then
  Begin
    fMensagem('ATENÇÃO', strMensAviso, ['&OK']);

    If (Pos(fCfgSis(strConf), '_T_') > 0) Then
      Exit;
  End;

  Result := True;
end;

function TfrmCaixa.fValidaSaldoItem(strCodIte, strCodLot: String; fltSaldo, fltQuant: Double): Boolean;
  Var
    fltSaldoLote: Double;
    fltSaldoProd: Double;
    fltQtdeTotal: Double;
    blnSaldoDisp: Boolean;
begin
  Result := False;

  If fEmptyStr(strCodLot) Then
  Begin
    If (Pos(fCfgSis('SLDCHK'), '_A_T_') <= 0) Then
      Exit(True);

    fltQtdeTotal := fQtdInseridaDoItem(strCodIte);
    fltSaldoProd := fltSaldo - fltQtdeTotal;
    blnSaldoDisp := fVerificaSaldoItem('SLDCHK', fltSaldoProd, fltQuant,
      'O item selecionado não possui saldo disponível');

    If (Not blnSaldoDisp) And (Not fMensagemLiberacaoProdutoSemSaldo('', strCodIte, fltSaldo, fltQtdeTotal + fltQuant)) Then
      Exit;
  End
  Else
  Begin
    If (Pos(fCfgSis('SLTCHK'), '_A_T_') <= 0) Then
      Exit(True);

    fltSaldoLote := fBuscaSaldoLote(strCodIte, strCodLot);

    If (Not fVerificaSaldoItem('SLTCHK', fltSaldoLote, fltQuant, 'O lote '+strCodLot+
      ' do produto selecionado não possui saldo disponível')) Then
    Begin
      Result := fMensagemLiberacaoProdutoSemSaldo(strCodLot, strCodIte, fltSaldoLote, fltQuant);
      Exit;
    End;
  End;

  Result := True;
end;

function TfrmCaixa.fQtdInseridaDoItem(strCodIte: String): Double;
  Var
    fltQtdItem: Double;
    cdsClone: TUniClientDataSet;
begin
  fltQtdItem := 0;
  cdsClone := TUniClientDataSet.Create(Nil);

  Try
    pCloneDataSet(cdsClone, cdsItens);
    cdsClone.First;

    While (Not cdsClone.Eof) Do
    Begin
      If (Not cdsClone.FieldByName('ITE_CODITE').AsString.Equals(strCodIte)) Then
      Begin
        cdsClone.Next;
        Continue;
      End;

      fltQtdItem := fltQtdItem + cdsClone.FieldByName('ITE_QTDITE').AsFloat;
      cdsClone.Next;
    End;

    Result := fltQtdItem;
  Finally
    FreeAndNil(cdsClone);
  End;
end;

function TfrmCaixa.fValidaQuantidade(qryItem: TUniQuery; LfltQtdIte: Double): Boolean;
Var
  fltValor: Double;
  strMltVen: String;

  function fPedeSenhaMultiploVenda: Boolean;
  begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Item com quantidade fora do Múltiplo de Vendas.');

    objLiberacao.strDirAce := 'SENMTP';
    objLiberacao.strSenLib := fCfgSis('SENMTP');
    objLiberacao.strMsgSen := 'Senha para liberação de venda de item com quantidade fora do múltiplo de venda';
    objLiberacao.strCodOpe := fatVendas.strCodVen;
    objLiberacao.strCodDig := fatVendas.strCodDig;
    objLiberacao.strCodIte := cdsItens.FieldByName('ITE_CODITE').AsString;


    Result := fatVendas.fFatMensagemLiberacao(objLiberacao);
  end;

begin
  Result := True;
  strMltVen := fCfgSis('MLTVEN');

  If LfltQtdIte <= 0 Then
  Begin
    Result := False;
    fMensagem('', 'A quantidade deve ser maior que zero!', ['&OK']);
  End

  { ******************************************* }
  { * VERIFICA MULTIPLO DE VENDA              * }
  { ****************************************AF* }
  Else If qryItem.FieldByName('ITE_MLTVEN').AsFloat > 0 Then
  Begin
    If (fFormataFloat(LfltQtdIte, 4) < fFormataFloat(qryItem.FieldByName('ITE_MLTVEN').AsFloat, 4)) Then
    Begin
      If (strMltVen = '1') Then
      Begin
        Result := False;
        fMensagem('', 'A quantidade deve ser igual ou múltiplo de: ' + FloatToStrF(qryItem.FieldByName('ITE_MLTVEN').AsFloat, ffNumber, 12, 3), ['&OK']);
      End
      Else If (strMltVen = '3') Then
      Begin
        pMensagemSonora('', CHECKOUT_SEM_SUCESSO);
        fMensagem('', 'A quantidade digitada é diferente de um múltiplo de: ' + FloatToStrF(qryItem.FieldByName('ITE_MLTVEN').AsFloat, ffNumber, 12, 3), ['&OK']);
      End
      Else If (strMltVen = '4') Then // Solicita Senha
      Begin
        Result := fPedeSenhaMultiploVenda;

        If (Not Result) Then
          Exit;
      End;
    End
    Else
    Begin
      fltValor := fFormataFloat(LfltQtdIte / qryItem.FieldByName('ITE_MLTVEN').AsFloat, 5);

      If (fltValor - Int(fltValor)) > 0 Then
      Begin
        If (strMltVen = '1') Then
        Begin
          fMensagem('', 'A quantidade deve ser igual ou múltiplo de: ' + FloatToStrF(qryItem.FieldByName('ITE_MLTVEN').AsFloat, ffNumber, 12, 3), ['&OK']);
          Result := False;
        End
        Else If (strMltVen = '3') Then
        Begin
          fMensagem('', 'A quantidade digitada é diferente de um múltiplo de: ' + FloatToStrF(qryItem.FieldByName('ITE_MLTVEN').AsFloat, ffNumber, 12, 3), ['&OK']);
        End
        Else If (strMltVen = '4') Then // Solicita Senha
        Begin
          Result := fPedeSenhaMultiploVenda;

          If (Not Result) Then
            Exit;
        End;
      End;
    End;
  End;
end;

procedure TfrmCaixa.imgProDblClick(Sender: TObject);
begin
  inherited;
  if cdsItens.Active then
  begin
    TfrmImagens.pAbrirImagens(tiProduto, cdsItens.FieldByName('ITE_CODITE').AsString, True);
  end;
end;

procedure TfrmCaixa.pAbrirGaveta;
begin
  If (fCfgSis('USNFCE') = 'S') Or fUsaSat Then
  Begin
    pAbrirGavetaNFCeSAT(fLerImpressora, fLerImpConfGaveta);
  End
  Else If (fConcomitante) Or (Assigned(VS_ObjFiscal)) Then
  Begin
    VS_ObjFiscal.fAbreGaveta;
  End;
end;

procedure TfrmCaixa.pAddItemSemPromocaoProValorMinTotProdutos(
  const strCodIte: String);
var
  intRecNo: Integer;
  strFilter: String;
  blnFiltered: Boolean;
  blnDisabled: Boolean;
  prcScroll: TprcScroll;
  strCodPro: String;
Begin
  blnDisabled := False;

  Try

    If (Not cdsItens.IsEmpty) Then
    Begin
      strFilter := cdsItens.Filter;
      blnFiltered := cdsItens.Filtered;
      intRecNo := cdsItens.RecNo;

      If (Not cdsItens.ControlsDisabled) Then
      Begin
        blnDisabled := True;
        pDisableControls(cdsItens, prcScroll);
      End;

      Try

        strCodPro := objPromVlrMinTotalProdutos.fGetCodPro(strCodIte);

        If Not fEmptyStr(strCodPro) Then
          Exit;

        cdsItens.Filtered := False;
        cdsItens.Filter   := 'ITE_PROMOC = ' + QuotedStr('N');
        cdsItens.Filtered := True;

        cdsItens.First;
        While Not cdsItens.Eof Do
        Begin
          If cdsItens.FieldByName('ITE_CODITE').AsString = strCodIte Then
          Begin
            objPromVlrMinTotalProdutos.faddOrUpdateItem(cdsItens.FieldByName('ITE_CODITE').AsString,
                                                        cdsItens.FieldByName('ITE_CODUNI').AsString,
                                                        '',
                                                        '',
                                                        cdsItens.FieldByName('ITE_TOTITE').AsFloat,
                                                        0);
          End;

          cdsItens.Next;
        End;

      Finally
        cdsItens.Filtered := False;
        cdsItens.Filter   := strFilter;
        cdsItens.Filtered := blnFiltered;
        cdsItens.RecNo    := intRecNo;

        If (blnDisabled) Then
          pEnableControls(cdsItens, prcScroll, True);
      End;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'');
    End;
  End;
End;

procedure TfrmCaixa.pFecharComDesconto;
begin
  If (Not fCfgSis('DESF03',varBoolean)) Then
    Exit;

  If (Assigned(cdsItens)) And (cdsItens.Active) And (cdsItens.IsEmpty) Then
  Begin
    pMensagemSonora('', CHECKOUT_SEM_SUCESSO);
    pMensagemOk('É necessário informar pelo menos 1 item.');
    Exit;
  End;

  {QUANDO CONDIÇÃO ESPECIAL, NÃO PERMITIR INFORMAR DESCONTO}
  If (fCfgSis('CNDPES', VarBoolean)) Then
  Begin
    If Assigned(fatVendas) Then
    Begin
      If (Not fEmptyStr(fatVendas.strCodCnd)) and (fatVendas.blnCndEsp) then
      Begin
        pMensagemOk('Não é permitido informar desconto quando a condição de pagamento for especial!');
        Exit;
      End;
    End;
  End;

  If Not fSenhaResponsavel Then
    Exit;

  If InterlockedIncrement(intSemaforoConfirma) = 0 Then
  Begin
    Try

      If Not fExpedicaoPendente Then
      Begin
        Self.blnFechamentoNormal := False;

        If fPedirDesconto Then
        Begin
          Close;
          ModalResult := mrOk;
        End;

      End;

      InterlockedDecrement(intSemaforoConfirma);

    Except
      On E: Exception Do
      Begin
        InterlockedDecrement(intSemaforoConfirma);
        pMensagensErro(E.Message, '[pConfirma]');
      End;
    End;
  End
  Else
  Begin
    InterlockedDecrement(intSemaforoConfirma);
  End;
end;

procedure TfrmCaixa.pGravarLogExclusaoCancelaCupom(const strCodOpeLib: String);
var
  intRecNo: Integer;
begin
  intRecNo := cdsItens.RecNo;
  cdsItens.DisableControls;
  cdsItens.First;

  while not cdsItens.Eof do
  begin
    if cdsItens.FieldByName('ITE_ITEPED').AsString <> 'S' then
      pGravarLogExclusaoItem(cdsItens.FieldByName('ITE_CODITE').AsString,
                             cdsItens.FieldByName('ITE_QTDITE').AsFloat,
                             strCodOpeLib);

    cdsItens.Next;
  end;

  cdsItens.RecNo := intRecNo;
  cdsItens.EnableControls;
end;

procedure TfrmCaixa.pGravarLogExclusaoItem(const strCodIte: String;
  const fltQtdIte: Double; strCodOpeLib: String);
var
  strInsert: String;
  qryInsert: TUniQuery;
begin
  strInsert := ' INSERT INTO LOGEXC ' +
               '   (AUTOINCREM, LOG_DTAEXC, LOG_HRAEXC, LOG_CODEMP, ' +
               '    LOG_CODOPE, LOG_CODITE, LOG_QTDITE, LOG_CODOPL) ' +
               ' VALUES ' +
               '   (:AUTOINCREM, :LOG_DTAEXC, :LOG_HRAEXC, :LOG_CODEMP, ' +
               '    :LOG_CODOPE, :LOG_CODITE, :LOG_QTDITE, :LOG_CODOPL); ';
  qryInsert := fCriaQuery;

  try
    qryInsert.SQL.Text := strInsert;
    qryInsert.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('LOGEXC', VS_strCodEmp);
    qryInsert.ParamByName('LOG_DTAEXC').AsDate := Date;
    qryInsert.ParamByName('LOG_HRAEXC').AsTime := fTime();
    qryInsert.ParamByName('LOG_CODEMP').AsString := VS_strCodEmp;
    qryInsert.ParamByName('LOG_CODOPE').AsString := strOpeRcx;
    qryInsert.ParamByName('LOG_CODITE').AsString := strCodIte;
    qryInsert.ParamByName('LOG_QTDITE').AsFloat := fltQtdIte;
    qryInsert.ParamByName('LOG_CODOPL').AsString := strCodOpeLib;
    qryInsert.ExecSQL;

    FreeAndNil(qryInsert);
  except
    on e:exception do
    begin
      if Assigned(qryInsert) then
        FreeAndNil(qryInsert);

      pMensagensErro(e.Message, '[frmCaixa.pGravarLogExclusaoItem]');
    end;
  end;
end;

function TfrmCaixa.fSenhaResponsavel: Boolean;
begin
  Result := True;

  If fConcomitante Then
  Begin
    If Not ffrmSenha(strSenha, 'Senha do responsável do caixa') Then
      Result := False

    Else If strSenha <> fCfgSis('SENF11') Then
      Result := False;
  End;
end;

function TfrmCaixa.fTipoDeVendaUnidadeOuPeso(strCodIte: String): String;
begin

  Result := '';

  If strCodIte.IsEmpty Then
    Exit;

  Result := fCampoTabela('ITE_TIPFLZ', 'CADITE', ['ITE_CODITE'], [strCodIte]);

end;

procedure TfrmCaixa.pConsultaPrecos;
begin
  pCriarFormularios(TfrmConsultaPreco, frmConsultaPreco);
  Try
    frmConsultaPreco.strCodCli := strCodCli;
    frmConsultaPreco.strTabPre := strTabPre;
    frmConsultaPreco.ShowModal;
  Finally
    pFreeAndNil(frmConsultaPreco);
  End;
end;

procedure TfrmCaixa.pAjustaStringTransicaoCampos(Var strValGrd: String; blnLendo: Boolean);
begin
  //PARA MANTER COMPATIBILIDADE ENTRE VERSÃO DE HOMOLOGAÇÃO E PRODUÇÃO NO FUTURO PODE REMOVER ISSO;
  If blnLendo Then
  Begin
    If Pos('dbgItensITE_PROMOC:', strValGrd) > 0 then
      strValGrd := AnsiReplaceStr(strValGrd, 'dbgItensITE_PROMOC:', 'dbgItensPROMOC:');

    If Pos('dbgItensCL_ITE_TEM_SALDO:', strValGrd) > 0 then
      strValGrd := AnsiReplaceStr(strValGrd, 'dbgItensCL_ITE_TEM_SALDO:', 'dbgItensSALDOS:');
  End
  Else
  Begin
    If Pos('dbgItensITE_PROMOC:', strValGrdOri) > 0 then
      strValGrd := AnsiReplaceStr(strValGrd, 'dbgItensPROMOC:', 'dbgItensITE_PROMOC:');

    If Pos('dbgItensCL_ITE_TEM_SALDO:', strValGrdOri) > 0 then
      strValGrd := AnsiReplaceStr(strValGrd, 'dbgItensSALDOS:', 'dbgItensCL_ITE_TEM_SALDO:');
  End;
end;

Procedure TfrmCaixa.pCarregaConfiguracoesGrid;
Var
  qryCfgCxa: TUniQuery;
  strArqTemp: String;
  strValGrd: String;
Begin
  strValGrdOri := '';

  qryCfgCxa := fCriaQuery;
  Try
    With qryCfgCxa, SQL Do
    Begin
      Clear;
      Add('SELECT * FROM CFGCXA');
      Add('WHERE CFG_CODEMP = :CODEMP');

      ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;

      If Not IsEmpty Then
      Begin
        strArqTemp := TCdsDigMultLoja.fCriarArquivoTemporario('', TCdsDigMultLoja.fGetPathTempOpcoesLocais);

        strValGrdOri := FieldByName('CFG_CFGGRI').AsString;
        strValGrd := strValGrdOri;

        pAjustaStringTransicaoCampos(strValGrd, True);

        If TCdsDigMultLoja.fEscreverNoArquivo(strArqTemp, strValGrd) Then
        Begin
          dbgItensView.RestoreFromIniFile(strArqTemp);
          DeleteFile(Pchar(strArqTemp));
        End;
      End;
    End;
  Finally
    FreeAndNil(qryCfgCxa);
  End;
end;

procedure TfrmCaixa.pCarregaInformacoesParaCalculoDaAliquota(
  AfatVendas: TFatVenda);
  var
    LqryCadCli : TUniQuery;
begin
  if fEmptyStr(AfatVendas.strCodCli) then
    exit;

  LqryCadCli := fCriaQuery(Self);
  try
    LqryCadCli.Close;
    LqryCadCli.SQL.Clear;
    LqryCadCli.SQL.Add(' SELECT CLI_ORGPUB, CLI_CALICM, CLI_ZONFRA, CLI_CONSUM ');
    LqryCadCli.SQL.Add('   FROM CADCLI ');
    LqryCadCli.SQL.Add('  WHERE CLI_CODCLI = :CODCLI ');
    LqryCadCli.ParamByName('CODCLI').AsString := AfatVendas.strCodCli;
    LqryCadCli.Open;

    AfatVendas.strCliOrg := LqryCadCli.FieldByName('CLI_ORGPUB').AsString;
    AfatVendas.strCalIcm := LqryCadCli.FieldByName('CLI_CALICM').AsString;
    AfatVendas.strZonFra := LqryCadCli.FieldByName('CLI_ZONFRA').AsString;

    if (fCfgSis('USOREV', VarBoolean)) and (not fEmptyStr(strAutFgo)) then
    begin
      AfatVendas.strTpOper := fCampoTabela('FGO_TPOPER', 'EXTGOR', ['FGO_SEQFGO'], [strAutFgo]);
      AfatVendas.strCliCon := fCampoTabela('FGO_CONSUM', 'EXTGOR', ['FGO_SEQFGO'], [strAutFgo]);
      if fEmptyStr(AfatVendas.strCliCon) then
        AfatVendas.strCliCon := LqryCadCli.FieldByName('CLI_CONSUM').AsString;
    end
    else
      AfatVendas.strCliCon := LqryCadCli.FieldByName('CLI_CONSUM').AsString;

    If fEmptyStr(AfatVendas.strTpOper) Then
    Begin
      If AfatVendas.strCliCon = 'S' Then
        AfatVendas.strTpOper := 'USO/CONSUMO'
      Else
        AfatVendas.strTpOper := 'REVENDA';
    End;

    LqryCadCli.Close;
  finally
    FreeAndNil(LqryCadCli);
  end;
end;

Procedure TfrmCaixa.pSalvaConfiguracoesGrid;
Var
  qryCfgCxa: TUniQuery;
  strArqTemp: String;
  strValGrd: String;
Begin
  strArqTemp := TCdsDigMultLoja.fCriarArquivoTemporario('', TCdsDigMultLoja.fGetPathTempOpcoesLocais);
  dbgItensView.StoreToIniFile(strArqTemp, True, [gsoUseFilter, gsoUseSummary]);

  qryCfgCxa := fCriaQuery;
  Try
    With qryCfgCxa, SQL Do
    Begin
      Clear;
      Add('SELECT * FROM CFGCXA');
      Add('WHERE CFG_CODEMP = :CODEMP');

      ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;

      If IsEmpty Then
      Begin
        qryCfgCxa.Insert;
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CFGCXA', VS_strCodEmp);
      End
      Else
      Begin
        Edit;
      End;

      strValGrd := TCdsDigMultLoja.fArquivoParaString(strArqTemp);

      pAjustaStringTransicaoCampos(strValGrd, False);

      FieldByName('CFG_CFGGRI').AsString := strValGrd;
      FieldByName('CFG_CODEMP').AsString := VS_strCodEmp;

      Post;

      DeleteFile(Pchar(strArqTemp));
    End;
  Finally
    FreeAndNil(qryCfgCxa);
  End;
end;

procedure TfrmCaixa.pTranfereDadosCdsChkOutCdsVendas;
begin
  cdsItens.First;
  While Not cdsItens.Eof Do
  Begin
    If cdsVenda.Locate('ITE_CHKOUT', cdsItens.FieldByName('ITE_CHKOUT').AsString, []) Then
    Begin
      cdsVenda.Edit;

      cdsVenda.FieldByName('ITE_PROMOC').AsString := cdsItens.FieldByName('ITE_PROMOC').AsString;
      cdsVenda.FieldByName('ITE_PROCUS').AsFloat  := cdsItens.FieldByName('ITE_PROCUS').AsFloat;
      cdsVenda.FieldByName('ITE_PROVEN').AsFloat  := cdsItens.FieldByName('ITE_PROVEN').AsFloat;
      cdsVenda.FieldByName('ITE_PROCVA').AsFloat  := cdsItens.FieldByName('ITE_PROCVA').AsFloat;
      cdsVenda.FieldByName('ITE_DESF07').AsFloat  := cdsItens.FieldByName('ITE_DESF07').AsFloat;
      cdsVenda.FieldByName('ITE_PROCAT').AsFloat  := cdsItens.FieldByName('ITE_PROCAT').AsFloat;
      cdsVenda.FieldByName('ITE_PROCDI').AsFloat  := cdsItens.FieldByName('ITE_PROCDI').AsFloat;

      cdsVenda.Post;
    End;

    cdsItens.Next;
  End;
end;

procedure TfrmCaixa.pTransfereDadosPromocaoVlrMinAtiva;
begin
  If Not objPromVlrMinTotalProdutos.fPossuiItensPromocaoVlrMinimo Then
    Exit;

  cdsItens.First;
  While Not cdsItens.Eof Do
  Begin
    If fEmptyStr(cdsItens.FieldByName('ITE_CHKOUT').AsString) Then
    Begin
      If cdsVenda.Locate('ITE_CODITE', cdsItens.FieldByName('ITE_CODITE').AsString, []) Then
      Begin
        cdsVenda.Edit;

        cdsVenda.FieldByName('ITE_PROMOC').AsString := cdsItens.FieldByName('ITE_PROMOC').AsString;
        cdsVenda.FieldByName('ITE_COMPRO').AsString := cdsItens.FieldByName('ITE_COMPRO').AsString;
        cdsVenda.FieldByName('ITE_CODPRO').AsString := cdsItens.FieldByName('ITE_CODPRO').AsString;
        cdsVenda.FieldByName('ITE_PROCUS').AsFloat  := cdsItens.FieldByName('ITE_PROCUS').AsFloat;
        cdsVenda.FieldByName('ITE_PROVEN').AsFloat  := cdsItens.FieldByName('ITE_PROVEN').AsFloat;
        cdsVenda.FieldByName('ITE_PROCVA').AsFloat  := cdsItens.FieldByName('ITE_PROCVA').AsFloat;
        cdsVenda.FieldByName('ITE_DESF07').AsFloat  := cdsItens.FieldByName('ITE_DESF07').AsFloat;
        cdsVenda.FieldByName('ITE_PROCAT').AsFloat  := cdsItens.FieldByName('ITE_PROCAT').AsFloat;
        cdsVenda.FieldByName('ITE_PROCDI').AsFloat  := cdsItens.FieldByName('ITE_PROCDI').AsFloat;
        cdsVenda.FieldByName('ITE_UNIORI').AsFloat  := cdsItens.FieldByName('ITE_UNIORI').AsFloat;
        cdsVenda.FieldByName('ITE_UNIVIS').AsFloat  := cdsItens.FieldByName('ITE_UNIVIS').AsFloat;
        cdsVenda.FieldByName('ITE_UNITAR').AsFloat  := cdsItens.FieldByName('ITE_UNITAR').AsFloat;
        cdsVenda.FieldByName('ITE_DESCON').AsFloat  := cdsItens.FieldByName('ITE_DESCON').AsFloat;
        cdsVenda.FieldByName('ITE_TOTITE').AsFloat  := cdsItens.FieldByName('ITE_TOTITE').AsFloat;

        cdsVenda.Post;
      End;
    End;

    cdsItens.Next;
  End;
end;

function TfrmCaixa.fPermiteConsultaNoCheckout: Boolean;
begin
  Result := fCfgSis('PRCOIT') = 'N';
end;

procedure TfrmCaixa.pSetarTaxVpr(blnTaxVpr: Boolean);
begin
  If Assigned(fatVendas) Then
    fatVendas.blnTaxVpr := blnTaxVpr;
end;

procedure TfrmCaixa.pSetaCondicaoDePagamento(const strCodCnd: String);
begin
  If (Not Assigned(fatVendas)) Then
    Exit;
  fatVendas.strCodCnd := strCodCnd;
end;

End.
