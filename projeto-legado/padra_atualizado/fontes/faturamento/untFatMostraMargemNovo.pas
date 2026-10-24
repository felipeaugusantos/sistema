unit untFatMostraMargemNovo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, Vcl.StdCtrls,
  EditFocus, Vcl.ExtCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxClasses,
  cxGridCustomView, cxGrid, cxGridCitel, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons, BitBtnLockedIncrem,
  DBEditFocus, UniClientDataSet, Uni, untTypesMargem, cxGridDBTableView, Math,
  untFuncFatTypes, System.Generics.Collections, untFuncoesSimples,
  untFuncFat, untITintaDeMaquina, untTintaDeMaquinaComponenteTipo, untGravando, untFatMostraMargemNovoController,
  untIFatMostraMargemNovo, cxProgressBar, cxTextEdit, cxCheckBox, cxCurrencyEdit,
  cxEditRepositoryItems, DateUtils, untLiberacao;

type
  TfrmFatMostraMargemNovo = class(TfrmPaiSimples)
    cxgItens: TcxGridCitel;
    cxgItensView: TcxGridDBBandedTableView;
    cxgItensITE_CODITE: TcxGridDBBandedColumn;
    cxgItensITE_DESITE: TcxGridDBBandedColumn;
    cxgItensITE_SIGUNI: TcxGridDBBandedColumn;
    cxgItensITE_UNITAR: TcxGridDBBandedColumn;
    cxgItensITE_UNIDOL: TcxGridDBBandedColumn;
    cxgItensITE_VLCTVN: TcxGridDBBandedColumn;
    cxgItensITE_DTCTVN: TcxGridDBBandedColumn;
    cxgItensITE_CUSITE: TcxGridDBBandedColumn;
    cxgItensITE_MARPRO_CUSITE: TcxGridDBBandedColumn;
    cxgItensITE_MARPRA_CUSITE: TcxGridDBBandedColumn;
    cxgItensITE_DESOPE: TcxGridDBBandedColumn;
    cxgItensITE_IMPFED: TcxGridDBBandedColumn;
    cxgItensITE_ICMSAI: TcxGridDBBandedColumn;
    cxgItensITE_OUTVAL: TcxGridDBBandedColumn;
    cxgItensITE_PRECUS: TcxGridDBBandedColumn;
    cxgItensITE_MARPRO_PRECUS: TcxGridDBBandedColumn;
    cxgItensITE_MRPRBT_PRECUS: TcxGridDBBandedColumn;
    cxgItensITE_MARPRA_PRECUS: TcxGridDBBandedColumn;
    cxgItensITE_PREMED: TcxGridDBBandedColumn;
    cxgItensITE_MARBRU_PREMED: TcxGridDBBandedColumn;
    cxgItensITE_PREULT: TcxGridDBBandedColumn;
    cxgItensITE_MARBRU_PREULT: TcxGridDBBandedColumn;
    cxgItensITE_CUSIMP: TcxGridDBBandedColumn;
    cxgItensITE_MARBRU_IMPULT: TcxGridDBBandedColumn;
    cxgItensITE_QTDITE: TcxGridDBBandedColumn;
    cxgItensITE_SALDOS: TcxGridDBBandedColumn;
    cxgItensITE_PROMOC: TcxGridDBBandedColumn;
    cxgItensITE_MRPRBT_PREMED: TcxGridDBBandedColumn;
    cxgItensITE_MARLIQ_PREMED: TcxGridDBBandedColumn;
    cxgItensITE_MARLIQ_PREULT: TcxGridDBBandedColumn;
    cxgItensITE_MARLIQ_IMPULT: TcxGridDBBandedColumn;
    cxgItensITE_TIPTMQ: TcxGridDBBandedColumn;
    cxgItensAUTOINCREM: TcxGridDBBandedColumn;
    cxgItensITE_UNIORI: TcxGridDBBandedColumn;
    cxgItensITE_IMPULT: TcxGridDBBandedColumn;
    cxgItensITE_MARIDE: TcxGridDBBandedColumn;
    cxgItensITE_PREIDE: TcxGridDBBandedColumn;
    cxgItensITE_MARCAT: TcxGridDBBandedColumn;
    cxgItensITE_PERDES: TcxGridDBBandedColumn;
    cxgItensITE_RESULT: TcxGridDBBandedColumn;
    cxgItensITE_MARMIN: TcxGridDBBandedColumn;
    cxgItensLevel2: TcxGridLevel;
    popGrid: TPopupMenu;
    mnuImprimirF4: TMenuItem;
    pnlAviTot: TPanel;
    Label8: TLabel;
    pnlLegendas: TPanel;
    pnlEditaveis: TPanel;
    Shape1: TShape;
    Label3: TLabel;
    pnlMargemLiquida: TPanel;
    Shape2: TShape;
    Label7: TLabel;
    pnlPromocao: TPanel;
    Shape3: TShape;
    Label5: TLabel;
    pnlSemEstoque: TPanel;
    Shape4: TShape;
    Label4: TLabel;
    pnlMargemBruta: TPanel;
    Shape5: TShape;
    Label6: TLabel;
    pnlTotais: TPanel;
    lblProVen: TLabel;
    edtProVen: TEditFocus;
    gpbUltVen: TGroupBox;
    lbl2: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    edtTotVen: TEditFocus;
    edtQtdVen: TEditFocus;
    edtDtaVen: TEditFocus;
    pnlFrete: TPanel;
    lblFrete: TLabel;
    lblFreSuges: TLabel;
    edtTotFrete: TEditFocus;
    edtFreSuges: TEditFocus;
    chkAcuFreteCobPrecoUni: TCheckBox;
    chkAcuFreteSugPrecoCus: TCheckBox;
    pnlBotoesMarg: TFlowPanel;
    cxgItensITE_VDIFAL: TcxGridDBBandedColumn;
    cxgItensFCP: TcxGridDBBandedColumn;
    cxgItensViewColumn1: TcxGridDBBandedColumn;
    cxgItensITE_DESTIN: TcxGridDBBandedColumn;
    Label9: TLabel;
    edtUnitar: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnMargemSobreItens: TBitBtnLocked;
    btnDesconto: TBitBtnLocked;
    btnCustosMargemTintas: TBitBtnLocked;
    btnTravasMinimas: TBitBtnLocked;
    btnDeseja: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    btnUltCompraEmp: TBitBtnLocked;
    btnVenCli: TBitBtnLocked;
    btnPadrao: TBitBtnLocked;
    btnFechar: TBitBtnLocked;
    cxgItensITE_DESMAR: TcxGridDBBandedColumn;
    cxgItensViewITE_MKPPRO: TcxGridDBBandedColumn;
    cxgItensViewITE_MARPRO: TcxGridDBBandedColumn;
    cxgItensViewITE_ENCPRO: TcxGridDBBandedColumn;
    cxgItensITE_PRETAB: TcxGridDBBandedColumn;
    cxgItensViewITE_MKPPRO2: TcxGridDBBandedColumn;
    cxgItensITE_UNIDIG: TcxGridDBBandedColumn;
    cxgItensITE_TAXJUR: TcxGridDBBandedColumn;
    cxgItensViewSELECIONADO: TcxGridDBBandedColumn;
    cxgItensViewITE_ORDITE: TcxGridDBBandedColumn;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    cxEditRepository: TcxEditRepository;
    cxEditRepositoryValor: TcxEditRepositoryCurrencyItem;
    cxEditRepositoryPercentual: TcxEditRepositoryCurrencyItem;
    lblDesEsp: TLabel;
    edtDesEsp: TEditFocus;
    cxgItensITE_CODFAB: TcxGridDBBandedColumn;
    cxgItensViewITE_DESMAX: TcxGridDBBandedColumn;
    cxgItensViewITE_VLRMIN: TcxGridDBBandedColumn;
    cxgItensViewITE_TOTMIN: TcxGridDBBandedColumn;
    cxgItensGIR_DIAEST: TcxGridDBBandedColumn;
    cxgItensITE_COMISS: TcxGridDBBandedColumn;
    cxgItensITE_TABPRE: TcxGridDBBandedColumn;
    cxgItensITE_TOTITE: TcxGridDBBandedColumn;
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnMargemSobreItensClick(Sender: TObject);
    procedure btnDescontoClick(Sender: TObject);
    procedure btnCustosMargemTintasClick(Sender: TObject);
    procedure btnTravasMinimasClick(Sender: TObject);
    procedure btnUltCompraEmpClick(Sender: TObject);
    procedure btnVenCliClick(Sender: TObject);
    procedure btnDesejaClick(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure mnuImprimirF4Click(Sender: TObject);
    procedure popGridPopup(Sender: TObject);
    procedure cxgItensViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure chkAcuFreteCobPrecoUniClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensViewEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure cxgItensViewEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnPadraoClick(Sender: TObject);
    procedure cxgItensViewColumnHeaderClick(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure cxgItensITE_DESITEPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxgItensViewDataControllerFilterChanged(Sender: TObject);

  private
    { Private declarations }

    itemCalcMar : TItemCalcMargem;

    intCorZeb : Integer;

    oleCopia : OleVariant;

    blnTintaDeMaquina : Boolean;
    blnApenasVisualizacao : Boolean;
    blnSomenteUnitarioAcimaDoSugerido : Boolean;
    blnCanculandoTotal: Boolean;
    blnPermiteEditarPrecoUnitario: Boolean;

    fltPerDes: Double;
    fltMarIte: Double;
    fltTotGerOri : Double;
    fltTotGerAtu : Double;
    blnRecalculandoItens: Boolean;

    fltTotalG: Double;
    fltDesEsp : Double;
    fltDesEspCopia : Double;

    strExMaF4: String;
    strOperador: String;

    mmsLayoutDefault: TMemoryStream;

    cdsDados: TUniClientDataSet;
    cdsItensTinta : TUniClientDataSet;
    cdsComDes: TUniClientDataSet;
    cdsImpressao: TUniClientDataSet;

    dicInfVen : TDictionary<String, TRecInfVen>;
    dicColunasF4 : TDictionary<String, Boolean>;

    recTotMarLuc : TRecTotaisMargemLucro;
    recTotMarLucTotIte : TRecTotaisMargemLucro;
    intDecUni : Integer;

    blnOcultaBotoes: Boolean;
    blnUsouTotalDesejado: Boolean;
    blnMargemLucroAplicaDesconto: Boolean;

    blnUsaUniLiq: Boolean;
    blnPodeEditarPrecoUnitario: Boolean;
    blnPodeAplicarTaxaJurosPrecoDigitado: Boolean;

    objMostraMargemNovoController: IFatMostraMargemNovoController;
    objValidaUnitario: IFatMostraMargemNovoValidaUnitario;
    objAdicionarTinta: IFatMostraMargemNovoAdicionarTinta;
    objBeforePost: IFatMostraMargemNovoBeforePost;
    blnExibiuMensagem: Boolean;
    blnDescontoMajoramento: Boolean;

    procedure pProcessaProdutos;
    procedure pProcessaTinta;
    procedure pProcessaSaldoDisponivel;
    procedure pCalculaResumo;
    procedure pTotalDesejadoVenda;
    function fExibeResumo: Boolean;
    function fCalculaUnitario(fltUniDig, fltUnitar, fltTaxJur: Double; out fltUniLiq: Double): Double;
    function fCalculaUnitarioLiquido(fltUnitar, fltTaxJur: Double): Double;
    function fAplicandoMargemSobreItens(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fDescontoMajoramento(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fDocumentosSelecionados: Integer;
    procedure pDesmarcarTodos;
    procedure pMarcarTodos;
    procedure pSelecionarRegistros(blnMarcar: Boolean);
    procedure pExibirDescontoEspecial(fltDescontoEspecial: Double);
    procedure pCalcularGiroDiasEstoque;
    procedure pProcessaGiroDiasEstoque;
    function fRetornaDiasEstoque(strCodIte: String): Double;
    function fExibeBtnDeseja: Boolean;
    function fExibeBtnMargemSobreItens: Boolean;

    const MSG_ITENS_NAO_DEDUTIVEIS: String = 'Não é possível alterar o valor da ' +
                                             'venda pois os itens inseridos não são dedutiveis!';

    const STR_TEXTO_TOTAL_S_DESC : String  = 'TOTAL S/ DESCONTO';
    const STR_TEXTO_TOTAL_C_DESC : String  = 'TOTAL C/ DESCONTO';
    const BAND_PRODUTOS                          : Integer = 0;  // Produtos
    const BAND_PRECO_VENDA                       : Integer = 1;  // Preço de Venda
    const BAND_PRECO_CUSTO                       : Integer = 2;  // Preço de Custo
    const BAND_PRECO_CUSTO_REAL                  : Integer = 3;  // Preço de Custo Real
    const BAND_PRECO_MEDIO                       : Integer = 4;  // Preço Médio
    const BAND_PRECO_ULTIMA_COMPRA               : Integer = 5;  // Preço de Última Compra
    const BAND_PRECO_ULTIMA_COMPRA_MAIS_IMPOSTOS : Integer = 6;  // Preço de Última Compra Mais Impostos
    const BAND_QUANTIDADE_ESTOQUE                : Integer = 7;  // Quantidade/Estoque
    const BAND_PRECO_IDEAL                       : Integer = 8;  // Preço Ideal
    const BAND_CAT_17                            : Integer = 9;  // CAT17
    const BAND_RESUMO                            : Integer = 10; // RESUMO
    const BAND_MARGEM_PRODUTO                    : Integer = 11; // MARGEM DO CADASTRO DE PRODUTOS
    const BAND_TRAVAS_MINIMAS                    : Integer = 12; // TRAVAS MÍNIMAS

    procedure pAtualizaLiberacaoUnitario(stlAutInc: TStringList);
    function fPegaTotalParaDesconto(blnAplicarRestricoes: Boolean; cdsDestin: TUniClientDataSet): Double;
    procedure pPosicionarRegistroVenda(DataSet: TDataSet);
    procedure pBeforeEdit(DataSet: TDataSet);
    function fRealizandoConfirmacao(blnInclCF: Boolean = True): Boolean;
    function fTemTinta(): Boolean;
    function fTotalDouble(strNomeCampo: String): Double;
    function fUserFunction(const MethodName: string; var Params: Variant): Variant;
    Function fValidaUnitario(DataSet: TDataSet; fltUnitar: Double): Boolean;
    function fItemEntraRateio(strPromocao: String; cdsDestin: TUniClientDataSet): Boolean;
    procedure pIncluirTotais(blnForcarInclusao: Boolean = False);
    procedure pDescontoMajoramento(fltPerVal: Double; tipPorVal: TPorcentagemValor; cdsDestin: TUniClientDataSet; blnUsaPreIni: Boolean = true; blnDiluirQtdeUnica: Boolean = True; pgbStatus: TcxProgressBar = Nil);
    procedure pFormataCamposGrid(DataSet: TDataSet; blnSetText: Boolean); overload;
    procedure pVerificaBotoes(pnlPanel: TFlowPanel; blnHabilita: Boolean);
    procedure pFormataCamposGrid; overload;
    procedure pGerarDicionarioColunas;
    procedure pImprimirF4(DataSet: TDataSet; dicColunas : TDictionary<String, Boolean>; fncUserFunction: TUserFunction; blnTinta: Boolean; stlFunctions: TStringList);

    procedure pBeforePost(DataSet: TDataSet);
    procedure pAfterPost(DataSet: TDataSet);
    procedure pAfterScroll(DataSet: TDataSet);

    function fAplicarDesconto(pgbProgresso: TcxProgressBar): Boolean;
    procedure pProcessarView;
    function fOperadorAcesso: String;
    procedure Sumarizar(const strNomeCampo: String; const summaryKind: TcxSummaryKind; const strFormato: string;
      const blnFooter, blnGroup, blnGroupFooter: Boolean);
    procedure pCriaCdsItens(blnEstruturaDaVenda: Boolean);
    procedure pProcessarTintasDeMaquina;
    procedure pProcessarTela;
    procedure pConfigurarGrid;
    function fGetChaveLayoutGrid: String;
    procedure pAdicionarTinta(const tintaDeMaquina: ITintaDeMaquina);
    procedure pAdicionaItemAvulso;
    function fGetTipoAsString(tmctTipo: TTintaDeMaquinaComponenteTipo): string;
    procedure pOnSetText(Sender: TField; const Text: string);
    procedure pOnGetTextCat(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure pCalcularSaldoDisponivel;
    function fPermiteDesconto: Boolean;
    procedure pVerificaPreTab;
    function fExibeMensagem: Boolean;
    procedure pDesativaColunas;
    procedure pAcumulaFreteAoPreçoDeVenda;
    function fRecebidoPorPix(const AblnMostrMsg: boolean = True): Boolean ;
    function fPemiteEditarDadosF4Margem(const AblnMostrMsg: boolean = True): Boolean ;
    procedure pAdicionaTravasMinimas;
    procedure pPreencherPercentualComissao;
    procedure pProcessaPercentualComissao;
    function fHabilitaBandTravasMinimas: Boolean;
    function fRetornaComissaoTabPreco: Double;
  public
    fltLimCre: Double;
    blnTabPreIte: Boolean;

    cdsItens : TUniClientDataSet;
    dtsItens : TDataSource;
    dtsTotais : TDataSource;
    fatVenda : TFatVenda;
    qryTinta: TUniQuery;
    strCcnAnt: String;
    stlIteLib: TStringList;
    dicInfEmp: TDicionario;

    blnApenasVerificandoMargemComFrete: Boolean;

    fltUnitarAnt  : Double;
    fltUniDigAnt  : Double;
    fltPreCusAnt  : Double;
    fltMarPraCusIteAnt : Double;
    fltMarPraPreCusAnt : Double;

    fltTotMargem : Double;
    fltTotUnitar : Double;
    fltTotUniOri : Double;

    pCalculaMargemLucro: TpCalcularMargemLucro;

    blnVisualizarPorMensagem: Boolean;
    blnConEqu: Boolean;

    procedure pCalcularTotais(cdsOleVariant: OleVariant; objFatVendas: TFatVenda = Nil);

    function fGetDesEsp: Double;

    class function fGetDadosMargem(const fatVenda: TFatVenda;
      const strOperador: String; itemCalcMar: TItemCalcMargem): OleVariant;

    class procedure pIncluirTotaisPublico(cdsItens: TUniClientDataSet; 
                                          blnTintaDeMaquina, 
                                          blnApenasVisualizacao,
                                          blnUsouTotalDesejado: Boolean;
                                          fltDesEsp: Double; 
                                          recTotMarLuc,
                                          recTotMarLucTotIte: TRecTotaisMargemLucro;
                                          blnForcarInclusao: Boolean);  
    class procedure pCalcularTotaisPublico(cdsItens: TUniClientDataSet; objFatVendas: TFatVenda; fltDesEsp: Double);                                       

    procedure pFormShowInterna(Sender: TObject);

    constructor Create(AOwner: TComponent;
                       const fatVenda: TFatVenda;
                       const qryTinta: TUniQuery;
                       const strOperador: String;
                       const blnTabPreIte: Boolean;
                       const fltLimCre: Double;
                       const blnApenasVerificandoMargemComFrete: Boolean;
                       const blnTintaDeMaquina: Boolean;
                       const cdsItensTinta : TUniClientDataSet;
                       const itemCalcMar: TItemCalcMargem = Nil;
                       const fltDesEsp: Double = 0;
                       const strCcnAnt: String = '';
                       const blnFatDigDesconto: Boolean = False;
                       const strName: String = '';
                       const blnUsaUniLiq: Boolean = False;
                       const blnPodeEditarPrecoUnitario: Boolean = False;
                       const blnPodeAplicarTaxaJurosPrecoDigitado: Boolean = False;
                       dicInfEmp: TDicionario = Nil); reintroduce;

    destructor Destroy; override;
  end;

var
  frmFatMostraMargemNovo: TfrmFatMostraMargemNovo;

implementation

{$R *.dfm}

uses untModuloFatMostraMargem, untFuncoes,
     untFatMostraTravaMinimaHelper, untTypesSistema,
     untcxGridDBBandedTableViewHelper, untFuncFatTelasHelper, untConstantes,
     untDadosFechamentoDadosTinta, untFuncTinta, untFatVendasCalculadorWrapper,
     untPesqAux, untTMatrizSaldosColorantes, untMargemLucro, untFuncoesRel, untFuncoesRel2,
     System.Rtti, untMargemMinima;

{ TfrmFatMostraMargemNovo }

procedure TfrmFatMostraMargemNovo.btnConfirmaClick(Sender: TObject);
begin
  If stlIteLib.Count > 0 Then
    pAtualizaLiberacaoUnitario(stlIteLib);

  inherited;
end;

procedure TfrmFatMostraMargemNovo.btnCustosMargemTintasClick(Sender: TObject);
  Var
    frmMarTmq : TfrmFatMostraMargemNovo;
begin
  If Not btnCustosMargemTintas.Visible Then
    Exit;

  frmMarTmq := TfrmFatMostraMargemNovo.Create(Self,
                                              fatVenda,
                                              qryTinta,
                                              strOperador,
                                              blnTabPreIte,
                                              fltLimCre,
                                              blnApenasVerificandoMargemComFrete,
                                              True,
                                              cdsItens,
                                              Nil,
                                              0,
                                              '',
                                              False,
                                              Self.Name+'Tinta');
  Try
    frmMarTmq.ShowModal;
  Finally
    pFreeAndNil(frmMarTmq);
  End;
end;

procedure TfrmFatMostraMargemNovo.btnDescontoClick(Sender: TObject);
var
  LfrmGravando : TfrmGravando;
begin
  inherited;
  If Not btnDesconto.Visible Then
    Exit;

  If fDocumentosSelecionados = 0 Then
  Begin
    pMensagemOk('Selecione os produtos para efetuar a operação!');
    Exit;
  End;

  If (fPegaTotalParaDesconto(True, cdsItens) = 0) Then
  Begin
    fMensagem('ATENÇÃO!', MSG_ITENS_NAO_DEDUTIVEIS, ['&OK']);
    Exit;
  End;

  repeat
    fltPerDes := 0;
    If Not fDigitaValor(fltPerDes, 'Percentual de Desconto/Majoramento', '#,##0.00', True, True) Then
      Exit;

    if (fltPerDes >= 100) then
      fMensagem('ATENÇÃO!', 'O Valor não pode ser Maior ou Igual a 100,00!', ['&OK']);

  until (fltPerDes < 100);

  Try
    Try
      pCriarFormularios(TfrmGravando, LfrmGravando);
      LfrmGravando.fExecutarAcao := fDescontoMajoramento;
      LfrmGravando.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  Finally
    FreeAndNil(LfrmGravando);
  End;
end;

function TfrmFatMostraMargemNovo.fDescontoMajoramento(pgbStatus: TcxProgressBar = Nil): Boolean;
begin
  Result := False;

  blnExibiuMensagem := False;
  blnRecalculandoItens := True;
  blnDescontoMajoramento := True;
  try
    pInformacao('Aplicando desconto / majoramento sobre Itens, Aguarde...', pgbStatus);
    pDescontoMajoramento(fltPerDes, tpvPorcentagem, cdsItens, True, True, pgbStatus);
  finally
    blnExibiuMensagem := False;
    blnRecalculandoItens := False;
    blnDescontoMajoramento := False;

    pAfterPost(cdsItens);
  end
end;

procedure TfrmFatMostraMargemNovo.btnDesejaClick(Sender: TObject);
begin
  inherited;
  If Not btnDeseja.Visible Then
    Exit;

  If Not Assigned(fatVenda) Then
    Exit;

  If fFormataFloat(fatVenda.fltTotGer, 2) = 0 Then
    Exit;

  If (fPegaTotalParaDesconto(True, cdsItens) = 0) Then
  Begin
    fMensagem('ATENÇÃO!', MSG_ITENS_NAO_DEDUTIVEIS, ['&OK']);
    Exit;
  End;

  fltTotGerOri := fPegaTotalParaDesconto(False, cdsItens);
  fltTotGerAtu := fltTotGerOri;

  pMarcarTodos;

  If Not fDigitaValor(fltTotGerAtu, 'Total Desejado da Venda', '#,##0.00') Then
    Exit;

  // se for igual, não tem necessidade de mudar nada!
  If (fFormataFloat(fltTotGerAtu, 2) = fFormataFloat(fltTotGerOri, 2)) Then
    Exit;

  TfrmGravando.fExecutarModal(pTotalDesejadoVenda, 'Aguarde, Calculando total desejado da venda ...', '');
end;

procedure TfrmFatMostraMargemNovo.pTotalDesejadoVenda;
  Var
    fltDescAcres : Double;
    intCnt : Integer;
begin

  Try
    blnRecalculandoItens := True;

    fltDesEsp := 0;
    fatVenda.blnUtilizarDesEspDoF4 := True;

    blnUsouTotalDesejado := True;

    // If (fltDescAcres > 0) Then "DESCONTO" ELSE "ACRÉSCIMO" ;
    fltDescAcres := (fltTotGerOri - fltTotGerAtu);

    fltDescAcres := fFormataFloat(fltDescAcres, 2);

    // Cálcula o desconto, sobre o total, ou sobre o montante que pode se deduzido
    fltDescAcres := (fltDescAcres / fPegaTotalParaDesconto(True, cdsItens)) * 100;

    // Clono o Client pra não pedir a trava duas vezes
    cdsComDes := TUniClientDataSet.Create(Self);
    Try
      pCloneDataSet(cdsComDes, cdsItens);

      // Aplica o desconto, sobre o total, ou sobre o montante que pode se deduzido
      pDescontoMajoramento(fltDescAcres, tpvPorcentagem, cdsComDes, False);

      // Pega a diferença pra ver se precisará ajustar algo
      fltDescAcres := fFormataFloat(fltTotGerAtu - fPegaTotalParaDesconto(False, cdsComDes), 2);

      //Faz ajuste pra mais ou pra menos
      If fFormataFloat(fltDescAcres, 2) <> 0 Then
      Begin
        //fltDesEsp := fFormataFloat(Abs(fltDescAcres), 2);
        If fFormataFloat(fltDescAcres, 2) <= 0 Then
        Begin
          fltDesEsp := fFormataFloat(Abs(fltDescAcres), 2);
        End
        Else
        Begin
          For intCnt := 1 To 5 Do
          Begin
            pDescontoMajoramento(fFormataFloat(fltDescAcres, 2), tpvValor, cdsComDes, False, (intCnt = 1));
            fltDescAcres := fFormataFloat(fltTotGerAtu - fPegaTotalParaDesconto(False, cdsComDes), 2);

            If (fFormataFloat(fltDescAcres, 2) <= 0) Then
            Begin
              fltDesEsp := fFormataFloat(Abs(fltDescAcres), 2);
              Break;
            End;
          End;
        End;
      End;

      // Pega as alterações do Clone e joga na principal, agora olhando as trava de unitário
      fChamaTelaGravando(fAplicarDesconto, 'Aguarde, atualizando preços...');
    Finally
      FreeAndNil(cdsComDes);
    End;

  Finally
    blnRecalculandoItens := False;

    pAfterPost(cdsItens);
  End;
end;
procedure TfrmFatMostraMargemNovo.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatMostraMargemNovo.btnMargemSobreItensClick(Sender: TObject);
  Var
    strTRVEPRbkp: String;
    prcScroll: TprcScroll;
    LfrmGravando : TfrmGravando;
    blnBandPrecoMedioVisible : Boolean;
    blnFieldPreMedBrutoRitecVisible : Boolean;
    blnFieldPreMedBrutoVisible : Boolean;
    blnFieldPreMedLiquidoVisible : Boolean;
begin
  inherited;
  If Not btnMargemSobreItens.Visible Then
    Exit;

  fltMarIte := 0;
  If Not fDigitaValor(fltMarIte, 'Percentual ' + IIF(fMargem_ou_Markup='MARGEM','Margem','Markup') + ' praticada', '#,##0.00', True, True) Then
    Exit;

  {*********************************************}
  {* ALTERA TEMPORARIAMENTE PARA NÃO SOLICITAR *}
  {* LIBERAÇÃO ITEM A ITEM (fValidaUnitario)   *}
  {*REQ.167935*******************************RP*}

  strTRVEPRbkp := VS_strTRVEPR;
  VS_strTRVEPR := '2';
  blnBandPrecoMedioVisible := cxgItensView.Bands[BAND_PRECO_MEDIO].Visible;
  blnFieldPreMedBrutoRitecVisible := cxgItensITE_MRPRBT_PREMED.Visible;
  blnFieldPreMedBrutoVisible := cxgItensITE_MARBRU_PREMED.Visible;
  blnFieldPreMedLiquidoVisible := cxgItensITE_MARLIQ_PREMED.Visible;
  Try
    If (TMargemMinima.PorPrecoCustoPreCus) Then
    Begin
      cxgItensView.SetBandVisible(BAND_PRECO_CUSTO,      True);
      cxgItensView.SetColumnVisible('ITE_MARPRA_CUSITE', True);
    End
    Else If (TMargemMinima.PorCustoRealPreCus) Then
    Begin
      cxgItensView.SetBandVisible(BAND_PRECO_CUSTO_REAL, True);
      cxgItensView.SetColumnVisible('ITE_MARPRA_PRECUS', True);
    End
    Else If (TMargemMinima.UsaPrecoMedio) Then
    Begin
      cxgItensView.SetBandVisible(BAND_PRECO_MEDIO, True);
      cxgItensView.SetColumnVisible('ITE_MRPRBT_PREMED', True);
      cxgItensView.SetColumnVisible('ITE_MARLIQ_PREMED', True);
      cxgItensView.SetColumnVisible('ITE_MARBRU_PREMED', True);
    End;

    blnRecalculandoItens := True;

    pVerificaBotoes(pnlBotoesMarg, False);

    pDisableControls(cdsItens, prcScroll);

    Try
      Try
        pCriarFormularios(TfrmGravando, LfrmGravando);
        LfrmGravando.fExecutarAcao := fAplicandoMargemSobreItens;
        LfrmGravando.ShowModal;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '');
        End;
      End;
    Finally
      FreeAndNil(LfrmGravando);
    End;

  Finally

    pEnableControls(cdsItens, prcScroll);
    VS_strTRVEPR := strTRVEPRbkp; //Restaura a trava configurada originalmente

    blnRecalculandoItens := False;

    pAfterPost(cdsItens);

    If (TMargemMinima.PorPrecoCustoPreCus) Then
    Begin
      cxgItensView.SetBandVisible(BAND_PRECO_CUSTO,      (strExMaF4[1] = 'S'));
      cxgItensView.SetColumnVisible('ITE_MARPRA_CUSITE', (strExMaF4[1] = 'S'));
    End
    Else If (TMargemMinima.PorCustoRealPreCus) Then
    Begin
      cxgItensView.SetBandVisible(BAND_PRECO_CUSTO_REAL, (strExMaF4[2] = 'S'));
      cxgItensView.SetColumnVisible('ITE_MARPRA_PRECUS', (strExMaF4[2] = 'S'));
    End
    Else If (TMargemMinima.UsaPrecoMedio) Then
    Begin
      cxgItensView.SetBandVisible(BAND_PRECO_MEDIO, blnBandPrecoMedioVisible);
      cxgItensView.SetColumnVisible('ITE_MRPRBT_PREMED', blnFieldPreMedBrutoRitecVisible);
      cxgItensView.SetColumnVisible('ITE_MARBRU_PREMED', blnFieldPreMedBrutoVisible);
      cxgItensView.SetColumnVisible('ITE_MARLIQ_PREMED', blnFieldPreMedLiquidoVisible);
    End;

    pnlInfo.Caption := '';
    pVerificaBotoes(pnlBotoesMarg, True);
    Application.ProcessMessages;
  End;
end;

function TfrmFatMostraMargemNovo.fAplicandoMargemSobreItens(pgbStatus: TcxProgressBar = Nil): Boolean;
Begin
  Result := False;

  pInformacao('Aplicando margem praticada sobre itens, Aguarde...', pgbStatus);

  pnlInfo.Caption := 'Aguarde...';
  Application.ProcessMessages;

  With cdsItens Do
  Begin
    First;
    While Not Eof Do
    Begin
      pProgresso(RecNo, RecordCount, pgbStatus);

      If (cdsItens.FieldByName('SELECIONADO').AsString = 'S') And (Not fEmptyStr(FieldByName('ITE_CODITE').AsString)) And
          fItemEntraRateio(FieldByName('ITE_PROMOC').AsString, cdsItens) And (blnPermiteEditarPrecoUnitario) Then
      Begin
        Try
          Edit;
          If (TMargemMinima.PorPrecoCustoPreCus) Then
          Begin
            cxgItensView.SetColumnIndex('ITE_MARPRA_CUSITE');
            FieldByName('ITE_MARPRA_CUSITE').AsFloat := fltMarIte;
          End
          Else If (TMargemMinima.PorCustoRealPreCus) Then
          Begin
            cxgItensView.SetColumnIndex('ITE_MARPRA_PRECUS');
            FieldByName('ITE_MARPRA_PRECUS').AsFloat := fltMarIte;
          End
          Else If (TMargemMinima.PorPrecoCustoPreMed) Then
          Begin
            If (fCfgSis('MARMKP', varString) = MARGEM_SOBRE_PRECO_VENDA_LIQUIDO_RITEC) Then
            Begin
              cxgItensView.SetColumnIndex('ITE_MRPRBT_PREMED');
              FieldByName('ITE_MRPRBT_PREMED').AsFloat := fltMarIte;
            End
            Else
            Begin
              cxgItensView.SetColumnIndex('ITE_MARBRU_PREMED');
              FieldByName('ITE_MARBRU_PREMED').AsFloat := fltMarIte;
            End;
          End
          Else If (TMargemMinima.PorCustoRealPreMed) Then
          Begin
            cxgItensView.SetColumnIndex('ITE_MARLIQ_PREMED');
            FieldByName('ITE_MARLIQ_PREMED').AsFloat := fltMarIte;
          End;
          Post;
        Except
          On E: EAbort Do
          Begin
            //Deve continuar o processamento dos produtos
          End;

          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '');
          End;
        End;
      End;
      Next;
    End;
    First;
  End;
end;

procedure TfrmFatMostraMargemNovo.btnPadraoClick(Sender: TObject);
begin
  inherited;
  btnPadrao.Enabled := False;
  mmsLayoutDefault.Position := 0;
  cxgItensView.RestoreFromStream(mmsLayoutDefault);
  btnPadrao.Enabled := True;

  pProcessarView;
end;

procedure TfrmFatMostraMargemNovo.btnRestaurarClick(Sender: TObject);
begin
  If (btnRestaurar.Visible) And (btnRestaurar.Enabled) Then
  Begin
    fltDesEsp := fltDesEspCopia;
    cdsItens.Data := oleCopia;
    pCalculaResumo;
    pIncluirTotais;
    pFormataCamposGrid;
    cdsItens.Edit;
    cdsItens.Post;
  End;
end;

procedure TfrmFatMostraMargemNovo.btnTravasMinimasClick(Sender: TObject);
begin
  inherited;
  If Not btnTravasMinimas.Visible Then
    Exit;

  If TMostraTravaMinimaHelper.fExibeTravaMinima Then
    TMostraTravaMinimaHelper.pExibeDados(fatVenda.cdsTravaMinima, fatVenda);
end;

procedure TfrmFatMostraMargemNovo.btnUltCompraEmpClick(Sender: TObject);
  Var
    objLiberacao : TLiberacao;
begin

  If (Not Assigned(cdsItens)) Or
     (Not cdsItens.Active) Or
     (cdsItens.IsEmpty) Then
    Exit;

    Try
      if (btnUltCompraEmp.Enabled) And (btnUltCompraEmp.Visible) then
      begin
        If (Not fVerificaAcessoSistema('PERMF8NOF4')) Then
        Begin
          objLiberacao := TLiberacao.Create;
          Try
            objLiberacao.Clear;
            objLiberacao.objMsgLibera.pAddTexto('Liberar Visualização das Últimas Compras');

            objLiberacao.strDirAce := 'PERMF8NOF4';
            objLiberacao.strMsgSen := 'Liberar Visualização das Últimas Compras';
            objLiberacao.strCodOpe := strLoginUsuarioLogado;


            If (Not objLiberacao.fLibera) Then
            Begin
              FreeAndNil(objLiberacao);
              Exit;
            End;
          Finally
            FreeAndNil(objLiberacao);
          End;
        End;

        If Assigned(prcExecutaRelatorio) Then
        begin
          prcExecutaRelatorio(133, 6128, [],
                              ['CODITE'],
                              [cdsItens.FieldByName('ITE_CODITE').AsString],
                              Sender,
                              nil,
                              True);
        End;

      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;

    end;

procedure TfrmFatMostraMargemNovo.btnVenCliClick(Sender: TObject);
  Var
    intConfirmando : Integer;
begin
  inherited;

  intConfirmando := -1;

  If (btnVenCli.Visible) And (btnVenCli.Enabled) And (Assigned(fatVenda)) Then
    fatVenda.pVendasPorCliente(True, intConfirmando, fatVenda.strCodCli, fatVenda.strCliOri);
end;

procedure TfrmFatMostraMargemNovo.chkAcuFreteCobPrecoUniClick(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(pAcumulaFreteAoPreçoDeVenda, 'Acumulando o frete ao preço de Custo/Venda do produto ...', '');
end;

procedure TfrmFatMostraMargemNovo.pAcumulaFreteAoPreçoDeVenda;
Begin
  If Assigned(pCalculaMargemLucro) Then
  Begin
    pCalculaMargemLucro(chkAcuFreteSugPrecoCus.Checked, chkAcuFreteCobPrecoUni.Checked, cdsItens);
    pCalcularTotais(cdsItens.Data);
    pCalculaResumo;
    pIncluirTotais;
    pFormataCamposGrid;
  End;
End;

constructor TfrmFatMostraMargemNovo.Create(AOwner: TComponent; const fatVenda: TFatVenda; const qryTinta: TUniQuery; const strOperador: String;
  const blnTabPreIte: Boolean; const fltLimCre: Double; const blnApenasVerificandoMargemComFrete, blnTintaDeMaquina: Boolean;
  const cdsItensTinta: TUniClientDataSet; const itemCalcMar: TItemCalcMargem; const fltDesEsp: Double; const strCcnAnt: String;
  const blnFatDigDesconto: Boolean; const strName: String; const blnUsaUniLiq: Boolean; const blnPodeEditarPrecoUnitario: Boolean;
  const blnPodeAplicarTaxaJurosPrecoDigitado: Boolean; dicInfEmp: TDicionario);
begin
  Inherited Create(AOwner);

  If (Not strName.IsEmpty) Then
    Self.Name := strName;

  Self.Height := 768;
  Self.Width := 1046;

  Self.fltDesEsp := fltDesEsp;
  Self.fatVenda := fatVenda;

  If (Self.blnTintaDeMaquina) Then
    intDecUni := 4
  Else If Assigned(fatVenda) Then
    intDecUni := fatVenda.VS_intDecUni
  Else
    intDecUni := fCfgSis('DECUNI', varInteger);

  Self.qryTinta := qryTinta;
  Self.strOperador := strOperador;
  Self.blnTabPreIte := blnTabPreIte;
  Self.fltLimCre := fltLimCre;
  Self.blnApenasVerificandoMargemComFrete := blnApenasVerificandoMargemComFrete;
  Self.blnTintaDeMaquina := blnTintaDeMaquina;
  Self.blnApenasVisualizacao := True;
  Self.itemCalcMar := itemCalcMar;
  Self.cdsItensTinta := TUniClientDataSet.Create(nil);
  Self.blnCanculandoTotal := False;
  Self.blnSomenteUnitarioAcimaDoSugerido := False;
  Self.blnMargemLucroAplicaDesconto := blnFatDigDesconto;
  Self.blnUsaUniLiq := blnUsaUniLiq ;
  Self.blnPodeEditarPrecoUnitario := blnPodeEditarPrecoUnitario;
  Self.blnPodeAplicarTaxaJurosPrecoDigitado := blnPodeAplicarTaxaJurosPrecoDigitado;
  Self.dicInfEmp := dicInfEmp;

  If Assigned(cdsItensTinta) Then
    Self.cdsItensTinta.Data := cdsItensTinta.Data;

  strExMaF4 := fCfgSis('EXMAF4');
  intCorZeb := StrToIntDef(fCfgSis('CORZEB'), clWhite);

  objMostraMargemNovoController := TFatMostraMargemNovoController.New;

  objValidaUnitario := objMostraMargemNovoController.ValidaUnitario;
  objAdicionarTinta := objMostraMargemNovoController.AdicionarTinta;
  objAdicionarTinta.SetDecUni(intDecUni);
  objBeforePost     := objMostraMargemNovoController.BeforePost;

  dtsItens := TDataSource.Create(Self);

  dicInfVen := TDictionary<String, TRecInfVen>.Create;
  dicColunasF4 := TDictionary<String, Boolean>.Create;

  stlIteLib := TStringList.Create;

  FillChar(recTotMarLuc, SizeOf(recTotMarLuc), #0);
  FillChar(recTotMarLucTotIte, SizeOf(recTotMarLucTotIte), #0);

  If (Self.blnTintaDeMaquina) Then
  Begin
    TfrmGravando.fExecutarModal(pProcessaTinta, 'Processando informações . . .', '');
  End
  Else If Assigned(Self.fatVenda) Then
  Begin
    TfrmGravando.fExecutarModal(pProcessaProdutos, 'Processando informações . . .', '');

    If (Not fatVenda.blnUtilizarDesEspDoF4) Then
      fatVenda.fltDesEspF4 := fltDesEsp;
  End;

  If Self.blnTintaDeMaquina Then
    Self.Caption := 'Consulta de Custo / Margem das Tintas'
  Else
    Self.Caption := 'Consulta de Custo / Margem de Produtos';

  blnOcultaBotoes := blnFatDigDesconto;
  blnVisualizarPorMensagem := False;

end;

procedure TfrmFatMostraMargemNovo.pProcessaProdutos;
Var cdsData : OleVariant;
begin
  pCriaCdsItens(False);
  {*******************************************************************************************}
  {* NAO DEVE APLICAR O DESCONTO NO UNITARIO, POIS QUANDO CARREGA UM PEDIDO OS VALORES DE    *}
  {* DESCONTO ESPECIAL E PERCENTUAL DE DESCONTO ESTAVAM SENDO APLICADOS NO PRECO UNITARIO,   *}
  {* AO CONFIRMAR NA TELA DE MARGEM (F10) ESTES PRECOS SAO ALTERADOS NO GRID DE VENDAS.      *}
  {* AO REPETIR ESTE PROCESSO VARIAS VEZES O PRECO DO PRODUTO VAI DECRESCENDO PODENDO ATE    *}
  {* FICAR NEGATIVO.                                                                         *}
  {* CONCLUSÃO, NO F4 O PREÇO DO PRODUTO DEVE SER O PRECO SEM DESCONTOS (ESPECIAL/PERCENTUAL)*}
  {************************************************************************************RO,JC**}

  If blnMargemLucroAplicaDesconto Then
    FatVenda.fltDesEsp := 0;

  cdsData := fatVenda.fCalculaMargemLucro(blnMargemLucroAplicaDesconto, -1, Nil, True, False);

  cdsItens.Data := cdsData;
  cdsItens.LogChanges := False;

  pAdicionaItemAvulso;

  pCalcularTotais(cdsItens.Data);
end;

procedure TfrmFatMostraMargemNovo.pProcessaTinta;
Begin
  pCriaCdsItens(True);
  pProcessarTintasDeMaquina;
End;

procedure TfrmFatMostraMargemNovo.cxgItensViewColumnHeaderClick(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
var
  strCampo: String;
  strNomeIndex: String;
  strCamposIndex: String;
  blnFazerDesc: Boolean;
begin
  strCampo := cxgItensView.Columns[AColumn.Index].DataBinding.FieldName;
  strNomeIndex := 'IDX_'+strCampo;
  strCamposIndex := 'ITE_SEQUEN;'+strCampo;

  blnFazerDesc := (cdsItens.IndexFieldNames = strCamposIndex);

  cdsItens.IndexDefs.Clear;
  cdsItens.IndexFieldNames := '';

  If (blnFazerDesc) Then
  Begin
    with cdsItens.IndexDefs.AddIndexDef do
    begin
      Name := strNomeIndex;
      Fields :=  strCamposIndex;
      DescFields := strCampo;
    end;

    cdsItens.IndexName := strNomeIndex;
  End
  Else
    cdsItens.IndexFieldNames := strCamposIndex;

end;

procedure TfrmFatMostraMargemNovo.cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    fltQtdIte : Double;
    fltSalDis : Double;
    blnPromoc : Boolean;
    blnUsaCorSelDif: Boolean;
begin
  inherited;

  If (Not Assigned(cdsItens)) Or (Not cdsItens.Active) Then
    Exit;

  blnPromoc := (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensITE_PROMOC.Index]) = 'S');
  blnUsaCorSelDif := False;

  If (AViewInfo.Item.Index = cxgItensITE_QTDITE.Index) Or
     (AViewInfo.Item.Index = cxgItensITE_SALDOS.Index) Then
  Begin
    fltQtdIte := IfNull(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensITE_QTDITE.Index], 0);
    fltSalDis := IfNull(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensITE_SALDOS.Index], 0);
  End
  Else
  Begin
    fltQtdIte := 0;
    fltSalDis := 0;
  End;

  If (fEmptyStr(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensITE_CODITE.Index]))) Then
  Begin
    ACanvas.Brush.Color := clLtGray;
    ACanvas.Font.Color  := clBlue;
  End
  Else If AViewInfo.Item.Options.Editing And (not blnPromoc) Then
  Begin
    ACanvas.Brush.Color := clYellow;
    ACanvas.Font.Color  := clBlack;

    If Not pnlEditaveis.Visible Then
      pnlEditaveis.Visible := True;
  End
  Else If (Pos('BRU_', AViewInfo.Item.Name) > 0) Then
  Begin
    ACanvas.Brush.Color := clLime; // $00F4A460
    ACanvas.Font.Color  := clBlack;

    If Not pnlMargemBruta.Visible Then
      pnlMargemBruta.Visible := True;
  End
  Else If (Pos('LIQ_', AViewInfo.Item.Name) > 0) Then
  Begin
    ACanvas.Brush.Color := clAqua; // $00A4A460
    ACanvas.Font.Color  := clBlack;

    If Not pnlMargemLiquida.Visible Then
      pnlMargemLiquida.Visible := True;
  End
  Else If (fltQtdIte > fltSalDis) Then
  Begin
    ACanvas.Brush.Color := clRed;
    ACanvas.Font.Color  := clBlack;

    If Not pnlSemEstoque.Visible Then
      pnlSemEstoque.Visible := True;
  End
  Else If blnPromoc Then
  Begin
    If AViewInfo.Focused Then
      ACanvas.Font.Color := clBlue
    Else
      ACanvas.Font.Color := clGreen;

    If Not pnlPromocao.Visible Then
      pnlPromocao.Visible := True;

    blnUsaCorSelDif := True;
  End
  Else If Odd(AViewInfo.GridRecord.Index) Then
  Begin
    ACanvas.Brush.Color := intCorZeb;
    ACanvas.Font.Color  := clBlack;
    If (AViewInfo.GridRecord.Selected) Then
    Begin
      If (AViewInfo.Item.Focused) Then
        ACanvas.Font.Color := clBlue
      Else
        ACanvas.Font.Color := clBlack;
    End;
  End
  Else
  Begin
    ACanvas.Font.Color := clBlack;
  End;

  If (AViewInfo.Selected) Then
  Begin
    ACanvas.Font.Style := [fsBold];
    If (blnUsaCorSelDif) Then
    Begin
      ACanvas.Brush.Color := clCream;
    End;
  End;
end;

procedure TfrmFatMostraMargemNovo.cxgItensViewEditKeyDown(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  With cdsItens Do
  Begin
    Case Key Of
      VK_Escape: btnFechar.Click;
      VK_RETURN: If State = dsEdit Then Post;
      VK_TAB:
      Begin
        If (SameText(cdsItens.FieldByName('ITE_DESITE').AsString, STR_TEXTO_TOTAL_S_DESC)) Or
           (SameText(cdsItens.FieldByName('ITE_DESITE').AsString, STR_TEXTO_TOTAL_C_DESC)) Then
          SelectNext(ActiveControl, True, True);
      End;
    End;
  End;
end;

procedure TfrmFatMostraMargemNovo.cxgItensViewEditKeyPress(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit;
  var Key: Char);
begin
  inherited;
  Case Key Of
    '-' : If Not (cxgItensView.ColumnSelected('ITE_MARPRA_PRECUS')) Then
            Key := #0;
  End;

end;

procedure TfrmFatMostraMargemNovo.cxgItensViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  With cdsItens Do
  Begin
    Case Key Of
      VK_Escape: btnFechar.Click;
      VK_RETURN: If State = dsEdit Then
                   Post;
    End;
  End;
end;

destructor TfrmFatMostraMargemNovo.Destroy;
begin
  FreeAndNil(dtsTotais);
  FreeAndNil(stlIteLib);
  FreeAndNil(dicInfVen);
  FreeAndNil(dicColunasF4);

  If Assigned(dicInfEmp) Then
    FreeAndNil(dicInfEmp);

  inherited;
end;

function TfrmFatMostraMargemNovo.fGetChaveLayoutGrid: String;
begin
  Result := Self.Name + '.' + cxgItens.Name;
end;

class function TfrmFatMostraMargemNovo.fGetDadosMargem(const fatVenda: TFatVenda; const strOperador: String;
  itemCalcMar: TItemCalcMargem): OleVariant;
  Var
    frmMosMar : TfrmFatMostraMargemNovo;
begin
  frmMosMar := TfrmFatMostraMargemNovo.Create(Nil,
                                              fatVenda,
                                              Nil,
                                              strOperador,
                                              False,
                                              0,
                                              False,
                                              False,
                                              Nil,
                                              itemCalcMar);
  Try
    Try
      frmMosMar.pFormShowInterna(Nil);
      Result := frmMosMar.cdsItens.Data;
    Except
    End;
  Finally
    pFreeAndNil(frmMosMar);
  End;
end;

function TfrmFatMostraMargemNovo.fGetDesEsp: Double;
begin
  Result := fltDesEsp;
end;

function TfrmFatMostraMargemNovo.fGetTipoAsString(tmctTipo: TTintaDeMaquinaComponenteTipo): string;
begin
  case tmctTipo of
    tmctColoranteImobiliario: Result := 'Colorantes';
    tmctBaseAutomotiva: Result := 'Bases Automotivas';
    tmctEmbalagemAutomotiva: Result := 'Embalagens Automotivas';
    tmctBaseImobiliaria: Result := 'Bases Imobiliárias';
  end;
end;

function TfrmFatMostraMargemNovo.fItemEntraRateio(strPromocao: String; cdsDestin: TUniClientDataSet): Boolean;
begin

  If Assigned(fatVenda) Then
  Begin
    With fatVenda, cdsDestin Do
    Begin
      blnPermiteEditarPrecoUnitario :=
        fPermiteEditarPrecoUnitario( strOpcDoc, strCodCnd, strCodCli,
                                     strPromocao,
                                     FieldByName('ITE_TABPRE').AsString, True,
                                     FieldByName('ITE_CODITE').AsString = fCfgSis('ITEVID'),
                                     fEhDevolucaoEspelhoOuParaFornecedor,
                                     blnSomenteUnitarioAcimaDoSugerido );
    End;
  End;

  If (fRealizandoConfirmacao(False)) Or (Not fPermiteDesconto) Or
     (Self.blnTintaDeMaquina) Or (Self.blnApenasVisualizacao) Then
    blnPermiteEditarPrecoUnitario := False;

  If Assigned(fatVenda) Then
    Result := (blnPermiteEditarPrecoUnitario) And
              (fatVenda.fItemEntraRateio(cdsDestin)) And
              (IIF((fatVenda.fRegraPrecoSugestaoAtiva = TRegraPrecoSugestao.PrecoDePromocao), True, (strPromocao <> 'S')))
  Else
    Result := (blnPermiteEditarPrecoUnitario) And
              (IIF((fatVenda.fRegraPrecoSugestaoAtiva = TRegraPrecoSugestao.PrecoDePromocao), True, (strPromocao <> 'S')));
end;

function TfrmFatMostraMargemNovo.fOperadorAcesso: String;
begin
  Result := IIF(fEmptyStr(strOperador), strLoginUsuarioLogado, strOperador);
end;

procedure TfrmFatMostraMargemNovo.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(cxgItens);
end;

procedure TfrmFatMostraMargemNovo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(mmsLayoutDefault);

  if not blnVisualizarPorMensagem then
  begin
    fGetFuncoesCxGrid.pSalvarView(TcxGridDBTableView(cxgItensView), fGetChaveLayoutGrid, cdsItens, False, 'S');
  end;

  With cdsItens Do
  Begin
    If (State = dsEdit) Then
    Begin
      Action := caNone;
      Post;
    End;
  End;

end;

procedure TfrmFatMostraMargemNovo.FormCreate(Sender: TObject);
begin
  inherited;

  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.WindowState := wsMaximized;

  blnUsouTotalDesejado := False;

  blnRecalculandoItens := False;

  mmsLayoutDefault  := TMemoryStream.Create;

  If (TMargemMinima.UsaPrecoBruto) Then
    cxgItensITE_PREMED.DataBinding.FieldName := 'ITE_PREMED'
  Else  
    cxgItensITE_PREMED.DataBinding.FieldName := 'ITE_PREMED_LIQ';

  blnExibiuMensagem := False;
  blnDescontoMajoramento := False;
end;

procedure TfrmFatMostraMargemNovo.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F12: pDesmarcarTodos;
    VK_F11: pMarcarTodos;
    VK_F10: Begin
              btnConfirma.Click;
              Key := 0;
            End;

    VK_F2 : Begin
              If btnMargemSobreItens.Visible Then
                btnMargemSobreItens.Click;
              Key := 0;
            End;

    VK_F3 : Begin
              If btnDesconto.Visible Then
                btnDesconto.Click;
              Key := 0;
            End;


    VK_F4: begin
             If btnCustosMargemTintas.Visible Then
               btnCustosMargemTintas.Click;
             Key := 0;
           end;

    VK_F5: begin
             If btnTravasMinimas.Visible Then
               btnTravasMinimas.Click;
             Key := 0;
           end;

    VK_Escape: btnFechar.Click;

    VK_F8 : If btnUltCompraEmp.Visible Then
              btnUltCompraEmp.Click;
    VK_F9 : If btnVenCli.Visible Then
              btnVenCli.Click;
    VK_F6 : If btnDeseja.Visible Then
              btnDeseja.Click;
    VK_F7 : If btnRestaurar.Visible Then
              btnRestaurar.Click;
  End;
end;

procedure TfrmFatMostraMargemNovo.FormShow(Sender: TObject);
begin
  inherited;
  pFormShowInterna(Sender);
end;

function TfrmFatMostraMargemNovo.fPegaTotalParaDesconto(blnAplicarRestricoes: Boolean; cdsDestin: TUniClientDataSet): Double;
  Var
    blnItemEntraRateio : Boolean;
    cdsClone : TUniClientDataSet;
begin
  Result := 0;

  cdsClone := TUniClientDataSet.Create(Self);
  Try
    pCloneDataSet(cdsClone, cdsDestin);

    With cdsClone Do
    Begin
      First;
      While Not Eof Do
      Begin
        If (Not blnAplicarRestricoes) Then
          blnItemEntraRateio := True
        Else
          blnItemEntraRateio := fItemEntraRateio(FieldByName('ITE_PROMOC').AsString, cdsClone);

        // não pega registro de totais 99997, 99998 e 99999
        If (blnItemEntraRateio) and (FieldByName('ITE_SEQUEN').AsInteger < 99997) then
        Begin
          Result := Result + fFormataFloat(FieldByName('ITE_UNITAR').AsFloat * FieldByName('ITE_QTDITE').AsFloat, 2);
        End;

        Next;
      End;
    End;
  Finally
    FreeAndNil(cdsClone);
  End;
end;

function TfrmFatMostraMargemNovo.fRealizandoConfirmacao(blnInclCF: Boolean = True): Boolean;
begin
  Result := False;
  If Assigned(fatVenda) Then
    Result := (Pos(fatVenda.strOpcDoc, IIF(blnInclCF, 'CF_', '')+'CI_CT_CP_OV_') > 0);
end;

function TfrmFatMostraMargemNovo.fTemTinta: Boolean;
  var
    strBookMark: TBookmark;
begin
  Result := False;

  If cdsVenda = nil Then Exit;
  If not Assigned(fGTinForGeral) Then Exit;

  Try
    Try
      cdsVenda.DisableConstraints;
      cdsVenda.DisableControls;
      strBookMark := cdsVenda.Bookmark;
      cdsVenda.First;
      while not cdsVenda.Eof do
      begin
        if cdsVenda.FieldByName('ITE_IDEPRO').AsString = 'NOR' then
        begin
          cdsVenda.Next;
          Continue;
        end;

        if Assigned(fGetITintadeMaquina(TDadosFechamentoDadosTinta.Create(cdsVenda),
          TFatVendasCalculadorWrapper.Create(fatVenda), dicInfEmp)) then
        begin
          Result := True;
          Exit;
        end;
        cdsVenda.Next;
      end;
    Except
      on E: Exception do
      begin
        Result := False;
      end;
    End;
  Finally
    cdsVenda.Bookmark := strBookMark;
    cdsVenda.EnableConstraints;
    cdsVenda.EnableControls;
  End;
end;

function TfrmFatMostraMargemNovo.fTotalDouble(strNomeCampo: String): Double;
  Var
    intRecNo : Integer;
begin

  Result := 0;

  intRecNo := cdsItens.RecNo;
  Try
    If (cdsItens.FindField(strNomeCampo) <> Nil) And
       (cdsItens.Locate('ITE_SEQUEN', 99997, []) Or cdsItens.Locate('ITE_SEQUEN', 99999, [])) Then
    Begin
        Result := cdsItens.FieldByName(strNomeCampo).AsFloat
    End;

  Finally
    cdsItens.RecNo := intRecNo;
  End;
end;

function TfrmFatMostraMargemNovo.fRecebidoPorPix(const AblnMostrMsg: boolean = True): Boolean;
begin
  result := False ;

  If Not Assigned(Self.fatVenda) Then
    Exit;

  if Self.fatVenda.fRecebidoPorPix then
  begin
    if AblnMostrMsg then
      fMensagem('ATENÇÃO!', 'Não é permitido alterar valores de uma venda que já tenha Pix recebido.', ['&OK']);
    result := True ;
    Exit;
  end ;
end;

function TfrmFatMostraMargemNovo.fPemiteEditarDadosF4Margem(const AblnMostrMsg: boolean = True): Boolean ;
begin
  Result := True;

  if (fRecebidoPorPix(False)) Then
    Result  := False;
end ;

function TfrmFatMostraMargemNovo.fUserFunction(const MethodName: string; var Params: Variant): Variant;
begin
  If (MethodName = AnsiUpperCase('fTotalDouble')) Then
  Begin
    Result := fTotalDouble(Params[0]);
  End;
end;

function TfrmFatMostraMargemNovo.fValidaUnitario(DataSet: TDataSet; fltUnitar: Double): Boolean;
  Var
    fltDesMGe: Double;
    fltDesMSu: Double;
    cdsTintaInf: TUniClientDataSet;

  procedure pPreencheCdsInformacoesTinta();
  begin
    cdsTintaInf.Append;
    cdsTintaInf.FieldByName('ITE_IDEPRO').AsString  := cdsVenda.FieldByName('ITE_IDEPRO').AsString;
    cdsTintaInf.FieldByName('ITE_ITETIN').AsString  := cdsVenda.FieldByName('ITE_ITETIN').AsString;
    cdsTintaInf.FieldByName('ITE_TIPPRE').AsString  := cdsVenda.FieldByName('ITE_TIPPRE').AsString;
    cdsTintaInf.FieldByName('ITE_LINTIN').AsString  := cdsVenda.FieldByName('ITE_LINTIN').AsString;
    cdsTintaInf.FieldByName('ITE_CATALI').AsString  := cdsVenda.FieldByName('ITE_CATALI').AsString;
    cdsTintaInf.FieldByName('ITE_PORPER').AsString  := cdsVenda.FieldByName('ITE_PORPER').AsString;
    cdsTintaInf.FieldByName('ITE_LAZQUA').AsInteger := cdsVenda.FieldByName('ITE_LAZQUA').AsInteger;
    cdsTintaInf.FieldByName('ITE_QTDEMB').AsFloat   := cdsVenda.FieldByName('ITE_QTDEMB').AsFloat;
    cdsTintaInf.FieldByName('ITE_QTDITE').AsFloat   := cdsVenda.FieldByName('ITE_QTDITE').AsFloat;
    cdsTintaInf.FieldByName('ITE_DESITE').AsString  := cdsVenda.FieldByName('ITE_DESITE').AsString;
    cdsTintaInf.FieldByName('ITE_VOLPRO').AsFloat   := cdsVenda.FieldByName('ITE_VOLPRO').AsFloat;
    cdsTintaInf.FieldByName('ITE_CODDIL').AsString  := cdsVenda.FieldByName('ITE_CODDIL').AsString;
    cdsTintaInf.FieldByName('ITE_PORDIL').AsFloat   := cdsVenda.FieldByName('ITE_PORDIL').AsFloat;
    cdsTintaInf.FieldByName('ITE_DILCON').AsString  := cdsVenda.FieldByName('ITE_DILCON').AsString;
    cdsTintaInf.FieldByName('ITE_PORCAT').AsFloat   := cdsVenda.FieldByName('ITE_PORCAT').AsFloat;
    cdsTintaInf.FieldByName('FOR_TIPCOR').AsString  := cdsVenda.FieldByName('FOR_TIPCOR').AsString;
    cdsTintaInf.FieldByName('FOR_TEXBAS').AsString  := cdsVenda.FieldByName('FOR_TEXBAS').AsString;
    cdsTintaInf.FieldByName('FOR_MODDIL').AsInteger := cdsVenda.FieldByName('FOR_MODDIL').AsInteger;
    cdsTintaInf.FieldByName('FOR_ITECOB').AsString  := cdsVenda.FieldByName('FOR_ITECOB').AsString;
    cdsTintaInf.FieldByName('ITE_EMPPRD').AsString  := cdsVenda.FieldByName('ITE_EMPPRD').AsString;
    cdsTintaInf.FieldByName('AUTOINCREM').AsInteger := 1;
    cdsTintaInf.FieldByName('ITE_MONTAD').AsString  := cdsVenda.FieldByName('ITE_MONTAD').AsString;
    cdsTintaInf.FieldByName('ITE_A_N_O_').AsString  := cdsVenda.FieldByName('ITE_A_N_O_').AsString;
    cdsTintaInf.FieldByName('ITE_CODITE').AsString  := cdsVenda.FieldByName('ITE_CODITE').AsString;
    cdsTintaInf.FieldByName('ITE_ITEEMB').AsString  := cdsVenda.FieldByName('ITE_ITEEMB').AsString;
    cdsTintaInf.FieldByName('ITE_TABPRE').AsString  := cdsVenda.FieldByName('ITE_TABPRE').AsString;
    cdsTintaInf.FieldByName('ITE_FATACE').AsFloat   := cdsVenda.FieldByName('ITE_FATACE').AsFloat;
    cdsTintaInf.FieldByName('ITE_DESESP').AsFloat   := 0.0;
    cdsTintaInf.Post;
  end;
Begin
  Result := True;
  pPosicionarRegistroVenda(DataSet);

  cdsTintaInf := Nil;

  Try
    If (fAnalisaTodosCompomentesAoTravarUnitarioDeTintaComoProdutoNormal) Then
    Begin
      If (cdsVenda.FieldByName('ITE_IDEPRO').AsString <> 'NOR') Then
      Begin
        cdsTintaInf := fCriaCdsInformacoesTinta(Self);
        pPreencheCdsInformacoesTinta();
      End;
    End;


    fltDesMGe := objValidaUnitario.RetornarAPorcentagemDoDescontoMaximoGerente(fatVenda, DataSet);
    fltDesMSu := objValidaUnitario.RetornarAPorcentagemDoDescontoMaximoSubGerente(fatVenda, DataSet);

    if fatVenda.fUsaValidaMargemCondPerfilItem then
    Begin
      Result := fatVenda.fValidaMargemCondPatgo(fltUnitar,
                                                fltTotalG,
                                                strCcnAnt,
                                                DataSet.FieldByName('ITE_QTDITE').AsFloat,
                                                0,  //fltQtdJaDig,
                                                0,  //fltQtdJaEmPromoc,
                                                DataSet.FieldByName('ITE_UNIORI').AsFloat,
                                                0,
                                                DataSet.FieldByName('ITE_PREEMB').AsFloat,
                                                DataSet.FieldByName('ITE_UNIDEV').AsFloat,
                                                DataSet.FieldByName('ITE_EMBALA').AsFloat,
                                                0, //fltDesCon,
                                                DataSet.FieldByName('ITE_PRCTIN').AsFloat,
                                                DataSet.FieldByName('ITE_PRVTIN').AsFloat,
                                                DataSet.FieldByName('ITE_CUSITE').AsFloat,
                                                DataSet.FieldByName('ITE_QTDEMB').AsInteger,
                                                DataSet.FieldByName('ITE_TOTITE').AsFloat,
                                                '', //strEmpresaItem,
                                                IIF(blnTabPreIte, DataSet.FieldByName('ITE_TABPRE').AsString, fatVenda.strTabPre),
                                                DataSet.FieldByName('ITE_CODITE').AsString,
                                                DataSet.FieldByName('ITE_DESITE').AsString,
                                                DataSet.FieldByName('ITE_IDEPRO').AsString,
                                                DataSet.FieldByName('ITE_TIPPRE').AsString,
                                                DataSet.FieldByName('ITE_ITETIN').AsString,
                                                DataSet.FieldByName('ITE_CATALI').AsString,
                                                DataSet.FieldByName('ITE_PROMOC').AsString,
                                                DataSet.FieldByName('ITE_ENTSAI').AsString,
                                                DataSet.FieldByName('ITE_BRINDE').AsString,
                                                True,
                                                cdsDados,
                                                fatVenda.qryConCit,
                                                qryTinta,
                                                cdsDados,
                                                DataSet.FieldByName('ITE_PRELOT').AsFloat,
                                                fRetSiglaUnidadePorCodIte(DataSet.FieldByName('ITE_CODITE').AsString),
                                                IIF(TMargemMinima.UsaPrecoBruto, DataSet.FieldByName('ITE_PREMED').AsFloat, DataSet.FieldByName('ITE_PREMED_LIQ').AsFloat),
                                                DataSet.FieldByName('ITE_IMPULT').AsFloat,
                                                True,
                                                False,
                                                False,
                                                '',
                                                0,
                                                DataSet.FieldByName('ITE_BAREMB').AsString,
                                                DataSet.FieldByName('ITE_UNISBI').AsFloat,
                                                stlIteLib,
                                                DataSet.FieldByName('ITE_PROACA').AsInteger = 1,
                                                (DataSet.FieldByName('ITE_SEQCOM').AsInteger > 0) And (cdsDados.FieldByName('ITE_ATIVAC').AsString <> 'S'),
                                                '1',
                                                0,
                                                True);
    End;

    If not Result Then
      Exit;

    Result := FatVenda.fValidaUnitario(fltUnitar,
                                       fltTotalG,
                                       strCcnAnt,
                                       DataSet.FieldByName('ITE_QTDITE').AsFloat,
                                       0,  //fltQtdJaDig,
                                       0,  //fltQtdJaEmPromoc,
                                       DataSet.FieldByName('ITE_UNIORI').AsFloat,
                                       fltDesMGe,
                                       DataSet.FieldByName('ITE_PREEMB').AsFloat,
                                       DataSet.FieldByName('ITE_UNIDEV').AsFloat,
                                       DataSet.FieldByName('ITE_EMBALA').AsFloat,
                                       0, //fltDesCon,
                                       DataSet.FieldByName('ITE_PRCTIN').AsFloat,
                                       DataSet.FieldByName('ITE_PRVTIN').AsFloat,
                                       DataSet.FieldByName('ITE_CUSITE').AsFloat,
                                       DataSet.FieldByName('ITE_QTDEMB').AsInteger,
                                       DataSet.FieldByName('ITE_TOTITE').AsFloat,
                                       '', //strEmpresaItem,
                                       IIF(blnTabPreIte, DataSet.FieldByName('ITE_TABPRE').AsString, fatVenda.strTabPre),
                                       DataSet.FieldByName('ITE_CODITE').AsString,
                                       DataSet.FieldByName('ITE_DESITE').AsString,
                                       DataSet.FieldByName('ITE_IDEPRO').AsString,
                                       DataSet.FieldByName('ITE_TIPPRE').AsString,
                                       DataSet.FieldByName('ITE_ITETIN').AsString,
                                       DataSet.FieldByName('ITE_CATALI').AsString,
                                       DataSet.FieldByName('ITE_PROMOC').AsString,
                                       DataSet.FieldByName('ITE_ENTSAI').AsString,
                                       DataSet.FieldByName('ITE_BRINDE').AsString,
                                       True,
                                       cdsDados,
                                       fatVenda.qryConCit,
                                       qryTinta,
                                       cdsDados,
                                       DataSet.FieldByName('ITE_PRELOT').AsFloat,
                                       fRetSiglaUnidadePorCodIte(DataSet.FieldByName('ITE_CODITE').AsString),
                                       IIF(TMargemMinima.UsaPrecoBruto, DataSet.FieldByName('ITE_PREMED').AsFloat, DataSet.FieldByName('ITE_PREMED_LIQ').AsFloat),
                                       DataSet.FieldByName('ITE_IMPULT').AsFloat,
                                       DataSet.FieldByName('ITE_PREULT').AsFloat,
                                       True,
                                       False,
                                       False,
                                       '',
                                       fltDesMSu,
                                       DataSet.FieldByName('ITE_BAREMB').AsString,
                                       DataSet.FieldByName('ITE_UNISBI').AsFloat,
                                       stlIteLib,
                                       DataSet.FieldByName('ITE_PROACA').AsInteger = 1,
                                       (DataSet.FieldByName('ITE_SEQCOM').AsInteger > 0) And (cdsDados.FieldByName('ITE_ATIVAC').AsString <> 'S'),
                                       '1',
                                       0,
                                       cdsTintaInf);

  Finally
    If Assigned(cdsTintaInf) Then
      FreeAndNil(cdsTintaInf);
  End;
end;

procedure TfrmFatMostraMargemNovo.mnuImprimirF4Click(Sender: TObject);
  Var
    stlFunctions : TStringList;
begin
  inherited;

  stlFunctions := TStringList.Create;
  cdsImpressao := TUniClientDataSet.Create(Self);

  Try
    stlFunctions.Add('function fTotalDouble(strNomeCampo: String): Double;');
    pGerarDicionarioColunas;

    pCloneDataSet(cdsImpressao, cdsItens);

    pImprimirF4(cdsImpressao, dicColunasF4, fUserFunction, False, stlFunctions);
  Finally
    FreeAndNil(stlFunctions);
    FreeAndNil(cdsImpressao);
  End;
end;

function TfrmFatMostraMargemNovo.fRetornaComissaoTabPreco: Double;
  Var
    strTabPre : String;
begin
  If blnTabPreIte Then
    strTabPre := cdsItens.FieldByName('ITE_TABPRE').AsString
  Else
    strTabPre := fatVenda.strTabPre;

  Result := fCampoTabela('ITE_COMTB' + IIF(fEmptyStr(strTabPre), '1', strTabPre),
                         'ITEGER',
                         ['ITE_CODITE', 'ITE_CODEMP'],
                         [cdsItens.FieldByName('ITE_CODITE').AsString,
                          fatVenda.fGetEmpCalculoItem(cdsItens.FieldByName('ITE_EMPITE').AsString)],
                         False);
end;

procedure TfrmFatMostraMargemNovo.pAdicionaItemAvulso;
  Var
    cdsVendaTmp : TUniClientDataSet;
begin
  If Not (Assigned(itemCalcMar)) Then
    Exit;

  cdsVendaTmp := TUniClientDataSet.Create(Self);
  Try
    pCloneDataSet(cdsVendaTmp, cdsItens);

    If (itemCalcMar.AUTOINCREM <> 0) And (cdsItens.Locate('AUTOINCREM', itemCalcMar.AUTOINCREM, [])) Then
      cdsItens.Delete;

    cdsVendaTmp.Append;

    cdsVendaTmp.FieldByName('ITE_EMPITE').AsString := itemCalcMar.ITE_EMPITE;
    cdsVendaTmp.FieldByName('ITE_CODITE').AsString := itemCalcMar.ITE_CODITE;
    cdsVendaTmp.FieldByName('ITE_DESITE').AsString := itemCalcMar.ITE_DESITE;
    cdsVendaTmp.FieldByName('ITE_IMPDIR').AsString := itemCalcMar.ITE_IMPDIR;
    cdsVendaTmp.FieldByName('ITE_IDEPRO').AsString := itemCalcMar.ITE_IDEPRO;
    cdsVendaTmp.FieldByName('ITE_PROMOC').AsString := itemCalcMar.ITE_PROMOC;
    cdsVendaTmp.FieldByName('ITE_TABPRE').AsString := itemCalcMar.ITE_TABPRE;
    cdsVendaTmp.FieldByName('ITE_NUMLOT').AsString := itemCalcMar.ITE_NUMLOT;

    cdsVendaTmp.FieldByName('ITE_CODFAB').AsString := fRetCodFabrica(itemCalcMar.ITE_CODITE);
    cdsVendaTmp.FieldByName('ITE_SIGUNI').AsString := fRetSiglaUnidadePorCodIte(itemCalcMar.ITE_CODITE);
    cdsVendaTmp.FieldByName('ITE_DESMAR').AsString := fRetNomMarcaItem(itemCalcMar.ITE_CODITE);

    cdsVendaTmp.FieldByName('ITE_QTDITE').AsFloat  := itemCalcMar.ITE_QTDITE;
    cdsVendaTmp.FieldByName('ITE_CUSITE').AsFloat  := itemCalcMar.ITE_CUSITE;
    cdsVendaTmp.FieldByName('ITE_UNITAR').AsFloat  := itemCalcMar.ITE_UNITAR;
    cdsVendaTmp.FieldByName('ITE_UNIORI').AsFloat  := itemCalcMar.ITE_UNIORI;
    cdsVendaTmp.FieldByName('ITE_PREMED').AsFloat  := itemCalcMar.ITE_PREMED;
    cdsVendaTmp.FieldByName('ITE_IMPULT').AsFloat  := itemCalcMar.ITE_IMPULT;
    cdsVendaTmp.FieldByName('ITE_PREULT').AsFloat  := itemCalcMar.ITE_PREULT;
    cdsVendaTmp.FieldByName('ITE_TOTITE').AsFloat  := fFormataFloat(itemCalcMar.ITE_UNITAR * itemCalcMar.ITE_QTDITE, 2);

    cdsVendaTmp.FieldByName('ITE_COMTBL').AsFloat  := itemCalcMar.ITE_COMTBL;
    cdsVendaTmp.FieldByName('ITE_IMPFED').AsFloat  := itemCalcMar.ITE_IMPFED;
    cdsVendaTmp.FieldByName('ITE_OUTVAL').AsFloat  := itemCalcMar.ITE_OUTVAL;
    cdsVendaTmp.FieldByName('ITE_DESOPE').AsFloat  := itemCalcMar.ITE_DESOPE;
    cdsVendaTmp.FieldByName('ITE_TAXJUR').AsFloat  := ItemCalcMar.ITE_TAXJUR;

    cdsVendaTmp.FieldByName('ITE_VAL_ST').AsFloat  := ItemCalcMar.ITE_VAL_ST;
    cdsVendaTmp.FieldByName('ITE_VALFCP').AsFloat  := ItemCalcMar.ITE_VALFCP;
    cdsVendaTmp.FieldByName('ITE_VALIPI').AsFloat  := ItemCalcMar.ITE_VALIPI;
    cdsVendaTmp.FieldByName('ITE_IPISAI').AsFloat  := ItemCalcMar.ITE_IPISAI;
    cdsVendaTmp.FieldByName('ITE_ALQICM').AsFloat  := ItemCalcMar.ITE_ALQICM;
    cdsVendaTmp.FieldByName('ITE_BASICM').AsFloat  := ItemCalcMar.ITE_BASICM;
    cdsVendaTmp.FieldByName('ITE_VALICM').AsFloat  := ItemCalcMar.ITE_VALICM;
    cdsVendaTmp.FieldByName('ITE_TOTCU2').AsFloat  := ItemCalcMar.ITE_TOTCU2;
    cdsVendaTmp.FieldByName('ITE_BASRET').AsFloat  := ItemCalcMar.ITE_BASRET;
    cdsVendaTmp.FieldByName('ITE_VALRET').AsFloat  := ItemCalcMar.ITE_VALRET;
    cdsVendaTmp.FieldByName('ABF_CODFIS').AsString := ItemCalcMar.ABF_CODFIS;
    cdsVendaTmp.FieldByName('ITE_VDIFAL').AsFloat  := ItemCalcMar.ITE_VDIFAL;
    cdsVendaTmp.FieldByName('ITE_ICMSAI').AsFloat  := ItemCalcMar.ITE_ICMSAI;
    cdsVendaTmp.FieldByName('ITE_ICMCAL').AsFloat  := ItemCalcMar.ITE_ICMCAL;
    cdsVendaTmp.FieldByName('ITE_RICMPR').AsString := ItemCalcMar.ITE_RICMPR;
    cdsVendaTmp.FieldByName('ITE_PERRIC').AsFloat  := ItemCalcMar.ITE_PERRIC;

    cdsVendaTmp.FieldByName('ITE_VDIFAL_MARGEM').Value                 := ItemCalcMar.ITE_VDIFAL_MARGEM;
    cdsVendaTmp.FieldByName('ITE_ALQDIF_ICMS_MARGEM').Value            := ItemCalcMar.ITE_ALQDIF_ICMS_MARGEM;
    cdsVendaTmp.FieldByName('ITE_ALQDIF_ICMS_MARGEM_IMPOSTOS').Value   := ItemCalcMar.ITE_ALQDIF_ICMS_MARGEM_IMPOSTOS;
    cdsVendaTmp.FieldByName('ITE_CODFIS_MARGEM').Value                 := ItemCalcMar.ITE_CODFIS_MARGEM;
    cdsVendaTmp.FieldByName('ITE_CODABF_MARGEM').Value                 := ItemCalcMar.ITE_CODABF_MARGEM;
    cdsVendaTmp.FieldByName('ITE_VALFCP_MARGEM').Value                 := ItemCalcMar.ITE_VALFCP_MARGEM;
    cdsVendaTmp.FieldByName('ITE_CALMAR_PREDIN_MAR_MARGEM').Value      := ItemCalcMar.ITE_CALMAR_PREDIN_MAR_MARGEM;
    cdsVendaTmp.FieldByName('ITE_CALMAR_PREDIN_MARLIQ_MARGEM').Value   := ItemCalcMar.ITE_CALMAR_PREDIN_MARLIQ_MARGEM;
    cdsVendaTmp.FieldByName('ITE_UTILIZA_PRECO_EM_DOLAR_MARGEM').Value := ItemCalcMar.ITE_UTILIZA_PRECO_EM_DOLAR_MARGEM;

    cdsVendaTmp.Post;

    cdsItens.Append;
    fatVenda.pPrepararDataSetParaCalculoDaMargem(cdsItens,
                                                 cdsVendaTmp,
                                                 True,
                                                 True,
                                                 False,
                                                 0,
                                                 False);

    fatVenda.pCalcularEPreencherMargemDataSet(cdsItens, False);
    cdsItens.Post;
  Finally
    FreeAndNil(cdsVendaTmp);
  End;
end;

procedure TfrmFatMostraMargemNovo.pAdicionarTinta(const tintaDeMaquina: ITintaDeMaquina);

  Var
    intCont: Integer;
    fltFatorUniOri : Double;
    fltFatorPreUlt : Double;
    recForTin : TForTin;

  function fGetSaldoTinta(strCodIte: String): Double;
    Var
      intCnt : Integer;
  begin
    Result := 0;

    If Assigned(recForTin.Formulas) Then
    Begin
      For intCnt := 0 To recForTin.Formulas.Count -1 Do
      Begin
        If SameText(recForTin.Formulas[intCnt].strCodIte, strCodIte) Then
        Begin
          Result := recForTin.Formulas[intCnt].fltSaldoML;
          Break;
        End;
      End;
    End;
  end;

begin
  If Not Assigned(tintaDeMaquina) then
    Exit;

  fltFatorUniOri := 0;
  fltFatorPreUlt := 0;
  FillChar(recForTin, SizeOf(TForTin), #0);

  If Assigned(fatVenda) And Assigned(cdsItensTinta) And (cdsItensTinta.FieldByName('ITE_IDEPRO').AsString <> 'NOR') Then
  Begin
    recForTin.Formulas :=
      TClassMatrizSaldosColorantes(fatVenda.dicFormulas.RetornaObjeto(cdsItensTinta.FieldByName('AUTOINCREM').AsString));
  End;

  If Assigned(cdsItensTinta) And (fFormataFloat(cdsItensTinta.FieldByName('ITE_UNITAR').AsFloat, intDecUni) <> 0) Then
  Begin
    fltFatorUniOri := cdsItensTinta.FieldByName('ITE_UNIORI').AsFloat / cdsItensTinta.FieldByName('ITE_UNITAR').AsFloat;
    fltFatorPreUlt := cdsItensTinta.FieldByName('ITE_PREULT').AsFloat / cdsItensTinta.FieldByName('ITE_UNITAR').AsFloat;
  End;

  For intCont := 0 To tintaDeMaquina.Count - 1 Do
  Begin
    cdsItens.Append;
    cdsItens.FieldByName('ITE_DESTIN').AsString := tintaDeMaquina.Descricao;
    cdsItens.FieldByName('ITE_TIPTMQ').AsString := fGetTipoAsString(tintaDeMaquina[intCont].Tipo);
    cdsItens.FieldByName('ITE_CODITE').AsString := tintaDeMaquina[intCont].CodIte;
    cdsItens.FieldByName('ITE_DESITE').AsString := tintaDeMaquina[intCont].Descricao;
    cdsItens.FieldByName('ITE_CODFAB').AsString := fRetCodFabrica(tintaDeMaquina[intCont].CodIte);
    cdsItens.FieldByName('ITE_SIGUNI').AsString := fRetSiglaUnidadePorCodIte(tintaDeMaquina[intCont].CodIte);
    cdsItens.FieldByName('ITE_DESMAR').AsString := fRetNomMarcaItem(tintaDeMaquina[intCont].CodIte);

    If tintaDeMaquina[intCont].Tipo = tmctEmbalagemAutomotiva Then
      cdsItens.FieldByName('ITE_QTDITE').AsFloat := tintaDeMaquina[intCont].Quantidade
    Else
      cdsItens.FieldByName('ITE_QTDITE').AsFloat := tintaDeMaquina[intCont].Quantidade * tintaDeMaquina.Quantidade;

    cdsItens.FieldByName('ITE_SALDOS').AsFloat := fGetSaldoTinta(tintaDeMaquina[intCont].CodIte);
    cdsItens.FieldByName('ITE_UNITAR').AsFloat := tintaDeMaquina[intCont].PrecoVenda * tintaDeMaquina.Quantidade;
    cdsItens.FieldByName('ITE_UNIORI').AsFloat := cdsItens.FieldByName('ITE_UNITAR').AsFloat * fltFatorUniOri;
    cdsItens.FieldByName('ITE_PERDES').AsFloat := fFormataFloat(((cdsItens.FieldByName('ITE_UNIORI').AsFloat - cdsItens.FieldByName('ITE_UNITAR').AsFloat)/cdsItens.FieldByName('ITE_UNIORI').AsFloat)*100, 2);
    cdsItens.FieldByName('ITE_CUSITE').AsFloat := tintaDeMaquina[intCont].PrecoCusto * tintaDeMaquina.Quantidade;
    cdsItens.FieldByName('ITE_PRECUS').AsFloat := tintaDeMaquina[intCont].PrecoCustoReal * tintaDeMaquina.Quantidade;
    cdsItens.FieldByName('ITE_RESULT').AsFloat := cdsItens.FieldByName('ITE_UNITAR').AsFloat - cdsItens.FieldByName('ITE_PRECUS').AsFloat;
    cdsItens.FieldByName('ITE_PREMED').AsFloat := tintaDeMaquina[intCont].PrecoMedio * tintaDeMaquina.Quantidade;
    cdsItens.FieldByName('ITE_PREULT').AsFloat := cdsItens.FieldByName('ITE_UNITAR').AsFloat * fltFatorPreUlt;
    cdsItens.FieldByName('ITE_OUTVAL').AsFloat := tintaDeMaquina[intCont].OutrosValores * tintaDeMaquina.Quantidade;
    cdsItens.FieldByName('ITE_ICMSAI').AsFloat := tintaDeMaquina[intCont].IcmsSaida * tintaDeMaquina.Quantidade;
    cdsItens.FieldByName('ITE_IMPFED').AsFloat := tintaDeMaquina[intCont].ImpostosFederais * tintaDeMaquina.Quantidade;
    cdsItens.FieldByName('ITE_DESOPE').AsFloat := tintaDeMaquina[intCont].DespesasOperacionais * tintaDeMaquina.Quantidade;
    cdsItens.FieldByName('ITE_IMPULT').AsFloat := tintaDeMaquina[intCont].UltimoPrecoCompraImpostos * tintaDeMaquina.Quantidade;

    If Assigned(fatVenda) Then
    Begin
      cdsItens.FieldByName('ITE_CUSIMP').AsFloat     := objAdicionarTinta.fRetornaPrecoCustoRealSub(cdsItens.FieldByName('ITE_IMPULT').AsFloat, cdsItens.FieldByName('ITE_UNITAR').AsFloat, cdsItens, fatVenda);
      cdsItens.FieldByName('ITE_PREMED_LIQ').AsFloat := objAdicionarTinta.fRetornaPrecoCustoRealSub(cdsItens.FieldByName('ITE_PREMED').AsFloat, cdsItens.FieldByName('ITE_UNITAR').AsFloat, cdsItens, fatVenda);
      cdsItens.FieldByName('ITE_PREULT_LIQ').AsFloat := objAdicionarTinta.fRetornaPrecoCustoRealSub(cdsItens.FieldByName('ITE_PREULT').AsFloat, cdsItens.FieldByName('ITE_UNITAR').AsFloat, cdsItens, fatVenda);
    End;

    cdsItens.FieldByName('ITE_MARPRO_CUSITE').AsFloat := objAdicionarTinta.RetornarValorMargemPropostaCustoDoItem(cdsItens);
    cdsItens.FieldByName('ITE_MARPRA_CUSITE').AsFloat := objAdicionarTinta.RetornarValorMargemPraticadaCustoDoItem(cdsItens);
    cdsItens.FieldByName('ITE_MARPRO_PRECUS').AsFloat := objAdicionarTinta.RetornarValorMargemPropostaPrecoDeCusto(cdsItens);
    cdsItens.FieldByName('ITE_MRPRBT_PRECUS').AsFloat := objAdicionarTinta.RetornarValorMargemPraticadaPrecoDeCustoBruta(cdsItens);
    cdsItens.FieldByName('ITE_MARPRA_PRECUS').AsFloat := objAdicionarTinta.RetornarValorMargemPraticadaPrecoDeCusto(cdsItens);
    cdsItens.FieldByName('ITE_MARBRU_PREMED').AsFloat := objAdicionarTinta.RetornarValorMargemBrutaPrecoMedio(cdsItens);
    cdsItens.FieldByName('ITE_MRPRBT_PREMED').AsFloat := objAdicionarTinta.RetornarValorMargemLiquidaPrecoMedioBruta(cdsItens);
    cdsItens.FieldByName('ITE_MARLIQ_PREMED').AsFloat := objAdicionarTinta.RetornarValorMargemLiquidaPrecoMedio(cdsItens);
    cdsItens.FieldByName('ITE_MARBRU_PREULT').AsFloat := objAdicionarTinta.RetornarValorMargemBrutaPrecoDeUltimaCompra(cdsItens);
    cdsItens.FieldByName('ITE_MARLIQ_PREULT').AsFloat := objAdicionarTinta.RetornarValorMargemLiquidaPrecoDeUltimaCompra(cdsItens);
    cdsItens.FieldByName('ITE_MARBRU_IMPULT').AsFloat := objAdicionarTinta.RetornarValorMargemBrutaPrecoDeUltimaCompraComImpostos(cdsItens);
    cdsItens.FieldByName('ITE_MARLIQ_IMPULT').AsFloat := objAdicionarTinta.RetornarValorMargemLiquidaPrecoDeUltimaCompraComImpostos(cdsItens);

    cdsItens.Post;
  End;
end;

procedure TfrmFatMostraMargemNovo.pAdicionaTravasMinimas;
begin
  if not fHabilitaBandTravasMinimas then
    Exit;

  try
    fatVenda.fVerificaVrMinimo(fatVenda.fltTotGer,
                               fatVenda.fltTotGer,
                               fatVenda.intPrzMed,
                               '',
                               False,
                               False);

    cdsItens.DisableControls;

    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      if (not fatVenda.cdsTravaMinima.Locate('AUTINC', cdsItens.FieldByName('AUTOINCREM').AsString, [])) then
      begin
        cdsItens.Next;
        Continue;
      end;

      cdsItens.Edit;

      if SameText(VS_strTRADES, '2') then
      begin
        if fVerificaAcessoSistema('VEMIN6', fOperadorAcesso) then
        begin
          cdsItens.FieldByName('TRM_DESMAX').AsFloat := fatVenda.cdsTravaMinima.FieldByName('DEMAGM').AsFloat;
          cdsItens.FieldByName('TRM_VLRMIN').AsFloat := fatVenda.cdsTravaMinima.FieldByName('VLMIGM').AsFloat;
          cdsItens.FieldByName('TRM_TOTMIN').AsFloat := fatVenda.cdsTravaMinima.FieldByName('TOTVLMIGM').AsFloat;
        end
        else if fVerificaAcessoSistema('VEMIN2', fOperadorAcesso) then
        begin
          cdsItens.FieldByName('TRM_DESMAX').AsFloat := fatVenda.cdsTravaMinima.FieldByName('DEMAXG').AsFloat;
          cdsItens.FieldByName('TRM_VLRMIN').AsFloat := fatVenda.cdsTravaMinima.FieldByName('VLMING').AsFloat;
          cdsItens.FieldByName('TRM_TOTMIN').AsFloat := fatVenda.cdsTravaMinima.FieldByName('TOTVLMING').AsFloat;
        end
        else if fVerificaAcessoSistema('VEMIN5', fOperadorAcesso) then
        begin
          cdsItens.FieldByName('TRM_DESMAX').AsFloat := fatVenda.cdsTravaMinima.FieldByName('DEMASM').AsFloat;
          cdsItens.FieldByName('TRM_VLRMIN').AsFloat := fatVenda.cdsTravaMinima.FieldByName('VLMISM').AsFloat;
          cdsItens.FieldByName('TRM_TOTMIN').AsFloat := fatVenda.cdsTravaMinima.FieldByName('TOTVLMISM').AsFloat;
        end
        else if fVerificaAcessoSistema('VEMIN', fOperadorAcesso) then
        begin
          cdsItens.FieldByName('TRM_DESMAX').AsFloat := fatVenda.cdsTravaMinima.FieldByName('DEMAXS').AsFloat;
          cdsItens.FieldByName('TRM_VLRMIN').AsFloat := fatVenda.cdsTravaMinima.FieldByName('VLMINS').AsFloat;
          cdsItens.FieldByName('TRM_TOTMIN').AsFloat := fatVenda.cdsTravaMinima.FieldByName('TOTVLMINS').AsFloat;
        end
        else if fVerificaAcessoSistema('VEMIN4', fOperadorAcesso) then
        begin
          cdsItens.FieldByName('TRM_DESMAX').AsFloat := fatVenda.cdsTravaMinima.FieldByName('DEMAVM').AsFloat;
          cdsItens.FieldByName('TRM_VLRMIN').AsFloat := fatVenda.cdsTravaMinima.FieldByName('VLMIVM').AsFloat;
          cdsItens.FieldByName('TRM_TOTMIN').AsFloat := fatVenda.cdsTravaMinima.FieldByName('TOTVLMIVM').AsFloat;
        end
        else
        begin
          cdsItens.FieldByName('TRM_DESMAX').AsFloat := fatVenda.cdsTravaMinima.FieldByName('DEMAXV').AsFloat;
          cdsItens.FieldByName('TRM_VLRMIN').AsFloat := fatVenda.cdsTravaMinima.FieldByName('VLMINV').AsFloat;
          cdsItens.FieldByName('TRM_TOTMIN').AsFloat := fatVenda.cdsTravaMinima.FieldByName('TOTVLMINV').AsFloat;
        end;
      end
      else
      begin
        if fVerificaAcessoSistema('VEMIN6', fOperadorAcesso) then
        begin
          cdsItens.FieldByName('TRM_DESMAX').AsFloat := fatVenda.cdsTravaMinima.FieldByName('MRMNGM').AsFloat;
          cdsItens.FieldByName('TRM_VLRMIN').AsFloat := fatVenda.cdsTravaMinima.FieldByName('VLMINGM').AsFloat;
          cdsItens.FieldByName('TRM_TOTMIN').AsFloat := fatVenda.cdsTravaMinima.FieldByName('TOTVLMINGM').AsFloat;
        end
        else if fVerificaAcessoSistema('VEMIN2', fOperadorAcesso) then
        begin
          cdsItens.FieldByName('TRM_DESMAX').AsFloat := fatVenda.cdsTravaMinima.FieldByName('MRMING').AsFloat;
          cdsItens.FieldByName('TRM_VLRMIN').AsFloat := fatVenda.cdsTravaMinima.FieldByName('VLMING_').AsFloat;
          cdsItens.FieldByName('TRM_TOTMIN').AsFloat := fatVenda.cdsTravaMinima.FieldByName('TOTVLMING_').AsFloat;
        end
        else if fVerificaAcessoSistema('VEMIN5', fOperadorAcesso) then
        begin
          cdsItens.FieldByName('TRM_DESMAX').AsFloat := fatVenda.cdsTravaMinima.FieldByName('MRMNSM').AsFloat;
          cdsItens.FieldByName('TRM_VLRMIN').AsFloat := fatVenda.cdsTravaMinima.FieldByName('VLMINSM').AsFloat;
          cdsItens.FieldByName('TRM_TOTMIN').AsFloat := fatVenda.cdsTravaMinima.FieldByName('TOTVLMINSM').AsFloat;
        end
        else if fVerificaAcessoSistema('VEMIN', fOperadorAcesso) then
        begin
          cdsItens.FieldByName('TRM_DESMAX').AsFloat := fatVenda.cdsTravaMinima.FieldByName('MRMINS').AsFloat;
          cdsItens.FieldByName('TRM_VLRMIN').AsFloat := fatVenda.cdsTravaMinima.FieldByName('VLMINS_').AsFloat;
          cdsItens.FieldByName('TRM_TOTMIN').AsFloat := fatVenda.cdsTravaMinima.FieldByName('TOTVLMINS_').AsFloat;
        end
        else if fVerificaAcessoSistema('VEMIN4', fOperadorAcesso) then
        begin
          cdsItens.FieldByName('TRM_DESMAX').AsFloat := fatVenda.cdsTravaMinima.FieldByName('MRMNVM').AsFloat;
          cdsItens.FieldByName('TRM_VLRMIN').AsFloat := fatVenda.cdsTravaMinima.FieldByName('VLMINVM').AsFloat;
          cdsItens.FieldByName('TRM_TOTMIN').AsFloat := fatVenda.cdsTravaMinima.FieldByName('TOTVLMINVM').AsFloat;
        end
        else
        begin
          cdsItens.FieldByName('TRM_DESMAX').AsFloat := fatVenda.cdsTravaMinima.FieldByName('MRMINV').AsFloat;
          cdsItens.FieldByName('TRM_VLRMIN').AsFloat := fatVenda.cdsTravaMinima.FieldByName('VLMINV_').AsFloat;
          cdsItens.FieldByName('TRM_TOTMIN').AsFloat := fatVenda.cdsTravaMinima.FieldByName('TOTVLMINV_').AsFloat;
        end;
      end;
      recTotMarLuc.fltTotalTravaMinima := recTotMarLuc.fltTotalTravaMinima + cdsItens.FieldByName('TRM_TOTMIN').AsFloat;
      recTotMarLucTotIte.fltTotalTravaMinima := recTotMarLucTotIte.fltTotalTravaMinima + cdsItens.FieldByName('TRM_TOTMIN').AsFloat;
      cdsItens.Post;
      cdsItens.Next;
    end;

    if SameText(VS_strTRADES, '2') then
      cxgItensViewITE_DESMAX.Caption := 'Desc. Max.'
    else
      cxgItensViewITE_DESMAX.Caption := 'Marg. Max.';

    cxgItensViewITE_VLRMIN.Caption := 'Vlr. Min.';
    cxgItensViewITE_TOTMIN.Caption := 'Vlr. Tot. Min.';

    (cdsItens.FieldByName('TRM_DESMAX') As TFloatField).DisplayFormat := '#,##0.00 %';
    (cdsItens.FieldByName('TRM_VLRMIN') As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
    (cdsItens.FieldByName('TRM_TOTMIN') As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
  finally
    cdsItens.EnableControls;
  end;
end;

procedure TfrmFatMostraMargemNovo.pAfterPost(DataSet: TDataSet);
  Var
    intRecNo: Integer;
begin
  If blnRecalculandoItens Then
    Exit;

  With DataSet Do
  Begin
    If (Not blnCanculandoTotal) Then
    Begin
      DisableControls;
      blnCanculandoTotal := True;
      intRecNo := DataSet.RecNo;
      pCalcularTotais(cdsItens.Data);
      DataSet.RecNo := intRecNo;
      blnCanculandoTotal := False;
      EnableControls;
    End;
  End;
end;

procedure TfrmFatMostraMargemNovo.pAfterScroll(DataSet: TDataSet);
  Var
    strCodIte: String;
    strCodCli: String;
    dtaDtaEnt : TDateTime;
    fltQtdIte : Double;
    fltTotIte : Double;
    fltUnitar : Double;
    fltDesEspIte : Double;
    recInfVen : TRecInfVen;

    function fExibeUltimaVenda: Boolean;
    begin
      Result := (pnlTotais.Visible) And (gpbUltVen.Visible);
    end;
begin
  If blnRecalculandoItens Then
    Exit;

  blnSomenteUnitarioAcimaDoSugerido := False;

  If Not blnCanculandoTotal Then
    cxgItensView.OptionsData.Editing := Not fEmptyStr(DataSet.FieldByName('ITE_CODITE').AsString);

  blnPermiteEditarPrecoUnitario := False;

  If not blnOcultaBotoes Then
  Begin
    If Assigned(fatVenda) Then
      With fatVenda, DataSet Do
        blnPermiteEditarPrecoUnitario :=
          fPermiteEditarPrecoUnitario( strOpcDoc, strCodCnd, strCodCli,
                                       FieldByName('ITE_PROMOC').AsString,
                                       FieldByName('ITE_TABPRE').AsString, True,
                                       FieldByName('ITE_CODITE').AsString = fCfgSis('ITEVID'),
                                       fEhDevolucaoEspelhoOuParaFornecedor,
                                       blnSomenteUnitarioAcimaDoSugerido );

    If (fRealizandoConfirmacao(False)) Or (Not fPermiteDesconto) Or
       (Self.blnTintaDeMaquina) Or (Self.blnApenasVisualizacao) Then
      blnPermiteEditarPrecoUnitario := False;
  End
  Else
    cxgItensView.OptionsData.Editing := False;

  cxgItensView.SetColumnEditing('ITE_PERDES', blnPermiteEditarPrecoUnitario );
  cxgItensView.SetColumnEditing('ITE_UNITAR', blnPermiteEditarPrecoUnitario );
  cxgItensView.SetColumnEditing('ITE_UNIDIG', blnPermiteEditarPrecoUnitario And blnPodeEditarPrecoUnitario);
  cxgItensView.SetColumnEditing('ITE_MARPRA_PRECUS', (blnPermiteEditarPrecoUnitario) And (fatVenda.strOpcDoc <> 'CF'));
  cxgItensView.SetColumnEditing('ITE_MARPRA_CUSITE', (blnPermiteEditarPrecoUnitario) And (fatVenda.strOpcDoc <> 'CF'));
  cxgItensView.SetColumnEditing('SELECIONADO', True);

  With DataSet Do
  Begin
    lblProVen.Visible := (FieldByName('ITE_PROMOC').AsString = 'S');
    edtProVen.Visible := (FieldByName('ITE_PROMOC').AsString = 'S');
    edtProVen.Text    := FloatToStrF(FieldByName('ITE_PROVEN').AsFloat, ffNumber, 12, 2);

    strCodIte := FieldByName('ITE_CODITE').AsString;

    If (Not dicInfVen.ContainsKey(strCodIte)) And (fExibeUltimaVenda) Then
    Begin
      If Not Assigned(fatVenda) Then
        strCodCli := ''
      Else
        strCodCli := fatVenda.strCodCli;

      pInfoUltimaVendaProduto(dtaDtaEnt,
                              fltQtdIte,
                              fltTotIte,
                              fltDesEspIte,
                              fltUnitar,
                              strCodIte,
                              strCodCli);

      recInfVen.dtaDtaEnt := dtaDtaEnt;
      recInfVen.fltQtdIte := fltQtdIte;
      recInfVen.fltTotIte := fltTotIte;
      recInfVen.fltDesEsp := fltDesEspIte;
      recInfVen.fltUnitar := fltUnitar;

      dicInfVen.Add(strCodIte, recInfVen);
    End;

    If (Not fEmptyStr(strCodIte)) And (fExibeUltimaVenda) Then
    Begin
      edtDtaVen.Text := IIF(dicInfVen[strCodIte].dtaDtaEnt > 0, FormatDateTime('dd/MM/yyyy', dicInfVen[strCodIte].dtaDtaEnt), '');
      edtQtdVen.Text := FormatFloat(fMskDigitos(2),  dicInfVen[strCodIte].fltQtdIte);
      edtUnitar.Text := FormatFloat(fMskDigitos(2),  dicInfVen[strCodIte].fltUnitar);
      edtTotVen.Text := FormatFloat(fMskDigitos(2),  dicInfVen[strCodIte].fltTotIte - dicInfVen[strCodIte].fltDesEsp);
    End
    Else
    Begin
      edtDtaVen.Text := '';
      edtQtdVen.Text := '';
      edtUnitar.Text := '';
      edtTotVen.Text := '';
    End;
  End;

  btnUltCompraEmp.Enabled := Not fEmptyStr(strCodIte);

  If blnOcultaBotoes Then
  Begin
    cxgItensView.OptionsData.Editing := False;
    blnPermiteEditarPrecoUnitario := False;
  End;
end;

function TfrmFatMostraMargemNovo.fAplicarDesconto(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strTRVEPRbkp: String;
    prcScroll: TprcScroll;
begin
  {*********************************************}
  {* ALTERA TEMPORARIAMENTE PARA NÃO SOLICITAR *}
  {* LIBERAÇÃO ITEM A ITEM (fValidaUnitario)   *}
  {*REQ*153878*******************************RP*}
  strTRVEPRbkp := VS_strTRVEPR;
  VS_strTRVEPR := '2';
  Result := True;

  Try
    pDisableControls(cdsItens, prcScroll);
    pgbProgresso.Properties.Max := cdsComDes.RecordCount;

    cdsComDes.First;
    While Not cdsComDes.Eof Do
    Begin
      pStepStatusGravacao(pgbProgresso);

      If not fEmptyStr(cdsComDes.FieldByName('AUTOINCREM').AsString) Then
      Begin
        If (fItemEntraRateio(cdsComDes.FieldByName('ITE_PROMOC').AsString, cdsComDes)) And
           (cdsItens.Locate('AUTOINCREM', cdsComDes.FieldByName('AUTOINCREM').AsString, [])) Then
        Begin
          Try
            cxgItensView.SetColumnIndex('ITE_UNITAR');
            cdsItens.Edit;
            cdsItens.FieldByName('ITE_UNITAR').AsFloat := cdsComDes.FieldByName('ITE_UNITAR').AsFloat;
            cdsItens.Post;
          Except
            On E: EAbort Do
            Begin
              //Deve continuar o processamento dos produtos
            End;
            On E: Exception Do
            Begin
              pMensagensErro(E.Message, '');
            End;
          End;
        End;
      End;

      cdsComDes.Next;
    End;
  Finally
    pEnableControls(cdsItens, prcScroll);
    VS_strTRVEPR := strTRVEPRbkp; //Restaura a trava configurada originalmente
  End;
end;

procedure TfrmFatMostraMargemNovo.pAtualizaLiberacaoUnitario(stlAutInc: TStringList);
  Var
    prcScroll: TprcScroll;
    strIncIni : String;
    intCnt : Integer;
begin
  If Not Assigned(fatVenda) Then
    Exit;

  With fatVenda Do
  Begin
    Try
      strIncIni := cdsVenda.FieldByName('AUTOINCREM').AsString;
      pDisableControls(cdsVenda, prcScroll);

      For intCnt := 0 To stlAutInc.Count-1 Do
      Begin
        If cdsVenda.Locate('AUTOINCREM', stlAutInc[intCnt], []) Then
        Begin
          cdsVenda.Edit;
          cdsVenda.FieldByName('ITE_LIBUNI').AsString := 'S';
          cdsVenda.Post;
        End;
      End;

      cdsVenda.Locate('AUTOINCREM', strIncIni, []);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmFatMostraMargemNovo.pAtualizaLiberacaoUnitario]');
    End;

    pEnableControls(cdsVenda, prcScroll);
  End;
end;

function TfrmFatMostraMargemNovo.fHabilitaBandTravasMinimas: Boolean;
begin
  Result := False;

  If (Not Assigned(fatVenda)) Then
    Exit;

  if Self.blnTintaDeMaquina then
    Exit;

  if ((fEmptyStr(strExMaF4)) or (Length(strExMaF4) < 10)) then
    Exit;

  if (strExMaF4[10] = 'N') then
    Exit;

  if (not TMostraTravaMinimaHelper.fExibeTravaMinima) or fVerificaAcessoSistema('VEMIN3', fOperadorAcesso) then // Nivel 3 - Diretoria
    Exit;

  if not fCfgSis('VMNSEM', varBoolean) and
    not fVerificaAcessoSistema('VEMIN', fOperadorAcesso)  and
    not fVerificaAcessoSistema('VEMIN2', fOperadorAcesso) and
    not fVerificaAcessoSistema('VEMIN3', fOperadorAcesso) and
    not fVerificaAcessoSistema('VEMIN4', fOperadorAcesso) and
    not fVerificaAcessoSistema('VEMIN5', fOperadorAcesso) and
    not fVerificaAcessoSistema('VEMIN6', fOperadorAcesso) then
    Exit;

  Result := True;
end;

procedure TfrmFatMostraMargemNovo.pBeforeEdit(DataSet: TDataSet);
begin
  cdsDados.Data := cdsItens.Data;
  cdsDados.LogChanges := False;

  fltUnitarAnt := DataSet.FieldByName('ITE_UNITAR').AsFloat;
  fltUniDigAnt := DataSet.FieldByName('ITE_UNIDIG').AsFloat;
  fltPreCusAnt := DataSet.FieldByName('ITE_PRECUS').AsFloat;
  fltMarPraCusIteAnt := DataSet.FieldByName('ITE_MARPRA_CUSITE').AsFloat;
  fltMarPraPreCusAnt := DataSet.FieldByName('ITE_MARPRA_PRECUS').AsFloat;
end;

procedure TfrmFatMostraMargemNovo.pBeforePost(DataSet: TDataSet);
  Var
    fltUnitar: Double;
    fltUniLiq: Double;

   Procedure pPosicionaItem;
   Begin
     With DataSet Do
     Begin
       //Precisamos posicionar a temporaria da venda para atualizar as variaveis utilizadas na trava de Preco
       pPosicionarRegistroVenda(DataSet);

       //Variavies utilizadas na trava de preco
       fatVenda.strIdePro := cdsVenda.FieldByName('ITE_IDEPRO').AsString;
       fatVenda.fltCusIte := cdsVenda.FieldByName('ITE_CUSITE').AsFloat;
       fatVenda.fltPreCus := cdsVenda.FieldByName('ITE_PRECUS').AsFloat;
       fatVenda.fltIcmSai := cdsVenda.FieldByName('ITE_ICMSAI').AsFloat;
       fatVenda.fltImpFed := cdsVenda.FieldByName('ITE_IMPFED').AsFloat;
       fatVenda.fltOutVal := cdsVenda.FieldByName('ITE_OUTVAL').AsFloat;
       fatVenda.fltDesOpe := cdsVenda.FieldByName('ITE_DESOPE').AsFloat;
       fatVenda.fltPreCu2 := cdsVenda.FieldByName('ITE_PRECU2').AsFloat;
       fatVenda.fltPreVe1 := cdsVenda.FieldByName('ITE_PREVE1').AsFloat;
       fatVenda.fltPreVe2 := cdsVenda.FieldByName('ITE_PREVE2').AsFloat;
       fatVenda.fltPreVe3 := cdsVenda.FieldByName('ITE_PREVE3').AsFloat;
       fatVenda.fltPreVe4 := cdsVenda.FieldByName('ITE_PREVE4').AsFloat;
       fatVenda.fltPreVe5 := cdsVenda.FieldByName('ITE_PREVE5').AsFloat;
       fatVenda.fltPreVe6 := cdsVenda.FieldByName('ITE_PREVE6').AsFloat;
       fatVenda.fltPreVe7 := cdsVenda.FieldByName('ITE_PREVE7').AsFloat;

       pPesquisaCadSem(fatVenda.qryConCit, fatVenda.qryConCit, FieldByName('ITE_CODITE').AsString, '',
                       False{blnBuscaCodBar}, False);

       fatVenda.qryConIte.Close;
       fatVenda.qryConIte.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
       fatVenda.qryConIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
       fatVenda.qryConIte.Open;
     End;
   End;

   function fValidaMargem(strCampoMargem: String): Double;
   Begin
     Result := objBeforePost.RetornarPercentualDaMargem(cdsItens, fatVenda, strCampoMargem);
   End;

   Function fValorSuperiorAoUnitarioMaximo : Boolean;
     Var
       fltVlrFtr,
       fltFator : Double;
   Begin
    Result   := True;
    fltFator := fCfgSis('FTPRVE', varDouble);
    If (fltFator > 0) Then
    Begin
      fltVlrFtr := DataSet.FieldByName('ITE_UNIORI').AsFloat * fltFator;
      If (fltUnitar > fltVlrFtr) Then
        Result := False;
    End;
  End;

  function fUnitarioMinimo: Double;
  begin
    With DataSet Do
    Begin
      Result := fatVenda.fUnitarioMinimo(FieldByName('ITE_CODITE').AsString,
                                         IIF(blnTabPreIte, FieldByName('ITE_TABPRE').AsString, fatVenda.strTabPre),
                                         FieldByName('ITE_QTDITE').AsFloat,
                                         FieldByName('ITE_UNIORI').AsFloat);
    End;
  end;

  procedure pAlteracaoCampoMargem(strCampoMargem: String; fltValorAnt: Double; DataSet: TDataSet);
    Var
      fltUniLiq: Double;
  begin
    With DataSet Do
    Begin
      If (fltValorAnt <> FieldByName(strCampoMargem).AsFloat) Then
      Begin

        If (fCfgSis('MARMKP') = '1') Then
        Begin
          If (FieldByName(strCampoMargem).AsFloat >= 100) Then
          Begin
            fMensagem('ATENÇÃO!', 'Margem não permitida: maior ou igual a 100!', ['&Ok']);
            Cancel;
            Abort;
          End
          Else If fValidaMargem(strCampoMargem) >= 100 Then
          Begin
            fMensagem('ATENÇÃO', 'A soma do ( ICMS Saída + Impostos Federais + Despesas Operacionais + Margem Bruta ' + IIF(fCfgSis('PCMPRO') <> '1',IIF(fCfgSis('PCMPRO') = '2', '+ Comissão ','+ ' + fCfgSis('TCOMTB')),'')  + ' ) não pode ser maior ou igual 100%.', ['&Ok']);
            Cancel;
            Abort;
          End;
        End;

        pPosicionaItem;

        fltUnitar := objBeforePost.RetornarValorUnitario(DataSet, cdsItens, fatVenda, cdsVenda, strCampoMargem);

        If Not fValidaUnitario(DataSet, fltUnitar) Then
        Begin
          Cancel;
          Abort;
        End;

        FieldByName('ITE_UNITAR').AsFloat := fltUnitar;

        If blnUsaUniLiq And blnPodeEditarPrecoUnitario Then
        Begin
          FieldByName('ITE_UNIDIG').AsFloat := fCalculaUnitario(FieldByName('ITE_UNIDIG').AsFloat,
                                                                FieldByName('ITE_UNITAR').AsFloat,
                                                                FieldByName('ITE_TAXJUR').AsFloat,
                                                                fltUniLiq);
          FieldByName('ITE_UNITAR').AsFloat := fltUniLiq;
        End;

        FieldByName('ITE_PRECUS').AsFloat := objBeforePost.RetornarValorPrecoCusto(DataSet, cdsItens, fatVenda);

        If (FieldByName('ITE_VLCTVN').AsFloat > 0) And fItemUtilizaPrecoEmDolar(FieldByName('ITE_CODITE').AsString) Then
          FieldByName('ITE_UNIDOL').AsFloat := objBeforePost.RetornarValorUnitarioDolar(DataSet); //FieldByName('ITE_UNITAR').AsFloat / FieldByName('ITE_VLCTVN').AsFloat;

        pPosicionarRegistroVenda(DataSet);

        fatVenda.pPrepararDataSetParaCalculoDaMargem(cdsItens,
                                                     cdsVenda,
                                                     False,
                                                     True,
                                                     False,
                                                     0,
                                                     False);

        fatVenda.pCalcularEPreencherMargemDataSet(cdsItens, False);

        FieldByName('ITE_TOTITE').AsFloat := objBeforePost.RetornarValorTotalDoItem(DataSet, fatVenda);
      End;
    End;
  end;

begin
  Try

    With DataSet Do
    Begin
      If fEmptyStr(FieldByName('ITE_CODITE').AsString) Then
        Exit;

      {Desconto por item}
      if cxgItensView.ColumnSelected('ITE_PERDES') then
      begin
        If blnUsaUniLiq And blnPodeEditarPrecoUnitario Then
        Begin
          if (FieldByName('ITE_PERDES').AsFloat > 0) then
            FieldByName('ITE_UNIDIG').AsFloat := fFormataFloat(FieldByName('ITE_UNIORI').AsFloat - ((FieldByName('ITE_UNIORI').AsFloat * FieldByName('ITE_PERDES').AsFloat) / 100), fatVenda.VS_intDecUni)
          else
          if (FieldByName('ITE_PERDES').AsFloat = 0) then
            FieldByName('ITE_UNIDIG').AsFloat := FieldByName('ITE_UNIORI').AsFloat;

          FieldByName('ITE_UNITAR').AsFloat := fCalculaUnitarioLiquido(FieldByName('ITE_UNIDIG').AsFloat,
                                                                       FieldByName('ITE_TAXJUR').AsFloat);
        End
        Else
        Begin
          if (FieldByName('ITE_PERDES').AsFloat > 0) then
            FieldByName('ITE_UNITAR').AsFloat := fFormataFloat(FieldByName('ITE_UNIORI').AsFloat - ((FieldByName('ITE_UNIORI').AsFloat * FieldByName('ITE_PERDES').AsFloat) / 100), fatVenda.VS_intDecUni)
          else
          if (FieldByName('ITE_PERDES').AsFloat = 0) then
            FieldByName('ITE_UNITAR').AsFloat := FieldByName('ITE_UNIORI').AsFloat;
        End;
      end;

      If cxgItensView.ColumnSelected('ITE_UNIDIG') or cxgItensView.ColumnSelected('ITE_UNITAR') or cxgItensView.ColumnSelected('ITE_PERDES') Then
      Begin
        If blnUsaUniLiq Then
        Begin
          If cxgItensView.ColumnSelected('ITE_UNIDIG') And (fltUniDigAnt <> FieldByName('ITE_UNIDIG').AsFloat) Then
          Begin
            FieldByName('ITE_UNITAR').AsFloat := fCalculaUnitarioLiquido(FieldByName('ITE_UNIDIG').AsFloat,
                                                                         FieldByName('ITE_TAXJUR').AsFloat);
          End;

          If blnPodeEditarPrecoUnitario And cxgItensView.ColumnSelected('ITE_UNITAR') And (fltUnitarAnt <> FieldByName('ITE_UNITAR').AsFloat) Then
          Begin
            FieldByName('ITE_UNIDIG').AsFloat := fCalculaUnitario(FieldByName('ITE_UNIDIG').AsFloat,
                                                                  FieldByName('ITE_UNITAR').AsFloat,
                                                                  FieldByName('ITE_TAXJUR').AsFloat,
                                                                  fltUniLiq);
            FieldByName('ITE_UNITAR').AsFloat := fltUniLiq;
          End;
        End;

        If (fltUniDigAnt <> FieldByName('ITE_UNIDIG').AsFloat) Or (fltUnitarAnt <> FieldByName('ITE_UNITAR').AsFloat) Then
        Begin
          fltUnitar := FieldByName('ITE_UNITAR').AsFloat;

          If fltUnitar <= 0 Then
          Begin
            if fExibeMensagem then
            begin
              fMensagem('ATENÇÃO!', 'O Valor Unitário deve ser maior que Zero!', ['&O k']);
              blnExibiuMensagem := True;
            end;
            Cancel;
            Abort;
          End
          Else If (fatVenda.strOpcDoc = 'DV') And (FieldByName('ITE_UNIDEV').AsFloat > 0.0) Then
          Begin

            If fFormataFloat(fltUnitar, intDecUni) > fFormataFloat(FieldByName('ITE_UNIDEV').AsFloat, intDecUni) Then
            Begin
              fMensagem('ATENÇÃO!', 'O Unitário deve ser menor ou igual a ' + FloatToStr(FieldByName('ITE_UNIDEV').AsFloat) + '!', ['&O k']);
              Cancel;
              Abort;
            End;

          End;

          If (blnSomenteUnitarioAcimaDoSugerido) Then
          Begin
            If fFormataFloat(fltUnitar, intDecUni) < fFormataFloat(fUnitarioMinimo, intDecUni) Then
            Begin
              fMensagem('ATENÇÃO!', 'O Unitário deve ser maior ou igual a ' + FloatToStr(fFormataFloat(fUnitarioMinimo, intDecUni)) + '!', ['&OK']);
              Cancel;
              Abort;
            End;
          End;

          pPosicionaItem;

          If Not fValidaUnitario(DataSet, fltUnitar) Then
          Begin
            Cancel;
            Abort;
          End;

          If not (DataSet.State in [dsInsert, dsEdit]) Then
            DataSet.Edit;

          FieldByName('ITE_TOTITE').AsFloat := objBeforePost.RetornarValorTotalDoItem(DataSet, fatVenda);

          FieldByName('ITE_PRECUS').AsFloat := objBeforePost.RetornarValorPrecoCusto(DataSet, cdsItens, fatVenda, cdsDados);

          pPosicionarRegistroVenda(DataSet);



          fatVenda.pPrepararDataSetParaCalculoDaMargem(cdsItens, cdsVenda,
                                                       False, True, False, 0, False);

          fatVenda.pCalcularEPreencherMargemDataSet(cdsItens, False);

        End {If (fltUnitarAnt <> FieldByName('UNITAR').AsFloat) And...}

        Else Exit;

      End {If SameText(dbgItens.SelectedField.FieldName, 'UNITAR') Then}

      Else If cxgItensView.ColumnSelected('ITE_PRECUS') Then
      Begin

        If (fltPreCusAnt <> FieldByName('ITE_PRECUS').AsFloat) Then
        Begin
          If FieldByName('ITE_PRECUS').AsFloat <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'O Preço de Custo deve ser maior que Zero!', ['&O k']);
            Cancel;
            Abort;
          End;

          pPosicionaItem;

          pPosicionarRegistroVenda(DataSet);

          fatVenda.pPrepararDataSetParaCalculoDaMargem(cdsItens, cdsVenda,
                                                       False, True, False, 0, False);

          fatVenda.pCalcularEPreencherMargemDataSet(cdsItens, False);

        End

        Else Exit;

      End

      Else If cxgItensView.ColumnSelected('ITE_MARPRA_CUSITE') Then
        pAlteracaoCampoMargem('ITE_MARPRA_CUSITE', fltMarPraCusIteAnt, DataSet)
      Else If cxgItensView.ColumnSelected('ITE_MARPRA_PRECUS') Then
        pAlteracaoCampoMargem('ITE_MARPRA_PRECUS', fltMarPraPreCusAnt, DataSet)
      Else If cxgItensView.ColumnSelected('ITE_MARLIQ_PREMED') Then
        pAlteracaoCampoMargem('ITE_MARLIQ_PREMED', fltMarPraPreCusAnt, DataSet)
      Else If cxgItensView.ColumnSelected('ITE_MRPRBT_PREMED') Then
        pAlteracaoCampoMargem('ITE_MRPRBT_PREMED', fltMarPraPreCusAnt, DataSet)
      Else If cxgItensView.ColumnSelected('ITE_MARBRU_PREMED') Then
        pAlteracaoCampoMargem('ITE_MARBRU_PREMED', fltMarPraPreCusAnt, DataSet);

      If cxgItensView.ColumnSelected('ITE_UNIDIG') Or
         cxgItensView.ColumnSelected('ITE_UNITAR') Or
         cxgItensView.ColumnSelected('ITE_PERDES') Or
         cxgItensView.ColumnSelected('ITE_MARPRA_CUSITE') Or
         cxgItensView.ColumnSelected('ITE_MARPRA_PRECUS') Then
      Begin
        If (Pos(fatVenda.strOpcDoc, 'PD_OR_VN_') > 0) And
           (Not fValorSuperiorAoUnitarioMaximo) Then
        Begin
          fMensagem('ATENÇÃO!','O valor digitado está superior ao valor de teto máximo permitido.' + #13 +
                               'Esta operação não será permitida! Para ajustar esta configuração,' + #13 +
                               'procure nas configurações do sistema o código CFG_FTPRVE',['&OK']);
          Cancel;
          Abort;
        End;
      End;

      If not blnUsaUniLiq Then
        FieldByName('ITE_UNIDIG').AsFloat := FieldByName('ITE_UNITAR').AsFloat;

    End; {With DataSet Do}

  Except

    On E: ExceptionAutcom Do
    Begin
      pMensagemOk(E.Message);
      Abort;
    End;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmFatMostraMargemNovo.pBeforePost]');
      Abort;
    End;

  End;

end;

procedure TfrmFatMostraMargemNovo.pCalcularSaldoDisponivel;
begin
  TfrmGravando.fExecutarModal(pProcessaSaldoDisponivel, 'Processando saldo disponível . . .', '');
end;

procedure TfrmFatMostraMargemNovo.pCalcularGiroDiasEstoque;
begin
  TfrmGravando.fExecutarModal(pProcessaGiroDiasEstoque, 'Processando dias estoque . . .', '');
end;

procedure TfrmFatMostraMargemNovo.pCalcularTotais(cdsOleVariant: OleVariant; objFatVendas: TFatVenda);
var fltDesEspAnt: Double;
begin
  If Not Assigned(objFatVendas) Then
    objFatVendas := fatVenda;

  If Not Assigned(objFatVendas) Then
    Exit;

  objFatVendas.pCalculaTotaisMargemLucro(cdsOleVariant,
                                         recTotMarLuc);

  fltTotMargem := TMargemMinima.TotalParaTravaDePreco(recTotMarLuc, True);

  fltTotUnitar := recTotMarLuc.fltTotUnitar;
  fltTotUniOri := recTotMarLuc.fltTotUniOri;

  If (fltDesEsp > 0) Then
  Begin
    fltDesEspAnt := objFatVendas.fltDesEsp;

    objFatVendas.fltDesEsp := fltDesEsp;
    cdsOleVariant := fatVenda.fCalculaMargemLucro(True, -1, Nil, True);

    objFatVendas.pCalculaTotaisMargemLucro(cdsOleVariant,
                                           recTotMarLucTotIte,
                                           0,
                                           False,
                                           -1,
                                           4);

    objFatVendas.fltDesEsp := fltDesEspAnt;
  End;

  pCalculaResumo;
  pIncluirTotais(True);
end;

class procedure TfrmFatMostraMargemNovo.pCalcularTotaisPublico(cdsItens: TUniClientDataSet; objFatVendas: TFatVenda; fltDesEsp: Double);
  Var 
    recTotMarLuc,
    recTotMarLucTotIte: TRecTotaisMargemLucro;
    cdsOleVariant: OleVariant;
begin
  cdsOleVariant := cdsItens.Data;
  
  objFatVendas.pCalculaTotaisMargemLucro(cdsOleVariant,
                                         recTotMarLuc);
  If (fltDesEsp > 0) Then
  Begin
    cdsOleVariant := objFatVendas.fCalculaMargemLucro(True, -1, Nil, True);

    objFatVendas.pCalculaTotaisMargemLucro(cdsOleVariant,
                                           recTotMarLucTotIte);
  End;

  pIncluirTotaisPublico(cdsItens, False, False, False, fltDesEsp, recTotMarLuc, recTotMarLucTotIte, True); 
end;

procedure TfrmFatMostraMargemNovo.pConfigurarGrid;
var
  intRecNo: Integer;
  intCol: Integer;
begin
  cxgItensView.StoreToStream(mmsLayoutDefault);

  fGetFuncoesCxGrid.fCarregarView(TcxGridDBTableView(cxgItensView), fGetChaveLayoutGrid, cdsItens, intRecNo, False, 'S');

  For intCol := 0 To cxgItensView.ColumnCount -1 Do
  Begin
    If cdsItens.FindField(cxgItensView.Columns[intCol].DataBinding.FieldName) = Nil Then
      cxgItensView.Columns[intCol].Visible := False;
  End;

  //se não conseguiu carregar as bandas obrigatórias, restaura o padrão
  If (Not cxgItensView.Bands[BAND_PRODUTOS].Visible) Or
     (Not cxgItensView.Bands[BAND_PRECO_VENDA].Visible) Or
     (cxgItensView.GetVisibleColumnCount(BAND_PRODUTOS) = 0) Or
     (cxgItensView.GetVisibleColumnCount(BAND_PRECO_VENDA) = 0) Then
    btnPadrao.Click;
end;

procedure TfrmFatMostraMargemNovo.pCriaCdsItens(blnEstruturaDaVenda: Boolean);
begin
  blnApenasVisualizacao := not fPemiteEditarDadosF4Margem(False) ;

  If (blnEstruturaDaVenda) Then
    cdsItens := TMargemLucro.fCriaEstruturaDadosMargemLucro
  Else
    cdsItens := TUniClientDataSet.Create(Self);

end;

procedure TfrmFatMostraMargemNovo.pDescontoMajoramento(fltPerVal: Double; tipPorVal: TPorcentagemValor; cdsDestin: TUniClientDataSet;  blnUsaPreIni: Boolean = True; blnDiluirQtdeUnica: Boolean = True; pgbStatus: TcxProgressBar = Nil);
  Var
    fltValDil : Double;
    fltUniSav : Double;
    strCampoPreIni : String;
    strTRVEPRbkp: String;
    prcScroll: TprcScroll;
begin
  {*********************************************}
  {* ALTERA TEMPORARIAMENTE PARA NÃO SOLICITAR *}
  {* LIBERAÇÃO ITEM A ITEM (fValidaUnitario)   *}
  {*REQ.167935*******************************RP*}
  strTRVEPRbkp := VS_strTRVEPR;
  VS_strTRVEPR := '2';

  Try
    If blnUsaPreIni Then
      strCampoPreIni := 'ITE_PREINI'
    Else
      strCampoPreIni := 'ITE_UNITAR';

    pDisableControls(cdsDestin, prcScroll);
    With cdsDestin Do
    Begin
      fltValDil := fltPerVal;

      If tipPorVal = tpvValor Then
        IndexFieldNames := 'ITE_QTDITE';

      First;
      While Not Eof Do
      Begin
        pProgresso(RecNo, RecordCount, pgbStatus);

        if (FieldByName('SELECIONADO').AsString = 'S') And (FieldByName('ITE_SEQUEN').AsInteger < 99997) and
           (fItemEntraRateio(FieldByName('ITE_PROMOC').AsString, cdsDestin)) then
        Begin
          Try
            cxgItensView.SetColumnIndex('ITE_UNITAR');

            Edit;

            Case tipPorVal Of
              tpvPorcentagem: Begin
                                FieldByName('ITE_UNITAR').AsFloat := fFormataFloat(FieldByName(strCampoPreIni).AsFloat * (1 - fltPerVal / 100), intDecUni);
                              End;
                    tpvValor: Begin
                                fltUniSav := FieldByName('ITE_UNITAR').AsFloat;

                                If blnDiluirQtdeUnica Then
                                Begin
                                  If ((FieldByName('ITE_UNITAR').AsFloat > fltValDil) Or (fltValDil < 0)) And (FieldByName('ITE_QTDITE').AsFloat = 1) Then
                                  Begin
                                    FieldByName('ITE_UNITAR').AsFloat := FieldByName('ITE_UNITAR').AsFloat + fltValDil;

                                    If (fFormataFloat(FieldByName('ITE_UNITAR').AsFloat, intDecUni)) <= 0 Then
                                      FieldByName('ITE_UNITAR').AsFloat := fltUniSav
                                    Else
                                      fltValDil := 0;
                                  End;
                                End
                                Else
                                Begin
                                  FieldByName('ITE_UNITAR').AsFloat := FieldByName('ITE_UNITAR').AsFloat + fFormataFloat(fltValDil / FieldByName('ITE_QTDITE').AsFloat, 2) ;

                                  If (fFormataFloat(FieldByName('ITE_UNITAR').AsFloat, intDecUni)) <= 0 Then
                                    FieldByName('ITE_UNITAR').AsFloat := fltUniSav
                                  Else
                                    fltValDil := fltValDil - fFormataFloat(fltValDil / FieldByName('ITE_QTDITE').AsFloat,2);
                                End;
                              End;
            End;

            Post;

            If (tipPorVal = tpvValor) And (fFormataFloat(fltValDil, 2) <= 0) Then
              Break;

          Except
            On E: EAbort Do
            Begin
              //Deve continuar o processamento dos produtos
            End;
            On E: Exception Do
            Begin
              pMensagensErro(E.Message, '');
            End;
          End;
        End;
        Next;
      End;
      First;
    End;
  Finally
    pEnableControls(cdsDestin, prcScroll);
    VS_strTRVEPR := strTRVEPRbkp; //Restaura a trava configurada originalmente
  End;
end;

procedure TfrmFatMostraMargemNovo.pFormataCamposGrid;
begin
  pFormataCamposGrid(cdsItens, True);
end;

procedure TfrmFatMostraMargemNovo.pFormataCamposGrid(DataSet: TDataSet; blnSetText: Boolean);

  Var
    strFormato : String;

  procedure pSetDisplayFormat(const strFieldName, strDisplayFormat: string);
  const
    strPROPERTY_NAME = 'DisplayFormat';
  var
    objRttiContext: TRttiContext;
    objRttiProperty: TRttiProperty;
  begin
    if not Assigned(DataSet.FindField(strFieldName)) then
      Exit;
    objRttiContext := TRttiContext.Create;
    try
      objRttiProperty := objRttiContext.GetType(DataSet.FindField(strFieldName).ClassType).GetProperty(strPROPERTY_NAME);
      if not Assigned(objRttiProperty) then
        Exit;
      objRttiProperty.SetValue(DataSet.FieldByName(strFieldName), TValue.From(strDisplayFormat));
    finally
      objRttiContext.Free;
    end;
  end;

  procedure pSetOnSetText(const strFieldName: string);
  begin
    if not Assigned(DataSet.FindField(strFieldName)) then
      Exit;
    DataSet.FindField(strFieldName).OnSetText := pOnSetText;
  end;

begin
  strFormato := '##,#0.00';

  If blnTintaDeMaquina Then
    strFormato := '##,#0.0000';

  pSetDisplayFormat('ITE_UNIDOL', '##,#0.0000');
  pSetDisplayFormat('ITE_VLCTVN', '##,#0.0000');
  pSetDisplayFormat('ITE_DTCTVN', 'dd/MM/yyyy');
  pSetDisplayFormat('ITE_MARMIN', strFormato);
  pSetDisplayFormat('ITE_RESULT', strFormato);
  pSetDisplayFormat('ITE_PERDES', strFormato);
  pSetDisplayFormat('ITE_UNIORI', fMskDigitos(intDecUni));
  pSetDisplayFormat('ITE_UNITAR', fMskDigitos(intDecUni));
  pSetDisplayFormat('ITE_TOTITE', fMskDigitos(intDecUni));
  pSetDisplayFormat('ITE_UNIDIG', fMskDigitos(intDecUni));
  pSetDisplayFormat('ITE_TAXJUR', strFormato);
  pSetDisplayFormat('ITE_CUSITE', strFormato);
  pSetDisplayFormat('ITE_MARPRO_CUSITE', strFormato);
  pSetDisplayFormat('ITE_MARPRA_CUSITE', strFormato);
  pSetDisplayFormat('ITE_DESOPE', strFormato);
  pSetDisplayFormat('ITE_IMPFED', strFormato);
  pSetDisplayFormat('ITE_ICMSAI', strFormato);
  pSetDisplayFormat('ITE_OUTVAL', strFormato);
  pSetDisplayFormat('ITE_PRECUS', strFormato);
  pSetDisplayFormat('ITE_PRECU2', strFormato);
  pSetDisplayFormat('ITE_MARPRO_PRECUS', strFormato);
  pSetDisplayFormat('ITE_MRPRBT_PRECUS', strFormato);
  pSetDisplayFormat('ITE_MARPRA_PRECUS', strFormato);
  pSetDisplayFormat('ITE_PREMED', strFormato);
  pSetDisplayFormat('ITE_PREMED_LIQ', strFormato);
  pSetDisplayFormat('ITE_MARBRU_PREMED', strFormato);
  pSetDisplayFormat('ITE_MRPRBT_PREMED', strFormato);
  pSetDisplayFormat('ITE_MARLIQ_PREMED', strFormato);
  pSetDisplayFormat('ITE_PREULT', strFormato);
  pSetDisplayFormat('ITE_MARBRU_PREULT', strFormato);
  pSetDisplayFormat('ITE_MARLIQ_PREULT', strFormato);
  pSetDisplayFormat('ITE_CUSIMP', strFormato);
  pSetDisplayFormat('ITE_MARBRU_IMPULT', strFormato);
  pSetDisplayFormat('ITE_MARLIQ_IMPULT', strFormato);
  pSetDisplayFormat('ITE_QTDITE', strFormato);
  pSetDisplayFormat('ITE_SALDOS', '##,#0.000');
  pSetDisplayFormat('ITE_MARIDE', strFormato);
  pSetDisplayFormat('ITE_MARCAT', strFormato);
  pSetDisplayFormat('ITE_PREIDE', strFormato);
  pSetDisplayFormat('ITE_VDIFAL', strFormato);
  pSetDisplayFormat('ITE_VALFCP', strFormato);
  pSetDisplayFormat('ITE_MKPPRO', strFormato);
  pSetDisplayFormat('ITE_ENCPRO', strFormato);
  pSetDisplayFormat('ITE_MARPRO', strFormato);
  pSetDisplayFormat('ITE_PRETAB', strFormato);

  pSetOnSetText('ITE_UNITAR');
  pSetOnSetText('ITE_UNIDIG');
  pSetOnSetText('ITE_MARPRA_PRECUS');
  pSetOnSetText('ITE_MARPRA_CUSITE');

  If (fCfgSis('MCAT17') = 'S') Then
  Begin
    If Assigned(DataSet.FindField('ITE_MARCAT')) Then
      DataSet.FindField('ITE_MARCAT').OnGetText := pOnGetTextCat;
  End;

  cxEditRepositoryValor.Properties.DecimalPlaces := intDecUni;
  cxEditRepositoryValor.Properties.DisplayFormat := fMskDigitos(intDecUni);
end;

procedure TfrmFatMostraMargemNovo.pFormShowInterna(Sender: TObject);
begin
  If Not Assigned(cdsItens) Then
    Raise Exception.Create('Os dados da margem não foram informados corretamente!');

  If Assigned(fatVenda) Then
    fltTotalG := fatVenda.fltTotGer
  Else
    fltTotalG := 0;

  pCalcularSaldoDisponivel;
  pCalcularGiroDiasEstoque;

  pProcessarTela;
  pConfigurarGrid;
  pVerificaPreTab;
  pAdicionaTravasMinimas;
  pProcessarView;
  pCalculaResumo;
  pPreencherPercentualComissao;
  pIncluirTotais;
  pFormataCamposGrid;

  cdsItens.BeforeEdit  := pBeforeEdit;
  cdsItens.BeforePost  := pBeforePost;
  cdsItens.AfterPost   := pAfterPost;
  cdsItens.AfterScroll := pAfterScroll;
  cdsItens.First;

  cdsDados := TUniClientDataSet.Create(Self);
  dtsItens.DataSet    := cdsItens;
  oleCopia := cdsItens.Data;

  fltDesEspCopia := fltDesEsp;

  Self.WindowState := wsMaximized;

  If (Self.blnTintaDeMaquina) Then
  Begin
    cxgItensView.ViewData.Expand(True);
    cxgItensView.NavigatorButtons.First.Click;
  End;

  cxgItensITE_DESMAR.Visible := fCfgSis('EXIMAR', VarBoolean);
  cxgItensITE_SALDOS.Visible := fVerificaAcessoSistema('PVISPF');
  cxgItensITE_CODFAB.Visible := fCfgSis('FABMAR', VarBoolean);

  If cxgItensITE_CODFAB.Visible Then
    cxgItensITE_CODFAB.Position.ColIndex := 1;

  If cxgItensITE_TABPRE.Visible Then
    cxgItensITE_TABPRE.Position.ColIndex := 6;

  If Assigned(fatVenda) Then
    pExibirDescontoEspecial(fatVenda.fltDesEspF4)
  Else
    pExibirDescontoEspecial(0);

  if blnVisualizarPorMensagem then
  begin
    btnMargemSobreItens.Visible := False;
    btnDesconto.Visible := False;
    btnCustosMargemTintas.Visible := False;
    btnTravasMinimas.Visible := False;
    btnDeseja.Visible := False;
    btnRestaurar.Visible := False;
    btnPadrao.Visible := False;
  end;

  if blnConEqu then
    btnDeseja.Visible := False;
end;

procedure TfrmFatMostraMargemNovo.pPreencherPercentualComissao;
begin
  TfrmGravando.fExecutarModal(pProcessaPercentualComissao, 'Carregando percentual de comissão . . .', '');
end;

procedure TfrmFatMostraMargemNovo.pProcessaPercentualComissao;
  Var
    strExMaF4 : String;
begin
  strExMaF4 := fCfgSis('EXMAF4');

  If ((fEmptyStr(strExMaF4)) Or (Length(strExMaF4) < 12) Or (strExMaF4[12] = 'N')) Then
    Exit;

  cdsItens.DisableControls;
  Try
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      cdsItens.Edit;
      cdsItens.FieldByName('ITE_COMISS').AsFloat := fRetornaComissaoTabPreco;
      cdsItens.Post;

      cdsItens.Next;
    End;
  Finally
    cdsItens.EnableControls;
  End;
end;

procedure TfrmFatMostraMargemNovo.pGerarDicionarioColunas;
  Var
    intCnt : Integer;
    strNomeCol : String;
begin
  dicColunasF4.Clear;
  For intCnt := 0 To cxgItensView.ColumnCount - 1 Do
  Begin
    If (Length(cxgItensView.Columns[intCnt].DataBinding.FieldName) > 5) Then
    Begin
      strNomeCol := 'rll' + Copy(cxgItensView.Columns[intCnt].DataBinding.FieldName, 5, Length(cxgItensView.Columns[intCnt].DataBinding.FieldName));
      dicColunasF4.AddOrSetValue(strNomeCol, cxgItensView.Columns[intCnt].Visible);
    End;
  End;
end;

procedure TfrmFatMostraMargemNovo.pImprimirF4(DataSet: TDataSet; dicColunas: TDictionary<String, Boolean>; fncUserFunction: TUserFunction;
  blnTinta: Boolean; stlFunctions: TStringList);
  Var
    strDestino : String;

  procedure pRemoverTotalizadores;
  Begin
    DataSet.Filtered := False;
    DataSet.Filter   := 'ITE_SEQUEN < 99997';
    DataSet.Filtered := True;
  End;

begin
  If fMensagem('','Saída', ['&Video', '&Imprimir']) = 1 Then
    strDestino := 'V'
  Else
    strDestino := 'I';

  pRemoverTotalizadores;

  frmModuloFatMostraMargem := TfrmModuloFatMostraMargem.Create(nil);
  Try
    frmModuloFatMostraMargem.dicColunas := dicColunas;
    frmModuloFatMostraMargem.blnTinta := blnTinta;
    frmModuloFatMostraMargem.fncUserFunction := fncUserFunction;
    frmModuloFatMostraMargem.stlFunctions := stlFunctions;
    frmModuloFatMostraMargem.pImprimir(DataSet, strDestino);
  Finally
    pFreeAndNil(frmModuloFatMostraMargem);
  End;
end;

procedure TfrmFatMostraMargemNovo.pExibirDescontoEspecial(fltDescontoEspecial: Double);
begin
  lblDesEsp.Visible := (fltDescontoEspecial <> 0);
  edtDesEsp.Visible := lblDesEsp.Visible;

  If edtDesEsp.Visible Then
  Begin
    edtDesEsp.Text := FormatFloat('#,##0.00', fltDescontoEspecial);
  End;
end;

procedure TfrmFatMostraMargemNovo.pIncluirTotais(blnForcarInclusao: Boolean = False);
begin
  pExibirDescontoEspecial(fltDesEsp);

  pIncluirTotaisPublico(cdsItens,
                        blnTintaDeMaquina, 
                        blnApenasVisualizacao, 
                        blnUsouTotalDesejado, 
                        fltDesEsp, 
                        recTotMarLuc,
                        recTotMarLucTotIte,
                        blnForcarInclusao);
end;

class procedure TfrmFatMostraMargemNovo.pIncluirTotaisPublico(cdsItens: TUniClientDataSet; 
                                                              blnTintaDeMaquina, 
                                                              blnApenasVisualizacao,
                                                              blnUsouTotalDesejado: Boolean;
                                                              fltDesEsp: Double; 
                                                              recTotMarLuc,
                                                              recTotMarLucTotIte: TRecTotaisMargemLucro;
                                                              blnForcarInclusao: Boolean);

  procedure pInsertTotais(intCodigo: Integer; recTotais: TRecTotaisMargemLucro; strDescri: String);
  begin
    cdsItens.Append;
    cdsItens.FieldByName('ITE_SEQUEN').AsInteger := intCodigo;
    cdsItens.FieldByName('ITE_ORDITE').AsInteger := intCodigo;
    cdsItens.FieldByName('ITE_CODITE').AsString := '';
    cdsItens.FieldByName('ITE_DESITE').AsString := strDescri;
    cdsItens.FieldByName('ITE_RESULT').AsFloat := recTotais.fltTotUnitar - recTotais.fltTotCusto;
    cdsItens.FieldByName('ITE_UNIORI').AsFloat := recTotais.fltTotUniOri;
    cdsItens.FieldByName('ITE_UNIDIG').AsFloat := recTotais.fltTotUniDig;
    cdsItens.FieldByName('ITE_UNITAR').AsFloat := recTotais.fltTotUnitar;
    cdsItens.FieldByName('ITE_TOTITE').AsFloat := recTotais.fltTotUnitar;
    cdsItens.FieldByName('ITE_PRECUS').AsFloat := recTotais.fltTotCusto;
    cdsItens.FieldByName('ITE_PRECU2').AsFloat := recTotais.fltTotCusto2;
    cdsItens.FieldByName('ITE_PRETAB').AsFloat := recTotais.fltTotPreTab;

    cdsItens.FieldByName('ITE_PREMED').AsFloat := recTotais.fltTotMedio;

    cdsItens.FieldByName('ITE_CUSIMP').AsFloat := recTotais.fltTotCusImp;
    cdsItens.FieldByName('ITE_CUSITE').AsFloat := recTotais.fltTotCusIte;
    cdsItens.FieldByName('ITE_PREULT').AsFloat := recTotais.fltTotPreUlt;
    cdsItens.FieldByName('ITE_QTDITE').AsFloat := recTotais.fltTotQtdIte;
    cdsItens.FieldByName('ITE_PREIDE').AsFloat := recTotais.fltTotPreIde;
    cdsItens.FieldByName('ITE_MARIDE').AsFloat := recTotais.fltTotMarLiq_PREIDE;
    cdsItens.FieldByName('ITE_MARCAT').AsFloat := recTotais.fltTotMarLiq_CAT_17;
    If fFormataFloat(recTotais.fltTotUniOri*recTotais.fltTotQtdIte, 2) <> 0.00 Then
      cdsItens.FieldByName('ITE_PERDES').AsFloat := fFormataFloat((((recTotais.fltTotUniOri*recTotais.fltTotQtdIte) - (recTotais.fltTotUnitar*recTotais.fltTotQtdIte))/(recTotais.fltTotUniOri*recTotais.fltTotQtdIte))*100, 2)
    Else
      cdsItens.FieldByName('ITE_PERDES').AsFloat := 0;
    cdsItens.FieldByName('ITE_MARPRA_PRECUS').AsFloat := recTotais.fltTotMarPra_PRECUS;
    cdsItens.FieldByName('ITE_MRPRBT_PRECUS').AsFloat := recTotais.fltTotMrPrBr_PRECUS;
    cdsItens.FieldByName('ITE_MARPRO_PRECUS').AsFloat := recTotais.fltTotMarPro_PRECUS;
    cdsItens.FieldByName('ITE_MARBRU_PREMED').AsFloat := recTotais.fltTotMarBru_PREMED;
    cdsItens.FieldByName('ITE_MRPRBT_PREMED').AsFloat := recTotais.fltTotMePrBr_PREMED;
    cdsItens.FieldByName('ITE_MARLIQ_PREMED').AsFloat := recTotais.fltTotMarLiq_PREMED;
    cdsItens.FieldByName('ITE_MARBRU_IMPULT').AsFloat := recTotais.fltTotMarBru_IMPULT;
    cdsItens.FieldByName('ITE_MARLIQ_IMPULT').AsFloat := recTotais.fltTotMarLiq_IMPULT;
    cdsItens.FieldByName('ITE_MARBRU_PREULT').AsFloat := recTotais.fltTotMarBru_PREULT;
    cdsItens.FieldByName('ITE_MARLIQ_PREULT').AsFloat := recTotais.fltTotMarLiq_PREULT;
    cdsItens.FieldByName('ITE_MARPRA_CUSITE').AsFloat := recTotais.fltTotMarPra_CUSITE;
    cdsItens.FieldByName('ITE_MARPRO_CUSITE').AsFloat := recTotais.fltTotMarPro_CUSITE;
    cdsItens.FieldByName('TRM_TOTMIN').AsFloat := recTotais.fltTotalTravaMinima;
    cdsItens.Post;
  end;

Begin
  If (Not blnForcarInclusao) And ((blnTintaDeMaquina) Or (blnApenasVisualizacao)) Then
    Exit;

  cdsItens.DisableControls;
  Try
    If (cdsItens.Locate('ITE_SEQUEN', 99997, [])) Then
      cdsItens.Delete;
    If (cdsItens.Locate('ITE_SEQUEN', 99998, [])) Then
      cdsItens.Delete;
    If (cdsItens.Locate('ITE_SEQUEN', 99999, [])) Then
      cdsItens.Delete;

    pInsertTotais(99997, recTotMarLuc, STR_TEXTO_TOTAL_S_DESC);

    If (Not blnUsouTotalDesejado) And (fltDesEsp > 0) Then
    Begin
      cdsItens.Append;
      cdsItens.FieldByName('ITE_SEQUEN').AsInteger := 99998;
      cdsItens.FieldByName('ITE_ORDITE').AsInteger := 99998;
      cdsItens.FieldByName('ITE_CODITE').AsString := '';
      cdsItens.FieldByName('ITE_DESITE').AsString := 'DESCONTO: ' + FormatFloat('#,##0.00', fltDesEsp);
      cdsItens.Post;

      pInsertTotais(99999, recTotMarLucTotIte, STR_TEXTO_TOTAL_C_DESC);
    End;
  Finally
    cdsItens.EnableControls;
  End;
end;

procedure TfrmFatMostraMargemNovo.pOnSetText(Sender: TField; const Text: string);
begin
  Try
    Sender.Value := fStrToFloat(Text);
  Except
    pMensagemOk(Text + ' não é um número válido. Verifique!');
  End;
end;

procedure TfrmFatMostraMargemNovo.pOnGetTextCat(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  If (Not Sender.IsNull) Then
  Begin
    Text := FormatFloat('#,##0.00', Sender.AsFloat);

    If (Sender.DataSet.FieldByName('ITE_MARCAT').AsFloat = 0) Then
      If (Sender.DataSet.FieldByName('ITE_SEQUEN').AsInteger < 99997) Then
        Text := FormatFloat('#,##0.00', Sender.DataSet.FieldByName('ITE_MARPRA_PRECUS').AsFloat);
  End;
end;

procedure TfrmFatMostraMargemNovo.popGridPopup(Sender: TObject);
begin
  inherited;
  mnuImprimirF4.Enabled := (Assigned(cdsItens)) And (cdsItens.Active) And (Not cdsItens.IsEmpty) And fVerificaAcessoSistema('IMPRF4', strLoginUsuarioLogado);
end;

procedure TfrmFatMostraMargemNovo.pPosicionarRegistroVenda(DataSet: TDataSet);
begin
  cdsVenda.Locate('AUTOINCREM', DataSet.FieldByName('AUTOINCREM').AsInteger, []);
  cdsDados.Locate('AUTOINCREM', DataSet.FieldByName('AUTOINCREM').AsInteger, []);
end;

function TfrmFatMostraMargemNovo.fPermiteDesconto: Boolean;
begin
  Result := True;
  If Assigned(fatVenda) Then
    If fatVenda.strOpcDoc = 'CF' Then
      Result := (fCfgSis('DESICF', varBoolean));
end;

function TfrmFatMostraMargemNovo.fExibeMensagem: Boolean;
begin
  Result := (not blnDescontoMajoramento) or (not blnExibiuMensagem);
end;

procedure TfrmFatMostraMargemNovo.pProcessarTela;
  Var
    strCodCli: String;
begin
  Self.Caption := 'Consulta de Custo / ' + IIF(fMargem_ou_Markup='MARGEM','Margem','Markup') + ' de Produtos';

  pnlFrete.Visible := Assigned(fatVenda) And (Not Self.blnTintaDeMaquina);
  btnDesconto.Visible := Assigned(fatVenda) And (Not blnApenasVerificandoMargemComFrete) And (Not Self.blnTintaDeMaquina) And (Not fRealizandoConfirmacao(False)) And (fPermiteDesconto);
  btnMargemSobreItens.Caption := '[F2] % ' + IIF(fMargem_ou_Markup='MARGEM','Margem','Markup') + ' praticada sobre itens';
  btnRestaurar.Visible := (Not Self.blnTintaDeMaquina) And (Not blnApenasVisualizacao) And (Not blnApenasVerificandoMargemComFrete);
  pnlTotais.Visible := (Not Self.blnTintaDeMaquina);
  pnlAviTot.Visible := (Not Self.blnTintaDeMaquina);

  If (Not blnApenasVerificandoMargemComFrete) Then
  Begin
    lblFreSuges.Visible := False;
    edtFreSuges.Visible := False;
    chkAcuFreteCobPrecoUni.Visible := False;
    chkAcuFreteSugPrecoCus.Visible := False;
    pnlFrete.Height := pnlFrete.Height - edtFreSuges.Height;
  End;

  btnCustosMargemTintas.Visible := (fTemTinta) And (Not Self.blnTintaDeMaquina);
  btnTravasMinimas.Visible := (Assigned(fatVenda)) And (TMostraTravaMinimaHelper.fExibeTravaMinima) And (Not Self.blnTintaDeMaquina);
  btnDeseja.Visible := fExibeBtnDeseja;
  btnMargemSobreItens.Visible := fExibeBtnMargemSobreItens;
  btnVenCli.Visible := Assigned(fatVenda);

  If Assigned(fatVenda) Then
  Begin
    edtTotFrete.Text := FormatFloat('#,##0.00', fatVenda.fltValFre);
    edtFreSuges.Text := FormatFloat('#,##0.00', fatVenda.fltFreSug);
  End;

  If (fAplicarTaxaJurosPrecoDigitado) And (not blnUsaUniLiq) Then
  Begin
    btnDeseja.Visible := False;
    btnDesconto.Visible := False;
    btnMargemSobreItens.Visible := False;
  End;

  If blnOcultaBotoes Then
  Begin
    btnMargemSobreItens.Visible := false;
    btnDesconto.Visible         := false;
    btnDeseja.Visible           := false;
    btnRestaurar.Visible        := false;
  End;

  strCodCli := '';
  If Assigned(fatVenda) Then
    strCodCli := fatVenda.strCodCli;

  If pnlTotais.Visible Then
    gpbUltVen.Visible := (Not fClienteConsumidor(fRetNomCliente(strCodCli)));
end;

function TfrmFatMostraMargemNovo.fExibeBtnDeseja: Boolean;
begin
  Result := False;

  If (Not Assigned(fatVenda)) Then
    Exit;

  If (blnApenasVerificandoMargemComFrete) Then
    Exit;

  If (fRealizandoConfirmacao) And (Not fPermiteDesconto) Then
    Exit;

  If (Self.blnTintaDeMaquina) Then
    Exit;

  If (blnApenasVisualizacao) Then
    Exit;

  Result := True;
end;

function TfrmFatMostraMargemNovo.fExibeBtnMargemSobreItens: Boolean;
begin
  Result := False;

  If (fRealizandoConfirmacao) And (Not fPermiteDesconto) Then
    Exit;

  If (Self.blnTintaDeMaquina) Then
    Exit;

  If (blnApenasVisualizacao) Then
    Exit;

  If (blnApenasVerificandoMargemComFrete) Then
    Exit;

  Result := True;
end;

procedure TfrmFatMostraMargemNovo.pProcessarTintasDeMaquina;
  Var
    tintaDeMaquina : ITintaDeMaquina;
    fatVendasCalculadorWrapper: TFatVendasCalculadorWrapper;
    cdsDadosVenda : TUniClientDataSet;
begin
  fatVendasCalculadorWrapper := nil;
  Try
    Try
      cdsDadosVenda := fCriaClientDatset(cdsVenda, False, Nil);

      cdsDadosVenda.First;
      fatVendasCalculadorWrapper := TFatVendasCalculadorWrapper.Create(fatVenda);

      While Not cdsDadosVenda.Eof Do
      Begin
        cdsItensTinta.RecNo := cdsDadosVenda.RecNo;

        If Not fEmptyStr(cdsItensTinta.FieldByName('ITE_EMPPRD').AsString) Then
          pSetaEmpresaLogadaTinta(cdsItensTinta.FieldByName('ITE_EMPPRD').AsString)
        Else If Not fEmptyStr(cdsItensTinta.FieldByName('ITE_EMPITE').AsString) Then
          pSetaEmpresaLogadaTinta(cdsItensTinta.FieldByName('ITE_EMPITE').AsString);

        If Assigned(fatVenda) Then
          If fatVenda.fEhDocumentoAbastecimentoPorDepositoUsandoPrecoLocal() Then
            pSetaEmpresaLogadaTinta(VS_strCodEmp);

        Try
          tintaDeMaquina := fGetITintadeMaquina(TDadosFechamentoDadosTinta.Create(cdsDadosVenda), fatVendasCalculadorWrapper, dicInfEmp);
          RecalcularTintadeMaquina(tintaDeMaquina, cdsItensTinta.FieldByName('ITE_UNITAR').AsFloat, cdsItensTinta.FieldByName('ITE_PRECUS').AsFloat);
          pAdicionarTinta(tintaDeMaquina);
        Finally
          pSetaEmpresaLogadaTinta(VS_strCodEmp);
        End;

        cdsDadosVenda.Next;
      End;

      pSetFocus(cxgItens);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(fatVendasCalculadorWrapper) then
      FreeAndNil(fatVendasCalculadorWrapper);
    if Assigned(cdsDadosVenda) Then
      FreeAndNil(cdsDadosVenda);
  End;
end;

procedure TfrmFatMostraMargemNovo.pProcessarView;
  Var
    strFormato : String;
    strValPer : String;
    blnDacMf4: Boolean;
    blnHabTravasMinimas: Boolean;
begin
  strFormato := Format('0.%s', [fStrZero(0, FormatSettings.CurrencyDecimals)]);

  If blnTintaDeMaquina Then
    strFormato := Format('0.%s', [fStrZero(0, 4)]);

  With cxgItensView Do
  Begin
    DataController.DataSource := dtsItens;

    SetAllColumnsEditing(False);

    If Self.blnTintaDeMaquina Then
      strValPer := '$'
    Else
      strValPer := '%';

    cxgItensITE_IMPFED.Caption := 'Imp.Federais(' + strValPer + ')';
    cxgItensITE_DESOPE.Caption := 'Desp.Operac.(' + strValPer + ')';
    cxgItensITE_ICMSAI.Caption := 'ICMS Saída(' + strValPer + ')';

    If Self.blnTintaDeMaquina Then
      cxgItensITE_OUTVAL.Caption := 'Outros Valores(' + strValPer + ')';

    If (Not fEmptyStr(fCfgSis('DOVCPP'))) Then
      cxgItensITE_OUTVAL.Caption := fCfgSis('DOVCPP')+IIF(Self.blnTintaDeMaquina, '(' + strValPer + ')', '');

    If (Not fEmptyStr(fCfgSis('DEOUVL'))) Then
      cxgItensITE_OUTVAL.Caption := fCfgSis('DEOUVL')+IIF(Self.blnTintaDeMaquina, '(' + strValPer + ')', '');

    If Pos(fCfgSis('TRADES'), '3_') <= 0 Then
      SetColumnVisible('ITE_MARMIN', False);

    SetColumnVisible('ITE_UNIDOL', False);
    SetColumnVisible('ITE_VLCTVN', False);
    SetColumnVisible('ITE_DTCTVN', False);

    If fCfgSis('COTDOR', VarBoolean) And fCfgSis('RPVDOL', VarBoolean) Then
    Begin
      If Assigned(fatVenda) And (Pos(fatVenda.strOpcDoc,'VN_PD_OR_') > 0) Then
      Begin
        SetColumnVisible('ITE_UNIDOL', True);
        SetColumnVisible('ITE_VLCTVN', True);
        SetColumnVisible('ITE_DTCTVN', True);
      End;
    End;

    If blnApenasVerificandoMargemComFrete Then
      OptionsData.Editing := False;

    SetBandVisible(BAND_CAT_17, True);

    blnDacMf4 := fCfgSis('DACMF4', varBoolean);
    // CFG_EXMAF4 = SSSNNNNN
    If (Not fEmptyStr(strExMaF4)) And (Length(strExMaF4) >= 9) Then
    Begin
      SetBandVisible(BAND_MARGEM_PRODUTO,                    ((strExMaF4[9] = 'S') And (IIF(blnDacMf4, fVerificaAcessoSistema('VCPMF4', fOperadorAcesso), True))));

      SetBandVisible(BAND_CAT_17,                            ((strExMaF4[8] = 'S') And (IIF(blnDacMf4, fVerificaAcessoSistema('VCTMF4', fOperadorAcesso), True))));

      SetBandVisible(BAND_PRECO_IDEAL,                       ((strExMaF4[7] = 'S') And (IIF(blnDacMf4, fVerificaAcessoSistema('VMIMF4', fOperadorAcesso), True))));

      SetBandVisible(BAND_QUANTIDADE_ESTOQUE,                ((strExMaF4[6] = 'S') And (IIF(blnDacMf4, fVerificaAcessoSistema('VQVMF4', fOperadorAcesso), True))));

      SetBandVisible(BAND_PRECO_ULTIMA_COMPRA_MAIS_IMPOSTOS, ((strExMaF4[5] = 'S') And (IIF(blnDacMf4, fVerificaAcessoSistema('VPIMF4', fOperadorAcesso), True))));

      SetBandVisible(BAND_PRECO_ULTIMA_COMPRA,               ((strExMaF4[4] = 'S') And (IIF(blnDacMf4, fVerificaAcessoSistema('VPUMF4', fOperadorAcesso), True))));

      SetBandVisible(BAND_PRECO_MEDIO,                       ((strExMaF4[3] = 'S') And (IIF(blnDacMf4, fVerificaAcessoSistema('VPMMF4', fOperadorAcesso), True))));

      SetBandVisible(BAND_PRECO_CUSTO_REAL,                  ((strExMaF4[2] = 'S') And (IIF(blnDacMf4, (fVerificaAcessoSistema('VPRMF4', fOperadorAcesso) or
                                                                                                        fVerificaAcessoSistema('VMRMF4', fOperadorAcesso) or
                                                                                                        fVerificaAcessoSistema('VIIMF4', fOperadorAcesso)),
                                                                                                        True))));

      SetBandVisible(BAND_PRECO_CUSTO,                       ((strExMaF4[1] = 'S') And (IIF(blnDacMf4, (fVerificaAcessoSistema('VPCMF4', fOperadorAcesso) or
                                                                                                        fVerificaAcessoSistema('VMPMF4', fOperadorAcesso)), True))));
    End;

    If ((Not fEmptyStr(strExMaF4)) And (Length(strExMaF4) >= 9) And (strExMaF4[9] = 'S')) Then
    Begin
      Bands[BAND_MARGEM_PRODUTO].Caption := IIF(pos(fCfgSis('MARMKP'), '1_5_') > 0,'MARGEM','MARKUP') + ' DO CADASTRO';
      cxgItensViewITE_MKPPRO2.Caption    := IIF(pos(fCfgSis('MARMKP'), '1_5_') > 0,'% Margem','% Markup');
    End;

    If ((Not fEmptyStr(strExMaF4)) And (Length(strExMaF4) >= 11) And (strExMaF4[11] = 'S')) Then
      cxgItensGIR_DIAEST.Visible := True
    Else
      cxgItensGIR_DIAEST.Visible := False;

    If ((Not fEmptyStr(strExMaF4)) And (Length(strExMaF4) >= 12) And (strExMaF4[12] = 'S')) Then
    Begin
      Case fCfgSis('PCMPRO', varInteger) Of
        1: cxgItensITE_COMISS.Visible := False;
        2:
          Begin
            cxgItensITE_COMISS.Visible := True;
            cxgItensITE_COMISS.Caption := 'Comissão';
            cxgItensITE_COMISS.DataBinding.FieldName := 'ITE_COMISS';
          End;
        3:
          Begin
            cxgItensITE_COMISS.Visible := True;
            cxgItensITE_COMISS.Caption := fCfgSis('TCOMTB');
            cxgItensITE_COMISS.DataBinding.FieldName := 'ITE_COMISS';
          End;
      End;
    End;

    If ((Not fEmptyStr(strExMaF4)) And (Length(strExMaF4) >= 13) And (strExMaF4[13] = 'S')) Then
      cxgItensITE_TABPRE.Visible := True
    Else
      cxgItensITE_TABPRE.Visible := False;

    If (fCfgSis('MCAT17') <> 'S') Then
      SetBandVisible(BAND_CAT_17, False);

    SetAllBandsMoving(False);
    SetAllColumnsMoving(False);

    {****************************}
    {* BAND PREÇO DE CUSTO REAL *}
    {*************************BL*}
    SetColumnVisible('ITE_DESOPE', IIF(blnDacMf4, (fVerificaAcessoSistema('VPRMF4', fOperadorAcesso) or
                                                   fVerificaAcessoSistema('VIIMF4', fOperadorAcesso)),
                                                   fVerificaAcessoSistema('VIIMF4', fOperadorAcesso)));

    SetColumnVisible('ITE_IMPFED', IIF(blnDacMf4, (fVerificaAcessoSistema('VPRMF4', fOperadorAcesso) or
                                                   fVerificaAcessoSistema('VIIMF4', fOperadorAcesso)),
                                                   fVerificaAcessoSistema('VIIMF4', fOperadorAcesso)));

    SetColumnVisible('ITE_ICMSAI', IIF(blnDacMf4, (fVerificaAcessoSistema('VPRMF4', fOperadorAcesso) or
                                                   fVerificaAcessoSistema('VIIMF4', fOperadorAcesso)),
                                                   fVerificaAcessoSistema('VIIMF4', fOperadorAcesso)));

    SetColumnVisible('ITE_OUTVAL', IIF(blnDacMf4, (fVerificaAcessoSistema('VPRMF4', fOperadorAcesso) or
                                                   fVerificaAcessoSistema('VIIMF4', fOperadorAcesso)),
                                                   fVerificaAcessoSistema('VIIMF4', fOperadorAcesso)));

    SetColumnVisible('ITE_VDIFAL', IIF(blnDacMf4, (fVerificaAcessoSistema('VPRMF4', fOperadorAcesso) or
                                                   fVerificaAcessoSistema('VIIMF4', fOperadorAcesso)),
                                                   fVerificaAcessoSistema('VIIMF4', fOperadorAcesso)));

    SetColumnVisible('ITE_VALFCP', IIF(blnDacMf4, (fVerificaAcessoSistema('VPRMF4', fOperadorAcesso) or
                                                   fVerificaAcessoSistema('VIIMF4', fOperadorAcesso)),
                                                   fVerificaAcessoSistema('VIIMF4', fOperadorAcesso)));

    SetColumnVisible('ITE_PRECUS', IIF(blnDacMf4, fVerificaAcessoSistema('VPRMF4', fOperadorAcesso), True));
    SetColumnVisible('ITE_MARPRO_PRECUS', IIF(blnDacMf4, fVerificaAcessoSistema('VMPRF4', fOperadorAcesso), True));
    SetColumnVisible('ITE_MRPRBT_PRECUS', IIF(blnDacMf4, fVerificaAcessoSistema('VMRMF4', fOperadorAcesso), True) And (fCfgSis('MARMKP') = MARGEM_SOBRE_PRECO_VENDA_LIQUIDO_RITEC));
    SetColumnVisible('ITE_MARPRA_PRECUS', IIF(blnDacMf4, fVerificaAcessoSistema('VMRMF4', fOperadorAcesso), True));

    SetColumnVisible('ITE_MRPRBT_PREMED', (fCfgSis('MARMKP') = MARGEM_SOBRE_PRECO_VENDA_LIQUIDO_RITEC));

    If (Not fEmptyStr(strExMaF4)) And (Length(strExMaF4) > 13) Then
      SetColumnVisible('ITE_TOTITE', strExMaF4[14] = 'S');

    If (cxgItensITE_MRPRBT_PRECUS.Visible) Then
    Begin
      cxgItensITE_MARPRO_PRECUS.Caption := 'M.Prop.Bru.';
      cxgItensITE_MRPRBT_PRECUS.Caption := 'M.Prat.Bru.';
      cxgItensITE_MARPRA_PRECUS.Caption := 'M.Prat.Liq.';
      cxgItensITE_MARPRO_PRECUS.Width := cxgItensITE_MRPRBT_PRECUS.Width;
      cxgItensITE_MARPRA_PRECUS.Width := cxgItensITE_MRPRBT_PRECUS.Width;
    End;

    If (fCfgSis('MARMKP', varString) <> MARGEM_SOBRE_PRECO_VENDA_LIQUIDO_RITEC) Then
      cxgItensITE_MARBRU_PREMED.Caption := 'M.Prat.';

    If (cxgItensITE_MRPRBT_PREMED.Visible) Then
    Begin
      cxgItensITE_MARBRU_PREMED.Caption := 'M.Prop.Bru.';
      cxgItensITE_MRPRBT_PREMED.Caption := 'M.Prat.Bru.';
      cxgItensITE_MARLIQ_PREMED.Caption := 'M.Prat.Liq.';
      cxgItensITE_MARBRU_PREMED.Width := cxgItensITE_MRPRBT_PREMED.Width;
      cxgItensITE_MARLIQ_PREMED.Width := cxgItensITE_MRPRBT_PREMED.Width;
    End;

    {***********************}
    {* BAND PREÇO DE CUSTO *}
    {********************BL*}
    SetColumnVisible('ITE_CUSITE', IIF(blnDacMf4, fVerificaAcessoSistema('VPCMF4', fOperadorAcesso), True));
    SetColumnVisible('ITE_MARPRO_CUSITE', IIF(blnDacMf4, fVerificaAcessoSistema('VMPCF4', fOperadorAcesso), True));
    SetColumnVisible('ITE_MARPRA_CUSITE', IIF(blnDacMf4, fVerificaAcessoSistema('VMPMF4', fOperadorAcesso), True));

    {***************}
    {* BAND RESUMO *}
    {************BL*}
    SetBandVisible(BAND_RESUMO, fExibeResumo);
    SetColumnVisible('ITE_MKPPRO', fExibeResumo);
    SetColumnVisible('ITE_ENCPRO', fExibeResumo);
    SetColumnVisible('ITE_MARPRO', fExibeResumo);

    cxgItensITE_UNITAR.Caption := IIF(blnUsaUniLiq,'Vr.Unitário Líquido','Vr.Unitário');
    SetColumnVisible('ITE_UNIDIG', blnUsaUniLiq);
    SetColumnVisible('ITE_TAXJUR', blnUsaUniLiq And blnPodeAplicarTaxaJurosPrecoDigitado);

    cxgItensViewITE_MARPRO.Caption := fCfgSis('TCOMTB');

    {***********************}
    {* BAND TRAVAS MÍNIMAS *}
    {***********************}
    blnHabTravasMinimas := fHabilitaBandTravasMinimas;
    SetBandVisible(BAND_TRAVAS_MINIMAS, blnHabTravasMinimas);
    SetColumnVisible('TRM_DESMAX', blnHabTravasMinimas);
    SetColumnVisible('TRM_VLRMIN', blnHabTravasMinimas);
    SetColumnVisible('TRM_TOTMIN', blnHabTravasMinimas);

    If (Self.blnTintaDeMaquina) Then
    Begin
      SetBandVisible(BAND_CAT_17, False);
      SetBandVisible(BAND_PRECO_IDEAL, False);
      SetBandVisible(BAND_MARGEM_PRODUTO, False);

      OptionsView.Footer := True;
      OptionsView.GroupFooters := gfAlwaysVisible;
      OptionsView.GroupSummaryLayout := gslAlignWithColumnsAndDistribute;

      // (skNone, skSum, skMin, skMax, skCount, skAverage)
      Sumarizar('ITE_UNITAR', skSum, strFormato, True, False, True);
      Sumarizar('ITE_TOTITE', skSum, strFormato, True, False, True);
      Sumarizar('ITE_UNIDIG', skSum, strFormato, True, False, True);
      Sumarizar('ITE_CUSITE', skSum, strFormato, True, False, True);
      Sumarizar('ITE_PRECUS', skSum, strFormato, True, False, True);
      Sumarizar('ITE_PRECU2', skSum, strFormato, True, False, True);
      If (TMargemMinima.UsaPrecoBruto) Then
        Sumarizar('ITE_PREMED'    , skSum, strFormato, True, False, True)
      Else  
        Sumarizar('ITE_PREMED_LIQ', skSum, strFormato, True, False, True);
      Sumarizar('ITE_OUTVAL', skSum, strFormato, True, False, True);
      Sumarizar('ITE_ICMSAI', skSum, strFormato, True, False, True);
      Sumarizar('ITE_IMPFED', skSum, strFormato, True, False, True);
      Sumarizar('ITE_DESOPE', skSum, strFormato, True, False, True);
      Sumarizar('ITE_CUSIMP', skSum, strFormato, True, False, True);
      Sumarizar('ITE_PREULT', skSum, strFormato, True, False, True);
      Sumarizar('ITE_QTDITE', skSum, strFormato, True, False, True);
      Sumarizar('ITE_UNIORI', skSum, strFormato, True, False, True);
      Sumarizar('ITE_IMPULT', skSum, strFormato, True, False, True);
      Sumarizar('ITE_PRETAB', skSum, strFormato, True, False, True);

      Sumarizar('ITE_MARPRO_PRECUS', skNone, strFormato, True, False, True);
      Sumarizar('ITE_MRPRBT_PRECUS', skNone, strFormato, True, False, True);
      Sumarizar('ITE_MARPRA_PRECUS', skNone, strFormato, True, False, True);
      Sumarizar('ITE_MARPRO_CUSITE', skNone, strFormato, True, False, True);
      Sumarizar('ITE_MARPRA_CUSITE', skNone, strFormato, True, False, True);
      Sumarizar('ITE_MARBRU_PREMED', skNone, strFormato, True, False, True);
      Sumarizar('ITE_MRPRBT_PREMED', skNone, strFormato, True, False, True);
      Sumarizar('ITE_MARLIQ_PREMED', skNone, strFormato, True, False, True);
      Sumarizar('ITE_MARBRU_PREULT', skNone, strFormato, True, False, True);
      Sumarizar('ITE_MARLIQ_PREULT', skNone, strFormato, True, False, True);
      Sumarizar('ITE_MARBRU_IMPULT', skNone, strFormato, True, False, True);
      Sumarizar('ITE_MARLIQ_IMPULT', skNone, strFormato, True, False, True);

      // FAZ O AGRUPAMENTO NO CXGRID
      GetColumnByFieldName('ITE_DESTIN').GroupBy(0, False);
      GetColumnByFieldName('ITE_TIPTMQ').GroupBy(1, False);
    End;

    pDesativaColunas;

    NavigatorButtons.First.Click;
  End;
end;

procedure TfrmFatMostraMargemNovo.pProcessaSaldoDisponivel;
var
  strExMaF4: String;
begin
  If Not Assigned(Self.fatVenda) Then
    Exit;

  strExMaF4 := fCfgSis('EXMAF4');

  If Not (IIF(((Not fEmptyStr(strExMaF4)) And (Length(strExMaF4) >= 8)),(strExMaF4[6] = 'S'), False)) Then
    Exit;

  Try
    cdsItens.DisableControls;

    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      cdsItens.Edit;
      cdsItens.FieldByName('ITE_SALDOS').AsFloat := fRetornaSaldoDisponivel(cdsItens.FieldByName('ITE_CODITE').AsString,
                                                                            IIF(cdsItens.FieldByName('ITE_TIPTMQ').AsString = fGetTipoAsString(tmctColoranteImobiliario), True, False),
                                                                            True,
                                                                            IIF(cdsItens.FieldByName('ITE_NUMLOT').AsString = 'A DEFINIR', '', cdsItens.FieldByName('ITE_NUMLOT').AsString),
                                                                            True,
                                                                            IIF(fatVenda.blnEnt_CD, fatVenda.strEmp_CD, VS_strCodEmp));
      cdsItens.Post;

      cdsItens.Next;
    End;
  Finally
    cdsItens.EnableControls;
  End;
end;

procedure TfrmFatMostraMargemNovo.pProcessaGiroDiasEstoque;
var
  strExMaF4: String;
begin
  strExMaF4 := fCfgSis('EXMAF4');

  If ((fEmptyStr(strExMaF4)) Or (Length(strExMaF4) < 11) Or (strExMaF4[11] = 'N')) Then
    Exit;

  cdsItens.DisableControls;
  Try
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      cdsItens.Edit;
      cdsItens.FieldByName('GIR_DIAEST').AsFloat := fRetornaDiasEstoque(cdsItens.FieldByName('ITE_CODITE').AsString);
      cdsItens.Post;

      cdsItens.Next;
    End;
  Finally
    cdsItens.EnableControls;
  End;
end;

function TfrmFatMostraMargemNovo.fRetornaDiasEstoque(strCodIte: String): Double;
  Var
    qryTmp : TUniQuery;
    strSQL : String;
    intAno : Integer;
    intMes : Integer;
    intQtdMeses : Integer;
    intContador : Integer;
    fltSomaMeses: Double;
    fltMediaMeses: Double;
    fltSaldos : Double;
    arrMes : Array Of Array[0..1] Of String ;
    strAnos : String;
begin
  strAnos      := '';
  fltSomaMeses := 0;
  intQtdMeses  := fCfgSis('QTDMGR', varInteger);

  If (intQtdMeses = 0) Or (fEmptyStr(strCodIte)) Then
  Begin
    Result := 0;
    Exit;
  End;

  intAno  := YearOf(VS_Date);
  intMes  := MonthOf(VS_Date);
  strAnos := IntToStr(intAno);

  For intContador := 0 to Pred(intQtdMeses) Do
  Begin
    If ((intMes-1) = 0) Then
    Begin
      intMes := 12;
      intAno := intAno-1;
      strAnos := strAnos + ',' + IntToStr(intAno)
    End
    Else
      intMes := intMes - 1;

    SetLength(arrMes, Length(arrMes)+1);
    arrMes[intContador][0] := fStrZero(IntToStr(intMes), 2);
    arrMes[intContador][1] := fStrZero(IntToStr(intAno), 2);
  End;

  strSQL := '';
  strSQL := strSQL + ' SELECT * FROM GIRITE ';
  strSQL := strSQL + ' WHERE GIR_CODITE = :CODITE ';
  strSQL := strSQL + ' AND GIR_CODEMP = :CODEMP ';
  strSQL := strSQL + ' AND GIR_A_N_O_ IN ('+fRetStrToSQLIn(strAnos, ',')+'); ';

  qryTmp := fCriaQuery(Self);
  Try
    qryTmp.SQL.Text := strSQL;
    qryTmp.ParamByName('CODITE').AsString := strCodIte;
    qryTmp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTmp.Open();

    For intContador := 0 To Length(arrMes)-1 Do
    Begin
      If qryTmp.Locate('GIR_A_N_O_', arrMes[intContador][1], []) Then
        fltSomaMeses := fltSomaMeses + StrToFloatDef(qryTmp.FieldByName('GIR_QSAI'+arrMes[intContador][0]).AsString, 0);
    End;

    strSQL := '';
    strSQL := strSQL + ' SELECT SUM(I.ITE_SALDOS + (IFNULL(I.ITE_SAL_ML, 0) / IF(IFNULL(P.ITE_CNV_ML, 0) <= 0, 1, P.ITE_CNV_ML))) AS SALDOS ';
    strSQL := strSQL + ' FROM ITEGER I, CADITE P ';
    strSQL := strSQL + ' WHERE I.ITE_CODITE = P.ITE_CODITE ';
    strSQL := strSQL + ' AND P.ITE_CODITE = :CODITE ';
    strSQL := strSQL + ' AND I.ITE_CODEMP = :CODEMP; ';
    qryTmp.SQL.Text := strSQL;
    qryTmp.ParamByName('CODITE').AsString := strCodIte;
    qryTmp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTmp.Open();

    fltSaldos := StrToFloatDef(qryTmp.FieldByName('SALDOS').AsString, 0);

    fltMediaMeses := RoundTo(fltSomaMeses / intQtdMeses, -2) / 30;
    If fltMediaMeses > 0 Then
      Result := RoundTo(fltSaldos / fltMediaMeses, -2)
    Else
      Result := 0;
  Finally
    FreeAndNil(qryTmp);
  End;
end;

procedure TfrmFatMostraMargemNovo.pVerificaBotoes(pnlPanel: TFlowPanel; blnHabilita: Boolean);
  Var
    intCnt : Integer;
begin
  For intCnt := 0 To pnlPanel.ControlCount-1 Do
    If (pnlPanel.Controls[intCnt] Is TBitBtnLocked) Then
      If ((pnlPanel.Controls[intCnt] As TBitBtnLocked).Visible) Then
        (pnlPanel.Controls[intCnt] As TBitBtnLocked).Enabled := blnHabilita;
end;

procedure TfrmFatMostraMargemNovo.pVerificaPreTab;
begin
  cxgItensView.Columns[cxgItensITE_PRETAB.Index].Visible := False;

  if cdsItens.FindField('ITE_PRETAB') = nil then
    Exit;

  cdsItens.First;

  while not cdsItens.Eof do
  begin
    if (cdsItens.FieldByName('ITE_UNIORI').AsFloat <> cdsItens.FieldByName('ITE_PRETAB').AsFloat) then
    begin
      cxgItensView.Columns[cxgItensITE_PRETAB.Index].Visible := True;
      cxgItensView.Columns[cxgItensITE_PRETAB.Index].Position.ColIndex := cxgItensView.Columns[cxgItensITE_UNIORI.Index].Position.ColIndex + 1;
      Break;
    end;

    cdsItens.Next;
  end;
end;

procedure TfrmFatMostraMargemNovo.Sumarizar(const strNomeCampo: String; const summaryKind: TcxSummaryKind; const strFormato: string; const blnFooter,
  blnGroup, blnGroupFooter: Boolean);
begin
  if blnFooter then
  begin
    cxgItensView.Columns[cxgItensView.DataController.GetItemByFieldName(strNomeCampo).Index].Summary.FooterKind := summaryKind;
    cxgItensView.Columns[cxgItensView.DataController.GetItemByFieldName(strNomeCampo).Index].Summary.FooterFormat := strFormato;
  end;

  if blnGroup then
  begin
    cxgItensView.Columns[cxgItensView.DataController.GetItemByFieldName(strNomeCampo).Index].Summary.GroupKind := summaryKind;
    cxgItensView.Columns[cxgItensView.DataController.GetItemByFieldName(strNomeCampo).Index].Summary.GroupFormat:= strFormato;
  end;

  if blnGroupFooter then
  begin
    cxgItensView.Columns[cxgItensView.DataController.GetItemByFieldName(strNomeCampo).Index].Summary.GroupFooterKind := summaryKind;
    cxgItensView.Columns[cxgItensView.DataController.GetItemByFieldName(strNomeCampo).Index].Summary.GroupFooterFormat := strFormato;
  end;
end;

function TfrmFatMostraMargemNovo.fExibeResumo: Boolean;
begin
  Result := ((fCfgSis('MARMKP') = '3') And fCfgSis('EMKPF4', VarBoolean));
end;

procedure TfrmFatMostraMargemNovo.pCalculaResumo;
var
  prcScroll: TprcScroll;

  function fRetornaMargem: Double;
  var
    fltMkpCus: Double;
    fltEncPro: Double;
    fltMarPra: Double;
    fltMkpPro: Double;
    fltIndPro: Double;
  Begin
    fltMarPra := cdsItens.FieldByName('ITE_MARPRA_CUSITE').AsFloat;
    fltMkpPro := cdsItens.FieldByName('ITE_MKPPRO').AsFloat;
    fltIndPro := cdsItens.FieldByName('ITE_INDPRO').AsFloat;
    fltEncPro := cdsItens.FieldByName('ITE_ENCPRO').AsFloat;

    fltMkpCus := (1 - (fltEncPro / 100));

    Result := (fltMarPra - fltMkpPro);
    Result := Result / (1 + (fltMkpPro / 100));
    Result := Result * fltMkpCus;
    Result := Result - fltIndPro;
  End;

begin
  If not fExibeResumo Then
    Exit;

  Try
    pDisableControls(cdsItens, prcScroll);

    cdsItens.First;
    While not cdsItens.eof Do
    Begin
      If (cdsItens.FieldByName('ITE_SEQUEN').AsInteger < 99997) then
      Begin
        cdsItens.Edit;
        cdsItens.FieldByName('ITE_MARPRO').AsFloat := fRetornaMargem;
        cdsItens.Post;
      End;

      cdsItens.Next;
    End;

  Finally
    pEnableControls(cdsItens, prcScroll);
  End;

End;

function TfrmFatMostraMargemNovo.fCalculaUnitario(fltUniDig, fltUnitar, fltTaxJur: Double; out fltUniLiq: Double): Double;
Var
  intIteracoes: Integer;
  fltLimiteInferior: Double;
  fltLimiteSuperior: Double;
  fltValorDesejado: Double;
begin
  Result := fFormataFloat(fltUniDig, fatVenda.VS_intDecUni);

  fltLimiteInferior := 0.0;
  fltLimiteSuperior := Max(fltUniDig, fltUnitar) * 100;
  fltValorDesejado  := fltUnitar;

  If Not Assigned(fatVenda) Then
    Exit;

  For intIteracoes := 1 To 100 Do
  Begin
    fltUnitar := fStrToFloat(FormatFloat(fMskDigitos(fatVenda.VS_intDecUni), (fltLimiteInferior + fltLimiteSuperior) / 2));

    fltUniDig := fCalculaUnitarioLiquido(fltUnitar, fltTaxJur);

    If fltValorDesejado = fltUniDig Then
      Break;

    If fltUniDig < fltValorDesejado Then
    Begin
      If fltUnitar = fltLimiteInferior Then
        Break;

      fltLimiteInferior := fltUnitar;
    End
    Else
    Begin
      If fltUnitar = fltLimiteSuperior Then
        Break;

      fltLimiteSuperior := fltUnitar;
    End
  End;

  fltUniLiq := fFormataFloat(fltUniDig, intDecUni);
  Result := fFormataFloat(fltUnitar, intDecUni);
end;

function TfrmFatMostraMargemNovo.fCalculaUnitarioLiquido(fltUnitar, fltTaxJur: Double): Double;
Var
  fltUniLiq: Double;
begin
  Result := fltUnitar;

  fltUniLiq := fFormataFloat(fltUnitar, fatVenda.VS_intDecUni);

  If Not Assigned(fatVenda) Then
    Exit;

  If fatVenda.fAplicaTaxaJuros And fAplicarTaxaJurosPrecoDigitado Then
    fltUniLiq := fltUniLiq + (fltUniLiq * fltTaxJur / 100.0);

  Result := fFormataFloat(fltUniLiq, fatVenda.VS_intDecUni);
end;

procedure TfrmFatMostraMargemNovo.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  If not cdsItens.isEmpty Then
  Begin
    TfrmGravando.fExecutarModalA(pMarcarTodos, 'Marcando documentos . . .', '');
  End;
end;

procedure TfrmFatMostraMargemNovo.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  If not cdsItens.isEmpty Then
  Begin
    TfrmGravando.fExecutarModalA(pDesmarcarTodos, 'Desmarcando documentos . . .', '');
  End;
end;

procedure TfrmFatMostraMargemNovo.cxgItensITE_DESITEPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If not fEmptyStr(DisplayValue) Then
    DisplayValue := '%' + VarToStr( DisplayValue ) + '%' ;
end;

procedure TfrmFatMostraMargemNovo.cxgItensViewDataControllerFilterChanged(
  Sender: TObject);
begin
  inherited;

  If cxgItensView.DataController.FilteredRecordCount <> cxgItensView.DataController.RecordCount Then
  Begin
    Try
      blnRecalculandoItens := True;
      cdsItens.DisableControls;
      cdsItens.First;
      While not cdsItens.eof Do
      Begin
        cdsItens.Edit;
        cdsItens.FieldByName('SELECIONADO').AsString := 'N';
        cdsItens.Post;

        cdsItens.Next;
      End;
    Finally
      cdsItens.EnableControls;
      blnRecalculandoItens := False;
    End;
  End;

  pSelecionarRegistros(True);

end;

procedure TfrmFatMostraMargemNovo.pMarcarTodos;
begin
  pSelecionarRegistros(True);
end;

procedure TfrmFatMostraMargemNovo.pDesmarcarTodos;
begin
  pSelecionarRegistros(False);
end;

procedure TfrmFatMostraMargemNovo.pSelecionarRegistros(blnMarcar: Boolean);
var
  LIndex   : Integer;
  LAutInc  : String;
  LContador: Integer;
begin
  Try
    blnRecalculandoItens := True;
    cdsItens.DisableControls;
    For LContador := 0 to cxgItensView.DataController.FilteredRecordCount - 1 do
    begin
      LIndex  := cxgItensView.DataController.FilteredRecordIndex[LContador];
      LAutInc := cxgItensView.DataController.Values[LIndex, cxgItensViewITE_ORDITE.Index];

      If cdsItens.Locate('ITE_ORDITE', LAutInc, []) then
      begin
        If (cdsItens.FieldByName('ITE_SEQUEN').AsInteger < 99997) Then
        Begin
          cdsItens.Edit;
          cdsItens.FieldByName('SELECIONADO').AsString := IIF(blnMarcar, 'S', 'N');
          cdsItens.Post;
        End;
      end;

      If (LContador Mod 20 = 0) Then
        Application.ProcessMessages;
    end;
  Finally
    cdsItens.First;
    cdsItens.EnableControls;
    blnRecalculandoItens := False;
  End;
end;

function TfrmFatMostraMargemNovo.fDocumentosSelecionados: Integer;
var
  LRecno: Integer;
Begin
  Result := 0;

  LRecno := cdsItens.recno;
  Try
    cdsItens.DisableControls;
    cdsItens.First;
    While not cdsItens.eof Do
    Begin
      If cdsItens.FieldByName('SELECIONADO').AsString = 'S' Then
      Begin
        inc(Result);
      End;

      cdsItens.Next;
    End;
  Finally
    cdsItens.Recno := LRecno;
    cdsItens.EnableControls;
  End;

End;

procedure TfrmFatMostraMargemNovo.pDesativaColunas;
var
  intBnd: Integer;
  intCol: Integer;
Begin
  For intBnd := 0 To cxgItensView.Bands.Count-1 Do
  Begin
    For intCol := 0 To cxgItensView.ColumnCount -1 Do
    Begin
      If (cxgItensView.Columns[intCol].Position.BandIndex = cxgItensView.Bands[intBnd].Index) And
         (not cxgItensView.Bands[intBnd].Visible) And cxgItensView.Columns[intCol].Visible Then
      Begin
        cxgItensView.Columns[intCol].Visible := False;
      End;
    End;
  End;
End;

end.
