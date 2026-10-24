unit untFatBaixaEntregaFutura;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
   Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask, untMensagemExplicativa, 
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, untFuncoesSimples,
  untFuncFat, untFuncFatTypes, StrUtils, MaskUtils, System.Generics.Collections,
  BitBtnLockedIncrem, DBCtrls, untTypesSistema, cxProgressBar,
  DBEditFocus, untControleEntregaRomaneio, untCadLote, untIteBar, Gauges,
  frxClass, frxDBSet, frxDMPExport, ComboBoxFocus, MemDS, DBAccess, Provider,
  frxExportCSVTestabilidade, Datasnap.DBClient, untLiberacao, untTLock,
  untLiberacaoFactory, untILiberacao, untTFatReprocessarSaldoItem, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  untFatMostraProdSemSaldo, System.Types, Faturamento.View.DadosCTe, untTipoFreteAtc,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGrid, cxClasses, cxGridDBBandedTableView;

const intTamMinDET_DESCRI: Integer = 250;

Type
  TTipoFrete = (frComFrete, frSemFrete);
  TTipoBaixa = (bxBaixaNormal, bxBaixaAutomatica, bxDevolucaoAutomatica);

type
  TfrmFatBaixaEntregaFutura = class(TfrmPaiOrdena)
    edtCodCliente: TEditFocus;
    Label1: TLabel;
    edtDesCliente: TEditFocus;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    btnEndEnt: TBitBtnLocked;
    btnAlteraMotivo: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    gpbMotivo: TGroupBox;
    chkFalta: TCheckBox;
    chkAguarda: TCheckBox;
    chkPrevisao: TCheckBox;
    Label2: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label3: TLabel;
    mskDtaFin: TMaskEditFocus;
    btnEndEntDoc: TBitBtnLocked;
    lbl2: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    Label4: TLabel;
    lblCodIte: TLabel;
    lblQtdIte: TLabel;
    edtCodIte: TEditFocus;
    edtQtdIte: TEditFocus;
    pnlLegendExp: TPanel;
    shp1: TShape;
    shp2: TShape;
    shp3: TShape;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    btnQtdIte: TSpeedButton;
    edtTotalPeso: TEditFocus;
    pnlLegendSep: TPanel;
    shp6: TShape;
    lbl7: TLabel;
    pgbProgresso: TcxProgressBar;
    shp4: TShape;
    lbl1: TLabel;
    lblInformacao: TLabel;
    btnImpSep: TBitBtnLocked;
    chkSepImp: TCheckBox;
    tmrInformacao: TTimer;
    lblCliBus: TLabel;
    cmbCliBus: TComboBoxFocus;
    Label5: TLabel;
    lblDocFat: TLabel;
    edtDocFat: TEditFocus;
    lblEspFat: TLabel;
    edtEspFat: TEditFocus;
    btnLimpaSeparacao: TBitBtnLocked;
    btnEstLoj: TBitBtnLocked;
    Label6: TLabel;
    Label8: TLabel;
    chkExibirProdQtdeEntregarPreenchida: TCheckBox;
    btnFrete: TBitBtnLocked;
    cxstylrpstryGrupo: TcxStyleRepository;
    cxstylGrupo: TcxStyle;
    cxstylFooter: TcxStyle;
    dbgDadosItens: TcxGrid;
    dbgvDadosItens: TcxGridDBTableView;
    dbgvDadosItensDET_MOTFUT: TcxGridDBColumn;
    dbgvDadosItensDET_CLIBUS: TcxGridDBColumn;
    dbgvDadosItensDTAFUT: TcxGridDBColumn;
    dbgvDadosItensGER_DTAENT: TcxGridDBColumn;
    dbgvDadosItensGER_NUMDOC: TcxGridDBColumn;
    dbgvDadosItensGER_ESPDOC: TcxGridDBColumn;
    dbgvDadosItensGER_CODEMP: TcxGridDBColumn;
    dbgvDadosItensDET_CODITE: TcxGridDBColumn;
    dbgvDadosItensDET_DESCRI: TcxGridDBColumn;
    dbgvDadosItensITE_SALDOS: TcxGridDBColumn;
    dbgvDadosItensDET_NUMLOT: TcxGridDBColumn;
    dbgvDadosItensDET_QTDITE: TcxGridDBColumn;
    dbgvDadosItensQTDENT: TcxGridDBColumn;
    dbgvDadosItensQTDJDV: TcxGridDBColumn;
    dbgvDadosItensDET_QTDPEN: TcxGridDBColumn;
    dbgvDadosItensSEP_QTDIMP: TcxGridDBColumn;
    dbgvDadosItensPENSEP: TcxGridDBColumn;
    dbgvDadosItensDET_QTDAEN: TcxGridDBColumn;
    dbgvDadosItensQTDDEV: TcxGridDBColumn;
    dbgvDadosItensDET_COMPLE: TcxGridDBColumn;
    dbgvDadosItensDET_QTDENT: TcxGridDBColumn;
    dbgvDadosItensQTDFUT: TcxGridDBColumn;
    dbglDadosTintas: TcxGridLevel;
    dbgvDadosItensITE_SALDIS: TcxGridDBColumn;
    dbgvDadosItensDET_LOCFIS: TcxGridDBColumn;
    dbgvDadosItensITE_CODFAB: TcxGridDBColumn;
    dbgvDadosItensDET_REFERE: TcxGridDBColumn;
    dbgvDadosItensVENDEDOR: TcxGridDBColumn;
    btnBaixaSimplificada: TBitBtnLocked;
    btnImpRelatorio: TBitBtnLocked;
    dbgvDadosItensPEDVEN: TcxGridDBColumn;
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cdsConsultaBeforePost(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodClienteEnter(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure cdsConsultaAfterPost(DataSet: TDataSet);
    procedure btnEndEntClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAlteraMotivoClick(Sender: TObject);
    procedure btnEndEntDocClick(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnQtdIteClick(Sender: TObject);
    procedure btnImpSepClick(Sender: TObject);
    procedure tmrInformacaoTimer(Sender: TObject);
    procedure cdsConsultaAfterOpen(DataSet: TDataSet);
    procedure cdsConsultaAfterCancel(DataSet: TDataSet);
    procedure btnLimpaSeparacaoClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnEstLojClick(Sender: TObject);
    procedure dtsConsultaStateChange(Sender: TObject);
    procedure chkExibirProdQtdeEntregarPreenchidaClick(Sender: TObject);
    procedure btnFreteClick(Sender: TObject);
    procedure dbgvDadosItensCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure dbgvDadosItensDblClick(Sender: TObject);
    procedure dbgvDadosItensEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure btnBaixaSimplificadaClick(Sender: TObject);
    procedure btnImpRelatorioClick(Sender: TObject);
  private
    { Private declarations }
    objCadLot    : TCadLot;
    blnEndDif    : Boolean;
    blnAltEnd    : Boolean;
    blnTestarPost: Boolean;
    arrGrupos: TConsultasArray;

    strEndSel: String;

    recEndere: TrecEnderecoEntrega;

    blnCancelou: Boolean;
    blnCancelar: Boolean;
    blnComSenha: Boolean;
    blnLiberou : Boolean;
    blnPermFF  : Boolean;

    cdsAux: TUniClientDataSet;
    cdsControle: TUniClientDataSet;
    fatVenda : TFatVenda;
    qryCadCli: TUniQuery;

    cdsSubProdutos: TUniClientDataSet;

    strTabela    : String;
    blnMarcaTodos: Boolean;

    blnTrocouLote: Boolean;
    blnValidaMarcarTodos: Boolean;

    strCodIte: String;
    strCodDig: String;
    strCamBus: String;
    strCodTin: String;

    blnUsaSelEnt : Boolean;
    bln2CodBar   : Boolean;
    strCodIteFor : String;

    blnSimulandoNavegacaoGrid: Boolean;

    fltFreRatAux: Double;
    fltTotEnt: Double;
    fltTotPes: Double;
    fltTotDev: Double;

    objIteBar: TIteBar;

    blnPodAltSep: Boolean;

    strInformacao: String;

    strCgcCpfSel: String;
    strCgcConSel: String;
    strNomConSel: String;

    arrMenDoc: array[1..2] of String;

    cdsQtdDig: TUniClientDataSet;

    dtaDtEntr: TDatetime;

    blnUtilizaIteRetSaldo: Boolean;

    blnDocOri: Boolean;
    blnUtiWms: Boolean;
    blnInformaSaldoGeralDisponivel: Boolean;

    objLiberacao : TLiberacao;
    objLock: TLock;

    stlDocsConf : TStringList;
    objReprocessarSaldoItens: IReprocessarSaldoItem;

    frmFatMostraProdSemSaldo: TfrmFatMostraProdSemSaldo;

    FblnTemDevolucao,
    FblnTemEntrega : Boolean;
    blnEscolheuFechamentoEmPedido: Boolean;
    blnPermiteEscolherEspecie: Boolean;

    blnValidandoAfterPost  : Boolean;

    FstrDocumentoParaDevolucao,
    FstrEspecieParaDevolucao,
    FstrEmpresaParaDevolucao  : String;
    FcdsValoresItensDocumentoBaixa : TUniClientDataSet;
    strAutoincMovsBaixaSimplificada: String;
    strFiltroCodCliBaixaSimplificada: String;
    strFiltroCodCidBaixaSimplificada: String;
    stlProdReqCompraLiberado: TStringList;

    function fAbrirTelaDeDevolucaoDeBaixaDeEntregaFutura(const blnFezDevolucaoAutomatica: Boolean): Boolean;
    procedure pConfirmarBaixaEntregaFutura;

    procedure pAlteraEnderecoEntregaDocumento;
    function fAvaliaEstoque(pgbProgresso: TcxProgressBar): Boolean;
    procedure pCarregaCliente;
    procedure pCarregarCliente(fatVenda: TFatVenda);
    procedure pInicializaTemporaria;
    procedure pFormataCampos;
    //procedure pAtualizaMovDet(cdsAux: TUniClientDataSet);
    procedure pAlteraEnderecoEntregaParaBaixa;
    procedure pAtualizaEndSel;
    procedure pCalcularTotais;

    procedure pProcessaSaldoDisponivel(var aFltSaldo, aFltSaldosSemLote: Double; var aStrMotFutAConsiderar: String);
    Function fAlteraEntregaFutura(dtaDtaRes,
                                  dtaDtaFut: TDate;
                                  strMotivo: String;
                                  strCliBus: String;
                                  objConEnt: TControleEntregaRomaneio): Boolean;

    Function fIncluiItens(fatVenda: TFatVenda; Const opcBaixa: TTipoBaixa): Boolean;
    Function fGetTipoFaturamento(fatVenda: TFatVenda; AblnEhDevolucao : Boolean = False): Boolean;
    function fRetQtdDigitada(strCodIte: String; strNumLot: String; strMotFutAConsiderar: String=''): Double;
    Function fGetItem(qryGenIte: TUniQuery; strCodIte: String): Boolean;
    Function fTestaEstoque: Boolean;
    function fPermiteGravacaoImpressao: Boolean;
    function fLimpaPrevisaoEntFut: Boolean;
    function fTrocaLotePadrao(Var strNovoLote: String; Var blnLiberou: Boolean): Boolean;
    Function fSelecionaEnderecoEntrega: Boolean;
    Function fSalvaEnderecoEntrega(strAutInc, strAutEnt, strEntAnt: String): Boolean;
    Function fAtualizaEnderecoGrid(strSeqGer, strEntGer: String): Boolean;
    Function fTravaBaixa: Boolean;
    procedure pControlaFoco;
    procedure pExpedeItem;
    function fEncontraItem(var strMensagem: String; blnApenasSimular: Boolean = False): Boolean;
    function fProcuraSemelhante(strCodBar: String; var strCodSem: String): Boolean;
    procedure pOnFilter(DataSet: TDataSet; var Accept: Boolean);

    function fVerificaQtdEstoque( fltSaldos: Double;
                                  fltQtdIte: Double;
                              var strSemEst: String;
                                  blnComSenha: Boolean;
                              var blnPedSen,
                                  blnSemEst: Boolean;
                                  recTinFor: TForTin;
                                  fltSaldosSemLote: Double = 0;
                                  strMotFutAConsiderar: String = '' ): Boolean;

    function fGetDescontoEspecialJaUtilizado(strDocFut, strEspFut, strEmpFut,
      strIteFut, strIncFut: String; fltUniFut: Double): Double;

    function fGetItemMaisDe1VezNoDocumento(strDoc, strEsp, strEmp, strIte: String): Boolean;

    procedure pMarcaTodosProdutosQuePodemSerAtendidos;
    function fPodeAlterarQuantidadeAEntregar: Boolean;
    Function fPermiteBaixa: Boolean;

    function fValidaTravaDevolucaoClienteComIES():Boolean;

    function fPedeTelaMensagens: Boolean;

    function fTravaFaturamentoItensComOrigemDiferente: Boolean;

    function fSelecionaConsumidor: Boolean;
    function fFiltraConsumidor: Boolean;

    function fDefineDataEntrega: Boolean;

    procedure pOnClickModoConsulta(Sender: TObject);

    procedure pAbreConsulta;
    function fChvDoc(blnMsg: Boolean=False): String;
    procedure pUnLockTodos;
    procedure pUnLockTodosConf;
    procedure pLockTodos;
    function fLockTodos(pgbStatus: TcxProgressBar = Nil): Boolean;

    procedure pCriaClientCdsQtdDig;
    procedure pSalvaQtdDig;
    procedure pRestauraQtdDig;
    procedure pLiberaGrid;
    Function fValidaMultiploVenda(fltQtdIte, fltMltVen: Double; DataSet: TDataSet = Nil): Boolean;

    procedure pGerarDocumentoFormulacaoItens(fatVenda : TFatVenda);
    function fSQLQtdEnt(strAlias: String = 'D'): String;

    procedure pAcertaSaldoDisponivel; overload;
    procedure pAcertaSaldoDisponivel(DataSet: TDataSet); overload;

    function fValidaVendaPresencial(strVenPreAtu: String): Boolean;

    procedure pVisibilidadeColunaLote;

    procedure pAcertaSaldoDisponivelNovoLote;

    function fCampoDocumentoPreenchido: Boolean;
    function fSQLFiltroMinimo: string;
    function fAchouPorDocumento: Boolean;
    procedure pZeraConsulta;

    procedure pNotificarRoboParaReprocessarSaldos;
    procedure pReprocessarSaldoItensPorDocumento(const strNumDoc, strEspDoc, strCodEmp: string; strLisAut: String='');

    procedure pCriarCdsSomenteComSubItensEstrutura(blnAbrindoConsulta: Boolean);
    procedure pAjustarQuantidadeBaixaSubItensEstrutura;
    procedure pAtualizarQuantidadeSubItens(strAutInc: String; fltQtdVen, fltQtdEnt, AfltQuantidadeADevolver: Double);
    procedure pAdicionarSubItensEstruturaParaBaixaEntFut;

    function fDefineEntregaNoFaturamento(MatrizDeItens: TMatrizFechamento): string;

    function  fVaiGerarPedidodeVenda(blnConsideraTipoFechamento:Boolean=True; blnVerificarRegistroCorrente:Boolean=False): Boolean;
    function  fVerificaDocumentosEmpresaCdELogada: Boolean;
    function fEhDocumentoEmpresaCd(strEmpresaCd: string; blnEhAbastecimentoDeposito: Boolean): Boolean;
    procedure LimpaSeparacao(ASeqGer: String);
    function fRetornaIndRev(strItens: string): string;

    function fProcessarDocumento(Const opcBaixa: TTipoBaixa; Out blnPassouGravaArquivos: Boolean;
      Const blnDevolucao:Boolean; Const blnIgnorarGravarTinDet: Boolean=False) : Boolean;
    procedure pCarregaInformacoesComplementares(const strAutInc: String);

    procedure pCarregarQuantidadesDevolvidas;
    function fExisteSomenteQuantidadeADevolver : Boolean;
    function fValidarDocumentosBaixadosComDataDePrevisaoAnterior : Boolean;
    procedure pPreencheClientParaValidacaoDocumentosBaixadosComDataDePrevisaoAnterior(AblnDocumentoPassandoNafrente : Boolean;
      AintRegra : Integer; AcdsDadosDocumentos : TUniClientDataset; var AcdsDadosDavalidacao : TUniClientDataset);
    function fVerificaParamEntregaFuturaDocSelec(Const strEntFutOpc: String): Boolean;
    function fVerificaFazendaDocSelec(Const strCodFaz: String): Boolean;
    function fEhMesmoGrupoFrete: Boolean;
    procedure pMostraTravaGrupoFreteDiferente;
    function fBuscaTipoFrete: integer;

    function fTravaNotaVendaAutorizada: Boolean;
    function fRetornaValorDoFreteIformadoParaDocumentosTotalmenteBaixados: Double;
    function fRetornouDocumentosEQuantidadeDeBaixa(var strListaDeDocumentos: String; var dicQuantidadesBaixarDocumentos: TDictionary<String,Double>): Boolean;
    function fRetornaTotalFreteInformadoNosDocumentosBaixadosTotalmente(strListaDeDocumentos: String; dicQuantidadesBaixarDocumentos: TDictionary<String,Double>): Double;

    function fRetornaLarguraUtilizadaGrid : Integer;
    function fPermiteDevolverProdutos(strEmpDoc: String; fltQtdDev: Double): Boolean;
    function fValidaStatusCliente: Boolean;
    function fRetornaEmpresaFatSemSaldo: String;

    procedure pConstruirGrid;
    procedure pSumarizar(const strNomeCampo: String; const summaryKind: TcxSummaryKind; const strFormato: string;
                        const blnFooter, blnGroup, blnGroupFooter: Boolean);

    function fValidaDataEntIme(dtaEntreg: TDateTime): Boolean;
    procedure pMostraMensagemTravaEmpresasDistintas(strCodEmpDoc1, strCodEmpDoc2, strNumDoc1, strNumDoc2, strEspDoc1, strEspDoc2: String);

    function fTravaDocumentosComProducaoForaDeLoja: Boolean;
    function fRetornaSeDocumentoComProducaoForaDeLoja(strAutIncDet: String): String;
    function fAguardaAutorizacaoNFe(pgbProgresso: TcxProgressBar = nil):Boolean;
    function fVerificaDocumentoAbastecimentoPeloDeposito: Boolean;
    procedure pMostraMensagemTravaAbastecimentoPeloDeposito(strCodEmpDoc1, strCodEmpDoc2, strNumDoc1, strNumDoc2, strEspDoc1, strEspDoc2: String);
    function fRetornaSeDocumentoEhAbastecimentoDeposito: String;
    function fRetornaEmpresaOrigemPedidoAbastecimentoDeposito: String;
    function fValidaRequisitoCompra(strNumDoc, strEspDoc, strCodEmp, strCodIte: String): Boolean;
    procedure pAdicionaItemParaReprocessamentoDeSaldo(const strCodIte : String);
  public
    { Public declarations }
    strCodCliConsulta: String;
    blnSepFut: Boolean;
    blnBFut49: Boolean;
    blnExibirSomenteProdQtdeEntPreenchida: Boolean;
    blnJaValidou: Boolean;

    strCodigoCaixa: String;

    intAltForm,
    intLarForm : Integer;
    blnModoCrm : Boolean;

    pAbrirDevolucaoBaixaEntregaFutura: procedure(strCodCli: String) of object;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fGetSql(blnLike: Boolean): String; Override;
    function fAbreConsulta(blnLike: Boolean): Boolean; Override;
    function fSetParametros: Boolean; Override;
  end;



Const
  ESPECIE_FISCAL = 'NF_IF_IV_D1_';

Const
  arrSemFrete: Array[0..3] Of Integer = (1, 3, 9, 4);
  arrComFrete: Array[0..1] Of Integer = (2, 5);

implementation

uses  Math, untFatTipoFaturamento, untConsultas, untConstantes,
      untFatDigMensagemOrc, untDigCodigoLote, untFatGor,
      untFatDigDtaEntFut, untGravando, untFatDigSepConferente,
      untFuncFatImp, untObservacao, untFuncoesGenerica, untFatSelCliCon,
      untFuncoes, untPesqAux,untEnderecoEntrega,untFuncTinta,
      untFatDadosFiscais, untMadeireira, untFuncGrava, untFatTipoExpedicao,
      untProdAcabado, untDuplicatas, untMsgLiberacao, untFatInfDataHora,
      untIFatEntregaFutura, untTFatEntregaFutura, untTFatReservaSaldo, untFatAltValorFreteSuges,
      untIFatReservaSaldo, untFatDigMensagemGenerica, untFatVendas, untFatMostraEstoqueEmp,
      untFuncoesMatematicas, untFatSeparadorConferente, untcxGridDBBandedTableViewHelper,
      untFatBaixaEntregaFuturaSimpl, untTFatBaixaEntregaFutura, untFuncoesRel;

{$R *.dfm}

function fMotivosQueNaoReservaramSaldo(strMotFut: String): String;
begin
  {***************************************************************************************************************}
  {* MESMA REGRA DO ROBÔ EM untTFatEntregaFutura>TEntregaFutura.pDefineParametrosTipoAutomatica.                 *}
  {*                                                                                                             *}
  {* NAS CALSAL 3,4,5 EU POSSO TER NA BAIXA DE ENTREGA FUTURA DE UM MESMO ITEM, DOCUMENTOS ONDE O MOTIVO DA      *}
  {* ENTREGA FUTURA RESERVA SALDO (QUANDO ESTÁ ACIMA DO SALDO DISPONÍVEL NA PESQUISA) E DOCUMENTOS ONDE O        *}
  {* MOTIVO DE BAIXA DE ENTREGA FUTURA NÃO RESERVOU SALDO (QUANDO ESTÁ ABAIXO DO SALDO DISPONÍVEL NA PESQUISA)   *}
  {* ITENS QUE NÃO RESERVARAM SALDO DEVEM SER VALIDADOS PELO SALDO DISPONÍVEL, ONDE O SALDO SE DÁ PELA SOMA DO   *}
  {* SALDO FÍSICO - SALDOS RESERVADOS (SEM SOMAR AO SALDO FÍSICO OS DEMAIS MOTIVOS DE ENTREGA FUTURA QUE JÁ      *}
  {* RESERVARAM SALDO POIS ELE TEM PRIORIDADE NA BAIXA) PARA ISSO DEVEMOS SETAR TEntregaFutura.Faturamento(True) *}
  {* NO CASO DOS ITENS COM LOTE NESSA SITUAÇÃO, EU FAÇO UMA VALIDAÇÃO DUPLA PRIMEIRO GERAL, COMO SE ESTIVESSE    *}
  {* VENDENDO O PRODUTO SEM LOTE E DEPOIS A VALIDAÇÃO COM LOTE.                                                  *}
  {*                                                                                                             *}
  {************************************************************************************************************VA*}

  Case AnsiIndexStr(fCfgSis('CALSAL'), ['3', '4', '5']) Of
    0: Result := 'F';
    1: Result := 'A_P_';
    2: Result := 'A_F_';
  end;

  If (Pos(strMotFut, Result) <= 0) Then
    Result := '';
End;

procedure TfrmFatBaixaEntregaFutura.pCarregaCliente;
Begin
  pPesquisaCadCli(qryCadCli, qryCadCli, edtCodCliente.Text);
  If Not (fEmptyStr(edtCodCliente.Text)) Then
  Begin
    edtDesCliente.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString;
    If fClienteConsumidor(fRetNomCliente(edtCodCliente.Text)) And fCampoDocumentoPreenchido Then
      fAchouPorDocumento;
  End
  Else
    edtDesCliente.Text := '';

  blnPermFF := ((qryCadCli.FieldByName('CLI_PERMFF').AsString = 'S') Or (qryCadCli.FieldByName('CLI_PERMFV').AsString = 'S'));

  fatVenda.strCodCli := edtCodCliente.Text; // Cliente - Codigo
  fatVenda.strCliNom := edtDesCliente.Text; // Cliente  - Nome

  blnAltEnd := False;
End;

procedure TfrmFatBaixaEntregaFutura.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatBaixaEntregaFutura.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  inherited;

  If (Not blnFecharFormPai) And (fMensagem('', 'Deseja abandonar a tarefa?', ['&Sim', '&Não']) = 2) Then
    Action:= caNone
  Else
  Begin
    pEsvaziaArrayCfgDes;

    FreeAndNil(cdsQtdDig);
    pFreeCdsVenda;
    If Assigned(cdsSubProdutos) Then
      FreeAndNil(cdsSubProdutos);
  End;

end;

procedure TfrmFatBaixaEntregaFutura.FormCreate(Sender: TObject);
begin
  inherited;

  If (fCfgSis('USACND', varString) = 'S') And fEmptyStr(fCfgSis('CNDAVI', varString)) Then
  Begin
    pMensagemOk('É necessário realizar a configuração "CFG_CNDAVI" para prosseguir!');
    blnFecharFormPai := True;
  End;

  pEsvaziaArrayCfgDes;
  stlDocsConf := TStringList.Create;
  objReprocessarSaldoItens := TReprocessarSaldoItem.New();
  objIteBar := TIteBar.Create(opcFuncoes);
  objCadLot := TCadLot.Create(Self);
  objLiberacao := TLiberacao.Create;
  objLock := TLock.Create;

  blnEndDif     := fCfgSis('ENFDIF', varBoolean);
  strEndSel     := '';
  blnTestarPost := True;
  blnAltEnd     := False;
  blnUsaSelEnt  := False;
  blnValidaMarcarTodos := False;
  blnEscolheuFechamentoEmPedido := False;

  If Not fVerificaAcessoSistema('frmFatBaixaEntregaFuturaPar', strLoginUsuarioLogado) Then
  Begin
    btnGravar.Enabled        := False;
    btnMarcaTodos.Enabled    := False;
    btnDesmarcaTodos.Enabled := False;
    btnAlteraMotivo.Enabled  := False;

    dbgvDadosItens.OptionsData.Editing := False;
  End;

  qryCadCli := fCriaQuery;
  blnTemPesquisa := FALSE;
  blnTemSelecao  := FALSE;
  blnMarcaTodos  := FALSE;
  blnComSenha    := TRUE;
  blnLiberou     := FALSE;
  blnTrocouLote  := False;
  strTabela      := '';

  If fEmptyStr(strCodCliConsulta) Then
  Begin
    pCriarCdsVenda(Self);
    fatVenda := TFatVenda.CreateInstance('VN');
    fatVenda.strOpcDocTrue  := 'BF';
    fatVenda.blnVerEstOrc   := False;
    fatVenda.strNomeForm    := 'frmFatVendas';
    fatVenda.blnBaiEntFut   := TRUE;
    fatVenda.blnImprimeSep  := True;
    fatVenda.strCodTra      := fCfgSis('TRASUG');
    fatVenda.strEntFat      := fCfgSis('ROMEFT');
    fatVenda.dicDesEspItens := TDicionario.Create;
    fatVenda.strCodigoCaixa := strCodigoCaixa;
    fatVenda.OperacaoOrigemFaturamento := ofBaixaDeEntregaFutura;
  End;

  blnPodAltSep := False;

  cdsAux := TUniClientDataSet.Create(Self);
  cdsControle := TUniClientDataSet.Create(Self);
  pCriaClientCdsQtdDig;

  edtQtdIte.EditFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));

  blnJaValidou := False;

  blnUtiWms := fUsaRotinaWMS;
  blnDocOri := False;
  blnValidandoAfterPost := False;

  {***************************************************************************************}
  {* VERIFICA SE IRÁ ASSUMIR A ESPÉCIE DO DOCUMENTO ORIGINAL NA BAIXA DA ENTREGA FUTURA. *}
  {* SE ESTIVER CONFIGURADO PARA USAR A GERAÇÃO DE PEDIDOS PARA BAIXA DE ENTREGA FUTURA, *}
  {* FORÇA UTILIZAR A MESMA ESPÉCIE DO DOCUMENTO ORIGINAL NA BAIXA DE ENTREGA FUTURA.    *}
  {* ISSO PORQUE O PEDIDO DEVE CONTER ITENS DA MESMA ESPÉCIE POIS O MESMO SERÁ FATURADO  *}
  {* EM UM ÚNICO DOCUMENTO NA EXPEDIÇÃO.                                                 *}
  {*******************************************************************************PZ-LE***}
  If ((fCfgSis('TPBEFT', varString) = '2') And (Not fBaixaDeEntregaFuturaApenasComoControleDeEntrega)) Then
    blnDocOri := True;

  FcdsValoresItensDocumentoBaixa := TUniClientDataSet.Create(Self);
  FcdsValoresItensDocumentoBaixa.FieldDefs.Add('AUTINC', ftString, 20);
  FcdsValoresItensDocumentoBaixa.FieldDefs.Add('DESESP', ftFloat);
  FcdsValoresItensDocumentoBaixa.CreateDataSet;

  intAltForm := Self.Height;
  intLarForm := Self.Width;

  WindowState := wsMaximized;

  blnBFut49 := False;
  blnExibirSomenteProdQtdeEntPreenchida := False;
  dbgvDadosItensDET_LOCFIS.Visible := fCfgSis('LFADEF', varBoolean);
  strAutoincMovsBaixaSimplificada := '';
  strFiltroCodCliBaixaSimplificada := '';
  strFiltroCodCidBaixaSimplificada := '';
  stlProdReqCompraLiberado := TStringList.Create;

  blnModoCrm := False;
end;

procedure TfrmFatBaixaEntregaFutura.FormDestroy(Sender: TObject);
begin

  pEsvaziaArrayCfgDes;

  FreeAndNil(objIteBar);

  if Assigned(fatVenda) then
  begin
    fatVenda.cdsBaiEntFut := Nil;
    FreeAndNil(fatVenda);
  end;

  FreeAndNil(qryCadCli);
  FreeAndNil(stlDocsConf);
  FreeAndNil(objLock);
  FreeAndNil(stlProdReqCompraLiberado);

  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  if Assigned(FcdsValoresItensDocumentoBaixa) then
    FreeAndNil(FcdsValoresItensDocumentoBaixa);

  inherited;
end;

function TfrmFatBaixaEntregaFutura.fValidaStatusCliente : Boolean;
Begin
  Result := True;

  If Not (fCfgSis('FTRASC', varBoolean)) Then
    Exit;

  If (Not fRetStatusCliente(edtCodCliente.Text)) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('A T E N Ç Ã O - Esse cliente está com atividade suspensa!');

    objLiberacao.strDirAce := 'ATISUS';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strMsgSen := 'Esse cliente está com atividade suspensa';
    objLiberacao.strOperador := strLoginUsuarioLogado;
    objLiberacao.strCliente := edtCodCliente.Text;

    If (Not objLiberacao.fLibera) Then
      Result := False;
  End;
End;

function TfrmFatBaixaEntregaFutura.fVaiGerarPedidodeVenda(blnConsideraTipoFechamento:Boolean=True; blnVerificarRegistroCorrente:Boolean=False): Boolean;
Var
  blnExpPed: Boolean;
begin
  Result := False;

  blnExpPed := (Pos(fCfgSis('TIPEXP', varString), '3_4_5_') > 0);

  If IIF(Not blnConsideraTipoFechamento, True, False) And
     (fUsaPedidoBaixaEntregaFutura) And
     (blnExpPed)                     And
     (blnUtiWms)                     Then
  Begin   
    Result := True
  End
  Else If (blnEscolheuFechamentoEmPedido) And (fatVenda.strEspDoc = 'PD') Then
  Begin
    Result := True
  End;
end;

function TfrmFatBaixaEntregaFutura.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaIni) And blnBuscaPorChave Then
    Begin

      mskDtaFin.Clear;
      mskDtaFin.Enabled := Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text));

    End

    Else If (Sender = mskDtaFin) Then
    Begin

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End
      End;

    End

    Else If (Sender = edtDocFat) Or (Sender = edtEspFat) Then
    Begin
      If fCampoDocumentoPreenchido Then
      Begin
        If fAchouPorDocumento Then
        Begin
          blnMudarFoco := False;
          pSetFocus(edtCodCliente);
        End
        Else
        Begin
          fMensagem('ATENÇÃO!', 'Número de documento não encontrado!', ['&O k']);
          pZeraConsulta;
          Result := False;
        End;
      End;
    End

    Else If (Sender = mskLinGru) Then
    Begin

      If fEmptyStr(mskLinGru.Text) Then
        edtDesGru.Text := 'TODOS'
      Else
        edtDesGru.Text := fRetNomeLinhaGrupo(mskLinGru.Text);

      If fEmptyStr(edtDesGru.Text) And (Not fEmptyStr(mskLinGru.Text))  Then
      Begin
        fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
        Result := False;
      End
      Else If (blnBuscaPorChave) And (blnModoCrm) Then
      Begin
        If fTravaBaixa Then
          TfrmGravando.fExecutarModal(pAbreConsulta, 'Aguarde... Carregando documentos.', '');
      End;

    End

    Else If (Sender = edtCodIte) Then
    Begin
      Result := True;
      blnMudarFoco := False;
    End

    Else If (Sender = edtQtdIte) Then
    Begin
      If (fEmptyStr(edtQtdIte.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If (fStrToFloat(edtQtdIte.Text) <= 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pSetFocus(edtCodIte);
        edtQtdIte.Enabled := False;
        blnMudarFoco := False;
      End;
    End

    Else If (Sender = edtCodCliente) Then
    Begin

      If fEmptyStr(edtCodCliente.Text) Then
      Begin
        edtDesCliente.Clear;

        If blnBuscaPorChave Then
        Begin
          objLock.pDestravarTodos;
          fMensagem('ATENÇÃO!', 'Informe o código do cliente!', ['&Ok']);
          Result := FALSE;
        End;
      End

      Else
      Begin
        pCarregaCliente;

        If fEmptyStr(edtDesCliente.Text) Then
        Begin
          objLock.pDestravarTodos;
          fMensagem('ATENÇÃO!', 'Cliente não cadastrado!', ['&Ok']);
          Result := FALSE;
        End
        Else If Not fValidaStatusCliente Then
        Begin
          objLock.pDestravarTodos;
          Result := False;
        End
        Else If blnBuscaPorChave Then
        begin
          If fTravaBaixa Then
          Begin
            TfrmGravando.fExecutarModal(pAbreConsulta, 'Aguarde... Carregando documentos.', '');

            If fClienteConsumidor(fRetNomCliente(edtCodCliente.Text)) Then
            Begin
              Result := fSelecionaConsumidor And fFiltraConsumidor;

              If (Result) And (Not fCampoDocumentoPreenchido) Then
                edtDesCliente.Text := strNomConSel;
            End;

          End
          Else
            Result := False;
        End;

      End

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmFatBaixaEntregaFutura.fValidaDataEntIme(
  dtaEntreg: TDateTime): Boolean;
begin
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('A data de entrega imediata deve ser maior ou igual a ' + DateToStr(VS_Date + fCfgSis('QMDPEI', varInteger)) + '.');
  objLiberacao.objMsgLibera.pAddTexto('Data entrega informada: ' + DateToStr(dtaEntreg));
  objLiberacao.objMsgLibera.pAddTexto('');
  objLiberacao.objMsgLibera.pAddTexto('Informe a senha para permitir data de entrega imediata inferior aos dias definidos na configuração');
  objLiberacao.objMsgLibera.pAddTexto('"CFG_QMDPEI - Quantidade mínima de dias para Entrega Imediata".');
  objLiberacao.objMsgLibera.pAddTexto('');

  objLiberacao.strDirAce := 'QMDPEI';
  objLiberacao.strMsgSen := 'A data de entrega imediata deve ser maior ou igual a ' + DateToStr(VS_Date + fCfgSis('QMDPEI', varInteger)) + '.';
  objLiberacao.strCodOpe := fatVenda.strCodVen;
  objLiberacao.strCodDig := fatVenda.strCodDig;
  objLiberacao.strCliente := fatVenda.strCodCli + '-' + fatVenda.strCliOri;
  objLiberacao.strCpfCnpj := fatVenda.strCliCgc;

  Result := fatVenda.fFatMensagemLiberacao(objLiberacao);
end;

function TfrmFatBaixaEntregaFutura.fValidaVendaPresencial(
  strVenPreAtu: String): Boolean;
  Var
    cdsTmp: TUniClientDataSet;
begin
  Result := True;

  cdsTmp := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsTmp, cdsAux);

  With cdsTmp Do
  Begin
    Filtered := False;
    Filter   := 'DET_QTDAEN > 0';
    Filtered := True;

    First;

    While Not Eof Do
    Begin
      Result := FieldByName('AUX_VENPRE').AsString = strVenPreAtu;

      If Not Result Then
        Break;

      Next;
    End;
  End;

  FreeAndNil(cdsTmp);
end;

function TfrmFatBaixaEntregaFutura.fTravaFaturamentoItensComOrigemDiferente: Boolean;
  Var
    cdsDados: TUniClientDataSet;
    stlItens: TStringList;
    stlEmpIt: TStringList;
    stlLista: TStringList;
    intIdx: Integer;
    intEmp: Integer;
begin
  Result := False;

  If (fCfgSis('PEF_CD', varString) = 'S') And
     (fCfgSis('ENT_CD', varString) = 'S') And
     (fCfgSis('EMP_CD', varString) = VS_strCodEmp) Then
  Begin 
    cdsDados := TUniClientDataSet.Create(Nil);
    stlItens := TStringList.Create;
    stlEmpIt := TStringList.Create;
    stlLista := TStringList.Create;
    
    Try
      pCloneDataSet(cdsDados, cdsConsulta);

      cdsDados.Filter := 'DET_QTDAEN > 0';
      cdsDados.Filtered := True;

      cdsDados.First;
      While Not cdsDados.Eof Do
      begin
        If (stlItens.IndexOf(cdsDados.FieldByName('DET_CODITE').AsString) = -1) Then
        Begin
          stlItens.Add(cdsDados.FieldByName('DET_CODITE').AsString);
        End;

        cdsDados.Next;
      End;

      For intIdx := 0 To stlItens.Count-1 Do
      Begin
        stlEmpIt.Clear;

        cdsDados.First;
        While Not cdsDados.Eof Do
        begin
          If (cdsDados.FieldByName('DET_CODITE').AsString = stlItens[intIdx]) And
             (stlEmpIt.IndexOf(cdsDados.FieldByName('DET_EMPORI').AsString) = -1) Then
          Begin
            stlEmpIt.Add(cdsDados.FieldByName('DET_EMPORI').AsString);
          End;

          cdsDados.Next;
        End;

        If (stlEmpIt.Count > 1) Then
        Begin
          If stlLista.Count = 0 Then
            stlLista.Add('Não é possível efetuar a baixa de entrega futura de itens com origens distintas:');

          stlLista.Add('');
          stlLista.Add('ITEM: '+stlItens[intIdx]);

          For intEmp := 0 To stlEmpIt.Count-1 Do
          Begin
            stlLista.Add('  EMPRESA ORIGEM: '+stlEmpIt[intEmp]);

            cdsDados.First;
            While Not cdsDados.Eof Do
            begin
              If (cdsDados.FieldByName('DET_CODITE').AsString = stlItens[intIdx]) And
                 (cdsDados.FieldByName('DET_EMPORI').AsString = stlEmpIt[intEmp]) Then
              Begin
                stlLista.Add('    '+cdsDados.FieldByName('DET_NUMDOC').AsString+'-'+cdsDados.FieldByName('DET_ESPDOC').AsString);
              End;

              cdsDados.Next;
            End;
          End;
        End;
      End;
    Finally
      If stlLista.Count > 0 Then
      Begin
        Result := True;
        pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
        Try
          frmMensagemExplicativa.Caption := 'Atenção';
          frmMensagemExplicativa.Width := 850;
          frmMensagemExplicativa.mmoInstru.Font.Style :=[];
          frmMensagemExplicativa.mmoInstru.Lines.Text := stlLista.Text;
          frmMensagemExplicativa.ShowModal;
        Finally
          pFreeAndNil(frmMensagemExplicativa);
        End;
      End;

      FreeAndNil(cdsDados);
      FreeAndNil(stlItens);
      FreeAndNil(stlEmpIt);
      FreeAndNil(stlLista);
    End;
  End;
end;

function TfrmFatBaixaEntregaFutura.fSelecionaConsumidor: Boolean;
begin
  If fCampoDocumentoPreenchido Then
  Begin
    Result := True;
    Exit;
  End;

  Try
    pCriarFormularios(TfrmFatSelCliCon, frmFatSelCliCon);

    With cdsConsulta Do
    Begin
      DisableControls;
      First;
      While Not Eof Do
      Begin
        frmFatSelCliCon.pAddConsumidor(FieldByName('GER_CGCCPF').AsString,
                                       FieldByName('GER_CGCCON').AsString,
                                       FieldByName('GER_NOMCON').AsString);
        Next;
      End;
      First;
      EnableControls;
    End;

    Result := frmFatSelCliCon.ShowModal = mrOk;

    If Result Then
    Begin
      strCgcCpfSel := frmFatSelCliCon.strCgcCpfSel;
      strCgcConSel := frmFatSelCliCon.strCgcConSel;
      strNomConSel := frmFatSelCliCon.strNomConSel;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      cdsConsulta.EnableControls;
      pMensagensErro(E.Message, '');
    End;
  End;
  pFreeAndNil(frmFatSelCliCon);
end;

function TfrmFatBaixaEntregaFutura.fFiltraConsumidor: Boolean;
begin
  If fCampoDocumentoPreenchido Then
  Begin
    Result := True;
    Exit;
  End;

  Try
    With cdsConsulta Do
    Begin
      DisableControls;
      First;
      While Not Eof Do
      Begin
        If (Trim(FieldByName('GER_CGCCPF').AsString) <> strCgcCpfSel) Or
           (Trim(FieldByName('GER_CGCCON').AsString) <> strCgcConSel) Or
           (Trim(FieldByName('GER_NOMCON').AsString) <> strNomConSel) Then
        Begin
          Delete;
        End
        Else
          Next;
      End;
      First;
      EnableControls;
    End;
    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      cdsConsulta.EnableControls;
      pMensagensErro(E.Message, '');
    End;
  End;
  pFreeAndNil(frmFatSelCliCon);
end;

procedure TfrmFatBaixaEntregaFutura.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinGru, edtDesGru, Nil, Key, arrGrupos) Then
  Begin
    If fValidaCampos(mskLinGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmFatBaixaEntregaFutura.fSetParametros: Boolean;
Begin
  With qryConsulta Do
  Begin
    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
    End;

    If Not fEmptyStr(mskLinGru.Text) Then
      ParamByName('CODGRU').AsString := mskLinGru.Text;
  End;

  Result := True;
End;

function TfrmFatBaixaEntregaFutura.fGetSql(blnLike: Boolean): String;
  Var
    strSQL: String;
Begin
  strSQL :=
    TBaixaEntFut.New(
      TParamsBaixaEntFut.New()
        .FaltaProduto(chkFalta.Checked)
        .PrevisaoEntrega(chkPrevisao.Checked)
        .AguardandoCliente(chkAguarda.Checked)
        .ClienteVaiRetirar(IIF(cmbCliBus.Visible, TClienteRetira(cmbCliBus.ItemIndex), crTODOS))
        .DataInicial(StrToDateDef(mskDtaIni.Text, 0))
        .DataFinal(StrToDateDef(mskDtaFin.Text, 0))
        .NumeroDocumento(edtDocFat.Text)
        .EspecieDocumento(edtEspFat.Text)
        .SeparacaoImpressa(chkSepImp.Visible And chkSepImp.Checked)
        .LinhaGrupo(mskLinGru.Text)
        .CodigoCliente(edtCodCliente.Text)
        .MarcaTodos(Self.blnMarcaTodos)
        .ImpressaoSeparacao(Self.blnSepFut)
        .BaixaCST49(Self.blnBFut49)
        .ModoConsulta(Not fEmptyStr(Self.strCodCliConsulta))
        .AutoincMovs(strAutoincMovsBaixaSimplificada)
    ).fGetSql;

  strSQL := strSQL + fFiltraSQL(blnlike);

  strSQL := strSQL + ' GROUP BY D.AUTOINCREM ';

  Result := strSQL;
End;

procedure TfrmFatBaixaEntregaFutura.pFormataCampos;
begin
  TFloatField(cdsConsulta.FieldByName('ITE_SALDOS')).DisplayFormat := '#,###0.000';
  TFloatField(cdsConsulta.FieldByName('QTDENT'    )).DisplayFormat := '#,###0.0000';
  TFloatField(cdsConsulta.FieldByName('DET_QTDPEN')).DisplayFormat := '#,###0.0000';
  TFloatField(cdsConsulta.FieldByName('DET_QTDITE')).DisplayFormat := '#,###0.0000';
  TFloatField(cdsConsulta.FieldByName('DET_QTDAEN')).DisplayFormat := '#,###0.0000';
  TFloatField(cdsConsulta.FieldByName('QTDDEV'    )).DisplayFormat := '#,###0.0000';
  TFloatField(cdsConsulta.FieldByName('QTDJDV'    )).DisplayFormat := '#,###0.0000';
  TDateField (cdsConsulta.FieldByName('DTAFUT'    )).DisplayFormat := 'dd/MM/yy';
  TDateField (cdsConsulta.FieldByName('GER_DTAENT')).DisplayFormat := 'dd/MM/yy';

  cdsConsulta.IndexFieldNames := 'DTAFUT;GER_DTAENT;GER_ESPDOC;GER_NUMDOC;CODITE;DET_INCREM';
end;

procedure TfrmFatBaixaEntregaFutura.pGerarDocumentoFormulacaoItens(fatVenda : TFatVenda);
Var
  strSeqGer         : String;
  strAutIncTdt      : String;
  qryAux            : TUniQuery;
  qryArqFor         : TUniQuery;
  QryGetItem        : TUniQuery;
  arrFormul         : TForMulTinDetArray;
  arrBaixaPigmentos : TBaixaPigmentosArray;
  stlItensTraMl     : TStringList;
  recForTin         : TForTin;
  intContFormul     : Integer;
  blnInTransaction  : Boolean;
begin
  blnInTransaction := fInTransaction;

  Try
    If Not blnInTransaction Then
      fStartTransaction;

    qryAux     := fCriaQuery;
    qryArqFor  := fCriaQuery;
    QryGetItem := fCriaQuery;

    cdsConsulta.First;

    While Not (cdsConsulta.Eof) Do
    Begin
      If cdsConsulta.fieldByName('DET_QTDAEN').AsInteger > 0 Then
      Begin

        fGetItem(QryGetItem, cdsConsulta.FieldByName('DET_CODITE').AsString);


        qryAux.SQL.Clear;

        qryAux.Close;

        qryAux.SQL.Add('SELECT TINDET.*, ');
        qryAux.SQL.Add('  FOR_FATACE, ');
        qryAux.SQL.Add('  FORTIN.* ');
        qryAux.SQL.Add('FROM TINDET ');
        qryAux.SQL.Add('  JOIN FORTIN ON FOR_CODACA = DET_CODACA ');
        qryAux.SQL.Add('             AND FOR_EMPACA = DET_EMPACA ');
        qryAux.SQL.Add('WHERE DET_NUMDOC = :NUMDOC');
        qryAux.SQL.Add('  AND DET_ESPDOC = :ESPDOC');
        qryAux.SQL.Add('  AND DET_CODEMP = :CODEMP');
        qryAux.SQL.Add('  AND DET_CODCLI = :CODCLI');
        qryAux.SQL.Add('  AND DET_CODACA = :CODACA');
        qryAux.SQL.Add('  AND DET_EMPACA = :EMPACA');


        qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryAux.ParamByName('CODCLI').AsString := edtCodCliente.Text;
        qryAux.ParamByName('NUMDOC').AsString := cdsConsulta.FieldByName('GER_NUMDOC').AsString;
        qryAux.ParamByName('ESPDOC').AsString := cdsConsulta.FieldByName('GER_ESPDOC').AsString;
        qryAux.ParamByName('CODACA').AsString := cdsConsulta.FieldByName('DET_CODACA').AsString;
        qryAux.ParamByName('EMPACA').AsString := cdsConsulta.FieldByName('DET_EMPACA').AsString;

        qryAux.Open;

        If (qryAux.FieldByName('DET_IDEPRO').AsString <> 'NOR') And (qryAux.FieldByName('DET_IDEPRO').AsString <> '') Then
        Begin
          If(fGravaTinGer(strSeqGer,
                          VS_strCodEmp,
                          fatVenda.strCodVen,
                          fatVenda.strNumDoc,
                          fatVenda.strEspDoc,
                          fatVenda.VS_Date,
                          fTime(),
                          fatVenda.strConPag,
                          fatVenda.strCodCli,
                          fatVenda.strCliEst,
                          IIF(fEmptyStr(fatVenda.strCliNom), '', fatVenda.strCliNom),
                          fatVenda.strCliEnd,
                          fatVenda.strCliBai,
                          fatVenda.strCliCep,
                          fatVenda.strCodCid,
                          fatVenda.strCliEst,
                          fatVenda.strCliTel,
                          fatVenda.intCgcCpf,
                          fatVenda.strCliCgc,
                          fatVenda.strCliIes,
                          fatVenda.strCli_Rg,'N')) Then
          begin
            stlItensTraMl := TStringList.Create;

            If Not (fGTinForGeral(qryAux.FieldByName('DET_IDEPRO').AsString,        // Tipo de Produto
                                  qryAux.FieldByName('DET_ITETIN').AsString,        // Item da Tinta
                                  qryAux.FieldByName('DET_TIPPRE').AsString,        // Tipo de Preço
                                  qryAux.FieldByName('DET_LINTIN').AsString,        // Linha da Tinta
                                  qryAux.FieldByName('DET_CATALI').AsString,        // Catalizador Utilizado
                                  qryAux.FieldByName('DET_LAZQUA').AsInteger,       // Quarto (Lazzumix)
                                  qryAux.FieldByName('DET_QTDEMB').AsFloat,         // Quantidade de Embalagem
                                  cdsConsulta.fieldByName('DET_QTDAEN').AsInteger,  // Quantidade do Item
                                  qryAux.FieldByName('DET_DESCRI').AsString,        // Descrição do Item
                                  qryArqFor,                                        // Arquivo de Formulas!
                                  qryAux.FieldByName('DET_VOLPRO').AsFloat,         // Volume a ser produzido (Tinta c/ Venda Dinamica)
                                  arrFormul,                                        // Retorno da Formulação
                                  arrBaixaPigmentos,                                // Retorno dos Pigmentos a serem baixados
                                  stlItensTraMl,                                    // Retorno dos Itens para Transferencia de ML
                                  qryAux.FieldByName('DET_CODDIL').AsString,
                                  qryAux.FieldByName('DET_PORDIL').AsFloat,
                                  qryAux.FieldByName('DET_DILCON').AsString,
                                  qryAux.FieldByName('DET_PORCAT').AsFloat,
                                  qryAux.FieldByName('FOR_TIPCOR').AsString,
                                  qryAux.FieldByName('FOR_TEXBAS').AsString,
                                  qryAux.FieldByName('FOR_MODDIL').AsInteger,
                                  qryAux.FieldByName('FOR_ITECOB').AsString,
                                  qryAux.FieldByName('DET_EMPPRD').AsString)) Then
            Begin
              Raise Exception.Create('Não foi possível gravar a formulação da tinta!');
            End;

            For intContFormul := Low(arrFormul) To High(arrFormul) Do
            Begin
              arrFormul[intContFormul].fltQtdbas := arrFormul[intContFormul].fltQtdbas *
                                                    cdsConsulta.fieldByName('DET_QTDAEN').AsInteger;
            End;

            If Not fGravaTinDet(strAutIncTdt,
                         strSeqGer,
                         VS_strCodEmp,
                         fatVenda.strCodDiv,
                         qryAux.FieldByName('DET_CODMAR').AsString,
                         cdsConsulta.FieldByName('DET_CODITE').AsString,
                         fatVenda.strCodVen,
                         fatVenda.strCodCli,
                         fatVenda.strNumDoc,
                         fatVenda.strEspDoc,
                         fatVenda.VS_Date,
                         fTime(),
                         fatVenda.strConPag,
                         fatVenda.strCliEst,
                         cdsConsulta.FieldByName('DET_DESCRI').AsString,
                         cdsConsulta.FieldByName('DET_REFERE').AsString,
                         qryAux.FieldByName('DET_UNIDAD').AsString,
                         QryGetItem.FieldByName('ITE_CODFOR').AsString,
                         cdsConsulta.fieldByName('DET_QTDAEN').AsInteger,
                         qryAux.FieldByName('DET_INCPIS').AsString,
                         IIF(fatVenda.blnNotEsp Or fatVenda.blnCupEsp, 'S', 'N'),
                         qryAux.FieldByName('DET_IDEPRO').AsString,
                         qryAux.FieldByName('DET_ITETIN').AsString,
                         qryAux.FieldByName('DET_ITECHA').AsString,
                         qryAux.FieldByName('DET_DESCOR').AsString,
                         qryAux.FieldByName('DET_TIPEMB').AsString,
                         qryAux.FieldByName('DET_QTDEMB').AsFloat,
                         qryAux.FieldByName('DET_QTDEMB').AsFloat,
                         qryAux.FieldByName('DET_TIPPRE').AsString,
                         qryAux.FieldByName('DET_MONTAD').AsString,
                         qryAux.FieldByName('DET_A_N_O_').AsString,
                         arrFormul[01].strFormul,
                         arrFormul[01].fltQtdbas,
                         arrFormul[02].strFormul,
                         arrFormul[02].fltQtdbas,
                         arrFormul[03].strFormul,
                         arrFormul[03].fltQtdbas,
                         arrFormul[04].strFormul,
                         arrFormul[04].fltQtdbas,
                         arrFormul[05].strFormul,
                         arrFormul[05].fltQtdbas,
                         arrFormul[06].strFormul,
                         arrFormul[06].fltQtdbas,
                         arrFormul[07].strFormul,
                         arrFormul[07].fltQtdbas,
                         arrFormul[08].strFormul,
                         arrFormul[08].fltQtdbas,
                         arrFormul[09].strFormul,
                         arrFormul[09].fltQtdbas,
                         arrFormul[10].strFormul,
                         arrFormul[10].fltQtdbas,
                         arrFormul[11].strFormul,
                         arrFormul[11].fltQtdbas,
                         arrFormul[12].strFormul,
                         arrFormul[12].fltQtdbas,
                         arrFormul[13].strFormul,
                         arrFormul[13].fltQtdbas,
                         arrFormul[14].strFormul,
                         arrFormul[14].fltQtdbas,
                         arrFormul[15].strFormul,
                         arrFormul[15].fltQtdbas,
                         arrFormul[16].strFormul,
                         arrFormul[16].fltQtdbas,
                         arrFormul[17].strFormul,
                         arrFormul[17].fltQtdbas,
                         arrFormul[18].strFormul,
                         arrFormul[18].fltQtdbas,
                         arrFormul[19].strFormul,
                         arrFormul[19].fltQtdbas,
                         arrFormul[20].strFormul,
                         arrFormul[20].fltQtdbas,
                         strCodDig,
                         qryAux.FieldByName('DET_CODACA').AsString,
                         qryAux.FieldByName('DET_EMPACA').AsString,
                         qryAux.FieldByName('DET_CATALI').AsString,
                         qryAux.FieldByName('DET_LINTIN').AsString,
                         IIF(fatVenda.strOprFlj = 'S', True, False),
                         qryAux.FieldByName('DET_EMPPRD').AsString,
                         qryAux.FieldByName('DET_LAZQUA').AsInteger,
                         qryAux.FieldByName('DET_VOLPRO').AsFloat,
                         qryAux.FieldByName('DET_CODDIL').AsString,
                         qryAux.FieldByName('DET_PORDIL').AsFloat,
                         qryAux.FieldByName('DET_DILCON').AsString,
                         qryAux.FieldByName('DET_PORCAT').AsFloat,
                         recForTin,
                         qryAux.FieldByName('FOR_FATACE').AsFloat,
                         false) Then
            Begin
               Raise Exception.Create('Não foi possível gravar a formulação da tinta (TINDET)!');
            End;
          End
          Else
            Raise Exception.Create('Não foi possível gravar a formulação da tinta (MOVGER)!');
        End;
      End;
      cdsConsulta.Next;
    End;

    If Not blnInTransaction Then
      fCommit();

  Finally
    FreeAndNil(QryAux);
    FreeAndNil(QryArqFor);
    FreeAndNil(QryGetItem);
  End;
end;

function TfrmFatBaixaEntregaFutura.fAbreConsulta(blnLike: Boolean): Boolean;
Begin
  If (Not fEmptyStr(strCodCliConsulta)) And cdsConsulta.Active Then
  Begin
    Result := True;
    Exit;
  End;

  strEndSel := '';

  Result := inherited fAbreConsulta(blnLike);

  If Result Then
  Begin
    cdsConsulta.LogChanges := False;

    If Not blnMarcaTodos Then
      cdsConsulta.FieldByName('DET_QTDAEN').FocusControl;

    pSetFocus(edtCodIte);

    pFormataCampos;

    cdsConsulta.First;
  End;

  strTabela     := '';
  blnMarcaTodos := FALSE;

  cdsAux.Filtered := False;
  cdsAux.Data := cdsConsulta.Data;
  cdsControle.Data := cdsConsulta.Data;

  pCalcularTotais;

  If (Not cdsConsulta.Active) Or (cdsConsulta.RecordCount = 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não existe(m) baixa(s) de entrega futura a ser(em) realizada(s) com este(s) filtro(s)!', ['&O k']);
    pSetFocus(chkFalta);
  End;

  If (fCfgSis('EFTEST') = '2') And (fCfgSis('EFTESE') = '1') Then
    pCriarCdsSomenteComSubItensEstrutura(True);

  dbgvDadosItens.ViewData.Expand(True);
  pSetFocus(dbgDadosItens);
End;

function TfrmFatBaixaEntregaFutura.fRetornaLarguraUtilizadaGrid: Integer;
var
  intCont, intTotColunasVisiveis : Integer;
const
  MARGEM = 70;
begin

  intTotColunasVisiveis := 0;
  For intCont := 0 To dbgvDadosItens.ColumnCount -1 Do
    If (dbgvDadosItens.Columns[intCont].Visible) Then
      If (dbgvDadosItens.Columns[intCont].DataBinding.FieldName <> 'DET_DESCRI') Then
        intTotColunasVisiveis := intTotColunasVisiveis + dbgvDadosItens.Columns[intCont].Width;

  Result := (intTotColunasVisiveis + MARGEM);

end;

function TfrmFatBaixaEntregaFutura.fRetornaSeDocumentoComProducaoForaDeLoja(
  strAutIncDet: String): String;
var
  strAutIncGer: String;
begin
  Result := 'N';

  if fEmptyStr(strAutIncDet) then
    Exit;

  strAutIncGer := fCampoTabela('DET_SEQGER', 'MOVDET', ['AUTOINCREM'], [strAutIncDet], False);

  if fEmptyStr(strAutIncGer) then
    Exit;

  Result := IfEmptyStr(fCampoTabela('GER_OPRFLJ', 'MOVGER', ['AUTOINCREM'], [strAutIncGer], False), 'N');
end;

function TfrmFatBaixaEntregaFutura.fRetornaSeDocumentoEhAbastecimentoDeposito: String;
var
  cdsDados: TUniClientDataSet;
begin
  cdsDados := TUniClientDataSet.Create(nil);

  try
    Result := 'N';

    pCloneDataSet(cdsDados, cdsAux);

    cdsDados.Filtered := False;
    cdsDados.Filter := ' DET_QTDAEN > 0 ';
    cdsDados.Filtered := True;

    if cdsDados.IsEmpty then
      Exit;

    cdsDados.First;

    Result := cdsDados.FieldByName('AUX_ABADEP').AsString;
  finally
    FreeAndNil(cdsDados);
  end;
end;

function TfrmFatBaixaEntregaFutura.fRetornaTotalFreteInformadoNosDocumentosBaixadosTotalmente(
  strListaDeDocumentos: String;
  dicQuantidadesBaixarDocumentos: TDictionary<String, Double>): Double;
var
  qryDocumentos: TUniQuery;
  fltQtdIteBaixar: Double;
begin
  qryDocumentos := fCriaQuery;

  try
    Result := 0;

    qryDocumentos.Close;
    qryDocumentos.SQL.Clear;
    qryDocumentos.SQL.Add('SELECT G.AUTOINCREM, SUM(D.DET_QTDITE) AS DET_QTDITE, A.AUX_FRECOT FROM MOVGER G');
    qryDocumentos.SQL.Add('INNER JOIN MOVDET D');
    qryDocumentos.SQL.Add('ON(G.AUTOINCREM = D.DET_SEQGER)');
    qryDocumentos.SQL.Add('INNER JOIN AUXMOV A');
    qryDocumentos.SQL.Add('ON(G.AUTOINCREM = A.AUX_SEQGER)');
    qryDocumentos.SQL.Add('WHERE G.AUTOINCREM IN('+strListaDeDocumentos+')');
    qryDocumentos.SQL.Add('GROUP BY G.AUTOINCREM, A.AUX_FRECOT ');
    qryDocumentos.Open;

    if qryDocumentos.IsEmpty then
      Exit;

    while not qryDocumentos.Eof do
    begin
      fltQtdIteBaixar := 0;
      if dicQuantidadesBaixarDocumentos.TryGetValue(qryDocumentos.FieldByName('AUTOINCREM').AsString, fltQtdIteBaixar) then
      begin
        if qryDocumentos.FieldByName('DET_QTDITE').AsFloat = fltQtdIteBaixar then
          Result := Result + qryDocumentos.FieldByName('AUX_FRECOT').AsFloat
        else
          Exit(0) ;
      end;

      qryDocumentos.Next;
    end;
  finally
    FreeAndNil(qryDocumentos);
  end;
end;

function TfrmFatBaixaEntregaFutura.fRetornaValorDoFreteIformadoParaDocumentosTotalmenteBaixados: Double;
var
  strListaDeDocumentos: String;
  dicQuantidadesBaixarDocumentos: TDictionary<String,Double>;
begin
  Result := 0;

  if not cdsConsulta.Active then
    Exit;

  if cdsConsulta.RecordCount <= 0 then
    Exit;

  dicQuantidadesBaixarDocumentos := TDictionary<String,Double>.Create;

  try
    if not fRetornouDocumentosEQuantidadeDeBaixa(strListaDeDocumentos, dicQuantidadesBaixarDocumentos) then
      Exit;

    Result := fRetornaTotalFreteInformadoNosDocumentosBaixadosTotalmente(strListaDeDocumentos, dicQuantidadesBaixarDocumentos);
  finally
    dicQuantidadesBaixarDocumentos.Free;
  end;
end;

function TfrmFatBaixaEntregaFutura.fRetornouDocumentosEQuantidadeDeBaixa(var strListaDeDocumentos: String; var dicQuantidadesBaixarDocumentos: TDictionary<String,Double>): Boolean;
var
  cdsDadosBKP: TUniClientDataSet;
  strAutIncDocumento: String;
  fltQtdIteBaixar: Double;
begin
  strListaDeDocumentos := EmptyStr;
  cdsDadosBKP := TUniClientDataSet.Create(Nil);

  try
    Result := False;

    pCloneDataSet(cdsDadosBKP, cdsConsulta);
    cdsDadosBKP.Filtered := False;
    cdsDadosBKP.Filter := 'DET_QTDAEN > 0';
    cdsDadosBKP.Filtered := True;

    if cdsDadosBKP.RecordCount <= 0 then
      Exit;

    while not cdsDadosBKP.Eof do
    begin
      strAutIncDocumento := fCampoTabela('AUTOINCREM', 'MOVGER', ['GER_NUMDOC','GER_ESPDOC','GER_CODEMP','GER_CODCLI'], [cdsDadosBKP.FieldByName('GER_NUMDOC').AsString,cdsDadosBKP.FieldByName('GER_ESPDOC').AsString,cdsDadosBKP.FieldByName('GER_CODEMP').AsString,edtCodCliente.Text], False);

      if fEmptyStr(strAutIncDocumento) then
      begin
        cdsDadosBKP.Next;
        Continue;
      end;

      fltQtdIteBaixar := 0;
      if dicQuantidadesBaixarDocumentos.TryGetValue(strAutIncDocumento, fltQtdIteBaixar) then
        fltQtdIteBaixar := fltQtdIteBaixar + cdsDadosBKP.FieldByName('DET_QTDAEN').AsFloat
      else
        fltQtdIteBaixar := cdsDadosBKP.FieldByName('DET_QTDAEN').AsFloat;

      dicQuantidadesBaixarDocumentos.AddOrSetValue(strAutIncDocumento, fltQtdIteBaixar);
      pIncrementaListaStr(strAutIncDocumento, strListaDeDocumentos, True);

      cdsDadosBKP.Next;
    end;

    if (dicQuantidadesBaixarDocumentos.Count > 0) and (not fEmptyStr(strListaDeDocumentos)) then
      Result := True;
  finally
    FreeAndNil(cdsDadosBKP);
  end;
end;

function TfrmFatBaixaEntregaFutura.fRetornaEmpresaFatSemSaldo: String;
var
  cdsDados: TUniClientDataSet;
begin
  cdsDados := TUniClientDataSet.Create(nil);

  try
    Result := EmptyStr;
    pCloneDataSet(cdsDados, cdsConsulta);
    cdsDados.First;

    while not cdsDados.Eof do
    begin
      if cdsDados.FieldByName('DET_QTDAEN').AsFloat > 0 then
      begin
        Result := cdsDados.FieldByName('GER_CODEMP').AsString;
        Exit;
      end;

      cdsDados.Next;
    end;
  finally
    FreeAndNil(cdsDados);
  end;
end;

function TfrmFatBaixaEntregaFutura.fRetornaEmpresaOrigemPedidoAbastecimentoDeposito: String;
var
  cdsDados: TUniClientDataSet;
begin
  cdsDados := TUniClientDataSet.Create(nil);

  try
    Result := EmptyStr;

    pCloneDataSet(cdsDados, cdsAux);

    cdsDados.Filtered := False;
    cdsDados.Filter := ' DET_QTDAEN > 0 ';
    cdsDados.Filtered := True;

    if cdsDados.IsEmpty then
      Exit;

    cdsDados.First;

    Result := cdsDados.FieldByName('GER_CODEMP').AsString;
  finally
    FreeAndNil(cdsDados);
  end;
end;

function TfrmFatBaixaEntregaFutura.fRetornaIndRev(strItens: string): string;
var
  qryIndRev: TUniQuery;
begin
  Result := '';

  if fEmptyStr(strItens) then
  begin
    Exit;
  end;

  try
    qryIndRev := fCriaQuery;
    qryIndRev.Close;
    qryIndRev.SQL.Clear;
    qryIndRev.SQL.Add('SELECT ITE_INDREV FROM CADITE');
    qryIndRev.SQL.Add('WHERE ITE_CODITE IN('+strItens+')');
    qryIndRev.SQL.Add('AND ITE_INDREV IS NOT NULL');
    qryIndRev.SQL.Add('AND TRIM(ITE_INDREV) <> ""');
    qryIndRev.SQL.Add('GROUP BY ITE_INDREV');
    qryIndRev.Open;

    if not qryIndRev.IsEmpty then
    begin
      if qryIndRev.RecordCount = 1 then
      begin
        Result := qryIndRev.FieldByName('ITE_INDREV').AsString;
      end
      else
      begin
        Result := 'R,I'; // Retorna os dois tipos possíveis.
      end;
    end;
  finally
    FreeAndNil(qryIndRev);
  end;
end;

function TfrmFatBaixaEntregaFutura.fRetQtdDigitada(strCodIte: String; strNumLot: String; strMotFutAConsiderar: String=''): Double;
begin

  With cdsAux Do
  Begin
    Filter   := 'DET_QTDAEN > 0 AND DET_CODITE = ' + QuotedStr(strCodIte);

    If Not fEmptyStr(strNumLot) Then
      Filter := Filter + ' AND DET_NUMLOT = ' + QuotedStr(strNumLot);

    Filtered := True;
    First;

    Result := 0.0;

    While Not Eof Do
    Begin
      If (fEmptyStr(strMotFutAConsiderar)) Or (Pos(FieldByName('DET_MOTFUT').AsString, strMotFutAConsiderar) > 0) Then
        Result := Result + FieldByName('DET_QTDAEN').AsFloat;
      Next;
    End;

    cdsAux.Filtered := False;
  End;

end;

procedure TfrmFatBaixaEntregaFutura.cdsConsultaBeforePost(DataSet: TDataSet);
  Var
    strSemEst    : String;
    blnPedSen    : Boolean;
    blnSemEst    : Boolean;
    fltSaldos    : Double;
    fltSaldosSemLote: Double;
    recTinFor    : TForTin;
    blnLocFor    : Boolean;
    strNumLot    : String;
    blnLiberouNaTrocaDoLote : Boolean;
    
    strMotFutAConsiderar: String;
    
    fltQtdAntesPost,
    fltQtdQueroPost : Double;

    LfltQuantidadePendente : Double;

    LstrCampoParaValidacao : String;

    procedure pCancelar;
    begin
      DataSet.Cancel;
      DataSet.Enablecontrols;
      blnCancelar := True;
      pLiberaGrid;
      Abort;
    end;

    function fQtdRegDoDocJaMarcado: Integer;
    begin
      cdsControle.Filtered := False;
      cdsControle.Filter:= 'DET_NUMDOC = ' + QuotedStr(Copy(fChvDoc,1,12)) + ' AND ' +
                           'DET_ESPDOC = ' + QuotedStr(Copy(fChvDoc,13,2)) + ' AND ' +
                           'DET_CODEMP = ' + QuotedStr(Copy(fChvDoc,15,3)) + ' AND ' +
                           'DET_QTDAEN > 0 OR QTDDEV > 0';
      cdsControle.Filtered := True;

      Result := cdsControle.RecordCount;
    end;

    
begin
  inherited;

  If Not blnTestarPost Then
    Exit;

  {*******************************************}
  {* ENTREGA FUTURA JA BAIXOU ESTOQUE        *}
  {****************************************PH*}
  recTinFor.blnTemSaldoVenda := True;
  blnLiberouNaTrocaDoLote := False;

  fltQtdAntesPost := 0;
  fltQtdQueroPost := 0; 
  blnCancelou := False;
  Try
    With DataSet Do
    Begin
      fltQtdAntesPost := FieldByName('DET_QTDANT').AsFloat;
      fltQtdQueroPost := FieldByName('DET_QTDAEN').AsFloat;

      if blnSepFut then
        LfltQuantidadePendente := RoundTo(FieldByName('PENSEP').AsFloat, -4)
      else
        LfltQuantidadePendente := RoundTo(FieldByName('DET_QTDPEN').AsFloat, -4);

      If (Not blnMarcaTodos) And (fUsaLiberacaoPreviaPeloCaixa) And (FieldByName('GER_DTLBRC').IsNull) And
         fValorMaior(RoundTo(FieldByName('DET_QTDAEN').AsFloat,-4), 0) Then
      Begin
        cdsConsulta.FieldByName('DET_QTDAEN').FocusControl;
        pSetFocus(edtCodIte);
        fMensagem('ATENÇÃO!', 'O sistema está configurado para primeiro receber e liberar o documento pelo caixa para depois fazer a expedição. Dessa forma, '+
                              'é preciso passar pelo caixa primeiramente para fazer a liberação do documento de entrega futura (opção [ALT+L] Liberação no "Resumo de Caixa") '+
                              'para posteriormente, realizar a baixa!', ['&Ok']);
        pCancelar;
      End
      Else If blnSepFut And fValorMaior(fltQtdQueroPost, 0) And (RoundTo(FieldByName('SEP_QTDIMP').AsFloat,-4) = RoundTo(FieldByName('DET_QTDITE').AsFloat,-4)) Then
      Begin
        If fValorMaior(RoundTo(FieldByName('DET_QTDAEN').AsFloat,-4), RoundTo(FieldByName('DET_QTDITE').AsFloat,-4)) Then
        Begin
          cdsConsulta.FieldByName('DET_QTDAEN').FocusControl;
          pSetFocus(edtCodIte);
          fMensagem('ATENÇÃO!', 'Quantidade informada não pode ser maior que a quantidade vendida!', ['&Ok']);
          pCancelar;
        End;
      End
      Else If blnSepFut And fValorMaior(RoundTo(FieldByName('DET_QTDAEN').AsFloat,-4), RoundTo(FieldByName('PENSEP').AsFloat,-4)) Then
      Begin
        cdsConsulta.FieldByName('DET_QTDAEN').FocusControl;
        pSetFocus(edtCodIte);
        fMensagem('ATENÇÃO!', 'Quantidade informada maior que a quantidade pendente!', ['&Ok']);
        pCancelar;
      End
      Else If (Not blnSepFut) And  fValorMaior(RoundTo(FieldByName('DET_QTDAEN').AsFloat,-4),
                                    RoundTo(FieldByName('DET_QTDITE').AsFloat - FieldByName('DET_QTDENT').AsFloat - FieldByName('QTDFUT').AsFloat ,-4)) Then
      Begin
        cdsConsulta.FieldByName('DET_QTDAEN').FocusControl;
        pSetFocus(edtCodIte);
        fMensagem('ATENÇÃO!', 'Quantidade informada maior que a quantidade pendente!', ['&Ok']);
        pCancelar;
      End
      Else if fCfgSis('DEVEFT',varboolean) And fValorMaior(RoundTo(FieldByName('QTDDEV').AsFloat,-4), RoundTo(LfltQuantidadePendente, -4))  Then
      Begin
        cdsConsulta.FieldByName('QTDDEV').FocusControl;
        pSetFocus(edtCodIte);
        fMensagem('ATENÇÃO!', 'Quantidade informada para devolução maior que a quantidade pendente!', ['&Ok']);
        pCancelar;
      End
      Else if fCfgSis('DEVEFT',varboolean) And fValorMenor(RoundTo(FieldByName('QTDDEV').AsFloat,-4), 0)  Then
      Begin
        cdsConsulta.FieldByName('QTDDEV').FocusControl;
        pSetFocus(edtCodIte);
        fMensagem('ATENÇÃO!', 'Quantidade informada para devolução deve ser superior à zero!', ['&Ok']);
        pCancelar;
      End
      Else If (FieldByName('QTDDEV').AsFloat > 0) And (Not fValidaRequisitoCompra(FieldByName('GER_NUMDOC').AsString,
                                                                                  FieldByName('GER_ESPDOC').AsString,
                                                                                  FieldByName('GER_CODEMP').AsString,
                                                                                  FieldByName('CODITE').AsString)) Then
      Begin
        pCancelar;
      End
      Else if fCfgSis('DEVEFT',varboolean) And
              fValorMaior(RoundTo(FieldByName('QTDDEV').AsFloat,-4), 0) And
              fValorMaior(RoundTo(FieldByName('DET_QTDAEN').AsFloat,-4), 0) Then
      Begin
        cdsConsulta.FieldByName('QTDDEV').FocusControl;
        pSetFocus(edtCodIte);
        fMensagem('ATENÇÃO!', 'Não é possível realizar operação de entrega e devolução do mesmo registro ao mesmo tempo!', ['&Ok']);
        pCancelar;
      End
      Else
      Begin

        If ((blnDocOri) and fValorMaior(cdsConsulta.FieldByName('DET_QTDAEN').AsFloat, 0)) or
           ((fCfgSis('BEFEDV', varString) = 'O') and fValorMaior(cdsConsulta.FieldByName('QTDDEV').AsFloat, 0)) Then
        Begin
          if fValorMaior(cdsConsulta.FieldByName('DET_QTDAEN').AsFloat, 0) then
          Begin
            LstrCampoParaValidacao := 'DET_QTDAEN';
            cdsAux.Filter   := 'DET_QTDAEN > 0';
            cdsAux.Filtered := True;
            cdsAux.First;
          End
          else
          Begin
            LstrCampoParaValidacao := 'QTDDEV';
            cdsAux.Filter   := 'QTDDEV > 0';
            cdsAux.Filtered := True;
            cdsAux.First;
          End;

          If (Not fEmptyStr(cdsAux.FieldByName('GER_ESPDOC').AsString))               And
             fValorMaior(cdsConsulta.FieldByName(LstrCampoParaValidacao).AsFloat, 0) And
             (((Pos(cdsAux.FieldByName('GER_ESPDOC').AsString, ESPECIE_FISCAL) > 0)  And
               (Pos(FieldByName('GER_ESPDOC').AsString, ESPECIE_FISCAL) <= 0))       Or
              ((Pos(cdsAux.FieldByName('GER_ESPDOC').AsString, ESPECIE_FISCAL) <= 0) And
               (Pos(FieldByName('GER_ESPDOC').AsString, ESPECIE_FISCAL) > 0)))       Then
          Begin
            cdsConsulta.FieldByName(LstrCampoParaValidacao).FocusControl;
            pSetFocus(edtCodIte);
            fMensagem('', 'Não é permitido selecionar espécies distintas de documentos de entrega futura para baixa. '  +
                          'Motivo: Sistema está configurado para vincular a espécie do documento de baixa com a do documento'+
                          ' original '+IIF(LstrCampoParaValidacao = 'DET_QTDAEN', 'CFG_TPBEFT', 'CFG_BEFEDV')+'.', ['&Ok']);
            pCancelar;
          End;

        End;

        If (Not fValidaVendaPresencial(FieldByName('AUX_VENPRE').AsString)) And
           fValorMaior(cdsConsulta.FieldByName('DET_QTDAEN').AsFloat, 0)    Then
        Begin
          cdsConsulta.FieldByName('DET_QTDAEN').FocusControl;
          pSetFocus(edtCodIte);
          fMensagem('ATENÇÃO!','Não é permitido realizar baixas de entregas futuras de vendas presenciais com vendas '+
                               'que não são presenciais pois a movimentação fiscal é distinta entre estas operações.', ['&Ok']);
          pCancelar;
        End;

        {*REQ.144458**********RP*}
        If (cdsConsulta.FieldByName('DET_QTDAEN').AsFloat > 0) And
           (Not fVerificaParamEntregaFuturaDocSelec(cdsConsulta.FieldByName('AUX_ENFUOP').AsString)) Then
        Begin
          cdsConsulta.FieldByName('DET_QTDAEN').FocusControl;
          pSetFocus(edtCodIte);
          pMensagemOk('Não é permitido realizar baixa de entrega futura de vendas realizadas com a configuração "CFG_ENFUOP" diferente.');
          pCancelar;
        End;

        If (fCfgSis('CADFAZ', varBoolean)) And
           (cdsConsulta.FieldByName('DET_QTDAEN').AsFloat > 0) And
           (Not fVerificaFazendaDocSelec(cdsConsulta.FieldByName('AUX_CODFAZ').AsString)) Then
        Begin
          cdsConsulta.FieldByName('DET_QTDAEN').FocusControl;
          pSetFocus(edtCodIte);
          pMensagemOk('Não é permitido realizar baixa de entrega futura de Fazendas diferentes.');
          pCancelar;
        End;

        fatVenda.strIdePro := FieldByName('DET_IDEPRO').AsString;

        If fValorMaior(cdsConsulta.FieldByName('DET_QTDAEN').AsFloat, 0) Then
          fatVenda.blnVendaPresencial := FieldByName('AUX_VENPRE').AsString = 'S';

        If (FieldByName('DET_QTDAEN').AsFloat = 0) Then
        Begin
          FieldByName('DET_QTDANT').AsFloat := FieldByName('DET_QTDAEN').AsFloat;
        End

        Else If (FieldByName('DET_QTDAEN').AsFloat <> FieldByName('DET_QTDANT').AsFloat) Or (blnValidaMarcarTodos) Then
        Begin

          If Not fValidaMultiploVenda(FieldByName('DET_QTDAEN').AsFloat,
                                      fCampoTabela('ITE_MLTVEN', 'CADITE', ['ITE_CODITE'], [DataSet.FieldByName('DET_CODITE').AsString]), DataSet) Then
          Begin
            pCancelar;
          End;

          If Not fPodeAlterarQuantidadeAEntregar Then
          Begin
            pCancelar;
          End;

          If (Not fEmptyStr(strEndSel)) And
             (FieldByName('ENTGER').AsString <> IIF(strEndSel = '0', '', strEndSel)) And
             (Not blnEndDif) Then
          Begin
            fMensagem('ATENÇÃO!', 'Documentos com diferentes endereços de entrega!', ['&Ok']);
            pCancelar;
          End;

          {***********************************************************}
          {* QUANDO A EMPRESA UTILIZAR WMS, SERÁ GERADO PEDIDO DE    *}
          {* BAIXA DE ENTREGA FUTURA, ONDE O MESMO SERÁ FATURADO     *}
          {* PELA EXPEDIÇÃO. PORTANTO O LOTE CORRETO SERÁ SOLICITADO *}
          {* DIRETAMENTE NA EXPEDIÇÃO.                               *}
          {********************************************************PZ*}
          If (Not blnUtiWms) And (SameText(FieldByName('DET_NUMLOT').AsString, 'A DEFINIR')) And (fEmptyStr(strCodCliConsulta)) And (Not blnSepFut) Then
          Begin
            FieldByName('LOTANT').AsString := 'A DEFINIR';

            If Not fTrocaLotePadrao(strNumLot, blnLiberouNaTrocaDoLote) Then
            Begin
              fMensagem('','É obrigatório a informação de um ' + objCadLot.strTitLab + ' válido' + #13#10 +
                           'para este item desta baixa de Entrega Futura!', ['&Ok']);
              pCancelar;
            End;

            FieldByName('DET_NUMLOT').AsString := strNumLot;
            TfrmGravando.fExecutarModal(pAcertaSaldoDisponivelNovoLote, 'Aguarde, calculando saldo disponível...','');
          End;

          fltSaldos := 0.0;
          fltSaldosSemLote := 0.0;
          If (Not blnLiberou) And (Not blnLiberouNaTrocaDoLote) Then
          Begin
            If blnUtilizaIteRetSaldo Then
            Begin
              If (blnInformaSaldoGeralDisponivel) And (FieldByName('DET_NUMLOT').AsString = 'A DEFINIR') Then
                fltSaldos := fRetornaSaldoDisponivel(FieldByName('CODITE').AsString,False,True,FieldByName('DET_NUMLOT').AsString, True, '', '', False, False, True, True)
              Else
                fltSaldos := fRetornaSaldoDisponivel(FieldByName('CODITE').AsString,False,True,FieldByName('DET_NUMLOT').AsString, True, '', '', False, False)
            End
            Else
            Begin
              pProcessaSaldoDisponivel(fltSaldos, fltSaldosSemLote, strMotFutAConsiderar);
            End;
          End;

          if (DataSet.FieldByName('DET_IDEPRO').AsString <> 'NOR') then
          begin
            If (Not IsTintaExistente(DataSet.FieldByName('DET_IDEPRO').AsString)) Then
            Begin
              pCancelar;
            End;

            recTinFor.Formulas := GetMatrizSaldoColorantes(
              DataSet.RecNo,
              DataSet.FieldByName('DET_CODITE').AsString,
              DataSet.FieldByName('DET_ITEEMB').AsString,
              DataSet.FieldByName('DET_IDEPRO').AsString,
              DataSet.FieldByName('DET_ITETIN').AsString,
              DataSet.FieldByName('DET_TIPPRE').AsString,
              DataSet.FieldByName('DET_LINLIN').AsString,
              DataSet.FieldByName('DET_CATALI').AsString,
              DataSet.FieldByName('DET_LAZQUA').AsInteger,
              DataSet.FieldByName('DET_QTDAEN').AsFloat,
              DataSet.FieldByName('DET_QTDAEN').AsFloat,
              DataSet.FieldByName('DET_DESCRI').AsString,
              DataSet.FieldByName('DET_VOLPRO').AsFloat,
              DataSet.FieldByName('DET_CODDIL').AsString,
              DataSet.FieldByName('DET_PORDIL').AsFloat,
              DataSet.FieldByName('DET_DILCON').AsString,
              DataSet.FieldByName('DET_PORCAT').AsFloat,
              DataSet.FieldByName('FOR_TIPCOR').AsString,
              DataSet.FieldByName('FOR_TEXBAS').AsString,
              DataSet.FieldByName('FOR_MODDIL').AsInteger,
              DataSet.FieldByName('FOR_ITECOB').AsString,
              DataSet.FieldByName('DET_CODEMP').AsString,
              DataSet.FieldByName('DET_EMPPRD').AsString,
              DataSet.FieldByName('DET_NUMDOC').AsString,
              DataSet.FieldByName('DET_ESPDOC').AsString,
              DataSet.FieldByName('DET_CODCLI').AsString,
              DataSet.FieldByName('DET_CODACA').AsString,
              DataSet.FieldByName('DET_EMPACA').AsString,
              blnLocFor);

            If Not blnLocFor Then
            Begin
              pCancelar;
            End;
          end;


          If (blnLiberou Or blnLiberouNaTrocaDoLote)
            Or (fVerificaQtdEstoque(fltSaldos,
                                    FieldByName('DET_QTDAEN').AsFloat,
                                    strSemEst,
                                    blnComSenha,
                                    blnPedSen,
                                    blnSemEst,
                                    recTinFor,
                                    fltSaldosSemLote,
                                    strMotFutAConsiderar)) Then
          Begin

            If blnComSenha Then
            Begin
              FieldByName('DET_QTDANT').AsFloat := FieldByName('DET_QTDAEN').AsFloat;
            End Else
            Begin

              If blnPedSen And Assigned(frmFatMostraProdSemSaldo) Then
                frmFatMostraProdSemSaldo.pIncluiItem(IIF(fatVenda.fEmpCarPreenchidaEmpDif(FieldByName('DET_EMPCAR').AsString, FieldByName('DET_CODEMP').AsString),
                                                         FieldByName('DET_EMPCAR').AsString, FieldByName('DET_CODEMP').AsString),
                                                     FieldByName('DET_CODITE').AsString,
                                                     FieldByName('DET_DESCRI').AsString,
                                                     fltSaldos,
                                                     FieldByName('DET_QTDITE').AsFloat,
                                                     FieldByName('DET_NUMLOT').AsString,
                                                     '',
                                                     '');


            End;

            strEndSel := IIF(fEmptyStr(FieldByName('ENTGER').AsString), '0', FieldByName('ENTGER').AsString);

          End Else
          Begin

            If blnComSenha Then
            Begin
              pCancelar;
            End

          End;

        End; {If (FieldByName('DET_QTDAEN').AsFloat <> FieldByName('DET_QTDANT').AsFloat) Then}

      End;

    End;
  Finally
    If (Not blnCancelou) And (Not blnMarcaTodos) Then
    Begin
      If (fltQtdAntesPost = 0) And fValorMaior(fltQtdQueroPost, 0) And (fQtdRegDoDocJaMarcado = 0) Then
      Begin
        If Not objLock.fLock_Unlock('MOVGER' + fChvDoc, True, False) Then
        Begin
          fMensagem('Atenção', fChvDoc(True) + ' está sendo utilizado em outra estação por ' + fGetHostLock('MOVGER' + fChvDoc) + '!', ['&Ok']);
          pCancelar;
        End;
      End
      Else If (fltQtdAntesPost <> 0) And (fltQtdQueroPost = 0) And (fQtdRegDoDocJaMarcado = 1) Then
      Begin
        objLock.fLock_Unlock('MOVGER' + fChvDoc, False, False);
      End;
    End;
  End;

end;

procedure TfrmFatBaixaEntregaFutura.chkExibirProdQtdeEntregarPreenchidaClick(
  Sender: TObject);
begin
  inherited;
  if (not cdsConsulta.Active) then
    Exit;

  if chkExibirProdQtdeEntregarPreenchida.Checked then
  begin
    cdsConsulta.Filtered := False;
    cdsConsulta.Filter := 'DET_QTDAEN > 0';
    cdsConsulta.Filtered := True;
  end
  else
  begin
    cdsConsulta.Filtered := False;
    cdsConsulta.Filter := '';
  end;
end;

procedure TfrmFatBaixaEntregaFutura.dbgvDadosItensCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if not cdsConsulta.Active then
    Exit;

  if (cdsConsulta.IsEmpty) then
    Exit;

  pControlaFoco;

  if (pnlLegendExp.Visible) and
     (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgvDadosItensDET_QTDAEN.Index] > 0) and
     (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgvDadosItensDET_QTDITE.Index] >
     (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgvDadosItensDET_QTDENT.Index] +
      Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgvDadosItensQTDFUT.Index] +
      Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgvDadosItensDET_QTDAEN.Index])) then
  begin
    ACanvas.Brush.Color  := clYellow;
    ACanvas.Font.Color   := clBlack;
  end
  else if (pnlLegendExp.Visible) and
          (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgvDadosItensDET_QTDITE.Index] =
          (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgvDadosItensDET_QTDENT.Index] +
           Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgvDadosItensQTDFUT.Index] +
           Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgvDadosItensDET_QTDAEN.Index])) then
  begin
    ACanvas.Brush.Color := clLime;
    ACanvas.Font.Color  := clBlack;
  end
  else if (pnlLegendSep.Visible) then
  begin
    if (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgvDadosItensSEP_QTDIMP.Index] > 0) then
    begin
      ACanvas.Brush.Color := clLime;
      ACanvas.Font.Color  := clBlack;
    end;

    if (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgvDadosItensDET_QTDAEN.Index] > 0) then
      ACanvas.Font.Color := clBlue;
  end;
end;

procedure TfrmFatBaixaEntregaFutura.dbgvDadosItensDblClick(Sender: TObject);
begin
  inherited;

  if (edtCodIte.Focused and
      fEmptyStr(edtCodIte.Text) and
      dbgDadosItens.Enabled) then
  begin
    if fCfgSis('SELENT', varBoolean) then
    begin
      if pnlTail.Visible and (not fEmptyStr(cdsConsulta.FieldByName('CODTIN').AsString)) then
      begin
        strCodTin           := cdsConsulta.FieldByName('CODTIN').AsString;
        dbgDadosItens.Enabled := False;
        edtCodIte.Text      := cdsConsulta.FieldByName('CODITE').AsString;
        blnUsaSelEnt        := True;
        dbgDadosItens.Repaint;
      end;
    end;
  end;
end;

procedure TfrmFatBaixaEntregaFutura.dbgvDadosItensEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  inherited;

  If (Key = '-') Or
     (CharInSet(Key, [',','.','-']) And
      ((Not fItemFracionado(cdsConsulta.FieldByName('DET_UNIDAD').AsString)) Or
       (Not fUnidadeDoProdutoEhFracionaria(cdsConsulta.FieldByName('DET_CODITE').AsString)))) Then
    Key := #0;
end;

procedure TfrmFatBaixaEntregaFutura.dtsConsultaStateChange(Sender: TObject);
begin
  inherited;
  chkExibirProdQtdeEntregarPreenchida.Enabled := (chkExibirProdQtdeEntregarPreenchida.Visible) and (cdsConsulta.Active) and (cdsConsulta.RecordCount > 0);
end;

procedure TfrmFatBaixaEntregaFutura.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
const
  RowMovementKeys = [VK_UP, VK_PRIOR, VK_DOWN, VK_NEXT, VK_HOME, VK_END];
Var
  strAutIncSel: String;
  intRecNoSel : Integer;
begin

  Case Key Of

    VK_F1    : Begin
                 If edtCodIte.Focused Then
                   btnQtdIte.Click;
               End; 
    VK_F2    : Begin
                 If Shift = [] Then
                 Begin
                   If cdsConsulta.State = dsEdit Then
                     cdsConsulta.Post;
                   btnEndEnt.Click;
                 End
                 Else
                  inherited;
               End;
    VK_F3    : If btnBaixaSimplificada.Visible Then btnBaixaSimplificada.Click;
    VK_F4    : If btnAlteraMotivo.Enabled Then btnAlteraMotivo.Click;
    VK_F6    : If btnMarcaTodos.Enabled Then btnMarcaTodos.Click;
    VK_F7    : If btnDesmarcaTodos.Enabled Then btnDesmarcaTodos.Click;
    VK_F8    : Begin
                 If ssAlt In Shift then
                 Begin
                   btnImpRelatorio.Click;
                 End
                 Else
                 Begin
                   If cdsConsulta.State = dsEdit Then
                     cdsConsulta.Post;
                   btnEndEntDoc.Click;
                 End;
               End;
    VK_F9    : If btnLimpaSeparacao.Visible Then
                 btnLimpaSeparacao.Click;
    VK_F10   : If btnGravar.Enabled And btnGravar.Visible Then
               Begin
                 Key := 0;
                 btnGravar.Click;
               End
               Else If btnImpSep.Visible Then
               Begin
                 Key := 0;
                 btnImpSep.Click;
               End;
    VK_F11   : btnEstLoj.Click;
    VK_F12   : btnFrete.Click;
    VK_RETURN: Begin
                 {NÃO ESTÁ EM MODO CONSULTA}
                 If fEmptyStr(strCodCliConsulta) Then
                 Begin
                   If edtCodIte.Focused And
                      fEmptyStr(edtCodIte.Text) And
                      dbgDadosItens.Enabled Then
                   Begin
                     If (pnlLegendExp.Visible) And
                        (cdsConsulta.FieldByName('DET_QTDITE').AsFloat = (cdsConsulta.FieldByName('DET_QTDENT').AsFloat +
                                                                          cdsConsulta.FieldByName('QTDFUT').AsFloat     +
                                                                          cdsConsulta.FieldByName('DET_QTDAEN').AsFloat)) And
                        (fMensagem('', 'Deseja desmarcar este produto?', ['&Sim', '&Não']) = 1) Then
                     Begin
                       strAutIncSel := cdsConsulta.FieldByName('DET_INCREM').AsString;
                       intRecNoSel  := cdsConsulta.RecNo;

                       With cdsConsulta Do
                       Begin
                         DisableControls;

                         Filtered := False;
                         Filter   := 'DET_INCREM = ' + QuotedStr(strAutIncSel);
                         Filtered := True;

                         Edit;
                         FieldByName('DET_QTDAEN').AsFloat := 0;
                         Post;

                         Filtered := False;
                         RecNo := intRecNoSel;
                         EnableControls;
                       End;
                     End;

                     If fCfgSis('SELENT', varBoolean) Then
                     Begin
                       If pnlTail.Visible And (Not fEmptyStr(cdsConsulta.FieldByName('CODTIN').AsString)) Then
                       Begin
                         strCodTin           := cdsConsulta.FieldByName('CODTIN').AsString;
                         dbgDadosItens.Enabled := False;
                         edtCodIte.Text      := cdsConsulta.FieldByName('CODITE').AsString;
                         blnUsaSelEnt        := True;
                       End;
                     End;
                   End
                   Else If (edtCodIte.Focused) And (Not fEmptyStr(edtCodIte.Text)) Then
                     pExpedeItem

                   Else If cdsConsulta.State = dsEdit Then
                   Begin
                     cdsConsulta.Post;
                     cdsConsulta.FieldByName('DET_QTDAEN').FocusControl;
                     pSetFocus(edtCodIte);
                   End
                   Else If cdsConsulta.Active And
                           (Not edtCodIte.Visible) And
                           (Not TcxGridDBBandedTableView(dbgvDadosItens).ColumnSelected('DET_QTDAEN')) Then
                   Begin
                     cdsConsulta.FieldByName('DET_QTDAEN').FocusControl;
                     cdsConsulta.Edit;
                   End;
                 End;
               End;
    VK_ESCAPE: If (Not dbgDadosItens.Enabled) Then
                 pLiberaGrid
               Else If cdsConsulta.State = dsEdit Then
                 cdsConsulta.Cancel
               Else
                 If (edtCodCliente.Focused) Or (Not fEmptyStr(strCodCliConsulta)) Then
                   Close;

                 {Else
                 Begin
                   Key := 0;
                   If fMensagem('', 'Deseja abandonar a tarefa?', ['&Sim', '&Não']) = 1 Then
                    pSetFocus(edtCodCliente)
                 End;}
    Else
      inherited;

    pControlaFoco;
  End;

  If (Key In RowMovementKeys) And (edtCodIte.Focused) And (Not blnSimulandoNavegacaoGrid) And (dbgDadosItens.Enabled) Then
  Begin
    blnSimulandoNavegacaoGrid := True;
    dbgDadosItens.Perform(WM_KEYDOWN, Key, 0);
    blnSimulandoNavegacaoGrid := False;
  End;
end;

procedure TfrmFatBaixaEntregaFutura.FormResize(Sender: TObject);
var
  intEspacoDisponivelDescricaoItem : Integer;
begin

  inherited;

  {Retorna tamanho padrão}
  If (Self.WindowState = wsNormal) Then
  Begin
    Self.Height := intAltForm;
    Self.Width  := intLarForm;
  End;

  {Ajusta coluna descrição com o tamanho disponível em tela}
  intEspacoDisponivelDescricaoItem := (Self.Width - fRetornaLarguraUtilizadaGrid);

  If (intEspacoDisponivelDescricaoItem > intTamMinDET_DESCRI) Then
    dbgvDadosItensDET_DESCRI.Width := intEspacoDisponivelDescricaoItem;

end;

procedure TfrmFatBaixaEntregaFutura.edtCodClienteEnter(Sender: TObject);
begin
  inherited;

  If fEmptyStr(strCodCliConsulta) Then
  Begin
    pZeraConsulta;
  End;
end;

procedure TfrmFatBaixaEntregaFutura.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;

  If Not btnMarcaTodos.Visible Then
    Exit;

  If ((Not cdsConsulta.Active) Or (cdsConsulta.IsEmpty)) Then
  Begin
    pMensagemOk('É necessário selecionar pelo menos um registro!');
    Exit;
  End;

  If blnSepFut Or (fCfgSis('BFUTMT') = '2') Then
  Begin
    If fMensagem('','Somente serão selecionados os produtos que ' +
                    'possuem estoque suficiente para realizar a entrega. ' +
                    'Deseja continuar?', ['', '']) = 1 Then
    Begin              
      pUnLockTodos;
      pMarcaTodosProdutosQuePodemSerAtendidos;
      pLockTodos;
    End;
  End
  Else
  Begin
    blnMarcaTodos := TRUE;
    blnValidaMarcarTodos := blnMarcaTodos;
    strTabela     := cdsConsulta.FieldByName('TABELA').AsString;
    blnUtilizaIteRetSaldo    := True;
    {*******************************************************}
    {* FAZ UMA CÓPIA DOS DADOS ANTERIOR PARA SER UTILIZADO *}
    {* CASO NÃO LIBERE OS PRODUTOS SEM SALDO               *}
    {*************************************************PZ-LE*}
    pUnLockTodos;
    TfrmGravando.fExecutarModal(pSalvaQtdDig, 'Aguarde...', '');
    TfrmGravando.fExecutarModal(pAbreConsulta, 'Aguarde... Carregando documentos.', '');
    
    If Not fTestaEstoque Then
    Begin
      blnValidaMarcarTodos := FALSE;
      blnMarcaTodos := FALSE;
      TfrmGravando.fExecutarModal(pRestauraQtdDig, 'Aguarde...', '');
    End;

    pLockTodos;

    If fClienteConsumidor(fRetNomCliente(edtCodCliente.Text)) Then
      fFiltraConsumidor;

   blnValidaMarcarTodos := FALSE;
   blnMarcaTodos := FALSE;
  End;

  dbgvDadosItens.ViewData.Expand(True);
end;

procedure TfrmFatBaixaEntregaFutura.btnQtdIteClick(Sender: TObject);
begin
  inherited;
  If (Not btnQtdIte.Enabled) Or (Not btnQtdIte.Visible) Then
    Exit;

  edtQtdIte.Enabled := True;
  pSetFocus(edtQtdIte);
end;

procedure TfrmFatBaixaEntregaFutura.btnBaixaSimplificadaClick(Sender: TObject);
  Var
    frmFatBaixaEntregaFuturaSimpl: TfrmFatBaixaEntregaFuturaSimpl;
begin
  inherited;
  If Not fVerificaSubControl(pnlHeader) Then
    Exit;

  objLock.pDestravarTodos;

  pCriarFormularios(TfrmFatBaixaEntregaFuturaSimpl, frmFatBaixaEntregaFuturaSimpl);
  Try
    frmFatBaixaEntregaFuturaSimpl.chkFalta.Checked    := chkFalta.Checked;
    frmFatBaixaEntregaFuturaSimpl.chkPrevisao.Checked := chkPrevisao.Checked;
    frmFatBaixaEntregaFuturaSimpl.chkAguarda.Checked  := chkAguarda.Checked;
    frmFatBaixaEntregaFuturaSimpl.lblCliBus.Visible   := lblCliBus.Visible;
    frmFatBaixaEntregaFuturaSimpl.cmbCliBus.Visible   := cmbCliBus.Visible;
    frmFatBaixaEntregaFuturaSimpl.cmbCliBus.ItemIndex := cmbCliBus.ItemIndex;
    frmFatBaixaEntregaFuturaSimpl.mskDtaIni.Text      := mskDtaIni.Text;
    frmFatBaixaEntregaFuturaSimpl.mskDtaFin.Text      := mskDtaFin.Text;
    frmFatBaixaEntregaFuturaSimpl.edtDocFat.Text      := edtDocFat.Text;
    frmFatBaixaEntregaFuturaSimpl.edtEspFat.Text      := edtEspFat.Text;
    frmFatBaixaEntregaFuturaSimpl.mskLinGru.Text      := mskLinGru.Text;
    frmFatBaixaEntregaFuturaSimpl.edtDesGru.Text      := edtDesGru.Text;
    frmFatBaixaEntregaFuturaSimpl.edtCodCliente.Text  := IIF(fEmptyStr(strAutoincMovsBaixaSimplificada),
                                                             edtCodCliente.Text, strFiltroCodCliBaixaSimplificada);
    frmFatBaixaEntregaFuturaSimpl.edtCodCidade.Text   := strFiltroCodCidBaixaSimplificada;
    frmFatBaixaEntregaFuturaSimpl.blnPrimeiraVez      := fEmptyStr(strAutoincMovsBaixaSimplificada);
    frmFatBaixaEntregaFuturaSimpl.blnSepFut           := blnSepFut;
    strAutoincMovsBaixaSimplificada := '';

    frmFatBaixaEntregaFuturaSimpl.ShowModal;

    If frmFatBaixaEntregaFuturaSimpl.ModalResult = mrOk Then
    Begin
      chkFalta.Checked    := frmFatBaixaEntregaFuturaSimpl.chkFalta.Checked;
      chkPrevisao.Checked := frmFatBaixaEntregaFuturaSimpl.chkPrevisao.Checked;
      chkAguarda.Checked  := frmFatBaixaEntregaFuturaSimpl.chkAguarda.Checked;
      If cmbCliBus.Visible Then
        cmbCliBus.ItemIndex := frmFatBaixaEntregaFuturaSimpl.cmbCliBus.ItemIndex;
      mskDtaIni.Text      := frmFatBaixaEntregaFuturaSimpl.mskDtaIni.Text;
      mskDtaFin.Text      := frmFatBaixaEntregaFuturaSimpl.mskDtaFin.Text;
      edtDocFat.Text      := frmFatBaixaEntregaFuturaSimpl.edtDocFat.Text;
      edtEspFat.Text      := frmFatBaixaEntregaFuturaSimpl.edtEspFat.Text;
      mskLinGru.Text      := frmFatBaixaEntregaFuturaSimpl.mskLinGru.Text;
      edtDesGru.Text      := frmFatBaixaEntregaFuturaSimpl.edtDesGru.Text;
      edtCodCliente.Text  := frmFatBaixaEntregaFuturaSimpl.cdsConsulta.FieldByName('DET_CODCLI').AsString;
      strAutoincMovsBaixaSimplificada := frmFatBaixaEntregaFuturaSimpl.cdsConsulta.FieldByName('AUTOINCREM').AsString;
      strFiltroCodCliBaixaSimplificada := frmFatBaixaEntregaFuturaSimpl.edtCodCliente.Text;
      strFiltroCodCidBaixaSimplificada := frmFatBaixaEntregaFuturaSimpl.edtCodCidade.Text;

      If chkSepImp.Visible Then
        chkSepImp.Checked := False;
      If chkExibirProdQtdeEntregarPreenchida.Visible Then
        chkExibirProdQtdeEntregarPreenchida.Checked := False;

      fValidaCampos(edtCodCliente);
    End;
  Finally
    pFreeAndNil(frmFatBaixaEntregaFuturaSimpl);
  End;
end;

procedure TfrmFatBaixaEntregaFutura.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;

  If Not btnDesmarcaTodos.Visible Then
    Exit;

  If ((Not cdsConsulta.Active) Or (cdsConsulta.IsEmpty)) Then
  Begin
    pMensagemOk('É necessário selecionar pelo menos um registro!');
    Exit;
  End;

  strTabela     := '';
  blnMarcaTodos := FALSE;
  pUnLockTodos;
  TfrmGravando.fExecutarModal(pAbreConsulta, 'Aguarde... Carregando documentos.', '');

  If fClienteConsumidor(fRetNomCliente(edtCodCliente.Text)) Then
    fFiltraConsumidor;
end;

Function TfrmFatBaixaEntregaFutura.fGetItem(qryGenIte: TUniQuery; strCodIte: String): Boolean;
  Var
    strSQL: String;
Begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  I.ITE_PESOIT, ';
    strSQL := strSQL + '  I.ITE_PESLIQ, ';    
    strSQL := strSQL + '  I.ITE_DESITE, ';
    strSQL := strSQL + '  I.ITE_DESFAB, ';
    strSQL := strSQL + '  I.ITE_COMLUB, ';
    strSQL := strSQL + '  I.ITE_CLAIPI, ';
    strSQL := strSQL + '  I.ITE_EXCIPI, ';
    strSQL := strSQL + '  I.ITE_CODFAB, ';
    strSQL := strSQL + '  I.ITE_CODBAR, ';
    strSQL := strSQL + '  G.ITE_PRECOM, ';
    strSQL := strSQL + '  G.ITE_PREVE1, ';
    strSQL := strSQL + '  G.ITE_PREVE2, ';
    strSQL := strSQL + '  G.ITE_PREVE3, ';
    strSQL := strSQL + '  G.ITE_PREVE4, ';
    strSQL := strSQL + '  G.ITE_PREVE5, ';
    strSQL := strSQL + '  G.ITE_PREVE6, ';
    strSQL := strSQL + '  G.ITE_PREVE7, ';
    strSQL := strSQL + '  G.ITE_PREULT, ';
    strSQL := strSQL + '  G.ITE_IMPULT, ';
    strSQL := strSQL + '  G.ITE_QTDUCO, ';
    strSQL := strSQL + '  G.ITE_IPISAI, ';
    strSQL := strSQL + '  G.ITE_DESMAX, ';
    strSQL := strSQL + '  G.ITE_SALDOS, ';
    strSQL := strSQL + '  G.ITE_PREMED, ';
    strSQL := strSQL + '  G.ITE_COMVAR, ';
    strSQL := strSQL + '  G.ITE_COMATA, ';
    strSQL := strSQL + '  G.ITE_COMDIS, ';
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
    strSQL := strSQL + '  A.ABF_CODABF, ';
    strSQL := strSQL + '  M.MAR_DESMAR, ';
    strSQL := strSQL + '  I.ITE_OBRCPF, ';
    strSQL := strSQL + '  I.ITE_CODFOR, ';

    If fCfgSis('IMPDIG') = '1' Then
      strSQL := strSQL + '  I.ITE_IMPDIR  '
    Else
      strSQL := strSQL + '  G.ITE_IMPDIR  ';
      
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G, ';
    strSQL := strSQL + '  ABFICM A, ';
    strSQL := strSQL + '  CADMAR M  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  I.ITE_CODMAR = M.MAR_CODMAR AND ';
    strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';

    If fCfgSIs('TIPABF') = '1' Then
      strSQL := strSQL + '  I.ITE_CODABF = A.ABF_CODABF AND '
    Else
      strSQL := strSQL + '  G.ITE_CODABF = A.ABF_CODABF AND ';

    strSQL := strSQL + '  I.ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  A.ABF_ESTADO = :ESTADO ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('ESTADO').AsString := fCadEmp('ESTADO');
      Open;
    End;

    Result := TRUE;

  Except

    On E: Exception Do
    Begin
      Result := False;
			pMensagensErro(E.Message,'[TfrmFatBaixaEntregaFutura.fGetItem]');
    End;

  End;
End;

Function TfrmFatBaixaEntregaFutura.fIncluiItens(fatVenda: TFatVenda; Const opcBaixa: TTipoBaixa): Boolean;
  Var
    qryGenIte   : TUniQuery;
    intContador : Integer;
    strMen001   : String;
    strMen002   : String;
    strNoDoc, strQtdDoc: String;
    recForTin: TForTin;
    fltIpiSai   : Double;
    strIteAbf   : String;
    strEntSai   : String;
    strEspFut   : String;
    strDocFut   : String;
    strEmpFut   : String;
    strProEmb   : String;
    strCodAbf   : String;
    strNumLot   : String;
    strLotAnt   : String;
    strMsgEfu   : String;
    fltDesEspIte: Double;
    fltDesEspBai: Double;
    blnMais1Vez : Boolean;
    recMadeira  : TDadosMadeira;
    sltAutoIncr : TStringList;
    LsrtCampoQuantidade : String;
    strTabDev   : String;
    strDivDev   : String;
    strDocDev   : String;
    strEspDev   : String;
    strEmpDev   : String;
    fltUniDev   : Double;
    fltQtdDev   : Double;
    strIncDev   : String;
    blnIgnoraFrete : Boolean;

  procedure pCarregaReferenciasDevolucao(strAutInc: String);
    Var
      strSQL   : String;
      qryGen: TUniQuery;
  begin
    qryGen := fCriaQuery(Nil);
    Try
      strSQL := '';
      strSQL := strSQL + ' SELECT DET_BAI.AUTOINCREM, DET_BAI.DET_NUMDOC, DET_BAI.DET_ESPDOC, DET_BAI.DET_CODEMP ';
      strSQL := strSQL + '   FROM MOVDET DET_BAI ';
      strSQL := strSQL + '  INNER JOIN MOVTRI TRI_BAI ON DET_BAI.AUTOINCREM = TRI_BAI.DET_SEQGER ';
      strSQL := strSQL + '  WHERE TRI_BAI.DET_INCFUT = :AUTINC ';
      strSQL := strSQL + '    AND DET_BAI.DET_NUMDOC = :NUMDOC ';
      strSQL := strSQL + '    AND DET_BAI.DET_ESPDOC = :ESPDOC ';
      strSQL := strSQL + '    AND DET_BAI.DET_CODEMP = :CODEMP ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('AUTINC').AsString := strAutInc;
        ParamByName('NUMDOC').AsString := FstrDocumentoParaDevolucao;
        ParamByName('ESPDOC').AsString := FstrEspecieParaDevolucao;
        ParamByName('CODEMP').AsString := FstrEmpresaParaDevolucao;
        
        Open;
        If Not IsEmpty Then
        Begin
          strTabDev := 'MOVDET'; 
          strDivDev := cdsConsulta.FieldByName('DET_CODDIV').AsString;
          fltUniDev := cdsConsulta.FieldByName('DET_UNITAR').AsFloat;
          fltQtdDev := cdsConsulta.Fieldbyname('QTDDEV').AsFloat;
          strDocDev := qryGen.FieldByName('DET_NUMDOC').AsString;
          strEspDev := qryGen.FieldByName('DET_ESPDOC').AsString;
          strEmpDev := qryGen.FieldByName('DET_CODEMP').AsString;
          strIncDev := qryGen.FieldByName('AUTOINCREM').AsString;          
        End;
        Close;
      End;

    Finally
      FreeAndNil(qryGen);
    End;
  end;

  function fRetEntRet():String;
  begin
    Result := 'R';

    If (cdsConsulta.FieldByName('DET_CLIBUS').AsString = 'N') Then
      Result := 'E';
  end;

  function fRetLocRet():String;
  begin
    Result := '';

    If (fRetEntRet() = 'R') And fCfgSis('LOCRET', VarBoolean) Then
      Result := 'E';
  end;
      
Begin
  Try
    LsrtCampoQuantidade := IIF(opcBaixa = bxBaixaNormal, 'DET_QTDAEN', 'QTDDEV');

    qryGenIte   := fCriaQuery;
    strMsgEfu   := fCfgSis('MSGEFU');
    sltAutoIncr := TStringList.Create;

    SetLength(fatVenda.arrChaveReferenciada, 0);

    With cdsConsulta Do
    Begin
      DisableControls;

      try
        intContador := 0;
        First;

        { ***************************************************************}
        {* variáveis para definir o tipo de mensagem a ser exibida      *}
        {* Se houver itens marcados em um único documento exibirá       *}
        {* as mensagens gravadas no MovGer.                             *}
        {***********************************21/07/09*********** AM ******}
        strNoDoc := '';
        strQtdDoc := '1';

        fatVenda.fltDesEsp := 0.00;
        fatVenda.dicDesEspItens.Limpar;

        If FieldByName(LsrtCampoQuantidade).AsFloat > 0 Then
          strNoDoc := FieldByName('DET_NUMDOC').AsString;

        fatVenda.fltValFre := 0.00;
        fatVenda.fltFreRat := 0.00;
        fatVenda.fltFreDig := 0.00;
        fatVenda.fltDesAce := 0.00;
        fatVenda.fltFreSug := 0.00;
        fltFreRatAux := 0;

        While Not Eof Do
        Begin
          if (opcBaixa In [bxBaixaAutomatica, bxDevolucaoAutomatica]) And (FieldByName('QTDDEV').AsFloat = 0) then
          Begin
            Next;
            Continue;
          End;

          If (FieldByName(LsrtCampoQuantidade).AsFloat > 0) And
             ((FieldByName('DET_CLAFIS').AsString = '1999') Or
              (sltAutoIncr.IndexOf(FieldByName('DET_INCREM').AsString) = -1)) Then
          Begin
            If FieldByName('DET_IDEPRO').AsString <> 'NOR' Then
            Begin
              If (Not IsTintaExistente(FieldByName('DET_IDEPRO').AsString)) Then
              Begin
                Result := False;
                First;
                EnableControls;
                Exit;
              End;
            End;

            inc(intContador);

            If (intContador = 1) Then
            Begin
              fatVenda.strCodVen := FieldByName('DET_CODVEN').AsString;
              fatVenda.strCodVe2 := FieldByName('DET_CODVE2').AsString;
              fatVenda.strNomVen := fRetNomVendRep(fatVenda.strCodVen);
              fatVenda.strSepExp   := FieldByName('CODSEP').AsString;
              fatVenda.strCfgENFUOP := FieldByName('AUX_ENFUOP').AsString;

              If fCfgSis('CADFAZ', varBoolean) And (Not fEmptyStr(FieldByName('AUX_CODFAZ').AsString)) Then
                fatVenda.fSelecionarFazendaCliente(edtCodCliente.Text, FieldByName('AUX_CODFAZ').AsString);

              {*********************************************}
              {* CASO TENHA SELECIONADO CLIENTE CONSUMIDOR *}
              {******************************************JC*}
              If fClienteConsumidor(fRetNomCliente(edtCodCliente.Text)) Then
              Begin
                fatVenda.strCliNom := FieldByName('GER_NOMCON').AsString;
                fatVenda.strCliEnd := FieldByName('GER_ENDCON').AsString;
                fatVenda.strCliBai := FieldByName('GER_BAICON').AsString;
                fatVenda.strCliCep := FieldByName('GER_CEPCON').AsString;
                fatVenda.strCodCid := FieldByName('GER_CIDCON').AsString;
                fatVenda.strCliCid := fRetNomCidade(fatVenda.strCodCid);
                fatVenda.strCliEst := FieldByName('GER_ESTCON').AsString;
                fatVenda.strCliTel := FieldByName('GER_TELCON').AsString;
                fatVenda.dtaNasCon := FieldByName('AUX_NASCON').AsDateTime;
                fatVenda.intCgcCpf := FieldByName('GER_CGCCPF').AsInteger;
                fatVenda.strCliCgc := FieldByName('GER_CGCCON').AsString;
                fatVenda.strCliIes := FieldByName('GER_IESCON').AsString;
                fatVenda.strCli_Rg := FieldByName('GER_R_GCON').AsString;
                fatVenda.strCliEma := FieldByName('GER_EMLCON').AsString;
              End;

            End;

            fGetItem(qryGenIte,FieldByName('DET_CODITE').AsString);

            If Pos(FieldByName('DET_NUMDOC').AsString + '-' + FieldByName('DET_ESPDOC').AsString,fatVenda.strMen001) <= 0 Then
              fatVenda.strMen001 := fatVenda.strMen001 +
                                    FieldByName('DET_NUMDOC').AsString + '-' + FieldByName('DET_ESPDOC').AsString + ',';

            If Pos(FieldByName('DET_CODVEN').AsString + '-' + fRetNomVendRep(FieldByName('DET_CODVEN').AsString), fatVenda.strMen002) <= 0 Then
              fatVenda.strMen002 := fatVenda.strMen002 +
                                    FieldByName('DET_CODVEN').AsString + '-' + fRetNomVendRep(FieldByName('DET_CODVEN').AsString) + ',';

            {*****************************************}
            {* ARMAZENA AS NOVAS MENSAGENS P\ UTIZAR *}
            {* NA IMPRESSAO DE DOCS, EXETO QUANDO NF *}
            {**************************************JB*}
            arrMenDoc[1] := fatVenda.strMen001;
            arrMenDoc[2] := fatVenda.strMen002;

            {**************************************}
            {* CARREGAS AS MENSAGENS DE EXPEDICAO *}
            {************************************FC}
            fatVenda.strMenExp := FieldByName('GER_MENEXP').AsString;
            fatVenda.strMenEx2 := FieldByName('GER_MENEX2').AsString;
            fatVenda.strMenEx3 := FieldByName('GER_MENEX3').AsString;
            fatVenda.strMenEx4 := FieldByName('GER_MENEX4').AsString;

            {****************************************************************}
            {* Se houver itens marcados em um único documento exibirá       *}
            {* as mensagens gravadas no MovGer.                             *}
            {***********************************21/07/09*********** AM **PE**}
            If (strMsgEfu = 'S') Then
            Begin
              strMen001 := FieldByName('GER_MEN001').AsString;
              strMen002 := FieldByName('GER_MEN002').AsString;
            End;

            strNumLot := FieldByName('DET_NUMLOT').AsString;
            strLotAnt := FieldByName('LOTANT').AsString;

            fatVenda.strEntGer := FieldByName('ENTGER').AsString;

            FillChar(recMadeira, SizeOf(recMadeira), #0);

            If fatVenda.fUtilizaVendaMadeiraOuVidroOuMetroLinear Then
            Begin
              recMadeira.fltComPec := FieldByName('DET_COMPEC').AsFloat;
              recMadeira.fltLarPec := FieldByName('DET_LARPEC').AsFloat;
              recMadeira.fltEspPec := FieldByName('DET_ESPPEC').AsFloat;

              recMadeira.fltQtdPec := fCalculaQuantidadePecas(FieldByName(LsrtCampoQuantidade).AsFloat,
                                                              recMadeira.fltComPec,
                                                              recMadeira.fltLarPec,
                                                              recMadeira.fltEspPec,
                                                              fRetSiglaUnidade(FieldByName('DET_UNIDAD').AsString));

              recMadeira.strAparel := FieldByName('DET_APAREL').AsString;
              recMadeira.fltPerApa := FieldByName('DET_PERAPA').AsFloat;
              recMadeira.strBenefi := FieldByName('DET_BENEFI').AsString;
              recMadeira.fltPerBen := FieldByName('DET_PERBEN').AsFloat;
            End;

            fatVenda.fltDesAce := fatVenda.fltDesAce +
                                  FieldByName('DET_DESACE').AsFloat /
                                  FieldByName('DET_QTDITE').AsFloat *
                                  (FieldByName(LsrtCampoQuantidade).AsFloat);

            blnIgnoraFrete := SameText('999', RightStr(cdsConsulta.FieldByName('DET_CLAFIS').AsString, 3));

            If (Not blnIgnoraFrete) Then
            Begin
              fatVenda.fltValFre := fFormataFloat(fatVenda.fltValFre +
                                                  FieldByName('DET_TOTFRE').AsFloat /
                                                  FieldByName('DET_QTDITE').AsFloat *
                                                  (FieldByName(LsrtCampoQuantidade).AsFloat), 2);
            End;

            fltFreRatAux := fltFreRatAux +
                            FieldByName('DET_FRERAT').AsFloat /
                            FieldByName('DET_QTDITE').AsFloat *
                           (FieldByName(LsrtCampoQuantidade).AsFloat);

            fatVenda.fltFreSug := FieldByName('DET_FRESUG').AsFloat /
                                  FieldByName('DET_QTDITE').AsFloat *
                                 (FieldByName(LsrtCampoQuantidade).AsFloat);

            fatVenda.fltFreDig := fatVenda.fltValFre;

            fatVenda.fltCusIte := FieldByName('DET_TOTCUS').AsFloat / FieldByName('DET_QTDITE').AsFloat;
            fatVenda.fltPreCus := FieldByName('DET_TOTCUS').AsFloat / FieldByName('DET_QTDITE').AsFloat;
            fatVenda.fltPreCu2 := FieldByName('DET_TOTCU2').AsFloat / FieldByName('DET_QTDITE').AsFloat;

            recForTin.strTipCor   := cdsConsulta.FieldByName('FOR_TIPCOR').AsString;
            recForTin.strTextBase := cdsConsulta.FieldByName('FOR_TEXBAS').AsString;
            recForTin.intModDil   := IfNull(cdsConsulta.FieldByName('FOR_MODDIL').Value, 0);
            recForTin.strCompB    := cdsConsulta.FieldByName('FOR_ITECOB').AsString;

            strCodAbf := '';
            strIteAbf := '';
            fltIpiSai := qryGenIte.FieldByName('ITE_IPISAI').AsFloat;

            //Se for uma entrega futura dos sub-itens de um produto estrutura entao devemos utilizar a abreviacao fiscal do item principal
            If (fCfgSis('EFTEST') = '2') And (FieldByName('DET_BXSBIT').AsString = 'S') Then
            Begin
              strIteAbf := FieldByName('DET_ITEABF').AsString;
              fltIpiSai := fCampoTabela('ITE_IPISAI', 'ITEGER', ['ITE_CODITE','ITE_CODEMP'], [strIteAbf, VS_strCodEmp]);

              If fCfgSis('TIPABF') = '1' Then
                strCodAbf := fCampoTabela('ITE_CODABF', 'CADITE', ['ITE_CODITE'], [strIteAbf])
              Else
                strCodAbf := fCampoTabela('ITE_CODABF', 'ITEGER', ['ITE_CODITE','ITE_CODEMP'], [strIteAbf, VS_strCodEmp]);
            End;

            strEspFut := FieldByName('DET_ESPDOC').AsString;
            strDocFut := FieldByName('DET_NUMDOC').AsString;
            strEmpFut := FieldByName('DET_CODEMP').AsString;

            strDivDev := '';
            strDocDev := '';
            strEspDev := '';
            strEmpDev := '';
            fltUniDev := 0;
            fltQtdDev := 0;
            strIncDev := '';
            If fCfgSis('DEVEFT', varBoolean) Then
              If (opcBaixa = bxDevolucaoAutomatica) Then
                pCarregaReferenciasDevolucao(FieldByName('DET_INCREM').AsString);

            strEntSai := 'S';
            strProEmb := 'N';

            If (fCfgSis('EFTEST') = '2') And (fCfgSis('EFTESE') = '1') Then
            Begin
              If (FieldByName('DET_BXSBIT').AsString = 'S') Then
              Begin
                strProEmb := 'S';
              End;

              If (FieldByName('DET_CLAFIS').AsString = '1999') Then
              Begin
                strEntSai := 'E';
                strProEmb := 'S';
                strEspFut := '';
                strDocFut := '';
                strEmpFut := '';
              End;
            End;

            If fEmptyStr(strCodAbf) Then
              strCodAbf := qryGenIte.FieldByName('ABF_CODABF').AsString;

            If (FieldByName('DET_CLAFIS').AsString <> '1999') Then
              sltAutoIncr.Add(FieldByName('DET_INCREM').AsString);

            stlDocsConf.Add(fChvDoc);

            pAdicionaItemParaReprocessamentoDeSaldo(FieldByName('DET_CODITE').AsString);

            fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
                                                 Nil,
                                                 FieldByName('DET_IDEPRO').AsString,
                                                 FieldByName('ITE_CODGRU').AsString,
                                                 FieldByName('DET_CODITE').AsString,
                                                 qryGenIte.FieldByName('ITE_DESITE').AsString,
                                                 FieldByName('DET_DESCRI').AsString,
                                                 qryGenIte.FieldByName('ITE_DESFAB').AsString,
                                                 FieldByName('DET_UNIDAD').AsString,
                                                 FieldByName('DET_UNIDAD').AsString,
                                                 FieldByName('DET_CODMAR').AsString,
                                                 qryGenIte.FieldByName('ITE_CODFOR').AsString,
                                                 FieldByName('DET_REFERE').AsString,
                                                 FieldByName('DET_UNIORI').AsFloat,
                                                 FieldByName('DET_UNIVIS').AsFloat,
                                                 FieldByName('DET_UNITAR').AsFloat,
                                                 0.0,
                                                 FieldByName('DET_DESCON').AsFloat,
                                                 FieldByName(LsrtCampoQuantidade).AsFloat,
                                                 FieldByName('DET_UNITAR').AsFloat*FieldByName(LsrtCampoQuantidade).AsFloat,
                                                 strEntSai,
                                                 fatVenda.fltPreCus,
                                                 fFormataFloat(fatVenda.fltPreCus *FieldByName(LsrtCampoQuantidade).AsFloat, 2),
                                                 qryGenIte.FieldByName('ITE_COMLUB').AsString,
                                                 fltIpiSai,
                                                 qryGenIte.FieldByName('ITE_DESMAX').AsFloat,
                                                 qryGenIte.FieldByName('ITE_PREVE1').AsFloat,
                                                 qryGenIte.FieldByName('ITE_PREVE2').AsFloat,
                                                 qryGenIte.FieldByName('ITE_PREVE3').AsFloat,
                                                 qryGenIte.FieldByName('ITE_PREVE4').AsFloat,
                                                 qryGenIte.FieldByName('ITE_PREVE5').AsFloat,
                                                 qryGenIte.FieldByName('ITE_PREVE6').AsFloat,
                                                 qryGenIte.FieldByName('ITE_PREVE7').AsFloat,
                                                 fCalculaPrecoVenda(2, fFormataFloat(fatVenda.fltPreCus *FieldByName(LsrtCampoQuantidade).AsFloat, 2), FieldByName('DET_UNITAR').AsFloat, 0, 0, 0, 0, 0),
                                                 qryGenIte.FieldByName('ITE_SALDOS').AsFloat,
                                                 FieldByName('DET_INCPIS').AsString,
                                                 IIF((opcBaixa = bxBaixaNormal) And blnPermiteEscolherEspecie, 0, qryGenIte.FieldByName('ITE_COMVAR').AsFloat),
                                                 IIF((opcBaixa = bxBaixaNormal) And blnPermiteEscolherEspecie, 0, qryGenIte.FieldByName('ITE_COMATA').AsFloat),
                                                 IIF((opcBaixa = bxBaixaNormal) And blnPermiteEscolherEspecie, 0, qryGenIte.FieldByName('ITE_COMDIS').AsFloat),
                                                 strDocDev,
                                                 strEspDev,
                                                 strEmpDev,
                                                 fltQtdDev,
                                                 fltUniDev,
                                                 strIncDev,
                                                (cdsConsulta.Fieldbyname('DET_PREULT').AsFloat *FieldByName(LsrtCampoQuantidade).AsFloat),
                                                 cdsConsulta.Fieldbyname('DET_IMPULT').AsFloat,
                                                 cdsConsulta.Fieldbyname('DET_PREULT').AsFloat,
                                                 cdsConsulta.Fieldbyname('DET_PREMED').AsFloat,
                                                 qryGenIte.FieldByName('ITE_CLAIPI').AsString,
                                                 FieldByName('DET_ITECHA').AsString,
                                                 FieldByName('DET_ITETIN').AsString,
                                                 FieldByName('DET_DESCOR').AsString,
                                                 FieldByName('DET_TIPPRE').AsString,
                                                 FieldByName('DET_LAZQUA').AsInteger,
                                                 FieldByName('DET_TIPEMB').AsString,
                                                 0,
                                                 0,
                                                 FieldByName('DET_PRVTIN').AsFloat,
                                                 FieldByName('DET_PRCTIN').AsFloat,
                                                 FieldByName('DET_FATTIN').AsFloat,
                                                 strProEmb,
                                                 FieldByName('DET_ITEEMB').AsString,
                                                 0,
                                                 0,
                                                 strCodAbf,
                                                 qryGenIte.FieldByName('ITE_PESOIT').AsFloat,
                                                 qryGenIte.FieldByName('ITE_PESLIQ').AsFloat,
                                                 FieldByName('DET_PROMOC').AsString,
                                                 0,
                                                 0,
                                                 0,
                                                 0,
                                                 IIF(fEmptyStr(FieldByName('DET_SEQTIN').AsString), '', '2'),
                                                 fatVenda.fRetPerComGrupo(FieldByName('ITE_CODGRU').AsString),
                                                 qryGenIte.FieldByName('ITE_CODFAB').AsString,
                                                 0,
                                                 0,
                                                 '',
                                                 '',
                                                 IIF((opcBaixa = bxDevolucaoAutomatica), FieldByName('DET_EMPORI').AsString, ''),
                                                 qryGenIte.FieldByName('ITE_MARMIN').AsFloat,
                                                 qryGenIte.FieldByName('ITE_MARMSG').AsFloat,
                                                 qryGenIte.FieldByName('ITE_MARMGE').AsFloat,
                                                 fRetNomMarca(FieldByName('DET_CODMAR').AsString),
                                                 '',
                                                 0,
                                                 0,
                                                 strIncDev, //strSeqDet
                                                 FieldByName('DET_CATALI').AsString,
                                                 FieldByName('DET_LINLIN').AsString,
                                                 0,
                                                 '',
                                                 '',
                                                 '',
                                                 qryGenIte.FieldByName('ITE_PRECOM').AsFloat,
                                                 FieldByName('DET_UNIDIG').AsFloat,
                                                 qryGenIte.FieldByName('ITE_QTPPRO').AsFloat,
                                                 FieldByName('DET_COMPLE').AsString,
                                                 strDivDev,
                                                 qryGenIte.FieldByName('ITE_OBRCPF').AsString,
                                                 '',
                                                 '',
                                                 fRetSiglaUnidade(FieldByName('DET_UNIDAD').AsString),
                                                 FieldByName('DET_VOLPRO').AsFloat,
                                                 intContador,
                                                 '',
                                                 FieldByName('DET_CODACA').AsString,
                                                 FieldByName('DET_EMPACA').AsString,
                                                 FieldByName('DET_PROACA').AsString = 'S',
                                                 strEspFut,
                                                 strDocFut,
                                                 strEmpFut,
                                                 cdsConsulta.Fieldbyname('DET_OUTVAL').AsFloat, //OUTVAL
                                                 0,
                                                 cdsConsulta.Fieldbyname('DET_DESOPE').AsFloat, //DESOPE
                                                 cdsConsulta.Fieldbyname('DET_ICMSAI').AsFloat, //ICMSAI
                                                 cdsConsulta.Fieldbyname('DET_IMPFED').AsFloat, //IMPFED
                                                 0,
                                                 '',
                                                 '',
                                                 '',
                                                 FieldByName('DET_TABPRE').AsString,
                                                 qryGenIte.FieldByName('ITE_IPIENT').AsFloat,
                                                 qryGenIte.FieldByName('ITE_FREENT').AsFloat,
                                                 cdsConsulta.Fieldbyname('DET_CODDIL').AsString,
                                                 0.0,
                                                 '',
                                                 0.0,
                                                 fRetEntRet(),
                                                 fRetLocRet(),
                                                 IIF(blnBFut49, FieldByName('DET_ENTFUT').AsString,'N'),
                                                 IIF(blnBFut49, FieldByName('DET_MOTFUT').AsString, ''),
                                                 dtaDtEntr,
                                                 FieldByName(LsrtCampoQuantidade).AsFloat,
                                                 0.0,
                                                 0,
                                                 qryGenIte.FieldByName('ITE_IMPDIR').AsString,
                                                 '',
                                                 fatVenda.fltPreCu2,
                                                 fFormataFloat(fatVenda.fltPreCu2 *FieldByName(LsrtCampoQuantidade).AsFloat, 2),
                                                 0,
                                                 0,
                                                 0,
                                                 0,
                                                 0,
                                                 0,
                                                 recForTin,
                                                 '',
                                                 strLotAnt,
                                                 strNumLot,
                                                 '',
                                                 '',
                                                 IIF(fCfgSis('EMPCAR', varBoolean) And (FieldByName('GER_ENTFAT').AsString = 'S'),
                                                     FieldByName('DET_BXSBIT').AsString = 'S', False), //blnBxSbIt
                                                 IIF((opcBaixa In [bxBaixaAutomatica, bxDevolucaoAutomatica]), 'S', 'N'),
                                                 FieldByName('DET_IDEPRO').AsString,
                                                 0,
                                                 strTabDev,
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
                                                 fatVenda.fltCusIte,
                                                 '',
                                                 '',
                                                 recMadeira,
                                                 IfThen((FieldByName('DET_IDEPRO').AsString = 'NOR') and (FieldByName('DET_PROACA').AsString <> 'S'), qryGenIte.FieldByName('ITE_IMPULT').AsFloat, cdsConsulta.Fieldbyname('DET_IMPULT').AsFloat) * FieldByName('DET_QTDAEN').AsFloat,
                                                 FieldByName('DET_VAL_RT').AsFloat,
                                                 FieldByName('DET_TAXJUR').AsFloat,
                                                 '',
                                                 0,
                                                 '',
                                                 '',
                                                 0,
                                                 0,
                                                 '',
                                                 '',
                                                 0,
                                                 FieldByName('DET_CODVEN').AsString,
                                                 'N',
                                                 FieldByName('DET_PERCOM').AsFloat,
                                                 0,
                                                 0,
                                                 False,
                                                 False,
                                                 FieldByName('DET_CLIBUS').AsString,
                                                 FieldByName('DET_TURENT').AsString,
                                                 0,
                                                 0,
                                                 FieldByName('DET_CODVE2').AsString,
                                                 'N',
                                                 0,
                                                 '',
                                                 IIF(opcBaixa In [bxBaixaNormal, bxBaixaAutomatica], FieldByName('DET_INCREM').AsString,''), //strIncFut
                                                 '',
                                                 '',
                                                 qryGenIte.FieldByName('ITE_EXCIPI').AsString,
                                                 0,
                                                 strIncDev, //strAiDvOr
                                                 IIF((opcBaixa = bxBaixaNormal) And blnPermiteEscolherEspecie, FieldByName('DET_CLAFIS').AsString, ''),
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
                                                 strIteAbf,
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
                                                 FieldByName('DET_EMPCAR').AsString,
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
                                                 qryGenIte.FieldByName('ITE_MARMMG').AsFloat,
                                                 0,
                                                 '',
                                                 'S',
                                                 cdsConsulta.FieldByName('DET_LOCFIS').AsString);

            If fatVenda.fGravaChaveReferenciada Then
            Begin
              fatVenda.pCarregaChaveReferenciada(cdsConsulta, True);
            End;

            fltDesEspIte := 0.00;

            If (FieldByName('DET_DESESP').AsFloat > 0.00) And (FieldByName('DET_CLAFIS').AsString <> '1999') Then
            Begin
              //desconto especial ja baixado (pode estar no desesp ou no unitario)
              fltDesEspBai := fGetDescontoEspecialJaUtilizado(FieldByName('DET_NUMDOC').AsString,
                                                              FieldByName('DET_ESPDOC').AsString,
                                                              FieldByName('DET_CODEMP').AsString,
                                                              FieldByName('DET_CODITE').AsString,
                                                              FieldByName('AUTOINCREM').AsString,
                                                              FieldByName('DET_UNITAR').AsFloat);

              blnMais1Vez := fGetItemMaisDe1VezNoDocumento(FieldByName('DET_NUMDOC').AsString,
                                                           FieldByName('DET_ESPDOC').AsString,
                                                           FieldByName('DET_CODEMP').AsString,
                                                           FieldByName('DET_CODITE').AsString);

              //Caso for baixa total Grava a diferenca entre o desconto especial e o ja foi baixado
              If (fFormataFloat(FieldByName(LsrtCampoQuantidade).AsFloat, 4) =
                  fFormataFloat(FieldByName('DET_QTDPEN').AsFloat, 4)) And (Not blnMais1Vez) Then
              Begin
                fltDesEspIte := fFormataFloat(FieldByName('DET_DESESP').AsFloat - fltDesEspBai, 2);
              End
              //Caso for baixa parcial grava o desconto especial proporcional
              Else
                fltDesEspIte := fFormataFloat(FieldByName('DET_DESESP').AsFloat /
                                              FieldByName('DET_QTDITE').AsFloat *
                                              FieldByName(LsrtCampoQuantidade).AsFloat, 2);

              if (opcBaixa In [bxBaixaAutomatica, bxDevolucaoAutomatica]) then
              Begin
                if not (opcBaixa = bxDevolucaoAutomatica) then
                Begin
                  FcdsValoresItensDocumentoBaixa.Append;
                  FcdsValoresItensDocumentoBaixa.FieldByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
                  FcdsValoresItensDocumentoBaixa.FieldByName('DESESP').AsFloat  := fltDesEspIte;
                  FcdsValoresItensDocumentoBaixa.Post;
                End
                Else
                Begin
                  If FcdsValoresItensDocumentoBaixa.Locate('AUTINC', FieldByName('AUTOINCREM').AsString, []) Then
                    fltDesEspIte := FcdsValoresItensDocumentoBaixa.FieldByName('DESESP').AsFloat;
                End;
              End;
            End;

            //Armazena o desconto especial do Item para apos o Rateio voltar o Valor original por item
            fatVenda.dicDesEspItens[cdsVenda.FieldByName('AUTOINCREM').AsString] := fltDesEspIte;

            fatVenda.fltDesEsp := fatVenda.fltDesEsp + fltDesEspIte;

          End;

         {***************************************************************}
         {* Se houver itens marcados em um único documento exibirá      *}
         {* as mensagens gravadas no MovGer.                            *}
         {***********************************21/07/09*********** AM *****}
          If FieldByName(LsrtCampoQuantidade).AsFloat > 0 Then
            If Not (fEmptyStr(strNoDoc)) Then
              If (strQtdDoc <> '+1') Then // se já foram encontrados mais de um documento nem testa
                If strNoDoc <> FieldByName('DET_NUMDOC').AsString Then // se encontrou NUMDOC diferente com qtd > 0
                Begin
                  strNoDoc := FieldByName('DET_NUMDOC').AsString;       // significa que há mais de um documento envolvido
                  strQtdDoc := '+1';
                End;

          Next;

        End; {While}

        FreeAndNil(sltAutoIncr);

        If Not fEmptyStr(fatVenda.strMen001) Then
          fatVenda.strMen001 := LeftStr(fatVenda.strMen001, Length(fatVenda.strMen001)-1);
        If Not fEmptyStr(fatVenda.strMen002) Then
          fatVenda.strMen002 := LeftStr(fatVenda.strMen002, Length(fatVenda.strMen002)-1);

  //      If (Not fCfgSis('MSGEFU', varBoolean)) Then
  //      Begin
          If strQtdDoc = '+1' Then // quando existem itens de mais de 1 documento
          Begin
            strMen001 := fatVenda.strMen001;
            fatVenda.strMen001 := strMen001;
          End
          Else  // quando só existem itens de um único documento
          Begin
            fatVenda.strMen001 := fatVenda.strMen001 + IIF(fEmptyStr(strMen001),'', ' ' + strMen001);
            fatVenda.strMen002 := strMen002;
          End;
  //      End Else
  //      Begin
  //        fatVenda.strMen001 := strMen001Pri;
  //        fatVenda.strMen002 := strMen002Pri;
  //      End;

      finally
        EnableControls;
      end;
    End; {With}

    Result := TRUE;

    FreeAndNil(qryGenIte);

    If Not fCfgSis('MENDOC', VarBoolean) Then
      fatVenda.strMen001 := '';
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[TfrmFatBaixaEntregaFutura.fIncluiItens]');
    End;
  End;

End;

function TfrmFatBaixaEntregaFutura.fTrocaLotePadrao(Var strNovoLote: String; Var blnLiberou: Boolean): Boolean;
  Var blnConfirma: Boolean;
      frmDigCodigoLote: TfrmDigCodigoLote;
Begin

  blnLiberou := False;
  Try
    Application.ProcessMessages;
    pCriarFormularios(TfrmDigCodigoLote, frmDigCodigoLote);
    frmDigCodigoLote.edtCodIte.Text := cdsConsulta.FieldByName('DET_CODITE').AsString;
    frmDigCodigoLote.edtDesIte.Text := cdsConsulta.FieldByName('DET_DESCRI').AsString;
    frmDigCodigoLote.edtCodEmp.Text := cdsConsulta.FieldByName('DET_CODEMP').AsString;
    frmDigCodigoLote.pSetQtdEnt(cdsConsulta.FieldByName('DET_QTDAEN').AsFloat);
    frmDigCodigoLote.pSetMotFut(cdsConsulta.FieldByName('DET_MOTFUT').AsString);
    frmDigCodigoLote.OperacaoOrigemFaturamento := ofBaixaDeEntregaFutura;
    Application.ProcessMessages;
    blnConfirma := (frmDigCodigoLote.ShowModal = mrOk);

    If (blnConfirma) Then
    Begin
      strNovoLote := frmDigCodigoLote.edtNumLot.Text;
      blnLiberou := frmDigCodigoLote.blnLiberou;
    End;
  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '[TfrmFatBaixaEntregaFutura.fTrocaLotePadrao]');
    End;
  End;
  pFreeAndNil(frmDigCodigoLote);

  Result := blnConfirma;
End;

Function TfrmFatBaixaEntregaFutura.fGetTipoFaturamento(fatVenda: TFatVenda; AblnEhDevolucao : Boolean = False): Boolean;
  Var
    arrOpcoes: TOpcoesFaturamentoArray;
    frmFatTipoFaturamento : TfrmFatTipoFaturamento;
Begin
  Result := FALSE;
  SetLength(arrOpcoes, 1);

  arrOpcoes[0].strDesCri := 'Nota Fiscal';
  arrOpcoes[0].strEspDoc := 'NF';
  arrOpcoes[0].strOpcLet := 'N';
  arrOpcoes[0].strMosMen := 'S';

  If ((fCfgSis('PEMIFF') = '1') And fCfgSis('PERMFF', varBoolean)) Or
     ((fCfgSis('PEMIFF') = '2') And blnPermFF) Or
     (fBaixaDeEntregaFuturaApenasComoControleDeEntrega) Then
  Begin
    SetLength(arrOpcoes, 2);
    arrOpcoes[1].strDesCri := 'Faturamento Futuro';
    arrOpcoes[1].strEspDoc := 'FF';
    arrOpcoes[1].strOpcLet := 'F';
    arrOpcoes[1].strMosMen := IIF(blnPermiteEscolherEspecie And (Not AblnEhDevolucao), 'S', 'N');
  End;

  If blnPermiteEscolherEspecie And (Not AblnEhDevolucao) Then
  Begin
    SetLength(arrOpcoes, 3);
    arrOpcoes[2].strDesCri := fDescricaoIF;
    arrOpcoes[2].strEspDoc := 'IF';
    arrOpcoes[2].strOpcLet := 'C';
    arrOpcoes[2].strMosMen := 'S';
  End;

  //Entrega Futura apenas como controle de entrega - sempre FF
  If (fBaixaDeEntregaFuturaApenasComoControleDeEntrega) And 
     (Not fPermiteEscolherFechamentoNaBaixaDeEntregaFutura) Then
  Begin
    fatVenda.strEspDoc := arrOpcoes[1].strEspDoc;
    fatVenda.strTipFat := arrOpcoes[1].strDesCri;
    Result := TRUE;    
  End
  Else If (blnDocOri and not(AblnEhDevolucao)) or
          (AblnEhDevolucao and (fCfgSis('BEFEDV', varString) = 'O')) Then
  Begin
    cdsAux.Data     := cdsConsulta.Data;

    If (blnDocOri and not(AblnEhDevolucao)) then
      cdsAux.Filter   := 'DET_QTDAEN > 0'
    Else
      cdsAux.Filter   := 'QTDDEV > 0';

    cdsAux.Filtered := True;
    cdsAux.First;

    If not cdsAux.isEmpty Then
    Begin
      If Pos(cdsAux.FieldByName('GER_ESPDOC').AsString, ESPECIE_FISCAL) > 0 Then
      Begin
        fatVenda.strEspDoc := arrOpcoes[0].strEspDoc;
        fatVenda.strTipFat := arrOpcoes[0].strDesCri;
      End
      Else
      Begin
        if ( Length(arrOpcoes) >= 2 ) then
        begin
          fatVenda.strEspDoc := arrOpcoes[1].strEspDoc;
          fatVenda.strTipFat := arrOpcoes[1].strDesCri;
        end
        else
        begin
          if (fCfgSis('PEMIFF') = '1') Then
            fMensagem('ATENÇÃO!', 'Sistema não configurado para fechamento em FF.' + #10#13 +
                                  'Alterar a configuração CFG_PERMFF para permissão de faturamento com essa espécie!', ['&OK'])
          else
            fMensagem('ATENÇÃO!', 'Cliente não tem permissão para fechamento em FF.' + #10#13 +
                                  'Baixas de "Entrega Futura" são sempre "À Vista", portanto, alterar seu cadastro deixando (Permitir FF (À Vista) = "S")!', ['&OK']);

          Result := False;
          Exit;
        end;
      End;
    End;

    Result := True;
  End
  Else
  Begin
    if not(FblnTemEntrega) and not(AblnEhDevolucao) then
      Exit(True);

    If (blnUtiWms And fVaiGerarPedidodeVenda(False)) Then
      Exit(True);

    Try
      pCriarFormularios(TfrmFatTipoFaturamento, frmFatTipoFaturamento);

      if AblnEhDevolucao then
      Begin
        frmFatTipoFaturamento.Caption              := 'Tipo de Faturamento - Devolução/Baixa';
        frmFatTipoFaturamento.Width                := 400;
        frmFatTipoFaturamento.edtTipFat.Width      := 370;
        frmFatTipoFaturamento.btnCancelaDados.Left := 312;
      End;

      frmFatTipoFaturamento.strOpcDoc := 'VN';
      frmFatTipoFaturamento.fatVenda  := fatVenda;
      frmFatTipoFaturamento.arrOpcoes := arrOpcoes;
      frmFatTipoFaturamento.showModal;

      If frmFatTipoFaturamento.blnConfirma Then
      Begin
        fatVenda.strEspDoc := arrOpcoes[frmFatTipoFaturamento.intPosAtual].strEspDoc;
        fatVenda.strTipFat := arrOpcoes[frmFatTipoFaturamento.intPosAtual].strDesCri;

        If fVerificaSeImpNFAvulsa(fatVenda.strEspDoc, teNaoPermite) Then
          Result := False
        Else
          Result := True;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[frmFatBaixaEntregaFutura.fGetTipoFaturamento]');
      End;
    End;

    pFreeAndNil(frmFatTipoFaturamento);
  End;

  if (fCfgSis('DEVEFT', varBoolean)) and (fCfgSis('ESPDEV', varBoolean)) and (AblnEhDevolucao) and (fltTotDev > 0) then
  begin
    fatVenda.objItensNotaEspelho := TItensNotaEspelho.Create(fatVenda);
    fatVenda.blnDvComDta := True;
  end;

  SetLength(arrOpcoes, 0);
End;

procedure TfrmFatBaixaEntregaFutura.pCarregarCliente(fatVenda: TFatVenda);
begin
  fatVenda.pCarregaDadosClienteBaixa(edtCodCliente.Text);
  fatVenda.strCodDig := strLoginUsuarioLogado;                  // Digitador     - Codigo
  fatVenda.strNomVen := fRetNomVendRep(fatVenda.strCodVen);     // Vendedor      - Nome
  fatVenda.strNomDig := fRetNomVendRep(fatVenda.strCodDig);     // Digitador     - Nome
  fatVenda.strCodDiv := '';
  fatVenda.strConPag := '01000';
  fatVenda.strCndFor := fFormataCondPag(fatVenda.strConPag); // Condição de pagamento formatada

  If (fCfgSis('USACND', varBoolean)) Then
  Begin
    fatVenda.strCodCnd := fCfgSis('CNDAVI', varString);                // Condicao      - Codigo
    fatVenda.strDesCnd := fRetDesConPag(fCfgSis('CNDAVI', varString)); // Condicao      - Descricao
  End;

  If (fCfgSis('USAFPG', varBoolean)) Then
  Begin
    fatVenda.strCodFpg := '001';           // Código da Forma de Pagamento
    fatVenda.strDesFpg := 'DINHEIRO';      // Descrição da Forma de Pagamento
  End;
end;

procedure TfrmFatBaixaEntregaFutura.pCarregaInformacoesComplementares(const strAutInc: String);
  Var
    LQuery : TUniQuery;
begin
  LQuery := fCriaQuery;
  Try
    LQuery.Sql.Text :=
       ' SELECT FGO_ABADEP, '+
       '        FGO_EMP_CD, '+
       '        FGO_OPRFLJ, '+
       '        FGO_CODEMP, '+
       '        DET_EMPORI  '+
       '   FROM MOVDET D    '+
       '  INNER JOIN MOVAUX A ON D.AUTOINCREM = A.DET_SEQGER '+
       '  INNER JOIN FATDOR F ON F.AUTOINCREM = A.DET_INC_PD '+
       '  INNER JOIN FATGOR G ON F.FDO_SEQGER = G.AUTOINCREM '+
       '  INNER JOIN EXTGOR E ON E.FGO_SEQFGO = G.AUTOINCREM '+
       '  INNER JOIN MOVTRI H ON D.AUTOINCREM = H.DET_SEQGER '+
       '  WHERE D.AUTOINCREM = :AUTINC '+
       ' GROUP BY FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP ';

    LQuery.ParamByName('AUTINC').AsString := strAutInc;
    LQuery.Open;
    If Not LQuery.IsEmpty Then
    Begin
      fatVenda.blnAbastecimentoDeposito := (LQuery.FieldByName('FGO_ABADEP').AsString = 'S');
      If fatVenda.blnAbastecimentoDeposito Then
      Begin
        fatVenda.strEmpresaAbastecimentoDeposito := LQuery.FieldByName('FGO_EMP_CD').AsString;
        fatVenda.strOprFlj := LQuery.FieldByName('FGO_OPRFLJ').AsString;

        If blnEscolheuFechamentoEmPedido Then
          fatVenda.strEmpOrigem := LQuery.FieldByName('DET_EMPORI').AsString;
      End;
    End;
    LQuery.Close;
  Finally
    FreeAndNil(LQuery);
  End;
end;

procedure TfrmFatBaixaEntregaFutura.pCarregarQuantidadesDevolvidas;
  var
    LQuery : TUniQuery;
begin
  LQuery := fCriaQuery;
  blnTestarPost := False;
  Try
    LQuery.Sql.Text := ' SELECT SUM(DET_QTDITE) QTDDEV '+
                       '   FROM MOVDET D,              '+
                       '         (SELECT DET_NUMDOC,   '+
                       '                 DET_ESPDOC,   '+
                       '                 DET_CODEMP,   '+
                       '                 DET_CODITE,   '+
                       '                 DET_UNITAR    '+
                       '            FROM MOVDET        '+
                       '            WHERE DET_DOCFUT = :DOCFUT '+
                       '              AND DET_ESPFUT = :ESPFUT '+
                       '              AND DET_EMPFUT = :EMPFUT '+
                       '              AND DET_CODITE = :CODITE '+
                       '              AND DET_UNITAR = :UNITAR '+
                       '            GROUP BY      '+
                       '              DET_NUMDOC, '+
                       '              DET_ESPDOC, '+
                       '              DET_CODEMP, '+
                       '              DET_CODITE, '+
                       '              DET_CODACA, '+
                       '              DET_EMPACA, '+
                       '              DET_UNITAR) A '+
                       '   WHERE D.DET_DOCDEV = A.DET_NUMDOC '+
                       '     AND D.DET_ESPDEV = A.DET_ESPDOC '+
                       '     AND D.DET_EMPDEV = A.DET_CODEMP '+
                       '     AND D.DET_CODITE = A.DET_CODITE '+
                       '     AND D.DET_UNITAR = A.DET_UNITAR ';

    cdsConsulta.DisableControls;
    cdsConsulta.First;
    while not cdsConsulta.Eof do
    Begin
      LQuery.ParamByName('DOCFUT').AsString := cdsConsulta.FieldByName('DET_NUMDOC').AsString;
      LQuery.ParamByName('ESPFUT').AsString := cdsConsulta.FieldByName('DET_ESPDOC').AsString;
      LQuery.ParamByName('EMPFUT').AsString := cdsConsulta.FieldByName('DET_CODEMP').AsString;
      LQuery.ParamByName('CODITE').AsString := cdsConsulta.FieldByName('DET_CODITE').AsString;
      LQuery.ParamByName('UNITAR').AsFloat  := cdsConsulta.FieldByName('DET_UNITAR').AsFloat;
      LQuery.Open;
      if not LQuery.IsEmpty then
      Begin
        cdsConsulta.Edit;
        cdsConsulta.FieldByName('QTDJDV').AsFloat := LQuery.FieldByName('QTDDEV').AsFloat;
        cdsConsulta.Post;
      End;
      LQuery.Close;

      cdsConsulta.Next;
    End;
    cdsConsulta.EnableControls;

  Finally
    freeAndNil(LQuery);
    blnTestarPost := True;
  End;
end;

procedure TfrmFatBaixaEntregaFutura.pInicializaTemporaria;
begin
  If cdsVenda = nil Then
    pCriarCdsVenda(Self);

  cdsVenda.EmptyDataSet;

  fatVenda.objFatVendaImp.pLimparDocumentos;

  fatVenda.strMen001 := 'REF.DOCS.: ';
  fatVenda.strMen002 := 'VENDEDOR.: ';
  fltFreRatAux := 0;

  If (fCfgSis('EFTEST') = '2') And (fCfgSis('EFTESE') = '1') Then
    pCriarCdsSomenteComSubItensEstrutura(False);

  If Assigned(fatVenda.objDadosCte) Then
  Begin
    fatVenda.objDadosCte.pLimpaDadosObjeto;
    fatVenda.objDadosCte.objPartilha.pLimpaDadosObjeto;
  End;
End;

function TfrmFatBaixaEntregaFutura.fAvaliaEstoque(pgbProgresso: TcxProgressBar): Boolean;
Begin
  Result := True;
  With cdsConsulta Do
  Begin
    pInfoStatusGravacao(pgbProgresso, 'Aguarde... Avaliando Estoque', RecordCount);

    Try
      Try
        DisableControls;

        First;
        While Not Eof Do
        Begin
          pStepStatusGravacao(pgbProgresso);

          Edit;
          Post;

          Next;
        End;
      Except
        On E: EAbort Do
          Result := False;

        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, 'frmFatBaixaEntregaFutura.fAvaliaEstoque');
        End;
      End;

    Finally
      EnableControls;
    End;
  End;
End;

Function TfrmFatBaixaEntregaFutura.fTestaEstoque: Boolean;
  Var
  objMsg : TMensagemLiberacao;
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;

Begin
  blnCancelar := FALSE;
  blnComSenha := FALSE;
  blnLiberou  := FALSE;
  Result      := FALSE;

  objMsg := TMensagemLiberacao.Create(Self);
  pCriarFormularios(TfrmFatMostraProdSemSaldo, frmFatMostraProdSemSaldo);
  try
    Try

      frmFatMostraProdSemSaldo.pAbreClientItens;

      fChamaTelaGravando(fAvaliaEstoque);

      If (Not frmFatMostraProdSemSaldo.cdsItens.IsEmpty) Then
      Begin
        frmFatMostraProdSemSaldo.ShowModal;

        objMsg.pAddTexto('Produtos Com Saldo Insuficiente!');

        objTabela := TRegistroMsgLiberaTabela.Create;

        objLinha              := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlCabecalho;
        objLinha.pAddColuna(''   ,  'Produto' , 50 , alEsquerda, teAutcom);
        objLinha.pAddColuna(''   ,  'Qtd Dig.', 10 , alEsquerda, teAutcom);
        objLinha.pAddColuna(''   ,  'Saldo'   , 10 , alEsquerda, teAutcom);
        objTabela.lstLinhas.Add(objLinha);

        With frmFatMostraProdSemSaldo.cdsItens Do
        Begin
          First;
          While Not Eof Do
          Begin
            objLinha              := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlValor;
            objLinha.pAddColuna('Produto' , FieldByName('ITE_CODITE').AsString + ' - ' + FieldByName('ITE_DESITE').AsString , 50 , alEsquerda, teAmbos);
            objLinha.pAddColuna('Qtd Dig.', FloatToStrF(FieLdByName('ITE_QTDITE').AsFloat, ffFixed, 5, 4)                   , 10 , alEsquerda, teAmbos);
            objLinha.pAddColuna('Saldo'   , FloatToStrF(FieLdByName('ITE_SALDOS').AsFloat, ffFixed, 5, 4)                   , 10 , alEsquerda, teAmbos);
            objTabela.lstLinhas.Add(objLinha);
            Next;
          End;
        End;

        objMsg.lstRegistros.Add(objTabela);

        blnLiberou := fSenhaLiberacaoSemSaldoVN(fatVenda.strCodVen, fatVenda.strCodDig,
                                                fatVenda.strNtrava, fatVenda.stlNumLib,
                                                objMsg, '', True, fatVenda.strOpcDoc,
                                                False, False, '', False, False, True);

      End

      Else blnLiberou := TRUE;

      Result := blnLiberou;

      If blnLiberou Then
      Begin
        Result := fChamaTelaGravando(fAvaliaEstoque);
        blnUtilizaIteRetSaldo := False;
      End;
      frmFatMostraProdSemSaldo.pFechaClientItens;

      blnComSenha := TRUE;
      blnLiberou  := FALSE;

    Except
      On E: Exception Do
      Begin
        blnLiberou := False;
        pMensagensErro(E.Message, '[frmFatBaixaEntregaFutura.fTestaEstoque]');
      End;
    End;
  finally
    FreeAndNil(objMsg);
    pFreeAndNil(frmFatMostraProdSemSaldo);
  end;
End;

Function TfrmFatBaixaEntregaFutura.fSelecionaEnderecoEntrega: Boolean;
  Var
    strEndEnt: String;
    blnSelEnd: Boolean;
    blnPriVez: Boolean;
Begin
  blnSelEnd := False;
  blnPriVez := True;
  strEndEnt := '';

  With cdsConsulta Do
  Begin
    DisableControls;

    First;

    While Not Eof Do
    Begin

      If (FieldByName('DET_QTDAEN').AsFloat > 0) Then
      Begin
        If blnPriVez Then
          strEndEnt := FieldByName('ENTGER').AsString;

        blnPriVez := False;

        If (Not SameText(strEndEnt, FieldByName('ENTGER').AsString)) Then
        Begin
          blnSelEnd := True;
          Break;
        End;
      End;

      Next;
    End;

    EnableControls;
  End;

  If Not (blnSelEnd Or fEmptyStr(strEndEnt)) Then
  Begin
    Result := fatVenda.objEndEnt.fLeEnderecoEntrega(edtCodCliente.Text, strEndEnt, True, True);
    If Result Then
      fatVenda.pEnderecoToFatVenda;
  End

  Else Result := False;

  If Not Result Then
  Begin
    If blnSelEnd Then
      pMensagemOk('Os documentos possuem diferentes endereços de entrega. Selecione um endereço!');

    recEndere.strIncrem := '';
    fatVenda.strAutEnt  := '';
    Result := fatVenda.fSelecionaEnderecoEntrega(True, True);
  End;

End;

function TfrmFatBaixaEntregaFutura.fPedeTelaMensagens: Boolean;
  Var
    strEstEmp: String;
    strCLAEFV: string;
    strCLAEFI: string;
    I: Integer;
    strItens: string;
    strIndRev: string;
    frmFatDigMensagemGenerica : TfrmFatDigMensagemGenerica;
    intTipFre: integer;
begin
  Result := True;

  If Result And fCfgSis('MSGEFU', varBoolean) And (Pos(fatVenda.strEspDoc, 'PD_MI_FF_') > 0) Then
  Begin

    Try
      pCriarFormularios(TfrmFatDigMensagemGenerica, frmFatDigMensagemGenerica);
      Try
        fatVenda.strCodRot := '';
        frmFatDigMensagemGenerica.fatVenda := fatVenda;
        frmFatDigMensagemGenerica.fraPlanoDeContas.mskCodCta.Visible := False;
        frmFatDigMensagemGenerica.showModal;
        Result := frmFatDigMensagemGenerica.blnConfirma;
      Finally
        pFreeAndNil(frmFatDigMensagemGenerica);
      End;
    Except
      dbgDadosItens.Enabled := TRUE;
      btnGravar.Enabled     := TRUE;
      btnEndEnt.Visible     := TRUE;
      Exit;
    End;

  End;

  If Result And fCfgSis('FISBEF', varBoolean) And (Pos(fatVenda.strEspDoc, 'NF_EL_NS_') > 0) Then
  Begin

    Try

      pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);
      try
        frmFatDadosFiscais.fatVenda := fatVenda;

        If (fCfgSis('ESPDEV', varBoolean)) And (fCfgSis('DEVEFT', varBoolean)) And (fCfgSis('FRDVES', varString) = '2') And (fltTotDev > 0) Then
        Begin
          intTipFre := fBuscaTipoFrete;
          If intTipFre In [1,3,9,4] Then
          Begin
            frmFatDadosFiscais.fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Clear;
            For intTipFre In arrSemFrete Do
              frmFatDadosFiscais.fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Items.Add(fDescricaoFrete(IntToStr(intTipFre)));
          End
          Else If intTipFre In [2,5] Then
          Begin
            frmFatDadosFiscais.fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Clear;
            For intTipFre In arrComFrete Do
              frmFatDadosFiscais.fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Items.Add(fDescricaoFrete(IntToStr(intTipFre)));
          End;

        End;

        If Not fatVenda.blnVendaPresencial Then
        Begin
          strEstEmp := fRetUFEmpresa;
          If (fatVenda.strCliEst = strEstEmp) Then
          begin
            strCLAEFV := '5'+fCfgSis('CLAEFV');
            strCLAEFI := '5'+fCfgSis('CLAEFI');
          end
          Else
          begin
            strCLAEFV := '6'+fCfgSis('CLAEFV');
            strCLAEFI := '6'+fCfgSis('CLAEFI');
          end;

          strItens := '';
          for I := 0 to Length(fatVenda.arrMatItens) - 1 do
          begin
            strItens := strItens + ',' + fatVenda.arrMatItens[I].strCodIte;
          end;

          if fEmptyStr(strItens) then
          begin
            fatVenda.strClaFis := strCLAEFV;
          end
          else
          begin
            Delete(strItens,1,1);
            strIndRev := fRetornaIndRev(strItens);

            if (not fCfgSis('CONIPI', varBoolean)) or (fEmptyStr(strIndRev)) or (strIndRev = 'R') then
            begin
              fatVenda.strClaFis := strCLAEFV;
            end
            else if (fCfgSis('CONIPI', varBoolean)) and (strIndRev = 'I') then
            begin
              fatVenda.strClaFis := strCLAEFI;
            end
            else if (fCfgSis('CONIPI', varBoolean)) and (strIndRev = 'R,I') then
            begin
              fatVenda.strClaFis := strCLAEFV;
              fatVenda.strClaFi2 := strCLAEFI;
            end;
          end;

          fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);
        End;

        frmFatDadosFiscais.Caption := frmFatDadosFiscais.Caption;
        frmFatDadosFiscais.blnPodeCancelar := True;
        frmFatDadosFiscais.ShowModal;

        Result := frmFatDadosFiscais.blnConfirma;
      finally
        pFreeAndNil(frmFatDadosFiscais);
      end;
    Except
      On E: Exception Do
      Begin
        cdsConsulta.EnableControls;
        Result := False;
        pMensagensErro(E.Message, '');
      End;
    End;
  End;

  if (Result) and (fatVenda.strEspDoc = 'NF') and (not fEmptyStr(fatVenda.strCodTra)) and (fCfgSis('UTICTE', varBoolean))
     and (fCampoTabela('TRA_CONHAB', 'CADTRA', ['TRA_CODTRA'], [fatVenda.strCodTra]) = 'S') then
  begin
    try
      Result := TfrmFatDadosCTe.Exibir(fatVenda);
    except
      On E: Exception do
      begin
        Result := False;
        pMensagensErro(E.Message, '[fPedeTelaMensagens]');
      end;
    end;
  end
  else
    fatVenda.objDadosCte.blnGrava := False;
end;

procedure TfrmFatBaixaEntregaFutura.btnGravarClick(Sender: TObject);
begin
  TfrmGravando.fExecutarModal(pConfirmarBaixaEntregaFutura,
    'Aguarde, Confirmando Baixa de Entrega Futura ...', '');
end;

function TfrmFatBaixaEntregaFutura.fAbrirTelaDeDevolucaoDeBaixaDeEntregaFutura(const blnFezDevolucaoAutomatica: Boolean): Boolean;
begin
  Result := False;

  If (blnFezDevolucaoAutomatica) Then
    Exit;

  If (Not Assigned(pAbrirDevolucaoBaixaEntregaFutura)) Then
    Exit;

  If (Not fUsaPedidoBaixaEntregaFutura) Then
    Exit;

  If (fatVenda.strEspDoc = 'PD') Then
    Exit;

  Result := fCfgSis('BFUDEV', varBoolean);
end;

procedure TfrmFatBaixaEntregaFutura.pConfirmarBaixaEntregaFutura;
  Var
    blnConfirma : Boolean;
    blnExpPed   : Boolean;
    blnPassouGravaArquivos: Boolean;
    blnProcessouDocumentoDeDevolucao : Boolean;
    LDocFat,
    LEspFat,
    LEmpFat     : String;

  procedure pEncerraBaixa;
  begin
    btnEndEnt.Visible := True;
    fatVenda.strEspDoc := '';
    pInicializaTemporaria;
  end;

  function fTravarBaixaSimultaneaTaxaJurosDiferentes: Boolean;
    Const
      strTitTaxJur = ' Tax. Jur.: ';
    Var
      cdsDados  : TUniClientDataSet;
      slLisTaxJur,
      slLisComTaxJur,
      slLisSemTaxJur : TStringList;
      strValJur,
      strNumDoc: String;
      intIdx   : Integer;
  begin
    Result := False;

    If (fCfgSis('CNDVEN') = 'I') Then
      Exit;

    If fVaiGerarPedidodeVenda Then
    Begin
      cdsDados := TUniClientDataSet.Create(Nil);
      slLisSemTaxJur := TStringList.Create;
      slLisComTaxJur := TStringList.Create;
      slLisTaxJur    := TStringList.Create;

      Try
        pCloneDataSet(cdsDados, cdsConsulta);

        cdsDados.First;
        While (Not cdsDados.Eof) Do
        Begin
          If (cdsDados.FieldByName('DET_QTDAEN').AsFloat > 0) Then
          Begin
            strValJur := FloatToStr(fFormataFloat(cdsDados.FieldByName('DET_TAXJUR').AsFloat, 2));
            strNumDoc := cdsDados.FieldByName('GER_NUMDOC').AsString+'-'+
                         cdsDados.FieldByName('GER_ESPDOC').AsString+'-'+
                         cdsDados.FieldByName('GER_CODEMP').AsString+
                         IIF(fFormataFloat(cdsDados.FieldByName('DET_TAXJUR').AsFloat, 2) > 0, strTitTaxJur + strValJur + '%', '');

            If slLisTaxJur.IndexOf(strValJur) = -1 Then
              slLisTaxJur.Add(strValJur);

            If fFormataFloat(cdsDados.FieldByName('DET_TAXJUR').AsFloat, 2) > 0 Then
            Begin
              If slLisComTaxJur.IndexOf(strNumDoc) = -1 Then
              Begin
                If slLisComTaxJur.Count = 0 Then
                  slLisComTaxJur.Add('DOCUMENTOS COM TAXA DE JUROS');
                slLisComTaxJur.Add(strNumDoc);
              End;
            End
            Else
            Begin
              If slLisSemTaxJur.IndexOf(strNumDoc) = -1 Then
              Begin
                If slLisSemTaxJur.Count = 0 Then
                  slLisSemTaxJur.Add('DOCUMENTOS SEM TAXA DE JUROS');
                slLisSemTaxJur.Add(strNumDoc);
              End;
            End;
          End;
          cdsDados.Next;
        End;

        strNumDoc := '';
        If (slLisTaxJur.Count > 1) Then
        Begin
          For intIdx:=0 To slLisComTaxJur.Count -1 Do
          Begin
            strNumDoc := strNumDoc + slLisComTaxJur[intIdx] + #10#13;
          End;

          strNumDoc := strNumDoc + #10#13;

          For intIdx:=0 To slLisSemTaxJur.Count -1 Do
          Begin
            strNumDoc := strNumDoc + slLisSemTaxJur[intIdx] + #10#13;
          End;
        End;

      Finally
        If (Not strNumDoc.IsEmpty) Then
        Begin
          fMensagem('Atenção!', 'Não é possível gerar "PEDIDO DE BAIXA DE ENTREGA FUTURA" de documentos com TAXA DE JUROS diferentes.'+
                                'Baixe os itens em conjunto com os documentos de mesma características: '+#10#13+strNumDoc, ['&Ok'], 1, False, 1, 0, False, 0, False, False, False, 200, 0, slLisSemTaxJur.Count+slLisComTaxJur.Count);
          Result := True;
        End;
        FreeAndNil(slLisComTaxJur);
        FreeAndNil(slLisSemTaxJur);
        FreeAndNil(slLisTaxJur);
        FreeAndNil(cdsDados)
      End;
    End;
  end;

  function fTravaFaturamentoComOrigemPedidosAbastecimentosDiferentes: Boolean;
    Var
      cdsDados  : TUniClientDataSet;
      LQuery : TUniQuery;
      stlLista: TStringList;
      strChave,
      strLisAutInc: String;
  begin
    Result := False;

    If fVaiGerarPedidodeVenda Then
    Begin
      cdsDados := TUniClientDataSet.Create(Nil);
      LQuery   := fCriaQuery;
      stlLista := TStringList.Create;

      Try
        pCloneDataSet(cdsDados, cdsConsulta);

        cdsDados.Filter := 'DET_QTDAEN > 0';
        cdsDados.Filtered := True;

        strLisAutInc := '';

        cdsDados.First;
        While (Not cdsDados.Eof) Do
        Begin
          pIncrementaListaStr(cdsDados.FieldByName('DET_INCREM').AsString, strLisAutInc, True, True, ',', False, False);
          cdsDados.Next;
        End;

        If (strLisAutInc <> '') Then
        Begin
          LQuery.Sql.Text :=
             ' SELECT IFNULL(FGO_ABADEP, "N") AS ABADEP, '+
             '        IFNULL(FGO_EMP_CD, " ") AS EMP_CD, '+
             '        IFNULL(FGO_OPRFLJ, "N") AS OPRFLJ, '+
             '        IFNULL(FGO_CODEMP, " ") AS CODEMP  '+
             '   FROM MOVDET D '+
             '  INNER JOIN MOVAUX A ON D.AUTOINCREM = A.DET_SEQGER '+
             '   LEFT JOIN FATDOR F ON F.AUTOINCREM = A.DET_INC_PD '+
             '   LEFT JOIN FATGOR G ON F.FDO_SEQGER = G.AUTOINCREM '+
             '   LEFT JOIN EXTGOR E ON E.FGO_SEQFGO = G.AUTOINCREM '+
             '  WHERE D.AUTOINCREM IN ('+strLisAutInc+') '+
             ' GROUP BY IFNULL(FGO_ABADEP, "N"), IFNULL(FGO_CODEMP," ") ';

          LQuery.Open;
          If (LQuery.RecordCount > 1) And (LQuery.Locate('ABADEP', 'S', [])) Then
          Begin
             LQuery.Close;
             LQuery.Sql.Text :=
                ' SELECT IF(IFNULL(FGO_ABADEP,"N") = "S", CONCAT("DOCUMENTOS DE ENTREGA FUTURA ORIGINADOS DE PEDIDOS DE ABASTECIMENTO EMP. ORI.: ", IFNULL(FGO_CODEMP," ")), "DOCUMENTOS DE ENTREGA FUTURA COMUNS") AS CHAVE, '+
                '        IFNULL(FGO_ABADEP, "N") AS ABADEP, '+
                '        IFNULL(FGO_EMP_CD, " ") AS EMP_CD, '+
                '        IFNULL(FGO_OPRFLJ, "N") AS OPRFLJ, '+
                '        IFNULL(FGO_CODEMP, " ") AS CODEMP, '+
                '        CONCAT(DET_NUMDOC, "-", DET_ESPDOC, "-", DET_CODEMP) AS NUMDOC '+
                '   FROM MOVDET D '+
                '  INNER JOIN MOVAUX A ON D.AUTOINCREM = A.DET_SEQGER '+
                '   LEFT JOIN FATDOR F ON F.AUTOINCREM = A.DET_INC_PD '+
                '   LEFT JOIN FATGOR G ON F.FDO_SEQGER = G.AUTOINCREM '+
                '   LEFT JOIN EXTGOR E ON E.FGO_SEQFGO = G.AUTOINCREM '+
                '  WHERE D.AUTOINCREM IN ('+strLisAutInc+') '+
                ' GROUP BY IFNULL(FGO_ABADEP,"N"), IFNULL(FGO_CODEMP," "), CONCAT(DET_NUMDOC, DET_ESPDOC, DET_CODEMP) '+
                ' ORDER BY IFNULL(FGO_ABADEP,"N"), IFNULL(FGO_CODEMP," "), CONCAT(DET_NUMDOC, DET_ESPDOC, DET_CODEMP) ';
             LQuery.Open;

             stlLista.Add('Não é possível efetuar a baixa de entrega futura de documentos com origens distintas:');
             stlLista.Add(' ');
             strChave := '';
             LQuery.First;
             While Not LQuery.Eof Do
             Begin
               If (strChave <> LQuery.FieldByName('CHAVE').AsString) Then
               Begin
                 stlLista.Add(LQuery.FieldByName('CHAVE').AsString);
                 strChave := LQuery.FieldByName('CHAVE').AsString;
               End;

               stlLista.Add('    '+LQuery.FieldByName('NUMDOC').AsString);

               LQuery.Next
             End;
             LQuery.Close;
          End;
        End;
      Finally
        If stlLista.Count > 0 Then
        Begin
          Result := True;
          pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
          Try
            frmMensagemExplicativa.Caption := 'Atenção';
            frmMensagemExplicativa.Width := 850;
            frmMensagemExplicativa.mmoInstru.Font.Style :=[];
            frmMensagemExplicativa.mmoInstru.Lines.Text := stlLista.Text;
            frmMensagemExplicativa.ShowModal;
          Finally
            pFreeAndNil(frmMensagemExplicativa);
          End;
        End;
        FreeAndNil(cdsDados);
        FreeAndNil(LQuery);
        FreeAndNil(stlLista);
      End;
    End;
  end;

  function fTravarBaixaSimultaneaPedidosComSemFreteRateado: Boolean;
    Var
      cdsDados  : TUniClientDataSet;
      slLisFreRat,
      slLisTotFre : TStringList;
      strNumDoc: String;
      intIdx   : Integer;
  begin
    Result := False;

    If fVaiGerarPedidodeVenda Then
    Begin
      cdsDados := TUniClientDataSet.Create(Nil);
      slLisTotFre := TStringList.Create;
      slLisFreRat := TStringList.Create;
      Try
        pCloneDataSet(cdsDados, cdsConsulta);

        cdsDados.First;
        While (Not cdsDados.Eof) Do
        Begin
          If (cdsDados.FieldByName('DET_QTDAEN').AsFloat > 0) Or (cdsDados.FieldByName('QTDDEV').AsFloat > 0) Then
          Begin
            strNumDoc := cdsDados.FieldByName('GER_NUMDOC').AsString+'-'+
                         cdsDados.FieldByName('GER_ESPDOC').AsString+'-'+
                         cdsDados.FieldByName('GER_CODEMP').AsString;

            If fFormataFloat(cdsDados.FieldByName('DET_FRERAT').AsFloat, 2) > 0 Then
            Begin
              If slLisFreRat.IndexOf(strNumDoc) = -1 Then
              Begin
                If slLisFreRat.Count = 0 Then
                  slLisFreRat.Add('DOCUMENTOS COM FRETE RATEADO');
                slLisFreRat.Add(strNumDoc);
              End;
            End
            Else If fFormataFloat(cdsDados.FieldByName('DET_TOTFRE').AsFloat, 2) > 0 Then
            Begin
              If slLisTotFre.IndexOf(strNumDoc) = -1 Then
              Begin
                If slLisTotFre.Count = 0 Then
                  slLisTotFre.Add('DOCUMENTOS COM FRETE DESTACADO');
                slLisTotFre.Add(strNumDoc);
              End;
            End;
          End;
          cdsDados.Next;
        End;

        strNumDoc := '';
        If (slLisFreRat.Count > 0) And (slLisTotFre.Count > 0) Then
        Begin
          For intIdx:=0 To slLisFreRat.Count -1 Do
          Begin
            strNumDoc := strNumDoc + slLisFreRat[intIdx] + #10#13;
          End;

          strNumDoc := strNumDoc + #10#13;

          For intIdx:=0 To slLisTotFre.Count -1 Do
          Begin
            strNumDoc := strNumDoc + slLisTotFre[intIdx] + #10#13;
          End;
        End;

      Finally
        If (Not strNumDoc.IsEmpty) Then
        Begin
          fMensagem('Atenção!', 'Não é possível gerar "PEDIDO DE BAIXA DE ENTREGA FUTURA" de documentos com FRETE RATEADO com documentos com FRETE DESTACADO.'+
                                'Baixe os itens em conjunto com os documentos de mesma características: '+#10#13+strNumDoc, ['&Ok'], 1, False, 1, 0, False, 0, False, False, False, 200, 0, slLisTotFre.Count+slLisFreRat.Count);
          Result := True;
        End;
        FreeAndNil(slLisFreRat);
        FreeAndNil(slLisTotFre);
        FreeAndNil(cdsDados)
      End;
    End;
  end;  

begin
  inherited;

  Try

    If Not btnGravar.Visible Then
      Exit;

    If Not fPermiteGravacaoImpressao Then
      Exit;

    If (Not blnAltEnd) And (Not fSelecionaEnderecoEntrega) Then
      Exit;

    if fCfgSis('BEFDCF', VarBoolean) then
      if not fValidarDocumentosBaixadosComDataDePrevisaoAnterior then
        Exit;

    If (Not fPermiteBaixa) Then
    Begin
      pEncerraBaixa;
      Exit;
    End;

    If (fTravaNotaVendaAutorizada) Then
    Begin
      pEncerraBaixa;
      Exit;
    End;

    If (Not fValidaTravaDevolucaoClienteComIES()) Then
    Begin
      pEncerraBaixa;
      Exit;
    End;

    blnProcessouDocumentoDeDevolucao := False;
    fatVenda.blnBFut49 := blnBFut49;

    If (blnBFut49) Then
      fatVenda.strOpcDocTrue := '49'
    Else
      fatVenda.strOpcDocTrue := 'BF';

    If fTravaFaturamentoItensComOrigemDiferente Then
    Begin
      pEncerraBaixa;
      Exit;
    End;

    dtaDtEntr := 0;

    pCarregarCliente(fatVenda);
    btnEndEnt.Visible := False;

    fatVenda.strAbaDep := fRetornaSeDocumentoEhAbastecimentoDeposito;

    {*******************************************}
    {* INFORMA SEPARADOR E CONFERENTE          *}
    {****************************************IV*}
    If (fCfgSis('EXSECO') = 'S') And edtCodIte.Visible Then
    Begin
      If (Not TFatSeparadorConferente.New
        .CarregaConferente(False)
        .Solicitar(fatVenda.FOpeExp, fatVenda.FSepExp)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Separador e o Conferente não estão preenchidos! Favor verificar.', ['&Ok']);
        pEncerraBaixa;
        Exit;
      End
      Else
      Begin
        fatVenda.strNomExp := fRetNomVendRep(fatVenda.strOpeExp);
        fatVenda.strNomSep := fRetNomVendRep(fatVenda.strSepExp);
      End;
    End;

    If fUsaPedidoBaixaEntregaFutura And (fCfgSis('EFTEST') <> '2') Then
    Begin

      blnExpPed := (Pos(fCfgSis('TIPEXP', varString), '3_4_5_') > 0);

      {*******************************************************************************************}
      {* SE O CLIENTE FOR BUSCAR, NÃO PERMITE GERAR PEDIDO, POIS O PEDIDO VAI PARA EXPEDIÇÃO.    *}
      {* SE NÃO UTILIZAR EXPEDIÇÃO POR PEDIDOS GERA O DOCUMENTO DE BAIXA SEM REALIZAR A PERGUNTA.*}
      {* SE UTILIZAR UTILIZAR WMS IRÁ GERAR O PEDIDO DIRETO SEM REALIZAR A PERGUNTA.             *}
      {****************************************************************************************PZ*}
      {* A T E N Ç Ã O. SE MUDAR ESTA REGRA, ALTERAR A REGRA DA FUNÇÃO fVaiGerarPedidodeVenda,   *}
      {* POIS A FUNÇÃO DEFINE SE IRÁ GERAR O PEDIDO DE VENDA QUANDO WMS PARA VALIDAR O ESTOQUE.  *}
      {****************************************************************************************PZ*}
      If (blnExpPed)     And
         (Not fExisteSomenteQuantidadeADevolver) And
         ((blnUtiWms)    Or
          (fEhDocumentoEmpresaCd(fatVenda.strEmp_CD, fatVenda.strAbaDep = 'S')) Or
          (fCfgSis('PEDBEF', varString) = 'P') Or
          (fGetMenu('Finalizar a Baixa de Entrega Futura em:',
                    ['PEDIDO DE BAIXA DE ENTREGA FUTURA',
                     'DOCUMENTO FINAL DE ENTREGA FUTURA'], 1, False, True) = 1)) Then
      Begin
        {*************************************************************}
        {* PASSA PELA FUNÇÃO fGetTipoFaturamento APENAS PARA VALIDAR *}
        {* AS PERMISSÕES E RETORNAR QUAL O TIPO DO PEDIDO            *}
        {**********************************************************PZ*}

        If (Not fGetTipoFaturamento(fatVenda)) Then
        Begin
          pEncerraBaixa;
          Exit;
        End;

        fatVenda.blnEnt_CD := False;
        if (fUsaPedidoBaixaEntregaFutura) and (fEhDocumentoEmpresaCd(fatVenda.strEmp_CD, fatVenda.strAbaDep = 'S')) then
        begin
          fatVenda.blnEnt_CD := True;
        end;

        If (fatVenda.strEspDoc = 'NF') Then
          fatVenda.strTipPed := 'A'
        Else
          fatVenda.strTipPed := 'B';

        fatVenda.strEspDoc := 'PD';
        fatVenda.strTipFat := 'Pedido';
        fatVenda.strPD_Exp := 'S';
        fatVenda.intLibera := 1;

        blnEscolheuFechamentoEmPedido := True;

        If Not ffrmData(dtaDtEntr, '', 'Data de Entrega Imediata', (VS_Date + fCfgSis('QMDPEI',varInteger)),
          (VS_Date + fCfgSis('DIAIME',varInteger)), fValidaDataEntIme) Then
        Begin
          pEncerraBaixa;
          Exit;
        End;

        If fTravarBaixaSimultaneaPedidosComSemFreteRateado Then
        Begin
          pEncerraBaixa;
          Exit;
        End;

        If fCfgSis('FATSSA', varBoolean) Then
        Begin
          fatVenda.strEmpFatSemSaldo := fRetornaEmpresaFatSemSaldo;
        End;

        If fTravarBaixaSimultaneaTaxaJurosDiferentes Then
        Begin
          pEncerraBaixa;
          Exit;
        End;

        If fTravaFaturamentoComOrigemPedidosAbastecimentosDiferentes Then
        Begin
          pEncerraBaixa;
          Exit;
        End;

        fatVenda.dtaDtEntr := Self.dtaDtEntr;
      End
      Else
      Begin
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddTexto('Finalizar a Baixa de Entrega Futura em "Documento Final de Entrega Futura"');

        objLiberacao.strDirAce := 'BXENFUDOFI';
        objLiberacao.strMsgSen := 'Finalizar a Baixa de Entrega Futura em "Documento Final de Entrega Futura"';
        objLiberacao.blnMosMen := True;
        objLiberacao.strCodOpe := fatVenda.strCodVen;
        objLiberacao.strCodDig := fatVenda.strCodDig;


        If (Not objLiberacao.fLibera) Then
        Begin
          pEncerraBaixa;
          Exit;
        End;

        If Not fGetTipoFaturamento(fatVenda) Then
        Begin
          pEncerraBaixa;
          Exit;
        End;

        If Not fDefineDataEntrega Then
        Begin
          pEncerraBaixa;
          Exit;
        End;

        fatVenda.dtaDtEntr := Self.dtaDtEntr;

        If fatVenda.strAbaDep = 'S' Then
        Begin
          fatVenda.strEmpOriPed := fRetornaEmpresaOrigemPedidoAbastecimentoDeposito;
          fatVenda.strEmpresaAbastecimentoDeposito := VS_strCodEmp;
          fatVenda.blnAbastecimentoDeposito := True;

          If (Pos(fatVenda.strEspDoc, 'NF_IF_') > 0) Then
            fatVenda.strTipPed := 'A';
        End;
      End;
    End
    Else
    Begin
      If Not fGetTipoFaturamento(fatVenda) Then
      Begin
        pEncerraBaixa;
        Exit;
      End;

      If Not fDefineDataEntrega Then
      Begin
        pEncerraBaixa;
        Exit;
      End;

      fatVenda.dtaDtEntr := Self.dtaDtEntr;
    End;

    blnConfirma := fatVenda.fSolicitaDataHoraEntradaSaidaNotaFiscal;

    {***********************************************************************
    Se na grid o usuário selecionar itens a entregar e a devolver o sistema
    deverá gerar 3 documentos. O primeiro é o documento de baixa da entrega
    futura dos itens à entregar.
    O segundo é o documento de baixa de entrega futura dos itens à devolver,
    e em seguida um terceiro que é um documento espelho desse segundo porém
    representando a devolução desse documento gerado.
    ********************************************************************GD*}
    Try
      if blnConfirma then
      Begin
        blnPassouGravaArquivos := False;
        
        //Gerando o documento da baixa da entrega futura dos itens à entregar
        blnConfirma := fProcessarDocumento(bxBaixaNormal, blnPassouGravaArquivos, False);

        if (FblnTemDevolucao) and (blnConfirma) then
        Begin
          If Not fGetTipoFaturamento(fatVenda, True) Then
          Begin
            pEncerraBaixa;
            Exit;
          End;

          FcdsValoresItensDocumentoBaixa.EmptyDataSet;

          //Gerando o documento da baixa da entrega futura dos itens à devolver
          blnConfirma := fProcessarDocumento(bxBaixaAutomatica, blnPassouGravaArquivos, True);
          if blnConfirma then
          Begin
            //Gerando o documento de devolução da baixa da entrega futura dos itens à devolver
            If (fatVenda.strEspDoc = 'NF') Then
            Begin
              Repeat
                blnConfirma := fChamaTelaGravando(fAguardaAutorizacaoNFe, 'Aguardando autorização da nota fiscal da baixa de entrega futura.');

                If blnConfirma Then
                Begin
                  blnConfirma := fProcessarDocumento(bxDevolucaoAutomatica, blnPassouGravaArquivos, False, True);
                  blnProcessouDocumentoDeDevolucao := blnConfirma;
                End
                Else
                Begin
                  fMensagem('ATENÇÃO!', 'Nota fiscal ' + fatVenda.strNumDoc + '-'
                                                       + fatVenda.strEmpDoc + '-'
                                                       + fatVenda.strEspDoc + ' ainda não foi autorizada.' + #10+#13 +
                                        'Não é possível gerar a nota fiscal dos itens devolvidos.' + #10+#13 +
                                        'Será necessário autorizar a nota de baixa de entrega futura e depois, ' +
                                        'voltar e clique no botão "Tentar novamente" para gerar a devolução.' + #10+#13 +
                                        'Se for necessário, fale com o operador responsável e verifique como a nota de ' +
                                        'baixa está no painel de notas eletrônicas.', ['&Tentar novamente']);

                End;
              Until blnConfirma;
            End
            Else
            Begin
              If (fatVenda.strEspDoc = 'FF') Then
              Begin
                fatVenda.strEspDoc := 'DV';
                fatVenda.strTipFat := 'Devolução';
              End;

              blnConfirma := fProcessarDocumento(bxDevolucaoAutomatica, blnPassouGravaArquivos, False);
              blnProcessouDocumentoDeDevolucao := blnConfirma;
            End;

          End;

          If (Not blnConfirma) And (blnPassouGravaArquivos) Then
          Begin
            LDocFat := fatVenda.strNumDoc;
            LEspFat := fatVenda.strEspDoc;
            LEmpFat := fatVenda.strEmpDoc;

            pEncerraBaixa;
            pUnLockTodosConf;
            pNotificarRoboParaReprocessarSaldos;
            pReprocessarSaldoItensPorDocumento(LDocFat, LEspFat, LEmpFat);
            pSetFocus(edtCodCliente);
            strEndSel := '';
          End;
        End;
      End;

    Finally
      If fEmptyStr(strCodCliConsulta) Then
        fatVenda.strOpcDocTrue := 'BF';
    End;

    If blnConfirma Then
    Begin
      If (Not blnEscolheuFechamentoEmPedido) Then
        pGerarDocumentoFormulacaoItens(fatVenda);

      If fAbrirTelaDeDevolucaoDeBaixaDeEntregaFutura(blnProcessouDocumentoDeDevolucao) Then
        pAbrirDevolucaoBaixaEntregaFutura(edtCodCliente.Text);

      LDocFat := fatVenda.strNumDoc;
      LEspFat := fatVenda.strEspDoc;
      LEmpFat := fatVenda.strEmpDoc;

      fatVenda.strEspDoc := '';
      pFreeCdsVenda;
      pInicializaTemporaria;
      pUnLockTodosConf;
      pNotificarRoboParaReprocessarSaldos;
      pReprocessarSaldoItensPorDocumento(LDocFat, LEspFat, LEmpFat);
      pSetFocus(edtCodCliente);
      strEndSel := '';

      If Not fEmptyStr(strAutoincMovsBaixaSimplificada) Then
        btnBaixaSimplificada.Click;
    End
    Else
    Begin
      pEncerraBaixa;
      Exit;
    End;

    btnEndEnt.Visible := True;

  Except
    On E: Exception Do
    Begin
      cdsConsulta.EnableControls;
      pMensagensErro(E.Message, '[btnGravarClick]');
      btnEndEnt.Visible := True;
      pFreeCdsVenda;
      pInicializaTemporaria;
    End;
  End;

End;

procedure TfrmFatBaixaEntregaFutura.pConstruirGrid;
begin
  if fCfgSis('BEFAMB', varBoolean) then
    dbgvDadosItens.GetColumnByFieldName('DET_COMPLE').GroupBy(0, False);

  pSumarizar('ITE_SALDOS', skSum, '#,##0.00', True, False, True);
  pSumarizar('DET_QTDITE', skSum, '#,###0.000', True, False, True);
  pSumarizar('QTDENT', skSum, '#,###0.000', True, False, True);
  pSumarizar('QTDJDV', skSum, '#,###0.000', True, False, True);
  pSumarizar('DET_QTDPEN', skSum, '#,###0.000', True, False, True);
  pSumarizar('SEP_QTDIMP', skSum, '#,###0.000', True, False, True);
  pSumarizar('PENSEP', skSum, '#,###0.000', True, False, True);
  pSumarizar('DET_QTDAEN', skSum, '#,###0.000', True, False, True);
  pSumarizar('QTDDEV', skSum, '#,###0.000', True, False, True);

  dbgvDadosItens.ViewData.Expand(True);
  dbgvDadosItens.NavigatorButtons.First.Click;
  dbgvDadosItens.ApplyBestFit();
end;

procedure TfrmFatBaixaEntregaFutura.btnImpRelatorioClick(Sender: TObject);
Var
  qryEditor : TUniQuery;
  strSQLCreate : String;
Begin
  If ((Not cdsConsulta.Active) Or (cdsConsulta.IsEmpty)) Then
  Begin
    pMensagemOk('É necessário selecionar pelo menos um cliente!');
    Exit;
  End;

  qryEditor := fCriaQuery(nil);

  strSQLCreate := '';
  strSQLCreate := strSQLCreate + 'DROP TEMPORARY TABLE IF EXISTS TMP_REL_BAIXA_FUTURA; ';
  strSQLCreate := strSQLCreate + 'CREATE TEMPORARY TABLE TMP_REL_BAIXA_FUTURA ( ';
  strSQLCreate := strSQLCreate + '    AUTINC VARCHAR(30), ';
  strSQLCreate := strSQLCreate + '    NUMDOC VARCHAR(12), ';
  strSQLCreate := strSQLCreate + '    ESPDOC VARCHAR(2), ';
  strSQLCreate := strSQLCreate + '    CODEMP VARCHAR(3), ';
  strSQLCreate := strSQLCreate + '    CODITE VARCHAR(7) ';
  strSQLCreate := strSQLCreate + ');  ';

  qryEditor.SQL.Clear;
  qryEditor.SQL.Text := strSQLCreate;
  qryEditor.ExecSQL;

  cdsConsulta.First;
  while not cdsConsulta.Eof do
  begin

    qryEditor.SQL.Clear;
    qryEditor.SQL.Add('INSERT INTO TMP_REL_BAIXA_FUTURA(');
    qryEditor.SQL.Add('  AUTINC, NUMDOC, ESPDOC, CODEMP, CODITE ');
    qryEditor.SQL.Add(')VALUES(');
    qryEditor.SQL.Add('  :AUTINC, :NUMDOC, :ESPDOC, :CODEMP, :CODITE ');
    qryEditor.SQL.Add(');');
    qryEditor.ParamByName('AUTINC').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
    qryEditor.ParamByName('NUMDOC').AsString := cdsConsulta.FieldByName('GER_NUMDOC').AsString;
    qryEditor.ParamByName('ESPDOC').AsString := cdsConsulta.FieldByName('GER_ESPDOC').AsString;
    qryEditor.ParamByName('CODEMP').AsString := cdsConsulta.FieldByName('GER_CODEMP').AsString;
    qryEditor.ParamByName('CODITE').AsString := cdsConsulta.FieldByName('DET_CODITE').AsString;

    qryEditor.ExecSQL;

    cdsConsulta.Next;

  end;

  qryEditor.Close;

  if Assigned(prcExecutaRelatorio) then
    prcExecutaRelatorio(424, 11054, [],
                        [],
                        [],
                        Sender,
                        [],
                        True);
  FreeAndNil(qryEditor);
end;

procedure TfrmFatBaixaEntregaFutura.btnImpSepClick(Sender: TObject);
  Var
    strTabDet : String;
    strAutInc : String;
    fltQtdIte : Double;
    fltQtdImp : Double;
    intContad : Integer;
    tmrHorImp : TTime;
    documento : TDadosImpressaoVenda;
    objFatImp : TFatVendaImp;

  procedure pGravaSeparacaoItem;
  begin
    With fCriaQuery, SQL Do
    Begin
      Clear;
      Add('REPLACE INTO ' + AnsiReplaceStr(strTabDet, 'MOVDET', 'SEPFUT'));
      Add('       (SEP_SEQGER, SEP_QTDITE, SEP_DTAIMP, SEP_HORIMP, SEP_QTDIMP) ');
      Add('VALUES (:SEQGER,    :QTDITE,    :DTAIMP,    :HORIMP, :QTDIMP   ) ');

      ParamByName('SEQGER').AsString := strAutInc;
      ParamByName('QTDITE').AsFloat  := fltQtdIte;
      ParamByName('QTDIMP').AsFloat  := fltQtdImp;
      ParamByName('DTAIMP').AsDate   := VS_Date;
      ParamByName('HORIMP').AsTime   := tmrHorImp;

      ExecSQL;
      Destroy;
    End;
  End;

begin
  inherited;
  objFatImp := nil;

  Try

    If Not btnImpSep.Visible Then
      Exit;

    If Not fPermiteGravacaoImpressao Then
      Exit;

    objFatImp := TFatVendaImp.Create;

    Screen.Cursor := crHourGlass;

    fStartTransaction;

    With cdsAux Do
    Begin
      pgbProgresso.Visible  := True;
      pgbProgresso.Properties.Max := RecordCount;
      lblInformacao.Visible := True;
      tmrInformacao.Enabled := True;      

      If Not Active Then
        Exit;

      First;

      strInformacao := 'AGUARDE REGISTRANDO QUANTIDADE A ENTREGAR...';
      lblInformacao.Caption := strInformacao;

      tmrHorImp := fTime();

      While Not Eof Do
      Begin
        pgbProgresso.Position := RecNo;
        Application.ProcessMessages;

        strTabDet := FieldByName('TABELA').AsString;
        strAutInc := FieldByName('AUTOINCREM').AsString;
        fltQtdIte := FieldByName('DET_QTDAEN').AsFloat;

        If (blnSepFut) And (RoundTo(FieldByName('SEP_QTDIMP').AsFloat,-4) = RoundTo(FieldByName('DET_QTDITE').AsFloat,-4)) Then
          fltQtdImp := FieldByName('SEP_QTDIMP').AsFloat
        Else
          fltQtdImp := FieldByName('SEP_QTDIMP').AsFloat + fltQtdIte;

        pGravaSeparacaoItem;

        If fltQtdIte > 0 Then
        Begin
          With documento Do
          Begin
            strCodCli := FieldByName('GER_CODCLI').AsString;
            strNumDoc := FieldByName('GER_NUMDOC').AsString;
            strEspDoc := FieldByName('GER_ESPDOC').AsString;
            strEmpDoc := FieldByName('GER_CODEMP').AsString;
            documento.dtaSepFut := VS_Date;
            documento.hraSepFut := tmrHorImp;
          End;

          documento.blnSepFut := True;

          If objFatImp.IndexOf(documento) = -1 Then
            objFatImp.Add(documento);
        End;

        Next;
      End;
    End;

    fCommit;

    strInformacao := 'AGUARDE IMPRIMINDO SEPARAÇÃO DE ENTREGA FUTURA...';
    lblInformacao.Caption := strInformacao;

    pgbProgresso.Position := 0;
    pgbProgresso.Properties.Max := objFatImp.ItemsCount;

    Application.ProcessMessages;

    For intContad := 0 To objFatImp.ItemsCount -1 Do
    Begin
      objFatImp.fImprimeSeparacao(objFatImp[intContad], '', '', False);
      pgbProgresso.Position := Succ(intContad);
      Application.ProcessMessages;
    End;

    pMensagemOk('Impressão da separação concluída com sucesso!');

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '');
    End;
  End;

  If Assigned(objFatImp) Then
    objFatImp.Destroy;

  Screen.Cursor := crDefault;
  pgbProgresso.Visible := False;
  lblInformacao.Visible := False;
  tmrInformacao.Enabled := False;
  pSetFocus(edtCodCliente);

end;

procedure TfrmFatBaixaEntregaFutura.LimpaSeparacao(ASeqGer: String);
Var
  LqryGen: TUniQuery;
Begin
  Try
    LqryGen := fCriaQuery;
    LqryGen.SQL.Add('UPDATE SEPFUT SET SEP_QTDIMP = 0 WHERE SEP_SEQGER = :SEQGER ');
    LqryGen.ParamByName('SEQGER').AsString := ASeqGer;
    LqryGen.ExecSQL;
  Finally
    FreeAndNil(LqryGen);
  End;
end;

procedure TfrmFatBaixaEntregaFutura.btnLimpaSeparacaoClick(Sender: TObject);

  function PodeLimparSeparacao: Boolean;
  var objLiberacao : ILiberacao;
  Begin
    objLiberacao := TLiberacaoFactory.fGetLiberacao;
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Liberação para desfazer separação');
    objLiberacao.strDirAce := 'LIMSEP';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  End;

begin
  If cdsConsulta.FieldByName('SEP_QTDIMP').AsFloat > 0 Then
  Begin
    If PodeLimparSeparacao Then
    Begin
      cdsConsulta.Edit;
      cdsConsulta.FieldByName('SEP_QTDIMP').AsFloat := 0;
      cdsConsulta.FieldByName('DET_QTDAEN').AsFloat := 0;
      cdsConsulta.FieldByName('PENSEP').AsFloat     := cdsConsulta.FieldByName('DET_QTDPEN').AsFloat;
      cdsConsulta.Post;

      LimpaSeparacao(cdsConsulta.FieldByName('AUTOINCREM').AsString);
    End;
  End;
end;

{procedure TfrmFatBaixaEntregaFutura.pAtualizaMovDet(cdsAux: TUniClientDataSet);
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;

    cdsAux.First;
    While Not cdsAux.Eof Do
    Begin

      If (SameText(cdsAux.FieldByName('DET_NUMLOT').AsString, 'A DEFINIR')) And
         (Not fEmptyStr(cdsAux.FieldByName('DET_NOVLOT').AsString)) Then
      Begin
        strSQL := '';
        strSQL := strSQL + 'UPDATE ';
        strSQL := strSQL + ' ' + cdsAux.FieldByName('TABELA').AsString + ' ';
        strSQL := strSQL + 'SET    ';
        strSQL := strSQL + '  DET_NUMLOT = :NUMLOT ';
        strSQL := strSQL + 'WHERE  ';
        strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

        qryGen.Close;
        qryGen.SQL.Clear;
        qryGen.SQL.Add(strSQL);
        qryGen.ParamByName('NUMLOT').AsString := cdsAux.FieldByName('DET_NOVLOT').AsString;
        qryGen.ParamByName('AUTINC').AsString := cdsAux.FieldByName('AUTOINCREM').AsString;
        qryGen.ExecSQL;
      End;

      cdsAux.Next;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'TfrmFatBaixaEntregaFutura.pAtualizaMovDet');
    End;
  End;

  FreeAndNil(qryGen);
end;}

procedure TfrmFatBaixaEntregaFutura.pLiberaGrid;
begin
  dbgDadosItens.Enabled := True;
  strCodTin             := '';
  edtCodIte.Text        := '';
  blnUsaSelEnt          := False;
  dbgDadosItens.Repaint;
end;

function TfrmFatBaixaEntregaFutura.fValidaMultiploVenda(fltQtdIte, fltMltVen: Double; DataSet: TDataSet = Nil): Boolean;
  Var
    fltValor: Double;

  function fPedeSenhaMultiploVenda: Boolean;
  begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Item ' + cdsConsulta.FieldByName('DET_CODITE').AsString   + ' - ' +
                                        LeftStr(cdsConsulta.FieldByName('DET_DESCRI').AsString,50) + ' '   +
                                        'com quantidade fora do Múltiplo de Vendas.');

    objLiberacao.strDirAce := 'SENMTP';
    objLiberacao.strSenLib := fCfgSis('SENMTP');
    objLiberacao.strMsgSen := 'Senha para liberação de venda de item com quantidade fora do múltiplo de venda';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  end;

begin
  Result := True;

  If blnJaValidou Then
    Exit;

  If (fltMltVen > 0) Then
  Begin
    {*************************************************************}
    {* (fltQtdIte < fltMltVen) ÀS VEZES NÃO COMPARA CORRETAMENTE *}
    {*REQ.163600***********************************************RP*}
    If CompareValue(fltQtdIte, fltMltVen) = LessThanValue Then
    Begin
      If (Pos(fCfgSis('MLTVEN'), '14') > 0) Then // 1-Trava / 4-Solicita Senha
      Begin
        fMensagem('','A quantidade deve ser igual ou múltiplo de: ' + FloatToStrF(fltMltVen, ffNumber, 12, 3), ['&OK']);

        If (fCfgSis('MLTVEN') = '4') Then // Solicita Senha
          Result := fPedeSenhaMultiploVenda
        Else
          Result := False;
      End
      Else If (fCfgSis('MLTVEN') = '3') Then  // Avisa
        fMensagem('','A quantidade digitada é diferente de um múltiplo de: ' + FloatToStrF(fltMltVen, ffNumber, 12, 3), ['&OK']);

      blnJaValidou := Result;

      If (Not Result) And (Assigned(DataSet)) And (DataSet.State = dsEdit) Then
      Begin
        DataSet.FieldByName('DET_QTDAEN').AsFloat := fltMltVen;
        Result := True;
      End;
    End
    Else
    Begin
      fltValor := fFormataFloat( fltQtdIte / fltMltVen, 5);

      If (fltValor - Int(fltValor)) > 0 Then
      Begin
        If (Pos(fCfgSis('MLTVEN'), '14') > 0) Then // 1-Trava / 4-Solicita Senha
        Begin
          fMensagem('','A quantidade deve ser igual ou múltiplo de: ' + FloatToStrF(fltMltVen, ffNumber, 12, 3), ['&OK']);

          If (fCfgSis('MLTVEN') = '4') Then // Solicita Senha
            Result := fPedeSenhaMultiploVenda
          Else
            Result := False;
        End
        Else If (fCfgSis('MLTVEN') = '3') Then // Avisa
          fMensagem('','A quantidade digitada é diferente de um múltiplo de: ' + FloatToStrF(fltMltVen, ffNumber, 12, 3), ['&OK']);

        If (Not Result) And (Assigned(DataSet)) And (DataSet.State = dsEdit) Then
        Begin
          fltValor := Int((fltQtdIte + fltMltVen) / fltMltVen) * fltMltVen;
          DataSet.FieldByName('DET_QTDAEN').AsFloat := fltValor;
          Result := True;
        End;

      End;

      blnJaValidou := Result;

    End;
  End;
End;

function TfrmFatBaixaEntregaFutura.fValidarDocumentosBaixadosComDataDePrevisaoAnterior: Boolean;
  var
    LblnJaTemCabecalho                 : Boolean;
    LcdsTemporario                     : TUniClientDataSet;
    LdtaMenorDataDosItensPendentes,
    LdtaMaiorDataDosItensSelecionados  : TDateTime;
    LobjLiberacao                      : TLiberacao;
    LcdsProdutos,
    LcdsDocumentos                     : TUniClientDataSet;
    LintIdx,
    LintIdy                            : Integer;
    LstrDescricaoDaRegra               : String;
    LQuery                             : TUniquery;
    LfltQuantidadeAEnviar,
    LfltQuantidadePendente             : Double;
    LstrProdutosParaFiltrar            : String;
begin
  Result := True;

  LcdsProdutos := TUniClientDataSet.Create(Self);
  LcdsProdutos.FieldDefs.Add('CODPRO', ftString, 10);
  LcdsProdutos.FieldDefs.Add('CODUNI', ftString, 10);
  LcdsProdutos.FieldDefs.Add('SALDO_', ftFloat);
  LcdsProdutos.CreateDataSet;

  LcdsDocumentos := TUniClientDataSet.Create(Self);
  LcdsDocumentos.FieldDefs.Add('DOCUME', ftString, 20);
  LcdsDocumentos.FieldDefs.Add('CODCLI', ftString, 10);
  LcdsDocumentos.FieldDefs.Add('NOMCLI', ftString, 30);
  LcdsDocumentos.FieldDefs.Add('CODVEN', ftString, 10);
  LcdsDocumentos.FieldDefs.Add('NOMVEN', ftString, 30);
  LcdsDocumentos.FieldDefs.Add('TIPENF', ftString, 6);
  LcdsDocumentos.FieldDefs.Add('QTDVEN', ftString, 20);
  LcdsDocumentos.FieldDefs.Add('QTDBAI', ftString, 20);
  LcdsDocumentos.FieldDefs.Add('QTDPEN', ftString, 20);
  LcdsDocumentos.FieldDefs.Add('DTAVEN', ftDate);
  LcdsDocumentos.FieldDefs.Add('PASFRE', ftInteger);
  LcdsDocumentos.FieldDefs.Add('REGRA_', ftInteger);
  LcdsDocumentos.CreateDataSet;

  LobjLiberacao    := TLiberacao.Create;

  LcdsTemporario := TUniClientDataSet.Create(Self);
  pCloneDataSet(LcdsTemporario, cdsConsulta);
  LcdsTemporario.DisableControls;
  With LcdsTemporario.IndexDefs.AddIndexDef Do
  Begin
    Name   := 'IDX_DATAPREVISAO';
    Fields := 'DTAFUT';
  End;
  LcdsTemporario.IndexName := 'IDX_DATAPREVISAO';

  LblnJaTemCabecalho := False;

  LQuery := fCriaQuery;
  Try
    LQuery.Sql.Text := ' SELECT IFNULL(ITE_SALDOS, 0) + (IFNULL(ITE_QTEF_A, 0) + IFNULL(ITE_QTEF_P, 0) + IFNULL(ITE_QTPDBF, 0)) - '+
                       '        (IFNULL(ITE_QTPD_V, 0) + IFNULL(ITE_QTPD_F, 0) + IFNULL(ITE_QTPD_P, 0) + IFNULL(ITE_SDPDBF, 0) +  '+
                       '         IFNULL(ITE_QTPD_E, 0) + IFNULL(ITE_SALREG, 0)) SALDO_ '+
                       '   FROM ITEGER '+
                       '  WHERE ITE_CODITE = :CODITE '+
                       '    AND ITE_CODEMP = :CODEMP ';

    LstrProdutosParaFiltrar := '';
    LcdsTemporario.First;
    While Not LcdsTemporario.Eof Do
    Begin
      If not LcdsProdutos.Locate('CODPRO;CODUNI', VarArrayOf([LcdsTemporario.FieldByName('DET_CODITE').AsString,
                                                              LcdsTemporario.FieldByName('DET_UNIDAD').AsString]), []) Then
      Begin
        LcdsProdutos.Append;
        LcdsProdutos.FieldByName('CODPRO').AsString := LcdsTemporario.FieldByName('DET_CODITE').AsString;
        LcdsProdutos.FieldByName('CODUNI').AsString := LcdsTemporario.FieldByName('DET_UNIDAD').AsString;

        LQuery.ParamByName('CODITE').AsString := LcdsTemporario.FieldByName('DET_CODITE').AsString;
        LQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
        LQuery.Open;
        LcdsProdutos.FieldByName('SALDO_').AsFloat  := LQuery.FieldByName('SALDO_').AsFloat;
        LQuery.Close;

        LstrProdutosParaFiltrar := LstrProdutosParaFiltrar + IIF(fEmptyStr(LstrProdutosParaFiltrar),
                                                             QuotedStr(LcdsTemporario.FieldByName('DET_CODITE').AsString),
                                                             ', '+QuotedStr(LcdsTemporario.FieldByName('DET_CODITE').AsString));
      End;
      LcdsTemporario.Next;
    End;

    LQuery.Sql.Clear;
    LQuery.SQL.Add('SELECT G.GER_CODCLI, G.GER_CODVEN, D.DET_CODITE, D.DET_QTDITE, D.DET_UNIDAD, D.DET_MOTFUT, 0.0000 AS DET_QTDAEN, '+
                   '       G.GER_NUMDOC, G.GER_ESPDOC, G.GER_CODEMP, G.GER_DTAENT, '+
                   '      (D.DET_QTDITE - ' + fSQLQtdEnt + ') AS DET_QTDPEN '+
                   '  FROM MOVDET D '+
                   ' INNER JOIN MOVGER G ON G.AUTOINCREM = D.DET_SEQGER ');

    If fUsaPedidoBaixaEntregaFutura Then
      LQuery.SQL.Add(TSqlEF.SQLJoinEFPedido('D', True {Esta na baixa de entrega Futura}));

    LQuery.SQL.Add(' WHERE D.DET_ESPDOC NOT IN ("ML", "PR", "TM", "TR", "BR", "PI", "EP") '+
                   '   AND G.GER_ENTFUT = "S" '+
                   '   AND G.GER_CODEMP = ' + QuotedStr(VS_strCodEmp)+
                   '   AND G.GER_CODCLI <> ' + QuotedStr(edtCodCliente.Text)+
                   '   AND D.DET_CODITE IN ('+LstrProdutosParaFiltrar+') '+
                   '   AND ROUND(D.DET_QTDITE - ' + fSQLQtdEnt + ', 4) > 0 '+
                   '  GROUP BY D.AUTOINCREM ');

    LQuery.Open;
    while not LQuery.Eof do
    begin
      LcdsTemporario.Append;
      LcdsTemporario.FieldByname('DET_CODITE').AsString   := LQuery.FieldByName('DET_CODITE').AsString;
      LcdsTemporario.FieldByname('DET_QTDITE').AsFloat    := LQuery.FieldByName('DET_QTDITE').AsFloat;
      LcdsTemporario.FieldByname('DET_UNIDAD').AsString   := LQuery.FieldByName('DET_UNIDAD').AsString;
      LcdsTemporario.FieldByname('DET_MOTFUT').AsString   := LQuery.FieldByName('DET_MOTFUT').AsString;
      LcdsTemporario.FieldByname('DET_QTDAEN').AsFloat    := LQuery.FieldByName('DET_QTDAEN').AsFloat;
      LcdsTemporario.FieldByname('DET_QTDPEN').AsFloat    := LQuery.FieldByName('DET_QTDPEN').AsFloat;
      LcdsTemporario.FieldByname('GER_NUMDOC').AsString   := LQuery.FieldByName('GER_NUMDOC').AsString;
      LcdsTemporario.FieldByname('GER_ESPDOC').AsString   := LQuery.FieldByName('GER_ESPDOC').AsString;
      LcdsTemporario.FieldByname('GER_CODEMP').AsString   := LQuery.FieldByName('GER_CODEMP').AsString;
      LcdsTemporario.FieldByname('GER_DTAENT').AsDateTime := LQuery.FieldByName('GER_DTAENT').AsDateTime;
      LcdsTemporario.FieldByname('GER_CODCLI').AsString   := LQuery.FieldByName('GER_CODCLI').AsString;
      LcdsTemporario.FieldByname('GER_CODVEN').AsString   := LQuery.FieldByName('GER_CODVEN').AsString;
      LcdsTemporario.Post;

      LQuery.Next;
    end;

    LQuery.Close;
  Finally
    FreeAndNil(LQuery);
  End;

  try
    LcdsProdutos.First;
    while not LcdsProdutos.Eof do
    Begin
      LdtaMenorDataDosItensPendentes    := strToDate('31/12/9999');
      LdtaMaiorDataDosItensSelecionados := 0;

      LfltQuantidadeAEnviar  := 0;
      LfltQuantidadePendente := 0;

      LcdsDocumentos.Filtered := False;
      LcdsDocumentos.Filter   := EmptyStr;
      LcdsDocumentos.EmptyDataSet;

      LcdsTemporario.Filter := ' DET_CODITE = '+QuotedStr(LcdsProdutos.FieldByName('CODPRO').AsString)+' AND '+
                               ' DET_UNIDAD = '+QuotedStr(LcdsProdutos.FieldByName('CODUNI').AsString)+' AND '+
                               ' DET_MOTFUT IN (''A'',''P'') AND DET_QTDAEN = 0 ';
      LcdsTemporario.Filtered := True;
      LcdsTemporario.First;
      if not LcdsTemporario.IsEmpty then
      Begin
        LcdsTemporario.First;
        while not LcdsTemporario.Eof do
        Begin
          if LcdsTemporario.FieldByName('GER_DTAENT').AsDateTime < LdtaMenorDataDosItensPendentes  then
            LdtaMenorDataDosItensPendentes := LcdsTemporario.FieldByName('GER_DTAENT').AsDateTime;
          LcdsTemporario.Next;
        End;

        {********REGRA 1: entrega futura por falta de produto com entregas futuras do tipo aguardando (previsão ou cliente) em aberto*********}
        LcdsTemporario.Filtered := False;
        LcdsTemporario.Filter   := EmptyStr;
        LcdsTemporario.Filter   := ' DET_CODITE = '+QuotedStr(LcdsProdutos.FieldByName('CODPRO').AsString)+' AND '+
                                   ' DET_UNIDAD = '+QuotedStr(LcdsProdutos.FieldByName('CODUNI').AsString)+' AND '+
                                   ' DET_MOTFUT = ''F'' AND DET_QTDAEN > 0 ';
        LcdsTemporario.Filtered := True;
        LcdsTemporario.First;
        if not LcdsTemporario.IsEmpty then
        Begin
          LcdsTemporario.First;
          while not LcdsTemporario.Eof do
          Begin
            pPreencheClientParaValidacaoDocumentosBaixadosComDataDePrevisaoAnterior(True, 1, LcdsTemporario, LcdsDocumentos);
            LcdsTemporario.Next;
          End;

          LcdsTemporario.Filtered := False;
          LcdsTemporario.Filter   := EmptyStr;
          LcdsTemporario.Filter := ' DET_CODITE = '+QuotedStr(LcdsProdutos.FieldByName('CODPRO').AsString)+' AND '+
                                   ' DET_UNIDAD = '+QuotedStr(LcdsProdutos.FieldByName('CODUNI').AsString)+' AND '+
                                   ' DET_MOTFUT IN (''A'',''P'') AND DET_QTDAEN = 0 ';
          LcdsTemporario.Filtered := True;
          LcdsTemporario.First;
          if not LcdsTemporario.IsEmpty then
          Begin
            LcdsTemporario.First;
            while not LcdsTemporario.Eof do
            Begin
              pPreencheClientParaValidacaoDocumentosBaixadosComDataDePrevisaoAnterior(False, 1, LcdsTemporario, LcdsDocumentos);
              LcdsTemporario.Next;
            End;
          End;
        End;
        LcdsTemporario.Filtered := False;
        LcdsTemporario.Filter   := EmptyStr;
        {********FIM REGRA 1*********}

        {********REGRA 2: entrega futura do tipo aguardando (previsão ou cliente) em aberto com data de previsão anterior ao(s) documento(s) selecionado(s)*********}
        LcdsTemporario.Filter := ' DET_CODITE = '+QuotedStr(LcdsProdutos.FieldByName('CODPRO').AsString)+' AND '+
                                 ' DET_UNIDAD = '+QuotedStr(LcdsProdutos.FieldByName('CODUNI').AsString)+' AND '+
                                 ' DET_MOTFUT IN (''A'',''P'') AND DET_QTDAEN > 0 ';
        LcdsTemporario.Filtered := True;
        LcdsTemporario.First;
        if not LcdsTemporario.IsEmpty then
        Begin
          LcdsTemporario.First;
          while not LcdsTemporario.Eof do
          Begin
            if LcdsTemporario.FieldByName('GER_DTAENT').AsDateTime > LdtaMenorDataDosItensPendentes  then
              LfltQuantidadeAEnviar := LfltQuantidadeAEnviar + LcdsTemporario.FieldByName('DET_QTDAEN').AsFloat;

            if LcdsTemporario.FieldByName('GER_DTAENT').AsDateTime > LdtaMaiorDataDosItensSelecionados then
              LdtaMaiorDataDosItensSelecionados := LcdsTemporario.FieldByName('GER_DTAENT').AsDateTime;

            LcdsTemporario.Next;
          End;

          LcdsTemporario.Filtered := False;
          LcdsTemporario.Filter   := EmptyStr;
          LcdsTemporario.Filter := ' DET_CODITE = '+QuotedStr(LcdsProdutos.FieldByName('CODPRO').AsString)+' AND '+
                                   ' DET_UNIDAD = '+QuotedStr(LcdsProdutos.FieldByName('CODUNI').AsString)+' AND '+
                                   ' DET_MOTFUT IN (''A'',''P'') AND DET_QTDAEN = 0 ';
          LcdsTemporario.Filtered := True;
          LcdsTemporario.First;
          if not LcdsTemporario.IsEmpty then
          Begin
            LcdsTemporario.First;
            while not LcdsTemporario.Eof do
            Begin
              if LcdsTemporario.FieldByName('GER_DTAENT').AsDateTime < LdtaMaiorDataDosItensSelecionados then
                LfltQuantidadePendente := LfltQuantidadePendente + LcdsTemporario.FieldByName('DET_QTDPEN').AsFloat;

              LcdsTemporario.Next;
            End;
          End;

          if LfltQuantidadeAEnviar + LfltQuantidadePendente > LcdsProdutos.FieldByName('SALDO_').AsFloat then
          Begin
            LcdsTemporario.Filtered := False;
            LcdsTemporario.Filter   := EmptyStr;
            LcdsTemporario.Filter := ' DET_CODITE = '+QuotedStr(LcdsProdutos.FieldByName('CODPRO').AsString)+' AND '+
                                     ' DET_UNIDAD = '+QuotedStr(LcdsProdutos.FieldByName('CODUNI').AsString)+' AND '+
                                     ' DET_MOTFUT IN (''A'',''P'') AND DET_QTDAEN > 0 ';
            LcdsTemporario.Filtered := True;
            LcdsTemporario.First;
            while not LcdsTemporario.Eof do
            Begin
              if LcdsTemporario.FieldByName('GER_DTAENT').AsDateTime > LdtaMenorDataDosItensPendentes  then
                pPreencheClientParaValidacaoDocumentosBaixadosComDataDePrevisaoAnterior(True, 2, LcdsTemporario, LcdsDocumentos);

              LcdsTemporario.Next;
            End;

            LcdsTemporario.Filtered := False;
            LcdsTemporario.Filter   := EmptyStr;
            LcdsTemporario.Filter := ' DET_CODITE = '+QuotedStr(LcdsProdutos.FieldByName('CODPRO').AsString)+' AND '+
                                     ' DET_UNIDAD = '+QuotedStr(LcdsProdutos.FieldByName('CODUNI').AsString)+' AND '+
                                     ' DET_MOTFUT IN (''A'',''P'') AND DET_QTDAEN = 0 ';
            LcdsTemporario.Filtered := True;
            LcdsTemporario.First;
            if not LcdsTemporario.IsEmpty then
            Begin
              LcdsTemporario.First;
              while not LcdsTemporario.Eof do
              Begin
                if LcdsTemporario.FieldByName('GER_DTAENT').AsDateTime < LdtaMaiorDataDosItensSelecionados then
                  pPreencheClientParaValidacaoDocumentosBaixadosComDataDePrevisaoAnterior(False, 2, LcdsTemporario, LcdsDocumentos);

                LcdsTemporario.Next;
              End;
            End;
          End;

        End;
        LcdsTemporario.Filtered := False;
        LcdsTemporario.Filter   := EmptyStr;
        {********FIM REGRA 2*********}
      End;

      if LcdsDocumentos.Recordcount = 0 then
      Begin
        LcdsProdutos.Next;
        Continue;
      End;

      if not LblnJaTemCabecalho then
      Begin
        LobjLiberacao.strDirAce  := 'PERBFPASFRE';
        LobjLiberacao.strMsgSen  := 'Permitir baixa de entrega futura passsando na frente de outros documentos com data de entrega mais antiga';
        LobjLiberacao.strCodOpe  := strLoginUsuarioLogado;
        LobjLiberacao.objMsgLibera.pAddTexto('BAIXA DE ENTREGA FUTURA PASSANDO NA FRENTE DE OUTROS DOCUMENTOS ', alEsquerda);
        LobjLiberacao.objMsgLibera.pAddTexto('-------------------------------------------------------------------------------------------------', alEsquerda);
        LobjLiberacao.objMsgLibera.pAddTexto('', alEsquerda);
        LobjLiberacao.objMsgLibera.pAddTextoCaption('Cliente  ',edtCodCliente.Text+'-'+edtDesCliente.Text, 14);
        LobjLiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ ',fFormataCpfCgc(fRetCgcCpf(edtCodCliente.Text), fSetaPais), 14);

        LblnJaTemCabecalho := True;
      End;

      LobjLiberacao.objMsgLibera.pAddTexto('', alEsquerda);
      LobjLiberacao.objMsgLibera.pAddTexto('---------------------------------------------------------------------------------------------------', alEsquerda);
      LobjLiberacao.objMsgLibera.pAddTextoCaption('Produto  ',LcdsProdutos.FieldByName('CODPRO').AsString+' - '+
      fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [LcdsProdutos.FieldByName('CODPRO').AsString])+' - '+
      fRetNomUnidade(LcdsProdutos.FieldByName('CODUNI').AsString), 15);
      LobjLiberacao.objMsgLibera.pAddTextoCaption('Saldo Apurado  ',FormatFloat('#,##0.00', LcdsProdutos.FieldByName('SALDO_').AsFloat), 15);
      LobjLiberacao.objMsgLibera.pAddTexto('---------------------------------------------------------------------------------------------------', alEsquerda);

      for LintIdx := 1 to 2 do
      Begin
        if LintIdx = 1 then
          LstrDescricaoDaRegra := 'de ter ent.futura falta de produto com ent.futuras do tipo aguardando (previsão ou cliente) pendente'
        else
          LstrDescricaoDaRegra := 'de ter ent.futura aguardando (previsão ou cliente) pendente com data de previsão anterior';

        LcdsDocumentos.Filtered := False;
        LcdsDocumentos.Filter   := EmptyStr;
        LcdsDocumentos.Filter := ' REGRA_ = '+IntToStr(LintIdx);
        LcdsDocumentos.Filtered := True;
        LcdsDocumentos.First;

        if LcdsDocumentos.Recordcount = 0 then
          Continue;

        for LintIdy := 0 to 1 do
        Begin
          LobjLiberacao.objMsgLibera.pAddTexto('', alEsquerda);
          LobjLiberacao.objMsgLibera.pAddTexto(IIF(LintIdy = 0,
                                              'Doc. passando na frente pela regra '+LstrDescricaoDaRegra,
                                              'Doc. ficando para trás pela regra '+LstrDescricaoDaRegra), alEsquerda);

          LobjLiberacao.objMsgLibera.pAddTexto('----------------------------------------------------------------------------------------------------------------------------------------------', alEsquerda);
          if LintIdy = 0 then
            LobjLiberacao.objMsgLibera.pAddTexto('DOC.VENDA           | TIPO |             CLIENTE              |            VENDEDOR              | QTD.VENDIDA |  QTD.BAIXANDO  | DT.VENDA. |', alEsquerda)
          else
            LobjLiberacao.objMsgLibera.pAddTexto('DOC.VENDA           | TIPO |             CLIENTE              |            VENDEDOR              | QTD.VENDIDA |  QTD.PENDENTE  | DT.VENDA. |', alEsquerda);
          LobjLiberacao.objMsgLibera.pAddTexto('----------------------------------------------------------------------------------------------------------------------------------------------', alEsquerda);

          LcdsDocumentos.First;
          while not LcdsDocumentos.Eof do
          Begin
            if (LcdsDocumentos.FieldByName('PASFRE').AsInteger = LintIdy) then
            Begin
              LobjLiberacao.objMsgLibera.pAddTexto(fPadR(LcdsDocumentos.FieldByName('DOCUME').AsString,20)+'|'+
                                                   fPadR(LcdsDocumentos.FieldByName('TIPENF').AsString, 6)+'|'+
                                                   fPadR(LcdsDocumentos.FieldByName('CODCLI').AsString+'-'+
                                                         LcdsDocumentos.FieldByName('NOMCLI').AsString, 34)+'|'+
                                                   fPadR(LcdsDocumentos.FieldByName('CODVEN').AsString+'-'+
                                                         LcdsDocumentos.FieldByName('NOMVEN').AsString, 34)+'|'+
                                                   fPadR(LcdsDocumentos.FieldByName('QTDVEN').AsString,13)+'|'+
                                                   fPadR(IIF(LintIdy = 0,
                                                             LcdsDocumentos.FieldByName('QTDBAI').AsString,
                                                             LcdsDocumentos.FieldByName('QTDPEN').AsString),16)+'|'+
                                                   fPadR(LcdsDocumentos.FieldByName('DTAVEN').AsString,11)+'|', alEsquerda);
            End;

            LcdsDocumentos.Next;
          End;
        End;

      End;

      LcdsProdutos.next;
    End;

    if LblnJaTemCabecalho then
      Result := LobjLiberacao.fLibera;

  finally
    FreeAndNil(LcdsTemporario);
    FreeAndNil(LcdsProdutos);
    FreeAndNil(LcdsDocumentos);
  end;
end;

function TfrmFatBaixaEntregaFutura.fValidaRequisitoCompra(strNumDoc, strEspDoc,
  strCodEmp, strCodIte: String): Boolean;
var
  qryCompra: TUniQuery;
  strChave: String;
begin
  Result := True;

  if not fCfgSis('ITPRCV', varBoolean) then
    Exit;

  strChave := Concat(strNumDoc,';',strEspDoc,';',strCodEmp,';',strCodIte);

  if stlProdReqCompraLiberado.IndexOf(strChave) > -1 then
    Exit;

  qryCompra := fCriaQuery;

  try
    qryCompra.Close;
    qryCompra.SQL.Clear;
    qryCompra.SQL.Add('SELECT DISTINCT D.DET_NUM_PD, D.DET_ESP_PD, D.DET_EMP_PD, D.DET_CODCLI, M.RCD_QTDITE, M.RCD_CODIGO');
    qryCompra.SQL.Add('FROM MOVDET D');
    qryCompra.SQL.Add('INNER JOIN MOVRCD M');
    qryCompra.SQL.Add('ON(D.DET_NUM_PD = M.RCD_DOCPDV AND');
    qryCompra.SQL.Add('   D.DET_ESP_PD = M.RCD_ESPPDV AND');
    qryCompra.SQL.Add('   D.DET_EMP_PD = M.RCD_EMPPDV AND');
    qryCompra.SQL.Add('   D.DET_CODITE = M.RCD_CODITE)');
    qryCompra.SQL.Add('WHERE D.DET_NUMDOC = :NUMDOC');
    qryCompra.SQL.Add('AND D.DET_ESPDOC = :ESPDOC');
    qryCompra.SQL.Add('AND D.DET_CODEMP = :CODEMP');
    qryCompra.SQL.Add('AND D.DET_CODITE = :CODITE');

    qryCompra.ParamByName('NUMDOC').AsString := strNumDoc;
    qryCompra.ParamByName('ESPDOC').AsString := strEspDoc;
    qryCompra.ParamByName('CODEMP').AsString := strCodEmp;
    qryCompra.ParamByName('CODITE').AsString := strCodIte;

    qryCompra.Open;

    if qryCompra.IsEmpty then
      Exit;

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('ENTREGA FUTURA - BAIXA/DEVOLUÇÃO DE ITEM COM REQUISIÇÃO VINCULADA');
    objLiberacao.objMsgLibera.pAddSeparador(70);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'    , Concat(qryCompra.FieldByName('DET_CODCLI').AsString,'-',fRetNomCliente(qryCompra.FieldByName('DET_CODCLI').AsString))                                 , 12);
    objLiberacao.objMsgLibera.pAddTextoCaption('Requisição' , qryCompra.FieldByName('RCD_CODIGO').AsString                                                                                                          , 12);
    objLiberacao.objMsgLibera.pAddTextoCaption('Documento'  , Concat(strNumDoc,'-',strEspDoc,'-',strCodEmp)                                                                                                         , 12);
    objLiberacao.objMsgLibera.pAddTextoCaption('Pedido'     , Concat(qryCompra.FieldByName('DET_NUM_PD').AsString,'-',qryCompra.FieldByName('DET_ESP_PD').AsString,'-',qryCompra.FieldByName('DET_EMP_PD').AsString), 12);
    objLiberacao.objMsgLibera.pAddTextoCaption('Item'       , Concat(strCodIte,'-',fRetNomProduto(strCodIte))                                                                                                       , 12);
    objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade' , FloatToStrF(qryCompra.FieldByName('RCD_QTDITE').AsFloat, ffFixed, 12, fCfgSis('DECQTD', varInteger))                                                  , 12);
    objLiberacao.objMsgLibera.pAddSeparador(70);

    objLiberacao.strDirAce := 'ITPRCV';
    objLiberacao.strMsgSen := 'ENTREGA FUTURA - BAIXA/DEVOLUÇÃO DE ITEM COM REQUISIÇÃO VINCULADA';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    if objLiberacao.fLibera then
    begin
      Result := True;
      stlProdReqCompraLiberado.Add(strChave);
    end;
  finally
    FreeAndNil(qryCompra);
  end;
end;

function TfrmFatBaixaEntregaFutura.fLimpaPrevisaoEntFut: Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  Try
    Result := True;
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + ' ' + cdsConsulta.FieldByName('TABELA').AsString + ' ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  DET_QTDEFT = NULL, ';
    strSQL := strSQL + '  DET_DTAEFT = NULL  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

    cdsConsulta.First;
    While Not cdsConsulta.Eof Do
    Begin

      If cdsConsulta.FieldByName('DET_QTDAEN').AsFloat > 0 Then
      Begin
        qryGen.Close;
        qryGen.SQL.Clear;
        qryGen.SQL.Add(strSQL);
        qryGen.ParamByName('AUTINC').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
        qryGen.ExecSQL;
      End;

      cdsConsulta.Next;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'fLimpaPrevisaoEntFut');
    End;
  End;

  FreeAndNil(qryGen);
End;

procedure TfrmFatBaixaEntregaFutura.cdsConsultaAfterCancel(DataSet: TDataSet);
begin
  inherited;
  blnCancelou := True;
end;

procedure TfrmFatBaixaEntregaFutura.cdsConsultaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TfrmGravando.fExecutarModal(pAcertaSaldoDisponivel,
    'Aguarde, calculando saldo disponível...', '');
end;

procedure TfrmFatBaixaEntregaFutura.cdsConsultaAfterPost(
  DataSet: TDataSet);
begin
  inherited;
  cdsAux.Data := cdsConsulta.Data;
  cdsControle.Data := cdsConsulta.Data;
  blnJaValidou := False;

  {ALTERANDO CHECAGEM , POIS GERAVA LOOP INFINITO AO MARCAR TODOS}
  If (not blnValidandoAfterPost) And (cdsConsulta.FieldByName('DET_QTDAEN').AsFloat > 0) Then
  Begin
    if (fUsaPedidoBaixaEntregaFutura) and ((not fVerificaDocumentoAbastecimentoPeloDeposito) or (not fVerificaDocumentosEmpresaCdELogada)) then
    begin
      blnValidandoAfterPost := True;
      cdsConsulta.Edit;
      cdsConsulta.FieldByName('DET_QTDAEN').AsFloat := 0;
      cdsConsulta.Post;
      blnValidandoAfterPost := False;
    end
    else if fTravaDocumentosComProducaoForaDeLoja then
    begin
      blnValidandoAfterPost := True;
      cdsConsulta.Edit;
      cdsConsulta.FieldByName('DET_QTDAEN').AsFloat := 0;
      cdsConsulta.Post;
      blnValidandoAfterPost := False;
    end;
  end;

  pAtualizaEndSel;
  pCalcularTotais;
end;

procedure TfrmFatBaixaEntregaFutura.pAtualizaEndSel;
Begin

  With cdsAux Do
  Begin
    If Not Active Then
      Exit;

    Filter := 'DET_QTDAEN > 0';
    Filtered := True;

    If IsEmpty Then
    Begin
      strEndSel := '';
    End;

    Filtered := False;
  End;
End;

procedure TfrmFatBaixaEntregaFutura.pAtualizarQuantidadeSubItens(strAutInc: String; fltQtdVen, fltQtdEnt, AfltQuantidadeADevolver: Double);
begin
  cdsSubProdutos.Filtered := False;
  cdsSubProdutos.Filter   := 'DET_INCFUT = ' + QuotedStr(cdsConsulta.FieldByName('AUTOINCREM').AsString);
  cdsSubProdutos.Filtered := True;

  cdsSubProdutos.First;
  While Not cdsSubProdutos.Eof Do
  Begin
    cdsSubProdutos.Edit;
    { Calcula a quantidade dos sub-produtos proporcional a
      quantidade do item estrutura sendo baixado }
    cdsSubProdutos.FieldByName('DET_QTDAEN').AsFloat := cdsSubProdutos.FieldByName('DET_QTDITE').AsFloat *
      ((fltQtdEnt + AfltQuantidadeADevolver) / fltQtdVen);
    cdsSubProdutos.Post;
    cdsSubProdutos.Next;
  End;
end;

procedure TfrmFatBaixaEntregaFutura.btnEndEntClick(Sender: TObject);
begin
  inherited;

  If Not btnEndEnt.Visible Then
    Exit;

  If ((Not cdsConsulta.Active) Or (cdsConsulta.IsEmpty)) Then
  Begin
    pMensagemOk('É necessário selecionar pelo menos um registro!');
    Exit;
  End;

  If ffrmSenha(strSenha) And
     fVerificaAcessoSistema('ENENC', fRetCodVendedor(strSenha)) Then
    pAlteraEnderecoEntregaParaBaixa;

end;

procedure TfrmFatBaixaEntregaFutura.btnEndEntDocClick(Sender: TObject);
begin
  inherited;

  If Not btnEndEntDoc.Visible Then
    Exit;

  If ((Not cdsConsulta.Active) Or (cdsConsulta.IsEmpty)) Then
  Begin
    pMensagemOk('É necessário selecionar pelo menos um registro!');
    Exit;
  End;

  If ffrmSenha(strSenha) And
     fVerificaAcessoSistema('ENDOC', fRetCodVendedor(strSenha)) Then
    pAlteraEnderecoEntregaDocumento;

end;

procedure TfrmFatBaixaEntregaFutura.btnEstLojClick(Sender: TObject);
var
  frmFatMostraEstoqueEmp : TfrmFatMostraEstoqueEmp;
begin
  inherited;
  if (not fVerificaAcessoSistema('PVISPF')) then
    Exit;

  if (not cdsConsulta.Active) then
    Exit;

  if (cdsConsulta.RecNo <= 0) then
  begin
    fMensagem('ATENÇÃO!', 'Selecione um produto no grid para verificar seu estoque.', ['&Ok']);
    Exit;
  end;

  pCriarFormularios(TfrmFatMostraEstoqueEmp, frmFatMostraEstoqueEmp);

  try
    try
      frmFatMostraEstoqueEmp.strCodIte    := cdsConsulta.FieldByName('DET_CODITE').AsString;
      frmFatMostraEstoqueEmp.fltQtdIte    := 0;
      frmFatMostraEstoqueEmp.strTabPre    := '';
      frmFatMostraEstoqueEmp.blnPedCorte  := False;
      frmFatMostraEstoqueEmp.edtItem.Text := cdsConsulta.FieldByName('DET_CODITE').AsString + ' - ' + fRetNomProduto(cdsConsulta.FieldByName('DET_CODITE').AsString);
      frmFatMostraEstoqueEmp.pnlSelecEmpresa.Visible := False;
      frmFatMostraEstoqueEmp.ShowModal;
    except
      On E: Exception Do
        pMensagensErro(E.Message, '[pMostraEstoqueLojas]');
    end;
  finally
    pFreeAndNil(frmFatMostraEstoqueEmp);
  end;
end;

procedure TfrmFatBaixaEntregaFutura.btnFreteClick(Sender: TObject);
var
  frmFatAltValorFreteSuges: TfrmFatAltValorFreteSuges;
begin
  inherited;

  if not btnFrete.Visible then
    Exit;

  if not btnFrete.Enabled then
    exit;

  if not cdsConsulta.Active then
    Exit;

  if cdsConsulta.RecordCount <= 0 then
    Exit;

  if cdsConsulta.RecNo <= 0 then
    Exit;

  pCriarFormularios(TfrmFatAltValorFreteSuges, frmFatAltValorFreteSuges);
  Try
    frmFatAltValorFreteSuges.strNumDoc := cdsConsulta.FieldByName('GER_NUMDOC').AsString;
    frmFatAltValorFreteSuges.strEspDoc := cdsConsulta.FieldByName('GER_ESPDOC').AsString;
    frmFatAltValorFreteSuges.strCodEmp := cdsConsulta.FieldByName('GER_CODEMP').AsString;
    frmFatAltValorFreteSuges.blnInformaFreteNaFreCot := fCfgSis('TRACOT', varBoolean);
    frmFatAltValorFreteSuges.tpOrigemAlteracaoFrete := oafBaixaEntregaFutura;
    frmFatAltValorFreteSuges.objLock := objLock;
    frmFatAltValorFreteSuges.ShowModal;
  Finally
    pFreeAndNil(frmFatAltValorFreteSuges);
  End;
end;

Function TfrmFatBaixaEntregaFutura.fSalvaEnderecoEntrega(strAutInc,
  strAutEnt, strEntAnt: String): Boolean;
   Var
     qryAuxMov: TUniQuery;
Begin

  Try
    qryAuxMov := fCriaQuery;

    With qryAuxMov, SQL do
    Begin
      Clear;
      Add('SELECT * FROM AUXMOV ');
      Add('WHERE');
      Add('  AUX_SEQGER = :AUTINC');

      ParamByName('AUTINC').AsString := strAutInc;

      Open;

      fStartTransaction;

      If IsEmpty Then
      Begin
        qryAuxMov.Insert;
        FieldByName('AUX_SEQGER').AsString := strAutInc;

      End Else
      Begin
        Edit;
      End;

      FieldByName('AUX_ENTGER').AsString := strAutEnt;

      Post;
      Close;
    End;

    pGravarLogFutEndereco(Self.Name,
                          cdsConsulta.FieldByName('GER_NUMDOC').AsString,
                          cdsConsulta.FieldByName('GER_ESPDOC').AsString,
                          cdsConsulta.FieldByName('GER_CODEMP').AsString,
                          cdsConsulta.FieldByName('GER_CODCLI').AsString,
                          cdsConsulta.FieldByName('GER_SERIE_').AsString,
                          '',
                          strLoginUsuarioLogado,
                          strEntAnt,
                          strAutEnt);

    fCommit;

    Result := True;

    FreeAndNil(qryAuxMov);

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message,'TfrmFatBaixaEntregaFutura.fSalvaEnderecoEntrega');
    End;
  End;
End;

Function TfrmFatBaixaEntregaFutura.fAtualizaEnderecoGrid(strSeqGer, strEntGer: String): Boolean;
  Var
    intRecNo: Integer;
Begin
  Try
    With cdsConsulta Do
    Begin
     DisableControls;

     blnTestarPost := False;

     intRecNo := RecNo;

     First;

     While Not Eof Do
     Begin

       If FieldByName('DET_SEQGER').AsString = strSeqGer Then
       Begin
         Edit;
         FieldByName('ENTGER').AsString := fatVenda.strAutEnt;
         Post;
       End;

       Next;
     End;

     RecNo := intRecNo;

     blnTestarPost := True;
     EnableControls;

     Result := True;
    End;

  Except
    On E: Exception Do
    Begin
      blnTestarPost := True;
      cdsConsulta.EnableControls;
      Result := False;
      pMensagensErro(E.Message,'TfrmFatBaixaEntregaFutura.fAtualizaEnderecoGrid');
    End;
  End;
End;

function TfrmFatBaixaEntregaFutura.fBuscaTipoFrete: integer;
begin
  Result := 0;
  cdsConsulta.First;
  while not cdsConsulta.Eof do
  begin
    if cdsConsulta.FieldByName('QTDDEV').AsFloat > 0 then
    begin
      Result := StrToIntDef(cdsConsulta.FieldByName('GER_TIPFRE').AsString, 0);
      Exit;
    end;
    cdsConsulta.Next;
  end;
end;

function TfrmFatBaixaEntregaFutura.fDefineDataEntrega: Boolean;
  Var
    strMotFut: String;
    dtaMaiorPrevisao: TDateTime;
Begin
  strMotFut := '';
  dtaMaiorPrevisao := 0;

  With cdsConsulta Do
  Begin
    DisableControls;

    First;

    While Not Eof Do
    Begin
      If (FieldByName('DET_QTDAEN').AsFloat > 0) Then
      Begin
        //armazena os motivos de entrega futura dos documentos selecionados
        If Pos(FieldByName('DET_MOTFUT').AsString, strMotFut) <= 0 Then
          strMotFut := strMotFut + FieldByName('DET_MOTFUT').AsString + '_';

        //Se motivo for falta de produto ou previsao de entrega, carrega a maior data de previsao
        If Pos(FieldByName('DET_MOTFUT').AsString, 'F_P_') > 0 Then
          dtaMaiorPrevisao := Max(dtaMaiorPrevisao, FieldByName('DET_DTAFUT').AsDateTime);
      End;

      Next;
    End;

    EnableControls;
  End;

  //Remove o ultimo caracter "_"
  If Not fEmptyStr(strMotFut) Then
    strMotFut := LeftStr(strMotFut, Length(strMotFut) -1);

  Self.dtaDtEntr := VS_Date;

  //Caso selecionados somente produtos com motivo Previsao de Entrega ou Falta de Produto
  If (strMotFut = 'P') Or (strMotFut = 'F') Then
    Self.dtaDtEntr := Max(dtaMaiorPrevisao, VS_Date);

  If Self.dtaDtEntr < VS_Date Then
    Self.dtaDtEntr := VS_Date;

  If Self.dtaDtEntr > (VS_Date + fCfgSis('DIAIME',varInteger)) Then
    Self.dtaDtEntr := (VS_Date + fCfgSis('DIAIME',varInteger));

  Result := ffrmData(Self.dtaDtEntr, '', 'Data de Entrega Imediata',
                     (VS_Date + fCfgSis('QMDPEI',varInteger)), (VS_Date + fCfgSis('DIAIME',varInteger)), fValidaDataEntIme);
end;

function TfrmFatBaixaEntregaFutura.fDefineEntregaNoFaturamento(MatrizDeItens: TMatrizFechamento): string;
  var
    item : TDadosFechamento;
begin
  Result := fCfgSis('ROMEFT');

  if (Length(MatrizDeItens) = 0) then
    exit;

  if not fCfgSis('CLBUEF',varboolean) then
    exit;

  for item in MatrizDeItens do
  begin
    if (item.strCliBus = 'S') then
    begin
      Result := 'N';
      break;
    end;
  end;
end;

procedure TfrmFatBaixaEntregaFutura.pOnClickModoConsulta(Sender: TObject);
begin
  If cdsConsulta.Active Then
    cdsConsulta.Close;

  fValidaCampos(edtCodCliente);
end;

procedure TfrmFatBaixaEntregaFutura.pAbreConsulta;
begin
  stlProdReqCompraLiberado.Clear;
  fAbreConsulta(TRUE);
  pVisibilidadeColunaLote;
  if fCfgSis('DEVEFT',varboolean) then
    pCarregarQuantidadesDevolvidas;
end;

procedure TfrmFatBaixaEntregaFutura.pAcertaSaldoDisponivel;
begin
  pAcertaSaldoDisponivel(cdsConsulta);
end;

procedure TfrmFatBaixaEntregaFutura.pAcertaSaldoDisponivel(DataSet: TDataSet);
Var
  blnAux : Boolean;
  strMotFutAConsiderar: String;
begin
  blnAux        := blnTestarPost;
  blnTestarPost := False;
  With DataSet Do
  Begin
    First;
    DisableControls;
    While Not Eof do
    Begin
      strMotFutAConsiderar := '';
      If fReservaSaldoPedidosBaixaEntregaFutura(True) Then
        strMotFutAConsiderar := fMotivosQueNaoReservaramSaldo(FieldByName('DET_MOTFUT').AsString);

      Edit;
      FieldByName('ITE_SALDOS').AsFloat := fRetornaSaldoDisponivel(FieldByName('CODITE').AsString,False,True,IfThen(FieldByName('DET_NUMLOT').AsString = 'A DEFINIR','',FieldByName('DET_NUMLOT').AsString), True, '', '', False, False);
      FieldByName('ITE_SALDIS').AsFloat := fRetornaSaldoDisponivel(FieldByName('CODITE').AsString,False,IIF(fEmptyStr(strMotFutAConsiderar), False, True),IfThen(FieldByName('DET_NUMLOT').AsString = 'A DEFINIR','',FieldByName('DET_NUMLOT').AsString), True, '', '', False, True);

      Post;
      Next;
    End;
    EnableControls;
    pFreeAndNil(frmGravando);
  End;
  blnTestarPost := blnAux;
end;

procedure TfrmFatBaixaEntregaFutura.pAcertaSaldoDisponivelNovoLote;
begin
  With cdsConsulta Do
  Begin
    FieldByName('ITE_SALDOS').AsFloat := fRetornaSaldoDisponivel(FieldByName('CODITE').AsString, False, True, FieldByName('DET_NUMLOT').AsString, True, '', '', False, False);
    FieldByName('ITE_SALDIS').AsFloat := fRetornaSaldoDisponivel(FieldByName('CODITE').AsString, False, True, FieldByName('DET_NUMLOT').AsString, True, '', '', False, True);
  End;
end;

procedure TfrmFatBaixaEntregaFutura.pAdicionarSubItensEstruturaParaBaixaEntFut;
Var
  intIndex: Integer;
begin
  If Not Assigned(cdsSubProdutos) Then
    Exit;

  pAjustarQuantidadeBaixaSubItensEstrutura;

  Try
    blnTestarPost  := False;
    cdsConsulta.DisableControls;
    cdsConsulta.First;
    While Not cdsConsulta.Eof Do
    Begin
      cdsSubProdutos.Append;
      For intIndex := 0 To cdsConsulta.Fields.Count -1 Do
        cdsSubProdutos.Fields[intIndex].Value := cdsConsulta.Fields[intIndex].Value;
      cdsSubProdutos.Post;

      //Se for o item principal vamos gravar uma entrada para zerar o estoque do mesmo e PROEMB='S' para nao exibir em relatorios de faturamento
      If cdsSubProdutos.Locate('DET_INCFUT', cdsConsulta.FieldByName('AUTOINCREM').AsString, []) Then
      Begin
        cdsSubProdutos.Append;
        For intIndex := 0 To cdsConsulta.Fields.Count -1 Do
          cdsSubProdutos.Fields[intIndex].Value := cdsConsulta.Fields[intIndex].Value;
        cdsSubProdutos.FieldByName('DET_CLAFIS').AsString := '1999';
        cdsSubProdutos.Post;
      End;

      cdsConsulta.Next;
    End;
    cdsConsulta.Data := cdsSubProdutos.Data;
    pFormataCampos;
  Finally
    cdsConsulta.EnableControls;
    blnTestarPost  := True;
    pFormataCampos;
  End;
end;

procedure TfrmFatBaixaEntregaFutura.pAjustarQuantidadeBaixaSubItensEstrutura;
begin
  If Not Assigned(cdsSubProdutos) Then
    Exit;

  //Zera a quantidade dos sub-produtos
  cdsSubProdutos.First;
  While Not cdsSubProdutos.Eof Do
  Begin
    cdsSubProdutos.Edit;
    cdsSubProdutos.FieldByName('DET_QTDAEN').AsFloat := 0;
    cdsSubProdutos.Post;
    cdsSubProdutos.Next;
  End;

  //Atualiza a quantidade dos sub-produtos
  Try
    cdsConsulta.DisableControls;
    cdsConsulta.First;
    While Not cdsConsulta.Eof Do
    Begin
      If (cdsConsulta.FieldByName('DET_QTDAEN').AsFloat > 0) Then
      Begin
        pAtualizarQuantidadeSubItens(
          cdsConsulta.FieldByName('AUTOINCREM').AsString,
          cdsConsulta.FieldByName('DET_QTDITE').AsFloat,
          cdsConsulta.FieldByName('DET_QTDAEN').AsFloat,
          cdsConsulta.FieldByName('QTDDEV').AsFloat);
      End;
      cdsConsulta.Next;
    End;
    cdsConsulta.First;
    cdsConsulta.EnableControls;
  Finally
    cdsConsulta.EnableControls;
    cdsSubProdutos.Filtered := False;
  End;
end;

procedure TfrmFatBaixaEntregaFutura.pAlteraEnderecoEntregaDocumento;
  Var
    strEndAnt: String;
Begin

  If (Not fEmptyStr(edtCodCliente.Text)) And
     (Not fClienteConsumidor(fRetNomCliente(edtCodCliente.Text), False, True)) Then
  Begin
    recEndere := fatVenda.objEndEnt.recEndere;

    With cdsConsulta Do
    Try

      fatVenda.objEndEnt.recEndere.strCliAnt := edtCodCliente.Text;
      fatVenda.objEndEnt.recEndere.strCodCli := edtCodCliente.Text;
      fatVenda.strAutEnt := FieldByName('ENTGER').AsString;

      strEndAnt := fatVenda.strAutEnt;

      If fatVenda.fAlteraEnderecoEntrega(True, False, True, True, True, True) And
         fSalvaEnderecoEntrega(FieldByName('DET_SEQGER').AsString,
                               fatVenda.strAutEnt,
                               strEndAnt) Then
      Begin
        fAtualizaEnderecoGrid(FieldByName('DET_SEQGER').AsString,
                              fatVenda.strAutEnt);
        pMensagemOk('Documento alterado com sucesso!');
      End;

    Finally

    End;

    fatVenda.objEndEnt.recEndere := recEndere;
    fatVenda.strAutEnt := recEndere.strIncrem;
  End;

End;

procedure TfrmFatBaixaEntregaFutura.pAlteraEnderecoEntregaParaBaixa;
Begin

  If (Not fEmptyStr(edtCodCliente.Text)) And
     (Not fClienteConsumidor(edtCodCliente.Text, False, True)) Then
  Begin

    blnAltEnd := fatVenda.fAlteraEnderecoEntrega(True, False, True, True, False, True);

  End;

End;


procedure TfrmFatBaixaEntregaFutura.FormShow(Sender: TObject);
  Var
    intColunAjust: Integer;
begin
  inherited;
  pConstruirGrid;

  If Not blnBFut49 Then
    Self.Caption := 'Baixa de Entrega Futura'
  Else
    Self.Caption := 'Baixa de Entrega Futura - CST 49';

  if not blnExibirSomenteProdQtdeEntPreenchida then
  begin
    chkExibirProdQtdeEntregarPreenchida.Visible := False;
    pnlHeader.Height := pnlHeader.Height - 18;
  end;

  If (blnSepFut) Then
  Begin
    btnImpSep.Visible := True;
    btnGravar.Visible := False;
    btnEndEnt.Visible := False;
    btnAlteraMotivo.Visible := False;
    btnEndEntDoc.Visible := False;
    pnlLegendSep.Visible := True;
    btnLimpaSeparacao.Visible := True;
    Self.Caption := 'Separação de Entrega Futura';
  End;

  If (fCfgSis('PCBEFT') = '2') And (Not blnSepFut) And (fEmptyStr(strCodCliConsulta)) Then
  Begin
    dbgvDadosItens.OptionsSelection.CellSelect := False;
    dbgvDadosItens.OptionsData.Editing         := False;
    dbgvDadosItens.TabStop                     := False;
    edtCodIte.Visible        := True;
    edtQtdIte.Visible        := True;
    lblCodIte.Visible        := True;
    lblQtdIte.Visible        := True;
    btnQtdIte.Visible        := True;
    pnlLegendExp.Visible     := True;
    chkSepImp.Visible        := True;
  End;

  If Not fEmptyStr(strCodCliConsulta) Then
  Begin
    Caption := 'Consulta de Entregas Futuras';
    btnGravar.Visible        := False;
    btnEndEnt.Visible        := False;
    btnMarcaTodos.Visible    := False;
    btnDesmarcaTodos.Visible := False;
    edtDocFat.Visible        := False;
    edtEspFat.Visible        := False;
    lblDocFat.Visible        := False;
    lblEspFat.Visible        := False;
    mskLinGru.Enabled        := False;
    mskDtaIni.Enabled        := False;
    mskDtaFin.Enabled        := False;
    edtCodCliente.ReadOnly   := True;
    blnTemSelecao            := False;
    btnBaixaSimplificada.Visible := False;
    edtCodCliente.Text       := strCodCliConsulta;

    chkFalta.OnClick  := pOnClickModoConsulta;
    chkPrevisao.OnClick := pOnClickModoConsulta;
    chkAguarda.OnClick := pOnClickModoConsulta;
    cmbCliBus.OnChange := pOnClickModoConsulta;

    dbgvDadosItens.OptionsData.Editing := False;

    fValidaCampos(edtCodCliente);
  End;
 
  dbgvDadosItensDET_MOTFUT.Options.Editing := False;
  dbgvDadosItensDET_CLIBUS.Options.Editing := False;
  dbgvDadosItensDTAFUT.Options.Editing     := False;
  dbgvDadosItensGER_DTAENT.Options.Editing := False;
  dbgvDadosItensGER_NUMDOC.Options.Editing := False;
  dbgvDadosItensGER_ESPDOC.Options.Editing := False;
  dbgvDadosItensGER_CODEMP.Options.Editing := False;
  dbgvDadosItensDET_CODITE.Options.Editing := False;
  dbgvDadosItensDET_DESCRI.Options.Editing := False;
  dbgvDadosItensITE_SALDIS.Options.Editing := False;
  dbgvDadosItensITE_SALDOS.Options.Editing := False;
  dbgvDadosItensDET_NUMLOT.Options.Editing := False;
  dbgvDadosItensDET_QTDITE.Options.Editing := False;
  dbgvDadosItensQTDENT.Options.Editing     := False;
  dbgvDadosItensDET_QTDPEN.Options.Editing := False;
  dbgvDadosItensSEP_QTDIMP.Options.Editing := False;
  dbgvDadosItensPENSEP.Options.Editing     := False;
  dbgvDadosItensVENDEDOR.Options.Editing   := False;
  dbgvDadosItensDET_QTDAEN.Options.Editing := True;

  dbgvDadosItensGER_NUMDOC.Width   := 85;
  dbgvDadosItensITE_SALDOS.Width   := 96;
  dbgvDadosItensDET_QTDITE.Width   := 70;
  dbgvDadosItensQTDENT.Width       := 70;
  dbgvDadosItensQTDJDV.Width       := 70;
  dbgvDadosItensDET_QTDPEN.Width   := 70;
  dbgvDadosItensSEP_QTDIMP.Width   := 70;
  dbgvDadosItensPENSEP.Width       := 70;
  dbgvDadosItensDET_QTDAEN.Width   := 70;
  dbgvDadosItensQTDDEV.Width       := 110;
  dbgvDadosItensDET_QTDENT.Width   := 70;
  dbgvDadosItensQTDFUT.Width       := 70;
  dbgvDadosItensVENDEDOR.Width     := 120;
  dbgvDadosItensDET_DESCRI.Width   := intTamMinDET_DESCRI;

  If blnSepFut Then
  Begin
    intColunAjust := 22;
    dbgvDadosItensQTDENT.Visible     := False;
    dbgvDadosItensDET_QTDPEN.Caption := 'Qt.Pendente.Ent.';
    dbgvDadosItensDET_QTDPEN.Width   := dbgvDadosItensDET_QTDPEN.Width + intColunAjust;
    dbgvDadosItensSEP_QTDIMP.Visible := True;
    dbgvDadosItensPENSEP.Visible     := True;
    dbgvDadosItensPENSEP.Caption     := 'Qt.Pendente.Sep.';
    dbgvDadosItensPENSEP.Width       := dbgvDadosItensPENSEP.Width + intColunAjust;
    dbgvDadosItensDET_QTDAEN.Caption := 'Qt.Separar';
  End
  Else
  Begin
    dbgvDadosItensQTDENT.Visible     := True;
    dbgvDadosItensSEP_QTDIMP.Visible := False;
    dbgvDadosItensPENSEP.Visible     := False;
    dbgvDadosItensDET_QTDAEN.Caption := 'Qt.Entregar';
  End;

  lblCliBus.Visible := fCfgSis('CLBUEF',varboolean);
  cmbCliBus.Visible := lblCliBus.Visible;
  dbgvDadosItensDET_CLIBUS.Visible := lblCliBus.Visible;

  dbgvDadosItensQTDDEV.Visible  := fCfgSis('DEVEFT',varboolean);
  dbgvDadosItensQTDJDV.Options.Editing := False;
  dbgvDadosItensQTDJDV.Visible  := fCfgSis('DEVEFT',varboolean);

  dbgvDadosItensITE_CODFAB.Visible  := fCfgSis('EXIFAB',varboolean);

  if dbgvDadosItensITE_CODFAB.Visible then
    dbgvDadosItensITE_CODFAB.Width := 65;

  blnInformaSaldoGeralDisponivel := ((fCfgSis('UTIWMS', varBoolean)) and (fCfgSis('TIPEXP', varInteger) = 5) and (fCfgSis('OPCROM', varInteger) = 1) and (fUsaPedidoBaixaEntregaFutura));

  blnPermiteEscolherEspecie := fBaixaDeEntregaFuturaApenasComoControleDeEntrega And
                               fPermiteEscolherFechamentoNaBaixaDeEntregaFutura;

  btnFrete.Enabled := fVerificaAcessoSistema('frmFatAltValorFreteSuges');
  btnFrete.Visible := (fCfgSis('TIPEXP', varString) = '2') and fCfgSis('FREVEN', varBoolean);

  If (fCfgSis('CALSAL') <> '2') Then
  Begin  
    //AO IMPLEMENTAR A EXIBIÇÃO DA COLUNA DO SALDO FÍSICO "NUNCA" MEXER NOS VALORES DA COLUNA ITE_SALDOS 
    dbgvDadosItensITE_SALDOS.Visible  := False;
  End;

  dbgvDadosItensPEDVEN.Visible := fCfgSis('BETNPD', VarBoolean);
  dbgvDadosItensPEDVEN.Options.Editing := False;
  dbgvDadosItensPEDVEN.Width := 130;

  If blnModoCrm Then
  Begin
    edtCodCliente.Enabled  := False;
    fValidaCampos(edtCodCliente);
  End;

  pSetFocus(chkFalta);

  Self.FormResize(Self);

end;

procedure TfrmFatBaixaEntregaFutura.pProcessaSaldoDisponivel(var aFltSaldo, aFltSaldosSemLote: Double; var aStrMotFutAConsiderar: String);
  Var
    strEmpSalRes: String;
    fltSalGarant: Double;
begin
  strEmpSalRes := IIF(fatVenda.blnEmpFat, cdsConsulta.FieldByName('DET_CODEMP').AsString, fatVenda.fEmpresaSaldoMatriz_CD);

  aStrMotFutAConsiderar := '';
  If fReservaSaldoPedidosBaixaEntregaFutura(True) Then
    aStrMotFutAConsiderar := fMotivosQueNaoReservaramSaldo(cdsConsulta.FieldByName('DET_MOTFUT').AsString);

  If (Not fEmptyStr(aStrMotFutAConsiderar)) Then
    aFltSaldosSemLote := fRetornaSaldoDisponivel(cdsConsulta.FieldByName('CODITE').AsString, False, True, '', True, '', '', False, False);

  If fatVenda.blnSaldoMatriz Then
    aFltSaldo := fatVenda.fltSaldoMatriz
  Else
    aFltSaldo   := fRetSaldosEmpresa(cdsConsulta.FieldByName('CODITE').AsString,
                                     IIF(fatVenda.fEmpCarPreenchidaEmpDif(cdsConsulta.FieldByName('DET_EMPCAR').AsString, cdsConsulta.FieldByName('DET_CODEMP').AsString),
                                         cdsConsulta.FieldByName('DET_EMPCAR').AsString, cdsConsulta.FieldByName('DET_CODEMP').AsString),
                                     cdsConsulta.FieldByName('DET_NUMLOT').AsString,
                                     (fatVenda.fEhEmissaoDocumentoWMS Or fatVenda.fEmpresaParaFaturamentoUsaWMS(strEmpSalRes) Or fVaiGerarPedidodeVenda(False, True)) And
                                      Not fLoteDefinidoNoPedido(cdsConsulta.FieldByName('CODITE').AsString));

  If fUsaQtdPendenteEntregaFutura(False) Then
    aFltSaldo := aFltSaldo + TEntregaFutura.New(
                               TParamEF.New()
                                 .CodIte(cdsConsulta.FieldByName('CODITE').AsString)
                                 .CodEmp(strEmpSalRes)
                                 .Lotes(IfThen(cdsConsulta.FieldByName('DET_NUMLOT').AsString = 'A DEFINIR', '', QuotedStr(cdsConsulta.FieldByName('DET_NUMLOT').AsString)))
                                 .Faturamento(IIF(fEmptyStr(AStrMotFutAConsiderar), False, True))
                               ).Total();

  If (blnUtiWms) And (SameText(cdsConsulta.FieldByName('DET_NUMLOT').AsString, 'A DEFINIR')) Then
  Begin
    fltSalGarant := TSaldoReservado.New(
                      TReservaParametros.New()
                     .EmpresaItem(cdsConsulta.FieldByName('DET_CODEMP').AsString)
                     .CodigoItem(cdsConsulta.FieldByName('CODITE').AsString)
                     .CodEmpresa(strEmpSalRes)
                     .TipoReserva(trsGarantia)
                     .ConverterML(True)
                     .DesconsideraPedidosCorte(False)
                    ).fGetQuantidade();

    aFltSaldo := aFltSaldo - fltSalGarant;
  End;

  If cdsConsulta.FieldByName('DET_PROACA').AsString = 'S' Then
    aFltSaldo := TProdAcabado.fRetornaSaldo(cdsConsulta.FieldByName('DET_CODACA').AsString,cdsConsulta.FieldByName('DET_EMPACA').AsString, cdsConsulta.FieldByName('DET_CODEMP').AsString);
end;

Function TfrmFatBaixaEntregaFutura.fAlteraEntregaFutura(dtaDtaRes,
                                                        dtaDtaFut: TDate;
                                                        strMotivo: String;
                                                        strCliBus: String;
                                                        objConEnt: TControleEntregaRomaneio): Boolean;
  Var
    strSQL  : String;
    strTab  : String;
    qryAux  : TUniQuery;
Begin

  With cdsConsulta Do
  Try

    fStartTransaction;

    If Assigned(objConEnt) Then
    Begin
      objConEnt.fSetNumDoc(cdsConsulta.FieldByName('GER_NUMDOC').AsString,
                           cdsConsulta.FieldByName('GER_ESPDOC').AsString,
                           cdsConsulta.FieldByName('GER_CODEMP').AsString,
                           cdsConsulta.FieldByName('GER_CODCLI').AsString);
      objConEnt.pCarregaArrayDatasPeloDocFat(objConEnt.arrDtaOri);
    End;

    qryAux := fCriaQuery;
    strTab := cdsConsulta.FieldByName('TABELA').AsString;

    strSQL := '';
    strSQL := strSQL + 'UPDATE    ';
    strSQL := strSQL + ' ' + strTab + ' ';
    strSQL := strSQL + 'SET       ';
    strSQL := strSQL + '  DET_MOTFUT = :MOTFUT, ';
    strSQL := strSQL + '  DET_DTAFUT = :DTAFUT  ';
    strSQL := strSQL + 'WHERE     ';
    strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

    qryAux.Close;
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('MOTFUT').AsString := strMotivo;
    qryAux.ParamByName('DTAFUT').AsDate   := dtaDtaFut;
    qryAux.ParamByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
    qryAux.ExecSQL;

    {**************************}
    {* ATUALIZANDO CLIBUS     *}
    {************************LE}
    qryAux.Close;
    qryAux.SQL.Clear;
    strSQL := '';
    strSQL := strSQL + 'UPDATE  ';
    strSQL := strSQL + ' MOVTRI ';
    strSQL := strSQL + 'SET       ';
    strSQL := strSQL + '  DET_CLIBUS = :CLIBUS ';
    strSQL := strSQL + 'WHERE     ';
    strSQL := strSQL + '  DET_SEQGER = :AUTINC ';
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
    qryAux.ParamByName('CLIBUS').AsString := strCliBus;
    qryAux.ExecSQL;

    FreeAndNil(qryAux);

    If Assigned(objConEnt) Then
    Begin
      If strMotivo = 'P' Then
        objConEnt.pAlteraDataEntregaDocumento(dtaDtaFut);

      objConEnt.pCarregaArrayDatasPeloDocFat(objConEnt.arrDtaEnt);

      objConEnt.fProcessaArrayDatasControleEntregaRomaneio;
    End;

    pReprocessarSaldoItensPorDocumento(FieldByName('GER_NUMDOC').AsString,
                                       FieldByName('GER_ESPDOC').AsString,
                                       FieldByName('GER_CODEMP').AsString,
                                       FieldByName('AUTOINCREM').AsString);

    pAdicionaItemParaReprocessamentoDeSaldo(FieldByName('DET_CODITE').AsString);
    pNotificarRoboParaReprocessarSaldos;

    pGravarLogFut(Self.Name,
                  FieldByName('GER_NUMDOC').AsString,
                  FieldByName('GER_ESPDOC').AsString,
                  FieldByName('GER_CODEMP').AsString,
                  FieldByName('GER_CODCLI').AsString,
                  FieldByName('GER_SERIE_').AsString,
                  FieldByName('DET_CODITE').AsString,
                  strLoginUsuarioLogado,
                  VS_Date,
                  fTime(),
                  FieldByName('DET_MOTFUT').AsString,
                  strMotivo,
                  FieldByName('DET_DTAFUT').AsString,
                  FormatDateTime('DD/MM/YYYY',  dtaDtaFut));

    fCommit;

    Result := True;

  Except

    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
		    pMensagensErro(E.Message,'[TfrmFatBaixaEntregaFutura.fAlteraEntregaFutura]');
    End;

  End;

End;

procedure TfrmFatBaixaEntregaFutura.btnAlteraMotivoClick(Sender: TObject);
  Var
    objConEnt: TControleEntregaRomaneio;
begin
  inherited;

  If (Not cdsConsulta.Active) or (cdsConsulta.IsEmpty) Then
  Begin
    pMensagemOk('É necessário selecionar pelo menos um registro!');
    Exit;
  End;

  If Not btnAlteraMotivo.Visible Then
    Exit;

  If Not fVerificaAcessoSistema('ALMBEF', strLoginUsuarioLogado) Then
  Begin
    fMensagem('ATENÇÃO', 'Usuário sem permissão para alterar o Motivo da Entrega Futura!' , ['&O k']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmFatDigDtaEntFut, frmFatDigDtaEntFut);

    If fCfgSis('DIAENT', varBoolean) Then
    Begin
      objConEnt := TControleEntregaRomaneio.Create;
      objConEnt.fSetNumDoc(cdsConsulta.FieldByName('DET_NUMDOC').AsString,
                           cdsConsulta.FieldByName('DET_ESPDOC').AsString,
                           cdsConsulta.FieldByName('DET_CODEMP').AsString,
                           cdsConsulta.FieldByName('DET_CODCLI').AsString);
      objConEnt.pCarregaArrayDatasPeloDocFat(objConEnt.arrDtaOri);
    End
    Else
      objConEnt := Nil;

    frmFatDigDtaEntFut.objConEnt              := objConEnt;
    frmFatDigDtaEntFut.intDiaFor              := cdsConsulta.FieldByName('ITE_DIAFOR').AsInteger;
    frmFatDigDtaEntFut.cmbMotEntFut.ItemIndex := fMotivoEntFutToIndex(cdsConsulta.FieldByName('DET_MOTFUT').AsString);
    frmFatDigDtaEntFut.mskDtaEntFut.Text      := DateToStr(cdsConsulta.FieldByName('DET_DTAFUT').AsDateTime);

    frmFatDigDtaEntFut.strNumDoc := cdsConsulta.FieldByName('DET_NUMDOC').AsString;
    frmFatDigDtaEntFut.strEspDoc := cdsConsulta.FieldByName('DET_ESPDOC').AsString;
    frmFatDigDtaEntFut.strCodEmp := cdsConsulta.FieldByName('DET_CODEMP').AsString;
    frmFatDigDtaEntFut.strCodCli := cdsConsulta.FieldByName('DET_CODCLI').AsString;
    frmFatDigDtaEntFut.strCodIte := cdsConsulta.FieldByName('DET_CODITE').AsString;
    frmFatDigDtaEntFut.strCodVen := cdsConsulta.FieldByName('DET_CODVEN').AsString;
    frmFatDigDtaEntFut.fltQtdIte := cdsConsulta.FieldByName('DET_QTDITE').AsFloat;

    If frmFatDigDtaEntFut.ShowModal = mrOk Then
    Begin

      fAlteraEntregaFutura(frmFatDigDtaEntFut.dtaDtaRes,
                           StrToDate(frmFatDigDtaEntFut.mskDtaEntFut.Text),
                           fMotivoEntFutToSigla(frmFatDigDtaEntFut.cmbMotEntFut.ItemIndex),
                           IfThen(frmFatDigDtaEntFut.cmbCliBus.Text = 'SIM','S','N'),
                           objConEnt);
      
      pSalvaQtdDig;
      TfrmGravando.fExecutarModal(pAbreConsulta, 'Aguarde... Carregando documentos.', '');

      If fClienteConsumidor(fRetNomCliente(edtCodCliente.Text)) Then
        fFiltraConsumidor;
      pRestauraQtdDig;
    End;

    If Assigned(objConEnt) Then
      FreeAndNil(objConEnt);

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'TfrmFatBaixaEntregaFutura.btnAlteraMotivoClick');
    End;

  End;

  pFreeAndNil(frmFatDigDtaEntFut);
end;

procedure TfrmFatBaixaEntregaFutura.pExpedeItem;
  Var
    strMensagem : String;
    strTxtCap   : String;
    blnAchou    : Boolean;
    blnBarExp   : Boolean;
    strCodSem   : String;
    strCodIteUni: String;
    strCodGruUni: String;
    fltQtdIteUni: Double;

  procedure SetaCampoProcurar(const strCaption: string);
  begin
    If bln2CodBar And (strCaption = CAP_CODBAR_EMB) Then
      strCamBus := 'CODBAR'
    Else
    If bln2CodBar And (strCaption = CAP_CODBAR_FOR) Then
      strCamBus := 'CODBAT'
    Else
      strCamBus := 'CODBAR';
  end;

  procedure pInverteBusca;
  begin
    If (strCamBus = 'BAREMB') Then
    Begin
      strCamBus := 'CODBAT';
      strTxtCap := CAP_CODBAR_FOR;
    End
    Else
    Begin
      strCamBus := 'BAREMB';
      strTxtCap := CAP_CODBAR_EMB;
    End;
  end;

  function fBuscaSegundoCodBar:Boolean;
  begin
    pInverteBusca;

    strCodIteFor := Trim(InputBox('AutCom', strTxtCap,''));
    strCodIte    := strCodIteFor;
    strCodDig    := strCodIteFor;
    Result       := fEncontraItem(strMensagem);
  end;

begin

  If (Length(edtCodIte.Text) > fTamCodIte) Then
    strCamBus := 'BAREMB'
  Else
  Begin
    strCamBus      := 'CODITE';
    edtCodIte.Text := fStrZero(edtCodIte.Text, fTamCodIte);
    blnBarExp      := (fCampoTabela('ITE_BAREXP', 'CADITE', ['ITE_CODITE'], [edtCodIte.Text]) = 'S') and fCfgSis('BAREXP', varBoolean);

    If (blnBarExp) Then
    Begin
      edtCodIte.Clear;
      pMensagemSonora('Para expedir este produto é necessário informar o código de barras.');
      pLiberaGrid;
      Exit;
    End;
  End;

  blnJaValidou := False;

  If Not fValidaMultiploVenda(fStrToFloat(edtQtdIte.Text),
                              fCampoTabela('ITE_MLTVEN', 'CADITE', ['ITE_CODITE'], [edtCodIte.Text])) Then
    Exit;

  bln2CodBar   := (fCfgSis('EXPTIN',varString) = 2) And (cdsConsulta.FieldByName('IDEPRO').AsString <> 'NOR');
  blnAchou     := False;

  strCodIteFor := '';
  strMensagem  := '';

  strCodIte    := edtCodIte.Text;
  strCodDig    := edtCodIte.Text;

  Try
    cdsConsulta.DisableControls;

    If (blnUsaSelEnt) And (Not fEmptyStr(strCodTin)) Then
      strCamBus := 'CODTIN';

    If (bln2CodBar) And (strCamBus <> 'CODITE') Then
    Begin
      blnAchou := fEncontraItem(strMensagem);

      If (Not blnAchou) Then
      Begin
        pInverteBusca;
        blnAchou := fEncontraItem(strMensagem);
      End;

      If blnAchou Then
      Begin
        If Not blnUsaSelEnt Then
          blnAchou := fBuscaSegundoCodBar;
      End;
    End
    Else If (strCamBus = 'CODITE') Then
      blnAchou := fEncontraItem(strMensagem)

    Else If (strCamBus = 'CODTIN') Then
      blnAchou := fEncontraItem(strMensagem);

    If Not blnAchou And fCfgSis('ETIDIF', varBoolean) And (strCamBus = 'BAREMB') Then
    Begin
      If objIteBar.fLerCodigoBarrasUnidades(edtCodIte.Text, strCodIteUni, strCodGruUni, fltQtdIteUni) Then
      Begin
        strCamBus := 'CODITE';
        strCodIte := strCodIteUni;
        edtCodIte.Text := strCodIteUni;
        edtQtdIte.Text := FloatToStrF(fltQtdIteUni, ffFixed, 12, fCfgSis('DECQTD', varInteger));
        blnAchou := fEncontraItem(strMensagem);
      End;
    End;

    If (Not bln2CodBar) And (Not blnAchou) And (Length(edtCodIte.Text) > fTamCodIte) Then
    Begin

      blnAchou := fEncontraItem(strMensagem);

      If (Not blnAchou) Then
      Begin
        SetaCampoProcurar(CAP_CODBAR_EMB);
        blnAchou := fEncontraItem(strMensagem);

        if (Not blnAchou) then
        begin
          SetaCampoProcurar(CAP_CODBAR_FOR);
          blnAchou := fEncontraItem(strMensagem);

          If (Not blnAchou) And fProcuraSemelhante(edtCodIte.Text, strCodSem) Then
          Begin
            strCamBus      := 'CODITE';
            edtCodIte.Text := strCodSem;
            strCodIte      := strCodSem;
            blnAchou       := fEncontraItem(strMensagem);
          End;
        end;
      End;
    End;

  Finally
    cdsConsulta.EnableControls;
  End;

  If (Not blnAchou) Then
  Begin
    strMensagem := 'Produto (' + edtCodIte.Text +
                    IIF(fEmptyStr(strCodIteFor), '', ' - ' + strCodIteFor) + ') não encontrado!';
  End;

  If (Not fEmptyStr(strMensagem)) Then
  Begin
    pMensagemSonora(strMensagem);
  End;

  pLiberaGrid;
  Application.ProcessMessages;
end;

function TfrmFatBaixaEntregaFutura.fEhDocumentoEmpresaCd(
  strEmpresaCd: string; blnEhAbastecimentoDeposito: Boolean): Boolean;
  Var
    cdsDados: TUniClientDataSet;
    strEmpCdDoc: String;
    blnEntCdDoc: Boolean;
begin
  Result := False;

  if blnEhAbastecimentoDeposito then
    Exit(True);

  cdsDados := TUniClientDataSet.Create(nil);

  try
    pCloneDataSet(cdsDados, cdsConsulta);
    cdsDados.First;

    while not cdsDados.Eof do
    begin
      if cdsDados.FieldByName('DET_QTDAEN').AsFloat > 0 then
      begin
        If (fCfgSis('PEF_CD', varBoolean)) And 
           (fCfgSis('ENT_CD', varBoolean)) And 
           (fCfgSis('CDEXAF', varBoolean)) And 
           (VS_strCodEmp = fCfgSis('EMP_CD')) And
           (Pos(VS_strTipExp, '3_4_') > 0) Then
        Begin
          strEmpCdDoc := LeftStr(cdsDados.FieldByName('EMP_CD_ENT_CD').AsString, 3);
          blnEntCdDoc := RightStr(cdsDados.FieldByName('EMP_CD_ENT_CD').AsString, 1) = 'S';  
          
          If (blnEntCdDoc) And (VS_strCodEmp = strEmpCdDoc) Then
          Begin
            fatVenda.strEmp_CD := strEmpCdDoc;
            Result := True;
            Exit;
          End;
        End;

        if (strEmpresaCd = VS_strCodEmp) and (cdsDados.FieldByName('GER_CODEMP').AsString = VS_strCodEmp) then
        begin
          fatVenda.strEmp_CD := EmptyStr;
          Exit;
        end;

        if (cdsDados.FieldByName('GER_CODEMP').AsString = strEmpresaCd) or
           ((strEmpresaCd = VS_strCodEmp) and (cdsDados.FieldByName('GER_CODEMP').AsString <> strEmpresaCd)) then
        begin
          if (strEmpresaCd = VS_strCodEmp) and (cdsDados.FieldByName('GER_CODEMP').AsString <> strEmpresaCd) then
          begin
            fatVenda.strEmp_CD := cdsDados.FieldByName('GER_CODEMP').AsString;
          end;
          Result := True;
          Exit;
        end;
      end;

      cdsDados.Next;
    end;
  finally
    FreeAndNil(cdsDados);
  end;
end;

function TfrmFatBaixaEntregaFutura.fEhMesmoGrupoFrete: Boolean;
var
  intTipFre,
  intTipoFrete: integer;
  typTipoFreteDoc,
  typTipoFreteItem: TTipoFrete;
begin
  Result := True;
  typTipoFreteDoc := frComFrete;
  typTipoFreteItem := frComFrete;

  if not fCfgSis('DEVEFT', varBoolean) then
    Exit;

  if not fCfgSis('ESPDEV', varBoolean) then
    Exit;

  if fCfgSis('FRDVES', varString) <> '2' then
    Exit;

  if cdsConsulta.IsEmpty then
    Exit;

  intTipFre := 0;
  cdsConsulta.First;

  while not cdsConsulta.Eof do
  begin
    if cdsConsulta.FieldByName('QTDDEV').AsFloat > 0 then
    begin
      if intTipFre = 0 then
      begin
        intTipFre := StrToIntDef(cdsConsulta.FieldByName('GER_TIPFRE').AsString, 0);

        case intTipFre of
          1,3,9,4: typTipoFreteDoc := frSemFrete;
          2,5    : typTipoFreteDoc := frComFrete;
        end;
      end
      else
      begin
        intTipoFrete := StrToIntDef(cdsConsulta.FieldByName('GER_TIPFRE').AsString, 0);

        case intTipoFrete of
          1,3,9,4: typTipoFreteItem := frSemFrete;
          2,5    : typTipoFreteItem := frComFrete;
        end;

        if (typTipoFreteDoc <> typTipoFreteItem) then
        begin
          Result := False;
          Exit;
        end;
      end;
    end;
    cdsConsulta.Next;
  end;
end;

function TfrmFatBaixaEntregaFutura.fEncontraItem(Var strMensagem: String; blnApenasSimular: Boolean = False): Boolean;
  Var
    fltQtdIte: Double;
    fltQtdExp: Double;
    fltQtdFal: Double;
    fltEmbala: Double;
    blnBusNormalOuExp2CodBarCompleta: Boolean;
begin

  If (Not blnApenasSimular) And fEncontraItem(strMensagem, True) Then
  Begin
    Result := True;
    If Not fEmptyStr(strMensagem) Then
      Exit;
  End;

  With cdsConsulta Do
  Begin
    First;
    Result := False;

    OnFilterRecord := pOnFilter;

    blnBusNormalOuExp2CodBarCompleta := ((Not bln2CodBar) Or (strCamBus = 'CODITE') Or (blnUsaSelEnt)) Or
                                        (bln2CodBar And (Not fEmptyStr(strCodIteFor))) Or
                                        (fCfgSis('EXPTIN', varString) = '1');

    If (FindFirst) Then
    Begin

      Result := True;

      fltEmbala := 0;

      If SameText(strCamBus, 'BAREMB') Then
        fltEmbala := objIteBar.fQuantidadeEmbalagem(FieldByName('DET_CODITE').AsString, strCodDig);

      If fltEmbala = 0 Then
        fltEmbala := 1;

      fltQtdIte := fltEmbala * fStrToFloat(edtQtdIte.Text);

      Repeat

        //Calcula a quantidade que falta do Produto
        fltQtdFal := FieldByName('DET_QTDITE').AsFloat - //Original
                     FieldByName('QTDENT'    ).AsFloat - //Já baixada
                     FieldByName('DET_QTDAEN').AsFloat;  //Já digitada

        If (fltQtdFal > 0) Then
        Begin
          If fltQtdFal > fltQtdIte Then
            fltQtdExp := fltQtdIte
          Else
            fltQtdExp := fltQtdFal;

          fltQtdIte := fFormataFloat(fltQtdIte, 4) - fFormataFloat(fltQtdExp, 4);

          If (blnBusNormalOuExp2CodBarCompleta) Then
          Begin

            If Not blnApenasSimular Then
            Begin
              {*REQ.144458**********RP*}
              IF Not fVerificaParamEntregaFuturaDocSelec(cdsConsulta.FieldByName('AUX_ENFUOP').AsString) Then
                strMensagem := 'Não é permitido realizar baixa de entrega futura de vendas realizadas com a configuração "CFG_ENFUOP" diferente.'
              Else
              Begin
                Edit;
                FieldByName('DET_QTDAEN').AsFloat := FieldByName('DET_QTDAEN').AsFloat + fltQtdExp;
                Post;
              End;
            End;

          End;
        End;

        If (fltQtdIte <= 0) Then
          Break;

      Until (Not FindNext);

      If fltQtdIte > 0 Then
      Begin
        fltQtdExp := fltEmbala * fStrToFloat(edtQtdIte.Text) - fltQtdIte;

        If (fltQtdExp = 0.00) Then
        Begin
          strMensagem := 'Produto (' + edtCodIte.Text + ') já foi totalmente expedido!';
        End
        Else
        Begin
          strMensagem := Format('Quantidade informada para o produto (%s) ' +
                                'ultrapassou a quantidade pendente (%f)!',
                                [edtCodIte.Text, fltQtdExp]);
        End;

        If Not blnApenasSimular Then
          edtQtdIte.Text := FloatToStrF(1, ffFixed, 12, fCfgSis('DECQTD', varInteger));
      End;

    End;

    OnFilterRecord := nil;

    pFormataCampos;

  End;

end;

function TfrmFatBaixaEntregaFutura.fExisteSomenteQuantidadeADevolver: Boolean;
begin
  Result := True;

  cdsConsulta.DisableControls;
  cdsConsulta.First;
  while not cdsConsulta.Eof do
  Begin
    if cdsConsulta.FieldByName('DET_QTDAEN').AsFloat > 0 then
    begin
      Result := False;
      Break;
    end;
    cdsConsulta.Next;
  End;
  cdsConsulta.EnableControls;
end;

procedure TfrmFatBaixaEntregaFutura.pPreencheClientParaValidacaoDocumentosBaixadosComDataDePrevisaoAnterior(AblnDocumentoPassandoNafrente: Boolean; AintRegra: Integer;
  AcdsDadosDocumentos: TUniClientDataset; var AcdsDadosDavalidacao: TUniClientDataset);
begin
  If not AcdsDadosDavalidacao.Locate('DOCUME;PASFRE;REGRA_;QTDVEN;QTDBAI;TIPENF',
    VarArrayOf([AcdsDadosDocumentos.FieldByName('GER_NUMDOC').AsString+'-'+
                AcdsDadosDocumentos.FieldByName('GER_ESPDOC').AsString+'-'+
                AcdsDadosDocumentos.FieldByName('GER_CODEMP').AsString,
                IIF(AblnDocumentoPassandoNafrente, 0, 1),
                AintRegra,
                AcdsDadosDocumentos.FieldByName('DET_QTDITE').AsString,
                AcdsDadosDocumentos.FieldByName('DET_QTDAEN').AsString,
                'EF-'+AcdsDadosDocumentos.FieldByName('DET_MOTFUT').AsString]), []) Then
  Begin
    AcdsDadosDavalidacao.Append;
    AcdsDadosDavalidacao.FieldByName('DOCUME').AsString   := AcdsDadosDocumentos.FieldByName('GER_NUMDOC').AsString+'-'+
                                                             AcdsDadosDocumentos.FieldByName('GER_ESPDOC').AsString+'-'+
                                                             AcdsDadosDocumentos.FieldByName('GER_CODEMP').AsString;
    AcdsDadosDavalidacao.FieldByName('TIPENF').AsString   := 'EF-'+AcdsDadosDocumentos.FieldByName('DET_MOTFUT').AsString;
    AcdsDadosDavalidacao.FieldByName('QTDVEN').AsString   := AcdsDadosDocumentos.FieldByName('DET_QTDITE').AsString;
    AcdsDadosDavalidacao.FieldByName('QTDBAI').AsString   := AcdsDadosDocumentos.FieldByName('DET_QTDAEN').AsString;
    AcdsDadosDavalidacao.FieldByName('QTDPEN').AsString   := AcdsDadosDocumentos.FieldByName('DET_QTDPEN').AsString;
    AcdsDadosDavalidacao.FieldByName('DTAVEN').AsDateTime := AcdsDadosDocumentos.FieldByName('GER_DTAENT').AsDateTime;
    AcdsDadosDavalidacao.FieldByName('PASFRE').AsInteger  := IIF(AblnDocumentoPassandoNafrente, 0, 1);
    AcdsDadosDavalidacao.FieldByName('REGRA_').AsInteger  := AintRegra;

    AcdsDadosDavalidacao.FieldByName('CODCLI').AsString   := AcdsDadosDocumentos.FieldByName('GER_CODCLI').AsString;
    AcdsDadosDavalidacao.FieldByName('NOMCLI').AsString   := fRetNomCliente(AcdsDadosDocumentos.FieldByName('GER_CODCLI').AsString);
    AcdsDadosDavalidacao.FieldByName('CODVEN').AsString   := AcdsDadosDocumentos.FieldByName('GER_CODVEN').AsString;
    AcdsDadosDavalidacao.FieldByName('NOMVEN').AsString   := fRetNomVendRep(AcdsDadosDocumentos.FieldByName('GER_CODVEN').AsString);


    AcdsDadosDavalidacao.Post
  End;
end;

function TfrmFatBaixaEntregaFutura.fProcessarDocumento(Const opcBaixa: TTipoBaixa; Out blnPassouGravaArquivos: Boolean;
  Const blnDevolucao, blnIgnorarGravarTinDet: Boolean): Boolean;
  var
    LstrOpcaoDocumentoOriginal : String;
    intContador                : Integer;
    fltTotFre                  : Double;
    fltValFreAntesTelaMsg      : Double;
begin
  Result := True;

  blnPassouGravaArquivos := False;

  fatVenda.blnBaiFutDev := blnDevolucao;
  fatVenda.blnIgnorarGravarTinDet := blnIgnorarGravarTinDet;

  if (opcBaixa In [bxBaixaAutomatica, bxDevolucaoAutomatica]) then
    fatVenda.blnExpedi := True
  else
    fatVenda.blnExpedi := False;

  If fCfgSis('NFEDSE', varBoolean) Then
    fatVenda.strDtaAtu := DateToStr(Self.dtaDtEntr);

  if (opcBaixa In [bxBaixaAutomatica]) then
    fatVenda.blnBaiDev := True;

  pInicializaTemporaria;

  If (fCfgSis('EFTEST') = '2') And (fCfgSis('EFTESE') = '1') Then
    pAdicionarSubItensEstruturaParaBaixaEntFut;

  stlDocsConf.Clear;
  pNotificarRoboParaReprocessarSaldos;
  Result := Result And fIncluiItens(fatVenda, opcBaixa);

  If (Result) And (cdsVenda.recordcount <> 0) Then
  Begin
    if (opcBaixa = bxDevolucaoAutomatica) then
    Begin
      LstrOpcaoDocumentoOriginal := fatVenda.strOpcDoc;
      fatVenda.strOpcDoc         := 'DV';
      fatVenda.strOpcDocTrue     := 'DV';
      fatVenda.blnDevBaiEntFut   := True;
      fatVenda.blnBaiEntFut      := False;
      fatVenda.blnDevolucaoAutomaticaEntregaFutura := True;
    End;

    If fEmptyStr(fatVenda.strTabPre) then
      fatVenda.strTabPre := '1';

    fatVenda.strEntreg := cdsConsulta.FieldByName('GER_CONENT').AsString;

    if opcBaixa = bxBaixaNormal then
      fatVenda.fltFreCot := fRetornaValorDoFreteIformadoParaDocumentosTotalmenteBaixados;

    fatVenda.pCarregaAliquotasRetencao;

    fatVenda.pPreencheMatrizFechamento;

    if (opcBaixa = bxDevolucaoAutomatica) then
    Begin
      for intContador := Low(fatVenda.arrMatItens) To High(fatVenda.arrMatItens) do
      Begin
        fatVenda.arrMatItens[intContador].strDocDev := FstrDocumentoParaDevolucao;
        fatVenda.arrMatItens[intContador].strEspDev := FstrEspecieParaDevolucao;
        fatVenda.arrMatItens[intContador].strEmpDev := FstrEmpresaParaDevolucao;

        fatVenda.arrMatItens[intContador].strEspFut := '';
        fatVenda.arrMatItens[intContador].strDocFut := '';
        fatVenda.arrMatItens[intContador].strEmpFut := '';
      End;

      fatVenda.strMen001 := 'Devolução do Documento "'+FstrDocumentoParaDevolucao+
      '-'+FstrEspecieParaDevolucao+'-'+FstrEmpresaParaDevolucao+'" gerado em baixa de entrega '+
      'futura';

      if (cdsConsulta.FieldByName('QTDDEV').AsFloat > 0) and (SameText(cdsConsulta.FieldByName('DET_NUMLOT').AsString, 'A DEFINIR')) then
        fatVenda.blnEhBaixaEntregaFuturaQtdBaixarDevolver := True
      else
        fatVenda.blnEhBaixaEntregaFuturaQtdBaixarDevolver := False;
    End;

    fatVenda.strEntFat := fDefineEntregaNoFaturamento(fatVenda.arrMatItens);

    fatVenda.pCalculaPesBruLiq;

    fatVenda.pCalculaTotGer(False, False);

    If fatVenda.fAplicaDescontoIcmsOrgaoPublicoNoDescontoEspecial Then
    Begin
      If (fatVenda.fltDesEsp <= 0.00) And (fatVenda.fltIcmOrg > 0) Then
        fatVenda.fltDesEsp := fatVenda.fltIcmOrg;
    End;

    fatVenda.pDestacaRetencoes;

    fatVenda.pRetemImpostosNoDescontoEspecial;

    fatVenda.pCalculaTotGer(False, False);

    fatVenda.pCalculaTotGer;

    fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

    fatVenda.pPreencherMsgDadosAdicBaixaEntFutNF;
    fatVenda.pPreencherMsgCondPgtoBaixaEntFutNF;

    fatVenda.intQtdTra := StrToIntDef(FloatToStr(fatVenda.fRetVolumes), 0);

    If fCfgSis('SEPEXC', varBoolean) Then
    Begin
      fatVenda.intQtdTraSepExc  := StrToIntDef(FloatToStr(fatVenda.fRetVolumesSepExc), 0);
      fatVenda.intQtdTraSepNExc := (fatVenda.intQtdTra - fatVenda.intQtdTraSepExc);
    End;

    If fVaiGerarPedidodeVenda Then
    Begin
      fatVenda.fltFreSug := IIF(fltFreRatAux > 0, fltFreRatAux, fatVenda.fltValFre);
    End;

    fltValFreAntesTelaMsg := fatVenda.fltValFre;
    
    If Not (opcBaixa = bxDevolucaoAutomatica) Then
    Begin
      If Not fPedeTelaMensagens Then
      Begin
        Exit(False);
      End;
    End;
    
    If fVaiGerarPedidodeVenda Then
    Begin
      If (fltFreRatAux > 0) Then
      Begin
        fatVenda.fltFreRat := IIF(fltValFreAntesTelaMsg <> fatVenda.fltValFre, fatVenda.fltValFre, fltFreRatAux);
        fatVenda.fltValFre := 0.00;
        fatVenda.fltFreDig := 0.00;
      End;
    End;

    if (fCfgSis('DEVEFT', varBoolean)) and (fCfgSis('ESPDEV', varBoolean)) and (fltTotDev > 0) And (fatVenda.strOpcDoc = 'DV') Then
    begin
      fltTotFre := 0;
      if (fCfgSis('FRDVES', varString) = '0') then
      begin
        fltTotFre := IIF(fatVenda.fltFreRat > 0, fatVenda.fltFreRat, fatVenda.fltValFre);
      end
      else if (fCfgSis('FRDVES', varString) = '2') then
      begin
        If (fatVenda.strTipFre = '1'{Emitente(CIF)}) Or (fatVenda.strTipFre = '3'{Terceiros}) Or (fatVenda.strTipFre = '9'{Sem Frete}) Or (fatVenda.strTipFre = '4'{Transporte Próprio Remetente}) Then
        begin
          fltTotFre := IIF(fatVenda.fltFreRat > 0, fatVenda.fltFreRat, fatVenda.fltValFre);
        end;
      end;
      fDigDuplic(fatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses(fatVenda.strConPag), 0, fatVenda.fltTotGer - fltTotFre,
                                               False, False, False, VS_Date, False);

      If fCfgSis('ZVFDEV', varBoolean) And ((fltTotFre > 0) Or (IIF(fatVenda.fltFreRat > 0, fatVenda.fltFreRat, fatVenda.fltValFre) > 0)) Then
      Begin
        fatVenda.fltValFre := 0.00;
        fatVenda.fltFreRat := 0.00;
        fatVenda.pCalculaTotGer;
      End;
    end
    else
      fDigDuplic(fatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses(fatVenda.strConPag), 0, fatVenda.fltTotGer,
                                               False, False, False, VS_Date, False);

    fatVenda.pCalculaTotalParaCadRec;

    fatVenda.pRateiaValores;

    fatVenda.fLimpaPrevisaoEntFut := fLimpaPrevisaoEntFut;

    If fUsaPedidoBaixaEntregaFutura And (fatVenda.strEspDoc = 'PD') Then
    Begin
      fatVenda.cdsBaiEntFut := Nil;

      If Not blnDocOri Then
      Begin

        Try
          pCriarFormularios(TfrmFatTipoExpedicao, frmFatTipoExpedicao);
          frmFatTipoExpedicao.Caption  := 'Tipo de Faturamento - Pedido de Entrega Imediata';
          frmFatTipoExpedicao.fatVenda := fatVenda;
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
          fMensagem('ATENÇÃO!', 'O tipo do pedido de entrega imediata não foi informado! Favor verificar.', ['&Ok']);
          Exit(False);
        End;

      End;
    End
    Else
    Begin
      fatVenda.cdsBaiEntFut := cdsConsulta;
    End;

    If fatVenda.strAbaDep <> 'S' Then
    Begin
      fatVenda.blnAbastecimentoDeposito := False;
      fatVenda.strEmpresaAbastecimentoDeposito := '';
    End;


    fatVenda.strOprFlj := 'N';
    fatVenda.blnTaxVpr := False;

    If (fatVenda.strEspDoc = 'PD') Then
    Begin
      If (fCfgSis('CNDVEN') = 'F') Then
      Begin
        If (fatVenda.fTaxJurMatrizItens > 0) Then
        Begin
          fatVenda.blnTaxVpr := True;
          fatVenda.fltTaxVpr := fatVenda.fTaxJurMatrizItens;
        End;
      End;
      pCarregaInformacoesComplementares(fatVenda.arrMatItens[0].strIncFut);
      untFatGor.intSeqFdo := 1;
    End
    Else If (Pos(fatVenda.strEspDoc, 'NF_FF_IF_') > 0) Then
    Begin
      fatVenda.strOprFlj := fRetornaSeDocumentoComProducaoForaDeLoja(fatVenda.arrMatItens[0].strIncFut);
    End;

    Try
      pCriarFormularios(TfrmGravando,frmGravando);
      frmGravando.strChave := 'FATVENDAS';

      frmGravando.fExecutarAcao := fatVenda.fGravaArquivos;

      blnPassouGravaArquivos := True;

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

    If Result Then
    Begin
      if (Pos(fatVenda.strClaFis, CLAFIS_ENTFUT_VEN) > 0) and
         (fatvenda.strEspDoc <> 'PD') then
      begin
        fDisparaWhatsappAutomatico(fatVenda.strNumDoc, 'EF', fatVenda.strEspDoc, EmptyStr, EmptyStr, EmptyStr, fatVenda.strCodCli, '', True, '', Nil, '', '', '', Self.UnitName);
        fDisparaEmailAutomatico(fatVenda.strNumDoc, 'EF', fatVenda.strEspDoc, EmptyStr, EmptyStr, EmptyStr, fatVenda.strCodCli);
        fDisparaSMSAutomatico(fatVenda.strNumDoc, 'EF', fatVenda.strEspDoc, EmptyStr, EmptyStr, EmptyStr, fatVenda.strCodCli);
      end;

      if (opcBaixa = bxBaixaAutomatica) then
      Begin
        FstrDocumentoParaDevolucao := fatVenda.strNumDoc;
        FstrEspecieParaDevolucao   := fatVenda.strEspDoc;
        FstrEmpresaParaDevolucao   := fatVenda.strEmpDoc;
      End;

      if (opcBaixa = bxDevolucaoAutomatica) then
      Begin
        fatVenda.strOpcDoc         := LstrOpcaoDocumentoOriginal;
        fatVenda.blnDevBaiEntFut   := False;
        fatVenda.blnBaiEntFut      := True;
        fatVenda.blnDevolucaoAutomaticaEntregaFutura := False;

        If fEmptyStr(strCodCliConsulta) Then
          fatVenda.strOpcDocTrue := 'BF';

        FstrDocumentoParaDevolucao := '';
        FstrEspecieParaDevolucao   := '';
        FstrEmpresaParaDevolucao   := '';
      End;
    End;

  End;
end;

Function TfrmFatBaixaEntregaFutura.fProcuraSemelhante(strCodBar: String; Var strCodSem: String): Boolean;
Begin
  strCodSem := fCampoTabela('SEM_CODITE', 'CADSEM', ['SEM_CODBAR'], [strCodBar]);
  Result    := Not fEmptyStr(strCodSem);
End;

procedure TfrmFatBaixaEntregaFutura.pOnFilter(DataSet: TDataSet; var Accept: Boolean);
begin
  If SameText(strCamBus, 'BAREMB') Then
    Accept := Pos('-' + strCodIte + '-', DataSet.FieldByName(strCamBus).AsString) > 0
  Else If Not fEmptyStr(strCodTin) Then
    Accept := (DataSet.FieldByName('CODTIN').AsString = strCodTin)
  Else
    Accept := (DataSet.FieldByName(strCamBus).AsString = strCodIte)
end;

procedure TfrmFatBaixaEntregaFutura.pCriarCdsSomenteComSubItensEstrutura(blnAbrindoConsulta: Boolean);
begin
  If blnAbrindoConsulta Then
  Begin
    If Assigned(cdsSubProdutos) Then
      FreeAndNil(cdsSubProdutos);

    cdsSubProdutos := TUniClientDataSet.Create(nil);
    cdsSubProdutos.Data := cdsConsulta.Data;
  End;

  Try
    //Remove os sub-produtos do cdsConsulta
    With cdsConsulta Do
    Begin
      DisableControls;
      First;
      While Not Eof Do
      Begin
        If (FieldByName('DET_BXSBIT').AsString = 'S') And
           (FieldByName('DET_PROEMB').AsString = 'S') And
           (FieldByName('DET_INCFUT').AsString <> '') Then
        Begin
          Delete;
        End
        Else If (FieldByName('DET_CLAFIS').AsString = '1999') Then
        Begin
          Delete;
        End
        Else
          Next;
      End;
      First;
      EnableControls;
    End;
    //Remove os produtos que não sub-produtos do cdsSubProdutos
    With cdsSubProdutos Do
    Begin
      DisableControls;
      First;
      While Not Eof Do
      Begin
        If Not ( (FieldByName('DET_BXSBIT').AsString = 'S') And
                 (FieldByName('DET_PROEMB').AsString = 'S') And
                 (FieldByName('DET_INCFUT').AsString <> '') ) Then
        Begin
          Delete;
        End
        Else
          Next;
      End;
      First;
      EnableControls;
    End;
  Except
    On E: Exception Do
    Begin
      cdsConsulta.EnableControls;
      cdsSubProdutos.EnableControls;
      pMensagensErro(E.Message, '');
    End;
  End;

end;

procedure TfrmFatBaixaEntregaFutura.pReprocessarSaldoItensPorDocumento(const strNumDoc, strEspDoc, strCodEmp: string; strLisAut: String='');
begin
  pgbProgresso.Visible  := True;
  tmrInformacao.Enabled := True;
  lblInformacao.Visible := True;
  pgbProgresso.Position := 0;

  strInformacao := 'AGUARDE REPROCESSANDO ESTOQUE PRODUTOS...';
  lblInformacao.Caption := strInformacao;
  Try
    TReprocessarSaldoItem.New
      .AddItensDoDocumento(
         TItensReprocessarDoDocumento.New
           .Documento(strNumDoc)
           .Especie(strEspDoc)
           .Empresa(strCodEmp)
           .ListaAutInc(strLisAut)
         ).ReprocessarSaldoPedidos(pgbProgresso)
          .ReprocessarSaldoEntregaFutura(pgbProgresso);

  Finally
    pgbProgresso.Visible := False;
    tmrInformacao.Enabled := False;
    lblInformacao.Visible := False;
  End;
end;

procedure TfrmFatBaixaEntregaFutura.pRestauraQtdDig;
  Var
    strIndex : String;
begin
  strIndex := cdsConsulta.IndexFieldNames;
  Try
    cdsConsulta.DisableControls;

    try
      cdsConsulta.IndexFieldNames := 'DET_INCREM;TABELA';

      cdsQtdDig.First;
      While Not cdsQtdDig.Eof Do
      Begin

        If cdsConsulta.FindKey([cdsQtdDig.FieldByName('AUX_INCREM').AsString,
                                cdsQtdDig.FieldByName('AUX_TABELA').AsString]) Then
        Begin
          cdsConsulta.Edit;
          cdsConsulta.FieldByName('DET_QTDAEN').AsFloat := cdsQtdDig.FieldByName('AUX_QTDSAV').AsFloat;
          cdsConsulta.FieldByName('DET_QTDANT').AsFloat := cdsQtdDig.FieldByName('AUX_QTDANT').AsFloat;
          cdsConsulta.Post;
        End;

        cdsQtdDig.Next;
      End;
    finally
      cdsConsulta.EnableControls;
    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmFatBaixaEntregaFutura.pRestauraQtdDig]');
    End;
  End;

  cdsConsulta.IndexFieldNames := strIndex;
  blnUtilizaIteRetSaldo := False;
end;

procedure TfrmFatBaixaEntregaFutura.pSalvaQtdDig;
begin
  Try
    cdsConsulta.DisableControls;

    try
      cdsQtdDig.EmptyDataSet;

      cdsConsulta.First;
      While Not cdsConsulta.Eof Do
      Begin

        If (cdsConsulta.FieldByName('DET_QTDAEN').AsFloat > 0) Or (blnValidaMarcarTodos) Then
        Begin
          cdsQtdDig.Append;
          cdsQtdDig.FieldByName('AUX_INCREM').AsString := cdsConsulta.FieldByName('DET_INCREM').AsString;
          cdsQtdDig.FieldByName('AUX_TABELA').AsString := cdsConsulta.FieldByName('TABELA').AsString;
          cdsQtdDig.FieldByName('AUX_QTDSAV').AsFloat  := cdsConsulta.FieldByName('DET_QTDAEN').AsFloat;
          cdsQtdDig.FieldByName('AUX_QTDANT').AsFloat  := cdsConsulta.FieldByName('DET_QTDANT').AsFloat;
          cdsQtdDig.Post;
        End;

        cdsConsulta.Next;
      End;
    finally
      cdsConsulta.EnableControls;
    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmFatBaixaEntregaFutura.pSalvaQtdDig]');
    End;
  End;
end;

procedure TfrmFatBaixaEntregaFutura.pSumarizar(const strNomeCampo: String;
  const summaryKind: TcxSummaryKind; const strFormato: string; const blnFooter,
  blnGroup, blnGroupFooter: Boolean);
begin
  if blnFooter then
  begin
    dbgvDadosItens.Columns[dbgvDadosItens.DataController.GetItemByFieldName(strNomeCampo).Index].Summary.FooterKind := summaryKind;
    dbgvDadosItens.Columns[dbgvDadosItens.DataController.GetItemByFieldName(strNomeCampo).Index].Summary.FooterFormat := strFormato;
  end;

  if blnGroup then
  begin
    dbgvDadosItens.Columns[dbgvDadosItens.DataController.GetItemByFieldName(strNomeCampo).Index].Summary.GroupKind := summaryKind;
    dbgvDadosItens.Columns[dbgvDadosItens.DataController.GetItemByFieldName(strNomeCampo).Index].Summary.GroupFormat := strFormato;
  end;

  if blnGroupFooter then
  begin
    dbgvDadosItens.Columns[dbgvDadosItens.DataController.GetItemByFieldName(strNomeCampo).Index].Summary.GroupFooterKind := summaryKind;
    dbgvDadosItens.Columns[dbgvDadosItens.DataController.GetItemByFieldName(strNomeCampo).Index].Summary.GroupFooterFormat := strFormato;
  end;
end;

procedure TfrmFatBaixaEntregaFutura.pUnLockTodos;
begin
  If (Not cdsConsulta.Active) Or (cdsConsulta.IsEmpty) Then
    Exit;

  cdsConsulta.DisableControls;
  Try
    cdsConsulta.First;
    While Not cdsConsulta.Eof Do
    Begin
      If (cdsConsulta.FieldByName('DET_QTDAEN').AsFloat > 0) Then
      Begin
        objLock.fLock_Unlock('MOVGER' + fChvDoc, False, False);
      End;
      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.First;
    cdsConsulta.EnableControls;
  End;
end;

procedure TfrmFatBaixaEntregaFutura.pLockTodos;
  Var
    frmGravando: TfrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fLockTodos;
    frmGravando.ShowModal;
  Finally
   pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmFatBaixaEntregaFutura.pUnLockTodosConf;
  Var
    intIdx: Integer;
begin
  If (Not cdsConsulta.Active) Or (cdsConsulta.IsEmpty) Then
    Exit;

  //DESTRAVANDO TODOS DOCUMENTOS QUE FORAM CONFIRMADOS
  for intIdx := 0 To stlDocsConf.Count-1 Do
  Begin
    objLock.fLock_Unlock('MOVGER' + stlDocsConf[intIdx], False, False);
  End;
end;

function TfrmFatBaixaEntregaFutura.fLockTodos(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    ST,
    SX: TStringList;
    strLis: String;
begin
  Result := True;

  If (Not cdsConsulta.Active) Or (cdsConsulta.IsEmpty) Then
    Exit;
    
  pInformacao('Aguarde... Bloqueando documentos!', pgbStatus);
  cdsConsulta.DisableControls;
  Try
    ST := TStringList.Create;
    SX := TStringList.Create;
    strLis := '';
    cdsConsulta.First;
    While Not cdsConsulta.Eof Do
    Begin
      pProgresso(cdsConsulta.RecNo, cdsConsulta.RecordCount, pgbStatus);
      If (cdsConsulta.FieldByName('DET_QTDAEN').AsFloat > 0) Then
      Begin
        If (ST.IndexOf(fChvDoc) = -1) Then
        Begin
          If (Not objLock.fLock_Unlock('MOVGER' + fChvDoc, True, False)) Then
          Begin
            strLis := strLis + fChvDoc(True)+' '+fGetHostLock('MOVGER' + fChvDoc) + #13#10; //TEXTO DE MSG DOS PROTUDOS TRAVADOS
            SX.Add(fChvDoc);                                                                //CHAVE DOS PROTUDOS TRAVADOS
          End;
          ST.Add(fChvDoc); //DOCUMENTOS JÁ TESTADOS SE PUDERAM SER TRAVADOS OU NÃO; 
        End;
      End;
      cdsConsulta.Next;
    End;

    If Not strLis.IsEmpty Then
    Begin
      //DESMARCAR TODOS OS PRODUTOS DOS DOCMENTOS QUE NÃO PUDERAM SER TRAVADOS
      cdsConsulta.First;
      While Not cdsConsulta.Eof Do
      Begin
        If (cdsConsulta.FieldByName('DET_QTDAEN').AsFloat > 0) Then
        Begin
          If (SX.IndexOf(fChvDoc) > -1) Then
          Begin
            cdsConsulta.Edit;
            cdsConsulta.FieldByName('DET_QTDANT').AsFloat := 0;
            cdsConsulta.FieldByName('DET_QTDAEN').AsFloat := 0; 
            cdsConsulta.Post;

            SX.Add(fChvDoc);
          End;
        End;
        cdsConsulta.Next;
      End;
    
      fMensagem('Atenção', 'Os seguintes documentos estão sendo utilizados por outras estações:'+#13#10+strLis,['&Ok'],
                           1,False,1,0,False,0,False,False,False,0,0,SX.Count);
    End;
  Finally
    cdsConsulta.First;
    cdsConsulta.EnableControls;
    FreeAndNil(SX);
    FreeAndNil(ST);
  End;
end;

procedure TfrmFatBaixaEntregaFutura.tmrInformacaoTimer(Sender: TObject);
begin
  inherited;
  If lblInformacao.Caption <> '' Then
    lblInformacao.Caption := ''
  Else
    lblInformacao.Caption := strInformacao;
  Application.ProcessMessages;    
end;

{********************************************}
{* CASO SEJA BAIXA DE ENTREGA FUTURA MANTER *}
{* O FOCO SEMPRE NO CODIGO DE ITEM.         *}
{*****************************************PZ*}
procedure TfrmFatBaixaEntregaFutura.pControlaFoco;
begin

  If (edtQtdIte.Visible) And
     (Not fCheckParent(ActiveControl, pnlHeader)) And
     (Not fCheckParent(ActiveControl, pnlPesquisa)) And
     (Not fCheckParent(ActiveControl, pnlTail)) Then
    pSetFocus(edtCodIte);

end;

procedure TfrmFatBaixaEntregaFutura.pCriaClientCdsQtdDig;
begin
  cdsQtdDig := TUniClientDataSet.Create(Self);

  With cdsQtdDig.FieldDefs.AddFieldDef Do
  Begin
    Name := 'AUX_INCREM';
    DataType := ftString;
    Size := 50;
    Required := False;
  End;

  With cdsQtdDig.FieldDefs.AddFieldDef Do
  Begin
    Name := 'AUX_TABELA';
    DataType := ftString;
    Size := 50;
    Required := False;
  End;

  With cdsQtdDig.FieldDefs.AddFieldDef Do
  Begin
    Name := 'AUX_QTDSAV';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsQtdDig.FieldDefs.AddFieldDef Do
  Begin
    Name := 'AUX_QTDANT';
    DataType := ftFloat;
    Required := False;
  End;

  cdsQtdDig.CreateDataSet;
  cdsQtdDig.IndexFieldNames := 'AUX_INCREM;AUX_TABELA';
end;

Function TfrmFatBaixaEntregaFutura.fTravaBaixa: Boolean;
  Var
    strTrava: String;
Begin
  // DESTRAVA ANTERIOR SE HOUVER
  objLock.pDestravarTodos;

  If Not fEmptyStr(edtCodCliente.Text) Then
  Begin
    If (blnSepFut) Then
      strTrava := 'SEP_ENTFUT_'
    Else
      strTrava := 'BAIXA_ENTFUT_';

    Result := objLock.fLock_Unlock(strTrava + edtCodCliente.Text, True, False);
    If Not Result Then
    Begin
      fMensagem('ATENÇÃO!', 'Este cliente já está sendo utilizado por outra estação: ' +
                 fGetHostLock(strTrava + edtCodCliente.Text), ['&Ok']);
    End;
  End

  Else Result := True;
End;

function TfrmFatBaixaEntregaFutura.fTravaDocumentosComProducaoForaDeLoja: Boolean;
var
  cdsDados: TUniClientDataSet;
  strProducaoForaDeLoja: String;
begin
  cdsDados := TUniClientDataSet.Create(Nil);

  try
    Result := False;

    pCloneDataSet(cdsDados, cdsConsulta);

    cdsDados.Filtered := False;
    cdsDados.Filter := ' DET_QTDAEN > 0 ';
    cdsDados.Filtered := True;

    if cdsDados.RecordCount <= 1 then
      Exit;

    cdsDados.First;

    strProducaoForaDeLoja := IfEmptyStr(cdsDados.FieldByName('GER_OPRFLJ').AsString, 'N');

    cdsDados.Next;

    while not cdsDados.Eof do
    begin
      if (IfEmptyStr(cdsDados.FieldByName('GER_OPRFLJ').AsString, 'N') <> strProducaoForaDeLoja) then
      begin
        fMensagem('ATENÇÃO!', 'Não é permitido selecionar produto de um documento com produção fora de loja com outro que não seja.', ['&Ok']);
        Result := True;
        Exit;
      end;

      cdsDados.Next;
    end;
  finally
    FreeAndNil(cdsDados);
  end;
end;

function TfrmFatBaixaEntregaFutura.fValidaTravaDevolucaoClienteComIES(): Boolean;
var
  objLiberacao: TLiberacao;

  function fTemDevolucaoDeNF():Boolean;
  var
    cdsDados: TUniClientDataSet;
  begin
    cdsDados := TUniClientDataSet.Create(Self);

    Try
      cdsDados.Data := cdsConsulta.Data;
      cdsDados.LogChanges := False;

      cdsDados.Filter   := '(GER_ESPDOC = ' + QuotedStr('NF') + ') AND (QTDDEV > 0)';
      cdsDados.Filtered := True;

      Result := (cdsDados.RecordCount > 0);
    Finally
      FreeAndNil(cdsDados);
    End;
  end;
begin
  Result := True;

  If FblnTemDevolucao And fTemDevolucaoDeNF() Then
  Begin
    objLiberacao := TLiberacao.Create;
    Try
      If (fPessoaJuridicaComIES(edtCodCliente.Text)) Then
      Begin
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddTexto('Não é permitido emitir devolução para pessoa jurídica com inscrição estadual cadastrada.');

        objLiberacao.strDirAce := 'DEVPJ';
        objLiberacao.strSenLib := fCfgSis('SEDVPJ');
        objLiberacao.strMsgSen := 'Devolução Para Pessoa Jurídica';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.strCliente := edtCodCliente.Text + '-' + edtDesCliente.Text;
        objLiberacao.strCpfCnpj := fRetCgcCpf(edtCodCliente.Text);

        Result := objLiberacao.fLibera();
      End;
    Finally
      FreeAndNil(objLiberacao);
    End;
  End;
end;

function TfrmFatBaixaEntregaFutura.fTravaNotaVendaAutorizada: Boolean;
var
  qryAux    : TUniQuery;
  intRecNo  : Integer;
begin
  Result   := False;
  intRecNo := cdsConsulta.RecNo;

  if not fCfgSis('TRABEF', varBoolean) then
    Exit;

  Try
    cdsConsulta.DisableControls;
    cdsConsulta.First;
    While Not cdsConsulta.Eof Do
    Begin
      If (cdsConsulta.FieldByName('DET_QTDAEN').AsFloat > 0) Then
      Begin
        qryAux := fCriaQuery;
        try
          qryAux.SQL.Add('SELECT NFE_STATUS FROM LOGNFE WHERE ');
          qryAux.SQL.Add('  NFE_NUMDOC = :NUMDOC AND ');
          qryAux.SQL.Add('  NFE_ESPDOC = :ESPDOC AND ');
          qryAux.SQL.Add('  NFE_CODEMP = :CODEMP AND ');
          qryAux.SQL.Add('  NFE_CODCLI = :CODCLI AND ');
          qryAux.SQL.Add('  IFNULL(NFE_SERIE_, "") = :SERIE_ AND ');
          qryAux.SQL.Add('  NFE_TIP_FC = :TIP_FC ');

          qryAux.ParamByName('NUMDOC').AsString := cdsConsulta.FieldByName('DET_NUMDOC').AsString;
          qryAux.ParamByName('ESPDOC').AsString := cdsConsulta.FieldByName('DET_ESPDOC').AsString;
          qryAux.ParamByName('CODEMP').AsString := cdsConsulta.FieldByName('DET_CODEMP').AsString;
          qryAux.ParamByName('CODCLI').AsString := cdsConsulta.FieldByName('DET_CODCLI').AsString;
          qryAux.ParamByName('SERIE_').AsString := cdsConsulta.FieldByName('DET_SERIE_').AsString;
          qryAux.ParamByName('TIP_FC').AsString := cdsConsulta.FieldByName('DET_TIP_FC').AsString;
          qryAux.Open;

          if qryAux.IsEmpty then
            Result := False
          else
            Result := (qryAux.FieldByName('NFE_STATUS').AsString <> 'AT');

          if Result then
          begin
            fMensagem('ATENÇÃO!',
                    'A nota fiscal de venda ainda não foi autorizada no documento: ' + #10+#13 +
                    cdsConsulta.FieldByName('DET_NUMDOC').AsString + '-' +
                    cdsConsulta.FieldByName('DET_ESPDOC').AsString + '-' +
                    cdsConsulta.FieldByName('DET_CODEMP').AsString,
                    ['&Ok']);
            Exit;
          End;
        finally
          FreeAndNil(qryAux);
        end;
      End;

      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.RecNo := intRecNo;
    cdsConsulta.EnableControls;
  End;
end;

procedure TfrmFatBaixaEntregaFutura.pCalcularTotais;
begin
  fltTotEnt := 0;
  fltTotPes := 0;
  fltTotDev := 0;

  With cdsAux Do
  Begin
    If Not Active Then
      Exit;

    Filter := 'DET_QTDAEN > 0 OR QTDDEV > 0 ';
    Filtered := True;
    First;

    While Not Eof Do
    Begin
      fltTotEnt := fltTotEnt + FieldByName('DET_QTDAEN').AsFloat + FieldByName('QTDDEV').AsFloat;
      fltTotDev := fltTotDev + FieldByName('QTDDEV').AsFloat;

      fltTotPes := fltTotPes + FieldByName('DET_TOTPES').AsFloat /
                               FieldByName('DET_QTDITE').AsFloat *
                               FieldByName('DET_QTDAEN').AsFloat;
      Next;
    End;

    Filtered := False;
  End;

  edtTotalPeso.Text := FormatFloat('#,##0.00', fltTotPes);

end;

function TfrmFatBaixaEntregaFutura.fVerificaDocumentoAbastecimentoPeloDeposito: Boolean;
var
  strCodEmpPrimeiroDocumento: string;
  strNumDocPrimeiroDocumento: String;
  strEspDocPrimeiroDocumento: String;
  strCodEmp: string;
  strNumDoc: String;
  strEspDoc: String;
  blnEhAbastecimentoPrimeiroDocumento: Boolean;
  blnEhAbastecimento: Boolean;
  cdsDados: TUniClientDataSet;
begin
  Result := True;

  cdsDados := TUniClientDataSet.Create(nil);

  try
    pCloneDataSet(cdsDados, cdsAux);

    cdsDados.Filtered := False;
    cdsDados.Filter := ' DET_QTDAEN > 0 ';
    cdsDados.Filtered := True;

    if cdsDados.IsEmpty then
      Exit;

    cdsDados.First;

    strCodEmpPrimeiroDocumento := cdsDados.FieldByName('GER_CODEMP').AsString;
    strNumDocPrimeiroDocumento := cdsDados.FieldByName('GER_NUMDOC').AsString;
    strEspDocPrimeiroDocumento := cdsDados.FieldByName('GER_ESPDOC').AsString;

    blnEhAbastecimentoPrimeiroDocumento := cdsDados.FieldByName('AUX_ABADEP').AsString = 'S';

    while not cdsDados.Eof do
    begin
      strCodEmp := cdsDados.FieldByName('GER_CODEMP').AsString;
      strNumDoc := cdsDados.FieldByName('GER_NUMDOC').AsString;
      strEspDoc := cdsDados.FieldByName('GER_ESPDOC').AsString;

      blnEhAbastecimento := cdsDados.FieldByName('AUX_ABADEP').AsString = 'S';

      if blnEhAbastecimentoPrimeiroDocumento <> blnEhAbastecimento then
      begin
        pMostraMensagemTravaAbastecimentoPeloDeposito(strCodEmpPrimeiroDocumento,
                                                      strCodEmp,
                                                      strNumDocPrimeiroDocumento,
                                                      strNumDoc,
                                                      strEspDocPrimeiroDocumento,
                                                      strEspDoc);
        Result := False;
        Exit;
      end;
      cdsDados.Next;
    end;

  finally
    FreeAndNil(cdsDados);
  end;
end;

function TfrmFatBaixaEntregaFutura.fVerificaDocumentosEmpresaCdELogada: Boolean;
var
  strCodEmp: string;
  strNumDoc: String;
  strEspDoc: String;
  cdsDados    : TUniClientDataSet;
begin
  Result := True;

  cdsDados := TUniClientDataSet.Create(nil);

  try
    pCloneDataSet(cdsDados, cdsAux);

    cdsDados.Filter := ' DET_QTDAEN > 0 ';
    cdsDados.Filtered := True;
    cdsDados.First;

    if cdsDados.IsEmpty then
      Exit;

    strCodEmp := cdsConsulta.FieldByName('GER_CODEMP').AsString;
    strNumDoc := cdsConsulta.FieldByName('GER_NUMDOC').AsString;
    strEspDoc := cdsConsulta.FieldByName('GER_ESPDOC').AsString;

    while not cdsDados.Eof do
    begin
      if strCodEmp <> cdsDados.FieldByName('GER_CODEMP').AsString then
      begin
        pMostraMensagemTravaEmpresasDistintas(strCodEmp,
                                              cdsDados.FieldByName('GER_CODEMP').AsString,
                                              strNumDoc,
                                              cdsDados.FieldByName('GER_NUMDOC').AsString,
                                              strEspDoc,
                                              cdsDados.FieldByName('GER_ESPDOC').AsString);
        Result := False;
        Exit;
      end;
      cdsDados.Next;
    end;
  finally
    FreeAndNil(cdsDados);
  end;
end;

function TfrmFatBaixaEntregaFutura.fVerificaParamEntregaFuturaDocSelec(Const strEntFutOpc: String): Boolean;
begin
  Result := True;

  If Not cdsAux.Active Then
    Exit;

  Try
    cdsAux.Filter   := 'DET_QTDAEN > 0';
    cdsAux.Filtered := True;

    cdsAux.First;
    While Not cdsAux.Eof Do
    Begin
      If cdsAux.FieldByName('AUX_ENFUOP').AsString <> strEntFutOpc Then
      Begin
        Result := False;
        Break;
      End;
      cdsAux.Next;
    End;
  Finally
    cdsAux.Filtered := False;
    cdsAux.Filter := EmptyStr;
  End;
end;

function TfrmFatBaixaEntregaFutura.fVerificaFazendaDocSelec(Const strCodFaz: String): Boolean;
begin
  Result := True;

  If Not cdsAux.Active Then
    Exit;

  Try
    cdsAux.Filter   := 'DET_QTDAEN > 0';
    cdsAux.Filtered := True;

    cdsAux.First;
    While Not cdsAux.Eof Do
    Begin
      If cdsAux.FieldByName('AUX_CODFAZ').AsString <> strCodFaz Then
      Begin
        Result := False;
        Break;
      End;
      cdsAux.Next;
    End;
  Finally
    cdsAux.Filtered := False;
    cdsAux.Filter := EmptyStr;
  End;
end;

function TfrmFatBaixaEntregaFutura.fVerificaQtdEstoque( fltSaldos: Double;
                                                        fltQtdIte: Double;
                                                    Var strSemEst: String;
                                                        blnComSenha: Boolean;
                                                    Var blnPedSen: Boolean;
                                                    Var blnSemEst: Boolean;
                                                        recTinFor: TForTin;
                                                        fltSaldosSemLote: Double = 0;
                                                        strMotFutAConsiderar: String = '' ): Boolean;

  Var
    fltSaldosAux: Double;
    strMotFutAConsiderarAux: String;

  function fValidaEstoqueLocal(fltSaldosPar: Double; strNumLotPar: String; strMotFutAConsiderarPar: String=''): Boolean;
  begin
    With cdsConsulta Do
      Result := fatVenda.fVerificaQtdEstoque(VS_strCodEmp,
                                             'VN',
                                             'S',
                                             '',
                                             '',
                                             FieldByName('DET_CODITE').AsString,
                                             FieldByName('DET_CODACA').AsString,
                                             FieldByName('DET_EMPACA').AsString,
                                             FieldByName('DET_DESCRI').AsString,
                                             '',
                                             'S',
                                             FieldByName('DET_MOTFUT').AsString,
                                             fltQtdIte,
                                             fRetQtdDigitada(FieldByName('DET_CODITE').AsString, strNumLotPar, strMotFutAConsiderarPar),
                                             FieldByName('DET_QTDANT').AsFloat,
                                             fltSaldosPar,
                                             True,
                                             strSemEst,
                                             blnComSenha,
                                             blnPedSen,
                                             blnSemEst,
                                             recTinFor,
                                             False,
                                             strNumLotPar,
                                             True,
                                             '',
                                             IIF(fatVenda.fEmpCarPreenchidaEmpDif(FieldByName('DET_EMPCAR').AsString, FieldByName('DET_CODEMP').AsString), FieldByName('DET_EMPCAR').AsString, ''),
                                             strMotFutAConsiderarPar);
  end;
                                                        
begin
  //Se for o item principal vamos validar o estoque dos subprodutos
  If (fCfgSis('EFTEST') = '2') And (fCfgSis('EFTESE') = '1') Then
    If Assigned(cdsSubProdutos) And cdsSubProdutos.Locate('DET_INCFUT', cdsConsulta.FieldByName('AUTOINCREM').AsString, []) Then
  Begin
    Result := True;
    pAtualizarQuantidadeSubItens(cdsConsulta.FieldByName('AUTOINCREM').AsString,
                                 cdsConsulta.FieldByName('DET_QTDITE').AsFloat, fltQtdIte, 0);
    Try
      cdsSubProdutos.Filtered := False;
      cdsSubProdutos.Filter   := 'DET_INCFUT = ' + QuotedStr(cdsConsulta.FieldByName('AUTOINCREM').AsString);
      cdsSubProdutos.Filtered := True;

      pAcertaSaldoDisponivel(cdsSubProdutos);

      With cdsSubProdutos Do
      Begin
        First;
        While Not Eof Do
        Begin
          Result := fatVenda.fVerificaQtdEstoque(VS_strCodEmp,
                                                 'VN',
                                                 'S',
                                                 '',
                                                 '',
                                                 FieldByName('DET_CODITE').AsString,
                                                 FieldByName('DET_CODACA').AsString,
                                                 FieldByName('DET_EMPACA').AsString,
                                                 FieldByName('DET_DESCRI').AsString,
                                                 '',
                                                 'S',
                                                 FieldByName('DET_MOTFUT').AsString,
                                                 FieldByName('DET_QTDAEN').AsFloat,
                                                 0,
                                                 0,
                                                 FieldByName('ITE_SALDOS').AsFloat,
                                                 True,
                                                 strSemEst,
                                                 blnComSenha,
                                                 blnPedSen,
                                                 blnSemEst,
                                                 recTinFor,
                                                 False,
                                                 FieldByName('DET_NUMLOT').AsString);
          If Not Result Then
            Break;
          Next;
        End;
      End;
    Finally
      cdsSubProdutos.Filtered := False;
    End;
    Exit;
  End;

  If (Not fEmptyStr(strMotFutAConsiderar)) And 
     ((cdsConsulta.FieldByName('LOTANT').AsString = 'A DEFINIR') And (IfEmptyStr(cdsConsulta.FieldByName('DET_NUMLOT').AsString, 'A DEFINIR') <> cdsConsulta.FieldByName('LOTANT').AsString)) Then
  Begin
    Result := fValidaEstoqueLocal(fltSaldosSemLote, '', strMotFutAConsiderar);

    If Result Then
      Result := fValidaEstoqueLocal(fltSaldos, cdsConsulta.FieldByName('DET_NUMLOT').AsString, strMotFutAConsiderar);
  End
  Else
  Begin
    fltSaldosAux := fltSaldos;
    strMotFutAConsiderarAux := '';
    If MatchStr(fCfgSis('CALSAL', varString), ['3', '4', '5']) then
    Begin
      strMotFutAConsiderarAux := strMotFutAConsiderar;

      If (Not fEmptyStr(strMotFutAConsiderarAux)) Then
        fltSaldosAux := fltSaldosSemLote
      Else
        strMotFutAConsiderarAux := cdsConsulta.FieldByName('DET_MOTFUT').AsString;
    End;

    Result := fValidaEstoqueLocal(fltSaldosAux, cdsConsulta.FieldByName('DET_NUMLOT').AsString, strMotFutAConsiderarAux);
  End;
end;

procedure TfrmFatBaixaEntregaFutura.pNotificarRoboParaReprocessarSaldos;
begin
  objReprocessarSaldoItens.NotificarRoboParaReprocessarSaldos;
  objReprocessarSaldoItens.Clear;
end;

procedure TfrmFatBaixaEntregaFutura.pMarcaTodosProdutosQuePodemSerAtendidos;
  Var
    strSemEst: String;
    blnSemEst: Boolean;
    blnPedSen: Boolean;
    recTinFor: TForTin;
    fltQtdIte: Double;
    fltSaldos: Double;
    fltSaldosSemLote: Double;
    strMotFutAConsiderar: String;
    stlItensLote:TStringList;
begin
  Try
    With cdsConsulta Do
    Begin
      DisableControls;
      blnTestarPost := Not blnSepFut;
      Screen.Cursor := crHourGlass;
      pgbProgresso.Visible  := True;
      pgbProgresso.Properties.Max := RecordCount;
      lblInformacao.Visible := True;
      tmrInformacao.Enabled := True;

      stlItensLote := TStringList.Create;

      First;
      While Not Eof Do
      Begin
        If Not fPodeAlterarQuantidadeAEntregar Then
          Exit;
        Next;
      End;

      First;

      strInformacao := 'AGUARDE ZERANDO QUANTIDADE A ENTREGAR...';

      While Not Eof Do
      Begin
        pgbProgresso.Position := RecNo;
        Application.ProcessMessages;

        Edit;
        FieldByName('DET_QTDAEN').AsFloat := 0;
        Post;
        Next;
      End;

      First;

      strInformacao := 'AGUARDE DEFININDO QUANTIDADE A ENTREGAR...';

      While Not Eof Do
      Begin
        fltQtdIte := 0;
        blnComSenha := False;

        pgbProgresso.Position := RecNo;
        Application.ProcessMessages;

        If (Not blnUtiWms) And (SameText(cdsConsulta.FieldByName('DET_NUMLOT').AsString, 'A DEFINIR')) And (fEmptyStr(strCodCliConsulta)) And (Not blnSepFut) Then
        Begin
          stlItensLote.Add(cdsConsulta.FieldByName('PEDVEN').AsString + ' - ' + cdsConsulta.FieldByName('DET_CODITE').AsString + '-' + cdsConsulta.FieldByName('DET_DESCRI').AsString);
          cdsConsulta.Next;
          Continue;
        End;

        fatVenda.strIdePro := FieldByName('DET_IDEPRO').AsString;

        If (fatVenda.strIdePro <> 'NOR') Then
          fltQtdIte := FieldByName('DET_QTDPEN').AsFloat
        Else
        Begin
          fltSaldos := 0.0;
          fltSaldosSemLote := 0.0;

          pProcessaSaldoDisponivel(fltSaldos, fltSaldosSemLote, strMotFutAConsiderar);

          If fVerificaQtdEstoque(fltSaldos,
                                 IIF(blnSepFut, FieldByName('PENSEP').AsFloat, FieldByName('DET_QTDPEN').AsFloat),
                                 strSemEst,
                                 blnComSenha,
                                 blnPedSen,
                                 blnSemEst,
                                 recTinFor,
                                 fltSaldosSemLote,
                                 strMotFutAConsiderar) And (Not blnSemEst) Then
          Begin
            fltQtdIte := IIF(blnSepFut, FieldByName('PENSEP').AsFloat, FieldByName('DET_QTDPEN').AsFloat);
          End
          Else
          Begin
            If fatVenda.fltSaldoDisponivelItem >= IIF(blnSepFut, FieldByName('PENSEP').AsFloat, FieldByName('DET_QTDPEN').AsFloat) Then
              fltQtdIte := IIF(blnSepFut, FieldByName('PENSEP').AsFloat, FieldByName('DET_QTDPEN').AsFloat)

            Else If fatVenda.fltSaldoDisponivelItem > 0 Then
              fltQtdIte := fatVenda.fltSaldoDisponivelItem;
          End;

        End;

        If fltQtdIte > 0 Then
        Begin
          Try
            Edit;
            FieldByName('DET_QTDAEN').AsFloat := fltQtdIte;
            FieldByName('DET_QTDANT').AsFloat := fltQtdIte;
            Post;
          Except
            On E: EAbort Do
            Begin
              Next;
              Continue;
            End;
          End;
        End;

        Next;
      End;

      First;
    End;

    If (stlItensLote.Count > 0) Then
      pMensagemOk('ATENÇÃO!!! ' + #10+#13 +
                  'Os itens listados abaixo, possuem lote e não podem ser marcados pela opção "Marcar Todos". ' + #10+#13 +
                  'Favor selecionar o item no grid e informar as quantidades item a item, na coluna "Qt. Entregar" ' +
                  'para informar o lote da baixa corretamente.' + #10+#13 +
                  stlItensLote.Text)

  Finally
    blnComSenha := True;
    blnTestarPost := True;
    Screen.Cursor := crDefault;
    pgbProgresso.Visible := False;
    lblInformacao.Visible := False;
    tmrInformacao.Enabled := False;    
    cdsConsulta.EnableControls;
    FreeAndNil(stlItensLote);
  End;

end;

procedure TfrmFatBaixaEntregaFutura.pMostraMensagemTravaAbastecimentoPeloDeposito(
  strCodEmpDoc1, strCodEmpDoc2, strNumDoc1, strNumDoc2, strEspDoc1,
  strEspDoc2: String);
var
  strMensagem: String;
begin
  strMensagem := 'Atenção! Não é permitido selecionar documento de abastecimento pelo deposito com outro que não seja.' + sLineBreak +
                 'Documentos selecionados:' + sLineBreak + sLineBreak +
                 strEspDoc1 + ' ' + strNumDoc1 + ' - Empresa: ' + strCodEmpDoc1 + sLineBreak +
                 strEspDoc2 + ' ' + strNumDoc2 + ' - Empresa: ' + strCodEmpDoc2;

  pMensagemOk(strMensagem, 550);
end;

procedure TfrmFatBaixaEntregaFutura.pMostraMensagemTravaEmpresasDistintas(
  strCodEmpDoc1, strCodEmpDoc2, strNumDoc1, strNumDoc2, strEspDoc1, strEspDoc2: String);
var
  strMensagem: String;
begin
  If fCfgSis('FATSSA', varBoolean) Then
  Begin
    strMensagem := 'Atenção! Não é permitido selecionar documento(s) de lojas diferentes para baixa.' + sLineBreak +
                   'Documentos selecionados:' + sLineBreak + sLineBreak +
                   strEspDoc1 + ' ' + strNumDoc1 + ' - Empresa: ' + strCodEmpDoc1 + sLineBreak +
                   strEspDoc2 + ' ' + strNumDoc2 + ' - Empresa: ' + strCodEmpDoc2;
  End
  Else
  Begin
    strMensagem := 'Não é permitido selecionar documento da loja logada e da loja CD ao mesmo tempo para baixa!';
  End;

  pMensagemOk(strMensagem, 550);
end;

procedure TfrmFatBaixaEntregaFutura.pMostraTravaGrupoFreteDiferente;
var
  strMensagem: string;
  frmObservacaoLocal: TfrmObservacao;
begin
  strMensagem := 'ATENÇÃO! O sistema está configurado para considerar o tipo do frete do documento na geração do crédito do contas a receber' +sLineBreak+
                 'da devolução (CFG_FRDVES). Sendo assim, não é permitido selecionar documentos com tipo de frete diferentes. Neste caso, será'+sLineBreak+
                 'preciso fazer duas devoluções.'+sLineBreak+sLineBreak+
                 'Documentos selecionados:'+sLineBreak;

  cdsConsulta.First;

  while not cdsConsulta.Eof do
  begin
    if cdsConsulta.FieldByName('QTDDEV').AsFloat > 0 then
    begin
      strMensagem := strMensagem + sLineBreak + cdsConsulta.FieldByName('GER_NUMDOC').AsString +' - '+ cdsConsulta.FieldByName('GER_ESPDOC').AsString +' - '+ cdsConsulta.FieldByName('GER_CODEMP').AsString +' - Tipo de Frete: '+ fDescricaoFrete(cdsConsulta.FieldByName('GER_TIPFRE').AsString);
    end;
    cdsConsulta.Next;
  end;

  pCriarFormularios(TfrmObservacao, frmObservacaoLocal);

  try
    frmObservacaoLocal.lblMensagem.caption := 'Trava Frete';
    frmObservacaoLocal.memObs.Texto := strMensagem;
    frmObservacaoLocal.ShowModal;
  finally
    pFreeAndNil(frmObservacaoLocal);
  end;

end;

Function TfrmFatBaixaEntregaFutura.fPermiteBaixa: Boolean;
  Var
    strItens         : String;
    LobjLiberacao    : TLiberacao;
    LobjTabela       : TRegistroMsgLiberaTabela;
    LobjLinha        : TLinhaMsgLibera;

  Function fPermiteBaixaProduto(strAutInc, strTabela : String) : Boolean;
    Var
      qryTmp : TUniQuery;
  Begin
    qryTmp := fCriaQuery(Self);

    With qryTmp Do
    Begin
      SQL.Clear;
      SQL.Add('SELECT                                                              ');
      SQL.Add(fSQLQtdEnt(strTabela) + ' AS DET_QTDENT,                             ');
      SQL.Add('  ROUND(IFNULL('+strTabela+'.DET_QTDITE,0) - '+fSQLQtdEnt(strTabela)+', 4) DET_QTDAEN ');
      SQL.Add('FROM                                                                ');
      SQL.Add('  '+strTabela+'                                                     ');
      SQL.Add(TSqlEF.SQLJoinEFPedido(strTabela, True {Esta na baixa de entrega Futura}));
      SQL.Add('WHERE '+strTabela+'.AUTOINCREM = :AUTINC                            ');
      ParamByName('AUTINC').AsString := strAutInc;
      Open;

      Result := (fFormataFloat(FieldByName('DET_QTDAEN').AsFloat, 4) >= fFormataFloat(cdsConsulta.FieldByName('DET_QTDAEN').AsFloat, 4));

      If Result Then
        Result := Not (fFormataFloat(FieldByName('DET_QTDENT').AsFloat, 4) <> fFormataFloat(cdsConsulta.FieldByName('DET_QTDENT').AsFloat + cdsConsulta.FieldByName('QTDFUT').AsFloat, 4));

      Close;
    End;

    FreeAndNil(qryTmp);
  End;
begin
  Result := True;

  FblnTemDevolucao := False;
  FblnTemEntrega   := False;
  blnEscolheuFechamentoEmPedido := False;
  
  LobjLiberacao    := TLiberacao.Create;    
  LobjTabela       := TRegistroMsgLiberaTabela.Create;

  Try
    cdsConsulta.First;
    While Not cdsConsulta.Eof Do
    Begin

      If (fFormataFloat(cdsConsulta.FieldByName('DET_QTDAEN').AsFloat, 4) > 0) Then
      Begin
        If (Not blnUtiWms) And (SameText(cdsConsulta.FieldByName('DET_NUMLOT').AsString, 'A DEFINIR')) Then
        Begin
          pMensagemOk('É obrigatório informar um ' + objCadLot.strTitLab + ' válido para o item '+
                      cdsConsulta.FieldByName('DET_CODITE').AsString +'-'+ cdsConsulta.FieldByName('DET_DESCRI').AsString);
          Exit(False);
        End;

        If Not fPermiteBaixaProduto(cdsConsulta.FieldByName('AUTOINCREM').AsString,
                                    cdsConsulta.FieldByName('TABELA').AsString) Then
        Begin
          strItens := strItens + 'Doc: '     + cdsConsulta.FieldByName('DET_NUMDOC').AsString +
                                 ' - Esp: '  + cdsConsulta.FieldByName('DET_ESPDOC').AsString +
                                 ' - Emp: '  + cdsConsulta.FieldByName('DET_CODEMP').AsString +
                                 ' - Item: ' + cdsConsulta.FieldByName('DET_CODITE').AsString + Chr(13);

          Result := False;
        End;

        FblnTemEntrega := True;
      End;

      if fPermiteDevolverProdutos(cdsConsulta.FieldByName('DET_CODEMP').AsString, cdsConsulta.FieldByName('QTDDEV').AsFloat) then
      Begin
        if not FblnTemDevolucao then
        Begin
          if fMensagem('Atenção', 'Foi informado quantidade a devolver. O sistema irá emitir automaticamente '+
          'o documento de baixa de entrega futura e de devolução. Deseja continuar?', ['&Sim', '&Não']) = 2 then
          Begin
            Exit(False);
          End
          Else
          Begin
            FblnTemDevolucao := True;

            LobjLiberacao.strDirAce  := 'PERDEVENTF';
            LobjLiberacao.strMsgSen  := 'Permitir emitir devolução na Baixa de Entrega Futura';
            LobjLiberacao.strCodOpe  := strLoginUsuarioLogado;
            LobjLiberacao.objMsgLibera.pAddTexto('PERMITIR EMITIR DEVOLUÇÃO NA BAIXA DE ENTREGA FUTURA', alEsquerda);
            LobjLiberacao.objMsgLibera.pAddTexto('', alEsquerda);
            LobjLiberacao.objMsgLibera.pAddTexto('Cliente  '+edtCodCliente.Text+'-'+edtDesCliente.Text, alEsquerda);
            LobjLiberacao.objMsgLibera.pAddTexto('', alEsquerda);

            LobjLinha := TLinhaMsgLibera.Create;
            LobjLinha.enuTipoLinha := tlCabecalho;
            LobjLinha.pAddColuna('', 'PRODUTO'   , 12 , alCentro   , teAutcom);
            LobjLinha.pAddColuna('', 'DESCRIÇÃO' , 50 , alEsquerda , teAutcom);
            LobjLinha.pAddColuna('', 'QUANTIDADE', 14 , alDireita  , teAutcom);
            LobjTabela.lstLinhas.Add(LobjLinha);
          End;
        End;

        LobjLinha              := TLinhaMsgLibera.Create;
        LobjLinha.enuTipoLinha := tlValor;
        LobjLinha.pAddColuna('PRODUTO:'   , cdsConsulta.FieldByName('CODITE').AsString, 12 , alCentro , teAmbos);
        LobjLinha.pAddColuna('PRODUTO:'   , cdsConsulta.FieldByName('DET_DESCRI').AsString, 50 , alEsquerda , teAmbos);
        LobjLinha.pAddColuna('QUANTIDADE:', FormatFloat('###,###,##0.00', cdsConsulta.FieldByName('QTDDEV').AsFloat), 14 , alDireita , teAmbos);
        LobjTabela.lstLinhas.Add(LobjLinha);
      End;

      cdsConsulta.Next;
    End;

    If Not Result Then
    Begin
      Try
        pCriarFormularios(TfrmObservacao, frmObservacao);
        frmObservacao.lblMensagem.Caption := 'Itens com baixa efetuada por outra estação de trabalho! Atualizar Dados!';
        frmObservacao.memObs.Texto := strItens;
        frmObservacao.ShowModal;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[fPermiteBaixa]');
      End;
      pFreeAndNil(frmObservacao);
    End
    Else
    Begin
      if FblnTemDevolucao then
      Begin
        LobjLiberacao.objMsgLibera.lstRegistros.Add(LobjTabela);    
        Result := LobjLiberacao.fLibera;
      end;
    End;
  Finally
    FreeAndNil(LobjLiberacao);    
  End;
end;

function TfrmFatBaixaEntregaFutura.fPermiteGravacaoImpressao: Boolean;
begin
  Result:=True;

  If ((Not cdsConsulta.Active) Or (cdsConsulta.IsEmpty)) Then
  Begin
    pMensagemOk('É necessário selecionar pelo menos um registro!');
    Result:=False;
    Exit;
  End;

  If (fltTotEnt <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe a quantidade a ser entregue!', ['&Ok']);
    Result:=False;
    Exit;
  End;

  If (Not fTestaEstoque) Then
  Begin
    Result:=False;
    Exit;
  End;

  If (Not fEhMesmoGrupoFrete) Then
  Begin
    pMostraTravaGrupoFreteDiferente;
    Result:=False;
    Exit;
  End;

end;

function TfrmFatBaixaEntregaFutura.fPodeAlterarQuantidadeAEntregar: Boolean;
begin
  Result := True;

  If (Not blnPodAltSep) And
     (cdsConsulta.FindField('SEPIMP') <> Nil) And
     (cdsConsulta.FindField('SEPIMP').AsString = 'S') Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Entrega Futura - Alteração de quantidade do item de separação já impressa.');

    objLiberacao.strDirAce := 'ALTSEPFUT';
    objLiberacao.strMsgSen := 'Alteração de quantidade do item de separação já impressa.';
    objLiberacao.strCodOpe := fatvenda.strCodVen;
    objLiberacao.strCodDig := fatvenda.strCodDig;
    objLiberacao.blnUsarSenhaFixa := False;
    objLiberacao.blnSempreVariavelUsuario := True;

    Result := fatVenda.fFatMensagemLiberacao(objLiberacao);

    blnPodAltSep := Result;
  End;

end;

function TfrmFatBaixaEntregaFutura.fGetDescontoEspecialJaUtilizado(strDocFut, strEspFut,
  strEmpFut, strIteFut, strIncFut: String; fltUniFut: Double): Double;
  Var
    strSQL: String;
    strPed: String;
    qryDocume : TUniQuery;
begin

  strPed := '';
  strPed := strPed + ' SELECT ';
  strPed := strPed + '   SUM(ROUND(IFNULL(FDO_DESESP, 0), 2)) AS DESESP, ';
  strPed := strPed + '   SUM(ROUND(IFNULL((:UNIFUT - FDO_UNITAR), 0) * FDO_QTDITE, 2)) AS DESUNI ';
  strPed := strPed + ' FROM ';
  strPed := strPed + '   EXTDOR ';
  strPed := strPed + '   LEFT JOIN FATDOR ON FATDOR.AUTOINCREM = FDO_SEQFDO ';
  strPed := strPed + ' WHERE ';
  strPed := strPed + '   FDO_INCFUT = :INCFUT AND ';
  strPed := strPed + '   FDO_JAFATU = 0       AND ';
  strPed := strPed + '   FDO_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
  strPed := strPed + '   RIGHT(FDO_CLAFIS, 3) <> "999" ';//Nao deve considerar a troca do lote (Procure por strMovLot na untFuncFat)

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   SUM(ROUND(IFNULL(DET_DESESP, 0), 2)) AS DESESP, ';
  strSQL := strSQL + '   SUM(ROUND(IFNULL((:UNIFUT - DET_UNITAR), 0) * DET_QTDITE, 2)) AS DESUNI ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   MOVDET ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   DET_DOCFUT = :DOCFUT AND ';
  strSQL := strSQL + '   DET_ESPFUT = :ESPFUT AND ';
  strSQL := strSQL + '   DET_EMPFUT = :EMPFUT AND ';
  strSQL := strSQL + '   DET_CODITE = :ITEFUT AND ';
  strSQL := strSQL + '   DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
  strSQL := strSQL + '   RIGHT(DET_CLAFIS, 3) <> "999" ';//Nao deve considerar a troca do lote (Procure por strMovLot na untFuncFat)

  strSQL := ' SELECT SUM(DESESP) AS DESESP, SUM(DESUNI) AS DESUNI FROM (' + strSQL + ' UNION ALL ' + strPed + ') T ';

  qryDocume := fCriaQuery(Self);

  With qryDocume, SQL Do
  Begin
    Close;
    Clear;
    Add(strSQL);

    ParamByName('DOCFUT').AsString := strDocFut;
    ParamByName('ESPFUT').AsString := strEspFut;
    ParamByName('EMPFUT').AsString := strEmpFut;
    ParamByName('ITEFUT').AsString := strIteFut;
    ParamByName('UNIFUT').AsFloat  := fltUniFut;
    ParamByName('INCFUT').AsString := strIncFut;

    Open;

    Result := FieldByName('DESESP').AsFloat + //Nos documentos novos o desconto especial já esta sendo gravado
              FieldByName('DESUNI').AsFloat;  //Nos documentos antigos o desconto especial era aplicado no preço unitario

    Close;
  End;

  FreeAndNil(qryDocume);

end;

function TfrmFatBaixaEntregaFutura.fGetItemMaisDe1VezNoDocumento(strDoc, strEsp, strEmp, strIte: String): Boolean;
  Var
    strSQL: String;
    qryDocume : TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   COUNT(*) AS QTD ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   MOVDET ';
  strSQL := strSQL + '   LEFT JOIN MOVTRI ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   DET_TIP_FC = "C"     AND ';
  strSQL := strSQL + '   DET_ENTFUT = "S"     AND ';

  If (fCfgSis('EFTEST') = '2') Then
  Begin
    strSQL := strSQL + '   (DET_PROEMB <> "S" OR DET_BXSBIT = "S") AND ';//Para exibir os sub-itens (proemb = 's' e bxsbit = 's')
    strSQL := strSQL + '   (DET_FILKAR = 0) AND ';//Para nao exibir o item principal (que vai estar com filkar = 1)
  End
  Else
    strSQL := strSQL + '   DET_PROEMB <> "S" AND ';

  strSQL := strSQL + '   DET_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '   DET_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '   DET_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '   DET_CODITE = :CODITE     ';

  strSQL := ' SELECT SUM(QTD) AS QTD FROM (' + strSQL + ') T ';

  qryDocume := fCriaQuery(Self);

  With qryDocume, SQL Do
  Begin
    Close;
    Clear;
    Add(strSQL);

    ParamByName('NUMDOC').AsString := strDoc;
    ParamByName('ESPDOC').AsString := strEsp;
    ParamByName('CODEMP').AsString := strEmp;
    ParamByName('CODITE').AsString := strIte;

    Open;

    Result := FieldByName('QTD').AsInteger > 1;

    Close;
  End;

  FreeAndNil(qryDocume);

end;

function TfrmFatBaixaEntregaFutura.fSQLQtdEnt(strAlias: String = 'D'): String;
begin
  Result := untFuncoesSimples.fGetSqlQtdEntregueEntFut(strAlias);
end;

procedure TfrmFatBaixaEntregaFutura.pVisibilidadeColunaLote;
var
  intRecNo : Integer;
begin
  If (dbgvDadosItensDET_NUMLOT <> Nil) Then
  Begin
    dbgvDadosItensDET_NUMLOT.Visible := False;
    dbgvDadosItensDET_NUMLOT.Caption := objCadLot.strTitLab;

    intRecNo := cdsConsulta.RecNo;
    cdsConsulta.DisableControls;

    Try
      cdsConsulta.First;

      While Not cdsConsulta.Eof Do
      Begin
        If Not fEmptyStr(cdsConsulta.FieldByName('DET_NUMLOT').AsString) Then
        Begin
          dbgvDadosItensDET_NUMLOT.Visible := True;
          dbgvDadosItensDET_NUMLOT.Width   := 100;
          Break;
        End;

        cdsConsulta.Next;
      End;
    Finally
      cdsConsulta.RecNo := intRecNo;
      cdsConsulta.EnableControls;
    End;
  End;
end;

function TfrmFatBaixaEntregaFutura.fCampoDocumentoPreenchido: Boolean;
begin
  Result := (Not fEmptyStr(edtDocFat.Text)) And (Not fEmptyStr(edtEspFat.Text));
end;

function TfrmFatBaixaEntregaFutura.fChvDoc(blnMsg: Boolean=False): String;
begin
  Result := cdsConsulta.FieldByName('DET_NUMDOC').AsString + IIF(blnMsg,'-','') +
            cdsConsulta.FieldByName('DET_ESPDOC').AsString + IIF(blnMsg,'-','') +
            cdsConsulta.FieldByName('DET_CODEMP').AsString;
end;

function TfrmFatBaixaEntregaFutura.fSQLFiltroMinimo: string;
begin
  Result :=
    TBaixaEntFut.New(
      TParamsBaixaEntFut.New()
        .NumeroDocumento(edtDocFat.Text)
        .EspecieDocumento(edtEspFat.Text)
    ).fSQLFiltroMinimo;
end;

function TfrmFatBaixaEntregaFutura.fAchouPorDocumento: Boolean;
  Var
    strSQL   : String;
    qryGen: TUniQuery;
begin
  Result := False;

  If fCampoDocumentoPreenchido Then
  Begin
    qryGen := fCriaQuery;
    Try
      strSQL := '';
      strSQL := strSQL + ' SELECT  ';
      strSQL := strSQL + '   GER_CODCLI, ';
      strSQL := strSQL + '   GER_NOMCON  ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   MOVGER ';

      If (fUsaPedidoBaixaEntregaFutura) Then
      Begin
        strSQL := strSQL + '   INNER JOIN MOVDET D ON(MOVGER.AUTOINCREM = D.DET_SEQGER) ';
        strSQL := strSQL + '   LEFT JOIN MOVTRI T ON(D.AUTOINCREM = T.DET_SEQGER) ';
        strSQL := strSQL + '   LEFT JOIN AUXMOV A ON (MOVGER.AUTOINCREM = A.AUX_SEQGER) ';
      End;

      strSQL := strSQL + ' WHERE ' + fSQLFiltroMinimo;

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;
        If Not IsEmpty Then
        Begin
          edtCodCliente.Text := FieldByName('GER_CODCLI').AsString;
          edtDesCliente.Text := FieldByName('GER_NOMCON').AsString;
          Result := True;
        End;
        Close;
      End;
    Finally
      FreeAndNil(qryGen);
    End;
  End;
end;

function TfrmFatBaixaEntregaFutura.fAguardaAutorizacaoNFe(pgbProgresso: TcxProgressBar = nil): Boolean;
Var
  intTentativas: Integer;
  strStatusNFe: String;
begin
  Result := False;
  For intTentativas := 1 To 100 Do
  Begin
    strStatusNFe := fPainelNFeStatusDocumento(fatVenda.strNumDoc, fatVenda.strEspDoc, fatVenda.strEmpDoc, fatVenda.strCodCli, fatVenda.strSerFsc);

    If (strStatusNFe = 'AT') Then
    Begin
      Result := True;
      Break;
    End;

    If (strStatusNFe = 'EE') Then
      Break;

    Sleep(100);
  End;
end;

procedure TfrmFatBaixaEntregaFutura.pZeraConsulta;
begin
  pUnLockTodos;
  qryConsulta.Close;
  cdsConsulta.Close;
  edtCodIte.Clear;
  edtTotalPeso.Text := '0,00';

  strCgcCpfSel := '';
  strCgcConSel := '';
  strNomConSel := '';

  fltFreRatAux := 0;
  fltTotEnt := 0;
  fltTotPes := 0;
  fltTotDev := 0;
  pLiberaGrid;
  blnPodAltSep := False;
  strAutoincMovsBaixaSimplificada := '';

  SetLength(arrLogLib, 0);
end;

function TfrmFatBaixaEntregaFutura.fPermiteDevolverProdutos(strEmpDoc: String; fltQtdDev: Double): Boolean;
begin
  Result := (fltQtdDev > 0);

  If Result And (strEmpDoc <> VS_strCodEmp) Then
  Begin
    Result := (fCfgSis('DVOULJ', varString) = 'S');

    If (Not Result) Then
    Begin
      Result := (fCfgSis('DVOULJ', varString) = 'B') And
                (fEhMesmaBaseCNPJ(VS_strCodEmp, strEmpDoc, True));
    End;
  End
end;

procedure TfrmFatBaixaEntregaFutura.pAdicionaItemParaReprocessamentoDeSaldo(const strCodIte : String);
begin
  objReprocessarSaldoItens.
       AddItem(TItemReprocessarSaldo.New.Codigo(strCodIte).
                                         EhItemEntregaFutura(True));
end;

end.
