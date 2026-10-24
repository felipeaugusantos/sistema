unit untCadCashback;

interface

uses
  Windows, Controls, Forms, untPaiCad, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  DBEditFocus, AppEvnts, DB, BitBtnLockedIncrem, Mask, DBCtrls, Menus, Classes,
  SysUtils, QColorLabel, frxClass, frxExportCSVTestabilidade, MaskEditFocus,
  EditFocus, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  Datasnap.DBClient, UniClientDataSet, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  untConsultas, untTypesSistema, MemDS, DBAccess, Uni, untMskC_G_C_, cxGridCitel,
  cxProgressBar;

type
  TFuncRetornoPequisa = function(strCodigo: String): String;
  TFuncRetornoPequisaComConst = function(const strCodigo: String): String;

  TfrmCadCashback = class(TfrmPaiCad)
    pnlCentral: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDescri: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    dtsCadCsh: TDataSource;
    lbl1: TLabel;
    lbl2: TColorLabel;
    dbeTipPes: TDBEditFocus;
    Label3: TLabel;
    dbeIniVig: TDBEditFocus;
    Label4: TLabel;
    dbeFinVig: TDBEditFocus;
    gpbGeracao: TGroupBox;
    gpbUtilizacaoCashback: TGroupBox;
    Label5: TLabel;
    dbeMinVen: TDBEditFocus;
    tbsItensCashback: TTabSheet;
    pnlFiltroItens: TPanel;
    lblItemItens: TLabel;
    lblGrupoLinhaItens: TLabel;
    lblMarcaItens: TLabel;
    lblFornecedorItens: TLabel;
    lblDepartamentoItens: TLabel;
    lblDescriIniItens: TLabel;
    lblDescriFinItens: TLabel;
    lblRefereItens: TLabel;
    lblImpLisItens: TLabel;
    cllImpLisItens: TColorLabel;
    lblUnidadeItens: TLabel;
    cllProAtiItens: TColorLabel;
    lblProAtiItens: TLabel;
    edtCodIteItens: TEditFocus;
    edtDesIteItens: TEditFocus;
    mskLinhaGrupoItens: TMaskEditFocus;
    edtDesGrupoItens: TEditFocus;
    edtMarcaItens: TEditFocus;
    edtDesMarcaItens: TEditFocus;
    edtFornecedorItens: TEditFocus;
    edtDesFornecedorItens: TEditFocus;
    edtDepartamentoItens: TEditFocus;
    edtDesDepartamentoItens: TEditFocus;
    edtDescriIniItens: TEditFocus;
    edtDescriFinItens: TEditFocus;
    edtRefereItens: TEditFocus;
    edtImpLisItens: TEditFocus;
    edtUnidadeItens: TEditFocus;
    edtProAtiItens: TEditFocus;
    btnConfirmarItens: TBitBtnLocked;
    edtDesUnidadeItens: TEditFocus;
    grdItens: TcxGrid;
    grdItensDBTableView: TcxGridDBTableView;
    grdItensDBTableViewCODITE: TcxGridDBColumn;
    grdItensDBTableViewDESITE: TcxGridDBColumn;
    grdItensDBTableViewUNIDAD: TcxGridDBColumn;
    grdItensDBTableViewMARCA_: TcxGridDBColumn;
    grdItensDBTableViewREFERE: TcxGridDBColumn;
    grdItensDBTableViewNOMFOR: TcxGridDBColumn;
    grdItensDBTableViewCODFOR: TcxGridDBColumn;
    grdItensDBTableViewCODMAR: TcxGridDBColumn;
    grdItensLevel: TcxGridLevel;
    dtsItens: TDataSource;
    cdsItens: TUniClientDataSet;
    cdsItensCODITE: TStringField;
    cdsItensDESITE: TStringField;
    cdsItensUNIDAD: TStringField;
    cdsItensCODMAR: TStringField;
    cdsItensMARCA_: TStringField;
    cdsItensREFERE: TStringField;
    cdsItensCODFOR: TStringField;
    cdsItensNOMFOR: TStringField;
    Label37: TLabel;
    dbeChsBch: TDBEditFocus;
    ColorLabel2: TColorLabel;
    grbValidade: TGroupBox;
    rdbDiaExp: TRadioButton;
    dbeDiaExp: TDBEditFocus;
    Label7: TLabel;
    rdbDtaVal: TRadioButton;
    dbeIniVal: TDBEditFocus;
    Label8: TLabel;
    dbeFinVal: TDBEditFocus;
    Label6: TLabel;
    dbePerMax: TDBEditFocus;
    tbsClientesCashback: TTabSheet;
    pnlFiltroClientes: TPanel;
    lblCliente: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    btnConfirmaClientes: TBitBtnLocked;
    grdClientes: TcxGrid;
    grdClientesDBTableView1: TcxGridDBTableView;
    grdClientesDBTableViewCODCLI: TcxGridDBColumn;
    grdClientesDBTableViewNOMCLI: TcxGridDBColumn;
    grdClientesLevel1: TcxGridLevel;
    cdsClientes: TUniClientDataSet;
    dtsClientes: TDataSource;
    lblAtividade: TLabel;
    edtCodAti: TEditFocus;
    edtDesAti: TEditFocus;
    lblCidade: TLabel;
    edtCodCid: TEditFocus;
    edtNomCid: TEditFocus;
    lblEstado: TLabel;
    edtCodEst: TEditFocus;
    edtNomEst: TEditFocus;
    lblRegiao: TLabel;
    edtCodReg: TEditFocus;
    edtDesReg: TEditFocus;
    lblSubRegiao: TLabel;
    edtCodSub: TEditFocus;
    edtDesSub: TEditFocus;
    lblRedeLoja: TLabel;
    edtCodRed: TEditFocus;
    edtDesRed: TEditFocus;
    lblCanalAcesso: TLabel;
    edtCodCac: TEditFocus;
    edtDesCac: TEditFocus;
    lblVendedor: TLabel;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    lblCnpjCpf: TLabel;
    edtCgcCpf: TEditFocus;
    cdsClientesCODCLI: TStringField;
    cdsClientesNOMCLI: TStringField;
    mskCgcCpf: TMaskEditC_G_C_;
    chkCliCon: TCheckBox;
    Label9: TLabel;
    dbeUtiIte: TDBEditFocus;
    ColorLabel1: TColorLabel;
    tbsItensUtilizacaoCashback: TTabSheet;
    cdsItensUtilizacao: TUniClientDataSet;
    dtsItensUtilizacao: TDataSource;
    cdsItensUtilizacaoCODITE: TStringField;
    cdsItensUtilizacaoDESITE: TStringField;
    cdsItensUtilizacaoUNIDAD: TStringField;
    cdsItensUtilizacaoCODMAR: TStringField;
    cdsItensUtilizacaoMARCA_: TStringField;
    cdsItensUtilizacaoREFERE: TStringField;
    cdsItensUtilizacaoCODFOR: TStringField;
    cdsItensUtilizacaoNOMFOR: TStringField;
    pnlFiltroItensUtilizacao: TPanel;
    lblItemItensUtilizacao: TLabel;
    lblGrupoLinhaItensUtilizacao: TLabel;
    lblMarcaItensUtilizacao: TLabel;
    lblFornecedorItensUtilizacao: TLabel;
    lblDepartamentoItensUtilizacao: TLabel;
    lblDescriIniItensUtilizacao: TLabel;
    lblDescriFinItensUtilizacao: TLabel;
    lblRefereItensUtilizacao: TLabel;
    lblImpLisItensUtilizacao: TLabel;
    cllImpLisItensUtilizacao: TColorLabel;
    lblUnidadeItensUtilizacao: TLabel;
    cllProAtiItensUtilizacao: TColorLabel;
    lblProAtiItensUtilizacao: TLabel;
    edtCodIteItensUtilizacao: TEditFocus;
    edtDesIteItensUtilizacao: TEditFocus;
    mskLinhaGrupoItensUtilizacao: TMaskEditFocus;
    edtDesGrupoItensUtilizacao: TEditFocus;
    edtMarcaItensUtilizacao: TEditFocus;
    edtDesMarcaItensUtilizacao: TEditFocus;
    edtFornecedorItensUtilizacao: TEditFocus;
    edtDesFornecedorItensUtilizacao: TEditFocus;
    edtDepartamentoItensUtilizacao: TEditFocus;
    edtDesDepartamentoItensUtilizacao: TEditFocus;
    edtDescriIniItensUtilizacao: TEditFocus;
    edtDescriFinItensUtilizacao: TEditFocus;
    edtRefereItensUtilizacao: TEditFocus;
    edtImpLisItensUtilizacao: TEditFocus;
    edtUnidadeItensUtilizacao: TEditFocus;
    edtProAtiItensUtilizacao: TEditFocus;
    btnConfirmarItensUtilizacao: TBitBtnLocked;
    edtDesUnidadeItensUtilizacao: TEditFocus;
    grdItensUtilizacao: TcxGrid;
    grdItensUtilizacaoDBTableView: TcxGridDBTableView;
    grdItensUtilizacaoDBTableViewCODITE: TcxGridDBColumn;
    grdItensUtilizacaoDBTableViewDESITE: TcxGridDBColumn;
    grdItensUtilizacaoDBTableViewUNIDAD: TcxGridDBColumn;
    grdItensUtilizacaoDBTableViewMARCA_: TcxGridDBColumn;
    grdItensUtilizacaoDBTableViewREFERE: TcxGridDBColumn;
    grdItensUtilizacaoDBTableViewNOMFOR: TcxGridDBColumn;
    grdItensUtilizacaoDBTableViewCODFOR: TcxGridDBColumn;
    grdItensUtilizacaoDBTableViewCODMAR: TcxGridDBColumn;
    grdItensUtilizacaoLevel: TcxGridLevel;
    dbeConPag: TDBEditFocus;
    Label10: TLabel;
    ColorLabel3: TColorLabel;
    tbsCondicaoPagamento: TTabSheet;
    dtsCondicaoPagamento: TDataSource;
    cdsCondicaoPagamento: TUniClientDataSet;
    cdsCondicaoPagamentoCODCND: TStringField;
    cdsCondicaoPagamentoCNDPAG: TStringField;
    cdsCondicaoPagamentoDESCND: TStringField;
    FlowPanel1: TFlowPanel;
    btnIncluirTodasCndPag: TBitBtnLocked;
    btnExcluirTodasCndPag: TBitBtnLocked;
    grdCondicaoPagamento: TcxGridCitel;
    grdCondicaoPagamentoTableView: TcxGridDBTableViewCitel;
    grdCondicaoPagamentoTableViewCODCND: TcxGridDBColumn;
    grdCondicaoPagamentoTableViewDESCND: TcxGridDBColumn;
    grdCondicaoPagamentoTableViewCNDPAG: TcxGridDBColumn;
    grdCondicaoPagamentoLevel: TcxGridLevel;
    pnlCndPag: TPanel;
    lblCndPag: TLabel;
    edtCodCnd: TEditFocus;
    btnIncCndPag: TBitBtnLocked;
    btnCancelCndPag: TBitBtnLocked;
    edtDesCnd: TEditFocus;
    Label11: TLabel;
    dbeItePro: TDBEditFocus;
    ColorLabel4: TColorLabel;
    Label12: TLabel;
    dbeDiaUti: TDBEditFocus;
    Label13: TLabel;
    dbeGerCsh: TDBEditFocus;
    Label14: TLabel;
    dbeCnlAce: TDBEditFocus;
    ColorLabel5: TColorLabel;
    tbsCanalAcesso: TTabSheet;
    pnlCnlAce: TPanel;
    Label15: TLabel;
    edtFilCodCac: TEditFocus;
    btnIncCnlAce: TBitBtnLocked;
    btnCancelCnlAce: TBitBtnLocked;
    edtFilNomCac: TEditFocus;
    grdCanalAcesso: TcxGridCitel;
    grdCanalAcessoTableView: TcxGridDBTableViewCitel;
    grdCancaAcessoTableViewCODCAC: TcxGridDBColumn;
    grdCancaAcessoTableViewNOMCAC: TcxGridDBColumn;
    grdCanalAcessoLevel: TcxGridLevel;
    cdsCanalAcesso: TUniClientDataSet;
    dtsCanalAcesso: TDataSource;
    cdsCanalAcessoCODCAC: TStringField;
    cdsCanalAcessoNOMCAC: TStringField;
    FlowPanel2: TFlowPanel;
    btnIncluirTodosCnlAce: TBitBtnLocked;
    btnExcluirTodosCnlAce: TBitBtnLocked;
    tbsDepartamento: TTabSheet;
    pnlDepartamento: TPanel;
    Label16: TLabel;
    edtCodDep: TEditFocus;
    btnIncCadDep: TBitBtnLocked;
    btnCancelCadDep: TBitBtnLocked;
    edtDesDep: TEditFocus;
    grdDepartamento: TcxGridCitel;
    grdDepartamentoTableView: TcxGridDBTableViewCitel;
    grdDepartamentoTableViewCODDEP: TcxGridDBColumn;
    grdDepartamentoTableViewDESDEP: TcxGridDBColumn;
    grdDepartamentoLevel: TcxGridLevel;
    FlowPanel3: TFlowPanel;
    btnIncluirTodosDepartamentos: TBitBtnLocked;
    btnExcluirTodosDepartamentos: TBitBtnLocked;
    cdsDepartamento: TUniClientDataSet;
    dtsDepartamento: TDataSource;
    cdsDepartamentoCODDEP: TStringField;
    cdsDepartamentoDESDEP: TStringField;
    Label17: TLabel;
    dbeDepart: TDBEditFocus;
    ColorLabel6: TColorLabel;
    grbTipoGeracao: TGroupBox;
    rdbValFix: TRadioButton;
    dbeValFix: TDBEditFocus;
    rdbPerDes: TRadioButton;
    dbePerDes: TDBEditFocus;
    rdbValCom: TRadioButton;
    dbeValCom: TDBEditFocus;
    dbeValAcu: TDBEditFocus;
    rdbPerIte: TRadioButton;
    dbePerIte: TDBEditFocus;
    rdbValIte: TRadioButton;
    dbeValIte: TDBEditFocus;
    rdbValDve: TRadioButton;
    dbeValDve: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure rdbValFixClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure rdbDiaExpClick(Sender: TObject);
    procedure edtCodIteItensKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupoItensKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaItensKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorItensKeyPress(Sender: TObject; var Key: Char);
    procedure edtDepartamentoItensKeyPress(Sender: TObject; var Key: Char);
    procedure edtUnidadeItensKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteItensExit(Sender: TObject);
    procedure mskLinhaGrupoItensExit(Sender: TObject);
    procedure edtMarcaItensExit(Sender: TObject);
    procedure edtFornecedorItensExit(Sender: TObject);
    procedure edtDepartamentoItensExit(Sender: TObject);
    procedure edtImpLisItensExit(Sender: TObject);
    procedure edtProAtiItensExit(Sender: TObject);
    procedure btnConfirmarItensClick(Sender: TObject);
    procedure edtUnidadeItensExit(Sender: TObject);
    procedure grdItensDBTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClientesClick(Sender: TObject);
    procedure grdClientesDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiExit(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidExit(Sender: TObject);
    procedure edtCodEstKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEstExit(Sender: TObject);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRegExit(Sender: TObject);
    procedure edtCodSubKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodSubExit(Sender: TObject);
    procedure edtCodRedKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRedExit(Sender: TObject);
    procedure edtCodCacKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCacExit(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenExit(Sender: TObject);
    procedure edtCgcCpfExit(Sender: TObject);
    procedure mskCgcCpfExit(Sender: TObject);
    procedure dbeUtiIteChange(Sender: TObject);
    procedure edtCodIteItensUtilizacaoKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupoItensUtilizacaoKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaItensUtilizacaoKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorItensUtilizacaoKeyPress(Sender: TObject; var Key: Char);
    procedure edtDepartamentoItensUtilizacaoKeyPress(Sender: TObject; var Key: Char);
    procedure edtUnidadeItensUtilizacaoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteItensUtilizacaoExit(Sender: TObject);
    procedure mskLinhaGrupoItensUtilizacaoExit(Sender: TObject);
    procedure edtMarcaItensUtilizacaoExit(Sender: TObject);
    procedure edtFornecedorItensUtilizacaoExit(Sender: TObject);
    procedure edtDepartamentoItensUtilizacaoExit(Sender: TObject);
    procedure edtImpLisItensUtilizacaoExit(Sender: TObject);
    procedure edtProAtiItensUtilizacaoExit(Sender: TObject);
    procedure btnConfirmarItensUtilizacaoClick(Sender: TObject);
    procedure edtUnidadeItensUtilizacaoExit(Sender: TObject);
    procedure grdItensUtilizacaoDBTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbeConPagChange(Sender: TObject);
    procedure edtCodCndExit(Sender: TObject);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncCndPagClick(Sender: TObject);
    procedure btnCancelCndPagClick(Sender: TObject);
    procedure btnIncluirTodasCndPagClick(Sender: TObject);
    procedure btnExcluirTodasCndPagClick(Sender: TObject);
    procedure grdCondicaoPagamentoTableViewKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure dbeCnlAceChange(Sender: TObject);
    procedure edtFilCodCacExit(Sender: TObject);
    procedure btnCancelCnlAceClick(Sender: TObject);
    procedure btnIncCnlAceClick(Sender: TObject);
    procedure edtFilCodCacKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirTodosCnlAceClick(Sender: TObject);
    procedure btnExcluirTodosCnlAceClick(Sender: TObject);
    procedure grdCanalAcessoTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdDepartamentoTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnIncCadDepClick(Sender: TObject);
    procedure btnCancelCadDepClick(Sender: TObject);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirTodosDepartamentosClick(Sender: TObject);
    procedure btnExcluirTodosDepartamentosClick(Sender: TObject);
    procedure dbeDepartChange(Sender: TObject);
  private
    { Private declarations }
    arrItens         : TConsultasArray;
    arrGrupos        : TConsultasArray;
    arrMarca         : TConsultasArray;
    arrFornecedores  : TConsultasArray;
    arrDepartamentos : TConsultasArray;
    arrUnidades      : TConsultasArray;

    arrClientes      : TConsultasArray;
    arrAtividades    : TConsultasArray;
    arrCidades       : TConsultasArray;
    arrEstados       : TConsultasArray;
    arrRegioes       : TConsultasArray;
    arrSubRegioes    : TConsultasArray;
    arrRedeLojas     : TConsultasArray;
    arrCanalAcessos  : TConsultasArray;
    arrVendedores    : TConsultasArray;

    arrCndPag        : TConsultasArray;

    procedure pExecutaCarregamento(funcCarregamento: TFunctionFormGravando);
    procedure pInfoStatusCarregamento(strInformacao: String; pgbProgresso: TcxProgressBar);
    procedure pStepStatusCarregamento(pgbProgresso: TcxProgressBar);

    procedure pCarregarTipoCashback;
    function fRetornaTipoCashback: String;
    procedure pHabilitarTipoCashback;
    procedure pCarregarUtilizacaoCashback;
    procedure pHabilitarUtilizacaoCashback;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pVerificaRadioGroupHabilitado;

    procedure pReorganizaTabs;
    procedure pHabilitaDesabilitaTabItensCashback;
    procedure pHabilitaDesabilitaTabClientesCashback;
    procedure pHabilitaDesabilitaTabItensUtilizacaoCashback;
    procedure pHabilitaDesabilitaTabCondicaoPagamento;
    procedure pHabilitaDesabilitaTabCanalAcesso;
    procedure pHabilitaDesabilitaTabDepartamento;
    procedure pHabilitaDesabilitaControles(const blnHabilita: Boolean=True);

    procedure pCarregaDadosCashback;
    function fExisteCashBackComMesmoPeriodoSemCliente: Boolean;
    function fExisteCashBackComMesmoPeriodoDevolucaoEmbalagem: Boolean;

    procedure pRetornaItens;
    procedure pWhereItens(const qryItens: TUniQuery);
    function fGravaItensCashback(strAutInc: String): Boolean;
    function fInformouItens: Boolean;
    procedure pLimpaFiltroItens;
    function fCarregaItensCashback(pgbProgresso: TcxProgressBar): Boolean;
    function fExcluiItensCashback(strAutInc: String): Boolean;
    procedure pExcluiRegistroItens;
    function fGravouItensCashback: Boolean;

    procedure pRetornaClientes;
    procedure pWhereClientes(const qryClientes: TUniQuery);
    function fGravaClientesCashback(strAutInc: String): Boolean;
    function fInformouClientes: Boolean;
    procedure pLimpaFiltroClientes;
    function fCarregaClientesCashback(pgbProgresso: TcxProgressBar): Boolean;
    function fExcluiClientesCashback(strAutInc: String): Boolean;
    procedure pExcluiRegistroClientes;
    function fGravouClientesCashback: Boolean;
    function fExisteClienteOutroCashBack: Boolean;
    function fValidouRegrasGravacao: Boolean;

    function fValidouFiltroPesquisa(const edtCodigo, edtDescricao: TEditFocus;
      var arrPesquisa: TConsultasArray;
      const funcPesquisa: TFuncRetornoPequisa;
      const strMensagem: String): Boolean; overload;
    function fValidouFiltroPesquisa(const edtCodigo, edtDescricao: TEditFocus;
      var arrPesquisa: TConsultasArray; const funcPesquisa: TFuncRetornoPequisaComConst;
      const strMensagem: String): Boolean; overload;
    function fExecutaValidouFiltroPesquisa(const edtCodigo, edtDescricao: TEditFocus;
      var arrPesquisa: TConsultasArray; const funcPesquisa: TFuncRetornoPequisa=nil;
      const funcPesquisaComConst: TFuncRetornoPequisaComConst=nil;
      const strMensagem: String=''): Boolean;

    procedure pAdicionarFiltros(const qryConsulta: TUniQuery;
      var arrConsulta: TConsultasArray; const strCampoFiltro: String); overload;
    procedure pAdicionarFiltros(const qryConsulta: TUniQuery; const strFiltro,
      strCampoFiltro: String); overload;
    procedure pAdicionarFiltros(const qryConsulta: TUniQuery;
      const strSQL: String); overload;

    procedure pRetornaItensUtilizacao;
    procedure pWhereItensUtilizacao(const qryItens: TUniQuery);
    function fGravaItensUtilizacaoCashback(strAutInc: String): Boolean;
    function fInformouItensUtilizacao: Boolean;
    procedure pLimpaFiltroItensUtilizacao;
    function fCarregaItensUtilizacaoCashback(pgbProgresso: TcxProgressBar): Boolean;
    function fExcluiItensUtilizacaoCashback(strAutInc: String): Boolean;
    procedure pExcluiRegistroItensUtilizacao;
    function fGravouItensUtilizacaoCashback: Boolean;

    procedure pAdicionaCondicaoPagamento;
    function fValidaCondicaoPagamento: Boolean;
    function fGravaCondicaoPagamento(strAutInc: String): Boolean;
    function fCarregaCondicaoPagamento(pgbProgresso: TcxProgressBar): Boolean;
    function fExcluiCondicaoPagamento(strAutInc: String): Boolean;
    procedure pExcluiRegistroCondicaoPagamento;
    function fInformouCondicaoPagamento: Boolean;
    function fGravouCondicaoPagamento: Boolean;
    procedure pLimpaFiltroCondicaoPagamento;

    procedure pAdicionaCanalAcesso;
    function fValidaCanalAcesso: Boolean;
    function fGravaCanalAcesso(strAutInc: String): Boolean;
    function fCarregaCanalAcesso(pgbProgresso: TcxProgressBar): Boolean;
    function fExcluiCanalAcesso(strAutInc: String): Boolean;
    procedure pExcluiRegistroCanalAcesso;
    function fInformouCanalAcesso: Boolean;
    function fGravouCanalAcesso: Boolean;
    procedure pLimpaFiltroCanalAcesso;

    procedure pAdicionaDepartamento;
    function fValidaDepartamento: Boolean;
    function fGravaDepartamento(strAutInc: String): Boolean;
    function fCarregaDepartamento(pgbProgresso: TcxProgressBar): Boolean;
    function fExcluiDepartamento(strAutInc: String): Boolean;
    procedure pExcluiRegistroDepartamento;
    function fInformouDepartamento: Boolean;
    function fGravouDepartamento: Boolean;
    procedure pLimpaFiltroDepartamento;

  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
  End;

var
  frmCadCashback: TfrmCadCashback;

implementation

uses untPai, untFuncoesSimples, System.StrUtils, untFuncoesGenerica,
     Cashback.Controle, untObservacao, untGravando;

{$R *.dfm}

procedure TfrmCadCashback.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'CADCSH';
  strNomeCampo := 'CSH_CODIGO';
  qryTabela := fCriarQuery('SELECT * FROM CADCSH', Self);
  dtsCadCsh.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  qryTabela.AfterOpen := pAfterOpen;

  rdbValDve.Visible := fCfgSis('DVECSH') = 'S';
  dbeValDve.Visible := rdbValDve.Visible;

  pHabilitarTipoCashback();
  pHabilitarUtilizacaoCashback();

  pLimpaFiltroItens;
  pLimpaFiltroItensUtilizacao;
  pLimpaFiltroClientes;
  pLimpaFiltroCondicaoPagamento;
  pLimpaFiltroCanalAcesso;
  pLimpaFiltroDepartamento;

  pgcDados.ActivePageIndex := 0;
  cdsItens.CreateDataSet;
  cdsItensUtilizacao.CreateDataSet;
  cdsClientes.CreateDataSet;
  cdsCondicaoPagamento.CreateDataSet;
  cdsCanalAcesso.CreateDataSet;
  cdsDepartamento.CreateDataSet;

  pHabilitaDesabilitaTabItensCashback;
  pHabilitaDesabilitaTabItensUtilizacaoCashback;
  pHabilitaDesabilitaTabCondicaoPagamento;
  pHabilitaDesabilitaTabCanalAcesso;
  pHabilitaDesabilitaTabDepartamento;
  pHabilitaDesabilitaTabClientesCashback;
end;

procedure TfrmCadCashback.btnCancelCnlAceClick(Sender: TObject);
begin
  inherited;
  edtFilCodCac.Enabled := True;
  edtFilCodCac.Clear;
  edtFilNomCac.Clear;
  pSetFocus(edtFilCodCac);
end;

procedure TfrmCadCashback.btnCancelaClick(Sender: TObject);
begin
  pHabilitaDesabilitaControles(True);

  pLimpaFiltroItens;
  pLimpaFiltroItensUtilizacao;
  pLimpaFiltroClientes;
  pLimpaFiltroCondicaoPagamento;
  pLimpaFiltroCanalAcesso;
  pLimpaFiltroDepartamento;

  inherited;

  pCarregaDadosCashback;
end;

procedure TfrmCadCashback.btnCancelCadDepClick(Sender: TObject);
begin
  inherited;
  edtCodDep.Enabled := True;
  edtCodDep.Clear;
  edtDesDep.Clear;
  pSetFocus(edtCodDep);
end;

procedure TfrmCadCashback.btnCancelCndPagClick(Sender: TObject);
begin
  inherited;
  edtCodCnd.Enabled := True;
  edtCodCnd.Clear;
  edtDesCnd.Clear;
  pSetFocus(edtCodCnd);
end;

procedure TfrmCadCashback.btnIncCnlAceClick(Sender: TObject);
begin
  inherited;
  pAdicionaCanalAcesso;
end;

procedure TfrmCadCashback.btnConfirmaClientesClick(Sender: TObject);
begin
  inherited;
  pRetornaClientes;
end;

procedure TfrmCadCashback.btnConfirmarItensClick(Sender: TObject);
begin
  inherited;
  pRetornaItens;
end;

procedure TfrmCadCashback.btnConfirmarItensUtilizacaoClick(Sender: TObject);
begin
  inherited;
  pRetornaItensUtilizacao;
end;

procedure TfrmCadCashback.btnExcluirClick(Sender: TObject);
begin
  If (Not fEmptyStr(dbeCodigo.Text)) And
     (TControleCashback.fExisteCashbackValidoNaVENCSH(dbeCodigo.Text)) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadCashback.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pHabilitarTipoCashback();
  pHabilitarUtilizacaoCashback();

  pLimpaFiltroItens;
  pLimpaFiltroItensUtilizacao;
  pLimpaFiltroCondicaoPagamento;
  pLimpaFiltroClientes;
  pLimpaFiltroCanalAcesso;
  pLimpaFiltroDepartamento;

  cdsItens.EmptyDataSet;
  cdsItensUtilizacao.EmptyDataSet;
  cdsClientes.EmptyDataSet;
  cdsCondicaoPagamento.EmptyDataSet;
  cdsCanalAcesso.EmptyDataSet;
  cdsDepartamento.EmptyDataSet;
end;

procedure TfrmCadCashback.btnExcluirTodasCndPagClick(Sender: TObject);
begin
  inherited;

  If fPergunta('Deseja remover todas as condições de pagamento da promoção?') Then
    cdsCondicaoPagamento.EmptyDataSet;
end;

procedure TfrmCadCashback.btnExcluirTodosCnlAceClick(Sender: TObject);
begin
  inherited;

  If fPergunta('Deseja remover todos os Canais de Acesso da promoção?') Then
    cdsCanalAcesso.EmptyDataSet;
end;

procedure TfrmCadCashback.btnExcluirTodosDepartamentosClick(Sender: TObject);
begin
  inherited;

  If fPergunta('Deseja remover todos os Departamentos da promoção?') Then
    cdsDepartamento.EmptyDataSet;
end;

procedure TfrmCadCashback.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  If (Not fValidouRegrasGravacao) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  qryTabela.FieldByName('CSH_CLICON').AsString := IfThen(chkCliCon.Checked, 'S', 'N');
  qryTabela.FieldByName('CSH_TIPCSH').AsString := fRetornaTipoCashback;

  Try
    inherited;

    If Not fGravouItensCashback Then
      blnGravou := False;

    If Not fGravouClientesCashback Then
      blnGravou := False;

    If Not fGravouItensUtilizacaoCashback Then
      blnGravou := False;

    If Not fGravouCondicaoPagamento Then
      blnGravou := False;

    If Not fGravouCanalAcesso Then
      blnGravou := False;

    If Not fGravouDepartamento Then
      blnGravou := False;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadCashback.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    FRollback;

  pHabilitarTipoCashback();
  pHabilitarUtilizacaoCashback();

  pLimpaFiltroItens;
  pLimpaFiltroItensUtilizacao;
  pLimpaFiltroCondicaoPagamento;
  pLimpaFiltroClientes;
  pLimpaFiltroCanalAcesso;
  pLimpaFiltroDepartamento;
end;

procedure TfrmCadCashback.btnIncCadDepClick(Sender: TObject);
begin
  inherited;
  pAdicionaDepartamento;
end;

procedure TfrmCadCashback.btnIncCndPagClick(Sender: TObject);
begin
  inherited;
  pAdicionaCondicaoPagamento;
end;

procedure TfrmCadCashback.btnIncluirClick(Sender: TObject);
begin
  pHabilitaDesabilitaControles(True);

  inherited;

  dbeIniVig.Field.Clear;
  dbeFinVig.Field.Clear;

  dbeIniVal.Field.Clear;
  dbeFinVal.Field.Clear;

  dbeValFix.Field.AsFloat := 0;
  dbePerDes.Field.AsFloat := 0;
  dbeValCom.Field.AsFloat := 0;
  dbeValAcu.Field.AsFloat := 0;
  dbeMinVen.Field.AsFloat := 0;
  dbePerMax.Field.AsFloat := 0;
  dbePerIte.Field.AsFloat := 0;
  dbeValIte.Field.AsFloat := 0;
  dbeValDve.Field.AsFloat := 0;
  dbeGerCsh.Field.AsFloat := 0;

  dbeDiaExp.Field.AsInteger := 0;
  dbeDiaUti.Field.AsInteger := 0;

  dbeTipPes.Field.AsString := 'A';
  dbeUtiIte.Field.AsString := 'N';
  dbeConPag.Field.AsString := 'T';
  dbeItePro.Field.AsString := 'S';
  dbeCnlAce.Field.AsString := 'T';
  dbeDepart.Field.AsString := 'T';

  rdbValFix.Checked := True;
  rdbDiaExp.Checked := True;
  chkCliCon.Checked := True;

  qryTabela.FieldByName('CSH_TIPCSH').AsString := 'VF';
  qryTabela.FieldByName('CSH_CHSBCH').AsString := 'N';
  qryTabela.FieldByName('CSH_CLICON').AsString := 'S';

  pLimpaFiltroItens;
  pLimpaFiltroItensUtilizacao;
  pLimpaFiltroCondicaoPagamento;
  pLimpaFiltroClientes;
  pLimpaFiltroCanalAcesso;
  pLimpaFiltroDepartamento;

  pCarregaDadosCashback;
end;

procedure TfrmCadCashback.btnIncluirTodasCndPagClick(Sender: TObject);
var
  qryGen: TUniQuery;
begin
  inherited;

  If Not fPergunta('Deseja incluir todas as condições de pagamento na promoção?') Then
    Exit;

  qryGen := fCriaQuery(Self);
  Try
    qryGen.SQL.Add('SELECT CND_CODIGO, CND_CNDPAG, CND_DESCRI FROM CADCND');
    qryGen.Open;
    cdsCondicaoPagamento.DisableControls;
    Try
      While Not qryGen.Eof Do
      Begin
        If Not cdsCondicaoPagamento.Locate('CODCND', qryGen.FieldByName('CND_CODIGO').AsString, []) Then
        Begin
          cdsCondicaoPagamento.Append;
          cdsCondicaoPagamento.FieldByName('CODCND').AsString := qryGen.FieldByName('CND_CODIGO').AsString;
          cdsCondicaoPagamento.FieldByName('DESCND').AsString := qryGen.FieldByName('CND_DESCRI').AsString;
          cdsCondicaoPagamento.FieldByName('CNDPAG').AsString := fFormataCondPag(qryGen.FieldByName('CND_CNDPAG').AsString);
          cdsCondicaoPagamento.Post;
        End;

        qryGen.Next;
      End;
    Finally
      cdsCondicaoPagamento.EnableControls;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadCashback.btnIncluirTodosCnlAceClick(Sender: TObject);
var
  qryGen: TUniQuery;
begin
  inherited;

  If Not fPergunta('Deseja incluir todos os Canais de Acesso na promoção?') Then
    Exit;

  qryGen := fCriaQuery(Self);
  Try
    qryGen.SQL.Add('SELECT CAC_CODCAC, CAC_NOMCAC FROM CADCAC');
    qryGen.Open;
    cdsCanalAcesso.DisableControls;
    Try
      While Not qryGen.Eof Do
      Begin
        If Not cdsCanalAcesso.Locate('CODCAC', qryGen.FieldByName('CAC_CODCAC').AsString, []) Then
        Begin
          cdsCanalAcesso.Append;
          cdsCanalAcesso.FieldByName('CODCAC').AsString := qryGen.FieldByName('CAC_CODCAC').AsString;
          cdsCanalAcesso.FieldByName('NOMCAC').AsString := qryGen.FieldByName('CAC_NOMCAC').AsString;
          cdsCanalAcesso.Post;
        End;

        qryGen.Next;
      End;
    Finally
      cdsCanalAcesso.EnableControls;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadCashback.btnIncluirTodosDepartamentosClick(Sender: TObject);
var
  qryGen: TUniQuery;
begin
  inherited;

  If Not fPergunta('Deseja incluir todos os Departamentos na promoção?') Then
    Exit;

  qryGen := fCriaQuery(Self);
  Try
    qryGen.SQL.Add('SELECT DEP_CODIGO, DEP_DESCRI FROM CADDEP');
    qryGen.Open;
    cdsDepartamento.DisableControls;
    Try
      While Not qryGen.Eof Do
      Begin
        If Not cdsDepartamento.Locate('CODDEP', qryGen.FieldByName('DEP_CODIGO').AsString, []) Then
        Begin
          cdsDepartamento.Append;
          cdsDepartamento.FieldByName('CODDEP').AsString := qryGen.FieldByName('DEP_CODIGO').AsString;
          cdsDepartamento.FieldByName('DESDEP').AsString := qryGen.FieldByName('DEP_DESCRI').AsString;
          cdsDepartamento.Post;
        End;

        qryGen.Next;
      End;
    Finally
      cdsDepartamento.EnableControls;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadCashback.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrCsh: TConsultasArray;
begin
  chrKey := '/';
  If fPesqTipoCashback(Self, Nil, Nil, qryTabela, chrKey, arrCsh) Then
  Begin
    pCarregaDadosCashback;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadCashback.grdCanalAcessoTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case key of
    VK_DELETE: pExcluiRegistroCanalAcesso;
  End;
end;

procedure TfrmCadCashback.dbeCnlAceChange(Sender: TObject);
begin
  inherited;
  pHabilitaDesabilitaTabCanalAcesso;
end;

procedure TfrmCadCashback.dbeConPagChange(Sender: TObject);
begin
  inherited;
  pHabilitaDesabilitaTabCondicaoPagamento;
end;

procedure TfrmCadCashback.dbeDepartChange(Sender: TObject);
begin
  inherited;
  pHabilitaDesabilitaTabDepartamento;
end;

procedure TfrmCadCashback.dbeUtiIteChange(Sender: TObject);
begin
  inherited;
  pHabilitaDesabilitaTabItensUtilizacaoCashback;
end;

procedure TfrmCadCashback.edtFilCodCacExit(Sender: TObject);
begin
  inherited;
  fValidouFiltroPesquisa(edtFilCodCac, edtFilNomCac, arrCanalAcessos, fRetNomCanalAcesso, 'Canal de Acesso não encontrado.');
end;

procedure TfrmCadCashback.edtFilCodCacKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqCanalAcesso(Self, edtFilCodCac, edtFilNomCac, nil, Key, arrCanalAcessos) Then
    Begin
      if fValidaCampos(edtFilCodCac, True) then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCashback.edtCgcCpfExit(Sender: TObject);
begin
  inherited;
  If (edtCgcCpf.Text = '1') Then
    mskCgcCpf.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
  Else
  If (edtCgcCpf.Text = '2') Then
    mskCgcCpf.EditMask := '999.999.999-99;0;'
  Else
  Begin
    fMensagem('ATENÇÃO', 'Escolha entre as opções 1-CNPJ ou 2-CPF.', ['&OK']);
    pSetFocus(edtCgcCpf);
  End;
end;

procedure TfrmCadCashback.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  fValidouFiltroPesquisa(edtCodAti, edtDesAti, arrAtividades, fRetAtividade, 'Atividade não encontrada.');
end;

procedure TfrmCadCashback.edtCodAtiKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, arrAtividades, False) Then
    Begin
      if fValidaCampos(edtCodAti, True) then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCashback.edtCodCacExit(Sender: TObject);
begin
  inherited;
  fValidouFiltroPesquisa(edtCodCac, edtDesCac, arrCanalAcessos, fRetNomCanalAcesso, 'Canal de Acesso não encontrado.');
end;

procedure TfrmCadCashback.edtCodCacKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqCanalAcesso(Self, edtCodCac, edtDesCac, Nil, Key, arrCanalAcessos, False) Then
    Begin
      if fValidaCampos(edtCodCac, True) then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCashback.edtCodCidExit(Sender: TObject);
begin
  inherited;
  fValidouFiltroPesquisa(edtCodCid, edtNomCid, arrCidades, fRetCidade, 'Cidade não encontrada.');
end;

procedure TfrmCadCashback.edtCodCidKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqCidade(Self, edtCodCid, edtNomCid, Nil, Nil, Key, arrCidades, False) Then
    Begin
      if fValidaCampos(edtCodCid, True) then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCashback.edtCodCliExit(Sender: TObject);
begin
  inherited;
  fValidouFiltroPesquisa(edtCodCli, edtNomCli, arrClientes, fRetNomCliente, 'Cliente não encontrado.');
end;

procedure TfrmCadCashback.edtCodCliKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes, False) Then
    Begin
      If fValidaCampos(edtCodCli, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCashback.edtCodCndExit(Sender: TObject);
begin
  inherited;
  fValidouFiltroPesquisa(edtCodCnd, edtDesCnd, arrCndPag, fRetDesConPag, 'Condição de Pagamento não encontrada.');
end;

procedure TfrmCadCashback.edtCodCndKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCondicoesPgto(Self, edtCodCnd, edtDesCnd, nil, Key, arrCndPag) Then
  Begin
    If fValidaCampos(edtCodCnd, True) Then
    Begin
      Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCashback.edtCodDepExit(Sender: TObject);
begin
  inherited;
  fValidouFiltroPesquisa(edtCodDep, edtDesDep, arrDepartamentos, fRetDescDepartamento, 'Departamento não encontrado.');
end;

procedure TfrmCadCashback.edtCodDepKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqDepartamento(Self, edtCodDep, edtDesDep, nil, Key, arrDepartamentos) Then
    Begin
      if fValidaCampos(edtCodDep, True) then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCashback.edtCodEstExit(Sender: TObject);
begin
  inherited;
  fValidouFiltroPesquisa(edtCodEst, edtNomEst, arrEstados, fRetNomeEstado, 'Estado não encontrado.');
end;

procedure TfrmCadCashback.edtCodEstKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqEstado(Self, edtCodEst, edtNomEst, Nil, Key, arrEstados, False) Then
    Begin
      if fValidaCampos(edtCodEst, True) then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCashback.edtCodIteItensExit(Sender: TObject);
begin
  inherited;
  fValidouFiltroPesquisa(edtCodIteItens, edtDesIteItens, arrItens, fRetNomProduto, 'Produto não encontrado.');
end;

procedure TfrmCadCashback.edtCodIteItensUtilizacaoExit(Sender: TObject);
begin
  inherited;
  fValidouFiltroPesquisa(edtCodIteItensUtilizacao, edtDesIteItensUtilizacao, arrItens, fRetNomProduto, 'Produto não encontrado.');
end;

procedure TfrmCadCashback.edtCodIteItensKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqItem(conIteSimples, Self, edtCodIteItens, edtDesIteItens, Nil, Key, arrItens, False, nil, 'Consulta de Itens', '1') Then
    Begin
      If fValidaCampos(edtCodIteItens, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCashback.edtCodIteItensUtilizacaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqItem(conIteSimples, Self, edtCodIteItensUtilizacao, edtDesIteItensUtilizacao, Nil, Key, arrItens, False, nil, 'Consulta de Itens', '1') Then
    Begin
      If fValidaCampos(edtCodIteItensUtilizacao, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCashback.edtCodRedExit(Sender: TObject);
begin
  inherited;
  fValidouFiltroPesquisa(edtCodRed, edtDesRed, arrRedeLojas, fRetNomeRedeLoja, 'Rede de Lojas não encontrada.');
end;

procedure TfrmCadCashback.edtCodRedKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqRedeLojas(Self, edtCodRed, edtDesRed, Nil, Key, arrRedeLojas, False) Then
    Begin
      if fValidaCampos(edtCodRed, True) then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCashback.edtCodRegExit(Sender: TObject);
begin
  inherited;
  fValidouFiltroPesquisa(edtCodReg, edtDesReg, arrRegioes, fRetNomRegiao, 'Região não encontrada.');
end;

procedure TfrmCadCashback.edtCodRegKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqRegiao(Self, edtCodReg, edtDesReg, Nil, Key, arrRegioes, False) Then
    Begin
      if fValidaCampos(edtCodReg, True) then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCashback.edtCodSubExit(Sender: TObject);
begin
  inherited;
  fValidouFiltroPesquisa(edtCodSub, edtDesSub, arrSubRegioes, fRetNomSubRegiao, 'Sub-região não encontrada.');
end;

procedure TfrmCadCashback.edtCodSubKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqSubRegiao(Self, edtCodSub, edtDesSub, Nil, Key, arrSubRegioes, False) Then
    Begin
      if fValidaCampos(edtCodSub, True) then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCashback.edtCodVenExit(Sender: TObject);
begin
  inherited;
  fValidouFiltroPesquisa(edtCodVen, edtNomVen, arrVendedores, fRetNomVendedor, 'Vendedor não encontrado.');
end;

procedure TfrmCadCashback.edtCodVenKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If (fPesqOperador(Self, edtCodVen, edtNomVen, Nil, Key, arrVendedores, False, False, False, False, False, False, False, False, True)) Then
    Begin
      if fValidaCampos(edtCodVen, True) then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCashback.edtDepartamentoItensExit(Sender: TObject);
begin
  inherited;
  fValidouFiltroPesquisa(edtDepartamentoItens, edtDesDepartamentoItens, arrDepartamentos, fRetDescDepartamento, 'Departamento não encontrado.');
end;

procedure TfrmCadCashback.edtDepartamentoItensUtilizacaoExit(Sender: TObject);
begin
  inherited;
  fValidouFiltroPesquisa(edtDepartamentoItensUtilizacao, edtDesDepartamentoItensUtilizacao, arrDepartamentos, fRetDescDepartamento, 'Departamento não encontrado.');
end;

procedure TfrmCadCashback.edtDepartamentoItensKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtDepartamentoItens, edtDesDepartamentoItens, Nil, Key, arrDepartamentos, False) Then
  Begin
    If fValidaCampos(edtDepartamentoItens, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCashback.edtDepartamentoItensUtilizacaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtDepartamentoItensUtilizacao, edtDesDepartamentoItensUtilizacao, Nil, Key, arrDepartamentos, False) Then
  Begin
    If fValidaCampos(edtDepartamentoItensUtilizacao, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCashback.edtFornecedorItensExit(Sender: TObject);
begin
  inherited;
  fValidouFiltroPesquisa(edtFornecedorItens, edtDesFornecedorItens, arrFornecedores, fRetNomFornecedor, 'Fornecedor não encontrado.');
end;

procedure TfrmCadCashback.edtFornecedorItensUtilizacaoExit(Sender: TObject);
begin
  inherited;
  fValidouFiltroPesquisa(edtFornecedorItensUtilizacao, edtDesFornecedorItensUtilizacao, arrFornecedores, fRetNomFornecedor, 'Fornecedor não encontrado.');
end;

procedure TfrmCadCashback.edtFornecedorItensKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtFornecedorItens, edtDesFornecedorItens, Nil, Key, arrFornecedores, False) Then
  Begin
    If fValidaCampos(edtFornecedorItens, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCashback.edtFornecedorItensUtilizacaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtFornecedorItensUtilizacao, edtDesFornecedorItensUtilizacao, Nil, Key, arrFornecedores, False) Then
  Begin
    If fValidaCampos(edtFornecedorItensUtilizacao, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCashback.edtImpLisItensExit(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtImpLisItens.Text)) Then
  Begin
    If(Not MatchStr(edtImpLisItens.Text, ['S','N'])) Then
      edtImpLisItens.Clear;
  End;
end;

procedure TfrmCadCashback.edtImpLisItensUtilizacaoExit(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtImpLisItensUtilizacao.Text)) Then
  Begin
    If(Not MatchStr(edtImpLisItensUtilizacao.Text, ['S','N'])) Then
      edtImpLisItensUtilizacao.Clear;
  End;
end;

procedure TfrmCadCashback.edtMarcaItensExit(Sender: TObject);
begin
  inherited;
  fValidouFiltroPesquisa(edtMarcaItens, edtDesMarcaItens, arrMarca, fRetNomMarca, 'Marca não encontrada.');
end;

procedure TfrmCadCashback.edtMarcaItensUtilizacaoExit(Sender: TObject);
begin
  inherited;
  fValidouFiltroPesquisa(edtMarcaItensUtilizacao, edtDesMarcaItensUtilizacao, arrMarca, fRetNomMarca, 'Marca não encontrada.');
end;

procedure TfrmCadCashback.edtMarcaItensKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtMarcaItens, edtDesMarcaItens, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtMarcaItens, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCashback.edtMarcaItensUtilizacaoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtMarcaItensUtilizacao, edtDesMarcaItensUtilizacao, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtMarcaItensUtilizacao, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCashback.edtProAtiItensExit(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtProAtiItens.Text)) Then
  Begin
    If (Not MatchStr(edtProAtiItens.Text, ['S','N'])) Then
      edtProAtiItens.Clear;
  End;
end;

procedure TfrmCadCashback.edtProAtiItensUtilizacaoExit(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtProAtiItensUtilizacao.Text)) Then
  Begin
    If (Not MatchStr(edtProAtiItensUtilizacao.Text, ['S','N'])) Then
      edtProAtiItens.Clear;
  End;
end;

procedure TfrmCadCashback.edtUnidadeItensExit(Sender: TObject);
begin
  inherited;
  fValidouFiltroPesquisa(edtUnidadeItens, edtDesUnidadeItens, arrUnidades, fRetNomUnidade, 'Unidade não encontrada.');
end;

procedure TfrmCadCashback.edtUnidadeItensUtilizacaoExit(Sender: TObject);
begin
  inherited;
  fValidouFiltroPesquisa(edtUnidadeItensUtilizacao, edtDesUnidadeItensUtilizacao, arrUnidades, fRetNomUnidade, 'Unidade não encontrada.');
end;

procedure TfrmCadCashback.edtUnidadeItensKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqUnidade(Self, edtUnidadeItens, edtDesUnidadeItens, Nil, Nil, Key, arrUnidades, False) Then
  Begin
    If fValidaCampos(edtUnidadeItens, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCashback.edtUnidadeItensUtilizacaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqUnidade(Self, edtUnidadeItensUtilizacao, edtDesUnidadeItensUtilizacao, Nil, Nil, Key, arrUnidades, False) Then
  Begin
    If fValidaCampos(edtUnidadeItensUtilizacao, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadCashback.fExcluiCanalAcesso(strAutInc: String): Boolean;
var
  qryCanalAcesso: TUniQuery;
begin
  qryCanalAcesso := fCriaQuery;

  Try
    Result := False;

    qryCanalAcesso.Close;
    qryCanalAcesso.SQL.Clear;
    qryCanalAcesso.SQL.Add('DELETE FROM CACCSH');
    qryCanalAcesso.SQL.Add('WHERE CSH_SEQCSH = :SEQCSH');

    qryCanalAcesso.ParamByName('SEQCSH').AsString := strAutInc;

    qryCanalAcesso.ExecSQL;

    Result := True;
  Finally
    FreeAndNil(qryCanalAcesso);
  End;
end;

function TfrmCadCashback.fExcluiClientesCashback(strAutInc: String): Boolean;
var
  qryItens: TUniQuery;
begin
  qryItens := fCriaQuery;

  Try
    Result := False;

    qryItens.Close;
    qryItens.SQL.Clear;
    qryItens.SQL.Add('DELETE FROM CLICSH');
    qryItens.SQL.Add('WHERE CSH_SEQCSH = :SEQCSH');

    qryItens.ParamByName('SEQCSH').AsString := strAutInc;

    qryItens.ExecSQL;

    Result := True;
  Finally
    FreeAndNil(qryItens);
  End;
end;

function TfrmCadCashback.fExcluiCondicaoPagamento(strAutInc: String): Boolean;
var
  qryCondicao: TUniQuery;
begin
  qryCondicao := fCriaQuery;

  Try
    Result := False;

    qryCondicao.Close;
    qryCondicao.SQL.Clear;
    qryCondicao.SQL.Add('DELETE FROM CPGCSH');
    qryCondicao.SQL.Add('WHERE CSH_SEQCSH = :SEQCSH');

    qryCondicao.ParamByName('SEQCSH').AsString := strAutInc;

    qryCondicao.ExecSQL;

    Result := True;
  Finally
    FreeAndNil(qryCondicao);
  End;
end;

function TfrmCadCashback.fExcluiDepartamento(strAutInc: String): Boolean;
var
  qryDepartamento: TUniQuery;
begin
  qryDepartamento := fCriaQuery;

  Try
    Result := False;

    qryDepartamento.Close;
    qryDepartamento.SQL.Clear;
    qryDepartamento.SQL.Add('DELETE FROM DEPCSH');
    qryDepartamento.SQL.Add('WHERE CSH_SEQCSH = :SEQCSH');

    qryDepartamento.ParamByName('SEQCSH').AsString := strAutInc;

    qryDepartamento.ExecSQL;

    Result := True;
  Finally
    FreeAndNil(qryDepartamento);
  End;
end;

function TfrmCadCashback.fExcluiItensCashback(strAutInc: String): Boolean;
var
  qryItens: TUniQuery;
begin
  qryItens := fCriaQuery;

  Try
    Result := False;

    qryItens.Close;
    qryItens.SQL.Clear;
    qryItens.SQL.Add('DELETE FROM ITECSH');
    qryItens.SQL.Add('WHERE CSH_SEQCSH = :SEQCSH');

    qryItens.ParamByName('SEQCSH').AsString := strAutInc;

    qryItens.ExecSQL;

    Result := True;
  Finally
    FreeAndNil(qryItens);
  End;
end;

function TfrmCadCashback.fExcluiItensUtilizacaoCashback(
  strAutInc: String): Boolean;
var
  qryItens: TUniQuery;
begin
  qryItens := fCriaQuery;

  Try
    Result := False;

    qryItens.Close;
    qryItens.SQL.Clear;
    qryItens.SQL.Add('DELETE FROM ITUCSH');
    qryItens.SQL.Add('WHERE CSH_SEQCSH = :SEQCSH');

    qryItens.ParamByName('SEQCSH').AsString := strAutInc;

    qryItens.ExecSQL;

    Result := True;
  Finally
    FreeAndNil(qryItens);
  End;
end;

function TfrmCadCashback.fExecutaValidouFiltroPesquisa(const edtCodigo,
  edtDescricao: TEditFocus; var arrPesquisa: TConsultasArray;
  const funcPesquisa: TFuncRetornoPequisa;
  const funcPesquisaComConst: TFuncRetornoPequisaComConst;
  const strMensagem: String): Boolean;
begin
  Result := False;

  If (Not Assigned(funcPesquisa)) And
     (Not Assigned(funcPesquisaComConst)) Then
  Begin
    fMensagem('ATENÇÃO', 'Não foi possível efetuar a pesquisa!', ['&OK']);
    edtCodigo.Clear;
    pSetFocus(edtCodigo);
    Exit;
  End;

  If (edtCodigo.Text = DupeString('0', edtCodigo.MaxLength)) Then
  Begin
    If(edtDescricao.Text = '+1') Then
      Exit;
  End;

  If fEmptyStr(edtCodigo.Text) Then
    edtDescricao.Text := 'TODOS'
  Else
  Begin
    If Assigned(funcPesquisa) Then
      edtDescricao.Text := funcPesquisa(edtCodigo.Text)
    Else
    If Assigned(funcPesquisaComConst) Then
      edtDescricao.Text := funcPesquisaComConst(edtCodigo.Text);

    SetLength(arrPesquisa, 1);
    arrPesquisa[0].strCodigo := edtCodigo.Text;
  End;

  If fEmptyStr(edtDescricao.Text) Then
  Begin
    If(Not fEmptyStr(edtCodigo.Text))  Then
    Begin
      fMensagem('AVISO', strMensagem, ['&OK']);
      edtCodigo.Clear;
      pSetFocus(edtCodigo);
    End;
  End;

  Result := True;
end;

function TfrmCadCashback.fExisteCashBackComMesmoPeriodoDevolucaoEmbalagem: Boolean;
var
  qryConsulta : TUniQuery;
  stlMensagem : TStringList;
  strMensagem : String;
begin
  Result := False;

  If (fRetornaTipoCashback <> 'DE') Then
    Exit;

  qryConsulta := nil;
  stlMensagem := nil;

  Try
    stlMensagem := TStringList.Create;
    qryConsulta := fCriaQuery;

    qryConsulta.Close;
    qryConsulta.SQL.Text := 'SELECT '
                          + '       C.CSH_CODIGO '
                          + '     , C.CSH_DESCRI '
                          + '     , C.CSH_INIVIG '
                          + '     , C.CSH_FINVIG '
                          + '     , "" AS ITE_CODITE '
                          + '     , "" ITE_DESITE '
                          + '     , "SI" AS TIPO '
                          + '  FROM CADCSH C '
                          + ' WHERE (:INIVIG BETWEEN C.CSH_INIVIG AND C.CSH_FINVIG '
                          + '    OR  :FINVIG BETWEEN C.CSH_INIVIG AND C.CSH_FINVIG '
                          + '    OR  C.CSH_INIVIG BETWEEN :INIVIG AND :FINVIG '
                          + '    OR  C.CSH_FINVIG BETWEEN :INIVIG AND :FINVIG) '
                          + '   AND C.CSH_TIPCSH = "DE" '
                          + '   AND C.CSH_CODIGO <> :CODIGO '
                          + ' ORDER BY C.CSH_CODIGO ';

    qryConsulta.ParamByName('INIVIG').AsDateTime := StrToDate(dbeIniVig.Text);
    qryConsulta.ParamByName('FINVIG').AsDateTime := StrToDate(dbeFinVig.Text);
    qryConsulta.ParamByName('CODIGO').AsString   := dbeCodigo.Text;
    qryConsulta.Open;

    Result := (qryConsulta.RecordCount > 0);

    If Not Result Then
      Exit;

    qryConsulta.First;
    While Not qryConsulta.Eof Do
    Begin
      strMensagem := 'CASHBACK: '
                   + Copy(qryConsulta.FieldByName('CSH_CODIGO').AsString
                   +      '-'
                   +      qryConsulta.FieldByName('CSH_DESCRI').AsString, 1, 30)
                   + ' - VIGÊNCIA: '
                   + FormatDateTime('dd/mm/yyyy', qryConsulta.FieldByName('CSH_INIVIG').AsDateTime)
                   + ' a '
                   + FormatDateTime('dd/mm/yyyy', qryConsulta.FieldByName('CSH_FINVIG').AsDateTime);

      If Not fEmptyStr(strMensagem) Then
        stlMensagem.Add(strMensagem);

      qryConsulta.Next;
    End;

    Result := (stlMensagem.Count > 0);

    If Not Result Then
      Exit;

    frmObservacao := nil;
    Try
      pCriarFormularios(TfrmObservacao, frmObservacao);
      frmObservacao.Width  := 900;
      frmObservacao.Height := 500;

      frmObservacao.lblMensagem.Caption := 'Já existe(m) outro(s) cashback(s) com período semelhantes';
      frmObservacao.memObs.Lines.Add('Cashback(s) que estão vigentes:');
      frmObservacao.memObs.Lines.AddStrings(stlMensagem);
      frmObservacao.ShowModal;
    Finally
      pFreeAndNil(frmObservacao);
    End;
  Finally
    FreeAndNil(qryConsulta);
    FreeAndNil(stlMensagem);
  End;
end;

function TfrmCadCashback.fExisteCashBackComMesmoPeriodoSemCliente: Boolean;
var
  qryConsulta       : TUniQuery;
  cdsItensValidacao : TUniClientDataSet;
  stlMensagem       : TStringList;
  strBaseMensagem,
  strMensagem       : String;
begin
  qryConsulta       := nil;
  cdsItensValidacao := nil;
  stlMensagem       := nil;

  Try
    cdsItensValidacao := TUniClientDataSet.Create(nil);
    stlMensagem       := TStringList.Create;
    qryConsulta       := fCriaQuery;

    qryConsulta.Close;
    qryConsulta.SQL.Text := 'SELECT '
                          + '       C.CSH_CODIGO '
                          + '     , C.CSH_DESCRI '
                          + '     , C.CSH_INIVIG '
                          + '     , C.CSH_FINVIG '
                          + '     , "" AS ITE_CODITE '
                          + '     , "" ITE_DESITE '
                          + '     , "SI" AS TIPO '
                          + '  FROM CADCSH C '
                          + ' WHERE (:INIVIG BETWEEN C.CSH_INIVIG AND C.CSH_FINVIG '
                          + '    OR  :FINVIG BETWEEN C.CSH_INIVIG AND C.CSH_FINVIG '
                          + '    OR  C.CSH_INIVIG BETWEEN :INIVIG AND :FINVIG '
                          + '    OR  C.CSH_FINVIG BETWEEN :INIVIG AND :FINVIG) '
                          + '   AND NOT EXISTS(SELECT L.AUTOINCREM FROM CLICSH L '
                          + '                   WHERE L.CSH_SEQCSH = C.AUTOINCREM) '
                          + '   AND NOT EXISTS(SELECT T.AUTOINCREM FROM ITECSH T '
                          + '                   WHERE T.CSH_SEQCSH = C.AUTOINCREM) '
                          + '   AND C.CSH_TIPCSH <> "DE" '
                          + '   AND C.CSH_CODIGO <> :CODIGO '
                          + ' UNION '
                          + 'SELECT '
                          + '       C.CSH_CODIGO '
                          + '     , C.CSH_DESCRI '
                          + '     , C.CSH_INIVIG '
                          + '     , C.CSH_FINVIG '
                          + '     , I.ITE_CODITE '
                          + '     , I.ITE_DESITE '
                          + '     , "CI" AS TIPO '
                          + '  FROM CADCSH C '
                          + ' INNER JOIN ITECSH T ON T.CSH_SEQCSH = C.AUTOINCREM '
                          + ' INNER JOIN CADITE I ON T.CSH_CODITE = I.ITE_CODITE '
                          + ' WHERE (:INIVIG BETWEEN C.CSH_INIVIG AND C.CSH_FINVIG '
                          + '    OR  :FINVIG BETWEEN C.CSH_INIVIG AND C.CSH_FINVIG '
                          + '    OR  C.CSH_INIVIG BETWEEN :INIVIG AND :FINVIG '
                          + '    OR  C.CSH_FINVIG BETWEEN :INIVIG AND :FINVIG) '
                          + '   AND NOT EXISTS(SELECT L.AUTOINCREM FROM CLICSH L '
                          + '                   WHERE L.CSH_SEQCSH = C.AUTOINCREM) '
                          + '   AND C.CSH_TIPCSH <> "DE" '
                          + '   AND C.CSH_CODIGO <> :CODIGO '
                          + ' ORDER BY 1 ';

    qryConsulta.ParamByName('INIVIG').AsDateTime := StrToDate(dbeIniVig.Text);
    qryConsulta.ParamByName('FINVIG').AsDateTime := StrToDate(dbeFinVig.Text);
    qryConsulta.ParamByName('CODIGO').AsString   := dbeCodigo.Text;
    qryConsulta.Open;

    Result := (qryConsulta.RecordCount > 0);

    If Not Result Then
      Exit;

    If Result And (Not MatchStr(fRetornaTipoCashback, ['VI','PI','DE'])) Then
    Begin
      fMensagem('ATENÇÃO!', 'Já existe outro cashback com período semelhante!', ['&Ok']);
      Exit;
    End;

    pCloneDataSet(cdsItensValidacao, cdsItens);
    qryConsulta.First;

    While Not qryConsulta.Eof Do
    Begin
      strMensagem     := EmptyStr;
      strBaseMensagem := 'CASHBACK: '
                       + Copy(qryConsulta.FieldByName('CSH_CODIGO').AsString
                       +      '-'
                       +      qryConsulta.FieldByName('CSH_DESCRI').AsString, 1, 30)
                       + ' - VIGÊNCIA: '
                       + FormatDateTime('dd/mm/yyyy', qryConsulta.FieldByName('CSH_INIVIG').AsDateTime)
                       + ' a '
                       + FormatDateTime('dd/mm/yyyy', qryConsulta.FieldByName('CSH_FINVIG').AsDateTime);

      If (Not fEmptyStr(qryConsulta.FieldByName('ITE_CODITE').AsString)) And
         (cdsItensValidacao.Locate('CODITE', qryConsulta.FieldByName('ITE_CODITE').AsString, [])) Then
      Begin
        strMensagem := strBaseMensagem
                     + ' - ITEM: '
                     + Copy(qryConsulta.FieldByName('ITE_CODITE').AsString
                     +      '-'
                     +      qryConsulta.FieldByName('ITE_DESITE').AsString, 1, 30);
      End;

      If fEmptyStr(strMensagem) And
         (qryConsulta.FieldByName('TIPO').AsString = 'SI') Then
        strMensagem := strBaseMensagem;

      If Not fEmptyStr(strMensagem) Then
        stlMensagem.Add(strMensagem);

      qryConsulta.Next;
    End;

    Result := (stlMensagem.Count > 0);

    If Not Result Then
      Exit;

    frmObservacao := nil;
    Try
      pCriarFormularios(TfrmObservacao, frmObservacao);
      frmObservacao.Width  := 900;
      frmObservacao.Height := 500;

      frmObservacao.lblMensagem.Caption := 'Já existe(m) outro(s) cashback(s) com período semelhantes';
      frmObservacao.memObs.Lines.Add('Cashback(s)/Produto(s) que estão vigentes:');
      frmObservacao.memObs.Lines.AddStrings(stlMensagem);
      frmObservacao.ShowModal;
    Finally
      pFreeAndNil(frmObservacao);
    End;
  Finally
    FreeAndNil(qryConsulta);
    FreeAndNil(cdsItensValidacao);
    FreeAndNil(stlMensagem);
  End;
end;

function TfrmCadCashback.fExisteClienteOutroCashBack: Boolean;
var
  qryConsulta : TUniQuery;
  intPosicao  : Integer;
begin
  Result := False;
  intPosicao := cdsClientes.Recno;
  cdsClientes.DisableControls;
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Text := 'SELECT C.AUTOINCREM FROM CADCSH C '
                          + ' INNER JOIN CLICSH I ON I.CSH_SEQCSH = C.AUTOINCREM '
                          + ' WHERE I.CSH_CODCLI = :CODCLI '
                          + '   AND (:INIVIG BETWEEN C.CSH_INIVIG AND C.CSH_FINVIG '
                          + '    OR  :FINVIG BETWEEN C.CSH_INIVIG AND C.CSH_FINVIG '
                          + '    OR  C.CSH_INIVIG BETWEEN :INIVIG AND :FINVIG '
                          + '    OR  C.CSH_FINVIG BETWEEN :INIVIG AND :FINVIG) ';

    If (StrToIntDef(dbeCodigo.Text,0) <> 0) Then
    Begin
      qryConsulta.SQL.Text := qryConsulta.SQL.Text
                            + '   AND C.CSH_CODIGO <> "'+dbeCodigo.Text+'" ';
    End;

    cdsClientes.First;
    While Not cdsClientes.Eof Do
    Begin
      qryConsulta.Close;
      qryConsulta.ParamByName('CODCLI').AsString   := cdsClientesCODCLI.AsString;
      qryConsulta.ParamByName('INIVIG').AsDateTime := StrToDate(dbeIniVig.Text);
      qryConsulta.ParamByName('FINVIG').AsDateTime := StrToDate(dbeFinVig.Text);
      qryConsulta.Open;

      If (qryConsulta.RecordCount > 0) Then
      Begin
        Result := True;
        fMensagem('ATENÇÃO!', 'O cliente ' + cdsClientesNOMCLI.AsString
                            + ' já está em outro cashback com período semelhante!', ['&Ok']);
        Exit;
      End;

      cdsClientes.Next;
    End;
  Finally
    cdsClientes.Recno := intPosicao;
    cdsClientes.EnableControls;
    FreeAndNil(qryConsulta);
  End;
end;

function TfrmCadCashback.fGravaCanalAcesso(strAutInc: String): Boolean;
var
  qryGravaCanalAcesso: TUniQuery;
begin
  Result := False;
  qryGravaCanalAcesso := fCriaQuery;

  Try
    cdsCanalAcesso.DisableControls;
    cdsCanalAcesso.First;

    If Not fExcluiCanalAcesso(strAutInc) Then
      Exit;

    qryGravaCanalAcesso.Close;
    qryGravaCanalAcesso.SQL.Clear;
    qryGravaCanalAcesso.SQL.Add('INSERT INTO CACCSH(AUTOINCREM, CSH_SEQCSH, CSH_CODEMP, CSH_CODCAC)');
    qryGravaCanalAcesso.SQL.Add('VALUES(:AUTINC, :SEQCSH, :CODEMP, :CODCAC)');

    While Not cdsCanalAcesso.Eof Do
    Begin
      qryGravaCanalAcesso.Close;
      qryGravaCanalAcesso.ParamByName('AUTINC').AsString := fRetAutoIncrem('CACCSH', VS_strCodEmp);
      qryGravaCanalAcesso.ParamByName('SEQCSH').AsString := strAutInc;
      qryGravaCanalAcesso.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGravaCanalAcesso.ParamByName('CODCAC').AsString := cdsCanalAcessoCODCAC.AsString;
      qryGravaCanalAcesso.ExecSQL;

      cdsCanalAcesso.Next;
    End;

    Result := True;
  Finally
    FreeAndNil(qryGravaCanalAcesso);
    cdsCanalAcesso.First;
    cdsCanalAcesso.EnableControls;
  End;
end;

function TfrmCadCashback.fGravaClientesCashback(strAutInc: String): Boolean;
var
  qryGravaClientes: TUniQuery;
begin
  Result := False;
  qryGravaClientes := fCriaQuery;

  Try
    cdsClientes.DisableControls;
    cdsClientes.First;

    If Not fExcluiClientesCashback(strAutInc) Then
      Exit;

    qryGravaClientes.Close;
    qryGravaClientes.SQL.Clear;
    qryGravaClientes.SQL.Add('INSERT INTO CLICSH(AUTOINCREM, CSH_SEQCSH, CSH_CODEMP, CSH_CODCLI) ');
    qryGravaClientes.SQL.Add('VALUES (:AUTINC, :SEQCSH, :CODEMP, :CODCLI) ');

    While Not cdsClientes.Eof Do
    Begin
      qryGravaClientes.Close;
      qryGravaClientes.ParamByName('AUTINC').AsString := fRetAutoIncrem('CLICSH', VS_strCodEmp);
      qryGravaClientes.ParamByName('SEQCSH').AsString := strAutInc;
      qryGravaClientes.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGravaClientes.ParamByName('CODCLI').AsString := cdsClientesCODCLI.AsString;
      qryGravaClientes.ExecSQL;

      cdsClientes.Next;
    End;

    Result := True;
  Finally
    FreeAndNil(qryGravaClientes);
    cdsClientes.First;
    cdsClientes.EnableControls;
  End;

end;

function TfrmCadCashback.fGravaCondicaoPagamento(strAutInc: String): Boolean;
var
  qryGravaCondicao: TUniQuery;
begin
  Result := False;
  qryGravaCondicao := fCriaQuery;

  Try
    cdsCondicaoPagamento.DisableControls;
    cdsCondicaoPagamento.First;

    If Not fExcluiCondicaoPagamento(strAutInc) Then
      Exit;

    qryGravaCondicao.Close;
    qryGravaCondicao.SQL.Clear;
    qryGravaCondicao.SQL.Add('INSERT INTO CPGCSH(AUTOINCREM, CSH_SEQCSH, CSH_CODEMP, CSH_CODCND)');
    qryGravaCondicao.SQL.Add('VALUES(:AUTINC, :SEQCSH, :CODEMP, :CODCND)');

    While Not cdsCondicaoPagamento.Eof Do
    Begin
      qryGravaCondicao.Close;
      qryGravaCondicao.ParamByName('AUTINC').AsString := fRetAutoIncrem('CPGCSH', VS_strCodEmp);
      qryGravaCondicao.ParamByName('SEQCSH').AsString := strAutInc;
      qryGravaCondicao.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGravaCondicao.ParamByName('CODCND').AsString := cdsCondicaoPagamentoCODCND.AsString;
      qryGravaCondicao.ExecSQL;

      cdsCondicaoPagamento.Next;
    End;

    Result := True;
  Finally
    FreeAndNil(qryGravaCondicao);
    cdsCondicaoPagamento.First;
    cdsCondicaoPagamento.EnableControls;
  End;
end;

function TfrmCadCashback.fGravaDepartamento(strAutInc: String): Boolean;
var
  qryGravaDepartamento: TUniQuery;
begin
  Result := False;
  qryGravaDepartamento := fCriaQuery;

  Try
    cdsDepartamento.DisableControls;
    cdsDepartamento.First;

    If Not fExcluiDepartamento(strAutInc) Then
      Exit;

    qryGravaDepartamento.Close;
    qryGravaDepartamento.SQL.Clear;
    qryGravaDepartamento.SQL.Add('INSERT INTO DEPCSH(AUTOINCREM, CSH_SEQCSH, CSH_CODEMP, CSH_CODDEP)');
    qryGravaDepartamento.SQL.Add('VALUES(:AUTINC, :SEQCSH, :CODEMP, :CODDEP)');

    While Not cdsDepartamento.Eof Do
    Begin
      qryGravaDepartamento.Close;
      qryGravaDepartamento.ParamByName('AUTINC').AsString := fRetAutoIncrem('DEPCSH', VS_strCodEmp);
      qryGravaDepartamento.ParamByName('SEQCSH').AsString := strAutInc;
      qryGravaDepartamento.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGravaDepartamento.ParamByName('CODDEP').AsString := cdsDepartamentoCODDEP.AsString;
      qryGravaDepartamento.ExecSQL;

      cdsDepartamento.Next;
    End;

    Result := True;
  Finally
    FreeAndNil(qryGravaDepartamento);
    cdsDepartamento.First;
    cdsDepartamento.EnableControls;
  End;
end;

function TfrmCadCashback.fGravaItensCashback(strAutInc: String): Boolean;
var
  qryGravaCondicao: TUniQuery;
begin
  Result := False;
  qryGravaCondicao := fCriaQuery;

  Try
    cdsItens.DisableControls;
    cdsItens.First;

    If Not fExcluiItensCashback(strAutInc) Then
      Exit;

    qryGravaCondicao.Close;
    qryGravaCondicao.SQL.Clear;
    qryGravaCondicao.SQL.Add('INSERT INTO ITECSH(AUTOINCREM, CSH_SEQCSH, CSH_CODEMP, CSH_CODITE, CSH_UNIDAD, CSH_CODMAR, CSH_REFERE, CSH_CODFOR)');
    qryGravaCondicao.SQL.Add('VALUES(:AUTINC, :SEQCSH, :CODEMP, :CODITE, :UNIDAD, :CODMAR, :REFERE, :CODFOR)');

    While Not cdsItens.Eof Do
    Begin
      qryGravaCondicao.Close;
      qryGravaCondicao.ParamByName('AUTINC').AsString := fRetAutoIncrem('ITECSH', VS_strCodEmp);
      qryGravaCondicao.ParamByName('SEQCSH').AsString := strAutInc;
      qryGravaCondicao.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGravaCondicao.ParamByName('CODITE').AsString := cdsItensCODITE.AsString;
      qryGravaCondicao.ParamByName('UNIDAD').AsString := cdsItensUNIDAD.AsString;
      qryGravaCondicao.ParamByName('CODMAR').AsString := cdsItensCODMAR.AsString;
      qryGravaCondicao.ParamByName('REFERE').AsString := cdsItensREFERE.AsString;
      qryGravaCondicao.ParamByName('CODFOR').AsString := cdsItensCODFOR.AsString;
      qryGravaCondicao.ExecSQL;

      cdsItens.Next;
    End;

    Result := True;
  Finally
    FreeAndNil(qryGravaCondicao);
    cdsItens.First;
    cdsItens.EnableControls;
  End;

end;

function TfrmCadCashback.fGravaItensUtilizacaoCashback(
  strAutInc: String): Boolean;
var
  qryItens: TUniQuery;
begin
  Result := False;
  qryItens := fCriaQuery;

  Try
    cdsItensUtilizacao.DisableControls;
    cdsItensUtilizacao.First;

    If Not fExcluiItensUtilizacaoCashback(strAutInc) Then
      Exit;

    qryItens.Close;
    qryItens.SQL.Clear;
    qryItens.SQL.Add('INSERT INTO ITUCSH(AUTOINCREM, CSH_SEQCSH, CSH_CODEMP, CSH_CODITE, CSH_UNIDAD, CSH_CODMAR, CSH_REFERE, CSH_CODFOR)');
    qryItens.SQL.Add('VALUES(:AUTINC, :SEQCSH, :CODEMP, :CODITE, :UNIDAD, :CODMAR, :REFERE, :CODFOR)');

    While Not cdsItensUtilizacao.Eof Do
    Begin
      qryItens.Close;
      qryItens.ParamByName('AUTINC').AsString := fRetAutoIncrem('ITUCSH', VS_strCodEmp);
      qryItens.ParamByName('SEQCSH').AsString := strAutInc;
      qryItens.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryItens.ParamByName('CODITE').AsString := cdsItensUtilizacaoCODITE.AsString;
      qryItens.ParamByName('UNIDAD').AsString := cdsItensUtilizacaoUNIDAD.AsString;
      qryItens.ParamByName('CODMAR').AsString := cdsItensUtilizacaoCODMAR.AsString;
      qryItens.ParamByName('REFERE').AsString := cdsItensUtilizacaoREFERE.AsString;
      qryItens.ParamByName('CODFOR').AsString := cdsItensUtilizacaoCODFOR.AsString;
      qryItens.ExecSQL;

      cdsItensUtilizacao.Next;
    End;

    Result := True;
  Finally
    FreeAndNil(qryItens);
    cdsItensUtilizacao.First;
    cdsItensUtilizacao.EnableControls;
  End;
end;

function TfrmCadCashback.fGravouCanalAcesso: Boolean;
begin
  Result := True;

  If tbsCanalAcesso.TabVisible Then
  Begin
    If fInformouCanalAcesso Then
    Begin
      If Not fGravaCanalAcesso(qryTabela.FieldByName('AUTOINCREM').AsString) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não foi possível gravar os Canais de Acesso!', ['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

function TfrmCadCashback.fGravouClientesCashback: Boolean;
begin
  Result := True;

  If tbsClientesCashback.TabVisible Then
  Begin
    If fInformouClientes Then
    Begin
      If Not fGravaClientesCashback(qryTabela.FieldByName('AUTOINCREM').AsString) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não foi possível gravar os clientes do cashback!', ['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

function TfrmCadCashback.fGravouCondicaoPagamento: Boolean;
begin
  Result := True;

  If tbsCondicaoPagamento.TabVisible Then
  Begin
    If fInformouCondicaoPagamento Then
    Begin
      If Not fGravaCondicaoPagamento(qryTabela.FieldByName('AUTOINCREM').AsString) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não foi possível gravar as condições de pagamento!', ['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

function TfrmCadCashback.fGravouDepartamento: Boolean;
begin
  Result := True;

  If tbsDepartamento.TabVisible Then
  Begin
    If fInformouDepartamento Then
    Begin
      If Not fGravaDepartamento(qryTabela.FieldByName('AUTOINCREM').AsString) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não foi possível gravar os Departamentos!', ['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

function TfrmCadCashback.fGravouItensCashback: Boolean;
begin
  Result := True;

  If tbsItensCashback.TabVisible Then
  Begin
    If fInformouItens Then
    Begin
      If Not fGravaItensCashback(qryTabela.FieldByName('AUTOINCREM').AsString) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não foi possível gravar os itens do cashback!', ['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

function TfrmCadCashback.fGravouItensUtilizacaoCashback: Boolean;
begin
  Result := True;

  If tbsItensUtilizacaoCashback.TabVisible Then
  Begin
    If fInformouItensUtilizacao Then
    Begin
      If Not fGravaItensUtilizacaoCashback(qryTabela.FieldByName('AUTOINCREM').AsString) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não foi possível gravar os itens de utilização do cashback!', ['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

function TfrmCadCashback.fInformouCanalAcesso: Boolean;
begin
  Result := (dbeCnlAce.Field.AsString = 'D') And
            (cdsCanalAcesso.RecordCount > 0);
end;

function TfrmCadCashback.fInformouClientes: Boolean;
begin
  Result := True;

  If (dbeTipPes.Text = 'M') Then
  Begin
    Result := cdsClientes.RecordCount > 0;
    Exit;
  End;
end;

function TfrmCadCashback.fInformouCondicaoPagamento: Boolean;
begin
  Result := (dbeConPag.Field.AsString = 'D') And
            (cdsCondicaoPagamento.RecordCount > 0);
end;

function TfrmCadCashback.fInformouDepartamento: Boolean;
begin
  Result := (dbeDepart.Field.AsString = 'D') And
            (cdsDepartamento.RecordCount > 0);
end;

function TfrmCadCashback.fInformouItens: Boolean;
begin
  Result := True;

  If rdbPerIte.Checked Then
  Begin
    Result := cdsItens.RecordCount > 0;
    Exit;
  End;

  If rdbValIte.Checked Then
  Begin
    Result := cdsItens.RecordCount > 0;
    Exit;
  End;
end;

function TfrmCadCashback.fInformouItensUtilizacao: Boolean;
begin
  Result := (dbeUtiIte.Field.AsString = 'S') And
            (cdsItensUtilizacao.RecordCount > 0);
end;

procedure TfrmCadCashback.pAdicionarFiltros(const qryConsulta: TUniQuery;
  var arrConsulta: TConsultasArray; const strCampoFiltro: String);
var
  strResult: String;
  intIndice: integer;
begin
  strResult := EmptyStr;
  For intIndice := Low(arrConsulta) To High(arrConsulta) Do
  Begin
    pIncrementaListaStr(arrConsulta[intIndice].strCodigo, strResult, True);
  End;

  If Not fEmptyStr(strResult) Then
  Begin
    qryConsulta.SQL.Add('AND '+strCampoFiltro+' IN('+strResult+')');
  End;
end;

procedure TfrmCadCashback.pAdicionarFiltros(const qryConsulta: TUniQuery;
  const strFiltro, strCampoFiltro: String);
begin
  If Not fEmptyStr(strFiltro) Then
    qryConsulta.SQL.Add('AND '+strCampoFiltro+' = "'+strFiltro+'"');
end;

procedure TfrmCadCashback.pAdicionaCanalAcesso;
begin
  If not fValidaCanalAcesso Then
    Exit;

  If (cdsCanalAcesso.Locate('CODCAC', edtFilCodCac.Text, [])) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse Canal de Acesso já foi escolhido!', ['&Ok']);
    pSetFocus(edtFilCodCac);
    Exit;
  End;

  cdsCanalAcesso.Append;
  cdsCanalAcessoCODCAC.AsString := edtFilCodCac.Text;
  cdsCanalAcessoNOMCAC.AsString := fCampoTabela('CAC_NOMCAC', 'CADCAC', ['CAC_CODCAC'], [edtFilCodCac.Text], False);
  cdsCanalAcesso.Post;

  btnCancelCnlAce.Click;
end;

procedure TfrmCadCashback.pAdicionaCondicaoPagamento;
begin
  If not fValidaCondicaoPagamento Then
    Exit;

  If (cdsCondicaoPagamento.Locate('CODCND', edtCodCnd.Text, [])) Then
  Begin
    fMensagem('ATENÇÃO!', 'Essa condição de pagamento já foi escolhida!', ['&Ok']);
    pSetFocus(edtCodCnd);
    Exit;
  End;

  cdsCondicaoPagamento.Append;
  cdsCondicaoPagamentoCODCND.AsString := edtCodCnd.Text;
  cdsCondicaoPagamentoDESCND.AsString := fCampoTabela('CND_DESCRI', 'CADCND', ['CND_CODIGO'], [edtCodCnd.Text], False);
  cdsCondicaoPagamentoCNDPAG.AsString := fFormataCondPag(fCampoTabela('CND_CNDPAG', 'CADCND', ['CND_CODIGO'], [edtCodCnd.Text], False));
  cdsCondicaoPagamento.Post;

  btnCancelCndPag.Click;
end;

procedure TfrmCadCashback.pAdicionaDepartamento;
begin
  If not fValidaDepartamento Then
    Exit;

  If (cdsDepartamento.Locate('CODDEP', edtCodDep.Text, [])) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse Departamento já foi escolhido!', ['&Ok']);
    pSetFocus(edtCodDep);
    Exit;
  End;

  cdsDepartamento.Append;
  cdsDepartamentoCODDEP.AsString := edtCodDep.Text;
  cdsDepartamentoDESDEP.AsString := fCampoTabela('DEP_DESCRI', 'CADDEP', ['DEP_CODIGO'], [edtCodDep.Text], False);
  cdsDepartamento.Post;

  btnCancelCadDep.Click;
end;

procedure TfrmCadCashback.pAdicionarFiltros(const qryConsulta: TUniQuery;
  const strSQL: String);
begin
  If Not fEmptyStr(strSQL) Then
    qryConsulta.SQL.Add('AND '+strSQL);
end;

procedure TfrmCadCashback.btnAlterarClick(Sender: TObject);
begin
  pHabilitaDesabilitaControles(True);

  pLimpaFiltroItens;
  pLimpaFiltroItensUtilizacao;
  pLimpaFiltroCondicaoPagamento;
  pLimpaFiltroClientes;
  pLimpaFiltroCanalAcesso;
  pLimpaFiltroDepartamento;

  inherited;

  pCarregaDadosCashback;
end;

function TfrmCadCashback.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = dbeCodigo) Then
  Begin

    If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
    Begin
      fMensagem('ATENÇÃO!',
        'O Código do cashback deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (blnBuscaPorChave) Then
    Begin
      If Not fBuscaPorCamposChave Then
        pLimparCampos;
    End;

  End
  Else If (Sender = dbeDescri) Then
  Begin

    If fEmptyStr(dbeDescri.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'A descrição do cashback deve ser preenchida!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeTipPes) Then
  Begin

    If fEmptyStr(dbeTipPes.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'O campo Tipo de Cliente deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (Not MatchStr(dbeTipPes.Text, ['F','J','A','M'])) Then
    Begin
      fMensagem('ATENÇÃO!',
        'O campo Tipo de Cliente deve ser preenchido com "F", "J", "A" ou "M"!',
        ['&Ok']);
      Result := False;
    End;

    pHabilitaDesabilitaTabClientesCashback;
  End

  Else If (Sender = dbeIniVig) Then
  Begin

    If fEmptyStr(dbeIniVig.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'O campo de início da vigência deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If StrToDateDef(dbeIniVig.Text, 0) = 0 Then
    Begin
      fMensagem('ATENÇÃO!',
        'Informe uma data válida para o início da vigência!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeFinVig) Then
  Begin

    If fEmptyStr(dbeFinVig.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'O campo de final da vigência deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If StrToDateDef(dbeFinVig.Text, 0) = 0 Then
    Begin
      fMensagem('ATENÇÃO!',
        'Informe uma data válida para o final da vigência!', ['&Ok']);
      Result := False;
    End
    Else If StrToDateDef(dbeFinVig.Text, 0) <
      StrToDateDef(dbeIniVig.Text, 0) Then
    Begin
      fMensagem('ATENÇÃO!',
        'A data final da vigência não pode ser menor que a data inicial!',
        ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeValFix) And dbeValFix.Enabled Then
  Begin

    If fEmptyStr(dbeValFix.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe o valor fixo do desconto!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbeValFix.Text) <= 0 Then
    Begin
      fMensagem('ATENÇÃO!',
        'O valor fixo do desconto deve ser maior que zero!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbePerDes) And dbePerDes.Enabled Then
  Begin

    If fEmptyStr(dbePerDes.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'Informe o percentual do desconto sobre o valor da compra!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbePerDes.Text) <= 0 Then
    Begin
      fMensagem('ATENÇÃO!',
        'O percentual do desconto deve ser maior que zero!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeValCom) And dbeValCom.Enabled Then
  Begin

    If fEmptyStr(dbeValCom.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe o valor em compras!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbeValCom.Text) <= 0 Then
    Begin
      fMensagem('ATENÇÃO!',
        'O valor em compras deve ser maior que zero!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeValAcu) And dbeValAcu.Enabled Then
  Begin

    If fEmptyStr(dbeValAcu.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe o valor para acumular no cashback!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbeValAcu.Text) <= 0 Then
    Begin
      fMensagem('ATENÇÃO!',
        'O valor para acumular no cashback deve ser maior que zero!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbePerIte) And dbePerIte.Enabled Then
  Begin
    If fEmptyStr(dbePerIte.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe o percentual sobre o valor dos itens!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbePerIte.Text) <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O precentual sobre o valor dos itens deve ser maior que zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeValIte) And dbeValIte.Enabled Then
  Begin
    If fEmptyStr(dbeValIte.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe o valor fixo dos itens!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbeValIte.Text) <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor fixo dos itens deve ser maior que zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeValDve) And dbeValDve.Enabled And dbeValDve.Visible Then
  Begin
    If fEmptyStr(dbeValDve.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe o valor de acúmulo para cada unidade de embalagem devolvida!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbeValDve.Text) < 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor de acúmulo para cada unidade de embalagem devolvida não pode ser negativo!', ['&Ok']);
      Result := False;
    End
    Else If rdbValDve.Checked And (fStrToFloat(dbeValDve.Text) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor de acúmulo para cada unidade de embalagem devolvida precisa ser maior que zero!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeChsBCh) Then
  Begin

    If fEmptyStr(dbeChsBCh.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Campo gerar cashback sobre venda com cashback, deve ser preenchido com [S] ou [N]!', ['&Ok']);
      Result := False;
    End
    Else If (Not MatchStr(dbeChsBCh.Text,['S','N'])) Then
      Result := False
  End

  Else If (Sender = dbeMinVen) Then
  Begin

    If fEmptyStr(dbeMinVen.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'Informe o valor mínimo para permitir utilizar este cashback em vendas!',
        ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbeMinVen.Text) < 0 Then
    Begin
      fMensagem('ATENÇÃO!',
        'O valor mínimo para permitir utilizar este cashback em vendas deve ser maior ou igual à zero!',
        ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbePerMax) Then
  Begin

    If fEmptyStr(dbePerMax.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'Informe o persentual máximo de cashback sobre a compra!',
        ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(dbePerMax.Text) < 0.01) Or
            (fStrToFloat(dbePerMax.Text) > 100.00) Then
    Begin
      fMensagem('ATENÇÃO!',
        'O percentual máximo para permitir utilizar este cashback em vendas deve estar entre 0.01 e 100.00%!',
        ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeDiaExp) And dbeDiaExp.Enabled Then
  Begin

    If fEmptyStr(dbeDiaExp.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'A quantidade de dias para expirar o cashback deve ser informado!', ['&Ok']
        );
      Result := False;
    End
    Else If fStrToFloat(dbeDiaExp.Text) < 0 Then
    Begin
      fMensagem('ATENÇÃO!',
        'A quantidade de dias para expirar o cashback deve ser maior ou igual à zero!',
        ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeIniVal) And dbeIniVal.Enabled Then
  Begin

    If fEmptyStr(dbeIniVal.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'O campo de início de utilização do cashback deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If StrToDateDef(dbeIniVal.Text, 0) = 0 Then
    Begin
      fMensagem('ATENÇÃO!',
        'Informe uma data válida para o início de utilização do cashback!', ['&Ok']);
      Result := False;
    End
    Else If StrToDateDef(dbeIniVal.Text, 0) <
      StrToDateDef(dbeIniVig.Text, 0) Then
    Begin
      fMensagem('ATENÇÃO!',
        'A data inicial de utilização do cashback não pode ser menor que a data inicial da vigência!',
        ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeFinVal) And dbeFinVal.Enabled Then
  Begin

    If fEmptyStr(dbeFinVal.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'O campo de final de utilização do cashback deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If StrToDateDef(dbeFinVal.Text, 0) = 0 Then
    Begin
      fMensagem('ATENÇÃO!',
        'Informe uma data válida para o término de utilização do cashback!', ['&Ok']);
      Result := False;
    End
    Else If StrToDateDef(dbeFinVal.Text, 0) <
      StrToDateDef(dbeIniVal.Text, 0) Then
    Begin
      fMensagem('ATENÇÃO!',
        'A data final de utilização do cashback não pode ser menor que a data inicial!',
        ['&Ok']);
      Result := False;
    End
    Else If StrToDateDef(dbeFinVal.Text, 0) <
      StrToDateDef(dbeFinVig.Text, 0) Then
    Begin
      fMensagem('ATENÇÃO!',
        'A data final de utilização do cashback não pode ser menor que a data final da vigência!',
        ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeUtiIte) Then
  Begin

    If fEmptyStr(dbeUtiIte.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'O campo Itens para utilização do Cashback deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (Not MatchStr(dbeUtiIte.Text, ['S','N'])) Then
    Begin
      fMensagem('ATENÇÃO!',
        'O campo Itens para utilização do Cashback deve ser preenchido com "S" ou "N"!',
        ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeConPag) Then
  Begin

    If fEmptyStr(dbeConPag.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'O campo Condição de Pagamento deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (Not MatchStr(dbeConPag.Text, ['T','D'])) Then
    Begin
      fMensagem('ATENÇÃO!',
        'O campo Condição de Pagamento deve ser preenchido com "T" ou "D"!',
        ['&Ok']);
      Result := False;
    End;

    pHabilitaDesabilitaTabCondicaoPagamento;
  End

  Else If (Sender = dbeCnlAce) Then
  Begin

    If fEmptyStr(dbeCnlAce.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'O campo Canal de Acesso deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (Not MatchStr(dbeCnlAce.Text, ['T','D'])) Then
    Begin
      fMensagem('ATENÇÃO!',
        'O campo Canal de Acesso deve ser preenchido com "T" ou "D"!',
        ['&Ok']);
      Result := False;
    End;

    pHabilitaDesabilitaTabCanalAcesso;
  End

  Else If (Sender = dbeDepart) Then
  Begin

    If fEmptyStr(dbeDepart.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'O campo Departamento deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (Not MatchStr(dbeDepart.Text, ['T','D'])) Then
    Begin
      fMensagem('ATENÇÃO!',
        'O campo Departamento deve ser preenchido com "T" ou "D"!',
        ['&Ok']);
      Result := False;
    End;

    pHabilitaDesabilitaTabDepartamento;
  End

  Else If (Sender = edtCodCnd) and blnBuscaPorChave Then
  Begin
    If Not fEmptyStr(edtCodCnd.Text) Then
    Begin
      If fEmptyStr(fRetDesConPag(edtCodCnd.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Condição não cadastrada!', ['&Ok']);
        Result := False;
      End
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'A Condição de Pagamento deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtFilCodCac) and blnBuscaPorChave Then
  Begin
    If Not fEmptyStr(edtFilCodCac.Text) Then
    Begin
      If fEmptyStr(fRetNomCanalAcesso(edtFilCodCac.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Canal de Acesso não cadastrado!', ['&Ok']);
        Result := False;
      End
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'O Canal de Acesso deve ser preenchido!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtCodDep) and blnBuscaPorChave Then
  Begin
    If Not fEmptyStr(edtCodDep.Text) Then
    Begin
      If fEmptyStr(fRetDescDepartamento(edtCodDep.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Departamento não cadastrado!', ['&Ok']);
        Result := False;
      End
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'O Departamento deve ser preenchido!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeItePro) Then
  Begin

    If (Not MatchStr(dbeItePro.Text,['S','N'])) Then
    Begin
      fMensagem('ATENÇÃO!', 'Campo gerar cashback sobre itens em Promoção, deve ser preenchido com [S] ou [N]!', ['&Ok']);
      Result := False;
    End
  End

  Else If (Sender = dbeDiaUti) Then
  Begin

    If fEmptyStr(dbeDiaUti.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'A quantidade de dias para permitir a utilizar o cashback após a compra deve ser informado!', ['&Ok']
        );
      Result := False;
    End
    Else If fStrToFloat(dbeDiaUti.Text) < 0 Then
    Begin
      fMensagem('ATENÇÃO!',
        'A quantidade de dias para permitir a utilizar o cashback após a compra deve ser maior ou igual à zero!',
        ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeGerCsh) Then
  Begin

    If fEmptyStr(dbeGerCsh.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'Informe o valor mínimo para permitir gerar cashback sobre vendas!',
        ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbeGerCsh.Text) < 0 Then
    Begin
      fMensagem('ATENÇÃO!',
        'O valor mínimo para permitir gerar cashback sobre vendas deve ser maior ou igual à zero!',
        ['&Ok']);
      Result := False;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmCadCashback.fValidaCanalAcesso: Boolean;
begin
  Result := fValidaCampos(edtFilCodCac, True);
end;

function TfrmCadCashback.fValidaCondicaoPagamento: Boolean;
begin
  Result := False;

  If (Not fValidaCampos(edtCodCnd, True)) Then
    Exit;

  Result := True;
end;

function TfrmCadCashback.fValidaDepartamento: Boolean;
begin
  Result := fValidaCampos(edtCodDep, True);
end;

function TfrmCadCashback.fValidouFiltroPesquisa(const edtCodigo,
  edtDescricao: TEditFocus; var arrPesquisa: TConsultasArray;
  const funcPesquisa: TFuncRetornoPequisaComConst;
  const strMensagem: String): Boolean;
begin
  Result := fExecutaValidouFiltroPesquisa(edtCodigo, edtDescricao, arrPesquisa,
              nil, funcPesquisa, strMensagem);
end;

function TfrmCadCashback.fValidouRegrasGravacao: Boolean;
begin
  Result := False;

  If fEmptyStr(fRetornaTipoCashback) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário que escolha algum tipo de cashback para geração.', ['&Ok']);
    Exit;
  End;

  If tbsItensCashback.TabVisible Then
  Begin
    If Not fInformouItens Then
    Begin
      fMensagem('ATENÇÃO!', 'Para utilizar o tipo de cashback '+dbeDescri.Text+','+sLineBreak+
                            ' os itens devem ser informados na aba "Itens do Cashback".', ['&Ok']);
      pgcDados.ActivePage := tbsItensCashback;
      pSetFocus(edtCodIteItens);
      Exit;
    End;
  End;

  If tbsClientesCashback.TabVisible Then
  Begin
    If Not fInformouClientes Then
    Begin
      fMensagem('ATENÇÃO!', 'Para utilizar o tipo de cliente "M" em '+dbeDescri.Text+','+sLineBreak+
                            ' é necessário incluir informações na aba "Clientes do Cashback".', ['&Ok']);
      pgcDados.ActivePage := tbsClientesCashback;
      pSetFocus(edtCodCli);
      Exit;
    End;

    If fExisteClienteOutroCashBack Then
      Exit;
  End
  Else
  Begin
    If (fRetornaTipoCashback <> 'DE') And
       fExisteCashBackComMesmoPeriodoSemCliente Then
      Exit
  End;

  If fExisteCashBackComMesmoPeriodoDevolucaoEmbalagem Then
    Exit;


  If tbsItensUtilizacaoCashback.TabVisible Then
  Begin
    If Not fInformouItensUtilizacao Then
    Begin
      fMensagem('ATENÇÃO!', 'Quando ativada a opção para "Definir itens para utilizar cashback", '+sLineBreak+
                            'a aba "Itens para Utilização do Cashback" deve conter registro(s).', ['&Ok']);
      pgcDados.ActivePage := tbsItensUtilizacaoCashback;
      pSetFocus(edtCodIteItensUtilizacao);
      Exit;
    End;
  End;

  If tbsCondicaoPagamento.TabVisible Then
  Begin
    If Not fInformouCondicaoPagamento Then
    Begin
      fMensagem('ATENÇÃO!', 'Quando a opção para "Condição de Pagamento" estiver em "Definir", '+sLineBreak+
                            'a aba "Condições de Pagamento" deve conter registro(s).', ['&Ok']);
      pgcDados.ActivePage := tbsCondicaoPagamento;
      pSetFocus(edtCodCnd);
      Exit;
    End;
  End;

  If tbsCanalAcesso.TabVisible Then
  Begin
    If Not fInformouCanalAcesso Then
    Begin
      fMensagem('ATENÇÃO!', 'Quando a opção para "Canal de Acesso" estiver em "Definir", '+sLineBreak+
                            'a aba "Canal de Acesso" deve conter registro(s).', ['&Ok']);
      pgcDados.ActivePage := tbsCanalAcesso;
      pSetFocus(edtFilCodCac);
      Exit;
    End;
  End;

  If tbsDepartamento.TabVisible Then
  Begin
    If Not fInformouDepartamento Then
    Begin
      fMensagem('ATENÇÃO!', 'Quando a opção para "Departamento" estiver em "Definir", '+sLineBreak+
                            'a aba "Departamento" deve conter registro(s).', ['&Ok']);
      pgcDados.ActivePage := tbsDepartamento;
      pSetFocus(edtCodDep);
      Exit;
    End;
  End;

  Result := True;
end;

function TfrmCadCashback.fValidouFiltroPesquisa(const edtCodigo,
  edtDescricao: TEditFocus; var arrPesquisa: TConsultasArray;
  const funcPesquisa: TFuncRetornoPequisa; const strMensagem: String): Boolean;
begin
  Result := fExecutaValidouFiltroPesquisa(edtCodigo, edtDescricao, arrPesquisa,
              funcPesquisa, nil, strMensagem);
end;

procedure TfrmCadCashback.grdClientesDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case key of
    VK_DELETE: pExcluiRegistroClientes;
  End;

end;

procedure TfrmCadCashback.grdCondicaoPagamentoTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case key of
    VK_DELETE: pExcluiRegistroCondicaoPagamento;
  End;
end;

procedure TfrmCadCashback.grdDepartamentoTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case key of
    VK_DELETE: pExcluiRegistroDepartamento;
  End;
end;

procedure TfrmCadCashback.grdItensDBTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case key of
    VK_DELETE: pExcluiRegistroItens;
  End;
end;

procedure TfrmCadCashback.grdItensUtilizacaoDBTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case key of
    VK_DELETE: pExcluiRegistroItensUtilizacao;
  End;
end;

procedure TfrmCadCashback.mskCgcCpfExit(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(mskCgcCpf.Text)) ANd
     (Not fValidaCnpjCpf(edtCgcCpf.Text, mskCgcCpf.Text)) Then
    pSetFocus(mskCgcCpf);
end;

procedure TfrmCadCashback.mskLinhaGrupoItensExit(Sender: TObject);
begin
  inherited;
  If (mskLinhaGrupoItens.Text = '000000') Then
  Begin
    If(edtDesGrupoItens.Text = '+1') Then
      Exit;
  End;

  If fEmptyStr(mskLinhaGrupoItens.Text) Then
    edtDesGrupoItens.Text := 'TODOS'
  Else
  Begin
    edtDesGrupoItens.Text := fRetNomeLinhaGrupo(mskLinhaGrupoItens.Text);
    SetLength(arrGrupos, 1);
    arrGrupos[0].strCodigo := mskLinhaGrupoItens.Text;
  End;

  If fEmptyStr(edtDesGrupoItens.Text) Then
  Begin
    If(Not fEmptyStr(mskLinhaGrupoItens.Text))  Then
    Begin
      fMensagem('AVISO', 'Linha/Grupo não encontrado.', ['&O K']);
      mskLinhaGrupoItens.Clear;
      pSetFocus(mskLinhaGrupoItens);
    End;
  End;
end;

procedure TfrmCadCashback.mskLinhaGrupoItensUtilizacaoExit(Sender: TObject);
begin
  inherited;
  If (mskLinhaGrupoItensUtilizacao.Text = '000000') Then
  Begin
    If(edtDesGrupoItensUtilizacao.Text = '+1') Then
      Exit;
  End;

  If fEmptyStr(mskLinhaGrupoItensUtilizacao.Text) Then
    edtDesGrupoItensUtilizacao.Text := 'TODOS'
  Else
  Begin
    edtDesGrupoItensUtilizacao.Text := fRetNomeLinhaGrupo(mskLinhaGrupoItensUtilizacao.Text);
    SetLength(arrGrupos, 1);
    arrGrupos[0].strCodigo := mskLinhaGrupoItensUtilizacao.Text;
  End;

  If fEmptyStr(edtDesGrupoItens.Text) Then
  Begin
    If(Not fEmptyStr(mskLinhaGrupoItens.Text))  Then
    Begin
      fMensagem('AVISO', 'Linha/Grupo não encontrado.', ['&O K']);
      mskLinhaGrupoItens.Clear;
      pSetFocus(mskLinhaGrupoItens);
    End;
  End;
end;

procedure TfrmCadCashback.mskLinhaGrupoItensKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinhaGrupoItens, edtDesGrupoItens, Nil, Key, arrGrupos, False) Then
  Begin
    If fValidaCampos(mskLinhaGrupoItens, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCashback.mskLinhaGrupoItensUtilizacaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinhaGrupoItensUtilizacao, edtDesGrupoItensUtilizacao, Nil, Key, arrGrupos, False) Then
  Begin
    If fValidaCampos(mskLinhaGrupoItensUtilizacao, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCashback.pAfterOpen(DataSet: TDataSet);
Var
  intIndex: Integer;
begin
  For intIndex := 0 To DataSet.Fields.Count - 1 Do
  Begin
    Case DataSet.Fields[intIndex].DataType Of
      ftFloat, ftCurrency, ftBCD:
        TFloatField(DataSet.Fields[intIndex]).DisplayFormat := '#,##0.00';
      ftDate:
        TDateField(DataSet.Fields[intIndex]).EditMask := '99/99/9999';
    End;
  End;
end;

function TfrmCadCashback.fCarregaCanalAcesso(pgbProgresso: TcxProgressBar): Boolean;
var
  qryCanalAcesso: TUniQuery;
begin
  Result := True;

  If fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) Then
    Exit;

  qryCanalAcesso := fCriaQuery;

  Try
    qryCanalAcesso.Close;
    qryCanalAcesso.SQL.Clear;
    qryCanalAcesso.SQL.Add('SELECT * FROM CACCSH');
    qryCanalAcesso.SQL.Add('INNER JOIN CADCAC ON CAC_CODCAC = CSH_CODCAC');
    qryCanalAcesso.SQL.Add('WHERE CSH_SEQCSH = :SEQCSH');
    qryCanalAcesso.ParamByName('SEQCSH').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryCanalAcesso.Open;

    cdsCanalAcesso.EmptyDataSet;

    If qryCanalAcesso.IsEmpty Then
      Exit;

    cdsCanalAcesso.DisableControls;
    pgbProgresso.Properties.Max := qryCanalAcesso.RecordCount;

    Try
      While Not qryCanalAcesso.Eof Do
      Begin
        pInfoStatusCarregamento('Carregando canais de acesso: ' + IntToStr(qryCanalAcesso.RecNo) + ' de ' + IntToStr(qryCanalAcesso.RecordCount), pgbProgresso);
        pStepStatusCarregamento(pgbProgresso);

        cdsCanalAcesso.Append;
        cdsCanalAcessoCODCAC.AsString := qryCanalAcesso.FieldByName('CSH_CODCAC').AsString;
        cdsCanalAcessoNOMCAC.AsString := qryCanalAcesso.FieldByName('CAC_NOMCAC').AsString;
        cdsCanalAcesso.Post;

        qryCanalAcesso.Next;
      End;

      cdsCanalAcesso.First;
    Finally
      pHabilitaDesabilitaTabCanalAcesso;
      cdsCanalAcesso.EnableControls;
    End;
  Finally
    FreeAndNil(qryCanalAcesso);
  End;
end;

function TfrmCadCashback.fCarregaClientesCashback(pgbProgresso: TcxProgressBar): Boolean;
var
  qryClientes: TUniQuery;
begin
  Result := True;

  If fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) Then
    Exit;

  qryClientes := fCriaQuery;

  Try
    qryClientes.Close;
    qryClientes.SQL.Clear;
    qryClientes.SQL.Text := 'SELECT '
                       + '       C.* '
                       + '     , L.CLI_NOMCLI '
                       + '  FROM CLICSH C '
                       + ' INNER JOIN CADCLI L ON L.CLI_CODCLI = CSH_CODCLI '
                       + ' WHERE CSH_SEQCSH = :SEQCSH ';
    qryClientes.ParamByName('SEQCSH').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryClientes.Open;

    cdsClientes.EmptyDataSet;

    If qryClientes.IsEmpty Then
      Exit;

    cdsClientes.DisableControls;
    pgbProgresso.Properties.Max := qryClientes.RecordCount;

    Try
      While Not qryClientes.Eof Do
      Begin
        pInfoStatusCarregamento('Carregando clientes: ' + IntToStr(qryClientes.RecNo) + ' de ' + IntToStr(qryClientes.RecordCount), pgbProgresso);
        pStepStatusCarregamento(pgbProgresso);

        cdsClientes.Append;
        cdsClientesCODCLI.AsString := qryClientes.FieldByName('CSH_CODCLI').AsString;
        cdsClientesNOMCLI.AsString := qryClientes.FieldByName('CLI_NOMCLI').AsString;
        cdsClientes.Post;

        qryClientes.Next;
      End;

      cdsClientes.First;
    Finally
      pHabilitaDesabilitaTabClientesCashback;
      cdsClientes.EnableControls;
    End;
  Finally
    FreeAndNil(qryClientes);
  End;
end;

function TfrmCadCashback.fCarregaCondicaoPagamento(pgbProgresso: TcxProgressBar): Boolean;
var
  qryCondicoes: TUniQuery;
begin
  Result := True;

  If fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) Then
    Exit;

  qryCondicoes := fCriaQuery;

  Try
    qryCondicoes.Close;
    qryCondicoes.SQL.Clear;
    qryCondicoes.SQL.Text := 'SELECT '
                       + '       C.* '
                       + '     , N.CND_DESCRI '
                       + '     , N.CND_CNDPAG '
                       + '  FROM CPGCSH C '
                       + ' INNER JOIN CADCND N ON N.CND_CODIGO = C.CSH_CODCND '
                       + ' WHERE CSH_SEQCSH = :SEQCSH ';
    qryCondicoes.ParamByName('SEQCSH').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryCondicoes.Open;

    cdsCondicaoPagamento.EmptyDataSet;

    If qryCondicoes.IsEmpty Then
      Exit;

    cdsCondicaoPagamento.DisableControls;
    pgbProgresso.Properties.Max := qryCondicoes.RecordCount;

    Try
      While Not qryCondicoes.Eof Do
      Begin
        pInfoStatusCarregamento('Carregando condições de pagamento: ' + IntToStr(qryCondicoes.RecNo) + ' de ' + IntToStr(qryCondicoes.RecordCount), pgbProgresso);
        pStepStatusCarregamento(pgbProgresso);

        cdsCondicaoPagamento.Append;
        cdsCondicaoPagamentoCODCND.AsString := qryCondicoes.FieldByName('CSH_CODCND').AsString;
        cdsCondicaoPagamentoDESCND.AsString := qryCondicoes.FieldByName('CND_DESCRI').AsString;
        cdsCondicaoPagamentoCNDPAG.AsString := fFormataCondPag(qryCondicoes.FieldByName('CND_CNDPAG').AsString);
        cdsCondicaoPagamento.Post;

        qryCondicoes.Next;
      End;

      cdsCondicaoPagamento.First;
    Finally
      pHabilitaDesabilitaTabCondicaoPagamento;
      cdsCondicaoPagamento.EnableControls;
    End;
  Finally
    FreeAndNil(qryCondicoes);
  End;
end;

procedure TfrmCadCashback.pCarregaDadosCashback;
begin
  pHabilitarTipoCashback();
  pHabilitarUtilizacaoCashback();

  pCarregarTipoCashback();
  pCarregarUtilizacaoCashback();

  cdsItens.EmptyDataSet;
  cdsItensUtilizacao.EmptyDataSet;
  cdsClientes.EmptyDataSet;
  cdsCondicaoPagamento.EmptyDataSet;
  cdsCanalAcesso.EmptyDataSet;
  cdsDepartamento.EmptyDataSet;

  pHabilitaDesabilitaTabItensCashback;
  pHabilitaDesabilitaTabItensUtilizacaoCashback;
  pHabilitaDesabilitaTabCondicaoPagamento;
  pHabilitaDesabilitaTabCanalAcesso;
  pHabilitaDesabilitaTabDepartamento;
  pHabilitaDesabilitaTabClientesCashback;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  pExecutaCarregamento(fCarregaItensCashback);
  pExecutaCarregamento(fCarregaItensUtilizacaoCashback);
  pExecutaCarregamento(fCarregaClientesCashback);
  pExecutaCarregamento(fCarregaCondicaoPagamento);
  pExecutaCarregamento(fCarregaCanalAcesso);
  pExecutaCarregamento(fCarregaDepartamento);

  chkCliCon.Checked := (qryTabela.FieldByName('CSH_CLICON').AsString = 'S');

  If (qryTabela.State In [dsEdit]) Then
    pHabilitaDesabilitaControles(False);
End;

function TfrmCadCashback.fCarregaDepartamento(pgbProgresso: TcxProgressBar): Boolean;
var
  qryDepartamento: TUniQuery;
begin
  Result := True;

  If fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) Then
    Exit;

  qryDepartamento := fCriaQuery;

  Try
    qryDepartamento.Close;
    qryDepartamento.SQL.Clear;
    qryDepartamento.SQL.Add('SELECT * FROM DEPCSH');
    qryDepartamento.SQL.Add('INNER JOIN CADDEP ON DEP_CODIGO = CSH_CODDEP');
    qryDepartamento.SQL.Add('WHERE CSH_SEQCSH = :SEQCSH');
    qryDepartamento.ParamByName('SEQCSH').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryDepartamento.Open;

    cdsDepartamento.EmptyDataSet;

    If qryDepartamento.IsEmpty Then
      Exit;

    cdsDepartamento.DisableControls;
    pgbProgresso.Properties.Max := qryDepartamento.RecordCount;

    Try
      While Not qryDepartamento.Eof Do
      Begin
        pInfoStatusCarregamento('Carregando departamentos: ' + IntToStr(qryDepartamento.RecNo) + ' de ' + IntToStr(qryDepartamento.RecordCount), pgbProgresso);
        pStepStatusCarregamento(pgbProgresso);

        cdsDepartamento.Append;
        cdsDepartamentoCODDEP.AsString := qryDepartamento.FieldByName('CSH_CODDEP').AsString;
        cdsDepartamentoDESDEP.AsString := qryDepartamento.FieldByName('DEP_DESCRI').AsString;
        cdsDepartamento.Post;

        qryDepartamento.Next;
      End;

      cdsDepartamento.First;
    Finally
      pHabilitaDesabilitaTabDepartamento;
      cdsDepartamento.EnableControls;
    End;
  Finally
    FreeAndNil(qryDepartamento);
  End;
end;

function TfrmCadCashback.fCarregaItensCashback(pgbProgresso: TcxProgressBar): Boolean;
var
  qryItens: TUniQuery;
begin
  Result := True;

  If fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) Then
    Exit;

  qryItens := fCriaQuery;

  Try
    qryItens.Close;
    qryItens.SQL.Clear;
    qryItens.SQL.Text := 'SELECT '
                       + '       I.* '
                       + '     , C.ITE_DESITE '
                       + '     , F.FOR_NOMFOR '
                       + '     , M.MAR_DESMAR '
                       + '  FROM ITECSH I '
                       + ' INNER JOIN CADITE C ON C.ITE_CODITE = I.CSH_CODITE '
                       + '  LEFT JOIN CADMAR M ON M.MAR_CODMAR = I.CSH_CODMAR '
                       + '  LEFT JOIN CADFOR F ON F.FOR_CODFOR = I.CSH_CODFOR '
                       + ' WHERE CSH_SEQCSH = :SEQCSH ';
    qryItens.ParamByName('SEQCSH').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryItens.Open;

    cdsItens.EmptyDataSet;

    If qryItens.IsEmpty Then
      Exit;

    cdsItens.DisableControls;
    pgbProgresso.Properties.Max := qryItens.RecordCount;

    Try
      While Not qryItens.Eof Do
      Begin
        pInfoStatusCarregamento('Carregando itens: ' + IntToStr(qryItens.RecNo) + ' de ' + IntToStr(qryItens.RecordCount), pgbProgresso);
        pStepStatusCarregamento(pgbProgresso);

        cdsItens.Append;
        cdsItensCODITE.AsString := qryItens.FieldByName('CSH_CODITE').AsString;
        cdsItensDESITE.AsString := qryItens.FieldByName('ITE_DESITE').AsString;
        cdsItensUNIDAD.AsString := qryItens.FieldByName('CSH_UNIDAD').AsString;
        cdsItensCODMAR.AsString := qryItens.FieldByName('CSH_CODMAR').AsString;
        cdsItensMARCA_.AsString := qryItens.FieldByName('MAR_DESMAR').AsString;
        cdsItensREFERE.AsString := qryItens.FieldByName('CSH_REFERE').AsString;
        cdsItensCODFOR.AsString := qryItens.FieldByName('CSH_CODFOR').AsString;
        cdsItensNOMFOR.AsString := qryItens.FieldByName('CSH_CODFOR').AsString + '-' +
                                   qryItens.FieldByName('FOR_NOMFOR').AsString;
        cdsItens.Post;

        qryItens.Next;
      End;

      cdsItens.First;
    Finally
      pHabilitaDesabilitaTabItensCashback;
      cdsItens.EnableControls;
    End;
  Finally
    FreeAndNil(qryItens);
  End;
end;

function TfrmCadCashback.fCarregaItensUtilizacaoCashback(pgbProgresso: TcxProgressBar): Boolean;
var
  qryItens: TUniQuery;
begin
  Result := True;

  If fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) Then
    Exit;

  qryItens := fCriaQuery;

  Try
    qryItens.Close;
    qryItens.SQL.Clear;
    qryItens.SQL.Text := 'SELECT '
                       + '       I.* '
                       + '     , C.ITE_DESITE '
                       + '     , F.FOR_NOMFOR '
                       + '     , M.MAR_DESMAR '
                       + '  FROM ITUCSH I '
                       + ' INNER JOIN CADITE C ON C.ITE_CODITE = I.CSH_CODITE '
                       + '  LEFT JOIN CADMAR M ON M.MAR_CODMAR = I.CSH_CODMAR '
                       + '  LEFT JOIN CADFOR F ON F.FOR_CODFOR = I.CSH_CODFOR '
                       + ' WHERE CSH_SEQCSH = :SEQCSH ';
    qryItens.ParamByName('SEQCSH').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryItens.Open;

    cdsItensUtilizacao.EmptyDataSet;

    If qryItens.IsEmpty Then
      Exit;

    cdsItensUtilizacao.DisableControls;
    pgbProgresso.Properties.Max := qryItens.RecordCount;

    Try
      While Not qryItens.Eof Do
      Begin
        pInfoStatusCarregamento('Carregando itens utilização: ' + IntToStr(qryItens.RecNo) + ' de ' + IntToStr(qryItens.RecordCount), pgbProgresso);
        pStepStatusCarregamento(pgbProgresso);

        cdsItensUtilizacao.Append;
        cdsItensUtilizacaoCODITE.AsString := qryItens.FieldByName('CSH_CODITE').AsString;
        cdsItensUtilizacaoDESITE.AsString := qryItens.FieldByName('ITE_DESITE').AsString;
        cdsItensUtilizacaoUNIDAD.AsString := qryItens.FieldByName('CSH_UNIDAD').AsString;
        cdsItensUtilizacaoCODMAR.AsString := qryItens.FieldByName('CSH_CODMAR').AsString;
        cdsItensUtilizacaoMARCA_.AsString := qryItens.FieldByName('MAR_DESMAR').AsString;
        cdsItensUtilizacaoREFERE.AsString := qryItens.FieldByName('CSH_REFERE').AsString;
        cdsItensUtilizacaoCODFOR.AsString := qryItens.FieldByName('CSH_CODFOR').AsString;
        cdsItensUtilizacaoNOMFOR.AsString := qryItens.FieldByName('CSH_CODFOR').AsString + '-' +
                                             qryItens.FieldByName('FOR_NOMFOR').AsString;
        cdsItensUtilizacao.Post;

        qryItens.Next;
      End;

      cdsItensUtilizacao.First;
    Finally
      pHabilitaDesabilitaTabItensUtilizacaoCashback;
      cdsItensUtilizacao.EnableControls;
    End;
  Finally
    FreeAndNil(qryItens);
  End;
end;

procedure TfrmCadCashback.pCarregarTipoCashback;
begin
  rdbValFix.Checked := qryTabela.FieldByName('CSH_TIPCSH').AsString = 'VF';
  rdbPerDes.Checked := qryTabela.FieldByName('CSH_TIPCSH').AsString = 'PD';
  rdbValCom.Checked := qryTabela.FieldByName('CSH_TIPCSH').AsString = 'VC';
  rdbPerIte.Checked := qryTabela.FieldByName('CSH_TIPCSH').AsString = 'PI';
  rdbValIte.Checked := qryTabela.FieldByName('CSH_TIPCSH').AsString = 'VI';

  If rdbValDve.Visible Then
    rdbValDve.Checked := qryTabela.FieldByName('CSH_TIPCSH').AsString = 'DE'
  Else
    rdbValDve.Checked := False;

  rdbValFixClick(nil);
end;

procedure TfrmCadCashback.pCarregarUtilizacaoCashback;
begin
  rdbDiaExp.Checked := qryTabela.FieldByName('CSH_INIVAL').IsNull;
  rdbDtaVal.Checked := Not qryTabela.FieldByName('CSH_INIVAL').IsNull;
  rdbDiaExpClick(nil);
end;

function TfrmCadCashback.fRetornaTipoCashback: String;
begin
  Result := EmptyStr;

  If rdbValFix.Checked Then
    Result := 'VF'
  Else If rdbPerDes.Checked Then
    Result := 'PD'
  Else If rdbValCom.Checked Then
    Result := 'VC'
  Else If rdbPerIte.Checked Then
    Result := 'PI'
  Else If rdbValIte.Checked Then
    Result := 'VI'
  Else If rdbValDve.Checked Then
    Result := 'DE';
end;

procedure TfrmCadCashback.pExcluiRegistroCanalAcesso;
begin
  If Not (qryTabela.State In [dsEdit, dsInsert]) Then
    Exit;

  If cdsCanalAcesso.Active Then
  Begin
    If cdsCanalAcesso.RecordCount > 0 Then
    Begin
      If cdsCanalAcesso.RecNo > 0 Then
      Begin
        If fMensagem('ATENÇÃO', 'Deseja excluir o Canal de Acesso?', ['&Sim','&Não'], 2) = 1 Then
        Begin
          cdsCanalAcesso.Delete;
        End;
      End;
    End;
  End;
end;

procedure TfrmCadCashback.pExcluiRegistroClientes;
begin
  If Not (qryTabela.State In [dsEdit, dsInsert]) Then
    Exit;

  If cdsClientes.Active Then
  Begin
    If cdsClientes.RecordCount > 0 Then
    Begin
      If cdsClientes.RecNo > 0 Then
      Begin
        If fMensagem('ATENÇÃO', 'Deseja excluir o cliente?', ['&Sim','&Não'], 2) = 1 Then
        Begin
          cdsClientes.Delete;
        End;
      End;
    End;
  End;
end;

procedure TfrmCadCashback.pExcluiRegistroCondicaoPagamento;
begin
  If Not (qryTabela.State In [dsEdit, dsInsert]) Then
    Exit;

  If cdsCondicaoPagamento.Active Then
  Begin
    If cdsCondicaoPagamento.RecordCount > 0 Then
    Begin
      If cdsCondicaoPagamento.RecNo > 0 Then
      Begin
        If fMensagem('ATENÇÃO', 'Deseja excluir a condição?', ['&Sim','&Não'], 2) = 1 Then
        Begin
          cdsCondicaoPagamento.Delete;
        End;
      End;
    End;
  End;
end;

procedure TfrmCadCashback.pExcluiRegistroDepartamento;
begin
  If Not (qryTabela.State In [dsEdit, dsInsert]) Then
    Exit;

  If cdsDepartamento.Active Then
  Begin
    If cdsDepartamento.RecordCount > 0 Then
    Begin
      If cdsDepartamento.RecNo > 0 Then
      Begin
        If fMensagem('ATENÇÃO', 'Deseja excluir o Departamento?', ['&Sim','&Não'], 2) = 1 Then
        Begin
          cdsDepartamento.Delete;
        End;
      End;
    End;
  End;
end;

procedure TfrmCadCashback.pExcluiRegistroItens;
begin
  If Not (qryTabela.State In [dsEdit, dsInsert]) Then
    Exit;

  If cdsItens.Active Then
  Begin
    If cdsItens.RecordCount > 0 Then
    Begin
      If cdsItens.RecNo > 0 Then
      Begin
        If fMensagem('ATENÇÃO', 'Deseja excluir o item?', ['&Sim','&Não'], 2) = 1 Then
        Begin
          cdsItens.Delete;
        End;
      End;
    End;
  End;
end;

procedure TfrmCadCashback.pExcluiRegistroItensUtilizacao;
begin
  If Not (qryTabela.State In [dsEdit, dsInsert]) Then
    Exit;

  If cdsItensUtilizacao.Active Then
  Begin
    If cdsItensUtilizacao.RecordCount > 0 Then
    Begin
      If cdsItensUtilizacao.RecNo > 0 Then
      Begin
        If fMensagem('ATENÇÃO', 'Deseja excluir o item?', ['&Sim','&Não'], 2) = 1 Then
        Begin
          cdsItensUtilizacao.Delete;
        End;
      End;
    End;
  End;
end;

procedure TfrmCadCashback.pExecutaCarregamento(
  funcCarregamento: TFunctionFormGravando);
var
  frmAguarde: TfrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := funcCarregamento;
    frmAguarde.ShowModal;
  Finally
    pFreeAndNil(frmAguarde);
  End;
end;

procedure TfrmCadCashback.pHabilitaDesabilitaControles(
  const blnHabilita: Boolean);
begin
  If (Not fEmptyStr(dbeCodigo.Text)) And
     (Not TControleCashback.fExisteCashbackGerado(dbeCodigo.Text)) Then
    Exit;

  dbeCodigo.Enabled             := blnHabilita;
  dbeDescri.Enabled             := blnHabilita;
  dbeIniVig.Enabled             := blnHabilita;
  dbeTipPes.Enabled             := blnHabilita;
  dbeConPag.Enabled             := blnHabilita;
  dbeCnlAce.Enabled             := blnHabilita;
  dbeDepart.Enabled             := blnHabilita;
  gpbGeracao.Enabled            := blnHabilita;
  gpbUtilizacaoCashback.Enabled := blnHabilita;
end;

procedure TfrmCadCashback.pHabilitaDesabilitaTabCanalAcesso;
begin
  tbsCanalAcesso.TabVisible     := (dbeCnlAce.Text = 'D');
  btnIncluirTodosCnlAce.Enabled := (dbeCnlAce.Text = 'D') And (qryTabela.State In [dsEdit, dsInsert]);
  btnExcluirTodosCnlAce.Enabled := (dbeCnlAce.Text = 'D') And (qryTabela.State In [dsEdit, dsInsert]);
  pnlCnlAce.Enabled             := (dbeCnlAce.Text = 'D') And (qryTabela.State In [dsEdit, dsInsert]);
  pReorganizaTabs;
end;

procedure TfrmCadCashback.pHabilitaDesabilitaTabClientesCashback;
begin
  tbsClientesCashback.TabVisible := (dbeTipPes.Text = 'M');
  pReorganizaTabs;
end;

procedure TfrmCadCashback.pHabilitaDesabilitaTabCondicaoPagamento;
begin
  tbsCondicaoPagamento.TabVisible := (dbeConPag.Text = 'D');
  btnIncluirTodasCndPag.Enabled   := (dbeConPag.Text = 'D') And (qryTabela.State In [dsEdit, dsInsert]);
  btnExcluirTodasCndPag.Enabled   := (dbeConPag.Text = 'D') And (qryTabela.State In [dsEdit, dsInsert]);
  pnlCndPag.Enabled               := (dbeConPag.Text = 'D') And (qryTabela.State In [dsEdit, dsInsert]);
  pReorganizaTabs;
end;

procedure TfrmCadCashback.pHabilitaDesabilitaTabDepartamento;
begin
  tbsDepartamento.TabVisible           := (dbeDepart.Text = 'D');
  btnIncluirTodosDepartamentos.Enabled := (dbeDepart.Text = 'D') And (qryTabela.State In [dsEdit, dsInsert]);
  btnExcluirTodosDepartamentos.Enabled := (dbeDepart.Text = 'D') And (qryTabela.State In [dsEdit, dsInsert]);
  pnlDepartamento.Enabled              := (dbeDepart.Text = 'D') And (qryTabela.State In [dsEdit, dsInsert]);
  pReorganizaTabs;
end;

procedure TfrmCadCashback.pHabilitaDesabilitaTabItensCashback;
begin
  tbsItensCashback.TabVisible := ((rdbPerIte.Checked) Or (rdbValIte.Checked));
  pReorganizaTabs;
end;

procedure TfrmCadCashback.pHabilitaDesabilitaTabItensUtilizacaoCashback;
begin
  tbsItensUtilizacaoCashback.TabVisible := (dbeUtiIte.Text = 'S');
  pReorganizaTabs;
end;

procedure TfrmCadCashback.pHabilitarTipoCashback;
begin
  rdbValFix.Enabled := qryTabela.State In [dsEdit, dsInsert];
  rdbPerDes.Enabled := qryTabela.State In [dsEdit, dsInsert];
  rdbValCom.Enabled := qryTabela.State In [dsEdit, dsInsert];
  rdbPerIte.Enabled := qryTabela.State In [dsEdit, dsInsert];
  rdbValIte.Enabled := qryTabela.State In [dsEdit, dsInsert];
  rdbValDve.Enabled := qryTabela.State In [dsEdit, dsInsert];
  grdItens.Enabled  := qryTabela.State In [dsEdit, dsInsert];
end;

procedure TfrmCadCashback.pHabilitarUtilizacaoCashback;
begin
  rdbDiaExp.Enabled := qryTabela.State In [dsEdit, dsInsert];
  rdbDtaVal.Enabled := qryTabela.State In [dsEdit, dsInsert];
end;

procedure TfrmCadCashback.pInfoStatusCarregamento(strInformacao: String;
  pgbProgresso: TcxProgressBar);
begin
  If Assigned(pgbProgresso) And (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strInformacao;
    Application.ProcessMessages;
  End;
end;

procedure TfrmCadCashback.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CSH_CODIGO');
  stlCampos.Add('CSH_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CSH_DESCRI');
  stlCamInd.Add('CSH_CODIGO');

  stlDesInd.Add('Nome');
  stlDesInd.Add('Código');

end;

procedure TfrmCadCashback.pLimpaFiltroItens;
begin
  edtCodIteItens.Clear;
  edtDesIteItens.Clear;
  mskLinhaGrupoItens.Clear;
  edtDesGrupoItens.Clear;
  edtFornecedorItens.Clear;
  edtDesFornecedorItens.Clear;
  edtDepartamentoItens.Clear;
  edtDesDepartamentoItens.Clear;
  edtDescriIniItens.Clear;
  edtDescriFinItens.Clear;
  edtRefereItens.Clear;
  edtImpLisItens.Clear;
  edtUnidadeItens.Clear;
  edtDesUnidadeItens.Clear;
  edtProAtiItens.Clear;
end;

procedure TfrmCadCashback.pLimpaFiltroItensUtilizacao;
begin
  edtCodIteItensUtilizacao.Clear;
  edtDesIteItensUtilizacao.Clear;
  mskLinhaGrupoItensUtilizacao.Clear;
  edtDesGrupoItensUtilizacao.Clear;
  edtFornecedorItensUtilizacao.Clear;
  edtDesFornecedorItensUtilizacao.Clear;
  edtDepartamentoItensUtilizacao.Clear;
  edtDesDepartamentoItensUtilizacao.Clear;
  edtDescriIniItensUtilizacao.Clear;
  edtDescriFinItensUtilizacao.Clear;
  edtRefereItensUtilizacao.Clear;
  edtImpLisItensUtilizacao.Clear;
  edtUnidadeItensUtilizacao.Clear;
  edtDesUnidadeItensUtilizacao.Clear;
  edtProAtiItensUtilizacao.Clear;
end;

procedure TfrmCadCashback.pLimpaFiltroCanalAcesso;
begin
  edtFilCodCac.Clear;
  edtFilNomCac.Clear;
end;

procedure TfrmCadCashback.pLimpaFiltroClientes;
begin
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtCodAti.Clear;
  edtDesAti.Clear;
  edtCodCid.Clear;
  edtNomCid.Clear;
  edtCodEst.Clear;
  edtNomEst.Clear;
  edtCodReg.Clear;
  edtDesReg.Clear;
  edtCodSub.Clear;
  edtDesSub.Clear;
  edtCodRed.Clear;
  edtDesRed.Clear;
  edtCodCac.Clear;
  edtDesCac.Clear;
  edtCodVen.Clear;
  edtNomVen.Clear;
  mskCgcCpf.Clear;
  edtCgcCpf.Text := '1';
  edtCgcCpfExit(edtCgcCpf);
end;

procedure TfrmCadCashback.pLimpaFiltroCondicaoPagamento;
begin
  edtCodCnd.Clear;
  edtDesCnd.Clear;
end;

procedure TfrmCadCashback.pLimpaFiltroDepartamento;
begin
  edtCodDep.Clear;
  edtDesDep.Clear;
end;

procedure TfrmCadCashback.pReorganizaTabs;
var
  intPosicao,
  intNumTab : Integer;
  strTexto  : String;
begin
  intNumTab := 0;
  For intPosicao := 0 To Pred(pgcDados.PageCount) Do
  Begin
    If pgcDados.Pages[intPosicao].TabVisible Then
    Begin
      Inc(intNumTab);
      strTexto := pgcDados.Pages[intPosicao].Caption;

      If Copy(strTexto, 1, 1) = '&' Then
        strTexto := Copy(strTexto, 6, strTexto.Length);

      pgcDados.Pages[intPosicao].Caption := '&'+intNumTab.ToString + ' - ' + strTexto;
    End;
  End;
end;

procedure TfrmCadCashback.pRetornaClientes;
var
  qryClientes: TUniQuery;
  cdsClienteBKP: TUniClientDataSet;
begin
  qryClientes := fCriaQuery;
  cdsClienteBKP := TUniClientDataSet.Create(nil);

  Try
    pCloneDataSet(cdsClienteBKP, cdsClientes);

    qryClientes.Close;
    qryClientes.SQL.Clear;
    qryClientes.SQL.Add('SELECT C.CLI_CODCLI, C.CLI_NOMCLI');
    qryClientes.SQL.Add('FROM CADCLI C');
    qryClientes.SQL.Add('LEFT JOIN CADCID I ON I.CID_CODCID = C.CLI_CODCID');
    qryClientes.SQL.Add('WHERE TRUE');

    pWhereClientes(qryClientes);

    qryClientes.Open;

    SetLength(arrClientes, 0);
    SetLength(arrAtividades, 0);
    SetLength(arrCidades, 0);
    SetLength(arrEstados, 0);
    SetLength(arrRegioes, 0);
    SetLength(arrSubRegioes, 0);
    SetLength(arrRedeLojas, 0);
    SetLength(arrCanalAcessos, 0);
    SetLength(arrVendedores, 0);

    If qryClientes.IsEmpty Then
    Begin
      fMensagem('AVISO', 'Nenhum registro encontrado nos filtros informado.', ['&OK']);
    End
    Else
    Begin
      cdsClientes.DisableControls;

      Try
        If cdsClientes.RecordCount > 0 Then
        Begin
          If fMensagem('ATENÇÃO', 'Deseja refazer a lista de clientes ou acrescentar?', ['&Refazer','&Acrescentar'],2) = 1 Then
          Begin
            cdsClientes.EmptyDataSet;
          End;
        End;

        While Not qryClientes.Eof Do
        Begin
          If Not cdsClienteBKP.Locate('CODCLI', qryClientes.FieldByName('CLI_CODCLI').AsString, []) Then
          Begin
            cdsClientes.Append;
            cdsClientesCODCLI.AsString := qryClientes.FieldByName('CLI_CODCLI').AsString;
            cdsClientesNOMCLI.AsString := qryClientes.FieldByName('CLI_NOMCLI').AsString;
            cdsClientes.Post;
          End;

          qryClientes.Next;
        End;

        cdsClientes.First;
        pLimpaFiltroClientes;
      Finally
        cdsClientes.EnableControls;
      End;
    End;
  Finally
    FreeAndNil(qryClientes);
    FreeAndNil(cdsClienteBKP);
  End;
end;

procedure TfrmCadCashback.pRetornaItens;
var
  qryItens: TUniQuery;
  cdsItemBKP: TUniClientDataSet;
begin
  qryItens := fCriaQuery;
  cdsItemBKP := TUniClientDataSet.Create(nil);

  Try
    pCloneDataSet(cdsItemBKP, cdsItens);

    qryItens.Close;
    qryItens.SQL.Clear;
    qryItens.SQL.Add('SELECT I.ITE_CODITE, I.ITE_DESITE, I.ITE_CODUNI, I.ITE_CODMAR,');
    qryItens.SQL.Add('       I.ITE_REFERE, I.ITE_CODFOR, F.FOR_NOMFOR, M.MAR_DESMAR');
    qryItens.SQL.Add('FROM CADITE I');
    qryItens.SQL.Add('LEFT JOIN CADFOR F');
    qryItens.SQL.Add('ON(I.ITE_CODFOR = F.FOR_CODFOR)');
    qryItens.SQL.Add('LEFT JOIN CADMAR M');
    qryItens.SQL.Add('ON(I.ITE_CODMAR = M.MAR_CODMAR)');
    qryItens.SQL.Add('WHERE TRUE');

    pWhereItens(qryItens);

    qryItens.Open;

    SetLength(arrItens, 0);
    SetLength(arrGrupos, 0);
    SetLength(arrMarca, 0);
    SetLength(arrFornecedores, 0);
    SetLength(arrDepartamentos, 0);
    SetLength(arrUnidades, 0);

    If qryItens.IsEmpty Then
    Begin
      fMensagem('AVISO', 'Nenhum registro encontrado nos filtros informado.', ['&OK']);
    End
    Else
    Begin
      cdsItens.DisableControls;

      Try
        If cdsItens.RecordCount > 0 Then
        Begin
          If fMensagem('ATENÇÃO', 'Deseja refazer a lista de itens ou acrescentar?', ['&Refazer','&Acrescentar'],2) = 1 Then
          Begin
            cdsItens.EmptyDataSet;
          End;
        End;

        While Not qryItens.Eof Do
        Begin
          If Not cdsItemBKP.Locate('CODITE', qryItens.FieldByName('ITE_CODITE').AsString, []) Then
          Begin
            cdsItens.Append;
            cdsItensCODITE.AsString := qryItens.FieldByName('ITE_CODITE').AsString;
            cdsItensDESITE.AsString := qryItens.FieldByName('ITE_DESITE').AsString;
            cdsItensUNIDAD.AsString := qryItens.FieldByName('ITE_CODUNI').AsString;
            cdsItensCODMAR.AsString := qryItens.FieldByName('ITE_CODMAR').AsString;
            cdsItensMARCA_.AsString := qryItens.FieldByName('MAR_DESMAR').AsString;
            cdsItensREFERE.AsString := qryItens.FieldByName('ITE_REFERE').AsString;
            cdsItensCODFOR.AsString := qryItens.FieldByName('ITE_CODFOR').AsString;
            cdsItensNOMFOR.AsString := qryItens.FieldByName('ITE_CODFOR').AsString + '-' +qryItens.FieldByName('FOR_NOMFOR').AsString;
            cdsItens.Post;
          End;

          qryItens.Next;
        End;

        cdsItens.First;
        pLimpaFiltroItens;
      Finally
        cdsItens.EnableControls;
      End;
    End;
  Finally
    FreeAndNil(qryItens);
    FreeAndNil(cdsItemBKP);
  End;
end;

procedure TfrmCadCashback.pRetornaItensUtilizacao;
var
  qryItens: TUniQuery;
  cdsItemBKP: TUniClientDataSet;
begin
  qryItens := fCriaQuery;
  cdsItemBKP := TUniClientDataSet.Create(nil);

  Try
    pCloneDataSet(cdsItemBKP, cdsItensUtilizacao);

    qryItens.Close;
    qryItens.SQL.Clear;
    qryItens.SQL.Add('SELECT I.ITE_CODITE, I.ITE_DESITE, I.ITE_CODUNI, I.ITE_CODMAR,');
    qryItens.SQL.Add('       I.ITE_REFERE, I.ITE_CODFOR, F.FOR_NOMFOR, M.MAR_DESMAR');
    qryItens.SQL.Add('FROM CADITE I');
    qryItens.SQL.Add('LEFT JOIN CADFOR F');
    qryItens.SQL.Add('ON(I.ITE_CODFOR = F.FOR_CODFOR)');
    qryItens.SQL.Add('LEFT JOIN CADMAR M');
    qryItens.SQL.Add('ON(I.ITE_CODMAR = M.MAR_CODMAR)');
    qryItens.SQL.Add('WHERE TRUE');

    pWhereItensUtilizacao(qryItens);

    qryItens.Open;

    SetLength(arrItens, 0);
    SetLength(arrGrupos, 0);
    SetLength(arrMarca, 0);
    SetLength(arrFornecedores, 0);
    SetLength(arrDepartamentos, 0);
    SetLength(arrUnidades, 0);

    If qryItens.IsEmpty Then
    Begin
      fMensagem('AVISO', 'Nenhum registro encontrado nos filtros informado.', ['&OK']);
    End
    Else
    Begin
      cdsItensUtilizacao.DisableControls;

      Try
        If cdsItensUtilizacao.RecordCount > 0 Then
        Begin
          If fMensagem('ATENÇÃO', 'Deseja refazer a lista de itens ou acrescentar?', ['&Refazer','&Acrescentar'],2) = 1 Then
          Begin
            cdsItensUtilizacao.EmptyDataSet;
          End;
        End;

        While Not qryItens.Eof Do
        Begin
          If Not cdsItemBKP.Locate('CODITE', qryItens.FieldByName('ITE_CODITE').AsString, []) Then
          Begin
            cdsItensUtilizacao.Append;
            cdsItensUtilizacaoCODITE.AsString := qryItens.FieldByName('ITE_CODITE').AsString;
            cdsItensUtilizacaoDESITE.AsString := qryItens.FieldByName('ITE_DESITE').AsString;
            cdsItensUtilizacaoUNIDAD.AsString := qryItens.FieldByName('ITE_CODUNI').AsString;
            cdsItensUtilizacaoCODMAR.AsString := qryItens.FieldByName('ITE_CODMAR').AsString;
            cdsItensUtilizacaoMARCA_.AsString := qryItens.FieldByName('MAR_DESMAR').AsString;
            cdsItensUtilizacaoREFERE.AsString := qryItens.FieldByName('ITE_REFERE').AsString;
            cdsItensUtilizacaoCODFOR.AsString := qryItens.FieldByName('ITE_CODFOR').AsString;
            cdsItensUtilizacaoNOMFOR.AsString := qryItens.FieldByName('ITE_CODFOR').AsString + '-' +qryItens.FieldByName('FOR_NOMFOR').AsString;
            cdsItensUtilizacao.Post;
          End;

          qryItens.Next;
        End;

        cdsItensUtilizacao.First;
        pLimpaFiltroItensUtilizacao;
      Finally
        cdsItensUtilizacao.EnableControls;
      End;
    End;
  Finally
    FreeAndNil(qryItens);
    FreeAndNil(cdsItemBKP);
  End;
end;

procedure TfrmCadCashback.pStepStatusCarregamento(pgbProgresso: TcxProgressBar);
begin
  If Assigned(pgbProgresso) Then
  Begin
    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;
end;

procedure TfrmCadCashback.pVerificaRadioGroupHabilitado;
begin
  If Not dbeValFix.Enabled Then
    dbeValFix.Field.AsFloat := 0;

  If Not dbePerDes.Enabled Then
    dbePerDes.Field.AsFloat := 0;

  If Not dbeValCom.Enabled Then
    dbeValCom.Field.AsFloat := 0;

  If Not dbeValAcu.Enabled Then
    dbeValAcu.Field.AsFloat := 0;

  If Not dbePerIte.Enabled Then
    dbePerIte.Field.AsFloat := 0;

  If Not dbeValIte.Enabled Then
    dbeValIte.Field.AsFloat := 0;

  If Not dbeValDve.Enabled Then
    dbeValDve.Field.AsFloat := 0;
end;

procedure TfrmCadCashback.pWhereClientes(const qryClientes: TUniQuery);
begin
  pAdicionarFiltros(qryClientes, arrClientes,     'C.CLI_CODCLI');
  pAdicionarFiltros(qryClientes, arrAtividades,   'C.CLI_CODATI');
  pAdicionarFiltros(qryClientes, arrCidades,      'C.CLI_CODCID');
  pAdicionarFiltros(qryClientes, arrEstados,      'I.CID_ESTADO');
  pAdicionarFiltros(qryClientes, arrRegioes,      'C.CLI_CODREG');
  pAdicionarFiltros(qryClientes, arrSubRegioes,   'C.CLI_CODSUB');
  pAdicionarFiltros(qryClientes, arrRedeLojas,    'C.CLI_CODRED');
  pAdicionarFiltros(qryClientes, arrCanalAcessos, 'C.CLI_CODCAC');
  pAdicionarFiltros(qryClientes, arrVendedores,   'C.CLI_CODVEN');
  pAdicionarFiltros(qryClientes, mskCgcCpf.Text,  'C.CLI_C_G_C_');
end;

procedure TfrmCadCashback.pWhereItens(const qryItens: TUniQuery);
begin
  pAdicionarFiltros(qryItens, arrItens,            'I.ITE_CODITE');
  pAdicionarFiltros(qryItens, arrGrupos,           'I.ITE_CODGRU');
  pAdicionarFiltros(qryItens, arrMarca,            'I.ITE_CODMAR');
  pAdicionarFiltros(qryItens, arrFornecedores,     'I.ITE_CODFOR');
  pAdicionarFiltros(qryItens, arrDepartamentos,    'I.ITE_CODDEP');
  pAdicionarFiltros(qryItens, arrUnidades,         'I.ITE_CODUNI');
  pAdicionarFiltros(qryItens, edtRefereItens.Text, 'I.ITE_REFERE');
  pAdicionarFiltros(qryItens, edtProAtiItens.Text, 'I.ITE_ITEATI');


  If Not fEmptyStr(edtImpLisItens.Text) Then
  Begin
    pAdicionarFiltros(qryItens, 'EXISTS(SELECT G.ITE_CODITE FROM ITEGER G '
                              + '        WHERE G.ITE_IMPLIS = "'+edtImpLisItens.Text+'" '
                              + '          AND G.ITE_CODEMP = "'+VS_strCodEmp+'" '
                              + '          AND I.ITE_CODITE = G.ITE_CODITE) ');
  End;

  If (Not fEmptyStr(edtDescriIniItens.Text)) And
     (fEmptyStr(edtDescriFinItens.Text)) Then
    pAdicionarFiltros(qryItens, 'I.ITE_DESITE LIKE "'+edtDescriIniItens.Text+'%"')
  Else
  If (Not fEmptyStr(edtDescriFinItens.Text)) And
     (fEmptyStr(edtDescriIniItens.Text)) Then
    pAdicionarFiltros(qryItens, 'I.ITE_DESITE LIKE "%'+edtDescriIniItens.Text+'"')
  Else
  If (Not fEmptyStr(edtDescriIniItens.Text)) And
     (Not fEmptyStr(edtDescriFinItens.Text)) Then
    pAdicionarFiltros(qryItens, 'LEFT(I.ITE_DESITE, LENGTH("'+edtDescriIniItens.Text+'")) BETWEEN "'+edtDescriIniItens.Text+'" AND "'+edtDescriFinItens.Text+'"');
end;

procedure TfrmCadCashback.pWhereItensUtilizacao(const qryItens: TUniQuery);
begin
  pAdicionarFiltros(qryItens, arrItens,            'I.ITE_CODITE');
  pAdicionarFiltros(qryItens, arrGrupos,           'I.ITE_CODGRU');
  pAdicionarFiltros(qryItens, arrMarca,            'I.ITE_CODMAR');
  pAdicionarFiltros(qryItens, arrFornecedores,     'I.ITE_CODFOR');
  pAdicionarFiltros(qryItens, arrDepartamentos,    'I.ITE_CODDEP');
  pAdicionarFiltros(qryItens, arrUnidades,         'I.ITE_CODUNI');
  pAdicionarFiltros(qryItens, edtRefereItensUtilizacao.Text, 'I.ITE_REFERE');
  pAdicionarFiltros(qryItens, edtProAtiItensUtilizacao.Text, 'I.ITE_ITEATI');

  If Not fEmptyStr(edtImpLisItensUtilizacao.Text) Then
  Begin
    pAdicionarFiltros(qryItens, 'EXISTS(SELECT G.ITE_CODITE FROM ITEGER G '
                              + '        WHERE G.ITE_IMPLIS = "'+edtImpLisItensUtilizacao.Text+'" '
                              + '          AND G.ITE_CODEMP = "'+VS_strCodEmp+'" '
                              + '          AND I.ITE_CODITE = G.ITE_CODITE) ');
  End;

  If (Not fEmptyStr(edtDescriIniItensUtilizacao.Text)) And
     (fEmptyStr(edtDescriFinItensUtilizacao.Text)) Then
    pAdicionarFiltros(qryItens, 'I.ITE_DESITE LIKE "'+edtDescriIniItensUtilizacao.Text+'%"')
  Else
  If (Not fEmptyStr(edtDescriFinItensUtilizacao.Text)) And
     (fEmptyStr(edtDescriIniItensUtilizacao.Text)) Then
    pAdicionarFiltros(qryItens, 'I.ITE_DESITE LIKE "%'+edtDescriIniItensUtilizacao.Text+'"')
  Else
  If (Not fEmptyStr(edtDescriIniItensUtilizacao.Text)) And
     (Not fEmptyStr(edtDescriFinItensUtilizacao.Text)) Then
    pAdicionarFiltros(qryItens, 'LEFT(I.ITE_DESITE, LENGTH("'+edtDescriIniItensUtilizacao.Text+'")) BETWEEN "'+edtDescriIniItensUtilizacao.Text+'" AND "'+edtDescriFinItensUtilizacao.Text+'"');
end;

procedure TfrmCadCashback.rdbDiaExpClick(Sender: TObject);
begin
  inherited;
  If Not (qryTabela.State In [dsEdit, dsInsert]) Then
    Exit;

  dbeDiaExp.Enabled := rdbDiaExp.Checked;
  dbeIniVal.Enabled := rdbDtaVal.Checked;
  dbeFinVal.Enabled := rdbDtaVal.Checked;

  If Not dbeDiaExp.Enabled Then
    dbeDiaExp.Field.AsFloat := 0;

  If Not dbeIniVal.Enabled Then
    dbeIniVal.Field.Clear;

  If Not dbeFinVal.Enabled Then
    dbeFinVal.Field.Clear;
end;

procedure TfrmCadCashback.rdbValFixClick(Sender: TObject);
begin
  inherited;
  If Not (qryTabela.State In [dsEdit, dsInsert]) Then
    Exit;

  If rdbValDve.Visible Then
  Begin
    If rdbValDve.Checked Then
    Begin
      qryTabela.FieldByName('CSH_CONPAG').AsString := 'T';
      qryTabela.FieldByName('CSH_CNLACE').AsString := 'T';
      qryTabela.FieldByName('CSH_DEPART').AsString := 'T';
      qryTabela.FieldByName('CSH_GERCSH').AsFloat  := 0;
      qryTabela.FieldByName('CSH_CHSBCH').AsString := 'N';
      qryTabela.FieldByName('CSH_ITEPRO').AsString := 'N';
    End;
  End;

  dbeValFix.Enabled := rdbValFix.Checked;
  dbePerDes.Enabled := rdbPerDes.Checked;
  dbeValCom.Enabled := rdbValCom.Checked;
  dbeValAcu.Enabled := rdbValCom.Checked;
  dbePerIte.Enabled := rdbPerIte.Checked;
  dbeValIte.Enabled := rdbValIte.Checked;
  dbeValDve.Enabled := rdbValDve.Checked;

  dbeConPag.Enabled := Not rdbValDve.Checked;
  dbeCnlAce.Enabled := Not rdbValDve.Checked;
  dbeDepart.Enabled := Not rdbValDve.Checked;
  dbeGerCsh.Enabled := Not rdbValDve.Checked;
  dbeChsBch.Enabled := Not rdbValDve.Checked;
  dbeItePro.Enabled := Not rdbValDve.Checked;

  pHabilitaDesabilitaTabItensCashback;
  pVerificaRadioGroupHabilitado;
end;

end.
