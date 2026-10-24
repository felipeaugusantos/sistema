  unit untCadCampanhaVendas;

interface

uses
  Windows, Classes, Controls, Forms, untPai, Menus, StdCtrls, Buttons, ExtCtrls,
  untCamGer, Mask, DBCtrls, DBGridCitel, DBGrids, DB, EditFocus, DBEditFocus, UniClientDataSet, Uni,
  MaskEditFocus, ComCtrls, AppEvnts, BitBtnLockedIncrem, Grids, System.StrUtils,
  Datasnap.DBClient, frxClass, frxExportCSVTestabilidade, QColorLabel, System.Variants,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, System.DateUtils,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, cxProgressBar, Vcl.Graphics,
  cxCurrencyEdit, cxTextEdit, untTSelecionaTinta, untCfgGrid, untLayoutImportacaoProdutosCampanhaVendas,
  Vcl.Dialogs, cxGridCitel, System.MaskUtils, untFuncoesGenerica,
  System.Generics.Collections, untTypesSistema, untFuncoesConsulta;

Type
  TOperacao = (opConsulta, opInclusao, opAlteracao);

Type
  TDadosCliente = record
    strCodCli : String;
    strNomCli : String;
    strCodAti : String;
    strDesAti : String;
    strCodCid : String;
    strCidEst : String;
    strDesCid : String;
    strDesEst : String;
    strCodReg : String;
    strDesReg : String;
    strCodSub : String;
    strDesSub : String;
    strCodRed : String;
    strDesRed : String;
    strCodCac : String;
    strDesCac : String;
    strCgcCpf : String;
    strNuCnpj : String;
    strCgcMas : String;
    strCatego : String;
  end;


type
  TfrmCadCampanhaVendas = class(TfrmPai)
    pnlCampanha: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtDesCmg: TEditFocus;
    edtCodCmg: TEditFocus;
    pgcDados: TPageControl;
    tbsProdutos: TTabSheet;
    tbsGenerica: TTabSheet;
    pnlProdutos: TPanel;
    lblQtdIte: TLabel;
    lblPreco: TLabel;
    Label19: TLabel;
    edtCodIte: TEditFocus;
    edtQtdIte: TEditFocus;
    edtVlrIte: TEditFocus;
    edtDesIte: TEditFocus;
    edtTotQtdPre: TEditFocus;
    pnlResumo1: TPanel;
    lblTotFat: TLabel;
    dbeTotFat: TDBEditFocus;
    pnlGenerica: TPanel;
    lblOpcao: TLabel;
    Label26: TLabel;
    edtCodOpc: TEditFocus;
    edtVlrFat: TEditFocus;
    edtDesOpc: TEditFocus;
    rdgOpcao: TRadioGroup;
    Label20: TLabel;
    btnCancelaItem: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    btnGenCancelaItem: TBitBtnLocked;
    btnGenAdicionar: TBitBtnLocked;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    btnPesquisa: TBitBtnLocked;
    mskDtaIni: TMaskEditFocus;
    Label16: TLabel;
    Label17: TLabel;
    mskDtaFin: TMaskEditFocus;
    Label37: TLabel;
    ColorLabel1: TColorLabel;
    edtAtiva: TEditFocus;
    dbgProdutosTV: TcxGridDBTableView;
    dbgProdutosLevel1: TcxGridLevel;
    dbgProdutos: TcxGrid;
    dbgProdutosTVCODITE: TcxGridDBColumn;
    dbgProdutosTVDESITE: TcxGridDBColumn;
    dbgProdutosTVQTDITE: TcxGridDBColumn;
    dbgProdutosTVVLRUNI: TcxGridDBColumn;
    dbgGenerica: TcxGrid;
    dbgGenericaDB: TcxGridDBTableView;
    dbgGenericaDBCODOPC: TcxGridDBColumn;
    dbgGenericaDBDESOPC: TcxGridDBColumn;
    dbgGenericaDBVLRFAT: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    mskLinhaGrupo: TMaskEditFocus;
    Label10: TLabel;
    Label11: TLabel;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    edtDesGrupo: TEditFocus;
    lblDescricao: TLabel;
    edtDescriIni: TEditFocus;
    edtRefere: TEditFocus;
    Label21: TLabel;
    Label22: TLabel;
    edtUnidade: TEditFocus;
    edtDescriFin: TEditFocus;
    Label23: TLabel;
    Label24: TLabel;
    edtFornecedor: TEditFocus;
    Label25: TLabel;
    edtDesFornecedor: TEditFocus;
    Label4: TLabel;
    edtClaIPI: TEditFocus;
    Bevel1: TBevel;
    lblClaCrm: TLabel;
    ColorLabel9: TColorLabel;
    edtClaCRM: TEditFocus;
    lblPreCus: TLabel;
    edtPreCus: TEditFocus;
    dbgProdutosTVPRECUS: TcxGridDBColumn;
    dbgProdutosTVCORSIT: TcxGridDBColumn;
    dbgProdutosTVNOMFOR: TcxGridDBColumn;
    dbgProdutosTVDEPDES: TcxGridDBColumn;
    dbgProdutosTVGICPMD: TcxGridDBColumn;
    dbgProdutosTVULTVEN: TcxGridDBColumn;
    dbgProdutosTVMARGEM: TcxGridDBColumn;
    dbgProdutosTVCUSCTR: TcxGridDBColumn;
    dbgProdutosTVMARLIQ: TcxGridDBColumn;
    dbgProdutosTVRESLIQ: TcxGridDBColumn;
    dbgProdutosTVRLIQGI: TcxGridDBColumn;
    dbgProdutosTVRLIQQT: TcxGridDBColumn;
    tbsAnalise: TTabSheet;
    dbgProdutosAnalise: TcxGrid;
    dbgAnaliseTV: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    dbgAnaliseTVCORSIT: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    dbgAnaliseTVQTDITE: TcxGridDBColumn;
    cxGridDBVLRUNI: TcxGridDBColumn;
    cxGridDBCUSCTRA: TcxGridDBColumn;
    cxGridDBMARLIQA: TcxGridDBColumn;
    dbgAnaliseTVRLIQAC: TcxGridDBColumn;
    dbgAnaliseTVRLIQQT: TcxGridDBColumn;
    dbgAnaliseTVRESPER: TcxGridDBColumn;
    dbgProdutosAnaliseLevel1: TcxGridLevel;
    btnReajuste: TBitBtnLocked;
    rdgGlobal: TRadioGroup;
    cxGridDBVENPER: TcxGridDBColumn;
    cxGridDBPEROBJ: TcxGridDBColumn;
    cxGridDBColumn20: TcxGridDBColumn;
    rdgGiro: TRadioGroup;
    cxGridDBPERACT: TcxGridDBColumn;
    cxGridDBULTPRE: TcxGridDBColumn;
    cxGridDBMARGEMA: TcxGridDBColumn;
    Panel1: TPanel;
    edtTotRLIQAC: TEditFocus;
    Label27: TLabel;
    edtTotRLIQQT: TEditFocus;
    Label28: TLabel;
    edtTotRESPER: TEditFocus;
    Label6: TLabel;
    edtTotMARGEM: TEditFocus;
    Label7: TLabel;
    Label8: TLabel;
    edtTotMARLIQ: TEditFocus;
    Label9: TLabel;
    edtTotMARPER: TEditFocus;
    lblSitPro: TLabel;
    edtCodSit: TEditFocus;
    edtDesSit: TEditFocus;
    btnHeranca: TBitBtnLocked;
    btnImportar: TBitBtnLocked;
    dbgProdutosTVNVLGIR: TcxGridDBColumn;
    dbgProdutosTVNVLCRI: TcxGridDBColumn;
    dbgProdutosTVESTMIN: TcxGridDBColumn;
    dbgProdutosTVESTMAX: TcxGridDBColumn;
    pgcCampanha: TPageControl;
    tbsGeral: TTabSheet;
    tbsCondPagto: TTabSheet;
    pnlCamCnd: TPanel;
    lblCndPag: TLabel;
    Label29: TLabel;
    btnIncCli: TBitBtnLocked;
    btnCancelCli: TBitBtnLocked;
    edtForPag: TEditFocus;
    edtDesPag: TEditFocus;
    edtCodCnd: TEditFocus;
    edtDesCnd: TEditFocus;
    cxgGridCamCnd: TcxGrid;
    cxgGridCamCndView: TcxGridDBTableView;
    cxgColCodCnd: TcxGridDBColumn;
    cxgColDescri: TcxGridDBColumn;
    cxgColCndPag: TcxGridDBColumn;
    cxgCamCnd: TcxGridLevel;
    btnTintaMaquina: TSpeedButton;
    dbgProdutosTVITETIN: TcxGridDBColumn;
    lblCodProdCliente: TLabel;
    edtCodProdCliente: TEditFocus;
    dbgProdutosTVCODPCL: TcxGridDBColumn;
    pnlDadosAdicionais: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label18: TLabel;
    Label15: TLabel;
    edtObs1: TEditFocus;
    edtObs2: TEditFocus;
    edtObs3: TEditFocus;
    edtBrinde: TEditFocus;
    mskDtaEnt: TMaskEditFocus;
    btnCfgGrids: TBitBtnLocked;
    btnImportarProdCampanha: TBitBtnLocked;
    btnHlpImp: TBitBtnLocked;
    frxHelp: TfrxReport;
    tbsClientes: TTabSheet;
    pnlPesqCli: TPanel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lblCategoria: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    edtCodAti: TEditFocus;
    edtDesAti: TEditFocus;
    edtCodCid: TEditFocus;
    edtDesCid: TEditFocus;
    edtDesEst: TEditFocus;
    edtCgcCpf: TEditFocus;
    edtNuCnPj: TMaskEditFocus;
    btnFiltrar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    cbxCatego: TComboBox;
    edtCodReg: TEditFocus;
    edtDesReg: TEditFocus;
    edtCodSub: TEditFocus;
    edtDesSub: TEditFocus;
    edtCodRed: TEditFocus;
    edtDesRed: TEditFocus;
    edtCodCac: TEditFocus;
    edtDesCac: TEditFocus;
    cxgClientes: TcxGridCitel;
    cxgClientesDBTableView1: TcxGridDBTableViewCitel;
    cxgClientesDBTableView1Column1: TcxGridDBColumn;
    cxgClientesDBTableView1Column2: TcxGridDBColumn;
    cxgClientesDBTableView1Column5: TcxGridDBColumn;
    cxgClientesDBTableView1Column7: TcxGridDBColumn;
    cxgClientesDBTableView1Column4: TcxGridDBColumn;
    cxgClientesDBTableView1Column3: TcxGridDBColumn;
    cxgClientesDBTableView1Column6: TcxGridDBColumn;
    cxgClientesLevel1: TcxGridLevel;
    dsCliCamp: TDataSource;
    cdsCliCamp: TUniClientDataSet;
    cdsCliCampCCM_CODCLI: TStringField;
    cdsCliCampCCM_NOMCLI: TStringField;
    cdsCliCampCCM_DESATI: TStringField;
    cdsCliCampCCM_CIDEST: TStringField;
    cdsCliCampCCM_CPFMAS: TStringField;
    cdsCliCampCCM_CATEGO: TStringField;
    cdsCliCampCCM_REDLOJ: TStringField;
    lblPreClq: TLabel;
    edtPreClq: TEditFocus;
    dbgProdutosTVPRECLQ: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure edtCodCmgKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCmgExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodRedKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRedExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure edtQtdIteExit(Sender: TObject);
    procedure edtVlrIteExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodOpcKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOpcExit(Sender: TObject);
    procedure btnGenAdicionarClick(Sender: TObject);
    procedure btnGenCancelaItemClick(Sender: TObject);
    procedure rdgOpcaoClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgProdutosTVKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgGenericaDBKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure dbgProdutosTVCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure mskDtaIniEnter(Sender: TObject);
    procedure mskDtaFinEnter(Sender: TObject);
    procedure edtAtivaExit(Sender: TObject);
    procedure btnReajusteClick(Sender: TObject);
    procedure rdgGiroClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgAnaliseTVCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure edtCodSitKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodSitExit(Sender: TObject);
    procedure btnHerancaClick(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure edtForPagKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelCliClick(Sender: TObject);
    procedure btnIncCliClick(Sender: TObject);
    procedure cxgGridCamCndViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnTintaMaquinaClick(Sender: TObject);
    procedure edtCodIteChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pgcCampanhaChange(Sender: TObject);
    procedure btnCfgGridsClick(Sender: TObject);
    procedure btnImportarProdCampanhaClick(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
    procedure edtCodAtiExit(Sender: TObject);
    procedure edtCodCidExit(Sender: TObject);
    procedure edtCodRegExit(Sender: TObject);
    procedure edtCodSubExit(Sender: TObject);
    procedure edtCodCacExit(Sender: TObject);
    procedure edtCgcCpfChange(Sender: TObject);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodSubKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCacKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure cdsCliCampCalcFields(DataSet: TDataSet);
    procedure cxgClientesDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }

    objCamGer: TCamGer;
    strNomPro: String;
    strRefere: String;
    strMarca : String;
    strUnidad: String;

    strGenExcluidos : String;
    strCndExcluidos : String;
    strCodCmgAnt: String;

    strIdePro,
    strIteTin,
    strTinDes : String;
    fltTinVol: Double;

    blnAltPorFator,
    blnAltGlobal,
    blnBuscaCampanhaPorCodigo: Boolean;
    strCodCmgHer : String;

    strImpNumDoc : String;
    strImpEspDoc : String;
    strImpCodEmp : String;
    strImpTabela : String;
    strImpPrefix : String;
    blnZerarCustos : Boolean;

    cdsProdutos: TUniClientDataSet;
    dtsProdutos: TDataSource;
    cdsCamCnd  : TUniClientDataSet;
    dtsCamCnd  : TDataSource;

    cdsGenerica: TUniClientDataSet;
    dtsGenerica: TDataSource;

    FcdsProdutosExcluidos : TUniClientDataSet;

    qryConFpg: TUniQuery;
    qryCamCnd: TUniQuery;

    intRecNoProdutos: Integer;
    objCfgGridProdutos: TCfgGrid;
    intRecNoGenerica: Integer;
    objCfgGridGenerica: TCfgGrid;
    intRecNoAnalise: Integer;
    objCfgGridAnalise: TCfgGrid;

    blnInseriu: Boolean;

    arrClientes : TConsultasArray;
    arrAti      : TConsultasArray;
    arrCid      : TConsultasArray;
    arrReg      : TConsultasArray;
    arrSub      : TConsultasArray;
    arrRed      : TConsultasArray;
    arrCac      : TConsultasArray;

    function fCalculaQtdPreco(fltQtdIte, fltVlrIte: Double): Double;
    function fConsisteSimilaridade(strCodIte: String): Boolean;
    function fAdicionaItens(pgbStatus: TcxProgressBar): Boolean;
    function fCriaCdsProdutos(AOwner: TComponent): TUniClientDataSet;
    function fCriaCdsGenerica(AOwner: TComponent): TUniClientDataSet;
    function fCriaCdsProdutosExcluidos(AOwner: TComponent): TUniClientDataSet;
    function fConfirmaImportacaoDocumento(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
    function fMesesGiro: Integer;
    function fProdutoFiltrado: Boolean;
    function fEfetuaAlteracaoGlobal(pgbStatus: TcxProgressBar): Boolean;
    function fCriaCdsCondicao(AOwner: TComponent): TUniClientDataSet;

    procedure pLimpaEdits(blnCampanha: Boolean = False; blnProdutos: Boolean = False;
    blnDadosAdicionais: Boolean = False; blnGenerica: Boolean = False);
    procedure pCarregaItensProdutos;
    procedure pCarregaItensGenerica;
    procedure pCancelarDados;
    procedure pTotalizaRodape;
    procedure pAtualizaDadosGenerica(DataSet: TDataSet);
    procedure pHabilitaFuncao(opFuncao : TOperacao);
    procedure pAtualizaCampos(blnLimpa : Boolean);
    procedure pCancelaAltGlobal;
    procedure pBeforePost(DataSet: TDataSet);
    procedure pCalculaValores;
    procedure pRecalculaValores;
    procedure pCarregaForPag;
    procedure pCarregaCondicaoPagamento(strCodCmg: String);
    procedure pIncluiCondicaoPagamento;
    procedure pGravaCondicaoPagamento;
    procedure pApagaRegistroTabela(strTabela, strCampo: String);
    function  fCodProdCliJaCadastrado(strCodIte, strCodProcCli : String): Boolean;
    function fValidaCodProdCliente : Boolean;
    function fGetChaveLayoutGridProdutos: String;
    function fGetChaveLayoutGridGenerica: String;
    function fGetChaveLayoutGridAnalise: String;

    procedure AposCarregarLinhaPlanilha(Linha: TLinha; var PararProcessamento: Boolean);

    function fBuscarDadosCliente(strCodCli: String):TDadosCliente;
    procedure pBuscarDadosClienteFiltro(strCodCli: String);
    procedure pInsereClientes();
    function fInsereClientes(pgbStatus: TcxProgressBar = Nil):Boolean;
    procedure pCarregaClientes(lstClientes : TList<String>);

  protected

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pEscapePressed; override;

  public
    { Public declarations }
  end;

implementation

uses SysUtils, untFuncoesSimples, untRedeLojas, untConsultas,
  untGravando, untConstantes, untHerancaCampanha, untDigDocumentoEmpresa,
  untPesqAux, untFuncoes, untFatVendasCalculadorWrapper, untFuncTinta,
  untFuncFat;

{$R *.dfm}

function TfrmCadCampanhaVendas.fBuscarDadosCliente(strCodCli: String): TDadosCliente;
Var
  qryCli : TUniQuery;
begin
  inherited;

  qryCli := fCriaQuery();
  Try
    qryCli.SQL.Add('  SELECT                                                ');
    qryCli.SQL.Add('    CC.CLI_CODCLI CODCLI,                               ');
    qryCli.SQL.Add('    CC.CLI_NOMCLI NOMCLI,                               ');
    qryCli.SQL.Add('    CC.CLI_CODATI CODATI,                               ');
    qryCli.SQL.Add('    CA.ATI_DESATI DESATI,                               ');
    qryCli.SQL.Add('    CC.CLI_CODCID CODCID,                               ');
    qryCli.SQL.Add('    CD.CID_NOMCID NOMCID,                               ');
    qryCli.SQL.Add('    CD.CID_ESTADO ESTADO,                               ');
    qryCli.SQL.Add('    CONCAT(CD.CID_NOMCID, " - ", CD.CID_ESTADO) CIDEST, ');
    qryCli.SQL.Add('    CC.CLI_CGCCPF CGCCPG,                               ');
    qryCli.SQL.Add('    CC.CLI_C_G_C_ C_G_C_,                               ');
    qryCli.SQL.Add('    CC.CLI_CATEGO CATEGO,                               ');
    qryCli.SQL.Add('    CC.CLI_CODRED CODRED,                               ');
    qryCli.SQL.Add('    CR.RED_DESRED DESRED,                               ');
    qryCli.SQL.Add('    CC.CLI_CODREG CODREG,                               ');
    qryCli.SQL.Add('    RG.REG_DESREG DESREG,                               ');
    qryCli.SQL.Add('    CC.CLI_CODSUB CODSUB,                               ');
    qryCli.SQL.Add('    SR.SUB_DESSUB DESSUB,                               ');
    qryCli.SQL.Add('    CC.CLI_CODCAC CODCAC,                               ');
    qryCli.SQL.Add('    CN.CAC_NOMCAC DESCAC                                ');
    qryCli.SQL.Add('  FROM                                                  ');
    qryCli.SQL.Add('    CADCLI CC                                           ');
    qryCli.SQL.Add('  LEFT JOIN                                             ');
    qryCli.SQL.Add('    CADCID CD ON (CC.CLI_CODCID = CD.CID_CODCID)        ');
    qryCli.SQL.Add('  LEFT JOIN                                             ');
    qryCli.SQL.Add('    CADATI CA ON (CC.CLI_CODATI = CA.ATI_CODATI)        ');
    qryCli.SQL.Add('  LEFT JOIN                                             ');
    qryCli.SQL.Add('    CADRED CR ON (CC.CLI_CODRED = CR.RED_CODRED)        ');
    qryCli.SQL.Add('  LEFT JOIN                                             ');
    qryCli.SQL.Add('    CADREG RG ON (CC.CLI_CODREG = RG.REG_CODREG)        ');
    qryCli.SQL.Add('  LEFT JOIN                                             ');
    qryCli.SQL.Add('    CADSUB SR ON (CC.CLI_CODSUB = SR.SUB_CODSUB)        ');
    qryCli.SQL.Add('  LEFT JOIN                                             ');
    qryCli.SQL.Add('    CADCAC CN ON (CC.CLI_CODCAC = CN.CAC_CODCAC)        ');
    qryCli.SQL.Add('  WHERE                                                 ');
    qryCli.SQL.Add('    CC.CLI_CODCLI=:CODCLI                               ');

    qryCli.ParamByName('CODCLI').AsString := strCodCli;
    qryCli.Open;

    If (Not qryCli.IsEmpty) Then
    Begin
      Result.strCodCli := qryCli.FieldByName('CODCLI').AsString;
      Result.strNomCli := qryCli.FieldByName('NOMCLI').AsString;
      Result.strCodAti := qryCli.FieldByName('CODATI').AsString;
      Result.strDesAti := qryCli.FieldByName('DESATI').AsString;
      Result.strCodCid := qryCli.FieldByName('CODCID').AsString;
      Result.strCidEst := qryCli.FieldByName('CIDEST').AsString;
      Result.strDesCid := qryCli.FieldByName('NOMCID').AsString;
      Result.strDesEst := qryCli.FieldByName('ESTADO').AsString;
      Result.strCodReg := qryCli.FieldByName('CODREG').AsString;
      Result.strDesReg := qryCli.FieldByName('DESREG').AsString;
      Result.strCodSub := qryCli.FieldByName('CODSUB').AsString;
      Result.strDesSub := qryCli.FieldByName('DESSUB').AsString;
      Result.strCodRed := qryCli.FieldByName('CODRED').AsString;
      Result.strDesRed := qryCli.FieldByName('DESRED').AsString;
      Result.strCodCac := qryCli.FieldByName('CODCAC').AsString;
      Result.strDesCac := qryCli.FieldByName('DESCAC').AsString;
      Result.strCgcCpf := qryCli.FieldByName('CGCCPG').AsString;
      Result.strNuCnpj := qryCli.FieldByName('C_G_C_').AsString;
      Result.strCatego := qryCli.FieldByName('CATEGO').AsString;

      If (Length(Result.strNuCnpj) = 14) Then
        Result.strCgcMas := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), Result.strNuCnpj)
      Else If (Length(Result.strNuCnpj) = 11) Then
        Result.strCgcMas := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_P_F_), Result.strNuCnpj)
      Else
        Result.strCgcMas := Result.strNuCnpj;
    End;
  Finally
    FreeAndNil(qryCli);
  End;
end;

procedure TfrmCadCampanhaVendas.pBuscarDadosClienteFiltro(strCodCli: String);
Var
  objDadosCliente : TDadosCliente;
begin
  objDadosCliente := fBuscarDadosCliente(strCodCli);

  If (Not fEmptyStr(objDadosCliente.strCodCli)) Then
  Begin
    edtCodCli.Text := objDadosCliente.strCodCli;
    edtNomCli.Text := objDadosCliente.strNomCli;
    edtCodAti.Text := objDadosCliente.strCodAti;
    edtDesAti.Text := objDadosCliente.strDesAti;
    edtCodCid.Text := objDadosCliente.strCodCid;
    edtDesCid.Text := objDadosCliente.strDesCid;
    edtDesEst.Text := objDadosCliente.strDesEst;
    edtCodReg.Text := objDadosCliente.strCodReg;
    edtDesReg.Text := objDadosCliente.strDesReg;
    edtCodSub.Text := objDadosCliente.strCodSub;
    edtDesSub.Text := objDadosCliente.strDesSub;
    edtCodRed.Text := objDadosCliente.strCodRed;
    edtDesRed.Text := objDadosCliente.strDesRed;
    edtCodCac.Text := objDadosCliente.strCodCac;
    edtDesCac.Text := objDadosCliente.strDesCac;
    edtNuCnPj.Text := objDadosCliente.strNuCnpj;
    edtCgcCpf.Text := objDadosCliente.strCgcCpf;

    cbxCatego.ItemIndex := cbxCatego.Items.IndexOf(objDadosCliente.strCatego);
  End;

end;

procedure TfrmCadCampanhaVendas.pInsereClientes;
begin
  fChamaTelaGravando(fInsereClientes, 'Aguarde, inserindo clientes...');
end;

function TfrmCadCampanhaVendas.fInsereClientes(pgbStatus: TcxProgressBar = Nil): Boolean;
Var
  qryCli : TUniQuery;
  strSQL : String;
begin
  inherited;

  qryCli := fCriaQuery();

  Try
    strSQL := '  SELECT           '+
              '    CC.CLI_CODCLI  '+
              '  FROM             '+
              '    CADCLI CC      '+
              '  WHERE            '+
              '    (TRUE)         ';


    If Not fEmptyStr(edtCodCli.Text) Then
      strSQL := strSQL + '  AND (CC.CLI_CODCLI=:CODCLI)  ';

    If Not fEmptyStr(edtCodAti.Text) Then
      strSQL := strSQL + '  AND (CC.CLI_CODATI=:CODATI)  ';

    If Not fEmptyStr(edtCodCid.Text) Then
      strSQL := strSQL + '  AND (CC.CLI_CODCID=:CODCID)  ';

    If Not fEmptyStr(edtCodReg.Text) Then
      strSQL := strSQL + '  AND (CC.CLI_CODREG=:CODREG)  ';

    If Not fEmptyStr(edtCodSub.Text) Then
      strSQL := strSQL + '  AND (CC.CLI_CODSUB=:CODSUB)  ';

    If Not fEmptyStr(edtCodRed.Text) Then
      strSQL := strSQL + '  AND (CC.CLI_CODRED=:CODRED)  ';

    If Not fEmptyStr(edtCodCac.Text) Then
      strSQL := strSQL + '  AND (CC.CLI_CODCAC=:CODCAC)  ';

    If Not fEmptyStr(fTiraCaracEspeciais(edtNuCnPj.Text)) Then
      strSQL := strSQL + '  AND (CC.CLI_C_G_C_=:C_G_C_)  ';

    If Not fEmptyStr(cbxCatego.Items[cbxCatego.ItemIndex]) Then
      strSQL := strSQL + '  AND (CC.CLI_CATEGO=:CATEGO)  ';

    qryCli.SQL.Add(strSQL);

    If Not fEmptyStr(edtCodCli.Text) Then
      qryCli.ParamByName('CODCLI').AsString := edtCodCli.Text;

    If Not fEmptyStr(edtCodAti.Text) Then
      qryCli.ParamByName('CODATI').AsString := edtCodAti.Text;

    If Not fEmptyStr(edtCodCid.Text) Then
      qryCli.ParamByName('CODCID').AsString := edtCodCid.Text;

    If Not fEmptyStr(edtCodReg.Text) Then
      qryCli.ParamByName('CODREG').AsString := edtCodReg.Text;

    If Not fEmptyStr(edtCodSub.Text) Then
      qryCli.ParamByName('CODSUB').AsString := edtCodSub.Text;

    If Not fEmptyStr(edtCodRed.Text) Then
      qryCli.ParamByName('CODRED').AsString := edtCodRed.Text;

    If Not fEmptyStr(edtCodCac.Text) Then
      qryCli.ParamByName('CODCAC').AsString := edtCodCac.Text;

    If Not fEmptyStr(fTiraCaracEspeciais(edtNuCnPj.Text)) Then
      qryCli.ParamByName('C_G_C_').AsString := fTiraCaracEspeciais(edtNuCnPj.Text);

    If Not fEmptyStr(cbxCatego.Items[cbxCatego.ItemIndex]) Then
      qryCli.ParamByName('CATEGO').AsString := cbxCatego.Items[cbxCatego.ItemIndex];

    qryCli.Open;

    If (Not qryCli.IsEmpty) Then
    Begin
      Try
        cdsCliCamp.DisableControls;

        pInfoStatusGravacao(pgbStatus, 'Aguarde, Inserindo Clientes...', qryCli.RecordCount);

        qryCli.First;
        While (Not qryCli.Eof) Do
        Begin
          pStepStatusGravacao(pgbStatus);
          Application.ProcessMessages;

          If (Not cdsCliCamp.Locate('CCM_CODCLI', qryCli.FieldByName('CLI_CODCLI').AsString, [])) Then
          Begin
            cdsCliCamp.Append;
            cdsCliCamp.FieldByName('CCM_CODCLI').AsString := qryCli.FieldByName('CLI_CODCLI').AsString;
            cdsCliCamp.Post;
          End;

          qryCli.Next;
        End;
      Finally
        cdsCliCamp.First;
        cdsCliCamp.EnableControls;
      End;
    End
    Else
      fMensagem('', 'Nenhum Cliente foi encontrado!', ['&OK'], 0);

    Result := True;
  Finally
    FreeAndNil(qryCli);
  End;
end;

procedure TfrmCadCampanhaVendas.pCarregaForPag;
begin
  pPesquisaCadFpg(qryConFpg, qryConFpg, edtForPag.Text);
  edtDesPag.Text := qryConFpg.FieldByName('FPG_DESCRI').AsString;
end;

procedure TfrmCadCampanhaVendas.pCarregaClientes(lstClientes: TList<String>);
Var
  intIndex : Integer;
begin
  Try
    cdsCliCamp.DisableControls;
    cdsCliCamp.EmptyDataSet;


    For intIndex := 0 To PRed(lstClientes.Count) Do
    Begin
      cdsCliCamp.Append;
      cdsCliCamp.FieldByName('CCM_CODCLI').AsString := lstClientes[intIndex];
      cdsCliCamp.Post;
    End;
  Finally
    cdsCliCamp.First;
    cdsCliCamp.EnableControls;
  End;
end;

function TfrmCadCampanhaVendas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA DATA DE ENTREGA                *}
    {**************************************RL*}
    If (Sender = mskDtaEnt) Then
    Begin

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaEnt.Text)) Then
      Try

        StrToDate(mskDtaEnt.Text);

        If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          If StrToDate(mskDtaEnt.Text) < StrToDate(mskDtaFin.Text) Then
          Begin

            fMensagem('ATENÇÃO!', 'A data de entrega deve ser maior ou igual ' + #13 +
                      'a data de término da campanha!', ['&Ok']);
            Result := False;

          End;

      Except

        fMensagem('ATENÇÃO!', 'Data inválida!', ['&Ok']);
        Result := False;

      End;

    End

    {*****************************************}
    {* VALIDA DATA INICIAL                   *}
    {**************************************RL*}
    Else If (Sender = mskDtaIni) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin

        fMensagem('ATENÇÃO!','A data de início da campanha deve ser preenchida!', ['&O k']);
        Result := False;

      End
      Else
      Try

        StrToDate(mskDtaIni.Text);

      Except

        fMensagem('ATENÇÃO!', 'Data inválida!', ['&Ok']);
        Result := False;

      End;

    End

    {*****************************************}
    {* VALIDA DATA DE TÉRMINO DA CAMPANHA    *}
    {**************************************RL*}
    Else If (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin

        fMensagem('ATENÇÃO!','A data de término da campanha deve ser preenchida!', ['&O k']);
        Result := False;

      End
      Else
      Try

        StrToDate(mskDtaFin.Text);

        If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
        Begin

          fMensagem('ATENÇÃO!', 'A data de início deve ser menor ou igual ' + #13 +
                    'a data de término da campanha!', ['&Ok']);
          Result := False;

        End;

      Except

        fMensagem('ATENÇÃO!', 'Data inválida!', ['&Ok']);
        Result := False;

      End;

    End

    {*****************************************}
    {* VALIDA NOME DA CAMPANHA               *}
    {**************************************RL*}
    Else If (Sender = edtDesCmg) Then
    Begin

      If (fEmptyStr(edtDesCmg.Text)) Then
      Begin

        fMensagem('ATENÇÃO!', 'O nome da campanha deve ser preenchido !', ['&Ok']);
        Result := False;

      End

    End

    {*****************************************}
    {* VALIDA BRINDE                         *}
    {**************************************RL*}
    Else If (Sender = edtBrinde) Then
    Begin

      If (fEmptyStr(edtBrinde.Text)) Then
      Begin

        fMensagem('ATENÇÃO!', 'O brinde deve ser preenchido !', ['&Ok']);
        Result := False;

      End

    End

    {*****************************************}
    {* VALIDA QUANTIDADE DO PRODUTO          *}
    {**************************************RL*}
    Else If (Sender = edtQtdIte) Then
    Begin

      If (Not blnAltGlobal) And (fEmptyStr(strCodCmgHer)) And (fEmptyStr(strImpNumDoc)) Then
      Begin
        If fEmptyStr(edtQtdIte.Text) Then
        Begin

          fMensagem('ATENÇÃO!', 'A quantidade do produto deve ser preenchida !', ['&Ok']);
          Result := False;

        End
        Else If fStrToFloat(edtQtdIte.Text) <= 0 Then
        Begin

          fMensagem('ATENÇÃO!', 'A Quantidade deve ser maior que zero!', ['&O k']);
          Result := False;

        End;
      End;
    End

    {*****************************************}
    {* VALIDA CODIGO DO PRODUTO DO CLIENTE   *}
    {**************************************KM*}
    Else If (Sender = edtCodProdCliente) And fCfgSis('CIPCAM', varBoolean) And (edtCodProdCliente.Enabled) Then
    Begin
      If not fEmptyStr(edtCodProdCliente.Text) Then
      Begin
        {VERIFICANDO DENTRO DA CAMPANHA}
        If fCodProdCliJaCadastrado(edtCodIte.Text, edtCodProdCliente.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Código do produto cliente já foi informado nesta campanha em outro produto!', ['&Ok']);
          Result := False;
        End
        {VERIFICANDO EM OUTRA(S) CAMPANHAS}
        Else
        Begin
          Try
            cdsCliCamp.DisableControls;

            cdsCliCamp.First;
            While Not cdsCliCamp.Eof Do
            Begin
              If objCamGer.fVerificaCodigoProdutoCliente(cdsCliCamp.FieldByName('CCM_CODCLI').AsString, edtCodProdCliente.Text, edtCodCmg.Text) <> '-1' Then
              Begin
                fMensagem('ATENÇÃO!', 'Código do produto cliente já foi informado em outra campanha ativa do cliente ou rede do cliente!', ['&Ok']);
                Result := False;
                Break;
              End;
              cdsCliCamp.Next;
            End;
          Finally
            cdsCliCamp.First;
            cdsCliCamp.EnableControls;
          End;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA VALOR DO PRODUTO               *}
    {**************************************RL*}
    Else If (Sender = edtVlrIte) Then
    Begin

      If fEmptyStr(strCodCmgHer) And (fEmptyStr(strImpNumDoc)) Then
      Begin
        If fEmptyStr(edtVlrIte.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O ' + IIF(blnAltGlobal,IIF(blnAltPorFator,'Fator','Valor'),'valor do produto') +  ' deve ser preenchido !', ['&Ok']);
          Result := False;
        End
        Else If fStrToFloat(edtVlrIte.Text) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O valor deve ser maior que Zero!', ['&O k']);
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA OPÇÃO DA CAMPANHA GENÉRICA     *}
    {**************************************RL*}
    Else If (Sender = edtCodOpc) Then
    Begin

      If fEmptyStr(edtCodOpc.Text) Then
      Begin

        If (cdsGenerica.IsEmpty) Then
        Begin
          fMensagem('ATENÇÃO!', 'O código da opção escolhida deve ser preenchido !', ['&Ok']);
          Result := False;
        End
        Else
        begin
          pSetFocus(dbgGenerica);
          blnMudarFoco := False;
        End;

      End;

    End

    {*****************************************}
    {* VALIDA VALOR DO FATURAMENTO           *}
    {**************************************RL*}
    Else If (Sender = edtVlrFat) Then
    Begin

      If fEmptyStr(edtVlrFat.Text) Then
      Begin

        fMensagem('ATENÇÃO!', 'O valor do faturamento deve ser preenchido !', ['&Ok']);
        Result := False;

      End
      Else If fStrToFloat(edtVlrFat.Text) <= 0 Then
      Begin

        fMensagem('ATENÇÃO!', 'O valor do faturamento deve ser maior que zero !', ['&Ok']);
        Result := False;

      End;

    End

    Else If (Sender = edtClaCRM) Then
    Begin

      If Not fEmptyStr(edtClaCRM.Text) Then
      Begin
        If Pos(edtClaCRM.Text,'CPA') <= 0 Then
        Begin
          Result := False;
          fMensagem('', 'O campo classificação oferta de consumíveis deve ser C, P ou A', ['&OK']);
        End;
      End;

    End

    Else If (Sender = edtAtiva) Then
    Begin
      If fEmptyStr(edtAtiva.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe se a campanha está ativa (S/N)!', ['&Ok']);
        Result := False;
      End
      Else If (edtAtiva.Text <> 'S') And (edtAtiva.Text <> 'N') Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe se a campanha está ativa (S/N)!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtCodCnd) Then
    Begin

      If fEmptyStr(edtCodCnd.Text) Then
      Begin
        edtCodCnd.clear;
        edtDesCnd.Clear;
        Result := True;
        blnMudarFoco := False;
        pSetFocus(cxgGridCamCnd);
      End
      Else
      Begin

        If (edtCodCnd.Text <> '000') Then
          edtDesCnd.Text := fRetDesConPag(edtCodCnd.Text);

        If fEmptyStr(edtDesCnd.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa condição não está cadastrada!', ['&Ok']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = edtForPag) Then
    Begin

      If fCfgSis('USAFPG', varBoolean)  Then
      Begin

        If fEmptyStr(edtForPag.Text) Then
        Begin
          fMensagem('','O campo forma de pagamento deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else If fRetornaStatusCadastro(edtForPag.Text, 'FPG', 'CADFPG', 'FPG_CODIGO') <> 'A' Then
        Begin
          fMensagem('ATENÇÃO!', 'Esta forma de pagamento não pode ser utilizada pois está inativa!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          pCarregaForPag;

          If qryConFpg.IsEmpty Then
          Begin
            fMensagem('','Forma de pagamento não encontrada!',['&OK']);
            Result := False;
          End;
        End;

        If Result And SameText(edtForPag.Text, '016') And
           (fStatusCndPag(fRetConPag(edtCodCnd.Text)) <> A_VISTA) Then
        Begin
          fMensagem('','A condição de pagamento deve ser a vista!',['&OK']);
          Result := False;
        End;

      End;

    End
    Else If (Sender = edtCodCli) Then
    Begin

      If (Not fEmptyStr(edtCodCli.Text)) Then
      Begin
        pBuscarDadosClienteFiltro(edtCodCli.Text);

        If (fEmptyStr(edtNomCli.Text)) Then
        Begin
          fMensagem('','Cliente não está cadastrado.',['&OK']);
          Result := False;
        End;
      End
      Else
        edtNomCli.Text := 'TODOS';

    End
    Else If (Sender = edtCodAti) Then
    Begin

      If (Not fEmptyStr(edtCodAti.Text)) Then
      Begin
        edtDesAti.Text := fRetNomAtividade(edtCodAti.Text);

        If (fEmptyStr(edtDesAti.Text)) Then
        Begin
          fMensagem('','Atividade não está cadastrada.',['&OK']);
          Result := False;
        End;
      End
      Else
        edtDesAti.Text := 'TODAS';

    End
    Else If (Sender = edtCodCid) Then
    Begin

      If (Not fEmptyStr(edtCodCid.Text)) Then
      Begin
        edtDesCid.Text := fRetNomCidade(edtCodCid.Text, 0);
        edtDesEst.Text := fRetNomCidade(edtCodCid.Text, 1);

        If (fEmptyStr(edtDesCid.Text)) Then
        Begin
          fMensagem('','Cidade não está cadastrada.',['&OK']);
          Result := False;
        End;
      End
      Else
      Begin
        edtDesCid.Text := 'TODAS';
        edtDesEst.Text := '';
      End;

    End
    Else If (Sender = edtCodReg) Then
    Begin

      If (Not fEmptyStr(edtCodReg.Text)) Then
      Begin
        edtDesReg.Text := fRetDesRegiao(edtCodReg.Text);

        If (fEmptyStr(edtDesReg.Text)) Then
        Begin
          fMensagem('','Região não está cadastrada.',['&OK']);
          Result := False;
        End;
      End
      Else
        edtDesReg.Text := 'TODAS';

    End
    Else If (Sender = edtCodSub) Then
    Begin

      If (Not fEmptyStr(edtCodSub.Text)) Then
      Begin
        edtDesSub.Text := fRetDesSubReg(edtCodSub.Text);

        If (fEmptyStr(edtDesSub.Text)) Then
        Begin
          fMensagem('','Sub-Região não está cadastrada.',['&OK']);
          Result := False;
        End;
      End
      Else
        edtDesSub.Text := 'TODAS';

    End
    Else If (Sender = edtCodRed) Then
    Begin

      If (Not fEmptyStr(edtCodRed.Text)) Then
      Begin
        edtDesRed.Text := fRetNomeRedeLoja(edtCodRed.Text);

        If (fEmptyStr(edtDesRed.Text)) Then
        Begin
          fMensagem('','Rede de Lojas não está cadastrada.',['&OK']);
          Result := False;
        End;
      End
      Else
        edtDesRed.Text := 'TODAS';

    End
    Else If (Sender = edtCodCac) Then
    Begin

      If (Not fEmptyStr(edtCodCac.Text)) Then
      Begin
        edtDesCac.Text := fRetNomCanalAcesso(edtCodCac.Text);

        If (fEmptyStr(edtDesCac.Text)) Then
        Begin
          fMensagem('','Canal de Acesso não está cadastrada.',['&OK']);
          Result := False;
        End;
      End
      Else
        edtDesCac.Text := 'TODAS';

    End;

  End;

  If Not (Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadCampanhaVendas.mskDtaFinEnter(Sender: TObject);
begin
  inherited;
  If fEmptyStr(fReplaceStr(mskDtaFin.Text,'/','')) Then
    mskDtaFin.Text := DateToStr(VS_Date);
end;

procedure TfrmCadCampanhaVendas.mskDtaIniEnter(Sender: TObject);
begin
  inherited;
  If fEmptyStr(fReplaceStr(mskDtaIni.Text,'/','')) Then
    mskDtaIni.Text := DateToStr(VS_Date);
end;

procedure TfrmCadCampanhaVendas.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(mskLinhaGrupo.Text) Then
    edtDesGrupo.Text := 'TODOS'
  Else
    edtDesGrupo.Text := fRetNomeLinhaGrupo(mskLinhaGrupo.Text);

  edtDesGrupo.Enabled := False;

  If fEmptyStr(edtDesGrupo.Text) And (Not fEmptyStr(mskLinhaGrupo.Text))  Then
  Begin
    fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
    mskLinhaGrupo.Clear;
    pSetFocus(mskLinhaGrupo);
  End;
end;

procedure TfrmCadCampanhaVendas.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrGrupos: TConsultasArray;
begin
  inherited;
  {********************************}
  {* NOVA CONSULTA DE LINHA/GRUPO *}
  {*****************************RV*}
  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, Nil, Key, arrGrupos) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadCampanhaVendas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  fGetFuncoesCxGrid.pSalvarView(dbgProdutosTV, fGetChaveLayoutGridProdutos, cdsProdutos);
  fGetFuncoesCxGrid.pSalvarView(dbgGenericaDB, fGetChaveLayoutGridGenerica, cdsGenerica);
  fGetFuncoesCxGrid.pSalvarView(dbgAnaliseTV, fGetChaveLayoutGridAnalise, cdsProdutos);
end;

procedure TfrmCadCampanhaVendas.FormCreate(Sender: TObject);
begin
  inherited;
  blnZerarCustos := False;

  cdsProdutos := fCriaCdsProdutos(Self);
  cdsProdutos.IndexFieldNames := 'CODITE';
  cdsProdutos.BeforePost := pBeforePost;
  dtsProdutos := fCriaDataSource(cdsProdutos);

  cdsGenerica := fCriaCdsGenerica(Self);
  dtsGenerica := fCriaDataSource(cdsGenerica);

  FcdsProdutosExcluidos := fCriaCdsProdutosExcluidos(Self);

  qryCamCnd := fCriaQuery(Self);
  cdsCamCnd := fCriaCdsCondicao(Self);
  dtsCamCnd := fCriaDataSource(cdsCamCnd);
  qryConFpg := fCriaQuery(Self);

  If (VS_strUsaTmq <> 'S') Then
  Begin
    btnTintaMaquina.Enabled := False;
    btnTintaMaquina.Visible := False;
  End;

  cxgGridCamCndView.DataController.DataSource := dtsCamCnd;

  dbgProdutosTV.DataController.DataSource := dtsProdutos;
  dbgAnaliseTV.DataController.DataSource  := dtsProdutos;
  dbgGenericaDB.DataController.DataSource  := dtsGenerica;

  objCamGer := TCamGer.Create(Self);

  rdgGlobal.Items.Add('Objetivo Venda');
  rdgGlobal.Items.Add('Preço Contrato');
  rdgGlobal.Items.Add('Margem');
  rdgGlobal.ItemIndex := 0;
  rdgGlobal.Visible   := False;

  blnAltGlobal := False;
  blnBuscaCampanhaPorCodigo := False;

  objCfgGridProdutos := TCfgGrid.Create(Self, dbgProdutosTV, 'Produtos', [], '', False, False);
  objCfgGridGenerica := TCfgGrid.Create(Self, dbgGenericaDB, 'Genérica', [], '', False, False);
  objCfgGridAnalise := TCfgGrid.Create(Self, dbgAnaliseTV, 'Análise de Resultados', [], '', False, False);

  pSetaCodIte(edtCodIte);

  pPreencheCombo(TCustomComboBox(cbxCatego),  arrCtgCli);
  cbxCatego.ItemIndex := 0;

  cdsCliCamp.CreateDataSet;
end;

procedure TfrmCadCampanhaVendas.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(cdsProdutos);
  FreeAndNil(cdsGenerica);
  FreeAndNil(qryConFpg);
  FreeAndNil(qryCamCnd);
  FreeAndNil(cdsCamCnd);
  FreeAndNIl(FcdsProdutosExcluidos);
end;

procedure TfrmCadCampanhaVendas.edtCodCmgKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryCamGer : TUniQuery;
    arrSel    : TConsultasArray;

begin
  inherited;

  qryCamGer := fCriaQuery;

  if fPesqCampanha(Self, edtCodCmg, edtDesCmg, qryCamGer, Key, arrSel) then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

  FreeAndnil(qryCamGer);
end;

procedure TfrmCadCampanhaVendas.edtCodCndKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCnd: TConsultasArray;
begin
  inherited;
  If fPesqCondicoesPgto(Self, edtCodCnd, edtDesCnd, Nil, Key, arrCnd, False) Then
  Begin
    If fValidaCampos(edtCodCnd, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCampanhaVendas.edtCodCmgExit(Sender: TObject);
begin
  inherited;

  FcdsProdutosExcluidos.EmptyDataSet;
  strGenExcluidos  := '';
  strCndExcluidos  := '';

  If Not fEmptyStr(edtCodCmg.Text) Then
  Begin

    objCamGer.pCarregaCamGer(edtCodCmg.Text);

    If fEmptyStr(objCamGer.strCodCmg) Then
    Begin
      pLimpaEdits(True, True, True, True);
      fMensagem('ATENÇÃO!', 'Campanha não cadastrada!', ['&Ok']);
      pSetFocus(edtCodCmg);
      Exit;
    End;

    pAtualizaCampos(False);

    pTotalizaRodape;

  End
  Else
  Begin
    pLimpaEdits(True, True, True, True);
  End;

  pHabilitaFuncao(opConsulta);
end;

procedure TfrmCadCampanhaVendas.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryItens    : TUniQuery;
    arrSel : TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    qryItens     := fCriaQuery;
    if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, qryItens, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
    Begin
      Self.SelectNext(ActiveControl, True, True);

    End;

    FreeAndNil(qryItens);
  End;

end;

procedure TfrmCadCampanhaVendas.edtCodIteChange(Sender: TObject);
begin
  inherited;
  edtCodProdCliente.Enabled := (Not fEmptyStr(edtCodIte.Text));
  lblCodProdCliente.Enabled := (Not fEmptyStr(edtCodIte.Text));
end;

procedure TfrmCadCampanhaVendas.edtCodIteExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtCodIte.Text) Then
  Begin

    If (fCfgSis('SIMCAM', varBoolean)) And (cdsProdutos.State = dsBrowse) Then
    Begin

      If fConsisteSimilaridade(edtCodIte.Text) Then
        pSetFocus(edtCodIte);

    End;

    pRetDadosItem(edtCodIte.Text,
                  strNomPro,
                  strRefere,
                  strMarca,
                  strUnidad);

    edtDesIte.Text  := strNomPro;
    edtRefere.Text  := strRefere;
    edtUnidade.Text := strUnidad;

    If Not fEmptyStr(strIteTin) Then
      Exit;

    If edtQtdIte.Text = '0,000' Then
      edtQtdIte.Text := FloatToStrF(0, ffFixed, 14, 3);

    If (edtCodIte.Text = cdsProdutos.FieldByName('CODITE').AsString) Then
      edtVlrIte.Text := FloatToStrF(cdsProdutos.FieldByName('VLRUNI').AsFloat, ffFixed, 12, 2)
    Else
      edtVlrIte.Text := '0,00';

    If (Not blnAltGlobal) And (edtVlrIte.Text = '0,00') Then
      edtVlrIte.Text := FloatToStrF(objCamGer.fBuscaPrecoVenda(edtCodIte.Text), ffFixed, 12, 2);

    If fEmptyStr(strNomPro) Then
    Begin

      pLimpaEdits(False, True);
      fMensagem('', 'Produto não encontrado !', ['&Ok']);
      pSetFocus(edtCodIte);

    End;

  End
  Else
    edtDesIte.Text := 'TODOS';

end;

procedure TfrmCadCampanhaVendas.edtCodRedKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqRedeLojas(Self, edtCodRed, edtDesRed, Nil, Key, arrRed) Then
  Begin
    If fValidaCampos(edtCodRed, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCampanhaVendas.edtCodRegExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodReg, edtDesReg, arrReg, Nil, fRetDesRegiao, 'da Região');
end;

procedure TfrmCadCampanhaVendas.edtCodRegKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqRegiao(Self, edtCodReg, edtDesReg, Nil, Key, arrReg) Then
  Begin
    If fValidaCampos(edtCodReg, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCampanhaVendas.edtCodSitExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodSit.Text) Then
    edtDesSit.Text := 'TODOS'
  Else
    edtDesSit.Text := fRetNomSituacaoProduto(edtCodSit.Text);

  If fEmptyStr(edtDesSit.Text) And (Not fEmptyStr(edtCodSit.Text))  Then
  Begin
    fMensagem('AVISO','Código de situação de produto não encontrado.', ['&O K']);
    edtCodSit.Clear;
    pSetFocus(edtCodSit);
  End;

end;

procedure TfrmCadCampanhaVendas.edtCodSitKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If fPesqSituacaoProduto(Self,
                          edtCodSit,
                          edtDesSit,
                          Nil,
                          Key,
                          arrSel) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadCampanhaVendas.edtCodSubExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodSub, edtDesSub, arrSub, Nil, fRetDesSubReg, 'da Sub-Região');
end;

procedure TfrmCadCampanhaVendas.edtCodSubKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqSubRegiao(Self, edtCodSub, edtDesSub, Nil, Key, arrSub) Then
  Begin
    If fValidaCampos(edtCodSub, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCampanhaVendas.edtFornecedorExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtFornecedor.Text) Then
    edtDesFornecedor.Text := 'TODOS'
  Else
    edtDesFornecedor.Text := fRetNomFornecedor(edtFornecedor.Text);

  If fEmptyStr(edtDesFornecedor.Text) And (Not fEmptyStr(edtFornecedor.Text))  Then
  Begin
    fMensagem('AVISO','Código do fornecedor não encontrado.', ['&O K']);
    edtFornecedor.Clear;
    pSetFocus(edtFornecedor);
  End;
end;

procedure TfrmCadCampanhaVendas.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCampanhaVendas.edtForPagKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrForma: TConsultasArray;
begin
  inherited;
  If (Not fCfgSis('USAFPG', varBoolean)) Then
    Exit;

  If fEntraCons(Key) And (Not edtForPag.ReadOnly) Then
  Begin
    {***********************************}
    {* NOVA CONSULTA DE FORMA DE PAGTO *}
    {********************************RV*}
    If fPesqFormaPgto(conFpgBaiAvi, Self, edtForPag, edtDesPag, Nil, Key, arrForma) Then
    Begin
      If (fValidaCampos(edtForPag, True)) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
    pCarregaForPag;
  End;
  pCarregaForPag;
end;

procedure TfrmCadCampanhaVendas.edtMarcaExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtMarca.Text) Then
    edtDesMarca.Text := 'TODOS'
  Else
    edtDesMarca.Text := fRetNomMarca(edtMarca.Text);

  If fEmptyStr(edtDesMarca.Text) And (Not fEmptyStr(edtMarca.Text))  Then
  Begin
    fMensagem('AVISO','Código da marca não encontrado.', ['&O K']);
    edtMarca.Clear;
    pSetFocus(edtMarca);
  End;
end;

procedure TfrmCadCampanhaVendas.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrMarca : TConsultasArray;
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrMarca) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCampanhaVendas.edtCodRedExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRed, edtDesRed, arrRed, Nil, fRetNomeRedeLoja, 'da Rede de Lojas');
end;

procedure TfrmCadCampanhaVendas.edtCodCliKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCampanhaVendas.edtAtivaExit(Sender: TObject);
begin
  inherited;
  If fValidaPanel(pnlCampanha) Then
  Begin
    pnlDadosAdicionais.Enabled := True;
    pgcDados.Enabled           := True;

    pSetFocus(mskLinhaGrupo);
  End;
end;

procedure TfrmCadCampanhaVendas.edtCgcCpfChange(Sender: TObject);
begin
  inherited;
  If (edtCgcCpf.Text = '1') Then
    edtNuCnpj.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
  Else If (edtCgcCpf.Text = '2') Then
    edtNuCnpj.EditMask := '999.999.999-99;0;'
  Else
    edtNuCnpj.EditMask := '';
end;

procedure TfrmCadCampanhaVendas.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAti, edtDesAti, arrAti, Nil, fRetNomAtividade, 'da Atividade');
end;

procedure TfrmCadCampanhaVendas.edtCodAtiKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, arrAti) Then
  Begin
    If fValidaCampos(edtCodAti, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCampanhaVendas.edtCodCacExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCac, edtDesCac, arrCac, Nil, fRetNomCanalAcesso, 'do Canal de Acesso');
end;

procedure TfrmCadCampanhaVendas.edtCodCacKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCanalAcesso(Self, edtCodCac, edtDesCac, Nil, Key, arrCac) Then
  Begin
    If fValidaCampos(edtCodCac, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCampanhaVendas.edtCodCidExit(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtCodCid.Text)) Then
  Begin
    edtDesCid.Text := fRetNomCidade(edtCodCid.Text, 0);
    edtDesEst.Text := fRetNomCidade(edtCodCid.Text, 1);
  End
  Else
  Begin
    edtDesCid.Text := 'TODAS';
    edtDesEst.Text := '';
  End;
end;

procedure TfrmCadCampanhaVendas.edtCodCidKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCidade(Self, edtCodCid, edtDesCid, edtDesEst, Nil, Key, arrCid) Then
  Begin
    If fValidaCampos(edtCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCampanhaVendas.edtCodCliExit(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtCodCli.Text)) Then
    pBuscarDadosClienteFiltro(edtCodCli.Text)
  Else
    edtNomCli.Text := 'TODOS';
end;

{*******************************************}
{* LIMPA CONTEÚDO DOS EDITS                *}
{****************************************RL*}
procedure TfrmCadCampanhaVendas.pLimpaEdits(blnCampanha: Boolean = False; blnProdutos: Boolean = False;
 blnDadosAdicionais: Boolean = False; blnGenerica: Boolean = False);
Begin

  If blnCampanha Then
  Begin

    edtCodCmg.Clear;
    edtDesCmg.Clear;
    edtAtiva.Text := 'S';

  End;

  If blnProdutos Then
  Begin

    edtCodIte.Clear;
    edtDesIte.Clear;
    edtCodProdCliente.Clear;
    lblCodProdCliente.Enabled := False;
    edtCodProdCliente.Enabled := False;
    edtRefere.Clear;
    edtUnidade.Clear;
    edtCodSit.Clear;
    edtQtdIte.Clear;
    edtQtdIte.Text := '0,000';
    edtVlrIte.Clear;
    edtVlrIte.Text := '0,00';
    edtPreCus.Clear;
    edtPreCus.Text := '0,00';
    edtPreClq.Clear;
    edtPreClq.Text := '0,00';
    edtTotQtdPre.Clear;

    mskLinhaGrupo.Clear;
    edtDesGrupo.Clear;
    edtMarca.Clear;
    edtDesMarca.Clear;
    edtDescriIni.Clear;
    edtClaIPI.Clear;
    edtFornecedor.Clear;
    edtDesFornecedor.Clear;
    edtDesSit.Clear;
    edtDescriFin.Clear;
    edtClaCRM.Clear;
    edtUnidade.Clear;
    edtCodSit.Clear;
  End;

  If blnDadosAdicionais Then
  Begin

    mskDtaEnt.Clear;
    mskDtaIni.Clear;
    mskDtaFin.Clear;
    edtBrinde.Clear;
    edtObs1.Clear;
    edtObs2.Clear;
    edtObs3.Clear;

  End;

  If blnGenerica Then
  Begin

    edtCodOpc.Clear;
    edtDesOpc.Clear;
    edtVlrFat.Clear;
    edtVlrFat.Text := '0,00';

  End;

  strIdePro := '';
  strIteTin := '';
  strTinDes := '';
  fltTinVol := 0;
End;

procedure TfrmCadCampanhaVendas.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  blnInseriu := False;

  If Not fValidaPanel(pnlCampanha, True) Then
    Exit;

  If Not fValidaPanel(pnlProdutos) Then
    Exit;

  If blnAltGlobal Then
  Begin
    Try
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.fExecutarAcao := fEfetuaAlteracaoGlobal;
      frmGravando.ShowModal;
      fMensagem('ATENÇÃO!', 'Alteração Global concluída com sucesso!', ['&Ok']);
      blnInseriu := True;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
    pFreeAndNil(frmGravando);
  End
  Else
  Begin
    Try
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.fExecutarAcao := fAdicionaItens;
      frmGravando.ShowModal;
      blnInseriu := True;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
    pFreeAndNil(frmGravando);
  End;

  pTotalizaRodape;

  pCancelaAltGlobal;
end;

function TfrmCadCampanhaVendas.fAdicionaItens(pgbStatus: TcxProgressBar): Boolean;
var
  qryProdutos : TUniQuery;
  fltQtdIte,
  fltVlrIte,
  fltPreCus,
  fltPreClq: Double;
  prcScroll: TprcScroll;
  dtaGiroDtaIni,
  dtaGiroDtaFim: TDate;
  intMeses: Integer;
  strDesIte : String;
  strCodPcl : String;

begin
  If Not fValidaPanel(pnlCampanha, True) Then
  Begin
    Result := False;
    Exit;
  End;

  intMeses := 0;
  case rdgGiro.ItemIndex of
   0: intMeses := 3;
   1: intMeses := 6;
   2: intMeses := 12;
  end;

  dtaGiroDtaIni := EncodeDate(YearOf(IncMonth(StrToDate(mskDtaIni.Text), -intMeses)), MonthOfTheYear(IncMonth(StrToDate(mskDtaIni.Text), -intMeses)), 01);
  dtaGiroDtaFim := IncDay(EncodeDate(YearOf(StrToDate(mskDtaIni.Text)), MonthOfTheYear(StrToDate(mskDtaIni.Text)), 01),-1);

  qryProdutos := fCriaQuery;

  pInfoStatusGravacao(pgbStatus, 'Aguarde, Carregando Produto(s)...');

  pDisableControls(cdsProdutos, prcScroll);

  With objCamGer Do
  Begin
    dicFiltro['GDTINI'] := dtaGiroDtaIni;
    dicFiltro['GDTFIM'] := dtaGiroDtaFim;
    dicFiltro['DTCTIN'] := StrToDate(mskDtaIni.Text);
    dicFiltro['DTCTFI'] := StrToDate(mskDtaFin.Text);
    dicFiltro['CODCMGEDT'] := '';
    If blnBuscaCampanhaPorCodigo Then
      dicFiltro['CODCMG'] := IIF(fEmptyStr(strCodCmgHer), edtCodCmg.Text, strCodCmgHer)
    Else
    Begin
      dicFiltro['CODCMG'] := '';
      If (fEmptyStr(strImpNumDoc)) And (fEmptyStr(strCodCmgHer)) And (Not fEmptyStr(edtCodCmg.Text)) Then
        dicFiltro['CODCMGEDT'] := edtCodCmg.Text;
    End;
    dicFiltro['IMPDOC'] := strImpNumDoc;
    dicFiltro['ESPDOC'] := strImpEspDoc;
    dicFiltro['CODEMP'] := IIF(fEmptyStr(strImpCodEmp), strCodEmp, strImpCodEmp);
    dicFiltro['IMPTAB'] := strImpTabela;
    dicFiltro['IMPPRE'] := strImpPrefix;
    dicFiltro['CODITE'] := edtCodIte.Text;
    dicFiltro['CODGRU'] := mskLinhaGrupo.Text;
    dicFiltro['CODFOR'] := edtFornecedor.Text;
    dicFiltro['CODMAR'] := edtMarca.Text;
    dicFiltro['DESINI'] := edtDescriIni.Text;
    dicFiltro['DESFIN'] := edtDescriFin.Text;
    dicFiltro['CLAIPI'] := edtClaIPI.Text;
    dicFiltro['REFERE'] := edtRefere.Text;
    dicFiltro['CODUNI'] := edtUnidade.Text;
    dicFiltro['CODSIT'] := edtCodSit.Text;
    dicFiltro['CLACRM'] := edtClaCRM.Text;
    dicFiltro['IDEPRO'] := '';
    dicFiltro['ITETIN'] := '';

    If Not fEmptyStr(strIteTin) Then
    Begin
      dicFiltro['IDEPRO'] := strIdePro;
      dicFiltro['ITETIN'] := strIteTin;
    End
  End;

  Try
    objCamGer.pCarregaProdutos(qryProdutos);

    pInfoStatusGravacao(pgbStatus, 'Aguarde, Carregando Produto(s)...', qryProdutos.RecordCount);

    If Not cdsProdutos.Active Then
      cdsProdutos.CreateDataSet;

    If qryProdutos.RecordCount > 0 Then
    Begin
      While Not qryProdutos.EOF Do
      Begin
        pStepStatusGravacao(pgbStatus);

        If fEmptyStr(strIdePro) Then
        Begin
          If (Not fEmptyStr(qryProdutos.FieldByName('IDEPRO').AsString)) And
             (qryProdutos.FieldByName('IDEPRO').AsString <> 'NOR') Then
          Begin
            If cdsProdutos.Locate('IDEPRO;ITETIN', VarArrayOf([qryProdutos.FieldByName('IDEPRO').AsString,
                                                               qryProdutos.FieldByName('ITETIN').AsString]), []) Then
              cdsProdutos.Edit;
          End
          Else
          If cdsProdutos.Locate('CODITE', qryProdutos.FieldByName('CODITE').AsString, []) Then
            cdsProdutos.Edit;
        End
        Else
        Begin
          if not fEmptyStr(strIteTin) then
          begin
            If cdsProdutos.Locate('IDEPRO;ITETIN', VarArrayOf([strIdePro,strIteTin]), []) Then
              cdsProdutos.Edit;
          end
          Else
            If cdsProdutos.Locate('IDEPRO;CODITE', VarArrayOf([strIdePro,edtCodIte.Text]), []) Then
              cdsProdutos.Edit;
        End;

        If cdsProdutos.State = dsBrowse Then
        Begin
          cdsProdutos.Insert;

          If Not fEmptyStr(strIdePro) Then
          Begin
            cdsProdutos.FieldByName('TINDES').AsString := strTinDes;
            cdsProdutos.FieldByName('IDEPRO').AsString := strIdePro;
            cdsProdutos.FieldByName('ITETIN').AsString := strIteTin;
            cdsProdutos.FieldByName('TINVOL').AsFloat  := fltTinVol;
            strDesIte := strTinDes;
          End
          Else
          Begin
            cdsProdutos.FieldByName('TINDES').AsString := qryProdutos.FieldByName('DESITE').AsString;
            cdsProdutos.FieldByName('IDEPRO').AsString := qryProdutos.FieldByName('IDEPRO').AsString;
            cdsProdutos.FieldByName('ITETIN').AsString := qryProdutos.FieldByName('ITETIN').AsString;
            cdsProdutos.FieldByName('TINVOL').AsFloat  := qryProdutos.FieldByName('TINVOL').AsFloat;
            strDesIte := qryProdutos.FieldByName('DESITE').AsString;
          End;
          cdsProdutos.FieldByName('DESITE').AsString := strDesIte;
          cdsProdutos.FieldByName('CODPCL').asString := edtCodProdCliente.Text;
        End
        Else
        Begin
          If Not fEmptyStr(strTinDes) Then
            cdsProdutos.FieldByName('DESITE').AsString := strTinDes;
          If fltTinVol > 0 Then
            cdsProdutos.FieldByName('TINVOL').AsFloat  := fltTinVol;
        End;

        If (Not fEmptyStr(fReplaceStr(edtVlrIte.Text,'0,00',''))) Then
        Begin
          fltQtdIte := fStrToFloat(edtQtdIte.Text);
          fltVlrIte := fStrToFloat(edtVlrIte.Text);
          fltPreCus := fStrToFloat(edtPreCus.Text);
          fltPreClq := fStrToFloat(edtPreClq.Text);
        End
        Else
        If (Not fEmptyStr(strImpNumDoc)) And (fEmptyStr(qryProdutos.FieldByName('AUTINC').AsString)) Then
        Begin
          fltQtdIte := qryProdutos.FieldByName('QTDITED').AsFloat;
          fltVlrIte := qryProdutos.FieldByName('UNITARD').AsFloat;
          fltPreCus := qryProdutos.FieldByName('TOTCUSD').AsFloat;
          fltPreClq := qryProdutos.FieldByName('PRECLQ').AsFloat;
        End
        Else
        Begin
          fltQtdIte := qryProdutos.FieldByName('QTDITE').AsFloat;
          fltVlrIte := qryProdutos.FieldByName('VLRUNI').AsFloat;
          fltPreCus := qryProdutos.FieldByName('PRECUS').AsFloat;
          fltPreClq := qryProdutos.FieldByName('PRECLQ').AsFloat;
        End;

        If (not FEmptyStr(edtCodProdCliente.Text)) Then
          strCodPcl := edtCodProdCliente.Text
        Else
          strCodPcl := qryProdutos.FieldByName('CODPCL').AsString;

        If blnZerarCustos Then
        Begin
          cdsProdutos.FieldByName('PRECUS').AsFloat := 0;
          cdsProdutos.FieldByName('PRECLQ').AsFloat := 0;
          cdsProdutos.FieldByName('TOTCU2').AsFloat := 0;
          cdsProdutos.FieldByName('TOTCU3').AsFloat := 0;
          cdsProdutos.FieldByName('TOTCUS').AsFloat := 0;
        End
        Else
        Begin
          cdsProdutos.FieldByName('PRECUS').AsFloat := fltPreCus;
          cdsProdutos.FieldByName('PRECLQ').AsFloat := fltPreClq;
          cdsProdutos.FieldByName('TOTCU2').AsFloat := qryProdutos.FieldByName('TOTCU2').AsFloat;
          cdsProdutos.FieldByName('TOTCU3').AsFloat := qryProdutos.FieldByName('TOTCU3').AsFloat;
          cdsProdutos.FieldByName('TOTCUS').AsFloat := qryProdutos.FieldByName('TOTCUS').AsFloat;
        End;

        If fEmptyStr(strImpNumDoc) And fEmptyStr(strCodCmgHer) Then
          cdsProdutos.FieldByName('AUTINC').AsString := qryProdutos.FieldByName('AUTINC').AsString;
        cdsProdutos.FieldByName('CODITE').AsString := qryProdutos.FieldByName('CODITE').AsString;
        cdsProdutos.FieldByName('CORSIT').AsString := qryProdutos.FieldByName('CORSIT').AsString;
        cdsProdutos.FieldByName('CODGRU').AsString := qryProdutos.FieldByName('CODGRU').AsString;
        cdsProdutos.FieldByName('CODFOR').AsString := qryProdutos.FieldByName('CODFOR').AsString;
        cdsProdutos.FieldByName('CODMAR').AsString := qryProdutos.FieldByName('CODMAR').AsString;
        cdsProdutos.FieldByName('CLAIPI').AsString := qryProdutos.FieldByName('CLAIPI').AsString;
        cdsProdutos.FieldByName('REFERE').AsString := qryProdutos.FieldByName('REFERE').AsString;
        cdsProdutos.FieldByName('CODUNI').AsString := qryProdutos.FieldByName('CODUNI').AsString;
        cdsProdutos.FieldByName('SITPRO').AsString := qryProdutos.FieldByName('SITPRO').AsString;
        cdsProdutos.FieldByName('CLACRM').AsString := qryProdutos.FieldByName('CLACRM').AsString;
        cdsProdutos.FieldByName('ITESIM').AsString := objCamGer.objCamDet.fRetornaSimilaridade(qryProdutos.FieldByName('CODITE').AsString);

        cdsProdutos.FieldByName('QTDITE').AsFloat := fltQtdIte;
        cdsProdutos.FieldByName('VLRUNI').AsFloat := fltVlrIte;

        cdsProdutos.FieldByName('VLRITE').AsString := FloatToStrF(cdsProdutos.FieldByName('QTDITE').AsFloat * cdsProdutos.FieldByName('VLRUNI').AsFloat, ffFixed, 12, 2);
        cdsProdutos.FieldByName('NOMFOR').AsString := qryProdutos.FieldByName('NOMFOR').AsString;
        cdsProdutos.FieldByName('DEPDES').AsString := qryProdutos.FieldByName('DEPDES').AsString;
        cdsProdutos.FieldByName('ULTVEN').AsFloat  := qryProdutos.FieldByName('ULTVEN').AsFloat;
        cdsProdutos.FieldByName('PEROBJ').AsFloat  := qryProdutos.FieldByName('PEROBJ').AsFloat;
        cdsProdutos.FieldByName('PERACT').AsFloat  := qryProdutos.FieldByName('PERACT').AsFloat;
        cdsProdutos.FieldByName('ULTPRE').AsFloat  := qryProdutos.FieldByName('ULTPRE').AsFloat;
        cdsProdutos.FieldByName('ITECUS').AsFloat  := qryProdutos.FieldByName('ITECUS').AsFloat;
        cdsProdutos.FieldByName('ITEOUT').AsFloat  := qryProdutos.FieldByName('ITEOUT').AsFloat;
        cdsProdutos.FieldByName('ICMSAI').AsFloat  := qryProdutos.FieldByName('ICMSAI').AsFloat;
        cdsProdutos.FieldByName('IMPFED').AsFloat  := qryProdutos.FieldByName('IMPFED').AsFloat;
        cdsProdutos.FieldByName('DESOPE').AsFloat  := qryProdutos.FieldByName('DESOPE').AsFloat;
        cdsProdutos.FieldByName('QTDPER').AsFloat  := qryProdutos.FieldByName('QTDPER').AsFloat;
        cdsProdutos.FieldByName('VENPER').AsFloat  := qryProdutos.FieldByName('VENPER').AsFloat;
        cdsProdutos.FieldByName('TOTITE').AsFloat  := qryProdutos.FieldByName('TOTITE').AsFloat;
        cdsProdutos.FieldByName('TOTIT3').AsFloat  := qryProdutos.FieldByName('TOTIT3').AsFloat;
        cdsProdutos.FieldByName('NVLGIR').AsString := qryProdutos.FieldByName('NVLGIR').AsString;
        cdsProdutos.FieldByName('NVLCRI').AsString := qryProdutos.FieldByName('NVLCRI').AsString;
        cdsProdutos.FieldByName('ESTMIN').AsFloat  := qryProdutos.FieldByName('ESTMIN').AsFloat;
        cdsProdutos.FieldByName('ESTMAX').AsFloat  := qryProdutos.FieldByName('ESTMAX').AsFloat;
        cdsProdutos.FieldByName('GIRP03').AsFloat  := qryProdutos.FieldByName('GIRP03').AsFloat;
        cdsProdutos.FieldByName('GIRP06').AsFloat  := qryProdutos.FieldByName('GIRP06').AsFloat;
        cdsProdutos.FieldByName('GIRP12').AsFloat  := qryProdutos.FieldByName('GIRP12').AsFloat;
        cdsProdutos.FieldByName('MARGEM').AsFloat  := qryProdutos.FieldByName('MARGEM').AsFloat;
        cdsProdutos.FieldByName('MARPER').AsFloat  := qryProdutos.FieldByName('MARPER').AsFloat;
        cdsProdutos.FieldByName('CODPCL').asString := strCodPcl;

        pCalculaValores;

        cdsProdutos.Post;

        qryProdutos.Next;
      End;
    End;

    qryProdutos.Refresh;

    Result := True;

  Finally
    blnBuscaCampanhaPorCodigo := False;
    qryProdutos.Close;
    FreeAndNil(qryProdutos);
  End;

  cdsProdutos.First;
  pEnableControls(cdsProdutos, prcScroll);

  pLimpaEdits(False, True);
  pSetFocus(mskLinhaGrupo);
end;

procedure TfrmCadCampanhaVendas.btnImportarClick(Sender: TObject);
var
  frmDigDocumentoEmpresa: TfrmDigDocumentoEmpresa;
begin
  inherited;

  If Not fValidaPanel(pnlCampanha, True) Then
    Exit;

  pCriarFormularios(TfrmDigDocumentoEmpresa, frmDigDocumentoEmpresa);
  Try
    frmDigDocumentoEmpresa.blnTipoPreco := False;
    frmDigDocumentoEmpresa.blnAcessoPelaCampanhaVendas := True;
    frmDigDocumentoEmpresa.ShowModal;
    If frmDigDocumentoEmpresa.blnConfirma Then

    If fConfirmaImportacaoDocumento(frmDigDocumentoEmpresa.strNumDoc,
                                    frmDigDocumentoEmpresa.strEspDoc,
                                    frmDigDocumentoEmpresa.strCodEmp) Then
    Begin
      strImpNumDoc := frmDigDocumentoEmpresa.strNumDoc;
      strImpEspDoc := frmDigDocumentoEmpresa.strEspDoc;
      strImpCodEmp := frmDigDocumentoEmpresa.strCodEmp;
      blnZerarCustos := frmDigDocumentoEmpresa.blnZerarCustos;
      blnBuscaCampanhaPorCodigo := False;

      btnConfirmar.Click;
    End;
  Finally
    FreeAndNil(frmDigDocumentoEmpresa);
  End;

  strImpNumDoc := '';
  strImpEspDoc := '';
  strImpCodEmp := '';
  strImpTabela := '';
  strImpPrefix := '';

end;

procedure TfrmCadCampanhaVendas.btnImportarProdCampanhaClick(Sender: TObject);
  var objImportaPlanilhaCampanhaVendas : TImportaPlanilhaCampanhaVendas;
Begin

  If Not fValidaPanel(pnlCampanha, True) Then
    Exit;


  objImportaPlanilhaCampanhaVendas := TImportaPlanilhaCampanhaVendas.Create;

  Try
    objImportaPlanilhaCampanhaVendas.AposCarregarDadosDaLinha := AposCarregarLinhaPlanilha;
    If objImportaPlanilhaCampanhaVendas.fSelecionaArquivo Then
      objImportaPlanilhaCampanhaVendas.pProcessaArquivo;
  Finally
    FreeAndNil(objImportaPlanilhaCampanhaVendas);
  End;

end;

procedure TfrmCadCampanhaVendas.btnAlterarClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(objCamGer.strCodCmg) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar uma campanha para usar essa função!', ['&Ok']);
    Exit;
  End;

  If StrToDate(objCamGer.strDtaFin) < VS_Date Then
  begin
    fMensagem('ATENÇÃO!', 'Esta campanha já foi finalizada. Por isso não pode ser alterada!', ['&Ok']);
    Exit;
  end;

  pSetFocus(edtDesCmg);

  pHabilitaFuncao(opAlteracao);
end;

procedure TfrmCadCampanhaVendas.dbgAnaliseTVCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (AViewInfo.Item.Index = dbgAnaliseTVQTDITE.Index) Then
  Begin
     ACanvas.Brush.Color := clYellow;
     ACanvas.Font.Color  := clBlack;
  End;

  If fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgAnaliseTVRLIQQT.Index])) <
     fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgAnaliseTVRESPER.Index])) Then
    ACanvas.Font.Color  := clGreen
  Else
  If fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgAnaliseTVRLIQQT.Index])) =
     fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgAnaliseTVRESPER.Index])) Then
    ACanvas.Font.Color  := clBlue
  Else
  If fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgAnaliseTVRLIQQT.Index])) >
     fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgAnaliseTVRESPER.Index])) Then
    ACanvas.Font.Color  := clRed;

  If (AViewInfo.Item.Index = dbgAnaliseTVCORSIT.Index) And
     (StrToIntDef(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgAnaliseTVCORSIT.Index]),0)>0) Then
  Begin
    ACanvas.Brush.Color := StrToIntDef(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgAnaliseTVCORSIT.Index]),0);
    ACanvas.Font.Color  := StrToIntDef(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgAnaliseTVCORSIT.Index]),0);
  End;
end;

procedure TfrmCadCampanhaVendas.dbgGenericaDBKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Escape) Then
  Begin
    If pgcDados.ActivePage = tbsProdutos Then
      btnCancelaItem.Click
    Else
      btnGenCancelaItem.Click
  End

  Else If (Key = VK_Return) And (pnlGenerica.Enabled) Then
    pCarregaItensGenerica
  Else If (Key = VK_Delete) And (pnlGenerica.Enabled) Then
  Begin

    If Not cdsGenerica.FieldByName('CODOPC').IsNull Then
    Try

      strGenExcluidos := strGenExcluidos + QuotedStr(cdsGenerica.FieldByName('CODOPC').AsString) + ',';

      cdsGenerica.Delete;
      If cdsGenerica.IsEmpty Then
        pSetFocus(edtCodOpc);

      pTotalizaRodape;

    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[TfrmCadCampanhaVendas.dbgGenericaKeyDown]');

    End
    Else
      pSetFocus(edtCodOpc);

  End;
end;

procedure TfrmCadCampanhaVendas.dbgProdutosTVCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (AViewInfo.Item.Index = dbgProdutosTVQTDITE.Index) Or
     (AViewInfo.Item.Index = dbgProdutosTVVLRUNI.Index) Or
     (AViewInfo.Item.Index = dbgProdutosTVPRECLQ.Index) Or
     (AViewInfo.Item.Index = dbgProdutosTVPRECUS.Index) Then
  Begin
     ACanvas.Brush.Color := clYellow;
     ACanvas.Font.Color  := clBlack;
  End;

  If fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgProdutosTVRLIQQT.Index])) >
     fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgProdutosTVRESLIQ.Index])) Then
    ACanvas.Font.Color  := clGreen
  Else
  If fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgProdutosTVRLIQQT.Index])) =
     fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgProdutosTVRESLIQ.Index])) Then
    ACanvas.Font.Color  := clBlue
  Else
  If fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgProdutosTVRLIQQT.Index])) <
     fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgProdutosTVRESLIQ.Index])) Then
    ACanvas.Font.Color  := clRed;

  If (AViewInfo.Item.Index = dbgProdutosTVCORSIT.Index) And
     (StrToIntDef(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgProdutosTVCORSIT.Index]),0)>0) Then
  Begin
    ACanvas.Brush.Color := StrToIntDef(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgProdutosTVCORSIT.Index]),0);
    ACanvas.Font.Color  := StrToIntDef(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgProdutosTVCORSIT.Index]),0);
  End;
end;

procedure TfrmCadCampanhaVendas.dbgProdutosTVKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Escape) Then
  Begin

    If pgcDados.ActivePage = tbsProdutos Then
      btnCancelaItem.Click
    Else
      btnGenCancelaItem.Click

  End

  Else If (Key = VK_Return) And (pnlProdutos.Enabled) Then
    pCarregaItensProdutos
  Else If (Key = VK_Delete) And (pnlProdutos.Enabled) Then
  Begin

    If (Not cdsProdutos.FieldByName('CODITE').IsNull) And (pnlProdutos.Enabled) Then
    Try

      FcdsProdutosExcluidos.Insert;
      FcdsProdutosExcluidos.FieldByName('CODITE').AsString := cdsProdutos.FieldByName('CODITE').AsString;
      FcdsProdutosExcluidos.FieldByName('IDEPRO').AsString := cdsProdutos.FieldByName('IDEPRO').AsString;
      FcdsProdutosExcluidos.FieldByName('ITETIN').AsString := cdsProdutos.FieldByName('ITETIN').AsString;
      FcdsProdutosExcluidos.Post;

      cdsProdutos.Delete;
      pSetFocus(dbgProdutos);

      pTotalizaRodape;

      If cdsProdutos.IsEmpty Then
        pSetFocus(edtCodIte);

    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[TfrmCadCampanhaVendas.dbgProdutosKeyDown]');
    End
    Else
      pSetFocus(edtCodIte);
  End;
end;

procedure TfrmCadCampanhaVendas.btnCancelaItemClick(Sender: TObject);
begin

  inherited;

  cdsProdutos.Cancel;
  pLimpaEdits(False, True);
  pSetFocus(mskLinhaGrupo);

  pCancelaAltGlobal;
end;

procedure TfrmCadCampanhaVendas.btnCancelarClick(Sender: TObject);
begin
  inherited;
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtCodAti.Clear;
  edtDesAti.Clear;
  edtCodCid.Clear;
  edtDesCid.Clear;
  edtDesEst.Clear;
  edtCodReg.Clear;
  edtDesReg.Clear;
  edtCodSub.Clear;
  edtDesSub.Clear;
  edtCodRed.Clear;
  edtDesRed.Clear;
  edtCodCac.Clear;
  edtDesCac.Clear;
  edtNuCnPj.Clear;

  cbxCatego.ItemIndex := 0;
  edtCgcCpf.Text := '1';

  pSetFocus(edtCodCli);
end;

procedure TfrmCadCampanhaVendas.btnCancelCliClick(Sender: TObject);
begin
  inherited;
  edtCodCnd.Clear;
  edtDesCnd.Clear;
  edtForPag.Clear;
  edtDesPag.Clear;

  pSetFocus(edtCodCnd);
end;

procedure TfrmCadCampanhaVendas.btnCfgGridsClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaAcessoSistema('PCCGCV', strLoginUsuarioLogado) Then
  Begin
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.' + #13#10 +
              'Direito de Acesso: "Permitir Configurar as Colunas dos Grids das Campanhas de Vendas"', ['&Ok']);
    Exit;
  End;

  Case pgcDados.ActivePageIndex Of
    0: objCfgGridProdutos.pConfiguraColunas;
    1: objCfgGridGenerica.pConfiguraColunas;
    2: objCfgGridAnalise.pConfiguraColunas;
  End;
end;

procedure TfrmCadCampanhaVendas.pCarregaItensProdutos;
Begin

  edtCodIte.Text := cdsProdutos.FieldByName('CODITE').AsString;

  pRetDadosItem(edtCodIte.Text,
                strNomPro,
                strRefere,
                strMarca,
                strUnidad);

  edtDesIte.Text            := strNomPro;
  edtRefere.Text            := strRefere;
  edtUnidade.Text           := strUnidad;
  edtQtdIte.Text            := FloatToStrF(cdsProdutos.FieldByName('QTDITE').AsFloat, ffFixed, 14, 3);
  edtVlrIte.Text            := FloatToStrF(cdsProdutos.FieldByName('VLRUNI').AsFloat, ffFixed, 12, 2);
  edtPreCus.Text            := FloatToStrF(cdsProdutos.FieldByName('PRECUS').AsFloat, ffFixed, 12, 2);
  edtPreClq.Text            := FloatToStrF(cdsProdutos.FieldByName('PRECLQ').AsFloat, ffFixed, 12, 2);
  edtTotQtdPre.Text         := FloatToStrF(fCalculaQtdPreco(fStrToFloat(edtQtdIte.Text), fStrToFloat(edtVlrIte.Text)), ffFixed, 12, 2);
  strIdePro                 := cdsProdutos.FieldByName('IDEPRO').AsString;
  strIteTin                 := cdsProdutos.FieldByName('ITETIN').AsString;
  fltTinVol                 := cdsProdutos.FieldByName('TINVOL').AsFloat;
  edtCodProdCliente.Text    := cdsProdutos.FieldByName('CODPCL').AsString;
  edtCodProdCliente.Enabled := True;
  lblCodProdCliente.Enabled := True;


  cdsProdutos.Edit;

  pSetFocus(edtQtdIte);

End;

procedure TfrmCadCampanhaVendas.pCarregaItensGenerica;
Begin

  If cdsGenerica.FieldByName('OPCAO').AsString = '1' Then
  Begin

    rdgOpcao.ItemIndex := 0;

    edtCodOpc.Text := cdsGenerica.FieldByName('CODOPC').AsString;
    edtDesOpc.Text := cdsGenerica.FieldByName('DESOPC').AsString;
    edtVlrFat.Text := FloatToStrF(cdsGenerica.FieldByName('VLRFAT').AsFloat, ffFixed, 12, 2);

  End
  Else If cdsGenerica.FieldByName('OPCAO').AsString = '2' Then
  Begin

    rdgOpcao.ItemIndex := 1;

    edtCodOpc.Text := cdsGenerica.FieldByName('CODOPC').AsString;
    edtDesOpc.Text := cdsGenerica.FieldByName('DESOPC').AsString;
    edtVlrFat.Text := FloatToStrF(cdsGenerica.FieldByName('VLRFAT').AsFloat, ffFixed, 12, 2);

  End
  Else If cdsGenerica.FieldByName('OPCAO').AsString = '3' Then
  Begin

    rdgOpcao.ItemIndex := 2;

    edtCodOpc.Text := cdsGenerica.FieldByName('CODOPC').AsString;
    edtDesOpc.Text := cdsGenerica.FieldByName('DESOPC').AsString;
    edtVlrFat.Text := FloatToStrF(cdsGenerica.FieldByName('VLRFAT').AsFloat, ffFixed, 12, 2);

  End;

  cdsGenerica.Edit;
  pSetFocus(edtCodOpc);

End;

{*******************************************}
{* CALCULA QTD X PRECO                     *}
{****************************************RL*}
function TfrmCadCampanhaVendas.fCalculaQtdPreco(fltQtdIte,
  fltVlrIte: Double): Double;
begin

  Result := fltQtdIte * fltVlrIte;

end;

{*******************************************}
{* CALCULA VALOR DA QTD X PRECO DO PRODUTO *}
{****************************************RL*}
procedure TfrmCadCampanhaVendas.edtQtdIteExit(Sender: TObject);
begin
  inherited;

  If (Not fEmptyStr(edtQtdIte.Text)) And  (Not fEmptyStr(edtVlrIte.Text)) Then
    edtTotQtdPre.Text := FloatToStrF(fCalculaQtdPreco(fStrToFloat(edtQtdIte.Text), fStrToFloat(edtVlrIte.Text)), ffFixed, 12, 2)
  Else
    edtTotQtdPre.Text := '0';

end;

procedure TfrmCadCampanhaVendas.edtVlrIteExit(Sender: TObject);
begin
  inherited;

  If (Not fEmptyStr(edtQtdIte.Text)) And  (Not fEmptyStr(edtVlrIte.Text)) Then
    edtTotQtdPre.Text := FloatToStrF(fCalculaQtdPreco(fStrToFloat(edtQtdIte.Text), fStrToFloat(edtVlrIte.Text)), ffFixed, 12, 2)
  Else
    edtTotQtdPre.Text := '0';

end;
                                                   
procedure TfrmCadCampanhaVendas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F8) And (pnlProdutos.Enabled) Then
  Begin
    btnTintaMaquina.Click;
  End
  Else
  If (Key = VK_F10) Then
  Begin

    Key := 0;
    btnGravar.Click;

  End
  Else If (Key = VK_F11) And (btnExcluir.Enabled) Then
  Begin

    btnExcluir.Click;

  End
  Else If (Shift = [SSAlt]) And (Key = Ord('P')) Then
  Begin

    pgcDados.ActivePage := tbsProdutos;

  End
  Else If (Shift = [SSAlt]) And (Key = Ord('N')) Then
  Begin

    If tbsGenerica.TabVisible Then
      pgcDados.ActivePage := tbsGenerica;

  End
  Else If (Key = VK_RETURN) Then
  Begin
    If(pgcDados.ActivePage = tbsGenerica) Then
      If (ActiveControl.Parent = rdgOpcao) Then
        SelectNext(ActiveControl, True, True);
  End
  Else If(pgcDados.ActivePage = tbsGenerica) And (Key = VK_ESCAPE) Then
    If (ActiveControl.Parent = rdgOpcao) Then
      pCancelarDados;

end;

procedure TfrmCadCampanhaVendas.FormShow(Sender: TObject);
begin
  inherited;
  tbsGenerica.TabVisible := fCfgSis('EXBGEN', varBoolean);

  pgcDados.ActivePage    := tbsProdutos;
  pgcCampanha.ActivePage := tbsGeral;

  pHabilitaFuncao(opConsulta);
  cdsGenerica.AfterScroll := pAtualizaDadosGenerica;

  lblCodProdCliente.Visible   := fCfgSis('CIPCAM', varBoolean);
  edtCodProdCliente.Visible   := lblCodProdCliente.Visible;
  dbgProdutosTVCODPCL.Visible := lblCodProdCliente.Visible;
 
  btnImportarProdCampanha.Visible := lblCodProdCliente.Visible;
  btnHlpImp.Visible := lblCodProdCliente.Visible;

  fGetFuncoesCxGrid.fCarregarView(dbgProdutosTV, fGetChaveLayoutGridProdutos, cdsProdutos, intRecNoProdutos);
  fGetFuncoesCxGrid.fCarregarView(dbgGenericaDB, fGetChaveLayoutGridGenerica, cdsGenerica, intRecNoGenerica);
  fGetFuncoesCxGrid.fCarregarView(dbgAnaliseTV, fGetChaveLayoutGridAnalise, cdsProdutos, intRecNoAnalise);

  pSetFocus(btnIncluir);
end;

procedure TfrmCadCampanhaVendas.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodCmg);
end;

procedure TfrmCadCampanhaVendas.edtCodOpcKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;

begin
  inherited;

  If fEntraCons(Key) Then
  Begin

    If rdgOpcao.ItemIndex = 0 Then
    Begin

      If fPesqGrupo(Self, edtCodOpc, edtDesOpc, nil, Key, arrSel) then      
      Begin
        If fValidaCampos(edtCodOpc, True) Then
          Self.SelectNext(ActiveControl, True, True);
      End;
    End
    Else If rdgOpcao.ItemIndex = 1 Then
    Begin
      {*********************************}
      {* NOVA CONSULTA DE FORNECEDORES *}
      {******************************RV*}
      If fPesqFornecedor(conForSimples, Self, edtCodOpc, edtDesOpc, Nil, Key, arrSel) Then
      Begin
        If fValidaCampos(edtCodOpc, True) Then
          SelectNext(ActiveControl, True, True);
      End;
    End
    Else
    Begin
      {***************************}
      {* NOVA CONSULTA DE MARCAS *}
      {************************DP*}
      If fPesqMarcas(Self, edtCodOpc, edtDesOpc, Nil, Key, arrSel) Then
      Begin
        Self.SelectNext(ActiveControl, True, True);
      End;
    End;

  End;

end;

procedure TfrmCadCampanhaVendas.edtCodOpcExit(Sender: TObject);
begin
  inherited;

  If rdgOpcao.ItemIndex = 0 Then
  Begin

    If Not fEmptyStr(edtCodOpc.Text) Then
    Begin

      edtDesOpc.Text := fRetNomeLinhaGrupo(edtCodOpc.Text);

      If fEmptyStr(edtDesOpc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Linha/Grupo não encontrada!', ['&Ok']) ;
        pSetFocus(edtCodOpc);
        edtCodOpc.Clear;
        edtDesOpc.Clear;
      End;

    End
    Else
    Begin

      edtCodOpc.Clear;
      edtDesOpc.Clear;

    End;

  End
  Else If rdgOpcao.ItemIndex = 1 Then
  Begin

    If Not fEmptyStr(edtCodOpc.Text) Then
    Begin

      edtDesOpc.Text := fRetNomFornecedor(edtCodOpc.Text);

      If fEmptyStr(edtDesOpc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Fornecedor não encontrado!', ['&Ok']) ;
        pSetFocus(edtCodOpc);
        edtCodOpc.Clear;
        edtDesOpc.Clear;
      End;

    End
    Else
    Begin

      edtCodOpc.Clear;
      edtDesOpc.Clear;

    End;

  End
  Else
  Begin

    If Not fEmptyStr(edtCodOpc.Text) Then
    Begin

      edtDesOpc.Text := fRetNomMarca(edtCodOpc.Text);

      If fEmptyStr(edtDesOpc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Marca não encontrada!', ['&Ok']) ;
        pSetFocus(edtCodOpc);
        edtCodOpc.Clear;
        edtDesOpc.Clear;
      End;

    End
    Else
    Begin

      edtCodOpc.Clear;
      edtDesOpc.Clear;

    End;

  End;


end;

procedure TfrmCadCampanhaVendas.btnExcluirClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(objCamGer.strCodCmg) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar uma campanha para usar essa função!', ['&Ok']);
    Exit;
  End;

  If fMensagem('', 'Deseja excluir campanha?', ['&Sim', '&Não']) = 2 Then
    Exit;

  Try
    fStartTransaction;

    //produtos
    pApagaRegistroTabela('CAMDET', 'CMD_SEQCMG');

    //genérica
    pApagaRegistroTabela('CAMGEN', 'GEN_SEQCMG');

    //cond. pagamento
    pApagaRegistroTabela('CAMCND', 'CND_CODCMG');

    //principal
    pApagaRegistroTabela('CAMGER', 'CMG_CODCMG');

    objCamGer.fLimpaCamCli(objCamGer.strAutInc);

    fCommit;
  Except
    On E: Exception Do
    Begin
     fRollBack;
     pMensagensErro(E.Message,'[TfrmCadCampanhaVendas.btnExcluirClick]');
    End;
  End;

  pCancelarDados;
  pLimpaEdits(True, True, True, True);
  pAtualizaCampos(True);
  pHabilitaFuncao(opConsulta);
end;

procedure TfrmCadCampanhaVendas.btnFiltrarClick(Sender: TObject);
begin
  inherited;
  pInsereClientes();
end;

procedure TfrmCadCampanhaVendas.btnGravarClick(Sender: TObject);
  Var
    strAutIncGer: String;
    strOpcao_   : String;
    dtaDtaEnt   : TDateTime;
    blnGravar   : Boolean;
    prcScroll   : TprcScroll;
    intRecNo    : Integer;
begin
  btnCancelaItem.Click;
  btnCancelar.Click;

  dtaDtaEnt := 0;
  blnGravar := False;

  If (cdsProdutos.IsEmpty) And (cdsGenerica.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'Favor informar produtos e/ou configuração genérica da campanha !', ['&Ok']);
    Exit;
  End;

  If fCfgSis('OCCCAM', VarBoolean) Then
  Begin
    If cdsCliCamp.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO!', 'Favor informar pelo menos um cliente !', ['&Ok']);
      Exit;
    End;
  End;

  Try
    If Not fValidaPanel(pnlCampanha, True) Then
      exit;

    If Not fValidaPanel(pnlDadosAdicionais, True) Then
      exit;

    If not fValidaCodProdCliente Then
      exit;


    cdsProdutos.First;
    cdsGenerica.First;

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaEnt.Text)) Then
      dtaDtaEnt := StrToDate(mskDtaEnt.Text);

    fStartTransaction;

    If objCamGer.fGravaCamGer(strAutIncGer,
                              edtCodCmg.Text,
                              edtDesCmg.Text,
                              '',
                              '',
                              edtObs1.Text,
                              edtObs2.Text,
                              edtObs3.Text,
                              VS_strCodEmp,
                              edtBrinde.Text,
                              dtaDtaEnt,
                              StrToDate(mskDtaIni.Text),
                              StrToDate(mskDtaFin.Text),
                              edtAtiva.Text
                             ) Then


    Begin
      pDisableControls(cdsProdutos, prcScroll);
      intRecNo := cdsProdutos.RecNo;

      While Not cdsProdutos.Eof Do
      Begin

        If objCamGer.objCamDet.fGravaCamDet(cdsProdutos.FieldByName('AUTINC').AsString,
                                            objCamGer.strCodCmg,
                                            cdsProdutos.FieldByName('CODITE').AsString,
                                            cdsProdutos.FieldByName('QTDITE').AsFloat,
                                            cdsProdutos.FieldByName('VLRUNI').AsFloat,
                                            cdsProdutos.FieldByName('VLRITE').AsFloat,
                                            cdsProdutos.FieldByName('PRECUS').AsFloat,
                                            cdsProdutos.FieldByName('GIRP03').AsFloat,
                                            cdsProdutos.FieldByName('GIRP06').AsFloat,
                                            cdsProdutos.FieldByName('GIRP12').AsFloat,
                                            VS_strCodEmp,
                                            cdsProdutos.FieldByName('IDEPRO').AsString,
                                            cdsProdutos.FieldByName('ITETIN').AsString,
                                            cdsProdutos.FieldByName('TINDES').AsString,
                                            cdsProdutos.FieldByName('TINVOL').AsFloat,
                                            cdsProdutos.FieldByName('CODPCL').asString,
                                            cdsProdutos.FieldByName('PRECLQ').AsFloat) Then
          blnGravar := True;

        cdsProdutos.Next;

      End;

      cdsProdutos.RecNo := intRecNo;
      pEnableControls(cdsProdutos, prcScroll);

      If objCamGer.fLimpaCamCli(strAutIncGer) Then
      Begin
        Try
          cdsCliCamp.DisableControls;

          cdsCliCamp.First;
          While Not cdsCliCamp.Eof Do
          Begin
            blnGravar := objCamGer.fGravaCamCli(strAutIncGer, cdsCliCamp.FieldByName('CCM_CODCLI').AsString);
            cdsCliCamp.Next;
          End;
        Finally
          cdsCliCamp.First;
          cdsCliCamp.EnableControls;
        End;
      End;


      If (Not fCfgSis('SIMCAM', varBoolean)) And (Not cdsGenerica.IsEmpty) Then
      Begin

        blnGravar := False;

        While Not cdsGenerica.Eof Do
        Begin

          If rdgOpcao.ItemIndex = 0 Then
            strOpcao_ := '1'
          Else If rdgOpcao.ItemIndex = 1 Then
            strOpcao_ := '2'
          Else
            strOpcao_ := '3';

          If objCamGer.objCamGen.fGravaCamGen(cdsGenerica.FieldByName('AUTINC').AsString,
                                              objCamGer.strCodCmg,
                                              strOpcao_,
                                              IIF(strOpcao_ = '1', cdsGenerica.FieldByName('CODOPC').AsString, ''),
                                              IIF(strOpcao_ = '2', cdsGenerica.FieldByName('CODOPC').AsString, ''),
                                              IIF(strOpcao_ = '3', cdsGenerica.FieldByName('CODOPC').AsString, ''),
                                              cdsGenerica.FieldByName('VLRFAT').AsFloat,
                                              VS_strCodEmp
                                             ) Then
            blnGravar := True;

          cdsGenerica.Next;

        End;

      End;

    End;

    {********************************************************}
    {* EXLCUIR ITENS DE BÔNUS DE PRODUTOS OU BÔNUS GENÉRICO *}
    {*****************************************************RL*}
      If FcdsProdutosExcluidos.recordcount <> 0 Then
        objCamGer.objCamDet.fDeletaCamDet(objCamGer.strCodCmg, FcdsProdutosExcluidos);

    If Not fEmptyStr(strGenExcluidos) Then
    Begin
      strGenExcluidos := Copy(strGenExcluidos, 1, Length(strGenExcluidos) - 1);

      objCamGer.objCamGen.fDeletaCamGen(objCamGer.strCodCmg, objCamGer.objCamGen.strOpcao_, strGenExcluidos);
    End;

    If Not fEmptyStr(strCndExcluidos) Then
    Begin
      strCndExcluidos := Copy(strCndExcluidos, 1, Length(strCndExcluidos) - 1);

      objCamGer.fDeletaCamCnd(strCndExcluidos);
    End;

    pGravaCondicaoPagamento;

    If blnGravar Then
      fCommit
    Else
      fRollBack;

    FcdsProdutosExcluidos.EmptyDataSet;
    strGenExcluidos  := '';
    strCndExcluidos  := '';
    pAtualizaCampos(False);

    pHabilitaFuncao(opConsulta);
    pSetFocus(edtDesCmg);

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message,'[TfrmCadCampanhaVendas.btnGravarClick]');

      pLimpaEdits(True, True, True, True);
      cdsProdutos.EmptyDataSet;
      cdsGenerica.EmptyDataSet;
      cdsCamCnd.EmptyDataSet;
      rdgOpcao.Enabled := True;

      FcdsProdutosExcluidos.EmptyDataSet;
      strGenExcluidos  := '';
      strCndExcluidos  := '';

      If Not edtCodCmg.Enabled Then
        edtCodCmg.Enabled := True;

      pSetFocus(edtCodCmg);

    End;

  End;

end;

procedure TfrmCadCampanhaVendas.btnHerancaClick(Sender: TObject);
  Var
    frmHerancaCampanha: TfrmHerancaCampanha;
begin
  inherited;

  strCodCmgHer := '';
  strImpCodEmp := '';

  If Not fValidaPanel(pnlCampanha, True) Then
    Exit;

  Try

    pCriarFormularios(TfrmHerancaCampanha, frmHerancaCampanha);
    frmHerancaCampanha.ShowModal;

    If frmHerancaCampanha.blnConfirma Then
    Begin
      strCodCmgHer := frmHerancaCampanha.strCodCmg;
      strImpCodEmp := frmHerancaCampanha.strEmpCmg;
      blnBuscaCampanhaPorCodigo := True;

      btnConfirmar.Click;
    End;

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmCadCampanhaVendas.btnHerancaClick]');
    End;

  End;

  pFreeAndNil(frmHerancaCampanha);

  strCodCmgHer := '';
  strImpCodEmp := '';

end;

procedure TfrmCadCampanhaVendas.btnHlpImpClick(Sender: TObject);
begin
  inherited;

  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);

end;

procedure TfrmCadCampanhaVendas.btnIncCliClick(Sender: TObject);
begin
  inherited;
  pIncluiCondicaoPagamento;
end;

procedure TfrmCadCampanhaVendas.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(objCamGer.strCodCmg) Then
  Begin
    strCodCmgAnt := objCamGer.strCodCmg;

    cdsProdutos.Cancel;
    cdsProdutos.EmptyDataSet;

    cdsGenerica.Cancel;
    cdsGenerica.EmptyDataSet;

    cdsCamCnd.Cancel;
    cdsCamCnd.EmptyDataSet;

    cdsCliCamp.Cancel;
    cdsCliCamp.EmptyDataSet;

    pAtualizaCampos(True);
  End;

  pLimpaEdits(True, True, True, True);
  edtCodCmg.Enabled := False;
  pSetFocus(edtDesCmg);

  pHabilitaFuncao(opInclusao);
end;

procedure TfrmCadCampanhaVendas.btnPesquisaClick(Sender: TObject);
  Var
    qryCamGer : TUniQuery;
    arrSel    : TConsultasArray;
    chrKey: Char;
begin
  inherited;

  chrKey := '/';

  qryCamGer := fCriaQuery;

  if fPesqCampanha(Self, edtCodCmg, edtDesCmg, qryCamGer, chrKey, arrSel) then
  Begin
    edtCodCmg.OnExit(Self);
    pgcCampanha.ActivePage := tbsGeral;
  End;

  FreeAndnil(qryCamGer);
end;

procedure TfrmCadCampanhaVendas.btnReajusteClick(Sender: TObject);
begin
  inherited;

  blnAltGlobal   := True;
  blnAltPorFator := fMensagem('', 'Alteração Por:', ['&Fator', '&Valor'])=1;

  lblQtdIte.Visible   := False;
  edtQtdIte.Visible   := False;
  lblPreCus.Visible   := False;
  edtPreCus.Visible   := False;
  lblPreClq.Visible   := False;
  edtPreClq.Visible   := False;
  rdgGlobal.Visible   := True;
  dbgProdutos.Enabled := False;

  lblPreco.Caption := IIF(blnAltPorFator,'Fator:','Valor:');

  pSetFocus(edtVlrIte);
end;

procedure TfrmCadCampanhaVendas.btnTintaMaquinaClick(Sender: TObject);
  Var
    strCodCli: String;
    fltPreVen,
    fltDesMax: Double;
    strOpcPreTin: String;
    blnProPreTin: Boolean;
    blnUsaPreMedTin,
    blnUsaPreCusTin: Boolean;
    strTabPreTin: String;
    strUnidadTin: String;

    sltItems: TStringList;

    dicRetorno: TDicionario;

    qryTinta: TUniQuery;
    qryTintaAux: TUniQuery;
    fatVenda: TFatVenda;

    procedure pExecutaRetornoPrecoTintadeMaquina(blnUsaPreCus: Boolean; strIdenPro: String; strTabPre: String;
                                                 strUnidad: String; fltPreVen, fltDesMax: Double;
                                                 strEmpSalRes: String; strOpcPre: String; dicRetorno: TDicionario;
                                                 qryTinta: TUniQuery; blnProPreTin: Boolean);
    Begin
      strIdePro := strIdenPro;
      strIteTin := dicRetorno['itetin'];
      strTinDes := dicRetorno['descor'];
      edtCodIte.Text := dicRetorno['codite'];
      edtVlrIte.Text := FloatToStrF(IfNull(dicRetorno['preve'+strTabPre], 0.0), ffFixed, 12, 2);
      edtPreCus.Text := FloatToStrF(IfNull(dicRetorno['precus'], 0.0), ffFixed, 12, 2);
      edtPreClq.Text := FloatToStrF(IfNull(dicRetorno['preclq'], 0.0), ffFixed, 12, 2);
      fltTinVol := IfNull(dicRetorno['volpro'], 0);

      pSetFocus(edtQtdIte);
    End;

begin
  inherited;

  blnUsaPreMedTin := False;
  blnProPreTin := (fCfgSis('PROPRE') = 2); // preço de sugestão 2 - Preço de tabela
  strIdePro := '';
  strIteTin := '';

  Try
    strIdePro := fEscolheTintaNovo('');
  Finally
  End;

  if strIdePro = '' then
    Exit;

  fltPreVen := 0;
  fltDesMax := 0;

  strTabPreTin := '';
  strOpcPreTin := '';

  blnUsaPreCusTin := True;

  qryTinta    := fCriaQuery(Self);
  qryTintaAux := fCriaQuery(Self);
  dicRetorno  := TDicionario.Create;
  sltItems    := TStringList.Create;

  fatVenda := TFatVenda.CreateInstance('VN', False, True);
  fatVenda.blnComTansacao := False;
  fatVenda.strNomeForm := 'frmFatVendas';
  fatVenda.strNumDoc := '';
  fatVenda.strSerFsc := '';
  fatVenda.strEspDoc := 'OR';
  fatVenda.blnNotEsp := True;

  If (strIdePro <> 'NOR') Then
  Begin
    strTabPreTin := fatVenda.fDefineTabelaPrecoItem(strIdePro, '');

    dicRetorno.Limpar;

    {*******************************************}
    {* ALIMENTA A VARIAVEIS USADAS NA FUNCAO   *}
    {****************************************MV*}
    dicRetorno['idepro']    := strIdePro;
    dicRetorno['codemp']    := VS_strCodEmp;
    dicRetorno['opcdoc']    := '';
    dicRetorno['usaprecus'] := blnUsaPreCusTin;
    dicRetorno['usapremed'] := blnUsaPreMedTin;
    dicRetorno['tippre']    := '';
    dicRetorno['lazqua']    := 0;
    dicRetorno['tipemb']    := '';
    dicRetorno['qtdemb']    := 0;

    dicRetorno['tabpre']    := strTabPreTin; //Precisa Apenas ser passado para a DLL

    dicRetorno['linha_']    := '';
    dicRetorno['catali']    := '';
    dicRetorno['codcli']    := strCodCli;
    dicRetorno['przmed']    := 0;
    dicRetorno['codcnd']    := '';
    dicRetorno['propre']    := blnProPreTin;

    dicRetorno.AdicionarObjeto('calculadorFatVendas', TFatVendasCalculadorWrapper.Create(fatVenda));

    Try
      pSetaEmpresaLogadaTinta(VS_strCodEmp);

      If fRetornaPreco(Self, qryTinta, qryTintaAux, dicRetorno, False, False, sltItems) Then
      Begin
        pExecutaRetornoPrecoTintadeMaquina(blnUsaPreCusTin, strIdePro, strTabPreTin,
                                           strUnidadTin, fltPreVen, fltDesMax,
                                           VS_strCodEmp, strOpcPreTin, dicRetorno,
                                           qryTinta, blnProPreTin);
      End;
    Finally
      FreeAndNil(sltItems);
      FreeAndNil(dicRetorno);
      FreeAndNil(qryTinta);
      FreeAndNil(qryTintaAux);
      FreeAndNil(fatVenda);
    End;
  End;
end;

procedure TfrmCadCampanhaVendas.cdsCliCampCalcFields(DataSet: TDataSet);
Var
  objDadosCliente : TDadosCliente;
begin
  inherited;

  objDadosCliente := fBuscarDadosCliente(cdsCliCamp.FieldByName('CCM_CODCLI').AsString);

  If (Not fEmptyStr(objDadosCliente.strCodCli)) Then
  Begin
    cdsCliCamp.FieldByName('CCM_NOMCLI').AsString := objDadosCliente.strNomCli;
    cdsCliCamp.FieldByName('CCM_DESATI').AsString := objDadosCliente.strDesAti;
    cdsCliCamp.FieldByName('CCM_CIDEST').AsString := objDadosCliente.strCidEst;
    cdsCliCamp.FieldByName('CCM_CATEGO').AsString := objDadosCliente.strCatego;
    cdsCliCamp.FieldByName('CCM_REDLOJ').AsString := objDadosCliente.strDesRed;
    cdsCliCamp.FieldByName('CCM_CPFMAS').AsString := objDadosCliente.strCgcMas;
  End;
end;

procedure TfrmCadCampanhaVendas.cxgClientesDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_DELETE:
      If (Not cdsCliCamp.IsEmpty) then
      Begin
        If fPergunta('Deseja remover o cliente ' + cdsCliCamp.FieldByName('CCM_CODCLI').AsString + ' da campanha?') then
          cdsCliCamp.Delete;
      End;
  end;
end;

procedure TfrmCadCampanhaVendas.cxgGridCamCndViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_DELETE Then
  Begin
    If cdsCamCnd.Active And (cdsCamCnd.RecordCount > 0) And
       (fMensagem('', 'Deseja Remover a Condição de Pagamento?', ['&Sim', '&Não'], 2) = 1) Then
    Begin
      If Not fEmptyStr(cdsCamCnd.FieldByName('AUTINC').AsString) Then
        strCndExcluidos := strCndExcluidos + QuotedStr(cdsCamCnd.FieldByName('AUTINC').AsString) + ',';

      cdsCamCnd.Delete;

      If cdsCamCnd.IsEmpty Then
        pSetFocus(edtCodCnd);
    End;
  End;
end;

procedure TfrmCadCampanhaVendas.btnGenAdicionarClick(Sender: TObject);
  Var
    strOpcao: String;
begin
  inherited;

  If Not fValidaPanel(pnlGenerica) Then
    Exit;

  If Not cdsGenerica.Active Then
    cdsGenerica.CreateDataSet;

  if fEmptyStr(edtCodOpc.Text) Then
    Exit;

  strOpcao := IIF(fEmptyStr(cdsGenerica.FieldByName('OPCAO').AsString), '-1', cdsGenerica.FieldByName('OPCAO').AsString);
  If ((rdgOpcao.ItemIndex + 1) <> StrToInt(strOpcao)) And (strOpcao <> '-1') Then
  Begin

    If strOpcao = '1' Then
      fMensagem('ATENÇÃO!', 'Só é permitido incluir a opção de Linha/Grupo na campanha!' + #13 +
                'Para inserir outra opção, apague os itens de Linha/Grupo adicionados!' , ['&Ok'])
    Else If strOpcao = '2' Then
      fMensagem('ATENÇÃO!', 'Só é permitido incluir a opção de Fornecedor na campanha!' + #13 +
                'Para inserir outra opção, apague os itens de Fornecedor adicionados!' , ['&Ok'])
    Else
      fMensagem('ATENÇÃO!', 'Só é permitido incluir a opção de Marca na campanha!' + #13 +
                'Para inserir outra opção, apague os itens de Marca adicionados!' , ['&Ok']);


    pSetFocus(edtCodOpc);

    Exit;

  End;

  With cdsGenerica Do
  Begin

    If Locate('CODOPC', edtCodOpc.Text, []) Then
      Edit;

    If State = dsBrowse Then
    Begin

      Insert;
      FieldByName('AUTINC').AsString  := '';

    End;

    FieldByName('OPCAO').AsString  := IntToStr(rdgOpcao.ItemIndex + 1);
    FieldByName('CODOPC').AsString := edtCodOpc.Text;
    FieldByName('DESOPC').AsString := edtDesOpc.Text;
    FieldByName('VLRFAT').AsFloat  :=  fStrToFloat(edtVlrFat.Text);
    Post;

  End;

  pLimpaEdits(False, True, False, True);
  pSetFocus(edtCodOpc);

end;

procedure TfrmCadCampanhaVendas.btnCancelaClick(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(strCodCmgAnt) Then
  Begin
    edtCodCmg.Text := strCodCmgAnt;
    edtCodCmg.OnExit(Self);
    strCodCmgAnt := '';
    Exit;
  End;

  pLimpaEdits(True, True, True, True);
  pCancelaAltGlobal;
  pCancelarDados;
end;

procedure TfrmCadCampanhaVendas.btnGenCancelaItemClick(Sender: TObject);
begin
  inherited;

  If Not pnlCampanha.Enabled Then
  Begin
    pCancelarDados;
    Exit;
  End;

  If (ActiveControl.Parent = pnlGenerica) And (fEmptyStr(edtCodOpc.Text)) Then
    pCancelarDados
  Else
  Begin

    cdsGenerica.Cancel;
    pLimpaEdits(False, False, False, True);
    pSetFocus(edtCodOpc);

  End;

end;

procedure TfrmCadCampanhaVendas.rdgGiroClick(Sender: TObject);
begin
  inherited;

  pRecalculaValores;
end;

procedure TfrmCadCampanhaVendas.rdgOpcaoClick(Sender: TObject);
begin
  inherited;

  If rdgOpcao.ItemIndex = 0 Then
  Begin

    lblOpcao.Caption    := 'Linha/Grupo:';
    edtCodOpc.MaxLength := 4;
    edtCodOpc.TamCampo  := 4;
    edtCodOpc.CompZeros := False;

  End
  Else If rdgOpcao.ItemIndex = 1 Then
  Begin

    lblOpcao.Caption    := 'Fornecedor:';
    edtCodOpc.MaxLength := 8;
    edtCodOpc.TamCampo  := 8;
    edtCodOpc.CompZeros := True;

  End
  Else
  Begin

    lblOpcao.Caption    := 'Marca:';
    edtCodOpc.MaxLength := 3;
    edtCodOpc.TamCampo  := 3;
    edtCodOpc.CompZeros := True;

  End;

end;

procedure TfrmCadCampanhaVendas.pgcCampanhaChange(Sender: TObject);
begin
  inherited;
  btnCfgGrids.Enabled := (pgcCampanha.ActivePageIndex = 0);
end;

procedure TfrmCadCampanhaVendas.pgcDadosChange(Sender: TObject);
begin
  inherited;

  If (fCfgSis('SIMCAM', varBoolean)) And (pgcDados.ActivePage = tbsGenerica) Then
  Begin

    fMensagem('ATENÇÃO!', 'O sistema não está configurado para trabalhar com campanha genérica!', ['&Ok']);
    pgcDados.ActivePage := tbsProdutos;
    Exit

  End;

  If pgcDados.ActivePage = tbsProdutos Then
    If pnlProdutos.Enabled Then
      pSetFocus(edtCodIte)
    Else
      pSetFocus(dbgProdutos);

  If fEmptyStr(edtDesCmg.Text) And (pnlCampanha.Enabled) Then
  Begin
    edtCodCmg.Enabled := True;
    pSetFocus(edtCodCmg);
  End;

end;

procedure TfrmCadCampanhaVendas.pEscapePressed;
begin

  If (ActiveControl.Parent = pnlProdutos) Then
    btnCancelaItem.Click
  Else If ActiveControl.Parent = pnlGenerica Then
    btnGenCancelaItem.Click
  Else If ActiveControl.Parent = pnlDadosAdicionais Then
  Begin

    If pgcDados.ActivePage = tbsProdutos Then
      pSetFocus(edtCodIte)
    Else
      pSetFocus(edtCodOpc)

  End
  Else If (ActiveControl.Parent = pnlCampanha) And (Not edtCodCmg.Focused) Then
    pCancelarDados
  Else
    inherited;

end;


{*******************************************}
{* CANCELA DADOS NA TELA E VOLTA O FOCO    *}
{* O INÍCIO DA TELA                        *}
{****************************************RL*}
procedure TfrmCadCampanhaVendas.pCancelaAltGlobal;
begin
  If blnAltGlobal Then
  Begin
    blnAltGlobal        := False;
    lblQtdIte.Visible   := True;
    edtQtdIte.Visible   := True;
    lblPreCus.Visible   := True;
    edtPreCus.Visible   := True;
    lblPreClq.Visible   := True;
    edtPreClq.Visible   := True;
    rdgGlobal.Visible   := False;
    dbgProdutos.Enabled := True;

    lblPreco.Caption := 'Preço Contrato:';
  End;
end;

procedure TfrmCadCampanhaVendas.pCancelarDados;
Begin

  FcdsProdutosExcluidos.EmptyDataSet;
  strGenExcluidos  := '';
  strCndExcluidos  := '';

  If fEmptyStr(objCamGer.strCodCmg) Then
  Begin
    cdsProdutos.Cancel;
    cdsProdutos.EmptyDataSet;

    cdsGenerica.Cancel;
    cdsGenerica.EmptyDataSet;

    cdsCamCnd.Cancel;
    cdsCamCnd.EmptyDataSet;

    pLimpaEdits(True, True, True, True);
    pAtualizaCampos(True);

    edtCodCmg.Enabled := True;
    pSetFocus(edtCodCmg);
  End
  Else
  Begin
    pAtualizaCampos(False);
    edtCodCmg.Enabled := False;
    pSetFocus(edtDesCmg);
  End;

  pHabilitaFuncao(opConsulta);

End;

function TfrmCadCampanhaVendas.fConsisteSimilaridade(strCodIte: String): Boolean;
  Var
    BookMark : TBookMark;
    strCodSim: String;
Begin

  Result := False;

  BookMark  := cdsProdutos.GetBookmark;
  strCodSim := objCamGer.objCamDet.fRetornaSimilaridade(strCodIte);

  With cdsProdutos Do
  Begin

    DisableControls;
    First;

    While Not Eof do
    Begin

      If (strCodSim = FieldByName('ITESIM').AsString) And (strCodIte <> FieldByName('CODITE').AsString) And
        (Not fEmptyStr(FieldByName('ITESIM').AsString)) Then
      Begin

        fMensagem('', 'Não é permitido adicionar o produto ' + strCodIte + '.' + #13 +
                      'Ele é um produto similar a outro produto já adicionado na campanha!', ['&Ok']);
        Result := True;
        Break;

      End;

      Next;

    End;

  End;

  cdsProdutos.GotoBookmark(BookMark);
  cdsProdutos.FreeBookmark(BookMark);
  cdsProdutos.EnableControls;

End;

procedure TfrmCadCampanhaVendas.pTotalizaRodape;
  Var
    cdsGen: TUniClientDataSet;
    fldRLIQAC,
    fldRLIQQT,
    fldRESPER,
    fldTOTCU3,
    fldTOTIT3,
    fldCUSCTR,
    fldVLRUNI,
    fldTOTITE,
    fldTOTCU2: TAggregateField;
    fltValor: Double;
begin
  lblTotFat.Caption := dbeTotFat.Text;

  cdsGen := TUniClientDataSet.Create(Self);

  fldTOTITE := fCriaAggregateField(cdsGen, 'TTOTITE', 'SUM(TOTITE)', ',0.00');
  fldTOTCU2 := fCriaAggregateField(cdsGen, 'TTOTCU2', 'SUM(TOTCU2)', ',0.00');
  fldCUSCTR := fCriaAggregateField(cdsGen, 'TCUSCTR', 'SUM(CUSCTR)', ',0.00');
  fldVLRUNI := fCriaAggregateField(cdsGen, 'TVLRUNI', 'SUM(VLRUNI)', ',0.00');
  fldTOTCU3 := fCriaAggregateField(cdsGen, 'TTOTCU3', 'SUM(TOTCU3)', ',0.00');
  fldTOTIT3 := fCriaAggregateField(cdsGen, 'TTOTIT3', 'SUM(TOTIT3)', ',0.00');

  fldRLIQAC := fCriaAggregateField(cdsGen, 'TRLIQAC', 'SUM(RLIQAC)', ',0.00');
  fldRLIQQT := fCriaAggregateField(cdsGen, 'TRLIQQT', 'SUM(RLIQQT)', ',0.00');
  fldRESPER := fCriaAggregateField(cdsGen, 'TRESPER', 'SUM(RESPER)', ',0.00');

  With cdsGen Do
  Begin
    Data := cdsProdutos.Data;
    AggregatesActive := True;

    If (fldTOTCU2.Value > 0) And (fldTOTITE.Value > 0) Then
    Begin
      fltValor := (1-(fldTOTCU2.Value/fldTOTITE.Value))*100;
      edtTotMARGEM.Text := FormatFloat(',0.00', fltValor);
    End
    Else
      edtTotMARGEM.Text := '0,00';

    If (fldCUSCTR.Value > 0) And (fldVLRUNI.Value > 0) Then
    Begin
      fltValor := (1-(fldCUSCTR.Value/fldVLRUNI.Value))*100;
      edtTotMARLIQ.Text := FormatFloat(',0.00', fltValor);
    End
    Else
      edtTotMARLIQ.Text := '0,00';

    If (fldTOTCU3.Value > 0) And (fldTOTIT3.Value > 0) Then
    Begin
      fltValor := (1-(fldTOTCU3.Value/fldTOTIT3.Value))*100;
      edtTotMARPER.Text := FormatFloat(',0.00', fltValor);
    End
    Else
      edtTotMARPER.Text := '0,00';

    If fldRLIQAC.Value > 0 Then
      edtTotRLIQAC.Text := FormatFloat(',0.00', fldRLIQAC.Value)
    Else
      edtTotRLIQAC.Text := '0,00';

    If fldRLIQQT.Value > 0 Then
      edtTotRLIQQT.Text := FormatFloat(',0.00', fldRLIQQT.Value)
    Else
      edtTotRLIQQT.Text := '0,00';

    If fldRESPER.Value > 0 Then
      edtTotRESPER.Text := FormatFloat(',0.00', fldRESPER.Value)
    Else
      edtTotRESPER.Text := '0,00';
  End;

  FreeAndNil(fldTOTITE);
  FreeAndNil(fldTOTCU2);
  FreeAndNil(fldCUSCTR);
  FreeAndNil(fldVLRUNI);
  FreeAndNil(fldTOTCU3);
  FreeAndNil(fldTOTIT3);
  FreeAndNil(fldRLIQAC);
  FreeAndNil(fldRLIQQT);
  FreeAndNil(fldRESPER);

  FreeAndNil(cdsGen);
End;

procedure TfrmCadCampanhaVendas.pAtualizaDadosGenerica(DataSet: TDataSet);
begin

  If cdsGenerica.IsEmpty Then
    rdgOpcao.Enabled := True
  Else
    rdgOpcao.Enabled := False;

end;

procedure TfrmCadCampanhaVendas.pHabilitaFuncao(opFuncao : TOperacao);
begin

  Case opFuncao Of
  opInclusao:
    Begin
      btnIncluir.Enabled  := False;
      btnGravar.Enabled   := True;
      btnAlterar.Enabled  := False;
      btnExcluir.Enabled  := False;
      btnCancela.Enabled  := True;
      btnReajuste.Enabled := False;
      btnHeranca.Enabled  := True;
      btnImportar.Enabled := True;

      pnlCampanha.Enabled        := True;

      pnlDadosAdicionais.Enabled := True;
      pnlProdutos.Enabled        := True;
      pnlGenerica.Enabled        := True;
      pnlCamCnd.Enabled          := True;

      dbgProdutosTVQTDITE.Options.Editing := True;
      dbgProdutosTVVLRUNI.Options.Editing := True;
      dbgProdutosTVPRECLQ.Options.Editing := True;
      dbgProdutosTVPRECUS.Options.Editing := True;
      dbgAnaliseTVQTDITE.Options.Editing  := True;
      cxgGridCamCnd.Enabled               := True;

      pnlPesqCli.Enabled := True;
      cxgClientes.Enabled := True;

      pSetFocus(edtDesCmg);
    End;
  opAlteracao:
    Begin
      btnIncluir.Enabled  := True;
      btnGravar.Enabled   := True;
      btnAlterar.Enabled  := False;
      btnExcluir.Enabled  := True;
      btnCancela.Enabled  := True;
      btnReajuste.Enabled := True;
      btnHeranca.Enabled  := True;
      btnImportar.Enabled := True;

      pnlCampanha.Enabled        := True;
      pnlDadosAdicionais.Enabled := True;
      pnlProdutos.Enabled        := True;
      pnlGenerica.Enabled        := True;
      pnlCamCnd.Enabled          := True;

      dbgProdutosTVQTDITE.Options.Editing := True;
      dbgProdutosTVVLRUNI.Options.Editing := True;
      dbgProdutosTVPRECLQ.Options.Editing := True;
      dbgProdutosTVPRECUS.Options.Editing := True;
      dbgAnaliseTVQTDITE.Options.Editing  := True;
      cxgGridCamCnd.Enabled               := True;

      pnlPesqCli.Enabled := True;
      cxgClientes.Enabled := True;

      pSetFocus(edtDesCmg);
    End;
  opConsulta:
    Begin
      btnIncluir.Enabled  := True;
      btnGravar.Enabled   := False;
      btnAlterar.Enabled  := True;
      btnExcluir.Enabled  := True;
      btnCancela.Enabled  := False;
      btnReajuste.Enabled := False;
      btnHeranca.Enabled  := False;
      btnImportar.Enabled := False;

      pnlCampanha.Enabled        := False;
      pnlDadosAdicionais.Enabled := False;
      pnlProdutos.Enabled        := False;
      pnlGenerica.Enabled        := False;
      pnlCamCnd.Enabled          := False;

      dbgProdutosTVQTDITE.Options.Editing := False;
      dbgProdutosTVVLRUNI.Options.Editing := False;
      dbgProdutosTVPRECLQ.Options.Editing := False;
      dbgProdutosTVPRECUS.Options.Editing := False;
      dbgAnaliseTVQTDITE.Options.Editing  := False;
      cxgGridCamCnd.Enabled               := False;

      pnlPesqCli.Enabled := False;
      cxgClientes.Enabled := False;

      pSetFocus(dbgProdutos);
    End;
  End;
end;

procedure TfrmCadCampanhaVendas.pApagaRegistroTabela(strTabela, strCampo: String);
  Var
    qryDelete: TUniQuery;
begin
  {********************************************************}
  {* GRAVA A TABELA DEL_XXXXXX E APAGA A TABELA PRINCIPAL *}
  {*REQ.171755******************************************RP*}

  qryDelete := fCriaQuery;
  Try
    qryDelete.SQL.Add('SELECT * FROM '+ strTabela);
    qryDelete.SQL.Add(' WHERE '+ strCampo +' = '+ QuotedStr(edtCodCmg.Text));
    qryDelete.Open;

    qryDelete.First;
    While Not qryDelete.Eof Do
    Begin
      fVerificaIntegridade(Self.Name, strTabela, qryDelete);
      qryDelete.Delete;
    End;
  Finally
    FreeAndNil(qryDelete);
  End;
end;

procedure TfrmCadCampanhaVendas.pAtualizaCampos(blnLimpa : Boolean);
Var
  lstClientes : TList<String>;
begin
  cdsProdutos.EmptyDataSet;
  cdsProdutos.Close;
  cdsProdutos.Open;

  cdsGenerica.EmptyDataSet;
  cdsGenerica.Close;
  cdsGenerica.Open;

  cdsCamCnd.EmptyDataSet;
  cdsCamCnd.Close;
  cdsCamCnd.Open;

  cdsCliCamp.EmptyDataSet;
  cdsCliCamp.Close;
  cdsCliCamp.Open;

  If blnLimpa Then
  Begin
    objCamGer.pLimpaDadosGer;
    Exit;
  End;

  edtCodCmg.Text := objCamGer.strCodCmg;
  edtDesCmg.Text := objCamGer.strDesCmg;
  edtBrinde.Text := objCamGer.strBrinde;
  edtObs1.Text   := objCamGer.strObs_01;
  edtObs2.Text   := objCamGer.strObs_02;
  edtObs3.Text   := objCamGer.strObs_03;
  mskDtaEnt.Text := objCamGer.strDtaEnt;
  mskDtaIni.Text := objCamGer.strDtaIni;
  mskDtaFin.Text := objCamGer.strDtaFin;
  edtAtiva.Text  := objCamGer.strAtiva_;

  edtCodCnd.Clear;
  edtDesCnd.Clear;
  edtForPag.Clear;
  edtDesPag.Clear;
  pCarregaCondicaoPagamento(objCamGer.strCodCmg);

  lstClientes := objCamGer.fCarregaCamCli(objCamGer.strAutInc);
  pCarregaClientes(lstClientes);
  FreeAndNil(lstClientes);

  If pnlCampanha.Enabled Then
    If pgcDados.ActivePage = tbsProdutos Then
      pSetFocus(edtCodIte)
    Else
      pSetFocus(edtCodOpc);

  Try
    blnBuscaCampanhaPorCodigo := True;
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fAdicionaItens;
    frmGravando.ShowModal;
    blnBuscaCampanhaPorCodigo := False;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  pFreeAndNil(frmGravando);

  objCamGer.objCamGen.pCarregaCamGen(objCamGer.strCodCmg);

  With objCamGer.objCamGen.qryCamGen Do
  Begin

    While Not Eof Do
    Begin

      cdsGenerica.Insert;
      cdsGenerica.FieldByName('OPCAO').AsString  := FieldByName('GEN_OPCAO_').AsString;

      If FieldByName('GEN_OPCAO_').AsString = '1' Then
      Begin
        cdsGenerica.FieldByName('CODOPC').AsString := FieldByName('GEN_CODGRU').AsString;
        cdsGenerica.FieldByName('DESOPC').AsString := fRetNomeLinhaGrupo(FieldByName('GEN_CODGRU').AsString);
        rdgOpcao.ItemIndex := 0;
      End
      Else If FieldByName('GEN_OPCAO_').AsString = '2' Then
      Begin
        cdsGenerica.FieldByName('CODOPC').AsString := FieldByName('GEN_CODFOR').AsString;
        cdsGenerica.FieldByName('DESOPC').AsString := fRetNomFornecedor(FieldByName('GEN_CODFOR').AsString);
        rdgOpcao.ItemIndex := 1;
      End
      Else
      Begin
        cdsGenerica.FieldByName('CODOPC').AsString := FieldByName('GEN_CODMAR').AsString;
        cdsGenerica.FieldByName('DESOPC').AsString := fRetNomMarca(FieldByName('GEN_CODMAR').AsString);
        rdgOpcao.ItemIndex := 2;
      End;

      cdsGenerica.FieldByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
      cdsGenerica.FieldByName('VLRFAT').AsFloat  := FieldByName('GEN_VLRFAT').AsFloat;
      cdsGenerica.Post;

      Next;

    End;

    cdsGenerica.First;

    If Not cdsGenerica.IsEmpty Then
      rdgOpcao.Enabled := False;

  End;
end;

function TfrmCadCampanhaVendas.fCriaCdsProdutos(AOwner: TComponent): TUniClientDataSet;
Begin
  Result := TUniClientDataSet.Create(AOwner);
  Result.AggregatesActive := True;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CODITE';
    DataType:= ftString;
    Size:= fTamCodIte;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CORSIT';
    DataType:= ftString;
    Size:= 80;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'DESITE';
    DataType:= ftString;
    Size:= 150;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'QTDITE';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'VLRUNI';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'VLRITE';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'PRECLQ';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'PRECUS';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'PRECTR';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'ITESIM';
    DataType:= ftString;
    Size:= 6
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'AUTINC';
    DataType:= ftString;
    Size:= 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'NOMFOR';
    DataType:= ftString;
    Size:= 80;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'DEPDES';
    DataType:= ftString;
    Size:= 80;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'ULTVEN';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'NVLGIR';
    DataType:= ftString;
    Size:= 3;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'NVLCRI';
    DataType:= ftString;
    Size:= 3;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'ESTMIN';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'ESTMAX';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'GICPMD';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'GIRP03';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'GIRP06';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'GIRP12';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'MARGEM';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CUSCTR';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'MARLIQ';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'RESLIQ';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'RLIQGI';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'RLIQQT';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'VENPER';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'PEROBJ';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'ULTPRE';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'MARPER';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'RLIQAC';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'RESPER';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'ITECUS';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'ITEOUT';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'ICMSAI';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'IMPFED';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'DESOPE';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'PERACT';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'QTDPER';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'TOTCUS';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'TOTCU2';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'TOTITE';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'TOTCU3';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'TOTIT3';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CODGRU';
    DataType:= ftString;
    Size:= 6;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CODFOR';
    DataType:= ftString;
    Size:= 8;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CODMAR';
    DataType:= ftString;
    Size:= 6;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CLAIPI';
    DataType:= ftString;
    Size:= 10;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'REFERE';
    DataType:= ftString;
    Size:= 16;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CODUNI';
    DataType:= ftString;
    Size:= 2;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'SITPRO';
    DataType:= ftString;
    Size:= 3;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CLACRM';
    DataType:= ftString;
    Size:= 1;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'IDEPRO';
    DataType:= ftString;
    Size:= 3;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'ITETIN';
    DataType:= ftString;
    Size:= 200;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'TINDES';
    DataType:= ftString;
    Size:= 100;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'TINVOL';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CODPCL';
    DataType:= ftString;
    Size:= 20;
  End;

  Result.CreateDataSet;
End;

function TfrmCadCampanhaVendas.fCriaCdsProdutosExcluidos(AOwner: TComponent): TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(AOwner);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CODITE';
    DataType:= ftString;
    Size:= 5;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'IDEPRO';
    DataType:= ftString;
    Size:= 3;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'ITETIN';
    DataType:= ftString;
    Size:= 200;
  End;

  Result.CreateDataSet;
end;

function TfrmCadCampanhaVendas.fCriaCdsCondicao(AOwner: TComponent): TUniClientDataSet;
Begin
  Result := TUniClientDataSet.Create(AOwner);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CND_CODCMG';
    DataType:= ftString;
    Size:= 6;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CND_CODCND';
    DataType:= ftString;
    Size:= 3;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CND_CODFPG';
    DataType:= ftString;
    Size:= 3;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CND_DESCRI';
    DataType:= ftString;
    Size:= 60;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CND_DESFPG';
    DataType:= ftString;
    Size:= 60;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'AUTINC';
    DataType:= ftString;
    Size:= 20;
  End;

  Result.CreateDataSet;
end;

function TfrmCadCampanhaVendas.fCriaCdsGenerica(AOwner: TComponent): TUniClientDataSet;
Begin
  Result := TUniClientDataSet.Create(AOwner);
  Result.AggregatesActive := True;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CODOPC';
    DataType:= ftString;
    Size:= 10;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'DESOPC';
    DataType:= ftString;
    Size:= 100;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'VLRFAT';
    DataType:= ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'OPCAO';
    DataType:= ftString;
    Size:= 1;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'AUTINC';
    DataType:= ftString;
    Size:= 20;
  End;

  Result.CreateDataSet;
End;

procedure TfrmCadCampanhaVendas.pBeforePost(DataSet: TDataSet);
begin
  inherited;

  pCalculaValores;

end;

procedure TfrmCadCampanhaVendas.pCalculaValores;
Begin
  With cdsProdutos Do
  Begin
    Case fMesesGiro Of
      3:  FieldByName('GICPMD').AsFloat := FieldByName('GIRP03').AsFloat;
      6:  FieldByName('GICPMD').AsFloat := FieldByName('GIRP06').AsFloat;
      12: FieldByName('GICPMD').AsFloat := FieldByName('GIRP12').AsFloat;
    End;

    FieldByName('PERACT').AsFloat := FieldByName('VENPER').AsFloat/
                                                 FieldByName('GICPMD').AsFloat;

    FieldByName('CUSCTR').AsFloat := FieldByName('ITECUS').AsFloat +
                                                 FieldByName('ITEOUT').AsFloat +
                                                 ((FieldByName('ICMSAI').AsFloat*FieldByName('VLRUNI').AsFloat)/100) +
                                                 ((FieldByName('IMPFED').AsFloat*FieldByName('VLRUNI').AsFloat)/100) +
                                                 ((FieldByName('DESOPE').AsFloat*FieldByName('VLRUNI').AsFloat)/100);

    If (FieldByName('CUSCTR').AsFloat > 0) And (FieldByName('VLRUNI').AsFloat > 0) Then
      FieldByName('MARLIQ').AsFloat := (1-(FieldByName('CUSCTR').AsFloat/FieldByName('VLRUNI').AsFloat))*100
    Else
      FieldByName('MARLIQ').AsFloat := 0;

    FieldByName('RESLIQ').AsFloat := (FieldByName('GICPMD').AsFloat*
                                                  FieldByName('ULTVEN').AsFloat)*
                                                  (FieldByName('MARGEM').AsFloat/100);

    FieldByName('RLIQGI').AsFloat := (FieldByName('GICPMD').AsFloat*
                                                  FieldByName('VLRUNI').AsFloat)*
                                                  (FieldByName('MARLIQ').AsFloat/100);


    FieldByName('RLIQQT').AsFloat := (FieldByName('QTDITE').AsFloat*
                                                  FieldByName('VLRUNI').AsFloat)*
                                                  (FieldByName('MARLIQ').AsFloat/100);

    FieldByName('RLIQAC').AsFloat := (FieldByName('GICPMD').AsFloat*
                                                  FieldByName('ULTPRE').AsFloat)*
                                                  (FieldByName('MARGEM').AsFloat/100);


    FieldByName('RESPER').AsFloat := (FieldByName('QTDPER').AsFloat*
                                                  FieldByName('VLRUNI').AsFloat)*
                                                  (FieldByName('MARPER').AsFloat/100);

    FieldByName('VLRITE').AsString := FloatToStrF(FieldByName('QTDITE').AsFloat * FieldByName('VLRUNI').AsFloat, ffFixed, 12, 2);                                              
  End;
End;

function TfrmCadCampanhaVendas.fEfetuaAlteracaoGlobal(pgbStatus: TcxProgressBar): Boolean;
var
  prcScroll: TprcScroll;
  intRecNo : Integer;
  fltVlrIte,
  fltCusto,
  fltImpostos: Double;

  function fCalculaPrecoPelaMargem(fltMargem, fltPreCus, fltImpostos : Double) : Double;
  begin
    Result := fltPreCus / (1-((fltMargem+fltImpostos) / 100));
  end;

begin
  Result := True;

  pInfoStatusGravacao(pgbStatus, 'Aguarde, Aplicando Reajuste Global...', cdsProdutos.RecordCount);

  pDisableControls(cdsProdutos, prcScroll);
  intRecNo := cdsProdutos.RecNo;

  Try

    cdsProdutos.First;
    While Not cdsProdutos.Eof Do
    Begin
      pStepStatusGravacao(pgbStatus);

      If fProdutoFiltrado Then
      Begin
        cdsProdutos.Edit;

        fltVlrIte := fStrToFloat(edtVlrIte.Text);

        Case rdgGlobal.ItemIndex Of
        0:
          Begin
            If blnAltPorFator Then
              cdsProdutos.FieldByName('QTDITE').AsFloat := cdsProdutos.FieldByName('QTDITE').AsFloat * fltVlrIte
            Else
              cdsProdutos.FieldByName('QTDITE').AsFloat := fltVlrIte;
          End;
        1:
          Begin
            If blnAltPorFator Then
              cdsProdutos.FieldByName('VLRUNI').AsFloat  := cdsProdutos.FieldByName('VLRUNI').AsFloat * fltVlrIte
            Else
              cdsProdutos.FieldByName('VLRUNI').AsFloat  := fltVlrIte;
          End;
        2:
          Begin
            fltCusto    := cdsProdutos.FieldByName('ITECUS').AsFloat +
                           cdsProdutos.FieldByName('ITEOUT').AsFloat;
            fltimpostos := cdsProdutos.FieldByName('ICMSAI').AsFloat +
                           cdsProdutos.FieldByName('IMPFED').AsFloat +
                           cdsProdutos.FieldByName('DESOPE').AsFloat;

            If blnAltPorFator Then
              cdsProdutos.FieldByName('VLRUNI').AsFloat  := fCalculaPrecoPelaMargem(cdsProdutos.FieldByName('MARLIQ').AsFloat * fltVlrIte,
                                                                                    fltCusto,
                                                                                    fltImpostos)
            Else
              cdsProdutos.FieldByName('VLRUNI').AsFloat  := fCalculaPrecoPelaMargem(fltVlrIte,
                                                                                    fltCusto,
                                                                                    fltImpostos);
          End;
        End;

        cdsProdutos.FieldByName('VLRITE').AsString := FloatToStrF(cdsProdutos.FieldByName('QTDITE').AsFloat * cdsProdutos.FieldByName('VLRUNI').AsFloat, ffFixed, 12, 2);
        pCalculaValores;
        cdsProdutos.Post;
      End;
      cdsProdutos.Next;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
      Exit;
    End;
  End;

  pLimpaEdits(False, True);
  edtVlrIte.Clear;
  cdsProdutos.RecNo := intRecNo;
  pEnableControls(cdsProdutos, prcScroll);
end;

function TfrmCadCampanhaVendas.fGetChaveLayoutGridAnalise: String;
begin
  Result := Self.Name + '.' + dbgProdutosAnalise.Name;
end;

function TfrmCadCampanhaVendas.fGetChaveLayoutGridGenerica: String;
begin
  Result := Self.Name + '.' + dbgGenerica.Name;
end;

function TfrmCadCampanhaVendas.fGetChaveLayoutGridProdutos: String;
begin
  Result := Self.Name + '.' + dbgProdutos.Name;
end;

function TfrmCadCampanhaVendas.fConfirmaImportacaoDocumento(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
begin
  Result := objCamGer.fTemItensParaImportar(strNumDoc, strEspDoc, strCodEmp, strImpTabela, strImpPrefix);
end;

function TfrmCadCampanhaVendas.fMesesGiro: Integer;
begin
  Result := 3;

  Case rdgGiro.ItemIndex Of
   0: Result := 3;
   1: Result := 6;
   2: Result := 12;
  End;
end;

Procedure TfrmCadCampanhaVendas.pRecalculaValores;
var
  intRecNo : Integer;
  prcScroll: TprcScroll;
Begin
  pDisableControls(cdsProdutos, prcScroll);
  intRecNo := cdsProdutos.RecNo;

  Try

    cdsProdutos.First;
    While Not cdsProdutos.Eof Do
    Begin
      cdsProdutos.Edit;
      pCalculaValores;
      cdsProdutos.Post;

      cdsProdutos.Next;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
      Exit;
    End;
  End;

  cdsProdutos.RecNo := intRecNo;
  pEnableControls(cdsProdutos, prcScroll);
End;

function TfrmCadCampanhaVendas.fProdutoFiltrado: Boolean;
Begin
  Result := True;

  With cdsProdutos do
  Begin
    If (Not fEmptyStr(edtCodIte.Text)) Then
      Result := (FieldByName('CODITE').AsString = edtCodIte.Text);

    If Result And (Not fEmptyStr(mskLinhaGrupo.Text)) Then
      Result := (FieldByName('CODGRU').AsString = mskLinhaGrupo.Text);

    If Result And (Not fEmptyStr(edtFornecedor.Text)) Then
      Result := (FieldByName('CODFOR').AsString = edtFornecedor.Text);

    If Result And (Not fEmptyStr(edtMarca.Text)) Then
      Result := (FieldByName('CODMAR').AsString = edtMarca.Text);

    If Result And (Not fEmptyStr(edtDescriIni.Text)) Then
      Result := (Pos(edtDescriIni.Text, FieldByName('DESITE').AsString) > 0);

    If Result And (Not fEmptyStr(edtDescriFin.Text)) Then
      Result := (Pos(edtDescriFin.Text, FieldByName('DESITE').AsString) > 0);

    If Result And (Not fEmptyStr(edtClaIPI.Text)) Then
      Result := (Pos(edtClaIPI.Text, FieldByName('CLAIPI').AsString) > 0);

    If Result And (Not fEmptyStr(edtRefere.Text)) Then
      Result := (FieldByName('REFERE').AsString = edtRefere.Text);

    If Result And (Not fEmptyStr(edtUnidade.Text)) Then
      Result := (FieldByName('CODUNI').AsString = edtUnidade.Text);

    If Result And (Not fEmptyStr(edtCodSit.Text)) Then
      Result := (FieldByName('SITPRO').AsString = edtCodSit.Text);

    If Result And (Not fEmptyStr(edtClaCRM.Text)) Then
      Result := (FieldByName('CLACRM').AsString = edtClaCRM.Text);
  End;

End;

procedure TfrmCadCampanhaVendas.pCarregaCondicaoPagamento(strCodCmg: String);
Begin
  With qryCamCnd, SQL Do
  Begin
    Close;

    Clear;
    Add('SELECT');
    Add('  CA.AUTOINCREM, ');
    Add('  CA.CND_CODCMG, ');
    Add('  CA.CND_CODCND, ');
    Add('  CN.CND_DESCRI, ');
    Add('  CA.CND_CODFPG, ');
    Add('  CONCAT(FPG_CODIGO, " - ", FPG_DESCRI) AS CND_DESFPG ');
    Add('FROM ');
    Add('  CAMCND CA ');
    Add('INNER JOIN CADCND CN ON CN.CND_CODIGO = CA.CND_CODCND ');
    Add('INNER JOIN CADFPG FP ON FP.FPG_CODIGO = CA.CND_CODFPG ');
    Add('WHERE ');
    Add('  CA.CND_CODCMG = :CODCMG ');

    ParamByName('CODCMG').AsString := strCodCmg;

    Open;
    First;
    While Not Eof Do
    Begin
      cdsCamCnd.Insert;
      cdsCamCnd.FieldByName('AUTINC').AsString     := FieldByName('AUTOINCREM').AsString;
      cdsCamCnd.FieldByName('CND_CODCMG').AsString := FieldByName('CND_CODCMG').AsString;
      cdsCamCnd.FieldByName('CND_CODCND').AsString := FieldByName('CND_CODCND').AsString;
      cdsCamCnd.FieldByName('CND_CODFPG').AsString := FieldByName('CND_CODFPG').AsString;
      cdsCamCnd.FieldByName('CND_DESCRI').AsString := FieldByName('CND_DESCRI').AsString;
      cdsCamCnd.FieldByName('CND_DESFPG').AsString := FieldByName('CND_DESFPG').AsString;
      cdsCamCnd.Post;

      Next;
    End;
  End;
End;

procedure TfrmCadCampanhaVendas.pIncluiCondicaoPagamento;
Begin
  If Not cdsCamCnd.Active Then
    pCarregaCondicaoPagamento('');

  With cdsCamCnd Do
  Begin

    If (Not fEmptyStr(edtCodCnd.Text)) And fValidaCampos(edtCodCnd, True) And
       (Not fEmptyStr(edtForPag.Text)) And fValidaCampos(edtForPag, True) Then
    Begin

      If Not Locate('CND_CODCND;CND_CODFPG', VarArrayOf([edtCodCnd.Text,edtForPag.Text]), []) Then
      Begin
        Insert;
        FieldByName('AUTINC').AsString     := fRetAutoIncrem('CAMCND', VS_strCodEmp);
        FieldByName('CND_CODCMG').AsString := edtCodCmg.Text;
        FieldByName('CND_CODCND').AsString := edtCodCnd.Text;
        FieldByName('CND_CODFPG').AsString := edtForPag.Text;
        FieldByName('CND_DESCRI').AsString := edtDesCnd.Text;
        FieldByName('CND_DESFPG').AsString := edtForPag.Text + ' - ' + edtDesPag.Text;
        Post;
      End;

      edtCodCnd.Clear;
      edtDesCnd.Clear;
      edtForPag.Clear;
      edtDesPag.Clear;

      pSetFocus(edtCodCnd);
    End

  End;

End;

procedure TfrmCadCampanhaVendas.pGravaCondicaoPagamento;
Begin
  edtCodCnd.Clear;
  edtDesCnd.Clear;

  If Not cdsCamCnd.Active Then
    Exit;

  With cdsCamCnd Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      objCamGer.fGravaCamCnd(FieldByName('AUTINC').AsString,
                             objCamGer.strCodCmg,
                             FieldByName('CND_CODCND').AsString,
                             FieldByName('CND_CODFPG').AsString);

      Next;
    End;

    EnableControls;
  End;
End;

function TfrmCadCampanhaVendas.fCodProdCliJaCadastrado(strCodIte, strCodProcCli : String): Boolean;
Var prcScroll : TprcScroll;
    intRecNo  : Integer;
begin
  Result := False;
  intRecNo := cdsProdutos.RecNo;
  Try
    pDisableControls(cdsProdutos, prcScroll);
    If cdsProdutos.Locate('CODPCL', strCodProcCli, []) Then
      Result := (cdsProdutos.FieldByName('CODITE').asString <> strCodIte)
  Finally
    cdsProdutos.RecNo := intRecNo;
    pEnableControls(cdsProdutos, prcScroll);
  End;
end;


function TfrmCadCampanhaVendas.fValidaCodProdCliente : Boolean;
{FUNCAO NECESSARIA PARA FAZER A VALIDAÇÃO DOS CODIGOS DE PRODUTOS DO CLIENTE NA GRAVAÇÃO FINAL,
 POIS É POSSIVEL ALTERAR O CLIENTE OU A REDE APÓS INSERIR TODOS OS PRODUTOS - KM}
Var prcScroll : TprcScroll;
    intRecNo  : Integer;

begin
  Result := True;

  If not fCfgSis('CIPCAM', varBoolean) Then
    Exit;

  cdsProdutos.First;
  pDisableControls(cdsProdutos, prcScroll);
  intRecNo := cdsProdutos.RecNo;
  While Not cdsProdutos.Eof Do
  Begin
    If not fEmptyStr(cdsProdutos.FieldByName('CODPCL').asString) Then
    Begin
      Try
        cdsCliCamp.DisableControls;

        cdsCliCamp.First;
        While Not cdsCliCamp.Eof Do
        Begin
          If objCamGer.fVerificaCodigoProdutoCliente(cdsCliCamp.FieldByName('CCM_CODCLI').AsString, cdsProdutos.FieldByName('CODPCL').asString, edtCodCmg.Text) <> '-1' Then
          Begin
            fMensagem('ATENÇÃO!', 'Código do produto cliente - "' + cdsProdutos.FieldByName('CODPCL').asString + '" já foi informado em outra campanha ativa do cliente ou rede do cliente! Não será possível gravar.', ['&Ok']);
            Result := False;
            Break
          End;
          cdsCliCamp.Next;
        End;
      Finally
        cdsCliCamp.First;
        cdsCliCamp.EnableControls;
      End;
    End;
    cdsProdutos.Next;
  End;
  cdsProdutos.RecNo := intRecNo;
  pEnableControls(cdsProdutos, prcScroll);
End;

procedure TfrmCadCampanhaVendas.AposCarregarLinhaPlanilha(Linha: TLinha; var PararProcessamento: Boolean);
begin

  Try

    blnInseriu := True;

    edtCodIte.Text := Linha.strCodigoItem;
    edtCodProdCliente.Text := Linha.strCodigoItemCliente;
    edtQtdIte.Text := FloatToStr(Linha.fltQuantidade);
    edtPreCus.Text := FloatToStr(Linha.fltPrecoCusto);
    edtPreClq.Text := FloatToStr(Linha.fltPrecoCompraLiquido);
    edtVlrIte.Text := FloatToStr(Linha.fltPrecoContrato);

    if Trim(edtCodIte.Text) = '' Then
    Begin
      fMensagem('','O Código AutCom não pode ser branco!', ['&OK']);
      blnInseriu := False;
    End;


    if fStrToFloat(edtQtdIte.Text) = 0 Then
    Begin
      fMensagem('','A Quantidade não pode ser zero!', ['&OK']);
      blnInseriu := False;
    End;


    if fStrToFloat(edtVlrIte.Text) = 0 Then
    Begin
      fMensagem('','O preço de Contrato não pode ser zero!', ['&OK']);
      blnInseriu := False;
    End;

    if blnInseriu Then
      btnConfirmar.Click();

    If Not blnInseriu Then
    Begin
      If Not fPergunta('O item anterior não foi inserido, deseja continuar?') Then
         PararProcessamento := True;
    End;

  Finally
    pTotalizaRodape;
    Application.ProcessMessages;
  end;

end;

end.

