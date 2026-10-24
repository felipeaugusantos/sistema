{***************************}
{* qryConOpe     -> CADOPE *}
{* qryConCta     -> CADCTA *}
{* qryConPor     -> CADPOR *}
{************************JB*}

unit untEntDadosFiscaisResumo;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Mask, DBCtrls, DBEditFocus,
  ExtCtrls, ComCtrls, Buttons, MaskEditFocus, EditFocus, DB, QColorLabel,
  Menus, untEspelhoNota, Uni, AppEvnts, untFechamentoFinanceiro,
  BitBtnLockedIncrem, untFuncoesSimples, Math, untGnre, StrUtils, MemoFocus,
  untEntPagtoAntecipado, UniClientDataSet, untEntVendor, untFatAbastecimentoDeposito,
  untEntOutrasDespesas, untEntEmbalagens, untTypesSistema, untDefineBaixaPedido,
  untEntFreConLista, frxClass, frxExportCSVTestabilidade, untZClient, untMsgInterna,
  untGeraMensagemPedidoCompraAtendido, ComboBoxFocus, untFechamentoEstoque,
  untFechamentoFiscal, untPortadorFornecedor, untFrameCentroCustoEditFocus,untEntRetencaoNotaServico,
  Faturamento.Consignacao.Classes, untFramePlanoDeContasMaskEdit, untPcmGer, DateUtils,
  untTAvisoAlteracaoPreco, untLiberacao,untCondicaoPagamentoCliente,
  Shared.Functions.DataSet, untFatAltEmpFatPedido, untAbastecimentoDepositoDevolucaoEntradaMercadoria,
  untTValidaCorrespondenteContabil, untFuncoesRel, untTipoFreteAtc,
  untAuditoriaGravacaoSaldo, untFrmManipulaContasPagarPrevisaoNao, untTPerfilDespachanteAduaneiro,
  cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxEdit, cxTextEdit, cxCurrencyEdit,
  cxInplaceContainer, cxVGrid, cxDBVGrid,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxClasses;

type
  TfrmEntDadosFiscaisResumo = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    pnlContasPagar: TPanel;
    pnlDetalhes: TPanel;
    vgrDetalhes: TcxDBVerticalGrid;
    rowTitulos: TcxDBMultiEditorRow;
    rowClfSc: TcxDBMultiEditorRow;
    rowVlCon: TcxDBMultiEditorRow;
    rowBasIc: TcxDBMultiEditorRow;
    rowAlqIc: TcxDBMultiEditorRow;
    rowVlrIc: TcxDBMultiEditorRow;
    rowIsent: TcxDBMultiEditorRow;
    rowBcRet: TcxDBMultiEditorRow;
    rowRetId: TcxDBMultiEditorRow;
    rowBasAn: TcxDBMultiEditorRow;
    rowAntIc: TcxDBMultiEditorRow;
    rowDAces: TcxDBMultiEditorRow;
    rowBasIp: TcxDBMultiEditorRow;
    rowVlrIp: TcxDBMultiEditorRow;
    rowOutra: TcxDBMultiEditorRow;
    rowBaeRe: TcxDBMultiEditorRow;
    rowVaeRe: TcxDBMultiEditorRow;
    rowBaeIp: TcxDBMultiEditorRow;
    rowVaeIp: TcxDBMultiEditorRow;
    rowBFCPS: TcxDBMultiEditorRow;
    rowVFCPS: TcxDBMultiEditorRow;
    rowQBCMo: TcxDBMultiEditorRow;
    rowValMo: TcxDBMultiEditorRow;
    rowBcCbs: TcxDBMultiEditorRow;
    rowVlCbs: TcxDBMultiEditorRow;
    rowBcIbs: TcxDBMultiEditorRow;
    rowVlIbs: TcxDBMultiEditorRow;
    rowBc_Is: TcxDBMultiEditorRow;
    rowVl_Is: TcxDBMultiEditorRow;
    pnlBotoesEnt: TPanel;
    Label1: TLabel;
    edtValSub: TEditFocus;
    Label2: TLabel;
    edtDesAce: TEditFocus;
    Label3: TLabel;
    edtValFre: TEditFocus;
    Label4: TLabel;
    edtValIpi: TEditFocus;
    Label5: TLabel;
    edtDesEsp: TEditFocus;
    lblCodOpe: TLabel;
    edtCodOpe: TEditFocus;
    btnConfirma: TBitBtnLocked;
    Label28: TLabel;
    edtTotIte: TEditFocus;
    Label29: TLabel;
    edtVlrCon: TEditFocus;
    pgbDadosFiscais: TProgressBar;
    edtCodPor: TEditFocus;
    Label30: TLabel;
    edtNomOpe: TEditFocus;
    edtNomPor: TEditFocus;
    lblCodDig: TLabel;
    edtCodDig: TEditFocus;
    edtNomDig: TEditFocus;
    lblCodRep: TLabel;
    edtCodRep: TEditFocus;
    edtNomRep: TEditFocus;
    chkGraFin: TCheckBox;
    chkImprCp: TCheckBox;
    lblChaNFE: TLabel;
    edtChaNFE: TEditFocus;
    lblInfCtp: TLabel;
    mmoHisCta: TMemoFocus;
    chkPgoAnt: TCheckBox;
    chkVeioBo: TCheckBox;
    lblCodCon: TLabel;
    edtCodCon: TEditFocus;
    lblModFre: TLabel;
    cbxModFre: TComboBoxFocus;
    Label32: TLabel;
    edtValAnt: TEditFocus;
    lblPesBru: TLabel;
    edtPesBru: TEditFocus;
    lblPesLiq: TLabel;
    edtPesLiq: TEditFocus;
    chkAtuPre: TCheckBox;
    btnPgoAnt: TBitBtnLocked;
    btnCancelarEntrada: TBitBtnLocked;
    btnOutDes: TBitBtnLocked;
    lblCredFor: TLabel;
    chkDeposi: TCheckBox;
    lblTemPgtoAntecipado: TLabel;
    lblQtdVol: TLabel;
    edtQtdVol: TEditFocus;
    lblEspVol: TLabel;
    edtEspVol: TEditFocus;
    lblBcoFor: TLabel;
    cbxBcoFor: TComboBoxFocus;
    cbxCODMOD: TComboBoxFocus;
    lblCODMOD: TLabel;
    FlwPnlBotoesEnt: TFlowPanel;
    lblCompet: TLabel;
    mskCompet: TMaskEditFocus;
    lblHistorioLivroFiscal: TLabel;
    edtHistorioLivroFiscal: TEditFocus;
    btnImpEspelho: TBitBtnLocked;
    btnVendor: TBitBtnLocked;
    btnConFre: TBitBtnLocked;
    btnConfDigitacao: TBitBtnLocked;
    btnDesmembraValores: TBitBtnLocked;
    btnGnreST: TBitBtnLocked;
    btnGnreTribut: TBitBtnLocked;
    fraCentroCusto: TfraCentroCustoEditFocus;
    lblCondPgto: TLabel;
    mskCndPag: TMaskEditFocus;
    btnTCIF: TBitBtnLocked;
    btnTS: TBitBtnLocked;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    chkPrevisao: TCheckBox;
    lblPagamentoCartaoCredito: TLabel;
    dtsCadFis: TDataSource;
    cxStyleRepositoryDetalhes: TcxStyleRepository;
    cxsTituloDetalhes: TcxStyle;
    pnlCheckBox: TPanel;
    lblEmpresa: TLabel;
    chkRealizaMovimentacaoDeSaldo: TCheckBox;
    chkTransfAut: TCheckBox;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarEntradaClick(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure btnImpEspelhoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodRepKeyPress(Sender: TObject; var Key: Char);
    procedure chkGraFinClick(Sender: TObject);
    procedure btnConFreClick(Sender: TObject);
    procedure btnConfDigitacaoClick(Sender: TObject);
    procedure btnGnreSTClick(Sender: TObject);
    procedure btnDesmembraValoresClick(Sender: TObject);
    procedure btnPgoAntClick(Sender: TObject);
    procedure chkPgoAntClick(Sender: TObject);
    procedure edtNumADKeyPress(Sender: TObject; var Key: Char);
    procedure mskCndPagExit(Sender: TObject);
    procedure btnVendorClick(Sender: TObject);
    procedure chkAtuPreClick(Sender: TObject);
    procedure btnOutDesClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkDeposiClick(Sender: TObject);
    procedure cbxBcoForDropDown(Sender: TObject);
    procedure cbxBcoForEnter(Sender: TObject);
    procedure cbxBcoForExit(Sender: TObject);
    procedure cbxBcoForKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbxBcoForChange(Sender: TObject);
    procedure edtChaNFEExit(Sender: TObject);
    procedure chkVeioBoClick(Sender: TObject);
    procedure btnGnreTributClick(Sender: TObject);
    procedure mskCndPagKeyPress(Sender: TObject; var Key: Char);
    procedure btnTCIFClick(Sender: TObject);
    procedure mnuGnreSTClick(Sender: TObject);
    procedure mnuGnreTributadoClick(Sender: TObject);
    procedure btnTSClick(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure chkTransfAutClick(Sender: TObject);
    procedure cbxModFreChange(Sender: TObject);
    procedure chkPrevisaoClick(Sender: TObject);
    procedure pGetDisplayTextTitulo(Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: String);
    procedure pGetDisplayTextValor(Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: String);
    procedure pGetDisplayTextClaFis(Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: String);
    procedure pGetContentStyleDetalhes(Sender: TObject; AEditProp: TcxCustomEditorRowProperties;
      AFocused: Boolean; ARecordIndex: Integer; var AStyle: TcxStyle);
  private
    { Private declarations }
    strAtuAdb: string;
    blnTemDupEle: Boolean;
    blnDupEleConsultado: Boolean;
    arrDuplicataXMLCache: TarrDuplicata;
    fltTotSelPreNotaOriginal: Double;
    strHisCtaPreNotaAtual: String;
    CondicaoPagamentoCliente: TCondicaoPagamentoCliente;
    blnSuframa: Boolean;
    blnDescontaFreteDevolucao: Boolean;

    blnEhDARE: Boolean;
    blnPreCtp: Boolean;

    fltBonificacao: Double;

    TipoCfop : TTipoCfop;

    objFechamentoEstoque: TFechamentoEstoque;
    objFechamentoFiscal : TFechamentoFiscal;

    objAvisoAlteracaoPreco : TAvisoAlteracaoPreco;

    objPortadorFornecedor : TPortadorFornecedor;

    objPgoAnt: TEntPagtoAntecipado;

    objDefBaixa: TDefineBaixaPedido;

    objVendor: TEntVendor;
    objOutDes: TEntOutrasDespesas;

    strCodOpe: String;
    strCodDig: String;
    strCndAnt: String;
    blnForGCP: Boolean;

    objLisFre: TFreConLista;

    objGnreST  : TGnre;
    objGnreTributado: TGnre;
    objGnreTCIF: TGnre;
    objGnreTS: TGnre;
    strCodCnd: String;

    qryConPor: TUniQuery;
    qryConCta: TUniQuery;
    qryConOpe: TUniQuery;
    oleItensPedidos: OleVariant;
    cdsCtpDet: TUniClientDataSet;

    objEspNota : TEspNota;

    lstBcoFor: TStringList;
    intIdxBcoForAnt: Integer;
    objFechamentoFinanceiro: TFechamentoFinanceiro;

    FblnAcessadoViaRetornoConsignacao : Boolean;
    FTipoRetornoConsignacao           : tTipoRetornoConsignacao;

    FValidaCorrespondenteContabil: TValidaCorrespondenteContabil;
    FblnSolicitarSenhaOpeEntradaGarantia: Boolean;

    objAuditoriaSaldo: IAuditoriaGravacaoSaldo;

    Function fSQLImpostosImportacao: String;
    procedure pDesmembraCTPImportacao;
    procedure pLogFalhaDestruicao(const AstrObjeto: String; AobjErro: Exception);
    Function fGravaAgendamentoDeRecebimento(strAutIncMovger: String) : Boolean;
    Function fGeraAgendamento(strAutIncMovger: String): Boolean;
    function fTemItemMarmoreGranitoSemLoteADefinirCadastrado: Boolean;
    procedure pGerarLotesADefinirParaGranitoMarmore;


    procedure pHabilitaFinanceiro;
    procedure pHabilitaVendorOutrasDespesas;
    procedure pAtribuiTabelas;
    function fRetClaFisCadFis(const AintIdx: Integer): String;
    function fRetVlrContabilCadFis: Double;
    procedure pAjustaLinhasDetalhes;
    procedure pAjustarFundoTema;
    procedure pCarregaOperador;
    procedure pCarregaDigitador;
    procedure pCarregaCentroCusto;
    procedure pCarregaPortador;
    procedure pCarregaEvento;
    procedure pCarregaRepresentante;
    procedure pCalculaTotaisCabecalho;
    procedure pImprimeEtiqueta;
    procedure pAjustaTelaPgoAntecipado;
    procedure pLimpaSelecaoPgoAntecipado;
    procedure pDesmarcaPgoAntecipadoComLimpeza;
    procedure pAtualizaICMSFrete(fltAlqIcm: Double);
    procedure pCarregaDadosContasPagarPreNota;

    procedure pHabilitaPagAntecipado;

    Function fTemAntecipadoValorMenor: Boolean;

    {Function fHaVinculosx922_x117: Boolean;}

    function fAtualizaPedidoDevolucao(strNumFat,
                                      strEspFat,
                                      strVenFat,
                                      strDigFat,
                                      strCndfat: String;
                                      fltValFat: Double): Boolean;
    procedure pImprimeLiberacaoArmazenamento;
    procedure pRefazCondPagamento;
    procedure pExibeArrDuplicata(Sender: TObject);
    procedure pMonstraItensImprimeLista(strItens: String);

    procedure pHabilitaCamposFinanceiro;
    Procedure pCalculaValorDocumento;
    procedure pCarregaDadosBancariosFornecedor(strCodFor: String);
    procedure pCarregaModFis(strChave: String = '');

    function fGetBcoFor: String;

    procedure pRetiraDadosParaContasAPagar;
    function fChaveModelo(AValue: String): String;
    procedure pAtualizarObjLisFre;
    function fLiberarValorBoleto: Boolean;

    {function fTotalDuplicatas: Currency;}
    function fRetEmpresaAbastecimentoDepositoNaDevolucaoDaNota(strDocSel: String): String;
    procedure pTransferirEstoqueAbastecimentoDeposito(strAutInc, strEmpresaAbastecimento: String);
    procedure pAtualizaStatusPedidoDevolucao;
    function fPedirSenhaOperador: Boolean;
    function fGetModDocumentocbxCODMOD: String;
    function fGravaPreCtp: Boolean;
    procedure pApagaExistentePreCtp(strAutInc: string);
    function fRetornaParcelas: String;
    function fRetCentroCustoDoc: String;
    function fRetornaExistePedidoCompraPagoCartaoCredito(stlPedidos: TStringList): Boolean;
    function fCadastroAutomaticoAtivosImobilizados(var strItensCadastrados: String; strItensASeremFiltrados, strNumDoc, strEspDoc, strSerie, strCodFor, strCndPag: String; dtaDtaEnt: TDateTime): Boolean;
    procedure pGetMsgItensAtivoImobilizado(var strMsg: String; var strItens: String; strNumDoc, strEspDoc, strSerie, strCodFor: String);
    function fValidaPagamentoAntecipadoAberto: Boolean;
    function fValidaNotaPossuiItensDevolvidosFaturados(ARecNotEle: TRecInfoNotaEletronica): Boolean;
    procedure pCarregaDuplicatasXML;
  protected
    procedure pEscapePressed; override;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fEhFornecedor: Boolean;
    procedure pZeraOutrasDespesas;
    function fEhOperacaoTransferenciaEstoque(const strNumDoc, strEspDoc, strCodFor: String; out strEmpFat, strCodCli, strSerie_: String): boolean;
    function fBaixaNotaConf(const strNumDoc, strEspDoc, strEmpDoc, strSerie_, strCodCli: String): Boolean;
  public
    { Public declarations }
    fAoConfirmarEntrada: TAoConfirmarDocumento;
    PerfilDespachanteAduaneiro: TPerfilDespachanteAduaneiro;
    blnDesmebrado,
    blnTravarFinanceiroEstaDuplicado,
    blnEncargosNoFrete,
    blnPrecoPraticado: Boolean;
    frmEntRetencaoNotaServico: TfrmEntRetencaoNotaServico;
    strCadPagDesmembramento: String;
    tipRatFrete: TTipoRateioFrete;

    blnPedFilialGarantia : Boolean;

    blnFornJaAtualizado: Boolean;

    fltCotDol,
    fltValorDocumento: Double;

    blnNotaImp,
    blnFreTri: Boolean;
    fltRetIte,
    fltValAnt: Double;

    recNotEle: TRecInfoNotaEletronica;
    objEmbala: TEntEmbalagens;

    blnCarPro: Boolean;

    strAutDev: String;

    strPedDev: String;

    dtaDtaEnt: TDateTime;
    dtaDtaDoc: TDateTime;
    dtaIcmAnt: TDateTime;
    strNumDoc: String;
    strSerie : String;
    strCodFaz: String;
    strCodFor: String;
    strCgcCpf: String;
    strTipCgcCpf: String;
    strEstFor: String;
    strEspDoc: String;
    strCodEmp: String;
    fltAlqFor: Double;
    fltTotPis: Double;
    fltTotCof: Double;
    fltBasPis: Double;
    fltBasCof: Double;
    fltAlqPis: Double;
    fltAlqCof: Double;
    blnDevolu: Boolean;
    intNumIte: Integer;
    stlPedidos: TStringList;
    strConPag,
    strCodConPagCliDev: string;
    qryEntMer: TUniQuery;

    blnConfirma: Boolean;
    blnGarantia: Boolean;
    cdsMovGad  : TUniClientDataSet;
    blnRecCliGarantia: Boolean;
    blnConEqu: Boolean;
    blnLocEqu: Boolean;

    strOrdIte: String;
    fltTotIte: Double;
    strMotDev: String;

    // Antecipação no Frete do Conhecimento
    fltMaxIVA,
    fltAntIcF,
    fltBasAnF : Double;

    arrDocOri: TStringArrayArray;
    blnFreIpi,
    blnDescontoIncondicional: Boolean;
    strAutInc: String;
    strChaNFe: String;
    arrLinDigCodbar: TarrLinDigCodbar;
    intQtdPar: Integer;
    arrClienteConsumidor: TStringArray;
    fltDesEspRecCliGarantia: Double;

    strDocSel: String;

    onBeforeConfirmaEntrada : TGenericProcedure;
    onAfterConfirmaEntrada : TGenericProcedure;

    arrDuplicata: TarrDuplicataPointer;

    FblnAcessadoViaPrenota : Boolean;
    strMatRev: String;

    property strBcoFor: String read fGetBcoFor;
    property blnAcessadoViaRetornoConsignacao : Boolean                  read FblnAcessadoViaRetornoConsignacao write FblnAcessadoViaRetornoConsignacao;
    property TipoRetornoConsignacao            : tTipoRetornoConsignacao read FTipoRetornoConsignacao           write FTipoRetornoConsignacao;
    procedure pShow;


  end;


implementation

uses untPesqAux, untFuncoes, untConstantes,
     untRelEstDigitacaoNotaEntrada, untRelEspNotaEnt,
     untEntEtiquetas, untDesmembrValores, untEntAutorizacaoRedPreco,
     untCadCta, untCadPag, untConsultas,
     untQckLiberacaoArmazenamento, untDigDuplicata, untDigCodBarBoleto,
     untAlteraFornecedorEntrada, untEntConfirmaVencimento, untDuplicatas,
     untEntImprimeLista, untVinculoBaixaEntregaFuturaEdocVenda,
     untLotePrecosEfetivacaoCx, untCfgSistema, Winapi.Messages,
     untEntradaAutomatizada, untEntFreCon,
     untCadFornecedores, untTypesCRM, untAtualizaOcorrenciasCRM,
     Contabilidade.Funcoes, Contabilidade.Consultas, untCadClientes,
     untCadTransportadoras, untFuncoesConsulta, untEmissaoNotaEspecial,
     untTSituacaoPedidoVenda, untConfirmaCTP117, untTLiberacaoValorBoleto,
     untObservacao, Vcl.Themes;

{$R *.dfm}

procedure TfrmEntDadosFiscaisResumo.FormCreate(Sender: TObject);

begin
  inherited;
  fAoConfirmarEntrada := Nil;
  fltDesEspRecCliGarantia := 0;
  FblnSolicitarSenhaOpeEntradaGarantia := fCfgSis('PSOGNE', varString) = 'S';
  blnDesmebrado := false;
  strCadPagDesmembramento := '';
  TipoCfop := tcCFOPNormal;

  FblnAcessadoViaRetornoConsignacao := False;
  FblnAcessadoViaPrenota := False;

  strAtuAdb := fCfgSis('ATUADB');

  onBeforeConfirmaEntrada := nil;
  onAfterConfirmaEntrada := nil;

  blnFornJaAtualizado:= False;

  btnGnreTribut.Visible := fCfgSis('GNRTEM', varBoolean);

  If Not btnGnreTribut.Visible Then
  begin
    Self.Width := 1050;
    btnGnreST.Caption := '[F3]GNRE';
  End;

  blnSuframa := fCfgSis('SUFRAM', varBoolean);
  btnTS.Visible := blnSuframa;
  btnTCIF.Visible := blnSuframa;

  {Se resolução disponível for inferior ou igual à (1366 x 768), maximiza tela!}
  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.WindowState := wsMaximized;

  objDefBaixa := TDefineBaixaPedido.Create(Self);

  objFechamentoEstoque := TFechamentoEstoque.Create(Self);
  objFechamentoFiscal  := TFechamentoFiscal.Create(Self);

  objAvisoAlteracaoPreco := TAvisoAlteracaoPreco.Create;

  objPortadorFornecedor := TPortadorFornecedor.Create(True);

  blnPrecoPraticado := False;

  blnFreIpi := False;

  SetLength(arrDocOri, 0, 0);

  fltAntIcF := 0;
  fltBasAnF := 0;

  objVendor := TEntVendor.Create(Self);

  objVendor.blnGravar := fCfgSis('CTPVND', varBoolean) And
                         fCfgSis('ENTCTP', varBoolean) And
                         (Not blnDevolu);

  btnVendor.Visible := objVendor.blnGravar;

  objOutDes := TEntOutrasDespesas.Create(Self);

  objPgoAnt :=  TEntPagtoAntecipado.Create;

  qryConPor := fCriaQuery(Self);

  strOrdIte := '';

  blnConfirma := False;
  strCodOpe   := '';
  strCndAnt   := '';
  strPedDev   := '';

  {*****************************************}
  {* ABRE AS TABELAS USADAS NA INSERÇÃO    *}
  {**************************************MV*}


  If Not fCfgSis('ENTCTP', varBoolean) Then
    pRetiraDadosParaContasAPagar;

  pAtribuiTabelas;
  pAjustarFundoTema;

  {**************************************}
  {* OBJETO DE FRETE DE CONHECIMENTO    *}
  {***********************************LA*}
  objLisFre := TFreConLista.Create(Self, False, True);

  {**************************************}
  {* OBJETO DA GNRE                     *}
  {***********************************LA*}
  objGnreST := TGnre.Create(Self);
  objGnreST.TipoChamada := tcGnreST;
  objGnreTributado := TGnre.Create(Self);
  objGnreTributado.TipoChamada := tcGnreTributado;
  If Not btnGnreTribut.Visible Then
    objGnreST.TipoChamada := tcGnrePadrao;

  objGnreTCIF := TGnre.Create(Self);
  objGnreTCIF.TipoChamada := tcTCIF;

  objGnreTS := TGnre.Create(Self);
  objGnreTS.TipoChamada := tcTS;

  blnEhDare        := fEhEmpresaDARE;

  If blnEhDare Then
  Begin
    btnGnreST.Caption     := fTrocaNomeGNRE(blnEhDare, btnGnreST.Caption);
    btnGnreTribut.Caption := fTrocaNomeGNRE(blnEhDare, btnGnreTribut.Caption);
  End;

  {**************************************}
  {* OBJETO DE ESPELHO DA NOTA          *}
  {***********************************JC*}
  objEspNota := TEspNota.Create(Self);

  {******************}
  {* DESMENBRAMENTO *}
  {***************JU*}
  cdsCtpDet := TUniClientDataSet.Create(Self);
  pCriaClientTemporariaCtpDet(strNumDoc, '', strSerie, strCodEmp, strCodFor, cdsCtpDet);

  {******************}
  {* Depósito       *}
  {***************FS*}
  lstBcoFor := TStringList.Create;
  intIdxBcoForAnt := -1;
  strCodCnd := EmptyStr;

  FValidaCorrespondenteContabil :=  TValidaCorrespondenteContabil.Create;

  objAuditoriaSaldo := TAuditoriaGravacaoSaldo.New;
end;

{***********************************************************************}
{* Req. 455181                                                         *}
{* Uma excecao no meio da destruicao impede TComponent.Destroy de       *}
{* executar FOwner.RemoveComponent(Self), deixando o Name preso na      *}
{* Application; e pFreeAndNil descarta essa excecao silenciosamente.    *}
{* Cada liberacao fica em bloco protegido proprio.                     *}
{***********************************************************************}
procedure TfrmEntDadosFiscaisResumo.pLogFalhaDestruicao(const AstrObjeto: String; AobjErro: Exception);
begin
  Try
    pGravarErro(True,
                '[TfrmEntDadosFiscaisResumo.FormDestroy] Req. 455181 - falha ao liberar ' +
                AstrObjeto + ': ' + AobjErro.Message + ' ' + AobjErro.ClassName,
                'Falha na destruicao do formulario; o Name seria mantido preso na Application.');
  Except
    On E: Exception Do
    Begin
    End;
  End;
end;

procedure TfrmEntDadosFiscaisResumo.FormDestroy(Sender: TObject);
begin

  {* Mantida por dependencia real: untPcmGer consome esta global apos a *}
  {* confirmacao da entrada. Ver spec RN08.                            *}
  Try
    If not FblnAcessadoViaPrenota Then
      If Assigned(frmVinculoBaixaEntregaFuturaEdocVenda) Then
        FreeAndNil(frmVinculoBaixaEntregaFuturaEdocVenda);
  Except
    On E: Exception Do
      pLogFalhaDestruicao('frmVinculoBaixaEntregaFuturaEdocVenda', E);
  End;

  Try
    If Assigned(objPgoAnt) Then FreeAndNil(objPgoAnt);
  Except
    On E: Exception Do
      pLogFalhaDestruicao('objPgoAnt', E);
  End;

  Try
    If Assigned(cdsCtpDet) Then FreeAndNil(cdsCtpDet);
  Except
    On E: Exception Do
      pLogFalhaDestruicao('cdsCtpDet', E);
  End;

  Try
    If Assigned(FValidaCorrespondenteContabil) Then FreeAndNil(FValidaCorrespondenteContabil);
  Except
    On E: Exception Do
      pLogFalhaDestruicao('FValidaCorrespondenteContabil', E);
  End;

  Try
    If Assigned(objAvisoAlteracaoPreco) Then FreeAndNil(objAvisoAlteracaoPreco);
  Except
    On E: Exception Do
      pLogFalhaDestruicao('objAvisoAlteracaoPreco', E);
  End;

  Try
    If Assigned(objDefBaixa) Then FreeAndNil(objDefBaixa);
  Except
    On E: Exception Do
      pLogFalhaDestruicao('objDefBaixa', E);
  End;

  Try
    If Assigned(objFechamentoEstoque) Then FreeAndNil(objFechamentoEstoque);
  Except
    On E: Exception Do
      pLogFalhaDestruicao('objFechamentoEstoque', E);
  End;

  Try
    If Assigned(objFechamentoFiscal) Then FreeAndNil(objFechamentoFiscal);
  Except
    On E: Exception Do
      pLogFalhaDestruicao('objFechamentoFiscal', E);
  End;

  Try
    If Assigned(objPortadorFornecedor) Then FreeAndNil(objPortadorFornecedor);
  Except
    On E: Exception Do
      pLogFalhaDestruicao('objPortadorFornecedor', E);
  End;

  Try
    If Assigned(objVendor) Then FreeAndNil(objVendor);
  Except
    On E: Exception Do
      pLogFalhaDestruicao('objVendor', E);
  End;

  Try
    If Assigned(objOutDes) Then FreeAndNil(objOutDes);
  Except
    On E: Exception Do
      pLogFalhaDestruicao('objOutDes', E);
  End;

  Try
    If Assigned(qryConPor) Then FreeAndNil(qryConPor);
  Except
    On E: Exception Do
      pLogFalhaDestruicao('qryConPor', E);
  End;

  Try
    If Assigned(objLisFre) Then FreeAndNil(objLisFre);
  Except
    On E: Exception Do
      pLogFalhaDestruicao('objLisFre', E);
  End;

  Try
    If Assigned(objGnreST) Then FreeAndNil(objGnreST);
  Except
    On E: Exception Do
      pLogFalhaDestruicao('objGnreST', E);
  End;

  Try
    If Assigned(objGnreTributado) Then FreeAndNil(objGnreTributado);
  Except
    On E: Exception Do
      pLogFalhaDestruicao('objGnreTributado', E);
  End;

  Try
    If Assigned(objGnreTCIF) Then FreeAndNil(objGnreTCIF);
  Except
    On E: Exception Do
      pLogFalhaDestruicao('objGnreTCIF', E);
  End;

  Try
    If Assigned(objGnreTS) Then FreeAndNil(objGnreTS);
  Except
    On E: Exception Do
      pLogFalhaDestruicao('objGnreTS', E);
  End;

  Try
    If Assigned(objEspNota) Then FreeAndNil(objEspNota);
  Except
    On E: Exception Do
      pLogFalhaDestruicao('objEspNota', E);
  End;

  Try
    If Assigned(lstBcoFor) Then FreeAndNil(lstBcoFor);
  Except
    On E: Exception Do
      pLogFalhaDestruicao('lstBcoFor', E);
  End;

  Try
    inherited;
  Except
    On E: Exception Do
      pLogFalhaDestruicao('inherited FormDestroy', E);
  End;
end;

Procedure TfrmEntDadosFiscaisResumo.pCalculaValorDocumento;
Begin
  If Not FblnAcessadoViaPrenota Then
  Begin
    fltBonificacao    := fRetTotalBonificacaoEntMer;
    fltValorDocumento := fFormataFloat(fStrToFloat(edtVlrCon.Text) - fltBonificacao -   fRetTotalRetencoes(dtsCadFis.DataSet) -
                                       IfThen(blnDescontaFreteDevolucao, fStrToFloat(edtValFre.Text) + fStrToFloat(edtDesAce.Text), 0), 2);
  End
  Else
  Begin
    fltValorDocumento := fltTotIte;
  end;
  objPgoAnt.fltValPreNota :=  fltValorDocumento;

End;

function TfrmEntDadosFiscaisResumo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
Var
  strSenha: String;
  strCndPag: String;
  strDocume: String;
  fltValorRestante: Double;
  intCont:   Integer;
  oParametros: TParametrosDesmembraValoresCtaDet;
  {curTotDup: Currency;}
  blnManterValoresOriginais: Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (recNotEle.finalidadeXML = xmlRetornoSimbolico) Then
      Exit(True);

    If (Sender = edtCodOpe) And (Sender.Parent.Enabled) And (recNotEle.finalidadeXML <> xmlRetornoSimbolico) And (Sender.Visible) Then
    Begin

      If fEmptyStr(edtCodOpe.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O operador deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin

        pCarregaOperador;
        If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse operador não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (strCodOpe <> edtCodOpe.Text) Then
        Begin

          If (Not blnDevolu) and fPedirSenhaOperador Then
          Begin

            If (ffrmSenha(strSenha)) Then
            Begin

              If (strSenha <> fDecrypt(qryConOpe.FieldByName('OPE_SENOPE').AsString)) Then
              Begin
                fMensagem('ATENÇÃO!', 'Senha Invalida!', ['&O k']);
                edtNomOpe.Clear;
                Result := False;
              End
              Else
              Begin
                strCodOpe           := edtCodOpe.Text;
                objLisFre.strCodOpe := edtCodOpe.Text;
              End;

            End
            Else
            Begin
              Result := False;
            End;

          End
          Else
          Begin
            strCodOpe           := edtCodOpe.Text;
            objLisFre.strCodOpe := edtCodOpe.Text;
          End;

        End;

      End;

    End
    Else If (Sender = edtCodEmpresa) And (edtCodEmpresa.Enabled) Then
    Begin
      If (edtCodEmpresa.Text = VS_StrCodEmp) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Depósito Fechado deve ser diferente da empresa logada!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodDig) And (Sender.Parent.Enabled) And (Sender.Visible) Then
    Begin

      If fEmptyStr(edtCodDig.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Digitador deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin

        pCarregaDigitador;
        If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Digitador não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          strCodDig := qryConOpe.FieldByName('OPE_CODOPE').AsString;
        End;

      End;

    End
    Else If (Sender = mskCndPag) And (Not (RecNotEle.finalidadeXML = xmlDevolucaoEntradaEmitidaFornecedor)) And (Not mskCndPag.Enabled) And (Not fEmptyStr(recNotEle.strAutInc)) And (Length(ArrDuplicata^) > 0) Then
    Begin
      If (fCfgSis('CTPBOL', varBoolean)) And (chkVeioBo.Checked) And
         (fTiraCaracEspeciaisPonto(mskCndPag.Text) <> '01000') And
         (Not fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text))) And
         (ArrDuplicata[0].strSequen <> '') And Result Then
      Begin

        For intCont := 0 To (IIF(intQtdPar > 0,intQtdPar, 24) -1) Do
        Begin
          If fEmptyStr(arrLinDigCodbar[intCont].strCodBar) And fEmptyStr(arrLinDigCodbar[intCont].strLinDig) Then
          Begin
            pMensagemOk('A linha digitável e/ou código de barras deve ser preenchida de todas as parcelas!');
            Result := False;
            Break;
          End
          Else
          Begin
            If Not fEmptyStr(arrLinDigCodbar[intCont].strCodBar) Then
            Begin
              Result := TfrmDigCodBarBoleto.fValidaCodBar(arrLinDigCodbar[intCont].strCodBar,
                                                          arrLinDigCodbar[intCont].strLinDig,
                                                          ArrDuplicata[intCont].curValor,
                                                          ArrDuplicata[intCont].dtaDtaVen);
            End;
            If Not fEmptyStr(arrLinDigCodbar[intCont].strLinDig) And Result Then
            Begin
              Result := TfrmDigCodBarBoleto.fValidaLinDig(arrLinDigCodbar[intCont].strCodBar,
                                                          arrLinDigCodbar[intCont].strLinDig,
                                                          ArrDuplicata[intCont].curValor,
                                                          ArrDuplicata[intCont].dtaDtaVen);
            End;
          End;
        End;

        If Not Result Then
        Begin
          pCriarFormularios(TfrmDigCodBarBoleto, frmDigCodBarBoleto);
          frmDigCodBarBoleto.arrLinDigCodbar := arrLinDigCodbar;
          frmDigCodBarBoleto.arrDuplicata := arrDuplicata;
          Try

            Try
              frmDigCodBarBoleto.ShowModal;
            Except
            End;

          Finally

            Result := frmDigCodBarBoleto.blnConfirma;
            arrLinDigCodbar      := frmDigCodBarBoleto.arrLinDigCodbar;
            intQtdPar            := frmDigCodBarBoleto.intQtdPar;
            FreeAndNil(frmDigCodBarBoleto);

          End;

          If Not Result Then
            pMensagemOk('É preciso informar os códigos de barra ou a linha digitável!');
        End;
      End;
    End


    Else If (Sender = mskCndPag) And (((mskCndPag.Enabled) And (Sender.Parent.Enabled)) Or (RecNotEle.finalidadeXML = xmlDevolucaoEntradaEmitidaFornecedor)) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If fEhRecClienteGarantia(blnRecCliGarantia, cdsMovGad) And (fTiraCaracEspeciaisPonto(mskCndPag.Text) <> '01000') Then
      Begin
        fMensagem('ATENÇÃO!', 'A condição de pagamento para recebimento de cliente (garantia) deve ser a vista!', ['&O k']);
        Result := False;
      End
      Else If blnConEqu And (fTiraCaracEspeciaisPonto(mskCndPag.Text) <> '01000') Then
      Begin
        fMensagem('ATENÇÃO!', 'A condição de pagamento para a entrada de conserto de equipamento deve ser a vista!', ['&O k']);
        Result := False;
      End
      Else If StrToInt(Copy(mskCndPag.Text, 1, 2)) > 24 Then
      Begin
        fMensagem('', 'Não é permitido mais que 24 parcelas!', ['&O k']);
        Result := False;
      End
      Else If Not fValidaCndPag(mskCndPag.Text, strCndPag, dtaDtaDoc, True) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&O k']);
        Result := False;
      End
      Else If fEmptyStr(strCndPag) Then
      Begin
        Result := False;
      End

      Else If chkPgoAnt.Checked And (objPgoAnt.fRetQtdPagamentos + fQuantParcelasPagto(mskCndPag.Text) > 24) Then
      Begin
        pMensagemOk('A Quantidade de pagamentos antecipados mais a quantidades de parcelas restantes deve ser menor ou igual a 24!');
        Result := False;
      End

      Else If chkPgoAnt.Checked And fCfgSis('UTDCPP', varBoolean) And (objPgoAnt.fltTotSel = 0) Then
      Begin
        pMensagemOk('Necessário selecionar pelo menos um pagamento antecipado!');
        Result := False;
      End

      Else If (blnBuscaPorChave)                     Or
              (fEmptyStr(ArrDuplicata[0].dtaDtaVen)) Or
              (strCndAnt <> mskCndPag.Text)          Then
      Begin

        mskCndPag.Text := strCndPag;

        {********************************************}
        {* LIMPA A MATRIZ USADA NA FUNÇÃO DIGDUPLIC *}
        {*****************************************MV*}
        If Not blnPreCtp Then
          pZeraDigDuplic(ArrDuplicata^);

        If fTemAntecipadoValorMenor Or (Not chkPgoAnt.Checked) Then
        Begin

          pCalculaValorDocumento;

          fltValorRestante  := fltValorDocumento;

          {curTotDup := fTotalDuplicatas;
          if curTotDup > 0 Then
            fltValorRestante := curTotDup;}

          If fTemAntecipadoValorMenor Then
            fltValorRestante := fFormataFloat(fltValorRestante - objPgoAnt.fltTotSel, 2);

          If fltValorRestante < 0 Then
          Begin
            pMensagemOk('O (Total da Nota) - (Pagamento Antecipado) - (Total da Bonificação) está resultando em um valor menor que zero!');
            Result := False;
          End;

          If fltValorRestante > 0 Then
          Begin
            blnManterValoresOriginais := False;
            //Na entrada de mercadoria, deve se manter os valores digitados na pré-nota.
            //Se o usuário alterou o pagamento antecipado (para mais ou para menos) em relação
            //ao que foi originalmente carregado da pré-nota, os valores precisam ser recalculados.
            If (Not FblnAcessadoViaPrenota) And fCfgSis('UTDCPP', varBoolean) And (objPgoAnt.fltTotSel > 0) And
               (RoundTo(objPgoAnt.fltTotSel, -2) = RoundTo(fltTotSelPreNotaOriginal, -2)) Then
              blnManterValoresOriginais := True;

            Result := fDigDuplic(arrDuplicata^,
                                 mskCndPag.Text,
                                 0,
                                 fltValorRestante,
                                 (fStatusCndPag(mskCndPag.Text) = A_PRAZO),
                                 True,
                                 False,
                                 dtaDtaDoc,
                                 True,
                                 fStrToFloat(edtVlrCon.Text) - fStrToFloat(edtTotIte.Text),
                                 'S',
                                 fRetArred2ParcFornec(strCodFor),
                                 False,
                                 0,
                                 False,
                                 Nil,
                                 '',
                                 True,
                                 True,
                                 Nil,
                                 '',
                                 True,
                                 False,
                                 '',
                                 '',
                                 Nil,
                                 False,
                                 False,
                                 Nil,
                                 blnManterValoresOriginais);

            If chkPgoAnt.Checked Then
            Begin
              Result := Result And
                        objPgoAnt.fRecalculaPagamentosAntecipados(strNumDoc, strSerie, fltValorDocumento, objEspNota.arrParcelas, ArrDuplicata^);
            End;

            If Result And (Not blnRecCliGarantia) Then
            Begin
              pRefazCondPagamento;
            End;

            If (fCfgSis('CTPBOL', varBoolean)) And (chkVeioBo.Checked) And (fTiraCaracEspeciaisPonto(mskCndPag.Text) <> '01000') And
               Not fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text)) And (ArrDuplicata[0].strSequen <> '') And Result Then
            Begin
              pCriarFormularios(TfrmDigCodBarBoleto, frmDigCodBarBoleto);
              frmDigCodBarBoleto.arrLinDigCodbar := arrLinDigCodbar;
              frmDigCodBarBoleto.arrDuplicata := arrDuplicata;
              Try
                Try
                  frmDigCodBarBoleto.ShowModal;
                Except
                On E: Exception Do
                   Result := False;
                End;
                Finally
                Begin
                  arrLinDigCodbar      := frmDigCodBarBoleto.arrLinDigCodbar;
                  intQtdPar            := frmDigCodBarBoleto.intQtdPar;
                  FreeAndNil(frmDigCodBarBoleto);
                End;
              End;
            End;

          End;

          If (Result) Then
          Begin

            pHabilitaFinanceiro;

          End;

        End;

      End

      Else If (fCfgSis('CTPBOL', varBoolean)) And (chkVeioBo.Checked)
        And (fTiraCaracEspeciaisPonto(mskCndPag.Text) <> '01000')
          And Not fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text))
            And (ArrDuplicata[0].strSequen <> '') And Result Then
      Begin
        For intCont := 0 To (IIF(intQtdPar > 0,intQtdPar, 24) -1) Do
        Begin
          If fEmptyStr(arrLinDigCodbar[intCont].strCodBar) And fEmptyStr(arrLinDigCodbar[intCont].strLinDig) Then
          Begin
            pMensagemOk('A linha digitável e/ou código de barras deve ser preenchida de todas as parcelas!');
            Result := False;
            Exit;
          End
          Else
          Begin
            If Not fEmptyStr(arrLinDigCodbar[intCont].strCodBar) Then
            Begin
              Result := TfrmDigCodBarBoleto.fValidaCodBar(arrLinDigCodbar[intCont].strCodBar,
                                                          arrLinDigCodbar[intCont].strLinDig,
                                                          ArrDuplicata[intCont].curValor,
                                                          ArrDuplicata[intCont].dtaDtaVen);
            End;
            If Not fEmptyStr(arrLinDigCodbar[intCont].strLinDig) And Result Then
            Begin
              Result := TfrmDigCodBarBoleto.fValidaLinDig(arrLinDigCodbar[intCont].strCodBar,
                                                          arrLinDigCodbar[intCont].strLinDig,
                                                          ArrDuplicata[intCont].curValor,
                                                          ArrDuplicata[intCont].dtaDtaVen);
            End;
          End;
        End;
      End;
    End

    Else If (Sender = fraCentroCusto.edtCodEve) And (Sender.Parent.Enabled) Then
    Begin

      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        pCarregaEvento;
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
        If (fCfgSis('CTPOBE', varBoolean)) And (Not blnDevolu) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Centro de Custos deve ser preenchido!', ['&O k']);
          Result := False;
        End;
        fraCentroCusto.edtDesEve.Clear;
      End;

    End

    Else If (Sender = fraPlanoDeContas.MskCodCta) And (fraPlanoDeContas.MskCodCta.Enabled or blnDesmebrado) And (pnlContasPagar.Visible) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text)) Then
      Begin
        If blnDesmebrado Then
        Begin
          If (blnDevolu) Or (Not fCfgSis('USACTF', varBoolean)) or (blnConEqu) or (blnRecCliGarantia) Then
            fMensagem('ATENÇÃO!', 'O Plano de Contas ('+strCadPagDesmembramento+') não foi encontrado no cadastro!', ['&O k'])
          Else
            fMensagem('ATENÇÃO!', 'O Plano de Contas ('+strCadPagDesmembramento+')não está cadastrado ou não está vinculado ao fornecedor!', ['&O k']);
        End
        Else
          fMensagem('ATENÇÃO!', 'O Plano de Contas da Baixa deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaCentroCusto;
        If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          If (blnDevolu) Or (Not fCfgSis('USACTF', varBoolean)) or (blnConEqu) or (blnRecCliGarantia) Then
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k'])
          Else
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado ou não está vinculado ao fornecedor!', ['&O k']);

          Result := False;
        End
        Else If Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.MskCodCta.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Plano de Contas não permitido!', ['&O k']);

          If Not fraPlanoDeContas.MskCodCta.Enabled Then
            fraPlanoDeContas.MskCodCta.Enabled := True;

          Result := False;
        End
        Else If Not PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text) Then
          Result := False;
        If (Result) And (Not blnDevolu) then
        begin
          oParametros := TParametrosDesmembraValoresCtaDet.Create;
          try
            oParametros.strNumCta := fraPlanoDeContas.MskCodCta.Text;
            oParametros.strCodEve := fraCentroCusto.edtCodEve.Text;
            oParametros.frmCadPag := Self;
            oParametros.fltValDup := fstrToFloat(edtVlrCon.Text);
            oParametros.strCodEmp := VS_strCodEmp;
            oParametros.blnDireto := False;

            if fDesmembraValoresCtaDet(oParametros) then
            Begin
              fraPlanoDeContas.MskCodCta.Enabled := False;

              If fEmptyStr(oParametros.strCodCta) Then
                fraPlanoDeContas.MskCodCta.Text := fCfgSis('CTAPRI')
              Else
                fraPlanoDeContas.MskCodCta.Text := oParametros.strCodCta;

              cdsCtpDet.Data := oParametros.cdsTemp.Data;

              pCarregaCentroCusto;
              pSetFocus(Self);
            End
            Else
              fraPlanoDeContas.MskCodCta.Enabled := True;
          finally
            oParametros.free;
          end;
        end;
        pCarregaCentroCusto;
      End;
    End
    Else If (Sender = edtCodPor)       And
            (edtCodPor.Enabled) And
            (edtCodPor.Parent.Enabled) Then
    Begin
      edtNomPor.Clear;
      If Not fEmptyStr(edtCodPor.Text) Then
      Begin
        pCarregaPortador;
        If qryConPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else If (fStatusCndPag(mskCndPag.Text) = A_VISTA) Or ((Not blnDevolu) And fCfgSis('CTPOBP', varBoolean)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do portador deve ser preenchido!', ['&O k']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA COMPETENCIA                    *}
    {**************************************PA*}
    Else If (Sender = mskCompet) And (mskCompet.Enabled)  then
    Begin
      If not fValidaDataStr('01/'+ mskCompet.Text) Then
      Begin
        pMensagemOk('Data informada na Competência não é válida!');
        Result := False;
      end

      Else If fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) Then
      Begin
        pMensagemOk('A Competência deve ser preenchida!');
        Result := False;
      End

    End

    Else If (Sender = edtCodRep) Then
    Begin
      If fEmptyStr(edtCodRep.Text) Then
      Begin
        edtNomRep.Clear;
      End
      Else
      Begin

        pCarregaRepresentante;
        If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse representante não está cadastrado!', ['&O k']);
          Result := False;
        End

      End;

    End

    Else If (Sender = edtPesBru) Then
    Begin

      If edtPesBru.Visible Then
      Begin

        If fStrToFloat(edtPesBru.Text) < 0 Then
        Begin
          Result := False;
          pMensagemOk('O Peso Bruto deve ser maior ou igual a zero!');
        End

        Else edtPesBru.Text := FormatFloat('#0.000', fStrToFloat(edtPesBru.Text));

      End;

    End

    Else If (Sender = edtPesLiq) Then
    Begin

      If edtPesLiq.Visible Then
      Begin

        If fStrToFloat(edtPesLiq.Text) < 0 Then
        Begin
          Result := False;
          pMensagemOk('O Peso Líquido deve ser maior ou igual a zero!');
        End

        Else If fStrToFloat(edtPesLiq.Text) > fStrToFloat(edtPesBru.Text) Then
        Begin
          Result := False;
          pMensagemOk('O Peso Líquido deve ser menor ou igual ao Peso Bruto!');
        End

        Else edtPesLiq.Text := FormatFloat('#0.000', fStrToFloat(edtPesLiq.Text));

      End;

    End

    Else If (Sender = edtQtdVol) Then
    Begin

      If fStrToFloat(edtQtdVol.Text) < 0 Then
      Begin
        Result := False;
        pMensagemOk('A quantidade de volumes deve ser maior ou igual a zero!');
      End

      Else edtQtdVol.Text := FormatFloat('#0.000', fStrToFloat(edtQtdVol.Text));

    End

    Else If (Sender = edtChaNFE) then
    Begin
      If ( Length(edtChaNFE.Text) > 0) And (Not fValidaChaveAcessoNFE(edtChaNFE.Text)) Then
      Begin
        Result := False;
        pMensagemOk('Chave de Acesso Inválida');
      End
      Else If (Not blnNotaImp) And (Not fEmptyStr(edtChaNFE.Text)) And fExisteNotaEntradaChaveNFE(edtChaNFE.Text, strDocume) Then
      Begin
        fMensagem('ATENÇÃO!', 'Já existe um documento com essa chave no Livro Fiscal: ' + strDocume, ['&O k']);
        Result := False;
      End
      Else If (Not fEmptyStr(edtChaNFE.Text)) And (Not blnNotaImp) Then
      Begin
        If fEhFornecedor Then
        Begin
          if fCfgSis('VCHACE', varBoolean) Then
          Begin
            If (Not fValidaChaveAcessoNFE(edtChaNFE.Text, strCodFor, strNumDoc, strSerie, False,'', (SameText(strTipCgcCpf,'2')) )) Then
            Begin
              pMensagemOk('Chave de Acesso Inválida. Verifique o Fornecedor, Número do Documento[' + strNumDoc + '] e a Série [' + strSerie + ']');
              Result := False;
            End;
          End;
        End
        Else
        Begin
          If fCfgSis('VCHACE', varBoolean) Then
          Begin
            If Assigned(arrClienteConsumidor) And (Not fEmptyStr(arrClienteConsumidor[7])) Then
              Result := fValidaChaveAcessoNFE(edtChaNFE.Text, strCodFor, strNumDoc, strSerie, True, arrClienteConsumidor[7], (SameText(strTipCgcCpf,'2')))
            Else
              Result := fValidaChaveAcessoNFE(edtChaNFE.Text, strCodFor, strNumDoc, strSerie, True,'', (SameText(strTipCgcCpf,'2')));

            If Not Result Then
            Begin
              pMensagemOk('Chave de Acesso Inválida. Verifique o Cliente, Número do Documento[' + strNumDoc + '] e a Série [' + strSerie + ']');
            End;
          End;
        End;
      End;
    End

    Else If (Sender = cbxCodMod) And (Sender.Parent.Enabled) And (Sender.Visible)  Then
    Begin
      If cbxCodMod.ItemIndex < 0 Then
      Begin
        Result := False;
        pMensagemOk('O modelo do documento deve ser informado!');
      End;
    End;

    //*************************************************//
    // VERIFICA SE DEVE DESABILITAR OU NAO CHKBOX      //
    // "IMPRIME CP"                                    //
    //**********************************************ED*//
    If (Result) Then
    Begin
      If (fCfgSis('ENTCTP', varBoolean))               And
         (Pos(fRetClaFisCadFis(1), VS_strClaCom) > 0) And
         (blnForGCP) Then
      Begin
        chkImprCp.Enabled := True;
      End
      Else
      Begin
        chkImprCp.Enabled := False;
        chkImprCp.Checked := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmEntDadosFiscaisResumo.fValidaPagamentoAntecipadoAberto: Boolean;
Var
  qryGenPag: TUniQuery;
  strlDuplicatasSelecionadas: TStringList;
  fltTotalSelecionado: Double;
begin
  Result := False;
  strlDuplicatasSelecionadas := TStringList.Create;
  qryGenPag := fCriaQuery(Self);
  Try

    fltTotalSelecionado := 0;
    qryGenPag.SQL.Add('SELECT AUTOINCREM, CTP_PAGANT');
    qryGenPag.SQL.Add('FROM CADPAG CP WHERE');
    qryGenPag.SQL.Add('CTP_NUMDUP = :NUMDUP AND');
    qryGenPag.SQL.Add('CTP_CODFOR = :CODFOR AND');
    qryGenPag.SQL.Add('CTP_CODEMP = :CODEMP AND');

    If (fEmptyStr(strSerie)) Then
      qryGenPag.SQL.Add('((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = ""))')
    Else
      qryGenPag.SQL.Add('CTP_SERIE_ = :SERIE');

    qryGenPag.ParamByName('NUMDUP').AsString := strNumDoc;
    qryGenPag.ParamByName('CODFOR').AsString := strCodFor;
    qryGenPag.ParamByName('CODEMP').AsString := VS_strCodEmp;

    If (Not fEmptyStr(strSerie)) Then
      qryGenPag.ParamByName('SERIE').AsString := strSerie;

    qryGenPag.Open;

    if qryGenPag.RecordCount > 0 then
    begin
      if not chkPgoAnt.Checked then
      begin
        Result := True;
        Exit;
      end;

      objPgoAnt.pRetornaListaSelecao(strlDuplicatasSelecionadas, fltTotalSelecionado);

      if not (strlDuplicatasSelecionadas.Count > 0) then
      begin
        Result := True;
        Exit;
      end;

      qryGenPag.First;

      while not qryGenPag.Eof do
      begin
        if qryGenPag.FieldByName('CTP_PAGANT').AsString = 'S' then
        begin
          if not (strlDuplicatasSelecionadas.IndexOf(qryGenPag.FieldByName('AUTOINCREM').AsString) >= 0) then
          begin
            Result := True;
            Exit;
          end;
        end;

        qryGenPag.Next;
      end;
    end;
  Finally
    FreeAndNil(qryGenPag);
    FreeAndNil(strlDuplicatasSelecionadas);
  End;
end;

procedure TfrmEntDadosFiscaisResumo.pCarregaCentroCusto;
begin
  If fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
    Exit;

  If ((blnDevolu) Or (Not fCfgSis('USACTF', varBoolean)) or (blnConEqu) or (blnLocEqu) or (blnRecCliGarantia)) Or
     ((Assigned(cdsCtpDet)) And (Not cdsCtpDet.IsEmpty) And (fCfgSis('USACTF', varBoolean)) And (fraPlanoDeContas.MskCodCta.Text = fCfgSis('CTAPRI'))) Then
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text)
  Else
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text, True, strCodFor);

  With qryConCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
    fraPlanoDeContas.MskCodCta.Text := FieldByName('CTA_CODCTA').AsString;
  End;
end;

procedure TfrmEntDadosFiscaisResumo.pCarregaOperador;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtCodOpe.Text);
  With qryConOpe Do
  Begin
    edtNomOpe.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

function TfrmEntDadosFiscaisResumo.fRetClaFisCadFis(const AintIdx: Integer): String;
begin
  { Na Pré-Nota o dtsCadFis fica sem DataSet. Devolve vazio em vez de falhar porque há
    chamadas dentro de IIf, que avalia os dois ramos mesmo quando a Pré-Nota escolhe o outro. }
  Result := '';
  If Assigned(dtsCadFis.DataSet) And dtsCadFis.DataSet.Active Then
    Result := dtsCadFis.DataSet.FieldByName('FIS_CLFSC' + IntToStr(AintIdx)).AsString;
end;

function TfrmEntDadosFiscaisResumo.fRetVlrContabilCadFis: Double;
begin
  { Arredonda por FormatFloat, como a leitura anterior do valor já formatado em 2 casas.
    RoundTo diverge nos meios exatos (ex.: ,125) e mudaria o centavo enviado ao pagamento antecipado. }
  Result := 0;
  If Assigned(dtsCadFis.DataSet) And dtsCadFis.DataSet.Active Then
    Result := fStrToFloat(FormatFloat('0.00', dtsCadFis.DataSet.FieldByName('FIS_VLCONT').AsFloat));
end;

procedure TfrmEntDadosFiscaisResumo.pGetDisplayTextTitulo(Sender: TcxCustomEditorRowProperties;
  ARecord: Integer; var AText: String);
begin
  { Editores sem campo em vgrDetalhes: exibem o próprio Caption (título da linha ou da coluna) }
  AText := Sender.Caption;
end;

procedure TfrmEntDadosFiscaisResumo.pGetDisplayTextValor(Sender: TcxCustomEditorRowProperties;
  ARecord: Integer; var AText: String);
begin
  { Classificação sem uso deixa o campo null; na tela aparece 0,00. O dataset continua null,
    porque o cdsCadFis é gravado no CADFIS e lá null e zero não são a mesma coisa. }
  If fEmptyStr(AText) Then
    AText := FormatFloat('#,##0.00', 0);
end;

procedure TfrmEntDadosFiscaisResumo.pGetDisplayTextClaFis(Sender: TcxCustomEditorRowProperties;
  ARecord: Integer; var AText: String);
begin
  { Só exibição: classificação vazia aparece como '-'; o campo continua vazio no dataset }
  If fEmptyStr(Trim(AText)) Then
    AText := '-';
end;

procedure TfrmEntDadosFiscaisResumo.pAjustaLinhasDetalhes;
  Var
    blnReforma: Boolean;

  procedure pOcultaValorSemBase(const AstrCampoBase: String; ArowValor: TcxDBMultiEditorRow);
    Var
      intColuna: Integer;
  Begin
    ArowValor.Visible := False;
    For intColuna := 1 To 5 Do
      If dtsCadFis.DataSet.FieldByName(AstrCampoBase + IntToStr(intColuna)).AsFloat > 0 Then
      Begin
        ArowValor.Visible := True;
        Exit;
      End;
  End;

begin
  { Pré-Nota: sem DataSet e com o pnlDetalhes oculto }
  If (Not Assigned(dtsCadFis.DataSet)) Or (Not dtsCadFis.DataSet.Active) Then
    Exit;

  { Mesma regra de TfrmCadLivroFiscal.pJustaCamposImpostos (fTemValorBase): a linha do valor só
    aparece se alguma classificação tiver base maior que zero; a linha da base fica sempre. }
  pOcultaValorSemBase('FIS_BCRET', rowRetId);
  pOcultaValorSemBase('FIS_BASAN', rowAntIc);
  pOcultaValorSemBase('FIS_BAERE', rowVaeRe);
  pOcultaValorSemBase('FIS_BASIP', rowVlrIp);
  pOcultaValorSemBase('FIS_BAEIP', rowVaeIp);
  pOcultaValorSemBase('FIS_BFCPS', rowVFCPS);
  pOcultaValorSemBase('FIS_QBCMO', rowValMo);

  { Bloco da Reforma só existe com a configuração ligada, como o pnlContainerReforma do livro
    fiscal; dentro dele vale a mesma regra base/valor dos demais pares }
  blnReforma := fSomarNovosImpostosDaReformaAoValorContabil;
  rowBcCbs.Visible := blnReforma;
  rowBcIbs.Visible := blnReforma;
  rowBc_Is.Visible := blnReforma;
  pOcultaValorSemBase('FIS_BCCBS', rowVlCbs);
  pOcultaValorSemBase('FIS_BCIBS', rowVlIbs);
  pOcultaValorSemBase('FIS_BC_IS', rowVl_Is);
  rowVlCbs.Visible := rowVlCbs.Visible And blnReforma;
  rowVlIbs.Visible := rowVlIbs.Visible And blnReforma;
  rowVl_Is.Visible := rowVl_Is.Visible And blnReforma;
end;

// Com skin, o TfrmPai troca o azul $00FFE4D5 do pnlDetalhes pela cor de painel do estilo, mas não
// alcança o TcxStyle dos títulos nem o fundo vazio e as linhas das células do grid, que continuariam azuis.
procedure TfrmEntDadosFiscaisResumo.pAjustarFundoTema;
begin
  If blnUsuarioLogadoUtilizaModoClassico Then
    Exit;

  If TStyleManager.ActiveStyle.Name <> AUTCOM_STYLE_NAME Then
    Exit;

  cxsTituloDetalhes.Color := TStyleManager.ActiveStyle.GetStyleColor(scPanel);
  vgrDetalhes.OptionsView.GridLineColor := cxsTituloDetalhes.Color;
end;

procedure TfrmEntDadosFiscaisResumo.pGetContentStyleDetalhes(Sender: TObject;
  AEditProp: TcxCustomEditorRowProperties; AFocused: Boolean; ARecordIndex: Integer;
  var AStyle: TcxStyle);
begin
  { Editor sem campo é título (linha ou coluna) ou espaçador entre colunas, que faz o papel da
    linha vertical: com o cabeçalho oculto o grid não desenha divisor entre os editores }
  If (AEditProp Is TcxDBEditorRowItemProperties) And
     fEmptyStr(TcxDBEditorRowItemProperties(AEditProp).DataBinding.FieldName) Then
    AStyle := cxsTituloDetalhes;
end;

procedure TfrmEntDadosFiscaisResumo.pGerarLotesADefinirParaGranitoMarmore;
var qryGenerica, qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  qryGenerica := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT ENT_CODITE FROM TMP_ENTMER ');
    qryConsulta.SQL.Add('  LEFT JOIN CADLOT ON LOT_CODEMP = "' + VS_StrCodEmp + '"');
    qryConsulta.SQL.Add('                  AND LOT_NUMLOT = "A DEFINIR"');
    qryConsulta.SQL.Add('                  AND LOT_CODITE = ENT_CODITE  ');
    qryConsulta.SQL.Add(' WHERE ENT_GRAMAR = "S"  ');
    qryConsulta.SQL.Add('   AND CADLOT.AUTOINCREM IS NULL ');

    qryConsulta.Open;
    qryGenerica.SQL.Text := 'SELECT * FROM CADLOT WHERE FALSE';
    qryGenerica.Open;

    While Not qryConsulta.Eof Do
    Begin
      qryGenerica.Insert;
      qryGenerica.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADLOT', VS_StrCodEmp);
      qryGenerica.FieldByName('LOT_NUMLOT').AsString   := 'A DEFINIR';
      qryGenerica.FieldByName('LOT_CODEMP').AsString   := VS_StrCodEmp;
      qryGenerica.FieldByName('LOT_CODITE').AsString   := qryConsulta.FieldByName('ENT_CODITE').AsString;
      qryGenerica.FieldByName('LOT_DTAFAB').Value      := VS_Date;
      qryGenerica.FieldByName('LOT_DTAVAL').Value      := IncYear(VS_Date);
      qryGenerica.FieldByName('LOT_DTABAL').Value      := VS_Date -1;//Nao pode ser VS_date, na data de balanco nao pode existir movimentacao
      qryGenerica.FieldByName('LOT_SALBAL').AsFloat    := 0;
      qryGenerica.FieldByName('LOT_SALDOS').AsFloat    := 0;
      qryGenerica.FieldByName('LOT_ML_BAL').AsFloat    := 0;
      qryGenerica.FieldByName('LOT_SAL_ML').AsFloat    := 0;
      qryGenerica.FieldByName('LOT_SALCON').Value      := Null;
      qryGenerica.FieldByName('LOT_DIGCON').AsString   := 'N';
      qryGenerica.FieldByName('LOT_ORDCON').Value      := Null;
      qryGenerica.FieldByName('LOT_DIFSAL').AsFloat    := 0;
      qryGenerica.FieldByName('LOT_LOCFIS').AsString   := '';
      qryGenerica.Post;
      qryConsulta.Next;
    End;

  Finally
    FreeAndNil(qryConsulta);
    FreeAndNil(qryGenerica);
  End;
end;

procedure TfrmEntDadosFiscaisResumo.btnConfirmaClick(Sender: TObject);
  Var
    strDocCon,
    strDocFre,
    strSeqGer,
    strListaItens: String;
    strAutIncCadFis : String;
    fltConFre: Double;
    objAtuFor: TAlteraFornecedorEntrada;
    intCtpCon: Longint;
    strOutIncMovGer: string;
    blnGravouMovDet,
    blnGerouLotDePreco: Boolean;
    frmLotePrecosEfetivacaoCx: TfrmLotePrecosEfetivacaoCx;
    objEmissaoNotaEspecial: TEmissaoNotaEspecial;
    blnGerarLoteADefinirParaGranitos,
    blnDevolucaoConsignacaoNormal,
    blnDevolucaoConsignacaoSimbolica : Boolean;
    intIdx : Integer;
    blnResult: boolean;
    blnBaixarNotGer: Boolean;
    strEmpFat, strSerFat, strCodCli: String;
    cdsPrecosEntMer: TDataSet;
    ArrCteMov: TArrCteMov;
    strEmpresaAbastecimentoDeposito: String;
    blnGerarContasAPagarx117: Boolean;
    strHistoricoEntradaFrete: String;
    objLiberacao : TLiberacao;
    strCodErrosAuditoria: String;
    strMsgConfirmacaoEntImo: String;
    strItensPatImo: String;
    strItensCadastradosPatImo: String;
    strClaFisEnt: String;
begin
  inherited;
  blnBaixarNotGer := fEhOperacaoTransferenciaEstoque(strNumDoc, strEspDoc, strCodFor, strEmpFat, strCodCli, strSerFat);
  objGnreST.FblnComNFE := Not fEmptyStr(recNotEle.strAutInc);
  objGnreTributado.FblnComNFE := Not fEmptyStr(recNotEle.strAutInc);
  objGnreTCIF.FblnComNFE := Not fEmptyStr(recNotEle.strAutInc);
  objGnreTS.FblnComNFE := Not fEmptyStr(recNotEle.strAutInc);
  strHistoricoEntradaFrete := '';

  If (recNotEle.finalidadeXML = xmlRetornoSimbolico) Then
  begin
    chkGraFin.Checked := False;
    strCodOpe := strLoginUsuarioLogado;
  End;

  If Not btnConfirma.Enabled Then
    Exit;

  pSetFocus(btnConfirma);
  Application.ProcessMessages;

  If (RoundTo(fltValAnt, -2) > 0) Then
  Begin

    If fEmptyStr(fRetNomFornecedor(fCfgSis('ANTFOR'))) Or
       fEmptyStr(fRetNomeConta(fCfgSis('ANTCTA'))) Then
    Begin
      pMensagemOk('Configure as informações para a gravação do ICMS Antecipado: CFG_ANTFOR e CFG_ANTCTA !');
      Exit;
    End;

  End;

  If Not fValidaObrigatoriedadeChaveModelo(edtChaNFE.Text, fGetModDocumentocbxCODMOD) Then
  Begin
    pMensagemOk('O Modelo selecionado exige a chave de acesso!');
    Exit;
  End;

  if (not blnTravarFinanceiroEstaDuplicado) and fValidaPagamentoAntecipadoAberto then
  begin
    pMensagemOk('Existe duplicata no contas a pagar com esses dados não vinculada!');
    Exit;
  end;

  if FblnAcessadoViaRetornoConsignacao then
  Begin
    blnDevolucaoConsignacaoNormal    := False;
    blnDevolucaoConsignacaoSimbolica := False;

    for intIdx := 1 to 5 do
    Begin
      if Pos(fRetClaFisCadFis(intIdx), fTransform(fCfgSis('RETCON'), 4)) > 0 then
        blnDevolucaoConsignacaoNormal := True;

      if Pos(fRetClaFisCadFis(intIdx), fTransform(fCfgSis('CLADSC'), 4)) > 0 then
        blnDevolucaoConsignacaoSimbolica := True;

      if (blnDevolucaoConsignacaoNormal) and (blnDevolucaoConsignacaoSimbolica) then
      Begin
        pMensagemOk('Não é permitido mescla de classificação fiscal de devolução de consignação normal '+
                    'com devolução de consignação simbólica, favor revisar as classificações informadas e as configurações "RETCON" e "CLADSC".');
        Exit;
      End;
    End;
  End;

  If Not fVerificaCampos Then
    Exit;


  If Not fLiberarValorBoleto Then
    Exit;

  If chkGraFin.Checked And (not fValidaVencimento(ArrDuplicata^)) then
  begin

    If (fCfgSis('PARVEN', varString) = 'A') Then
    Begin
      pCriarFormularios(TfrmEntConfirmaVencimento, frmEntConfirmaVencimento);
      frmEntConfirmaVencimento.ShowModal;
      if frmEntConfirmaVencimento.ModalResult <> mrOk then
      begin
        pFreeAndNil(frmEntConfirmaVencimento);
        Exit;
      end
      else
        pFreeAndNil(frmEntConfirmaVencimento);
    End
    Else
    Begin
      objLiberacao := TLiberacao.Create;
      Try
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddSeparador(113);
        objLiberacao.objMsgLibera.pAddTexto('Confirmação de Vencimento de Duplicata com data anterior à hoje.');
        objLiberacao.objMsgLibera.pAddSeparador(113);
        objLiberacao.objMsgLibera.pAddTexto('Atenção, existe(m) duplicata(s) de contas a pagar gerada(s) por esta nota fiscal, com');
        objLiberacao.objMsgLibera.pAddTexto('vencimento anterior à hoje, ocasionado pela data documento ser anterior à data de entrada.');
        objLiberacao.objMsgLibera.pAddTexto('Necessário a senha de liberação para concluir a entrada de mercadorias.');
        objLiberacao.objMsgLibera.pAddSeparador(113);
        objLiberacao.strDirAce := 'LIBPARVEN';
        objLiberacao.strMsgSen := 'Confirmação de Vencimento de Duplicata com data anterior à hoje';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;

        If Not objLiberacao.fLibera Then
          Exit;

      Finally
        FreeAndNil(objLiberacao);
      End;

    End;
  End;


  btnConfirma.Enabled := False;

  If FblnAcessadoViaPrenota Then
  Begin
     If ((fMensagem('', 'Confirma gravação?', ['&Sim', '&Não']) = 1) And
           objFechamentoEstoque.fVeSeTravaFechamentoEstoque(traMovimentacao, dtaDtaEnt) And
           objFechamentoFiscal.fVeSeTravaFechamentoFiscal(trfMovimentacao, dtaDtaEnt)) Then
     Begin
        //FECHAMENTO FINANCEIRO
        If chkGraFin.Checked then
        Begin
          If objFechamentoFinanceiro.FechamentoFinanceiroJaRealizado(VS_StrCodEmp, dtaDtaEnt) then
          begin
            blnConfirma := False;
            btnConfirma.Enabled := True;
            Exit;
          end;
        End;


       pApagaExistentePreCtp(recNotEle.strAutInc);



       objPgoAnt.fGravaPrePga(recNotEle.strAutInc);

       blnConfirma := fGravaPreCtp;
       Close;
       Exit;
     End
     Else
      Exit;
  End;

  pAtualizaICMSFrete(objLisFre.fGetAliquotaFrete);

  // Req. 458295 - Atualiza qryEntMer para que ENT_FRECON (rateio CT-e) e
  // ENT_ICMCFR (atualizado por pAtualizaICMSFrete) sejam lidos atualizados
  // por fVerificaItensAbaixoPrecoMedio. Ambos são gravados em TMP_ENTMER
  // por ExecSQL direto sem reabrir o dataset.
  qryEntMer.Refresh;

  If (not (blnGarantia or blnRecCliGarantia or FblnAcessadoViaRetornoConsignacao)) and
     fCfgSis('ATUFOR', varBoolean) And (Pos(strCodFor, fRetForFilialTodos) = 0) And (Not blnDevolu) and (not blnConEqu) and (not blnLocEqu) Then
  Begin
     objAtuFor := TAlteraFornecedorEntrada.Create(Nil, strCodFor);
     objAtuFor.pMostraItens;
  End Else
  Begin
    objAtuFor := Nil;
  End;

  If (qryEntMer.FieldByName('ENT_PREGNR').AsString = 'S') And (fStrToFloat(objGnreST.strValGnr) <= 0) Then
    objGnreST.pVerificaPrevia;

  If (recNotEle.finalidadeXML = xmlRetornoSimbolico)  or
     ((fMensagem('', 'Confirma gravação?', ['&Sim', '&Não']) = 1) And
     (blnDevolu Or

      fAbreTelaAutorizacao(blnNotaImp,
                           qryEntMer,
                           strNumDoc,
                           strEspDoc,
                           VS_strCodEmp,
                           strSerie,
                           strCodFor,
                           IIF(chkAtuPre.Checked, 'S', 'N'),
                           objAtuFor,
                           dtaDtaEnt,
                           blnPrecoPraticado,
                           blnConEqu or blnLocEqu,
                           fltCotDol,
                           blnEncargosNoFrete)

                           ) and
     objFechamentoEstoque.fVeSeTravaFechamentoEstoque(traMovimentacao, dtaDtaEnt) And
     objFechamentoFiscal.fVeSeTravaFechamentoFiscal(trfMovimentacao, dtaDtaEnt)) Then
  Begin
    If Not objOutDes.blnRateioManual Then
      objOutDes.fRateiaOutrasDespesas;
    objVendor.fRateiaVendor;

    //FECHAMENTO FINANCEIRO
    if chkGraFin.Checked then
    Begin
      if objFechamentoFinanceiro.FechamentoFinanceiroJaRealizado(VS_StrCodEmp, dtaDtaEnt) then
      begin
        blnConfirma := False;
        Exit;
      end;
    End;

    Try

      //Vincula com documento de entrega futura.

      If TfrmVinculoBaixaEntregaFuturaEdocVenda.fTemCFOP_922 Then
        TipoCFOP := tcCFOP922
      Else If TfrmVinculoBaixaEntregaFuturaEdocVenda.fTemCFOP_117 Then
        TipoCFOP := tcCFOP117
      Else
        TipoCFOP := tcCFOPNormal;

      If (TipoCFOP = tcCFOP117) And (Not TfrmVinculoBaixaEntregaFuturaEdocVenda.fVincularX922_x117(recNotEle.strAutInc)) Then
      Begin
        btnConfirma.Enabled := True;
        Exit;
      End;

      If Not fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        objEmissaoNotaEspecial := TEmissaoNotaEspecial.Create;
        objEmissaoNotaEspecial.pCriaObjetosExt;
      End;

      blnGerarLoteADefinirParaGranitos := False;
      If fTemItemMarmoreGranitoSemLoteADefinirCadastrado then
        blnGerarLoteADefinirParaGranitos := true;

      If (fCfgSis('MONPRC', varBoolean) And fCfgSis('ATPRAU', varBoolean) And (Not fCfgSis('LOTPRE', varBoolean))) Then
      Begin
        cdsPrecosEntMer := objAvisoAlteracaoPreco.fCriaCdsPrecosEntMer;
        pProcessaPrecoDeVendaEMargem(blnNotaImp,
                                     qryEntMer,
                                     cdsPrecosEntMer,
                                     cdsMovGad,
                                     blnConEqu or blnLocEqu,
                                     recNotEle.strAutInc,
                                     strNumDoc,
                                     strCodFor,
                                     strSerie,
                                     fltCotDol,
                                     objAtuFor,
                                     Nil,
                                     blnPrecoPraticado,
                                     IIF(chkAtuPre.Checked, 'S', 'N'),
                                     blnEncargosNoFrete,
                                     blnGarantia,
                                     blnRecCliGarantia,
                                     FblnAcessadoViaRetornoConsignacao,
                                     RecNotEle.finalidadeXML,
                                     edtCodEmpresa.Text);
        objAvisoAlteracaoPreco.FcdsDados := cdsPrecosEntMer;
        If Not objAvisoAlteracaoPreco.fVerificaOscilacao(tpEntMer) Then
        Begin
          btnConfirma.Enabled := True;
          Exit;
        End;
      End;
      blnGerarContasAPagarx117 := False;


        If blnTemDupEle And
           (Pos(fRetClaFisCadFis(1), '_1116_2116_1117_2117') > 0) And
           (Pos(fRetClaFisCadFis(1), VS_strClaCom)  = 0) And
           (fCfgSis('ENTCTP', varBoolean))  And
           fFornecedorGravaCtp(strCodFor) Then
          blnGerarContasAPagarx117 := TfmrConfirmaCTP117.fPerguntaGravaCadPag(arrDuplicata^);

      objAuditoriaSaldo.Limpar;

      If FblnAcessadoViaRetornoConsignacao And
         (Not fValidaNotaPossuiItensDevolvidosFaturados(recNotEle)) Then
      Begin
        Exit;
      End;

      fStartTransaction;

      intCtpCon := fRetCtpCon;

      If Assigned(objAtuFor) Then
        objAtuFor.pAtualizaItens;

      strDocCon := TEntradaAutomatizada.fRetDocCon(strNumDoc, strEspDoc, strSerie, strCodFor);

      If Assigned(objLisFre) Then
      Begin
        strDocFre := '';
        fltConFre := objLisFre.fltValCon;
      End Else
      Begin
        strDocFre := '';
        fltConFre := 0;
      End;

      If blnGerarLoteADefinirParaGranitos Then
        pGerarLotesADefinirParaGranitoMarmore;

      dtsCadFis.DataSet.Edit;
      dtsCadFis.DataSet.FieldByName('FIS_HISTOR').AsString := edtHistorioLivroFiscal.Text;
      dtsCadFis.DataSet.Post;

      strEmpresaAbastecimentoDeposito := fRetEmpresaAbastecimentoDepositoNaDevolucaoDaNota(strDocSel);

      If Assigned(objVendor) And fCfgSis('UTDCPP', varBoolean) Then
      Begin
        objVendor.strAutInc := recNotEle.strAutInc;
        objVendor.pCarregarPreCtp;
      End;

      blnResult := fConfirmaEntradaMercadorias(strSeqGer,
                                   strListaItens,
                                   ArrCteMov,
                                   blnGravouMovDet,
                                   blnGerouLotDePreco,
                                   strMatRev,
                                   blnNotaImp,
                                   objAtuFor,
                                   objDefBaixa,
                                   arrLinDigCodbar,
                                   fltCotDol,
                                   fStrToFloat(edtValFre.Text),
                                   edtCodOpe.Text,
                                   mskCndPag.Text,
                                   edtCodPor.Text,
                                   fraPlanoDeContas.MskCodCta.Text,
                                   strCodFor,
                                   strCodFaz,
                                   strNumDoc,
                                   strEspDoc,
                                   dtaDtaEnt,
                                   dtaDtaDoc,
                                   dtaIcmAnt,
                                   strSerie,
                                   strEstFor,
                                   IIF(chkVeiobo.Checked, 'S', 'N'),
                                   IIF(chkDeposi.Checked, 'S', 'N'),
                                   edtEspVol.Text,
                                   fStrToFloat(edtQtdVol.Text),
                                   fltAlqFor,
                                   pgbDadosFiscais,
                                   fraCentroCusto.edtCodEve.Text,
                                   blnDevolu,
                                   strCodDig,
                                   edtCodRep.Text,
                                   chkGraFin.Checked,
                                   chkImprCp.Checked,
                                   mmoHisCta.Text,
                                   fltTotPis,
                                   fltTotCof,
                                   fltBasPis,
                                   fltBasCof,
                                   fltAlqPis,
                                   fltAlqCof,
                                   edtCodCon.Text,
                                   oleItensPedidos,
                                   strOrdIte,
                                   Self.Name,
                                   blnCarPro,
                                   recNotEle.strAutInc,
                                   cbxModFre.Text[1],
                                   edtChaNFE.Text,
                                   strMotDev,
                                   qryEntMer,
                                   objVendor,
                                   objOutDes,
                                   cdsCtpDet,
                                   strAutIncCadFis,
                                   ArrDuplicata^,
                                   objEmbala,
                                   dtsCadFis.DataSet,
                                   strDocFre,
                                   fltConFre,
                                   strAutDev,
                                   intCtpCon,
                                   strOutIncMovGer,
                                   fStrToFloat(edtPesBru.Text),
                                   fStrToFloat(edtPesLiq.Text),
                                   IIF(chkAtuPre.Checked, 'S', 'N'),
                                   fltAntIcF,
                                   fltBasAnF,
                                   blnGarantia,
                                   blnRecCliGarantia,
                                   cdsMovGad,
                                   arrDocOri,
                                   blnPedFilialGarantia,
                                   blnConEqu or blnLocEqu,
                                   blnDescontoIncondicional,
                                   blnFreIpi,
                                   blnPrecoPraticado,
                                   frmVinculoBaixaEntregaFuturaEdocVenda,
                                  {Não vai movimentar saldo se a classificação fiscal estiver
                                   na configuração CFG_CLARET}
                                   not chkRealizaMovimentacaoDeSaldo.Checked,
                                   strBcoFor,
                                   fGetModDocumentocbxCODMOD,
                                   nil,
                                   mskCompet.Text,
                                   arrClienteConsumidor,
                                   onBeforeConfirmaEntrada,
                                   onAfterConfirmaEntrada,
                                   recNotEle.finalidadeXML,
                                   frmEntRetencaoNotaServico,
                                   FblnAcessadoViaRetornoConsignacao,
                                   FTipoRetornoConsignacao,
                                   RecNotEle.strExtFul,
                                   recNotEle.strCodExt,
                                   RecNotEle.finalidadeXML = xmlRetornoSimbolico,
                                   objEmissaoNotaEspecial,
                                   edtCodEmpresa.Text,
                                   blnEncargosNoFrete,
                                   TipoCFOP,
                                   blnFornJaAtualizado,
                                   IIF(fEmptyStr(strEmpresaAbastecimentoDeposito), False, True),
                                   blnGerarContasAPagarx117,
                                   strCodConPagCliDev,
                                   chkPrevisao.Checked) And

                   fAtualizaPedidoDevolucao(strNumDoc,
                                           strEspDoc,
                                           edtCodOpe.Text,
                                           strCodDig,
                                           mskCndPag.Text,
                                           fStrToFloat(edtVlrCon.Text)) And

                   obJGnreSt.fGravaGnre(strNumDoc, strEspDoc, strSerie, strCodFor, strCodOpe, Self.Name, chkImprCp.Checked, dtaDtaDoc, strAutIncCadFis) And
                   obJGnreTributado.fGravaGnre(strNumDoc, strEspDoc, strSerie, strCodFor, strCodOpe, Self.Name, chkImprCp.Checked, dtaDtaDoc, strAutIncCadFis) And
                   obJGnreTCIF.fGravaGnre(strNumDoc, strEspDoc, strSerie, strCodFor, strCodOpe, Self.Name, chkImprCp.Checked, dtaDtaDoc, strAutIncCadFis) And
                   obJGnreTS.fGravaGnre(strNumDoc, strEspDoc, strSerie, strCodFor, strCodOpe, Self.Name, chkImprCp.Checked, dtaDtaDoc, strAutIncCadFis) And

                   ((Not chkPgoAnt.Checked) Or objPgoAnt.fGravaPgtosAntecipados(strSeqGer, strNumDoc, strSerie, fltValorDocumento, fRetHistoricoRetencao(dtsCadFis.DataSet, fStrToFloat(edtVlrCon.Text)))) And
                   fGravaAgendamentoDeRecebimento(strSeqGer);

      If blnResult Then
      Begin
        objAuditoriaSaldo.Adicionar(strOutIncMovGer, 'MOVGER');

        If (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
        Begin
          blnResult := False;
          fRollBack;
          pMostraErrosAuditoria(strCodErrosAuditoria);
        End;
      End;

      if blnResult then
      begin
        if Assigned(fAoConfirmarEntrada) then
          blnResult := fAoConfirmarEntrada(Self, strSeqGer);
      end;

      if blnResult then
      Begin
        if not fEmptyStr(strEmpresaAbastecimentoDeposito) then
          pTransferirEstoqueAbastecimentoDeposito(strSeqGer, strEmpresaAbastecimentoDeposito);

        if blnBaixarNotGer then
          fBaixaNotaConf(strNumDoc, strEspDoc, strEmpFat, strSerFat, strCodCli);

        strHistoricoEntradaFrete := strHistoricoEntradaFrete + ' DTA. EMISSÃO: ' + DateToStr(dtaDtaEnt) +
                                                                 ' FORNECEDOR: ' + strCodFor + ' - ' + fRetNomFornecedor(strCodFor) +
                                                                  ' DOCUMENTO: ' + strNumDoc +  ' - ' +
                                                                                   strEspDoc ;
        {*******************************************************}
        {* REALIZA GRAVAÇÃO DO FRETE DE CONHECIMENTO SE HOUVER *}
        {****************************************************AF*}
        If (Not objLisFre.IsEmpty) And (Assigned(qryEntMer)) And (qryEntMer.RecordCount > 0) Then
          strClaFisEnt := qryEntMer.FieldByName('ENT_CLAFIS').AsString
        Else
          strClaFisEnt := '';

        If objLisFre.fConfirmaFreConhecimento(edtCodPor.Text, Self.Name, strSeqGer, ArrCteMov, strHistoricoEntradaFrete, strClaFisEnt) Then
        Begin
          strAutInc := strSeqGer;
          strChaNFe := edtChaNFE.Text;
          { Cria as mensagem para exibir para os vendedores que seus pedidos podem ser atendidos ou parcialmente atendidos }
          If Not (RecNotEle.finalidadeXML = xmlRetornoSimbolico) Then
            TGeraMensagemPedidoCompraAtendido.pGerarNotificaoParaVendedoresComVendaPendente(strOutIncMovGer, stlPedidos, qryEntMer, edtCodOpe.Text);

          If (VS_strHabilitarCRM) Then
          Begin
            TUpdateOccurrenceCRM.New()
              .NumDoc(strNumDoc)
              .CodEmp(VS_strCodEmp)
              .EspDoc(strEspDoc)
              .strNomFrm(Self.Name)
              .AcaFat(afcPedidoEntradaMercadoria)
              .pRun();
          End;

          fCommit;

          Try
            pCriarFormularios(TFrmManipulaContasPagarPrevisaoNao, frmManipulaContasPagarPrevisaoNao) ;
            frmManipulaContasPagarPrevisaoNao.pCarregarDadosCtaPagarComPrevisaoNao(strNumDoc, strCodFor, strSerie, dtaDtaDoc);
            if frmManipulaContasPagarPrevisaoNao.fCarregarDadosCtaPagarComPrevisaoSim then
              frmManipulaContasPagarPrevisaoNao.showModal;
          Finally
            FreeAndNil(frmManipulaContasPagarPrevisaoNao);
          End;

          If blnDevolu Then
          Begin
            If fCfgSis('EXISTA', varBoolean) Then
              pAtualizaStatusPedidoDevolucao;
          End;

          blnConfirma := True;
          If Not (RecNotEle.finalidadeXML in [xmlRetornoSimbolico, xmlDevolucaoEntradaEmitidaFornecedor]) Then
            pImprimeCPs;

          Close;
          If Not (RecNotEle.finalidadeXML in [xmlRetornoSimbolico, xmlDevolucaoEntradaEmitidaFornecedor]) Then
          Begin
            If fVerificaAcessoSistema('frmLotePrecosEfetivacao') And
               fCfgSis('ENTEFE', varBoolean) And blnGerouLotDePreco And
               (Not fConferenciaDepoisDaEntrada) Then
            Begin
              pCriarFormularios(TfrmLotePrecosEfetivacaoCx, frmLotePrecosEfetivacaoCx);
              Try
                frmLotePrecosEfetivacaoCx.pSetDocumentoDeEntradaLotePreco(strNumDoc,
                                                                          strEspDoc,
                                                                          strSerie,
                                                                          strCodFor,
                                                                          '',
                                                                          fltCotDol,
                                                                          True);
                frmLotePrecosEfetivacaoCx.ShowModal;
              Finally
                FreeAndNil(frmLotePrecosEfetivacaoCx);
              End;
            End;
          End;

        End Else
        Begin
          fRollBack;
          If Assigned(frmVinculoBaixaEntregaFuturaEdocVenda) Then
            frmVinculoBaixaEntregaFuturaEdocVenda.pRestauraID;
          pgbDadosFiscais.Position := 0;
        End;

      End Else
      Begin
        fRollBack;
        If Assigned(frmVinculoBaixaEntregaFuturaEdocVenda) Then
          frmVinculoBaixaEntregaFuturaEdocVenda.pRestauraID;
        pgbDadosFiscais.Position := 0;
      End;

      If blnResult Then
      Begin
        If fCfgSis('ENTIMO', varBoolean) Then
        Begin
          pGetMsgItensAtivoImobilizado(strMsgConfirmacaoEntImo, strItensPatImo, strNumDoc, strEspDoc, strSerie, strCodFor);
          If Not fEmptyStr(strMsgConfirmacaoEntImo) Then
          Begin
            If fMensagem('', strMsgConfirmacaoEntImo, ['&Sim', '&Não']) = 1 Then
            Begin
              blnResult := fCadastroAutomaticoAtivosImobilizados(strItensCadastradosPatImo, strItensPatImo, strNumDoc, strEspDoc, strSerie, strCodFor, fTiraCaracEspeciaisPonto(mskCndPag.Text), dtaDtaEnt);

              If blnResult Then
                fMensagem('', 'Itens cadastrados com sucesso:' + #13#10 + strItensCadastradosPatImo, ['&Ok']);
            End;
          End;
        End;
      End;

    Except
      On E: Exception Do
      Begin
        fRollBack;

        If Assigned(frmVinculoBaixaEntregaFuturaEdocVenda) Then
          frmVinculoBaixaEntregaFuturaEdocVenda.pRestauraID;

        pgbDadosFiscais.Position := 0;
        pMensagensErro(E.Message, '[TfrmEntDadosFiscaisResumo.btnConfirmaClick]');
        blnConfirma := False;
      End;
    End;

    objFechamentoEstoque.pDestravaFechamentoEstoque(traMovimentacao);
    objFechamentoFiscal.pDestravaFechamentoFiscal(trfMovimentacao);

  End;
  If Not (recNotEle.finalidadeXML = xmlRetornoSimbolico) Then
  Begin

  If Assigned(objEmissaoNotaEspecial) Then
  begin
    If objEmissaoNotaEspecial.strMsgNota <> '' Then
      pMensagemOk(objEmissaoNotaEspecial.strMsgNota);

    FreeAndNil(objEmissaoNotaEspecial);
  End;

   If blnConfirma And (Not blnDevolu) And fCfgSis('ENTETI', varBoolean) And (Not fCfgSis('LOTPRE', varBoolean)) And (Not (RecNotEle.finalidadeXML = xmlDevolucaoEntradaEmitidaFornecedor)) Then
      pImprimeEtiqueta;

    If blnConfirma  And fCfgSis('IMPLIB', varBoolean) Then
      pImprimeLiberacaoArmazenamento;

    If blnConfirma AND fCfgSis('ENTLIS', varBoolean) Then
      pMonstraItensImprimeLista(strListaItens);

    If Assigned(objAtuFor) Then
      FreeAndNil(objAtuFor);
  End;

  // Se nao deu certo a gravação precisa voltar para a tela anterior
  // senao vai dar erro em cdsDefBaixa.fSalva
  If Not blnConfirma Then
    Self.Close;

  btnConfirma.Enabled := True;

end;

procedure TfrmEntDadosFiscaisResumo.pMonstraItensImprimeLista(strItens: String);
  Var
    objImpLis: TEntImprimeLista;
Begin
  objImpLis := TEntImprimeLista.Create(Self, strItens);
  Try
    objImpLis.pMostraItens;
  Finally
    FreeAndNil(objImpLis);
  End;
End;

procedure TfrmEntDadosFiscaisResumo.pCalculaTotaisCabecalho;
  Var
    strSQL   : String;
    qryGenMer: TUniQuery;

begin
  Try

    qryGenMer := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  SUM(ENT_VALRET) AS ENT_VALRET, ';
    strSQL := strSQL + '  SUM(ENT_VALANT) AS ENT_VALANT, ';
    strSQL := strSQL + '  SUM(ENT_VALIPI) AS ENT_VALIPI, ';
    strSQL := strSQL + '  SUM(ENT_VALFRE) AS ENT_VALFRE, ';
    strSQL := strSQL + '  SUM(ENT_DESACE) AS ENT_DESACE, ';
    strSQL := strSQL + '  SUM(ENT_DESESP) AS ENT_DESESP, ';
    strSQL := strSQL + '  SUM(ENT_TOTITE) AS ENT_TOTITE, ';
    strSQL := strSQL + '  SUM(ENT_VLRCON) ' + IIf(blnDescontoIncondicional, ' - SUM(ENT_DESESP)' , '') + 'AS ENT_VLRCON ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  TMP_ENTMER ';

    With qryGenMer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      edtValSub.Text := FloatToStrF(FieldByName('ENT_VALRET').AsFloat, ffFixed, 12, 2);
      edtValAnt.Text := FloatToStrF(FieldByName('ENT_VALANT').AsFloat, ffFixed, 12, 2);
      edtValIpi.Text := FloatToStrF(FieldByName('ENT_VALIPI').AsFloat, ffFixed, 12, 2);

      if blnRecCliGarantia then
      begin
        edtDesEsp.Text := FloatToStrF(fltDesEspRecCliGarantia, ffFixed, 12, 2);

        edtTotIte.Text := FloatToStrF(FieldByName('ENT_TOTITE').AsFloat +
                                        fltDesEspRecCliGarantia,
                                      ffFixed, 12, 2);
      end
      else begin
        edtDesEsp.Text := FloatToStrF(FieldByName('ENT_DESESP').AsFloat, ffFixed, 12, 2);
        edtTotIte.Text := FloatToStrF(FieldByName('ENT_TOTITE').AsFloat, ffFixed, 12, 2);
      end;

      edtVlrCon.Text := FloatToStrF(FieldByName('ENT_VLRCON').AsFloat (*+
                                    fStrToFloat(edtValFre.Text) +
                                    fStrToFloat(edtDesAce.Text)*), ffFixed, 12, 2);

      Close;
    End;

  Finally
    FreeAndNil(qryGenMer);
  End;

end;

procedure TfrmEntDadosFiscaisResumo.pAtribuiTabelas;
begin
  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
end;

procedure TfrmEntDadosFiscaisResumo.pAtualizaICMSFrete(fltAlqIcm: Double);
  var qryComand : TUniQuery;
begin
  qryComand := fCriaQuery;
  Try
    If fltAlqIcm > -1 Then
    Begin
     qryComand.SQL.Add('UPDATE TMP_ENTMER SET ENT_ICMCFR = :ENT_ICMCFR');
     qryComand.ParamByName('ENT_ICMCFR').AsFloat := fltAlqIcm;
    End
    Else
     qryComand.SQL.Add('UPDATE TMP_ENTMER SET ENT_ICMCFR = ENT_ALQICM');
    qryComand.ExecSql;
  Finally
    FreeAndNil(qryComand);
  End;


end;

procedure TfrmEntDadosFiscaisResumo.pAtualizarObjLisFre;
begin
  objLisFre.strEspNot := strEspDoc;
  objLisFre.fltMaxIVA := fltMaxIVA;
  objLisFre.fltTotIte := fltTotIte;
  objLisFre.tipRatFrete := tipRatFrete;
  objLisFre.fltVlrCon := fStrToFloat(edtVlrCon.Text);
  objLisFre.fltTotLiq := fStrToFloat(edtTotIte.Text) - fStrToFloat(edtDesEsp.Text);
  objLisFre.strCodPor := edtCodPor.Text;
end;

procedure TfrmEntDadosFiscaisResumo.pAtualizaStatusPedidoDevolucao;
  Var
    stlPeds: TStringList;
    intCont: Integer;
    arrNumPed: TArray<String>;
    strNumPed, strEmpPed: String;
begin
  stlPeds := TStringList.Create;
  stlPeds.Sorted     := True;
  stlPeds.Duplicates := dupIgnore;

  Try
    qryEntMer.First;
    While Not qryEntMer.Eof Do
    Begin
      pRetNumeroPedidoVenda(qryEntMer.FieldByName('ENT_NUMPED').AsString,
                            qryEntMer.FieldByName('ENT_ESPDOC').AsString,
                            qryEntMer.FieldByName('ENT_CODEMP').AsString,
                            qryEntMer.FieldByName('ENT_CODFOR').AsString,
                            strNumPed, strEmpPed);

      If Not fEmptyStr(strNumPed) Then
        stlPeds.Add(strNumPed +'-PD-'+ strEmpPed +'-'+ qryEntMer.FieldByName('ENT_CODFOR').AsString);

      qryEntMer.Next;
    End;

    For intCont := 0 To stlPeds.Count -1 Do
    Begin
      arrNumPed := stlPeds[intCont].Split(['-']);

      TUpdateStatus.New(
        TParamStatus.New()
          .NumDoc(arrNumPed[0])
          .EspDoc(arrNumPed[1])
          .CodEmp(arrNumPed[2])
          .CodCli(arrNumPed[3])
      ).pExecute;
    End;
  Finally
    stlPeds.Free;
  End;
end;

procedure TfrmEntDadosFiscaisResumo.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: btnConfirma.Click;
    VK_F9 : btnOutDes.Click;
    VK_F8 : If btnImpEspelho.Visible Then
              btnImpEspelho.Click;
    VK_F7 : btnVendor.Click;
    VK_F6 : btnConFre.Click;
    VK_F5 : btnConfDigitacao.Click;
    VK_F4 : btnDesmembraValores.Click;
    VK_F3 : btnGnreST.Click;
    VK_F2 : btnGnreTribut.Click;

    VK_F1 : Begin
              If Shift = [ssAlt] Then
                btnTS.Click
              Else
                btnTCIF.Click;
            End;
  End;

end;

procedure TfrmEntDadosFiscaisResumo.edtCodEmpresaExit(Sender: TObject);
  var arrLinEmp: TConsultasArray;
begin
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrLinEmp, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmEntDadosFiscaisResumo.edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
  var arrLinEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrLinEmp, True) Then
  Begin
    fValidaCampos(edtCodEmpresa, False);
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmEntDadosFiscaisResumo.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  If (Key = ',') or (Key = '+') Then
  Begin
    Key := #0;
    Exit;
  End;

  Try
    if fPesqOperador(Self, edtCodOpe, edtNomOpe, qryConOpe, Key, arrSel) then    
    Begin
      If fValidaCampos(edtCodOpe, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  Except
    On E: Exception Do
    Begin
      fMensagem('', 'Erro na busca rápida: ' + E.Message, ['&O k']);
    End;
  End;
end;

procedure TfrmEntDadosFiscaisResumo.pHabilitaVendorOutrasDespesas;
Begin
  objVendor.blnGravar := (fStatusCndPag(mskCndPag.Text) = A_VISTA) Or
                          chkGraFin.Checked;

  btnVendor.Enabled := objVendor.blnGravar;

  btnOutDes.Enabled := (fStatusCndPag(mskCndPag.Text) <> A_VISTA) Or
                       (fStatusCndPag(mskCndPag.Text) = A_VISTA);
End;

procedure TfrmEntDadosFiscaisResumo.mnuGnreSTClick(Sender: TObject);
begin
  inherited;
  btnGnreST.Click;
end;

procedure TfrmEntDadosFiscaisResumo.mnuGnreTributadoClick(Sender: TObject);
begin
  inherited;
  btnGnreTribut.Click;
end;

procedure TfrmEntDadosFiscaisResumo.mskCndPagExit(Sender: TObject);
begin
  inherited;

  pHabilitaVendorOutrasDespesas;
end;

procedure TfrmEntDadosFiscaisResumo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;


  cdsCtpDet := Nil;

end;

procedure TfrmEntDadosFiscaisResumo.pEscapePressed;
begin

  If (ActiveControl.Parent = pnlContasPagar) Then
    inherited
  Else If pnlContasPagar.Enabled Then
    pSetFocus(edtCodOpe);

end;

procedure TfrmEntDadosFiscaisResumo.pExibeArrDuplicata(Sender: TObject);
  Var
    frmDigDuplicata : TfrmDigDuplicata;
begin
  {* Req. 455181 - o pFreeAndNil no fim do metodo opera sobre esta local; *}
  {* sem inicializar, um Assigned sobre lixo de pilha libera ponteiro     *}
  {* invalido quando pCriarFormularios falha.                            *}
  frmDigDuplicata := nil;

  Try
    pCriarFormularios(TfrmDigDuplicata, frmDigDuplicata);
    frmDigDuplicata.arrDuplicata := Self.arrDuplicata;
    frmDigDuplicata.btnValoresPadrao.Visible := False;
    frmDigDuplicata.intQtdPar       := Length(ArrDuplicata^);
    frmDigDuplicata.blnEditavel     := False;
    frmDigDuplicata.blnHabEditDup   := False;
    frmDigDuplicata.blnHabEditValor := False;
    frmDigDuplicata.curTotalPed     := 0;
    frmDigDuplicata.blnPergConf     := False;
    frmDigDuplicata.strEspDoc       := strEspDoc;
    frmDigDuplicata.pMostraContaCorrente := Nil;

    frmDigDuplicata.btnHistorico.Visible := False;
    frmDigDuplicata.edtHist02.Visible    := False;
    frmDigDuplicata.btnHistorico.Enabled := False;
    frmDigDuplicata.edtHist02.Enabled    := False;

    frmDigDuplicata.lblCheques.Visible := False;
    frmDigDuplicata.lblCheques2.Visible := False;
    frmDigDuplicata.edtChq01.Visible := False;
    frmDigDuplicata.edtChq02.Visible := False;
    frmDigDuplicata.edtChq03.Visible := False;
    frmDigDuplicata.edtChq04.Visible := False;
    frmDigDuplicata.edtChq05.Visible := False;
    frmDigDuplicata.edtChq06.Visible := False;
    frmDigDuplicata.edtChq07.Visible := False;
    frmDigDuplicata.edtChq08.Visible := False;
    frmDigDuplicata.edtChq09.Visible := False;
    frmDigDuplicata.edtChq10.Visible := False;
    frmDigDuplicata.edtChq11.Visible := False;
    frmDigDuplicata.edtChq12.Visible := False;

    frmDigDuplicata.edtChq13.Visible := False;
    frmDigDuplicata.edtChq14.Visible := False;
    frmDigDuplicata.edtChq15.Visible := False;
    frmDigDuplicata.edtChq16.Visible := False;
    frmDigDuplicata.edtChq17.Visible := False;
    frmDigDuplicata.edtChq18.Visible := False;
    frmDigDuplicata.edtChq19.Visible := False;
    frmDigDuplicata.edtChq20.Visible := False;
    frmDigDuplicata.edtChq21.Visible := False;
    frmDigDuplicata.edtChq22.Visible := False;
    frmDigDuplicata.edtChq23.Visible := False;
    frmDigDuplicata.edtChq24.Visible := False;

    frmDigDuplicata.lblTotVen.Left  := 635;
    frmDigDuplicata.lblTotDig.Left  := 635;
    frmDigDuplicata.lblVlFalta.Left := 635;
    frmDigDuplicata.edtTotVen.Left  := 635;
    frmDigDuplicata.edtTotDig.Left  := 635;
    frmDigDuplicata.edtVlFalta.Left := 635;
    frmDigDuplicata.Width := 755;

    frmDigDuplicata.blnFaturamento  := False;
    frmDigDuplicata.strCndPag       := mskCndPag.Text;
    frmDigDuplicata.dtaDtaBas       := dtaDtaDoc;
    frmDigDuplicata.blnDupsRedondas := False;
    frmDigDuplicata.strCodCli       := '';
    frmDigDuplicata.blnPerRep       := False;
    frmDigDuplicata.btnSalvar.Visible := False;
    frmDigDuplicata.OnClose := Nil;


    frmDigDuplicata.ShowModal;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fDigDuplic]');
    End;
  End;

  pFreeAndNil(frmDigDuplicata);

end;

procedure TfrmEntDadosFiscaisResumo.btnTCIFClick(Sender: TObject);
begin
  inherited;
  If Not btnTCIF.Visible Then
    Exit;
  objGnreTCIF.pTelaGnre(Not fEmptyStr(recNotEle.strAutInc), fCfgSis('FORGNE'));
  objGnreTCIF.fAtualizaValorGnre;

end;

procedure TfrmEntDadosFiscaisResumo.btnTSClick(Sender: TObject);
begin
  inherited;
  If Not btnTS.Visible Then
    Exit;
  objGnreTS.pTelaGnre(Not fEmptyStr(recNotEle.strAutInc), fCfgSis('FORGNE'));
  objGnreTS.fAtualizaValorGnre;
end;

procedure TfrmEntDadosFiscaisResumo.btnCancelarEntradaClick(
  Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmEntDadosFiscaisResumo.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    if fPesqPortador(conSimples, Self, edtCodPor, edtNomPor, qryConPor, Key, arrSel) then    
    Begin
      If fValidaCampos(edtCodPor, False) Then
        Self.SelectNext(ActiveControl, True, True);
    End;

  End;
end;

procedure TfrmEntDadosFiscaisResumo.pCarregaPortador;
begin
  pPesquisaCadPor(Nil, qryConPor, edtCodPor.Text);
  With qryConPor Do
  Begin
    edtNomPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;

end;

function TfrmEntDadosFiscaisResumo.fRetornaParcelas: String;
  Var
    intContador  : Integer;
    strParcelas  : String;
    strAgrupamento: String;
    stlAgrupamentos: TStringList;
    intAgrup: Integer;
Begin
  stlAgrupamentos := TStringList.Create;
  stlAgrupamentos.Sorted     := True;
  stlAgrupamentos.Duplicates := dupIgnore;

  Try
    Try
      strAgrupamento := '';
      strParcelas := '';
      For intContador := 0 To Length(objEspNota.arrParcelas) -1 Do
      Begin
        If Not fEmptyStr(objEspNota.arrParcelas[intContador].strNumAgp) Then
          stlAgrupamentos.Add(String(objEspNota.arrParcelas[intContador].strNumAgp));

        strParcelas := strParcelas + String(arrLetras[intContador]) + ') ' + objEspNota.arrParcelas[intContador].strData + ' ' + objEspNota.arrParcelas[intContador].strValor +  ' Boleto: '+ objEspNota.arrParcelas[intContador].strVeioBo +'   ';
      End;

      If stlAgrupamentos.Count > 0 Then
      Begin
        For intAgrup := 0 To stlAgrupamentos.Count - 1 Do
          strAgrupamento := strAgrupamento + String(objEspNota.arrParcelas[intAgrup].strNumAgp) + ' ';
      End;

      Result := strParcelas;

      If Not fEmptyStr(strAgrupamento) Then
        Result := 'Agrupamento : ' + strAgrupamento + #13#10 + Result;

    Except
      Result := '';
    End;
  Finally
    stlAgrupamentos.Free;
  End;
End;

function TfrmEntDadosFiscaisResumo.fRetCentroCustoDoc: String;
Begin
  If Length(objEspNota.arrParcelas) > 0 Then
    Result := fFormataCCusto(objEspNota.arrParcelas[0].strCodCta) + '-' + fRetDescCentroCusto(objEspNota.arrParcelas[0].strCodCta)
  Else
    Result := '';
End;

procedure TfrmEntDadosFiscaisResumo.btnImpEspelhoClick(Sender: TObject);
  Var
    strGNRE: string;
    qrySetaVar: TUniQuery;
    frmRelEspNotaEnt: TfrmRelEspNotaEnt;

    Procedure pSetaParcelasEspelho;
      Var
        intContador: Integer;
    Begin
      SetLength(objEspNota.arrParcelas, 0);

      If chkPgoAnt.Checked Then
        objPgoAnt.fRecalculaPagamentosAntecipados(strNumDoc, strSerie, fltValorDocumento, objEspNota.arrParcelas, ArrDuplicata^);

      For intContador := 0 To Length(ArrDuplicata^) -1 Do
      Begin

        If Not fEmptyStr(ArrDuplicata[intContador].dtaDtaVen) Then
        Begin
          SetLength(objEspNota.arrParcelas, Succ(Length(objEspNota.arrParcelas)));
          objEspNota.arrParcelas[High(objEspNota.arrParcelas)].strData   := FormatDateTime('dd/mm/yy',StrToDateTime(ArrDuplicata[intContador].dtaDtaVen));
          objEspNota.arrParcelas[High(objEspNota.arrParcelas)].strValor  := FloatToStrF(ArrDuplicata[intContador].curValor,ffNumber,15,2);
          objEspNota.arrParcelas[High(objEspNota.arrParcelas)].strCodCta := fraPlanoDeContas.MskCodCta.Text;
          objEspNota.arrParcelas[High(objEspNota.arrParcelas)].strVeioBo := IIF(chkVeioBo.Checked,'SIM','NÃO');
        End;

      End;

    End;

    function fRetConhecimentoFrete: string;
    begin
      Result := '';
      if not objLisFre.IsEmpty then
      begin
        Result := fPadR('CONHECIMENTO DE FRETE', 25) +
                  fPadR('FORNECEDOR', 50) +
                  fPadR('', 5) +
                  fPadL('VALOR TOTAL', 16) +
                  fPadL('VR. PROP. AO DOCTO' + IIF(objEspNota.blnDedFre, ' (1)', ''), 30) +
                  fPadR('', 5) +
                  fPadR('CONDIÇÃO DE PAGAMENTO', 40);
        objLisFre.First;
        while not objLisFre.Eof do
        begin
          Result := Result + #13#10;
          Result := Result + fDescricaoFrete(cbxModFre.Text[1]);
          Result := Result + #13#10;
          Result := Result + fPadR(objLisFre.FieldByName('NUMDOC').AsString + '-' + objLisFre.FieldByName('ESPDOC').AsString + '-' + objLisFre.FieldByName('CODEMP').AsString + '-' + objLisFre.FieldByName('SERIE_').AsString, 25) +
                    fPadR(objLisFre.FieldByName('CODTRA').AsString + '-' + objLisFre.FieldByName('NOMTRA').AsString, 50) +
                    fPadR('', 5) +
                    fPadL(FormatFloat('#,##0.00', objLisFre.FieldByName('VALCON').AsFloat), 16) +
                    fPadL(FormatFloat('#,##0.00', objEspNota.fRetSomaConhecimento), 30) +
                    fPadR('', 5) +
                    fPadR(objEspNota.fCondPagtoConhecimentoFrete, 40);
          Result := Result + #13#10;
          Result := Result + objEspNota.fDuplicatasConhecimentoFrete(objLisFre.FieldByName('NUMDOC').AsString, objLisFre.FieldByName('ESPDOC').AsString, objLisFre.FieldByName('SERIE_').AsString, objLisFre.FieldByName('CODTRA').AsString);
          objLisFre.Next;
        end;
        objLisFre.First;
      end;
    end;

begin

  If Not (btnImpEspelho.Visible) Then
    Exit;

  {********************************}
  {* VERIFICA PERMISSÃO DE ACESSO *}
  {*****************************RV*}
  If (Not fVerificaAcessoSistema('ESPNFE', strCodOpe)) Or fEmptyStr(strCodOpe) Then
  Begin
    fMensagem('', 'Usuário sem permissão de acesso!', ['&O k']);
    Exit;
  End;

  If (fValidaCampos(mskCndPag,False)) And
     ((((Not fEmptyStr(strCndAnt)) And (mskCndPag.Text = strCndAnt)) Or chkPgoAnt.Checked) Or
     (fltValorDocumento = 0)) Then
  Begin
    Try
      pSetaParcelasEspelho;

      if fCfgSis('ENTEDI', varBoolean) then
      begin

        { Preciso setar esses objetos no objEspNota pois as variáveis @VENDOR, @ICMANT, @OUTDES e @CONFRE vão usá-las }
        objEspNota.objLisFre := Self.objLisFre;
        objEspNota.objVendor := Self.objVendor;
        objEspNota.objOutDes := Self.objOutDes;

        If Assigned(objEspNota.objVendor) Then
          objEspNota.objVendor.fRateiaVendor;

        If Assigned(objEspNota.objOutDes) Then
          If Not objEspNota.objOutDes.blnRateioManual Then
            objEspNota.objOutDes.fRateiaOutrasDespesas;

        { objGnre é o único objeto que não sofre alterações depois de setado nessa unit, por isso pode ser usado direto }
        if Assigned(objGnreST) And (Not fEmptyStr(objGnreST.strValGnr)) then
          strGNRE := 'CONCAT(LPAD(FORMAT(:VALGNR, 2), 15, " "), RPAD("", 2, " "), RPAD(CONCAT(:CODFOR,"-",:NOMFOR), 73, " "), RPAD(DATE_FORMAT(:DTAVEN, "%d/%m/%Y"), 10, " "))'
        else
          strGNRE := '""';

        qrySetaVar := fCriaQuery;
        try
          qrySetaVar.Close;
          qrySetaVar.SQL.Clear;
          qrySetaVar.SQL.Add('SET @VENDOR   = :VENDOR;');
          qrySetaVar.SQL.Add('SET @ICMANT   = :ICMANT;');
          qrySetaVar.SQL.Add('SET @OUTDES   = :OUTDES;');
          qrySetaVar.SQL.Add('SET @CONFRE   = :CONFRE;');
          qrySetaVar.SQL.Add('SET @PEDIDOS  = :PEDIDOS;');
          qrySetaVar.SQL.Add('SET @PARCELAS = :PARCELAS;');
          qrySetaVar.SQL.Add('SET @PLACONTA = :PLACONTA;');
          qrySetaVar.SQL.Add('SET @GNRE     = ' + strGNRE + ';');

          qrySetaVar.ParamByName('VENDOR').AsString  := objEspNota.fRetVendorDigitacao;
          qrySetaVar.ParamByName('ICMANT').AsString  := objEspNota.fRetICMAntDigitacao;
          qrySetaVar.ParamByName('OUTDES').AsString  := objEspNota.fRetOutrasDespesasDigitacao;
          qrySetaVar.ParamByName('CONFRE').AsString  := fRetConhecimentoFrete;
          qrySetaVar.ParamByName('PEDIDOS').AsString := stlPedidos.Text;
          qrySetaVar.ParamByName('PARCELAS').AsString := fRetornaParcelas;
          qrySetaVar.ParamByName('PLACONTA').AsString := fRetCentroCustoDoc;

          if Assigned(objGnreST) And (Not fEmptyStr(objGnreST.strValGnr)) then
          begin
            qrySetaVar.ParamByName('VALGNR').AsFloat := fStrToFloat(objGnreST.strValGnr);
            qrySetaVar.ParamByName('CODFOR').AsString := strCodFor;
            qrySetaVar.ParamByName('NOMFOR').AsString := fRetNomFornecedor(strCodFor);
            qrySetaVar.ParamByName('DTAVEN').AsDateTime := StrToDate(objGnreST.strDtaVen);
          end;

          qrySetaVar.ExecSQL;
        finally
          FreeAndNil(qrySetaVar);
        end;

        if Assigned(prcExecutaRelatorio) then
          prcExecutaRelatorio(412, 19185, [19185],
                              ['CODEMP', 'NUMDOC', 'ESPDOC', 'SERIE_', 'CODFOR',
                               'DTAENT', 'DTADOC', 'CONPAG', 'CODOPE'],
                              [VS_strCodEmp, strNumDoc, strEspDoc, strSerie, strCodFor,
                               DateToStr(dtaDtaEnt), DateToStr(dtaDtaDoc), mskCndPag.Text, edtCodOpe.Text],
                              Sender, nil);

      end
      else
      begin

        pCriarFormularios(TfrmRelEspNotaEnt, frmRelEspNotaEnt);

        objEspNota.dtaIcmAnt        := dtaIcmAnt;
        objEspNota.fltIcmAnt        := fStrToFloat(edtValAnt.Text);
        objEspNota.strPedidos       := stlPedidos.Text;
        objEspNota.intModFre        := StrToInt(cbxModFre.Text[1]);

        frmRelEspNotaEnt.objEspNota := objEspNota;
        frmRelEspNotaEnt.objGnre    := objGnreST;
        frmRelEspNotaEnt.blnEntMer  := True;

        frmRelEspNotaEnt.strCodFor  := strCodFor;
        frmRelEspNotaEnt.strNumDoc  := strNumDoc;
        frmRelEspNotaEnt.strEspDoc  := strEspDoc;
        frmRelEspNotaEnt.strSerie   := strSerie;
        frmRelEspNotaEnt.strCndPag  := mskCndPag.Text;
        frmRelEspNotaEnt.strDtaEnt  := DateToStr(dtaDtaEnt);
        frmRelEspNotaEnt.strDtaDoc  := DateToStr(dtaDtaDoc);
        frmRelEspNotaEnt.strCodOpe  := edtCodOpe.Text;
        frmRelEspNotaEnt.strNomOpe  := edtNomOpe.Text;
        frmRelEspNotaEnt.objLisFre  := objLisFre;
        frmRelEspNotaEnt.objVendor  := objVendor;
        frmRelEspNotaEnt.objOutDes  := objOutDes;

        frmRelEspNotaEnt.ShowModal;
        FreeAndNil(frmRelEspNotaEnt);

      end;
    Except
      On E: Exception Do
      Begin
				pMensagensErro(E.Message,'[TfrmEntDadosFiscaisResumo.btnImpEspelhoClick]');
      End;
    End;
  End;
end;

procedure TfrmEntDadosFiscaisResumo.btnOutDesClick(Sender: TObject);
begin
  inherited;
  If Not (btnOutDes.Enabled And btnOutDes.Visible) Then
    Exit;
  objOutDes.tipRatFreteRPA := objLisFre.tipRatFreteRPA;
  objOutDes.blnConverteQtdItensEmb := ((fCfgSis('CNVEMB', varString) <> 'N') And (Not blnDevolu) And (Not blnRecCliGarantia) And (Not blnConEqu) And (Not blnLocEqu)  And (not FblnAcessadoViaRetornoConsignacao));
  objOutDes.fInformaOutrasDespesas(arrDuplicata^, strCodFor, dtaDtaEnt);
  pAtualizarObjLisFre;
  objLisFre.pSetValorRpa(objOutDes.fTotalFreteRpa, objOutDes.tipRatFreteRPA);
end;

procedure TfrmEntDadosFiscaisResumo.btnPgoAntClick(Sender: TObject);
begin
  inherited;

  pCalculaValorDocumento;
  chkPgoAnt.Checked := objPgoAnt.fSelecionaDuplicatas(fltValorDocumento, fltBonificacao, False, recNotEle.strAutInc);

  pAjustaTelaPgoAntecipado;
  If Not chkPgoAnt.Checked Then
    pCarregaDuplicatasXML;

  SelectNext(ActiveControl, True, True);
end;

procedure TfrmEntDadosFiscaisResumo.btnVendorClick(Sender: TObject);
begin
  inherited;

  If Not (btnVendor.Enabled And btnVendor.Visible) Then
    Exit;

  objVendor.blnPreNot := FblnAcessadoViaPrenota;
  objVendor.strAutInc := recNotEle.strAutInc;
  objVendor.fInformaVendor(strCodFor);
  
end;

procedure TfrmEntDadosFiscaisResumo.pCarregaEvento;
begin
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmEntDadosFiscaisResumo.edtChaNFEExit(Sender: TObject);
begin
  inherited;
  pCarregaModFis(edtChaNFE.Text);
end;

procedure TfrmEntDadosFiscaisResumo.pHabilitaPagAntecipado;
Begin
  chkPgoAnt.Visible := Not blnDevolu;
  btnPgoAnt.Visible := Not blnDevolu;
End;

procedure TfrmEntDadosFiscaisResumo.FormShow(Sender: TObject);
begin
  inherited;
  pShow;
End;

procedure TfrmEntDadosFiscaisResumo.pShow;
  Var
    blnBaiPed: Boolean;
    fltCredFor: Double;
    strClaRet: string;
    intModFreSelec: integer;
    blnEntradaFornecedoUsoConsumo : Boolean;
begin
  inherited;
  chkPrevisao.Visible := not blnDevolu
    And Not blnGarantia
    And Not blnRecCliGarantia;
  blnTemDupEle := False;
  blnDupEleConsultado := False;
  fltTotSelPreNotaOriginal := 0;
  strHisCtaPreNotaAtual := '';
  pZeraDigDuplic(arrDuplicata^);
  intModFreSelec := StrToInt(cbxModFre.Text[1]);

  blnDescontaFreteDevolucao := blnDevolu and((fCfgSis('FREDEV') = 1) Or ((fCfgSis('FREDEV') = 3) And (intModFreSelec in[1, 3, 4, 9])));

  pHabilitaPagAntecipado;
  objPgoAnt.pSetaFornecedor(strCodFor);
  objPgoAnt.strAutIncGerEleLoad := recNotEle.strAutInc;

  objPortadorFornecedor.strCodFor := strCodFor;

  lblTemPgtoAntecipado.Visible := ((Not blnDevolu) and objPgoAnt.fFornecedorTemPagamentoAntecipado(strCodFor));

  objPgoAnt.pSetarDocumentoEntrada(strNumDoc, strSerie, strEspDoc, mskCndPag.Text, TDate(dtaDtaEnt), TDate(dtaDtaDoc), fRetVlrContabilCadFis);

  edtChaNFE.Text := recNotEle.str_Chave;

  edtChaNFE.ReadOnly := (Not fEmptyStr(edtChaNFE.Text));
  edtChaNFE.TabStop  := (Not edtChaNFE.ReadOnly);

  mskCompet.Text := FormatDateTime('mm/YYYY',dtaDtaEnt);

  lblCodCon.Visible := (fCfgSis('CODCON', varBoolean)) And (Not blnDevolu);
  edtCodCon.Visible := lblCodCon.Visible;

  edtPesBru.Text := FormatFloat('#0.000', 0);
  edtPesLiq.Text := FormatFloat('#0.000', 0);
  If Not fCfgSis('PESENT', varBoolean) Then
  Begin
    lblPesBru.Visible := False;
    lblPesLiq.Visible := False;
    edtPesBru.Visible := False;
    edtPesLiq.Visible := False;
  End
  Else If Not fEmptyStr(recNotEle.strAutInc) Then
  Begin
    edtPesBru.Text := FormatFloat('#0.000', recNotEle.fltPesBru);
    edtPesLiq.Text := FormatFloat('#0.000', recNotEle.fltPesLiq);
  End;

  edtEspVol.Text := recNotEle.strEspVol;
  edtQtdVol.Text := FormatFloat('#0.000', recNotEle.fltQtdVol);

  case StrToIntDef(recNotEle.strModFre,-1) of
    0: cbxModFre.ItemIndex :=  0;
    1: cbxModFre.ItemIndex :=  1;
    2: cbxModFre.ItemIndex :=  2;
    3: cbxModFre.ItemIndex :=  3;
    4: cbxModFre.ItemIndex :=  4;
    9: cbxModFre.ItemIndex :=  5;
  End;


  If Not fEmptyStr(edtChaNFE.Text) Then
  begin
   cbxCodMod.ItemIndex := cbxCODMOD.Items.IndexOfName(fChaveModelo(edtChaNFE.Text));
  end;

  If Not FblnAcessadoViaPrenota Then
    pCalculaTotaisCabecalho;

  strCodConPagCliDev := '';
  If (blnDevolu) Or (blnRecCliGarantia) Or (blnConEqu) Or (blnLocEqu) or (FblnAcessadoViaRetornoConsignacao) Then
  Begin
    lblCodOpe.Caption := 'Vendedor';

    chkVeioBo.Visible := False;
    chkDeposi.Visible := False;
    cbxBcoFor.Visible := False;
    lblBcoFor.Visible := False;

    lblCodDig.Visible := True;
    edtCodDig.Visible := True;
    edtNomDig.Visible := True;

    btnImpEspelho.Visible := False;
    CondicaoPagamentoCliente.intQtdCndPag := 0;
    If (blnDevolu) Then
    begin
      If fCfgSis('EGCNDV') = '1' Then
        strConPag := '01000'
      Else If fCfgSis('EGCNDV') = '2' Then
      Begin
        If fCfgSis('ELCNDV') = 'S' Then
        Begin
          lblBcoFor.Visible := True;
          lblBcoFor.Left := mskCndPag.Left;
          lblBcoFor.Caption := 'Para buscar outra Cond. de Pagamento pressione "/"';
          lblBcoFor.Font.Color := clRed;
        End;
        CondicaoPagamentoCliente.pCarregaDados(strCodFor, '');
        If CondicaoPagamentoCliente.intQtdCndPag > 0 Then
        Begin
          edtCodPor.Text := CondicaoPagamentoCliente.strCodPor;
          strConPag := CondicaoPagamentoCliente.strCNDPAG;
          strCodConPagCliDev := CondicaoPagamentoCliente.strCodCnd;
        End;
      End;

      If fCfgSis('ELCNDV') = 'N' Then
      Begin
        mskCndPag.Enabled := False;
        If strConPag = '' Then
          strConPag := '01000';
      End;
    End;
  End
  Else
  Begin
    lblCodRep.Visible := False;
    edtCodRep.Visible := False;
    edtNomRep.Visible := False;
  End;

  pCarregaRepresentante;

  If Not SameText(edtCodOpe.Text,'') Then
    pCarregaOperador;

  //*************************************************//
  // VERIFICA SE DEVE GRAVAR CP PARA O FORN. SELEC.  //
  //**********************************************ED*//
  blnForGCP := fFornecedorGravaCtp(strCodFor);

  If (blnGarantia) then
    oleItensPedidos := fDefinePedidosABaixarGarantia(blnBaiPed, qryEntMer, fCfgSis('CNVEMB'),
                                                     {blnRefugo : Boolean =} False,
                                                     {blnBaixa  : Boolean =} False,
                                                     objDefBaixa)
  Else
    oleItensPedidos := fDefinePedidosABaixar(blnBaiPed, qryEntMer, stlPedidos, recNotEle.strAutInc,
                                             {blnEntradaSimplificada: Boolean = } False,
                                             {blnCaixaUm: Boolean =} False,
                                             objDefBaixa);

  If stlPedidos.Count > 0 Then
    btnConfDigitacao.Visible := True;

  lblPagamentoCartaoCredito.Visible := fRetornaExistePedidoCompraPagoCartaoCredito(stlPedidos);

  pCarregaCentroCusto;

  btnDesmembraValores.Visible := (Not blnDevolu);

  mskCndPag.Text := strConPag;

  mmoHisCta.Enabled := fCfgSis('INFCTP', varBoolean);
  lblInfCtp.Enabled := mmoHisCta.Enabled;

  chkAtuPre.Visible := fCfgSis('ATPRAU', varBoolean);
  If Not chkAtuPre.Visible Then
    mmoHisCta.Height := mmoHisCta.Height + 18;

  If fCfgSis('PDOBPG', varBoolean) Then
    mmoHisCta.Lines.Add(fObservacaoPedido(stlPedidos));

(*  If Assigned(objFreCon) Then
  Begin
    objFreCon.blnFreTri    := blnFreTri;
    objFreCon.fltTotIteSub := fltRetIte;
    objFreCon.fltTotIteAnt := fltValAnt;
  End;
*)

  {************************************************}
  {* CASO SEJA IMPORTADO XML E TENHA DUPLICATAS   *}
  {* IMPORTADAS PREENCHE ARRAY E COND. PGTO       *}
  {*********************************************GB*}
   pCarregaDuplicatasXML;

  {********************************************************}
  {* EXIBE VALOR DE CREDITO DO FORNECEDOR SE CASO EXISTIR *}
  {******************************************************FC}
  fltCredFor := fRetCreditoByFornecedor(strCodFor);
  lblCredFor.Visible := fltCredFor > 0;
  lblCredFor.Caption := lblCredFor.Caption + ' ' + FloatToStrF(fltCredFor, ffCurrency, 9, 2);

  If (blnDevolu) Or (recNotEle.finalidadeXML = xmlDevolucaoEntradaEmitidaFornecedor) Then
  Begin
    btnOutDes.Visible := False;
    btnVendor.Visible := False;
    btnGnreST.Visible   := False;
    btnGnreTribut.Visible   := False;
    btnConFre.Visible := False;
  End;


  If recNotEle.finalidadeXML = xmlDevolucaoEntradaEmitidaFornecedor Then
  Begin
    mskCndPag.Text := '01000';
    mskCndPag.Enabled := False;
    btnPgoAnt.Visible := False;
    chkPgoAnt.Visible := False;
    lblTemPgtoAntecipado.Visible := False;
  End;

  If blnNotaImp And (Not FblnAcessadoViaPrenota) Then
  Begin
    pDesmembraCTPImportacao;
    pZeraOutrasDespesas;
  End;

  blnEntradaFornecedoUsoConsumo := (strMatRev = 'M') And  (Not fCfgSis('FLUPDC', varBoolean) );

  strClaRet := fTransform(fCfgSis('CLARET'), 4);
  If not FblnAcessadoViaPrenota Then
    chkRealizaMovimentacaoDeSaldo.Visible := (Not fEmptyStr(strClaRet)) and
                                              (Not blnEntradaFornecedoUsoConsumo) And
                                             ((Pos(dtsCadFis.DataSet.FieldByName('FIS_CLFSC1').AsString, strClaRet) > 0) Or
                                              (Pos(dtsCadFis.DataSet.FieldByName('FIS_CLFSC2').AsString, strClaRet) > 0) Or
                                              (Pos(dtsCadFis.DataSet.FieldByName('FIS_CLFSC3').AsString, strClaRet) > 0) Or
                                              (Pos(dtsCadFis.DataSet.FieldByName('FIS_CLFSC4').AsString, strClaRet) > 0) Or
                                              (Pos(dtsCadFis.DataSet.FieldByName('FIS_CLFSC5').AsString, strClaRet) > 0));

  chkTransfAut.Visible := fCfgSis('ETRAUT', varBoolean);
  edtCodEmpresa.Visible := chkTransfAut.Visible;
  edtDesEmpresa.Visible := chkTransfAut.Visible;
  lblEmpresa.Visible := chkTransfAut.Visible;

  chkTransfAut.Checked := False;

  pnlCheckBox.Visible := (chkTransfAut.Visible) Or (chkRealizaMovimentacaoDeSaldo.Visible);

  chkRealizaMovimentacaoDeSaldo.Hint := 'Quando desmarcada esta operação, o sistema não realiza a movimentação em estoque' + #$A#$D +
                                        'dos itens deste documento cujo CFOP estiver relacionada na configuração [CFG_CLARET] ' + #$A#$D +
                                        'Classificação Fiscal para Retorno de Industrialização que não movimentam estoque';

  pCarregaDadosBancariosFornecedor(strCodFor);

  pCarregaModFis(edtChaNFE.Text);

  pAjustaLinhasDetalhes;

  pHabilitaFinanceiro;
  pHabilitaCamposFinanceiro;

  If FblnAcessadoViaRetornoConsignacao Then
  Begin
    pRetiraDadosParaContasAPagar;
    edtCodOpe.Text    := strLoginUsuarioLogado;
    mskCndPag.Text    := '01000';
    chkGraFin.Checked := True;
  End;
  If blnTravarFinanceiroEstaDuplicado Then
  begin
    chkGraFin.Checked := False;
    mskCndPag.Text    := '01000';
  End;

  if FblnAcessadoViaRetornoConsignacao then
  Begin
    btnOutDes.Visible           := False;
    btnVendor.Visible           := False;
    btnConFre.Visible           := False;
    btnConfDigitacao.Visible    := False;
    btnDesmembraValores.Visible := False;
    btnGnreST.Visible           := False;
    btnGnreTribut.Visible       := False;
    btnTCIF.Visible             := False;
    btnTS.Visible               := False;
  End;

  If Assigned(objGnreST) And (Not fEmptyStr(strCodFor)) And fEhFornecedor Then
  Begin
    If Not fEmptyStr(fCfgSis('FORGNE', VarString)) Then
      objGnreST.strCodFor := fCfgSis('FORGNE', VarString);

    objGnreST.strForDoc := strCodFor;
  End;
end;

procedure TfrmEntDadosFiscaisResumo.pTransferirEstoqueAbastecimentoDeposito(strAutInc,
  strEmpresaAbastecimento: String);
var
  AbastecimentoDepositoDevolucaoEntradaMercadoria: TAbastecimentoDepositoDevolucaoEntradaMercadoria;
begin
  if fEmptyStr(strAutInc) then
    Exit;

  if fEmptyStr(strEmpresaAbastecimento) then
    Exit;

  if fEmptyStr(strCodCnd) then
    Exit;

  AbastecimentoDepositoDevolucaoEntradaMercadoria := TAbastecimentoDepositoDevolucaoEntradaMercadoria.Create(strAutInc, strEmpresaAbastecimento, strCodCnd);
  try
    AbastecimentoDepositoDevolucaoEntradaMercadoria.pTransfereEstoqueDevolucaoNotaEntrada;
  finally
    FreeAndNil(AbastecimentoDepositoDevolucaoEntradaMercadoria);
  end;
end;

procedure TfrmEntDadosFiscaisResumo.pZeraOutrasDespesas;
var qryExec: TUniquery;
    fltValOutDes: Double;
begin
  fltValOutDes := fRetOutDesImportacao;
  If fltValOutDes > 0 Then
  begin
    qryExec := fCriaQuery;
    qryExec.SQL.Text := 'UPDATE TMP_ENTMER SET ENT_OUTDES = 0';
    qryExec.ExecSQL;
    objOutDes.pInsereDepesasImportacao(fltValOutDes);

    objOutDes.pCarregaValorOut;
  End;
end;

procedure TfrmEntDadosFiscaisResumo.pCarregaDadosBancariosFornecedor(
  strCodFor: String);
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;

  Try
    cbxBcoFor.Clear;
    lstBcoFor.Clear;
    With qryGen, SQL Do
    Begin
      Clear;
      Add(getSQLDadosBancariosFornecedor);
      ParamByName('CODFOR').AsString := strCodFor;
      Open;

      While Not Eof Do
      Begin
        cbxBcoFor.Items.Add(Trim(FieldByName('DESC_CONTA').AsString));
        lstBcoFor.Add(FieldByName('AUTOINCREM').AsString);
        Next;
      End;

      Close;
    End;
  Finally
    If Pred(cbxBcoFor.Items.Count) >= intIdxBcoForAnt Then
      cbxBcoFor.ItemIndex := intIdxBcoForAnt;
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmEntDadosFiscaisResumo.pCarregaDigitador;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtCodDig.Text, True);
  With qryConOpe Do
  Begin
    edtNomDig.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

procedure TfrmEntDadosFiscaisResumo.pCarregaDuplicatasXML;
Var
  qryDupEle: TUniQuery;
  intNumDupEle: integer;
begin
  If not fEmptyStr(recNotEle.strAutInc) Then
  Begin
    If Not blnDupEleConsultado Then
    Begin
      blnDupEleConsultado := True;
      qryDupEle := Nil;
      Try
        qryDupEle := fCriaQuery(Self);
        qryDupEle.SQL.Add('SELECT * FROM DUPELE WHERE DUP_SEQELE = :SEQELE ORDER BY AUTOINCREM');
        qryDupEle.ParamByName('SEQELE').AsString := recNotEle.strAutInc;
        With qryDupEle Do
        Begin
          Open;

          if (RecordCount > 0) And (RecordCount <= 24) Then
          Begin
            blnTemDupEle := True;
            pZeraDigDuplic(arrDuplicataXMLCache);
            intNumDupEle := 0;
            First;

            While Not Eof Do
            Begin
              Inc(intNumDupEle);
              With arrDuplicataXMLCache[RecNo - 1] Do
              Begin
                intNumDup   := intNumDupEle;
                strSequen   := Chr(64 + intNumDupEle);
                curValor    := FieldByName('DUP_VALDUP').AsFloat;
                dtaDtaVen   := DateToStr(FieldByName('DUP_DTAVEN').AsDateTime);
                strNFNumDup := FieldByName('DUP_NUMDUP').AsString;
                strUsaChq   := 'N';
                strHist02   := '';
              End;

              Next;
            End;
          End;
        End;
      Finally
        FreeAndNil(qryDupEle);
      End;
    End;

    If blnTemDupEle Then
    Begin
      arrDuplicata^ := arrDuplicataXMLCache;
      pRefazCondPagamento;
      mskCndPag.Enabled      := False;
      lblCondPgto.OnClick    := pExibeArrDuplicata;
      lblCondPgto.Font.Color := clBlue;
      lblCondPgto.Font.Style := [fsUnderline];
      lblCondPgto.Cursor     := crHandPoint;
    End;
  End;

  pCarregaDadosContasPagarPreNota;
end;

procedure TfrmEntDadosFiscaisResumo.edtCodRepKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  inherited;
  Try
    if fPesqOperador(Self, edtCodRep, edtNomRep, qryConOpe, Key, arrSel) then
    Begin
      If fValidaCampos(edtCodRep, True) Then
        SelectNext(ActiveControl, True, True);
    End;

  Except
    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmEntDadosFiscaisResumo.edtCodRepKeyPress]');
    End;
  End;
end;

procedure TfrmEntDadosFiscaisResumo.edtNumADKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
(*  If fPesqAgendamentoDevolucao(Self, edtNumAD, Nil, Key, strCodFor) Then
  Begin
    If fValidaCampos(edtNumAD) Then
      SelectNext(edtNumAD, True, True);
  End; *)
end;

procedure TfrmEntDadosFiscaisResumo.pCarregaRepresentante;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtCodRep.Text);
  With qryConOpe Do
  Begin
    edtNomRep.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

procedure TfrmEntDadosFiscaisResumo.pCarregaDadosContasPagarPreNota;
  Var
  strSQL : String;
  qryGen: TUniQuery;
  stlLst: TStringList;
  function fRetDadosBancariosFornecedor(strAutoinc: String): Integer;
    var
  strSQL : String;
  qryTMP: TUniQuery;
  begin
    Result := -1;

    If FEmptyStr(strAutoinc) Then
      Exit;

    strSQL := 'SELECT * FROM ( ' +
            '  SELECT B.AUTOINCREM, ' +
            '  CONCAT("BCO: ", RPAD(B.BCF_CODBCO, 4, " "), ' +
            '         "AG: ", RPAD(CONCAT(B.BCF_NUMAGE, IF(B.BCF_DIGAGE = "", "", "-"), B.BCF_DIGAGE), 8, " "), ' +
            '         "CONTA: ", RPAD(CONCAT(B.BCF_NUMCTA, IF(B.BCF_DIGCTA = "", "", "-"), B.BCF_DIGCTA), 14, " "), '+
            '         "TIT.:" , RPAD(IFNULL(B.BCF_NOMTIT, ""), 20, " ") ) AS DESC_CONTA, ' +
            '         "CONTA" AS TIPO_CONTA               ' +
            '  FROM BCOFOR B WHERE B.AUTOINCREM = :AUTOINCREM ' +
            ' ) AS TMP ORDER BY 2, AUTOINCREM DESC';
    Try
      qryTMP := fCriaQuery;
      qryTMP.SQL.Clear;
      qryTMP.SQL.Add(strSQL);
      qryTMP.ParamByName('AUTOINCREM').AsString := strAutoinc;
      qryTMP.Open;

      If (Not qryTMP.isEmpty) Then
        Result := cbxBcoFor.Items.IndexOf(Trim(qryTMP.FieldByName('DESC_CONTA').AsString));

      qryTMP.Close;
    Finally
      FreeAndNil(qryTMP);
    End;
  End;

  procedure pCarregaDesmembramento;
    var
  strSQL : String;
  qryTMP: TUniQuery;
  Begin
    If Not cdsCtpDet.Active Then
      cdsCtpDet.Open;

    cdsCtpDet.EmptyDataSet;

    strSQL := 'SELECT * FROM PREDES WHERE PRE_SEQGER = :AUTOINCREM';
    Try
      qryTMP := fCriaQuery;
      qryTMP.SQL.Clear;
      qryTMP.SQL.Add(strSQL);
      qryTMP.ParamByName('AUTOINCREM').AsString := recNotEle.strAutInc;
      qryTMP.Open;

      While Not qryTMP.Eof Do
      Begin
        cdsCtpDet.Insert;
        cdsCtpDet.FieldByName('CTP_NUMDUP').AsString := qryTMP.FieldByName('PRE_NUMDUP').AsString;
        cdsCtpDet.FieldByName('CTP_PARCEL').AsString := qryTMP.FieldByName('PRE_PARCEL').AsString;
        cdsCtpDet.FieldByName('CTP_CODEMP').AsString := qryTMP.FieldByName('PRE_CODEMP').AsString;
        cdsCtpDet.FieldByName('CTP_SERIE_').AsString := qryTMP.FieldByName('PRE_SERIE_').AsString;
        cdsCtpDet.FieldByName('CTP_CODFOR').AsString := qryTMP.FieldByName('PRE_CODFOR').AsString;
        cdsCtpDet.FieldByName('CTP_CODCTA').AsString := qryTMP.FieldByName('PRE_CODCTA').AsString;
        cdsCtpDet.FieldByName('CTA_DESCTA').AsString := qryTMP.FieldByName('PRE_DESCTA').AsString;
        cdsCtpDet.FieldByName('CTP_DEBCRE').AsString := qryTMP.FieldByName('PRE_DEBCRE').AsString;
        cdsCtpDet.FieldByName('CTP_CODEVE').AsString := qryTMP.FieldByName('PRE_CODEVE').AsString;
        cdsCtpDet.FieldByName('CTP_MARDES').AsString := qryTMP.FieldByName('PRE_MARDES').AsString;
        cdsCtpDet.FieldByName('CTP_VALDUP').AsFloat  := qryTMP.FieldByName('PRE_VALDUP').AsFloat;
        cdsCtpDet.FieldByName('CTP_FATCAL').AsFloat  := qryTMP.FieldByName('PRE_FATCAL').AsFloat;
        cdsCtpDet.FieldByName('PERCENTUAL').AsFloat  := qryTMP.FieldByName('PRE_PERCEN').AsFloat;
        cdsCtpDet.Post;
        qryTMP.Next;
      End;
      qryTMP.Close;
    Finally
      FreeAndNil(qryTMP);
    End;
  End;

  procedure pCarregaAntecipados;
    var
  strSQL : String;
  qryTMP: TUniQuery;
  Begin
    stlLst := TStringList.Create;
    qryTMP := fCriaQuery;

    Try
      strSQL := 'SELECT * FROM PREPGA WHERE PRE_SEQGER = :AUTOINCREM';
      qryTMP.SQL.Clear;
      qryTMP.SQL.Add(strSQL);
      qryTMP.ParamByName('AUTOINCREM').AsString := recNotEle.strAutInc;
      qryTMP.Open;

      While Not qryTMP.Eof Do
      Begin
        stlLst.Add(qryTMP.FieldByName('AUTOINCPAG').AsString);
        qryTMP.Next;
      End;
      qryTMP.Close;

      If stlLst.Count > 0 Then
      Begin
        pCalculaValorDocumento;
        objPgoAnt.strAutIncGerEleLoad := recNotEle.strAutInc;
        objPgoAnt.pSetaListaSelecao(stlLst);
        objPgoAnt.pCarregaTotSel;
        fltTotSelPreNotaOriginal := objPgoAnt.fltTotSel;
        objPgoAnt.fRecalculaPagamentosAntecipados(strNumDoc, strSerie, fltValorDocumento, objEspNota.arrParcelas, ArrDuplicata^);
      End;
    Finally
      FreeAndNil(qryTMP);
      FreeAndNil(stlLst);
    End;

  End;

begin
  blnPreCtp := False;

  If (Not fCfgSis('UTDCPP', varBoolean)) Then
    Exit;

  strSQL := 'SELECT * FROM PRECTP WHERE PRE_SEQGER = :AUTOINCREM';
  Try
    qryGen := fCriaQuery;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ParamByName('AUTOINCREM').AsString := recNotEle.strAutInc;
    qryGen.Open;
    If (Not qryGen.isEmpty) Then
    Begin
      //capa
      chkVeiobo.Checked               := IIF(qryGen.FieldByName('PRE_VEIOBO').AsString = 'S', True, False);
      chkDeposi.Checked               := IIF(qryGen.FieldByName('PRE_DEPOSI').AsString = 'S', True, False);
      //OnClick desabilitado propositalmente: essa atribuicao pode disparar chkPgoAntClick,
      //que reentra em pAjustaTelaPgoAntecipado/pHabilitaFinanceiro/pHabilitaCamposFinanceiro
      //enquanto esta rotina ainda esta em execucao (mesmo padrao usado em outras units do projeto,
      //ex.: untOpcoesDocEnvioEmail.pas).
      chkPgoAnt.OnClick := Nil;
      Try
        chkPgoAnt.Checked             := IIF(qryGen.FieldByName('PRE_PGOANT').AsString = 'S', True, False);
      Finally
        chkPgoAnt.OnClick := chkPgoAntClick;
      End;
      cbxBcoFor.ItemIndex             := fRetDadosBancariosFornecedor(qryGen.FieldByName('PRE_BCOFOR').AsString);
      mskCndPag.Text                  := qryGen.FieldByName('PRE_CNDPAG').AsString;

      //Remove a linha adicionada por uma execucao anterior desta rotina antes de reinserir,
      //evitando duplicar texto em mmoHisCta a cada vez que chkPgoAnt e desmarcado.
      If (Not fEmptyStr(strHisCtaPreNotaAtual)) And (mmoHisCta.Lines.IndexOf(strHisCtaPreNotaAtual) >= 0) Then
        mmoHisCta.Lines.Delete(mmoHisCta.Lines.IndexOf(strHisCtaPreNotaAtual));

      strHisCtaPreNotaAtual := qryGen.FieldByName('PRE_HISCTA').AsString;
      If Not fEmptyStr(strHisCtaPreNotaAtual) Then
        mmoHisCta.Lines.Add(strHisCtaPreNotaAtual);

      mskCompet.Text                  := qryGen.FieldByName('PRE_COMPET').AsString;
      fraCentroCusto.edtCodEve.Text   := qryGen.FieldByName('PRE_CODEVE').AsString;
      pCarregaEvento;
      fraPlanoDeContas.MskCodCta.Text := qryGen.FieldByName('PRE_CODCTA').AsString;
      edtCodPor.Text                  := qryGen.FieldByName('PRE_CODPOR').AsString;
      pCarregaPortador;
      //condição
      {* Req. 455181 - True indica origem no fluxo de entrada: aqui o      *}
      {* excesso de parcelas deve abortar, nao truncar.                    *}
      pCarregaDuplicatasCND(4, qryGen.FieldByName('PRE_SEQGER').AsString, ArrDuplicata^, True);
      pRefazCondPagamento;
      blnPreCtp := True;
      blnTemDupEle := False; //Pre-nota (PRECTP) redefiniu ArrDuplicata, deixando de vir do DUPELE importado do XML
      //desmembramento
      pCarregaDesmembramento;
      //pagamento antecipado
      pCarregaAntecipados;
      If chkPgoAnt.Checked Then
      Begin
        If fTemAntecipadoValorMenor Then
        Begin
          mskCndPag.Enabled := True
        End
        Else
        Begin
          mskCndPag.Enabled := False;
          mskCndPag.Clear;
        End;
      End
      Else
        mskCndPag.Enabled := False;
    End;
    qryGen.Close;
  Finally
    FreeAndNil(qryGen);
  End;
End;

procedure TfrmEntDadosFiscaisResumo.cbxBcoForChange(Sender: TObject);
begin
  inherited;
  intIdxBcoForAnt := cbxBcoFor.ItemIndex;
end;

procedure TfrmEntDadosFiscaisResumo.cbxBcoForDropDown(Sender: TObject);
begin
  inherited;
  SendMessage(cbxBcoFor.Handle, CB_SETDROPPEDWIDTH, 315, 0);
end;

procedure TfrmEntDadosFiscaisResumo.cbxBcoForEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'INSERT para incluir/alterar dados bancários do fornecedor';
end;

procedure TfrmEntDadosFiscaisResumo.cbxBcoForExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmEntDadosFiscaisResumo.cbxBcoForKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key =  VK_Insert) Then
  Begin

    pCriarFormularios(TfrmCadFornecedores, frmCadFornecedores);

    try
      frmCadFornecedores.strCodFornecedorIniciarCadastro := strCodFor;
      frmCadFornecedores.fMskCon := fMskCon;
      frmCadFornecedores.fSemMascaraPlaNco := fSemMascaraPlaNco;
      frmCadFornecedores.fPesqPlanoContabil := fPesqPlanoContabil;
      frmCadFornecedores.pPlanoDeContasPorEmpresa := pPlanoDeContasPorEmpresa;
      frmCadFornecedores.fVerificarPlanoDeContasPorEmpresa := fVerificarPlanoDeContasPorEmpresa;
      frmCadFornecedores.pGravarPlanoContasAutomatico := pGravarPlanoContasAutomatico;
      frmCadFornecedores.pGravarPlanoContasAutomaticoParaCadaEmpresa := pGravarPlanoContasAutomaticoParaCadaEmpresa;
      frmCadFornecedores.fCadastroRapidoCliente := TfrmCadClientes.fCadastroRapidoCliente;
      frmCadFornecedores.fCadastroRapidoTransportadora := TfrmCadTransportadoras.fCadastroRapidoTransportadora;
      frmCadFornecedores.fCriaEstruturaCdsNCO := fCriaEstruturaCdsNCO ;
      frmCadFornecedores.pCarregaPlanoDeContasPorEmpresa := pCarregaPlanoDeContasPorEmpresa ;
      frmCadFornecedores.pSalvaPlanoDeContasPorEmpresa := pSalvaPlanoDeContasPorEmpresa;
      frmCadFornecedores.ShowModal;
    finally
      frmCadFornecedores.fMskCon := Nil;
      frmCadFornecedores.fSemMascaraPlaNco := Nil;
      frmCadFornecedores.fPesqPlanoContabil := Nil;
      frmCadFornecedores.fCadastroRapidoCliente := Nil;
      frmCadFornecedores.fCadastroRapidoTransportadora := Nil;
      frmCadFornecedores.fCriaEstruturaCdsNCO := Nil ;
      frmCadFornecedores.pCarregaPlanoDeContasPorEmpresa := Nil ;
      frmCadFornecedores.pSalvaPlanoDeContasPorEmpresa := Nil ;
      pCarregaDadosBancariosFornecedor(strCodFor);
      pFreeAndNil(frmCadFornecedores);

   End;

  End;
end;

procedure TfrmEntDadosFiscaisResumo.cbxModFreChange(Sender: TObject);
var intModFreSelec: integer;
    blnDescontaFreteDevolucaoOriginal: Boolean;
begin
  If blnDevolu Then
  Begin
    blnDescontaFreteDevolucaoOriginal := blnDescontaFreteDevolucao;
    intModFreSelec := StrToInt(cbxModFre.Text[1]);
    blnDescontaFreteDevolucao := blnDevolu and((fCfgSis('FREDEV') = 1) Or ((fCfgSis('FREDEV') = 3) And (intModFreSelec in[1, 3, 4, 9])));
    If blnDescontaFreteDevolucaoOriginal <> blnDescontaFreteDevolucao Then
      fValidaCampos(mskCndPag)
  End;

end;



procedure TfrmEntDadosFiscaisResumo.chkAtuPreClick(Sender: TObject);
  Var
    strSenOpe: String;
begin
  inherited;

  If chkAtuPre.Checked Then
  Begin
  
    If Not (ffrmSenha(strSenOpe, 'Desativar atualização Preço') And
            fVerificaAcessoSistema('NAOATUPRE', fRetCodVendedor(strSenOpe))) Then
    Begin
      pMensagemOk('Operador sem direito de acesso!');
      chkAtuPre.Checked := False;
    End;

  End;
end;

procedure TfrmEntDadosFiscaisResumo.chkDeposiClick(Sender: TObject);
begin
  inherited;
  cbxBcoFor.Enabled := chkDeposi.Checked;

  If Not cbxBcoFor.Enabled Then
    cbxBcoFor.ItemIndex := -1;
end;

procedure TfrmEntDadosFiscaisResumo.chkGraFinClick(Sender: TObject);
begin
  inherited;

  pHabilitaCamposFinanceiro;
end;

procedure TfrmEntDadosFiscaisResumo.pHabilitaCamposFinanceiro;
Begin
  If (chkGraFin.Checked Or chkPgoAnt.Checked) And blnTravarFinanceiroEstaDuplicado Then
  begin
    fMensagem('ATENÇÃO!', 'Já existe uma duplicata no contas a pagar com esses dados!', ['&O k']);
    chkPgoAnt.OnClick := Nil;
    Try
      chkPgoAnt.Checked := False;
    Finally
      chkPgoAnt.OnClick := chkPgoAntClick;
    End;
    chkGraFin.Checked := False;
    pLimpaSelecaoPgoAntecipado;
  End;

  edtCodPor.Enabled := chkGraFin.Checked;
  mmoHisCta.Enabled := chkGraFin.Checked;
  lblInfCtp.Enabled := chkGraFin.Checked;

  If Not blnPreCtp Then
  Begin
    If Not mmoHisCta.Enabled Then
      mmoHisCta.Clear;

    If Not edtCodPor.Enabled Then
    Begin
      edtCodPor.clear;
      edtNomPor.clear;
    End else
    begin
      If not blnDevolu Then
      Begin
        edtCodPor.Text := objPortadorFornecedor.strCodPor;
        edtNomPor.Text := objPortadorFornecedor.strNomPor;

        edtCodPor.enabled := not objPortadorFornecedor.fTravaPortador;
      End;
    end;
  End;

  pHabilitaVendorOutrasDespesas;
End;

function TfrmEntDadosFiscaisResumo.fRetEmpresaAbastecimentoDepositoNaDevolucaoDaNota(
  strDocSel: String): String;
var
  LObjDocumentosAbastecimentoDeposito: TDocumentosAbastecimentoDeposito;
  stlDocSel: TStringList;
  strDocOri: String;
  strEspOri: String;
  strEmpOri: String;
  strCliOri: String;
begin
  Result := EmptyStr;

  If fEmptyStr(strDocSel) Then
    Exit;

  If Not fCfgSis('ABADEP',varBoolean) Then
    Exit;

  stlDocSel := TStringList.Create;
  Try
    stlDocSel.CommaText := Trim(AnsiReplaceStr(AnsiReplaceStr(strDocSel,#39,''),'"',''));

    strDocOri := Copy(stlDocSel[0], 01, fTamDocCadRec());
    strEspOri := Copy(stlDocSel[0], fTamDocCadRec() + 1, 2);
    strEmpOri := Copy(stlDocSel[0], fTamDocCadRec() + 3, 3);
    strCliOri := Copy(stlDocSel[0], fTamDocCadRec() + 6, 8);

    LObjDocumentosAbastecimentoDeposito := TDocumentosAbastecimentoDeposito.Create(strDocOri, strEspOri, strEmpOri, strCliOri);

    Try
      LObjDocumentosAbastecimentoDeposito.pCarregaDocumentosDeAbastecimentoDeposito;

      If LObjDocumentosAbastecimentoDeposito.ObjInformacaoDocumentoAbastecimentoDepositoList.Count = 1 Then
      Begin
        strCodCnd := fCampoTabela('GER_CODCND','MOVGER',['GER_NUMDOC','GER_ESPDOC','GER_CODEMP'],[strDocOri,strEspOri,strEmpOri],False);
        Result := LObjDocumentosAbastecimentoDeposito.ObjInformacaoDocumentoAbastecimentoDepositoList[0].CodEmp;
      End;
    Finally
      FreeAndNil(LObjDocumentosAbastecimentoDeposito);
    End;
  Finally
    FreeAndNil(stlDocSel);
  End;
end;

Function TfrmEntDadosFiscaisResumo.fTemAntecipadoValorMenor: Boolean;
Begin
  If Not FblnAcessadoViaPrenota Then
    Result := (RoundTo(objPgoAnt.fltTotSel, -2) < RoundTo(fStrToFloat(edtVlrCon.Text)-fRetTotalRetencoes(dtsCadFis.DataSet), -2)) And chkPgoAnt.Checked
  Else
    Result := (RoundTo(objPgoAnt.fltTotSel, -2) < RoundTo(fStrToFloat(edtVlrCon.Text), -2)) And chkPgoAnt.Checked;
End;

function TfrmEntDadosFiscaisResumo.fValidaNotaPossuiItensDevolvidosFaturados(ARecNotEle: TRecInfoNotaEletronica): Boolean;
var
  qryConsulta: TUniQuery;
  LChaveRefNfe: String;
  frmObservacao: TfrmObservacao;
  LStlListaItens: TStringList;
begin
  Result := True;

  If ARecNotEle.finalidadeXML <> xmlConsignacaoDevolucaoCliente Then
    Exit;

  LChaveRefNfe := TRetornoConsignacaoBuilder.RetornaChaveReferenciada(ARecNotEle.strCodCli, ARecNotEle.strNumDoc, Integer(ARecNotEle.finalidadeXML));
  LStlListaItens := TStringList.Create;
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT C.CON_TIPMOV,     ' +
                        '       R.RET_REFNFE,     ' +
                        '       DET.DET_CODITE,   ' +
                        '       DET.DET_CODEMP,   ' +
                        '       DET.DET_DESCRI,   ' +
                        '       M.GER_ESPDOC,     ' +
                        '       M.GER_NUMDOC,     ' +
                        '       M.GER_ESPDOC,     ' +
                        '       CONCAT(C.CON_NUMDOC,"-", C.CON_ESPDOC) AS DOCENV, ' +
                        '       (CASE WHEN C.CON_TIPMOV = "D" THEN "DEVOLVIDO" ' +
                        '             WHEN C.CON_TIPMOV = "F" THEN "FATURADO" END) AS DESCMOV ' +
                        'FROM DETELE D            ' +
                        'JOIN GERELE G ON D.DET_SEQGER = G.AUTOINCREM           ' +
                        'JOIN RETELE R ON G.AUTOINCREM = R.RET_SEQGER           ' +
                        'INNER JOIN MOVGER M ON G.GER_CODEMP = M.GER_CODEMP AND ' +
                        '                       G.GER_ESPENT = M.GER_ESPDOC AND ' +
                        '                       G.GER_DOCENT = M.GER_NUMDOC AND ' +
                        '                       G.GER_CODCLI = M.GER_CODCLI     ' +
                        'INNER JOIN MOVDET DET ON M.AUTOINCREM = DET.DET_SEQGER ' +
                        '                     AND D.DET_CODITE = DET.DET_CODITE ' +
                        'LEFT JOIN MOVCON C ON C.CON_SEQGER = DET.AUTOINCREM    ' +
                        'WHERE GER_TIPXML = 5                                   ' +
                        '  AND R.RET_REFNFE = :RET_REFNFE                       ' +
                        '  AND C.CON_TIPMOV IN ("D", "F")                       '
                        );
    qryConsulta.ParamByName('RET_REFNFE').AsString := LChaveRefNfe;
    qryConsulta.Open;
    If Not qryConsulta.IsEmpty Then
    Begin
      While Not qryConsulta.EOF do
      Begin
        LStlListaItens.Add(qryConsulta.FieldByName('DET_CODITE').AsString + ' - ' + qryConsulta.FieldByName('DET_DESCRI').AsString);
        LStlListaItens.Add('Envio: ' + qryConsulta.FieldByName('DOCENV').AsString);
        LStlListaItens.Add('Status: '+ qryConsulta.FieldByName('DESCMOV').AsString);
        LStlListaItens.Add('');
        qryConsulta.Next;
      End;
    End;

    Result := qryConsulta.RecordCount <= 0;

    If Not Result Then
    Begin
      pCriarFormularios(TfrmObservacao, frmObservacao);
      Try
        frmObservacao.Caption := 'Os itens abaixo já foram devolvidos, verifique!';
        frmObservacao.lblMensagem.Caption := ' Os itens abaixo já foram devolvidos: ';
        frmObservacao.memObs.Lines.Assign(LStlListaItens);
        frmObservacao.ShowModal;
      Finally
        pFreeAndNil(frmObservacao);
      End;
    End;
  Finally
    FreeAndNil(qryConsulta);
    FreeAndNil(LStlListaItens)
  End;
end;

function TfrmEntDadosFiscaisResumo.fTemItemMarmoreGranitoSemLoteADefinirCadastrado: Boolean;
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT COUNT(1) QTD FROM TMP_ENTMER ');
    qryConsulta.SQL.Add('  INNER JOIN CADLOT ON LOT_CODEMP = "' + VS_StrCodEmp + '"');
    qryConsulta.SQL.Add('                  AND LOT_NUMLOT = ENT_NUMLOT  ');
    qryConsulta.SQL.Add('                  AND LOT_CODITE = ENT_CODITE  ');
    qryConsulta.SQL.Add(' WHERE ENT_GRAMAR = "S"  ');
    qryConsulta.SQL.Add('   AND ENT_NUMLOT = "A DEFINIR"  ');

    qryConsulta.Open;

    Result := qryConsulta.FieldByName('QTD').AsInteger = 0;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmEntDadosFiscaisResumo.pAjustaTelaPgoAntecipado;
var
  blnGraFin: Boolean;
Begin
  If chkPgoAnt.Checked Then
  Begin
    blnGraFin := fTemAntecipadoValorMenor and (TEntradaAutomatizada.fGravaContasPagar(IIf(FblnAcessadoViaPrenota, '1102', fRetClaFisCadFis(1)), strCodFor) And (Not blnDevolu));
    btnPgoAnt.Enabled := True;
    chkGraFin.Enabled := False;
    chkGraFin.Checked := blnGraFin;
    mskCndPag.Enabled := blnGraFin;
    btnDesmembraValores.Enabled := blnGraFin;
    mskCndPag.Clear;
    pZeraDigDuplic(ArrDuplicata^);
  End Else
  Begin
    btnPgoAnt.Enabled := False;
    mskCndPag.Clear;
    pZeraDigDuplic(ArrDuplicata^);

    mskCndPag.Enabled := True;
    objPgoAnt.pSetaListaSelecao(Nil);
    pHabilitaFinanceiro;
    btnDesmembraValores.Enabled := True;
  End;

  pHabilitaCamposFinanceiro;

  If (chkGraFin.Checked Or chkPgoAnt.Checked) And blnTravarFinanceiroEstaDuplicado Then
    begin
      fMensagem('ATENÇÃO!', 'Já existe uma duplicata no contas a pagar com esses dados!', ['&O k']);
      chkGraFin.Checked := False;
      chkPgoAnt.OnClick := Nil;
      Try
        chkPgoAnt.Checked := False;
      Finally
        chkPgoAnt.OnClick := chkPgoAntClick;
      End;
      pLimpaSelecaoPgoAntecipado;
    End;


End;

//Zera a selecao de pagamento antecipado e recarrega o estado original (XML/pre-nota).
//Nao chama pAjustaTelaPgoAntecipado/pHabilitaFinanceiro/pHabilitaCamposFinanceiro de proposito:
//este metodo e usado de dentro dessas 3 rotinas, e chama-las de volta causaria recursao.
procedure TfrmEntDadosFiscaisResumo.pLimpaSelecaoPgoAntecipado;
begin
  objPgoAnt.pSetaListaSelecao(Nil);
  pCarregaDuplicatasXML;
end;

//Uso fora do trio pAjustaTelaPgoAntecipado/pHabilitaFinanceiro/pHabilitaCamposFinanceiro
//(ex.: chkPrevisaoClick), onde chamar pAjustaTelaPgoAntecipado e seguro.
procedure TfrmEntDadosFiscaisResumo.pDesmarcaPgoAntecipadoComLimpeza;
begin
  chkPgoAnt.Checked := False;
  pAjustaTelaPgoAntecipado;
  pCarregaDuplicatasXML;

  //A pre-nota (PRECTP) pode ter restaurado chkPgoAnt.Checked para True dentro do reload acima
  //(a atribuicao em pCarregaDadosContasPagarPreNota usa OnClick := Nil, entao o mutex
  //chkPgoAnt/chkPrevisao feito em chkPgoAntClick nao roda para essa transicao).
  //Se isso ocorreu, a pre-nota venceu: desfaz chkPrevisao para nao deixar os dois marcados.
  If chkPgoAnt.Checked Then
    chkPrevisao.Checked := False;
end;

procedure TfrmEntDadosFiscaisResumo.pApagaExistentePreCtp(strAutInc: string);
var qryComand: TUniQuery;
begin
  qryComand := fCriaQuery;
  Try
    qryComand.SQL.Add('DELETE FROM PRECTP WHERE PRE_SEQGER = "' + strAutInc + '";');
    qryComand.SQL.Add('DELETE FROM PRECND WHERE PRE_SEQGER = "' + strAutInc + '";');
    qryComand.SQL.Add('DELETE FROM PREPGA WHERE PRE_SEQGER = "' + strAutInc + '";');
    qryComand.SQL.Add('DELETE FROM PREDES WHERE PRE_SEQGER = "' + strAutInc + '";');

    qryComand.ExecSQL;

  Finally
    FreeAndNil(qryComand);
  End;
end;

procedure TfrmEntDadosFiscaisResumo.pHabilitaFinanceiro;
Begin
  If (blnDevolu And (fStatusCndPag(mskCndPag.Text) = A_VISTA) And (fCfgSis('DEVCTP', varBoolean)) And (Not blnConEqu) And (Not blnLocEqu)) Or
     ((Not blnDevolu) And (fStatusCndPag(mskCndPag.Text) = A_VISTA) And (fCfgSis('OPTCTP', varBoolean)) And (Not blnConEqu) And (Not blnLocEqu)) Then
  Begin
    chkGraFin.Enabled := (Not chkPgoAnt.Checked);
    mmoHisCta.Enabled := True;
    lblInfCtp.Enabled := True;
  End
  Else
  Begin
    chkGraFin.Enabled := False;

    If chkPgoAnt.Checked Then
      chkGraFin.Checked := fTemAntecipadoValorMenor and (TEntradaAutomatizada.fGravaContasPagar(fRetClaFisCadFis(1), strCodFor) And (Not blnDevolu))
    Else If (Not TEntradaAutomatizada.fGravaContasPagar(fRetClaFisCadFis(1), strCodFor, false, recNotEle.finalidadeXML) And (Not blnDevolu)) Then
      chkGraFin.Checked := False
    Else
      chkGraFin.Checked := True;

    mmoHisCta.Enabled := chkGraFin.Checked;
    lblInfCtp.Enabled := chkGraFin.Checked;
  End;
  If (chkGraFin.Checked Or chkPgoAnt.Checked) And blnTravarFinanceiroEstaDuplicado Then
  begin
    chkPgoAnt.OnClick := Nil;
    Try
      chkPgoAnt.Checked := False;
    Finally
      chkPgoAnt.OnClick := chkPgoAntClick;
    End;
    chkGraFin.Checked := False;
    pLimpaSelecaoPgoAntecipado;
  end;

End;

procedure TfrmEntDadosFiscaisResumo.chkPgoAntClick(Sender: TObject);
begin
  inherited;
  pAjustaTelaPgoAntecipado;
  If chkPgoAnt.Checked Then
  begin
    If chkPrevisao.Checked Then
      chkPrevisao.Checked := False;
  end
  Else
    pCarregaDuplicatasXML;
end;

procedure TfrmEntDadosFiscaisResumo.chkPrevisaoClick(Sender: TObject);
begin
  inherited;
  If chkPrevisao.Checked Then
    If chkPgoAnt.Checked Then
      pDesmarcaPgoAntecipadoComLimpeza;
end;

procedure TfrmEntDadosFiscaisResumo.chkTransfAutClick(Sender: TObject);
begin
  inherited;
  edtCodEmpresa.Enabled := chkTransfAut.Checked;
  If Not edtCodEmpresa.Enabled Then
    edtCodEmpresa.Text := '';
end;

procedure TfrmEntDadosFiscaisResumo.chkVeioBoClick(Sender: TObject);
begin
  inherited;
  If (Not mskCndPag.Enabled) And (Not fEmptyStr(recNotEle.strAutInc)) And (Length(ArrDuplicata^) > 0) And
     ((fCfgSis('CTPBOL', varBoolean)) And (chkVeioBo.Checked) And
      (fTiraCaracEspeciaisPonto(mskCndPag.Text) <> '01000') And
      (Not fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text))) And
      (ArrDuplicata[0].strSequen <> '')) Then
  Begin
    pCriarFormularios(TfrmDigCodBarBoleto, frmDigCodBarBoleto);
    frmDigCodBarBoleto.arrLinDigCodbar := arrLinDigCodbar;
    frmDigCodBarBoleto.arrDuplicata := arrDuplicata;
    Try
      frmDigCodBarBoleto.ShowModal;
    Finally
      Begin
        arrLinDigCodbar      := frmDigCodBarBoleto.arrLinDigCodbar;
        intQtdPar            := frmDigCodBarBoleto.intQtdPar;
        FreeAndNil(frmDigCodBarBoleto);
      End;
    End;
  End;
End;

procedure TfrmEntDadosFiscaisResumo.btnConFreClick(Sender: TObject);
  Var
    objFreCon: TFreCon;
begin
  inherited;

  If (tipRatFrete = trfPropPesoItem) And (Not fVerificaPesoDosItensEntrada) Then
    Exit;

  If fCfgSis('ATPRAU', varBoolean) And (fCfgSis('PERFRE', varInteger) = 2) And (fStrToFloat(edtValFre.Text) > 0) Then
  Begin
    pMensagemOk('O sistema está configurado para atualizar o valor do conhecimento de frete diretamento no campo "Valor do frete" no cadastro de produtos.' + #13#10 +
                'Essa nota já possui frete, nesse caso, é preciso digitar o conhecimento após a entrada de mercadorias!');
    Exit;
  End;

  objFreCon := TFreCon.Create(Self);

  Try
    // SALVA OS DADOS DAS DUPLICATAS DA NOTA
    objFreCon.pControlaDigDuplicAtual(1);
    pAtualizarObjLisFre;
    objLisFre.pGridConhecimento(strNumDoc, strCodFor, strSerie, ArrDuplicata);
    If fCfgSis('URSTCL', varBoolean) Then
      pMensagemOk('Lembre-se! Se quiser distribuir o valor do CTE na GNRE, deve entrar novamente na Tela de GNRE.');
    fltAntIcF := objLisFre.fltAntIcT;
    fltBasAnF := objLisFre.fltBasAnT;

  Finally
    // RESTAURA OS DADOS DAS DUPLICATAS DA NOTA
    objFreCon.pControlaDigDuplicAtual(2);

    FreeAndNil(objFreCon);
  End;

end;

function TfrmEntDadosFiscaisResumo.fAtualizaPedidoDevolucao(strNumFat,
                                                            strEspFat,
                                                            strVenFat,
                                                            strDigFat,
                                                            strCndfat: String;
                                                            fltValFat: Double): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin

  Result  := True;

  If fEmptyStr(strPedDev) Then
    Exit;

  Try

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  FATGOR ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  FGO_NUMFAT = :NUMFAT, ';
    strSQL := strSQL + '  FGO_TIPFAT = :ESPFAT, ';
    strSQL := strSQL + '  FGO_JAFATU = TRUE, ';
    strSQL := strSQL + '  FGO_DTAFAT = ' + fCurrentDate + ', ';
    strSQL := strSQL + '  FGO_VENFAT = :VENFAT, ';
    strSQL := strSQL + '  FGO_DIGFAT = :DIGFAT, ';
    strSQL := strSQL + '  FGO_CNDFAT = :CNDFAT, ';
    strSQL := strSQL + '  FGO_VALFAT = :VALFAT  ';


    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FGO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  FGO_ESPDOC = "PD"    AND ';
    strSQL := strSQL + '  FGO_CODEMP = :CODEMP ';

    qryGen := fCriaQuery;

    With qryGen Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strPedDev;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      ParamByName('NUMFAT').AsString := strNumFat;
      ParamByName('ESPFAT').AsString := strEspFat;

      If (fEmptyStr(strVenFat)) Then
        ParamByName('VENFAT').Value := Null
      Else
        ParamByName('VENFAT').AsString := strVenFat;

      If (fEmptyStr(strDigFat)) Then
        ParamByName('DIGFAT').Value := Null
      Else
        ParamByName('DIGFAT').AsString := strDigFat;

      ParamByName('CNDFAT').AsString := strCndFat;
      ParamByName('VALFAT').AsFloat  := fltValFat;

      ExecSQL;
      Close;

    End;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  FATDOR ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  FDO_NUMFAT = :NUMFAT, ';
    strSQL := strSQL + '  FDO_TIPFAT = :ESPFAT, ';
    strSQL := strSQL + '  FDO_JAFATU = TRUE, ';
    strSQL := strSQL + '  FDO_DTAFAT = ' + fCurrentDate + ', ';
    strSQL := strSQL + '  FDO_VENFAT = :VENFAT, ';
    strSQL := strSQL + '  FDO_EMPFAT = :CODEMP, ';
    strSQL := strSQL + '  FDO_CNDFAT = :CNDFAT, ';
    strSQL := strSQL + '  FDO_VALFAT = :VALFAT ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FDO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  FDO_ESPDOC = "PD"    AND ';
    strSQL := strSQL + '  FDO_CODEMP = :CODEMP ';

    With qryGen Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strPedDev;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      ParamByName('NUMFAT').AsString := strNumFat;
      ParamByName('ESPFAT').AsString := strEspFat;

      If (fEmptyStr(strVenFat)) Then
        ParamByName('VENFAT').Value := Null
      Else
        ParamByName('VENFAT').AsString := strVenFat;

      ParamByName('CNDFAT').AsString := strCndFat;
      ParamByName('VALFAT').AsFloat  := fltValFat;
      ExecSQL;
      Close;

    End;

    FreeAndNil(qryGen);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fAtualizaPedidoDevolucao]');
    End;
  End;

end;

function TfrmEntDadosFiscaisResumo.fBaixaNotaConf(const strNumDoc, strEspDoc, strEmpDoc,
  strSerie_, strCodCli: String): Boolean;
  Var
    qry: TUniQuery;
    strSQL : String;
Begin
  strSQL := 'UPDATE NOTGER SET GER_NUMFAT = GER_NUMDOC, GER_TIPFAT = GER_ESPDOC, GER_EMPFAT = GER_CODEMP  ';
  strSQL := strSQL + ' WHERE IFNULL(GER_SERIE_, "") = :SERIE_ AND GER_CODCLI = :CODCLI AND  ';
  strSQL := strSQL +         ' GER_NUMDOC = :NUMDOC AND GER_ESPDOC = :ESPDOC AND GER_CODEMP = :CODEMP';
  Result := True;
  Try
    Try
      qry := fCriaQuery;
      qry.close;
      qry.Sql.Clear;
      qry.sql.Add(strSQL);
      qry.ParamByName('NUMDOC').AsString := strNumDoc;
      qry.ParamByName('ESPDOC').AsString := strEspDoc;
      qry.ParamByName('CODEMP').AsString := strEmpDoc;
      qry.ParamByName('CODCLI').AsString := strCodCli;
      qry.ParamByName('SERIE_').AsString := strSerie_;
      qry.ExecSQL;
    Except
      On E: Exception do
      begin
        Result := False;
      end;
    end;
  Finally
    if Assigned(Qry) then
      FreeAndNil(qry);
  end;

end;

function TfrmEntDadosFiscaisResumo.fEhFornecedor: Boolean;
begin
  If blnConEqu Then
    Exit(False);
  If blnDevolu  then
    Exit(False);
  if blnRecCliGarantia then
    Exit(False);
  If (blnGarantia And blnRecCliGarantia) Then
    Exit(False);
  if FblnAcessadoViaRetornoConsignacao then
    Exit(False);
  If blnLocEqu Then
    Exit(False);

  Exit(True);
end;

function TfrmEntDadosFiscaisResumo.fGeraAgendamento(strAutIncMovger: String): Boolean;
Var
 qryMovger: TUniQuery;
begin
  Result := (fUsaRotinaWMS and
             fConferenciaDepoisDaEntrada And
             (fCfgSis('TPLREC', varString) <> 'N') and
             (fCampoTabela('FOR_SEMAGE', 'CADFOR', ['FOR_CODFOR'], [strCodFor]) = 'S'));

  If (Result) And (Not fEmptyStr(strAutIncMovger)) Then
  Begin
    Try
      qryMovger := fCriaQuery;
      qryMovger.SQL.Clear;
      qryMovger.SQL.Add(' SELECT AUTOINCREM          ');
      qryMovger.SQL.Add('   FROM MOVGER              ');
      qryMovger.SQL.Add(' WHERE AUTOINCREM = :AUTINC ');
      qryMovger.SQL.Add(' AND GER_DTAENT IS NULL     ');

      qryMovger.ParamByName('AUTINC').AsString := strAutIncMovger;
      qryMovger.Close;
      qryMovger.Open;

      Result := Result And (Not qryMovger.isEmpty);

    Finally
      FreeAndNil(qryMovger);
    End;
  End;

end;

function TfrmEntDadosFiscaisResumo.fEhOperacaoTransferenciaEstoque(
  const strNumDoc, strEspDoc, strCodFor: String; out strEmpFat, strCodCli, strSerie_: String): boolean;
  Var
   strSQL: String;
   Qry: TUniQuery;
begin
  Result := False;
  strSQL := EmptyStr;
  strSQL := strSQL + ' SELECT G.GER_NUMDOC, G.GER_SERIE_, G.GER_ESPDOC,G.GER_CODEMP, G.GER_CODCLI, G2.GER_ESPDOC as "ESPDOC_ORI", ';
  strSQL := strSQL +        ' G2.GER_EMPFAT, G2.GER_CODEMP, PC.PCG_NUMPED, PC.PCG_ESPDOC ';
  strSQL := strSQL + ' FROM NOTGER G ';
  strSQL := strSQL + ' JOIN MOVGER G2 ON G2.GER_NUMFAT = G.GER_NUMDOC and G2.GER_CODCLI = G.GER_CODCLI ';
  If fCfgSis('CPDORI', varBoolean) Then
  Begin
    strSQL := strSQL + ' INNER JOIN PCMGER PC ON  PC.PCG_ORIGND = G2.GER_NUMDOC ';
    strSQL := strSQL + '                  AND PC.PCG_ORIGES = G2.GER_ESPDOC ';
    strSQL := strSQL + '                  AND PC.PCG_ORIGEP = G2.GER_CODEMP ';
  End
  Else
    strSQL := strSQL + ' JOIN PCMGER PC ON PC.PCG_DOCORI = CONCAT(G2.GER_NUMDOC,G2.GER_ESPDOC, G2.GER_CODEMP) ';
  strSQL := strSQL + ' JOIN CADEMP EO ON EO.EMP_CODEMP = G.GER_CODEMP AND EO.EMP_FORFIL = PC.PCG_CODFOR ';
  strSQL := strSQL + ' JOIN CADEMP ED ON ED.EMP_CLIFIL = G.GER_CODCLI ';
  strSQL := strSQL + ' WHERE G.GER_NUMDOC = :NUMDOC AND G.GER_ESPDOC = :ESPDOC  AND PC.PCG_CODFOR = :CODFOR  AND ED.EMP_CODEMP = :CODEMP';
  Qry := Nil;
  Try
    Qry := fCriaQuery(Nil);
    Qry.Close;
    Qry.Sql.Clear;
    Qry.Sql.Add(strSql);
    Qry.ParamByName('NUMDOC').AsString := strNumDoc;
    Qry.ParamByName('ESPDOC').AsString := strEspDoc;
    Qry.ParamByName('CODEMP').AsString := VS_strCodEmp;
    Qry.ParamByName('CODFOR').AsString := strCodFor;
    Qry.Open;
    if Not Qry.IsEmpty then
    begin
      Qry.First;
      Result := Qry.FieldByName('ESPDOC_ORI').AsString = 'TE';
      if Result then
      begin
        strEmpFat := Qry.FieldByName('GER_CODEMP').AsString;
        strSerie_ := Qry.FieldByName('GER_SERIE_').AsString;
        strCodCli := Qry.FieldByName('GER_CODCLI').AsString;
      end;
    end;
    if Qry.Active then
      Qry.Close;
  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;

end;

function TfrmEntDadosFiscaisResumo.fGetBcoFor: String;
begin
  If cbxBcoFor.ItemIndex > -1 Then
    Result := lstBcoFor[cbxBcoFor.ItemIndex]
  Else
    Result := '';
end;

function TfrmEntDadosFiscaisResumo.fGetModDocumentocbxCODMOD: String;
begin
  if cbxCODMOD.ItemIndex >= 0 then
    Result := cbxCODMOD.Items.Names[cbxCODMOD.ItemIndex]
  else
    Result := EmptyStr;
end;

function TfrmEntDadosFiscaisResumo.fGravaPreCtp: Boolean;
var qryComand: TUniQuery;
  procedure pGravaPRECND(strAutInc: String; arrDuplic: TarrDuplicata );
  Var
    qryPreCnd: TUniQuery;
    intContador: Integer;
  Begin
    Try
      qryPreCnd := fCriaQuery(Nil);

      With qryPreCnd, SQL Do
      Begin
        Add('SELECT * FROM PRECND WHERE FALSE');
        Open;
        For intContador := Low(arrDuplic) To High(arrDuplic) Do
        Begin
          If arrDuplic[intContador].curValor > 0 Then
          Begin
            qryPreCnd.Insert;
            FieldByName('PRE_SEQGER').AsString   := strAutInc;
            FieldByName('PRE_PARCEL').AsString   := arrDuplic[intContador].strSequen;
            FieldByName('PRE_VALPAR').AsFloat    := arrDuplic[intContador].curValor;
            FieldByName('PRE_DTAVEN').AsDateTime := StrToDate(arrDuplic[intContador].dtaDtaVen);
            qryPreCnd.Post;
          End;
        End;

      End;

    Finally
      FreeAndNil(qryPreCnd);
    End;
  End;

  procedure pGravaPREDES(cdsCtpDet: TUniClientDataSet);
    Var
    qryPreDes: TUniQuery;
  Begin
    Try
      qryPreDes := fCriaQuery(Nil);

      cdsCtpDet.First;

      With qryPreDes, SQL Do
      Begin
        Add('SELECT * FROM PREDES WHERE FALSE');
        Open;
        While (Not cdsCtpDet.Eof) Do
        Begin
          qryPreDes.Insert;
          FieldByName('PRE_NUMDUP').AsString := cdsCtpDet.FieldByName('CTP_NUMDUP').AsString;
          FieldByName('PRE_PARCEL').AsString := cdsCtpDet.FieldByName('CTP_PARCEL').AsString;
          FieldByName('PRE_CODEMP').AsString := cdsCtpDet.FieldByName('CTP_CODEMP').AsString;
          FieldByName('PRE_SERIE_').AsString := cdsCtpDet.FieldByName('CTP_SERIE_').AsString;
          FieldByName('PRE_CODFOR').AsString := cdsCtpDet.FieldByName('CTP_CODFOR').AsString;
          FieldByName('PRE_CODCTA').AsString := cdsCtpDet.FieldByName('CTP_CODCTA').AsString;
          FieldByName('PRE_DESCTA').AsString := cdsCtpDet.FieldByName('CTA_DESCTA').AsString;
          FieldByName('PRE_DEBCRE').AsString := cdsCtpDet.FieldByName('CTP_DEBCRE').AsString;
          FieldByName('PRE_CODEVE').AsString := cdsCtpDet.FieldByName('CTP_CODEVE').AsString;
          FieldByName('PRE_MARDES').AsString := cdsCtpDet.FieldByName('CTP_MARDES').AsString;
          FieldByName('PRE_VALDUP').AsFloat  := cdsCtpDet.FieldByName('CTP_VALDUP').AsFloat;
          FieldByName('PRE_FATCAL').AsFloat  := cdsCtpDet.FieldByName('CTP_FATCAL').AsFloat;
          FieldByName('PRE_PERCEN').AsFloat  := cdsCtpDet.FieldByName('PERCENTUAL').AsFloat;
          FieldByName('PRE_SEQGER').AsString := recNotEle.strAutInc;
          qryPreDes.Post;
          cdsCtpDet.Next;
        End;
      End;

    Finally
      FreeAndNil(qryPreDes);
    End;
  End;

begin
  Result := True;

  Try
    qryComand := fCriaQuery;
    Try

      qryComand.SQl.Add('INSERT INTO PRECTP( AUTOINCREM, PRE_SEQGER, PRE_VEIOBO, PRE_DEPOSI, PRE_PGOANT, PRE_BCOFOR, PRE_CNDPAG, PRE_HISCTA, PRE_COMPET, PRE_CODEVE, PRE_CODCTA, PRE_CODPOR, PRE_CODFOR, PRE_VENCTA, PRE_VENPAG, PRE_VALVEN) VALUES ');
      qryComand.SQl.Add('                  (:AUTOINCREM,:PRE_SEQGER,:PRE_VEIOBO,:PRE_DEPOSI,:PRE_PGOANT,:PRE_BCOFOR,:PRE_CNDPAG,:PRE_HISCTA,:PRE_COMPET,:PRE_CODEVE,:PRE_CODCTA,:PRE_CODPOR,:PRE_CODFOR,:PRE_VENCTA,:PRE_VENPAG,:PRE_VALVEN) ');





      qryComand.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('PRECTP', VS_strCodEmp);
      qryComand.ParamByName('PRE_SEQGER').AsString := recNotEle.strAutInc;
      qryComand.ParamByName('PRE_VEIOBO').AsString := IIF(chkVeiobo.Checked, 'S', 'N');
      qryComand.ParamByName('PRE_DEPOSI').AsString := IIF(chkDeposi.Checked, 'S', 'N');
      qryComand.ParamByName('PRE_PGOANT').AsString := IIF(chkPgoAnt.Checked, 'S', 'N');
      qryComand.ParamByName('PRE_BCOFOR').AsString := strBcoFor;
      qryComand.ParamByName('PRE_CNDPAG').AsString := mskCndPag.Text;
      qryComand.ParamByName('PRE_HISCTA').AsString := mmoHisCta.Text;
      qryComand.ParamByName('PRE_COMPET').AsString := mskCompet.Text;
      qryComand.ParamByName('PRE_CODEVE').AsString := fraCentroCusto.edtCodEve.Text;
      qryComand.ParamByName('PRE_CODCTA').AsString := fraPlanoDeContas.MskCodCta.Text;
      qryComand.ParamByName('PRE_CODPOR').AsString := edtCodPor.Text;

      If objVendor.blnGravar Then
      Begin
        qryComand.ParamByName('PRE_CODFOR').AsString := objVendor.strCodFor;
        qryComand.ParamByName('PRE_VENCTA').AsString := objVendor.strCodCta;
        qryComand.ParamByName('PRE_VENPAG').AsString := objVendor.strCndPag;
        qryComand.ParamByName('PRE_VALVEN').AsFloat  := objVendor.fltValVen;
      End;


      qryComand.ExecSQL;

      pGravaPRECND(recNotEle.strAutInc, arrDuplicata^);

      pGravaPREDES(cdsCtpDet);

    Finally
      FreeAndNil(qryComand);
    End;
  Except
    on e:Exception do
    begin
      pMensagensErro(e.message,'[fGravaPreCtp]' );
      Result := False;

    End;
  End;

end;

procedure TfrmEntDadosFiscaisResumo.pCarregaModFis(strChave: String = '');
  Var
    strModChave: String;
    i: Integer;
    objStrings: TStrings;
Begin
  cbxCodMod.Clear;
  cbxCodMod.Enabled := True;
  objStrings := cbxCodMod.Items;
  fRetornaDadosModFis(strChave, objStrings);
  If cbxCodMod.Items.Count = 1 Then
  Begin
    cbxCodMod.Enabled   := False;
    cbxCodMod.ItemIndex := 0;
  End
  Else If (Not fEmptyStr(strChave)) Then
  begin
    strModChave := Copy(strChave,  21, 2);
    i := cbxCodMod.Items.IndexOfName(strModChave);
    cbxCodMod.ItemIndex := i;
  end;
End;

procedure TfrmEntDadosFiscaisResumo.btnConfDigitacaoClick(Sender: TObject);
  Var
    frmRelEstDigitacaoNotaEntrada: TfrmRelEstDigitacaoNotaEntrada;
begin
  inherited;
  If Not btnConfDigitacao.Visible Then
    Exit;

  Try
    pCriarFormularios(TfrmRelEstDigitacaoNotaEntrada, frmRelEstDigitacaoNotaEntrada);
    frmRelEstDigitacaoNotaEntrada.pImprimeRelatorio(oleItensPedidos);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmEntDadosFiscaisResumo.btnConfDigitacaoClick]');
    End;
  End;

  pFreeAndNil(frmRelEstDigitacaoNotaEntrada);

end;

procedure TfrmEntDadosFiscaisResumo.btnGnreSTClick(Sender: TObject);
begin
  inherited;

  objGnreST.pTelaGnre(Not fEmptyStr(recNotEle.strAutInc), fCfgSis('FORGNE'));
  objGnreST.fAtualizaValorGnre;
end;

procedure TfrmEntDadosFiscaisResumo.btnGnreTributClick(Sender: TObject);
begin
  inherited;
  objGnreTributado.pTelaGnre(Not fEmptyStr(recNotEle.strAutInc), fCfgSis('FORGNE'));
  objGnreTributado.fAtualizaValorGnre;
end;

procedure TfrmEntDadosFiscaisResumo.pImprimeEtiqueta;
Begin
  TfrmEntEtiquetas.pImpEtiEntradaMercadorias(strNumDoc, strEspDoc, strCodFor, strSerie);
End;

procedure TfrmEntDadosFiscaisResumo.pImprimeLiberacaoArmazenamento;
  Var
    frmQckLiberacaoArmazenamento: TfrmQckLiberacaoArmazenamento;
begin
  pCriarFormularios(TfrmQckLiberacaoArmazenamento, frmQckLiberacaoArmazenamento);
  frmQckLiberacaoArmazenamento.pImprimir(strNumDoc, strEspDoc, strSerie, strCodFor, VS_strCodEmp ,'frmEntMercadorias_LIBARM', '', IIf(blnDevolu, 'C', 'F'), oriLibEntradaDadosFiscaisResumo);
  FreeAndNil(frmQckLiberacaoArmazenamento);
end;

procedure TfrmEntDadosFiscaisResumo.pRefazCondPagamento;
  Var
    intContador : Integer;
    arrDatas    : TDateArray;
    strCndPag   : String;
begin
  intContador := 0;
  {*****************************************}
  {* REFAZ A CONDIÇÃO DE PAGAMENTO         *}
  {**************************************MV*}
  While (ArrDuplicata[intContador].dtaDtaVen <> '') And
        (intContador <= 23)                         Do
  Begin

    SetLength(arrDatas, intContador+1);
    arrDatas[intContador] := StrToDate(ArrDuplicata[intContador].dtaDtaVen);
    Inc(intContador);

  End;

  strCndPag      := fRetornaCndPag(arrDatas, dtaDtaDoc);
  mskCndPag.Text := strCndPag;
  strCndAnt      := mskCndPag.Text;
end;

procedure TfrmEntDadosFiscaisResumo.pRetiraDadosParaContasAPagar;
begin
  pnlContasPagar.Enabled := False;
  pnlContasPagar.Visible := False;

  Self.ClientHeight := Self.ClientHeight - 80;
  Self.Height       := Self.Height - 80;

  pSetFocus(btnConfirma);
end;

procedure TfrmEntDadosFiscaisResumo.btnDesmembraValoresClick(
  Sender: TObject);
  Var
    frmDesmembrValores : TfrmDesmembrValores;
    fltValorRestante: Double;

  procedure pCarregaDadosTmpCtpDet;
  begin
    If Assigned(cdsCtpDet) Then
    Begin
      If Not cdsCtpDet.Active Then
        cdsCtpDet.Open;
    End;
  end;
begin
  inherited;

  If (Not btnDesmembraValores.Visible) Or (Not btnDesmembraValores.Enabled) Then
    Exit;

  Try

    fltValorRestante := fStrToFloat(edtVlrCon.Text);

    If (chkPgoAnt.Checked) And (fTemAntecipadoValorMenor) Then
    Begin
      fltValorRestante := fFormataFloat(fltValorRestante - objPgoAnt.fltTotSel, 2);
    End;

    pCarregaDadosTmpCtpDet;

    pCriarFormularios(TfrmDesmembrValores, frmDesmembrValores);

    frmDesmembrValores.DatasetCtpDet  := cdsCtpDet;
    frmDesmembrValores.strNumDup  := '';
    frmDesmembrValores.strParcel  := '';
    frmDesmembrValores.strSerie   := '';
    frmDesmembrValores.strCodEmp  := '';
    If (fCfgSis('USACTF', varBoolean)) Then
      frmDesmembrValores.strCodFor  := strCodFor
    Else
      frmDesmembrValores.strCodFor  := '';
    frmDesmembrValores.fltValTot  := fltValorRestante;
    frmDesmembrValores.blnEntMer  := True;

    frmDesmembrValores.blnBaixada := blnNotaImp;
    frmDesmembrValores.FValidaCorrespondenteContabil := Self.FValidaCorrespondenteContabil;

    frmDesmembrValores.showModal;
    blnDesmebrado := False;
    strCadPagDesmembramento := '';

    If Not cdsCtpDet.IsEmpty Then
    Begin

      fraPlanoDeContas.MskCodCta.Enabled := False;

      If fEmptyStr(frmDesmembrValores.strCodCta) Then
        fraPlanoDeContas.MskCodCta.Text    := fCfgSis('CTAPRI')
      Else
        fraPlanoDeContas.MskCodCta.Text    := frmDesmembrValores.strCodCta;
      strCadPagDesmembramento := fraPlanoDeContas.MskCodCta.Text;
      pCarregaCentroCusto;

      SelectNext(fraPlanoDeContas.MskCodCta, True, True);
      blnDesmebrado := True;

    End
    Else
    Begin
      fraPlanoDeContas.MskCodCta.Enabled := Not blnNotaImp;

      pSetFocus(fraPlanoDeContas.MskCodCta);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmCadCtaPagar.btnDesmembrClick]');
    End;
  End;
  pFreeAndNil(frmDesmembrValores);

end;

procedure TfrmEntDadosFiscaisResumo.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;

Begin
  If (Key = '/') Or (Key = '?') Then
  Begin
    If (Not fCfgSis('USACTF', varBoolean)) Or (blnDevolu) Or (blnConEqu) or (blnRecCliGarantia) Then
    Begin
      If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
      Begin
        If (fValidaCampos(fraPlanoDeContas.MskCodCta, True)) Then
          Self.SelectNext(ActiveControl, True, True);
        pCarregaCentroCusto;
      End;
    End
    Else
    Begin
      If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto, True, True, strCodFor) Then
      Begin
        If (fValidaCampos(fraPlanoDeContas.MskCodCta, True)) Then
          Self.SelectNext(ActiveControl, True, True);
        pCarregaCentroCusto;
      End;
    End;
  End;

end;

function TfrmEntDadosFiscaisResumo.fPedirSenhaOperador: Boolean;
begin
  Result := True;
  if (strEspDoc = 'NF') AND blnRecCliGarantia then
     Result := FblnSolicitarSenhaOpeEntradaGarantia;
end;

Function TfrmEntDadosFiscaisResumo.fSQLImpostosImportacao: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   SUM(O14_VIPI)    AS VALIPI,' ;
  strSQL := strSQL + '   SUM(N17_VICMS)   AS VALICM, ';
  strSQL := strSQL + '   SUM(DET_VALIMP)  AS VALIMP, ';
  strSQL := strSQL + '   SUM(DET_VALSIS)  AS VALSIS, ';
  strSQL := strSQL + '   SUM(I23B_VAFRMM) AS VAFRMM,  ';
  strSQL := strSQL + '   SUM(Q09_VPIS) AS ENT_VALPIS,     ';
  strSQL := strSQL + '   SUM(S11_VCOFINS) AS ENT_VALCOF,     ';
  strSQL := strSQL + '   SUM(I17A_VOUTRO) AS ENT_DESACE ';
  strSQL := strSQL + ' FROM DETELE ';
  strSQL := strSQL + ' WHERE DET_SEQGER = ' + QuotedStr(recNotEle.strAutInc);

  Result := strSQL;
End;

procedure TfrmEntDadosFiscaisResumo.pDesmembraCTPImportacao;
  Var
    qryDetEle: TUniQuery;
    fltValTot: Double;

  Procedure pInsereRateio(strCodCta: String; fltValRat: Double);
  Begin
    With cdsCtpDet Do
    Begin
      Insert;
      FieldByName('CTP_MARDES').AsString := 'D';
      FieldByName('CTP_CODEMP').AsString := VS_strCodEmp;
      FieldByName('CTP_CODCTA').AsString := strCodCta;
      FieldByName('CTA_DESCTA').AsString := fRetNomeConta(strCodCta);
      cdsCtpDet.FieldByName('CTP_VALDUP').AsFloat  := fltValRat;
      Post;

      fltValTot := fltValTot + fltValRat;
    End;
  End;

Begin
  If Not Assigned(cdsCtpDet) Then
    Exit;

  If (fEmptyStr(fraPlanoDeContas.MskCodCta.Text)) Then
    fraPlanoDeContas.MskCodCta.Text := fCfgSis('CTAPRI');

  fraPlanoDeContas.MskCodCta.Enabled := False;
  pCarregaCentroCusto;

  fltValTot := 0;

  qryDetEle := fCriaQuery;
  qryDetEle.SQL.Text := fSQLImpostosImportacao;

  With cdsCtpDet Do
  Begin
    If Not Active Then
      Open;

    EmptyDataSet;

    qryDetEle.Open;

    pInsereRateio(fCfgSis('CCPROD'), fltTotIte + qryDetEle.FieldByName('ENT_DESACE').AsFloat);
    pInsereRateio(fCfgSis('CCVIPI'), qryDetEle.FieldByName('VALIPI').AsFloat);
    pInsereRateio(fCfgSis('CCVPIS'), qryDetEle.FieldByName('ENT_VALPIS').AsFloat);
    pInsereRateio(fCfgSis('CCVCOF'), qryDetEle.FieldByName('ENT_VALCOF').AsFloat);

    pInsereRateio(fCfgSis('CCIMPO'), qryDetEle.FieldByName('VALIMP').AsFloat);
    pInsereRateio(fCfgSis('CCSICO'), qryDetEle.FieldByName('VALSIS').AsFloat);
    pInsereRateio(fCfgSis('CCAFRM'), qryDetEle.FieldByName('VAFRMM').AsFloat);
    pInsereRateio(fCfgSis('CCICMS'), qryDetEle.FieldByName('VALICM').AsFloat);

    First;
    If fltValTot > 0 Then
    While Not Eof Do
    Begin
      Edit;
      cdsCtpDet.FieldByName('CTP_FATCAL').AsFloat := cdsCtpDet.FieldByName('CTP_VALDUP').AsFloat / fltValTot;
      Post;
      Next;
    End;

  End;

  FreeAndNil(qryDetEle);
End;

Function TfrmEntDadosFiscaisResumo.fGravaAgendamentoDeRecebimento(strAutIncMovger: String) : Boolean;
  Var
    qryInsert : TUniQuery;
    strIncAge : String;
    strIdeDig : String;
Begin
  If (recNotEle.finalidadeXML = xmlDevolucaoEntradaEmitidaFornecedor) Then
    Exit(True);

  If strMatRev = 'M' then
    Exit(True);

  If Not fEmptyStr(edtCodEmpresa.Text) Then
    Exit(True);

  If fApenasClaRet(strNumDoc, strEspDoc, strSerie, strCodFor, VS_strCodEmp) Then
    Exit(True);

  If not fGeraAgendamento(strAutIncMovger) Then
    Exit(True);

  Result := True;
  strIncAge := '';

  qryInsert := fCriaQuery;
  Try
    qryInsert.Close;
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add(' INSERT INTO AGEREC ( ');
    qryInsert.SQL.Add('      ARC_CODIGO,     ');
    qryInsert.SQL.Add('      ARC_CODTRA,     ');
    qryInsert.SQL.Add('      ARC_DTAENT,     ');
    qryInsert.SQL.Add('      ARC_STATUS,     ');
    qryInsert.SQL.Add('      AUTOINCREM,     ');
    qryInsert.SQL.Add('      ARC_CODEMP,     ');
    qryInsert.SQL.Add('      ARC_DTAREC,     ');
    qryInsert.SQL.Add('      ARC_HRAREC,     ');
    qryInsert.SQL.Add('      ARC_OPEREC,     ');
    qryInsert.SQL.Add('      ARC_IDEDIG,     ');
    qryInsert.SQL.Add('      ARC_NOMMOT,     ');
    qryInsert.SQL.Add('      ARC_PLACA_,     ');
    qryInsert.SQL.Add('      ARC_IDENTI,     ');
    qryInsert.SQL.Add('      ARC_MOVEFE)     ');
    qryInsert.SQL.Add(' VALUES (:CODIGO,     ');
    qryInsert.SQL.Add('         :CODTRA,     ');
    qryInsert.SQL.Add('         :DTAENT,     ');
    qryInsert.SQL.Add('         :STATUS,     ');
    qryInsert.SQL.Add('         :INCREM,     ');
    qryInsert.SQL.Add('         :CODEMP,     ');
    qryInsert.SQL.Add('         :DTAREC,     ');
    qryInsert.SQL.Add('         :HRAREC,     ');
    qryInsert.SQL.Add('         :OPEREC,     ');
    qryInsert.SQL.Add('         :IDEDIG,     ');
    qryInsert.SQL.Add('         :NOMMOT,     ');
    qryInsert.SQL.Add('         :PLACA_,     ');
    qryInsert.SQL.Add('         :IDENTI,     ');
    qryInsert.SQL.Add('         :MOVEFE)     ');

    strIncAge := fRetAutoIncrem('AGEREC', VS_strCodEmp);
    strIdeDig := fAtualizaProCod('DIGELE', 'ARC_IDEDIG', 'AGEREC');

    qryInsert.ParamByName('INCREM').AsString := strIncAge;
    qryInsert.ParamByName('CODIGO').AsString := fAtualizaProCod('AGEREC', 'ARC_CODIGO');
    qryInsert.ParamByName('CODTRA').AsString := fCfgSis('TRASUG', varString);
    qryInsert.ParamByName('DTAENT').AsDateTime := fNow();
    qryInsert.ParamByName('DTAREC').AsDateTime := fNow();
    qryInsert.ParamByName('HRAREC').AsDateTime := fNow();
    qryInsert.ParamByName('STATUS').AsString := 'EC';
    qryInsert.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryInsert.ParamByName('PLACA_').AsString := 'AAA-0000';
    qryInsert.ParamByName('IDENTI').AsString := 'ES: ' + strNumDoc + '-' + strEspDoc;
    qryInsert.ParamByName('MOVEFE').AsString := 'N';
    qryInsert.ParamByName('OPEREC').AsString := strLoginUsuarioLogado;
    qryInsert.ParamByName('IDEDIG').AsString := strIdeDig;
    qryInsert.ParamByName('NOMMOT').AsString := 'ENTRADA DE MERCADORIA';

    Try
      qryInsert.ExecSQL;
    Except
      On E : Exception Do
      Begin

        pMensagensErro(E.Message, 'TfrmEntDadosFiscaisResumo.fGravaAgendamentoDeRecebimento');
        Exit(False);
      End;

    End;



    qryInsert.Close;
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add(' INSERT INTO AGEDOC ( ');
    qryInsert.SQL.Add('         AUTOINCREM,  ');
    qryInsert.SQL.Add('         ADC_SEQGER,  ');
    qryInsert.SQL.Add('         ADC_NUMDOC,  ');
    qryInsert.SQL.Add('         ADC_SERIE_,  ');
    qryInsert.SQL.Add('         ADC_CODFOR,  ');
    qryInsert.SQL.Add('         ADC_ESPDOC,  ');
    qryInsert.SQL.Add('         ADC_TIPINC,  ');
    qryInsert.SQL.Add('         ADC_CODEMP,  ');
    qryInsert.SQL.Add('         ADC_ACESSO)  ');
    qryInsert.SQL.Add(' VALUES (:AUTINC,     ');
    qryInsert.SQL.Add('         :SEQGER,     ');
    qryInsert.SQL.Add('         :NUMDOC,     ');
    qryInsert.SQL.Add('         :SERIE_,     ');
    qryInsert.SQL.Add('         :CODFOR,     ');
    qryInsert.SQL.Add('         :ESPDOC,     ');
    qryInsert.SQL.Add('         :TIPINC,     ');
    qryInsert.SQL.Add('         :CODEMP,     ');
    qryInsert.SQL.Add('         :ACESSO)     ');

    qryInsert.ParamByName('AUTINC').AsString := fRetAutoIncrem('AGEDOC', VS_strCodEmp);
    qryInsert.ParamByName('SEQGER').AsString := strIncAge;

    qryInsert.ParamByName('NUMDOC').AsString := strNumDoc;
    qryInsert.ParamByName('SERIE_').AsString := strSerie;
    qryInsert.ParamByName('CODFOR').AsString := strCodFor;
    qryInsert.ParamByName('ESPDOC').AsString := strEspDoc;
    qryInsert.ParamByName('TIPINC').AsString := 'M';
    qryInsert.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryInsert.ParamByName('ACESSO').AsString := edtChaNFE.Text;

    Try
      qryInsert.ExecSQL;
    Except
      On E : Exception Do
      Begin

        pMensagensErro(E.Message, 'TfrmRecTransfEstoque.fGravaAgendamentoDeRecebimento');
        Exit(False);
      End;

    End;
  Finally
    FreeAndNil(qryInsert);
  End;

End;



{function TfrmEntDadosFiscaisResumo.fHaVinculosx922_x117: Boolean;

  function fSQLGetAutIncPedele: String;
  begin
    Result := '';
    Result := Result + ' ( SELECT                      ';
    Result := Result + '    P.AUTOINCREM               ';
    Result := Result + '   FROM                        ';
    Result := Result + '    PEDELE P                   ';
    Result := Result + '   INNER JOIN                  ';
    Result := Result + '    GERELE G ON                ';
    Result := Result + '   G.AUTOINCREM = P.PEL_SEQELE ';
    Result := Result + '   WHERE                       ';
    Result := Result + '    G.B08_NNF    = :DOC AND    ';
    Result := Result + '    G.GER_CODEMP = :EMP 	   ';
	Result := Result + '   LIMIT 1)				       ';

  end;

var
  qryAux: TUniQuery;
  blnTemMOVDET, blnTemPNENFU: Boolean;
begin
  Try
    qryAux := fCriaQuery;
    Try
      // MOVDET
      qryAux.SQL.Add('    SELECT                 ');
      qryAux.SQL.Add('     COUNT(1) AS COUNT     ');
      qryAux.SQL.Add('    FROM                   ');
      qryAux.SQL.Add('     MOVDET                ');
      qryAux.SQL.Add('    WHERE                  ');
      qryAux.SQL.Add('     DET_QTDEFT > 0 AND    ');
      qryAux.SQL.Add('     AUTOINCREM = :AUTINC  ');

      qryAux.ParamByName('AUTINC').AsString := recNotEle.strAutInc;
      qryAux.Open;

      blnTemMOVDET := qryAux.FieldByName('COUNT').AsInteger > 0;

      // PNENFU
      qryAux.Close;
      qryAux.SQL.Clear;

      qryAux.SQL.Add('    SELECT                 ');
      qryAux.SQL.Add('     COUNT(1) AS COUNT     ');
      qryAux.SQL.Add('    FROM                   ');
      qryAux.SQL.Add('     PNENFU                ');
      qryAux.SQL.Add('    WHERE                  ');
      qryAux.SQL.Add('     NFE_PREELE =          ');
      qryAux.SQL.Add( fSQLGetAutIncPedele );

      qryAux.ParamByName('EMP').AsString := VS_strCodEmp;
      qryAux.ParamByName('DOC').AsString := recNotEle.strNumDoc;
      qryAux.Open;

      blnTemPNENFU := qryAux.FieldByName('COUNT').AsInteger > 0;

      Result := blnTemMOVDET Or blnTemPNENFU;
    Except On
      E : Exception Do
      Begin
        pMensagensErro(E.Message, 'TfrmEntDadosFiscaisResumo.fHaVinculosx922_x117');
        Exit(False);
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;   }

function TfrmEntDadosFiscaisResumo.fChaveModelo(AValue: String): String;
Begin
  Result := Copy(AValue,23,22);
End;

function TfrmEntDadosFiscaisResumo.fLiberarValorBoleto: Boolean;
Var
  RecParametrosLiberacaoValorBoleto: TRecParametrosLiberacaoValorBoleto;
Begin
  pCalculaValorDocumento;
  RecParametrosLiberacaoValorBoleto.Create(strNumDoc, strSerie);
  RecParametrosLiberacaoValorBoleto.strCodFor := strCodFor;
  if blnDevolu then
    RecParametrosLiberacaoValorBoleto.strNomFor := fRetNomCliente(RecParametrosLiberacaoValorBoleto.strCodFor)
  else
    RecParametrosLiberacaoValorBoleto.strNomFor := fRetNomFornecedor(recNotEle.strCodFor);

  RecParametrosLiberacaoValorBoleto.strCodOpe := edtCodOpe.Text;
  RecParametrosLiberacaoValorBoleto.strCodDig := edtCodDig.Text;

  If Assigned(frmEntRetencaoNotaServico) Then
    RecParametrosLiberacaoValorBoleto.fltValorRetencoes := frmEntRetencaoNotaServico.fraCadImpostosNFS.fRetTotalImpostos;

  RecParametrosLiberacaoValorBoleto.blnAcessoViaPreNota := FblnAcessadoViaPrenota;
  If Not FblnAcessadoViaPrenota Then
  begin
    RecParametrosLiberacaoValorBoleto.fltValorContabil := dtsCadFis.DataSet.FieldByName('FIS_VLCONT').AsCurrency;
    RecParametrosLiberacaoValorBoleto.fltValorDocumento := dtsCadFis.DataSet.FieldByName('FIS_VLCONT').AsCurrency;
  end
  else
    RecParametrosLiberacaoValorBoleto.fltValorDocumento := fltValorDocumento;

  RecParametrosLiberacaoValorBoleto.fltTotAdiantamento := objPgoAnt.fltTotUso;
  RecParametrosLiberacaoValorBoleto.arrDuplicata := ArrDuplicata;

  RecParametrosLiberacaoValorBoleto.fltBonificacao := fltBonificacao;


  Result := TLiberacaoValorBoleto.fLiberarValorBoleto(RecParametrosLiberacaoValorBoleto);
End;


procedure TfrmEntDadosFiscaisResumo.mskCndPagKeyPress(Sender: TObject;
  var Key: Char);
var
  arrCnd: TConsultasArray;
  qryPesquisa: TUniQuery;
begin
  inherited;
  If blnDevolu then
    If CondicaoPagamentoCliente.intQtdCndPag > 1 Then
      If mskCndPag.Enabled  Then
      Begin
        qryPesquisa := fCriaQuery;
        Try
          If fPesqCondicoesPgto(Self, nil, nil, qryPesquisa, Key, arrCnd, True, False,
                                IIF(fCfgSis('PFLCLI', varBoolean), conCndPerfil, conCndSimples),
                                0, 0, strCodFor, True) Then
          Begin
            CondicaoPagamentoCliente.pCarregaDados(strCodFor, qryPesquisa.FieldByName('CND_CNDPAG').AsString);
            If CondicaoPagamentoCliente.intQtdCndPag > 0 Then
            Begin
              edtCodPor.Text := CondicaoPagamentoCliente.strCodPor;
              fValidaCampos(edtCodPor);
              mskCndPag.Text := CondicaoPagamentoCliente.strCNDPAG;
            End;
          End;
        Finally
          FreeAndNil(qryPesquisa)
        End;
      End;
end;

{function TfrmEntDadosFiscaisResumo.fTotalDuplicatas: Currency;
Var
   qryDupEle: TUniQuery;
Begin
  qryDupEle := fCriarQuery('SELECT SUM(DUP_VALDUP) AS VALDUP FROM DUPELE WHERE DUP_SEQELE = ''' +
    recNotEle.strAutInc + ''' ORDER BY AUTOINCREM', Nil);
  Try
    qryDupEle.Open;
    Result := qryDupEle.FieldByName('VALDUP').AsCurrency;
  Finally
    FreeAndNil(qryDupEle);
  End;
End;}


function TfrmEntDadosFiscaisResumo.fRetornaExistePedidoCompraPagoCartaoCredito(stlPedidos: TStringList): Boolean;
Var
  qryAux: TUniQuery;
  intContador, intTamPed: Integer;
begin
  qryAux := fCriaQuery(nil);
  Result := False;

  intTamPed := fTamNumPedCom;

  Try
    If fEmptyStr(stlPedidos.Text) and fTabelaExiste('TMP_ENTMER') Then
    Begin
      qryAux.SQL.Add('SELECT PCG_PAGCCC ');
      qryAux.SQL.Add('  FROM TMP_ENTMER');
      qryAux.SQL.Add(' INNER JOIN PCMDET PDI ON PDI.AUTOINCREM = ENT_SEQPCD');
      qryAux.SQL.Add(' INNER JOIN PCMGER ON');
      qryAux.SQL.Add('       PCG_NUMPED = PCD_NUMPED');
      qryAux.SQL.Add('   AND PCG_CODEMP = PCD_CODEMP');
      qryAux.SQL.Add('   AND PCG_ESPDOC = PCD_ESPDOC');
      qryAux.SQL.Add('   AND PCG_NUMCTN = PCD_NUMCTN');
      qryAux.SQL.Add(' WHERE PCG_PAGCCC = True ');
      qryAux.Open;

      if Not qryAux.IsEmpty then
        Exit(True)
    End
    Else
    begin
      For intContador := 0 To Pred(stlPedidos.Count) Do
      begin
        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add('SELECT 1 FROM PCMGER WHERE ');
        qryAux.SQL.Add('PCG_NUMPED = :NUMPED');
        qryAux.SQL.Add(' AND PCG_CODEMP = :CODEMP');
        qryAux.SQL.Add(' AND PCG_PAGCCC = True');

        qryAux.ParamByName('NUMPED').AsString := LeftStr(stlPedidos[intContador], intTamPed);
        qryAux.ParamByName('CODEMP').AsString := RightStr(stlPedidos[intContador], 3);
        qryAux.Open;

        if Not qryAux.IsEmpty then
          Exit(True)
      end;
    end;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmEntDadosFiscaisResumo.pGetMsgItensAtivoImobilizado(var strMsg: String; var strItens: String; strNumDoc, strEspDoc, strSerie, strCodFor: String);
var
 strCfopImo,
 strCodIte: String;
 qryCons: TUniQuery;
begin
  qryCons := fCriaQuery;
  strCfopImo := fTransform(fCfgSis('CFOIMO'), 3);
  strCodIte := '';
  Try
    qryCons.SQL.Clear;
    qryCons.SQL.Add(' SELECT SQL_NO_CACHE                                ');
    qryCons.SQL.Add('  DISTINCT IF(M.AUTOINCREM IS NULL AND I.ITE_TIPPRO = "08","S","N") AS PODE_INCLUIR ');
    qryCons.SQL.Add('  FROM ITEGER I                                     ');
    qryCons.SQL.Add('  LEFT JOIN CADIMO M ON M.IMO_CODITE = I.ITE_CODITE ');
    qryCons.SQL.Add('                    AND M.IMO_CODEMP = I.ITE_CODEMP ');
    qryCons.SQL.Add('                    AND M.IMO_DOCAQU = :DOCAQU      ');
    qryCons.SQL.Add('                    AND M.IMO_SERAQU = :SERAQU      ');
    qryCons.SQL.Add('                    AND M.IMO_FORAQU = :FORAQU      ');
    qryCons.SQL.Add('                    AND M.IMO_ESPAQU = :ESPAQU      ');
    qryCons.SQL.Add('  WHERE TRUE                                        ');
    qryCons.SQL.Add('    AND I.ITE_CODITE = :CODITE                      ');
    qryCons.SQL.Add('    AND I.ITE_CODEMP = :CODEMP                      ');
    qryEntMer.DisableControls;
    qryEntMer.First;
    While Not qryEntMer.Eof Do
    Begin
      If Pos(Copy(qryEntMer.FieldByName('ENT_CLAFIS').AsString,2,3), strCfopImo) > 0 Then
      Begin
        qryCons.ParamByName('CODITE').AsString := qryEntMer.FieldByName('ENT_CODITE').AsString;
        qryCons.ParamByName('CODEMP').AsString := VS_StrCodEmp;
        qryCons.ParamByName('DOCAQU').AsString := strNumDoc;
        qryCons.ParamByName('SERAQU').AsString := strSerie;
        qryCons.ParamByName('FORAQU').AsString := strCodFor;
        qryCons.ParamByName('ESPAQU').AsString := strEspDoc;
        qryCons.Open;
        If qryCons.FieldByName('PODE_INCLUIR').AsString = 'S' Then
        Begin
          strItens := strItens + qryEntMer.FieldByName('ENT_CODITE').AsString + '-' + qryEntMer.FieldByName('ENT_DESITE').AsString+#13#10;
          strCodIte := strCodIte + QuotedStr(qryEntMer.FieldByName('ENT_CODITE').AsString) + ',';
        End;
      End;
      qryEntMer.Next;
    End;
    If fEmptyStr(strItens) Then
    Begin
      strMsg := '';
      Exit;
    End;
    strMsg := 'Os produtos abaixo são do tipo Imobilizado/Patrimônio:' + #13#10;
    strMsg := strMsg + strItens + #13#10;
    strMsg := strMsg + 'Deseja cadastrá-los automaticamente no cadastro de Imobilizado/Patrimônio?';
    strItens := Copy(strCodIte,0, Length(strCodIte)-1);
  Finally
    qryEntMer.EnableControls;
    FreeAndNil(qryCons);
  End;
end;

function TfrmEntDadosFiscaisResumo.fCadastroAutomaticoAtivosImobilizados(var strItensCadastrados: String; strItensASeremFiltrados, strNumDoc, strEspDoc, strSerie, strCodFor, strCndPag: String; dtaDtaEnt: TDateTime): Boolean;
var
 strCfopImo,
 strCodIns: String;
 qryAux,
 qryIns: TUniQuery;
begin
  If fEmptyStr(strItensASeremFiltrados) Then
    Exit(True);

  strCfopImo := fTransform(fCfgSis('CFOIMO'), 3);
  qryAux := fCriaQuery;
  qryIns := fCriaQuery;
  Result := True;
  strItensCadastrados := '';
  Try
    Try
      qryIns.SQL.Clear;
      qryIns.SQL.Add('INSERT INTO CADIMO (AUTOINCREM, ');
      qryIns.SQL.Add('                    IMO_CODIMO, ');
      qryIns.SQL.Add('                    IMO_DESCRI, ');
      qryIns.SQL.Add('                    IMO_CODEMP, ');
      qryIns.SQL.Add('                    IMO_DTAAQU, ');
      qryIns.SQL.Add('                    IMO_DOCAQU, ');
      qryIns.SQL.Add('                    IMO_SERAQU, ');
      qryIns.SQL.Add('                    IMO_FORAQU, ');
      qryIns.SQL.Add('                    IMO_ESPAQU, ');
      qryIns.SQL.Add('                    IMO_CODITE, ');
      qryIns.SQL.Add('                    IMO_QTDIMO, ');
      qryIns.SQL.Add('                    IMO_VALAQU, ');
      qryIns.SQL.Add('                    IMO_TOTAQU, ');
      qryIns.SQL.Add('                    IMO_VALICM, ');
      qryIns.SQL.Add('                    IMO_QTDPAR, ');
      qryIns.SQL.Add('                    IMO_DIFALI )');
      qryIns.SQL.Add('             VALUES(:AUTINC,    ');
      qryIns.SQL.Add('                   :IMO_CODIMO, ');
      qryIns.SQL.Add('                   :IMO_DESCRI, ');
      qryIns.SQL.Add('                   :IMO_CODEMP, ');
      qryIns.SQL.Add('                   :IMO_DTAAQU, ');
      qryIns.SQL.Add('                   :IMO_DOCAQU, ');
      qryIns.SQL.Add('                   :IMO_SERAQU, ');
      qryIns.SQL.Add('                   :IMO_FORAQU, ');
      qryIns.SQL.Add('                   :IMO_ESPAQU, ');
      qryIns.SQL.Add('                   :IMO_CODITE, ');
      qryIns.SQL.Add('                   :IMO_QTDIMO, ');
      qryIns.SQL.Add('                   :IMO_VALAQU, ');
      qryIns.SQL.Add('                   :IMO_TOTAQU, ');
      qryIns.SQL.Add('                   :IMO_VALICM, ');
      qryIns.SQL.Add('                   :IMO_QTDPAR, ');
      qryIns.SQL.Add('                   :IMO_DIFALI )');

      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT SQL_NO_CACHE * FROM TMP_ENTMER WHERE ENT_CODITE IN (' + strItensASeremFiltrados+')');
      qryAux.Open;
      qryAux.First;

      fStartTransaction;

      While Not qryAux.Eof Do
      Begin
        strCodIns := fAtualizaProCod('CADIMO', 'IMO_CODIMO');
        qryIns.ParamByName('AUTINC').AsString := fRetAutoIncrem('CADIMO', VS_StrCodEmp);
        qryIns.ParamByName('IMO_CODIMO').AsString := strCodIns;
        qryIns.ParamByName('IMO_DESCRI').AsString := qryAux.FieldByName('ENT_DESITE').AsString;
        qryIns.ParamByName('IMO_CODEMP').AsString := IIf(fEmptyStr(qryAux.FieldByName('ENT_CODEMP').AsString),VS_strCodEmp,qryAux.FieldByName('ENT_CODEMP').AsString);
        qryIns.ParamByName('IMO_DTAAQU').AsDateTime := dtaDtaEnt;
        qryIns.ParamByName('IMO_DOCAQU').AsString := strNumDoc;
        qryIns.ParamByName('IMO_SERAQU').AsString := strSerie;
        qryIns.ParamByName('IMO_FORAQU').AsString := strCodFor;
        qryIns.ParamByName('IMO_ESPAQU').AsString := strEspDoc;
        qryIns.ParamByName('IMO_CODITE').AsString := qryAux.FieldByName('ENT_CODITE').AsString;
        qryIns.ParamByName('IMO_QTDIMO').AsFloat := qryAux.FieldByName('ENT_QTDITE').AsFloat;
        qryIns.ParamByName('IMO_VALAQU').AsFloat := qryAux.FieldByName('ENT_UNITAR').AsFloat;
        qryIns.ParamByName('IMO_TOTAQU').AsFloat := qryAux.FieldByName('ENT_TOTITE').AsFloat;
        qryIns.ParamByName('IMO_VALICM').AsFloat := qryAux.FieldByName('ENT_VALICM').AsFloat;
        qryIns.ParamByName('IMO_QTDPAR').AsInteger := StrToIntDef(Copy(strCndPag,0,2),1);
        qryIns.ParamByName('IMO_DIFALI').AsFloat := 0;
        qryIns.ExecSQL;
        strItensCadastrados := strItensCadastrados + strCodIns + '-' + qryAux.FieldByName('ENT_DESITE').AsString + #13#10;

        qryAux.Next;
      End;

      fCommit;
    Except On
      E:Exception Do
      Begin
        Result := False;
        fRollBack;
        pMensagensErro(E.Message, 'TfrmEntDadosFiscaisResumo.fCadastroAutomaticoAtivosImobilizados');
      End;
    End;
  Finally
    FreeAndNil(qryAux);
    FreeAndNil(qryIns);
  End;
end;

end.

