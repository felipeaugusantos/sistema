unit untRelSimplesNacional;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass, cxProgressBar,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ComCtrls, EditFocus, Vcl.Mask, MaskEditFocus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCitel, cxClasses, cxGridLevel, cxGrid, Uni, UniClientDataSet,
  System.UITypes, StrUtils, DateUtils, Math, Vcl.CheckLst,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient,
  untTypesSistema, untRelFiscResumoIcms,
  untRelFiscResumoApIcms, untFuncoesRel;

type
  TTipoTabelaSimples = (tsComercio, tsIndustria, tsServicoIII, tsServicoIV, tsServicoV, tsServicoVA, tsFaturamentoPeriodo, tsIndustriaSimples);

  TfrmRelSimplesNacional = class(TfrmPai)
    grpDadosApuracao: TGroupBox;
    pgcApuracoes: TPageControl;
    tshComercio: TTabSheet;
    tshIndustria: TTabSheet;
    tshServicosIII: TTabSheet;
    tshServicosIV: TTabSheet;
    tshServicosVA: TTabSheet;
    dtsComercio: TDataSource;
    dtsIndustria: TDataSource;
    dtsServicosIII: TDataSource;
    dtsServicosIV: TDataSource;
    dtsServicosVA: TDataSource;
    grdComercio: TcxGridCitel;
    grdComercioDados: TcxGridDBTableViewCitel;
    grdComercio_IDXFXA: TcxGridDBColumn;
    grdComercio_LIMINF: TcxGridDBColumn;
    grdComercio_LIMSUP: TcxGridDBColumn;
    grdComercio_ALIQUO: TcxGridDBColumn;
    grdComercio_ALIRPJ: TcxGridDBColumn;
    grdComercio_ALCSLL: TcxGridDBColumn;
    grdComercio_ALQCOF: TcxGridDBColumn;
    grdComercio_ALQPIS: TcxGridDBColumn;
    grdComercio_ALQCPP: TcxGridDBColumn;
    grdComercio_ALQICM: TcxGridDBColumn;
    grdComercioLvl1: TcxGridLevel;
    grdIndustria: TcxGridCitel;
    grdIndustriaDados: TcxGridDBTableViewCitel;
    grdIndustria_IDXFXA: TcxGridDBColumn;
    grdIndustria_LIMINF: TcxGridDBColumn;
    grdIndustria_LIMSUP: TcxGridDBColumn;
    grdIndustria_ALIQUO: TcxGridDBColumn;
    grdIndustria_ALIRPJ: TcxGridDBColumn;
    grdIndustria_ALCSLL: TcxGridDBColumn;
    grdIndustria_ALQCOF: TcxGridDBColumn;
    grdIndustria_ALQPIS: TcxGridDBColumn;
    grdIndustria_ALQCPP: TcxGridDBColumn;
    grdIndustria_ALQICM: TcxGridDBColumn;
    grdIndustria_ALQIPI: TcxGridDBColumn;
    grdIndustriaLvl1: TcxGridLevel;
    grdComercio_ALQTRB: TcxGridDBColumn;
    grdComercio_TOTTRB: TcxGridDBColumn;
    grdComercio_ALQRET: TcxGridDBColumn;
    grdComercio_TOTRET: TcxGridDBColumn;
    grdComercio_TOTSNC: TcxGridDBColumn;
    pnlComercio: TPanel;
    lblFatTribComercio: TLabel;
    edtFatProdTribComercio: TEditFocus;
    edtFatProdRetComercio: TEditFocus;
    lblFatRetComercio: TLabel;
    lblFatIsentoComercio: TLabel;
    edtFatProdIsentoComercio: TEditFocus;
    pnlIndustria: TPanel;
    lblFatTribIndustria: TLabel;
    lblFatRetIndustria: TLabel;
    lblFatIsentoIndustria: TLabel;
    edtFatProdTribIndustria: TEditFocus;
    edtFatProdRetIndustria: TEditFocus;
    edtFatProdIsentoIndustria: TEditFocus;
    grdIndustria_ALQTRB: TcxGridDBColumn;
    grdIndustria_TOTTRB: TcxGridDBColumn;
    grdIndustria_ALQRET: TcxGridDBColumn;
    grdIndustria_TOTRET: TcxGridDBColumn;
    grdIndustria_TOTSNC: TcxGridDBColumn;
    pnlServicosIII: TPanel;
    lblFatServServicosIIIIss: TLabel;
    edtFatServServicosIIIIss: TEditFocus;
    grdServicosIII: TcxGridCitel;
    grdServicosIIIDados: TcxGridDBTableViewCitel;
    grdServicosIII_IDXFXA: TcxGridDBColumn;
    grdServicosIII_LIMINF: TcxGridDBColumn;
    grdServicosIII_LIMSUP: TcxGridDBColumn;
    grdServicosIII_ALIQUO: TcxGridDBColumn;
    grdServicosIII_ALIRPJ: TcxGridDBColumn;
    grdServicosIII_ALCSLL: TcxGridDBColumn;
    grdServicosIII_ALQCOF: TcxGridDBColumn;
    grdServicosIII_ALQPIS: TcxGridDBColumn;
    grdServicosIII_ALQCPP: TcxGridDBColumn;
    grdServicosIII_ALQICM: TcxGridDBColumn;
    grdServicosIII_ALQISS: TcxGridDBColumn;
    grdServicosIIILvl1: TcxGridLevel;
    grdServicosIII_TOTSNC: TcxGridDBColumn;
    pnlServicosIV: TPanel;
    lblFatServServicosIVIss: TLabel;
    edtFatServServicosIVIss: TEditFocus;
    grdServicosIV: TcxGridCitel;
    grdServicosIVDados: TcxGridDBTableViewCitel;
    grdServicosIV_IDVFXA: TcxGridDBColumn;
    grdServicosIV_LIMINF: TcxGridDBColumn;
    grdServicosIV_LIMSUP: TcxGridDBColumn;
    grdServicosIV_ALIQUO: TcxGridDBColumn;
    grdServicosIV_ALIRPJ: TcxGridDBColumn;
    grdServicosIV_ALCSLL: TcxGridDBColumn;
    grdServicosIV_ALQCOF: TcxGridDBColumn;
    grdServicosIV_ALQPIS: TcxGridDBColumn;
    grdServicosIV_ALQCPP: TcxGridDBColumn;
    grdServicosIV_ALQICM: TcxGridDBColumn;
    grdServicosIV_ALQISS: TcxGridDBColumn;
    grdServicosIV_TOTSNC: TcxGridDBColumn;
    grdServicosIVLvl1: TcxGridLevel;
    grdServicosVA: TcxGridCitel;
    grdServicosVADados: TcxGridDBTableViewCitel;
    grdServicosVA_IDXFXA: TcxGridDBColumn;
    grdServicosVA_LIMINF: TcxGridDBColumn;
    grdServicosVA_LIMSUP: TcxGridDBColumn;
    grdServicosVA_ALIQUO: TcxGridDBColumn;
    grdServicosVA_ALIRPJ: TcxGridDBColumn;
    grdServicosVA_ALCSLL: TcxGridDBColumn;
    grdServicosVA_ALQCOF: TcxGridDBColumn;
    grdServicosVA_ALQPIS: TcxGridDBColumn;
    grdServicosVA_ALQCPP: TcxGridDBColumn;
    grdServicosVA_ALQICM: TcxGridDBColumn;
    grdServicosVA_ALQISS: TcxGridDBColumn;
    grdServicosVA_TOTSNC: TcxGridDBColumn;
    grdServicosVALvl1: TcxGridLevel;
    pnlServicosVA: TPanel;
    lblFatServServicosVAIss: TLabel;
    edtFatServServicosVAIss: TEditFocus;
    edtFatServServicosIIIIssRet: TEditFocus;
    lblFatServServicosIIIIssRet: TLabel;
    edtFatServServicosIVIssRet: TEditFocus;
    lblFatServServicosIVIssRet: TLabel;
    lblFatServServicosVAIssRet: TLabel;
    edtFatServServicosVAIssRet: TEditFocus;
    tshResumo: TTabSheet;
    Resumo: TPanel;
    lblTotalRecolher: TLabel;
    edtTotalRecolher: TEditFocus;
    grdResumo: TcxGridCitel;
    grdResumoDados: TcxGridDBTableViewCitel;
    grdResumo_TABELA: TcxGridDBColumn;
    grdResumo_LIMINF: TcxGridDBColumn;
    grdResumo_LIMSUP: TcxGridDBColumn;
    grdResumo_ALIQUO: TcxGridDBColumn;
    grdResumo_ALIRPJ: TcxGridDBColumn;
    grdResumo_ALCSLL: TcxGridDBColumn;
    grdResumo_ALQCOF: TcxGridDBColumn;
    grdResumo_ALQPIS: TcxGridDBColumn;
    grdResumo_ALQCPP: TcxGridDBColumn;
    grdResumo_ALQICM: TcxGridDBColumn;
    grdResumo_ALQISS: TcxGridDBColumn;
    grdResumo_TOTSNC: TcxGridDBColumn;
    grdResumoLvl1: TcxGridLevel;
    grdResumo_ALQIPI: TcxGridDBColumn;
    dtsResumo: TDataSource;
    grdResumo_TOTTRB: TcxGridDBColumn;
    grdResumo_TOTRET: TcxGridDBColumn;
    grdResumo_TOTISE: TcxGridDBColumn;
    grdResumo_TOTISS: TcxGridDBColumn;
    grdResumo_TOTISR: TcxGridDBColumn;
    grdIndustria_VLRDES: TcxGridDBColumn;
    grdResumo_VLRDES: TcxGridDBColumn;
    grdComercio_VLRDES: TcxGridDBColumn;
    grdServicosIII_VLRDES: TcxGridDBColumn;
    grdServicosVA_VLRDES: TcxGridDBColumn;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label2: TLabel;
    edtReceitaBruta: TEditFocus;
    chkCalculoManual: TCheckBox;
    lblMesAtual: TLabel;
    lblFatMesAtual: TLabel;
    lblSep2: TLabel;
    mskMesAtual: TMaskEditFocus;
    edtFatMesAtual: TEditFocus;
    btnCalcMesAtual: TBitBtnLocked;
    lblFatMeses: TLabel;
    lblSep1: TLabel;
    lblPeriodoApurado: TLabel;
    edtMeses: TEditFocus;
    edtValFatMeses: TEditFocus;
    btnCalcMeses: TBitBtnLocked;
    pnlEmpresasRaiz: TPanel;
    Label1: TLabel;
    btnVisualizarEmpresas: TBitBtnLocked;
    cdsAgruEmp: TUniClientDataSet;
    cdsAgruEmpCODEMP: TStringField;
    cdsAgruEmpCNPJ: TStringField;
    cdsAgruEmpVALOR: TFloatField;
    chklEmpresas: TCheckListBox;
    tshIndustriaSimples: TTabSheet;
    Panel4: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    edtFatProdTribIndustriaSimples: TEditFocus;
    edtFatProdRetIndustriaSimples: TEditFocus;
    grdIndustriaSimples: TcxGridCitel;
    grdIndustriaSimplesDados: TcxGridDBTableViewCitel;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxGridDBColumn7: TcxGridDBColumn;
    cxGridDBColumn8: TcxGridDBColumn;
    cxGridDBColumn9: TcxGridDBColumn;
    cxGridDBColumn10: TcxGridDBColumn;
    cxGridDBColumn11: TcxGridDBColumn;
    cxGridDBColumn12: TcxGridDBColumn;
    cxGridDBColumn13: TcxGridDBColumn;
    cxGridDBColumn14: TcxGridDBColumn;
    cxGridDBColumn15: TcxGridDBColumn;
    cxGridDBColumn16: TcxGridDBColumn;
    cxGridDBColumn17: TcxGridDBColumn;
    grdIndustriaSimplesLvl1: TcxGridLevel;
    dtsIndustriaSimples: TDataSource;
    chkCFOPBoni: TCheckBox;
    btnConfirma: TBitBtnLocked;
    btnLimparApuracao: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    lblAliqEfetiva3: TLabel;
    lblAliqEfetiva1: TLabel;
    lblAliqEfetiva2: TLabel;
    lblAliqEfetiva4: TLabel;
    lblAliqEfetiva5: TLabel;
    lblAliqEfetiva6: TLabel;
    btnImpAnexo: TBitBtnLocked;
    grdComercio_ALQIBS: TcxGridDBColumn;
    grdComercio_ALQCBS: TcxGridDBColumn;
    grdIndustria_ALQIBS: TcxGridDBColumn;
    grdIndustria_ALQCBS: TcxGridDBColumn;
    grdServicosIII_ALQCBS: TcxGridDBColumn;
    grdServicosIII_ALQIBS: TcxGridDBColumn;
    grdServicosIV_ALQCBS: TcxGridDBColumn;
    grdServicosIV_ALQIBS: TcxGridDBColumn;
    grdServicosVA_ALQCBS: TcxGridDBColumn;
    grdServicosVA_ALQIBS: TcxGridDBColumn;
    grdIndustriaSimp_ALQIBS: TcxGridDBColumn;
    grdIndustriaSimp_ALQCBS: TcxGridDBColumn;
    grdResumo_ALQIBS: TcxGridDBColumn;
    grdResumo_ALQCBS: TcxGridDBColumn;

    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtMesesExit(Sender: TObject);
    procedure btnCalcMesesClick(Sender: TObject);
    procedure edtValFatMesesExit(Sender: TObject);
    procedure btnCalcMesAtualClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure grdComercioDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdIndustriaDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdServicosIIIDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdServicosIVDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdServicosVADadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mskMesAtualEnter(Sender: TObject);
    procedure mskMesAtualExit(Sender: TObject);
    procedure chkCalculoManualClick(Sender: TObject);
    procedure btnLimparApuracaoClick(Sender: TObject);
    procedure grdResumoDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnVisualizarEmpresasClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure pgcApuracoesChange(Sender: TObject);
    procedure btnImpAnexoClick(Sender: TObject);
  private
    { Private declarations }
    fltTotRet: Currency;
    strMesAtual: String;

    cdsComercio   : TUniClientDataSet;
    cdsIndustria  : TUniClientDataSet;
    cdsIndustriaSimples  : TUniClientDataSet;
    cdsServicosIII: TUniClientDataSet;
    cdsServicosIV : TUniClientDataSet;
    cdsServicosVA : TUniClientDataSet;
    cdsResumo     : TUniClientDataSet;

    procedure pLimparComponentes;
    procedure pLimparEditsAbas;
    procedure pCalcularMesesAnteriores;
    procedure pCalcularMesAtual;
    procedure pRealizarApuracao;
    function  fCarregarDadosTabela(tsTipoTabela: TTipoTabelaSimples): Boolean;
    procedure pCriarClientDatasetFaixas(Var cdsFaixas: TUniClientDataSet);
    function  fCalcularValorVendaTribRet(tsTipoTabela: TTipoTabelaSimples): Boolean;
    function  fGetSQL(blnFiltrarCST, blnFiltrarRetISS: Boolean; tsTipoTabela: TTipoTabelaSimples; blnAgrupado: Boolean = False): String;
    function  fCalcularDataIni(strCompet: String; intMeses: Integer): TDateTime;
    function  fCalcularDataFin(strCompet: String): TDateTime;
    function  fCalcularImposto(tsTipoTabela: TTipoTabelaSimples): Boolean;
    function  fGetClientDataSet(tsTipoTabela: TTipoTabelaSimples): TUniClientDataSet;
    procedure pLimparClientsDataSet;
    procedure pAjustarComponentesCalculoManual(blnCalculoManual: Boolean);
    procedure pCriarResumoApuracao;
    procedure pCriarDataSetResumo;
    procedure pMontarDataSetResumo;
    procedure pSomarImpostosResumo;
    function fValorMaximoEnquadramentoSimples: Boolean;
    procedure pRetEmpresaMesmoGrupoESimples(var intQtdEmpresas: integer);
    function fRetEmpresaCalculo: String;
  public
    { Public declarations }
  private
    dtaApuIni,
    dtaApuFin: TDate;
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean): Boolean; override;
  end;

var
  frmRelSimplesNacional: TfrmRelSimplesNacional;

implementation

{$R *.dfm}

uses untFuncoesSimples, untFuncoes, untConstantes,
  untRelSimplesNacionalResumoEmpresa;

procedure TfrmRelSimplesNacional.btnCalcMesAtualClick(Sender: TObject);
begin
  inherited;

  fExecutarModal(pCalcularMesAtual, 'Aguarde, Calculando vendas...', '');
end;

procedure TfrmRelSimplesNacional.btnCalcMesesClick(Sender: TObject);
begin
  inherited;

  fExecutarModal(pCalcularMesesAnteriores, 'Aguarde, Calculando vendas...', '');


end;

procedure TfrmRelSimplesNacional.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  fExecutarModal(pRealizarApuracao, 'Aguarde, Realizando apuração dos impostos...', '');
end;

procedure TfrmRelSimplesNacional.btnImpAnexoClick(Sender: TObject);
var
  intChave: Integer;
  fltFatProdTrib, fltFatProdRet, fltFatProdIsento: Double;
  fltFatServIss, fltFatServIssRet: Double;
  fltTotalRecolher: Double;
  qrySetaVariaveis: TUniQuery;
  strTabela: string;
begin
  inherited;

  intChave := 0;

  fltFatProdTrib   := 0;
  fltFatProdRet    := 0;
  fltFatProdIsento := 0;
  fltFatServIss    := 0;
  fltFatServIssRet := 0;
  fltTotalRecolher := 0;
  strTabela := '';

  Case (btnImpAnexo.Tag) Of
    518 :
      Begin
        intChave := 34707;
        fltFatProdTrib   := StrToFloatDef(AnsiReplaceStr(edtFatProdTribComercio.Text, '.', ''), 0);
        fltFatProdRet    := StrToFloatDef(AnsiReplaceStr(edtFatProdRetComercio.Text, '.', ''), 0);
        fltFatProdIsento := StrToFloatDef(AnsiReplaceStr(edtFatProdIsentoComercio.Text, '.', ''), 0);
        strTabela := 'TMP_RSN_518';
        pGerandoTemporariaAtravesDataSet(strTabela, cdsComercio);
      End;
    519 :
      Begin
        intChave := 34708;
        fltFatProdTrib   := StrToFloatDef(AnsiReplaceStr(edtFatProdTribIndustria.Text, '.', ''), 0);
        fltFatProdRet    := StrToFloatDef(AnsiReplaceStr(edtFatProdRetIndustria.Text, '.', ''), 0);
        fltFatProdIsento := StrToFloatDef(AnsiReplaceStr(edtFatProdIsentoIndustria.Text, '.', ''), 0);
        strTabela := 'TMP_RSN_519';
        pGerandoTemporariaAtravesDataSet(strTabela, cdsIndustria);
      End;
    520 :
      Begin
        intChave := 34709;
        fltFatServIss    := StrToFloatDef(AnsiReplaceStr(edtFatServServicosIIIIss.Text, '.', ''), 0);
        fltFatServIssRet := StrToFloatDef(AnsiReplaceStr(edtFatServServicosIIIIssRet.Text, '.', ''), 0);
        strTabela := 'TMP_RSN_520';
        pGerandoTemporariaAtravesDataSet(strTabela, cdsServicosIII);
      End;
    521 :
      Begin
        intChave := 34710;
        fltFatServIss    := StrToFloatDef(AnsiReplaceStr(edtFatServServicosIVIss.Text, '.', ''), 0);
        fltFatServIssRet := StrToFloatDef(AnsiReplaceStr(edtFatServServicosIVIssRet.Text, '.', ''), 0);
        strTabela := 'TMP_RSN_521';
        pGerandoTemporariaAtravesDataSet(strTabela, cdsServicosIV);
      End;
    522 :
      Begin
        intChave := 34711;
        fltFatServIss    := StrToFloatDef(AnsiReplaceStr(edtFatServServicosVAIss.Text, '.', ''), 0);
        fltFatServIssRet := StrToFloatDef(AnsiReplaceStr(edtFatServServicosVAIssRet.Text, '.', ''), 0);
        strTabela := 'TMP_RSN_522';
        pGerandoTemporariaAtravesDataSet(strTabela, cdsServicosVA);
      End;
    523 :
      Begin
        intChave := 34712;
        fltTotalRecolher := StrToFloatDef(AnsiReplaceStr(edtTotalRecolher.Text, '.', ''), 0);
        strTabela := 'TMP_RSN_523';
        pGerandoTemporariaAtravesDataSet(strTabela, cdsResumo);
      End;
  End;

  qrySetaVariaveis := fCriaQuery;
  Try
    qrySetaVariaveis.SQL.Clear;
    qrySetaVariaveis.SQL.Add('SET @FATPRODTRIB   = :FATPRODTRIB;');
    qrySetaVariaveis.SQL.Add('SET @FATPRODRET    = :FATPRODRET;');
    qrySetaVariaveis.SQL.Add('SET @FATPRODISENTO = :FATPRODISENTO;');
    qrySetaVariaveis.SQL.Add('SET @FATSERVISS    = :FATSERVISS;');
    qrySetaVariaveis.SQL.Add('SET @FATSERVISSRET = :FATSERVISSRET;');
    qrySetaVariaveis.SQL.Add('SET @TOTALRECOLHER = :TOTALRECOLHER;');
    qrySetaVariaveis.SQL.Add('SET @VALFATMESES   = :VALFATMESES;');
    qrySetaVariaveis.SQL.Add('SET @FATMESATUAL   = :FATMESATUAL;');
    qrySetaVariaveis.SQL.Add('SET @RECEITABRUTA  = :RECEITABRUTA;');
    qrySetaVariaveis.SQL.Add('SET @MESES         = :MESES;');
    qrySetaVariaveis.SQL.Add('SET @MESATUAL      = :MESATUAL;');

    qrySetaVariaveis.ParamByName('FATPRODTRIB').AsFloat   := fltFatProdTrib;
    qrySetaVariaveis.ParamByName('FATPRODRET').AsFloat    := fltFatProdRet;
    qrySetaVariaveis.ParamByName('FATPRODISENTO').AsFloat := fltFatProdIsento;
    qrySetaVariaveis.ParamByName('FATSERVISS').AsFloat    := fltFatServIss;
    qrySetaVariaveis.ParamByName('FATSERVISSRET').AsFloat := fltFatServIssRet;
    qrySetaVariaveis.ParamByName('TOTALRECOLHER').AsFloat := fltTotalRecolher;
    qrySetaVariaveis.ParamByName('VALFATMESES').AsFloat   := StrToFloatDef(AnsiReplaceStr(edtValFatMeses.Text, '.', ''), 0);
    qrySetaVariaveis.ParamByName('FATMESATUAL').AsFloat   := StrToFloatDef(AnsiReplaceStr(edtFatMesAtual.Text, '.', ''), 0);
    qrySetaVariaveis.ParamByName('RECEITABRUTA').AsFloat  := StrToFloatDef(AnsiReplaceStr(edtReceitaBruta.Text, '.', ''), 0);
    qrySetaVariaveis.ParamByName('MESES').AsString        := edtMeses.Text;
    qrySetaVariaveis.ParamByName('MESATUAL').AsString     := mskMesAtual.Text;

    qrySetaVariaveis.ExecSQL;
  Finally
    freeAndNil(qrySetaVariaveis);
  End;

  If Assigned(prcExecutaRelatorio) Then
    prcExecutaRelatorio(btnImpAnexo.Tag, intChave, [], [], [], nil, nil, True);
end;

procedure TfrmRelSimplesNacional.btnImprimirClick(Sender: TObject);
begin
  inherited;
  pCriarForm(TfrmRelFiscResumoApIcms);
end;

procedure TfrmRelSimplesNacional.btnLimparApuracaoClick(Sender: TObject);
begin
  inherited;

  pLimparComponentes();
  pLimparClientsDataSet();

  pSetFocus(edtMeses);

  tshResumo.TabVisible := False;

  tshComercio.Show();
end;

procedure TfrmRelSimplesNacional.btnVisualizarEmpresasClick(Sender: TObject);
begin
  inherited;
  TfrmRelSimplesNacionalResumoEmpresa.pCallResumo(cdsAgruEmp, edtMeses.Text);
end;

procedure TfrmRelSimplesNacional.chkCalculoManualClick(Sender: TObject);
begin
  inherited;

  pAjustarComponentesCalculoManual(chkCalculoManual.Checked);
end;

procedure TfrmRelSimplesNacional.edtMesesExit(Sender: TObject);
begin
  inherited;

  If (fEmptyStr(TEditFocus(Sender).Text)) Then
    TEditFocus(Sender).Text := '0';
end;

procedure TfrmRelSimplesNacional.edtValFatMesesExit(Sender: TObject);
begin
  inherited;

  If (fEmptyStr(TEditFocus(Sender).Text)) Then
    TEditFocus(Sender).Text := '0,00';
end;

function TfrmRelSimplesNacional.fCalcularDataFin(strCompet: String): TDateTime;
  Var
    intMes, intAno: Integer;
begin
  intMes := StrToInt(Copy(strCompet, 1, 2));
  intAno := StrToInt(Copy(strCompet, 4, 4));

  If (intMes = 1) Then Begin
    intAno := intAno - 1;
    intMes := 12;
  End Else Begin
    intMes := intMes - 1;
  End;

  Result := Trunc(EndOfAMonth(intAno, intMes));
end;

function TfrmRelSimplesNacional.fCalcularDataIni(strCompet: String; intMeses: Integer): TDateTime;
  Var
    i, intMes, intAno: Integer;
begin
  intMes := StrToInt(Copy(strCompet, 1, 2));
  intAno := StrToInt(Copy(strCompet, 4, 4));

  For i := 1 To intMeses Do Begin
    If (intMes = 1) Then Begin
      intAno := intAno - 1;
      intMes := 12;
    End Else Begin
      intMes := intMes - 1;
    End;
  End;

  Result := EncodeDate(intAno, intMes, 1);
end;

function TfrmRelSimplesNacional.fGetClientDataSet(tsTipoTabela: TTipoTabelaSimples): TUniClientDataSet;
begin
  Case (tsTipoTabela) Of
    tsComercio  : Result := cdsComercio;
    tsIndustria : Result := cdsIndustria;
    tsIndustriaSimples : Result := cdsIndustriaSimples;
    tsServicoIII: Result := cdsServicosIII;
    tsServicoIV : Result := cdsServicosIV;
    tsServicoVA : Result := cdsServicosVA;
    Else Result := nil;
  End;
end;

function TfrmRelSimplesNacional.fGetSQL(blnFiltrarCST, blnFiltrarRetISS: Boolean; tsTipoTabela: TTipoTabelaSimples; blnAgrupado: Boolean = False): String;
  Var
    strSQL, strTemp: String;
    strEmpresasCalculo: String;


  function fTabIdeSer: String;
    Var i: Integer;
  begin
    Result := '';

    For i := 1 To 30 Do Begin
      Result := Result + ' SELECT ' + FormatFloat('#', i) + ' AS IDESER ';

      If (i <> 30) Then
        Result := Result + 'UNION ';
    End;
  end;

  function fCaseIdeSer: String;
    Var i: Integer;
  begin
    Result := ' CASE ';

    For i := 1 To 30 Do Begin
      Result := Result + ' WHEN IDESER = "' + FormatFloat('##00', i) + '" THEN GER_CODS' +
        FormatFloat('##00', i) + ' ';

      If (i = 30) Then
        Result := Result + ' END ';
    End;
  end;

  function fCaseValSer: String;
    Var i: Integer;
  begin
    Result := ' CAST(IF(CASE ';

    For i := 1 To 30 Do Begin
      Result := Result + ' WHEN IDESER = "' + FormatFloat('##00', i) + '" THEN GER_IDES' +
        FormatFloat('##00', i) + ' ';

      If (i = 30) Then
        Result := Result + ' END = "I", 0.00, CASE ';
    End;

    For i := 1 To 30 Do Begin
      Result := Result + ' WHEN IDESER = "' + FormatFloat('##00', i) + '" THEN GER_VALS' +
        FormatFloat('##00', i) + ' * (1 - (GER_DECS' + FormatFloat('##00', i) + ' / 100)) ';

      If (i = 30) Then
        Result := Result + ' END) AS DECIMAL(12,2)) ';
    End;
  end;

begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CAST(DATE_FORMAT(DET_DTAENT, "%m/%Y") AS CHAR(15)) AS DTAENT, ';
  strSQL := strSQL + '  DET_DTAENT AS DTAENT_ORDEM, ';
  strSQL := strSQL + '  CONCAT(DET_NUMDOC,DET_ESPDOC,DET_CODEMP,DET_CODCLI,IFNULL(DET_SERIE_,"")) AS CHAVEDOC, ';
  strSQL := strSQL + ' DET_CODEMP AS CODEMP, ';
  strSQL := strSQL + ' EMP_C_G_C_, ';

  If (tsTipoTabela in [tsServicoIII, tsServicoIV, tsServicoVA]) Then Begin
    strSQL := strSQL + fCaseValSer + ' AS TOTAL_VENDA, ';
  End Else Begin
    If fCfgSis('IMRSIM', varString) = '1' Then
      strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) < 5, -1, 1) * (DET_TOTITE-DET_DESESP-DET_DESCFF) AS TOTAL_VENDA, '
    Else If fCfgSis('IMRSIM', varString) = '2' Then
      strSQL := strSQL + '  IF(LEFT(DET_CLAFIS, 1) < 5, - 1, 1) * (DET_VLRCON) AS TOTAL_VENDA, '
    Else If fCfgSis('IMRSIM', varString) = '3' Then
      strSQL := strSQL + '  IF(LEFT(DET_CLAFIS, 1) < 5, - 1, 1) * (DET_TOTITE + DET_TOTFRE + DET_DESACE - DET_DESESP) AS TOTAL_VENDA, '
    Else If fCfgSis('IMRSIM', varString) = '4' Then
      strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) < 5, -1, 1) * (DET_TOTITE-DET_DESESP-DET_DESCFF+DET_TOTFRE) AS TOTAL_VENDA, ';
  End;

  strSQL := strSQL + '  IF(DET_ESPDOC = "MI" AND DET_JAFATU = 0    AND LEFT(DET_CLAFIS,1) >= 5, ';
  strSQL := strSQL + '      DET_TOTITE - DET_DESESP - DET_DESCFF, 0) AS MIA, ';
  strSQL := strSQL + '  IF(DET_ESPDOC = "FF" AND DET_JAFATU = 0    AND LEFT(DET_CLAFIS,1) >= 5, ';
  strSQL := strSQL + '      DET_TOTITE - DET_DESESP - DET_DESCFF, 0) AS FFN, ';
  strSQL := strSQL + '  IF(DET_ESPDOC IN ("FF","MI") AND DET_JAFATU = 1    AND LEFT(DET_CLAFIS,1) >= 5, ';
  strSQL := strSQL + '      DET_TOTITE - DET_DESESP - DET_DESCFF, 0) AS MIFFC, ';
  strSQL := strSQL + '  IF(DET_ESPDOC = "TR" OR  DET_ESPDOC = "DV" OR  LEFT(DET_CLAFIS,1) < 5 , ';
  strSQL := strSQL + '      IF(LEFT(DET_CLAFIS,1) >= 5, DET_TOTITE - DET_DESESP - DET_DESCFF, -(DET_TOTITE - DET_DESESP - DET_DESCFF)), 0) AS TR, ';
  strSQL := strSQL + '  IF(DET_ESPDOC = "FF"                       AND LEFT(DET_CLAFIS,1) >= 5, ';
  strSQL := strSQL + '      DET_TOTITE - DET_DESESP - DET_DESCFF, 0) AS FF, ';

  If fCfgSis('ENTBRF', varBoolean) Then Begin
    strSQL := strSQL + '  IF(((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) AND LEFT(DET_CLAFIS,1) >= 5, ';
    strSQL := strSQL + '     DET_TOTITE - DET_DESESP - DET_DESCFF, 0) AS BR, ';
  End Else
    strSQL := strSQL + '  0 AS BR, ';

  strSQL := strSQL + '  IF(DET_ESPDOC = "MI"                                    AND LEFT(DET_CLAFIS,1) >= 5,   ';
  strSQL := strSQL + '      DET_TOTITE - DET_DESESP - DET_DESCFF, 0) AS MI,   ';
  strSQL := strSQL + '  IF((DET_ESPDOC IN ("NV", "NF", "EL", "IF", "IV", "D1", "NS"))                             AND LEFT(DET_CLAFIS,1) >= 5 AND LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') = 0,    ';
  strSQL := strSQL + '      DET_TOTITE - DET_DESESP - DET_DESCFF, 0) AS NFIF, ';
  strSQL := strSQL + '  IF((DET_ESPDOC IN ("NV", "NF", "EL", "NS")) AND LEFT(DET_CONPAG,5) <> "01000" AND LEFT(DET_CLAFIS,1) >= 5 AND LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') = 0,    ';
  strSQL := strSQL + '      DET_TOTITE - DET_DESESP - DET_DESCFF, 0) AS NFN,  ';
  strSQL := strSQL + '  IF((DET_ESPDOC IN ("NV", "NF", "EL", "NS")) AND LEFT(DET_CONPAG,5) = "01000"  AND LEFT(DET_CLAFIS,1) >= 5 AND LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') = 0,    ';
  strSQL := strSQL + '      DET_TOTITE - DET_DESESP - DET_DESCFF, 0) AS NFC,  ';
  strSQL := strSQL + '  IF(DET_ESPDOC IN ("IF", "IV")                              AND LEFT(DET_CLAFIS,1) >= 5,   ';
  strSQL := strSQL + '      DET_TOTITE - DET_DESESP - DET_DESCFF, 0) AS IF_,  ';
  strSQL := strSQL + '  0.00 AS MARGEM, ';
  strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) >= 5, DET_TOTITE-DET_DESESP-DET_DESCFF, ';
  strSQL := strSQL + '      -(DET_TOTITE - DET_DESESP - DET_DESCFF) )) AS TOTALG,';
  strSQL := strSQL + '  DET_VALRET AS TOTRET     ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET D ';
  strSQL := strSQL + '  INNER JOIN CADCLI ON DET_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  INNER JOIN CADEMP ON EMP_CODEMP = DET_CODEMP';
  strSQL := strSQL + '   LEFT JOIN CADITE ON DET_CODITE = ITE_CODITE ';
  strSQL := strSQL + '   LEFT JOIN CADOPE ON DET_CODVEN = OPE_CODOPE ';
  strSQL := strSQL + '   LEFT JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';

  If (tsTipoTabela in [tsServicoIII, tsServicoIV, tsServicoVA]) Then Begin
    strSQL := strSQL + ' INNER JOIN MOVGER G ON G.AUTOINCREM = D.DET_SEQGER ';
    strSQL := strSQL + ' INNER JOIN SERMOV S ON S.GER_SEQGER = G.AUTOINCREM ';
    strSQL := strSQL + ' INNER JOIN AUXMOV   ON AUXMOV.AUX_SEQGER = G.AUTOINCREM ';
    strSQL := strSQL + ' INNER JOIN (' + fTabIdeSer + ') T ON TRUE  ';
    strSQL := strSQL + ' INNER JOIN CADSER ON SER_CODSER = ' + fCaseIdeSer;
  End;

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
  strSQL := strSQL + '  DET_PROEMB <> "S" AND ';
  strSQL := strSQL + '  DET_TIP_FC = "C"  AND ';

  if not chkCFOPBoni.Checked then
    strSQL := strSQL + '  DET_CLAFIS NOT IN ("5910","5910") AND ';

  If (tsTipoTabela in [tsComercio, tsFaturamentoPeriodo]) Then Begin
    strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLAVEN) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)';

    If fCfgSis('ENTBRF', varBoolean) Then
      strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
    Else
      strSQL := strSQL + ') ';

    If (tsTipoTabela <> tsFaturamentoPeriodo) Then Begin
      strSQL := strSQL + '  AND (NOT LOCATE(DET_CLAFIS, :CLAIND) > 0)';
      strSQL := strSQL + '  AND (NOT LOCATE(DET_CLAFIS, :CLASER) > 0)';
    End;
  End Else If (tsTipoTabela = tsIndustria) or (tsTipoTabela = tsIndustriaSimples) Then
    strSQL := strSQL + '  (LOCATE(DET_CLAFIS,  :CLAIND) > 0)'
  Else
    strSQL := strSQL + '  (LOCATE(DET_CLAFIS,  :CLASER) > 0)';

  If (tsTipoTabela in [tsServicoIII, tsServicoIV, tsServicoVA]) Then Begin
    strSQL := strSQL + '  AND SER_TIPTAB = :TIPTAB ';
  End;

  strEmpresasCalculo := fRetEmpresaCalculo;
  strSQL := strSQL + '  AND DET_CODEMP IN('+strEmpresasCalculo+')';

  strSQL := strSQL + '  AND DET_ESPDOC IN ("NF", "NV", "IF", "IV", "NS") ';

  If (blnFiltrarCST) And (tsTipoTabela in [tsComercio, tsIndustria, tsIndustriaSimples]) Then Begin
    strSQL := strSQL + '  AND LOCATE(DET_CODFIS, :CODFIS) > 0 ';
  End;

  If (tsTipoTabela in [tsServicoIII, tsServicoIV, tsServicoVA]) Then Begin
    If (blnFiltrarRetISS) Then
      strSQL := strSQL + '  AND IFNULL(AUX_RETISS, "N") = "S" '
    Else
      strSQL := strSQL + '  AND IFNULL(AUX_RETISS, "N") = "N" ';
  End;

  strTemp := AnsiReplaceStr(strSQL,  'MOVGER','NOTGER');
  strTemp := AnsiReplaceStr(strTemp, 'MOVDET','NOTDET');
  strTemp := AnsiReplaceStr(strTemp, 'AUXMOV','AUXNOT');
  strTemp := AnsiReplaceStr(strTemp, 'MOVTRI','NOTTRI');
  strTemp := AnsiReplaceStr(strTemp, 'SERMOV','SERNOT');

  Result := strSQL + ' UNION ALL ' + strTemp + ' ORDER BY DTAENT_ORDEM DESC ';

  If blnAgrupado Then
    Result := 'SELECT SUM(TOTAL_VENDA) AS TOTAL_VENDA, SUM(TOTRET) TOTRET, CODEMP, EMP_C_G_C_ FROM (' + Result + ' ) AS TMP GROUP BY CODEMP';



end;

procedure TfrmRelSimplesNacional.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (Assigned(cdsComercio))    Then FreeAndNil(cdsComercio);
  If (Assigned(cdsIndustria))   Then FreeAndNil(cdsIndustria);
  If (Assigned(cdsIndustriaSimples))   Then FreeAndNil(cdsIndustriaSimples);
  If (Assigned(cdsServicosIII)) Then FreeAndNil(cdsServicosIII);
  If (Assigned(cdsServicosIV))  Then FreeAndNil(cdsServicosIV);
  If (Assigned(cdsServicosVA))  Then FreeAndNil(cdsServicosVA);
  If (Assigned(cdsResumo))      Then FreeAndNil(cdsResumo);
end;

procedure TfrmRelSimplesNacional.FormCreate(Sender: TObject);
begin
  inherited;

  pLimparComponentes();

  cdsComercio   := nil;
  cdsIndustria  := nil;
  cdsIndustriaSimples := nil;

  cdsServicosIII:= nil;
  cdsServicosIV := nil;
  cdsServicosVA := nil;
  cdsResumo     := nil;

  tshIndustriaSimples.TabVisible := (fCfgSis('CONIPI') = 'S') And (fRegimeSubstituicaoTributaria = '2');

end;

procedure TfrmRelSimplesNacional.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F5) And (btnCalcMeses.Enabled)    Then btnCalcMeses.Click();
  If (Key = VK_F6) And (btnCalcMesAtual.Enabled) Then btnCalcMesAtual.Click();
  If (Key = VK_F10)    Then btnConfirma.Click();
  If (Key = VK_F11)    Then btnLimparApuracao.Click();
  If (Key = VK_ESCAPE) Then btnSair.Click();
end;

procedure TfrmRelSimplesNacional.FormShow(Sender: TObject);
  var intQtd: integer;
begin
  inherited;
  grpDadosApuracao.Height := 157;
  pnlEmpresasRaiz.Visible := False;

  pSetFocus(edtMeses);

  tshServicosIII.TabVisible := fCfgSis('USASER', varBoolean);
  tshServicosIV.TabVisible  := tshServicosIII.TabVisible;
  tshServicosVA.TabVisible  := tshServicosIII.TabVisible;

  tshResumo.TabVisible := False;
  pRetEmpresaMesmoGrupoESimples(intQtd);
  pAjustarComponentesCalculoManual(chkCalculoManual.Checked);

  If intQtd > 1 Then
  begin
    pnlEmpresasRaiz.Visible := True;
    grpDadosApuracao.Height := 219;
  End
  Else
  Begin
    grpDadosApuracao.Height := 157;
    pnlEmpresasRaiz.Visible := False;
  End;
  tshComercio.Show();

end;

procedure TfrmRelSimplesNacional.pRetEmpresaMesmoGrupoESimples(var intQtdEmpresas: integer);
var qryConsulta: TUniQuery;
begin
   intQtdEmpresas := 0;
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD FROM CADEMP F');
    qryConsulta.SQL.Add('INNER JOIN CFGSIS ON SIS_CODCFG = "CFG_SIMPAU" AND SIS_CODEMP = F.EMP_CODEMP AND SIS_VALCFG = "S"');
    qryConsulta.SQL.Add('WHERE LEFT(F.EMP_C_G_C_, 8) = (SELECT LEFT(EMP_C_G_C_, 8) FROM CADEMP M');
    qryConsulta.SQL.Add('        INNER JOIN CFGSIS ON SIS_CODCFG = "CFG_SIMPAU" AND SIS_CODEMP = M.EMP_CODEMP AND SIS_VALCFG = "S"');
    qryConsulta.SQL.Add('        WHERE M.EMP_CODEMP = "'+VS_StrCodEmp+'")');
    qryConsulta.Open;

    If qryConsulta.FieldByName('QTD').AsInteger = 0 Then
      Exit;

    intQtdEmpresas := qryConsulta.FieldByName('QTD').AsInteger;
    qryConsulta.sql.Clear;
    qryConsulta.SQL.Add('SELECT CONCAT(EMP_CODEMP,"-", EMP_NOMEMP) AS EMPRESA FROM CADEMP F');
    qryConsulta.SQL.Add('INNER JOIN CFGSIS ON SIS_CODCFG = "CFG_SIMPAU" AND SIS_CODEMP = F.EMP_CODEMP AND SIS_VALCFG = "S"');
    qryConsulta.SQL.Add('WHERE LEFT(F.EMP_C_G_C_, 8) = (SELECT LEFT(EMP_C_G_C_, 8) FROM CADEMP M');
    qryConsulta.SQL.Add('                                 INNER JOIN CFGSIS ON SIS_CODCFG = "CFG_SIMPAU" AND SIS_CODEMP = M.EMP_CODEMP AND SIS_VALCFG = "S"');
    qryConsulta.SQL.Add('                                 WHERE M.EMP_CODEMP = "'+VS_StrCodEmp+'")');
    qryConsulta.SQL.Add(' ORDER BY EMP_CODEMP ');

    qryConsulta.Open;

    chklEmpresas.Clear;
    while not qryConsulta.Eof do
    Begin
      chklEmpresas.AddItem(qryConsulta.FieldByName('EMPRESA').AsString, nil);
      qryConsulta.Next;
    End


  Finally
    freeAndNil(qryConsulta);
  End;
end;

function TfrmRelSimplesNacional.fRetEmpresaCalculo: String;
var i: integer;
begin
 result := '';
 for I := 0 to chklEmpresas.Count -1 do
   If chklEmpresas.Checked[i] then
     result := result +  '"' + Copy(chklEmpresas.Items[i], 1 , 3) + '"';
 If Result <> '' Then
   result := AnsiReplaceStr(result, '""', '","');
 If Result = '' Then
   Result := '"'+VS_StrCodEmp+'"';

End;

function TfrmRelSimplesNacional.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    intQtdMesesAnt: Integer;
    fltMediaFat: Double;
    fltTotalFat: Double;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then Begin

    If (Sender = edtMeses) Then Begin
      If (StrToInt(edtMeses.Text) < 1) Or (StrToInt(edtMeses.Text) > 12) Then Begin
        fMensagem('ATENÇÃO!', 'A quantidade de meses anteriores deve estar no intervalo entre 1 e 12!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = mskMesAtual) Then Begin
      If (mskMesAtual.Text = '  /    ') Then Begin
        fMensagem('ATENÇÃO!', 'O mês de apuração deve ser informado!', ['&OK']);
        Result := False;
      End Else If (Length(fTiraCaracEspeciais(Trim(mskMesAtual.Text))) <> 6) Then Begin
        fMensagem('ATENÇÃO!', 'O ano do mês de apuração deve ser informado com 4 dígitos!', ['&OK']);
        Result := False;
      End Else If (fEmptyStr(Copy(fTiraCaracEspeciais(Trim(mskMesAtual.Text)), 1, 2))) Or (StrToInt(Copy(mskMesAtual.Text, 1, 2)) < 1) Or (StrToInt(Copy(mskMesAtual.Text, 1, 2)) > 12) Then Begin
        fMensagem('ATENÇÃO!', 'O mês de apuração deve ser informado corretamente!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtValFatMeses) Or
            (Sender = edtFatMesAtual) Or (Sender = edtReceitaBruta) Then Begin
      intQtdMesesAnt := StrToInt(edtMeses.Text);

      fltTotalFat := fStrToFloat(edtValFatMeses.Text);

      If (intQtdMesesAnt <> 12) And (intQtdMesesAnt > 0) Then Begin
        fltMediaFat := fltTotalFat / intQtdMesesAnt;
        fltTotalFat := fltMediaFat * 12;
      End;

      edtReceitaBruta.Text := FormatFloat('#,##0.00', fltTotalFat);

      If (fltTotalFat < 0) Then
        edtReceitaBruta.Text := FormatFloat('#,##0.00', 0)
      Else
        edtReceitaBruta.Text := FormatFloat('#,##0.00', fltTotalFat);
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmRelSimplesNacional.fValorMaximoEnquadramentoSimples: Boolean;
  Var
    qryTemp: TUniQuery;
    fltReceitaBruta, fltMaxFaixasSimples: Double;
begin
  Result := True;

  Try
    qryTemp := fCriaQuery(nil);

    Try
      qryTemp.Close();
      qryTemp.SQL.Clear();
      qryTemp.SQL.Text := 'SELECT MAX(TSN_LIMSUP) AS TSN_LIMSUP FROM TSNFXA';
      qryTemp.Open();

      fltReceitaBruta     := RoundTo(fStrToFloat(edtReceitaBruta.Text), -2);
      fltMaxFaixasSimples := RoundTo(qryTemp.FieldByName('TSN_LIMSUP').AsFloat, -2);

      Result := (fltReceitaBruta <= fltMaxFaixasSimples);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, 'TfrmRelSimplesNacional.fValorMaximoEnquadramentoSimples');
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

procedure TfrmRelSimplesNacional.grdComercioDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
   fltRecBruta,
   fltLimInf,
   fltLimSup: Double;
begin
  inherited;

  If Assigned(grdComercioDados.DataController.DataSource.DataSet) And
    (Not grdComercioDados.DataController.DataSource.DataSet.IsEmpty) Then Begin

    fltRecBruta := fStrToFloat(edtReceitaBruta.Text);
    fltLimInf   := VarAsType(IfNull(Sender.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdComercio_LIMINF.Index], 0), varDouble);
    fltLimSup   := VarAsType(IfNull(Sender.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdComercio_LIMSUP.Index], 0), varDouble);

    fltRecBruta := Trunc(fltRecBruta * 100);
    fltLimInf   := Trunc(fltLimInf * 100);
    fltLimSup   := Trunc(fltLimSup * 100);

    If (fltLimInf <= fltRecBruta) And (fltLimSup >= fltRecBruta) Then Begin
      If (ACanvas.Brush.Color = clHighlight) Then
        ACanvas.Font.Color := clBlack;

      ACanvas.Brush.Color := $0096CFA7;
    End;
  End;
end;

procedure TfrmRelSimplesNacional.grdIndustriaDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
   fltRecBruta,
   fltLimInf,
   fltLimSup: Double;
begin
  inherited;

  If Assigned(grdIndustriaDados.DataController.DataSource.DataSet) And
    (Not grdIndustriaDados.DataController.DataSource.DataSet.IsEmpty) Then Begin

    fltRecBruta := fStrToFloat(edtReceitaBruta.Text);
    fltLimInf   := VarAsType(IfNull(Sender.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdIndustria_LIMINF.Index], 0), varDouble);
    fltLimSup   := VarAsType(IfNull(Sender.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdIndustria_LIMSUP.Index], 0), varDouble);

    fltRecBruta := Trunc(fltRecBruta * 100);
    fltLimInf   := Trunc(fltLimInf * 100);
    fltLimSup   := Trunc(fltLimSup * 100);

    If (fltLimInf <= fltRecBruta) And (fltLimSup >= fltRecBruta) Then Begin
      If (ACanvas.Brush.Color = clHighlight) Then
        ACanvas.Font.Color := clBlack;

      ACanvas.Brush.Color := $0096CFA7;
    End;
  End;
end;

procedure TfrmRelSimplesNacional.grdResumoDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (ACanvas.Brush.Color = clHighlight) Then
    ACanvas.Font.Color := clBlack;

  ACanvas.Brush.Color := $0096CFA7;
end;

procedure TfrmRelSimplesNacional.grdServicosIVDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
   fltRecBruta,
   fltLimInf,
   fltLimSup: Double;
begin
  inherited;

  If Assigned(grdServicosIVDados.DataController.DataSource.DataSet) And
    (Not grdServicosIVDados.DataController.DataSource.DataSet.IsEmpty) Then Begin

    fltRecBruta := fStrToFloat(edtReceitaBruta.Text);
    fltLimInf   := VarAsType(IfNull(Sender.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdServicosIV_LIMINF.Index], 0), varDouble);
    fltLimSup   := VarAsType(IfNull(Sender.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdServicosIV_LIMSUP.Index], 0), varDouble);

    fltRecBruta := Trunc(fltRecBruta * 100);
    fltLimInf   := Trunc(fltLimInf * 100);
    fltLimSup   := Trunc(fltLimSup * 100);

    If (fltLimInf <= fltRecBruta) And (fltLimSup >= fltRecBruta) Then Begin
      If (ACanvas.Brush.Color = clHighlight) Then
        ACanvas.Font.Color := clBlack;

      ACanvas.Brush.Color := $0096CFA7;
    End;
  End;
end;

procedure TfrmRelSimplesNacional.grdServicosVADadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
   fltRecBruta,
   fltLimInf,
   fltLimSup: Double;
begin
  inherited;

  If Assigned(grdServicosVADados.DataController.DataSource.DataSet) And
    (Not grdServicosVADados.DataController.DataSource.DataSet.IsEmpty) Then Begin

    fltRecBruta := fStrToFloat(edtReceitaBruta.Text);
    fltLimInf   := VarAsType(IfNull(Sender.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdServicosVA_LIMINF.Index], 0), varDouble);
    fltLimSup   := VarAsType(IfNull(Sender.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdServicosVA_LIMSUP.Index], 0), varDouble);

    fltRecBruta := Trunc(fltRecBruta * 100);
    fltLimInf   := Trunc(fltLimInf * 100);
    fltLimSup   := Trunc(fltLimSup * 100);

    If (fltLimInf <= fltRecBruta) And (fltLimSup >= fltRecBruta) Then Begin
      If (ACanvas.Brush.Color = clHighlight) Then
        ACanvas.Font.Color := clBlack;

      ACanvas.Brush.Color := $0096CFA7;
    End;
  End;
end;

procedure TfrmRelSimplesNacional.mskMesAtualEnter(Sender: TObject);
begin
  inherited;

  strMesAtual := mskMesAtual.Text;
end;

procedure TfrmRelSimplesNacional.mskMesAtualExit(Sender: TObject);
begin
  inherited;

  If (fStrToFloat(edtReceitaBruta.Text) > 0) And
     (Length(fTiraCaracEspeciais(Trim(mskMesAtual.Text))) = 6) And
     (Not chkCalculoManual.Checked) And
     (strMesAtual <> mskMesAtual.Text) And
     (fMensagem('ATENÇÃO!', 'Deseja recalcular os valores de faturamento atual e dos meses anteriores?', ['&Sim', '&Não'], 1) = 1) Then Begin
    btnCalcMeses.Click();
    btnCalcMesAtual.Click();

    pLimparEditsAbas();
    pLimparClientsDataSet();

    tshResumo.TabVisible := False;
    tshComercio.Show();
  End;

  strMesAtual := mskMesAtual.Text;
end;

procedure TfrmRelSimplesNacional.grdServicosIIIDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
   fltRecBruta,
   fltLimInf,
   fltLimSup: Double;
begin
  inherited;

  If Assigned(grdServicosIIIDados.DataController.DataSource.DataSet) And
    (Not grdServicosIIIDados.DataController.DataSource.DataSet.IsEmpty) Then Begin

    fltRecBruta := fStrToFloat(edtReceitaBruta.Text);
    fltLimInf   := VarAsType(IfNull(Sender.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdServicosIII_LIMINF.Index], 0), varDouble);
    fltLimSup   := VarAsType(IfNull(Sender.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdServicosIII_LIMSUP.Index], 0), varDouble);

    fltRecBruta := Trunc(fltRecBruta * 100);
    fltLimInf   := Trunc(fltLimInf * 100);
    fltLimSup   := Trunc(fltLimSup * 100);

    If (fltLimInf <= fltRecBruta) And (fltLimSup >= fltRecBruta) Then Begin
      If (ACanvas.Brush.Color = clHighlight) Then
        ACanvas.Font.Color := clBlack;

      ACanvas.Brush.Color := $0096CFA7;
    End;
  End;
end;

function TfrmRelSimplesNacional.fCalcularImposto(tsTipoTabela: TTipoTabelaSimples): Boolean;
var
  blnCalcAliqEfetiva: Boolean;
  dblAliqEfetiva: Double;
  dblTOTSNCEfetivo: Double;

  function fGetClientDataSets: TUniClientDataSet; begin
    Result := fGetClientDataSet(tsTipoTabela);
  end;

begin
  Result := True;

  Try
    fGetClientDataSets().DisableControls();
    fGetClientDataSets().First();

    While (Not fGetClientDataSets().Eof) Do Begin
      If (fGetClientDataSets().FieldByName('TSN_LIMINF').AsFloat <= fStrToFloat(edtReceitaBruta.Text)) And
         (fGetClientDataSets().FieldByName('TSN_LIMSUP').AsFloat >= fStrToFloat(edtReceitaBruta.Text)) Then Begin

        fGetClientDataSets().Edit();

        dblAliqEfetiva   := (((fStrToFloat(edtValFatMeses.Text) * (fGetClientDataSets().FieldByName('TSN_ALIQUO').AsFloat / 100)) - fGetClientDataSets().FieldByName('TSN_VLRDES').AsFloat) / fStrToFloat(edtValFatMeses.Text));
        dblTOTSNCEfetivo := dblAliqEfetiva * fStrToFloat(edtFatMesAtual.Text);

        Case (tsTipoTabela) Of
          tsComercio:
            Begin
              blnCalcAliqEfetiva := fCampoTabela('TSN_ALIQEF', 'CADTSN', ['TSN_CODEMP', 'TSN_TIPTAB'], [VS_StrCodEmp, '0']) = 'S';
              lblAliqEfetiva1.Visible := blnCalcAliqEfetiva;
              fGetClientDataSets().FieldByName('TSN_TOTTRB').AsFloat := fStrToFloat(edtFatProdTribComercio.Text) * (fGetClientDataSets().FieldByName('TSN_ALQTRB').AsFloat / 100);
              fGetClientDataSets().FieldByName('TSN_TOTRET').AsFloat := fStrToFloat(edtFatProdRetComercio.Text)  * (fGetClientDataSets().FieldByName('TSN_ALQRET').AsFloat / 100);


              If blnCalcAliqEfetiva Then
              Begin
                fGetClientDataSets().FieldByName('TSN_TOTSNC').AsFloat := dblTOTSNCEfetivo;
                fGetClientDataSets().FieldByName('TSN_ALIQUO').AsFloat := dblAliqEfetiva * 100;
              End
              Else
              Begin
                {If (fGetClientDataSets().FieldByName('TSN_INIVIG').AsDateTime >= EncodeDate(2025, 1, 1)) Then //alterar para 2026
                Begin
                  fGetClientDataSets().FieldByName('TSN_TOTSNC').AsFloat :=
                    fStrToFloat(edtFatProdTribComercio.Text) *
                    (fGetClientDataSets().FieldByName('TSN_ALQRET').AsFloat / 100);
                End
                Else}
                Begin
                  fGetClientDataSets().FieldByName('TSN_TOTSNC').AsFloat :=
                    fGetClientDataSets().FieldByName('TSN_TOTTRB').AsFloat +
                    fGetClientDataSets().FieldByName('TSN_TOTRET').AsFloat;
                End;
              End;
            End;

          tsIndustria:
            Begin
              blnCalcAliqEfetiva := fCampoTabela('TSN_ALIQEF', 'CADTSN', ['TSN_CODEMP', 'TSN_TIPTAB'], [VS_StrCodEmp, '1']) = 'S';
              lblAliqEfetiva2.Visible := blnCalcAliqEfetiva;
              fGetClientDataSets().FieldByName('TSN_TOTTRB').AsFloat := fStrToFloat(edtFatProdTribIndustria.Text) * (fGetClientDataSets().FieldByName('TSN_ALQTRB').AsFloat / 100);
              fGetClientDataSets().FieldByName('TSN_TOTRET').AsFloat := fStrToFloat(edtFatProdRetIndustria.Text)  * (fGetClientDataSets().FieldByName('TSN_ALQRET').AsFloat / 100);
              If Not blnCalcAliqEfetiva Then
                fGetClientDataSets().FieldByName('TSN_TOTSNC').AsFloat := fGetClientDataSets().FieldByName('TSN_TOTTRB').AsFloat + fGetClientDataSets().FieldByName('TSN_TOTRET').AsFloat
              Else
              Begin
                fGetClientDataSets().FieldByName('TSN_TOTSNC').AsFloat := dblTOTSNCEfetivo;
                fGetClientDataSets().FieldByName('TSN_ALIQUO').AsFloat := dblAliqEfetiva * 100;
              End;
            End;

          tsIndustriaSimples:
            Begin
              blnCalcAliqEfetiva := fCampoTabela('TSN_ALIQEF', 'CADTSN', ['TSN_CODEMP', 'TSN_TIPTAB'], [VS_StrCodEmp, '1']) = 'S';
              lblAliqEfetiva6.Visible := blnCalcAliqEfetiva;
              fGetClientDataSets().FieldByName('TSN_TOTTRB').AsFloat := fStrToFloat(edtFatProdTribIndustriaSimples.Text) * (RoundTo(fGetClientDataSets().FieldByName('TSN_ALQTRB').AsFloat, -2) / 100);
              fGetClientDataSets().FieldByName('TSN_TOTRET').AsFloat := fltTotRet;
              If Not blnCalcAliqEfetiva Then
                fGetClientDataSets().FieldByName('TSN_TOTSNC').AsFloat := fStrToFloat(edtFatMesAtual.Text)* (RoundTo(fGetClientDataSets().FieldByName('TSN_ALQTRB').AsFloat, -2) / 100)
              Else
              Begin
                fGetClientDataSets().FieldByName('TSN_TOTSNC').AsFloat := dblTOTSNCEfetivo;
                fGetClientDataSets().FieldByName('TSN_ALIQUO').AsFloat := dblAliqEfetiva * 100;
              End;
            End;
          tsServicoIII:
            Begin
              blnCalcAliqEfetiva := fCampoTabela('TSN_ALIQEF', 'CADTSN', ['TSN_CODEMP', 'TSN_TIPTAB'], [VS_StrCodEmp, '2']) = 'S';
              lblAliqEfetiva3.Visible := blnCalcAliqEfetiva;
              If (fStrToFloat(edtFatServServicosIIIIss.Text) > 0) Or (fStrToFloat(edtFatServServicosIIIIssRet.Text) > 0) Then
              Begin
                If Not blnCalcAliqEfetiva Then
                  fGetClientDataSets().FieldByName('TSN_TOTSNC').AsFloat :=
                    (fStrToFloat(edtFatServServicosIIIIss.Text) * (fGetClientDataSets().FieldByName('TSN_ALIQUO').AsFloat / 100)) +
                    (fStrToFloat(edtFatServServicosIIIIssRet.Text) * ((fGetClientDataSets().FieldByName('TSN_ALIQUO').AsFloat - fGetClientDataSets().FieldByName('TSN_ALQISS').AsFloat) / 100))
                Else
                Begin
                  fGetClientDataSets().FieldByName('TSN_TOTSNC').AsFloat := dblTOTSNCEfetivo;
                  fGetClientDataSets().FieldByName('TSN_ALIQUO').AsFloat := dblAliqEfetiva * 100;
                End;
              End
              Else
                fGetClientDataSets().FieldByName('TSN_TOTSNC').AsFloat := 0;
            End;

          tsServicoIV:
            Begin
              blnCalcAliqEfetiva := fCampoTabela('TSN_ALIQEF', 'CADTSN', ['TSN_CODEMP', 'TSN_TIPTAB'], [VS_StrCodEmp, '3']) = 'S';
              lblAliqEfetiva4.Visible := blnCalcAliqEfetiva;
              If (fStrToFloat(edtFatServServicosIVIss.Text) > 0) Or (fStrToFloat(edtFatServServicosIVIssRet.Text) > 0) Then
              Begin
                If Not blnCalcAliqEfetiva Then
                  fGetClientDataSets().FieldByName('TSN_TOTSNC').AsFloat :=
                    (fStrToFloat(edtFatServServicosIVIss.Text) * (fGetClientDataSets().FieldByName('TSN_ALIQUO').AsFloat / 100)) +
                    (fStrToFloat(edtFatServServicosIVIssRet.Text) * ((fGetClientDataSets().FieldByName('TSN_ALIQUO').AsFloat - fGetClientDataSets().FieldByName('TSN_ALQISS').AsFloat) / 100))
                Else
                Begin
                  fGetClientDataSets().FieldByName('TSN_TOTSNC').AsFloat := dblTOTSNCEfetivo;
                  fGetClientDataSets().FieldByName('TSN_ALIQUO').AsFloat := dblAliqEfetiva * 100;
                End;
              End
              Else
                fGetClientDataSets().FieldByName('TSN_TOTSNC').AsFloat := 0;
            End;

          tsServicoVA:
            Begin
              blnCalcAliqEfetiva := fCampoTabela('TSN_ALIQEF', 'CADTSN', ['TSN_CODEMP', 'TSN_TIPTAB'], [VS_StrCodEmp, '5']) = 'S';
              lblAliqEfetiva5.Visible := blnCalcAliqEfetiva;
              If (fStrToFloat(edtFatServServicosVAIss.Text) > 0) Or (fStrToFloat(edtFatServServicosVAIssRet.Text) > 0) Then
              Begin
                If Not blnCalcAliqEfetiva Then
                  fGetClientDataSets().FieldByName('TSN_TOTSNC').AsFloat :=
                    (fStrToFloat(edtFatServServicosVAIss.Text) * (fGetClientDataSets().FieldByName('TSN_ALIQUO').AsFloat / 100)) +
                    (fStrToFloat(edtFatServServicosVAIssRet.Text) * ((fGetClientDataSets().FieldByName('TSN_ALIQUO').AsFloat - fGetClientDataSets().FieldByName('TSN_ALQISS').AsFloat) / 100))
                Else
                Begin
                  fGetClientDataSets().FieldByName('TSN_TOTSNC').AsFloat := dblTOTSNCEfetivo;
                  fGetClientDataSets().FieldByName('TSN_ALIQUO').AsFloat := dblAliqEfetiva * 100;
                End;
              End
              Else
                fGetClientDataSets().FieldByName('TSN_TOTSNC').AsFloat := 0;
            End;
        End;

        fGetClientDataSets().Post();
        Break;
      End;

      fGetClientDataSets().Next();
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TfrmRelSimplesNacional.fCalcularImposto');
    End;
  End;
  fGetClientDataSets().EnableControls();
end;

procedure TfrmRelSimplesNacional.pAjustarComponentesCalculoManual(
  blnCalculoManual: Boolean);
begin
  edtValFatMeses.ReadOnly := (Not blnCalculoManual);
  btnCalcMeses.Enabled    := (Not blnCalculoManual);
end;

procedure TfrmRelSimplesNacional.pCalcularMesAtual;
  Var
    qryTemp : TUniQuery;
    fltValor: Double;
begin
  If (Not fValidaCampos(mskMesAtual, True)) Then Exit;

  Try
    qryTemp  := fCriaQuery(nil);

    Try
      qryTemp.Close();
      qryTemp.SQL.Clear();
      qryTemp.SQL.Text := fGetSQL(False, False, tsFaturamentoPeriodo, True);
      qryTemp.ParamByName('DTAINI').AsDateTime := Trunc(EncodeDate(StrToInt(Copy(mskMesAtual.Text, 4, 4)), StrToInt(Copy(mskMesAtual.Text, 1, 2)), 1));
      qryTemp.ParamByName('DTAFIN').AsDateTime := Trunc(EndOfAMonth(StrToInt(Copy(mskMesAtual.Text, 4, 4)), StrToInt(Copy(mskMesAtual.Text, 1, 2))));
//      qryTemp.ParamByName('CODEMP').AsString   := VS_strCodEmp;
      qryTemp.ParamByName('CLAVEN').AsString   := VS_strClaVen;
      qryTemp.ParamByName('CLADEV').AsString   := VS_strClaDev;
      qryTemp.Open();
      qryTemp.First();

      fltValor := 0;

      While (Not qryTemp.Eof) Do Begin
        fltValor := fltValor + qryTemp.FieldByName('TOTAL_VENDA').AsFloat;

        qryTemp.Next();
      End;

      edtFatMesAtual.Text := FormatFloat('#,##0.00', fltValor);

      fValidaCampos(edtFatMesAtual, True);



    Except
      On E: Exception Do
        pMensagensErro(E.Message, 'TfrmRelSimplesNacional.pCalcularMesAtual');
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

procedure TfrmRelSimplesNacional.pCalcularMesesAnteriores;
  Var
    qryTemp : TUniQuery;
    intMeses: Integer;
    fltValor: Double;
begin
  If (Not fValidaCampos(mskMesAtual, True)) Then Exit;

  If (fEmptyStr(edtMeses.Text)) Or (StrToInt(edtMeses.Text) = 0) Then Begin
    fMensagem('ATENÇÃO!', 'Informe a quantidade de meses para apuração!', ['&OK']);
    pSetFocus(edtMeses);
    Exit;
  End;

  Try
    qryTemp  := fCriaQuery(nil);
    intMeses := StrToInt(edtMeses.Text);

    Try
      qryTemp.Close();
      qryTemp.SQL.Clear();
      qryTemp.SQL.Text := fGetSQL(False, False, tsFaturamentoPeriodo, True);
      qryTemp.ParamByName('DTAINI').AsDateTime := Trunc(fCalcularDataIni(mskMesAtual.Text, intMeses));
      qryTemp.ParamByName('DTAFIN').AsDateTime := Trunc(fCalcularDataFin(mskMesAtual.Text));
//      qryTemp.ParamByName('CODEMP').AsString   := VS_strCodEmp;
      qryTemp.ParamByName('CLAVEN').AsString   := VS_strClaVen;
      qryTemp.ParamByName('CLADEV').AsString   := VS_strClaDev;
      qryTemp.Open();
      qryTemp.First();

      fltValor := 0;
      If Not cdsAgruEmp.IsEmpty Then
      cdsAgruEmp.EmptyDataSet;
      While (Not qryTemp.Eof) Do
      Begin
        fltValor := fltValor + qryTemp.FieldByName('TOTAL_VENDA').AsFloat;
        If not (cdsAgruEmpCODEMP.AsString =  qryTemp.FieldByName('CODEMP').AsString) Then
        Begin
          cdsAgruEmp.First;
          cdsAgruEmp.Locate('CODEMP', qryTemp.FieldByName('CODEMP').AsString, []);
        End;
        If  Not (cdsAgruEmpCODEMP.AsString =  qryTemp.FieldByName('CODEMP').AsString) Then
        Begin
          cdsAgruEmp.Append;
          cdsAgruEmpCODEMP.AsString := qryTemp.FieldByName('CODEMP').AsString;
          cdsAgruEmpCNPJ.AsString := qryTemp.FieldByName('EMP_C_G_C_').AsString;
        End
        Else
          cdsAgruEmp.Edit;

        cdsAgruEmpVALOR.AsFloat := cdsAgruEmpVALOR.AsFloat + qryTemp.FieldByName('TOTAL_VENDA').AsFloat;
        cdsAgruEmp.Post;

        qryTemp.Next();
      End;

      edtValFatMeses.Text := FormatFloat('#,##0.00', fltValor);


      dtaApuIni := qryTemp.ParamByName('DTAINI').AsDate;
      dtaApuFin := qryTemp.ParamByName('DTAFIN').AsDate;
      lblPeriodoApurado.Visible := True;
      lblPeriodoApurado.Caption := 'Período apurado: ' + qryTemp.ParamByName('DTAINI').AsString +
        ' - ' + qryTemp.ParamByName('DTAFIN').AsString;

      fValidaCampos(edtValFatMeses, True);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, 'TfrmRelSimplesNacional.pCalcularMesesAnteriores');
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

function TfrmRelSimplesNacional.fCalcularValorVendaTribRet(tsTipoTabela: TTipoTabelaSimples): Boolean;
  Var
    qryTemp : TUniQuery;
    fltFatTribICMS,
    fltFatTrib,
    fltFatRet,
    fltFatIsento,
    fltFatIss,
    fltFatIssRet: Double;

  procedure pAtualizarEditsAbas; begin
    Case (tsTipoTabela) Of
      tsComercio:
        Begin
          edtFatProdTribComercio.Text   := FormatFloat('#,##0.00', fltFatTrib);
          edtFatProdRetComercio.Text    := FormatFloat('#,##0.00', fltFatRet);
          edtFatProdIsentoComercio.Text := FormatFloat('#,##0.00', fltFatIsento);
        End;

      tsIndustria:
        Begin
          edtFatProdTribIndustria.Text   := FormatFloat('#,##0.00', fltFatTrib);
          edtFatProdRetIndustria.Text    := FormatFloat('#,##0.00', fltFatRet);
          edtFatProdIsentoIndustria.Text := FormatFloat('#,##0.00', fltFatIsento);
        End;

      tsIndustriaSimples:
        Begin
          edtFatProdTribIndustriaSimples.Text   := FormatFloat('#,##0.00', fltFatTribICMS);
          edtFatProdRetIndustriaSimples.Text    := FormatFloat('#,##0.00', fltFatRet);
//          edtFatProdIsentoIndustria.Text := FormatFloat('#,##0.00', fltFatIsento);
        End;

      tsServicoIII:
        Begin
          edtFatServServicosIIIIss.Text    := FormatFloat('#,##0.00', fltFatIss);
          edtFatServServicosIIIIssRet.Text := FormatFloat('#,##0.00', fltFatIssRet);
        End;

      tsServicoIV:
        Begin
          edtFatServServicosIVIss.Text    := FormatFloat('#,##0.00', fltFatIss);
          edtFatServServicosIVIssRet.Text := FormatFloat('#,##0.00', fltFatIssRet);
        End;

      tsServicoVA:
        Begin
          edtFatServServicosVAIss.Text    := FormatFloat('#,##0.00', fltFatIss);
          edtFatServServicosVAIssRet.Text := FormatFloat('#,##0.00', fltFatIssRet);
        End;
    End;
  end;

begin
  Result := False;

  Try
    qryTemp  := fCriaQuery(nil);

    Try
      qryTemp.Close();
      qryTemp.SQL.Clear();
      qryTemp.SQL.Text := fGetSQL(True, False, tsTipoTabela, True); //calcula primeiro sem retenção
      qryTemp.ParamByName('DTAINI').AsDateTime := Trunc(EncodeDate(StrToInt(Copy(mskMesAtual.Text, 4, 4)), StrToInt(Copy(mskMesAtual.Text, 1, 2)), 1));
      qryTemp.ParamByName('DTAFIN').AsDateTime := Trunc(EndOfAMonth(StrToInt(Copy(mskMesAtual.Text, 4, 4)), StrToInt(Copy(mskMesAtual.Text, 1, 2))));
      //qryTemp.ParamByName('CODEMP').AsString   := VS_strCodEmp;

      If (tsTipoTabela = tsComercio) Then Begin
        qryTemp.ParamByName('CLAVEN').AsString := VS_strClaVen;
        qryTemp.ParamByName('CLADEV').AsString := VS_strClaDev;
        qryTemp.ParamByName('CLAIND').AsString := fTransform(fCfgSis('CLAIND', varString), 4);
        qryTemp.ParamByName('CLASER').AsString := fTransform(fCfgSis('CLASER', varString), 4);
        qryTemp.ParamByName('CODFIS').AsString := CST_TRIBUTADO + CST_REDUCAO_20 + CST_ANTECIPACAO_ICMS;
      End Else If (tsTipoTabela = tsIndustria) Then Begin
        qryTemp.ParamByName('CLAIND').AsString := fTransform(fCfgSis('CLAIND', varString), 4);
        qryTemp.ParamByName('CODFIS').AsString := CST_TRIBUTADO + CST_REDUCAO_20 + CST_ANTECIPACAO_ICMS;
      End Else If (tsTipoTabela = tsIndustriaSimples) Then Begin
        qryTemp.ParamByName('CLAIND').AsString := VS_strClaDev + fTransform(fCfgSis('CLAIND', varString), 4) ;
        qryTemp.ParamByName('CODFIS').AsString := CST_TRIBUTADO + CST_REDUCAO_20 + CST_ANTECIPACAO_ICMS;
      End Else Begin
        qryTemp.ParamByName('CLASER').AsString  := fTransform(fCfgSis('CLASER', varString), 4);
        qryTemp.ParamByName('TIPTAB').AsInteger := Integer(tsTipoTabela);
      End;

      qryTemp.Open();
      qryTemp.First();

      fltFatTrib := 0;

      While (Not qryTemp.Eof) Do Begin
        fltFatTrib := fltFatTrib + qryTemp.FieldByName('TOTAL_VENDA').AsFloat;

        qryTemp.Next();
      End;

      If (tsTipoTabela in [tsServicoIII, tsServicoIV, tsServicoVA]) Then Begin
        fltFatIss  := fltFatTrib;
        fltFatTrib := 0;
      End;


      If (tsTipoTabela in [tsComercio, tsIndustria, tsIndustriaSimples]) Then Begin
        qryTemp.Close();
        qryTemp.SQL.Clear();
        qryTemp.SQL.Text := fGetSQL(True, False, tsTipoTabela, True);
        qryTemp.ParamByName('DTAINI').AsDateTime := Trunc(EncodeDate(StrToInt(Copy(mskMesAtual.Text, 4, 4)), StrToInt(Copy(mskMesAtual.Text, 1, 2)), 1));
        qryTemp.ParamByName('DTAFIN').AsDateTime := Trunc(EndOfAMonth(StrToInt(Copy(mskMesAtual.Text, 4, 4)), StrToInt(Copy(mskMesAtual.Text, 1, 2))));
//        qryTemp.ParamByName('CODEMP').AsString   := VS_strCodEmp;

        If (tsTipoTabela = tsComercio) Then Begin
          qryTemp.ParamByName('CLAVEN').AsString := VS_strClaVen;
          qryTemp.ParamByName('CLADEV').AsString := VS_strClaDev;
          qryTemp.ParamByName('CLAIND').AsString := fTransform(fCfgSis('CLAIND', varString), 4);
          qryTemp.ParamByName('CLASER').AsString := fTransform(fCfgSis('CLASER', varString), 4);
          qryTemp.ParamByName('CODFIS').AsString := CST_SUBSTITUICAO;
        End Else If (tsTipoTabela = tsIndustria) Then Begin
          qryTemp.ParamByName('CLAIND').AsString := fTransform(fCfgSis('CLAIND', varString), 4);
          qryTemp.ParamByName('CODFIS').AsString := CST_SUBSTITUICAO;
        End Else If (tsTipoTabela = tsIndustriaSimples) Then Begin
          qryTemp.ParamByName('CLAIND').AsString := VS_strClaDev + fTransform(fCfgSis('CLAIND', varString), 4);
          qryTemp.ParamByName('CODFIS').AsString := CST_SUBSTITUICAO;
        End Else Begin
          qryTemp.ParamByName('CLASER').AsString  := fTransform(fCfgSis('CLASER', varString), 4);
          qryTemp.ParamByName('TIPTAB').AsInteger := Integer(tsTipoTabela);
        End;

        qryTemp.Open();
        qryTemp.First();

        fltFatRet := 0;
        fltTotRet := 0;

        While (Not qryTemp.Eof) Do Begin
          fltTotRet := fltTotRet + qryTemp.FieldByName('TOTRET').AsFloat;
          fltFatRet := fltFatRet + qryTemp.FieldByName('TOTAL_VENDA').AsFloat;
          qryTemp.Next();
        End;

        qryTemp.Close();
        qryTemp.SQL.Clear();
        qryTemp.SQL.Text := fGetSQL(True, False, tsTipoTabela, True);
        qryTemp.ParamByName('DTAINI').AsDateTime := Trunc(EncodeDate(StrToInt(Copy(mskMesAtual.Text, 4, 4)), StrToInt(Copy(mskMesAtual.Text, 1, 2)), 1));
        qryTemp.ParamByName('DTAFIN').AsDateTime := Trunc(EndOfAMonth(StrToInt(Copy(mskMesAtual.Text, 4, 4)), StrToInt(Copy(mskMesAtual.Text, 1, 2))));
        //qryTemp.ParamByName('CODEMP').AsString   := VS_strCodEmp;

        If (tsTipoTabela = tsComercio) Then Begin
          qryTemp.ParamByName('CLAVEN').AsString := VS_strClaVen;
          qryTemp.ParamByName('CLADEV').AsString := VS_strClaDev;
          qryTemp.ParamByName('CLAIND').AsString := fTransform(fCfgSis('CLAIND', varString), 4);
          qryTemp.ParamByName('CLASER').AsString := fTransform(fCfgSis('CLASER', varString), 4);
          qryTemp.ParamByName('CODFIS').AsString := CST_ISENTO + CST_NAO_TRIBUTADO;
        End Else If (tsTipoTabela = tsIndustria) Then Begin
          qryTemp.ParamByName('CLAIND').AsString := fTransform(fCfgSis('CLAIND', varString), 4);
          qryTemp.ParamByName('CODFIS').AsString := CST_ISENTO + CST_NAO_TRIBUTADO;
        End Else If (tsTipoTabela = tsIndustriaSimples) Then Begin
          qryTemp.ParamByName('CLAIND').AsString := fTransform(fCfgSis('CLAIND', varString), 4);
          qryTemp.ParamByName('CODFIS').AsString := CST_ISENTO + CST_NAO_TRIBUTADO;
        End Else Begin
          qryTemp.ParamByName('CLASER').AsString  := fTransform(fCfgSis('CLASER', varString), 4);
          qryTemp.ParamByName('TIPTAB').AsInteger := Integer(tsTipoTabela);
        End;

        qryTemp.Open();
        qryTemp.First();

        fltFatIsento := 0;

        While (Not qryTemp.Eof) Do Begin
          fltFatIsento := fltFatIsento + qryTemp.FieldByName('TOTAL_VENDA').AsFloat;

          qryTemp.Next();
        End;
      End Else Begin
        fltFatRet    := 0;
        fltFatIsento := 0;

        qryTemp.Close();
        qryTemp.SQL.Clear();
        qryTemp.SQL.Text := fGetSQL(True, True, tsTipoTabela, True); //calcula com retenção
        qryTemp.ParamByName('DTAINI').AsDateTime := Trunc(EncodeDate(StrToInt(Copy(mskMesAtual.Text, 4, 4)), StrToInt(Copy(mskMesAtual.Text, 1, 2)), 1));
        qryTemp.ParamByName('DTAFIN').AsDateTime := Trunc(EndOfAMonth(StrToInt(Copy(mskMesAtual.Text, 4, 4)), StrToInt(Copy(mskMesAtual.Text, 1, 2))));
        //qryTemp.ParamByName('CODEMP').AsString   := VS_strCodEmp;
        qryTemp.ParamByName('CLASER').AsString  := fTransform(fCfgSis('CLASER', varString), 4);
        qryTemp.ParamByName('TIPTAB').AsInteger := Integer(tsTipoTabela);

        qryTemp.Open();
        qryTemp.First();

        fltFatTrib := 0;

        While (Not qryTemp.Eof) Do Begin
          fltFatTrib := fltFatTrib + qryTemp.FieldByName('TOTAL_VENDA').AsFloat;

          qryTemp.Next();
        End;

        fltFatIssRet := fltFatTrib;
        fltFatTrib   := 0;
      End;

      fltFatTribICMS := fltFatTrib;

      pAtualizarEditsAbas();

      Result := True;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, 'TfrmRelSimplesNacional.fCalcularValorVendaTribRet');
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

function TfrmRelSimplesNacional.fCarregarDadosTabela(tsTipoTabela: TTipoTabelaSimples): Boolean;
  Var
    strSQL: String;
    qryTabela: TUniQuery;

  function fGetDataSource: TDataSource; begin
    Case (tsTipoTabela) Of
      tsComercio  : Result := dtsComercio;
      tsIndustria : Result := dtsIndustria;
      tsIndustriaSimples : Result := dtsIndustriaSimples;
      tsServicoIII: Result := dtsServicosIII;
      tsServicoIV : Result := dtsServicosIV;
      tsServicoVA : Result := dtsServicosVA;
      Else Result := nil;
    End;
  end;

  function fGetClientDataSets: TUniClientDataSet; begin
    Result := fGetClientDataSet(tsTipoTabela);
  end;

  procedure pCarregarDadosClientDataSet;
    Var
      fltReceitaBruta, fltPercTrib, fltAliqIcms: Double;

  begin
    qryTabela.First();

    While (Not qryTabela.Eof) Do Begin
      fGetClientDataSets().Append();

      fGetClientDataSets().FieldByName('TSN_SEQTSN').AsString  := qryTabela.FieldByName('TSN_SEQTSN').AsString;
      fGetClientDataSets().FieldByName('AUTOINCREM').AsString  := qryTabela.FieldByName('AUTOINCREM').AsString;
      fGetClientDataSets().FieldByName('TSN_IDXFXA').AsInteger := qryTabela.FieldByName('TSN_IDXFXA').AsInteger;
      fGetClientDataSets().FieldByName('TSN_LIMINF').AsFloat   := qryTabela.FieldByName('TSN_LIMINF').AsFloat;
      fGetClientDataSets().FieldByName('TSN_LIMSUP').AsFloat   := qryTabela.FieldByName('TSN_LIMSUP').AsFloat;
      fGetClientDataSets().FieldByName('TSN_ALIQUO').AsFloat   := qryTabela.FieldByName('TSN_ALIQUO').AsFloat;
      fGetClientDataSets().FieldByName('TSN_ALIRPJ').AsFloat   := qryTabela.FieldByName('TSN_ALIRPJ').AsFloat;
      fGetClientDataSets().FieldByName('TSN_ALCSLL').AsFloat   := qryTabela.FieldByName('TSN_ALCSLL').AsFloat;
      fGetClientDataSets().FieldByName('TSN_ALQCOF').AsFloat   := qryTabela.FieldByName('TSN_ALQCOF').AsFloat;
      fGetClientDataSets().FieldByName('TSN_ALQPIS').AsFloat   := qryTabela.FieldByName('TSN_ALQPIS').AsFloat;
      fGetClientDataSets().FieldByName('TSN_ALQCPP').AsFloat   := qryTabela.FieldByName('TSN_ALQCPP').AsFloat;
      fGetClientDataSets().FieldByName('TSN_ALQISS').AsFloat   := qryTabela.FieldByName('TSN_ALQISS').AsFloat;
      fGetClientDataSets().FieldByName('TSN_ALQIPI').AsFloat   := qryTabela.FieldByName('TSN_ALQIPI').AsFloat;
      fGetClientDataSets().FieldByName('TSN_VLRDES').AsFloat   := qryTabela.FieldByName('TSN_VLRDES').AsFloat;
      fGetClientDataSets().FieldByName('TSN_ALQICM').AsFloat   := qryTabela.FieldByName('TSN_ALQICM').AsFloat;
      fGetClientDataSets().FieldByName('TSN_TOTTRB').AsFloat   := qryTabela.FieldByName('TSN_TOTTRB').AsFloat;
      fGetClientDataSets().FieldByName('TSN_TOTRET').AsFloat   := qryTabela.FieldByName('TSN_TOTRET').AsFloat;
      fGetClientDataSets().FieldByName('TSN_TOTSNC').AsFloat   := qryTabela.FieldByName('TSN_TOTSNC').AsFloat;
      fGetClientDataSets().FieldByName('TSN_ALQCBS').AsFloat   := qryTabela.FieldByName('TSN_ALQCBS').AsFloat;
      fGetClientDataSets().FieldByName('TSN_ALQIBS').AsFloat   := qryTabela.FieldByName('TSN_ALQIBS').AsFloat;

      If (qryTabela.FieldByName('TSN_INIVIG').AsDateTime >= EncodeDate(2018, 1, 1)) Then
      Begin
        fltReceitaBruta := RoundTo(fStrToFloat(edtReceitaBruta.Text), -2);
        fltAliqIcms     := fGetClientDataSets().FieldByName('TSN_ALQICM').AsFloat;

        fltPercTrib     := ( (fltReceitaBruta * (fGetClientDataSets().FieldByName('TSN_ALIQUO').AsFloat / 100))
                              - fGetClientDataSets().FieldByName('TSN_VLRDES').AsFloat ) / fltReceitaBruta;


        fGetClientDataSets().FieldByName('TSN_ALQTRB').AsFloat := fltPercTrib * 100;
        fGetClientDataSets().FieldByName('TSN_ALQRET').AsFloat := (fltPercTrib - (fltPercTrib * (fltAliqIcms / 100))) * 100;
      End
      Else
      Begin
        fGetClientDataSets().FieldByName('TSN_ALQTRB').AsFloat := qryTabela.FieldByName('TSN_ALQTRB').AsFloat;
        fGetClientDataSets().FieldByName('TSN_ALQRET').AsFloat := qryTabela.FieldByName('TSN_ALQRET').AsFloat;
      End;

      fGetClientDataSets().Post();

      qryTabela.Next();
    End;
  end;

  procedure pCriarClientDataSet; begin
    Case (tsTipoTabela) Of
      tsComercio  : pCriarClientDatasetFaixas(cdsComercio);
      tsIndustria : pCriarClientDatasetFaixas(cdsIndustria);
      tsIndustriaSimples : pCriarClientDatasetFaixas(cdsIndustriaSimples);
      tsServicoIII: pCriarClientDatasetFaixas(cdsServicosIII);
      tsServicoIV : pCriarClientDatasetFaixas(cdsServicosIV);
      tsServicoVA : pCriarClientDatasetFaixas(cdsServicosVA);
    End;
  end;

  procedure pAjustarColunasGrid; begin
    Case (tsTipoTabela) Of
      tsComercio  : grdComercioDados.ApplyBestFit();
      tsIndustria : grdIndustriaDados.ApplyBestFit();
      tsIndustriaSimples : grdIndustriaSimplesDados.ApplyBestFit();
      tsServicoIII: grdServicosIIIDados.ApplyBestFit();
      tsServicoIV : grdServicosIVDados.ApplyBestFit();
      tsServicoVA : grdServicosVADados.ApplyBestFit();
    End;
  end;

begin
  Result := False;

  strSQL := 'SELECT ';
  strSQL := strSQL + '  D.*, ';
  strSQL := strSQL + '  TSN_INIVIG, ';
  strSQL := strSQL + '  TSN_ALIQUO AS TSN_ALQTRB, ';
  strSQL := strSQL + '  0.00 AS TSN_TOTTRB, ';
  strSQL := strSQL + '  (TSN_ALIQUO - TSN_ALQICM) AS TSN_ALQRET, ';
  strSQL := strSQL + '  0.00 AS TSN_TOTRET, ';
  strSQL := strSQL + '  0.00 AS TSN_TOTSNC ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADTSN G ';
  strSQL := strSQL + '  INNER JOIN TSNFXA D ';
  strSQL := strSQL + '    ON G.AUTOINCREM = D.TSN_SEQTSN ';
  strSQL := strSQL + 'WHERE G.TSN_TIPTAB = :TIPTAB ';
  strSQL := strSQL + '  AND :DTAVIG BETWEEN G.TSN_INIVIG AND IFNULL(G.TSN_FIMVIG, "2025-12-31") ';
  strSQL := strSQL + 'ORDER BY D.TSN_IDXFXA ';

  Try
    qryTabela := fCriaQuery(nil);

    Try
      qryTabela.Close();
      qryTabela.SQL.Clear();
      qryTabela.SQL.Text := strSQL;
      If tsTipoTabela in [tsIndustria, tsIndustriaSimples] Then
        qryTabela.ParamByName('TIPTAB').AsInteger  := Integer(tsIndustria)
      Else
        qryTabela.ParamByName('TIPTAB').AsInteger  := Integer(tsTipoTabela);
      qryTabela.ParamByName('DTAVIG').AsDateTime := EncodeDate(StrToInt(Copy(mskMesAtual.Text, 4, 4)), StrToInt(Copy(mskMesAtual.Text, 1, 2)), 1);
      qryTabela.Open();

      If (Assigned(fGetClientDataSets())) Then
        fGetClientDataSets().EmptyDataSet()
      Else
        pCriarClientDataSet();

      pCarregarDadosClientDataSet();
      fGetDataSource().DataSet := fGetClientDataSets();

      pAjustarColunasGrid();

      Result := True;
    Except
      On E: Exception Do Begin
        pMensagensErro(E.Message, 'TfrmRelSimplesNacional.fCarregarDadosTabela');
      End;
    End;
  Finally
    FreeAndNil(qryTabela);
  End;
End;

procedure TfrmRelSimplesNacional.pCriarClientDatasetFaixas(Var cdsFaixas: TUniClientDataSet);
begin
  cdsFaixas := TUniClientDataSet.Create(Self);

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_SEQTSN';
    DataType := ftString;
    Size     := 20;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'AUTOINCREM';
    DataType := ftString;
    Size     := 20;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_IDXFXA';
    DataType := ftInteger;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_LIMINF';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_LIMSUP';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALIQUO';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALIRPJ';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALCSLL';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQCOF';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQPIS';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQCPP';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQISS';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQICM';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQIPI';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_VLRDES';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQTRB';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_TOTTRB';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQRET';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_TOTRET';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_TOTSNC';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQCBS';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQIBS';
    DataType := ftFloat;
  End;

  cdsFaixas.CreateDataSet();

  TFloatField(cdsFaixas.FieldByName('TSN_LIMINF')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_LIMSUP')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_ALIQUO')).DisplayFormat := fMskDigitos(5);
  TFloatField(cdsFaixas.FieldByName('TSN_ALIRPJ')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_ALCSLL')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_ALQCOF')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_ALQPIS')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_ALQCPP')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_ALQISS')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_ALQICM')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_ALQIPI')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_VLRDES')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_ALQTRB')).DisplayFormat := fMskDigitos(4);
  TFloatField(cdsFaixas.FieldByName('TSN_TOTTRB')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_ALQRET')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_TOTRET')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_TOTSNC')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_ALQCBS')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_ALQIBS')).DisplayFormat := fMskDigitos(2);
end;

procedure TfrmRelSimplesNacional.pCriarDataSetResumo;
begin
  cdsResumo := TUniClientDataSet.Create(Self);

  With cdsResumo.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_TABELA';
    DataType := ftString;
    Size     := 30;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do Begin
    Name     := 'AUTOINCREM';
    DataType := ftString;
    Size     := 20;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_LIMINF';
    DataType := ftFloat;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_LIMSUP';
    DataType := ftFloat;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALIQUO';
    DataType := ftFloat;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALIRPJ';
    DataType := ftFloat;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALCSLL';
    DataType := ftFloat;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQCOF';
    DataType := ftFloat;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQPIS';
    DataType := ftFloat;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQCPP';
    DataType := ftFloat;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQISS';
    DataType := ftFloat;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQICM';
    DataType := ftFloat;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQIPI';
    DataType := ftFloat;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_VLRDES';
    DataType := ftFloat;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_TOTSNC';
    DataType := ftFloat;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_TOTTRB';
    DataType := ftFloat;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_TOTRET';
    DataType := ftFloat;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_TOTISE';
    DataType := ftFloat;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_TOTISS';
    DataType := ftFloat;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_TOTISR';
    DataType := ftFloat;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQCBS';
    DataType := ftFloat;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQIBS';
    DataType := ftFloat;
  End;

  cdsResumo.CreateDataSet();

  TFloatField(cdsResumo.FieldByName('TSN_LIMINF')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsResumo.FieldByName('TSN_LIMSUP')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsResumo.FieldByName('TSN_ALIQUO')).DisplayFormat := fMskDigitos(5);
  TFloatField(cdsResumo.FieldByName('TSN_ALIRPJ')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsResumo.FieldByName('TSN_ALCSLL')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsResumo.FieldByName('TSN_ALQCOF')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsResumo.FieldByName('TSN_ALQPIS')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsResumo.FieldByName('TSN_ALQCPP')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsResumo.FieldByName('TSN_ALQISS')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsResumo.FieldByName('TSN_ALQICM')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsResumo.FieldByName('TSN_ALQIPI')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsResumo.FieldByName('TSN_VLRDES')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsResumo.FieldByName('TSN_TOTSNC')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsResumo.FieldByName('TSN_TOTTRB')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsResumo.FieldByName('TSN_TOTRET')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsResumo.FieldByName('TSN_TOTISE')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsResumo.FieldByName('TSN_TOTISS')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsResumo.FieldByName('TSN_TOTISR')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsResumo.FieldByName('TSN_ALQCBS')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsResumo.FieldByName('TSN_ALQIBS')).DisplayFormat := fMskDigitos(2);
end;

procedure TfrmRelSimplesNacional.pCriarResumoApuracao;
begin
  //criar dataset
  If (Not Assigned(cdsResumo)) Then
    pCriarDataSetResumo()
  Else
    cdsResumo.EmptyDataSet();

  //alimentar dataset
  pMontarDataSetResumo;

  dtsResumo.DataSet := cdsResumo;
  grdResumoDados.ApplyBestFit();

  //somar impostos e atualizar edit
  pSomarImpostosResumo;
end;

procedure TfrmRelSimplesNacional.pgcApuracoesChange(Sender: TObject);
begin
  inherited;

  btnImpAnexo.Visible := True;

  Case pgcApuracoes.ActivePageIndex Of
    0:
      Begin
        btnImpAnexo.Caption := 'Imprimir Anexo I';
        btnImpAnexo.Tag     := 518;
      End;
    1:
      Begin
        btnImpAnexo.Caption := 'Imprimir Anexo II';
        btnImpAnexo.Tag     := 519;
      End;
    2:
      Begin
        btnImpAnexo.Caption := 'Imprimir Anexo III';
        btnImpAnexo.Tag     := 520;
      End;
    3:
      Begin
        btnImpAnexo.Caption := 'Imprimir Anexo IV';
        btnImpAnexo.Tag     := 521;
      End;
    4:
      Begin
        btnImpAnexo.Caption := 'Imprimir Anexo V-A';
        btnImpAnexo.Tag     := 522;
      End;
    6:
      Begin
        btnImpAnexo.Caption := 'Imprimir Res. Apuração';
        btnImpAnexo.Tag     := 523;
      End;
  Else
    btnImpAnexo.Visible := False;
  End;
end;

procedure TfrmRelSimplesNacional.pLimparClientsDataSet;
begin
  If (Assigned(cdsComercio))    Then cdsComercio.EmptyDataSet();
  If (Assigned(cdsIndustria))   Then cdsIndustria.EmptyDataSet();
  If (Assigned(cdsIndustriaSimples))   Then cdsIndustriaSimples.EmptyDataSet();

  If (Assigned(cdsServicosIII)) Then cdsServicosIII.EmptyDataSet();
  If (Assigned(cdsServicosIV))  Then cdsServicosIV.EmptyDataSet();
  If (Assigned(cdsServicosVA))  Then cdsServicosVA.EmptyDataSet();
  If (Assigned(cdsResumo))      Then cdsResumo.EmptyDataSet();
end;

procedure TfrmRelSimplesNacional.pLimparComponentes;
begin
  edtMeses.Text        := '0';
  edtValFatMeses.Text  := '0,00';
  mskMesAtual.Text     := FormatDateTime('mm/yyyy', VS_Date);
  strMesAtual          := mskMesAtual.Text;
  edtFatMesAtual.Text  := '0,00';
  edtReceitaBruta.Text := '0,00';

  lblPeriodoApurado.Visible := False;
  lblPeriodoApurado.Caption := 'Período apurado:';

  chkCalculoManual.Checked := False;
  pAjustarComponentesCalculoManual(chkCalculoManual.Checked);

  pLimparEditsAbas();
end;

procedure TfrmRelSimplesNacional.pLimparEditsAbas;
begin
  edtFatProdTribComercio.Text   := '0,00';
  edtFatProdRetComercio.Text    := '0,00';
  edtFatProdIsentoComercio.Text := '0,00';

  edtFatProdTribIndustria.Text   := '0,00';
  edtFatProdRetIndustria.Text    := '0,00';
  edtFatProdIsentoIndustria.Text := '0,00';

  edtFatProdTribIndustriaSimples.Text   := '0,00';
  edtFatProdRetIndustriaSimples.Text    := '0,00';

  edtFatServServicosIIIIss.Text := '0,00';
  edtFatServServicosIVIss.Text  := '0,00';
  edtFatServServicosVAIss.Text  := '0,00';

  edtFatServServicosIIIIssRet.Text := '0,00';
  edtFatServServicosIVIssRet.Text  := '0,00';
  edtFatServServicosVAIssRet.Text  := '0,00';
end;

procedure TfrmRelSimplesNacional.pMontarDataSetResumo;
  Var
    fltRecBruta: Double;

  procedure pAdicionarRegistro(strTabela: String; tsTipoTabela: TTipoTabelaSimples); begin
    With fGetClientDataSet(tsTipoTabela) Do Begin
      cdsResumo.Append();

      cdsResumo.FieldByName('TSN_TABELA').AsString := strTabela;
      cdsResumo.FieldByName('AUTOINCREM').AsString := FieldByName('AUTOINCREM').AsString;
      cdsResumo.FieldByName('TSN_LIMINF').AsFloat  := FieldByName('TSN_LIMINF').AsFloat;
      cdsResumo.FieldByName('TSN_LIMSUP').AsFloat  := FieldByName('TSN_LIMSUP').AsFloat;
      cdsResumo.FieldByName('TSN_ALIQUO').AsFloat  := FieldByName('TSN_ALIQUO').AsFloat;
      cdsResumo.FieldByName('TSN_ALIRPJ').AsFloat  := FieldByName('TSN_ALIRPJ').AsFloat;
      cdsResumo.FieldByName('TSN_ALCSLL').AsFloat  := FieldByName('TSN_ALCSLL').AsFloat;
      cdsResumo.FieldByName('TSN_ALQCOF').AsFloat  := FieldByName('TSN_ALQCOF').AsFloat;
      cdsResumo.FieldByName('TSN_ALQPIS').AsFloat  := FieldByName('TSN_ALQPIS').AsFloat;
      cdsResumo.FieldByName('TSN_ALQCPP').AsFloat  := FieldByName('TSN_ALQCPP').AsFloat;
      cdsResumo.FieldByName('TSN_ALQISS').AsFloat  := FieldByName('TSN_ALQISS').AsFloat;
      cdsResumo.FieldByName('TSN_ALQICM').AsFloat  := FieldByName('TSN_ALQICM').AsFloat;
      cdsResumo.FieldByName('TSN_ALQIPI').AsFloat  := FieldByName('TSN_ALQIPI').AsFloat;
      cdsResumo.FieldByName('TSN_VLRDES').AsFloat  := FieldByName('TSN_VLRDES').AsFloat;
      cdsResumo.FieldByName('TSN_TOTSNC').AsFloat  := FieldByName('TSN_TOTSNC').AsFloat;
      cdsResumo.FieldByName('TSN_ALQCBS').AsFloat  := FieldByName('TSN_ALQCBS').AsFloat;
      cdsResumo.FieldByName('TSN_ALQIBS').AsFloat  := FieldByName('TSN_ALQIBS').AsFloat;

      cdsResumo.FieldByName('TSN_TOTTRB').AsFloat := 0;
      cdsResumo.FieldByName('TSN_TOTRET').AsFloat := 0;
      cdsResumo.FieldByName('TSN_TOTISE').AsFloat := 0;
      cdsResumo.FieldByName('TSN_TOTISS').AsFloat := 0;
      cdsResumo.FieldByName('TSN_TOTISR').AsFloat := 0;

      Case (tsTipoTabela) Of
        tsComercio  :
          Begin
            cdsResumo.FieldByName('TSN_TOTTRB').AsFloat := fStrToFloat(edtFatProdTribComercio.Text);
            cdsResumo.FieldByName('TSN_TOTRET').AsFloat := fStrToFloat(edtFatProdRetComercio.Text);
            cdsResumo.FieldByName('TSN_TOTISE').AsFloat := fStrToFloat(edtFatProdIsentoComercio.Text);
          End;

        tsIndustria :
          Begin
            cdsResumo.FieldByName('TSN_TOTTRB').AsFloat := fStrToFloat(edtFatProdTribIndustria.Text);
            cdsResumo.FieldByName('TSN_TOTRET').AsFloat := fStrToFloat(edtFatProdRetIndustria.Text);
            cdsResumo.FieldByName('TSN_TOTISE').AsFloat := fStrToFloat(edtFatProdIsentoIndustria.Text);
          End;

        tsIndustriaSimples :
          Begin
            cdsResumo.FieldByName('TSN_TOTTRB').AsFloat := fStrToFloat(edtFatProdTribIndustriaSimples.Text);
            cdsResumo.FieldByName('TSN_TOTRET').AsFloat := fStrToFloat(edtFatProdRetIndustriaSimples.Text);
//            cdsResumo.FieldByName('TSN_TOTISE').AsFloat := fStrToFloat(edtFatProdIsentoIndustria.Text);
          End;

        tsServicoIII:
          Begin
            cdsResumo.FieldByName('TSN_TOTISS').AsFloat := fStrToFloat(edtFatServServicosIIIIss.Text);
            cdsResumo.FieldByName('TSN_TOTISR').AsFloat := fStrToFloat(edtFatServServicosIIIIssRet.Text);
          End;

        tsServicoIV :
          Begin
            cdsResumo.FieldByName('TSN_TOTISS').AsFloat := fStrToFloat(edtFatServServicosIVIss.Text);
            cdsResumo.FieldByName('TSN_TOTISR').AsFloat := fStrToFloat(edtFatServServicosIVIssRet.Text);
          End;

        tsServicoVA :
          Begin
            cdsResumo.FieldByName('TSN_TOTISS').AsFloat := fStrToFloat(edtFatServServicosVAIss.Text);
            cdsResumo.FieldByName('TSN_TOTISR').AsFloat := fStrToFloat(edtFatServServicosVAIssRet.Text);
          End;
      End;

      cdsResumo.Post();
    End;
  end;

begin
  Try
    fltRecBruta := fStrToFloat(edtReceitaBruta.Text);

    If (Assigned(cdsComercio)) Then Begin
      cdsComercio.DisableControls();
      cdsComercio.First();

      While (Not cdsComercio.Eof) Do Begin
        If (cdsComercio.FieldByName('TSN_LIMINF').AsFloat <= fltRecBruta) And
           (cdsComercio.FieldByName('TSN_LIMSUP').AsFloat >= fltRecBruta) Then Begin
          pAdicionarRegistro('Anexo I', tsComercio);
          Break;
        End;

        cdsComercio.Next();
      End;
    End;

    If (Assigned(cdsIndustria)) Then Begin
      cdsIndustria.DisableControls();
      cdsIndustria.First();

      While (Not cdsIndustria.Eof) Do Begin
        If (cdsIndustria.FieldByName('TSN_LIMINF').AsFloat <= fltRecBruta) And
           (cdsIndustria.FieldByName('TSN_LIMSUP').AsFloat >= fltRecBruta) Then Begin
          pAdicionarRegistro('Anexo II', tsIndustria);
          Break;
        End;

        cdsIndustria.Next();
      End;
    End;
    If (Assigned(cdsIndustriaSimples)) Then Begin
      cdsIndustriaSimples.DisableControls();
      cdsIndustriaSimples.First();

      While (Not cdsIndustria.Eof) Do Begin
        If (cdsIndustriaSimples.FieldByName('TSN_LIMINF').AsFloat <= fltRecBruta) And
           (cdsIndustriaSimples.FieldByName('TSN_LIMSUP').AsFloat >= fltRecBruta) Then Begin
          pAdicionarRegistro('Anexo V-I', tsIndustriaSimples);
          Break;
        End;

        cdsIndustriaSimples.Next();
      End;
    End;


    If (Assigned(cdsServicosIII)) Then Begin
      cdsServicosIII.DisableControls();
      cdsServicosIII.First();

      While (Not cdsServicosIII.Eof) Do Begin
        If (cdsServicosIII.FieldByName('TSN_LIMINF').AsFloat <= fltRecBruta) And
           (cdsServicosIII.FieldByName('TSN_LIMSUP').AsFloat >= fltRecBruta) Then Begin
          pAdicionarRegistro('Anexo III', tsServicoIII);
          Break;
        End;

        cdsServicosIII.Next();
      End;
    End;

    If (Assigned(cdsServicosIV)) Then Begin
      cdsServicosIV.DisableControls();
      cdsServicosIV.First();

      While (Not cdsServicosIV.Eof) Do Begin
        If (cdsServicosIV.FieldByName('TSN_LIMINF').AsFloat <= fltRecBruta) And
           (cdsServicosIV.FieldByName('TSN_LIMSUP').AsFloat >= fltRecBruta) Then Begin
          pAdicionarRegistro('Anexo IV', tsServicoIV);
          Break;
        End;

        cdsServicosIV.Next();
      End;
    End;

    If (Assigned(cdsServicosVA)) Then Begin
      cdsServicosVA.DisableControls();
      cdsServicosVA.First();

      While (Not cdsServicosVA.Eof) Do Begin
        If (cdsServicosVA.FieldByName('TSN_LIMINF').AsFloat <= fltRecBruta) And
           (cdsServicosVA.FieldByName('TSN_LIMSUP').AsFloat >= fltRecBruta) Then Begin
          pAdicionarRegistro('Anexo V-A', tsServicoVA);
          Break;
        End;

        cdsServicosVA.Next();
      End;
    End;

  Finally
    If (Assigned(cdsComercio))    Then cdsComercio.EnableControls();
    If (Assigned(cdsIndustria))   Then cdsIndustria.EnableControls();
    If (Assigned(cdsIndustriaSimples))   Then cdsIndustriaSimples.EnableControls();
    If (Assigned(cdsServicosIII)) Then cdsServicosIII.EnableControls();
    If (Assigned(cdsServicosIV))  Then cdsServicosIV.EnableControls();
    If (Assigned(cdsServicosVA))  Then cdsServicosVA.EnableControls();
  End;
end;

procedure TfrmRelSimplesNacional.pRealizarApuracao;
  Var
    fltSoma, fltMesAtual: Double;

  function fSomarBasesCalculo: Double; begin
    Result := RoundTo(
                fStrToFloat(edtFatProdTribComercio.Text) +
                fStrToFloat(edtFatProdRetComercio.Text) +
                fStrToFloat(edtFatProdIsentoComercio.Text) +
                fStrToFloat(edtFatProdTribIndustria.Text) +
                fStrToFloat(edtFatProdRetIndustria.Text) +
                fStrToFloat(edtFatProdIsentoIndustria.Text) +
                fStrToFloat(edtFatServServicosIIIIss.Text) +
                fStrToFloat(edtFatServServicosIVIss.Text) +
                fStrToFloat(edtFatServServicosVAIss.Text) +
                fStrToFloat(edtFatServServicosIIIIssRet.Text) +
                fStrToFloat(edtFatServServicosIVIssRet.Text) +
                fStrToFloat(edtFatServServicosVAIssRet.Text), -2);
  end;

begin
  If (Not chkCalculoManual.Checked) Then
    pLimparEditsAbas();

  //validar campos
  If (Not fVerificaCampos()) Then Exit;

  If (fStrToFloat(edtFatMesAtual.Text) = 0) Then Begin
    fMensagem('ATENÇÃO!', 'Valor do faturamento do mês de apuração deve ser maior que zero!', ['&OK']);
    pSetFocus(edtFatMesAtual);

    tshResumo.TabVisible := False;
    tshComercio.Show();

    Exit;
  End;

  If (fStrToFloat(edtReceitaBruta.Text) = 0) Then Begin
    fMensagem('ATENÇÃO!', 'Receita Bruta deve ser maior que zero para realizar a apuração dos impostos!', ['&OK']);
    pSetFocus(edtReceitaBruta);

    tshResumo.TabVisible := False;
    tshComercio.Show();

    Exit;
  End;

  If (Not fValorMaximoEnquadramentoSimples()) Then Begin
    fMensagem('ATENÇÃO!', 'Receita Bruta apurada é maior que o máximo permitido para enquadramento no Simples Nacional!', ['&OK']);
    pSetFocus(edtReceitaBruta);

    tshResumo.TabVisible := False;
    tshComercio.Show();

    Exit;
  End;

  //carregar dados tabela Comércio
  If (Not
       (
         fCalcularValorVendaTribRet(tsComercio) And
         fCarregarDadosTabela(tsComercio) And
         fCalcularImposto(tsComercio)
       )
     ) Then Begin
    fMensagem('ATENÇÃO!', 'Houve um problema na apuração da tabela de Comércio. Operação cancelada!', ['&OK']);
    Exit;
  End;

  //carregar dados tabela Indústria
  If (Not
       (
         fCalcularValorVendaTribRet(tsIndustria) And
         fCarregarDadosTabela(tsIndustria) And
         fCalcularImposto(tsIndustria)
       )
     ) Then Begin
    fMensagem('ATENÇÃO!', 'Houve um problema na apuração da tabela de Indústria. Operação cancelada!', ['&OK']);
    Exit;
  End;


  If (Not
       (
         fCalcularValorVendaTribRet(tsIndustriaSimples) And
         fCarregarDadosTabela(tsIndustriaSimples) And
         fCalcularImposto(tsIndustriaSimples)
       )
     ) Then Begin
    fMensagem('ATENÇÃO!', 'Houve um problema na apuração da tabela de Indústria Simples. Operação cancelada!', ['&OK']);
    Exit;
  End;

  //carregar dados tabela Serviço III
  If (tshServicosIII.TabVisible) And
     (Not
       (
         fCalcularValorVendaTribRet(tsServicoIII) And
         fCarregarDadosTabela(tsServicoIII) And
         fCalcularImposto(tsServicoIII)
       )
     ) Then Begin
    fMensagem('ATENÇÃO!', 'Houve um problema na apuração da tabela de Serviços (Anexo III). Operação cancelada!', ['&OK']);
    Exit;
  End;

  //carregar dados tabela Serviço IV
  If (tshServicosIV.TabVisible) And
     (Not
       (
         fCalcularValorVendaTribRet(tsServicoIV) And
         fCarregarDadosTabela(tsServicoIV) And
         fCalcularImposto(tsServicoIV)
       )
     ) Then Begin
    fMensagem('ATENÇÃO!', 'Houve um problema na apuração da tabela de Serviços (Anexo IV). Operação cancelada!', ['&OK']);
    Exit;
  End;

  //carregar dados tabela Serviço V-A
  If (tshServicosVA.TabVisible) And
     (Not
       (
         fCalcularValorVendaTribRet(tsServicoVA) And
         fCarregarDadosTabela(tsServicoVA) And
         fCalcularImposto(tsServicoVA)
       )
     ) Then Begin
    fMensagem('ATENÇÃO!', 'Houve um problema na apuração da tabela de Serviços (Anexo V-A). Operação cancelada!', ['&OK']);
    Exit;
  End;

  fltSoma     := fSomarBasesCalculo();
  fltMesAtual := RoundTo(fStrToFloat(edtFatMesAtual.Text), -2);

  If (fltSoma <> fltMesAtual) Then Begin
    fMensagem('ATENÇÃO!', 'A soma das bases de cálculo não confere com o valor do faturamento do mês de apuração. Verifique!', ['&OK']);
    pLimparClientsDataSet();
    pSetFocus(edtMeses);

    tshResumo.TabVisible := False;

    tshComercio.Show();
  End Else Begin
    pCriarResumoApuracao();

    tshResumo.TabVisible := True;
    tshResumo.Show();
  End;
end;

procedure TfrmRelSimplesNacional.pSomarImpostosResumo;
  Var
    fltSoma: Double;
begin
  fltSoma := 0;

  If (Assigned(cdsComercio))    Then
    fltSoma := fltSoma + cdsComercio.FieldByName('TSN_TOTSNC').AsFloat;

  If (Assigned(cdsIndustria))   Then
    fltSoma := fltSoma + cdsIndustria.FieldByName('TSN_TOTSNC').AsFloat;

//  If (Assigned(cdsIndustria))   Then
//    fltSoma := fltSoma + cdsIndustria.FieldByName('TSN_TOTSNC').AsFloat;

  If (Assigned(cdsServicosIII)) Then
    fltSoma := fltSoma + cdsServicosIII.FieldByName('TSN_TOTSNC').AsFloat;

  If (Assigned(cdsServicosIV))  Then
    fltSoma := fltSoma + cdsServicosIV.FieldByName('TSN_TOTSNC').AsFloat;

  If (Assigned(cdsServicosVA))  Then
    fltSoma := fltSoma + cdsServicosVA.FieldByName('TSN_TOTSNC').AsFloat;

  edtTotalRecolher.Text := FormatFloat('#,##0.00', fltSoma);
end;

end.
