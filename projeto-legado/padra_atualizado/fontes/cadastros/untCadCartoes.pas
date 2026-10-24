unit untCadCartoes;

interface

uses
  Classes, Controls, Forms, StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls,
  Uni, DBCtrls, DBEditFocus, Menus, AppEvnts, EditFocus, Windows, DB,
  QColorLabel, BitBtnLockedIncrem, Mask, frxClass, frxExportCSVTestabilidade,
  dxScreenTip, cxClasses, dxCustomHint, cxHint, DBComboBoxFocus, untFuncoes,
  untFrameCentroCustoDBEditFocus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGridCitel, cxGrid, UniClientDataSet,
  untFramePlanoDeContasDBEditFocus;

type
  TfrmCadCartoes = class(TfrmPaiCad)
    dtsCadCar: TDataSource;
    HintControler: TcxHintStyleController;
    btnPlaNco: TBitBtnLocked;
    tsBaixaOtimizada: TTabSheet;
    Label1: TLabel;
    lbDesCar: TLabel;
    Label5: TLabel;
    Label61: TLabel;
    lblCndPag: TLabel;
    Label148: TLabel;
    Label7: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    lbl1: TLabel;
    Label9: TLabel;
    lbl2: TLabel;
    lbl3: TColorLabel;
    Label17: TLabel;
    Label6: TLabel;
    ColorLabel1: TColorLabel;
    lblDesPlaCon: TLabel;
    ColorLabel3: TColorLabel;
    Label24: TLabel;
    ColorLabel2: TColorLabel;
    Label22: TLabel;
    dbeCodCar: TDBEditFocus;
    dbeDesCar: TDBEditFocus;
    dbePeriod: TDBEditFocus;
    dbeSugCPg: TDBEditFocus;
    edtCodEmpresa: TDBEditFocus;
    edtDesEmpresa: TEditFocus;
    dbeMaxPar: TDBEditFocus;
    gbDadosTef: TGroupBox;
    dbeCodBan: TDBEditFocus;
    edtNomBan: TEditFocus;
    dbeExcDia: TDBEditFocus;
    dbeTipCar: TDBComboBoxFocus;
    dbeParMin: TDBEditFocus;
    dbeCnpj: TDBEditFocus;
    dbeStatus: TDBEditFocus;
    dbeEntSped: TDBEditFocus;
    dbeConCon: TDBEditFocus;
    btnDesmembr: TBitBtnLocked;
    dbchkDesmembr: TDBCheckBox;
    dbeNumNSU: TDBEditFocus;
    dbeNumCCD: TDBEditFocus;
    dbePlaNco: TDBEditFocus;
    edtDesPlaNco: TEditFocus;
    GroupBox2: TGroupBox;
    Label50: TLabel;
    Label11: TLabel;
    Label23: TLabel;
    dbePorBai: TDBEditFocus;
    edtPorBai: TEditFocus;
    edtPorTax: TEditFocus;
    dbePorTax: TDBEditFocus;
    dbeForTax: TDBEditFocus;
    edtForTax: TEditFocus;
    GroupBox3: TGroupBox;
    Label19: TLabel;
    edtPorBad: TEditFocus;
    dbePorBad: TDBEditFocus;
    grpCancelamentos: TGroupBox;
    grpCtaAnt: TGroupBox;
    fraCentroCustoC: TfraCentroCustoDBEditFocus;
    fraCentroCustoTX: TfraCentroCustoDBEditFocus;
    fraCentroCustoD: TfraCentroCustoDBEditFocus;
    gbTxAdm: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    ColorLabel4: TColorLabel;
    lbTaxMin: TLabel;
    dbePerDes: TDBEditFocus;
    dbeTipTax: TDBEditFocus;
    dbeTaxMin: TDBEditFocus;
    tabBaixaOtimizadaPorEmpresa: TTabSheet;
    pnlTopoOtimizadaPorEmpresa: TPanel;
    pnlAcoesOtimizada: TPanel;
    btnIncluirDadosEmpresa: TBitBtnLocked;
    btnAlterarDadosEmpresa: TBitBtnLocked;
    btnExcluirDadosEmpresa: TBitBtnLocked;
    pnlDadosOtimizadaPorEmpresa: TPanel;
    grdDadosOtimizada: TcxGridCitel;
    grdDadosOtimizadaDados: TcxGridDBTableViewCitel;
    grdDadosOtimizadaDadosCON_CODEMP: TcxGridDBColumn;
    grdDadosOtimizadaDadosCON_PORCRE: TcxGridDBColumn;
    grdDadosOtimizadaDadosCON_CTACRE: TcxGridDBColumn;
    grdDadosOtimizadaDadosCON_EVECRE: TcxGridDBColumn;
    grdDadosOtimizadaDadosCON_PORTAX: TcxGridDBColumn;
    grdDadosOtimizadaDadosCON_FORTAX: TcxGridDBColumn;
    grdDadosOtimizadaDadosCON_CTATAX: TcxGridDBColumn;
    grdDadosOtimizadaDadosCON_EVETAX: TcxGridDBColumn;
    grdDadosOtimizadaDadosCON_PORDEB: TcxGridDBColumn;
    grdDadosOtimizadaDadosCON_CTADEB: TcxGridDBColumn;
    grdDadosOtimizadaDadosCON_EVEDEB: TcxGridDBColumn;
    grdDadosOtimizadaDadosCON_CTAAJU: TcxGridDBColumn;
    grdDadosOtimizadaDadosCON_CTAANT: TcxGridDBColumn;
    grdDadosOtimizadaNivel: TcxGridLevel;
    dtsConPor: TDataSource;
    btnCopiarDadosEmpresa: TBitBtnLocked;
    lblCodRed: TLabel;
    dbeCodRed: TDBEditFocus;
    edtDesCredenciadora: TEditFocus;
    gbTefTrocaArquivo: TGroupBox;
    Label8: TLabel;
    dbeNomRed: TDBEditFocus;
    Label10: TLabel;
    dbeTipTra: TDBEditFocus;
    Label21: TLabel;
    dbeNomBan: TDBEditFocus;
    gbTefViaDLL: TGroupBox;
    DBETFTOPE: TDBEditFocus;
    lbCodOperadora: TLabel;
    DBETFTRED: TDBEditFocus;
    lbCodBandeira: TLabel;

    fraPlanoDeContas: TfraPlanoDeContasDBEditFocus;
    fraPlanoDeContasDaBaixa: TfraPlanoDeContasDBEditFocus;
    fraPlanoDeContasDebito: TfraPlanoDeContasDBEditFocus;
    fraPlanoDeContasAnt: TfraPlanoDeContasDBEditFocus;
    fraPlanoDeContasCanc: TfraPlanoDeContasDBEditFocus;

    grpFretes: TGroupBox;
    lblMarketPlace: TLabel;
    ColorLabel5: TColorLabel;
    dbeMarketPlace: TDBEditFocus;
    grdDadosOtimizadaDadosCON_CTAFRE: TcxGridDBColumn;
    fraPlanoDeContasFrete: TfraPlanoDeContasDBEditFocus;
    BtnHeranca: TBitBtnLocked;
    dbeCardSe: TDBEditFocus;
    lbCardSe: TLabel;
    lblFornecedorFiscal: TLabel;
    dbeCodigoFornecedorFiscal: TDBEditFocus;
    edtNomeFornecedorFiscal: TEditFocus;
    Label12: TLabel;
    Label18: TLabel;
    DBETFRED2: TDBEditFocus;
    DBETFBAN2: TDBEditFocus;
    grpExportacaoEquals: TGroupBox;
    lblAdquirinteEquals: TLabel;
    lblMeiosCapturaEquals: TLabel;
    cmbAdquirinteEquals: TDBLookupComboBox;
    cmbMeiosCapturaEquals: TDBLookupComboBox;
    lbTipDeb: TLabel;
    dbeTipDeb: TDBComboBoxFocus;
    grpCupons: TGroupBox;
    grdDadosOtimizadaDadosCON_CTACUP: TcxGridDBColumn;
    fraPlanoDeContasCupons: TfraPlanoDeContasDBEditFocus;
    gpbArredondamento: TGroupBox;
    chkPriParcela: TDBCheckBox;
    chkUltParcela: TDBCheckBox;
    gbLinkPagamentoBandeira: TGroupBox;
    Label20: TLabel;
    dbeCieban: TDBComboBoxFocus;
    BtnAlteracaoGlobal: TBitBtnLocked;
    gbAdquirente: TGroupBox;
    lbAdq: TLabel;
    gpbTipoTransacao: TGroupBox;
    chkTipoPos: TDBCheckBox;
    chkTipoTef: TDBCheckBox;
    dbeCodAdq: TDBEditFocus;
    edtNomAdq: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbePorBaiKeyPress(Sender: TObject; var Key: Char);
    procedure dbePorTaxKeyPress(Sender: TObject; var Key: Char);
    procedure dbeForTaxKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbeCodBanKeyPress(Sender: TObject; var Key: Char);
    function dbeCodBanChamaCadastro(Key: Word): String;
    procedure dbeCnpjKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure dbePorBadKeyPress(Sender: TObject; var Key: Char);
    procedure btnDesmembrClick(Sender: TObject);
    procedure dbchkDesmembrClick(Sender: TObject);
    procedure dtsCadCarStateChange(Sender: TObject);
    procedure dbeNomRedEnter(Sender: TObject);
    procedure dbeNomRedExit(Sender: TObject);
    procedure dbeNomBanEnter(Sender: TObject);
    procedure dbeTipTraEnter(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dtsCadCarDataChange(Sender: TObject; Field: TField);
    procedure dbePlaNcoKeyPress(Sender: TObject; var Key: Char);
    procedure btnPlaNcoClick(Sender: TObject);
    procedure fraCentroCustoCdbeCodEveExit(Sender: TObject);
    procedure fraCentroCustoTXdbeCodEveExit(Sender: TObject);
    procedure fraCentroCustoDdbeCodEveExit(Sender: TObject);
    function dbePorBaiChamaCadastro(Key: Word): string;
    function dbeCtaCarChamaCadastro(Key: Word): string;
    function dbePorTaxChamaCadastro(Key: Word): string;
    function dbeForTaxChamaCadastro(Key: Word): string;
    function dbeCtaTaxChamaCadastro(Key: Word): string;
    function dbePorBadChamaCadastro(Key: Word): string;
    function dbeCtaBadChamaCadastro(Key: Word): string;
    function dbeCtaAjuChamaCadastro(Key: Word): string;
    function dbeCtaAntChamaCadastro(Key: Word): string;
    procedure btnIncluirDadosEmpresaClick(Sender: TObject);
    procedure btnAlterarDadosEmpresaClick(Sender: TObject);
    procedure btnExcluirDadosEmpresaClick(Sender: TObject);
    procedure btnCopiarDadosEmpresaClick(Sender: TObject);
    procedure dbeCodRedKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasdbeCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasDaBaixadbeCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasDebitodbeCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasCancdbeCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasAntdbeCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    function fraPlanoDeContasdbeCodCtaChamaCadastro(Key: Word): string;
    function fraPlanoDeContasDaBaixadbeCodCtaChamaCadastro(Key: Word): string;
    function fraPlanoDeContasAntdbeCodCtaChamaCadastro(Key: Word): string;
    function fraPlanoDeContasCancdbeCodCtaChamaCadastro(Key: Word): string;
    procedure dbeCtaFreteKeyPress(Sender: TObject; var Key: Char);
    procedure pgcDadosChange(Sender: TObject);
    procedure fraPlanoDeContasFretedbeCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure BtnHerancaClick(Sender: TObject);
    procedure dbeCardSeKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCardSeEnter(Sender: TObject);
    procedure dbeCardSeExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbeCodigoFornecedorFiscalKeyPress(Sender: TObject; var Key: Char);
    procedure dbeEntSpedChange(Sender: TObject);
    procedure dbeTipTaxExit(Sender: TObject);
    procedure fraPlanoDeContasCuponsdbeCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure chkPriParcelaClick(Sender: TObject);
    procedure chkUltParcelaClick(Sender: TObject);
    procedure BtnAlteracaoGlobalClick(Sender: TObject);
    function dbeCodAdqChamaCadastro(Key: Word): string;
    procedure dbeCodAdqKeyPress(Sender: TObject; var Key: Char);
    procedure DBETFTOPEEnter(Sender: TObject);
    procedure DBETFTREDEnter(Sender: TObject);
    procedure DBETFBAN2Enter(Sender: TObject);
    procedure DBETFRED2Enter(Sender: TObject);
    procedure chkTipoPosExit(Sender: TObject);
    procedure chkTipoTefExit(Sender: TObject);
    procedure chkTipoTefClick(Sender: TObject);
  private
    { Private declarations }
    FintHeightGbTefViaDLL : Integer ;
    FintHeightGbDadosTef : Integer ;
    FintHeightForm : Integer ;
    FintTopLbCardSe : Integer ;
    FintTopDbeCardSe : Integer ;
    qryCadPor,
    qryCadCta,
    qryCadFor,
    qryCadEve: TUniQuery;
    FcdsNCO : TUniClientDataset;

    intParCar: Integer;
    blnUtiCon : Boolean;

    strUltCnpj: string;
    blnAtualizaCnpj: boolean;

    cdsConPor,
    cdsValidaConPor: TUniClientDataSet;

    cdsHerdaCad,
    cdsConPorHerda : TUniClientDataSet;
    blnCriouHeranca: Boolean;

    stlExclusoes: TStringList;

    blnBaixaOtimizada: Boolean;

    strPlCtaOld,
    strPlCtaBaixOld,
    strPlCtaDebOld,
    strPlCtaCancOld,
    strPlCtaAntOld,
    strPlCtaFreteOld : String;


    FConfiguracaoMERANA: Boolean;

    procedure pCarregaDadosAdicionais;

    procedure dbeCodPorKeyPress(dbeCodPor: TDBEditFocus;
                                edtDesPor: TEditFocus; var Key: Char);

    procedure pCarregaPortador(dbeCodPor: TDBEditFocus;
                               edtDesPor: TEditFocus);

    procedure pCarregaCentroDeCusto(dbeCodCta: TDBEditFocus;
                                    edtDesCta: TEditFocus;
                                    AValidaFornecedor: Boolean);

    procedure pCarregaEvento(dbeCodEve: TDBEditFocus;
                             edtDesEve: TEditFocus);

    procedure pCarregaEmpresa(dbeCodEmp: TDBEditFocus;
                              edtDesEmp: TEditFocus);

    procedure pCarregaFornecedor;
    procedure CarregaFornecedorFiscal;

    procedure pAfterOpen(DataSet: TDataSet);
    procedure pShowHint(edtEdit: TCustomEdit; strTitulo: String);
    procedure pHideHint;
    procedure pCarregaPlanoContabil(const blnBuscaPorChave: Boolean=False);

    procedure pCarregaDadosPorEmpresa;
    procedure pGravaDadosBaixaOtimizadaPorEmpresa;

    function fRetSQLConCar: String;

    procedure pHabiliatarOtimizadaPorEmpresa(blnHabilitar: Boolean);
    procedure pGravaDadosBaixaOtimizadaPorEmpresa_Heranca(strCodCartao : string);

    procedure HabilitarFornecedorFiscal;
    procedure HabilitarEquals;
    procedure HabilitarArredondamento;
    procedure pMostrarTipoDebito(const AblnVisivel: Boolean) ;
    function fMostrarTipoDebito: Boolean ;
    procedure pAjustarLinkCielo ;
    function fCartaoUtilizandoEmMarketplace(ACodigoCartao : string) : boolean;
    procedure pMostraCamposNovaFormaCadCartaoTef ;
    procedure pDesabilitaCamposNovaFormaCadCartaoTef ;
    function fValidaCamposNovaFormaCadCartaoTef(const AMensagem: String = ''): Boolean;
    procedure pAtualizaCamposNovaFormaCadCartaoTef(Sender: TWinControl) ;
    function fSomentePosSelecionado: Boolean ;
    procedure pHabilitaDesCar(const AblnHabilita: Boolean; const AblnSomenteCores: Boolean = False) ;
    procedure pAjustarLabelGroupBoxLinkPagamentoBandeira ;
    procedure pTratarZerosEsquerdaSemAcaoDoComponente(AEdit: TDBEditFocus);
    function fObjetoValidoParaAtualizarNovaFormaCadCartaoTef(ASenderObject: TWinControl): Boolean;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    qryConEmp : TUniQuery;
  end;


implementation

uses SysUtils, Variants, StrUtils, untFuncoesSimples, untPesqAux, untFuncIns,
     untFuncoesGenerica, untConsultas, untTypesSistema, untDesmCarEmpCContabil,
     Contabilidade.Consultas, Contabilidade.Funcoes, untCadCartoesBaixaOtimizada,
     untPanelCxBandeiras, untPnlDadosBandeiras, untTDadosEquals,
     untClassesComumLinkPagamentoCitel, untCadCartoesAlteracaoGlobal,
     untPanelCxAdquirentesCartao, untPnlDadosAdquirentesCartao,
     untRegrasCadastroCartaoTef, Vcl.Graphics;

{$R *.dfm}

procedure TfrmCadCartoes.FormCreate(Sender: TObject);
begin
  inherited;
  pMostraCamposNovaFormaCadCartaoTef ;
  pDesabilitaCamposNovaFormaCadCartaoTef ;

  FcdsNCO := fCriaEstruturaCdsNCO(Nil);
  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryCadFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryCadEve := fCriarQuery('SELECT * FROM CADEVE WHERE FALSE', Self);

  strNomeTabela         := 'CADCAR';
  strNomeCampo          := 'CAR_CODCAR';

  qryTabela             := fCriaQuery(Self);
  dtsCadCar.DataSet     := qryTabela;

  qryTabela.AfterOpen := pAfterOpen;    

  SetLength(arrCamposChave, 1);
  arrCamposChave[0]     := dbeCodCar;

  qryCadPor             := fCriaQuery(Self);

  blnBaixaOtimizada := fCfgSis('BAIOTI', varBoolean);

  GroupBox2.Enabled        := blnBaixaOtimizada;
  GroupBox3.Enabled        := blnBaixaOtimizada;
  grpCancelamentos.Enabled := blnBaixaOtimizada;
  grpCtaAnt.Enabled        := blnBaixaOtimizada;
  pgcDados.ActivePage := tbsGeral;

  blnUtiCon := fCfgSis('UTICON', varBoolean);

  cdsValidaConPor := TUniClientDataSet.Create(Self);

  dbeCodRed.Visible := False;
  lblCodRed.Visible := dbeCodRed.Visible;
  edtDesCredenciadora.Visible := dbeCodRed.Visible;
  
  if (blnUticon) then
  begin
    lblCodRed.Top := lblCodRed.Top - 21;
    dbeCodRed.Top := dbeCodRed.Top - 21;
    edtDesCredenciadora.Top := edtDesCredenciadora.Top - 21;

    lblFornecedorFiscal.Top := lblFornecedorFiscal.Top - 21;
    dbeCodigoFornecedorFiscal.Top := dbeCodigoFornecedorFiscal.Top - 21;
    edtNomeFornecedorFiscal.Top := edtNomeFornecedorFiscal.Top - 21;
  end;

  strUltCnpj := '-1';
  blnAtualizaCnpj := True;
  strPlCtaOld      := '';
  strPlCtaBaixOld  := '';
  strPlCtaDebOld   := '';
  strPlCtaCancOld  := '';
  strPlCtaAntOld   := '';
  strPlCtaFreteOld := '';

  blnCriouHeranca := False;

  cmbAdquirinteEquals.ListSource := fCriaDataSource(TDadosEquals.RetornaDatasetAdquirinte);
  cmbMeiosCapturaEquals.ListSource := fCriaDataSource(TDadosEquals.RetornaDatasetMeiosCaptura);

  gbLinkPagamentoBandeira.Visible := MatchStr(fCfgSis('LINKPG', varString), ['3', '5', '7']) ;
  pAjustarLinkCielo ;
  pAjustarLabelGroupBoxLinkPagamentoBandeira ;
  TlinkPagamentoCitelBandeiras.pPreencheCombo(dbeCieban.Items) ;

  FintHeightGbTefViaDLL := gbTefViaDLL.Height ;
  FintHeightGbDadosTef := gbDadosTef.Height ;
  FintHeightForm := Self.Height ;
  FintTopLbCardSe := lbCardSe.Top ;
  FintTopDbeCardSe := dbeCardSe.Top ;

  grpExportacaoEquals.Visible := Not Trim(fCfgSis('EQUPAT', varString)).IsEmpty;
  pMostrarTipoDebito(False) ;

  FConfiguracaoMERANA := fCfgSis('MERANA', varBoolean) Or
                         fCfgSis('SHOANA', varBoolean) Or
                         fCfgSis('MLZANA', varBoolean);

  //BtnAlteracaoGlobal.Enabled := False;
end;

procedure TfrmCadCartoes.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pCarregaDadosAdicionais;

  pHabilitaCodigo(dbeCodCar, dbeDesCar, Not blnUsaProCodigo);

  qryTabela.FieldByName('CAR_TIPCAR').AsString := 'C';
  qryTabela.FieldByName('CAR_STATUS').AsString := 'S';
  qryTabela.FieldByName('CAR_ENTSPE').AsString := 'S';
  qryTabela.FieldByName('CAR_OBRCCD').AsString := 'S';
  qryTabela.FieldByName('CAR_OBRNSU').AsString := 'S';
  qryTabela.FieldByName('CAR_TIPTAX').AsString := 'P';
  qryTabela.FieldByName('CAR_TAXMIN').AsFloat  := 0.00;
  qryTabela.FieldByName('CAR_MKTPLA').AsString := 'N';
  qryTabela.FieldByName('CAR_EQUCAP').AsString := '3';
  qryTabela.FieldByName('CAR_ARRPAR').AsString := 'N';
  qryTabela.FieldByName('CAR_TIPTEF').AsString := 'N';
  qryTabela.FieldByName('CAR_TIPPOS').AsString := 'N';

  strPlCtaOld      := '';
  strPlCtaBaixOld  := '';
  strPlCtaDebOld   := '';
  strPlCtaCancOld  := '';
  strPlCtaAntOld   := '';
  strPlCtaFreteOld := '';

  pHideHint;

  stlExclusoes.Clear;
  pCarregaPlanoDeContasPorEmpresa('CARNCO', dbeCodCar.Text, FcdsNCO);

  btnAlterar.Enabled := False;
  btnExcluir.Enabled := False;
  btnHeranca.Enabled := False;
  btnHeranca.Enabled := False;

  HabilitarFornecedorFiscal;
  HabilitarEquals;
  HabilitarArredondamento;
  pDesabilitaCamposNovaFormaCadCartaoTef;
end;

procedure TfrmCadCartoes.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(FcdsNCO) then
    FreeAndNil(FcdsNCO) ;
end;

procedure TfrmCadCartoes.btnIncluirDadosEmpresaClick(Sender: TObject);
  Var
    frmCadCartoesBaixaOtimizada: TfrmCadCartoesBaixaOtimizada;
begin
  inherited;

  cdsValidaConPor.Data := cdsConPor.Data;

  cdsConPor.Last;
  cdsConPor.Append;
  cdsConPor.FieldByName('CON_CODCAR').AsString := dbeCodCar.Text;
  cdsConPor.FieldByName('INCLUIDO').AsString   := 'S';

  pCriarFormularios(TfrmCadCartoesBaixaOtimizada, frmCadCartoesBaixaOtimizada);
  frmCadCartoesBaixaOtimizada.pCarregaEmpresa;
  frmCadCartoesBaixaOtimizada.dtsConPor.DataSet := cdsConPor;
  frmCadCartoesBaixaOtimizada.cdsValidaConPor   := cdsValidaConPor;
  frmCadCartoesBaixaOtimizada.ExibeCampoFrete   := grpFretes.Visible;
  frmCadCartoesBaixaOtimizada.ExibeCampoCupom   := grpCupons.Visible;
  frmCadCartoesBaixaOtimizada.ShowModal;
  FreeAndNil(frmCadCartoesBaixaOtimizada);

  pSetFocus(grdDadosOtimizada);
end;

procedure TfrmCadCartoes.BtnAlteracaoGlobalClick(Sender: TObject);
var
  LFrmCadCartoesAlteracaoGlobal: TfrmCadCartoesAlteracaoGlobal;
begin
  inherited;
  pCriarFormularios(TfrmCadCartoesAlteracaoGlobal, LFrmCadCartoesAlteracaoGlobal);
  try
    LFrmCadCartoesAlteracaoGlobal.gbFretes.Visible := grpFretes.Visible;
    LFrmCadCartoesAlteracaoGlobal.gbCupons.Visible := grpCupons.Visible;
    LFrmCadCartoesAlteracaoGlobal.gbPorEmpresaFretes.Visible := grpFretes.Visible;
    LFrmCadCartoesAlteracaoGlobal.gbPorEmpresaCupons.Visible := grpCupons.Visible;
    LFrmCadCartoesAlteracaoGlobal.grpExportacaoEquals.Visible := grpExportacaoEquals.Visible;

    if LFrmCadCartoesAlteracaoGlobal.fTemCartoesCadastrados then
      LFrmCadCartoesAlteracaoGlobal.ShowModal
    else
      fMensagem('ATENÇÃO!', 'Não há nenhum cartão cadastrado.', ['&Ok']);
  finally
    pFreeAndNil(LFrmCadCartoesAlteracaoGlobal);
  end;
end;

procedure TfrmCadCartoes.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodCar, dbeDesCar, False);

  pHabiliatarOtimizadaPorEmpresa(True);

  HabilitarFornecedorFiscal;
  HabilitarEquals;
  HabilitarArredondamento;

  pDesabilitaCamposNovaFormaCadCartaoTef ;

  stlExclusoes.Clear;

  strPlCtaOld      := fraPlanoDeContas.dbeCodCta.Text;
  strPlCtaBaixOld  := fraPlanoDeContasDaBaixa.dbeCodCta.Text;
  strPlCtaDebOld   := fraPlanoDeContasDebito.dbeCodCta.Text;
  strPlCtaCancOld  := fraPlanoDeContasCanc.dbeCodCta.Text;
  strPlCtaAntOld   := fraPlanoDeContasAnt.dbeCodCta.Text;
  strPlCtaFreteOld := fraPlanoDeContasFrete.dbeCodCta.Text;

  btnHeranca.Enabled := False;
end;

function TfrmCadCartoes.fCartaoUtilizandoEmMarketplace(
  ACodigoCartao: string): boolean;
var
  LConsultaCartao : TUniQuery;
const
  LSQL : String = 'SELECT CAR_MKTPLA, CAR_CODCAR, GTY_NOMGTY, ' +
                  '       GTY_HUBMKP, GTY_CODEMP FROM HUBCIT_CADGTY ' +
                  ' INNER JOIN CADCAR ON GTY_CODCAR = CAR_CODCAR ' +
                  ' WHERE GTY_CODCAR = :CODCAR ';
begin
  Result := False;

  if fEmptyStr(ACodigoCartao) then
    Exit;

  if not fTabelaExiste('HUBCIT_CADGTY', True) then
    Exit;

  LConsultaCartao := fCriaQuery(Self);
  try
    try
      LConsultaCartao.SQL.Text := LSQL;
      LConsultaCartao.ParamByName('CODCAR').AsString := ACodigoCartao;
      LConsultaCartao.Open;
      Result := not LConsultaCartao.IsEmpty
    except on E: Exception do
      pMensagensErro('Ocorreu um erro ao verificar o cartão. Erro gerado: ' + E.Message, '[TfrmCadCartoes.fCartaoUtilizandoEmMarketplace]');
    end;
  finally
    if assigned(LConsultaCartao) then
      FreeAndNil(LConsultaCartao);
  end;
end;

procedure TfrmCadCartoes.fraCentroCustoCdbeCodEveExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(TDBEditFocus(Sender));
end;

procedure TfrmCadCartoes.fraCentroCustoDdbeCodEveExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(TDBEditFocus(Sender));
end;

procedure TfrmCadCartoes.fraCentroCustoTXdbeCodEveExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(TDBEditFocus(Sender));
end;

function TfrmCadCartoes.fraPlanoDeContasAntdbeCodCtaChamaCadastro(
  Key: Word): string;
begin
  inherited;
  Result := fChamaCadCta(Key);
end;

procedure TfrmCadCartoes.fraPlanoDeContasAntdbeCodCtaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCentroCusto : TConsultasArray;
begin
  inherited;
  If fPesqCentroCusto(Self, fraPlanoDeContasAnt.dbeCodCta, fraPlanoDeContasAnt.edtDesCta, Nil, Key, arrCentroCusto) Then
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      Self.SelectNext(ActiveControl, True, True);
end;

function TfrmCadCartoes.fraPlanoDeContasCancdbeCodCtaChamaCadastro(
  Key: Word): string;
begin
  inherited;
  Result := fChamaCadCta(Key);
end;

procedure TfrmCadCartoes.fraPlanoDeContasCancdbeCodCtaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCentroCusto : TConsultasArray;

    bolOK: Boolean;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If Not fCfgSis('USACTF', varBoolean) Then
    bolOK := fPesqCentroCusto(Self, fraPlanoDeContasCanc.dbeCodCta, fraPlanoDeContasCanc.edtDesCta, Nil, Key, arrCentroCusto)
  Else
    bolOK := fPesqCentroCusto(Self, fraPlanoDeContasCanc.dbeCodCta, fraPlanoDeContasCanc.edtDesCta, Nil, Key, arrCentroCusto, True, True, dbeForTax.Field.AsString);

  If bolOK Then
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadCartoes.fraPlanoDeContasCuponsdbeCodCtaKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContasCupons.dbeCodCta, fraPlanoDeContasCupons.edtDesCta, Nil, Key, arrCentroCusto) Then
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      Self.SelectNext(ActiveControl, True, True);
end;

function TfrmCadCartoes.fraPlanoDeContasDaBaixadbeCodCtaChamaCadastro(
  Key: Word): string;
begin
  inherited;
  Result := fChamaCadCta(Key);
end;

procedure TfrmCadCartoes.fraPlanoDeContasDaBaixadbeCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
  bolOK: Boolean;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If Not fCfgSis('USACTF', varBoolean) Then
    bolOK := fPesqCentroCusto(Self, fraPlanoDeContasDaBaixa.dbeCodCta, fraPlanoDeContasDaBaixa.edtDesCta, Nil, Key, arrCentroCusto)
  Else
    bolOK := fPesqCentroCusto(Self, fraPlanoDeContasDaBaixa.dbeCodCta, fraPlanoDeContasDaBaixa.edtDesCta, Nil, Key, arrCentroCusto, True, True, dbeForTax.Field.AsString);

  If bolOK Then
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);

end;

function TfrmCadCartoes.fraPlanoDeContasdbeCodCtaChamaCadastro(
  Key: Word): string;
begin
  inherited;
  Result := fChamaCadCta(Key);
end;

procedure TfrmCadCartoes.fraPlanoDeContasdbeCodCtaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCentroCusto : TConsultasArray;
    bolOK: Boolean;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  bolOK := fPesqCentroCusto(Self, fraPlanoDeContas.dbeCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto);

  If bolOK Then
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadCartoes.fraPlanoDeContasDebitodbeCodCtaKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrCentroCusto : TConsultasArray;
begin
  inherited;
  If fPesqCentroCusto(Self, fraPlanoDeContasDebito.dbeCodCta, fraPlanoDeContasDebito.edtDesCta, Nil, Key, arrCentroCusto) Then
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadCartoes.fraPlanoDeContasFretedbeCodCtaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCentroCusto : TConsultasArray;

    bolOK: Boolean;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If Not fCfgSis('USACTF', varBoolean) Then
    bolOK := fPesqCentroCusto(Self, fraPlanoDeContasFrete.dbeCodCta, fraPlanoDeContasFrete.edtDesCta, Nil, Key, arrCentroCusto)
  Else
    bolOK := fPesqCentroCusto(Self, fraPlanoDeContasFrete.dbeCodCta, fraPlanoDeContasFrete.edtDesCta, Nil, Key, arrCentroCusto, True, True, dbeForTax.Field.AsString);

  If bolOK Then
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      Self.SelectNext(ActiveControl, True, True);
end;

function TfrmCadCartoes.fRetSQLConCar: String;
begin
  Result := '';
  Result := Result + 'SELECT CONPOR.*,                                     ';
  Result := Result + 'CONCAT(CON_PORCRE, "-", P1.POR_NOMPOR) AS DESPORCRE, ';
  Result := Result + 'CONCAT(CON_PORTAX, "-", P2.POR_NOMPOR) AS DESPORTAX, ';
  Result := Result + 'CONCAT(CON_PORDEB, "-", P3.POR_NOMPOR) AS DESPORDEB, ';
  Result := Result + 'CONCAT(CON_CTACRE, "-", C1.CTA_DESCTA) AS DESCTACRE, ';
  Result := Result + 'CONCAT(CON_CTATAX, "-", C2.CTA_DESCTA) AS DESCTATAX, ';
  Result := Result + 'CONCAT(CON_CTADEB, "-", C3.CTA_DESCTA) AS DESCTADEB, ';
  Result := Result + 'CONCAT(CON_CTAAJU, "-", C4.CTA_DESCTA) AS DESCTAAJU, ';
  Result := Result + 'CONCAT(CON_CTAANT, "-", C5.CTA_DESCTA) AS DESCTAANT, ';
  Result := Result + 'CONCAT(CON_CTAFRE, "-", C6.CTA_DESCTA) AS DESCTAFRE, ';
  Result := Result + 'CONCAT(CON_CTACUP, "-", C7.CTA_DESCTA) AS DESCTACUP, ';
  Result := Result + 'CONCAT(CON_EVECRE, "-", E1.EVE_DESEVE) AS DESEVECRE, ';
  Result := Result + 'CONCAT(CON_EVETAX, "-", E2.EVE_DESEVE) AS DESEVETAX, ';
  Result := Result + 'CONCAT(CON_EVEDEB, "-", E3.EVE_DESEVE) AS DESEVEDEB, ';
  Result := Result + 'CONCAT(CON_FORTAX, "-", F1.FOR_NOMFOR) AS DESFORTAX, ';
  Result := Result + '"N" AS INCLUIDO                                      ';

  Result := Result + 'FROM CONPOR                                          ';
  Result := Result + 'LEFT JOIN CADPOR P1 ON P1.POR_CODPOR=CON_PORCRE      ';
  Result := Result + 'LEFT JOIN CADPOR P2 ON P2.POR_CODPOR=CON_PORTAX      ';
  Result := Result + 'LEFT JOIN CADPOR P3 ON P3.POR_CODPOR=CON_PORDEB      ';
  Result := Result + 'LEFT JOIN CADCTA C1 ON C1.CTA_CODCTA=CON_CTACRE      ';
  Result := Result + 'LEFT JOIN CADCTA C2 ON C2.CTA_CODCTA=CON_CTATAX      ';
  Result := Result + 'LEFT JOIN CADCTA C3 ON C3.CTA_CODCTA=CON_CTADEB      ';
  Result := Result + 'LEFT JOIN CADCTA C4 ON C4.CTA_CODCTA=CON_CTAAJU      ';
  Result := Result + 'LEFT JOIN CADCTA C5 ON C5.CTA_CODCTA=CON_CTAANT      ';
  Result := Result + 'LEFT JOIN CADCTA C6 ON C6.CTA_CODCTA=CON_CTAFRE      ';
  Result := Result + 'LEFT JOIN CADCTA C7 ON C7.CTA_CODCTA=CON_CTAFRE      ';
  Result := Result + 'LEFT JOIN CADEVE E1 ON E1.EVE_CODEVE=CON_EVECRE      ';
  Result := Result + 'LEFT JOIN CADEVE E2 ON E2.EVE_CODEVE=CON_EVETAX      ';
  Result := Result + 'LEFT JOIN CADEVE E3 ON E3.EVE_CODEVE=CON_EVEDEB      ';
  Result := Result + 'LEFT JOIN CADFOR F1 ON F1.FOR_CODFOR=CON_FORTAX      ';

  Result := Result + 'WHERE CON_CODCAR="' + dbeCodCar.Text + '"            ';
  Result := Result + 'ORDER BY CON_CODEMP                                  ';
end;

function TfrmCadCartoes.fSomentePosSelecionado: Boolean;
begin
  result := (chkTipoPos.Checked) and (not chkTipoTef.Checked) ;
end;

function TfrmCadCartoes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var qryAux   : TUniQuery;
    SEditFocus : TEditFocus;
    SMensagem  : String;
    strCnpj: string;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    pAtualizaCamposNovaFormaCadCartaoTef(Sender) ;
    If (Sender = dbeCodCar) Then
    Begin

      If (fEmptyStr(dbeCodCar.Text)) And (dbeCodCar.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Cartão deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End
      Else If (Not fVerificaAcessoCartao(dbeCodCar.Text)) Then
      Begin
        fMensagem('', 'Usuário sem permissão de acesso a esse Cartão!', ['&Ok']);
        Result := False;
      End;

    End
    Else If (Sender = dbeDesCar) Then
    Begin

      If fEmptyStr(dbeDesCar.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do Cartão deve ser preenchido!', ['&Ok']);
        Result := False;
      End;

    End
    Else If (Sender = dbeTipTax) Then
    Begin
      If Pos(dbeTipTax.Text, 'PV') <= 0 Then
      Begin
        Result := False;
        fMensagem('','O campo Tipo de Taxa deve ser informado com (P)ercentual ou (V)alor!', ['&Ok']);
      End;
    End
    Else If (Sender = dbePerDes) Then
    Begin
      If fEmptyStr(dbePerDes.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O ' + IIF(dbeTipTax.Text = 'P', 'percentual', 'valor') + ' de desconto deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (Not fValidaEscala(dbePerDes.Text, 0, 100)) And (dbeTipTax.Text = 'P') Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de desconto deve estar entre 0 e 100 !', ['&Ok']);
        Result := False;
      End
      Else If (fStrToFloat(dbePerDes.Text) < 0) And (dbeTipTax.Text = 'V') Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor de desconto ser maior que 0!', ['&Ok']);
        Result := False;
      End;
      If Not fEmptyStr(dbePerDes.Text) Then
        dbePerDes.Text := FloattoStrF(fStrToFloat(dbePerDes.Text), ffNumber, 12, IIF(dbeTipTax.Text = 'V', 2, 6));
    End
    Else If (Sender = dbeParMin) Then
    Begin

      If fEmptyStr(dbeParMin.Text) And (dbeTipTax.Text = 'V') Then
      Begin
        fMensagem('ATENÇÃO!', 'Quando o campo Tipo de Taxa for igual a Valor, o campo Valor Mínimo da Parcela deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (dbeTipTax.Text = 'V') And (fStrToFloat(dbeParMin.Text) < fStrToFloat(dbePerDes.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Quando o campo Tipo de Taxa for igual a Valor, o campo Valor Mínimo da Parcela deve ser maior que a Taxa de Administração !', ['&Ok']);
        Result := False;
      End;
      If Not fEmptyStr(dbeParMin.Text) Then
        dbeParMin.Text := FloattoStrF(fStrToFloat(dbeParMin.Text), ffNumber, 12, 2);

    End
    Else If (Sender = dbeCodBan) Then
    Begin

      If fEmptyStr(dbeCodBan.Text) Then
      Begin
        edtNomBan.Clear;
        fMensagem('ATENÇÃO!', 'O Código da Bandeira deve ser preenchido!', ['&Ok']);
        Result := False;
      End Else
      Begin
        edtNomBan.Text := fRetNomBandeira(dbeCodBan.Text);

        If fEmptyStr(edtNomBan.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Código da Bandeira não encontrado!', ['&Ok']);
          Result := False;
        End;

      End

    End

    Else If fCadastroCartaoParamAutTef and (not fSomentePosSelecionado) and (Sender = dbeCodAdq) Then
    Begin
      pTratarZerosEsquerdaSemAcaoDoComponente(dbeCodAdq);
      If fEmptyStr(dbeCodAdq.Text) Then
      Begin
        edtNomAdq.Clear;
        fMensagem('ATENÇÃO!', 'O Código da Adquirente deve ser preenchido!', ['&Ok']);
        Result := False;
      End Else
      Begin
        edtNomAdq.Text := fRetNomAdquirenteCartao(dbeCodAdq.Text);
        If fEmptyStr(edtNomAdq.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Código da Adquirente não encontrado!', ['&Ok']);
          Result := False;
        End;

      End;
    End

    Else If (Sender = dbeCardSe) Then
    Begin

      If not fEmptyStr(dbeCardSe.Text) Then
      Begin
        If fEmptyStr(fRetCardSe(dbeCardSe.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Cód. CardSe não encontrado!', ['&Ok']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = dbeCodigoFornecedorFiscal) And (dbeCodigoFornecedorFiscal.Enabled) Then
    Begin
      edtNomeFornecedorFiscal.Clear;
      If Not fEmptyStr(dbeCodigoFornecedorFiscal.Text) Then
      Begin
        CarregaFornecedorFiscal;
        If fEmptyStr(edtNomeFornecedorFiscal.Text) Then
        Begin
          fMensagem('ATENÇÃO','Fornecedor Fiscal não encontrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        If dbeEntSped.Text = 'S' Then
        Begin
         fMensagem('ATENÇÃO','O Fornecedor Fiscal deve ser preenchido!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeCodRed) and (dbeCodRed.Visible) Then
    Begin

      If fEmptyStr(dbeCodRed.Text) Then
      Begin
        edtDesCredenciadora.Clear;
        fMensagem('ATENÇÃO!', 'O Código da Credenciadora no SAT deve ser preenchido!', ['&Ok']);
        Result := False;
      End Else
      Begin
        edtDesCredenciadora.Text := fRetNomCredenciadora(dbeCodRed.Text);

        If fEmptyStr(edtDesCredenciadora.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Código da Credenciadora não encontrado!', ['&Ok']);
          Result := False;
        End
        else if dbeCodRed.Text <> '999' then
        begin
          strCnpj := fCampoTabela('CRE_CNPJ__', 'CADCRE', ['CRE_CODCRE'], [dbeCodRed.Text]);
          blnAtualizaCnpj := (strUltCnpj <> strCnpj);

          if (blnAtualizaCnpj)and (not SameText(qryTabela.FieldByName('CAR_C_G_C_').AsString, strCnpj)) then
          begin
            if fMensagem('', 'Gostaria de atualizar o CNPJ da Administradora?', ['&Sim', '&Não']) = 1 then
              qryTabela.FieldByName('CAR_C_G_C_').AsString := strCnpj;

            strUltCnpj := strCnpj;
          end;
        end;

      End

    End
    Else If (Sender = dbePeriod) Then
    Begin

      If (fEmptyStr(dbePeriod.Text)) Then
      Begin
        dbePeriod.Field.AsInteger := 0;
      End
      Else If (StrToInt(dbePeriod.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A periodicidade deve ser um valor maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;

    End
    Else If (Sender = dbeExcDia) Then
    Begin

      If fEmptyStr(dbeExcDia.Text) Then
      Begin
        dbeExcDia.Field.AsInteger := 0
      End
      Else If (StrToIntDef(dbeExcDia.Text, -1) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade de dias excedentes na 1ª parcela deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;

    End
    Else If (Sender = dbeSugCPg) Then
    Begin

      If (fEmptyStr(dbeSugCPg.Text)) Then
      Begin
        dbeSugCPg.Field.AsInteger := 1;
      End
      Else If (StrToInt(dbeSugCPg.Text) < 1) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Qtd. Mínima de Parcelas deve ser um valor maior ou igual a 1!', ['&Ok']);
        Result := False;
      End
      Else If StrToInt(dbeSugCPg.Text) > intParCar Then
      Begin
        fMensagem('ATENÇÃO!', 'A Qtd. Mínima de Parcelas deve ser um valor menor ou igual a ' + InttoStr(intParCar) + '!', ['&Ok']);
        Result := False;
      End;

    End
    Else If (Sender = dbeMaxPar) Then
    Begin

      If (fEmptyStr(dbeMaxPar.Text)) Then
      Begin
        dbeMaxPar.Field.AsInteger := StrToInt(dbeSugCPg.Text);
      End
      Else If StrToInt(dbeMaxPar.Text) < StrToInt(dbeSugCPg.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Qtd. Máxima de Parcelas deve ser um valor maior ou igual a Qtd. Mínima de Parcelas!', ['&Ok']);
        Result := False;
      End

      Else If StrToInt(dbeMaxPar.Text) < 1 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Qtd. Máxima de Parcelas deve ser um valor maior ou igual a 1!', ['&Ok']);
        Result := False;
      End

      Else If StrToInt(dbeMaxPar.Text) > intParCar Then
      Begin
        fMensagem('ATENÇÃO!', 'A Qtd. Máxima de Parcelas deve ser um valor menor ou igual a ' + InttoStr(intParCar) + '!', ['&Ok']);
        Result := False;
      End;

    End
    Else If (Sender = edtCodEmpresa) Then
    Begin

      If Not fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        pCarregaEmpresa(edtCodEmpresa, edtDesEmpresa);
        If (qryConEmp.IsEmpty) Then
        Begin
          fMensagem('ATENÇÃO', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('', 'Usuário sem permissão de acesso a essa Empresa!', ['&Ok']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = dbeNomRed) Then
    Begin

      If fEmptyStr(dbeNomRed.Text) Then
      Begin
        dbeNomBan.Clear;
        dbeTipTra.Clear;

        dbeNomBan.Enabled := False;
        dbeTipTra.Enabled := False;
      End
      Else
      Begin
        dbeNomBan.Enabled := True;
        dbeTipTra.Enabled := True;
      End;

    End
    Else If (Sender = dbeNomBan) Then
    Begin

      If (Not fEmptyStr(dbeNomRed.Text)) And fEmptyStr(dbeNomBan.Text) Then
      Begin
        pMensagemOk('O campo "Nome da Bandeira" deve ser preenchido!');
        Result := False;
      End;

    End
    Else If (Sender = dbeTipTra) Then
    Begin

      If (Not fEmptyStr(dbeNomRed.Text)) And fEmptyStr(dbeTipTra.Text) Then
      Begin
        pMensagemOk('O campo "Tipo da Transação" deve ser preenchido!');
        Result := False;
      End;

    End

    Else If (Sender = dbePlaNco) And (dbePlaNco.Visible) Then
    Begin
      pCarregaPlanoContabil(blnBuscaPorChave);
      If (Not fEmptyStr(dbePlaNco.Text)) And (fEmptyStr(edtDesPlaNco.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Plano contábil inexistente!', ['&OK']);
        Result := False;
      End
      Else If (qryTabela.State In [dsInsert, dsEdit]) Then
      begin
        If fEmptyStr(edtDesPlaNco.Text) Then
          dbePlaNco.Field.Value := Null
        Else
          dbePlaNco.Field.AsString := fSemMascaraPlaNco(dbePlaNco.Text);
      End;
    End

    Else If (Sender = dbePorBai) Then
    Begin

      If (fEmptyStr(dbePorBai.Text)) Then
      Begin
        edtPorBai.Clear;
        dbePorBai.Field.Clear;
      End
      Else
      Begin
        pCarregaPortador(dbePorBai, edtPorBai);

        If blnBaixaOtimizada Then
        Begin
          If (qryCadPor.FieldByName('POR_CODPOR').IsNull) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!', ['&Ok']);
            Result := False;
          End
          {*REQ*145940**********RP*}
          Else If Not fEmpresaTemAcessoPortador(dbePorBai.Text, edtCodEmpresa.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End
          Else If fCfgSis('DACPOR', varBoolean) And (Pos(dbePorBai.Text, strPortadoresOperador) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&Ok']);
            Result := False;
          End
          Else If (Not fPortadorPermiteBaixa(dbePorBai.Text)) Then
          Begin
            fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
            Result := False;
          End;
        End;
      End;

    End
    Else If (Sender = dbePorTax) Then
    Begin

      If (fEmptyStr(dbePorTax.Text)) Then
      Begin
        edtPorTax.Clear;
        dbePorTax.Field.Clear;
      End
      Else
      Begin
        pCarregaPortador(dbePorTax, edtPorTax);

        If blnBaixaOtimizada Then
        Begin
          If (qryCadPor.FieldByName('POR_CODPOR').IsNull) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!', ['&Ok']);
            Result := False;
          End
          {*REQ*145940**********RP*}
          Else If Not fEmpresaTemAcessoPortador(dbePorTax.Text, edtCodEmpresa.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End
          Else If fCfgSis('DACPOR', varBoolean) And (Pos(dbePorTax.Text, strPortadoresOperador) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&Ok']);
            Result := False;
          End
          Else If (Not fPortadorPermiteBaixa(dbePorTax.Text)) Then
          Begin
            fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
            Result := False;
          End;
        End;
      End;

    End
    Else If (Sender = dbePorBad) Then
    Begin

      If (fEmptyStr(dbePorBad.Text)) Then
      Begin
        edtPorBad.Clear;
        dbePorBad.Field.Clear;
      End
      Else
      Begin
        pCarregaPortador(dbePorBad, edtPorBad);

        If blnBaixaOtimizada Then
        Begin
          If (qryCadPor.FieldByName('POR_CODPOR').IsNull) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!', ['&Ok']);
            Result := False;
          End
          {*REQ*145940**********RP*}
          Else If Not fEmptyStr(edtCodEmpresa.Text) And Not fEmpresaTemAcessoPortador(dbePorBad.Text, edtCodEmpresa.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End
          Else If fCfgSis('DACPOR', varBoolean) And (Pos(dbePorBad.Text, strPortadoresOperador) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&Ok']);
            Result := False;
          End
          Else If (Not fPortadorPermiteBaixa(dbePorBad.Text)) Then
          Begin
            fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
            Result := False;
          End
          Else If Not fEmptyStr(dbePorBai.Text) And (dbePorBai.Text = dbePorBad.Text) Then
          Begin
            fMensagem('ATENÇÃO', 'O portador do Grupo de Débito não pode ser o mesmo do Grupo de Crédito!',['&O K']);
            Result := False;
          End;
        End;
      End;

    End
    Else If (Sender = fraPlanoDeContas.dbeCodCta) Then
    Begin

      If (RightStr(fraPlanoDeContas.dbeCodCta.Text, 3) = '000') ANd (blnBaixaOtimizada) Then
      Begin
        fMensagem('ATENÇÃO!', fraPlanoDeContas.dbeCodCta.Text + ' não é um Plano de Contas válido!', ['&Ok']);
        fraPlanoDeContas.dbeCodCta.Field.Clear;
        Result := False;
      End

      Else If Not fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.dbeCodCta.Text)) Then
      Begin
        fraPlanoDeContas.dbeCodCta.Text := fStrZero(fraPlanoDeContas.dbeCodCta.Text,7);
        pCarregaCentroDeCusto(fraPlanoDeContas.dbeCodCta, fraPlanoDeContas.edtDesCta, False);

        If blnBaixaOtimizada Then
        Begin
          If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok']);

            Result := False;
          End
          Else
          Begin
            If (qryTabela.State In [dsInsert]) or (strPlCtaOld <> fraPlanoDeContas.dbeCodCta.Text) then
              Result := PlanoDeContasAtivo(fraPlanoDeContas.dbeCodCta.Text,True);
          End;
        End;
      End

      Else
      Begin
        fraPlanoDeContas.edtDesCta.Clear;
        fraPlanoDeContas.dbeCodCta.Field.Clear;
      End;

    End
    Else If (Sender = dbeStatus) Then
    Begin

      If Not fValidoSimNao(dbeStatus.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'No campo "Ativo?" deve ser informado S ou N!', ['&Ok']);
        Result := False;
      End;

    End
    Else If (Sender = dbeMarketPlace) Then
    Begin

      If Not fValidoSimNao(dbeMarketPlace.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'No campo "Mercado Livre" deve ser informado S ou N!', ['&Ok']);
        Result := False;
      End;

      if (dbeMarketPlace.Text <> 'S') and (not fEmptyStr(dbeCodCar.Text)) then
      begin
        if fCartaoUtilizandoEmMarketplace(dbeCodCar.Text) then
        begin
          fMensagem('ATENÇÃO!', 'Os cartões vinculados à integração HUB devem obrigatoriamente ter o campo "Mercado Livre" definido "S"!', ['&Ok']);
          Result := False;
        end;
      end;

      grpFretes.Visible := dbeMarketPlace.Text = 'S';
      grdDadosOtimizadaDadosCON_CTAFRE.Visible := dbeMarketPlace.Text = 'S';

      grpCupons.Visible := dbeMarketPlace.Text = 'S';
      grdDadosOtimizadaDadosCON_CTACUP.Visible := dbeMarketPlace.Text = 'S';
      If grpCupons.Visible Then
      Begin
        grpCupons.Visible := FConfiguracaoMERANA;
        grdDadosOtimizadaDadosCON_CTACUP.Visible := FConfiguracaoMERANA;
      End;
    End
    Else If (Sender = dbeNumCCD) Then
    Begin

      If Not fValidoSimNao(dbeNumCCD.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'No campo "Obrigatório Núm. Liberação?" deve ser informado S ou N!', ['&Ok']);
        Result := False;
      End;

    End
    Else If (Sender = dbeNumNSU) Then
    Begin

      If Not fValidoSimNao(dbeNumNSU.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'No campo "Obrigatório Núm. NSU?" deve ser informado S ou N!', ['&Ok']);
        Result := False;
      End;

    End
    Else If (Sender = fraPlanoDeContasDaBaixa.dbeCodCta) Then
    Begin

      If (RightStr(fraPlanoDeContasDaBaixa.dbeCodCta.Text, 3) = '000') And (blnBaixaOtimizada) Then
      Begin
        fMensagem('ATENÇÃO!', fraPlanoDeContasDaBaixa.dbeCodCta.Text + ' não é um Plano de Contas válido!', ['&Ok']);
        fraPlanoDeContasDaBaixa.dbeCodCta.Field.Clear;
        Result := False;
      End

      Else If Not fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContasDaBaixa.dbeCodCta.Text)) Then
      Begin
        fraPlanoDeContasDaBaixa.dbeCodCta.Text := fStrZero(fraPlanoDeContasDaBaixa.dbeCodCta.Text,7);

        pCarregaCentroDeCusto(fraPlanoDeContasDaBaixa.dbeCodCta, fraPlanoDeContasDaBaixa.edtDesCta, True);

        If blnBaixaOtimizada Then
        Begin
          If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
          Begin
            If Not fCfgSis('USACTF', varBoolean) Then
              fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok'])
            Else
              fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado ou não está vinculado ao fornecedor!', ['&Ok']);

            Result := False;
          End
          Else
          Begin
            If (qryTabela.State In [dsInsert]) or (strPlCtaBaixOld <> fraPlanoDeContasDaBaixa.dbeCodCta.Text) then
              Result := PlanoDeContasAtivo(fraPlanoDeContasDaBaixa.dbeCodCta.Text,True);
          End;
        End;
      End

      Else
      Begin
        fraPlanoDeContasDaBaixa.edtDesCta.Clear;
        fraPlanoDeContasDaBaixa.dbeCodCta.Field.Clear;
      End;

    End
    Else If (Sender = fraPlanoDeContasDebito.dbeCodCta) Then
    Begin

      If (RightStr(fraPlanoDeContasDebito.dbeCodCta.Text, 3) = '000') And (blnBaixaOtimizada) Then
      Begin
        fMensagem('ATENÇÃO!', fraPlanoDeContasDebito.dbeCodCta.Text + ' não é um Plano de Contas válido!', ['&Ok']);
        fraPlanoDeContasDebito.dbeCodCta.Field.Clear;
        Result := False;
      End

      Else If Not fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContasDebito.dbeCodCta.Text)) Then
      Begin
        fraPlanoDeContasDebito.dbeCodCta.Text := fStrZero(fraPlanoDeContasDebito.dbeCodCta.Text,7);

        pCarregaCentroDeCusto(fraPlanoDeContasDebito.dbeCodCta, fraPlanoDeContasDebito.edtDesCta, False);

        If blnBaixaOtimizada Then
        Begin
          If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok']);

            Result := False;
          End
          Else
          Begin
            If (qryTabela.State In [dsInsert]) or (strPlCtaDebOld <> fraPlanoDeContasDebito.dbeCodCta.Text) then
              Result := PlanoDeContasAtivo(fraPlanoDeContasDebito.dbeCodCta.Text,True);
          End;
        End;
      End

      Else
      Begin
        fraPlanoDeContasDebito.edtDesCta.Clear;
        fraPlanoDeContasDebito.dbeCodCta.Field.Clear;
      End;

    End

    Else If (Sender = fraPlanoDeContasCanc.dbeCodCta) Then
    Begin

      If (RightStr(fraPlanoDeContasCanc.dbeCodCta.Text, 3) = '000') And (blnBaixaOtimizada) Then
      Begin
        fMensagem('ATENÇÃO!', fraPlanoDeContasCanc.dbeCodCta.Text + ' não é um Plano de Contas válido!', ['&Ok']);
        fraPlanoDeContasCanc.dbeCodCta.Field.Clear;
        Result := False;
      End

      Else If Not fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContasCanc.dbeCodCta.Text)) Then
      Begin
        fraPlanoDeContasCanc.dbeCodCta.Text := fStrZero(fraPlanoDeContasCanc.dbeCodCta.Text,7);

        pCarregaCentroDeCusto(fraPlanoDeContasCanc.dbeCodCta, fraPlanoDeContasCanc.edtDesCta, True);

        If blnBaixaOtimizada Then
        Begin
          If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
          Begin
            If Not fCfgSis('USACTF', varBoolean) Then
              fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok'])
            Else
              fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado ou não está vinculado ao fornecedor!', ['&Ok']);

            Result := False;
          End
          Else
          Begin
            If (qryTabela.State In [dsInsert]) or (strPlCtaCancOld <> fraPlanoDeContasCanc.dbeCodCta.Text) then
              Result := PlanoDeContasAtivo(fraPlanoDeContasCanc.dbeCodCta.Text,True);
          End;
        End;
      End

      Else
      Begin
        fraPlanoDeContasCanc.edtDesCta.Clear;
        fraPlanoDeContasCanc.dbeCodCta.Field.Clear;
      End;

    End

    Else If (Sender = fraPlanoDeContasAnt.dbeCodCta) Then
    Begin

      If (RightStr(fraPlanoDeContasAnt.dbeCodCta.Text, 3) = '000') And (blnBaixaOtimizada) Then
      Begin
        fMensagem('ATENÇÃO!', fraPlanoDeContasAnt.dbeCodCta.Text + ' não é um Plano de Contas válido!', ['&Ok']);
        fraPlanoDeContasCanc.dbeCodCta.Field.Clear;
        Result := False;
      End

      Else If Not fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContasAnt.dbeCodCta.Text)) Then
      Begin
        fraPlanoDeContasAnt.dbeCodCta.Text := fStrZero(fraPlanoDeContasAnt.dbeCodCta.Text,7);

        pCarregaCentroDeCusto(fraPlanoDeContasAnt.dbeCodCta, fraPlanoDeContasAnt.edtDesCta, False);

        If blnBaixaOtimizada Then
        Begin
          If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok']);

            Result := False;
          End
          Else
          Begin
            If (qryTabela.State In [dsInsert]) or (strPlCtaAntOld <> fraPlanoDeContasAnt.dbeCodCta.Text) then
              Result := PlanoDeContasAtivo(fraPlanoDeContasAnt.dbeCodCta.Text,True);
          End;
        End;
      End

      Else
      Begin
        fraPlanoDeContasAnt.edtDesCta.Clear;
        fraPlanoDeContasAnt.dbeCodCta.Field.Clear;
      End;

    End

    Else If (Sender = fraPlanoDeContasFrete.dbeCodCta) Then
    Begin
      If grpFretes.Visible Then
      Begin
        If (RightStr(fraPlanoDeContasFrete.dbeCodCta.Text, 3) = '000') And (blnBaixaOtimizada) Then
        Begin
          fMensagem('ATENÇÃO!', fraPlanoDeContasFrete.dbeCodCta.Text + ' não é um Plano de Contas válido!', ['&Ok']);
          fraPlanoDeContasFrete.dbeCodCta.Field.Clear;
          Result := False;
        End

        Else If Not fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContasFrete.dbeCodCta.Text)) Then
        Begin
          fraPlanoDeContasFrete.dbeCodCta.Text := fStrZero(fraPlanoDeContasFrete.dbeCodCta.Text,7);

          pCarregaCentroDeCusto(fraPlanoDeContasFrete.dbeCodCta, fraPlanoDeContasFrete.edtDesCta, True);

          If blnBaixaOtimizada Then
          Begin
            If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
            Begin
              If Not fCfgSis('USACTF', varBoolean) Then
                fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok'])
              Else
                fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado ou não está vinculado ao fornecedor!', ['&Ok']);

              Result := False;
            End
            Else
            Begin
              If (qryTabela.State In [dsInsert]) or (strPlCtaFreteOld <> fraPlanoDeContasFrete.dbeCodCta.Text) then
                Result := PlanoDeContasAtivo(fraPlanoDeContasFrete.dbeCodCta.Text,True);
            End;
          End;
        End

        Else
        Begin
          fraPlanoDeContasFrete.edtDesCta.Clear;
          fraPlanoDeContasFrete.dbeCodCta.Field.Clear;
        End;

      End;

    End

    Else If (Sender = fraPlanoDeContasCupons.dbeCodCta) Then
    Begin
      If grpCupons.Visible Then
      Begin
        If RightStr(fraPlanoDeContasCupons.dbeCodCta.Text, 3) = '000' Then
        Begin
          fMensagem('ATENÇÃO!', fraPlanoDeContasCupons.dbeCodCta.Text + ' não é um Plano de Contas válido!', ['&Ok']);
          fraPlanoDeContasCupons.dbeCodCta.Field.Clear;
          Result := False;
        End

        Else If Not fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContasCupons.dbeCodCta.Text)) Then
        Begin
          fraPlanoDeContasCupons.dbeCodCta.Text := fStrZero(fraPlanoDeContasCupons.dbeCodCta.Text,7);

          pCarregaCentroDeCusto(fraPlanoDeContasCupons.dbeCodCta, fraPlanoDeContasCupons.edtDesCta, True);
          If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
          Begin
            If Not fCfgSis('USACTF', varBoolean) Then
              fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok'])
            Else
              fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado ou não está vinculado ao fornecedor!', ['&Ok']);

            Result := False;
          End;

        End

        Else
        Begin
          fraPlanoDeContasCupons.edtDesCta.Clear;
          fraPlanoDeContasCupons.dbeCodCta.Field.Clear;
        End;

      End;

    End

    Else If (Sender = dbeForTax) Then
    Begin

      If (fEmptyStr(dbeForTax.Text)) Then
      Begin
        edtForTax.Clear;
        dbeForTax.Field.Clear;
      End Else
      Begin
        pCarregaFornecedor;

        If blnBaixaOtimizada Then
        Begin
          If qryCadFor.FieldByName('FOR_CODFOR').IsNull Then
          Begin
            fMensagem('ATENÇÃO!','Esse fornecedor não está cadastrado!',['&OK']);
            Result := False;
          End;
        End;
      End;

    End
    Else If (Sender = dbeCnpj) Then
    Begin

      If Not fEmptyStr(dbeCnpj.Text) Then
      Begin
        Result := fValidaCnpjCpf('1', dbeCnpj.Text, False, True);

        If (Result) Then
        Begin
          qryAux := fCriaQuery;
          qryAux.Close;
          qryAux.SQL.Text := 'SELECT FOR_CODFOR FROM CADFOR WHERE FOR_C_G_C_ = :CGC';
          qryAux.ParamByName('CGC').AsString := dbeCnpj.Text;
          qryAux.Open;

          If qryAux.IsEmpty Then
          Begin
            fMensagem('ATENÇÃO!','Não existe fornecedor cadastrado com este CNPJ!',['&OK']);
            Result := False;
          End;

          FreeAndNil(qryAux);

//        If (Result) Then
//          Result := (Not fExisteCnpjCpf('CADCAR','CAR_CODCAR',dbeCodCar.Text,'CAR_C_G_C_',dbeCnpj.Text));
        End;
      End Else
      begin
        fMensagem('ATENÇÃO!','O campo CNPJ deve ser preenchido!',['&OK']);
        Result := False;
      end;
    End
    Else If (Sender = dbeEntSped) Then
    Begin

      If Not fValidoSimNao(dbeEntSped.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'No campo "Entrar no SPED" deve ser informado S ou N!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = dbeConCon) And (Not fCfgSis('UTICON', varBoolean)) Then
    Begin
      dbePlaNco.Field.Value := Null;
    End

    Else If ((Sender = fraCentroCustoC.dbeCodEve) or (Sender = fraCentroCustoTX.dbeCodEve) or (Sender = fraCentroCustoD.dbeCodEve)) then
      begin

        If blnBaixaOtimizada Then
        Begin
          if fEmptyStr(TDBEditFocus(sender).Text) and fCfgSis('CTPOBE', varBoolean) Then
          Begin
            SMensagem := '';
            if (Sender = fraCentroCustoC.dbeCodEve) And (Not fEmptyStr(dbePorBai.Text)) then
              SMensagem := 'O campo Centro de Custos do crédito deve ser preenchido.'
            else
            if (Sender = fraCentroCustoTX.dbeCodEve) And (Not fEmptyStr(dbePorTax.Text)) then
              SMensagem := 'O campo Centro de Custos da taxa deve ser preenchido.'
            else
            if (Sender = fraCentroCustoD.dbeCodEve) And (not fEmptyStr(dbePorBad.text)) then
              SMensagem := 'O campo Centro de Custos do débito deve ser preenchido.';

            if not fEmptyStr(SMensagem) then
            begin
              fMensagem('ATENÇÃO!', SMensagem, ['&Ok']);
              pSetFocus(Sender);
              Exit(False);
            end;
          End;
        End;

        if Sender = fraCentroCustoC.dbeCodEve then
          SEditFocus := fraCentroCustoC.edtDesEve
        else
        if Sender = fraCentroCustoTX.dbeCodEve then
          SEditFocus := fraCentroCustoTX.edtDesEve
        else
          SEditFocus := fraCentroCustoD.edtDesEve;

        If Not fEmptyStr(TDBEditFocus(Sender).Text) Then
        Begin
          SEditFocus.Text := fRetNomEvento(TDBEditFocus(Sender));

          If blnBaixaOtimizada Then
          Begin
            If fEmptyStr(SEditFocus.Text) Then
            Begin
              fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&Ok']);
              pSetFocus(Sender);
              Exit(False);
            End;

            If (Sender = fraCentroCustoD.dbeCodEve) and (Result) And (fEmptyStr(edtPorBad.Text)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Para utilizar o Centro de Custos de débito é necessário selecionar '+
                'Portador e Plano de Contas de débito!', ['&Ok']);
              Exit(False);
            End;
          End;
        End
        Else
        Begin
          SEditFocus.Clear;
          TDBEditFocus(sender).Field.Clear;
        End;

      end

    Else If (Sender = dbeTaxMin) Then
    Begin
      If StrToFloatDef(dbeTaxMin.Text,0) < 0 then
      begin
        fMensagem('ATENÇÃO!', 'Valor mínimo da taxa de administração deve ser maior ou igual à zero.', ['&Ok']);
        Result := False;
      end;

      If Not fEmptyStr(dbeTaxMin.Text) Then
        dbeTaxMin.Text := FloattoStrF(fStrToFloat(dbeTaxMin.Text), ffNumber, 12, 2);
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadCartoes.fValidaCamposNovaFormaCadCartaoTef(
  const AMensagem: String = ''): Boolean;
var
  LParamValidacao: TParamEntradaValidacao;
  LMensagem: String;
begin
  Result := True ;
  if not fCadastroCartaoParamAutTef then
    Exit ;

  if not fEmptyStr(AMensagem) then
  begin
    Result:= False;
    fMensagem('ATENÇÃO!',AMensagem, ['&Ok']);
    Exit;
  end;

  FillChar(LParamValidacao, Sizeof(TParamEntradaValidacao), #0);
  LParamValidacao.TipoPos := chkTipoPos.Checked;
  LParamValidacao.TipoTef := chkTipoTef.Checked;
  LParamValidacao.CodAdq := dbeCodAdq.text;
  LParamValidacao.NomAdq := edtNomAdq.text;
  LParamValidacao.TefCodAdqClisitef := DBETFTOPE.Field.AsString;
  LParamValidacao.TefCodBanClisitef := DBETFTRED.Field.AsString;
  LParamValidacao.TefCodAdqScope := DBETFRED2.Field.AsString;
  LParamValidacao.TefCodBanScope := DBETFBAN2.Field.AsString;
  LParamValidacao.Codban := dbeCodBan.Text;
  LParamValidacao.NomBan := edtNomBan.Text;

  if TUtilCadastroCartaoTef.fPossuiDadosInvalidos(LParamValidacao, LMensagem) then
  begin
    Result:= False;
    fMensagem('ATENÇÃO!',LMensagem, ['&Ok']);
    Exit;
  end;
end;

procedure TfrmCadCartoes.HabilitarArredondamento;
begin
  gpbArredondamento.Enabled := False;
  chkPriParcela.Enabled := False;
  chkUltParcela.Enabled := False;

  If qryTabela.State In [dsBrowse] Then
    Exit;

  gpbArredondamento.Enabled := True;
  chkPriParcela.Enabled := True;
  chkUltParcela.Enabled := True;

  If chkPriParcela.Checked Then
    chkUltParcela.Enabled := False;

  If chkUltParcela.Checked Then
    chkPriParcela.Enabled := False;
end;

procedure TfrmCadCartoes.HabilitarEquals;
begin
  grpExportacaoEquals.Enabled := False;

  If qryTabela.State In [dsBrowse] Then
    Exit;

  If Not grpExportacaoEquals.Visible Then
    Exit;

  grpExportacaoEquals.Enabled := True;
end;

procedure TfrmCadCartoes.HabilitarFornecedorFiscal;
begin
  lblFornecedorFiscal.Enabled := dbeEntSped.Text = 'S';
  dbeCodigoFornecedorFiscal.Enabled := (dbeEntSped.Text = 'S') And
                                       (qryTabela.State <> dsBrowse);
  edtNomeFornecedorFiscal.Enabled := (dbeEntSped.Text = 'S') And
                                     (qryTabela.State <> dsBrowse);
end;

procedure TfrmCadCartoes.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CAR_CODCAR');
  stlCampos.Add('CAR_DESCAR');
  stlCampos.Add('CAR_PERDES');
  stlCampos.Add('CAR_PERIOD');
  stlCampos.Add('CAR_SUGPAR');
  stlCampos.Add('CAR_MAXPAR');
  stlCampos.Add('CAR_CODEMP');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CAR_DESCAR');
  stlCamInd.Add('CAR_CODCAR');
  stlCamInd.Add('CAR_CODEMP');

  stlDesInd.Add('Operadora');
  stlDesInd.Add('Código');
  stlDesInd.Add('Empresa');
end;

procedure TfrmCadCartoes.pMostraCamposNovaFormaCadCartaoTef;
begin
  gbAdquirente.Visible := fCadastroCartaoParamAutTef ;
end;

procedure TfrmCadCartoes.pMostrarTipoDebito(const AblnVisivel: Boolean);
begin
  lbTipDeb.Visible := AblnVisivel ;
  dbeTipDeb.Visible := AblnVisivel ;

  if lbTipDeb.Visible then
  begin
    gbTefViaDLL.Height := FintHeightGbTefViaDLL ;
    gbTefTrocaArquivo.Height := FintHeightGbTefViaDLL ;
    gbDadosTef.Height := FintHeightGbDadosTef ;
    Self.Height := FintHeightForm ;
    lbCardSe.Top := FintTopLbCardSe ;
    dbeCardSe.Top := FintTopDbeCardSe ;
  end
  else
  begin
    dbeCardSe.Top := dbeTipDeb.Top ;
    lbCardSe.Top := lbTipDeb.Top ;
    gbTefViaDLL.Height := FintHeightGbTefViaDLL - 20;
    gbTefTrocaArquivo.Height := FintHeightGbTefViaDLL - 20;
    gbDadosTef.Height := FintHeightGbDadosTef - 16 ;
    Self.Height := FintHeightForm - 17 ;
  end ;

  gbLinkPagamentoBandeira.Top := gbDadosTef.Top + gbDadosTef.Height + 1 ;

end;

function TfrmCadCartoes.fMostrarTipoDebito: Boolean;
var
  LstrTefCit: String ;
begin
  LstrTefCit := fCfgSis('TEFCIT', varString) ;
  if LstrTefCit = OPCAO_CLISITEF then
  begin
    Result := (qryTabela.FieldByName('CAR_TFTRED').AsString = '00021') and
              (qryTabela.FieldByName('CAR_TFTBAN').AsString = '20085') ;
  end
  else // NCR
  begin
    Result := (qryTabela.FieldByName('CAR_TFRED2').AsString = '00099') and
              (qryTabela.FieldByName('CAR_TFBAN2').AsString = '00183') ;
  end ;
end;

function TfrmCadCartoes.fObjetoValidoParaAtualizarNovaFormaCadCartaoTef(
  ASenderObject: TWinControl): Boolean;
var
  LControle: TWinControl;
  LObjetosValidos: array of TWinControl;
begin
  LObjetosValidos:= [dbeCodAdq, dbeCodBan, dbeSugCPg, dbeMaxPar, dbeTipCar,
    chkTipoPos, chkTipoTef];

  Result:= False;

  for LControle in LObjetosValidos do
  begin
    if (LControle = ASenderObject) then
    begin
      Result:= True;
      Exit;
    end;
  end;
end;

procedure TfrmCadCartoes.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

  btnHeranca.Visible := fVerificaAcessoSistema('CARHERANCA', strLoginUsuarioLogado);

  btnHeranca.Enabled := True;

  qryConEmp := fCriaQuery(Self);

  strCampoEmp := EmptyStr;

  intParCar := IIF(fEmptyStr(fCfgSis('PARCAR')),
                   24,
                   fCfgSis('PARCAR', varInteger));

  If (blnUtiCon) Then
  Begin
    dbePlaNco.Visible := True;
    edtDesPlaNco.Visible := True;
    dbeConCon.Visible := False;
    lblDesPlaCon.Caption := 'Plano Contábil:';
    dbchkDesmembr.Visible := False;
    btnPlaNco.Visible := True;
  End
  Else
  Begin
    dbePlaNco.Visible := False;
    edtDesPlaNco.Visible := False;
    dbeConCon.Visible := True;
    lblDesPlaCon.Caption := 'Conta Contábil:';
    dbchkDesmembr.Visible := True;
    btnPlaNco.Visible := False;
  End;

  stlExclusoes := TStringList.Create;

  pHabiliatarOtimizadaPorEmpresa(False);
  HabilitarArredondamento;
end;

procedure TfrmCadCartoes.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, True, True) Then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCartoes.pCarregaEmpresa(dbeCodEmp: TDBEditFocus;
                                         edtDesEmp: TEditFocus);
Begin
  pPesquisaCadEmp(Nil, qryConEmp, dbeCodEmp.Text);
  edtDesEmp.Text := qryConEmp.FieldByName('EMP_NOMEMP').AsString;
End;

procedure TfrmCadCartoes.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadCartoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (Action <> caNone) Then
  Begin
    FreeAndNil(qryConEmp);

    If Assigned(cdsValidaConPor) Then
      FreeAndNil(cdsValidaConPor);

    If Assigned(cdsConPor) Then
      FreeAndNil(cdsConPor);

    If Assigned(stlExclusoes) Then
      FreeAndNil(stlExclusoes);
  End;
end;

procedure TfrmCadCartoes.btnPesquisaClick(Sender: TObject);
Var
  chrKey     : Char;
  arrCartoes : TConsultasArray;
begin
  {****************************}
  {* NOVA CONSULTA DE CARTOES *}
  {*************************DP*}
  chrKey := '/';
  fPesqCartao(Self, Nil, Nil, qryTabela, chrKey, arrCartoes,True, False, True, True, fCfgSis('EMPGER', VarString) = 'S');
  pCarregaDadosAdicionais;
  pCarregaPlanoDeContasPorEmpresa('CARNCO', dbeCodCar.Text, FcdsNCO);
  strUltCnpj := '-1';

  fraPlanoDeContas.dbeCodCta.Field.EditMask        := '99.99.999;0;_';
  fraPlanoDeContasDaBaixa.dbeCodCta.Field.EditMask := '99.99.999;0;_';
  fraPlanoDeContasDebito.dbeCodCta.Field.EditMask  := '99.99.999;0;_';
  fraPlanoDeContasAnt.dbeCodCta.Field.EditMask     := '99.99.999;0;_';
  fraPlanoDeContasCanc.dbeCodCta.Field.EditMask    := '99.99.999;0;_';
  fraPlanoDeContasFrete.dbeCodCta.Field.EditMask   := '99.99.999;0;_';
  fraPlanoDeContasCupons.dbeCodCta.Field.EditMask   := '99.99.999;0;_';

  btnHeranca.Enabled := True;
end;

procedure TfrmCadCartoes.btnPlaNcoClick(Sender: TObject);
begin
  inherited;
  pPlanoDeContasPorEmpresa(dbeCodCar.Text, 'CARNCO', qryTabela.FieldByName('CAR_PLANCO').AsString, qryTabela.State, FcdsNCO, True);
end;

procedure TfrmCadCartoes.CarregaFornecedorFiscal;
begin
  edtNomeFornecedorFiscal.Clear;
  If Not fEmptyStr(dbeCodigoFornecedorFiscal.Text) Then
    edtNomeFornecedorFiscal.Text := fCampoTabela('FOR_NOMFOR', 'CADFOR', ['FOR_CODFOR'], [dbeCodigoFornecedorFiscal.Text]);
end;

procedure TfrmCadCartoes.chkPriParcelaClick(Sender: TObject);
begin
  chkUltParcela.Enabled := True;

  If chkPriParcela.Checked Then
  Begin
    chkUltParcela.Checked := False;
    chkUltParcela.Enabled := False;
  End;
end;

procedure TfrmCadCartoes.chkTipoPosExit(Sender: TObject);
begin
  inherited;
  pAtualizaCamposNovaFormaCadCartaoTef(Sender as TWinControl) ;
end;

procedure TfrmCadCartoes.chkTipoTefClick(Sender: TObject);
begin
  inherited;

  If not(qryTabela.State In [dsInsert, dsEdit]) Then
    Exit;

  if TDBCheckBox(Sender).Checked then
    if not fValidaCamposNovaFormaCadCartaoTef then
      TDBCheckBox(Sender).Field.AsString := TDBCheckBox(Sender).ValueUnchecked;
end;

procedure TfrmCadCartoes.chkTipoTefExit(Sender: TObject);
begin
  inherited;
  pAtualizaCamposNovaFormaCadCartaoTef(Sender as TWinControl) ;
end;

procedure TfrmCadCartoes.chkUltParcelaClick(Sender: TObject);
begin
  chkPriParcela.Enabled := True;

  If chkUltParcela.Checked Then
  Begin
    chkPriParcela.Checked := False;
    chkPriParcela.Enabled := False;
  End;
end;

procedure TfrmCadCartoes.dbeCodPorKeyPress(dbeCodPor: TDBEditFocus;
                                           edtDesPor: TEditFocus; var Key: Char);
  Var
    arrSel : TConsultasArray;

begin

  If fPesqPortador(conSimples,
                   Self,
                   dbeCodPor,
                   edtDesPor,
                   qryCadPor,
                   Key,
                   arrSel,
                   True,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   edtCodEmpresa.Text) Then
  Begin
    If fValidaCampos(dbeCodPor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadCartoes.dbeCodRedKeyPress(Sender: TObject; var Key: Char);
var
  arrCre: TConsultasArray;
begin
  If fPesqCartaoCredenciadora(Self, dbeCodRed, edtDesCredenciadora, Nil, Key, arrCre) Then
  Begin
    If fValidaCampos(dbeCodRed, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCartoes.pCarregaPlanoContabil(const blnBuscaPorChave: Boolean=False);
begin
  If (edtDesPlaNco.Visible) Then
  begin
    edtDesPlaNco.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePlaNco.Text)], False);
  end;
end;

procedure TfrmCadCartoes.pCarregaPortador(dbeCodPor: TDBEditFocus;
                                          edtDesPor: TEditFocus);
begin
  pPesquisaCadPor(Nil, qryCadPor, dbeCodPor.Text);
  edtDesPor.Text := IIF(fEmptyStr(dbeCodPor.Text), '', qryCadPor.FieldByName('POR_NOMPOR').AsString);
end;

procedure TfrmCadCartoes.pDesabilitaCamposNovaFormaCadCartaoTef;
var
  LblnNovaFormaCadCartaoTef: Boolean ;
begin
  LblnNovaFormaCadCartaoTef := fCadastroCartaoParamAutTef ;
  if not LblnNovaFormaCadCartaoTef then
    Exit ;

  pHabilitaDesCar(fSomentePosSelecionado) ;
  DBETFTOPE.Enabled := not LblnNovaFormaCadCartaoTef ;
  DBETFTOPE.Color := 16768952 ;
  DBETFTOPE.NormalColor  := 16768952 ;
  DBETFTRED.Enabled := not LblnNovaFormaCadCartaoTef ;
  DBETFTRED.Color := 16768952 ;
  DBETFTRED.NormalColor  := 16768952 ;
  DBETFRED2.Enabled := not LblnNovaFormaCadCartaoTef ;
  DBETFRED2.Color := 16768952 ;
  DBETFRED2.NormalColor  := 16768952 ;
  DBETFBAN2.Enabled := not LblnNovaFormaCadCartaoTef ;
  DBETFBAN2.Color := 16768952 ;
  DBETFBAN2.NormalColor  := 16768952 ;
  pSetFocus(dbeStatus) ;
end;

procedure TfrmCadCartoes.pgcDadosChange(Sender: TObject);
begin
  inherited;
  grpFretes.Visible := dbeMarketPlace.Text = 'S';
  grdDadosOtimizadaDadosCON_CTAFRE.Visible := dbeMarketPlace.Text = 'S';

  grpCupons.Visible := dbeMarketPlace.Text = 'S';
  grdDadosOtimizadaDadosCON_CTACUP.Visible := dbeMarketPlace.Text = 'S';
  If grpCupons.Visible Then
  Begin
    grpCupons.Visible := FConfiguracaoMERANA;
    grdDadosOtimizadaDadosCON_CTACUP.Visible := FConfiguracaoMERANA;
  End;

  BtnAlteracaoGlobal.Enabled :=
    (pgcDados.ActivePage = tbsGeral) or
    (pgcDados.ActivePage = tsBaixaOtimizada) or
    (pgcDados.ActivePage = tabBaixaOtimizadaPorEmpresa);
end;

procedure TfrmCadCartoes.dbePlaNcoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fEntraCons(Key) Then
  Begin
    TStringField(qryTabela.FieldByName('CAR_PLANCO')).EditMask := '';
    If fPesqPlanoContabil(Self, dbePlaNco, Nil, Nil, Key, arrSel) Then
    Begin
      If fValidaCampos(dbePlaNco, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
    TStringField(qryTabela.FieldByName('CAR_PLANCO')).EditMask := fMskCon;
  End;
end;

function TfrmCadCartoes.dbePorBadChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadPor(Key);
end;

procedure TfrmCadCartoes.dbePorBadKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  dbeCodPorKeyPress(dbePorBad, edtPorBad, Key);
end;

function TfrmCadCartoes.dbePorBaiChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadPor(Key);
end;

procedure TfrmCadCartoes.dbePorBaiKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  dbeCodPorKeyPress(dbePorBai, edtPorBai, Key);
end;

function TfrmCadCartoes.dbePorTaxChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadPor(Key);
end;

procedure TfrmCadCartoes.dbePorTaxKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  dbeCodPorKeyPress(dbePorTax, edtPorTax, Key);
end;

procedure TfrmCadCartoes.DBETFBAN2Enter(Sender: TObject);
begin
  inherited;
  pShowHint(DBETFBAN2, lbCodBandeira.Caption);
end;

procedure TfrmCadCartoes.DBETFRED2Enter(Sender: TObject);
begin
  inherited;
  pShowHint(DBETFRED2, lbCodOperadora.Caption);
end;

procedure TfrmCadCartoes.DBETFTOPEEnter(Sender: TObject);
begin
  inherited;
  pShowHint(DBETFTOPE, lbCodOperadora.Caption);
end;

procedure TfrmCadCartoes.DBETFTREDEnter(Sender: TObject);
begin
  inherited;
  pShowHint(DBETFTRED, lbCodBandeira.Caption);
end;

procedure TfrmCadCartoes.dbeTipTaxExit(Sender: TObject);
begin
  inherited;
  If Not qryTabela.Active THen
    Exit;

  If dbeTipTax.Text <> 'V' Then
    TFloatField(qryTabela.FieldByName('CAR_PERDES')).DisplayFormat := ',0.000000'
  Else
    TFloatField(qryTabela.FieldByName('CAR_PERDES')).DisplayFormat := ',0.00';
end;

procedure TfrmCadCartoes.dbeTipTraEnter(Sender: TObject);
begin
  inherited;
  pShowHint(dbeTipTra,'Tipo da Transação');
end;

procedure TfrmCadCartoes.dtsCadCarDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  dbeTipCar.ItemIndex := -1;
  If qryTabela.FieldByName('CAR_TIPCAR').AsString = 'C' Then
    dbeTipCar.ItemIndex := 0
  Else If qryTabela.FieldByName('CAR_TIPCAR').AsString = 'D' Then
    dbeTipCar.ItemIndex := 1;

  dbeTipDeb.ItemIndex := 0 ;
  If qryTabela.FieldByName('CAR_TIPDEB').AsString = '0' Then
    dbeTipDeb.ItemIndex := 0
  Else If qryTabela.FieldByName('CAR_TIPDEB').AsString = '1' Then
    dbeTipDeb.ItemIndex := 1;

  pMostrarTipoDebito(fMostrarTipoDebito) ;
end;

procedure TfrmCadCartoes.dtsCadCarStateChange(Sender: TObject);
begin
  inherited;
  btnDesmembr.Enabled := dtsCadCar.State in [dsEdit, dsInsert];
end;

procedure TfrmCadCartoes.pCarregaCentroDeCusto(dbeCodCta: TDBEditFocus;
                                               edtDesCta: TEditFocus;
                                               AValidaFornecedor: Boolean);
begin
  If (Not fCfgSis('USACTF', varBoolean)) Or (Not AValidaFornecedor) Then
    pPesquisaCadCta(qryCadCta, qryCadCta, dbeCodCta.Text)
  Else
    pPesquisaCadCta(qryCadCta, qryCadCta, dbeCodCta.Text, True, dbeForTax.Text);



  edtDesCta.Text := IIF(fEmptyStr(dbeCodCta.Text), '', qryCadCta.FieldByName('CTA_DESCTA').AsString);
end;

function TfrmCadCartoes.dbeCtaAjuChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadCta(Key);
end;

function TfrmCadCartoes.dbeCtaAntChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadCta(Key);
end;

function TfrmCadCartoes.dbeCtaBadChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadCta(Key);
end;

function TfrmCadCartoes.dbeCtaCarChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadCta(Key);
end;

procedure TfrmCadCartoes.dbeCtaFreteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCentroCusto : TConsultasArray;
begin
  inherited;
  If fPesqCentroCusto(Self, fraPlanoDeContasFrete.dbeCodCta, fraPlanoDeContasFrete.edtDesCta, Nil, Key, arrCentroCusto) Then
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      Self.SelectNext(ActiveControl, True, True);
end;

function TfrmCadCartoes.dbeCtaTaxChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadCta(Key);
end;

procedure TfrmCadCartoes.dbeEntSpedChange(Sender: TObject);
begin
  inherited;
  HabilitarFornecedorFiscal;
end;

function TfrmCadCartoes.dbeForTaxChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadFor(Key);
end;

procedure TfrmCadCartoes.dbeForTaxKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, dbeForTax, edtForTax, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(dbeForTax, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCartoes.pCarregaEvento(dbeCodEve: TDBEditFocus;
                                        edtDesEve: TEditFocus);
begin
  pPesquisaCadEve(qryCadEve, qryCadEve, dbeCodEve.Text);

  edtDesEve.Text := IIF(fEmptyStr(dbeCodEve.Text), '', qryCadEve.FieldByName('EVE_DESEVE').AsString);
end;

procedure TfrmCadCartoes.dbeNomBanEnter(Sender: TObject);
begin
  inherited;
  pShowHint(dbeNomBan,'Nome da Bandeira');
end;

procedure TfrmCadCartoes.dbeNomRedEnter(Sender: TObject);
begin
  inherited;
  pShowHint(dbeNomRed,'Nome da Operadora');
end;

procedure TfrmCadCartoes.dbeNomRedExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmCadCartoes.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryCadFor,  qryCadFor, dbeForTax.Text);
  edtForTax.Text := IIF(fEmptyStr(dbeForTax.Text), '', qryCadFor.FieldByName('FOR_NOMFOR').AsString);
end;

procedure TfrmCadCartoes.pCarregaDadosAdicionais;
Begin
  pCarregaEmpresa(edtCodEmpresa, edtDesEmpresa);
  pCarregaFornecedor;
  CarregaFornecedorFiscal;
  pCarregaPortador(dbePorBai, edtPorBai);
  pCarregaPortador(dbePorTax, edtPorTax);
  pCarregaPortador(dbePorBad, edtPorBad);
  pCarregaCentroDeCusto(fraPlanoDeContas.dbeCodCta, fraPlanoDeContas.edtDesCta, False);
  pCarregaCentroDeCusto(fraPlanoDeContasDaBaixa.dbeCodCta, fraPlanoDeContasDaBaixa.edtDesCta, True);
  pCarregaCentroDeCusto(fraPlanoDeContasDebito.dbeCodCta, fraPlanoDeContasDebito.edtDesCta, False);
  pCarregaCentroDeCusto(fraPlanoDeContasCanc.dbeCodCta, fraPlanoDeContasCanc.edtDesCta, True);
  pCarregaCentroDeCusto(fraPlanoDeContasAnt.dbeCodCta, fraPlanoDeContasAnt.edtDesCta, False);
  pCarregaCentroDeCusto(fraPlanoDeContasFrete.dbeCodCta, fraPlanoDeContasFrete.edtDesCta, True);
  pCarregaCentroDeCusto(fraPlanoDeContasCupons.dbeCodCta, fraPlanoDeContasCupons.edtDesCta, True);
  pCarregaEvento(fraCentroCustoD.dbeCodEve, fraCentroCustoD.edtDesEve);
  pCarregaEvento(fraCentroCustoC.dbeCodEve, fraCentroCustoC.edtDesEve);
  pCarregaEvento(fraCentroCustoTX.dbeCodEve, fraCentroCustoTX.edtDesEve);

  pCarregaDadosPorEmpresa;
  
  pCarregaPlanoContabil;

  edtDesCredenciadora.Text := fRetNomCredenciadora(dbeCodRed.Text);
  edtNomBan.Text := fRetNomBandeira(dbeCodBan.Text);
  edtNomAdq.Text := fRetNomAdquirenteCartao(dbeCodAdq.Text);
  pHabilitaDesCar(fSomentePosSelecionado, True) ;

  btnAlterar.Enabled := fVerificaAcessoCartao(dbeCodCar.Text);
  btnExcluir.Enabled := btnAlterar.Enabled;

  grpFretes.Visible := dbeMarketPlace.Text = 'S';
  grdDadosOtimizadaDadosCON_CTAFRE.Visible := dbeMarketPlace.Text = 'S';

  grpCupons.Visible := dbeMarketPlace.Text = 'S';
    grdDadosOtimizadaDadosCON_CTACUP.Visible := dbeMarketPlace.Text = 'S';
    If grpCupons.Visible Then
    Begin
      grpCupons.Visible := FConfiguracaoMERANA;
      grdDadosOtimizadaDadosCON_CTACUP.Visible := FConfiguracaoMERANA;
    End;

  HabilitarEquals;
  HabilitarArredondamento;

  If dbeTipTax.Text <> 'V' Then
    TFloatField(qryTabela.FieldByName('CAR_PERDES')).DisplayFormat := ',0.000000'
  Else
    TFloatField(qryTabela.FieldByName('CAR_PERDES')).DisplayFormat := ',0.00';
End;

procedure TfrmCadCartoes.pCarregaDadosPorEmpresa;
  Var
    qryConsulta: TUniQuery;
begin
  If Assigned(cdsConPor) Then
    FreeAndNil(cdsConPor);

  Try
    qryConsulta := fCriarQuery(fRetSQLConCar);
    qryConsulta.Open;
    cdsConPor := fCriaClientDatset(qryConsulta);
    cdsConPor.Open;

    dtsConPor.DataSet  := cdsConPor;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmCadCartoes.btnAlterarDadosEmpresaClick(Sender: TObject);
  Var
    frmCadCartoesBaixaOtimizada: TfrmCadCartoesBaixaOtimizada;
begin
  inherited;
  If cdsConPor.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário selecionar um registro para utilizar essa função!', ['&OK']);
    Exit;
  End;

  cdsConPor.Edit;

  pCriarFormularios(TfrmCadCartoesBaixaOtimizada, frmCadCartoesBaixaOtimizada);
  frmCadCartoesBaixaOtimizada.pCarregaEmpresa;
  frmCadCartoesBaixaOtimizada.dtsConPor.DataSet := cdsConPor;
  frmCadCartoesBaixaOtimizada.cdsValidaConPor   := cdsValidaConPor;
  frmCadCartoesBaixaOtimizada.ExibeCampoFrete   := grpFretes.Visible;
  frmCadCartoesBaixaOtimizada.ExibeCampoCupom   := grpCupons.Visible;
  frmCadCartoesBaixaOtimizada.ShowModal;
  FreeAndNil(frmCadCartoesBaixaOtimizada);

  pSetFocus(grdDadosOtimizada);
end;

procedure TfrmCadCartoes.pGravaDadosBaixaOtimizadaPorEmpresa;
  Var
    qryConPor: TUniQuery;
    objCampo : TField;

    strAutoIncrem: String;
begin
  Try
    qryConPor := fCriaQuery;

    //Exclusões
    qryConPor.SQL.Text := 'DELETE FROM CONPOR WHERE AUTOINCREM=:AUTOINC';
    For strAutoIncrem In stlExclusoes Do
    Begin
      qryConPor.ParamByName('AUTOINC').AsString := strAutoIncrem;
      qryConPor.ExecSQL;
    End;

    //Inclusões/Alterações
    qryConPor.SQL.Text := 'REPLACE INTO CONPOR (AUTOINCREM, CON_CODCAR, CON_CODEMP, CON_DTACAD, CON_CODOPE, CON_PORCRE, ' +
                          ' CON_PORTAX, CON_PORDEB, CON_CTACRE, CON_CTATAX, CON_CTADEB,             ' +
                          ' CON_CTAAJU, CON_CTAANT, CON_EVECRE, CON_EVETAX, CON_EVEDEB,             ' +
                          ' CON_FORTAX, CON_CTAFRE, CON_CTACUP) VALUES                              ' +
                          ' (:AUTOINCREM, :CON_CODCAR, :CON_CODEMP, :CON_DTACAD, :CON_CODOPE, :CON_PORCRE, ' +
                          ' :CON_PORTAX, :CON_PORDEB, :CON_CTACRE, :CON_CTATAX, :CON_CTADEB,        ' +
                          ' :CON_CTAAJU, :CON_CTAANT, :CON_EVECRE, :CON_EVETAX, :CON_EVEDEB,        ' +
                          ' :CON_FORTAX, :CON_CTAFRE, :CON_CTACUP)                                  ';

    cdsConPor.First;
    While Not cdsConPor.Eof Do
    Begin
      For objCampo In cdsConPor.Fields Do
      Begin
        If qryConPor.Params.FindParam(objCampo.FieldName) = Nil Then
          Continue;

        qryConPor.ParamByName(objCampo.FieldName).Value := Null;
        If (cdsConPor.FieldByName(objCampo.FieldName).DataType = ftDate) Then
          qryConPor.ParamByName(objCampo.FieldName).AsDateTime := objCampo.AsDateTime

        Else If Not cdsConPor.FieldByName(objCampo.FieldName).AsString.IsEmpty Then
          qryConPor.ParamByName(objCampo.FieldName).AsString := objCampo.AsString;
      End;

      qryConPor.ExecSQL;

      cdsConPor.Next;
    End;

    FreeAndNil(qryConPor);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TfrmCadCartoes.pGravaDadosBaixaOtimizadaPorEmpresa_Heranca(strCodCartao : String);
  Var
    qryConPor: TUniQuery;
    objCampo : TField;

begin
  Try
    qryConPor := fCriaQuery;

    qryConPor.SQL.Text := ' INSERT INTO CONPOR (AUTOINCREM, CON_CODCAR, CON_CODEMP, CON_DTACAD, CON_CODOPE, CON_PORCRE, ' +
                          ' CON_PORTAX, CON_PORDEB, CON_CTACRE, CON_CTATAX, CON_CTADEB,         ' +
                          ' CON_CTAAJU, CON_CTAANT, CON_EVECRE, CON_EVETAX, CON_EVEDEB,         ' +
                          ' CON_FORTAX, CON_CTAFRE, CON_CTACUP) VALUES                          ' +
                          ' (:AUTOINCREM, :CON_CODCAR, :CON_CODEMP, :CON_DTACAD, :CON_CODOPE, :CON_PORCRE,                ' +
                          ' :CON_PORTAX, :CON_PORDEB, :CON_CTACRE, :CON_CTATAX, :CON_CTADEB,    ' +
                          ' :CON_CTAAJU, :CON_CTAANT, :CON_EVECRE, :CON_EVETAX, :CON_EVEDEB,    ' +
                          ' :CON_FORTAX, :CON_CTAFRE, :CON_CTACUP)                              ';

    cdsConPorHerda.First;
    While Not cdsConPorHerda.Eof Do
    Begin
      For objCampo In cdsConPorHerda.Fields Do
      Begin
        If qryConPor.Params.FindParam(objCampo.FieldName) = Nil Then
          Continue;

        qryConPor.ParamByName(objCampo.FieldName).Value := Null;

        If (objCampo.FieldName = 'AUTOINCREM') Then
           qryConPor.ParamByName(objCampo.FieldName).AsString := fRetAutoIncrem('CONPOR', VS_strCodEmp)
        Else
        If (objCampo.FieldName = 'CON_CODCAR') Then
           qryConPor.ParamByName(objCampo.FieldName).AsString := strCodCartao
        Else
        Begin
           If Not cdsConPorHerda.FieldByName(objCampo.FieldName).AsString.IsEmpty Then
              qryConPor.ParamByName(objCampo.FieldName).AsString := objCampo.AsString;
        End;

      End;

      qryConPor.ExecSQL;

      cdsConPorHerda.Next;
    End;

    If Assigned(cdsConPorHerda) Then
       FreeAndNil(cdsConPorHerda);

    FreeAndNil(qryConPor);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TfrmCadCartoes.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaDadosAdicionais;
  pCarregaPlanoDeContasPorEmpresa('CARNCO', dbeCodCar.Text, FcdsNCO);
  pHideHint;

  pHabiliatarOtimizadaPorEmpresa(False);
  HabilitarEquals;
  HabilitarArredondamento;

  blnCriouHeranca := False;

  btnHeranca.Enabled := True;

  stlExclusoes.Clear;
end;

procedure TfrmCadCartoes.btnCopiarDadosEmpresaClick(Sender: TObject);
  Var
    frmCadCartoesBaixaOtimizada: TfrmCadCartoesBaixaOtimizada;
begin
  inherited;
  If cdsConPor.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário selecionar um registro para utilizar essa função!', ['&OK']);
    Exit;
  End;

  cdsValidaConPor.Data := cdsConPor.Data;
  cdsValidaConPor.Locate('AUTOINCREM', cdsConPor.FieldByName('AUTOINCREM').AsString, []);

  cdsConPor.Last;
  cdsConPor.Append;

  cdsConPor.FieldByName('CON_CODCAR').Value := cdsValidaConPor.FieldByName('CON_CODCAR').Value;
  cdsConPor.FieldByName('CON_PORCRE').Value := cdsValidaConPor.FieldByName('CON_PORCRE').Value;
  cdsConPor.FieldByName('CON_PORTAX').Value := cdsValidaConPor.FieldByName('CON_PORTAX').Value;
  cdsConPor.FieldByName('CON_PORDEB').Value := cdsValidaConPor.FieldByName('CON_PORDEB').Value;
  cdsConPor.FieldByName('CON_CTACRE').Value := cdsValidaConPor.FieldByName('CON_CTACRE').Value;
  cdsConPor.FieldByName('CON_CTATAX').Value := cdsValidaConPor.FieldByName('CON_CTATAX').Value;
  cdsConPor.FieldByName('CON_CTADEB').Value := cdsValidaConPor.FieldByName('CON_CTADEB').Value;
  cdsConPor.FieldByName('CON_CTAAJU').Value := cdsValidaConPor.FieldByName('CON_CTAAJU').Value;
  cdsConPor.FieldByName('CON_CTAANT').Value := cdsValidaConPor.FieldByName('CON_CTAANT').Value;
  cdsConPor.FieldByName('CON_EVECRE').Value := cdsValidaConPor.FieldByName('CON_EVECRE').Value;
  cdsConPor.FieldByName('CON_EVETAX').Value := cdsValidaConPor.FieldByName('CON_EVETAX').Value;
  cdsConPor.FieldByName('CON_EVEDEB').Value := cdsValidaConPor.FieldByName('CON_EVEDEB').Value;
  cdsConPor.FieldByName('CON_FORTAX').Value := cdsValidaConPor.FieldByName('CON_FORTAX').Value;
  cdsConPor.FieldByName('CON_CTAFRE').Value := cdsValidaConPor.FieldByName('CON_CTAFRE').Value;

  pCriarFormularios(TfrmCadCartoesBaixaOtimizada, frmCadCartoesBaixaOtimizada);
  frmCadCartoesBaixaOtimizada.pCarregaEmpresa;
  frmCadCartoesBaixaOtimizada.dtsConPor.DataSet := cdsConPor;
  frmCadCartoesBaixaOtimizada.cdsValidaConPor   := cdsValidaConPor;
  frmCadCartoesBaixaOtimizada.ExibeCampoFrete   := grpFretes.Visible;
  frmCadCartoesBaixaOtimizada.ExibeCampoCupom   := grpCupons.Visible;
  frmCadCartoesBaixaOtimizada.ShowModal;
  FreeAndNil(frmCadCartoesBaixaOtimizada);

  pSetFocus(grdDadosOtimizada);
end;

procedure TfrmCadCartoes.btnDesmembrClick(Sender: TObject);
begin
  inherited;
  pCriarFormularios(TfrmDesmCarEmpCContabil, frmDesmCarEmpCContabil);
  Try
    frmDesmCarEmpCContabil.strCodCar := dbeCodCar.Text;
    frmDesmCarEmpCContabil.ShowModal;

    Application.ProcessMessages;
  Finally
    frmDesmCarEmpCContabil.Free;
  End;
end;

procedure TfrmCadCartoes.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  Try
    inherited;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro('Ocorreu um erro ao excluir o cartão. Erro gerado: ' + E.Message, '[TfrmCadCartoes.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pCarregaDadosAdicionais;
  pCarregaPlanoDeContasPorEmpresa('CARNCO', dbeCodCar.Text, FcdsNCO);
end;

procedure TfrmCadCartoes.btnExcluirDadosEmpresaClick(Sender: TObject);
begin
  inherited;
  If cdsConPor.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário selecionar um registro para utilizar essa função!', ['&OK']);
    Exit;
  End;

  If (fMensagem('ATENÇÃO', 'Tem certeza que deseja excluir o registro selecionado?', ['&Sim', '&Não'], 1) = 2) Then
    Exit;

  If cdsConPor.FieldByName('INCLUIDO').AsString <> 'S' Then
    stlExclusoes.Add(cdsConPor.FieldByName('AUTOINCREM').AsString);

  cdsConPor.Delete;

  pSetFocus(grdDadosOtimizada);
end;

procedure TfrmCadCartoes.btnGravarClick(Sender: TObject);
  Var
    strCfg_PORPGR: String;
    strCfg_CTAGCP: String;
begin

  blnImplementouAsValidacoesBotaoGravarPai := True;
  If (dbeStatus.Text = 'S') Then
  Begin
    If (Not fValidacoesBotaoGravarPai) Then
      Exit;

    if not fVerificarPlanoDeContasPorEmpresa(dbeCodCar.Text, 'CARNCO', dbePlaNco.Text, FcdsNCO) then
    begin
      exit ;
    end;

    if not fValidaCamposNovaFormaCadCartaoTef then
      Exit ;

    pHideHint;

    If blnBaixaOtimizada Then
    Begin
      If (Not fEmptyStr(dbePorBai.Text)) Or (Not fEmptyStr(dbePorTax.Text)) Or
         (Not fEmptyStr(fraPlanoDeContasDaBaixa.dbeCodCta.Text)) Or (Not fEmptyStr(fraPlanoDeContas.dbeCodCta.Text)) Or
         (Not fEmptyStr(fraPlanoDeContasDebito.dbeCodCta.Text))  Or (Not fEmptyStr(dbePorBad.Text)) Then
      Begin
        strCfg_PORPGR := fCfgSis('PORPGR');
        strCfg_CTAGCP := fCfgSis('CTAGCP');

        If (Not fEmptyStr(strCfg_PORPGR)) Then
        Begin

          If ((Not fEmptyStr(dbePorBai.Text)) And (dbePorBai.Text = strCfg_PORPGR)) Or
             ((Not fEmptyStr(dbePorTax.Text)) And (dbePorTax.Text = strCfg_PORPGR)) Or
             ((Not fEmptyStr(dbePorBad.Text)) And (dbePorBad.Text = strCfg_PORPGR)) Then
          Begin
            pMensagemOk('Portador ' + strCfg_PORPGR + ' não permitido, pois está configurado para baixa de Contas a Pagar no resumo de caixa.');

            If ((Not fEmptyStr(dbePorBai.Text)) And (dbePorBai.Text = strCfg_PORPGR)) Then
              pSetFocus(dbePorBai)

            Else If ((Not fEmptyStr(dbePorTax.Text)) And (dbePorTax.Text = strCfg_PORPGR)) Then
              pSetFocus(dbePorTax)

            Else If ((Not fEmptyStr(dbePorBad.Text)) And (dbePorBad.Text = strCfg_PORPGR)) Then
              pSetFocus(dbePorBad);

            Exit;
          End;

        End;

        If (Not fEmptyStr(strCfg_CTAGCP)) Then
        Begin

          If ((Not fEmptyStr(fraPlanoDeContas.dbeCodCta.Text))        And (fraPlanoDeContas.dbeCodCta.Text = strCfg_CTAGCP)) Or
             ((Not fEmptyStr(fraPlanoDeContasDaBaixa.dbeCodCta.Text)) And (fraPlanoDeContasDaBaixa.dbeCodCta.Text = strCfg_CTAGCP)) Or
             ((Not fEmptyStr(fraPlanoDeContasDebito.dbeCodCta.Text))  And (fraPlanoDeContasDebito.dbeCodCta.Text = strCfg_CTAGCP)) Then
          Begin
            pMensagemOk('Plano de Contas ' + strCfg_CTAGCP + ' não permitido, pois está configurado para baixa de Contas a Pagar no resumo de caixa.');

            If ((Not fEmptyStr(fraPlanoDeContas.dbeCodCta.Text)) And (fraPlanoDeContas.dbeCodCta.Text = strCfg_CTAGCP)) Then
              pSetFocus(fraPlanoDeContas.dbeCodCta)

            Else If ((Not fEmptyStr(fraPlanoDeContasDaBaixa.dbeCodCta.Text)) And (fraPlanoDeContasDaBaixa.dbeCodCta.Text = strCfg_CTAGCP)) Then
              pSetFocus(fraPlanoDeContasDaBaixa.dbeCodCta)

            Else If ((Not fEmptyStr(fraPlanoDeContasDebito.dbeCodCta.Text)) And (fraPlanoDeContasDebito.dbeCodCta.Text = strCfg_CTAGCP)) Then
              pSetFocus(fraPlanoDeContasDebito.dbeCodCta);

            Exit;
          End;

        End;
      End;
    End;

    if fEmptyStr(dbeCnpj.Text) then
    begin
      pMensagemOk('Obrigatório o preenchimento do campo CNPJ.');
      pSetFocus(dbeCnpj);
      Exit;
    end;

  End;

  If fEmptyStr(dbePorBai.Text) Then
    dbePorBai.Field.Clear;

  If fEmptyStr(dbePorTax.Text) Then
    dbePorTax.Field.Clear;

  If fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.dbeCodCta.Text)) Then
    fraPlanoDeContas.dbeCodCta.Field.Clear;

  If fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContasDaBaixa.dbeCodCta.Text)) Then
    fraPlanoDeContasDaBaixa.dbeCodCta.Field.Clear;

  If fEmptyStr(dbeForTax.Text) Then
    dbeForTax.Field.Clear;

  If fEmptyStr(dbePorBad.Text) Then
    dbePorBad.Field.Clear;

  If fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContasDebito.dbeCodCta.Text)) Then
    fraPlanoDeContasDebito.dbeCodCta.Field.Clear;

  If fEmptyStr(edtCodEmpresa.Text) Then
    dtsCadCar.DataSet.FieldByName('CAR_CODEMP').Value := Null;

  qryTabela.FieldByName('CAR_DESMEM').AsString  := IIF(dbchkDesmembr.Checked , 'S', 'N');
  qryTabela.FieldByName('CAR_ARRPAR').AsString  := IIF(chkPriParcela.Checked , 'P', IIF(chkUltParcela.Checked, 'U', 'N'));
  qryTabela.FieldByName('CAR_TIPTEF').AsString := IIF(chkTipoTef.Checked , 'S', 'N');
  qryTabela.FieldByName('CAR_TIPPOS').AsString := IIF(chkTipoPos.Checked , 'S', 'N');

  If fTiraCaracEspeciais(dbePlanco.Field.AsString) = '' Then
    dbePlanco.Field.Clear;

  if fEmptyStr(fraCentroCustoC.dbeCodEve.Text) then
    fraCentroCustoC.dbeCodEve.Field.Clear;

  if fEmptyStr(fraCentroCustoTX.dbeCodEve.Text) then
    fraCentroCustoTX.dbeCodEve.Field.Clear;

  If MatchStr(qryTabela.FieldByName('CAR_TIPTAX').AsString, ['p', 'v']) Then
    qryTabela.FieldByName('CAR_TIPTAX').AsString := qryTabela.FieldByName('CAR_TIPTAX').AsString.ToUpper;

  if fEmptyStr(dbeCodigoFornecedorFiscal.Text) Or (dbeEntSped.Text <> 'S') then
    qryTabela.FieldByName('CAR_FORFIS').Value := Null;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  Try
    inherited;
    pGravaDadosBaixaOtimizadaPorEmpresa;

    // Verifica se o registro foi gerado atraves de uma herança
    If blnCriouHeranca Then
       pGravaDadosBaixaOtimizadaPorEmpresa_Heranca(dbeCodCar.Text);

    blnCriouHeranca := False;

    if blnGravou then
      pSalvaPlanoDeContasPorEmpresa('CARNCO', dbeCodCar.Text, FcdsNCO) ;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro('Ocorreu um erro ao gravar o cartão. Erro gerado: ' + E.Message, '[TfrmCadCartoes.btnGravarClick]');
    End;

  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  pCarregaDadosAdicionais;

  stlExclusoes.Clear;

  btnHeranca.Enabled := True;

  pHabiliatarOtimizadaPorEmpresa(False);
end;

procedure TfrmCadCartoes.BtnHerancaClick(Sender: TObject);
Var
    qryConPor    : TUniQuery;
    StrCodCartao : String;
    strSql : String;
begin
  inherited;

  If Not blnBaixaOtimizada Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é possível utilizar essa função, pois a CFG_BAIOTI está igual a "Não"!', ['&Ok']);
    exit;
  End;

  if fEmptyStr(dbeCodCar.Text) then
  begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar um cartão para gerar a herança!', ['&Ok']);
    exit;
  end;

  // Verifica se esta vinculado a uma empresa;
  If fEmptyStr(edtCodEmpresa.Text) Then
  Begin
     fMensagem('ATENÇÃO', 'Apenas é possivel a herança quando o cartão está vinculado a uma empresa!', ['&Ok']);
     Exit;
  End;

  StrCodCartao := dbeCodCar.Text;

  strSql := ' SELECT * FROM CONPOR WHERE CON_CODCAR = ' + QuotedStr(strCodCartao);

  // Copia os dados do cartão atual
  cdsHerdaCad    := fCriaClientDatset(qryTabela);

  // Copia os dados por empresa
  cdsConPorHerda := TUniClientDataSet.Create(Self);
  Try
    qryConPor := fCriarQuery(strSql);
    qryConPor.Open;
    cdsConPorHerda := fCriaClientDatset(qryConPor);
  Finally
    FreeAndNil(qryConPor);
  End;

  btnIncluir.Click;

  qrytabela.FieldByName('CAR_STATUS').AsString  := cdsHerdaCad.FieldByName('CAR_STATUS').AsString;
  qrytabela.FieldByName('CAR_PERDES').AsString  := cdsHerdaCad.FieldByName('CAR_PERDES').AsString;
  qrytabela.FieldByName('CAR_TIPTAX').AsString  := cdsHerdaCad.FieldByName('CAR_TIPTAX').AsString;
  qrytabela.FieldByName('CAR_TAXMIN').AsString  := cdsHerdaCad.FieldByName('CAR_TAXMIN').AsString;
  qrytabela.FieldByName('CAR_CODBAN').AsString  := cdsHerdaCad.FieldByName('CAR_CODBAN').AsString;
  qrytabela.FieldByName('CAR_MKTPLA').AsString  := cdsHerdaCad.FieldByName('CAR_MKTPLA').AsString;
  qrytabela.FieldByName('CAR_PERIOD').AsString  := cdsHerdaCad.FieldByName('CAR_PERIOD').AsString;
  qrytabela.FieldByName('CAR_EXCDIA').AsString  := cdsHerdaCad.FieldByName('CAR_EXCDIA').AsString;
  qrytabela.FieldByName('CAR_SUGPAR').AsString  := cdsHerdaCad.FieldByName('CAR_SUGPAR').AsString;
  qrytabela.FieldByName('CAR_MAXPAR').AsString  := cdsHerdaCad.FieldByName('CAR_MAXPAR').AsString;
  qrytabela.FieldByName('CAR_TIPCAR').AsString  := cdsHerdaCad.FieldByName('CAR_TIPCAR').AsString;
  qrytabela.FieldByName('CAR_PARMIN').AsString  := cdsHerdaCad.FieldByName('CAR_PARMIN').AsString;
  qrytabela.FieldByName('CAR_C_G_C_').AsString  := cdsHerdaCad.FieldByName('CAR_C_G_C_').AsString;
  qrytabela.FieldByName('CAR_OBRCCD').AsString  := cdsHerdaCad.FieldByName('CAR_OBRCCD').AsString;
  qrytabela.FieldByName('CAR_OBRNSU').AsString  := cdsHerdaCad.FieldByName('CAR_OBRNSU').AsString;
  qrytabela.FieldByName('CAR_ENTSPE').AsString  := cdsHerdaCad.FieldByName('CAR_ENTSPE').AsString;
  qrytabela.FieldByName('CAR_PLANCO').AsString  := cdsHerdaCad.FieldByName('CAR_PLANCO').AsString;
  qrytabela.FieldByName('CAR_DESMEM').Asboolean := cdsHerdaCad.FieldByName('CAR_DESMEM').Asboolean;
  qrytabela.FieldByName('CAR_ARRPAR').AsString  := cdsHerdaCad.FieldByName('CAR_ARRPAR').AsString;
  qryTabela.FieldByName('CAR_TIPTEF').AsString := cdsHerdaCad.FieldByName('CAR_TIPTEF').AsString;
  qryTabela.FieldByName('CAR_TIPPOS').AsString := cdsHerdaCad.FieldByName('CAR_TIPPOS').AsString;
  if fCadastroCartaoParamAutTef and (Not FEmptyStr(cdsHerdaCad.FieldByName('CAR_CODADQ').AsString)) then
    qryTabela.FieldByName('CAR_CODADQ').AsString := cdsHerdaCad.FieldByName('CAR_CODADQ').AsString;

  if fCadastroCartaoParamAutTef then
    qryTabela.FieldByName('CAR_DESCAR').AsString := cdsHerdaCad.FieldByName('CAR_DESCAR').AsString;

  If Not FEmptyStr(cdsHerdaCad.FieldByName('CAR_CODRED').AsString) Then
     qrytabela.FieldByName('CAR_CODRED').AsString := cdsHerdaCad.FieldByName('CAR_CODRED').AsString;

  If Not FEmptyStr(cdsHerdaCad.FieldByName('CAR_NOMRED').AsString) Then
     qrytabela.FieldByName('CAR_NOMRED').AsString  := cdsHerdaCad.FieldByName('CAR_NOMRED').AsString;

  If Not FEmptyStr(cdsHerdaCad.FieldByName('CAR_NOMBAN').AsString) Then
     qrytabela.FieldByName('CAR_NOMBAN').AsString  := cdsHerdaCad.FieldByName('CAR_NOMBAN').AsString;

  If Not FEmptyStr(cdsHerdaCad.FieldByName('CAR_TIPTRA').AsString) Then
     qrytabela.FieldByName('CAR_TIPTRA').AsString  := cdsHerdaCad.FieldByName('CAR_TIPTRA').AsString;

  If Not FEmptyStr(cdsHerdaCad.FieldByName('CAR_TFTRED').AsString) Then
     qrytabela.FieldByName('CAR_TFTRED').AsString  := cdsHerdaCad.FieldByName('CAR_TFTRED').AsString;

  If Not FEmptyStr(cdsHerdaCad.FieldByName('CAR_TFTBAN').AsString) Then
     qrytabela.FieldByName('CAR_TFTBAN').AsString  := cdsHerdaCad.FieldByName('CAR_TFTBAN').AsString;

  If Not FEmptyStr(cdsHerdaCad.FieldByName('CAR_TFRED2').AsString) Then
     qrytabela.FieldByName('CAR_TFRED2').AsString  := cdsHerdaCad.FieldByName('CAR_TFRED2').AsString;

  If Not FEmptyStr(cdsHerdaCad.FieldByName('CAR_TFBAN2').AsString) Then
     qrytabela.FieldByName('CAR_TFBAN2').AsString  := cdsHerdaCad.FieldByName('CAR_TFBAN2').AsString;

  //Informacões para baixa otimizada de cartoes;
  If Not FEmptyStr(cdsHerdaCad.FieldByName('CAR_PORBAI').AsString) Then
     qrytabela.FieldByName('CAR_PORBAI').AsString := cdsHerdaCad.FieldByName('CAR_PORBAI').AsString;

  If Not FEmptyStr(cdsHerdaCad.FieldByName('CAR_CTABAI').AsString) Then
     qrytabela.FieldByName('CAR_CTABAI').AsString := cdsHerdaCad.FieldByName('CAR_CTABAI').AsString;

  If Not FEmptyStr(cdsHerdaCad.FieldByName('CAR_EVECRE').AsString) Then
     qrytabela.FieldByName('CAR_EVECRE').AsString := cdsHerdaCad.FieldByName('CAR_EVECRE').AsString;

  If Not FEmptyStr(cdsHerdaCad.FieldByName('CAR_PORTAX').AsString) Then
     qrytabela.FieldByName('CAR_PORTAX').AsString := cdsHerdaCad.FieldByName('CAR_PORTAX').AsString;

  If Not FEmptyStr(cdsHerdaCad.FieldByName('CAR_FORTAX').AsString) Then
     qrytabela.FieldByName('CAR_FORTAX').AsString := cdsHerdaCad.FieldByName('CAR_FORTAX').AsString;

  If Not FEmptyStr(cdsHerdaCad.FieldByName('CAR_CTATAX').AsString) Then
     qrytabela.FieldByName('CAR_CTATAX').AsString := cdsHerdaCad.FieldByName('CAR_CTATAX').AsString;

  If Not FEmptyStr(cdsHerdaCad.FieldByName('CAR_EVETAX').AsString) Then
     qrytabela.FieldByName('CAR_EVETAX').AsString := cdsHerdaCad.FieldByName('CAR_EVETAX').AsString;

  If Not FEmptyStr(cdsHerdaCad.FieldByName('CAR_PORBAD').AsString) Then
     qrytabela.FieldByName('CAR_PORBAD').AsString := cdsHerdaCad.FieldByName('CAR_PORBAD').AsString;

  If Not FEmptyStr(cdsHerdaCad.FieldByName('CAR_CTABAD').AsString) Then
     qrytabela.FieldByName('CAR_CTABAD').AsString := cdsHerdaCad.FieldByName('CAR_CTABAD').AsString;

  If Not FEmptyStr(cdsHerdaCad.FieldByName('CAR_EVEDEB').AsString) Then
     qrytabela.FieldByName('CAR_EVEDEB').AsString := cdsHerdaCad.FieldByName('CAR_EVEDEB').AsString;

  If Not FEmptyStr(cdsHerdaCad.FieldByName('CAR_CTAAJU').AsString) Then
     qrytabela.FieldByName('CAR_CTAAJU').AsString := cdsHerdaCad.FieldByName('CAR_CTAAJU').AsString;

  If Not FEmptyStr(cdsHerdaCad.FieldByName('CAR_CTAANT').AsString) Then
     qrytabela.FieldByName('CAR_CTAANT').AsString := cdsHerdaCad.FieldByName('CAR_CTAANT').AsString;

  If Not FEmptyStr(cdsHerdaCad.FieldByName('CAR_CTAFRE').AsString) Then
     qrytabela.FieldByName('CAR_CTAFRE').AsString := cdsHerdaCad.FieldByName('CAR_CTAFRE').AsString;

  edtNomBan.Text := fRetNomBandeira(dbeCodBan.Text);
  edtDesCredenciadora.Text := fRetNomCredenciadora(dbeCodRed.Text);
  pCarregaPlanoContabil(False);
  edtNomAdq.Text := fRetNomAdquirenteCartao(dbeCodAdq.Text);

  // ------ //
  If Not fEmptyStr(dbePorBai.Text) Then
     pCarregaPortador(dbePorBai, edtPorBai);

  If Not fEmptyStr(fraPlanoDeContas.dbeCodCta.Text) Then
     pCarregaCentroDeCusto(fraPlanoDeContas.dbeCodCta, fraPlanoDeContas.edtDesCta, False);

  If Not fEmptyStr(FraCentroCustoC.dbecodeve.Text) Then
     FraCentroCustoC.edtDesEve.Text := fRetNomEvento(FraCentroCustoC.dbecodeve);

  If Not fEmptyStr(dbePorTax.Text) Then
     pCarregaPortador(dbePorTax, edtPorTax);

  If Not fEmptyStr(fraPlanoDeContas.dbeCodCta.Text) Then
     pCarregaCentroDeCusto(fraPlanoDeContasDaBaixa.dbeCodCta, fraPlanoDeContasDaBaixa.edtDesCta, True);

  If Not fEmptyStr(dbeForTax.Text) Then
     pCarregaFornecedor;

  If Not fEmptyStr(FraCentroCustoTX.dbecodeve.Text) Then
     FraCentroCustoTX.edtDesEve.Text := fRetNomEvento(FraCentroCustoTX.dbecodeve);

  If Not fEmptyStr(fraPlanoDeContasDebito.dbeCodCta.Text) Then
     pCarregaCentroDeCusto(fraPlanoDeContasDebito.dbeCodCta, fraPlanoDeContasDebito.edtDesCta, False);

  If Not fEmptyStr(fraCentroCustoD.dbecodeve.Text) Then
     FraCentroCustoD.edtDesEve.Text := fRetNomEvento(fraCentroCustoD.dbecodeve);

  If Not fEmptyStr(dbePorBad.Text) Then
     pCarregaPortador(dbePorBad, edtPorBad);

  If Not fEmptyStr(FraPlanoDeContasCanc.dbeCodCta.Text) Then
     pCarregaCentroDeCusto(fraPlanoDeContasCanc.dbeCodCta, fraPlanoDeContasCanc.edtDesCta, True);

  If Not fEmptyStr(fraPlanoDeContasAnt.dbeCodCta.Text) Then
     pCarregaCentroDeCusto(fraPlanoDeContasAnt.dbeCodCta, fraPlanoDeContasAnt.edtDesCta, False);

  If Not fEmptyStr(fraPlanoDeContasFrete.dbeCodCta.Text) Then
     pCarregaCentroDeCusto(fraPlanoDeContasFrete.dbeCodCta, fraPlanoDeContasFrete.edtDesCta, True);

  If Not fEmptyStr(fraPlanoDeContasCupons.dbeCodCta.Text) Then
     pCarregaCentroDeCusto(fraPlanoDeContasCupons.dbeCodCta, fraPlanoDeContasCupons.edtDesCta, True);

  //*******************************************//
  // Os dados da baixa otimizada por empresa   //
  // será gravado apos a confirmação da tabela //
  // principal                                 //
  //*******************************************//
  blnCriouHeranca := True;

  If Assigned(cdsHerdaCad) Then
     FreeAndNil(cdsHerdaCad);

end;

procedure TfrmCadCartoes.dbeCodBanKeyPress(Sender: TObject; var Key: Char);
Var
  arrBandeira : TConsultasArray;
  LobjfrmPnl: TPanelCxBandeiras;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE BANDEIRAS DE CARTOES *}
  {**************************************DP*}
  LobjfrmPnl := TPanelCxBandeiras.Create(TfrmPnlDadosBandeiras) ;
  If fPesqCartaoBandeira(Self, dbeCodBan, edtNomBan, Nil, Key, arrBandeira, True, LobjfrmPnl) Then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCartoes.dbeCodigoFornecedorFiscalKeyPress(Sender: TObject;
  var Key: Char);
  Var
    LFornecedorArray: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForCompleta, Self, dbeCodigoFornecedorFiscal, edtNomeFornecedorFiscal, Nil, Key, LFornecedorArray) Then
  Begin
    If fValidaCampos(dbeCodigoFornecedorFiscal, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCartoes.dbchkDesmembrClick(Sender: TObject);
begin
  inherited;
  If dbchkDesmembr.Checked Then
  Begin
    btnDesmembr.Visible := True;
    If (blnUtiCon) Then
    Begin
      dbePlaNco.Clear;
      dbePlaNco.Enabled := False;
    End
    Else
    Begin
      dbeConCon.Clear;
      dbeConCon.Enabled   := False;
    End;
  End
  Else
  Begin
    btnDesmembr.Visible := False;
    If (blnUtiCon) Then
      dbePlaNco.Enabled := True
    Else
      dbeConCon.Enabled   := True;
  End;
end;

procedure TfrmCadCartoes.dbeCardSeEnter(Sender: TObject);
begin
  inherited;
  pShowHint(dbeCardSe, lbCardSe.Caption);
end;

procedure TfrmCadCartoes.dbeCardSeExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmCadCartoes.dbeCardSeKeyPress(Sender: TObject; var Key: Char);
Var
  LarrCardse : TConsultasArray;
begin
  inherited;
  If fPesqCarteiraDigital(Self, dbeCardSe, Nil, Nil, Key, LarrCardse) Then
    fValidaCampos(dbeCardSe, True);
end;

procedure TfrmCadCartoes.dbeCnpjKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFornec: TConsultasArray;
    qryAux: TUniQuery;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, Nil, Nil, Nil, Key, arrFornec) Then
  Begin
    qryAux := fCriaQuery;
    qryAux.Close;
    qryAux.SQL.Text := 'SELECT FOR_C_G_C_ FROM CADFOR WHERE FOR_CODFOR = :COD';
    qryAux.ParamByName('COD').AsString := arrFornec[0].strCodigo;
    qryAux.Open;
    dbeCnpj.Field.AsString := qryAux.FieldByName('FOR_C_G_C_').AsString;
    FreeAndNil(qryAux);

    If fValidaCampos(dbeCnpj, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;


function TfrmCadCartoes.dbeCodAdqChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadAdqCartaoFunc(Key);
end;

procedure TfrmCadCartoes.dbeCodAdqKeyPress(Sender: TObject; var Key: Char);
Var
  arrAdquirente : TConsultasArray;
  LobjfrmPnl: TPanelCxAdquirentesCartao;
begin
  inherited;
  LobjfrmPnl:= nil;

  try
    LobjfrmPnl := TPanelCxAdquirentesCartao.Create(TfrmPnlDadosAdquirentesCartao) ;
    If fPesqAdquirenteCartao(Self, dbeCodAdq, edtNomAdq, Nil, Key, arrAdquirente, True, LobjfrmPnl) Then
    Begin
      If fValidaCampos(TDBEditFocus(Sender), True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  finally
    FreeAndNil(LobjfrmPnl);
  end;
end;

function TfrmCadCartoes.dbeCodBanChamaCadastro(Key: Word): String;
begin
  inherited;

  Result := fChamaCadBan(Key);

end;

procedure TfrmCadCartoes.pAfterOpen(DataSet: TDataSet);
begin
  DataSet.FieldByName('CAR_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_);;
  TFloatField(DataSet.FieldByName('CAR_PERDES')).DisplayFormat := ',0.000000';
  TFloatField(DataSet.FieldByName('CAR_PARMIN')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('CAR_TAXMIN')).DisplayFormat := '#,##0.00';

  If DataSet.FindField('CAR_PLANCO') <> Nil Then
    TStringField(DataSet.FieldByName('CAR_PLANCO')).EditMask := fMskCon;
end;

procedure TfrmCadCartoes.pAjustarLabelGroupBoxLinkPagamentoBandeira;
var
  LstrCfg: String ;
begin
  LstrCfg := fCfgSis('LINKPG', varString) ;
  if LstrCfg = '3' then
    gbLinkPagamentoBandeira.Caption := 'Dados para Link de Pagamento CIELO'
  else if LstrCfg = '5' then
    gbLinkPagamentoBandeira.Caption := 'Dados para Link de Pagamento CredPay'
  else if LstrCfg = '7' then
    gbLinkPagamentoBandeira.Caption := 'Dados para Link de Pagamento IPAG' ;
end;

procedure TfrmCadCartoes.pAjustarLinkCielo;
begin
  if not gbLinkPagamentoBandeira.Visible then
    Self.Height := Self.Height - gbLinkPagamentoBandeira.Height ;
end;

procedure TfrmCadCartoes.pAtualizaCamposNovaFormaCadCartaoTef(
  Sender: TWinControl);
var
  LEntrada: TParamEntradaDadosTef ;
  LRetorno: TParamSaidaDadosTef ;
  LMensagem: String ;
begin
  if not(fObjetoValidoParaAtualizarNovaFormaCadCartaoTef(Sender)) then
    exit;

  if not fCadastroCartaoParamAutTef then
    Exit ;

  if not (qryTabela.State In [dsInsert, dsEdit]) then
    Exit ;

  LEntrada.codigo_bandeira   := dbeCodBan.Text ;
  LEntrada.codigo_adquirente := dbeCodAdq.Text ;
  LEntrada.parcela_minima    := StrToIntDef(dbeSugCPg.Text, 0) ;
  LEntrada.parcela_maxima    := StrToIntDef(dbeMaxPar.Text, 0) ;
  LEntrada.pos_adquirente    := TUtilCadastroCartaoTef.fAdquirenteModoPos(LEntrada.codigo_adquirente);

  LEntrada.tipo_cartao := TUtilCadastroCartaoTef.fGetTipoCartao(copy(dbeTipCar.Text,1,1)) ;

  if (Sender = dbeTipCar) then
    qryTabela.FieldByName('CAR_TIPCAR').AsString := TUtilCadastroCartaoTef.fGetTipoCartaoToStr(LEntrada.tipo_cartao);

  LEntrada.tipo_transacao := [] ;

  if chkTipoPos.Checked then
    Include(LEntrada.tipo_transacao, ttPos);

  if chkTipoTef.Checked then
    Include(LEntrada.tipo_transacao, ttTef);

  DBETFTRED.Field.Clear;
  DBETFTOPE.Field.Clear;
  DBETFBAN2.Field.Clear;
  DBETFRED2.Field.Clear;

  if (TTRegrasCartaoTefService.fDadosTransacaoCartao(LEntrada, LRetorno)) then
  begin
    dbeDesCar.Field.AsString := LRetorno.descricao ;

    if (TTRegrasCartaoTefService.fValidaRegrasRetorno(ftClisitef, LRetorno, LEntrada, tvAdquirente, LMensagem)) then
      DBETFTOPE.Field.AsString := LRetorno.codigos[ftClisitef].codigo_rede ;

    if (TTRegrasCartaoTefService.fValidaRegrasRetorno(ftClisitef, LRetorno, LEntrada, tvBandeira, LMensagem)) then
      DBETFTRED.Field.AsString := LRetorno.codigos[ftClisitef].codigo_bandeira ;

    if (TTRegrasCartaoTefService.fValidaRegrasRetorno(ftScope, LRetorno, LEntrada, tvAdquirente, LMensagem)) then
      DBETFRED2.Field.AsString := LRetorno.codigos[ftScope].codigo_rede ;

    if (TTRegrasCartaoTefService.fValidaRegrasRetorno(ftScope, LRetorno, LEntrada, tvBandeira, LMensagem)) then
      DBETFBAN2.Field.AsString := LRetorno.codigos[ftScope].codigo_bandeira ;
  end;
end;

procedure TfrmCadCartoes.pShowHint(edtEdit: TCustomEdit; strTitulo: String);
var
  LPosicao: TPoint ;
Begin
  LPosicao := edtEdit.ClientToScreen(Point(0,0)) ;
  HintControler.ShowHint(LPosicao.X, LPosicao.Y, strTitulo, edtEdit.Hint);
End;

procedure TfrmCadCartoes.pTratarZerosEsquerdaSemAcaoDoComponente(
  AEdit: TDBEditFocus);
begin
  If Not(AEdit.DataSource.DataSet.State In [dsInsert, dsEdit]) Then
    Exit;

  AEdit.CompZeros:= false;
  AEdit.Field.AsString:= AEdit.Text;

  if (StrToIntDef(AEdit.Text, 0) = 0) then
  begin
    AEdit.Field.Clear;
    exit;
  end;

  AEdit.Field.AsString := fStrZero(AEdit.Field.AsString, AEdit.Field.Size);
end;

procedure TfrmCadCartoes.pHabiliatarOtimizadaPorEmpresa(blnHabilitar: Boolean);
begin
  blnHabilitar := blnBaixaOtimizada And blnHabilitar;

  btnIncluirDadosEmpresa.Enabled := blnHabilitar;
  btnAlterarDadosEmpresa.Enabled := blnHabilitar;
  btnExcluirDadosEmpresa.Enabled := blnHabilitar;
  btnCopiarDadosEmpresa.Enabled  := blnHabilitar;

  grdDadosOtimizada.Enabled := blnBaixaOtimizada;
end;

procedure TfrmCadCartoes.pHabilitaDesCar(const AblnHabilita,
  AblnSomenteCores: Boolean);
begin
  if not fCadastroCartaoParamAutTef then
    Exit ;

  if not AblnSomenteCores then
    dbeDesCar.Enabled := AblnHabilita ;

  if AblnHabilita then
  begin
    dbeDesCar.Color := clWindow ;
    dbeDesCar.NormalColor  := clWindow ;
    dbeDesCar.CharCase := ecUpperCase ;
  end
  else
  begin
    dbeDesCar.Color := 16768952 ;
    dbeDesCar.NormalColor  := 16768952 ;
    dbeDesCar.CharCase := ecNormal ;
  end ;
end;

procedure TfrmCadCartoes.pHideHint;
Begin
  HintControler.HideHint;
End;

end.
