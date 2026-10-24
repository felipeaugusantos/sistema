{***************************}
{* qryConTra -> CADTRA     *}
{* qryConCfo -> CADCFO     *}
{* qryConCta -> CADCTA     *}
{************************JB*}
{***************************}
{* qryConCfo -> CADCFO     *}
{************************RV*}
unit untFatDadosFiscais;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons,
  ExtCtrls, QColorLabel, EditFocus, untFuncFat, StrUtils, Mask,
  MaskEditFocus, Uni, Math, AppEvnts, UniClientDataSet, UniDataSetProvider,
  cxHint, BitBtnLockedIncrem, ComboBoxFocus, dxScreenTip,
  untFuncFatTypes, cxClasses, dxCustomHint, Vcl.Samples.Gauges, frxClass,
  frxExportCSVTestabilidade, untLiberacao, untFatRegrasImpostos, untTypesSistema,
  untFrameCentroCustoEditFocus, untDadosFechamentoVendaTransportadoraFrame,
  untDadosFechamentoVendaObraFrame, untDadosFechamentoVendaBombeamentoFrame,
  untDadosFechamentoVendaMSGExpFrame, untDadosFechamentoVendaMSGFatFrame,
  untDadosFechamentoVendaClaFisFrame, untDadosFechamentoVendaPlanContasFrame,
  untDadosFechamentoVendaTotaisFrame, untDadosFechamentoVendaProjetoFrame,
  untDadosFechamentoVendaTipoFaturamentoFrame,
  untDadosFechamentoVendaGravarContasFrame, untNumeroDrawbackFrame,
  untReferenciarDocumentosExterior, untEmpresaFaturamentoFrame,
  untValidacoesFrete, untTPerfilDespachanteAduaneiro;

type
  TrecSalvaImp = Record
    fltBasIcm,
    fltValIcm,
    fltBasIpi,
    fltValIpi,
    fltBasRet,
    fltValRet: Double;
  End;

  TrecConfiguracaoNotaDeImportacaoDesonerada = Record
    strCstPis : String;
    strCstCof : String;
    strCstIpi : String;
    strEnqIpi : String;
  End;

  TfrmFatDadosFiscais = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    pnlTransportadora: TPanel;
    pnlMensagem: TPanel;
    pnlResImp: TPanel;
    pnlDesconto: TPanel;
    pnlGravaFinanceiro: TPanel;
    pnlMenExp: TPanel;
    pnlEvento: TPanel;
    pnlDadSer: TPanel;
    HintControler: TcxHintStyleController;
    tmrHideHints: TTimer;
    btnConfirmaDados: TBitBtnLocked;
    btnDadAdi: TBitBtnLocked;
    btnDigImpostosItens: TBitBtnLocked;
    btnMostraMargem: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    btnVerImpostos: TBitBtnLocked;
    pnlBombeamento: TPanel;
    pnlProgresso: TPanel;
    pgbProgresso: TGauge;
    lblProgresso: TLabel;
    FlwPblConfirma: TFlowPanel;
    pnlProjeto: TPanel;
    fraCentroCusto: TfraCentroCustoEditFocus;
    fraDadosFechamentoVendaTransportadoraFrame: TfraDadosFechamentoVendaTransportadoraFrame;
    fraDadosFechamentoVendaObraFrame: TfraDadosFechamentoVendaObraFrame;
    fraDadosFechamentoVendaBombeamentoFrame: TfraDadosFechamentoVendaBombeamentoFrame;
    fraDadosFechamentoVendaMSGExpFrame: TfraDadosFechamentoVendaMSGExpFrame;
    fraDadosFechamentoVendaClaFisFrame: TfraDadosFechamentoVendaClaFisFrame;
    fraDadosFechamentoVendaMSGFatFrame: TfraDadosFechamentoVendaMSGFatFrame;
    fraDadosFechamentoVendaPlanContasFrame: TfraDadosFechamentoVendaPlanContasFrame;
    fraDadosFechamentoVendaTotaisFrame: TfraDadosFechamentoVendaTotaisFrame;
    fraDadosFechamentoVendaProjetoFrame: TfraDadosFechamentoVendaProjetoFrame;
    fraDadosFechamentoVendaTipoFaturamentoFrame: TfraDadosFechamentoVendaTipoFaturamentoFrame;
    fraDadosFechamentoVendaGravarContasFrame: TfraDadosFechamentoVendaGravarContasFrame;
    btnEspRascNF: TBitBtnLocked;
    pnlDrawBack: TPanel;
    fraNumeroDrawbackFrame: TfraNumeroDrawbackFrame;
    pnlTipAte: TPanel;
    lblTipAte: TLabel;
    edtDesTpa: TEditFocus;
    edtCodTpa: TEditFocus;
    pnlRefDocDadosFiscais: TPanel;
    fraReferenciarDocumentosExterior: TfraReferenciarDocumentosExterior;
    pnlEmpfat: TPanel;
    fraEmpresaFaturamentoFrame1: TfraEmpresaFaturamentoFrame;
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure edtClaFisKeyPress(Sender: TObject; var Key: Char);
    procedure edtQtdTraKeyPress(Sender: TObject; var Key: Char);
    procedure mskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure ckbOFGravaCTPClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDadAdiClick(Sender: TObject);
    procedure edtTotGerExit(Sender: TObject);
    procedure edtMens01Exit(Sender: TObject);
    procedure edtMens02Exit(Sender: TObject);
    procedure edtMens03Exit(Sender: TObject);
    procedure btnDigImpostosItensClick(Sender: TObject);
    procedure edtDesAceExit(Sender: TObject);
    procedure edtValFreExit(Sender: TObject);
    procedure edtValFreEnter(Sender: TObject);
    procedure btnCalcFreSugClick(Sender: TObject);
    procedure btnCalcVolumeClick(Sender: TObject);
    procedure btnMostraMargemClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tmrHideHintsTimer(Sender: TObject);
    procedure edtAlqIcmExit(Sender: TObject);
    procedure edtBasIcmExit(Sender: TObject);
    procedure edtValIcmExit(Sender: TObject);
    procedure btnVerImpostosClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtQtdBomExit(Sender: TObject);
    procedure btnDespesasFaturamentoClick(Sender: TObject);
    procedure edtClaFisExit(Sender: TObject);
    procedure chkTaxMinClick(Sender: TObject);
    procedure chkEst_DvClick(Sender: TObject);
    procedure edtCodSitKeyPress(Sender: TObject; var Key: Char);
    procedure edtValRetExit(Sender: TObject);
    procedure btnNotExpClick(Sender: TObject);
    procedure lblEdiPesClick(Sender: TObject);
    procedure cmbNatOpeExit(Sender: TObject);
    procedure cmbNatOpeEnter(Sender: TObject);
    procedure ckbGravaCTRClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtAlqFCPSTExit(Sender: TObject);
    procedure edtBasFCPSTExit(Sender: TObject);
    procedure edtPesLiqExit(Sender: TObject);
    procedure edtPesBruExit(Sender: TObject);
    procedure edtCodPrjKeyPress(Sender: TObject; var Key: Char);
    procedure edtMens04Exit(Sender: TObject);
    procedure edtMens05Exit(Sender: TObject);
    procedure edtValIpiChange(Sender: TObject);
    procedure fraDadosFechamentoVendaTransportadoraFrameedtDesAceChange(
      Sender: TObject);
    procedure fraDadosFechamentoVendaPlanContasFramemskCodCtaExit(
      Sender: TObject);
    procedure fraDadosFechamentoVendaPlanContasFramemskCodCtaEnter(
      Sender: TObject);
    procedure fraDadosFechamentoVendaBombeamentoFrameedtRedISSExit(
      Sender: TObject);
    procedure fraDadosFechamentoVendaTotaisFrameedtBasIssExit(Sender: TObject);
    procedure btnEspRascNFClick(Sender: TObject);
    procedure edtCodTpaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure fraEmpresaFaturamentoFrame1edtCodEmpFatKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraReferenciarDocumentosExteriorbtnRefeDocClick(Sender: TObject);
    procedure fraDadosFechamentoVendaTransportadoraFramebtnHlpDesClick(
      Sender: TObject);
    procedure fraDadosFechamentoVendaTotaisFrameedtPerFCPExit(Sender: TObject);
    procedure fraDadosFechamentoVendaTotaisFrameedtVlrFCPExit(Sender: TObject);
    procedure fraDadosFechamentoVendaTransportadoraFramechkRetornoPorRecusaClick(Sender: TObject);
  private
    { Private declarations }
    objValidacoesFrete : TValidacoesFrete;
    recSalvaImp: TrecSalvaImp;
    recConfiguracaoNotaDeImportacaoDesonerada: TrecConfiguracaoNotaDeImportacaoDesonerada;

    strCodTraAnt: String;
    strTipFreAnt: String;
    strDesClaAnt: String;
    fltValFreAnt: Double;
    fltValFreAntTrava: Double;

    strPesBruAnt: String;
    strPesLiqAnt: String;

    intPnlCon: Integer;
    intpnlSta: Integer;
    intPnlTra: Integer;
    intPlMeEx: Integer;
    intPnlEve: Integer;
    intPnlMen: Integer;
    intPnlRes: Integer;
    intPnlDes: Integer;
    intPnlOFC: Integer;
    intPnlSer: Integer;
    intPnlPrj: Integer;
    intPnlTpa: Integer;

    qryConCta: TUniQuery;
    qryConCfo: TUniQuery;
    qryCadCfo: TUniQuery;
    qryConTra: TUniQuery;
    qryCadTra: TUniQuery;

    intOpcCfo: Integer;

    intSemaforoConfirma: Integer;

    strCl1Ant: String;
    strCl2Ant: String;
    strCl3Ant: String;

    strInfoProcessamento: String;

    blnCalcFreteSugestaoRegia: Boolean;
    blnCalcFreteSugestaoTranp: Boolean;
    blnCalcFreteSugestaoItens: Boolean;
    blnSomenExibirSugestFrete: Boolean;
    blnCalcFreteSugestaoFaixa: Boolean;

    strFatCon : String;

    blnPesBruEna: Boolean;
    blnPesLiqEna: Boolean;
    blnPesBruRea: Boolean;
    blnPesLiqRea: Boolean;
    blnPesBruTab: Boolean;
    blnPesLiqTab: Boolean;

    strCCuFpg : String;

    objLiberacao  : TLiberacao;

    blnZeraFrete: Boolean;

    blnRespondeuPerguntaSeDesejaCarregarFrete: Boolean;
    blnLiberouTravaDeClassificacaoFiscalDeBonificacao: Boolean;

    blnMudouClassificacao : Boolean;

    fltDevolucaoEspelhoAD_ValFre: Double;
    fltDevolucaoEspelhoAD_DesAce: Double;

    cdsImpostos_Ant,
    cdsImpostos_Pos : TUniClientDataSet;
    qryConfiguracaoNotaDeImportacaoDesonerada: TUniQuery;
    cdsConfiguracaoNotaDeImportacaoDesonerada: TUniClientDataSet;
    dspConfiguracaoNotaDeImportacaoDesonerada: TUniDataSetProvider;

    edtZerIpi: TEditFocus;
    lblZerIpi: TLabel;
    lblLegIpi: TLabel;

    edtZerRet: TEditFocus;
    lblZerRet: TLabel;
    lblLegRet: TLabel;

    edtZerFCPST : TEditFocus;
    lblZerFCPST : TLabel;
    lblLegFCPST : TLabel;
    FblnEspRascDANFE: Boolean;

    FUsaTrocaDeCfopNaDigitacaoDeImpostos: Boolean;
    FUsuarioAlterouClassificacaoReforma: Boolean;
    FArrClaFisOriginalItens: TArray<String>;
    FStrClaFisOriginal1: String;
    FStrClaFisOriginal2: String;
    FStrClaFisOriginal3: String;
    FStrClassificacoesCalculadas: String;

    function fDeveAtualizarOsTotaisEmTela : Boolean;
    function fClassificacoesDaTela : String;
    function fClassificacoesDaTelaMudaram : Boolean;
    function fAplicouClassificacoesDaTelaNaMatriz : Boolean;
    procedure pGuardaClassificacoesOriginaisDosItens;
    procedure pJogaClassificacoesParaOsItens(const strClaAnt1, strClaAnt2, strClaAnt3 : String);
    function fGetInputPassarZeroEmitenteCIF: TInputPassarZeroEmitenteCIF;
    procedure pExibiValImpostosiConsiginacao;
    function fCriacdsImpostos : TUniClientDataSet;
    procedure pCopiaImpostos(cdsImpostos : TUniClientDataSet);
    procedure pProcessaDiferencas(blnTeveMotivoValorDesoneradoAlteradoManualemente: Boolean=False);

    Procedure pAjustaAlturaForm;
    procedure pEditaBases;
    procedure pCarregaCadTra;
    procedure pCarregaCadCfo(edtClassificacao: TEdit; blnAtualizaEdits: Boolean);
    procedure pCarregaCentroCusto;
    procedure pAtualizaEditsImpostos;
    procedure pAjustarAlturaFrameTotais;
    procedure pSalvaImpostosOriginais;
    procedure pAtualiza_fltRet_Sp;
    function fBloqueiaNotaTranf: Boolean;

    function fClassFiscalZeraIcmsOuAlteraCST: Boolean;

    function fFreteValidoDevolucao: Boolean;
    function fConfirmaDados: Boolean;
    procedure pConfirma;
    procedure pAtualizaMatItens(strClaNov, strClaVel, strClaDef: String);
    procedure pAtualizaMatItensOutrasSaidas(strClaNov : String);
    procedure pAjustaMensagens(strOpcDoc: String);
    procedure pCalculaFreteSugestao;
    Procedure pAjustaMensagemNC;
    procedure pAtualizaAlqIcm;
    procedure pAtualizaVlrIcm;
    procedure pAtualizaAlqFCPST;
    procedure pAtualizaVlrFCPST;
    procedure pAtualizaAlqFCP;
    procedure pAtualizaVlrFCP;

    procedure pAtualizaDadosAdicionaisNotImp;

    function fSeExpedicaoPermiteAlterarValorFrete(strCodTraPed, strCodTraNov: String;
                                                  fltValFrePed, fltValFreNov: Double): Boolean;

    procedure pCalculaTotalGeral;
    procedure pCalculaTotalBombeamento;
    procedure pValidaClassificacaoFiscalQuandoDesabilitada;

    procedure pCalculaComplementoIcmsComDiferimento;
    function fEhComplementoIcmsComDiferimento: Boolean;
    function fAlterouValorFrete: Boolean;
    function fAlterouValorFreteCotado: Boolean;
    function fAlterouDespesasAcessoria: Boolean;
    function fAlterouClassificacaoFiscal: Boolean;

    function fAlterouPesoBruto: Boolean;
    function fAlterouPesoLiqui: Boolean;

    procedure pAtualizaImpostosClassificacaoFiscal;

    procedure pOnProcessaItem(const item: TDadosFechamento; index, count: Integer; AInfo: String = '');
    function fCFOPMesmaCategoria: Boolean;
    function fCFOPMesmaCategoriaOutrasSaidasDeFornecedorDevolucao: Boolean;
    function fSugestaoCSTNotaComplem: String;
    function fRetornaMensagemClaDem : String;
    procedure pMostraBtnEdtInfDocExp(blnMostra: Boolean);
    procedure pAbreTelaDigPesoProduto;

    procedure pAplicaFatorPesBruLiq(strTipPes: String; fltPesOri, fltPesDig: Double);
    function fTemIcmsDesoneradoSuframa: Boolean;
    function fEhRestituicaoDeIcmsStOuEstoque: Boolean;
    function fTravaTransportadoraPoisJaFoiDefinido: Boolean;
    function  fMsgDevObrigatoria: Boolean;
    function fCarregaCentroCustoDev: Boolean;
    procedure pSetaCentroCusto(strCCusto: String);
    procedure pCarregaNatOperacao(strCodCfo: String);
    function fOutrasSaidasAbreviacaoIpi: Boolean;
    function fMensagemExiste(strMsg1, strMsg2, strMsg3, strMsg4, strMsg5, strMsgPrincipal: string): Boolean;
    function fLiberaNaoGravarContasPagar: Boolean;
    procedure pAvisaSobreGNRE;
    function fTransferenciaDeMarcadoriasValidandoEnquadramentoDeIPI(strOpcDoc, strClaFis: String): Boolean;
    function fZeraImpostoFaturaConsignacao(strClaFis : String) : Boolean;
    function fEhOutrasSaidasDeFornecedorDevolucao(strOpcDoc, strClaFis: String): Boolean; Overload;
    function fEhOutrasSaidasDeFornecedorDevolucao: Boolean; Overload;
    function fValidaAdiantamentoComClassificacaoFiscalDeVenda : Boolean;
    function fConfirmaAlteracaoFrete(Const fltValorFrete, fltNovoValorFrete: Double): Boolean;
    function fEhDevolucaoDeFornecedorComDiferimento: Boolean;
    function fExistePercentualDiferimentoParaDevolucaoDeFornecedor: Boolean;
    function fPermiteDefinicaoDoFrete: Boolean;
    function fEhClassificacaoDeOutrasSaidas(AClaFis: String): Boolean;
    function fPreValidacaoDeProdutoRevendaDentroDoEstado(strClaFis: String): Boolean;
    function fHabilitaDigitarTotalGeralParaNotaDeImportacao: Boolean;
    procedure pHabilitaDigitarTotalGeralParaNotaDeImportacao;
    procedure pCarregaConfiguracoesParaNotaDeImportacaoDesonerada;
    procedure pRetornaConfiguracoesParaNotaDeImportacaoDesonerada(strCodFis: String);
    function fUtilizarClassificacaoDaMatriz: Boolean;
    function fMaisDeUmaCfop: Boolean;
    function fDefineTipoDeFreteNoFaturamento: Boolean;
    procedure pDefineTipoDeFreteNoFaturamento;
    function fValidouPreenchimentoCFOPAtivoImobilizado(const strCFOP: String): Boolean;
    function fEhOutrasSaidasDeFornecedorDevolucaoComIcmsDesonerado(strCodFis: String; fltVrdIcm: Double): Boolean;
    procedure pAtualizaMotivoDesoneracaoItensDeOutrasSaidasDeFornecedor;
    procedure pNotaEspecialComplementarDeIPI;
    function fNotaEspecialAbreviacaoIpi: Boolean;
    function fNotaEspecialDevolucao: Boolean;
    function fNotaEspecialCfopOutrasSaidas: Boolean;
    function fApresentaTelaParaReferenciarNotaParaExportacao: Boolean;
    function fEhNotaOriginadaDaExpedicaoComSolicitacaoDeNotaReferenciada: Boolean;
    function fEhNotaEspecialComSolicitacaoDeNotaReferenciada: Boolean;
    function fEhVendaNormalFechadaEmDocumentoFiscalComSolicitacaoDeNotaReferenciada: Boolean;
    function fEhVendaNormalFechadaEmNotaEspecialComSolicitacaoDeNotaReferenciada: Boolean;
    function fTravaClassificacaoFiscalDeBonificacao(strClaFis: String): Boolean;
    function fInverteuPosicaoDasClassificacoes(const strClaAnt1, strClaAnt2 : String): Boolean;
    function fApresentaTelaParaReferenciarNotaOutrasSaidas: Boolean;
    function fApresentaTelaParaReferenciarNotaExpedicao: Boolean;
    function fApresentaTelaParaReferenciarNota: Boolean;
    procedure pCalcVolumeSepExclusiva;
    function fEhNotaComplementarDeCapa: Boolean;
    function fSomaDespesasAcessorias: Boolean;
    function fEhDevolucao: Boolean;
    procedure pSetaClassificacaoParaNotaDeImportacao;
    procedure pSetarHintDescontoEspecialComDesoneracao(const AExibeHint : Boolean);
    function fValidarAteracaoFreteGF: Boolean;
    procedure pSugereCFOPDevolucaoOutrasSaidasFornecedor;
    function fRetornaMensagemClaUC: String;
    function fHabilitarTrocaDeCfopNaDigitacaoDeImpostos: Boolean;
    function fHabilitarTrocaDeCfopNaDigitacaoDeImpostosParaNotaDeImportacao: Boolean;
    procedure pPreencheChavesAcesso;
    function fSomaDespesasAcessoriasImportacao: Double;
    function fSomaOutrasDespesasImportacaoDefinidoConfiguracao: Double;
    function fRetornaUFEmpresa: String;
    procedure btnConfirmaDadosOnClickVisualizacaoAd(Sender: TObject);
    function fRetornaQuantidadeDeItensNaNota(Itens: TMatrizFechamento): Double;
    function fDesabilitarPreenchimentoClassificacaoFiscal : Boolean;
    function fEhClassificacaoDeOutrasSaidasDeFornecedor(AClaFis: String): Boolean;
    function fExiteClassificacaoDeOutrasSaidasDeFornecedor: Boolean;
    function fValidaConsistenciaDasCfops: Boolean;
    function fValidaRetornoPorRecusa: Boolean;
  protected
    blnVisualizacaoEspelhoDevolucao: Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fOutrasSaidasFornecedorComVendaPresencial : Boolean;
  public
    { Public declarations }
    cdsImpostosDigitadosItens: TUniClientDataSet;
    PerfilDespachanteAduaneiro: TPerfilDespachanteAduaneiro;
    strDesAceAnt: String;
    strValFreAnt: String;
    strValFreOri: String;
    strClaFisAnt: String;
    strValFreCotAnt: string;

    blnConfirma: Boolean;
    blnPodeCancelar: Boolean;
    blnForcaEdiBas: Boolean;
    fatVenda: TFatVenda;

    blnNotImp: Boolean; // NOTA DE IMPORTACAO
    blnNotImpXML: Boolean; // NOTA DE IMPORTACAO - XML
    blnExpedicao: Boolean;
    blnBaixaRefugo:Boolean;
    fltOUTDesAce: Variant;
    blnMostraFreteCotado: Boolean;
    blnEhNotaEspecialFatorPorValor: Boolean;

    blnFatBaixaPedidoDev : Boolean;

    blnConfirmacaoEspelho : Boolean;
    blnEspelhoEnvioParaOFornecedor: Boolean;
    blnFatDadosFiscaisImpostosExterno: Boolean;

    blnNFCeComplementar: Boolean;
    blnOrigemEntradaDV: Boolean;

    pAfterCalcTotGer: procedure of object;
    fValidaValoresDivergentes: function(): Boolean of object;
    procedure pRateiaValorTaxaSiscomexNosItens;
    procedure pAtualizarImpostosDigitadosParaMatrizItens;
    procedure pAtualizaRodape;

    Class function fInformouDespesasAduaneiras(var recDespesasAduaneiras: TDespesasAduaneiras; blnReadOnly: Boolean = False): Boolean;
    procedure pConfirmDados;
    procedure pOnShow;
    function fEhConfirmacaoEspelhoEnvioFornecedor: Boolean;
    procedure pAplicarModoSomenteVisualizacaoEspelhoDevolucao(AOrigemEntradaDV:Boolean = False);
  end;

var
  frmFatDadosFiscais: TfrmFatDadosFiscais;
  fltTotIpiOri      : Double;
  fltTotRetOri      : Double;

implementation


uses   untFuncoes, untPesqAux, DB, untFatDadosAdicionais,
       untConstantes, untConsultas, untfuncoesSimples, untProjetos,
       untFatDadosFiscaisImpostos, untTipoFreteAtc,untFatImpostos, untNotCom,
       untPesoItem, Shared.Functions.Types, untDespAduaneiras, untValorPorExtenso,
       untAdiantamentoCliente, untGerarEspelhoRascunhoDANFE,
       untTFuncoesAuxiliaresPix, untCFOPNotaImportacao, untDefineCFOP,
       untTypesCFOP, Shared.Functions.Configuracoes;

{$R *.dfm}

function TfrmFatDadosFiscais.fCarregaCentroCustoDev: Boolean;
begin
  Result := (Pos(fatVenda.strOpcDoc, 'DV_OE_VN_') > 0) And
            (Not fEmptyStr(fCfgSis('CTRCDV')))         And
            (Not fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text)) And
            (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, VS_strClaDev) > 0);
end;

function TfrmFatDadosFiscais.fCFOPMesmaCategoria: Boolean;
    Var
      blnClaEh1ClaVen : Boolean;
      blnClaEh2ClaVen : Boolean;
      blnClaEh3ClaVen : Boolean;
      blnHaDivergente : Boolean;
      strCompleClaVen : String;
Begin
  strCompleClaVen := fRetComplementoStrClaDevBrinde(fatVenda.strOpcDoc);
  
  blnClaEh1ClaVen := (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, VS_strClaVen + strCompleClaVen) > 0);
  blnClaEh2ClaVen := (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text, VS_strClaVen + strCompleClaVen) > 0);
  blnClaEh3ClaVen := (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text, VS_strClaVen + strCompleClaVen) > 0);

  if fCfgSis('BRIVEN', varBoolean) then
  begin
    blnClaEh1ClaVen := blnClaEh1ClaVen Or (Pos(fCfgSis('CLABRI'), fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text) > 0);
    blnClaEh2ClaVen := blnClaEh2ClaVen Or (Pos(fCfgSis('CLABRI'), fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text) > 0);
    blnClaEh3ClaVen := blnClaEh3ClaVen Or (Pos(fCfgSis('CLABRI'), fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text) > 0);
  end;

  blnHaDivergente :=
            (blnClaEh1ClaVen And (((Not fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text)) And (Not blnClaEh2ClaVen)) Or ((Not fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text)) And (Not blnClaEh3ClaVen)))) Or
            (Not blnClaEh1ClaVen And (((Not fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text)) And (blnClaEh2ClaVen)) Or ((Not fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text)) And (blnClaEh3ClaVen))));

  If blnHaDivergente Then
    fMensagem('Atenção','Quando utilizado duas ou mais classificações fiscais, só é permitido um conjunto de classificações '+
                         'de venda ou um conjunto de classificações que não são de venda. Verifique a relação nas configurações do sistema', ['&OK']);

  Result := Not blnHaDivergente;
end;

function TfrmFatDadosFiscais.fCFOPMesmaCategoriaOutrasSaidasDeFornecedorDevolucao: Boolean;
    Var
      blnClaEh1ClaDev : Boolean;
      blnClaEh2ClaDev : Boolean;
      blnClaEh3ClaDev : Boolean;
      blnHaDivergente : Boolean;
Begin
  blnClaEh1ClaDev := (fEhOutrasSaidasDeFornecedorDevolucao(fatVenda.strOpcDoc, fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text));
  blnClaEh2ClaDev := (fEhOutrasSaidasDeFornecedorDevolucao(fatVenda.strOpcDoc, fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text));;
  blnClaEh3ClaDev := (fEhOutrasSaidasDeFornecedorDevolucao(fatVenda.strOpcDoc, fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text));;

  blnHaDivergente :=
            (blnClaEh1ClaDev And (((Not fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text)) And (Not blnClaEh2ClaDev)) Or ((Not fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text)) And (Not blnClaEh3ClaDev)))) Or
            (Not blnClaEh1ClaDev And (((Not fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text)) And (blnClaEh2ClaDev)) Or ((Not fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text)) And (blnClaEh3ClaDev))));

  If blnHaDivergente Then
    fMensagem('Atenção','Quando utilizado duas ou mais classificações fiscais, só é permitido um conjunto de classificações '+
                         'de Outras Saídas ou um conjunto de classificações de Devolução de Fornecedor. Verifique a relação nas configurações do sistema', ['&OK']);

  Result := Not blnHaDivergente;
end;

procedure TfrmFatDadosFiscais.pSalvaImpostosOriginais;
Begin
  With recSalvaImp Do
  Begin
    fltBasIcm := fatVenda.fltBasIcm;
    fltValIcm := fatVenda.fltTotIcm;
    fltBasIpi := fatVenda.fltBasIpi;
    fltValIpi := fatVenda.fltTotIpi;
    fltBasRet := fatVenda.fltBasRet;
    fltValRet := fatVenda.fltTotRet;
  End;  
End;

procedure TfrmFatDadosFiscais.pSetaCentroCusto(strCCusto: String);
begin
  fraDadosFechamentoVendaPlanContasFrame.mskCodCta.Text := strCCusto;
  pCarregaCentroCusto;
end;

procedure TfrmFatDadosFiscais.pSetaClassificacaoParaNotaDeImportacao;
  Var
    objCFOPNotaImportacao : TCFOPNotaImportacao;
    recInputDefine: TInputDefineClassificacaoFiscal;
    recInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  If (Not blnNotImp) Then
    Exit;

  FillChar(recInputDefine, SizeOf(recInputDefine), #0);
  FillChar(recInputOutputClassificacao, SizeOf(recInputOutputClassificacao), #0);
  objCFOPNotaImportacao := TCFOPNotaImportacao.Create(recInputDefine, objConfiguracoes, recInputOutputClassificacao);
  Try
    fatVenda.strClaFis := objCFOPNotaImportacao.GetClassificacao.Classificacao;
  Finally
    FreeAndNil(objCFOPNotaImportacao);
  End;
end;

procedure TfrmFatDadosFiscais.tmrHideHintsTimer(Sender: TObject);
begin
  inherited;
  If Screen.ActiveForm <> Self Then
    HintControler.HideHint;
end;

procedure TfrmFatDadosFiscais.btnCalcFreSugClick(Sender: TObject);
begin
  inherited;
  If (fatVenda.fPermitirFreteNoFaturamento) Then
  Begin
    pCalculaFreteSugestao;
    If (fatVenda.fltTotPro - fatVenda.fltDesEsp >= fatVenda.fltVlMinF) Then
     fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text := '0,00'
    Else If fMensagem('', 'Deseja carregar o valor do frete sugestão?', ['', '']) = 1 Then
      fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text := FormatFloat('#,##0.00', fatVenda.fRetFreSugCal);
  End;
end;

procedure TfrmFatDadosFiscais.btnCalcVolumeClick(Sender: TObject);
begin
  inherited;
  fraDadosFechamentoVendaTransportadoraFrame.edtQtdTra.Text := FloatToStrF(fatVenda.fRetVolumes, ffFixed, 12, 0);
  If fraDadosFechamentoVendaTransportadoraFrame.pnlVolumeSepExc.Visible Then
    pCalcVolumeSepExclusiva;
end;

procedure TfrmFatDadosFiscais.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatDadosFiscais.btnConfirmaDadosClick(Sender: TObject);
begin
  If InterlockedIncrement(intSemaforoConfirma) = 0 Then
  Begin

    If (fatVenda.intSemaforoCalculaTotGer > -1) Then
    Begin
      InterlockedDecrement(intSemaforoConfirma);
      Exit;
    End;

    Try
      pConfirma;
      InterlockedDecrement(intSemaforoConfirma);
    Except
      InterlockedDecrement(intSemaforoConfirma);
    End;
  End
  Else
    InterlockedDecrement(intSemaforoConfirma);
end;

procedure TfrmFatDadosFiscais.btnConfirmaDadosOnClickVisualizacaoAd(
  Sender: TObject);
begin
  blnConfirma := True;
  ModalResult := mrOk;
end;

function TfrmFatDadosFiscais.fValidaRetornoPorRecusa: Boolean;

  function fValidaChkRetornoPorRecusa: Boolean;
  begin
    Result := True;

    If not fraDadosFechamentoVendaTransportadoraFrame.chkEst_Dv.Visible Then
      Exit;

    If not fraDadosFechamentoVendaTransportadoraFrame.chkRetornoPorRecusa.Visible Then
      Exit;

    If fraDadosFechamentoVendaTransportadoraFrame.chkEst_Dv.Checked And fraDadosFechamentoVendaTransportadoraFrame.chkRetornoPorRecusa.Checked Then
      Exit(False);
  end;

  function fValidaChvRef: Boolean;
  var
    LContador1: Integer;
    LContador2: Integer;
    LChvRef: String;
  begin
    Result := True;

    If not fatVenda.blnRetornoPorRecusa Then
      Exit;

    If fatVenda.blnDevolucaoCompleta Then
      Exit;

    For LContador1 := 0 To Length(fatVenda.arrMatItens) -1 Do
    Begin
      LChvRef := fatVenda.arrMatItens[LContador1].strChvRef;

      For LContador2 := 0 To Length(fatVenda.arrMatItens) -1 Do
        If not (LChvRef = fatVenda.arrMatItens[LContador2].strChvRef) Then
          Exit(False);
    End;
  end;

begin
  Result := True;

  If not fValidaChkRetornoPorRecusa Then
  Begin
    fMensagem('Atenção', 'Selecione apenas um opção !' + #13 +
                         '"Nota Fiscal de Retorno por Recusa" ou "Estorno de Nota Fiscal não cancelada no prazo"', ['&OK']);
    Result := False;
    Exit;
  End;

  If not fValidaChvRef Then
  Begin
    fMensagem('Atenção', 'Para Nota Fiscal de Recusa Parcial, deve-se referenciar apenas uma nota fiscal de origem.', ['&OK']);
    Result := False;
    Exit;
  End;

end;

procedure TfrmFatDadosFiscais.pConfirma;
  Var
    intContador: Integer;

    strBasIcm: String;
    strTotIcm: String;
    strBasIpi: String;
    strTotIpi: String;
    strBasRet: String;
    strTotRet: String;
    strBasFCP: String;
    strTotFCP: String;
    strTotGer: String;

begin
  inherited;

  Try
    btnConfirmaDados.Enabled := False;

    If Not fValidarAteracaoFreteGF Then
      Exit;
    if (fatVenda.strOpcDocTrue = 'NW') And (Not fatVenda.blnBloquearRestaurarValoresEspeplhoGF) then
      fatVenda.blnBloquearRestaurarValoresEspeplhoGF := True;

    If fBloqueiaNotaTranf Then
    Begin
      blnConfirma := False;

      if not FblnEspRascDANFE then
        Close;

      Exit;
    End;

    If fMsgDevObrigatoria Then
    Begin
      blnConfirma := False;
      Exit;
    End;

    if not fValidaAdiantamentoComClassificacaoFiscalDeVenda then
    Begin
      blnConfirma := False;
      Exit;
    End;

    If not fValidaRetornoPorRecusa Then
    Begin
      blnConfirma := False;
      Exit;
    End;

    If (fAlterouClassificacaoFiscal()) Then
      strClaFisAnt := fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text;

    {**************************************************************************}
    {* DEVE VALIDAR O FRETE, DESPESAS ACESSORIAS E AS CLASSIFICACOES FISCAIS  *}
    {* CASO NAO FORAM ALTERADOS NAO IRA EXCLUIR OS IMPOSTOS DIGITADOS         *}
    {**********************************************************************JC**}
    If Not fValidaCampos(fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre, True) Then
      Exit;

    If Not fValidaCampos(fraDadosFechamentoVendaTransportadoraFrame.edtValFre, True) Then
      Exit;

    If Not fValidaCampos(fraDadosFechamentoVendaTransportadoraFrame.edtDesAce, True) Then
      Exit;

    If Not fValidaCampos(fraDadosFechamentoVendaClaFisFrame.edtClaFis, True) Then
      Exit;

    If Not fValidaCampos(fraDadosFechamentoVendaClaFisFrame.edtClaFi2, True) Then
      Exit;

    If Not fValidaCampos(fraDadosFechamentoVendaClaFisFrame.edtClaFi3, True) Then
      Exit;

    {**************************************************************************}
    {* VALIDAÇÃO ADICIONAL AQUI E NÃO NO fValidaCampos POR CONTA DA COMBINAÇÃO*}
    {* DE CFOPS                                                               *}
    {**********************************************************************VA**}
    //Outras entradas de Garantia nao valida CFOP. GB (menil)
    If fEmptyStr(fatVenda.strClaFisRecGarantia) And (Not fCFOPMesmaCategoria) Then
    Begin
      If fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled Then
        pSetFocus(fraDadosFechamentoVendaClaFisFrame.edtClaFis);
      Exit;
    End;

    If (fEhOutrasSaidasDeFornecedorDevolucao) And (Not fCFOPMesmaCategoriaOutrasSaidasDeFornecedorDevolucao) Then
    Begin
      If fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled Then
        pSetFocus(fraDadosFechamentoVendaClaFisFrame.edtClaFis);
      Exit;
    End;

    If fatVenda.fEhComplementoDeFrete Then
    Begin
      If (fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text) <= 0) Then
      Begin
        fMensagem('Atenção','Informe o valor do frete que deve ser complementado antes de continuar!',['&OK']);
        Exit;
      End;
    End;

    strBasIcm := fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Text;
    strTotIcm := fraDadosFechamentoVendaTotaisFrame.edtValIcm.Text;
    strBasIpi := fraDadosFechamentoVendaTotaisFrame.edtBasIpi.Text;
    strTotIpi := fraDadosFechamentoVendaTotaisFrame.edtValIpi.Text;
    strBasRet := fraDadosFechamentoVendaTotaisFrame.edtBasRet.Text;
    strTotRet := fraDadosFechamentoVendaTotaisFrame.edtValRet.Text;
    strBasFCP := fraDadosFechamentoVendaTotaisFrame.edtBasFCPST.Text;
    strTotFCP := fraDadosFechamentoVendaTotaisFrame.edtValFCPST.Text;
    strTotGer := fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.Text;

    If blnNotImp Then
      fatVenda.fltImpTot := fStrToFloat(strTotGer);

    If fVerificaCampos Then
    Begin

      fatVenda.strCodEve := fraCentroCusto.edtCodEve.Text;
      fatVenda.strCodObr := fraDadosFechamentoVendaObraFrame.edtCodObr.Text;
      fatVenda.strCodArt := fraDadosFechamentoVendaObraFrame.edtCodART.Text;
      fatVenda.strCodCno := fraDadosFechamentoVendaObraFrame.edtCodCno.Text;
      fatVenda.strInsImo := fraDadosFechamentoVendaObraFrame.edtInsImo.Text;
      fatVenda.strCodCib := fraDadosFechamentoVendaObraFrame.edtCodCib.Text;
      fatVenda.strPlaFat := fraDadosFechamentoVendaTransportadoraFrame.mskPlaFat.Text;

      If btnDigImpostosItens.Visible Or fEhNotaComplementarDeCapa Then
      Begin
        fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Text   := strBasIcm;
        fraDadosFechamentoVendaTotaisFrame.edtValIcm.Text   := strTotIcm;
        fraDadosFechamentoVendaTotaisFrame.edtBasIpi.Text   := strBasIpi;
        fraDadosFechamentoVendaTotaisFrame.edtValIpi.Text   := strTotIpi;
        fraDadosFechamentoVendaTotaisFrame.edtBasRet.Text   := strBasRet;
        fraDadosFechamentoVendaTotaisFrame.edtValRet.Text   := strTotRet;
        fraDadosFechamentoVendaTotaisFrame.edtBasFCPST.Text := strBasFCP;
        fraDadosFechamentoVendaTotaisFrame.edtValFCPST.Text := strTotFCP;
        fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.Text := strTotGer;
      End;

      If fConfirmaDados Then
      Begin
        If (fatVenda.strOpcDoc = 'OF') Then
          fatVenda.pCalculaPisCofinsLivro(fatVenda.strClaFis)
        Else
          fatVenda.pCalculaPisCofinsLivro;

        pAtualizarImpostosDigitadosParaMatrizItens;

        If blnNotImp Then
          pRateiaValorTaxaSiscomexNosItens;

        For intContador := 0 To Length(fatVenda.arrMatItens) -1 Do
        Begin
          If fStrToFloat( fraDadosFechamentoVendaTotaisFrame.edtBasFCPST.Text ) <= 0.0 Then
          Begin
            If fatVenda.arrMatItens[intContador].fltBasRet > 0 Then
            Begin
              fatVenda.arrMatItens[intContador].recDifalFCP.fltBasFcp := 0.0;
              fatVenda.arrMatItens[intContador].recDifalFCP.fltValFcp := 0.0;

              fatVenda.arrMatItens[intContador].VisualizarFcpIcmsST.fltBase     := 0;
              fatVenda.arrMatItens[intContador].VisualizarFcpIcmsST.fltAliquota := 0;
              fatVenda.arrMatItens[intContador].VisualizarFcpIcmsST.fltValor    := 0;
            End;
          End;

          If fStrToFloat( fraDadosFechamentoVendaTotaisFrame.edtBasRet.Text ) <= 0.0 Then
          Begin
            fatVenda.pZerarDadosStMatrizItens(intContador);
          End;

          If (fStrToFloat( fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Text ) <= 0.0) And (Not fatVenda.fEmissaoPedidoBrinde) Then
          Begin
            if fatVenda.arrMatItens[intContador].fltValRet = 0 then
            Begin
              fatVenda.pZerarDadosIcmsMatrizItens(True, intContador);

              fatVenda.arrMatItens[intContador].fltBas__S := 0.0;
              fatVenda.arrMatItens[intContador].fltAlq__S := 0.0;
            End;
          End;

          If fStrToFloat( fraDadosFechamentoVendaTotaisFrame.edtBasIpi.Text ) <= 0.0 Then
          Begin
            fatVenda.pZerarDadosIpiMatrizItens(True, intContador);
          End;

        End;

        For intContador := 0 To Length(fatVenda.arrAlqIcm) -1 Do
        Begin

          If fStrToFloat( fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Text ) <= 0.0 Then
          Begin
            fatVenda.arrAlqIcm[intContador].fltBasIcm := 0.0;
            fatVenda.arrAlqIcm[intContador].fltAlqIcm := 0.0;
            fatVenda.arrAlqIcm[intContador].fltValIcm := 0.0;
          End;

          If fStrToFloat( fraDadosFechamentoVendaTotaisFrame.edtBasIpi.Text ) <= 0.0 Then
          Begin
            fatVenda.arrAlqIcm[intContador].fltBasIpi := 0.0;
            fatVenda.arrAlqIcm[intContador].fltValIpi := 0.0;
          End;

        End;

        pCalculaFreteSugestao;

        pAvisaSobreGNRE;

        If (pnlEmpFat.Visible) Then
        Begin
          fatVenda.strEmpFatSemSaldo := fraEmpresaFaturamentoFrame1.edtCodEmpFat.Text;
          fatVenda.strEmpLog := VS_strCodEmp;
        End;

        If (Not fraDadosFechamentoVendaTransportadoraFrame.edtValFre.ReadOnly) And (Not blnSomenExibirSugestFrete) Then
        Begin
          If (blnCalcFreteSugestaoRegia) Or
             (blnCalcFreteSugestaoTranp) Or
             (blnCalcFreteSugestaoItens) Or
             ((fatVenda.strOpcDoc = 'DV') And (fCfgSis('SENZER', varBoolean))) Or
             (blnCalcFreteSugestaoFaixa) And
             (not blnZeraFrete) Then
          Begin
            If Not fatVenda.fValidaFreteSugestao(fatVenda.fltFreSug) Then
            Begin
              blnConfirma := False;
              Exit;
            End;
          End;
        End;


        If (fatVenda.fTravaAoZerarFrete(fltValFreAntTrava, fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text))) Then
        Begin
          If Not fatVenda.fValidaFreteDigitado(fltValFreAntTrava) Then
          Begin
            blnConfirma := False;
            Exit;
          End;
        End;

        if Assigned(fValidaValoresDivergentes) then
          if not fValidaValoresDivergentes then
            Exit;

        If (Assigned(objValidacoesFrete)) And (Not objValidacoesFrete.PermitePassarComFreteZeroEmitenteCIF(fGetInputPassarZeroEmitenteCIF)) Then
        Begin
          blnConfirma := False;
          Exit;
        End;

        If (Not fValidaConsistenciaDasCfops) Then
        Begin
          blnConfirma := False;
          Exit;
        End;

        btnConfirmaDados.Enabled := True;
        blnConfirma := True;

        If fEhRestituicaoDeIcmsStOuEstoque Then
          fatVenda.objNfeComplemento.strDescricao := fValorPorExtenso(fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.Text);

        If btnDigImpostosItens.Visible Then
          fatVenda.fltTotGer := fStrToFloat(fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.Text);

        if (not FblnEspRascDANFE) then
          Close;
      End;

    End;

  Finally
    btnConfirmaDados.Enabled := True;
    if (Not blnConfirma) And fatVenda.blnBloquearRestaurarValoresEspeplhoGF then
      fatVenda.blnBloquearRestaurarValoresEspeplhoGF := False;
  End;

end;

procedure TfrmFatDadosFiscais.pPreencheChavesAcesso;
  Const
    SQL_CHAVES = 'SELECT C.FIS_ACESSO '+
                 'FROM CADFIS C       '+
                 'LEFT JOIN MOVGER M ON M.GER_NUMFAT = C.FIS_NUMDOC '+
                 '                  AND M.GER_TIPFAT = C.FIS_ESPDOC '+
                 '                  AND M.GER_EMPFAT = C.FIS_CODEMP '+
                ' LEFT JOIN CADEMP CE ON CE.EMP_CODEMP = M.GER_CODEMP '+
                 'WHERE M.GER_NUMDOC = :NUMDOC '+
                 '  AND M.GER_CODEMP = CE.EMP_CODEMP '+
                 '  AND M.GER_ESPDOC = ''TE''  '+
                 '  AND M.GER_TIP_FC = ''C''   '+
                 '  AND CE.EMP_FORFIL = :CODFOR '+
                 '  AND C.FIS_ACESSO IS NOT NULL';
  Var
    intCont: Integer;
    qryChaves: TUniQuery;
begin
  inherited;
  qryChaves := fCriaQuery(Self);
  Try
    qryChaves.SQL.Text := SQL_CHAVES;
    For intCont := 0 To Length(fatVenda.arrMatItens) - 1 Do
    Begin
      qryChaves.Close;
      qryChaves.ParamByName('NUMDOC').AsString := fatVenda.arrMatItens[intCont].strDocDev;
      qryChaves.ParamByName('CODFOR').AsString := fatVenda.strCodCli;

      qryChaves.Open;

      If Not (qryChaves.IsEmpty) Then
      Begin
         If Not MatchStr(qryChaves.FieldByName('FIS_ACESSO').AsString, fatVenda.arrChaveNFReferenciaDocumentos) Then
         Begin
           SetLength(fatVenda.arrChaveNFReferenciaDocumentos, Length(fatVenda.arrChaveNFReferenciaDocumentos) + 1);
           fatVenda.arrChaveNFReferenciaDocumentos[Length(fatVenda.arrChaveNFReferenciaDocumentos) - 1] := qryChaves.FieldByName('FIS_ACESSO').AsString;
         End;
      End;
    End;
  Finally
    FreeAndNil(qryChaves);
  End;
end;

procedure TfrmFatDadosFiscais.pExibiValImpostosiConsiginacao;
begin
  If (Not Assigned(fatVenda)) Then
    Exit;
  If (fCfgSis('FAMECO', varString) <> '1') Then
  Begin
    If (fatVenda.fltValIpiZeradoFaturaConsignacao > 0) Then
    Begin
      If Not Assigned(edtZerIpi) Then
      Begin
        edtZerIpi := TEditFocus.Create(Self);
        edtZerIpi.Name := 'edtZerIpi';
        edtZerIpi.Parent := fraDadosFechamentoVendaTotaisFrame.pnlDados;

        lblZerIpi := TLabel.Create(Self);
        lblZerIpi.Name := 'lblZerIpi';
        lblZerIpi.Parent := fraDadosFechamentoVendaTotaisFrame.pnlDados;

        lblLegIpi := TLabel.Create(Self);
        lblLegIpi.Name := 'lblLegIpi';
        lblLegIpi.Parent := fraDadosFechamentoVendaTotaisFrame.pnlDados;

        lblZerIpi.Alignment := fraDadosFechamentoVendaTotaisFrame.lblBasIpi.Alignment;
        lblZerIpi.Font      := fraDadosFechamentoVendaTotaisFrame.lblBasIpi.Font;
        lblZerIpi.Width     := fraDadosFechamentoVendaTotaisFrame.lblBasIpi.Width;
        lblZerIpi.Height    := fraDadosFechamentoVendaTotaisFrame.lblBasIpi.Height;
        lblZerIpi.Left      := fraDadosFechamentoVendaTotaisFrame.lblBasIpi.Left;
        lblZerIpi.Top       := fraDadosFechamentoVendaTotaisFrame.lblBasIpi.Top;

        lblLegIpi.Font      := fraDadosFechamentoVendaTotaisFrame.lblValIpi.Font;
        lblLegIpi.Width     := fraDadosFechamentoVendaTotaisFrame.lblValIpi.Width;
        lblLegIpi.Height    := fraDadosFechamentoVendaTotaisFrame.lblValIpi.Height;
        lblLegIpi.Left      := fraDadosFechamentoVendaTotaisFrame.lblValIpi.Left;
        lblLegIpi.Top       := fraDadosFechamentoVendaTotaisFrame.lblValIpi.Top;

        edtZerIpi.Alignment := fraDadosFechamentoVendaTotaisFrame.edtBasIpi.Alignment;
        edtZerIpi.Font      := fraDadosFechamentoVendaTotaisFrame.edtBasIpi.Font;
        edtZerIpi.Width     := fraDadosFechamentoVendaTotaisFrame.edtBasIpi.Width;
        edtZerIpi.Height    := fraDadosFechamentoVendaTotaisFrame.edtBasIpi.Height;
        edtZerIpi.Left      := fraDadosFechamentoVendaTotaisFrame.edtBasIpi.Left;
        edtZerIpi.Top       := fraDadosFechamentoVendaTotaisFrame.edtBasIpi.Top;
        edtZerIpi.Enabled   := False;
      End;

      lblZerIpi.Caption   := 'Valor IPI:';
      lblLegIpi.Caption   := 'Somado à Desp. Acess.';
      edtZerIpi.Text := FormatFloat('#,##0.00', fatVenda.fltValIpiZeradoFaturaConsignacao);
      lblZerIpi.Visible := True;
      lblLegIpi.Visible := True;
      edtZerIpi.Visible := True;

      fraDadosFechamentoVendaTotaisFrame.lblBasIpi.Visible := False;
      fraDadosFechamentoVendaTotaisFrame.edtBasIpi.Visible := False;
      fraDadosFechamentoVendaTotaisFrame.lblValIpi.Visible := False;
      fraDadosFechamentoVendaTotaisFrame.edtValIpi.Visible := False;
    End
    Else
    Begin
      If Assigned(edtZerIpi) Then
      Begin
        lblZerIpi.Visible := False;
        lblLegIpi.Visible := False;
        edtZerIpi.Visible := False;
      End;

      fraDadosFechamentoVendaTotaisFrame.lblBasIpi.Visible := True;
      fraDadosFechamentoVendaTotaisFrame.edtBasIpi.Visible := True;
      fraDadosFechamentoVendaTotaisFrame.lblValIpi.Visible := True;
      fraDadosFechamentoVendaTotaisFrame.edtValIpi.Visible := True;
    End;
  End;

  If (fatVenda.fltValSTZeradoFaturaConsignacao > 0) Then
  Begin
    If Not Assigned(edtZerRet) Then
    Begin
      edtZerRet := TEditFocus.Create(Self);
      edtZerRet.Name := 'edtZerRet';
      edtZerRet.Parent := fraDadosFechamentoVendaTotaisFrame.pnlDados;

      lblZerRet := TLabel.Create(Self);
      lblZerRet.Name := 'lblZerRet';
      lblZerRet.Parent := fraDadosFechamentoVendaTotaisFrame.pnlDados;

      lblLegRet := TLabel.Create(Self);
      lblLegRet.Name := 'lblLegRet';
      lblLegRet.Parent := fraDadosFechamentoVendaTotaisFrame.pnlDados;

      lblZerRet.Alignment := fraDadosFechamentoVendaTotaisFrame.lblBaseST.Alignment;
      lblZerRet.Font      := fraDadosFechamentoVendaTotaisFrame.lblBaseST.Font;
      lblZerRet.Width     := fraDadosFechamentoVendaTotaisFrame.lblBaseST.Width;
      lblZerRet.Height    := fraDadosFechamentoVendaTotaisFrame.lblBaseST.Height;
      lblZerRet.Left      := fraDadosFechamentoVendaTotaisFrame.lblBaseST.Left;
      lblZerRet.Top       := fraDadosFechamentoVendaTotaisFrame.lblBaseST.Top;

      lblLegRet.Font      := fraDadosFechamentoVendaTotaisFrame.lblVlrST.Font;
      lblLegRet.Width     := fraDadosFechamentoVendaTotaisFrame.lblVlrST.Width;
      lblLegRet.Height    := fraDadosFechamentoVendaTotaisFrame.lblVlrST.Height;
      lblLegRet.Left      := fraDadosFechamentoVendaTotaisFrame.lblVlrST.Left;
      lblLegRet.Top       := fraDadosFechamentoVendaTotaisFrame.lblVlrST.Top;

      edtZerRet.Alignment := fraDadosFechamentoVendaTotaisFrame.edtBasRet.Alignment;
      edtZerRet.Font      := fraDadosFechamentoVendaTotaisFrame.edtBasRet.Font;
      edtZerRet.Width     := fraDadosFechamentoVendaTotaisFrame.edtBasRet.Width;
      edtZerRet.Height    := fraDadosFechamentoVendaTotaisFrame.edtBasRet.Height;
      edtZerRet.Left      := fraDadosFechamentoVendaTotaisFrame.edtBasRet.Left;
      edtZerRet.Top       := fraDadosFechamentoVendaTotaisFrame.edtBasRet.Top;
      edtZerRet.Enabled   := False;
    End;

    lblZerRet.Caption   := 'Valor ST:';
    lblLegRet.Caption   := 'Somado à Desp. Acess.';
    edtZerRet.Text := FormatFloat('#,##0.00', fatVenda.fltValSTZeradoFaturaConsignacao);
    lblZerRet.Visible := True;
    lblLegRet.Visible := True;
    edtZerRet.Visible := True;

    fraDadosFechamentoVendaTotaisFrame.lblBaseST.Visible := False;
    fraDadosFechamentoVendaTotaisFrame.edtBasRet.Visible := False;
    fraDadosFechamentoVendaTotaisFrame.lblVlrST.Visible := False;
    fraDadosFechamentoVendaTotaisFrame.edtValRet.Visible := False;
  End
  Else
  Begin
    If Assigned(edtZerRet) Then
    Begin
      lblZerRet.Visible := False;
      lblLegRet.Visible := False;
      edtZerRet.Visible := False;
    End;

    fraDadosFechamentoVendaTotaisFrame.lblBaseST.Visible := True;
    fraDadosFechamentoVendaTotaisFrame.edtBasRet.Visible := True;
    fraDadosFechamentoVendaTotaisFrame.lblVlrST.Visible := True;
    fraDadosFechamentoVendaTotaisFrame.edtValRet.Visible := True;
  End;

  If (fatVenda.fltValFcpSTZeradoFaturaConsignacao > 0) Then
  Begin
    If Not Assigned(edtZerFCPST) Then
    Begin
      edtZerFCPST        := TEditFocus.Create(Self);
      edtZerFCPST.Name   := 'edtZerFCPST';
      edtZerFCPST.Parent := fraDadosFechamentoVendaTotaisFrame.pnlDados;

      lblZerFCPST        := TLabel.Create(Self);
      lblZerFCPST.Name   := 'lblZerFCPST';
      lblZerFCPST.Parent := fraDadosFechamentoVendaTotaisFrame.pnlDados;

      lblLegFCPST        := TLabel.Create(Self);
      lblLegFCPST.Name   := 'lblLegFCPST';
      lblLegFCPST.Parent := fraDadosFechamentoVendaTotaisFrame.pnlDados;

      lblZerFCPST.Alignment := fraDadosFechamentoVendaTotaisFrame.lblBaseFCPST.Alignment;
      lblZerFCPST.Font      := fraDadosFechamentoVendaTotaisFrame.lblBaseFCPST.Font;
      lblZerFCPST.Width     := fraDadosFechamentoVendaTotaisFrame.lblBaseFCPST.Width;
      lblZerFCPST.Height    := fraDadosFechamentoVendaTotaisFrame.lblBaseFCPST.Height;
      lblZerFCPST.Left      := fraDadosFechamentoVendaTotaisFrame.lblBaseFCPST.Left;
      lblZerFCPST.Top       := fraDadosFechamentoVendaTotaisFrame.lblBaseFCPST.Top;

      lblLegFCPST.Font      := fraDadosFechamentoVendaTotaisFrame.lblVlrFCPST.Font;
      lblLegFCPST.Width     := fraDadosFechamentoVendaTotaisFrame.lblVlrFCPST.Width;
      lblLegFCPST.Height    := fraDadosFechamentoVendaTotaisFrame.lblVlrFCPST.Height;
      lblLegFCPST.Left      := fraDadosFechamentoVendaTotaisFrame.lblVlrFCPST.Left;
      lblLegFCPST.Top       := fraDadosFechamentoVendaTotaisFrame.lblVlrFCPST.Top;

      edtZerFCPST.Alignment := fraDadosFechamentoVendaTotaisFrame.edtBasFCPST.Alignment;
      edtZerFCPST.Font      := fraDadosFechamentoVendaTotaisFrame.edtBasFCPST.Font;
      edtZerFCPST.Width     := fraDadosFechamentoVendaTotaisFrame.edtBasFCPST.Width;
      edtZerFCPST.Height    := fraDadosFechamentoVendaTotaisFrame.edtBasFCPST.Height;
      edtZerFCPST.Left      := fraDadosFechamentoVendaTotaisFrame.edtBasFCPST.Left;
      edtZerFCPST.Top       := fraDadosFechamentoVendaTotaisFrame.edtBasFCPST.Top;
      edtZerFCPST.Enabled   := False;
    End;

    lblZerFCPST.Caption  := 'Valor FCP ST:';
    lblLegFCPST.Caption  := 'Somado à Desp. Acess.';
    edtZerFCPST.Text     := FormatFloat('#,##0.00', fatVenda.fltValFcpSTZeradoFaturaConsignacao);
    lblZerFCPST.Visible  := True;
    lblLegFCPST.Visible  := True;
    edtZerFCPST.Visible  := True;

    fraDadosFechamentoVendaTotaisFrame.lblBaseFCPST.Visible := False;
    fraDadosFechamentoVendaTotaisFrame.edtBasFCPST.Visible  := False;
    fraDadosFechamentoVendaTotaisFrame.edtValFCPST.Visible  := False;
    fraDadosFechamentoVendaTotaisFrame.lblVlrFCPST.Visible  := False;
    fraDadosFechamentoVendaTotaisFrame.lblPerFCP.Visible    := False;
    fraDadosFechamentoVendaTotaisFrame.edtPerFCP.Visible    := False;
    fraDadosFechamentoVendaTotaisFrame.lblAlqFCPST.Visible  := False;
    fraDadosFechamentoVendaTotaisFrame.edtAlqFCPST.Visible  := False;
  End
  Else
  Begin
    If Assigned(edtZerFCPST) Then
    Begin
      lblZerFCPST.Visible := False;
      lblLegFCPST.Visible := False;
      edtZerFCPST.Visible := False;
    End;

    fraDadosFechamentoVendaTotaisFrame.lblBaseFCPST.Visible := True;
    fraDadosFechamentoVendaTotaisFrame.edtBasFCPST.Visible  := True;
    fraDadosFechamentoVendaTotaisFrame.edtValFCPST.Visible  := True;
    fraDadosFechamentoVendaTotaisFrame.lblVlrFCPST.Visible  := True;
    fraDadosFechamentoVendaTotaisFrame.lblPerFCP.Visible    := True;
    fraDadosFechamentoVendaTotaisFrame.edtPerFCP.Visible    := True;
    fraDadosFechamentoVendaTotaisFrame.lblAlqFCPST.Visible  := True;
    fraDadosFechamentoVendaTotaisFrame.edtAlqFCPST.Visible  := True;
  End;
end;

procedure TfrmFatDadosFiscais.pCopiaImpostos(cdsImpostos: TUniClientDataSet);
begin

  If Not Assigned(frmFatDadosFiscaisImpostos) Then
    Exit;

  cdsImpostos.EmptyDataSet;

  cdsImpostos.Append;

  cdsImpostos.FieldByName('BASICM').AsFloat := fStrToFloat(frmFatDadosFiscaisImpostos.edtBasIcm.Text);
  cdsImpostos.FieldByName('VALICM').AsFloat := fStrToFloat(frmFatDadosFiscaisImpostos.edtValIcm.Text);

  cdsImpostos.FieldByName('BASRET').AsFloat := fStrToFloat(frmFatDadosFiscaisImpostos.edtBasRet.Text);
  cdsImpostos.FieldByName('VALRET').AsFloat := fStrToFloat(frmFatDadosFiscaisImpostos.edtValRet.Text);

  cdsImpostos.FieldByName('BASIPI').AsFloat := fStrToFloat(frmFatDadosFiscaisImpostos.edtBasIpi.Text);
  cdsImpostos.FieldByName('VALIPI').AsFloat := fStrToFloat(frmFatDadosFiscaisImpostos.edtValIpi.Text);

  cdsImpostos.FieldByName('BASISS').AsFloat := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasIss.Text);
  cdsImpostos.FieldByName('VALISS').AsFloat := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtValIss.Text);

  cdsImpostos.FieldByName('BASFCP').AsFloat := fStrToFloat(frmFatDadosFiscaisImpostos.edtBasFCP.Text);
  cdsImpostos.FieldByName('VALFCP').AsFloat := fStrToFloat(frmFatDadosFiscaisImpostos.edtValFCP.Text);

  cdsImpostos.FieldByName('BASFCP_ST').AsFloat := fStrToFloat(frmFatDadosFiscaisImpostos.edtBasFCPST.Text);
  cdsImpostos.FieldByName('VALFCP_ST').AsFloat := fStrToFloat(frmFatDadosFiscaisImpostos.edtValFCPST.Text);

  cdsImpostos.FieldByName('CST').AsString := fraDadosFechamentoVendaTotaisFrame.edtCodSit.Text;

  cdsImpostos.Post;

end;

procedure TfrmFatDadosFiscais.pAtualiza_fltRet_Sp;
Begin
  If (SameText(fatVenda.fTrocaUFEndEntrega,'SP') Or fEmptyStr(fatVenda.strCliIes)) And
     (RoundTo(recSalvaImp.fltBasRet,-2) <> RoundTo(fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasRet.Text),-2)) Then
    fatVenda.fltRet_Sp := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasRet.Text);
End;

procedure TfrmFatDadosFiscais.pAvisaSobreGNRE;
var
  LItem: TDadosFechamento;
begin
  for LItem In fatVenda.arrMatItens Do
    if (not fatVenda.fDentroDoEstado(LItem.strEmpIte)) and (Pos(fatVenda.strOpcDoc, 'OU_OF_OV_VN') > 0) then
    begin
      if ((fatVenda.GetTipAbf(LItem) = '_SAI_NCO') and (LItem.strClaFis = '6108')) or
         ((fatVenda.GetTipAbf(LItem) = '_SAI_CCO') and (LItem.strClaFis = '6404')) or
         ((fatVenda.GetTipAbf(LItem) = '_SAI_CNC') and (LItem.strClaFis = '6403')) then
      begin
        fMensagem('','Essa operação pode se fazer necessário a geração de GNRE, favor acessar a rotina e verificar.',['&OK']);
        Break;
      end;
    end;
end;

procedure TfrmFatDadosFiscais.pSugereCFOPDevolucaoOutrasSaidasFornecedor;
  Var
    intContador: Integer;

    function fRetornaPrefixoCFOP: String;
    begin
      Result := IIF(fatVenda.fDentroDoEstado(fatVenda.arrMatItens[intContador].strEmpIte), '5', '6');

      If pos(fatVenda.arrMatItens[intContador].strIdDest, '1_2_3_') > 0 Then
      Begin
        Case fatVenda.arrMatItens[intContador].strIdDest[1] Of
          '1': Result := '5';
          '2': Result := '6';
          '3': Result := '7';
        End;
      End;
    end;

begin
  For intContador := 0 To Length(fatVenda.arrMatItens)-1 Do
  Begin
    If (Pos(fatVenda.arrMatItens[intContador].strCodFis, CST_TRIBUTADO) > 0) Or
       (Pos(fatVenda.arrMatItens[intContador].strCodFis, CST_NAO_TRIBUTADO) > 0) Then
    Begin
      fatVenda.arrMatItens[intContador].strClaFis := fRetornaPrefixoCFOP + '202';
    End;

    If Pos(fatVenda.arrMatItens[intContador].strCodFis, CST_SUBSTITUICAO) > 0 Then
    Begin
      fatVenda.arrMatItens[intContador].strClaFis := fRetornaPrefixoCFOP + '411';
    End;
  End;

  fatVenda.pSintetizaClassificacoes(False);

  fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text := fatVenda.strClaFis;
  fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text := fatVenda.strClaFi2;
  fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text := fatVenda.strClaFi3;
  pCarregaNatOperacao(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text);

  blnMudouClassificacao := True;
end;

function TfrmFatDadosFiscais.fSugestaoCSTNotaComplem: String;
begin
  Result := '';
  Result := '000';

  If blnNFCeComplementar Then
    Exit;

  If (fatVenda.objNfeComplemento.tncTipoNota = tncComplementoICMS) And
     ((fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtPerDif.Text) > 0) Or
      (fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtValDif.Text) > 0)) Then
  Begin
    If (RightStr(fraDadosFechamentoVendaTotaisFrame.edtCodSit.Text, 2) = '51') Then
      Result := fraDadosFechamentoVendaTotaisFrame.edtCodSit.Text
    Else
      Result := '051';

    Exit;
  End;

  If (fatVenda.objNfeComplemento.tncTipoNota In [tncCreditoICMS,
                                                 tncTransferenciaCredorICMS,
                                                 tncTransferenciaDevedorICMS,
                                                 tncRestIcmsStEstoque,
                                                 tncEstornoDeCredito]) Or
     (fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtValIcm.Text) > 0) Or

     (fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtValRet.Text) > 0) Then
  Begin
    Result := '090'
  End;

end;

function TfrmFatDadosFiscais.fTemIcmsDesoneradoSuframa: Boolean;
begin
  Result := False;

  If Assigned(cdsImpostosDigitadosItens) Then
  Begin
    With cdsImpostosDigitadosItens Do
    Begin
      First;

      While Not Eof Do
      Begin
        If Copy(FieldByName('ITE_MTDICM').AsString, 1, 1) = '7' Then
        Begin
          Result := True;
          Break;
        End;

        Next;
      End;
    End;
  End;
end;

function TfrmFatDadosFiscais.fTravaClassificacaoFiscalDeBonificacao(strClaFis: String): Boolean;
begin
  Result := False;

  If (Not fatVenda.strEspDoc.Equals('NF')) Then
    Exit;

  If (Not fatVenda.strOpcDoc.Equals('VN')) Then
    Exit;

  If (Not RightStr(strClaFis, 3).Equals('910')) Then
    Exit;

  If (fVerificaAcessoSistema('PEDJLB')) Then
    Exit;

  If(blnLiberouTravaDeClassificacaoFiscalDeBonificacao) Then
    Exit;

  objLiberacao.Clear;
  objLiberacao.strDirAce    := 'PEDJLB';
  objLiberacao.strMsgSen    := 'Alterar para classificação fiscal de bonificação';
  objLiberacao.strCodOpe    := strLoginUsuarioLogado;
  objLiberacao.objMsgLibera.pAddTexto('Permitir alterar classificação fiscal para bonificação');

  blnLiberouTravaDeClassificacaoFiscalDeBonificacao := objLiberacao.fLibera;

  Result := Not blnLiberouTravaDeClassificacaoFiscalDeBonificacao;
end;

function TfrmFatDadosFiscais.fEhRestituicaoDeIcmsStOuEstoque: Boolean;
begin
  Result := False;

  If not (fatVenda.strOpcDoc = 'NC') Then
    Exit;

  If not (fatVenda.objNfeComplemento.tncTipoNota = tncRestIcmsStEstoque) Then
    Exit;

  Result := True;
end;

function TfrmFatDadosFiscais.fTravaTransportadoraPoisJaFoiDefinido: Boolean;
begin
  Result := (Not fEmptyStr(fatVenda.strCodTra)) And
            ((blnExpedicao) Or (fatVenda.strOpcDoc = 'CP')) And
            (fatVenda.blnResolveuConflitoDeTransportadora) And
            (fCfgSis('TREXCP') = 'S' {Pedir senha});
end;

function TfrmFatDadosFiscais.fValidaAdiantamentoComClassificacaoFiscalDeVenda: Boolean;
begin
  Result := True;

  If (Pos(fatVenda.strOpcDoc, 'VN_') > 0) And (Not fEmptyStr(fatVenda.strEspOrc)) Then
  Begin
    if (TAdiantamento.fGetTotaisAdiantamento(fatVenda.strNumOrc,
                                             fatVenda.strEspOrc,
                                             IIF(fEmptyStr(fatVenda.strEmpOri), VS_strCodEmp, fatVenda.strEmpOri)).fltValLan > 0.00) and
       ((Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, VS_strClaVen) <= 0)) then
    Begin
      fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida. Existe um adiantamento para o pedido\orçamento a ser faturado, portanto '+
      'a Classificação Fiscal a ser utilizada deve estar presente na configuração "CFG_CLAVEN"!', ['&O k']);
      Exit(False);
    End;
  End;
end;

function TfrmFatDadosFiscais.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    intClaFis  : Integer;
    intClaFis2 : Integer;
    intClaFis3 : Integer;
    strClaFisSav : String;
    strClaFi2Sav : String;
    strClaFi3Sav : String;
    strClaFi2Ant : String;
    strClaFi3Ant : String;
    LCfgClaGAE   : String;

    function fPerguntaSeDesejaCarregarFrete(fltValFrePed, fltValFreNov: Double): Boolean;
    begin
      Result := True;

      If blnExpedicao Then
      Begin
        Result := (Not SameText(fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text, strCodTraAnt));
        If Result Then
          Result := (fFormataFloat(fltValFrePed,2) <> fFormataFloat(fltValFreNov,2));
      End;
    end;

    function fFreteHabititadoParaEdicao: Boolean;
    begin
      Result := True;

      If (fatVenda.strOpcDoc = 'CI') Then
        Exit(False);

      If (Pos(fatVenda.strOpcDoc, 'CF_CT_CS_') > 0) Then
        Exit(Not fraDadosFechamentoVendaTransportadoraFrame.edtValFre.ReadOnly);
    end;

    function fPermiteAlterarValorFrete: Boolean;
    begin
      Result := (Not blnExpedicao) Or (blnExpedicao And fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Enabled);
    end;

begin

  Result := True;

  intClaFis  := 0;
  intClaFis2 := 0;
  intClaFis3 := 0;

  LCfgClaGAE := '';

  If Not fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text) Then
    intClaFis  := StrToInt((LeftStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, 1)));

  If Not fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text) Then
    intClaFis2 := StrToInt((LeftStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text, 1)));

  If Not fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text) Then
    intClaFis3 := StrToInt((LeftStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text, 1)));

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = fraDadosFechamentoVendaTransportadoraFrame.edtCodTra) Then
    Begin
      blnRespondeuPerguntaSeDesejaCarregarFrete := False;

      If (fEmptyStr(fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Transportadora deve ser preenchido!', ['&O k']);
        Result := False;
      End
      else
      if not fRetTransportadoraAtiva(fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text) then
      begin
        fMensagem('ATENÇÃO!', 'Transportadora está inativada!', ['&Ok']);
        Result := False;
      end
      Else
      Begin
        pCarregaCadTra;

        If (fCfgSis('PERATF', varBoolean)) And
           (fCfgSis('FRETRA', varString) = FRETRA_POR_FAIXA_FATURAMENTO) And
           (Not fatVenda.fVerificaTransportadoraVinculadaFreteFaixaFaturamento(fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Transportadora não atende a faixa de faturamento!', ['&Ok']);
          Result := False;
        End
        Else If fEmptyStr(fraDadosFechamentoVendaTransportadoraFrame.edtNomTra.Text) Then
        Begin

          If (blnCalcFreteSugestaoTranp) Then
          Begin
            fMensagem('ATENÇÃO!', IIF(blnCalcFreteSugestaoTranp, fRetMsgTransportadoraNaoEncontrada(fatVenda.fRetornaStrCodCidEntAtual),
                                                                 fRetMsgTransportadoraNaoEncontrada), ['&Ok']);
          End
          Else
          If (blnCalcFreteSugestaoRegia) Then
          Begin
            fMensagem('ATENÇÃO!', IIF(blnCalcFreteSugestaoRegia, fRetMsgTransportadoraNaoEncontrada(fatVenda.fRetornaStrCodRegEntAtual, True),
                                                                 fRetMsgTransportadoraNaoEncontrada('', True)), ['&Ok']);
          End;

          Result := False;
        End
        Else
        Begin
          If (fatVenda.strOpcDoc = 'NC') And (not fatVenda.fEhComplementoDeFrete) Then
          Begin
            fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text := FormatFloat('#0.00', 0);
          End
          Else If (fatVenda.fPermitirFreteNoFaturamento) And (fFreteHabititadoParaEdicao) Then
          Begin
            If (Not fatVenda.blnBaiEntFut) And (Not blnZeraFrete) Then
            Begin

              If (blnCalcFreteSugestaoTranp Or blnCalcFreteSugestaoRegia) And blnBuscaPorChave And (Not blnSomenExibirSugestFrete) Then
              Begin
                pCalculaFreteSugestao;
                If (fatVenda.fltTotPro - fatVenda.fltDesEsp >= fatVenda.fltVlMinF) And fPermiteAlterarValorFrete Then
                  fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text := '0,00'
                Else If (fCfgSis('CARFRE', varString) = 'N') Or
                        ((fPerguntaSeDesejaCarregarFrete(fatVenda.fltValFreAnt, fatVenda.fRetFreSugCal)) And
                        (fMensagem('', 'Deseja carregar o valor do frete da transportadora selecionada?', ['','']) = 1)) Then
                Begin
                  If fSeExpedicaoPermiteAlterarValorFrete(fatVenda.strCodTraAnt, fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text,
                                                          fatVenda.fltValFreAnt, fatVenda.fRetFreSugCal) Then
                  Begin
                    blnRespondeuPerguntaSeDesejaCarregarFrete := True;
                    fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text := FloatToStrF(fatVenda.fRetFreSugCal, ffNumber, 12, 2);
                    Result := fValidaCampos(fraDadosFechamentoVendaTransportadoraFrame.edtValFre, True);
                    blnRespondeuPerguntaSeDesejaCarregarFrete := False;
                  End;
                End;
              End
              Else
              Begin
                If (Not blnCalcFreteSugestaoItens) And
                   (Not blnCalcFreteSugestaoTranp) And
                   (Not blnCalcFreteSugestaoRegia) And
                   (Not blnCalcFreteSugestaoFaixa) And blnBuscaPorChave And
                   (((fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text) = 0) And fEmptyStr(fatVenda.strNumOrc)) Or
                   (Not SameText(fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text, strCodTraAnt))) Then
                Begin
                  If (fCfgSis('CARFRE', varString) = 'N') Or
                     ((qryConTra.FieldByName('TRA_VALFRE').AsFloat > 0) And
                     (fPerguntaSeDesejaCarregarFrete(fatVenda.fltValFreAnt, qryConTra.FieldByName('TRA_VALFRE').AsFloat)) And
                     (fMensagem('', 'Deseja carregar o valor do frete da transportadora selecionada?', ['','']) = 1)) Then
                  Begin
                    If fSeExpedicaoPermiteAlterarValorFrete(fatVenda.strCodTraAnt, fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text,
                                                            fatVenda.fltValFreAnt, qryConTra.FieldByName('TRA_VALFRE').AsFloat) Then
                    Begin
                      blnRespondeuPerguntaSeDesejaCarregarFrete := True;
                      fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text := FormatFloat('#0.00', qryConTra.FieldByName('TRA_VALFRE').AsFloat);
                      Result := fValidaCampos(fraDadosFechamentoVendaTransportadoraFrame.edtValFre, True);
                      blnRespondeuPerguntaSeDesejaCarregarFrete := False;
                    End;
                  End;
                End
                Else
                If ((blnCalcFreteSugestaoItens Or (blnCalcFreteSugestaoFaixa)) And
                   (Not SameText(fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text, strCodTraAnt))) Then
                Begin
                  pCalculaFreteSugestao;

                  If (fatVenda.fltTotPro - fatVenda.fltDesEsp >= fatVenda.fltVlMinF) Then
                    fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text := '0,00'
                  Else
                    fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text := FloatToStrF(fatVenda.fltFreSug, ffNumber, 12, 2);

                  Result := fValidaCampos(fraDadosFechamentoVendaTransportadoraFrame.edtValFre, True);
                End;
              End;
            End;
          End;
        End;
      End;

      If Result Then
      Begin
        strCodTraAnt := fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text;
        If blnBuscaPorChave Then
          fltValFreAntTrava := fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text);
      End;
    End

    Else If (Sender = fraDadosFechamentoVendaTransportadoraFrame.mskPlaFat) Then
    Begin
      If (Not fEmptyStr(fraDadosFechamentoVendaTransportadoraFrame.mskPlaFat.Text)) Then
      Begin
        If Not fValidaPlaca(fraDadosFechamentoVendaTransportadoraFrame.mskPlaFat.Text) Then
        Begin
          If fCampoTabela('TRA_VEIEST', 'CADTRA', ['TRA_CODTRA'],
          [fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text]) = 'N' Then
          Begin
            fMensagem('ATENÇÃO!', 'A placa informada não é válida!', ['&OK']);
            Result := False;
          End;
        End;
      End
      Else
      Begin
        If (Not fEmptyStr(fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text)) and (fCfgSis('PLAOBR', varBoolean)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A placa da transportadora deve ser preenchida!', ['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = fraDadosFechamentoVendaTransportadoraFrame.edtDesAce) And (fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Enabled) Then
    Begin

      If (Not fEmptyStr(fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text)) Then
      Begin

        If (fStrtoFloat(fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text) < 0.0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Valor da despesa acessória deve ser maior ou igual a Zero!', ['&O k']);
          Result := False;
        End;

        If Result Then
        Begin
          If (fltDevolucaoEspelhoAD_DesAce > 0) And
             (fFormataFloat(fStrtoFloat(fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text),2) <> 0) And
             (fFormataFloat(fStrtoFloat(fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text),2) <> fFormataFloat(fltDevolucaoEspelhoAD_DesAce,2)) Then
          Begin
            fMensagem('ATENÇÃO!', 'O Valor da despesa acessória deve ser Zero ou '+ FormatFloat('#,##0.00', fltDevolucaoEspelhoAD_DesAce) +' !', ['&O k']);
            Result := False;
          End;
        End;

      End;

      If (Result) Then
      Begin
        If fAlterouDespesasAcessoria And Assigned(cdsImpostosDigitadosItens) Then
        Begin
          If Not fPergunta('O valor da despesa acessória foi alterado, portando a digitação ' +
                           'dos impostos será descartada. Confirma a alteração da despesa acessória?') Then
            fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text := strDesAceAnt;
        End;

        If fAlterouDespesasAcessoria Then
        Begin

          fatVenda.DigImp.pLimpar;
          If (fatVenda.strOpcDoc = 'GF') And (Not(fatVenda.blnAlterouPrecoGF)) Then
            fatVenda.blnAlterouPrecoGF := True;
          pCalculaTotalGeral;

          If Assigned(cdsImpostosDigitadosItens) Then
            FreeAndNil(cdsImpostosDigitadosItens);

          strDesAceAnt := fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text;

          pValidaClassificacaoFiscalQuandoDesabilitada;
        End;
      End;

    End

    Else If (Sender = fraDadosFechamentoVendaBombeamentoFrame.edtQtdBom) And (pnlBombeamento.Visible) Then
    Begin
      If fraDadosFechamentoVendaBombeamentoFrame.chkTaxMin.Checked Then
      Begin
        If (fStrToFloat(fraDadosFechamentoVendaBombeamentoFrame.edtTotBom.Text) > 0.0) And (fStrToFloat(fraDadosFechamentoVendaBombeamentoFrame.edtQtdBom.Text) <= 0.0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A quantidade de bombeamento de concreto deve ser maior que Zero!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        If (Not fEmptyStr(fraDadosFechamentoVendaBombeamentoFrame.edtQtdBom.Text)) Then
        Begin
          If (fStrtoFloat(fraDadosFechamentoVendaBombeamentoFrame.edtQtdBom.Text) < 0.0) Then
          Begin
            fMensagem('ATENÇÃO!', 'A quantidade de bombeamento de concreto deve ser maior ou igual a Zero!', ['&O k']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = fraDadosFechamentoVendaBombeamentoFrame.edtPrcBom) And (pnlBombeamento.Visible) Then
    Begin

      If (Not fEmptyStr(fraDadosFechamentoVendaBombeamentoFrame.edtPrcBom.Text)) Then
      Begin

        If (fStrtoFloat(fraDadosFechamentoVendaBombeamentoFrame.edtPrcBom.Text) < 0.0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço do bombeamento de concreto deve ser maior ou igual a Zero!', ['&O k']);
          Result := False;
        End;

        If (fStrtoFloat(fraDadosFechamentoVendaBombeamentoFrame.edtQtdBom.Text) > 0.0) And (fStrtoFloat(fraDadosFechamentoVendaBombeamentoFrame.edtPrcBom.Text) <= 0.0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço do bombeamento de concreto deve ser informado!', ['&O k']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = fraDadosFechamentoVendaBombeamentoFrame.edtTotBom) And (pnlBombeamento.Visible) And (fraDadosFechamentoVendaBombeamentoFrame.chkTaxMin.Checked) Then
    Begin
      If (Not fEmptyStr(fraDadosFechamentoVendaBombeamentoFrame.edtTotBom.Text)) Then
      Begin
        If (fStrtoFloat(fraDadosFechamentoVendaBombeamentoFrame.edtTotBom.Text) < 0.0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O valor da taxa mínima do bombeamento de concreto deve ser maior ou igual a Zero!', ['&O k']);
          Result := False;
        End;

        If (fStrtoFloat(fraDadosFechamentoVendaBombeamentoFrame.edtQtdBom.Text) > 0.0) And (fStrtoFloat(fraDadosFechamentoVendaBombeamentoFrame.edtTotBom.Text) <= 0.0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O valor da taxa mínima do bombeamento de concreto deve ser informado!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = fraDadosFechamentoVendaTransportadoraFrame.edtValFre) And (fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Enabled Or blnRespondeuPerguntaSeDesejaCarregarFrete) Then
    Begin

      If (Not fEmptyStr(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text)) Then
      Begin

        If fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text) < 0.0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Valor do frete deve ser maior ou igual a Zero!', ['&O k']);
          Result := False;
        End
        {*********************************************************}
        {* SE CASO A VENDA FOR MAIOR QUE O VALOR DE CONFIGURAÇÃO *}
        {* DE INSEÇÃO DO FRETE, NÃO DEIXA COBRAR O FRETE.        *}
        {*******************************************************FC}
        Else If (fFormataFloat(fltValFreAnt, 2) <> fFormataFloat(fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text,0), 2)) And
                (fFormataFloat(fatVenda.fltTotPro - fatVenda.fltDesEsp, 2) >= fFormataFloat(fatVenda.fltVlMinF, 2)) And
                (fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text) > 0.0) Then
        Begin
          If fMensagem('ATENÇÃO!', 'O Valor da venda é maior / igual ao valor mínimo para isenção da cobrança do frete. O que deseja fazer?'
                                 , ['&Continuar e zerar o frete', '&Manter o frete digitado'], 1, False, 1, 210) = 1 Then
            fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text := '0,00';
        End;

      End

      Else
        fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text := '0,00';

      If fAlterouValorFrete Then
      Begin
        if (Pos(fatVenda.strOpcDoc, 'OF_GF_') > 0) and (blnConfirmacaoEspelho) Then
        Begin
          objLiberacao.Clear;
          objLiberacao.strDirAce    := 'ALTFREOFGF';
          objLiberacao.strMsgSen    := 'Alterar Frete Outra Saída Fornecedor\Garantia Fornecedor';
          objLiberacao.strCodOpe    := strLoginUsuarioLogado;
          objLiberacao.objMsgLibera.pAddTexto('Permitir alterar o frete na rotina de outras saídas para fornecedor\Garantia para fornecedor.');

          Result := objLiberacao.fLibera;
        End;
      End;

      If Result Then
      Begin
        If fAlterouValorFrete And Assigned(cdsImpostosDigitadosItens) Then
        Begin
          If Not fPergunta('O valor do frete foi alterado, portando a digitação ' +
                           'dos impostos será descartada. Confirma a alteração do valor do Frete?') Then
            fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text := strValFreAnt;
        End;

        If fAlterouValorFrete Then
        Begin
          fatVenda.DigImp.pLimpar;
          If (fatVenda.strOpcDoc = 'GF') And (Not(fatVenda.blnAlterouPrecoGF)) And (strValFreOri <> fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text)  Then
            fatVenda.blnAlterouPrecoGF := True;

          pCalculaTotalGeral;

          If Assigned(cdsImpostosDigitadosItens) Then
            FreeAndNil(cdsImpostosDigitadosItens);

          strValFreAnt := fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text;

          pValidaClassificacaoFiscalQuandoDesabilitada;
          strValFreOri := fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text;
        End;
      End;

      If Result Then
      Begin
        If (fltDevolucaoEspelhoAD_ValFre > 0) And
           (fFormataFloat(fStrtoFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text),2) <> 0) And
           (fFormataFloat(fStrtoFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text),2) <> fFormataFloat(fltDevolucaoEspelhoAD_ValFre,2)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Valor do frete deve ser Zero ou '+ FormatFloat('#,##0.00', fltDevolucaoEspelhoAD_ValFre) +' !', ['&O k']);
          Result := False;
        End;
      End;

      fltValFreAnt := fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text,0);

    End

    Else If (Sender = fraDadosFechamentoVendaTransportadoraFrame.edtValFreCot) And (fraDadosFechamentoVendaTransportadoraFrame.edtValFreCot.Visible) Then
    Begin
      If (Not fEmptyStr(fraDadosFechamentoVendaTransportadoraFrame.edtValFreCot.Text)) Then
      Begin
        If fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFreCot.Text) < 0.0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Valor do frete cotado deve ser maior ou igual a Zero!', ['&O k']);
          Result := False;
        End
      End;

      If Result Then
      Begin
        If fAlterouValorFreteCotado Then
        Begin
          pCalculaTotalGeral;

          If Assigned(cdsImpostosDigitadosItens) Then
            FreeAndNil(cdsImpostosDigitadosItens);

          strValFreCotAnt := fraDadosFechamentoVendaTransportadoraFrame.edtValFreCot.Text;

          pValidaClassificacaoFiscalQuandoDesabilitada;
        End;
      End;
    End

    Else If (Sender = fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre) Then
    Begin
      If (fCfgSis('TRPPRM', varBoolean)) And (Not fFreteValido(fTipoFrete(fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Text))) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Informe um Tipo de Frete válido!', ['&O k']);
      End
      Else If (Not fFreteValido(fTipoFrete(fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Text))) Or
           (Not fFreteValidoDevolucao) Or
           (Not fPermiteFreteProprio(fTipoFrete(fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Text))) Then
      Begin
        Result := False;
      End
      Else
      Begin
        If (fTipoFrete(fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Text) = '9') And (fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text) > 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe um Tipo de Frete válido:' +#13+
                                'Emitente(CIF), Destinatário(FOB) ou Terceiros', ['&O k']);
          Result := False;
        End
        Else If fatVenda.blnVendaPresencial And fCfgSis('FREPRE', varBoolean) Then
        Begin
          If (Not fCfgSis('FTVDPS', varBoolean)) And
             (fTipoFrete(fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Text) <> '9') And
             (fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text) = 0) And
             (Not fOutrasSaidasFornecedorComVendaPresencial) Then
          Begin
            fMensagem('ATENÇÃO!', 'Quando não foi informado valor de frete na venda presencial, só é permitido informar o tipo de Frete: "Sem Frete"!', ['&O k']);
            Result := False;
          End;
        End;
      End;

      If Result And
        blnCalcFreteSugestaoFaixa And
        (fTipoFrete(fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Text) <> strTipFreAnt) Then
      Begin
        pCalculaFreteSugestao;

        If (fatVenda.fltTotPro - fatVenda.fltDesEsp >= fatVenda.fltVlMinF) Then
          fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text := '0,00'
        Else
          fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text := FloatToStrF(fatVenda.fltFreSug, ffNumber, 12, 2);

        Result := fValidaCampos(fraDadosFechamentoVendaTransportadoraFrame.edtValFre, True);
      End;

      If Not fTipoFretePermitidoTransportadora(fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text, fTipoFrete(fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Text)) Then
      Begin
        If Not fatVenda.fLiberaTipoFreteNaoPermitidoTransportadora(fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text,  fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O tipo de frete: "' + fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Text + '" ' + sLineBreak +
                                'não se encontra na lista de tipos de fretes permitidos para a transportadora.' + sLineBreak +
                                'Verifique o cadatro da transportadora.', ['&OK']);
          Result := False;
        End;
      End;

      If Result Then
        strTipFreAnt := fTipoFrete(fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Text);
    End

    Else If (Sender = fraDadosFechamentoVendaTransportadoraFrame.edtQtdTra) Then
    Begin

      If (Not fEmptyStr(fraDadosFechamentoVendaTransportadoraFrame.edtQtdTra.Text)) Then
      Begin
        If fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtQtdTra.Text) < 0.0 Then
        Begin
          fMensagem('ATENÇÃO!', 'A Quantidade deve ser maior ou igual a Zero!', ['&O k']);
          Result := False;
        End;

        If fraDadosFechamentoVendaTransportadoraFrame.pnlVolumeSepExc.Visible Then
        Begin
          fraDadosFechamentoVendaTransportadoraFrame.edtQtdTraSepNExc.Text :=
            FloatToStrF(fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtQtdTra.Text) -
                        fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtQtdTraSepExc.Text), ffFixed, 12, 0);

          If fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtQtdTraSepNExc.Text) < 0.0 Then
          Begin
            pMensagemOk('O campo "Volume dos itens de Separação não Exclusiva" não pode ficar negativo. '+
              'Ajuste o Volume para poder continuar (ele deve ser maior ou igual ao volume dos itens '+
              'de separação exclusiva) ou revise as configurações de cálculo de volume, pois o volume '+
              'dos itens de separação exclusiva devem seguir as configurações de cálculo de volume do Sistema.');
            Result := False;
          End;

          If fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtQtdTra.Text) <>
            (fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtQtdTraSepExc.Text) +
             fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtQtdTraSepNExc.Text)) Then
          Begin
            pMensagemOk('O Volume deve ser igual à soma dos campos "Volume dos itens de Separação Exclusiva" e '+
              '"Volume dos itens de Separação Não Exclusiva". Realize o ajuste do campo do volume para poder continuar.');
            Result := False;
          End;
        End;
      End;

    End

    Else If (Sender = fraDadosFechamentoVendaTransportadoraFrame.edtEspTra) Then
    Begin
    End

    Else If (Sender = fraDadosFechamentoVendaTransportadoraFrame.edtMarTra) Then
    Begin
    End

    Else If (Sender = fraDadosFechamentoVendaTransportadoraFrame.edtPesBru) Then
    Begin

      If (Not fEmptyStr(fraDadosFechamentoVendaTransportadoraFrame.edtPesBru.Text)) Then
      Begin

        If fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtPesBru.Text) < 0.0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Peso Bruto deve ser maior ou igual a Zero!', ['&O k']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = fraDadosFechamentoVendaTransportadoraFrame.edtPesLiq) Then
    Begin

      If (Not fEmptyStr(fraDadosFechamentoVendaTransportadoraFrame.edtPesLiq.Text)) Then
      Begin

        If fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtPesLiq.Text) < 0.0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Peso Líquido deve ser maior ou igual a Zero!', ['&O k']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = fraDadosFechamentoVendaTransportadoraFrame.edtTraRedCod) And (fraDadosFechamentoVendaTransportadoraFrame.pnlTraRedesp.Visible) Then
    Begin
      If (fEmptyStr(fraDadosFechamentoVendaTransportadoraFrame.edtTraRedCod.Text)) Then
        fraDadosFechamentoVendaTransportadoraFrame.edtTraRedNom.Clear
      Else
      Begin
        fraDadosFechamentoVendaTransportadoraFrame.edtTraRedNom.Text := fRetNomTransportadora(fraDadosFechamentoVendaTransportadoraFrame.edtTraRedCod.Text);

        If fEmptyStr(fraDadosFechamentoVendaTransportadoraFrame.edtTraRedNom.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Transportadora não está cadastrada!', ['&OK']);
          Result := False;
        End;
      End;

      fatVenda.strTraRdp := fraDadosFechamentoVendaTransportadoraFrame.edtTraRedCod.Text;
    End

    {***************************}
    {* VALIDA O CÓDIGO DA OBRA *}
    {************************PZ*}
    Else If (Sender = fraDadosFechamentoVendaObraFrame.edtCodObr) And (pnlDadSer.Visible) Then
    Begin                                                           
      If fEmptyStr(fraDadosFechamentoVendaObraFrame.edtCodObr.Text) And fatVenda.fEhVendaItemConcreto And fCfgSis('OBGOBR', VarBoolean) Then
      Begin
        fMensagem('ATENÇÃO!','O Código da Obra é obrigatório para venda de item concreto!', ['&O k']);
        Result := False;
      End
      Else If (fEmptyStr(fraDadosFechamentoVendaObraFrame.edtCodObr.Text) And (Not fEmptyStr(fraDadosFechamentoVendaObraFrame.edtCodART.Text))) Then
      Begin
        fMensagem('ATENÇÃO!','O Código da Obra é obrigatório quando o Código ART estiver preenchido!', ['&O k']);
        Result := False;
      End;
    End

    {************************}
    {* VALIDA O CÓDIGO ART. *}
    {*********************PZ*}
    Else If (Sender = fraDadosFechamentoVendaObraFrame.edtCodART) And (pnlDadSer.Visible) Then
    Begin
      If (fEmptyStr(fraDadosFechamentoVendaObraFrame.edtCodART.Text) And (Not fEmptyStr(fraDadosFechamentoVendaObraFrame.edtCodObr.Text))) Then
      Begin
        fMensagem('ATENÇÃO!','O Código ART é obrigatório quando o Código da Obra estiver preenchido!', ['&O k']);
        Result := False;
      End

      Else If (fEmptyStr(fraDadosFechamentoVendaObraFrame.edtCodObr.Text) And (Not fEmptyStr(fraDadosFechamentoVendaObraFrame.edtCodART.Text))) Then
      Begin
        fMensagem('ATENÇÃO!','O Código da Obra é obrigatório quando o Código ART estiver preenchido!', ['&O k']);
        pSetFocus(fraDadosFechamentoVendaObraFrame.edtCodObr);
        blnMudarFoco := False;
      End;
    End    

    Else If (Sender = fraDadosFechamentoVendaClaFisFrame.edtClaFis) Then
    Begin

      If fAlterouClassificacaoFiscal Then
        pCarregaNatOperacao(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text);

      If fAlterouClassificacaoFiscal And Assigned(cdsImpostosDigitadosItens) Then
      Begin
        If blnEspelhoEnvioParaOFornecedor Or
           Not fPergunta('A classificação fiscal foi alterada, portando a digitação ' +
                         'dos impostos será descartada. Confirma a alteração da classificação fiscal?') Then
          fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text := strClaFisAnt;
      End;

      If (fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Classificação Fiscal deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        if (fatVenda.strCliEst = 'EX') then
        begin
          pnlDrawBack.Visible := True;
        end
        else
        begin
          pnlDrawBack.Visible := False;
        end;

        If (fTravaClassificacaoFiscalDeBonificacao(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Classificação fiscal de bonificação não permitida!', ['&Ok']);
          Result := False;
          Exit;
        End;

        pCarregaCadCfo((Sender As TEdit), blnBuscaPorChave);
        If qryConCfo.FieldByName('CFO_CODCFO').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Classificação Fiscal não está cadastrada!', ['&O k']);
          Result := False;
        End
        Else If Not fValidouPreenchimentoCFOPAtivoImobilizado(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text) Then
        Begin
          Result := False;
        End
        Else If (Pos(fatVenda.strOpcDoc,'NP') > 0) Then
        Begin
          Exit;
        End

        {***********************************}
        { OUTRAS SAIDAS - CLIENTE           }
        {********************************JB*}
        Else If (Pos(fatVenda.strOpcDoc, 'OU_OV_') > 0) Then
        Begin
          If (Not fatVenda.fEhRecGarantia) And (Not fatVenda.fEhConsertoEquipamento) Then
          Begin
            VS_strClaNfo := fTransform(fCfgSis('CLANFO'), 4);
            If blnBaixaRefugo Then
              VS_strClaNfo := VS_strClaNfo + '5'+ fCfgSis('CLAREF', varString) + '_6' + fCfgSis('CLAREF', varString)+ '_';
            If (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, VS_strClaNfo) <= 0) Or (StrToInt((LeftStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, 1))) < 5) Then
            Begin
              fMensagem('ATENÇÃO!', 'Só é permitida uma classificação de Outras Saídas!', ['&O k']);
              Result := False;
            End;

            If Result                                                                 And
               (fatVenda.strOpcDoc = 'OU')                                            And
               (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, '5109_5110_6109_6110_5411_5202_6411_6202_') <= 0) And
               fTemIcmsDesoneradoSuframa                                              Then
            Begin
              fMensagem('ATENÇÃO!', 'Só é permitido os CFOP´s 5109, 5110, 5202, 5411, 6109, 6110, 6202 e 6411 quando possuir produtos de ICMS Desonerado com motivo 7-SUFRAMA!', ['&O k']);
              Result := False;
            End;
          End
          Else
          Begin
            If fatVenda.fEhConsertoEquipamento Then
            Begin
              If (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, fTransform(fCfgSis('CLASAI'), 4)) <= 0) Or (StrToInt((LeftStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, 1))) < 5) Then
              Begin
                fMensagem('ATENÇÃO!', 'Só é permitida uma classificação de Conserto de Equipamento!', ['&O k']);
                Result := False;
              End;
            End;
          End;
        End

        Else If (Pos(fatVenda.strOpcDoc, 'CT') > 0) Then
        Begin
          If fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_REGES2').AsString = 'S' Then
          Begin
            If (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, VS_strClaDev) = 0) Then
            Begin
              fMensagem('ATENÇÃO!', 'Só é permitida uma classificação de Devolução para Confirmação de Transferência gerada pela rotina de Regime Especial!', ['&O k']);
              Result := False;
            End;
          End;
        End

        {***********************************}
        { OUTRAS SAIDAS - FORNECEDOR        }
        {********************************JB*}
        Else If (Pos(fatVenda.strOpcDoc,'OF') > 0) And (not FUsaTrocaDeCfopNaDigitacaoDeImpostos) Then
        Begin
          If (Not fEhClassificacaoDeOutrasSaidas(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Só é permitida uma classificação de Outras Saídas!', ['&O k']);
            Result := False;
          End;

          If Result                                                                 And
             (fatVenda.strOpcDoc = 'OF')                                            And
             (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, '5109_5110_6109_6110_5411_5202_6411_6202_') <= 0) And
             fTemIcmsDesoneradoSuframa                                              Then
          Begin
            fMensagem('ATENÇÃO!', 'Só é permitido os CFOP´s 5109, 5110, 5202, 5411, 6109, 6110, 6202 e 6411 quando possuir produtos de ICMS Desonerado com motivo 7-SUFRAMA!', ['&O k']);
            Result := False;
          End;
        End

        {***********************************}
        { OUTRAS ENTRADAS                   }
        {********************************JB*}
        Else If (Pos(fatVenda.strOpcDoc, 'OE_EF_') > 0) Then
        Begin
          If Not fatVenda.fEhRecGarantia Then
          Begin
            If (StrToInt((LeftStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, 1))) >= 5) Or (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, VS_strClaNOE) = 0) Then
            Begin
              fMensagem('ATENÇÃO!', 'Só é permitida uma classificação de Outras Entradas!', ['&O k']);
              Result := False;
            End
            Else If LeftStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, 1) = '3' Then
            Begin
              {*********************************************************************}
              { TRAVA LIBERADA PARA O CFOP 3.202 DIA 16/11/2012 A PEDIDO DO RONALDO }
              {******************************************************************RN*}
              If (fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text <> '3202') Then
              Begin
                fMensagem('ATENÇÃO!', 'Não é permitido emitir Nota Fiscal de Importação pela ' +
                                      'rotina de Outras Entradas, pois para a emissão deste tipo ' +
                                      'de documento é necessário informar os dados do Imposto de Importação e ' +
                                      'do DI dos produtos. ' + #13#10 +
                                      'Utilizar a rotina de Nota de Importação que se ' +
                                      'encontra no módulo de Entrada de Mercadorias!', ['&OK']);
                Result := False;
              End;
            End;
          End;
        End

        Else If (fatVenda.strOpcDoc = 'MF') Then
        Begin
          If (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, '5949_6949_5923_6923_') <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Só são permitidas as classificações 5949, 6949, 5923 ou 6923 para Mercadoria Faltante!', ['&O k']);
            Result := False;
          End;
        End

        {***********************************}
        { BRINDE.                           }
        {********************************JB*}
        Else If (fatVenda.strOpcDoc = 'BR') Then
        Begin
          If Pos(RightStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, 03), '910_' + fCfgSis('CLABRI')) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Só são permitidas as classificações 5910, 6910 ou a classificação configurada para Brindes!', ['&O k']);
            Result := False;
          End;
        End

        {***********************************}
        { GARANTIA - RETORNO DE FORNECEDOR  }
        {********************************MM*}
        Else If (fatVenda.strOpcDoc = 'GR') Then
        Begin
          If (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, VS_strClaRGR) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Só são permitidas as classificações configuradas para' + #13 +
                                  'Garantia - Retorno de Fornecedor!', ['&O k']);
            Result := False;
          End;
        End

        {***********************************}
        { GARANTIA - ENVIO P/ FORNECEDOR    }
        {********************************MM*}
        Else If (fatVenda.strOpcDoc = 'GF') Then
        Begin
          Case fatVenda.enuTipoEnvioFornecedorGarantia of
            tefDevolucao:
              begin
               LCfgClaGAE := fCfgSis('CLAGAE');
               If (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, LCfgClaGAE) <= 0) Then
                Begin
                  fMensagem('ATENÇÃO!', 'Só são permitidas as classificações configuradas para' + #13 +
                                        'Garantia - Envio p/ Fornecedor [CFG_CLAGAE]!', ['&O k']);
                  Result := False;
                End;
              end;
            else
              begin
                If (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, VS_strClaRGF) <= 0) Then
                Begin
                  fMensagem('ATENÇÃO!', 'Só são permitidas as classificações configuradas para' + #13 +
                                        'Garantia - Envio p/ Fornecedor!', ['&O k']);
                  Result := False;
                End;
              end;
          End;
        end

        {****************************************}
        {* NOTA DE COMPLEMENTO DE TRANSFERÊNCIA *}
        {*************************************FC*}
        Else If (fatVenda.strOpcDoc = 'NC') Then
        Begin
          If (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, CFOP_COMBUSTIVEL) > 0) And (not fatVenda.objNfeComplemento.blnTemItens) Then
          Begin
            fMensagem('ATENÇÃO!', 'Para emitir nota fiscal de complemento de combustível é preciso fazer o complemento por produto.'+#13+
                                  'Volte na tela anterior e clique na opção "Caso deseje complementar por produto, clique aqui"'+#13+
                                  'Insira os dados por produto e depois prossiga novamente.', ['&O k'],
                                  1, False, 1, 0, False, 0, False, False, False, 0, 600);
            Result := False;
          End
          Else If (fatVenda.objNfeComplemento.tncTipoNota = tncTransferenciaCredorICMS) And
             (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, '1601_1602_5601_5602_') <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Só são permitidas as classificações 1601, 1602, 5601 e 5602!', ['&O k']);
            Result := False;
          End
          Else If (fatVenda.objNfeComplemento.tncTipoNota = tncTransferenciaDevedorICMS) And
                  (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, '5605_') <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Só é permitida a classificação 5605!', ['&O k']);
            Result := False;
          End
          Else If (fatVenda.objNfeComplemento.tncTipoNota = tncRestIcmsStEstoque) Then
          Begin
            if fEmptyStr(VS_strClaNco) then
            begin
              fMensagem('ATENÇÃO!', 'Não foram configuradas classificações fiscais para Nota de Complemento - Restituição de ICMS ST/Estoque [CFG_CLANCO]!', ['&O k']);
              Result := False;
            end
            Else If (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, VS_strClaNco) <= 0) then
            begin
              fMensagem('ATENÇÃO!', 'Só são permitidas as classificações atribuídas à configuração de classificação fiscal para Nota de Complemento - Restituição de ICMS ST/Estoque [CFG_CLANCO]!', ['&O k']);
              Result := False;
            end;
          End
          Else If (fatVenda.objNfeComplemento.tncTipoNota = tncEstornoDeCredito) And
                  (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, fTransform(fCfgSis('CLAEST'), 4)) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Só é permitida a(s) classificações ' + fTransform(fCfgSis('CLAEST'), 4) + '!', ['&O k']);
            Result := False;
          End
          Else If (fatVenda.objNfeComplemento.tncTipoNota = tncNFAjusteICMSaMaior) And
                  (StrToInt((LeftStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, 1))) >= 5)  Then
          Begin
            fMensagem('ATENÇÃO!', 'Só é permitida a(s) classificações de entradas !', ['&O k']);
            Result := False;
          End;
        End

        Else If (fatVenda.strOpcDoc = 'FC') Then
        Begin
          If (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, strFatCon) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Só são permitidas as classificações configuradas para' + #13 +
                                  'Faturamento de Mercadoria em Consignação!', ['&OK']);
            Result := False;
          End;
        End

        {***************************}
        {        DEMONSTRAÇÃO       }
        {***************************}
        Else If (fatVenda.strTipOpe = 'D') Then
        Begin
          If (Pos(RightStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text,3), VS_strClaDem) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Tipo de Operação de "Demonstração".' + #13 + 'Só são permitidas classificações com final : ' +
                      fRetornaMensagemClaDem, ['&Ok']);
            Result := False;
          End;
        End

        Else If (fatVenda.strOpcDoc = 'UC') Then
        Begin
          If (Pos(RightStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text,3), VS_strCla_UC) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Tipo de Operação de "Uso e Consumo".' + #13 + 'Só são permitidas classificações com final : ' +
                      fRetornaMensagemClaUC, ['&Ok']);
            Result := False;
          End;
        End

        {***************************}
        { DEVOLUÇÃO DE DEMONSTRAÇÃO }
        {************************PZ*}
        Else If (fatVenda.strOpcDoc = 'DD') Then
        Begin
          If (Pos(RightStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text,3), VS_strClaDem) <= 0) Or
             (StrToInt(LeftStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text,1)) >= 5) Then
          Begin
            fMensagem('ATENÇÃO!', 'Só são permitidas classificações de entrada com final : ' +
                      fRetornaMensagemClaDem, ['&O k']);
            Result := False;
          End;
        End

        Else If (fatVenda.blnDevNota) And (not FUsaTrocaDeCfopNaDigitacaoDeImpostos) And (not fatVenda.blnEspelhoDevolucaoClienteFatDadosFiscais) Then
        Begin
          If (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, VS_strClaDev + fRetComplementoStrClaDevBrinde(fatVenda.strOpcDoc)) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Só é permitido classificação de Devolução!', ['&O k']);
            fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled := True;
            Result := False;
          End;
        End

        {*****************************************}
        {* DEVOLUÇÃO NÃO PERMITIDA PARA CLICON   *}
        {**************************************AF*}
        Else If fClienteConsumidor(fatVenda.strCliOri, False, True) And (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, VS_strClaDev) > 0) And (Not fCfgSis('DEVCON', VarBoolean)) Then
        Begin
          fMensagem('', 'Classificação de Devolução não permitida para cliente consumidor!', ['&Ok']);
          Result := False;
        End

        Else If (fatVenda.blnEstornoNotaFiscal) Then
        Begin
          If (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, VS_strClaDev) > 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Não é permitido usar classificação de Devolução!', ['&O k']);
            Result := False;
          End;
        End

        Else If (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, '5923_5924_6923_6924_') > 0) And
                (fatVenda.strOpcDoc <> 'CO') And (fatVenda.strTipOpe <> 'R') Then
        Begin
          fMensagem('ATENÇÃO!', 'Notas de remessa por conta e ordem devem ser efetuadas através do menu ' +
                                'Principal->Faturamento->Emissão de Faturamento->Remessa por conta e ordem.', ['&Ok']);
          Result := False;
        End

        Else If (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, '5923_5924_6923_6924_') <= 0) And (fatVenda.strOpcDoc = 'CO') Then
        Begin
          fMensagem('ATENÇÃO!', 'Classificação Fiscal informada não é valida para emissão de Notas de remessa por conta e ordem.' + #13#10 +
                                'Somente é permitido informar 5923, 5924, 6923 e 6924!', ['&Ok']);
          Result := False;
        End;

        pnlRefDocDadosFiscais.Visible := fApresentaTelaParaReferenciarNota;
      End;

      If Result Then
      Begin
        If not ((Pos(fatVenda.strOpcDoc, 'OE_EF_') > 0) And (fatVenda.strCliCgc = fRetCGCEmpresa(VS_strCodEmp))) Then
        Begin
          If ((fatVenda.fTrocaUFEndEntrega = 'EX') And (Pos(LeftStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text,1), '3_7_') <= 0)) And (Not fatVenda.blnVendaPresencial) Then
          Begin
            fMensagem('',IIF(fatVenda.fDocumentoParaFornecedor, 'Fornecedor ', 'Cliente ')  +
                         'do Exterior, portanto são permitidas somente classificações fiscais iniciadas com 3 ou 7!',['&OK']);
            Result := False;
          End
          Else If ((fatVenda.fTrocaUFEndEntrega = fRetornaUFEmpresa) And (Pos(LeftStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text,1),'1_3_5_') <= 0)) Then
          Begin
            fMensagem('',IIF(fatVenda.fDocumentoParaFornecedor, 'Fornecedor ', 'Cliente ')  +
                         'dentro do estado, portanto são permitidas somente classificações fiscais iniciadas com 1, 3 ou 5!',['&OK']);
            Result := False;
          End
          Else If (Not fatVenda.blnVendaPresencial) And ((fatVenda.fTrocaUFEndEntrega <> fRetornaUFEmpresa) And (fatVenda.strCliEst <> 'EX') And (Pos(LeftStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text,1),'2_6_') <= 0)) Then
          Begin
            fMensagem('',IIF(fatVenda.fDocumentoParaFornecedor, 'Fornecedor ', 'Cliente ')  +
                         'fora do estado, portanto são permitidas somente classificações fiscais iniciadas com 2 ou 6!',['&OK']);
            Result := False;
          End;
        End;
      End;

      If Result Then
      Begin
        strClaFisSav := fatVenda.strClaFis;
        fatVenda.strClaFis := fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text;

        If (fatVenda.fExibirCentroDeCustoNoFaturamento) Then
          fraDadosFechamentoVendaPlanContasFrame.mskCodCta.Enabled := True
        Else
        Begin
          fraDadosFechamentoVendaPlanContasFrame.mskCodCta.Enabled := False;
          fraDadosFechamentoVendaPlanContasFrame.mskCodCta.Clear;
          fraDadosFechamentoVendaPlanContasFrame.edtDesCta.Clear;
        End;

        If fAlterouClassificacaoFiscal Then
        Begin

          fatVenda.DigImp.pLimpar;

          If Assigned(cdsImpostosDigitadosItens) Then
            FreeAndNil(cdsImpostosDigitadosItens);

          strClaFisAnt := fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text;

          If (fatVenda.fExibirCentroDeCustoNoFaturamento) Then
          Begin
            If fCarregaCentroCustoDev Then
              strCCuFpg := fCfgSis('CTRCDV')
            Else
              strCCuFpg := fRetCCustoFpg(fatVenda.strCodFpg);

            pSetaCentroCusto(strCCuFpg);
          End
          Else
            fraDadosFechamentoVendaPlanContasFrame.edtDesCta.Clear;

          If fatVenda.strOpcDoc <> 'NC' Then
          Begin

            If fatVenda.fEhClassificacaoFiscalParaRemessaDeIndustrializacao(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text) Then
            Begin
              blnMudouClassificacao := True;
              pAtualizaMatItens(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, strClaFisSav, strCl1Ant);
            End;

            If fatVenda.fEhClassificacaoFiscalParaBaixaDeEstoqueDecorrenteDePerdaRouboOuDeterioracao(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text) Then
            Begin
              blnMudouClassificacao := True;
              pAtualizaMatItens(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, strClaFisSav, strCl1Ant);
            End;

            If fatVenda.blnClienteZonaFrancaComDescontoEspecial Then
            Begin
              blnMudouClassificacao := True;
              pAtualizaMatItens(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, strClaFisSav, strCl1Ant);
            End;

            If (fatVenda.strCliEst = 'EX') And (not FUsaTrocaDeCfopNaDigitacaoDeImpostos) Then
            Begin
              blnMudouClassificacao := True;
              pAtualizaMatItens(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, strClaFisSav, strCl1Ant);
            End;

            If (fPreValidacaoDeProdutoRevendaDentroDoEstado(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text)) Then
            Begin
              blnMudouClassificacao := True;
              pAtualizaMatItens(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, strClaFisSav, strCl1Ant);
            End;

            If (fEhOutrasSaidasDeFornecedorDevolucao(fatVenda.strOpcDoc, fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text)) Then
            Begin
              blnMudouClassificacao := True;
              pAtualizaMatItens(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, strClaFisSav, strCl1Ant);
            End;

            If (fOutrasSaidasAbreviacaoIpi) Then
            Begin
              blnMudouClassificacao := True;
              pAtualizaMatItens(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, strClaFisSav, strCl1Ant);
            End;

            If fVendaProducao(fatVenda.strOpcDoc, fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text) Or (Pos(strClaFisSav, fCfgSis('CFOIND')) > 0) Then
            Begin
              pAtualizaMatItens(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, strClaFisSav, strCl1Ant);
            End;

            If fZeraImpostoFaturaConsignacao(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text) Then
            Begin
              blnMudouClassificacao := True;
              pAtualizaMatItens(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, strClaFisSav, strCl1Ant);
            End;

            If fTransferenciaDeMarcadoriasValidandoEnquadramentoDeIPI(fatVenda.strOpcDoc, fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text) Then
            Begin
              blnMudouClassificacao := True;
              pAtualizaMatItens(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, strClaFisSav, strCl1Ant);
            End;

            If fatVenda.fEhDevolucaoParaFornecedorQueAbasteceEmpresaPorTransferenciaDeEstoque(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text) Then
            Begin
              blnMudouClassificacao := True;
              pAtualizaMatItensOutrasSaidas(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text);
            End;

            If fNotaEspecialCfopOutrasSaidas Then
            Begin
              blnMudouClassificacao := True;
              pAtualizaMatItens(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, strClaFisSav, strCl1Ant);
            End;

            if fNotaEspecialAbreviacaoIpi then
            Begin
              blnMudouClassificacao := True;
              pAtualizaMatItens(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, strClaFisSav, strCl1Ant);
            End;

            if fNotaEspecialDevolucao then
            begin
              blnMudouClassificacao := True;
              pAtualizaMatItens(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, strClaFisSav, strCl1Ant);
            end;

            if fatVenda.fNotaEspecialCST_X90(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text) then
            begin
              blnMudouClassificacao := True;
              pAtualizaMatItens(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, strClaFisSav, strCl1Ant);
            end;

            If (fDeveAtualizarOsTotaisEmTela) Then
              FUsuarioAlterouClassificacaoReforma := True;

            pCalculaTotalGeral;
          End;

          fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text := strClaFisAnt;
          fatVenda.strClaFis := strClaFisAnt;

          If fatVenda.fEhNotaDeComplementoCIAP Then
          Begin
            fraDadosFechamentoVendaTotaisFrame.lblCstPis.Visible := True;
            fraDadosFechamentoVendaTotaisFrame.edtCstPis.Visible := True;
            fraDadosFechamentoVendaTotaisFrame.edtCstPis.Enabled := True;

            fraDadosFechamentoVendaTotaisFrame.lblCstCof.Visible := True;
            fraDadosFechamentoVendaTotaisFrame.edtCstCof.Visible := True;
            fraDadosFechamentoVendaTotaisFrame.edtCstCof.Enabled := True;

            fraDadosFechamentoVendaTotaisFrame.lblCstIpi.Visible := True;
            fraDadosFechamentoVendaTotaisFrame.edtCstIpi.Visible := True;
            fraDadosFechamentoVendaTotaisFrame.edtCstIpi.Enabled := True;
          End
          Else
          Begin
            fraDadosFechamentoVendaTotaisFrame.lblCstPis.Visible := False;
            fraDadosFechamentoVendaTotaisFrame.edtCstPis.Visible := False;
            fraDadosFechamentoVendaTotaisFrame.edtCstPis.Enabled := False;

            fraDadosFechamentoVendaTotaisFrame.lblCstCof.Visible := False;
            fraDadosFechamentoVendaTotaisFrame.edtCstCof.Visible := False;
            fraDadosFechamentoVendaTotaisFrame.edtCstCof.Enabled := False;

            fraDadosFechamentoVendaTotaisFrame.lblCstIpi.Visible := False;
            fraDadosFechamentoVendaTotaisFrame.edtCstIpi.Visible := False;
            fraDadosFechamentoVendaTotaisFrame.edtCstIpi.Enabled := False;
          End;

          fatVenda.pSolicitaComplementoDadosExportacao;
          pEditaBases;
        End;

        pMostraBtnEdtInfDocExp(fatVenda.fEhNotaExportacao);
      End;

      If Result And (fEhOutrasSaidasDeFornecedorDevolucao(fatVenda.strOpcDoc, fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text)) Then
      Begin
        If fEhDevolucaoDeFornecedorComDiferimento And (not fExistePercentualDiferimentoParaDevolucaoDeFornecedor) Then
        Begin
          Result := False;
        End;
      End;

      If Result And (fatVenda.strOpcDoc = 'OF') Then
      Begin
        pAtualizaMotivoDesoneracaoItensDeOutrasSaidasDeFornecedor;
      End;

    End

    Else If (Sender = fraDadosFechamentoVendaClaFisFrame.edtClaFi2) And (fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Enabled) Then
    Begin

      If Not fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text) Then
      Begin

        If (fTravaClassificacaoFiscalDeBonificacao(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Classificação fiscal de bonificação não permitida!', ['&Ok']);
          Result := False;
          Exit;
        End;

        pCarregaCadCfo((Sender As TEdit), False);
        If Not fExisteCFOP(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Classificação Fiscal não está cadastrada!', ['&O k']);
          Result := False;
        End
        Else If (Pos(fatVenda.strOpcDoc, 'OU_OV_') > 0) Then
        Begin
          If (Not fatVenda.fEhRecGarantia) And (Not fatVenda.fEhConsertoEquipamento) Then
          Begin
            If (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text, VS_strClaNfo) <= 0) Then
            Begin
              fMensagem('ATENÇÃO!', 'Só é permitida uma classificação de Outras Saídas!', ['&O k']);
              Result := False;
            End;
          End
          Else
          Begin
            If fatVenda.fEhConsertoEquipamento Then
            Begin
              If (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, fTransform(fCfgSis('CLASAI'), 4)) <= 0) Or (StrToInt((LeftStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, 1))) < 5) Then
              Begin
                fMensagem('ATENÇÃO!', 'Só é permitida uma classificação de Conserto de Equipamento!', ['&O k']);
                Result := False;
              End;
            End;
          End;
        End
        Else If (Pos(fatVenda.strOpcDoc, 'OE_EF_') > 0) Then
        Begin
          If (StrToInt((LeftStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text, 1))) >= 5) Or (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text, VS_strClaNOE) = 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Só é permitida uma classificação de Outras Entradas!', ['&O k']);
            Result := False;
          End;
        End
        Else If Not fValidouPreenchimentoCFOPAtivoImobilizado(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text) Then
        Begin
          Result := False;
        End
        Else If (fCfgSis('USABRI', varString) = 'S') And
                (fCfgSis('VENBRI', varString) = 'S') And
                ((RightStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, 3) = '910') And (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, VS_strClaVen) <= 0)) And
                ((RightStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text, 3) <> '910') And (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text, VS_strClaVen) > 0)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Foi informada uma CFOP de bonificação com uma CFOP de venda e o documento não será desmembrando '+
                                'conforme configurações. Para poder continuar, troque e coloque a CFOP de bonificação na segunda posição da ' +
                                'tela de dados fiscais.', ['&O k']);
          Result := False;
        End;
      End;

      {**************************}
      {*VALIDA AS CLASSIFICAÇÕES*}
      {***********************PZ*}
      If Result Then
      Begin
        strClaFi2Sav := fatVenda.strClaFi2;
        If (fOutrasSaidasAbreviacaoIpi) Then
          fatVenda.strClaFi2 := fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text;

        strClaFi2Ant := fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text;

        If (intClaFis2 > 0) And ((intClaFis >= 5)And(intClaFis2 < 5)) Then
        Begin
          fMensagem('ATENÇÃO','Classificações incorretas. Os códigos devem ser referente a Entrada ou a Saída!',['&O K']);
          Result := False;
        End
        Else If (intClaFis2 > 0) And ((intClaFis < 5)And(intClaFis2 >= 5)) Then
        Begin
          fMensagem('ATENÇÃO','Classificações incorretas. Os códigos devem ser referente a Entrada ou a Saída!',['&O K']);
          Result := False;
        End;

        If (strClaFi2Sav <> fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text) Then
        Begin
          If (fatVenda.strCliEst = 'EX')  Or
             (fOutrasSaidasAbreviacaoIpi) Or
             (fEhClassificacaoDeOutrasSaidasDeFornecedor(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text)) Or
             (fatVenda.fEhClassificacaoFiscalParaBaixaDeEstoqueDecorrenteDePerdaRouboOuDeterioracao(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text)) Or
             (fEhOutrasSaidasDeFornecedorDevolucao(fatVenda.strOpcDoc, fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text)) Then
          Begin
            If (fEhOutrasSaidasDeFornecedorDevolucao(fatVenda.strOpcDoc, fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text)) Then
              strClaFi2Sav := strCl2Ant;

            blnMudouClassificacao := True;
            pAtualizaMatItens(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text, strClaFi2Sav, strCl2Ant);
            pCalculaTotalGeral;
            fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text := strClaFi2Ant;
            fatVenda.strClaFi2 := strClaFi2Ant;
          End;
        End;

        If Result And (fDeveAtualizarOsTotaisEmTela) And (fClassificacoesDaTelaMudaram) Then
        Begin
          FUsuarioAlterouClassificacaoReforma := True;
          pCalculaTotalGeral;
        End;

      End;

    End

    Else If (Sender = fraDadosFechamentoVendaClaFisFrame.edtClaFi3) And (fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Enabled) Then
    Begin

      If Not fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text) Then
      Begin

        If (fTravaClassificacaoFiscalDeBonificacao(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Classificação fiscal de bonificação não permitida!', ['&Ok']);
          Result := False;
          Exit;
        End;

        pCarregaCadCfo((Sender As TEdit), False);
        If Not fExisteCFOP(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Classificação Fiscal não está cadastrada!', ['&O k']);
          Result := False;
        End
        Else If (Pos(fatVenda.strOpcDoc, 'OU_OV_') > 0) Then
        Begin
          If (Not fatVenda.fEhRecGarantia) And (Not fatVenda.fEhConsertoEquipamento) Then
          Begin
            If (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text, VS_strClaNfo) <= 0) Then
            Begin
              fMensagem('ATENÇÃO!', 'Só é permitida uma classificação de Outras Saídas!', ['&O k']);
              Result := False;
            End;
          End
          Else
          Begin
            If fatVenda.fEhConsertoEquipamento Then
            Begin
              If (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, fTransform(fCfgSis('CLASAI'), 4)) <= 0) Or (StrToInt((LeftStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, 1))) < 5) Then
              Begin
                fMensagem('ATENÇÃO!', 'Só é permitida uma classificação de Conserto de Equipamento!', ['&O k']);
                Result := False;
              End;
            End;
          End;
        End
        Else If (Pos(fatVenda.strOpcDoc, 'OE_EF_') > 0) Then
        Begin
          If (StrToInt((LeftStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text, 1))) >= 5) Or (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text, VS_strClaNOE) = 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Só é permitida uma classificação de Outras Entradas!', ['&O k']);
            Result := False;
          End;
        End
        Else If Not fValidouPreenchimentoCFOPAtivoImobilizado(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text) Then
        Begin
          Result := False;
        End
        Else If (fCfgSis('USABRI', varString) = 'S') And
                (fCfgSis('VENBRI', varString) = 'S') And
                ((RightStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, 3) = '910') And (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, VS_strClaVen) <= 0)) And
                ((RightStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text, 3) <> '910') And (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text, VS_strClaVen) > 0)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Foi informada uma CFOP de bonificação com uma CFOP de venda e o documento não será desmembrando '+
                                'conforme configurações. Para poder continuar, troque e coloque a CFOP de bonificação na segunda posição da ' +
                                'tela de dados fiscais.', ['&O k']);
          Result := False;
        End;
      End;

      {**************************}
      {*VALIDA AS CLASSIFICAÇÕES*}
      {***********************PZ*}
      If Result Then
      Begin
        strClaFi3Sav := fatVenda.strClaFi3;
        If (fOutrasSaidasAbreviacaoIpi) Then
          fatVenda.strClaFi3 := fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text;

        strClaFi3Ant := fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text;

        If ( ((intClaFis >= 5)And(intClaFis2 < 5) And (intClaFis2 > 0))  Or
             ((intClaFis >= 5)And(intClaFis3 < 5) And (intClaFis3 > 0)) ) Then
        Begin
          fMensagem('ATENÇÃO','Classificações incorretas. Os códigos devem ser referente a Entrada ou a Saída!',['&O K']);
          Result := False;
        End
        Else If (((intClaFis < 5)And(intClaFis2 >= 5) And (intClaFis2 > 0))  Or
                 ((intClaFis < 5)And(intClaFis3 >= 5) And (intClaFis3 > 0))) Then
        Begin
          fMensagem('ATENÇÃO','Classificações incorretas. Os códigos devem ser referente a Entrada ou a Saída!',['&O K']);
          Result := False;
        End;

        If (strClaFi3Sav <> fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text) Then
        Begin
          If (fatVenda.strCliEst = 'EX')  Or
             (fOutrasSaidasAbreviacaoIpi) Or
             (fEhClassificacaoDeOutrasSaidasDeFornecedor(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text)) Or
             (fatVenda.fEhClassificacaoFiscalParaBaixaDeEstoqueDecorrenteDePerdaRouboOuDeterioracao(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text)) Or
             (fEhOutrasSaidasDeFornecedorDevolucao(fatVenda.strOpcDoc, fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text)) Then
          Begin
            If (fEhOutrasSaidasDeFornecedorDevolucao(fatVenda.strOpcDoc, fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text)) Then
              strClaFi3Sav := strCl3Ant;

            blnMudouClassificacao := True;
            pAtualizaMatItens(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text, strClaFi3Sav, strCl3Ant);
            pCalculaTotalGeral;
            fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text := strClaFi3Ant;
            fatVenda.strClaFi3 := strClaFi3Ant;
          End;
        End;

        If Result And (fDeveAtualizarOsTotaisEmTela) And (fClassificacoesDaTelaMudaram) Then
        Begin
          FUsuarioAlterouClassificacaoReforma := True;
          pCalculaTotalGeral;
        End;

      End;

    End

    Else If (Sender = fraDadosFechamentoVendaPlanContasFrame.mskCodCta) And (fraDadosFechamentoVendaPlanContasFrame.mskCodCta.Visible) Then
    Begin

      If Not fEmptyStr(fraDadosFechamentoVendaPlanContasFrame.mskCodCta.Text) Then
      Begin
        pCarregaCentroCusto;
        If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
          Result := PlanoDeContasAtivo(fraDadosFechamentoVendaPlanContasFrame.mskCodCta.Text,True);
      End
      Else
      Begin
        fraDadosFechamentoVendaPlanContasFrame.edtDesCta.Clear;
      End;

    End

    Else If (Sender = fraDadosFechamentoVendaTotaisFrame.edtBasIcm) Or (Sender = fraDadosFechamentoVendaTotaisFrame.edtValIcm) Or
            (Sender = fraDadosFechamentoVendaTotaisFrame.edtBasIpi) Or (Sender = fraDadosFechamentoVendaTotaisFrame.edtValIpi) Or
            (Sender = fraDadosFechamentoVendaTotaisFrame.edtBasRet) Or (Sender = fraDadosFechamentoVendaTotaisFrame.edtValRet) Or
            (Sender = fraDadosFechamentoVendaTotaisFrame.edtBasFCPST) Or (Sender = fraDadosFechamentoVendaTotaisFrame.edtValFCPST) Or (Sender = fraDadosFechamentoVendaTotaisFrame.edtAlqFCPST) Then
    Begin

      If btnDigImpostosItens.Visible Or (fatVenda.strOpcDoc = 'NC') Then
      Begin

        pAtualizaRodape;

        If (fatVenda.strOpcDoc = 'NC') Then
          fatVenda.fltNotCom := fStrToFloat(fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.Text);

        If (Not fEmptyStr((Sender As TEdit).Text)) Then
        Begin
          If (fStrToFloat((Sender As TEdit).Text) < 0.0) Then
          Begin
            fMensagem('', 'Valores fiscais devem ser maior ou igual a Zero!', ['&O k']);
            Result := False;
          End;
        End;
      End;

    End

    Else If (Sender = fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer) And (Not fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.ReadOnly) Then
    Begin

      If fStrToFloat(fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.Text) <= 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Total deve ser maior que Zero!', ['&O k']);
        Result := False;
      End

      Else if blnBuscaPorChave Then
             fatVenda.fltImpTot := fStrToFloat(fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.Text);

    End

    Else If (Sender = fraCentroCusto.edtCodEve) And pnlEvento.Visible Then
    begin
      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        fraCentroCusto.edtDesEve.Text := fRetNomEventoExiFat(fraCentroCusto.edtCodEve);
        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End
      Else
      begin
        fraCentroCusto.edtDesEve.Clear;

        if fCfgSis('OBGCCF', varBoolean) then
        begin
          fMensagem('','Atenção! É obrigatório o preenchimento do campo "Centro de Custos" conforme definido na configuração CFG_OBGCCF.',['&OK']);
          Result := False
        end;        
      end;
    end

    Else If (fraDadosFechamentoVendaTotaisFrame.edtCodSit.Visible) And (Sender = fraDadosFechamentoVendaTotaisFrame.edtCodSit) Then
    Begin
      If fEmptyStr(fraDadosFechamentoVendaTotaisFrame.edtCodSit.Text) Then
      Begin
        fMensagem('', 'Defina uma CST para a nota de complemento!', ['&OK']);
        Result := False;
      End
      Else If fEmptyStr(fRetSitTributaria(fraDadosFechamentoVendaTotaisFrame.edtCodSit.Text)) Then
      Begin
        fMensagem('', 'Código CST não cadastrado!', ['&OK']);
        Result := False;
      End;
    End

    Else If (fraDadosFechamentoVendaTotaisFrame.edtCstPis.Visible) And (Sender = fraDadosFechamentoVendaTotaisFrame.edtCstPis) Then
    Begin
      If fEmptyStr(fraDadosFechamentoVendaTotaisFrame.edtCstPis.Text) Then
      Begin
        fMensagem('', 'Defina uma CST de PIS para a nota de complemento!', ['&OK']);
        Result := False;
      End
      Else If pos(fraDadosFechamentoVendaTotaisFrame.edtCstPis.Text, '01_02_03_04_05_06_07_08_09_49_50_51_52_53_54_55_56_60_61_62_63_64_65_66_67_70_71_72_73_74_75_98_99_') = 0 Then
      Begin
        fMensagem('', 'Código CST de PIS inválido!', ['&OK']);
        Result := False;
      End;
    End

    Else If (fraDadosFechamentoVendaTotaisFrame.edtCstCof.Visible) And (Sender = fraDadosFechamentoVendaTotaisFrame.edtCstCof) Then
    Begin
      If fEmptyStr(fraDadosFechamentoVendaTotaisFrame.edtCstCof.Text) Then
      Begin
        fMensagem('', 'Defina uma CST de COFINS para a nota de complemento!', ['&OK']);
        Result := False;
      End
      Else If pos(fraDadosFechamentoVendaTotaisFrame.edtCstCof.Text, '01_02_03_04_05_06_07_08_09_49_50_51_52_53_54_55_56_60_61_62_63_64_65_66_67_70_71_72_73_74_75_98_99_') = 0 Then
      Begin
        fMensagem('', 'Código CST de COFINS inválido!', ['&OK']);
        Result := False;
      End;
    End

    Else If (fraDadosFechamentoVendaTotaisFrame.edtCstIpi.Visible) And (Sender = fraDadosFechamentoVendaTotaisFrame.edtCstIpi) Then
    Begin
      If fEmptyStr(fraDadosFechamentoVendaTotaisFrame.edtCstIpi.Text) Then
      Begin
        fMensagem('', 'Defina uma CST de IPI para a nota de complemento!', ['&OK']);
        Result := False;
      End
      Else If pos(fraDadosFechamentoVendaTotaisFrame.edtCstIpi.Text, '00_01_02_03_04_05_49_50_51_52_53_54_55_99_') = 0 Then
      Begin
        fMensagem('', 'Código CST de IPI inválido!', ['&OK']);
        Result := False;
      End;
    End;

    If (Sender = fraDadosFechamentoVendaProjetoFrame.edtCodPrj) And pnlProjeto.Visible Then
    Begin
      If Not fEmptyStr(fraDadosFechamentoVendaProjetoFrame.edtCodPrj.Text) Then
      Begin
        fraDadosFechamentoVendaProjetoFrame.edtDesPrj.Text := fCampoTabela('PRJ_DESPRJ', 'CADPRJ', ['PRJ_CODPRJ'], [fraDadosFechamentoVendaProjetoFrame.edtCodPrj.Text], False);

        If fEmptyStr(fraDadosFechamentoVendaProjetoFrame.edtDesPrj.Text) Then
        Begin
          fMensagem('', 'Projeto não encontrado !', ['&Ok']);
          Result := False;
          fraDadosFechamentoVendaProjetoFrame.edtDesPrj.Clear;
        End
        Else
        If Not TProjeto.fClienteTemProjetoAtivo(fatVenda.strCodCli, fraDadosFechamentoVendaProjetoFrame.edtCodPrj.Text) Then
        Begin
          fMensagem('', 'Projeto não encontrado para o cliente do pedido!', ['&Ok']);
          Result := False;
          fraDadosFechamentoVendaProjetoFrame.edtDesPrj.Clear;
        End;
      End;
    End

    Else If (Sender = fraEmpresaFaturamentoFrame1.edtCodEmpFat) And (pnlEmpFat.Visible) Then
    Begin
      if fEmptyStr(fraEmpresaFaturamentoFrame1.edtCodEmpFat.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Empresa de Faturamento deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        fraEmpresaFaturamentoFrame1.edtDesEmpFat.Text := fRetNomeEmpresa(fraEmpresaFaturamentoFrame1.edtCodEmpFat.Text);
        If fEmptyStr(fraEmpresaFaturamentoFrame1.edtDesEmpFat.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não encontrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodTpa) And pnlTipAte.Visible Then
    Begin
      edtDesTpa.Text := fRetNomTipoAtend(edtCodTpa.Text);

      If Not fEmptyStr(fTiraCaracEspeciais(edtCodTpa.Text)) Then
      Begin
        If fEmptyStr(edtDesTpa.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este Tipo de Atendimento não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        If fCfgSis('OBRTPA', VarBoolean) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Tipo de Atendimento deve ser preenchido!', ['&Ok']);
          Result := False;
        End;
      End;
    End;
  End;

  If (Not Result) Then
  Begin
    If not FUsaTrocaDeCfopNaDigitacaoDeImpostos Then
      strClaFisAnt := '';

    pSetFocus(Sender);
  End;

end;

function TfrmFatDadosFiscais.fValidarAteracaoFreteGF: Boolean;
Var
  lstrValFre,
  lstrTipFre: String;
begin
  Result := True;

  if Not ((Not blnZeraFrete) And
          ((fatVenda.strOpcDoc = 'GF') or (fatVenda.strOpcDocTrue = 'NW')) And
          (Not fEhConfirmacaoEspelhoEnvioFornecedor) And
          fraDadosFechamentoVendaTransportadoraFrame.edtValFre.enabled) then
  begin
    Exit;
  end;

  Try
    lstrValFre := fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text;
    lstrTipFre := fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Text;

    if fEmptyStr(strTipFreAnt) Or
         (strTipFreAnt <> fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Text) then
    begin
      if Not fValidaCampos(fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre, True) then
        raise Exception.Create('');
    end;

    if (lstrValFre <> fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text) Or
       fAlterouValorFrete then
    begin
      fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text := lstrValFre;
      if Not fValidaCampos(fraDadosFechamentoVendaTransportadoraFrame.edtValFre, True) then
        raise Exception.Create('')
    end;
  Except
    On E: Exception do
    begin
      Result := False;
    end;
  End;
end;

function TfrmFatDadosFiscais.fValidouPreenchimentoCFOPAtivoImobilizado(
  const strCFOP: String): Boolean;
begin

  Result := True;

  If (fatVenda.strOpcDoc <> 'NP') Then
    Exit;

  If (fEmptyStr(strCFOP)) Then
    Exit;

  Result := SameText(Copy(strCFOP, 2, 3), fCfgSis('CLAATI', varString));

  If (Not Result) Then
    fMensagem('ATENÇÃO','Classificação fiscal informada não é valida para emissão de notas de Ativo Imobilizado.' + sLineBreak +
              'Somente é permitido informar a classificação x' + fCfgSis('CLAATI', varString) + ' configurada em "CFG_CLAATI" ',['&OK']);

end;

function TfrmFatDadosFiscais.fZeraImpostoFaturaConsignacao(strClaFis: String): Boolean;
begin
  Result := (fCfgSis('FAMECO', varString) <> '1') And (Pos(strClaFis, fCfgSis('FATCON', varString)) > 0);
end;

procedure TfrmFatDadosFiscais.lblEdiPesClick(Sender: TObject);
begin
  inherited;
  pAbreTelaDigPesoProduto;
end;

function TfrmFatDadosFiscais.fMensagemExiste(strMsg1, strMsg2, strMsg3, strMsg4,
  strMsg5, strMsgPrincipal: string): Boolean;
begin
  strMsg1 := UpperCase(strMsg1);
  strMsg2 := UpperCase(strMsg2);
  strMsg3 := UpperCase(strMsg3);
  strMsg4 := UpperCase(strMsg4);
  strMsg5 := UpperCase(strMsg5);
  strMsgPrincipal := UpperCase(strMsgPrincipal);

  Result := False;
  case AnsiIndexStr(strMsgPrincipal,[strMsg1,strMsg2,strMsg3,strMsg4,strMsg5]) of
    0: Result := True;
    1: Result := True;
    2: Result := True;
    3: Result := True;
    4: Result := True;
  end;
end;

procedure TfrmFatDadosFiscais.FormCreate(Sender: TObject);
  Var
    intTipFre: Integer;
begin
  inherited;
  //Devem iniciar vazias para validar pelo menos uma vez
  blnVisualizacaoEspelhoDevolucao := False;
  blnNFCeComplementar := False;

  blnFatDadosFiscaisImpostosExterno := False;

  blnFatBaixaPedidoDev := False;

  blnMudouClassificacao := False;
  blnRespondeuPerguntaSeDesejaCarregarFrete := False;

  FUsaTrocaDeCfopNaDigitacaoDeImpostos := False;
  FUsuarioAlterouClassificacaoReforma := False;

  strDesAceAnt := '';
  strValFreAnt := '';
  strClaFisAnt := '';
  strValFreCotAnt := '';

  strPesBruAnt := '';
  strPesLiqAnt := '';

  fltDevolucaoEspelhoAD_ValFre := 0;
  fltDevolucaoEspelhoAD_DesAce := 0;

  fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Clear;
  For intTipFre In TiposFrete Do
    fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Items.Add(fDescricaoFrete(IntToStr(intTipFre)));

  blnExpedicao := False;
  blnMostraFreteCotado := False;

  intPnlCon := pnlConfirma.Height;
  intPnlSta := pnlStatus.Height;
  intPnlTra := pnlTransportadora.Height;
  intPlMeEx := pnlMenExp.Height;
  intPnlEve := pnlEvento.Height;
  intPnlMen := pnlMensagem.Height;
  intPnlRes := pnlResImp.Height;
  intPnlDes := pnlDesconto.Height;
  intPnlOFC := pnlGravaFinanceiro.Height;
  intPnlSer := pnlDadSer.Height;
  intPnlPrj := pnlProjeto.Height;
  intPnlTpa := pnlTipAte.Height;

  blnNotImp := FALSE;
  blnNotImpXML := False;

  intSemaforoConfirma := -1;

  blnConfirma     := False;
  blnPodeCancelar := TRUE;
  blnForcaEdiBas  := False;

  qryCadTra := fCriarQuery('SELECT * FROM CADTRA WHERE FALSE', Self);
  qryConTra := qryCadTra;
  qryConCfo := fCriaQuery(Self);
  qryCadCfo := fCriaQuery(Self);
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);

  strFatCon := fTransform(fCfgSis('FATCON'), 4);

  fltOUTDesAce := null;

  objLiberacao := TLiberacao.create;

  cdsImpostos_Ant := fCriacdsImpostos;
  cdsImpostos_Pos := fCriacdsImpostos;

  blnLiberouTravaDeClassificacaoFiscalDeBonificacao := False;

  blnConfirmacaoEspelho := False;
  blnEspelhoEnvioParaOFornecedor := False;
  FblnEspRascDANFE := False;
  blnEhNotaEspecialFatorPorValor := False;
end;

procedure TfrmFatDadosFiscais.FormDestroy(Sender: TObject);
begin

  FreeAndNil(objLiberacao);

  If Assigned(cdsImpostos_Ant) Then
    FreeAndNil(cdsImpostos_Ant);

  If Assigned(cdsImpostos_Pos) Then
    FreeAndNil(cdsImpostos_Pos);

  If Assigned(frmFatDadosFiscaisImpostos) And (Not blnFatDadosFiscaisImpostosExterno) Then
    FreeAndNil(frmFatDadosFiscaisImpostos);

  If Assigned(cdsConfiguracaoNotaDeImportacaoDesonerada) Then
    FreeAndNil(cdsConfiguracaoNotaDeImportacaoDesonerada);

  If Assigned(dspConfiguracaoNotaDeImportacaoDesonerada) Then
    FreeAndNil(dspConfiguracaoNotaDeImportacaoDesonerada);

  If Assigned(qryConfiguracaoNotaDeImportacaoDesonerada) Then
    FreeAndNil(qryConfiguracaoNotaDeImportacaoDesonerada);

  If (Assigned(objValidacoesFrete)) Then
    FreeAndNil(objValidacoesFrete);

  inherited;

end;

procedure TfrmFatDadosFiscais.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F4: btnMostraMargem.Click;
  End;
end;

procedure TfrmFatDadosFiscais.FormShow(Sender: TObject);
begin
  inherited;
  pOnShow;
end;

procedure TfrmFatDadosFiscais.pCarregaCadTra;
begin
  If ((Not blnCalcFreteSugestaoTranp) And (Not blnCalcFreteSugestaoRegia)) Or (fTravaTransportadoraPoisJaFoiDefinido) Then
    pPesquisaCadTra(qryConTra, qryConTra, fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text, 'S')
  Else
  Begin
    If (blnCalcFreteSugestaoRegia) Then
      pPesquisaCadTraRegFrete(qryConTra, qryConTra, fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text, fatVenda.fRetornaStrCodRegEntAtual, 'S')
    Else
      pPesquisaCadTraCidFrete(qryConTra, qryConTra, fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text, fatVenda.fRetornaStrCodCidEntAtual, 'S');
  End;

  With qryConTra Do
  Begin
    fraDadosFechamentoVendaTransportadoraFrame.edtNomTra.Text := FieldByName('TRA_NOMTRA').AsString
  End;

  If (Not fEmptyStr(fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text)) And (strCodTraAnt <> fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text) Then
    fraDadosFechamentoVendaTransportadoraFrame.mskPlaFat.Text := AnsiReplaceStr(qryConTra.FieldByName('TRA_NUMPLA').AsString, '-', '');
end;

procedure TfrmFatDadosFiscais.edtCodTpaKeyPress(Sender: TObject; var Key: Char);
var
  arrTpaAte: TConsultasArray;
begin
  inherited;

  If fPesqTipoAtendimento(Self, edtCodTpa, edtDesTpa, Nil, Key, arrTpaAte) Then
  Begin
    if fValidaCampos(edtCodTpa, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDadosFiscais.edtCodTraKeyPress(Sender: TObject; var Key: Char);
Var
  arrTransp  : TConsultasArray;
  TipoConTra : TTipoConsultaTransportad;
  strCidReg  : String;
  edtTraCod  : TCustomEdit;
  edtTraNom  : TEditFocus;
begin

  inherited;

  edtTraCod := fraDadosFechamentoVendaTransportadoraFrame.edtCodTra;
  edtTraNom := fraDadosFechamentoVendaTransportadoraFrame.edtNomTra;

  If (Sender = fraDadosFechamentoVendaTransportadoraFrame.edtTraRedCod) Then
  Begin
    edtTraCod := fraDadosFechamentoVendaTransportadoraFrame.edtTraRedCod;
    edtTraNom := fraDadosFechamentoVendaTransportadoraFrame.edtTraRedNom;
  End;

  {************************************}
  {* NOVA CONSULTA DE TRANSPORTADORAS *}
  {*********************************RV*}
  If (blnCalcFreteSugestaoTranp) Then
  Begin
    TipoConTra := conTraCidFrete;
    strCidReg  := fatVenda.fRetornaStrCodCidEntAtual;
  End
  Else If (blnCalcFreteSugestaoRegia) Then
  Begin
    TipoConTra := conTraRegFrete;
    strCidReg  := fatVenda.fRetornaStrCodRegEntAtual;
  End
  Else
  Begin
    TipoConTra := conTraCompleta;
    strCidReg  := '';
  End;

  If fPesqTransportadora(TipoConTra, Self, edtTraCod, edtTraNom, Nil, Key, arrTransp, True, strCidReg, 'S', fatVenda.fltTotGer) Then
  Begin
    If fValidaCampos(edtTraCod, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFatDadosFiscais.pCarregaCadCfo(edtClassificacao: TEdit; blnAtualizaEdits: Boolean);
  Var
    intContador: Integer;
    strMensagem: String;
    stlMen50p  : TStringList;
    strDesClaAux : String;
    strMen50p  : String;

  function fEditouDescricaoClaFis: Boolean;
  begin
    Result := ((Not fEmptyStr(strDesClaAnt)) And (fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Enabled));
  end;

begin

  pPesquisaCadCfo(qryCadCfo, qryConCfo, fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text);
  With qryConCfo Do
  Begin

    If (edtClassificacao = fraDadosFechamentoVendaClaFisFrame.edtClaFis) And
       ((blnAtualizaEdits) Or (fEmptyStr(fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Text))) Then
    Begin
      intOpcCfo := fCfgSis('OPCCFO', varInteger);

      If intOpcCfo = 2 Then
      Begin
        fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Style := csSimple;
        strDesClaAux := FieldByName('CFO_DESCR1').AsString;
      End
      Else
      Begin
        fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Style := csDropDownList;
        strDesClaAux := FieldByName('CFO_NATOPE').AsString;
      End;

      If Not fEditouDescricaoClaFis Then
      Begin
        If (fatVenda.blnEstornoNotaFiscalEntregaFutura) Then
          fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Text := 'ESTORNO DE SIMPLES FATURAMENTO'
        Else
          fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Text := strDesClaAux;
      End;

      {*****************************************}
      {* QUANDO FOR REMESSA POR CONTA E ORDEM, *}
      {* É UMA MENSAGEM PRÉ-DEFINIDA.          *}
      {**************************************MV*}
      If ((Pos(fatVenda.strOpcDoc,'MF_') > 0) And (fEmptyStr(fatVenda.strMen001)))  or (fatVenda.strOpcDoc = 'CO')Then
      Begin

        strMensagem := AnsiReplaceStr(fatVenda.strMensagContaOrdem, ' DE R$ 0,00', ' DE R$ ' + FloatToStrF(fatVenda.fltTotGer, ffNumber, 12, 2));
        strMen50p := strMensagem;

        If (fatVenda.strOpcDoc = 'CO') Then
        Begin
          For intContador := Low(fatVenda.arrMenOri) To High(fatvenda.arrMenOri) DO
          Begin
            If Not fEmptyStr(fatVenda.arrMenOri[intContador]) Then
            Begin
              strMen50p := strMen50p + ' ' + fatVenda.arrMenOri[intContador];
            End;
          End;
        End;

        stlMen50p := TStringList.Create;
        stlMen50p.Text := WrapText(strMen50p, #13#10, [' '], 50);

        For intContador := 0 To stlMen50p.Count-1 Do
        Begin

          If (intContador = 0) And (fraDadosFechamentoVendaMSGFatFrame.edtMens01.Visible) And (fEmptyStr(fraDadosFechamentoVendaMSGFatFrame.edtMens01.Text)) Then
          Begin
            fatVenda.strMen501 := stlMen50p.Strings[intContador];
            fatVenda.strMen001 := Copy(strMensagem, 001, 80);
            fraDadosFechamentoVendaMSGFatFrame.edtMens01.Text := fatVenda.strMen001;
          End

          Else If (intContador = 1) And (fraDadosFechamentoVendaMSGFatFrame.edtMens02.Visible) And (fEmptyStr(fraDadosFechamentoVendaMSGFatFrame.edtMens02.Text)) Then
          Begin
            fatVenda.strMen502 := stlMen50p.Strings[intContador];
            fatVenda.strMen002 := Copy(strMensagem, 081, 80);
            fraDadosFechamentoVendaMSGFatFrame.edtMens02.Text     := fatVenda.strMen002;
          End

          Else If (intContador = 2) And (fraDadosFechamentoVendaMSGFatFrame.edtMens03.Visible) And (fEmptyStr(fraDadosFechamentoVendaMSGFatFrame.edtMens03.Text)) Then
          Begin
            fatVenda.strMen503 := stlMen50p.Strings[intContador];
            fatVenda.strMen003 := Copy(strMensagem, 161, 80);
            fraDadosFechamentoVendaMSGFatFrame.edtMens03.Text     := fatVenda.strMen003;
          End

          Else If (intContador = 3) And (fraDadosFechamentoVendaMSGFatFrame.edtMens04.Visible) And (fEmptyStr(fraDadosFechamentoVendaMSGFatFrame.edtMens04.Text)) Then
          Begin
            fatVenda.strMen504 := stlMen50p.Strings[intContador];
            fraDadosFechamentoVendaMSGFatFrame.edtMens04.Text     := fatVenda.strMen004;
          End

          Else If (intContador = 4) And (fraDadosFechamentoVendaMSGFatFrame.edtMens05.Visible) And (fEmptyStr(fraDadosFechamentoVendaMSGFatFrame.edtMens05.Text)) Then
          Begin
            fatVenda.strMen505 := stlMen50p.Strings[intContador];
            fraDadosFechamentoVendaMSGFatFrame.edtMens05.Text     := fatVenda.strMen005;
          End
          Else If intContador = 5 Then fatVenda.strMen506 := stlMen50p.Strings[intContador]
          Else If intContador = 6 Then fatVenda.strMen507 := stlMen50p.Strings[intContador]
          Else If intContador = 7 Then fatVenda.strMen508 := stlMen50p.Strings[intContador];

        End;

        FreeAndNil(stlMen50p);
      End;

      If (fatVenda.strOpcDoc = 'CO') Then
      Begin
        {*****************************************}
        {* USA A MENSAGEM DO DOCUMENTO ORIGINAL  *}
        {**************************************MV*}
        For intContador := Low(fatVenda.arrMenOri) To High(fatVenda.arrMenOri) Do
        Begin
          if (fEmptyStr(fatVenda.arrMenOri[intContador])) or (fMensagemExiste(fatVenda.strMen001, fatVenda.strMen002, fatVenda.strMen003, fatVenda.strMen004, fatVenda.strMen005, fatVenda.arrMenOri[intContador])) then
            Continue

          Else If (fEmptyStr(fatVenda.strMen001)) Then
            fatVenda.strMen001 := fatVenda.arrMenOri[intContador]

          Else If (fEmptyStr(fatVenda.strMen002)) Then
            fatVenda.strMen002 := fatVenda.arrMenOri[intContador]

          Else If (fEmptyStr(fatVenda.strMen003)) Then
            fatVenda.strMen003 := fatVenda.arrMenOri[intContador]

          Else If (fEmptyStr(fatVenda.strMen004)) Then
            fatVenda.strMen004 := fatVenda.arrMenOri[intContador]

          Else If (fEmptyStr(fatVenda.strMen005)) Then
            fatVenda.strMen005 := fatVenda.arrMenOri[intContador];
        End;
      End;

      fatVenda.strMenCfo1 := FieldByName('CFO_MNAT01').AsString;
      fatVenda.strMenCfo2 := FieldByName('CFO_MNAT02').AsString;
      fatVenda.strMenCfo3 := FieldByName('CFO_MNAT03').AsString;

    End;
  End;
end;

procedure TfrmFatDadosFiscais.edtClaFisKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCFOP: TConsultasArray;
begin
  inherited;

  If FUsaTrocaDeCfopNaDigitacaoDeImpostos Then
  Begin
    Key := #0;
    fMensagem('ATENÇÃO!', 'A CFOP deve ser alterada através do botão "Digitar Impostos"', ['&Ok']);
    Exit;
  End;

  {*******************************}
  {* NOVA CONSULTA DE CFOP       *}
  {****************************RV*}
  If fPesqCFOP(Self, (Sender As TEditFocus), nil, qryConCfo, Key, arrCFOP) Then
  Begin
    fatVenda.strMenCfo1 := qryConCfo.FieldByName('CFO_MNAT01').AsString;
    fatVenda.strMenCfo2 := qryConCfo.FieldByName('CFO_MNAT02').AsString;
    fatVenda.strMenCfo3 := qryConCfo.FieldByName('CFO_MNAT03').AsString;

    If fValidaCampos((Sender As TEditFocus), True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFatDadosFiscais.pCarregaNatOperacao(strCodCfo: String);
var qryNatOpe: TUniQuery;
Begin
  If (fatVenda.blnEstornoNotaFiscalEntregaFutura) Then
    Exit;
  Try
    qryNatOpe := fCriaQuery(Self);
    With qryNatOpe, SQL do
    Begin
      Close;
      Clear;
      Add('SELECT NAT_DESCRI FROM NATCFO');
      Add('WHERE NAT_ATIVO_ = "S" ');
      Add('  AND NAT_CODCFO = :CODCFO');
      ParamByName('CODCFO').AsString := strCodCfo ;
      Open;

      fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Clear;
      While not eof do
      Begin
        fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Items.Add( FieldByName('NAT_DESCRI').AsString );

        Next;
      End;

      If RecordCount > 0 Then
      Begin
        fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.ItemIndex := 0;
        strDesClaAnt := Trim(fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Text);
      End;

    End;

  Finally
    FreeAndNil(qryNatOpe);
  End;

End;

Procedure TfrmFatDadosFiscais.pAjustaAlturaForm;
Begin

  Self.ClientHeight := Self.ClientHeight + intPnlCon - intPnlSta;

  If Not pnlTransportadora.Visible then
    Self.ClientHeight := Self.ClientHeight - intPnlTra;

  If Not pnlMenExp.Visible then
    Self.ClientHeight := Self.ClientHeight - intPlMeEx;

  If Not pnlEvento.Visible then
    Self.ClientHeight := Self.ClientHeight - intPnlEve;

  If Not pnlMensagem.Visible then
    Self.ClientHeight := Self.ClientHeight - intPnlMen;

  If Not pnlResImp.Visible then
    Self.ClientHeight := Self.ClientHeight - intPnlRes;

  If Not pnlDesconto.Visible then
    Self.ClientHeight := Self.ClientHeight - intPnlDes;

  If Not pnlGravaFinanceiro.Visible then
    Self.ClientHeight := Self.ClientHeight - intPnlOFC;

  If Not pnlDadSer.Visible then
    Self.ClientHeight := Self.ClientHeight - intPnlSer;

  If Not pnlProjeto.Visible then
    Self.ClientHeight := Self.ClientHeight - intPnlPrj;

  If Not pnlTipAte.Visible then
    Self.ClientHeight := Self.ClientHeight - intPnlTpa;

End;

function TfrmFatDadosFiscais.fFreteValidoDevolucao: Boolean;
  Var
    strFreDev: String;
    intIdxFre: Integer;
begin
  Result := True;

  If (fatVenda.strOpcDoc = 'DV') Then
  Begin
    strFreDev := fPadR(fCfgSis('PMFRDV', varString), Length(TiposFrete), 'N');

    intIdxFre := fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.ItemIndex+1;
    If (Copy(strFreDev, intIdxFre, 1) <> 'S') Then
    Begin
      fMensagem('Atenção!', 'Tipo de frete '+fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Text+' não é permitido para emissão de nota fiscal de devolução '+
                            'para clientes conforme definido na configuração '+'"CFG_PMFRDV - '+fRetNomCfg('PMFRDV')+'"', ['&O k']);
      Result := False;
    End;
  End;
end;

function TfrmFatDadosFiscais.fGetInputPassarZeroEmitenteCIF: TInputPassarZeroEmitenteCIF;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result.EditValFre := fraDadosFechamentoVendaTransportadoraFrame.edtValFre;
  Result.ComboTipFre := fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre;
  Result.CodigoTransportadora := fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text;
end;

function TfrmFatDadosFiscais.fConfirmaDados: Boolean;
  Var
    intContador: Integer;
    stlMen50p  : TStringList;
    fltTmpCal  : Double;
    itemNfeComp: TNfeComplementoItem;
    strComLub  : String;
begin

  Result := True;

  {*****************************************}
  {* CALCULA O FRETE DE DESCONTO ESPECIAL  *}
  {* DE ORGÃO PÚBLICO                      *}
  {**************************************MV*}
  {If (fatVenda.strCliOrg = 'S') And (fCfgSis('SIMPAU') <> 'S') And
     (fatVenda.fDentroDoEstado)                                Then
  Begin

    fatVenda.fltDesEsp := fatVenda.fltDesEsp + fatVenda.fltFreIco;
    fatVenda.fltBasOrg := fatVenda.fltBasOrg + fatVenda.fltFreOrg;
    fatVenda.fltIcmOrg := fatVenda.fltIcmOrg + fatVenda.fltFreIco;
    fatVenda.fltTotGer := fatVenda.fltTotGer - fatVenda.fltFreIco;

  End;}

//  If (edtClaFis.Enabled) Or (fatVenda.blnCliFil) Then
//  Begin
  fatVenda.fltTotGer := fatVenda.fltTotGer + fltTotIpiOri;
  fatVenda.fltTotGer := fatVenda.fltTotGer + fltTotRetOri;
  fatVenda.fltTotGer := fatVenda.fltTotGer + fatVenda.fltValIpiZeradoFaturaConsignacao +
                                             fatVenda.fltValSTZeradoFaturaConsignacao  +
                                             fatVenda.fltValFcpSTZeradoFaturaConsignacao;


//  End;

  {*****************************************}
  {* CARREGA VARIAVEIS                     *}
  {**************************************MV*}
  fatVenda.strCodTpA := edtCodTpa.Text;
  fatVenda.strCodTra := fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text;
  fatVenda.strNomTra := fraDadosFechamentoVendaTransportadoraFrame.edtNomTra.Text;
  fatVenda.strEndTra := qryConTra.FieldByName('TRA_ENDERE').AsString;
  fatVenda.strNumPla := qryConTra.FieldByName('TRA_NUMPLA').AsString;
  fatVenda.strCgcTra := qryConTra.FieldByName('TRA_C_G_C_').AsString;
  fatVenda.strIesTra := qryConTra.FieldByName('TRA_I_E_S_').AsString;
  fatVenda.strCidTra := fRetNomCidade(qryConTra.FieldByName('TRA_CODCID').AsString, 0);
  fatVenda.strEstTra := fRetNomCidade(qryConTra.FieldByName('TRA_CODCID').AsString, 1);
  fatVenda.strCodPrj := fraDadosFechamentoVendaProjetoFrame.edtCodPrj.Text;
   fatVenda.strNomPrj := fCampoTabela('PRJ_DESPRJ', 'CADPRJ', ['PRJ_CODPRJ'], [fraDadosFechamentoVendaProjetoFrame.edtCodPrj.Text], False);

  fatVenda.fltValFre := fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text);
  fatVenda.strTipFre := fTipoFrete(fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Text);

  fatVenda.fltDesAce := fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text) + fatVenda.fltValIpiZeradoFaturaConsignacao +
                                                                                                 fatVenda.fltValSTZeradoFaturaConsignacao  +
                                                                                                 fatVenda.fltValFcpSTZeradoFaturaConsignacao;

  fatVenda.intQtdTra := StrToIntDef(fraDadosFechamentoVendaTransportadoraFrame.edtQtdTra.Text, 0);
  fatVenda.strEspTra := fraDadosFechamentoVendaTransportadoraFrame.edtEspTra.Text;
  fatVenda.strMarTra := fraDadosFechamentoVendaTransportadoraFrame.edtMarTra.Text;
  fatVenda.strNumera := fraDadosFechamentoVendaTransportadoraFrame.edtNumera.Text;
  fatVenda.intNConhe := StrToIntDef(fraDadosFechamentoVendaTransportadoraFrame.edtNConhe.Text, -1);

  If fraDadosFechamentoVendaTransportadoraFrame.pnlVolumeSepExc.Visible Then
  Begin
    fatVenda.intQtdTraSepExc  := StrToIntDef(fraDadosFechamentoVendaTransportadoraFrame.edtQtdTraSepExc.Text, 0);
    fatVenda.intQtdTraSepNExc := StrToIntDef(fraDadosFechamentoVendaTransportadoraFrame.edtQtdTraSepNExc.Text, 0);
  End;

  fatVenda.fltPesBru := fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtPesBru.Text);
  fatVenda.fltPesLiq := fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtPesLiq.Text);

  fatVenda.strClaFis := fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text;
  If (RightStr(fatVenda.strClaFis, 3) = '933') Then
    fatVenda.strClaSer := fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text

  Else If (RightStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text, 3) = '933') Then
    fatVenda.strClaSer := fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text

  Else If (RightStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text, 3) = '933') Then
    fatVenda.strClaSer := fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text

  Else If (Not fEmptyStr(fatVenda.strClaSer)) Then
    fatVenda.strClaSer := fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text;

  fatVenda.strDesCla := fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Text;

  If intOpcCfo = 1 Then
  Begin
    If (Not fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text)) Then
      fatVenda.strDesCl2 := fRetNomGeral('NAT_DESCRI','NAT_CODCFO','NATCFO',fStrToFloat(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text))
    Else
      fatVenda.strDesCl2 := '';

    If (Not fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text)) Then
      fatVenda.strDesCl3 := fRetNomGeral('NAT_DESCRI','NAT_CODCFO','NATCFO',fStrToFloat(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text))
    Else
      fatVenda.strDesCl3 := '';
  End
  Else
  Begin
    If (Not fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text)) Then
      fatVenda.strDesCl2 := fRetNomGeral('CFO_DESCR1','CFO_CODCFO','CADCFO',fStrToFloat(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text))
    Else
      fatVenda.strDesCl2 := '';

    If (Not fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text)) Then
      fatVenda.strDesCl3 := fRetNomGeral('CFO_DESCR1','CFO_CODCFO','CADCFO',fStrToFloat(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text))
    Else
      fatVenda.strDesCl3 := '';
  End;

  fatVenda.strClaFi2 := fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text;
  fatVenda.strClaFi3 := fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text;

  {**********************************************}
  {* CASO TENHA SERVIÇO EM UMA NOTA, ACRESCENTA *}
  {* "\SERVIÇOS" NA NATUREZA DA OPERAÇÃO        *}
  {*******************************************MV*}
  If (fCfgSis('SERNAT', varBoolean)) Then
  Begin
    If (RightStr(fatVenda.strClaFi2, 3) = '933') Or
       (RightStr(fatVenda.strClaFi3, 3) = '933') Then
    Begin

      If (Pos('SERVICOS', fatVenda.strDesCla) <= 0) Then
        fatVenda.strDesCla := fatVenda.strDesCla + '/SERVICOS';

    End;
  End;

  fatVenda.strMen001 := Trim(fraDadosFechamentoVendaMSGFatFrame.edtMens01.Text);
  fatVenda.strMen002 := Trim(fraDadosFechamentoVendaMSGFatFrame.edtMens02.Text);
  fatVenda.strMen003 := Trim(fraDadosFechamentoVendaMSGFatFrame.edtMens03.Text);
  fatVenda.strMen004 := Trim(fraDadosFechamentoVendaMSGFatFrame.edtMens04.Text);
  fatVenda.strMen005 := Trim(fraDadosFechamentoVendaMSGFatFrame.edtMens05.Text);

  If fatVenda.strOpcDoc = 'NC' Then
    pAjustaMensagemNC;

  If (pnlMenExp.Visible) And (fraDadosFechamentoVendaMSGExpFrame.edtMenExp.Enabled) Then
  Begin
    fatVenda.strMenExp := Trim(fraDadosFechamentoVendaMSGExpFrame.edtMenExp.Text);
    fatVenda.strMenEx2 := Trim(fraDadosFechamentoVendaMSGExpFrame.edtMenEx2.Text);
    fatVenda.strMenEx3 := Trim(fraDadosFechamentoVendaMSGExpFrame.edtMenEx3.Text);
    fatVenda.strMenEx4 := Trim(fraDadosFechamentoVendaMSGExpFrame.edtMenEx4.Text);
  End;

  If fatVenda.strOpcDoc <> 'CO' Then
  Begin
    stlMen50p      := TStringList.Create;
    stlMen50p.Text := WrapText(fatVenda.strMen001 + ' ' + fatVenda.strMen002 + ' ' + fatVenda.strMen003 + ' ' + fatVenda.strMen004 + ' ' + fatVenda.strMen005, #13#10, [' '], 50);

    For intContador := 0 To stlMen50p.Count-1 Do
    Begin
      If intContador = 0 Then fatVenda.strMen501 := stlMen50p.Strings[intContador]
      Else If intContador = 1 Then fatVenda.strMen502 := stlMen50p.Strings[intContador]
      Else If intContador = 2 Then fatVenda.strMen503 := stlMen50p.Strings[intContador]
      Else If intContador = 3 Then fatVenda.strMen504 := stlMen50p.Strings[intContador]
      Else If intContador = 4 Then fatVenda.strMen505 := stlMen50p.Strings[intContador]
      Else If intContador = 5 Then fatVenda.strMen506 := stlMen50p.Strings[intContador]
      Else If intContador = 6 Then fatVenda.strMen507 := stlMen50p.Strings[intContador]
      Else If intContador = 7 Then fatVenda.strMen508 := stlMen50p.Strings[intContador];
    End;
  End;

  fatVenda.fltBasIcm := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Text);
  fatVenda.fltTotIcm := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtValIcm.Text);

  If (fatVenda.fltTotIcm <= 0.0) Then
    fatVenda.fltAlqIcm := 0.0;

  fatVenda.fltBasIpi := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasIpi.Text);
  fatVenda.fltTotIpi := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtValIpi.Text);
  fatVenda.fltBasRet := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasRet.Text);

  fatVenda.fltTotRet   := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtValRet.Text);

  fatVenda.fltBasFcpST := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasFCPST.Text);
  fatVenda.fltAlqFcpST := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtAlqFCPST.Text);
  fatVenda.fltTotFcpST := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtValFCPST.Text);

  If (fatVenda.fltTotIpi <= 0.0) Then
    fatVenda.fltAlqIpi := 0.0;

  If (fatVenda.fltTotRet <= 0.0) Then
  Begin
    fatVenda.fltRetNor := 0.0;
    fatVenda.fltBcrNor := 0.0;
    fatVenda.fltRetCom := 0.0;
    fatVenda.fltBcrCom := 0.0;
  End;

  {*****************************************}
  {* NOTA DE COMPLEMENTO DE ICMS           *}
  {**************************************MV*}
  If fatVenda.strOpcDoc = 'NC' Then
  Begin
    fatVenda.fltNotCom := fStrToFloat(fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.Text);
    fatVenda.fltTotGer := fatVenda.fltNotCom;
    fatVenda.strCstNotCom := fraDadosFechamentoVendaTotaisFrame.edtCodSit.Text;
    fatVenda.strCstIpiNotCom := fraDadosFechamentoVendaTotaisFrame.edtCstIpi.Text;
    fatVenda.strCstPisNotCom := fraDadosFechamentoVendaTotaisFrame.edtCstPis.Text;
    fatVenda.strCstCofNotCom := fraDadosFechamentoVendaTotaisFrame.edtCstCof.Text;

    If (fatVenda.fltTotIcm > 0) And (fatVenda.fltBasIcm > 0) Then
      fatVenda.fltIcmCom := fFormataFloat((fatVenda.fltTotIcm / fatVenda.fltBasIcm) * 100, 2)
    Else
      fatVenda.fltIcmCom := 0;

    If (fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtAlqIcm.Text) > 0) And (fatVenda.fltTotIcm > 0) And (fatVenda.fltBasIcm > 0) Then
    Begin
      fltTmpCal := (fatVenda.fltBasIcm * fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtAlqIcm.Text)) / 100;
      If (not fEhComplementoIcmsComDiferimento) And (Not (CompareValue(fatVenda.fltTotIcm, fltTmpCal, 0.01) = EqualsValue)) Then
      Begin
        fMensagem('','Alíquota de ICMS incompatível com o valor Digitado!',['&OK']);
        Result := False;
      End
      Else
        fatVenda.fltIcmCom := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtAlqIcm.Text);
    End;

    If not fatVenda.fNotaDeComplementoCalculaFCPComReducaoBaseIcmsST Then
    Begin
      If (fatVenda.fltTotFcpST > 0) And (fatVenda.fltBasFcpST > 0) Then
        fatVenda.fltAlqFcpST := fFormataFloat((fatVenda.fltTotFcpST / fatVenda.fltBasFcpST) * 100, 2)
      Else
        fatVenda.fltAlqFcpST := 0;

      If (fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtAlqFCPST.Text) > 0) And (fatVenda.fltTotFcpST > 0) And (fatVenda.fltBasFcpST > 0) Then
      Begin
        fltTmpCal := (fatVenda.fltBasFcpST * fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtAlqFCPST.Text)) / 100;
        If (Not (CompareValue(fatVenda.fltTotFcpST, fltTmpCal, 0.01) = EqualsValue)) Then
        Begin
          fMensagem('','Alíquota de FCP ST incompatível com o valor Digitado!',['&OK']);
          Result := False;
        End
        Else
          fatVenda.fltAlqFcpST := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtAlqFCPST.Text);
      End;
    End;

    {*****************************************}
    {* LIMPA MATRIZ DE RESUMO DE ICMS        *}
    {**************************************MV*}
    SetLength(fatVenda.arrAlqIcm, 0);

    {*****************************************}
    {* GERA RESUMO DE ALIQUOTAS DE ICMS      *}
    {**************************************MV*}
    fatVenda.pGeraAlqIcm( 'T',
                          fatVenda.fltIcmCom,
                          fatVenda.fltBasIcm,
                          fatVenda.fltTotIcm,
                          fatVenda.fltNotCom,
                          fatVenda.fltBasIpi,
                          fatVenda.fltTotIpi,
                          fatVenda.fltDesAce);

    fatVenda.objNfeComplemento.fltBasFcp := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Text);;
    fatVenda.objNfeComplemento.fltValFCP := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtVlrFCP.Text);
    fatVenda.objNfeComplemento.fltPerFCP := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtPerFCP.Text);
    fatVenda.objNfeComplemento.blnVenPre := fatVenda.blnVendaPresencial;
    fatVenda.objNfeComplemento.strTipFre := fTipoFrete(fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Text);

    If fatVenda.fEhComplementoDeFrete Then
    Begin
      fatVenda.objNfeComplemento.fltTotFre := fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text);
    End;

    pCalculaComplementoIcmsComDiferimento;

    If fatVenda.objNfeComplemento.blnTemItens Then
    Begin
      {*****************************************}
      {* LIMPA MATRIZ DE RESUMO DE ICMS        *}
      {**************************************MV*}
      SetLength(fatVenda.arrAlqIcm, 0);

      {*****************************************}
      {* GERA RESUMO DE ALIQUOTAS DE ICMS      *}
      {**************************************MV*}
      For itemNfeComp In fatVenda.objNfeComplemento.arrItensNFe Do
      Begin
        If Not itemNfeComp.blnItemTemValor Then
          Continue;

        If (Pos(itemNfeComp.strCodFis, CST_SUBSTITUICAO) <= 0) Then
          strComLub := 'T'
        Else
          strComLub := itemNfeComp.strComLub;

        fatVenda.pGeraAlqIcm( strComLub,
                              itemNfeComp.fltAlqIcm,
                              itemNfeComp.fltBasIcm,
                              itemNfeComp.fltValIcm,
                              itemNfeComp.fltValRet + itemNfeComp.fltValIpi,
                              itemNfeComp.fltBasIpi,
                              itemNfeComp.fltValIpi,
                              0.00 );
      End;

    End;

  End;

//  If (edtBasRet.Enabled) Then
  If btnDigImpostosItens.Visible Then
  Begin
    fatVenda.fltTotGer := fatVenda.fltTotGer - fltTotRetOri;
    fatVenda.fltTotGer := fatVenda.fltTotGer + fatVenda.fltTotRet;
  End;

//  If (edtBasIpi.Enabled) Then
  If btnDigImpostosItens.Visible Then
  Begin
    fatVenda.fltTotGer := fatVenda.fltTotGer - fltTotIpiOri;
    fatVenda.fltTotGer := fatVenda.fltTotGer + fatVenda.fltTotIpi;
  End;

  fatVenda.strCodCta := fraDadosFechamentoVendaPlanContasFrame.mskCodCta.Text;

  FreeAndNil(stlMen50p);

  If fInverteuPosicaoDasClassificacoes(strCl1Ant, strCl2Ant) Then
  Begin
    strCl2Ant := strCl1Ant;
    strCl1Ant := fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text;
  End;

  pJogaClassificacoesParaOsItens(strCl1Ant, strCl2Ant, strCl3Ant);

  fatVenda.strEntUrg := IIF(fraDadosFechamentoVendaTransportadoraFrame.chkEntUrg.Checked, 'S', 'N');
  fatVenda.blnEst_Dv := fraDadosFechamentoVendaTransportadoraFrame.chkEst_Dv.Checked;

  fatVenda.blnRetornoPorRecusa := fraDadosFechamentoVendaTransportadoraFrame.chkRetornoPorRecusa.Checked;

  If fatVenda.strClaFis = fatVenda.strClaFi2 Then
    fatVenda.strClaFi2 := '';

  If (fatVenda.strClaFi3 = fatVenda.strClaFis) Or (fatVenda.strClaFi3 = fatVenda.strClaFi2) Then
    fatVenda.strClaFi3 := '';

  If intOpcCfo = 1 then
  Begin
    If (Not fEmptyStr(fatVenda.strClaFi2)) Then
      fatVenda.strDesCl2 := fRetNomGeral('NAT_DESCRI','NAT_CODCFO','NATCFO',fStrToFloat(fatVenda.strClaFi2))
    Else
      fatVenda.strDesCl2 := '';

    If (Not fEmptyStr(fatVenda.strClaFi3)) Then
      fatVenda.strDesCl3 := fRetNomGeral('NAT_DESCRI','NAT_CODCFO','NATCFO',fStrToFloat(fatVenda.strClaFi3))
    Else
      fatVenda.strDesCl3 := '';
  End
  Else
  Begin
    If (Not fEmptyStr(fatVenda.strClaFi2)) Then
      fatVenda.strDesCl2 := fRetNomGeral('CFO_DESCR1','CFO_CODCFO','CADCFO',fStrToFloat(fatVenda.strClaFi2))
    Else
      fatVenda.strDesCl2 := '';

    If (Not fEmptyStr(fatVenda.strClaFi3)) Then
      fatVenda.strDesCl3 := fRetNomGeral('CFO_DESCR1','CFO_CODCFO','CADCFO',fStrToFloat(fatVenda.strClaFi3))
    Else
      fatVenda.strDesCl3 := '';
  End;

  If fEmptyStr(fatVenda.strNumOrc) Then
    fatVenda.blnSetouTipoFreteSugestao := True;
end;

function TfrmFatDadosFiscais.fCriacdsImpostos: TUniClientDataSet;
begin

  Result := TUniClientDataSet.Create(Self);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'BASICM';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VALICM';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'BASRET';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VALRET';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'BASIPI';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VALIPI';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'BASISS';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VALISS';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'BASFCP';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VALFCP';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'BASFCP_ST';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VALFCP_ST';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CST';
    DataType := ftString;
    Size     := 40;
  End;

  Result.CreateDataSet;

  TFloatField(Result.FieldByName('BASICM')).DisplayFormat := '#,##0.00';
  TFloatField(Result.FieldByName('VALICM')).DisplayFormat := '#,##0.00';

  TFloatField(Result.FieldByName('BASRET')).DisplayFormat := '#,##0.00';
  TFloatField(Result.FieldByName('VALRET')).DisplayFormat := '#,##0.00';

  TFloatField(Result.FieldByName('BASIPI')).DisplayFormat := '#,##0.00';
  TFloatField(Result.FieldByName('VALIPI')).DisplayFormat := '#,##0.00';

  TFloatField(Result.FieldByName('BASISS')).DisplayFormat := '#,##0.00';
  TFloatField(Result.FieldByName('VALISS')).DisplayFormat := '#,##0.00';

  TFloatField(Result.FieldByName('BASFCP')).DisplayFormat := '#,##0.00';
  TFloatField(Result.FieldByName('VALFCP')).DisplayFormat := '#,##0.00';

  TFloatField(Result.FieldByName('BASFCP_ST')).DisplayFormat := '#,##0.00';
  TFloatField(Result.FieldByName('VALFCP_ST')).DisplayFormat := '#,##0.00';

end;

class function TfrmFatDadosFiscais.fInformouDespesasAduaneiras(
  var recDespesasAduaneiras: TDespesasAduaneiras;
  blnReadOnly: Boolean): Boolean;
var
  objForm: TfrmDespAduaneiras;
begin
  pCriarFormularios(TfrmDespAduaneiras, objForm);

  try
    objForm.edtDemurrage.Text    := FormatFloat('#,##0.00', recDespesasAduaneiras.fltDemurr);
    objForm.edtTaxa.Text         := FormatFloat('#,##0.00', recDespesasAduaneiras.fltTaxArm);
    objForm.edtDespachante.Text  := FormatFloat('#,##0.00', recDespesasAduaneiras.fltDespac);
    objForm.edtFrete.Text        := FormatFloat('#,##0.00', recDespesasAduaneiras.fltFrete_);
    objForm.edtOutrasDesp.Text   := FormatFloat('#,##0.00', recDespesasAduaneiras.fltOutDes);
    objForm.edtMulta.Text        := FormatFloat('#,##0.00', recDespesasAduaneiras.fltMulAdu);
    objForm.edtFreteInterno.Text := FormatFloat('#,##0.00', recDespesasAduaneiras.fltFreInt);
    objForm.edtF500.Text         := FormatFloat('#,##0.00', recDespesasAduaneiras.fltF_500_);
    objForm.lblTotal.Caption     := 'R$: ' + FormatFloat('#,##0.00', recDespesasAduaneiras.fltTotalD);

    objForm.edtDemurrage.Enabled    := not blnReadOnly;
    objForm.edtTaxa.Enabled         := not blnReadOnly;
    objForm.edtDespachante.Enabled  := not blnReadOnly;
    objForm.edtFrete.Enabled        := not blnReadOnly;
    objForm.edtOutrasDesp.Enabled   := not blnReadOnly;
    objForm.edtMulta.Enabled        := not blnReadOnly;
    objForm.edtFreteInterno.Enabled := not blnReadOnly;
    objForm.edtF500.Enabled         := not blnReadOnly;

    objForm.ShowModal;

    Result   := (objForm.ModalResult = mrOk);

    if Result then
    begin
      recDespesasAduaneiras.fltDemurr := fStrToFloat(objForm.edtDemurrage.Text, 0);
      recDespesasAduaneiras.fltTaxArm := fStrToFloat(objForm.edtTaxa.Text, 0);
      recDespesasAduaneiras.fltDespac := fStrToFloat(objForm.edtDespachante.Text, 0);
      recDespesasAduaneiras.fltFrete_ := fStrToFloat(objForm.edtFrete.Text, 0);
      recDespesasAduaneiras.fltOutDes := fStrToFloat(objForm.edtOutrasDesp.Text, 0);
      recDespesasAduaneiras.fltMulAdu := fStrToFloat(objForm.edtMulta.Text, 0);
      recDespesasAduaneiras.fltFreInt := fStrToFloat(objForm.edtFreteInterno.Text, 0);
      recDespesasAduaneiras.fltF_500_ := fStrToFloat(objForm.edtF500.Text, 0);
      recDespesasAduaneiras.fltTotalD := fStrToFloat(Copy(objForm.lblTotal.Caption, 5, Length(objForm.lblTotal.Caption)), 0);
    end;
  finally
    pFreeAndNil(objForm);
  end;
end;

function TfrmFatDadosFiscais.fInverteuPosicaoDasClassificacoes(const strClaAnt1, strClaAnt2 : String): Boolean;
begin
  Result := False;

  If (Pos(fatVenda.strOpcDoc, OPC_OUTRAS_ENTRADAS + OPC_OUTRAS_SAIDAS) <= 0) Then
    Exit;

  Result := (fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text <> strClaAnt1) And
            (fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text = strClaAnt2);
end;

function TfrmFatDadosFiscais.fLiberaNaoGravarContasPagar: Boolean;
begin
  objLiberacao.Clear;
  objLiberacao.strDirAce    := 'OENCTP';
  objLiberacao.strSenLib    := fCfgSis('SOECTP');
  objLiberacao.strMsgSen    := 'Não grava contas a pagar';
  objLiberacao.strCodOpe    := strLoginUsuarioLogado;
  objLiberacao.objMsgLibera.pAddTexto('Permite não gravar no contas a pagar.');

  Result := objLiberacao.fLibera;
end;

function TfrmFatDadosFiscais.fMsgDevObrigatoria: Boolean;
begin
  Result := False;
  If (fCfgSis('OBMSDV') = 'S') And (fatVenda.strOpcDoc = 'DV') Then
  Begin
    If (fraDadosFechamentoVendaMSGFatFrame.edtMens01.Text = '') Or (fraDadosFechamentoVendaMSGFatFrame.edtMens02.Text = '') Then
    Begin
      fMensagem('ATENÇÃO!', 'Mensagem obrigatória!', ['&OK']);
      If (fraDadosFechamentoVendaMSGFatFrame.edtMens01.Text = '') Then
      Begin
        pSetFocus(fraDadosFechamentoVendaMSGFatFrame.edtMens01);
      End
      Else
      Begin
        pSetFocus(fraDadosFechamentoVendaMSGFatFrame.edtMens02);
      End;
      Result := True;
    End;
  End;
end;

function TfrmFatDadosFiscais.fNotaEspecialAbreviacaoIpi: Boolean;
begin
  Result := (fCfgSis('UTIABI', varBoolean)) And (fatVenda.strOpcDoc = 'NE');
end;

function TfrmFatDadosFiscais.fNotaEspecialDevolucao: Boolean;
begin
  Result := False;

  If not (fatVenda.strOpcDoc = 'NE') Then
    Exit;

  If not (Pos(fatVenda.strClaFis, '1202_1411_') > 0) Then
    Exit;

  Result := True;
end;

function TfrmFatDadosFiscais.fNotaEspecialCfopOutrasSaidas: Boolean;
begin
  Result := False;

  If not (fatVenda.strOpcDoc = 'NE') Then
    Exit;

  If not fEhClassificacaoDeOutrasSaidas(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text) Then
    Exit;

  Result := True;
end;

procedure TfrmFatDadosFiscais.pMostraBtnEdtInfDocExp(blnMostra: Boolean);
begin
  If (blnMostra) And (Not fraDadosFechamentoVendaClaFisFrame.btnNotExp.Visible) Then
  Begin
    fraDadosFechamentoVendaClaFisFrame.btnNotExp.Visible := True;
    fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Width := (fraDadosFechamentoVendaClaFisFrame.btnNotExp.Left - fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Left);
  End
  Else If (Not blnMostra) And (fraDadosFechamentoVendaClaFisFrame.btnNotExp.Visible) Then
  Begin
    fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Width := ((fraDadosFechamentoVendaClaFisFrame.btnNotExp.Left - fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Left) + fraDadosFechamentoVendaClaFisFrame.btnNotExp.Width);
    fraDadosFechamentoVendaClaFisFrame.btnNotExp.Visible := False;
  End;
end;

procedure TfrmFatDadosFiscais.pAbreTelaDigPesoProduto;
Var
  objPesIte: TPesIte;
begin

  Try

    objPesIte := TPesIte.Create(Self);
    objPesIte.fatVenda := fatVenda;

    objPesIte.blnPesBruEna := blnPesBruEna;
    objPesIte.blnPesLiqEna := blnPesLiqEna;
    objPesIte.blnPesBruRea := blnPesBruRea;
    objPesIte.blnPesLiqRea := blnPesLiqRea;
    objPesIte.blnPesBruTab := blnPesBruTab;
    objPesIte.blnPesLiqTab := blnPesLiqTab;

    objPesIte.pAbreTelaDigPesoProduto(fraDadosFechamentoVendaTransportadoraFrame.edtPesBru, fraDadosFechamentoVendaTransportadoraFrame.edtPesLiq);

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmFatDadosFiscais.pAbreTelaDigPesoProduto]');
  End;

  FreeAndNil(objPesIte);

end;

function TfrmFatDadosFiscais.fHabilitaDigitarTotalGeralParaNotaDeImportacao: Boolean;
Begin
  Result := blnNotImp And fCfgSis('NFITOT', varBoolean);
End;

procedure TfrmFatDadosFiscais.pHabilitaDigitarTotalGeralParaNotaDeImportacao;
Begin
  fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.ReadOnly    := True;
  fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.TabStop     := False;
  fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.Color       := $00FFDFB8;
  fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.NormalColor := $00FFDFB8;
  fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.FocusColor  := $00FFDFB8;

  If fHabilitaDigitarTotalGeralParaNotaDeImportacao Then
  Begin
    fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.ReadOnly    := False;
    fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.TabStop     := True;
    fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.Color       := clWindow;
    fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.NormalColor := clWindow;
    fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.FocusColor  := clInfoBk;
  End;
End;

procedure TfrmFatDadosFiscais.pSetarHintDescontoEspecialComDesoneracao(const AExibeHint : Boolean);
  Var
    strTextoHint : String;
begin
  fraDadosFechamentoVendaTipoFaturamentoFrame.edtDesEsp.ShowHint := AExibeHint;
  fraDadosFechamentoVendaTipoFaturamentoFrame.imgAlerta.ShowHint := AExibeHint;
  If (AExibeHint) Then
  Begin
    strTextoHint := 'Desconto Comercial: ' + FormatFloat('#,##0.00', fatVenda.fltDesComercialZFM) + sLineBreak +
                    'Desoneração: ' + FormatFloat('#,##0.00', fatVenda.fltIcmOrg);
    fraDadosFechamentoVendaTipoFaturamentoFrame.edtDesEsp.Hint := strTextoHint;
    fraDadosFechamentoVendaTipoFaturamentoFrame.imgAlerta.Hint := strTextoHint;
  End
  Else
  Begin
    fraDadosFechamentoVendaTipoFaturamentoFrame.edtDesEsp.Hint := '';
    fraDadosFechamentoVendaTipoFaturamentoFrame.imgAlerta.Hint := '';
  End;
end;

function TfrmFatDadosFiscais.fEhDevolucao: Boolean;
begin
  Result := fatVenda.fEhDevolucaoEspelhoOuParaFornecedor;

  If not Result Then
    Exit;

  If fatVenda.blnClienteZonaFrancaComDescontoEspecial Then
    Result := False;
end;

procedure TfrmFatDadosFiscais.pAtualizaRodape;
  Var
    fltTotGer: Double;
begin
  If blnNotImp Then
    pHabilitaDigitarTotalGeralParaNotaDeImportacao;

  If fHabilitaDigitarTotalGeralParaNotaDeImportacao And (intSemaforoConfirma = 0) Then
    Exit;

  {****************************************}
  {* CALCULA TOTAL GERAL                  *}
  {*************************************JB*}
  fltTotGer := fatVenda.fltTotPro          +
               fatVenda.fltTotSer          +
               fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtValIpi.Text) +
               fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtValRet.Text) +
               fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtValFCPST.Text) +
               fatVenda.fltTotCBS + fatVenda.fltTotIBS + fatVenda.fltTotIS +
               fStrToFloat(fraDadosFechamentoVendaBombeamentoFrame.edtTotBom.Text) +
               IIF(fSomaDespesasAcessorias, fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text), 0) +
               fatVenda.fltValIpiZeradoFaturaConsignacao +
               fatVenda.fltValSTZeradoFaturaConsignacao  +
               fatVenda.fltValFcpSTZeradoFaturaConsignacao +
               fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text) -
               fatVenda.fltDesEsp -
               IIF(fEhDevolucao, 0.00, fatVenda.fltVrdIcm);

  {***********************************************************************}
  {* NO TOTAL DA NOTA DE IMPORTACAO TAMBEM ENTRAM                        *}
  {* O VALOR DO ICMS, IMP. IMPORTACAO, TAXA SISCOMEX, PIS/PASEP E COFINS *}
  {*******************************************************************JC**}
  If blnNotImp Then
  Begin
    fltTotGer := 0;
    fltTotGer := fltTotGer + fatVenda.fltTotSer;
    fltTotGer := fltTotGer + IIF(fSomaDespesasAcessorias, fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text), 0);

    If tcvcVR_PRODUTOS  in PerfilDespachanteAduaneiro.ComposicaoValorContabil then
      fltTotGer := fltTotGer + fatVenda.fltTotPro;

    If tcvcFRETE  in PerfilDespachanteAduaneiro.ComposicaoValorContabil then
      fltTotGer := fltTotGer + fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text);

    If tcvcSEGURO in PerfilDespachanteAduaneiro.ComposicaoValorContabil then
      fltTotGer := fltTotGer + fatVenda.fltValSeg;

    If tcvcVR_ICMS in PerfilDespachanteAduaneiro.ComposicaoValorContabil then
      fltTotGer := fltTotGer + fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtValIcm.Text);

    If tcvcPIS in PerfilDespachanteAduaneiro.ComposicaoValorContabil then
      fltTotGer := fltTotGer + fatVenda.fltTotPis;

    If tcvcCOFINS in PerfilDespachanteAduaneiro.ComposicaoValorContabil then
      fltTotGer := fltTotGer + fatVenda.fltTotCof;

    If tcvcIPI in PerfilDespachanteAduaneiro.ComposicaoValorContabil then
      fltTotGer := fltTotGer + fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtValIpi.Text);

    If tcvcII in PerfilDespachanteAduaneiro.ComposicaoValorContabil then
      fltTotGer := fltTotGer + fatVenda.fltImpImp;

    If tcvcSISCOMEX in PerfilDespachanteAduaneiro.ComposicaoValorContabil then
      fltTotGer := fltTotGer + fatVenda.fltImpTax;

    If tcvcAFRMM in PerfilDespachanteAduaneiro.ComposicaoValorContabil then
      fltTotGer := fltTotGer + fatVenda.fltTotRmm;

    If tcvcDESPESAS_ADUANEIRAS in PerfilDespachanteAduaneiro.ComposicaoValorContabil then
      fltTotGer := fltTotGer + fatVenda.fltDesAdu;

    If tcvcIOF in PerfilDespachanteAduaneiro.ComposicaoValorContabil then
      fltTotGer := fltTotGer + fatVenda.fltValIof;

    fltTotGer := fltTotGer - fatVenda.fltDesEsp;


    If fFormataFloat(abs(fFormataFloat(fltTotGer, 2) - fFormataFloat(fatVenda.fltTot_DI, 2)), 2) <= 0.05 Then
    Begin
      fltTotGer := fltTotGer - fFormataFloat(fFormataFloat(fltTotGer, 2) - fFormataFloat(fatVenda.fltTot_DI, 2), 2);
    End;

    fatVenda.fltTotGer := fltTotGer
  End;

  {***********************************************************************}
  {* QUANDO tncRestIcmsStEstoque, SERÁ INFORMADO MANUAMENTE              *}
  {*******************************************************************NC**}
  If (fatVenda.objNfeComplemento.tncTipoNota in [tncRestIcmsStEstoque, tncEstornoDeCredito]) And (Not fEmptyStr(fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.Text)) Then
  Begin
    fltTotGer := fStrToFloat(fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.Text);
    fatVenda.fltTotGer := fltTotGer;
  End;

  // O PROBLEMA DA SOMA É SOMENTE VISUAL, NA NOTA E NO LIVRO FISCAL OS VALORES ESTÃO CORRETO NA NOTA DE COMPLEMENTO
  if fatVenda.objNfeComplemento.TotalItens.fltValorCom > 0 then
  begin
    fltTotGer := fltTotGer + fatVenda.objNfeComplemento.TotalItens.fltValorCom;
  end;

  fraDadosFechamentoVendaTipoFaturamentoFrame.edtTipFat.Text := fatVenda.strTipFat;
  fraDadosFechamentoVendaTipoFaturamentoFrame.edtPorDes.Text := FormatFloat('#,##0.00', fatVenda.fltPorDes);
  fraDadosFechamentoVendaTipoFaturamentoFrame.edtDesEsp.Text := FormatFloat('#,##0.00', fatVenda.fltDesEsp);
  fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.Text := FormatFloat('#,##0.00', fltTotGer); //Total Geral Local
  fraDadosFechamentoVendaTipoFaturamentoFrame.imgAlerta.Visible := (fatVenda.fPermiteDescontoComercialEmOperacaoZonaFrancaComDescontoDeIcms);
  pSetarHintDescontoEspecialComDesoneracao(fraDadosFechamentoVendaTipoFaturamentoFrame.imgAlerta.Visible);

end;

function TfrmFatDadosFiscais.fEhComplementoIcmsComDiferimento: Boolean;
begin
  Result := False;

  If not (fatVenda.strOpcDoc = 'NC') Then
    Exit;

  If not (fatVenda.objNfeComplemento.tncTipoNota = tncComplementoICMS) Then
    Exit;

  If not (RightStr(fraDadosFechamentoVendaTotaisFrame.edtCodSit.Text, 2) = '51') Then
    Exit;

  Result := True;
end;

procedure TfrmFatDadosFiscais.pAtualizaVlrIcm;
begin
  If (fatVenda.strOpcDoc = 'NC') And (fraDadosFechamentoVendaTotaisFrame.edtAlqIcm.Visible) And
     (fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Text) > 0) And (fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtAlqIcm.Text) > 0)  Then
  Begin
    fraDadosFechamentoVendaTotaisFrame.edtValIcm.Text := FloatToStrF((fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Text) * fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtAlqIcm.Text)) / 100, ffNumber, 12, 2);
  End;
  If (fatVenda.strOpcDoc = 'NC') Then
  Begin
    fraDadosFechamentoVendaTotaisFrame.edtCodSit.Text := fSugestaoCSTNotaComplem;
    fraDadosFechamentoVendaTotaisFrame.edtCstIpi.Text := '49';
    fraDadosFechamentoVendaTotaisFrame.edtCstPis.Text := '99';
    fraDadosFechamentoVendaTotaisFrame.edtCstCof.Text := '99';
  End;

  pCalculaComplementoIcmsComDiferimento;
end;

procedure TfrmFatDadosFiscais.pCalculaComplementoIcmsComDiferimento;
var
  fltBasIcm: Double;
  fltPerIcm: Double;
  fltIcmsOp: Double;
  fltValIcm: Double;
  fltBasDif: Double;
  fltPerDif: Double;
  fltIcmDif: Double;
begin
  If not fEhComplementoIcmsComDiferimento Then
    Exit;

  If fatVenda.objNfeComplemento.blnTemItens Then
    Exit;

  fatVenda.objNfeComplemento.fltPerIcm := 0;
  fatVenda.objNfeComplemento.fltIcmsOp := 0;
  fatVenda.objNfeComplemento.fltPerDif := 0;
  fatVenda.objNfeComplemento.fltIcmDif := 0;
  fatVenda.objNfeComplemento.fltValIcm := 0;

  If RightStr(fraDadosFechamentoVendaTotaisFrame.edtCodSit.Text, 2) = '51' Then
  Begin
    fltBasIcm := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Text);
    fltPerIcm := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtAlqIcm.Text);
    fltPerDif := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtPerDif.Text);

    fltIcmsOp := fFormataFloat(fltBasIcm * (fltPerIcm / 100), 2);
    fltBasDif := fFormataFloat(fltBasIcm * (fltPerDif / 100), 2);
    fltBasDif := fFormataFloat(fltBasIcm - fltBasDif, 2);
    fltValIcm := fFormataFloat(fltBasDif * (fltPerIcm / 100), 2);
    fltIcmDif := fFormataFloat(fltIcmsOp - fltValIcm, 2);

    fatVenda.objNfeComplemento.fltPerIcm := fltPerIcm;
    fatVenda.objNfeComplemento.fltIcmsOp := fltIcmsOp;
    fatVenda.objNfeComplemento.fltPerDif := fltPerDif;
    fatVenda.objNfeComplemento.fltIcmDif := fltIcmDif;
    fatVenda.objNfeComplemento.fltValIcm := fltValIcm;

    fraDadosFechamentoVendaTotaisFrame.edtValIcm.Text := FloatToStrF(fltValIcm, ffNumber, 12, 2);
    fraDadosFechamentoVendaTotaisFrame.edtValDif.Text := FloatToStrF(fltIcmDif, ffNumber, 12, 2);
  End;

end;

procedure TfrmFatDadosFiscais.pAtualizaVlrFCP;
begin
  If (Pos(fatVenda.strOpcDoc,'NC_OF_') > 0) And (fraDadosFechamentoVendaTotaisFrame.edtPerFCP.Visible) And
     (fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Text) > 0) And (fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtPerFCP.Text) > 0)  Then
  Begin
    fraDadosFechamentoVendaTotaisFrame.edtVlrFCP.Text := FloatToStrF((fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Text) * fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtPerFCP.Text)) / 100, ffNumber, 12, 2);
  End;
end;

procedure TfrmFatDadosFiscais.pAtualizaVlrFCPST;
var
  fltBasFcp   :Double;
  fltAlqFcpST :Double;
  fltBasFcpST :Double;
begin

  If not (Pos(fatVenda.strOpcDoc,'NC_OF_') > 0) Then
    Exit;

  If not fraDadosFechamentoVendaTotaisFrame.edtAlqFCPST.Visible Then
    Exit;

  If not (fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasFCPST.Text) > 0) Then
    Exit;

  If not (fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtAlqFCPST.Text) > 0) Then
    Exit;

  fltBasFcp   := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Text);
  fltAlqFcpST := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtAlqFCPST.Text);
  fltBasFcpST := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasFCPST.Text);

  If fatVenda.fNotaDeComplementoCalculaFCPComReducaoBaseIcmsST Then
    fltBasFcpST := fltBasFcpST - fltBasFcp;

  fraDadosFechamentoVendaTotaisFrame.edtValFCPST.Text := FloatToStrF((fltBasFcpST * fltAlqFcpST) / 100, ffNumber, 12, 2);
end;

procedure TfrmFatDadosFiscais.edtQtdBomExit(Sender: TObject);
begin
  inherited;
  pCalculaTotalGeral;
end;

procedure TfrmFatDadosFiscais.edtQtdTraKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If CharInSet(Key, [',', '.']) Then
  Begin
    Key := #0;
  End;
end;

procedure TfrmFatDadosFiscais.pEditaBases;
  Var
    blnEdiBas: Boolean;
begin
  {*****************************************}
  {* CALCULA QUANTIDADE DE CODIGO FISCAL   *}
  {**************************************MV*}
  fatVenda.pCalculaQtdCodFis;

  {*****************************************}
  {* DEFINE EDIÇÃO DE VALORES FISCAIS      *}
  {**************************************MV*}
  blnEdiBas := False;

  If Pos(fatVenda.strOpcDoc, 'NC_NP_') > 0 Then
    blnEdiBas := True
  Else If (blnForcaEdiBas) Then
    blnEdiBas := True
  Else If (fCfgSis('DIGFIS', varBoolean)) Then
    blnEdiBas := True
  Else
  Begin

    If (Pos(fatVenda.strOpcDoc, 'OU_OV_OE_EF_') > 0) Or
       (Pos(fatVenda.strClaFis, VS_strClaVen) <= 0) Then
    Begin
      blnEdiBas := True;
    End;

  End;

  //PRESTCON
  If (Pos(fatVenda.strOpcDoc, 'VN_CN_CP_') > 0) And
     fatVenda.fEhVendaConcreto And MatchStr(fCfgSis('TPNFCR'),[PRESTCON,SECOL,J_A_MASSA_CONCRETO]) Then
  Begin
    blnEdiBas := False;
  End;

  blnEdiBas := blnEdiBas And (Not fatVenda.blnBaiEntFut);

  If fatVenda.strOpcDoc = 'NC' Then
    btnDigImpostosItens.Visible := False
  Else
  Begin
    If Not fraDadosFechamentoVendaTransportadoraFrame.chkEst_Dv.Checked Then
      btnDigImpostosItens.Visible := blnEdiBas
    Else
      btnDigImpostosItens.Visible := False;
  End;

  pAjustarAlturaFrameTotais;
end;

procedure TfrmFatDadosFiscais.pAtualizaImpostosClassificacaoFiscal;
  Var
    intContador: Integer;
begin
  inherited;

  If (fatVenda.strOpcDoc = 'OF') And (Not blnEspelhoEnvioParaOFornecedor) Then
    fatVenda.pAjustaCSTSimples;

  {**************************************************************
   * COMENTADO DIA 07/08/2014                                   *
   * REMESSA PARA DEPÓSITO ESTA SETANDO 041 ONDE NÃO DEVERIA;   *
   * CLIENTE: ELRON - REQUISITO: 22336                          *
   ***********************************************************RN*
  If (Pos(RightStr(edtClaFis.Text,3),'905_906_') > 0) Then
  Begin
    For intContador := 0 To Length(fatVenda.arrMatItens)-1 Do
    Begin
      If fEmptyStr(fatVenda.arrMatItens[intContador].strFisAnt) Then
        fatVenda.arrMatItens[intContador].strFisAnt := fatVenda.arrMatItens[intContador].strCodFis;

      fatVenda.arrMatItens[intContador].strCodFis := '041';
      fatVenda.arrMatItens[intContador].strCodSit := '041';
    end;
  End
  Else }

  {**************************************************************
   * COMENTADO DIA 26/03/2018 REQ.: 99648                       *
   ***********************************************************VA*
  //5927 - Lançamento efetuado a título de baixa de estoque decorrente de perda, roubo ou deterioração
  If edtClaFis.Text = '5927' Then
  Begin
    For intContador := 0 To Length(fatVenda.arrMatItens)-1 Do
    Begin
      If fEmptyStr(fatVenda.arrMatItens[intContador].strFisAnt) Then
        fatVenda.arrMatItens[intContador].strFisAnt := fatVenda.arrMatItens[intContador].strCodFis;

      fatVenda.arrMatItens[intContador].strCodFis := '090';
      fatVenda.arrMatItens[intContador].strCodSit := '090';
    End;
  End
  Else}
  If fatVenda.fEhNotaEspecialComplementarDeIPI Then
  Begin
    For intContador := 0 To Length(fatVenda.arrMatItens)-1 Do
    Begin
      fatVenda.arrMatItens[intContador].strCodFis := '090';
      fatVenda.arrMatItens[intContador].strCodSit := '090';
    End;
  End
  Else
  If (Pos(RightStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text,3),'915_916_') > 0) Then
  Begin
    For intContador := 0 To Length(fatVenda.arrMatItens)-1 Do
    Begin
      If fEmptyStr(fatVenda.arrMatItens[intContador].strFisAnt) Then
        fatVenda.arrMatItens[intContador].strFisAnt := fatVenda.arrMatItens[intContador].strCodFis;

      fatVenda.arrMatItens[intContador].strCodFis := '041';
      fatVenda.arrMatItens[intContador].strCodSit := '041';

      fatVenda.pZerarDadosIcmsMatrizItens(false, intContador);
      fatVenda.pZerarDadosIpiMatrizItens(True, intContador);
      fatVenda.pZerarDadosStMatrizItens(intContador);

      fatVenda.arrMatItens[intContador].recDifalFCP.fltBasFcp := 0;
      fatVenda.arrMatItens[intContador].recDifalFCP.fltValFcp := 0;
    End;

    fatVenda.fltBasIcm := 0;
    fatVenda.fltTotIcm := 0;
    fatVenda.fltBasIpi := 0;
    fatVenda.fltTotIpi := 0;
    fatVenda.fltBasRet := 0;
    fatVenda.fltTotRet := 0;

    fatVenda.fltBasFcpST := 0;
    fatVenda.fltTotFcpST := 0;

    fatVenda.pAtualizaTemporariaItens(cdsVenda);
    pAtualizaEditsImpostos;
    pAtualizaRodape;
  End
  Else If (fatVenda.fZerarIcmsNotaTransferenciaEstadosEspecificos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text)) Then
  Begin
    fatVenda.pZerarIcmsNotaTransferenciaEstadosEspecificos;

    pAtualizaEditsImpostos;
    pAtualizaRodape;
  End;

  If fatVenda.blnEspelhoDevolucaoClienteFatDadosFiscais Then
  Begin
    fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text := fatVenda.strClaFis;
    fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text := fatVenda.strClaFi2;
    fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text := fatVenda.strClaFi3;
    pCarregaNatOperacao(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text);
  End;

end;

procedure TfrmFatDadosFiscais.pAtualizaAlqIcm;
begin
  If (fatVenda.strOpcDoc = 'NC') And (fraDadosFechamentoVendaTotaisFrame.edtAlqIcm.Visible) And
     (fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Text) > 0) And (fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtValIcm.Text) > 0) Then
  Begin
    fraDadosFechamentoVendaTotaisFrame.edtAlqIcm.Text := FloatToStrF(((fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtValIcm.Text) / fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Text)) * 100), ffNumber, 12, 2);
  End;
  If (fatVenda.strOpcDoc = 'NC') Then
  Begin
    fraDadosFechamentoVendaTotaisFrame.edtCodSit.Text := fSugestaoCSTNotaComplem;
    fraDadosFechamentoVendaTotaisFrame.edtCstIpi.Text := '49';
    fraDadosFechamentoVendaTotaisFrame.edtCstPis.Text := '99';
    fraDadosFechamentoVendaTotaisFrame.edtCstCof.Text := '99';
  End;
end;

procedure TfrmFatDadosFiscais.pAtualizaAlqFCP;
begin
  If (Pos(fatVenda.strOpcDoc,'NC_OF_OE_EF_') > 0) And (fraDadosFechamentoVendaTotaisFrame.edtPerFCP.Visible) And
     (fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Text) > 0) And (fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtVlrFCP.Text) > 0) Then
  Begin
    fraDadosFechamentoVendaTotaisFrame.edtPerFCP.Text := FloatToStrF(((fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtVlrFCP.Text) / fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Text)) * 100), ffNumber, 12, 2);
  End;
end;

procedure TfrmFatDadosFiscais.pAtualizaAlqFCPST;
var
  fltBasFcp  : Double;
  fltBasFcpST: Double;
  fltValFcpST: Double;
begin

  If not (Pos(fatVenda.strOpcDoc,'NC_OF_OE_EF_') > 0) Then
    Exit;

  If not (fraDadosFechamentoVendaTotaisFrame.edtAlqFCPST.Visible) Then
    Exit;

  If not (fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasFCPST.Text) > 0) Then
    Exit;

  If not (fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtValFCPST.Text) > 0) Then
    Exit;

  fltBasFcp   := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Text);
  fltBasFcpST := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasFCPST.Text);
  fltValFcpST := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtValFCPST.Text);

  If fatVenda.fNotaDeComplementoCalculaFCPComReducaoBaseIcmsST Then
    fltBasFcpST := fltBasFcpST - fltBasFcp;

  fraDadosFechamentoVendaTotaisFrame.edtAlqFCPST.Text := FloatToStrF(((fltValFcpST / fltBasFcpST) * 100), ffNumber, 12, 2);
end;

procedure TfrmFatDadosFiscais.pAjustarAlturaFrameTotais;
  Var
    intVariacao: Integer;
begin
  intVariacao := fraDadosFechamentoVendaTotaisFrame.fAjustarVisibilidade(fSomarNovosImpostosDaReformaAoValorContabil);

  If (intVariacao = 0) Then
    Exit;

  pnlResImp.Height  := pnlResImp.Height  + intVariacao;
  Self.ClientHeight := Self.ClientHeight + intVariacao;
end;

procedure TfrmFatDadosFiscais.pAtualizaEditsImpostos;
begin
  fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Text   := FormatFloat('#,##0.00', fatVenda.fltBasIcm);
  fraDadosFechamentoVendaTotaisFrame.edtValIcm.Text   := FormatFloat('#,##0.00', fatVenda.fltTotIcm);
  fraDadosFechamentoVendaTotaisFrame.edtBasIpi.Text   := FormatFloat('#,##0.00', fatVenda.fltBasIpi);
  fraDadosFechamentoVendaTotaisFrame.edtValIpi.Text   := FormatFloat('#,##0.00', fatVenda.fltTotIpi);
  fraDadosFechamentoVendaTotaisFrame.edtBasRet.Text   := FormatFloat('#,##0.00', fatVenda.fltBasRet);
  fraDadosFechamentoVendaTotaisFrame.edtValRet.Text   := FormatFloat('#,##0.00', fatVenda.fltTotRet);
  fraDadosFechamentoVendaTotaisFrame.edtBasFCPST.Text := FormatFloat('#,##0.00', fatVenda.fltBasFcpST);
  fraDadosFechamentoVendaTotaisFrame.edtAlqFCPST.Text := FormatFloat('#,##0.00', fatVenda.fltAlqFcpST);
  fraDadosFechamentoVendaTotaisFrame.edtValFCPST.Text := FormatFloat('#,##0.00', fatVenda.fltTotFcpST);
  fraDadosFechamentoVendaTotaisFrame.edtBasIss.Text   := FormatFloat('#,##0.00', fatVenda.fltBasIss);
  fraDadosFechamentoVendaTotaisFrame.edtValIss.Text   := FormatFloat('#,##0.00', fatVenda.fltValIss);
  fraDadosFechamentoVendaTotaisFrame.edtBaseCBS.Text  := FormatFloat('#,##0.00', fatVenda.fltTotBasCBS);
  fraDadosFechamentoVendaTotaisFrame.edtValorCBS.Text := FormatFloat('#,##0.00', fatVenda.fltTotCBS);
  fraDadosFechamentoVendaTotaisFrame.edtBaseIBS.Text  := FormatFloat('#,##0.00', fatVenda.fltTotBasIBS);
  fraDadosFechamentoVendaTotaisFrame.edtValorIBS.Text := FormatFloat('#,##0.00', fatVenda.fltTotIBS);
  fraDadosFechamentoVendaTotaisFrame.edtBaseIS.Text   := FormatFloat('#,##0.00', fatVenda.fltTotBasIS);
  fraDadosFechamentoVendaTotaisFrame.edtValorIS.Text  := FormatFloat('#,##0.00', fatVenda.fltTotIS);

  With fatVenda.objNfeComplemento, TotalItens Do
  Begin
    If (fatVenda.strOpcDoc = 'NC') And blnTemItens Then
    Begin
      fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Text  := FormatFloat('#,##0.00', fltBaseIcms );
      fraDadosFechamentoVendaTotaisFrame.edtValIcm.Text  := FormatFloat('#,##0.00', fltValorIcms);
      fraDadosFechamentoVendaTotaisFrame.edtBasIpi.Text  := FormatFloat('#,##0.00', fltBaseIPI  );
      fraDadosFechamentoVendaTotaisFrame.edtValIpi.Text  := FormatFloat('#,##0.00', fltValorIPI );
      fraDadosFechamentoVendaTotaisFrame.edtBasRet.Text  := FormatFloat('#,##0.00', fltBaseST   );
      fraDadosFechamentoVendaTotaisFrame.edtValRet.Text  := FormatFloat('#,##0.00', fltValorST  );
      fraDadosFechamentoVendaTotaisFrame.edtValDif.Text  := FormatFloat('#,##0.00', fltIcmDif   );
      fraDadosFechamentoVendaTotaisFrame.edtBasFCPST.Text  := FormatFloat('#,##0.00', fltBasFcpST);
      fraDadosFechamentoVendaTotaisFrame.edtValFCPST.Text  := FormatFloat('#,##0.00', fltValFcpST);
    End;
  End;

  pAtualizaAlqFCPST;

end;

procedure TfrmFatDadosFiscais.pAtualizaMatItens(strClaNov, strClaVel, strClaDef: String);
  Var
    intCont: Integer;
begin

  For intCont := 0 To Length(fatVenda.arrMatItens) -1 Do
  Begin
    If (fatVenda.arrMatItens[intCont].strClaFis = strClaVel) Or blnNotImp Or fVendaProducao(fatVenda.strOpcDoc, strClaNov) Or
       (Pos(RightStr(strClaNov, 3),'915_916_927_') > 0)  Then
      fatVenda.arrMatItens[intCont].strClaFis := IIF(fEmptyStr(strClaNov), strClaDef, strClaNov);
  End;

end;

procedure TfrmFatDadosFiscais.mskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraDadosFechamentoVendaPlanContasFrame.mskCodCta, fraDadosFechamentoVendaPlanContasFrame.edtDesCta, Nil, Key, arrCentroCusto) Then
    if fValidaCampos(fraDadosFechamentoVendaPlanContasFrame.mskCodCta) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmFatDadosFiscais.pCarregaCentroCusto;
begin
  fraDadosFechamentoVendaPlanContasFrame.mskCodCta.Text := IIF(fEmptyStr(fraDadosFechamentoVendaPlanContasFrame.mskCodCta.Text),fraDadosFechamentoVendaPlanContasFrame.mskCodCta.Text,fGetPlanoDeContas(fraDadosFechamentoVendaPlanContasFrame.mskCodCta.Text));

  pPesquisaCadCta(qryConCta, qryConCta, fraDadosFechamentoVendaPlanContasFrame.mskCodCta.Text);
  With qryConCta Do
  Begin
    fraDadosFechamentoVendaPlanContasFrame.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmFatDadosFiscais.chkEst_DvClick(Sender: TObject);
begin
  If (fraDadosFechamentoVendaTransportadoraFrame.chkEst_Dv.Checked) And (Pos(fatVenda.strOpcDoc, 'DV_EF_OE_') > 0) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.strDirAce    := 'EST_DV';
    objLiberacao.strSenLib    := fCfgSis('EST_DV');
    objLiberacao.strMsgSen    := 'Gerar estorno de Nota Fiscal não cancelada no prazo (Devolução)';
    objLiberacao.strCodOpe    := strLoginUsuarioLogado;
    objLiberacao.objMsgLibera.pAddTexto('Gerar estorno de Nota Fiscal não cancelada no prazo (Devolução)');

    fraDadosFechamentoVendaTransportadoraFrame.chkEst_Dv.Checked := objLiberacao.fLibera;
  End
  Else
    fraDadosFechamentoVendaTransportadoraFrame.chkEst_Dv.Checked := False;

  fatVenda.blnEst_Dv := fraDadosFechamentoVendaTransportadoraFrame.chkEst_Dv.Checked;
end;

procedure TfrmFatDadosFiscais.chkTaxMinClick(Sender: TObject);
begin
  If fraDadosFechamentoVendaBombeamentoFrame.chkTaxMin.Checked Then
  Begin
    fraDadosFechamentoVendaBombeamentoFrame.lblTotalBombeamento.Caption := 'Taxa Mínima de Bombeamento (Concreto):';
    fraDadosFechamentoVendaBombeamentoFrame.lblTotalBombeamento.Left    := fraDadosFechamentoVendaBombeamentoFrame.lblPrecoBombeamento.Left;
    fraDadosFechamentoVendaBombeamentoFrame.edtTotBom.Left     := 391;
    fraDadosFechamentoVendaBombeamentoFrame.edtTotBom.ReadOnly := False;
    fraDadosFechamentoVendaBombeamentoFrame.edtTotBom.TabStop  := True;
    fraDadosFechamentoVendaBombeamentoFrame.lblPrecoBombeamento.Visible := False;
    fraDadosFechamentoVendaBombeamentoFrame.edtPrcBom.Visible := False;

    If Assigned(fatVenda) Then
      fatVenda.tbIteBom         := tbTaxaMinima;
  End
  Else
  Begin
    fraDadosFechamentoVendaBombeamentoFrame.lblTotalBombeamento.Caption := 'Valor Total Bombeamento (Concreto):';
    fraDadosFechamentoVendaBombeamentoFrame.lblTotalBombeamento.Left    := 390;
    fraDadosFechamentoVendaBombeamentoFrame.edtTotBom.Left     := 571;
    fraDadosFechamentoVendaBombeamentoFrame.edtTotBom.ReadOnly := True;
    fraDadosFechamentoVendaBombeamentoFrame.edtTotBom.TabStop  := False;
    fraDadosFechamentoVendaBombeamentoFrame.lblPrecoBombeamento.Visible := True;
    fraDadosFechamentoVendaBombeamentoFrame.edtPrcBom.Visible := True;

    If Assigned(fatVenda) Then
      fatVenda.tbIteBom         := tbItemBombeamento;
  End;
end;

procedure TfrmFatDadosFiscais.ckbGravaCTRClick(Sender: TObject);
begin
  inherited;
  fatVenda.blnCtrOutSai := fraDadosFechamentoVendaGravarContasFrame.ckbGravaCTR.Checked;
end;

procedure TfrmFatDadosFiscais.ckbOFGravaCTPClick(Sender: TObject);
begin
  inherited;

  if (fatVenda.strOpcDoc = 'EF') then
  begin
    if not fraDadosFechamentoVendaGravarContasFrame.ckbOFGravaCTP.Checked then
    begin
      fraDadosFechamentoVendaGravarContasFrame.ckbOFGravaCTP.Checked := not fLiberaNaoGravarContasPagar;
      fatVenda.blnCtpOutEnt := fraDadosFechamentoVendaGravarContasFrame.ckbOFGravaCTP.Checked;
    end;
  end
  else
  begin
    If (Not fraDadosFechamentoVendaGravarContasFrame.ckbOFGravaCTP.Checked) And (fatVenda.strOpcDoc = 'OF') Then
    Begin
      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'CTPOSF';
      objLiberacao.strSenLib    := fCfgSis('CTPOSF');
      objLiberacao.strMsgSen    := 'Não gerar Contas a Pagar de Outras Saídas';
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('Não gerar Contas a Pagar de Outras Saídas');

      if not objLiberacao.fLibera then
        fraDadosFechamentoVendaGravarContasFrame.ckbOFGravaCTP.Checked := True;
    End;

    fatVenda.blnOFGCTP := fraDadosFechamentoVendaGravarContasFrame.ckbOFGravaCTP.Checked;
  end;

end;

procedure TfrmFatDadosFiscais.cmbNatOpeEnter(Sender: TObject);
begin
  inherited;
  strDesClaAnt := Trim(fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Text);
end;

procedure TfrmFatDadosFiscais.cmbNatOpeExit(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Text)) And
     (strDesClaAnt <> Trim(fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Text)) Then
    strDesClaAnt := fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Text
  Else
    strDesClaAnt := '';
end;

function TfrmFatDadosFiscais.fBloqueiaNotaTranf: Boolean;
  Var
    qryGenEmp: TUniQuery;
begin
  If (fatVenda.fDocumentoParaFornecedor) Then
  Begin
    Result := False;
    Exit;
  End;

  Try
    qryGenEmp := fCriaQuery;

    With qryGenEmp Do
    Begin
      SQL.Add('SELECT  ');
      SQL.Add('  EMP_CODEMP ');
      SQL.Add('FROM  ');
      SQL.Add('  CADEMP  ');
      SQL.Add('WHERE  ');
      If (fatVenda.fDocumentoParaFornecedor) Then
        SQL.Add('  EMP_FORFIL = :CLIFIL AND  ')
      Else
        SQL.Add('  EMP_CLIFIL = :CLIFIL AND  ');
      SQL.Add('  EMP_CODEMP = :CODEMP ');

      ParamByName('CLIFIL').Value := fatVenda.strCodCli;
      ParamByName('CODEMP').Value := VS_strCodEmp;
      Open;

      If (Not IsEmpty) And (Pos(RightStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, 3), '151_152_408_409_') > 0) Then
      Begin

        objLiberacao.Clear;
        objLiberacao.strDirAce    := 'SENPEM';
        objLiberacao.strSenLib    := fCfgSis('SENPEM');
        objLiberacao.strMsgSen    := 'Transferência de Estoque não permitida para a própria loja';
        objLiberacao.strCodOpe    := fatVenda.strCodVen;
        objLiberacao.strCodDig    := fatVenda.strCodDig;
        objLiberacao.objMsgLibera.pAddTexto('Liberação para efetuar transferência de estoque para a própria Loja');

        if fatVenda.fFatMensagemLiberacao(objLiberacao)then
        Begin
          fatVenda.strCodVen := objLiberacao.strCodOpe;
          fatVenda.strCodDig := objLiberacao.strCodDig;

          Result := False;
          fatVenda.strPerEmpTe := 'S';
        End
        Else
        Begin
          Result := True;

          If fatVenda.strPerEmpTe = 'S' Then
            fatVenda.strPerEmpTe := '';
        End;
      End
      Else
        Result := False;

    End;

  Finally
    FreeAndNil(qryGenEmp);
  End;

end;


procedure TfrmFatDadosFiscais.FormActivate(Sender: TObject);
begin
  inherited;
  fraDadosFechamentoVendaTransportadoraFrame.btnHlpDes.Visible := blnNotImpXML;
  fraDadosFechamentoVendaTransportadoraFrame.lblOutros.Visible := blnNotImpXML;
  fraDadosFechamentoVendaTransportadoraFrame.edtOutros.Visible := blnNotImpXML;

  If ((blnExpedicao) And (fCfgSis('EXVOPD', varBoolean))) Or
     ((blnExpedicao) And (fCfgSis('SOLVOL', varBoolean)) and (fatVenda.intQtdTra > 0) ) Or
     ((blnExpedicao) And  fCfgSis('MONCAI', varBoolean) And (Pos(VS_strTipExp, '3_4') > 0) And fCfgSis('CFVLCB', varBoolean)) Or
     (fatVenda.strOpcDocTrue = 'BF') Or
     (blnNotImpXML) Or
     ((fatVenda.strOpcDocTrue = 'OF') And (blnEspelhoEnvioParaOFornecedor) And (fatVenda.intQtdTra > 0)) Then
  Begin
    fraDadosFechamentoVendaTransportadoraFrame.edtQtdTra.Text := intToStr(fatVenda.intQtdTra);
    If fraDadosFechamentoVendaTransportadoraFrame.pnlVolumeSepExc.Visible Then
    Begin
      fraDadosFechamentoVendaTransportadoraFrame.edtQtdTraSepExc.Text  := IntToStr(fatVenda.intQtdTraSepExc);
      fraDadosFechamentoVendaTransportadoraFrame.edtQtdTraSepNExc.Text := IntToStr(fatVenda.intQtdTraSepNExc);
    End;
  End
  Else If fEmptyStr(fatVenda.strNumOrc) Or (fatVenda.intQtdTra = 0) Then
  Begin
    IF fCfgSis('CALVOL', varBoolean) And (Not blnEspelhoEnvioParaOFornecedor) Then
    Begin
      fraDadosFechamentoVendaTransportadoraFrame.edtQtdTra.Text := FloatToStrF(fatVenda.fRetVolumes, ffFixed, 12, 0);
      If fraDadosFechamentoVendaTransportadoraFrame.pnlVolumeSepExc.Visible Then
        pCalcVolumeSepExclusiva;
    End
    Else If not (blnEspelhoEnvioParaOFornecedor) Then
    Begin
      fraDadosFechamentoVendaTransportadoraFrame.edtQtdTra.Text := '0';
      fraDadosFechamentoVendaTransportadoraFrame.edtQtdTraSepExc.Text  := '0';
      fraDadosFechamentoVendaTransportadoraFrame.edtQtdTraSepNExc.Text := '0';
    End;
  End
  Else
  Begin
    If (Floor(fatVenda.fRetVolumes) <> fatVenda.intQtdTra) And fCfgSis('CALVOL', varBoolean) Then
      fatVenda.pTratarDiferencaVolumeCalculadoComDigitado;

    fraDadosFechamentoVendaTransportadoraFrame.edtQtdTra.Text := intToStr(fatVenda.intQtdTra);
    If fraDadosFechamentoVendaTransportadoraFrame.pnlVolumeSepExc.Visible Then
    Begin
      fraDadosFechamentoVendaTransportadoraFrame.edtQtdTraSepExc.Text  := IntToStr(fatVenda.intQtdTraSepExc);
      fraDadosFechamentoVendaTransportadoraFrame.edtQtdTraSepNExc.Text := IntToStr(fatVenda.intQtdTraSepNExc);
    End;
  End;

  If (fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Enabled) Then
    pSetFocus(fraDadosFechamentoVendaTransportadoraFrame.edtValFre)
  else If (fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.CanFocus) Then
    pSetFocus(fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre)
  else If (fraDadosFechamentoVendaTransportadoraFrame.chkEntUrg.CanFocus) Then
    pSetFocus(fraDadosFechamentoVendaTransportadoraFrame.chkEntUrg);

  Self.blnRegistraUltimoComponenteClicado := True;

  If Not blnNotImp Then
  Begin
    fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Left :=
      fraDadosFechamentoVendaTransportadoraFrame.edtPesBru.Left;
    fraDadosFechamentoVendaTransportadoraFrame.lblDespAcessoria.Left :=
      fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Left -
      fraDadosFechamentoVendaTransportadoraFrame.lblDespAcessoria.Width -
      4;
  End;

end;

procedure TfrmFatDadosFiscais.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (Not blnPodeCancelar) And (Not blnConfirma) Then
    Action := caNone;

  If (Action <> caNone) Then
  Begin
    FreeAndNil(qryConCfo);

    If Assigned(cdsImpostosDigitadosItens) Then
      FreeAndNil(cdsImpostosDigitadosItens);

  End;
end;

procedure TfrmFatDadosFiscais.btnDadAdiClick(Sender: TObject);
begin
  inherited;

  pCriarFormularios(TfrmFatDadosAdicionais, frmFatDadosAdicionais);

  pAtualizarImpostosDigitadosParaMatrizItens;
  pGuardaClassificacoesOriginaisDosItens;

With frmFatDadosAdicionais, fatVenda Do
  Begin
    edtImpMer.Text := FormatFloat('#,##0.00', fltImpMer);
    edtFreImp.Text := FormatFloat('#,##0.00', fltValFre);
    edtSegImp.Text := FormatFloat('#,##0.00', fltValSeg);

    edtImpSeg.Text := FormatFloat('#,##0.00', fltImpSeg);
    edtBaseII.Text := FormatFloat('#,##0.00', fltBaseII);
    edtDesAdu.Text := FormatFloat('#,##0.00', fltDesAdu);
    edtImpImp.Text := FormatFloat('#,##0.00', fltImpImp);
    edtValIOF.Text := FormatFloat('#,##0.00', fltValIOF);
    edtImpPro.Text := FormatFloat('#,##0.00', fltTotPro);
    edtImpTax.Text := FormatFloat('#,##0.00', fltImpTax);
    edtImpPis.Text := FormatFloat('#,##0.00', fltTotPis);
    edtImpCof.Text := FormatFloat('#,##0.00', fltTotCof);
    edtAFRMM.Text  := FormatFloat('#,##0.00', fltTotRmm);
    edtTotDes.Text := FormatFloat('#,##0.00', fSomaDespesasAcessoriasImportacao);
    if (blnNotImpXML) then
    begin
//      fltDespesaAcessoria := fltDesAce;
//      fltTotalIpi := fltTotIpi;
      frmFatDadosAdicionais.PerfilDespachanteAduaneiro := Self.PerfilDespachanteAduaneiro;
      edtTotDes.Text := FormatFloat('#,##0.00', fSomaOutrasDespesasImportacaoDefinidoConfiguracao);
    end;

    edtImpIC1.Text := strImpIC1;
    edtImpIC2.Text := strImpIC2;


    frmFatDadosAdicionais.recDespesasAduaneiras.fltDemurr := fatVenda.fltAduDem;
    frmFatDadosAdicionais.recDespesasAduaneiras.fltTaxArm := fatVenda.fltAduTxa;
    frmFatDadosAdicionais.recDespesasAduaneiras.fltDespac := fatVenda.fltAduDpc;
    frmFatDadosAdicionais.recDespesasAduaneiras.fltFrete_ := fatVenda.fltAduFre;
    frmFatDadosAdicionais.recDespesasAduaneiras.fltOutDes := fatVenda.fltAduOdp;
    frmFatDadosAdicionais.recDespesasAduaneiras.fltMulAdu := fatVenda.fltAduMul;
    frmFatDadosAdicionais.recDespesasAduaneiras.fltFreInt := fatVenda.fltAduFti;
    frmFatDadosAdicionais.recDespesasAduaneiras.fltF_500_ := fatVenda.fltAdu500;
    frmFatDadosAdicionais.recDespesasAduaneiras.fltTotalD := fatVenda.fltDesAdu;


    If frmFatDadosAdicionais.ShowModal = mrOk Then
    Begin
      fltImpMer := fStrToFloat(edtImpMer.Text);
      fltImpSeg := fStrToFloat(edtImpSeg.Text);
      fltImpImp := fStrToFloat(edtImpImp.Text);
      fltBaseII := fStrToFloat(edtBaseII.Text);
      fltDesAdu := fStrToFloat(edtDesAdu.Text);
      fltValIOF := fStrToFloat(edtValIOF.Text);
      fltImpPro := fStrToFloat(edtImpPro.Text);
      fltImpTax := fStrToFloat(edtImpTax.Text);
      strImpIC1 := edtImpIC1.Text;
      strImpIC2 := edtImpIC2.Text;

      pRateiaValorTaxaSiscomexNosItens;
      pAtualizaRodape;

      pSetFocus(Self.btnConfirmaDados);
    End;

  End;

  FreeAndNil(frmFatDadosAdicionais);

end;

procedure TfrmFatDadosFiscais.btnDespesasFaturamentoClick(Sender: TObject);
begin
  inherited;
  If fraDadosFechamentoVendaTransportadoraFrame.btnDespesasFaturamento.Visible And Assigned(fatVenda.objDespesasFaturamento) Then
  Begin
    fatVenda.objDespesasFaturamento.pExibirDigitacaoDespesas;
    fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text := FormatFloat('#,##0.00', fatVenda.objDespesasFaturamento.fltValorTotal);
    If fAlterouDespesasAcessoria Then fValidaCampos(fraDadosFechamentoVendaTransportadoraFrame.edtDesAce, True);
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDadosFiscais.edtTotGerExit(Sender: TObject);
begin
  inherited;
  fatVenda.fltImpTot := fStrToFloat(fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.Text);
end;

procedure TfrmFatDadosFiscais.edtMens01Exit(Sender: TObject);
begin
  inherited;
  fatVenda.strMen001 := fraDadosFechamentoVendaMSGFatFrame.edtMens01.Text;
end;

procedure TfrmFatDadosFiscais.edtMens02Exit(Sender: TObject);
begin
  inherited;
  fatVenda.strMen002 := fraDadosFechamentoVendaMSGFatFrame.edtMens02.Text;
end;

procedure TfrmFatDadosFiscais.edtMens03Exit(Sender: TObject);
begin
  inherited;
  fatVenda.strMen003 := fraDadosFechamentoVendaMSGFatFrame.edtMens03.Text;
end;

procedure TfrmFatDadosFiscais.edtMens04Exit(Sender: TObject);
begin
  inherited;
  fatVenda.strMen004 := fraDadosFechamentoVendaMSGFatFrame.edtMens04.Text;
end;

procedure TfrmFatDadosFiscais.edtMens05Exit(Sender: TObject);
begin
  inherited;
  fatVenda.strMen005 := fraDadosFechamentoVendaMSGFatFrame.edtMens05.Text;
end;

procedure TfrmFatDadosFiscais.edtPesBruExit(Sender: TObject);
begin
  inherited;
  if fAlterouPesoBruto then
  Begin
    If fValidaCampos(fraDadosFechamentoVendaTransportadoraFrame.edtPesBru, True) Then
    Begin
      pAplicaFatorPesBruLiq('B', fStrToFloat(strPesBruAnt), fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtPesBru.Text));
      fatVenda.fltPesBru := fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtPesBru.Text);
      strPesBruAnt := FormatFloat('#,###0.000', fatVenda.fltPesBru);
    End;
  End;
end;

procedure TfrmFatDadosFiscais.edtPesLiqExit(Sender: TObject);
begin
  inherited;
  if fAlterouPesoLiqui then
  Begin
    If fValidaCampos(fraDadosFechamentoVendaTransportadoraFrame.edtPesLiq, True) Then
    Begin
      pAplicaFatorPesBruLiq('L', fStrToFloat(strPesLiqAnt), fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtPesLiq.Text));
      fatVenda.fltPesLiq := fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtPesLiq.Text);
      strPesLiqAnt := FormatFloat('#,###0.000', fatVenda.fltPesLiq);
    End;
  End;
end;

procedure TfrmFatDadosFiscais.edtCodPrjKeyPress(Sender: TObject; var Key: Char);
  Var
    arrPrj : TConsultasArray;
begin
  If fPesqProjetos(Self, fraDadosFechamentoVendaProjetoFrame.edtCodPrj, fraDadosFechamentoVendaProjetoFrame.edtDesPrj, qryTabela, Key, arrPrj, True, fatvenda.strCodcli) Then
  Begin
    If fValidaCampos(fraDadosFechamentoVendaProjetoFrame.edtCodPrj, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDadosFiscais.edtCodSitKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCodSit : TConsultasArray;
begin
  inherited;
  If fPesqSitTributaria(Self, TEditFocus(Sender), Nil, Nil, Key, arrCodSit) Then
  Begin
    If fValidaCampos(TEditFocus(Sender)) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDadosFiscais.pAjustaMensagemNC;
  Var
    arrMen : Array [1..5] Of String;
    arrMenNC : Array [1..10] Of String;
    intCntMen : Integer;
    intCntMenNC : Integer;
begin
  arrMen[1] := Trim(fatVenda.strMen001);
  arrMen[2] := Trim(fatVenda.strMen002);
  arrMen[3] := Trim(fatVenda.strMen003);
  arrMen[4] := Trim(fatVenda.strMen004);
  arrMen[5] := Trim(fatVenda.strMen005);

  arrMenNC[1]  := Trim(fatVenda.strMenNc01);
  arrMenNC[2]  := Trim(fatVenda.strMenNc02);
  arrMenNC[3]  := Trim(fatVenda.strMenNc03);
  arrMenNC[4]  := Trim(fatVenda.strMenNc04);
  arrMenNC[5]  := Trim(fatVenda.strMenNc05);
  arrMenNC[6]  := Trim(fatVenda.strMenNc06);
  arrMenNC[7]  := Trim(fatVenda.strMenNc07);
  arrMenNC[8]  := Trim(fatVenda.strMenNc08);
  arrMenNC[9]  := Trim(fatVenda.strMenNc09);
  arrMenNC[10] := Trim(fatVenda.strMenNc10);

  For intCntMen := 1 To 5 Do
  Begin
    If Not fEmptyStr(arrMen[intCntMen]) Then
    Begin
      For intCntMenNC := 1 To 10 Do
      Begin
        If fEmptyStr(arrMenNC[intCntMenNC]) Then
        Begin
          arrMenNC[intCntMenNC] := arrMen[intCntMen];
          Break;
        End;
      End;
    End;
  End;

  fatVenda.strMenNc01 := arrMenNC[1];
  fatVenda.strMenNc02 := arrMenNC[2];
  fatVenda.strMenNc03 := arrMenNC[3];
  fatVenda.strMenNc04 := arrMenNC[4];
  fatVenda.strMenNc05 := arrMenNC[5];
  fatVenda.strMenNc06 := arrMenNC[6];
  fatVenda.strMenNc07 := arrMenNC[7];
  fatVenda.strMenNc08 := arrMenNC[8];
  fatVenda.strMenNc09 := arrMenNC[9];
  fatVenda.strMenNc10 := arrMenNC[10];
end;

procedure TfrmFatDadosFiscais.pAjustaMensagens(strOpcDoc: String);
  Var
    intContador: Integer;
    intQtdMsg  : Integer;
    objEdit    : TObject;
begin
  {***********************************************}
  {* AJUSTA A TELA DE ACORDO COM A QUANTIDADE DE *}
  {* MENSAGENS CONFIGURADAS PARA NOTA FISCAL     *}
  {** 20/03/2008 - 10:24 **********************ER*}

  intQtdMsg := fCfgSis('QTDMSG', varInteger);

  If strOpcDoc = 'NC' Then
    intQtdMsg := 0;

  If fEhRestituicaoDeIcmsStOuEstoque Then
    intQtdMsg := 5;

  fraDadosFechamentoVendaMSGFatFrame.lblMensagem.Visible := intQtdMsg > 0;

  pnlMensagem.Height                        := pnlMensagem.Height                        - (fraDadosFechamentoVendaMSGFatFrame.edtMens01.Height * (5 - intQtdMsg));
  fraDadosFechamentoVendaMSGFatFrame.Height := fraDadosFechamentoVendaMSGFatFrame.Height - (fraDadosFechamentoVendaMSGFatFrame.edtMens01.Height * (5 - intQtdMsg));

  For intContador := intQtdMsg + 1 To 5 Do
  Begin
    objEdit := fraDadosFechamentoVendaMSGFatFrame.FindComponent('edtMens0'+IntToStr(intContador));
    TEditFocus(objEdit).Visible := False;
    TEditFocus(objEdit).Text := String.Empty;
    if Assigned(TEditFocus(objEdit).OnExit) then
      TEditFocus(objEdit).OnExit(objEdit);
  End;
end;


procedure TfrmFatDadosFiscais.pAplicaFatorPesBruLiq(strTipPes: String;
  fltPesOri, fltPesDig: Double);
  Var
    intIdx: Integer;
    fltFator: Double;
    fltPesos: Double;
begin
  fltFator := 0;
  fltPesos := 0;

  If (fltPesOri <> 0) Then
    fltFator := fltPesDig / fltPesOri
  Else
    fltPesos := fltPesDig / fRetornaQuantidadeDeItensNaNota(fatVenda.arrMatItens);

  fatVenda.strEdiPesGer := 'S';

  For intIdx := 0 To Length(fatVenda.arrMatItens) -1 Do
  Begin
    If (strTipPes='B') Then
    Begin
      If (fltPesos <> 0) Then
      Begin
        fatVenda.arrMatItens[intIdx].fltPesoIt     := fltPesos;
        fatVenda.arrMatItens[intIdx].fltPesoItCalc := fltPesos;
      End
      Else
      Begin
        fatVenda.arrMatItens[intIdx].fltPesoIt     := fatVenda.arrMatItens[intIdx].fltPesoIt     * fltFator;
        fatVenda.arrMatItens[intIdx].fltPesoItCalc := fatVenda.arrMatItens[intIdx].fltPesoItCalc * fltFator;
      End
    End
    Else
    Begin
      If (fltPesos <> 0) Then
      Begin
        fatVenda.arrMatItens[intIdx].fltPesLiq     := fltPesos;
        fatVenda.arrMatItens[intIdx].fltPesLiqCalc := fltPesos;
      End
      Else
      Begin
        fatVenda.arrMatItens[intIdx].fltPesLiq     := fatVenda.arrMatItens[intIdx].fltPesLiq     * fltFator;
        fatVenda.arrMatItens[intIdx].fltPesLiqCalc := fatVenda.arrMatItens[intIdx].fltPesLiqCalc * fltFator;
      End;
    End;
  End;
end;

procedure TfrmFatDadosFiscais.pAplicarModoSomenteVisualizacaoEspelhoDevolucao(AOrigemEntradaDV: Boolean = False);
begin
  blnVisualizacaoEspelhoDevolucao := True;
  blnOrigemEntradaDV := AOrigemEntradaDV;
  btnConfirmaDados.OnClick := btnConfirmaDadosOnClickVisualizacaoAd;
  btnConfirmaDados.Caption := 'Fechar';
  btnCancelaDados.visible := False;

end;

procedure TfrmFatDadosFiscais.edtDesAceExit(Sender: TObject);
begin
  inherited;
  //Caso nao tenha validado com o enter, entao forca a validacao na saida do edit
  If fAlterouDespesasAcessoria Then
    fValidaCampos(fraDadosFechamentoVendaTransportadoraFrame.edtDesAce, True);

end;

procedure TfrmFatDadosFiscais.edtAlqIcmExit(Sender: TObject);
begin
  inherited;
  pAtualizaVlrIcm;
end;

procedure TfrmFatDadosFiscais.edtAlqFCPSTExit(Sender: TObject);
begin
  inherited;
  pAtualizaVlrFCPST;
end;

procedure TfrmFatDadosFiscais.edtBasFCPSTExit(Sender: TObject);
begin
  inherited;
  pAtualizaAlqFCPST;
end;

procedure TfrmFatDadosFiscais.edtBasIcmExit(Sender: TObject);
begin
  inherited;
  pAtualizaAlqIcm;
end;

procedure TfrmFatDadosFiscais.edtClaFisExit(Sender: TObject);
begin
  inherited;
  If FUsaTrocaDeCfopNaDigitacaoDeImpostos Then
    Exit;

  //Caso nao tenha validado com o enter, entao forca a validacao na saida do edit
  If fAlterouClassificacaoFiscal Then
    fValidaCampos(fraDadosFechamentoVendaClaFisFrame.edtClaFis, True);
end;

function TfrmFatDadosFiscais.fMaisDeUmaCfop: Boolean;
begin
  Result := (Not fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text)) Or
            (Not fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text));
end;

function TfrmFatDadosFiscais.fUtilizarClassificacaoDaMatriz: Boolean;
Begin
  Result := True;

  If (fEhOutrasSaidasDeFornecedorDevolucao And fMaisDeUmaCfop) Then
    Exit;

  If ((fatVenda.strOpcDoc = 'OF') And (fMaisDeUmaCfop)) Then
    Exit;

  If ((fatVenda.strOpcDoc = 'OE') And (fMaisDeUmaCfop)) Then
    Exit;

  If ((fatVenda.strOpcDoc = 'OU') And (fMaisDeUmaCfop)) Then
    Exit;

  If (fatVenda.strOpcDocTrue = 'FE') And fMaisDeUmaCfop Then
    Exit;

  If ((fatVenda.strOpcDoc = 'NE') And (fMaisDeUmaCfop)) Then
    Exit;

  If ((fatVenda.strOpcDoc = 'GF') And (fMaisDeUmaCfop)) Then
    Exit;

  Result := False;
End;

procedure TfrmFatDadosFiscais.btnDigImpostosItensClick(Sender: TObject);
var
  intCont: Integer;

  {FCP ST}
  fltBasFcp : double;
  fltPerFcp : double;
  fltValFcp : double;

  {FCP}
  fltBasFcp_ : double;
  fltPerFcp_ : double;
  fltValFcp_ : double;
begin
  inherited;

  If Not btnDigImpostosItens.Visible Then
    Exit;

  {**************************************************************************}
  {* DEVE VALIDAR O FRETE, DESPESAS ACESSORIAS E AS CLASSIFICACOES FISCAIS  *}
  {* ANTES DE ENTRAR NA DIGITACAO DOS IMPOSTOS, PARA NAO OCORRER DO USUARIO *}
  {* DIGITAR TODOS OS IMPOSTOS DOS ITENS E DEPOIS DESCOBRIR QUE A CFOP NAO  *}
  {* É VALIDA E ELE PERDER TUDO OQUE FOI DIGITADO AO TER DE ALTERAR A MESMA *}
  {**********************************************************************JC**}
  If Not fValidaCampos(fraDadosFechamentoVendaTransportadoraFrame.edtValFre, True) Then
    Exit;

  If Not fValidaCampos(fraDadosFechamentoVendaTransportadoraFrame.edtDesAce, True) Then
    Exit;

  If Not fValidaCampos(fraDadosFechamentoVendaClaFisFrame.edtClaFis, True) Then
    Exit;

  If Not fValidaCampos(fraDadosFechamentoVendaClaFisFrame.edtClaFi2, True) Then
    Exit;

  If Not fValidaCampos(fraDadosFechamentoVendaClaFisFrame.edtClaFi3, True) Then
    Exit;

  If (Not FUsaTrocaDeCfopNaDigitacaoDeImpostos) And (fEhOutrasSaidasDeFornecedorDevolucao) And (Not fCFOPMesmaCategoriaOutrasSaidasDeFornecedorDevolucao) Then
  Begin
    If fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled Then
      pSetFocus(fraDadosFechamentoVendaClaFisFrame.edtClaFis);
    Exit;
  End;

  If Not Assigned(cdsImpostosDigitadosItens) Then
    pMensagemSonora(Concat('Antes de digitar os impostos dos produtos verifique se o valor ',
                           'do frete, despesa acessória e as classificações fiscais estão ',
                           'corretos, pois se for necessário alterar algum destes campos ',
                           'os impostos digitados nos itens serão descartados ',
                           'sendo necessário digita-los novamente!'));

  If fUtilizarClassificacaoDaMatriz Then
  Begin    
    pAtualizaMatItens(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, strCl1Ant, strCl1Ant);
    pAtualizaMatItens(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text, strCl2Ant, strCl2Ant);
    pAtualizaMatItens(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text, strCl3Ant, strCl3Ant);
  End;

  pSetFocus(btnDigImpostosItens);

  Try
    If Not blnFatDadosFiscaisImpostosExterno Then
      pCriarFormularios(TfrmFatDadosFiscaisImpostos, frmFatDadosFiscaisImpostos);

    frmFatDadosFiscaisImpostos.blnDevolucao      := (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, VS_strClaDev) > 0);

    frmFatDadosFiscaisImpostos.blnNotImp := blnNotImp;

    frmFatDadosFiscaisImpostos.blnTrocaCFOP := FUsaTrocaDeCfopNaDigitacaoDeImpostos;

    If not FUsaTrocaDeCfopNaDigitacaoDeImpostos Then
    Begin
      fatVenda.strClaFis := fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text;
      fatVenda.pCalculaPisCofinsLivro(fatVenda.strClaFis);
    End;

    If blnNotImp Or (fatVenda.strOpcDoc = 'OF') Or ((fatVenda.strOpcDoc = 'NE') And (fatVenda.blnNEFornecedor)) Then
    Begin
      frmFatDadosFiscaisImpostos.strCodigoFornecedor := fatVenda.strCodCli;
      frmFatDadosFiscaisImpostos.blnNotaFornecedor   := True;
    End;

    If (Pos(fatVenda.strOpcDoc, 'OU_OF_NE_') > 0) Or blnNotImp Then
      frmFatDadosFiscaisImpostos.blnIcmsDesonerado := True;

    frmFatDadosFiscaisImpostos.strSitP_C := fatVenda.strSitP_C;
    frmFatDadosFiscaisImpostos.strMenP_C := fatVenda.strMenP_C;

    frmFatDadosFiscaisImpostos.strOpcDoc := fatVenda.strOpcDoc;
    frmFatDadosFiscaisImpostos.strCliOrg := fatVenda.strCliOrg;
    frmFatDadosFiscaisImpostos.strZonFra := fatVenda.strZonFra;
    frmFatDadosFiscaisImpostos.fatVenda  := Self.fatVenda;

    If Assigned(cdsImpostosDigitadosItens) Then
      frmFatDadosFiscaisImpostos.cdsItens.Data := cdsImpostosDigitadosItens.Data
    Else
    Begin
      For intCont := 0 To Length(fatVenda.arrMatItens) -1 Do
      Begin
        If fEmptyStr(fatVenda.arrMatItens[intCont].strFisAnt) Then
          fatVenda.arrMatItens[intCont].strFisAnt := fatVenda.arrMatItens[intCont].strCodFis;

        If Not (fCfgSis('USASER', varBoolean) And fEhItemServico(fatVenda.arrMatItens[intCont].strCodIte)) Then
        begin

          {FCP ST}
          fltBasFcp := 0;
          fltValFcp := 0;
          fltPerFcp := 0;

          if (fatVenda.arrMatItens[intCont].fltValRet > 0) and (fatVenda.arrMatItens[intCont].recDifalFCP.fltPerFcp > 0) then
          begin
            fltBasFcp := fatVenda.arrMatItens[intCont].recDifalFCP.fltBasFcp;
            fltValFcp := fatVenda.arrMatItens[intCont].recDifalFCP.fltValFcp;
            fltPerFcp := fatVenda.arrMatItens[intCont].recDifalFCP.fltPerFcp;
          end;

          {FCP}
          fltBasFcp_ := 0;
          fltPerFcp_ := 0;
          fltValFcp_ := 0;

          if ((fatVenda.arrMatItens[intCont].VisualizarFcpIcms.fltValor > 0) and (fatVenda.arrMatItens[intCont].VisualizarFcpIcms.fltAliquota > 0)) Or 
             (fatVenda.fGravaEspelhoFundoCombateIMCeFundoCombateST(fatVenda.arrMatItens[intCont].strClaFis, fatVenda.arrMatItens[intCont].strEmpIte)) then
          begin
            If (fatVenda.fGravaEspelhoFundoCombateIMCeFundoCombateST(fatVenda.arrMatItens[intCont].strClaFis, fatVenda.arrMatItens[intCont].strEmpIte)) Then
            Begin
              fltBasFcp_ := fatVenda.arrMatItens[intCont].EspelhoFcpIcms.fltBase;
              fltPerFcp_ := fatVenda.arrMatItens[intCont].EspelhoFcpIcms.fltAliquota;
              fltValFcp_ := fatVenda.arrMatItens[intCont].EspelhoFcpIcms.fltValor;
            End
            Else
            Begin  
              fltBasFcp_ := fatVenda.arrMatItens[intCont].VisualizarFcpIcms.fltBase;
              fltPerFcp_ := fatVenda.arrMatItens[intCont].VisualizarFcpIcms.fltAliquota;
              fltValFcp_ := fatVenda.arrMatItens[intCont].VisualizarFcpIcms.fltValor;
            End;
          end;

          frmFatDadosFiscaisImpostos.pAdicionaRegistro(fatVenda.arrMatItens[intCont].intAutInc,
                                                       fatVenda.arrMatItens[intCont].strCodIte,
                                                       fatVenda.arrMatItens[intCont].strEmpIte,
                                                       fatVenda.arrMatItens[intCont].strDesIte,
                                                       fatVenda.arrMatItens[intCont].strRefere,
                                                       fatVenda.arrMatItens[intCont].strSigUni,

                                                       fatVenda.fRetornaCstDiferimento(fatVenda.arrMatItens[intCont].fltBasIcm,
                                                                                       fatVenda.arrMatItens[intCont].strCodFis),

                                                       fatVenda.arrMatItens[intCont].strClaIpi,

                                                       fatVenda.arrMatItens[intCont].strFisAnt,
                                                       fatVenda.arrMatItens[intCont].strCodAbf,

                                                       fatVenda.arrMatItens[intCont].fltQtdIte,
                                                       fatVenda.arrMatItens[intCont].fltTotIte -
                                                       fatVenda.arrMatItens[intCont].fltDesEsp,

                                                       fatVenda.arrMatItens[intCont].fltBasIcm,
                                                       fatVenda.arrMatItens[intCont].fltAlqIcm,
                                                       fatVenda.arrMatItens[intCont].fltValIcm,
                                                       fatVenda.arrMatItens[intCont].fltBasIpi,
                                                       fatVenda.arrMatItens[intCont].fltAlqIpi,
                                                       fatVenda.arrMatItens[intCont].fltValipi,
                                                       fatVenda.arrMatItens[intCont].fltBasRet,
                                                       fatVenda.arrMatItens[intCont].fltValRet,

                                                       fatVenda.arrMatItens[intCont].fltAlqPis,
                                                       fatVenda.arrMatItens[intCont].fltBasPis,
                                                       fatVenda.arrMatItens[intCont].fltValPis,

                                                       fatVenda.arrMatItens[intCont].fltAlqCof,
                                                       fatVenda.arrMatItens[intCont].fltBasCof,
                                                       fatVenda.arrMatItens[intCont].fltValCof,

                                                       {FCP ST}
                                                       fltBasFcp,
                                                       fltPerFcp,
                                                       fltValFcp,

                                                       {FCP}
                                                       fltBasFcp_,
                                                       fltPerFcp_,
                                                       fltValFcp_,

                                                       IIF(fUtilizarClassificacaoDaMatriz, fatVenda.arrMatItens[intCont].strClaFis, fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text),

                                                       fatVenda.arrMatItens[intCont].strIncPis,
                                                       fatVenda.arrMatItens[intCont].strCstPis,
                                                       fatVenda.arrMatItens[intCont].strCstCof,
                                                       fatVenda.arrMatItens[intCont].fltBasVrd,
                                                       fatVenda.arrMatItens[intCont].fltVrdIcm,
                                                       fatVenda.arrMatItens[intCont].strMtdIcm,

                                                       '',//strautInc (autoincrem da ESPDET);
                                                       '',//strGarant Tipo de documento a ser confirmado para validar a CFOP;

                                                       fatVenda.arrMatItens[intCont].strDocDev,
                                                       fatVenda.arrMatItens[intCont].strEspDev,
                                                       fatVenda.arrMatItens[intCont].strEmpDev,
                                                       fatVenda.arrMatItens[intCont].fltValIva,
                                                       fatVenda.arrMatItens[intCont].fltAlqRet,
                                                       fatVenda.arrMatItens[intCont].fltPerRed,
                                                       fatVenda.arrMatItens[intCont].fltPeBaST,
                                                       fatVenda.arrMatItens[intCont].fltValCBS,
                                                       fatVenda.arrMatItens[intCont].fltValIBS,
                                                       fatVenda.arrMatItens[intCont].fltVal_IS);

          end;
      End;
    End;

    frmFatDadosFiscaisImpostos.cdsItensITE_CODSIT.ReadOnly := True;
    If (Pos(fatVenda.strOpcDoc, 'VN_OU_OF_OE_EF_GF_NE_OV_') > 0) Or (Pos(fatVenda.strOpcDocTrue, 'EI_') > 0) Or fClienteFilial(fatVenda.strCodCli) Then
      frmFatDadosFiscaisImpostos.cdsItensITE_CODSIT.ReadOnly := False;
    
    {Realiza cópia antes do operador alterar}
    If (cdsImpostos_Ant.IsEmpty) Then {<<- Copia os dados anteriores a 1º vez, pois a tela pode ser acessada várias vezes.}
      pCopiaImpostos(cdsImpostos_Ant);
    
    frmFatDadosFiscaisImpostos.blnDifFCPST := fatVenda.blnDifFCPST;

    frmFatDadosFiscaisImpostos.blnEhOutrasSaidasDeFornecedorDevolucao := fEhOutrasSaidasDeFornecedorDevolucao(fatVenda.strOpcDoc, fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text);
    
    If Not frmFatDadosFiscaisImpostos.cdsItens.IsEmpty Then
      frmFatDadosFiscaisImpostos.ShowModal
    Else
      fMensagem('','Não foram encontrados produtos neste documento!', ['&Ok']);

    If frmFatDadosFiscaisImpostos.ModalResult = mrOk Then
    Begin
      if (pos(fatVenda.strOpcDoc, '_GF_') > 0) or (fatVenda.strOpcDocTrue = 'NW') then
        fatVenda.blnBloquearRestaurarValoresEspeplhoGF := True;

      If Not Assigned(cdsImpostosDigitadosItens) Then
        cdsImpostosDigitadosItens := TUniClientDataSet.Create(Self);

      cdsImpostosDigitadosItens.Data := frmFatDadosFiscaisImpostos.cdsItens.Data;

      fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Text := frmFatDadosFiscaisImpostos.edtBasIcm.Text;
      fraDadosFechamentoVendaTotaisFrame.edtValIcm.Text := frmFatDadosFiscaisImpostos.edtValIcm.Text;
      fraDadosFechamentoVendaTotaisFrame.edtBasIpi.Text := frmFatDadosFiscaisImpostos.edtBasIpi.Text;
      fraDadosFechamentoVendaTotaisFrame.edtValIpi.Text := frmFatDadosFiscaisImpostos.edtValIpi.Text;
      fraDadosFechamentoVendaTotaisFrame.edtBasRet.Text := frmFatDadosFiscaisImpostos.edtBasRet.Text;
      fraDadosFechamentoVendaTotaisFrame.edtValRet.Text := frmFatDadosFiscaisImpostos.edtValRet.Text;

      {FCP ST}
      fraDadosFechamentoVendaTotaisFrame.edtBasFCPST.Text := frmFatDadosFiscaisImpostos.edtBasFCPST.Text;
      fraDadosFechamentoVendaTotaisFrame.edtValFCPST.Text := frmFatDadosFiscaisImpostos.edtValFCPST.Text;
      If (Not frmFatDadosFiscaisImpostos.blnTeveFCPSTAlteradoManualemente) Then
        pAtualizaAlqFCPST;

      {FCP}
      fraDadosFechamentoVendaTotaisFrame.edtVlrFCP.Text := frmFatDadosFiscaisImpostos.edtValFCP.Text;

      If (frmFatDadosFiscaisImpostos.blnSintetizouClassificacoesFiscais) Then
      Begin
        fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text := fatVenda.strClaFis;
        fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text := fatVenda.strClaFi2;
        fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text := fatVenda.strClaFi3;
        pCarregaNatOperacao(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text);
      End;

      If blnNotImp Or (Pos(fatVenda.strOpcDoc, 'OF_OE_FE_OU_NE_') > 0) Then
      Begin
        pAtualizarImpostosDigitadosParaMatrizItens;
        pGuardaClassificacoesOriginaisDosItens;
      End;

      If blnNotImp Then
        pRateiaValorTaxaSiscomexNosItens;

      if (fZeraImpostoFaturaConsignacao(fatVenda.strClaFis)) and (fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtValIpi.Text) > 0) then
      begin
        fatVenda.fltValIpiZeradoFaturaConsignacao := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtValIpi.Text);
        fraDadosFechamentoVendaTotaisFrame.edtBasIpi.Text := '0,00';
        fraDadosFechamentoVendaTotaisFrame.edtValIpi.Text := '0,00';
      end;

      if (fZeraImpostoFaturaConsignacao(fatVenda.strClaFis)) and
         (fCfgSis('FAMECO', varString) = '3') then
      begin
        if (fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtValRet.Text) > 0) then
        Begin
          fatVenda.fltValSTZeradoFaturaConsignacao := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtValRet.Text);
          fraDadosFechamentoVendaTotaisFrame.edtBasRet.Text := '0,00';
          fraDadosFechamentoVendaTotaisFrame.edtValRet.Text := '0,00';
        End;

        if (fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtValFCPST.Text) > 0) then
        Begin
          fatVenda.fltValFcpSTZeradoFaturaConsignacao := fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtValFCPST.Text);
          fraDadosFechamentoVendaTotaisFrame.edtBasFCPST.Text := '0,00';
          fraDadosFechamentoVendaTotaisFrame.edtValFCPST.Text := '0,00';
        End;
      end;

      If FUsaTrocaDeCfopNaDigitacaoDeImpostos Then
        strClaFisAnt := fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text;

      pAtualizaRodape;

      strValFreCotAnt := fraDadosFechamentoVendaTransportadoraFrame.edtValFreCot.Text;

      {Realiza cópia após alterações do operador}
      pCopiaImpostos(cdsImpostos_Pos);

      {Identifica se houve realmente alterações}
      pProcessaDiferencas(frmFatDadosFiscaisImpostos.blnTeveMotivoValorDesoneradoAlteradoManualemente);

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
  If Assigned(frmFatDadosFiscaisImpostos) And (Not blnFatDadosFiscaisImpostosExterno) Then
    pFreeAndNil(frmFatDadosFiscaisImpostos);

  pSetFocus(btnConfirmaDados);

end;

procedure TfrmFatDadosFiscais.btnEspRascNFClick(Sender: TObject);
var
  objGerarEspelho: TGerarEspelhoRascunhoDANFE;
  fltTotGerOriginal: Double;
begin
  inherited;

  fltTotGerOriginal := fatVenda.fltTotGer;

  try
    fValidaCampos(fraDadosFechamentoVendaClaFisFrame.edtClaFis, True);

    objGerarEspelho := TGerarEspelhoRascunhoDANFE.Create(VS_strCodEmp, fatVenda);
    blnConfirma       := False;
    FblnEspRascDANFE  := True;
    pConfirma;

    if (not blnConfirma) then
      Exit;

    objGerarEspelho.fGerarEspelho(fatVenda.fOpcDocClaSub);
  finally
    blnConfirma        := False;
    FblnEspRascDANFE   := False;
    fatVenda.fltTotGer := fltTotGerOriginal;
    FreeAndNil(objGerarEspelho);
  end;
end;

procedure TfrmFatDadosFiscais.fraDadosFechamentoVendaTransportadoraFramebtnHlpDesClick(
  Sender: TObject);
var strMensagem: string;
begin
  inherited;
  If Assigned(PerfilDespachanteAduaneiro) then
  begin
    strMensagem := '';
    If tcvoSISCOMEX in PerfilDespachanteAduaneiro.ComposicaoValorOutras then
      strMensagem := strMensagem + Format('Valor da Taxa Siscomex: %s' + #13, [FormatFloat('#,##0.00',fatVenda.fltImpTax)]);
    If tcvoPIS in PerfilDespachanteAduaneiro.ComposicaoValorOutras then
      strMensagem := strMensagem + Format('Valor PIS: %s' + #13, [FormatFloat('#,##0.00',fatVenda.fltTotPis)]);
    If tcvoCOFINS in PerfilDespachanteAduaneiro.ComposicaoValorOutras then
      strMensagem := strMensagem + Format('Valor COFINS: %s' + #13, [FormatFloat('#,##0.00',fatVenda.fltTotCof)]);
    If tcvoIOF in PerfilDespachanteAduaneiro.ComposicaoValorOutras then
      strMensagem := strMensagem + Format('Valor IOF: %s' + #13, [FormatFloat('#,##0.00',fatVenda.fltValIof)]);
    If tcvoDESPESAS_ADUANEIRAS in PerfilDespachanteAduaneiro.ComposicaoValorOutras then
      strMensagem := strMensagem + Format('Valor Despesas Aduaneiras: %s' + #13, [FormatFloat('#,##0.00',fatVenda.fltDesAdu)]);
    If tcvoAFRMM in PerfilDespachanteAduaneiro.ComposicaoValorOutras then
      strMensagem := strMensagem + Format('Valor A.F.R.M.M: %s' + #13 , [FormatFloat('#,##0.00',fatVenda.fltTotRmm)]);
    strMensagem := strMensagem + Format('Total de Outros: %s',[FormatFloat('#,##0.00',fSomaOutrasDespesasImportacaoDefinidoConfiguracao)]);

    fMensagemEx('Outros', strMensagem,['&OK'],1
      ,False
      ,1
      ,0
      ,False
      ,0
      ,False
      ,False
      ,False
      ,0
      ,0
      ,6
    );
  end
  Else
  begin
    fMensagemEx('Outros',
      Format(
      'Valor da Taxa Siscomex: %s' + #13 +
      'Valor PIS: %s' + #13 +
      'Valor COFINS: %s' + #13 +
      'Valor IOF: %s' + #13 +
      'Valor Despesas Aduaneiras:: %s' + #13 +
      'Valor A.F.R.M.M: %s' + #13 +
      'Total de Outros: %s',[
        FormatFloat('#,##0.00',fatVenda.fltImpTax),
        FormatFloat('#,##0.00',fatVenda.fltTotPis),
        FormatFloat('#,##0.00',fatVenda.fltTotCof),
        FormatFloat('#,##0.00',fatVenda.fltValIof),
        FormatFloat('#,##0.00',fatVenda.fltDesAdu),
        FormatFloat('#,##0.00',fatVenda.fltTotRmm),
        FormatFloat('#,##0.00',fSomaDespesasAcessoriasImportacao)
        ])
      ,['&OK']
      ,1
      ,False
      ,1
      ,0
      ,False
      ,0
      ,False
      ,False
      ,False
      ,0
      ,0
      ,6
    );
  end;
end;

procedure TfrmFatDadosFiscais.btnMostraMargemClick(Sender: TObject);
begin
  inherited;
  If (fStrToFloat(fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.Text) <= 0.0) Then
    Exit;

  If (btnMostraMargem.Enabled) And (btnMostraMargem.Visible) Then
  Begin

    If InterlockedIncrement(intSemaforoConfirma) = 0 Then
    Begin

      Try
        fatVenda.strCodTra := fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text;
        fatVenda.fltValFre := fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text);
        pCalculaFreteSugestao;
        fatVenda.pMostraMargemComFrete;
        pSetFocus(ActiveControl);

        InterlockedDecrement(intSemaforoConfirma);
      Except
        InterlockedDecrement(intSemaforoConfirma);
      End;

    End
    Else
      InterlockedDecrement(intSemaforoConfirma);

  End;
end;

procedure TfrmFatDadosFiscais.btnNotExpClick(Sender: TObject);
begin
  inherited;
  If Assigned(fatVenda) Then
    fatVenda.pSolicitaComplementoDadosExportacao;
end;

procedure TfrmFatDadosFiscais.btnVerImpostosClick(Sender: TObject);
var
  fltTotGerOriginal: Double;
begin
  inherited;

  If not btnVerImpostos.Visible Then
    Exit;

  fltTotGerOriginal := fatVenda.fltTotGer;

  pCriarFormularios(TfrmFatImpostos, frmFatImpostos);

  Try
    blnConfirma       := False;
    FblnEspRascDANFE  := True;

    pConfirma;

    if (not blnConfirma) then
      Exit;

    frmFatImpostos.fltTotGer := fStrToFloat(fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.Text);
    frmFatImpostos.fatVenda := fatVenda;
    if (fatVenda.strOpcDoc = 'GF') AND fatVenda.blnConfirmacaoEspelho then
      frmFatImpostos.cdsImpostosEspelho := cdsImpostosDigitadosItens;
    frmFatImpostos.ShowModal;
  Finally
    blnConfirma        := False;
    FblnEspRascDANFE   := False;
    fatVenda.fltTotGer := fltTotGerOriginal;
    FreeAndNil(frmFatImpostos);
  End;
end;

procedure TfrmFatDadosFiscais.edtValFreEnter(Sender: TObject);
begin
  inherited;
  pCalculaFreteSugestao;

  If (blnCalcFreteSugestaoRegia Or
      blnCalcFreteSugestaoTranp Or
      blnCalcFreteSugestaoItens Or
      blnCalcFreteSugestaoFaixa) And blnSomenExibirSugestFrete Then
  Begin
    HintControler.ShowHint(Self.Left + fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Left + fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Width,
                           15 + Self.Top + fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Top + fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Height,
                           'Valor do frete sugestão: ' + FormatFloat('#,##0.00', fatVenda.fltFreSug), '');
  End;
end;

procedure TfrmFatDadosFiscais.pCalculaFreteSugestao;
begin
  If (blnCalcFreteSugestaoRegia Or
      blnCalcFreteSugestaoTranp Or
      blnCalcFreteSugestaoItens Or
      blnCalcFreteSugestaoFaixa) And
      (not blnZeraFrete) And
      (Not fatVenda.blnNotEspVBT) Then
  Begin
    fatVenda.fltFreSugCal := 0;

    If (blnCalcFreteSugestaoTranp Or blnCalcFreteSugestaoRegia) Then
    Begin
      if fAlterouPesoBruto then
      Begin
        fatVenda.fltPesBru := fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtPesBru.Text);
        strPesBruAnt := FormatFloat('#,###0.000', fatVenda.fltPesBru);
      End;

      if fAlterouPesoLiqui then
      Begin
        fatVenda.fltPesLiq := fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtPesLiq.Text);
        strPesLiqAnt := FormatFloat('#,###0.000', fatVenda.fltPesLiq);
      End;

      fatVenda.fCalculaSugestaoFreteTransportadora(fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text, False, blnCalcFreteSugestaoRegia);
    End
    Else
    If blnCalcFreteSugestaoItens Then
      fatVenda.fCalculaSugestaoFreteProdutos(fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text)
    Else
    If blnCalcFreteSugestaoFaixa Then
      fatVenda.fCalculaSugestaoFreteFaixaFaturamento(fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text,
                                                     fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Text);
  End;
end;

procedure TfrmFatDadosFiscais.edtValFreExit(Sender: TObject);
begin
  inherited;

  HintControler.HideHint;
  //Caso nao tenha validado com o enter, entao forca a validacao na saida do edit
  If fAlterouValorFrete Then
  Begin
    //Documento de garantia alterou o frete, prevalecer a alteração do usuário
    if (fatVenda.strOpcDoc = 'GF') Or (fatVenda.strOpcDocTrue = 'NW') then
      fatVenda.blnAlterouFreteGF := True;

    If fValidaCampos(fraDadosFechamentoVendaTransportadoraFrame.edtValFre, True) Then
    Begin
      If Self.strUltimoComponenteClicado = btnConfirmaDados.Name Then
      Begin
        Self.strUltimoComponenteClicado := '';
        btnConfirmaDados.Click;
      End;
    End;
  End;
end;

procedure TfrmFatDadosFiscais.edtValIcmExit(Sender: TObject);
begin
  inherited;
  pAtualizaAlqIcm;
end;

procedure TfrmFatDadosFiscais.edtValIpiChange(Sender: TObject);
begin
  inherited;
  pExibiValImpostosiConsiginacao;
end;

procedure TfrmFatDadosFiscais.edtValRetExit(Sender: TObject);
begin
  inherited;
  If (fatVenda.strOpcDoc = 'NC') Then
    fraDadosFechamentoVendaTotaisFrame.edtCodSit.Text := fSugestaoCSTNotaComplem;
end;

{*****************************************************}
{* QUANDO FOR OUTRAS SAIDAS DEVERÁ TER O MESMO CFOP  *}
{* PARA TODOS OS ITENS                               *}
{** 21/09/2011 - 12:45 ****************************PE*}
procedure TfrmFatDadosFiscais.pAtualizaMatItensOutrasSaidas(strClaNov : String);
  Var
    intCont: Integer;
begin

  For intCont := 0 To Length(fatVenda.arrMatItens) -1 Do
  Begin
    If (fatVenda.arrMatItens[intCont].strClaFis <> strClaNov) And (Not fEmptyStr(strClaNov))  Then
      fatVenda.arrMatItens[intCont].strClaFis := strClaNov;
  End;

end;

function TfrmFatDadosFiscais.fClassFiscalZeraIcmsOuAlteraCST: Boolean;
begin
  Result := False;
  If (Pos(RightStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text,3),'915_916_') > 0) Then
    Result := True
  Else If fatVenda.fZerarIcmsNotaTransferenciaEstadosEspecificos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text) Then
    Result := True;
end;

procedure TfrmFatDadosFiscais.pAtualizarImpostosDigitadosParaMatrizItens;
  Var
    intContador : Integer;
    fltVlrProdIva : Double;
begin
  If ((btnDigImpostosItens.Visible) or (fatVenda.blnConfirmacaoEspelho)) And Assigned(cdsImpostosDigitadosItens) Then
  begin
    With fatVenda Do
    Begin
      fltTotBasPis := 0;
      fltTotBasCof := 0;
      fltTotPis    := 0;
      fltTotCof    := 0;
      fltVrdIcm    := 0;
      fltBasVrd    := 0;

      For intContador := 0 To Length(arrMatItens) -1 Do
      Begin
        If cdsImpostosDigitadosItens.Locate('ITE_AUTINC', arrMatItens[intContador].intAutInc, []) Then
        Begin
          arrMatItens[intContador].strClaFis := cdsImpostosDigitadosItens.FieldByName('ITE_CLAFIS').AsString;
          arrMatItens[intContador].strClaIpi := cdsImpostosDigitadosItens.FieldByName('ITE_CLAIPI').AsString;

          arrMatItens[intContador].fltAlqIcm := cdsImpostosDigitadosItens.FieldByName('ITE_ALQICM').AsFloat;
          arrMatItens[intContador].fltBasIcm := cdsImpostosDigitadosItens.FieldByName('ITE_BASICM').AsFloat;
          arrMatItens[intContador].fltValIcm := cdsImpostosDigitadosItens.FieldByName('ITE_VALICM').AsFloat;

          arrMatItens[intContador].fltAlqIpi := cdsImpostosDigitadosItens.FieldByName('ITE_ALQIPI').AsFloat;
          arrMatItens[intContador].fltBasIpi := cdsImpostosDigitadosItens.FieldByName('ITE_BASIPI').AsFloat;
          arrMatItens[intContador].fltValipi := cdsImpostosDigitadosItens.FieldByName('ITE_VALIPI').AsFloat;

          arrMatItens[intContador].fltBasRet := cdsImpostosDigitadosItens.FieldByName('ITE_BASRET').AsFloat;
          arrMatItens[intContador].fltAlqRet := cdsImpostosDigitadosItens.FieldByName('ITE_ALQRET').AsFloat;
          arrMatItens[intContador].fltValRet := cdsImpostosDigitadosItens.FieldByName('ITE_VALRET').AsFloat;

          arrMatItens[intContador].fltPerRed := cdsImpostosDigitadosItens.FieldByName('ITE_PERRED').AsFloat;
          arrMatItens[intContador].fltPeBaST := cdsImpostosDigitadosItens.FieldByName('ITE_PEBAST').AsFloat;
          arrMatItens[intContador].fltValIva := cdsImpostosDigitadosItens.FieldByName('ITE_VALIVA').AsFloat;

          If (strOpcDoc = 'OF') And (arrMatItens[intContador].fltValRet > 0) And (arrMatItens[intContador].fltBasIcm > 0) Then
          Begin
            fltVlrProdIva                      := arrMatItens[intContador].fltBasIcm + arrMatItens[intContador].fltValipi;
            arrMatItens[intContador].fltValIva := ((arrMatItens[intContador].fltBasRet / fltVlrProdIva) * 100) - 100;
          end;

          {FCP ST}
          If arrMatItens[intContador].fltValRet > 0 Then
          Begin
            arrMatItens[intContador].recDifalFCP.fltBasFcp := cdsImpostosDigitadosItens.FieldByName('ITE_BASFCP').AsFloat;
            arrMatItens[intContador].recDifalFCP.fltPerFcp := cdsImpostosDigitadosItens.FieldByName('ITE_PERFCP').AsFloat;
            arrMatItens[intContador].recDifalFCP.fltValFcp := cdsImpostosDigitadosItens.FieldByName('ITE_VALFCP').AsFloat;
          End;

          arrMatItens[intContador].VisualizarFcpIcmsST.fltBase     := cdsImpostosDigitadosItens.FieldByName('ITE_BASFCP').AsFloat;
          arrMatItens[intContador].VisualizarFcpIcmsST.fltAliquota := cdsImpostosDigitadosItens.FieldByName('ITE_PERFCP').AsFloat;
          arrMatItens[intContador].VisualizarFcpIcmsST.fltValor    := cdsImpostosDigitadosItens.FieldByName('ITE_VALFCP').AsFloat;

          {FCP}
          arrMatItens[intContador].VisualizarFcpIcms.fltBase     := cdsImpostosDigitadosItens.FieldByName('ITE_BASFCP_').AsFloat;
          arrMatItens[intContador].VisualizarFcpIcms.fltAliquota := cdsImpostosDigitadosItens.FieldByName('ITE_PERFCP_').AsFloat;
          arrMatItens[intContador].VisualizarFcpIcms.fltValor    := cdsImpostosDigitadosItens.FieldByName('ITE_VALFCP_').AsFloat;

          arrMatItens[intContador].fltAlqPis := cdsImpostosDigitadosItens.FieldByName('ITE_ALQPIS').AsFloat;
          arrMatItens[intContador].fltBasPis := cdsImpostosDigitadosItens.FieldByName('ITE_BASPIS').AsFloat;
          arrMatItens[intContador].fltValPis := cdsImpostosDigitadosItens.FieldByName('ITE_VALPIS').AsFloat;
          arrMatItens[intContador].strCSTPis := cdsImpostosDigitadosItens.FieldByName('ITE_CSTPIS').AsString;

          arrMatItens[intContador].fltAlqCof := cdsImpostosDigitadosItens.FieldByName('ITE_ALQCOF').AsFloat;
          arrMatItens[intContador].fltBasCof := cdsImpostosDigitadosItens.FieldByName('ITE_BASCOF').AsFloat;
          arrMatItens[intContador].fltValCof := cdsImpostosDigitadosItens.FieldByName('ITE_VALCOF').AsFloat;
          arrMatItens[intContador].strCSTCof := cdsImpostosDigitadosItens.FieldByName('ITE_CSTCOF').AsString;
          arrMatItens[intContador].strCodFis := cdsImpostosDigitadosItens.FieldByName('ITE_CODSIT').AsString;

          arrMatItens[intContador].fltBasVrd := cdsImpostosDigitadosItens.FieldByName('ITE_BASVRD').AsFloat;
          arrMatItens[intContador].fltVrdIcm := cdsImpostosDigitadosItens.FieldByName('ITE_VRDICM').AsFloat;
          arrMatItens[intContador].strMtdIcm := cdsImpostosDigitadosItens.FieldByName('ITE_MTDICM').AsString;

         If fatVenda.fEhDevolucaoEspelhoOuParaFornecedor Then
            arrMatItens[intContador].strClaFis := cdsImpostosDigitadosItens.FieldByName('ITE_CLAFIS').AsString;

          If (arrMatItens[intContador].fltVrdIcm > 0) And (not fatVenda.blnClienteZonaFrancaComDescontoEspecial) And
             (Pos(Copy(arrMatItens[intContador].strCodFis, 2, 2), '30_40_41_50_') > 0) And
             (cdsImpostosDigitadosItens.FieldByName('ITE_DESONE').AsString = 'Sim') Then
          Begin
            fltBasIcm := fltBasIcm - arrMatItens[intContador].fltBasIcm;
            fltTotIcm := fltTotIcm - arrMatItens[intContador].fltValIcm;

            If blnNotImp Then
            Begin
              pRetornaConfiguracoesParaNotaDeImportacaoDesonerada(Copy(arrMatItens[intContador].strCodFis, 2, 2));

              If Copy(arrMatItens[intContador].strCodFis, 2, 2) = '50' Then
              Begin
                arrMatItens[intContador].strCSTIpi := recConfiguracaoNotaDeImportacaoDesonerada.strCstIpi;
                arrMatItens[intContador].strEnqIpi := recConfiguracaoNotaDeImportacaoDesonerada.strEnqIpi;
                arrMatItens[intContador].fltAlqIpi := 0;
                arrMatItens[intContador].fltBasIpi := 0;
                arrMatItens[intContador].fltValipi := 0;
              End;

              If arrMatItens[intContador].fltVal_II = 0 Then
              Begin
                arrMatItens[intContador].fltBaseII := 0;
                arrMatItens[intContador].fltDesAdu := 0;
                arrMatItens[intContador].fltValIof := 0;
              End;

              If arrMatItens[intContador].fltValPis = 0 Then
              Begin
                arrMatItens[intContador].strCSTPis := recConfiguracaoNotaDeImportacaoDesonerada.strCstPis;
                arrMatItens[intContador].fltAlqPis := 0;
                arrMatItens[intContador].fltBasPis := 0;
              End;

              If arrMatItens[intContador].fltValCof = 0 Then
              Begin
                arrMatItens[intContador].strCSTCof := recConfiguracaoNotaDeImportacaoDesonerada.strCstCof;
                arrMatItens[intContador].fltAlqCof := 0;
                arrMatItens[intContador].fltBasCof := 0;
              End;
            End;

            fatVenda.pZerarDadosIcmsMatrizItens(False, intContador);
          End;

          arrMatItens[intContador].fltAlqIcmImp := arrMatItens[intContador].fltAlqIcm;
          arrMatItens[intContador].fltBasIcmImp := arrMatItens[intContador].fltBasIcm;
          arrMatItens[intContador].fltValIcmImp := arrMatItens[intContador].fltValIcm;

          arrMatItens[intContador].fltAlqIpiImp := arrMatItens[intContador].fltAlqIpi;
          arrMatItens[intContador].fltBasIpiImp := arrMatItens[intContador].fltBasIpi;
          arrMatItens[intContador].fltValIpiImp := arrMatItens[intContador].fltValIpi;

          arrMatItens[intContador].fltBasRetImp := arrMatItens[intContador].fltBasRet;
          arrMatItens[intContador].fltValRetImp := arrMatItens[intContador].fltValRet;

          fltVrdIcm := fltVrdIcm + arrMatItens[intContador].fltVrdIcm;
          fltBasVrd := fltBasVrd + arrMatItens[intContador].fltBasVrd;

          If (not fatVenda.blnClienteZonaFrancaComDescontoEspecial) Then
          Begin
            arrMatItens[intContador].fltVlrCon := arrMatItens[intContador].fltVlrCon - arrMatItens[intContador].fltVrdIcm;
            fltTotGer := fltTotGer - arrMatItens[intContador].fltVrdIcm;
          End;

          fltTotBasPis := fltTotBasPis + arrMatItens[intContador].fltBasPis;
          fltTotBasCof := fltTotBasCof + arrMatItens[intContador].fltBasCof;
          fltTotPis    := fltTotPis    + arrMatItens[intContador].fltValPis;
          fltTotCof    := fltTotCof    + arrMatItens[intContador].fltValCof;
        End;
      End;

      If (not fatVenda.blnClienteZonaFrancaComDescontoEspecial) And  (fltVrdIcm > 0) Then
      Begin
        fatVenda.fltAlqIcm := fFormataFloat((fltVrdIcm / fltBasVrd) * 100, 2);
        pAtualizaRodape;
      End;
    End;
  end;
end;

procedure TfrmFatDadosFiscais.pRateiaValorTaxaSiscomexNosItens;
  Var
    intCont: Integer;
    fltTotalProdutos : Double;
    fltPercRepresent : Double;
    fltTotRatSiscomex: Double;
begin
  If Length(fatVenda.arrMatItens) = 0 Then
    Exit;

  fltTotalProdutos  := 0;
  fltTotRatSiscomex := 0;

  For intCont := 0 To Length(fatVenda.arrMatItens) -1 Do
    fltTotalProdutos := fltTotalProdutos + fatVenda.arrMatItens[intCont].fltTotIte;

  For intCont := 0 To Length(fatVenda.arrMatItens) -1 Do
  Begin
    fltPercRepresent := fatVenda.arrMatItens[intCont].fltTotIte / fltTotalProdutos;

    fatVenda.arrMatItens[intCont].fltImpTax := fFormataFloat(fatVenda.fltImpTax * fltPercRepresent, 2);

    fltTotRatSiscomex := fltTotRatSiscomex + fatVenda.arrMatItens[intCont].fltImpTax;
  End;

  fatVenda.arrMatItens[0].fltImpTax :=
    fatVenda.arrMatItens[0].fltImpTax + (fatVenda.fltImpTax - fltTotRatSiscomex);
end;

function TfrmFatDadosFiscais.fAlterouDespesasAcessoria: Boolean;
begin
  Result := fEmptyStr(strDesAceAnt) Or (fStrToFloat(strDesAceAnt) <> fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text));
end;

function TfrmFatDadosFiscais.fAlterouPesoBruto: Boolean;
begin
  Result := (Not fEmptyStr(strPesBruAnt)) And (fStrToFloat(strPesBruAnt) <> fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtPesBru.Text));
end;

function TfrmFatDadosFiscais.fAlterouPesoLiqui: Boolean;
begin
  Result := (Not fEmptyStr(strPesLiqAnt)) And (fStrToFloat(strPesLiqAnt) <> fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtPesLiq.Text));
end;

function TfrmFatDadosFiscais.fAlterouValorFrete: Boolean;
begin
  Result := fEmptyStr(strValFreAnt) Or (fStrToFloat(strValFreAnt) <> fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text));
end;

function TfrmFatDadosFiscais.fAlterouValorFreteCotado: Boolean;
begin
  Result := fEmptyStr(strValFreCotAnt) Or (fStrToFloat(strValFreCotAnt) <> fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFreCot.Text));
end;

function TfrmFatDadosFiscais.fApresentaTelaParaReferenciarNota: Boolean;
begin
  Result := fApresentaTelaParaReferenciarNotaParaExportacao Or
            fApresentaTelaParaReferenciarNotaOutrasSaidas Or
            fApresentaTelaParaReferenciarNotaExpedicao;
end;

function TfrmFatDadosFiscais.fApresentaTelaParaReferenciarNotaExpedicao: Boolean;
begin
  Result := True;

  If Not (blnExpedicao) Then
    Exit(False);

  If Not (fCfgSis('EXIRDE', varBoolean)) Then
    Exit(False);

  If Not (Assigned(fatVenda)) then
    Exit(False);

  if (Pos(fatVenda.strEspDoc, 'NF_IF_') <= 0) then
    Exit(False);
end;

function TfrmFatDadosFiscais.fApresentaTelaParaReferenciarNotaOutrasSaidas: Boolean;
begin
  Result := True;

  If Not (Assigned(fatVenda)) then
    Exit(False);

  If Not (Pos(fatVenda.strOpcDoc, 'OU_OV_OF_') > 0) Then
    Exit(False);

  If Not (Pos(fatVenda.strEspDoc, 'NF') > 0) then
    Exit(False);
end;

function TfrmFatDadosFiscais.fApresentaTelaParaReferenciarNotaParaExportacao: Boolean;
begin
  Result := True;

  if (not Assigned(fatVenda)) then
    Exit(False);

  if (fatVenda.strCliEst <> 'EX') then
    Exit(False);

  if (Pos(fatVenda.strEspDoc, 'NF_IF_') <= 0) then
    Exit(False);

  if (fEhNotaOriginadaDaExpedicaoComSolicitacaoDeNotaReferenciada) then
    Exit;

  if (fEhNotaEspecialComSolicitacaoDeNotaReferenciada) then
    Exit;

  if (fEhVendaNormalFechadaEmDocumentoFiscalComSolicitacaoDeNotaReferenciada) then
    Exit;

  if (fEhVendaNormalFechadaEmNotaEspecialComSolicitacaoDeNotaReferenciada) then
    Exit;

  Result := False;
end;

function TfrmFatDadosFiscais.fAlterouClassificacaoFiscal: Boolean;
begin
  Result := fEmptyStr(strClaFisAnt) Or (strClaFisAnt <> fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text);
end;

procedure TfrmFatDadosFiscais.pValidaClassificacaoFiscalQuandoDesabilitada;
begin
  If (Not fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled) Or fClassFiscalZeraIcmsOuAlteraCST Then
    fValidaCampos(fraDadosFechamentoVendaClaFisFrame.edtClaFis, True);

  If Pos(fatVenda.strOpcDoc,'CO_MF_') > 0 Then
    pCarregaCadCfo(fraDadosFechamentoVendaClaFisFrame.edtClaFis, True);
end;

procedure TfrmFatDadosFiscais.pCalculaTotalBombeamento;
begin
  fatVenda.fltQtdBom := 0.0;
  fatVenda.fltPrcBom := 0.0;
  fatVenda.fltTotBom := 0.0;

  If pnlBombeamento.Visible Then
  Begin
    If fatVenda.tbIteBom = tbItemBombeamento Then
    Begin
      fatVenda.fltQtdBom := fStrToFloat(fraDadosFechamentoVendaBombeamentoFrame.edtQtdBom.Text);
      fatVenda.fltPrcBom := fStrToFloat(fraDadosFechamentoVendaBombeamentoFrame.edtPrcBom.Text);
      fatVenda.fltTotBom := fFormataFloat(fatVenda.fltQtdBom * fatVenda.fltPrcBom, 2);

      fraDadosFechamentoVendaBombeamentoFrame.edtTotBom.Text := FormatFloat('#,##0.00', fatVenda.fltTotBom);
    End
    Else
    Begin
      fatVenda.fltQtdBom := fStrToFloat(fraDadosFechamentoVendaBombeamentoFrame.edtQtdBom.Text);
      fatVenda.fltTotBom := fStrToFloat(fraDadosFechamentoVendaBombeamentoFrame.edtTotBom.Text);

      If fatVenda.fltQtdBom <> 0 Then
        fatVenda.fltPrcBom := fFormataFloat(fatVenda.fltTotBom / fatVenda.fltQtdBom, fatVenda.VS_intDecUni)
      Else
        fatVenda.fltPrcBom := 0.0;

      fraDadosFechamentoVendaBombeamentoFrame.edtPrcBom.Text := FormatFloat(fMskDigitos(fatVenda.VS_intDecUni), fatVenda.fltPrcBom);
    End;
  End;
end;

function TfrmFatDadosFiscais.fSeExpedicaoPermiteAlterarValorFrete(strCodTraPed, strCodTraNov: String;
   fltValFrePed, fltValFreNov: Double): Boolean;
begin
  If (blnExpedicao) Then
  Begin
    If (fCfgSis('DFEXAF', varBoolean)) Then
    Begin
      Result := True;
    End
    Else
    Begin
      If (fFormataFloat(fltValFrePed,2) <> fFormataFloat(fltValFreNov,2)) Then
      Begin
        objLiberacao.Clear;
        objLiberacao.strDirAce    := 'PMFRDEFXAF';
        objLiberacao.strMsgSen    := 'Alterarção de Frete';
        objLiberacao.strCodOpe    := strLoginUsuarioLogado;
        objLiberacao.objMsgLibera.pAddTexto('Permitir alterar o valor do frete na tela dos dados fiscais da expedição?');
        objLiberacao.objMsgLibera.pAddTexto('Sistema configurado para não permitir alterar o frete definido no pedido de venda (CFG_DFEXAF)!');
        objLiberacao.objMsgLibera.pAddSeparador(95);
        objLiberacao.objMsgLibera.pAddTexto('');
        objLiberacao.objMsgLibera.pAddTexto('Transportadora do Pedido: '+strCodTraPed+'-'+fRetNomTransportadora(strCodTraPed));
        objLiberacao.objMsgLibera.pAddTexto('Frete do Pedido: '+FormatFloat('#,##0.00', fFormataFloat(fltValFrePed,2)));
        objLiberacao.objMsgLibera.pAddTexto('');
        objLiberacao.objMsgLibera.pAddTexto('Nova Transportadora: '+strCodTraNov+'-'+fRetNomTransportadora(strCodTraNov));

        objLiberacao.objMsgLibera.pAddTexto('Novo Frete: '+FormatFloat('#,##0.00', fFormataFloat(fltValFreNov,2)));

        Result := objLiberacao.fLibera;
      End
      Else
      Begin
        Result := False;
      End;
    End;
  End
  Else
  Begin
    Result := True;
  End;
end;

procedure TfrmFatDadosFiscais.pCalculaTotalGeral;
  Var
    blnPegaClassificacaoItem : Boolean;
    blnAplicouClassificacoesDaTela : Boolean;
begin
  // Req. 450881: no modo somente-visualizacao do espelho de devolucao (SEM AD) a matriz fiscal
  // ja esta calculada refletindo a nota de origem; recalcular aqui zera ICMS/CST. Nao recalcular.
  if blnOrigemEntradaDV then
    Exit;
  blnPegaClassificacaoItem := True;

  If (fatVenda.strCliEst = 'EX') Then
    blnPegaClassificacaoItem := False;

  If ((blnMudouClassificacao) And (fOutrasSaidasAbreviacaoIpi)) or (fatVenda.blnConfirmacaoEspelho) Then
    blnPegaClassificacaoItem := False;

  If blnMudouClassificacao And fEhOutrasSaidasDeFornecedorDevolucao Then
    blnPegaClassificacaoItem := False;

  If blnPegaClassificacaoItem And blnMudouClassificacao And fTransferenciaDeMarcadoriasValidandoEnquadramentoDeIPI(fatVenda.strOpcDoc, fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text) Then
    blnPegaClassificacaoItem := False;

  If blnPegaClassificacaoItem And blnMudouClassificacao And fZeraImpostoFaturaConsignacao(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text) Then
    blnPegaClassificacaoItem := False;

  If fatVenda.fEhDevolucaoParaFornecedorQueAbasteceEmpresaPorTransferenciaDeEstoque(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text) Then
    blnPegaClassificacaoItem := False;

  If blnMudouClassificacao And fPreValidacaoDeProdutoRevendaDentroDoEstado(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text) Then
    blnPegaClassificacaoItem := False;

  If blnPegaClassificacaoItem And blnMudouClassificacao And fatVenda.blnClienteZonaFrancaComDescontoEspecial Then
    blnPegaClassificacaoItem := False;

  If blnPegaClassificacaoItem And blnMudouClassificacao And fatVenda.fEhClassificacaoFiscalParaRemessaDeIndustrializacao(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text) Then
    blnPegaClassificacaoItem := False;

  If blnPegaClassificacaoItem And blnMudouClassificacao And fatVenda.fEhClassificacaoFiscalParaBaixaDeEstoqueDecorrenteDePerdaRouboOuDeterioracao(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text) Then
    blnPegaClassificacaoItem := False;

  If blnPegaClassificacaoItem And blnMudouClassificacao And  fNotaEspecialCfopOutrasSaidas Then
    blnPegaClassificacaoItem := False;

  If blnPegaClassificacaoItem And blnMudouClassificacao And fExiteClassificacaoDeOutrasSaidasDeFornecedor Then
    blnPegaClassificacaoItem := False;

  if fNotaEspecialAbreviacaoIpi then
    blnPegaClassificacaoItem := False;

  if fNotaEspecialDevolucao then
    blnPegaClassificacaoItem := False;

  if blnPegaClassificacaoItem And fatVenda.fNotaEspecialCST_X90(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text) then
    blnPegaClassificacaoItem := False;

  blnAplicouClassificacoesDaTela := (FUsuarioAlterouClassificacaoReforma) And (fDeveAtualizarOsTotaisEmTela) And (fAplicouClassificacoesDaTelaNaMatriz);
  If blnAplicouClassificacoesDaTela Then
    blnPegaClassificacaoItem := False;

  {*****************************************************************}
  {* ATRIBUI OS VALORES DOS EDITS PARA AS VARIAVEIS DO FATURAMENTO *}
  {**************************************************************JC*}
  If (pnlBombeamento.Visible) And (fraDadosFechamentoVendaBombeamentoFrame.edtRedISS.Visible) Then
    fatVenda.fltRedIss := fStrToFloat(fraDadosFechamentoVendaBombeamentoFrame.edtRedISS.Text);

  fatVenda.fltDesAce := fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text);
  if (blnNotImpXML) then
  begin
    fatVenda.fltOutros := fSomaOutrasDespesasImportacaoDefinidoConfiguracao;
    fraDadosFechamentoVendaTransportadoraFrame.edtOutros.Text := FormatFloat('#,##0.00', fatVenda.fltOutros);
  end;

  fatVenda.fltValFre := fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text);

  fatVenda.fltFreDig := fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text);
  fatVenda.fltDeADig := fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text);

  if (fraDadosFechamentoVendaTransportadoraFrame.edtValFreCot.Visible) then
  begin
    fatVenda.fltFreCot := fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFreCot.Text);
  end;

  If fatVenda.blnEspelhoDevolucaoClienteFatDadosFiscais Then
    blnPegaClassificacaoItem := False;

  {***************************************************************}
  {* CALCULA O VALOR TOTAL DO BOMBEAMENTO DE CONCRETO (PRESTCON) *}
  {************************************************************JC*}
  pCalculaTotalBombeamento;

  strInfoProcessamento := 'Aguarde, Calculando valor - %s ...';

  pnlProgresso.Visible := True;

  fatVenda.pCalculaTotGer(False, True, pOnProcessaItem, blnPegaClassificacaoItem);

  If blnAplicouClassificacoesDaTela Then
  Begin
    fatVenda.strClaFis := fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text;
    fatVenda.strClaFi2 := fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text;
    fatVenda.strClaFi3 := fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text;
  End;

  If Assigned(pAfterCalcTotGer) Then
    pAfterCalcTotGer;

  pnlProgresso.Visible := False;

  {********************************************************************}
  {* SALVA O VALOR DO IPI E ST ORIGINAL PARA DESCONTAR DO TOTAL GERAL *}
  {*****************************************************************JC*}
  fltTotIpiOri := fatVenda.fltTotIpi;
  fltTotRetOri := fatVenda.fltTotRet;

  pAtualiza_fltRet_Sp;

  {********************************************************}
  {* DESCONTA O VALOR DO IPI E ST ORIGINAL DO TOTAL GERAL *}
  {*****************************************************JC*}
  fatVenda.fltTotGer := fatVenda.fltTotGer - fltTotIpiOri;
  fatVenda.fltTotGer := fatVenda.fltTotGer - fltTotRetOri;

  {**************************************************}
  {* ATUALIZA OS EDITS DE IMPOSTOS E DE TOTAL GERAL *}
  {***********************************************JC*}
  pAtualizaEditsImpostos;
  pAtualizaRodape;

  pAtualizaImpostosClassificacaoFiscal;
end;

procedure TfrmFatDadosFiscais.pCalcVolumeSepExclusiva;
begin
  fraDadosFechamentoVendaTransportadoraFrame.edtQtdTraSepExc.Text :=
    FloatToStrF(fatVenda.fRetVolumesSepExc, ffFixed, 12, 0);

  fraDadosFechamentoVendaTransportadoraFrame.edtQtdTraSepNExc.Text :=
    FloatToStrF(fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtQtdTra.Text) -
                fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtQtdTraSepExc.Text),
                ffFixed, 12, 0);
end;

procedure TfrmFatDadosFiscais.pOnProcessaItem(const item: TDadosFechamento;
  index, count: Integer; AInfo: String = '');
begin
  If AInfo.IsEmpty Then
    AInfo := strInfoProcessamento;
  pRegistrarProgresso(Format(AInfo, [item.strCodIte + '-' + fPadR(item.strDesIte, 35)]),
    lblProgresso, pgbProgresso, 0, Succ(index), count);
end;

function TfrmFatDadosFiscais.fDefineTipoDeFreteNoFaturamento: Boolean;
Begin
  Result := fatVenda.fPermitirFreteNoFaturamento;

  If (not Result) And (Pos(fatVenda.strOpcDoc, 'OU_OF_OV_OE_') > 0) And (fatVenda.fltValFre > 0) Then
    Result := True;
End;

function TfrmFatDadosFiscais.fDesabilitarPreenchimentoClassificacaoFiscal: Boolean;
begin
  Result := True;

  If (Pos(fatVenda.strEspDoc,'NF_EL_NS_') <= 0) Then
    Exit;

  If ((Not fCfgSis('ALCFCF', VarBoolean)) And //Quando configurado para nao permitir alterar a CFOP para cliente filial
     (fatVenda.blnCliFil) And (fRetornaClienteFilial(VS_strCodEmp) <> fatVenda.strCodCli)) Then
    Exit;

  If (fatVenda.blnEstornoNotaFiscalEntregaFutura) Then
    Exit;

  Result := False;
end;

procedure TfrmFatDadosFiscais.pDefineTipoDeFreteNoFaturamento;
  Var
    strLocalTipFre : String;
begin
  If (Not fDefineTipoDeFreteNoFaturamento) Then
    Exit;

  strLocalTipFre := fatVenda.fRetornaTipFre;

  If (fEmptyStr(strLocalTipFre)) Then
    Exit;

  fatVenda.strTipFre := fatVenda.fRetornaTipFre;
end;

procedure TfrmFatDadosFiscais.pOnShow;
  Var
    strTipFat   : String;
    fltPerDesAce: Double;
    fltVlrDesAce: Double;
    fltParDesAce: Double; //Valor por Condição a Prazo
    fltValFcpICMS: Double;
    fltBasFcpICMS: Double;
    fltPerFcpICMS: Double;
    blnMenExpVisible: Boolean;
    fltValFreSugNovo: Double;
    LValorFretePixRecebido: Double;

  function fDeveAlterarDespesasAcessorias():Boolean;
  begin
    Result := (Pos(fatVenda.strOpcDoc, 'CI_CT_CP_CS_DV_PR_DD_CR_' + IIF(fatVenda.fltDesAce > 0, 'CF_', '')) <= 0) And
              (fatVenda.strNotImp = 'N') And
              (not fatVenda.fRecebidoPorPix) And
              (Not ((fatVenda.fltDesAce > 0) And (fatVenda.strOpcDocTrue = 'BF')));
  end;

begin
  fraDadosFechamentoVendaTransportadoraFrame.OnFormShow;

  If fVerificaAcessoSistema('VEIMNF', strLoginUsuarioLogado) Then
    btnVerImpostos.Visible := True
  Else
    btnVerImpostos.Visible := False;

  if fVerificaAcessoSistema('VESRNF', strLoginUsuarioLogado) then
    btnEspRascNF.Visible := True;

  if blnEhNotaEspecialFatorPorValor then
    btnEspRascNF.Visible := False;

  If (fatVenda.strOpcDoc = 'NC') Then
  Begin
    btnVerImpostos.Visible := False;
    btnEspRascNF.Visible   := fCfgSis('ESPNFE', VarBoolean);
  End;

  fraDadosFechamentoVendaTotaisFrame.lblPerDif.Visible  := False;
  fraDadosFechamentoVendaTotaisFrame.lblValDif.Visible  := False;
  fraDadosFechamentoVendaTotaisFrame.edtPerDif.Visible  := False;
  fraDadosFechamentoVendaTotaisFrame.edtValDif.Visible  := False;
  fraDadosFechamentoVendaTotaisFrame.edtPerDif.ReadOnly := True;
  fraDadosFechamentoVendaTotaisFrame.edtValDif.ReadOnly := True;

  LValorFretePixRecebido := fatVenda.fltValFre;

  blnCalcFreteSugestaoRegia := (fCfgSis('FRETRA') = FRETRA_POR_TRANSPORTADORA_REGIAO) And (Pos(fatVenda.strOpcDoc, 'OF_OE_EF_NC_GF_' + IIF(fatVenda.blnNEFornecedor, 'NE_', '') ) <= 0) And (Not blnNotImp);
  blnCalcFreteSugestaoTranp := (fCfgSis('FRETRA') = FRETRA_POR_TRANSPORTADORA_CIDADE) And (Not blnNotImp);
  blnCalcFreteSugestaoItens := (fCfgSis('FRETRA') = FRETRA_POR_PRODUTOS_ADICIONAL_TRANSPORTADORA) And (Not blnNotImp);
  blnCalcFreteSugestaoFaixa := (fCfgSis('FRETRA') = FRETRA_POR_FAIXA_FATURAMENTO) And (Not blnNotImp) And (Pos(fatVenda.strOpcDoc, 'CF_') <= 0);
  blnSomenExibirSugestFrete := (fCfgSis('SUGFRE') = '2');

  If (fatVenda.strOpcDoc = 'NC') Then
  Begin
    blnCalcFreteSugestaoRegia := False;
    blnCalcFreteSugestaoTranp := False;
    blnCalcFreteSugestaoItens := False;
    blnCalcFreteSugestaoFaixa := False;
  End;

  btnMostraMargem.Visible := (Pos(fatVenda.strOpcDoc, 'VN_OR_PD_CP_') > 0) And
                             (blnCalcFreteSugestaoRegia Or
                              blnCalcFreteSugestaoTranp Or
                              blnCalcFreteSugestaoItens Or
                              blnCalcFreteSugestaoFaixa)And
                             (fVerificaAcessoSistema('VIMLF4'));

  blnMostraFreteCotado := (fCfgSis('TRACOT', varBoolean)) and (Pos(fatVenda.strClaFis, VS_strClaVen) > 0) and (Pos(fatVenda.strClaFis, VS_strClaDev) <= 0);

  {Libera edição dos campos Redução de Base de Cálculo de ISS e Base ISS}
  fraDadosFechamentoVendaBombeamentoFrame.edtRedISS.Visible := False;
  fraDadosFechamentoVendaBombeamentoFrame.lblRedISS.Visible := False;
  If (fatVenda.fEhVendaConcreto) And (fCfgSis('TPNFCR') = J_A_MASSA_CONCRETO) And (fatVenda.strOpcDoc = 'CN') Then
  Begin
    fraDadosFechamentoVendaBombeamentoFrame.edtRedISS.Visible := True;

    {Pega percentual de redução das configurações
     para mostrar no edit em tela}
    fatVenda.pDefineAliquotaIss;
    fraDadosFechamentoVendaBombeamentoFrame.edtRedISS.Text    := fatVenda.fltRedIss.ToString();

    fraDadosFechamentoVendaBombeamentoFrame.lblRedISS.Visible := True;

    fraDadosFechamentoVendaTotaisFrame.edtBasIss.Enabled := True;

  End;

  If (fatVenda.fEhVendaConcreto) And (fCfgSis('TPNFCR') = J_A_MASSA_CONCRETO) Then
    pnlDadSer.Visible := True
  Else
    pnlDadSer.Visible := ((fCfgSis('NFESER', varBoolean)) Or (FatVenda.strOpcDoc = 'CN')) And (FatVenda.strEspDoc = 'NS');

  fraDadosFechamentoVendaTransportadoraFrame.chkEst_Dv.Visible := Pos(fatVenda.strOpcDoc, 'DV_EF_OE_') > 0;
  If fraDadosFechamentoVendaTransportadoraFrame.chkEst_Dv.Visible Then
    fraDadosFechamentoVendaTransportadoraFrame.chkEst_Dv.Checked := fatVenda.blnEst_Dv;

  fraDadosFechamentoVendaTransportadoraFrame.chkRetornoPorRecusa.Visible := (fatVenda.strOpcDoc = 'DV');
  If fraDadosFechamentoVendaTransportadoraFrame.chkRetornoPorRecusa.Visible Then
    fraDadosFechamentoVendaTransportadoraFrame.chkRetornoPorRecusa.Checked := fatVenda.blnRetornoPorRecusa;

  //Prestcon - Taxa de Bombeamento na confirmacao de notas de concreto
  pnlBombeamento.Visible := pnlDadSer.Visible And (FatVenda.strOpcDoc = 'CN');

  If Not pnlBombeamento.Visible Then
  Begin
    If (fatVenda.fEhVendaConcreto) And (fCfgSis('TPNFCR') = J_A_MASSA_CONCRETO) Then
    Begin

      {Se carregou PD para faturar não precisa mostrar a taxa,
       pois não terá taxa na nota de remessa (NF), somente na NS!}
      If (fatVenda.strOpcDoc = 'VN') And (fatVenda.strEspDoc = 'NF') Then
        pnlBombeamento.Visible := False
      Else
      Begin

        pnlBombeamento.Visible := True;

        If (fatVenda.fltQtdBom > 0) Then
          fraDadosFechamentoVendaBombeamentoFrame.edtQtdBom.Text := FormatFloat('#,##0.00', fatVenda.fltQtdBom);
        If (fatVenda.fltPrcBom > 0) Then
          fraDadosFechamentoVendaBombeamentoFrame.edtPrcBom.Text := FormatFloat('#,##0.00', fatVenda.fltPrcBom);
        If (fatVenda.fltTotBom > 0) Then
          fraDadosFechamentoVendaBombeamentoFrame.edtTotBom.Text := FormatFloat('#,##0.00', fatVenda.fltTotBom);

      End;

    End;

  End;

  pnlProjeto.Visible := (FatVenda.strOpcDoc <> 'DV') And
                        TProjeto.fClienteTemProjetoAtivo(fatVenda.strCodCli);

  If pnlProjeto.Visible Then
  Begin
    If Not fEmptyStr(fatVenda.strCodPrj) Then
    Begin
      fraDadosFechamentoVendaProjetoFrame.edtCodPrj.Text := fatVenda.strCodPrj;
      fValidaCampos(fraDadosFechamentoVendaProjetoFrame.edtCodPrj);
    End;
  End;

  fraDadosFechamentoVendaBombeamentoFrame.edtPrcBom.EditFormat := fMskDigitos(fatVenda.VS_intDecUni);

  If pnlBombeamento.Visible And MatchStr(fCfgSis('TPNFCR'),[SECOL, J_A_MASSA_CONCRETO]) Then
    fatVenda.pCarregaTaxaBombeamentoPedOrc;

  If (fatVenda.fltQtdBom > 0) And
     (fatVenda.fltPrcBom > 0) And
     (fatVenda.fltTotBom > 0) And
     (pnlBombeamento.Visible) Then
  Begin
    fraDadosFechamentoVendaBombeamentoFrame.edtPrcBom.Text    := FormatFloat(fMskDigitos(fatVenda.VS_intDecUni), fatVenda.fltPrcBom);
    fraDadosFechamentoVendaBombeamentoFrame.edtQtdBom.Text    := FormatFloat('#,##0.00', fatVenda.fltQtdBom);
    fraDadosFechamentoVendaBombeamentoFrame.edtTotBom.Text    := FormatFloat('#,##0.00', fatVenda.fltTotBom);

    {Não vai ter taxa mínima na JA!}
    If (fCfgSis('TPNFCR') = J_A_MASSA_CONCRETO) Then
    Begin
      fraDadosFechamentoVendaBombeamentoFrame.chkTaxMin.Checked := False;
      fraDadosFechamentoVendaBombeamentoFrame.chkTaxMin.Visible := False;
      fatVenda.tbIteBom := tbItemBombeamento;
    End
    Else
      fraDadosFechamentoVendaBombeamentoFrame.chkTaxMin.Checked := IIF(fatVenda.tbIteBom = tbTaxaMinima, True, False);

  End
  Else
    fatVenda.tbIteBom := tbItemBombeamento;

  If pnlBombeamento.Visible And (fCfgSis('TPNFCR') = SECOL) Then
  Begin
    fraDadosFechamentoVendaBombeamentoFrame.edtQtdBom.ReadOnly := True;
    fraDadosFechamentoVendaBombeamentoFrame.edtPrcBom.ReadOnly := True;
    fraDadosFechamentoVendaBombeamentoFrame.edtTotBom.ReadOnly := True;
    fraDadosFechamentoVendaBombeamentoFrame.chkTaxMin.Enabled  := False;
  End;

  If (pnlDadSer.Visible) Then
  Begin
    fraDadosFechamentoVendaObraFrame.edtCodObr.Text := fatVenda.strCodObr;
    fraDadosFechamentoVendaObraFrame.edtCodART.Text := fatVenda.strCodArt;
    fraDadosFechamentoVendaObraFrame.edtCodCno.Text := fatVenda.strCodCno;
    fraDadosFechamentoVendaObraFrame.edtInsImo.Text := fatVenda.strInsImo;
    fraDadosFechamentoVendaObraFrame.edtCodCib.Text := fatVenda.strCodCib;
  End
  Else
  Begin
    fraDadosFechamentoVendaObraFrame.edtCodObr.Clear;
    fraDadosFechamentoVendaObraFrame.edtCodART.Clear;
    fraDadosFechamentoVendaObraFrame.edtCodCno.Clear;
    fraDadosFechamentoVendaObraFrame.edtInsImo.Clear;
    fraDadosFechamentoVendaObraFrame.edtCodCib.Clear;
  End;

  If blnNotImp Then
  Begin
    fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.Color       := $00FFDFB8;
    fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.NormalColor := $00FFDFB8;
    fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.FocusColor  := $00FFDFB8;
    pAtualizaDadosAdicionaisNotImp;
  End;

  pAjustaMensagens(fatVenda.strOpcDoc);

  pNotaEspecialComplementarDeIPI;

  pSetaClassificacaoParaNotaDeImportacao;

  btnDadAdi.Visible  := blnNotImp;

  If fatVenda.objNfeComplemento.tncTipoNota in [tncRestIcmsStEstoque, tncEstornoDeCredito] Then
    fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.ReadOnly := False
  Else
    fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.ReadOnly := True {(Not blnNotImp)};

  fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.TabStop := Not fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.ReadOnly;
  If Not fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.ReadOnly Then
    fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.FocusColor := clWindow;

  {*****************************************}
  {* CASO FOR NOTA DE COMPLEMENTO, DESABI- *}
  {* LITA O FRETE                          *}
  {**************************************MV*}
  If fatVenda.strOpcDoc = 'NC' Then
  Begin
    fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Enabled := False;
    fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Enabled := False;

    fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Enabled := True;
    fraDadosFechamentoVendaTotaisFrame.edtValIcm.Enabled := True;
    fraDadosFechamentoVendaTotaisFrame.edtBasIpi.Enabled := True;
    fraDadosFechamentoVendaTotaisFrame.edtValIpi.Enabled := True;
    fraDadosFechamentoVendaTotaisFrame.edtBasRet.Enabled := True;
    fraDadosFechamentoVendaTotaisFrame.edtValRet.Enabled := True;
    fraDadosFechamentoVendaTotaisFrame.edtBasFCPST.Enabled := True;
    fraDadosFechamentoVendaTotaisFrame.edtValFCPST.Enabled := True;
    fraDadosFechamentoVendaTotaisFrame.edtAlqFCPST.Enabled := True;

    fraDadosFechamentoVendaTotaisFrame.lblAlqIcm.Visible := True;
    fraDadosFechamentoVendaTotaisFrame.edtAlqIcm.Visible := True;
    fraDadosFechamentoVendaTotaisFrame.edtAlqIcm.Enabled := True;
    fraDadosFechamentoVendaTotaisFrame.edtAlqIcm.Text    := '0,00';

    fraDadosFechamentoVendaTotaisFrame.lblCodSit.Visible := True;
    fraDadosFechamentoVendaTotaisFrame.edtCodSit.Visible := True;
    fraDadosFechamentoVendaTotaisFrame.edtCodSit.Enabled := True;

    fraDadosFechamentoVendaTotaisFrame.lblPerFCP.Visible := True;
    fraDadosFechamentoVendaTotaisFrame.edtPerFCP.Visible := True;
    fraDadosFechamentoVendaTotaisFrame.edtPerFCP.Enabled := True;

    fraDadosFechamentoVendaTotaisFrame.lblVlrFCP.Visible := True;
    fraDadosFechamentoVendaTotaisFrame.edtVlrFCP.Visible := True;

    fltValFcpICMS := fatVenda.objNfeComplemento.TotalItens.recDifalFCP.fltValFcp;
    fltBasFcpICMS := fatVenda.objNfeComplemento.TotalItens.recDifalFCP.fltBasFcp;

    if (fltValFcpICMS = 0) Or (fltBasFcpICMS = 0) then
    begin
      fltPerFcpICMS := 0
    end
    else
    begin
      fltPerFcpICMS := fFormataFloat((fltValFcpICMS * 100) / fltBasFcpICMS, 2);
    end;

    fraDadosFechamentoVendaTotaisFrame.edtVlrFCP.Text := FormatFloat('#,##0.00', fltValFcpICMS);
    fraDadosFechamentoVendaTotaisFrame.edtPerFCP.Text := FormatFloat('#,##0.00', fltPerFcpICMS);

    fraDadosFechamentoVendaTotaisFrame.edtPerDif.Text := '0,00';
    fraDadosFechamentoVendaTotaisFrame.edtValDif.Text := '0,00';

    If (fatVenda.objNfeComplemento.tncTipoNota = tncComplementoICMS) And (not fatVenda.objNfeComplemento.blnTemItens) Then
    Begin
      fraDadosFechamentoVendaTotaisFrame.lblPerDif.Visible  := True;
      fraDadosFechamentoVendaTotaisFrame.lblValDif.Visible  := True;
      fraDadosFechamentoVendaTotaisFrame.edtPerDif.Visible  := True;
      fraDadosFechamentoVendaTotaisFrame.edtValDif.Visible  := True;
      fraDadosFechamentoVendaTotaisFrame.edtPerDif.ReadOnly := False;
    End;

    If fatVenda.objNfeComplemento.blnTemItens Then
    Begin
      fraDadosFechamentoVendaTotaisFrame.edtPerFCP.ReadOnly := True;
      fraDadosFechamentoVendaTotaisFrame.edtVlrFCP.ReadOnly := True;

      fraDadosFechamentoVendaTotaisFrame.edtBasIcm.ReadOnly := True;
      fraDadosFechamentoVendaTotaisFrame.edtValIcm.ReadOnly := True;
      fraDadosFechamentoVendaTotaisFrame.edtBasIpi.ReadOnly := True;
      fraDadosFechamentoVendaTotaisFrame.edtValIpi.ReadOnly := True;
      fraDadosFechamentoVendaTotaisFrame.edtBasRet.ReadOnly := True;
      fraDadosFechamentoVendaTotaisFrame.edtValRet.ReadOnly := True;

      fraDadosFechamentoVendaTotaisFrame.edtBasFCPST.ReadOnly := True;
      fraDadosFechamentoVendaTotaisFrame.edtValFCPST.ReadOnly := True;
      fraDadosFechamentoVendaTotaisFrame.edtAlqFCPST.ReadOnly := True;

      fraDadosFechamentoVendaTotaisFrame.lblAlqIcm.Visible := False;
      fraDadosFechamentoVendaTotaisFrame.edtAlqIcm.Visible := False;
      fraDadosFechamentoVendaTotaisFrame.edtAlqIcm.Enabled := False;
      fraDadosFechamentoVendaTotaisFrame.edtAlqIcm.Text    := '0,00';

      fraDadosFechamentoVendaTotaisFrame.lblCodSit.Visible := False;
      fraDadosFechamentoVendaTotaisFrame.edtCodSit.Visible := False;
      fraDadosFechamentoVendaTotaisFrame.edtCodSit.Enabled := False;

      pAtualizaEditsImpostos;
      pAtualizaRodape;
    End;

  End;

  If (Pos(fatVenda.strOpcDoc, 'VN_CN_CP_') > 0) And
     fatVenda.fEhVendaConcreto And MatchStr(fCfgSis('TPNFCR'),[PRESTCON,SECOL,J_A_MASSA_CONCRETO]) Then
  Begin
    fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Enabled := False;
    fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Enabled := False;
    fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled := False;
  End;

  If Pos(fatVenda.strOpcDoc, 'OV_') > 0 Then
  Begin
    fatVenda.fltValFre := fatVenda.fltFreDig;
  End;

  blnZeraFrete := (fCfgSis('ZERFRE', varBoolean)) And
                    (fatVenda.fPossuiSomenteItensRetira) And
                      (Not (MatchStr(fatVenda.strOpcDoc, ['NE','CF','CI','CP','OF']) Or
                             MatchStr(fatVenda.strOpcDoc, ['GF']) or
                               (fatVenda.strOpcDocTrue = 'NW')));

  If (blnZeraFrete) Then
  Begin
    fatVenda.fltValFre := 0;
    fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text := '0,00';
    fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Enabled := False;
    fatVenda.blnZerouFrete_CFG_ZERFRE := True;
  End
  Else
  begin
    fatVenda.blnZerouFrete_CFG_ZERFRE := False;
    if fEhConfirmacaoEspelhoEnvioFornecedor then
      fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Enabled := False;
  end;

  fltTotIpiOri := fatVenda.fltTotIpi;
  fltTotRetOri := fatVenda.fltTotRet;

  fatVenda.fltTotGer := fatVenda.fltTotGer - fltTotIpiOri;
  fatVenda.fltTotGer := fatVenda.fltTotGer - fltTotRetOri;

  If (fatVenda.strOpcDoc = 'OF') And (Not fatVenda.blnDevWms) And (Not blnEspelhoEnvioParaOFornecedor) Then
  Begin
    pSugereCFOPDevolucaoOutrasSaidasFornecedor;
  End;

  {*****************************************}
  {* (DES)HABILITA CLASSIFICAÇÕES FISCAIS  *}
  {**************************************MV*}
  If fDesabilitarPreenchimentoClassificacaoFiscal Then
  Begin
    fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled := False;
    fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Enabled := False;
  End
  Else
  Begin

    If Not fEmptyStr(fatVenda.strClaFi2) Then
      fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Enabled := True;

    If Not fEmptyStr(fatVenda.strClaFi3) Then
      fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Enabled := True;

  End;

  {*****************************************}
  {* HABILITA / DESABILITA EDITS DAS BASES *}
  {**************************************MV*}
  pEditaBases;

  {*****************************************}
  {* CARREGA EDITS                         *}
  {**************************************MV*}
  If {(Not fEmptyStr(fatVenda.strNumOrc)) Or} (Not fEmptyStr(fatVenda.strCodTra)) Then
  Begin
    fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text := fatVenda.strCodTra;
    If (fTravaTransportadoraPoisJaFoiDefinido) Then
    Begin
      fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Enabled := False;
      fraDadosFechamentoVendaTransportadoraFrame.mskPlaFat.Enabled := False;
    End;
  End
  Else
  Begin
    If (Not fEmptyStr(fCfgSis('TRASUG'))) Then
      fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text := fCfgSis('TRASUG');
  End;

  pCarregaCadTra;

  If (Not blnZeraFrete) Then
    blnZeraFrete := (Pos(fatVenda.strOpcDoc, 'CF_') > 0) And (qryConTra.FieldByName('TRA_FREVEN').AsString = 'R');

  If (Not blnCalcFreteSugestaoRegia) And
     (Not blnCalcFreteSugestaoTranp) And
     (Not blnCalcFreteSugestaoItens) And
     (Not blnCalcFreteSugestaoFaixa) Then
  Begin
    If (Not fEmptyStr(fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text)) And (fatVenda.fltFreDig <= 0) And (Pos(fatVenda.strOpcDocTrue, 'BF_CI_') <= 0) Then
    Begin
      If (fEmptyStr(fatVenda.strNumOrc)) And (Not blnExpedicao) And (Not blnZeraFrete) And (fatVenda.strOpcDoc <> 'CF') Then
        fatVenda.fltFreDig := qryConTra.FieldByName('TRA_VALFRE').AsFloat;
    End;
  End;

  fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text      := IfThen(Not fatVenda.fPermitirFreteNoFaturamento, '0,00', FormatFloat('#,##0.00', fatVenda.fltFreDig));

  if blnZeraFrete then
  begin
    fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text := '0,00';
    fatVenda.fltValFre := 0;
    fatVenda.fltFreDig := 0;
  end;

  If (Pos(fatVenda.strOpcDoc, 'CF_CI_CT_CS_') > 0) Then
    fraDadosFechamentoVendaTransportadoraFrame.edtValFre.ReadOnly := (Not fCfgSis('ALFECF', varBoolean))
  Else If fatVenda.blnCliFil Then
    fraDadosFechamentoVendaTransportadoraFrame.edtValFre.ReadOnly := (Not fCfgSis('ALFRTR', varBoolean))
  Else
    fraDadosFechamentoVendaTransportadoraFrame.edtValFre.ReadOnly := (Not fCfgSis('ALTFRE', varBoolean));

  If (blnExpedicao) Then
  Begin
    fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Enabled := (fCfgSis('DFEXAF', varBoolean));
    fraDadosFechamentoVendaTransportadoraFrame.edtValFre.ReadOnly := Not (fCfgSis('DFEXAF', varBoolean));
  End;

  fraDadosFechamentoVendaTransportadoraFrame.lblValFreCot.Visible := blnMostraFreteCotado;
  fraDadosFechamentoVendaTransportadoraFrame.edtValFreCot.Visible := fraDadosFechamentoVendaTransportadoraFrame.lblValFreCot.Visible;
  fraDadosFechamentoVendaTransportadoraFrame.edtValFreCot.Text    := FormatFloat('#,##0.00', fatVenda.fltFreCot);

  If (fraDadosFechamentoVendaTransportadoraFrame.edtValFreCot.Visible) Then
    fraDadosFechamentoVendaTransportadoraFrame.lblValorDoFrete.Caption := 'Frete à Cobrar:';

  fraDadosFechamentoVendaTransportadoraFrame.edtValFre.ReadOnly := (fraDadosFechamentoVendaTransportadoraFrame.edtValFre.ReadOnly) Or (Not fatVenda.fPermitirFreteNoFaturamento) Or (fatVenda.blnBaiEntFut);
  fraDadosFechamentoVendaTransportadoraFrame.edtValFre.TabStop  := (Not fraDadosFechamentoVendaTransportadoraFrame.edtValFre.ReadOnly);

  fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.ItemIndex :=
    fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Items.IndexOf(fDescricaoFrete(fatVenda.fGetTipoFreteSugestao));
  fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Enabled   := fatVenda.fPermitirFreteNoFaturamento;

  fraDadosFechamentoVendaTransportadoraFrame.btnCalcFreSug.Visible := False;

  If (blnCalcFreteSugestaoItens Or blnCalcFreteSugestaoTranp Or blnCalcFreteSugestaoRegia Or blnCalcFreteSugestaoFaixa) And
     (Not blnSomenExibirSugestFrete) And (fatVenda.fPermitirFreteNoFaturamento)
     and (Not ((fatVenda.blnConfirmacaoEspelho) and (fCfgSis('OUSAFO', varString) = '2'))) then
  Begin
    fraDadosFechamentoVendaTransportadoraFrame.btnCalcFreSug.Visible := (Not fraDadosFechamentoVendaTransportadoraFrame.edtValFre.ReadOnly);

    If (fEmptyStr(fatVenda.strNumOrc)) And (Pos(fatVenda.strOpcDoc, 'CF_CI_CT_CP_DV_') <= 0) And (Not fatVenda.blnBaiEntFut) Then
    Begin
      pCalculaFreteSugestao;
      If (fatVenda.fltTotPro - fatVenda.fltDesEsp >= fatVenda.fltVlMinF) Then
        fltValFreSugNovo := 0.00
      Else
        fltValFreSugNovo := fatVenda.fltFreSug;

      if fPermiteDefinicaoDoFrete then
      begin
        if (fFormataFloat(fatVenda.fltFreDig, 2) <> fFormataFloat(fltValFreSugNovo, 2)) then
        begin
          if Not fConfirmaAlteracaoFrete(fatVenda.fltFreDig, fltValFreSugNovo) then
          begin
            fltValFreSugNovo := fatVenda.fltFreDig;
          end;
        end;
      end;
      fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text := FloatToStrF(fltValFreSugNovo, ffNumber, 12, 2);
    End;

  End;

  If (fatVenda.strCodFpg = '016') Or (fatVenda.strOpcDoc = 'CS') Then
  Begin
    fatVenda.fltDesAce := 0;
    fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.ReadOnly := True;
    fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.TabStop  := False;
  End;

  If blnNotImp Then
    fatVenda.fltOutros := fSomaOutrasDespesasImportacaoDefinidoConfiguracao;

  fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text := FormatFloat('#,##0.00', fatVenda.fltDesAce);

  fraDadosFechamentoVendaTransportadoraFrame.edtOutros.Text := FormatFloat('#,##0.00', fatVenda.fltOutros);

  fraDadosFechamentoVendaTransportadoraFrame.edtEspTra.Text := fatVenda.strEspTra;
  fraDadosFechamentoVendaTransportadoraFrame.edtMarTra.Text := fatVenda.strMarTra;
  fraDadosFechamentoVendaTransportadoraFrame.edtNumera.Text := fatVenda.strNumera;

  If (fatVenda.intNConhe = -1) Then
    fraDadosFechamentoVendaTransportadoraFrame.edtNConhe.Clear
  Else
    fraDadosFechamentoVendaTransportadoraFrame.edtNConhe.Text := IntToStr(fatVenda.intNConhe);

  fraDadosFechamentoVendaTransportadoraFrame.edtPesBru.Text := FormatFloat('#,###0.000', fatVenda.fltPesBru);
  fraDadosFechamentoVendaTransportadoraFrame.edtPesLiq.Text := FormatFloat('#,###0.000', fatVenda.fltPesLiq);
  strPesBruAnt := fraDadosFechamentoVendaTransportadoraFrame.edtPesBru.Text;
  strPesLiqAnt := fraDadosFechamentoVendaTransportadoraFrame.edtPesLiq.Text;

  fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text := fatVenda.strClaFis;
  pCarregaNatOperacao(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text);

  If not fEmptyStr(fatVenda.strDesCla) Then
  begin
    fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.ItemIndex := fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Items.IndexOf(fatVenda.strDesCla) ;

    if (Pos(fatVenda.strOpcDoc, 'GF_OF_') > 0) AND (fatVenda.blnConfirmacaoEspelho) then
    begin
      if fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.ItemIndex = -1 then
        fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Items.Add(fatVenda.strDesCla);
    end;
  end;

  pMostraBtnEdtInfDocExp(fatVenda.fEhNotaExportacao);

  {*******************************************}
  {* VERIFICA SE É CLIENTE FILIAL (TRANSF.DE *}
  {* ESTOQUE). CASO FOR, VERIFICA SE A CLAS- *}
  {* SIFICAÇÃO FISCAL CONFIGURADA PRA TRANS. *}
  {* É DE VENDA. CASO SIM, ESCREVE 'VENDA'   *}
  {* NA NATUREZA DE OPERAÇÃO                 *}
  {****************************************MV*}

  If (fatVenda.blnEstornoNotaFiscalEntregaFutura) Then
  Begin
    fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Clear;
    fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Items.Add('ESTORNO DE SIMPLES FATURAMENTO');
    fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.ItemIndex := 0;
  End
  Else if (Pos(fatVenda.strOpcDoc, 'GF_OF_') > 0) AND (fatVenda.blnConfirmacaoEspelho) then
    fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.ItemIndex := fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Items.IndexOf(fatVenda.strDesCla)
  else  If (Not fatVenda.blnCliFil) Then
    fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Text := fatVenda.strDesCla
  Else
  Begin
    If (Pos(fatVenda.strClaFis, VS_strClaVen) > 0) Then
      fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Text := 'V E N D A'
    Else
      fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Text := fatVenda.strDesCla;
  End;

  fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text := fatVenda.strClaFi2;
  fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text := fatVenda.strClaFi3;

  If fCarregaCentroCustoDev Then
    strCCuFpg := fCfgSis('CTRCDV')
  Else
    strCCuFpg := fRetCCustoFpg(fatVenda.strCodFpg);

  If (Not fatVenda.fExibirCentroDeCustoNoFaturamento) Then
  Begin
    pnlMensagem.Height     := pnlMensagem.Height - fraDadosFechamentoVendaPlanContasFrame.mskCodCta.Height - 2;
    fraDadosFechamentoVendaPlanContasFrame.lblCentroCusto.Visible := False;
    fraDadosFechamentoVendaPlanContasFrame.mskCodCta.Clear;
    fraDadosFechamentoVendaPlanContasFrame.mskCodCta.Visible      := False;
    fraDadosFechamentoVendaPlanContasFrame.edtDesCta.Visible      := False;
  End
  Else
  Begin
    pSetaCentroCusto(strCCuFpg);
  End;

  {**********************************************************************************}
  {* CASO NAO PERMITA ALTERAR A CLASSIFICACAO FISCAL                                *}
  {* PARA OS DOCS: VENDA NORMAL(VN) E PARA AS                                       *}
  {* CONFIRMAÇÕES: DOCUMENTOS(CF), CUPOM FISCAL(CI), TRANSFERENCIA(CT), PEDIDOS(CP) *}
  {*******************************************************************************LU*}
  If ((Not fCfgSis('ALTCLA', varBoolean)) And (Not fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text)) And (Pos(fatVenda.strOpcDoc, 'VN_VS_CP_OV_CF_CT_') > 0)) Or
     ((Not fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text)) And (fatVenda.strOpcDoc = 'CI')) Then
  Begin
    fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled := False;
    fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Enabled := False;
    fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Enabled := False;
    fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Enabled := False;
  End;

  If (Pos(fatVenda.strOpcDoc, 'CO_MF_CS_') > 0) Then
  Begin
    fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled := (fatVenda.strOpcDoc = 'CO') Or (fatVenda.strOpcDoc = 'MF');
    fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Enabled := (fatVenda.strOpcDoc = 'CO') Or (fatVenda.strOpcDoc = 'MF');
    fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Enabled := False;
    fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Enabled := False;
  End;

  If fatVenda.blnPedRemGar Then
  Begin
    fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled := False;
    fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Enabled := False;
    fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Enabled := False;
    fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Enabled := False;
  End;

  {*****************************************}
  {* HABILITA CLASSIFICAÇÕES FISCAIS NOTA  *}
  {* DE COMPLENTO PARA CLIENTE FILIAL      *}
  {**************************************PE*}
  If (Pos(fatVenda.strEspDoc,'NF_EL_NS_') > 0)   And
     (fatVenda.blnCliFil)                        And
     (fatVenda.strOpcDoc = 'NC')                 Then
  Begin
    fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled := True;
    fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Enabled := True;
    fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Enabled := False;
    fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Enabled := False;
  End;

  If (fatVenda.strOpcDoc = 'NC') And fatVenda.objNfeComplemento.blnTemItens Then
  Begin
    fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled := False;
    fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Enabled := False;
    fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Enabled := False;
    fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Enabled := False;

    fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text := fatVenda.objNfeComplemento.TotalItens.strClaFis1;
    fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text := fatVenda.objNfeComplemento.TotalItens.strClaFis2;
    fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text := fatVenda.objNfeComplemento.TotalItens.strClaFis3;
  End;

  pCarregaCadCfo(fraDadosFechamentoVendaClaFisFrame.edtClaFis, True);

  fraDadosFechamentoVendaMSGFatFrame.edtMens01.Text := fatVenda.strMen001;
  fraDadosFechamentoVendaMSGFatFrame.edtMens02.Text := fatVenda.strMen002;
  fraDadosFechamentoVendaMSGFatFrame.edtMens03.Text := fatVenda.strMen003;
  fraDadosFechamentoVendaMSGFatFrame.edtMens04.Text := fatVenda.strMen004;
  fraDadosFechamentoVendaMSGFatFrame.edtMens05.Text := fatVenda.strMen005;

  fraDadosFechamentoVendaMSGExpFrame.edtMenExp.Text := fatVenda.strMenExp;
  fraDadosFechamentoVendaMSGExpFrame.edtMenEx2.Text := fatVenda.strMenEx2;
  fraDadosFechamentoVendaMSGExpFrame.edtMenEx3.Text := fatVenda.strMenEx3;
  fraDadosFechamentoVendaMSGExpFrame.edtMenEx4.Text := fatVenda.strMenEx4;

  blnMenExpVisible := False;

  If (fatVenda.strOpcDoc = 'CP') Then
  Begin
    blnMenExpVisible := True;

    fraDadosFechamentoVendaMSGExpFrame.edtMenExp.Enabled := False;
    fraDadosFechamentoVendaMSGExpFrame.edtMenEx2.Enabled := False;
    fraDadosFechamentoVendaMSGExpFrame.edtMenEx3.Enabled := False;
    fraDadosFechamentoVendaMSGExpFrame.edtMenEx4.Enabled := False;
  End
  Else If (Pos(fatVenda.strOpcDoc, 'VN_CN_CP_') > 0) Then
  Begin
    If Not (fatVenda.fEhVendaConcreto And MatchStr(fCfgSis('TPNFCR'),[PRESTCON,SECOL,J_A_MASSA_CONCRETO])) Then
    Begin
      blnMenExpVisible := True;

      fraDadosFechamentoVendaMSGExpFrame.edtMenExp.Enabled := True;
      fraDadosFechamentoVendaMSGExpFrame.edtMenEx2.Enabled := True;
      fraDadosFechamentoVendaMSGExpFrame.edtMenEx3.Enabled := True;
      fraDadosFechamentoVendaMSGExpFrame.edtMenEx4.Enabled := True;
    End;
  End;

  pnlMenExp.Visible := blnMenExpVisible;

  pnlEvento.Visible := fCfgSis('EVEFAT', varBoolean) And
                      (Pos(fatVenda.strEspDoc, 'MI_FF_NF_EL_IF_IV_D1_TR_DV_') > 0) And
                      (fatVenda.strOpcDoc <> 'OF');

  if Not fEhConfirmacaoEspelhoEnvioFornecedor then
    pAtualizaEditsImpostos;

  If (Not fCfgSis('USASER', varBoolean)) And (Not fatVenda.fEhVendaItemConcreto) Then
  Begin
    fraDadosFechamentoVendaTotaisFrame.lblBasIss.Visible := False;
    fraDadosFechamentoVendaTotaisFrame.lblValIss.Visible := False;
    fraDadosFechamentoVendaTotaisFrame.edtBasIss.Visible := False;
    fraDadosFechamentoVendaTotaisFrame.edtValIss.Visible := False;
  End;

  fraDadosFechamentoVendaMSGFatFrame.edtMens01.MaxLength := IIF(fCfgSis('QTCANF', varInteger) < fTamCampoMsgNF, fCfgSis('QTCANF', varInteger), fTamCampoMsgNF);
  fraDadosFechamentoVendaMSGFatFrame.edtMens02.MaxLength := fraDadosFechamentoVendaMSGFatFrame.edtMens01.MaxLength;
  fraDadosFechamentoVendaMSGFatFrame.edtMens03.MaxLength := fraDadosFechamentoVendaMSGFatFrame.edtMens01.MaxLength;
  fraDadosFechamentoVendaMSGFatFrame.edtMens04.MaxLength := fraDadosFechamentoVendaMSGFatFrame.edtMens01.MaxLength;
  fraDadosFechamentoVendaMSGFatFrame.edtMens05.MaxLength := fraDadosFechamentoVendaMSGFatFrame.edtMens01.MaxLength;

  pSalvaImpostosOriginais;

  fraDadosFechamentoVendaGravarContasFrame.ckbGravaCTR.left := fraDadosFechamentoVendaGravarContasFrame.ckbOFGravaCTP.Left;
  fraDadosFechamentoVendaGravarContasFrame.ckbGravaCTR.Top  := fraDadosFechamentoVendaGravarContasFrame.ckbOFGravaCTP.Top;

  fraDadosFechamentoVendaGravarContasFrame.ckbOFGravaCTP.Visible := False;
  fraDadosFechamentoVendaGravarContasFrame.ckbGravaCTR.Visible   := False;

  If SameText(fatVenda.strOpcDoc,'OF') And
  ( ((fCfgSis('OUSAFO', varString) = '2') And (fatVenda.blnConfirmacaoEspelho) ) or (fCfgSis('OUSAFO', varString) = '1')) Then
  Begin
    pnlGravaFinanceiro.Visible  := True;
    fraDadosFechamentoVendaGravarContasFrame.ckbOFGravaCTP.Visible := True;
    fraDadosFechamentoVendaGravarContasFrame.ckbOFGravaCTP.Checked := fCfgSis('GCPOSF', varBoolean);
    //ckbOFGravaCTP.Checked       := fatVenda.blnOFGCTP;
  End;

  If SameText(fatVenda.strOpcDoc,'NC') And
     fatVenda.blnNCFornecedor And (fatVenda.objNfeComplemento.tncTipoNota In [tncCreditoICMS, tncEstornoDeCredito]) Then
  Begin
    pnlGravaFinanceiro.Visible  := True;
    fraDadosFechamentoVendaGravarContasFrame.ckbOFGravaCTP.Visible := True;
    fraDadosFechamentoVendaGravarContasFrame.ckbOFGravaCTP.Checked := fCfgSis('GCPOSF', varBoolean);
  End;

  If SameText(fatVenda.strOpcDoc,'OU') And (not fatVenda.blnConEqu) Then
  Begin
    pnlGravaFinanceiro.Visible := TRUE;
    fraDadosFechamentoVendaGravarContasFrame.ckbGravaCTR.Visible := True;
    fraDadosFechamentoVendaGravarContasFrame.ckbGravaCTR.Checked := fCfgSis('GCROSC', varBoolean);
    fatVenda.blnCtrOutSai := fraDadosFechamentoVendaGravarContasFrame.ckbGravaCTR.Checked;
  End;

  if SameText(fatVenda.strOpcDoc,'EF') And (not fatVenda.blnConEqu) then
  begin
    pnlGravaFinanceiro.Visible := True;
    fraDadosFechamentoVendaGravarContasFrame.ckbOFGravaCTP.Visible := True;
    fraDadosFechamentoVendaGravarContasFrame.ckbOFGravaCTP.Checked := True;
    fatVenda.blnCtpOutEnt := True;
  end;
                                                           //Se ja tem despesas acessorias da confirmacao entao nao deve alterar
  If (fDeveAlterarDespesasAcessorias) Then
  Begin
    If (fatVenda.strCliDAc = 'S') And (Pos(fatVenda.strOpcDoc, 'PD_OR_VN_CF_') > 0) Then
    Begin
      fltVlrDesAce := 0;

      strTipFat := '';

      If fCfgSis('TPDCEX') = '1' Then
      Begin
        If fatVenda.strEspDoc = 'NF' Then strTipFat := 'A';
        If fatVenda.strEspDoc = 'FF' Then strTipFat := 'B';
        If fatVenda.strEspDoc = 'IF' Then strTipFat := 'C';
      End;

      If fCobrarDespAcessCondPagto(fatVenda.strCodCnd, fatVenda.strCodCli, strTipFat) Then
      Begin
        fltVlrDesAce := fRetornaDesAceUnicoPorVenda(fatVenda.strCodCnd);
        fltPerDesAce := fRetornaDesAceCnd(fatVenda.strCodCnd);
        fltParDesAce := fRetornaDesAcePrazoCnd(fatVenda.strCodCnd, fatVenda.strConPag);

        If fltPerDesAce > 0 Then
          fltVlrDesAce := fltVlrDesAce + fatVenda.fltTotPro * fltPerDesAce / 100.00;

        fltVlrDesAce := fltVlrDesAce + fltParDesAce;
      End;

      fltVlrDesAce := fltVlrDesAce + fCfgSis('VLDEAC', varDouble);

      fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text := FormatFloat('#,##0.00',fltVlrDesAce);
      pCalculaTotalGeral;
    End
    Else
    Begin
      If fEmptyStr(fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text,True) Then
        fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text := '0,00';

      If Pos(fatVenda.strOpcDoc, 'OU_OF_OV_OE_NE_EF_GF_') <= 0 Then
        fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Enabled := False;
      if Not fEhConfirmacaoEspelhoEnvioFornecedor then
        pCalculaTotalGeral;
    End;
  End
  Else
  Begin
    If (fatVenda.strCliDAc = 'N') And (fatVenda.strNotImp = 'N') Then
      fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Enabled := False;
  End;

  If Assigned(fatVenda.objDespesasFaturamento) And (Not fatVenda.blnBaiEntFut) Then
  Begin
    fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Enabled  := True;
    fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.ReadOnly := True;
    fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.TabStop  := False;
    fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Color    := $00FFDFB8;
    fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text     := FormatFloat('#,##0.00', fatVenda.objDespesasFaturamento.fltValorTotal);
    fraDadosFechamentoVendaTransportadoraFrame.btnDespesasFaturamento.Visible := True;
    pCalculaTotalGeral;
  End;

  fraCentroCusto.edtCodEve.Text := fatVenda.strCodEve;
  fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve.Text);

  if (Pos(fatVenda.strOpcDoc, 'OF_') > 0) and (blnConfirmacaoEspelho) Then
    strValFreAnt   := fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text;

  If fatVenda.fEhDevolucaoEspelhoPorAD and (not blnConfirmacaoEspelho) Then
  Begin
    fatVenda.pCalculaFreteDespAcessDevolucaoEspelhoPorAD;
    fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text := FormatFloat('#,##0.00', fatVenda.fltValFre);
    fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text := FormatFloat('#,##0.00', fatVenda.fltDesAce);
  End
  Else If fatVenda.fEhDevolucaoEspelhoOuParaFornecedor and (not blnConfirmacaoEspelho) Then
  Begin
    fatVenda.pCalculaFreteDespAcessDevolucaoFornecedor;

    pDefineTipoDeFreteNoFaturamento;

    fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.ItemIndex := fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Items.IndexOf(fDescricaoFrete(IfThen(Not fDefineTipoDeFreteNoFaturamento, '9', fatVenda.strTipFre)));
    fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text := FormatFloat('#,##0.00', fatVenda.fltValFre);

    If (fatVenda.fltValFre = 0) And (fCfgSis('ESPDEV', varBoolean)) And (fCfgSis('FRDVES', varString) = '2') And (Pos(fatVenda.strOpcDoc, 'DV_') > 0) Then
      frmFatDadosFiscais.fraDadosFechamentoVendaTransportadoraFrame.pAdicionaElementoFreteConta(fDescricaoFrete(IntToStr(9)));

    fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text := FormatFloat('#,##0.00', fatVenda.fltDesAce);
  End
  Else If (blnFatBaixaPedidoDev) And (fatVenda.strOpcDoc = 'DV') Then
  Begin
    fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text := FormatFloat('#,##0.00', fatVenda.fltValFre);
    fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text := FormatFloat('#,##0.00', fatVenda.fltDesAce);
  End;

  If (fatVenda.fEhRecGarantia) and ( fltOUTDesAce <> null ) Then
  begin
    fatVenda.fltDesAce := fltOUTDesAce;
    fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text := FormatFloat('#,##0.00', fatVenda.fltDesAce);
  End;

  if (Pos(fatVenda.strOpcDoc, 'GF_') > 0) Then
    strValFreAnt   := fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text;

  {*****************************************}
  {* ATUALIZA RODAPÉ                       *}
  {**************************************JB*}
  pAtualizaRodape;

  fatVenda.fltImpTot := fStrToFloat(fraDadosFechamentoVendaTipoFaturamentoFrame.edtTotGer.Text);

  If not fatVenda.blnConfirmacaoEspelho Then
    pValidaClassificacaoFiscalQuandoDesabilitada;

  If fEmptyStr(fraDadosFechamentoVendaTransportadoraFrame.edtEspTra.Text) Then
    fraDadosFechamentoVendaTransportadoraFrame.edtEspTra.Text := fCfgSis('ESPTRA');

  strCl1Ant := fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text;
  strCl2Ant := fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text;
  strCl3Ant := fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text;
  pGuardaClassificacoesOriginaisDosItens;

  If fCfgSis('TVBRLQ', varBoolean) Then
  Begin
    fraDadosFechamentoVendaTransportadoraFrame.edtPesBru.Enabled := False;
    fraDadosFechamentoVendaTransportadoraFrame.edtPesLiq.Enabled := False;

    fraDadosFechamentoVendaTransportadoraFrame.lblEdiPes.Visible := False;
  End Else
  Begin
    fraDadosFechamentoVendaTransportadoraFrame.edtPesBru.Enabled := True;
    fraDadosFechamentoVendaTransportadoraFrame.edtPesLiq.Enabled := True;
  End;

  fraDadosFechamentoVendaTransportadoraFrame.chkEntUrg.Checked := fatVenda.strEntUrg = 'S';

  pAjustaAlturaForm;

  fatVenda.strCstNotCom := '';

  If (fatVenda.strOpcDoc = 'NC') Then
  Begin
    fatVenda.fltValFre := 0;
    fatVenda.fltFreSug := 0;
    fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text := FormatFloat('#0.00', fatVenda.fltValFre);

    If fatVenda.objNfeComplemento.tncTipoNota In [tncTransferenciaCredorICMS, tncTransferenciaDevedorICMS] Then
    Begin
      fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.ItemIndex := fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Items.IndexOf(fDescricaoFrete('9'));
      fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Enabled := False;
    End;

    fraDadosFechamentoVendaTransportadoraFrame.btnCalcFreSug.Visible := False;
    fraDadosFechamentoVendaTotaisFrame.edtCodSit.Text := fSugestaoCSTNotaComplem;
    fraDadosFechamentoVendaTotaisFrame.edtCstIpi.Text := '49';
    fraDadosFechamentoVendaTotaisFrame.edtCstPis.Text := '99';
    fraDadosFechamentoVendaTotaisFrame.edtCstCof.Text := '99';

    pAtualizaRodape;
  End;

  { Req.: 227012
  If (fatVenda.strOpcDoc = 'DV') And
     (fCfgSis('FRETRA') = FRETRA_POR_PRODUTOS_ADICIONAL_TRANSPORTADORA) Then
  Begin
    fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Enabled := False;
    fraDadosFechamentoVendaTransportadoraFrame.mskPlaFat.Enabled := False;
  End;
  }

  blnPesBruEna := fraDadosFechamentoVendaTransportadoraFrame.edtPesBru.Enabled;
  blnPesLiqEna := fraDadosFechamentoVendaTransportadoraFrame.edtPesLiq.Enabled;
  blnPesBruRea := fraDadosFechamentoVendaTransportadoraFrame.edtPesBru.ReadOnly;
  blnPesLiqRea := fraDadosFechamentoVendaTransportadoraFrame.edtPesLiq.ReadOnly;
  blnPesBruTab := fraDadosFechamentoVendaTransportadoraFrame.edtPesBru.TabStop;
  blnPesLiqTab := fraDadosFechamentoVendaTransportadoraFrame.edtPesLiq.TabStop;

  If (fatVenda.strEdiPes = 'E') Then
  Begin
    fraDadosFechamentoVendaTransportadoraFrame.edtPesBru.readOnly := True;
    fraDadosFechamentoVendaTransportadoraFrame.edtPesLiq.readOnly := True;
    fraDadosFechamentoVendaTransportadoraFrame.edtPesBru.TabStop  := False;
    fraDadosFechamentoVendaTransportadoraFrame.edtPesLiq.TabStop  := False;
  End;

  strCodTraAnt := fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text;
  strTipFreAnt := fTipoFrete(fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Text);
  fatVenda.strCodTraAnt := fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text;
  fatVenda.strNomTraAnt := fraDadosFechamentoVendaTransportadoraFrame.edtNomTra.Text;
  fatVenda.fltValFreAnt := fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text,0);
  fltValFreAnt := fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text,0);
  fltValFreAntTrava := fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text,0);

  //Se For Confirmação de Espelho carrega os impostos já salvos;
  if fatVenda.blnConfirmacaoEspelho Then
  Begin
    fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Enabled := False;
    fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.ItemIndex := fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Items.IndexOf(fDescricaoFrete(fatVenda.strTipFre));
    strTipFreAnt := fTipoFrete(fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Text);
    If Not blnFatDadosFiscaisImpostosExterno Then
      pCriarFormularios(TfrmFatDadosFiscaisImpostos, frmFatDadosFiscaisImpostos);

    fatVenda.strClaFis := fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text;
    fatVenda.pCalculaPisCofinsLivro(fatVenda.strClaFis);

    If blnNotImp Or (fatVenda.strOpcDoc = 'OF') Or ((fatVenda.strOpcDoc = 'NE') And (fatVenda.blnNEFornecedor)) Then
    Begin
      frmFatDadosFiscaisImpostos.strCodigoFornecedor := fatVenda.strCodCli;
      frmFatDadosFiscaisImpostos.blnNotaFornecedor   := True;
    End;

    If (Pos(fatVenda.strOpcDoc, 'OU_OF_NE_') > 0) Or blnNotImp Then
      frmFatDadosFiscaisImpostos.blnIcmsDesonerado := True;

    frmFatDadosFiscaisImpostos.strOpcDoc := fatVenda.strOpcDoc;
    frmFatDadosFiscaisImpostos.strCliOrg := fatVenda.strCliOrg;
    frmFatDadosFiscaisImpostos.strZonFra := fatVenda.strZonFra;
    frmFatDadosFiscaisImpostos.cdsItens.Data := cdsImpostosDigitadosItens.Data;
    frmFatDadosFiscaisImpostos.cdsItens.Edit; //Calcular os totais.
    frmFatDadosFiscaisImpostos.cdsItens.Post;
    cdsImpostosDigitadosItens.Data := frmFatDadosFiscaisImpostos.cdsItens.Data;

    fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Text := frmFatDadosFiscaisImpostos.edtBasIcm.Text;
    fraDadosFechamentoVendaTotaisFrame.edtValIcm.Text := frmFatDadosFiscaisImpostos.edtValIcm.Text;
    fraDadosFechamentoVendaTotaisFrame.edtBasIpi.Text := frmFatDadosFiscaisImpostos.edtBasIpi.Text;
    fraDadosFechamentoVendaTotaisFrame.edtValIpi.Text := frmFatDadosFiscaisImpostos.edtValIpi.Text;
    fraDadosFechamentoVendaTotaisFrame.edtBasRet.Text := frmFatDadosFiscaisImpostos.edtBasRet.Text;
    fraDadosFechamentoVendaTotaisFrame.edtValRet.Text := frmFatDadosFiscaisImpostos.edtValRet.Text;



    If blnNotImp Then
    Begin
      pAtualizarImpostosDigitadosParaMatrizItens;
      pRateiaValorTaxaSiscomexNosItens;
      pGuardaClassificacoesOriginaisDosItens;
    End;

    pAtualizaRodape;
  End;

  if fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Enabled then
  begin
    if blnExpedicao then
    begin
      fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Enabled := fCfgSis('ALDAVE', varBoolean);
    end
    else If (Pos(fatVenda.strOpcDoc, 'PD_OR_VN_GF_') > 0) Then
    begin
      fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Enabled := fCfgSis('ALDAVF', varBoolean);
    end;
  end
  else
  begin
    if fatVenda.strOpcDoc = 'GF' then
    begin
      fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Enabled := fCfgSis('ALDAVF', varBoolean);
    end;
  end;

  if (fCfgSis('OUSAFO',varString) = '2') AND  fatVenda.blnConfirmacaoEspelho AND (fatVenda.strOpcDoc = 'GF') then
  begin
  	fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Enabled := False;
    fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Enabled := False;
  end;

  if fatVenda.strOpcDoc = 'GF' then
  begin
    strDesAceAnt   := FormatFloat('#,##0.00', fatVenda.fltDesAce);
    fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text := FormatFloat('#,##0.00', fatVenda.fltDesAce);
    strValFreOri := fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text;
    strValFreAnt := strValFreOri;
  end;

  If (Not fEmptyStr(fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text)) And (fEmptyStr(fraDadosFechamentoVendaTransportadoraFrame.mskPlaFat.Text)) Then
    fraDadosFechamentoVendaTransportadoraFrame.mskPlaFat.Text := AnsiReplaceStr(fCampoTabela('TRA_NUMPLA', 'CADTRA', ['TRA_CODTRA'], [fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Text]), '-', '');

  If (Pos(fatVenda.strOpcDoc, 'FC_') > 0) and
     (fCfgSis('ALDAVF', varBoolean)) and
     (fCampoTabela('CLI_CODEAC', 'CADCLI', ['CLI_CODCLI'], [fatVenda.strCodCli], False) = 'S') Then
    fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Enabled := True;

  if fatVenda.strOpcDoc = 'DV' then
    fatVenda.fltFreteOriginalParaDevolucao := fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text,0);

  If (fatVenda.strOpcDoc = 'PR') And (fCfgSis('ZVFPDR', varBoolean)) Then
  Begin
    fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text := '0,00';
  End;

  If (fatVenda.strOpcDoc = 'DV') And (fCfgSis('ZVFDEV', varBoolean)) Then
  Begin
    fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text := '0,00';
  End;

  pnlRefDocDadosFiscais.Visible := fApresentaTelaParaReferenciarNota;

  if (fatVenda.strCliEst = 'EX') then
  begin
    pnlDrawBack.Visible := True;
  end
  else
  begin
    pnlDrawBack.Visible := False;
  end;

  If fatVenda.blnEspelhoDevolucaoCliente Then
  Begin
    If fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Enabled Then
      fltDevolucaoEspelhoAD_ValFre := fFormataFloat(fStrtoFloat(fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text),2);

    If fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Enabled Then
      fltDevolucaoEspelhoAD_DesAce := fFormataFloat(fStrtoFloat(fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text),2);
  End;

  pnlTipAte.Visible := (fatVenda.strOpcDoc = 'VN') And fCfgSis('VNDTPA', varBoolean);

  If Not fEmptyStr(fatVenda.strCodTpA) Then
  Begin
    edtCodTpa.Text := fatVenda.strCodTpA;
    fValidaCAmpos(edtCodTpa);

    If pnlTipAte.Visible Then
    Begin
      If (Not fEmptyStr(fatVenda.strNumOrc)) And
         (Not fEmptyStr(edtDesTpa.Text)) And
         (Not fVerificaAcessoSistema('mnuAlteracaoTipoAtendPed')) Then
      Begin
         edtCodTpa.Enabled := False;
         edtCodTpa.Color   := edtDesTpa.Color;
      End;
    End;
  End;

  If blnNotImp Then
    pCarregaConfiguracoesParaNotaDeImportacaoDesonerada;

  fraNumeroDrawbackFrame.objVenda := fatVenda;
  fraNumeroDrawbackFrame.onConfirm := pConfirmDados;

  fraReferenciarDocumentosExterior.objVenda := fatVenda;
  fraReferenciarDocumentosExterior.pCarregaCaptionbtnRefeDoc;

  if fatVenda.fRecebidoPorPix then
  begin
    fatVenda.fltValFre := LValorFretePixRecebido;
    fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text := FloatToStrF(LValorFretePixRecebido, ffNumber, 12, 2);
    fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text := FormatFloat('#,##0.00', fatVenda.fltDesAce);
    fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Enabled := False;
    fraDadosFechamentoVendaTransportadoraFrame.btnCalcFreSug.Enabled := False;
    fraDadosFechamentoVendaTransportadoraFrame.edtValFreCot.Enabled := False;
    fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Enabled := False;
    fraDadosFechamentoVendaTransportadoraFrame.btnDespesasFaturamento.Enabled := False;
    fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Enabled := False;
    fraDadosFechamentoVendaTransportadoraFrame.edtCodTra.Enabled := False;
    fraDadosFechamentoVendaTipoFaturamentoFrame.edtDesEsp.Enabled := False;
    fraDadosFechamentoVendaTipoFaturamentoFrame.edtPorDes.Enabled := False;
    btnDigImpostosItens.Enabled := False ;
    fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled := False ;
    fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Enabled := False ;
    fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Enabled := False ;
    fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Enabled := False ;
    fraNumeroDrawbackFrame.btnDrawback.Enabled := False ;
    fraDadosFechamentoVendaTotaisFrame.pnlDados.Enabled := False ;
    pCalculaTotalGeral;
  End;

  If (fatVenda.strOpcDoc = 'OF') And (fCfgSis('OUSAFO', varString) = '2') Then
    fraDadosFechamentoVendaTransportadoraFrame.mskPlaFat.Text := fatVenda.strPlaFat;

  If (fraDadosFechamentoVendaTransportadoraFrame.pnlTraRedesp.Visible) Then
  Begin
    If (Not fEmptyStr(fatVenda.strTraRdp)) Then
    Begin
      fraDadosFechamentoVendaTransportadoraFrame.edtTraRedCod.Text := fatVenda.strTraRdp;
      fValidaCampos(fraDadosFechamentoVendaTransportadoraFrame.edtTraRedCod);
    End
    Else
      fraDadosFechamentoVendaTransportadoraFrame.edtTraRedCod.Text := '';
  End;

  pnlEmpFat.Visible := (Pos(fatVenda.strOpcDoc, 'VN_') > 0) And fCfgSis('FATSSA', varBoolean);

  If (pnlEmpFat.Visible) Then
  Begin
    If Not fEmptyStr(fatVenda.strEmpFatSemSaldo) Then
      fraEmpresaFaturamentoFrame1.edtCodEmpFat.Text := fatVenda.strEmpFatSemSaldo
    Else If (Length(fatVenda.strCliCgc) > 11) Then
      fraEmpresaFaturamentoFrame1.edtCodEmpFat.Text := fCfgSis('SSAEPJ')
    Else
      fraEmpresaFaturamentoFrame1.edtCodEmpFat.Text := fCfgSis('SSAEPF');

    If Not fEmptyStr(fraEmpresaFaturamentoFrame1.edtCodEmpFat.Text) Then
      fraEmpresaFaturamentoFrame1.edtDesEmpFat.Text := fRetNomeEmpresa(fraEmpresaFaturamentoFrame1.edtCodEmpFat.Text);
  End;

  If (fatVenda.strOpcDocTrue = 'CA') Or
     (fCfgSis('BLOCTE', varBoolean) And (fatVenda.strOpcDoc = 'CT')) Then
  Begin
    fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled := False;
    fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Enabled := False;
    fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Enabled := False;
    fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Enabled := False;
  End;

  objValidacoesFrete := TValidacoesFrete.Create(fatVenda);

  fatVenda.fltTiiZfm := fatVenda.fRetornaValorDoImpostoDeImportacaoZonaFranca;

  fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text := FormatFloat('#,##0.00', fatVenda.fltDesAce + fatVenda.fltTiiZfm);

  If (fatVenda.strOpcDoc = 'NC') And (fatVenda.objNfeComplemento.tncTipoNota = tncNFAjusteICMSaMaior) Then
  Begin
    fatVenda.strClaFis := '1949';
    fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text := fatVenda.strClaFis;
    pCarregaNatOperacao(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text);

    fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Enabled := True;
    fraDadosFechamentoVendaTotaisFrame.edtAlqIcm.Enabled := True;
    fraDadosFechamentoVendaTotaisFrame.edtValIcm.Enabled := True;

    fraDadosFechamentoVendaTotaisFrame.edtBasRet.Enabled := False;
    fraDadosFechamentoVendaTotaisFrame.edtValRet.Enabled := False;

    fraDadosFechamentoVendaTotaisFrame.edtBasIpi.Enabled := False;
    fraDadosFechamentoVendaTotaisFrame.edtValIpi.Enabled := False;

    fraDadosFechamentoVendaTotaisFrame.edtBasIss.Enabled := False;
    fraDadosFechamentoVendaTotaisFrame.edtValIss.Enabled := False;

    fraDadosFechamentoVendaTotaisFrame.edtPerFCP.Enabled := False;
    fraDadosFechamentoVendaTotaisFrame.edtVlrFCP.Enabled := False;

    fraDadosFechamentoVendaTotaisFrame.edtBasFCPST.Enabled := False;
    fraDadosFechamentoVendaTotaisFrame.edtAlqFCPST.Enabled := False;
    fraDadosFechamentoVendaTotaisFrame.edtValFCPST.Enabled := False;

    fraDadosFechamentoVendaTotaisFrame.edtCodSit.Enabled := False;
  End;

  If fatVenda.fEhComplementoDeFrete Then
  Begin
    fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Enabled := True;
    fraDadosFechamentoVendaTotaisFrame.edtAlqIcm.Enabled := True;
    fraDadosFechamentoVendaTotaisFrame.edtValIcm.Enabled := True;

    fraDadosFechamentoVendaTotaisFrame.edtBasRet.Enabled := False;
    fraDadosFechamentoVendaTotaisFrame.edtValRet.Enabled := False;

    fraDadosFechamentoVendaTotaisFrame.edtBasIpi.Enabled := False;
    fraDadosFechamentoVendaTotaisFrame.edtValIpi.Enabled := False;

    fraDadosFechamentoVendaTotaisFrame.edtBasIss.Enabled := False;
    fraDadosFechamentoVendaTotaisFrame.edtValIss.Enabled := False;

    fraDadosFechamentoVendaTotaisFrame.edtPerFCP.Enabled := False;
    fraDadosFechamentoVendaTotaisFrame.edtVlrFCP.Enabled := False;

    fraDadosFechamentoVendaTotaisFrame.edtBasFCPST.Enabled := False;
    fraDadosFechamentoVendaTotaisFrame.edtAlqFCPST.Enabled := False;
    fraDadosFechamentoVendaTotaisFrame.edtValFCPST.Enabled := False;

    fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Enabled   := True;
    fraDadosFechamentoVendaTransportadoraFrame.edtValFre.ReadOnly  := False;
    fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Enabled   := True;
    fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.ItemIndex := fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Items.IndexOf(fDescricaoFrete(IIF(not fEmptyStr(fatVenda.objNfeComplemento.strTipFre), fatVenda.objNfeComplemento.strTipFre, '9')));
  End;

  FUsaTrocaDeCfopNaDigitacaoDeImpostos := fHabilitarTrocaDeCfopNaDigitacaoDeImpostos;

  If FUsaTrocaDeCfopNaDigitacaoDeImpostos Then
  Begin
    fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled := False;
    blnForcaEdiBas := True;
    pEditaBases;
  End;

  If fEhRestituicaoDeIcmsStOuEstoque Then
  Begin
    fraDadosFechamentoVendaMSGFatFrame.edtMens01.Text := 'RESTITUIÇÃO DE ICMS/ST/ESTOQUE - APROPRIAÇÃO DO CRÉDITO REFERENTE À EXCLUSÃO ';
    fraDadosFechamentoVendaMSGFatFrame.edtMens02.Text := 'DE MERCADORIAS DO REGIME DA SUBSTITUIÇÃO TRIBUTÁRIA - ';
    fraDadosFechamentoVendaMSGFatFrame.edtMens03.Text := 'ART. 26, INCISO IV DA RESOLUÇÃO Nº 4.855/2015 ';
  End;

  If (not fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text)) And fEmptyStr(strClaFisAnt) Then
  Begin
    strClaFisAnt := fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text;
    pCarregaNatOperacao(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text);
  End;

End;


procedure TfrmFatDadosFiscais.pProcessaDiferencas(blnTeveMotivoValorDesoneradoAlteradoManualemente: Boolean=False);
var
  i : Integer;
  strValorAlterado : String;
begin

  If Not Assigned(cdsImpostos_Ant) Then
    Exit;


  If Not Assigned(cdsImpostos_Pos) Then
    Exit;

  If (cdsImpostos_Ant.IsEmpty) Then
    Exit;

  If (cdsImpostos_Pos.IsEmpty) Then
    Exit;

  If Not Assigned(fatVenda) Then
    Exit;

  cdsImpostos_Ant.First;
  cdsImpostos_Pos.First;

  fatVenda.DigImp.pLimpar;
  for i := 0 to cdsImpostos_Ant.FieldCount -1 do
  begin

    If (cdsImpostos_Ant.Fields[i].Value <> cdsImpostos_Pos.Fields[i].Value) Then
    Begin

      strValorAlterado := 'Campo Alterado: ' + cdsImpostos_Ant.Fields[i].FieldName + ' - De: ' + FormatFloat(',0.00', cdsImpostos_Ant.Fields[i].AsFloat) +
                                                                                     ' Para: ' + FormatFloat(',0.00', cdsImpostos_Pos.Fields[i].AsFloat);
      fatVenda.DigImp.stlValores_Alterados.Add(strValorAlterado);

      {Operador alterou impostos!}
      fatVenda.DigImp.blnOperadorDigitouImpostos := True;

    End;

  end;

  If blnTeveMotivoValorDesoneradoAlteradoManualemente Then
    fatVenda.DigImp.blnOperadorDigitouImpostos := True;

end;

procedure TfrmFatDadosFiscais.pAtualizaDadosAdicionaisNotImp;
  Var
    intContador: Integer;
begin
  fatVenda.fltBaseII := 0.00;
  fatVenda.fltDesAdu := 0.00;
  fatVenda.fltImpImp := 0.00;
  fatVenda.fltValIOF := 0.00;

  For intContador := Low(fatVenda.arrMatItens) To High(fatVenda.arrMatItens) Do
  Begin
    fatVenda.fltBaseII := fatVenda.fltBaseII + fatVenda.arrMatItens[intContador].fltBaseII;
    fatVenda.fltDesAdu := fatVenda.fltDesAdu + fatVenda.arrMatItens[intContador].fltDesAdu;
    fatVenda.fltImpImp := fatVenda.fltImpImp + fatVenda.arrMatItens[intContador].fltVal_II;
    fatVenda.fltValIOF := fatVenda.fltValIof + fatVenda.arrMatItens[intContador].fltValIof;
  End;
  if (pos(fatVenda.strOpcDoc, '_GF_') > 0) or (fatVenda.strOpcDocTrue = 'NW') then
    fatVenda.blnBloquearRestaurarValoresEspeplhoGF := True
end;

function TfrmFatDadosFiscais.fOutrasSaidasAbreviacaoIpi: Boolean;
begin
  Result := (fCfgSis('UTIABI', varBoolean)) And (fatVenda.strOpcDoc = 'OU');
end;

function TfrmFatDadosFiscais.fOutrasSaidasFornecedorComVendaPresencial: Boolean;
begin
  Result := False;

  If (fatvenda.strOpcDoc <> 'OF') Then
    Exit;

  If (fatvenda.strDocDevOF.IsEmpty) Then
    Exit;

  If (Not fatVenda.blnVendaPresencial) Then
    Exit;

  Result := True;
end;

procedure TfrmFatDadosFiscais.fraDadosFechamentoVendaBombeamentoFrameedtRedISSExit(Sender: TObject);
begin
  inherited;

  If (fStrToFloat(fraDadosFechamentoVendaBombeamentoFrame.edtRedISS.Text) < 0) Then
    fraDadosFechamentoVendaBombeamentoFrame.edtRedISS.Text := '0';

  pCalculaTotalGeral;

end;

procedure TfrmFatDadosFiscais.fraDadosFechamentoVendaPlanContasFramemskCodCtaEnter(
  Sender: TObject);
begin
  inherited;
  fraDadosFechamentoVendaPlanContasFrame.mskCodCta.EditMask := '';
end;

procedure TfrmFatDadosFiscais.fraDadosFechamentoVendaPlanContasFramemskCodCtaExit(
  Sender: TObject);
begin
  inherited;
  fraDadosFechamentoVendaPlanContasFrame.mskCodCta.EditMask := '99.99.999;0;_';
end;

procedure TfrmFatDadosFiscais.fraDadosFechamentoVendaTotaisFrameedtBasIssExit(Sender: TObject);
var
  fltTotal : Double;
begin
  inherited;

  {Calcular redução da base ISS}
  If Not fraDadosFechamentoVendaTotaisFrame.edtBasIss.Enabled Then
    Exit;

  If Not (fatVenda.fEhVendaConcreto) Then
    Exit;

  If Not (fCfgSis('TPNFCR') = J_A_MASSA_CONCRETO) Then
    Exit;

  If Not (fatVenda.strOpcDoc = 'CN') Then
    Exit;

  {Base ISS = Total de produto + Taxa de bombeamento}
  fltTotal := fatVenda.fltTotPro + fStrToFloat(fraDadosFechamentoVendaBombeamentoFrame.edtTotBom.Text);

  If (fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasIss.Text) > fltTotal) Or (fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasIss.Text) < 0) Then
    fraDadosFechamentoVendaTotaisFrame.edtBasIss.Text := fltTotal.ToString();

  fraDadosFechamentoVendaBombeamentoFrame.edtRedISS.Text := FormatFloat('#,##0.00', (1- fStrToFloat(fraDadosFechamentoVendaTotaisFrame.edtBasIss.Text) / fltTotal) * 100);
  pCalculaTotalGeral;

end;

procedure TfrmFatDadosFiscais.fraDadosFechamentoVendaTotaisFrameedtPerFCPExit(
  Sender: TObject);
begin
  inherited;
  pAtualizaVlrFCP;
end;

procedure TfrmFatDadosFiscais.fraDadosFechamentoVendaTotaisFrameedtVlrFCPExit(
  Sender: TObject);
begin
  inherited;
  pAtualizaAlqFCP;
end;

procedure TfrmFatDadosFiscais.fraDadosFechamentoVendaTransportadoraFrameedtDesAceChange(Sender: TObject);
begin
  inherited;
  pExibiValImpostosiConsiginacao;
end;

procedure TfrmFatDadosFiscais.fraEmpresaFaturamentoFrame1edtCodEmpFatKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrEmpresa: TConsultasArray;
begin
  If fEntraCons(Key) Then
  begin
    If fPesqEmpresa(conEmpSimples, Self, fraEmpresaFaturamentoFrame1.edtCodEmpFat, fraEmpresaFaturamentoFrame1.edtDesEmpFat, Nil, Key, arrEmpresa) Then
    Begin
      If fValidaCampos(fraEmpresaFaturamentoFrame1.edtCodEmpFat, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end;
end;

procedure TfrmFatDadosFiscais.fraReferenciarDocumentosExteriorbtnRefeDocClick(
  Sender: TObject);
begin
  inherited;

  If (fatVenda.strOpcDoc = 'OF') Then
  Begin
    pPreencheChavesAcesso;
  End;

  fraReferenciarDocumentosExterior.btnRefeDocClick(Sender);

end;

function TfrmFatDadosFiscais.fRetornaMensagemClaDem : String;
  Var
    strAux: String;
begin
  strAux := '';
  Result := '';
  Result := fTransform(fCfgSis('CLADEM'),3,', ')+ '.';
  strAux := RightStr(Result,8);
  Result := AnsiReplaceStr(Result,strAux,'');
  strAux := Copy(strAux,2,4);
  Result := Result + ' e ' + strAux + '.';
end;

function TfrmFatDadosFiscais.fRetornaMensagemClaUC : String;
  Var
    strAux: String;
    arrAux: TStringDynArray;
    intCont: Integer;
begin
  Result := '';
  strAux :=  fTransform(fCfgSis('CLA_UC'),3,'_');
  strAux := LeftStr(strAux, strAux.Length - 1);
  arrAux := SplitString(strAux, '_');

  If (Length(arrAux) > 1) Then
  Begin
    strAux := '';
    For intCont := 0 To Length(arrAux) - 1 Do
    Begin
      If (intCont < Length(arrAux) - 2) Then
        strAux := strAux + arrAux[intCont] + ', '
      Else  If (intCont = Length(arrAux) - 2) Then
        strAux := strAux + arrAux[intCont]
      Else
        strAux := strAux + ' e ' + arrAux[intCont];
    End;

  End
  Else
   strAux := arrAux[0];

  Result := strAux + '.';
end;

function TfrmFatDadosFiscais.fRetornaQuantidadeDeItensNaNota(
  Itens: TMatrizFechamento): Double;
var
  item: TDadosFechamento;
begin
  Result := 0;

  for item in Itens do
  begin
    Result := Result + item.fltQtdIte;
  end;
end;

function TfrmFatDadosFiscais.fTransferenciaDeMarcadoriasValidandoEnquadramentoDeIPI(strOpcDoc, strClaFis: String): Boolean;
begin
  Result := False;

  If not fCfgSis('CONIPI', varBoolean) Then
    Exit;

  If not fCfgSis('UTIABI', varBoolean) Then
    Exit;

  If not (Pos(strOpcDoc, 'VN_OR_PD_CP_') > 0) Then
    Exit;

  If not (Pos(RightStr(fatVenda.strClaFis, 3), '151_152_408_409_') > 0) Then
    Exit;

  Result := True;
end;

function TfrmFatDadosFiscais.fEhOutrasSaidasDeFornecedorDevolucao(strOpcDoc, strClaFis: String): Boolean;
begin
  Result := False;

  If not (strOpcDoc = 'OF') Then
    Exit;

  If not (Pos(strClaFis, VS_strClaDev + VS_strClaDVC) > 0) Then
    Exit;

  Result := True;
end;

function TfrmFatDadosFiscais.fEhOutrasSaidasDeFornecedorDevolucao: Boolean;
begin
  Result := (fEhOutrasSaidasDeFornecedorDevolucao(fatVenda.strOpcDoc, fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text)) Or
            (fEhOutrasSaidasDeFornecedorDevolucao(fatVenda.strOpcDoc, fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text)) Or
            (fEhOutrasSaidasDeFornecedorDevolucao(fatVenda.strOpcDoc, fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text));
end;

function TfrmFatDadosFiscais.fConfirmaAlteracaoFrete(const fltValorFrete, fltNovoValorFrete: Double): Boolean;
Const
  OP_SIM: Integer = 1;
Var
  Msg: String;
begin
  Msg := 'O novo valor de frete sugerido para operação é R$ %0:s.'+slinebreak;
  Msg := Msg + 'Porém o espelho do documento contém o valor de R$ %1:s.'+SlineBreak;
  Msg := Msg + 'Confirma a alteração no valor do frete?';

  Msg := Format(Msg,[FormatFloat('#,##0.00', fltNovoValorFrete),  //0
                     FormatFloat('#,##0.00', fltValorFrete)]);    //1

  Result := fMensagem('Atenção!',
                      Msg,
                      ['&Sim','&Não'],OP_SIM) = OP_SIM;
end;

function TfrmFatDadosFiscais.fEhDevolucaoDeFornecedorComDiferimento: Boolean;
Var
  intContador: Integer;
begin
  Result := false;

  For intContador := 0 To Length(fatVenda.arrMatItens) -1 Do
  Begin
    If fatVenda.fEhDevolucaoDeFornecedorComDiferimento(fatVenda.arrMatItens[intContador]) Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TfrmFatDadosFiscais.fEhNotaEspecialComSolicitacaoDeNotaReferenciada: Boolean;
begin
  Result := ((fatVenda.strOpcDoc = 'NE') And (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, fCfgSis('CFTRNS', varString))  > 0));
end;

function TfrmFatDadosFiscais.fEhNotaOriginadaDaExpedicaoComSolicitacaoDeNotaReferenciada: Boolean;
begin
  Result := ((blnExpedicao) And (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, fCfgSis('CFTRNE', varString))  > 0));
end;

function TfrmFatDadosFiscais.fExistePercentualDiferimentoParaDevolucaoDeFornecedor: Boolean;
Var
  intContador: Integer;
begin
  Result := false;

  For intContador := 0 To Length(fatVenda.arrMatItens) -1 Do
  Begin
    If fatVenda.fEhDevolucaoDeFornecedorComDiferimento(fatVenda.arrMatItens[intContador]) Then
    Begin
      Result := (fatVenda.fRetornaPercentualDiferimento(fatVenda.arrMatItens[intContador].strCodIte, fatVenda.arrMatItens[intContador].strEmpIte) > 0);

      If not Result Then
      Begin
        fMensagem('', 'Informe o percentual de diferimento na abreviação fiscal ['+fatVenda.arrMatItens[intContador].strCodAbf+'] !', ['&Ok']);
        Break;
      End;
    End;
  End;

end;

function TfrmFatDadosFiscais.fPermiteDefinicaoDoFrete: Boolean;
begin
  Result := True;

  If (fatVenda.strOpcDoc = 'GF') Then
    Exit(True);

  If (fatVenda.strOpcDoc = 'OF') And (blnEspelhoEnvioParaOFornecedor) Then
    Exit(True);
end;

function TfrmFatDadosFiscais.fEhClassificacaoDeOutrasSaidas(AClaFis: String): Boolean;
begin
  VS_strClaNfo := fTransform(fCfgSis('CLANFO'), 4);
  VS_strClaNOE := fTransform(fCfgSis('CLANOE'), 4);

  Result := True;

  If (StrToIntDef(LeftStr(AClaFis, 1), 4) < 5) Then
    Exit(False);

  If (Pos(AClaFis, VS_strClaNfo) <= 0) Then
    Exit(False);
end;

function TfrmFatDadosFiscais.fEhConfirmacaoEspelhoEnvioFornecedor: Boolean;
  Var
    lblnOusafo: Boolean;
begin
  lblnOusafo := fCfgSis('OUSAFO', varString) = '2';
  Result := (Pos(fatVenda.strOpcDoc, 'GF_OF_') > 0);
  Result := Result and lblnOusafo and fatVenda.blnConfirmacaoEspelho;
end;

function TfrmFatDadosFiscais.fPreValidacaoDeProdutoRevendaDentroDoEstado(strClaFis:String):Boolean;
var
  blnImpDir: Boolean;
  blnEh5403: Boolean;
  LItem: TDadosFechamento;
begin
  blnImpDir := fCfgSis('IMPDIR',varBoolean);
  blnEh5403 := (strClaFis = '5403');
  Result := False;
  for LItem In fatVenda.arrMatItens Do
    if fatVenda.fDentroDoEstado(LItem.strEmpIte) then
      if (fatVenda.fGetUFEmpresa(LItem.strEmpIte) = 'RJ') And blnImpDir And blnEh5403 then
        Result := True;
End;

procedure TfrmFatDadosFiscais.pCarregaConfiguracoesParaNotaDeImportacaoDesonerada;
Begin
  dspConfiguracaoNotaDeImportacaoDesonerada := TUniDataSetProvider.Create(Self);
  cdsConfiguracaoNotaDeImportacaoDesonerada := TUniClientDataSet.Create(Self);
  qryConfiguracaoNotaDeImportacaoDesonerada := fCriaQuery(Self);
  dspConfiguracaoNotaDeImportacaoDesonerada.DataSet := qryConfiguracaoNotaDeImportacaoDesonerada;
  cdsConfiguracaoNotaDeImportacaoDesonerada.SetProvider(dspConfiguracaoNotaDeImportacaoDesonerada);

  qryConfiguracaoNotaDeImportacaoDesonerada.Close;
  qryConfiguracaoNotaDeImportacaoDesonerada.SQL.Text := 'SELECT * FROM CFGDNI';
  qryConfiguracaoNotaDeImportacaoDesonerada.Open;

  pSetaClient(qryConfiguracaoNotaDeImportacaoDesonerada);
  cdsConfiguracaoNotaDeImportacaoDesonerada.Open;
End;

procedure TfrmFatDadosFiscais.pRetornaConfiguracoesParaNotaDeImportacaoDesonerada(strCodFis: String);
Begin
  recConfiguracaoNotaDeImportacaoDesonerada.strCstPis := '09';
  recConfiguracaoNotaDeImportacaoDesonerada.strCstCof := '09';
  recConfiguracaoNotaDeImportacaoDesonerada.strCstIpi := '05';
  recConfiguracaoNotaDeImportacaoDesonerada.strEnqIpi := '126';

  If cdsConfiguracaoNotaDeImportacaoDesonerada.Locate('DNI_CSTICM', strCodFis, []) Then
  Begin
    recConfiguracaoNotaDeImportacaoDesonerada.strCstPis := cdsConfiguracaoNotaDeImportacaoDesonerada.FieldByName('DNI_CSTPIS').AsString;
    recConfiguracaoNotaDeImportacaoDesonerada.strCstCof := cdsConfiguracaoNotaDeImportacaoDesonerada.FieldByName('DNI_CSTCOF').AsString;
    recConfiguracaoNotaDeImportacaoDesonerada.strCstIpi := cdsConfiguracaoNotaDeImportacaoDesonerada.FieldByName('DNI_CSTIPI').AsString;
    recConfiguracaoNotaDeImportacaoDesonerada.strEnqIpi := cdsConfiguracaoNotaDeImportacaoDesonerada.FieldByName('DNI_ENQIPI').AsString;
  End;
End;

procedure TfrmFatDadosFiscais.pConfirmDados;
begin
  pSetFocus(btnConfirmaDados);
end;

function TfrmFatDadosFiscais.fEhOutrasSaidasDeFornecedorDevolucaoComIcmsDesonerado(strCodFis: String; fltVrdIcm: Double): Boolean;
begin
  Result := False;

  If not fEhOutrasSaidasDeFornecedorDevolucao(fatVenda.strOpcDoc, fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text) Then
    Exit;

  If not (Pos(Copy(strCodFis, 2, 2), '30_40_41_50_') > 0) Then
    Exit;

  If not (fltVrdIcm > 0) Then
    Exit;

  Result := True;
end;

function TfrmFatDadosFiscais.fEhVendaNormalFechadaEmDocumentoFiscalComSolicitacaoDeNotaReferenciada: Boolean;
begin
  Result := ((fatVenda.strOpcDoc = 'VN') And (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, fCfgSis('CFTRNE', varString))  > 0));
end;

function TfrmFatDadosFiscais.fEhVendaNormalFechadaEmNotaEspecialComSolicitacaoDeNotaReferenciada: Boolean;
begin
  Result := ((fatVenda.strOpcDoc = 'VN') And (LowerCase(fatVenda.strTipFat) = 'nota especial') And (Pos(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text, fCfgSis('CFTRNS', varString))  > 0));
end;

procedure TfrmFatDadosFiscais.pAtualizaMotivoDesoneracaoItensDeOutrasSaidasDeFornecedor;
var
  intCont: Integer;
begin

  For intCont := 0 To Length(fatVenda.arrMatItens) -1 Do
  Begin
    If fEmptyStr(fatVenda.arrMatItens[intCont].strMtdIcmOri) Then
      fatVenda.arrMatItens[intCont].strMtdIcmOri := fatVenda.arrMatItens[intCont].strMtdIcm;

    If fEhOutrasSaidasDeFornecedorDevolucaoComIcmsDesonerado(fatVenda.arrMatItens[intCont].strCodFis,
                                                             fatVenda.arrMatItens[intCont].fltVrdIcm) Then
    Begin
      fatVenda.arrMatItens[intCont].strMtdIcm := '9';
    End
    Else
    Begin
      fatVenda.arrMatItens[intCont].strMtdIcm := fatVenda.arrMatItens[intCont].strMtdIcmOri;
    End;
  End;

end;

procedure TfrmFatDadosFiscais.pNotaEspecialComplementarDeIPI;
var
  intContador: Integer;
begin
  If fatVenda.fEhNotaEspecialComplementarDeIPI Then
  Begin
    fatVenda.strClaFis := LeftStr(fatVenda.strClaFis, 1) + '949';

    For intContador := 0 To Length(fatVenda.arrMatItens)-1 Do
    Begin
      fatVenda.arrMatItens[intContador].strClaFis := LeftStr(fatVenda.arrMatItens[intContador].strClaFis, 1) + '949';
      fatVenda.arrMatItens[intContador].strCodFis := '090';
      fatVenda.arrMatItens[intContador].strCodSit := '090';
    End;
  End;
end;

function TfrmFatDadosFiscais.fEhNotaComplementarDeCapa: Boolean;
begin
  Result := False;

  If not (fatVenda.strOpcDoc = 'NC') Then
    Exit;

  If fatVenda.objNfeComplemento.blnTemItens Then
    Exit;

  Result := True;
end;

function TfrmFatDadosFiscais.fSomaDespesasAcessorias: Boolean;
var
  LDespesasAcessorias: Double;
  LTotalImpostosImportacao: Double;
begin
  Result := True;

  If not blnNotImp Then
    Exit;

  LDespesasAcessorias := fStrToFloat(fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text);

  LTotalImpostosImportacao := fatVenda.fltDesAdu +
                              fatVenda.fltValIof +
                              fatVenda.fltImpTax +
                              fatVenda.fltTotPis +
                              fatVenda.fltTotCof +
                              fatVenda.fltTotRmm;

  Result := (Abs(LDespesasAcessorias - LTotalImpostosImportacao) > 0.05);
end;

function TfrmFatDadosFiscais.fSomaOutrasDespesasImportacaoDefinidoConfiguracao: Double;
begin
  If Assigned(PerfilDespachanteAduaneiro) then
  begin
    Result := 0;
    If tcvoDESPESAS_ADUANEIRAS in PerfilDespachanteAduaneiro.ComposicaoValorOutras then
      Result := Result + fatVenda.fltDesAdu;
    If tcvoIOF in PerfilDespachanteAduaneiro.ComposicaoValorOutras then
      Result := Result + fatVenda.fltValIof;
    If tcvoPIS in PerfilDespachanteAduaneiro.ComposicaoValorOutras then
      Result := Result + fatVenda.fltTotPis;
    If tcvoCOFINS in PerfilDespachanteAduaneiro.ComposicaoValorOutras then
      Result := Result + fatVenda.fltTotCof;
    If tcvoSISCOMEX in PerfilDespachanteAduaneiro.ComposicaoValorOutras then
      Result := Result + fatVenda.fltImpTax;
    If tcvoAFRMM in PerfilDespachanteAduaneiro.ComposicaoValorOutras then
      Result := Result + fatVenda.fltTotRmm;
  end
  Else
    Result := fatVenda.fltDesAdu +
      fatVenda.fltValIof +
      fatVenda.fltImpTax +
      fatVenda.fltTotPis +
      fatVenda.fltTotCof +
      fatVenda.fltTotRmm;
end;


procedure TfrmFatDadosFiscais.fraDadosFechamentoVendaTransportadoraFramechkRetornoPorRecusaClick(Sender: TObject);
begin
  inherited;
  fatVenda.blnRetornoPorRecusa := fraDadosFechamentoVendaTransportadoraFrame.chkRetornoPorRecusa.Checked;
end;

function TfrmFatDadosFiscais.fSomaDespesasAcessoriasImportacao: Double;
Begin
    Result := fatVenda.fltDesAdu +
      fatVenda.fltValIof +
      fatVenda.fltImpTax +
      fatVenda.fltTotPis +
      fatVenda.fltTotCof +
      fatVenda.fltTotRmm;
End;

function TfrmFatDadosFiscais.fRetornaUFEmpresa: String;
begin
  Result := fCadEmp('ESTADO');

  If not fatVenda.fEhDevAutomatizadaDocOutraEmpresa Then
    Exit;

  Result := fCadEmpDes('ESTADO', fatVenda.strEmpDocDev);
end;

function TfrmFatDadosFiscais.fHabilitarTrocaDeCfopNaDigitacaoDeImpostos: Boolean;
begin
  Result := False;

  If fHabilitarTrocaDeCfopNaDigitacaoDeImpostosParaNotaDeImportacao Then
    Exit(True);

  if not (Pos(fatVenda.strOpcDoc, 'OF_GF_') > 0) then
    Exit;

  If fEmptyStr(fatVenda.strClaFi2) Then
    Exit;

  If not fEhClassificacaoDeOutrasSaidas(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text) Then
    Exit;

  If not fCfgSis('DIGCFO',varBoolean) Then
    Exit;

  Result := True;
end;

function TfrmFatDadosFiscais.fHabilitarTrocaDeCfopNaDigitacaoDeImpostosParaNotaDeImportacao: Boolean;
begin
  Result := False;

  If not blnNotImp Then
    Exit;

  If not (fContarOcorrenciasCaractere(VS_strClaImp,'_') > 1) Then
    Exit;

  Result := True;
end;

function TfrmFatDadosFiscais.fEhClassificacaoDeOutrasSaidasDeFornecedor(AClaFis: String): Boolean;
begin
  Result := False;

  If not (fatVenda.strOpcDoc = 'OF') Then
    Exit;

  Result := fEhClassificacaoDeOutrasSaidas(AClaFis);
end;

function TfrmFatDadosFiscais.fExiteClassificacaoDeOutrasSaidasDeFornecedor: Boolean;
begin
  Result := False;

  If not (fatVenda.strOpcDoc = 'OF') Then
    Exit;

  Result := fEhClassificacaoDeOutrasSaidas(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text) Or
            fEhClassificacaoDeOutrasSaidas(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text) Or
            fEhClassificacaoDeOutrasSaidas(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text);
end;

function TfrmFatDadosFiscais.fValidaConsistenciaDasCfops: Boolean;

  function fAchouClaFis(const AClaFis : String) : Boolean;
    Var
      intContador : Integer;
  begin
    Result := False;
    For intContador := 0 To Length(fatVenda.arrMatItens) -1 Do
    Begin
      If (fatVenda.arrMatItens[intContador].strClaFis = AClaFis) Then
      Begin
        Result := True;
        Break;
      End;
    End;
  end;

begin
  Result := True;

  If (fatVenda.strOpcDoc = 'NC') Then
    Exit;

  If fEmptyStr(fatVenda.strClaFi2 + fatVenda.strClaFi3) Then
    Exit;

  If (Not fEmptyStr(fatVenda.strClaFi2)) Then
  Begin
    If (Not fAchouClaFis(fatVenda.strClaFi2)) Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!','A classificação fiscal (2) ' + fatVenda.strClaFi2 + ' não foi encontrada nos itens do documento' + sLineBreak +
                          'Se for o caso remova o preenchimento desta classificação e pressione [ENTER] para validar o campo', ['&OK']);
      Exit;
    End;
  End;

  If (Not fEmptyStr(fatVenda.strClaFi3)) Then
  Begin
    If (Not fAchouClaFis(fatVenda.strClaFi3)) Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!','A classificação fiscal (3) ' + fatVenda.strClaFi3 + ' não foi encontrada nos itens do documento' + sLineBreak +
                          'Se for o caso remova o preenchimento desta classificação e pressione [ENTER] para validar o campo', ['&OK']);
      Exit;
    End;
  End;
end;

function TfrmFatDadosFiscais.fDeveAtualizarOsTotaisEmTela : Boolean;
begin
  Result := (fSomarNovosImpostosDaReformaAoValorContabil) And (Pos(fatVenda.strOpcDoc, 'OU_BR_OE_OF_NE_') > 0);
end;

function TfrmFatDadosFiscais.fClassificacoesDaTela : String;
begin
  Result := fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text + '|' +
            fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text + '|' +
            fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text;
end;

function TfrmFatDadosFiscais.fClassificacoesDaTelaMudaram : Boolean;
begin
  Result := (FStrClassificacoesCalculadas <> fClassificacoesDaTela);
end;

procedure TfrmFatDadosFiscais.pGuardaClassificacoesOriginaisDosItens;
  Var
    intContador : Integer;
begin
  SetLength(FArrClaFisOriginalItens, Length(fatVenda.arrMatItens));
  For intContador := 0 To Length(fatVenda.arrMatItens) -1 Do
    FArrClaFisOriginalItens[intContador] := fatVenda.arrMatItens[intContador].strClaFis;

  FStrClaFisOriginal1 := fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text;
  FStrClaFisOriginal2 := fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text;
  FStrClaFisOriginal3 := fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text;
  FStrClassificacoesCalculadas := fClassificacoesDaTela;
end;

function TfrmFatDadosFiscais.fAplicouClassificacoesDaTelaNaMatriz : Boolean;
  Var
    intContador : Integer;
    strClaAnt1  : String;
    strClaAnt2  : String;
begin
  Result := (Length(FArrClaFisOriginalItens) > 0) And (Length(FArrClaFisOriginalItens) = Length(fatVenda.arrMatItens));
  If Not Result Then
    Exit;

  For intContador := 0 To Length(fatVenda.arrMatItens) -1 Do
    fatVenda.arrMatItens[intContador].strClaFis := FArrClaFisOriginalItens[intContador];

  strClaAnt1 := FStrClaFisOriginal1;
  strClaAnt2 := FStrClaFisOriginal2;
  If fInverteuPosicaoDasClassificacoes(strClaAnt1, strClaAnt2) Then
  Begin
    strClaAnt2 := strClaAnt1;
    strClaAnt1 := fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text;
  End;

  pJogaClassificacoesParaOsItens(strClaAnt1, strClaAnt2, FStrClaFisOriginal3);
  FStrClassificacoesCalculadas := fClassificacoesDaTela;
end;

procedure TfrmFatDadosFiscais.pJogaClassificacoesParaOsItens(const strClaAnt1, strClaAnt2, strClaAnt3 : String);
begin
  {*************************************}
  {* JOGA CLASSIFICAÇÕES PARA OS ITENS *}
  {**********************************AF*}
  If (strClaAnt1 <> fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text) Then pAtualizaMatItens(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text,strClaAnt1, strClaAnt1);
  If (strClaAnt2 <> fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text) Then pAtualizaMatItens(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text,strClaAnt2, strClaAnt2);
  If (strClaAnt3 <> fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text) Then pAtualizaMatItens(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text,strClaAnt3, strClaAnt3);

  If blnNotImp And (not fatVenda.blnInformouDrawback) Then
    pAtualizaMatItens(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text,fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text,fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text);

  {*******************************************}
  {* QUANDO FOR OUTRAS ENTRADAS TERÁ O MESMO *}
  {* COMPORTAMENTO DA OUTRAS SAÍDAS.         *}
  {****************************************PZ*}
  If (Pos(fatVenda.strOpcDoc, 'OU_BR_OE_OF_NE_') > 0) And
     (fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text) Or
       (fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text = fraDadosFechamentoVendaClaFisFrame.edtClaFi2.Text)) And
     (fEmptyStr(fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text) Or
       (fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text = fraDadosFechamentoVendaClaFisFrame.edtClaFi3.Text)) Then
  Begin
    pAtualizaMatItensOutrasSaidas(fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text);
  End;
end;

end.

