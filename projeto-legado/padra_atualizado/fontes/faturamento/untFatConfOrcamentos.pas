{***********************}
{* qryCadCfo -> CADCFO *}
{********************RV*}
unit untFatConfOrcamentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, AppEvnts, Menus, Buttons, ExtCtrls, EditFocus,
  Grids, DBGridCitel, DBGrids, Mask, CurrencyEditFocus, untFatTipoExpedicao,
  ComboBoxFocus, DB, UniClientDataSet, Uni, MaskEditFocus, untFuncoesSimples,
  untFuncFat, untFuncFatTypes, StrUtils, untFiscal, untConstantes,
  BitBtnLockedIncrem, untEnderecoEntrega, untPanelCxPedOrc, DateUtils,
  Spin, untFuncoesGenerica, frxClass, untFatPromocaoBrindes, untGryncash,
  cxProgressBar, QColorLabel, MaskUtils, cxGraphics, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookAndFeels,
  cxLookAndFeelPainters, untQuestFidelidade, untCadPro, Generics.Collections,
  untTypesSistema, untMovCdb, frxExportCSVTestabilidade, Datasnap.DBClient,
  cxCurrencyEdit, Types, untLiberacao, untFatConfPedidos,
  untTMatrizSaldosColorantes, untFuncTinta, untRcxTResumoDeCaixa, Yapay.Api.Facade,
  Faturamento.View.DadosCTe, untInterfaceTefCitel, untTefCitelUtil, untCadLote,
  untTiposPix, untTecladoSEAT, untSubjectIntf, untFuncoesComodatoCilindroVasilhame,
  Winapi.UxTheme, untTCdsVinculosRequisicoes, untValidaEntRetDocumentoF11,
  untFatSelecionaTipoOrdemPagamento;

type
  TfrmFatConfOrcamentos = class(TfrmPai, IObserver_)
    pnlCabecalho: TPanel;
    pnlCentral: TPanel;
    pnlRodape: TPanel;
    lblTipDoc: TLabel;
    edtNumOrc: TEditFocus;
    lblTotIte: TLabel;
    edtTotGer: TEditFocus;
    Label2: TLabel;
    cbxModalidades: TComboBoxFocus;
    Label3: TLabel;
    edtValor: TCurrencyEditFocus;
    dbgModalidades: TDBGridCitel;
    cdsModalidades: TUniClientDataSet;
    cdsModalidadesVALOR: TFloatField;
    cdsModalidadesTROCO: TFloatField;
    cdsModalidadesRESTANTE: TFloatField;
    cdsModalidadesDESMOD: TStringField;
    cdsModalidadesECF_CODMOD: TStringField;
    cdsModalidadesECF_IDENTI: TStringField;
    cdsModalidadesCALC_RESTANTE: TFloatField;
    cdsModalidadesARQUIVOTEF: TStringField;
    cdsModalidadesECF_INFADI: TStringField;
    cdsModalidadesAGG_PAGO: TAggregateField;
    dtsModalidades: TDataSource;
    Bevel1: TBevel;
    Label4: TLabel;
    edtValDig: TCurrencyEditFocus;
    edtValTro: TCurrencyEditFocus;
    Label6: TLabel;
    edtNomCli: TEditFocus;
    Label7: TLabel;
    Label8: TLabel;
    btnConfirma: TBitBtnLocked;
    edtCodCli: TEditFocus;
    mskCgcCpf: TMaskEditFocus;
    lblCpfCgc: TLabel;
    edtEndEnt: TEditFocus;
    edtBaiEnt: TEditFocus;
    Label9: TLabel;
    Label10: TLabel;
    mskCepEnt: TMaskEditFocus;
    Label11: TLabel;
    edtCidEnt: TEditFocus;
    edtNomCid: TEditFocus;
    cdsModalidadesCODFPG: TStringField;
    Label13: TLabel;
    cdsModalidadesIDXCRT: TIntegerField;
    lblRG_IES: TLabel;
    mskNumR_G: TMaskEditFocus;
    cdsModalidadesECF_DESMOD: TStringField;
    Label15: TLabel;
    edtCodTra: TEditFocus;
    edtNomTra: TEditFocus;
    Label16: TLabel;
    lblEntRet: TLabel;
    Label18: TLabel;
    edtCodFpg: TEditFocus;
    lblCreditos: TLabel;
    chkEndEnt: TCheckBox;
    cdsModalidadesORDEM: TIntegerField;
    edtCodEmp: TEditFocus;
    btnEndEnt: TBitBtnLocked;
    lblValAnt: TLabel;
    lblDesVend: TLabel;
    lblVendedor: TLabel;
    edtTipFat: TEditFocus;
    spnTipFat: TSpinButton;
    btnAdicionarItens: TBitBtnLocked;
    btnEdiMod: TBitBtnLocked;
    btnMsgNot: TBitBtnLocked;
    lblVolume: TLabel;
    edtVolume: TEditFocus;
    lbl2: TLabel;
    edtEspVol: TEditFocus;
    edtCgcCpf: TEditFocus;
    lblCadPag: TLabel;
    edtCodPag: TEditFocus;
    mskCndPag: TMaskEditFocus;
    btnAltCnd: TBitBtnLocked;
    btnDuplicatas: TSpeedButton;
    lblUF: TLabel;
    edtUF: TEditFocus;
    cmbTipFre: TcxComboBox;
    lblEmail: TLabel;
    edtEmail: TEditFocus;
    edtDesPag: TEditFocus;
    lblUtiNps: TLabel;
    edtNpsS_N: TEditFocus;
    pnlComanda: TPanel;
    Label1: TLabel;
    edtBarCom: TEditFocus;
    pnlOpcaoEmiFatOuAdto: TPanel;
    rdgOpcaoEmiFatOuAdto: TGroupBox;
    rdbAdiantamentoPedido: TRadioButton;
    rdbEmissaoFaturamento: TRadioButton;
    btnAgruparPedidos: TBitBtnLocked;
    lblTipoFaturamento: TLabel;
    cdsModalidadesSESSAO_TEF: TStringField;
    lblNotPau: TLabel;
    edtNotPau: TEditFocus;
    lblNumParcelas: TLabel;
    edtNumParcelas: TEditFocus;
    shpRetISS: TShape;
    lblRetISS: TLabel;
    lblSomentePos: TLabel;
    btnConfRetiraCaixa: TBitBtnLocked;
    btnGerarPDF: TBitBtnLocked;
    btnNumSeries: TBitBtnLocked;
    lblPlaFat: TLabel;
    mskPlaFat: TMaskEditFocus;
    btnLerPinPad: TBitBtnLocked;
    btnFatorServico: TBitBtnLocked;
    cdsModalidadesPORTADOR_ORDPAG: TStringField;
    tmrReload: TTimer;
    cdsModalidadesPIX_AVULSO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsModalidadesAfterPost(DataSet: TDataSet);
    procedure cdsModalidadesAfterDelete(DataSet: TDataSet);
    procedure dbgModalidadesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbxModalidadesEnter(Sender: TObject);
    procedure edtCidEntKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cbxModalidadesExit(Sender: TObject);
    procedure edtCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnEndEntClick(Sender: TObject);
    procedure mskNumR_GExit(Sender: TObject);
    procedure edtNumOrcKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure spnTipFatDownClick(Sender: TObject);
    procedure spnTipFatUpClick(Sender: TObject);
    procedure btnAdicionarItensClick(Sender: TObject);
    procedure btnEdiModClick(Sender: TObject);
    procedure edtTipFatChange(Sender: TObject);
    procedure btnMsgNotClick(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCgcCpfChange(Sender: TObject);
    procedure btnDuplicatasClick(Sender: TObject);
    procedure btnAltCndClick(Sender: TObject);
    procedure edtNpsS_NExit(Sender: TObject);
    procedure edtTipFatEnter(Sender: TObject);
    procedure rdbEmissaoFaturamentoClick(Sender: TObject);
    procedure mskCgcCpfExit(Sender: TObject);
    procedure btnAgruparPedidosClick(Sender: TObject);
    procedure cbxModalidadesChange(Sender: TObject);
    procedure btnConfRetiraCaixaClick(Sender: TObject);
    procedure btnGerarPDFClick(Sender: TObject);
    procedure btnNumSeriesClick(Sender: TObject);
    procedure edtEmailExit(Sender: TObject);
    procedure btnLerPinPadClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    function fValidaCodAmzCaixa():Boolean;
    procedure btnFatorServicoClick(Sender: TObject);
    procedure mskCgcCpfChange(Sender: TObject);
    procedure tmrReloadTimer(Sender: TObject);
  private
    { Private declarations }
    strNumCepOld,
    strCodCidOld,
    strEndereOld,
    strBairroOld,
    strNomCidOld : String;

    strNumCep,
    strCodCid,
    strEndere,
    strBairro,
    strNomCid,
    strEstado : String;

    blnRestaurarMatrizDeItens : Boolean;
    blnRecalculaCdsVendaForcadoLocal: Boolean;
    strSessaoTef : String;
    blnCancelarCFTef: Boolean;
    blnAdiantamentoAutomatico : Boolean;
    blnMudouCondicaoPagamento : Boolean;
    strUltimoCodCndUsadoCaixa: String;

    cdsIteCfo : TUniClientDataSet;

    fltValAnt: Double;
    fltValAdt: Double;

    fltDesEspRest: Double;
    blnAdicionandoItems: Boolean;
    blnGravouArquivos: Boolean;
    blnLiberouPromocaoVencida: Boolean;

    FPais: TPais;

    blnUtiNps : Boolean;

    fatVenda   : TFatVenda;
    fatAgrupamento: TFatVenda;
    cdsItensAdd: TUniClientDataSet;
    stlItensPromoPorQtdMinQtdLim: TStringList;
    ArrItemPro: TArrRecItemPro;
    oleItensVendaPed: OleVariant;
    oleItensVendaPedAdicionais: OleVariant;
    blnSomentePos: Boolean;

    arrMsgNot      : Array[1..5]  Of String;
    arrDuplicataSav: Array[0..23] Of TArrDigDuplic;

    strTipPed: String;
    strEstCliAnt: String;
    strCodCliAnt: String;
    strCgcCpfAnt: String;

    blnAltLoj: Boolean;
    strEmpLog: String;
    strEspCfo: String;
    intEmpBai: Integer;
    strNumeroDoc: String;
    strClienteDoc: String;
    objEndEnt: TEnderecoEntrega;

    blnCliFil : Boolean;
    blnCliCon : Boolean;
    strFpgOrc : String;
    strConPag : String;

    strDigCodVen: String;
    strDigCodCnd: String;
    strDigConPag: String;
    strDigForPag: String;

    blnFocoGrid: Boolean;

    qryModalidades: TUniQuery;
    qryFatGor: TUniQuery;
    qryConOrc: TUniQuery;
    stlModalidades: TStringList;

    qryCadCli: TUniQuery;
    qryConCid: TUniQuery;
    qryCadTra: TUniQuery;
    qryCadCfo: TUniQuery;

    strCodEcf: String;
    strModEcf: String;
    strPorta : String;

    cdsChequePre: TUniClientDataSet;
    cdsChequeVis: TUniClientDataSet;

    arrCartoes: TCartoesResumoCaixaArray;
    arrCartFin: TCartoesResumoCaixaArray; // Financiamento

    blnPrimeiraVendaTEF: Boolean;

    blnMudouCodCli: Boolean;

    strInfErro: String;

    ecfFiscal: TUntFiscal;
    stlForPag: TStringList;
    stlCndPag: TStringList;

    blnTrocoComoCredito : Boolean;

    optTroco: TOperacaoTroco; // CHEQUE A VISTA
    fltValorTroco: Double;    // CHEQUE A VISTA

    optTrocoPre: TOperacaoTroco; // CHEQUE PRÉ
    fltValorTrocoPre: Double;    // CHEQUE PRÉ

    optTrocoCar: TOperacaoTroco; // CARTAO
    fltValorTrocoCar: Double;    // CARTAO

    optTrocoDin: TOperacaoTroco;
    fltValorTrocoDin: Double;

    intSemaforoConfirma: Integer;
    intSemaforoConsulta: Integer;

    intSemaforoReceberModalidades: Integer;
    blnHabFormKeyDown : Boolean;

    strFone01,
    strCelular: String;

    stlDupCreditos : TStringList;
    stlLckDup      : TStringList;
    fltTotCreditos : Double;
    fltCredUtilizados: Double;

    strCliIes: String;
    strEmlCon: String;
    strAutInc: String;

    blnFecharForm: Boolean;

    intSemaforoOrcamento: Integer;

    arrOpcoes: TOpcoesFaturamentoArray;

    intPosAtual: Integer;

    fltDesEspConcedido: Double;
    fltPorDesConcedido: Double;

    strTabPrecoFat: String;

    strCodCarPed: String;
    intQtdParPed: Integer;
    strTipoTitulo : String;

    blnConfirmouTEF: Boolean;

    FMatrizesDesmembramento : TMatrizesFechamento;

    blnDesmembrarVenda: Boolean;
    blnTemEntregaFutura: Boolean;
    blnTemEntregaImediata: Boolean;
    blnTemRetiraOutraLoja: Boolean;
    blnTemRetiraExpedicao: Boolean;
    blnTemRetiraBalcao: Boolean;
    blnTemItensEmpresaCD: Boolean;
    blnVendaOrigOutraLoja: Boolean;
    blnTemRetiraMesmaLoja : Boolean;

    fltValorAdiantamentoPedidoPeloF11: Double;
    blnRealizandoAdiantamentoPedidoPeloF11: Boolean;

    blnPedOrcMltLojUtiNps : Boolean;

    blnVaiEmitirPedidoConcreto: Boolean;

    cdsModAux: TUniClientDataSet;

    blnVendaConsumidorFocarApenasCPF: Boolean;

    blnJaValidouDocs: Boolean;

    objCodBar : TCodigoBarras;

    blnCliBal : Boolean ; //Cliente Balcao

    strTipOpe: string;

    objLiberacao : TLiberacao;

    blnImprimiuCupom: Boolean;

    blnVerificouMinimo: Boolean;
    blnChamouTelaTabelaPreco: Boolean;

  {*****Utilizadas para Quest Fidelidade*****}
    fltValorPonto: Double;
    fltValorDinheiro: Double;
    blnVaiResgatarQuest: Boolean;
    blnUsandoQuestFidelidade: Boolean;
    AcumulaQuest: TAcumula;
    strCpfCnpjClienteQuest: string;
    ResgateQuest: TResgata;
    strNumDocQuest: string;
    strEspDocQuest: string;
    strAutIncQuest: string;
    blnEhCartaoQuest: Boolean;
  {******************************************}

    strIncDoc: String;
    strTabela: String;

    strModalidade: String;

    edtCodEmpInf: TEditFocus;

    blnEhCartaoGrynCash: Boolean; // indica se o cliente vai usar o saldo para ser salvo como cartao
    blnCliGry: Boolean; // indica se é cliente da gryncash
    fltCshGry: Double; // indica o saldo a ser utilizado
    strEmailAnt: string;
    blnPermiteAlterarEmailMedianteConfiguracao: Boolean;

    cdsItensChkOut : TUniClientDataSet;

    FPedidoEntCd : Boolean;
    FPedidoEmpCd : String;

    FPermiteUsarPix: Boolean;

    FDadosRetornoPix,
    FDadosRequisicaoPix,
    FAutoIncremChavePix: String;

    FCondicaoPagamentoPixComCobrancaAnteriorExpirada: Boolean;

    FObjetoRecebimentoPix: TDadosRetornoPixConsulta;

    FcdsChkOut: TUniClientDataSet ;
    FcdsLogChk: TUniClientDataSet ;

    objTecladoSEAT : TTecladoSEAT;

    objCdsVinculos: TUniClientDataSet;
    blnCarregouDocImportadoPedOrc : Boolean;
    FblnTxIdPixRemovida: Boolean ;
    blnJaConsultouSituacaoRegularCliente: Boolean;
    blnCarregouClienteConsumidor: Boolean;

    strReloadCodCli : String;
    cdsReloadItens  : TUniClientDataSet;

    function fVaiRecalcularTotGerPorCausaDosImpostos: Boolean;
    procedure pCalculaTotGerImpostos(var intProgresso: Integer; const intProgressoMax: Integer; pgbStatus: TcxProgressBar);
    function fAdicionouItensCheckout: Boolean;
    function fExibirTelaParaInformarDadosDoCartao(const blnValidouCamposDaTela: Boolean; const strTipCar: String): Boolean;
    procedure pVerificarUtilizacaoDoTecladoSEAT;
    procedure pUpdate(const Parameters: array of String; AVisualizarProgresso: Boolean = True);
    procedure pLimparPainelStatus;

    function fTravaRepetirFormaPagamento(const AstrCodEcf, AstrCodFpg: String): Boolean ;

    procedure pGerarPDF;

    procedure pVerificaCheckOut;

    function fExecutouRecalculoPrecosCondPagto(blnRecalculaSemPerguntar: Boolean=False): Boolean;
    procedure pCarregaMensagemPedido(blnLimpar: Boolean = False);
    procedure pPedeMensagemNota;

    Procedure pSalvaDuplicatas;
    procedure pAbrirGaveta(strConPag: String);
    procedure pHabitilaEndereco(blnCliCon: Boolean);
    procedure pEnderecoToTela(objEndEnt: TEnderecoEntrega);

    procedure pInformacao(strInfo: String; pgbStatus: TcxProgressBar);
    procedure pProgresso(Var intProgresso: Integer; intMaximo: Integer; pgbStatus: TcxProgressBar);
    function fPedidoCarregado: Boolean;
    function fUsaPromocaoComSugestaoPrecoTabelaSemPedidoCarregado: Boolean;
    function fUsaPromocaoComSugestaoPrecoTabelaSemPedidoCarregadoComCondicaoNoFinal: Boolean;
    procedure pCarregaFormasPagamento;

    procedure pCarregaOrcamento;
    procedure pCarregaCliente(blnVerEnd: Boolean = False; strParCli: String = '');
    procedure pCarregaTransportadora(blnCarregaPlaca: Boolean = True);

    function fCancelaModalidades: Boolean;

    function fRetornaQtdNeg: Integer ;
    function fRetornaCodFin: String ;
    function fIsF11: Boolean ;

    function fReceberModalidade: Boolean;
    function fReceberModalidadeInterna: Boolean;
    procedure pReceberModalidade;

    function fTemFormaPagtoNaoPermitidaComAReceber(Var strDesFpg: String): Boolean;

    procedure pDestroiFrmCaixa;
    procedure pMostraTotal;
    procedure pApagaModalidade;
    procedure pCarregaCadCid;
    procedure pLimparArrCol;
    procedure pLimparTela(blnLimpaItensAnteriores: Boolean = True);
    procedure pDefineEspecieDefault;
    procedure pAcertaClienteCheque(cdsChq: TUniClientDataSet);
    function fChequePre(fltValor: Double): Boolean;
    function fChequeVis(fltValor: Double): Boolean;
    function fDigCartao(fltValor: Double; Var intIdxCrt: Integer;
      strNomRed, strNomBan, strTipTra, strNumCcd, strNumNsu: String; const strTipDeb: Char; intQtdPar: Integer; strTipoOperacaoTef: String;
      Var arrCartoes: TCartoesResumoCaixaArray; strCodCar: String = '';
      strCodFin: String = ''; intQtdNeg: Integer = 0; blnDigCar: Boolean = True;
      strArquivoTEF: String=''; strCodPos: String = ''; strTipCar: String='';
      strDadosCupom: String = '';
      strChaPix: String = '';
      strPixS_N: String = 'N';
      strNumDoc: String = '';
      strDtaTra: String = '';
      strHraTra: String = '';
      strStatusCartao: String = '';
      strCodigoCarteiraDigital: string = '';
      intPeriod: Integer = 0;
      intPriVenc: Integer = 0;
      AstrControle: String = '';
      AstrCodigoTipoOperacaoCartao: string = ''): Boolean;

    function fRetEspecieSelecionada: String;
    Function fTemModalidadeVinculado: Boolean;

    function fDefineFormaPagamento(fatVenda: TFatVenda): Boolean;
    procedure pDefineModalidades(fatVenda: TFatVenda);
    function fRetValorAReceberComUtilizaCredito: Double;

    procedure pSetarEdtCodEmpInformativo(strCodEmp: String='');

    function fRetNumCCds: String;
    function fImprimirCupom(dadosCupom: TDadosImpressaoVenda; Var strNumCoo, strNumSer, strNumCcf: String): Boolean;
    function fImprimirCupomNovo(dadosCupom: TDadosImpressaoVenda; Var strNumCoo, strNumSer, strNumCcf: String): Boolean;
    function fImprimirCupomVelho(dadosCupom: TDadosImpressaoVenda; Var strNumCoo, strNumSer, strNumCcf: String): Boolean;
    function fRetVencimentos(strConPag: String;
      dtaDtaEnt: TDateTime): String;
    function fVerificaTef: Boolean;
    function fAtualizarTabelas(strNumDoc, strEspDoc, strCodEmp,
      strCodCli, strNumCoo, strNumSer, strNumCcf: String): Boolean;

    procedure pCriaImpFiscalVelha;

    procedure pZeraOpcaoTrocoCheque;
    procedure pAtualizaNumCcd(fatVenda: TFatVenda);
    function fImprimeEnderecoEntrega(strDesMod: String; dadosCupom: TDadosImpressaoVenda;
      strNumCOO: String; cdsModali: TUniClientDataSet): Boolean;
    function fImprimeEnderecoEntregaNova(strDesMod: String; dadosCupom: TDadosImpressaoVenda;
      strNumCOO: String; cdsModali: TUniClientDataSet): Boolean;

    Function fImprimeDadosGarantia(ecfFiscal: TUntFiscal; dadosCupom: TDadosImpressaoVenda): Boolean;
    function fImprimeCreditosCliente(ecfFiscal: TUntFiscal; dadosCupom: TDadosImpressaoVenda): Boolean;

    procedure pConfirmar;

    function fConfirmarAdiantamento(pgbStatus: TcxProgressBar = nil): Boolean;
    function fFecharAdiantamento(pgbStatus: TcxProgressBar = nil): Boolean;

    function fConfirmarVenda(pgbStatus: TcxProgressBar = nil): Boolean;
    function fFecharVenda(pgbStatus: TcxProgressBar = nil): Boolean;

    function fItensObrigatoriedadeCpf(strNumDoc, strEspDoc, strCodEmp,
      strCodCli: String): Boolean;

    function fItensObrigatoriedadeCodigoIbama(strNumDoc, strEspDoc,
      strCodEmp, strCodCli: String): Boolean;

    function fConferenciaProdutos: Boolean;

    function fVerificaLimiteCredito(strCndPag: String;
                                    fatVenda: TFatVenda;
                                    fltTotGer: Double;
                                    strCfgLim: String): Boolean;

    function fVerificaPromocao: Boolean;
    procedure pAcertaDadosCondicaoPagamento(fatVenda: TFatVenda);

    procedure pInserirItemServico(fatVenda: TFatVenda; strCodIte: String);
    function fEmpresaDocumento: String;
    function fRetornaCodigoDaEmpresa: String;

    function fIniciaFatVenda: Boolean;

    function fFatGor(strCampo: String): TField;
    function fAuxGor(strCampo: String): TField;

    function fValidaDocumento(Sender: TWinControl): Boolean;
    function fCarregaDocumentoValidaEstoque(pgbStatus: TcxProgressBar = Nil): Boolean;

    procedure pSetaOpcoesFaturamento(blnEhConcreto : Boolean = False);
    procedure pKeyDownTipFat(Key: Word; Shift: TShiftState);

    function fTipoFaturamentoSelec: TOpcoesFaturamento;
    procedure pSetaTipoFaturamento(strEspecie: String);

    procedure pInserirItensAdicionais(fatVenda: TFatVenda; blnNaoRatearDescontoEmItensNovos: Boolean; cdsNovosItens: TUniClientDataSet=Nil; pgbStatus: TcxProgressBar = nil);

    function fRetornaDescontoEspecial(Var fltPorDes, fltDesEsp, fltTotGer: Double; cdsItensNovos: TUniClientDataSet;
      blnConcomitante: Boolean; blnFechamentoComDesconto: Boolean; strTabPre: String; pgbStatus: TcxProgressBar): Boolean;
    procedure pCarregaClienteVenda(fatVenda: TFatVenda; strTabPre: String='');
    procedure pCarregaEnderecoEntregaVenda(fatVenda: TFatVenda);
    procedure pCarregaTransportadoraVenda(fatVenda: TFatVenda);
    procedure pMostraObsCliente(strCodCli: String);
    procedure pMarcaDocumentoComoImpresso(strNumDoc, strEspDoc, strCodEmp,
      strCodCli: String);

    function fTemModalidadeTEF: Boolean;

    procedure fMostraCadPagto;

    function fGetTotalParcelasPedido: Double;

    procedure pOnCalculaTotGer(const item: TDadosFechamento; index, count: Integer; AInfo: String = '');
    procedure pOnPreencheMatrizItens(const item: TDadosFechamento; index, count: Integer; AInfo: String = '');

    function fConfirmaCartoesTEF(blnUsaVinculado: Boolean): Boolean;

    procedure pCarregaDadosCadastraisConsumidor;

    function fAtualizarDadosCupomImpresso(dadosCupom: TDadosImpressaoVenda; strNumCoo,
      strNumSer, strNumCcf: String): Boolean;
    procedure pImprimeModalidadesSintetizadas(objFiscal: TFiscalBrd;
      arrParametros: array of TObject);
    procedure pImprimeModalidadesSintetizadasVelho(objFiscal: TUntFiscal;
      arrParametros: array of TObject);

    function fGetModalidadesImpressaoCupom(Var fltPagtoAnt: Double): TUniClientDataSet;

    function fEspecieCasoConcomitante: String;
    function fCfgConcomitante: Boolean;
    procedure pHabilitaDadosCliente(blnHab: Boolean);
    Procedure pCarregaComplementosEndCad(fatVenda: TFatVenda);

    function fVendaAberta: Boolean;
    procedure pCancelaCupomNoEcf(ecfFiscal: TUntFiscal);
    procedure pImprimeReciboBai;

    function fGetIndexModalidade(strCodFpg: String): Integer;
    function fEhRecebimentoFormasPagtoNegociadas: Boolean;

    function fReceberFormaPagamento(strCodFpg: String; fltValor: Double;
                                    strCodCar: String; intQtdPar: Integer): Boolean;

    function fUsouExpedicaoServicos: Boolean;

    procedure pFormasPagamentoNegociada;
    procedure pConfirmaValorTotal;
    procedure pSetarEspecieFechamentoPD;

    function fPedidoTemFazendaInformada: Boolean;
    function fPermiteDocumentoDaEmpresa(strCodEmp: String): Boolean;
    function fTravaUtilizacaoCredito(cdsCredit: TUniClientDataSet): Boolean;
    function fValidaCreditosVencidos(cdsCredit: TUniClientDataSet): Boolean;
    procedure pVerificarPromocaoBrindes(strNumDoc, strEspDoc: String);
    procedure pDestravaDuplicatasCredito;
    procedure pSetarItensExpedidosMatrizItens(var Itens: TMatrizFechamento);
    procedure pMarcarTodosItensComoExpedidos(var Itens: TMatrizFechamento);
    function  fConverteCodigoBarrasEmNumeroDocumento: Boolean;
    procedure pCarregaTabelaDePrecoPorCnd;
    procedure pSetaVisibilidadeNetpoints;
    procedure pSetaVisibilidadeNotaPaulista;
    function fGetTotGer(fltTotGer: Double): Double;

    function fTravarTrocoUtlCartaoOuCheque(blnCartao : Boolean = False;fltValor:Double = 0): Boolean;
    procedure pDesabilitaCamposAntesFechamento;
    procedure pHabilitarCamposAposFechamento(blnSucesso: Boolean);
    procedure pFinalizarFechamento(blnSucesso: Boolean; pgbStatus: TcxProgressBar);
    procedure pDigitacaoNumeroLiberacaoCartoes;
    function fPrecisaInformarNumLiberacao(const AitemInfoCartao: TCartoesResumoCaixa): Boolean ;
    procedure pImprimirReciboAdiantamentoPedido(pgbStatus: TCxProgressBar);
    procedure pImprimirReciboCreditosPendentes(pgbStatus: TCxProgressBar);
    procedure pImprimirReciboCreditosUtilizados(pgbStatus: TCxProgressBar);
    procedure pLimparVariaveisUsadasNaVenda;
    function fRealizarGravacao: Boolean;
    function fEhFaturamentoDeConcreto : Boolean;
    function fEhMultiLojaComAlgumaEmpresaTefDesligado(const AstrNumDoc, AstrEspDoc, AstrCodEmp, AstrCodCli: String): Boolean;
    function fVerificaStatusImpressora: Boolean;
    procedure pDefinirNumeroSerieCooLogTef;
    procedure pTrataWMS;
    function fCarregaAgrupamentoPedido(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pCarregaClienteAgrupamento;
    Function fSalvaLoGEnderecoEntrega(strCodOpe, strCodEmp, strNomCam, strValAnt, strValAtu, strCodCli: String): Boolean;
    function fProcessaLogEnderecoEntrega : Boolean;
    function fObtemDadoPinPad(pgbProgresso: TcxProgressBar): Boolean ;
    function fRetornouQuestFidelidadeOK(strCPFCNPJ, strItens, strNumDoc: string; blnVaiResgatar: Boolean): Boolean;
    procedure pValidaQuestFidelidade(strDocCli: string; blnVAiResgatar: Boolean);
    function fEfetivouQuestFidelidade: string;
    function fPedidoTemQuestFidelidade(strNumDoc, strEspDoc: string; var strDocCli: string): Boolean;
    function fNaoVerificouMinimoNoOrcamentoOuPedido: Boolean;
    function fConfirmaCTE: Boolean;

    function fConfirmaVendaTefCitel : Boolean;
    function fPdfNFCeGerado(const AstrNumDoc, AstrEspDoc, AstrCodEmp, AstrCodCli: String;
                            var AblnSemImpressaoPrevista: Boolean): Boolean;
    procedure pAguardarImpressaoNFCeAntesDoTEF;
    function fVerPendenciasTefCitel : Boolean;
    procedure pAbreFormItensSeries;
    function fChamaTelaDeOperacoes(fltValDig : Double;
                                   strNumDoc : String;
                                   out intQtdParc : Integer;
                                   out intOperacao : Integer;
                                   AobjDadosAdicionaisTefTra: IDadosAdicionaisTefTra;
                                   const AValidaParcelas: IDadosValidaParcelas = nil): IRetornoTEFCitel;
    procedure pUtilizarGrynCash(strCliCgc: String; fltTotGer: Double);
    procedure pAdicionaItensChkOutTemp(cdsItens : TUniClientDataSet);
    procedure pDesfazCheckoutTemp(cdsItens : TUniClientDataSet; blnConclusao : Boolean);

    function ValidarAberturaDoPedidoComPix: Boolean;
    function RealizaPerguntaDoTipoDeOrdemDePagamento: Boolean;
    function AbreTelaParaPagamentoDoPix(AConfirmado: Boolean; fltValDig: Double; out APortadorOrdemPgto: String; out APixAvulso: String): Boolean;
    function RetornaTipoDePagamentoOrdemPix: TTipoOrdemPagamento;
    function ValidarSeExistePixRecebidoSemConfirmacao(AExclusao: Boolean): Boolean;
    function fRetonaValorPixPago: Double ;
    procedure pRemovePixPedidoComValorParcial ;
    function fTxPixVazia: Boolean;
    function ValidaCondicaoPixOuValorDoPixGeradoPeloPedido: Boolean;
    function TravarRegistroDoPix(ATravar: Boolean = True): Boolean;
    function JaRecebidoEmPixOuPixAvulso: String;

    function fTroca007Para012 : Boolean;
    function fRealizaFaturamentoNotaConcretoF11(blnValidaAcessoSistema: Boolean = True): Boolean;

    function fVerificaTravaColetor(strNumDoc: String): Boolean;
    function fTipoPedidoNFe: Boolean;
    function fPrecisaAmarrarInfoCartao(const AstrCodCar, AstrCodEmp: String): Boolean;
    function fCarregarPedidoOrcamento(strNumOrc: String): Boolean;
    function fUsouModalidadesUtilizacaoCreditoDinheiro():Boolean;

    procedure pMostraDebitosReceber(strCodCli : String);
    function fDestacarRetencoesServicos: Boolean;
    procedure pDestacaRetencoesServicos;
    function fRecebimentoComPix: Boolean;
    function fRecebimentoComTransferenciaBancaria(fltValor: Double): Boolean;
    function fEmpresaFaturamentoSemSaldo: String;
    procedure pValidaTicketEstacionamento;
    function fDefineAbastecimentoItensPDAVista: Boolean;
    function fVerificaTrocoOuAdiantamentoEmDinheiro(strCodFpg: String): Boolean;
    function fPermiteCupomFiscalComIPI: Boolean;
    function fPermiteFaturarPedidoDeOutraLoja(strCodEmp, strEmp_CD, strEnt_CD: String): Boolean;
    function fVerificaSituacaoRegularCliente: Boolean;
    procedure pAtualizaOrdemProducaoVinculada;
    function fPedidoComOrdemProducao: Boolean;
    procedure pGravaTemNSE(var dicDados: TDictionary<String, String>);
    procedure pRecuperaTemNSE(var dicDados: TDictionary<String, String>);
    procedure pHabilitaOpcoesRealizar;
    function fRetornaPortadorCredito: String;
    procedure pSetFunctionsEventosCadPro(const AFatVenda : TFatVenda);
    procedure pClearFunctionsEventosCadPro;
    procedure pSetFunctionsEventosCadProFatVenda;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pEscapePressed; override;
  public
    { Public declarations }
    strCodOpe: String;
    strEmpres: String;
    blnApenasPrazo: Boolean;

    strCodigoCaixa  : String;
    objResumoDeCaixa: TResumoDeCaixa;
    strArquivoTef: String;
    strArqViaCliente: String;
    strArqViaLojista: String;
    strNumDocImportadoPedOrc: String;

    blnRcxF11: Boolean;
    blnObrigarExpedirAntesDeFaturar: Boolean;
    blnTravaFaturamentoF11: Boolean;

    {J.A Massa e Concreto:
     Utilizado para carregar a estrutura do concreto com preço de custo.}
    function fCarregaEstrutura(Item : TDadosFechamento;
                               blnBaixaSubItemEstrutura: Boolean): Boolean;

  end;

Const
  EMPRESA_EM_BRANCO = '1';

Const
  USANDO_VINCULADO = True;
  NAO_USANDO_VINCULADO = False;

implementation

uses untFuncoes, untConsultas,untPesqAux,untFinanceira,
  untCadCheques, untRcxDigCartoes,untPnlDadosPedOrc,
  untFunTef, untObservacao, Math,
  untGravando,untFuncFatImp,untImpCreditosCliente,
  untFatConfOrcamentosItens, untItensSemPro,untImpDadosGarantia,
  untPafGerais, untFuncoesRel, untFuncoesRel2,
  untFatGor, untLogVar,
  untEnderecamentoProduto, untCaixa, untFatDigNetPoints,
  untDigCndPagamento, untFatDigDesconto, untDigCliente,
  untFatMensagemNotaF11, untFatMostraObsCliente, untCfgRel,
  untQckRcxRecCredPenCli, untTipoFreteAtc,
  untImpressorCupom, untFatAltCondPagtoPedido, untQckFatImpNFCe, untReciboCtr,
  untRcxRecbBaixDocs, untPromocaoBrindes, untAdiantamentoCliente,
  untComprovanteServicosExecutar, untAgrupDuplicatas, untFuncoesCaixa,
  untDuplicatas, untLogTef, untDisparaEmailAut,
  ComObj, ActiveX, untCancelamentoDocumentos,
  untRcxInfCarPos, untFatDigCodBarrasComanda, untMsgLiberacao,
  untLiberacaoFactory, untTAmarraCartao,
  untLibExt, untCadCid, untAdiantamentoClienteGenerico,
  untFatDigCnpj, untCadQuestFidelidade, untFuncoesOcorrenciasCRM,
  untPontosQuestFidelidade, untFatSelecaoTabelaPreco, untTHorOpe,
  Faturamento.Classes.TAlterarPedido, untFatExpedicao, untFuncoesEditorFast,
  untValidadorDaRegraValorEmissaoNFCePorEstado, untTefCitelOperacoes,
  untPrincipal, untFatConfOrcamentos_ItensSeries, untAlpe, untCaixaLogCheckOut, untFatInfDataHora,
  untTFuncoesPixAutcom, untTPixDao, untTFuncoesAuxiliaresPix,
  untLinkPagamentoCitelUtil, untMovger,
  CobrancaEletronica.Lib.Types, CobrancaEletronica.Lib.Facade, untTravaCaixa,
  untTPickingCheckOut, untMovimentacaoProgramada, PinPad.Funcoes, PinPad.Interfaces,
  untTicketEstacionamento, untFatFatorServico, untTConsultaCadastroFit, untOrdPro,
  untClassesComumLinkPagamentoCitel, untBaixaAnalitica, untConsultaSituacaoCadastral,
  System.Diagnostics;

{$R *.dfm}

{ TfrmFatConfOrcamentos }

function TfrmFatConfOrcamentos.fCarregarPedidoOrcamento(strNumOrc: String): Boolean;
begin
  edtNumOrc.Text := strNumOrc;
  If (blnAltLoj) Then
    Result := fValidaCampos(edtCodEmp, False)
  Else
    Result := fValidaCampos(edtNumOrc, False);
end;

function TfrmFatConfOrcamentos.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
Var
  blnConstrutora: Boolean;
  blnCodBar     : Boolean;
  Documento     : untTypesSistema.TDocumento;
  LCodigoCorreio: String;
  objDadosNFe: TValidacaoDadosNFe;
begin

  Try
    Result := True;

    If ((Sender = edtNumOrc) Or (Sender = edtCodEmp)) And pnlCabecalho.Enabled Then
    Begin
      If InterlockedIncrement(intSemaforoOrcamento) = 0 Then
      Begin
        edtNumOrc.ReadOnly := true ;
        try
          Try
            blnCodBar := (Length(edtNumOrc.Text) = 18);
            Result := fValidaDocumento(Sender);

            If (Result) And (blnCodBar) And (blnAltLoj) Then
              Result := fValidaDocumento(edtCodEmp);

            if (Result) and (Assigned(fatVenda)) and (fatVenda.fltTotSer > 0) then
            begin
              shpRetISS.Visible := True;
              lblRetISS.Visible := True;
              lblRetISS.Caption := 'Cliente sem retenção de ISS';
              if fatVenda.strRetIss = 'S' then
              begin
                lblRetISS.Caption := 'Cliente com retenção de ISS';
              end;
            end;

            btnGerarPDF.Enabled := Result;
          Except
            InterlockedDecrement(intSemaforoOrcamento);
            Raise;
          End;
          InterlockedDecrement(intSemaforoOrcamento);
        finally
          edtNumOrc.ReadOnly := false ;
        end ;
      End
      Else
        InterlockedDecrement(intSemaforoOrcamento);
    End

    Else If (Sender = edtTipFat) Then
    Begin
      If Not (fEmptyStr(edtTipFat.Text)) Then
      Begin
        Result := fValidarTipoFaturamentoSelecionadoF11(fTipoFaturamentoSelec.strEspDoc,
                                                        strDigCodCnd,
                                                        strConPag,
                                                        strCodOpe,
                                                        fatVenda,
                                                        qryFatGor,
                                                        blnDesmembrarVenda,
                                                        blnTemEntregaFutura,
                                                        blnTemEntregaImediata,
                                                        blnTemRetiraOutraLoja,
                                                        blnVendaOrigOutraLoja,
                                                        blnTemRetiraMesmaLoja,
                                                        blnTemRetiraBalcao,
                                                        blnTemRetiraExpedicao,
                                                        blnTemItensEmpresaCD,
                                                        blnJaValidouDocs);
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'É necessário escolher uma espécie para fechamento!', ['&Ok']);
        Result := False;
      End;

      If (fTipoFaturamentoSelec.strEspDoc <> 'NF') And blnCliCon And blnVendaConsumidorFocarApenasCPF And
         (Not (fCfgConcomitante And Assigned(VS_objFiscal))) Then
      Begin
        blnMudarFoco := False;
        pSetFocus(mskCgcCpf);
        mskCgcCpf.SelectAll;
      End;
    End

    Else If (Sender = edtCodCli) Then
    Begin

      If (fEmptyStr(edtCodCli.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do cliente deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(strEstCliAnt)) And (strEstCliAnt <> fRetNomCidade(fRetCidCliente(edtCodCli.Text),1)) And (blnMudouCodCli) Then
        Begin
          pMensagemOk('O cliente deve ser do estado: ' + strEstCliAnt + '!');
          Result := False;
        End
        Else
        Begin

          pCarregaCliente(True);
          If (qryCadCli.IsEmpty) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&Ok']);
            Result := False;
          End

          Else If blnCliFil Then
          Begin
            fMensagem('ATENÇÃO!', 'Cliente Filial não é permitido nessa operação!', ['&Ok']);
            Result := False;
          End;

        End;
      End;
    End

    Else If (Sender = edtCgcCpf) Then
    Begin
      If fEmptyStr(edtCgcCpf.Text) Or (Pos(edtCgcCpf.Text, '1_2_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe 1-CNPJ / 2-CPF!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = mskCgcCpf) Then
    Begin

      If (Not fEmptyStr(mskCgcCpf.Text)) Then
        Result := fValidaCnpjCpf(edtCgcCpf.Text, mskCgcCpf.Text, True, True);

      If Result And blnCliCon Then
      Begin
        If (mskCgcCpf.Text <> strCgcCpfAnt) Then
        Begin
          pCarregaDadosCadastraisConsumidor;
          strCgcCpfAnt := mskCgcCpf.Text;
        End;

        If (fTipoFaturamentoSelec.strEspDoc <> 'NF') And blnVendaConsumidorFocarApenasCPF Then
        Begin
          blnMudarFoco := False;
          pSetFocus(btnConfirma);
        End;
      End;

      fatVenda.blnCliConF11 := blnCliCon;
    End

    Else If (Sender = edtCidEnt) Then
    Begin

      If (Not fEmptyStr(edtCidEnt.Text)) Then
      Begin

        blnConstrutora := (fAtividadeConstrutora(fRetornaAtividadeCliente(edtCodCli.Text)));

        pCarregaCadCid;

        strNomCid := edtNomCid.Text;
        strCodCid := edtCidEnt.Text;

        If (qryConCid.IsEmpty) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If (Not blnConstrutora) And
                (strEstCliAnt <> qryConCid.FieldByName('CID_ESTADO').AsString) Then
        Begin
          pMensagemOk('O cliente deve ser do estado: ' + strEstCliAnt + '!');
          Result := False;
        End;
      End
      Else
      Begin
        edtNomCid.Clear;
        edtUF.Clear;
        fMensagem('', 'A cidade de entrega deve ser preenchida!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtCodTra) Then
    Begin

      If fEmptyStr(edtCodTra.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A transportadora deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaTransportadora(blnBuscaPorChave);
        If (qryCadTra.IsEmpty) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa transportadora não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = mskPlaFat) Then
    Begin
      If (Not fEmptyStr(mskPlaFat.Text)) And (Not fValidaPlaca(mskPlaFat.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A placa informada não é válida!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = cmbTipFre) Then
    Begin
      If (Not fFreteValido(fTipoFrete(cmbTipFre.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'Selecione um tipo de frete válido!', ['&Ok']);
        Result := False;
      End
      Else If (Not fPermiteFreteProprio(fTipoFrete(cmbTipFre.Text))) Then
        Result := False;
    End

    Else If (Sender = edtNpsS_N) And (edtNpsS_N.Visible) Then
    Begin
      If Not (MatchStr(edtNpsS_N.Text, ['S', 'N'])) Then
      Begin
        fMensagem('', 'Deseja Netpoints deve ser preenchido com "S" ou "N"!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtNotPau) And (edtNotPau.Visible) Then
    Begin
      If Not (MatchStr(edtNotPau.Text, ['S', 'N'])) Then
      Begin
        fMensagem('', 'Nota Fiscal Paulista deve ser preenchido com "S" ou "N"!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtBaiEnt) Then
    Begin
      strBairro := edtBaiEnt.Text;
    End

    Else If (Sender = edtEndEnt) Then
    Begin
       strEndere := edtEndEnt.Text;
    End

    Else If (Sender = mskCepEnt) Then
    Begin

      strNumCep := mskCepEnt.Text;
      strCodCid := edtCidEnt.Text;
      strEndere := edtEndEnt.Text;
      strBairro := edtBaiEnt.Text;
      strNomCid := edtNomCid.Text;

      If (fCfgSis('USACEP', varBoolean)) And (fCfgSis('ECLF11', varBoolean)) And (strNumCep <> strNumCepOld) Then
      Begin

        If (Not fCadCepDadosCep(strNumCep, strCodCid, strEndere, strBairro, strNomCid, strEstado, LCodigoCorreio, '', '')) Then
        Begin
          Result := fMensagem('ATENÇÃO!', 'CEP não encontrado!' + #13 + 'Deseja continuar mesmo assim?', ['&Sim', '&Não'],2) = 1;
        End
        Else
        Begin

          edtCidEnt.Text := strCodCid;
          edtEndEnt.Text := strEndere;
          edtBaiEnt.Text := strBairro;
          edtNomCid.Text := strNomCid;
          fValidaCampos(edtCidEnt, True);

        End;
      End;
    End

    Else If (Sender = edtEmail) And (edtEmail.Enabled) Then
    Begin
      If (Not (fContarString(';', TEditFocus(Sender).Text) In [fContarString('@', TEditFocus(Sender).Text), fContarString('@', TEditFocus(Sender).Text) - 1])) Then
      Begin
        fMensagem('ATENÇÃO!', 'Foram informados mais de 1 endereço de e-mail no campo ' +
          QuotedStr('E-Mail') + ', separe-os com ' + QuotedStr(';') + ' (ponto e vírgula) e certifique-se' +
          ' de que o caracter ' + QuotedStr('@') + ' foi informado corretamente em cada um deles!', ['&Ok']);

        Result := False;
      End;

      If Result Then
        Result := fEmailValido(edtEmail.Text);


      If Result Then
      Begin
        objDadosNFe := TValidacaoDadosNFe.Create(nil);

        Try
          objDadosNFe.strEmaNfe   := edtEmail.Text;
          objDadosNFe.tcTipoCampo := tcEmail1;
          objDadosNFe.strEspDoc   := 'NF';
          objDadosNFe.ovOrigem    := ovCadCli;
          objDadosNFe.blnCliCons  := False;
          objDadosNFe.blnSomenteItensRetira := False;

          Result := fValidaDadosClienteNFe(objDadosNFe);
        Finally
          FreeAndNil(objDadosNFe);
        End;
      End;
    End

    {Comanda}
    else if (pnlComanda.Visible) then
    begin

      if (Sender = edtBarCom) then
      begin

        if not fEmptyStr(edtBarCom.Text) then
        begin

          {Valida faixa permitida!}
          if not TfrmFatDigCodBarrasComanda.fComandaEstaDentroFaixa(edtBarCom.Text) then
          begin
            fMensagem('Atenção', 'Código da comanda esta fora da faixa permitida!', ['&Ok']);
            edtBarCom.Clear;
            pSetFocus(edtBarCom);
          end
          else
          begin

            Documento := TfrmFatDigCodBarrasComanda.fRetPDEmAberto_Comanda(edtBarCom.Text);

            if (not fEmptyStr(Documento.strNumDoc)) then
            begin

              edtNumOrc.Text := Documento.strNumDoc;
              edtCodEmp.Text := Documento.strCodEmp;
              pSetarEdtCodEmpInformativo;

              if not fValidaCampos(edtNumOrc) then
              begin
                Sender := edtBarCom;
                Result := False;
              end;

            end
            else
            begin

              fMensagem('ATENÇÃO!', 'Não foi encontrado nenhum pedido em aberto vinculado a esta comanda!', ['&Ok']);
              edtBarCom.Clear;

              Sender := edtBarCom;
              Result := False;

            end;

          end;

        end;

      end;

    end;

    pSetaVisibilidadeNetpoints;
    pSetaVisibilidadeNotaPaulista;

  Except
    On E: ExceptionAutCom Do
    Begin
      fMensagem('',E.Message,['&OK']);
      Result := False;
    End;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[ValidaFatConfOrçamentos]');
      Result := False;
    End;
  End;

  If (Not Result) And (Sender = edtCodEmp) Then
    Sender := edtNumOrc;

  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmFatConfOrcamentos.fValidaCodAmzCaixa: Boolean;
begin
  Result := True;

  If (fCfgSis('VINAF3', varBoolean)) And (Not fEmptyStr(strCodigoCaixa)) Then
  Begin
    Result := Not fEmptyStr(fCampoTabela('CAX_CODAMZ', 'CADCAX', ['CAX_CODCAX', 'CAX_CODEMP'], [strCodigoCaixa, VS_strCodEmp]));
  End;
end;

function TfrmFatConfOrcamentos.fValidaCreditosVencidos(cdsCredit: TUniClientDataSet): Boolean;
  Var
    intDiasValidadeCredito: Integer;
    strOpeRcx: String;
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
begin
  Result := True;

  intDiasValidadeCredito := fCfgSis('DIACRE', VarInteger);

  strOpeRcx := IIF(fEmptyStr(strCodOpe), strLoginUsuarioLogado, strCodOpe);

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddSeparador(115);
  objLiberacao.objMsgLibera.pAddTexto('***  Utilização de Crédito Expirado  ***', alCentro, teAutcom, '', 115);
  objLiberacao.objMsgLibera.pAddSeparador(115);
  objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade de dias para expirar e solicitar senha para utilização', intDiasValidadeCredito.ToString);

  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'DUPLICATA'  , 13 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'EMP'        , 4  , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'CLIENTE'    , 39 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'DT.CAD.'    , 11 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DT.VENC.'   , 11 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'VR.CREDITO' , 14 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'QTD.DIAS'   , 8  , alDireita  , teAutcom);
  objTabela.lstLinhas.Add(objLinha);

  cdsCredit.First;
  While Not cdsCredit.Eof Do
  Begin
    If (DaysBetween(cdsCredit.FieldByName('DTAVEN').AsDateTime, VS_Date) > intDiasValidadeCredito) Then
    Begin
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('DUPLICATA'  , cdsCredit.FieldByName('NUMDUP').AsString + cdsCredit.FieldByName('PARCEL').AsString       , 13 , alEsquerda );
      objLinha.pAddColuna('EMP'        , cdsCredit.FieldByName('CODEMP').AsString                                                  , 4  , alCentro   );
      objLinha.pAddColuna('CLIENTE'    , cdsCredit.FieldByName('CODCLI').AsString + '-' + cdsCredit.FieldByName('NOMCLI').AsString , 39 , alEsquerda );
      objLinha.pAddColuna('DT.CAD.'    , FormatDateTime('dd/MM/yyyy', cdsCredit.FieldByName('DTACAD').AsDateTime)                  , 11 , alCentro   );
      objLinha.pAddColuna('DT.VENC.'   , FormatDateTime('dd/MM/yyyy', cdsCredit.FieldByName('DTAVEN').AsDateTime)                  , 11 , alCentro   );
      objLinha.pAddColuna('VR.CREDITO' , FormatFloat('#,##0.00', cdsCredit.FieldByName('VLRCRE').AsFloat)                          , 14 , alDireita  );
      objLinha.pAddColuna('QTD.DIAS'   , DaysBetween(cdsCredit.FieldByName('DTAVEN').AsDateTime, VS_Date).ToString                 , 8  , alDireita  );
      objTabela.lstLinhas.Add(objLinha);

      Result := False;
    End;
    cdsCredit.Next;
  End;
  cdsCredit.First;


  If Result Then
    FreeAndNil(objTabela)
  else
  begin
    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
    objLiberacao.strDirAce := 'LIBRECCREDEXP';
    objLiberacao.strMsgSen := 'Utilização de Crédito Expirado';
    objLiberacao.strCodOpe := strOpeRcx;


    Result := objLiberacao.fLibera;
  end;

end;

Procedure TfrmFatConfOrcamentos.pCarregaMensagemPedido(blnLimpar: Boolean = False);
  Var
    intContador: Integer;
Begin
  For intContador := Low(arrMsgNot) To High(arrMsgNot) Do
    arrMsgNot[intContador] := '';

  If Not blnLimpar Then
  Begin
    arrMsgNot[1] := fFatGor('MEN001').AsString;
    arrMsgNot[2] := fFatGor('MEN002').AsString;
    arrMsgNot[3] := fAuxGor('MEN003').AsString;
    arrMsgNot[4] := fAuxGor('MEN004').AsString;
    arrMsgNot[5] := fAuxGor('MEN005').AsString;
  End;
End;

procedure TfrmFatConfOrcamentos.pInformacao(strInfo: String; pgbStatus: TcxProgressBar);
var blnAtualizar: Boolean;
begin
  If Assigned(pgbStatus) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
  Begin
    blnAtualizar := (TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption <> strInfo);
    TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strInfo;

    If blnAtualizar Then
      pProcessMessages;
  End;
end;

procedure TfrmFatConfOrcamentos.pProgresso(Var intProgresso: Integer; intMaximo: Integer; pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    Inc(intProgresso);
    pgbStatus.Position := intProgresso;
    pgbStatus.properties.Max := intMaximo;

    If (intMaximo <= 10) Then
      pProcessMessages
    Else If (intProgresso mod 2) = 0 Then
      pProcessMessages;
  End;
end;

procedure TfrmFatConfOrcamentos.pReceberModalidade;
begin
  fReceberModalidade;
end;

procedure TfrmFatConfOrcamentos.pRemovePixPedidoComValorParcial;
var
  LfltValorPix: Double ;
  LRetornoStatus: String ;
  LqryConsulta: TUniQuery ;
  LstrSeqPix, LstrUsaShp: String ;
begin
  If (qryFatGor.FindField('FGO_TX_PIX') = Nil) Or
       (fTxPixVazia) Then
    Exit ;

  LfltValorPix := fFormataFloat(edtValor.Value, 2);

  If LfltValorPix = fFormataFloat(fStrToFloat(edtTotGer.Text), 2) Then
    Exit ;

  LqryConsulta := fCriaQuery() ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add(' SELECT ') ;
    LqryConsulta.SQL.Add('   M.MPX_SEQPIX, ') ;
    LqryConsulta.SQL.Add('   M.MPX_USASHP ') ;
    LqryConsulta.SQL.Add(' FROM MOVPIX M ') ;
    LqryConsulta.SQL.Add('      JOIN EXTGOR G ON G.FGO_EMPPIX=M.MPX_CODEMP ') ;
    LqryConsulta.SQL.Add('                    AND G.FGO_TX_PIX=M.MPX_TX_ID_ ') ;
    LqryConsulta.SQL.Add('      JOIN FATGOR F ON F.AUTOINCREM=G.FGO_SEQFGO ') ;
    LqryConsulta.SQL.Add(' WHERE F.FGO_NUMDOC = :NUMDOC AND F.FGO_ESPDOC = :ESPDOC AND F.FGO_CODEMP = :CODEMP ') ;
    LqryConsulta.ParamByName('NUMDOC').AsString := qryFatGor.FieldByName('FGO_NUMDOC').AsString ;
    LqryConsulta.ParamByName('ESPDOC').AsString := qryFatGor.FieldByName('FGO_ESPDOC').AsString ;
    LqryConsulta.ParamByName('CODEMP').AsString := qryFatGor.FieldByName('FGO_CODEMP').AsString ;
    LqryConsulta.Open ;
    LstrSeqPix := LqryConsulta.FieldByName('MPX_SEQPIX').AsString ;
    LstrUsaShp := LqryConsulta.FieldByName('MPX_USASHP').AsString ;
  finally
    FreeAndNil(LqryConsulta) ;
  end ;

  fStartTransaction;
  try
    LRetornoStatus := TFuncoesPixAutcom.MudarStatusDoPixParaRemovido(qryFatGor.FieldByName('FGO_TX_PIX').AsString,
                                                                     LstrSeqPix);

    TPixDao.LimparPixDosPedidos(qryFatGor.FieldByName('FGO_EMPPIX').AsString,
                                qryFatGor.FieldByName('FGO_TX_PIX').AsString) ;

    TPixDao.ExcluirRegistroDoPix(qryFatGor.FieldByName('FGO_EMPPIX').AsString,
                                 qryFatGor.FieldByName('FGO_TX_PIX').AsString,
                                 Self.Name,
                                 'EXCLUSÃO - PIX PARCIAL/PIX DIVIDIDO F11',
                                 IIF(LstrUsaShp <> 'S',
                                   'REMOVIDA_PELO_USUARIO_RECEBEDOR',
                                   'cancelled'),
                                   LRetornoStatus);

    pGeraLogLiberacao(qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                      qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                      qryFatGor.FieldByName('FGO_CODEMP').AsString);

    FblnTxIdPixRemovida := True ;
    fatVenda.DadosPixDaVenda.TxIdPix := '' ;

    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;

      pMensagensErro('Ocorreu um erro ao remover o Pix do documento selecionado.' + #13 +
                     'Erro gerado: ' + E.Message, '[TfrmFatConfOrcamentospRemovePixPedidoComValorParcial]');
    End;
  End;
end;

function TfrmFatConfOrcamentos.fEfetivouQuestFidelidade: string;
var
  RetornoAcumula: TRetornoAcumula;
  RetornoResgata: TRetornoResgate;
  strMensagemQuest: string;
  strJSONQuest: string;
  strAusIncLocal: string;
begin
  Result := '';
  if (blnUsandoQuestFidelidade) then
  begin
    try
      if Assigned(AcumulaQuest) then
      begin
        strJSONQuest := AcumulaQuest.ToJsonString;
        RetornoAcumula := TRetornoAcumula.Create;
        RetornoAcumula := fAcumulaPontosQuest(AcumulaQuest);
        if not RetornoAcumula.Erro then
        begin
          if fGravaTransacaoQuest(RetornoAcumula.TransacaoID, strCpfCnpjClienteQuest, QUEST_COMAND_ACUMULA, strJSONQuest, strAusIncLocal) then
          begin
            //strMensagemQuest := 'Pontos Acumulados: ' +FloatToStrF(RetornoAcumula.PontosAcumuladosParticipante, ffFixed, 12, 2)+ '.' +sLineBreak+
            //                    'Saldo Disponível pontos: '+FloatToStrF(RetornoAcumula.SaldoDisponivelPontos, ffFixed, 12, 2)+'.' +sLineBreak+
            //                    'Saldo disponível valor: '+FloatToStrF(RetornoAcumula.SaldoDisponivelValor, ffFixed, 12, 2)+'.';
            //fMensagem('ATENÇÃO!', strMensagemQuest, ['&Ok']);
            Result := strAusIncLocal;
          end;
        end
        else
        begin
          fMensagem('ATENÇÃO!', RetornoAcumula.Mensagem, ['&Ok']);
        end;
      end
      else if Assigned(ResgateQuest) then
      begin
        strJSONQuest := ResgateQuest.ToJsonString;
        RetornoResgata := TRetornoResgate.Create;
        RetornoResgata := fResgataPontosQuest(ResgateQuest);
        if not RetornoResgata.Erro then
        begin
          if fGravaTransacaoQuest(RetornoResgata.TransacaoID, strCpfCnpjClienteQuest, QUEST_COMAND_RESGATA, strJSONQuest, strAusIncLocal) then
          begin
            strMensagemQuest := 'Pontos Resgatados: ' +FloatToStrF(RetornoResgata.PontosResgatados, ffFixed, 12, 2)+ '.' +sLineBreak+
                                'Saldo Disponível pontos: '+FloatToStrF(RetornoResgata.SaldoDisponivelPontos, ffFixed, 12, 2)+'.' +sLineBreak+
                                'Saldo disponível valor: '+FloatToStrF(RetornoResgata.SaldoDisponivelValor, ffFixed, 12, 2)+'.';
            fMensagem('ATENÇÃO!', strMensagemQuest, ['&Ok']);
            Result := strAusIncLocal;
          end;
        end
        else
        begin
          fMensagem('ATENÇÃO!', RetornoResgata.Mensagem, ['&Ok']);
        end;
      end;
    finally
      if Assigned(RetornoAcumula) then
      begin
        FreeAndNil(RetornoAcumula);
      end;

      if Assigned(RetornoResgata) then
      begin
        FreeAndNil(RetornoResgata);
      end;
    end;
  end;
end;

function TfrmFatConfOrcamentos.fEhFaturamentoDeConcreto: Boolean;
begin

  Result := False;

  If Not Assigned(fatVenda) Then
    Exit;

  {NF de remessa da J.A}
  If ((fCfgSis('TPNFCR') = J_A_MASSA_CONCRETO) Or (fRealizaFaturamentoNotaConcretoF11(False))) And
     (fatVenda.strEspDoc = 'NF') And
     (fatVenda.fEhVendaItemConcreto) Then
    Exit(True);

end;

function TfrmFatConfOrcamentos.fEhMultiLojaComAlgumaEmpresaTefDesligado(const AstrNumDoc, AstrEspDoc, AstrCodEmp, AstrCodCli: String): Boolean;
begin
  Result := False ;

  if not fUsaTef then
    Exit ;

  if fCfgSis('MLOTEF', varString) = '1' then
    Exit ;

  if fEmptyStr(AstrNumDoc) then
    Exit ;

  if not (fEhPedOrcMultiloja(AstrNumDoc, AstrEspDoc, AstrCodEmp) or
          (fCfgSis('EMPFAT', varBoolean) and fPedidoEntregaCD(AstrNumDoc, AstrEspDoc, AstrCodEmp, AstrCodCli))
         ) then
    Exit ;

  if not fTemEmpresaTefDesligadoMultiLoja(AstrNumDoc,
                                          AstrEspDoc,
                                          AstrCodEmp) then
    Exit ;

  Result := True ;
end;

function TfrmFatConfOrcamentos.fEhRecebimentoFormasPagtoNegociadas: Boolean;
begin
  Result := Assigned(fatVenda) And (fatVenda.strCodFpg = '009') And
           (Not fEmptyStr(fatVenda.objFormasPagtoNegociada.fGetFormasPagtoSelecionadas));
end;

function TfrmFatConfOrcamentos.fCarregaDocumentoValidaEstoque(pgbStatus: TcxProgressBar = Nil): Boolean;
  Const
    INT_PROGRESSO_MAX = 3;
  Var
    intProgresso: Integer;
    strInformacao: String;
    strFiltroBrindes: String;
    blnDeletouItens : Boolean;
begin
  intProgresso := 0;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Iniciando Venda...', pgbStatus);

  Result := fIniciaFatVenda;

  If Assigned(qryFatGor) And (qryFatGor.Active) Then
    If fEhPedOrcMultiloja(fFatGor('NUMDOC').AsString,
                          fFatGor('ESPDOC').AsString,
                          fFatGor('CODEMP').AsString) Then
      fatVenda.blnVerificarEstoqueComoPDORMultiLoja := True;

  fatVenda.strEspDoc := fRetEspecieSelecionada;
  objCdsVinculos := TCdsVinculosRequisicoes.fGetClientDataSet;

  {****************************************************}
  {* COLOCADA ESTA REGRA AQUI PARA PODER CALCULAR A   *}
  {* CONDIÇÃO DE PAGAMENTO CORRETAMENTE QUANDO A      *}
  {* CONDIÇÃO POSSUIR "FORA" OU O CLIENTE POSSUIR DIA *}
  {* FIXO PARA PAGAMENTO.                             *}
  {*************************************************PZ*}
  If (edtCodPag.Visible) Then
  Begin
    fatVenda.strCodCnd := edtCodPag.Text;
    fatVenda.blnCndEsp := (fRetEspConPag(edtCodPag.Text) = 'S');
    fatVenda.strCodCli := edtCodCli.Text;
    fatVenda.pCarregaCondicaoPagamentoPedido(qryFatGor);
    strConPag      := fatVenda.StrConPag;
    mskCndPag.Text := fFormataCondPag(strConPag);
  End;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Carregando Cliente...', pgbStatus);

  pCarregaClienteVenda(fatVenda);

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Carregando ' + lblTipDoc.Caption +'...', pgbStatus);

  fatVenda.blnFecharForm := False;

  If fPedidoPossuiBrindes(strNumeroDoc, strEspCfo, fEmpresaDocumento) Then
    strFiltroBrindes := 'N'
  Else
    strFiltroBrindes := '';

  If fatVenda.blnVerificarEstoqueComoPDORMultiLoja Then
    fatVenda.pCarregaCfgSis(fatVenda.strEspOrc);

  If (fCfgSis('CDTCLV', varBoolean)) And
     (fEmptyStr(fatVenda.strEspDoc)) Then
    fatVenda.strEspDoc := qryFatGor.FieldByName('FGO_ESPDOC').AsString;

  fatVenda.pCarregaPedidoOrcamento(qryFatGor, blnDeletouItens, pgbStatus, strFiltroBrindes);

  TCdsVinculosRequisicoes.pCarregarClientDataSet(qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                                 qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                                 qryFatGor.FieldByName('FGO_CODCLI').AsString);

  If fUsaRotinaWMS And fUsaRotinaExpedicaoConferenciaRetiraCaixa Then
    fatVenda.objRegravarLotesPedidoWMS := TRegravarLotesPedidoWMS.Create(
      fatVenda.strNumOrc, fatVenda.strEspOrc, fRetornaCodigoDaEmpresa);

  fatVenda.blnTaxaBombeamentoPedOrc := Self.blnVaiEmitirPedidoConcreto And (fCfgSis('TPNFCR') = SECOL);

  If fatVenda.blnTaxaBombeamentoPedOrc And Not fEmptyStr(fatVenda.strNumOrc) Then
    fatVenda.pCarregaTaxaBombeamentoPedOrc;

  If Not fatVenda.fVerificaPesoItensRateioFrete Then
  Begin
    fatVenda.blnFecharForm := True;
  End;

  If fEhRecebimentoFormasPagtoNegociadas Then
  Begin
    If blnRealizandoAdiantamentoPedidoPeloF11 Then
    Begin
      fatVenda.objFormasPagtoNegociada.cdsFormasNegociadas.First;

      While Not fatVenda.objFormasPagtoNegociada.cdsFormasNegociadas.Eof Do
      Begin
        //para recebimento de adiantamento (dinheiro, cheque, cartao, credito, ordem de pagamento)
        If fPos(fatVenda.objFormasPagtoNegociada.cdsFormasNegociadas.FieldByName('CODFPG').AsString, strFormasPagtoAdiantamento) Then
          fatVenda.objFormasPagtoNegociada.cdsFormasNegociadas.Next
        Else
          fatVenda.objFormasPagtoNegociada.cdsFormasNegociadas.Delete;
      End;

      fltValorAdiantamentoPedidoPeloF11 := fatVenda.objFormasPagtoNegociada.fltTotalFormasPagto;

      If (fltValAnt + fltValAdt) > 0 Then
      Begin
        fltValorAdiantamentoPedidoPeloF11 := fltValorAdiantamentoPedidoPeloF11 - (fltValAnt + fltValAdt);

        If fltValorAdiantamentoPedidoPeloF11 <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Adiantamento do pedido já foi realizado!', ['&O k']);
          Result := False;
        End;
      End;

      edtTotGer.Text := FloatToStrF(fltValorAdiantamentoPedidoPeloF11, ffFixed, 12, 2);
      edtValor.Value := fltValorAdiantamentoPedidoPeloF11;

      If fltValorAdiantamentoPedidoPeloF11 <= 0 Then
        Result := False;
    End
    Else If fatVenda.fPedidoRecebidoModalidadesCreditoeAReceberF11(fatVenda.strNumOrc,
                                                              fatVenda.strEspOrc,
                                                              fRetornaCodigoDaEmpresa) Then
    Begin
      fatVenda.objFormasPagtoNegociada.pLimparFormasNegociadas;
      fatVenda.objFormasPagtoNegociada.pAdicionarModalidadesNovoPedidoF11('015',fatVenda.FConPag,fStrToFloat(edtTotGer.Text));
    End
    Else If fatVenda.fPedidoAPrazoComEntradaQuitada(fatVenda.strNumOrc,
                                                    fatVenda.strEspOrc,
                                                    fRetornaCodigoDaEmpresa,
                                                    fatVenda.FConPag) Then
    Begin
      If (fStrToFloat(edtTotGer.Text) > 0) Then
      Begin
        fatVenda.objFormasPagtoNegociada.pLimparFormasNegociadas;
        fatVenda.objFormasPagtoNegociada.pAdicionarModalidadesNovoPedidoF11('008',fatVenda.FConPag,fStrToFloat(edtTotGer.Text));
      End;
    End;

    pCarregaFormasPagamento;
  End;

  If (fatVenda.fZerarDesEsp) Then
    fatVenda.fltDesEsp := 0.0;

  If (blnDeletouItens) Then
    Result := False;

  oleItensVendaPed := cdsVenda.Data;

  If (fatVenda.cdsDadosPedBaixados.RecordCount > 0) Or
     (fPedidoFaturadoParcialmente(fFatGor('NUMDOC').AsString,
                                  fFatGor('ESPDOC').AsString,
                                  fFatGor('CODEMP').AsString)) Then
  Begin
    If (fEhPedidoComServicoEProduto(fFatGor('NUMDOC').AsString,
                                    fFatGor('ESPDOC').AsString,
                                    fFatGor('CODEMP').AsString)) Then
    Begin
      fMensagem('Atenção', 'Pedidos com itens de produtos e serviços, faturados parcialmente, devem ' +
                           'ser faturados pelo módulo de "Confirmação de Pedidos"!', ['&OK']);
    End
    Else
    Begin
      fMensagem('Atenção', 'Não é permitido faturar este documento pelo F11 do Resumo de Caixa, ' +
                           'pois o mesmo foi baixado parcialmente, ou seja, já possui produtos ' +
                           'com quantidade baixada. Para faturar o mesmo é necessário ' +
                           'utilizar o módulo de Venda Normal ou Expedição!', ['&OK']);
    End;

    Result := False;
  End;

  If Result And (Not blnRealizandoAdiantamentoPedidoPeloF11) And (fatVenda.strSegSoc = 'S') Then
  Begin
    fMensagem('', 'Cliente configurado para calcular Seguridade Social, portanto ' +
                  'para faturar este documento é necessário utilizar ' +
                  'o módulo de Venda Normal!', ['&OK']);
    Result := False;
  End;

  If Result And (Not blnRealizandoAdiantamentoPedidoPeloF11) And fatVenda.fTemLoteVazio(cdsVenda) Then
    Result := False;

  If Result And (Not blnRealizandoAdiantamentoPedidoPeloF11) And (Not fatVenda.fVerificaFornedorMarcaNaoPermitidosParaCliente) Then
    Result := False;

  If fatVenda.blnVerificarEstoqueComoPDORMultiLoja Then
    fatVenda.pCarregaCfgSis;

  If Result And (Not blnRealizandoAdiantamentoPedidoPeloF11) Then
  Begin
    If Not fatVenda.fTabelasTintasConfiguradasCorretamente Then
    Begin
      fMensagem('','Tabela de geração da tinta não está ativa no faturamento !' + #13#10 +
                   'Favor verificar tabela de geração no Auttin.' + #13#10 +
                   'Favor verificar o parâmetro CFG_TABPRC.'  ,['&OK']);
      Result := False;
    End;
  End;

  If Result And fFatGor('ESPDOC').AsString.Equals('PD') And (Not fPermiteFaturamentoPedidoComItemEstruturaSemOrdemProducao(fFatGor('NUMDOC').AsString, fFatGor('CODEMP').AsString, objLiberacao)) Then
    Result := False;

  fatVenda.intQtdTra := fFatGor('VOLUME').AsInteger;
  fatVenda.strEspTra := fFatGor('ESPECI').AsString;

  strTipPed := '';
  If Not fEmptyStr(fatVenda.strTipPed) Then
  Begin
    Case fatVenda.strTipPed[1] Of
      'A':
        Begin
          strTipPed := 'NF';
          lblTipoFaturamento.Caption := 'Nota Fiscal';
        End;
      'B':
        Begin
          strTipPed := IIF(SameText(fatVenda.strTipOpe, 'B'), 'BR', 'FF');
          lblTipoFaturamento.Caption := 'Pedido-B';
        End;
      'C':
        Begin
          strTipPed := 'IF';
          lblTipoFaturamento.Caption := 'Cupom Fiscal';
        End;
    Else
      lblTipoFaturamento.Caption := '';
    End;
    pDefineEspecieDefault;
  End;

  lblVendedor.Caption := fatVenda.strCodVen + '-' + fRetNomVendRep(fatVenda.strCodVen);
  lblVendedor.Visible := True;
  lblDesVend.Visible  := True;
  lblTipoFaturamento.Visible := (fCfgSis('TPDCEX') = '1');

  objEndEnt.recEndere := fatVenda.objEndEnt.recEndere;

  If (fatVenda.blnFecharForm) Then
    Result := False;

  pInserirItemServico(fatVenda, fCfgSis('ITESER', varString));

  If (fCfgSis('AUTCEN', varString) = 'S') And (fCfgSis('ITESER', varString) <> fCfgSis('SERTER', varString)) Then
    pInserirItemServico(fatVenda, fCfgSis('SERTER', varString));

  Try
    fatVenda.pPreencheMatrizFechamento('',pOnPreencheMatrizItens);

    {Executa a "pSetaOpcoesFaturamento" aqui para retirar espécies do fechamento de nota de concreto!}
    If (fCfgSis('TPNFCR') = J_A_MASSA_CONCRETO) And fatVenda.fEhVendaItemConcreto Then
      pSetaOpcoesFaturamento(True);

  Except
    on E: Exception do
    begin
      Result := False;
      fMensagem('ATENÇÃO!', E.Message, ['OK']);
      Exit;
    end;
  End;

  blnVendaOrigOutraLoja := (qryFatGor.FieldByName('FGO_CODEMP').AsString <> VS_strCodEmp);
  blnDesmembrarVenda    := fatVenda.fHaveraDesmembramentoVenda(fatVenda.arrMatItens, FMatrizesDesmembramento);
  blnTemEntregaFutura   := fatVenda.fTemEntregaFutura(fatVenda.arrMatItens);
  blnTemEntregaImediata := fatVenda.fTemItensEntregaImediata(fatVenda.arrMatItens);
  blnTemRetiraOutraLoja := fatVenda.fTemItensRetira(fatVenda.arrMatItens, opOutraEmpresa);
  blnTemRetiraExpedicao := fatVenda.fTemItensRetira(fatVenda.arrMatItens, opTodasEmpresas, opLocalRetiraExpedicao);
  blnTemItensEmpresaCD  := fatVenda.fTemItensEmpresaCD(fatVenda.arrMatItens);
  blnTemRetiraMesmaLoja := (fatVenda.fTemItensRetira(fatVenda.arrMatItens, opPropriaEmpresa) And
                           (Not fatVenda.fTemItensRetira(fatVenda.arrMatItens, opPropriaEmpresa, opLocalRetiraCaixa)));
  blnTemRetiraBalcao    := fatVenda.fTemItensRetira(fatVenda.arrMatItens, opTodasEmpresas, opLocalRetiraBalcao) Or
                           fatVenda.fTemItensRetira(fatVenda.arrMatItens, opTodasEmpresas, opLocalRetiraBalcao2);


  blnPedOrcMltLojUtiNps := fEmpresaDoPedidoUtiNps(fFatGor('NUMDOC').AsString,
                                                  fFatGor('ESPDOC').AsString,
                                                  fFatGor('CODEMP').AsString);

  edtVolume.Visible := not (blnDesmembrarVenda And fCfgSis('RCXVOL', varBoolean));
  lblVolume.Visible := not (blnDesmembrarVenda And fCfgSis('RCXVOL', varBoolean));

  If (Result)                                            And
     (Not blnRealizandoAdiantamentoPedidoPeloF11)        And
     (fatVenda.fGeraPDAbastecimentoCDVendaEntregaFutura) Then
  Begin
    If fEmptyStr(fCfgSis('EMP_CD', VarString)) Then
    Begin
      Result := False;

      fMensagem('','Está configurado para gerar pedido de abastecimento pelo C.D. ao faturar Pedidos de Entrega Futura (CFG_ENTABA), ' +
                   'porém a configuração CFG_EMP_CD está vazia. Favor configure o código da empresa C.D. para poder faturar este pedido.',
                   ['&OK']);
    End;
  End;

  fatVenda.blnBloquearCfopQueNaoSejaDeVenda := False;
  If (Result) And
     (Not blnRealizandoAdiantamentoPedidoPeloF11) And
     (fCfgSis('CKCLAD', varBoolean)) And
     (Not blnCliFil) And
     ((SameText(fatVenda.strTipOpe, 'V')) Or (SameText(fatVenda.strTipOpe, 'C'))) And
     (Pos(fatVenda.strOpcDoc, 'VN_CP_') > 0) And
     (fCfgSis('TPNFCR') <> J_A_MASSA_CONCRETO) {J.A Emite simples remessa, não deve travar aqui!} Then
  Begin
    fatVenda.blnBloquearCfopQueNaoSejaDeVenda := True;
  End;

  If Result And (Not blnRealizandoAdiantamentoPedidoPeloF11) And fatVenda.fUltrapassouLimiteItensNFe(strInformacao) Then
  Begin
    pMensagemSonora(strInformacao);
    Result := False;
  End;

  If (Result) And (Not fEmptyStr(edtCodCli.Text)) Then
    Result := Result And fValidarCanhotoNotaFiscalPendente(fatVenda);

  If (Result) And (fatVenda.strTipOpe = 'R') Then
    Result := fPermiteFaturarRemessaContaOrdem(False, fatVenda.strTipOpe);

  If (Result) And (fatVenda.strTipOpe = 'C') Then
    Result := Not fExisteDocumentoContaOrdemComRemessaNaoFaturada(
                    fatVenda.strNumOrc, fatVenda.strEspOrc, VS_strCodEmp);

  {*******************************************}
  {* CASO ESTEJA TUDO OK COM O DOCUMENTO E   *}
  {* UTILIZA TEKA DE CONFERENCIA DE ITENS    *}
  {****************************************JC*}
  If Result And (Not blnRealizandoAdiantamentoPedidoPeloF11) And fCfgSis('ITECFO', varBoolean) Then
  Begin
    pInformacao('Aguarde, Realizando Conferência dos Produtos...', pgbStatus);
    Result := fConferenciaProdutos;
  End;
end;

function TfrmFatConfOrcamentos.fCarregaEstrutura(Item : TDadosFechamento;
                                                 blnBaixaSubItemEstrutura: Boolean): Boolean;

  function fItem(strCampo: String): TField;
  begin
    Result := cdsVenda.FieldByName('ITE_' + strCampo);
  end;

  procedure pSetaPrecoCusto;
  begin
    cdsVenda.First;
    While Not cdsVenda.Eof Do
    Begin
      cdsVenda.Edit;

      fItem('UNIDIG').AsFloat := fItem('PRECUS').AsFloat;
      fItem('UNITAR').AsFloat := fItem('PRECUS').AsFloat;
      fItem('TOTITE').AsFloat := fItem('TOTCUS').AsFloat;
      fItem('DESCON').AsFloat := 0;

      cdsVenda.Post;
      cdsVenda.Next;
    End;
    cdsVenda.First;
  end;

begin

  pCriarFormularios(TfrmCaixa,frmCaixa);
  frmCaixa.blnCarregamentoSubItensConcretoAutomaticamente := True;

  frmCaixa.cdsChkOut := FcdsChkOut ;
  frmCaixa.cdsLogChk := FcdsLogChk ;
  frmCaixa.qryCadCli         := qryCadCli;
  frmCaixa.prcCarregaCliente := pCarregaCliente;
  frmCaixa.strOpeRcx := strCodOpe;
  frmCaixa.strEspCfo := strEspCfo;
  frmCaixa.strTabPre := strTabPrecoFat;
  frmCaixa.objCodBar := objCodBar;

  {Atribui vendedor aqui para não ser solicitado na tela
   do caixa!}
  frmCaixa.strCodVen := fatVenda.strCodVen;

  If Not qryFatGor.IsEmpty Then
  Begin
    frmCaixa.strCodCli := qryFatGor.FieldByName('FGO_CODCLI').AsString;
    frmCaixa.strCodCnd := qryFatGor.FieldByName('FGO_CODCND').AsString;
    frmCaixa.strConPag := qryFatGor.FieldByName('FGO_CONPAG').AsString;
    frmCaixa.blnCndEsp := (fRetEspConPag(qryFatGor.FieldByName('FGO_CODCND').AsString) = 'S');
    frmCaixa.strEstCli := fRetNomCidade(edtCidEnt.Text,1);
    frmCaixa.strAutFgo := qryFatGor.FieldByName('AUTOINCREM').AsString;
    frmCaixa.funcaoDesconto := fRetornaDescontoEspecial;
  End;

  frmCaixa.pIniciaVenda;

  //frmCaixa.Show;
  frmCaixa.edtCodBarra.Text := Item.strCodIte;
  frmCaixa.edtQtd.Text      := Item.fltQtdIte.ToString();

  If Assigned(cdsItensAdd) And (not cdsItensAdd.IsEmpty) Then
    cdsItensAdd.EmptyDataSet;

  Result := frmCaixa.fProcessaItem;

  If (Result) Then
  Begin
    cdsItensAdd.Data := frmCaixa.cdsItens.Data;
    pInserirItensAdicionais(fatVenda, False);
    pSetaPrecoCusto;

    {Na nota de simples remessa não tem
     taxa de bombeamento!}
    fatVenda.fltTotBom := 0.0;
    fatVenda.fltPrcBom := 0.0;
    fatVenda.fltQtdBom := 0.0;

    fatVenda.pPreencheMatrizFechamento;
    fatVenda.pCalculaTotGer(False, False, pOnCalculaTotGer);
    edtTotGer.Text := FloatToStrF(fatVenda.fltTotGer, ffFixed, 12, 2);

  End;

  If Assigned(frmCaixa) Then
    pFreeAndNil(frmCaixa);

end;

function TfrmFatConfOrcamentos.fIniciaFatVenda: Boolean;
begin
  Try
    Result := True;

    pCriarCdsVenda(Nil);

    fatVenda := TFatVenda.CreateInstance('VN', objResumoDeCaixa);
    SetLength(arrTravasLibFinalVenda, 0);
    fatVenda.strOpcDocTrue := '11';
    fatVenda.blnImprimeTicketIF := True;
    fatVenda.blnEmissaoPorFatPedEntCdOutLoj := FPedidoEntCd;
    fatVenda.strOriF11   := 'S';
    fatVenda.strEntFut   := 'S';
    fatVenda.strNomeForm := 'frmFatVendas';
    fatVenda.strCodOpe   := strCodOpe;
    fatVenda.blnVerEstOrc := Not blnRealizandoAdiantamentoPedidoPeloF11;
    fatVenda.blnExisteCampanha := fatVenda.objCamGer.fExisteCampanha(VS_Date);
    fatVenda.blnExisteBonus := fatVenda.objBonGer.fExisteBonus(VS_Date);
    fatVenda.blnRealizandoAdiantamentoPedidoPeloF11 := blnRealizandoAdiantamentoPedidoPeloF11;
    fatVenda.objFormasPagtoNegociada.strCodOperador := strCodOpe;
    fatVenda.strCodigoCaixa   := strCodigoCaixa;

    pSetFunctionsEventosCadPro(fatVenda);

    fatVenda.blnImprimeSep := True;

    fatVenda.blnConfOrcamento := True;
    fatVenda.strNumOrc := edtNumOrc.Text;
    fatVenda.strEspOrc := strEspCfo;
    fatVenda.strEmpOri := fEmpresaDocumento;

    fatVenda.strEspDoc := fRetEspecieSelecionada;

    fatVenda.blnFecharForm := False;

    blnDesmembrarVenda    := False;
    blnTemEntregaFutura   := False;
    blnTemEntregaImediata := False;
    blnTemRetiraOutraLoja := False;
    blnVendaOrigOutraLoja := False;
    blnTemRetiraMesmaLoja := False;
    blnTemRetiraExpedicao := False;
    blnTemRetiraBalcao    := False;
    blnTemItensEmpresaCD  := False;
    blnPedOrcMltLojUtiNps := False;

    SetLength(FMatrizesDesmembramento, 0);

    If Assigned(VS_objFiscal) Then
      VS_objFiscal.blnApenasItensCheckOutF11 := False;
      
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

function TfrmFatConfOrcamentos.fPermiteDocumentoDaEmpresa(strCodEmp: String): Boolean;
begin
  Result := True;
  If (strCodEmp <> strEmpLog) Then
  Begin
    If fCampoEmpresasNoServidorPreenchido(strCodEmp, strEmpLog) Then
    Begin
      If Not fEmpresasNoMesmoServidor(strCodEmp, strEmpLog) Then
      Begin
        Result := False;
        pMensagemOk('Não é possível faturar este documento da ' +
                    'empresa ' + strCodEmp + ' na empresa ' +
                    strEmpLog + ', pois as mesmas não estão ' +
                    'no mesmo servidor.');
      End;
    End
    Else If fEmpresaUsaReplicacao(strEmpLog) Then
    Begin
      Result := False;
      pMensagemOk('Não é possível faturar este documento, ' +
                  'pois a empresa ' + strEmpLog + ' está ' +
                  'configurada para utilizar Replicação.');
    End
    Else If fEmpresaUsaReplicacao(strCodEmp) Then
    Begin
      Result := False;
      pMensagemOk('Não é possível faturar este documento, ' +
                  'pois a empresa ' + strCodEmp + ' está ' +
                  'configurada para utilizar Replicação.');
    End;
  End;
End;

function TfrmFatConfOrcamentos.fPermiteFaturarPedidoDeOutraLoja(strCodEmp,
  strEmp_CD, strEnt_CD: String): Boolean;
begin
  Result := False;

  if (not fCfgSis('NPLF11', varBoolean)) And (strCodEmp = VS_strCodEmp) then
    Exit(True);

  if (strEnt_CD = 'S') and (strEmp_CD = VS_strCodEmp) then
    Exit(True);
end;

function TfrmFatConfOrcamentos.fTravaRepetirFormaPagamento(
  const AstrCodEcf, AstrCodFpg: String): Boolean;
var
  LblnPixCitelHabilitado: Boolean ;
begin
  Result := False ;

  if not fEmptyStr(AstrCodEcf) then
    Exit ;

  LblnPixCitelHabilitado := fCfgSis('USAPIX', varBoolean) ;

  if Pos(AstrCodFpg, ifThen(LblnPixCitelHabilitado, '007_012', '007') ) > 0 then
    Exit ;

  if not cdsModalidades.Locate('CODFPG', AstrCodFpg, []) then
    Exit ;

  Result := True ;
end;

function TfrmFatConfOrcamentos.fValidaDocumento(Sender: TWinControl): Boolean;
  Var
    strNumOs, strNumRom: String;
    blnSomenteServ : Boolean;
    strDocCliQuest: string;
    strEstoqueExterno: String;
    blnVaiResgatarQuest: Boolean;
    objParametrosMensagem: TParametrosMensagem;
    objPedidoAlpe: TAlpe;
    objPedidoLinkPagamentoCitel : TLinkPagamentoCitelClass;
    stlItensOS: TStringList;
    arrMensagem: TStringArray;
    intCont: Integer;
    strEquip: String;
    LblnUtilizarDataEmissaoCalcularDiaVencimento: boolean ;

  function fValidaItemEspecial: Boolean;
  begin

    Result := False;

    If (Pos(fFatGor('ESPDOC').AsString, 'OR_PD_') > 0) And (Not fPermiteItemEspecial('VN')) Then
    Begin

      Result := fncExecutaRelatorio(201, 7578, [],
                        ['NUMDOC','ESPDOC','CODEMP'],
                        [IfThen(Not fEmptyStr(fFatGor('NUMDOC').AsString),fFatGor('NUMDOC').AsString,edtNumOrc.Text),
                        IfThen(Not fEmptyStr(fFatGor('ESPDOC').AsString),fFatGor('ESPDOC').AsString,'OR'),
                        VS_strCodEmp],
                        nil,
                        nil,
                        True,
                        False);

      if Result then
      Begin
          fMensagem('', 'Existem Itens Especiais no Orçamento/Pedido. Verifique!', ['&O k']);
      End;

      pLimparPainelStatus;

    End;

  end;

  function fCarregarDocumento: Boolean;
    var
      frmGravandoDoc: TfrmGravando;
  begin
    Try
      pCriarFormularios(TfrmGravando, frmGravandoDoc);
      frmGravandoDoc.fExecutarAcao := fCarregaDocumentoValidaEstoque;
      frmGravandoDoc.ShowModal;
      Result := frmGravandoDoc.blnConfirma;
    Except

      On E: ExceptionAutcom Do
      Begin
        Result := False;
        pMensagemOK(E.Message);
      End;

      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '');
      End;
    End;
    pFreeAndNil(frmGravandoDoc);
  end;

  function fDocEmRomaneio: Boolean;
  begin
    strNumRom := fDocumentoEmRomaneio(fFatGor('NUMDOC').AsString,
                                      fFatGor('ESPDOC').AsString,
                                      fFatGor('CODEMP').AsString);

    Result := Not fEmptyStr(strNumRom);
  end;

begin

  If (Sender = edtNumOrc) And (Length(edtNumOrc.Text) <= fTamDocCadRec) And (Not fEmptyStr(edtNumOrc.Text)) Then
    edtNumOrc.Text := fStrZero(edtNumOrc.Text, fTamDocCadRec);

  Result := fConverteCodigoBarrasEmNumeroDocumento;

  If (intEmpBai = 2) And blnAltLoj And (Not fEmptyStr(edtCodEmp.Text)) Then
    pSetaEmpresaLogada(edtCodEmp.Text);

  If Result And (Sender = edtNumOrc) And fEmptyStr(edtNumOrc.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'O número do '+strTipoTitulo+' deve ser preenchido!', ['&Ok']);
    Result := False;
  End

  Else If (Sender = edtCodEmp) Then
  Begin
    If fEmptyStr(edtCodEmp.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O código da Empresa deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fEmptyStr(fRetNomeEmpresaSelec(edtCodEmp.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Empresa não está cadastrada!', ['&Ok']);
      Result := False;
    End;
  End;

  If Result And (fCfgSis('PAFECF', varBoolean)) And (fDavPreVendaCadastrado(edtNumOrc.Text, fCfgSis('ESPCFO'), fRetornaCodigoDaEmpresa)) Then
  Begin
    pMensagemOk('Não é permitido faturar este documento pois o mesmo possui um DAV associado. Use o PDVCitel.');
    Result := False;
  End;

  Result := Result And fPermiteDocumentoDaEmpresa(VS_strCodEmp);

  If Result And ((Sender = edtCodEmp) Or
                 ((Sender = edtNumOrc) And (Not blnAltLoj))) Then
  Begin

    strEmpres := edtCodEmp.Text;
    strNumeroDoc := edtNumOrc.Text;

    SetLength(FMatrizesDesmembramento, 0);
    blnDesmembrarVenda    := False;
    blnTemEntregaFutura   := False;
    blnTemEntregaImediata := False;
    blnTemRetiraOutraLoja := False;
    blnVendaOrigOutraLoja := False;
    blnTemRetiraMesmaLoja := False;
    blnTemRetiraExpedicao := False;
    blnTemRetiraBalcao    := False;
    blnTemItensEmpresaCD  := False;
    blnPedOrcMltLojUtiNps := False;

    If fItemPendenteSeparacaoAutoCenter(fEmpresaDocumento, strNumeroDoc, strEspCfo) And
      (Not blnRealizandoAdiantamentoPedidoPeloF11) Then
    Begin
     pMensagemOk('Existem produtos pendentes na Expedição de Serviço que precisam ser regularizados. '
               + 'O pedido não poderá ser faturado com esta pendência. '
               + 'Entre em contato com o setor responsável!');
     Result := False;
    End

    Else If fServicoPendenteAutoCenter(fEmpresaDocumento, strNumeroDoc, strEspCfo) And
           (Not blnRealizandoAdiantamentoPedidoPeloF11) Then
    Begin
      pMensagemOk('Existem serviços não finalizados no Acompanhamento de Serviços. '
                + 'O pedido não poderá ser faturado com esta pendência. '
                + 'Entre em contato com o setor responsável!');
      Result := False;
    End

    Else If fEhPedidoReservaEstoqueEnderecamento(strNumeroDoc, strEspCfo, fEmpresaDocumento) Then
    Begin
      pMensagemOk('Este pedido não pode ser utilizado pois o mesmo se refere à ' +
                  'uma reserva de estoque realizada pela Entrada de Mercadorias ou Devolução!');
      Result := False;
    End

    else if (TYapayFacade.fPedidoPossuiCobrancaAtiva(strNumeroDoc, strEspCfo, fEmpresaDocumento)) and
            (not TYapayFacade.fPedidoFoiPago(strNumeroDoc, strEspCfo, fEmpresaDocumento)) then
    begin
      objParametrosMensagem := TParametrosMensagem.Create;
      try
        objParametrosMensagem.Titulo := 'Yapay';
        objParametrosMensagem.Texto := 'Pedido possuí Cobrança Yapay ativa!';
        objParametrosMensagem.Opcoes := ['&OK'];
        objParametrosMensagem.Url.Caption := 'Visualizar cobrança';
        objParametrosMensagem.Url.Href :=
          TYapayFacade.fLinkPagamento(TYapayFacade.fGetAutIncFatGor(strNumeroDoc, strEspCfo, fEmpresaDocumento));
        fMensagem(objParametrosMensagem);
      finally
        objParametrosMensagem.Free;
      end;
      result := False;
    end

    else if (blnRealizandoAdiantamentoPedidoPeloF11) And
            (TFacadeCobrancaEletronica
               .fExisteCobrancaEletronica(strNumeroDoc, strEspCfo, fEmpresaDocumento, tcPagarMe)) then
    begin
      objParametrosMensagem := TParametrosMensagem.Create;
      try
        objParametrosMensagem.Titulo := 'Pagar.me';
        objParametrosMensagem.Texto := 'Pedido possuí Cobrança Pagar.me ativa!';
        objParametrosMensagem.Opcoes := ['&OK'];
        fMensagem(objParametrosMensagem);
      finally
        objParametrosMensagem.Free;
      end;
      result := False;
    end

    Else If Not fLock_Unlock( 'FATGOR' + edtNumOrc.Text +
                                         strEspCfo +
                                         fEmpresaDocumento,
                                         True,
                                         False)
      and (not fVerificaTravaColetor(edtNumOrc.Text)) Then
    Begin
      fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' +
                    fGetHostLock('FATGOR' + edtNumOrc.Text + strEspCfo + fEmpresaDocumento)  + '!', ['&Ok']);
      Result := False;
    End

    Else If fEhPedidoOriginadoPelaConsignacao(strNumeroDoc, strEspCfo, fEmpresaDocumento) Then
    Begin
      pMensagemOk('Este pedido não pode ser utilizado pois o mesmo se refere à rotina de envio de consignação!');
      Result := False;
    End
    Else If (strEmpLog <> VS_strCodEmp) And (Not fVerificaDECUNIDocumento(fEmpresaDocumento, strEmpLog)) Then
    Begin
      pMensagemOk('Você irá faturar um documento de outra empresa (' + fEmpresaDocumento + '). ' +
                  'Porém, a precisão do unitário está configurada de maneira diferente nas duas empresas, o que pode ' +
                  'gerar divergências no valor contábil e contas a receber dos documentos faturados. É necessário que todas ' +
                  'as empresas envolvidas estejam com o mesmo valor na configuração CFG_DECUNI.');
      Result := False;
    End;

    If Result Then
    Begin
      pCarregaOrcamento;
      strClienteDoc := edtCodCli.Text;
      If (qryFatGor.IsEmpty) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse '+strTipoTitulo+' não está cadastrado ou pertence a outra loja!', ['&Ok']);
        Result := False;
      End
      Else If ((Not rdbAdiantamentoPedido.Checked) And (fFatGor('LOC_PD').AsString = 'S')) Then
      Begin
        fMensagem('ATENÇÃO!', 'É permitido realizar apenas adiantamento deste pedido.', ['&O k']);
        Result := False;
      End
      Else If Not fLock_Unlock( 'CADREC' + edtNumOrc.Text +
                                           strEspCfo +
                                           fEmpresaDocumento +
                                           edtCodCli.Text,
                                           True,
                                           False)
        and (not fVerificaTravaColetor(edtNumOrc.Text)) Then
      Begin
        fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' +
                      fGetHostLock('CADREC' + edtNumOrc.Text + strEspCfo + fEmpresaDocumento + edtCodCli.Text)  + '!', ['&Ok']);
        Result := False;
      End
      Else If (strEspCfo = 'OR') And (qryFatGor.FieldByName('FGO_CODFPG').AsString = '016') And (qryFatGor.FieldByName('FGO_ESPDOC').AsString = 'OR') Then
      Begin
        fMensagem('Atenção','Não é permitido faturar "Orçamento" emitido com a forma de pagamento "016-Financiamento" pela opção "[F11] Conf. Orç.".'+#10#13+
                            'Antes de faturar esse tipo de documento, o mesmo deve ser salvo em "Pedido" pela rotina de "Orçamento" e o sistema deve estar com a CFG_ESPCFO = PD'+#10#13+
                            'Em caso de dúvida entre em contato com a Citel.',['&OK']);
        pLimparTela;                    
        Result := False;                    
      End

      Else If SameText(fFatGor('TIPOPE').AsString, 'U') Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é possível carregar um pedido com o tipo de operação "Uso/Consumo" pelo F11. ' +
                              'Favor utilizar a rotina de expedição!', ['&Ok']);
        pLimparTela;
        Result := False;
      End

      Else If (strEspCfo = 'PD') And
              (Not fPedLiberado(edtNumOrc.Text, fRetornaCodigoDaEmpresa)) And
              fCfgSis('ADINPD', VarBoolean) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse pedido está aguardando liberação Comercial e/ou Financeira!', ['&O k']);
        pLimparTela;
        Result := False;
      End

      {Liberação de Pedidos Externos}
      Else If (strEspCfo = 'PD')              And
              (fCfgSis('LIBEXT', varBoolean)) And
              (TLibExt.fPedidoTemOrigemExterna(edtNumOrc.Text, strEspCfo, fRetornaCodigoDaEmpresa)) And
              (Not TLibExt.fPedidoDeOrigemExternaEstaLiberado(edtNumOrc.Text, strEspCfo, fRetornaCodigoDaEmpresa)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse pedido está aguardando "Liberação de Pedidos Externos"!', ['&Ok']);
        pLimparTela;
        Result := False;
      End

      {Coleta}
      Else If (fCfgSis('COLGAR', varString) = 'S') And (qryFatGor.FieldByName('FGO_COLETA').AsString = 'S') Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse pedido não pode ser ' + IIF(rdbAdiantamentoPedido.Checked, 'adiantado!', 'faturado!') + #13 +
                              'Sua finalidade é apenas de reserva de saldo de estoque (Coleta)!', ['&Ok']);
        pLimparTela;
        Result := False;
      End

      Else If Not ValidarAberturaDoPedidoComPix Then
      Begin
        pLimparTela;
        Result := False;
      End

      Else If blnRealizandoAdiantamentoPedidoPeloF11 And
          Not TAdiantamento.fPermiteSelecionarPedido(edtNumOrc.Text, strEspCfo, fEmpresaDocumento, 'RCX') Then
      Begin
        pLimparTela;
        Result := False;
      End

      Else If blnRealizandoAdiantamentoPedidoPeloF11 And ((fltValAnt + fltValAdt) > 0) And (fStrToFloat(edtTotGer.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Adiantamento do pedido já foi realizado!', ['&O k']);
        pLimparTela;
        Result := False;
      End

      Else If (objResumoDeCaixa.strTipoFechamento <> 'C') And
              (blnRealizandoAdiantamentoPedidoPeloF11 And blnApenasPrazo) Then
      Begin
        pMensagemOk('O caixa já foi fechado, não é permitido realizar o adiantamento do pedido!');
        pLimparTela;
        Result := False;
      End

      Else If (rdbAdiantamentoPedido.Checked = True) And
              (fEhAbastecimentoPorDepositoComEntrega_e_Retira(qryFatGor)) Then
      Begin
        fMensagem('ATENÇÃO!','O pedido informado é de abastecimento por depósito e há item de retira e item de entrega no pedido.'+#13+
                             'Nesse caso, é preciso escolher a opção "Emissão de Faturamento" para que o autcom desmembre e '+
                             'gere dois pedidos novos - um de retira e outro de entrega.'+#13+
                             'Verifique também se as configurações CFG_NPDF11 e CFG_NPRF11 estão ativadas.', ['&Ok'],
                             1, false, 1, 0, false, 0, false, false, false, 220, 620);
        pLimparTela;
        Result := False;
      End

      Else If (fFatGor('ENT_CD').AsString = 'S') And
              (Not blnRealizandoAdiantamentoPedidoPeloF11) And
              (fFatGor('CODEMP').AsString = strEmpLog) And
              (fConPagComEntrada(Self.strConPag)) And
              (not fEhAbastecimentoPorDeposito(qryFatGor)) Then
      Begin
        Try
          If fPergunta('Pedido emitido como entrega pelo CD, portanto não é possível ' +
                       'realizar o faturamento pelo [F11] do resumo de caixa. ' + #13#10 +
                       'Deseja realizar o recebimento do pedido?') Then
          Begin
            rdbAdiantamentoPedido.Checked := True;
//            pAdiantamentoClientePedido(fFatGor('NUMDOC').AsString,
//                                       fFatGor('ESPDOC').AsString,
//                                       fFatGor('CODEMP').AsString,
//                                       fFatGor('CODCLI').AsString,
//                                       True);
          End
          Else
            pLimparTela;
        Finally
          Result := False;
        End;
      End

      Else If (fFatGor('CODFPG').AsString = '016') And
              (blnRealizandoAdiantamentoPedidoPeloF11) And
              (fCampoTabela('FIN_VALADT', 'FATFIN', ['FIN_SEQGER'], [strAutInc]) = 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é possível lançar adiantamento para pedido com financiamento sem valor de entrada!', ['&O k']);
        pLimparTela;
        Result := False;
      End

      Else If (fFatGor('CODFPG').AsString = '016') And
              (blnRealizandoAdiantamentoPedidoPeloF11) And
              (fCampoTabela('FIN_VALADT', 'FATFIN', ['FIN_SEQGER'], [strAutInc]) > 0) And
              (TAdiantamento.fGetTotaisAdiantamento(fFatGor('NUMDOC').AsString,
                                                    fFatGor('ESPDOC').AsString,
                                                    fFatGor('CODEMP').AsString).fltValLan > 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Adiantamento do pedido já foi realizado!', ['&O k']);
        pLimparTela;
        Result := False;
      End

      Else If (fFatGor('CODFPG').AsString = '016') And
              (Not blnRealizandoAdiantamentoPedidoPeloF11) And
              (fCampoTabela('FIN_VALADT', 'FATFIN', ['FIN_SEQGER'], [strAutInc]) > 0) And
              (TAdiantamento.fGetTotaisAdiantamento(fFatGor('NUMDOC').AsString,
                                                    fFatGor('ESPDOC').AsString,
                                                    fFatGor('CODEMP').AsString).fltValLan = 0) Then
      Begin
        Try
          If fPergunta('Pedido emitido com (financiamento + entrada), portanto é necessário ' +
                       'realizar o recebimento da entrada antes do faturamento pelo [F11] do resumo de caixa. ' + sLineBreak +
                       'Deseja realizar o recebimento do pedido?') Then
          Begin
            rdbAdiantamentoPedido.Checked := True;
//            pAdiantamentoClientePedido(fFatGor('NUMDOC').AsString,
//                                       fFatGor('ESPDOC').AsString,
//                                       fFatGor('CODEMP').AsString,
//                                       fFatGor('CODCLI').AsString,
//                                       False);
          End
          Else
            pLimparTela;
        Finally
          Result := False;
        End;
      End

      Else If (Not blnRealizandoAdiantamentoPedidoPeloF11) And
              (Not fEhAbastecimentoPorDepositoComEntrega_e_Retira(qryFatGor)) And
              (fFatGor('ENT_CD').AsString = 'S') And
              (fFatGor('EMP_CD').AsString <> strEmpLog) Then
      Begin
        pMensagemOk('Pedido emitido como entrega pelo CD, portanto o faturamento deverá ser realizado pela Empresa CD!');
        pLimparTela;
        Result := False;
      End

      Else If (fFatGor('JAFATU').AsInteger = 1) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse '+strTipoTitulo+' já foi faturado!', ['&Ok']);
        pLimparTela;
        Result := False;
      End

      Else If SameText(fFatGor('TIPOPE').AsString, 'B') Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é possível carregar um pedido com o tipo de operação "Bonificação" pelo F11. ' +
                              'Favor utilizar a rotina de venda normal, expedição ou confirmação de pedidos!', ['&Ok']);
        pLimparTela;
        Result := False;
      End

      Else If blnCliFil Then
      Begin
        fMensagem('ATENÇÃO!', 'Cliente Filial não é permitido nessa operação!', ['&Ok']);
        pLimparTela;
        Result := False;
      End

      Else If Assigned(qryFatGor) And qryFatGor.Active And
             (Not TFatVenda.fValidarSeClienteEstoqueExternoPermiteFaturamento(fFatGor('CODCLI').AsString, strEstoqueExterno)) Then
      Begin
        pMensagemOk(Format('O documento selecionado é do cliente do estoque externo "%s" e não pode ser faturado pelo Autcom!', [strEstoqueExterno]));
        pLimparTela;
        Result := False;
      End

      Else If (fRetornaStatusCliente(fFatGor('CODCLI').AsString) = 'I') And
              (fCfgSis('TRASCL', VarBoolean)) And
              (Not TFatVenda.fPermiteVenderApenasDinheiroECartaoParaInativo('11')) Then
              (*********************************)
              (* ORIENTADO PARA MUDAR A TRAVA  *)
              (******************************LA*)
              // ((strEspCfo <> 'OR') Or (Not fCfgSis('ORINAT', VarBoolean))) Then
      Begin
        fMensagem('ATENÇÃO!', 'O cliente está com atividade suspensa!', ['&OK']);
        pLimparTela;
        Result := False;
      End;

      {***************************************************}
      {* SE O TIPO DE EXPEDIÇÃO FOR POR PEDIDO(OPÇÃO 4)  *}
      {* E O PEDIDO NÃO FOI EXPEDIDO, NÃO DEIXA FATURAR. *}
      {************************************************PZ*}
      If (Result) And
         (blnObrigarExpedirAntesDeFaturar) And
         (VS_strTipExp = '4') And
         (Not fUsaRotinaExpedicaoConferenciaRetiraCaixa) And
         (Not blnRealizandoAdiantamentoPedidoPeloF11) And
         (fFatGor('ESPDOC').AsString = 'PD')   And
         (Not fPedidoFoiExpedido(fFatGor('NUMDOC').AsString,
                                 fFatGor('CODEMP').AsString,
                                 fFatGor('CODCLI').AsString,
                                 True,
                                 False,
                                 (VS_strTipExp = '4') And (fCfgSis('LOCRET', varBoolean)) And ( Not fCfgSis('EXRETC', varBoolean)),
                                 IIF(fRetornaCodigoDaEmpresa = VS_strCodEmp, VS_strCodEmp, ''))) Then
      Begin
        fMensagem('ATENÇÃO!', 'O pedido deve ser expedido antes de faturar!', ['&O k']);
        pLimparTela;
        Result := False;
      End;

      If (Result) Then
      Begin
        If (VS_strTipExp = '4') And
           (fCfgSis('BLOPED', varBoolean)) And
           ((fPedidoPossuiItensEntregaImediata(fFatGor('NUMDOC').AsString, fFatGor('ESPDOC').AsString, fFatGor('CODEMP').AsString)) Or
           (fPedidoPossuiItensRetira(fFatGor('NUMDOC').AsString, fFatGor('ESPDOC').AsString, fFatGor('CODEMP').AsString))) And
           (blnRealizandoAdiantamentoPedidoPeloF11) And
           (fFatGor('ESPDOC').AsString = 'PD')   And
           (Not fPedidoFoiExpedido(fFatGor('NUMDOC').AsString,
                                   fFatGor('CODEMP').AsString,
                                   fFatGor('CODCLI').AsString,
                                   True,
                                   False,
                                   (VS_strTipExp = '4') And (fCfgSis('LOCRET', varBoolean)) And ( Not fCfgSis('EXRETC', varBoolean)),
                                   IIF(fRetornaCodigoDaEmpresa = VS_strCodEmp, VS_strCodEmp, ''))) Then
        Begin
          fMensagem('ATENÇÃO!', 'O pedido deve ser expedido antes de realizar adiantamento!', ['&O k']);
          pLimparTela;
          Result := False;
        End;
      End;

      If (Result) And
         (fUsaRotinaExpedicaoConferenciaRetiraCaixa) And
         (Not blnRealizandoAdiantamentoPedidoPeloF11) And
         (fPedidoPossuiItensRetiraCaixaNaoExpedidos(fFatGor('NUMDOC').AsString,
                                                    fFatGor('ESPDOC').AsString,
                                                    fFatGor('CODEMP').AsString)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Os produtos de retira caixa devem ser conferidos antes de faturar!', ['&O k']);
        pLimparTela;
        Result := False;
      End;

      If (Result) And
         (rdbEmissaoFaturamento.Checked) And
         (fFatGor('ABADEP').AsString = 'S') Then
      Begin
        fMensagem('ATENÇÃO!', 'Este Pedido de Venda se trata de um Abastecimento por Depósito e o mesmo deve ser faturado na Expedição.', ['&Ok']);
        pLimparTela;
        Result := False;
      End;

      If (Result) And
         ((fCfgSis('LOCRET', varString) = 'S') And (VS_strTipExp <> '1')) And
         (Not blnRealizandoAdiantamentoPedidoPeloF11) And
         (fPedidoEhRetiraExpedicaoOriginadoDeOutroPedido(fFatGor('NUMDOC').AsString,
                                                         fFatGor('ESPDOC').AsString,
                                                         fFatGor('CODEMP').AsString)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse pedido deve ser retirado/faturado pela expedição!', ['&O k']);
        pLimparTela;
        Result := False;
      End;

      If Result Then
      Begin
        If (fCfgSis('BLQRET', varBoolean)) And
           (VS_strTipExp = '3') And
           (fFatGor('ESPDOC').AsString = 'PD') And
           (fFatGor('ENTFAT').AsString = 'N' ) And
           (fFatGor('ENT_CD').AsString = 'N' ) And
           (fFatGor('LIBSPR').AsString = 'N' ) And
           (Not fEhPedOrcMultiloja(fFatGor('NUMDOC').AsString,
                                   fFatGor('ESPDOC').AsString,
                                   fFatGor('CODEMP').AsString)) Then
        Begin
          blnSomenteServ := False;
          If (Not fDocumentoPossuiServicos(fFatGor('NUMDOC').AsString,
                                           fFatGor('ESPDOC').AsString,
                                           fFatGor('CODEMP').AsString,
                                           blnSomenteServ)) Or
             (Not blnSomenteServ) Then
          Begin
            fMensagem('ATENÇÃO!', 'O pedido de retira deve ser separado antes de faturar!', ['&O k']);
            pLimparTela;
            Result := False;
          End;
        End;
      End;

      If Result And blnRealizandoAdiantamentoPedidoPeloF11 Then
      Begin
        If Not fVerificaAcessoSistema('DIRRCXADC', strCodOpe) Then
        Begin
          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('Adiantamento de Cliente (Resumo de Caixa)');

          objLiberacao.strDirAce := 'DIRRCXADC';
          objLiberacao.strMsgSen := 'Adiantamento de Cliente';
          objLiberacao.blnMosMen := True;
          objLiberacao.strCodOpe := strCodOpe;
          objLiberacao.strCodDig := strCodOpe;


          If (Not objLiberacao.fLibera) Then
          Begin
            pLimparTela;
            Result := False;
          End;
        End;
      End;

      If Result And blnRealizandoAdiantamentoPedidoPeloF11 And (fFatGor('ENT_CD').AsString = 'S') Then
      Begin
        If Not fVerificaAcessoSistema('DIRRCXRECF11', strCodOpe) Then
        Begin
          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('Recebimentos Pedidos Entrega pelo CD (F11)');

          objLiberacao.strDirAce := 'DIRRCXRECF11';
          objLiberacao.strMsgSen := 'Recebimentos Pedidos Entrega pelo CD (F11)';
          objLiberacao.blnMosMen := True;
          objLiberacao.strCodOpe := strCodOpe;
          objLiberacao.strCodDig := strCodOpe;

          If (Not objLiberacao.fLibera) Then
          Begin
            pLimparTela;
            Result := False;
          End;
        End;
      End;

      If Result And (blnRealizandoAdiantamentoPedidoPeloF11 Or blnAdiantamentoAutomatico) Then
      Begin
        fltValorAdiantamentoPedidoPeloF11 := TAdiantamento.fPedeValorAdiantamento(edtNumOrc.Text, strEspCfo, fEmpresaDocumento, 'RCX');

        If (fltValorAdiantamentoPedidoPeloF11 <= 0) And blnRealizandoAdiantamentoPedidoPeloF11 Then
        Begin
          pLimparTela;
          Result := False;
        End
        Else
        Begin
          edtTotGer.Text := FloatToStrF(fltValorAdiantamentoPedidoPeloF11, ffFixed, 12, 2);
          edtValor.Value := fltValorAdiantamentoPedidoPeloF11;
        End;
      End;

      if Result and (not fPermiteCarregarPDOrdServico(qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                                      qryFatGor.FieldByName('FGO_CODEMP').AsString)) then
      begin
        pLimparTela;
        Result := False;
      end;

      If Result And
        (Not fCfgSis('FTPDOS', varBoolean)) And
        (Not blnRealizandoAdiantamentoPedidoPeloF11) Then
      Begin
        If (Not fOSFinalizada(fFatGor('NUMDOC').AsString,
                              fFatGor('ESPDOC').AsString,
                              fFatGor('CODEMP').AsString,
                              strNumOs)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este Pedido de Venda é oriundo da Ordem de Serviço ' + strNumOs + #13 +
                                'e a mesma ainda não foi finalizada. Procure o responsável' + #13 +
                                'pela rotina de Conserto de Equipamentos para realizar' + #13 +
                                'este procedimento e liberar o faturamento deste Pedido.', ['&O k']);
          pLimparTela;
          Result := False;
        End;
      End;

      if Result and
        (not fOSFinalizadaArmazenada(fFatGor('NUMDOC').AsString,
                                     fFatGor('ESPDOC').AsString,
                                     fFatGor('CODEMP').AsString,
                                     strNumOs, strEquip)) and
        (not blnRealizandoAdiantamentoPedidoPeloF11) then
      begin
        fMensagem('ATENÇÃO!', 'Este pedido de venda é oriundo de Conserto de Equipamento através da Ordem de Serviço ' + strNumOs + '.' + #13 +
                              'Para permitir seu faturamento, é necessário que o Armazenamento do Equipamento tenha ' +
                              'sido realizado e esteja pronto pra ser retirado, porém isso ainda não ocorreu.' + #13 +
                              'Entre em contato com o departamento de Assitência Técnica para solicitar que isso seja feito.' + #13 +
                              'Equipamento: ' + strEquip, ['&OK'], 1, False, 1, 0, False, 0, False, False, False, 230, 560);
        pLimparTela;
        Result := False;
      end;

      if Result and
        (fOSGarantiaLoja(fFatGor('NUMDOC').AsString,
                         fFatGor('ESPDOC').AsString,
                         fFatGor('CODEMP').AsString,
                         strNumOs)) then
      begin
        fMensagem('ATENÇÃO!', 'Este Pedido de Venda é oriundo da Ordem de Serviço ' + strNumOs + ' e a mesma se trata de GARANTIA LOJA. ' +
                              'O Pedido de Venda deve ser faturado pela rotina de Confirmação de Pedidos.', ['&O k']);
        pLimparTela;
        Result := False;
      end;

      stlItensOS := TStringList.Create;

      try
        if Result and (fOSItensNaoReservados(fFatGor('NUMDOC').AsString,
                       fFatGor('ESPDOC').AsString,
                       fFatGor('CODEMP').AsString,
                       '',
                       strNumOs,
                       stlItensOS)) then
        begin
          SetLength(arrMensagem, 0);

          pAddDados(arrMensagem, fPadR('-', 58, '-'));
          pAddDados(arrMensagem, fPadR('|Cód.Item|Descrição', 57) + '|');
          pAddDados(arrMensagem, fPadR('-', 58, '-'));

          for intCont := 0 to Pred(stlItensOS.Count) do
          begin
            pAddDados(arrMensagem, '|' + fPadR(Copy(stlItensOS[intCont], 1, 56), 56) + '|');
          end;

          fMensagemTabela('ATENÇÃO!',
                          'Produtos',
                          arrMensagem,
                          'Não é permitido faturar o pedido ' + fFatGor('NUMDOC').AsString + '-PD-' + fFatGor('CODEMP').AsString +
                            ' pois ele possui produtos que não estão reservando estoque (OS).' + #13 + #13 +
                            'OS: ' + strNumOs + #13 +
                            'Acesse a rotina "Liberação de Reserva de Estoque Itens de Pedido de Venda - OS", ' +
                            'realize a liberação da reserva do estoque e depois, tente novamente.',
                          ['&Ok'],
                          1,
                          False,
                          1,
                          0,
                          False,
                          0,
                          False,
                          False,
                          False,
                          400,
                          100);

          pLimparTela;
          Result := False;
        end;
      finally
        FreeAndNil(stlItensOS);
      end;
    End;

    If Result Then
    Begin
      If (Not fEmptyStr(fFatGor('NUMDOC').AsString)) And
         (SameText(fFatGor('ESPDOC').AsString, 'PD')) And
         (fFatGor('ORIGEM').AsString <> 'AGRUPAMENTO') And

         (fPedidoOriginadoOutroPedidoPeloF11Caixa(fFatGor('NUMDOC').AsString,
                                                  fFatGor('CODEMP').AsString)) And

         (fPedidoPossuiItensRetira(fFatGor('NUMDOC').AsString,
                                   fFatGor('ESPDOC').AsString,
                                   fFatGor('CODEMP').AsString)) And

         (Not fPermiteFaturarPedidoDeOutraLoja(fFatGor('CODEMP').AsString,
                                               fFatGor('EMP_CD').AsString,
                                               fFatGor('ENT_CD').AsString)) Then
      Begin
        fMensagem('ATENÇÃO!', MSG_PEDIDO_ORIGEM_F11_FATURAR_PELA_EXPEDICAO, ['&O k']);
        pLimparTela;
        Result := False;
      End
      Else
      If (Not fEmptyStr(fFatGor('NUMDOC').AsString)) And
         (SameText(fFatGor('ESPDOC').AsString, 'PD')) And
         (fFatGor('ORIGEM').AsString <> 'AGRUPAMENTO') And

         (fPedidoOriginadoOutroPedidoPeloF11Caixa(fFatGor('NUMDOC').AsString,
                                                  fFatGor('CODEMP').AsString)) And

         (fPedidoPossuiItensEntregaImediata(fFatGor('NUMDOC').AsString,
                                            fFatGor('ESPDOC').AsString,
                                            fFatGor('CODEMP').AsString)) Then
      Begin
        {*********************************************************************************}
        {* Caso não permita faturar pedidos de entrega imediata gerados pelo próprio F11 *}
        {******************************************************************************JC*}
        If Not fCfgSis('FNPDEI', VarBoolean) Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido carregar um pedido que foi ' +
                                'originado a partir de outro pedido pelo F11 do Resumo ' +
                                'de Caixa. Para faturar este pedido utilizar rotina de Expedição!', ['&O k']);
          pLimparTela;
          Result := False;
        End
        Else If (TFatVenda.fTotalDuplicataQuitada(fFatGor('NUMDOC').AsString,
                                                  fFatGor('ESPDOC').AsString,
                                                  fFatGor('CODEMP').AsString,
                                                  fFatGor('CODCLI').AsString) > 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido carregar um pedido que foi ' +
                                'originado a partir de outro pedido pelo F11 do Resumo ' +
                                'de Caixa e que possua contas a receber quitado!', ['&O k']);
          pLimparTela;
          Result := False;
        End
        Else If (TAdiantamento.fGetTotaisAdiantamento(fFatGor('NUMDOC').AsString,
                                                      fFatGor('ESPDOC').AsString,
                                                      fFatGor('CODEMP').AsString).fltValLan > 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido carregar um pedido que foi ' +
                                'originado a partir de outro pedido pelo F11 do Resumo ' +
                                'de caixa e que possua adiantamento de cliente!', ['&O k']);
          pLimparTela;
          Result := False;
        End
        Else If (fFatGor('CODFPG').AsString = '016') Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido carregar um pedido que foi ' +
                                'originado a partir de outro pedido pelo F11 do Resumo ' +
                                'de Caixa e que a Forma de Pagamento seja "016 - FINANCIAMENTO". ' +
                                'Para faturar este pedido utilizar rotina de Expedição!', ['&OK']);
          pLimparTela;
          Result := False;
        End;

      End;
    End;

    If Result Then
    Begin
      If fDocEmRomaneio And fCfgSis('USPRRO', varBoolean) And (Not blnRealizandoAdiantamentoPedidoPeloF11) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse pedido está associado ao(s) Romaneio(s): ' + strNumRom + '.' + #13#10 +
                              'Utilizar rotina de Expedição para Faturar o mesmo!', ['&Ok']);
        pLimparTela;
        Result := False;
      End
    End;

    If Result And
       SameText(strEspCfo, 'PD')                                        And
       ( Not fEmptyStr( edtNumOrc.Text ) )                              And
       ( TAdiantamentoGenerico.fRetornaValorBoletosAdiantamento(
                          fFatGor('NUMDOC').AsString,
                          fFatGor('ESPDOC').AsString,
                          fFatGor('CODEMP').AsString,
                          fFatGor('CODCLI').AsString) > 0 ) Then
    Begin
      If fFatGor('BOLVEN').AsString = 'S' Then
        fMensagem('ATENÇÃO!', 'Esse documento possui ' +
                              'boleto(s) de adiantamento. '+ #13#10+
                              'Utilizar rotina de Expedição para Faturar o mesmo!', ['&OK'])
      Else
        fMensagem('ATENÇÃO!', 'Esse documento possui ' +
                              'boleto de adiantamento '+
                              'que ainda não foi baixado pela '+
                              'remessa bancária!', ['&OK']);
      pLimparTela;
      Result := False;
    End;

    {Verifica se orçamento esta fora do prazo de validade!}
    If Result Then
    Begin
      If (Not fEmptyStr(fFatGor('NUMDOC').AsString))          And
         (fFatGor('ESPDOC').AsString = 'OR')                  And
         ((fCfgSis('ORCVEN', varInteger) > 0) Or fCfgSis('IFVLOR', varBoolean)) And
         (fCfgSis('ORCVBL', varBoolean))                                        Then
      Begin

        If (not TFatVenda.fTravaOrcVenc(fFatGor('NUMDOC').AsString,
                                        fFatGor('ESPDOC').AsString,
                                        fFatGor('CODEMP').AsString)) Then
        Begin
          pLimparTela;
          Result := False;
        End;

      End;
    End;

    If Result Then
    Begin
      If fPedidoBaixaEntregaFutura(fFatGor('NUMDOC').AsString,
                                   fFatGor('ESPDOC').AsString,
                                   fFatGor('CODEMP').AsString) Then
      Begin
        fMensagem('ATENÇÃO!', 'Pedidos de Baixa de Entrega Futura devem ser faturados pela rotina de Expedição!', ['&Ok']);
        pLimparTela;
        Result := False;
      End
    End;

    If (Result) Then
    Begin
      If (qryConCid.FieldByName('CID_ESTADO').AsString <> 'EX') And
         (Not blnRealizandoAdiantamentoPedidoPeloF11) And
         (fItensObrigatoriedadeCpf(fFatGor('NUMDOC').AsString,
                                   fFatGor('ESPDOC').AsString,
                                   fFatGor('CODEMP').AsString,
                                   fFatGor('CODCLI').AsString)) Then
      Begin
        pLimparTela;
        Result := False;
      End;
    End;

    If (Result) Then
    Begin
      If (Not blnRealizandoAdiantamentoPedidoPeloF11) And
         (fItensObrigatoriedadeCodigoIbama(fFatGor('NUMDOC').AsString,
                                           fFatGor('ESPDOC').AsString,
                                           fFatGor('CODEMP').AsString,
                                           fFatGor('CODCLI').AsString)) Then
      Begin
        pLimparTela;
        Result := False;
      End;
    End;

    If (Result) Then
    Begin

      If fValidaItemEspecial Then
      Begin
        pLimparTela;
        Result := False;
      End;

    End;

    If (Result) Then
    Begin
      LblnUtilizarDataEmissaoCalcularDiaVencimento := TfatVenda.fUtilizarDataEmissaoCalcularDiaVencimento(fFatGor('NUMDOC').AsString, fFatGor('ESPDOC').AsString, fFatGor('CODEMP').AsString) ;
      If (Not fPermiteClienteDiaFixoOuDiaSemana(edtCodCli.Text, LblnUtilizarDataEmissaoCalcularDiaVencimento)) Then
      Begin
        pLimparTela;
        Result := False;
      End;
    End;

    If (Result) Then
    Begin
      LblnUtilizarDataEmissaoCalcularDiaVencimento := TfatVenda.fUtilizarDataEmissaoCalcularDiaVencimento(fFatGor('NUMDOC').AsString, fFatGor('ESPDOC').AsString, fFatGor('CODEMP').AsString) ;
      If Not fPermiteUtilizarEstaCondPagamento(edtCodPag.Text, LblnUtilizarDataEmissaoCalcularDiaVencimento) Then
      Begin
        pLimparTela;
        Result := False;
      End;
    End;

    If (Result) Then
    Begin
      blnVaiEmitirPedidoConcreto := False;

      If fDocumentoPossuiItemConcreto(fFatGor('NUMDOC').AsString,
                                      fFatGor('ESPDOC').AsString,
                                      fFatGor('CODEMP').AsString) Then
      Begin
        {*******************************************************************************}
        {* NA SECOL QUANDO GERA NOVO PEDIDO DE ENTREGA IMEDIATA NO F11 E O PEDIDO DE   *}
        {* CONCRETO É DE ENTREGA IMEDIATA ENTAO PERMITE FATURAR PELO F11, POIS A NF DE *}
        {* SIMPLES REMESSA DE CONCRETO SERA EMITIDA PELA EXPEDICAO DESTE NOVO PEDIDO.  *}
        {***************************************************************************JC**}
        blnVaiEmitirPedidoConcreto := fCfgSis('NPDF11', varBoolean) And (fCfgSis('TPNFCR') = SECOL) And
                                      fPedidoPossuiItensEntregaImediata(fFatGor('NUMDOC').AsString,
                                                                        fFatGor('ESPDOC').AsString,
                                                                        fFatGor('CODEMP').AsString);

        If fQuantidadeItensPedido(fFatGor('NUMDOC').AsString,
                                  fFatGor('ESPDOC').AsString,
                                  fFatGor('CODEMP').AsString) > 1 Then
        Begin
          fMensagem('ATENÇÃO!', strTipoTitulo + 's de venda de concreto devem possuir somente o item concreto. ' +
                                'Favor alterar este documento antes de faturar o mesmo!', ['&Ok']);
          pLimparTela;
          Result := False;
        End

        Else If (Not blnVaiEmitirPedidoConcreto) And
                (Not blnRealizandoAdiantamentoPedidoPeloF11) And
                (Not fRealizaFaturamentoNotaConcretoF11) And
                (fCfgSis('TPNFCR') <> J_A_MASSA_CONCRETO) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este ' + strTipoTitulo + ' possui itens concreto, ' +
                                'somente é permitido faturar o mesmo pela Venda Normal!', ['&Ok']);
          pLimparTela;
          Result := False;
        End;
      End;

      If Result And
         blnRealizandoAdiantamentoPedidoPeloF11 And
         fEhPedOrcMultiloja(fFatGor('NUMDOC').AsString,
                            fFatGor('ESPDOC').AsString,
                            fFatGor('CODEMP').AsString) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é possível realizar o adiantamento de um Pedido/Orçamento Multiloja. '+
          'Favor solicitar ao vendedor que realize o desmembramento do documento e somente depois de '+
          'desmembrado realizar o adiantamento!', ['&Ok']);
        pLimparTela;
        Result := False;
      End;

      If Result And fCfgSis('EMPFAT', varBoolean) And Not fCfgSis('EMPFVN', VarBoolean) Then
      Begin

        If fEhPedOrcMultiloja(fFatGor('NUMDOC').AsString,
                              fFatGor('ESPDOC').AsString,
                              fFatGor('CODEMP').AsString) Then
        Begin
          If Not fUsaRotinaExpedicaoConferenciaRetiraCaixa And
             Not fPedidoTemSomenteItensParaEmpresasCD(fFatGor('NUMDOC').AsString,
                                                      fFatGor('ESPDOC').AsString,
                                                      fFatGor('CODEMP').AsString) Then
          Begin
            fMensagem('ATENÇÃO!', 'Pedido/Orçamento Multiloja. Desmembre-o antes de faturar!', ['&Ok']);
            pLimparTela;
            Result := False;
          End;
        End;

      End;

      If Result And (Not fCarregarDocumento) Then
      Begin
        pLimparTela;
        Result := False;
      End;

      If Result Then
      Begin
        pCarregarFormulacaoBaixada(fatVenda.stlFormulacaoBaixada,
                                   fFatGor('NUMDOC').AsString,
                                   fFatGor('ESPDOC').AsString,
                                   fFatGor('CODEMP').AsString);
      End;


      If (Result) And (Not blnRealizandoAdiantamentoPedidoPeloF11) Then
        pVerificarUtilizacaoDoTecladoSEAT;

      if Result then
      begin
        objPedidoAlpe := TAlpe.Create;
        try
          objPedidoAlpe
          .pCarregaPedidoAlpe(
             fFatGor('NUMDOC').AsString,
             fFatGor('ESPDOC').AsString,
             fFatGor('CODEMP').AsString );

          if ( Pos(objPedidoAlpe.strTipRec, 'ALPE') > 0 ) then
          begin
            if blnRealizandoAdiantamentoPedidoPeloF11 then
            begin
              pMensagemOk('Adiantamentos de pedidos ALPE são realizados automaticamente, portanto não será permitido prosseguir com a operação.');
              pLimparTela;
              Result := False;
            end
            else
            begin
              if not objPedidoAlpe.fVerificaEstrutura then
              begin
                pMensagemOk('Existem problemas na estrutura do pedido ALPE. Entre em contato com a Citel!');
                pLimparTela;
                Result := False;
              end;
            end;
          end;

        finally
          FreeAndNil(objPedidoAlpe);
        end;
      end;

      if Result then
      begin
        objPedidoLinkPagamentoCitel := TLinkPagamentoCitelClass.Create;
        try
          objPedidoLinkPagamentoCitel.pCarregaPedidoLinkPagamentoCitel(
             fFatGor('NUMDOC').AsString,
             fFatGor('ESPDOC').AsString,
             fFatGor('CODEMP').AsString );


          if TLinkPagamentoCitelFornecedores.fEhLinkPagamentoCitel(objPedidoLinkPagamentoCitel.strTipRec) then
          begin
            if blnRealizandoAdiantamentoPedidoPeloF11 then
            begin
              pMensagemOk('O adiantamento de pedido com Link de Pagamento é realizado automaticamente. '+#13#10+
                           'Portanto, não será possível prosseguir com a operação neste momento.');
              pLimparTela;
              Result := False;
            end
            else
            begin
              if not objPedidoLinkPagamentoCitel.fVerificaEstrutura then
              begin
                pMensagemOk('O pagamento referente ao pedido, feito através do Link de Pagamento, ainda não foi identificado. '+#13#10+
                             'Por favor, aguarde a confirmação ou entre em contato caso tenha dúvidas.');
                pLimparTela;
                Result := False;
              end;
            end;
          end;

        finally
          FreeAndNil(objPedidoLinkPagamentoCitel);
        end;
      end;

      if Result then
      begin
        if TFacadeCobrancaEletronica
             .fExisteCobrancaEletronica(
                fFatGor('NUMDOC').AsString,
                fFatGor('ESPDOC').AsString,
                fFatGor('CODEMP').AsString,
                tcPagarMe) then
        begin
          if blnRealizandoAdiantamentoPedidoPeloF11 then
          begin
            pMensagemOk('Adiantamentos de pedidos Pagar.me são realizado automaticamente, portanto não será permitido prosseguir com a operação.');
            pLimparTela;
            Result := False;
          end
          else
          begin
            if not TFacadeCobrancaEletronica
                 .fExisteAdiantamentoClienteCobrancaEletronica(
                    fFatGor('NUMDOC').AsString,
                    fFatGor('ESPDOC').AsString,
                    fFatGor('CODEMP').AsString,
                    tcPagarMe) then
            begin
              pMensagemOk('Existem problemas na estrutura do pedido Pagar.me. Entre em contato com a Citel!');
              pLimparTela;
              Result := False;
            end;
          end;
        end;
      end;
    End;

    If Result Then
    Begin

      blnLiberouPromocaoVencida := False;
      If Not fVerificaPromocao Then
      Begin
        pLimparTela;
        Result := False;
      End;

    End;

    If Result Then
    Begin

      If (fatVenda.fTemProdutosComboVigenciaVencida) Then
      Begin
        pLimparTela;
        Result := False;
      End;

    End;

    If Result Then
    Begin
      If fDestacarRetencoesServicos Then
        pDestacaRetencoesServicos;
    End;

    If (Result) Then
    Begin
      pnlCentral.Enabled := True;
      pnlCabecalho.Enabled := False;
      pnlComanda.Enabled := False;
      pnlOpcaoEmiFatOuAdto.Enabled := False;
      blnMudarFoco := False;
      btnAltCnd.Enabled := False;
      btnConfRetiraCaixa.Enabled := False;
      btnFatorServico.Enabled := False;

      if fCfgSis('PONQUE', varBoolean) and (not cdsModalidades.Locate(cdsModalidadesDESMOD.AsString,'QUEST',[])) then
      begin
        blnVaiResgatarQuest := fPedidoTemQuestFidelidade(edtNumOrc.Text, strEspCfo, strDocCliQuest);
        pValidaQuestFidelidade(strDocCliQuest, blnVaiResgatarQuest);
      end;

      {***************************************************}
      {* VERIFICA SE CLIENTE POSSUI CASHBACK NA GRYNCASH *}
      {*************************************************BL}
      blnCliGry := False;
      fltCshGry := 0;
      if edtValor.Value > 0 then
        pUtilizarGrynCash(mskCgcCpf.Text, edtValor.Value);

      pSetFocus(cbxModalidades);
      pProcessMessages;

      If fCfgSisL('OBSF11', varBoolean) Then
        pMostraObsCliente(fFatGor('CODCLI').AsString);

      If (Not fClienteConsumidor(fRetNomCliente(fFatGor('CODCLI').AsString),True, True)) Then
        TFatVenda.pMensagemGarantiaEnvioCliente(fFatGor('CODCLI').AsString);

      pFormasPagamentoNegociada;

      If Result Then
      Begin
        If (fCfgSis('EXCCRC', varBoolean)) Then
        Begin
          If (Not fClienteConsumidor(fRetNomCliente(fFatGor('CODCLI').AsString),True, True)) Then
            pMostraDebitosReceber(fFatGor('CODCLI').AsString);
        End;
      End;
    End
    Else
    Begin
      if (not fVerificaTravaColetor(strNumeroDoc)) then
      begin
        fLock_Unlock( 'FATGOR' + strNumeroDoc +
                                 strEspCfo +
                                 fEmpresaDocumento, False, False );

        fLock_Unlock( 'CADREC' + strNumeroDoc +
                                  strEspCfo +
                                  fEmpresaDocumento +
                                  strClienteDoc, False, False );
      end;

      TravarRegistroDoPix(False);

      pDestravaDuplicatasCredito;

    End;

    If Result Then
      fVerificaSituacaoRegularCliente;
  End;

end;

procedure TfrmFatConfOrcamentos.pAbreFormItensSeries;
Var
  frmFatConfOrcamentos_ItensSeries: TfrmFatConfOrcamentos_ItensSeries;
begin
  pCriarFormularios(TfrmFatConfOrcamentos_ItensSeries, frmFatConfOrcamentos_ItensSeries);
  Try
    fatVenda.objFatSerieItem.pApagaSeries;

    cdsVenda.First;
    While Not cdsVenda.Eof Do
    Begin
      If fProdutoUsaNumeroDeSerie(cdsVenda.FieldByName('ITE_CODITE').AsString, cdsVenda.FieldByName('ITE_EMPITE').AsString) Then
      Begin
        frmFatConfOrcamentos_ItensSeries.cdsItens.Append;
        frmFatConfOrcamentos_ItensSeries.cdsItensAUTOINCREM.AsString := IntToStr(cdsVenda.FieldByName('AUTOINCREM').AsInteger);
        frmFatConfOrcamentos_ItensSeries.cdsItensFDO_SEQFDO.AsString := cdsVenda.FieldByName('ITE_SEQDET').AsString;
        frmFatConfOrcamentos_ItensSeries.cdsItensFDO_CODITE.AsString := cdsVenda.FieldByName('ITE_CODITE').AsString;
        frmFatConfOrcamentos_ItensSeries.cdsItensFDO_DESCRI.AsString := cdsVenda.FieldByName('ITE_DESITE').AsString;
        frmFatConfOrcamentos_ItensSeries.cdsItensFDO_QTDITE.AsFloat  := cdsVenda.FieldByName('ITE_QTDITE').AsFloat;
        frmFatConfOrcamentos_ItensSeries.cdsItensFDO_EMPITE.AsString := cdsVenda.FieldByName('ITE_EMPITE').AsString;
        frmFatConfOrcamentos_ItensSeries.cdsItensFDO_TEMNSE.AsString := cdsVenda.FieldByName('ITE_TEMNSE').AsString;
        frmFatConfOrcamentos_ItensSeries.cdsItens.Post;

        fatVenda.objFatSerieItem.AutoincItem := IIF(fEmptyStr(cdsVenda.FieldByName('ITE_SEQDET').AsString),cdsVenda.FieldByName('AUTOINCREM').AsString,cdsVenda.FieldByName('ITE_SEQDET').AsString);
        fatVenda.objFatSerieItem.pCarregaSeriesItem(cdsVenda.FieldByName('ITE_CODITE').AsString,
                                                    cdsVenda.FieldByName('ITE_EMPITE').AsString,
                                                    cdsVenda.FieldByName('ITE_SEQDET').AsString,
                                                    fatVenda.strIncOrc);
      End;

      cdsVenda.Next;
    End;

    frmFatConfOrcamentos_ItensSeries.fatVenda := fatVenda;
    If (frmFatConfOrcamentos_ItensSeries.ShowModal = mrOk) Then
    Begin
      frmFatConfOrcamentos_ItensSeries.cdsItens.First;
      While Not frmFatConfOrcamentos_ItensSeries.cdsItens.Eof Do
      Begin
        If cdsVenda.Locate('ITE_SEQDET', frmFatConfOrcamentos_ItensSeries.cdsItensFDO_SEQFDO.AsString, []) Then
        Begin
          If (cdsVenda.FieldByName('ITE_TEMNSE').AsString <> frmFatConfOrcamentos_ItensSeries.cdsItensFDO_TEMNSE.AsString) Then
          Begin
            cdsVenda.Edit;
            cdsVenda.FieldByName('ITE_TEMNSE').AsString := frmFatConfOrcamentos_ItensSeries.cdsItensFDO_TEMNSE.AsString;
            cdsVenda.Post;
          End;
        End;

        frmFatConfOrcamentos_ItensSeries.cdsItens.Next;
      End;
    End;
  Finally
    pFreeAndNil(frmFatConfOrcamentos_ItensSeries);
  End;
end;

procedure TfrmFatConfOrcamentos.FormCreate(Sender: TObject);
  Var
    intTipFre: Integer;
    strPatIni: String;
begin
  inherited;

  {Se resolução disponível for inferior ou igual à (1366 x 768), ajusta a tela!}
  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.Position := poScreenCenter;

  blnTrocoComoCredito := False;
  blnObrigarExpedirAntesDeFaturar := True;
  blnCarregouDocImportadoPedOrc := False;
  pEsvaziaArrayCfgDes;
  blnRcxF11 := True;
  blnRestaurarMatrizDeItens := False;
  blnVerificouMinimo := False;
  blnRecalculaCdsVendaForcadoLocal := False;
  blnLiberouPromocaoVencida := False;
  strSessaoTef := '';
  blnSomentePos := (VS_strUsaTef <> 'S') and (not Assigned(VS_objTef));
  objLiberacao := TLiberacao.Create;
  TLogTef.blnExcedeuTempoTEF := False;
  blnHabFormKeyDown := True;
  cdsIteCfo := Nil;
  strTipPed := '';
  blnAltLoj := fCfgSis('ALTLOJ', varBoolean);
  strEmpLog := VS_strCodEmp;
  strEspCfo := fCfgSis('ESPCFO');
  intEmpBai := fCfgSis('EMPBAI');
  blnUtiNps := fCfgSis('UTINPS', varBoolean);

  btnAgruparPedidos.Visible := fCfgSis('F11PGR', varBoolean);

  blnAdicionandoItems := False;
  blnMudouCondicaoPagamento := False;
  blnVendaConsumidorFocarApenasCPF := fCfgSis('FOCCPF', VarBoolean);

  FCondicaoPagamentoPixComCobrancaAnteriorExpirada := False;

  FPais := fSetaPais;

  strCodigoCaixa := '';

  btnLerPinPad.Visible := (fCfgSis('TEFCIT', varBoolean) and fCfgSis('TEFPIN', varBoolean)) or fAcessoDiretoPinPadCitel ;

  FPedidoEntCd := False;
  FPedidoEmpCd := '';

  cmbTipFre.Clear;
  For intTipFre In TiposFrete Do
    cmbTipFre.Properties.Items.Add(fDescricaoFrete(IntToStr(intTipFre)));

  cmbTipFre.ItemIndex := cmbTipFre.Properties.Items.IndexOf(fDescricaoFrete('1'));
  cmbTipFre.OnKeyDown := pOnKeyDownEdits;

  {*****************************************************************************************************************}
  {* Não deve ficar alterando o cliente no F11, pois isto da brecha para o operador manipular os valores           *}
  {* Por exemplo no pedido tinha um cliente de tabela de preço 2                                                   *}
  {* e no f11 ele troca para um outro cliente que nao possui permissão de utilizar esta tabela de preço            *}
  {* Este é apenas um exemplo, para permitir alterar seria necessario inserir todas as validacoes do frmFatVendas  *}
  {* dentro do f11, ou seja, estariamos criando uma nova tela de vendas e o f11 perderia a funcionalidade original *}
  {* que era apenas de agilizar a venda.                                                                           *}
  {*********************************************************************************************************JC,RO***}
  edtCodCli.ReadOnly := True;

  pSetaOpcoesFaturamento;

  SetLength(arrLogAvi, 0);

  blnFecharForm := False;
  intSemaforoConfirma  := -1;
  intSemaforoOrcamento := -1;
  intSemaforoConsulta  := -1;
  intSemaforoReceberModalidades := -1;

  stlForPag := TStringList.Create;
  stlForPag.Sorted := True;
  stlForPag.Duplicates := dupIgnore;

  stlCndPag := TStringList.Create;
  stlCndPag.Sorted := True;
  stlCndPag.Duplicates := dupIgnore;

  ecfFiscal := Nil;
  pZeraOpcaoTrocoCheque;
  blnFocoGrid := False;
  strPatIni := fCfgSis('DIRINI');
  strCodEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA'   , '', strPatIni + '/opcoes_fiscal.ini' );
  strModEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'MODELO'       , '', strPatIni + '/opcoes_fiscal.ini' );
  strPorta  := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'PORTA'        , '', strPatIni + '/opcoes_fiscal.ini' );

  pDefineEspecieDefault;

  If (Not fCfgSis('USNFCE', varBoolean)) And (Not fUsaSat) And (Not fUsaTef) And (Not fEmptyStr(strCodEcf)) And (Not VS_blnTelNov) Then
  Begin
    Try
      pCriaImpFiscalVelha;
    Except
      On E: Exception Do
      Begin
        blnFecharForm := True;
        pMensagemOk('Ocorreu um erro ao criar a Impressora Fiscal.'+#13+
                    'Verifique o arquivo opcoes_fiscal.ini em ' + strPatIni);
      End;
    End;
  End;

  qryConOrc := fCriaQuery(Nil);

  qryFatGor := fCriaQuery(Nil);
  With qryFatGor Do
  Begin
    SQL.Clear;
    SQL.Add(fSelectFromFatgorLeftAuxiliares(False));
    SQL.Add('WHERE ');
    SQL.Add('  F.FGO_NUMDOC = :NUMDOC AND ');
    SQL.Add('  F.FGO_ESPDOC = :ESPDOC AND ');
    SQL.Add('  F.FGO_CODEMP = :CODEMP ');
  End;

  qryCadCli := fCriaQuery(Nil);
  qryConCid := fCriaQuery(Nil);
  qryCadTra := fCriaQuery(Nil);
  qryCadCfo := fCriaQuery(Nil);

  qryModalidades := fCriaQuery(Nil);
  stlModalidades := TStringList.Create;
  stlItensPromoPorQtdMinQtdLim := TStringList.Create;

  FAutoIncremChavePix := TPixDao.RetornaAutoIncremChavePixDoCaixa(VS_CodigoCaixaF11);

  FPermiteUsarPix := TFuncoesPixAutcom.RealizaValidacoesUsoDoPixNoCaixa(VS_strCodigoOperadorLogadoCaixa,
                                                                        FAutoIncremChavePix);

  pCarregaFormasPagamento;

  cdsModalidades.CreateDataSet;
  cdsItensAdd := TUniClientDataSet.Create(Nil);

  cdsChequePre := fCriaCdsCheques(Nil);
  cdsChequeVis := fCriaCdsCheques(Nil);

  strCodOpe := strLoginUsuarioLogado;

  lblEntRet.Caption := '';
  If (Not fCfgSis('ENTFAT', varBoolean)) Then
  Begin
    lblEntRet.Visible := False;
  End;

  If (strEspCfo = 'OR') Then
    strTipoTitulo := 'Orçamento'
  Else
    strTipoTitulo := 'Pedido';

  lblTipDoc.Caption := strTipoTitulo + ':';

  stlDupCreditos  := TStringList.Create;
  stlLckDup       := TStringList.Create;
  fltTotCreditos  := 0.0;
  fltCredUtilizados := 0.0;

  objEndEnt := TEnderecoEntrega.Create(Nil);

  fMostraCadPagto;

  btnAltCnd.Visible := (strEspCfo = 'PD') And fCfgSis('ACPF11', VarBoolean);
  btnConfRetiraCaixa.Visible := fUsaRotinaExpedicaoConferenciaRetiraCaixa;

  objCodBar := TCodigoBarras.Create;
  //edtNumOrc.MaxLength := fTamDocCadRec;
  //edtNumOrc.TamCampo  := fTamDocCadRec;

  {Comanda}
  if (strEspCfo = 'PD') And fCfgSis('COMAND', VarBoolean) then
  begin
    pnlComanda.Visible := True;
  end
  else
  begin
    pnlComanda.Visible := False;
    Self.Height        := Self.Height - pnlComanda.Height;
  end;

  if (strEspCfo = 'PD') then
  begin
    pnlOpcaoEmiFatOuAdto.Visible := True;
  end
  else
  begin
    pnlOpcaoEmiFatOuAdto.Visible := False;
    Self.Height := Self.Height - pnlOpcaoEmiFatOuAdto.Height;
  end;

  shpRetISS.Visible := False;
  lblRetISS.Visible := False;
  blnChamouTelaTabelaPreco := False;

  blnEhCartaoQuest := False;

  strArquivoTef := '';
  strArqViaCliente := '';
  strArqViaLojista := '';
  strEmailAnt := '';
  strNumDocImportadoPedOrc := '';

  blnPermiteAlterarEmailMedianteConfiguracao := ((fCfgSis('AECF11', varBoolean)) And (fVerificaAcessoSistema('ALTEM3', strLoginUsuarioLogado)));


  cdsItensChkOut := TUniClientDataSet.Create(Nil);

  pVerificaCheckOut ;

  FcdsChkOut := fCriaCdsChkOut ;
  FcdsLogChk := fCriaCdsLogChk ;

  btnFatorServico.Visible := fCfgSis('UTIFNS', varBoolean);

  blnTravaFaturamentoF11 := False;
  blnCarregouClienteConsumidor := False;

  tmrReload.Enabled := False;
  strReloadCodCli   := '';
  cdsReloadItens    := TUniClientDataSet.Create(Nil);
end;

procedure TfrmFatConfOrcamentos.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FcdsChkOut);
  FreeAndNil(FcdsLogChk);

  If Assigned(objTecladoSEAT) Then
    FreeAndNil(objTecladoSEAT);

  pEsvaziaArrayCfgDes;

  pLimparArrCol;
end;

procedure TfrmFatConfOrcamentos.FormActivate(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(strNumDocImportadoPedOrc)) And (fEmptyStr(edtNumOrc.Text)) And (Not blnCarregouDocImportadoPedOrc) Then
  Begin
    If fCarregarPedidoOrcamento(strNumDocImportadoPedOrc) Then
      blnCarregouDocImportadoPedOrc := True;
  End;
end;

procedure TfrmFatConfOrcamentos.FormClose(Sender: TObject;
  var Action: TCloseAction);
  Var
    strCodErr: String;
begin
  pSetaEmpresaLogada(strEmpLog);

  If (Not fVerificaTef) Then
  Begin
    Action := caNone;
    Exit;
  End;

  If Not ValidarSeExistePixRecebidoSemConfirmacao(False) Then
  Begin
    Action := caNone;
    Exit;
  End;

  If fVendaAberta Then
  Begin
    Action := caNone;
    Exit;
  End;

  If Assigned(VS_objFiscal) And (fCfgConcomitante) And (qryFatGor.IsEmpty) And (Not cdsItensAdd.IsEmpty) Then
  Begin

    If fMensagem('', 'Há itens registrados no ECF. Caso sair desta tela o cupom será cancelado. ' +
      'Deseja sair?', ['&Sim', '&Não'], 2) = 1 Then
    Begin

      If VS_objFiscal.EstadoECF = ecfCupomAberto Then
      Begin
        VS_objFiscal.fCancelaCupom;
      End;
    End
    Else
    Begin
      Action := caNone;
      Exit;
    End;
  End;

  pEsvaziaArrayCfgDes;

  if (not fVerificaTravaColetor(edtNumOrc.Text)) then
  begin
    fLock_Unlock( 'FATGOR' + edtNumOrc.Text +
                             strEspCfo +
                             fEmpresaDocumento, False, False );

    fLock_Unlock( 'CADREC' + edtNumOrc.Text +
                             strEspCfo +
                             fEmpresaDocumento +
                             edtCodCli.Text, False, False );
  end;

  pLimparArrCol;

  TravarRegistroDoPix(False);

  pDestravaDuplicatasCredito;

  if not cdsItensChkOut.IsEmpty then
    pDesfazCheckoutTemp(cdsItensChkOut, False);

  If Assigned(ecfFiscal) Then
  Begin
    ecfFiscal.fFinalizaEcf(strCodErr);
    ecfFiscal.Free;
  End;

  If Assigned(VS_objFiscal) Then
    VS_objFiscal.blnApenasItensCheckOutF11 := False;

  pClearFunctionsEventosCadPro;

  FreeAndNil(stlItensPromoPorQtdMinQtdLim);
  FreeAndNil(stlModalidades);
  FreeAndNil(stlForPag);
  FreeAndNil(stlCndPag);
  FreeAndNil(stlDupCreditos);
  FreeAndNil(stlLckDup);
  FreeAndNil(objEndEnt);

  FreeAndNil(qryFatGor);

  If (cdsVenda <> nil) Then
  Begin
    Try
      If cdsVenda.Active Then
        cdsVenda.Close;
      pFreeCdsVenda;
    Except

    End;
  End;

  If Assigned(fatVenda) Then
    FreeAndNil(fatVenda);

  If Assigned(qryCadCli) Then
    FreeAndNil(qryCadCli);

  If Assigned(qryConCid) Then
    FreeAndNil(qryConCid);

  If Assigned(qryCadCfo) Then
    FreeAndNil(qryCadCfo);

  If Assigned(qryCadTra) Then
    FreeAndNil(qryCadTra);

  If Assigned(qryModalidades) Then
    FreeAndNil(qryModalidades);

  If Assigned(cdsIteCfo) Then
    FreeAndNil(cdsIteCfo);

  If Assigned(qryConOrc) Then
    FreeAndNil(qryConOrc);

  If Assigned(cdsItensAdd) Then
    FreeAndNil(cdsItensAdd);

  If Assigned(objCodBar) Then
    FreeAndNil(objCodBar);

  If Assigned(cdsChequePre) Then
    FreeAndNil(cdsChequePre);

  If Assigned(cdsChequeVis) Then
    FreeAndNil(cdsChequeVis);

  If Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  if Assigned(cdsItensChkOut) then
    FreeAndNil(cdsItensChkOut);

  If Assigned(edtCodEmpInf) Then
    FreeAndNil(edtCodEmpInf);

  If Assigned(cdsReloadItens) Then
    FreeAndNil(cdsReloadItens);

  inherited;
end;

procedure TfrmFatConfOrcamentos.pCarregaOrcamento;
  Var
    strMsg   : String;
    fltIssDes: Double;
begin

  If (cdsItensAdd.Active) And (Not cdsItensAdd.IsEmpty) Then
    cdsItensAdd.EmptyDataSet;

  qryFatGor.Close;
  qryFatGor.ParamByName('NUMDOC').AsString := edtNumOrc.Text;
  qryFatGor.ParamByName('ESPDOC').AsString := strEspCfo;
  qryFatGor.ParamByName('CODEMP').AsString := fEmpresaDocumento;
  qryFatGor.Open;

  fltValAnt := TFatVenda.fTotalDuplicataQuitada(edtNumOrc.Text, strEspCfo, fRetornaCodigoDaEmpresa, qryFatGor.FieldByName('FGO_CODCLI').AsString);
  fltValAdt := TAdiantamento.fGetTotaisAdiantamento(edtNumOrc.Text, strEspCfo, fRetornaCodigoDaEmpresa).fltValLan;

  blnAdiantamentoAutomatico := TAdiantamento.fAdiantamentoGravadoAutomaticamente(fFatGor('NUMDOC').AsString,
                                                                                 fFatGor('ESPDOC').AsString,
                                                                                 fFatGor('CODEMP').AsString,
                                                                                 fFatGor('CODCLI').AsString);

  fltIssDes := 0;
  If fClienteRetemISS(fFatGor('CODCLI').AsString) Then
    fltIssDes := fFatGor('VALISS').AsFloat;

  If (fltValAnt + fltValAdt > 0) Then
  Begin
    lblValAnt.Visible := True;
    lblValAnt.Caption := 'Pgto. Antecipado R$ ' + FormatFloat('#,##0.00', fltValAnt + fltValAdt);
  End
  Else
    lblValAnt.Visible := False;

  If blnAdiantamentoAutomatico And (fltValAdt > 0) And (fltValAdt < fFatGor('VLRCON').AsFloat) Then
    fltValAdt := 0;

  edtTotGer.Text := FloatToStrF(fFatGor('VLRCON').AsFloat - fltValAnt - fltValAdt - fltIssDes - fFatGor('TOTBRI').AsFloat, ffFixed, 12, 2);
  edtValor.Value := fFatGor('VLRCON').AsFloat - fltValAnt  - fltValAdt - fltIssDes - fFatGor('TOTBRI').AsFloat;
  edtCodCli.Text := fFatGor('CODCLI').AsString;
  edtCodFpg.Text := fFatGor('CODFPG').AsString + ' - ' +
                    fRetDescFpg(fFatGor('CODFPG').AsString);

  Self.strFpgOrc := fFatGor('CODFPG').AsString;
  Self.strConPag := fFatGor('CONPAG').AsString;

  edtNumParcelas.Text := fFatGor('QTDPAC').AsString;

  edtVolume.Text := fFatGor('VOLUME').AsString;
  edtEspVol.Text := fFatGor('ESPECI').AsString;

  btnNumSeries.Visible := False;
  If fCfgSis('NSERQT', varBoolean) Then
    btnNumSeries.Visible := Not qryFatGor.IsEmpty And
                            fPedidoUsaNumeroDeSerie(qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                                    qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                                    qryFatGor.FieldByName('FGO_CODEMP').AsString);

  If (fFatGor('ESPDOC').AsString = 'PD') Then
  Begin
    If TFatVenda.fPedidoAPrazoComEntradaQuitada(fFatGor('NUMDOC').AsString,
                                                fFatGor('ESPDOC').AsString,
                                                fFatGor('CODEMP').AsString,
                                                Self.strConPag) Then
    Begin
      TFatVenda.pAlteraCondicaoPagamentoRemovendoEntrada(Self.strConPag);
    End;
  End;

  If (edtCodPag.Visible) then
  Begin
    edtCodPag.Text := fFatGor('CODCND').AsString;
    mskCndPag.Text := fFormataCondPag(Self.strConPag);
    edtDesPag.Text := fRetDesConPag(fFatGor('CODCND').AsString);
  End;

  If Not fEmptyStr(strFpgOrc) And (fRetornaStatusCadastro(strFpgOrc, 'FPG', 'CADFPG', 'FPG_CODIGO') <> 'A') Then
  Begin
    fMensagem('ATENÇÃO!', 'A forma de pagamento ' + strFpgOrc + '-(' + fFormataCondPag(strConPag) +
                          ') não pode ser utilizada pois está inativa! Favor verificar.', ['&O k']);
  End;

  strAutInc := fFatGor('AUTOINCREM').AsString;

  objEndEnt.pRetEnderecoEntregaOrcamento(fFatGor('AUTOINCREM').AsString,
                                         fFatGor('CODCLI').AsString);

  pCarregaCliente(True);

  If Not fEmptyStr(fFatGor('CODTRA').AsString) Then
  Begin
    edtCodTra.Text := fFatGor('CODTRA').AsString;
    cmbTipFre.ItemIndex := cmbTipFre.Properties.Items.IndexOf(fDescricaoFrete(fFatGor('TIPFRE').AsString));

    If (Not fFreteValido(fTipoFrete(cmbTipFre.Text))) Then
      cmbTipFre.ItemIndex := cmbTipFre.Properties.Items.IndexOf(fDescricaoFrete(fCfgSis('TIPFRE')));
  End
  Else
  Begin
    If (fFatGor('TOTFRE').AsFloat > 0) Then
      cmbTipFre.ItemIndex := cmbTipFre.Properties.Items.IndexOf(fDescricaoFrete(fFatGor('TIPFRE').AsString))
    Else
      cmbTipFre.ItemIndex := cmbTipFre.Properties.Items.IndexOf(fDescricaoFrete('9'));

    edtCodTra.Text := fCfgSis('TRASUG', varString, fEmpresaDocumento);
  End;

  pCarregaTransportadora;

  lblEntRet.Caption := fRetornaDescricaoEntRetDocumento(fFatGor('NUMDOC').AsString,
                                                        fFatGor('ESPDOC').AsString,
                                                        fFatGor('CODEMP').AsString);
  blnPrimeiraVendaTEF := True;

  pCarregaMensagemPedido;

  {**************************************}
  {* EXIBE AS OBSERVAÇÕES DO ORÇAMENTO  *}
  {***********************************LU*}
  If (Not fEmptyStr(fFatGor('MEN001').AsString)) Or
     (Not fEmptyStr(fFatGor('MEN002').AsString)) Or
     (Not fEmptyStr(fAuxGor('MEN003').AsString)) Or
     (Not fEmptyStr(fAuxGor('MEN004').AsString)) Or
     (Not fEmptyStr(fAuxGor('MEN005').AsString)) Then
  Begin
    Try
      if (fFatGor('ORIGEM').AsString = 'AGRUPAMENTO') then
      begin
        pCriarFormularios(TfrmFatMensagemNotaF11, frmFatMensagemNotaF11);
        try
          frmFatMensagemNotaF11.edtMens01.MaxLength := fFatGor('MEN001').Size;
          frmFatMensagemNotaF11.edtMens02.MaxLength := fFatGor('MEN002').Size;
          frmFatMensagemNotaF11.edtMens03.MaxLength := fAuxGor('MEN003').Size;
          frmFatMensagemNotaF11.edtMens04.MaxLength := fAuxGor('MEN004').Size;
          frmFatMensagemNotaF11.edtMens05.MaxLength := fAuxGor('MEN005').Size;
          frmFatMensagemNotaF11.edtMens01.Text := arrMsgNot[1];
          frmFatMensagemNotaF11.edtMens02.Text := arrMsgNot[2];
          frmFatMensagemNotaF11.edtMens03.Text := arrMsgNot[3];
          frmFatMensagemNotaF11.edtMens04.Text := arrMsgNot[4];
          frmFatMensagemNotaF11.edtMens05.Text := arrMsgNot[5];
          frmFatMensagemNotaF11.Caption := 'Observação';

          frmFatMensagemNotaF11.ShowModal;
          if (frmFatMensagemNotaF11.blnConfirma) then
          begin
            arrMsgNot[1] := frmFatMensagemNotaF11.edtMens01.Text;
            arrMsgNot[2] := frmFatMensagemNotaF11.edtMens02.Text;
            arrMsgNot[3] := frmFatMensagemNotaF11.edtMens03.Text;
            arrMsgNot[4] := frmFatMensagemNotaF11.edtMens04.Text;
            arrMsgNot[5] := frmFatMensagemNotaF11.edtMens05.Text;
          end;
        finally
          pFreeAndNil(frmFatMensagemNotaF11);
        end;
      end
      else
      begin
        strMsg := '';
        strMsg := strMsg +
                  fFatGor('MEN001').AsString + #13#10 +
                  fFatGor('MEN002').AsString + #13#10 +
                  fAuxGor('MEN003').AsString + #13#10 +
                  fAuxGor('MEN004').AsString + #13#10 +
                  fAuxGor('MEN005').AsString + #13#10;

        pCriarFormularios(TfrmObservacao, frmObservacao);
        try
          frmObservacao.lblMensagem.caption := '';
          frmObservacao.memObs.Texto := strMsg;
          frmObservacao.ShowModal;
        finally
          pFreeAndNil(frmObservacao);
        end;
      end;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[frmFatConfOrcamentos.pCarregaOrcamento]');
    End;
  End;

  strCodCarPed := fFatGor('CODCAR').AsString;
  intQtdParPed := fFatGor('QTDPAC').AsInteger;
  strTipOpe    := fFatGor('TIPOPE').AsString;
  strEmailAnt  := edtEmail.Text;


  //Se TIPPOPE = (A) Amostra só permite Nota Fiscal.
  if (strTipOpe = 'A') then
  begin
    pSetaOpcoesFaturamento;
    pDefineEspecieDefault;
  end;

end;

procedure TfrmFatConfOrcamentos.pHabitilaEndereco(blnCliCon: Boolean);
  Var
    blnEditarEndereco: Boolean;
Begin
  //Se nao for consumidor entao nao permite editar endereco
  If Not blnCliCon Then
    blnEditarEndereco := False
  //Se for consumidor a configuracao CFG_ECLF11 determina se permite editar o endereco
  Else
    blnEditarEndereco := fCfgSis('ECLF11', varBoolean);

  edtEndEnt.ReadOnly := (Not blnEditarEndereco);
  edtBaiEnt.ReadOnly := (Not blnEditarEndereco);
  mskCepEnt.ReadOnly := (Not blnEditarEndereco);
  edtCidEnt.ReadOnly := (Not blnEditarEndereco);

  edtEndEnt.TabStop  := blnEditarEndereco;
  edtBaiEnt.TabStop  := blnEditarEndereco;
  mskCepEnt.TabStop  := blnEditarEndereco;
  edtCidEnt.TabStop  := blnEditarEndereco;

  btnEndEnt.Visible  := Not blnCliCon;
End;

function TfrmFatConfOrcamentos.fPedidoTemFazendaInformada: Boolean;
begin
  Result := False;

  If fCfgSis('CADFAZ', VarBoolean) Then
  Begin
    Result := qryFatGor.Active And
              Not qryFatGor.IsEmpty And
              Not fEmptyStr(fFatGor('CODFAZ').AsString);
  End;
end;

function TfrmFatConfOrcamentos.fPedidoTemQuestFidelidade(strNumDoc, strEspDoc: string; var strDocCli: string): Boolean;
var
  qryPedidoQuest: TUniQuery;
begin
  try
    Result    := False;
    strDocCli := '';

    qryPedidoQuest := fCriaQuery();

    if (strEspDoc = 'PD') then
    begin
      qryPedidoQuest.Close;
      qryPedidoQuest.SQL.Clear;
      qryPedidoQuest.SQL.Add('SELECT E.FGO_DOCQUE');
      qryPedidoQuest.SQL.Add('FROM EXTGOR E');
      qryPedidoQuest.SQL.Add('INNER JOIN FATGOR F');
      qryPedidoQuest.SQL.Add('ON(E.FGO_SEQFGO = F.AUTOINCREM)');
      qryPedidoQuest.SQL.Add('WHERE F.FGO_NUMDOC = :NUMDOC');
      qryPedidoQuest.SQL.Add('AND F.FGO_ESPDOC = "PD"');
      qryPedidoQuest.SQL.Add('AND F.FGO_CODEMP = :CODEMP');
      qryPedidoQuest.SQL.Add('AND E.FGO_USAQUE = "S" ');

      qryPedidoQuest.ParamByName('NUMDOC').AsString := strNumDoc;
      qryPedidoQuest.ParamByName('CODEMP').AsString := fRetornaCodigoDaEmpresa;

      qryPedidoQuest.Open;

      if not qryPedidoQuest.IsEmpty then
      begin
        strDocCli := qryPedidoQuest.FieldByName('FGO_DOCQUE').AsString;
        Result := True;
      end;
    end;
  finally
    FreeAndNil(qryPedidoQuest);
  end;
end;

procedure TfrmFatConfOrcamentos.pCarregaCliente(blnVerEnd: Boolean = False; strParCli: String = '');
  Var
    idxUtiCre: Integer;
    blnEditarCliente: Boolean;
    blnEditarTranspor: Boolean;
    blnEditarEmail: Boolean;
begin
  If fEmptyStr(strParCli) Then
    strParCli := edtCodCli.Text;

  If (fEmptyStr(edtCodCli.Text)) Then
    edtCodCli.Text := strParCli;

  If (Not fEmptyStr(edtEmail.Text)) Then
    strEmlCon := AnsiLowerCase(edtEmail.Text);

  qryCadCli.SQL.Clear;
  qryCadCli.SQL.Add('SELECT * FROM CADCLI WHERE CLI_CODCLI = :CODCLI');
  qryCadCli.ParamByName('CODCLI').AsString := strParCli;
  qryCadCli.Open;

  blnCliCon := fClienteConsumidor(qryCadCli.FieldByName('CLI_NOMCLI').AsString, False, True);
  blnCliBal := fClienteConsumidor(qryCadCli.FieldByName('CLI_NOMCLI').AsString, True, False);
  blnCliFil := fClienteFilial(qryCadCli.FieldByName('CLI_CODCLI').AsString);

  pHabitilaEndereco(blnCliCon);

  If Not blnCarregouClienteConsumidor Then
  Begin
    If ((Not blnCliCon) Or (qryFatGor.IsEmpty)) And (Not fPedidoTemFazendaInformada) Then
    Begin
      edtNomCli.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString;
      If fEmptyStr(objEndEnt.recEndere.strEndEnt) Or
         ((Trim(qryCadCli.FieldByName('CLI_CODCLI').AsString) <> Trim(strCodCliAnt)) And blnAdicionandoItems) Then
      Begin
        edtEndEnt.Text := qryCadCli.FieldByName('CLI_ENDERE').AsString + IIF(fEmptyStr(qryCadCli.FieldByName('CLI_ENDNUM').AsString),'',', ' + qryCadCli.FieldByName('CLI_ENDNUM').AsString);
        edtEndEnt.Text := Concat(edtEndEnt.Text, IIF(fEmptyStr(qryCadCli.FieldByName('CLI_ENDCOM').AsString), '', '  ' + qryCadCli.FieldByName('CLI_ENDCOM').AsString));
        edtBaiEnt.Text := qryCadCli.FieldByName('CLI_BAIRRO').AsString;
        mskCepEnt.Text := qryCadCli.FieldByName('CLI_C_E_P_').AsString;
        edtCidEnt.Text := qryCadCli.FieldByName('CLI_CODCID').AsString;
        strFone01      := qryCadCli.FieldByName('CLI_FONE01').AsString;
      End
      Else
      Begin
        edtEndEnt.Text := objEndEnt.recEndere.strEndEnt;
        edtBaiEnt.Text := objEndEnt.recEndere.strBaiEnt;
        mskCepEnt.Text := objEndEnt.recEndere.strCepEnt;
        edtCidEnt.Text := objEndEnt.recEndere.strCidEnt;
        strFone01      := objEndEnt.recEndere.strTelEnt;
      End;

      strCelular     := qryCadCli.FieldByName('CLI_CELULA').AsString;
      strCliIes := qryCadCli.FieldByName('CLI_I_E_S_').AsString;
      strEmlCon := qryCadCli.FieldByName('CLI_EMAIL3').AsString;

      If SameText(qryCadCli.FieldByName('CLI_CGCCPF').AsString, '1') Then
      Begin
        mskCgcCpf.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_);
        lblRG_IES.Caption  := 'IES:';

        mskNumR_G.Text := qryCadCli.FieldByName('CLI_I_E_S_').AsString;
      End
      Else
      Begin
        mskCgcCpf.EditMask := fRetMascaraC_G_C_(fSetaPais, C_P_F_);
        lblRG_IES.Caption  := 'RG:';

        mskNumR_G.Text := qryCadCli.FieldByName('CLI_NUMR_G').AsString;
      End;

      If (fEmptyStr(mskCgcCpf.Text)) Or (fCfgSis('PTCCKO', varBoolean)) Then
      Begin
        edtCgcCpf.Text := qryCadCli.FieldByName('CLI_CGCCPF').AsString;
        mskCgcCpf.Text := qryCadCli.FieldByName('CLI_C_G_C_').AsString;
        strCgcCpfAnt   := qryCadCli.FieldByName('CLI_C_G_C_').AsString;
        pSetaVisibilidadeNetpoints;
        pSetaVisibilidadeNotaPaulista;
      End;

      If (qryFatGor.IsEmpty) And Assigned(fatVenda) Then
      Begin
        fatVenda.strStReEs := qryCadCli.FieldByName('CLI_STREES').AsString;
        fatVenda.strPrStRe := qryCadCli.FieldByName('CLI_PRSTRE').AsString;
      End;

    End
    Else
    Begin

      If SameText(fFatGor('CGCCPF').AsString, '1') Then
      Begin
        mskCgcCpf.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_);
        lblRG_IES.Caption  := 'IES:';

        mskNumR_G.Text := fFatGor('IESCON').AsString;
      End
      Else
      Begin
        mskCgcCpf.EditMask := fRetMascaraC_G_C_(fSetaPais, C_P_F_);
        lblRG_IES.Caption  := 'RG:';

        mskNumR_G.Text := fFatGor('R_GCON').AsString;
      End;

      edtNomCli.Text := fFatGor('NOMCON').AsString;
      edtEndEnt.Text := fFatGor('ENDCON').AsString;
      edtBaiEnt.Text := fFatGor('BAICON').AsString;
      mskCepEnt.Text := fFatGor('CEPCON').AsString;
      edtCidEnt.Text := fFatGor('CIDCON').AsString;
      edtCgcCpf.Text := fFatGor('CGCCPF').AsString;
      mskCgcCpf.Text := fFatGor('CGCCON').AsString;
      strCgcCpfAnt   := fFatGor('CGCCON').AsString;
      strFone01      := fFatGor('TELCON').AsString;
      strCelular     := fFatGor('CELCON').AsString;
      strCliIes      := fFatGor('IESCON').AsString;
      strEmlCon      := fFatGor('EMLCON').AsString;

      pSetaVisibilidadeNetpoints;
      pSetaVisibilidadeNotaPaulista;
    End;
  End;

  If (qryFatGor.IsEmpty) And Assigned(fatVenda) Then
  Begin
    fatVenda.strDesoST := qryCadCli.FieldByName('CLI_DESOST').AsString;
    fatVenda.strDesoMT := qryCadCli.FieldByName('CLI_DESOMT').AsString;
  End;

  If Assigned(fatVenda) Then
  Begin
    fatVenda.strNatSer := qryCadCli.FieldByName('CLI_NATSER').AsString;
  End;

  edtEmail.Text := AnsiLowerCase(strEmlCon);

  //Se nao for consumidor entao nao permite editar o cliente
  If Not blnCliCon Then
    blnEditarCliente := False
  //Se for consumidor a configuracao CFG_ECLF11 determina se permite editar o cliente
  Else
    blnEditarCliente := fCfgSis('ECLF11', varBoolean);

  blnEditarTranspor := blnEditarCliente Or fCfgSis('ETRF11', varBoolean);
  blnEditarEmail := (blnEditarCliente) Or ((blnPermiteAlterarEmailMedianteConfiguracao) And (fTipoFaturamentoSelec.strEspDoc = 'NF'));

  If blnRealizandoAdiantamentoPedidoPeloF11 Then
  Begin
    blnEditarTranspor := False;
    blnEditarEmail := False;
  End;

  edtNomCli.ReadOnly := Not blnEditarCliente;
  edtCgcCpf.ReadOnly := Not blnEditarCliente;
  mskCgcCpf.ReadOnly := Not blnEditarCliente;
  mskNumR_G.ReadOnly := Not blnEditarCliente;
  edtEmail.ReadOnly  := Not blnEditarEmail;
  edtCodTra.ReadOnly := Not blnEditarTranspor;
  cmbTipFre.Properties.ReadOnly := Not blnEditarTranspor;

  edtNomCli.TabStop := blnEditarCliente;
  edtCgcCpf.TabStop := blnEditarCliente;
  mskCgcCpf.TabStop := blnEditarCliente;
  mskNumR_G.TabStop := blnEditarCliente;
  edtEmail.TabStop  := blnEditarEmail;
  edtCodTra.TabStop := blnEditarTranspor;
  cmbTipFre.TabStop := blnEditarTranspor;

  strEstCliAnt := fRetNomCidade(edtCidEnt.Text,1);

  strCodCliAnt := qryCadCli.FieldByName('CLI_CODCLI').AsString;

  pCarregaCadCid;

  stlForPag.Clear;
  stlCndPag.Clear;
  pCarregaFormasPagto(strParCli, stlForPag, stlCndPag);
  pCarregaFormasPagamento;

  If (fGetTotalCreditosCliente(strParCli) > 0) And fVerificaAcessoSistema('PEREXICRED', strCodOpe) And (fMostraCreditoComPortador(strParCli)) Then
  Begin
    lblCreditos.Visible := True;
  End;

  If (Not fMostraCreditoComPortador(strParCli)) Then
  Begin
    idxUtiCre := stlModalidades.IndexOf('013');

    If (idxUtiCre <> -1) Then
    Begin
      cbxModalidades.Items.Delete(idxUtiCre);
      stlModalidades.Delete(idxUtiCre);
    End;
  End;

  If blnVerEnd And (Not fPedidoTemFazendaInformada) And
     (qryFatGor.IsEmpty Or (fFatGor('ENTFAT').AsString <> 'N')) Then
  Begin
    objEndEnt.fSelecionaEnderecoEntrega(strParCli);
  End;

  If (Not fEmptyStr(objEndEnt.recEndere.strIncrem)) And (Not blnCliCon)  Then
    pEnderecoToTela(objEndEnt);

  If Not qryFatGor.IsEmpty Then
    strTabPrecoFat := fFatGor('TABPRE').AsString
  Else
  Begin
    strTabPrecoFat := fCfgSisL('TBPSUG');

    If strTabPrecoFat = '0' Then
    Begin
      strTabPrecoFat := qryCadCli.FieldByName('CLI_TABPRE').AsString;

      If fEmptyStr(strTabPrecoFat) And fCfgSis('HIETAB', VarBoolean) Then
        strTabPrecoFat := fCampoTabela('OPE_TABPRE', 'CADOPE', ['OPE_CODOPE'], [strDigCodVen], False);

      If fEmptyStr(strTabPrecoFat) Then
      Begin
        If (fEmptyStr(fCfgSis('TBPRPD', varString))) Then
          strTabPrecoFat := '1'
        Else
          strTabPrecoFat := fCfgSis('TBPRPD', varString);
      End;
    End;
  End;

  strNumCepOld := mskCepEnt.Text;
  strCodCidOld := edtCidEnt.Text;
  strEndereOld := edtEndEnt.Text;
  strBairroOld := edtBaiEnt.Text;
  strNomCidOld := edtNomCid.Text;

 If (fCfgSis('INLGPD', varBoolean)) and (Not fClienteConsumidor(fRetNomCliente(edtCodCli.Text))) then
  begin
    if (fCampoTabela('CLI_LEILGP', 'CADCLI', ['CLI_CODCLI'], [edtCodCli.Text])= 'N') then
      fMensagem('ATENÇÃO!', 'Este Cliente ' + edtCodCli.Text + ' - ' +fRetNomCliente(edtCodCli.Text) + ' não está incluído na Lei LGPD. ' + sLineBreak +
                            'Este é um aviso para atualizar os dados cadastrais e incluí-lo na Lei LGPD. ', ['&O k']);
  end;

end;

procedure TfrmFatConfOrcamentos.pEnderecoToTela(objEndEnt: TEnderecoEntrega);
Begin
  With objEndEnt.recEndere Do
  Begin
    edtEndEnt.Text := strEndEnt;
    edtBaiEnt.Text := strBaiEnt;
    mskCepEnt.Text := strCepEnt;
    edtCidEnt.Text := strCidEnt;
    edtNomCid.Text := fRetNomCidade(strCidEnt);
    edtUF.Text     := strEstEnt;    
    strFone01      := strTelEnt;
  End;
End;

procedure TfrmFatConfOrcamentos.pEscapePressed;
begin

  If (ActiveControl.Parent = pnlCentral) Then
  Begin
    fCancelaModalidades;
  End
  Else If (ActiveControl.Parent = pnlRodape) Or
          ((ActiveControl) Is TBitBtnLocked) Or
          ((ActiveControl) Is TBitBtnLocked) Then
  Begin
    pnlCentral.Enabled := True;
    pSetFocus(cbxModalidades);
    pnlRodape.Enabled  := False;
    btnAdicionarItens.Enabled := True;
    pFormasPagamentoNegociada;
  End
  Else
    inherited;

end;

procedure TfrmFatConfOrcamentos.pDefinirNumeroSerieCooLogTef;
begin
  TLogTef.strNumSer := '';
  TLogTef.intNumCoo := 0;

  if Assigned(VS_objFiscal) then
  begin
    TLogTef.strNumSer := VS_objFiscal.fNumeroSerie;
    TLogTef.intNumCoo := StrToIntDef(VS_objFiscal.fRetornaCOO, 0);
  end;
end;

function TfrmFatConfOrcamentos.fRealizaFaturamentoNotaConcretoF11(blnValidaAcessoSistema: Boolean = True): Boolean;
begin
  Result := False;

  if not fCfgSis('CCRF11', varBoolean) then
    Exit;

  if fCfgSis('TPNFCR') <> CONCREMASSA then
    Exit;

  if blnValidaAcessoSistema then
  begin
    if not fVerificaAcessoSistema('UVCF11') Then
    begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Faturamento de item concreto');

      objLiberacao.strDirAce := 'UVCF11';
      objLiberacao.strMsgSen := 'Faturamento de item concreto';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;

      If (Not objLiberacao.fLibera) Then
      Begin
        Exit;
      End;
    end;
  end;

  Result := True;
end;

function TfrmFatConfOrcamentos.fRealizarGravacao: Boolean;
  var
    frmGravandoVenda: TfrmGravando;
begin
  pProcessMessages(True);
  Try
    fatVenda.strSessaoTef := strSessaoTef;
    fatVenda.intCgcCpf := StrToIntDef(edtCgcCpf.Text, 0);
    fatVenda.strCliEma := edtEmail.Text;

    try
      pCriarFormularios(TfrmGravando, frmGravandoVenda);
      try
        frmGravandoVenda.strChave := 'FATVENDAS';
        fatVenda.strEmpLog := strEmpLog;

        If blnRealizandoAdiantamentoPedidoPeloF11 Then
        Begin
          frmGravandoVenda.fExecutarAcao := fatVenda.fGravarAdiantamentoPedidoPeloF11;
          fatVenda.blnResCaiAdt := True;
        End
        else
        If fEhFaturamentoDeConcreto Then
        Begin
          fatVenda.fCarregaEstrutura     := fCarregaEstrutura;
          frmGravandoVenda.fExecutarAcao := fatVenda.fGravaNotaDeConcreto;
        End
        Else
        Begin
          frmGravandoVenda.fExecutarAcao := fatVenda.fGravaArquivosDesmembrandoVenda;
        End;

        frmGravandoVenda.ShowModal;
        Result := frmGravandoVenda.blnConfirma;
      finally
        pFreeAndNil(frmGravandoVenda);
      end;
    except
      on E: Exception do
      begin
        Result := False;
        pMensagensErro(E.Message, '[fFecharVenda - frmGravandoVenda]');
      end;
    end;

  except
    on E: EAbort do
    begin
      Result := False;
      fRollBack;
      fMensagem('ATENÇÃO!', 'Houve um problema na gravação. Pressione [ENTER] para continuar.', ['&Ok']);
    end;

    on E: Exception do
    begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[fFecharVenda]');
      fMensagem('ATENÇÃO!', 'Houve um problema na gravação. Pressione [ENTER] para continuar.', ['&Ok']);
    end;
  end;

end;

procedure TfrmFatConfOrcamentos.pLimparVariaveisUsadasNaVenda;
begin
  cdsChequePre.EmptyDataSet;
  cdsChequeVis.EmptyDataSet;
  SetLength(arrCartoes, 0);
  SetLength(arrCartFin, 0);

  stlDupCreditos.Clear;
  fltTotCreditos := 0.0;
  fltCredUtilizados := 0;
  pApagaLogVarNaoUtilizado(fatVenda.stlNumLib, arrLogLib);
  SetLength(arrLogLib, 0);
  SetLength(arrLogAvi, 0);
end;

procedure TfrmFatConfOrcamentos.pDesabilitaCamposAntesFechamento;
begin
  edtCodCli.Enabled := False;
  edtNomCli.Enabled := False;
  edtCgcCpf.Enabled := False;
  mskCgcCpf.Enabled := False;
  mskNumR_G.Enabled := False;
  edtEndEnt.Enabled := False;
  edtEmail.Enabled := False;
  edtBaiEnt.Enabled := False;
  mskCepEnt.Enabled := False;
  edtCidEnt.Enabled := False;
  edtCodTra.Enabled := False;
  mskPlaFat.Enabled := False;
  cmbTipFre.Enabled := False;
  edtVolume.Enabled := False;
  edtEspVol.Enabled := False;
  fltDesEspRest := 0;
end;

function TfrmFatConfOrcamentos.fCancelaModalidades: Boolean;
begin
  Result := False;

  edtValor.Value := 0;

  If fVendaAberta Then
    Exit;

  If Not ValidarSeExistePixRecebidoSemConfirmacao(False) Then
    Exit;

  If (fMensagem('', 'Deseja cancelar essa operação?', ['&Sim', '&Não']) = 2) Then
    Exit;

  If Assigned(objTecladoSEAT) And TTecladoSEAT.fUtilizaIntegracaoComTecladoDeSatisfacaoSEAT(oaCaixa) Then
  Begin
    If objTecladoSEAT.fEmOperacao Then
      objTecladoSEAT.pDesligarMonitoramento(True);
  End;

  If Not fVerificaTef Then
    Exit;

  If Assigned(VS_objFiscal) And (fCfgConcomitante) And (qryFatGor.IsEmpty) And (Not cdsItensAdd.IsEmpty) Then
  Begin
    If VS_objFiscal.EstadoECF = ecfCupomAberto Then
    Begin
      VS_objFiscal.fCancelaCupom;
    End;
  End;

  if (not fVerificaTravaColetor(edtNumOrc.Text)) then
  begin
    fLock_Unlock( 'FATGOR' + edtNumOrc.Text +
                             strEspCfo +
                             fEmpresaDocumento, False, False );

    fLock_Unlock( 'CADREC' + edtNumOrc.Text +
                             strEspCfo +
                             fEmpresaDocumento +
                             edtCodCli.Text, False, False );
  end;

  TravarRegistroDoPix(False);

  pDestravaDuplicatasCredito;

  if not cdsItensChkOut.IsEmpty then
    pDesfazCheckoutTemp(cdsItensChkOut, False);

  pnlComanda.Enabled := True;
  pnlOpcaoEmiFatOuAdto.Enabled := True;
  pnlCabecalho.Enabled := True;
  pnlCentral.Enabled := False;

  if (strEspCfo = 'PD') And fCfgSis('COMAND', VarBoolean) then
    pSetFocus(edtBarCom)
  else
    pSetFocus(edtNumOrc);

  pLimparTela;
  pTrataWMS;

  Result := True;
end;

function TfrmFatConfOrcamentos.fRetornaQtdNeg: Integer ;
var
  LintQtdNeg: Integer ;
begin
  LintQtdNeg := StrToIntDef(LeftStr(Self.strConPag,2), 0);

  If fEhRecebimentoFormasPagtoNegociadas Or fCfgSis('SOLCAR', varBoolean) Then
  Begin
    LintQtdNeg := intQtdParPed;
  End;
  Result := LintQtdNeg ;
end ;

function TfrmFatConfOrcamentos.fRetornaCodFin: String ;
begin
  Result := '' ;
end ;

function TfrmFatConfOrcamentos.fIsF11: Boolean ;
begin
  Result := True ;
end ;

function TfrmFatConfOrcamentos.fPedidoCarregado: Boolean;
begin
  Result := (qryFatGor.Active) And (Not qryFatGor.IsEmpty);
end;

function TfrmFatConfOrcamentos.fPedidoComOrdemProducao: Boolean;
var
  qryOrdemProducao: TUniQuery;
begin
  Result := False;

  if not Assigned(fatVenda) then
    Exit;

  if fatVenda.strEspDoc <> 'PD' then
    Exit;

  if fatVenda.strEspOrigem <> 'PD' then
    Exit;

  qryOrdemProducao := fCriaQuery;

  try
    qryOrdemProducao.Close;
    qryOrdemProducao.SQL.Clear;
    qryOrdemProducao.SQL.Add('SELECT AUTOINCREM');
    qryOrdemProducao.SQL.Add('FROM MOVPRO');
    qryOrdemProducao.SQL.Add('WHERE PRO_NUMPED = :NUMPED');
    qryOrdemProducao.SQL.Add('AND PRO_ESPPED = :ESPPED');
    qryOrdemProducao.SQL.Add('AND PRO_EMPPED = :EMPPED');
    qryOrdemProducao.ParamByName('NUMPED').AsString := fatVenda.strNumOrigem;
    qryOrdemProducao.ParamByName('ESPPED').AsString := fatVenda.strEspOrigem;
    qryOrdemProducao.ParamByName('EMPPED').AsString := fatVenda.strEmpOrigem;
    qryOrdemProducao.Open;

    Result := Not qryOrdemProducao.IsEmpty;
  finally
    FreeAndNil(qryOrdemProducao);
  end;
end;
function TfrmFatConfOrcamentos.fUsaPromocaoComSugestaoPrecoTabelaSemPedidoCarregado: Boolean;
begin
  Result := (fCfgSis('PRMF11', varInteger) = 2) And (Not fPedidoCarregado);
end;

function TfrmFatConfOrcamentos.fUsaPromocaoComSugestaoPrecoTabelaSemPedidoCarregadoComCondicaoNoFinal: Boolean;
begin
  Result := fUsaPromocaoComSugestaoPrecoTabelaSemPedidoCarregado And (fCfgSis('CND_F3') = 'F');
end;

{*****************************************}
{* CARREGA AS FORMAS DE PAGAMENTO E AS   *}
{*  MODALIDADES (CASO USE IMP. FISCAL).  *}
{**************************************MV*}
procedure TfrmFatConfOrcamentos.pCarregaFormasPagamento;
  Var
    intIndMod: Integer;
    blnPos: Boolean;
    intContador: Integer;

    LDescricaoModalidade: String;
    LblnRemoverFormaCartaoTefMultiLojaOutrasEmpSemTef: Boolean;
begin
  If (fCfgSis('FPGESC', varBoolean)) And (not fEmptyStr(strDigForPag)) Then
  Begin
    strFpgOrc := strDigForPag;
  End;

  qryModalidades.Close;
  qryModalidades.SQL.Clear;

  If (Not fEmptyStr(strCodEcf)) Then
  Begin
    qryModalidades.SQL.Add('SELECT ');
    qryModalidades.SQL.Add('  F.FPG_CODIGO, ');
    qryModalidades.SQL.Add('  F.FPG_DESCRI, ');
    qryModalidades.SQL.Add('  E.ECF_DESMOD, ');
    qryModalidades.SQL.Add('  IFNULL(FE.ECF_CODMOD, "01") AS ECF_CODMOD, ');
    qryModalidades.SQL.Add('  IFNULL(E.ECF_IDENTI, "1") AS ECF_IDENTI, ');
    qryModalidades.SQL.Add('  IFNULL(E.ECF_INFADI, "N") AS ECF_INFADI, ');
    qryModalidades.SQL.Add('  CAST("" AS CHAR(5)) AS PORTADOR_ORDPAG ');
    qryModalidades.SQL.Add('FROM ');
    qryModalidades.SQL.Add('  CADFPG F ');
    qryModalidades.SQL.Add('JOIN FPGECF FE ON FE.FPG_CODIGO = F.FPG_CODIGO ');
    qryModalidades.SQL.Add('JOIN ECFMOD E ON E.ECF_CODECF = FE.ECF_CODECF AND ');
    qryModalidades.SQL.Add('                 E.ECF_CODEMP = FE.ECF_CODEMP AND ');
    qryModalidades.SQL.Add('                 E.ECF_CODMOD = FE.ECF_CODMOD AND ');
    qryModalidades.SQL.Add('                 E.ECF_CODECF = :CODECF ');
    qryModalidades.SQL.Add('WHERE ');
    qryModalidades.SQL.Add('  F.FPG_MOSMOD = "S" AND ');
    qryModalidades.SQL.Add('  F.FPG_STATUS = "A" AND ');
    qryModalidades.SQL.Add('  F.FPG_CODIGO <> "009" ');

    qryModalidades.ParamByName('CODECF').AsString := strCodEcf;
  End
  Else
  Begin
    qryModalidades.SQL.Add('SELECT ');
    qryModalidades.SQL.Add('  F.FPG_CODIGO, ');
    qryModalidades.SQL.Add('  F.FPG_DESCRI, ');
    qryModalidades.SQL.Add('  F.FPG_DESCRI AS ECF_DESMOD, ');
    qryModalidades.SQL.Add('  "01" AS ECF_CODMOD, ');
    qryModalidades.SQL.Add('  IF(F.FPG_CODIGO="007", "3", "1") AS ECF_IDENTI, ');
    qryModalidades.SQL.Add('  "N" AS ECF_INFADI, ');
    qryModalidades.SQL.Add('  CAST("" AS CHAR(5)) AS PORTADOR_ORDPAG ');
    qryModalidades.SQL.Add('FROM ');
    qryModalidades.SQL.Add('  CADFPG F ');
    qryModalidades.SQL.Add('WHERE ');
    qryModalidades.SQL.Add('  F.FPG_MOSMOD = "S" AND ');
    qryModalidades.SQL.Add('  F.FPG_STATUS = "A" AND ');
    qryModalidades.SQL.Add('  F.FPG_CODIGO <> "009"  ');
  End;

  If Assigned(fatVenda) Then
    qryModalidades.SQL.Add(TFatVenda.fFiltroFormasPagamentoF11(edtCodCli.Text, strFpgOrc,
      strConPag, strCodOpe, fatVenda.objFormasPagtoNegociada, blnRealizandoAdiantamentoPedidoPeloF11, FPermiteUsarPix))
  Else
    qryModalidades.SQL.Add(TFatVenda.fFiltroFormasPagamentoF11(edtCodCli.Text, strFpgOrc,
      strConPag, strCodOpe, nil, blnRealizandoAdiantamentoPedidoPeloF11, FPermiteUsarPix));

  qryModalidades.SQL.Add('ORDER BY ');
  qryModalidades.SQL.Add('  F.FPG_CODIGO ');

  qryModalidades.Open;
  cbxModalidades.Items.Clear;
  stlModalidades.Clear;
  LblnRemoverFormaCartaoTefMultiLojaOutrasEmpSemTef := fEhMultiLojaComAlgumaEmpresaTefDesligado(edtNumOrc.Text, strEspCfo, edtCodEmp.Text, edtCodCli.Text) ;
  blnPos := False;
  While (Not qryModalidades.Eof) Do
  Begin
    If (qryModalidades.FieldByName('FPG_CODIGO').AsString <> '013')                                        Or
       ( (qryModalidades.FieldByName('FPG_CODIGO').AsString = '013') And (LeftStr(strConPag, 2) <> '24') ) Then
    Begin

      LDescricaoModalidade := qryModalidades.FieldByName('FPG_DESCRI').AsString;
      If qryModalidades.FieldByName('FPG_CODIGO').AsString = '012' Then
      Begin
        If FPermiteUsarPix Then
          LDescricaoModalidade := LDescricaoModalidade + '/PIX';
      End;

      if not ((LblnRemoverFormaCartaoTefMultiLojaOutrasEmpSemTef) and (qryModalidades.FieldByName('ECF_IDENTI').AsString = '3')) then
      begin
        cbxModalidades.Items.Add(LDescricaoModalidade);
        stlModalidades.Add(qryModalidades.FieldByName('FPG_CODIGO').AsString);
      end ;

      If (Not blnPos) And (fUsaTef) And (qryModalidades.FieldByName('ECF_IDENTI').AsString = '3') Then
      Begin
        blnPos := True;
        cbxModalidades.Items.Add(LDescricaoModalidade + '(POS)');
        stlModalidades.Add(qryModalidades.FieldByName('FPG_CODIGO').AsString);
      End;

    End;

    qryModalidades.Next;
  End;

  intIndMod := 0;
  For intContador := 0 To stlModalidades.Count-1 Do
  Begin
    If stlModalidades[intContador] = strFpgOrc Then
    Begin
      If Pos('(POS)', cbxModalidades.Items[intContador]) <= 0 Then
      Begin
        intIndMod := intContador;
        Break;
      End;
    End;
  End;

  cbxModalidades.ItemIndex := intIndMod;
end;

Function TfrmFatConfOrcamentos.fTemModalidadeVinculado: Boolean;
Begin

  Result := FALSE;

  If (fCfgSis('USNFCE', varBoolean)) Or fUsaSat Then
  Begin
    Result := True;
    Exit;
  End;

  With cdsModalidades Do
  Begin
    First;
    While Not Eof Do
    Begin
      If FieldByName('ECF_CODMOD').AsString <> '01' Then
      Begin
        Result := TRUE;
        Exit;
      End;
      Next;
    End;
    Last;
  End;
End;

function TfrmFatConfOrcamentos.fTxPixVazia: Boolean;
begin
  Result := True ;

  if fEmptyStr(qryFatGor.FieldByName('FGO_TX_PIX').AsString) then
    Exit ;

  if FblnTxIdPixRemovida then
    Exit ;

  Result := False ;
end;

function TfrmFatConfOrcamentos.fTemModalidadeTEF: Boolean;
begin
  If Assigned(cdsModalidades) And cdsModalidades.Active and (not blnEhCartaoQuest) Then
  Begin
    Result := (cdsModalidades.Locate('ECF_IDENTI', '3', [])) And (fUsaTef) And
              (Pos('(POS)', cdsModalidades.FieldByName('DESMOD').AsString) <= 0);
  End
  else
    Result := False;
end;

function TfrmFatConfOrcamentos.fTemFormaPagtoNaoPermitidaComAReceber(Var strDesFpg: String): Boolean;
  Var
    cdsTmp: TUniClientDataSet;
begin
  cdsTmp := TUniClientDataSet.Create(Nil);
  cdsTmp.Data := cdsModalidades.Data;

  Result := False;
  cdsTmp.First;
  While Not cdsTmp.Eof Do
  Begin
    If Not fFormaPagtoPermitidaComAReceber(cdsTmp.FieldByName('CODFPG').AsString) Then
    Begin
      Result    := True;
      strDesFpg := cdsTmp.FieldByName('DESMOD').AsString;
      Break;
    End;
    cdsTmp.Next;
  End;

  FreeAndNil(cdsTmp);
end;

procedure TfrmFatConfOrcamentos.pSetarEdtCodEmpInformativo(strCodEmp: String='');
begin
  If Assigned(edtCodEmpInf) Then
    edtCodEmpInf.Text := IIF(strCodEmp.IsEmpty, edtCodEmp.Text, strCodEmp);
end;

function TfrmFatConfOrcamentos.fAdicionouItensCheckout: Boolean;
begin
  Result := False;

  If (Not Assigned(cdsItensAdd)) Then
    Exit;

  If (Not cdsItensAdd.Active) Then
    Exit;

  If (cdsItensAdd.IsEmpty) Then
    Exit;

  Result := True;
end;

procedure TfrmFatConfOrcamentos.pSetarEspecieFechamentoPD;
Begin
  pSetFocus(edtCodCli);
  pSetaTipoFaturamento('PD');
  edtTipFat.Enabled := False;
  spnTipFat.Enabled := False;
End;

procedure TfrmFatConfOrcamentos.pConfirmaValorTotal;
  Var
    blnVaiGerarPedidoParaTodosOsDesmembramentos : Boolean;
begin
  If (Not edtTipFat.Enabled) And (AnsiUpperCase(edtTipFat.Text) = 'PEDIDO') Then
    pDefineEspecieDefault;

  If (fFormataFloat(edtValDig.Value, 2) >= fFormataFloat(fStrToFloat(edtTotGer.Text), 2)) Then
  Begin
    pnlRodape.Enabled := True;
    btnAdicionarItens.Enabled := False;
    If edtTipFat.Enabled Then
      pSetFocus(edtTipFat);
    pnlCentral.Enabled := False;

    If fTemModalidadeTEF And (not fatVenda.fItensObrNfe(False, True)) And (not fTipoPedidoNFe) Then
    Begin
      pSetaTipoFaturamento('IF');
    End;

    If blnRealizandoAdiantamentoPedidoPeloF11 Then
    Begin
      If blnCliCon And fCfgSis('ECLF11', varBoolean) Then
      Begin
        pSetFocus(mskCgcCpf);
        mskCgcCpf.SelectAll;
      End
      Else
        pSetFocus(btnConfirma);
      pSetaTipoFaturamento('PD');
      edtTipFat.Enabled := False;
      spnTipFat.Enabled := False;
    End;

    blnVaiGerarPedidoParaTodosOsDesmembramentos := False;
    If (blnDesmembrarVenda) Then
      blnVaiGerarPedidoParaTodosOsDesmembramentos := fatVenda.fVaiGerarPedidoParaTodosOsDesmembramentos('S', FMatrizesDesmembramento);

    If fDeveSetarEspeciePedidoFechamentoF11(strNumeroDoc,
                                            strEspCfo,
                                            fEmpresaDocumento,
                                            qryFatGor,
                                            blnDesmembrarVenda,
                                            blnTemEntregaFutura,
                                            blnTemEntregaImediata,
                                            blnTemRetiraOutraLoja,
                                            blnVendaOrigOutraLoja,
                                            blnTemRetiraMesmaLoja,
                                            blnTemRetiraBalcao,
                                            blnTemRetiraExpedicao,
                                            blnTemItensEmpresaCD,
                                            cdsItensAdd,
                                            blnVaiGerarPedidoParaTodosOsDesmembramentos) Then
    Begin
      pSetarEspecieFechamentoPD;
    End;
  End;
end;

function TfrmFatConfOrcamentos.fReceberModalidade: Boolean;
begin
  Result := False;

  If Not Assigned(fatVenda) Then
  Begin
    fMensagem('ATENÇÃO', 'Não foi possível iniciar o recebimento: os dados da venda não estão inicializados.' + sLineBreak +
                         'Cancele esta operação, feche a tela do F11 e refaça o lançamento desde o início.' + sLineBreak +
                         'Se a mensagem se repetir, acione o suporte antes de continuar.', ['&OK']);
    pSetFocus(edtNumOrc);
    Exit;
  End;

  If InterlockedIncrement(intSemaforoReceberModalidades) = 0 Then
  Begin
    Try
      Try
        blnHabFormKeyDown := False;
        Result := fReceberModalidadeInterna;
      Finally
        blnHabFormKeyDown := True;
      End;
    Except
      InterlockedDecrement(intSemaforoReceberModalidades);
      Raise;
    End;
    InterlockedDecrement(intSemaforoReceberModalidades);
  End
  Else
    InterlockedDecrement(intSemaforoReceberModalidades);
end;

function TfrmFatConfOrcamentos.fReceberModalidadeInterna: Boolean;
  Var
    objFinanc: TFinanceira;
    fltCreditosNegociados: Double;
    strCodFpg: String;
    strIdenti: String;
    strCodMod: String;
    strDesMod: String;

    fltTotDig: Double;
    fltValDig: Double;
    fltTotGer: Double;

    fltTroco: Double;

    intIdxCrt: Integer;
    blnConfirma: Boolean;
    strValorTEF: String;

    strNomRed: String;
    strNomBan: String;
    strTipTra: String;
    strTipDeb: Char;
    intQtdPar: Integer;
    intQtdNeg: Integer;
    strNumCcd: String;
    strNumNsu: String;
    strControle: String;

    strChaPix: String;
    strPixS_N: String;
    strCodigoCarteiraDigital: String;
    strCodigoTipoOperacaoCartao: string;

    strNumDoc: String;
    strDtaTra: String;
    strHraTra: String;
    strViaCli: String;
    strViaLoj: String;
    strStatusCartao: String;

    strFpgNeg: String;

    fltValRes: Double;
    intOpcMsg: Integer;
    fltRestante: Double;

    blnUltCartao: Boolean;
    strArqRet: String;
    fltRestanteTEF: Double;

    blnDigCar: Boolean;
    strCodCar: String;
    strTipCar: String;

    blnMostrarTela: Boolean;
    strMsg: String;
    dtaDtaIni,
    dtaDtaFin: TDate;
    crTela: TChamaRotina;

    strCodPos: String;

    strNumSer : String;
    RetornoTEFCitel: IRetornoTEFCitel;
    strDadosCupom : String;
    frmAgrupDuplicatas: TfrmAgrupDuplicatas;

    intOperacao, intQtdParc : Integer;
    stlConteudo : TStringList;

    strData, strHora: String;

    strOpeRcx : String;

    LPixAvulso,
    LDescricaoModalidade,
    LPortadorOrdemPagamento: String;

    LintPriVenc: integer;
    LintPeriod: integer;
    LarrDocCartoes: TArrayInfoTraDoc;
    LrecDocCartao: TInfoTraDoc;
    LobjDadosAdicionaisTefTra: IDadosAdicionaisTefTra ;
    LValidaParcelas: IDadosValidaParcelas ;
    LstrTipoOperacaoTef: String ;
begin
  inherited;
  strCodigoCarteiraDigital := '' ;
  Result := False;
  If (blnAdicionandoItems) and (cbxModalidades.Text <> 'QUEST') Then
    Exit;

  LPortadorOrdemPagamento := EmptyStr;
  LPixAvulso := EmptyStr;

  edtValor.Value := fStrToFloat(edtValor.Text);

  If fCfgSis('FPGCLI', varBoolean) And
     (stlForPag.Count > 0) And
     (stlForPag.IndexOf(stlModalidades[cbxModalidades.ItemIndex]) < 0) And
     (strFpgOrc <> stlModalidades[cbxModalidades.ItemIndex]) Then
  Begin
    objLiberacao.Clear;
    pMsgFormasPagtoPermitidasCliente(stlModalidades[cbxModalidades.ItemIndex], stlForPag, objLiberacao.objMsgLibera);

    objLiberacao.strDirAce := 'FPGSEN';
    objLiberacao.strSenLib := fCfgSis('FPGSEN');
    objLiberacao.strMsgSen := 'Forma pagamento não permitida';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;
    objLiberacao.strCliente := edtCodCli.Text + '-' + edtNomCli.Text;
    objLiberacao.strCpfCnpj := mskCgcCpf.Text;
    objLiberacao.fltValorVenda := fStrToFloat(edtTotGer.Text);

    If Not objLiberacao.fLibera Then
    Begin
      pSetFocus(cbxModalidades);
      Exit;
    End;
  End;

  If (fStatusCndPag(strConPag) = A_VISTA) And
     (Pos(stlModalidades[cbxModalidades.ItemIndex],'001_002_006_007_012_013_014_015_016_') <= 0) And
     (Not fEmptyStr(fCfgSis('F11AVS'))) And
     (Not (fCfgSis('TFPF11', varBoolean) And fEhRecebimentoFormasPagtoNegociadas)) Then
  Begin
    fMensagem('ATENÇÃO!', 'A forma de pagamento do Orçamento/Pedido é à Vista!', ['&Ok']);

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Troca de Forma de pagamento à vista para a prazo');
    objLiberacao.strDirAce := 'F11AVS';
    objLiberacao.strSenLib := fCfgSis('F11AVS');
    objLiberacao.strMsgSen := 'Troca de Forma pagamento à vista para a prazo';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;
    objLiberacao.strCliente := edtCodCli.Text + '-' + edtNomCli.Text;
    objLiberacao.strCpfCnpj := mskCgcCpf.Text;

    If Not objLiberacao.fLibera Then
    Begin
      pSetFocus(cbxModalidades);
      Exit;
    End;
  End;

  If (fCfgSis('TEFEXC', varBoolean)) And (TLogTef.blnExcedeuTempoTEF) Then
  Begin
    fMensagem('ATENÇÃO!', MSG_TEF_EXCEDEU_TEMPO, ['&OK']);
    Exit;
  End;

  If (stlModalidades[cbxModalidades.ItemIndex] = '014') And (cdsModalidades.RecordCount > 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Essa modalidade não pode ser utilizada em conjunto com outras modalidades.', ['&Ok']);
    pSetFocus(cbxModalidades);
    Exit;
  End
  Else If (stlModalidades[cbxModalidades.ItemIndex] = '015') And
          (fTemFormaPagtoNaoPermitidaComAReceber(strDesMod)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Essa modalidade de recebimento não é permitida com a modalidade ' +
                          strDesMod + ' já informada!', ['&Ok']);
    pSetFocus(cbxModalidades);
    Exit;
  End
  Else If (cdsModalidades.RecordCount > 0) Then
  Begin

    If cdsModalidades.Locate('CODFPG', '014', []) Then
    Begin
      fMensagem('ATENÇÃO!', 'A modalidade já escolhida (' +
        cdsModalidades.FieldByName('DESMOD').AsString +') não pode ser ' +
        'utilizada em conjunto com outras modalidades.', ['&Ok']);

      pSetFocus(cbxModalidades);

      Exit;
    End;

    If (cdsModalidades.Locate('CODFPG', '015', [])) And
       (Not fFormaPagtoPermitidaComAReceber(stlModalidades[cbxModalidades.ItemIndex])) Then
    Begin
      fMensagem('ATENÇÃO!', 'A modalidade já escolhida (' +
        cdsModalidades.FieldByName('DESMOD').AsString + ') não pode ser ' +
        'utilizada em conjunto com outra modalidade que não seja ' +
        fDescricaoFormasPagtoPermitidasComAReceber + '.', ['&Ok']);

      pSetFocus(cbxModalidades);

      Exit;
    End;

    If cdsModalidades.Locate('CODFPG', '015', []) And (cdsModalidades.RecordCount > 1) Then
    Begin
      fMensagem('', 'Modalidade "' + cdsModalidades.FieldByName('DESMOD').AsString + '" já foi selecionada ' +
                    'com outra modalidade e a mesma não deve ser combinada com mais de uma modalidade!', ['&Ok']);

      pSetFocus(cbxModalidades);

      Exit;
    End;

    If (stlModalidades[cbxModalidades.ItemIndex] = '015') And (cdsModalidades.RecordCount > 1) Then
    Begin
      fMensagem('', 'Modalidade "' + cbxModalidades.Text + '" não permitida ' +
                    'pois já foram selecionadas ' + cdsModalidades.RecordCount.ToString + ' modalidades e '+
                    'a mesma não deve ser combinada com mais de uma modalidade!', ['&Ok']);
      pSetFocus(cbxModalidades);

      Exit;
    End;

  End;

  fltTotGer := fStrToFloat(edtTotGer.Text);
  {*****************************************}
  {* SE NÃO DIGITAR VALOR, VOU PARA O GRID *}
  {* OU PARA O COMBO DE MODALIDADES        *}
  {**************************************MV*}
  If (edtValor.Value <= 0) Then
  Begin
    If (pnlCentral.Enabled) Then
      If (blnFocoGrid) Then
        pSetFocus(dbgModalidades)
      Else
        pSetFocus(cbxModalidades);
    pConfirmaValorTotal;
    Exit;
  End;

  if (not qryModalidades.Active) or (qryModalidades.IsEmpty) then
  begin
    fMensagem('ATENÇÃO!', 'Modalidades não carregadas, verifique as configurações de modalidades de recebimento e recarregue o documento!', ['&Ok']);
    Exit;
  end;

  strCodFpg := IIF(blnEhCartaoGrynCash, '007' , stlModalidades[cbxModalidades.ItemIndex]);
  qryModalidades.Locate('FPG_CODIGO', strCodFpg, [loCaseInsensitive]);

  strIdenti := qryModalidades.FieldByName('ECF_IDENTI').AsString;
  strCodMod := qryModalidades.FieldByName('ECF_CODMOD').AsString;

  {*****************************************}
  {* TRAVA PARA CASO USE ECF               *}
  {* SÓ PODE DIGITAR VÁRIAS VEZES CARTÃO   *}
  {**************************************MV*}
  If (Not fEmptyStr(strCodEcf)) And (Pos(strIdenti, '3') <= 0) And (cdsModalidades.Locate('CODFPG', strCodFpg, [])) Then
  Begin
    fMensagem('', 'Essa modalidade já foi informada!', ['&Ok']);
    pSetFocus(edtValor);
    Exit;
  End;

  {*****************************************}
  {* TRAVA PARA CASO NÃO USE ECF           *}
  {* SÓ PODE DIGITAR VÁRIAS VEZES CARTÃO   *}
  {**************************************MV*}
  if fTravaRepetirFormaPagamento(strCodEcf, strCodFpg) then
  Begin
    fMensagem('', 'Essa modalidade já foi informada!', ['&Ok']);
    pSetFocus(edtValor);
    Exit;
  End;

  blnConfirma := ValidaCondicaoPixOuValorDoPixGeradoPeloPedido;
  If Not blnConfirma Then
    Exit(False);

  {*****************************************}
  {* QUANDO É UTILIZAÇÃO DE CRÉDITOS, SÓ   *}
  {* PODE UTILIZAR FORMAS À VISTA OU À PRA-*}
  {* ZO.                                   *}
  {**************************************MV*}
(*  If (cdsModalidades.Locate('CODFPG', '013', [])) Then
  Begin

    If (Pos(strCodFpg, '008_010_') > 0) Then
    Begin
      cdsModalidades.First;
      While (Not cdsModalidades.Eof) Do
      Begin
        If (Pos(cdsModalidades.FieldByName('CODFPG').AsString, '008_010_013_') <= 0) Then
        Begin
          fMensagem('', 'Não é permitido a utilização de Faturado ou Vale.', ['&Ok']);
          pSetFocus(edtValor);
          Exit;
        End;
        cdsModalidades.Next;
      End;
    End
    Else
    Begin
      cdsModalidades.First;
      While (Not cdsModalidades.Eof) Do
      Begin
        If (Pos(cdsModalidades.FieldByName('CODFPG').AsString, '008_010_') > 0) Then
        Begin
          fMensagem('', 'Já foi inserido a modalidade Faturado ou Vale, portanto ' +
            'só é permitido utilizar Faturado ou Vale.', ['&Ok']);
          pSetFocus(edtValor);
          Exit;
        End;
        cdsModalidades.Next;
      End;
    End;

  End;*)

  if blnEhCartaoGrynCash then
    edtValor.Value := fltCshGry;

  fltValDig := edtValor.Value;
  fltTotDig := edtValDig.Value + fltValDig;

  fltTroco := edtValTro.Value;

  {*****************************************}
  {* VERIFICA A POSSIBILIDADE DE DAR TROCO *}
  {**************************************MV*}
  {*****************************************}
  {* AGORA O 013 - UTILIZAÇÃO DE CREDITOS  *}
  {* PODE DIGITAR QUALQUER VALOR, QUE O    *}
  {* SISTEMA IRÁ CALCULAR O MESMO COM BASE *}
  {* NOS CRÉDITOS SELECIONADOS             *}
  {**************************************MV*}
  If (fFormataFloat(fltTotDig, 2) > fFormataFloat(fltTotGer, 2)) And (strCodFpg <> '013') Then
  Begin

    {*****************************************}
    {* SÓ PODE DAR TROCO PARA DINHEIRO.      *}
    {**************************************MV*}
    If (strIdenti <> '1') Or (strCodFpg <> '001') Then
    Begin

      If strIdenti = '3' Then
      Begin
        strDesMod := 'CARTÃO';
      End
      Else If strIdenti = '4' Then
      Begin
        strDesMod := 'CHEQUE';
      End
      Else If strIdenti = '2' Then
      Begin
        strDesMod := 'CHEQUE-PRÉ';
      End
      Else If strIdenti = '5' Then
      Begin
        strDesMod := 'VENDA A PRAZO';
      End
      Else
      Begin
        strDesMod := qryModalidades.FieldByName('FPG_DESCRI').AsString;
      End;

      If Not (((Pos(strCodFpg, '002_006_') > 0) And fCfgSis('TROCHQ', varBoolean)) Or
              ((Pos(strCodFpg, '007_')  > 0) And fCfgSis('TROCAR', varBoolean)))   Then
      Begin

        If (fltValDig > fltTotGer) Then
        Begin
          fMensagem('', 'O valor para modalidade ' + strDesMod + ' ' + #13 +
                        'não pode ultrapassar o valor' +#13 +
                        'total da compra.', ['&Ok']);
          pSetFocus(edtValor);
          Exit;
        End
        Else
        Begin
          fMensagem('', 'Não permitido troco para ' + strDesMod + '.', ['&Ok']);
          pSetFocus(edtValor);
          Exit;
        End;

      End;

    End
    Else If (fltTroco > 0.0) Then
    Begin
      fMensagem('', 'O total da venda já foi atingido!', ['&Ok']);
      Exit;
    End
    Else If Not fVerificaTrocoOuAdiantamentoEmDinheiro(strCodFpg) Then
    Begin
      fltTroco := (fltTotDig - fltTotGer);
      edtValTro.Value := fltTroco;
    End;

  End;

  {*****************************************}
  {* SE FOR CARTÃO, REALIZA A DIGITAÇÃO E  *}
  {* E CHAMA O TEF.                        *}
  {**************************************MV*}
  blnConfirma := True;
  If (strCodFpg = '007') Then
  Begin
    strTipCar := '';
    If (fUsaTef) Then
    Begin
      If (fCfgSis('PAFECF', varBoolean)) And
         (Pos('(POS)', cbxModalidades.Items[cbxModalidades.ItemIndex]) <= 0) And
         (Assigned(VS_objFiscal)) Then
      Begin
        If (Not VS_objFiscal.fValidaSerieECFEmpresa(strNumSer)) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO!', 'O número de série "' + strNumSer + '" não foi encontrado nos dados da ECF na empresa "' + VS_strCodEmp + '".', ['&OK']);
          Exit;
        End;
      End;

      strValorTEF := FloatToStrF(fltValDig, ffFixed, 12, 2);
      strValorTEF := fTiraCaracter(strValorTEF);

      fltRestanteTEF := fltTotGer - edtValDig.Value;

      {*****************************************}
      {* VERIFICA SE É O ÚLTIMO CARTÃO DIGITADO*}
      {**************************************MV*}
      blnUltCartao := False;
      If (fltValDig - fltRestanteTEF >= 0) Then
        blnUltCartao := True;

      If (Pos('(POS)', cbxModalidades.Items[cbxModalidades.ItemIndex]) <= 0) and (not blnEhCartaoQuest) Then
      Begin

        If Not fEhRecebimentoFormasPagtoNegociadas Then
        Begin
          Self.Enabled := False;
        End;

        if VS_blnTefCitel then
        Begin
          strNumDoc := fRetNumDocTransacaoTef;

          strOpeRcx := IIF(fEmptyStr(strCodOpe), strLoginUsuarioLogado, strCodOpe);

          FillChar(LrecDocCartao, SiZeOf(LrecDocCartao), #0) ;
          LrecDocCartao.DtaTra := VS_Date ;
          LrecDocCartao.NumDoc := strNumDoc ;
          LrecDocCartao.CodEmp := VS_strCodEmp ;
          LrecDocCartao.NumDup := edtNumOrc.Text ;
          LrecDocCartao.EspDoc := strEspCfo ;
          LrecDocCartao.Parcel := '' ;
          LrecDocCartao.EmpDoc := VS_strCodEmp ;
          SetLength(LarrDocCartoes, 1) ;
          LarrDocCartoes[Low(LarrDocCartoes)] := LrecDocCartao ;

          LobjDadosAdicionaisTefTra := TDadosAdicionaisTefTra
                                         .New
                                         .PixS_N('N')
                                         .OpcDoc(IfThen(fAdicionouItensCheckout, 'F3', '11'))
                                         .OpeRcx(strOpeRcx)
                                         .ArrDocs(LarrDocCartoes)
                                         .NumDoc(strNumDoc)
                                         .Valor(fltValDig) ;

          LValidaParcelas := TDadosValidaParcelasCartao
                               .New
                               .F11(fIsF11)
                               .QtdNeg(fRetornaQtdNeg)
                               .CodFin(fRetornaCodFin) ;

          RetornoTEFCitel := fChamaTelaDeOperacoes(fltValDig, strNumDoc, intQtdParc, intOperacao, LobjDadosAdicionaisTefTra, LValidaParcelas);

          blnConfirma := Assigned(RetornoTEFCitel);

          if blnConfirma then
          begin
            strData          := copy(RetornoTEFCitel.DadosCartao.strDataHoraTrans,1,8);
            strHora          := copy(RetornoTEFCitel.DadosCartao.strDataHoraTrans,9,6);

            If (Not blnConfirma) And (Assigned(RetornoTEFCitel)) And (Not fEmptyStr(RetornoTEFCitel.StatusTEF.strStatus)) Then
              fMensagem('ATENÇÃO!', Format('Status: %s - %s', [RetornoTEFCitel.StatusTEF.strStatus, RetornoTEFCitel.StatusTEF.strMensagem]), ['&OK']);

            stlConteudo    := TStringList.Create;
            try
              pMontaConteudoCupom(RetornoTEFCitel.DadosCartao.strConteudoViaCliente + sLineBreak +
                                  RetornoTEFCitel.DadosCartao.strConteudoViaLojista,
                                  fStrZero(RetornoTEFCitel.DadosCartao.strNomeRede,5),
                                  fStrZero(RetornoTEFCitel.DadosCartao.strBandeira,5),
                                  RetornoTEFCitel.DadosCartao.strCodigoEstabeleci,
                                  stlConteudo);
              strArquivoTef  := stlConteudo.Text;
            finally
              FreeAndNil(stlConteudo);
            end;

            strArqViaCliente := RetornoTEFCitel.DadosCartao.strConteudoViaCliente;
            strArqViaLojista := RetornoTEFCitel.DadosCartao.strConteudoViaLojista;
          end ;
        End
        Else
        Begin
          If (Assigned(VS_objTef)) And (Not VS_objTef.fTef_Crt(strValorTEF, blnPrimeiraVendaTEF, blnUltCartao, strArqRet)) Then
            blnConfirma := False;
        End;

        If Not fEhRecebimentoFormasPagtoNegociadas Then
        Begin
          Self.Enabled := True;
          SetForegroundWindow(Handle);
        End;
      End;

      blnPrimeiraVendaTEF := False;
    End;

    If (fCfgSis('DIGCAR') = 'S') And (blnConfirma) Then
    Begin
      strNomRed := '';
      strTipTra := '';
      strTipDeb := '0';
      strNumCcd := '';
      blnDigCar := True;
      strCodCar := '';
      strNumNsu := '';
      strControle := '';
      strChaPix := '';
      strPixS_N := 'N';
      LintPriVenc := -1;
      LintPeriod  := 0;
      LstrTipoOperacaoTef := '' ;

      intQtdNeg := fRetornaQtdNeg ;

      strDadosCupom := '';

      If (VS_blnTefCitel) And Assigned(RetornoTEFCitel) And (Pos('(POS)', cbxModalidades.Items[cbxModalidades.ItemIndex]) <= 0) and (not blnEhCartaoQuest) and
         (not blnEhCartaoGrynCash) Then
      Begin
        strNomRed := fStrZero(RetornoTEFCitel.DadosCartao.strNomeRede,5);
        strNomBan := fStrZero(RetornoTEFCitel.DadosCartao.strBandeira,5);
        strTipTra := RetornoTEFCitel.DadosCartao.strTipoTransacao;
        strTipDeb := RetornoTEFCitel.DadosCartao.strTipDeb;
        intQtdPar := StrToInt(RetornoTEFCitel.DadosCartao.strQuantidadeParcelas);
        strNumCcd := RetornoTEFCitel.DadosCartao.strAutorizacao;
        strNumNsu := fPadL(RetornoTEFCitel.DadosCartao.strNSU, 14, '0');
        strControle := RetornoTEFCitel.DadosCartao.strControle ;
        strDadosCupom := strArquivoTef;
        strTipCar := 'TEF';
        strDtaTra := Copy(RetornoTEFCitel.DadosCartao.strDataHoraTrans,1,8);
        strHraTra := Copy(RetornoTEFCitel.DadosCartao.strDataHoraTrans,9,6);;
        strViaCli := RetornoTEFCitel.DadosCartao.strConteudoViaCliente;
        strViaLoj := RetornoTEFCitel.DadosCartao.strConteudoViaLojista;
        strArqViaCliente := RetornoTEFCitel.DadosCartao.strConteudoViaCliente;
        strArqViaLojista := RetornoTEFCitel.DadosCartao.strConteudoViaLojista;
        strStatusCartao := 'P';
        strPixS_N := RetornoTEFCitel.DadosCartao.strPixS_N;
        strChaPix := RetornoTEFCitel.DadosCartao.strChaPix;
        strCodigoCarteiraDigital := RetornoTEFCitel.DadosCartao.strCodigoCarteiraDigital;
        strCodigoTipoOperacaoCartao := IntToStr(intOperacao);
        LintPriVenc := RetornoTEFCitel.DadosCartao.intPrimeiroVencimento;
        LintPeriod  := RetornoTEFCitel.DadosCartao.intPeriodo;
        LstrTipoOperacaoTef := RetornoTEFCitel.DadosCartao.strTipoOperacao ;
      End
      Else If (VS_strUsaTef = 'S') And Assigned(VS_objTef) And (Pos('(POS)', cbxModalidades.Items[cbxModalidades.ItemIndex]) <= 0) and (not blnEhCartaoQuest) and
         (not blnEhCartaoGrynCash) Then
      Begin
        strNomRed := VS_objTef.strNomRed;
        strNomBan := VS_objTef.strNomBan;
        strTipTra := VS_objTef.strTipTra;
        strTipDeb := '0';
        intQtdPar := VS_objTef.intQtdPar;
        strNumCcd := VS_objTef.strNumCcd;
        strNumNsu := fPadL(VS_objTef.strNumNsu, 14, '0');
        strTipCar := 'TEF';
        strChaPix := VS_objTef.strChaPix;
        strPixS_N := VS_objTef.strPixS_N;
        strCodigoCarteiraDigital := '';
      End
      Else
      Begin
        strCodCar := strCodCarPed;
        intQtdPar := intQtdParPed;
        blnDigCar := fEmptyStr(strCodCarPed);//Caso ja tenha selecionado no pedido nao deixa alterar
        strTipCar := 'POS';
      End;

      if blnEhCartaoQuest then
      begin
        strCodCar := fCfgSis('CARQUE');
        intQtdPar := 1;
        strNumCcd := '.';
        strNumNsu := '.';
      end;

      if blnEhCartaoGrynCash then
      begin
        strCodCar := fCfgSis('CARGRY');
        intQtdPar := 1;
        strNumCcd := '.';
        strNumNsu := '.';
      end;

      blnConfirma := fDigCartao(fltValDig, intIdxCrt, strNomRed, strNomBan, strTipTra,
        strNumCcd, strNumNsu, strTipDeb, intQtdPar, LstrTipoOperacaoTef, arrCartoes, strCodCar, fRetornaCodFin, intQtdNeg,
        blnDigCar, strArqRet, strCodPos, strTipCar, strDadosCupom, strChaPix, strPixS_N, strNumDoc, strDtaTra, strHraTra,
        strStatusCartao, strCodigoCarteiraDigital, LintPeriod, LintPriVenc, strControle, strCodigoTipoOperacaoCartao);
    End;
  End

  {*****************************************}
  {* SE FINANCIAMENTO CHAMA O CARTÃO       *}
  {**************************************LA*}
  Else If (strCodFpg = '016') Then
  Begin
    {If blnTemRetiraOutraLoja And fCfgSis('NPRF11', varBoolean) Then
    Begin
      pMensagemOk('Forma de pagamento não permitido para documento que ' +
                  'possui itens de retira de outra loja, pois o sistema esta ' +
                  'configurado para gerar um novo pedido de venda!');
      blnConfirma := False;
    End
    {If blnTemRetiraExpedicao And fCfgSis('LOCRET', varBoolean) Then
    Begin
      pMensagemOk('Forma de pagamento não permitido para documento que ' +
                  'possui itens de retira expedição, pois o sistema irá ' +
                  'gerar um novo pedido de venda!');
      blnConfirma := False;
    End
    Else If blnTemItensEmpresaCD And fCfgSis('ENT_CD', varBoolean) Then
    Begin
      pMensagemOk('Forma de pagamento não permitido para documento que ' +
                  'possui itens para faturamento em outra empresa, pois o ' +
                  'sistema irá gerar um novo pedido de venda para a empresa!');
      blnConfirma := False;
    End
    Else} If (fCfgSis('DIGCAR') = 'S') And (blnConfirma) Then
    Begin
      strNomRed := '';
      strNomBan := '';
      strTipTra := '';
      strTipDeb := '0';
      strNumCcd := '';
      strTipCar := '';

      If ((VS_strUsaTef = 'S') And Assigned(VS_objTef)) or (VS_blnTefCitel) Then
        strTipCar := 'TEF'
      Else
        strTipCar := 'POS';

      Try
        SetLength(arrCartFin, 0);

        objFinanc := TFinanceira.Create(Nil);

        With objFinanc, cdsMovFin Do
        Begin
          pCarregaFinanciamento('FATGOR', strAutInc);
          First;
          strNumNsu := '';
          While Not Eof Do
          Begin

            If FieldByName('FIN_TIPRET').AsString = 'P' Then
              blnConfirma := fDigCartao(IIF(FieldByName('FIN_DESACE').AsString = 'S',
                                            FieldByName('FIN_VALOPE').AsFloat,
                                            FieldByName('FIN_VALFIN').AsFloat),
                intIdxCrt, strNomRed, strNomBan, strTipTra,strNumCcd, strNumNsu, strTipDeb, FieldByName('FIN_QTDPAR').AsInteger, 'C',
                arrCartFin, fRetCartaoFinanceira(FieldByName('FIN_CODFIN').AsString, FieldByName('FIN_QTDPAR').AsInteger),
                FieldByName('FIN_CODFIN').AsString, 0, True, '', '', strTipCar, '', strChaPix, strPixS_N,
                strNumDoc, strDtaTra, strHraTra, strCodigoCarteiraDigital);

            If Not blnConfirma Then
              Break;

            Next;
          End;
        End;

        FreeAndNil(objFinanc);

      Except

        On E: Exception Do
        Begin
          pMensagensErro(E.Message,'[TfrmFatConfOrcamentos.edtValorExit]');
          blnConfirma := False;
        End;

      End;

    End;
  End

  {*****************************************}
  {* DIGITAÇÃO DO CHEQUE-PRÉ               *}
  {**************************************MV*}
  Else If (strCodFpg = '002') And (fCfgSis('CHQRCX') = 'S') Then
  Begin
    blnConfirma := fChequePre(fltValDig);
  End

  {*****************************************}
  {* DIGITAÇÃO DO CHEQUE À VISTA           *}
  {**************************************MV*}
  Else If (strCodFpg = '006') And (fCfgSis('CHQRCX') = 'S') And (fCfgSis('CHQVIS') = 'S') Then
  Begin
    blnConfirma := fChequeVis(fltValDig);
  End;

  {***************************************}
  {* RECEBIMENTO POR PIX                 *}
  {************************************AJ*}
  If strCodFpg = '012' Then
  Begin
    If FPermiteUsarPix Then
    Begin
      blnConfirma := AbreTelaParaPagamentoDoPix(blnConfirma,
                                                fltValDig,
                                                LPortadorOrdemPagamento,
                                                LPixAvulso);

      If Not blnConfirma Then
        Exit(False);
    End
    Else
    Begin
      If fatVenda.FPortadorTFAutomatica.IsEmpty Then
        fatVenda.FPortadorTFAutomatica := objResumoDeCaixa.RetornaPortadorTFAutomatica(True);

      If objResumoDeCaixa.TransferenciaOrdemPagamentoAutomaticaFaturamento Then
      Begin
        blnConfirma := Not fatVenda.FPortadorTFAutomatica.IsEmpty;

        If Not blnConfirma Then
          Exit(False);
      End;

      LPortadorOrdemPagamento := fatVenda.FPortadorTFAutomatica;
    End;
  End;

  fltRestante := fltTotGer - edtValDig.Value;

  If fVerificaTrocoOuAdiantamentoEmDinheiro(strCodFpg) And (blnConfirma) Then
  Begin
    If (fFormataFloat(fltValDig, 2) > fFormataFloat(fltRestante, 2)) Then
    Begin
      fltValorTrocoDin := fltValDig - fltRestante;

      intOpcMsg := fMensagem('', 'Deseja:', ['&Troco', '&Crédito']);
      If intOpcMsg = 1 Then
      Begin
        optTrocoDin := otTroco;
        edtValTro.Value := edtValTro.Value + Abs(fltValorTrocoDin);
      End
      Else
      Begin
        optTrocoDin := otCredito;
        fatVenda.strPortadorCreditoCliente := fRetornaPortadorCredito;
      End;
    End;
  End

  Else If (strCodFpg = '002') And (fCfgSis('TROCHQ', varBoolean)) And (blnConfirma) Then
  Begin
    If (fFormataFloat(fltValDig, 2) > fFormataFloat(fltRestante, 2)) Then
    Begin
      fltValorTrocoPre := fltValDig - fltRestante;

      intOpcMsg := fMensagem('', 'Deseja:', ['&Troco', '&Crédito']);
      If intOpcMsg = 1 Then
      Begin
        If (fCfgSis('UTTROC', varString) = 'S') Then
        Begin
          optTrocoPre := otCredito;
          fatVenda.strPortadorCreditoCliente := fCfgSis('PORSLC');
          edtValTro.Value := edtValTro.Value + Abs(fltValorTrocoPre);
          blnTrocoComoCredito := True;
        End
        Else If (Not fTravarTrocoUtlCartaoOuCheque(False,fltValorTrocoPre)) Then
          blnConfirma := False
        Else
        Begin
          optTrocoPre := otTroco;
          edtValTro.Value := edtValTro.Value + Abs(fltValorTrocoPre);
        End;
      End
      Else
      Begin
        optTrocoPre := otCredito;
        fatVenda.strPortadorCreditoCliente := fRetornaPortadorCredito;
      End;

    End;
  End

  Else If (strCodFpg = '006') And (fCfgSis('TROCHQ', varBoolean)) And (blnConfirma) Then
  Begin

    If (fFormataFloat(fltValDig, 2) > fFormataFloat(fltRestante, 2)) Then
    Begin
      fltValorTroco := fltValDig - fltRestante;

      intOpcMsg := fMensagem('', 'Deseja:', ['&Troco', '&Crédito']);
      If intOpcMsg = 1 Then
      Begin
        If (fCfgSis('UTTROC', varString) = 'S') Then
        Begin
          optTroco := otCredito;
          fatVenda.strPortadorCreditoCliente := fCfgSis('PORSLC');
          edtValTro.Value := edtValTro.Value + Abs(fltValorTroco);
          blnTrocoComoCredito := True;
        End
        Else If (Not fTravarTrocoUtlCartaoOuCheque(False,fltValorTroco)) Then
          blnConfirma := False
        Else
        Begin
          optTroco := otTroco;
          edtValTro.Value := edtValTro.Value + Abs(fltValorTroco);
        End;
      End
      Else
      Begin
        optTroco := otCredito;
        fatVenda.strPortadorCreditoCliente := fRetornaPortadorCredito;
      End;

    End;
  End

  Else If (strCodFpg = '007') And fCfgSis('TROCAR', varBoolean) And blnConfirma Then
  Begin
    If (fFormataFloat(fltValDig, 2) > fFormataFloat(fltRestante, 2)) Then
    Begin
      fltValorTrocoCar := fltValDig - fltRestante;

      intOpcMsg := fMensagem('', 'Deseja:', ['&Troco', '&Crédito']);
      If intOpcMsg = 1 Then
      Begin
        If (fCfgSis('UTTROC', varString) = 'S') Then
        Begin
          optTrocoCar := otCredito;
          fatVenda.strPortadorCreditoCliente := fCfgSis('PORSLC');
          edtValTro.Value := edtValTro.Value + Abs(fltValorTrocoCar);
          blnTrocoComoCredito := True;
        End
        Else If (Not fTravarTrocoUtlCartaoOuCheque(True,fltValorTrocoCar)) Then
          blnConfirma := False
        Else
        Begin
          optTrocoCar := otTroco;
          edtValTro.Value := edtValTro.Value + Abs(fltValorTrocoCar);
        End;
      End
      Else
      Begin
        optTrocoCar := otCredito;
        fatVenda.strPortadorCreditoCliente := fRetornaPortadorCredito;
      End;

    End;
  End

  Else If (strCodFpg = '013') Then
  Begin
    fltCreditosNegociados := 0;
    If (cdsModalidades.IsEmpty) Then
    Begin
      If fExisteCredComProfissionalDevMerc(edtCodCli.Text, dtaDtaIni, dtaDtaFin, crTela) Then
      Begin
        Try
          strMsg := '';

          If crTela = crAgrupamento Then
          Begin
            strMsg := strMsg + 'Este cliente tem títulos em aberto no contas a receber, a serem quitados, decorrente da ';
            strMsg := strMsg + 'comissão por devolução de mercadorias. ' + sLineBreak;
            strMsg := strMsg + 'Você será encaminhado para o Agrupamento de Duplicatas para agrupar os créditos decorrentes ';
            strMsg := strMsg + 'das vendas com os débitos decorrentes da devolução. ' + sLineBreak;
            strMsg := strMsg + 'Caso o valor final do agrupamento permaneça negativo (crédito para o cliente), o crédito ';
            strMsg := strMsg + 'poderá ser usado na Utilização de Créditos. '+ sLineBreak;
            strMsg := strMsg + 'Caso o valor final do agrupamento permaneça positivo (débito para o cliente), o operador ';
            strMsg := strMsg + 'deverá realizar a quitação pela rotina de recebimento no caixa. ';
          End
          Else
          Begin
            strMsg := strMsg + 'Este cliente tem títulos em aberto no contas a receber, a serem quitados, decorrente da ';
            strMsg := strMsg + 'comissão por devolução de mercadorias. ' + sLineBreak;
            strMsg := strMsg + 'Contudo, ele possui créditos que deixam seu saldo devedor zerado. Você será encaminhado ';
            strMsg := strMsg + 'para a Baixa do Contas a Receber para liquidar estes títulos em aberto, sem necessidade ';
            strMsg := strMsg + 'de pagamento financeiro por parte do cliente.';
          End;

          pCriarFormularios(TfrmObservacao, frmObservacao);
          frmObservacao.lblMensagem.Caption := 'Débitos/Créditos do Cliente';
          frmObservacao.memObs.Texto := strMsg;
          frmObservacao.ShowModal;
        Except
          On E: Exception Do
            pMensagensErro(E.Message, '[frmObservacao]');
        End;

        pFreeAndNil(frmObservacao);

        If crTela = crAgrupamento Then
        Begin
          pCriarFormularios(TfrmAgrupDuplicatas, frmAgrupDuplicatas);
          SetLength(frmAgrupDuplicatas.arrDocsAgrupar, 0);
          frmAgrupDuplicatas.edtCodCli.Text := edtCodCli.Text;
          frmAgrupDuplicatas.mskDtaIni.Text := DateToStr(dtaDtaIni);
          frmAgrupDuplicatas.mskDtaFin.Text := DateToStr(dtaDtaFin);
          frmAgrupDuplicatas.blnF11 := True;
          frmAgrupDuplicatas.ShowModal;

          If frmAgrupDuplicatas.taAgrupouF11 <> taNone Then
          Begin
            If frmAgrupDuplicatas.taAgrupouF11 = taAbortou Then
              fMensagem('ATENÇÃO','É necessário que agrupe todas as duplicatas de créditos para utilizar este tipo de modalidade!',['&OK']);

            pFreeAndNil(frmAgrupDuplicatas);
            Exit;
          End
          Else
            pFreeAndNil(frmAgrupDuplicatas);
        End
        Else
        Begin
          If Not TFuncoesCaixa.fChamaTelaCaixa(strCodOpe, edtCodCli.Text) Then
          Begin
            fMensagem('ATENÇÃO','É necessário que baixe todas as duplicatas de créditos para utilizar este tipo de modalidade!',['&OK']);
            Exit;
          End;
        End;
      End;

      fltCreditosNegociados := 0;

      strFpgNeg := '009_';
      If (fCfgSis('TFPF11', varBoolean) Or fCfgSis('SFPGPD', varBoolean)) Then
        strFpgNeg := strFpgNeg + '013_';

      If (fPos(fatVenda.strCodFpg, strFpgNeg)) And
         (fatVenda.objFormasPagtoNegociada.fFormaPagtoSelecionada('013')) Then
      Begin
        fltCreditosNegociados := fatVenda.objFormasPagtoNegociada.cdsFormasNegociadas.FieldByName('VALFPG').AsFloat;
        stlDupCreditos.Text   := fatVenda.objFormasPagtoNegociada.stlDupCreditos.Text;
      End;

      blnMostrarTela := (fltCreditosNegociados = 0);
      TLiberacaoFactory.pSetLiberacao(TLiberacao.Create);
      blnConfirma := fSelecionaDuplicatasCredito(edtCodCli.Text, fStrToFloat(edtTotGer.Text),
        stlDupCreditos, stlLckDup, fltTotCreditos, '', fTravaUtilizacaoCredito, blnMostrarTela,
        fltCreditosNegociados, TLiberacaoFactory.fGetLiberacao, '11', Not blnMostrarTela);
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'A modalidade Utilização de Créditos deve ser ' +
                            'informada antes das outras modalidades', ['&Ok']);
      blnConfirma := False;
    End;

    If (blnConfirma) Then
    Begin
      fltCredUtilizados := IIF((fltCreditosNegociados > 0) And (fCfgSis('MANCRE', varBoolean)), Min(fltCreditosNegociados, fStrToFloat(edtTotGer.Text)), Min(fltTotCreditos, fStrToFloat(edtTotGer.Text)));
      If (fltTotCreditos > fltCredUtilizados) Then
        fltTotCreditos := fltCredUtilizados;
      edtValor.Value := fltCredUtilizados;
    End;
  End;

  If (strFpgOrc = '016') And (strCodFpg <> '016') And (Not blnRealizandoAdiantamentoPedidoPeloF11) Then // NAO DEIXA MUDAR DE FINANCEIRA PARA OUTRA
  Begin
    fMensagem('ATENÇÃO!', 'O ' + IIF(strEspCfo = 'OR', 'Orçamento', 'Pedido') + ' foi definido com a modalidade Financiamento e não pode ser alterado!', ['&Ok']);
    blnConfirma := False;
  End;

  {*****************************************}
  {* VERIFICA SE JÁ INCLUIU ALGUMA UTILI-  *}
  {* ZAÇÃO DE CRÉDITOS. CASO SIM, SÓ DEIXA *}
  {* INCLUIR FORMAS DE PAGAMENTO QUE SÃO   *}
  {* À VISTA.                              *}
  {**************************************MV*}
  (**********************************************)
  (* SOLICITADO PARA RETIRAR A TRAVA.           *)
  (* NÃO PERCEBI NENHUMA CONSEQUENCIA SINISTRA. *)
  (* *****************************************LA*)
{
  If (blnConfirma) And (cdsModalidades.Locate('CODFPG', '013', [])) Then
  Begin
    If (Pos(strCodFpg, '001_002_006_007') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Já foi incluído uma modalidade Utilização de Créditos, ' +
                            'portanto só é permitido incluir Dinheiro, Cheque ou Cartão.', ['&Ok']);
      blnConfirma := False;
    End;
  End;
}
  If (blnConfirma) Then
  Begin
    With cdsModalidades Do
    Begin
      Append;
      FieldByName('ORDEM').AsInteger     := IIF(strCodFpg='013', 0, 1);

      If (VS_blnTefCitel) And (Assigned(objTefCitel)) And (Assigned(RetornoTEFCitel)) Then
        FieldByName('VALOR').AsFloat := fltValDig
      Else
        FieldByName('VALOR').AsFloat := edtValor.Value;

      If optTroco = otCredito Then
        FieldByName('VALOR').AsFloat := FieldByName('VALOR').AsFloat - fltValorTroco;

      If optTrocoPre = otCredito Then
        FieldByName('VALOR').AsFloat := FieldByName('VALOR').AsFloat - fltValorTrocoPre;

      If optTrocoCar = otCredito Then
        FieldByName('VALOR').AsFloat := FieldByName('VALOR').AsFloat - fltValorTrocoCar;

      If optTrocoDin = otCredito Then
        FieldByName('VALOR').AsFloat := FieldByName('VALOR').AsFloat - fltValorTrocoDin;

      if blnVaiResgatarQuest then
      begin
        FieldByName('DESMOD').AsString     := 'QUEST';
        FieldByName('ECF_CODMOD').AsString := '007';
        FieldByName('ECF_IDENTI').AsString := '3';
        FieldByName('ECF_INFADI').AsString := '';
        FieldByName('CODFPG').AsString     := '007';
        FieldByName('IDXCRT').AsInteger    := intIdxCrt;
        FieldByName('ECF_DESMOD').AsString := 'QUEST';
      end
      else
      if blnEhCartaoGrynCash then
      begin
        FieldByName('DESMOD').AsString     := 'GRYNCASH';
        FieldByName('ECF_CODMOD').AsString := '007';
        FieldByName('ECF_IDENTI').AsString := '3';
        FieldByName('ECF_INFADI').AsString := '';
        FieldByName('CODFPG').AsString     := '007';
        FieldByName('IDXCRT').AsInteger    := intIdxCrt;
        FieldByName('ECF_DESMOD').AsString := 'GRYNCASH';
      end
      else
      begin
        LDescricaoModalidade := qryModalidades.FieldByName('FPG_DESCRI').AsString +
                                IIF(Pos('(POS)', cbxModalidades.Items[cbxModalidades.ItemIndex]) > 0, '(POS)', '');
        If qryModalidades.FieldByName('FPG_CODIGO').AsString = '012' Then
        Begin
          If FPermiteUsarPix Then
            LDescricaoModalidade := qryModalidades.FieldByName('FPG_DESCRI').AsString + '/PIX';
        End;

        FieldByName('DESMOD').AsString := LDescricaoModalidade;
        FieldByName('ECF_CODMOD').AsString := qryModalidades.FieldByName('ECF_CODMOD').AsString;
        FieldByName('ECF_IDENTI').AsString := qryModalidades.FieldByName('ECF_IDENTI').AsString;
        FieldByName('ECF_INFADI').AsString := qryModalidades.FieldByName('ECF_INFADI').AsString;
        FieldByName('CODFPG').AsString     := qryModalidades.FieldByName('FPG_CODIGO').AsString;
        FieldByName('IDXCRT').AsInteger    := intIdxCrt;
        FieldByName('ECF_DESMOD').AsString := qryModalidades.FieldByName('ECF_DESMOD').AsString;
      end;

      FieldByName('PORTADOR_ORDPAG').AsString := LPortadorOrdemPagamento;
      FieldByName('PIX_AVULSO').AsString := LPixAvulso;

      Post;
    End;
  End;

  Result := blnConfirma;

  fltValRes := 0.0;
  If RoundTo(fltTotGer,-2) > RoundTo(edtValDig.Value,-2) Then
    fltValRes := RoundTo(fltTotGer - edtValDig.Value,-2);

  If strCodFpg <> '007' then
    cbxModalidades.ItemIndex := 0;
  edtValor.Value := fltValRes;
  pSetFocus(cbxModalidades);

  pConfirmaValorTotal;

  chkEndEnt.Visible := (fCfgSis('CUPEET') = 'S') And fTemModalidadeVinculado And Not blnRealizandoAdiantamentoPedidoPeloF11;

  If fCfgSis('CHKENT', varBoolean) Then
    chkEndEnt.Checked := chkEndEnt.Visible;

  If Not chkEndEnt.Visible Then
    chkEndEnt.Checked := FALSE;

  blnEhCartaoGrynCash := False;
end;

function TfrmFatConfOrcamentos.fGetIndexModalidade(strCodFpg: String): Integer;
  Var
    intIndMod: Integer;
    arrIndMod: Array Of Integer;
    arrDesMod: Array Of String;
begin
  For intIndMod := 0 To stlModalidades.Count - 1 Do
  Begin
    If strCodFpg = stlModalidades[intIndMod] Then
    Begin
      SetLength(arrIndMod, Length(arrIndMod) + 1);
      SetLength(arrDesMod, Length(arrDesMod) + 1);

      arrIndMod[Length(arrIndMod) - 1] := intIndMod;
      arrDesMod[Length(arrDesMod) - 1] := cbxModalidades.Items[intIndMod];
    End;
  End;

  Case Length(arrIndMod) Of
    0:   Result := -1;
    1:   Result := arrIndMod[0];
    Else Result := arrIndMod[Pred(fGetMenu('Selecione a Modalidade:', arrDesMod, 1, False, True))];
  End;
end;

function TfrmFatConfOrcamentos.fReceberFormaPagamento(strCodFpg: String; fltValor: Double;
                                                      strCodCar: String; intQtdPar: Integer): Boolean;
begin
  Result := False;
  pSetFocus(cbxModalidades);
  cbxModalidades.ItemIndex := fGetIndexModalidade(strCodFpg);

  If cbxModalidades.ItemIndex > -1 Then
  Begin
    If fPergunta('Confirma o recebimento da forma de pagamento "' +
       cbxModalidades.Text + '" no valor de ' + FormatFloat('R$ #,##0.00', fltValor) + ' ?') Then
    Begin
      strCodCarPed   := strCodCar;
      intQtdParPed   := intQtdPar;
      edtValor.Value := fltValor;
      Result         := fReceberModalidade;

      If Result Then
        pMensagemOk('Recebimento realizado com sucesso!');
    End;
  End;
end;

procedure TfrmFatConfOrcamentos.cdsModalidadesAfterPost(DataSet: TDataSet);
begin
  inherited;
  pMostraTotal;
  chkEndEnt.Visible := (fCfgSis('CUPEET') = 'S') And fTemModalidadeVinculado;

  If fCfgSis('CHKENT', varBoolean) Then
    chkEndEnt.Checked := chkEndEnt.Enabled;
end;

procedure TfrmFatConfOrcamentos.cdsModalidadesAfterDelete(
  DataSet: TDataSet);
begin
  inherited;
  pMostraTotal;
end;

procedure TfrmFatConfOrcamentos.pDestroiFrmCaixa;
begin
 strUltimoCodCndUsadoCaixa := '';
  If (cdsItensAdd.Active) And (cdsItensAdd.RecordCount > 0) Then
    strUltimoCodCndUsadoCaixa := frmCaixa.strCodCnd;

  pFreeAndNil(frmCaixa);
end;

procedure TfrmFatConfOrcamentos.pMostraTotal;
begin
  edtValDig.Value := IIF( TAggregateField(cdsModalidades.FieldByName('AGG_PAGO')).Value = Null, 0.00, TAggregateField(cdsModalidades.FieldByName('AGG_PAGO')).Value);
end;

procedure TfrmFatConfOrcamentos.pFinalizarFechamento(blnSucesso: Boolean; pgbStatus: TcxProgressBar);
  Var
    strMsg: String;
begin
  If (blnSucesso) Then
  Begin
    if (not fVerificaTravaColetor(strNumeroDoc)) then
    begin
      fLock_Unlock( 'FATGOR' + strNumeroDoc +
                   strEspCfo +
                   fEmpresaDocumento, False, False );

      fLock_Unlock( 'CADREC' + strNumeroDoc +
                   strEspCfo +
                   fEmpresaDocumento +
                   strClienteDoc, False, False );
    end;


    TravarRegistroDoPix(False);

    pDestravaDuplicatasCredito;
    strMsg := '';
    If (blnCancelarCFTef) Then
      strMsg := 'Venda Cancelada!'
    Else If blnRealizandoAdiantamentoPedidoPeloF11 Then
      strMsg := 'Adiantamento realizado com sucesso!'
    Else If blnImprimiuCupom Then
      strMsg := 'Venda realizada com sucesso!';

    blnJaValidouDocs := False;

    If edtValTro.Value > 0 Then
      strMsg := strMsg + #13#10 + 'TROCO: R$ ' + FloatToStrF(edtValTro.Value, ffFixed, 12, 2);

    pgbStatus.Position := pgbStatus.Properties.Max;
    pInformacao(strMsg, pgbStatus);

    If (fCfgSis('MSUF11', varBoolean)) And (Not fEmptyStr(strMsg)) Then
      fMensagem('', strMsg, ['&Ok']);

    pLimparTela;
    pnlCabecalho.Enabled := True;
    pnlComanda.Enabled := True;
    pnlOpcaoEmiFatOuAdto.Enabled := True;

    pnlCentral.Enabled := False;

    if (strEspCfo = 'PD') And fCfgSis('COMAND', VarBoolean) then
      pSetFocus(edtBarCom)
    else
      pSetFocus(edtNumOrc);

    pnlRodape.Enabled := False;
    btnAdicionarItens.Enabled := True;
  End
  Else
  Begin
    pgbStatus.Position := pgbStatus.Properties.Max;
    pInformacao('Operação não finalizada!', pgbStatus);
    pnlRodape.Enabled := True;
    btnAdicionarItens.Enabled := False;
  End;
end;

procedure TfrmFatConfOrcamentos.pFormasPagamentoNegociada;
begin
  If Not fEhRecebimentoFormasPagtoNegociadas Then
    Exit;

  With fatVenda, objFormasPagtoNegociada Do
  Begin
    objFormasPagtoNegociada.strNumeroDocumentoNegociado  := fatVenda.strNumOrc;
    objFormasPagtoNegociada.strEspecieDocumentoNegociado := fatVenda.strEspOrc;
    objFormasPagtoNegociada.strEmpresaDocumentoNegociado := fatVenda.strEmpDoc;

    If Not fRecebimentoFormasPagtoNegociadasF11(fStrToFloat(edtTotGer.Text),
                                                Self.fReceberFormaPagamento,
                                                Self.pAbrirGaveta) Then
    Begin
      If Not fCancelaModalidades Then
      Begin
        pFormasPagamentoNegociada;
        Exit;
      End;
    End
    Else
    Begin
      If rdbAdiantamentoPedido.Checked Then
        If fFormaPagtoSelecionada('012') Then
          fatVenda.strConPag := cdsFormasNegociadas.FieldByName('CONPAG').AsString;
      pConfirmaValorTotal;
    End;
  End;
end;

procedure TfrmFatConfOrcamentos.pGerarPDF;
begin
  untFuncoesOcorrenciasCRM.pGerarPDF(Concat(strNumeroDoc, strEspCfo, fEmpresaDocumento));
end;

procedure TfrmFatConfOrcamentos.dbgModalidadesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = Vk_Delete) And (Not cdsModalidades.IsEmpty) Then
  Begin
    If Not ValidarSeExistePixRecebidoSemConfirmacao(True) Then
    Begin
      Key := 0;
      Exit;
    End;

    pApagaModalidade;
    edtValTro.Value := 0;
    If cdsModalidades.IsEmpty Then
      pSetFocus(edtValor);
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    pSetFocus(edtValor);
  End;
end;

procedure TfrmFatConfOrcamentos.pApagaModalidade;
  Var
    qryAux: TUniQuery;
    intIdxCtr: Integer;
    intContador: Integer;
begin

  qryAux := fCriaQuery(Nil);

  If ((cdsModalidades.FieldByName('ECF_IDENTI').AsString = '2') Or (cdsModalidades.FieldByName('CODFPG').AsString = '002')) And
     (fCfgSis('CHQRCX') = 'S')                                 Then
  Begin
    If Assigned(cdsChequePre) Then
      cdsChequePre.EmptyDataSet;
  End

  Else If ((cdsModalidades.FieldByName('ECF_IDENTI').AsString = '4') Or (cdsModalidades.FieldByName('CODFPG').AsString = '006')) And
          (fCfgSis('CHQRCX') = 'S') And (fCfgSis('CHQVIS') = 'S')   Then
  Begin
    If Assigned(cdsChequeVis) Then
      cdsChequeVis.EmptyDataSet;
  End

  Else If ((cdsModalidades.FieldByName('ECF_IDENTI').AsString = '3') Or (cdsModalidades.FieldByName('CODFPG').AsString = '007')) And
          ((Not fUsaTef) OR (Pos('(POS)', cdsModalidades.FieldByName('DESMOD').AsString) > 0)) And (fCfgSis('DIGCAR') = 'S') Then
  Begin

    If (cdsModalidades.FieldByName('CODFPG').AsString = '016') Then
    Begin
      SetLength(arrCartFin, 0);
    End Else
    Begin
      intIdxCtr := cdsModalidades.FieldByName('IDXCRT').AsInteger;

      {*****************************************}
      {* REMOVO O CARTÃO DO VETOR.             *}
      {**************************************MV*}
      For intContador := intIdxCtr To Length(arrCartoes)-2 Do
      Begin
        arrCartoes[intContador] := arrCartoes[intContador+1];
      End;
      SetLength(arrCartoes, Length(arrCartoes)-1);
    End;
  End

  Else If (cdsModalidades.FieldByName('CODFPG').AsString = '013') Then
  Begin
    stlDupCreditos.Clear;
    fltTotCreditos := 0.0;
    fltCredUtilizados := 0.0;
  End;

  If (cdsModalidades.FieldByName('ECF_IDENTI').AsString <> '3') Or
     ((Not fUsaTef) Or
      (cdsModalidades.FieldByName('CODFPG').AsString = '016') Or
      (Pos('(POS)',cdsModalidades.FieldByName('DESMOD').AsString) > 0))  Then
  Begin
    cdsModalidades.Delete;
    {*********************************}
    {* ZERA TROCO PARA CHEQUE/CARTÃO *}
    {******************************AF*}
    pZeraOpcaoTrocoCheque;
  End;

  FreeAndNil(qryAux);
end;

procedure TfrmFatConfOrcamentos.btnEdiModClick(Sender: TObject);
begin
  inherited;
  If dbgModalidades.CanFocus Then
  Begin
    blnFocoGrid := True;
    pSetFocus(dbgModalidades);
    blnFocoGrid := False;
  End;
end;

procedure TfrmFatConfOrcamentos.btnEndEntClick(Sender: TObject);
  Var
    strSenha: String;
begin
  inherited;

  If Not btnEndEnt.Visible Then
    Exit;

  If fPedidoTemFazendaInformada Then
    Exit;

  If blnRealizandoAdiantamentoPedidoPeloF11 Then
  Begin
    pMensagemOk('Não é permitido quando realizando adiantamento de pedido!');
    Exit;
  End;

  If fValidaCampos(edtCodCli, True) And
     ffrmSenha(strSenha) And
     fVerificaAcessoSistema('ENENC', fRetCodVendedor(strSenha)) Then
  Begin
    If blnTemEntregaImediata Or blnTemEntregaFutura Or fatVenda.fImprimeEndEntregaItensRetira Then
    Begin
      objEndEnt.fAlteraEnderecoEntrega(True, edtCodCli.Text, False, False, False, False, True, fTipoFaturamentoSelec.strEspDoc);
      pEnderecoToTela(objEndEnt);
    End
    Else
      fMensagem('ATENÇÃO', 'Não é possível alterar o endereço, nenhum item de entrega imediata/futura encontrado!', ['&O k']);
  End;
end;

procedure TfrmFatConfOrcamentos.btnFatorServicoClick(Sender: TObject);
var
  frmFatFatorServico: TfrmFatFatorServico;
begin
  inherited;

  if not btnFatorServico.Visible then
    Exit;

  if not btnFatorServico.Enabled then
    Exit;

  pCriarFormularios(TfrmFatFatorServico, frmFatFatorServico);

  try
    frmFatFatorServico.ShowModal;
  finally
    pFreeAndNil(frmFatFatorServico);
  end;
end;

procedure TfrmFatConfOrcamentos.btnGerarPDFClick(Sender: TObject);
begin
  inherited;
  If btnGerarPDF.Enabled Then
    TfrmGravando.fExecutarModalA(Self.pGerarPDF, 'Aguarde... Gerando Arquivo (.PDF)', '');
end;

procedure TfrmFatConfOrcamentos.btnLerPinPadClick(Sender: TObject);
begin
  inherited;
  if not pnlRodape.Enabled then
  begin
    exit ;
  end ;

  if not fClienteConsumidor(fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [edtCodCli.Text])) then
  begin
    fMensagem('ATENÇÃO', 'Opção válida somente para cliente consumidor!', ['&O k']);
    exit ;
  end ;

  fChamaTelaGravando(fObtemDadoPinPad) ;

end;

procedure TfrmFatConfOrcamentos.btnMsgNotClick(Sender: TObject);
begin
  inherited;
  If blnRealizandoAdiantamentoPedidoPeloF11 Then
  Begin
    pMensagemOk('Não é permitido quando realizando adiantamento de pedido!');
    Exit;
  End;

  If btnMsgNot.Visible Then
    pPedeMensagemNota;
end;

procedure TfrmFatConfOrcamentos.btnNumSeriesClick(Sender: TObject);
begin
  inherited;
  If Not btnNumSeries.Visible Then
    Exit;

  fatVenda.objFatSerieItem.ChamouPeloCtrlF3DoCaixa := True;
  pAbreFormItensSeries;
  fatVenda.objFatSerieItem.ChamouPeloCtrlF3DoCaixa := False;
end;

procedure TfrmFatConfOrcamentos.pPedeMensagemNota;
Begin
  pCriarFormularios(TfrmFatMensagemNotaF11, frmFatMensagemNotaF11);
  If Assigned(frmFatMensagemNotaF11) Then
  Begin
    With frmFatMensagemNotaF11, qryFatGor Do
    Begin
      edtMens01.Text := arrMsgNot[1];
      edtMens02.Text := arrMsgNot[2];
      edtMens03.Text := arrMsgNot[3];
      edtMens04.Text := arrMsgNot[4];
      edtMens05.Text := arrMsgNot[5];

      If ShowModal = mrOk Then
      Begin
        arrMsgNot[1] := edtMens01.Text;
        arrMsgNot[2] := edtMens02.Text;
        arrMsgNot[3] := edtMens03.Text;
        arrMsgNot[4] := edtMens04.Text;
        arrMsgNot[5] := edtMens05.Text;
      End;
    End;

    FreeAndNil(frmFatMensagemNotaF11);
  End;

End;

procedure TfrmFatConfOrcamentos.cbxModalidadesChange(Sender: TObject);
begin
  inherited;
  if qryModalidades.Active then
    lblSomentePos.Visible := (blnSomentePos) and
                             (qryModalidades.Locate('FPG_CODIGO', stlModalidades[cbxModalidades.ItemIndex], [loCaseInsensitive]))
                             and (qryModalidades.FieldByName('ECF_IDENTI').AsString = '3');
end;

procedure TfrmFatConfOrcamentos.cbxModalidadesEnter(Sender: TObject);
begin
  inherited;
  pnlCabecalho.Enabled := False;
  pnlComanda.Enabled := False;
  pnlOpcaoEmiFatOuAdto.Enabled := False;
end;

procedure TfrmFatConfOrcamentos.edtCgcCpfChange(Sender: TObject);
begin
  inherited;
  If (edtCgcCpf.Text = '1') Then
  Begin
    lblRG_IES.Caption  := 'IES:';
    mskCgcCpf.Clear;
    mskCgcCpf.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_);
  End
  Else
  Begin
    lblRG_IES.Caption  := 'RG:';
    mskCgcCpf.Clear;
    mskCgcCpf.EditMask := '999.999.999-99;0;';
  End;
end;

procedure TfrmFatConfOrcamentos.edtCidEntKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If (Not edtCidEnt.ReadOnly) And fPesqCidade(Self, edtCidEnt, edtNomCid, nil, nil, Key, arrSel) Then
  Begin
    If (fValidaCampos(edtCidEnt, True)) Then
      SelectNext(ActiveControl, True, True);
  End;   

end;

procedure TfrmFatConfOrcamentos.pCarregaCadCid;
begin
  qryConCid.Close;
  qryConCid.SQL.Clear;
  qryConCid.SQL.Add('SELECT * FROM CADCID WHERE CID_CODCID = :CODCID ');
  qryConCid.ParamByName('CODCID').AsString := edtCidEnt.Text;
  qryConCid.Open;

  edtNomCid.Text := qryConCid.FieldByName('CID_NOMCID').AsString;
  edtUF.Text     := qryConCid.FieldByName('CID_ESTADO').AsString;  
end;

procedure TfrmFatConfOrcamentos.pLimparPainelStatus;
begin
  pnlInfo.Caption := '';
end;

procedure TfrmFatConfOrcamentos.pLimparArrCol;
begin
  TProQtdColetiva.pLimpar;
  TProQtdColetiva.OpcSys := tRegSysGeral;
  SetLength(ArrItemPro, 0);
end;

procedure TfrmFatConfOrcamentos.pLimparTela(blnLimpaItensAnteriores: Boolean = True);
begin
  if (not fVerificaTravaColetor(edtNumOrc.Text)) then
  begin
    fLock_Unlock( 'FATGOR' + edtNumOrc.Text +
                             strEspCfo +
                             fEmpresaDocumento, False, False );

    fLock_Unlock( 'CADREC' + edtNumOrc.Text +
                             strEspCfo +
                             fEmpresaDocumento +
                             edtCodCli.Text, False, False );
  end;

  pLimparArrCol;

  TravarRegistroDoPix(False);

  strSessaoTef := '';

  pZeraOpcaoTrocoCheque;
  Self.Enabled := True;
  btnGerarPDF.Enabled := False;
  cdsModalidades.EmptyDataSet;

  If blnLimpaItensAnteriores And cdsItensAdd.Active Then
    cdsItensAdd.EmptyDataSet;

  If (cdsVenda <> nil) Then
  Begin
    Try
      If cdsVenda.Active Then
        cdsVenda.Close;
      pFreeCdsVenda;
    Except

    End;
  End;

  if Assigned(objCdsVinculos) then
    FreeAndNil(objCdsVinculos);

  pClearFunctionsEventosCadPro;

  If Assigned(fatVenda) Then
    FreeAndNil(fatVenda);

  If Assigned(fatAgrupamento) Then
    FreeAndNil(fatAgrupamento);

  If Assigned(cdsIteCfo) Then
    FreeAndNil(cdsIteCfo);

  edtValor.Value := 0;
  cbxModalidades.ItemIndex := 0;

  pSetaVisibilidadeNetpoints;
  pSetaVisibilidadeNotaPaulista;

  edtCodCli.Clear;
  edtNomCli.Clear;
  edtCgcCpf.Clear;
  mskCgcCpf.Clear;
  mskNumR_G.Clear;
  edtEndEnt.Clear;
  edtEmail.Clear;
  edtBaiEnt.Clear;
  mskCepEnt.Clear;
  edtCidEnt.Clear;
  edtNomCid.Clear;
  edtUF.Clear;  

  edtTotGer.Clear;
  edtBarCom.Clear;
  edtNumOrc.Clear;
  edtCodFpg.Clear;
  edtCodPag.Clear;
  mskCndPag.Clear;  
  edtDesPag.Clear;
  edtNumParcelas.Clear;
  edtValDig.Value := 0;
  edtValTro.Value := 0;

  edtNotPau.Text := 'S';

  edtVolume.Text := '0';
  edtEspVol.Clear;  

  pCarregaMensagemPedido(True);

  pDefineEspecieDefault;

  SetLength(arrCartoes, 0);
  SetLength(arrCartFin, 0);

  qryFatGor.Close;

  cdsChequePre.EmptyDataSet;
  cdsChequeVis.EmptyDataSet;

  lblEntRet.Caption := '';

  stlDupCreditos.Clear;
  fltTotCreditos := 0.0;
  fltCredUtilizados := 0.0;

  lblCreditos.Visible := False;
  chkEndEnt.Checked   := False;

  If (Not edtCodEmp.Visible) Then
  Begin
    If (Not Assigned(edtCodEmpInf)) Then
    Begin
      edtCodEmpInf := TEditFocus.Create(Self);
      edtCodEmpInf.Name := 'edtCodEmpInf';
      edtCodEmpInf.Parent := edtCodEmp.Parent;
      CloneProperties(TControl(edtCodEmp), TControl(edtCodEmpInf));
      edtCodEmpInf.Visible := True;
      edtCodEmpInf.Enabled := False;
      edtCodEmpInf.Color       := $00FFDFB8;
      edtCodEmpInf.NormalColor := $00FFDFB8;
      edtCodEmpInf.FocusColor  := $00FFDFB8;
    End;
  End;


  edtCodEmp.Text := VS_strCodEmp;

  If blnTravaFaturamentoF11 Then
    edtCodEmp.Text := strEmpres;

  pSetarEdtCodEmpInformativo;

  If blnAltLoj And (fCfgSis('EMPF11', varString, strEmpLog) = EMPRESA_EM_BRANCO) And (fEmptyStr(strNumDocImportadoPedOrc)) Then
    edtCodEmp.Clear;

  edtCodTra.Clear;
  edtNomTra.Clear;  
  mskPlaFat.Clear;
  btnEndEnt.Visible := False;

  lblValAnt.Visible := False;

  lblVendedor.Visible := False;
  lblDesVend.Visible  := False;
  lblTipoFaturamento.Visible := False;

  btnAltCnd.Enabled := True;
  btnConfRetiraCaixa.Enabled := True;

  strInfErro := '';

  strConPag := '';

  strFpgOrc := '';
  strDigForPag := '';

  strEmlCon := '';

  strDigCodCnd := '';
  strDigConPag := '';

  strCliIes := '';

  SetLength(arrLogLib, 0);
  SetLength(arrLogAvi, 0);

  fltDesEspConcedido := 0;
  fltPorDesConcedido := 0;

  FillChar(objEndEnt.recEndere, SizeOf(objEndEnt.recEndere), #0);

  SetLength(FMatrizesDesmembramento, 0);
  blnDesmembrarVenda    := False;
  blnTemEntregaFutura   := False;
  blnTemEntregaImediata := False;
  blnTemRetiraOutraLoja := False;
  blnVendaOrigOutraLoja := False;
  blnTemRetiraMesmaLoja := False;
  blnTemRetiraExpedicao := False;
  blnTemRetiraBalcao    := False;
  blnTemItensEmpresaCD  := False;
  blnPedOrcMltLojUtiNps := False;
  btnFatorServico.Enabled := True;

  fltValorAdiantamentoPedidoPeloF11 := 0;
  strUltimoCodCndUsadoCaixa := '';

  TLogTef.blnExcedeuTempoTEF := False;

  shpRetISS.Visible := False;
  lblRetISS.Visible := False;
  blnChamouTelaTabelaPreco := False;
  btnNumSeries.Visible := False;

  FPedidoEntCd := False;
  FPedidoEmpCd := '';

  FDadosRetornoPix := '';
  FDadosRequisicaoPix := '';
  FObjetoRecebimentoPix := Nil;
  FblnTxIdPixRemovida := False;

  blnJaConsultouSituacaoRegularCliente := False;

  blnCarregouClienteConsumidor := False;

  pHabilitaDadosCliente(True);
end;

procedure TfrmFatConfOrcamentos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Not blnHabFormKeyDown) Then
  Begin
    Key := 0;
    Exit;
  End;

  If ((ActiveControl) = edtTipFat) Then
    pKeyDownTipFat(Key, Shift);

  If Assigned(ActiveControl) And (ActiveControl.Parent.Name = 'edtValor') And (Key = 27) Then
  Begin
    pSetFocus(cbxModalidades);
    Key := 0;
  End
  Else If Assigned(ActiveControl) And (ActiveControl.Parent.Name = 'edtValor') And (Key = 13) Then
  Begin
    TfrmGravando.fExecutarModalA(pReceberModalidade, 'Aguarde, Realizando Recebimento...', '');
    Key := 0;
  End
  Else If Assigned(ActiveControl) Then
  Begin
    If (ActiveControl.Parent = pnlCentral) Then
    Begin

      If (Key = VK_F5) Then
      Begin
        btnEdiMod.Click;
      End;

    End
    Else If (ActiveControl.Parent = pnlRodape) Or (pnlRodape.Enabled) Then
    Begin
      If (Key = VK_F10) Then
      Begin
        btnConfirma.Click;
      End;
    End;
  End
  Else If (Key = VK_F10) Then
    Key := 0;

  Case Key Of
    VK_F1: btnDuplicatas.Click;  
    VK_F2: btnEndEnt.Click;
    VK_F3: Begin
             If Shift = [ssCtrl] Then
               btnNumSeries.Click
             Else
               btnAdicionarItens.Click;
           End;
    VK_F6: btnMsgNot.Click;
    VK_F7: btnAltCnd.Click;
    VK_F8: btnGerarPDF.Click;
    VK_F9: btnConfRetiraCaixa.Click;
    VK_F11: Begin
              if btnLerPinPad.Visible then
              begin
                btnLerPinPad.Click;
              end ;
            end ;

    VK_F12: btnFatorServico.Click;
  End;

end;

procedure TfrmFatConfOrcamentos.btnAltCndClick(Sender: TObject);
begin
  inherited;

  If btnAltCnd.Enabled And btnAltCnd.Visible And
     pnlCabecalho.Enabled And qryFatGor.IsEmpty And cdsItensAdd.IsEmpty  Then
  Begin
    Try
      pCriarFormularios(TfrmFatAltCondPagtoPedido, frmFatAltCondPagtoPedido);

      frmFatAltCondPagtoPedido.ShowModal;

      If Not fEmptyStr(frmFatAltCondPagtoPedido.strUltimoPedido) Then
      Begin
        edtNumOrc.Text := frmFatAltCondPagtoPedido.strUltimoPedido;

        if (strEspCfo = 'PD') And fCfgSis('COMAND', VarBoolean) then
          pSetFocus(edtBarCom)
        else
          pSetFocus(edtNumOrc);

      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
    pFreeAndNil(frmFatAltCondPagtoPedido);
  End;

end;

procedure TfrmFatConfOrcamentos.pUpdate(const Parameters: array of String; AVisualizarProgresso: Boolean);
  const
    IDX_STATUS = 0;
    IDX_COR    = 1;
begin
  inherited;

  If IsThemeActive Then
    pnlInfo.StyleElements := pnlInfo.StyleElements - [seFont];

  If Parameters[IDX_STATUS].IsEmpty Then
  Begin
    pLimparPainelStatus;
    Exit;
  End;

  pnlInfo.Caption    := Parameters[IDX_STATUS];
  pnlInfo.Font.Color := IIF(Parameters[IDX_COR].Equals('VERMELHO'), clRed, clGreen);

end;

procedure TfrmFatConfOrcamentos.pUtilizarGrynCash(strCliCgc: String; fltTotGer: Double);
var
  objGryncash: TGryncash;
  key: Word;
begin
  if (fCfgSis('USAGRY') = 'S') then
  begin
    objGryncash := TGryncash.Create(fatVenda);
    try
      if objGryncash.fUserCashBackFundsOnStore(edtNomCli.Text, strCliCgc, blnCliGry, fltCshGry, fltTotGer) then
      begin
        if fltCshGry > 0 then
        begin
          blnHabFormKeyDown   := True;
          blnAdicionandoItems := False;
          blnEhCartaoGrynCash := blnCliGry;
          pSetFocus(edtValor);

          key := VK_RETURN;
          Self.OnKeyDown(Self, key, [ssShift]);
        end;
      end;
    finally
      FreeAndNil(objGryncash);
    end;
  end;
end;

function TfrmFatConfOrcamentos.fRecebimentoComPix: Boolean;
  Var
    LDadosPix : TUniClientDataSet;
    LDadosRequisicaoPixAVista : TDadosRequisicaoPixAVista;
    LDadosRetornoPix : String;
    LErro : String;
    LMensagem : String;
begin
  Result := False;

  LDadosPix := Nil;
  LDadosRequisicaoPixAVista := Nil;
  Try

    FObjetoRecebimentoPix := Nil;
    FDadosRetornoPix := '';
    FDadosRequisicaoPix := '';

    pRemovePixPedidoComValorParcial ;

    If (qryFatGor.FindField('FGO_TX_PIX') = Nil) Or
       (fTxPixVazia) Then
    Begin
      LDadosRequisicaoPixAVista := TFuncoesPixAutcom.RetornaDadosRequisicaoPedido(fatVenda,
                                                                                 fStrToFloat(edtValor.Text));

      LDadosRequisicaoPixAVista.TextoItemShipay := LDadosRequisicaoPixAVista.SolicitacaoPagador;
      LDadosRequisicaoPixAVista.UtilizaShipay := TPixDao.ChavePixUtilizaShipay(FAutoIncremChavePix);
      LDadosRequisicaoPixAVista.UtilizaTefScope := TPixDao.ChavePixUtilizaTefScope(FAutoIncremChavePix);
      LDadosRequisicaoPixAVista.TipoCobranca := 'instantanea';

      FDadosRequisicaoPix := TFuncoesPix.RetornaJsonDadosRequisicao(LDadosRequisicaoPixAVista);

      LDadosRetornoPix := TFuncoesPixAutcom.PagarPixViaQRCodeGerandoNovoPix(FAutoIncremChavePix,
                                                                            FDadosRequisicaoPix,
                                                                            FDadosRetornoPix,
                                                                            fatVenda.strCodCli,
                                                                            False,
                                                                            TFuncoesPixAutcom.RetornaChaveDaVenda(fatVenda, Self.Caption),
                                                                            fatVenda.fltTotGer);
    End
    Else
    Begin
      LDadosPix := TPixDao.RetornaDadosDoPix(qryFatGor.FieldByName('FGO_TX_PIX').AsString,
                                             qryFatGor.FieldByName('FGO_EMPPIX').AsString);

      If MatchStr(LDadosPix.FieldByName('MPX_STATUS').AsString, STATUS_PIX_PAGO) Then
        Raise ExceptionAutcom.Create('Esse QRCode já está recebido no Autcom.' + #13 +
                                     'Recarregue o pedido para atualizar os dados.');

      FDadosRequisicaoPix := LDadosPix.FieldByName('MPX_JSOENV').AsString;

      LDadosRetornoPix := TFuncoesPixAutcom.PagarPixViaPorQRCode(LDadosPix,
                                                                 Self.Name,
                                                                 True);
    End;

    LErro := TFuncoesPix.RetornaMensagemErroRequisicao(LDadosRetornoPix);
    If Not LErro.IsEmpty Then
      Raise ExceptionAutcom.Create(LErro);

    FDadosRetornoPix := LDadosRetornoPix;

    FObjetoRecebimentoPix := TFuncoesPix.RetornaDadosDoRetornoPixConsulta(FDadosRetornoPix,
                                                                          FDadosRequisicaoPix);

    Result := TFuncoesPixAutcom.PixPagoComValorOMesmoValorDaCobranca(FObjetoRecebimentoPix);

    If Result Then
    Begin
      FObjetoRecebimentoPix.JsonRetorno := FDadosRetornoPix;
      FObjetoRecebimentoPix.JSonRequisicao := FDadosRequisicaoPix;
      FObjetoRecebimentoPix.AutoIncremChavePix := FAutoIncremChavePix;
      FObjetoRecebimentoPix.RecebidoPeloF11 := 'S';
      FObjetoRecebimentoPix.CodigoDoCaixa := strCodigoCaixa;

      FObjetoRecebimentoPix.PlanoDeContas := fCfgSis('CTAPIX');
      If FObjetoRecebimentoPix.PlanoDeContas.IsEmpty Then
        FObjetoRecebimentoPix.PlanoDeContas := fCfgSis('CTATRA');

      If Assigned(LDadosPix) Then
      Begin
        If Not LDadosPix.IsEmpty Then
        Begin
          FObjetoRecebimentoPix.AutoIncremMovPix := LDadosPix.FieldByName('AUTOINCREM').AsString;
          FObjetoRecebimentoPix.CodigoPortador := LDadosPix.FieldByName('POR_CODPOR').AsString;
        End;
      End;

      If (qryFatGor.FindField('FGO_TX_PIX') = Nil) Or
         (fTxPixVazia) Then
      Begin
        If FObjetoRecebimentoPix.SolicitacaoPagador.IsEmpty Then
        Begin
          FObjetoRecebimentoPix.SolicitacaoPagador := LDadosRequisicaoPixAVista.SolicitacaoPagador;
          FObjetoRecebimentoPix.NomeDevedor := LDadosRequisicaoPixAVista.NomeDevedor;
          FObjetoRecebimentoPix.CPFCNPJDevedor := LDadosRequisicaoPixAVista.CPFCNPJDevedor;
        End;

        If FCondicaoPagamentoPixComCobrancaAnteriorExpirada Then
          fatVenda.DadosPixDaVenda.GerarPixDaVenda := False;
      End;

      fatVenda.DadosPixDaVenda.RecebidoPorPix := 'S';
      fatVenda.DadosPixDaVenda.LstPixPago.Add(FObjetoRecebimentoPix);
    End;

    If Not Result Then
    Begin
      LMensagem := 'O recebimento do Pix por QRCode não foi realizado. ';
      If (qryFatGor.IsEmpty) Or (fTxPixVazia) Then
        LMensagem := LMensagem + #13 + 'Assim o registro do Pix não foi gerado.';

      fMensagem('ATENÇÃO', LMensagem, ['&Ok']);
    End;
  Finally
    If Assigned(LDadosPix) Then
      FreeAndNil(LDadosPix);

    If Assigned(LDadosRequisicaoPixAVista) Then
      FreeAndNil(LDadosRequisicaoPixAVista);
  End;
end;

function TfrmFatConfOrcamentos.fRecebimentoComTransferenciaBancaria(fltValor: Double): Boolean;
begin
  Result := fVerificaAcessoSistema('PERRECF11MODOP', strCodOpe);
  If Not Result Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Permitir recebimento no F11 na modalidade "Ordem de Pagamento" com a opção de transferência bancária.');
    objLiberacao.objMsgLibera.pAddTexto('');
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente', fatVenda.strCodCli + ' - ' + fRetNomCliente(fatVenda.strCodCli), 35);
    objLiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ', fFormataCpfCgc(fatVenda.strCliCgc, fSetaPais), 35);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor', 'R$ '+FormatCurr(',0.00', fltValor), 35);

    objLiberacao.strDirAce := 'PERRECF11MODOP';
    objLiberacao.strMsgSen := 'Permitir recebimento no F11 na modalidade "Ordem de Pagamento" com a opção de transferência bancária.';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := strCodOpe;
    objLiberacao.strCodDig := strCodOpe;

    Result := objLiberacao.fLibera;
  End;
end;

function TfrmFatConfOrcamentos.AbreTelaParaPagamentoDoPix(AConfirmado: Boolean; fltValDig: Double;
  out APortadorOrdemPgto: String; out APixAvulso: String): Boolean;
  Var
    LTipoPagamento : TTipoOrdemPagamento;
    frmFatSelecionaTipoOrdemPagamento : TfrmFatSelecionaTipoOrdemPagamento;
begin
  Result := AConfirmado;

  APortadorOrdemPgto := EmptyStr;
  APixAvulso := JaRecebidoEmPixOuPixAvulso;

  If Not Result THen
    Exit;

  If RealizaPerguntaDoTipoDeOrdemDePagamento Then
  Begin
    pCriarFormularios(TfrmFatSelecionaTipoOrdemPagamento, frmFatSelecionaTipoOrdemPagamento);
    Try
      If APixAvulso.Equals('S') Then
      Begin
        frmFatSelecionaTipoOrdemPagamento.chkPixAvulso.Checked := True;
        frmFatSelecionaTipoOrdemPagamento.chkPixAvulso.Enabled := False;
      End;

      frmFatSelecionaTipoOrdemPagamento.ShowModal;

      LTipoPagamento := frmFatSelecionaTipoOrdemPagamento.TipoPagamento;

      If frmFatSelecionaTipoOrdemPagamento.chkPixAvulso.Checked Then
        APixAvulso := 'S';
    Finally
      pFreeAndNil(frmFatSelecionaTipoOrdemPagamento);
    End;
  End
  Else
    LTipoPagamento := RetornaTipoDePagamentoOrdemPix;

  Case LTipoPagamento Of
    tpoPix:
      Begin
        APixAvulso := 'N';

        Result := fRecebimentoComPix;
      End;

    tpoTransferencia:
      Begin
        If strCodEcf.IsEmpty Then
        Begin
          If cdsModalidades.Locate('CODFPG', '012', []) Then
          Begin
            fMensagem('ATENÇÃO', 'Essa modalidade já foi informada!', ['&Ok']);

            Exit(False);
          End;
        End;

        Result := fRecebimentoComTransferenciaBancaria(fltValDig);

        If Result Then
        Begin
          If fatVenda.FPortadorTFAutomatica.IsEmpty Then
            fatVenda.FPortadorTFAutomatica := objResumoDeCaixa.RetornaPortadorTFAutomatica;

          If objResumoDeCaixa.TransferenciaOrdemPagamentoAutomatica Then
            Result := Not fatVenda.FPortadorTFAutomatica.IsEmpty;

          APortadorOrdemPgto := fatVenda.FPortadorTFAutomatica;
        End;
      End;
  End;
end;

procedure TfrmFatConfOrcamentos.btnAdicionarItensClick(Sender: TObject);
  Var
    fltIssDes: Double;
    fltValRes: Double;
    strCndF11: String;
    strCliCodCnd: string;
    fltTotBri: Double;
    blnAbriuFechouTelaClienteSemAlterar: Boolean;
    blnRecalculaTaxCndF3ForcadoLocal: Boolean;
    LblnZerarDescontoDoItemRecalculoPrecos : Boolean;
    fltTaxJurCndAuxAnt,
    fltTaxJurCndAuxAtu: Double;
    frmDigCndPagamento : TfrmDigCndPagamento;
    strCodCliDuplic : String;
    blnNenhumaCndPagEncontrada:Boolean;

    function fVerificaSeItensTeraoModicacaoAposCondicaoPagamento : Boolean;
    begin
      Result := False;

      If fCfgSis('USACND', VarBoolean) And (Not frmCaixa.blnConcomitante) Then
      Begin
        Result := (fCfgSis('PROCXA', VarBoolean) And (fCfgSis('RECCND', varBoolean) Or fCfgSis('RECPRO', varBoolean))) //Verifica se vai entrar/sair de promoção
               Or (fCfgSis('CNDCXA', VarBoolean) And fCfgSis('RECCND', VarBoolean)) //Verifica se o unitário vai modificar
      End;
    end;

    procedure pVerificaAcionaVariaveisParaRecalculoPreco;
      Var
        blnItensEntraramOuSairamDePromocao: Boolean;
        blnItensTiveramUnitarModificados: Boolean;
        strMsg: String;
    begin
      If (fVerificaSeItensTeraoModicacaoAposCondicaoPagamento) And
         ((cdsItensAdd.Active) And (Not cdsItensAdd.IsEmpty)) Then
      Begin
        frmCaixa.pVerificaSeItensTeraoModificacaoAposCondicaoPagamento(blnItensEntraramOuSairamDePromocao,
                                                                       blnItensTiveramUnitarModificados);
        strMsg := '';

        If blnItensEntraramOuSairamDePromocao Then
          strMsg := 'Essa condição de pagamento pode alterar o valor da venda, pois ativa ou desativa uma promoção!'
        Else If blnItensTiveramUnitarModificados Then
          strMsg := 'Essa condição de pagamento pode alterar o valor da venda!';

        If (Not strMsg.IsEmpty) Then
        Begin
          frmCaixa.blnRecalcularPrecos := True;

          If (fMensagem('AVISO!', strMsg+#10#13+'Deseja manter os preços que constam na tela de check-out?', ['&Sim', '&Não']) = 2) Then
          Begin
            frmCaixa.blnManterPrecoDigitado := False;
          End
          Else
          Begin
            objLiberacao.Clear;
            objLiberacao.objMsgLibera.pAddTexto('Permitir manter os preços que constam na tela de check-out ao trocar uma condição de pagamento que está ativando ou desativando uma promoção.');
            objLiberacao.objMsgLibera.pAddTexto('');
            objLiberacao.objMsgLibera.pAddTextoCaption('Cliente', fatVenda.strCodCli + ' - ' + fRetNomCliente(fatVenda.strCodCli), 35);
            objLiberacao.objMsgLibera.pAddTextoCaption('Condição de pagamento escolhida', fatVenda.strCodCnd + ' - ' + fRetDesConPag(fatVenda.strCodCnd), 35);

            objLiberacao.strDirAce := 'ATIDESPRM';
            objLiberacao.strMsgSen := 'Não recalcular';
            objLiberacao.blnMosMen := True;
            objLiberacao.strCodOpe := strCodOpe;
            objLiberacao.strCodDig := strCodOpe;

            frmCaixa.blnManterPrecoDigitado := objLiberacao.fLibera;
          End;
        End;
      End;
    end;

    function fAbriuDigitouClienteValido: Boolean;
    Begin
      Result := True;
      blnCarregouClienteConsumidor := False;

      If fCfgSis('PCLF11', varBoolean) Then
      Begin
        pCriarFormularios(TfrmDigCliente, frmDigCliente);
        Try
          frmDigCliente.objVenda := fatVenda;
          frmDigCliente.blnChamadorF11 := True;
          frmDigCliente.blnPedDadosConsumidor := fCfgSis('EXCOCH', varBoolean);
          frmDigCliente.edtCodCli.Text := edtCodCli.Text;
          frmDigCliente.edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
          frmDigCliente.strCodCli := edtCodCli.Text;
          frmDigCliente.blnChamadaVeioDoF11 := True;
          frmDigCliente.blnPermiteVenderApenasDinheiroECartaoParaInativo := TFatVenda.fPermiteVenderApenasDinheiroECartaoParaInativo('11');

          If frmDigCliente.ShowModal = mrOk Then
          Begin
            If (Not fValidouConsultaSituacaoCadastral(frmDigCliente.edtCodCli.Text)) Then
            Begin
              fMensagem('ATENÇÃO!', Format(MSG_PAINEL_FECHADO_CONSULTA_CADASTRAL, [VS_strCodEmp]), ['&OK']);
              Result := False;
              Exit;
            End;

            edtCodCli.Text := frmDigCliente.edtCodCli.Text;

            If (fCfgSis('EXCOCH', varBoolean)) And (fClienteConsumidor(fRetNomCliente(edtCodCli.Text), False)) Then
            Begin
              With frmDigCliente.regConsum Do
              Begin
                edtCgcCpf.Text := IntToStr(intCgcCpf);
                mskCgcCpf.Text := strCliCgc;
                edtNomCli.Text := strCliNom;
                mskNumR_G.Text := strCli_Rg;
                mskCepEnt.Text := strCliCep;
                edtEndEnt.Text := strCliEnd;
                edtBaiEnt.Text := strCliBai;
                edtCidEnt.Text := strCodCid;
                edtUF.Text     := strCliEst;
                edtEmail.Text  := strCliEml;
              End;

              blnCarregouClienteConsumidor := True;
            End;

            Result := True;
          End  
          Else
          Begin
            Result := False;
          End;  
        Finally
          pFreeAndNil(frmDigCliente);
        End;
      End;
    End;        

    procedure pCarregaInformacoesCliente;
    begin
      If fCfgSisL('OBSF11', varBoolean) Then
        pMostraObsCliente(edtCodCli.Text);

      stlForPag.Clear;
      stlCndPag.Clear;
      pCarregaFormasPagto(edtCodCli.Text, stlForPag, stlCndPag);
      pCarregaFormasPagamento;
    end;

    function fPedeCliente: Boolean;
      Var
        strClienteJaInformado: String;
        blnValidouCliente : Boolean;
    begin
      Result := True;
      blnValidouCliente := False;

      If qryFatGor.IsEmpty Then
      Begin
        If (Assigned(fatVenda)) Then
        Begin
          If fClienteConsumidor(fRetNomCliente(fatVenda.strCodCli)) Then
          Begin
            If fAbriuDigitouClienteValido Then
            Begin
              If Not fClienteConsumidor(fRetNomCliente(edtCodCli.Text)) Then
              Begin
                Result := fValidaCampos(edtCodCli);

                If Not Result Then
                Begin
                  edtCodCli.Text := fatVenda.strCodCli;
                  Result := fValidaCampos(edtCodCli); 
                End;

                If Result Then
                Begin
                  fatVenda.strCodCli := edtCodCli.Text;
                  fatVenda.strCliOri := fRetNomCliente(edtCodCli.Text);
                  pCarregaInformacoesCliente;
                End;

                blnValidouCliente := True;
              End;  
            End
            Else
            Begin
              If ((cdsItensAdd.Active) And (Not cdsItensAdd.IsEmpty)) Then
                blnAbriuFechouTelaClienteSemAlterar := True;
            End;
          End
          Else If fCfgSis('PTCCKO', varBoolean) Then
            Result := fAbriuDigitouClienteValido;
        End
        Else
        Begin
          strClienteJaInformado := '';

          If Not fEmptyStr(strReloadCodCli) Then
          Begin
            strClienteJaInformado := strReloadCodCli;
            strReloadCodCli       := EmptyStr;
          End;

          {***************************************************************}
          {* SE JA PRESSIONOU O F3, INFORMOU CLIENTE E INFORMOU PRODUTOS *}
          {* NAO DEVE PERMITIR ALTERAR O CODIGO DO CLIENTE               *}
          {************************************************************JC*}
          If Assigned(fatVenda) And (Not fEmptyStr(fatVenda.strCodCli)) And
             (fAdicionouItensCheckout) Then
          Begin
            strClienteJaInformado := fatVenda.strCodCli;
          End;

          pLimparTela(False);

          If Not fIniciaFatVenda Then
          Begin
            Result := False;
            Exit;
          End;

          fatVenda.strEntFut := 'N';
          btnAltCnd.Enabled := False;
          btnConfRetiraCaixa.Enabled := False;

          edtCodCli.Text := fCfgSisL('CLIF11');

          If Not fEmptyStr(strClienteJaInformado) Then
            edtCodCli.Text := strClienteJaInformado;

          If fEmptyStr(edtCodCli.Text) Then
          Begin
            fMensagem('','Favor configurar o "cliente consumidor para F11" nas configurações do sistema!', ['&OK']);
            Result := False;
          End
          Else
          Begin
            If (fEmptyStr(strClienteJaInformado)) Or (fCfgSis('PTCCKO', varBoolean)) Then
              Result := fAbriuDigitouClienteValido;

            Result := Result And fValidaCampos(edtCodCli);

            If Result Then
              pCarregaInformacoesCliente;

            blnValidouCliente := True;
          End;
        End;
      End;

      If (Result) And (Not blnValidouCliente) Then
        Result := fValidaCampos(edtCodCli);

      If Result Then
      Begin
        pCarregaClienteVenda(fatVenda);

        If Result And (fatVenda.strRetPco = 'S') Then
        Begin
          fMensagem('', 'Cliente configurado para Reter Pis e Cofins. ' +#13+
                        'Necessário utilizar o módulo de Venda Normal!', ['&OK']);
          Result := False;
        End;

        If Result And (fatVenda.strRetIrf = 'S') Then
        Begin
          fMensagem('', 'Cliente configurado para Reter IRPJ. ' +#13+
                        'Necessário utilizar o módulo de Venda Normal!', ['&OK']);
          Result := False;
        End;

        If (Result) Then
        Begin
          If (fCfgSis('EXCCRC', varBoolean)) Then
            pMostraDebitosReceber(edtCodCli.Text);
        End;
      End;
    end;

    function fInformouCondicaoPagamento: Boolean;
    begin
      Result := True;
      blnNenhumaCndPagEncontrada := False;
      If fEmptyStr(strCndF11) Or fCfgSis('DCNF11', VarBoolean) Then
      Begin
        pCriarFormularios(TfrmDigCndPagamento, frmDigCndPagamento);
        frmDigCndPagamento.fraDigCndPagamento.pnlForPag.Visible := False;
        frmDigCndPagamento.Height := frmDigCndPagamento.Height - frmDigCndPagamento.fraDigCndPagamento.pnlForPag.Height;

        If (Assigned(fatVenda)) And (Not fEmptyStr(edtCodCli.Text)) Then
        Begin
          fatVenda.strCodCli := edtCodCli.Text;
          fatVenda.strCliOri := fRetNomCliente(edtCodCli.Text);
          frmDigCndPagamento.fraDigCndPagamento.strCodCli := edtCodCli.Text;
          frmDigCndPagamento.fraDigCndPagamento.strNomCli := fatVenda.strCliOri;
          frmDigCndPagamento.fraDigCndPagamento.fatVenda := fatVenda;
          strCliCodCnd := fCampoTabela('CND_CODCND', 'CLICND', ['CND_CODCLI', 'CND_SUGEST'], [edtCodCli.Text, 'S']);
        End;

        if (fEmptyStr(strCndF11)) and (not fEmptyStr(strCliCodCnd)) then
          strCndF11 := strCliCodCnd;

        If Not fEmptyStr(strCndF11) Then
        Begin
          If fCfgSis('USACND', VarBoolean) Then
          Begin
            frmDigCndPagamento.fraDigCndPagamento.edtCodCnd.Text := strCndF11;
            frmDigCndPagamento.fraDigCndPagamento.pCarregaCondicao;
          End
          Else
            frmDigCndPagamento.fraDigCndPagamento.mskCndPag.Text := strCndF11;
        End;

        frmDigCndPagamento.fraDigCndPagamento.blnRcx_F3 := True;

        frmDigCndPagamento.ShowModal;

        If frmDigCndPagamento.fraDigCndPagamento.blnConfirma Then
        Begin
          If (Not strUltimoCodCndUsadoCaixa.IsEmpty) Then
            blnMudouCondicaoPagamento := (frmDigCndPagamento.fraDigCndPagamento.edtCodCnd.Text <> strUltimoCodCndUsadoCaixa);
          strDigConPag := frmDigCndPagamento.fraDigCndPagamento.mskCndPag.Text;
          strDigCodCnd := frmDigCndPagamento.fraDigCndPagamento.edtCodCnd.Text;
          strDigForPag := frmDigCndPagamento.fraDigCndPagamento.edtForPag.Text;
          blnChamouTelaTabelaPreco := False;
          pCarregaTabelaDePrecoPorCnd;
        End
        Else
        Begin
          Result := False;
          blnNenhumaCndPagEncontrada := frmDigCndPagamento.fraDigCndPagamento.blnNenhumaCndPagEncontrada;
        End;

        pFreeAndNil(frmDigCndPagamento);
      End
      Else
      Begin
        If fCfgSis('USACND', VarBoolean) Then
        Begin
          strDigConPag := fRetConPagCodCnd(strCndF11);
          strDigCodCnd := strCndF11;
          If fCfgSis('USAFPG', varBoolean) Then
            strDigForPag := fRetForPagCodCnd(strCndF11);
        End
        Else
          strDigConPag := strCndF11;
      End;

      If qryFatGor.IsEmpty Then
      Begin
        fatVenda.strConPag := strDigConPag;
        If fCfgSis('USACND', VarBoolean) Then
          fatVenda.strCodCnd := strDigCodCnd;
        fatVenda.blnCndEsp := (fRetEspConPag(strDigCodCnd) = 'S');
        Self.strConPag     := strDigConPag;

        pAcertaDadosCondicaoPagamento(fatVenda);
        pCarregaTabelaDePrecoPorCnd;
      End;

    end;

    function fTravaDebitoCliente: Boolean;
    begin
      Result := False;

      If (fStatusCndPag(strDigConPag) <> A_VISTA) And (Assigned(fatVenda)) Then
      Begin
        If (Not fatVenda.fDebitoCliente(strDigForPag, strDigConPag, 2, 'F3')) Then
        Begin
          Result := True;
        End;
      End;
    end;

    function fTravaSeValorAbaixoMinimo: Boolean;
    Begin
      Result := False;

      If (fUsaPromocaoComSugestaoPrecoTabelaSemPedidoCarregadoComCondicaoNoFinal) Then
      Begin
        If fatVenda.fVerificaVrMinimo(fGetTotGer(fatVenda.fltTotGer), fGetTotGer(fatVenda.fltTotGer), fatVenda.intPrzMed) Then
          blnVerificouMinimo := True
        Else
          Result := True;
      End;
    End;

    procedure pCancelar;
    begin
      pFreeAndNil(frmCaixa);

      If Not fEmptyStr(edtNumOrc.Text) Then
      Begin
        if (not fVerificaTravaColetor(edtNumOrc.Text)) then
        begin
          fLock_Unlock( 'FATGOR' + edtNumOrc.Text +
                                   strEspCfo +
                                   fEmpresaDocumento, False, False );

          fLock_Unlock( 'CADREC' + edtNumOrc.Text +
                                   strEspCfo +
                                   fEmpresaDocumento +
                                   edtCodCli.Text, False, False );
        end;

        pDestravaDuplicatasCredito;
      End;

      pnlComanda.Enabled := True;
      pnlOpcaoEmiFatOuAdto.Enabled := True;
      pnlCabecalho.Enabled := True;
      pnlCentral.Enabled := False;

      if (strEspCfo = 'PD') And fCfgSis('COMAND', VarBoolean) then
        pSetFocus(edtBarCom)
      else
        pSetFocus(edtNumOrc);

      pLimparTela;
      pTrataWMS;
    end;

    procedure pReload;
    Begin
      strReloadCodCli     := fatVenda.strCodCli;
      cdsReloadItens.Data := cdsItensAdd.Data;

      pCancelar;

      tmrReload.Enabled   := True;
    End;

begin
  inherited;
  blnVerificouMinimo := False;
  blnNenhumaCndPagEncontrada := False;
  strCliCodCnd := '';
  blnHabFormKeyDown := False;
  blnMudouCondicaoPagamento := False;
  blnRecalculaTaxCndF3ForcadoLocal := False;
  blnRecalculaCdsVendaForcadoLocal := False;
  LblnZerarDescontoDoItemRecalculoPrecos := False;
  blnChamouTelaTabelaPreco := False;
  fltTaxJurCndAuxAnt := 0;
  Try
    If Not btnAdicionarItens.Enabled Then
      Exit;

    If fUsaRotinaWMS And blnRealizandoAdiantamentoPedidoPeloF11 And qryFatGor.IsEmpty Then
      rdbEmissaoFaturamento.Checked := True;

    If blnRealizandoAdiantamentoPedidoPeloF11 Then
    Begin
      pMensagemOk('Não é possível adicionar produtos quando realizando adiantamento de pedido!');
      Exit;
    End;

    If Not cdsModalidades.IsEmpty Then
    Begin
      pMensagemOk('Não é possível adicionar produtos, ' +
                  'pois já foram informadas as modalidades de pagamento!');
      Exit;
    End;

    If (Not qryFatGor.IsEmpty) And
       fDocumentoPossuiItemConcreto(fFatGor('NUMDOC').AsString,
                                    fFatGor('ESPDOC').AsString,
                                    fFatGor('CODEMP').AsString) Then
    Begin
      pMensagemOk('Não é possível adicionar produtos, ' +
                  'pois este ' + strTipoTitulo + ' possui itens concreto!');
      Exit;
    End;

    If (Not qryFatGor.IsEmpty) Then
    Begin
      If (Not fTxPixVazia) Then
      Begin
        pMensagemOk('Não é possível adicionar produtos quando o pedido possui Pix gerado!');
        Exit;
      End;

      If (fCfgSis('USAPIX', varBoolean)) And
         (fCampoTabela('CND_RECPIX', 'CADCND', ['CND_CODIGO'], [qryFatGor.FieldByName('FGO_CODCND').AsString]) = 'S') Then
      Begin
        pMensagemOk('Não é possível adicionar produtos quando a condição de pagamento do pedido for recebimento por Pix!' + #13 +
                    'Deve ser alterada a condição de pagamento.');
        Exit;
      End;
    End;

    If (Not fValidaCodAmzCaixa) Then
    Begin
      pMensagemOk('Sistema configurado para usar Armazém do CHECKOUT por Caixa, favor ajustar cadastro do Caixa.');
      Exit();
    End;

    strDigForPag := '';
    blnAdicionandoItems := True;

    strCndF11 := fCfgSis('CNDF11');

    Try

      blnAbriuFechouTelaClienteSemAlterar := False;
      If Not fPedeCliente Then
      Begin
        pnlCabecalho.Enabled := True;
        pnlComanda.Enabled := True;
        pnlOpcaoEmiFatOuAdto.Enabled := True;
        pnlCentral.Enabled := False;

        if (strEspCfo = 'PD') And fCfgSis('COMAND', VarBoolean) then
          pSetFocus(edtBarCom)
        else
          pSetFocus(edtNumOrc);

        pLimparTela;
        pTrataWMS();
        Exit;
      End;

      If blnAbriuFechouTelaClienteSemAlterar Then
      Begin
        Exit
      End;

      If Assigned(VS_objFiscal) Then
        VS_objFiscal.blnApenasItensCheckOutF11 := qryFatGor.IsEmpty;

      strDigCodVen := strCodOpe;

      pCriarFormularios(TfrmCaixa,frmCaixa);

      frmCaixa.cdsChkOut := FcdsChkOut ;
      frmCaixa.cdsLogChk := FcdsLogChk ;

      frmCaixa.qryCadCli := qryCadCli;
      frmCaixa.prcCarregaCliente := pCarregaCliente;
      frmCaixa.strOpeRcx := strCodOpe;
      frmCaixa.strEspCfo := strEspCfo;
      frmCaixa.strTabPre := strTabPrecoFat;
      frmCaixa.objCodBar := objCodBar;
      frmCaixa.strCodCaixa := strCodigoCaixa;
      frmCaixa.cdsIteCfo := cdsIteCfo;

      If Not qryFatGor.IsEmpty Then
      Begin
        frmCaixa.strCodCli := fFatGor('CODCLI').AsString;
        frmCaixa.strCodCnd := fFatGor('CODCND').AsString;
        frmCaixa.strConPag := fFatGor('CONPAG').AsString;
        frmCaixa.blnCndEsp := (fRetEspConPag(fFatGor('CODCND').AsString) = 'S');
        frmCaixa.strEstCli := fRetNomCidade(edtCidEnt.Text,1);
        frmCaixa.strAutFgo := fFatGor('AUTOINCREM').AsString;
        frmCaixa.funcaoDesconto := fRetornaDescontoEspecial;

        frmCaixa.pIniciaVenda;

        If Assigned(fatVenda) Then
          frmCaixa.pSetarTaxVpr(fatVenda.blnTaxVpr);

        If Not frmCaixa.fCarregaPedido Then
        Begin
          pFreeAndNil(frmCaixa);
          Exit;
        End;
      End
      Else
      Begin
        frmCaixa.blnConcomitante := (fCfgConcomitante) And
                                    (Assigned(VS_objFiscal)) And
                                    (Not fCfgSis('PAFECF', varBoolean)) And
                                    (Not fCfgSis('USNFCE', varBoolean)) And
                                    (Not fUsaSat);

        {********************************************************************}
        {* Caso pede a condicao de pagamento no inicio (antes dos produtos) *}
        {****************************************************************JC**}
        If fCfgSis('CND_F3') = 'I' Then
        Begin
          If fCfgSis('USACND', VarBoolean) Then
          Begin
            fltTaxJurCndAuxAnt := fCampoTabela('CND_TXJURO', 'CADCND', ['CND_CODIGO'], [fatVenda.strCodCnd]);
          End;   

          If Not fInformouCondicaoPagamento Then
          Begin
            If (cdsItensAdd.Active) And (cdsItensAdd.RecordCount > 0) Then
              pDestroiFrmCaixa
            Else
              pCancelar;

            Exit;
          End;

          If fCfgSis('USACND', VarBoolean) Then
          Begin
            fltTaxJurCndAuxAtu := fCampoTabela('CND_TXJURO', 'CADCND', ['CND_CODIGO'], [fatVenda.strCodCnd]);
            If (Assigned(fatVenda)) Then
            Begin
              frmCaixa.blnCalculaTaxCndF3InicioCx := (Not frmCaixa.blnConcomitante) And ((fltTaxJurCndAuxAtu > 0) Or (fltTaxJurCndAuxAtu <> fltTaxJurCndAuxAnt));
              fatVenda.blnCalculaTaxCndF3Inicio := frmCaixa.blnCalculaTaxCndF3InicioCx;
            End;
          End;

          If fTravaDebitoCliente Then
          Begin
            If (cdsItensAdd.Active) And (cdsItensAdd.RecordCount > 0) Then
              pDestroiFrmCaixa
            Else  
              pCancelar;

            Exit;
          End;
        End
        Else
        Begin
          fatVenda.pAtualizaInformacoesCondPagamento(Nil, True);
          strDigCodCnd := '';
          strDigConPag := '';
        End;

        frmCaixa.strCodCli := edtCodCli.Text;
        frmCaixa.strEstCli := fRetUFCliente(edtCodCli.Text);
        frmCaixa.strCodCnd := strDigCodCnd;
        frmCaixa.strConPag := strDigConPag;
        frmCaixa.blnCndEsp := (fRetEspConPag(strDigCodCnd) = 'S');

        If (Assigned(fatVenda)) Then
        Begin
          fatVenda.blnVendaPresencial := False;
          If fatVenda.fAtendeRegrasDifal(True) Then
            fatVenda.blnVendaPresencial := True;
          frmCaixa.blnVendaPresencialSemCarregarPedOrc := fatVenda.blnVendaPresencial;
        End;  

        frmCaixa.pIniciaVenda;
      End;

      If (Assigned(fatVenda)) Then
        fatVenda.blnOriF3 := True;

      frmCaixa.funcaoDesconto := fRetornaDescontoEspecial;

      If (cdsItensAdd.Active) And (Not cdsItensAdd.IsEmpty) Then
        frmCaixa.cdsItens.data := cdsItensAdd.Data
      Else
      Begin
        If (cdsReloadItens.Active) And (Not cdsReloadItens.IsEmpty) Then
        Begin
          frmCaixa.cdsItens.data := cdsReloadItens.Data;
          cdsReloadItens.EmptyDataSet;
        End;
      End;

      frmCaixa.stlItensPromoPorQtdMinQtdLim.Clear;
      frmCaixa.stlItensPromoPorQtdMinQtdLim.Text := Self.stlItensPromoPorQtdMinQtdLim.Text;
      TProQtdColetiva.pCopyArrItemPro(ArrItemPro, TProQtdColetiva.ArrItemPro);

      {**********************************}
      {* PREENCHE DADOS DO NOVO CLIENTE *}
      {* QUANDO FOR CONCOMITANTE        *}
      {*******************************FC*}
      If frmCaixa.blnConcomitante Then
      Begin
        VS_objFiscal.strCodCli  := edtCodCli.Text;
        VS_objFiscal.strNomCli  := edtNomCli.Text;
        VS_objFiscal.strEndCli  := edtEndEnt.Text;
        VS_objFiscal.strBaiCli  := edtBaiEnt.Text;
        VS_objFiscal.strCepCli  := mskCepEnt.Text;
        VS_objFiscal.strCidCli  := edtNomCid.Text;
        VS_objFiscal.strEstCli  := edtUF.Text;
        VS_objFiscal.strCgcCpf  := mskCgcCpf.Text;
        VS_objFiscal.strCpfClie := mskCgcCpf.Text;
        VS_objFiscal.strRG_Cli  := mskNumR_G.Text;
        VS_objFiscal.strIesCli  := strCliIes;
        VS_objFiscal.strTelCli  := strFone01;
        VS_objFiscal.strNomVen  := strCodOpe + '-' + fRetNomVendRep(strCodOpe);
      End;

      If Not fEmptyStr(edtCodCli.Text) And Not fValidarCanhotoNotaFiscalPendente(fatVenda) Then
      Begin
        pCancelar;
        Exit;
      End;

      If (Not blnRecalculaCdsVendaForcadoLocal) Then
      Begin
        If (Not fPedidoCarregado) And (fCfgSis('CND_F3') = 'I') Then
        Begin
          If (blnChamouTelaTabelaPreco) And
             (fatVenda.strTabPre <> strTabPrecoFat) And
             (Not fEmptyStr(fatVenda.strTabPre)) Then
          Begin
            If fMensagem('', 'A tabela de preço foi alterada. Deseja recalcular os preços dos itens ja inseridos?', ['&Sim', '&Não'], 2) = 1 Then
              frmCaixa.blnRecalcularPrecos := True;
          End
          Else If (Not fUsaPromocaoComSugestaoPrecoTabelaSemPedidoCarregado) Then
          Begin
            If (blnMudouCondicaoPagamento) Then
              pVerificaAcionaVariaveisParaRecalculoPreco;
          End;
        End;
      End;

      frmCaixa.blnDestroiObjetos := False;

      frmCaixa.blnUsaPromocaoComSugestaoPrecoTabelaSemPedidoCarregado := fUsaPromocaoComSugestaoPrecoTabelaSemPedidoCarregado;

      If Assigned(fatVenda) Then
        frmCaixa.objFatSerieItem := fatVenda.objFatSerieItem;

      If frmCaixa.ShowModal = mrOk Then
      Begin
        Self.stlItensPromoPorQtdMinQtdLim.Clear;
        Self.stlItensPromoPorQtdMinQtdLim.Text := frmCaixa.stlItensPromoPorQtdMinQtdLim.Text;
        TProQtdColetiva.pCopyArrItemPro(TProQtdColetiva.ArrItemPro, ArrItemPro);

        strDigCodVen := frmCaixa.fRetVenSugestao;

        If (Assigned(fatVenda)) Then
        Begin
          fatVenda.objCamGer.pAcrescentaExcecaoCampanha(frmCaixa.fItensExcecaoCampanha);

          If (fEmptyStr(fatVenda.strCodVen)) Then
            fatVenda.strCodVen := strDigCodVen;

          If (fEmptyStr(fatVenda.strTipVen)) Then
            fatVenda.strTipVen := fRetTipoOperador(fatVenda.strCodVen);
        End;

        If (Not fUsaPromocaoComSugestaoPrecoTabelaSemPedidoCarregadoComCondicaoNoFinal) Then
        Begin
          frmCaixa.pDestroiObjetos;

          cdsItensAdd.Data := frmCaixa.cdsItens.Data;
          oleItensVendaPedAdicionais := cdsVenda.Data;
        End;

        {******************************************************************}
        {* Caso pede a condicao de pagamento no Fim (depois dos produtos) *}
        {**************************************************************JC**}
        If qryFatGor.IsEmpty And (fCfgSis('CND_F3') = 'F') Then
        Begin
          If fCfgSis('USACND', VarBoolean) Then
          Begin
            fltTaxJurCndAuxAnt := fCampoTabela('CND_TXJURO', 'CADCND', ['CND_CODIGO'], [fatVenda.strCodCnd]);
          End;

          If Not fInformouCondicaoPagamento Then
          Begin
            pReload;
            Exit;
          End;

          If (Not blnVerificouMinimo) Then
          Begin
            fatVenda.pAtualizaInformacoesCondPagamento();

            If ((Not qryFatGor.Active) Or qryFatGor.IsEmpty) Then
              blnVerificouMinimo := fatVenda.fVerificaVrMinimo(fatVenda.fltTotGerAnt, fGetTotGer(fatVenda.fltTotGer), fatVenda.intPrzMed)
            Else If (fatVenda.fAumentouDesconto) Then
              blnVerificouMinimo := fatVenda.fVerificaVrMinimo(fatVenda.fltTotGerAnt, fGetTotGer(fatVenda.fltTotGer), fatVenda.intPrzMed);

            If (Not blnVerificouMinimo) Then
            Begin
              pReload;
              Exit;
            End;
          End;

          If fUsaPromocaoComSugestaoPrecoTabelaSemPedidoCarregadoComCondicaoNoFinal Then
          Begin
            frmCaixa.pSetaCondicaoDePagamento(fatVenda.strCodCnd);
            frmCaixa.pRecalculaPrecosSomenteItensPromo;
            frmCaixa.pTranfereDadosCdsChkOutCdsVendas;
            frmCaixa.pDestroiObjetos;

            cdsItensAdd.Data := frmCaixa.cdsItens.Data;
            oleItensVendaPedAdicionais := cdsVenda.Data;
          End;

          If fCfgSis('USACND', VarBoolean) Then
          Begin
            fltTaxJurCndAuxAtu := fCampoTabela('CND_TXJURO', 'CADCND', ['CND_CODIGO'], [fatVenda.strCodCnd]);
            blnRecalculaTaxCndF3ForcadoLocal := (Not frmCaixa.blnConcomitante) And ((fltTaxJurCndAuxAtu > 0) Or (fltTaxJurCndAuxAtu <> fltTaxJurCndAuxAnt));
          End;

          If fTravaDebitoCliente Then
          Begin
            pReload;
            Exit;
          End;

          While fTravaSeValorAbaixoMinimo Do
          Begin
            // Enquanto não informar nao sai dessa tela
          End;

          If fVerificaSeItensTeraoModicacaoAposCondicaoPagamento Then
          Begin
            If (fExecutouRecalculoPrecosCondPagto) Then
            begin
              blnRecalculaCdsVendaForcadoLocal := True;
            end;
          End;
        End;

        pVerificarUtilizacaoDoTecladoSEAT;

      End
      Else
      Begin
        frmCaixa.pDestroiObjetos;
        pCancelar;
        Exit;
      End;

      frmCaixa.pDestroiObjetos;

      {SE CFG_CNDPES = "S" E CASO A CONDIÇÃO FOR ESPECIAL, INDEPENDENTE DO LOCAL DA SOLICITAÇÃO (INICIO OU FINAL), FORÇAR O RECALCULO, ZERANDO OS DESCONTOS}
      if ((fatVenda.blnCondicaoEspecial) and (fatVenda.blnCndEsp)) then
      Begin
        if not fatVenda.fProdutoForaCondEsp(fatVenda.strCodCnd) then
        Begin
          LblnZerarDescontoDoItemRecalculoPrecos := True;
          blnRecalculaTaxCndF3ForcadoLocal       := True;
        End;
      End;

      strCodCliDuplic := '';
      If (Assigned(qryFatGor)) And (Not qryFatGor.IsEmpty) Then
        strCodCliDuplic := qryFatGor.FieldByName('FGO_CODCLI').AsString
      Else If (Assigned(fatVenda)) Then
        strCodCliDuplic := fatVenda.strCodCli;

      fltValAnt := TFatVenda.fTotalDuplicataQuitada(edtNumOrc.Text, strEspCfo, fRetornaCodigoDaEmpresa, strCodCliDuplic);
      fltValAdt := TAdiantamento.fGetTotaisAdiantamento(edtNumOrc.Text, strEspCfo, fRetornaCodigoDaEmpresa).fltValLan;

      If (Not qryFatGor.IsEmpty) And
         fClienteRetemISS(fFatGor('CODCLI').AsString) Then
      Begin
        fltIssDes := fFatGor('VALISS').AsFloat;
      End
      Else
        fltIssDes := 0;

      If (Not qryFatGor.IsEmpty) Then
        fltTotBri := fFatGor('TOTBRI').AsFloat
      Else
        fltTotBri := 0;

      {*********************************}
      {* VALIDA LIMITE DE CRÉDITO - F3 *}
      {******************************AF*}
      If Not fVerificaLimiteCredito(fatVenda.strConPag, fatVenda, (frmCaixa.fltTotGerCx - fltValAnt - fltIssDes - fltTotBri), 'LIM_F3') Then
      Begin
        If (qryFatGor.IsEmpty) And (cdsItensAdd.Active) And (cdsItensAdd.RecordCount > 0) Then
          pDestroiFrmCaixa
        Else  
          pCancelar;

        Exit;
      End;

      If frmCaixa.blnConcomitante Then
      Begin
        pSetaTipoFaturamento('IF');
        pHabilitaDadosCliente(False);
      End;

      fltDesEspConcedido := frmCaixa.fltDesEspCx;
      fltPorDesConcedido := frmCaixa.fltPorDesCx;

      If blnRecalculaTaxCndF3ForcadoLocal Or blnRecalculaCdsVendaForcadoLocal Then
      Begin
        fatVenda.pPreencheMatrizFechamento('', pOnPreencheMatrizItens);
        fatVenda.blnRecalculaTaxCndF3Forcado := True;
        {SÓ IRÁ PASSAR AQUI, QUANDO CND ESPECIAL PARA ZERAR OS DESCONTOS, E COND_F3 = I, ENTÃO NÃO É PRECISO CALCULAR OS JUROS NOVAMENTE}
        if ((fatVenda.blnCondicaoEspecial) and (fatVenda.blnCndEsp)) And (fCfgSis('CND_F3') = 'I') then
          fatVenda.pCalculaTotGer(LblnZerarDescontoDoItemRecalculoPrecos)
        Else
        Begin
          fatVenda.pCalculaTaxVpr;

          {CASO FOR COND ESPECIAL E CND_F3 = 'F', CALCULAR OS JUROS PORÉM RETIRAR OS DESCONTOS}
          if ((fatVenda.blnCondicaoEspecial) and (fatVenda.blnCndEsp)) And (fCfgSis('CND_F3') = 'F') then
            fatVenda.pCalculaTotGer(LblnZerarDescontoDoItemRecalculoPrecos)
          Else
            fatVenda.pCalculaTotGer;
        End;

        edtTotGer.Text := FloatToStrF(fatVenda.fltTotGer, ffFixed, 12, 2)
      End
      Else
        edtTotGer.Text := FloatToStrF(frmCaixa.fltTotGerCx - fltValAnt - fltValAdt - fltIssDes - fltTotBri, ffFixed, 12, 2);
        
      {**************************}
      {* CALCULA VALOR RESTANTE *}
      {***********************AF*}
      fltValRes := 0.0;
      If RoundTo(fStrToFloat(edtTotGer.Text), -2) > RoundTo(edtValDig.Value, -2) Then
        fltValRes := RoundTo(fStrToFloat(edtTotGer.Text) - edtValDig.Value, -2);

      edtValor.Value := fltValRes;

      If qryFatGor.IsEmpty Then
      Begin

        objEndEnt.fSelecionaEnderecoEntrega(edtCodCli.Text);
        pCarregaCliente(True);

        edtCodTra.Text := fCfgSisL('TRASUG');
        pCarregaTransportadora;

        lblEntRet.Caption := 'RETIRA';
        blnPrimeiraVendaTEF := True;

        pnlCentral.Enabled := True;
        pnlCabecalho.Enabled := False;
        pnlComanda.Enabled := False;
        pnlOpcaoEmiFatOuAdto.Enabled := False;

        If (Not fEmptyStr(strDigForPag)) Then
          cbxModalidades.ItemIndex := fGetIndexModalidade(strDigForPag);

        pDefineEspecieDefault;

        If fFreteValido(fCfgSis('TIPFRR')) Then
          cmbTipFre.ItemIndex := cmbTipFre.Properties.Items.IndexOf(fDescricaoFrete(fCfgSis('TIPFRR')));
      End;

      If Not fEmptyStr(frmCaixa.strCpfDigitado) Then
      Begin
        edtCgcCpf.Text := IntToStr(frmCaixa.intCgcCpfDigitado);
        mskCgcCpf.Text := frmCaixa.strCpfDigitado;
        fValidaCampos(mskCgcCpf);
      End;

      if (fCfgSis('PONQUE', varBoolean)) and (not cdsModalidades.Locate(cdsModalidadesDESMOD.AsString,'QUEST',[])) then
      begin
        If fMensagem('', 'Utilizar Quest Fidelidade?', ['&Sim', '&Não'], 2) = 1 Then
        begin
          pValidaQuestFidelidade(mskCgcCpf.Text, True);
        end
        else
        begin
          pValidaQuestFidelidade(mskCgcCpf.Text, False);
        end;
      end;

      if (not blnCliCon) and (not blnCliBal) then
        fVerificaSituacaoRegularCliente;

      {***************************************************}
      {* VERIFICA SE CLIENTE POSSUI CASHBACK NA GRYNCASH *}
      {*************************************************BL}
      blnCliGry := False;
      fltCshGry := 0;
      if fatVenda.fltTotGer > 0 then
        pUtilizarGrynCash(fatVenda.strCliCgc, fatVenda.fltTotGer);

      pSetFocus(cbxModalidades);
      pProcessMessages;

    Except
      On E: Exception Do
        pMensagensErro(E.Message,'');
    End;

    pDestroiFrmCaixa;

  Finally
    blnAdicionandoItems := False;
    blnHabFormKeyDown := True;
  End;
end;

procedure TfrmFatConfOrcamentos.btnConfirmaClick(Sender: TObject);
begin

  if (not btnConfirma.Enabled) then
    Exit;

  If Not Assigned(fatVenda) Then
  Begin
    pMensagemOk('Favor selecionar um documento para faturar ou adicionar itens!');
    Exit;
  End;

  {Na J_A_MASSA_CONCRETO não pode adiantar valores no pedido!}
  If (fCfgSis('TPNFCR') = J_A_MASSA_CONCRETO) And (blnRealizandoAdiantamentoPedidoPeloF11) And (Not qryFatGor.IsEmpty) Then
  Begin

    If fEhPedidoDeConcreto(qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                           qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                           qryFatGor.FieldByName('FGO_CODEMP').AsString) Then
    Begin
      pMensagemOk('Atenção!' + #13 +
                  'Não é permitido realizar adiantamento de Pedido de Concreto.' + #13 +
                  'O financeiro desta movimentação será gerado apenas na rotina "Confirmação de Nota Fiscal - Concreto", ao emitir a Nota de Serviço.');
      Exit;
    End;

  End;

  If Assigned(qryFatGor) And (qryFatGor.Active) Then
    If (fCfgSis('CDTCLV', varBoolean)) And
       (Assigned(fatVenda)) And
       (Pos(fatVenda.strEspDoc, 'PD_FF_IF_NF_') > 0) And
       (fExistePedidoNormalComCilindroVasilhameNaoFaturado(qryFatGor.FieldByName('FGO_SEQFGO').AsString)) Then
      Exit;

  fatVenda.cdsVinculos := objCdsVinculos;

  If Not fValidaCampos(edtNpsS_N, True) Then
    Exit;

  If Not fValidaCampos(edtNotPau, True) Then
    Exit;

  fatVenda.strNotPau := edtNotPau.Text;

  If (THorOpe.fExisteRestricoesDeAcesso(resVenda, True)) Then
    Exit;

  if not fConfirmaCTE then
    Exit;

  if Not fatVenda.fValidarValorEmissaoNFCePorEstado(edtTipFat.Text) then
    Exit;

  If InterlockedIncrement(intSemaforoConfirma) = 0 Then
  Begin
    Try
      if not fProcessaLogEnderecoEntrega then
      begin
        InterlockedDecrement(intSemaforoConfirma);
        Exit;
      end;

      pConfirmar;
    Except
      InterlockedDecrement(intSemaforoConfirma);
      Raise;
    End;
    InterlockedDecrement(intSemaforoConfirma);
  End
  Else
    InterlockedDecrement(intSemaforoConfirma);
end;

procedure TfrmFatConfOrcamentos.btnConfRetiraCaixaClick(Sender: TObject);
  Var
    strUltimoPedidoRetiradaCaixa: String;
begin
  inherited;
  If Not btnConfRetiraCaixa.Visible Then
    Exit;

  If Not btnConfRetiraCaixa.Enabled Then
    Exit;

  If Not pnlCabecalho.Enabled Then
    Exit;

  If Not qryFatGor.IsEmpty Then
    Exit;

  If Not cdsItensAdd.IsEmpty Then
    Exit;

  If Not fVerificaAcessoSistema('frmFatExpedicaoConferenciaRetiraCaixa', strCodOpe) Then
  Begin
    pMensagemOk('Usuário não tem permissão para acessar rotina de "' + btnConfRetiraCaixa.Hint + '"!');
    Exit;
  End;

  Try
    pCriarFormularios(TfrmFatExpedicao, frmFatExpedicao);
    Try
      frmFatExpedicao.blnApenasConferenciaProdutosRetiraCaixa := True;
      frmFatExpedicao.Caption := btnConfRetiraCaixa.Hint;
      frmFatExpedicao.ShowModal;
    Finally
      strUltimoPedidoRetiradaCaixa := frmFatExpedicao.strUltimoPedidoRetiradaCaixa;
      pFreeAndNil(frmFatExpedicao);
    End;

    if not fEmptyStr(strUltimoPedidoRetiradaCaixa) then
    begin
      edtNumOrc.Text := strUltimoPedidoRetiradaCaixa;
      fValidaCampos(edtNumOrc);
    end;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[]');
  End;
  
end;

procedure TfrmFatConfOrcamentos.btnDuplicatasClick(Sender: TObject);
  Var
    intCont: Integer;
    fltValDup: Double;
    arrValores: TDoubleArray;
    arrDupBkp : Array[0..23] Of TArrDigDuplic;
    dtaDtaBas : TDate;
    LblnUtilizarDataEmissaoCalcularDiaVencimento: boolean;
begin
  inherited;

  If (Not Assigned(qryFatGor)) Or (Not Assigned(fatVenda)) Then
  Begin
    pMensagemOk('Necessário carregar o documento antes de verificar as duplicatas!');
    Exit;
  End;

  With qryFatGor Do
  Begin
    If IsEmpty Then
      Exit;

    SetLength(arrValores, StrToIntDef(LeftStr(FieldByName('FGO_CONPAG').AsString, 2), 0));

    fltValDup := 0;

    If (fatVenda.strCodFpg = '009') Then
    Begin
      If cdsModalidades.Locate('CODFPG', '002', []) Then
        fltValDup := fltValDup + cdsModalidades.FieldByName('VALOR').AsFloat;

      If cdsModalidades.Locate('CODFPG', '008', []) Then
        fltValDup := fltValDup + cdsModalidades.FieldByName('VALOR').AsFloat;

      If cdsModalidades.Locate('CODFPG', '010', []) Then
        fltValDup := fltValDup + cdsModalidades.FieldByName('VALOR').AsFloat;
    End
    Else
    Begin
      For intCont := Low(arrValores) To High(arrValores) Do
        fltValDup := fltValDup + fatVenda.arrDuplicataCND[intCont].curValor ;
    End;

    If (fltValDup = 0) Then
    Begin
      For intCont := Low(arrValores) To High(arrValores) Do
        fltValDup := fltValDup + fatVenda.arrDuplicataCND[intCont].curValor ;
    End;
    
    For intCont := Low(fatVenda.arrDuplicata) To High(fatVenda.arrDuplicata) Do
      arrDupBkp[intCont] := fatVenda.arrDuplicata[intCont];

    dtaDtaBas := VS_Date;

    LblnUtilizarDataEmissaoCalcularDiaVencimento := fatVenda.fUtilizarDataEmissaoCalcularDiaVencimento ;
    {***************************************************************************************}
    {* UTILIZA A DATA DA EMISSÃO DO PEDIDO COMO BASE PARA CALCULO DA CONDIÇÃO DE PAGAMENTO *}
    {************************************************************************************PZ*}
    If (fUtilizarComoDataBaseCtrDataEmissaoPedido(fatVenda.fFaturandoPedido, LblnUtilizarDataEmissaoCalcularDiaVencimento)) Then
    Begin
      {**********************************************************************************************}
      {* CASO O PEDIDO ESTEJA SENDO FATURADO ANTECIPADAMENTE À DATA DE PREVISÃO, UTILIZAR ESSA DATA *}
      {*******************************************************************************************KM*}
      If (fUtilizarComoDataBaseCtrDataPrevisaoPedido(fatVenda.fFaturandoPedido)) And (fatVenda.dtaPreVis <> 0) And (VS_Date < fatVenda.dtaPreVis) Then
        dtaDtaBas := fatVenda.dtaPreVis
      Else
        dtaDtaBas := fatVenda.dtaDtaEntOri;
    End
    Else If fatVenda.fUtilizarDataPrvDataFatComoDataBaseParaCalculoVencimento Then
      dtaDtaBas := fRetDataBaseCalculoCondicaoPagto(fatVenda.dtaPreVis, fatVenda.fFaturandoPedido, fatVenda.dtaDtaEntOri, LblnUtilizarDataEmissaoCalcularDiaVencimento);

    fDigDuplic(fatVenda.arrDuplicata,
               FieldByName('FGO_CONPAG').AsString,
               0,
               fltValDup,
               True,
               False,
               False,
               dtaDtaBas,
               False,
               0,
               'N',
               False,
               False,
               0,
               False,
               arrValores,
               '',
               fCfgSis('FSDUDP', varBoolean),
               False,
               Nil,
               '',
               False,
               True,
               '',
               '',
               Nil,
               fatVenda.fFaturandoPedido,
               False, Nil, False, False, 0, '', fatVenda.strCodCid,
               '', False, LblnUtilizarDataEmissaoCalcularDiaVencimento);

    For intCont := Low(fatVenda.arrDuplicata) To High(fatVenda.arrDuplicata) Do
      fatVenda.arrDuplicata[intCont] := arrDupBkp[intCont];
  End;
end;

procedure TfrmFatConfOrcamentos.pConfirmar;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravandoFechamentoVenda);
    try
      If blnRealizandoAdiantamentoPedidoPeloF11 Then
      Begin
        frmGravandoFechamentoVenda.fExecutarAcao := fConfirmarAdiantamento;
        blnUsandoQuestFidelidade := False;
      End
      Else
      Begin
        frmGravandoFechamentoVenda.fExecutarAcao := fConfirmarVenda;
      End;

      frmGravandoFechamentoVenda.ShowModal;

      if (fCfgSis('PONQUE', varBoolean))and (blnUsandoQuestFidelidade) then
      begin
        pConfirmaTransacaoQuest(strAutIncQuest, strNumDocQuest, strEspDocQuest);
      end;
    finally
      pFreeAndNil(frmGravandoFechamentoVenda);
    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
end;

function TfrmFatConfOrcamentos.fConverteCodigoBarrasEmNumeroDocumento: Boolean;
Var
  strDocBar: String;
  strEspBar: String;
  strEmpBar: String;
begin
  Result := False;

  Try
    If (Length(edtNumOrc.Text) = 18) Then
    Begin
      pConverteCodigoBarrasDocumento(edtNumOrc.Text, strDocBar, strEspBar, strEmpBar);

      If (fEmptyStr(strEspBar)) Then
      Begin
        fMensagem('', 'Não foi possível identificar a Espécie do Documento!', ['&O k']);
      End
      Else If (Not (SameText(strEspBar, strEspCfo))) Then
      Begin
        fMensagem('', 'Código de Barras de Documentos de Espécie ' + strEspBar + ' não é permitido!', ['&O k']);
      End
      Else If (Not blnAltLoj) And (Not (SameText(strEmpBar, VS_strCodEmp))) Then
      Begin
        fMensagem('', 'Não é permitido faturar ' + strTipoTitulo + ' de outra Empresa.' + #13#10 +
                      'Empresa deste Documento: '  + strEmpBar + '.', ['&O k']);
      End
      Else
      Begin
        edtNumOrc.Text := strDocBar;
        edtCodEmp.Text := strEmpBar;
        pSetarEdtCodEmpInformativo;
        Result := True;
      End;
    End
    Else
      Result := True;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmFatConfOrcamentos.fConverteCodigoBarrasEmNumeroDocumento]');
  End;
end;

function TfrmFatConfOrcamentos.fConfirmarVenda(pgbStatus: TcxProgressBar = nil): Boolean;
  Const
    INT_PROGRESSO_MAX = 14;
  Var
    intProgresso: Integer;
    blnFechouVenda: Boolean;
    strConPagBkp: String;

    objMovimentacao : TMovimentacaoProgramadaCaixa;
    fltTotalCreditosCliente : Double;

  function fRetMsgSEAT : String;
  begin

    Result := 'Permitir realizar faturamento no F11 do Resumo de Caixa sem receber a avaliação do teclado de satisfação da Seat[DOC]';

    If Not fEmptyStr(edtNumOrc.Text) Then
      Result := Result.Replace('[DOC]', IIF(fCfgSis('ESPCFO', VarString) = 'PD', ' Pedido:', ' Orçamento:') + edtNumOrc.Text + '-' + strEspCfo + '-' + fEmpresaDocumento)
    Else
      Result := Result.Replace('[DOC]', '.');

  end;

begin
  inherited;

  Result := false;

  intProgresso := 0;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Iniciando Fechamento Venda...', pgbStatus);

  Self.Enabled := False;
  btnConfirma.Enabled := FAlse;
  btnSair.Enabled := False;

  pProcessMessages;
  Sleep(20);

  If (fCampoTabela('FGO_JAFATU', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [edtNumOrc.Text, strEspCfo, fEmpresaDocumento]) = 1) Then
  Begin
    If fatVenda.blnGravouDocumentos Then //funcfat já estava instanciada e já tinha gravado um documento, ou seja, pLimparTela falhou
    Begin
      pMensagemOk('Esse '+IIF(strEspCfo = 'OR', 'orçamento', 'pedido')+' já foi faturado!');
      Self.Enabled := True;
      btnConfirma.Enabled := True;
      btnSair.Enabled := True;
      Exit;
    End;
  End;

  If (fCfgSis('TEFEXC', varBoolean)) And (TLogTef.blnExcedeuTempoTEF) Then
  Begin
    fMensagem('ATENÇÃO!', MSG_TEF_EXCEDEU_TEMPO, ['&OK']);
    Self.Enabled := True;
    btnConfirma.Enabled := True;
    btnSair.Enabled := True;
    Exit;
  End;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Validando estado (UF) do cliente...', pgbStatus);

  If ((strEstCliAnt <> fRetNomCidade(fRetCidCliente(edtCodCli.Text),1)) And (blnMudouCodCli)) Then
  Begin
    pMensagemOk('O cliente deve ser do estado: ' + strEstCliAnt + '!');
    Self.Enabled := True;
    btnConfirma.Enabled := True;
    btnSair.Enabled := True;
    Exit;
  End;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Validando cliente estoque externo ...', pgbStatus);

  If Result And (Not fatVenda.fValidarClienteEstoqueExterno(edtCodCli.Text)) Then
  Begin
    Self.Enabled := True;
    btnConfirma.Enabled := True;
    btnSair.Enabled := True;
    Exit;
  End;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Verificando Cliente Filial...', pgbStatus);

  If blnCliFil Then
  Begin
    fMensagem('ATENÇÃO!', 'Cliente Filial não é permitido nessa operação!', ['&Ok']);
    Self.Enabled := True;
    btnConfirma.Enabled := True;
    btnSair.Enabled := True;
    Exit;
  End;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Validando Tipo de Faturamento...', pgbStatus);

  If (Not fValidaCampos(edtTipFat)) Then
  Begin
    Self.Enabled := True;
    btnConfirma.Enabled := True;
    btnSair.Enabled := True;
    Exit;
  End;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Validando Cidade de Entrega...', pgbStatus);

  If (Not fValidaCampos(edtCidEnt)) Then
  Begin
    Self.Enabled := True;
    btnConfirma.Enabled := True;
    btnSair.Enabled := True;
    Exit;
  End;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Validando Transportadora...', pgbStatus);

  If (Not fValidaCampos(edtCodTra, False)) Then
  Begin
    Self.Enabled := True;
    btnConfirma.Enabled := True;
    btnSair.Enabled := True;
    Exit;
  End;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Validando Placa...', pgbStatus);

  If (Not fValidaCampos(mskPlaFat)) Then
  Begin
    Self.Enabled := True;
    btnConfirma.Enabled := True;
    btnSair.Enabled := True;
    Exit;
  End;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Validando Tipo de Frete...', pgbStatus);

  If (Not fValidaCampos(cmbTipFre)) Then
  Begin
    Self.Enabled := True;
    btnConfirma.Enabled := True;
    btnSair.Enabled := True;
    Exit;
  End;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Validando CGC/CPF do cliente...', pgbStatus);

  If (Not fValidaCampos(mskCgcCpf)) Then
  Begin
    Self.Enabled := True;
    btnConfirma.Enabled := True;
    btnSair.Enabled := True;
    Exit;
  End;

  If (Not fVerificaSituacaoRegularCliente) Then
  Begin
    Self.Enabled := True;
    btnConfirma.Enabled := True;
    btnSair.Enabled := True;
    Exit;
  End;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Validando Permissão Emitir Documento...', pgbStatus);

  If (Not Assigned(qryCadCli)) Or (Not qryCadCli.Active) Then
  Begin
    pMensagemOk('As informações do cliente não foram carregadas corretamente. Saia da tela e entre novamente!');
    Self.Enabled := True;
    btnConfirma.Enabled := True;
    btnSair.Enabled := True;
    Exit;
  End;

  fatVenda.blnPermFF := ((qryCadCli.FieldByName('CLI_PERMFF').AsString = 'S') Or (qryCadCli.FieldByName('CLI_PERMFV').AsString = 'S'));    
  If (fTipoFaturamentoSelec.strEspDoc = 'FF') Then
  Begin
    If (Not fatVenda.fPermiteEmissaoFFPeloCadastrosDoCliente(True)) Then 
    Begin
      Self.Enabled := True;
      btnConfirma.Enabled := True;
      btnSair.Enabled := True;
      Exit;
    End;
  End;

  If (fCfgSis('REGCID', varBoolean)) And (fCfgSis('ESPCFO', varString) = 'PD') Then
  Begin
    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Validando Permissão Rota...', pgbStatus);
    If Not fValidarControleRotasRegioesCidades(fatVenda) Then
    Begin
      Self.Enabled        := True;
      btnConfirma.Enabled := True;
      btnSair.Enabled     := True;
      Screen.Cursor       := crDefault;
      Exit;
    End;
  End;

  If Assigned(fatVenda) And (Not fatVenda.fValidarClientePermiteFaturamentoDiaSemana(edtCodCli.Text, objLiberacao)) Then
  Begin
    Self.Enabled        := True;
    btnConfirma.Enabled := True;
    btnSair.Enabled     := True;
    Screen.Cursor       := crDefault;
    Exit;
  End;

  If TFatVenda.fTravarVendaClientePessoaFisica(edtCodCli.Text, edtCgcCpf.Text) Then
  Begin
    Self.Enabled := True;
    btnConfirma.Enabled := True;
    btnSair.Enabled := True;
    Exit;
  End;

  Screen.Cursor := crHourGlass;

  If (Not pnlRodape.Enabled) Then
  Begin
    Self.Enabled := True;
    btnConfirma.Enabled := True;
    btnSair.Enabled := True;
    Screen.Cursor := crDefault;
    Exit;
  End;

  If fVerificaSeImpNFAvulsa(fRetEspecieSelecionada, IIF(SameText(fCfgSis('ESPCFO'), 'PD'), teConfirmacaoPD, teEmissaoNF)) Then
  Begin
    Self.Enabled := True;
    btnConfirma.Enabled := True;
    btnSair.Enabled := True;
    Screen.Cursor := crDefault;
    Exit;
  End;

  If Assigned(objTecladoSEAT) And TTecladoSEAT.fUtilizaIntegracaoComTecladoDeSatisfacaoSEAT(oaCaixa) Then
  Begin

    If (objTecladoSEAT.Status in [stDefault, stAvaliando]) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto(fRetMsgSEAT);
      objLiberacao.strDirAce := 'DIRTECSEAT';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      If Not objLiberacao.fLibera Then
      Begin
        Self.Enabled        := True;
        btnConfirma.Enabled := True;
        btnSair.Enabled     := True;
        Screen.Cursor       := crDefault;
        Exit;
      End;
      objTecladoSEAT.pDesligarMonitoramento(True);
    End;
  End;

  If (fFormataFloat(edtValTro.Value, 2) > 0) And
     (fFormataFloat(edtValTro.Value, 2) > fFormataFloat(objResumoDeCaixa.fRetornaSaldoCaixaCampo('RCX_DINREC', strCodigoCaixa, strEmpLog), 2)) Then
  Begin
    Self.Enabled := True;
    btnConfirma.Enabled := True;
    btnSair.Enabled := True;
    Screen.Cursor := crDefault;
    fMensagem('', 'Saldo em caixa insuficiente para esse valor de troco!', ['&Ok']);
    Exit;
  End;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Validando os créditos selecionados...', pgbStatus);

  fltTotalCreditosCliente := fGetTotalCreditosCliente(edtCodCli.Text);
  If (fCfgSis('OBRCRE', varBoolean) And
     ((fFormataFloat(fltTotalCreditosCliente, 2) > fFormataFloat(fltTotCreditos, 2)) and
      (fFormataFloat(fStrToFloat(edtTotGer.Text), 2) > fFormataFloat(fltTotCreditos, 2)))) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.strMsgSen := 'Permitir faturamento sem utilização de Créditos.';
    objLiberacao.strDirAce := 'OBRCRE';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.objMsgLibera.pAddTexto('Permitir faturamento sem utilização de Créditos.');
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'            , edtCodCli.Text + ' - ' + edtNomCli.Text, 13);
    objLiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ'           , fFormataCpfCgc(fatVenda.strCliCgc, fSetaPais), 13);
    objLiberacao.objMsgLibera.pAddTextoCaption('Nome Fantasia'      , fRetNomFantasia(edtCodCli.Text), 13);
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor da Venda' , FloatToStrF(fStrToFloat(edtTotGer.Text), ffFixed, 12, 2) , 28, alDireita, teAmbos, '', 12);
    objLiberacao.objMsgLibera.pAddTextoCaption('Total de Crédito' , FloatToStrF(fltTotalCreditosCliente, ffFixed, 12, 2) , 28, alDireita, teAmbos, '', 12);
    objLiberacao.objMsgLibera.pAddTextoCaption('Total de Crédito Selecionado' , FloatToStrF(fltTotCreditos, ffFixed, 12, 2) , 28, alDireita, teAmbos, '', 12);

    If Not objLiberacao.fLibera Then
    Begin
      Self.Enabled        := True;
      btnConfirma.Enabled := True;
      btnSair.Enabled     := True;
      Screen.Cursor       := crDefault;
      Exit;
    End;
  End;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguardando confirmação da venda...', pgbStatus);

  If (fMensagem('', 'Confirma venda?', ['&Sim', '&Não']) = 2) Then
  Begin
    Self.Enabled := True;
    btnConfirma.Enabled := True;
    btnSair.Enabled := True;
    Screen.Cursor := crDefault;
    Exit;
  End;

  if fCfgSis('ENTSAI', varBoolean) then
  begin
    if (Pos(fTipoFaturamentoSelec.strEspDoc, 'NF_NS_EL_') > 0) then
    begin
      try
        pCriarFormularios(TfrmFatInfDataHora, frmFatInfDataHora);
        if frmFatInfDataHora.ShowModal = mrOk then
        begin
          fatVenda.FdtaDtEsNf := frmFatInfDataHora.dtaDataSaida;
          fatVenda.FtmrHrEsNf := frmFatInfDataHora.tmeHoraSaida;
          fatVenda.strDtaAtu  := DateToStr(fatVenda.FdtaDtEsNf);
          fatVenda.strHorSai  := TimeToStr(fatVenda.FtmrHrEsNf);
        end;
      finally
        pFreeAndNil(frmFatInfDataHora);
      end;
    end;
  end;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);

  pInformacao(MSG_AGUARDE_REALIZANDO_FECHAMENTO_VENDA, pgbStatus);

  blnFechouVenda    := False;
  blnGravouArquivos := False;

  intProgresso := INT_PROGRESSO_MAX;

  Try
    pDesabilitaCamposAntesFechamento;

    strConPagBkp := fatVenda.strConPag;

    blnFechouVenda := fFecharVenda(pgbStatus);

    If (blnFechouVenda) And (rdbEmissaoFaturamento.Checked) Then
      pValidaTicketEstacionamento;

    if blnFechouVenda then
      if not cdsItensChkOut.IsEmpty then
        pDesfazCheckoutTemp(cdsItensChkOut, True);

    if (fCfgSis('FATAUT', varBoolean)) then
    begin
      if (blnFechouVenda) And (not fEmptyStr(edtNumOrc.Text)) And (strEspCfo = 'PD') then
      begin
        pMarcarDataExpedicaoFaturamentoAutomatico('','','','',VS_Date,
                                                  fatVenda.strNumOrc,
                                                  fatVenda.strEspOrc,
                                                  fatVenda.strEmpOri);
      end;
    end;

    If (blnFechouVenda) And Assigned(objTecladoSEAT) And TTecladoSEAT.fUtilizaIntegracaoComTecladoDeSatisfacaoSEAT(oaCaixa) Then
    Begin
      If (objTecladoSEAT.Status in [stConcluiu, stFalhou]) Then
      Begin
        If Assigned(fatVenda.cdsDocGer) And (fatVenda.cdsDocGer.RecordCount > 1) Then
        Begin
          fatVenda.cdsDocGer.First;
          While Not fatVenda.cdsDocGer.Eof Do
          Begin
            objTecladoSEAT.pSetNumDoc(fatVenda.cdsDocGer.FieldByName('NUMDOC').AsString);
            objTecladoSEAT.pSetEspDoc(fatVenda.cdsDocGer.FieldByName('ESPDOC').AsString);
            objTecladoSEAT.pSetEmpDoc(fatVenda.cdsDocGer.FieldByName('CODEMP').AsString);
            objTecladoSEAT.fGravarAvaliacao;
            fatVenda.cdsDocGer.Next;
          End;
        End
        Else
        Begin
          objTecladoSEAT.pSetNumDoc(fatVenda.strNumDoc);
          objTecladoSEAT.pSetEspDoc(fatVenda.strEspDoc);
          objTecladoSEAT.pSetEmpDoc(VS_strCodEmp);
          objTecladoSEAT.fGravarAvaliacao;
        End;
      End;
    End;

    If (blnFechouVenda And
        fUsaRotinaWMS  And
        TPickingCheckOut.fWMSUtilizaPickingCheckOut) Then
    Begin

      TPickingCheckOut.pApagarLotDor(fatVenda.strNumOrc,
                                     fatVenda.strEspOrc,
                                     fRetornaCodigoDaEmpresa);

      If TPickingCheckOut.fWMSUtilizaPickingCheckOutEMovimentacaoProgramada Then
      begin
        objMovimentacao := TMovimentacaoProgramadaCaixa.Create('');
        try
          Try
            objMovimentacao.pSetItensCaixa(cdsVenda);
            objMovimentacao.fRealizaMovimentos;
          Except
            On E : Exception Do
              fMensagem('', E.Message, ['&OK']);
          End;
        finally
          FreeAndNil(objMovimentacao);
        end;
      end;

    End;

    pFinalizarFechamento(blnFechouVenda, pgbStatus);

  Finally
    blnVerificouMinimo := False;

    If (fCfgSis('PONQUE', varBoolean)) and (not blnFechouVenda) Then
    begin
      fltValorPonto := 0;
      fltValorDinheiro := 0;
      blnVaiResgatarQuest := False;
      strCpfCnpjClienteQuest := '';
      strNumDocQuest := '';
      strEspDocQuest := '';
      blnEhCartaoQuest := False;
    end;

    pHabilitarCamposAposFechamento(blnFechouVenda);

    If (Not blnFechouVenda) And (Assigned(fatVenda)) Then
      fatVenda.strConPag := strConPagBkp;

    If blnFechouVenda Then
    begin
      blnRecalculaCdsVendaForcadoLocal := False;
      pTrataWMS;
    end ;
  End;

end;

function TfrmFatConfOrcamentos.fConfirmarAdiantamento(pgbStatus: TcxProgressBar = nil): Boolean;

  procedure pHabilitarTela(blnHab: Boolean);
  begin
    Self.Enabled := blnHab;
    btnConfirma.Enabled := blnHab;
    btnSair.Enabled := blnHab;

    If blnHab Then
      Screen.Cursor := crDefault;
  end;

begin
  inherited;

  Result := False;

  pgbStatus.Position := 0;
  pgbStatus.Properties.Max := 0;
  pgbStatus.Visible := False;

  pInformacao('Aguarde, Iniciando adiantamento...', pgbStatus);

  pHabilitarTela(False);

  pProcessMessages;
  Sleep(20);

  If (fCfgSis('TEFEXC', varBoolean)) And (TLogTef.blnExcedeuTempoTEF) Then
  Begin
    fMensagem('ATENÇÃO!', MSG_TEF_EXCEDEU_TEMPO, ['&OK']);
    pHabilitarTela(True);
    Exit;
  End;

  If blnCliFil Then
  Begin
    fMensagem('ATENÇÃO!', 'Cliente Filial não é permitido nessa operação!', ['&Ok']);
    pHabilitarTela(True);
    Exit;
  End;

  Screen.Cursor := crHourGlass;

  If (Not pnlRodape.Enabled) Then
  Begin
    pHabilitarTela(True);
    Exit;
  End;

  If (fFormataFloat(edtValTro.Value, 2) > 0) And
     (fFormataFloat(edtValTro.Value, 2) > fFormataFloat(objResumoDeCaixa.fRetornaSaldoCaixaCampo('RCX_DINREC', strCodigoCaixa, strEmpLog), 2)) Then
  Begin
    fMensagem('', 'Saldo em caixa insuficiente para esse valor de troco!', ['&Ok']);
    pHabilitarTela(True);
    Exit;
  End;

  pInformacao('Aguardando confirmação de adiantamento...', pgbStatus);

  If (fMensagem('', 'Confirma adiantamento do Pedido?', ['&Sim', '&Não']) = 2) Then
  Begin
    pHabilitarTela(True);
    Exit;
  End;

  pInformacao('Aguarde, Realizando adiantamento do pedido...', pgbStatus);

  blnGravouArquivos := False;

  Try
    pDesabilitaCamposAntesFechamento;

    Result := fFecharAdiantamento(pgbStatus);

    pFinalizarFechamento(Result, pgbStatus);

  Finally
    pHabilitarCamposAposFechamento(Result);

    If Result Then
      pTrataWMS;
  End;

end;

{*****************************************}
{* DEFINE A ESPÉCIE DEFAULT              *}
{**************************************MV*}
procedure TfrmFatConfOrcamentos.pDefineEspecieDefault;
  Var
    strEspSug: string;
begin
  strEspSug := fCfgSis('ESPSUG');

  If (strEspSug = 'DP') And (Not fEmptyStr(strTipPed)) Then
    strEspSug := strTipPed;

  If Not fEmptyStr(fEspecieCasoConcomitante) Then
    strEspSug := fEspecieCasoConcomitante;

  pSetaTipoFaturamento(strEspSug);

  edtTipFat.Enabled := True;
  spnTipFat.Enabled := True;
end;

function TfrmFatConfOrcamentos.fChequePre(fltValor: Double): Boolean;
Begin

  Result := True;

  If Not Assigned(cdsChequePre) Then cdsChequePre := fCriaCdsCheques(Nil);

  Try
    pCriarFormularios(TfrmCadCheques,frmCadCheques);
    frmCadCheques.strCodOpe   := strCodOpe;
    frmCadCheques.blnResumida := True;
    frmCadCheques.blnResCai   := True;
    frmCadCheques.blnGravacaoFisica := False;
    frmCadCheques.fltValTot   := fltValor;
    frmCadCheques.blnPrazo    := True;
    frmCadCheques.cdsChqRcx   := cdsChequePre;
    frmCadCheques.strCliente  := edtCodCli.Text;
    frmCadCheques.blnTravaCli := True;

    frmCadCheques.cdsChqOutroTip.Data := cdsChequeVis.Data;

    frmCadCheques.RotinaChamada := 'RESUMO DE CAIXA->F11 CONF. ORÇAMENTOS';

    If fCfgSis('TFPF11', varBoolean) Then
    Begin
      frmCadCheques.strConPag := strConPag;
      frmCadCheques.blnValidarVencConPag := True;

      With fatVenda, objFormasPagtoNegociada Do
      Begin
        If (strCodFpg = '009') And (fFormaPagtoSelecionada('002')) Then
        Begin
          frmCadCheques.strConPag := cdsFormasNegociadas.FieldByName('CONPAG').AsString;
          If (cdsFormasNegociadas.FieldByName('DTACHQ').AsDateTime > 0) Then
            frmCadCheques.dtaDataChqPre := cdsFormasNegociadas.FieldByName('DTACHQ').AsDateTime;
        End;
      End;
    End;

    frmCadCheques.ShowModal;

    If (Not frmCadCheques.blnConfima) Then
    Begin
      Result := False;
      optTrocoPre := otNada;
      fltValorTrocoPre := 0.0;
    End
    Else
      cdsChequePre.Data := frmCadCheques.cdsTabela.Data;

    If cdsChequePre.IsEmpty Then
    Begin
      Result := False;
    End;

    if Result then
    Begin
       // ***** Verifica prazo medio para recebimento de cheque pré. ***** //
       Result := fVerificaPrazoRecebimentoChequePre( cdsChequePre );
       if Not Result then
          cdsChequePre.EmptyDataSet;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[frmFatConfOrcamentos.fChequePre]');
    End;
  End;

  pFreeAndNil(frmCadCheques);

End;

function TfrmFatConfOrcamentos.fChequeVis(fltValor: Double): Boolean;
Begin
  Result := True;

  If Not Assigned(cdsChequeVis) Then cdsChequeVis := fCriaCdsCheques(Nil);

  Try
    pCriarFormularios(TfrmCadCheques,frmCadCheques);
    frmCadCheques.strCodOpe         := strCodOpe;
    frmCadCheques.blnResumida       := True;
    frmCadCheques.blnResCai         := True;
    frmCadCheques.blnGravacaoFisica := False;    
    frmCadCheques.fltValTot         := fltValor;
    frmCadCheques.blnPrazo          := False;
    frmCadCheques.cdsChqRcx         := cdsChequeVis;
    frmCadCheques.dbeDtaCad.Enabled := False;
    frmCadCheques.dbeDtaCad.TabStop := False;
    frmCadCheques.dbeDtaVen.Enabled := False;
    frmCadCheques.dbeDtaVen.TabStop := False;
    frmCadCheques.strCliente        := edtCodCli.Text;
    frmCadCheques.blnTravaCli       := True;

    frmCadCheques.cdsChqOutroTip.Data := cdsChequePre.Data;

    frmCadCheques.RotinaChamada := 'RESUMO DE CAIXA->F11 CONF. ORÇAMENTOS';

    frmCadCheques.ShowModal;

    If (Not frmCadCheques.blnConfima) Then
    Begin
      optTroco := otNada;
      fltValorTroco := 0.0;
      Result := False;
    End
    Else
      cdsChequeVis.Data := frmCadCheques.cdsTabela.Data;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[frmFatConfOrcamentos.fChequeVis]');
    End;
  End;

  pFreeAndNil(frmCadCheques);

End;

function TfrmFatConfOrcamentos.fExibirTelaParaInformarDadosDoCartao(const blnValidouCamposDaTela: Boolean; const strTipCar: String): Boolean;
begin
  Result := True;

  If ((fEhRecebimentoFormasPagtoNegociadas) And (strTipCar = 'POS')) Then
    Exit;

  If (Not blnValidouCamposDaTela) Then
    Exit;

  Result := False;
end;

function TfrmFatConfOrcamentos.fDigCartao(fltValor: Double;
  Var intIdxCrt: Integer; strNomRed, strNomBan, strTipTra, strNumCcd, strNumNsu: String;
  const strTipDeb: Char; intQtdPar: Integer; strTipoOperacaoTef: String; Var arrCartoes: TCartoesResumoCaixaArray;
  strCodCar: String = ''; strCodFin: String = ''; intQtdNeg: Integer = 0;
  blnDigCar: Boolean = True; strArquivoTEF: String=''; strCodPos: String = '';
  strTipCar: String=''; strDadosCupom: String = ''; strChaPix: String = ''; strPixS_N: String = 'N';
  strNumDoc: String = ''; strDtaTra: String = ''; strHraTra: String = ''; strStatusCartao: String = ''; strCodigoCarteiraDigital: string = '';
  intPeriod: Integer = 0; intPriVenc: Integer = 0; AstrControle: String = '';
  AstrCodigoTipoOperacaoCartao: string = ''): Boolean;
  Var
    intTamMat: Integer;
    strDesCar: String;
    fltValDig: Double;
    dtaDatTra: TDateTime;
    fltValDes: Double;
    strCndPag: String;
    strObsCar: String;
    fltPerDes: Double;
    objAmarraCartao : TAmarraCartao;
    strCCD, strNSU : String;
    strParTef : String;
    arrCartoesCopy : TCartoesResumoCaixaArray;
    strMsgTEF: string;
    frmRcxDigCartoes : TfrmRcxDigCartoes;
    strModalidade : String;
    LstrCodEmp : String ;
    LstrCodigoTipoOperacaoCartao: string;
    LstrCodigoBandeira: string;
begin
  intIdxCrt := -1;

  fltValDes := 0.00;
  fltValDig := 0.00;
  fltPerDes := 0.00;
  dtaDatTra := 0;

  If (Not fEmptyStr(strNomRed)) Then
  Begin
    pRetDadosCartao(strNomRed, strNomBan, strTipTra, intQtdPar, strCodCar, strCodigoCarteiraDigital, LstrCodEmp, strTipDeb, strTipoOperacaoTef);

    If fPrecisaAmarrarInfoCartao(strCodCar, LstrCodEmp) Then
    Begin
      objAmarraCartao := TAmarraCartao.Create(strNomRed, strNomBan, strTipTra, intQtdPar, strCodigoCarteiraDigital, strTipDeb, strTipoOperacaoTef);
      Try
        objAmarraCartao.pPosNumerosSeq(strArquivoTEF, strCCD, strNSU, strCodCar);
      Finally
        FreeAndNil(objAmarraCartao);
      End;
    End;
  End;

  Try

    pCriarFormularios(TfrmRcxDigCartoes, frmRcxDigCartoes);
    frmRcxDigCartoes.fltTotDig := fltValDig;
    frmRcxDigCartoes.fltTotGer := fltValor;
    frmRcxDigCartoes.fltMaxDig := fltValor;
    frmRcxDigCartoes.blnTraVal := True;
    frmRcxDigCartoes.edtTotCar.ReadOnly := True;
    frmRcxDigCartoes.edtTotCar.TabStop  := False;
    frmRcxDigCartoes.arrCartoes := arrCartoes;

    frmRcxDigCartoes.strNumCcd := strNumCcd;
    frmRcxDigCartoes.strNumNsu := strNumNsu;
    frmRcxDigCartoes.strCodCar := strCodCar;
    frmRcxDigCartoes.strCodFin := strCodFin;
    frmRcxDigCartoes.intQtdPar := intQtdPar;
    frmRcxDigCartoes.intQtdNeg := intQtdNeg;
    frmRcxDigCartoes.blnF11    := fIsF11;
    frmRcxDigCartoes.Period    := intPeriod;
    frmRcxDigCartoes.PriVenc   := intPriVenc;

    //frmRcxDigCartoes.edtNumNsu.Text := strNumNsu;
    //frmRcxDigCartoes.edtNumCcd.Text := strNumCcd;

    If (Not blnDigCar) And (Not fVerificaAcessoSistema('F11ALTCAR', strCodOpe)) Then
    Begin
      frmRcxDigCartoes.edtCodCar.ReadOnly := True;
      frmRcxDigCartoes.edtQtdPar.ReadOnly := True;
    End;

    //frmRcxDigCartoes.blnSairComEsc := ((VS_strUsaTef <> 'S') Or (Pos('(POS)', cbxModalidades.Items[cbxModalidades.ItemIndex]) > 0));
    //frmRcxDigCartoes.blnTipPOS     := ((VS_strUsaTef <> 'S') Or (Pos('(POS)', cbxModalidades.Items[cbxModalidades.ItemIndex]) > 0));

    frmRcxDigCartoes.blnSairComEsc  := strTipCar = 'POS';
    frmRcxDigCartoes.blnTipPOS      := strTipCar = 'POS';

    If (Not frmRcxDigCartoes.blnTipPos) Then
      frmRcxDigCartoes.edtNumNsuCon.Text := strNumNsu;

    if frmRcxDigCartoes.edtNumNsuCon.Text = '00000000000000' then
      frmRcxDigCartoes.edtNumNsuCon.Clear;

    frmRcxDigCartoes.blnEhQuestFidelidade := blnVaiResgatarQuest;
    frmRcxDigCartoes.blnEhGrynCash        := blnEhCartaoGrynCash;
    frmRcxDigCartoes.strChaPix            := strChaPix;
    frmRcxDigCartoes.strPixS_N            := strPixS_N;
    frmRcxDigCartoes.strCodigoCarteiraDigital := strCodigoCarteiraDigital;
    frmRcxDigCartoes.strNumDoc            := strNumDoc;
    frmRcxDigCartoes.strArqViaCliente     := strArqViaCliente;
    frmRcxDigCartoes.strArqViaLojista     := strArqViaLojista;
    frmRcxDigCartoes.strDtaTra            := strDtaTra;
    frmRcxDigCartoes.strHraTra            := strHraTra;
    frmRcxDigCartoes.strOpcDoc            := '11';
    frmRcxDigCartoes.strControle          := AstrControle;
    frmRcxDigCartoes.strCodigoTipoOperacaoCartao := AstrCodigoTipoOperacaoCartao;
    frmRcxDigCartoes.strCodigoBandeira := strNomBan;

    frmRcxDigCartoes.OnShow(frmRcxDigCartoes);

    If frmRcxDigCartoes.blnQtdeParcTefDifNegociada Then
    Begin
      if Assigned(VS_objTef) then
      begin
        Result := False;
        pMensagemOk('A quantidade de parcelas não pode ser maior que a quantidade negociada (' + IntToStr(intQtdNeg) + ')!');

        VS_objTef.pVerificaCncNcn;
        Exit;
      end ;
    End;

    frmRcxDigCartoes.blnSemMensagem := True;

    If (fExibirTelaParaInformarDadosDoCartao(frmRcxDigCartoes.fVerificaCamposCartao, strTipCar)) Then
    Begin
      pSetFocus(frmRcxDigCartoes.edtValCar);
      frmRcxDigCartoes.ShowModal;
    End
    Else
    Begin
      frmRcxDigCartoes.btnConfirma.Click;
    End;

    strCodCar := frmRcxDigCartoes.edtCodCar.Text;
    strDesCar := frmRcxDigCartoes.edtDesCar.Text;
    fltValDig := frmRcxDigCartoes.fltValDig;
    dtaDatTra := frmRcxDigCartoes.dtaDatTra;
    fltValDes := frmRcxDigCartoes.fltValDes;
    strCndPag := frmRcxDigCartoes.mskCndPag.Text;
    strNumCcd := frmRcxDigCartoes.edtNumCcd.Text;
    strObsCar := frmRcxDigCartoes.edtObsCar.Text;
    fltPerDes := frmRcxDigCartoes.fltPerDes;
    strNumNsu := fPadL(frmRcxDigCartoes.strNumNsu, 14, '0');
    AstrControle := frmRcxDigCartoes.strControle ;
    strNumDoc := frmRcxDigCartoes.strNumDoc;
    strDtaTra := frmRcxDigCartoes.strDtaTra;
    strHraTra := frmRcxDigCartoes.strHraTra;
    Result    := frmRcxDigCartoes.blnConfirma;
    strModalidade := frmRcxDigCartoes.strModalidade;
    strArqViaCliente := frmRcxDigCartoes.strArqViaCliente;
    strArqViaLojista := frmRcxDigCartoes.strArqViaLojista;
    strChaPix        := frmRcxDigCartoes.strChaPix;
    strPixS_N        := frmRcxDigCartoes.strPixS_N;
    strCodigoCarteiraDigital        := frmRcxDigCartoes.strCodigoCarteiraDigital;
    LstrCodigoTipoOperacaoCartao := frmRcxDigCartoes.strCodigoTipoOperacaoCartao;
    LstrCodigoBandeira := frmRcxDigCartoes.strCodigoBandeira;

    If (Not Result) And (strFpgOrc <> '016') Then
    Begin
      optTrocoCar      := otNada;
      fltValorTrocoCar := 0.0;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[frmFatConfOrcamentos.fDigCartao]');
    End;
  End;

  pFreeAndNil(frmRcxDigCartoes);

  If (Result) Then
  Begin
    arrCartoesCopy := arrCartoes;

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
    arrCartoes[intTamMat].strCodFin := strCodFin;
    arrCartoes[intTamMat].strTipCar := strTipCar;
    arrCartoes[intTamMat].strNumNsu := fPadL(strNumNsu, 14, '0');
    arrCartoes[intTamMat].strControle := AstrControle;
    arrCartoes[intTamMat].intQtdPar := intQtdPar;
    arrCartoes[intTamMat].dtaDtaTra := dtaDatTra;

    If (VS_blnTefCitel) Then
      arrCartoes[intTamMat].strConteudoArquivo := strDadosCupom
    Else If (Assigned(VS_objTef)) And (Not fEmptyStr(strArquivoTEF)) And (FileExists(strArquivoTEF)) Then
      arrCartoes[intTamMat].strConteudoArquivo := fLerConteudoArquivo(strArquivoTEF);

    arrCartoes[intTamMat].strChaPix := strChaPix;
    arrCartoes[intTamMat].strPixS_N := strPixS_N;
    arrCartoes[intTamMat].strCodigoCarteiraDigital := strCodigoCarteiraDigital;

    if VS_blnTefCitel then
    begin
      arrCartoes[intTamMat].strViaCli := strArqViaCliente;
      arrCartoes[intTamMat].strViaLoj := strArqViaLojista;
      arrCartoes[intTamMat].strNumDoc := strNumDoc;
      arrCartoes[intTamMat].strDtaTra := strDtaTra;
      arrCartoes[intTamMat].strHraTra := strHraTra;
      arrCartoes[intTamMat].strStatusCartao := strStatusCartao;
      arrCartoes[intTamMat].blnTefCnf := False;
      if fAutoConfirmaTransacaoPendenteEstaAtivada then
      begin
        arrCartoes[intTamMat].strCodigoTipoOperacaoCartao := LstrCodigoTipoOperacaoCartao;
        arrCartoes[intTamMat].strCodigoBandeira := LstrCodigoBandeira;
        arrCartoes[intTamMat].blnTefCnf := fAutoConfirmarTransacaoTef(arrCartoes[intTamMat]);
        if arrCartoes[intTamMat].blnTefCnf then
          arrCartoes[intTamMat].strStatusCartao := 'F';
      end;
    end;

    if (not VS_blnTefCitel) and ((arrCartoes[intTamMat].strTipCar = 'TEF') and (fEmptyStr(arrCartoes[intTamMat].strConteudoArquivo))) then
    begin
      If Not (Self.strFpgOrc = '016') Then //Se for FINANCEIRA, ignora a trava.
      Begin
        Result := False;
        pMensagemOk('A modalidade selecionada utiliza "TEF", ' +
                    'porém não foi encontrado o arquivo que c' +
                    'onfirma a transação TEF. ' +
                    'Entre em contato com a CITEL para solução do problema!');
        Exit;
      End;
    end;

    If (VS_blnTefCitel) then
    begin
      if (arrCartoes[intTamMat].strTipCar = 'TEF') And (Not fEmptyStr(strArquivoTEF))
        And (strModalidade <> '3') Then
      Begin
        strParTef := VS_objTef.intQtdPar.ToString;

        If (Not fEmptyStr(strParTef)) And ((StrToInt(LeftStr(strCndPag, 2))) <> (StrToIntDef(strParTef, 0))) Then
        Begin
          Result := False;
          arrCartoes := arrCartoesCopy;
          pMensagemOk('A quantidade de parcelas informada no TEF é diferente ' +
                      'da condição de pagamento negociada nesse cartão!' + sLineBreak +
                      'Cartão: ' + strCodCar + ' - ' + fRetNomeCartao(strCodCar) + sLineBreak+
                      'Parcelas informadas no TEF: [ ' + strParTef + ' ] ' + sLineBreak +
                      'Condição de Pagamento Negociada no Cartão: [ ' + fFormataCondPag(strCndPag) + ' ] ');

          Exit;
        End;
      End;
    end
    else
    If (Assigned(VS_objTef)) then
    begin
      if (arrCartoes[intTamMat].strTipCar = 'TEF') And (Not fEmptyStr(strArquivoTEF))
        And (FileExists(strArquivoTEF)) And (Not VS_objTef.fParceladoPelaAdministradora) Then
      Begin
        strParTef := VS_objTef.intQtdPar.ToString;

        If (Not fEmptyStr(strParTef)) And ((StrToInt(LeftStr(strCndPag, 2))) <> (StrToIntDef(strParTef, 0))) Then
        Begin
          Result := False;
          arrCartoes := arrCartoesCopy;
          pMensagemOk('A quantidade de parcelas informada no TEF é diferente ' +
                      'da condição de pagamento negociada nesse cartão!' + sLineBreak +
                      'Cartão: ' + strCodCar + ' - ' + fRetNomeCartao(strCodCar) + sLineBreak+
                      'Parcelas informadas no TEF: [ ' + strParTef + ' ] ' + sLineBreak +
                      'Condição de Pagamento Negociada no Cartão: [ ' + fFormataCondPag(strCndPag) + ' ] ');

          VS_objTef.pVerificaCncNcn;

          Exit;
        End;
      End;
    end;

    intIdxCrt := intTamMat;

    strArqViaCliente := '';
    strArqViaLojista := '';
  End
  Else
  Begin
    strMsgTEF := 'ATENÇÃO, ocorreu um erro na digitação dos dados desse cartão. faça a digitação manualmente!';

    If (strFpgOrc <> '016') And (VS_strUsaTef = 'S') And (Pos('(POS)', cbxModalidades.Items[cbxModalidades.ItemIndex]) <= 0) Then
    Begin
      strMsgTEF := strMsgTEF + #13 + ' Verifique se a operação TEF foi realizada em: ADM - Administração TEF!';
      strInfErro := '*TEF: ';
    End;

    pMensagemSonora(strMsgTEF);
  End;
end;

function TfrmFatConfOrcamentos.fEmpresaDocumento: String;
begin
  Result := IIF(Not blnAltLoj, VS_strCodEmp, IIF(fEmptyStr(strEmpres), VS_strCodEmp, strEmpres));

  If FPedidoEntCd Then
    Result := FPedidoEmpCd;

  If blnTravaFaturamentoF11 Then
    Result := edtCodEmp.Text;
end;

function TfrmFatConfOrcamentos.fEmpresaFaturamentoSemSaldo: String;
begin
  Result := '';

  if (not fEmptyStr(edtNumOrc.Text)) then
    Exit;

  if not fCfgSis('FATSSA', varBoolean) then
    Exit;

  if (Length(fatVenda.strCliCgc) > 11) then
    Result := fCfgSis('SSAEPJ')
  else
    Result := fCfgSis('SSAEPF');
end;

function TfrmFatConfOrcamentos.fRetonaValorPixPago: Double;
var
  LPixPago: TDadosRetornoPixConsulta ;
begin
  Result := 0 ;
  for LPixPago in fatVenda.DadosPixDaVenda.LstPixPago do
  begin
    Result := Result + LPixPago.ValorPago ;
  end ;
end;

function TfrmFatConfOrcamentos.fRetornaCodigoDaEmpresa: String;
begin
  Result := IIF(edtCodEmp.Visible, edtCodEmp.Text, VS_strCodEmp);

  If FPedidoEntCd Then
    Result := FPedidoEmpCd;
end;

Procedure TfrmFatConfOrcamentos.pSalvaDuplicatas;
  Var
    intIndice: Integer;
Begin

  If (qryFatGor.IsEmpty) Then
    pZeraDigDuplic(fatVenda.arrDuplicata);

  For intIndice := Low(fatVenda.arrDuplicata) To High(fatVenda.arrDuplicata) Do
    arrDuplicataSav[intIndice] := fatVenda.arrDuplicata[intIndice];
End;

function TfrmFatConfOrcamentos.fPrecisaAmarrarInfoCartao(const AstrCodCar,
  AstrCodEmp: String): Boolean;
begin

  if not VS_blnTefCitel then
    Exit(False) ;

  Result := True ;
  if fEmptyStr(AstrCodCar) then
    Exit ;

  if (not fEmptyStr(AstrCodEmp)) and (AstrCodEmp <> VS_strCodEmp) then
    Exit ;

  Result := False ;
end;

function TfrmFatConfOrcamentos.fPrecisaInformarNumLiberacao(
  const AitemInfoCartao: TCartoesResumoCaixa): Boolean;
var
  LstrObrigaNumLiberacao: String ;
begin
  Result := False ;

  if not fEmptyStr(AitemInfoCartao.strCodigoCarteiraDigital) then
    Exit ;

  if not fEmptyStr(AitemInfoCartao.strNumCcd) then
    Exit ;

  LstrObrigaNumLiberacao := fCampoTabela('CAR_OBRCCD', 'CADCAR', ['CAR_CODCAR'], [AitemInfoCartao.strCodCar]) ;
  if LstrObrigaNumLiberacao = 'N' then
    Exit ;

  Result := True ;
end;

function TfrmFatConfOrcamentos.fProcessaLogEnderecoEntrega : Boolean;
begin
  Result := True;

  if (not btnConfirma.Enabled) then
    Exit;
 
  If (fCfgSis('ECLF11', varBoolean)) Then
  begin
    fStartTransaction;
    Try
      If (strNumCepOld <> mskCepEnt.Text) Then
        fSalvaLoGEnderecoEntrega(strLoginUsuarioLogado, VS_strCodEmp, 'CEP', strNumCepOld, mskCepEnt.Text, edtCodCli.Text);

      If (strBairroOld <> edtBaiEnt.Text) Then
        fSalvaLoGEnderecoEntrega(strLoginUsuarioLogado, VS_strCodEmp, 'BAIRRO', strBairroOld, edtBaiEnt.Text, edtCodCli.Text);

      If (strEndereOld <> edtEndEnt.Text) Then
        fSalvaLoGEnderecoEntrega(strLoginUsuarioLogado, VS_strCodEmp, 'ENDERECO', strEndereOld, edtEndEnt.Text, edtCodCli.Text);

      If (strCodCidOld <> edtCidEnt.Text) Then
        fSalvaLoGEnderecoEntrega(strLoginUsuarioLogado, VS_strCodEmp, 'CODCIDADE', strCodCidOld, edtCidEnt.Text, edtCodCli.Text);

      fCommit;
    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack;
        pMensagensErro(E.Message,'[TfrmFatConfOrcamentos.fProcessaLogEnderecoEntrega]');
      End;
    End;
  end;
end;

procedure TfrmFatConfOrcamentos.pAbrirGaveta(strConPag: String);
  Var
    strCodErr: String;
begin
  strCodErr := '';
  If (fCfgSis('ABRGAV', varBoolean)) And
     ((fStatusCndPag(strConPag) = A_VISTA) Or (fConPagComEntrada(strConPag))) Then
  Begin
    If (fCfgSis('USNFCE') = 'S') Or fUsaSat Then
      pAbrirGavetaNFCeSAT(fLerImpressora, fLerImpConfGaveta)
    Else
    Begin
      If Assigned(VS_objFiscal) Then
        VS_objFiscal.fAbreGaveta
      Else If Assigned(ecfFiscal) Then
        ecfFiscal.fAbreGaveta(strCodErr);
    End;
  End;
end;

function TfrmFatConfOrcamentos.fFatGor(strCampo: String): TField;
begin
  If strCampo = 'AUTOINCREM' Then
    Result := qryFatGor.FieldByName(strCampo)
  Else
    Result := qryFatGor.FieldByName('FGO_' + strCampo);
end;

function TfrmFatConfOrcamentos.fAuxGor(strCampo: String): TField;
begin
  Result := qryFatGor.FieldByName('AUX_' + strCampo);
end;

function TfrmFatConfOrcamentos.fVaiRecalcularTotGerPorCausaDosImpostos: Boolean;
begin
  Result := True;

  If (fatVenda.fRetemImpostosNoDescontoEspecial) Then
    Exit;

  If (fatVenda.fAplicaDescontoIcmsOrgaoPublicoNoDescontoEspecial) Then
    Exit;

  Result := False;
end;

procedure TfrmFatConfOrcamentos.pGravaTemNSE(var dicDados: TDictionary<String, String>);
begin
  If (Assigned(dicDados)) Then
  Begin
    cdsVenda.DisableControls;
    Try
      cdsVenda.First;
      While Not cdsVenda.Eof Do
      Begin
        dicDados.Add(cdsVenda.FieldByName('AUTOINCREM').AsString, cdsVenda.FieldByName('ITE_TEMNSE').AsString);

        cdsVenda.Next;
      End;
    Finally
      cdsVenda.EnableControls;
    End;
  End
end;

procedure TfrmFatConfOrcamentos.pRecuperaTemNSE(var dicDados: TDictionary<String, String>);
  Var
    strAutInc : String;
begin
  If (dicDados.Count > 0) Then
  Begin
    cdsVenda.DisableControls;
    Try
      For strAutInc in dicDados.Keys Do
      Begin
        If cdsVenda.Locate('AUTOINCREM', strAutInc, []) Then
        Begin
          cdsVenda.Edit;
          cdsVenda.FieldByName('ITE_TEMNSE').AsString := dicDados.Items[strAutInc];
          cdsVenda.Post;
        End;
      End;
    Finally
      cdsVenda.EnableControls;
    End;
  End;
end;

procedure TfrmFatConfOrcamentos.pCalculaTotGerImpostos(var intProgresso: Integer; const intProgressoMax: Integer; pgbStatus: TcxProgressBar);
begin
  If (Not fVaiRecalcularTotGerPorCausaDosImpostos) Then
    Exit;

  fatVenda.fltIcmOrg := 0.0;
  fatVenda.fltBasOrg := 0.0;

  pProgresso(intProgresso, intProgressoMax, pgbStatus);
  pInformacao('Aguarde, Calculando valor dos produtos...', pgbStatus);
  fatVenda.pCalculaTotGer(False, False, pOnCalculaTotGer);

  If (fatVenda.fAplicaDescontoIcmsOrgaoPublicoNoDescontoEspecial) Then
  Begin
    If (fatVenda.fltDesEsp <= 0.00) And (fatVenda.fltIcmOrg > 0) Then
      fatVenda.fltDesEsp := fatVenda.fltIcmOrg;
  End;

  If (fatVenda.fRetemImpostosNoDescontoEspecial) Then
  Begin
    pProgresso(intProgresso, intProgressoMax, pgbStatus);
    pInformacao('Aguarde, Destacando Retenções...', pgbStatus);
    fatVenda.pDestacaRetencoes;
  End;

  If fRateiaFreteItensTransportadora(fatVenda.strCodTra, fatVenda.strTipFre) And (fatVenda.fltValFre > 0) Then
  Begin
    fatVenda.fltFreRat := fatVenda.fltValFre;
    fatVenda.fltValFre := 0.00;
    fatVenda.fltFreDig := 0.00;
  End;

  pProgresso(intProgresso, intProgressoMax, pgbStatus);
  pInformacao('Aguarde, Calculando valor dos produtos com impostos...', pgbStatus);
  fatVenda.pCalculaTotGer(False, True, pOnCalculaTotGer);
end;

function TfrmFatConfOrcamentos.fFecharVenda(pgbStatus: TcxProgressBar = nil): Boolean;
  Const
    INT_PROGRESSO_MAX = 50;

  Var
    intContador: Integer;
    intProgresso: Integer;

    strNumCoo: String;
    strNumSer: String;
    strNumCcf: String;

    strInformacao: String;

    dadosImpressao: TDadosImpressaoVenda;
    intVia: Integer;
    fltDesAceIPI: Double;
    dicItemTemSerie : TDictionary<String, String>;

    function fRetTipoPedido: String;
    begin
      If fatVenda.strEspDoc = 'PD' Then
      Begin
        If qryFatGor.IsEmpty Or fEmptyStr(fFatGor('TIPPED').AsString) Then
          Result := 'A'
        Else
          Result := fFatGor('TIPPED').AsString;
      End
      Else If fatVenda.strEspDoc = 'NF' Then
        Result := 'A'
      Else If fatVenda.strEspDoc = 'IF' Then
        Result := 'C'
      Else
        Result := 'B';// MI e FF ou BR
    end;

begin
  blnRestaurarMatrizDeItens := False;
  blnImprimiuCupom := True;
  blnCancelarCFTef := False;
  Result := False;

  pDefinirNumeroSerieCooLogTef;

  Try
    intProgresso := 0;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Acertando Cheques Venda...', pgbStatus);

    pAcertaClienteCheque(cdsChequePre);
    pAcertaClienteCheque(cdsChequeVis);

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Preparando Dados para Gravação...', pgbStatus);

    fatVenda.strOriF11 := 'S';
    fatVenda.blnUtilizacaoCreditoEDinheiroOriF11 := fUsouModalidadesUtilizacaoCreditoDinheiro();

    If fRetEspecieSelecionada = 'IF' Then
    Begin
      If Assigned(VS_objFiscal) Then
      Begin
        fatVenda.pSetaMetodoArredondamentoICMSECF(VS_objFiscal.fCalculaValorIcms);
      End
      Else if Assigned(ecfFiscal) Then
      Begin
        fatVenda.pSetaMetodoArredondamentoICMSECF(ecfFiscal.fCalculaValorIcms);
      End;
    End;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Carregando variáveis para Gravação...', pgbStatus);

    fatVenda.blnImprimeSep := True;

    fatVenda.blnConfOrcamento := True;
    fatVenda.blnVerEstOrc := False;
    fatVenda.strNomeForm := 'frmFatVendas';

    fatVenda.fltValMor := fCfgSis('TAXDIA', varDouble);
    fatVenda.strOriF11 := 'S';
    fatVenda.strAutIcv := EmptyStr;

    fatVenda.strNumOrc := edtNumOrc.Text;
    fatVenda.strEspOrc := strEspCfo;
    fatVenda.strEmpOri := fEmpresaDocumento;

    fatVenda.strNumOrigem := fatVenda.strNumOrc;
    fatVenda.strEspOrigem := fatVenda.strEspOrc;
    fatVenda.strEmpOrigem := fatVenda.strEmpOri;

    if fCfgSis('COMAND', VarBoolean) then
      fatVenda.strBarCom := fCampoTabela(
        'FGO_BARCOM',
        'FATGOR INNER JOIN EXTGOR ON AUTOINCREM = FGO_SEQFGO',
        ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'],
        [fatVenda.strNumOrc, fatVenda.strEspOrc, fatVenda.strEmpOri]);

    fatVenda.strEspDoc := fRetEspecieSelecionada;

    If (fatVenda.strEspDoc = 'PD') then
    begin
      if fCfgSis('DTORPD', varBoolean) Then
      Begin
        fatVenda.dtaGraPed := fatVenda.dtaDtaEntOri;
        fatVenda.dtaPrevis := fatVenda.dtaPreVisOri;
      End
      else
      begin
        fatVenda.dtaGraPed := VS_Date;
        fatVenda.dtaHorPed := fRetHoraServidor;
        fatVenda.dtaPrevis := VS_Date;
      end;
    end;

    fatVenda.optTroco := optTroco;
    fatVenda.fltValorTroco := fltValorTroco;

    fatVenda.optTrocoPre := optTrocoPre;
    fatVenda.fltValorTrocoPre := fltValorTrocoPre;

    fatVenda.optTrocoCar := optTrocoCar;
    fatVenda.fltValorTrocoCar := fltValorTrocoCar;

    fatVenda.optTrocoDinheiro := optTrocoDin;
    fatVenda.fltValorTrocoDinheiro := fltValorTrocoDin;

    fatVenda.cdsChequePre.Data := cdsChequePre.Data;
    fatVenda.cdsChequeVis.Data := cdsChequeVis.Data;

    fatVenda.strTabPre := strTabPrecoFat;

    fatVenda.objCodBar := objCodBar;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Carregando dados do cliente para Gravação...', pgbStatus);

    fatVenda.blnFecharForm := False;

    fatVenda.fltDupRec := 0;
    fatVenda.fltValAdt := 0;
    FillChar(fatVenda.recValAdt, SizeOf(fatVenda.recValAdt), #0);

    fatVenda.fltTroco_ := edtValTro.Value;
    fatVenda.blnTrocoComoCredito := blnTrocoComoCredito;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Carregando produtos...', pgbStatus);

    If (btnNumSeries.Visible) Then
    Begin
      dicItemTemSerie := TDictionary<String, String>.Create;
      pGravaTemNSE(dicItemTemSerie);
    End;

    cdsVenda.EmptyDataSet;    

    If Not qryFatGor.IsEmpty Then
    Begin
      cdsVenda.Data := oleItensVendaPed;

      If (btnNumSeries.Visible) Then
      Begin
        pRecuperaTemNSE(dicItemTemSerie);
        FreeAndNil(dicItemTemSerie);
      End;

      fatVenda.strEspTra := edtEspVol.Text;
      fatVenda.intQtdTra := StrToIntDef(edtVolume.Text, 0);

      pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
      pInformacao('Aguarde, Definindo Endereço de Entrega/Transportadora...', pgbStatus);

      pCarregaClienteVenda(fatVenda, fatVenda.strTabPre);
      pCarregaEnderecoEntregaVenda(fatVenda);
      pCarregaTransportadoraVenda(fatVenda);

      If fCfgSis('F11DIG', varBoolean) Then
        fatVenda.strCodDig := Self.strCodOpe;

      If (Not cdsItensAdd.Active) Or (cdsItensAdd.IsEmpty) Then
      Begin
        fltDesEspConcedido := fatVenda.fltDesEsp;

        If (fatVenda.fPermiteDescontoComercialEmOperacaoZonaFrancaComDescontoDeIcms) Then
        Begin
          fatVenda.fltDesEsp := qryFatGor.FieldByName('FGO_DECZFM').AsFloat;
          fatVenda.fltDesComercialZFM := qryFatGor.FieldByName('FGO_DECZFM').AsFloat;
          fltDesEspConcedido := qryFatGor.FieldByName('FGO_DECZFM').AsFloat;
        End;

        fltPorDesConcedido := fatVenda.fltPorDesTmp;
      End;

      pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
      pInformacao('Aguarde, calculando total duplicatas quitadas...', pgbStatus);

      {***************************************************}
      {* CARREGA O TOTAL RECEBIDO. NAO ESTAVA CARREGANDO *}
      {* E O CONTAS A RECEBER ESTAVA GRAVANDO ERRADO     *}
      {************************************************JC*}
      If (Pos(fatVenda.strEspOrc, 'PD_OR_') > 0) Then
      Begin
        fatVenda.fltDupRec := fatVenda.fTotalDuplicataQuitada(fatVenda.strNumOrc,
                                                              fatVenda.strEspOrc,
                                                              fRetornaCodigoDaEmpresa,
                                                              fFatGor('CODCLI').AsString);

        fatVenda.recValAdt := TAdiantamento.fGetTotaisAdiantamento(fatVenda.strNumOrc,
                                                                   fatVenda.strEspOrc,
                                                                   fRetornaCodigoDaEmpresa);

        fatVenda.fltValAdt := fatVenda.recValAdt.fltValLan;

        If Not blnRealizandoAdiantamentoPedidoPeloF11 Then
        Begin
          fatVenda.blnResCaiAdt := TAdiantamento.fGetResCaiAdiantamento(fatVenda.strNumOrc,
                                                                        fatVenda.strEspOrc,
                                                                        fRetornaCodigoDaEmpresa,
                                                                        qryFatGor.FieldByName('FGO_CODCLI').AsString);
          If (fTipoFaturamentoSelec.strEspDoc = 'PD') Then
            fatVenda.blnResCaiAdt := True;
        End;

        If fatVenda.fPedidoAPrazoComEntradaQuitada(fatVenda.strNumOrc,
                                                   fatVenda.strEspOrc,
                                                   fRetornaCodigoDaEmpresa,
                                                   fatVenda.FConPag) Then
        Begin
          fatVenda.pAlteraCondicaoPagamentoRemovendoEntrada(fatVenda.FConPag);
        End;
      End;
    End
    Else
    Begin
      pCarregaClienteVenda(fatVenda);

      SetLength(FMatrizesDesmembramento, 0);
      blnDesmembrarVenda    := False;
      blnTemEntregaFutura   := False;
      blnTemEntregaImediata := False;
      blnTemRetiraOutraLoja := False;
      blnVendaOrigOutraLoja := False;
      blnTemRetiraMesmaLoja := False;
      blnTemRetiraExpedicao := False;
      blnTemRetiraBalcao    := False;
      blnTemItensEmpresaCD  := False;
      blnPedOrcMltLojUtiNps := False;

      fatVenda.strConPag := strDigConPag;
      fatVenda.strCodCnd := strDigCodCnd;
      fatVenda.blnCndEsp := (fRetEspConPag(strDigCodCnd) = 'S');
      fatVenda.strCodVen := strDigCodVen;
      fatVenda.strCodDig := strCodOpe;
      fatVenda.strNomVen := fRetNomVendRep(strDigCodVen);
      fatVenda.strNomDig := fRetNomVendRep(strCodOpe);
      fatVenda.strTipVen := fRetTipoOperador(fatVenda.strCodVen);
      fatVenda.strCodFpg := '001';
      fatVenda.strEmpFatSemSaldo := fEmpresaFaturamentoSemSaldo;
    End;
    fatVenda.strTipPed := fRetTipoPedido;

    pSalvaDuplicatas;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Carregando produtos adicionais...', pgbStatus);

    pInserirItemServico(fatVenda, fCfgSis('ITESER'));

    If fCfgSis('AUTCEN', VarBoolean) And (fCfgSis('ITESER') <> fCfgSis('SERTER'))  Then
      pInserirItemServico(fatVenda, fCfgSis('SERTER'));

    If (blnRestaurarMatrizDeItens) Then
      fatVenda.pPreencheMatrizFechamento('', pOnPreencheMatrizItens);

    {**************************************}
    {* INSERINDO ITENS ADICIONAIS PELO F3 *}
    {***********************************AF*}
    If (cdsItensAdd.Active) And (Not cdsItensAdd.IsEmpty) Then
    Begin
      cdsVenda.Data := oleItensVendaPedAdicionais;

      If blnRecalculaCdsVendaForcadoLocal Then
        fExecutouRecalculoPrecosCondPagto(True);  
    End;    

    If Not fVerificaStatusImpressora Then
      Exit(False);

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, verificando itens para emissão de cupom fiscal...', pgbStatus);

    If Not fatVenda.fVerificaQuantidadeItensCupom Then
    Begin
      Result := False;
      Exit;
    End;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, verificando lote dos produtos...', pgbStatus);

    If Not fatVenda.fValidarLoteVazio Then
    Begin
      Result := False;
      Exit;
    End;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, verificando se possui itens para emitir documento...', pgbStatus);

    If cdsVenda.RecordCount <= 0 Then
    Begin
      Result := True;
      Exit;
    End;

    If btnNumSeries.Visible Then
    Begin
      pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
      pInformacao('Aguarde, verificando número de séries ...', pgbStatus);
      If Not fatVenda.fValidaQuantSerieItens Then
      Begin
        pMensagemOk('Utilize o botão "[Ctrl+F3] Núm. Séries" para corrigir.');
        Result := False;
        Exit;
      End;
    End;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, verificando permissão para emitir documento...', pgbStatus);

    If (Not fPermiteEmissaoEspecie(fatVenda.strEspDoc)) Then
    Begin
      fMensagem('ATENÇÃO!',Format(MSG_ESPECIE_EMISSAO_NAO_PERMITIDA, [fGetConfiguracaoPermiteEmissaoEspecie(fatVenda.strEspDoc)]) , ['&OK']);
      Result := False;
      Exit;
    End;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, verificando permissão para emitir documento com Serviço(s)...', pgbStatus);

    If Not fatVenda.fValidarPermissaoEmitirDocumentoComServicos() Then
    Begin
      Result := False;
      Exit;
    End;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, verificando itens com obrigatoriedade de NFe...', pgbStatus);

    If (fatVenda.fItensObrNfe) Then
    Begin
      Result := False;
      Exit;
    End;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Validando dados do consumidor...', pgbStatus);

    If Not fatVenda.fDadosCorretosParaClienteConsumidor(fatVenda.strEspDoc) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido emitir Nota Fiscal sem preencher todos os dados do cliente.', ['&Ok']);
      Result := False;
      Exit;
    End;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Validando condição de pagamento...', pgbStatus);

    {*****************************************}
    {* VALIDA CONDICAO DE PAGTO CARREGADA    *}
    {**************************************IV*}
    If (Not fEmpresaTemAcessoCondicaoPagto(fatVenda.strCodCnd)) Then
    Begin
      If fEmptyStr(fatVenda.strCodCnd) Then
        fMensagem('ATENÇÃO!', 'A Condição de Pagamento deve ser informada! Favor verificar.', ['&Ok'])
      Else
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar esta condição. Verifique o Cadastro de Condições de Pagamento - Aba "Empresas Acesso".' , ['&O k']);

      Result := False;
      Exit;
    End;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Validando forma de pagamento...', pgbStatus);

    {*****************************************}
    {* VALIDA FORMA DE PAGAMENTO CARREGADA   *}
    {**************************************IV*}
    If (fCfgSis('USAFPG', varBoolean)) And
       (fRetornaStatusCadastro(fatVenda.strCodFpg, 'FPG', 'CADFPG', 'FPG_CODIGO') <> 'A') Then
    Begin
      If fEmptyStr(fatVenda.strCodFpg) Then
        fMensagem('ATENÇÃO!', 'A Forma de Pagamento deve ser informada! Favor verificar.', ['&Ok']);
      Result := False;
      Exit;
    End;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Verificando Obrigatoriedade de CPF/CNPJ itens...', pgbStatus);

    {************************************************************}
    {* VERIFICA SE EXISTE ITENS COM OBRIGATORIEDADE DE CPF/CNPJ *}
    {* VERIFICA CPF\CGC VALIDO                                  *}
    {*********************************************************JB*}
    If (fatVenda.fTrocaUFEndEntrega <> 'EX') And
       (Not fatVenda.fVerificaItemObrigCpfCnpj) Then
      Exit;

    If (Not fatVenda.fVerificaItemObrigCodIbama) Then
      Exit;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Definindo dados da condição de pagamento...', pgbStatus);

    pAcertaDadosCondicaoPagamento(fatVenda);

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Verificando Obrigatoriedade de CPF/CNPJ...', pgbStatus);

    If Not fatVenda.fValidarCpfObrigatorio(True) Then
      Exit;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Verificando permissão cupom fiscal para cliente fora do estado...', pgbStatus);

    If Not fPermiteEmitirCupomParaForaDoEstado(fatVenda) Then
    Begin
      Exit;
    End;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Verificando permissão cupom fiscal para vendas online (e-commerce)...', pgbStatus);

    If fTravaEmissaoDeCupomParaEcommerce(fatVenda) Then
    Begin
      fMensagem('', 'Não é permitido emitir cupom fiscal para vendas online (e-commerce).', ['&Ok']);
      Exit;
    End;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Informando o profissional...', pgbStatus);

    If (fCfgSis('PROF11', varBoolean)) And (fCfgSis('NROPRO') <> '1') Then
    Begin
      If Not fPedeProfissional(fatVenda) Then
      Begin
        Result := False;
        Exit;
      End;
    End;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Validando condição de pagamento para consumidor...', pgbStatus);

    If Not fatVenda.fValidarCondicaoPrazoConsumidor Then
      Exit;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Carregando dados do produto para Fechamento...', pgbStatus);

    fatVenda.fltDesEsp := fltDesEspConcedido;
    fatVenda.fltPorDes := fltPorDesConcedido;
    fatVenda.pPreencheMatrizFechamento('', pOnPreencheMatrizItens);

    if fDefineAbastecimentoItensPDAVista then
    begin
      If Not fatVenda.fDefineAbastecimentoItensSemEstoqueSuficiente Then
        Exit;
    end;

    If ((fatVenda.fltTotSer > 0) Or (fatVenda.fGetTotalServNaoTerc('R') > 0)) And fUsaRateioDeServicos Then
    Begin
      fatVenda.pCalculaValUniRateioServico;
    End;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Calculando Taxa de Juros...', pgbStatus);

    If Not qryFatGor.IsEmpty Then
      fatVenda.blnDeCndF := (fCfgSis('CNDVEN') = 'F')
    Else
      fatVenda.blnTaxVpr := True;

    If (Not fatVenda.blnCalculaTaxCndF3Inicio) Then
    Begin
      If fatVenda.blnTaxVpr Or fatVenda.blnRecalculaTaxCndF3Forcado Then
        fatVenda.pCalculaTaxVpr;
    End;

    If (Pos(fatVenda.strOpcDoc, 'PD_OR_VN_CP_') > 0) And (fCfgSis('TAXENT', varBoolean)) Then
    Begin
      fatVenda.blnAplicaTaxaEntrega := True;
      fatVenda.pAtualizaValorTaxaEntrega;
    End;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Calculando Peso Bruto/Liquido...', pgbStatus);

    fatVenda.pCalculaPesBruLiq;

    If (fPermiteInformarPesoNoPedidoDeVenda) And (Not qryFatGor.IsEmpty) Then
    Begin
      fatVenda.fltPesBru := fFatGor('PESBRU').AsFloat;
      fatVenda.fltPesLiq := fFatGor('PESLIQ').AsFloat;
    End;

    If (qryFatGor.Active) And (Not qryFatGor.IsEmpty) And (fCfgSis('PESEXP', varBoolean)) and (fCfgSis('TIPEXP', varString) = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
    Begin
      If (fFatGor('PEBRTE').AsFloat > 0) And (fFatGor('PELITE').AsFloat > 0) Then
      Begin
        fatVenda.fltPesBru := fFatGor('PEBRTE').AsFloat;
        fatVenda.fltPesLiq := fFatGor('PELITE').AsFloat;
      End;
    End;

    If (Not blnDesmembrarVenda) And (fatVenda.strEspDoc = 'IF') And fCfgSis('FRECUP', VarBoolean) Then
    Begin
      fatVenda.pInsereItemFreteNoCupomFiscal;
    End;

    fatVenda.pAplicarFreteComoAcrescimoNFCe;

    If fPermiteCupomFiscalComIPI Then
    Begin
      fltDesAceIPI := fatVenda.fValorTotalDeIpiComoDespesaAcessoria;
      fatVenda.fltDesAce := fltDesAceIPI;
    End;

    If fCfgSis('EIIZFM', varBoolean) Then
    Begin
      fatVenda.fltTiiZfm := fatVenda.fRetornaValorDoImpostoDeImportacaoZonaFranca;
      If fatVenda.fltTiiZfm > 0 Then
        fatVenda.fltDesAce := fatVenda.fltTiiZfm;
    end;

    If (Not fVaiRecalcularTotGerPorCausaDosImpostos) Then
    Begin
      If fRateiaFreteItensTransportadora(fatVenda.strCodTra, fatVenda.strTipFre) And (fatVenda.fltValFre > 0) Then
      Begin
        fatVenda.fltFreRat := fatVenda.fltValFre;
        fatVenda.fltValFre := 0.00;
        fatVenda.fltFreDig := 0.00;
      End;
    End;

    {***************************************************************************************}
    {* CHAMADA À pCalculaTotGer DEFAULT POIS QUANDO CONFIGURADO PARA 4 CASAS PARA UNITÁRIO *}
    {* O SISTEMA PRECISA ACERTAR A TOTITE PASSANDO PELA pCalcPorDes DA pCalculaTotGer PARA *}
    {* CALCULAR OS VALORES DE RETENÇÃO CORRETAMENTE REQ.: 79710                            *}
    {************************************************************************************VA*}
    pInformacao('Aguarde, Calculando valor dos produtos...', pgbStatus);
    fatVenda.pCalculaTotGer(False, True, pOnCalculaTotGer);
    If (Not fatVenda.fValidarDivergenciaST(False)) Then
      fatVenda.pCalculaTotGer(False, True, pOnCalculaTotGer);

    if (not blnVerificouMinimo) and
       (fNaoVerificouMinimoNoOrcamentoOuPedido) and
       (not fatVenda.fVerificaVrMinimo(fGetTotGer(fatVenda.fltTotGer), fGetTotGer(fatVenda.fltTotGer), fatVenda.intPrzMed)) Then
    Begin
      Exit;
    End;

    pSetarItensExpedidosMatrizItens(fatVenda.arrMatItens);

    If fUsouExpedicaoServicos Then
      pMarcarTodosItensComoExpedidos(fatVenda.arrMatItens);

    blnDesmembrarVenda    := fatVenda.fHaveraDesmembramentoVenda(fatVenda.arrMatItens, FMatrizesDesmembramento);
    blnTemEntregaFutura   := fatVenda.fTemEntregaFutura(fatVenda.arrMatItens);
    blnTemEntregaImediata := fatVenda.fTemItensEntregaImediata(fatVenda.arrMatItens);
    blnTemRetiraOutraLoja := fatVenda.fTemItensRetira(fatVenda.arrMatItens, opOutraEmpresa);
    blnTemRetiraExpedicao := fatVenda.fTemItensRetira(fatVenda.arrMatItens, opTodasEmpresas, opLocalRetiraExpedicao);
    blnTemItensEmpresaCD  := fatVenda.fTemItensEmpresaCD(fatVenda.arrMatItens);
    blnTemRetiraBalcao    := fatVenda.fTemItensRetira(fatVenda.arrMatItens, opTodasEmpresas, opLocalRetiraBalcao) Or
                             fatVenda.fTemItensRetira(fatVenda.arrMatItens, opTodasEmpresas, opLocalRetiraBalcao2);
    fatVenda.blnPdOutraLojaEmPdComEntCDOndeCDEhLojaAtual := fatVenda.fFatPedidoOutraLojaEmPedidoComEntCDOndeCDEhLojaAtual(fatVenda.arrMatItens);

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Verificando permissão para itens agrotóxicos...', pgbStatus);

    If Not fatVenda.fValidarItemAgrotoxicoEmCupom Then
      Exit;

    If Not fatVenda.fValidarBrindeEmCupom Then
      Exit;

    If fatVenda.fUltrapassouLimiteItensNFe(strInformacao) Then
    Begin
      pMensagemSonora(strInformacao);
      Result := False;
      Exit;
    End;

    pCalculaTotGerImpostos(intProgresso, INT_PROGRESSO_MAX, pgbStatus);

    If Not fatVenda.fRetemImpostosNoDescontoEspecial Then
    Begin
      fatVenda.pDestacaRetencoes;
    End;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Verificando permissão para bonificação de produtos...', pgbStatus);

    {*************************************************}
    {* VERIFICA SE OS PRODUTOS PODEM SER BONIFICADOS *}
    {**********************************************MM*}
    If Not fatVenda.fValidouItensBonificados Then
    Begin
      Result := False;
      Exit;
    End;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, verificando permissão para emitir cupom fiscal...', pgbStatus);

    If Not fPermiteEmitirCupom(fatVenda) Then
    Begin
      Result := False;
      Exit;
    End;

    If Not fatVenda.fValidarDivergenciaST Then
    Begin
      Result := False;
      Exit;
    End;

    If (fPermiteDefinirTipoDeFaturamentoNoPedidoMesmoUsandoExpedicaoPorDocumentoFaturado) And
       (Not fatVenda.fValidarDivergenciaIPI) Then
    Begin
      Result := False;
      Exit;
    End;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Validando faixa da condição de pagamento...', pgbStatus);

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Definindo modalidades e Forma de Pagamento...', pgbStatus);

    pDefineModalidades(fatVenda);

    If Not fDefineFormaPagamento(fatVenda) Then
    Begin
      Result := False;
      Exit;
    End;

    If fEmptyStr(fatVenda.strCodFpg) Then
      fatVenda.strCodFpg := strFpgOrc;

    fatVenda.cdsModalidade.Data := cdsModalidades.Data;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Verificando venda à vista...', pgbStatus);

    If (objResumoDeCaixa.strTipoFechamento <> 'C') And
       (blnApenasPrazo And (Copy(fatVenda.strConPag,3,3) = '000')) Then
    Begin
      pMensagemOk(MSG_SOMENTE_A_PRAZO);
      Exit(False);
    End;

    If Not qryFatGor.IsEmpty Then
    Begin
      pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
      pInformacao('Aguarde, Verificando débitos em atraso do cliente...', pgbStatus);

      If (Not blnCliFil) And (Not blnCliCon) And
         (Not fEmptyStr(fatVenda.strConPag)) And
         (fStatusCndPag(fatVenda.strConPag) <> A_VISTA) And
         (Not fatVenda.fDebitoCliente(fatVenda.strCodFpg, fatVenda.strConPag, 2, 'F11')) Then
      Begin
        Result := False;
        Exit;
      End;
    End;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Verificando Limite de crédito do cliente...', pgbStatus);

    {*****************************}
    {* VALIDA LIMITE DE CRÉDITO  *}
    {**************************AF*}
    If (Not fVerificaLimiteCredito(fatVenda.strConPag, fatVenda, fStrToFloat(edtTotGer.Text), 'LIMF11')) Then
    Begin
      Result := False;
      Exit;
    End;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Validando valor do documento...', pgbStatus);
    pProcessMessages(True);

    {******************************************}
    {* VERIFICA O VALOR MINIMO P\ EMITIR A NF *}
    {***************************************AL*}
    If (fatVenda.strEspDoc = 'NF') And (Not fatVenda.fVerificaValorMinimoEmitirNF) Then
    Begin
      Result := False;
      Exit;
    End;

    fatVenda.fltTotGer := fGetTotGer(fatVenda.fltTotGer);

    If (Not fatVenda.fVerificaIntervaloMargemValorCndPagto(fatVenda.strCodCnd)) Then
    Begin
      Self.Enabled        := True;
      btnConfirma.Enabled := True;
      btnSair.Enabled     := True;
      Screen.Cursor       := crDefault;
      Exit;
    End;

    fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Calculando valor Financeiro...', pgbStatus);

    fatVenda.pCalculaTotalParaCadRec;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Realizando Rateio de Produtos...', pgbStatus);

    fatVenda.pRateiaValores;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Carregando cartões...', pgbStatus);

    SetLength(fatVenda.arrCartoes, Length(arrCartoes) + Length(arrCartFin));
    For intContador := Low(arrCartoes) To High(arrCartoes) Do
    Begin
      fatVenda.arrCartoes[intContador] := arrCartoes[intContador];
    End;

    For intContador := Low(arrCartFin) To High(arrCartFin) Do
    Begin
      fatVenda.arrCartoes[intContador + Length(arrCartoes)] := arrCartFin[intContador];
    End;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Carregando CFOP...', pgbStatus);

    With qryCadCfo Do
    Begin
      pPesquisaCadCfo(qryCadCfo, qryCadCfo, fatVenda.strClaFis);

      fatVenda.strMenCfo1 := FieldByName('CFO_MNAT01').AsString;
      fatVenda.strMenCfo2 := FieldByName('CFO_MNAT02').AsString;
      fatVenda.strMenCfo3 := FieldByName('CFO_MNAT03').AsString;
    End;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Definindo valor do crédito...', pgbStatus);

    fatVenda.stlDupCreditos.Assign(stlDupCreditos);
    fatVenda.fltCredUtilizados := fltCredUtilizados;

    fatVenda.strInfErro := strInfErro;

    fatVenda.strMen001 := arrMsgNot[1];
    fatVenda.strMen002 := arrMsgNot[2];
    fatVenda.strMen003 := arrMsgNot[3];
    fatVenda.strMen004 := arrMsgNot[4];
    fatVenda.strMen005 := arrMsgNot[5];

  Except
    On E: ExceptionAutCom Do
    Begin
      fMensagem('', E.Message, ['&O K']);
      Result := False;
      Exit;
    End;

    On E: Exception Do
    Begin
      pMensagensErro('Erro na preparação do fechamento: ' + E.Message, '[Pre: fFecharVenda]');
      Result := False;
      Exit;
    End;
  End;

  Result := True;

  If Not fatVenda.fValidarTipoFaturamentoRetencoes(True) Then
  Begin
    Result := False;
    Exit;
  End;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Verificando valor mínimo da parcela...', pgbStatus);

  {*****************************************}
  {* TRATAMENTO DE PARCELA MÍNIMA PARA NF  *}
  {**************************************MV*}
  If Not fatVenda.fVerificaValorMinimoParcela Then
  Begin
    Result := False;
    Exit;
  End;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Verificando abreviação fiscal dos produtos...', pgbStatus);

  If Not fatVenda.fVerificaItensCupomAbf() Then
  Begin
    Result := False;
    Exit;
  End;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Verificando tipo de faturamento pedido...', pgbStatus);

  If Not fatVenda.fSolicitarTipoFaturamentoNovosPedidosF11 Then
  Begin
    Result := False;
    Exit;
  End;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Verificando Comunicação com Integrador...', pgbStatus);

  if not fatVenda.fVerificaInfoIntegradorSatCitel then
  Begin
    Result := False;
    Exit;
  End;

  If Not fatVenda.fValidarTipoFaturamentoEmail Then
  Begin
    Result := False;
    Exit;
  End;

  If fatVenda.fTemComboComItemBrindeEntregaFutura(True) Then
  Begin
    Result := False;
    Exit;
  End;

  If Not fatVenda.fValidarItensSemExtDor(qryFatGor) Then
  Begin
    Result := False;
    Exit;
  End;

  If fatVenda.fPedidoComFalhaNaRetencaoDoImpostoDeRenda Then
  Begin
    fMensagem('ATENÇÃO', 'Cliente configurado para Reter IRPJ, porém o valor não foi calculado.' + #13 +
                         'É necessário efetuar a regravação do pedido!', ['&Ok']);
    Result := False;
    Exit;
  End;

  If fClienteComProblemaNaConsultaDeSituacaoCadastral(fatVenda.strCodCli, fatVenda.strEspDoc) Then
  Begin
    Result := False;
    Exit;
  End;

  //CARRGANDO DADOS DO CASHBACK
  fatVenda.blnSalGry := blnCliGry;
  fatVenda.fltCshGry := fltCshGry;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Realizando Gravação...', pgbStatus);

  pDefinirNumeroSerieCooLogTef;

  If (Result) Then
    fatVenda.pSetarCentroCustoFaturamento;

  Result := Result And fRealizarGravacao;

  If (Not Result) Then
    Exit;

  If fatVenda.blnRespMsg Then
  Begin
    fatVenda.blnRespMsg := False;
    Exit;
  End;

  blnGravouArquivos := True;

  If Result Then
  Try
    pAtualizaOrdemProducaoVinculada;
    blnConfirmouTEF := False;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Realizando impressão...', pgbStatus);

    For intContador := 0 To fatVenda.objFatVendaImp.ItemsCount -1 Do
    Begin
      dadosImpressao := fatVenda.objFatVendaImp[intContador];

      If (Not fEmptyStr(strCodEcf)) And (dadosImpressao.strEspDoc = 'IF') And (Not fCfgSis('USNFCE', varBoolean)) And (Not fUsaSat) Then
      Begin
        blnImprimiuCupom := fImprimirCupom(dadosImpressao, strNumCoo, strNumSer, strNumCcf);

        If Not blnImprimiuCupom Then
        Begin
          fMensagem('ATENÇÃO!', 'Ocorreu um erro na impressão do cupom ' + dadosImpressao.strNumDoc + '.' + #13#10 +
                                'Será necessário reimprimi-lo através da tecla F8 no Resumo de Caixa.', ['&Ok']);
        End;

      End;

      If ((chkEndEnt.Checked) And
          (chkEndEnt.Visible) And
          ((dadosImpressao.strEspDoc = 'IF')  Or ((dadosImpressao.strEspDoc = 'FF') And (Pos(dadosImpressao.strEspDoc, fCfgSis('ESP40C')) > 0))) And
          ((fCfgSis('USNFCE', varBoolean)) Or fUsaSat)) Then
      Begin
        For intVia := 1 To fCfgSis('QTDVEE', varInteger) Do
        Begin
          pImprimirDadosEntregaNFCe(dadosImpressao);
        End;
      End;

      If fCfgSis('IMPSER', varBoolean) then
      Begin
        If dadosImpressao.strEspDoc = 'NS' Then
        Begin
          If (Not TfrmComprovanteServicosExecutar.fImprimeLayoutEditor(dadosImpressao.strNumDoc, dadosImpressao.strEspDoc,
                                       dadosImpressao.strEmpDoc, dadosImpressao.strCodCli)) Then
          Begin
            TfrmComprovanteServicosExecutar.pImprime(dadosImpressao.strNumDoc,
                                                     dadosImpressao.strEspDoc,
                                                     dadosImpressao.strEmpDoc);
          End;
        End;
      End;

    End;


    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Confirmando Cartões TEF...', pgbStatus);

    {****************************************************************************}
    {* CASO NAO IMPRIMIU CUPOM FISCAL FINALIZA O TEF UTILIZANDO REL. GERENCIAL, *}
    {* POIS QUANDO IMPRIMIR CUPOM JA FINALIZA O TEF UTILIZANDO VINCULADO        *}
    {*************************************************************************JC*}
    If Not blnConfirmouTEF Then
    begin
      pRetornaIncDocTabela(fatVenda.strNumDoc,
                           fatVenda.strEspDoc,
                           fatVenda.strEmpDoc,
                           fatVenda.strCodCli,
                           strIncDoc,
                           strTabela);
      blnConfirmouTEF := fConfirmaCartoesTEF(NAO_USANDO_VINCULADO);
    end;

    If (Not blnConfirmouTEF) And ((Not fCfgSis('USNFCE', varBoolean)) And (Not fUsaSat)) And (fatVenda.strEspDoc = 'IF') Then
    Begin
      fMensagem('ATENÇÃO!', 'Ocorreu um erro na impressão do cupom ' + dadosImpressao.strNumDoc + '.' + #13#10 + 'O documento será cancelado!', ['&Ok']);
      blnCancelarCFTef := True;
    End
    Else
    Begin
      pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
      pInformacao('Digitação dos Cartões...', pgbStatus);

      pDigitacaoNumeroLiberacaoCartoes;
    End;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Abrindo Gaveta...', pgbStatus);

    strNumDocQuest := fatVenda.strNumDoc;
    strEspDocQuest := fatVenda.strEspDoc;

    If (dadosImpressao.strEspDoc <> 'IF') Or ((fCfgSis('USNFCE', varBoolean)) Or (fUsaSat)) And (Not blnCancelarCFTef) Then
      pAbrirGaveta(fatVenda.strConPag);
  Except
    On E: EAbort Do
    Begin
      fRollBack;
      blnImprimiuCupom := False;
      pMensagemOk('Não foi possível imprimir o cupom, para a emissão do mesmo utilize o botão f8 do Resumo de caixa.');
    End;

    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[Impressao: fFecharVenda]');
    End;
  End;

  If Result Then
  Begin
    pImprimirReciboCreditosPendentes(pgbStatus);
    pImprimirReciboCreditosUtilizados(pgbStatus);
  End;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Limpando variáveis utilizadas na venda...', pgbStatus);

  If Result Then
    pLimparVariaveisUsadasNaVenda;

  If (Result) And (Not blnCancelarCFTef) Then
  Begin
    Try
      If (Not blnCliCon And Not blnCliBal) Then
        pVerificarPromocaoBrindes('','')
      Else
      Begin
        For intContador := 0 To fatVenda.objFatVendaImp.ItemsCount -1 Do
        Begin
          pVerificarPromocaoBrindes(fatVenda.objFatVendaImp[intContador].strNumDoc,
                                    fatVenda.objFatVendaImp[intContador].strEspDoc);
        End;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmFatConfOrcamentos.fFecharVenda: pVerificarPromocaoBrindes]');
      End
    End;
  End;

  If (blnCancelarCFTef) Then
  Begin
    TfrmCancelamentoDocumentos.pCancelaCFTef(fatVenda.strNumDoc, fatVenda.strCodCli, VS_strCodEmp, fatVenda.strSerFsc);
  End;
end;

function TfrmFatConfOrcamentos.fFecharAdiantamento(pgbStatus: TcxProgressBar = nil): Boolean;
  Var
    intContador: Integer;
    fltFator: Double;
    fltTotCbs: Double;
    fltTotIbs: Double;
    fltTot_Is: Double;
begin
  Result := True;

  pgbStatus.Position := 0;
  pgbStatus.Properties.Max := 0;
  pgbStatus.Visible := False;

  pInformacao('Aguarde, Preparando Dados para Gravação...', pgbStatus);

  pDefinirNumeroSerieCooLogTef;

  pAcertaClienteCheque(cdsChequePre);
  pAcertaClienteCheque(cdsChequeVis);

  fatVenda.strOriF11 := 'S';
  fatVenda.blnConfOrcamento := True;
  fatVenda.strNomeForm := 'frmFatVendas';

  fatVenda.strNumDoc := edtNumOrc.Text;
  fatVenda.strNumOrc := edtNumOrc.Text;
  fatVenda.strEspOrc := strEspCfo;
  fatVenda.strEspDoc := strEspCfo;
  fatVenda.strEmpOri := fEmpresaDocumento;

  fatVenda.optTroco := optTroco;
  fatVenda.fltValorTroco := fltValorTroco;

  fatVenda.optTrocoPre := optTrocoPre;
  fatVenda.fltValorTrocoPre := fltValorTrocoPre;

  fatVenda.optTrocoCar := optTrocoCar;
  fatVenda.fltValorTrocoCar := fltValorTrocoCar;

  fatVenda.optTrocoDinheiro := optTrocoDin;
  fatVenda.fltValorTrocoDinheiro := fltValorTrocoDin;

  fatVenda.cdsChequePre.Data := cdsChequePre.Data;
  fatVenda.cdsChequeVis.Data := cdsChequeVis.Data;

  fatVenda.fltDupRec := 0;
  fatVenda.fltValAdt := 0;
  FillChar(fatVenda.recValAdt, SizeOf(fatVenda.recValAdt), #0);

  fatVenda.fltTroco_ := edtValTro.Value;
  fatVenda.blnTrocoComoCredito := blnTrocoComoCredito;

  pCarregaClienteVenda(fatVenda, fatVenda.strTabPre);
  pCarregaEnderecoEntregaVenda(fatVenda);

  pSalvaDuplicatas;

  If Not fVerificaStatusImpressora Then
    Exit(False);

  pAcertaDadosCondicaoPagamento(fatVenda);

  pDefineModalidades(fatVenda);

  If Not fDefineFormaPagamento(fatVenda) Then
    Exit(False);

  If fEmptyStr(fatVenda.strCodFpg) Then
    fatVenda.strCodFpg := strFpgOrc;

  fatVenda.cdsModalidade.Data := cdsModalidades.Data;

  fatVenda.fltTotGer := fStrToFloat(edtTotGer.Text);
  fatVenda.fltTotCadRec := fStrToFloat(edtTotGer.Text);

  fltFator := 0;

  If fFatGor('VLRCON').AsFloat <> 0 Then
    fltFator := fatVenda.fltTotCadRec / fFatGor('VLRCON').AsFloat;

  //Necessario para gravar o valor proporcional nos cheques e cartoes (ver fGravaCheques)
  fatVenda.fltTotIpi := fFatGor('TOTIPI').AsFloat * fltFator;
  fatVenda.fltTotRet := fFatGor('TOTRET').AsFloat * fltFator;
  fatVenda.fltDesAce := fFatGor('DESACE').AsFloat * fltFator;
  fatVenda.fltValFre := fFatGor('TOTFRE').AsFloat * fltFator;

  pCarregaTotalReformaPedido(fFatGor('AUTOINCREM').AsString, fltTotCbs, fltTotIbs, fltTot_Is);
  fatVenda.fltTotCBS := fltTotCbs * fltFator;
  fatVenda.fltTotIBS := fltTotIbs * fltFator;
  fatVenda.fltTotIS  := fltTot_Is * fltFator;

  fatVenda.pPegaDadosFiscais(fatVenda.fTrocaUFEndEntrega, fatVenda.strCliIes, fatVenda.strMicEmp, fatVenda.fGetUFEmpresa(''), True);

  SetLength(fatVenda.arrCartoes, Length(arrCartoes) + Length(arrCartFin));

  For intContador := Low(arrCartoes) To High(arrCartoes) Do
    fatVenda.arrCartoes[intContador] := arrCartoes[intContador];

  For intContador := Low(arrCartFin) To High(arrCartFin) Do
    fatVenda.arrCartoes[intContador + Length(arrCartoes)] := arrCartFin[intContador];

  fatVenda.stlDupCreditos.Assign(stlDupCreditos);
  fatVenda.fltCredUtilizados := fltCredUtilizados;

  fatVenda.strInfErro := strInfErro;

  //CARREGANDO DADOS PARA GRAVAR RECEBIMENTO GRYNCASH
  fatVenda.blnSalGry := blnCliGry;
  fatVenda.fltCshGry := fltCshGry;

  pInformacao('Aguarde, Realizando Gravação...', pgbStatus);

  pDefinirNumeroSerieCooLogTef;

  If (Result) Then
    fatVenda.pSetarCentroCustoFaturamento;

  Result := Result And fRealizarGravacao;

  If (Not Result) Then
    Exit;

  If fatVenda.blnRespMsg Then
  Begin
    fatVenda.blnRespMsg := False;
    Exit;
  End;

  blnGravouArquivos := True;

  If Result Then
  begin
    try
      pRetornaIncDocTabela(fatVenda.strNumDoc,
                           fatVenda.strEspDoc,
                           fatVenda.strEmpDoc,
                           fatVenda.strCodCli,
                           strIncDoc,
                           strTabela);
      blnConfirmouTEF := fConfirmaCartoesTEF(NAO_USANDO_VINCULADO);

      pAbrirGaveta(fatVenda.strConPag);
      pDigitacaoNumeroLiberacaoCartoes;
      pImprimirReciboAdiantamentoPedido(pgbStatus);
      pImprimirReciboCreditosPendentes(pgbStatus);
      pImprimirReciboCreditosUtilizados(pgbStatus);
    finally
      pLimparVariaveisUsadasNaVenda;
    end;
  End;

end;

function TfrmFatConfOrcamentos.fRetValorAReceberComUtilizaCredito: Double;
begin
  Result := 0.00;
  
  If (fStatusCndPag(fatVenda.strConPagOri) = A_PRAZO) And (fatVenda.strCodFpg = '009') And (fatVenda.fltValCre <> 0.00) And (fatVenda.fltVlARec > 0.00) Then  
    Result := fatVenda.fltVlARec;
end;

function TfrmFatConfOrcamentos.fRetEspecieSelecionada: String;
begin
  Result := fTipoFaturamentoSelec.strEspDoc;
end;

function TfrmFatConfOrcamentos.fGetTotalParcelasPedido: Double;
  Var
    intContador: Integer;
begin
  Result := 0;

  If qryFatGor.Active And Not qryFatGor.IsEmpty Then
    For intContador := 0 To 23 Do
      Result := Result + fatVenda.arrDuplicataCND[intContador].curValor;
End;


function TfrmFatConfOrcamentos.fGetTotGer(fltTotGer: Double): Double;
var
  fltDiferencaToleradaF11: Double;
begin
  Result := fltTotGer;

  fltDiferencaToleradaF11 := TOLERANCIA_DIFERENCA_F11;

  if (fatVenda.fltTotProBri > 0) Then
    if (fFormataFloat(fatVenda.fltTotProBri, 2) <= fFormataFloat(fltDiferencaToleradaF11, 2)) then
      Exit;

  If (CompareValue(fltTotGer, fStrToFloat(edtTotGer.Text), TOLERANCIA_DIFERENCA_F11) = EqualsValue) Then
    Result := fStrToFloat(edtTotGer.Text);
end;

function TfrmFatConfOrcamentos.fDefineAbastecimentoItensPDAVista: Boolean;
begin
  Result := False;

  if (not fCfgSis('REQAUT', varBoolean)) then
    Exit;

  if (fStatusCndPag(fatVenda.strConPag) <> A_VISTA) then
    Exit;

  Result := True;
end;

function TfrmFatConfOrcamentos.fDefineFormaPagamento(fatVenda: TFatVenda): Boolean;
  Var
    intContador     : Integer;
    blnCalcDigDuplic: Boolean;
    arrDatas        : TDateArray;
    fltTotpar       : Double;
    fltDifere       : Double;
    fltTotDup       : Double;
    fltTotGrl       : Double;
    dtaDtaBas       : TDate;

    blnParcelasDeAcordoComDigDuplic: Boolean;
    blnSabDomFeriadosComoDiaUtil: Boolean;

    LblnUtilizarDataEmissaoCalcularDiaVencimento: boolean;

  function fGetValorAVista: Double;
  begin
    Result := fatVenda.fltValDin +
              fatVenda.fltValCqP +
              fatVenda.fltValCqV +
              fatVenda.fltValCar +
              fatVenda.fltValFin +
              fatVenda.fltValOrd +
              IIF(fRetValorAReceberComUtilizaCredito > 0, 0, fatVenda.fltVlARec) +
              fltCredUtilizados;
  end;

  procedure pInserirParcelaAVista;
    Var
      intContador: Integer;
  begin
    For intContador := Low(fatVenda.arrDuplicata) To High(fatVenda.arrDuplicata) Do
      If Not fEmptyStr(fatVenda.arrDuplicata[intContador].dtaDtaVen) Then
        fatVenda.arrDuplicata[intContador].strSequen := String(arrLetras[intContador + 1]);

    If (fFormataFloat(fltCredUtilizados, 2) = 0.00) Then
    Begin
      For intContador := High(fatVenda.arrDuplicata) DownTo Low(fatVenda.arrDuplicata)+1 Do
        fatVenda.arrDuplicata[intContador] := fatVenda.arrDuplicata[intContador-1];

      fatVenda.arrDuplicata[0].strSequen := 'A';
      fatVenda.arrDuplicata[0].curValor  := fGetValorAVista;
      fatVenda.arrDuplicata[0].dtaDtaVen := DateToStr(VS_Date);
    End
    Else If (fFormataFloat(fltCredUtilizados, 2) = fFormataFloat(fGetValorAVista, 2)) Then
    Begin
      For intContador := High(fatVenda.arrDuplicata) DownTo Low(fatVenda.arrDuplicata)+1 Do
        fatVenda.arrDuplicata[intContador] := fatVenda.arrDuplicata[intContador-1];

      fatVenda.arrDuplicata[0].strSequen := 'A';
      fatVenda.arrDuplicata[0].curValor  := fGetValorAVista;
      fatVenda.arrDuplicata[0].dtaDtaVen := DateToStr(VS_Date);

      fatVenda.intSeqDupBaiUtiCred := 0;
      fatVenda.blnZerDin := True;
    End
    Else
    Begin
      For intContador := High(fatVenda.arrDuplicata) DownTo Low(fatVenda.arrDuplicata)+2 Do
        fatVenda.arrDuplicata[intContador] := fatVenda.arrDuplicata[intContador-2];

      fatVenda.arrDuplicata[0].strSequen := 'A';
      fatVenda.arrDuplicata[0].curValor  := fGetValorAVista - fltCredUtilizados;
      fatVenda.arrDuplicata[0].dtaDtaVen := DateToStr(VS_Date);

      fatVenda.arrDuplicata[1].strSequen := 'A';
      fatVenda.arrDuplicata[1].curValor  := fltCredUtilizados;
      fatVenda.arrDuplicata[1].dtaDtaVen := DateToStr(VS_Date);

      fatVenda.intSeqDupBaiUtiCred := 1;
    End;
  end;

begin
  Result := True;
  fatVenda.intSeqDupBaiUtiCred := -1;
  fatVenda.blnUsouValDupOriComDesmembramento := False;

  blnSabDomFeriadosComoDiaUtil := fCfgSis('FSDUDP', varBoolean);

  SetLength(arrDatas, 0);
  blnCalcDigDuplic := True;

  blnParcelasDeAcordoComDigDuplic := True;

  If (Pos(fatVenda.strCodFpg, '002_007_') > 0) And (fCfgSis('PRACHC', varBoolean)) Then
    blnParcelasDeAcordoComDigDuplic := False; // TEM QUE SER ANTES DE MUDAR A FORMA DE PAGAMENTO.

  fltTotpar := 0;

  For intContador := 0 to 23 do
  Begin
    fatVenda.arrDuplicata[intContador] := arrDuplicataSav[intContador];
    fatVenda.arrDuplicata[intContador].curValor := fFormataFloat( fatVenda.arrDuplicata[intContador].curValor, 2);
    fltTotpar := fltTotpar + fatVenda.arrDuplicata[intContador].curValor;
  End;

  If blnRealizandoAdiantamentoPedidoPeloF11 Then
  Begin
    fltTotGrl := fStrToFloat(edtTotGer.Text);
    blnParcelasDeAcordoComDigDuplic := False;
  End
  Else
  Begin
    fltTotGrl := fGetTotGer(fatVenda.fltTotGer);

    If (fatVenda.strRetIss = 'S') And (fatVenda.fltValIss > 0) Then
    Begin
      blnParcelasDeAcordoComDigDuplic := False;//Duplicatas do pedido nao tem o desconto do ISS FGO_VPARXX
      fltTotGrl := fltTotGrl - fatVenda.fltValIss;
    End;

    If (fatVenda.fltTotProBri > 0) Then
      fltTotGrl := fltTotGrl - fatVenda.fltTotProBri;

    If fDestacarRetencoesServicos Then
    Begin
      If fatVenda.fTotalRetencoesServicos > 0 Then
        fltTotGrl := fltTotGrl - fatVenda.fTotalRetencoesServicos;
    End;

    If fatVenda.fltDupRec + fatVenda.fltValAdt > 0 Then
      fltTotGrl := fltTotGrl - fatVenda.fltDupRec - fatVenda.fltValAdt;
  End;

  {******************************************************}
  {* PEGA A DIFERENCA DO VALOR TOTAL DO DOCUMENTO ATUAL *}
  {***************************************************JB*}
  fltDifere := fStrToFloat(edtTotGer.Text) - fltTotGrl;

  If (fltTotpar = 0) Then
    pZeraDigDuplic(fatVenda.arrDuplicata);

  fatVenda.strCodFpg := cdsModalidades.FieldByName('CODFPG').AsString;

  If (cdsModalidades.RecordCount > 1) Then
  Begin
    cdsModalidades.First;
    While (Not cdsModalidades.Eof) Do
    Begin
      If (fatVenda.strCodFpg <> cdsModalidades.FieldByName('CODFPG').AsString) Then
      Begin
        fatVenda.strCodFpg := '009';
        Break;
      End;

      cdsModalidades.Next;
    End;

  End;

  If (Pos(fatVenda.strCodFpg, '013_') > 0) Then
    fatVenda.blnZerDin := True;

  {************************************************************************}
  {* DEFINIÇÃO DA CONDIÇÃO DE PAGAMENTO:                                  *}
  {*                                                                      *}
  {* 001,002,006,007,013: SEMPRE À VISTA.                                 *}
  {* 008,010: SEMPRE A PRAZO. CASO A CONDIÇÃO VENHA A VISTA DO ORÇAMENTO, *}
  {*          TRANSFORMA PARA A PRAZO.                                    *}
  {* 012,014,015: GRAVA A CONDIÇÃO QUE VEIO DO ORÇAMENTO.                 *}
  {*********************************************************************MV*}
  If fatVenda.fCodFpgSempreAVista Or
     (fatVenda.fVaiBaixarOrdemPagamento And fatVenda.fBaixaDuplicataAVista(strEmpLog)) Then
  Begin
    If (Pos(fatVenda.strCodFpg, '002_007_') > 0) And (fCfgSis('PRACHC', varBoolean)) Then
      blnParcelasDeAcordoComDigDuplic := False;

    fatVenda.strConPag := '01000';
  End;

  { ****************************************************************************}
  { AJUSTE PARA CORREÇÃO DE ERRO PONTUAL:                                      *}
  { * QUANDO OCORRER MUDANÇA DE CARTÃO (007) PARA ORDEM DE PAGAMENTO (012)     *}
  { * ATRIBUIR A CONDIÇÃO DE PAGAMENTO "A VISTA", POIS O SISTEMA ESTAVA        *}
  { * MANTENDO A CONDIÇÃO DO PEDIDO/ORC E GERAVA PARCELAS INCORRETAS NA ADTCLI *}
  { **************************************************************************KM}
  If fTroca007Para012 Then
    fatVenda.strConPag := '01000';

  (***********************************************************************)
  (* SE MUDAR A FORMA DE PAGAMENTO PARA A VISTA ENTAO IGNORA AS PARCELAS *)
  (*******************************************************************LAG*)

  { **************************************************************************}
  {* SE A TROCA DA FORMA DE PAGAMENTO NÃO FOI DE 007 PARA 012,               *}
  {* PERMITIR A ALTERAÇÃO DA blnParcelasDeAcordoComDigDuplic = FALSE         *}
  {* SENÃO, ELA PRECISA SER MANTIDA COMO TRUE, PARA ATUALIZAR O arrDuplicata *}
  {************************************************************************KM*}
  If (fatVenda.strCodFpg <> strFpgOrc) And (not fTroca007Para012) And
     (Pos(fatVenda.strCodFpg, '001_002_006_007_012') > 0) Then
    blnParcelasDeAcordoComDigDuplic := False;

  (******************************************************************)
  (* CASO O VALOR DAS PARCELAS FOR DIFERENTE DO NEGOCIADO NO PEDIDO *)
  (**************************************************************JC**)
  If fFormataFloat(fltTotpar, 2) <> fFormataFloat(fGetTotalParcelasPedido, 2) Then
    blnParcelasDeAcordoComDigDuplic := False;

  (***********************************************************************)
  (* CASO A QUANTIDADE DE PARCELAS SEJA DIFERENTE DO NEGOCIADO NO PEDIDO *)
  (*******************************************************************JC**)
  If (qryFatGor.Active And Not qryFatGor.IsEmpty) And
     (LeftStr(fatVenda.strConPag, 2) <> LeftStr(fFatGor('CONPAG').AsString, 2)) Then
    blnParcelasDeAcordoComDigDuplic := False;

  (************************************************************************)
  (* CASO POSSUA DUPLICATAS QUITADAS DEVE IGNORAR AS NEGOCIADAS NO PEDIDO *)
  (********************************************************************JC**)
  If fFormataFloat(fatVenda.fltDupRec + fatVenda.fltValAdt, 2) > 0 Then
    blnParcelasDeAcordoComDigDuplic := False;

  If (Pos(fatVenda.strCodFpg, '008_010') > 0) Or
     (fatVenda.fltFatura > 0.0)               Or
     (fatVenda.fltValVle > 0.0)               Or
     (fRetValorAReceberComUtilizaCredito > 0) Then
  Begin
    If (fStatusCndPag(fatVenda.strConPag) = A_VISTA) Then
      fatVenda.strConPag := '01001'

    Else If (Copy(fatVenda.strConPag,3,3) = '000') And (fFormataFloat(fGetValorAVista,2) = 0) Then
      fatVenda.strConPag := Copy(fatVenda.strConPag,1,2) + '001' + Copy(fatVenda.strConPag,6,Length(fatVenda.strConPag));
  End;

  LblnUtilizarDataEmissaoCalcularDiaVencimento := (Not fatVenda.fCodFpgSempreAVista()) And
                                                  fatVenda.fUtilizarDataEmissaoCalcularDiaVencimento;
  {******************************************}
  {* CASO SEJA PARCELADO, VERIFICA A NECES- *}
  {* SIDADE DE REMONTAR A COND. DE PAGAMENTO*}
  {***************************************MV*}
  If (fatVenda.strCodFpg = '009') Then
  Begin

    fatVenda.blnZerDin := False;

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
        fatVenda.strConPag := fRetornaCndPag(fatVenda.arrDuplicata, fatVenda.dtaPreVis)
      Else
        fatVenda.strConPag := fatVenda.strConPagOri;
    End;

    If (fatVenda.fltFatura > 0) Or
       (fatVenda.fltValVle > 0) Or
       (fRetValorAReceberComUtilizaCredito > 0) Then
    Begin

      If (fStatusCndPag(fatVenda.strConPag) = A_VISTA) Then
        fatVenda.strConPag := '01001';

      If (fGetValorAVista > 0) Then
      Begin
        dtaDtaBas := VS_Date;

        blnCalcDigDuplic := False;

        {*****************************************}
        {* CASO A CONDIÇÃO NÃO TENHA A VISTA     *}
        {**************************************AF*}
        If Copy(fatVenda.strConPag, 3, 3) <> '000' Then
        Begin
          fltTotDup := RoundTo(fatVenda.fltFatura + fatVenda.fltValVle + fRetValorAReceberComUtilizaCredito, -2);
          If fltTotDup > 0 Then
          Begin
            {***************************************************************************************}
            {* UTILIZA A DATA DA EMISSÃO DO PEDIDO COMO BASE PARA CALCULO DA CONDIÇÃO DE PAGAMENTO *}
            {************************************************************************************PZ*}
            If (fUtilizarComoDataBaseCtrDataEmissaoPedido(fatVenda.fFaturandoPedido, LblnUtilizarDataEmissaoCalcularDiaVencimento)) Then
            Begin
              {**********************************************************************************************}
              {* CASO O PEDIDO ESTEJA SENDO FATURADO ANTECIPADAMENTE À DATA DE PREVISÃO, UTILIZAR ESSA DATA *}
              {*******************************************************************************************KM*}
              If (fUtilizarComoDataBaseCtrDataPrevisaoPedido(fatVenda.fFaturandoPedido)) And (fatVenda.dtaPreVis <> 0) And (VS_Date < fatVenda.dtaPreVis) Then
                dtaDtaBas := fatVenda.dtaPreVis
              Else
                dtaDtaBas := fatVenda.dtaDtaEntOri;
            End
            Else If fatVenda.fUtilizarDataPrvDataFatComoDataBaseParaCalculoVencimento Then
              dtaDtaBas := fRetDataBaseCalculoCondicaoPagto(fatVenda.dtaPreVis, fatVenda.fFaturandoPedido, fatVenda.dtaDtaEntOri, LblnUtilizarDataEmissaoCalcularDiaVencimento);

            fDigDuplic( fatVenda.arrDuplicata, fatVenda.strConPag, 0, fltTotDup, False, False,
                        False, dtaDtaBas, False, 0, 'N', True, False, 0,
                        False, Nil, '', blnSabDomFeriadosComoDiaUtil, True,
                        Nil, '', False, True, '', '', Nil, fatVenda.fFaturandoPedido,
                        False, Nil, False, False, 0, '', fatVenda.strCodCid,
                        '', False, LblnUtilizarDataEmissaoCalcularDiaVencimento);

            pInserirParcelaAVista;
          End
          Else
          Begin
            FillChar(fatVenda.arrDuplicata, Sizeof(fatVenda.arrDuplicata), #0);
          End;
        End
        Else
        Begin
          fatVenda.strConPag := fStrZero(IntToStr( StrToInt( Copy(fatVenda.strConPag,1,2) ) -1), 2) + Copy(fatVenda.strConPag,6,Length(fatVenda.strConPag));

          fltTotDup := RoundTo(fatVenda.fltFatura + fatVenda.fltValVle + fRetValorAReceberComUtilizaCredito, -2);
          If fltTotDup > 0 Then
          Begin
            {***************************************************************************************}
            {* UTILIZA A DATA DA EMISSÃO DO PEDIDO COMO BASE PARA CALCULO DA CONDIÇÃO DE PAGAMENTO *}
            {************************************************************************************PZ*}
            If (fUtilizarComoDataBaseCtrDataEmissaoPedido(fatVenda.fFaturandoPedido, LblnUtilizarDataEmissaoCalcularDiaVencimento)) Then
            Begin
              {**********************************************************************************************}
              {* CASO O PEDIDO ESTEJA SENDO FATURADO ANTECIPADAMENTE À DATA DE PREVISÃO, UTILIZAR ESSA DATA *}
              {*******************************************************************************************KM*}
              If (fUtilizarComoDataBaseCtrDataPrevisaoPedido(fatVenda.fFaturandoPedido)) And (fatVenda.dtaPreVis <> 0) And (VS_Date < fatVenda.dtaPreVis) Then
                dtaDtaBas := fatVenda.dtaPreVis
              Else
                dtaDtaBas := fatVenda.dtaDtaEntOri;
            End
            Else If fatVenda.fUtilizarDataPrvDataFatComoDataBaseParaCalculoVencimento Then
              dtaDtaBas := fRetDataBaseCalculoCondicaoPagto(fatVenda.dtaPreVis, fatVenda.fFaturandoPedido, fatVenda.dtaDtaEntOri, LblnUtilizarDataEmissaoCalcularDiaVencimento);

            fDigDuplic( fatVenda.arrDuplicata, fatVenda.strConPag, 0, fltTotDup, False, False,
                        False, dtaDtaBas, False, 0, 'N', True, False, 0,
                        False, Nil, '', blnSabDomFeriadosComoDiaUtil, True,
                        Nil, '', False, True, '', '', Nil, fatVenda.fFaturandoPedido,
                        False, Nil, False, False, 0, '', fatVenda.strCodCid,
                        '', False, LblnUtilizarDataEmissaoCalcularDiaVencimento);

            pInserirParcelaAVista;
          End
          Else
          Begin
            FillChar(fatVenda.arrDuplicata, Sizeof(fatVenda.arrDuplicata), #0);
          End;
        End;

        For intContador := Low(fatVenda.arrDuplicata) To High(fatVenda.arrDuplicata) Do
        Begin

          If fEmptyStr(fatVenda.arrDuplicata[intContador].dtaDtaVen) Then
            Break;

          If (intContador > 0) And
             (fatVenda.arrDuplicata[intContador].dtaDtaVen = fatVenda.arrDuplicata[intContador -1].dtaDtaVen) Then
            Continue;

          SetLength(arrDatas, Length(arrDatas)+1);
          arrDatas[Length(arrDatas)-1] := StrToDate(fatVenda.arrDuplicata[intContador].dtaDtaVen);
        End;

        fatVenda.strConPag := fRetornaCndPag(arrDatas, VS_Date);

      End;

    End
    Else
    Begin
      {*****************************************}
      {* CASO NÃO TENHA FATURADO               *}
      {**************************************AF*}
      fatVenda.strConPag := '01000';
    End;

  End;

  If (blnParcelasDeAcordoComDigDuplic) Then
    blnParcelasDeAcordoComDigDuplic := Not (fStatusCndPag(fatVenda.strConPag) = A_VISTA);

  If (blnCalcDigDuplic) Then
  Begin
    fltTotDup := fFormataFloat(fltTotGrl - fltTotCreditos, 2);

    If (fltTotDup > 0) And (fltTotCreditos <= 0) Then
    Begin
      dtaDtaBas := VS_Date;

      {***************************************************************************************}
      {* UTILIZA A DATA DA EMISSÃO DO PEDIDO COMO BASE PARA CALCULO DA CONDIÇÃO DE PAGAMENTO *}
      {************************************************************************************PZ*}
      If (fUtilizarComoDataBaseCtrDataEmissaoPedido(fatVenda.fFaturandoPedido, LblnUtilizarDataEmissaoCalcularDiaVencimento)) Then
      Begin
        {**********************************************************************************************}
        {* CASO O PEDIDO ESTEJA SENDO FATURADO ANTECIPADAMENTE À DATA DE PREVISÃO, UTILIZAR ESSA DATA *}
        {*******************************************************************************************KM*}
        If (fUtilizarComoDataBaseCtrDataPrevisaoPedido(fatVenda.fFaturandoPedido)) And (fatVenda.dtaPreVis <> 0) And (VS_Date < fatVenda.dtaPreVis) Then
          dtaDtaBas := fatVenda.dtaPreVis
        Else
          dtaDtaBas := fatVenda.dtaDtaEntOri;

        fatVenda.strConPag := fatVenda.strConPagOri;
      End
      Else If fatVenda.fUtilizarDataPrvDataFatComoDataBaseParaCalculoVencimento Then
      Begin
        dtaDtaBas := fRetDataBaseCalculoCondicaoPagto(fatVenda.dtaPreVis, fatVenda.fFaturandoPedido, fatVenda.dtaDtaEntOri, LblnUtilizarDataEmissaoCalcularDiaVencimento);
        fatVenda.strConPag := fatVenda.strConPagOri;
      End;

      fDigDuplic(fatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses(fatVenda.strConPag), 0, fltTotDup,
                                               FAlse, False, False, dtaDtaBas, False,
                                               0, 'N', True, False, 0,
                                               False, Nil, '', blnSabDomFeriadosComoDiaUtil, True, Nil, '', False, True, '','', Nil, fatVenda.fFaturandoPedido,
                                               False, Nil, False, False, 0, '', fatVenda.strCodCid,
                                               '', False, LblnUtilizarDataEmissaoCalcularDiaVencimento);

      If (fltTotCreditos = 0) And (Not qryFatGor.IsEmpty) And cdsItensAdd.IsEmpty And
         ((Not blnDesmembrarVenda) Or (blnDesmembrarVenda And (fCfgSis('DUPORP', varBoolean)))) Then
      Begin

        If (fltTotpar > 0)                                            And
           (fFormataFloat(fatVenda.arrDuplicataCND[0].curValor, 2) - fltDifere > 0) And
           (blnParcelasDeAcordoComDigDuplic)                           Then
        Begin
          For intContador := 0 To 23 Do
          Begin
            If (fEmptyStr(fatVenda.arrDuplicata[intContador].strSequen)) Then
              Break;
            fatVenda.arrDuplicata[intContador].curValor := fFormataFloat(fatVenda.arrDuplicataCND[intContador].curValor, 2);
            fatVenda.blnUsouValDupOriComDesmembramento := True;
          End;
          fatVenda.arrDuplicata[0].curValor := fatVenda.arrDuplicata[0].curValor - fltDifere;
        End;

      End;

      fatVenda.strConPag := fRetornaCndPag(fatVenda.arrDuplicata, VS_Date);

    End
    Else If (fltTotCreditos > 0) Then
    Begin

      If (fFormataFloat(fltTotGrl, 2) > fFormataFloat(fltTotCreditos, 2)) Then
      Begin
        fDigDuplic(fatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses(fatVenda.strConPag), 0, fltTotDup,
                                                 FAlse, False, False, VS_Date, False,
                                                 0, 'N', True, False, 0,
                                                 False, Nil, '', blnSabDomFeriadosComoDiaUtil,
                                                 True, Nil, '', False, True, '', '', Nil, False, False, Nil, False, False, 0, '', fatVenda.strCodCid );
        fatVenda.intSeqDupBaiUtiCred := 1;

        For intContador := High(fatVenda.arrDuplicata)-1 DownTo 1 Do
        Begin
          fatVenda.arrDuplicata[intContador+1] := fatVenda.arrDuplicata[intContador];
        End;

        fatVenda.arrDuplicata[1].strSequen := 'A';
        fatVenda.arrDuplicata[1].curValor  := fltTotCreditos;
        fatVenda.arrDuplicata[1].dtaDtaVen := DateToStr(VS_Date);
      End
      Else
      Begin
        pZeraDigDuplic(fatVenda.arrDuplicata);
        fatVenda.intSeqDupBaiUtiCred := 0;
        fatVenda.arrDuplicata[0].strSequen := 'A';
        fatVenda.arrDuplicata[0].curValor  := fltTotGrl;
        fatVenda.arrDuplicata[0].dtaDtaVen := DateToStr(VS_Date);
      End;

    End
    Else
    Begin
      FillChar(fatVenda.arrDuplicata, Sizeof(fatVenda.arrDuplicata), #0);
    End;
  End;

  If Result And (fatVenda.fltValAdt > 0) And (Not blnRealizandoAdiantamentoPedidoPeloF11) Then
  Begin
    Result := fatVenda.fAdicionaAdiantamentoPrimeiraParcela;
    {**********************************************************}
    {* O ADIANTAMENTO ENTROU COMO PRIMEIRA PARCELA DESLOCANDO *}
    {* TODAS AS OUTRAS PARA FRENTE                            *}
    {*******************************************************JC*}
    If Result And (fatVenda.intSeqDupBaiUtiCred <> -1) Then
      Inc(fatVenda.intSeqDupBaiUtiCred);
  End;

  For intContador := Low(fatVenda.arrDuplicata) To High(fatVenda.arrDuplicata) Do
    fatVenda.arrDuplicCop[intContador] := fatVenda.arrDuplicata[intContador];
end; {pDefineFormaPagamento}

procedure TfrmFatConfOrcamentos.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  If edtCodCli.ReadOnly Then
    Exit;

  If blnRealizandoAdiantamentoPedidoPeloF11 Then
    Exit;

  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If strCodCliAnt <> (edtCodCli.Text) Then
      blnMudouCodCli := True;

    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);

  End;
end;

procedure TfrmFatConfOrcamentos.edtCodEmpExit(Sender: TObject);
begin
  inherited;

  If (intEmpBai = 2) And blnAltLoj And (Not fEmptyStr(edtCodEmp.Text)) Then
    pSetaEmpresaLogada(edtCodEmp.Text);

end;

procedure TfrmFatConfOrcamentos.pDefineModalidades(fatVenda: TFatVenda);
  Var
    strModAtu: String;
    strFpgAtu: String;
    strDesMod: String;
    strInfAdi: String;
    fltValMod: Double;
    fltPreMod: Double;
    fltDifMod: Double;
    fltTotGrl: Double;
    cdsModAux: TUniClientDataSet;
    blnTemTroco: Boolean;
    blnTemValorAdiantadoMaiorQueFaturado: Boolean;
    blnLancaDiferencaComoDinheiro: Boolean;

    LPixAvulso,
    LPortadorOrdPag: String;

    function fComparaModalidades: Boolean;
    begin
      Result := strFpgAtu = cdsModalidades.FieldByName('CODFPG').AsString;
    end;
begin

  blnTemValorAdiantadoMaiorQueFaturado := False;
  
  If blnRealizandoAdiantamentoPedidoPeloF11 Then
    fltTotGrl := fStrToFloat(edtTotGer.Text)
  Else
  Begin
    fltTotGrl := fGetTotGer(fatVenda.fltTotGer);

    If (fatVenda.strRetIss = 'S') And (fatVenda.fltValIss > 0) Then
      fltTotGrl := fltTotGrl - fatVenda.fltValIss;

    If (fatVenda.fltTotProBri > 0) Then
      fltTotGrl := fltTotGrl - fatVenda.fltTotProBri;

    If fDestacarRetencoesServicos Then
    Begin
      If fatVenda.fTotalRetencoesServicos > 0 Then
        fltTotGrl := fltTotGrl - fatVenda.fTotalRetencoesServicos;
    End;

    If fatVenda.fltDupRec + fatVenda.fltValAdt > 0 Then
    Begin
      fltTotGrl := fFormataFloat(fltTotGrl - fatVenda.fltDupRec - fatVenda.fltValAdt, 2);

      blnTemValorAdiantadoMaiorQueFaturado := (fltTotGrl < 0.00);
    End;
  End;

  If Assigned(ecfFiscal) Then
  Begin
    ecfFiscal.strCodVen := fatVenda.strCodVen;
    ecfFiscal.strNomVen := fatVenda.strCodVen + '-' + fatVenda.strNomVen;
    ecfFiscal.strNumDoc := fatVenda.strNumDoc;
    ecfFiscal.strCodCli := edtCodCli.Text;
    ecfFiscal.strNomCli := edtNomCli.Text;
    ecfFiscal.strEndCli := edtEndEnt.Text;
    ecfFiscal.strBaiCli := edtBaiEnt.Text;
    ecfFiscal.strCepCli := mskCepEnt.Text;
    ecfFiscal.strCidCli := edtNomCid.Text;
    ecfFiscal.strEstCli := edtUF.Text;
    ecfFiscal.strCgcCpf := mskCgcCpf.Text;
    ecfFiscal.strIesCli := strCliIes;
    ecfFiscal.strRG_Cli := mskNumR_G.Text;
  End;

  cdsModAux := TUniClientDataSet.Create(Nil);

  {***************************************}
  {* CRIA OS AGGREGATES                  *}
  {************************************AF*}
  cdsModAux.AggregatesActive := True;
  With TAggregateField.Create(cdsModAux) Do
  Begin
    FieldName     := 'TOT_VALORMOD';
    DataSet       := cdsModAux;
    Expression    := 'SUM(VALOR)';
    Active        := True;
  End;

  {*****************************************}
  {* FAZ UMA COPIA DA ESTRUTURA            *}
  {**************************************AF*}
  cdsModAux.Data := cdsModalidades.Data;
  cdsModAux.EmptyDataSet;
  cdsModAux.IndexFieldNames := 'VALOR';

  fatVenda.FValorTFAutomatica := 0.0;
  LPixAvulso := JaRecebidoEmPixOuPixAvulso;

  cdsModalidades.First;
  While Not cdsModalidades.Eof Do
  Begin
    strModAtu := cdsModalidades.FieldByName('ECF_CODMOD').AsString;
    strFpgAtu := cdsModalidades.FieldByName('CODFPG').AsString;
    strDesMod := Trim(cdsModalidades.FieldByName('ECF_DESMOD').AsString);
    strInfAdi := cdsModalidades.FieldByName('ECF_INFADI').AsString;
    fltValMod := 0.0;

    While (Not cdsModalidades.Eof) And (fComparaModalidades) Do
    Begin
      fltValMod := fltValMod + cdsModalidades.FieldByName('VALOR').AsFloat;

      If Not cdsModalidades.FieldByName('PORTADOR_ORDPAG').AsString.IsEmpty Then
      Begin
        LPortadorOrdPag := cdsModalidades.FieldByName('PORTADOR_ORDPAG').AsString;
        fatVenda.FValorTFAutomatica := fFormataFloat(fatVenda.FValorTFAutomatica + cdsModalidades.FieldByName('VALOR').AsFloat, 2);
      End;

      cdsModalidades.Next;
    End;

    {*****************************************}
    {* AJUSTE DAS MODALIDADES                *}
    {**************************************AF*}
    fltPreMod := fFormataFloat(fltValMod, 2);

    cdsModAux.Append;
    cdsModAux.FieldByName('CODFPG').AsString     := strFpgAtu;
    cdsModAux.FieldByName('ECF_CODMOD').AsString := strModAtu;
    cdsModAux.FieldByName('ECF_DESMOD').AsString := strDesMod;
    cdsModAux.FieldByName('ECF_INFADI').AsString := strInfAdi;
    cdsModAux.FieldByName('VALOR').AsFloat       := fltPreMod;
    cdsModAux.FieldByName('PORTADOR_ORDPAG').AsString := LPortadorOrdPag;

    cdsModAux.FieldByName('PIX_AVULSO').AsString := 'N';
    If cdsModAux.FieldByName('CODFPG').AsString.Equals('012') Then
      cdsModAux.FieldByName('PIX_AVULSO').AsString := LPixAvulso;

    cdsModAux.Post;
  End;

  {*****************************************}
  {* TERMINO DE AJUSTE DAS MODALIDADES     *}
  {**************************************AF*}
  cdsModAux.First;
  If (cdsModAux.AggFields.FieldByName('TOT_VALORMOD').IsNull) Then
    fltPreMod := 0
  Else
    fltPreMod := cdsModAux.AggFields.FieldByName('TOT_VALORMOD').Value;

  If (optTroco    In [otNada, otCredito]) And
     (optTrocoPre In [otNada, otCredito]) And
     (optTrocoCar In [otNada, otCredito]) And
     (optTrocoDin In [otNada, otCredito]) And
     (Not blnTrocoComoCredito) Then
    fltPreMod := fltPreMod - fFormataFloat(edtValTro.Value, 2);

  blnTemTroco := ((optTroco = otTroco) Or (optTrocoPre = otTroco) Or (optTrocoCar = otTroco) Or (optTrocoDin = otTroco) Or (blnTrocoComoCredito));

  blnLancaDiferencaComoDinheiro := (Not blnTemTroco) And
                                   (Not blnTemValorAdiantadoMaiorQueFaturado) And
                                   (Not blnLiberouPromocaoVencida);

  If blnLancaDiferencaComoDinheiro Then
  Begin
    fltDifMod := fltTotGrl - fltPreMod;

    If fltDifMod <> 0 Then
    Begin
      cdsModAux.Edit;
      cdsModAux.FieldByName('VALOR').AsFloat := cdsModAux.FieldByName('VALOR').AsFloat + fltDifMod;
      cdsModAux.Post;
    End;
  End;

  fatVenda.fltValCqP := 0.0;
  fatVenda.fltValCqV := 0.0;
  fatVenda.fltValDin := 0.0;
  fatVenda.fltValCar := 0.0;
  fatVenda.fltValFin := 0.0;
  fatVenda.fltValOrd := 0.0;
  fatVenda.fltFatura := 0.0;
  fatVenda.fltVlARec := 0.0;//A receber
  fatVenda.fltValVle := 0.0;
  fatVenda.fltValCre := 0.0;

  cdsModAux.First;
  While (Not cdsModAux.Eof) Do
  Begin

    If (cdsModAux.FieldByName('CODFPG').AsString = '002') Then
      fatVenda.fltValCqP := fatVenda.fltValCqP + cdsModAux.FieldByName('VALOR').AsFloat

    Else If (cdsModAux.FieldByName('CODFPG').AsString = '006') Then
      fatVenda.fltValCqV := fatVenda.fltValCqV + cdsModAux.FieldByName('VALOR').AsFloat

    Else If Pos(cdsModAux.FieldByName('CODFPG').AsString, '007') > 0 Then
      fatVenda.fltValCar := fatVenda.fltValCar + cdsModAux.FieldByName('VALOR').AsFloat

    Else If (cdsModAux.FieldByName('CODFPG').AsString = '008') Then
      fatVenda.fltFatura := fatVenda.fltFatura + cdsModAux.FieldByName('VALOR').AsFloat

    Else If (cdsModAux.FieldByName('CODFPG').AsString = '010') Then
      fatVenda.fltValVle := fatVenda.fltValVle + cdsModAux.FieldByName('VALOR').AsFloat

    Else If (cdsModAux.FieldByName('CODFPG').AsString = '012') Then
    Begin
      fatVenda.fltValOrd := fatVenda.fltValOrd + cdsModAux.FieldByName('VALOR').AsFloat;

      If Not cdsModAux.FieldByName('PORTADOR_ORDPAG').AsString.IsEmpty Then
        fatVenda.FPortadorTFAutomatica := cdsModAux.FieldByName('PORTADOR_ORDPAG').AsString;

      If cdsModAux.FieldByName('PIX_AVULSO').AsString.Equals('S') Then
        fatVenda.FPixAvulso := 'S';
    End

    Else If (cdsModAux.FieldByName('CODFPG').AsString = '013') Then
      fatVenda.fltValCre := fatVenda.fltValCre - fltTotCreditos

    Else If (cdsModAux.FieldByName('CODFPG').AsString = '015') Then
      fatVenda.fltVlARec := fatVenda.fltVlARec + cdsModAux.FieldByName('VALOR').AsFloat

    Else If (cdsModAux.FieldByName('CODFPG').AsString = '016') Then
      fatVenda.fltValFin := fatVenda.fltValFin + cdsModAux.FieldByName('VALOR').AsFloat

    Else If (Pos(cdsModAux.FieldByName('CODFPG').AsString, '014_015') <= 0) Then
      fatVenda.fltValDin := fatVenda.fltValDin + cdsModAux.FieldByName('VALOR').AsFloat;

    cdsModAux.Next;
  End;

  If (optTroco    In [otNada, otCredito]) And
     (optTrocoPre In [otNada, otCredito]) And
     (optTrocoCar In [otNada, otCredito]) And
     (optTrocoDin In [otNada, otCredito]) And
     (Not blnTrocoComoCredito) Then
    fatVenda.fltValDin := fatVenda.fltValDin - fFormataFloat(edtValTro.Value, 2);

  If Assigned(cdsModAux) Then
    FreeAndNil(cdsModAux);
end;

procedure TfrmFatConfOrcamentos.pDestravaDuplicatasCredito;
  Var
    intContador: Integer;
Begin

  pDestravaDupCreditoProf;

  If (Not Assigned(stlLckDup)) Then
    Exit;

  For intContador := 0 To stlLckDup.Count - 1 Do
  Begin
    fLock_Unlock(stlLckDup[intContador], False, False);
  End;

  stlLckDup.Clear;
end;

procedure TfrmFatConfOrcamentos.pDigitacaoNumeroLiberacaoCartoes;
  Var
    blnConfCrt: Boolean;
    intContador: Integer;
    frmRcxDigCartoes : TfrmRcxDigCartoes;
begin
  {*****************************************}
  {* CASO TENHA DIGITADO CARTÃO, PEDE O NÚ-*}
  {* MERO DE LIBERAÇÃO.                    *}
  {**************************************MV*}
  blnConfCrt := True;
  If Length(arrCartoes) > 0 Then
  Begin
    Try
      pCriarFormularios(TfrmRcxDigCartoes, frmRcxDigCartoes);
    Except
      On E: Exception Do
      Begin
        blnConfCrt := False;
        pMensagensErro('Erro ao criar formulário. Será necessário digitar os números ' +
                       'de liberação manualmente.' + #13#10 + E.Message, '[TfrmFatConfOrcamentos.fFecharVenda]');
      End;
    End;

    Try
      If blnConfCrt Then
      Begin
        frmRcxDigCartoes.blnHabComp := False;
        frmRcxDigCartoes.Caption := 'Digitação do Número de Liberação';
        frmRcxDigCartoes.edtValCar.Enabled := False;
        frmRcxDigCartoes.edtTotCar.Enabled := False;
        frmRcxDigCartoes.edtCodCar.Enabled := False;
        frmRcxDigCartoes.edtDesCar.Enabled := False;
        frmRcxDigCartoes.edtQtdPar.Enabled := False;
        frmRcxDigCartoes.mskCndPag.Enabled := False;
        frmRcxDigCartoes.edtObsCar.Enabled := False;
        frmRcxDigCartoes.edtQtdPar.Enabled := False;
        frmRcxDigCartoes.edtNumNsu.Enabled := False;

        If fCfgSis('VALNSU', VarBoolean) Then
          frmRcxDigCartoes.edtNumNsuCon.Enabled := False;

        For intContador := Low(arrCartoes) To High(arrCartoes) Do
        Begin
          If fPrecisaInformarNumLiberacao(arrCartoes[intContador]) Then
          Begin

            frmRcxDigCartoes.edtNumCcd.Clear;
            frmRcxDigCartoes.edtValCar.Text := FloatToStrF(arrCartoes[intContador].fltValDig, ffNumber, 12, 2);
            frmRcxDigCartoes.edtTotCar.Text := FloatToStrF(arrCartoes[intContador].fltValDes, ffNumber, 12, 2);
            frmRcxDigCartoes.edtCodCar.Text := arrCartoes[intContador].strCodCar;
            frmRcxDigCartoes.edtDesCar.Text := arrCartoes[intContador].strDesCar;
            frmRcxDigCartoes.edtQtdPar.Text := LeftStr(arrCartoes[intContador].strCndPag, 2);
            frmRcxDigCartoes.mskCndPag.Text := arrCartoes[intContador].strCndPag;
            frmRcxDigCartoes.edtObsCar.Text := arrCartoes[intContador].strObsCar;
            frmRcxDigCartoes.edtNumNsu.Text := fPadL(arrCartoes[intContador].strNumNsu, 14, '0');

            If fCfgSis('VALNSU', VarBoolean) Then
              frmRcxDigCartoes.edtNumNsuCon.Text := fPadL(arrCartoes[intContador].strNumNsu, 14, '0');

            frmRcxDigCartoes.ShowModal;
            blnConfCrt := frmRcxDigCartoes.blnConfirma;
            arrCartoes[intContador].strNumCcd := frmRcxDigCartoes.edtNumCcd.Text;

            If Not blnConfCrt Then
              Break;

          End;

        End;

      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro('Houve um erro na digitação dos números de liberação. Será ' +
                       'necessário digitá-los manualmente.' + #13#10 + E.Message,
                       '[TfrmFatConfOrcamentos.fFecharVenda]');
      End;
    End;

    pFreeAndNil(frmRcxDigCartoes);

    If (Not blnConfCrt) Then
    Begin
      fMensagem('ATENÇÃO!', 'A digitação dos números de liberação foi cancelada' + #13#10 +
                            'Será necessário digitá-los manualmente.', ['&Ok']);
    End
    Else
    Begin
      Try
        pAtualizaNumCcd(fatVenda);
      Except
        On E: Exception Do
        Begin
          pMensagensErro('Houve um erro na atualização dos números de liberação.' + #13#10 +
                         'Será necessário digitá-los manualmente.' + #13#10 + E.Message, '[pAtualizaNumCcd ]');
        End;
      End;
    End;

  End;

end;

function TfrmFatConfOrcamentos.fImprimirCupom(dadosCupom: TDadosImpressaoVenda; Var strNumCoo, strNumSer, strNumCcf: String): Boolean;
begin
  If (VS_strUsaTef = 'S') Or VS_blnTelNov Then
    Result := fImprimirCupomNovo(dadosCupom, strNumCoo, strNumSer, strNumCcf)
  Else
    Result := fImprimirCupomVelho(dadosCupom, strNumCoo, strNumSer, strNumCcf);
end;

function TfrmFatConfOrcamentos.fImprimirCupomNovo(dadosCupom: TDadosImpressaoVenda; Var strNumCoo, strNumSer, strNumCcf: String): Boolean;
  Var
    strDesMod: String;
    
    impressorCupom: TImpressorCupomNovo;
    dicParametros: TDicionario;
begin

  If (VS_strUsaPaf = 'S') And (Not fCfgSis('PAFECF', varBoolean)) Then
  Begin
    If (Not fComparaNumeroSerieGrandeTotal) Then
    Begin
      Abort;
    End;
  End;

  cdsModAux := TUniClientDataSet.Create(Nil);
  Result := False;

  strNumCoo := '';
  strNumSer := '';
  strNumCcf := '';

  VS_objFiscal.strNumDoc := dadosCupom.strNumDoc;
  VS_objFiscal.strCodCli := edtCodCli.Text;
  VS_objFiscal.strNomCli := edtNomCli.Text;
  VS_objFiscal.strEndCli := edtEndEnt.Text;
  VS_objFiscal.strBaiCli := edtBaiEnt.Text;
  VS_objFiscal.strCepCli := mskCepEnt.Text;
  VS_objFiscal.strCidCli := edtNomCid.Text;
  VS_objFiscal.strEstCli := edtUF.Text;
  VS_objFiscal.strCgcCpf := mskCgcCpf.Text;
  VS_objFiscal.strCpfClie := mskCgcCpf.Text;
  VS_objFiscal.strRG_Cli := mskNumR_G.Text;
  VS_objFiscal.strIesCli := strCliIes;
  VS_objFiscal.strNomVen := dadosCupom.strCodVen + '-' + dadosCupom.strNomVen;
  VS_objFiscal.strTelCli := strFone01;
  VS_objFiscal.fltIcmDev := dadosCupom.fltTotIcm;
  VS_objFiscal.fltImpPag := dadosCupom.fltImpPag;
  VS_objFiscal.fltPeImPg := dadosCupom.fltPeImPg;
  VS_objFiscal.fltFedImp := dadosCupom.fltFedImp;
  VS_objFiscal.fltPeImFd := dadosCupom.fltPeImFd;
  VS_objFiscal.fltEstImp := dadosCupom.fltEstImp;
  VS_objFiscal.fltPeImEs := dadosCupom.fltPeImEs;
  VS_objFiscal.fltMunImp := dadosCupom.fltMunImp;
  VS_objFiscal.fltPeImMn := dadosCupom.fltPeImMn;

  If (fCfgSis('ABRGAV', varBoolean)) And
     (fStatusCndPag(dadosCupom.strConPag) = A_VISTA) Then
    VS_objFiscal.fAbreGaveta;

  impressorCupom := TImpressorCupomNovo.Create(VS_objFiscal, pImprimeModalidadesSintetizadas);
  dicParametros := TDicionario.Create;
  Try
    Try
      dicParametros['CONPAG'] := dadosCupom.strConPag;
      dicParametros['TOTGER'] := dadosCupom.fltTotGer;
      impressorCupom.pAdicionaParametro(dicParametros);

      If (fCfgConcomitante) And (qryFatGor.IsEmpty) And (Not cdsItensAdd.IsEmpty) Then
      Begin
        impressorCupom.bimBlocosImpressao := impressorCupom.bimBlocosImpressao - [biItens];
      End;

      If VS_objFiscal.EstadoECF = ecfCupomAberto Then
      Begin
//        impressorCupom.pSetDesconto(fatVenda.fltDesEsp,
//                                    fatVenda.fltTotGer);
        impressorCupom.pSetDesconto((fatVenda.fTotalProdutosOriginal - fGetTotGer(fatVenda.fltTotGer) ),
                                     fGetTotGer(fatVenda.fltTotGer));
      End;

      impressorCupom.pImprimirCupom(dadosCupom.strNumDoc, dadosCupom.strEspDoc,
        VS_strCodEmp, dadosCupom.strCodCli, fSerieIF);

      strNumCcf := VS_objFiscal.fNumeroCCF;
      strNumCoo := VS_objFiscal.fRetornaCOO;
      strNumSer := VS_objFiscal.fNumeroSerie;

      If fEmptyStr(strNumCoo) Then
        Abort
      Else
        If Not fAtualizarDadosCupomImpresso(dadosCupom, strNumCoo, strNumSer, strNumCcf) Then
          Abort;
    Except
      On E: Exception Do
      Begin
        Result := False;
        VS_objFiscal.fCancelaCupom;
        Abort;
      End;
    End;
  Finally
    FreeAndNil(dicParametros);
    FreeAndNil(impressorCupom);
  End;

  {************************************************************************************************}
  {* CASO SEJA CUPOM + CUPOM E O COMPROVANTE DE TEF JÁ TENHA SIDO IMPRESSO NÃO IMPRIME NOVAMTENTE *}
  {*********************************************************************************************VA*}
  If (blnConfirmouTEF) And ((fCfgSis('CUPNOT', varInteger) = 2) Or (fCfgSis('CUPENT', varInteger) = 2)) Then
  Begin
    Result := blnConfirmouTEF;
  End
  Else If (Not blnConfirmouTEF) Then
  Begin
    pRetornaIncDocTabela(fatVenda.strNumDoc,
                         fatVenda.strEspDoc,
                         fatVenda.strEmpDoc,
                         fatVenda.strCodCli,
                         strIncDoc,
                         strTabela);
    blnConfirmouTEF := fConfirmaCartoesTEF(USANDO_VINCULADO);
    Result := blnConfirmouTEF;
  End;

  If (chkEndEnt.Checked) And (chkEndEnt.Visible) And (Not fCfgSis('USNFCE', varBoolean)) And (Not fUsaSat) Then
    fImprimeEnderecoEntregaNova(strDesMod, dadosCupom, strNumCOO, cdsModAux);

  If fCfgSis('IMPGAR',varBoolean) Then
    fImprimeDadosGarantia(Nil, dadosCupom);    

  If fCfgSis('IMPCRG',varBoolean) Then
    fImprimeCreditosCliente(Nil, dadosCupom);

  If Assigned(cdsModAux) Then
    FreeAndNil(cdsModAux);
end;

function TfrmFatConfOrcamentos.fGetModalidadesImpressaoCupom(Var fltPagtoAnt: Double): TUniClientDataSet;
  Var
    qryModPagAnt: TUniQuery;
    intField: Integer;
begin
  Result := TUniClientDataSet.Create(Nil);
  Result.Data := cdsModalidades.Data;
  Result.IndexFieldNames := 'ORDEM;ECF_CODMOD';

  If Not qryFatGor.Active Or qryFatGor.IsEmpty Then
  Begin
    fltPagtoAnt := 0;
    Exit;
  End;

  fltPagtoAnt := fltValAnt + fltValAdt;

  If fltPagtoAnt > 0 Then
  Begin
    qryModPagAnt := fCriaQuery;

    With qryModPagAnt, SQL Do
    Begin
      Close;
      Clear;

      Add('SELECT ');
      Add('  F.FPG_CODIGO, ');
      Add('  F.FPG_DESCRI, ');
      Add('  E.ECF_DESMOD, ');
      Add('  E.ECF_DESMOD AS DESMOD, ');
      Add('  M.MOD_VALMOD AS VALOR,  ');
      Add('  IF(F.FPG_CODIGO = "013", 0, 1) AS ORDEM,   ');
      Add('  IFNULL(FE.ECF_CODMOD, "01") AS ECF_CODMOD, ');
      Add('  IFNULL(E.ECF_IDENTI, "1") AS ECF_IDENTI,   ');
      Add('  IFNULL(E.ECF_INFADI, "N") AS ECF_INFADI    ');
      Add('FROM ');
      Add('  MOVMOD M ');
      Add('JOIN CADFPG F ON F.FPG_CODIGO = MOD_CODMOD ');
      Add('JOIN FPGECF FE ON FE.FPG_CODIGO = F.FPG_CODIGO ');
      Add('JOIN ECFMOD E ON E.ECF_CODECF = FE.ECF_CODECF AND ');
      Add('                 E.ECF_CODEMP = FE.ECF_CODEMP AND ');
      Add('                 E.ECF_CODMOD = FE.ECF_CODMOD AND ');
      Add('                 E.ECF_CODECF = :CODECF ');
      Add('WHERE ');
      Add('  M.MOD_NUMDOC = :NUMDOC AND ');
      Add('  M.MOD_ESPDOC = :ESPDOC AND ');
      Add('  M.MOD_CODEMP = :CODEMP AND ');
      Add('  F.FPG_MOSMOD = "S"     AND ');
      Add('  F.FPG_STATUS = "A"     AND ');
      {*************************************************}
      {* DEVE CARREGAR SOOMENTE AS MODALIDADES A VISTA *}
      {**********************************************JC*}
      Add('  F.FPG_CODIGO <> "009"  AND ');//Parcelado
      Add('  F.FPG_CODIGO <> "008"  AND ');//Faturado
      Add('  F.FPG_CODIGO <> "010"      ');//Vale

      ParamByName('CODECF').AsString := strCodEcf;
      ParamByName('NUMDOC').AsString := fFatGor('NUMDOC').AsString;
      ParamByName('ESPDOC').AsString := fFatGor('ESPDOC').AsString;
      ParamByName('CODEMP').AsString := fFatGor('CODEMP').AsString;

      Open;

      While Not Eof Do
      Begin
        Result.Append;

        For intField := 0 To Fields.Count -1 Do
          If Result.FindField(Fields[intField].FieldName) <> nil Then
            Result.FindField(Fields[intField].FieldName).Value := Fields[intField].Value;

        Result.Post;
        Next;
      End;

    End;

    FreeAndNil(qryModPagAnt);
  End;

end;

procedure TfrmFatConfOrcamentos.pImprimeModalidadesSintetizadas(objFiscal: TFiscalBrd; arrParametros: Array of TObject);
  Var
    cdsModalidadesCupom: TUniClientDataSet;
    fltValorPagoAnteriormente: Double;

    strModAtu: String;
    strDesMod: String;
    fltValMod: Double;
    strInfAdi: String;

    fltFatDiv: Double;
    fltPreMod: Double;
    fltDifMod: Double;
begin
  {***************************************}
  {* CRIA OS AGGREGATES                  *}
  {************************************AF*}
  fltFatDiv := 0.00;

  cdsModAux.AggregatesActive := True;
  With TAggregateField.Create(cdsModAux) Do
  Begin
    FieldName     := 'TOT_VALOR';
    DataSet       := cdsModAux;
    Expression    := 'SUM(VALOR)';
    Active        := True;
  End;

  cdsModalidadesCupom := fGetModalidadesImpressaoCupom(fltValorPagoAnteriormente);

  {*****************************************}
  {* FAZ UMA COPIA DA ESTRUTURA            *}
  {**************************************AF*}
  cdsModAux.Data := cdsModalidadesCupom.Data;
  cdsModAux.EmptyDataSet;

  cdsModalidadesCupom.First;
  While Not cdsModalidadesCupom.Eof Do
  Begin
    strModAtu := cdsModalidadesCupom.FieldByName('ECF_CODMOD').AsString;
    strDesMod := Trim(cdsModalidadesCupom.FieldByName('ECF_DESMOD').AsString);
    fltValMod := 0.0;
    strInfAdi := cdsModAux.FieldByName('ECF_INFADI').AsString;

    While (Not cdsModalidadesCupom.Eof) And (strModAtu = cdsModalidadesCupom.FieldByName('ECF_CODMOD').AsString) Do
    Begin
      fltValMod := fltValMod + cdsModalidadesCupom.FieldByName('VALOR').AsFloat;
      cdsModalidadesCupom.Next;
    End;

    {*****************************************}
    {* AJUSTE DAS MODALIDADES                *}
    {**************************************AF*}
    fltFatDiv := TDicionario(arrParametros[0])['TOTGER'] / (fStrToFloat(edtTotGer.Text) + fltValorPagoAnteriormente);
    fltPreMod := fFormataFloat(fltValMod * fltFatDiv, 2);

    cdsModAux.Append;
    cdsModAux.FieldByName('ECF_CODMOD').AsString := strModAtu;
    cdsModAux.FieldByName('ECF_DESMOD').AsString := strDesMod;
    cdsModAux.FieldByName('ECF_INFADI').AsString := strInfAdi;
    cdsModAux.FieldByName('VALOR').AsFloat       := fltPreMod;
    cdsModAux.Post;
  End;

  FreeAndNil(cdsModalidadesCupom);

  {*****************************************}
  {* TERMINO DE AJUSTE DAS MODALIDADES     *}
  {**************************************AF*}
  cdsModAux.First;
  fltPreMod := cdsModAux.AggFields.FieldByName('TOT_VALOR').Value;

  If (optTroco    In [otNada, otCredito]) And
     (optTrocoPre In [otNada, otCredito]) And
     (optTrocoCar In [otNada, otCredito]) And
     (optTrocoDin In [otNada, otCredito]) And
     (Not blnTrocoComoCredito) Then
    fltPreMod := fltPreMod - fFormataFloat(edtValTro.Value * fltFatDiv, 2);

  fltDifMod := TDicionario(arrParametros[0])['TOTGER'] - fltPreMod;

  If fltDifMod <> 0 Then
  Begin
    cdsModAux.Edit;
    cdsModAux.FieldByName('VALOR').AsFloat := cdsModAux.FieldByName('VALOR').AsFloat + fltDifMod;
    cdsModAux.Post;
  End;

  {*****************************************}
  {* IMPRIME AS MODALIDADES NA IMPRESSORA  *}
  {**************************************AF*}
  While Not cdsModAux.Eof Do
  Begin

    strModAtu := cdsModAux.FieldByName('ECF_CODMOD').AsString;
    strDesMod := Trim(cdsModAux.FieldByName('ECF_DESMOD').AsString);
    fltValMod := 0.0;

    strInfAdi := '';
    If cdsModAux.FieldByName('ECF_INFADI').AsString = 'S' Then
      strInfAdi := fRetVencimentos(TDicionario(arrParametros[0])['CONPAG'], VS_Date);

    While (Not cdsModAux.Eof) And (strModAtu = cdsModAux.FieldByName('ECF_CODMOD').AsString) Do
    Begin
      fltValMod := fltValMod + Abs(cdsModAux.FieldByName('VALOR').AsFloat);
      cdsModAux.Next;
    End;

    If (Not VS_objFiscal.fRegistraModalidades(strModAtu,
                                              strDesMod,
                                              fltValMod,
                                              strInfAdi)) Then
    Begin
      VS_objFiscal.fCancelaCupom;
      Abort;
    End;

  End;
end;

function TfrmFatConfOrcamentos.fRetNumCCds: String;
  Var
    intContador: Integer;
Begin
  Result := '';
  For intContador := Low(arrCartoes) To High(arrCartoes) Do
    Result := Result + ' ' + arrCartoes[intContador].strNumCcd;
  Result := Trim(Result);
End;

function TfrmFatConfOrcamentos.fImprimirCupomVelho(dadosCupom: TDadosImpressaoVenda;
  Var strNumCoo, strNumSer, strNumCcf: String): Boolean;
  Var
    strCodErr: String;

    strDesMod: String;

    strCGCCPF: String;
    strIESCli: String;
    strRG_Cli: String;
    strObserv: String;
    strEndImp: String;

    blnImpPag: Boolean;
    strImpPag: String;

    {*****************************************}
    {* >>>>>>>>>>>>  ATENÇÃO <<<<<<<<<<<<<<< *}
    {* VARIÁVEIS ESPECIFICAS PARA DARUMA.    *}
    {**************************************MV*}
    impressorCupom: TImpressorCupomVelho;
    dicParametros: TDicionario;

    Function fRetDesMod : String;
    Begin
      Result := '';
      cdsModalidades.First;
      While Not cdsModalidades.Eof Do
      Begin
        If Not (SameText('DINHEIRO', cdsModalidades.FieldByName('ECF_DESMOD').AsString)) Then
        Begin
          Result := Trim(cdsModalidades.FieldByName('ECF_DESMOD').AsString);
          Break;
        End;        
        cdsModalidades.Next;
      End;
    End;

begin

  cdsModAux := TUniClientDataSet.Create(Nil);
  Result := True;

  strEndImp := dadosCupom.strCliEnd + IIF(fEmptyStr(dadosCupom.strCliNum), '', ', ' + dadosCupom.strCliNum) +
                                      IIF(fEmptyStr(dadosCupom.strCliCom), '', ' ' + dadosCupom.strCliCom);

  ecfFiscal.fltICMDev := dadosCupom.fltTotIcm;
  ecfFiscal.fltImpPag := dadosCupom.fltImpPag;
  ecfFiscal.fltPeImPg := dadosCupom.fltPeImPg;
  ecfFiscal.fltFedImp := dadosCupom.fltFedImp;
  ecfFiscal.fltPeImFd := dadosCupom.fltPeImFd;
  ecfFiscal.fltEstImp := dadosCupom.fltEstImp;
  ecfFiscal.fltPeImEs := dadosCupom.fltPeImEs;
  ecfFiscal.fltMunImp := dadosCupom.fltMunImp;
  ecfFiscal.fltPeImMn := dadosCupom.fltPeImMn;

  ecfFiscal.strCodVen := dadosCupom.strCodVen;
  ecfFiscal.strNomVen := dadosCupom.strCodVen + '-' + dadosCupom.strNomVen;
  ecfFiscal.strNumDoc := dadosCupom.strNumDoc;
  ecfFiscal.strCodCli := edtCodCli.Text;
  ecfFiscal.strNomCli := edtNomCli.Text;
  ecfFiscal.strEndCli := edtEndEnt.Text;
  ecfFiscal.strBaiCli := edtBaiEnt.Text;
  ecfFiscal.strCepCli := mskCepEnt.Text;
  ecfFiscal.strCidCli := edtNomCid.Text;
  ecfFiscal.strEstCli := edtUF.Text;
  ecfFiscal.strCgcCpf := mskCgcCpf.Text;
  ecfFiscal.strIesCli := strCliIes;
  ecfFiscal.strRG_Cli := mskNumR_G.Text;

  blnImpPag := ((ecfFiscal.fltImpPag <> 0.00) And (ecfFiscal.fltPeImPg <> 0.00)) Or
               ((ecfFiscal.fltFedImp <> 0.00) And (ecfFiscal.fltPeImFd <> 0.00)) Or
               ((ecfFiscal.fltEstImp <> 0.00) And (ecfFiscal.fltPeImEs <> 0.00)) Or
               ((ecfFiscal.fltMunImp <> 0.00) And (ecfFiscal.fltPeImMn <> 0.00));

  If (fCfgSis('ABRGAV', varBoolean)) And
     (fStatusCndPag(dadosCupom.strConPag) = A_VISTA) Then
    ecfFiscal.fAbreGaveta(strCodErr);

  //*************************************************//
  // FORMATA AS VARIAVEIS STRCGCCPF E IESCLI         //
  //**********************************************ED*//
  strCGCCPF := fFormataCpfCgc(dadosCupom.strCliCgc, FPais);
  strIESCli := dadosCupom.strCliIes;
  strRG_Cli := mskNumR_G.Text;
  If Pos('/', strCGCCPF) > 0 Then
  Begin
    strCGCCPF := 'CNPJ: ' + strCGCCPF;
    strIESCli := 'IES.: ' + strIESCli;
  End
  Else
  Begin
    strCGCCPF := 'CPF: ' + strCGCCPF;
    strIESCli := 'RG.: ' + strRG_Cli;
  End;

  {*****************************************}
  {* MENSAGENS DA IMPRESSORA               *}
  {**************************************MA*}
  If Pos( ecfFiscal.fGetModEcf, 'SWEDA-9000' ) > 0 Then
  Begin
    strObserv := '';
    strObserv := strObserv + '2' + fPadR( IIF(fCfgSis('IMPCAC', varBoolean),'Cupom Fiscal: ' + dadosCupom.strNumDoc + '-IF',''), 40 );

    If blnImpPag Then
    Begin
      If Not fUsaImpostoFonteIBPT Then
      Begin
        If ecfFiscal.fltImpPag < 1000 Then
          strObserv := strObserv + '0' + fPadR(strMsgArreTribu40 + FormatFloat('#,##0.00', ecfFiscal.fltImpPag) +
                                               '(' + FormatFloat('#,##0.00', ecfFiscal.fltPeImPg) + '%)', 40)
        Else
          strObserv := strObserv + '0' + fPadR(strMsgArreTribuRedz40 + FormatFloat('#,##0.00', ecfFiscal.fltImpPag) +
                                               '(' + FormatFloat('#,##0.00', ecfFiscal.fltPeImPg) + '%)', 40);
      End
      Else
      Begin
        strImpPag := '';
        strImpPag := strImpPag + VAL_APR_IBPT;

        If (ecfFiscal.fltFedImp <> 0.00) Then
          strImpPag := strImpPag + FormatFloat('#,##0.00', ecfFiscal.fltFedImp) + FEDERAL;

        If (ecfFiscal.fltEstImp <> 0.00) Then
          strImpPag := strImpPag + '/' + FormatFloat('#,##0.00', ecfFiscal.fltEstImp) + ESTADUAL;

        If (ecfFiscal.fltMunImp <> 0.00) Then
          strImpPag := strImpPag + '/' + FormatFloat('#,##0.00', ecfFiscal.fltMunImp) + MUNICIPAL;

        strImpPag := strImpPag + FONTE_IBPT;
        strObserv := strObserv + '0' + Copy(fPadR(strImpPag, 40), 1, 40);
      End;                                             
    End;

    strObserv := strObserv + '0' + fPadR( LeftStr( dadosCupom.strCliNom, 31 ) + '-' + dadosCupom.strCodCli, 40 );
    strObserv := strObserv + '0' + fPadR( strEndImp + ' - ' + dadosCupom.strCliBai, 40 );

    If Not blnImpPag Then
      strObserv := strObserv + '0' + fPadR( dadosCupom.strCliCep + ' - ' + dadosCupom.strCliCid + '-' + dadosCupom.strCliEst, 40 );

    strObserv := strObserv + '0' + fPadR(  strCGCCPF + ' - ' + strIESCli, 40 );
    strObserv := strObserv + '0' + fPadR( 'Vendedor: ' + dadosCupom.strNomVen, 40 );

    If (fCadEmp('ESTADO') = 'MG') And
       (fCfgSis('MINLEG', varBoolean)) Then
      strObserv := strObserv + '0' + fPadR( 'MINAS LEGAL', 40)
    Else
    If fCfgSis('CUPMAN', varBoolean) Then
    Begin
      strObserv := strObserv + '0' + fPadR( 'VALIDO PARA O CUPOM MANIA', 40);
      strObserv := strObserv + '0' + fPadR( 'ICMS DEVIDO: ' + FormatFloat('#0.00', dadosCupom.fltTotIcm), 40);
    End;

  End
  Else If Pos( ecfFiscal.fGetModEcf, 'SWEDA-7000' ) > 0 Then
  Begin
    strObserv := '';

    If blnImpPag Then
    Begin
      If Not fUsaImpostoFonteIBPT Then
      Begin
        If ecfFiscal.fltImpPag < 1000 Then
          strObserv := strObserv + '0' + fPadR(strMsgArreTribu40 + FormatFloat('#,##0.00', ecfFiscal.fltImpPag) +
                                               '(' + FormatFloat('#,##0.00', ecfFiscal.fltPeImPg) + '%)', 40)
        Else
          strObserv := strObserv + '0' + fPadR(strMsgArreTribuRedz40 + FormatFloat('#,##0.00', ecfFiscal.fltImpPag) +
                                               '(' + FormatFloat('#,##0.00', ecfFiscal.fltPeImPg) + '%)', 40);
      End
      Else
      Begin
        strImpPag := '';
        strImpPag := strImpPag + VAL_APR_IBPT;

        If (ecfFiscal.fltFedImp <> 0.00) Then
          strImpPag := strImpPag + FormatFloat('#,##0.00', ecfFiscal.fltFedImp) + FEDERAL;

        If (ecfFiscal.fltEstImp <> 0.00) Then
          strImpPag := strImpPag + '/' + FormatFloat('#,##0.00', ecfFiscal.fltEstImp) + ESTADUAL;

        If (ecfFiscal.fltMunImp <> 0.00) Then
          strImpPag := strImpPag + '/' + FormatFloat('#,##0.00', ecfFiscal.fltMunImp) + MUNICIPAL;

        strImpPag := strImpPag + FONTE_IBPT;
        strObserv := strObserv + '0' + Copy(fPadR(strImpPag, 40), 1, 40);
      End;
    End;

    strObserv := strObserv + '0' + fPadR( IIF(fCfgSis('IMPCAC', varBoolean),'Cupom Fiscal: ' + dadosCupom.strNumDoc + '-IF',''), 40 );
    strObserv := strObserv + '0' + fPadR( LeftStr( dadosCupom.strCliNom, 31 ) + '-' + dadosCupom.strCodCli, 40 );
    strObserv := strObserv + '0' + fPadR( strEndImp + ' - ' + dadosCupom.strCliBai, 40 );

    If Not blnImpPag Then
      strObserv := strObserv + '0' + fPadR( dadosCupom.strCliCep + ' - ' + dadosCupom.strCliCid + '-' + dadosCupom.strCliEst, 40 );

    strObserv := strObserv + '0' + fPadR( strCGCCPF + ' - ' + strIESCli, 40 );
    strObserv := strObserv + '0' + fPadR( 'Vendedor: ' + dadosCupom.strNomVen, 40 );

    If fCfgSis('SIMNAC') = 'S' Then
      strObserv := strObserv + '0' + fPadR( 'ICMS A SER REC. CONF. LC 123/2006 - SIMPLES NAC', 40 );

    If (fCadEmp('ESTADO') = 'MG') And
       (fCfgSis('MINLEG', varBoolean)) Then
      strObserv := strObserv + '0' + fPadR( 'MINAS LEGAL', 40)
    Else
    If fCfgSis('CUPMAN', varBoolean) Then
      strObserv := strObserv + '0' + fPadR( 'VALIDO P/CUPOM MANIA.ICMS DEV: ' + FormatFloat('#0.00', dadosCupom.fltTotIcm), 40);

  End
  Else
  Begin

    strObserv := '';

    If blnImpPag Then
    Begin
      If Not fUsaImpostoFonteIBPT Then
      Begin
        If ecfFiscal.fltImpPag < 1000 Then
          strObserv := strObserv + fPadR(strMsgArreTribu48  + FormatFloat('#,##0.00', ecfFiscal.fltImpPag) +
                                         '(' + FormatFloat('#,##0.00', ecfFiscal.fltPeImPg) + '%)', 48)
        Else
          strObserv := strObserv + fPadR(strMsgArreTribuRedz48 + FormatFloat('#,##0.00', ecfFiscal.fltImpPag) +
                                         '(' + FormatFloat('#,##0.00', ecfFiscal.fltPeImPg) + '%)', 48);
      End
      Else
      Begin
        strImpPag := '';
        strImpPag := strImpPag + VAL_APR_IBPT;

        If (ecfFiscal.fltFedImp <> 0.00) Then
          strImpPag := strImpPag + FormatFloat('#,##0.00', ecfFiscal.fltFedImp) + FEDERAL;

        If (ecfFiscal.fltEstImp <> 0.00) Then
          strImpPag := strImpPag + '/' + FormatFloat('#,##0.00', ecfFiscal.fltEstImp) + ESTADUAL;

        If (ecfFiscal.fltMunImp <> 0.00) Then
          strImpPag := strImpPag + '/' + FormatFloat('#,##0.00', ecfFiscal.fltMunImp) + MUNICIPAl;

        strImpPag := strImpPag + FONTE_IBPT;
        strObserv := strObserv + Copy(fPadR(strImpPag, 48), 1, 48);
      End;
    End;

    strObserv := strObserv + fPadR( fRetDocMaisTelParaIF(dadosCupom.strNumDoc, strFone01, 48), 48 );
    strObserv := strObserv + fPadR( LeftStr( dadosCupom.strCliNom, 31 ) + '-' + dadosCupom.strCodCli, 48 );
    strObserv := strObserv + fPadR( strEndImp + ' - ' + dadosCupom.strCliBai, 48 );

    If Not blnImpPag Then
      strObserv := strObserv + fPadR( dadosCupom.strCliCep + ' - ' + dadosCupom.strCliCid + '-' + dadosCupom.strCliEst, 48 );

    strObserv := strObserv + fPadR( strCGCCPF + ' - ' + strIESCli, 48 );

    If fEmptyStr(fRetNumCCds) Then
      strObserv := strObserv + fPadR( 'Vendedor:' + dadosCupom.strNomVen, 48 )
    Else
      strObserv := strObserv + fPadR( 'Vendedor:' + LeftStr(dadosCupom.strNomVen,10) + ' Lib.Car:' + fRetNumCCds, 48 );

//123456789012345678901234567890123456789012345678
//Vendedor:1234567890 Lib.Car:12345678901234567890

    If fCfgSis('SIMNAC') = 'S' Then
      strObserv := strObserv + fPadR( 'ICMS A SER REC. CONF. LC 123/2006 - SIMPLES NAC', 48 );

    If (fCadEmp('ESTADO') = 'MG') And
       (fCfgSis('MINLEG', varBoolean)) Then
      strObserv := strObserv + '0' + fPadR( 'MINAS LEGAL', 40)
    Else        
    If fCfgSis('CUPMAN', varBoolean) Then
      strObserv := strObserv + fPadR( 'VALIDO PARA O CUPOM MANIA.ICMS DEVIDO: ' + FormatFloat('#0.00', dadosCupom.fltTotIcm), 48);

  End;

  dicParametros := TDicionario.Create;
  impressorCupom := TImpressorCupomVelho.Create(ecfFiscal,
    pImprimeModalidadesSintetizadasVelho, dadosCupom.fltTotGer, strObserv);
  impressorCupom.pAdicionaParametro(dicParametros);
  Try
    dicParametros['CONPAG'] := dadosCupom.strConPag;
    dicParametros['TOTGER'] := dadosCupom.fltTotGer;
    impressorCupom.pImprimirCupom(dadosCupom.strNumDoc, dadosCupom.strEspDoc,
      VS_strCodEmp, dadosCupom.strCodCli, fSerieIF);
  Finally
    FreeAndNil(dicParametros);
    FreeAndNil(impressorCupom);
  End;

  strNumCoo := fstrEspaco(' ', 6);
  If (Not ecfFiscal.fRetornaCoo(strNumCoo, strCodErr)) Then
  Begin
    pCancelaCupomNoEcf(ecfFiscal);
    fMensagem('ATENÇÃO!', 'Retorna COO: ' + #13#10 + ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
    Result := False;
    Exit;
  End;

  strNumSer := fstrEspaco(' ', 20);
  If (Not ecfFiscal.fNumeroSerie(strNumSer, strCodErr)) Then
  Begin
    pCancelaCupomNoEcf(ecfFiscal);
    fMensagem('ATENÇÃO!', 'Retorna Número de Série: ' + #13#10 + ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
    Result := False;
    Exit;
  End;

  If (Not fAtualizarDadosCupomImpresso(dadosCupom, strNumCoo, strNumSer, strNumCcf)) Then
  Begin
    pCancelaCupomNoEcf(ecfFiscal);
    fMensagem('ATENÇÃO!', 'Erro ao Atualizar dados do Cupom Impresso!', ['&Ok']);
    Result := False;
    Exit;
  End;

//  ecfFiscal.fFinalizaEcf(strCodErr);

  strDesMod := fRetDesMod;

  If (chkEndEnt.Checked) And (chkEndEnt.Visible) And (Not fCfgSis('USNFCE', varBoolean)) And (Not fUsaSat) Then
    fImprimeEnderecoEntrega(strDesMod, dadosCupom, strNumCOO, cdsModAux);

  If fCfgSis('IMPGAR',varBoolean) Then
    fImprimeDadosGarantia(ecfFiscal, dadosCupom);

  If fCfgSis('IMPCRG',varBoolean) Then
    fImprimeCreditosCliente(ecfFiscal, dadosCupom);

  If Assigned(cdsModAux) Then
    FreeAndNil(cdsModAux);
end;

procedure TfrmFatConfOrcamentos.pImprimeModalidadesSintetizadasVelho(objFiscal: TUntFiscal; arrParametros: Array of TObject);
  Var
    cdsModalidadesCupom: TUniClientDataSet;
    fltValorPagoAnteriormente: Double;

    strModAtu: String;
    strDesMod: String;
    fltValMod: Double;

    fltFatDiv: Double;
    fltPreMod: Double;
    fltDifMod: Double;
    strInfAdi: String;
    strCodErr: String;
begin
  {***************************************}
  {* CRIA OS AGGREGATES                  *}
  {************************************AF*}
  fltFatDiv := 0.00;

  cdsModAux.AggregatesActive := True;
  With TAggregateField.Create(cdsModAux) Do
  Begin
    FieldName     := 'TOT_VALOR';
    DataSet       := cdsModAux;
    Expression    := 'SUM(VALOR)';
    Active        := True;
  End;

  cdsModalidadesCupom := fGetModalidadesImpressaoCupom(fltValorPagoAnteriormente);

  {*****************************************}
  {* FAZ UMA COPIA DA ESTRUTURA            *}
  {**************************************AF*}
  cdsModAux.Data := cdsModalidadesCupom.Data;
  cdsModAux.EmptyDataSet;

  cdsModalidadesCupom.First;
  While Not cdsModalidadesCupom.Eof Do
  Begin

    strModAtu := cdsModalidadesCupom.FieldByName('ECF_CODMOD').AsString;
    strDesMod := Trim(cdsModalidadesCupom.FieldByName('ECF_DESMOD').AsString);
    fltValMod := 0.0;

    While (Not cdsModalidadesCupom.Eof) And (strModAtu = cdsModalidadesCupom.FieldByName('ECF_CODMOD').AsString) Do
    Begin
      fltValMod := fltValMod + cdsModalidadesCupom.FieldByName('VALOR').AsFloat;
      cdsModalidadesCupom.Next;
    End;

    {*****************************************}
    {* AJUSTE DAS MODALIDADES                *}
    {**************************************AF*}
    fltFatDiv := TDicionario(arrParametros[0])['TOTGER'] / (fStrToFloat(edtTotGer.Text) + fltValorPagoAnteriormente);
    fltPreMod := fFormataFloat(fltValMod * fltFatDiv, 2);

    cdsModAux.Append;
    cdsModAux.FieldByName('ECF_CODMOD').AsString := strModAtu;
    cdsModAux.FieldByName('ECF_DESMOD').AsString := strDesMod;
    cdsModAux.FieldByName('ECF_INFADI').AsString := cdsModalidadesCupom.FieldByName('ECF_INFADI').AsString;
    cdsModAux.FieldByName('VALOR').AsFloat       := fltPreMod;
    cdsModAux.Post;
  End;

  FreeAndNil(cdsModalidadesCupom);

  {*****************************************}
  {* TERMINO DE AJUSTE DAS MODALIDADES     *}
  {**************************************AF*}
  cdsModAux.First;
  fltPreMod := cdsModAux.AggFields.FieldByName('TOT_VALOR').Value;

  If (optTroco    In [otNada, otCredito]) And
     (optTrocoPre In [otNada, otCredito]) And
     (optTrocoCar In [otNada, otCredito]) And
     (optTrocoDin In [otNada, otCredito]) And
     (Not blnTrocoComoCredito) Then
    fltPreMod := fltPreMod - fFormataFloat(edtValTro.Value * fltFatDiv, 2);

  fltDifMod := TDicionario(arrParametros[0])['TOTGER'] - fltPreMod;

  If fltDifMod <> 0 Then
  Begin
    cdsModAux.Edit;
    cdsModAux.FieldByName('VALOR').AsFloat := cdsModAux.FieldByName('VALOR').AsFloat + fltDifMod;
    cdsModAux.Post;
  End;

  {*****************************************}
  {* IMPRIME AS MODALIDADES NA IMPRESSORA  *}
  {**************************************AF*}
  While Not cdsModAux.Eof Do
  Begin

    strModAtu := cdsModAux.FieldByName('ECF_CODMOD').AsString;
    strDesMod := Trim(cdsModAux.FieldByName('ECF_DESMOD').AsString);
    fltValMod := 0.0;

    strInfAdi := '';
    If cdsModAux.FieldByName('ECF_INFADI').AsString = 'S' Then
      strInfAdi := fRetVencimentos(TDicionario(arrParametros[0])['CONPAG'], VS_Date);

    While (Not cdsModAux.Eof) And (strModAtu = cdsModAux.FieldByName('ECF_CODMOD').AsString) Do
    Begin
      fltValMod := fltValMod + cdsModAux.FieldByName('VALOR').AsFloat;
      cdsModAux.Next;
    End;

    If Not ecfFiscal.fPagamento(strCodErr,
                                strModAtu,
                                strDesMod,
                                fltValMod,
                                False,
                                strInfAdi) Then
    Begin
      ecfFiscal.fCancelaCupom( strCodErr );
      fMensagem('ATENÇÃO!', 'Formas de Pagamento: ' + #13#10 + ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
      Abort;
    End;

  End;
end;

function TfrmFatConfOrcamentos.fImprimeDadosGarantia(
  ecfFiscal: TUntFiscal; dadosCupom: TDadosImpressaoVenda): Boolean;
  Var
    objImpGar: TImpDadosGarantia;
begin
  objImpGar := TImpDadosGarantia.Create(Self, ecfFiscal);
  Result    := objImpGar.fImprimirGarantia(dadosCupom.strNumDoc, 'IF', VS_strCodEmp, dadosCupom.strCodCli);

  FreeAndNil(objImpGar);
end;

function TfrmFatConfOrcamentos.fImprimeCreditosCliente(ecfFiscal: TUntFiscal; dadosCupom: TDadosImpressaoVenda): Boolean;
  Var
    objImpCre: TImpCreditosCliente;
begin
  objImpCre := TImpCreditosCliente.Create(Self, ecfFiscal);
  Result    := objImpCre.fImprimirCreditos(dadosCupom.strCodCli, fltCredUtilizados);
  FreeAndNil(objImpCre);
end;

Function TfrmFatConfOrcamentos.fImprimeEnderecoEntrega(strDesMod: String;
  dadosCupom: TDadosImpressaoVenda; strNumCOO: String; cdsModali: TUniClientDataSet): Boolean;
  Var
    strCodErr: String;
    intContador: Integer;

    strLinItem: String;
    strCGCCPF: String;
    strIESCli: String;
    strRG_Cli: String;

    strModali: string;
    strDescMo: String;
    fltModVal: Double;

    stlMen001: TStringList;
    stlMen002: TStringList;

  Procedure pMensagemVinculado(strMensagem: String);
    Var
      stlMensagem: TStringList;
      intContador: Integer;
      strCodErr: String;
  Begin
    stlMensagem := TStringList.Create;
    stlMensagem.Text := strMensagem;

    If Not fEmptyStr(strMensagem) Then
    Begin
      ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( '', 48));
      For intContador := 0 To stlMensagem.Count - 1 Do
        ecfFiscal.fUsaCupomVinculado(strCodErr,fPadR( stlMensagem[intContador], 48 ));
    End;

    FreeAndNil(stlMensagem);
  End;
Begin
  Result := FALSE;

  If Not ecfFiscal.fAbreCupomVinculado(strCodErr, strDesMod, 0, '') Then
    Exit;

  stlMen001 := TStringList.Create;
  stlMen002 := TStringList.Create;

  If Not fEmptyStr(dadosCupom.strMen001) Then stlMen001.Text := WrapText(dadosCupom.strMen001, 45);
  If Not fEmptyStr(dadosCupom.strMen002) Then stlMen002.Text := WrapText(dadosCupom.strMen002, 45);

  If Pos('-', dadosCupom.recEndEnt.strCepEnt) = 0 Then  dadosCupom.recEndEnt.strCepEnt := FormatMaskText('99999-999;0;_', dadosCupom.recEndEnt.strCepEnt);

  strCGCCPF := fFormataCpfCgc(dadosCupom.strCliCgc, FPais);
  strIESCli := dadosCupom.strCliIes;
  strRG_Cli := dadosCupom.strCli_Rg;

  If Pos('/', strCGCCPF) > 0 Then
  Begin
    strCGCCPF := 'CNPJ: ' + strCGCCPF;
    strIESCli := 'IES.: ' + strIESCli;
  End
  Else
  Begin
    strCGCCPF := 'CPF: ' + strCGCCPF;
    strIESCli := 'RG.: ' + strRG_Cli;
  End;

  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR('', 48, '-'));

  If fCfgSis('IMPCAC', varBoolean) Then
    ecfFiscal.fUsaCupomVinculado(strCodErr,fPadC('Cupom Fiscal: ' + dadosCupom.strNumDoc + '-IF' ,48))
  Else
    ecfFiscal.fUsaCupomVinculado(strCodErr,fPadC('COO Cupom Fiscal: ' + strNumCOO, 48));
  
  ecfFiscal.fUsaCupomVinculado(strCodErr,fPadC('DADOS DO CLIENTE',48));
  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( LeftStr( dadosCupom.strCliNom, 31 ) + '-' + dadosCupom.strCodCli, 48 ));
  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR(  dadosCupom.strCliEnd + ' - ' + dadosCupom.strCliBai, 48 ));
  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR('CEP: ' +  dadosCupom.strCliCep + ' - ' + dadosCupom.strCliCid + '-' + dadosCupom.strCliEst, 48 ));
  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( strCGCCPF + ' - ' + strIESCli, 48 ));

  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR('', 48, '-'));
  ecfFiscal.fUsaCupomVinculado(strCodErr,fPadC('ENDERECO DE ENTREGA',48));

  If fEmptyStr(dadosCupom.recEndEnt.strEndEnt) Then
  Begin
    ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( dadosCupom.strCliEnd + ' - ' + dadosCupom.strCliBai, 48 ));
    ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR('CEP: ' + dadosCupom.strCliCep + ' - ' + dadosCupom.strCliCid + '-' + dadosCupom.strCliEst, 48 ));
  End Else
  Begin
    ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( dadosCupom.recEndEnt.strEndEnt + ' - ' + dadosCupom.recEndEnt.strBaiEnt, 48 ));
    ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR('CEP: ' + dadosCupom.recEndEnt.strCepEnt + ' - ' + dadosCupom.recEndEnt.strNomCid + '-' + dadosCupom.recEndEnt.strEstEnt, 48 ));
  End;

  If fCfgSis('IMPDCE', varBoolean) Then
  Begin
    ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR('', 48, '-'));
    ecfFiscal.fUsaCupomVinculado(strCodErr, fPadC('ITENS DO CUPOM',48));
    ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR('ITEM CÓDIGO DESCRIÇÃO QTD.UN.UNIT(R$)  TOTAL(R$)', 48));
    ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR('', 48, '-'));

    With dadosCupom Do
    Begin

      For intContador := Low(arrMatItens) To High(arrMatItens) Do
      Begin

        strLinItem := '';
        strLinItem := strLinItem + fStrZero(intContador+1, 3) + ' ';
        strLinItem := strLinItem + arrMatItens[intContador].strCodIte + ' ';
        strLinItem := strLinItem + fPadR(arrMatItens[intContador].strDesIte, 38);

        ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( strLinItem, 48 ));

        strLinItem := fPadR('', 13);
        strLinItem := strLinItem + fPadL(fFloatToStrVirgula(arrMatItens[intContador].fltQtdIte, 6, 2), 08);
        strLinItem := strLinItem + fRetSiglaUnidadeIF(arrMatItens[intContador].strUnidad) + ' x ';
        strLinItem := strLinItem + fPadR(fFloatToStrVirgula(arrMatItens[intContador].fltUniTar, 7, 3), 11);
        strLinItem := strLinItem + fPadL(fFloatToStrVirgula(arrMatItens[intContador].fltTotIte, 8, 2), 11);

        ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( strLinItem, 48 ));

      End;

      If fltDesEsp > 0 Then
      Begin
        ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( 'Subtotal R$' + fPadL(fFloatToStrVirgula(fltTotPro, 8, 2), 37), 48 ));
        ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( 'Desconto   ' + fPadL(fFloatToStrVirgula(-fltDesEsp, 8, 2), 37), 48 ));
      End;

      ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( 'Total R$   ' + fPadL(fFloatToStrVirgula(fltTotGer, 8, 2), 37), 48 ));

      cdsModali.First;
      While Not cdsModali.Eof Do
      Begin

        strModali := cdsModali.FieldByName('ECF_CODMOD').AsString;
        strDescMo := Trim(cdsModali.FieldByName('ECF_DESMOD').AsString);
        fltModVal := 0.0;

        While (Not cdsModali.Eof) And (strModali = cdsModali.FieldByName('ECF_CODMOD').AsString) Do
        Begin
          fltModVal := fltModVal + cdsModali.FieldByName('VALOR').AsFloat;
          cdsModali.Next;
        End;

        strLinItem := fPadR(strDescMo, 30);
        strLinItem := strLinItem + fPadL(fFloatToStrVirgula(fltModVal, 8, 2), 18);

        ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( strLinItem, 48 ));

      End;

    End;

  End;

  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR('', 48, '-'));

  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadC('CONDICAO DE PAGAMENTO',48));
  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR('VENCIMENTO VALOR DA PARCELA', 48 ));

  fDigDuplic(fatVenda.arrDuplicata, dadosCupom.strConPag, 0, dadosCupom.fltTotGer, False, False, False, VS_Date, False);

  For intContador := 0 to 23 Do
    fatVenda.arrDuplicata[intContador].curValor := dadosCupom.arrDuplicatasCND[intContador].curValor ;

  For intContador := 0 to 23 Do
    With fatVenda.arrDuplicata[intContador] Do
    If curValor > 0 Then
      ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR(dtaDtaVen + '  ' + FloatToStrF( curValor, ffFixed, 12, 2 ), 48 ))
    Else
      Break;

  If (fStatusCndPag(dadosCupom.strConPag) <> A_VISTA) Then
    pMensagemVinculado(fCfgSisL('MPRAF8'))
  Else
    pMensagemVinculado(fCfgSisL('MVISF8'));

  If (stlMen001.Count > 0) Or (stlMen002.Count > 0) Then
  Begin
    ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( '', 48 ));

    For intContador := 0 To stlMen001.Count -1 Do
      ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( stlMen001[intContador], 48 ));

    For intContador := 0 To stlMen002.Count -1 Do
      ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( stlMen002[intContador], 48 ));
  End;
  
  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( '', 48 ));
  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( '', 48 ));
  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadR( '', 48 ));
  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadC( '____________________________________', 48 ));
  ecfFiscal.fUsaCupomVinculado(strCodErr, fPadC( 'Assinatura', 48 ));

  If Not ecfFiscal.fFechaCupomVinculado(strCodErr) Then
    Exit;

  Result := TRUE;
End;

Function TfrmFatConfOrcamentos.fImprimeEnderecoEntregaNova(strDesMod: String;
  dadosCupom: TDadosImpressaoVenda; strNumCOO: String; cdsModali: TUniClientDataSet): Boolean;
  Var
    intContador: Integer;

    strLinItem: String;
    strCGCCPF: String;
    strIESCli: String;
    strRG_Cli: String;

    strModali: string;
    strDescMo: String;
    fltModVal: Double;

    stlMen001: TStringList;
    stlMen002: TStringList;

  Procedure pMensagemVinculado(strMensagem: String);
    Var
      stlMensagem: TStringList;
      intContador: Integer;
  Begin
    stlMensagem := TStringList.Create;
    stlMensagem.Text := strMensagem;

    If Not fEmptyStr(strMensagem) Then
    Begin
      VS_objFiscal.fRelatorioGerencial(fPadR( '', 48));
      For intContador := 0 To stlMensagem.Count - 1 Do
        VS_objFiscal.fRelatorioGerencial(fPadR( stlMensagem[intContador], 48 ));
    End;

    FreeAndNil(stlMensagem);
  End;
Begin
  Result := FALSE;

  If Not VS_objFiscal.fAbreRelatorioGerencial Then
    Exit;

  stlMen001 := TStringList.Create;
  stlMen002 := TStringList.Create;

  If Not fEmptyStr(dadosCupom.strMen001) Then stlMen001.Text := WrapText(dadosCupom.strMen001, 45);
  If Not fEmptyStr(dadosCupom.strMen002) Then stlMen002.Text := WrapText(dadosCupom.strMen002, 45);

  If Pos('-', dadosCupom.recEndEnt.strCepEnt) = 0 Then  dadosCupom.recEndEnt.strCepEnt := FormatMaskText('99999-999;0;_', dadosCupom.recEndEnt.strCepEnt);

  strCGCCPF := fFormataCpfCgc(dadosCupom.strCliCgc, FPais);
  strIESCli := dadosCupom.strCliIes;
  strRG_Cli := dadosCupom.strCli_Rg;

  If Pos('/', strCGCCPF) > 0 Then
  Begin
    strCGCCPF := 'CNPJ: ' + strCGCCPF;
    strIESCli := 'IES.: ' + strIESCli;
  End
  Else
  Begin
    strCGCCPF := 'CPF: ' + strCGCCPF;
    strIESCli := 'RG.: ' + strRG_Cli;
  End;

  VS_objFiscal.fRelatorioGerencial(fPadR('', 48, '-'));

  If fCfgSis('IMPCAC', varBoolean) Then
    VS_objFiscal.fRelatorioGerencial(fPadC('Cupom Fiscal: ' + dadosCupom.strNumDoc + '-IF' ,48))
  Else
    VS_objFiscal.fRelatorioGerencial(fPadC('COO Cupom Fiscal: ' + strNumCOO,48));
  
  VS_objFiscal.fRelatorioGerencial(fPadC('DADOS DO CLIENTE',48));
  VS_objFiscal.fRelatorioGerencial(fPadR( LeftStr( dadosCupom.strCliNom, 31 ) + '-' + dadosCupom.strCodCli, 48 ));
  VS_objFiscal.fRelatorioGerencial(fPadR(  dadosCupom.strCliEnd + ' - ' + dadosCupom.strCliBai, 48 ));
  VS_objFiscal.fRelatorioGerencial(fPadR('CEP: ' +  dadosCupom.strCliCep + ' - ' + dadosCupom.strCliCid + '-' + dadosCupom.strCliEst, 48 ));
  VS_objFiscal.fRelatorioGerencial(fPadR( dadosCupom.strCliCgc + ' - ' + dadosCupom.strCliIes, 48 ));

  VS_objFiscal.fRelatorioGerencial(fPadR('', 48, '-'));
  VS_objFiscal.fRelatorioGerencial(fPadC('ENDERECO DE ENTREGA',48));

  If fEmptyStr(dadosCupom.recEndEnt.strEndEnt) Then
  Begin
    VS_objFiscal.fRelatorioGerencial(fPadR( dadosCupom.strCliEnd + ' - ' + dadosCupom.strCliBai, 48 ));
    VS_objFiscal.fRelatorioGerencial(fPadR('CEP: ' + dadosCupom.strCliCep + ' - ' + dadosCupom.strCliCid + '-' + dadosCupom.strCliEst, 48 ));
  End Else
  Begin
    VS_objFiscal.fRelatorioGerencial(fPadR( dadosCupom.recEndEnt.strEndEnt + ' - ' + dadosCupom.recEndEnt.strBaiEnt, 48 ));
    VS_objFiscal.fRelatorioGerencial(fPadR('CEP: ' + dadosCupom.recEndEnt.strCepEnt + ' - ' + dadosCupom.recEndEnt.strNomCid + '-' + dadosCupom.recEndEnt.strEstEnt, 48 ));
  End;

  If fCfgSis('IMPDCE', varBoolean) Then
  Begin
    VS_objFiscal.fRelatorioGerencial(fPadR('', 48, '-'));
    VS_objFiscal.fRelatorioGerencial(fPadC('ITENS DO CUPOM',48));
    VS_objFiscal.fRelatorioGerencial(fPadR('ITEM CÓDIGO DESCRIÇÃO QTD.UN.UNIT(R$)  TOTAL(R$)', 48));
    VS_objFiscal.fRelatorioGerencial(fPadR('', 48, '-'));

    With dadosCupom Do
    Begin

      For intContador := Low(arrMatItens) To High(arrMatItens) Do
      Begin

        strLinItem := '';
        strLinItem := strLinItem + fStrZero(intContador+1, 3) + ' ';
        strLinItem := strLinItem + arrMatItens[intContador].strCodIte + ' ';
        strLinItem := strLinItem + fPadR(arrMatItens[intContador].strDesIte, 38);

        VS_objFiscal.fRelatorioGerencial(fPadR( strLinItem, 48 ));

        strLinItem := fPadR('', 5);
        strLinItem := strLinItem + fPadL(fFloatToStrVirgula(arrMatItens[intContador].fltQtdIte, 6, 2), 08);
        strLinItem := strLinItem + fRetSiglaUnidadeIF(arrMatItens[intContador].strUnidad) + ' x ';
        strLinItem := strLinItem + fPadR(fFloatToStrVirgula(arrMatItens[intContador].fltUniTar, 7, 3), 12);
        strLinItem := strLinItem + fPadL(fFloatToStrVirgula(arrMatItens[intContador].fltTotIte, 8, 2), 15);

        VS_objFiscal.fRelatorioGerencial(fPadR( strLinItem, 48 ));

      End;

      If fltDesEsp > 0 Then
      Begin
        VS_objFiscal.fRelatorioGerencial(fPadR( 'Subtotal R$' + fPadL(fFloatToStrVirgula(fltTotPro, 8, 2), 37), 48 ));
        VS_objFiscal.fRelatorioGerencial(fPadR( 'Desconto   ' + fPadL(fFloatToStrVirgula(-fltDesEsp, 8, 2), 37), 48 ));
      End;

      VS_objFiscal.fRelatorioGerencial(fPadR( 'Total R$   ' + fPadL(fFloatToStrVirgula(fltTotGer, 8, 2), 37), 48 ));

      cdsModali.First;
      While Not cdsModali.Eof Do
      Begin

        strModali := cdsModali.FieldByName('ECF_CODMOD').AsString;
        strDescMo := Trim(cdsModali.FieldByName('ECF_DESMOD').AsString);
        fltModVal := 0.0;

        While (Not cdsModali.Eof) And (strModali = cdsModali.FieldByName('ECF_CODMOD').AsString) Do
        Begin
          fltModVal := fltModVal + cdsModali.FieldByName('VALOR').AsFloat;
          cdsModali.Next;
        End;

        strLinItem := fPadR(strDescMo, 30);
        strLinItem := strLinItem + fPadL(fFloatToStrVirgula(fltModVal, 8, 2), 18);

        VS_objFiscal.fRelatorioGerencial(fPadR( strLinItem, 48 ));

      End;

    End;

  End;

  VS_objFiscal.fRelatorioGerencial(fPadR('', 48, '-'));

  VS_objFiscal.fRelatorioGerencial(fPadC('CONDICAO DE PAGAMENTO',48));
  VS_objFiscal.fRelatorioGerencial(fPadR('VENCIMENTO VALOR DA PARCELA', 48 ));

  fDigDuplic(fatVenda.arrDuplicata, dadosCupom.strConPag, 0, dadosCupom.fltTotGer, False, False, False, VS_Date, False);

  For intContador := 0 to 23 Do
    fatVenda.arrDuplicata[intContador].curValor := dadosCupom.arrDuplicatasCND[intContador].curValor ;

  For intContador := 0 to 23 Do
    With fatVenda.arrDuplicata[intContador] Do
    If curValor > 0 Then
      VS_objFiscal.fRelatorioGerencial(fPadR(dtaDtaVen + '  ' + FloatToStrF( curValor, ffFixed, 12, 2 ), 48 ))
    Else
      Break;

  If (fStatusCndPag(dadosCupom.strConPag) <> A_VISTA) Then
    pMensagemVinculado(fCfgSisL('MPRAF8'))
  Else
    pMensagemVinculado(fCfgSisL('MVISF8'));

  If (stlMen001.Count > 0) Or (stlMen002.Count > 0) Then
  Begin
    VS_objFiscal.fRelatorioGerencial(fPadR( '', 48 ));

    For intContador := 0 To stlMen001.Count -1 Do
      VS_objFiscal.fRelatorioGerencial(fPadR( stlMen001[intContador], 48 ));

    For intContador := 0 To stlMen002.Count -1 Do
      VS_objFiscal.fRelatorioGerencial(fPadR( stlMen002[intContador], 48 ));
  End;

  VS_objFiscal.fRelatorioGerencial(fPadR( '', 48 ));
  VS_objFiscal.fRelatorioGerencial(fPadR( '', 48 ));
  VS_objFiscal.fRelatorioGerencial(fPadR( '', 48 ));
  VS_objFiscal.fRelatorioGerencial(fPadC( '____________________________________', 48 ));
  VS_objFiscal.fRelatorioGerencial(fPadC( 'Assinatura', 48 ));

  If Not VS_objFiscal.fFechaRelatorioGerencial Then
    Exit;

  Result := TRUE;
End;

function TfrmFatConfOrcamentos.fRetVencimentos( strConPag: String; dtaDtaEnt: TDateTime ): String;
Var
  intQtdPar: Integer;
  intQtdDia: Integer;
  intContador: Integer;
  strPar001 : String;
  strPar002 : String;
Begin

  Result := '';

  strPar001 := 'Vencimento: ';
  strPar002 := '   ';

  strConPag := Trim( strConPag );
  intQtdPar := StrToInt( LeftStr( strConPag, 2 ) );

  If intQtdPar > 7 Then    //Permite apenas 7 parcelas
    intQtdPar := 7;

  For intContador := 1 to intQtdPar Do
  Begin

    intQtdDia := StrToInt( Copy( strConPag, ( intContador * 3 ), 3 ) );

    If intQtdDia <= 0 Then
      Continue;

    If Length( strPar001 + FormatDateTime( 'dd/mm/yy', dtaDtaEnt + intQtdDia ) + ' ' ) > 48 Then
      strPar002 := strPar002 + FormatDateTime( 'dd/mm/yy', dtaDtaEnt + intQtdDia ) + ' '
    Else
      strPar001 := strPar001 + FormatDateTime( 'dd/mm/yy', dtaDtaEnt + intQtdDia ) + ' '

  End;

  Result := fPadr( strPar001, 48 ) + fPadr( strPar002, 32 );

  If Length( strPar001 ) = 12 Then
    Result := '';

End;

function TfrmFatConfOrcamentos.fVerificaTef: Boolean;
begin
  Result := True;
  If (cdsModalidades.Locate('ECF_IDENTI', '3', [])) And
     (Pos('(POS)',cdsModalidades.FieldByName('DESMOD').AsString) <= 0) And
     (((VS_strUsaTef = 'S') And (Assigned(VS_objTef))) Or (VS_blnTefCitel)) Then
  Begin
    If fMensagem('ATENÇÃO!', 'Há cartões já confirmados. Deseja cancelar os mesmos?', ['',''], 2) = 1 Then
    Begin
      if (VS_blnTefCitel) then
      begin
        if fVerPendenciasTefCitel then
          pLimparTela;
      end
      Else
      begin
        try
          VS_objTef.pVerificaCncNcn;
        finally
          pLimparTela;
        end;
      end;
    End
    Else
      Result := False;
  End;
end;

procedure TfrmFatConfOrcamentos.mskCgcCpfChange(Sender: TObject);
begin
  inherited;
  blnJaConsultouSituacaoRegularCliente := False;
end;

procedure TfrmFatConfOrcamentos.mskCgcCpfExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(mskCgcCpf.Text) Then
    fValidaCampos(mskCgcCpf);
end;

procedure TfrmFatConfOrcamentos.mskNumR_GExit(Sender: TObject);
begin
  inherited;

  If SameText(qryCadCli.FieldByName('CLI_CGCCPF').AsString, '1') Or SameText(edtCgcCpf.Text, '1') Then
    strCliIes := mskNumR_G.Text;

end;

function TfrmFatConfOrcamentos.fAtualizarTabelas(strNumDoc,
                                                 strEspDoc,
                                                 strCodEmp,
                                                 strCodCli,
                                                 strNumCoo,
                                                 strNumSer,
                                                 strNumCcf: String): Boolean;
  Var
    qryAux: TUniQuery;
begin

  Result := True;

  If Pos(strEspDoc, 'NF_EL_NS_IF_IV_D1_') <= 0 Then
    Exit;

  qryAux := fCriaQuery(Nil);

  Try

    qryAux.SQL.Clear;
    qryAux.SQL.Add('UPDATE ');
    qryAux.SQL.Add('  CADFIS ');
    qryAux.SQL.Add('SET ');
    qryAux.SQL.Add('  FIS_NUMCOO = :NUMCOO, ');
    qryAux.SQL.Add('  FIS_NUMSER = :NUMSER ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  FIS_FORCLI = :CODCLI AND ');
    qryAux.SQL.Add('  FIS_TIP_FC = "C" ');

    qryAux.ParamByName('NUMCOO').AsString := strNumCoo;
    qryAux.ParamByName('NUMSER').AsString := strNumSer;

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;

    qryAux.ExecSQL;
    qryAux.Close;

    If (strEspDoc = 'IF') And (Not fEmptyStr(strCodEcf)) Then
    Begin
      pMarcaDocumentoComoImpresso(strNumDoc, strEspDoc, strCodEmp, strCodCli);
      
      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE ');
      qryAux.SQL.Add('  FATGOR ');
      qryAux.SQL.Add('SET ');
      qryAux.SQL.Add('  FGO_NUMCCF = :NUMCCF ');
      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  FGO_NUMDOC = :NUMDOC AND ');
      qryAux.SQL.Add('  FGO_ESPDOC = :ESPDOC AND ');
      qryAux.SQL.Add('  FGO_CODEMP = :CODEMP ');

      qryAux.ParamByName('NUMDOC').AsString := edtNumOrc.Text;
      qryAux.ParamByName('ESPDOC').AsString := strEspCfo;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
      qryAux.ParamByName('NUMCCF').AsString := strNumCcf;

      qryAux.ExecSQL;
      qryAux.Close;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fAtualizarTabelas]');
    End;
  End;

  FreeAndNil(qryAux);

end;

procedure TfrmFatConfOrcamentos.pMarcaDocumentoComoImpresso(strNumDoc,
  strEspDoc, strCodEmp, strCodCli: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Clear;
  qryAux.SQL.Add('UPDATE ');
  qryAux.SQL.Add('  MOVGER ');
  qryAux.SQL.Add('SET ');
  qryAux.SQL.Add('  GER_IMPRES = TRUE ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  GER_CODCLI = :CODCLI AND ');
  qryAux.SQL.Add('  GER_TIP_FC = "C" ');

  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := strCodCli;

  qryAux.ExecSQL;
  qryAux.Close;
  FreeAndNil(qryAux);
end;

procedure TfrmFatConfOrcamentos.cbxModalidadesExit(Sender: TObject);
begin
  inherited;
  If fStrToFloat(edtTotGer.Text) > edtValDig.Value Then
  Begin
    edtValor.Value := fStrToFloat(edtTotGer.Text) - edtValDig.Value;
    if fFormataFloat(edtValor.Value, 2) = 0.00 then
      edtValor.Value := 0.00 ;
  End;
end;

procedure TfrmFatConfOrcamentos.edtCodTraKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTransp: TConsultasArray;
begin
  inherited;
  If (fEntraCons(Key)) And (Not edtCodTra.ReadOnly) Then
  Begin
    {************************************}
    {* NOVA CONSULTA DE TRANSPORTADORAS *}
    {*********************************RV*}
    If fPesqTransportadora(conTraSimples, Self, edtCodTra, edtNomTra, Nil, Key, arrTransp) Then
    Begin
      If fValidaCampos(edtCodTra, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmFatConfOrcamentos.edtEmailExit(Sender: TObject);
begin
  inherited;
  If fValidaCampos(edtEmail, True) Then
  Begin
    If (Not blnRealizandoAdiantamentoPedidoPeloF11) And
       (strEmailAnt <> edtEmail.Text) And
       (fTipoFaturamentoSelec.strEspDoc = 'NF') And
       (Not blnCliCon) And
       (blnPermiteAlterarEmailMedianteConfiguracao) Then
    Begin
      If fMensagem('', 'Deseja Alterar o E-mail de envio da NFE para o cliente?', ['&Sim', '&Não'], 1) = 1 Then
      Begin
        If Not fAlteraEmailNFE(edtCodCli.Text, edtEmail.Text) Then
          fMensagem('ATENÇÃO', 'Ocorreu um erro ao tentar efetuar a alteração de E-Mail do cliente.', ['&Ok'])
        Else
          strEmailAnt := edtEmail.Text;
      End
      Else
        edtEmail.Text := strEmailAnt;
    End;
  End;
end;

procedure TfrmFatConfOrcamentos.edtNpsS_NExit(Sender: TObject);
begin
  If edtNpsS_N.Visible Then
  Begin
    inherited;
    If (edtNpsS_N.Text = 'S') And (TfrmFatDigNetPoints.fCpfVendedorOK(fatVenda.strCodVen)) Then
    Begin
      pCriarFormularios(TfrmFatDigNetPoints, frmFatDigNetPoints);

      If fEmptyStr(fatVenda.objNetpoints.strCpfCli) Then
        fatVenda.objNetpoints.strCpfCli := mskCgcCpf.Text;

      If (fEmptyStr(fatVenda.objNetpoints.strFonCli)) And
         (Not fEmptyStr(edtCodCli.Text)) Then
        fatVenda.objNetpoints.strFonCli := fCampoTabela('CLI_CELULA', 'CADCLI', ['CLI_CODCLI'], [edtCodCli.Text]);

      fatVenda.objNetpoints.strQueNps := 'S';

      frmFatDigNetPoints.objNetpoints := fatVenda.objNetpoints;

      If (Not fEmptyStr(fatVenda.objNetpoints.strCpfCli)) And (frmFatDigNetPoints.fCpfDoClienteJaCadastradoNoNetPoints(fatVenda.objNetpoints.strCpfCli)) Then
      Begin
        frmFatDigNetPoints.objNetPoints.blnCpfCad := True;
        fatVenda.objNetpoints := frmFatDigNetPoints.objNetPoints;
      End
      Else
        frmFatDigNetPoints.ShowModal;

      pFreeAndNil(frmFatDigNetPoints);
    End
    Else
    Begin
      edtNpsS_N.Text := 'N';

      With fatVenda Do
      Begin
        objNetpoints.strQueNps := 'N';
        objNetPoints.strCpfCli := '';
        objNetPoints.strFonCli := '';
        objNetPoints.blnCpfCad := False;
      End;
    End;
  End;
end;

procedure TfrmFatConfOrcamentos.edtNumOrcKeyPress(Sender: TObject;
  var Key: Char);
  Var
    strEspDoc: String;
    strCodEmp: String;
    blnPermitirExibirTodosOsPedidos: Boolean;
    arrDoc   : TConsultasArray;
    objfrmPnl: TPanelCxPedOrc;
    edtCodEmpTmp: TEditFocus;
begin

  If (InterlockedIncrement(intSemaforoConsulta) = 0) Then
  Begin
    Try
      inherited;

      strEspDoc := strEspCfo;

      If (Not blnAltLoj) Then
      Begin
        strCodEmp := VS_strCodEmp;
        edtCodEmpTmp := nil;
      End
      Else
      Begin
        strCodEmp := edtCodEmp.Text;
        edtCodEmpTmp := edtCodEmp;
      End;

      If (blnTravaFaturamentoF11) Then
      Begin
        strCodEmp := edtCodEmp.Text;
        edtCodEmpTmp := edtCodEmp;
      End;

      If fEntraCons(Key) Then
      Begin
        edtNumOrc.Clear;
        FPedidoEntCd := False;
        FPedidoEmpCd := '';
        blnPermitirExibirTodosOsPedidos := fCfgSis('CONEQU', varBoolean);
        objfrmPnl := TPanelCxPedOrc.Create(TfrmPnlDadosPedOrc, strEspDoc, False, blnPermitirExibirTodosOsPedidos, fCfgSis('EXIPED', varBoolean));
        {*******************************}
        {* NOVA CONSULTA DE DOCUMENTOS *}
        {****************************RV*}
        If fPesqPedOrc(conPedCompleta, Self, strEspDoc, strEspDoc, strCodEmp,
                       edtNumOrc, Nil, edtCodEmpTmp, qryConOrc, Key, arrDoc,
                       True, objfrmPnl, '', 'S', '', False, False, '', '', False,  rdbAdiantamentoPedido.Checked ) Then
        Begin
          edtNumOrc.Text := qryConOrc.FieldByName('FGO_NUMDOC').AsString;

          If (fCfgSis('ALTLOJ') = 'N') And (fCfgSis('ENT_CD') = 'S') And (fCfgSis('EMPFAT') = 'S') And
             (qryConOrc.FieldByName('FGO_CODEMP').AsString <> VS_strCodEmp) And (qryConOrc.FieldByName('FGO_ENT_CD').AsString = 'S') Then
          Begin
            FPedidoEntCd := (fCampoTabela('FGO_EMP_CD', 'EXTGOR', ['FGO_SEQFGO'], [qryConOrc.FieldByName('AUTOINCREM').AsString]) = VS_strCodEmp);
            FPedidoEmpCd := qryConOrc.FieldByName('FGO_CODEMP').AsString;
          End;

          pSetarEdtCodEmpInformativo(qryConOrc.FieldByName('FGO_CODEMP').AsString);

        End;

        FreeAndNil(objfrmPnl);
      End;

      InterlockedDecrement(intSemaforoConsulta);

    Except
      On E: Exception Do
      Begin
        InterlockedDecrement(intSemaforoConsulta);
        pMensagensErro(E.Message, '');
      End;
    End;
  End
  ELse
    InterlockedDecrement(intSemaforoConsulta);
end;

procedure TfrmFatConfOrcamentos.pMostraDebitosReceber(strCodCli : String);
begin

  If fEmptyStr(strCodCli) Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(142, 6617, [],
                        ['CODCLI','TRFTCR','PDVLIM','EXIPOR','CODEMP'],
                        [strCodCli,
                        fCfgSis('TRFTCR', varString),
                        IIf(fCfgSis('PDVLIM', varBoolean),'S','N'),
                        IIf(fCfgSis('EXIPOR', varBoolean),'S','N'),
                        VS_strCodEmp],
                        nil,
                        nil,
                        True,
                        False);
  End;

end;

procedure TfrmFatConfOrcamentos.edtTipFatChange(Sender: TObject);
  Var
    strEspecie: String;
    blnEditarCliente: Boolean;
    blnEditarEmail: Boolean;
begin
  inherited;

  blnJaValidouDocs := False;
  btnMsgNot.Visible := (Not SameText(edtTipFat.Text, fDescricaoIF)) And
                       (fCfgSis('QTDMSG', varInteger) > 0);

  strEspecie := 'NF_IF_IV_';

  If (blnTemEntregaImediata) And (fCfgSis('NPDF11', varBoolean)) Then
    strEspecie := strEspecie + 'PD_';

  If (blnTemRetiraOutraLoja) And (fCfgSis('NPRF11', varBoolean)) Then
    strEspecie := strEspecie + 'PD_';

  If (blnTemRetiraExpedicao) And (fCfgSis('LOCRET', varBoolean)) Then
    strEspecie := strEspecie + 'PD_';

  If (blnTemRetiraBalcao) And (fCfgSis('LOCRET', varBoolean)) Then
    strEspecie := strEspecie + 'PD_';

  If (blnTemItensEmpresaCD) And (fCfgSis('ENT_CD', varBoolean)) Then
    strEspecie := strEspecie + 'PD_';

  If (blnRealizandoAdiantamentoPedidoPeloF11) Then
    strEspecie := strEspecie + 'PD_';

  If (Not fEmptyStr(fEspecieCasoConcomitante)) And (Pos(fTipoFaturamentoSelec.strEspDoc, fEspecieCasoConcomitante) <= 0) Then
  Begin
    If Not fEmptyStr(edtTipFat.Text) Then
      pMensagemOk('Quando impressão concomitante, só permitido fechamento em "Cupom Fiscal".');

    pSetaTipoFaturamento(fEspecieCasoConcomitante);
  End;

  pSetaVisibilidadeNotaPaulista;

  If Not blnCliCon Then
    blnEditarCliente := False
  Else
    blnEditarCliente := fCfgSis('ECLF11', varBoolean);

  blnEditarEmail := (blnEditarCliente) Or ((blnPermiteAlterarEmailMedianteConfiguracao) And (Not blnRealizandoAdiantamentoPedidoPeloF11) And (fTipoFaturamentoSelec.strEspDoc = 'NF'));
  edtEmail.ReadOnly := Not blnEditarEmail;
  edtEmail.TabStop := blnEditarEmail;
end;

procedure TfrmFatConfOrcamentos.edtTipFatEnter(Sender: TObject);
begin
  inherited;
  pSetaVisibilidadeNotaPaulista;
end;

function TfrmFatConfOrcamentos.fEspecieCasoConcomitante: String;
begin
  Result := '';
  If (Assigned(VS_objFiscal)) And (VS_objFiscal.EstadoECF = ecfCupomAberto) Then
  Begin
    Result := 'IF';
  End;
end;

function TfrmFatConfOrcamentos.fExecutouRecalculoPrecosCondPagto(blnRecalculaSemPerguntar: Boolean=False): Boolean;
  Var
    objAltCnd: TAlterarPedido;
    fltTotGerAnt: Double;
    strMsg: String;
    blnOriF3: Boolean;
begin
  Result := False;
  objAltCnd := TAlterarPedido.Create(Nil);
  blnOriF3 := fatVenda.blnOriF3;
  fatVenda.blnOriF3 := False;
  Try
    objAltCnd.objVenda := fatVenda;
    objAltCnd.pCarregaCondicao(fatVenda.strCodCnd);
    objAltCnd.blnRecalculaPrecos := True;
    objAltCnd.objVenda.blnEstaRecalculandoPeloAlteraPedidoVenda := True;

    If blnRecalculaSemPerguntar Then
    Begin
      objAltCnd.blnApenasVerificaSeItensTeraoModicacaoAposCondicaoPagamento := False;
      objAltCnd.fCalculaTotalPedido;
    End
    Else
    Begin
      objAltCnd.blnApenasVerificaSeItensTeraoModicacaoAposCondicaoPagamento := True;
      objAltCnd.fCalculaTotalPedido;

      strMsg := '';

      If objAltCnd.blnItensEntraramOuSairamDePromocao Then
        strMsg := 'Essa condição de pagamento pode alterar o valor da venda, pois ativa ou desativa uma promoção!'
      Else If objAltCnd.blnItensTiveramUnitarModificados Then
        strMsg := 'Essa condição de pagamento pode alterar o valor da venda!';  

      If (Not strMsg.IsEmpty) Then
      Begin
        If (fMensagem('AVISO!', strMsg+#10#13+'Deseja manter os preços que constam na tela de check-out?', ['&Sim', '&Não']) = 2) Then
        Begin
          fltTotGerAnt := fatVenda.fltTotGer;

          objAltCnd.blnApenasVerificaSeItensTeraoModicacaoAposCondicaoPagamento := False;
          objAltCnd.fCalculaTotalPedido;

          Result := (fltTotGerAnt <> fatVenda.fltTotGer);
        End
        Else
        Begin
          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('Permitir manter os preços que constam na tela de check-out ao trocar uma condição de pagamento que está ativando ou desativando uma promoção.');
          objLiberacao.objMsgLibera.pAddTexto('');
          objLiberacao.objMsgLibera.pAddTextoCaption('Cliente', fatVenda.strCodCli + ' - ' + fRetNomCliente(fatVenda.strCodCli), 35);
          objLiberacao.objMsgLibera.pAddTextoCaption('Condição de pagamento escolhida', fatVenda.strCodCnd + ' - ' + fRetDesConPag(fatVenda.strCodCnd), 35);

          objLiberacao.strDirAce := 'ATIDESPRM';
          objLiberacao.strMsgSen := 'Não recalcular';
          objLiberacao.blnMosMen := True;
          objLiberacao.strCodOpe := strCodOpe;
          objLiberacao.strCodDig := strCodOpe;


          If (Not objLiberacao.fLibera) Then
          Begin
            fltTotGerAnt := fatVenda.fltTotGer;

            objAltCnd.blnApenasVerificaSeItensTeraoModicacaoAposCondicaoPagamento := False;
            objAltCnd.fCalculaTotalPedido;

            Result := (fltTotGerAnt <> fatVenda.fltTotGer);
          End;
        End;
      End;
    End;
  Finally
    fatVenda.blnOriF3 := blnOriF3;
    objAltCnd.objVenda.blnEstaRecalculandoPeloAlteraPedidoVenda := False;
    FreeAndNil(objAltCnd);
  End;
end;

procedure TfrmFatConfOrcamentos.pCarregaTransportadora(blnCarregaPlaca: Boolean = True);
begin
  qryCadTra.Close;
  qryCadTra.SQL.Clear;
  qryCadTra.SQL.Add('SELECT * FROM CADTRA WHERE TRA_CODTRA = :CODTRA');
  qryCadTra.ParamByName('CODTRA').AsString := edtCodTra.Text;
  qryCadTra.Open;

  edtNomTra.Text := qryCadTra.FieldByName('TRA_NOMTRA').AsString;

  If blnCarregaPlaca Then
    mskPlaFat.Text := AnsiReplaceStr(qryCadTra.FieldByName('TRA_NUMPLA').AsString, '-', '');
end;

procedure TfrmFatConfOrcamentos.pCriaImpFiscalVelha;
  Var
    strCodErr: String;
    strPatIni: String;
begin

  ecfFiscal := TUntFiscal.Create;
  strPatIni := fCfgSis('DIRINI');

  If Not ecfFiscal.pSetModEcf( strModEcf ) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não foi possivel setar o Modelo da Impressora. Verifique o Modelo Configurado!', ['&Ok']);
    Exit;
  End;

  If Not ecfFiscal.fIniciaEcf( strCodErr, strPatIni, strPorta ) Then
  Begin
    fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
    Exit;
  End;

end;

procedure TfrmFatConfOrcamentos.pZeraOpcaoTrocoCheque;
begin
  optTroco         := otNada;
  fltValorTroco    := 0.0;

  optTrocoPre      := otNada;
  fltValorTrocoPre := 0.0;

  optTrocoCar      := otNada;
  fltValorTrocoCar := 0.0;

  optTrocoDin := otNada;
  fltValorTrocoDin := 0.0;

  blnTrocoComoCredito := False;
end;

procedure TfrmFatConfOrcamentos.rdbEmissaoFaturamentoClick(Sender: TObject);
begin
  inherited;
  blnRealizandoAdiantamentoPedidoPeloF11 := rdbAdiantamentoPedido.Checked;
  pSetaOpcoesFaturamento;

  If Not blnRealizandoAdiantamentoPedidoPeloF11 Then
    lblTotIte.Caption := 'Total dos Itens:'
  Else
    lblTotIte.Caption := 'Total do adiantamento:';

  If pnlComanda.Visible Then
    pSetFocus(edtBarCom)
  Else
    pSetFocus(edtNumOrc);

  pnlOpcaoEmiFatOuAdto.Color := IIF(blnRealizandoAdiantamentoPedidoPeloF11,
                                    clGreen,
                                    clBlue);
end;

function TfrmFatConfOrcamentos.RealizaPerguntaDoTipoDeOrdemDePagamento: Boolean;
begin
  Result := qryFatGor.IsEmpty;

  If Not Result Then
    Result := fCampoTabela('CND_RECPIX', 'CADCND', ['CND_CODIGO'], [qryFatGor.FieldByName('FGO_CODCND').AsString]) <> 'S'
  Else
  Begin
    If fatVenda.blnOriF3 Then
      Result := fCampoTabela('CND_RECPIX', 'CADCND', ['CND_CODIGO'], [strDigCodCnd]) <> 'S';
  End;

  If Result Then
    Result := fCfgSis('F11ORD') = 'A';

  If Result Then
    Result :=  Not cdsModalidades.Locate('CODFPG', '012', []);
end;

function TfrmFatConfOrcamentos.RetornaTipoDePagamentoOrdemPix: TTipoOrdemPagamento;
begin
  Result := tpoPix;

  If fatVenda.DadosPixDaVenda.LstPixPago.Count > 0 Then
    Exit;

  If cdsModalidades.Locate('CODFPG', '012', []) Then
    Result := tpoTransferencia;
end;

procedure TfrmFatConfOrcamentos.pAtualizaNumCcd(fatVenda: TFatVenda);
  Var
    intContador: Integer;
    qryUpd: TUniQuery;
begin

  qryUpd := fCriaQuery(Nil);

  Try
    fStartTransaction;
    qryUpd.SQL.Clear;
    qryUpd.SQL.Add('UPDATE ');
    qryUpd.SQL.Add('  MOVCAR ');
    qryUpd.SQL.Add('SET ');
    qryUpd.SQL.Add('  MCA_NUMCCD = :NUMCCD ');
    qryUpd.SQL.Add('WHERE ');
    qryUpd.SQL.Add('  MCA_DOCUME = :DOCUME ');

    For intContador := Low(arrCartoes) To High(arrCartoes) Do
    Begin
      qryUpd.Close;
      qryUpd.ParamByName('NUMCCD').AsString := arrCartoes[intContador].strNumCcd;
      qryUpd.ParamByName('DOCUME').AsString := fatVenda.strNumDoc + '-A-' +
                                               fatVenda.strEspDoc + '-' +
                                               VS_strCodEmp + '-000-' + fStrZero(intContador, 2);
      qryUpd.ExecSQL;
      qryUpd.Close;
    End;
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Raise Exception.Create(E.Message);
    End;
  End;

  FreeAndNil(qryUpd);
end;

procedure TfrmFatConfOrcamentos.pAtualizaOrdemProducaoVinculada;
var
  Item: TDadosFechamento;
  strCodPro: String;
  qryAtualiza: TUniQuery;
begin
  if not Assigned(fatVenda) then
    Exit;

  if fatVenda.strEspDoc <> 'PD' then
    Exit;

  if fatVenda.strEspOrigem <> 'PD' then
    Exit;

  if not fPedidoComOrdemProducao then
    Exit;

  qryAtualiza := fCriaQuery;

  try
    qryAtualiza.Close;
    qryAtualiza.SQL.Clear;
    qryAtualiza.SQL.Add('UPDATE MOVPRO');
    qryAtualiza.SQL.Add('SET PRO_NUMPED = :NUMPED');
    qryAtualiza.SQL.Add(', PRO_ESPPED = :ESPPED');
    qryAtualiza.SQL.Add(', PRO_EMPPED = :EMPPED');
    qryAtualiza.SQL.Add('WHERE PRO_NUMDOC = :NUMDOC');
    qryAtualiza.SQL.Add('AND PRO_ESPDOC = :ESPDOC');
    qryAtualiza.SQL.Add('AND PRO_CODEMP = :CODEMP');
    qryAtualiza.SQL.Add('AND PRO_CODCLI = :CODCLI');
    qryAtualiza.SQL.Add('AND PRO_CODITE = :CODITE');

    for item in fatVenda.arrMatItens do
    begin
      strCodPro := fCampoTabela('PRO_CODPRO','MOVPRO',['PRO_NUMDOC','PRO_ESPDOC','PRO_CODEMP','PRO_CODCLI','PRO_CODITE'],[fatVenda.strNumOrigem,fatVenda.strEspOrigem,fatVenda.strEmpOrigem,fatVenda.strCodCli,item.strCodIte]);

      if fEmptyStr(strCodPro) then
        Continue;

      TOrdPro.pLimpaOrdProDoPedido(strCodPro, fatVenda.strNumOrigem, fatVenda.strEspOrigem, fatVenda.strEmpOrigem);

      qryAtualiza.Close;
      qryAtualiza.ParamByName('NUMPED').AsString := fatVenda.strNumDoc;
      qryAtualiza.ParamByName('ESPPED').AsString := fatVenda.strEspDoc;
      qryAtualiza.ParamByName('EMPPED').AsString := fatVenda.strEmpDoc;
      qryAtualiza.ParamByName('NUMDOC').AsString := fatVenda.strNumOrigem;
      qryAtualiza.ParamByName('ESPDOC').AsString := fatVenda.strEspOrigem;
      qryAtualiza.ParamByName('CODEMP').AsString := fatVenda.strEmpOrigem;
      qryAtualiza.ParamByName('CODCLI').AsString := fatVenda.strCodCli;
      qryAtualiza.ParamByName('CODITE').AsString := item.strCodIte;
      qryAtualiza.ExecSQL;
    end;
  finally
    FreeAndNil(qryAtualiza);
  end;
end;

procedure TfrmFatConfOrcamentos.pCarregaDadosCadastraisConsumidor;
  Var
    qryCliCon: TUniQuery;
    strCodCli: String;

  function fValidaCgcCpf: Boolean;
  begin
    Result := (Not fEmptyStr(fTiraCaracEspeciais(mskCgcCpf.Text))) And
              (Not fStringRepetida(fTiraCaracEspeciais(mskCgcCpf.Text)));
  end;

begin
  If Not fValidaCgcCpf Then
    Exit;

  qryCliCon := fCriaQuery;

  With qryCliCon Do
  Begin
    pPesquisaCadCliCon(qryCliCon, qryCliCon, mskCgcCpf.Text);

    If (Not IsEmpty) And (Not fEmptyStr(FieldByName('CON_C_P_F_').AsString)) Then
    Begin
      edtCgcCpf.Text := FieldByName('CON_CGCCPF').AsString;
      mskCgcCpf.Text := FieldByName('CON_C_P_F_').AsString;
      edtNomCli.Text := FieldByName('CON_NOMCON').AsString;
      edtEndEnt.Text := FieldByName('CON_ENDERE').AsString;
      edtBaiEnt.Text := FieldByName('CON_BAIRRO').AsString;
      mskCepEnt.Text := FieldByName('CON_C_E_P_').AsString;
      edtCidEnt.Text := FieldByName('CON_CODCID').AsString;

      If edtCgcCpf.Text = '1' Then
        mskNumR_G.Text := FieldByName('CON_I_E_S_').AsString
      Else
        mskNumR_G.Text := FieldByName('CON_NUMR_G').AsString;

      strEmlCon := FieldByName('CON_EMLCON').AsString;
    End
    Else
    Begin
      strCodCli := fRetClientePorCgcCpf(StrToIntDef(edtCgcCpf.Text, 0),
                                        fTiraCaracEspeciais(mskCgcCpf.Text));
      If Not fEmptyStr(strCodCli) Then
      Begin
        pPesquisaCadCli(qryCliCon, qryCliCon, strCodCli);

        If (Not IsEmpty) And (Not fEmptyStr(FieldByName('CLI_C_G_C_').AsString)) Then
        Begin
          edtCgcCpf.Text := FieldByName('CLI_CGCCPF').AsString;
          mskCgcCpf.Text := FieldByName('CLI_C_G_C_').AsString;
          edtNomCli.Text := FieldByName('CLI_NOMCLI').AsString;
          edtEndEnt.Text := FieldByName('CLI_ENDERE').AsString + ' ' + FieldByName('CLI_ENDNUM').AsString + ' ' + FieldByName('CLI_ENDCOM').AsString;
          edtBaiEnt.Text := FieldByName('CLI_BAIRRO').AsString;
          mskCepEnt.Text := FieldByName('CLI_C_E_P_').AsString;
          edtCidEnt.Text := FieldByName('CLI_CODCID').AsString;

          If edtCgcCpf.Text = '1' Then
            mskNumR_G.Text := FieldByName('CLI_I_E_S_').AsString
          Else
            mskNumR_G.Text := FieldByName('CLI_NUMR_G').AsString;

          strEmlCon := FieldByName('CLI_EMAIL3').AsString;
        End;
      End;
    End;

    edtEmail.Text:= AnsiLowerCase(strEmlCon);
    pSetaVisibilidadeNetpoints;
    pSetaVisibilidadeNotaPaulista;
  End;

  pCarregaCadCid;

  FreeAndNil(qryCliCon);
end;

function TfrmFatConfOrcamentos.fItensObrigatoriedadeCodigoIbama(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: String): Boolean;
  Var
    qryAux: TUniQuery;
begin

  Result := False;

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  CLI_CODIBA ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  FATDOR ');
  qryAux.SQL.Add('  JOIN FATGOR ON FGO_NUMDOC = FDO_NUMDOC AND ');
  qryAux.SQL.Add('                 FGO_ESPDOC = FDO_ESPDOC AND ');
  qryAux.SQL.Add('                 FGO_CODEMP = FDO_CODEMP AND ');
  qryAux.SQL.Add('                 FGO_CODCLI = FDO_CODCLI ');
  qryAux.SQL.Add('  JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI ');
  qryAux.SQL.Add('  JOIN CADITE ON ITE_CODITE = FDO_CODITE ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  FDO_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  FDO_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  FDO_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  FDO_CODCLI = :CODCLI AND ');
  qryAux.SQL.Add('  ITE_OBRIBA = "S" ');

  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := strCodCli;

  qryAux.Open;

  If (Not qryAux.IsEmpty) Then
  Begin

    If fEmptyStr(qryAux.FieldByName('CLI_CODIBA').AsString) Then
    Begin
      fMensagem('ATENÇÃO!', 'Há itens com obrigatoriedade de código IBAMA no cliente, ' +
                            'porém o cliente "' + strCodCli + '" não possui este código informado no ' +
                            'seu cadastro. Favor verificar o cadastro do cliente!', ['&Ok']);
      Result := True;
    End;

  End;

  FreeAndNil(qryAux);
end;

function TfrmFatConfOrcamentos.fItensObrigatoriedadeCpf(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: String): Boolean;
  Var
    qryAux: TUniQuery;
    intCgcCpf: Integer;
begin

  Result := False;

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", FGO_CGCCON, CLI_C_G_C_) AS NUMCGC ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  FATDOR ');
  qryAux.SQL.Add('  JOIN FATGOR ON FGO_NUMDOC = FDO_NUMDOC AND ');
  qryAux.SQL.Add('                 FGO_ESPDOC = FDO_ESPDOC AND ');
  qryAux.SQL.Add('                 FGO_CODEMP = FDO_CODEMP AND ');
  qryAux.SQL.Add('                 FGO_CODCLI = FDO_CODCLI ');
  qryAux.SQL.Add('  JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI ');
  qryAux.SQL.Add('  JOIN CADITE ON ITE_CODITE = FDO_CODITE ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  FDO_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  FDO_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  FDO_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  FDO_CODCLI = :CODCLI AND ');
  qryAux.SQL.Add('  ITE_OBRCPF = "S" ');

  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := strCodCli;

  qryAux.Open;

  If (Not qryAux.IsEmpty) Then
  Begin

    intCgcCpf := IIF(Length(qryAux.FieldByName('NUMCGC').AsString) > 11, 1, 2);

    If (fEmptyStr(qryAux.FieldByName('NUMCGC').AsString))                                      Or
       (fStringRepetida(qryAux.FieldByName('NUMCGC').AsString))                                Or
       (Not fValidaCnpjCpf(IntToStr(intCgcCpf), qryAux.FieldByName('NUMCGC').AsString, False)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Há itens com obrigatoriedade de CPF/CNPJ. Favor apresentar ' +
                            'a documentação necessária no balcão.', ['&Ok']);
      Result := True;
    End;

  End;

  FreeAndNil(qryAux);
end;

procedure TfrmFatConfOrcamentos.fMostraCadPagto;
  Var
    intAux : integer;
begin
  If fCfgSis('USACND', varBoolean) Then
    intAux := 0
  Else
    intAux := 26;

  Self.Height         := Self.Height - intAux;
  pnlCabecalho.Height := pnlCabecalho.Height - intAux;
  lblCadPag.Visible   := intAux = 0;
  edtCodPag.Visible   := intAux = 0;
  mskCndPag.Visible   := intAux = 0;
  edtDesPag.Visible   := intAux = 0;
end;

function TfrmFatConfOrcamentos.fNaoVerificouMinimoNoOrcamentoOuPedido: Boolean;
begin
  Result := ((fatVenda.strEspOrc = 'OR') and (fCfgSis('TRVMIN') <> 'T')) or
            ((fatVenda.strEspDoc = 'PD') and (fCfgSis('TRMNPD') <> 'T')) or
            ((fatVenda.strEspOrc = 'PD') and (fCfgSis('TRMNPD') <> 'T'));
end;

function TfrmFatConfOrcamentos.fObtemDadoPinPad(
  pgbProgresso: TcxProgressBar): Boolean;
var
  LstrDocumentoPinPad: String ;
  LintOpcao: integer ;
begin
  Result := False ;

  LintOpcao := strToIntDef(fTrimAll(edtCgcCpf.Text), 0) ;
  if (LintOpcao <> 1) and (LintOpcao <> 2) then
  begin
    fMensagem('ATENÇÃO', 'Opção inválida!', ['&O k']);
    exit ;
  end ;

  pInformacao('Aguardando o cliente informar o ' + ifthen(LintOpcao = 1, 'CNPJ', 'CPF') + ' no Pin Pad...', pgbProgresso);
  btnLerPinPad.Enabled := False ;
  try
    if fAcessoDiretoPinPadCitel then
      LstrDocumentoPinPad := fObtemDadosPinPadCitelDireto(fIfthen(LintOpcao = 1, ppcdCnpj, ppcdCpf))
    else
      LstrDocumentoPinPad := fObtemDadoPinPadDireto(LintOpcao) ;

    mskCgcCpf.Text := LstrDocumentoPinPad ;
    pSetFocus(mskCgcCpf);
  finally
    btnLerPinPad.Enabled := True ;
  end ;

  Result := True ;
end;

{**********************************************}
{* CHAMA A TELA DE CONFERENCIA DE ITENS DO    *}
{* DOCUMENTO, RESULTA TRUE SE ESTIVER TUDO OK *}
{*******************************************JC*}
function TfrmFatConfOrcamentos.fConferenciaProdutos: Boolean;
begin
  Result := False;

  Try
    pCriarFormularios(TfrmFatConfOrcamentosItens, frmFatConfOrcamentosItens);
    frmFatConfOrcamentosItens.strNumDoc := edtNumOrc.Text;
    frmFatConfOrcamentosItens.strEspDoc := strEspCfo;
    frmFatConfOrcamentosItens.strCodOpe := strCodOpe;
    frmFatConfOrcamentosItens.strCodEmp := fEmpresaDocumento;
    frmFatConfOrcamentosItens.objCodBar := objCodBar;
    frmFatConfOrcamentosItens.blnRcxF11 := blnRcxF11;
    frmFatConfOrcamentosItens.blnDocImportadoPedOrc := Not fEmptyStr(strNumDocImportadoPedOrc);
    frmFatConfOrcamentosItens.ShowModal;

    Result := frmFatConfOrcamentosItens.blnConferido;

    If Assigned(cdsIteCfo) Then
      FreeAndNil(cdsIteCfo);

    If (Result) Then
    Begin
      cdsIteCfo := TUniClientDataSet.Create(Nil);
      pCloneDataSet(cdsIteCfo, frmFatConfOrcamentosItens.cdsItens);

      cdsIteCfo.First;
      while not cdsIteCfo.Eof do
      begin

        if cdsIteCfo.FieldByName('QTDLIB').AsFloat > 0 then
        begin
          fatVenda.fAtualizaTipoBusca(cdsIteCfo.FieldByName('AUTOINCREM').AsString, cdsIteCfo.FieldByName('TIPBUS').AsString);
        end;

        cdsIteCfo.Next;
      end;

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fConferenciaProdutos]');
    End;
  End;

  pFreeAndNil(frmFatConfOrcamentosItens);
end;

function TfrmFatConfOrcamentos.fVendaAberta: Boolean;
begin
  Result := False;
  If (Not cdsItensAdd.IsEmpty) Or ((Not qryFatGor.IsEmpty) And (cdsModalidades.RecordCount > 0)) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Iniciado um PD/OR no F11 ou Cancelamento de item no check-out');
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'        , edtCodCli.Text + '-' + fRetNomCliente(edtCodCli.Text), 14);
    objLiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ'       , fFormataCpfCgc(fRetCgcCpf(edtCodCli.Text), fSetaPais), 14);
    objLiberacao.objMsgLibera.pAddTextoCaption('Nome Fantasia'  , fRetNomFantasia(edtCodCli.Text)                      , 14);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor da Venda' , FormatFloat('#,##0.00', fStrToFloat(edtTotGer.Text)) , 14);

    objLiberacao.strDirAce := 'CANCF4C';
    objLiberacao.strSenLib := fCfgSis('SENLBD');
    objLiberacao.strMsgSen := 'Iniciado um PD/OR no F11 ou Cancelamento de item no check-out';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := strCodOpe;
    objLiberacao.strCodDig := strCodOpe;
    objLiberacao.strSenLibNv2 := fCfgSis('SENLN2');
    objLiberacao.blnUsarSenhaFixa := False;

    If Not objLiberacao.fLibera Then
    Begin
      Result := True;
    End;
  End;
end;

function TfrmFatConfOrcamentos.fVerificaPromocao: Boolean;
  Var
    qryGen: TUniQuery;
    strTabPre: String;
    strPromocao: String;
    fltProPreCus: Double;
    fltProPreVen: Double;
    fltProComVar: Double;
    fltProComAta: Double;
    fltProComDis: Double;
    fltQtdDis: Double;
    fltDesF07: Double;
    fltPrecoDaTinta: Double;
    fltTaxVprAnt: Double;
    fltPrecoEstrutu: Double;
    blnParticiona: Boolean;
    blnPromo: Boolean;
    strComPro: String;
    strCodPro: String;
    strCndTmp: String;
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
    frmItensSemPro : TfrmItensSemPro;
    intIdx: Integer;
    cdsVendaAux: TUniClientDataSet;
    blnAplicarTaxaJuros : Boolean;

    function fGetQtdJaDigitadaItem: Double;
      Var
        strSeqGer, strAutInc, strCodIte: String;
    begin
      strCodIte := qryGen.FieldByName('FDO_CODITE').AsString;
      strSeqGer := qryGen.FieldByName('FDO_SEQGER').AsString;
      strAutInc := qryGen.FieldByName('AUTOINCREM').AsString;

      Result := fCampoTabela('SUM(IF(AUTOINCREM = "' + strAutInc + '", 0, FDO_QTDITE))',
        'FATDOR', ['FDO_CODITE', 'FDO_SEQGER'], [strCodIte, strSeqGer]);
    end;

    function fGetQtdJaEmPromocaoItem: Double;
      Var
        strSeqGer, strAutInc, strCodIte: String;
    begin
      strCodIte := qryGen.FieldByName('FDO_CODITE').AsString;
      strSeqGer := qryGen.FieldByName('FDO_SEQGER').AsString;
      strAutInc := qryGen.FieldByName('AUTOINCREM').AsString;

      Result := fCampoTabela('SUM(IF(AUTOINCREM = "' + strAutInc + '", 0, FDO_QTDITE))',
        'FATDOR', ['FDO_CODITE', 'FDO_SEQGER', 'FDO_PROMOC'], [strCodIte, strSeqGer, 'S']);
    end;

    function fRetEmpresaItem: String;
    Begin
      Result := IIF(fEmptyStr(qryGen.FieldByName('FDO_EMPITE').AsString), VS_strCodEmp, qryGen.FieldByName('FDO_EMPITE').AsString);
    End;

    function fPrecoDeVenda: Double;
    Begin
      If (qryGen.FieldByName('FDO_IDEPRO').AsString = 'NOR') Then
      Begin
        If (fltPrecoEstrutu = 0) Then
          Result := qryGen.FieldByName('ITE_PREVE' + strTabPre).AsFloat
        Else
          Result := fltPrecoEstrutu
      End
      Else
        Result := fltPrecoDaTinta;
    End;

Begin
  Result := False;

  fltTaxVprAnt := fatVenda.fltTaxVpr;
  qryGen := fCriaQuery(Nil);
  Try
    Try
      Result := True;

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT ');
        SQL.Add(' FATDOR.FDO_SEQGER, ');
        SQL.Add(' FATDOR.AUTOINCREM, ');
        SQL.Add(' ITE_PREVE1, ');
        SQL.Add(' ITE_PREVE2, ');
        SQL.Add(' ITE_PREVE3, ');
        SQL.Add(' ITE_PREVE4, ');
        SQL.Add(' ITE_PREVE5, ');
        SQL.Add(' ITE_PREVE6, ');
        SQL.Add(' ITE_PREVE7, ');
        SQL.Add(' FDO_PROMOC, ');
        SQL.Add(' FDO_CODITE, ');
        SQL.Add(' FDO_DESCRI, ');
        SQL.Add(' FDO_UNITAR, ');
        SQL.Add(' FDO_QTDITE, ');
        SQL.Add(' FDO_CODCLI, ');
        SQL.Add(' FDO_TABPRE, ');
        SQL.Add(' FDO_CODCND, ');
        SQL.Add(' FDO_EMPITE, ');
        SQL.Add(' FDO_EMPDMP, ');
        SQL.Add(' FDO_ENTRET, ');
        SQL.Add(' FDO_LOCRET, ');
        SQL.Add(' FDO_ENTFUT, ');
        SQL.Add(' FDO_MOTFUT, ');
        SQL.Add(' FDO_IDEPRO, ');
        SQL.Add(' FDO_CODCND, ');
        SQL.Add(' UNI_SIGUNI  ');
        SQL.Add('FROM ');
        SQL.Add('  FATDOR ');
        SQL.Add('       JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM ');
        SQL.Add('       JOIN ITEGER ON ITE_CODITE = FDO_CODITE AND ITE_CODEMP = FDO_CODEMP ');
        SQL.Add('  LEFT JOIN CADUNI ON FDO_UNIDAD = UNI_CODUNI ');
        SQL.Add('WHERE ');
        SQL.Add('  FDO_NUMDOC = :NUMDOC AND ');
        SQL.Add('  FDO_ESPDOC = :ESPDOC AND ');
        SQL.Add('  FDO_CODEMP = :CODEMP ');

        ParamByName('NUMDOC').AsString := edtNumOrc.Text;
        ParamByName('ESPDOC').AsString := strEspCfo;
        ParamByName('CODEMP').AsString := fRetornaCodigoDaEmpresa;
        Open;

        fatVenda.blnDeCndF := (fCfgSis('CNDVEN') = 'F');
        strCndTmp := fRetConPag(fatVenda.strCodCnd);
        fatVenda.pCalculaTaxVpr(strCndTmp);

        pCriarFormularios(TfrmItensSemPro,frmItensSemPro);
        Try
          While Not Eof Do
          Begin
            fltPrecoEstrutu := 0;

            If FieldByName('FDO_PROMOC').AsString = 'S' Then
            Begin
              strTabPre   := FieldByName('FDO_TABPRE').AsString;
              strPromocao := 'N';

              If FieldByName('FDO_IDEPRO').AsString = 'NOR' Then
              Begin
                If (fRetornaPrecosPromocao(FieldByName('FDO_CODITE').AsString,
                                           FieldByName('FDO_CODCLI').AsString,
                                           VS_Date,
                                           FieldByName('FDO_QTDITE').AsFloat,
                                           fGetQtdJaDigitadaItem,
                                           fGetQtdJaEmPromocaoItem,
                                           0,
                                           fltProPreCus,
                                           fltProPreVen,
                                           fltProComVar,
                                           fltProComAta,
                                           fltProComDis,
                                           fltQtdDis,
                                           fltDesF07,
                                           strComPro,
                                           strCodPro,
                                           blnParticiona,
                                           blnPromo,
                                           strTabPre,
                                           FieldByName('FDO_CODCND').AsString,
                                           '',
                                           '',
                                           True,
                                           False,
                                           '-1',
                                           ((FieldByName('FDO_ENTRET').AsString = 'E') And (FieldByName('FDO_ENTFUT').AsString = 'N')),
                                           ((FieldByName('FDO_ENTRET').AsString = 'E') And (FieldByName('FDO_ENTFUT').AsString = 'S')),
                                           FieldByName('FDO_MOTFUT').AsString,
                                           fatVenda.fGetEmpPrecoPromoItem(fRetEmpresaItem, FieldByName('FDO_EMPDMP').AsString),
                                           edtNumOrc.Text,
                                           strEspCfo)) Then
                Begin
                  If (Not blnParticiona) Then
                    strPromocao := 'S';
                End;

                If (fCfgSis('SUGVLE') = '2') And
                   (fItemEstrutura(FieldByName('FDO_CODITE').AsString)) Then
                Begin
                  blnAplicarTaxaJuros := Not ((fatVenda.strJurPro = 'N') And (FieldByName('FDO_PROMOC').AsString = 'S'));
                  fltPrecoEstrutu := fatVenda.fCalculaPrecoEstrutura(blnAplicarTaxaJuros And fAplicarTaxaJurosPrecoSugestao,
                                                                     Preco_de_Venda,
                                                                     FieldByName('FDO_CODITE').AsString,
                                                                     FieldByName('FDO_EMPITE').AsString,
                                                                     'S',
                                                                     strTabPre,
                                                                     fatVenda.fltMargem);

                  If blnAplicarTaxaJuros Then
                  Begin
                    If fAplicarTaxaJurosPrecoSugestao Then
                      fltPrecoEstrutu := fltPrecoEstrutu + fFormataFloat(fltPrecoEstrutu * (fatVenda.fGetTaxVprItem(FieldByName('FDO_CODITE').AsString, FieldByName('FDO_EMPITE').AsString, strCndTmp) / 100.0), 04);
                  End;

                  strPromocao := fatVenda.strPromoc;
                End
              End
              Else
              Begin
                strPromocao := IIF(fatVenda.fExisteTintaComPromocaoVencidaNoPedido(edtNumOrc.Text,
                                                                                   strEspCfo,
                                                                                   fRetEmpresaItem,
                                                                                   FieldByName('FDO_CODCLI').AsString,
                                                                                   FieldByName('FDO_CODITE').AsString,
                                                                                   fltPrecoDaTinta),'N','S');
              End;

              If strPromocao = 'N' Then
              Begin
                frmItensSemPro.cdsDados.Append;
                frmItensSemPro.cdsDados.FieldByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
                frmItensSemPro.cdsDados.FieldByName('CODITE').AsString := FieldByName('FDO_CODITE').AsString;
                frmItensSemPro.cdsDados.FieldByName('DESCRI').AsString := FieldByName('FDO_DESCRI').AsString;
                frmItensSemPro.cdsDados.FieldByName('UNIDAD').AsString := FieldByName('UNI_SIGUNI').AsString;
                frmItensSemPro.cdsDados.FieldByName('VALPRO').AsFloat  := FieldByName('FDO_UNITAR').AsFloat;
                frmItensSemPro.cdsDados.FieldByName('VALSPR').AsFloat  := fPrecoDeVenda;
                frmItensSemPro.cdsDados.FieldByName('QTDITE').AsFloat  := FieldByName('FDO_QTDITE').AsFloat;
                frmItensSemPro.cdsDados.FieldByName('QTDEXC').AsFloat  := FieldByName('FDO_QTDITE').AsFloat - fltQtdDis;
                frmItensSemPro.cdsDados.FieldByName('QTDLIM').AsFloat  := fDadosPromocao(FieldByName('FDO_CODITE').AsString,
                                                                                         fatVenda.fGetEmpPrecoPromoItem(fRetEmpresaItem, FieldByName('FDO_EMPDMP').AsString),
                                                                                         FieldByName('FDO_CODCLI').AsString,
                                                                                         strTabPre,
                                                                                         '',
                                                                                         edtNumOrc.Text,
                                                                                         strEspCfo,
                                                                                         strCodPro).fltQtdLim;
                frmItensSemPro.cdsDados.Post;
              End;

            End;

            Next;
          End;

          If Not frmItensSemPro.cdsDados.IsEmpty Then
          Begin
            frmItensSemPro.ShowModal;

            objLiberacao.Clear;
            objLiberacao.objMsgLibera.pAddSeparador(105);
            objLiberacao.objMsgLibera.pAddTexto('LIBERAÇÃO DE PROMOÇÃO EXCEDIDA', alCentro, teAutcom, '', 105);

            objTabela := TRegistroMsgLiberaTabela.Create;

            objLinha  := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlCabecalho;
            objLinha.pAddColuna(''  , 'COD.'       , fTamCodIte  , alEsquerda , teAutcom);
            objLinha.pAddColuna(''  , 'DESCRICAO'  , 38 , alEsquerda , teAutcom);
            objLinha.pAddColuna(''  , 'UN'         , 3  , alCentro   , teAutcom);
            objLinha.pAddColuna(''  , 'QUANTIDADE' , 11 , alDireita  , teAutcom);
            objLinha.pAddColuna(''  , 'QTD.EXCED'  , 11 , alDireita  , teAutcom);
            objLinha.pAddColuna(''  , 'VR. PROMO'  , 11 , alDireita  , teAutcom);
            objLinha.pAddColuna(''  , 'VR. ATUAL'  , 11 , alDireita  , teAutcom);
            objTabela.lstLinhas.Add(objLinha);


            With frmItensSemPro.cdsDados Do
            Begin
              First;
              While Not Eof Do
              Begin

                objLinha  := TLinhaMsgLibera.Create;
                objLinha.enuTipoLinha := tlValor;
                objLinha.pAddColuna('COD.'       , FieldByName('CODITE').AsString , fTamCodIte  , alEsquerda);
                objLinha.pAddColuna('DESCRICAO'  , FieldByName('DESCRI').AsString , 38 , alEsquerda);
                objLinha.pAddColuna('UN'         , FieldByName('UNIDAD').AsString , 3  , alCentro  );
                objLinha.pAddColuna('QUANTIDADE' , FloatToStrF(FieldByName('QTDITE').AsFloat, ffFixed, 12, fCfgSis('DECQTD', varInteger)), 11 , alDireita );
                objLinha.pAddColuna('QTD.EXCED'  , FloatToStrF(FieldByName('QTDEXC').AsFloat, ffFixed, 12, fCfgSis('DECQTD', varInteger)), 11 , alDireita );
                objLinha.pAddColuna('VR. PROMO'  , FloatToStrF(FieldByName('VALPRO').AsFloat, ffFixed, 12, 2), 11 , alDireita);
                objLinha.pAddColuna('VR. ATUAL'  , FloatToStrF(FieldByName('VALSPR').AsFloat, ffFixed, 12, 2), 11 , alDireita);
                objTabela.lstLinhas.Add(objLinha);

                Next;
              End;
            End;

            objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

            objLiberacao.strDirAce := 'PROEXC';
            objLiberacao.strSenLib := fCfgSis('PROEXC');
            objLiberacao.strMsgSen := 'Promoção Excedida';
            objLiberacao.strCodOpe := strLoginUsuarioLogado;

            If (objLiberacao.fLibera) Then
            Begin
              blnLiberouPromocaoVencida := True;
              cdsVendaAux := TUniClientDataSet.Create(Nil);
              cdsVendaAux.Data := oleItensVendaPed;
              Try
                frmItensSemPro.cdsDados.First;
                While Not frmItensSemPro.cdsDados.Eof Do
                Begin
                  For intIdx := 0 To Length(fatVenda.arrMatItens) -1 Do
                  Begin
                    If (frmItensSemPro.cdsDados.FieldByName('AUTINC').AsString = fatVenda.arrMatItens[intIdx].strSeqDet) Then
                      fatVenda.arrMatItens[intIdx].strPromoc := 'N';
                  End;

                  cdsVendaAux.First;
                  If cdsVendaAux.Locate('ITE_SEQDET', frmItensSemPro.cdsDados.FieldByName('AUTINC').AsString, []) Then
                  Begin
                    cdsVendaAux.Edit;
                    cdsVendaAux.FieldByName('ITE_PROMOC').AsString := 'N';
                    cdsVendaAux.Post;
                  End;

                  frmItensSemPro.cdsDados.Next;
                End;
              Finally
                oleItensVendaPed := cdsVendaAux.Data;
                FreeAndNil(cdsVendaAux);
              End;
            End
            Else
            Begin
              Result := False;
            End;
          End;
        Finally
          pFreeAndNil(frmItensSemPro);
        End;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  Finally
    fatVenda.fltTaxVpr := fltTaxVprAnt;
    FreeAndNil(qryGen);
  End;
End;

function TfrmFatConfOrcamentos.fVerificaSituacaoRegularCliente: Boolean;
var strMsgRetorno: string;
begin
  Result := True;

  if fRetEspecieSelecionada <> 'NF' Then
    Exit;

  If SameText(edtCgcCpf.Text, '2') Then
    Exit;

  If blnJaConsultouSituacaoRegularCliente Then
    Exit;

  Try
    If (blnCliCon) Or (blnCliBal) Then
      Result := TConsultaCadastroFit.VerificaSituacaoRegularConfirmacao(mskCgcCPf.Text, edtUF.Text, strCliIes, strMsgRetorno)
    Else
      Result := TConsultaCadastroFit.VerificaSituacaoRegularConfirmacao(edtCodCli.Text, False, strMsgRetorno);

    If (Not Result) Then
    Begin
      If fEmptyStr(strMsgRetorno) Then
        strMsgRetorno := 'Erro ao realizar consulta da situação regular do cliente.';

      fMensagem('ATENÇÃO!', strMsgRetorno, ['&Ok']);
    End;
  Finally
    blnJaConsultouSituacaoRegularCliente := Result;
  End;
end;

function TfrmFatConfOrcamentos.fVerificaStatusImpressora: Boolean;
begin
  Result := True;
  If (Assigned(VS_objFiscal)) And (Not fCfgSis('USNFCE', varBoolean)) And
     (Not fUsaSat) And (VS_strUsaTef = 'S') And (Not fCfgSis('PAFECF', varBoolean)) And
     (fCfgSis('USACUP', varBoolean)) And (fTemModalidadeTEF) Then
  Begin
    If (VS_objFiscal.fReducaoZPendente) Then
    Begin
      fMensagem('ATENÇÃO', 'Impressora fiscal pendente de Redução Z!', ['&OK']);
      Result := False;
    End
    Else If (VS_objFiscal.fStatusImpressora <> '1') Then
    Begin
      fMensagem('ATENÇÃO', 'Impressora fiscal sem comunicação! Verifique!', ['&OK']);
      Result := False;
    End;
  End;
end;

procedure TfrmFatConfOrcamentos.pInserirItemServico(fatVenda: TFatVenda; strCodIte: String);
  Var
    qryCadIte,
    qryIteGer,
    qryAbfIcm: TUniQuery;
begin

  If (fatVenda.fltTotSer <= 0) And (Not fatVenda.fPossuiBrindeServico()) Then
    Exit;

  If fEmptyStr(strCodIte) Then
    Raise Exception.Create('Item de serviço não configurado.');

  If fEmptyStr(fatVenda.strTabPre) Then
    fatVenda.strTabPre := strTabPrecoFat;

  qryCadIte := fCriaQuery(Nil);
  qryIteGer := fCriaQuery(Nil);
  qryAbfIcm := fCriaQuery(Nil);

  qryCadIte.SQL.Add('SELECT * FROM CADITE WHERE ITE_CODITE = :CODITE');
  qryCadIte.ParamByName('CODITE').AsString := strCodIte;
  qryCadIte.Open;

  qryIteGer.SQL.Add('SELECT * FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP');
  qryIteGer.ParamByName('CODITE').AsString := strCodIte;
  qryIteGer.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryIteGer.Open;

  qryAbfIcm.SQL.Add('SELECT * FROM ABFICM WHERE ABF_CODABF = :CODABF AND ABF_ESTADO = :ESTADO');

  If fCfgSis('TIPABF') = '1' Then
    qryAbfIcm.ParamByName('CODABF').AsString := qryCadIte.FieldByName('ITE_CODABF').AsString
  Else
    qryAbfIcm.ParamByName('CODABF').AsString := qryIteGer.FieldByName('ITE_CODABF').AsString;

  qryAbfIcm.ParamByName('ESTADO').AsString := fatVenda.strCliEst;
  qryAbfIcm.Open;

  blnRestaurarMatrizDeItens := True;
  fatVenda.pInserirItemServico(Nil, qryCadIte, qryIteGer, qryAbfIcm);

  FreeAndNil(qryCadIte);
  FreeAndNil(qryIteGer);
  FreeAndNil(qryAbfIcm);

end;

{**************************************}
{* INSERE ITENS QUE FORAM ADICIONADOS *}
{***********************************AF*}
procedure TfrmFatConfOrcamentos.pInserirItensAdicionais(fatVenda: TFatVenda; blnNaoRatearDescontoEmItensNovos: Boolean; cdsNovosItens: TUniClientDataSet=Nil; pgbStatus: TcxProgressBar = nil);
  Var
    recForTin : TForTin;
    recMadeira: TDadosMadeira;
    intProgresso: Integer;
    prcScroll: TprcScroll;
    blnUsaConferenciaItensF11: Boolean;
    blnBaixaSubItemEstrutura : Boolean;
    strTemNumSerie: String;
begin

  If cdsNovosItens = Nil Then
    cdsNovosItens := cdsItensAdd;

  If (Not cdsNovosItens.Active) Or (cdsNovosItens.IsEmpty) Then
    Exit;

  blnUsaConferenciaItensF11 := fCfgSis('ITECFO', varBoolean);

  FillChar(recForTin, SizeOf(TForTin), #0);
  FillChar(recMadeira, SizeOf(recMadeira), #0);

  intProgresso := 0;

  pDisableControls(cdsNovosItens, prcScroll);

  cdsNovosItens.First;

  pInformacao('Aguarde, Adicionando produtos para fechamento da venda...', pgbStatus);

  While Not cdsNovosItens.Eof Do
  Begin
    pProgresso(intProgresso, cdsNovosItens.RecordCount, pgbStatus);

    blnBaixaSubItemEstrutura := (cdsNovosItens.FieldByName('ITE_BXSBIT').AsString = 'S');

    If (blnBaixaSubItemEstrutura) And (fCfgSis('BXSBIT') = '3') Then
    Begin
      If (fRetornaSaldoDisponivel(cdsNovosItens.FieldByName('ITE_CODITE').AsString, True) >= cdsNovosItens.FieldByName('ITE_QTDITE').AsFloat) Then
        blnBaixaSubItemEstrutura := False;
    End;

    fatVenda.strComPro := cdsNovosItens.FieldByName('ITE_COMPRO').AsString;
    fatVenda.strCodPro := cdsNovosItens.FieldByName('ITE_CODPRO').AsString;

    If cdsNovosItens.FieldByName('ITE_ITEPED').AsString <> 'S' Then
    Begin
      strTemNumSerie := 'N';

      If fCfgSis('NSERQT', varBoolean) Then
      Begin
        fatVenda.objFatSerieItem.AutoincItem := IntToStr(cdsNovosItens.FieldByName('ITE_AUTINC').AsInteger);
        fatVenda.objFatSerieItem.pFiltraDataSet;

        strTemNumSerie := IIF(fatVenda.objFatSerieItem.cdsFatSeries.RecordCount > 0, 'S', 'N');
      End;

      fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
                                           Nil,
                                          'NOR',
                                          cdsNovosItens.FieldByName('ITE_CODGRU').AsString,
                                          cdsNovosItens.FieldByName('ITE_CODITE').AsString,
                                          cdsNovosItens.FieldByName('ITE_DESITE').AsString,
                                          cdsNovosItens.FieldByName('ITE_DESITE').AsString,
                                          '',
                                          cdsNovosItens.FieldByName('ITE_CODUNI').AsString,
                                          cdsNovosItens.FieldByName('ITE_CODUNI').AsString,
                                          cdsNovosItens.FieldByName('ITE_CODMAR').AsString,
                                          cdsNovosItens.FieldByName('ITE_CODFOR').AsString,
                                          cdsNovosItens.FieldByName('ITE_REFERE').AsString,
                                          cdsNovosItens.FieldByName('ITE_UNIORI').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_UNIVIS').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_UNITAR').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_UNIORI').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_DESCON').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_QTDITE').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_UNITAR').AsFloat *
                                          cdsNovosItens.FieldByName('ITE_QTDITE').AsFloat,
                                          'S',
                                          cdsNovosItens.FieldByName('ITE_PRECUS').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_TOTCUS').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_COMLUB').AsString,
                                          cdsNovosItens.FieldByName('ITE_IPISAI').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_DESMAX').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_PREVE1').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_PREVE2').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_PREVE3').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_PREVE4').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_PREVE5').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_PREVE6').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_PREVE7').AsFloat,
                                          0.0,
                                          0.0,
                                          cdsNovosItens.FieldByName('ITE_INCPIS').AsString,
                                          cdsNovosItens.FieldByName('ITE_COMVAR').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_COMATA').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_COMDIS').AsFloat,
                                          '',
                                          '',
                                          '',
                                          0.0,
                                          0.0,
                                          '',
                                          cdsNovosItens.FieldByName('ITE_PREULT').AsFloat * cdsNovosItens.FieldByName('ITE_QTDITE').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_IMPULT').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_PREULT').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_PREMED').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_CLAIPI').AsString,
                                          '',
                                          '',
                                          '',
                                          '',
                                          0,
                                          '',
                                          0,
                                          0,
                                          0,
                                          0,
                                          0,
                                          'N',
                                          '',
                                          0.0,
                                          0.0,
                                          cdsNovosItens.FieldByName('ABF_CODABF').AsString,
                                          cdsNovosItens.FieldByName('ITE_PESOIT').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_PESLIQ').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_PROMOC').AsString,
                                          cdsNovosItens.FieldByName('ITE_PROCUS').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_PROVEN').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_PROCVA').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_DESF07').AsFloat,
                                          '',
                                          fatVenda.fRetPerComGrupo(cdsNovosItens.FieldByName('ITE_CODGRU').AsString),
                                          '',
                                          -1,
                                          0.0,
                                          fatVenda.strNumOrc,
                                          fatVenda.strEspOrc, //VERIFICAR SE ESTES ITENS VÃO GRAVAR O PEDIDO ORIGINAL
                                          fatVenda.strEmpOri,
                                          cdsNovosItens.FieldByName('ITE_MARMIN').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_MARMSG').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_MARMGE').AsFloat,
                                          '',
                                          '',
                                          0.0,
                                          0.0,
                                          '',
                                          '',
                                          '',
                                          0.0,
                                          '',
                                          '',
                                          '',
                                          0.0,
                                          cdsNovosItens.FieldByName('ITE_UNIORI').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_QTPPRO').AsFloat,
                                          '',
                                          '',
                                          cdsNovosItens.FieldByName('ITE_OBRCPF').AsString,
                                          '',
                                          '',
                                          '',
                                          0,
                                          fatVenda.fOrdemItem(cdsVenda,'Adiciona',Nil),
                                          '',
                                          '',
                                          '',
                                          False,
                                          '',
                                          '',
                                          '',
                                          cdsNovosItens.FieldByName('ITE_OUTVAL').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_COMTB' + cdsNovosItens.FieldByName('ITE_TABPRE').AsString).AsFloat,
                                          cdsNovosItens.FieldByName('ITE_DESOPE').AsFloat, //fltDesOpe
                                          cdsNovosItens.FieldByName('ITE_ICMSAI').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_IMPFED').AsFloat, //fltImpFed
                                          cdsNovosItens.FieldByName('ITE_DESMGE').AsFloat,
                                          '',
                                          '',
                                          '',
                                          cdsNovosItens.FieldByName('ITE_TABPRE').AsString,
                                          cdsNovosItens.FieldByName('ITE_IPIENT').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_FREENT').AsFloat,
                                          '',
                                          0,
                                          '',
                                          0,
                                          cdsNovosItens.FieldByName('ITE_ENTRET').AsString,
                                          cdsNovosItens.FieldByName('ITE_LOCRET').AsString,
                                          'N',
                                          '',
                                          0,
                                          0,
                                          0,
                                          0,
                                          cdsNovosItens.FieldByName('ITE_IMPDIR').AsString,
                                          '',
                                          cdsNovosItens.FieldByName('ITE_PRECUS').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_TOTCUS').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_PROCAT').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_PROCDI').AsFloat,
                                          0,
                                          0,
                                          0,
                                          0,
                                          recForTin,
                                          '',
                                          '',
                                          cdsNovosItens.FieldByName('ITE_NUMLOT').AsString, {numlot}
                                          '',
                                          '',
                                          blnBaixaSubItemEstrutura,
                                          'N',
                                          'NOR',
                                          0,
                                          '',
                                          cdsNovosItens.FieldByName('ITE_CODBAR').AsString,
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
                                          cdsNovosItens.FieldByName('ITE_PRECUS').AsFloat,
                                          '',
                                          '',
                                          recMadeira,
                                          cdsNovosItens.FieldByName('ITE_IMPULT').AsFloat * cdsNovosItens.FieldByName('ITE_QTDITE').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_VAL_RT').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_TAXJUR').AsFloat,
                                          '',
                                          cdsNovosItens.FieldByName('ITE_QTDITE').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_BAREMB').AsString,
                                          '',
                                          0,
                                          0,
                                          '',
                                          '',
                                          0,
                                          cdsNovosItens.FieldByName('ITE_CODVEN').AsString,
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
                                          cdsNovosItens.FieldByName('ITE_E_X___').AsString,
                                          cdsNovosItens.FieldByName('ITE_DESMSU').AsFloat,
                                          '',
                                          '',
                                          '',
                                          IIF(blnNaoRatearDescontoEmItensNovos, 'N', 'S'), //CONSIDERAR ITEM NO RATEIO DE DESCONTO?
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
                                          cdsNovosItens.FieldByName('ITE_SEQEST').AsInteger,
                                          cdsNovosItens.FieldByName('ITE_ITEEST').AsString,
                                          cdsNovosItens.FieldByName('ITE_UNIEST').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_QTDSBI').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_UNISBI').AsFloat,
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
                                          cdsNovosItens.FieldByName('ITE_COMDIG').AsFloat,
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
                                          strTemNumSerie,
                                          '',
                                          '',
                                          '',
                                          '',
                                          cdsNovosItens.FieldByName('ITE_CHKOUT').AsString,
                                          cdsNovosItens.FieldByName('ITE_DESMVM').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_DESMSM').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_DESMGM').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_MARMMV').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_MARMMS').AsFloat,
                                          cdsNovosItens.FieldByName('ITE_MARMMG').AsFloat);
    End
    Else
    Begin
      If (Not blnUsaConferenciaItensF11) And (fCfgSis('TIPEXP', varString) <> '2') Then
      Begin
        If cdsVenda.Locate('ITE_SEQDET', cdsNovosItens.FieldByName('ITE_SEQDET').AsString, []) Then
        Begin
          cdsVenda.Edit;
          cdsVenda.FieldByName('ITE_QTDEXP').AsFloat := cdsNovosItens.FieldByName('ITE_QTDEXP').AsFloat;
          cdsVenda.Post;
        End;
      End;
    End;

    cdsNovosItens.Next;
  End;

  pAdicionaItensChkOutTemp(cdsNovosItens);

  cdsNovosItens.First;
  pEnableControls(cdsNovosItens, prcScroll);
end;

procedure TfrmFatConfOrcamentos.FormShow(Sender: TObject);
begin
  inherited;
  blnMudouCodCli := False;
  blnJaValidouDocs := False;

  pLimparTela;
  pTrataWMS;

  If blnTravaFaturamentoF11 Then
  Begin
    rdbEmissaoFaturamento.Enabled := False;
    rdbAdiantamentoPedido.Checked := True;
  End;

  edtDesPag.Width := IIF(fCfgSis('SOLCAR', varBoolean) And fCfgSis('TEFREC', varBoolean),393,563);
  edtNumParcelas.Visible := fCfgSis('SOLCAR', varBoolean) And fCfgSis('TEFREC', varBoolean);
  lblNumParcelas.Visible := fCfgSis('SOLCAR', varBoolean) And fCfgSis('TEFREC', varBoolean);

  if (strEspCfo = 'PD') And fCfgSis('COMAND', VarBoolean) then
    pSetFocus(edtBarCom)
  else
    pSetFocus(edtNumOrc);

  blnVaiResgatarQuest := False;
  blnUsandoQuestFidelidade := False;

  FPermiteUsarPix := False;
  If fCfgSis('BAVF11', varBoolean) Then
    FPermiteUsarPix := TFuncoesPixAutcom.RealizaValidacoesUsoDoPixNoCaixa(strCodOpe,
                                                                          FAutoIncremChavePix);

  FDadosRetornoPix := '';
  FDadosRequisicaoPix := '';
  FObjetoRecebimentoPix := Nil;
  FblnTxIdPixRemovida := False;

  pHabilitaOpcoesRealizar;
end;

procedure TfrmFatConfOrcamentos.FormPaint(Sender: TObject);
begin
  inherited;
  If blnFecharForm Then
    Close;
end;

Function TfrmFatConfOrcamentos.fVerificaLimiteCredito(strCndPag: String;
  fatVenda: TFatVenda; fltTotGer: Double; strCfgLim: String):Boolean;
  Var
    fltTotDis : Double;
    fltSldNes : Double;
    strLimIsn : String;
    strSenLim : String;
    strSenLi2 : String;
    fltLimCre : Double;
    fltDebtos : Double;
    blnPFLCLI : Boolean;
    blnNivel2 : Boolean;
    strUltimaAlteracaoCreditoCliente : String;

    LMensagemLiberacao : TMensagemLiberacao;

    function fDebitoCliente(strCndPgt: String): Double;
      Var
        strSQL   : String;
        qryGenTmp: TUniQuery;
    begin
      qryGenTmp := fCriaQuery(Nil);
      Try
        Result := 0.0;

        {*********************************************}
        {* CONFIGURAÇÃO PARA LIBERAR CLIENTE COMPRAR *}
        {* A VISTA EM DINHEIRO OU CARTÃO MESMO COM   *}
        {* DEBITOS                                   *}
        {******************************************AF*}
        If (fCfgSis('LIBAVI', varBoolean)) Then
        Begin

          If (fStatusCndPag(strCndPgt) = A_VISTA) Then
            Exit;

        End;

        {*****************************************}
        {* SE ENTRA PEDIDOS EM ABERTO NO LIMITE  *}
        {**************************************PZ*}
        If fCfgSis('PDVLIM', varBoolean) Then
          Result := Result + fRetTotalPedidoVendaAberto(fatVenda.strCodCli, fatVenda.strNumOrc);

        {*********************************************}
        {* SE ENTRA EMPRÉSTIMOS EM ABERTO NO LIMITE  *}
        {*******************************************BL}
        If fCfgSis('LMCEMP', varBoolean) Then
          Result  := Result  + fRetTotalEmprestimosAberto(fatVenda.strCodCli);

        {*****************************************}
        {* DEBITOS CHEQUE PRE                    *}
        {**************************************AF*}
        If fCfgSis('CHQCCO', varBoolean) Then
        Begin

          strSQL := '';
          strSQL := strSQL + 'SELECT ';
          strSQL := strSQL + '  * ';
          strSQL := strSQL + 'FROM ';
          strSQL := strSQL + '  CADCHQ ';
          strSQL := strSQL + 'INNER JOIN CADCLI ';
          strSQL := strSQL + '  ON CLI_CODCLI = CHQ_CODCLI ';
          strSQL := strSQL + 'WHERE ( ';
          strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';
          If fCfgSis('TRFTCR', varString) = '2' Then
          Begin
            strSQL := strSQL + '    OR CLI_CODRED =              ';
            strSQL := strSQL + '    (SELECT                      ';
            strSQL := strSQL + '       CLI_CODRED                ';
            strSQL := strSQL + '     FROM                        ';
            strSQL := strSQL + '       CADCLI                    ';
            strSQL := strSQL + '     WHERE CLI_CODCLI = :CODCLI) ';
          End;
          strSQL := strSQL + ') AND ((CHQ_DTADEP IS NULL) OR ((CHQ_DTADP2 IS NULL) AND (CHQ_DTADEV IS NOT NULL))) ';
          strSQL := strSQL + '  AND CHQ_INCCTR = "N" ';

          With qryGenTmp Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('CODCLI').AsString := edtCodCli.Text;
            Open;

            While Not Eof Do
            Begin
              Result := Result + FieldByName('CHQ_VALCHQ').AsFloat;
              Next;
            End;

            Close;
          End;

        End;

        {*****************************************}
        {* DEBITOS CONTAS A REC.                 *}
        {**************************************AF*}
        strSQL := '';
        strSQL := strSQL + 'SELECT ';
        strSQL := strSQL + '  * ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  CADREC ';
        strSQL := strSQL + 'INNER JOIN CADCLI ';
        strSQL := strSQL + '  ON CLI_CODCLI = CTR_CODCLI ';
        strSQL := strSQL + 'WHERE ( ';
        strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';
        If fCfgSis('TRFTCR', varString) = '2' Then
        Begin
          strSQL := strSQL + '    OR CLI_CODRED =              ';
          strSQL := strSQL + '    (SELECT                      ';
          strSQL := strSQL + '       CLI_CODRED                ';
          strSQL := strSQL + '     FROM                        ';
          strSQL := strSQL + '       CADCLI                    ';
          strSQL := strSQL + '     WHERE CLI_CODCLI = :CODCLI) ';
        End;
        strSQL := strSQL + ') AND CTR_DTAREC IS NULL ';

        With qryGenTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODCLI').AsString := edtCodCli.Text;
          Open;

          While Not Eof Do
          Begin
            Result := Result + FieldByName('CTR_VALDUP').AsFloat;
            Next;
          End;

          Close;
        End;
      Finally
        FreeAndNil(qryGenTmp);
      End;
    end;

Begin
  Result := True;

  If (fEmptyStr(strCndPag)) Then
    Exit;

  If blnCliFil Or blnCliCon Then
    Exit;



  {**********************************}
  {* MONTA O LIMITE DE CREDITO      *}
  {*******************************AF*}
  fltDebtos := fDebitoCliente(strCndPag);
  fltLimCre := fLimiteCreditoCliente(edtCodCli.Text);
  fltTotDis := fltLimCre - fltDebtos;

  If (fltTotGer > fltTotDis) And
     ((fStatusCndPag(strCndPag) = A_PRAZO) Or fatVenda.fUsaPerfilECadCnd) Then
  Begin

    blnPFLCLI := fCfgSis('PFLCLI', varBoolean);

    If fEmptyStr(strDigCodCnd) Then
      strDigCodCnd := fatVenda.strCodCnd;

    If blnPFLCLI then
    begin
      If (Not fatVenda.fCondicaoPagtoClienteOk(strDigCodCnd)) then
      Begin
        Result := False;
        Exit;
      End;
    end;

    If (blnPFLCLI And fatVenda.fCondicaoPagamentoValidaLimiteCredito) Or
       ((Pos(fCfgSis(strCfgLim), 'T_A_') > 0) And (Not blnPFLCLI))    Then
    Begin
      fltSldNes := fltTotDis - fltTotGer;
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('A T E N Ç Ã O - Valor Total Maior Que o Limite de Crédito.');

      strUltimaAlteracaoCreditoCliente := fDataUltimaAlteracaoCreditoCliente(edtCodCli.Text);
      if (not fEmptyStr(strUltimaAlteracaoCreditoCliente)) then
        objLiberacao.objMsgLibera.pAddTextoCaption('Data Última Alteração', strUltimaAlteracaoCreditoCliente, 25, alDireita, teAmbos, '', 10);

      objLiberacao.objMsgLibera.pAddTextoCaption('Limite de Crédito'  , FormatFloat('#,##0.00', fltLimCre)  , 25);
      objLiberacao.objMsgLibera.pAddTextoCaption('Débitos Pendentes'  , FormatFloat('#,##0.00', fltDebtos)  , 25);
      objLiberacao.objMsgLibera.pAddTextoCaption('Disponível'         , FormatFloat('#,##0.00', fltTotDis)  , 25);

      If fCfgSis(strCfgLim) <> 'A' Then
      Begin
        objLiberacao.objMsgLibera.pAddTextoCaption('Valor desta Venda', FormatFloat('#,##0.00', fltTotGer) , 25);
        objLiberacao.objMsgLibera.pAddTextoCaption('Diferença'        , FormatFloat('#,##0.00', fltSldNes) , 25);
      End;

      If fCfgSis('USACND', varBoolean) Then
        objLiberacao.objMsgLibera.pAddTextoCaption('Condição Pagto'   , fatVenda.strCodCnd + '-' + fatVenda.strDesCnd + ' '+ fFormataCondPag(fatVenda.strConPag), 25)
      Else
        objLiberacao.objMsgLibera.pAddTextoCaption('Condição Pagto'   , fFormataCondPag(fatVenda.strConPag)                                                     , 25);

      If fCfgSis('USAFPG', varBoolean) Then
        objLiberacao.objMsgLibera.pAddTextoCaption('Forma de Pagto'   , fatVenda.strCodFpg + '-' + fatVenda.strDesFpg                                           , 25);

      strLimIsn := fCfgSis(strCfgLim);
      strSenLim := fCfgSis('SENLIM');
      strSenLi2 := fCfgSis('SENLI2');

      {***********************************}
      {* SE NÃO É PARA AVISAR NEM TRAVAR *}
      {********************************AL*}
      If strLimIsn = 'N' Then
      Begin
        Exit;
      End;

      blnNivel2 := fltTotGer > fStrToFloat(fCfgSis('VLRLCR',varDouble));

      objLiberacao.strDirAce := 'LIMCR';
      objLiberacao.blnTraTel := (strLimIsn = 'T');
      objLiberacao.strSenLib := strSenLim;
      objLiberacao.strMsgSen := 'Limite de Crédito';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;
      objLiberacao.strDirAceNv2 := 'LIMCR2';
      objLiberacao.strSenLibNv2 := strSenLi2;
      objLiberacao.blnNivel2 := blnNivel2;
      objLiberacao.strCliente := (edtCodCli.Text + '-' + edtNomCli.Text);
      objLiberacao.strCpfCnpj := mskCgcCpf.Text;

      if fCfgSis('INTRCC', varInteger) = 1 then
        LMensagemLiberacao := objLiberacao.objMsgLibera
      else
        LMensagemLiberacao := objLiberacao.objMsgRemota;

      If Assigned(fatVenda) And (cdsVenda <> nil) Then
        fatVenda.pMontaMensagem(cdsVenda, LMensagemLiberacao);

      Result := objLiberacao.fLibera;
    End;

  End;

End;

procedure TfrmFatConfOrcamentos.pAcertaClienteCheque(cdsChq: TUniClientDataSet);
begin
  If (Assigned(cdsChq)) And (cdsChq.RecordCount > 0) Then
  With cdsChq Do
  Begin
    First;
    While Not Eof Do
    Begin
      Edit;
      FieldByName('CHQ_CODCLI').AsString := edtCodCli.Text;
      Post;
      Next;
    End;
    First;
  End;
end;

procedure TfrmFatConfOrcamentos.pAcertaDadosCondicaoPagamento(fatVenda: TFatVenda);
  Var
    qryAux: TUniQuery;
begin
  If (fEmptyStr(fatVenda.strCodCnd)) Then
    Exit;

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT * FROM CADCND WHERE CND_CODIGO = :CODCND');
  qryAux.ParamByName('CODCND').AsString := fatVenda.strCodCnd;
  qryAux.Open;

  fatVenda.strDesCnd := qryAux.FieldByName('CND_DESCRI').AsString;

  fatVenda.fltDMVCnd := qryAux.FieldByName('CND_DESMAX').AsFloat;
  fatVenda.fltDVMCnd := qryAux.FieldByName('CND_DESMVM').AsFloat;

  fatVenda.fltDMGCnd := qryAux.FieldByName('CND_DESMGE').AsFloat;
  fatVenda.fltDGMCnd := qryAux.FieldByName('CND_DESMGM').AsFloat;

  fatVenda.fltDMSCnd := qryAux.FieldByName('CND_DESMSU').AsFloat;
  fatVenda.fltDSMCnd := qryAux.FieldByName('CND_DESMSM').AsFloat;

  fatVenda.fltTxJCnd := qryAux.FieldByName('CND_TXJURO').AsFloat;
  fatVenda.strCAbDes := qryAux.FieldByName('CND_ABADES').AsString;
  fatVenda.strTipFor := qryAux.FieldByName('CND_TIPFOR').AsString;
  fatVenda.strAbDeCc := qryAux.FieldByName('CND_ABDECC').AsString;
  fatVenda.strJurPro := qryAux.FieldByName('CND_JURPRO').AsString;
  fatVenda.strCndTbP := qryAux.FieldByName('CND_TABPRE').AsString;
  fatVenda.strCndTpm := qryAux.FieldByName('CND_PRETAB').AsString;

  FreeAndNil(qryAux);
end;

procedure TfrmFatConfOrcamentos.spnTipFatDownClick(Sender: TObject);
  var
    Key: Word;
begin
  inherited;
  Key := VK_DOWN;

  If spnTipFat.Enabled Then
    pKeyDownTipFat(Key, []);

end;

procedure TfrmFatConfOrcamentos.spnTipFatUpClick(Sender: TObject);
  var
    Key: Word;
begin
  inherited;
  Key := VK_UP;

  If spnTipFat.Enabled Then
    pKeyDownTipFat(Key, []);

end;

procedure TfrmFatConfOrcamentos.tmrReloadTimer(Sender: TObject);
begin
  inherited;
  tmrReload.Enabled := False;
  btnAdicionarItensClick(btnAdicionarItens);
end;

function TfrmFatConfOrcamentos.TravarRegistroDoPix(ATravar: Boolean): Boolean;
begin
  If Not Assigned(qryFatGor) Then
    Exit(True);

  If qryFatGor.IsEmpty Then
    Exit(True);

  If qryFatGor.FieldByName('FGO_TX_PIX').AsString.IsEmpty Then
    Exit(True);

  Result := fLock_Unlock('CONSULTA_RECEBIMENTO_PIX_' +
                         qryFatGor.FieldByName('FGO_TX_PIX').AsString,
                         ATravar,
                         False,
                         False,
                         '',
                         False);
end;

function TfrmFatConfOrcamentos.ValidaCondicaoPixOuValorDoPixGeradoPeloPedido: Boolean;
  Var
    LMensagem: String;
begin
  Result := True;

  FCondicaoPagamentoPixComCobrancaAnteriorExpirada := False;

  If Not fCfgSis('USAPIX', varBoolean) Then
    Exit;

  If strEspCfo <> 'PD' Then
    Exit;

  If Not Assigned(fatVenda) Then
    Exit;

  If fatVenda.DadosPixDaVenda.TxIdPix.IsEmpty Then
  Begin
    If qryFatGor.IsEmpty Then
      Exit;

    If fCampoTabela('CND_RECPIX', 'CADCND', ['CND_CODIGO'], [qryFatGor.FieldByName('FGO_CODCND').AsString]) <> 'S' Then
      Exit;
  End;

  If fatVenda.DadosPixDaVenda.RecebidoPorPix = 'S' Then
    Exit;

  If Not FPermiteUsarPix Then
  Begin
    If fCfgSis('F11ORD') <> 'O' Then
    Begin
      LMensagem := 'Não será permitido realizar o recebimento por Pix. Realizar as seguintes verificações: ' + sLineBreak;
      LMensagem := LMensagem + sLineBreak + '1- Arquivo "libIntegracaoPixCitel.dll" se encontra na pasta do AUTCOM';
      LMensagem := LMensagem + sLineBreak + '2- Todos os dados da chave pix foram preenchidos no cadastro: > Principal > Manutenção de Cadastros > Auxiliares > Contas Bancárias';
      LMensagem := LMensagem + sLineBreak + '3- O operador do caixa possui direito de acesso: "Permitir realizar recebimento por Pix no Resumo de Caixa/F11"';
      fMensagem('ATENÇÃO', LMensagem, ['&Ok'], 1, False, 1, 0, False, 0, False, False, False, 0, 0, 3);
    End
    Else
    Begin
      LMensagem := 'Não é permitido realizar o recebimento por meio do QRCode Pix na Confirmação de Orçamentos.' + #13 +
                   'Altere a condição de pagamento do Pedido para continuar.';
      fMensagem('ATENÇÃO', LMensagem, ['&Ok']);
    End;
    Exit(False);
  End;

  If Pos('/PIX', cbxModalidades.Text) = 0 Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário realizar o recebimento por Pix para esse pedido.', ['&Ok']);
    Exit(False);
  End;

end;

function TfrmFatConfOrcamentos.ValidarAberturaDoPedidoComPix: Boolean;
  Var
    LListaDePedidos: String;
    LAutoIncremChavePix: String;
    LCondicaoPagamentoPix: Boolean;
begin
  Result := True;

  If Not fCfgSis('USAPIX', varBoolean) Then
    Exit;

  If strEspCfo <> 'PD' Then
    Exit;

  If qryFatGor.FieldByName('FGO_JAFATU').AsInteger = 1 Then
    Exit;

  LCondicaoPagamentoPix := fCampoTabela('CND_RECPIX', 'CADCND', ['CND_CODIGO'], [qryFatGor.FieldByName('FGO_CODCND').AsString]) = 'S';

  If fTxPixVazia Then
  Begin
    If qryFatGor.IsEmpty Then
      Exit;

    If Not LCondicaoPagamentoPix Then
      Exit;

    If fFormataFloat(fltValAdt, 2) <> 0 Then
      Exit;

    If Not fCfgSis('BAVF11', varBoolean) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é possível carregar um pedido com condição de pagamento Pix '+
                            'quando a configuração CFG_BAVF11 for igual a Não.' + #13 +
                            'A condição de pagamento do pedido deve ser alterada antes de faturar!', ['&Ok']);
      Exit(False);
    End;

    LAutoIncremChavePix := fCfgSis('CHAPIX');
    if TPixDao.ChavePixUtilizaTefScope(LAutoIncremChavePix) = 'S' then
      Exit;

    FCondicaoPagamentoPixComCobrancaAnteriorExpirada := True;

    Result := fMensagem('ATENÇÃO!', 'A condição de pagamento do pedido é utilizada para utilização de pagamentos por Pix!' + #13 +
                                    'O Pix desse pedido foi expirado ou removido pelo usuário.' + #13 +
                                    'Deseja gerar um novo Pix para o pedido selecionado?', ['&Sim', '&Não'], 2) = 1;

    If Not Result Then
      fMensagem('ATENÇÃO!', 'A condição de pagamento do pedido deve ser alterada antes de faturar!', ['&Ok']);
  End
  Else
  Begin
    If MatchStr(TPixDao.RetornaStatusSePedidoPossuirPix(qryFatGor.FieldByName('FGO_EMPPIX').AsString,
                                                        qryFatGor.FieldByName('FGO_TX_PIX').AsString), STATUS_PIX_PAGO) Then
      Exit(Not TAdiantamento.AdiantamentoRealizadoPorPixDeFormaParcial(qryFatGor));

    If TPixDao.PixGeradoEmPedidosDesmembrados(qryFatGor.FieldByName('FGO_EMPPIX').AsString,
                                              qryFatGor.FieldByName('FGO_TX_PIX').AsString,
                                              LListaDePedidos) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse pedido foi desmembrado e o Pix está vinculado aos pedidos: ' +
                            LListaDePedidos + #13 +
                            'Antes de faturar esse pedido, deve ser realizado o pagamento do Pix através ' +
                            'da tela de Adiantamento ou deve remover o registro Pix do pedido.', ['&Ok']);
      Exit(False);
    End;

    If qryFatGor.FieldByName('FGO_EMPPIX').AsString <> VS_strCodEmp Then
    Begin
      fMensagem('ATENÇÃO', 'Esse pedido possui um Pix gerado pela empresa ' +
                           qryFatGor.FieldByName('FGO_EMPPIX').AsString + '.' + #13 +
                           'Portanto deve ser realizado o faturamento na empresa geradora do Pix.', ['&Ok']);

      Exit(False);
    End;

    If Not fCfgSis('BAVF11', varBoolean) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é possível carregar um pedido com Pix gerado '+
                            'quando a configuração CFG_BAVF11 for igual a Não.' + #13 +
                            'A condição de pagamento do pedido deve ser alterada antes de faturar!', ['&Ok']);
      Exit(False);
    End;

    If LCondicaoPagamentoPix Then
    Begin
      If fFormataFloat(fStrToFloat(edtTotGer.Text), 2) >
         TPixDao.RetornaValorDoPixMOVPIX(qryFatGor.FieldByName('FGO_EMPPIX').AsString,
                                         qryFatGor.FieldByName('FGO_TX_PIX').AsString) Then
      Begin
        fMensagem('ATENÇÃO', 'O valor do Pix gerado é menor que o valor do pedido.' + #13 +
                             'Remova o Pix do Pedido e gere a cobrança novamente, para continuar com o recebimento.', ['&Ok']);
        Exit(False);
      End;
    End;

    If Not TravarRegistroDoPix(True) Then
    Begin
      fMensagem('ATENÇÃO', 'O Pix desse pedido está sendo utilizado em Outra Estação por ' +
                           fGetHostLock('CONSULTA_RECEBIMENTO_PIX_' + qryFatGor.FieldByName('FGO_TX_PIX').AsString) + '!', ['&Ok']);
      Result := False;
    End;
  End;
end;

function TfrmFatConfOrcamentos.ValidarSeExistePixRecebidoSemConfirmacao(AExclusao: Boolean): Boolean;
  Var
    LPedido: String;
begin
  Result := True;

  If Not FPermiteUsarPix Then
    Exit;

  If AExclusao Then
  Begin
    If cdsModalidades.FieldByName('CODFPG').AsString <> '012' Then
      Exit;
  End;

  If Not Assigned(FObjetoRecebimentoPix) Then
    Exit;

  If TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(FObjetoRecebimentoPix) Then
  Begin
    If fMensagem('ATENÇÃO', 'O recebimento em andamento possui um Pix que já foi recebido.' + #13 +
                            'Se continuar, o sistema não gravará o registro do pagamento desse Pix.' + #13 +
                            'Deseja realmente continuar?', ['&Sim', '&Não'], 2) = 2 Then
      Exit(False);

    LPedido := fatVenda.strNumDoc + '-' +
               fatVenda.strEspDoc + '-' +
               fatVenda.strEmpDoc;
    If fatVenda.strNumDoc.IsEmpty Then
      LPedido := edtNumOrc.Text + '-' +
                 'PD-' +
                 fatVenda.strEmpDoc;

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Permitir cancelar recebimento do Resumo de Caixa/F11 com um Pix já recebido');
    objLiberacao.objMsgLibera.pAddTexto('');
    objLiberacao.objMsgLibera.pAddTexto('Pedido: ' + LPedido);
    objLiberacao.objMsgLibera.pAddTexto('Valor do Pix: ' + FormatFloat(',0.00', fRetonaValorPixPago));

    objLiberacao.strDirAce := 'PERCANCRCXPIXREC';
    objLiberacao.strMsgSen := 'Permitir cancelar recebimento do Resumo de Caixa/F11 com um Pix já recebido';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := strCodOpe;
    objLiberacao.strCodDig := strCodOpe;

    Result := objLiberacao.fLibera;

    If Result Then
    Begin
      fatVenda.DadosPixDaVenda.RecebidoPorPix := 'N';
      fatVenda.DadosPixDaVenda.ObjetoPixPago := Nil;
      fatVenda.DadosPixDaVenda.LstPixPago.Clear ;
      FObjetoRecebimentoPix := Nil;
      FDadosRetornoPix := '';
      FDadosRequisicaoPix := '';
      FblnTxIdPixRemovida := False;

      If FCondicaoPagamentoPixComCobrancaAnteriorExpirada Then
        fatVenda.DadosPixDaVenda.GerarPixDaVenda := True;
    End;
  End;
end;

procedure TfrmFatConfOrcamentos.pSetaOpcoesFaturamento(blnEhConcreto : Boolean = False);
  Var
    intIndice: Integer;

  function fPermiteEspecie(strEsp: String): Boolean;
  begin
    If Not fPermiteEmissaoEspecie(strEsp) Then
      Result := False
    Else
    Begin
      If (fCfgSis('PEMIFF') = '1') And                   //PERMISSAO GERAL
         (Not fCfgSis('PERM' + strEsp, varBoolean)) Then //NAO PERMITE
      Begin
        Result := False;
      End
      Else
        Result := True;
    End;
  end;

begin
  intIndice := -1;
  SetLength(arrOpcoes, 0);

  Inc(intIndice);
  SetLength(arrOpcoes, Succ(intIndice));

  arrOpcoes[intIndice].strDesCri := 'Nota Fiscal';
  arrOpcoes[intIndice].strEspDoc := 'NF';
  arrOpcoes[intIndice].strOpcLet := 'N';
  arrOpcoes[intIndice].strMosMen := 'S';

  //Se TIPPOPE = (A) Amostra só permite Nota Fiscal.
  if (strTipOpe = 'A') then
    Exit;

  If ((fCfgSis('USACUP', varBoolean)) Or (fCfgSis('USNFCE', varBoolean)) Or fUsaSat ) And
     (Not fCfgSis('PAFECF', varBoolean)) And
     (Not blnEhConcreto) Then
  Begin
    Inc(intIndice);
    SetLength(arrOpcoes, Succ(intIndice));

    arrOpcoes[intIndice].strDesCri := fDescricaoIF;
    arrOpcoes[intIndice].strEspDoc := 'IF';
    arrOpcoes[intIndice].strOpcLet := 'C';
    arrOpcoes[intIndice].strMosMen := 'S';
  End;

  If fPermiteEspecie('FF') And (Not blnEhConcreto) Then
  Begin
    Inc(intIndice);
    SetLength(arrOpcoes, Succ(intIndice));

    arrOpcoes[intIndice].strDesCri := 'Faturamento Futuro';
    arrOpcoes[intIndice].strEspDoc := 'FF';
    arrOpcoes[intIndice].strOpcLet := 'F';
    arrOpcoes[intIndice].strMosMen := 'N';
  End;

  If (fCfgSis('NPDF11', VarBoolean) Or
      fCfgSis('NPRF11', VarBoolean) Or
      fCfgSis('LOCRET', VarBoolean) Or
      fCfgSis('ENT_CD', VarBoolean) Or
      blnRealizandoAdiantamentoPedidoPeloF11) And (Not blnEhConcreto) Then
  Begin
    Inc(intIndice);
    SetLength(arrOpcoes, Succ(intIndice));

    arrOpcoes[intIndice].strDesCri := 'Pedido';
    arrOpcoes[intIndice].strEspDoc := 'PD';
    arrOpcoes[intIndice].strOpcLet := #0;
    arrOpcoes[intIndice].strMosMen := 'N';
  End;

end;

procedure TfrmFatConfOrcamentos.pSetarItensExpedidosMatrizItens(var Itens: TMatrizFechamento);
  Var
    intCnt : Integer;
    cdsLocalCfo : TUniClientDataSet;
    fltQtdExp : Double;
begin
  If Not Assigned(cdsIteCfo) Then
    Exit;

  If (cdsIteCfo.IsEmpty) Then
    Exit;

  cdsLocalCfo := TUniClientDataSet.Create(Nil);
  pCloneDataSet(cdsLocalCfo, cdsIteCfo);

  cdsLocalCfo.First;
  While Not cdsLocalCfo.Eof Do
  Begin

    If (cdsLocalCfo.FieldByName('QTDLIB').AsFloat <= 0) Then
    Begin
      cdsLocalCfo.Delete;
      Continue;
    End;

    cdsLocalCfo.Next;
  End;

  cdsLocalCfo.IndexFieldNames := 'IDEPRO;CODITE;DESCRI;NUMLOT;ENTRET;LOCRET;ENTFUT;EMPITE';

  For intCnt := Low(Itens) To High(Itens) Do
  Begin
    If (cdsLocalCfo.Locate('IDEPRO;CODITE;DESCRI;NUMLOT;ENTRET;LOCRET;ENTFUT;EMPITE',
                     VarArrayOf([Itens[intCnt].strIdePro, Itens[intCnt].strCodIte,
                                 Itens[intCnt].strDesIte, Itens[intCnt].strNumLot,
                                 Itens[intCnt].strEntRet, Itens[intCnt].strLocRet,
                                 Itens[intCnt].strEntFut, Itens[intCnt].strEmpIte]), [])) Then
    Begin
      If (cdsLocalCfo.FieldByName('QTDLIB').AsFloat > 0) Then
      Begin
        If (Itens[intCnt].fltQtdExp < Itens[intCnt].fltQtdIte) Then
        Begin
          If (Itens[intCnt].fltQtdExp + cdsLocalCfo.FieldByName('QTDLIB').AsFloat) > Itens[intCnt].fltQtdIte Then
          Begin
            fltQtdExp := Itens[intCnt].fltQtdIte;

            cdsLocalCfo.Edit;
            cdsLocalCfo.FieldByName('QTDLIB').AsFloat := cdsLocalCfo.FieldByName('QTDLIB').AsFloat - fltQtdExp;
            cdsLocalCfo.Post;

            Itens[intCnt].fltQtdExp := fltQtdExp;
          End
          Else
          Begin
            fltQtdExp := cdsLocalCfo.FieldByName('QTDLIB').AsFloat;

            cdsLocalCfo.Edit;
            cdsLocalCfo.FieldByName('QTDLIB').AsFloat := 0;
            cdsLocalCfo.Post;
            Itens[intCnt].fltQtdExp := Itens[intCnt].fltQtdExp + fltQtdExp;
          End;
        End;
      End;
    End;
  End;

  FreeAndNil(cdsLocalCfo);
end;

function TfrmFatConfOrcamentos.fUsouExpedicaoServicos: Boolean;
begin
  Result := False;
  If qryFatGor.Active And fCfgSis('AUTCEN', varBoolean) And fCfgSis('USAEXS', varBoolean) Then
    Result := Not fEmptyStr(fCampoTabela('FGO_CODS01','FATGOR', ['AUTOINCREM'],
      [fFatGor('AUTOINCREM').AsString]));
end;

function TfrmFatConfOrcamentos.fUsouModalidadesUtilizacaoCreditoDinheiro: Boolean;
Var
  intRecNo: Integer;
  blnUtiDin: Boolean;
  blnUtiCre: Boolean;
begin
  blnUtiDin := False;
  blnUtiCre := False;

  intRecNo := cdsModalidades.RecNo;
  Try
    cdsModalidades.DisableControls;
    cdsModalidades.First;
    While Not cdsModalidades.Eof Do
    Begin
      If cdsModalidades.FieldByName('CODFPG').AsString = '001' Then
        blnUtiDin := True;

      If cdsModalidades.FieldByName('CODFPG').AsString = '013' Then
        blnUtiCre := True;

      cdsModalidades.Next;
    End;

    Result := (blnUtiDin And blnUtiCre);
  Finally
    cdsModalidades.RecNo := intRecNo;
    cdsModalidades.EnableControls;
  End;
end;

procedure TfrmFatConfOrcamentos.pMarcarTodosItensComoExpedidos(var Itens: TMatrizFechamento);
  Var
    intCnt : Integer;
begin
  For intCnt := Low(Itens) To High(Itens) Do
    Itens[intCnt].fltQtdExp := Itens[intCnt].fltQtdIte;
end;

function TfrmFatConfOrcamentos.fTipoFaturamentoSelec: TOpcoesFaturamento;
  Var
    intIndex: Integer;
begin
  For intIndex := 0 To Length(arrOpcoes) - 1 Do
    If SameText(arrOpcoes[intIndex].strDesCri, edtTipFat.Text) Then
    Begin
      Result := arrOpcoes[intIndex];
      Break;
    End;    
end;

function TfrmFatConfOrcamentos.fTipoPedidoNFe: Boolean;
begin
  result := fatVenda.strTipPed = 'A' ;
end;

function TfrmFatConfOrcamentos.fTravarTrocoUtlCartaoOuCheque(blnCartao : Boolean;fltValor:Double): Boolean;
  Var
   strOpeRcx : String;
begin
  Result := True;
  If Not (fCfgSis('TRORCX', varBoolean)) Then
    Exit;

  strOpeRcx := IIF(fEmptyStr(strCodOpe), strLoginUsuarioLogado, strCodOpe);
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddSeparador(100);
  objLiberacao.objMsgLibera.pAddTexto('LIBERAÇÃO DE RECEBIMENTO COM TROCO DE CHEQUE E/OU CARTÃO');
  objLiberacao.objMsgLibera.pAddSeparador(100);

  objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'            , edtCodCli.Text + ' - ' + fRetNomCliente(edtCodCli.Text)                , 29);
  objLiberacao.objMsgLibera.pAddTextoCaption('Total Duplicadas Recebidas' , FormatFloat('##,#0.00',fStrToFloat(edtTotGer.Text))            ,  29);
  If Not blnCartao Then
    objLiberacao.objMsgLibera.pAddTextoCaption('Total Pago em Cheque', FormatFloat('##,#0.00',fStrToFloat(edtValor.Text))       ,  29)
  Else
    objLiberacao.objMsgLibera.pAddTextoCaption('Total Pago em Cartão'      , FormatFloat('##,#0.00',fStrToFloat(edtValor.Text))  ,  29);
  objLiberacao.objMsgLibera.pAddSeparador(100);
  objLiberacao.objMsgLibera.pAddTextoCaption('Troco:'   , FormatFloat('##,#0.00',fltValor)                                                 ,  29);
  objLiberacao.objMsgLibera.pAddSeparador(100);
    If Not fEmptyStr(edtNumOrc.Text) Then
      objLiberacao.objMsgLibera.pAddTextoCaption('Pedido'                , edtNumOrc.Text + '-' + strEspCfo + '-' + VS_strCodEmp,  29);

    objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor'                , strOpeRcx + '-' + fRetNomeOperador(strOpeRcx)        ,  29);


  objLiberacao.strDirAce := 'DIRRCXTROCO';
  objLiberacao.strMsgSen := 'Liberação de troco utilizando cartão/cheque pelo Caixa';
  objLiberacao.strCodOpe := strOpeRcx;

  Result := objLiberacao.fLibera;
end;

function TfrmFatConfOrcamentos.fTravaUtilizacaoCredito(cdsCredit: TUniClientDataSet): Boolean;
  Var
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
    strOpeRcx : String;
begin
  Result := False;

  //Caso nao valide os cerditos vencidos nao deve permitir utilizacao de creditos
  If Not fValidaCreditosVencidos(cdsCredit) Then
  Begin
    Result := True;
    Exit;
  End;

  strOpeRcx := IIF(fEmptyStr(strCodOpe), strLoginUsuarioLogado, strCodOpe);

  If (Not fVerificaAcessoSistema('RCXCRE', strOpeRcx)) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('UTILIZAÇÃO DE CRÉDITOS NO CAIXA', alCentro, teAmbos, '', 83);
    objLiberacao.objMsgLibera.pAddSeparador(83);
    objLiberacao.objMsgLibera.pAddTexto('DADOS DO DOCUMENTO PARA FATURAR', alCentro, teAmbos, '', 83);
    objLiberacao.objMsgLibera.pAddSeparador(83);

    If Not fEmptyStr(edtNumOrc.Text) Then
      objLiberacao.objMsgLibera.pAddTextoCaption('Pedido'                , edtNumOrc.Text + '-' + strEspCfo + '-' + VS_strCodEmp, 19);

    objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor'                , strOpeRcx + '-' + fRetNomeOperador(strOpeRcx)        , 19);

    If (edtCodPag.Visible) then
    Begin
      If Not fEmptyStr(edtCodPag.Text) Then
        objLiberacao.objMsgLibera.pAddTextoCaption('Cond.Pagto'          , edtCodPag.Text + '-' + fRetDesConPag(edtCodPag.Text) , 19);
      If Not fEmptyStr(mskCndPag.Text) Then
        objLiberacao.objMsgLibera.pAddTextoCaption('                   ' , mskCndPag.Text                                       , 19);
      If Not fEmptyStr(edtCodFpg.Text) Then
        objLiberacao.objMsgLibera.pAddTextoCaption('Forma de Pagamento'  , edtCodFpg.Text                                       , 19);
    End;

    objLiberacao.objMsgLibera.pAddTextoCaption('Valor do Documento'      , edtTotGer.Text                                       , 19);
    objLiberacao.objMsgLibera.pAddSeparador(83);
    objLiberacao.objMsgLibera.pAddTexto('CRÉDITOS SELECIONADOS PARA UTILIZAÇÃO', alCentro, teAmbos, '', 83);

    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'DUPLICATA'  , 10 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'ESP'        , 4  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'EMP'        , 4  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'CLIENTE'    , 31 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'DT.CAD.'    , 11 , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'VR.CREDITO' , 12 , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    cdsCredit.First;
    While Not cdsCredit.Eof Do
    Begin
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('DUPLICATA'  , cdsCredit.FieldByName('NUMDUP').AsString + '-' + cdsCredit.FieldByName('PARCEL').AsString , 15 , alEsquerda);
      objLinha.pAddColuna('ESP'        , cdsCredit.FieldByName('ESPDOC').AsString                                                  , 4  , alCentro  );
      objLinha.pAddColuna('EMP'        , cdsCredit.FieldByName('CODEMP').AsString                                                  , 4  , alCentro  );
      objLinha.pAddColuna('CLIENTE'    , cdsCredit.FieldByName('CODCLI').AsString + '-' + cdsCredit.FieldByName('NOMCLI').AsString , 31 , alEsquerda);
      objLinha.pAddColuna('DT.CAD.'    , FormatDateTime('dd/mm/yyyy', cdsCredit.FieldByName('DTACAD').AsDateTime)                  , 11 , alCentro  );
      objLinha.pAddColuna('VR.CREDITO' , FloatToStrF(Abs(cdsCredit.FieldByName('VLRCRE').AsFloat), ffFixed, 11, 2)                 , 12 , alDireita );
      objTabela.lstLinhas.Add(objLinha);

      cdsCredit.Next;
    End;

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    objLiberacao.strDirAce := 'RCXCRE';
    objLiberacao.strSenLib := fCfgSis('RCXCRE');
    objLiberacao.strMsgSen := 'Utilização de Créditos';
    objLiberacao.strCliente:= edtCodCli.Text + '-' + edtNomCli.Text;
    objLiberacao.strCodOpe := strOpeRcx;

    Result := (Not objLiberacao.fLibera);
  End;
end;

procedure TfrmFatConfOrcamentos.pSetaTipoFaturamento(strEspecie: String);
  Var
    intIndex: Integer;
begin
  edtTipFat.Text := '';

  For intIndex := 0 To Length(arrOpcoes) - 1 Do
    If SameText(arrOpcoes[intIndex].strEspDoc, strEspecie) Then
    Begin
      edtTipFat.Text := arrOpcoes[intIndex].strDesCri;
      Break;
    End;

  pSetaVisibilidadeNotaPaulista;
end;

procedure TfrmFatConfOrcamentos.pSetaVisibilidadeNetpoints;
begin
  lblUtiNps.Visible := (blnUtiNps Or blnPedOrcMltLojUtiNps) And (edtCgcCpf.Text = '2') And (Not fEmptyStr(edtCodCli.Text)) And
                       (pnlRodape.Enabled) And (Not fEmptyStr(mskCgcCpf.Text)) And (Assigned(fatVenda)) And
                       (Not fEmptyStr(edtTipFat.Text)) And
                       (Pos(fTipoFaturamentoSelec.strEspDoc, 'NF_IF_IV_') > 0);


  edtNpsS_N.Visible := lblUtiNps.Visible;

  If (Not edtNpsS_N.Visible) Then
  Begin
    edtNpsS_N.Clear;

    If (Assigned(fatVenda)) Then
    Begin
      With fatVenda Do
      Begin
        objNetpoints.strQueNps := 'N';
        objNetPoints.strCpfCli := '';
        objNetPoints.strFonCli := '';
        objNetPoints.blnCpfCad := False;
      End;
    End;
  End;
end;

procedure TfrmFatConfOrcamentos.pSetaVisibilidadeNotaPaulista;
begin
  lblNotPau.Visible := False;

  If Assigned(fatVenda) And (fatVenda.fUFsDestTribItems.Contains('SP')) Then
  Begin
    If fCfgSis('NFPCLI', VarBoolean) Then
    Begin
      lblNotPau.Visible := (Not blnCliCon) And (edtCgcCpf.Text = '2') And (Not fEmptyStr(edtCodCli.Text)) And
                           (pnlRodape.Enabled) And (Not fEmptyStr(mskCgcCpf.Text)) And (Assigned(fatVenda)) And
                           (Not fEmptyStr(edtTipFat.Text)) And
                           (Pos(fTipoFaturamentoSelec.strEspDoc, 'IF_') > 0);
    End;
  End;

  edtNotPau.Visible := lblNotPau.Visible;

  If Not edtNotPau.Visible Then
    edtNotPau.Text := 'S';
end;

procedure TfrmFatConfOrcamentos.pTrataWMS;
begin
  If fCfgSis('BAISEP', varBoolean) Then
    If fUsaRotinaExpedicaoConferenciaRetiraCaixa Then
      Exit;

  If fUsaRotinaWMS And TPickingCheckOut.fWMSUtilizaPickingCheckOut Then
    Exit;

  If fUsaRotinaWMS Then
  Begin
    rdbEmissaoFaturamento.Enabled := False;
    rdbAdiantamentoPedido.Checked := True;
  End;

end;

procedure TfrmFatConfOrcamentos.pKeyDownTipFat(Key: Word; Shift: TShiftState);
  Var
    intPosicao : Integer;
    intContador: Integer;
begin
  inherited;

  If Key = VK_Down Then
  Begin

    intPosicao := intPosAtual;

    If (intPosAtual+1 >= Length(arrOpcoes)) Then
    Begin
      intPosAtual := 0;
    End
    Else
      Inc(intPosAtual);

    While (arrOpcoes[intPosAtual].strMosMen = 'N') And
          (intPosicao <> intPosAtual)              Do
    Begin

      If intPosAtual >= Length(arrOpcoes)-1 Then
        intPosAtual := 0
      Else
        Inc(intPosAtual);

    End;
    edtTipFat.Text := arrOpcoes[intPosAtual].strDesCri;

  End
  Else If Key = VK_Up Then
  Begin
    intPosicao := intPosAtual;

    If (intPosAtual-1 < 0) Then
    Begin
      intPosAtual := Length(arrOpcoes)-1;
    End
    Else
      Dec(intPosAtual);

    While (arrOpcoes[intPosAtual].strMosMen = 'N') And
          (intPosicao <> intPosAtual)              Do
    Begin

      If intPosAtual <= 0 Then
        intPosAtual := 0
      Else
        Dec(intPosAtual);

    End;

    edtTipFat.Text := arrOpcoes[intPosAtual].strDesCri;

  End
  Else If Shift <> [ssAlt] Then
  Begin

    For intContador := 0 To Length(arrOpcoes) -1 Do
    Begin

      If (arrOpcoes[intContador].strOpcLet = Chr(Key)) Then
      Begin
        intPosAtual := intContador;
        Break;
      End;

    End;

    If intContador < Length(arrOpcoes) Then
      edtTipFat.Text := arrOpcoes[intPosAtual].strDesCri;

  End;

  pSetaVisibilidadeNotaPaulista;

end;

procedure TfrmFatConfOrcamentos.pImprimeReciboBai;
  Var
    cdsImpRec : TUniClientDataSet;
    qryConCli : TUniQuery;
    qryCadRec : TUniQuery;
    arrCodCli : Array Of TRcxDadosCliente;
    strNomCli,
    strRecRcx : String;
    recValRec : TRcxValoresReceb;
    fltDinRec,
    fltCarRec,
    fltChqPre,
    fltChqVis,
    fltOrdRec,
    fltCreRec: Double;

  procedure pCarregaCadRec;
  begin
    qryCadRec.Close;
    qryCadRec.SQL.Clear;
    qryCadRec.SQL.Add('SELECT * FROM CADREC  WHERE CTR_SEQCON = '+IntToStr(fatVenda.intSeqCon) +
                                             ' AND CTR_EMPBAI = '+VS_strCodEmp.QuotedString);
    qryCadRec.Open;
  end;

begin
  fltDinRec := 0;
  fltCarRec := 0;
  fltChqPre := 0;
  fltChqVis := 0;
  fltOrdRec := 0;
  fltCreRec := 0;

  cdsImpRec := fCriaClientDatasetReciboCTR;
  qryCadRec := fCriaQuery;
  qryConCli := fCriaQuery;
  Try
    pCarregaCadRec;

    If Not qryCadRec.IsEmpty Then
    Begin
      With qryCadRec Do
      Begin

        SetLength(arrCodCli, 0);
        strRecRcx := fCfgSis('RECRCX');

        First;
        While Not Eof Do
        Begin
          cdsImpRec.Insert;
          cdsImpRec.FieldByName('CODCLI').AsString   := FieldByName('CTR_CODCLI').AsString;
          cdsImpRec.FieldByName('NOMCLI').AsString   := fRetNomCliente(FieldByName('CTR_CODCLI').AsString);
          cdsImpRec.FieldByName('DESCRI').AsString   := FieldByName('CTR_CODCLI').AsString + '-' + cdsImpRec.FieldByName('NOMCLI').AsString;
          cdsImpRec.FieldByName('NUMDOC').AsString   := FieldByName('CTR_NUMDUP').AsString;
          cdsImpRec.FieldByName('PARCEL').AsString   := FieldByName('CTR_PARCEL').AsString;
          cdsImpRec.FieldByName('ESPDOC').AsString   := FieldByName('CTR_ESPDOC').AsString;
          cdsImpRec.FieldByName('CODEMP').AsString   := FieldByName('CTR_CODEMP').AsString;
          cdsImpRec.FieldByName('DTACAD').AsDateTime := FieldByName('CTR_DTACAD').AsDateTime;
          cdsImpRec.FieldByName('DTAVEN').AsDateTime := FieldByName('CTR_DTAVEN').AsDateTime;
          cdsImpRec.FieldByName('DTAREC').AsDateTime := VS_Date;
          cdsImpRec.FieldByName('HORREC').AsDateTime := fTime();
          cdsImpRec.FieldByName('CODVEN').AsString   := fBuscaVendedorDup(FieldByName('CTR_NUMDUP').AsString,
                                                                            FieldByName('CTR_PARCEL').AsString,
                                                                            FieldByName('CTR_ESPDOC').AsString,
                                                                            FieldByName('CTR_CODCLI').AsString,
                                                                            FieldByName('CTR_CODEMP').AsString);
          cdsImpRec.FieldByName('SEQBAI').AsInteger := FieldByName('CTR_SEQBAI').AsInteger;
          cdsImpRec.FieldByName('SEQCON').AsInteger := FieldByName('CTR_SEQCON').AsInteger;
          cdsImpRec.FieldByName('NOSNUM').AsString  := FieldByName('CTR_NOSNUM').AsString;

          If strRecRcx = 'C' Then
            cdsImpRec.FieldByName('VALDOC').AsFloat  := FieldByName('CTR_VALORI').AsFloat + FieldByName('CTR_VALJUR').AsFloat
          Else
            cdsImpRec.FieldByName('VALDOC').AsFloat  := FieldByName('CTR_VALORI').AsFloat;

          cdsImpRec.FieldByName('VALORI').AsFloat  := FieldByName('CTR_VALORI').AsFloat;
          cdsImpRec.FieldByName('VALJUR').AsFloat  := FieldByName('CTR_VALJUR').AsFloat;
          cdsImpRec.FieldByName('VALDES').AsFloat  := FieldByName('CTR_VALDES').AsFloat;
          cdsImpRec.FieldByName('VALREC').AsFloat  := FieldByName('CTR_VALREC').AsFloat;

          If (Length(arrCodCli) = 0) Then
          Begin
            SetLength(arrCodCli, 1);

            pPesquisaCadCli(qryConCli, qryConCli, FieldByName('CTR_CODCLI').AsString);

            strNomCli := fRetNomCliente(FieldByName('CTR_CODCLI').AsString);
            arrCodCli[0].strCodCli := FieldByName('CTR_CODCLI').AsString;

            cdsImpRec.FieldByName('CODCLI').AsString := FieldByName('CTR_CODCLI').AsString;
            arrCodCli[0].strNomCli := FieldByName('CTR_CODCLI').AsString + ' - ' + fRetNomCliente(FieldByName('CTR_CODCLI').AsString);

            cdsImpRec.FieldByName('NOMCLI').AsString := strNomCli;

            arrCodCli[0].strEndCli := qryConCli.FieldByName('CLI_ENDERE').AsString+', ' +
                                      qryConCli.FieldByName('CLI_ENDNUM').AsString+' - '+
                                      qryConCli.FieldByName('CLI_BAIRRO').AsString;
            cdsImpRec.FieldByName('ENDERE').AsString := qryConCli.FieldByName('CLI_ENDERE').AsString;
            cdsImpRec.FieldByName('ENDNUM').AsString := qryConCli.FieldByName('CLI_ENDNUM').AsString;
            cdsImpRec.FieldByName('ENDCMP').AsString := qryConCli.FieldByName('CLI_ENDCOM').AsString;
            cdsImpRec.FieldByName('BAIRRO').AsString := qryConCli.FieldByName('CLI_BAIRRO').AsString;

            arrCodCli[0].strCepCli := qryConCli.FieldByName('CLI_C_E_P_').AsString;
            cdsImpRec.FieldByName('C_E_P_').AsString := qryConCli.FieldByName('CLI_C_E_P_').AsString;

            arrCodCli[0].strCidCli := fRetNomCidade(qryConCli.FieldByName('CLI_CODCID').AsString)+'-'+
                                      fRetNomCidade(qryConCli.FieldByName('CLI_CODCID').AsString, 2);
            cdsImpRec.FieldByName('CIDADE').AsString := fRetNomCidade(qryConCli.FieldByName('CLI_CODCID').AsString);
            cdsImpRec.FieldByName('ESTADO').AsString := fRetUFCliente(FieldByName('CTR_CODCLI').AsString);
            cdsImpRec.FieldByName('C_G_C_').AsString := qryConCli.FieldByName('CLI_C_G_C_').AsString;
            cdsImpRec.FieldByName('FONE01').AsString := qryConCli.FieldByName('CLI_FONE01').AsString;
          End;

          arrCodCli[0].fltValRec := arrCodCli[0].fltValRec + FieldByName('CTR_VALREC').AsFloat;

          If (Pos('CONSUMIDOR', strNomCli) > 0) Or
             (Pos('BALCAO', strNomCli) > 0) Or
             (Pos('BALCÃO', strNomCli) > 0) Then
          Begin
            cdsImpRec.FieldByName('NOMCLI').AsString := fRetCliConsumidor(FieldByName('CTR_CODCLI').AsString,
                                                                          FieldByName('CTR_NUMDUP').AsString,
                                                                          FieldByName('CTR_ESPDOC').AsString,
                                                                          FieldByName('CTR_CODEMP').AsString);
            cdsImpRec.FieldByName('DESCRI').AsString := FieldByName('CTR_CODCLI').AsString + '-' + cdsImpRec.FieldByName('NOMCLI').AsString;
          End;

          If Not strCodigoCaixa.IsEmpty Then
            cdsImpRec.FieldByName('RCX_CAIXA').AsString := 'CAIXA: ' + strCodigoCaixa;

          cdsImpRec.Post;

          fltDinRec := fltDinRec + FieldByName('CTR_DINHEI').AsFloat;
          fltCarRec := fltCarRec + FieldByName('CTR_CARTAO').AsFloat;
          fltChqPre := fltChqPre + FieldByName('CTR_CHQPRE').AsFloat;
          fltChqVis := fltChqVis + FieldByName('CTR_CHQAVI').AsFloat;
          fltOrdRec := fltOrdRec + FieldByName('CTR_ORDPAG').AsFloat;
          fltCreRec := fltCreRec + IIF(FieldByName('CTR_VALREC').AsFloat < 0,
                                       FieldByName('CTR_VALREC').AsFloat, 0);

          Next;

        End;
      End;

        {With cdsModalidades Do
        Begin
          If Locate('CODFPG', '001', []) Then
            recValRec.strDinRec:=FormatFloat('#,##0.00', FieldByName('VALOR').AsFloat);
          If Locate('CODFPG', '007', []) Then
            recValRec.strCarRec:=FormatFloat('#,##0.00', FieldByName('VALOR').AsFloat);
          If Locate('CODFPG', '002', []) Then
            recValRec.strChqPre:=FormatFloat('#,##0.00', FieldByName('VALOR').AsFloat);
          If Locate('CODFPG', '006', []) Then
            recValRec.strChqVis:=FormatFloat('#,##0.00', FieldByName('VALOR').AsFloat);
          If Locate('CODFPG', '012', []) Then
            recValRec.strOrdRec:=FormatFloat('#,##0.00', FieldByName('VALOR').AsFloat);
        End;}

        recValRec.strDinRec:=FormatFloat('#,##0.00', fltDinRec);
        recValRec.strCarRec:=FormatFloat('#,##0.00', fltCarRec);
        recValRec.strChqPre:=FormatFloat('#,##0.00', fltChqPre);
        recValRec.strChqVis:=FormatFloat('#,##0.00', fltChqVis);
        recValRec.strOrdRec:=FormatFloat('#,##0.00', fltOrdRec);
        recValRec.strCreRec:=FormatFloat('#,##0.00', fltCreRec);

        blnCalculaTotais := False;

        pImpRecBaiDoc(cdsImpRec,
                      strRecRcx,
                      fatVenda.intSeqCon,
                      strCodOpe ,
                      arrCodCli,
                      recValRec,
                      cdsChequePre,
                      cdsChequeVis);
    End;

  Finally
    FreeAndNil(cdsImpRec);
    FreeAndNil(qryCadRec);
    FreeAndNil(qryConCli);
  End;

end;

procedure TfrmFatConfOrcamentos.pImprimirReciboAdiantamentoPedido(pgbStatus: TCxProgressBar);
  Var
    objRecibo: TReciboAdiantamento;
begin
  If (Not blnRealizandoAdiantamentoPedidoPeloF11) Then
    Exit;

  If Not fPergunta('Imprimir Recibo?', fCfgSis('SUGREC', varBoolean)) Then
    Exit;

  pInformacao('Aguarde, Imprimindo Recibo...', pgbStatus);
  objRecibo := TReciboAdiantamento.Create(fatVenda.intSeqCon, strEmpLog, 'RCX');
  objRecibo.pImprimirRecibo;
  FreeAndNil(objRecibo);
end;

procedure TfrmFatConfOrcamentos.pImprimirReciboCreditosPendentes(pgbStatus: TCxProgressBar);
begin
  If (fCfgSis('IMPCPC') = 'S') And (fltCredUtilizados > 0) And (fGetTotalCreditosCliente(edtCodCli.Text) > 0) And (Not blnCancelarCFTef) Then
  Begin
    If (fMensagem('', 'Deseja imprimir o recibo de créditos pendentes do cliente?', ['&Sim', '&Não']) = 1) Then
    Begin
      pInformacao('Aguarde, Imprimindo recibo de créditos pendentes...', pgbStatus);
      TfrmQckRcxRecCredPenCli.pImprimeRcxRecCredPenCli(edtCodCli.Text, Self.Name);
    End;
  End;
end;

procedure TfrmFatConfOrcamentos.pImprimirReciboCreditosUtilizados(pgbStatus: TCxProgressBar);
begin
  If (fCfgSis('RBCF11') = 'S') And (fltCredUtilizados > 0) And (Not blnCancelarCFTef) Then
  Begin
    If (fMensagem('', 'Deseja imprimir o recibo de créditos utilizados?', ['&Sim', '&Não']) = 1) Then
    Begin
      pInformacao('Aguarde, Imprimindo recibo de créditos utilizados...', pgbStatus);
      pImprimeReciboBai;
    End;
  End;
end;

function TfrmFatConfOrcamentos.fRetornaDescontoEspecial(Var fltPorDes, fltDesEsp, fltTotGer: Double;
  cdsItensNovos: TUniClientDataSet; blnConcomitante: Boolean; blnFechamentoComDesconto: Boolean;
  strTabPre: String; pgbStatus: TcxProgressBar): Boolean;
  Const
    INT_PROGRESSO_MAX = 12;
  Var
    fltTotGerAnt: Double;
    fltDesEspAnt: Double;
    fltPorDesAnt: Double;
    fltValFreAnt: Double;
    fltDesAceAnt: Double;
    fltFreRatAnt: Double;
    fltTotSerAnt: Double;
    blnSemDes   : Boolean;
    intProgresso: Integer;
    blnNaoRatearDescontoEmItensNovos: Boolean;
    frmFatDigDesconto : TfrmFatDigDesconto;
begin
  fatVenda.strOriF11 := 'S';
  fatVenda.strNomeForm := 'frmFatVendas';

  If Not fEmptyStr(strTabPre) Then
    fatVenda.strTabPre := strTabPre;

  fatVenda.blnImprimeSep := True;

  fatVenda.blnConfOrcamento := True;
  fatVenda.strNumOrc := edtNumOrc.Text;
  fatVenda.strEspOrc := strEspCfo;
  fatVenda.strEmpOri := fEmpresaDocumento;

  fatVenda.strEspDoc := fRetEspecieSelecionada;

  blnNaoRatearDescontoEmItensNovos := (Not fCfgSis('DESF11', varBoolean)) And
                                      (Not fEmptyStr(fatVenda.strNumOrc)) And
                                      (Not blnConcomitante);

  If blnNaoRatearDescontoEmItensNovos Then
  Begin
    //F7DESF11 = Quando CFG_DESF11 = NÃO, aplicar desconto dado no pedido/orçamento sobre itens de check-out (F3 do F11)?
    If (fVerificaAcessoSistema('F7DESF11', IIF(fEmptyStr(strCodOpe), strLoginUsuarioLogado, strCodOpe))) Then
       blnNaoRatearDescontoEmItensNovos := False;
  End;     

  intProgresso := 0;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Carregando dados do cliente...', pgbStatus);

  pCarregaClienteVenda(fatVenda, fatVenda.strTabPre);

  If (fEmptyStr(fatVenda.strCliEst)) Then
  Begin
    pMensagemOk('As informações da cidade do cliente "' + fatVenda.strCodCli + '-' + fatVenda.strCliOri + '"' + sLineBreak +
                'não foram carregadas corretamente!' + sLineBreak +
                'Cidade: "' + fatVenda.strCodCid + '-' + fatVenda.strCliCid + '"' + sLineBreak +
                'Estado: "' + fatVenda.strCliEst + '"');
    Result := False;
    Exit;
  End;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Carregando dados da condição de pagamento...', pgbStatus);

  If qryFatGor.IsEmpty Then
  Begin
    fatVenda.strCodCnd := strDigCodCnd;
    fatVenda.strConPag := strDigConPag;
    fatVenda.blnCndEsp := (fRetEspConPag(strDigCodCnd) = 'S');
  End;

  pAcertaDadosCondicaoPagamento(fatVenda);

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Carregando produtos do documento...', pgbStatus);

  fatVenda.blnFecharForm := False;

  if (fEmptyStr(fatVenda.strTipVen)) and (not fEmptyStr(fatVenda.strCodVen)) then
    fatVenda.strTipVen := fRetTipoOperador(fatVenda.strCodVen);

  if (fEmptyStr(fatVenda.strTipVen)) and (not fEmptyStr(strDigCodVen)) then
    fatVenda.strTipVen := fRetTipoOperador(strDigCodVen);

  if cdsVenda.Active then
    cdsVenda.EmptyDataSet;

  fltFreRatAnt := 0;
  If Not qryFatGor.IsEmpty Then
  Begin
    cdsVenda.Data := oleItensVendaPed;

    fatVenda.intQtdTra := fFatGor('VOLUME').AsInteger;
    fatVenda.strEspTra := fFatGor('ESPECI').AsString;

    fltFreRatAnt := fFatGor('FRERAT').AsFloat;
  End;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Carregando produtos adicionais...', pgbStatus);

  pInserirItensAdicionais(fatVenda, blnNaoRatearDescontoEmItensNovos, cdsItensNovos, pgbStatus);

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Inserindo item de serviço...', pgbStatus);

  pInserirItemServico(fatVenda, fCfgSis('ITESER'));

  If fCfgSis('AUTCEN', VarBoolean) And (fCfgSis('ITESER') <> fCfgSis('SERTER')) Then
    pInserirItemServico(fatVenda, fCfgSis('SERTER'));

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Carregando dados do produto para Fechamento...', pgbStatus);

  If Assigned(frmCaixa) And (Not qryFatGor.IsEmpty) Then
    frmCaixa.pTransfereDadosPromocaoVlrMinAtiva;

  fatVenda.pPreencheMatrizFechamento;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Definindo tipo de produtos (Entrega/Retira/Ent.Futura)...', pgbStatus);

  blnDesmembrarVenda    := fatVenda.fHaveraDesmembramentoVenda(fatVenda.arrMatItens, FMatrizesDesmembramento);
  blnTemEntregaFutura   := fatVenda.fTemEntregaFutura(fatVenda.arrMatItens);
  blnTemEntregaImediata := fatVenda.fTemItensEntregaImediata(fatVenda.arrMatItens);
  blnTemRetiraOutraLoja := fatVenda.fTemItensRetira(fatVenda.arrMatItens, opOutraEmpresa);
  blnTemRetiraExpedicao := fatVenda.fTemItensRetira(fatVenda.arrMatItens, opTodasEmpresas, opLocalRetiraExpedicao);
  blnTemRetiraBalcao    := fatVenda.fTemItensRetira(fatVenda.arrMatItens, opTodasEmpresas, opLocalRetiraBalcao) Or
                           fatVenda.fTemItensRetira(fatVenda.arrMatItens, opTodasEmpresas, opLocalRetiraBalcao2);
  blnTemItensEmpresaCD  := fatVenda.fTemItensEmpresaCD(fatVenda.arrMatItens);

  fltDesEspAnt := fatVenda.fltDesEsp;
  fltPorDesAnt := fatVenda.fltPorDes;
  fltValFreAnt := fatVenda.fltValFre;
  fltDesAceAnt := fatVenda.fltDesAce;
  fltTotSerAnt := fatVenda.fltTotSer;

  fatVenda.fltDesEsp := 0;
  fatVenda.fltPorDes := 0;
  fatVenda.fltValFre := 0;
  fatVenda.fltDesAce := 0;
  fatVenda.fltTotSer := 0;

  If fRateiaFreteItensTransportadora(fatVenda.strCodTra, fatVenda.strTipFre) And (fltFreRatAnt > 0) Then
    fatVenda.fltFreRat := fltFreRatAnt;

  {*************************************}
  {* CALCULA TOTAL GERAL SEM IMPOSTOS, *}
  {* FRETE, DESPESAS E SERVICOS        *}
  {********************************MV***}
  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Calculando valor dos produtos...', pgbStatus);

  fatVenda.pCalculaTotGer(False, False, pOnCalculaTotGer);

  fltTotGerAnt := fGetTotGer(fatVenda.fltTotGer);

  fatVenda.strOriF11 := 'S';

  pCriarFormularios(TfrmFatDigDesconto, frmFatDigDesconto);
  frmFatDigDesconto.fatVenda     := fatVenda;
  frmFatDigDesconto.fltTotGerAnt := fGetTotGer(fatVenda.fltTotGer);
  frmFatDigDesconto.fltDesEspAnt := fltDesEspAnt;
  frmFatDigDesconto.fltPorDesAnt := fltPorDesAnt;
  frmFatDigDesconto.pnlVlrCheckOut.Visible := blnNaoRatearDescontoEmItensNovos;

  frmFatDigDesconto.pAtualizaInformacoesVenda;

  frmFatDigDesconto.edtPorDes.Text := FormatFloat('#,##0.00', fltPorDesAnt);
  frmFatDigDesconto.edtDesEsp.Text := FormatFloat('#,##0.00', fltDesEspAnt);

  frmFatDigDesconto.pOnCalculaTotGer := pOnCalculaTotGer;

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Verificando desconto do documento...', pgbStatus);

  blnSemDes := (fltPorDesAnt = 0) And (fltDesEspAnt = 0);

  If (Not blnConcomitante) And (fatVenda.strBenRei <> 'S') Then
  Begin
    {*******************************************}
    {* CASO CONFIGURADO PARA EXIBIR O DESCONTO *}
    {****************************************JC*}
    If (fCfgSis('DESF11', varBoolean)) Or (blnFechamentoComDesconto) Then
    Begin
      frmFatDigDesconto.ShowModal;
    End
    Else
    Begin
      {********************************************************************************}
      {* CASO CONFIGURADO PARA NAO EXIBIR O DESCONTO E NAO TENHA CARREGADO UM PEDIDO. *}
      {* OU SE O VALOR DO DESCONTO(PORDES OU DESESP) FOR IGUAL A ZERO.                *}
      {*************************************************************************JC*PZ* }
      If (Not qryFatGor.Active) Or (qryFatGor.IsEmpty) Or (blnSemDes) Then
      Begin
        frmFatDigDesconto.pCarregaTela;
        frmFatDigDesconto.btnConfirmaDados.Click;
      End
      {****************************************************************************}
      {* CASO CONFIGURADO PARA NAO EXIBIR O DESCONTO E TENHA CARREGADO UM PEDIDO  *}
      {* MOSTRA A TELA DO DESCONTO ESPECIAL MAS NÃO PERMITE EDITAR. APENAS PARA O *}
      {* OPERADOR SABER O VALOR DO DESCONTO E VALIDAÇÃO DO PREÇO MÍNIMO.          *}
      {**********************************************************************JC*PZ*}
      Else
      Begin
        frmFatDigDesconto.edtPorDes.ReadOnly := True;
        frmFatDigDesconto.edtDesEsp.ReadOnly := True;
        frmFatDigDesconto.ShowModal;
      End;
    End;

    pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
    pInformacao('Aguarde, Validando Valor Mínimo da Venda...', pgbStatus);

    If frmFatDigDesconto.blnConfirma Then
    Begin
      fatVenda.fltTotGerAnt := fltTotGerAnt;
      fatVenda.fltDesEspAnt := fltDesEspAnt;
      fatVenda.fltPorDesAnt := fltPorDesAnt;

      If (fUsaPromocaoComSugestaoPrecoTabelaSemPedidoCarregadoComCondicaoNoFinal) Then
      Begin
        Result := True;
      End
      {CASO NAO TENHA CARREGADO UM PEDIDO, SEMPRE IRA VERIFICAR O VALOR MINIMO}
      Else If (Not fPedidoCarregado) And (Not fEmptyStr(fatVenda.strCodCnd)) And (Not (fCfgSis('CND_F3') = 'F')) Then
      begin
        Result := fatVenda.fVerificaVrMinimo(fltTotGerAnt, fGetTotGer(fatVenda.fltTotGer), fatVenda.intPrzMed);
        blnVerificouMinimo := True;
      end

      {CASO TENHA CARREGADO UM PEDIDO, SOMENTE SE AUMENTOU O DESCONTO IRA VERIFICAR O VALOR MINIMO}
      Else If (fatVenda.fAumentouDesconto) And (Not fEmptyStr(fatVenda.strCodCnd)) And (Not (fCfgSis('CND_F3') = 'F')) Then
      begin
        Result := fatVenda.fVerificaVrMinimo(fltTotGerAnt, fGetTotGer(fatVenda.fltTotGer), fatVenda.intPrzMed);
        blnVerificouMinimo := True;
      end

      Else If (qryFatGor.Active And (Not qryFatGor.IsEmpty)) And (Not fEmptyStr(fatVenda.strCodCnd)) Then
      Begin
        Result := fatVenda.fVerificaVrMinimo(fltTotGerAnt, fGetTotGer(fatVenda.fltTotGer), fatVenda.intPrzMed);
        blnVerificouMinimo := True;
      End

      Else
        Result := True;
    End
    Else
      Result := False;
  End
  Else
  Begin
    Result := True;
  End;

  If (fCfgSis('USACND', varBoolean)) And (fCfgSis('PFLCLI', varBoolean)) Then
  Begin
    If (Not fatVenda.fVerificaIntervaloMargemValorCndPagto(fatVenda.strCodCnd)) Then
      Result := False;
  End;

  FreeAndNil(frmFatDigDesconto);

  pProgresso(intProgresso, INT_PROGRESSO_MAX, pgbStatus);
  pInformacao('Aguarde, Definindo valor de frete, despesas acessorias e descontos do documento...', pgbStatus);

  If (Not Result) Then
  Begin
    fatVenda.fltDesEsp := fltDesEspAnt;
    fatVenda.fltPorDes := fltPorDesAnt;
  End;

  fltDesEsp := fatVenda.fltDesEsp;
  fltPorDes := fatVenda.fltPorDes;

  fatVenda.fltValFre := fltValFreAnt;
  fatVenda.fltDesAce := fltDesAceAnt;
  fatVenda.fltTotSer := fltTotSerAnt;

  If fRateiaFreteItensTransportadora(fatVenda.strCodTra, fatVenda.strTipFre) And (fatVenda.fltValFre > 0) Then
  Begin
    fatVenda.fltFreRat := fatVenda.fltValFre;
    fatVenda.fltValFre := 0.00;
    fatVenda.fltFreDig := 0.00;
  End;

  If (Not blnDesmembrarVenda) And (fatVenda.strEspDoc = 'IF') And fCfgSis('FRECUP', VarBoolean) Then
  Begin
    fatVenda.pInsereItemFreteNoCupomFiscal;
  End;

  fatVenda.pAplicarFreteComoAcrescimoNFCe;

  fltTotGer := fGetTotGer(fatVenda.fltTotGer + fatVenda.fltTotRet + fatVenda.fltValFre + fatVenda.fltTotIpi + fatVenda.fltTotFcpST + fatVenda.fltTotCBS + fatVenda.fltTotIBS + fatVenda.fltTotIS + fatVenda.fltTotSer);
end;

function TfrmFatConfOrcamentos.fRetornouQuestFidelidadeOK(
  strCPFCNPJ, strItens, strNumDoc: string; blnVaiResgatar: Boolean): Boolean;
var
  Participante: TParticipante;
  PreCadastro: TPreCadastro;
  blnEhCadastro: Boolean;
  strTelefone: string;
  intEscolha: integer;
  intIndice: integer;
  blnErroCadastroQuest: Boolean;
  frmPontosQuestFidelidade: TfrmPontosQuestFidelidade;
begin
  Result := False;
  try
    if Assigned(ResgateQuest) then
    begin
      FreeAndNil(ResgateQuest);
    end;

    if Assigned(AcumulaQuest) then
    begin
      FreeAndNil(AcumulaQuest);
    end;

    pCriarFormularios(TfrmFatDigCnpj, frmFatDigCnpj);
    frmFatDigCnpj.ModalResult := mrOk;

    frmFatDigCnpj.edtCgcCpf.Text := '2';
    frmFatDigCnpj.edtNumCgc.EditMask := '999.999.999-99;0;';

    if Length(strCPFCNPJ) = 11 then
    begin
      frmFatDigCnpj.edtNumCgc.Text := strCPFCNPJ;
    end;

    if (fEmptyStr(strNumDoc)) and  (blnVaiResgatar) then
    begin
      frmFatDigCnpj.ShowModal;
    end;

    if (not fEmptyStr(strNumDoc)) or (frmFatDigCnpj.ModalResult = mrOk) then
    begin
      strCpfCnpjClienteQuest := frmFatDigCnpj.edtNumCgc.Text;
      Participante := TParticipante.Create;
      Participante := fConsultaQuestFidelidade(strCpfCnpjClienteQuest,IIF(not fEmptyStr(fCfgSis('CNPQUE')),fCfgSis('CNPQUE'),fRetCGCEmpresa(VS_strCodEmp)));
      if Participante.Erro then
      begin
        if not blnVaiResgatar then
        begin
          Exit;
        end;
        fMensagem('ATENÇÃO!', Participante.Mensagem, ['&Ok']);
        pBuscaClienteQuestNoAutcom(strCpfCnpjClienteQuest, blnCliCon, PreCadastro);
        blnEhCadastro := True;
      end
      else
      begin
        PreCadastro := TPreCadastro.Create;
        PreCadastro.CnpjParceiro := IIF(not fEmptyStr(fCfgSis('CNPQUE')),fCfgSis('CNPQUE'),fRetCGCEmpresa(VS_strCodEmp));
        PreCadastro.CpfCnpjParticipante := Participante.CpfCnpjParticipante;
        PreCadastro.PrimeiroNome := Participante.Nome;
        PreCadastro.DDD := Participante.Telefones[0].DDD;
        PreCadastro.Numero := Participante.Telefones[0].Numero;
        PreCadastro.Email := Participante.Email;
        blnEhCadastro := False;
      end;

      try
        pCriarFormularios(TfrmCadQuestFidelidade, frmCadQuestFidelidade);
        frmCadQuestFidelidade.ModalResult := mrOk;

        if Length(strCpfCnpjClienteQuest) = 11 then
        begin
          frmCadQuestFidelidade.edtCgcCpf.Text := '2';
          frmCadQuestFidelidade.edtNumCgc.EditMask := '999.999.999-99;0;';
        end
        else
        begin
          frmCadQuestFidelidade.edtCgcCpf.Text := '1';
          frmCadQuestFidelidade.edtNumCgc.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_);
        end;
        frmCadQuestFidelidade.edtNumCgc.Text := strCpfCnpjClienteQuest;
        frmCadQuestFidelidade.edtTelefone.Text := IIF(PreCadastro.DDD = 0,'',IntToStr(PreCadastro.DDD)) + PreCadastro.Numero;
        frmCadQuestFidelidade.edtNome.Text := PreCadastro.PrimeiroNome;
        frmCadQuestFidelidade.edtEmail.Text := PreCadastro.Email;
        frmCadQuestFidelidade.lblQuestPontos.Caption := '0,00';
        frmCadQuestFidelidade.lblQuestValor.Caption := 'R$ 0,00';

        if not Participante.Erro then
        begin
          frmCadQuestFidelidade.lblQuestPontos.Caption := FloatToStrF(Participante.SaldoDisponivelPontos, ffFixed, 12, 2);
          frmCadQuestFidelidade.lblQuestValor.Caption := 'R$ ' + FloatToStrF(Participante.SaldoDisponivelValor, ffFixed, 12, 2);

          frmCadQuestFidelidade.memHistoricoQuest.Lines.Clear;
          for intIndice := 0 to Participante.HistoricoCompras.Count - 1 do
          begin
            frmCadQuestFidelidade.memHistoricoQuest.Lines.Add('Produto: ' + Participante.HistoricoCompras[intIndice].Produto);
            frmCadQuestFidelidade.memHistoricoQuest.Lines.Add('Quantidade: '+ IntToStr(Participante.HistoricoCompras[intIndice].Compras));
            frmCadQuestFidelidade.memHistoricoQuest.Lines.Add('');
          end;

          frmCadQuestFidelidade.memOfertasQuest.Lines.Clear;
          for intIndice := 0 to Participante.Campanhas.Count - 1 do
          begin
            frmCadQuestFidelidade.memOfertasQuest.Lines.Add(Participante.Campanhas[intIndice].Descricao);
            frmCadQuestFidelidade.memOfertasQuest.Lines.Add('');
          end;
        end;

        frmCadQuestFidelidade.pHabilitaCampos(blnEhCadastro);
        blnErroCadastroQuest := True;

        while blnErroCadastroQuest do
        begin
          if (fEmptyStr(strNumDoc)) and (blnVaiResgatar) then
          begin
            frmCadQuestFidelidade.ShowModal;
          end;

          if (not fEmptyStr(strNumDoc)) or (frmCadQuestFidelidade.ModalResult = mrOk) then
          begin
            PreCadastro.CpfCnpjParticipante := frmCadQuestFidelidade.edtNumCgc.Text;
            strTelefone := frmCadQuestFidelidade.edtTelefone.Text;
            if fEmptyStr(strTelefone) then
            begin
              PreCadastro.DDD := 0;
              PreCadastro.Numero := '';
            end
            else
            begin
              PreCadastro.DDD := StrToIntDef(Copy(strTelefone,1,2),0);
              Delete(strTelefone,1,2);
              PreCadastro.Numero := Trim(strTelefone);
            end;
            PreCadastro.PrimeiroNome := frmCadQuestFidelidade.edtNome.Text;
            PreCadastro.Email := frmCadQuestFidelidade.edtEmail.Text;
            blnErroCadastroQuest := False;

            if Participante.Erro then
            begin
              pPreCadastroQuestFidelidade(PreCadastro);
              fMensagem('ATENÇÃO!', PreCadastro.Mensagem, ['&Ok']);
              if PreCadastro.Erro then
              begin
                blnErroCadastroQuest := True;
              end
              else
              begin
                blnVaiResgatar := False;
              end;
            end
            else
            begin
              PreCadastro.SaldoDisponivelPontos := Participante.SaldoDisponivelPontos;
              PreCadastro.SaldoDisponivelValor  := Participante.SaldoDisponivelValor;
            end;
          end
          else
          begin
            Exit;
          end;
        end;
      finally
        FreeAndNil(frmCadQuestFidelidade);
      end;

      try
        pCriarFormularios(TfrmPontosQuestFidelidade, frmPontosQuestFidelidade);
        frmPontosQuestFidelidade.strItens  := strItens;
        frmPontosQuestFidelidade.strNumDoc := strNumDoc;
        frmPontosQuestFidelidade.lblNomeParticipante.Caption := PreCadastro.PrimeiroNome;
        frmPontosQuestFidelidade.lblPontosParticipante.Caption := FloatToStrF(PreCadastro.SaldoDisponivelPontos, ffFixed, 12, 2);
        frmPontosQuestFidelidade.lblValorParticipante.Caption  := FloatToStrF(PreCadastro.SaldoDisponivelValor, ffFixed, 12, 2);

        if blnVaiResgatar then
        begin
          frmPontosQuestFidelidade.ShowModal;
          fltValorDinheiro := 0;
          if frmPontosQuestFidelidade.ModalResult = mrOK then
          begin
            intEscolha := frmPontosQuestFidelidade.rdgPontos.ItemIndex;
            case intEscolha of
              0: fltValorDinheiro := 0;
              1: fltValorDinheiro := PreCadastro.SaldoDisponivelValor;
              2: fltValorDinheiro := StrToFloatDef(frmPontosQuestFidelidade.edtPontos.Text,0);
            end;

            if fltValorDinheiro > PreCadastro.SaldoDisponivelValor then
            begin
              fMensagem('ATENÇÃO!', 'Saldo insuficiente para efetuar resgate.', ['&Ok']);
              Exit;
            end;
          end
          else
          begin
            fMensagem('ATENÇÃO!', 'Nenhuma ação será executada.', ['&Ok']);
            Exit;
          end;
        end;
      finally
        FreeAndNil(frmPontosQuestFidelidade);
      end;
      if fltValorDinheiro > 0 then
      begin
        fltValorPonto := (fltValorDinheiro / fCfgSis('VLRQUE', varDouble));
        if fltValorDinheiro > StrToFloatDef(edtValor.Text,0) then
        begin
          fltValorDinheiro := StrToFloatDef(edtValor.Text,0);
          fltValorPonto := (fltValorDinheiro / fCfgSis('VLRQUE', varDouble));
        end;
        blnVaiResgatarQuest := True;
      end
      else
      begin
        fltValorPonto := 0;
      end;
      Result := True;
    end;
  finally
    FreeAndNil(frmFatDigCnpj);
    if Assigned(PreCadastro) then
    begin
      FreeAndNil(PreCadastro);
    end;

    if Assigned(Participante) then
    begin
      FreeAndNil(Participante);
    end;
  end;
end;

procedure TfrmFatConfOrcamentos.pCarregaClienteVenda(fatVenda: TFatVenda; strTabPre: String='');
begin
  fatVenda.blnGravaCtrTe := False;
  fatVenda.strCodEmpTe   := '';
  fatVenda.strTipEmiTe   := '';
  fatVenda.strCodForTe   := '';
  fatVenda.strPerEmpTe   := '';
  fatVenda.strTipOpe     := Self.strTipOpe;

  If Not qryFatGor.IsEmpty Then
  Begin
    untFuncFat.pCarregarClientePedidoOrcamento(fatVenda, '', False, FPedidoEntCd);
    If Not fEmptyStr(strTabPre) Then
       fatVenda.strTabPre := strTabPre;

    If fatVenda.fPedidoAPrazoComEntradaQuitada(fatVenda.strNumOrc,
                                               fatVenda.strEspOrc,
                                               fRetornaCodigoDaEmpresa,
                                               fatVenda.FConPag) Then
    Begin
      fatVenda.pAlteraCondicaoPagamentoRemovendoEntrada(fatVenda.FConPag);
    End;
  End
  Else
  Begin
    fatVenda.pCarregaDadosClienteBaixa(qryCadCli.FieldByName('CLI_CODCLI').AsString);
    fatVenda.strMen001 := qryCadCli.FieldByName('CLI_MSGPED').AsString;
    fatVenda.strMen002 := qryCadCli.FieldByName('CLI_MSGPE2').AsString;
  End;

  fatVenda.strCliNom := edtNomCli.Text;                                                 //Nome do Cliente
  fatVenda.strCliIes := strCliIes;
  fatVenda.strCli_Rg := mskNumR_G.Text;                                                 //         - RG

  If Not fEmptyStr(edtEmail.Text) Then
    fatVenda.strCliEma := edtEmail.Text;

  If fClienteConsumidor(qryCadCli.FieldByName('CLI_NOMCLI').AsString, False, True) Then
  Begin
    fatVenda.strCliCgc := mskCgcCpf.Text;
    fatVenda.intCgcCpf := StrToInt(edtCgcCpf.Text);
    fatVenda.strCliTel := strFone01;
  End;

  fatVenda.strCliCel := strCelular;
  fatVenda.pCarregaAliquotasRetencao;
  fatVenda.pDefineSeClienteEmiteEnvioEstoqueExternoPeloAutcom;

  If (fatVenda.blnCliFil) Then
    fatVenda.pAtualizaClassTransferencias;

  pCarregaEnderecoEntregaVenda(fatVenda);
  pCarregaTransportadoraVenda(fatVenda);
end;

procedure TfrmFatConfOrcamentos.pCarregaComplementosEndCad(fatVenda: TFatVenda);
  Var
    qryEndEnt : TUniQuery;
begin
  qryEndEnt := fCriaQuery(Nil);

  With qryEndEnt Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT * ');
    SQL.Add('   FROM ENTCLI ');
    SQL.Add('  WHERE ETC_CODCLI = :CODCLI ');
    SQL.Add('    AND ETC_ENDFAT = "S" ');
    ParamByName('CODCLI').AsString := edtCodCli.Text;
    Open;

    fatVenda.strCobIss := FieldByName('ETC_COBISS').AsString;

    {Quando J_A_MASSA_CONCRETO, será informado Obra e ART na tela de "frmFatDigDadosConcreto" no Pedido!}
    If (fCfgSis('TPNFCR') <> J_A_MASSA_CONCRETO) Then
    Begin
      fatVenda.strCodObr := FieldByName('ETC_CODOBR').AsString;
      fatVenda.strCodArt := FieldByName('ETC_CODART').AsString;
      fatVenda.strCodCno := FieldByName('ETC_CODCNO').AsString;
      fatVenda.strInsImo := FieldByName('ETC_INSIMO').AsString;
      fatVenda.strCodCib := FieldByName('ETC_CODCIB').AsString;
    End;

    fatVenda.strRefEnt := FieldByName('ETC_REFENT').AsString;

    Close;
  End;

  FreeAndNil(qryEndEnt);
end;

procedure TfrmFatConfOrcamentos.pCarregaEnderecoEntregaVenda(fatVenda: TFatVenda);
begin
  fatVenda.objEndEnt.recEndere := objEndEnt.recEndere;
  fatVenda.strAutEnt           := objEndEnt.recEndere.strIncrem;

  fatVenda.strEndEnt := edtEndEnt.Text;
  fatVenda.strBaiEnt := edtBaiEnt.Text;
  fatVenda.strCepEnt := mskCepEnt.Text;
  fatVenda.strCidEnt := edtCidEnt.Text;
  fatVenda.strNomCidEnt := fRetNomCidade(fatVenda.strCidEnt);
  fatVenda.strEstEnt    := fRetNomCidade(fatVenda.strCidEnt, 1);

  If fEmptyStr(fatVenda.strAutEnt) Then
    pCarregaComplementosEndCad(fatVenda)
  Else
  Begin
    fatVenda.strCobIss := objEndEnt.recEndere.strCobIss;

    {Quando J_A_MASSA_CONCRETO, será informado Obra e ART na tela de "frmFatDigDadosConcreto" no Pedido!}
    If (fCfgSis('TPNFCR') <> J_A_MASSA_CONCRETO) Then
    Begin
      fatVenda.strCodObr := objEndEnt.recEndere.strCodObr;
      fatVenda.strCodArt := objEndEnt.recEndere.strCodArt;
      fatVenda.strCodCno := objEndEnt.recEndere.strCodCno;
      fatVenda.strInsImo := objEndEnt.recEndere.strInsImo;
      fatVenda.strCodCib := objEndEnt.recEndere.strCodCib;
    End;

    fatVenda.strRefEnt := objEndEnt.recEndere.strRefEnt;
  End;

  If (fClienteConsumidor(fatVenda.strCliOri, False, True)) Then
  Begin
    fatVenda.strCliEnd := edtEndEnt.Text;
    fatVenda.strCliBai := edtBaiEnt.Text;
    fatVenda.strCliCep := mskCepEnt.Text;
    fatVenda.strCodCid := edtCidEnt.Text;
    fatVenda.strCliCid := edtNomCid.Text;
    fatVenda.strCliEst := edtUF.Text;
  End;
end;

procedure TfrmFatConfOrcamentos.pCarregaTransportadoraVenda(fatVenda: TFatVenda);
begin
  If Not qryCadTra.Active Then
    pCarregaTransportadora;

  fatVenda.strCodTra := edtCodTra.Text;
  fatVenda.strNomTra := edtNomTra.Text;
  fatVenda.strEndTra := qryCadTra.FieldByName('TRA_ENDERE').AsString;
  fatVenda.strNumPla := qryCadTra.FieldByName('TRA_NUMPLA').AsString;
  fatVenda.strCgcTra := qryCadTra.FieldByName('TRA_C_G_C_').AsString;
  fatVenda.strIesTra := qryCadTra.FieldByName('TRA_I_E_S_').AsString;
  fatVenda.strCidTra := fRetNomCidade(qryCadTra.FieldByName('TRA_CODCID').AsString, 0);
  fatVenda.strEstTra := fRetNomCidade(qryCadTra.FieldByName('TRA_CODCID').AsString, 1);
  fatVenda.strTipFre := fTipoFrete(cmbTipFre.Text);
  fatVenda.strPlaFat := mskPlaFat.Text;
end;

procedure TfrmFatConfOrcamentos.pMostraObsCliente(strCodCli: String);
  Var
    qryCliObs: TUniQuery;
    strCliObs: String;
begin

  qryCliObs := fCriaQuery(Nil);

  With qryCliObs Do
  Begin
    SQL.Add('SELECT SQL_NO_CACHE CLI_OBSERV FROM CADCLI WHERE CLI_CODCLI =:CODCLI ');
    ParamByName('CODCLI').AsString := strCodCli;
    Open;
    strCliObs := FieldByName('CLI_OBSERV').AsString;
  End;

  FreeAndNil(qryCliObs);

  If (fEmptyStr(strCliObs)) Then
    Exit;

  Try
    pCriarFormularios(TfrmFatMostraObsCliente, frmFatMostraObsCliente);
    frmFatMostraObsCliente.memObserv.Texto := strCliObs;
    frmFatMostraObsCliente.strCodCli := strCodCli;
    frmFatMostraObsCliente.showModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[pMostraObsClienteF11]');
  End;

  pFreeAndNil(frmFatMostraObsCliente);

end;

function TfrmFatConfOrcamentos.fVerificaTravaColetor(strNumDoc: String): Boolean;
begin
  Result := False;

  if (not blnRealizandoAdiantamentoPedidoPeloF11) then
    Exit;

  if (not fVerificaLockAtivo('FATGOR' + strNumDoc +
                                        strEspCfo +
                                        fEmpresaDocumento +
                                        STR_TRAVA_COLETOR)) then
    Exit;

  Result := True;
end;

function TfrmFatConfOrcamentos.fVerificaTrocoOuAdiantamentoEmDinheiro(
  strCodFpg: String): Boolean;
begin
  Result := ((rdbAdiantamentoPedido.Checked) And (strCodFpg = '001') And (fCfgSis('TROF11', varBoolean)));
end;

function TfrmFatConfOrcamentos.fConfirmaCartoesTEF(blnUsaVinculado: Boolean): Boolean;
  var
    blnTemTef: boolean;
begin
  Result := False;
  blnTemTef := False;
  cdsModalidades.First;
  while Not cdsModalidades.Eof do
  begin
    blnTemTef := (cdsModalidades.FieldByName('ECF_IDENTI').AsString = '3') and
                 (Pos('(POS)',cdsModalidades.FieldByName('DESMOD').AsString) <= 0);
    if blnTemTef then
      Break;

    cdsModalidades.Next;
  end;

  if blnTemTef then
  Begin
    pAguardarImpressaoNFCeAntesDoTEF;

    if (VS_blnTefCitel) then
    begin
      Result := fConfirmaVendaTefCitel;
    end
    Else If (Assigned(VS_objTef)) And (Not VS_objTef.fTefFinRet(Not blnUsaVinculado)) Then
    Begin
      {************************************}
      {* -> VERIFICA CNC / NCN            *}
      {*********************************WI*}
      VS_objTef.pVerificaCncNcn;
    End
    Else
      Result := True;
  End
  Else
    Result := True;
end;

function TfrmFatConfOrcamentos.fConfirmaCTE: Boolean;
begin
  if (fTipoFaturamentoSelec.strEspDoc = 'NF') and (not fEmptyStr(edtCodTra.Text))
     and (blnTemEntregaImediata) and (fCfgSis('UTICTE', varBoolean))
     and (fCampoTabela('TRA_CONHAB', 'CADTRA', ['TRA_CODTRA'], [edtCodTra.Text]) = 'S') then
  begin
    try
      Result := TfrmFatDadosCTe.Exibir(fatVenda, edtCodTra.Text, StrToFloatDef(edtVolume.Text, 0));
    except
      On E: Exception do
      begin
        Result := False;
        pMensagensErro(E.Message, '[fConfirmaVenda_CTe]');
      end;
    end;
  end
  else
  begin
    fatVenda.objDadosCte.blnGrava := False;
    Result := True;
  end;
end;

procedure TfrmFatConfOrcamentos.pOnPreencheMatrizItens(const item: TDadosFechamento; index, count: Integer; AInfo: String = '');
  Var
    strInfoProcessamento: String;
begin
  If Assigned(frmGravandoFechamentoVenda) Then
  Begin
    strInfoProcessamento := 'Aguarde, Processando produto %s...';
    If AInfo.IsEmpty Then
      AInfo := strInfoProcessamento;
    pInformacao(Format(AInfo, [item.strCodIte + '-' + fPadR(item.strDesIte, 10)]), frmGravandoFechamentoVenda.pgbStatus);
    pProgresso(index, count, frmGravandoFechamentoVenda.pgbStatus);
  End;
end;

procedure TfrmFatConfOrcamentos.pOnCalculaTotGer(const item: TDadosFechamento; index, count: Integer; AInfo: String = '');
  Var
    strInfoProcessamento: String;
begin
  If Assigned(frmGravandoFechamentoVenda) Then
  Begin
    strInfoProcessamento := 'Aguarde, Calculando valor do produto %s...';
    If AInfo.IsEmpty Then
      AInfo := strInfoProcessamento;
    pInformacao(Format(AInfo, [item.strCodIte + '-' + fPadR(item.strDesIte, 10)]), frmGravandoFechamentoVenda.pgbStatus);
    pProgresso(index, count, frmGravandoFechamentoVenda.pgbStatus);
  End;
end;

function TfrmFatConfOrcamentos.fAtualizarDadosCupomImpresso(dadosCupom: TDadosImpressaoVenda;
  strNumCoo, strNumSer, strNumCcf: String): Boolean;
  Var
    blnRetAtu: Boolean;
begin
  fStartTransaction;
  Try
    pMarcaDocumentoComoImpresso(dadosCupom.strNumDoc, dadosCupom.strEspDoc,
      dadosCupom.strEmpDoc, dadosCupom.strCodCli);

    blnRetAtu := fAtualizarTabelas(dadosCupom.strNumDoc,
                                   dadosCupom.strEspDoc,
                                   dadosCupom.strEmpDoc,
                                   dadosCupom.strCodCli,
                                   strNumCoo,
                                   strNumSer,
                                   strNumCcf);
    Result := blnRetAtu;
    If blnRetAtu Then
    Begin
      fCommit;
    End
    Else
    Begin
      fRollBack;
    End;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
    End;
  End;
end;

function TfrmFatConfOrcamentos.fCfgConcomitante: Boolean;
begin
  Result := (fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'CMTF11'       , 'N', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' ) = 'S');
end;

procedure TfrmFatConfOrcamentos.pHabilitaDadosCliente(blnHab: Boolean);
begin
  edtCodCli.Enabled := blnHab;
  edtNomCli.Enabled := blnHab;
  edtCgcCpf.Enabled := blnHab;
  mskCgcCpf.Enabled := blnHab;
  mskNumR_G.Enabled := blnHab;
  edtEndEnt.Enabled := blnHab;
  edtBaiEnt.Enabled := blnHab;
  mskCepEnt.Enabled := blnHab;
  edtCidEnt.Enabled := blnHab;
  edtCodTra.Enabled := blnHab;
  mskPlaFat.Enabled := blnHab;
  edtVolume.Enabled := blnHab;
  edtEspVol.Enabled := blnHab;
  cmbTipFre.Enabled := blnHab;
  chkEndEnt.Enabled := blnHab;
  edtEmail.Enabled  := blnHab;
end;

procedure TfrmFatConfOrcamentos.pHabilitaOpcoesRealizar;
var
  LHabRea: String;
  LCarRea: Integer;
begin
  if fUsaRotinaWMS then
    Exit;

  LHabRea := fCfgSis('HABREA', varString);
  LCarRea := fCfgSis('CARREA', varInteger);

  rdbEmissaoFaturamento.Visible := LHabRea[1] = 'S';
  rdbAdiantamentoPedido.Visible := LHabRea[2] = 'S';

  rdbEmissaoFaturamento.Checked := True;

  if (not rdbEmissaoFaturamento.Visible) then
  begin
    rdbAdiantamentoPedido.Left := rdbEmissaoFaturamento.Left;
    rdbAdiantamentoPedido.Checked := True;
  end;

  if rdbAdiantamentoPedido.Visible and rdbEmissaoFaturamento.Visible then
  begin
    rdbEmissaoFaturamento.Checked := (LCarRea = 1);
    rdbAdiantamentoPedido.Checked := (LCarRea = 2);
  end;
end;

procedure TfrmFatConfOrcamentos.pHabilitarCamposAposFechamento(blnSucesso: Boolean);
begin
  Self.Enabled := True;
  btnConfirma.Enabled := True;
  btnSair.Enabled := True;
  Screen.Cursor := crDefault;

  If (blnGravouArquivos) And (Not blnSucesso) Then
  Begin
    btnConfirma.Enabled := False;
    fMensagem('Atenção', 'O pedido/orçamento foi faturado, entretando, houve algum erro na conclusão do faturamento ex: Perda de Conexão.'+#10#13+
                         'Recomenda-se fechar o Autcom e conferir posterirormente se o documento de faturamento foi emitido corretamente!', ['&Ok']);
  End;

  edtCodCli.Enabled := True;
  edtNomCli.Enabled := True;
  edtCgcCpf.Enabled := True;
  mskCgcCpf.Enabled := True;
  mskNumR_G.Enabled := True;
  edtEndEnt.Enabled := True;
  edtEmail.Enabled  := True;
  edtBaiEnt.Enabled := True;
  mskCepEnt.Enabled := True;
  edtCidEnt.Enabled := True;
  edtCodTra.Enabled := True;
  mskPlaFat.Enabled := True;
  cmbTipFre.Enabled := True;
  edtVolume.Enabled := True;
  edtEspVol.Enabled := True;
  {****************************************************}
  { Se estiver configurado para fechar automaticamente }
  {*************************************************RV*}
  If fCfgSis('F11SAI', varBoolean) Then
  Begin
    ModalResult := mrOk;
  End;

  If (strEspCfo = 'PD') And fCfgSis('COMAND', VarBoolean) Then
    pSetFocus(edtBarCom)
  Else
    pSetFocus(edtNumOrc);
end;

procedure TfrmFatConfOrcamentos.pCancelaCupomNoEcf(ecfFiscal: TUntFiscal);
  Var
    strCodErr: String;
begin
  While (Not ecfFiscal.fRetImpLigada(strCodErr)) Do
  Begin
    fMensagem('ATENÇÃO', 'A impressora está desligada. Favor ligá-la.', ['&Ok']);
    pProcessMessages;
  End;

  ecfFiscal.fCancelaCupom(strCodErr);
end;

procedure TfrmFatConfOrcamentos.pValidaQuestFidelidade(strDocCli: string; blnVAiResgatar: Boolean);
var
  RetornoToken: TRetornoToken;
  strItens: string;
  strTokenQuest: string;
  intTentativas: integer;
begin
  strAutIncQuest := '';
  if fEmptyStr(strDocCli) then
  begin
    strDocCli := mskCgcCpf.Text;
  end;
  if cdsItensAdd.IsEmpty then
  begin
    if fRetornouQuestFidelidadeOK(strDocCli, '', fFatGor('AUTOINCREM').AsString, blnVAiResgatar) then
    begin
      blnUsandoQuestFidelidade := True;
      if blnVaiResgatarQuest then
      begin
        cbxModalidades.Items.Add('QUEST');
        stlModalidades.Add('007');
        cbxModalidades.ItemIndex := cbxModalidades.Items.IndexOf('QUEST');
        blnEhCartaoQuest := True;

        edtValor.Text := FloatToStrF(fltValorDinheiro, ffFixed, 12, 2);
        TfrmGravando.fExecutarModalA(pReceberModalidade, 'Aguarde, Realizando Recebimento...', '');

        cbxModalidades.Items.Delete(cbxModalidades.Items.IndexOf('QUEST'));
        blnVaiResgatarQuest := False;
        blnEhCartaoQuest := False;

        ResgateQuest := TResgata.Create;
        ResgateQuest := fRetornaClasseResgateQuest(fFatGor('AUTOINCREM').AsString,IIF(not fEmptyStr(fCfgSis('CNPQUE')),fCfgSis('CNPQUE'),fRetCGCEmpresa(VS_strCodEmp)), strCpfCnpjClienteQuest, StrToFloatDef(edtTotGer.Text,0), fltValorPonto);

        try
          RetornoToken := TRetornoToken.Create;
          RetornoToken := fGeraTokenQuest(IIF(not fEmptyStr(fCfgSis('CNPQUE')),fCfgSis('CNPQUE'),fRetCGCEmpresa(VS_strCodEmp)), strCpfCnpjClienteQuest, fltValorPonto);
          fMensagem('ATENÇÃO!', RetornoToken.Mensagem, ['&Ok']);
          if not RetornoToken.Erro then
          begin
            intTentativas := 0;
            while (intTentativas < 3) do
            begin
              Inc(intTentativas);
              If ffrmSenha(strTokenQuest, 'Informe o token ou a senha') Then
              begin
                ResgateQuest.SenhaParticipante :=  strTokenQuest;
                strAutIncQuest := fEfetivouQuestFidelidade;
                if fEmptyStr(strAutIncQuest) and (intTentativas >= 3) then
                begin
                  pApagaModalidade;
                  edtValor.Value := edtValor.Value + fltValorDinheiro;
                end
                else
                begin
                  intTentativas := 3;
                end;
              end
              else
              begin
                intTentativas := 3;
                pApagaModalidade;
                edtValor.Value := edtValor.Value + fltValorDinheiro;
                strTokenQuest := '.';
              end;
            end;
          end;
        finally
          FreeAndNil(RetornoToken);
        end;
      end
      else
      begin
        if blnVAiResgatar then
        begin
          AcumulaQuest := TAcumula.Create;
          AcumulaQuest := fRetornaClasseAcumulaQuest(fFatGor('AUTOINCREM').AsString,IIF(not fEmptyStr(fCfgSis('CNPQUE')),fCfgSis('CNPQUE'),fRetCGCEmpresa(VS_strCodEmp)), strCpfCnpjClienteQuest, StrToFloatDef(edtTotGer.Text,0));
          strAutIncQuest := fEfetivouQuestFidelidade;
        end;
      end;
    end;
  end
  else
  begin
    strItens := '';
    cdsItensAdd.First;
    while not cdsItensAdd.Eof do
    begin
      strItens :=  strItens + ',' + cdsItensAdd.FieldByName('ITE_CODITE').AsString;
      cdsItensAdd.Next;
    end;
    cdsItensAdd.First;
    Delete(strItens,1,1);

    if fRetornouQuestFidelidadeOK(strDocCli, strItens, '', blnVAiResgatar) then
    begin
      blnUsandoQuestFidelidade := True;
      if blnVaiResgatarQuest then
      begin
        cbxModalidades.Items.Add('QUEST');
        stlModalidades.Add('007');
        cbxModalidades.ItemIndex := cbxModalidades.Items.IndexOf('QUEST');
        blnEhCartaoQuest := True;

        edtValor.Text := FloatToStrF(fltValorDinheiro, ffFixed, 12, 2);
        TfrmGravando.fExecutarModalA(pReceberModalidade, 'Aguarde, Realizando Recebimento...', '');

        cbxModalidades.Items.Delete(cbxModalidades.Items.IndexOf('QUEST'));
        blnVaiResgatarQuest := False;
        blnEhCartaoQuest := False;

        ResgateQuest := TResgata.Create;
        ResgateQuest := fRetornaClasseResgateQuestCDS(IIF(not fEmptyStr(fCfgSis('CNPQUE')),fCfgSis('CNPQUE'),fRetCGCEmpresa(VS_strCodEmp)), strCpfCnpjClienteQuest, StrToFloatDef(edtTotGer.Text,0), fltValorPonto, cdsItensAdd);

        try
          RetornoToken := TRetornoToken.Create;
          RetornoToken := fGeraTokenQuest(IIF(not fEmptyStr(fCfgSis('CNPQUE')),fCfgSis('CNPQUE'),fRetCGCEmpresa(VS_strCodEmp)), strCpfCnpjClienteQuest, fltValorPonto);
          fMensagem('ATENÇÃO!', RetornoToken.Mensagem, ['&Ok']);
          if not RetornoToken.Erro then
          begin
            intTentativas := 0;
            while (intTentativas < 3) do
            begin
              Inc(intTentativas);
              If ffrmSenha(strTokenQuest, 'Informe o token ou a senha') Then
              begin
                ResgateQuest.SenhaParticipante :=  strTokenQuest;
                strAutIncQuest := fEfetivouQuestFidelidade;
                if fEmptyStr(strAutIncQuest) and (intTentativas >= 3) then
                begin
                  pApagaModalidade;
                  edtValor.Value := edtValor.Value + fltValorDinheiro;
                end
                else
                begin
                  intTentativas := 3;
                end;
              end
              else
              begin
                intTentativas := 3;
                pApagaModalidade;
                edtValor.Value := edtValor.Value + fltValorDinheiro;
                strTokenQuest := '.';
              end;
            end;
          end;
        finally
          FreeAndNil(RetornoToken);
        end;
      end
      else
      begin
        if blnVAiResgatar then
        begin
          AcumulaQuest := TAcumula.Create;
          AcumulaQuest := fRetornaClasseAcumulaQuestCDS(IIF(not fEmptyStr(fCfgSis('CNPQUE')),fCfgSis('CNPQUE'),fRetCGCEmpresa(VS_strCodEmp)), strCpfCnpjClienteQuest, StrToFloatDef(edtTotGer.Text,0), cdsItensAdd);
          strAutIncQuest := fEfetivouQuestFidelidade;
        end;
      end;
    end;
  end;
end;

procedure TfrmFatConfOrcamentos.pVerificaCheckOut;
begin
  pDesligamentoInesperadoChkOut ;
end;

procedure TfrmFatConfOrcamentos.pVerificarPromocaoBrindes(strNumDoc, strEspDoc: String);
var
  dtaMin, dtaMax: TDateTime;
  blnPedeBrindes,
  blnApenasPromoVigente: Boolean;
  frmFatPromocaoBrindes : TfrmFatPromocaoBrindes;
begin
  blnApenasPromoVigente := (not fCfgSis('PEBRFA', varBoolean));

  If (TPromocaoBrindes.fTemPromocaoDeBrindeEmVigencia) And
     (TFatEmitirBrindePromocao.fClienteTemPontosParaBrindes(
      edtCodCli.Text, strNumDoc, strEspDoc, dtaMin, dtaMax, blnApenasPromoVigente)) Then
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
      Try
        pCriarFormularios(TfrmFatPromocaoBrindes, frmFatPromocaoBrindes);
        frmFatPromocaoBrindes.strOperador    := strCodOpe;
        frmFatPromocaoBrindes.edtCodCli.Text := edtCodCli.Text;
        frmFatPromocaoBrindes.edtNomCli.Text := edtNomCli.Text;
        frmFatPromocaoBrindes.edtNumDoc.Text := strNumDoc;
        frmFatPromocaoBrindes.edtEspDoc.Text := strEspDoc;
        frmFatPromocaoBrindes.mskDtaIni.Text := DateToStr(dtaMin);
        frmFatPromocaoBrindes.mskDtaFin.Text := DateToStr(dtaMax);
        frmFatPromocaoBrindes.edtCodEmp.Text := VS_strCodEmp;
        frmFatPromocaoBrindes.edtDesEmp.Text := fRetNomeEmpresa;
        frmFatPromocaoBrindes.ShowModal;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;
      pFreeAndNil(frmFatPromocaoBrindes);
    End;
  End;
end;

procedure TfrmFatConfOrcamentos.pVerificarUtilizacaoDoTecladoSEAT;
begin

  If Not TTecladoSEAT.fUtilizaIntegracaoComTecladoDeSatisfacaoSEAT(oaCaixa) Then
    Exit;

  If TTecladoSEAT.fDocumentoJaFoiAvaliado(edtNumOrc.Text, fCfgSis('ESPCFO', varString), fRetornaCodigoDaEmpresa) Then
    Exit;

  If Not Assigned(objTecladoSEAT) Then
    objTecladoSEAT := TTecladoSEAT.Create;

  If (objTecladoSEAT.Status in [stDefault, stConcluiu]) Then
  Begin
    objTecladoSEAT.pAddObserver(Self);
    objTecladoSEAT.pIniciarAvaliacao;
  End;

end;

function TfrmFatConfOrcamentos.fVerPendenciasTefCitel : Boolean;
var
  intContCartao: Integer;
begin
  Result := False;
  for intContCartao := 0 to  Length(arrCartoes) - 1 do
  begin
    if fVerificaUtilizouTEFCitel(arrCartoes[intContCartao].strViaCli, arrCartoes[intContCartao].strViaLoj) then
    begin
      if arrCartoes[intContCartao].strStatusCartao = 'P' then
      begin
        try
          pEstornaTransacaoPendente(False,
                                    arrCartoes[intContCartao].strDtaTra,
                                    arrCartoes[intContCartao].strHraTra,
                                    arrCartoes[intContCartao].strNumDoc,
                                    '');
        finally
          arrCartoes[intContCartao].strStatusCartao := 'C';
          Result := True;

          pGravaTransacaoEstornada(arrCartoes[intContCartao].strNumDoc,
                                   arrCartoes[intContCartao].strNumNsu,
                                   arrCartoes[intContCartao].strDtaTra,
                                   arrCartoes[intContCartao].strHraTra,
                                   strIncDoc,
                                   strTabela,
                                   arrCartoes[intContCartao].fltValDig,
                                   arrCartoes[intContCartao].strControle);
        end;
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
        Result := True;
      end;
    end;
  end;
end;

function TfrmFatConfOrcamentos.JaRecebidoEmPixOuPixAvulso: String;
begin
  Result := 'N';

  If cdsModalidades.Locate('CODFPG;PIX_AVULSO', VarArrayOf(['012', 'S']), []) Then
    Exit('S');

  If Assigned(fatVenda.DadosPixDaVenda.LstPixPago) Then
  Begin
    If fatVenda.DadosPixDaVenda.LstPixPago.Count > 0 Then
      Exit('S');
  End;
end;

procedure  TfrmFatConfOrcamentos.pCarregaTabelaDePrecoPorCnd;
var
  intIndice: integer;
  frmFatSelecaoTabelaPreco: TfrmFatSelecaoTabelaPreco;
begin
  If (Assigned(fatVenda)) Then
    If (fCfgSis('USACND', varBoolean))   And (fCfgSis('TBPCND', varBoolean)) And
       (fEmptyStr(VS_strTabPreCheckOut)) And (Not fEmptyStr(Trim(StringReplace(fatVenda.strCndTpm,'N','',[rfReplaceAll, rfIgnoreCase])))) And
       (qryFatGor.IsEmpty) and (not blnChamouTelaTabelaPreco) Then
    Begin
       strTabPrecoFat := fDevolveTabelaPrecoFaturamento(fatVenda.strCndTpm);
       if Length(strTabPrecoFat) > 1 then
       begin
         try
           pCriarFormularios(TfrmFatSelecaoTabelaPreco,frmFatSelecaoTabelaPreco);
           frmFatSelecaoTabelaPreco.cbbTabPre.Clear;
           frmFatSelecaoTabelaPreco.cbbTabPre.Items.Add('');
           for intIndice := 1 to Length(strTabPrecoFat) do
           begin
             frmFatSelecaoTabelaPreco.cbbTabPre.Items.Add(strTabPrecoFat[intIndice]);
           end;
           frmFatSelecaoTabelaPreco.cbbTabPre.ItemIndex := 0;
           frmFatSelecaoTabelaPreco.ShowModal;
           if frmFatSelecaoTabelaPreco.ModalResult = mrOk then
           begin
             strTabPrecoFat := frmFatSelecaoTabelaPreco.cbbTabPre.Text;
             blnChamouTelaTabelaPreco := True;
           end;
         finally
           pFreeAndNil(frmFatSelecaoTabelaPreco);
        end;
      end;

       If Assigned(frmCaixa) Then
         frmCaixa.strTabPre := strTabPrecoFat;
    End;
end;

procedure TfrmFatConfOrcamentos.pCarregaClienteAgrupamento;
  Var
    qryConCli: TUniQuery;
    arrClientes : TConsultasArray;
    chrKey : Char;
begin
  fatAgrupamento.blnGravaCtrTe := False;
  fatAgrupamento.strCodEmpTe   := '';
  fatAgrupamento.strTipEmiTe   := '';
  fatAgrupamento.strCodForTe   := '';
  fatAgrupamento.strPerEmpTe   := '';
  fatAgrupamento.strCndLib := '';

  If fEmptyStr(fatAgrupamento.strTabPre) Then
    fatAgrupamento.strTabPre := '1';

  qryConCli := fCriaQuery(Self);

  chrKey := '/';

  fPesqCliente(conCliSimples, Self, nil, nil, qryConCli, chrKey, arrClientes);

  With qryConCli Do
  Begin
    If (Not IsEmpty) Then
    Begin
      fatAgrupamento.blnPermFF := ((FieldByName('CLI_PERMFF').AsString = 'S') Or (FieldByName('CLI_PERMFV').AsString = 'S'));
      fatAgrupamento.strStReEs := FieldByName('CLI_STREES').AsString;
      fatAgrupamento.strPrStRe := FieldByName('CLI_PRSTRE').AsString;

      fatAgrupamento.strCodCli := FieldByName('CLI_CODCLI').AsString;                   // Cliente - Codigo
      fatAgrupamento.strCliOri := FieldByName('CLI_NOMCLI').AsString;                   //         - Nome Original
      fatAgrupamento.strCliNom := FieldByName('CLI_NOMCLI').AsString;                   //         - Nome

      fatAgrupamento.strCliNum := FieldByName('CLI_ENDNUM').AsString;                   //         - Numero
      fatAgrupamento.strCliCom := FieldByName('CLI_ENDCOM').AsString;                   //         - Complemento
      fatAgrupamento.strCliEnd := FieldByName('CLI_ENDERE').AsString + ', ' +
                                  FieldByName('CLI_ENDNUM').AsString + '  ' +           //         - Endereco
                                  FieldByName('CLI_ENDCOM').AsString;

      fatAgrupamento.strCliBai := FieldByName('CLI_BAIRRO').AsString;                   //         - Bairro
      fatAgrupamento.strCliCep := FieldByName('CLI_C_E_P_').AsString;                   //         - Cep
      fatAgrupamento.strCodCid := FieldByName('CLI_CODCID').AsString;                   //         - Cód. Cidade
      fatAgrupamento.strCliTel := FieldByName('CLI_FONE01').AsString;                   //         - Telefone
      fatAgrupamento.strCliEma := FieldByName('CLI_EMAIL3').AsString;                   //         - Email NFe
      fatAgrupamento.strCliEm2 := FieldByName('CLI_EMAIL2').AsString;                   //         - Email 2
      fatAgrupamento.strCluFid := FieldByName('CLI_CLUFID').AsString;                   //         - Clube Fidelidade
      fatAgrupamento.strCliFid := FieldByName('CLI_CLIFID').AsString;                   //         - Cliente Fidelidade
      fatAgrupamento.strCodObr := FieldByName('CLI_CODOBR').AsString;                   //         - Código Obra (Serviço)
      fatAgrupamento.strCodArt := FieldByName('CLI_CODART').AsString;                   //         - Código Art. (Serviço)
      fatAgrupamento.strCodCno := FieldByName('CLI_CODCNO').AsString;                   //         - Código CNO. (Serviço)
      fatAgrupamento.strInsImo := FieldByName('CLI_INSIMO').AsString;                   //         - Inscr.Imobiliária. (Serviço)
      fatAgrupamento.strCodCib := FieldByName('CLI_CODCIB').AsString;                   //         - Código CIB. (Serviço)
      fatAgrupamento.strCliFax := FieldByName('CLI_F_A_X_').AsString;                   //         - Fax

      fatAgrupamento.strCliCid := fRetNomCidade(fatAgrupamento.strCodCid);              // - Cidade
      fatAgrupamento.strCliEst := fRetNomCidade(fatAgrupamento.strCodCid, 1);           // - Estado

      fatAgrupamento.strCliAti := FieldByName('CLI_CODATI').AsString;                   //         - Atividade
      fatAgrupamento.blnConstr := (fAtividadeConstrutora(FieldByName('CLI_CODATI').AsString)); // Cliente construtora ????
      fatAgrupamento.strCli_Rg := FieldByName('CLI_NUMR_G').AsString;                   //         - RG
      fatAgrupamento.strCliCgc := FieldByName('CLI_C_G_C_').AsString;                   //         - CNPJ

      fatAgrupamento.strObserv := FieldByName('CLI_OBSERV').AsString;                   //         - Observações

      fatAgrupamento.strCliDAc := FieldByName('CLI_CODEAC').AsString;                   //         - Cobrar despesas acessórias do cliente

      fatAgrupamento.strRegFis := FieldByName('CLI_REGFIS').AsString;                   //         - Calcular as regras fiscais ( CFOP e impostos ) considerando endereço de entrega

      fatAgrupamento.blnCliFil := fatAgrupamento.fClienteFilialVenda(qryConCli.FieldByName('CLI_CODCLI').AsString);
      fatAgrupamento.fltFat_TE := fatAgrupamento.recDadCli.fltFat_TE;
      fatAgrupamento.strTEPREV := fatAgrupamento.recDadCli.strTEPREV;
      fatAgrupamento.strTEPPRO := fatAgrupamento.recDadCli.strTEPPRO;

      If fatAgrupamento.fCarregaValorBrutoParaAplicarDescontoProfissional Then
        fatAgrupamento.fltDescProfissional := fRetDescontoCliente(fatAgrupamento.strCliFat)
      Else
        fatAgrupamento.fltDescProfissional := fRetDescontoCliente(fatAgrupamento.strCodCli);

      fatAgrupamento.fltDescFidelidade   := fRetDescontoFidelidade(fatAgrupamento.strCodCli);

      fatAgrupamento.strEndCob := FieldByName('CLI_ENDCOB').AsString;
      fatAgrupamento.strBaiCob := FieldByName('CLI_BAICOB').AsString;
      fatAgrupamento.strCepCob := FieldByName('CLI_CEPCOB').AsString;
      fatAgrupamento.strCidCob := fRetNomCidade(FieldByName('CLI_CIDCOB').AsString);
      fatAgrupamento.strEstCob := fRetNomCidade(FieldByName('CLI_CIDCOB').AsString, 1);

      fatAgrupamento.strDif_ST := FieldByName('CLI_DIF_ST').AsString;
      fatAgrupamento.strSitP_C := FieldByName('CLI_SITP_C').AsString;
      fatAgrupamento.strSitPCP := FieldByName('CLI_SITPCP').AsString;
      fatAgrupamento.strMenP_C := FieldByName('CLI_MENP_C').AsString;
      fatAgrupamento.strDiferi := FieldByName('CLI_DIFERI').AsString;
      fatAgrupamento.fltRedIcmsCli := FieldByName('CLI_REDICM').AsFloat;

      fatAgrupamento.pProcessarDespesasOperacionaisComplementar(FieldByName('CLI_DESOPE').AsFloat);

      If fEmptyStr(FieldByName('CLI_CGCCPF').AsString) Then
        fatAgrupamento.intCgcCpf := 0
      Else
        fatAgrupamento.intCgcCpf := FieldByName('CLI_CGCCPF').AsInteger;                //         - CGC/CPF

      fatAgrupamento.strCliIes := FieldByName('CLI_I_E_S_').AsString;                   //         - Ins.Estadual
      fatAgrupamento.strCliImp := FieldByName('CLI_I_M_P_').AsString;                   //         - Insc. Municipal Produtor
      fatAgrupamento.strProRur := FieldByName('CLI_PRORUR').AsString;                   //         - Produtor Rural
      fatAgrupamento.strMicEmp := FieldByName('CLI_MICEMP').AsString;                   //         - MEI-Micro Empreendedor Individual
      fatAgrupamento.strCliOrg := FieldByName('CLI_ORGPUB').AsString;                   //         - Orgao Publico
      fatAgrupamento.strDesPis := FieldByName('CLI_DESPIS').AsString;                   //         - Orgao Publico
      fatAgrupamento.strZonFra := FieldByName('CLI_ZONFRA').AsString;                   //         - Zona Franca de Manaus
      fatAgrupamento.strDesZon := FieldByName('CLI_DESZON').AsString;                   //         - Desconto Especial Cliente Zona Franca
      fatAgrupamento.strCodZfm := FieldByName('CLI_SUFRAM').AsString;                   //         - Código Sufram
      fatAgrupamento.blnCliExportacaoIndireta := FieldByName('CLI_EXPIND').AsString = 'S';//- Cliente Exportação Indireta
      fatAgrupamento.strCodReg := FieldByName('CLI_CODREG').AsString;                   //         - Código da Região
      fatAgrupamento.strDesReg := fRetDesRegiao(FieldByName('CLI_CODREG').AsString);    //         - Descrição da Região
      fatAgrupamento.strCliCon := FieldByName('CLI_CONSUM').AsString;                   //         - Consumidor Final (S/N)
      fatAgrupamento.strCodRep := FieldbyName('CLI_CODREP').AsString;                   //         - Código do Representante
      fatAgrupamento.strNomRep := fRetNomVendRep(FieldbyName('CLI_CODREP').AsString);   //         - Nome do Representante

      if (fCfgSis('SIMPAU', varBoolean) and fCfgSis('RETIMP', varBoolean)) then
      begin
        fatAgrupamento.strRetPCo := 'N';                                                  //         - Retenção de Pis e Cofins
        fatAgrupamento.strRetIrf := 'N';                                                  //         - Retenção de IRPF
        fatAgrupamento.strCDesPI := 'N';                                                  //         - Retenção de Pis e Cofins
      end
      else
      begin
        fatAgrupamento.strRetPCo := FieldbyName('CLI_RETPCO').AsString;                   //         - Retenção de Pis e Cofins
        fatAgrupamento.strRetIrf := FieldbyName('CLI_RETIRF').AsString;                   //         - Retenção de IRPF
        fatAgrupamento.strCDesPI := FieldbyName('CLI_CDESPI').AsString;                   //         - Retenção de Pis e Cofins
      end;

      fatAgrupamento.strSitIPI := FieldByName('CLI_SITIPI').AsString;                   //         - Situação do IPI
      fatAgrupamento.strEnqIPI := FieldByName('CLI_ENQIPI').AsString;                   //         - Enquadramento do IPI
      fatAgrupamento.strMenIPI := FieldByName('CLI_MENIPI').AsString;                   //         - Mensagem do IPI
      fatAgrupamento.strRetIss := FieldbyName('CLI_RETISS').AsString;                   //         - Retenção de ISS
      fatAgrupamento.strOrPuRD := FieldbyName('CLI_ORPURD').AsString;                   //         - Tipo de Desconto (Rateio / Desconto)
      fatAgrupamento.strCalIcm := FieldbyName('CLI_CALICM').AsString;                   //         - Calcula Desconto de ICMS (Orgão Public)
      fatAgrupamento.fltRedIss := FieldbyName('CLI_REDISS').AsFloat;                    //         - Aliquota de ISS do Cliente (Prestcon)
      fatAgrupamento.strCobIss := FieldbyName('CLI_COBISS').AsString;                   //         - Cobrar Iss sobre (T)otal da Nota ou Total dos (S)erviços (Prestcon)
      fatAgrupamento.strSegSoc := FieldbyName('CLI_SEGSOC').AsString;                   //         - Seguridade Social

      fatAgrupamento.strPerEmp := FieldByName('CLI_PEREMP').AsString;                   //         - Permite Emprestimo
      fatAgrupamento.strCliPer := FieldByName('CLI_PERMUT').AsString;
      fatAgrupamento.strCalIcm := 'N';

      fatAgrupamento.pCarregaAliquotasRetencao;
      fatAgrupamento.pDefineSeClienteEmiteEnvioEstoqueExternoPeloAutcom;

    End;

  End;

  fatAgrupamento.objFazenda.pLimparDadosFazenda;

end;

procedure TfrmFatConfOrcamentos.btnAgruparPedidosClick(Sender: TObject);
var
  result: boolean;
  strPedAgrupado: String;

  function fCarregandoPedidoAgrupamento: Boolean;
  begin
    Try
      pCriarFormularios(TfrmGravando,frmGravando);
      frmGravando.fExecutarAcao := fCarregaAgrupamentoPedido;
      frmGravando.ShowModal;
      Result := frmGravando.blnConfirma;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message,'');
      End;
    End;

    pFreeAndNil(frmGravando);
  end;

  function fGravarPedidoAgrupamento: Boolean;
  begin
    Try
      pCriarFormularios(TfrmGravando,frmGravando);
      frmGravando.fExecutarAcao := fatAgrupamento.fGravaArquivos;
      frmGravando.ShowModal;
      Result := frmGravando.blnConfirma;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message,'');
      End;
    End;

    pFreeAndNil(frmGravando);
  end;

Begin
  If (InterlockedIncrement(intSemaforoConsulta) = 0) Then
  Begin
    Try
      pLimparTela;
      pCriarCdsVenda(Self);
      fatAgrupamento := TFatVenda.CreateInstance('CP', objResumoDeCaixa);
      Try
        pSetFunctionsEventosCadPro(fatAgrupamento);
        SetLength(arrTravasLibFinalVenda, 0);
        fatAgrupamento.strNomeForm    := 'frmFatVendas';
        fatAgrupamento.strEspDoc      := 'PD';
        fatAgrupamento.strOriGor      := 'AGRUPAMENTO';
        fatAgrupamento.blnImprimeDocs := False;
        fatAgrupamento.blnImprimeSep  := False;
        fatAgrupamento.blnAgrupamentoPedidos := True;
        fatAgrupamento.strCodigoCaixa   := strCodigoCaixa;

        pCarregaClienteAgrupamento;

        If fEmptyStr(fatAgrupamento.strCodCli) Then
        Begin
          InterlockedDecrement(intSemaforoConsulta);
          pLimparTela;
          Exit;
        End;

        Try
          pCriarFormularios(TfrmFatConfPedidos, frmFatConfPedidos);
          frmFatConfPedidos.fatVenda := fatAgrupamento;
          frmFatConfPedidos.ShowModal;

          fatAgrupamento := frmFatConfPedidos.fatVenda;
          fatAgrupamento.strConfSer := frmFatConfPedidos.strTemSer;

          If (VS_strTipExp = '4') Then
          Begin
            fatAgrupamento.strOpeExp := frmFatConfPedidos.strOpeExp;
            fatAgrupamento.strSepExp := frmFatConfPedidos.strSepExp;
          End;

          Result := frmFatConfPedidos.blnConfirma;
        Finally
          pFreeAndNil(frmFatConfPedidos);
        End;

        If Result Then
        Begin
          If fCarregandoPedidoAgrupamento Then
          Begin
            untFatGor.intSeqFdo := 1;
            If fGravarPedidoAgrupamento Then
            Begin
              strPedAgrupado := fatAgrupamento.strNumDoc;
              pLimparTela;
              edtNumOrc.Text := strPedAgrupado;
              fValidaCampos(edtNumOrc);
            End;
          End;
        End;
      Finally
        pSetFunctionsEventosCadProFatVenda;
      End;

      InterlockedDecrement(intSemaforoConsulta);
    Except
      InterlockedDecrement(intSemaforoConsulta);
      pLimparTela;
    End;
  End
  Else
    InterlockedDecrement(intSemaforoConsulta);
end;

function TfrmFatConfOrcamentos.fCarregaAgrupamentoPedido(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    arrDatas: TDateArray;
    blnMostraDigDuplic: Boolean;

    strSQL: String;
    strItemAnt: String;
    strGrupoAnt: String;
    fltUnitarioEmb: Double;
    intContServico: Integer;
    intContador: Integer;
    strOpcDoc: String;

    qryGenIte : TUniQuery;
    qryGenDor : TUniQuery;
    qryGenGor : TUniQuery;

    recItemPedido: TRecItemPedido;
    arrItemPedidos: TArrItemPedidos;

    blnSintetiza: Boolean;

    matrizSaldosAux: TClassMatrizSaldosColorantes;
    blnEntSav: Boolean;
    blnLocFor: Boolean;

    recMadeira: TDadosMadeira;
    fltCusIte: Double;
    blnPegEndEnt: Boolean;
    blnPegMsg: Boolean;
    impSubIteEst: TImpostosSubItensEstrutura;
    fltOutValIte,
    fltDesOpeIte,
    fltIcmSaiIte,
    fltImpFedIte: Double;
    fltItePreVe1,
    fltItePreVe2,
    fltItePreVe3,
    fltItePreVe4,
    fltItePreVe5,
    fltItePreVe6,
    fltItePreVe7: Double;
    fltUniDigDescontada: Double;

    intPraMedio: Integer;

    fltProPreCus: Double;
    fltProPreVen: Double;
    fltProComVar: Double;
    fltProComAta: Double;
    fltProComDis: Double;
    fltQtdDis   : Double;
    fltProDesF07: Double;

    strTabPreIte: String;
    strCodCndTmp: String;
    strPromocao : String;

    blnParticiona: Boolean;
    blnPromo     : Boolean;

    blnPesPed   : Boolean;
    fltPesBruTmp: Double;
    fltPesLiqTmp: Double;

    strCodTraSav : String;

    fltImcSTPV : Double;
    blnCalcST : Boolean;

    recForTin: TForTin;
    qryCadUni: TUniQuery;
    strMensagens: string;
    strMen001_: string;
    strMen002_: string;
    strMen003_: string;
    strMen004_: string;
    strMen005_: string;

    function fRetEmpresaItem: String;
    Begin
      Result := IIF(fEmptyStr(qryGenDor.FieldByName('FDO_EMPITE').AsString), VS_strCodEmp, qryGenDor.FieldByName('FDO_EMPITE').AsString);
    End;

    procedure pInformacao(strMsg: String);
    begin
      If Assigned(pgbStatus) Then
        TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strMsg;
      pProcessMessages;
    end;

    procedure pProgress(intPos, intMax: Integer);
    Begin
      If Assigned(pgbStatus) Then
      Begin
        pgbStatus.Properties.Max := intMax;
        pgbStatus.Position := intPos;
        pProcessMessages;
      End;
    End;

    procedure pCalculaFreteDespDescPagAntConfPedidos;
      Var
        cdsItens: TUniClientDataSet;
        stlDocsFre: TStringList;
        qryGenGor: TUniQuery;
        fltDesCal: Double;
        strChaveDoc: String;
    begin
      {*****************************************}
      {* CALCULA O DESC. ESPECIAL PROPORCIONAL *}
      {* OBS: MELHORAR ESSA PARTE DO FRETE.    *}
      {**************************************MV*}
      cdsItens  := TUniClientDataSet.Create(Self);
      qryGenGor := fCriaQuery(Self);

      fatAgrupamento.fltPorDes := 0.0;//Unitario do item ja esta liquido, nao deve aplicar o desconto novamente
      fatAgrupamento.fltDesEsp := 0;
      fatAgrupamento.fltValFre := 0;
      fatAgrupamento.fltFreDig := 0;

      pCloneDataSet(cdsItens, cdsVenda);
      stlDocsFre := TStringList.Create;

      cdsItens.First;
      While (Not cdsItens.Eof) Do
      Begin
        If strOpcDoc = 'CP' Then
        Begin
          strChaveDoc := cdsItens.FieldByName('ITE_NUMORC').AsString +
                         cdsItens.FieldByName('ITE_ESPORC').AsString +
                         cdsItens.FieldByName('ITE_EMPORC').AsString;

          If (stlDocsFre.IndexOf(strChaveDoc) < 0) Then
          Begin
            stlDocsFre.Add(strChaveDoc);

            qryGenGor.Close;
            qryGenGor.SQL.Clear;
            qryGenGor.SQL.Add('SELECT ');
            qryGenGor.SQL.Add('  FGO_CODTRA, ');
            qryGenGor.SQL.Add('  FGO_FRERAT, ');
            qryGenGor.SQL.Add('  FGO_TOTFRE - FGO_FREBAI AS FGO_VALFRE, ');
            qryGenGor.SQL.Add('  FGO_PORDES, ');
            qryGenGor.SQL.Add('  FGO_TIPFRE  ');
            qryGenGor.SQL.Add('FROM ');
            qryGenGor.SQL.Add('  FATGOR ');
            qryGenGor.SQL.Add('  INNER JOIN EXTGOR ON FGO_SEQFGO = AUTOINCREM ');
            qryGenGor.SQL.Add('WHERE ');
            qryGenGor.SQL.Add('  FGO_NUMDOC = :NUMDOC AND ');
            qryGenGor.SQL.Add('  FGO_ESPDOC = :ESPDOC AND ');
            qryGenGor.SQL.Add('  FGO_CODEMP = :CODEMP ');

            qryGenGor.ParamByName('NUMDOC').AsString := cdsItens.FieldByName('ITE_NUMORC').AsString;
            qryGenGor.ParamByName('ESPDOC').AsString := cdsItens.FieldByName('ITE_ESPORC').AsString;
            qryGenGor.ParamByName('CODEMP').AsString := cdsItens.FieldByName('ITE_EMPORC').AsString;
            qryGenGor.Open;

            fatAgrupamento.fltValFre := fatAgrupamento.fltValFre + qryGenGor.FieldByName('FGO_VALFRE').AsFloat;
            fatAgrupamento.fltFreDig := fatAgrupamento.fltFreDig + qryGenGor.FieldByName('FGO_VALFRE').AsFloat;

            If fRateiaFreteItensTransportadora(qryGenGor.FieldByName('FGO_CODTRA').AsString, qryGenGor.FieldByName('FGO_TIPFRE').AsString) And (qryGenGor.FieldByName('FGO_FRERAT').AsFloat > 0) Then
            Begin
              fatAgrupamento.fltValFre := fatAgrupamento.fltValFre + qryGenGor.FieldByName('FGO_FRERAT').AsFloat;
              fatAgrupamento.fltFreDig := fatAgrupamento.fltFreDig + qryGenGor.FieldByName('FGO_FRERAT').AsFloat;
            End;
          End;

          fatAgrupamento.fltPorDes := qryGenGor.FieldByName('FGO_PORDES').AsFloat;

          fltDesCal := fatAgrupamento.fCalcDescEspecialItemConfPed( cdsItens.FieldByName('ITE_QTDORI').AsFloat,
                                                              cdsItens.FieldByName('ITE_QTDBAI').AsFloat,
                                                              cdsItens.FieldByName('ITE_QTDITE').AsFloat,
                                                              cdsItens.FieldByName('ITE_DESESP').AsFloat,
                                                              cdsItens.FieldByName('ITE_DESBAI').AsFloat );

          If (fatAgrupamento.fltDesSai = 0) Then
          Begin
            If cdsVenda.Locate('ITE_SEQDET', cdsItens.FieldByName('ITE_SEQDET').AsString, []) Then
            Begin
              cdsVenda.Edit;
              cdsVenda.FieldByName('ITE_DESEXP').AsFloat := fltDesCal;
              cdsVenda.Post;
            End;
          End;

          fatAgrupamento.fltDesEsp := fatAgrupamento.fltDesEsp + fltDesCal;
        End;

        cdsItens.Next;
      End;

      FreeAndNil(stlDocsFre);
      FreeAndNil(qryGenGor);
      FreeAndNil(cdsItens);

      fatAgrupamento.pSintetizaPedidosPagAnt;
    end;


begin
  pInformacao('Carregando Produtos, Aguarde....');
  strOpcDoc := 'CP';

  qryGenIte := fCriaQuery(Self);
  qryGenDor := fCriaQuery(Self);
  qryGenGor := fCriaQuery(Self);

  strItemAnt  := '';
  strGrupoAnt := '';
  strMensagens := '';
  strMen001_ := '';
  strMen002_ := '';
  strMen003_ := '';
  strMen004_ := '';
  strMen005_ := '';

  fatAgrupamento.fltPorDes := 0.0;//Unitario do item ja esta liquido, nao deve aplicar o desconto novamente
  fatAgrupamento.fltDesEsp := 0.0;
  fatAgrupamento.fltValFre := 0.0;
  intContServico := 1;

  blnPesPed := fPermiteInformarPesoNoPedidoDeVenda;

  SetLength(fatAgrupamento.arrPedidosConf, 0);
  SetLength(fatAgrupamento.arrPedidosServAgrupados, 0);

  (**************************************************************************)
  (* VAI SOMAR TODOS OS DESCONTOS EM VALOR DO PEDIDO.                       *)
  (* OS PEDIDOS COM DESCONTO EM VALOR NAO PODEM SER FATURADOS PARCIALMENTE. *)
  (* OS DESCONTOS EM PERCENTUAL SERAO CALCULADOS ITEM A ITEM.               *)
  (***********************************************************************LA*)
  strSQL := '';
  strSQL := strSQL + ' SELECT                                                                          ';
  strSQL := strSQL + '   FGO_ENT_CD                                                                    ';
  strSQL := strSQL + '   , D.FDO_NUMDOC                                                                ';
  strSQL := strSQL + '   , D.FDO_ESPDOC                                                                ';
  strSQL := strSQL + '   , D.FDO_CODEMP                                                                ';
  strSQL := strSQL + '   , D.FDO_EMPITE                                                                ';
  strSQL := strSQL + '   , FDO_EMPDMP                                                                  ';
  strSQL := strSQL + '   , D.FDO_BXSBIT                                                                ';
  strSQL := strSQL + '   , D.FDO_ORDPRO                                                                ';
  strSQL := strSQL + '   , D.FDO_IDEPRO                                                                ';
  strSQL := strSQL + '   , GRU_CODGRU                                                                  ';
  strSQL := strSQL + '   , D.FDO_CODITE                                                                ';
  strSQL := strSQL + '   , D.FDO_DESCRI                                                                ';
  strSQL := strSQL + '   , D.FDO_UNIDAD                                                                ';
  strSQL := strSQL + '   , D.FDO_UNIDAD                                                                ';
  strSQL := strSQL + '   , D.FDO_CODMAR                                                                ';
  strSQL := strSQL + '   , D.FDO_FORITE                                                                ';
  strSQL := strSQL + '   , D.FDO_REFERE                                                                ';
  strSQL := strSQL + '   , D.FDO_UNIORI                                                                ';
  strSQL := strSQL + '   ,   FDO_UNIVIS                                                                ';
  strSQL := strSQL + '   ,   FDO_TAXJUR                                                                ';
  strSQL := strSQL + '   ,   FDO_VAL_RT                                                                ';
  strSQL := strSQL + '   , D.FDO_UNITAR                                                                ';
  strSQL := strSQL + '   , D.FDO_UNITAR                                                                ';
  strSQL := strSQL + '   , D.FDO_DESCON                                                                ';
  strSQL := strSQL + '   , D.FDO_JAFATU                                                                ';
  strSQL := strSQL + '   , (D.FDO_QTDITE - D.FDO_QTDBAI) AS FDO_QTDITE                                 ';
  strSQL := strSQL + '   , (D.FDO_QTDITE - D.FDO_QTDBAI) * D.FDO_UNITAR AS FDO_TOTITE                  ';
  strSQL := strSQL + '   , (D.FDO_TOTCUS / D.FDO_QTDITE) * (D.FDO_QTDITE - D.FDO_QTDBAI) AS FDO_TOTCUS ';
  strSQL := strSQL + '   , (D.FDO_TOTCU2 / D.FDO_QTDITE) * (D.FDO_QTDITE - D.FDO_QTDBAI) AS FDO_TOTCU2 ';
  strSQL := strSQL + '   , (D.FDO_VALIPI / D.FDO_QTDITE) * (D.FDO_QTDITE - D.FDO_QTDBAI) AS FDO_VALIPI ';

  strSQL := strSQL + '   , ITE_INCPIS                                                                  ';
  strSQL := strSQL + '   , D.FDO_PREEMB                                                                ';
  strSQL := strSQL + '   , D.FDO_TOTPES                                                                ';
  strSQL := strSQL + '   ,   FDO_PESLIQ                                                                ';
  strSQL := strSQL + '   , D.FDO_PROMOC                                                                ';
  strSQL := strSQL + '   , D.FDO_CLAFIS                                                                ';
  strSQL := strSQL + '   , D.FDO_CODEMP                                                                ';
  strSQL := strSQL + '   , D.FDO_QTDEMB                                                                ';
  strSQL := strSQL + '   , D.FDO_PREEMB                                                                ';
  strSQL := strSQL + '   , D.FDO_ESPDOC                                                                ';
  strSQL := strSQL + '   , D.FDO_SEQTIN                                                                ';
  strSQL := strSQL + '   , D.FDO_SEQIND                                                                ';
  strSQL := strSQL + '   , D.FDO_QTDBAI                                                                ';
  strSQL := strSQL + '   , D.FDO_UNIDIG                                                                ';
  strSQL := strSQL + '   , D.FDO_COMPLE                                                                ';
  strSQL := strSQL + '   , D.FDO_TABPRE                                                                ';
  strSQL := strSQL + '   , D.FDO_ITETIN                                                                ';
  strSQL := strSQL + '   , D.FDO_LAZQUA                                                                ';
  strSQL := strSQL + '   , D.FDO_VOLPRO                                                                ';
  strSQL := strSQL + '   , D.FDO_TIPPRE                                                                ';
  strSQL := strSQL + '   , D.FDO_SEQGER                                                                ';
  strSQL := strSQL + '   , D.FDO_ENTFUT                                                                ';
  strSQL := strSQL + '   , D.FDO_MOTFUT                                                                ';
  strSQL := strSQL + '   , FDO_ENTRET                                                                  ';
  strSQL := strSQL + '   , FDO_LOCRET                                                                  ';
  strSQL := strSQL + '   , FDO_DTENTR                                                                  ';
  strSQL := strSQL + '   , D.FDO_QTDITE AS FDO_QTDORI                                                  ';
  strSQL := strSQL + '   , D.FDO_DESBAI                                                                ';
  strSQL := strSQL + '   , D.FDO_DESESP                                                                ';
  strSQL := strSQL + '   , FGO_VLRCON AS FGO_TOTPED                                                    ';
  strSQL := strSQL + '   , FGO_CODFPG                                                                  ';
  strSQL := strSQL + '   , FGO_PANUTI                                                                  ';
  strSQL := strSQL + '   , FGO_TOTFRE                                                                  ';
  strSQL := strSQL + '   , FGO_DESESP                                                                  ';
  strSQL := strSQL + '   , D.FDO_KEY_EP                                                                ';
  strSQL := strSQL + '   , D.FDO_NUMLOT                                                                ';
  strSQL := strSQL + '   , D.FDO_EMPPRD                                                                ';
  strSQL := strSQL + '   , D.FDO_LINLIN                                                                ';
  strSQL := strSQL + '   , D.FDO_CATALI                                                                ';
  strSQL := strSQL + '   , D.FDO_QTDITE                                                                ';
  strSQL := strSQL + '   , D.FDO_CODDIL                                                                ';
  strSQL := strSQL + '   , D.FDO_PORDIL                                                                ';
  strSQL := strSQL + '   , D.FDO_DILCON                                                                ';
  strSQL := strSQL + '   , D.FDO_PORCAT                                                                ';
  strSQL := strSQL + '   , FOR_TIPCOR                                                                  ';
  strSQL := strSQL + '   , FOR_TEXBAS                                                                  ';
  strSQL := strSQL + '   , FOR_MODDIL                                                                  ';
  strSQL := strSQL + '   , FOR_ITECOB                                                                  ';
  strSQL := strSQL + '   , FOR_CATALI                                                                  ';
  strSQL := strSQL + '   , FOR_UNIVER                                                                  ';
  strSQL := strSQL + '   , D.FDO_ITEEMB                                                                ';
  strSQL := strSQL + '   , D.AUTOINCREM                                                                ';
  strSQL := strSQL + '   , D.FDO_CODVEN                                                                ';
  strSQL := strSQL + '   , D.FDO_CODVE2                                                                ';
  strSQL := strSQL + '   , FDO_ALTPCO                                                                  ';
  strSQL := strSQL + '   , D.FDO_PERCOM                                                                ';
  strSQL := strSQL + '   , FGO_TIPFIN                                                                  ';
  strSQL := strSQL + '   , FGO_DESFIN                                                                  ';
  strSQL := strSQL + '   , D.FDO_CODACA                                                                ';
  strSQL := strSQL + '   , D.FDO_EMPACA                                                                ';
  strSQL := strSQL + '   , D.FDO_PROACA                                                                ';
  strSQL := strSQL + '   , D.FDO_TIPEMB                                                                ';
  strSQL := strSQL + '   , FDO_QTDEXP                                                                  ';
  strSQL := strSQL + '   , FDO_NUMCMP                                                                  ';
  strSQL := strSQL + '   , FDO_NITCMP                                                                  ';
  strSQL := strSQL + '   , FDO_DTACMP                                                                  ';
  strSQL := strSQL + '   , FOR_FATACE                                                                  ';
  strSQL := strSQL + '   , FGO_PLAVEI                                                                  ';
  strSQL := strSQL + '   , FGO_KM_VEI                                                                  ';
  strSQL := strSQL + '   , EXTDOR.FDO_CLIBUS                                                           ';
  strSQL := strSQL + '   , EXTDOR.FDO_TURENT                                                           ';
  strSQL := strSQL + '   , D.FDO_PRCTIN                                                                ';
  strSQL := strSQL + '   , FDO_LOTABA                                                                  ';
  strSQL := strSQL + '   , FGO_FASOBR                                                                  ';
  strSQL := strSQL + '   ,IF( IFNULL(FDO_TABPRE, "") = "", FGO_TABPRE, FDO_TABPRE) AS TABPRE           ';
  strSQL := strSQL + '   , D.FDO_CODCND                                                                ';
  strSQL := strSQL + '   , D.FDO_CONPAG                                                                ';
  strSQL := strSQL + '   , D.FDO_PERREP                                                                ';
  strSQL := strSQL + '   , D.FDO_SEQGER                                                                ';
  strSQL := strSQL + '   , FDO_ATIVAC                                                                  ';
  strSQL := strSQL + '   , FDO_SEQCOM                                                                  ';
  strSQL := strSQL + '   , FDO_SEQEST ';
  strSQL := strSQL + '   , FDO_ITEEST ';
  strSQL := strSQL + '   , FDO_UNIEST ';
  strSQL := strSQL + '   , FDO_QTDSBI ';
  strSQL := strSQL + '   , FDO_UNISBI ';
  strSQL := strSQL + '   , FDO_FREMKP ';
  strSQL := strSQL + '   , FDO_COMMKP ';
  strSQL := strSQL + '   , IF(IFNULL(BRI_SEQDET, "N") = "N", "N", "S") AS FDO_BRINDE                   ';
  strSQL := strSQL + '   , BRI_CODPAR                                                                  ';
  strSQL := strSQL + '   , BRI_TIPBRI                                                                  ';
  strSQL := strSQL + '   , D.FDO_CODFIS                                                                ';
  strSQL := strSQL + '   , TD.*                                                                        ';
  strSQL := strSQL + ' FROM                                                                            ';
  strSQL := strSQL + '   FATDOR D                                                                      ';
  strSQL := strSQL + '   JOIN FATGOR                                                                   ';
  strSQL := strSQL + '     ON FGO_NUMDOC = D.FDO_NUMDOC                                                ';
  strSQL := strSQL + '     AND FGO_ESPDOC = D.FDO_ESPDOC                                               ';
  strSQL := strSQL + '     AND FGO_CODEMP = D.FDO_CODEMP                                               ';
  strSQL := strSQL + '     AND FGO_CODCLI = D.FDO_CODCLI                                               ';
  strSQL := strSQL + '   JOIN EXTGOR                                                                   ';
  strSQL := strSQL + '     ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM                                    ';
  strSQL := strSQL + '   JOIN CADITE                                                                   ';
  strSQL := strSQL + '     ON ITE_CODITE = D.FDO_CODITE                                                ';
  strSQL := strSQL + '   JOIN CADGRU                                                                   ';
  strSQL := strSQL + '     ON GRU_CODGRU = ITE_CODGRU                                                  ';
  strSQL := strSQL + '   LEFT JOIN FORTIN                                                              ';
  strSQL := strSQL + '     ON D.FDO_CODACA = FOR_CODACA                                                ';
  strSQL := strSQL + '     AND D.FDO_EMPACA = FOR_EMPACA                                               ';
  strSQL := strSQL + '   LEFT JOIN EXTDOR                                                              ';
  strSQL := strSQL + '     ON EXTDOR.FDO_SEQFDO = D.AUTOINCREM                                         ';
  strSQL := strSQL + '   LEFT JOIN BRIDOR                                                              ';
  strSQL := strSQL + '     ON BRI_SEQDET = D.AUTOINCREM                                                ';

  strSQL := strSQL + '   LEFT JOIN TINDOR TD                                                           ';
  strSQL := strSQL + '     ON D.FDO_NUMDOC = TD.FDO_NUMDOC                                             ';
  strSQL := strSQL + '     AND D.FDO_ESPDOC = TD.FDO_ESPDOC                                            ';
  strSQL := strSQL + '     AND D.FDO_CODEMP = TD.FDO_CODEMP                                            ';
  strSQL := strSQL + '     AND D.FDO_CODACA = TD.FDO_CODACA                                            ';
  strSQL := strSQL + '     AND D.FDO_EMPACA = TD.FDO_EMPACA                                            ';
  strSQL := strSQL + ' WHERE D.FDO_PROEMB <> "S"                                                       ';
  strSQL := strSQL + '   AND D.FDO_QTDBAI < D.FDO_QTDITE                                               ';
  strSQL := strSQL + '   AND D.FDO_NUMDOC = :NUMDOC                                                    ';
  strSQL := strSQL + '   AND D.FDO_ESPDOC = :ESPDOC                                                    ';
  strSQL := strSQL + '   AND D.FDO_CODEMP = :CODEMP                                                    ';
  strSQL := strSQL + ' ORDER BY D.AUTOINCREM                                                           ';

  {*****************************************}
  {* DOCUMENTO DETALHADO                   *}
  {**************************************MV*}
  With qryGenDor Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  I.ITE_CODGRU, ';
  strSQL := strSQL + '  I.ITE_DESITE, ';
  strSQL := strSQL + '  I.ITE_DESSIM, ';
  strSQL := strSQL + '  I.ITE_DESFAB, ';
  strSQL := strSQL + '  I.ITE_COMLUB, ';
  strSQL := strSQL + '  I.ITE_CLAIPI, ';
  strSQL := strSQL + '  I.ITE_EXCIPI, ';
  strSQL := strSQL + '  I.ITE_CODFAB, ';
  strSQL := strSQL + '  I.ITE_CODBAR, ';
  strSQL := strSQL + '  G.ITE_OUTVAL, ';
  strSQL := strSQL + '  G.ITE_IMPFED, ';
  strSQL := strSQL + '  G.ITE_ICMSAI, ';
  strSQL := strSQL + '  G.ITE_DESOPE, ';
  strSQL := strSQL + '  G.ITE_PREULT, ';
  strSQL := strSQL + '  G.ITE_IMPULT, ';
  strSQL := strSQL + '  G.ITE_QTDUCO, ';
  strSQL := strSQL + '  G.ITE_PRECUS, ';

  strSQL := strSQL + '  G.ITE_PREVE1, ';
  strSQL := strSQL + '  G.ITE_PREVE2, ';
  strSQL := strSQL + '  G.ITE_PREVE3, ';
  strSQL := strSQL + '  G.ITE_PREVE4, ';
  strSQL := strSQL + '  G.ITE_PREVE5, ';
  strSQL := strSQL + '  G.ITE_PREVE6, ';
  strSQL := strSQL + '  G.ITE_PREVE7, ';

  strSQL := strSQL + '  G.ITE_COMTB1, ';
  strSQL := strSQL + '  G.ITE_COMTB2, ';
  strSQL := strSQL + '  G.ITE_COMTB3, ';
  strSQL := strSQL + '  G.ITE_COMTB4, ';
  strSQL := strSQL + '  G.ITE_COMTB5, ';
  strSQL := strSQL + '  G.ITE_COMTB6, ';
  strSQL := strSQL + '  G.ITE_COMTB7, ';

  strSQL := strSQL + '  G.ITE_IPISAI, ';
  strSQL := strSQL + '  G.ITE_DESMAX, ';
  strSQL := strSQL + '  G.ITE_DESMGE, ';
  strSQL := strSQL + '  G.ITE_DESMSU, ';
  strSQL := strSQL + '  G.ITE_SALDOS, ';
  strSQL := strSQL + '  G.ITE_PREMED, ';
  strSQL := strSQL + '  G.ITE_COMVAR, ';
  strSQL := strSQL + '  G.ITE_COMATA, ';
  strSQL := strSQL + '  G.ITE_COMDIS, ';
  strSQL := strSQL + '  G.ITE_COMDIG, ';
  strSQL := strSQL + '  G.ITE_MARMIN, ';
  strSQL := strSQL + '  G.ITE_MARMSG, ';
  strSQL := strSQL + '  G.ITE_MARMGE, ';

  strSQL := strSQL + '  G.ITE_DESMVM, ';
  strSQL := strSQL + '  G.ITE_DESMSM, ';
  strSQL := strSQL + '  G.ITE_DESMGM, ';

  strSQL := strSQL + '  G.ITE_MARMMV, ';
  strSQL := strSQL + '  G.ITE_MARMMS, ';
  strSQL := strSQL + '  G.ITE_MARMMG, ';

  strSQL := strSQL + '  G.ITE_IPIENT, ';
  strSQL := strSQL + '  G.ITE_FREENT, ';
  strSQL := strSQL + '  G.ITE_QTPPRO, ';
  strSQL := strSQL + '  G.ITE_LOCFIS, ';
  strSQL := strSQL + '  A.ABF_CODABF, ';
  strSQL := strSQL + '  I.ITE_PESOIT, ';
  strSQL := strSQL + '  I.ITE_PESLIQ, ';
  strSQL := strSQL + '  I.ITE_OBRCPF, ';
  strSQL := strSQL + '  I.ITE_EMBALA, ';
  strSQL := strSQL + '  G.ITE_PRECOM, ';

  If fCfgSis('IMPDIG') = '1' Then
    strSQL := strSQL + '  I.ITE_IMPDIR  '
  Else
    strSQL := strSQL + '  G.ITE_IMPDIR  ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I, ';
  strSQL := strSQL + '  ITEGER G, ';
  strSQL := strSQL + '  ABFICM A ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';

  If fCfgSis('TIPABF') = '1' Then
    strSQL := strSQL + '  I.ITE_CODABF = A.ABF_CODABF AND '
  Else
    strSQL := strSQL + '  G.ITE_CODABF = A.ABF_CODABF AND ';

  strSQL := strSQL + '  I.ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  A.ABF_ESTADO = :ESTADO ';

  {*****************************************}
  {* PREPARA A QUERY PARA RETORNAR DADOS   *}
  {* DO ITEM E DA ABREVIAÇÃO FISCAL        *}
  {**************************************MV*}
  With qryGenIte Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
  End;

  Try
    Screen.Cursor        := crHourGlass;

    With fatAgrupamento.qryTemporariaConfirmacao Do
    Begin

      First;
      blnPegMsg := True;
      blnPegEndEnt := True;
      fatAgrupamento.strPlaVei := '';
      fatAgrupamento.strKm_Vei := '';

      While (Not Eof) Do
      Begin
        {*************************************************************************}
        {* SE FOR PEDIDO DE BAIXA DE ENTREGA FUTURA, DEVE BAIXAR A QTD. ENTREGUE *}
        {* E BAIXAR OS DOCUMENTOS DE ENTREGA FUTURA CORRESPONDENTES              *}
        {**********************************************************************MM*}
        If (strOpcDoc = 'CP') And (Assigned(FindField('TMP_BENFUT'))) And (FieldByName('TMP_BENFUT').AsString = 'S') Then
        Begin
          If (Not Assigned(fatAgrupamento.dicDesEspItens)) Then
            fatAgrupamento.dicDesEspItens := TDicionario.Create;

          fatAgrupamento.blnBaiEntFut := True;
          fatAgrupamento.pAdicionaItensDaBaixaDeEntregaFutura(FieldByName('TMP_AUTINC').AsString);
        End
        Else
        Begin
          fatAgrupamento.blnBaiEntFut := False;
          If (Assigned(fatAgrupamento.cdsBaiEntFut)) Then
            fatAgrupamento.cdsBaiEntFut.EmptyDataSet;
        End;

        If fEmptyStr(fatAgrupamento.strFasObr) Then
          fatAgrupamento.strFasObr := FieldByName('TMP_FASOBR').AsString;

        if (not fEmptyStr(fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN001').AsString.Trim)) then
        begin
          strMen001_ := strMen001_ + IIF(strMen001_.Length > 0 , '; ', '') +
                              fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN001').AsString.Trim;

          strMensagens := strMensagens + IIF(strMensagens.Length > 0 , '; ', '') +
                              fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN001').AsString.Trim;
        end;

        if (not fEmptyStr(fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN002').AsString.Trim)) then
        begin
          strMen002_ := strMen002_ + IIF(strMen002_.Length > 0 , '; ', '') +
                              fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN002').AsString.Trim;

          strMensagens := strMensagens + IIF(strMensagens.Length > 0 , '; ', '') +
                              fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN002').AsString.Trim;
        end;

        if (not fEmptyStr(fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN003').AsString.Trim)) then
        begin
          strMen003_ := strMen003_ + IIF(strMen003_.Length > 0 , '; ', '') +
                              fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN003').AsString.Trim;

          strMensagens := strMensagens + IIF(strMensagens.Length > 0 , '; ', '') +
                              fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN003').AsString.Trim;
        end;

        if (not fEmptyStr(fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN004').AsString.Trim)) then
        begin
          strMen004_ := strMen004_ + IIF(strMen004_.Length > 0 , '; ', '') +
                              fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN004').AsString.Trim;

          strMensagens := strMensagens + IIF(strMensagens.Length > 0 , '; ', '') +
                              fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN004').AsString.Trim;
        end;

        if (not fEmptyStr(fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN005').AsString.Trim)) then
        begin
          strMen005_ := strMen005_ + IIF(strMen005_.Length > 0 , '; ', '') +
                              fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN005').AsString.Trim;

          strMensagens := strMensagens + IIF(strMensagens.Length > 0 , '; ', '') +
                              fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN005').AsString.Trim;
        end;

        {******************************************}
        {* PEGA AS MENSAGENS DO PRIMEIRO REGISTRO *}
        {* QUE POSSUI MENSAGENS GRAVADAS.         *}
        {***************************************PZ*}
        If (blnPegMsg) And
           ((Not fEmptyStr(FieldByName('TMP_MENEXP').AsString)) Or
            (Not fEmptyStr(FieldByName('TMP_MENEX2').AsString)) Or
            (Not fEmptyStr(FieldByName('TMP_MENEX3').AsString)) Or
            (Not fEmptyStr(FieldByName('TMP_MENEX4').AsString))) Then
        Begin
          fatAgrupamento.strMenExp := FieldByName('TMP_MENEXP').AsString;
          fatAgrupamento.strMenEx2 := FieldByName('TMP_MENEX2').AsString;
          fatAgrupamento.strMeneX3 := FieldByName('TMP_MENEX3').AsString;
          fatAgrupamento.strMeneX4 := FieldByName('TMP_MENEX4').AsString;
          blnPegMsg := False;
        End;

        If (fCfgSis('SUJROM') = 'S') And
           (blnPegEndEnt) Then
        Begin
          fatAgrupamento.pCarregaEnderecoEntrega(fatAgrupamento,
                                           FieldByName('TMP_NOMTAB').AsString,
                                           FieldByName('TMP_AUTINC').AsString,
                                           True);

          blnPegEndEnt := fEmptyStr(fatAgrupamento.strEndEnt);

          If Not blnPegEndEnt Then
            fatAgrupamento.blnEndEntConfDoc := True;
        End
        Else
          blnPegEndEnt := False;

        For intContador := 1 To 30 Do
        Begin

          If (Not fEmptyStr(FieldByName('TMP_CODS' + fStrZero(intContador, 2)).AsString)) Then
          Begin

            fatAgrupamento.pAtribuiValoresServico(intContServico,
                                            FieldByName('TMP_CODS' + fStrZero(intContador, 2)).AsString,
                                            FieldByName('TMP_DESS' + fStrZero(intContador, 2)).AsString,
                                            FieldByName('TMP_IDES' + fStrZero(intContador, 2)).AsString,
                                            FieldByName('TMP_BRIS' + fStrZero(intContador, 2)).AsString,
                                            FieldByName('TMP_PARS' + fStrZero(intContador, 2)).AsString,
                                            FieldByName('TMP_TBRS' + fStrZero(intContador, 2)).AsString,
                                            FieldByName('TMP_VENS' + fStrZero(intContador, 2)).AsString,
                                            FieldByName('TMP_VE2S' + fStrZero(intContador, 2)).AsString,
                                            FieldByName('TMP_QTDS' + fStrZero(intContador, 2)).AsFloat,
                                            FieldByName('TMP_UNIS' + fStrZero(intContador, 2)).AsFloat,
                                            FieldByName('TMP_VALS' + fStrZero(intContador, 2)).AsFloat,
                                            FieldByName('TMP_CUSS' + fStrZero(intContador, 2)).AsFloat,
                                            FieldByName('TMP_DECS' + fStrZero(intContador, 2)).AsFloat );
            Inc(intContServico);

          End;
        End;

        fatAgrupamento.pAcertaValorServicos;

        If (Pos(FieldByName('TMP_NUMDOC').AsString, fatAgrupamento.strNumDocsPD) <= 0) Then
          fatAgrupamento.strNumDocsPD := fatAgrupamento.strNumDocsPD + FieldByName('TMP_NUMDOC').AsString + ',';

        {*****************************************}
        {* SOMA DESCONTO ESPECIAL                *}
        {**************************************MV*}
        fatAgrupamento.fltDesEsp := fatAgrupamento.fltDesEsp + FieldByName('TMP_DESESP').AsFloat;

        fatAgrupamento.strEmpFatSemSaldo := FieldByName('TMP_FATSSA').AsString;

        {*****************************************}
        {* CARREGA DOCUMENTO DETALHADO           *}
        {**************************************MV*}
        qryGenDor.Close;
        qryGenDor.ParamByName('NUMDOC').AsString := FieldByName('TMP_NUMDOC').AsString;
        qryGenDor.ParamByName('ESPDOC').AsString := FieldByName('TMP_ESPDOC').AsString;
        qryGenDor.ParamByName('CODEMP').AsString := FieldByName('TMP_CODEMP').AsString;
        qryGenDor.Open;


        If fEmptyStr(fatAgrupamento.strPlaVei) Then
          fatAgrupamento.strPlaVei := qryGenDor.FieldByName('FGO_PLAVEI').AsString;

        If fEmptyStr(fatAgrupamento.strKm_Vei) Then
          fatAgrupamento.strKm_Vei := qryGenDor.FieldByName('FGO_KM_VEI').AsString;

        {************************************}
        {* CARREGA DOCUMENTO FATGOR         *}
        {*********************************JB*}
        qryGenGor.Close;
        qryGenGor.SQL.Clear;
        qryGenGor.SQL.Add('SELECT ');
        qryGenGor.SQL.Add('  FGO_CODTRA, ');
        qryGenGor.SQL.Add('  FGO_TIPFRE, ');
        qryGenGor.SQL.Add('  FGO_NUMDOC, ');
        qryGenGor.SQL.Add('  FGO_ESPDOC, ');
        qryGenGor.SQL.Add('  FGO_CODEMP, ');
        qryGenGor.SQL.Add('  FGO_OPRFLJ, ');
        qryGenGor.SQL.Add('  FGO_DTAENT, ');
        qryGenGor.SQL.Add('  FGO_USAQUE, ');
        qryGenGor.SQL.Add('  FGO_DOCQUE, ');
        qryGenGor.SQL.Add('  FGO_EDIPES, ');
        qryGenGor.SQL.Add('  FGO_TABPRE  ');
        qryGenGor.SQL.Add('FROM ');
        qryGenGor.SQL.Add('  FATGOR ');
        qryGenGor.SQL.Add('  LEFT JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM ');
        qryGenGor.SQL.Add('WHERE ');
        qryGenGor.SQL.Add('  AUTOINCREM = :SEQGER ');
        qryGenGor.ParamByName('SEQGER').AsString := qryGenDor.FieldByName('FDO_SEQGER').AsString;
        qryGenGor.Open;

        If fEmptyStr(fatAgrupamento.strCodTra) Then
          fatAgrupamento.strCodTra  := qryGenGor.FieldByName('FGO_CODTRA').AsString;

        fatAgrupamento.strTipFre    := qryGenGor.FieldByName('FGO_TIPFRE').AsString;
        fatAgrupamento.strNumOrc    := qryGenGor.FieldByName('FGO_NUMDOC').AsString;
        fatAgrupamento.strEspOrc    := qryGenGor.FieldByName('FGO_ESPDOC').AsString;
        fatAgrupamento.strEmpOri    := qryGenGor.FieldByName('FGO_CODEMP').AsString;
        fatAgrupamento.strOprFlj    := qryGenGor.FieldByName('FGO_OPRFLJ').AsString;
        fatAgrupamento.dtaDtaEntOri := qryGenGor.FieldByName('FGO_DTAENT').AsDateTime;
        fatAgrupamento.strTabPre    := IfEmptyStr(qryGenGor.FieldByName('FGO_TABPRE').AsString, fatAgrupamento.strTabPre);

        if qryGenGor.FieldByName('FGO_USAQUE').AsString = 'S' then
        begin
          fatAgrupamento.strUsaQue := 'S';
          fatAgrupamento.strDocQue := qryGenGor.FieldByName('FGO_DOCQUE').AsString;
        end;

        If (qryGenGor.FieldByName('FGO_EDIPES').AsString = 'S') Then
          fatAgrupamento.strEdiPes := 'E';

        While (Not qryGenDor.Eof) Do
        Begin
          pProgress(qryGenDor.RecNo, qryGenDor.RecordCount);

          {*****************************************}
          {* SÓ ADICIONA AS SAÍDAS                 *}
          {**************************************MV*}
          If (StrToInt(LeftStr(qryGenDor.FieldByName('FDO_CLAFIS').AsString, 1)) < 5) Then
          Begin
            fatAgrupamento.fltDesEsp := fatAgrupamento.fltDesEsp + qryGenDor.FieldByName('FDO_TOTITE').AsFloat;
            fatAgrupamento.fltDesSai := fatAgrupamento.fltDesSai + qryGenDor.FieldByName('FDO_TOTITE').AsFloat;

            qryGenDor.Next;
            Continue;
          End;

          If fEhItemServico(qryGenDor.FieldByName('FDO_CODITE').AsString) Then
          Begin
            pIncluirNaMatrizDePedidos(fatAgrupamento.arrPedidosServAgrupados, qryGenGor.FieldByName('FGO_NUMDOC').AsString,
                                                                              qryGenGor.FieldByName('FGO_ESPDOC').AsString,
                                                                              qryGenGor.FieldByName('FGO_CODEMP').AsString);
            qryGenDor.Next;
            Continue;
          End;

          If (strItemAnt <> qryGenDor.FieldByName('FDO_CODITE').AsString)  Or
             (strGrupoAnt <> qryGenDor.FieldByName('GRU_CODGRU').AsString) Then
          Begin

            {*****************************************}
            {* CARREGA ITEM                          *}
            {**************************************MV*}
            qryGenIte.Close;
            qryGenIte.ParamByName('CODITE').AsString := qryGenDor.FieldByName('FDO_CODITE').AsString;
            qryGenIte.ParamByName('CODEMP').AsString := fatAgrupamento.fGetEmpCalculoItem(qryGenDor.FieldByName('FDO_EMPITE').AsString);
            qryGenIte.ParamByName('ESTADO').AsString := fatAgrupamento.fGetUFEmpresa(qryGenDor.FieldByName('FDO_EMPITE').AsString);
            qryGenIte.Open;

            strItemAnt  := qryGenDor.FieldByName('FDO_CODITE').AsString;
            strGrupoAnt := qryGenDor.FieldByName('GRU_CODGRU').AsString;

          End;

          If (qryGenDor.FieldByName('FDO_QTDEMB').AsFloat > 0) Then
            fltUnitarioEmb := (qryGenDor.FieldByName('FDO_PREEMB').AsFloat /
                               qryGenDor.FieldByName('FDO_QTDEMB').AsFloat)
          Else
            fltUnitarioEmb := 0.0;

          (**********************************************)
          (* PARA ADICINAR NA TEMPORARIA CORRETAMENTE   *)
          (*******************************************LA*)
          fatAgrupamento.blnEnt_CD := SameText(qryGenDor.FieldByName('FGO_ENT_CD').AsString, 'S');

          fltCusIte := qryGenDor.FieldByName('FDO_TOTCUS').AsFloat / qryGenDor.FieldByName('FDO_QTDITE').AsFloat;

          If Not (fCfgSis('ALPDEX', VarBoolean) Or (qryGenDor.FieldByName('FDO_JAFATU').AsInteger = 0)) Then
          Begin
            qryGenDor.Next;
            Continue;
          End;

          blnSintetiza := False;

          If Not blnSintetiza Then
          Begin
            If qryGenDor.FieldByName('FDO_IDEPRO').AsString <> 'NOR' Then
            Begin
              If Not IsTintaExistente(qryGenDor.FieldByName('FDO_IDEPRO').AsString) Then
              Begin
                Result := False;
                Screen.Cursor        := crDefault;
                Exit;
              End;
            End;

            fltProPreCus := 0;
            fltProPreVen := 0;
            fltProComVar := 0;
            fltProComAta := 0;
            fltProComDis := 0;
            fltQtdDis    := 0;
            fltProDesF07 := 0;

            intPraMedio := fFloatToInt(fCalcMediaPagto(fatAgrupamento.strConPag));
            If fEmptyStr(fatAgrupamento.strConPag) Then
              intPraMedio := fFloatToInt(fCalcMediaPagto(qryGenDor.FieldByName('FDO_CONPAG').AsString));

            strPromocao := qryGenDor.FieldByName('FDO_PROMOC').AsString;

            strTabPreIte := qryGenDor.FieldByName('TABPRE').AsString;

            strCodCndTmp := '';

            If fCfgSis('USACND', varBoolean) Then
            Begin
              strCodCndTmp := fatAgrupamento.strCodCnd;
              If fEmptyStr(fatAgrupamento.strCodCnd) Then
                strCodCndTmp := qryGenDor.FieldByName('FDO_CODCND').AsString;
            End;

            {*************************************************************************}
            {* Somente deve carregar os dados da promocao, caso o produto estava em  *}
            {* promocao quando o pedido foi feito. Pois ocorre de o produto nao      *}
            {* estar mais em promocao no momento em que vai faturar o mesmo (ex: F11)*}
            {* porem o desconto que nao se aplica a um produto em promocao, sera     *}
            {* aplicado alterando o preco combinado no balcao com o cliente. O mesmo *}
            {* vale para produtos que nao estavam em promocao e agora estao, nao deve*}
            {* retirar o desconto que foi concedido ao cliente.                      *}
            {**********************************************************************JC*}
            If (fatAgrupamento.fFilialPromocao) And (strPromocao = 'S') Then
            Begin
              If Not (fRetornaPrecosPromocao(qryGenDor.FieldByName('FDO_CODITE').AsString,
                                             fatAgrupamento.strCodCli,
                                             VS_Date,
                                             qryGenDor.FieldByName('FDO_QTDITE').AsFloat,
                                             0,
                                             0,
                                             intPraMedio,
                                             fltProPreCus,
                                             fltProPreVen,
                                             fltProComVar,
                                             fltProComAta,
                                             fltProComDis,
                                             fltQtdDis,
                                             fltProDesF07,
                                             fatAgrupamento.strComPro,
                                             fatAgrupamento.strCodPro,
                                             blnParticiona,
                                             blnPromo,
                                             strTabPreIte,
                                             strCodCndTmp,
                                             '',
                                             '',
                                             True,
                                             False,
                                             '-1',
                                             ((qryGenDor.FieldByName('FDO_ENTRET').AsString = 'E') And (qryGenDor.FieldByName('FDO_ENTFUT').AsString = 'N')),
                                             ((qryGenDor.FieldByName('FDO_ENTRET').AsString = 'E') And (qryGenDor.FieldByName('FDO_ENTFUT').AsString = 'S')),
                                             qryGenDor.FieldByName('FDO_MOTFUT').AsString,
                                             fatAgrupamento.fGetEmpPrecoPromoItem(fRetEmpresaItem, qryGenDor.FieldByName('FDO_EMPDMP').AsString),
                                             qryGenDor.FieldByName('FDO_NUMDOC').AsString,
                                             qryGenDor.FieldByName('FDO_ESPDOC').AsString)) Then
              Begin
                fltProComVar := qryGenDor.FieldByName('FDO_PERCOM').AsFloat;
                fltProComAta := qryGenDor.FieldByName('FDO_PERREP').AsFloat;
                fltProComDis := qryGenDor.FieldByName('FDO_PERCOM').AsFloat;
              End;
            End;

            recForTin.intModDil   := IfNull(qryGenDor.FieldByName('FOR_MODDIL').Value, 0);
            recForTin.strTextBase := IfNull(qryGenDor.FieldByName('FOR_TEXBAS').Value, '');
            recForTin.strTipCor   := IfNull(qryGenDor.FieldByName('FOR_TIPCOR').Value, '');
            recForTin.strCompB    := IfNull(qryGenDor.FieldByName('FOR_ITECOB').Value, '');
            recForTin.strUniver   := IfNull(qryGenDor.FieldByName('FOR_UNIVER').Value, '');
            recForTin.strCatali   := IfNull(qryGenDor.FieldByName('FOR_CATALI').Value, '');

            If fatAgrupamento.fUtilizaPrecoSubItensEstrutura(Pos('ITEM ESPECIAL', qryGenDor.FieldByName('FDO_DESCRI').AsString) > 0,
                                                       qryGenDor.FieldByName('FDO_CODITE').AsString) Then
            Begin
              impSubIteEst.strCodIte := qryGenDor.FieldByName('FDO_CODITE').AsString;
              impSubIteEst.strEmpIte := qryGenDor.FieldByName('FDO_EMPITE').AsString;
              impSubIteEst.fltUniPai := qryGenDor.FieldByName('FDO_UNITAR').AsFloat;
              impSubIteEst.fltQtdPai := qryGenDor.FieldByName('FDO_QTDITE').AsFloat;

              fatAgrupamento.pRetImpostosSubItensEstrutura(impSubIteEst);
              fltOutValIte := impSubIteEst.fltOutVal;
              fltDesOpeIte := impSubIteEst.fltDesOpe;
              fltIcmSaiIte := impSubIteEst.fltIcmSai;
              fltImpFedIte := impSubIteEst.fltImpFed;

              fltItePreVe1 := fatAgrupamento.fCalculaPrecoEstrutura(False, Preco_de_Venda,qryGenDor.FieldByName('FDO_CODITE').AsString,qryGenDor.FieldByName('FDO_EMPITE').AsString,'S','1',fatAgrupamento.fltMargem);
              fltItePreVe2 := fatAgrupamento.fCalculaPrecoEstrutura(False, Preco_de_Venda,qryGenDor.FieldByName('FDO_CODITE').AsString,qryGenDor.FieldByName('FDO_EMPITE').AsString,'S','2',fatAgrupamento.fltMargem);
              fltItePreVe3 := fatAgrupamento.fCalculaPrecoEstrutura(False, Preco_de_Venda,qryGenDor.FieldByName('FDO_CODITE').AsString,qryGenDor.FieldByName('FDO_EMPITE').AsString,'S','3',fatAgrupamento.fltMargem);
              fltItePreVe4 := fatAgrupamento.fCalculaPrecoEstrutura(False, Preco_de_Venda,qryGenDor.FieldByName('FDO_CODITE').AsString,qryGenDor.FieldByName('FDO_EMPITE').AsString,'S','4',fatAgrupamento.fltMargem);
              fltItePreVe5 := fatAgrupamento.fCalculaPrecoEstrutura(False, Preco_de_Venda,qryGenDor.FieldByName('FDO_CODITE').AsString,qryGenDor.FieldByName('FDO_EMPITE').AsString,'S','5',fatAgrupamento.fltMargem);
              fltItePreVe6 := fatAgrupamento.fCalculaPrecoEstrutura(False, Preco_de_Venda,qryGenDor.FieldByName('FDO_CODITE').AsString,qryGenDor.FieldByName('FDO_EMPITE').AsString,'S','6',fatAgrupamento.fltMargem);
              fltItePreVe7 := fatAgrupamento.fCalculaPrecoEstrutura(False, Preco_de_Venda,qryGenDor.FieldByName('FDO_CODITE').AsString,qryGenDor.FieldByName('FDO_EMPITE').AsString,'S','7',fatAgrupamento.fltMargem);
            End
            Else
            Begin
              fltOutValIte := qryGenIte.FieldByName('ITE_OUTVAL').AsFloat;
              fltDesOpeIte := qryGenIte.FieldByName('ITE_DESOPE').AsFloat;
              fltIcmSaiIte := qryGenIte.FieldByName('ITE_ICMSAI').AsFloat;
              fltImpFedIte := qryGenIte.FieldByName('ITE_IMPFED').AsFloat;

              fltItePreVe1 := qryGenIte.FieldByName('ITE_PREVE1').AsFloat;
              fltItePreVe2 := qryGenIte.FieldByName('ITE_PREVE2').AsFloat;
              fltItePreVe3 := qryGenIte.FieldByName('ITE_PREVE3').AsFloat;
              fltItePreVe4 := qryGenIte.FieldByName('ITE_PREVE4').AsFloat;
              fltItePreVe5 := qryGenIte.FieldByName('ITE_PREVE5').AsFloat;
              fltItePreVe6 := qryGenIte.FieldByName('ITE_PREVE6').AsFloat;
              fltItePreVe7 := qryGenIte.FieldByName('ITE_PREVE7').AsFloat;
            End;

            fltPesBruTmp := qryGenDor.FieldByName('FDO_TOTPES').AsFloat / qryGenDor.FieldByName('FDO_QTDITE').AsFloat;
            fltPesLiqTmp := qryGenIte.FieldByName('ITE_PESLIQ').AsFloat;

            If (fatAgrupamento.strEdiPes = 'E') And (blnPesPed) Then
            Begin
              fltPesBruTmp := fFormataFloat(qryGenDor.FieldByName('FDO_TOTPES').AsFloat / qryGenDor.FieldByName('FDO_QTDITE').AsFloat, 2);
              fltPesLiqTmp := fFormataFloat(qryGenDor.FieldByName('FDO_PESLIQ').AsFloat / qryGenDor.FieldByName('FDO_QTDITE').AsFloat, 2);
            End;

            fltUniDigDescontada := qryGenDor.FieldByName('FDO_UNIDIG').AsFloat;

            If Not ((fatAgrupamento.strJurPro = 'N') And (strPromocao = 'S')) Then
            Begin
              If fAplicarTaxaJurosPrecoDigitado Then
              Begin
                fltUniDigDescontada := fltUniDigDescontada + (fltUniDigDescontada * qryGenDor.FieldByName('FDO_TAXJUR').AsFloat / 100.0);
              End;
            End;

            //INICIO
            fltUniDigDescontada := fFormataFloat(fltUniDigDescontada, fatAgrupamento.VS_intDecUni);
            fltUniDigDescontada := fltUniDigDescontada - fatAgrupamento.fRetornaVrDesconto(2, fltUniDigDescontada, qryGenDor.FieldByName('FDO_DESCON').AsFloat);
            fltUniDigDescontada := fFormataFloat(fltUniDigDescontada, fatAgrupamento.fMaxDecUni);
            fltUniDigDescontada := fFormataFloat(fltUniDigDescontada, fatAgrupamento.VS_intDecUni);
            //FIM

            fatAgrupamento.objIcStPv.pAdd(qryGenDor.FieldByName('FDO_CODITE').AsString,
                                          fatAgrupamento.fGetEmpCalculoItem(qryGenDor.FieldByName('FDO_EMPITE').AsString),
                                          fatAgrupamento.GetTipAbf(qryGenDor.FieldByName('FDO_EMPITE').AsString),
                                          fatAgrupamento.fUFDestTrib(qryGenDor.FieldByName('FDO_EMPITE').AsString),
                                          qryGenDor.FieldByName('FDO_CODFIS').AsString,
                                          fltImcSTPV,
                                          blnCalcST);

            fatAgrupamento.pAdicionaRegistroTemporaria(cdsVenda,
                                                 nil,
                                                 qryGenDor.FieldByName('FDO_IDEPRO').AsString,
                                                 qryGenDor.FieldByName('GRU_CODGRU').AsString,
                                                 qryGenDor.FieldByName('FDO_CODITE').AsString,
                                                 qryGenDor.FieldByName('FDO_DESCRI').AsString,
                                                 qryGenDor.FieldByName('FDO_DESCRI').AsString,
                                                 qryGenIte.FieldByName('ITE_DESFAB').AsString,
                                                 qryGenDor.FieldByName('FDO_UNIDAD').AsString,
                                                 qryGenDor.FieldByName('FDO_UNIDAD').AsString,
                                                 qryGenDor.FieldByName('FDO_CODMAR').AsString,
                                                 qryGenDor.FieldByName('FDO_FORITE').AsString,
                                                 qryGenDor.FieldByName('FDO_REFERE').AsString,
                                                 qryGenDor.FieldByName('FDO_UNIORI').AsFloat,
                                                 qryGenDor.FieldByName('FDO_UNIVIS').AsFloat,
                                                 fltUniDigDescontada,
                                                 0.00,
                                                 qryGenDor.FieldByName('FDO_DESCON').AsFloat,
                                                 qryGenDor.FieldByName('FDO_QTDITE').AsFloat,
                                                 fltUniDigDescontada * qryGenDor.FieldByName('FDO_QTDITE').AsFloat,
                                                 'S',
                                                 qryGenDor.FieldByName('FDO_TOTCUS').AsFloat / qryGenDor.FieldByName('FDO_QTDITE').AsFloat,
                                                 qryGenDor.FieldByName('FDO_TOTCUS').AsFloat,
                                                 qryGenIte.FieldByName('ITE_COMLUB').AsString,
                                                 qryGenIte.FieldByName('ITE_IPISAI').AsFloat,
                                                 qryGenIte.FieldByName('ITE_DESMAX').AsFloat,
                                                 fltItePreVe1,
                                                 fltItePreVe2,
                                                 fltItePreVe3,
                                                 fltItePreVe4,
                                                 fltItePreVe5,
                                                 fltItePreVe6,
                                                 fltItePreVe7,

                                                 fCalculaPrecoVenda(2, fltCusIte + fltOutValIte,
                                                                       fltUniDigDescontada,
                                                                       0,
                                                                       fltIcmSaiIte + fatAgrupamento.fAlqDifIcmsPrecoDinamico(qryGenDor.FieldByName('FDO_CODITE').AsString, qryGenDor.FieldByName('FDO_EMPITE').AsString, qryGenIte.FieldByName('ABF_CODABF').AsString, qryGenDor.FieldByName('FDO_CODFIS').AsString, fltIcmSaiIte),
                                                                       fltImpFedIte,
                                                                       fltDesOpeIte + fatAgrupamento.fltDesOpeCli,
                                                                       qryGenIte.FieldByName('ITE_COMTB' + qryGenDor.FieldByName('FDO_TABPRE').AsString ).AsFloat,
                                                                       fatAgrupamento.VS_strMARMKP,
                                                                       '',
                                                                       -1,
                                                                       fltImcSTPV,
                                                                       blnCalcST),

                                                 qryGenIte.FieldByName('ITE_SALDOS').AsFloat,
                                                 qryGenDor.FieldByName('ITE_INCPIS').AsString,
                                                 qryGenIte.FieldByName('ITE_COMVAR').AsFloat,
                                                 qryGenIte.FieldByName('ITE_COMATA').AsFloat,
                                                 qryGenIte.FieldByName('ITE_COMDIS').AsFloat,
                                                 '',
                                                 '',
                                                 '',
                                                 0.0,
                                                 0.0,
                                                 '',
                                                 qryGenIte.FieldByName('ITE_PREULT').AsFloat * qryGenDor.FieldByName('FDO_QTDITE').AsFloat,
                                                 qryGenIte.FieldByName('ITE_IMPULT').AsFloat,
                                                 qryGenIte.FieldByName('ITE_PREULT').AsFloat,
                                                 qryGenIte.FieldByName('ITE_PREMED').AsFloat,
                                                 qryGenIte.FieldByName('ITE_CLAIPI').AsString,
                                                 '',
                                                 qryGenDor.FieldByName('FDO_ITETIN').AsString,
                                                 '',
                                                 qryGenDor.FieldByName('FDO_TIPPRE').AsString,
                                                 qryGenDor.FieldByName('FDO_LAZQUA').AsInteger,
                                                 qryGenDor.FieldByName('FDO_TIPEMB').AsString,
                                                 qryGenDor.FieldByName('FDO_QTDEMB').AsFloat,
                                                 qryGenDor.FieldByName('FDO_PREEMB').AsFloat,
                                                 0.0,
                                                 qryGenDor.FieldByName('FDO_PRCTIN').AsFloat,
                                                 0.0,
                                                 'N',
                                                 qryGenDor.FieldByName('FDO_ITEEMB').AsString,
                                                 fltUnitarioEmb,
                                                 fltUnitarioEmb,
                                                 qryGenIte.FieldByName('ABF_CODABF').AsString,
                                                 fltPesBruTmp,
                                                 fltPesLiqTmp,
                                                 qryGenDor.FieldByName('FDO_PROMOC').AsString,
                                                 0.0,
                                                 0.0,
                                                 fltProComVar,
                                                 0.0,
                                                 IIF(fEmptyStr(qryGenDor.FieldByName('FDO_SEQTIN').AsString), '', '2'),
                                                 fatAgrupamento.fRetPerComGrupo(qryGenDor.FieldByName('GRU_CODGRU').AsString),
                                                 qryGenIte.FieldByName('ITE_CODFAB').AsString,
                                                 qryGenDor.FieldByName('FDO_SEQIND').AsInteger,
                                                 qryGenDor.FieldByName('FDO_QTDBAI').AsFloat,
                                                 qryGenDor.FieldByName('FDO_NUMDOC').AsString,
                                                 qryGenDor.FieldByName('FDO_ESPDOC').AsString,
                                                 qryGenDor.FieldByName('FDO_CODEMP').AsString,
                                                 qryGenIte.FieldByName('ITE_MARMIN').AsFloat,
                                                 qryGenIte.FieldByName('ITE_MARMSG').AsFloat,
                                                 qryGenIte.FieldByName('ITE_MARMGE').AsFloat,
                                                 fatAgrupamento.strDesMar,
                                                 fatAgrupamento.strStatus,
                                                 0.0,
                                                 0.0,
                                                 qryGenDor.FieldByName('AUTOINCREM').AsString,
                                                 qryGenDor.FieldByName('FDO_CATALI').AsString,
                                                 qryGenDor.FieldByName('FDO_LINLIN').AsString,
                                                 qryGenIte.FieldByName('ITE_EMBALA').AsFloat,
                                                 '',
                                                 '',
                                                 '',
                                                 qryGenIte.FieldByName('ITE_PRECOM').AsFloat,
                                                 qryGenDor.FieldByName('FDO_UNIDIG').AsFloat,
                                                 qryGenIte.FieldByName('ITE_QTPPRO').AsFloat,
                                                 qryGenDor.FieldByName('FDO_COMPLE').AsString,
                                                 '',
                                                 qryGenIte.FieldByName('ITE_OBRCPF').AsString,
                                                 qryGenDor.FieldByName('FDO_MONTAD').AsString,
                                                 qryGenDor.FieldByName('FDO_A_N_O_').AsString,
                                                 fRetSiglaUnidade(qryGenDor.FieldByName('FDO_UNIDAD').AsString, qryCadUni),
                                                 qryGenDor.FieldByName('FDO_VOLPRO').AsFloat,
                                                 fatAgrupamento.fOrdemItem(cdsVenda,'Adiciona',nil),
                                                 '',
                                                 qryGenDor.FieldByName('FDO_CODACA').AsString,
                                                 qryGenDor.FieldByName('FDO_EMPACA').AsString,
                                                 (qryGenDor.FieldByName('FDO_PROACA').AsString = 'S'),
                                                 '',
                                                 '',
                                                 '',
                                                 fltOutValIte,
                                                 qryGenIte.FieldByName('ITE_COMTB' + qryGenDor.FieldByName('FDO_TABPRE').AsString ).AsFloat,
                                                 fltDesOpeIte,
                                                 fltIcmSaiIte,
                                                 fltImpFedIte,
                                                 qryGenIte.FieldByName('ITE_DESMGE').AsFloat,
                                                 '',
                                                 '',
                                                 '',
                                                 qryGenDor.FieldByName('FDO_TABPRE').AsString,
                                                 qryGenIte.FieldByName('ITE_IPIENT').AsFloat,
                                                 qryGenIte.FieldByName('ITE_FREENT').AsFloat,
                                                 qryGenDor.FieldByName('FDO_CODDIL').AsString,
                                                 qryGenDor.FieldByName('FDO_PORDIL').AsFloat,
                                                 qryGenDor.FieldByName('FDO_DILCON').AsString,
                                                 qryGenDor.FieldByName('FDO_PORCAT').AsFloat,
                                                 qryGenDor.FieldByName('FDO_ENTRET').AsString,
                                                 qryGenDor.FieldByName('FDO_LOCRET').AsString,
                                                 qryGenDor.FieldByName('FDO_ENTFUT').AsString,
                                                 qryGenDor.FieldByName('FDO_MOTFUT').AsString,
                                                 qryGenDor.FieldByName('FDO_DTENTR').AsDateTime,
                                                 qryGenDor.FieldByName('FDO_QTDORI').AsFloat,
                                                 qryGenDor.FieldByName('FDO_DESESP').AsFloat,
                                                 qryGenDor.FieldByName('FDO_DESBAI').AsFloat,
                                                 qryGenIte.FieldByName('ITE_IMPDIR').AsString,
                                                 qryGenIte.FieldByName('ITE_LOCFIS').AsString,
                                                 qryGenDor.FieldByName('FDO_TOTCU2').AsFloat / qryGenDor.FieldByName('FDO_QTDITE').AsFloat,
                                                 qryGenDor.FieldByName('FDO_TOTCU2').AsFloat,
                                                 fltProComAta,
                                                 fltProComDis,
                                                 qryGenDor.FieldByName('FGO_TOTPED').AsFloat,
                                                 qryGenDor.FieldByName('FGO_PANUTI').AsFloat,
                                                 qryGenDor.FieldByName('FGO_DESESP').AsFloat,
                                                 qryGenDor.FieldByName('FGO_TOTFRE').AsFloat,
                                                 recForTin,
                                                 qryGenDor.FieldByName('FDO_KEY_EP').AsString,
                                                 '',
                                                 qryGenDor.FieldByName('FDO_NUMLOT').AsString,
                                                 qryGenDor.FieldByName('FDO_EMPPRD').AsString,
                                                 qryGenDor.FieldByName('FDO_CODVEN').AsString,
                                                 qryGenDor.FieldByName('FDO_BXSBIT').AsString = 'S',
                                                 'N',
                                                 'NOR',
                                                 0,
                                                 '',
                                                 qryGenIte.FieldByName('ITE_CODBAR').AsString,
                                                 qryGenDor.FieldByName('FGO_TIPFIN').AsString,
                                                 qryGenDor.FieldByName('FGO_DESFIN').AsFloat,
                                                 0,
                                                 0,
                                                 qryGenDor.FieldByName('FDO_EMPITE').AsString,
                                                 qryGenDor.FieldByName('FOR_FATACE').AsFloat,
                                                 True,
                                                 '',
                                                 '',
                                                 '',
                                                 0,
                                                 fltCusIte,
                                                 qryGenIte.FieldByName('ITE_DESSIM').AsString,
                                                 qryGenDor.FieldByName('FDO_ORDPRO').AsString,
                                                 recMadeira,
                                                 qryGenIte.FieldByName('ITE_IMPULT').AsFloat * qryGenDor.FieldByName('FDO_QTDITE').AsFloat,
                                                 qryGenDor.FieldByName('FDO_VAL_RT').AsFloat,
                                                 qryGenDor.FieldByName('FDO_TAXJUR').AsFloat,
                                                 '',
                                                 qryGenDor.FieldByName('FDO_QTDEXP').AsFloat,
                                                 '',
                                                 qryGenDor.FieldByName('FDO_NUMCMP').AsString,
                                                 qryGenDor.FieldByName('FDO_NITCMP').AsInteger,
                                                 0,
                                                 '',
                                                 '',
                                                 0,
                                                 qryGenDor.FieldByName('FDO_CODVEN').AsString,
                                                 qryGenDor.FieldByName('FDO_ALTPCO').AsString,
                                                 qryGenDor.FieldByName('FDO_PERCOM').AsFloat,
                                                 0,
                                                 0,
                                                 False,
                                                 False,
                                                 qryGenDor.FieldByName('FDO_CLIBUS').AsString,
                                                 qryGenDor.FieldByName('FDO_TURENT').AsString,
                                                 0,
                                                 0,
                                                 qryGenDor.FieldByName('FDO_CODVE2').AsString,
                                                 'N',
                                                 0,
                                                 qryGenDor.FieldByName('FDO_LOTABA').AsString,
                                                 '',
                                                 '',
                                                 '',
                                                 qryGenIte.FieldByName('ITE_EXCIPI').AsString,
                                                 qryGenIte.FieldByName('ITE_DESMSU').AsFloat,
                                                 '',
                                                 '',
                                                 '',
                                                 'S',
                                                 qryGenDor.FieldByName('FDO_BRINDE').AsString,
                                                 qryGenDor.FieldByName('BRI_CODPAR').AsString,
                                                 qryGenDor.FieldByName('BRI_TIPBRI').AsString,
                                                 qryGenDor.FieldByName('FDO_SEQGER').AsString,
                                                 '',
                                                 (fatAgrupamento.strEdiPes = 'E'),
                                                 qryGenIte.FieldByName('ITE_PESOIT').AsFloat,
                                                 qryGenIte.FieldByName('ITE_PESLIQ').AsFloat,
                                                 'N',
                                                 '',
                                                 qryGenDor.FieldByName('FDO_ATIVAC').AsString,
                                                 qryGenDor.FieldByName('FDO_SEQCOM').AsInteger,
                                                 0,
                                                 0,
                                                 '',
                                                 0,
                                                 0,
                                                 qryGenDor.FieldByName('FDO_SEQEST').AsInteger,
                                                 qryGenDor.FieldByName('FDO_ITEEST').AsString,
                                                 qryGenDor.FieldByName('FDO_UNIEST').AsFloat,
                                                 qryGenDor.FieldByName('FDO_QTDSBI').AsFloat,
                                                 qryGenDor.FieldByName('FDO_UNISBI').AsFloat,
                                                 '',
                                                 '',
                                                 0,
                                                 qryGenDor.FieldByName('FDO_FREMKP').AsFloat,
                                                 qryGenDor.FieldByName('FDO_COMMKP').AsFloat,
                                                 False,
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 0,
                                                 0,
                                                 qryGenIte.FieldByName('ITE_COMDIG').AsFloat,
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
                                                 qryGenIte.FieldByName('ITE_DESMVM').AsFloat,
                                                 qryGenIte.FieldByName('ITE_DESMSM').AsFloat,
                                                 qryGenIte.FieldByName('ITE_DESMGM').AsFloat,
                                                 qryGenIte.FieldByName('ITE_MARMMV').AsFloat,
                                                 qryGenIte.FieldByName('ITE_MARMMS').AsFloat,
                                                 qryGenIte.FieldByName('ITE_MARMMG').AsFloat,
                                                 0,
                                                 '',
                                                 'S',
                                                 '',
                                                 0,
                                                 '',
                                                 0,
                                                 0,
                                                 '',
                                                 False,
                                                 0,
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 0,
                                                 False,
                                                 0,
                                                 0,
                                                 True,
                                                 True,
                                                 'N',
                                                 False,
                                                 '',
                                                 False,
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 qryGenDor.FieldByName('FDO_EMPDMP').AsString,
                                                 False,
                                                 '',
                                                 0,
                                                 0,
                                                 0,
                                                 0,
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 'N',
                                                 '',
                                                 False,
                                                 qryGenDor.FieldByName('FDO_DTACMP').AsDateTime);

            fatAgrupamento.pCarregaEstruturaItemVidroPedOrc(qryGenDor.FieldByName('AUTOINCREM').AsString);
          End;

          {********************************}
          {* CARREGA AS FORMULAS DA TINTA *}
          {*****************************PH*}
          If qryGenDor.FieldByName('FDO_IDEPRO').AsString <> 'NOR' Then
          Begin
            matrizSaldosAux := fDesfragmentaTintaSaldosOR(qryGenDor, blnLocFor);
            If Not blnLocFor Then
            Begin
              Result := False;
              Screen.Cursor        := crDefault;
              Exit;
            End;

            fatAgrupamento.dicFormulas.AdicionarObjeto(cdsVenda.FieldByName('AUTOINCREM').AsString, matrizSaldosAux);
          End;

          qryGenDor.Next;

          pProcessMessages;

        End;

        fatAgrupamento.pAcertaTabelaPrecoTinta(FieldByName('TMP_NUMDOC').AsString,
                                               FieldByName('TMP_ESPDOC').AsString,
                                               FieldByName('TMP_CODEMP').AsString);

        fatAgrupamento.blnVendaPresencial := FieldByName('TMP_VENPRE').AsString = 'S';
        fatAgrupamento.strTipPed          := FieldByName('TMP_TIPPED').AsString;

        Next;

        pProcessMessages;
      End;

      if (not fEmptyStr(strMensagens)) then
      begin
        if (strMensagens.Length <= (fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN001').Size +
                                    fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN002').Size +
                                    fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN003').Size +
                                    fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN004').Size +
                                    fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN005').Size)) and
           ((strMen001_.Length > fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN001').Size) or
           (strMen002_.Length > fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN002').Size) or
           (strMen003_.Length > fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN003').Size) or
           (strMen004_.Length > fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN004').Size) or
           (strMen005_.Length > fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN005').Size)) then
        begin
          fatAgrupamento.strMen001 := Copy(strMensagens, 1, fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN001').Size);

          fatAgrupamento.strMen002 := Copy(strMensagens, fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN001').Size + 1,
                                                         fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN002').Size);

          fatAgrupamento.strMen003 := Copy(strMensagens, fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN001').Size +
                                                         fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN002').Size + 1,
                                                         fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN003').Size);

          fatAgrupamento.strMen004 := Copy(strMensagens, fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN001').Size +
                                                         fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN002').Size +
                                                         fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN003').Size + 1,
                                                         fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN004').Size);

          fatAgrupamento.strMen005 := Copy(strMensagens, fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN001').Size +
                                                         fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN002').Size +
                                                         fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN003').Size +
                                                         fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN004').Size + 1,
                                                         fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN005').Size);
        end
        else
        begin
          fatAgrupamento.strMen001 := Copy(strMen001_, 1, fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN001').Size);
          fatAgrupamento.strMen002 := Copy(strMen002_, 1, fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN002').Size);
          fatAgrupamento.strMen003 := Copy(strMen003_, 1, fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN003').Size);
          fatAgrupamento.strMen004 := Copy(strMen004_, 1, fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN004').Size);
          fatAgrupamento.strMen005 := Copy(strMen005_, 1, fatAgrupamento.qryTemporariaConfirmacao.FieldByName('TMP_MEN005').Size);
        end
      end;

      fatAgrupamento.pAcertaProdutoAcabado;

      //retirar a virgula do final
      If (Not fEmptyStr(fatAgrupamento.strNumDocsPD)) Then
        fatAgrupamento.strNumDocsPD := Copy(fatAgrupamento.strNumDocsPD, 1, Length(fatAgrupamento.strNumDocsPD) - 1);

      Result := True;
      Screen.Cursor        := crDefault;
    End;

  Except

    On E: ExceptionAutcom Do
    Begin
      Result := False;

      Screen.Cursor        := crDefault;
      pMensagemOk(E.Message);
    End;

    On E: Exception Do
    Begin
      Result := False;

      Screen.Cursor        := crDefault;
      pMensagensErro(E.Message, '[fCarregaItensConfirmacaoPedido]');
    End;

  End;

  pInserirItemServico(fatAgrupamento, fCfgSis('ITESER'));

  fatAgrupamento.fltPorDes := 0.0;//Unitario do item ja esta liquido, nao deve aplicar o desconto novamente
  fatAgrupamento.fltDesEsp := 0.0;
  fatAgrupamento.fltValFre := 0.0;

  {*****************************************}
  {* SE OCORREU UM ERRO DURANTE O PROCES-  *}
  {* SAMENTO, SAI                          *}
  {**************************************MV*}
  If (Not Result) Then
    Exit;

  pInformacao('Processando Produtos, Aguarde....');

  fatAgrupamento.pAtualizaDocumentoEntregaFutura;

  pCalculaFreteDespDescPagAntConfPedidos;

  {*****************************************}
  {* PREENCHE A MATRIZ COM OS ITENS        *}
  {**************************************MV*}
  Try
    fatAgrupamento.pPreencheMatrizFechamento;
    fatAgrupamento.strNumOrc := '';
    fatAgrupamento.strEspDoc := 'PD';
    fatAgrupamento.strTipFat := 'PEDIDO';

    fatAgrupamento.strCodVen := qryGenDor.FieldByName('FDO_CODVEN').AsString ;
    fatAgrupamento.strCodOpe := strCodOpe;
    fatAgrupamento.strCodDig := strCodOpe;
    fatAgrupamento.strNomDig := fRetNomVendRep(strCodOpe);

    If fCfgSis('USACND', varBoolean) And fEmptyStr(fatAgrupamento.strCodCnd) And (not fEmptyStr(strCodCndTmp)) Then
      fatAgrupamento.strCodCnd := strCodCndTmp;

    If fCfgSis('USAFPG', varBoolean) And fEmptyStr(fatAgrupamento.strCodFpg) And (not fEmptyStr(qryGenDor.FieldByName('FGO_CODFPG').AsString)) Then
      fatAgrupamento.strCodFpg := qryGenDor.FieldByName('FGO_CODFPG').AsString;
  Except
    On E: ExceptionAutCom Do
    Begin
      fMensagem('', E.Message, ['&O K']);
      Result := False;
      Exit;
    End;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmFatVendas.fCarregaItensConfirmacaoPedido]');
      Result := False;
      Exit;
    End;
  End;

  If Result Then
  Begin
    pInformacao('Totalizando Produtos, Aguarde....');

    fatAgrupamento.pAtualizaInformacoesCondPagamento;

    fatAgrupamento.blnDeCndF := (fCfgSis('CNDVEN') = 'F');

    If (Not fEmptyStr(fatAgrupamento.strCodCnd)) Then
    Begin
      fatAgrupamento.fltTxJCnd := fRetTaxJurosCondicao(fatAgrupamento.strCodCnd);
    End;

    fatAgrupamento.pCalculaTaxVpr;

    If fatAgrupamento.fltTaxVpr > 0 Then
        fatAgrupamento.blnTaxVpr := True;

    fatAgrupamento.pCalculaPesBruLiq;

    If fatAgrupamento.fRetemImpostosNoDescontoEspecial Then
    Begin
      fatAgrupamento.pDestacaRetencoes;
      fatAgrupamento.pRetemImpostosNoDescontoEspecial;
    End;

    If (fatAgrupamento.fltTotSer > 0) Then
    Begin
      fatAgrupamento.pDefineAliquotaIss;
      fatAgrupamento.fltBasIss := fFormataFloat(fatAgrupamento.fltTotSer * (1 - fatAgrupamento.fltRedIss / 100), 2);
      fatAgrupamento.fltValIss := fCalculaValorIss(fatAgrupamento.fltBasIss, fatAgrupamento.fltPerIss);
    End;

    fatAgrupamento.pCalculaTotGer(False, True);

    fatAgrupamento.strDesCla := fRetDesCla(fatAgrupamento.strClaFis);

    fatAgrupamento.pCalculaTotalParaCadRec;

    fatAgrupamento.pRateiaValores;

    If (fatAgrupamento.fltTotIcm <= 0.0) Then
      fatAgrupamento.fltAlqIcm := 0.0;

    If (fatAgrupamento.fltTotIpi <= 0.0) Then
      fatAgrupamento.fltAlqIpi := 0.0;

    blnMostraDigDuplic := False;

    fatAgrupamento.fDigitaDuplicata(blnMostraDigDuplic,
                              arrDatas, fatAgrupamento.dtaPreVis,
                              True, fatAgrupamento.arrDuplicCop);

    If fatAgrupamento.fltValAdt > 0 Then
    Begin
      Result := Result And fatAgrupamento.fAdicionaAdiantamentoPrimeiraParcela;
    End;

    Result := Result And (fFormataFloat(fatAgrupamento.fltTotGer, 2) >= 0);

  End;

  FreeAndNil(qryGenIte);
  FreeAndNil(qryGenDor);
end;

Function TfrmFatConfOrcamentos.fSalvaLoGEnderecoEntrega(strCodOpe, strCodEmp, strNomCam, strValAnt, strValAtu, strCodCli: String): Boolean;
  Var
    qryLogEndEnt: TUniQuery;
Begin
  Try
    Result := True;

    qryLogEndEnt := fCriaQuery;
    qryLogEndEnt.SQL.Add('INSERT INTO LOGEND ( ');
    qryLogEndEnt.SQL.Add('  AUTOINCREM,        ');
    qryLogEndEnt.SQL.Add('  END_DTAALT,        ');
    qryLogEndEnt.SQL.Add('  END_HRAALT,        ');
    qryLogEndEnt.SQL.Add('  END_OPEALT,        ');
    qryLogEndEnt.SQL.Add('  END_CODEMP,        ');
    qryLogEndEnt.SQL.Add('  END_NOMCAM,        ');
    qryLogEndEnt.SQL.Add('  END_VALANT,        ');
    qryLogEndEnt.SQL.Add('  END_VALATU,        ');
    qryLogEndEnt.SQL.Add('  END_CODCLI         ');
    qryLogEndEnt.SQL.Add('  )                  ');
    qryLogEndEnt.SQL.Add('VALUES (             ');
    qryLogEndEnt.SQL.Add('  :AUTOINCREM,       ');
    qryLogEndEnt.SQL.Add('  CURRENT_DATE,      ');
    qryLogEndEnt.SQL.Add('  CURRENT_TIME,      ');
    qryLogEndEnt.SQL.Add('  :OPEALT,           ');
    qryLogEndEnt.SQL.Add('  :CODEMP,           ');
    qryLogEndEnt.SQL.Add('  :NOMCAM,           ');
    qryLogEndEnt.SQL.Add('  :VALANT,           ');
    qryLogEndEnt.SQL.Add('  :VALATU,           ');
    qryLogEndEnt.SQL.Add('  :CODCLI            ');
    qryLogEndEnt.SQL.Add('  )                  ');

    qryLogEndEnt.ParamByName('AUTOINCREM').asString := fRetAutoIncrem('LOGEND', strCodEmp);
    qryLogEndEnt.ParamByName('OPEALT').asString := strCodOpe;
    qryLogEndEnt.ParamByName('CODEMP').asString := strCodEmp;
    qryLogEndEnt.ParamByName('NOMCAM').asString := strNomCam;
    qryLogEndEnt.ParamByName('VALANT').asString := strValAnt;
    qryLogEndEnt.ParamByName('VALATU').asString := strValAtu;
    qryLogEndEnt.ParamByName('CODCLI').asString := strCodCli;

    qryLogEndEnt.ExecSQL;

    FreeAndNil(qryLogEndEnt);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fSalvaLoGEnderecoEntrega]');
    End;
  End;
End;

function TfrmFatConfOrcamentos.fPdfNFCeGerado(const AstrNumDoc, AstrEspDoc, AstrCodEmp, AstrCodCli: String;
                                              var AblnSemImpressaoPrevista: Boolean): Boolean;
  const
    STR_OBSERV_AGUARDANDO_ENVIO = 'Utilize F1 do Painel para Reenviar';
  var
    qryPdfNFCe: TUniQuery;
begin
  Result := False;
  AblnSemImpressaoPrevista := False;

  qryPdfNFCe := fCriaQuery(nil);
  try
    qryPdfNFCe.SQL.Text := 'SELECT                                                 ' +
                           '  L.NFE_STATUS,                                        ' +
                           '  L.NFE_OBSERV,                                        ' +
                           '  IF(P.NFE_ACESSO IS NULL, 0, 1) AS TEMPDF             ' +
                           'FROM                                                   ' +
                           '  LOGNFE L                                             ' +
                           '  LEFT JOIN PDFNFE P ON L.NFE_ACESSO = P.NFE_ACESSO    ' +
                           'WHERE                                                  ' +
                           '  L.NFE_NUMDOC = :NUMDOC AND                           ' +
                           '  L.NFE_ESPDOC = :ESPDOC AND                           ' +
                           '  L.NFE_CODEMP = :CODEMP AND                           ' +
                           '  L.NFE_CODCLI = :CODCLI                               ' +
                           'LIMIT 1                                                ';
    qryPdfNFCe.ParamByName('NUMDOC').AsString := AstrNumDoc;
    qryPdfNFCe.ParamByName('ESPDOC').AsString := AstrEspDoc;
    qryPdfNFCe.ParamByName('CODEMP').AsString := AstrCodEmp;
    qryPdfNFCe.ParamByName('CODCLI').AsString := AstrCodCli;
    qryPdfNFCe.Open;

    {**********************************************************************}
    {* SEM LOGNFE, OU COM ERRO / DENEGADA / ENVIADA AO PAINEL / CANCELADA  *}
    {* / INUTILIZADA: O PDF NAO SERA GERADO AGORA, ENTAO NAO HA O QUE      *}
    {* AGUARDAR. EM CONTINGENCIA (OF) A NFC-e E IMPRESSA, ENTAO AGUARDA.   *}
    {**********************************************************************}
    If qryPdfNFCe.IsEmpty Then
    Begin
      AblnSemImpressaoPrevista := True;
      Exit;
    End;

    Result := (qryPdfNFCe.FieldByName('TEMPDF').AsInteger = 1);

    If Not Result Then
    Begin
      AblnSemImpressaoPrevista := MatchStr(qryPdfNFCe.FieldByName('NFE_STATUS').AsString,
                                           ['EE', 'DN', 'AE', 'CN', 'IN']);

      {********************************************************************}
      {* EE GRAVADO ANTES DA TRANSMISSAO ('Utilize F1 do Painel para Reen-*}
      {* viar...'): AINDA NAO HOUVE RETORNO DA LIBNFE, CONTINUA AGUARDANDO *}
      {********************************************************************}
      If (qryPdfNFCe.FieldByName('NFE_STATUS').AsString = 'EE') And
         (AnsiStartsText(STR_OBSERV_AGUARDANDO_ENVIO, Trim(qryPdfNFCe.FieldByName('NFE_OBSERV').AsString))) Then
        AblnSemImpressaoPrevista := False;
    End;
  finally
    FreeAndNil(qryPdfNFCe);
  end;
end;

{******************************************************************************}
{* COM A NFC-e IMPRESSA PELO NFeImpressao.exe (PRNFCE), A IMPRESSAO OCORRE EM *}
{* PROCESSO EXTERNO E ASSINCRONO, CONCORRENDO COM O COMPROVANTE TEF NA MESMA  *}
{* IMPRESSORA DE CUPOM. AGUARDA O PDF DE CADA NFC-e SER GERADO (PDFNFE) ANTES *}
{* DE LIBERAR A IMPRESSAO DO TEF, LIMITADO A 20 SEGUNDOS POR DOCUMENTO -      *}
{* DEPOIS DISSO, OU SE A NFC-e ESTIVER EM ERRO, O TEF SEGUE NORMALMENTE.      *}
{******************************************************************************}
procedure TfrmFatConfOrcamentos.pAguardarImpressaoNFCeAntesDoTEF;
  const
    INT_TEMPO_MAXIMO_ESPERA_MS  = 20000;
    INT_INTERVALO_CONSULTA_MS   = 500;
    INT_INTERVALO_MENSAGENS_MS  = 100;
  var
    intContador: Integer;
    dadosImpressao: TDadosImpressaoVenda;
    swtEspera: TStopwatch;
    blnSemImpressaoPrevista: Boolean;
    intProximaConsultaMs: Int64;
begin
  If Not fCfgSis('PRNFCE', varBoolean) Then
    Exit;

  If (Not Assigned(fatVenda)) Or (Not Assigned(fatVenda.objFatVendaImp)) Then
    Exit;

  For intContador := 0 To fatVenda.objFatVendaImp.ItemsCount -1 Do
  Begin
    dadosImpressao := fatVenda.objFatVendaImp[intContador];

    If dadosImpressao.strEspDoc <> 'IF' Then
      Continue;

    {* O TEMPO MAXIMO DE ESPERA E CONTADO POR DOCUMENTO *}
    swtEspera := TStopwatch.StartNew;
    try
      While (Not fPdfNFCeGerado(dadosImpressao.strNumDoc,
                                dadosImpressao.strEspDoc,
                                dadosImpressao.strEmpDoc,
                                dadosImpressao.strCodCli,
                                blnSemImpressaoPrevista)) Do
      Begin
        If blnSemImpressaoPrevista Then
          Break;

        If swtEspera.ElapsedMilliseconds >= INT_TEMPO_MAXIMO_ESPERA_MS Then
          Break;

        {* CONSULTA O BANCO A CADA 500 MS, MAS PROCESSA AS MENSAGENS DA TELA A CADA 100 MS *}
        intProximaConsultaMs := swtEspera.ElapsedMilliseconds + INT_INTERVALO_CONSULTA_MS;
        While swtEspera.ElapsedMilliseconds < intProximaConsultaMs Do
        Begin
          pProcessMessages;
          Sleep(INT_INTERVALO_MENSAGENS_MS);
        End;
      End;
    except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmFatConfOrcamentos.pAguardarImpressaoNFCeAntesDoTEF: ' +
                                  dadosImpressao.strNumDoc + '-' + dadosImpressao.strEspDoc + ']');
    end;
  End;
end;

function TfrmFatConfOrcamentos.fConfirmaVendaTefCitel : Boolean;
var
  intCont : Integer;
begin
  Result := False;

  for intCont := 0 to length(arrCartoes) -1 do
  begin
    if fVerificaUtilizouTEFCitel(arrCartoes[intCont].strViaCli, arrCartoes[intCont].strViaLoj) then
    begin
      if arrCartoes[intCont].blnTefCnf then
      begin
        pAtualizaDadosFaturamentoTef(
          strIncDoc,
          strTabela,
          IntToStr(fatVenda.intSeqCon),
          arrCartoes[intCont].strViaCli,
          arrCartoes[intCont].strViaLoj,
          arrCartoes[intCont].strNumDoc,
          arrCartoes[intCont].strDtaTra);
      end
      else
      begin
        try
          fFinalizaCartao(arrCartoes[intCont].strNumDoc,
                          arrCartoes[intCont].strDtaTra,
                          arrCartoes[intCont].strHraTra,
                          arrCartoes[intCont].strViaCli,
                          arrCartoes[intCont].strViaLoj,
                          arrCartoes[intCont].strNumNsu,
                          strIncDoc,
                          strTabela,
                          arrCartoes[intCont].fltValDig,
                          arrCartoes[intCont].strViaCli + #13 + arrCartoes[intCont].strViaLoj,
                          IntToStr(fatVenda.intSeqCon),
                          arrCartoes[intCont].strControle);
        finally
          arrCartoes[intCont].strStatusCartao := 'F';
          Result := True;
        end;
      end;
    end;
  end;
end;

function TfrmFatConfOrcamentos.fChamaTelaDeOperacoes(fltValDig : Double;
                                                     strNumDoc : String;
                                                     out intQtdParc : Integer;
                                                     out intOperacao : Integer;
                                                         AobjDadosAdicionaisTefTra: IDadosAdicionaisTefTra;
                                                     const AValidaParcelas: IDadosValidaParcelas = nil): IRetornoTEFCitel;
  var
    frmTefCitelOperacoes : TfrmTefCitelOperacoes;
    strOpeRcx : String;
begin
  pCriarFormularios(TfrmTefCitelOperacoes, frmTefCitelOperacoes);
  objTefCitel.AdicionaObserver(frmTefCitelOperacoes);
  try
    strOpeRcx := IIF(fEmptyStr(strCodOpe), strLoginUsuarioLogado, strCodOpe);

    frmTefCitelOperacoes.fltValor                   := fltValDig;
    frmTefCitelOperacoes.strNumDoc                  := strNumDoc;
    frmTefCitelOperacoes.strRcxCodOpe               := strOpeRcx;
    frmTefCitelOperacoes.objDadosAdicionaisTefTra   := AobjDadosAdicionaisTefTra ;
    frmTefCitelOperacoes.objValidaParcelas          := AValidaParcelas ;
    frmTefCitelOperacoes.blnApenasDebito            := (fRetTipoCartao(strCodCarPed) = 'D');

    if frmTefCitelOperacoes.ShowModal = mrOk then
    begin
      Result      := frmTefCitelOperacoes.RetornoTEFCitel;
      intQtdParc  := frmTefCitelOperacoes.intQtdParcelas;
      intOperacao := frmTefCitelOperacoes.intOperacao;
      strModalidade := frmTefCitelOperacoes.strModalidade;
    end
    else
      Result := nil;
  Finally
    objTefCitel.RemoveObserver(frmTefCitelOperacoes);
    pFreeAndNil(frmTefCitelOperacoes);
  End;
end;

procedure TfrmFatConfOrcamentos.pDesfazCheckoutTemp(cdsItens : TUniClientDataSet; blnConclusao : Boolean);
begin
  try
    cdsItens.First;
    while not cdsItens.Eof do
    begin
      if cdsItens.FieldByName('ITE_CHKOUT').AsInteger <> 0 then
      begin
        fGravaCheckout(cdsItens.FieldByName('ITE_CHKOUT').AsInteger,
                       strCodOpe,
                       edtCodCli.Text,
                       strDigCodVen,
                       cdsItens.FieldByname('ITE_CODBAR').AsString,
                       cdsItens.FieldByname('ITE_CODITE').AsString,
                       cdsItens.FieldByname('ITE_DESITE').AsString,
                       cdsItens.FieldByname('UNI_DESUNI').AsString,
                       cdsItens.FieldByname('ITE_QTDITE').AsFloat,
                       cdsItens.FieldByname('ITE_UNITAR').AsFloat,
                       fFormataFloat(cdsItens.FieldByname('ITE_QTDITE').AsFloat * cdsItens.FieldByname('ITE_UNITAR').AsFloat, 2),
                       VS_ComputerNetName,
                       VS_IPAddressAsString,
                       VS_UserFromWindows,
                       'E',
                       blnConclusao,
                       FcdsChkOut,
                       FcdsLogChk);

        cdsItens.Edit;
        cdsItens.FieldByName('ITE_CHKOUT').AsString := '0';
        cdsItens.Post;
      end;

      cdsItens.Next;
    end;
    //persiste o controle.
    pPersisteChkOut(FcdsChkOut, 'CHKOUT') ;
    pPersisteChkOut(FcdsLogChk, 'LOGCHK') ;
  except
    //
  end;
end;

procedure TfrmFatConfOrcamentos.pAdicionaItensChkOutTemp(cdsItens : TUniClientDataSet);
begin
  cdsItensChkOut.Data := cdsItens.Data;
  cdsItensChkOut.EmptyDataSet;

  cdsItens.First;
  while not cdsItens.Eof do
  begin
    cdsItensChkOut.Append;
    cdsItensChkOut.FieldByName('ITE_CODITE').AsString := CdsItens.FieldByName('ITE_CODITE').AsString;
    cdsItensChkOut.FieldByName('ITE_CHKOUT').AsString := CdsItens.FieldByName('ITE_CHKOUT').AsString;
    cdsItensChkOut.FieldByname('ITE_CODBAR').AsString := CdsItens.FieldByName('ITE_CODBAR').AsString;
    cdsItensChkOut.FieldByname('ITE_CODITE').AsString := CdsItens.FieldByName('ITE_CODITE').AsString;
    cdsItensChkOut.FieldByname('ITE_DESITE').AsString := CdsItens.FieldByName('ITE_DESITE').AsString;
    cdsItensChkOut.FieldByname('UNI_DESUNI').AsString := CdsItens.FieldByName('UNI_DESUNI').AsString;
    cdsItensChkOut.FieldByname('ITE_QTDITE').AsFloat  := CdsItens.FieldByName('ITE_QTDITE').AsFloat;
    cdsItensChkOut.FieldByname('ITE_UNITAR').AsFloat  := CdsItens.FieldByName('ITE_UNITAR').AsFloat;
    cdsItensChkOut.Post;

    cdsItens.Next;
  end;
end;

function TfrmFatConfOrcamentos.fTroca007Para012 : Boolean;
{RETORNA SE HOUVE ESSA TROCA ESPECÍFICA, QUE GERA UM ERRO PONTUAL, CORRIGIDO COM ALGUNS TRATAMENTOS
QUE IRÁ VERIFICÁ-LA - KM}
Begin
  Result := (fatVenda.strCodFpg <> strFpgOrc) And (Pos(strFpgOrc, '007') > 0) And (Pos(fatVenda.strCodFpg, '012') > 0);
End;

function TfrmFatConfOrcamentos.fDestacarRetencoesServicos: Boolean;
begin
  Result := False;

  If not Assigned(fatVenda) Then
    Exit;

  If not ((fatVenda.strRetPCo = 'S') Or (fatVenda.strRetIrf = 'S')) Then
    Exit;

  If fatVenda.fSomenteItensDeServico(fatVenda.arrMatItens) Then
    Exit(True);

  If fatVenda.fRetemImpostosNoDescontoEspecial Then
    Exit;

  If not (fatVenda.strCDesPI = 'S') Then
    Exit;

  Result := True;
end;

procedure TfrmFatConfOrcamentos.pDestacaRetencoesServicos;
begin
  fatVenda.pDestacaRetencoes;
  fatVenda.pCalculaTotGer(False, False);

  If (fatVenda.fTotalRetencoesServicos > 0) Then
  Begin
    fatVenda.pCalculaTotalParaCadRec;

    fDigDuplic(fatVenda.arrDuplicata, fatVenda.strConPag, 0,
       fatVenda.fltTotCadRec - fatVenda.fltValAdt,
       False, True, False, fatVenda.dtaDigDup, False, fatVenda.fltImpFre, 'N',
       fCfgSis('DUPRED', varBoolean), True, fatVenda.fltValAdt, True,
       Nil, '', True, True, fatVenda.pMostraContaCorrenteCliente);

    edtTotGer.Text := FloatToStrF( fStrToFloat(edtTotGer.Text) - fatVenda.fTotalRetencoesServicos, ffFixed, 12, 2);
    edtValor.Value := edtValor.Value - fatVenda.fTotalRetencoesServicos;
  End;
end;

procedure TfrmFatConfOrcamentos.pValidaTicketEstacionamento;
  Var
    objTicket: TTicketEstacionamento;
begin
  objTicket := TTicketEstacionamento.Create(fatVenda, strToFloatDef(edtTotGer.Text, 0));

  Try
    objTicket.pValidar;
  Finally
    FreeAndNil(objTicket);
  End;
end;

function TfrmFatConfOrcamentos.fPermiteCupomFiscalComIPI: Boolean;
begin
  Result := False;

  If not fEmptyStr(fatVenda.strNumOrc) Then
    Exit;

  If not (fatVenda.strEspDoc = 'IF') Then
    Exit;

  If not fCfgSis('IMPDIR', varBoolean) Then
    Exit;

  If not fCfgSis('CUPIPI', varBoolean) Then
    Exit;

  Result := True;
end;

function TfrmFatConfOrcamentos.fRetornaPortadorCredito: String;
  Var
    frmBaixaAnalitica : TfrmBaixaAnalitica;
begin
  Result := '';
  pCriarFormularios(TfrmBaixaAnalitica, frmBaixaAnalitica);
  Try
    frmBaixaAnalitica.Panel1.Visible := False;
    frmBaixaAnalitica.fraPlanoDeContasCre.Visible := False;
    frmBaixaAnalitica.fraCentroCusto.Visible := False;
    frmBaixaAnalitica.gpbDescontoAntecipacao.Visible := False;
    frmBaixaAnalitica.fraPlanoDeContasCre.MskCodCta.Visible := False;
    frmBaixaAnalitica.pgcDados.Visible := False;
    frmBaixaAnalitica.pnlFundo.Height :=57;
    frmBaixaAnalitica.Height := 132;
    frmBaixaAnalitica.blnFrmRcxResumoCaixa := True;
    frmBaixaAnalitica.blnSomentePortador := True;
    frmBaixaAnalitica.edtPorDeb.Visible := False;
    frmBaixaAnalitica.ShowModal;

    If frmBaixaAnalitica.blnConfirma Then
     Result := frmBaixaAnalitica.strPorBai;
  Finally
    pFreeAndNil(frmBaixaAnalitica);
  End;
end;

procedure TfrmFatConfOrcamentos.pSetFunctionsEventosCadPro(const AFatVenda : TFatVenda);
begin
  TEventosCadPro.fncGetUnitarioEmbalagemFechada := AFatVenda.fGetUnitarioEmbalagemFechada;
  TEventosCadPro.fncUFDestTrib := AFatVenda.fUFDestTrib;
  TEventosCadPro.fncUFEmpresa := AFatVenda.fGetUFEmpresa;
  TEventosCadPro.fncPegaPrecoVenda := AFatVenda.objIcStPv.fPegaPrecoVenda;
  TEventosCadPro.fncPegaIcmsSai := AFatVenda.fGetIcmSai;
  TEventosCadPro.fncOpcDoc := AFatVenda.GetStrOpcDoc;
  TEventosCadPro.fncQueryEmCacheTrouxeAlgumRegistro := fQueryEmCacheTrouxeAlgumRegistro;
end;

procedure TfrmFatConfOrcamentos.pClearFunctionsEventosCadPro;
begin
  TEventosCadPro.fncQueryEmCacheTrouxeAlgumRegistro := nil;
  TEventosCadPro.fncGetUnitarioEmbalagemFechada := nil;
  TEventosCadPro.fncUFDestTrib := nil;
  TEventosCadPro.fncUFEmpresa := nil;
  TEventosCadPro.fncPegaPrecoVenda := nil;
  TEventosCadPro.fncPegaIcmsSai := nil;
  TEventosCadPro.fncOpcDoc := nil;
end;

procedure TfrmFatConfOrcamentos.pSetFunctionsEventosCadProFatVenda;
begin
  If Assigned(fatVenda) Then
    pSetFunctionsEventosCadPro(fatVenda)
  Else
    pClearFunctionsEventosCadPro;
end;

end.
