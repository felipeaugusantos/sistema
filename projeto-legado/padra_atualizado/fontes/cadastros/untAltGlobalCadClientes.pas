unit untAltGlobalCadClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, QColorLabel, EditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, untFuncoesSimples,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, Datasnap.DBClient, UniClientDataSet,
  untTypesSistema, cxGridBandedTableView, cxGridDBBandedTableView, cxProgressBar,
  Uni, untZClient, cxEditRepositoryItems, cxDBEditRepository, ComboBoxFocus,
  cxCheckBox, untLiberacao, cxDBLookupComboBox, cxDropDownEdit, Vcl.Mask,
  MaskEditFocus, untLogAltCadCli, Datasnap.Provider, UniDataSetProvider,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, cxGridCitel;

type
  TfrmAltGlobalCadClientes = class(TfrmPai)
    pnlFiltro: TPanel;
    Label19: TLabel;
    edtCodCli: TEditFocus;
    edtDesCli: TEditFocus;
    Label9: TLabel;
    ColorLabel1: TColorLabel;
    edtSituacao: TEditFocus;
    Label3: TLabel;
    edtCodCid: TEditFocus;
    edtNomCid: TEditFocus;
    Label1: TLabel;
    ColorLabel2: TColorLabel;
    edtConsum: TEditFocus;
    Label5: TLabel;
    ColorLabel5: TColorLabel;
    edtRevist: TEditFocus;
    Label6: TLabel;
    clbPrcVenda: TColorLabel;
    edtTabPre: TEditFocus;
    lbl1: TLabel;
    edtCodReg: TEditFocus;
    edtNomReg: TEditFocus;
    edtNomVen: TEditFocus;
    edtCodVen: TEditFocus;
    Label7: TLabel;
    lbl3: TLabel;
    edtEstado: TEditFocus;
    lbl6: TLabel;
    edtBairro: TEditFocus;
    lbl11: TLabel;
    edtCodRep: TEditFocus;
    edtDesRep: TEditFocus;
    lbl5: TLabel;
    edtCodAti: TEditFocus;
    edtDesAti: TEditFocus;
    lbl9: TLabel;
    edtCodRed: TEditFocus;
    edtDesRed: TEditFocus;
    Label8: TLabel;
    edtCodCac: TEditFocus;
    edtDesCac: TEditFocus;
    lbl12: TLabel;
    edtDesSub: TEditFocus;
    edtCodSub: TEditFocus;
    Label12: TLabel;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    Label13: TLabel;
    edtCodPor2: TEditFocus;
    edtNomPor2: TEditFocus;
    Label15: TLabel;
    cdsParametros: TUniClientDataSet;
    cdsParametrosCAMPO: TStringField;
    cdsParametrosMARCADO: TBooleanField;
    cdsParametrosDESCRI: TStringField;
    dtsCampos: TDataSource;
    btnConfirma: TBitBtnLocked;
    pnlCamposVisualizados: TPanel;
    cdsParametrosABA: TStringField;
    pnlTipCli: TPanel;
    edtDesTpc: TEditFocus;
    edtTipCli: TEditFocus;
    lblTipCli: TLabel;
    pnlForPag: TPanel;
    Label11: TLabel;
    edtCodFpg: TEditFocus;
    edtDesFpg: TEditFocus;
    pnlPeMIFF: TPanel;
    Label2: TLabel;
    ColorLabel3: TColorLabel;
    edtPermFF: TEditFocus;
    pnlPeMIFV: TPanel;
    Label4: TLabel;
    edtPermFV: TEditFocus;
    ColorLabel4: TColorLabel;
    pnlCodCnd: TPanel;
    Label14: TLabel;
    edtCodCnd: TEditFocus;
    edtDesCnd: TEditFocus;
    nbDados: TNotebook;
    grdCampos: TcxGridCitel;
    grdCamposTv: TcxGridDBTableViewCitel;
    grdCamposCAMPO: TcxGridDBColumn;
    grdCamposABA: TcxGridDBColumn;
    grdCamposDESCRI: TcxGridDBColumn;
    grdCamposMARCADO: TcxGridDBColumn;
    grdCamposLvl: TcxGridLevel;
    Panel1: TPanel;
    Label16: TLabel;
    Panel2: TPanel;
    btnLimpaFiltros: TBitBtnLocked;
    cxEditRepository: TcxEditRepository;
    cxeString16: TcxEditRepositoryTextItem;
    cxeString20: TcxEditRepositoryTextItem;
    cxeString02: TcxEditRepositoryTextItem;
    cxeString03: TcxEditRepositoryTextItem;
    cxeString05: TcxEditRepositoryTextItem;
    cxeString06: TcxEditRepositoryTextItem;
    cxeString07: TcxEditRepositoryTextItem;
    cxeString08: TcxEditRepositoryTextItem;
    cxeString10: TcxEditRepositoryTextItem;
    cxeString25: TcxEditRepositoryTextItem;
    cxeString30: TcxEditRepositoryTextItem;
    cxeString50: TcxEditRepositoryTextItem;
    cxeString70: TcxEditRepositoryTextItem;
    cxeString80: TcxEditRepositoryTextItem;
    cxeDate: TcxEditRepositoryDateItem;
    cxeInt03: TcxEditRepositoryCurrencyItem;
    cxeInt11: TcxEditRepositoryCurrencyItem;
    cmbSimNao: TcxEditRepositoryLookupComboBoxItem;
    cxeMemo: TcxEditRepositoryMemoItem;
    cxeMasVal: TcxEditRepositoryTextItem;
    cxeMasPer: TcxEditRepositoryTextItem;
    cxeMasInt: TcxEditRepositoryTextItem;
    cxeConsTam8: TcxEditRepositoryTextItem;
    cxeConsTam6: TcxEditRepositoryTextItem;
    cxeConsTam5: TcxEditRepositoryTextItem;
    cxeConsTam3: TcxEditRepositoryTextItem;
    cxeConsTam4: TcxEditRepositoryTextItem;
    cxeConsTam2: TcxEditRepositoryTextItem;
    cxeConsTam7: TcxEditRepositoryTextItem;
    Label156: TLabel;
    cmbCategoria: TComboBoxFocus;
    cmbPropCategoria: TcxEditRepositoryComboBoxItem;
    cmbBolImp: TcxEditRepositoryLookupComboBoxItem;
    cxeString40: TcxEditRepositoryTextItem;
    cxeString01: TcxEditRepositoryTextItem;
    cxeRegTri: TcxEditRepositoryLookupComboBoxItem;
    cxeIndCom: TcxEditRepositoryLookupComboBoxItem;
    cxeTFTNES: TcxEditRepositoryLookupComboBoxItem;
    cmbTabPre: TcxEditRepositoryComboBoxItem;
    cxeSitIpi: TcxEditRepositoryLookupComboBoxItem;
    cxeSitP_C: TcxEditRepositoryLookupComboBoxItem;
    pnlCndPag: TPanel;
    Label10: TLabel;
    rdbIncluir: TRadioButton;
    rdgExcluir: TRadioButton;
    pnlLiberacao: TPanel;
    cxeTipFre: TcxEditRepositoryLookupComboBoxItem;
    cxeInt07: TcxEditRepositoryCurrencyItem;
    cxeInt20: TcxEditRepositoryCurrencyItem;
    Label17: TLabel;
    edtCep: TMaskEditFocus;
    cxeCodCna: TcxEditRepositoryMaskItem;
    grdCamposVALOR: TcxGridDBColumn;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    shpConsulta: TShape;
    Label18: TLabel;
    shpLista: TShape;
    Label20: TLabel;
    Shape3: TShape;
    Label21: TLabel;
    cxStyleRepository: TcxStyleRepository;
    cxsCorAzul: TcxStyle;
    cxsCombo: TcxStyle;
    cxsAltera: TcxStyle;
    cxsConsulta: TcxStyle;
    cdsParametrosPROPER: TStringField;
    grdCamposPROPER: TcxGridDBColumn;
    cdsParametrosVALOR: TStringField;
    cdsParametrosDESVAL: TStringField;
    grdCamposDESVAL: TcxGridDBColumn;
    cdsClientesAlteracao: TUniClientDataSet;
    dspClientesAlteracao: TUniDataSetProvider;
    pgbProgresso: TProgressBar;
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidExit(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRegExit(Sender: TObject);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenExit(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRedExit(Sender: TObject);
    procedure edtCodRedKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodSubExit(Sender: TObject);
    procedure edtCodSubKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiExit(Sender: TObject);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCacExit(Sender: TObject);
    procedure edtCodCacKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRepExit(Sender: TObject);
    procedure edtCodRepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodFpgExit(Sender: TObject);
    procedure edtCodFpgKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPor2Exit(Sender: TObject);
    procedure edtCodPor2KeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cdsParametrosBeforePost(DataSet: TDataSet);
    procedure edtTipCliExit(Sender: TObject);
    procedure edtTipCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCndExit(Sender: TObject);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure btnLimpaFiltrosClick(Sender: TObject);
    procedure cxeConsTam2PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvTiposAltEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxeMasPerPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxeMasValPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cdsParametrosMARCADOChange(Sender: TField);
    procedure cdsParametrosAfterPost(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure cxeInt03PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure grdCamposVALORGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure grdCamposVALORGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure grdCamposVALORStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure grdCamposTvEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure grdCamposTvKeyPress(Sender: TObject; var Key: Char);
    procedure grdCamposTvEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure grdCamposMARCADOPropertiesChange(Sender: TObject);
  private
    { Private declarations }
    FArrCidade,
    FArrRede,
    FArrRegiao,
    FArrVended,
    FArrSubReg,
    FArrAtividade,
    FArrCanal,
    FArrRepr,
    FArrForma,
    FArrPortador,
    FArrPortador2,
    FArrTipCli,
    FArrCndPag,
    FArrClientes: TConsultasArray;
    FstrVrfTpr: String;
    FArrCampos: Array Of  TCampoGlobal;
    FqryCadCli: TUniQuery;
    FDtsCadCli: TDataSource;

    FcdsSimNao,
    FcdsBolImp,
    FcdsRegTri,
    FcdsIndCom,
    FcdsTFTNES,
    FcdsSitIpi,
    FcdsSitP_C,
    FcdsTipFre: TUniClientDataSet;

    FdtsSimNao,
    FdtsBolImp,
    FdtsRegTri,
    FdtsIndCom,
    FdtsTFTNES,
    FdtsSitIpi,
    FdtsSitP_C,
    FdtsTipFre: TDataSource;

    FAcessoPER_FF,
    FAcessoCLIMEI,
    FAcessoCLI_PR: Boolean;

    objLiberacao: TLiberacao;
    objLogAltCadCli: TLogAltCadCli;
    arrCamposTabela: Array Of TCampoGlobal;
    arrCamposGrid: TArrCampoGlobal;

    procedure pAplicaMascara(const strCampo, strMascara: String);
    procedure pSetParamSeValor(const strParam, strValor: String; const blnLike: Boolean = False);
    procedure pCarregaTabelasPreco;
    procedure pCarregaCategorias;
    procedure pLimpaCampos;
    procedure pPreparaColunas;
    procedure pIncluiParametro(const strAba, strCampo, strDescricao: String; proProperties: TcxEditRepositoryItem; const blnMarcado: boolean = False);
    procedure pIncluiCampo(strNomCam, strTitulo: String; blnVisible: Boolean = True; proProperties: TcxEditRepositoryItem = Nil; strFieldDesc: string = ''; strFieldDescTitle: String = '');
    procedure pAddColuna(const strAba, strCampo, strDescricao: String; proProperties: TcxEditRepositoryItem = Nil; blnVisivel: Boolean = True; strFieldDesc: string = ''; strFieldDescTitle: String = '');

    procedure pCriaCdsSimNao;
    procedure pCriaCdsBolImp;
    procedure pCriaCdsRegTri;
    procedure pCriaCdsIndCom;
    procedure pCriaCdsTFTNES;
    procedure pCriaCdsSitIpi;
    procedure pCriaCdsSitP_C;
    procedure pCriaCdsTipFre;

    function fRetornaValorDoCampo(strCampo: String): String;
    procedure pAtualizaValorCampo(var arrCampos: array of TCampoGlobal;
      strNomeCampo: String; varValor: Variant);
    procedure pAlteraValorTabelaClientes(strCodCli: String;
      var arrCampos: array of TCampoGlobal);
    procedure pRetProperties(strNomProp: String;
      var AProperties: TcxCustomEditProperties);

    function fRetSql: String;
    function fAbreQryCadCli(pgbProgresso2: TcxProgressBar): Boolean;
    function fCampoMarcado(strCampo: String): Boolean;
    function fConfirmaAlteracoes(cxProgresso: TcxProgressBar): Boolean;
    function fRetDescricaoCadastro(strNomCam, strCodCad: String; blnValidar: Boolean; Var blnErro: Boolean): String;
    function fTemConsultaTabela(strNomCam: String): Boolean;
    function fValidaValor(strValor: String): Boolean;
    function fCampoLiberacaoMarcado: Boolean;
    function fRetSqlSeCampoMarcado(strCampo, strSql: String): String;
    function fRetSqlSeTemValor(strCampo, strSql: String): String;
    function fValidaCodPor(strValor: String): Boolean;
    function fValidaCodPo2(strValor: String): Boolean;
    function fValidaCodRep(strValor: String): Boolean;
    function fValidaTabPre(strValor: String): Boolean;
    function fValidaTipCli(strValor: String): Boolean;
    function fValidaCodVen(strValor: String): Boolean;
    function fVerificaCamposObrigatorios:Boolean;
    function fValidaLimCre(strValor: String): Boolean;
    function fVerificaFiltros: Boolean;
    function fGeraVetorCampos: Boolean;
    function fGeraVetorCamposAux(pgbProgresso: TcxProgressBar): Boolean;
    function fCampoPorNome(var arrCampos: array of TCampoGlobal;
      strNomeCampo: String): TCampoGlobal;
    procedure pSalva(strDado: String; var Key: Char);
    procedure pAdicionaCampoGrid(strNomeCampo: String);

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

uses
  System.StrUtils, untFuncoesConsulta, untConsultas, untGravando, untConstantes,
  cxTextEdit, untFuncoes, untMsgLiberacao,untFuncoesGenerica,
  untTipoFreteAtc, untConfirmaGlobalClientes;

procedure TfrmAltGlobalCadClientes.edtCodFpgExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFpg, edtDesFpg, FArrForma, Nil, fRetDescFpg, 'da Forma de Pagamento');
end;

procedure TfrmAltGlobalCadClientes.edtCodFpgKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFormaPgto(conFpgSimples, Self, edtCodFpg, edtDesFpg, Nil, Key, FArrForma, False) Then
    If fValidaCampos(edtCodFpg, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobalCadClientes.edtCodPor2Exit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPor2, edtNomPor2, FArrPortador2, Nil, fRetNomPortador, 'do Portador');
end;

procedure TfrmAltGlobalCadClientes.edtCodPor2KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPor2, edtNomPor2, Nil, Key, FArrPortador2, False) Then
    If fValidaCampos(edtCodPor2, False) Then
      Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobalCadClientes.edtCodPorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPor, edtNomPor, FArrPortador, Nil, fRetNomPortador, 'do Portador');
end;

procedure TfrmAltGlobalCadClientes.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPor, edtNomPor, Nil, Key, FArrPortador, False) Then
    If fValidaCampos(edtCodPor, False) Then
      Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobalCadClientes.edtCodCndExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCnd, edtDesCnd, FArrCndPag, fRetDesConPag, Nil, 'da Condição de Pagamento');
end;

procedure TfrmAltGlobalCadClientes.edtCodCndKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCondicoesPgto(Self, edtCodCnd, edtDesCnd, nil, Key, FArrCndPag, False) Then
    If fValidaCampos(edtCodCnd, True) Then
      Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobalCadClientes.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAti, edtDesAti, FArrAtividade, Nil, fRetNomAtividade, 'da atividade');
end;

procedure TfrmAltGlobalCadClientes.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, FArrAtividade, False) Then
    If fValidaCampos(edtCodAti, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobalCadClientes.edtCodCacExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCac, edtDesCac, FArrCanal, nil, fRetNomCanalAcesso, 'do Canal');
end;

procedure TfrmAltGlobalCadClientes.edtCodCacKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCanalAcesso(Self, edtCodCac, edtDesCac, Nil, Key, FArrCanal, false) Then
		If fValidaCampos(edtCodCac, False) Then
  		Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobalCadClientes.edtCodCidExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCid, edtNomCid, FArrCidade, fRetNomCidadeSemOpc, Nil, 'da Cidade');
end;

procedure TfrmAltGlobalCadClientes.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCidade(Self, edtCodCid, edtNomCid, Nil, Nil, Key, FArrCidade, False) Then
    If fValidaCampos(edtCodCid, False) Then
      Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobalCadClientes.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtDesCli, FArrClientes, Nil, fRetNomCliente, 'do Cliente');
end;

procedure TfrmAltGlobalCadClientes.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, FArrClientes, False) Then
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobalCadClientes.edtCodRedExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRed, edtDesRed, FArrRede, fRetNomeRedeLojaSelect, Nil, 'da rede de lojas');
end;

procedure TfrmAltGlobalCadClientes.edtCodRedKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqRedeLojas(Self, edtCodRed, edtDesRed, Nil, Key, FArrRede, False) Then
    If fValidaCampos(edtCodRed, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobalCadClientes.edtCodRegExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodReg, edtNomReg, FArrRegiao, Nil, fRetNomRegiao, 'da Região');
end;

procedure TfrmAltGlobalCadClientes.edtCodRegKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqRegiao(Self, edtCodReg, edtNomReg, Nil, Key, FArrRegiao, False) Then
    If fValidaCampos(edtCodReg, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobalCadClientes.edtCodRepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRep, edtDesRep, FArrRepr, fRetNomVendRep, nil, 'da representante');
end;

procedure TfrmAltGlobalCadClientes.edtCodRepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodRep, edtDesRep, qryTabela, Key, FArrRepr, False) Then
    If fValidaCampos(edtCodRep, False) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobalCadClientes.edtCodSubExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodSub, edtDesSub, FArrSubReg, Nil, fRetNomSubRegiao, 'da sub-região');
end;

procedure TfrmAltGlobalCadClientes.edtCodSubKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqSubRegiao(Self, edtCodSub, edtDesSub, Nil, Key, FArrSubReg, False) Then
    If fValidaCampos(edtCodSub, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobalCadClientes.edtCodVenExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVen, edtNomVen, FArrVended, fRetNomeOperador, Nil, 'do Vendedor');
end;

procedure TfrmAltGlobalCadClientes.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodVen, edtNomVen, Nil, Key, FArrVended, False) Then
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobalCadClientes.edtTipCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtTipCli, edtDesTpc, FArrTipCli, Nil, fRetDescTipoCli, 'do Tipo de Cliente');
end;

procedure TfrmAltGlobalCadClientes.edtTipCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqTipoCliente(Self, edtTipCli, edtDesTpc, nil, Key, FArrTipCli, False) Then
	  If fValidaCampos(edtTipCli, True) Then
      SelectNext(ActiveControl, True, True);
end;

function TfrmAltGlobalCadClientes.fCampoLiberacaoMarcado: Boolean;
var
  cdsClone: TUniClientDataSet;
begin
  cdsClone := TUniClientDataSet.Create(nil);
  try
    cdsClone.CloneCursor(cdsParametros, True);

    cdsClone.Filtered := False;
    cdsClone.Filter   := 'MARCADO = 1 AND ( ' +
                         '  (CAMPO = ''CLI_LIMCRE'') OR ' +
                         '  (CAMPO = ''CLI_CODPOR'') OR ' +
                         '  (CAMPO = ''CLI_CODPO2'') OR ' +
                         '  (CAMPO = ''CLI_CODREP'') OR ' +
                         '  (CAMPO = ''CLI_TABPRE'') OR ' +
                         '  (CAMPO = ''CLI_TIPCLI'') OR ' +
                         '  (CAMPO = ''CLI_CODVEN''))';
    cdsClone.Filtered := True;

    Result := Not cdsClone.IsEmpty;
  finally
    FreeAndNil(cdsClone);
  end;
end;

function TfrmAltGlobalCadClientes.fCampoMarcado(strCampo: String): Boolean;
begin
  Result := False;
  If cdsParametros.Locate('CAMPO', strCampo, []) Then
    Result := cdsParametros.FieldByName('MARCADO').AsBoolean
end;

procedure TfrmAltGlobalCadClientes.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  fChamaTelaGravando(fConfirmaAlteracoes, 'Confirmando as informações, aguarde...');
end;

procedure TfrmAltGlobalCadClientes.btnLimpaFiltrosClick(Sender: TObject);
begin
  inherited;
  pLimpaCampos;
end;

procedure TfrmAltGlobalCadClientes.cdsParametrosAfterPost(DataSet: TDataSet);
begin
  inherited;
  pnlLiberacao.Visible := fCampoLiberacaoMarcado;
end;

procedure TfrmAltGlobalCadClientes.cdsParametrosMARCADOChange(Sender: TField);
begin
  inherited;
  If cdsParametrosCAMPO.AsString = 'CNDPAG' Then
    pnlCndPag.Enabled := Sender.AsBoolean;
end;

procedure TfrmAltGlobalCadClientes.cxeConsTam2PropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
Var
  strCodigo: String;
begin
  inherited;

  If Not Assigned(grdCamposTV.Controller.FocusedColumn) Then
    Exit;

  strCodigo := DisplayValue;
  If (Not fEmptyStr(strCodigo)) And (TcxTextEdit(Sender).Properties.MaxLength > 0) Then
    DisplayValue := fStrZero(strCodigo, TcxTextEdit(Sender).Properties.MaxLength);

  fRetDescricaoCadastro(cdsParametrosCAMPO.AsString, DisplayValue, True, Error);

  If Error Then
    ErrorText := ''
  Else
  If Not fValidaValor(DisplayValue) Then
  Begin
    Error := True;
    ErrorText := '';
  End
end;

procedure TfrmAltGlobalCadClientes.cxeInt03PropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
Var
  intValor: Integer;
begin
  inherited;

  If fEmptyStr(DisplayValue) Then
    Exit;

  If Not TryStrToInt(DisplayValue, intValor) Then
  Begin
    Error := True;
    ErrorText := '';
  End

  Else If Not fValidaValor(DisplayValue) Then
  Begin
    Error := True;
    ErrorText := '';
  End;
end;

procedure TfrmAltGlobalCadClientes.cxeMasPerPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
Var
  fltValor: Double;
begin
  inherited;

  If fEmptyStr(DisplayValue) Then
    Exit;

  If Not TryStrToFloat(DisplayValue, fltValor) Then
  Begin
    Error := True;
    ErrorText := '';
  End Else
  Begin

    If Not fValidaValor(DisplayValue) Then
    Begin
      Error := True;
      ErrorText := '';
    End

    Else If (Not fValidaEscala(DisplayValue, 0, 100)) Then
    Begin
      Error := True;
      ErrorText := '';

      pMensagemOk('O ' + TcxGridDBBandedColumn(grdCamposTV.Controller.FocusedColumn).Caption + ' deve estar entre 0 e 100!');
    End;

  End;
end;

procedure TfrmAltGlobalCadClientes.cxeMasValPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
Var
  fltValor: Double;
begin
  inherited;

  If fEmptyStr(DisplayValue) Then
    Exit;

  If Not TryStrToFloat(DisplayValue, fltValor) Then
  Begin
    Error := True;
    ErrorText := '';
  End Else
  Begin

    If Not fValidaValor(DisplayValue) Then
    Begin
      Error := True;
      ErrorText := '';
    End

  End;
end;

procedure TfrmAltGlobalCadClientes.cxvTiposAltEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_Return: If FqryCadCli.State = dsEdit Then
                   FqryCadCli.Post;
  End;
end;

function TfrmAltGlobalCadClientes.fTemConsultaTabela(strNomCam: String): Boolean;
Begin
  If AnsiEndsStr('_NOV', strNomCam) Then
    strNomCam := AnsiReplaceStr(strNomCam, '_NOV', '');

  Result := Pos(strNomCam,
    'CLI_CODCAC_CLI_CODRED_CLI_CODREG_CLI_CODSUB_CLI_CODATI_CLI_CODFPG_'+
    'CLI_CODPOR_CLI_CODPO2_CLI_CODREP_CLI_SUPREG_CLI_CODVEN_CLI_TIPCLI_'+
    'CLI_ENQIPI_CNDPAG_CODTRA_') > 0;
End;

function TfrmAltGlobalCadClientes.fRetDescricaoCadastro(strNomCam,
  strCodCad: String; blnValidar: Boolean; var blnErro: Boolean): String;
begin
  Result  := '';
  blnErro := False;

  If fEmptyStr(strCodCad) Then
    Exit;

  case AnsiIndexStr(strNomCam, ['CLI_CODCAC', 'CLI_CODRED', 'CLI_CODREG',
                                'CLI_CODSUB', 'CLI_CODATI', 'CLI_CODFPG',
                                'CLI_CODPOR', 'CLI_CODPO2', 'CLI_CODREP',
                                'CLI_SUPREG', 'CLI_CODVEN', 'CLI_TIPCLI',
                                'CLI_ENQIPI', 'CNDPAG',     'CODTRA'     ]) of
    0 : Result := fRetNomCanalAcesso(strCodCad);
    1 : Result := fRetNomeRedeLoja(strCodCad);
    2 : Result := fRetNomRegiao(strCodCad);

    3 : Result := fRetNomSubRegiao(strCodCad);
    4 : Result := fRetNomAtividade(strCodCad);
    5 : Result := fRetDesFpg(strCodCad);

    6 : Result := fRetNomPortador(strCodCad);
    7 : Result := fRetNomPortador(strCodCad);
    8 : Result := fRetNomeOperador(strCodCad);

    9 : Result := fRetNomeOperador(strCodCad);
    10: Result := fRetNomeOperador(strCodCad);
    11: Result := fRetDescTipoCli(strCodCad);

    12: Result := fRetDescricaoEnquadramentoIPI(strCodCad);
    13: Result := fRetDesConPag(strCodCad);
    14: Result := fRetNomTransportadora(strCodCad);
  end;

  If blnValidar And fEmptyStr(Result) Then
  Begin
    pMensagemOk('Código não encontrado!');
    blnErro := True;
  End;
end;

procedure TfrmAltGlobalCadClientes.FormCreate(Sender: TObject);
begin
  inherited;
  objLiberacao := TLiberacao.Create;
  FqryCadCli := fCriaQuery;
  FDtsCadCli := TDataSource.Create(Nil);
  FDtsCadCli.DataSet := FqryCadCli;

  FAcessoPER_FF := fVerificaAcessoSistema('PER_FF');
  FAcessoCLIMEI := fVerificaAcessoSistema('CLIMEI');
  FAcessoCLI_PR := fVerificaAcessoSistema('CLI_PR');

  pnlTipCli.Visible := fCfgSis('USATPC', varBoolean);
  pnlForPag.Visible := fCfgSis('USAFPG', varBoolean);
  pnlPeMIFF.Visible := (fPermiteEmissaoEspecie('FF')) And (fCfgSis('PEMIFF') = '2');
  pnlPeMIFV.Visible := pnlPeMIFF.Visible;
  pnlCodCnd.Visible := fCfgSis('USACND', varBoolean) and fVerificaAcessoSistema('CLCNDP');
  pnlCndPag.Visible := fCfgSis('USACND', varBoolean) and fVerificaAcessoSistema('CLCNDP');

  nbDados.PageIndex := 0;
  pCarregaTabelasPreco;
  pCarregaCategorias;
  pPreparaColunas;

  pCriaCdsSimNao;
  pCriaCdsBolImp;
  pCriaCdsRegTri;
  pCriaCdsIndCom;
  pCriaCdsTFTNES;
  pCriaCdsSitIpi;
  pCriaCdsSitP_C;
  pCriaCdsTipFre;

  objLogAltCadCli := TLogAltCadCli.Create(Self);
end;

procedure TfrmAltGlobalCadClientes.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objLiberacao);
  FreeAndNil(FDtsCadCli);
  FreeAndNil(FqryCadCli);

  If Assigned(objLogAltCadCli) Then
    FreeAndNil(objLogAltCadCli);

  inherited;
end;

procedure TfrmAltGlobalCadClientes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Escape) And (Assigned(ActiveControl)) And (ActiveControl.Name = '') Then
  Begin
    Key := 0;
    btnSair.Click;
  End;

  Case Key Of
    VK_F8 : btnLimpaFiltros.Click;
    VK_F10: btnConfirma.Click;
    VK_RETURN: If fCheckParent(ActiveControl, grdCampos) And (cdsParametros.State = dsEdit) Then
               Begin
                 cdsParametros.Post;
                 grdCamposTv.NavigatorButtons.Next.Click;
               End;
  End;
end;

function TfrmAltGlobalCadClientes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (sender = edtSituacao) Then
  Begin
    If (Pos(edtSituacao.Text, 'AIT') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Preencha o campo "Situação" corretamente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (sender = edtConsum) Then
  Begin
    If (Not fEmptyStr(edtConsum.Text)) and (Pos(edtConsum.Text, 'SN') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Preencha o campo "Consumidor Final" corretamente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (sender = edtPermFF) Then
  Begin
    If (Not fEmptyStr(edtPermFF.Text)) and (Pos(edtPermFF.Text, 'SN') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Preencha o campo "Permitir FF (A Prazo)" corretamente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (sender = edtPermFV) Then
  Begin
    If (Not fEmptyStr(edtPermFV.Text)) and (Pos(edtPermFV.Text, 'SN') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Preencha o campo "Permitir FF (À Vista)" corretamente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (sender = edtRevist) Then
  Begin
    If (Not fEmptyStr(edtRevist.Text)) and (Pos(edtRevist.Text, 'SN') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Preencha o campo "Revista" corretamente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtTabPre) Then
  Begin
    If (Not fEmptyStr(edtTabPre.Text)) and (Pos( edtTabPre.Text, FstrVrfTpr ) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Entre com uma opção válida para a tabela de ' + clbPrcVenda.Caption + '!', ['&Ok']);
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmAltGlobalCadClientes.cdsParametrosBeforePost(DataSet: TDataSet);
  Var
    blnErro : Boolean;
    strDescri : String;
    blnMarcado : Boolean;
begin
  inherited;
  blnMarcado :=  True;

  If cdsParametrosVALOR.IsNull Or fEmptyStr(cdsParametrosVALOR.AsString) Then
  Begin
    cdsParametrosDESVAL.Clear;
    cdsParametrosVALOR.Clear;

    blnMarcado := False;
  End
  Else If fTemConsultaTabela(cdsParametrosCAMPO.AsString) Then
  Begin
    If (Pos(cdsParametrosCAMPO.AsString, 'CLI_CODCAC_CLI_CODRED_CLI_CODREG_CLI_CODSUB_CLI_CODPOR_CLI_CODPO2') > 0 ) Then
      cdsParametrosVALOR.AsString := fStrZero(cdsParametrosVALOR.AsString, 5)
    Else
      cdsParametrosVALOR.AsString := fStrZero(cdsParametrosVALOR.AsString, 3);

    strDescri := fRetDescricaoCadastro(cdsParametrosCAMPO.AsString, cdsParametrosVALOR.AsString, False, blnErro);

    If fEmptyStr(strDescri) Then
    Begin
      cdsParametrosDESVAL.Clear;
      cdsParametrosVALOR.Clear;

      blnMarcado := False;
    End
    Else
      cdsParametrosDESVAL.AsString := strDescri;
  End;

  cdsParametrosMARCADO.AsBoolean := blnMarcado;
end;

Procedure TfrmAltGlobalCadClientes.pSalva(strDado: String; var Key: Char);
Begin
  Key := #0;
  cdsParametros.Edit;
  cdsParametrosVALOR.AsString := strDado;
  Key := #0;

  Keybd_Event(VK_RETURN, 0, 0, 0);
End;

procedure TfrmAltGlobalCadClientes.grdCamposTvKeyPress(Sender: TObject;
  var Key: Char);
   Var
    arrSelecao: TConsultasArray;
    qryDados: TUniQuery;
begin
  inherited;

  If fEntraCons(Key) And
     fTemConsultaTabela(cdsParametrosCAMPO.AsString) Then
  Begin
    qryDados := fCriaQuery;
    Try
      Case AnsiIndexStr(cdsParametrosCAMPO.AsString,
                         ['CLI_CODCAC', 'CLI_CODRED', 'CLI_CODREG',
                          'CLI_CODSUB', 'CLI_CODATI', 'CLI_CODFPG',
                          'CLI_CODPOR', 'CLI_CODPO2', 'CLI_CODREP',
                          'CLI_SUPREG', 'CLI_CODVEN', 'CLI_TIPCLI',
                          'CLI_ENQIPI', 'CNDPAG',     'CODTRA'     ]) Of
        0 :
          Begin
            If fPesqCanalAcesso(Self, Nil, Nil, qryDados, Key, arrSelecao, True) And (Not fEmptyStr(qryDados.FieldByName('CAC_CODCAC').AsString)) Then
              pSalva(qryDados.FieldByName('CAC_CODCAC').AsString, Key);
          End;

        1 :
          Begin
            If fPesqRedeLojas(Self, Nil, Nil, qryDados, Key, arrSelecao, True) And (Not fEmptyStr(qryDados.FieldByName('RED_CODRED').AsString)) Then
              pSalva(qryDados.FieldByName('RED_CODRED').AsString, Key);
          End;

        2 :
          Begin
            If fPesqRegiao(Self, Nil, Nil, qryDados, Key, arrSelecao, True) And (Not fEmptyStr(qryDados.FieldByName('REG_CODREG').AsString)) Then
              pSalva(qryDados.FieldByName('REG_CODREG').AsString, Key);
          End;

        3 :
          Begin
            If fPesqSubRegiao(Self, Nil, Nil, qryDados, Key, arrSelecao, True) And (Not fEmptyStr(qryDados.FieldByName('SUB_CODSUB').AsString)) Then
              pSalva(qryDados.FieldByName('SUB_CODSUB').AsString, Key);
          End;

        4 :
          Begin
            If fPesqAtividade(Self, Nil, Nil, qryDados, Key, arrSelecao, True) And (Not fEmptyStr(qryDados.FieldByName('ATI_CODATI').AsString)) Then
              pSalva(qryDados.FieldByName('ATI_CODATI').AsString, Key);
          End;

        5 :
          Begin
            If fPesqFormaPgto(conFpgSimples, Self, Nil, Nil, qryDados, Key, arrSelecao, True) And (Not fEmptyStr(qryDados.FieldByName('FPG_CODIGO').AsString)) Then
              pSalva(qryDados.FieldByName('FPG_CODIGO').AsString, Key);
          End;

        6 :
          Begin
            If fPesqPortador(conSimples, Self, Nil, Nil, qryDados, Key, arrSelecao, True) And (Not fEmptyStr(qryDados.FieldByName('POR_CODPOR').AsString)) Then
              pSalva(qryDados.FieldByName('POR_CODPOR').AsString, Key);
          End;

        7 :
          Begin
            If fPesqPortador(conSimples, Self, Nil, Nil, qryDados, Key, arrSelecao, True) And (Not fEmptyStr(qryDados.FieldByName('POR_CODPOR').AsString)) Then
              pSalva(qryDados.FieldByName('POR_CODPOR').AsString, Key);
          End;

        8 :
          Begin
            If fPesqOperador(Self, Nil, Nil, qryDados, Key, arrSelecao, True) And (Not fEmptyStr(qryDados.FieldByName('OPE_CODOPE').AsString)) Then
              pSalva(qryDados.FieldByName('OPE_CODOPE').AsString, Key);
          End;

        9 :
          Begin
            If fPesqOperador(Self, Nil, Nil, qryDados, Key, arrSelecao, True) And (Not fEmptyStr(qryDados.FieldByName('OPE_CODOPE').AsString)) Then
              pSalva(qryDados.FieldByName('OPE_CODOPE').AsString, Key);
          End;

        10 :
          Begin
            If fPesqOperador(Self, Nil, Nil, qryDados, Key, arrSelecao, True) And (Not fEmptyStr(qryDados.FieldByName('OPE_CODOPE').AsString)) Then
              pSalva(qryDados.FieldByName('OPE_CODOPE').AsString, Key);
          End;

        11 :
          Begin
            If fPesqTipoCliente(Self, Nil, Nil, qryDados, Key, arrSelecao, True) And (Not fEmptyStr(qryDados.FieldByName('TIP_CODTIP').AsString)) Then
              pSalva(qryDados.FieldByName('TIP_CODTIP').AsString, Key);
          End;

        12 :
          Begin
            If (AnsiMatchStr(fRetornaValorDoCampo('CLI_SITIPI'), ['M', 'S'])) Then
              If fPesqEnquadramentoIPI(Self, Nil, Nil, qryDados, Key, arrSelecao, True) And (Not fEmptyStr(qryDados.FieldByName('EQI_CODIGO').AsString)) Then
                pSalva(qryDados.FieldByName('EQI_CODIGO').AsString, Key);
          End;

        13 :
          Begin
            If fPesqCondicoesPgto(Self, Nil, Nil, qryDados, Key, arrSelecao, True) And (Not fEmptyStr(qryDados.FieldByName('CND_CODIGO').AsString)) Then
              pSalva(qryDados.FieldByName('CND_CODIGO') .AsString, Key);
          End;

        14 :
          Begin
            If fPesqTransportadora(conTraSimples, Self, Nil, Nil, qryDados, Key, arrSelecao, True) And (Not fEmptyStr(qryDados.FieldByName('TRA_CODTRA').AsString)) Then
              pSalva(qryDados.FieldByName('TRA_CODTRA').AsString, Key);
          End;
      end;
    Finally
      FreeAndNil(qryDados);
    End;
  End;
end;

function TfrmAltGlobalCadClientes.fRetornaValorDoCampo(strCampo: String):String;
  Var
    cdsClone : TUniClientDataSet;
begin
  cdsClone := TUniClientDataSet.Create(nil);
  try
    pCloneDataSet(cdsClone, cdsParametros);

    cdsClone.Filtered := False;
    cdsClone.Filter   := 'CAMPO='+QuotedStr(strCampo);
    cdsClone.Filtered := True;

    Result := cdsClone.FieldByName('VALOR').AsString;
  finally
    FreeAndNil(cdsClone);
  end;
end;

procedure TfrmAltGlobalCadClientes.grdCamposMARCADOPropertiesChange(
  Sender: TObject);
begin
  inherited;
  If (Not cdsParametrosMARCADO.AsBoolean) Then
  Begin
    If cdsParametros.State <> dsEdit Then
      cdsParametros.Edit;

    cdsParametrosVALOR.Clear;
    cdsParametros.Post;
  End
  Else
    grdCamposVALOR.Focused := True;
end;

procedure TfrmAltGlobalCadClientes.grdCamposTvEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  AAllow := True;

  If cdsParametrosCAMPO.AsString  = 'CLI_MENIPI' Then
    AAllow := fRetornaValorDoCampo('CLI_SITIPI') <> 'T'
  Else
  If cdsParametrosCAMPO.AsString = 'CLI_MENP_C' Then
    AAllow := fRetornaValorDoCampo('CLI_SITP_C') <> 'T'
  Else
  If cdsParametrosCAMPO.AsString = 'CLI_ENQIPI' Then
    AAllow := AnsiMatchStr(fRetornaValorDoCampo('CLI_SITIPI'), ['M', 'S'])
  Else
  If cdsParametrosCAMPO.AsString = 'CLI_REDISS' Then
    AAllow := StrToIntDef(fRetornaValorDoCampo('CLI_ALQISS'), 0) > 0
  Else
  If cdsParametrosCAMPO.AsString = 'CLI_PERMFF' Then
    AAllow := FAcessoPER_FF
  Else
  If cdsParametrosCAMPO.AsString = 'CLI_PERMFV' Then
    AAllow := FAcessoPER_FF
  Else
  If cdsParametrosCAMPO.AsString = 'CLI_MICEMP' Then
    AAllow := FAcessoCLIMEI
  Else
  If cdsParametrosCAMPO.AsString = 'CLI_PRORUR' Then
    AAllow := FAcessoCLI_PR
end;

procedure TfrmAltGlobalCadClientes.grdCamposTvEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  inherited;
  grdCamposTvKeyPress(Sender, Key);
end;

procedure TfrmAltGlobalCadClientes.grdCamposVALORGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
  Const
    strMasFat: String = '#,##0.0000';
    strMasPer: String = '#,##0.00';
    strMasVal: String = '#,##0.0000';
    strMasInt: String = '#,##0';
begin
  inherited;

  If Not (Assigned(ARecord)) Then
    Exit;

  If fEmptyStr(AText) Then
    Exit;

  If SameText(VarToString(ARecord.Values[grdCamposPROPER.Index]), 'cxeMasFat') Then
    AText := FormatFloat(strMasFat, fStrToFloat(AText))

  Else If SameText(VarToString(ARecord.Values[grdCamposPROPER.Index]), 'cxeMasPer') Then
    AText := FormatFloat(strMasPer, fStrToFloat(AText))

  Else If SameText(VarToString(ARecord.Values[grdCamposPROPER.Index]), 'cxeMasVal') Then
    AText := FormatFloat(strMasVal, fStrToFloat(AText))

  Else If SameText(VarToString(ARecord.Values[grdCamposPROPER.Index]), 'cxeMasInt') Then
    AText := FormatFloat(strMasInt, fStrToFloat(AText))

  Else If fTemConsultaTabela(VarToString(ARecord.Values[grdCamposCAMPO.Index])) And
          (Not fEmptyStr(AText)) Then
    AText := AText + ' - ' + VarToString(ARecord.Values[grdCamposDESVAL.Index]);
end;

procedure TfrmAltGlobalCadClientes.grdCamposVALORGetProperties(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
  Var
    intIdx: Integer;
begin
  inherited;

  If Not (Assigned(ARecord)) Then
    Exit;

  intIdx := grdCamposPROPER.Index;

  If (ARecord.Values[intIdx] <> Null) Then
    pRetProperties(VarToString(ARecord.Values[intIdx]), AProperties);
end;

Procedure TfrmAltGlobalCadClientes.pRetProperties(strNomProp: String; var AProperties: TcxCustomEditProperties);
Begin
  If Assigned(FindComponent(strNomProp)) Then
    AProperties := TcxEditRepositoryItem(FindComponent(strNomProp)).Properties;
End;

procedure TfrmAltGlobalCadClientes.grdCamposVALORStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  inherited;

  If Not (Assigned(ARecord)) Then
    Exit;

  If (ARecord.Values[grdCamposPROPER.Index] <> Null) And
     (AnsiStartsStr('cmb', VarToString(ARecord.Values[grdCamposPROPER.Index]))) Then
  Begin
    AStyle := cxsCombo
  End
  Else
  If (fTemConsultaTabela(VarToString(ARecord.Values[grdCamposCAMPO.Index]))) Then
    AStyle := cxsConsulta;
end;

procedure TfrmAltGlobalCadClientes.pIncluiCampo(strNomCam, strTitulo: String;
  blnVisible: Boolean; proProperties: TcxEditRepositoryItem; strFieldDesc,
  strFieldDescTitle: String);
var
  intContador: Integer;
  Campo: TCampoGlobal;
begin
   intContador := Length(FArrCampos);
   SetLength(FArrCampos, intContador + 1);

   Campo.strNomCam  := strNomCam;
   Campo.strDesCam  := strTitulo;

   If Assigned(proProperties) Then
     Campo.strProper := proProperties.ToString
   Else
     Campo.strProper := '';

   FArrCampos[intContador] := Campo;
end;

procedure TfrmAltGlobalCadClientes.pIncluiParametro(const strAba, strCampo,
  strDescricao: String; proProperties: TcxEditRepositoryItem; const blnMarcado: boolean = False);
Begin

  If Not cdsParametros.Active Then
  Begin
    cdsParametros.CreateDataSet;
    cdsParametros.LogChanges := False;
    cdsParametros.Open();
  End;

  cdsParametros.Append;
  cdsParametrosMARCADO.AsBoolean := IIf(blnMarcado, 1, 0);
  cdsParametrosABA.AsString      := strAba;
  cdsParametrosCAMPO.AsString    := strCampo;
  cdsParametrosDESCRI.AsString   := strDescricao;

  If Assigned(proProperties) Then
    cdsParametrosPROPER.AsString := proProperties.Name
  Else
    cdsParametrosPROPER.AsString := '';

  cdsParametros.Post;
End;

function TfrmAltGlobalCadClientes.fVerificaFiltros: Boolean;
begin
  Result := False;

  If (Not fEmptyStr(edtCodCli.Text)) Or (Not fEmptyStr(edtCep.Text)) Or
	   (Not fEmptyStr(edtCodCid.Text)) Or (Not fEmptyStr(edtEstado.Text)) Or
     (Not fEmptyStr(edtBairro.Text)) Or (Not fEmptyStr(edtCodReg.Text)) Or
     (Not fEmptyStr(edtCodSub.Text)) Or (Not fEmptyStr(edtCodRed.Text)) Or
     (Not fEmptyStr(edtCodCac.Text)) Or (Not fEmptyStr(edtCodVen.Text)) Or
	   (Not fEmptyStr(edtCodRep.Text)) Or (Not fEmptyStr(cmbCategoria.Text)) Or
     (AnsiIndexStr(edtSituacao.Text, ['I', 'A']) >= 0) Or
     (Not fEmptyStr(edtConsum.Text)) Or (Not fEmptyStr(edtPermFF.Text)) Or
     (Not fEmptyStr(edtPermFV.Text)) Or (Not fEmptyStr(edtRevist.Text)) Or
     (Not fEmptyStr(edtTabPre.Text)) Or (Not fEmptyStr(edtCodAti.Text)) Or
     (Not fEmptyStr(edtCodFpg.Text)) Or (Not fEmptyStr(edtCodPor.Text)) Or
     (Not fEmptyStr(edtCodPor2.Text)) Or (Not fEmptyStr(edtTipCli.Text)) Or
	   (Not fEmptyStr(edtCodCnd.Text)) Then
  Begin
    Exit(True);
  End;
end;

procedure TfrmAltGlobalCadClientes.pLimpaCampos;
begin
  edtCodCli.Clear;
  edtDesCli.Clear;
  edtCodCid.Clear;
  edtNomCid.Clear;
  edtCodReg.Clear;
  edtNomReg.Clear;
  edtNomVen.Clear;
  edtCodVen.Clear;
  edtEstado.Clear;
  edtBairro.Clear;
  edtCodRep.Clear;
  edtDesRep.Clear;
  edtCodRed.Clear;
  edtDesRed.Clear;
  edtCodCac.Clear;
  edtDesCac.Clear;
  edtDesSub.Clear;
  edtCodSub.Clear;
  cmbCategoria.Items.Clear;
  edtCep.Clear;
  edtCodCnd.Clear;
  edtDesCnd.Clear;
  edtTipCli.Clear;
  edtDesTpc.Clear;
  edtCodPor2.Clear;
  edtNomPor2.Clear;
  edtCodPor.Clear;
  edtNomPor.Clear;
  edtCodFpg.Clear;
  edtDesFpg.Clear;
  edtCodAti.Clear;
  edtDesAti.Clear;

  edtSituacao.Text := 'T';
  edtConsum.Clear;
  edtPermFF.Clear;
  edtPermFV.Clear;
  edtRevist.Clear;
  edtTabPre.Clear;

  pSetFocus(edtCodCli);

  If Assigned(objLogAltCadCli) Then
    objLogAltCadCli.LogVar.Clear;
end;

procedure TfrmAltGlobalCadClientes.pPreparaColunas;
const
  ABA_GERAL = 'Geral';
  ABA_COMPL = 'Complementos';
  ABA_FISCA = 'Dados Fiscais';
  ABA_CNDPG = 'Condições de Pagamento';
  ABA_COBRA = 'Dados de Cobrança';
  ABA_ENDER = 'Endereços de Entrega';
begin
  cdsParametros.DisableControls;
  Try
    pAddColuna(ABA_GERAL, 'CLI_NOMCLI', 'Nome/Razão');
    pAddColuna(ABA_COMPL, 'CLI_CODCAC', 'Canal de Acesso', cxeConsTam5, True, 'CAC_NOMCAC', 'Desc. Canal de Acesso');
    pAddColuna(ABA_COMPL, 'CLI_CATEGO', 'Categoria', cmbPropCategoria);
    pAddColuna(ABA_COMPL, 'CLI_PERCOM', 'Comissão', cxeMasPer, (fCfgSis('OPCCOM') = 'CV'));
    pAddColuna(ABA_COMPL, 'CLI_DESCON', 'Desconto para Profissionais', cxeMasPer, (fCfgSis('CLIDES', varBoolean)));
    pAddColuna(ABA_COMPL, 'CLI_PEREMP', 'Permite empréstimo', cmbSimNao, (fCfgSis('PREMEP', varBoolean)));
    pAddColuna(ABA_COMPL, 'CLI_PERAGU', 'Permitir Entrega Futura com Status "Aguardando o Cliente"', cmbSimNao);
    pAddColuna(ABA_COMPL, 'CLI_PERFAL', 'Permitir Entrega Futura com Status "Falta de Produto"', cmbSimNao);
    pAddColuna(ABA_COMPL, 'CLI_PERPRE', 'Permitir Entrega Futura com Status "Previsão de Entrega"', cmbSimNao);
    pAddColuna(ABA_COMPL, 'CLI_PERMFF', 'Permitir FF (A Prazo)', cmbSimNao, (fPermiteEmissaoEspecie('FF')) And (fCfgSis('PEMIFF') = '2'));
    pAddColuna(ABA_COMPL, 'CLI_PERMFV', 'Permitir FF (À Vista)', cmbSimNao, (fPermiteEmissaoEspecie('FF')) And (fCfgSis('PEMIFF') = '2'));
    pAddColuna(ABA_COMPL, 'CLI_CODRED', 'Rede de Lojas', cxeConsTam5, True, 'RED_DESRED', 'Desc. Rede de Lojas');
    pAddColuna(ABA_COMPL, 'CLI_CODREG', 'Região', cxeConsTam5, True, 'REG_DESREG', 'Desc. Região');
    pAddColuna(ABA_COMPL, 'CLI_REVIST', 'Revista', cmbSimNao);
    pAddColuna(ABA_COMPL, 'CLI_CODSUB', 'Sub-Região', cxeConsTam5, True, 'SUB_DESSUB', 'Desc. Região');
    pAddColuna(ABA_COMPL, 'CLI_ITEBAS', 'Permitir venda de "Produto Base"?', cmbSimNao);
    pAddColuna(ABA_COMPL, 'CLI_ITEPIG', 'Permitir venda de "Produto Pigmento"?', cmbSimNao);
    pAddColuna(ABA_COMPL, 'CLI_EXPXML', 'Exportar XML?', cmbSimNao, (fCfgSis('FEXMLV', varBoolean)));
    pAddColuna(ABA_CNDPG, 'CNDPAG',     'Condição de Pagamento', cxeConsTam3, fCfgSis('USACND', varBoolean) and fVerificaAcessoSistema('CLCNDP'), 'DESCND', 'Desc. Condição de Pagamento');
    pAddColuna(ABA_COBRA, 'CLI_ENVBOL', 'Enviar boleto por e-mail', cmbSimNao);
    pAddColuna(ABA_COBRA, 'CLI_BOLIMP', 'Impressão do boleto pelo faturamento será feita por', cmbBolImp);
    pAddColuna(ABA_COBRA, 'CLI_PROPER', 'Utilizar controle de protesto personalizado por cliente', cmbSimNao);
    pAddColuna(ABA_FISCA, 'CLI_ALQISS', 'Alíquota de ISS', cxeMasPer);
    pAddColuna(ABA_FISCA, 'CLI_RECAP_', 'Benefício Fiscal RECAP', cmbSimNao);
    pAddColuna(ABA_FISCA, 'CLI_BENREI', 'Benefício REIDI', cmbSimNao);
    pAddColuna(ABA_FISCA, 'CLI_CODCNA', 'CNAE', cxeCodCna);
    pAddColuna(ABA_FISCA, 'CLI_CDESPI', 'Calcula desconto de PIS/COFINS/IRPJ/CSLL', cmbSimNao, (Not fCfgSis('SIMPAU', varBoolean)) And (not fCfgSis('RETIMP', varBoolean)));
    pAddColuna(ABA_FISCA, 'CLI_CODEAC', 'Cobrar Despesas Acessórias', cmbSimNao);
    pAddColuna(ABA_FISCA, 'CLI_TAXENT', 'Cobrar Taxa de Entrega', cmbSimNao, fCfgSis('TAXENT', varBoolean));
    pAddColuna(ABA_FISCA, 'CLI_PRSTRE', 'Código do processo Sujeito passivo por ST atribuída por regime especial', cxeString40);
    pAddColuna(ABA_FISCA, 'CLI_RETPCO', 'Retém PIS e Cofins', cmbSimNao, (Not fCfgSis('SIMPAU', varBoolean)) and (Not fCfgSis('RETIMP', varBoolean)));
    pAddColuna(ABA_FISCA, 'CLI_ICMREI', 'Deduzir ICMS do Benefício REIDI', cmbSimNao);
    pAddColuna(ABA_FISCA, 'CLI_DESOPE', 'Despesas Operacionais Complementar', cxeMasPer, fCfgSis('CLIDOP', varBoolean));
    pAddColuna(ABA_FISCA, 'CLI_ENQIPI', 'Enquadramento IPI', cxeConsTam3, True, 'EQI_DESCRI', 'Desc. Enquadramento IPI');
    pAddColuna(ABA_FISCA, 'CLI_TFTNES', 'Fator Nota Especial', cxeString01, fCfgSis('FTNFES', varBoolean));
    pAddColuna(ABA_FISCA, 'CLI_INDUST', 'Indústria', cmbSimNao);
    pAddColuna(ABA_FISCA, 'CLI_IVAESP', 'IVA Especial com carga média para "MT/CE" (Produtos Importados)', cxeMasVal);
    pAddColuna(ABA_FISCA, 'CLI_IVANAC', 'IVA Especial com carga média para "MT/CE" (Produtos Nacionais)', cxeMasVal);
    pAddColuna(ABA_FISCA, 'CLI_CEDESP', 'IVA Especial-Itens c/NCM no CEDEM-com carga média para "MT/CE" (Prod. Importados)', cxeMasVal);
    pAddColuna(ABA_FISCA, 'CLI_CEDNAC', 'IVA Especial-Itens c/NCM no CEDEM-com carga média para "MT/CE" (Prod. Nacionais)', cxeMasVal);
    pAddColuna(ABA_FISCA, 'CLI_MENIPI', 'Mensagem IPI', cxeMemo);
    pAddColuna(ABA_FISCA, 'CLI_MENP_C', 'Mensagem PIS/COFINS', cxeMemo);
    pAddColuna(ABA_FISCA, 'CLI_IVASIM', 'Percentual carga média para "MT/CE" (CNAE Simplificado)', cxeMasPer);
    pAddColuna(ABA_FISCA, 'CLI_CEDSIM', 'Percentual-Itens c/NCM no CEDEM-carga média para "MT/CE" (CNAE Simplificado)', cxeMasPer);
    pAddColuna(ABA_FISCA, 'CLI_SIBICM', 'Quando IVA Especial "MT", somar IPI na base de ICMS', cmbSimNao);
    pAddColuna(ABA_FISCA, 'CLI_REDISS', 'Redução Base Cálculo do ISS', cxeMasPer);
    pAddColuna(ABA_FISCA, 'CLI_REDICM', 'Redução de Base de ICMS para produtos tributados', cxeMasPer);
    pAddColuna(ABA_FISCA, 'CLI_REGTRI', 'Regime Tributário', cxeRegTri);
    pAddColuna(ABA_FISCA, 'CLI_RETIRF', 'Retém IRPJ', cmbSimNao, (Not fCfgSis('SIMPAU', varBoolean)) and (Not fCfgSis('RETIMP', varBoolean)));
    pAddColuna(ABA_FISCA, 'CLI_RETISS', 'Retém ISS', cmbSimNao);
    pAddColuna(ABA_FISCA, 'CLI_SEGSOC', 'Seguridade Social', cmbSimNao);
    pAddColuna(ABA_FISCA, 'CLI_SITIPI', 'Situação IPI', cxeSitIpi);
    pAddColuna(ABA_FISCA, 'CLI_SITP_C', 'Situação PIS/COFINS', cxeSitP_C);
    pAddColuna(ABA_FISCA, 'CLI_SUFRAM', 'Suframa', cxeString20);
    pAddColuna(ABA_FISCA, 'CLI_INDCOM', 'Sugestão para Industrialização ou Comercialização', cxeIndCom, fCfgSis('INDCOM', varBoolean));
    pAddColuna(ABA_FISCA, 'CLI_STREES', 'Sujeito passivo por ST atribuída por regime especial', cmbSimNao);
    pAddColuna(ABA_FISCA, 'CLI_TFTNES', 'Tipo de Fator Nota Especial', cxeTFTNES, fCfgSis('FTNFES', varBoolean));
    pAddColuna(ABA_FISCA, 'CLI_DIFERI', 'Utilizar diferimento de ICMS', cmbSimNao);
    pAddColuna(ABA_FISCA, 'CLI_DIF_ST', 'Utilizar diferimento de ST', cmbSimNao, fCfgSis('EMPDIS', varBoolean));
    pAddColuna(ABA_FISCA, 'CLI_ZONFRA', 'Zona Franca', cmbSimNao);
    pAddColuna(ABA_ENDER, 'TIPFRE', 'Tipo de Frete', cxeTipFre);
    pAddColuna(ABA_ENDER, 'CODTRA', 'Transportadora', cxeConsTam5, True, 'NOMTRA', 'Nome Transportadora');
    pAddColuna(ABA_GERAL, 'CLI_CODATI', 'Atividade', cxeConsTam3, True, 'ATI_DESATI', 'Desc. Atividade');
    pAddColuna(ABA_GERAL, 'CLI_CONSUM', 'Consumidor Final', cmbSimNao);
    pAddColuna(ABA_GERAL, 'CLI_CODFPG', 'Forma de Pagamento', cxeConsTam3, True, 'FPG_DESCRI', 'Desc. Forma de Pagamento');
    pAddColuna(ABA_GERAL, 'CLI_LIMCRE', 'Limite de Crédito', cxeMasVal);
    pAddColuna(ABA_GERAL, 'CLI_MICEMP', 'MEI - Micro Empreendedor Individual', cmbSimNao);
    pAddColuna(ABA_GERAL, 'CLI_CODPOR', 'Portador (1)', cxeConsTam5, True, 'POR_NOMPOR', 'Desc. Portador (1)');
    pAddColuna(ABA_GERAL, 'CLI_CODPO2', 'Portador (2)', cxeConsTam5, True, 'POR_NOMPO2', 'Desc. Portador (2)');
    pAddColuna(ABA_GERAL, 'CLI_PRORUR', 'Produtor Rural', cmbSimNao);
    pAddColuna(ABA_GERAL, 'CLI_CODREP', 'Representante', cxeConsTam3, True, 'OPE_NOMREP', 'Nome Representante');
    pAddColuna(ABA_GERAL, 'CLI_SUPREG', 'Supervisor Regional', cxeConsTam3, True, 'OPE_SUPREG', 'Nome Supervisor Regional');
    pAddColuna(ABA_GERAL, 'CLI_TABPRE', 'Tabela de Preço', cmbTabPre);
    pAddColuna(ABA_GERAL, 'CLI_TIPCLI', 'Tipo de Cliente', cxeConsTam3, fCfgSis('USATPC', varBoolean), 'TIP_DESTIP', 'Desc. Tipo de Cliente');
    pAddColuna(ABA_GERAL, 'CLI_CODVEN', 'Vendedor', cxeConsTam3, True, 'OPE_NOMVEN', 'Nome Vendedor');
    pAddColuna(ABA_GERAL, 'CLI_EMAIL_', 'E-Mail - 1');
    pAddColuna(ABA_GERAL, 'CLI_EMAIL3', 'E-Mail NFe');
    pAddColuna(ABA_GERAL, 'CLI_EMAIL2', 'E-Mail NFe 2');
    pAddColuna(ABA_GERAL, 'CLI_EMNTDE', 'Emite Nota de Débito', cmbSimNao);
    cdsParametros.First;
  Finally
    cdsParametros.EnableControls;
  End;
end;

function TfrmAltGlobalCadClientes.fRetSqlSeTemValor(strCampo, strSql: String): String;
begin
  Result := '';
  If Not fEmptyStr(strCampo) Then
    Result := strSql;
end;

function TfrmAltGlobalCadClientes.fRetSql: String;
var
  strSQL: String;
begin
  cdsParametros.DisableControls;
  try
    strSQL := '';
    strSQL := strSQL + 'SELECT' + sLineBreak;
    strSQL := strSQL + '  CADCLI.CLI_CODCLI ' + sLineBreak;
    strSQL := strSQL + '  ,CADCLI.CLI_NOMCLI ' + sLineBreak;
    strSQL := strSQL + '  ,CADCLI.CLI_C_G_C_ ' + sLineBreak;
    strSQL := strSQL + '  ,"N" AS ALTERADO' + sLineBreak;
    strSQL := strSQL + '  , "M" AS CLI_MARDES ' + sLineBreak;

    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_CODCAC', '  ,CAC_NOMCAC' + sLineBreak + '  ,CAC_NOMCAC AS CAC_NOMCAC_ORI' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_CODRED', '  ,RED_DESRED' + sLineBreak + '  ,RED_DESRED AS RED_DESRED_ORI' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_CODREG', '  ,REG_DESREG' + sLineBreak + '  ,REG_DESREG AS REG_DESREG_ORI' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_CODSUB', '  ,SUB_DESSUB' + sLineBreak + '  ,SUB_DESSUB AS SUB_DESSUB_ORI' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_CODATI', '  ,ATI_DESATI' + sLineBreak + '  ,ATI_DESATI AS ATI_DESATI_ORI' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_CODFPG', '  ,FPG_DESCRI' + sLineBreak + '  ,FPG_DESCRI AS FPG_DESCRI_ORI' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_CODPOR', '  ,CADPOR.POR_NOMPOR' + sLineBreak + '  ,CADPOR.POR_NOMPOR AS POR_NOMPOR_ORI' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_CODPO2', '  ,CADPO2.POR_NOMPOR AS POR_NOMPO2' + sLineBreak + '  ,CADPO2.POR_NOMPOR AS POR_NOMPO2_ORI' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_CODREP', '  ,OPEREP.OPE_NOMOPE AS OPE_NOMREP' + sLineBreak + '  ,OPEREP.OPE_NOMOPE AS OPE_NOMREP_ORI' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_SUPREG', '  ,OPESUP.OPE_NOMOPE AS OPE_SUPREG' + sLineBreak + '  ,OPESUP.OPE_NOMOPE AS OPE_SUPREG_ORI' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_CODVEN', '  ,OPEVEN.OPE_NOMOPE AS OPE_NOMVEN' + sLineBreak + '  ,OPEVEN.OPE_NOMOPE AS OPE_NOMVEN_ORI' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_TIPCLI', '  ,TIP_DESTIP' + sLineBreak + '  ,TIP_DESTIP AS TIP_DESTIP_ORI' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_ENQIPI', '  ,EQI_DESCRI' + sLineBreak + '  ,EQI_DESCRI AS EQI_DESCRI_ORI' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CNDPAG', '  ,"" AS CNDPAG' + sLineBreak + '  ,"" AS CNDPAG_ORI' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CODTRA', '  ,"" AS CODTRA' + sLineBreak + '  ,"" AS CODTRA_ORI' + sLineBreak + '  ,"" AS NOMTRA' + sLineBreak + '  ,"" AS NOMTRA_ORI' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('TIPFRE', '  ,"" AS TIPFRE' + sLineBreak + '  ,"" AS TIPFRE_ORI' + sLineBreak);

    cdsParametros.First;
    While Not cdsParametros.Eof do
    begin
      If cdsParametrosMARCADO.AsBoolean and cdsParametrosCAMPO.AsString.StartsWith('CLI_') Then
      Begin
         strSQL := strSQL + '  ,' + cdsParametrosCAMPO.AsString + sLineBreak;
         strSQL := strSQL + '  ,' + cdsParametrosCAMPO.AsString +  ' AS ' + cdsParametrosCAMPO.AsString + '_ORI' + sLineBreak;
      End;

      cdsParametros.Next;
    end;

    strSQL := strSQL + 'FROM CADCLI' + sLineBreak;
    strSQL := strSQL + 'LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID' + sLineBreak;
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_CODCAC', 'LEFT JOIN CADCAC ON CAC_CODCAC = CLI_CODCAC' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_CODRED', 'LEFT JOIN CADRED ON RED_CODRED = CLI_CODRED' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_CODREG', 'LEFT JOIN CADREG ON REG_CODREG = CLI_CODREG' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_CODSUB', 'LEFT JOIN CADSUB ON SUB_CODSUB = CLI_CODSUB' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_CODATI', 'LEFT JOIN CADATI ON ATI_CODATI = CLI_CODATI' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_CODFPG', 'LEFT JOIN CADFPG ON FPG_CODIGO = CLI_CODFPG' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_CODPOR', 'LEFT JOIN CADPOR ON CADPOR.POR_CODPOR = CLI_CODPOR' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_CODPO2', 'LEFT JOIN CADPOR AS CADPO2 ON CADPO2.POR_CODPOR = CLI_CODPO2' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_CODREP', 'LEFT JOIN CADOPE AS OPEREP ON OPEREP.OPE_CODOPE = CLI_CODREP' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_SUPREG', 'LEFT JOIN CADOPE AS OPESUP ON OPESUP.OPE_CODOPE = CLI_SUPREG' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_CODVEN', 'LEFT JOIN CADOPE AS OPEVEN ON OPEVEN.OPE_CODOPE = CLI_CODVEN' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_TIPCLI', 'LEFT JOIN TIPCLG ON TIP_CODTIP = CLI_TIPCLI' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CLI_ENQIPI', 'LEFT JOIN ENQIPI ON EQI_CODIGO = CLI_ENQIPI' + sLineBreak);

    strSQL := strSQL + 'WHERE TRUE' + sLineBreak;

    strSQL := strSQL + fStrLocate(edtCodCli  , FArrClientes  , 'CLI_CODCLI', 'CODCLI');
    strSQL := strSQL + fStrLocate(edtCodCid  , FArrCidade    , 'CLI_CODCID', 'CODCID');
    strSQL := strSQL + fStrLocate(edtCodRed  , FArrRede      , 'CLI_CODRED', 'CODRED');
    strSQL := strSQL + fStrLocate(edtCodReg  , FArrRegiao    , 'CLI_CODREG', 'CODREG');
    strSQL := strSQL + fStrLocate(edtCodVen  , FArrVended    , 'CLI_CODVEN', 'CODVEN');
    strSQL := strSQL + fStrLocate(edtCodSub  , FArrSubReg    , 'CLI_CODSUB', 'CODSUB');
    strSQL := strSQL + fStrLocate(edtCodAti  , FArrAtividade , 'CLI_CODATI', 'CODATI');
    strSQL := strSQL + fStrLocate(edtCodCac  , FArrCanal     , 'CLI_CODCAC', 'CODCAC');
    strSQL := strSQL + fStrLocate(edtCodRep  , FArrRepr      , 'CLI_CODREP', 'CODREP');
    If pnlForPag.Visible Then
      strSQL := strSQL + fStrLocate(edtCodFpg  , FArrForma     , 'CLI_CODFPG', 'CODFPG');
    strSQL := strSQL + fStrLocate(edtCodPor  , FArrPortador  , 'CLI_CODPOR', 'CODPOR');
    strSQL := strSQL + fStrLocate(edtCodPor2 , FArrPortador2 , 'CLI_CODPO2', 'CODPO2');
    If pnlTipCli.Visible Then
      strSQL := strSQL + fStrLocate(edtTipCli  , FArrTipCli    , 'CLI_TIPCLI', 'TIPCLI');
    If pnlCodCnd.Visible and (Length(FArrCndPag) > 0) Then
    Begin
      If Length(FArrCndPag) > 1 Then
        strSQL := strSQL + 'AND EXISTS (SELECT AUTOINCREM FROM CLICND WHERE CND_CODCLI = CLI_CODCLI AND LOCATE(CND_CODCND, :CODCND) > 0) '
      Else
        strSQL := strSQL + 'AND EXISTS (SELECT AUTOINCREM FROM CLICND WHERE CND_CODCLI = CLI_CODCLI AND CND_CODCND = :CODCND) ';
    End;

    If edtSituacao.Text <> 'T' Then
      strSQL := strSQL + '  AND CLI_STATUS = :STATUS ';

    strSQL := strSQL + fRetSqlSeTemValor(fTiraCaracEspeciais(edtCep.Text), '  AND CLI_C_E_P_ = :C_E_P_ ');
    strSQL := strSQL + fRetSqlSeTemValor(edtEstado.Text, '  AND CID_ESTADO = :ESTADO ');
    strSQL := strSQL + fRetSqlSeTemValor(cmbCategoria.Text, '  AND CLI_CATEGO = :CATEGO ');
    strSQL := strSQL + fRetSqlSeTemValor(edtBairro.Text, '  AND CLI_BAIRRO LIKE :BAIRRO ');

    If pnlPeMIFF.Visible and (not fEmptyStr(edtPermFF.Text)) Then
      strSQL := strSQL + '  AND CLI_PERMFF = :PERMFF ';

    If pnlPeMIFV.Visible and (not fEmptyStr(edtPermFV.Text)) Then
      strSQL := strSQL + '  AND CLI_PERMFV = :PERMFV ';

    strSQL := strSQL + fRetSqlSeTemValor(edtConsum.Text, '  AND CLI_CONSUM = :CONSUM ');
    strSQL := strSQL + fRetSqlSeTemValor(edtRevist.Text, '  AND CLI_REVIST = :REVIST ');
    strSQL := strSQL + fRetSqlSeTemValor(edtTabPre.Text, '  AND CLI_TABPRE = :TABPRE ');

    Result := strSQL;
  finally
    cdsParametros.First;
    cdsParametros.EnableControls;
  end;
end;

function TfrmAltGlobalCadClientes.fRetSqlSeCampoMarcado(strCampo, strSql: String): String;
begin
  Result := '';
  If fCampoMarcado(strCampo) Then
    Result := strSql;
end;

function TfrmAltGlobalCadClientes.fVerificaCamposObrigatorios:Boolean;
begin
  Result := True;
  If fCampoMarcado('CLI_MENIPI') or fCampoMarcado('CLI_ENQIPI') then
    If (Not fCampoMarcado('CLI_SITIPI')) Then
    Begin
      pMensagemOk('Quando o campo "'+fCampoPorNome(FArrCampos, 'CLI_MENIPI').strDesCam+'" ou "'+fCampoPorNome(FArrCampos, 'CLI_ENQIPI').strDesCam+'" estiver preenchido, o campo "'+fCampoPorNome(FArrCampos, 'CLI_SITIPI').strDesCam+'" também deve estar!');
      Exit(False);
    End;

  If fCampoMarcado('CLI_MENP_C') then
    If (Not fCampoMarcado('CLI_SITP_C')) Then
    Begin
      pMensagemOk('Quando o campo "'+fCampoPorNome(FArrCampos, 'CLI_MENP_C').strDesCam+'" estiver preenchido, o campo "'+fCampoPorNome(FArrCampos, 'CLI_SITP_C').strDesCam+'" também deve estar!');
      Exit(False);
    End;

  If fCampoMarcado('CLI_REDISS') then
    If (Not fCampoMarcado('CLI_ALQISS')) Then
    Begin
      pMensagemOk('Quando o campo "'+fCampoPorNome(FArrCampos, 'CLI_REDISS').strDesCam+'" estiver preenchido, o campo "'+fCampoPorNome(FArrCampos, 'CLI_ALQISS').strDesCam+'" também deve estar!');
      Exit(False);
    End;
end;

procedure TfrmAltGlobalCadClientes.pSetParamSeValor(const strParam, strValor: String; const blnLike: Boolean = False);
begin
  If not fEmptyStr(strValor) Then
    FqryCadCli.ParamByName(strParam).AsString := strValor + IfThen(blnLike, '%', '');
end;

procedure TfrmAltGlobalCadClientes.pAdicionaCampoGrid(strNomeCampo: String);
  Var
    intTamMatCampos: Integer;
    intContadorLocal: integer;
    recGlobal: TCampoGlobal;
begin
  recGlobal := fCampoPorNome(FArrCampos, strNomeCampo);

  If Not recGlobal.strNomCam.IsEmpty Then
  Begin
    intTamMatCampos := Length(arrCamposGrid);

    For intContadorLocal := 0 To intTamMatCampos -1 Do
      If arrCamposGrid[intContadorLocal].strNomCam = strNomeCampo Then
        Exit;

    SetLength(arrCamposGrid, intTamMatCampos+1);
    arrCamposGrid[intTamMatCampos] := recGlobal;
  End;
end;

function TfrmAltGlobalCadClientes.fAbreQryCadCli(pgbProgresso2: TcxProgressBar): Boolean;
  Var
    strLinha    : String;
    strCamAtu   : String;
    varValAtu   : Variant;
    intContador : Integer;
    intTamMat   : Integer;
    arrRegistroAtual : Array Of TCampoGlobal;
begin
  Result := True;

  FqryCadCli.SQL.Text := fRetSql;

  pSetaParam(edtCodCli.Text  , FArrClientes  , strLinha, 'CODCLI', FqryCadCli);
  pSetaParam(edtCodCid.Text  , FArrCidade    , strLinha, 'CODCID', FqryCadCli);
  pSetaParam(edtCodRed.Text  , FArrRede      , strLinha, 'CODRED', FqryCadCli);
  pSetaParam(edtCodReg.Text  , FArrRegiao    , strLinha, 'CODREG', FqryCadCli);
  pSetaParam(edtCodVen.Text  , FArrVended    , strLinha, 'CODVEN', FqryCadCli);
  pSetaParam(edtCodSub.Text  , FArrSubReg    , strLinha, 'CODSUB', FqryCadCli);
  pSetaParam(edtCodAti.Text  , FArrAtividade , strLinha, 'CODATI', FqryCadCli);
  pSetaParam(edtCodCac.Text  , FArrCanal     , strLinha, 'CODCAC', FqryCadCli);
  pSetaParam(edtCodRep.Text  , FArrRepr      , strLinha, 'CODREP', FqryCadCli);
  If pnlForPag.Visible Then
    pSetaParam(edtCodFpg.Text  , FArrForma     , strLinha, 'CODFPG', FqryCadCli);
  pSetaParam(edtCodPor.Text  , FArrPortador  , strLinha, 'CODPOR', FqryCadCli);
  pSetaParam(edtCodPor2.Text , FArrPortador2 , strLinha, 'CODPO2', FqryCadCli);
  If pnlTipCli.Visible Then
    pSetaParam(edtTipCli.Text  , FArrTipCli    , strLinha, 'TIPCLI', FqryCadCli);
  If pnlCodCnd.Visible Then
    pSetaParam(edtCodCnd.Text  , FArrCndPag    , strLinha, 'CODCND', FqryCadCli);

  If edtSituacao.Text <> 'T' Then
    FqryCadCli.ParamByName('STATUS').AsString := edtSituacao.Text;

  pSetParamSeValor('C_E_P_', fTiraCaracEspeciais(edtCep.Text));
  pSetParamSeValor('ESTADO', edtEstado.Text);
  pSetParamSeValor('CATEGO', cmbCategoria.Text);
  pSetParamSeValor('BAIRRO', edtBairro.Text, True);
  pSetParamSeValor('CONSUM', edtConsum.Text);
  pSetParamSeValor('REVIST', edtRevist.Text);
  pSetParamSeValor('TABPRE', edtTabPre.Text);

  If pnlPeMIFF.Visible and (not fEmptyStr(edtPermFF.Text)) Then
    FqryCadCli.ParamByName('PERMFF').AsString := edtPermFF.Text;

  If pnlPeMIFV.Visible and (not fEmptyStr(edtPermFV.Text)) Then
    FqryCadCli.ParamByName('PERMFV').AsString := edtPermFV.Text;

  FqryCadCli.Options.SetFieldsReadOnly := False;
  FqryCadCli.CachedUpdates := True;
  FqryCadCli.Close;
  FqryCadCli.Open;

  If FqryCadCli.IsEmpty Then
  Begin
    fMensagem('','Não há dados para serem alterados!',['&OK']);
    Result := False;
    Exit;
  End;

  pSetaClient(FqryCadCli);
  dspClientesAlteracao.DataSet := FqryCadCli;

  cdsClientesAlteracao.Close;
  cdsClientesAlteracao.Open;
  pSetaClient(cdsClientesAlteracao);

  pAplicaMascara('CLI_PERCOM', '#,##0.00');
  pAplicaMascara('CLI_DESCON', '#,##0.00');
  pAplicaMascara('CLI_ALQISS', '#,##0.00');
  pAplicaMascara('CLI_DESOPE', '#,##0.00');
  pAplicaMascara('CLI_IVAESP', '#,##0.0000');
  pAplicaMascara('CLI_IVANAC', '#,##0.0000');
  pAplicaMascara('CLI_CEDESP', '#,##0.0000');
  pAplicaMascara('CLI_CEDNAC', '#,##0.0000');
  pAplicaMascara('CLI_IVASIM', '#,##0.0000');
  pAplicaMascara('CLI_CEDSIM', '#,##0.0000');
  pAplicaMascara('CLI_REDISS', '#,##0.00');
  pAplicaMascara('CLI_REDICM', '#,##0.00');
  pAplicaMascara('CLI_LIMCRE', '#,##0.00');

  pgbProgresso2.Position       := 0;
  pgbProgresso2.Properties.Max := FqryCadCli.RecordCount;
  Application.ProcessMessages;

  FqryCadCli.First;
  While Not FqryCadCli.Eof Do
  Begin
    SetLength(arrRegistroAtual, 0);

    For intContador := 0 To FqryCadCli.FieldCount -1 Do
    Begin
      intTamMat := Length(arrRegistroAtual);
      SetLength(arrRegistroAtual, intTamMat+1);
      arrRegistroAtual[intTamMat].strNomCam := FqryCadCli.Fields[intContador].FieldName;
      arrRegistroAtual[intTamMat].varValCam := FqryCadCli.Fields[intContador].Value;

      If (FqryCadCli.Fields[intContador].DataType in [ftString, ftMemo]) Then
      Begin
        arrRegistroAtual[intTamMat].strTipCam := 'VARCHAR';
      End
      Else If (FqryCadCli.Fields[intContador].DataType in [ftDate, ftDateTime]) Then
      Begin
        arrRegistroAtual[intTamMat].strTipCam := 'DATE';
      End
      Else
      Begin
        arrRegistroAtual[intTamMat].strTipCam := 'NUMERIC';
      End;

      If arrRegistroAtual[intTamMat].varValCam = Null Then
      Begin
        If (FqryCadCli.Fields[intContador].DataType in [ftString, ftMemo]) Then
        Begin
          arrRegistroAtual[intTamMat].varValCam := ''
        End
        Else If (FqryCadCli.Fields[intContador].DataType in [ftDate, ftDateTime]) Then
        Begin
          arrRegistroAtual[intTamMat].varValCam := 0;
        End
        Else
        Begin
          arrRegistroAtual[intTamMat].varValCam := 0.0;
        End;
      End;
    End;

    intTamMat := Length(arrCamposTabela);
    intContador := 0;
    While intContador < intTamMat Do
    Begin
      strCamAtu := arrCamposTabela[intContador].strNomCam;
      varValAtu := arrCamposTabela[intContador].varValCam;

      pAdicionaCampoGrid(strCamAtu);
      pAtualizaValorCampo(arrRegistroAtual, strCamAtu, varValAtu);

      Inc(intContador);
      Application.ProcessMessages;
    End;

    pAlteraValorTabelaClientes(FqryCadCli.FieldByName('CLI_CODCLI').AsString,
                               arrRegistroAtual);

    FqryCadCli.Next;

    pgbProgresso2.Position := pgbProgresso2.Position + 1;
    Application.ProcessMessages;
  End;

  FqryCadCli.Close;
end;

procedure TfrmAltGlobalCadClientes.pAlteraValorTabelaClientes(strCodCli: String;
  Var arrCampos: Array Of TCampoGlobal);
  Var
    intContador: Integer;
    intTamMat  : Integer;
begin
  intTamMat := Length(arrCampos);
  intContador := 0;

  If cdsClientesAlteracao.Locate('CLI_CODCLI', strCodCli, []) Then
  Begin
    cdsClientesAlteracao.Edit;

    While intContador < intTamMat Do
    Begin
      If Pos('CHAR', arrCampos[intContador].strTipCam) > 0 Then
        cdsClientesAlteracao.FieldByName(arrCampos[intContador].strNomCam).AsString := arrCampos[intContador].varValCam

      Else If cdsClientesAlteracao.FieldByName(arrCampos[intContador].strNomCam).DataType = ftFloat Then
        cdsClientesAlteracao.FieldByName(arrCampos[intContador].strNomCam).AsFloat := fStrToFloat(arrCampos[intContador].varValCam)

      Else If cdsClientesAlteracao.FieldByName(arrCampos[intContador].strNomCam).DataType In [ftInteger, ftSmallint, ftWord] Then
        cdsClientesAlteracao.FieldByName(arrCampos[intContador].strNomCam).AsInteger := Trunc(fStrToFloat(arrCampos[intContador].varValCam))
      Else If cdsClientesAlteracao.FieldByName(arrCampos[intContador].strNomCam).DataType In [ftDate, ftDateTime] Then
      Begin
        Try
          cdsClientesAlteracao.FieldByName(arrCampos[intContador].strNomCam).AsDateTime := StrToDate(arrCampos[intContador].varValCam);
        Except
          cdsClientesAlteracao.FieldByName(arrCampos[intContador].strNomCam).AsString   := '';
        End;
      End;

      Inc(intContador);
    End;

    cdsClientesAlteracao.Post;
  End;
end;

procedure TfrmAltGlobalCadClientes.pAtualizaValorCampo(Var arrCampos: Array Of TCampoGlobal;
  strNomeCampo: String; varValor: Variant);
  Var
    intContador: Integer;
    intTamMat: Integer;
begin
  intContador := 0;
  intTamMat := Length(arrCampos);
  While intContador < intTamMat Do
  Begin
    If arrCampos[intContador].strNomCam = strNomeCampo Then
    Begin
      arrCampos[intContador].varValCam := varValor;
      Break;
    End;
    Inc(intContador);
  End;
end;

procedure TfrmAltGlobalCadClientes.pAddColuna(const strAba, strCampo,
  strDescricao: String; proProperties: TcxEditRepositoryItem; blnVisivel: Boolean;
  strFieldDesc, strFieldDescTitle: String);
begin
  If Not blnVisivel Then
    Exit;

  pIncluiParametro(strAba, strCampo, strDescricao, proProperties);
  pIncluiCampo(strCampo, strDescricao, True, proProperties, strFieldDesc, strFieldDescTitle);
end;

procedure TfrmAltGlobalCadClientes.pAplicaMascara(const strCampo,
  strMascara: String);
var
  Field: TField;
begin
  Field := FqryCadCli.FindField(strCampo);
  If not Assigned(Field) Then
    Exit;

  TFloatField(Field).DisplayFormat := strMascara;
end;

procedure TfrmAltGlobalCadClientes.pCarregaCategorias;
var
  intContador: Integer;
begin
  pPreencheCombo(TCustomComboBox(cmbCategoria), arrCtgCli);
  cmbPropCategoria.Properties.Items.Clear;
  for intContador := 0 to Pred(cmbCategoria.Items.Count) do
    cmbPropCategoria.Properties.Items.Add(cmbCategoria.Items[intContador])
end;

procedure TfrmAltGlobalCadClientes.pCarregaTabelasPreco;
var
  intCon: Integer;
begin
  FstrVrfTpr := EmptyStr;
  clbPrcVenda.Caption := EmptyStr;

  cmbTabPre.Properties.Items.Clear;
  For intCon := 1 To Length(Trim(VS_strTabVen)) Do
  Begin
    FstrVrfTpr := FstrVrfTpr + IfThen(SameText(VS_strTabVen[intCon], 'S'), IntToStr(intCon), '');
    If (VS_strTabVen[intCon] = 'S') Then
    Begin
      If intCon <> Length(Trim(VS_strTabVen)) Then
        clbPrcVenda.Caption := clbPrcVenda.Caption + ' (' + IntToStr(intCon) + ')'
      Else
        clbPrcVenda.Caption := clbPrcVenda.Caption + ' ou (' + IntToStr(intCon) + ')';

      cmbTabPre.Properties.Items.Add(IntToStr(intCon));
    End;
  End;

  clbPrcVenda.Caption := 'Preço de Venda ' + clbPrcVenda.Caption;
  clbPrcVenda.AutoSize := FALSE;
  clbPrcVenda.AutoSize := TRUE;
end;

function TfrmAltGlobalCadClientes.fGeraVetorCampos: Boolean;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    Try
      frmGravando.blnTempoRestante := True;
      frmGravando.fExecutarAcao := fGeraVetorCamposAux;
      frmGravando.lblGravando.Caption := 'Aguarde, carregando dados...';
      frmGravando.ShowModal;
      Result := frmGravando.blnConfirma;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmAltPrecoIndividual.fGeraVetorCamposAux]');
        Result := False;
      End;
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
End;

function TfrmAltGlobalCadClientes.fCampoPorNome(Var arrCampos: Array Of TCampoGlobal;
  strNomeCampo: String): TCampoGlobal;
  Var
    intContador: Integer;
    intTamMat: Integer;
begin
  Fillchar(Result, SizeOf(Result), #0);
  intContador := 0;
  intTamMat := Length(arrCampos);

  While intContador < intTamMat Do
  Begin
    If arrCampos[intContador].strNomCam = strNomeCampo Then
    Begin
      Result := arrCampos[intContador];
      Break;
    End;
    Inc(intContador);
  End;
end;

function TfrmAltGlobalCadClientes.fGeraVetorCamposAux(pgbProgresso: TcxProgressBar): Boolean;
  Var
    intTamMat: Integer;
begin
  SetLength(arrCamposTabela, 0);
  SetLength(arrCamposGrid,   0);

  cdsParametros.DisableControls;
  Try

    pgbProgresso.Position       := 0;
    pgbProgresso.Properties.Max := cdsParametros.RecordCount;
    Application.ProcessMessages;

    cdsParametros.First;
    While Not cdsParametros.Eof Do
    Begin
      If (Not cdsParametrosMARCADO.AsBoolean) Then
      Begin
        cdsParametros.Next;
        Continue;
      End;

      pAtualizaValorCampo(FArrCampos, cdsParametrosCAMPO.AsString, cdsParametrosVALOR.Value);

      intTamMat := Length(arrCamposTabela);
      SetLength(arrCamposTabela, intTamMat+1);

      arrCamposTabela[intTamMat].strDesCam := cdsParametrosDESCRI.AsString;
      arrCamposTabela[intTamMat].strProper := cdsParametrosPROPER.AsString;
      arrCamposTabela[intTamMat].varValCam := cdsParametrosVALOR.Value;
      arrCamposTabela[intTamMat].strNomCam := cdsParametrosCAMPO.AsString;

      cdsParametros.Next;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;
  Finally
    cdsParametros.EnableControls;
  End;

  Result := (Length(arrCamposTabela) > 0);
end;

function TfrmAltGlobalCadClientes.fConfirmaAlteracoes(cxProgresso: TcxProgressBar): Boolean;
  Var
    frmConfirmaGlobalClientes : TfrmConfirmaGlobalClientes;
    blnConfirma : Boolean;
begin
  blnConfirma := False;

  If cdsClientesAlteracao.Active Then
    cdsClientesAlteracao.EmptyDataSet;

  pInfoStatusGravacao(cxProgresso, 'Validando campos, aguarde...');

  If (Not fVerificaCamposObrigatorios) Then
    Exit(False);

  If (Not fVerificaFiltros) Then
  Begin
    fMensagem('', 'É necessário preencher pelo menos um filtro!', ['&O k']);
    Exit(False);
  End;

  If (Not fGeraVetorCampos) Then
  Begin
    fMensagem('', 'É necessário marcar pelo menos um campo para alteração!', ['&O k']);
    Exit(False);
  End;

  pCriarFormularios(TfrmConfirmaGlobalClientes, frmConfirmaGlobalClientes);
  Try
    btnConfirma.Enabled := False;
    btnSair.Enabled     := False;

    If (fAbreQryCadCli(cxProgresso)) Then
    Begin
      Try
        frmConfirmaGlobalClientes.dtsClientes.DataSet := cdsClientesAlteracao;
        frmConfirmaGlobalClientes.arrCamposGrid := arrCamposGrid;
        frmConfirmaGlobalClientes.blnIncluirCnd := rdbIncluir.Checked;
        frmConfirmaGlobalClientes.ShowModal;

        blnConfirma := frmConfirmaGlobalClientes.blnConfirma;
      Except
        On E: Exception Do
        Begin
          blnConfirma := False;
          pMensagensErro(E.Message, '[frmAltGlobalCadClientes.btnConfirmaClick]');
        End;
      End;
    End;
  Finally
    btnConfirma.Enabled := True;
    btnSair.Enabled     := True;
    pFreeAndNil(frmConfirmaGlobalClientes);
  End;

  Result := blnConfirma;
end;

Procedure TfrmAltGlobalCadClientes.pCriaCdsSimNao;
Begin
  FcdsSimNao := fCriaClientDataset(
    'SELECT "S" AS VALCAM, "Sim" AS DESCAM ' +
    'UNION ' +
    'SELECT "N" AS VALCAM, "Não" AS DESCAM', Self);
  FdtsSimNao := TDataSource.Create(Self);
  FdtsSimNao.DataSet := FcdsSimNao;

  TcxLookupComboBoxProperties(cmbSimNao.Properties).ListSource := FdtsSimNao;
End;

Procedure TfrmAltGlobalCadClientes.pCriaCdsBolImp;
Begin
  FcdsBolImp := fCriaClientDataset(
    'SELECT "E" AS VALCAM, "Empresa" AS DESCAM ' +
    'UNION ' +
    'SELECT "B" AS VALCAM, "Banco" AS DESCAM', Self);
  FdtsBolImp := TDataSource.Create(Self);
  FdtsBolImp.DataSet := FcdsBolImp;

  TcxLookupComboBoxProperties(cmbBolImp.Properties).ListSource := FdtsBolImp;
End;

Procedure TfrmAltGlobalCadClientes.pCriaCdsIndCom;
Begin
  FcdsIndCom := fCriaClientDataset(
    'SELECT "I" AS VALCAM, "Industrialização" AS DESCAM ' +
    'UNION ' +
    'SELECT "C" AS VALCAM, "Comercialização" AS DESCAM', Self);
  FdtsIndCom := TDataSource.Create(Self);
  FdtsIndCom.DataSet := FcdsIndCom;

  TcxLookupComboBoxProperties(cxeIndCom.Properties).ListSource := FdtsIndCom;
End;

Procedure TfrmAltGlobalCadClientes.pCriaCdsSitIpi;
var
  intContador: Integer;
  strSQL: String;
Begin
  strSQL := '';
  For intContador := 0 To Length(arr_SITUACAOTRIBUTARIAIPI)-1 do
  begin
    strSQL := strSQL + 'SELECT "' + arr_SITUACAOTRIBUTARIAIPI[intContador][0] + '" AS VALCAM, "' + arr_SITUACAOTRIBUTARIAIPI[intContador][0]+' - '+arr_SITUACAOTRIBUTARIAIPI[intContador][1] + '" AS DESCAM ';
    If intContador <> Length(arr_SITUACAOTRIBUTARIAIPI)-1 Then
      strSQL := strSQL + 'UNION ';
  end;

  FcdsSitIpi := fCriaClientDataset(strSQL, Self);
  FdtsSitIpi := TDataSource.Create(Self);
  FdtsSitIpi.DataSet := FcdsSitIpi;

  TcxLookupComboBoxProperties(cxeSitIpi.Properties).ListSource := FdtsSitIpi;
End;

Procedure TfrmAltGlobalCadClientes.pCriaCdsSitP_C;
var
  intContador: Integer;
  strSQL: String;
Begin
  strSQL := '';
  For intContador := 0 To Length(arr_SITUACAOTRIBUTARIAPISCOFINS)-1 do
  begin
    strSQL := strSQL + 'SELECT "' + arr_SITUACAOTRIBUTARIAPISCOFINS[intContador][0] + '" AS VALCAM, "' + arr_SITUACAOTRIBUTARIAIPI[intContador][0]+' - '+arr_SITUACAOTRIBUTARIAPISCOFINS[intContador][1] + '" AS DESCAM ';
    If intContador <> Length(arr_SITUACAOTRIBUTARIAPISCOFINS)-1 Then
      strSQL := strSQL + 'UNION ';
  end;

  FcdsSitP_C := fCriaClientDataset(strSQL, Self);
  FdtsSitP_C := TDataSource.Create(Self);
  FdtsSitP_C.DataSet := FcdsSitP_C;

  TcxLookupComboBoxProperties(cxeSitP_C.Properties).ListSource := FdtsSitP_C;
End;

Procedure TfrmAltGlobalCadClientes.pCriaCdsRegTri;
Begin
  FcdsRegTri := fCriaClientDataset(
    'SELECT "S" AS VALCAM, "Simples" AS DESCAM ' +
    'UNION ' +
    'SELECT "R" AS VALCAM, "Lucro Real" AS DESCAM ' +
    'UNION ' +
    'SELECT "P" AS VALCAM, "Lucro Presumido" AS DESCAM', Self);
  FdtsRegTri:= TDataSource.Create(Self);
  FdtsRegTri.DataSet := FcdsRegTri;

  TcxLookupComboBoxProperties(cxeRegTri.Properties).ListSource := FdtsRegTri;
End;

Procedure TfrmAltGlobalCadClientes.pCriaCdsTFTNES;
Begin
  FcdsTFTNES:= fCriaClientDataset(
    'SELECT "V" AS VALCAM, "Valor" AS DESCAM ' +
    'UNION ' +
    'SELECT "Q" AS VALCAM, "Quantidade" AS DESCAM', Self);
  FdtsTFTNES:= TDataSource.Create(Self);
  FdtsTFTNES.DataSet := FcdsTFTNES;

  TcxLookupComboBoxProperties(cxeTFTNES.Properties).ListSource := FdtsTFTNES;
End;

procedure TfrmAltGlobalCadClientes.pCriaCdsTipFre;
var
  intTipFre: Integer;
  strSQL: String;
Begin
  strSQL := '';
  for intTipFre := Low(TiposFrete) to High(TiposFrete) do
  begin
    strSQL := strSQL + 'SELECT "' + TiposFrete[intTipFre].ToString + '" AS VALCAM, "' + fDescricaoFrete(TiposFrete[intTipFre].ToString) + '" AS DESCAM ';
    If intTipFre <> Length(TiposFrete)-1 Then
      strSQL := strSQL + 'UNION ';
  end;

  FcdsTipFre := fCriaClientDataset(strSQL, Self);
  FdtsTipFre := TDataSource.Create(Self);
  FdtsTipFre.DataSet := FcdsTipFre;

  TcxLookupComboBoxProperties(cxeTipFre.Properties).ListSource := FdtsTipFre;
end;

Function TfrmAltGlobalCadClientes.fValidaValor(strValor: String): Boolean;
var
  strFieldName: String;
Begin
  Result := True;

  strFieldName := cdsParametrosCAMPO.AsString;
  If strFieldName = 'CLI_LIMCRE' Then
    Result := fValidaLimCre(strValor)

  Else
  If strFieldName = 'CLI_CODPOR' Then
    Result := fValidaCodPor(strValor)

  Else
  If strFieldName = 'CLI_CODPO2' Then
    Result := fValidaCodPo2(strValor)

  Else
  If strFieldName = 'CLI_CODREP' Then
    Result := fValidaCodRep(strValor)

  Else
  If strFieldName = 'CLI_TABPRE' Then
    Result := fValidaTabPre(strValor)

  Else
  If strFieldName = 'CLI_TIPCLI' Then
    Result := fValidaTipCli(strValor)

  Else
  If strFieldName = 'CLI_CODVEN' Then
    Result := fValidaCodVen(strValor)
End;

function TfrmAltGlobalCadClientes.fValidaLimCre(strValor: String): Boolean;
begin
  Result := True;

  If (fEmptyStr(strValor)) Or (fStrToFloat(strValor) < 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Limite de Crédito deve ser maior ou igual Zero!', ['&Ok']);
    Result := False;
  End
  Else If fStrToFloat(strValor) > MAX_VALMON Then
  Begin
    fMensagem('ATENÇÃO!', 'O Limite de Crédito deve estar entre 0 e 999999,99!', ['&Ok']);
    Result := False;
  End
  Else If (fCfgSis('LMCROP', VarBoolean)) And
          (fStrToFloat(strValor) > fLimCredOperador(strLoginUsuarioLogado)) Then
  Begin
    If fCfgSis('LMCRTR', VarString) = '1' then
    Begin
      fMensagem('ATENÇÃO!', 'O valor do limite de crédito informado ultrapassa o limite permitido para o operador!', ['&Ok']);
      Result := False;
    End;
  End;
end;

function TfrmAltGlobalCadClientes.fValidaCodPor(strValor: String): Boolean;
begin
  Result := True;

  If Not (fEmptyStr(strValor)) Then
  Begin
    If fEmptyStr(fRetNomPortador(strValor)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!', ['&Ok']);
      Result := False;
    End
    Else If Not fEmpresaTemAcessoPortador(strValor) Then
    Begin
      fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
      Result := False;
    End
  End;
end;

function TfrmAltGlobalCadClientes.fValidaCodPo2(strValor: String): Boolean;
begin
  Result := True;

  If Not (fEmptyStr(strValor)) Then
  Begin
    If fEmptyStr(fRetNomPortador(strValor)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!', ['&Ok']);
      Result := False;
    End
    Else If Not fEmpresaTemAcessoPortador(strValor) Then
    Begin
      fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
      Result := False;
    End;
  End;
end;

function TfrmAltGlobalCadClientes.fValidaCodRep(strValor: String): Boolean;
begin
  Result := True;

  If Not fEmptyStr(strValor) Then
  Begin
    If fEmptyStr(fRetNomeOperador(strValor)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse representante não está cadastrado!', ['&Ok']);
      Result := False;
    End
  End;
end;

function TfrmAltGlobalCadClientes.fValidaTabPre(strValor: String): Boolean;
begin
  Result := True;

  If Not fEmptyStr(strValor) Then
  Begin
    If Pos( strValor, FstrVrfTpr ) <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Entre com uma opção válida para a tabela de ' + clbPrcVenda.Caption + '!', ['&Ok']);
      Result := False;
    End
  End
  Else
  Begin
    If (Not fCfgSis('TPRFAT', varBoolean)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Tabela de Preço deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End
end;

function TfrmAltGlobalCadClientes.fValidaTipCli(strValor: String): Boolean;
begin
  Result := True;

  If (Not fEmptyStr(strValor)) Then
  Begin
    If (fEmptyStr(fRetDescTipoCli(strValor))) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse tipo de cliente não está cadastrado!', ['&Ok']);
      Result := False;
    End
  End;
end;

function TfrmAltGlobalCadClientes.fValidaCodVen(strValor: String): Boolean;
begin
  Result := True;

  If (Not fEmptyStr(strValor)) Then
  Begin
    If fEmptyStr(fRetNomeOperador(strValor)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse vendedor não está cadastrado!', ['&Ok']);
      Result := False;
    End
  End;
end;

end.

