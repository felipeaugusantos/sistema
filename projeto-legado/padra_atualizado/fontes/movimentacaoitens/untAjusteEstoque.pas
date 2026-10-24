{***************************}
{* qryConOpe -> CADOPE     *}
{* qryConCit -> CADITE     *}
{* qryConIte -> ITEGER     *}
{************************JB*}
unit untAjusteEstoque;

interface

uses
  Windows, Classes, Controls, Forms,
  StdCtrls, untPaiSimples, DBGridCitel, DBGrids, EditFocus,
  MaskEditFocus, ComCtrls, Buttons, ExtCtrls, DB, QColorLabel,
  Uni, untCadLote, UniClientDataSet, untAjudaPorAbas,
  untFuncoesSimples, untObservacao, cxProgressbar, Vcl.Graphics,
  BitBtnLockedIncrem, Menus, Mask, Grids, AppEvnts, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxButtons,
  untCustoItemFaturamento, untValidaCapacidadeMaximaLote, untSaldoLojas,
  untAuditoriaGravacaoSaldo,

  Fulfillment.Constantes;

type

  TResultEdt = Record
    edtRefCodIte : TEditFocus;
    edtRefDesIte : TEditFocus;
    edtRefRefere : TEditFocus;
    edtRefEntSai : TEditFocus;
    edtRefTipAju : TEditFocus;
    edtRefSaldos : TEditFocus;
    edtRefQtdIte : TEditFocus;
    edtRefUnitar : TEditFocus;
    edtRefTotIte : TEditFocus;
    edtRefNumLot : TEditFocus;
    edtRefSal_Ml : TEditFocus;
    edtRefSalDis : TEditFocus;
    edtRefUnidad : TEditFocus;
    blnSaida     : Boolean;
  End;

  TTipoAjuste = (tajVazio, tajNormal, tajAcabado);

  TDirAcessEntSai = Set Of (tdaEntrada, tdaSaida, tdaTodos);

  TRecItensNumeroSerie = Record
    strAutInc: String;
    strCodIte: String;
    strDesIte: String;
    fltQtdIte: Double;
    strEmpDoc: String;
    strEmpIte: String;
    strTabDev: String;
  End;

  TArrayItensNumeroSerie = Array of TRecItensNumeroSerie;

  TfrmAjusteEstoque = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    pnlItemContainer: TPanel;
    dbgItens: TDBGridCitel;
    pnlDetalhe: TPanel;
    Label32: TLabel;
    pnlBotoesEnt: TPanel;
    Label1: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    edtCodCli: TEditFocus;
    Label4: TLabel;
    mskDtaEnt: TMaskEditFocus;
    Label5: TLabel;
    edtCodVen: TEditFocus;
    lblObserv: TLabel;
    edtObse01: TEditFocus;
    edtObse02: TEditFocus;
    pgbItens: TProgressBar;
    edtNomCli: TEditFocus;
    edtNomVen: TEditFocus;
    edtTotGer: TEditFocus;
    lblDigita: TLabel;
    edtCodDig: TEditFocus;
    edtNomDig: TEditFocus;
    dtsAjuste: TDataSource;
    btnConfirma: TBitBtnLocked;
    btnCancelarEntrada: TBitBtnLocked;
    btnEstLoj: TBitBtnLocked;
    pnlItemEnt: TPanel;
    Label10: TLabel;
    Label26: TLabel;
    lblTipMov: TLabel;
    Label11: TLabel;
    lblTipAju: TLabel;
    lblDesTipAju: TColorLabel;
    lblSalMl: TLabel;
    lblNumLot: TLabel;
    edtCodIte: TEditFocus;
    edtEntSai: TEditFocus;
    edtDesIte: TEditFocus;
    edtRefere: TEditFocus;
    edtUnidade: TEditFocus;
    edtSaldos: TEditFocus;
    edtTipAju: TEditFocus;
    edtSalMl: TEditFocus;
    edtNumLot: TEditFocus;
    pnlItemSai: TPanel;
    lblMarBruLXA: TLabel;
    lblMBLxA: TLabel;
    lblMarliqLXA: TLabel;
    lblEspessura: TLabel;
    lblMLLxA: TLabel;
    lblQtdChapa: TLabel;
    edtQtdChapa: TEditFocus;
    Label9: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    ColorLabel1: TColorLabel;
    lblTipAjuSai: TLabel;
    lblDesTipAjuSai: TColorLabel;
    lblSalMlSai: TLabel;
    lblNumLotSai: TLabel;
    edtCodIteSai: TEditFocus;
    edtQtdIteSai: TEditFocus;
    edtUnitarSai: TEditFocus;
    edtTotIteSai: TEditFocus;
    edtEntSaiSai: TEditFocus;
    edtDesIteSai: TEditFocus;
    edtRefereSai: TEditFocus;
    edtUnidadeSai: TEditFocus;
    edtSaldosSai: TEditFocus;
    edtTipAjuSai: TEditFocus;
    edtSalMlSai: TEditFocus;
    edtNumLotSai: TEditFocus;
    clbTipoMovimento: TColorLabel;
    lblItemEntrada: TLabel;
    lblItemSaida: TLabel;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    lblEmpSalExt: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    pnlOpcCod: TPanel;
    rdbCodIte: TRadioButton;
    rdbProAca: TRadioButton;
    pnlSaldoProAca: TPanel;
    rdbComSaldo: TRadioButton;
    rdbTodos: TRadioButton;
    edtToItem: TEditFocus;
    Label6: TLabel;
    pnlOcorrencia: TPanel;
    lbl2: TLabel;
    lblHisCom: TLabel;
    edtCodOco: TEditFocus;
    edtDesOco: TEditFocus;
    edtHisCom: TEditFocus;
    lblLotExt: TLabel;
    edtLotExt: TEditFocus;
    lblSaldoDisponivel: TLabel;
    edtSaldoDisponivel: TEditFocus;
    pnlQuantidade: TPanel;
    lblQuantidade: TLabel;
    edtQtdIte: TEditFocus;
    Label16: TLabel;
    edtUnitar: TEditFocus;
    Label18: TLabel;
    edtTotIte: TEditFocus;
    pnlMedidasMarmore: TPanel;
    edtLOT_MEDB_L: TEditFocus;
    edtLOT_MEDB_A: TEditFocus;
    edtLOT_MEDL_L: TEditFocus;
    edtLOT_MEDL_A: TEditFocus;
    edtLOT_ESPESS: TEditFocus;
    lblFinalidade: TLabel;
    edtFinAju: TEditFocus;
    edtDesFinAju: TEditFocus;
    edtSaldoDisponivelSaida: TEditFocus;
    lblSaldoDisponivelSaida: TLabel;
    chkSubPro: TCheckBox;
    btnImportarPlanilha: TBitBtnLocked;
    pnlInfoPlan: TPanel;
    lblInfoPlan: TLabel;
    lblObsAdc: TLabel;
    edtObsAdc: TEditFocus;
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure pAdicionarItem(Sender: TEditFocus);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelarEntradaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtEntSaiKeyPress(Sender: TObject; var Key: Char);
    procedure edtTipAjuExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormPaint(Sender: TObject);
    procedure edtNumLotKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure rdbCodIteClick(Sender: TObject);
    procedure rdbProAcaClick(Sender: TObject);
    procedure btnEstLojClick(Sender: TObject);
    procedure dtsAjusteDataChange(Sender: TObject; Field: TField);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOcoExit(Sender: TObject);
    procedure edtCodOcoKeyPress(Sender: TObject; var Key: Char);
    procedure edtFinAjuKeyPress(Sender: TObject; var Key: Char);
    procedure btnImportarPlanilhaClick(Sender: TObject);
  private
    {*******************************************}
    {* TABELA AUXILIAR PARA TINTA. USADA POR   *}
    {* EXEMPLO, PARA A TABELA qryMixFor (LAZ)  *}
    {****************************************LA*}
    blnMarmoreAtivo: Boolean;
    strUniAca: String;
    blnAJSOOC: Boolean;
    qryConOco: TUniQuery;

    blnEXIAJU,
    FblnAjuContrPart : boolean;
    intQtdItens: integer;
    intQtdMaxItens: Integer;
    FblnAjuSaldoExterno: boolean;
    blnVariasChapasPorLote: Boolean;
    FMsgAjusteSaldoExternoInicial: String;
    intIdAgrupador: Integer;
    intTamCod     : Integer;
    tajAjuste  : TTipoAjuste;
    dicRetorno : TDicionario;
    qryTinta   : TUniQuery;
    qryTintaAux: TUniQuery;
    strCodAca,
    strEmpAca  : String;

    objCadLot    : TCadLot;
    cdsAjuste    : TUniClientDataSet;

    strEspDoc    : String;
    strPreAju    : String;
    strImpAju    : String;
    blnFecharTela: Boolean;
    strCodOpe    : String;
    intDecQtd    : Integer;
    strNumDocAJ  : String;
    strNumDocML  : String;
    daEntSai     : TDirAcessEntSai;

    blnLiberacaoAcimaDaCapacidadeMax: Boolean;

    qryConIte: TUniQuery;
    qryConOpe: TUniQuery;
    qryConCit: TUniQuery;

    fltCusLot,
    fltIteSalMl    : Double;
    fltIteSaldos   : Double;
    intQtdReajuste : integer;
    strIteUsaSer   : String;

    objCustoItem : ICustoItemFaturamento;
    recCustoItem : TRecResulCusto;

    intCtlEst: Integer;

    objAuditoriaSaldo: IAuditoriaGravacaoSaldo;

    FChaveLockAjusteFul: String;
    FHubMkp: String;
    FDtaPlanilha: TDateTime;
    FHraPlanilha: TTime;
    FItensPlan: TStringList;
    FItensSalNeg: TStringList;
    FAjuPlan: TUniClientDataSet;

    FImportacaoPlanilha: Boolean;
    FZerarEstItensEmpExt: Boolean;
    FfltQtdAjusteMax: Double; // Req. 457063 - cache do valor maximo de MOVDET.DET_QTDITE (-1 = nao calculado)
    FintQtdAjusteCasasDec: Integer; // Req. 457063 - cache das casas decimais de MOVDET.DET_QTDITE (-1 = nao calculado)

    FColumnNumLot: TColumn;

    function  fHabilitouCustoPorTabelaDePreco : Boolean;
    function  fRetornaTabelaCusto : String;
    procedure pCarregaValoresCusto(strCodIte, strCodEmp, strTabPre : String);

    function fExisteAjuste(strNumDoc, strEspDoc: String): Boolean;
    function fProximoAjuste(strEspDoc: String): String;
    Procedure pAtualizaSequencial(strCfgSis: String; intValor: Integer);


    procedure pSetaTipoAjuste;
    procedure pMostraLote(blnMostrar: Boolean; Sender: TEditFocus);
    function fRetMensagemErroLimite: String;

    procedure pImprime(strNumDoc, strEspDoc: String; intQtd: Integer);
    procedure pImprimeTicketIF(strNumDoc, strEspDoc, strCodCli: String; intQtd: Integer);
    function fRegraItemMarmore(strCodIte: String): Boolean;

    procedure pLimpaDadosItem(Sender: TEditFocus);
    procedure pCarregaCliente;
    procedure pCarregaDigitador;
    procedure pCarregaItem(Sender: TEditFocus);
    procedure pSetarDireitoDeAcesso(strCodOpe: String);
    procedure pCarregaOcorrencia;

    procedure pCalculaTotalItem(Sender: TEditFocus);
    procedure pCalculaTotalGeral;
    function fQtdAjusteValida(AValor: Double): Boolean; // Req. 457063
    function fQtdAjusteMaxValor: Double; // Req. 457063
    function fQtdAjusteCasasDecimais: Integer; // Req. 457063

    procedure pAtribuiTabelas;
    procedure pHabilitaCampos(Owner: TWinControl; blnHabilita: Boolean);

    procedure pCriaTemporaria;
    procedure pDeletaTemporaria;

    procedure pAdicionaItem(Sender: TEditFocus);
    procedure pAdd(Sender: TEditFocus; AQryConCit : TUniQuery = Nil; AQtdPlanilha: Double = 0);
    procedure pCarregarSubProdutos(Sender: TEditFocus; ACodItePai : String);
    procedure pProcessaPrecoUnitarioETotal(Sender: TEditFocus; AQryConCit : TUniQuery);

    procedure pAlteraItem(Sender: TEditFocus);
    procedure pDeletaItem;

    procedure pCarregaItensAlteracao;
    procedure pLimparTela;

    Function fAggr(FieldAgg: TField): Variant;
    function fValidaCabecalho: Boolean;
    function fConfirmaAjuste: Boolean;
    procedure pAjustaMedidasMarmore(AblnVariasChapasPorMarmore: Boolean);
    function fVerificaQtdEstoque(fltQuantidade: Double; strCodite, strNumLot, strTipoMovimento, strTipAju: String;
                                 blnProAca: Boolean; fltSalAca, fltSalDis: Double): Boolean;
    function fRetQtdDigitada(strNumLot, strCodIte: String): Double;
    Function fRetPrecoLote(strCodIte, strNumLot: String; Var fltCusLot: Double): Boolean;

    function fGetStatusItem(strCodIte : String) : String;
    procedure pHabilitaTipAju(blnHabilitar: Boolean; Sender: TEditFocus);
    function fPodeInserir(strTipAju: String): Boolean;
    procedure pTravaItemFracionadoKey(Sender: TObject; var Key: Char);
    function fTabPreco: String;
    function fTabPrecoImp: String;
    Function fPesquisaProdutoAcabado: Boolean;
    Function fProdutosMesmoTipo: Boolean;
    function fGetSqlIteGer : String;
    procedure SetblnAjuContrPart(const Value: boolean);
    procedure SetblnAjuSaldoExterno(const Value: boolean);
    Function fGetSaldoLote(strNumLot, strCodIte, strCodEmp: String):String;

    function fGetNumeroLote: String;
    function fTemMovimentoProgramadoEmAberto(strCodIte, strLote: string): Boolean;
    procedure pMostraMensagemMovimentoProgramadoEmAberto(strCodIte, strLote: string);
    function fRetornaSaldoItem: Double;
    procedure pAdicionarItensPlanilha(cdsItens: TUniClientDataSet);

    procedure pCriaDataSetAjustePlanilha;
    procedure pDestravaLockAjusteFul;
    procedure pCalculaAjusteEstExtPlanilha;
    function fBloqueiaImportacaoFul: Boolean;
    function fQtdeItensMOVDETAposPlanilha(ACodIte: String): Double;
    function fZerarEstoqueExtItensForaDaPlanilha(pgbProgresso: TcxProgressBar): Boolean;
    function fConfirmaAjusteEstoqueExtPlanilha: Boolean;
    procedure pAjustaObsAdicional;
    function fValidaAcessoFinAjuEstoque(AStrCodAju: String): Boolean;
    function fInformarNumeroSerie(arrItensSerieEntrada, arrItensSerieSaida:TArrayItensNumeroSerie): Boolean;
    function fInformarNumeroSerieEntrada(arrItensSerieEntrada:TArrayItensNumeroSerie): Boolean;
    function fInformarNumeroSerieSaida(arrItensSerieSaida:TArrayItensNumeroSerie): Boolean;
    function fAjustaNumeroSerieEntrada(arrSeriesEntrada: TArrayItensNumeroSerieDevolucao): Boolean;
    procedure pCarregaFinalidadeConfigurada;
    function fFindColumn(AStrFieldName: String): TColumn;
    function fLiberaAjuste: Boolean;
    { Private declarations }
  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fRetPrecoVendaLote(strCodIte: String; strNumLot: String): Double;

    function fControleOrigemContraPartida(Sender: TEditFocus): Boolean;
    function fGetEdt(Sender: TEditFocus) : TResultEdt;

    function fHabilitarControlesItem(Sender: TWinControl; blnBuscaPorChave: Boolean) : Boolean;
    function fMostrarOpcaoDeCarregamentoDosSubProdutos : Boolean;
  public
    property blnAjuContrPart: boolean read FblnAjuContrPart write SetblnAjuContrPart default false;
    property blnAjuSaldoExterno: boolean read FblnAjuSaldoExterno write SetblnAjuSaldoExterno default false;
    { Public declarations }
  end;

implementation

uses SysUtils, Variants, StrUtils, Math, untFuncoes, untPesqAux, untPai, untFuncFat,
  untMovGer, untCadIte, untConsultas, untFatMostraEstoqueEmp, untProdAcabado,
  untFuncTinta, untConstantes, untTypesSistema, untPanelCxItem,
  untPnlDadosItem, untTestabilidade, untMsgLiberacao, untIFatEntregaFutura,
  untTFatEntregaFutura, untFuncFatTypes, untImportarPlanilhaAjusteEstoque,
  untFatImpressao, untGravando, untConfirmaAjusteEstoqueExtPlanilha, untTFatReservaSaldo,
  untIFatReservaSaldo, untFatSeriesItensDevolucao, untTNumeroSerie,
  untNumeroSerieSaidaAjuste, untLiberacao, Fulfillment.RegrasMovimentacaoEstoque;

Var
  StrCodVen: String;

{$R *.dfm}

function TfrmAjusteEstoque.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  var
    blnSaida: boolean;
    edtRefQtdIte,
    edtRefCodIte,
    edtRefNumLot,
    edtRefUnidade,
    edtRefEntSai,
    edtRefTipAju,
    edtRefSalMl,
    edtRefSaldos: TEditFocus;
    strEntSai: String;
    fltUnitar: Double;
    cdsData: TUniClientDataSet;
begin
  Result := True;

  blnSaida := False;
  cdsData     := Nil;

  If Sender is TEditFocus then
     blnSaida := fControleOrigemContraPartida(TEditFocus(Sender));
  If blnSaida  then
  Begin
    if not FblnAjuContrPart then
      Exit;
    edtRefQtdIte := edtQtdIteSai;
    edtRefCodIte := edtCodIteSai;
    edtRefNumLot := edtNumLotSai;
    edtRefSaldos := edtSaldosSai;
    edtRefEntSai := edtEntSaiSai;
    edtRefTipAju := edtTipAjuSai;
    edtRefUnidade := edtUnidadeSai;
    edtRefSalMl := edtSalMlSai;
  End
  Else
  Begin
    edtRefQtdIte := edtQtdIte;
    edtRefCodIte := edtCodIte;
    edtRefNumLot := edtNumLot;
    edtRefSaldos := edtSaldos;
    edtRefEntSai := edtEntSai;
    edtRefTipAju := edtTipAju;
    edtRefUnidade := edtUnidade;
    edtRefSalMl := edtSalMl;
  End;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodCli) Then
    Begin

      If Not fEmptyStr(edtCodCli.Text) Then
      Begin
        pCarregaCliente;
        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('','Cliente não encontrado!',['&OK']);
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'O Cliente deve ser preeenchido!', ['&O k']);
        Result := False;
      End;

    End

    Else If (Sender = edtCodEmpresa) And FblnAjuSaldoExterno Then
    Begin
      If Not fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        edtDesEmpresa.Text := fCampoTabela('EEE_DESEEE', 'CADEEE',  ['EEE_CODEEE'], [edtCodEmpresa.Text]);
        If fEmptyStr(edtDesEmpresa.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Código Empresa Saldo Externo inválido!', ['&O k']);
          Result := False;
        End
        else if (not fBloqueiaImportacaoFul) then
        begin
          edtCodEmpresa.Clear;
          edtDesEmpresa.Clear;
          Result := False;
        end;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'A Empresa Saldo Externo deve ser preeenchido!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodOco) Then
    Begin
      If Not fEmptyStr(edtCodOco.Text) Then
      Begin
        pCarregaOcorrencia;
        If qryConOco.FieldByName('OCO_CODOCO').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa ocorrência não está cadastrada!', ['&O k']);
          Result := False;
        End
      End;
    End

    Else If (Sender = mskDtaEnt) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaEnt.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de Entrada deve ser preeenchida!', ['&O k']);
        pHabilitaCampos(pnlCabecalho, True);
        pHabilitaCampos(pnlItemContainer, False);
        btnConfirma.Enabled := False;
        dbgItens.Enabled    := False;
        Result := False;
      End;

    End


    Else If (Sender = edtLOT_MEDB_L) And (pnlMedidasMarmore.Enabled And pnlMedidasMarmore.Visible) and (not blnVariasChapasPorLote) then
    begin
      If Sender = edtLOT_MEDB_L then
      Begin
        If fEmptyStr(edtLOT_MEDB_L.Text) Then
        begin
          fMensagem('ATENÇÃO!', 'A Medida Bruta - Lagura deve ser preeenchida!', ['&O k']);
          Result := False;
        End

        Else If StrToFloat(edtLOT_MEDB_L.Text) <=0  Then
        begin
          fMensagem('ATENÇÃO!', 'A Medida Bruta - Lagura deve ser mario que zero!', ['&O k']);
          Result := False;
        End
        Else
          edtLOT_MEDB_L.Text :=  FormatFloat(fMskDigitos(intDecQtd), (StrToFloat(edtLOT_MEDB_L.Text)));
      End;
    End

    Else If (Sender = edtLOT_MEDB_A) And (pnlMedidasMarmore.Enabled And pnlMedidasMarmore.Visible)And (not blnVariasChapasPorLote)then
    begin
      If Sender = edtLOT_MEDB_A then
      Begin
        If fEmptyStr(edtLOT_MEDB_A.Text) Then
        begin
          fMensagem('ATENÇÃO!', 'A Medida Bruta - Lagura deve ser preeenchida!', ['&O k']);
          Result := False;
        End
        Else If StrToFloat(edtLOT_MEDB_A.Text) <=0  Then
        begin
          fMensagem('ATENÇÃO!', 'A Medida Bruta - Lagura deve ser mario que zero!', ['&O k']);
          Result := False;
        End
        Else
          edtLOT_MEDB_A.Text :=  FormatFloat(fMskDigitos(intDecQtd), (StrToFloat(edtLOT_MEDB_A.Text)));

      End;
    End

    Else If (Sender = edtLOT_ESPESS) And (pnlMedidasMarmore.Enabled And pnlMedidasMarmore.Visible)And (not blnVariasChapasPorLote)then
    begin
      If Sender = edtLOT_ESPESS then
      Begin
        If fEmptyStr(edtLOT_ESPESS.Text) Then
        begin
          fMensagem('ATENÇÃO!', 'A Espessura deve ser preeenchida!', ['&O k']);
          Result := False;
        End

        Else If StrToFloat(edtLOT_ESPESS.Text) <=0  Then
        begin
          fMensagem('ATENÇÃO!', 'A Espessura deve ser mario que zero!', ['&O k']);
          Result := False;
        End
        Else
          edtLOT_ESPESS.Text :=  FormatFloat(fMskDigitos(intDecQtd), (StrToFloat(edtLOT_ESPESS.Text)));


      End;
    End
    Else If ((Sender = edtLOT_MEDL_L) or (Sender = edtLOT_MEDL_A)) And (pnlMedidasMarmore.Enabled And pnlMedidasMarmore.Visible)And (not blnVariasChapasPorLote)then
    Begin
      If Sender = edtLOT_MEDL_L then
      Begin
        If fEmptyStr(edtLOT_MEDL_L.Text) Then
        begin
          fMensagem('ATENÇÃO!', 'A Medida Líquida - Lagura deve ser preeenchida!', ['&O k']);
          Result := False;
        End
        Else If StrToFloat(edtLOT_MEDL_L.Text) <=0  Then
        begin
          fMensagem('ATENÇÃO!', 'A Medida Líquida - Altura deve ser mario que zero!', ['&O k']);
          Result := False;
        End
        Else
          edtLOT_MEDL_L.Text :=  FormatFloat(fMskDigitos(intDecQtd), (StrToFloat(edtLOT_MEDL_L.Text)));

      End
      Else If (Sender = edtLOT_MEDL_A) And (not blnVariasChapasPorLote) then
      Begin
        If fEmptyStr(edtLOT_MEDL_A.Text) Then
        begin
          fMensagem('ATENÇÃO!', 'A Medida Líquida - Altura deve ser preeenchida!', ['&O k']);
          Result := False;
        End
        Else If StrToFloat(edtLOT_MEDL_A.Text) <=0 Then
        begin
          fMensagem('ATENÇÃO!', 'A Medida Líquida - Lagura deve ser maior que zero!', ['&O k']);
          Result := False;
        End
        Else
          edtLOT_MEDL_A.Text :=  FormatFloat(fMskDigitos(intDecQtd), (StrToFloat(edtLOT_MEDL_A.Text)));

      End;
      If Result And (edtLOT_MEDL_A.Text <> '') And (edtLOT_MEDL_L.Text  <> '')And (not blnVariasChapasPorLote)then
      begin
        edtQtdIte.Text := FormatFloat(fMskDigitos(intDecQtd), (StrToFloat(edtLOT_MEDL_L.Text) * StrToFloat(edtLOT_MEDL_A.Text)));
        pCalculaTotalItem(edtQtdIte);
      End

    End


    Else If (Sender = edtQtdChapa) and (edtQtdChapa.Visible) And (pnlMedidasMarmore.Enabled) And (pnlMedidasMarmore.Visible) Then
    Begin
      If edtQtdChapa.Text = '' Then
      edtQtdChapa.Text := '0';
      If StrToFloat(edtQtdChapa.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Qtd Chapa deve ser maior que zero!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        edtQtdIte.Text := FormatFloat('0.000', fStrToFloat(edtQtdChapa.Text)
                                              * fCampoTabela('LOT_MEDL_A', 'CADLOT', ['LOT_CODITE', 'LOT_CODEMP', 'LOT_NUMLOT' ], [edtCodIte.Text, VS_strCodEmp, edtNumLot.Text])
                                              * fCampoTabela('LOT_MEDL_L', 'CADLOT', ['LOT_CODITE', 'LOT_CODEMP', 'LOT_NUMLOT' ], [edtCodIte.Text, VS_strCodEmp, edtNumLot.Text]));

        edtTotIte.Text := FloatToStrF(fStrToFloat(edtQtdIte.Text) * fStrToFloat(edtUnitar.Text), ffFixed, 12, 2);
      end;
    End
    Else If (Sender = edtCodVen) Then
    Begin
      If fEmptyStr(edtCodVen.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Vendedor deve ser preeenchido!', ['&O k']);
        pHabilitaCampos(pnlCabecalho, True);
        pHabilitaCampos(pnlItemContainer, False);
        btnConfirma.Enabled := False;
        dbgItens.Enabled    := False;
        Result := False;
      End
      Else
      Begin
        If edtCodDig.Visible Then
          StrCodVen := edtCodVen.Text
        Else
          StrCodVen := fRetCodVendedor(edtCodVen.Text);

        If (fEmptyStr(StrCodVen)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Senha do vendedor inválida!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          edtNomVen.Text := fRetNomVendRep(StrCodVen);
          If fEmptyStr(edtNomVen.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Este operador não está cadastrado!', ['&O k']);
            Result := False;
          End;
        End;

      End;

      //Valida o direito de acesso do vendedor quando não tiver digitador
      If (Not blnAjuContrPart) And (Not edtCodDig.Visible) and (Result) Then
      Begin
         pSetarDireitoDeAcesso(StrCodVen);
         If daEntSai = [] Then
         Begin
           fMensagem('ATENÇÃO!', 'Este Vendedor Não Tem Acesso Para Entrada ou Saída No Ajuste de Estoque!', ['&O k']);
           Result := False;
         End;
      End;

    End

    Else If (Sender = edtCodDig) And (edtCodDig.Enabled) Then
    Begin

      If fEmptyStr(edtCodDig.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Digitador deve ser preeenchido!', ['&O k']);
        pHabilitaCampos(pnlCabecalho, True);
        pHabilitaCampos(pnlItemContainer, False);
        btnConfirma.Enabled := False;
        dbgItens.Enabled    := False;
        Result := False;
      End
      Else
      Begin

        pCarregaDigitador;
        If qryConOpe.FieldbyName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse digitador não está cadastrado!', ['&O k']);
          Result := False;
        End;

      End;

      If (Not blnAjuContrPart) And Result Then
      Begin
         pSetarDireitoDeAcesso(qryConOpe.FieldbyName('OPE_CODOPE').AsString);
         If (daEntSai = []) Then
         Begin
           fMensagem('ATENÇÃO!', 'Este Digitador Não Tem Acesso Para Entrada ou Saída No Ajuste de Estoque!', ['&O k']);
           Result := False;
         End;
      End;
    End

    Else If (Sender = edtFinAju) Then
    Begin
      If fEmptyStr(edtFinAju.Text) Then
      Begin
        Result := fMensagem('', 'Informe a finalidade do ajuste!', ['&OK']) = -1;
      End
      Else
      Begin
        edtDesFinAju.Text := fCampoTabela('FAJ_DESCRI', 'FINAJU', ['FAJ_CODIGO'], [edtFinAju.Text]);
        If fEmptyStr(edtDesFinAju.Text) Then
        Begin
          Result := fMensagem('', 'Finalidade do ajuste informada não está cadastrada!', ['&Ok']) = -1;
        End
        Else
        Begin
          If Not fValidaAcessoFinAjuEstoque(edtFinAju.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Operador sem direito de acesso para esta finalidade de ajuste!', ['&O k']);
            Result := False;
          End
          Else
          If FblnAjuContrPart And (fCampoTabela('FAJ_ENTSAI', 'FINAJU', ['FAJ_CODIGO'], [edtFinAju.Text]) <> 'A') Then
          Begin
            fMensagem('ATENÇÃO!', 'Para ajustes de estoque com contra-partida, a finalidade deve ter a operação AMBAS definida!', ['&O k']);
            Result := False;
          End
          Else
            pAjustaObsAdicional;
        End;
      End;

    End

    Else If (fHabilitarControlesItem(Sender, blnBuscaPorChave)) Then
    Begin

      If fValidaCabecalho Then
      Begin

        pHabilitaCampos(pnlCabecalho, False);
        pHabilitaCampos(pnlItemContainer, True);
        btnImportarPlanilha.Enabled := True;
        intQtdItens := 0;
        dbgItens.Enabled := True;
        btnConfirma.Enabled := True;
        blnMudarFoco        := False;
        pSetFocus(edtCodIte);

      End;
    End

    Else If (Sender = edtRefCodIte) Then
    Begin

      If (edtRefCodIte.ReadOnly) Then
      Begin
        Result := False;
      End
      Else If fEmptyStr(edtRefCodIte.Text) Then
      Begin

        If blnBuscaPorChave Then
        Begin
          blnMudarFoco := False;
          pSetFocus(dbgItens);
        End
        Else
        Begin
          fMensagem('ATENÇÃO!', 'O Código do Item deve ser preenchido!', ['&O k']);
          Result := False;
        End;

      End
      Else
      Begin

        pCarregaItem(TEditFocus(Sender));

        If fGetStatusItem(edtRefCodIte.Text) = 'N' Then
        Begin

          fMensagem('ATENÇÃO!', 'Esse item está Inativo!', ['&O k']);
          Result := False;

        End
        Else If qryConCit.FieldByName('ITE_CODITE').IsNull Then
        Begin

          fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
          Result := False;

        End

        Else If qryConCit.FieldByName('ITE_ITEATI').AsString <> 'S' Then
        Begin
          pLimpaDadosItem(edtRefCodIte);
          fMensagem('ATENÇÃO!', 'Esse item está Inativo!', ['&O k']);
          Result := False;
        End

        Else If (qryConIte.FieldByName('ITE_DTABAL').AsDateTime >= VS_Date) Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido vender um item com data de balanço ' + DateToStr(VS_Date) + '. Verifique!', ['&O k']);
          Result := False;
        End;
      End;


    End
    Else If (Sender = edtRefNumLot) Then
    Begin

      If edtRefNumLot.Visible Then
      Begin
        If fEmptyStr(edtRefNumLot.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe o número do ' + objCadLot.strTitLab + '!', ['&Ok']);
          Result := False;
        End

        Else If Not objCadLot.fExisteLote(edtRefCodIte.Text, VS_strCodEmp, edtRefNumLot.Text, True, (not FblnAjuSaldoExterno)) Then
        Begin
          fMensagem('ATENÇÃO!', objCadLot.strTitLab + ' não encontrado!', ['&Ok']);
          Result := False;
        End

        Else If SameText(edtRefNumLot.Text, 'A DEFINIR') Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é possível ajustar o saldo do lote "A DEFINIR"!', ['&Ok']);
          Result := False;
        End

        Else If SameText(edtRefNumLot.Text, 'GARANTIA') Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é possível ajustar o saldo do lote "GARANTIA"!', ['&Ok']);
          Result := False;
        End

        Else If fVerificaLoteTransitorio(edtRefCodIte.Text, edtRefNumLot.Text, VS_strCodEmp) Then
        Begin
          pMensagemOK('Não é permitida a seleção de Lotes Transitórios!');
          Result := False;
        End

        Else If fRegraItemMarmore(edtRefCodIte.Text) And (Not fLoteChapa(edtRefCodIte.Text, VS_strCodEmp, edtRefNumLot.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Para este item só é permitido usar um lote de Chapa!', ['&Ok']);
          Result := False;
        End

        Else If TCadLot.fBloqueiaTranfSaldoLote(edtRefNumLot.Text, '', edtRefCodIte.Text, VS_strCodEmp, True, objCadLot.strTitLab) Then
        Begin
          Result := False;
        End

        Else
        Begin
          If blnSaida And FblnAjuContrPart Then
            edtSaldoDisponivelSaida.Text := fGetSaldoLote(edtNumLotSai.Text, edtCodIteSai.Text, VS_strCodEmp)
          Else
            edtSaldoDisponivel.Text := fGetSaldoLote(edtNumLot.Text, edtCodIte.Text, VS_strCodEmp);

          edtRefSaldos.Text := FormatFloat(fMskDigitos(intDecQtd),
                                           IIF(edtLotExt.Visible,
                                               objCadLot.fSaldoLote(edtRefCodIte.Text, VS_strCodEmp, edtLotExt.Text),
                                               objCadLot.qryCadLot.FieldByName('LOT_SALDOS').AsFloat) -
                                           IIF(fUsaRotinaWMS, fGetSaldoResLotDor(edtCodIte.Text, IIF(edtLotExt.Visible, edtLotExt.Text, edtNumLot.Text), VS_strCodEmp), 0));
         If edtRefSalMl.Visible Then
          edtRefSalMl.Text := FormatFloat(fMskDigitos(intDecQtd), objCadLot.qryCadLot.FieldByName('LOT_SAL_ML').AsFloat -
                                                        IIF(fUsaRotinaWMS, fGetSaldoResLotDor(edtCodIte.Text, edtNumLot.Text, VS_strCodEmp) *
                                                        IIf(qryConCit.FieldByName('ITE_CNV_ML').AsFloat = 0, 1, qryConCit.FieldByName('ITE_CNV_ML').AsFloat), 0));
        End;

        If Result Then
        Begin
          fltCusLot := 0;

          If SameText(strImpAju, 'TOTCUS') And fRetPrecoLote(edtRefCodIte.Text, edtRefNumLot.Text, fltCusLot) Then
          Begin
            fltUnitar := fltCusLot;

            If SameText(edtTipAju.Text, 'G') Then
              edtUnitar.Text := FloatToStrF(fltUnitar / qryConCit.FieldByName('ITE_CNV_ML').AsFloat, ffFixed, 12, 4)
            Else
              edtUnitar.Text := FloatToStrF(fltUnitar, ffFixed, 12, 2);

            pCalculaTotalItem(EdtRefQtdIte);
          End
          Else If fRegraItemMarmore(edtRefCodIte.Text)then
            edtUnitar.Text := FloatToStrF(fRetPrecoVendaLote(edtRefCodIte.Text, edtRefNumLot.Text), ffFixed, 12, 2);

        End;

      End;
    End

    Else If (Sender = edtRefUnidade) Then
    Begin

      If fEmptyStr(edtRefUnidade.Text) Then
      Begin
        Result := False;
        pMensagemOk('Unidade do Produto em branco!');
      End;

    End

    Else If (Sender = edtRefEntSai) Then
    Begin

      strEntSai := Copy(edtRefEntSai.Text, 1, 1);
      If (strEntSai <> 'E') And (strEntSai <> 'S') Then
        Result := False
      Else If (Not blnAjuContrPart) Then
      Begin
        If Not (tdaTodos in daEntSai) Then
        Begin
          If (strEntSai = 'S') And (not(tdaSaida in daEntSai)) Then
          Begin
            Result := False;
            pMensagemOk(IIf(edtCodDig.Visible, 'Digitador', 'Vendedor') + ' sem acesso a Saída!');
          End
          Else
          If (strEntSai = 'E') And (not (tdaEntrada in daEntSai)) Then
          Begin
            Result := False;
            pMensagemOk(IIf(edtCodDig.Visible, 'Digitador', 'Vendedor') + ' sem acesso a Entrada!');
          End;
        End;
      End;

    End

    Else If (Sender = edtRefTipAju) Then
    Begin
      If (Not edtRefTipAju.Visible) Then
        edtRefTipAju.Text := 'E';

      Result := Pos(edtRefTipAju.Text, 'EG') > 0;
    End

    Else If (Sender = edtRefQtdIte) Then
    Begin

      If (edtRefQtdIte.ReadOnly) Then
      Begin
        Result := False;
      End
      Else If fEmptyStr(edtRefQtdIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Quantidade deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If fStrToFloat(edtRefQtdIte.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Quantidade deve ser maior que Zero!', ['&O k']);
        Result := False;
      End
      Else If (Not fItemFracionado(qryConCit.FieldByName('ITE_CODUNI').AsString)) And (Frac(fStrToFloat(edtRefQtdIte.Text)) <> 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O item não é fracionável e sua quantidade deve ser inteira!', ['&O k']);
        Result := False;
      End
      Else If Not fQtdAjusteValida(fStrToFloat(edtRefQtdIte.Text)) Then // Req. 457063
      Begin
        fMensagem('ATENÇÃO!', 'Quantidade informada é inválida ou excede o limite máximo permitido para gravação (' +
          FormatFloat(fMskDigitos(fQtdAjusteCasasDecimais), fQtdAjusteMaxValor) + ')!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If ((fCfgSis('CAMXUT',varString) = 'A') Or (fCfgSis('CAMXUT',varString) = 'T')) And Not(fUsaRotinaWMS) Then
        Begin
          If edtEntSai.Text = 'E' Then
          Begin
            cdsData     := fCriaDataCapaMaxima(cdsData);
            cdsData     := fInsereItemCapacidadeMaxima(edtCodIte.Text, edtRefNumLot.Text, fStrToFloat(edtRefQtdIte.Text), cdsData);
            If Not blnLiberacaoAcimaDaCapacidadeMax Then
              blnLiberacaoAcimaDaCapacidadeMax:= (fValidaCapacidadeMaximaLote(edtNumLot.Text, cdsData));
            If Not(blnLiberacaoAcimaDaCapacidadeMax) Then
            Begin
              Result := False;
              Exit;
            End
          End;
        End;
        pCalculaTotalItem(EdtRefQtdIte);
      End;

    End
    Else If (Sender = edtObsAdc) Then
    Begin
      If edtObsAdc.Visible Then
      Begin
        If fEmptyStr(edtObsAdc.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo observação adicional deve ser preenchido!', ['&O k']);
          Result := False;
          Exit;
        End;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;


procedure TfrmAjusteEstoque.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    strCodAtu     : String;
    strForAnt     : String;
    strCliMarcas  : String;

    intOpcAtivos: Integer;
    arrSel: TConsultasArray;
    objfrmPnl: TPanelCxItem;
    strTabPre: String;
    edtRefCodIte: TEditFocus;
begin
  inherited;
  if (Sender as TEditFocus)  = edtCodIte then
     edtRefCodIte := edtCodIte
  else
     edtRefCodIte := edtCodIteSai;

  If CharInSet(Key, ['0'..'9']) And rdbProAca.Checked Then
    Key := #0;

  If (fEntraCons(Key)) And ((Not edtRefCodIte.ReadOnly) Or (tajAjuste = tajAcabado)) Then
  Begin
    If rdbProAca.Checked Then
    Begin
      If fPesquisaProdutoAcabado  Then
      Begin
        If fGetStatusItem(edtRefCodIte.Text) = 'N' Then
          fMensagem('ATENÇÃO!', 'Esse item está Inativo!', ['&O k'])
        Else
          SelectNext(ActiveControl, True, True);
      End;

      Exit;
    End;

    Try
      strTabPre    := '1';
      intOpcAtivos := 3;

      objfrmPnl := TPanelCxItem.New();

      objFrmPnl.strNomForm := Self.Name;
      objFrmPnl.recParametros.strCodCli  := '';
      objFrmPnl.strCodVen  := '';
      objFrmPnl.strCodDig  := '';
      objFrmPnl.intPraMedio:= 0;
      objFrmPnl.recParametros.strTabPre  := '1';
      objfrmPnl.strNumOrc  := '';
      objfrmPnl.strEspOrc  := '';

      If fPesqItem(conIteCompleta,
                   Self,
                   Nil,
                   Nil,
                   qryConIte,
                   Key,
                   arrSel,
                   True,
                   objfrmPnl,
                   'Consulta de Itens',
                   strTabPre,
                   '',
                   0,
                   false,
                   false,
                   intOpcAtivos) Then
      Begin
        edtRefCodIte.Text := qryConIte.FieldByName('ITE_CODITE').AsString;
        strCodAtu      := qryConIte.FieldByName('ITE_CODITE').AsString;
        pCarregaItem(edtRefCodIte);
        {*******************************************************}
        {* VALIDA MARCAS CADASTRADAS NOS VENDEDORES DO CLIENTE *}
        {****************************************************IV*}
        If (Not fEmptyStr(strCliMarcas)) And (Pos(qryConIte.FieldByName('ITE_CODMAR').AsString, strCliMarcas) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Item com Marca não permitida para este vendedor informado. Verifique!', ['&O k']);
        End
        Else
        Begin
          If (Not qryConIte.IsEmpty) Then
            edtRefCodIte.Text := qryConIte.FieldByName('ITE_CODITE').AsString;
          SelectNext(ActiveControl, True, True);
        End;

      End;

      Self.Name := strForAnt;

      Key := #0;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

  End;

end;

procedure TfrmAjusteEstoque.edtCodOcoExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtCodOco);

end;

procedure TfrmAjusteEstoque.edtCodOcoKeyPress(Sender: TObject; var Key: Char);
var arrOcor: TConsultasArray;
begin
  inherited;
  If fPesqOcorrencia(Self, edtCodOco, edtDesOco, Nil, Key, arrOcor) Then
    pCarregaOcorrencia;

end;

procedure TfrmAjusteEstoque.pCarregaItem(Sender: TEditFocus);
  Var
    blnBuscaCodBar: Boolean;
    edtRefCodIte,
    edtRefDesIte,
    edtRefRefere,
    edtRefUnidade,
    edtRefQtdIte,
    edtRefSaldos,
    edtRefSalMl,
    edtRefUnitar,
    edtRefTipAju: TEditFocus;
    fltSalRes: Double;
    fltUnitar: Double;
begin

  If fControleOrigemContraPartida(TEditFocus(Sender)) Then
  Begin
    edtRefCodIte := edtCodIteSai;
    edtRefDesIte := edtDesIteSai;
    edtRefRefere := edtRefereSai;
    edtRefUnidade:= edtUnidadeSai;
    edtRefQtdIte := edtQtdIteSai;
    edtRefSaldos := edtSaldosSai;
    edtRefSalMl  := edtSalMlSai;
    edtRefUnitar := edtUnitarSai;
    edtRefTipAju := edtTipAjuSai;
  End
  Else
  Begin
    edtRefCodIte := edtCodIte;
    edtRefDesIte := edtDesIte;
    edtRefRefere := edtRefere;
    edtRefUnidade:= edtUnidade;
    edtRefQtdIte := edtQtdIte;
    edtRefSaldos := edtSaldos;
    edtRefSalMl  := edtSalMl;
    edtRefUnitar := edtUnitar;
    edtRefTipAju := edtTipAju
  End;
  If (qryConCit.FieldByName('ITE_CODITE').AsString = edtRefCodIte.Text) And
     (rdbProAca.Checked) Then
    Exit;

  intDecQtd := fCfgSis('DEQTAJ', varInteger);
  blnBuscaCodBar := True;

  If (Length(Trim(edtRefCodIte.Text)) <= intTamCod) Then
  Begin
    edtRefCodIte.Text := fStrZero(edtRefCodIte.Text, intTamCod);
    blnBuscaCodBar := False;
  End;

  pPesquisaCadIte(qryConCit, qryConCit, edtRefCodIte.Text, '',  blnBuscaCodBar,
                  False, //  blnBuscaCodFab       : Boolean = False;
                  True,  //  blnFiltraAtivo       : Boolean = True;
                  blnEXIAJU, //  blnFiltrarExiLis     : Boolean = True;
                  False, //  blnFiltraDepProdAcab : Boolean = False;
                  False, //  blnFiltraDepProdEmb  : Boolean = False;
                  False, //  blnFiltraDepProdGra  : Boolean = False;
                  False, //  blnFiltraDepMatPrim  : Boolean = False;
                  False, //  blnVeioF11           : Boolean = False;
                  False, //  blnProdutoDiluente   : Boolean = False;
                  False);//  blnTestarCFG_EXILIS  : Boolean = True


  With qryConCit Do
  Begin

    If blnBuscaCodBar Then
      edtRefCodIte.Text := qryConCit.FieldByName('ITE_CODITE').AsString;

    edtRefDesIte.Text  := qryConCit.FieldByName('ITE_DESITE').AsString;

    edtRefRefere.Text  := qryConCit.FieldByName('ITE_REFERE').AsString;
    edtRefUnidade.Text := fRetSiglaUni(qryConCit.FieldByName('ITE_CODUNI').AsString);

    If fEmptyStr(edtRefQtdIte.Text) Then
      edtRefQtdIte.Text := '0,00';

    pHabilitaTipAju(qryConCit.FieldByName('ITE_CNV_ML').AsFloat > 0, Sender);

  End;

  If Not (qryConCit.IsEmpty) Then
  Begin

    With qryConIte Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(fGetSqlIteGer);
      ParamByName('CODITE').AsString := qryConCit.FieldByName('ITE_CODITE').AsString;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If fUsaRotinaWMS Then
        fltSalRes := fGetSaldoResLotDor(edtRefCodIte.Text, edtNumLot.Text, VS_strCodEmp)
      Else
        fltSalRes := 0;

      {********************************}
      {* CARREGA O SALDO              *}
      {*****************************JB*}

      If fControleOrigemContraPartida(TEditFocus(Sender)) Then
        edtSaldoDisponivelSaida.Text := FloatToStr(fRetornaSaldoItem)
      Else
        edtSaldoDisponivel.Text := FloatToStr(fRetornaSaldoItem);

      If Not FblnAjuSaldoExterno Then
      Begin
        If fUsaQtdPendenteEntregaFutura Then
          edtRefSaldos.Text  := FormatFloat(fMskDigitos(intDecQtd), FieldByName('ITE_SALDOS').AsFloat - fltSalRes +
                                                     TEntregaFutura.New(
                                                       TParamEF.New()
                                                         .CodIte(edtRefCodIte.Text)
                                                         .CodEmp(VS_strCodEmp)
                                                         .TipoTE(tteTodas)
                                                       ).Total())
        Else
          edtRefSaldos.Text  := FormatFloat(fMskDigitos(intDecQtd), FieldByName('ITE_SALDOS').AsFloat - fltSalRes);

        edtRefSalMl.Text   := FormatFloat('#,####0.0000', FieldByName('ITE_SAL_ML').AsFloat );
      End
      Else
        edtRefSaldos.Text  := FormatFloat(fMskDigitos(intDecQtd), fRetSalExterno(edtRefCodIte.Text,
                                                                                 VS_StrCodEmp,
                                                                                 edtCodEmpresa.Text,
                                                                                 IIF(edtLotExt.Visible, edtLotExt.Text, edtNumLot.Text) ));


      {********************************}
      {* TRAVA ITEM FRACIONADO OU NAO *}
      {*****************************AF*}
      If Not fItemFracionado(qryConCit.FieldByName('ITE_CODUNI').AsString) Then
        edtRefQtdIte.OnKeyPress := pTravaItemFracionadoKey
      Else
        edtRefQtdIte.OnKeyPress := Nil;

      If fHabilitouCustoPorTabelaDePreco Then
      Begin
        pCarregaValoresCusto(edtRefCodIte.Text, VS_strCodEmp, fRetornaTabelaCusto);
        fltUnitar := recCustoItem.fltPreCus;
      End
      Else
        fltUnitar := qryConIte.FieldByName(fTabPrecoImp).AsFloat;

      fltCusLot := 0;

      If SameText(strImpAju, 'TOTCUS') And fRetPrecoLote(edtRefCodIte.Text, edtNumLot.Text, fltCusLot) Then
        fltUnitar := fltCusLot;

      If SameText(edtRefTipAju.Text, 'G') Then
        edtRefUnitar.Text := FloatToStrF(fltUnitar / qryConCit.FieldByName('ITE_CNV_ML').AsFloat, ffFixed, 12, 4)
      Else
        edtRefUnitar.Text := FloatToStrF(fltUnitar, ffFixed, 12, 2);

      strIteUsaSer := qryConIte.FieldByName('ITE_USASER').AsString;

      pCalculaTotalItem(edtRefQtdIte);

    End;

  End
  Else
  Begin

    qryConIte.Close;

  End;

  lblQuantidade.Caption := 'Quantidade:';

  if rdbProAca.Checked then
    pMostraLote(false, Nil)
  else
  Begin
    pMostraLote(objCadLot.fExisteLote(edtRefCodIte.Text, VS_strCodEmp, '', False), edtRefCodIte);
    pnlMedidasMarmore.Enabled := fRegraItemMarmore(edtRefCodIte.Text);
    edtQtdIte.Enabled := Not pnlMedidasMarmore.Enabled;
    If pnlMedidasMarmore.Enabled Then
      lblQuantidade.Caption := 'Quantidade em m²:';


  End;

end;

procedure TfrmAjusteEstoque.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  inherited;
  If (edtCodDig.Visible) And
     (fPesqOperador(Self, edtCodVen, edtNomVen, qryConOpe, Key, arrSel)) Then
  Begin
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAjusteEstoque.pAtribuiTabelas;
begin
  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
  qryConCit := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
  qryConIte := fCriaQuery(Self);// IteGer(Self);
end;

procedure TfrmAjusteEstoque.pMostraLote(blnMostrar: Boolean; Sender: TEditFocus);
Var
  LLotExt: String;
  LMostraLotEstExt: Boolean;
Begin
  If Sender as TeditFocus = edtCodIte then
  Begin
    lblNumLot.Visible := blnMostrar;
    edtNumLot.Visible := blnMostrar;
    If Assigned(FColumnNumLot) Then
      FColumnNumLot.Visible := blnMostrar;
    edtNumLot.Enabled := True;
  End
  Else
  Begin
    lblNumLotSai.Visible := blnMostrar;
    edtNumLotSai.Visible := blnMostrar;
  End;

  LMostraLotEstExt := blnMostrar And FblnAjuSaldoExterno And objCadLot.ProdutoTemLote(edtCodIte.Text);
  edtLotExt.Visible := LMostraLotEstExt;

  If edtLotExt.Visible Then
  Begin
    If Not objCadLot.ExisteLoteEstoqueExterno(edtCodIte.Text, edtCodEmpresa.Text, LLotExt) Then
      edtLotExt.Visible := objCadLot.GeraLoteEstoqueExterno(edtCodIte.Text, edtCodEmpresa.Text, LLotExt);

    edtLotExt.Text := LLotExt;
  End;

  if LMostraLotEstExt then
  begin
    if (not edtLotExt.Visible) then
    begin
      fMensagem('Atenção', 'O item informado possui lotes cadastrados mas não tem o lote do fulfillment da empresa ' +
        'externa informada (' + edtCodEmpresa.Text + '). Isso quer dizer que nenhuma movimentação relacionada a ' +
        'essa empresa externa foi feita para esse item. Por favor, entre em contato com a citel para orientações.', ['&Ok']);

      pLimpaDadosItem(Sender);
      Exit;
    end
    else
    begin
      edtNumLot.Text := edtLotExt.Text;
      edtNumLot.Enabled := False;
    end;
  end;

  If FblnAjuSaldoExterno Then
  Begin
    edtEntSai.TabStop    := True;
    edtEntSai.Color      := clWindow;
    edtEntSai.FocusColor := clInfoBk;

    edtQtdIte.TabStop    := True;
    edtQtdIte.Color      := clWindow;
    edtQtdIte.FocusColor := clInfoBk;
  End;

  lblLotExt.Caption := objCadLot.strTitLab + ' Est. Externo:';
  lblLotExt.Visible := edtLotExt.Visible;

  If edtNumLot.Visible Then
    lblNumLot.Caption := IIF(intCtlEst = 2, 'Cód. Armazém', 'Lote');
End;

procedure TfrmAjusteEstoque.pMostraMensagemMovimentoProgramadoEmAberto(strCodIte, strLote: string);
var
  frmObservacaoLocal: TfrmObservacao;
  strMensagem: string;
begin
  pCriarFormularios(TfrmObservacao, frmObservacaoLocal);
  try
    strMensagem := '"Atenção! O item '+strCodIte+' e o lote '+strLote+' tem uma movimentação programada em aberto. Sendo assim, o ajuste de estoque não é permitido.';
    strMensagem := strMensagem + sLineBreak;
    strMensagem := strMensagem + 'Realize a operação da movimentação programada e depois, se for preciso, faça o ajuste novamente.';

    frmObservacaoLocal.lblMensagem.Caption := 'Item com movimentação programada!';
    frmObservacaoLocal.memObs.Texto := strMensagem;
    frmObservacaoLocal.ShowModal;
  finally
    pFreeAndNil(frmObservacaoLocal);
  end;
end;

procedure TfrmAjusteEstoque.pProcessaPrecoUnitarioETotal(Sender: TEditFocus; AQryConCit : TUniQuery);
  var
    LPrecoUnitario : Double;
    LQryConIte     : TUniQuery;
begin

  If fHabilitouCustoPorTabelaDePreco Then
  Begin
    pCarregaValoresCusto(fGetEdt(Sender).edtRefCodIte.Text, VS_strCodEmp, fRetornaTabelaCusto);
    LPrecoUnitario := recCustoItem.fltPreCus;
  End
  Else
  Begin

    LQryConIte := fCriaQuery;

    Try

      LQryConIte.Close;
      LQryConIte.SQL.Clear;
      LQryConIte.SQL.Add(fGetSqlIteGer);
      LQryConIte.ParamByName('CODITE').AsString := fGetEdt(Sender).edtRefCodIte.Text;
      LQryConIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LQryConIte.Open;

      LPrecoUnitario := LQryConIte.FieldByName(fTabPrecoImp).AsFloat;

    Finally
      FreeAndNil(LQryConIte);
    End;

  End;

  If SameText(fGetEdt(Sender).edtRefTipAju.Text, 'G') Then
    fGetEdt(Sender).edtRefUnitar.Text := FloatToStrF(LPrecoUnitario / AQryConCit.FieldByName('ITE_CNV_ML').AsFloat, ffFixed, 12, 4)
  Else
    fGetEdt(Sender).edtRefUnitar.Text := FloatToStrF(LPrecoUnitario, ffFixed, 12, 2);

  fGetEdt(Sender).edtRefTotIte.Text := FloatToStrF(fStrToFloat(fGetEdt(Sender).edtRefQtdIte.Text) * fStrToFloat(fGetEdt(Sender).edtRefUnitar.Text), ffFixed, 12, 2);

end;

procedure TfrmAjusteEstoque.FormCreate(Sender: TObject);
begin
  inherited;

  qryConOco   := fCriaQuery(Self);
  intTamCod   := fTamCodIte;
  blnAJSOOC := fCfgSis('AJSOOC', varBoolean);
  If Not blnAJSOOC Then
    pnlDetalhe.Height := pnlDetalhe.Height- pnlOcorrencia.Height;

  pnlOcorrencia.Visible := blnAJSOOC;

  FblnAjuContrPart    := False;
  FblnAjuSaldoExterno := False;

  intIdAgrupador := 0;
  intQtdMaxItens := fCfgSis('ITEDOC');
  dicRetorno  := TDicionario.Create;
  qryTinta    := fCriaQuery(Self);
  qryTintaAux := fCriaQuery(Self);
  tajAjuste   := tajVazio;

  blnEXIAJU := fCfgSis('EXIAJU', varBoolean);

  cdsAjuste := Nil;

  objCadLot := TCadLot.Create(Self);

  blnFecharTela := False;

  pAtribuiTabelas;

  // Req. 457063 - limite de caracteres do campo de quantidade, derivado da
  // precisao real de MOVDET.DET_QTDITE (sem hardcode)
  edtQtdIte.MaxLength    := fTamCampoQtdAjuste;
  edtQtdIte.TamCampo     := fTamCampoQtdAjuste;
  edtQtdIteSai.MaxLength := fTamCampoQtdAjuste;
  edtQtdIteSai.TamCampo  := fTamCampoQtdAjuste;

  FfltQtdAjusteMax      := -1; // Req. 457063 - forca recalculo (memoizado) na 1a validacao
  FintQtdAjusteCasasDec := -1;

  edtCodCli.Text := fCfgSis('CLIAJU');
  edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
  If fEmptyStr(edtNomCli.Text) Then
  Begin
    fMensagem('', 'O cliente configurado para ajuste de estoque não está cadastrado no sistema. ' +
                  'Por favor verifique.', ['&O k']);

    blnFecharTela := True;
    Exit;
  End;

  strPreAju      := fCfgSis('PREAJU');
  strImpAju      := fCfgSis('IMPAJU');
  blnVariasChapasPorLote := fCfgSis('CTRLCH') = '2';
  mskDtaEnt.Text := DateToStr(VS_Date);

  pHabilitaCampos(pnlCabecalho, True);
  pHabilitaCampos(pnlItemContainer, False);
  btnImportarPlanilha.Enabled := False;
  btnConfirma.Enabled := False;
  dbgItens.Enabled    := False;

  pCriaTemporaria;

  If fHabilitouCustoPorTabelaDePreco Then
    objCustoItem := TCustoItemFaturamento.New;

  intCtlEst := fCfgSis('CTLEST', varInteger);
  dbgItens.Columns[2].Title.Caption := IIF(intCtlEst = 2, 'Cód. Armazém', 'Lote');

  strIteUsaSer := 'N';

  objAuditoriaSaldo := TAuditoriaGravacaoSaldo.New;

  FChaveLockAjusteFul := '';
  FHubMkp := '';
  FImportacaoPlanilha := False;
  FZerarEstItensEmpExt := False;
  FDtaPlanilha := 0;
  FHraPlanilha := 0;
  FItensPlan := TStringList.Create;
  FItensSalNeg := TStringList.Create;
  pCriaDataSetAjustePlanilha;

  FColumnNumLot := fFindColumn('ITE_NUMLOT');
end;

procedure TfrmAjusteEstoque.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(dicRetorno);
  FreeAndNil(FItensPlan);
  FreeAndNil(FItensSalNeg);

  if Assigned(FAjuPlan) then
    FreeAndNil(FAjuPlan);
end;

{*******************************************************}
{* VALIDA SE A QUANTIDADE JA CONVERTIDA E' FINITA E     *}
{* CABE NA PRECISAO REAL DE MOVDET.DET_QTDITE, ANTES    *}
{* DE GRAVAR - Req. 457063                              *}
{*******************************************************}
function TfrmAjusteEstoque.fQtdAjusteValida(AValor: Double): Boolean;
begin
  Result := (Not IsNan(AValor)) And (Not IsInfinite(AValor))
            And (Abs(AValor) <= fQtdAjusteMaxValor);
end;

{*******************************************************}
{* CASAS DECIMAIS DE MOVDET.DET_QTDITE, COM CACHE EM    *}
{* CAMPO DO FORM (evita DESC MOVDET repetido) - 457063  *}
{*******************************************************}
function TfrmAjusteEstoque.fQtdAjusteCasasDecimais: Integer;
begin
  If FintQtdAjusteCasasDec < 0 Then
    FintQtdAjusteCasasDec := fObterQtdeCasasDecimaisCampo('MOVDET', 'DET_QTDITE');

  Result := FintQtdAjusteCasasDec;
end;

{*******************************************************}
{* MAIOR QUANTIDADE REPRESENTAVEL POR MOVDET.DET_QTDITE *}
{* (DECIMAL(P,S) -> 10^(P-S) - 10^(-S)), COM CACHE EM   *}
{* CAMPO DO FORM (evita DESC MOVDET repetido) - 457063  *}
{*******************************************************}
function TfrmAjusteEstoque.fQtdAjusteMaxValor: Double;
begin
  If FfltQtdAjusteMax < 0 Then
    FfltQtdAjusteMax := Power(10, fObterPrecisaoCampo('MOVDET', 'DET_QTDITE') - fQtdAjusteCasasDecimais)
                        - Power(10, -fQtdAjusteCasasDecimais);

  Result := FfltQtdAjusteMax;
end;

procedure TfrmAjusteEstoque.pCalculaTotalItem(Sender: TEditFocus);
  var
    edtRefTotIte,
    edtRefUnitar,
    edtRefQtdIte: TEditFocus;
Begin
   if fControleOrigemContraPartida(TEditFocus(Sender)) then
   Begin
     edtRefTotIte := edtTotIteSai;
     edtRefUnitar := edtUnitarSai;
     edtRefQtdIte := edtQtdIteSai;
   End
   Else
   Begin
     edtRefTotIte := edtTotIte;
     edtRefUnitar := edtUnitar;
     edtRefQtdIte := edtQtdIte;
   End;

  If fEmptyStr(edtRefQtdIte.Text) Then
    edtRefQtdIte.Text := FormatFloat(fMskDigitos(fCfgSis('DEQTAJ', varInteger)), 0)
  Else
    edtRefQtdIte.Text := FloatToStrF(fStrToFloat(edtRefQtdIte.Text), ffFixed, 12, intDecQtd);

  If fEmptyStr(edtRefUnitar.Text) Then
    edtRefUnitar.Text := '0,0000';

  edtRefTotIte.Text := FloatToStrF(fStrToFloat(edtRefQtdIte.Text) * fStrToFloat(edtRefUnitar.Text), ffFixed, 12, 2);
end;

procedure TfrmAjusteEstoque.pLimpaDadosItem(Sender: TEditFocus);
  Var
    intContador: Integer;
    edtTemp: TEdit;
    lblTemp: TLabel;
    pnlRefItem: TPanel;
    edtRefCodIte: TEditFocus;
begin
  strCodAca := '';
  if fControleOrigemContraPartida(Sender) Then
  Begin
    pnlRefItem := pnlItemSai;
    edtRefCodIte := edtCodIteSai;
  End
  else
  Begin
    pnlRefItem := pnlItemEnt;
    edtRefCodIte := edtCodIteSai;
  End;

  For intContador := 0 To pnlRefItem.ControlCount -1 Do
  Begin
    If (pnlRefItem.Controls[intContador] Is TEdit) Then
    Begin
      { Se for ajuste com contra partida então o campo que deifine que é entrada ou saida não limpa }
      if (((pnlRefItem.Controls[intContador] As TEdit).Name = edtEntSai.Name) or
          ((pnlRefItem.Controls[intContador] As TEdit).Name = edtEntSaiSai.Name)) and (FblnAjuContrPart) Then
         Continue;
      edtTemp := (pnlRefItem.Controls[intContador] As TEdit);
      edtTemp.Clear;
    End
    Else If (pnlRefItem.Controls[intContador] Is TLabel) Then
    Begin
      lblTemp := (pnlRefItem.Controls[intContador] As TLabel);

      If lblTemp.Tag = 99 Then
        lblTemp.Caption := '';

    End

  End;

  pnlRefItem := pnlQuantidade;
  For intContador := 0 To pnlRefItem.ControlCount -1 Do
  Begin
    If (pnlRefItem.Controls[intContador] Is TEdit) Then
    Begin
      { Se for ajuste com contra partida então o campo que deifine que é entrada ou saida não limpa }
      if (((pnlRefItem.Controls[intContador] As TEdit).Name = edtEntSai.Name) or
          ((pnlRefItem.Controls[intContador] As TEdit).Name = edtEntSaiSai.Name)) and (FblnAjuContrPart) Then
         Continue;
      edtTemp := (pnlRefItem.Controls[intContador] As TEdit);
      edtTemp.Clear;
    End
    Else If (pnlRefItem.Controls[intContador] Is TLabel) Then
    Begin
      lblTemp := (pnlRefItem.Controls[intContador] As TLabel);

      If lblTemp.Tag = 99 Then
        lblTemp.Caption := '';

    End;
  End;

  If blnMarmoreAtivo Then
  Begin
    pnlRefItem := pnlMedidasMarmore;
    For intContador := 0 To pnlRefItem.ControlCount -1 Do
    Begin
      If (pnlRefItem.Controls[intContador] Is TEdit) Then
      Begin
        { Se for ajuste com contra partida então o campo que deifine que é entrada ou saida não limpa }
        if (((pnlRefItem.Controls[intContador] As TEdit).Name = edtEntSai.Name) or
            ((pnlRefItem.Controls[intContador] As TEdit).Name = edtEntSaiSai.Name)) and (FblnAjuContrPart) Then
           Continue;
        edtTemp := (pnlRefItem.Controls[intContador] As TEdit);
        edtTemp.Clear;
      End
      Else If (pnlRefItem.Controls[intContador] Is TLabel) Then
      Begin
        lblTemp := (pnlRefItem.Controls[intContador] As TLabel);

        If lblTemp.Tag = 99 Then
          lblTemp.Caption := '';

      End;
    End;


  End;

  FMsgAjusteSaldoExternoInicial := '';

  edtRefCodIte.Enabled := True;

  pMostraLote(False, edtRefCodIte);
end;

{*****************************************}
{* HABILITA = TRUE: READONLY := FALSE E  *}
{* TABSTOP := TRUE                       *}
{**************************************MV*}
procedure TfrmAjusteEstoque.pHabilitaCampos(Owner: TWinControl; blnHabilita: Boolean);
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

    End
    Else If (Owner.Controls[intContador] Is TPanel) Then
       pHabilitaCampos((Owner.Controls[intContador] As TPanel), blnHabilita);
  End;

end;

procedure TfrmAjusteEstoque.pAdicionarItensPlanilha(cdsItens: TUniClientDataSet);
var
  edtSender : TEditFocus;
begin
  btnImportarPlanilha.Enabled := False;
  pHabilitaCampos(pnlItemContainer, False);
  lblTipMov.Visible := False;
  edtEntSai.Visible := False;
  clbTipoMovimento.Visible := False;
  FItensPlan.Clear;

  pgbItens.Visible := True;
  pgbItens.Max     := cdsItens.RecordCount;

  cdsItens.First;

  While Not cdsItens.Eof Do
  Begin
    FItensPlan.Add(cdsItens.FieldByName('CODITE').AsString);

    If Not fEmptyStr(cdsItens.FieldByName('VALIDACAO').AsString) Then
    Begin
      cdsItens.Next;
      Continue;
    End;

    edtSender := edtCodIte;

    fGetEdt(edtSender).edtRefCodIte.Text := cdsItens.FieldByName('CODITE').AsString;
    pPesquisaCadIte(qryConCit, qryConCit, fGetEdt(edtSender).edtRefCodIte.Text, '', False);

    fGetEdt(edtSender).edtRefDesIte.Text := cdsItens.FieldByName('DESITE').AsString;
    fGetEdt(edtSender).edtRefRefere.Text := cdsItens.FieldByName('CODREF').AsString;
    fGetEdt(edtSender).edtRefQtdIte.Text := cdsItens.FieldByName('QTDITE').AsString;
    pProcessaPrecoUnitarioETotal(edtSender, qryConCit);

    If rdbProAca.Checked Then
      pMostraLote(false, Nil)
    Else
    Begin
      edtCodIte.Text := fGetEdt(edtSender).edtRefCodIte.Text;
      pMostraLote(objCadLot.fExisteLote(fGetEdt(edtSender).edtRefCodIte.Text, VS_strCodEmp, '', False), fGetEdt(edtSender).edtRefCodIte);
    End;

    If fItemEstrutura(fGetEdt(edtSender).edtRefCodIte.Text) And (chkSubPro.Visible) And (chkSubPro.Checked) Then
      pCarregarSubProdutos(edtSender, fGetEdt(edtSender).edtRefCodIte.Text)
    Else
      pAdd(edtSender, qryConCit, cdsItens.FieldByName('QTDITE').AsFloat);

    pLimpaDadosItem(edtSender);

    pgbItens.StepBy(1);

    cdsItens.Next;
  End;

  pgbItens.Position := 0;
  pgbItens.Visible := False;
end;

procedure TfrmAjusteEstoque.btnImportarPlanilhaClick(Sender: TObject);
var
  frmImportarPlanilha : TfrmImportarPlanilhaAjusteEstoque;
begin
  inherited;

  pCriarFormularios(TfrmImportarPlanilhaAjusteEstoque, frmImportarPlanilha);

  Try
    frmImportarPlanilha.strHUBMKP := FHubMkp;
    frmImportarPlanilha.strEmpExt := edtCodEmpresa.Text;
    frmImportarPlanilha.blnSubPro := (chkSubPro.Visible) And (chkSubPro.Checked);
    frmImportarPlanilha.ShowModal;

    If frmImportarPlanilha.blnOk Then
    begin
      FDtaPlanilha := StrToDateDef(frmImportarPlanilha.mskData.Text, 0);
      FHraPlanilha := StrToTimeDef(frmImportarPlanilha.mskHora.Text, 0);

      If fEmptyDate(DateToStr(FDtaPlanilha)) Then
      Begin
        FDtaPlanilha := StrToDate(mskDtaEnt.Text);
        FHraPlanilha := fTime();
      End;

      FImportacaoPlanilha := True;
      lblInfoPlan.Caption := Format(lblInfoPlan.Caption, [frmImportarPlanilha.mskData.Text, frmImportarPlanilha.mskHora.Text]);
      pnlInfoPlan.Visible := True;
      pAdicionarItensPlanilha(frmImportarPlanilha.cdsItens);
    end
    else
    begin
      pDestravaLockAjusteFul;
      pLimparTela;
    end;
  Finally
    pFreeAndNil(frmImportarPlanilha);
  End;
end;

procedure TfrmAjusteEstoque.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimpaDadosItem(edtCodIte);
  if FblnAjuContrPart then
    pLimpaDadosItem(edtCodIteSai);

  edtCodIte.Enabled := True;
  pSetFocus(edtCodIte);

  btnAdicionar.Tag := 0;

  blnLiberacaoAcimaDaCapacidadeMax:= False;
end;


{*****************************************}
{* RETORNA A QUANTIDADE JA DIGITADA DO   *}
{* DO ITEM ATUAL                         *}
{**************************************LA*}
function TfrmAjusteEstoque.fRetQtdDigitada(strNumLot, strCodite: String): Double;
  Var
    intRecNo: Integer;
begin

  Result := 0.0;

  With cdsAjuste Do
  Begin

    DisableControls;

    intRecNo := RecNo;
    First;

    While Not Eof Do
    Begin
      If (FieldByName('ITE_CODITE').AsString = strCodite) And
          SameText(FieldByName('ITE_NUMLOT').AsString, strNumLot) Then
        Result := Result + FieldByName('ITE_QTDITE').AsFloat;
      Next;
    End;

    RecNo := intRecNo;

    EnableControls;
  End;

end;

function TfrmAjusteEstoque.fTabPreco: String;
  Var
    strSQL: String;
    qryAux: TUniQuery;
begin
  If (strPreAju = 'CLIENTE') Then
  Begin
    Try
      qryAux := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CLI_TABPRE ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADCLI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';

      With qryAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODCLI').AsString := edtCodCli.Text;
        Open;

        If Not IsEmpty Then
          Result := 'ITE_PREVE' + FieldByName('CLI_TABPRE').AsString
        Else
          Result := 'ITE_PREVE1';

      End;

    Except
      Result := 'ITE_PREVE1';
    End;
    FreeAndNil(qryAux);
  End
  Else
    Result := 'ITE_' + strPreAju;
end;

function TfrmAjusteEstoque.fTabPrecoImp: String;
begin

  if SameText(strImpAju,'TOTCUS' ) Then
    Result := 'PRECUS'
  Else
  if SameText(strImpAju,'TOTULT' ) Then
    Result := 'PREULT'
  Else
  if SameText(strImpAju,'IMPULT' ) Then
    Result := 'IMPULT'
  Else
  if SameText(strImpAju,'TOTMED' ) Then
    Result := 'PREMED';

  Result := 'ITE_' + Result;

  if SameText(strImpAju,'TOTITE' ) Then
    Result := fTabPreco

end;

function TfrmAjusteEstoque.fTemMovimentoProgramadoEmAberto(strCodIte,
  strLote: string): Boolean;
var
  qryMovimento: TUniQuery;
begin
  Result := False;
  qryMovimento := fCriaQuery;

  try
    qryMovimento.Close;
    qryMovimento.SQL.Clear;
    qryMovimento.SQL.Add('SELECT COUNT(*) AS TOTAL');
    qryMovimento.SQL.Add('FROM MOVLOT');
    qryMovimento.SQL.Add('WHERE MLT_CODEMP = :CODEMP');
    qryMovimento.SQL.Add('AND MLT_CODITE = :CODITE');
    qryMovimento.SQL.Add('AND (MLT_LOTDES = :LOTE OR MLT_LOTORI = :LOTE)');
    qryMovimento.SQL.Add('AND IFNULL(MLT_DTAREA, "")= ""');

    qryMovimento.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryMovimento.ParamByName('CODITE').AsString := strCodIte;
    qryMovimento.ParamByName('LOTE').AsString := strLote;

    qryMovimento.Open;

    if not qryMovimento.IsEmpty then
    begin
      Result := qryMovimento.FieldByName('TOTAL').AsInteger > 0;
    end;
  finally
    FreeAndNil(qryMovimento);
  end;
end;

function TfrmAjusteEstoque.fHabilitarControlesItem(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtObse02) And (blnBuscaPorChave) And (Not chkSubPro.Visible) And (Not edtObsAdc.Visible) Then
    Exit;

  If (Sender = chkSubPro) And (blnBuscaPorChave) And (chkSubPro.Visible) And (Not edtObsAdc.Visible) Then
    Exit;

  If (Sender = edtObsAdc) And (blnBuscaPorChave)Then
    Exit;

  Result := False;

end;

function TfrmAjusteEstoque.fHabilitouCustoPorTabelaDePreco: Boolean;
begin

  Result := False;

  If Not (fCfgSis('TABPRD', varBoolean)) Then
    Exit;

  If Not (strPreAju = 'PRECUS') Then
    Exit;

  Result := True;

end;

function TfrmAjusteEstoque.fInformarNumeroSerie(arrItensSerieEntrada, arrItensSerieSaida:TArrayItensNumeroSerie): Boolean;
begin
  if (Length(arrItensSerieEntrada) = 0) and (Length(arrItensSerieSaida) = 0) then
    Exit(True);

  fMensagem('Aviso', 'Há itens com controle de número de série para os itens de entrada ou saída. Informe nas respectivas telas à seguir para proseguir com o ajuste de estoque.', ['&Ok']);

  Result := False;

  if not fInformarNumeroSerieEntrada(arrItensSerieEntrada) then
    Exit;

  if not fInformarNumeroSerieSaida(arrItensSerieSaida) then
    Exit;

  Result := True;
end;

function TfrmAjusteEstoque.fInformarNumeroSerieEntrada(
  arrItensSerieEntrada: TArrayItensNumeroSerie): Boolean;
var
  frmFatSeriesItensDevolucao: TfrmFatSeriesItensDevolucao;
  intContador: Integer;
begin
  Result := True;

  if Length(arrItensSerieEntrada) <= 0 then
    Exit;

  pCriarFormularios(TfrmFatSeriesItensDevolucao, frmFatSeriesItensDevolucao);

  try
    frmFatSeriesItensDevolucao.Caption := 'Série dos Produtos do Ajuste de Estoque(Entrada)';
    frmFatSeriesItensDevolucao.FAjusteEstoque := True;

    for intContador := 0 to Length(arrItensSerieEntrada) - 1 do
    begin
      frmFatSeriesItensDevolucao.cdsSeries.Append;
      frmFatSeriesItensDevolucao.cdsSeriesAUTINC.AsString := arrItensSerieEntrada[intContador].strAutInc;
      frmFatSeriesItensDevolucao.cdsSeriesCODITE.AsString := arrItensSerieEntrada[intContador].strCodIte;
      frmFatSeriesItensDevolucao.cdsSeriesDESITE.AsString := arrItensSerieEntrada[intContador].strDesIte;
      frmFatSeriesItensDevolucao.cdsSeriesQTDITE.AsFloat :=  arrItensSerieEntrada[intContador].fltQtdIte;
      frmFatSeriesItensDevolucao.cdsSeriesEMPDOC.AsString := arrItensSerieEntrada[intContador].strEmpDoc;
      frmFatSeriesItensDevolucao.cdsSeriesEMPITE.AsString := arrItensSerieEntrada[intContador].strEmpIte;
      frmFatSeriesItensDevolucao.cdsSeriesTABDEV.AsString := arrItensSerieEntrada[intContador].strTabDev;
      frmFatSeriesItensDevolucao.cdsSeries.Post;
    end;

    if frmFatSeriesItensDevolucao.cdsSeries.IsEmpty then
      Exit;

    frmFatSeriesItensDevolucao.cdsSeries.First;
    frmFatSeriesItensDevolucao.ShowModal;

    Result := frmFatSeriesItensDevolucao.ModalResult = mrOk;

    if not Result then
      Exit;

    Result := fAjustaNumeroSerieEntrada(frmFatSeriesItensDevolucao.FArrItensNumeroSerieDevolucao);

    if not Result then
      Exit;


  finally
    pFreeAndNil(frmFatSeriesItensDevolucao);
  end;
end;

function TfrmAjusteEstoque.fInformarNumeroSerieSaida(
  arrItensSerieSaida: TArrayItensNumeroSerie): Boolean;
var
  frmNumeroSerieSaidaAjuste: TfrmNumeroSerieSaidaAjuste;
  intContador: Integer;
begin
  Result := True;

  if Length(arrItensSerieSaida) <= 0 then
    Exit;

  pCriarFormularios(TfrmNumeroSerieSaidaAjuste, frmNumeroSerieSaidaAjuste);

  try
    for intContador := 0 to Length(arrItensSerieSaida)-1 do
    begin
      frmNumeroSerieSaidaAjuste.cdsNumeroSerie.Append;
      frmNumeroSerieSaidaAjuste.cdsNumeroSerieCODIGO.AsString := arrItensSerieSaida[intContador].strCodIte;
      frmNumeroSerieSaidaAjuste.cdsNumeroSerieDESCRI.AsString := arrItensSerieSaida[intContador].strDesIte;
      frmNumeroSerieSaidaAjuste.cdsNumeroSerieQTDITE.AsFloat := arrItensSerieSaida[intContador].fltQtdIte;
      frmNumeroSerieSaidaAjuste.cdsNumeroSerieEMPITE.AsString := arrItensSerieSaida[intContador].strEmpIte;
      frmNumeroSerieSaidaAjuste.cdsNumeroSerieAUTINC.AsString := arrItensSerieSaida[intContador].strAutInc;
      frmNumeroSerieSaidaAjuste.cdsNumeroSerie.Post;
    end;

    if frmNumeroSerieSaidaAjuste.cdsNumeroSerie.IsEmpty then
      Exit;

    frmNumeroSerieSaidaAjuste.cdsNumeroSerie.First;
    frmNumeroSerieSaidaAjuste.ShowModal;

    Result := frmNumeroSerieSaidaAjuste.ModalResult = mrOk;
  finally
    pFreeAndNil(frmNumeroSerieSaidaAjuste);
  end;
end;

function TfrmAjusteEstoque.fMostrarOpcaoDeCarregamentoDosSubProdutos: Boolean;
begin

  Result := True;

  If ((fCfgSis('BXSBIT') = '2') And FblnAjuSaldoExterno) Then
    Exit;

  If ((fCfgSis('BXSBIT') = '3') And FblnAjuSaldoExterno) Then
    Exit;

  Result := False;

end;

{*****************************************}
{* VERIFICA SE HÁ ESTOQUE SUFICIENTE     *}
{**************************************LA*}
function TfrmAjusteEstoque.fVerificaQtdEstoque(fltQuantidade: Double; strCodite, strNumLot, strTipoMovimento, strTipAju: String;
                                 blnProAca: Boolean; fltSalAca, fltSalDis: Double): Boolean;
  Var
    strNTrava: String;
    fltSaldos,
    fltSalRes: Double;
    objMsg   : TMensagemLiberacao;
    blnSemSaldo: Boolean;
begin

  Result    := True;

  If (strTipoMovimento = 'E') Then
  Begin
    Exit;
  End
  Else If (strTipoMovimento = 'S') And FblnAjuSaldoExterno Then
  Begin
    If fltQuantidade > fltSalAca Then
    Begin
      fMensagem('', 'Este produto não possui saldo externo suficiente para esse ajuste! ', ['&O k']);
      Result := False;
      Exit;
    End;
  End;

  If (fltQuantidade <= 0.0) Then
  Begin
    Result := False;
    Exit;
  End;

  If blnProAca Then
  Begin
    fltSaldos := fltSalAca;
  End Else
  Begin
    {***********************************}
    { CARREGA O SALDO DE ACORDO COM O   }
    { TIPO DO ITEM ( SALDOS / SAL_ML )  }
    {********************************JB*}
    If (qryConCit.FieldByName('ITE_CNV_ML').AsFloat > 0) And
       (SameText(strTipAju, 'G') ) Then
      fltSaldos := qryConIte.FieldByName('ITE_SAL_ML').AsFloat
    Else
    Begin
      fltSaldos := qryConIte.FieldByName('ITE_SALDOS').AsFloat;

      If (edtNumLot.Visible) And (Not fEmptyStr(strNumLot)) Then
        fltSaldos := objCadLot.fSaldoLote(qryConIte.FieldByName('ITE_CODITE').AsString,
                                          VS_strCodEmp, strNumLot);
    End;
  End;

  If fUsaRotinaWMS Then
    fltSalRes := fGetSaldoResLotDor(strCodite, strNumLot, VS_strCodEmp)
  Else
    fltSalRes := 0;

  fltSaldos := fltSaldos - fltSalRes;
  fltQuantidade := fltQuantidade + fRetQtdDigitada(strNumLot, strCodIte);

  {*****************************************}
  {* CASO ESTEJA ALTERANDO UM ITEM, NAO    *}
  {* CONSIDERA A QUANTIDADE JA CADASTRADA  *}
  {**************************************LA*}
  If btnAdicionar.Tag > 0 Then
    fltQuantidade := fltQuantidade - cdsAjuste.FieldByName('ITE_QTDITE').AsFloat;

  If (Pos(fCfgSis('SLD_VN'), 'AT') > 0) Then
  Begin

    If Pos('ITEM ESPECIAL', qryConCit.FieldByName('ITE_DESITE').AsString) > 0 Then
    Begin
      Exit;
    End;

    if FblnAjuSaldoExterno then
      blnSemSaldo := ((fltSalDis + fltQuantidade) < 0)
    else
      blnSemSaldo := fltQuantidade > fltSalDis;

    If blnSemSaldo Then
    Begin
      If fUsaRotinaWMS Then
      Begin
        fMensagem('', 'Este produto não possui saldo suficiente para esse ajuste! ', ['&O k']);
        Result := False;
        pSetFocus(edtCodIte);
        Exit;
      End

      Else If (SameText(strTipAju, 'G') ) Then
      Begin
        intQtdReajuste  := 0;

        fltIteSalMl := fltSaldos;

        While fltQuantidade > fltIteSalMl Do
        Begin
          Inc(intQtdReajuste);

          fltIteSalMl  := fltIteSalMl + (qryConIte.FieldByName('ITE_CNV_ML').AsFloat);

          If qryConIte.FieldByName('ITE_SALDOS').AsFloat = 0 Then
          Begin
            fMensagem('', 'Este produto não possui saldo suficiente para esse ajuste! ', ['&O k']);
            Result := False;
            pSetFocus(edtCodIte);
            Exit;
          End;

          fltIteSaldos := (qryConIte.FieldByName('ITE_SALDOS').AsFloat - intQtdReajuste);
        End;
      End

      Else If (not FblnAjuSaldoExterno) and (fCfgSis('SLD_VN') = 'T') Then
      Begin
        objMsg := TMensagemLiberacao.Create(Self);
        try
          objMsg.pAddTexto('--------------------------------------------------------------------------------------------------------------');
          objMsg.pAddTexto('                            AJUSTE DE ESTOQUE DEIXANDO O SALDO DISPONÍVEL NEGATIVO                            ');
          objMsg.pAddTexto('--------------------------------------------------------------------------------------------------------------');
          objMsg.pAddTexto('Operador         :  ' + strCodOpe + '-' +  fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE'], [strCodOpe]));
          objMsg.pAddTexto('Produto          :  ' + qryConCit.FieldByName('ITE_CODITE').AsString + '-' + qryConCit.FieldByName('ITE_DESITE').AsString);
          If Not fEmptyStr(strNumLot) Then
            objMsg.pAddTexto('Lote             :  ' + strNumLot);
          objMsg.pAddTexto('Saldo Físico     :  ' + FormatFloat('#,##0.00', fltSaldos));
          objMsg.pAddTexto('Saldo Disponível :  ' + FormatFloat('#,##0.00', fltSalDis));
          objMsg.pAddTexto('');
          objMsg.pAddTexto('Tipo de movimentação :  ' + IIF(strTipoMovimento = 'S','SAÍDA','ENTRADA'));
          objMsg.pAddTexto('Qtd. Ajustada                          :  ' + FormatFloat('#,##0.00', fltQuantidade));
          objMsg.pAddTexto('Saldo Disponível se confirmado o ajuste:  ' + FormatFloat('#,##0.00',
            IIF(FblnAjuSaldoExterno, IIF(strTipoMovimento = 'S', fltSalDis + fltQuantidade, fltSalDis - fltQuantidade),
                                     IIF(strTipoMovimento = 'S', fltSalDis - fltQuantidade, fltSalDis + fltQuantidade)) ));
          objMsg.pAddTexto('--------------------------------------------------------------------------------------------------------------');

          If (Not fSenhaLiberacaoSemSaldoVN(strCodVen, strCodOpe, strNtrava, Nil, objMsg, '', TRUE, 'AJ')) Then
          Begin
            Result := False;
            pSetFocus(edtCodIte);
            Exit;
          End;
        finally
          FreeAndNil(objMsg);
        end;
      End;
    End;

  End;

end;

function TfrmAjusteEstoque.fZerarEstoqueExtItensForaDaPlanilha(pgbProgresso: TcxProgressBar): Boolean;
var
  LLotExt: String;
  LQtdLot: Double;
  LQry: TUniQuery;
  edtSender : TEditFocus;
begin
  Result := True;

  LQry := fCriaQuery;

  try
    LQry.SQL.Add('SELECT EXT_CODITE CODITE, EXT_SALDO_ SALEXT, ITE_DESITE DESITE, ITE_REFERE CODREF ');
    LQry.SQL.Add('FROM ESTEXT ');
    LQry.SQL.Add('INNER JOIN CADITE ON EXT_CODITE = ITE_CODITE ');
    LQry.SQL.Add('WHERE EXT_SALDO_ <> 0 ');
    LQry.SQL.Add('  AND EXT_CODEMP = :CODEMP ');
    LQry.SQL.Add('  AND EXT_CODEEE = :CODEXT ');
    LQry.SQL.Add('  AND EXT_CODITE NOT IN (' + fCommaText(FItensPlan, True) + ') ');
    LQry.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQry.ParamByName('CODEXT').AsString := edtCodEmpresa.Text;
    LQry.Open;

    if LQry.IsEmpty then
      Exit;

    while not LQry.Eof do
    begin
      pProgresso(LQry.RecNo, LQry.RecordCount, pgbProgresso);
      edtSender := edtCodIte;

      fGetEdt(edtSender).edtRefCodIte.Text := LQry.FieldByName('CODITE').AsString;
      pPesquisaCadIte(qryConCit, qryConCit, fGetEdt(edtSender).edtRefCodIte.Text, '', False);

      fGetEdt(edtSender).edtRefDesIte.Text := LQry.FieldByName('DESITE').AsString;
      fGetEdt(edtSender).edtRefRefere.Text := LQry.FieldByName('CODREF').AsString;
      fGetEdt(edtSender).edtRefQtdIte.Text := LQry.FieldByName('SALEXT').AsString;
      fGetEdt(edtSender).edtRefEntSai.Text := 'S';

      if (objCadLot.ExisteLoteEstoqueExterno(LQry.FieldByName('CODITE').AsString, edtCodEmpresa.Text, LLotExt)) then
      begin
        fGetEdt(edtSender).edtRefNumLot.Text := LLotExt;

        LQtdLot := fCampoTabela('LOT_SALDOS', 'CADLOT',  ['LOT_FULFIL', 'LOT_CODITE', 'LOT_CODEMP', 'LOT_CODEXT'],
          ['S', LQry.FieldByName('CODITE').AsString, VS_strCodEmp, edtCodEmpresa.Text]);

        if (LQtdLot = 0) then
        begin
          pLimpaDadosItem(edtSender);
          LQry.Next;
          Continue;
        end
        else if (LQtdLot < 0) then
        begin
          fGetEdt(edtSender).edtRefQtdIte.Text := FloatToStr(LQtdLot * (-1));
          fGetEdt(edtSender).edtRefEntSai.Text := 'E';
        end
        else
          fGetEdt(edtSender).edtRefQtdIte.Text := FloatToStr(LQtdLot);
      end
      else if (LQry.FieldByName('SALEXT').AsFloat < 0) then
      begin
        fGetEdt(edtSender).edtRefQtdIte.Text := FloatToStr(LQry.FieldByName('SALEXT').AsFloat * (-1));
        fGetEdt(edtSender).edtRefEntSai.Text := 'E';
      end
      else
        fGetEdt(edtSender).edtRefQtdIte.Text := LQry.FieldByName('SALEXT').AsString;

      pProcessaPrecoUnitarioETotal(edtSender, qryConCit);

      edtCodIte.Text := fGetEdt(edtSender).edtRefCodIte.Text;
      pMostraLote(objCadLot.fExisteLote(fGetEdt(edtSender).edtRefCodIte.Text, VS_strCodEmp, '', False), fGetEdt(edtSender).edtRefCodIte);

      pAdd(edtSender, qryConCit);
      pLimpaDadosItem(edtSender);

      LQry.Next;
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TfrmAjusteEstoque.pSetaTipoAjuste;
Begin

  With cdsAjuste Do
  Begin

    If IsEmpty Then
    Begin
      tajAjuste         := tajVazio;
      rdbCodIte.Enabled := True;
      rdbProAca.Enabled := True;
    End

    Else If fEmptyStr(FieldByName('ITE_CODACA').AsString) Then
    Begin
      tajAjuste         := tajNormal;

      rdbCodIte.Enabled := True;
      rdbCodIte.Checked := True;

      rdbProAca.Enabled := False;
    End

    Else Begin
      tajAjuste         := tajAcabado;

      rdbCodIte.Enabled := False;

      rdbProAca.Enabled := True;
      rdbProAca.Checked := True;
    End;

  End;

End;

Function TfrmAjusteEstoque.fProdutosMesmoTipo: Boolean;
Begin
  Result := True;

  pSetaTipoAjuste;

  If (Not fEmptyStr(strCodAca)) And (FblnAjuSaldoExterno) Then
  Begin
    pMensagemOk('O Ajuste deve conter somente produtos, produto informado é um Produto Acabado!');
    Exit(False);
  End;

  Case tajAjuste Of
    tajNormal:   If Not fEmptyStr(strCodAca) Then
                 Begin
                   pMensagemOk('O Ajuste deve conter somente produtos normais ou somente produtos acabados!');
                   Result := False;
                 End;

    tajAcabado:  If fEmptyStr(strCodAca) Then
                 Begin
                   pMensagemOk('O Ajuste deve conter somente produtos normais ou somente produtos acabados!');
                   Result := False;
                 End;
  End;

End;

function TfrmAjusteEstoque.fQtdeItensMOVDETAposPlanilha(ACodIte: String): Double;
var
  LQry: TUniQuery;
begin
  LQry := fCriaQuery;

  try
    LQry.SQL.Add('SELECT IFNULL(SUM(IF((DET_CLAFIS < 5000 OR FUL_OPERAC = "Remessa"), DET_QTDITE, -DET_QTDITE)), 0) QTDITE ');
    LQry.SQL.Add('FROM MOVDET D ');
    LQry.SQL.Add('INNER JOIN MOVAUX A     ON D.AUTOINCREM = A.DET_SEQGER ');
    LQry.SQL.Add('INNER JOIN MOVTRI T     ON D.AUTOINCREM = T.DET_SEQGER ');
    LQry.SQL.Add('LEFT JOIN FULL_CFGSIS F ON D.DET_CODEMP = F.SIS_CODEMP ');
    LQry.SQL.Add('                       AND F.SIS_VALCFG = T.DET_CODEXT ');
    LQry.SQL.Add('                       AND F.SIS_CODCFG = "CFG_CODEEE" ');
    LQry.SQL.Add('LEFT JOIN ESTFUL E      ON F.SIS_HUBMKP = E.FUL_HUBMKP ');
    LQry.SQL.Add('                       AND D.DET_CLAFIS = E.FUL_CLAFIS ');
    LQry.SQL.Add('                       AND FUL_PROCES IS NULL          ');
    LQry.SQL.Add('                       AND FUL_OPERAC = "Remessa"      ');
    LQry.SQL.Add('WHERE CAST(CONCAT(DET_DTAENT, " ", DET_HORENT) AS DATETIME) > ' +
      QuotedStr(FormatDateTime('yyyy-mm-dd', FDtaPlanilha) + ' ' + FormatDateTime('hh:mm:ss', FHraPlanilha)));
    LQry.SQL.Add('  AND DET_CODITE = :CODITE ');
    LQry.SQL.Add('  AND DET_CODEMP = :CODEMP ');
    LQry.SQL.Add('  AND DET_CODEXT = :CODEXT ');
    LQry.SQL.Add('  AND DET_FILFUL = 0 ');
    LQry.ParamByName('CODITE').AsString := ACodIte;
    LQry.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQry.ParamByName('CODEXT').AsString := edtCodEmpresa.Text;
    LQry.Open;

    Result := LQry.FieldByName('QTDITE').AsFloat;
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TfrmAjusteEstoque.btnAdicionarClick(Sender: TObject);
var strLimiteAtingido: string;
begin
  If fVerificaCampos Then
  Begin
    if fTemMovimentoProgramadoEmAberto(edtCodIte.Text, edtNumLot.Text) then
    Begin
      pMostraMensagemMovimentoProgramadoEmAberto(edtCodIte.Text, edtNumLot.Text);
      edtNumLot.Clear;
      pSetFocus(edtNumLot);
      Exit;
    End;

    blnLiberacaoAcimaDaCapacidadeMax:= False;

    inc(intIdAgrupador);
    strLimiteAtingido := '';

    If ((intQtdItens + 1) > intQtdMaxItens) Then
      strLimiteAtingido := fRetMensagemErroLimite;

    If strLimiteAtingido <> '' Then
    Begin
      fMensagem('Atenção',                   //  strTitulo: String;
                 strLimiteAtingido,          //  strTexto: String;
                 ['&OK'],                    //  arrOpcoes: Array Of String;
                 1,                          //  intFocoBotao: Integer = 1;
                 False,                      //  blnSaiComEsc: Boolean = False;
                 1,                          //  intEstFon: Integer = 1;
                 0,                          //   intWidBut: Integer = 0;
                 False,                      //  blnAutosize: Boolean = False;
                 0,                          //  intSomarTop: Integer=0;
                 false,                      //  blnObrigaEsc: Boolean = False;
                 False,                      //  blnOcultPainelBtn: Boolean = False;
                 False,                      //  blnBtnSemImg : Boolean = False;
                 0,                          //  intHeightOpc: Integer = 0;
                 600,                        //  intFormWidth: Integer = 0;
                 3);                         //  intQtdLinha: Integer = -1;
      Exit;
    End;

    pAdicionarItem(edtCodIte);

    if FblnAjuContrPart then
      pAdicionarItem(edtCodIteSai);

    btnAdicionar.Tag := 0;
    pSetFocus(edtCodIte);
    If (Not FblnAjuContrPart) And
       (Not(tdaTodos in daEntSai)) Then
    Begin
      If daEntSai = [tdaSaida] Then
      Begin
        edtEntSai.Text := 'S';
        clbTipoMovimento.Caption := '(S)aída';
        edtEntSai.Enabled := False;
      End
      Else If daEntSai = [tdaEntrada] Then
      Begin
        edtEntSai.Text := 'E';
        clbTipoMovimento.Caption := '(E)ntrada';
        edtEntSai.Enabled := False;
      End;
    End;

  End;
end;

function TfrmAjusteEstoque.fValidaCabecalho: Boolean;
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
          pSetFocus((pnlCabecalho.Controls[intContador] As TEditFocus))
        Else If (pnlCabecalho.Controls[intContador] Is TMaskEditFocus) Then
          pSetFocus((pnlCabecalho.Controls[intContador] As TMaskEditFocus));

        blnMudarFoco := False;
        Break;
      End;

    End;

  End;

end;

procedure TfrmAjusteEstoque.pEscapePressed;
begin
  If ((ActiveControl.Parent) = pnlItemContainer) Then
  Begin

    If (edtCodIte.Focused) or
       (edtCodIteSai.Focused) Then
    Begin

      btnCancelaItem.Click;
      pHabilitaCampos(pnlCabecalho, True);
      pHabilitaCampos(pnlItemContainer, False);
      btnConfirma.Enabled := False;
      dbgItens.Enabled    := False;
      pSetFocus(edtCodVen);

    End

    Else
    Begin

      btnCancelaItem.Click;

    End;

  End
  Else If ((ActiveControl.Parent) = pnlCabecalho) Then
  Begin
    inherited;
  End;
end;

procedure TfrmAjusteEstoque.dbgItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
//  Var
//    intRecNo: Integer;
begin
  inherited;

  if FImportacaoPlanilha then
    Exit;

  If (Key = VK_Escape) Then
  Begin
    If edtCodIte.Enabled Then
      pSetFocus(edtCodIte)
  End
  Else If (Key = VK_Return) Then
  Begin
    pCarregaItensAlteracao;
  End
  Else If (Key = VK_Delete) Then
  Begin
    If Not cdsAjuste.Active Then
    Begin

      If edtCodIte.Enabled Then
        pSetFocus(edtCodIte);

      Exit;
    End;

    pDeletaItem;
  End;
end;


procedure TfrmAjusteEstoque.dtsAjusteDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  btnEstLoj.Enabled := (cdsAjuste.Active) and (not fEmptyStr(cdsAjuste.FieldByName('ITE_CODITE').AsString));

end;

procedure TfrmAjusteEstoque.pCriaDataSetAjustePlanilha;
begin
  FAjuPlan := TUniClientDataSet.Create(nil);

  FAjuPlan.FieldDefs.Add('CODITE', ftString, 10);
  FAjuPlan.FieldDefs.Add('DESITE', ftString, 70);
  FAjuPlan.FieldDefs.Add('QTDPLA', ftFloat);
  FAjuPlan.FieldDefs.Add('QTDMOV', ftFloat);
  FAjuPlan.FieldDefs.Add('QTDAJU', ftFloat);
  FAjuPlan.FieldDefs.Add('OPERAC', ftString, 10);
  FAjuPlan.FieldDefs.Add('SALATU', ftFloat);
  FAjuPlan.FieldDefs.Add('SALAPO', ftFloat);
  FAjuPlan.CreateDataSet;

  (FAjuPlan.FieldByName('QTDPLA') as TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DEQTAJ', varInteger));
  (FAjuPlan.FieldByName('QTDMOV') as TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DEQTAJ', varInteger));
  (FAjuPlan.FieldByName('QTDAJU') as TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DEQTAJ', varInteger));
  (FAjuPlan.FieldByName('SALATU') as TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DEQTAJ', varInteger));
  (FAjuPlan.FieldByName('SALAPO') as TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DEQTAJ', varInteger));

  FAjuPlan.IndexFieldNames := 'CODITE';
end;

procedure TfrmAjusteEstoque.pCriaTemporaria;
begin
  cdsAjuste := TUniClientDataSet.Create(Owner);
  dtsAjuste.DataSet := cdsAjuste;

  With cdsAjuste, FieldDefs Do
  Begin
    AggregatesActive := True;
    With AddFieldDef Do Begin Name := 'ITE_CODITE'; DataType := ftString; Size := intTamCod; End;
    With AddFieldDef Do Begin Name := 'ITE_CODGRU'; DataType := ftString; Size := 006; End;
    With AddFieldDef Do Begin Name := 'ITE_DESITE'; DataType := ftString; Size := 057; End;
    With AddFieldDef Do Begin Name := 'ITE_NUMLOT'; DataType := ftString; Size := 030; End;
    With AddFieldDef Do Begin Name := 'ITE_REFERE'; DataType := ftString; Size := 016; End;
    With AddFieldDef Do Begin Name := 'ITE_CODMAR'; DataType := ftString; Size := 006; End;
    With AddFieldDef Do Begin Name := 'ITE_ENTSAI'; DataType := ftString; Size := 001; End;
    With AddFieldDef Do Begin Name := 'ITE_CODUNI'; DataType := ftString; Size := 002; End;
    With AddFieldDef Do Begin Name := 'ITE_SIGUNI'; DataType := ftString; Size := 006; End;
    With AddFieldDef Do Begin Name := 'ITE_SALDOS'; DataType := ftFloat;   End; //12,2
    With AddFieldDef Do Begin Name := 'ITE_SAL_ML'; DataType := ftFloat;   End; //12,3
    With AddFieldDef Do Begin Name := 'ITE_QTDITE'; DataType := ftFloat;   End; //12,4
    With AddFieldDef Do Begin Name := 'ITE_UNITAR'; DataType := ftFloat;   End; //12,4
    With AddFieldDef Do Begin Name := 'ITE_CUSLOT'; DataType := ftFloat;   End; //12,4
    With AddFieldDef Do Begin Name := 'ITE_TOTITE'; DataType := ftFloat;   End; //12,2
    With AddFieldDef Do Begin Name := 'ITE_TIPAJU'; DataType := ftString; Size := 001; End;
    With AddFieldDef Do Begin Name := 'ITE_CNV_ML'; DataType := ftFloat;   End; //12,4
    With AddFieldDef Do Begin Name := 'AUTOINCREM'; DataType := ftAutoInc; End;
    With AddFieldDef Do Begin Name := 'ITE_CODACA'; DataType := ftString; Size := 006; End;
    With AddFieldDef Do Begin Name := 'ITE_EMPACA'; DataType := ftString; Size := 003; End;
    with AddFieldDef do Begin Name :=     'ITEREL'; DataType := ftInteger; End;
    With AddFieldDef Do Begin Name := 'ITE_EXTINI'; DataType := ftString; Size := 001; End;
    with AddFieldDef do Begin Name := 'LOT_MEDB_L'; DataType := ftFloat; End;
    with AddFieldDef do Begin Name := 'LOT_MEDB_A'; DataType := ftFloat; End;
    with AddFieldDef do Begin Name := 'LOT_MEDL_L'; DataType := ftFloat; End;
    with AddFieldDef do Begin Name := 'LOT_MEDL_A'; DataType := ftFloat; End;
    with AddFieldDef do Begin Name := 'LOT_ESPESS'; DataType := ftFloat; End;
    with AddFieldDef do Begin Name := 'LOT_NCHAPA'; DataType := ftFloat; End;
    with AddFieldDef do Begin Name := 'LOT_PRVMAP'; DataType := ftFloat; End;
    with AddFieldDef do Begin Name := 'LOT_PRVMAT'; DataType := ftFloat; End;
    With AddFieldDef Do Begin Name := 'ITE_QTDPLA'; DataType := ftFloat; End; //12,4
    With AddFieldDef Do Begin Name := 'ITE_OBSADC'; DataType := ftString; Size := 100; End;
    With AddFieldDef Do Begin Name := 'ITE_USASER'; DataType := ftString; Size := 001; End;

    With TAggregateField.Create(cdsAjuste) Do
    Begin
      FieldName := 'TOT_TOTITE'; DataSet := cdsAjuste; DisplayFormat := '#,##0.00'; Alignment := taRightJustify;
      Expression := 'SUM(ITE_TOTITE)'; Active := True;
    End;

    CreateDataSet;

    Open;

    (FieldByName('ITE_QTDITE') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DEQTAJ', varInteger));
    (FieldByName('ITE_UNITAR') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
    (FieldByName('ITE_QTDPLA') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DEQTAJ', varInteger));
    (FieldByName('ITE_TOTITE') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ITE_SALDOS') As TFloatField).DisplayFormat := '#,##0.000';
  End;

  pSetaClient(cdsAjuste);

end;

procedure TfrmAjusteEstoque.pDeletaTemporaria;
begin
  If Assigned(cdsAjuste) And cdsAjuste.Active Then
    cdsAjuste.EmptyDataSet;
end;

procedure TfrmAjusteEstoque.pDestravaLockAjusteFul;
begin
  if fEmptyStr(FChaveLockAjusteFul) then
    Exit;

  fLock_Unlock(FChaveLockAjusteFul, False, False);
  FChaveLockAjusteFul := '';
  FHubMkp := '';
end;

procedure TfrmAjusteEstoque.pCarregaItensAlteracao;
  var
    edtRefCodIte,
    edtRefQtdIte,
    edtRefUnitar,
    edtRefTotIte,
    edtRefEntSai,
    edtRefDesIte,
    edtRefRefere,
    edtRefUnidade,
    edtRefSaldos,
    edtRefTipAju,
    edtRefSalMl,
    edtRefNumLot: TEditFocus;
begin
  if cdsAjuste.IsEmpty then
     Exit;
  If FblnAjuContrPart and fEmptyStr(edtCodIte.Text) Then
     cdsAjuste.Locate('ITEREL; ITE_ENTSAI', VarArrayOf([cdsAjuste.FieldByName('ITEREL').AsString, 'E']), [])
  Else If (FblnAjuContrPart) and not (fEmptyStr(edtCodIte.Text))then
     cdsAjuste.Locate('ITEREL; ITE_ENTSAI', VarArrayOf([cdsAjuste.FieldByName('ITEREL').AsString, 'S']), []);
  If (not fEmptyStr(edtCodIte.Text)) and ( not fEmptyStr(edtCodIteSai.Text)) Then
    Exit;


  if FblnAjuContrPart and (cdsAjuste.FieldByName('ITE_ENTSAI').AsString = 'S') then
  Begin
    edtRefCodIte  := edtCodIteSai;
    edtRefQtdIte  := edtQtdIteSai;
    edtRefUnitar  := edtUnitarSai;
    edtRefTotIte  := edtTotIteSai;
    edtRefEntSai  := edtEntSaiSai;
    edtRefDesIte  := edtDesIteSai;
    edtRefRefere  := edtRefereSai;
    edtRefUnidade := edtUnidadeSai;
    edtRefSaldos  := edtSaldosSai;
    edtRefTipAju  := edtTipAjuSai;
    edtRefSalMl   := edtSalMlSai;
    edtRefNumLot  := edtNumLotSai;
  End
  Else
  begin
    edtRefCodIte  := edtCodIte;
    edtRefQtdIte  := edtQtdIte;
    edtRefUnitar  := edtUnitar;
    edtRefTotIte  := edtTotIte;
    edtRefEntSai  := edtEntSai;
    edtRefDesIte  := edtDesIte;
    edtRefRefere  := edtRefere;
    edtRefUnidade := edtUnidade;
    edtRefSaldos  := edtSaldos;
    edtRefTipAju  := edtTipAju;
    edtRefSalMl   := edtSalMl;
    edtRefNumLot  := edtNumLot;
  End;

  pSetFocus(edtRefQtdIte);

  with cdsAjuste do
  Begin
    If Not Active Then
    Begin
      If edtRefCodIte.Enabled Then
        pSetFocus(edtCodIte);
      Exit;
    End;

    If IsEmpty Then
    Begin
      If edtRefCodIte.Enabled Then
        pSetFocus(edtRefCodIte);

      Exit;
    End;

    {********************************}
    {* TRAVA ITEM FRACIONADO OU NAO *}
    {*****************************AF*}
    If Not fItemFracionado(FieldByName('ITE_CODUNI').AsString) Then
      edtRefQtdIte.OnKeyPress := pTravaItemFracionadoKey
    Else
      edtRefQtdIte.OnKeyPress := Nil;

    edtRefCodIte.Text  := FieldByName('ITE_CODITE').AsString;
    edtRefDesIte.Text  := FieldByName('ITE_DESITE').AsString;
    edtRefRefere.Text  := FieldByName('ITE_REFERE').AsString;
    edtRefUnidade.Text := FieldByName('ITE_SIGUNI').AsString;
    edtRefSaldos.Text  := FloatToStrF(FieldByName('ITE_SALDOS').AsFloat, ffFixed, 12, intDecQtd);
    edtRefSalMl.Text   := FloatToStrF(FieldByName('ITE_SAL_ML').AsFloat, ffFixed, 12, 4);
    edtRefEntSai.Text  := FieldByName('ITE_ENTSAI').AsString;
    edtRefTipAju.Text  := FieldByName('ITE_TIPAJU').AsString;
    edtRefQtdIte.Text  := FloatToStrF(FieldByName('ITE_QTDITE').AsFloat, ffFixed, 12, intDecQtd);
    edtRefUnitar.Text  := FloatToStrF(FieldByName('ITE_UNITAR').AsFloat, ffFixed, 12, 4);
    edtRefTotIte.Text  := FloatToStrF(FieldByName('ITE_TOTITE').AsFloat, ffFixed, 12, 2);

    If fRegraItemMarmore(edtRefCodIte.Text)then
    Begin
     edtLOT_MEDB_L.Text := FloatToStrF(FieldByName('LOT_MEDB_L').AsFloat, ffFixed, 12, intDecQtd);
     edtLOT_MEDB_A.Text := FloatToStrF(FieldByName('LOT_MEDB_A').AsFloat, ffFixed, 12, intDecQtd);
     edtLOT_MEDL_L.Text := FloatToStrF(FieldByName('LOT_MEDL_L').AsFloat, ffFixed, 12, intDecQtd);
     edtLOT_MEDL_A.Text := FloatToStrF(FieldByName('LOT_MEDL_A').AsFloat, ffFixed, 12, intDecQtd);
     edtLOT_ESPESS.Text := FloatToStrF(FieldByName('LOT_ESPESS').AsFloat, ffFixed, 12, intDecQtd);
     edtQtdChapa.Text := FloatToStrF(FieldByName('LOT_NCHAPA').AsFloat, ffFixed, 12, intDecQtd);


    End;
    {}

    edtRefNumLot.Text  := FieldByName('ITE_NUMLOT').AsString;

    strCodAca       := FieldByName('ITE_CODACA').AsString;
    strEmpAca       := FieldByName('ITE_EMPACA').AsString;

    strUniAca       := FieldByName('ITE_CODUNI').AsString;

    objCadLot.strLotAnt := FieldByName('ITE_NUMLOT').AsString;

    pHabilitaTipAju(FieldByName('ITE_CNV_ML').AsFloat > 0, edtRefCodIte);

    {*****************************************}
    {* ATRIBUI O AUTO INCREMENTO DO REGISTRO *}
    {* QUE SERÁ USADO COMO CHAVE PARA A ALTE-*}
    {* RAÇÃO                                 *}
    {**************************************MV*}
    btnAdicionar.Tag   := FieldByName('AUTOINCREM').AsInteger;

    edtRefCodIte.Enabled  := False;

    if FblnAjuContrPart then
       pSetFocus(edtEntSai);
  End;


  if rdbProAca.Checked then
    pMostraLote(false, Nil)
  else
    pMostraLote(objCadLot.fExisteLote(edtRefCodIte.Text, VS_strCodEmp, '', False), edtRefCodIte);


  If FblnAjuContrPart then
    pCarregaItensAlteracao;

end;

procedure TfrmAjusteEstoque.pAdd(Sender: TEditFocus; AQryConCit : TUniQuery = Nil; AQtdPlanilha: Double = 0);
begin

  If Not Assigned(AQryConCit) Then
    AQryConCit := qryConCit;

  cdsAjuste.Insert;
  cdsAjuste.FieldByName('ITE_CODITE').AsString := fGetEdt(Sender).edtRefCodIte.Text;
  cdsAjuste.FieldByName('ITE_CODGRU').AsString := AQryConCit.FieldByName('ITE_CODGRU').AsString;
  cdsAjuste.FieldByName('ITE_DESITE').AsString := fGetEdt(Sender).edtRefDesIte.Text;
  cdsAjuste.FieldByName('ITE_REFERE').AsString := fGetEdt(Sender).edtRefRefere.text;
  cdsAjuste.FieldByName('ITE_CODMAR').AsString := AQryConCit.FieldByName('ITE_CODMAR').AsString;
  cdsAjuste.FieldByName('ITE_ENTSAI').AsString := fGetEdt(Sender).edtRefEntSai.Text;
  cdsAjuste.FieldByName('ITE_TIPAJU').AsString := fGetEdt(Sender).edtRefTipAju.Text;
  cdsAjuste.FieldByName('ITE_CNV_ML').AsFLoat  := AQryConCit.FieldByName('ITE_CNV_ML').AsFloat;
  cdsAjuste.FieldByName('ITE_CODUNI').AsString := IIF(fEmptyStr(strCodAca), AQryConCit.FieldByName('ITE_CODUNI').AsString, strUniAca);
  cdsAjuste.FieldByName('ITE_SIGUNI').AsString := fRetSiglaUni(cdsAjuste.FieldByName('ITE_CODUNI').AsString);
  cdsAjuste.FieldByName('ITE_SALDOS').AsFloat  := fStrToFloat(fGetEdt(Sender).edtRefSaldos.Text);
  cdsAjuste.FieldByName('ITE_SAL_ML').AsFloat  := fStrToFloat(fGetEdt(Sender).edtRefSal_Ml.Text);
  cdsAjuste.FieldByName('ITE_QTDITE').AsFloat  := fStrToFloat(fGetEdt(Sender).edtRefQtdIte.Text);
  cdsAjuste.FieldByName('ITE_UNITAR').AsFloat  := fStrToFloat(fGetEdt(Sender).edtRefUnitar.Text);
  cdsAjuste.FieldByName('ITE_TOTITE').AsFloat  := fStrToFloat(fGetEdt(Sender).edtRefTotIte.Text);
  cdsAjuste.FieldByName('ITE_NUMLOT').AsString := fGetEdt(Sender).edtRefNumLot.Text;
  cdsAjuste.FieldByName('ITE_CODACA').AsString := strCodAca;
  cdsAjuste.FieldByName('ITE_EMPACA').AsString := strEmpAca;
  cdsAjuste.FieldByName('LOT_MEDB_L').AsString := edtLOT_MEDB_L.Text;
  cdsAjuste.FieldByName('LOT_MEDB_A').AsString := edtLOT_MEDB_A.Text;
  cdsAjuste.FieldByName('LOT_MEDL_L').AsString := edtLOT_MEDL_L.Text;
  cdsAjuste.FieldByName('LOT_MEDL_A').AsString := edtLOT_MEDL_A.Text;
  cdsAjuste.FieldByName('LOT_ESPESS').AsString := edtLOT_ESPESS.Text;
  cdsAjuste.FieldByName('LOT_NCHAPA').AsString := edtQtdChapa.Text;
  cdsAjuste.FieldByName('LOT_PRVMAP').AsString := edtUnitar.Text;
  cdsAjuste.FieldByName('LOT_PRVMAT').AsString := edtTotIte.Text;
  cdsAjuste.FieldByName('ITE_CUSLOT').AsFloat  := fltCusLot;
  cdsAjuste.FieldByName('ITEREL').AsInteger    := intIdAgrupador;
  cdsAjuste.FieldByName('ITE_EXTINI').AsString := 'N';
  cdsAjuste.FieldByName('ITE_QTDPLA').AsFloat  := AQtdPlanilha;
  cdsAjuste.FieldByName('ITE_OBSADC').AsString := edtObsAdc.Text;
  cdsAjuste.FieldByName('ITE_USASER').AsString := strIteUsaSer;
  cdsAjuste.Post;

end;

procedure TfrmAjusteEstoque.pAdicionaItem(Sender: TEditFocus);
begin

  If fItemEstrutura(fGetEdt(Sender).edtRefCodIte.Text) And (chkSubPro.Visible) And (chkSubPro.Checked) Then
    pCarregarSubProdutos(Sender, fGetEdt(Sender).edtRefCodIte.Text)
  Else
    pAdd(Sender);

end;

procedure TfrmAjusteEstoque.pAdicionarItem(Sender: TEditFocus);
  var
    intRecNo: Integer;
    edtRefCodIte,
    edtRefQtdIte,
    edtRefSaldos,
    edtRefTipAju,
    edtRefEntSai,
    edtRefSaldoDisponivel,
    edtRefNumLot: TEditFocus;
begin
  inherited;
  if fControleOrigemContraPartida(Sender) Then
  Begin
    edtRefCodIte :=  edtCodIteSai;
    edtRefQtdIte :=  edtQtdIteSai;
    edtRefSaldos :=  edtSaldosSai;
    edtRefTipAju :=  edtTipAjuSai;
    edtRefNumLot :=  edtNumLotSai;
    edtRefEntSai :=  edtEntSaiSai;
    edtRefSaldoDisponivel := edtSaldoDisponivelSaida;
  End
  Else
  Begin
    edtRefCodIte :=  edtCodIte;
    edtRefQtdIte :=  edtQtdIte;
    edtRefSaldos :=  edtSaldos;
    edtRefTipAju :=  edtTipAju;
    edtRefNumLot :=  edtNumLot;
    edtRefEntSai :=  edtEntSai;
    edtRefSaldoDisponivel := edtSaldoDisponivel;
  End;

  If Not cdsAjuste.IsEmpty  then
    intRecNo := cdsAjuste.RecNo
  Else
    intRecNo := -1;

  inherited;

  If fPodeInserir(edtRefTipAju.Text) And
     fProdutosMesmoTipo Then
  Begin

   if FblnAjuContrPart then
       pPesquisaCadIte(qryConCit, qryConCit, edtRefCodIte.Text, '', False);

    If (Not fVerificaQtdEstoque(fStrToFloat(edtRefQtdIte.Text), edtRefCodIte.text, edtRefNumLot.Text,edtRefEntSai.Text, edtRefTipAju.Text,
                                Not fEmptyStr(strCodAca), fStrToFloat(edtRefSaldos.Text), fStrToFloat(edtRefSaldoDisponivel.Text) )) Then
       Exit;

    If btnAdicionar.Tag <= 0 Then
      pAdicionaItem(Sender)
    Else
      pAlteraItem(Sender);

    pLimpaDadosItem(Sender);
    pCalculaTotalGeral;

    pSetFocus(edtRefCodIte);

    edtRefCodIte.Enabled := True;

  End;

  If intRecNo > -1 then
    cdsAjuste.RecNo := intRecNo;
end;

procedure TfrmAjusteEstoque.pAjustaMedidasMarmore(AblnVariasChapasPorMarmore: Boolean);
var qryComand: TUniQuery;
strSinal: String;
begin

  If cdsAjuste.FieldByname('ITE_ENTSAI').AsString = 'E' then
    strSinal := '+'
  Else
    strSinal := '-';

  qryComand := fCriaQuery;
  Try
    qryComand.SQL.Add('UPDATE CADLOT SET ');
    If Not AblnVariasChapasPorMarmore Then
    Begin
      qryComand.SQL.Add(' LOT_MEDB_L = LOT_MEDB_L ' + strSinal + ' :LOT_MEDB_L,');
      qryComand.SQL.Add(' LOT_MEDB_A = LOT_MEDB_A ' + strSinal + ' :LOT_MEDB_A,');
      qryComand.SQL.Add(' LOT_MEDL_L = LOT_MEDL_L ' + strSinal + ' :LOT_MEDL_L,');
      qryComand.SQL.Add(' LOT_MEDL_A = LOT_MEDL_A ' + strSinal + ' :LOT_MEDL_A,');
      qryComand.SQL.Add(' LOT_ESPESS = :LOT_ESPESS,');
      qryComand.SQL.Add(' LOT_VENTO1 = (LOT_MEDL_L*LOT_MEDL_A) * LOT_PREVE1,');
      qryComand.SQL.Add(' LOT_VETOE1 = (LOT_MEDL_L*LOT_MEDL_A) * LOT_PRVEE1');
    End
    Else
    Begin
      qryComand.SQL.Add(' LOT_VENTO1 = LOT_PREVE1 * (LOT_MEDL_L*LOT_MEDL_A) * ROUND((LOT_SALDOS / (LOT_MEDL_L*LOT_MEDL_A)), 4),');
      qryComand.SQL.Add(' LOT_VETOE1 = LOT_PRVEE1 * (LOT_MEDL_L*LOT_MEDL_A) * ROUND((LOT_SALDOS / (LOT_MEDL_L*LOT_MEDL_A)), 4)');
    End;
    qryComand.SQL.Add(' WHERE LOT_NUMLOT = :NUMLOT ');
    qryComand.SQL.Add('   AND LOT_CODITE = :CODITE ');
    qryComand.SQL.Add('   AND LOT_CODEMP = :CODEMP ');

    If Not AblnVariasChapasPorMarmore Then
    Begin
      qryComand.ParamByName('LOT_MEDB_L').AsFloat := cdsAjuste.FieldByname('LOT_MEDB_L').AsFloat;
      qryComand.ParamByName('LOT_MEDB_A').AsFloat := cdsAjuste.FieldByname('LOT_MEDB_A').AsFloat;
      qryComand.ParamByName('LOT_MEDL_L').AsFloat := cdsAjuste.FieldByname('LOT_MEDL_L').AsFloat;
      qryComand.ParamByName('LOT_MEDL_A').AsFloat := cdsAjuste.FieldByname('LOT_MEDL_A').AsFloat;
      qryComand.ParamByName('LOT_ESPESS').AsFloat := cdsAjuste.FieldByname('LOT_ESPESS').AsFloat;
    End;

    qryComand.ParamByName('NUMLOT').AsString := cdsAjuste.FieldByname('ITE_NUMLOT').AsString;
    qryComand.ParamByName('CODITE').AsString := cdsAjuste.FieldByname('ITE_CODITE').AsString;
    qryComand.ParamByName('CODEMP').AsString := VS_StrCodEmp;

    qryComand.ExecSQL;
  Finally
    FreeAndNil(qryComand);
  End;

end;

procedure TfrmAjusteEstoque.pAlteraItem(Sender: TEditFocus);
  var
    edtRefCodIte,
    edtRefDesIte,
    edtRefRefere,
    edtRefEntSai,
//    edtRefUnidade,
    edtRefQtdIte,
    edtRefUnitar,
    edtRefTotIte,
    edtRefNumLot: TEditFocus;
begin
  if fControleOrigemContraPartida(TEditFocus(Sender)) then
  Begin
    edtRefCodIte  := edtCodIteSai;
    edtRefDesIte  := edtDesIteSai;
    edtRefRefere  := edtRefereSai;
    edtRefEntSai  := edtEntSaiSai;
//    edtRefUnidade := edtUnidadeSai;
    edtRefQtdIte  := edtQtdIteSai;
    edtRefUnitar  := edtUnitarSai;
    edtRefTotIte  := edtTotIteSai;
    edtRefNumLot  := edtNumLotSai;
  End
  Else
  Begin
    edtRefCodIte  := edtCodIte;
    edtRefDesIte  := edtDesIte;
    edtRefRefere  := edtRefere;
    edtRefEntSai  := edtEntSai;
//    edtRefUnidade := edtUnidade;
    edtRefQtdIte  := edtQtdIte;
    edtRefUnitar  := edtUnitar;
    edtRefTotIte  := edtTotIte;
    edtRefNumLot  := edtNumLot;
 End;
 if FblnAjuContrPart then
    cdsAjuste.Locate('ITEREL; ITE_ENTSAI;ITE_CODITE', VarArrayOf([cdsAjuste.FieldByName('ITEREL').AsString, edtRefEntSai.Text, edtRefCodIte.Text]), []);

  With cdsAjuste Do
  Begin
    If IsEmpty Then
      Exit;
    Edit;
    {*****************************************}
    {* DADOS QUE SERAO ATUALIZADOS           *}
    {**************************************MV*}
    FieldByName('ITE_CODITE').AsString := edtRefCodIte.Text;
    FieldByName('ITE_CODGRU').AsString := qryConCit.FieldByName('ITE_CODGRU').AsString;
    FieldByName('ITE_DESITE').AsString := edtRefDesIte.Text;
    FieldByName('ITE_REFERE').AsString := edtRefRefere.Text;
    FieldByName('ITE_ENTSAI').AsString := edtRefEntSai.Text;

    If fEmptyStr(strCodAca) Then
      FieldByName('ITE_CODUNI').AsString := qryConCit.FieldByName('ITE_CODUNI').AsString
    Else
      FieldByName('ITE_CODUNI').AsString := strUniAca;

    FieldByName('ITE_SIGUNI').AsString := fRetSiglaUni(FieldByName('ITE_CODUNI').AsString);

    FieldByName('ITE_QTDITE').AsFloat  := fStrToFloat(edtRefQtdIte.Text);
    FieldByName('ITE_UNITAR').AsFloat  := fStrToFloat(edtRefUnitar.Text);
    FieldByName('ITE_TOTITE').AsFloat  := fStrToFloat(edtRefTotIte.Text);
    FieldByName('ITE_NUMLOT').AsString := edtRefNumLot.Text;
    FieldByName('ITE_CODACA').AsString := strCodAca;
    FieldByName('ITE_EMPACA').AsString := strEmpAca;
    FieldByName('ITE_USASER').AsString := strIteUsaSer;

    {*****************************************}
    {* DADOS DO FILTRO                       *}
    {**************************************MV*}
   // FieldByName('AUTINC').AsInteger := btnAdicionar.Tag;
    Post;
  End;

end;

procedure TfrmAjusteEstoque.pDeletaItem;
  var
    intValIteRelac: integer;
begin
  If Not cdsAjuste.IsEmpty then
  Begin
    cdsAjuste.DisableControls;
    intValIteRelac := cdsAjuste.FieldByName('ITEREL').AsInteger;

    While cdsAjuste.Locate('ITEREL', IntToStr(intValIteRelac), []) do
    Begin
      cdsAjuste.Delete;
    End;
    cdsAjuste.EnableControls;
  End;
  pCalculaTotalGeral;
end;

Function TfrmAjusteEstoque.fAggr(FieldAgg: TField): Variant;
Begin

  If TAggregateField(FieldAgg).Value = Null Then
    Result := 0
  Else
    Result := TAggregateField(FieldAgg).Value;

End;

function TfrmAjusteEstoque.fAjustaNumeroSerieEntrada(
  arrSeriesEntrada: TArrayItensNumeroSerieDevolucao): Boolean;
begin
  Result := TNumeroSerie.fAjustaEstoqueEntrada(arrSeriesEntrada);
end;

function TfrmAjusteEstoque.fBloqueiaImportacaoFul: Boolean;
begin
  Result := False;

  FHubMkp := fCampoTabela('SIS_HUBMKP', 'FULL_CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP', 'SIS_VALCFG'], ['CFG_CODEEE', VS_strCodEmp, edtCodEmpresa.Text]);

  if (not fEmptyStr(FChaveLockAjusteFul)) and (FChaveLockAjusteFul = Format(CHAVE_LOCK_AJUSTE_FUL, [FHubMkp, VS_strCodEmp])) then
    Exit(True);

  if fMensagem('Atenção', 'Para evitar problemas e divergências no estoque, o autcom vai interromper a importação do ' +
    'fulfillment informado até a gravação do ajuste ou até fechar a tela, cancelando a operação. Deseja realmente continuar?', ['&Sim', '&Não']) = 2 then
    Exit;

  FChaveLockAjusteFul := Format(CHAVE_LOCK_AJUSTE_FUL, [FHubMkp, VS_strCodEmp]);

  if (not fLock_Unlock(FChaveLockAjusteFul, True, False)) then
  begin
    fMensagem('Atenção', 'Há um ajuste de estoque externo para a empresa informada sendo executado ' +
                         'em outra estação - ' + fGetHostLock(FChaveLockAjusteFul) +'.' + #13 +
                         'Aguarde a liberação da para dar continuidade!', ['&OK']);
    FChaveLockAjusteFul := '';
    Exit;
  end;

  Result := True;
end;

procedure TfrmAjusteEstoque.pCalculaAjusteEstExtPlanilha;
var
  LQtdPlan  ,
  LQtdMovDet,
  LQtdEstExt,
  LQtdTotal : Double;
begin
  if (not FblnAjuSaldoExterno) or (not FImportacaoPlanilha) then
    Exit;

  if FAjuPlan.Active then
    FAjuPlan.EmptyDataSet;

  FItensSalNeg.Clear;

  pgbItens.Visible := True;
  pgbItens.Max     := cdsAjuste.RecordCount;

  cdsAjuste.First;

  while not cdsAjuste.Eof do
  begin
    LQtdPlan   := cdsAjuste.FieldByName('ITE_QTDPLA').AsFloat;
    LQtdMovDet := fQtdeItensMOVDETAposPlanilha(cdsAjuste.FieldByName('ITE_CODITE').AsString);

    if (not fEmptyStr(cdsAjuste.FieldByName('ITE_NUMLOT').AsString)) then
      LQtdEstExt := fCampoTabela('LOT_SALDOS', 'CADLOT',  ['LOT_FULFIL', 'LOT_CODITE', 'LOT_CODEMP', 'LOT_CODEXT'],
        ['S', cdsAjuste.FieldByName('ITE_CODITE').AsString, VS_strCodEmp, edtCodEmpresa.Text])
    else
      LQtdEstExt := fRetSalExterno(cdsAjuste.FieldByName('ITE_CODITE').AsString, VS_strCodEmp, edtCodEmpresa.Text);

    LQtdTotal := LQtdPlan - ((LQtdMovDet * (-1)) + LQtdEstExt);

    if (LQtdTotal = 0) then
    begin
      cdsAjuste.Delete;

      if (cdsAjuste.RecNo = cdsAjuste.RecordCount) then
        Break
      else
        Continue;
    end;

    cdsAjuste.Edit;

    if (LQtdTotal < 0) then
    begin
      cdsAjuste.FieldByName('ITE_QTDITE').AsFloat  := LQtdTotal * (-1);
      cdsAjuste.FieldByName('ITE_ENTSAI').AsString := 'S';
    end
    else
    begin
      cdsAjuste.FieldByName('ITE_QTDITE').AsFloat  := LQtdTotal;
      cdsAjuste.FieldByName('ITE_ENTSAI').AsString := 'E';
    end;

    cdsAjuste.Post;

    FAjuPlan.Append;
    FAjuPlan.FieldByName('CODITE').AsString := cdsAjuste.FieldByName('ITE_CODITE').AsString;
    FAjuPlan.FieldByName('DESITE').AsString := cdsAjuste.FieldByName('ITE_DESITE').AsString;
    FAjuPlan.FieldByName('QTDPLA').AsFloat  := LQtdPlan;
    FAjuPlan.FieldByName('QTDMOV').AsFloat  := LQtdMovDet;
    FAjuPlan.FieldByName('QTDAJU').AsFloat  := cdsAjuste.FieldByName('ITE_QTDITE').AsFloat;
    FAjuPlan.FieldByName('OPERAC').AsString := IIF((cdsAjuste.FieldByName('ITE_ENTSAI').AsString = 'E'), 'Entrada', 'Saída');
    FAjuPlan.FieldByName('SALATU').AsFloat  := LQtdEstExt;
    FAjuPlan.FieldByName('SALAPO').AsFloat  := LQtdEstExt + LQtdTotal;
    FAjuPlan.Post;

    If fFormataFloat(FAjuPlan.FieldByName('SALAPO').AsFloat, fCfgSis('DEQTAJ', varInteger)) < 0 Then
      FItensSalNeg.Add(FAjuPlan.FieldByName('CODITE').AsString +' - '+
                       FAjuPlan.FieldByName('DESITE').AsString);

    pgbItens.StepBy(1);

    cdsAjuste.Next;
  end;

  pgbItens.Position := 0;
  pgbItens.Visible := False;
end;

procedure TfrmAjusteEstoque.pCalculaTotalGeral;
  Var
    fltTotEnt: Double;
    fltTotSai: Double;

begin
 Try
   pSetaTipoAjuste;

   cdsAjuste.DisableControls;

   cdsAjuste.Filter := 'ITE_ENTSAI = ' + QuotedStr('E');
   cdsAjuste.Filtered := True;
   fltTotEnt := fAggr(cdsAjuste.FieldByName('TOT_TOTITE'));
   intQtdItens := cdsAjuste.RecordCount;

   cdsAjuste.Filter := 'ITE_ENTSAI = ' + QuotedStr('S');
   cdsAjuste.Filtered := True;
   fltTotSai := fAggr(cdsAjuste.FieldByName('TOT_TOTITE'));
   intQtdItens   :=  intQtdItens + cdsAjuste.RecordCount;

   cdsAjuste.Filter   := '';
   cdsAjuste.Filtered := False;

   edtTotGer.Text := FloatToStrF(fltTotEnt - fltTotSai, ffFixed, 12, 2);

   edtToItem.Text := IntToStr(cdsAjuste.RecordCount);

 Finally
   cdsAjuste.EnableControls;
 End;
end;

procedure TfrmAjusteEstoque.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  pDeletaTemporaria;
  FreeAndNil(qryConOco);
  pDestravaLockAjusteFul;
end;

function TfrmAjusteEstoque.fExisteAjuste(strNumDoc, strEspDoc: String): Boolean;
  Var
    qryDados: TUniQuery;
Begin
  qryDados := fCriaQuery;

  Try
    qryDados.SQL.Text := 'SELECT GER_NUMDOC FROM MOVGER WHERE GER_CODEMP = ' + QuotedStr(VS_strCodEmp) +
                         ' AND GER_ESPDOC = ' + QuotedStr(strEspDoc) + ' AND GER_SERIE_ = ' + QuotedStr('') +
                         ' AND GER_CODCLI = ' + QuotedStr(edtCodCli.Text) +
                         ' AND GER_NUMDOC = ' + QuotedStr(strNumDoc);

    qryDados.Open;

    Result := Not qryDados.IsEmpty;

  Finally
    FreeAndNil(qryDados);
  End;
End;

function TfrmAjusteEstoque.fProximoAjuste(strEspDoc: String): String;
  Var
    qryDados: TUniQuery;
Begin
  qryDados := fCriaQuery;

  Try

    qryDados.SQL.Text := 'SELECT MAX(GER_NUMDOC) AS NUMDOC FROM MOVGER WHERE GER_CODEMP = ' + QuotedStr(VS_strCodEmp) +
                         ' AND GER_ESPDOC = ' + QuotedStr(strEspDoc) + ' FOR UPDATE ';

    qryDados.Open;

    If qryDados.IsEmpty Then
      Result := fStrZero('1', fTamDocCadRec)
    Else
      Result := fStrZero((qryDados.FieldByName('NUMDOC').AsInteger + 1).ToString, fTamDocCadRec);

  Finally
    FreeAndNil(qryDados);
  End;
End;

Procedure TfrmAjusteEstoque.pAtualizaSequencial(strCfgSis: String; intValor: Integer);
  Var
    qryDados: TUniQuery;
Begin
  qryDados := fCriaQuery;

  Try

    qryDados.SQL.Text := 'UPDATE CFGSIS SET SIS_VALCFG = ' + QuotedStr(fStrZero(intValor.ToString, fTamDocCadRec)) +
                         ' WHERE SIS_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND SIS_CODCFG = '+  QuotedStr('CFG_' + strCfgSis);

    qryDados.ExecSQL;

  Finally
    FreeAndNil(qryDados);
  End;
End;

function TfrmAjusteEstoque.fConfirmaAjuste: Boolean;
  Var
    strAutInc   : String;
    dtaDtaEnt   : TDateTime;
    hraHraEnt   : TTime;
    strClaFis   : String;
    strAutIncTmp: String;
    fltQtdSalMl : Double;
    blnAjuGra   : Boolean;
    recServicos : TDadosServicos;
    fltCnv_Ml   : Double;
    strNumDocTM : String;
    strAutIncTM : String;
    blnGerouTM  : Boolean;
    strCliEst   : String;
    arrDuplic   : TarrDuplicata;
    fltPreCus   : Double;
    strCodErrosAuditoria: String;
    arrItensSerieEntrada: TArrayItensNumeroSerie;
    arrItensSerieSaida: TArrayItensNumeroSerie;
    blnDeveMovimentarEstoqueFisico: Boolean;
begin
  With cdsAjuste Do
  Begin
    DisableControls;

    Filter := 'ITE_TIPAJU = ' + QuotedStr('G');
    Filtered := True;

    blnAjuGra := RecordCount > 0;

    Filter := '';
    Filtered := False;

    EnableControls;
  End;

  FillChar(arrItensSerieEntrada, SizeOf(arrItensSerieEntrada), #0);
  FillChar(arrItensSerieSaida, SizeOf(arrItensSerieSaida), #0);

  if (FZerarEstItensEmpExt) then
    fChamaTelaGravando(fZerarEstoqueExtItensForaDaPlanilha, 'Carregando itens para zerar estoque...');

  if (cdsAjuste.RecordCount = 0) then
  begin
    Result := True;
    Exit;
  end;

  blnGerouTM := false;

  If FImportacaoPlanilha Then
  begin
    dtaDtaEnt := FDtaPlanilha;
    hraHraEnt := FHraPlanilha;
  end
  else
  begin
    dtaDtaEnt := StrToDate(mskDtaEnt.Text);
    hraHraEnt := fTime();
  end;

  If ((dtaDtaEnt = 0) or (hraHraEnt = 0)) Then
  Begin
    fMensagem('','Não foi possível determinar a '+ IIF(FDtaPlanilha = 0, 'data', 'hora') + ' de entrada, refaça a operação! ',['&OK']);
    Exit(False);
  End;

  If (blnAjuGra) Then
    edtEspDoc.Text := 'ML'
  Else
    edtEspDoc.Text := 'AJ';

  strCliEst := fRetEstadoCliente(edtCodCli.Text);

  objAuditoriaSaldo.Limpar;

  fStartTransaction;

  Try

    pgbItens.Visible := True;
    pgbItens.Max     := cdsAjuste.RecordCount;

    {********************************************}
    {* PEGA PROXIMO DOCUMENTO P/ AJUSTE (AJ/ML) *}
    {*****************************************JB*}
    strNumDocML := IIF(blnAjuGra, fRetSequencial('PRO_ML', VS_strCodEmp, fTamDocCadRec), EmptyStr);

    If blnAjuGra And fExisteAjuste(strNumDocML, 'ML') Then
    Begin
      strNumDocML := fProximoAjuste('ML');
      pAtualizaSequencial('PRO_ML', strNumDocML.ToInteger + 1);
    End;

    strNumDocAJ := fRetSequencial('PRO_AJ', VS_strCodEmp, fTamDocCadRec);

    If fExisteAjuste(strNumDocAJ, 'AJ') Then
    Begin
      strNumDocAJ := fProximoAjuste('AJ');

      pAtualizaSequencial('PRO_AJ', strNumDocAJ.ToInteger + 1);
    End;

    If fEmptyStr(strCodOpe) Then
       strCodOpe := strLoginUsuarioLogado;

    FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

    {****************}
    {* GRAVA MOVGER *}
    {*************MV*}
    Result := fGravaMovGer(strAutInc,                                                     // Auto Incremento (Retorno)
                           IIF(blnAjuGra, strNumDocML, strNumDocAJ),                      // Numero Documento
                           edtEspDoc.Text,                                                // Espécie
                           VS_strCodEmp,                                                  // Empresa
                           '',                                                            // Transportadora
                           strCodVen,                                                     // Vendedor
                           '',                                                            // Fornecedor
                           edtCodCli.Text,                                                // Cliente
                           'C',                                                           // Tipo ((C)liente / (F)ornecedor)
                           dtaDtaEnt,                                                     // Data da Entrada
                           hraHraEnt,                                                          // Hora da Entrada
                           VS_Date,                                                       // Data do Documento
                           '01000',                                                       // Condição de Pagamento
                           strCliEst,                                                     // Estado do Cliente / Fornecedor
                           '',                                                            // Nome do Consumidor
                           '',                                                            // Endereço do Consumidor
                           '',                                                            // Bairro do Consumidor
                           '',                                                            // Cep do Consumidor
                           '',                                                            // Cidade do Consumidor
                           '',                                                            // Estado do Consumidor
                           '',                                                            // Telefone do Consumidor
                           0,
                           '',                                                            // CNPJ / CGC
                           '',                                                            // CNPJ / CGC do consumidor
                           '',                                                            // Inscrição estadual do Consumidor
                           '',                                                            // RG do consumidor
                           0.0,                                                           // Base Simples Paulista
                           0.0,                                                           // Base de IPI
                           0.0,                                                           // Aliquota de IPI
                           0.0,                                                           // Total de IPI
                           0.0,                                                           // Base de ICMS
                           0.0,                                                           // Aliquota de ICMS
                           0.0,                                                           // Total de ICMS
                           0.0,                                                           // Valor de Substituição
                           0.0,                                                           // Aliquota de Substituição
                           0.0,                                                           // Base de Substituição
                           0.0,                                                           // Base de Substituição Simulada
                           0.0,                                                           // Desconto Especial
                           Abs(fStrToFloat(edtTotGer.Text)),                              // Valor Contábil
                           Abs(fStrToFloat(edtTotGer.Text)),                              // Total dos Itens
                           IIF(fHabilitouCustoPorTabelaDePreco, Abs(fStrToFloat(edtTotGer.Text)), 0.0), // Total de Custo
                           0.0,                                                           // Total Médio
                           '',                                                            // Tipo de Frete
                           0.0,                                                           // Valor do Frete
                           0.0,                                                           // Peso Bruto
                           0.0,                                                           // Peso Liquido
                           0.0,                                                           // Volume
                           '',                                                            // Especie
                           '',                                                            // Marca
                           edtObse01.Text,                                                // Mensagem 1
                           edtObse02.Text,                                                // Mensagem 2
                           edtObsAdc.Text,                                                // Mensagem 3
                           '',                                                            // Mensagem 4
                           '',                                                            // Mensagem 5
                           blnAjuGra,                                                     // Indica se Faturado ou nao
                           IIF(blnAjuGra, 'AJ', EmptyStr),                                // Tipo de Faturamento
                           IIF(blnAjuGra, strNumDocAJ, EmptyStr),                         // Numero de Faturamento
                           IIF(blnAjuGra, VS_strCodEmp, EmptyStr),                        // Empresa dd Faturamento
                           IIF(blnAjuGra, VS_Date, 0),                                    // Data de Faturamento
                           IIF(blnAjuGra, strCodVen, EmptyStr),                           // Vendedor do Faturamento
                           IIF(blnAjuGra, '01000', EmptyStr),                             // Condição de Pagamento do Faturamento
                           False,                                                         // Devolução Especial
                           Abs(IIF(blnAjuGra, fStrToFloat(edtTotGer.Text), 0.0)),         // Valor do Faturamento
                           0.0,                                                           // Valor Parcela 01
                           0.0,                                                           // Valor Parcela 02
                           0.0,                                                           // Valor Parcela 03
                           0.0,                                                           // Valor Parcela 04
                           0.0,                                                           // Valor Parcela 05
                           0.0,                                                           // Valor Parcela 06
                           0.0,                                                           // Valor Parcela 07
                           0.0,                                                           // Valor Parcela 08
                           0.0,                                                           // Valor Parcela 09
                           0.0,                                                           // Valor Parcela 10
                           0.0,                                                           // Valor Parcela 11
                           0.0,                                                           // Valor Parcela 12
                           arrDuplic,
                           '',                                                            // Série
                           'N',                                                           // Nota Especial
                           '9999',                                                        // Classificação Fiscal 1
                           '',                                                            // Classificação Fiscal 2
                           '',                                                            // Classificação Fiscal 3
                           '',                                                            // Natureza da Operação
                           0.0,                                                           // Percentual de Desconto
                           strCodOpe,                                                     // Codigo do Digitador
                           '',                                                            // Codigo da Condição
                           '',                                                            // Forma de Pagamento
                           0.0,                                                           // Fator para meia nota
                           recServicos,
                           0.0,                                                           // Despesa acessoria
                           '',                                                            // Origem do Documento (V)enda (D)evolução
                           'N',                                                           // Usa controle de entrega
                           '',                                                            // Representante
                           0.0,                                                           // Aliquota do IRPF (SERVIÇO)
                           0.0,                                                           // Valor do IRPF (SERVIÇO + PRODUTO)
                           0.0,                                                           // Aliquota do Pis (SERVIÇO)
                           0.0,                                                           // Valor do Pis (SERVIÇO + PRODUTO)
                           0.0,                                                           // Aliquota do Cofins (SERVIÇO)
                           0.0,                                                           // Valor do Cofins (SERVIÇO + PRODUTO)
                           0.0,                                                           // Aliquota do CSLL (SERVIÇO)
                           0.0,                                                           // Valor do CSLL (SERVIÇO + PRODUTO)
                           0.0,                                                           // Valor de IRPF que foi retido
                           0.0,                                                           // Valor de PIS que foi retido
                           0.0,                                                           // Valor de COFINS que foi retido
                           0.0,                                                           // Valor de CSLL que foi retido
                           '',                                                            // Notas de Documentos Acumulados
                           0.0,                                                           // Aliquota do IRPF (PRODUTOS)
                           0.0,                                                           // Aliquota do PIS (PRODUTOS)
                           0.0,                                                           // Aliquota do COFINS (PRODUTOS)
                           0.0,                                                           // Aliquota do CSLL (PRODUTOS)
                           0.0,                                                           // Valor de SERVIÇO que foi retido
                           '',                                                            // Notas de documentos acumulados (SERVIÇO)
                           0.0,                                                           // Percentual da Seguridade Social
                           0.0,                                                           // Valor da Seguridade Social
                           0.0,                                                           // Valor do IRPF Retido (Produto)
                           0.0,                                                           // Valor do IRPF Devido (Produto)
                           0.0,                                                           // Valor do IRPF Retido (Serviço)
                           0.0,                                                           // Valor do IRPF Devido (Serviço)
                           0.0,                                                           // Valor do PIS Retido (Produto)
                           0.0,                                                           // Valor do PIS Devido (Produto)
                           0.0,                                                           // Valor do PIS Retido (Serviço)
                           0.0,                                                           // Valor do PIS Devido (Serviço)
                           0.0,                                                           // Valor do COFINS Retido (Produto)
                           0.0,                                                           // Valor do COFINS Devido (Produto)
                           0.0,                                                           // Valor do COFINS Retido (Serviço)
                           0.0,                                                           // Valor do COFINS Devido (Serviço)
                           0.0,                                                           // Valor do CSLL Retido (Produto)
                           0.0,                                                           // Valor do CSLL Devido (Produto)
                           0.0,                                                           // Valor do CSLL Retido (Serviço)
                           0.0,                                                           // Valor do CSLL Devido (Serviço)
                           '',                                                            // Ordem de Produção
                           0.0,                                                           // Base Orgão Público
                           0.0,                                                           // ICMS Orgão Público
                           0,                                                             // Número do Conhecimento de Frete
                           '',                                                            // Consumidor final
                           'N',                                                           // Entrega no Faturamento
                           '',                                                            // Cliente de Faturamento
                           '',                                                            // Operador da Expedição
                           '',                                                            // Separador da Expedição
                           '',                                                            // Tabela de Preços utilizada
                           '',
                           'N',                                                           // Entrega Futura
                           FALSE,                                                         // Baixa de Entrega Futura
                           0,                                                             // Margem de Lucro
                           0.0,                                                           // Base do retido (caso tivesse) com ipi e frete de entrada
                           0.0,                                                           // Valor do retido considerando a base acima.
                           'N',                                                           // Gerar produção fora da loja
                           '',                                                            // Numero do Registro - Correios ou Transportadora
                           VS_Date,                                                       // Data de Entrega no Romaneio
                           '',                                                            // Classificação fiscal 4
                           'N',                                                           // AUTO-SERVIÇO
                           '',                                                            // Evento
                           '',                                                            // AUTINC ENDEREÇO DE ENTREGA
                           '',                                                            // Conteúdo do CNFNFE
                           edtCodOco.Text,                                                // Motivo da Devolução
                           '',                                                            //
                           True,                                                          // Imprime Duplicatas na NF-e
                           0,                                                             //  fltValCre
                           0,                                                             //  dtadtlBex
                           '',                                                            //  strEmlCon
                           0,                                                             //  dtaDtESNf
                           0,                                                             //  tmrHrESNf
                           Nil,                                                           //  objFinanc
                           '',                                                            //  strDocCon
                           '',                                                            //  strCodObr
                           '',                                                            //  strCodArt
                           'N',                                                           //  strPermut
                           '',                                                            //  strRetIss
                           IIF(FblnAjuSaldoExterno, 'AF', ''),                            //  strOpcDoc
                           0,                                                             //  fltFreSug
                           '',                                                            //  strNumAde
                           0,                                                             //  fltBasAnt
                           0,                                                             //  fltValAnt
                           '',                                                            //  strNaoAtu
                           '',                                                            //  strEntUrg
                           '',                                                            //  strMenExp
                           '',                                                            //  strMenEx2
                           '',                                                            //  strMenEx3
                           '',                                                            //  strMenEx4
                           0,                                                             //  fltDupRec
                           0,                                                             //  fltValAdt
                           0,                                                             //  fltDeDVCf
                           '',                                                            //  strPlaVei
                           '',                                                            //  strKm_Vei
                           '',                                                            //  strCliOri
                           '',                                                            //  strCodMot
                           '',                                                            //  strBetone
                           '',                                                            //  strLacre_
                           '',                                                            //  strTipMps
                           '',                                                            //  strAbatim
                           '',                                                            //  strBrita_
                           '',                                                            //  strConBom
                           0,                                                             //  intFckDia
                           0,                                                             //  fltImpPag
                           0,                                                             //  intPrzMed
                           False,                                                         //  blnImpPdv
                           False,                                                         //  blnDTEXREP
                           '',                                                            //  strChvNfeDev
                           '',                                                            //  strOpeSol
                           False,                                                         //  blnEst_Dv
                           '',                                                            //  strNumCOODev
                           '',                                                            //  strNumSerDev
                           '',                                                            //  strNumUSUDev
                           '',                                                            //  strTipDocDev
                           0,                                                             //  fltTotDif
                           nil,                                                           //  objFazenda
                           0,                                                             //  fltFedImp
                           0,                                                             //  fltEstImp
                           0,                                                             //  fltMunImp
                           0,                                                             //  fltTroco_
                           '',                                                            //  strObsNfeFis
                           'N',                                                           //  strVenPre
                           '',                                                            //  strSeqDocOri
                           False,                                                         //  blnConEqu
                           False,                                                         //  blnDescIncond
                           True,                                                          //  blnGraCTP
                           '',                                                            //  strNumera
                           'N',                                                           //  strEdiPes
                           0,                                                             //  fltTaxEnt
                           0,                                                             //  fltVrdIcm
                           0,                                                             //  fltBasVrd
                           0,                                                             //  intNroBox
                           '',                                                            //  strCodEmbarcacao
                           0,                                                             //  fltTotBri
                           '',                                                            //  strTraRdp
                           '',                                                            //  strCliCtt
                           '',                                                            //  strCodMod
                           '',                                                            //  strNumGui
                           edtHisCom.Text,                                                //  strHisCom
                           '',                                                            //  strCodPrj
                           '',                                                            //  strNatCfo
                           '',                                                            //  strTpOper
                           '',                                                            //  strCupDes
                          'S',                                                            //  strNotPau
                            0,                                                            //  fltCotMoe
                            0,                                                            //  fltFreMkp
                            0,                                                            //  fltComMkp
                           '',                                                            //  strPlaFat
                          False,                                                          //  blnDevWms
                          False,                                                          //  blnFullFilmentModoRobo
                            0,                                                            //  fltFreCot
                            0,                                                            //  fltFreRat
                          'N',                                                            //  strEntSim
                           '',                                                            //  strSeqDmp
                           '',                                                            //  strEntFutOpc
                            0,                                                            //  fltTotIpiEntFut
                            0,                                                            //  fltTotRetEntFut
                            0,                                                            //  fltTotFcpSTEntFut
                            0,                                                            //  fltICMDes
                            0,                                                            //  fltDesPis
                            '',                                                           //  strOpFaEx
                            '',                                                           //  strDocAba
                            '',                                                           //  strEspAba
                            '',                                                           //  strEmpAba
                            '',                                                           //  strCliAba
                           False,                                                         //  blnColeta
                           '',                                                            //  strNumeroRandomico
                           '',                                                            //  strNumeroDrawback
                           edtFinAju.Text);                                               //  finalidade Ajuste

    If Result Then
      objAuditoriaSaldo.Adicionar(strAutInc, 'MOVGER');

    With cdsAjuste Do
    Begin

      qryConIte.Close;
      qryConIte.SQL.Clear;
      qryConIte.SQL.Add(fGetSqlIteGer);

      First;

      While (Not Eof) And (Result) Do
      Begin

        If FieldByName('ITE_ENTSAI').AsString = 'E' Then
          strClaFis := '1999'
        Else
          strClaFis := '5999';

        qryConIte.Close;
        qryConIte.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
        qryConIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryConIte.Open;

        If fHabilitouCustoPorTabelaDePreco Then
        Begin
          pCarregaValoresCusto(FieldByName('ITE_CODITE').AsString, VS_strCodEmp, fRetornaTabelaCusto);
          fltPreCus := recCustoItem.fltPreCus;
        End
        Else
          fltPreCus := qryConIte.FieldByName('ITE_PRECUS').AsFloat;

        fltCnv_Ml := IIF(blnAjuGra, qryConIte.FieldByName('ITE_CNV_ML').AsFloat, 1);

        strAutIncTmp := '';

        blnDeveMovimentarEstoqueFisico := True;

        //movimenta ACAGER
        If Not fEmptyStr(FieldByName('ITE_CODACA').AsString) Then
          blnDeveMovimentarEstoqueFisico := False;

        If FblnAjuSaldoExterno And (fCfgSis('MOVFUL') = '2') Then
          blnDeveMovimentarEstoqueFisico := False;

        Result := Result And fGravaMovDet(strAutIncTmp,                                                // Retorna Auto-Incremento por Referencia
                               strAutInc,                                                   // Sequencial do Arquivo Geral
                               IIF(blnAjuGra, strNumDocML, strNumDocAJ),                    // Numero Documento
                               edtEspDoc.Text,                                              // Espécie
                               VS_strCodEmp,                                                // Empresa
                               FieldByName('ITE_CODITE').AsString,                          // Cód. Item
                               strCodVen,                                                   // Vendedor
                               '',                                                          // Código Diversos
                               FieldByName('ITE_CODMAR').AsString,                          // Código da Marca
                               '',                                                          // Fornecedor
                               edtCodCli.Text,                                              // Cliente
                               dtaDtaEnt,                                                   // Data da Entrada
                               hraHraEnt,                                                        // Hora da Entrada
                               VS_Date,                                                     // Data do Documento
                               '01000',                                                     // Condição de Pagamento
                               'C',                                                         // Tipo: (C)liente / (F) Fornecedor
                               strCliEst,                                                    // Estado do Fornecedor
                               FieldByName('ITE_DESITE').AsString,                          // Descrição do Item
                               FieldByName('ITE_REFERE').AsString,                          // Referência do Item
                               FieldByName('ITE_CODUNI').AsString,                          // Cód. Unidade
                               qryConCit.FieldByName('ITE_CODFOR').AsString,                // Fornecedor Item
                               FieldByName('ITE_QTDITE').AsFloat,                           // Quantidade do Item
                               FieldByName('ITE_UNITAR').AsFloat,                           // Valor Unitario
                               FieldByName('ITE_UNITAR').AsFloat,                           // Valor Unitário Original
                               FieldByName('ITE_UNITAR').AsFloat,                           // Valor Unitário Original sem juros
                               FieldByName('ITE_UNITAR').AsFloat * FieldByName('ITE_QTDITE').AsFloat,    // Total do Item
                               FieldByName('ITE_UNITAR').AsFloat * FieldByName('ITE_QTDITE').AsFloat,    // Valor Contábil do Item

                               (IIF(FieldByName('ITE_CUSLOT').AsFloat > 0,
                                      FieldByName('ITE_CUSLOT').AsFloat,
                                      fltPreCus) / fltCnv_Ml) * FieldByName('ITE_QTDITE').AsFloat, // Valor Total de Custo

                               (qryConIte.FieldByName('ITE_PREMED').AsFloat / fltCnv_Ml) * FieldByName('ITE_QTDITE').AsFloat, // Valor Total Medio

                               0.0,                                                         // % Desconto do Item
                               0.0,                                                         // Valor do Frete
                               0.0,                                                         // Valor do Desconto Especial
                               '',                                                          // Código do Representante
                               '',                                                          // Código do Vendedor 2
                               0.0,                                                         // Percentual de Comissão do Vendedor
                               0.0,                                                         // Total de Comissão do Vendedor
                               0.0,                                                         // Total de Comissão do Vendedor 2
                               strClaFis,                                                   // Classificação Fiscal
                               '',                                                          // Código Fiscal
                               0.0,                                                         // Valor IPI
                               0.0,                                                         // Aliquota IPI
                               0.0,                                                         // Base IPI
                               0.0,                                                         // Valor de ICMS
                               0.0,                                                         // Aliquota de ICMS
                               0.0,                                                         // Base de ICMS
                               0.0,                                                         // Valor de Substituição
                               0.0,                                                         // Aliquota de Substituição
                               0.0,                                                         // Base de Substituição
                               0.0,                                                         // Total de Peso
                               0.0,                                                         // Percentual de Base de ICMS
                               0.0,                                                         // Percentual de Redução de Base
                               blnAjuGra,                                                   // Indica se ja esta Faturado
                               IIF(blnAjuGra, 'AJ', EmptyStr),                              // Tipo de Faturamento
                               IIF(blnAjuGra, strNumDocAJ, EmptyStr),                       // Numero de Faturamento
                               IIF(blnAjuGra, VS_strCodEmp, EmptyStr),                      // Empresa dd Faturamento
                               IIF(blnAjuGra, VS_Date, 0),                                  // Data de Faturamento
                               IIF(blnAjuGra, strCodVen, EmptyStr),                         // Vendedor do Faturamento
                               IIF(blnAjuGra, '01000', EmptyStr),                           // Condição de Pagamento do Faturamento
                               Abs(IIF(blnAjuGra, fStrToFloat(edtTotGer.Text), 0.0)),       // Valor do Faturamento
                               'NOR',                                                       // Identificação Produto ( Normal / Outros )
                               qryConCit.FieldByName('ITE_INCPIS').AsString,                // Indice se incide Pis
                               '',                                                          // Série
                               0.0,                                                         // Valor de Despesa Acessória
                               'N',                                                         // Nota Especial
                               '',                                                          // Documento da Devolução
                               '',                                                          // Espécie da Devolução
                               '',                                                          // Empresa da Devolução
                               '',                                                          // Item de Chamada (TINTA DE MAQUINA)
                               '',                                                          // Item da Tinta (TINTA DE MAQUINA)
                               '',                                                          // Descrição da Cor (TINTA DE MAQUINA)
                               '',                                                          // Tipo de Embalagem (TINTA DE MAQUINA)
                               0.0,                                                         // Quantidade de Embalagem (TINTA DE MAQUINA)
                               0.0,                                                         // Preço da Embalagem (TINTA DE MAQUINA)
                               '',                                                          // Tipo de Preço (TINTA DE MAQUINA)
                               0.0,                                                         // Preço de Venda da Tinta (TINTA DE MAQUINA)
                               0.0,                                                         // Preço de Compra da Tinta (TINTA DE MAQUINA)
                               0.0,                                                         // Fator da Tinta (TINTA DE MAQUINA)
                               '',                                                          // Produto Embalagem (TINTA DE MAQUINA)
                               strCodOpe,                                                   // Código do Digitador
                               '',                                                          // Codigo da Condição
                               '',                                                          // Forma de Pagamento
                               '',                                                          // Item da Embalagem
                               '',                                                          // Grupo do Item da Embalagem
                               0,                                                           // Quarto da Lazzumiz
                               'N',                                                         // É item em promoção?
                               '',                                                          // Tipo de Tinta
                               0.0,                                                         // Quantidade de Pulsos
                               '',                                                          // Número do pedido de compras
                               '',                                                          // Origem do documento
                               '',                                                          // Pedido de Venda - Número
                               '',                                                          // Pedido de Venda - Espécie
                               '',                                                          // Pedido de Venda - Empresa
                               0,                                                           // Pedido de Venda - Sequencial
                               '',                                                          // Ordem de Produção
                               '',                                                          // Descrição para Nota Fiscal Especial
                               '',
                               0,
                               0,
                               0.0,                                                         // Volume a produzir (Tinta de Máquina Venda Dinâmica)
                               FieldByName('ITE_CODACA').AsString,
                               FieldByName('ITE_EMPACA').AsString,
                               Not fEmptyStr(FieldByName('ITE_CODACA').AsString),           // PROD ACABADO
                               blnDeveMovimentarEstoqueFisico.ToFilKar,                     // FILKAR
                               '',                                                          //  Especie da Entrega Fututa
                               '',                                                          //  Documento da Entrega Fututa
                               '',
                               '',                                                          //  Empresa da Entrega Fututa
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

                               (IIF(FieldByName('ITE_CUSLOT').AsFloat > 0,
                                      FieldByName('ITE_CUSLOT').AsFloat,
                                      fltPreCus) / fltCnv_Ml) * FieldByName('ITE_QTDITE').AsFloat, // Valor Total de Custo 2

                               0,
                               0,
                               '',
                               IIF(FBlnAjuSaldoExterno, edtLotExt.Text, FieldByName('ITE_NUMLOT').AsString),
                               'N',
                               0,
                               0,
                               0,
                               (qryConIte.FieldByName('ITE_PREULT').AsFloat / fltCnv_Ml) * FieldByName('ITE_QTDITE').AsFloat, // fltTotUlt
                               (qryConIte.FieldByName('ITE_IMPULT').AsFloat / fltCnv_Ml) * FieldByName('ITE_QTDITE').AsFloat, // fltImpUlt
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
                               0,  // fltUniTab
                               '', // strLot_TA
                               0,  // fltConFre
                               0,  // fltBasAnt
                               0,  // fltIcmAnt
                               0,  // fltVendor
                               0,  // fltOutDes
                               0,  // fltVlGnre
                               'P',
                               FieldByName('ITE_UNITAR').AsFloat * FieldByName('ITE_QTDITE').AsFloat,  // fltOutIcm
                               0,         // fltIseIcm
                               0,         // fltFreSug
                               '',        // strCodMot
                               '',        // strNatPis
                               '',        // strNatCof
                               '',        // strSeqGad
                               0,         // fltOutVal
                               0,         // fltIcmSai
                               0,         // fltImpFed
                               0,         // fltDesOpe
                               0,         // fltQtdExp
                               '',        // strNumCmp
                               0,         // intNItCmp
                               0,         // fltDeDVCf
                               '',        // strCodMec
                               'N',       // strAntPro
                               'N',       // strAntFre
                               0,         // fltMedAnt
                               0,         // fltPreAnt
                               0,         // fltImpAnt
                               '',        // strSeqAnt
                               'N',       // strRICMPR
                               0,         // fltComLiq
                               '',        // strNcmTin
                               0,         // fltValIva
                               'N',       // strCliBus
                               '',        // strTurEnt
                               'NOR',     // strIdeDev
                               0,         // fltPeBaST
                               0,         // fltVal_RT
                               0,         // fltDesCli
                               0,         // fltImpPag
                               0,         // fltTaxJur
                               0,         // fltSerRat
                               '',        // strProBri
                               0,         // fltPonBri
                               0,         // fltValDif
                               0,         // fltVaFrAn
                               '',        // strLotAba
                               0,         // fltFedImp
                               0,         // fltEstImp
                               0,         // fltMunImp
                               '',        // strIncDev
                               'N',       // strBrinde
                               '',        // strCodPar
                               '',        // strTipBri
                               0,         // fltIcmOrg
                               '',        // strBaqtze
                               '',        // strIncFut
                               0,         // fltValFle
                               0,         // fltTaxEnt
                               0,         // fltVrdIcm
                               0,         // fltBasVrd
                               '',        // strMtdIcm
                               'N',       // strBxSbIt
                               '',        // strIteAbf
                               'N',       // strAtivac
                               0,         // intSeqCom
                               0,         // fltVICMDe
                               '',        // strNcmIte
                               0,         // fltComDig
                               0,         // fltPerDig
                               0,         // fltIcmPav
                               False,     // blnIcmSai
                               0,         // fltAlDifa
                               '',        // strAutSai
                               0,         // fltBFCPST
                               0,         // fltPFCPST
                               0,         // fltVFCPST
                               '',        // strDadSep
                               '',        // strAutEle
                               '',        // strNotUlt
                               0,         // fltPICMEF
                               0,         // fltBICMEF
                               0,         // fltAICMEF
                               0,         // fltVICMEF
                               0,         // fltBSTANT
                               0,         // fltVSTANT
                               '',        // strNotC17
                               0,         // fltAlq922
                               0,         // fltDesCnd
                               '',        // strProEsp
                               '',        // strCodPro
                               '',        // strInc_Pd
                               0,         // fltSICMEF
                               0,   // fltValTCI:
                               0,   // fltCalTCI:
                               0,   // fltVal_TS:
                               IIf(FBlnAjuSaldoExterno, 'S', ''),        // strExtFul
                               IIf(FBlnAjuSaldoExterno, edtCodEmpresa.Text, ''), //strCodExt
                               0,
                               0,
                               '',
                               '',
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
                               0,
                               0,
                               0,
                               False,
                               '',
                               '',
                               '',
                               '',
                               False,
                               '',
                               0,
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               0,
                               0,
                               False,
                               0,
                               0,
                               0,
                               0,
                               0,
                               'N',
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               'N',
                               '',
                               '',
                               '',
                               0,
                               0,
                               False,
                               FblnAjuSaldoExterno.ToFilFul, // blnFilFul
                               False,
                               '',
                               0,
                               '',
                               0,
                               IIF(FBlnAjuSaldoExterno, FieldByName('ITE_ENTSAI').AsString, '') //strFilFul_EntSai
                               );

        If Not Result Then
          Break;

        ReprocessarItem(FieldByName('ITE_CODITE').AsString, '', False);

        If (Not blnAjuGra) And (fCfgSis('NUMSER', varString) = 'S') And (FieldByName('ITE_USASER').AsString = 'S') Then
        Begin
          If (FieldByName('ITE_ENTSAI').AsString = 'E') Then
          Begin
            SetLength(arrItensSerieEntrada, Length(arrItensSerieEntrada)+1);

            arrItensSerieEntrada[Length(arrItensSerieEntrada)-1].strAutInc := strAutIncTmp;
            arrItensSerieEntrada[Length(arrItensSerieEntrada)-1].strCodIte := FieldByName('ITE_CODITE').AsString;
            arrItensSerieEntrada[Length(arrItensSerieEntrada)-1].strDesIte := FieldByName('ITE_DESITE').AsString;
            arrItensSerieEntrada[Length(arrItensSerieEntrada)-1].fltQtdIte := FieldByName('ITE_QTDITE').AsFloat;
            arrItensSerieEntrada[Length(arrItensSerieEntrada)-1].strEmpDoc := VS_strCodEmp;
            arrItensSerieEntrada[Length(arrItensSerieEntrada)-1].strEmpIte := VS_strCodEmp;
            arrItensSerieEntrada[Length(arrItensSerieEntrada)-1].strTabDev := 'MOVDET';
          End
          Else If (FieldByName('ITE_ENTSAI').AsString = 'S') Then
          Begin
            SetLength(arrItensSerieSaida, Length(arrItensSerieSaida)+1);

            arrItensSerieSaida[Length(arrItensSerieSaida)-1].strAutInc := strAutIncTmp;
            arrItensSerieSaida[Length(arrItensSerieSaida)-1].strCodIte := FieldByName('ITE_CODITE').AsString;
            arrItensSerieSaida[Length(arrItensSerieSaida)-1].strDesIte := FieldByName('ITE_DESITE').AsString;
            arrItensSerieSaida[Length(arrItensSerieSaida)-1].fltQtdIte := FieldByName('ITE_QTDITE').AsFloat;
            arrItensSerieSaida[Length(arrItensSerieSaida)-1].strEmpDoc := VS_strCodEmp;
            arrItensSerieSaida[Length(arrItensSerieSaida)-1].strEmpIte := VS_strCodEmp;
            arrItensSerieSaida[Length(arrItensSerieSaida)-1].strTabDev := 'MOVDET';
          End;
        End;

        // Criando documentos "TM"
        If (FieldByName('ITE_TIPAJU').AsString = 'G') And
           (FieldByName('ITE_QTDITE').AsFloat > qryConIte.FieldByName('ITE_SAL_ML').AsFloat) And
           (FieldByName('ITE_ENTSAI').AsString = 'S') Then
        Begin
          If (Not (blnGerouTM)) Then
          Begin
            strNumDocTM := fRetSequencial('PRO_TM');

            strAutIncTM := fstrEspaco(' ', 20);

            Result := fGravaMovGer(strAutIncTM,                                                   // Auto Incremento (Retorno)
                                   strNumDocTM,                                                   // Numero Documento
                                   'TM',                                                          // Espécie
                                   VS_strCodEmp,                                                  // Empresa
                                   '',                                                            // Transportadora
                                   strCodVen,                                                     // Vendedor
                                   '',                                                            // Fornecedor
                                   edtCodCli.Text,                                                // Cliente
                                   'C',                                                           // Tipo ((C)liente / (F)ornecedor)
                                   dtaDtaEnt,                                                     // Data da Entrada
                                   hraHraEnt,                                                          // Hora da Entrada
                                   VS_Date,                                                       // Data do Documento
                                   '01000',                                                       // Condição de Pagamento
                                   strCliEst,                                                      // Estado do Cliente / Fornecedor
                                   '',                                                            // Nome do Consumidor
                                   '',                                                            // Endereço do Consumidor
                                   '',                                                            // Bairro do Consumidor
                                   '',                                                            // Cep do Consumidor
                                   '',                                                            // Cidade do Consumidor
                                   '',                                                            // Estado do Consumidor
                                   '',                                                            // Telefone do Consumidor
                                   0,
                                   '',                                                            // CNPJ / CGC
                                   '',                                                            // CNPJ / CGC do consumidor
                                   '',                                                            // Inscrição estadual do Consumidor
                                   '',                                                            // RG do consumidor
                                   0.0,                                                           // Base Simples Paulista
                                   0.0,                                                           // Base de IPI
                                   0.0,                                                           // Aliquota de IPI
                                   0.0,                                                           // Total de IPI
                                   0.0,                                                           // Base de ICMS
                                   0.0,                                                           // Aliquota de ICMS
                                   0.0,                                                           // Total de ICMS
                                   0.0,                                                           // Valor de Substituição
                                   0.0,                                                           // Aliquota de Substituição
                                   0.0,                                                           // Base de Substituição
                                   0.0,                                                           // Base de Substituição Simulada
                                   0.0,                                                           // Desconto Especial
                                   intQtdReajuste,                                                // Valor Contábil
                                   intQtdReajuste,                                                // Total dos Itens
                                   0.0,                                                           // Total de Custo
                                   0.0,                                                           // Total Médio
                                   '',                                                            // Tipo de Frete
                                   0.0,                                                           // Valor do Frete
                                   0.0,                                                           // Peso Bruto
                                   0.0,                                                           // Peso Liquido
                                   0.0,                                                           // Volume
                                   '',                                                            // Especie
                                   '',                                                            // Marca
                                   edtObse01.Text,                                                // Mensagem 1
                                   edtObse02.Text,                                                // Mensagem 2
                                   edtObsAdc.Text,                                                // Mensagem 3
                                   '',                                                            // Mensagem 4
                                   '',                                                            // Mensagem 5
                                   False,                                                         // Indica se Faturado ou nao

                                   IIF(blnAjuGra, 'AJ', EmptyStr),                                // Tipo de Faturamento
                                   IIF(blnAjuGra, strNumDocAJ, EmptyStr),                         // Numero de Faturamento
                                   IIF(blnAjuGra, VS_strCodEmp, EmptyStr),                        // Empresa dd Faturamento
                                   IIF(blnAjuGra, VS_Date, 0),                                    // Data de Faturamento
                                   IIF(blnAjuGra, strCodVen, EmptyStr),                           // Vendedor do Faturamento
                                   IIF(blnAjuGra, '01000', EmptyStr),                             // Condição de Pagamento do Faturamento
                                   False,                                                         // Devolução Especial
                                   0.0,  														                              //Valor do Faturamento
                                   0.0,                                                           // Valor Parcela 01
                                   0.0,                                                           // Valor Parcela 02
                                   0.0,                                                           // Valor Parcela 03
                                   0.0,                                                           // Valor Parcela 04
                                   0.0,                                                           // Valor Parcela 05
                                   0.0,                                                           // Valor Parcela 06
                                   0.0,                                                           // Valor Parcela 07
                                   0.0,                                                           // Valor Parcela 08
                                   0.0,                                                           // Valor Parcela 09
                                   0.0,                                                           // Valor Parcela 10
                                   0.0,                                                           // Valor Parcela 11
                                   0.0,                                                           // Valor Parcela 12
                                   arrDuplic,
                                   '',                                                            // Série
                                   'N',                                                           // Nota Especial
                                   '5999',                                                        // Classificação Fiscal 1
                                   '',                                                            // Classificação Fiscal 2
                                   '',                                                            // Classificação Fiscal 3
                                   '',                                                            // Natureza da Operação
                                   0.0,                                                           // Percentual de Desconto
                                   strCodOpe,                                                     // Codigo do Digitador
                                   '',                                                            // Codigo da Condição
                                   '',                                                            // Forma de Pagamento
                                   0.0,                                                           // Fator para meia nota
                                   recServicos,
                                   0.0,                                                           // Despesa acessoria
                                   '',                                                            // Origem do Documento (V)enda (D)evolução
                                   'N',                                                           // Usa controle de entrega
                                   '',                                                            // Representante
                                   0.0,                                                           // Aliquota do IRPF (SERVIÇO)
                                   0.0,                                                           // Valor do IRPF (SERVIÇO + PRODUTO)
                                   0.0,                                                           // Aliquota do Pis (SERVIÇO)
                                   0.0,                                                           // Valor do Pis (SERVIÇO + PRODUTO)
                                   0.0,                                                           // Aliquota do Cofins (SERVIÇO)
                                   0.0,                                                           // Valor do Cofins (SERVIÇO + PRODUTO)
                                   0.0,                                                           // Aliquota do CSLL (SERVIÇO)
                                   0.0,                                                           // Valor do CSLL (SERVIÇO + PRODUTO)
                                   0.0,                                                           // Valor de IRPF que foi retido
                                   0.0,                                                           // Valor de PIS que foi retido
                                   0.0,                                                           // Valor de COFINS que foi retido
                                   0.0,                                                           // Valor de CSLL que foi retido
                                   '',                                                            // Notas de Documentos Acumulados
                                   0.0,                                                           // Aliquota do IRPF (PRODUTOS)
                                   0.0,                                                           // Aliquota do PIS (PRODUTOS)
                                   0.0,                                                           // Aliquota do COFINS (PRODUTOS)
                                   0.0,                                                           // Aliquota do CSLL (PRODUTOS)
                                   0.0,                                                           // Valor de SERVIÇO que foi retido
                                   '',                                                            // Notas de documentos acumulados (SERVIÇO)
                                   0.0,                                                           // Percentual da Seguridade Social
                                   0.0,                                                           // Valor da Seguridade Social
                                   0.0,                                                           // Valor do IRPF Retido (Produto)
                                   0.0,                                                           // Valor do IRPF Devido (Produto)
                                   0.0,                                                           // Valor do IRPF Retido (Serviço)
                                   0.0,                                                           // Valor do IRPF Devido (Serviço)
                                   0.0,                                                           // Valor do PIS Retido (Produto)
                                   0.0,                                                           // Valor do PIS Devido (Produto)
                                   0.0,                                                           // Valor do PIS Retido (Serviço)
                                   0.0,                                                           // Valor do PIS Devido (Serviço)
                                   0.0,                                                           // Valor do COFINS Retido (Produto)
                                   0.0,                                                           // Valor do COFINS Devido (Produto)
                                   0.0,                                                           // Valor do COFINS Retido (Serviço)
                                   0.0,                                                           // Valor do COFINS Devido (Serviço)
                                   0.0,                                                           // Valor do CSLL Retido (Produto)
                                   0.0,                                                           // Valor do CSLL Devido (Produto)
                                   0.0,                                                           // Valor do CSLL Retido (Serviço)
                                   0.0,                                                           // Valor do CSLL Devido (Serviço)
                                   '',                                                            // Ordem de Produção
                                   0.0,                                                           // Base Orgão Público
                                   0.0,                                                           // ICMS Orgão Público
                                   0,                                                             // Número do Conhecimento de Frete
                                   '',                                                            // Consumidor final
                                   'N',                                                           // Entrega no Faturamento
                                   '',                                                            // Cliente de Faturamento
                                   '',                                                            // Operador da Expedição
                                   '',                                                            // Separador da Expedição
                                   '',                                                            // Tabela de Preços utilizada
                                   '',
                                   'N',                                                           // Entrega Futura
                                   FALSE,                                                         // Baixa de Entrega Futura
                                   0,                                                             // Margem de Lucro
                                   0.0,                                                           // Base do retido (caso tivesse) com ipi e frete de entrada
                                   0.0,                                                           // Valor do retido considerando a base acima.
                                   'N',                                                           // Gerar produção fora da loja
                                   '',                                                            // Numero do Registro - Correios ou Transportadora
                                   VS_Date,                                                       // Data de Entrega no Romaneio
                                   '',                                                            // Classificação fiscal 4
                                   'N',                                                           // AUTO-SERVIÇO
                                   '',                                                            // Evento
                                   '',                                                            // AUTINC ENDEREÇO DE ENTREGA
                                   '',                                                            // Conteúdo do CNFNFE
                                   '',                                                            // Motivo da Devolução
                                   '',
                                   True);                                                         // Imprime Duplicatas na NF-e

            If Result Then
              objAuditoriaSaldo.Adicionar(strAutIncTM, 'MOVGER');

            blnGerouTM := Result;
          End;

          If (blnGerouTM) Then
          Begin
            intQtdReajuste  := 0;
            fltIteSaldos    := 0;

            fltIteSalMl := qryConIte.FieldByName('ITE_SAL_ML').AsFloat;

            While FieldByName('ITE_QTDITE').AsFloat > fltIteSalMl Do
            Begin
              Inc(intQtdReajuste);

              fltIteSalMl  := fltIteSalMl + (qryConIte.FieldByName('ITE_CNV_ML').AsFloat);

              fltIteSaldos := (qryConIte.FieldByName('ITE_SALDOS').AsFloat - intQtdReajuste);
            End;

            qryConIte.Edit;
            qryConIte.FieldByName('ITE_SAL_ML').AsFloat := fltIteSalMl;
            qryConIte.FieldByName('ITE_SALDOS').AsFloat := fltIteSaldos;
            qryConIte.Post;

            strAutIncTmp := fstrEspaco(' ', 20);

            Result := Result And fGravaMovDet(strAutIncTmp,
                                   strAutIncTM,
                                   strNumDocTM,
                                   'TM',
                                   VS_strCodEmp,                                                // Empresa
                                   FieldByName('ITE_CODITE').AsString,                          // Cód. Item
                                   strCodVen,                                                   // Vendedor
                                   '',                                                          // Código Diversos
                                   FieldByName('ITE_CODMAR').AsString,                          // Código da Marca
                                   '',                                                          // Fornecedor
                                   edtCodCli.Text,                                              // Cliente
                                   dtaDtaEnt,                                                   // Data da Entrada
                                   hraHraEnt,                                                        // Hora da Entrada
                                   VS_Date,                                                     // Data do Documento
                                   '01000',                                                     // Condição de Pagamento
                                   'C',                                                         // Tipo: (C)liente / (F) Fornecedor
                                   strCliEst,                                                   // Estado do Fornecedor
                                   FieldByName('ITE_DESITE').AsString,                          // Descrição do Item
                                   FieldByName('ITE_REFERE').AsString,                          // Referência do Item
                                   FieldByName('ITE_CODUNI').AsString,                          // Cód. Unidade
                                   qryConCit.FieldByName('ITE_CODFOR').AsString,                // Fornecedor Item
                                   intQtdReajuste,
                                   0.0,
                                   0.0,
                                   0.0,
                                   0.0,
                                   0.0,
                                   0.0,
                                   0.0,
                                   0.0,                                                         // % Desconto do Item
                                   0.0,                                                         // Valor do Frete
                                   0.0,                                                         // Valor do Desconto Especial
                                   '',                                                          // Código do Representante
                                   '',                                                          // Código do Vendedor 2
                                   0.0,                                                         // Percentual de Comissão do Vendedor
                                   0.0,                                                         // Total de Comissão do Vendedor
                                   0.0,                                                         // Total de Comissão do Vendedor 2
                                   '5999',                                                   // Classificação Fiscal
                                   '',                                                          // Código Fiscal
                                   0.0,                                                         // Valor IPI
                                   0.0,                                                         // Aliquota IPI
                                   0.0,                                                         // Base IPI
                                   0.0,                                                         // Valor de ICMS
                                   0.0,                                                         // Aliquota de ICMS
                                   0.0,                                                         // Base de ICMS
                                   0.0,                                                         // Valor de Substituição
                                   0.0,                                                         // Aliquota de Substituição
                                   0.0,                                                         // Base de Substituição
                                   0.0,                                                         // Total de Peso
                                   0.0,                                                         // Percentual de Base de ICMS
                                   0.0,                                                         // Percentual de Redução de Base
                                   False,                                                       // Indica se ja esta Faturado
                                   IIF(blnAjuGra, 'AJ', EmptyStr),                              // Tipo de Faturamento
                                   IIF(blnAjuGra, strNumDocAJ, EmptyStr),                       // Numero de Faturamento
                                   IIF(blnAjuGra, VS_strCodEmp, EmptyStr),                      // Empresa dd Faturamento
                                   IIF(blnAjuGra, VS_Date, 0),                                  // Data de Faturamento
                                   IIF(blnAjuGra, strCodVen, EmptyStr),                         // Vendedor do Faturamento
                                   IIF(blnAjuGra, '01000', EmptyStr),                           // Condição de Pagamento do Faturamento
                                   0.0,  													      // Valor do Faturamento
                                   'NOR',                                                       // Identificação Produto ( Normal / Outros )
                                   qryConCit.FieldByName('ITE_INCPIS').AsString,                // Indice se incide Pis
                                   '',                                                          // Série
                                   0.0,                                                         // Valor de Despesa Acessória
                                   'N',                                                         // Nota Especial
                                   '',                                                          // Documento da Devolução
                                   '',                                                          // Espécie da Devolução
                                   '',                                                          // Empresa da Devolução
                                   '',                                                          // Item de Chamada (TINTA DE MAQUINA)
                                   '',                                                          // Item da Tinta (TINTA DE MAQUINA)
                                   '',                                                          // Descrição da Cor (TINTA DE MAQUINA)
                                   '',                                                          // Tipo de Embalagem (TINTA DE MAQUINA)
                                   0.0,                                                         // Quantidade de Embalagem (TINTA DE MAQUINA)
                                   0.0,                                                         // Preço da Embalagem (TINTA DE MAQUINA)
                                   '',                                                          // Tipo de Preço (TINTA DE MAQUINA)
                                   0.0,                                                         // Preço de Venda da Tinta (TINTA DE MAQUINA)
                                   0.0,                                                         // Preço de Compra da Tinta (TINTA DE MAQUINA)
                                   0.0,                                                         // Fator da Tinta (TINTA DE MAQUINA)
                                   '',                                                          // Produto Embalagem (TINTA DE MAQUINA)
                                   strCodOpe,                                                   // Código do Digitador
                                   '',                                                          // Codigo da Condição
                                   '',                                                          // Forma de Pagamento
                                   '',                                                          // Item da Embalagem
                                   '',                                                          // Grupo do Item da Embalagem
                                   0,                                                           // Quarto da Lazzumiz
                                   'N',                                                         // É item em promoção?
                                   '',                                                          // Tipo de Tinta
                                   0.0,                                                         // Quantidade de Pulsos
                                   '',                                                          // Número do pedido de compras
                                   '',                                                          // Origem do documento
                                   '',                                                          // Pedido de Venda - Número
                                   '',                                                          // Pedido de Venda - Espécie
                                   '',                                                          // Pedido de Venda - Empresa
                                   0,                                                           // Pedido de Venda - Sequencial
                                   '',                                                          // Ordem de Produção
                                   '',                                                          // Descrição para Nota Fiscal Especial
                                   '',
                                   0,
                                   0,
                                   0.0,                                                         // Volume a produzir (Tinta de Máquina Venda Dinâmica)
                                   '',
                                   '',
                                   False,
                                   True, //Filkar                                 '',                                                          //  Especie da Entrega Fututa
                                   '',
                                   '',
                                   '',
                                   '',
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
                                   fGetNumeroLote,
                                   'N',
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
                                   0);


          End;
        End;

        If Not Result Then
          Break;

        {*****************************************}
        {* ATUALIZA O ESTOQUE DO ITEM, DE ACORDO *}
        {* COM O TIPO DE MOVIMENTAÇÃO (E/S)      *}
        {**************************************MV*}
        If edtEspDoc.Text = 'AJ' Then
        Begin
          If blnDeveMovimentarEstoqueFisico Then
            Result := Result And fAtualizaEstoqueCadIte(FieldByName('ITE_CODITE').AsString,
                                                        FieldByName('ITE_ENTSAI').AsString,
                                                        FieldByName('ITE_QTDITE').AsFloat,
                                                        0.0,
                                                        FieldByName('ITE_NUMLOT').AsString, False);

          If (Not fEmptyStr(FieldByName('ITE_CODACA').AsString)) Then
            Result := Result And TProdAcabado.fAtualizaEstoque(FieldByName('ITE_CODACA').AsString,
                                                               FieldByName('ITE_EMPACA').AsString,
                                                               VS_strCodEmp,
                                                               FieldByName('ITE_ENTSAI').AsString,
                                                               FieldByName('ITE_QTDITE').AsFloat);

          If (Not blnDeveMovimentarEstoqueFisico) And
             (FblnAjuSaldoExterno) And
             (fCfgSis('MOVFUL') = '2') Then
          Begin
            Result := Result And objCadLot.fAtualizaEstoqueLote(FieldByName('ITE_CODITE').AsString,
                                                                FieldByName('ITE_ENTSAI').AsString,
                                                                FieldByName('ITE_NUMLOT').AsString,
                                                                FieldByName('ITE_QTDITE').AsFloat);
          End;
        End
        Else
        Begin
          If FieldByName('ITE_ENTSAI').AsString = 'E' Then
            fltQtdSalMl := -FieldByName('ITE_QTDITE').AsFloat
          Else
            fltQtdSalMl := FieldByName('ITE_QTDITE').AsFloat;

          Result := Result And fAtualizaEstoqueML(FieldByName('ITE_CODITE').AsString, fltQtdSalMl, FieldByName('ITE_NUMLOT').AsString);
        End;


        If Result And fRegraItemMarmore(FieldByName('ITE_CODITE').AsString)  Then
          pAjustaMedidasMarmore(blnVariasChapasPorLote);

        If Not Result Then
          Break;

        pgbItens.StepBy(1);
        Next;
      End;

      Result := Result And fInformarNumeroSerie(arrItensSerieEntrada, arrItensSerieSaida);
    End;

    If Result And (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
    Begin
      Result := False;
      fRollBack;
      pMostraErrosAuditoria(strCodErrosAuditoria);
    End;

    If Result Then
    Begin
      fCommit;
      edtNumDoc.Text := strNumDocAJ; // Numero Documento;
    End
    Else
      fRollBack;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[fConfirmaAjuste]');
    End;
  End;

  pgbItens.Position := 0;
  pgbItens.Visible := False;
end;

function TfrmAjusteEstoque.fConfirmaAjusteEstoqueExtPlanilha: Boolean;
var
  LConfirmaAjuste: TfrmConfirmaAjusteEstoqueExtPlanilha;
begin
  if (not FblnAjuSaldoExterno) or (not FImportacaoPlanilha) then
    Exit(True);

  if FAjuPlan.IsEmpty then
    Exit(True);

  If FItensSalNeg.Count > 0 Then
  Begin
    TfrmObservacao.fObservacao('Não é permitido confirmar o ajuste se o saldo após ajuste ficar negativo. '+
      'Revise os dados da planilha e depois tente novamente, ou remova o(s) item(ns) abaixo da planilha e '+
      'depois faça o ajuste deles manualmente:', FItensSalNeg.Text);
    Exit(False);
  End;

  pCriarFormularios(TfrmConfirmaAjusteEstoqueExtPlanilha, LConfirmaAjuste);

  try
    LConfirmaAjuste.cldsItens := FAjuPlan;
    LConfirmaAjuste.ShowModal;

    Result := (LConfirmaAjuste.ModalResult = mrOk);
  finally
    pFreeAndNil(LConfirmaAjuste);
  end;
end;

function TfrmAjusteEstoque.fControleOrigemContraPartida(Sender: TEditFocus): Boolean;
begin
  Result := pnlItemSai.FindChildControl(Sender.Name) <> nil;
end;

procedure TfrmAjusteEstoque.btnConfirmaClick(Sender: TObject);
Var intQtdImp : Integer;
begin
  inherited;
  FZerarEstItensEmpExt := False;

  If Not btnConfirma.Enabled Then
    Exit;

  If (Not cdsAjuste.Active)       Or
     (cdsAjuste.RecordCount <= 0) Then
  Begin
    If edtCodIte.Enabled Then
      pSetFocus(edtCodIte);

    Exit;
  End;

  pCalculaAjusteEstExtPlanilha;

  if (not fConfirmaAjusteEstoqueExtPlanilha) then
    Exit;

  If fMensagem('', 'Confirma gravação?', ['&Sim', '&Não']) = 1 Then
  Begin
    If (fCfgSis('LIBAJU', varBoolean)) Then
      If (Not fLiberaAjuste) Then
      Begin
        fMensagem('', 'Gravação abortada!', ['&O k']);
        Exit;
      End;

    if FImportacaoPlanilha and
      (fMensagem('Atenção', 'Deseja zerar os estoques dos itens da empresa externa informada e que não estão relacionados na planilha?', ['&Sim', '&Não'], 2) = 1) then
      FZerarEstItensEmpExt := True;

    If fConfirmaAjuste Then
    Begin
      fMensagem('', 'Gravação concluída com sucesso!', ['&O k']);

      If fMensagem('', 'Imprimir?', ['&Sim', '&Não']) = 1 Then
      Begin
        strEspDoc := '';

        If fEmptyStr(edtEspDoc.Text) Then
          strEspDoc := 'AJ'
        Else
          strEspDoc := edtEspDoc.Text;

//        pCarregaConfImpr(qryCfgRel, Self.Name);
//        fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);

        intQtdImp := 1;

        If (fCfgSis('VIA_AJ', varBoolean)) Then
          intQtdImp := fGetMenu('Qtd. Vias', ['1 Via', '2 Vias', '3 Vias', '4 Vias'], 1)
        Else If fCfgSis('QTDVAJ', varInteger) > 1 Then
          intQtdImp := fCfgSis('QTDVAJ', varInteger);

        If (Pos(strEspDoc, fCfgSis('ESP40C')) > 0) Or (fCfgSis('MODIMP') = '1') Then
          pImprimeTicketIF(edtNumDoc.Text, strEspDoc, edtCodCli.Text, intQtdImp)
        Else
          pImprime(strNumDocAJ, strEspDoc, intQtdImp);
      End;

      pLimparTela;
    End;
  End
  Else
  Begin
    If edtCodIte.Enabled Then
      pSetFocus(edtCodIte);
  End;

  pSetaTipoAjuste;

  TTestabilidade.fGetTestabilidade.NumeroDocumento  := strNumDocAJ;
end;

procedure TfrmAjusteEstoque.btnEstLojClick(Sender: TObject);
  Var
    frmFatMostraEstoqueEmp : TfrmFatMostraEstoqueEmp;
begin
  If (not cdsAjuste.Active) or (fEmptyStr(cdsAjuste.FieldByName('ITE_CODITE').AsString)) Then
    Exit;

  Try
    pCriarFormularios(TfrmFatMostraEstoqueEmp, frmFatMostraEstoqueEmp);
    With frmFatMostraEstoqueEmp, cdsAjuste Do
    Begin
      strCodIte    := FieldByName('ITE_CODITE').AsString;
      fltQtdIte    := 0;
      strTabPre    := '';
      blnPedCorte  := False;
      edtItem.Text := FieldByName('ITE_CODITE').AsString + ' - ' + fRetNomProduto(FieldByName('ITE_CODITE').AsString);
      pnlSelecEmpresa.Visible := False;

      ShowModal;
    End;


  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[pMostraEstoqueLojas]');
  End;

  pFreeAndNil(frmFatMostraEstoqueEmp);

end;

procedure TfrmAjusteEstoque.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End
  Else
  If (Key = VK_F6) Then
  Begin
    btnEstLoj.Click;
  End;

end;

procedure TfrmAjusteEstoque.btnCancelarEntradaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmAjusteEstoque.pLimparTela;
begin
  pDestravaLockAjusteFul;
  pDeletaTemporaria;

  pHabilitaCampos(pnlCabecalho, True);
  pHabilitaCampos(pnlItemContainer, False);
  btnConfirma.Enabled := False;
  dbgItens.Enabled    := False;

  pLimpaDadosItem(edtCodIte);
  if FblnAjuContrPart then
    pLimpaDadosItem(edtCodIteSai);
  edtNumDoc.Clear;
  edtCodVen.Clear;
  edtCodDig.Clear;
  edtObse01.Clear;
  edtObse02.Clear;
  edtCodOco.Clear;
  edtDesOco.Clear;
  edtHisCom.Clear;
  edtTotGer.Text := '0,00';
  edtToItem.Text := '0';

  edtNomVen.Clear;
  edtNomDig.Clear;
  pSetFocus(edtCodVen);

  edtCodEmpresa.Clear;
  edtDesEmpresa.Clear;

  lblTipMov.Visible := True;
  edtEntSai.Visible := True;
  clbTipoMovimento.Visible := True;

  FChaveLockAjusteFul := '';
  FHubMkp := '';
  pnlInfoPlan.Visible := False;
  FImportacaoPlanilha := False;
  FZerarEstItensEmpExt := False;
  FDtaPlanilha := 0;
  FHraPlanilha := 0;
  FItensPlan.Clear;
  btnImportarPlanilha.Enabled := False;

  edtObsAdc.Clear;
  edtFinAju.Clear;
  edtDesFinAju.Clear;

  pCarregaFinalidadeConfigurada;
end;

{*******************************}
{* IMPRIME RELACAO DE ITENS DO *}
{* AJUSTE DE ESTOQUE           *}
{****************************AF*}
procedure TfrmAjusteEstoque.pImprime(strNumDoc, strEspDoc: String; intQtd: Integer);
  Var
    strNomeFila: String;
    strTipImp: String;
    strNomeArquivo: String;
Begin

  pImprimeFatImp('MOVDET', strNumDoc, strEspDoc, VS_strCodEmp, edtCodCli.Text, 'C', '',
                 False, strNomeArquivo, False, strTipImp, intQtd, impComPrecoGeral, 0, False, False, True, False, strNomeFila);

end;

procedure TfrmAjusteEstoque.FormShow(Sender: TObject);
begin
  inherited;
  If Not FblnAjuSaldoExterno Then
  Begin
    pnlCabecalho.Height := pnlCabecalho.Height - 22;
    pnlOpcCod.Visible := VS_strUsaTmq = 'S';
  End
  Else
  Begin
    pnlOpcCod.Visible := False;
    Self.Caption := Self.Caption + ' Externo';
  End;

  If Not FblnAjuContrPart Then
  Begin
    btnAdicionar.Top := 76;
    btnCancelaItem.Top := 99;
  End;

  {*******************************************}
  {* AJUSTA TELA CASO USE DIGITADOR          *}

  {****************************************MV*}
  If (Not fCfgSis('USADIG', varBoolean)) Then
  Begin
    lblDigita.Enabled := False;
    edtCodDig.Enabled := False;
    edtNomDig.Enabled := False;

    lblDigita.Visible := False;
    edtCodDig.Visible := False;
    edtNomDig.Visible := False;

    pnlCabecalho.Height := pnlCabecalho.Height - edtCodDig.Height;

    lblFinalidade.Top := lblFinalidade.Top - edtCodDig.Height;
    edtFinAju.Top :=  edtFinAju.Top - edtCodDig.Height;
    edtDesFinAju.Top := edtDesFinAju.Top - edtCodDig.Height;

    lblEmpSalExt.Top := lblEmpSalExt.Top - edtCodDig.Height;
    edtCodEmpresa.Top :=  edtCodEmpresa.Top - edtCodDig.Height;
    edtDesEmpresa.Top :=  edtDesEmpresa.Top - edtCodDig.Height;

    lblObserv.Top := lblObserv.Top - edtCodDig.Height - IIf(FblnAjuSaldoExterno, 0, edtCodEmpresa.Height);
    edtObse01.Top := edtObse01.Top - edtCodDig.Height - IIf(FblnAjuSaldoExterno, 0, edtCodEmpresa.Height);
    edtObse02.Top := edtObse02.Top - edtCodDig.Height - IIf(FblnAjuSaldoExterno, 0, edtCodEmpresa.Height);
  End
  Else
  Begin
    edtCodVen.PasswordChar := #0;
    edtCodVen.MaxLength := 3;

    lblObserv.Top := lblObserv.Top - IIf(FblnAjuSaldoExterno, 0, edtCodEmpresa.height);
    edtObse01.Top := edtObse01.Top - IIf(FblnAjuSaldoExterno, 0, edtCodEmpresa.height);
    edtObse02.Top := edtObse02.Top - IIf(FblnAjuSaldoExterno, 0, edtCodEmpresa.height);
  End;

  {*******************************************}
  {* VERIFICA SE PERMITI ALTERAR O CLIENTE   *}
  {****************************************LU*}
  If fCfgSis('AJALCL') = 'S' Then
    edtCodCli.Enabled := True;

  lblNumLot.Visible    := false;
  edtNumLot.Visible    := false;
  If Assigned(FColumnNumLot) Then
    FColumnNumLot.Visible := false;

  If Not chkSubPro.Visible Then
    pnlCabecalho.Height := (pnlCabecalho.Height - chkSubPro.Height);

  pCarregaFinalidadeConfigurada;

  btnImportarPlanilha.Visible := FblnAjuSaldoExterno;
end;

procedure TfrmAjusteEstoque.pCarregaDigitador;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtCodDig.Text, True);
  With qryConOpe Do
  Begin
    strCodOpe      := FieldByName('OPE_CODOPE').AsString;
    edtNomDig.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

procedure TfrmAjusteEstoque.pCarregaFinalidadeConfigurada;
begin
  If fValidaAcessoFinAjuEstoque(fCfgSis('FINAJU', varString)) Then
  Begin
    edtFinAju.Text := fCfgSis('FINAJU', varString);
    If FblnAjuContrPart Then
    Begin
      If fCampoTabela('FAJ_ENTSAI', 'FINAJU', ['FAJ_CODIGO'], [edtFinAju.Text]) <> 'A' Then
        edtFinAju.Clear;
    End;
    If Not fEmptyStr(edtFinAju.Text) Then
      edtDesFinAju.Text := fCampoTabela('FAJ_DESCRI', 'FINAJU', ['FAJ_CODIGO'], [edtFinAju.Text]);
  End;
end;

{*******************************************}
{* PROCEDURE PARA IMPRIMIR 40C             *}
{****************************************AC*}

procedure TfrmAjusteEstoque.pImprimeTicketIF(strNumDoc, strEspDoc, strCodCli: String; intQtd: Integer);
  Var
    strNomeArquivo: String;
begin

  Try

    pImprimeFatImp('MOVDET', strNumDoc, strEspDoc, VS_strCodEmp,strCodCli,'C',
                   '', False, strNomeArquivo, False, 'I', intQtd, impSemPrecoGeral, 0, False, True);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pImprimeTicketIF]');
    End;

  End;

end;

function TfrmAjusteEstoque.fGetNumeroLote: String;
begin
  Result := '';

  If fUsaRotinaWMS Then
  Begin
    If Assigned(objCadLot) Then
      Result := objCadLot.fRetLotePrincipalTintaMaquina(qryConIte.FieldByName('ITE_CODITE').AsString, Vs_strCodEmp);
  End;
end;

function TfrmAjusteEstoque.fGetSaldoLote(strNumLot, strCodIte,
  strCodEmp: String): String;
var
  fltSalRes: Double;
begin
  fltSalRes := fRetornaSaldoDisponivel(strCodIte,
                                       False,
                                       False,
                                       strNumLot,
                                       True,
                                       strCodEmp,
                                       '',
                                       False,
                                       True,
                                       True,
                                       False,
                                       False,
                                       False,
                                       '',
                                       '',
                                       False,
                                       True);

  Result:= FloatToStr(fltSalRes);

end;

function TfrmAjusteEstoque.fGetSqlIteGer: String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  G.*, C.ITE_CNV_ML ';
  Result := Result + 'FROM ';
  Result := Result + '  ITEGER G ';
  Result := Result + ' INNER JOIN CADITE C ON C.ITE_CODITE = G.ITE_CODITE ';
  Result := Result + 'WHERE ';
  Result := Result + '  G.ITE_CODITE = :CODITE AND ';
  Result := Result + '  G.ITE_CODEMP = :CODEMP ';

end;

function TfrmAjusteEstoque.fGetStatusItem(strCodIte : String) : String;
  Var
    strSQL: String;
    qry: TUniQuery;
begin

  Try
    qry := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_ITEATI ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qry Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      Open;

      If Not IsEmpty Then
        Result := FieldByName('ITE_ITEATI').asString
      Else
        Result := 'NULL';

    End;

  Except
    Result := 'NULL';
  End;

  FreeAndNil(qry);
end;

procedure TfrmAjusteEstoque.edtEntSaiKeyPress(Sender: TObject;
  var Key: Char);
var
  strOpe: String;
begin
  inherited;
  If fEmptyStr(edtFinAju.Text) Then
    Exit;

  strOpe := UpperCase(fCampoTabela('FAJ_ENTSAI', 'FINAJU', ['FAJ_CODIGO'], [edtFinAju.Text]));
  If strOpe = 'A' Then
    strOpe := 'SE';

  If Pos(UpperCase(Key),strOpe) > 0 Then
    SelectNext(ActiveControl, True, True)
  Else
    Key := #0;
end;


procedure TfrmAjusteEstoque.edtFinAjuKeyPress(Sender: TObject; var Key: Char);
Var
    arrConsulta : TConsultasArray;
begin
  inherited;
  If fPesqFinalidadeAjuste(Self, edtFinAju, edtDesFinAju, Nil, Key, arrConsulta, True, True, FblnAjuContrPart) Then
  Begin
    If fValidaCampos(edtFinAju, True) Then
      SelectNext(ActiveControl, True, True);

    pAjustaObsAdicional;
  End;
end;

procedure TfrmAjusteEstoque.pHabilitaTipAju(blnHabilitar: Boolean; Sender: TEditFocus);
  var
    lblRefTipAju,
    lblRefSalMl: TLabel;
    lblRefDesTipAju: TColorLabel;
    edtRefTipAju,
    edtRefSalMl : TEditFocus;
begin

 if fControleOrigemContraPartida(TEditFocus(Sender)) then
 Begin
    lblRefTipAju := lblTipAjuSai;
    lblRefSalMl  := lblSalMlSai;
    lblRefDesTipAju := lblDesTipAjuSai;
    edtRefTipAju := edtTipAjuSai;
    edtRefSalMl  := edtSalMlSai;
 End
 Else
 Begin
    lblRefTipAju := lblTipAju;
    lblRefSalMl  := lblSalMl;
    lblRefDesTipAju := lblDesTipAju;
    edtRefTipAju := edtTipAju;
    edtRefSalMl  := edtSalMl;
 End;


  If blnHabilitar And (Not rdbProAca.Checked) Then
  Begin
    lblRefTipAju.Visible := True;
    edtRefTipAju.Visible := True;
    lblRefDesTipAju.Visible := True;
    lblRefSalMl.Visible := Not FblnAjuSaldoExterno;
    edtRefSalMl.Visible := Not FblnAjuSaldoExterno;
  End
  Else
  Begin
    lblRefTipAju.Visible := False;
    edtRefTipAju.Visible := False;
    lblRefDesTipAju.Visible := False;
    edtRefTipAju.Text := 'E';

    lblRefSalMl.Visible := False;
    edtRefSalMl.Visible := False;
  End;
end;

function TfrmAjusteEstoque.fPodeInserir(strTipAju: String): Boolean;
  Var
    strMsg: String;
    intRecNo: Integer;
begin
  With cdsAjuste Do
  Begin
    intRecNo := RecNo;
    DisableControls;

    If strTipAju = 'E' Then
      Filter := 'ITE_TIPAJU = ' + QuotedStr('G')
     Else
      Filter := 'ITE_TIPAJU = ' + QuotedStr('E');

    Filtered := True;

    Result := RecordCount = 0;

    Filter := '';
    Filtered := False;

    If intRecNo > -1 then
      cdsAjuste.RecNo := intRecNo;

    EnableControls;
  End;


  If Not Result Then
  Begin

    If strTipAju = 'E' Then
      strMsg := 'Não é permitido ajustar em Embalagem, pois já há produtos para ajuste em Gramas/ML selecionados.'
    Else
      strMsg := 'Não é permitido ajustar em Gramas/ML, pois já há produtos para ajuste em Embalagem selecionados.';

    fMensagem('', strMsg, ['&Ok']);

  End
  Else
  Begin
    If strTipAju = 'E' Then
    Begin
      edtEspDoc.Text := 'AJ';
      intDecQtd      := fCfgSis('DEQTAJ', varInteger);
    End
    Else
    Begin
      edtEspDoc.Text := 'ML';
      intDecQtd := 4;
    End;
  End;
end;

procedure TfrmAjusteEstoque.pTravaItemFracionadoKey(Sender: TObject; var Key: Char);
Begin

  If CharInSet(Key, [',','.','-']) Then
    Key := #0;

End;

procedure TfrmAjusteEstoque.rdbCodIteClick(Sender: TObject);
begin
  inherited;
  pnlSaldoProAca.Visible := rdbProAca.Checked;
end;

procedure TfrmAjusteEstoque.rdbProAcaClick(Sender: TObject);
begin
  inherited;
  pnlSaldoProAca.Visible := rdbProAca.Checked;

  lblNumLot.Visible    := false;
  edtNumLot.Visible    := false;
  If Assigned(FColumnNumLot) Then
    FColumnNumLot.Visible := false;


  lblNumLotSai.Visible := false;
  edtNumLotSai.Visible := false;
end;

procedure TfrmAjusteEstoque.SetblnAjuContrPart(const Value: boolean);
begin
  FblnAjuContrPart := Value;
  pnlItemSai.Visible := FblnAjuContrPart;

  blnMarmoreAtivo := fCfgSis('MARMOR', varBoolean) And (Not FblnAjuContrPart);
  If Not blnMarmoreAtivo then
  Begin
    pnlQuantidade.Top := pnlMedidasMarmore.Top;
   // pnlItemEnt.Height := pnlItemEnt.Height - pnlMedidasMarmore.Height;
    pnlMedidasMarmore.Visible := False;
  End
  Else If blnVariasChapasPorLote Then
  Begin
    lblMarBruLXA.Visible := False;
    edtLOT_MEDB_L.Visible := False;
    edtLOT_MEDB_A.Visible := False;
    lblMBLxA.Visible := False;
    lblMarliqLXA.Visible := False;
    edtLOT_MEDL_L.Visible := False;
    lblMLLxA.Visible := False;
    edtLOT_MEDL_A.Visible := False;
    lblEspessura.Visible := False;
    edtLOT_ESPESS.Visible := False;
    lblQtdChapa.Left := 38;
    edtQtdChapa.Left := 97;
    lblQtdChapa.Visible := True;
    edtQtdChapa.Visible := True;
  End;


  pnlItemContainer.Height := Iif(FblnAjuContrPart, pnlItemSai.Height + pnlItemEnt.Height, pnlItemEnt.Height) + 5;
  btnAdicionar.Top := Iif(FblnAjuContrPart, btnAdicionar.Top, btnAdicionar.Top-120);
  btnCancelaItem.Top := Iif(FblnAjuContrPart, btnCancelaItem.Top, btnCancelaItem.Top-120);
  lblItemEntrada.Caption := Iif(FblnAjuContrPart, 'Item Entrada:', 'Item:');
  edtEntSai.Enabled := not FblnAjuContrPart;
  edtEntSai.Text := Iif(FblnAjuContrPart, 'E', '');
  pnlOpcCod.Enabled := not FblnAjuContrPart;
  clbTipoMovimento.Caption := Iif(FblnAjuContrPart, '(E)ntrada', '(E)ntrada (S)aída');
end;

procedure TfrmAjusteEstoque.SetblnAjuSaldoExterno(const Value: boolean);
begin

  FblnAjuSaldoExterno    := value;
  lblDesTipAju.Visible   := Not FblnAjuSaldoExterno;
  edtTipAju.Text         := 'E';
  lblTipAju.Visible      := FblnAjuSaldoExterno;
  edtCodEmpresa.Visible  := FblnAjuSaldoExterno;
  edtDesEmpresa.Visible  := FblnAjuSaldoExterno;
  lblEmpSalExt.Visible   := FblnAjuSaldoExterno;
  pnlSaldoProAca.Visible := False;
  lblEmpSalExt.Visible   := FblnAjuSaldoExterno;
  chkSubPro.Visible      := fMostrarOpcaoDeCarregamentoDosSubProdutos;

end;

function TfrmAjusteEstoque.fGetEdt(Sender: TEditFocus): TResultEdt;
begin

  If fControleOrigemContraPartida(Sender) Then
  Begin
    Result.edtRefCodIte := edtCodIteSai;
    Result.edtRefDesIte := edtDesIteSai;
    Result.edtRefRefere := edtRefereSai;
    Result.edtRefEntSai := edtEntSaiSai;
    Result.edtRefTipAju := edtTipAjuSai;
    Result.edtRefSaldos := edtSaldosSai;
    Result.edtRefQtdIte := edtQtdIteSai;
    Result.edtRefUnitar := edtUnitarSai;
    Result.edtRefTotIte := edtTotIteSai;
    Result.edtRefNumLot := edtNumLotSai;
    Result.edtRefSal_Ml := edtSalMlSai;
    Result.edtRefSalDis := edtSaldoDisponivelSaida;
    Result.edtRefUnidad := edtUnidadeSai;
    Result.blnSaida     := True;
  End
  Else
  Begin
    Result.edtRefCodIte := edtCodIte;
    Result.edtRefDesIte := edtDesIte;
    Result.edtRefRefere := edtRefere;
    Result.edtRefEntSai := edtEntSai;
    Result.edtRefTipAju := edtTipAju;
    Result.edtRefSaldos := edtSaldos;
    Result.edtRefQtdIte := edtQtdIte;
    Result.edtRefUnitar := edtUnitar;
    Result.edtRefTotIte := edtTotIte;
    Result.edtRefNumLot := edtNumLot;
    Result.edtRefSal_Ml := edtSalMl;
    Result.edtRefSalDis := edtSaldoDisponivel;
    Result.edtRefUnidad := edtUnidade;
    Result.blnSaida     := False;
  End;

end;

function TfrmAjusteEstoque.fRetMensagemErroLimite: String;
begin
  Result := 'A quantidade de ítens ultrapassou o limite para emitir NFe que é de ' + IntToStr(intQtdMaxItens)+ ' itens!' + #$A#$D +
            'Será necessario gravar este ajuste com a quantidade de itens digitadas até aqui e fazer outro. ' + #$A#$D +
            'Há um limite na SEFAZ referente ao tamanho do arquivo enviado. Se o arquivo passa de 500 kbytes,' + #$A#$D +
            'a nota não autoriza e o painel apresenta a seguinte mensagem: "lote de nf-e maior que 500kb"';
end;

function TfrmAjusteEstoque.fRetornaSaldoItem: Double;
Var
  recSaldos,
  recSaldosML                 : TRecSaldos;
  fltSaldos, fltSaldoDispo    : double;
  objSalLoj                   : TSaldoLojas;
  sltLista                    : TStringList;
Begin
  Try
    objSalLoj := TSaldoLojas.Create(Self);
    sltLista  := TStringList.Create;

    With objSalLoj do
    Begin
      pCarregaSaldos(qryConCit.FieldByName('ITE_CODITE').AsString, VS_strCodEmp, VS_strCodEmp,
                     qryConCit.FieldByName('ITE_CNV_ML').AsFloat, False, sltLista);

      fltSaldos := qryConIte.FieldByName('ITE_SALDOS').AsFloat;

      pCalculaSaldos(nil, recSaldos, recSaldosML,
                    fltSaldos, VS_strCodEmp, VS_strCodEmp,
                    qryConCit.FieldByName('ITE_CODITE').AsString, qryConCit.FieldByName('ITE_CNV_ML').AsFloat,
                    fCfgSis('ENTFUT', varBoolean), false, fCfgSis('ORDPRO', varBoolean), fCfgSis('CALSAL', varInteger));
    End;

    fltSaldoDispo := recSaldos.fltSalDis;
  Finally
    FreeAndNil(objSalLoj);
  End;

    Result := fltSaldoDispo;
end;

function TfrmAjusteEstoque.fRetornaTabelaCusto: String;
var
  strTabAju : String;
  intTabPre : Integer;
begin

  Result := '';

  strTabAju := fCfgSis('TABAJU', varString);

  If strTabAju = 'CLIENTE' then
    Exit(fRetTabPrecoCliente(edtCodCli.Text));

  for intTabPre := 1 to 7 do
  begin
    If strTabAju = 'PRECU' + intTabPre.ToString Then
      Result := intTabPre.ToString;
  end;

end;

Function TfrmAjusteEstoque.fRetPrecoLote(strCodIte, strNumLot: String; Var fltCusLot: Double): Boolean;
  Var
    strSQL: String;
    qryCadLot: TUniQuery;
Begin
  Result := False;
  fltCusLot := 0;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  LOT_PRECUS ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADLOT ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  LOT_CODITE = :CODITE AND ';
  strSQL := strSQL + '  LOT_NUMLOT = :NUMLOT AND ';
  strSQL := strSQL + '  LOT_CODEMP = :CODEMP ';

  qryCadLot := fCriaQuery;
  With qryCadLot Do
  Begin
    SQL.Text := strSQL;

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('NUMLOT').AsString := strNumLot;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    If (Not IsEmpty) And (FieldByName('LOT_PRECUS').AsFloat > 0) Then
    Begin
      fltCusLot := FieldByName('LOT_PRECUS').AsFloat;
      Result := True;
    End;

  End;

  FreeAndNil(qryCadLot);
End;

function TfrmAjusteEstoque.fRetPrecoVendaLote(strCodIte,
  strNumLot: String): Double;
  Var
    strSQL: String;
    qryCadLot: TUniQuery;
Begin
  Result := 0;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  LOT_PREVE1 LOT_PREVEN ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADLOT ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  LOT_CODITE = :CODITE AND ';
  strSQL := strSQL + '  LOT_NUMLOT = :NUMLOT AND ';
  strSQL := strSQL + '  LOT_CODEMP = :CODEMP ';

  qryCadLot := fCriaQuery;
  With qryCadLot Do
  Begin
    SQL.Text := strSQL;

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('NUMLOT').AsString := strNumLot;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    If (Not IsEmpty) And (FieldByName('LOT_PREVEN').AsFloat > 0) Then
    Begin
      Result := FieldByName('LOT_PREVEN').AsFloat;
    End;

  End;

  FreeAndNil(qryCadLot);

end;

procedure TfrmAjusteEstoque.edtTipAjuExit(Sender: TObject);
  Var
    strSQL: String;
    fltUnitar: Double;
begin
  inherited;
  If edtTipAju.Text = 'E' Then
  Begin
    edtEspDoc.Text := 'AJ';
    intDecQtd := fCfgSis('DEQTAJ', varInteger);
  End
  Else
  Begin
    edtEspDoc.Text := 'ML';
    intDecQtd := 4;
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ITEGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '  ITE_CODEMP = :CODEMP ';

  pPesquisaCadIte(qryConCit, qryConCit, edtCodIte.Text, '', False);
  With qryConIte Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := qryConCit.FieldByName('ITE_CODITE').AsString;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

    fltUnitar := qryConIte.FieldByName(fTabPrecoImp).AsFloat;

    fltCusLot := 0;

    If SameText(strImpAju, 'TOTCUS') And fRetPrecoLote(edtCodIte.Text, edtNumLot.Text, fltCusLot) Then
      fltUnitar := fltCusLot;
  End;

  If SameText(edtTipAju.Text, 'G') Then
    edtUnitar.Text := FloatToStrF(fltUnitar / qryConCit.FieldByName('ITE_CNV_ML').AsFloat, ffFixed, 12, 4)
  Else
    edtUnitar.Text := FloatToStrF(fltUnitar, ffFixed, 12, 2);
end;

procedure TfrmAjusteEstoque.edtCodCliKeyPress(Sender: TObject;
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
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAjusteEstoque.edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqEmpresaEstoqueExterno(Self, edtCodEmpresa, edtDesEmpresa, nil, Key, arrSel) then
  begin
    fValidaCampos(edtCodEmpresa, False);
    Self.SelectNext(ActiveControl, True, True);
  End


end;

procedure TfrmAjusteEstoque.pCarregaCliente;
Begin
  edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
End;

procedure TfrmAjusteEstoque.FormPaint(Sender: TObject);
begin
  inherited;
  If blnFecharTela Then
  Begin
    Close;
  End;
end;

procedure TfrmAjusteEstoque.edtNumLotKeyPress(Sender: TObject; var Key: Char);
  var
    edtRefCodIte,
    edtRefNumLot: TEditFocus;
begin
  inherited;
  if fControleOrigemContraPartida(TEditFocus(Sender)) then
  Begin
    edtRefCodIte := edtCodIteSai;
    edtRefNumLot := edtNumLotSai;
  End
  Else
  Begin
    edtRefCodIte := edtCodIte;
    edtRefNumLot := edtNumLot;
  End;

  If objCadLot.fedtNumLotKeyPress(edtRefCodIte.Text, Sender, Key, edtRefNumLot, Self, False, True, Nil, nil, '', False, False, False, fRegraItemMarmore(edtRefCodIte.Text), Nil, '', True) Then
  Begin
    If fValidaCampos(edtRefNumLot, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

Function TfrmAjusteEstoque.fPesquisaProdutoAcabado: Boolean;
  Var
    strTabPre: String;
    blnUsaPreCus: Boolean;
    fltPreVen,
    fltSaldoReservadoProdutoAcabado,
    fltSaldoFisicoProdutoAcabado: Double;
    strIdePro: String;
    strDesCor: String;
    strTipPre: String;  // Tipo de Preço Embalagem (Diluido / Concentrado)
Begin
  Result := False;

  strIdePro := 'ACA';
  strTabPre := '1';
  blnUsaPreCus := SameText(RightStr(fTabPreco, 3), 'CUS');

  {*******************************************}
  {* ALIMENTA A VARIAVEIS USADAS NA FUNCAO   *}
  {****************************************LA*}
  dicRetorno.Limpar;
  dicRetorno['idepro']    := strIdePro;
  dicRetorno['codemp']    := VS_strCodEmp;
  dicRetorno['opcdoc']    := 'AJ';
  dicRetorno['usaprecus'] := blnUsaPreCus;
  dicRetorno['usaprecus'] := blnUsaPreCus;

  If rdbComSaldo.Checked Then
    dicRetorno['opcConsulta'] := ocaComSaldo
  Else
    dicRetorno['opcConsulta'] := ocaTodos;

  If fRetornaPreco(Self, qryTinta, qryTintaAux, dicRetorno, False, False, nil) Then
  Begin
    edtCodIte.Text     := dicRetorno['codite'];

    pCarregaItem(edtCodIte);

    strDesCor := dicRetorno['descor'];
    strTipPre := dicRetorno['tippre'];
    fltPreVen := dicRetorno['unitar'];

    If blnUsaPreCus Then
      fltPreVen := dicRetorno['precus'];

    fltSaldoFisicoProdutoAcabado := 0;
    If dicRetorno['codaca'] <> Null Then
    Begin
      strCodAca      := dicRetorno['codaca'];
      strEmpAca      := dicRetorno['empaca'];

      If TryStrToFloat(dicRetorno['saldos'], fltSaldoFisicoProdutoAcabado) Then
        edtSaldos.Text := FormatFloat(fMskDigitos(intDecQtd), dicRetorno['saldos'])
      Else
      Begin
        fltSaldoFisicoProdutoAcabado := 0;
        edtSaldos.Text := '0.000'
      End;

      fltSaldoReservadoProdutoAcabado := TSaldoReservado.New(
                                TReservaParametros.New()
                                  .EmpresaItem(VS_strCodEmp)
                                  .NumeroDocumento('')
                                  .CodigoItem(edtCodIte.Text)
                                  .CodEmpresa(VS_strCodEmp)
                                  .TipoFiltroDocumento(tfdTodos)
                                  .CodItemAcabado(strCodAca)
                                  .EmpItemAcabado(strEmpAca)
                                  .DesconsideraPedidosCorte(True)
                               ).fGetQuantidade();

      edtSaldoDisponivel.Text := FloatToStrF((fltSaldoFisicoProdutoAcabado - fltSaldoReservadoProdutoAcabado), ffFixed, 12, 3);
    End;

    strUniAca := IIF(dicRetorno['unidad'] = Null, '', dicRetorno['unidad']);

    edtUnidade.Text := fRetSiglaUni(strUniAca);

    edtUnitar.Text  := FloatToStrF(fltPreVen, ffFixed, 12, 2);
    edtRefere.Text  := fRetornaReferenciaTinta(strIdePro, qryTinta);
    edtDesIte.Text  := fRetornaDescricaoTinta(strIdePro, strDesCor, qryTinta, strTipPre);

    Result := Not fEmptyStr(fRetNomProduto(edtCodIte.Text));
  End;

End;

procedure TfrmAjusteEstoque.pSetarDireitoDeAcesso(strCodOpe: String);
begin
  If blnAjuContrPart Then
    Exit;

  If Not (fEmptyStr(edtCodIte.Text) And fEmptyStr(edtCodIteSai.Text)) Then
    Exit;
  daEntSai := [];
  edtEntSai.Text := '';
  clbTipoMovimento.Caption := '(E)ntrada (S)aída';
  edtEntSai.Enabled := True;

  If fVerificaAcessoSistema('AJUENT', strCodOpe) Then
  Begin
    daEntSai := [tdaEntrada];
    clbTipoMovimento.Caption := '(E)ntrada';
    edtEntSai.Text := 'E';
    edtEntSai.Enabled := False;
  End;

  If fVerificaAcessoSistema('AJUSAI', strCodOpe) Then
  Begin
     daEntSai := daEntSai + [tdaSaida];
    clbTipoMovimento.Caption := '(S)aída';
    edtEntSai.Text := 'S';
    edtEntSai.Enabled := False;
  End;
  If daEntSai = [tdaSaida, tdaEntrada] then
  Begin
     edtEntSai.Text := '';
     clbTipoMovimento.Caption := '(E)ntrada (S)aída';
     edtEntSai.Enabled := True;
     daEntSai := daEntSai + [tdaTodos];
  End;
end;

procedure TfrmAjusteEstoque.pCarregaOcorrencia;
begin
  pPesquisaCadOco(Nil, qryConOco, edtCodOco.Text);
  With qryConOco Do
  Begin
    edtDesOco.Text := FieldByName('OCO_DESOCO').AsString;
  End;

end;


procedure TfrmAjusteEstoque.pCarregarSubProdutos(Sender: TEditFocus; ACodItePai: String);
  const
    SQL = 'SELECT          '+
          '  D.DMT_ITESUB, '+
          '  D.DMT_QTDITE  '+
          'FROM            '+
          '  GERMAT G      '+
          '  INNER JOIN DETMAT D ON (D.DMT_SEQGER = G.AUTOINCREM) '+
          'WHERE           '+
          '  G.GMT_CODITE = :CODITE';

var
  LQryEstrutura  : TUniQuery;
  LQtdItemPai    : Double;
  LQryConCit     : TUniQuery;
  LLotExt        : String;
begin

  LQryEstrutura := fCriaQuery;
  LQryConCit    := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
  LQtdItemPai   := fStrToFloat(fGetEdt(Sender).edtRefQtdIte.Text);

  Try

    LQryEstrutura.Close;
    LQryEstrutura.SQL.Clear;
    LQryEstrutura.SQL.Add(SQL);
    LQryEstrutura.ParamByName('CODITE').AsString := ACodItePai;
    LQryEstrutura.Open;

    LQryEstrutura.First;

    While Not LQryEstrutura.Eof Do
    Begin
      fGetEdt(Sender).edtRefCodIte.Text := LQryEstrutura.FieldByName('DMT_ITESUB').AsString;
      pPesquisaCadIte(LQryConCit, LQryConCit, fGetEdt(Sender).edtRefCodIte.Text, '', False);

      fGetEdt(Sender).edtRefDesIte.Text := LQryConCit.FieldByName('ITE_DESITE').AsString;
      fGetEdt(Sender).edtRefRefere.Text := LQryConCit.FieldByName('ITE_REFERE').AsString;
      fGetEdt(Sender).edtRefQtdIte.Text := FormatFloat(fMskDigitos(intDecQtd), (LQtdItemPai * LQryEstrutura.FieldByName('DMT_QTDITE').AsFloat));
      pProcessaPrecoUnitarioETotal(Sender, LQryConCit);

      if edtLotExt.Visible then
      begin
        if objCadLot.ProdutoTemLote(LQryEstrutura.FieldByName('DMT_ITESUB').AsString) and
          (not objCadLot.ExisteLoteEstoqueExterno(LQryEstrutura.FieldByName('DMT_ITESUB').AsString, edtCodEmpresa.Text, LLotExt)) then
          objCadLot.GeraLoteEstoqueExterno(edtCodIte.Text, edtCodEmpresa.Text, LLotExt);

        fGetEdt(Sender).edtRefNumLot.Text := LLotExt;
      end;

      pAdd(Sender, LQryConCit);
      LQryEstrutura.Next;
    End;

  Finally
    FreeAndNil(LQryEstrutura);
    FreeAndNil(LQryConCit);
  End;

end;

procedure TfrmAjusteEstoque.pCarregaValoresCusto(strCodIte,
                                                 strCodEmp,
                                                 strTabPre: String);
begin

  FillChar(recCustoItem, SizeOf(recCustoItem), #0);

  If Not Assigned(objCustoItem) Then
    Exit;

  recCustoItem := objCustoItem.Get(strCodIte, strCodEmp, strTabPre);

end;

function TfrmAjusteEstoque.fRegraItemMarmore(strCodIte: String): Boolean;
begin
  Result := blnMarmoreAtivo and fItemMarmore(strCodIte)
End;

procedure TfrmAjusteEstoque.pAjustaObsAdicional;
begin
  lblObsAdc.Visible := fCampoTabela('FAJ_OBSADC', 'FINAJU', ['FAJ_CODIGO'], [edtFinAju.Text]) = 'S';
  edtObsAdc.Visible := lblObsAdc.Visible;

  If chkSubPro.Visible Then
    lblObsAdc.Top := chkSubPro.Top + 25
  Else
    lblObsAdc.Top := edtObse02.Top + 25;

  edtObsAdc.Top := lblObsAdc.Top;
end;

function TfrmAjusteEstoque.fValidaAcessoFinAjuEstoque(AStrCodAju: String): Boolean;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;

  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT                                             ');
    qryAux.SQL.Add('  COUNT(1) AS CNT                                   ');
    qryAux.SQL.Add(' FROM FINAJU F                                      ');
    qryAux.SQL.Add(' INNER JOIN DFJGPO G ON G.DFJ_SEQFAJ = F.AUTOINCREM ');
    qryAux.SQL.Add(' INNER JOIN OPEGPO P ON P.GPO_CODGPO = G.DFJ_CODGPO ');
    qryAux.SQL.Add(' WHERE TRUE                                         ');
    qryAux.SQL.Add('   AND P.OPE_CODOPE = :CODOPE                       ');
    qryAux.SQL.Add('   AND F.FAJ_CODIGO = :CODFAJ                       ');

    qryAux.ParamByName('CODFAJ').AsString := AStrCodAju;
    qryAux.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryAux.Open;

    Result := qryAux.FieldByName('CNT').AsInteger > 0;

    If Result Then
      Exit;

    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT                                             ');
    qryAux.SQL.Add('  COUNT(1) AS CNT                                   ');
    qryAux.SQL.Add(' FROM FINAJU F                                      ');
    qryAux.SQL.Add(' INNER JOIN DFJOPE O ON O.DFJ_SEQFAJ = F.AUTOINCREM ');
    qryAux.SQL.Add(' WHERE TRUE                                         ');
    qryAux.SQL.Add('   AND O.DFJ_CODOPE = :CODOPE                       ');
    qryAux.SQL.Add('   AND F.FAJ_CODIGO = :CODFAJ                       ');

    qryAux.ParamByName('CODFAJ').AsString := AStrCodAju;
    qryAux.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryAux.Open;

    Result := qryAux.FieldByName('CNT').AsInteger > 0;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmAjusteEstoque.fFindColumn(AStrFieldName: String): TColumn;
var
  I: Integer;
begin
  Result := Nil;
  For I := 0 To Pred(dbgItens.Columns.Count) Do
  Begin
    If dbgItens.Columns[I].FieldName = AStrFieldName Then
      Exit(dbgItens.Columns[I]);
  End;
end;

function TFrmAjusteEstoque.fLiberaAjuste: Boolean;
Var
  intDecQtd: Integer;
  objTabela: TRegistroMsgLiberaTabela;
  objLinha: TLinhaMsgLibera;
  objLiberacao: TLiberacao;
begin
  objLiberacao := TLiberacao.Create;
  cdsAjuste.Disablecontrols;

  Try
    intDecQtd := fCfgSis('DECQTD', varInteger);

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('AJUSTE DE ESTOQUE : Liberação para gravar Ajuste de Estoque.');
    objLiberacao.objMsgLibera.pAddSeparador(113);
    objLiberacao.objMsgLibera.pAddTexto('Vendedor          : ' + edtCodVen.Text + ' - ' + edtNomVen.Text);
    objLiberacao.objMsgLibera.pAddTexto('Data Entrada      : ' + mskDtaEnt.Text);
    objLiberacao.objMsgLibera.pAddTexto('Empresa           : ' + VS_strCodEmp);

    objLiberacao.strDirAce := 'LIBGRVAJUEST';
    objLiberacao.strMsgSen := 'AJUSTE DE ESTOQUE: Liberação para gravar Ajuste de Estoque.';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna('', 'Cód. Item'      , 10 , alEsquerda);
    objLinha.pAddColuna('', 'Descrição'      , 60, alEsquerda);
    objLinha.pAddColuna('', 'Tipo Movimento' , 15, alEsquerda);
    objLinha.pAddColuna('', 'Quantidade'     , 15, alDireita);
    objTabela.lstLinhas.Add(objLinha);

    cdsAjuste.First;
    While Not cdsAjuste.Eof Do
    Begin
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('Cód. Item' , cdsAjuste.FieldByName('ITE_CODITE').AsString, 10);
      objLinha.pAddColuna('Descrição' , cdsAjuste.FieldByName('ITE_DESITE').AsString, 60);
      objLinha.pAddColuna('Descrição' , cdsAjuste.FieldByName('ITE_ENTSAI').AsString, 15);
      objLinha.pAddColuna('Quantidade', FormatFloat(fMskDigitos(intDecQtd), cdsAjuste.FieldByName('ITE_QTDITE').AsFloat), 15, alDireita);
      objTabela.lstLinhas.Add(objLinha);
      cdsAjuste.Next;
    End;

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
    Result := objLiberacao.fLibera;
  Finally
    objLiberacao.Clear;
    cdsAjuste.EnableControls;
  End;

end;

end.