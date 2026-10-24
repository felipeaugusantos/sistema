unit untAltGlobCadClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, QColorLabel, EditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, Datasnap.DBClient, UniClientDataSet,
  untTypesSistema, cxGridBandedTableView, cxGridDBBandedTableView, cxProgressBar,
  Uni, untZClient, cxEditRepositoryItems, cxDBEditRepository, ComboBoxFocus,
  cxCheckBox, untLiberacao, cxDBLookupComboBox, cxDropDownEdit, Vcl.Mask,
  MaskEditFocus, untLogAltCadCli;

type

  TCampo = Record
    Title,
    FieldName: String;
    ReadOnly,
    Visible: Boolean;
    Properties: TcxCustomEditProperties;
    blnTemDescricao : Boolean;
  End;

  TArrCampos = Array Of TCampo;

  ELiberacaoNãoRealizada = Exception;

  TfrmAltGlobCadClientes = class(TfrmPai)
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
    btnConfirmaAlt: TBitBtnLocked;
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
    grdCampos: TcxGrid;
    grdCamposTv: TcxGridDBTableView;
    grdCamposCAMPO: TcxGridDBColumn;
    grdCamposABA: TcxGridDBColumn;
    grdCamposDESCRI: TcxGridDBColumn;
    grdCamposMARCADO: TcxGridDBColumn;
    grdCamposLvl: TcxGridLevel;
    Panel1: TPanel;
    Label16: TLabel;
    Panel2: TPanel;
    btnMarcar: TBitBtnLocked;
    btnDesmarcar: TBitBtnLocked;
    btnLimpaFiltros: TBitBtnLocked;
    cxgTiposAlt: TcxGrid;
    cxvTiposAlt: TcxGridDBBandedTableView;
    cxgTiposAltLevel1: TcxGridLevel;
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
    cxeCategoria: TcxEditRepositoryComboBoxItem;
    cxeBolImp: TcxEditRepositoryLookupComboBoxItem;
    cxeString40: TcxEditRepositoryTextItem;
    cxeString01: TcxEditRepositoryTextItem;
    cxeRegTri: TcxEditRepositoryLookupComboBoxItem;
    cxeIndCom: TcxEditRepositoryLookupComboBoxItem;
    cxeTFTNES: TcxEditRepositoryLookupComboBoxItem;
    cxeTabPre: TcxEditRepositoryComboBoxItem;
    cxeSitIpi: TcxEditRepositoryLookupComboBoxItem;
    cxeSitP_C: TcxEditRepositoryLookupComboBoxItem;
    pnlCndPag: TPanel;
    Label10: TLabel;
    rdbIncluir: TRadioButton;
    rdgExcluir: TRadioButton;
    pnlLiberacao: TPanel;
    cdsLimCre: TUniClientDataSet;
    cdsLimCreCODCLI: TStringField;
    cdsLimCreLIMANT: TFloatField;
    cdsLimCreLIMNOV: TFloatField;
    cdsLimCreCGCCPF: TStringField;
    cdsLimCreNOMCLI: TStringField;
    cdsLimCreTIPO__: TStringField;
    cdsValida: TUniClientDataSet;
    cdsValidaTIPO__: TStringField;
    cdsValidaCODCLI: TStringField;
    cdsValidaNOMCLI: TStringField;
    cdsValidaCGCCPF: TStringField;
    cdsValidaPORANT: TStringField;
    cdsValidaPORNOV: TStringField;
    cdsValidaNOMANT: TStringField;
    cdsValidaNOMNOV: TStringField;
    cxeTipFre: TcxEditRepositoryLookupComboBoxItem;
    cxeInt07: TcxEditRepositoryCurrencyItem;
    cxeInt20: TcxEditRepositoryCurrencyItem;
    Label17: TLabel;
    edtCep: TMaskEditFocus;
    cxeCodCna: TcxEditRepositoryMaskItem;
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
    procedure btnConfirmaAltClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cdsParametrosBeforePost(DataSet: TDataSet);
    procedure edtTipCliExit(Sender: TObject);
    procedure edtTipCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCndExit(Sender: TObject);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure btnDesmarcarClick(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
    procedure btnLimpaFiltrosClick(Sender: TObject);
    procedure cxeConsTam2PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvTiposAltEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure cxvTiposAltEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxeMasPerPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxeMasValPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvTiposAltEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure cdsParametrosMARCADOChange(Sender: TField);
    procedure cdsParametrosAfterPost(DataSet: TDataSet);
    procedure btnSairClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxeInt03PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
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

    FArrCampos: TArrCampos;

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

    procedure pConfirma;

    procedure pAplicaMascara(const strCampo, strMascara: String);

    procedure pSetParamSeValor(const strParam, strValor: String; const blnLike: Boolean = False);
    function fRetSql: String;
    function fAbreQryCadCli: Boolean;

    procedure pCarregaTabelasPreco;
    procedure pCarregaCategorias;

    procedure pMarcaDesmarca(blnMarcar: Boolean);
    function fCampoMarcado(strCampo: String): Boolean;
    procedure pLimpaCampos;
    procedure pLimpaTela;

    procedure pPreparaColunas;

    procedure pIncluiParametro(const strAba, strCampo, strDescricao: String; const blnMarcado: boolean = False);
    procedure pIncluiCampo(strNomCam, strTitulo: String; blnVisible: Boolean = True; proProperties: TcxCustomEditProperties = Nil; strFieldDesc: string = ''; strFieldDescTitle: String = '');

    procedure pAddColuna(const strAba, strCampo, strDescricao: String; proProperties: TcxCustomEditProperties = Nil; blnVisivel: Boolean = True; strFieldDesc: string = ''; strFieldDescTitle: String = '');

    function fMontaGridAlterados(cxProgresso: TcxProgressBar): Boolean;
    function fGravaDados(cxProgresso: TcxProgressBar): Boolean;

    procedure pAdicionaColuna(strTitulo: String; intIndice: Integer);

    function fGetMaxWidhProper(proProperties: TcxCustomEditProperties): Integer;
    function fGetMaxWidthCombo(proProperties: TcxComboBoxProperties): Integer;
    function fGetMaxWidthLookup(proProperties: TcxLookupComboBoxProperties): Integer;

    function fRetDescricaoCadastro(strNomCam, strCodCad: String; blnValidar: Boolean; Var blnErro: Boolean): String;
    function fRetCampoDesc(strField: string): TCampo;
    function fTemCampoDesc(strField: string): Boolean;
    function fTemConsultaTabela(strNomCam: String): Boolean;

    procedure pCriaCdsSimNao;
    procedure pCriaCdsBolImp;
    procedure pCriaCdsRegTri;
    procedure pCriaCdsIndCom;
    procedure pCriaCdsTFTNES;
    procedure pCriaCdsSitIpi;
    procedure pCriaCdsSitP_C;
    procedure pCriaCdsTipFre;

    function fValidaValor(strValor: String): Boolean;

    function fCampoLiberacaoMarcado: Boolean;

    function fValidaLimiteCredito: Boolean;
    function fValidaPortador1: Boolean;
    function fValidaPortador2: Boolean;
    function fValidaRepresentante: Boolean;
    function fValidaTabelaPreco: Boolean;
    function fValidaTipoCliente: Boolean;
    function fValidaVendedor: Boolean;

    procedure pVerificaLimiteCredito;
    procedure pVerificaPortador1;
    procedure pVerificaPortador2;

    procedure pVerificaAlteracoes(cxProgresso: TcxProgressBar);
    function fPersisteDados(cxProgresso: TcxProgressBar): Boolean;

    function fRetSqlSeCampoMarcado(strCampo, strSql: String): String;
    function fRetSqlSeTemValor(strCampo, strSql: String): String;

    function fValidaLimCre(strValor: String): Boolean;
    function fValidaCodPor(strValor: String): Boolean;
    function fValidaCodPo2(strValor: String): Boolean;
    function fValidaCodRep(strValor: String): Boolean;
    function fValidaTabPre(strValor: String): Boolean;
    function fValidaTipCli(strValor: String): Boolean;
    function fValidaCodVen(strValor: String): Boolean;

    Procedure pSalvaDescricao(strDado: String; AEdit: TcxCustomEdit; var Key: Char);

    procedure pPesqCanalAcesso(qryDados: TUniQuery; var Key: Char;
      var arrSelecao: TConsultasArray; Edit: TcxCustomEdit);
    procedure pPesqRedeLojas(qryDados: TUniQuery; var Key: Char;
      var arrSelecao: TConsultasArray; Edit: TcxCustomEdit);
    procedure pPesqRegiao(qryDados: TUniQuery; var Key: Char;
      var arrSelecao: TConsultasArray; Edit: TcxCustomEdit);
    procedure pPesqSubRegiao(qryDados: TUniQuery; var Key: Char;
      var arrSelecao: TConsultasArray; Edit: TcxCustomEdit);
    procedure pPesqAtividade(qryDados: TUniQuery; var Key: Char;
      var arrSelecao: TConsultasArray; Edit: TcxCustomEdit);
    procedure pPesqFormaPgto(qryDados: TUniQuery; var Key: Char;
      var arrSelecao: TConsultasArray; Edit: TcxCustomEdit);
    procedure pPesqPortador(qryDados: TUniQuery; var Key: Char;
      var arrSelecao: TConsultasArray; Edit: TcxCustomEdit);
    procedure pPesqCondicoesPgto(qryDados: TUniQuery; var Key: Char;
      var arrSelecao: TConsultasArray; Edit: TcxCustomEdit);
    procedure pPesqEnquadramentoIPI(qryDados: TUniQuery; var Key: Char;
      var arrSelecao: TConsultasArray; Edit: TcxCustomEdit);
    procedure pPesqOperador(qryDados: TUniQuery; var Key: Char;
      var arrSelecao: TConsultasArray; Edit: TcxCustomEdit);
    procedure pPesqTipoCliente(qryDados: TUniQuery; var Key: Char;
      var arrSelecao: TConsultasArray; Edit: TcxCustomEdit);
    procedure pPesqTransportadora(qryDados: TUniQuery; var Key: Char;
      var arrSelecao: TConsultasArray; Edit: TcxCustomEdit);

    function fIncluirCliCnd(const strCodCli, strCodCnd: String): Boolean;

    function fPersisteCndPag: Boolean;
    function fPersisteCodTra: Boolean;
    function fPersisteTipFre: Boolean;
    function fPersisteCodReg: Boolean;

    procedure pMarcaCampo(const strCampo: String);
    procedure pMarcaCamposObrigatorios;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

  function fRetDescTipoCli(strCodTip: String): String;

implementation

{$R *.dfm}

uses
  System.StrUtils, untFuncoesSimples, untFuncoesConsulta, untConsultas, untGravando, untConstantes,
  cxTextEdit, untFuncoes, untMsgLiberacao,untFuncoesGenerica,
  untTipoFreteAtc;

procedure TfrmAltGlobCadClientes.edtCodFpgExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFpg, edtDesFpg, FArrForma, Nil, fRetDescFpg, 'da Forma de Pagamento');
end;

procedure TfrmAltGlobCadClientes.edtCodFpgKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFormaPgto(conFpgSimples, Self, edtCodFpg, edtDesFpg, Nil, Key, FArrForma, False) Then
    If fValidaCampos(edtCodFpg, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobCadClientes.edtCodPor2Exit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPor2, edtNomPor2, FArrPortador2, Nil, fRetNomPortador, 'do Portador');
end;

procedure TfrmAltGlobCadClientes.edtCodPor2KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPor2, edtNomPor2, Nil, Key, FArrPortador2, False) then
    If fValidaCampos(edtCodPor2, False) Then
      Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobCadClientes.edtCodPorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPor, edtNomPor, FArrPortador, Nil, fRetNomPortador, 'do Portador');
end;

procedure TfrmAltGlobCadClientes.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPor, edtNomPor, Nil, Key, FArrPortador, False) then
    If fValidaCampos(edtCodPor, False) Then
      Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobCadClientes.edtCodCndExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCnd, edtDesCnd, FArrCndPag, fRetDesConPag, Nil, 'da Condição de Pagamento');
end;

procedure TfrmAltGlobCadClientes.edtCodCndKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCondicoesPgto(Self, edtCodCnd, edtDesCnd, nil, Key, FArrCndPag, False) Then
    If fValidaCampos(edtCodCnd, True) Then
      Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobCadClientes.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAti, edtDesAti, FArrAtividade, Nil, fRetNomAtividade, 'da atividade');
end;

procedure TfrmAltGlobCadClientes.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, FArrAtividade, False) Then
    if fValidaCampos(edtCodAti, True) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobCadClientes.edtCodCacExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCac, edtDesCac, FArrCanal, nil, fRetNomCanalAcesso, 'do Canal');
end;

procedure TfrmAltGlobCadClientes.edtCodCacKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCanalAcesso(Self, edtCodCac, edtDesCac, Nil, Key, FArrCanal, false) Then
		if fValidaCampos(edtCodCac, False) then
  		Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobCadClientes.edtCodCidExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCid, edtNomCid, FArrCidade, fRetNomCidadeSemOpc, Nil, 'da Cidade');
end;

procedure TfrmAltGlobCadClientes.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCidade(Self, edtCodCid, edtNomCid, Nil, Nil, Key, FArrCidade, False) Then
    if fValidaCampos(edtCodCid, False) then
      Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobCadClientes.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtDesCli, FArrClientes, Nil, fRetNomCliente, 'do Cliente');
end;

procedure TfrmAltGlobCadClientes.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, FArrClientes, False) Then
    if fValidaCampos(edtCodCli, True) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobCadClientes.edtCodRedExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRed, edtDesRed, FArrRede, fRetNomeRedeLojaSelect, Nil, 'da rede de lojas');
end;

procedure TfrmAltGlobCadClientes.edtCodRedKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqRedeLojas(Self, edtCodRed, edtDesRed, Nil, Key, FArrRede, False) Then
    if fValidaCampos(edtCodRed, True) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobCadClientes.edtCodRegExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodReg, edtNomReg, FArrRegiao, Nil, fRetNomRegiao, 'da Região');
end;

procedure TfrmAltGlobCadClientes.edtCodRegKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqRegiao(Self, edtCodReg, edtNomReg, Nil, Key, FArrRegiao, False) Then
    if fValidaCampos(edtCodReg, True) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobCadClientes.edtCodRepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRep, edtDesRep, FArrRepr, fRetNomVendRep, nil, 'da representante');
end;

procedure TfrmAltGlobCadClientes.edtCodRepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fPesqOperador(Self, edtCodRep, edtDesRep, qryTabela, Key, FArrRepr, False) then
    If fValidaCampos(edtCodRep, False) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobCadClientes.edtCodSubExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodSub, edtDesSub, FArrSubReg, Nil, fRetNomSubRegiao, 'da sub-região');
end;

procedure TfrmAltGlobCadClientes.edtCodSubKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqSubRegiao(Self, edtCodSub, edtDesSub, Nil, Key, FArrSubReg, False) Then
    If fValidaCampos(edtCodSub, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobCadClientes.edtCodVenExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVen, edtNomVen, FArrVended, fRetNomeOperador, Nil, 'do Vendedor');
end;

procedure TfrmAltGlobCadClientes.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodVen, edtNomVen, Nil, Key, FArrVended, False) then
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltGlobCadClientes.edtTipCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtTipCli, edtDesTpc, FArrTipCli, fRetDescTipoCli, Nil, 'do Tipo de Cliente');
end;

procedure TfrmAltGlobCadClientes.edtTipCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fPesqTipoCliente(Self, edtTipCli, edtDesTpc, nil, Key, FArrTipCli, False) then
	  If fValidaCampos(edtTipCli, True) Then
      SelectNext(ActiveControl, True, True);
end;

function TfrmAltGlobCadClientes.fCampoLiberacaoMarcado: Boolean;
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

    Result := not cdsClone.IsEmpty;
  finally
    FreeAndNil(cdsClone);
  end;
end;

function TfrmAltGlobCadClientes.fCampoMarcado(strCampo: String): Boolean;
begin
  Result := False;
  If cdsParametros.Locate('CAMPO', strCampo, []) Then
    Result := cdsParametros.FieldByName('MARCADO').AsBoolean
end;

function TfrmAltGlobCadClientes.fMontaGridAlterados(
  cxProgresso: TcxProgressBar): Boolean;
Var
  intContador : Integer;
begin
  Result := True;

  pMarcaCamposObrigatorios;

  if not fAbreQryCadCli then
    Exit;

  cxvTiposAlt.DataController.DataSource := Nil;

  cxProgresso.Properties.Max := Length(FArrCampos);

  cxvTiposAlt.BeginUpdate;
  cdsParametros.DisableControls;
  try

    cxvTiposAlt.ClearItems;
    cxvTiposAlt.Bands[0].Width := 0;
    cxvTiposAlt.Bands[1].Width := 0;

    for intContador := Low(FArrCampos) to High(FArrCampos) do
    begin
      If FArrCampos[intContador].Visible Then
        pAdicionaColuna(FArrCampos[intContador].Title, intContador);

      cxProgresso.Position := cxProgresso.Position + 1;
      Application.ProcessMessages;
    end;

    cxvTiposAlt.DataController.DataSource := FDtsCadCli;
  finally
    cdsParametros.First;
    cdsParametros.EnableControls;
    cxvTiposAlt.EndUpdate;
  end;

  pnlFiltro.Enabled := False;
  nbDados.PageIndex := nbDados.PageIndex + 1;
  pSetFocus(cxgTiposAlt);

end;

procedure TfrmAltGlobCadClientes.btnConfirmaAltClick(Sender: TObject);
begin
  inherited;
  pConfirma;
end;

procedure TfrmAltGlobCadClientes.btnDesmarcarClick(Sender: TObject);
begin
  inherited;
  If Not btnDesmarcar.Visible Then
    Exit;

  pMarcaDesmarca(False);
end;

procedure TfrmAltGlobCadClientes.btnLimpaFiltrosClick(Sender: TObject);
begin
  inherited;
  pLimpaCampos;
end;

procedure TfrmAltGlobCadClientes.btnMarcarClick(Sender: TObject);
begin
  inherited;
  If Not btnMarcar.Visible Then
    Exit;

  pMarcaDesmarca(True);
end;

procedure TfrmAltGlobCadClientes.btnSairClick(Sender: TObject);
begin
  case nbDados.PageIndex of
    0: inherited; // Parametros
    1: begin // Alteração
         if FqryCadCli.State = dsEdit then
           FqryCadCli.Cancel
         else
         begin
           If fMensagem('','Cancela registros?',['&Sim','&Não'],2) = 1 Then
             pLimpaTela;
         end;
       end;
  end;

end;

procedure TfrmAltGlobCadClientes.cdsParametrosAfterPost(DataSet: TDataSet);
begin
  inherited;
  pnlLiberacao.Visible := fCampoLiberacaoMarcado;
end;

procedure TfrmAltGlobCadClientes.cdsParametrosBeforePost(DataSet: TDataSet);
begin
  inherited;
  If ((cdsParametrosCAMPO.AsString = 'CLI_CODCLI') Or
      (cdsParametrosCAMPO.AsString = 'CLI_NOMCLI')) And
      (Not cdsParametrosMARCADO.AsBoolean) Then
    cdsParametrosMARCADO.AsBoolean :=  True;
end;

procedure TfrmAltGlobCadClientes.cdsParametrosMARCADOChange(Sender: TField);
begin
  inherited;
  if cdsParametrosCAMPO.AsString = 'CNDPAG' then
    pnlCndPag.Enabled := Sender.AsBoolean;
end;

procedure TfrmAltGlobCadClientes.cxeConsTam2PropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
Var
  strCodigo: String;
  strDescricao: string;
  campo: TCampo;
begin
  inherited;

  If Not Assigned(cxvTiposAlt.Controller.FocusedColumn) Then
    Exit;

  strCodigo := DisplayValue;

  If (Not fEmptyStr(strCodigo)) And (TcxTextEdit(Sender).Properties.MaxLength > 0) Then
    DisplayValue := fStrZero(strCodigo, TcxTextEdit(Sender).Properties.MaxLength);

  strDescricao := fRetDescricaoCadastro(TcxGridDBBandedColumn(cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName, DisplayValue, True, Error);

  If (strDescricao <> '') And (TcxGridDBBandedColumn(cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName <> '') Then
  Begin
    campo := fRetCampoDesc(TcxGridDBBandedColumn(cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName);
    If (campo.FieldName <> '') And (  Not (campo.FieldName = TcxGridDBBandedColumn(cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName)) Then
    Begin
      If FqryCadCli.State in dsEditModes Then
      Begin
        FqryCadCli.FieldByName(campo.FieldName).AsString := strDescricao;
      End;
    End;
  end;

  If Error Then
    ErrorText := ''
  Else
  If Not fValidaValor(DisplayValue) Then
  Begin
    Error := True;
    ErrorText := '';
  End
end;

procedure TfrmAltGlobCadClientes.cxeInt03PropertiesValidate(Sender: TObject;
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

procedure TfrmAltGlobCadClientes.cxeMasPerPropertiesValidate(Sender: TObject;
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

      pMensagemOk('O ' + TcxGridDBBandedColumn(cxvTiposAlt.Controller.FocusedColumn).Caption + ' deve estar entre 0 e 100!');
    End;

  End;
end;

procedure TfrmAltGlobCadClientes.cxeMasValPropertiesValidate(Sender: TObject;
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

procedure TfrmAltGlobCadClientes.cxvTiposAltEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  AAllow := True;
  if TcxGridDBBandedColumn(cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName = 'CLI_MENIPI' then
    AAllow := Sender.DataController.Values[Sender.DataController.FocusedRecordIndex, cxvTiposAlt.GetColumnByFieldName('CLI_SITIPI').Index] <> 'T'
  else
  if TcxGridDBBandedColumn(cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName = 'CLI_MENP_C' then
    AAllow := Sender.DataController.Values[Sender.DataController.FocusedRecordIndex, cxvTiposAlt.GetColumnByFieldName('CLI_SITP_C').Index] <> 'T'
  else
  if TcxGridDBBandedColumn(cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName = 'CLI_ENQIPI' then
    AAllow := AnsiMatchStr(Sender.DataController.Values[Sender.DataController.FocusedRecordIndex, cxvTiposAlt.GetColumnByFieldName('CLI_SITIPI').Index], ['M', 'S'])
  else
  if TcxGridDBBandedColumn(cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName = 'CLI_REDISS' then
    AAllow := Sender.DataController.Values[Sender.DataController.FocusedRecordIndex, cxvTiposAlt.GetColumnByFieldName('CLI_ALQISS').Index] > 0
  else
  if TcxGridDBBandedColumn(cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName = 'CLI_PERMFF' then
    AAllow := FAcessoPER_FF
  else
  if TcxGridDBBandedColumn(cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName = 'CLI_PERMFV' then
    AAllow := FAcessoPER_FF
  else
  if TcxGridDBBandedColumn(cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName = 'CLI_MICEMP' then
    AAllow := FAcessoCLIMEI
  else
  if TcxGridDBBandedColumn(cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName = 'CLI_PRORUR' then
    AAllow := FAcessoCLI_PR
end;

procedure TfrmAltGlobCadClientes.cxvTiposAltEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_Return: If FqryCadCli.State = dsEdit Then
                   FqryCadCli.Post;
  End;
end;

Procedure TfrmAltGlobCadClientes.pSalvaDescricao(strDado: String; AEdit: TcxCustomEdit; var Key: Char);
var
  strDescricao: string;
  campo: TCampo;
  Error: Boolean;
Begin
  Key := #0;
  AEdit.EditValue := strDado;
  AEdit.PostEditValue;
  Key := #0;

  Error := False;
  strDescricao := fRetDescricaoCadastro(TcxGridDBBandedColumn(cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName, strDado, True, Error);

  If (strDescricao <> '') And (TcxGridDBBandedColumn(cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName <> '') Then
  Begin
    campo := fRetCampoDesc(TcxGridDBBandedColumn(cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName);
    If (campo.FieldName <> '') And (  Not (campo.FieldName = TcxGridDBBandedColumn(cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName)) Then
    Begin
      If FqryCadCli.State in dsEditModes Then
      Begin
        FqryCadCli.FieldByName(campo.FieldName).AsString := strDescricao;
      End;
    End;
  end;

  Keybd_Event(VK_RETURN, 0, 0, 0);
End;

procedure TfrmAltGlobCadClientes.cxvTiposAltEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
Var
  qryDados: TUniQuery;
  arrSelecao: TConsultasArray;
  strNomCam: String;
begin
  inherited;

  strNomCam := TcxGridDBBandedColumn(AItem).DataBinding.FieldName;

  If fEntraCons(Key) Then
  Begin

    If fTemConsultaTabela(strNomCam) Then
    Begin

      qryDados := fCriaQuery;

      case AnsiIndexStr(strNomCam, ['CLI_CODCAC', 'CLI_CODRED', 'CLI_CODREG',
                                    'CLI_CODSUB', 'CLI_CODATI', 'CLI_CODFPG',
                                    'CLI_CODPOR', 'CLI_CODPO2', 'CLI_CODREP',
                                    'CLI_SUPREG', 'CLI_CODVEN', 'CLI_TIPCLI',
                                    'CLI_ENQIPI', 'CNDPAG',     'CODTRA'     ]) of
        0 : pPesqCanalAcesso(qryDados, Key, arrSelecao, AEdit);
        1 : pPesqRedeLojas(qryDados, Key, arrSelecao, AEdit);
        2 : pPesqRegiao(qryDados, Key, arrSelecao, AEdit);

        3 : pPesqSubRegiao(qryDados, Key, arrSelecao, AEdit);
        4 : pPesqAtividade(qryDados, Key, arrSelecao, AEdit);
        5 : pPesqFormaPgto(qryDados, Key, arrSelecao, AEdit);

        6 : pPesqPortador(qryDados, Key, arrSelecao, AEdit);
        7 : pPesqPortador(qryDados, Key, arrSelecao, AEdit);
        8 : pPesqOperador(qryDados, Key, arrSelecao, AEdit);

        9 : pPesqOperador(qryDados, Key, arrSelecao, AEdit);
        10: pPesqOperador(qryDados, Key, arrSelecao, AEdit);
        11: pPesqTipoCliente(qryDados, Key, arrSelecao, AEdit);

        12: pPesqEnquadramentoIPI(qryDados, Key, arrSelecao, AEdit);
        13: pPesqCondicoesPgto(qryDados, Key, arrSelecao, AEdit);
        14: pPesqTransportadora(qryDados, Key, arrSelecao, AEdit);
      end;

      FreeAndNil(qryDados);
    End;

  End;
end;

function TfrmAltGlobCadClientes.fTemCampoDesc(strField: string): Boolean;
var
  i : integer;
begin
  Result := False;
  For i := 0 To High(FArrCampos) do
  Begin
    If FArrCampos[i].FieldName = strField Then
    Begin
      If FArrCampos[i].blnTemDescricao Then
        exit(True);
    End;
  End
end;

function TfrmAltGlobCadClientes.fTemConsultaTabela(strNomCam: String): Boolean;
Begin
  If AnsiEndsStr('_NOV', strNomCam) Then
    strNomCam := AnsiReplaceStr(strNomCam, '_NOV', '');

  Result := Pos(strNomCam,
    'CLI_CODCAC_CLI_CODRED_CLI_CODREG_CLI_CODSUB_CLI_CODATI_CLI_CODFPG_'+
    'CLI_CODPOR_CLI_CODPO2_CLI_CODREP_CLI_SUPREG_CLI_CODVEN_CLI_TIPCLI_'+
    'CLI_ENQIPI_CNDPAG_CODTRA_') > 0;
End;

function TfrmAltGlobCadClientes.fRetDescricaoCadastro(strNomCam,
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

function TfrmAltGlobCadClientes.fRetCampoDesc(strField: string): TCampo;
var
  i : integer;
begin
  For i := 0 To High(FArrCampos) do
  Begin
    If FArrCampos[i].FieldName = strField Then
    Begin
      If FArrCampos[i].blnTemDescricao Then
        exit(FArrCampos[i + 1])
      Else
      Begin
        Result.Title := '';
        Result.FieldName := '';
        Result.ReadOnly := True;
        Result.Visible := False;
        Result.Properties:= Nil;
        Result.blnTemDescricao := False;
      end;
    End;
  End
end;

procedure TfrmAltGlobCadClientes.FormCreate(Sender: TObject);
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

procedure TfrmAltGlobCadClientes.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objLiberacao);
  FreeAndNil(FDtsCadCli);
  FreeAndNil(FqryCadCli);

  If Assigned(objLogAltCadCli) Then
    FreeAndNil(objLogAltCadCli);

  inherited;
end;

procedure TfrmAltGlobCadClientes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Escape) And (Assigned(ActiveControl)) And (ActiveControl.Name = '') Then
  Begin
    Key := 0;
    btnSair.Click;
  End;

  Case Key Of
    VK_F2 : btnMarcar.Click;
    VK_F3 : btnDesmarcar.Click;
    VK_F8 : btnLimpaFiltros.Click;
    VK_F10: btnConfirmaAlt.Click;
  End;

end;

function TfrmAltGlobCadClientes.fValidaCampos(Sender: TWinControl;
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
    If (not fEmptyStr(edtConsum.Text)) and (Pos(edtConsum.Text, 'SN') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Preencha o campo "Consumidor Final" corretamente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (sender = edtPermFF) Then
  Begin
    If (not fEmptyStr(edtPermFF.Text)) and (Pos(edtPermFF.Text, 'SN') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Preencha o campo "Permitir FF (A Prazo)" corretamente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (sender = edtPermFV) Then
  Begin
    If (not fEmptyStr(edtPermFV.Text)) and (Pos(edtPermFV.Text, 'SN') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Preencha o campo "Permitir FF (À Vista)" corretamente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (sender = edtRevist) Then
  Begin
    If (not fEmptyStr(edtRevist.Text)) and (Pos(edtRevist.Text, 'SN') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Preencha o campo "Revista" corretamente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtTabPre) Then
  Begin
    If (Not fEmptyStr(edtTabPre.Text)) and (Pos( edtTabPre.Text, FstrVrfTpr ) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Tabela de ' + clbPrcVenda.Caption + '!', ['&Ok']);
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmAltGlobCadClientes.fValidaLimiteCredito: Boolean;
var
  strOpeLibLimCre: String;
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
begin
  Result := True;

  if not fCampoMarcado('CLI_LIMCRE') then
    Exit;

  pVerificaLimiteCredito;

  cdsLimCre.Filtered := False;
  cdsLimCre.Filter := 'TIPO__ = ''1''';
  cdsLimCre.Filtered := True;

  if not cdsLimCre.IsEmpty then
  begin
    strOpeLibLimCre := strLoginUsuarioLogado;

    objLiberacao.Clear;
    objLiberacao.strDirAce    := 'LCRCLIOPE';
    objLiberacao.strSenLib    := fCfgSis('SENCRE');
    objLiberacao.strMsgSen    := 'Limite de Crédito';
    objLiberacao.strCodOpe    := strLoginUsuarioLogado;
    objLiberacao.strCodDig    := strLoginUsuarioLogado;
    objLiberacao.objMsgLibera.pAddTexto('Alteração de limite de crédito maior que alçada do operador ');
    objLiberacao.objMsgLibera.pAddQuebra();

    objTabela := TRegistroMsgLiberaTabela.Create();

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'Cliente'           , 70 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'CPF/CNPJ'          , 18 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Lim. Crédito Atual', 20 , alDireita , teAutcom);
    objLinha.pAddColuna(''  , 'Novo Lim. Crédito' , 20 , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    cdsLimCre.First;
    while not cdsLimCre.eof do
    begin

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('Cliente'            , cdsLimCreCODCLI.AsString + '-' + cdsLimCreNOMCLI.AsString, 70 , alEsquerda , teAutcom);
      objLinha.pAddColuna('CPF/CNPJ'           , fFormataCpfCgc(cdsLimCreCGCCPF.AsString, fSetaPais)      , 18 , alEsquerda , teAutcom);
      objLinha.pAddColuna('Lim. Crédito Atual' , FloatToStrF(cdsLimCreLIMANT.AsFloat, ffFixed, 15, 2)     , 20 , alDireita  , teAutcom);
      objLinha.pAddColuna('Novo Lim. Crédito'  , FloatToStrF(cdsLimCreLIMNOV.AsFloat, ffFixed, 15, 2)     , 20 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      cdsLimCre.Next;
    end;

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    Result := objLiberacao.fLibera;
    strOpeLibLimCre := objLiberacao.strOperador;

    If not Result Then
      raise ELiberacaoNãoRealizada.Create('A liberação do limite de crédito não foi realizada!');
  end;

  cdsLimCre.Filtered := False;
  cdsLimCre.Filter := 'TIPO__ = ''2''';
  cdsLimCre.Filtered := True;

  if not cdsLimCre.IsEmpty then
  begin
    strOpeLibLimCre := strLoginUsuarioLogado;

    objLiberacao.Clear;
    objLiberacao.strDirAce    := 'LCRCLI';
    objLiberacao.strSenLib    := fCfgSis('SENCRE');
    objLiberacao.strMsgSen    := 'Limite de Crédito';
    objLiberacao.strCodOpe    := strLoginUsuarioLogado;
    objLiberacao.strCodDig    := strLoginUsuarioLogado;
    objLiberacao.objMsgLibera.pAddTexto('Troca de limite de crédito.');
    objLiberacao.objMsgLibera.pAddQuebra();

    objTabela := TRegistroMsgLiberaTabela.Create();

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'Cliente'           , 70 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'CPF/CNPJ'          , 18 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Lim. Crédito Atual', 20 , alDireita , teAutcom);
    objLinha.pAddColuna(''  , 'Novo Lim. Crédito' , 20 , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    cdsLimCre.First;
    while not cdsLimCre.eof do
    begin

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('Cliente'            , cdsLimCreCODCLI.AsString + '-' + cdsLimCreNOMCLI.AsString, 70 , alEsquerda , teAutcom);
      objLinha.pAddColuna('CPF/CNPJ'           , fFormataCpfCgc(cdsLimCreCGCCPF.AsString, fSetaPais)      , 18 , alEsquerda , teAutcom);
      objLinha.pAddColuna('Lim. Crédito Atual' , FloatToStrF(cdsLimCreLIMANT.AsFloat, ffFixed, 15, 2)     , 20 , alDireita  , teAutcom);
      objLinha.pAddColuna('Novo Lim. Crédito'  , FloatToStrF(cdsLimCreLIMNOV.AsFloat, ffFixed, 15, 2)     , 20 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      cdsLimCre.Next;
    end;

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
    Result := objLiberacao.fLibera;
    strOpeLibLimCre := objLiberacao.strOperador;

    If not Result Then
      raise ELiberacaoNãoRealizada.Create('A liberação do limite de crédito não foi realizada!');
  end;
end;

procedure TfrmAltGlobCadClientes.pVerificaLimiteCredito;
var
  fltValorNovo: Double;
  fltValorAnte: Double;
begin
  cdsLimCre.Close;
  cdsLimCre.CreateDataSet;

  FqryCadCli.DisableControls;
  FqryCadCli.First;
  try

    while not FqryCadCli.Eof do
    begin
      fltValorNovo := FqryCadCli.FieldByName('CLI_LIMCRE').AsFloat;
      fltValorAnte := FqryCadCli.FieldByName('CLI_LIMCRE_ORI').AsFloat;

      if fltValorAnte <> fltValorNovo then
      begin

        If (fCfgSis('LMCROP', VarBoolean)) And
           (fltValorNovo > fLimCredOperador('', FqryCadCli.FieldByName('CLI_CODCLI').Value)) Then
        Begin
          if fCfgSis('LMCRTR', VarString) <> '1' then
          begin
            cdsLimCre.Append;
            cdsLimCreTIPO__.AsString := '1';
            cdsLimCreCODCLI.AsString := FqryCadCli.FieldByName('CLI_CODCLI').AsString;
            cdsLimCreNOMCLI.AsString := FqryCadCli.FieldByName('CLI_NOMCLI').AsString;
            cdsLimCreCGCCPF.AsString := FqryCadCli.FieldByName('CLI_C_G_C_').AsString;
            cdsLimCreLIMANT.AsFloat  := fltValorAnte;
            cdsLimCreLIMNOV.AsFloat  := fltValorNovo;
            cdsLimCre.Post;
          end;
        End
        Else
        Begin
          cdsLimCre.Append;
          cdsLimCreTIPO__.AsString := '2';
          cdsLimCreCODCLI.AsString := FqryCadCli.FieldByName('CLI_CODCLI').AsString;
          cdsLimCreNOMCLI.AsString := FqryCadCli.FieldByName('CLI_NOMCLI').AsString;
          cdsLimCreCGCCPF.AsString := FqryCadCli.FieldByName('CLI_C_G_C_').AsString;
          cdsLimCreLIMANT.AsFloat  := fltValorAnte;
          cdsLimCreLIMNOV.AsFloat  := fltValorNovo;
          cdsLimCre.Post;
        End;
      End;

      FqryCadCli.Next;
    end;
  finally
    FqryCadCli.First;
    FqryCadCli.EnableControls;
  end;
end;


function TfrmAltGlobCadClientes.fValidaPortador1: Boolean;
var
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
begin
  Result := True;

  if not fCampoMarcado('CLI_CODPOR') then
    Exit;

  pVerificaPortador1;

  if (Not fEmptyStr(fCfgSis('SENPOR'))) then
  begin
    cdsValida.Filtered := False;
    cdsValida.Filter := 'TIPO__ = ''1''';
    cdsValida.Filtered := True;

    if not cdsValida.IsEmpty then
    begin
      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'CLIPOR';
      objLiberacao.strSenLib    := fCfgSis('SENPOR');
      objLiberacao.strMsgSen    := 'Portador (1) em branco';
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.strCodDig    := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('Portador (1) em branco.');
      objLiberacao.objMsgLibera.pAddQuebra();

      objTabela := TRegistroMsgLiberaTabela.Create();

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'Cliente'         , 60 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'CPF/CNPJ'        , 18 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'Portador 1 Atual', 26 , alEsquerda , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      cdsValida.First;
      while not cdsValida.eof do
      begin

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Cliente'          , cdsValidaCODCLI.AsString + '-' + cdsValidaNOMCLI.AsString, 60 , alEsquerda , teAutcom);
        objLinha.pAddColuna('CPF/CNPJ'         , fFormataCpfCgc(cdsValidaCGCCPF.AsString, fSetaPais)      , 18 , alEsquerda , teAutcom);
        objLinha.pAddColuna('Portador 1 Atual' , cdsValidaPORANT.AsString + '-' + cdsValidaNOMANT.AsString, 26 , alEsquerda , teAutcom);
        objTabela.lstLinhas.Add(objLinha);

        cdsValida.Next;
      end;

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      Result := objLiberacao.fLibera;

      If not Result Then
        raise ELiberacaoNãoRealizada.Create('A liberação do Portador (1) não foi realizada!');
    end;
  end;

  if (Not fEmptyStr(fCfgSis('SENTPO'))) then
  begin
    cdsValida.Filtered := False;
    cdsValida.Filter := 'TIPO__ = ''2''';
    cdsValida.Filtered := True;

    if not cdsValida.IsEmpty then
    begin
      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'ALTPOR';
      objLiberacao.strSenLib    := fCfgSis('SENTPO');
      objLiberacao.strMsgSen    := 'Portador';
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.strCodDig    := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('Troca de portador 1 no Cadastro de Cliente.');
      objLiberacao.objMsgLibera.pAddQuebra();

      objTabela := TRegistroMsgLiberaTabela.Create();

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'Cliente'         , 60 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'CPF/CNPJ'        , 18 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'Portador 1 Atual', 26 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'Novo Portador 1' , 26 , alEsquerda , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      cdsValida.First;
      while not cdsValida.eof do
      begin

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Cliente'          , cdsValidaCODCLI.AsString + '-' + cdsValidaNOMCLI.AsString, 60 , alEsquerda , teAutcom);
        objLinha.pAddColuna('CPF/CNPJ'         , fFormataCpfCgc(cdsValidaCGCCPF.AsString, fSetaPais)      , 18 , alEsquerda , teAutcom);
        objLinha.pAddColuna('Portador 1 Atual' , cdsValidaPORANT.AsString + '-' + cdsValidaNOMANT.AsString, 26 , alEsquerda , teAutcom);
        objLinha.pAddColuna('Novo Portador 1'  , cdsValidaPORNOV.AsString + '-' + cdsValidaNOMNOV.AsString, 26 , alEsquerda , teAutcom);
        objTabela.lstLinhas.Add(objLinha);

        cdsValida.Next;
      end;

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      Result := objLiberacao.fLibera;

      If not Result Then
        raise ELiberacaoNãoRealizada.Create('A liberação do Portador (1) não foi realizada!');
    end;
  end;
end;

procedure TfrmAltGlobCadClientes.pVerificaPortador1;
var
  strValorNovo: String;
  strValorAnte: String;
begin
  cdsValida.Close;
  cdsValida.CreateDataSet;

  FqryCadCli.DisableControls;
  FqryCadCli.First;
  try

    while not FqryCadCli.Eof do
    begin
      strValorNovo := FqryCadCli.FieldByName('CLI_CODPOR').AsString;
      strValorAnte := FqryCadCli.FieldByName('CLI_CODPOR_ORI').AsString;

      if strValorAnte <> strValorNovo then
      begin
        if fEmptyStr(strValorNovo) then
        begin
          cdsValida.Append;
          cdsValidaTIPO__.AsString := '1';
          cdsValidaCODCLI.AsString := FqryCadCli.FieldByName('CLI_CODCLI').AsString;
          cdsValidaNOMCLI.AsString := FqryCadCli.FieldByName('CLI_NOMCLI').AsString;
          cdsValidaCGCCPF.AsString := FqryCadCli.FieldByName('CLI_C_G_C_').AsString;
          cdsValidaPORANT.AsString := strValorAnte;
          cdsValidaPORNOV.AsString := strValorNovo;
          cdsValidaNOMANT.AsString := FqryCadCli.FieldByName('POR_NOMPOR_ORI').AsString;
          cdsValidaNOMNOV.AsString := FqryCadCli.FieldByName('POR_NOMPOR').AsString;;
          cdsValida.Post;
        end
        else
        Begin
          cdsValida.Append;
          cdsValidaTIPO__.AsString := '2';
          cdsValidaCODCLI.AsString := FqryCadCli.FieldByName('CLI_CODCLI').AsString;
          cdsValidaNOMCLI.AsString := FqryCadCli.FieldByName('CLI_NOMCLI').AsString;
          cdsValidaCGCCPF.AsString := FqryCadCli.FieldByName('CLI_C_G_C_').AsString;
          cdsValidaPORANT.AsString := strValorAnte;
          cdsValidaPORNOV.AsString := strValorNovo;
          cdsValidaNOMANT.AsString := FqryCadCli.FieldByName('POR_NOMPOR_ORI').AsString;
          cdsValidaNOMNOV.AsString := FqryCadCli.FieldByName('POR_NOMPOR').AsString;;
          cdsValida.Post;
        End;
      end;

      FqryCadCli.Next;
    end;
  finally
    FqryCadCli.First;
    FqryCadCli.EnableControls;
  end;
end;

function TfrmAltGlobCadClientes.fValidaPortador2: Boolean;
var
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
begin
  Result := True;

  if not fCampoMarcado('CLI_CODPO2') then
    Exit;

  pVerificaPortador2;

  if (Not fEmptyStr(fCfgSis('SENPO2'))) then
  begin
    cdsValida.Filtered := False;
    cdsValida.Filter := 'TIPO__ = ''1''';
    cdsValida.Filtered := True;

    if not cdsValida.IsEmpty then
    begin
      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'CLIPO2';
      objLiberacao.strSenLib    := fCfgSis('SENPO2');
      objLiberacao.strMsgSen    := 'Portador (2) em branco';
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.strCodDig    := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('Portador (2) em branco.');
      objLiberacao.objMsgLibera.pAddQuebra();

      objTabela := TRegistroMsgLiberaTabela.Create();

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'Cliente'         , 60 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'CPF/CNPJ'        , 18 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'Portador 2 Atual', 26 , alEsquerda , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      cdsValida.First;
      while not cdsValida.eof do
      begin

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Cliente'          , cdsValidaCODCLI.AsString + '-' + cdsValidaNOMCLI.AsString, 60 , alEsquerda , teAutcom);
        objLinha.pAddColuna('CPF/CNPJ'         , fFormataCpfCgc(cdsValidaCGCCPF.AsString, fSetaPais)      , 18 , alEsquerda , teAutcom);
        objLinha.pAddColuna('Portador 2 Atual' , cdsValidaPORANT.AsString + '-' + cdsValidaNOMANT.AsString, 26 , alEsquerda , teAutcom);
        objTabela.lstLinhas.Add(objLinha);

        cdsValida.Next;
      end;

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      Result := objLiberacao.fLibera;

      If not Result Then
        raise ELiberacaoNãoRealizada.Create('A liberação do Portador (2) não foi realizada!');
    end;
  end;

  if (Not fEmptyStr( fCfgSis('SENTPO'))) then
  begin
    cdsValida.Filtered := False;
    cdsValida.Filter := 'TIPO__ = ''2''';
    cdsValida.Filtered := True;

    if not cdsValida.IsEmpty then
    begin
      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'ALTPOR';
      objLiberacao.strSenLib    := fCfgSis('SENTPO');
      objLiberacao.strMsgSen    := 'Portador';
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.strCodDig    := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('Troca de portador 2 no Cadastro de Cliente.');
      objLiberacao.objMsgLibera.pAddQuebra();

      objTabela := TRegistroMsgLiberaTabela.Create();

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'Cliente'         , 60 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'CPF/CNPJ'        , 18 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'Portador 2 Atual', 26 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'Novo Portador 2' , 26 , alEsquerda , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      cdsValida.First;
      while not cdsValida.eof do
      begin

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Cliente'          , cdsValidaCODCLI.AsString + '-' + cdsValidaNOMCLI.AsString, 60 , alEsquerda , teAutcom);
        objLinha.pAddColuna('CPF/CNPJ'         , fFormataCpfCgc(cdsValidaCGCCPF.AsString, fSetaPais)      , 18 , alEsquerda , teAutcom);
        objLinha.pAddColuna('Portador 2 Atual' , cdsValidaPORANT.AsString + '-' + cdsValidaNOMANT.AsString, 26 , alEsquerda , teAutcom);
        objLinha.pAddColuna('Novo Portador 2'  , cdsValidaPORNOV.AsString + '-' + cdsValidaNOMNOV.AsString, 26 , alEsquerda , teAutcom);
        objTabela.lstLinhas.Add(objLinha);

        cdsValida.Next;
      end;

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      Result := objLiberacao.fLibera;

      If not Result Then
        raise ELiberacaoNãoRealizada.Create('A liberação do Portador (2) não foi realizada!');
    end;
  end;
end;

procedure TfrmAltGlobCadClientes.pVerificaPortador2;
var
  strValorNovo: String;
  strValorAnte: String;
begin
  cdsValida.Close;
  cdsValida.CreateDataSet;

  FqryCadCli.DisableControls;
  FqryCadCli.First;
  try

    while not FqryCadCli.Eof do
    begin
      strValorNovo := FqryCadCli.FieldByName('CLI_CODPO2').AsString;
      strValorAnte := FqryCadCli.FieldByName('CLI_CODPO2_ORI').AsString;

      if strValorAnte <> strValorNovo then
      begin
        if fEmptyStr(strValorNovo) then
        begin
          cdsValida.Append;
          cdsValidaTIPO__.AsString := '1';
          cdsValidaCODCLI.AsString := FqryCadCli.FieldByName('CLI_CODCLI').AsString;
          cdsValidaNOMCLI.AsString := FqryCadCli.FieldByName('CLI_NOMCLI').AsString;
          cdsValidaCGCCPF.AsString := FqryCadCli.FieldByName('CLI_C_G_C_').AsString;
          cdsValidaPORANT.AsString := strValorAnte;
          cdsValidaPORNOV.AsString := strValorNovo;
          cdsValidaNOMANT.AsString := FqryCadCli.FieldByName('POR_NOMPO2_ORI').AsString;
          cdsValidaNOMNOV.AsString := FqryCadCli.FieldByName('POR_NOMPO2').AsString;;
          cdsValida.Post;
        end
        else
        Begin
          cdsValida.Append;
          cdsValidaTIPO__.AsString := '2';
          cdsValidaCODCLI.AsString := FqryCadCli.FieldByName('CLI_CODCLI').AsString;
          cdsValidaNOMCLI.AsString := FqryCadCli.FieldByName('CLI_NOMCLI').AsString;
          cdsValidaCGCCPF.AsString := FqryCadCli.FieldByName('CLI_C_G_C_').AsString;
          cdsValidaPORANT.AsString := strValorAnte;
          cdsValidaPORNOV.AsString := strValorNovo;
          cdsValidaNOMANT.AsString := FqryCadCli.FieldByName('POR_NOMPO2_ORI').AsString;
          cdsValidaNOMNOV.AsString := FqryCadCli.FieldByName('POR_NOMPO2').AsString;;
          cdsValida.Post;
        End;
      end;

      FqryCadCli.Next;
    end;
  finally
    FqryCadCli.First;
    FqryCadCli.EnableControls;
  end;
end;

function TfrmAltGlobCadClientes.fValidaRepresentante: Boolean;
var
  strValorNovo: String;
  strValorAnte: String;
  blnTemValidacao: Boolean;
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
begin
  Result := True;

  if not fCampoMarcado('CLI_CODREP') then
    Exit;

  blnTemValidacao := False;

  objTabela := TRegistroMsgLiberaTabela.Create();

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'Cliente'            , 60 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'CPF/CNPJ'           , 18 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'Representante Atual', 26 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'Novo Representante' , 26 , alEsquerda , teAutcom);
  objTabela.lstLinhas.Add(objLinha);

  FqryCadCli.DisableControls;
  FqryCadCli.First;
  try

    while not FqryCadCli.Eof do
    begin
      strValorNovo := FqryCadCli.FieldByName('CLI_CODREP').AsString;
      strValorAnte := FqryCadCli.FieldByName('CLI_CODREP_ORI').AsString;

      if strValorAnte <> strValorNovo then
      begin
        blnTemValidacao := True;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Cliente'            , FqryCadCli.FieldByName('CLI_CODCLI').AsString + '-' + FqryCadCli.FieldByName('CLI_NOMCLI').AsString, 60 , alEsquerda , teAutcom);
        objLinha.pAddColuna('CPF/CNPJ'           , fFormataCpfCgc(FqryCadCli.FieldByName('CLI_C_G_C_').AsString, fSetaPais)                           , 18 , alEsquerda , teAutcom);
        objLinha.pAddColuna('Representante Atual', strValorAnte + '-' + FqryCadCli.FieldByName('OPE_NOMREP_ORI').AsString                             , 26 , alEsquerda , teAutcom);
        objLinha.pAddColuna('Novo Representante' , strValorNovo + '-' + FqryCadCli.FieldByName('OPE_NOMREP').AsString                                 , 26 , alEsquerda , teAutcom);
        objTabela.lstLinhas.Add(objLinha);
      end;

      FqryCadCli.Next;
    end;
  finally
    FqryCadCli.First;
    FqryCadCli.EnableControls;
  end;

  if blnTemValidacao then
  begin
    If (Not fPermitirAlterarVendedorERepresentante) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'ALTVCL';
      objLiberacao.strSenLib    := fCfgSis('SENVEN');
      objLiberacao.strMsgSen    := 'Representante';
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.strCodDig    := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('Troca de Representante no Cadastro de Cliente.');
      objLiberacao.objMsgLibera.pAddQuebra();

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      Result := objLiberacao.fLibera;

      If not Result Then
        raise ELiberacaoNãoRealizada.Create('A liberação do Representante não foi realizada!');
    End;
  end;
end;

function TfrmAltGlobCadClientes.fValidaTabelaPreco: Boolean;
var
  strValorNovo: String;
  strValorAnte: String;
  blnTemValidacao: Boolean;
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
begin
  Result := True;

  if not fCampoMarcado('CLI_TABPRE') then
    Exit;

  if not (fCfgSis('SENTTP', varString) = 'S') then
    Exit;

  blnTemValidacao := False;

  objTabela := TRegistroMsgLiberaTabela.Create();

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'Cliente'              , 60 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'CPF/CNPJ'             , 18 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'Tabela de Preço Atual', 25 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'Nova Tabela de Preço' , 25 , alEsquerda , teAutcom);
  objTabela.lstLinhas.Add(objLinha);

  FqryCadCli.DisableControls;
  FqryCadCli.First;
  try

    while not FqryCadCli.Eof do
    begin
      strValorNovo := FqryCadCli.FieldByName('CLI_TABPRE').AsString;
      strValorAnte := FqryCadCli.FieldByName('CLI_TABPRE_ORI').AsString;

      if strValorAnte <> strValorNovo then
      begin
        blnTemValidacao := True;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Cliente'              , FqryCadCli.FieldByName('CLI_CODCLI').AsString + '-' + FqryCadCli.FieldByName('CLI_NOMCLI').AsString, 60 , alEsquerda , teAutcom);
        objLinha.pAddColuna('CPF/CNPJ'             , fFormataCpfCgc(FqryCadCli.FieldByName('CLI_C_G_C_').AsString, fSetaPais)                           , 18 , alEsquerda , teAutcom);
        objLinha.pAddColuna('Tabela de Preço Atual', strValorAnte                                                                                       , 25 , alEsquerda , teAutcom);
        objLinha.pAddColuna('Nova Tabela de Preço' , strValorNovo                                                                                       , 25 , alEsquerda , teAutcom);
        objTabela.lstLinhas.Add(objLinha);
      end;

      FqryCadCli.Next;
    end;
  finally
    FqryCadCli.First;
    FqryCadCli.EnableControls;
  end;

  if blnTemValidacao then
  begin
    objLiberacao.Clear;
    objLiberacao.strDirAce    := 'CLIPRE';
    objLiberacao.strSenLib    := fCfgSis('SENTPC');
    objLiberacao.strMsgSen    := 'Tabela de Preço do Cliente';
    objLiberacao.strCodOpe    := strLoginUsuarioLogado;
    objLiberacao.strCodDig    := strLoginUsuarioLogado;
    objLiberacao.objMsgLibera.pAddTexto('Troca de tabela de preço no Cadastro de Cliente.');
    objLiberacao.objMsgLibera.pAddQuebra();

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    Result := objLiberacao.fLibera;

    If not Result Then
      raise ELiberacaoNãoRealizada.Create('A liberação da Tabela de Preço não foi realizada!');
  end;
end;

function TfrmAltGlobCadClientes.fValidaTipoCliente: Boolean;
var
  strValorNovo: String;
  strValorAnte: String;
  blnTemValidacao: Boolean;
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
begin
  Result := True;

  if not fCampoMarcado('CLI_TIPCLI') then
    Exit;

  if fEmptyStr( fCfgSis('SENTCL')) then
    Exit;

  blnTemValidacao := False;

  objTabela := TRegistroMsgLiberaTabela.Create();

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'Cliente'              , 60 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'CPF/CNPJ'             , 18 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'Tipo de Cliente Atual', 26 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'Novo Tipo de Cliente' , 26 , alEsquerda , teAutcom);
  objTabela.lstLinhas.Add(objLinha);

  FqryCadCli.DisableControls;
  FqryCadCli.First;
  try

    while not FqryCadCli.Eof do
    begin
      strValorNovo := FqryCadCli.FieldByName('CLI_TIPCLI').AsString;
      strValorAnte := FqryCadCli.FieldByName('CLI_TIPCLI_ORI').AsString;

      if strValorAnte <> strValorNovo then
      begin
        blnTemValidacao := True;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Cliente'              , FqryCadCli.FieldByName('CLI_CODCLI').AsString + '-' + FqryCadCli.FieldByName('CLI_NOMCLI').AsString, 60 , alEsquerda , teAutcom);
        objLinha.pAddColuna('CPF/CNPJ'             , fFormataCpfCgc(FqryCadCli.FieldByName('CLI_C_G_C_').AsString, fSetaPais)                           , 18 , alEsquerda , teAutcom);
        objLinha.pAddColuna('Tipo de Cliente Atual', strValorAnte + '-' + FqryCadCli.FieldByName('TIP_DESTIP_ORI').AsString                             , 26 , alEsquerda , teAutcom);
        objLinha.pAddColuna('Novo Tipo de Cliente' , strValorNovo + '-' + FqryCadCli.FieldByName('TIP_DESTIP').AsString                                 , 26 , alEsquerda , teAutcom);
        objTabela.lstLinhas.Add(objLinha);
      end;

      FqryCadCli.Next;
    end;
  finally
    FqryCadCli.First;
    FqryCadCli.EnableControls;
  end;

  if blnTemValidacao then
  begin
    objLiberacao.Clear;
    objLiberacao.strDirAce    := 'ALTTPC';
    objLiberacao.strSenLib    := fCfgSis('SENTCL');
    objLiberacao.strMsgSen    := 'Tipo de Cliente';
    objLiberacao.strCodOpe    := strLoginUsuarioLogado;
    objLiberacao.strCodDig    := strLoginUsuarioLogado;
    objLiberacao.objMsgLibera.pAddTexto('Troca de tipo de cliente no Cadastro de Cliente.');
    objLiberacao.objMsgLibera.pAddQuebra();

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    Result := objLiberacao.fLibera;

    If not Result Then
      raise ELiberacaoNãoRealizada.Create('A liberação do Tipo de Cliente não foi realizada!');
  end;
end;

function TfrmAltGlobCadClientes.fValidaVendedor: Boolean;
var
  strValorNovo: String;
  strValorAnte: String;
  blnTemValidacao: Boolean;
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
begin
  Result := True;

  if not fCampoMarcado('CLI_CODVEN') then
    Exit;

  blnTemValidacao := False;

  objTabela := TRegistroMsgLiberaTabela.Create();

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'Cliente'       , 60 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'CPF/CNPJ'      , 18 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'Vendedor Atual', 26 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'Novo Vendedor' , 26 , alEsquerda , teAutcom);
  objTabela.lstLinhas.Add(objLinha);

  FqryCadCli.DisableControls;
  FqryCadCli.First;
  try

    while not FqryCadCli.Eof do
    begin
      strValorNovo := FqryCadCli.FieldByName('CLI_CODVEN').AsString;
      strValorAnte := FqryCadCli.FieldByName('CLI_CODVEN_ORI').AsString;

      if strValorAnte <> strValorNovo then
      begin
        blnTemValidacao := True;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Cliente'       , FqryCadCli.FieldByName('CLI_CODCLI').AsString + '-' + FqryCadCli.FieldByName('CLI_NOMCLI').AsString, 60 , alEsquerda , teAutcom);
        objLinha.pAddColuna('CPF/CNPJ'      , fFormataCpfCgc(FqryCadCli.FieldByName('CLI_C_G_C_').AsString, fSetaPais)                           , 18 , alEsquerda , teAutcom);
        objLinha.pAddColuna('Vendedor Atual', strValorAnte + '-' + FqryCadCli.FieldByName('OPE_NOMVEN_ORI').AsString                             , 26 , alEsquerda , teAutcom);
        objLinha.pAddColuna('Novo Vendedor' , strValorNovo + '-' + FqryCadCli.FieldByName('OPE_NOMVEN').AsString                                 , 26 , alEsquerda , teAutcom);
        objTabela.lstLinhas.Add(objLinha);
      end;

      FqryCadCli.Next;
    end;
  finally
    FqryCadCli.First;
    FqryCadCli.EnableControls;
  end;

  if blnTemValidacao then
  begin
    If (Not fPermitirAlterarVendedorERepresentante) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'ALTVCL';
      objLiberacao.strSenLib    := fCfgSis('SENVEN');
      objLiberacao.strMsgSen    := 'Vendedor';
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.strCodDig    := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('Troca de Vendedor no Cadastro de Cliente.');
      objLiberacao.objMsgLibera.pAddQuebra();

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      Result := objLiberacao.fLibera;

      If not Result Then
        raise ELiberacaoNãoRealizada.Create('A liberação do Vendedor não foi realizada!');
    End;
  end;
end;

procedure TfrmAltGlobCadClientes.pIncluiCampo(strNomCam, strTitulo: String;
  blnVisible: Boolean; proProperties: TcxCustomEditProperties; strFieldDesc,
  strFieldDescTitle: String);
var
  intContador: Integer;
  Campo: TCampo;
begin
   intContador := Length(FArrCampos);
   SetLength(FArrCampos, intContador + 1);

   Campo.FieldName  := strNomCam;
   Campo.Title      := strTitulo;
   Campo.Visible    := blnVisible;
   Campo.Properties := proProperties;
   Campo.ReadOnly   := AnsiMatchStr(strNomCam, ['CLI_CODCLI', 'CLI_NOMCLI']);
   Campo.blnTemDescricao := (strFieldDesc <> '');

   FArrCampos[intContador] := Campo;

   If Campo.blnTemDescricao Then
   Begin
     intContador := Length(FArrCampos);
     SetLength(FArrCampos, intContador + 1);

     Campo.FieldName  := strFieldDesc;
     Campo.Title      := strFieldDescTitle;
     Campo.Visible    := blnVisible;
     Campo.ReadOnly   := True;
     Campo.Properties := proProperties;
     Campo.blnTemDescricao := False;

     FArrCampos[intContador] := Campo;
   End;
end;

procedure TfrmAltGlobCadClientes.pIncluiParametro(const strAba, strCampo, strDescricao: String; const blnMarcado: boolean = False);
Begin
  cdsParametros.Append;
  cdsParametrosMARCADO.AsBoolean := IIf(blnMarcado, 1, 0);
  cdsParametrosABA.AsString      := strAba;
  cdsParametrosCAMPO.AsString    := strCampo;
  cdsParametrosDESCRI.AsString   := strDescricao;// + '|' + RemoveAcento(ADescricao);
  cdsParametros.Post;
End;

procedure TfrmAltGlobCadClientes.pLimpaCampos;
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

procedure TfrmAltGlobCadClientes.pLimpaTela;
begin
 pnlFiltro.Enabled := True;
 If fMensagem('', 'Deseja limpar a tela?',['&Sim','&Não'],1) = 1 Then
 begin
   pLimpaCampos;
   pMarcaDesmarca(False);
 end;
 FqryCadCli.Close;
 nbDados.PageIndex := nbDados.PageIndex - 1;
end;

procedure TfrmAltGlobCadClientes.pMarcaDesmarca(blnMarcar: Boolean);
begin
  cdsParametros.DisableControls;
  cdsParametros.First;
  While not cdsParametros.Eof Do
  Begin
    cdsParametros.Edit;
    cdsParametrosMarcado.AsBoolean := blnMarcar;
    cdsParametros.Post;
    cdsParametros.Next;
  End;
  cdsParametros.First;
  cdsParametros.EnableControls;
end;

procedure TfrmAltGlobCadClientes.pMarcaCampo(const strCampo: String);
var
  intRecNo: Integer;
begin
  intRecNo := cdsParametros.RecNo;
  If cdsParametros.Locate('CAMPO', strCampo, []) Then
  begin
    cdsParametros.Edit;
    cdsParametros.FieldByName('MARCADO').AsBoolean := True;
    cdsParametros.Post;

    cdsParametros.RecNo := intRecNo;
  end;
end;

procedure TfrmAltGlobCadClientes.pMarcaCamposObrigatorios;
begin
  if fCampoMarcado('CLI_MENIPI') or fCampoMarcado('CLI_ENQIPI') then
    pMarcaCampo('CLI_SITIPI');

  if fCampoMarcado('CLI_MENP_C') then
    pMarcaCampo('CLI_SITP_C');

  if fCampoMarcado('CLI_REDISS') then
    pMarcaCampo('CLI_ALQISS');
end;

procedure TfrmAltGlobCadClientes.pPreparaColunas;
const
  ABA_GERAL = 'Geral';
  ABA_COMPL = 'Complementos';
  ABA_FISCA = 'Dados Fiscais';
  ABA_CNDPG = 'Condições de Pagamento';
  ABA_COBRA = 'Dados de Cobrança';
  ABA_ENDER = 'Endereços de Entrega';
begin
  pAddColuna(ABA_GERAL, 'CLI_CODCLI', 'Código');
  pAddColuna(ABA_GERAL, 'CLI_NOMCLI', 'Nome/Razão');
  pAddColuna(ABA_COMPL, 'CLI_CODCAC', 'Canal de Acesso', cxeConsTam5.Properties, True, 'CAC_NOMCAC', 'Desc. Canal de Acesso');
  pAddColuna(ABA_COMPL, 'CLI_CATEGO', 'Categoria', cxeCategoria.Properties);
  pAddColuna(ABA_COMPL, 'CLI_PERCOM', 'Comissão', cxeMasPer.Properties, (fCfgSis('OPCCOM') = 'CV'));
  pAddColuna(ABA_COMPL, 'CLI_DESCON', 'Desconto para Profissionais', cxeMasPer.Properties, (fCfgSis('CLIDES', varBoolean)));
  pAddColuna(ABA_COMPL, 'CLI_PEREMP', 'Permite empréstimo', cmbSimNao.Properties, (fCfgSis('PREMEP', varBoolean)));
  pAddColuna(ABA_COMPL, 'CLI_PERAGU', 'Permitir Entrega Futura com Status "Aguardando o Cliente"', cmbSimNao.Properties);
  pAddColuna(ABA_COMPL, 'CLI_PERFAL', 'Permitir Entrega Futura com Status "Falta de Produto"', cmbSimNao.Properties);
  pAddColuna(ABA_COMPL, 'CLI_PERPRE', 'Permitir Entrega Futura com Status "Previsão de Entrega"', cmbSimNao.Properties);
  pAddColuna(ABA_COMPL, 'CLI_PERMFF', 'Permitir FF (A Prazo)', cmbSimNao.Properties, (fPermiteEmissaoEspecie('FF')) And (fCfgSis('PEMIFF') = '2'));
  pAddColuna(ABA_COMPL, 'CLI_PERMFV', 'Permitir FF (À Vista)', cmbSimNao.Properties, (fPermiteEmissaoEspecie('FF')) And (fCfgSis('PEMIFF') = '2'));
  pAddColuna(ABA_COMPL, 'CLI_CODRED', 'Rede de Lojas', cxeConsTam5.Properties, True, 'RED_DESRED', 'Desc. Rede de Lojas');
  pAddColuna(ABA_COMPL, 'CLI_CODREG', 'Região', cxeConsTam5.Properties, True, 'REG_DESREG', 'Desc. Região');
  pAddColuna(ABA_COMPL, 'CLI_REVIST', 'Revista', cmbSimNao.Properties);
  pAddColuna(ABA_COMPL, 'CLI_CODSUB', 'Sub-Região', cxeConsTam5.Properties, True, 'SUB_DESSUB', 'Desc. Região');
  pAddColuna(ABA_CNDPG, 'CNDPAG',     'Condição de Pagamento', cxeConsTam3.Properties, fCfgSis('USACND', varBoolean) and fVerificaAcessoSistema('CLCNDP'), 'DESCND', 'Desc. Condição de Pagamento');
  pAddColuna(ABA_COBRA, 'CLI_ENVBOL', 'Enviar boleto por e-mail', cmbSimNao.Properties);
  pAddColuna(ABA_COBRA, 'CLI_BOLIMP', 'Impressão do boleto pelo faturamento será feita por', cxeBolImp.Properties);
  pAddColuna(ABA_FISCA, 'CLI_ALQISS', 'Alíquota de ISS', cxeMasPer.Properties);
  pAddColuna(ABA_FISCA, 'CLI_RECAP_', 'Benefício Fiscal RECAP', cmbSimNao.Properties);
  pAddColuna(ABA_FISCA, 'CLI_BENREI', 'Benefício REIDI', cmbSimNao.Properties);
  pAddColuna(ABA_FISCA, 'CLI_CODCNA', 'CNAE', cxeCodCna.Properties);
  pAddColuna(ABA_FISCA, 'CLI_CDESPI', 'Calcula desconto de PIS/COFINS/IRPJ/CSLL', cmbSimNao.Properties, (not fCfgSis('SIMPAU', varBoolean)) and (not fCfgSis('RETIMP', varBoolean)));
  pAddColuna(ABA_FISCA, 'CLI_CODEAC', 'Cobrar Despesas Acessórias', cmbSimNao.Properties);
  pAddColuna(ABA_FISCA, 'CLI_TAXENT', 'Cobrar Taxa de Entrega', cmbSimNao.Properties, fCfgSis('TAXENT', varBoolean));
  pAddColuna(ABA_FISCA, 'CLI_PRSTRE', 'Código do processo Sujeito passivo por ST atribuída por regime especial', cxeString40.Properties);
  pAddColuna(ABA_FISCA, 'CLI_RETPCO', 'Retém PIS e Cofins', cmbSimNao.Properties, (not fCfgSis('SIMPAU', varBoolean)) and (not fCfgSis('RETIMP', varBoolean)));
  pAddColuna(ABA_FISCA, 'CLI_ICMREI', 'Deduzir ICMS do Benefício REIDI', cmbSimNao.Properties);
  pAddColuna(ABA_FISCA, 'CLI_DESOPE', 'Despesas Operacionais Complementar', cxeMasPer.Properties, fCfgSis('CLIDOP', varBoolean));
  pAddColuna(ABA_FISCA, 'CLI_ENQIPI', 'Enquadramento IPI', cxeConsTam3.Properties, True, 'EQI_DESCRI', 'Desc. Enquadramento IPI');
  pAddColuna(ABA_FISCA, 'CLI_TFTNES', 'Fator Nota Especial', cxeString01.Properties, fCfgSis('FTNFES', varBoolean));
  pAddColuna(ABA_FISCA, 'CLI_INDUST', 'Indústria', cmbSimNao.Properties);
  pAddColuna(ABA_FISCA, 'CLI_IVAESP', 'IVA Especial com carga média para "MT/CE" (Produtos Importados)', cxeMasVal.Properties);
  pAddColuna(ABA_FISCA, 'CLI_IVANAC', 'IVA Especial com carga média para "MT/CE" (Produtos Nacionais)', cxeMasVal.Properties);
  pAddColuna(ABA_FISCA, 'CLI_CEDESP', 'IVA Especial-Itens c/NCM no CEDEM-com carga média para "MT/CE" (Prod. Importados)', cxeMasVal.Properties);
  pAddColuna(ABA_FISCA, 'CLI_CEDNAC', 'IVA Especial-Itens c/NCM no CEDEM-com carga média para "MT/CE" (Prod. Nacionais)', cxeMasVal.Properties);
  pAddColuna(ABA_FISCA, 'CLI_MENIPI', 'Mensagem IPI', cxeMemo.Properties);
  pAddColuna(ABA_FISCA, 'CLI_MENP_C', 'Mensagem PIS/COFINS', cxeMemo.Properties);
  pAddColuna(ABA_FISCA, 'CLI_IVASIM', 'Percentual carga média para "MT/CE" (CNAE Simplificado)', cxeMasPer.Properties);
  pAddColuna(ABA_FISCA, 'CLI_CEDSIM', 'Percentual-Itens c/NCM no CEDEM-carga média para "MT/CE" (CNAE Simplificado)', cxeMasPer.Properties);
  pAddColuna(ABA_FISCA, 'CLI_SIBICM', 'Quando IVA Especial "MT", somar IPI na base de ICMS', cmbSimNao.Properties);
  pAddColuna(ABA_FISCA, 'CLI_REDISS', 'Redução Base Cálculo do ISS', cxeMasPer.Properties);
  pAddColuna(ABA_FISCA, 'CLI_REDICM', 'Redução de Base de ICMS para produtos tributados', cxeMasPer.Properties);
  pAddColuna(ABA_FISCA, 'CLI_REGTRI', 'Regime Tributário', cxeRegTri.Properties);
  pAddColuna(ABA_FISCA, 'CLI_RETIRF', 'Retém IRPJ', cmbSimNao.Properties, (not fCfgSis('SIMPAU', varBoolean)) and (not fCfgSis('RETIMP', varBoolean)));
  pAddColuna(ABA_FISCA, 'CLI_RETISS', 'Retém ISS', cmbSimNao.Properties);
  pAddColuna(ABA_FISCA, 'CLI_SEGSOC', 'Seguridade Social', cmbSimNao.Properties);
  pAddColuna(ABA_FISCA, 'CLI_SITIPI', 'Situação IPI', cxeSitIpi.Properties);
  pAddColuna(ABA_FISCA, 'CLI_SITP_C', 'Situação PIS/COFINS', cxeSitP_C.Properties);
  pAddColuna(ABA_FISCA, 'CLI_SITPCP', 'Situação PIS/COFINS Venda Presencial', cxeSitP_C.Properties);
  pAddColuna(ABA_FISCA, 'CLI_SUFRAM', 'Suframa', cxeString20.Properties);
  pAddColuna(ABA_FISCA, 'CLI_INDCOM', 'Sugestão para Industrialização ou Comercialização', cxeIndCom.Properties, fCfgSis('INDCOM', varBoolean));
  pAddColuna(ABA_FISCA, 'CLI_STREES', 'Sujeito passivo por ST atribuída por regime especial', cmbSimNao.Properties);
  pAddColuna(ABA_FISCA, 'CLI_TFTNES', 'Tipo de Fator Nota Especial', cxeTFTNES.Properties, fCfgSis('FTNFES', varBoolean));
  pAddColuna(ABA_FISCA, 'CLI_DIFERI', 'Utilizar diferimento de ICMS', cmbSimNao.Properties);
  pAddColuna(ABA_FISCA, 'CLI_DIF_ST', 'Utilizar diferimento de ST', cmbSimNao.Properties, fCfgSis('EMPDIS', varBoolean));
  pAddColuna(ABA_FISCA, 'CLI_ZONFRA', 'Zona Franca', cmbSimNao.Properties);
  pAddColuna(ABA_ENDER, 'TIPFRE', 'Tipo de Frete', cxeTipFre.Properties);
  pAddColuna(ABA_ENDER, 'CODTRA', 'Transportadora', cxeConsTam5.Properties, True, 'NOMTRA', 'Nome Transportadora');
  pAddColuna(ABA_GERAL, 'CLI_CODATI', 'Atividade', cxeConsTam3.Properties, True, 'ATI_DESATI', 'Desc. Atividade');
  pAddColuna(ABA_GERAL, 'CLI_CONSUM', 'Consumidor Final', cmbSimNao.Properties);
  pAddColuna(ABA_GERAL, 'CLI_CODFPG', 'Forma de Pagamento', cxeConsTam3.Properties, True, 'FPG_DESCRI', 'Desc. Forma de Pagamento');
  pAddColuna(ABA_GERAL, 'CLI_LIMCRE', 'Limite de Crédito', cxeMasVal.Properties);
  pAddColuna(ABA_GERAL, 'CLI_MICEMP', 'MEI - Micro Empreendedor Individual', cmbSimNao.Properties);
  pAddColuna(ABA_GERAL, 'CLI_CODPOR', 'Portador (1)', cxeConsTam5.Properties, True, 'POR_NOMPOR', 'Desc. Portador (1)');
  pAddColuna(ABA_GERAL, 'CLI_CODPO2', 'Portador (2)', cxeConsTam5.Properties, True, 'POR_NOMPO2', 'Desc. Portador (2)');
  pAddColuna(ABA_GERAL, 'CLI_PRORUR', 'Produtor Rural', cmbSimNao.Properties);
  pAddColuna(ABA_GERAL, 'CLI_CODREP', 'Representante', cxeConsTam3.Properties, True, 'OPE_NOMREP', 'Nome Representante');
  pAddColuna(ABA_GERAL, 'CLI_SUPREG', 'Supervisor Regional', cxeConsTam3.Properties, True, 'OPE_SUPREG', 'Nome Supervisor Regional');
  pAddColuna(ABA_GERAL, 'CLI_TABPRE', 'Tabela de Preço', cxeTabPre.Properties);
  pAddColuna(ABA_GERAL, 'CLI_TIPCLI', 'Tipo de Cliente', cxeConsTam3.Properties, fCfgSis('USATPC', varBoolean), 'TIP_DESTIP', 'Desc. Tipo de Cliente');
  pAddColuna(ABA_GERAL, 'CLI_CODVEN', 'Vendedor', cxeConsTam3.Properties, True, 'OPE_NOMVEN', 'Nome Vendedor');
  pAddColuna(ABA_GERAL, 'CLI_EMAIL_', 'E-Mail - 1');
  pAddColuna(ABA_GERAL, 'CLI_EMAIL3', 'E-Mail NFe');
  pAddColuna(ABA_GERAL, 'CLI_EMAIL2', 'E-Mail NFe 2');
  cdsParametros.First;

end;

function TfrmAltGlobCadClientes.fRetSqlSeTemValor(strCampo, strSql: String): String;
begin
  Result := '';
  if not fEmptyStr(strCampo) then
    Result := strSql;
end;

function TfrmAltGlobCadClientes.fRetSql: String;
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
    strSQL := strSQL + fRetSqlSeCampoMarcado('CNDPAG', '  ,"" AS CNDPAG' + sLineBreak + '  ,"" AS CNDPAG_ORI' + sLineBreak + '  ,"" AS DESCND' + sLineBreak + '  ,"" AS DESCND_ORI' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('CODTRA', '  ,"" AS CODTRA' + sLineBreak + '  ,"" AS CODTRA_ORI' + sLineBreak + '  ,"" AS NOMTRA' + sLineBreak + '  ,"" AS NOMTRA_ORI' + sLineBreak);
    strSQL := strSQL + fRetSqlSeCampoMarcado('TIPFRE', '  ,"" AS TIPFRE' + sLineBreak + '  ,"" AS TIPFRE_ORI' + sLineBreak);

    cdsParametros.First;
    while not cdsParametros.Eof do
    begin
      If cdsParametrosMARCADO.AsBoolean and cdsParametrosCAMPO.AsString.StartsWith('CLI_') Then
      begin
         strSQL := strSQL + '  ,' + cdsParametrosCAMPO.AsString + sLineBreak;
         strSQL := strSQL + '  ,' + cdsParametrosCAMPO.AsString +  ' AS ' + cdsParametrosCAMPO.AsString + '_ORI' + sLineBreak;
      end;

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
    if pnlForPag.Visible then
      strSQL := strSQL + fStrLocate(edtCodFpg  , FArrForma     , 'CLI_CODFPG', 'CODFPG');
    strSQL := strSQL + fStrLocate(edtCodPor  , FArrPortador  , 'CLI_CODPOR', 'CODPOR');
    strSQL := strSQL + fStrLocate(edtCodPor2 , FArrPortador2 , 'CLI_CODPO2', 'CODPO2');
    if pnlTipCli.Visible then
      strSQL := strSQL + fStrLocate(edtTipCli  , FArrTipCli    , 'CLI_TIPCLI', 'TIPCLI');
    if pnlCodCnd.Visible and (Length(FArrCndPag) > 0) then
    begin
      If Length(FArrCndPag) > 1 Then
        strSQL := strSQL + 'AND EXISTS (SELECT AUTOINCREM FROM CLICND WHERE CND_CODCLI = CLI_CODCLI AND LOCATE(CND_CODCND, :CODCND) > 0) '
      Else
        strSQL := strSQL + 'AND EXISTS (SELECT AUTOINCREM FROM CLICND WHERE CND_CODCLI = CLI_CODCLI AND CND_CODCND = :CODCND) ';
    end;

    if edtSituacao.Text <> 'T' then
      strSQL := strSQL + '  AND CLI_STATUS = :STATUS ';

    strSQL := strSQL + fRetSqlSeTemValor(fTiraCaracEspeciais(edtCep.Text), '  AND CLI_C_E_P_ = :C_E_P_ ');
    strSQL := strSQL + fRetSqlSeTemValor(edtEstado.Text, '  AND CID_ESTADO = :ESTADO ');
    strSQL := strSQL + fRetSqlSeTemValor(cmbCategoria.Text, '  AND CLI_CATEGO = :CATEGO ');
    strSQL := strSQL + fRetSqlSeTemValor(edtBairro.Text, '  AND CLI_BAIRRO LIKE :BAIRRO ');

    if pnlPeMIFF.Visible and (not fEmptyStr(edtPermFF.Text)) then
      strSQL := strSQL + '  AND CLI_PERMFF = :PERMFF ';

    if pnlPeMIFV.Visible and (not fEmptyStr(edtPermFV.Text)) then
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

function TfrmAltGlobCadClientes.fRetSqlSeCampoMarcado(strCampo, strSql: String): String;
begin
  Result := '';
  if fCampoMarcado(strCampo) then
    Result := strSql;
end;

procedure TfrmAltGlobCadClientes.pSetParamSeValor(const strParam, strValor: String; const blnLike: Boolean = False);
begin
  if not fEmptyStr(strValor) then
    FqryCadCli.ParamByName(strParam).AsString := strValor + IfThen(blnLike, '%', '');
end;

function TfrmAltGlobCadClientes.fAbreQryCadCli: Boolean;
var
  strLinha: String;
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
  if pnlForPag.Visible then
    pSetaParam(edtCodFpg.Text  , FArrForma     , strLinha, 'CODFPG', FqryCadCli);
  pSetaParam(edtCodPor.Text  , FArrPortador  , strLinha, 'CODPOR', FqryCadCli);
  pSetaParam(edtCodPor2.Text , FArrPortador2 , strLinha, 'CODPO2', FqryCadCli);
  if pnlTipCli.Visible then
    pSetaParam(edtTipCli.Text  , FArrTipCli    , strLinha, 'TIPCLI', FqryCadCli);
  if pnlCodCnd.Visible then
    pSetaParam(edtCodCnd.Text  , FArrCndPag    , strLinha, 'CODCND', FqryCadCli);

  if edtSituacao.Text <> 'T' then
    FqryCadCli.ParamByName('STATUS').AsString := edtSituacao.Text;

  pSetParamSeValor('C_E_P_', fTiraCaracEspeciais(edtCep.Text));
  pSetParamSeValor('ESTADO', edtEstado.Text);
  pSetParamSeValor('CATEGO', cmbCategoria.Text);
  pSetParamSeValor('BAIRRO', edtBairro.Text, True);
  pSetParamSeValor('CONSUM', edtConsum.Text);
  pSetParamSeValor('REVIST', edtRevist.Text);
  pSetParamSeValor('TABPRE', edtTabPre.Text);

  if pnlPeMIFF.Visible and (not fEmptyStr(edtPermFF.Text)) then
    FqryCadCli.ParamByName('PERMFF').AsString := edtPermFF.Text;

  if pnlPeMIFV.Visible and (not fEmptyStr(edtPermFV.Text)) then
    FqryCadCli.ParamByName('PERMFV').AsString := edtPermFV.Text;

  FqryCadCli.Options.SetFieldsReadOnly := False;
  FqryCadCli.CachedUpdates := True;
  FqryCadCli.Close;
  FqryCadCli.Open;

  if FqryCadCli.IsEmpty then
  begin
    fMensagem('','Não há dados para serem alterados!',['&OK']);
    Result := False;
    Exit;
  end;

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

end;

procedure TfrmAltGlobCadClientes.pAddColuna(const strAba, strCampo,
  strDescricao: String; proProperties: TcxCustomEditProperties; blnVisivel: Boolean;
  strFieldDesc, strFieldDescTitle: String);
begin
  if not blnVisivel then
    Exit;

  pIncluiParametro(strAba, strCampo, strDescricao);
  pIncluiCampo(strCampo, strDescricao, True, proProperties, strFieldDesc, strFieldDescTitle);
end;

procedure TfrmAltGlobCadClientes.pAdicionaColuna(strTitulo: String; intIndice: Integer);
Var
  cxItem: TcxCustomGridTableItem;
  intMax: Integer;
  blnVisible: Boolean;
  objCampo: TCampo;
Begin
  objCampo := FArrCampos[intIndice];

  if not Assigned(FqryCadCli.FindField(objCampo.FieldName)) then
    Exit;

  cxItem := cxvTiposAlt.FindItemByName(objCampo.FieldName);

  If Not Assigned(cxItem) Then
  Begin
    cxItem         := cxvTiposAlt.DataController.CreateItemByField(FqryCadCli.FieldByName(objCampo.FieldName));
    cxItem.Name    := objCampo.FieldName;
    cxItem.Caption := strTitulo;

    If FqryCadCli.FieldByName(objCampo.FieldName).DataType In [ftFloat, ftInteger, ftWord] Then
      TcxGridDBBandedColumn(cxItem).HeaderAlignmentHorz := taRightJustify;

    If Assigned(objCampo.Properties) Then
    Begin
      cxItem.PropertiesClassName := objCampo.Properties.ClassName;
      cxItem.Properties := objCampo.Properties;
    End;

    If objCampo.FieldName = 'CLI_NOMCLI' Then
      TcxGridDBBandedColumn(cxItem).Width := 296
    Else
      TcxGridDBBandedColumn(cxItem).Width := Self.Canvas.TextWidth(strTitulo) + 10;

    intMax := fGetMaxWidhProper(cxItem.Properties);

    If intMax > TcxGridDBBandedColumn(cxItem).Width Then
      TcxGridDBBandedColumn(cxItem).Width := intMax;

    cxItem.Options.Editing := Not objCampo.ReadOnly;

    If Pos(objCampo.FieldName, 'CLI_CODCLI-CLI_NOMCLI') = 0 Then
      TcxGridDBBandedColumn(cxItem).Position.BandIndex := 1;

    If TcxGridDBBandedColumn(cxItem).Width = 64 Then
      TcxGridDBBandedColumn(cxItem).Width := 65;

    If TcxGridDBBandedColumn(cxItem).Width < 60 Then
      TcxGridDBBandedColumn(cxItem).Width := 60;
  End;

  blnVisible := fCampoMarcado(objCampo.FieldName);
  cxItem.Visible := blnVisible;

  If blnVisible Then
    cxvTiposAlt.Bands[TcxGridDBBandedColumn(cxItem).Position.BandIndex].Width :=
      cxvTiposAlt.Bands[TcxGridDBBandedColumn(cxItem).Position.BandIndex].Width +  TcxGridDBBandedColumn(cxItem).Width;

end;

procedure TfrmAltGlobCadClientes.pAplicaMascara(const strCampo,
  strMascara: String);
var
  Field: TField;
begin
  Field := FqryCadCli.FindField(strCampo);
  if not Assigned(Field) then
    Exit;

  TFloatField(Field).DisplayFormat := strMascara;
end;

procedure TfrmAltGlobCadClientes.pCarregaCategorias;
var
  I: Integer;
begin
  pPreencheCombo(TCustomComboBox(cmbCategoria), arrCtgCli);
  cxeCategoria.Properties.Items.Clear;
  for I := 0 to Pred(cmbCategoria.Items.Count) do
    cxeCategoria.Properties.Items.Add(cmbCategoria.Items[I])
end;

procedure TfrmAltGlobCadClientes.pCarregaTabelasPreco;
var
  intCon: Integer;
begin
  FstrVrfTpr := EmptyStr;
  clbPrcVenda.Caption := EmptyStr;

  cxeTabPre.Properties.Items.Clear;
  For intCon := 1 To Length(Trim(VS_strTabVen)) Do
  Begin
    FstrVrfTpr := FstrVrfTpr + IfThen(SameText(VS_strTabVen[intCon], 'S'), IntToStr(intCon), '');
    If (VS_strTabVen[intCon] = 'S') Then
    Begin
      If intCon <> Length(Trim(VS_strTabVen)) Then
        clbPrcVenda.Caption := clbPrcVenda.Caption + ' (' + IntToStr(intCon) + ')'
      Else
        clbPrcVenda.Caption := clbPrcVenda.Caption + ' ou (' + IntToStr(intCon) + ')';

      cxeTabPre.Properties.Items.Add(IntToStr(intCon));
    End;
  End;

  clbPrcVenda.Caption := 'Preço de Venda ' + clbPrcVenda.Caption;
  clbPrcVenda.AutoSize := FALSE;
  clbPrcVenda.AutoSize := TRUE;
end;

procedure TfrmAltGlobCadClientes.pConfirma;
begin
  case nbDados.PageIndex of
  0: begin
       If Not fVerificaCampos Then
         Exit;

       fChamaTelaGravando(fMontaGridAlterados, 'Montando dados para alteração, aguarde...');
     end;
  1: begin
       If fMensagem('','Confirma alteração de dados?',['&Sim','&Não']) = 1 Then
         fChamaTelaGravando(fGravaDados, 'Gravando dados, aguarde...');
     end;
  end;
end;

Function TfrmAltGlobCadClientes.fGetMaxWidhProper(proProperties: TcxCustomEditProperties): Integer;
Begin
  Result := 0;

  If Not Assigned(proProperties) Then
    Exit;

  If proProperties.ClassType = TcxLookupComboBoxProperties Then
    Result := fGetMaxWidthLookup(TcxLookupComboBoxProperties(proProperties))

  Else If proProperties.ClassType = TcxComboBoxProperties Then
    Result := fGetMaxWidthCombo(TcxComboBoxProperties(proProperties));

  If Result > 0 Then
    Inc(Result, 10);
End;

function TfrmAltGlobCadClientes.fGetMaxWidthLookup(proProperties: TcxLookupComboBoxProperties): Integer;
var
  objDataSet: TDataSet;
  strFieldName: string;
begin
  Result := 0;

  objDataSet := proProperties.ListSource.DataSet;
  strFieldName := proProperties.ListFieldNames;

  if not Assigned(objDataSet.FindField(strFieldName)) then
  begin
    if proProperties.ListColumns.Count = 0 then
      exit;

    strFieldName := proProperties.ListColumns[0].FieldName;
    if not Assigned(objDataSet.FindField(strFieldName)) then
      exit;
  end;

  objDataSet.First;
  While Not objDataSet.Eof Do
  Begin
    If Self.Canvas.TextWidth(objDataSet.FieldByName(strFieldName).AsString) > Result Then
      Result := Self.Canvas.TextWidth(objDataSet.FieldByName(strFieldName).AsString);
    objDataSet.Next;
  End;
end;

function TfrmAltGlobCadClientes.fGetMaxWidthCombo(proProperties: TcxComboBoxProperties): Integer;
var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 0 To proProperties.Items.Count - 1 Do
    If Self.Canvas.TextWidth(proProperties.Items[intContador]) > Result Then
      Result := Self.Canvas.TextWidth(proProperties.Items[intContador]);
end;

function TfrmAltGlobCadClientes.fGravaDados(cxProgresso: TcxProgressBar): Boolean;
begin
  Result := False;
  try
    pInfoStatusGravacao(cxProgresso, 'Validando campos, aguarde...');

    fValidaLimiteCredito;
    fValidaPortador1;
    fValidaPortador2;
    fValidaRepresentante;
    fValidaTabelaPreco;
    fValidaTipoCliente;
    fValidaVendedor;

    pVerificaAlteracoes(cxProgresso);
    if fPersisteDados(cxProgresso) then
    begin
      fMensagem('','Dados alterados com sucesso!',['&OK']);
      pLimpaTela;
    end;
  except
    on E: ELiberacaoNãoRealizada do
    begin
      fMensagem('ATENÇÃO!', E.Message, ['&Ok']);
      Exit;
    end;
  end;


  Result := True;
end;

Procedure TfrmAltGlobCadClientes.pCriaCdsSimNao;
Begin
  FcdsSimNao := fCriaClientDataset(
    'SELECT "S" AS VALCAM, "Sim" AS DESCAM ' +
    'UNION ' +
    'SELECT "N" AS VALCAM, "Não" AS DESCAM', Self);
  FdtsSimNao := TDataSource.Create(Self);
  FdtsSimNao.DataSet := FcdsSimNao;

  TcxLookupComboBoxProperties(cmbSimNao.Properties).ListSource := FdtsSimNao;
End;

Procedure TfrmAltGlobCadClientes.pCriaCdsBolImp;
Begin
  FcdsBolImp := fCriaClientDataset(
    'SELECT "E" AS VALCAM, "Empresa" AS DESCAM ' +
    'UNION ' +
    'SELECT "B" AS VALCAM, "Banco" AS DESCAM', Self);
  FdtsBolImp := TDataSource.Create(Self);
  FdtsBolImp.DataSet := FcdsBolImp;

  TcxLookupComboBoxProperties(cxeBolImp.Properties).ListSource := FdtsBolImp;
End;

Procedure TfrmAltGlobCadClientes.pCriaCdsIndCom;
Begin
  FcdsIndCom := fCriaClientDataset(
    'SELECT "I" AS VALCAM, "Industrialização" AS DESCAM ' +
    'UNION ' +
    'SELECT "C" AS VALCAM, "Comercialização" AS DESCAM', Self);
  FdtsIndCom := TDataSource.Create(Self);
  FdtsIndCom.DataSet := FcdsIndCom;

  TcxLookupComboBoxProperties(cxeIndCom.Properties).ListSource := FdtsIndCom;
End;

Procedure TfrmAltGlobCadClientes.pCriaCdsSitIpi;
var
  i: Integer;
  strSQL: String;
Begin
  strSQL := '';
  For i := 0 To Length(arr_SITUACAOTRIBUTARIAIPI)-1 do
  begin
    strSQL := strSQL + 'SELECT "' + arr_SITUACAOTRIBUTARIAIPI[i][0] + '" AS VALCAM, "' + arr_SITUACAOTRIBUTARIAIPI[i][0]+' - '+arr_SITUACAOTRIBUTARIAIPI[i][1] + '" AS DESCAM ';
    if I <> Length(arr_SITUACAOTRIBUTARIAIPI)-1 then
      strSQL := strSQL + 'UNION ';
  end;

  FcdsSitIpi := fCriaClientDataset(strSQL, Self);
  FdtsSitIpi := TDataSource.Create(Self);
  FdtsSitIpi.DataSet := FcdsSitIpi;

  TcxLookupComboBoxProperties(cxeSitIpi.Properties).ListSource := FdtsSitIpi;
End;

Procedure TfrmAltGlobCadClientes.pCriaCdsSitP_C;
var
  i: Integer;
  strSQL: String;
Begin
  strSQL := '';
  For i := 0 To Length(arr_SITUACAOTRIBUTARIAPISCOFINS)-1 do
  begin
    strSQL := strSQL + 'SELECT "' + arr_SITUACAOTRIBUTARIAPISCOFINS[i][0] + '" AS VALCAM, "' + arr_SITUACAOTRIBUTARIAIPI[i][0]+' - '+arr_SITUACAOTRIBUTARIAPISCOFINS[i][1] + '" AS DESCAM ';
    if I <> Length(arr_SITUACAOTRIBUTARIAPISCOFINS)-1 then
      strSQL := strSQL + 'UNION ';
  end;

  FcdsSitP_C := fCriaClientDataset(strSQL, Self);
  FdtsSitP_C := TDataSource.Create(Self);
  FdtsSitP_C.DataSet := FcdsSitP_C;

  TcxLookupComboBoxProperties(cxeSitP_C.Properties).ListSource := FdtsSitP_C;
End;

Procedure TfrmAltGlobCadClientes.pCriaCdsRegTri;
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

Procedure TfrmAltGlobCadClientes.pCriaCdsTFTNES;
Begin
  FcdsTFTNES:= fCriaClientDataset(
    'SELECT "V" AS VALCAM, "Valor" AS DESCAM ' +
    'UNION ' +
    'SELECT "Q" AS VALCAM, "Quantidade" AS DESCAM', Self);
  FdtsTFTNES:= TDataSource.Create(Self);
  FdtsTFTNES.DataSet := FcdsTFTNES;

  TcxLookupComboBoxProperties(cxeTFTNES.Properties).ListSource := FdtsTFTNES;
End;

procedure TfrmAltGlobCadClientes.pCriaCdsTipFre;
var
  intTipFre: Integer;
  strSQL: String;
Begin
  strSQL := '';
  for intTipFre := Low(TiposFrete) to High(TiposFrete) do
  begin
    strSQL := strSQL + 'SELECT "' + TiposFrete[intTipFre].ToString + '" AS VALCAM, "' + fDescricaoFrete(TiposFrete[intTipFre].ToString) + '" AS DESCAM ';
    if intTipFre <> Length(TiposFrete)-1 then
      strSQL := strSQL + 'UNION ';
  end;

  FcdsTipFre := fCriaClientDataset(strSQL, Self);
  FdtsTipFre := TDataSource.Create(Self);
  FdtsTipFre.DataSet := FcdsTipFre;

  TcxLookupComboBoxProperties(cxeTipFre.Properties).ListSource := FdtsTipFre;
end;

Function TfrmAltGlobCadClientes.fValidaValor(strValor: String): Boolean;
var
  strFieldName: String;
Begin
  Result := True;

  strFieldName := TcxGridDBBandedColumn(cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName;
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

function TfrmAltGlobCadClientes.fValidaLimCre(strValor: String): Boolean;
var
  strCodCli: String;
begin
  Result := True;

  strCodCli := cxvTiposAlt.DataController.Values[cxvTiposAlt.DataController.FocusedRecordIndex, cxvTiposAlt.GetColumnByFieldName('CLI_CODCLI').Index];

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
          (fStrToFloat(strValor) > fLimCredOperador('', strCodCli)) Then
  Begin
    if fCfgSis('LMCRTR', VarString) = '1' then
    begin
      fMensagem('ATENÇÃO!', 'O valor do limite de crédito informado ultrapassa o limite permitido para o operador!', ['&Ok']);
      Result := False;
    end;
  End;
end;

function TfrmAltGlobCadClientes.fValidaCodPor(strValor: String): Boolean;
begin
  Result := True;

  If not (fEmptyStr(strValor)) Then
  Begin
    If fEmptyStr(fRetNomPortador(strValor)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!', ['&Ok']);
      Result := False;
    End

    {*REQ*145940**********RP*}
    Else If Not fEmpresaTemAcessoPortador(strValor) Then
    Begin
      fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
      Result := False;
    End
  End;
end;

function TfrmAltGlobCadClientes.fValidaCodPo2(strValor: String): Boolean;
begin
  Result := True;

  If not (fEmptyStr(strValor)) Then
  Begin
    If fEmptyStr(fRetNomPortador(strValor)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!', ['&Ok']);
      Result := False;
    End

    {*REQ*145940**********RP*}
    Else If Not fEmpresaTemAcessoPortador(strValor) Then
    Begin
      fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
      Result := False;
    End
  End;
end;

function TfrmAltGlobCadClientes.fValidaCodRep(strValor: String): Boolean;
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

function TfrmAltGlobCadClientes.fValidaTabPre(strValor: String): Boolean;
begin
  Result := True;

  If Not fEmptyStr(strValor) Then
  Begin

    If Pos( strValor, FstrVrfTpr ) <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'A Tabela de ' + clbPrcVenda.Caption + '!', ['&Ok']);
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

function TfrmAltGlobCadClientes.fValidaTipCli(strValor: String): Boolean;
begin
  Result := True;

  If (fEmptyStr(strValor)) Then
  Begin
    If (Not fCfgSis('TPCBRC', varBoolean)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O tipo de cliente deve ser preenchido!', ['&Ok']);
      Result := False;
    End;
  End
  Else
  Begin
    If (fEmptyStr(fRetDescTipoCli(strValor))) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse tipo de cliente não está cadastrado!', ['&Ok']);
      Result := False;
    End
  End;
end;

function TfrmAltGlobCadClientes.fValidaCodVen(strValor: String): Boolean;
begin
  Result := True;

  If Not fEmptyStr(strValor) Then
  Begin
    If fEmptyStr(fRetNomeOperador(strValor)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse vendedor não está cadastrado!', ['&Ok']);
      Result := False;
    End
  End
  Else
  Begin
    fMensagem('ATENÇÃO!', 'O código do vendedor deve ser preenchido!', ['&Ok']);
    Result := False;
  End;
end;

procedure TfrmAltGlobCadClientes.pVerificaAlteracoes(cxProgresso: TcxProgressBar);
var
  I: Integer;
  FieldOri: TField;
begin
  pInfoStatusGravacao(cxProgresso, 'Verificando registros alterados, aguarde...', FqryCadCli.RecordCount);

  FqryCadCli.DisableControls;
  FqryCadCli.First;
  try

    while not FqryCadCli.Eof do
    begin
      for I := 0 to Pred(FqryCadCli.Fields.Count) do
      begin
        if FqryCadCli.Fields[I].FieldName.EndsWith('_ORI') then
          Continue;

        FieldOri := FqryCadCli.FindField(FqryCadCli.Fields[I].FieldName + '_ORI');
        if not Assigned(FieldOri) then
          Continue;

        if FieldOri.Value <> FqryCadCli.Fields[I].Value then
        begin
          FqryCadCli.Edit;
          FqryCadCli.FieldByName('ALTERADO').AsString := 'S';
          FqryCadCli.Post;
          Break;
        end;
      end;

      FqryCadCli.Next;
      pStepStatusGravacao(cxProgresso, 'Verificando registros alterados, aguarde...');
    end;
  finally
    FqryCadCli.First;
    FqryCadCli.EnableControls;
  end;
end;

function TfrmAltGlobCadClientes.fPersisteDados(cxProgresso: TcxProgressBar): Boolean;
var
  qryCadCli: TUniQuery;
  I: Integer;
  FieldOri,
  FieldCadCli: TField;
begin
  FqryCadCli.DisableControls;
  FqryCadCli.Filtered := False;
  FqryCadCli.Filter := 'ALTERADO = ''S''';
  FqryCadCli.Filtered := True;
  FqryCadCli.First;
  pInfoStatusGravacao(cxProgresso, 'Gravando, aguarde...', FqryCadCli.RecordCount);
  try

    qryCadCli := fCriaQuery;
    qryCadCli.SQL.Text := 'SELECT * FROM CADCLI WHERE CLI_CODCLI = :CODCLI';
    try
      while not FqryCadCli.Eof do
      begin
        qryCadCli.Close;
        qryCadCli.ParamByName('CODCLI').AsString := FqryCadCli.FieldByName('CLI_CODCLI').AsString;
        qryCadCli.Open;

        qryCadCli.Edit;

        for I := 0 to Pred(FqryCadCli.Fields.Count) do
        begin
          if FqryCadCli.Fields[I].FieldName.EndsWith('_ORI') then
            Continue;

          if not FqryCadCli.Fields[I].FieldName.StartsWith('CLI_') then
            Continue;

          FieldOri := FqryCadCli.FindField(FqryCadCli.Fields[I].FieldName + '_ORI');
          if not Assigned(FieldOri) then
            Continue;

          if FieldOri.Value <> FqryCadCli.Fields[I].Value then
          begin
            FieldCadCli := qryCadCli.FindField(FqryCadCli.Fields[I].FieldName);
            if not Assigned(FieldCadCli) then
              Continue;

            FieldCadCli.Value := FqryCadCli.Fields[I].Value;

            if fEmptyStr(FieldCadCli.Value) and fTemCampoDesc(FieldCadCli.FieldName) then
              FieldCadCli.Clear;
          end;
        end;

        objLogAltCadCli.pLogAdd('CADCLI', ['AUTOINCREM'], 'CLI_CODCLI = ' + QuotedStr(FqryCadCli.FieldByName('CLI_CODCLI').AsString), pSetaDisplayLabelCadCli);

        qryCadCli.Post;

        fPersisteCndPag;
        fPersisteTipFre;
        fPersisteCodTra;
        fPersisteCodReg;

        FqryCadCli.Next;
        pStepStatusGravacao(cxProgresso, 'Gravando, aguarde...');
      end;
    finally
      FreeAndNil(qryCadCli);
    end;

    Result := True;

    objLogAltCadCli.pProcessarLogs;
  finally
    FqryCadCli.Filtered := False;
    FqryCadCli.First;
    FqryCadCli.EnableControls;
  end;
end;

procedure TfrmAltGlobCadClientes.pPesqCanalAcesso(qryDados: TUniQuery;
  Var Key: Char; Var arrSelecao: TConsultasArray; Edit: TcxCustomEdit);
begin
  If fPesqCanalAcesso(Self, Nil, Nil, qryDados, Key, arrSelecao) And
     (Not fEmptyStr(qryDados.FieldByName('CAC_CODCAC').AsString)) Then
    pSalvaDescricao(qryDados.FieldByName('CAC_CODCAC').AsString, Edit, Key);
end;

procedure TfrmAltGlobCadClientes.pPesqRedeLojas(qryDados: TUniQuery;
  Var Key: Char; Var arrSelecao: TConsultasArray; Edit: TcxCustomEdit);
begin
  If fPesqRedeLojas(Self, Nil, Nil, qryDados, Key, arrSelecao) And
     (Not fEmptyStr(qryDados.FieldByName('RED_CODRED').AsString)) Then
    pSalvaDescricao(qryDados.FieldByName('RED_CODRED').AsString, Edit, Key);
end;

procedure TfrmAltGlobCadClientes.pPesqRegiao(qryDados: TUniQuery;
  Var Key: Char; Var arrSelecao: TConsultasArray; Edit: TcxCustomEdit);
begin
  If fPesqRegiao(Self, Nil, Nil, qryDados, Key, arrSelecao) And
     (Not fEmptyStr(qryDados.FieldByName('REG_CODREG').AsString)) Then
    pSalvaDescricao(qryDados.FieldByName('REG_CODREG').AsString, Edit, Key);
end;

procedure TfrmAltGlobCadClientes.pPesqSubRegiao(qryDados: TUniQuery;
  Var Key: Char; Var arrSelecao: TConsultasArray; Edit: TcxCustomEdit);
begin
  If fPesqSubRegiao(Self, Nil, Nil, qryDados, Key, arrSelecao) And
     (Not fEmptyStr(qryDados.FieldByName('SUB_CODSUB').AsString)) Then
    pSalvaDescricao(qryDados.FieldByName('SUB_CODSUB').AsString, Edit, Key);
end;

procedure TfrmAltGlobCadClientes.pPesqAtividade(qryDados: TUniQuery;
  Var Key: Char; Var arrSelecao: TConsultasArray; Edit: TcxCustomEdit);
begin
  If fPesqAtividade(Self, Nil, Nil, qryDados, Key, arrSelecao) And
     (Not fEmptyStr(qryDados.FieldByName('ATI_CODATI').AsString)) Then
    pSalvaDescricao(qryDados.FieldByName('ATI_CODATI').AsString, Edit, Key);
end;

procedure TfrmAltGlobCadClientes.pPesqFormaPgto(qryDados: TUniQuery;
  Var Key: Char; Var arrSelecao: TConsultasArray; Edit: TcxCustomEdit);
begin
  If fPesqFormaPgto(conFpgSimples, Self, Nil, Nil, qryDados, Key, arrSelecao) And
     (Not fEmptyStr(qryDados.FieldByName('FPG_CODIGO').AsString)) Then
    pSalvaDescricao(qryDados.FieldByName('FPG_CODIGO').AsString, Edit, Key);
end;

procedure TfrmAltGlobCadClientes.pPesqPortador(qryDados: TUniQuery;
  Var Key: Char; Var arrSelecao: TConsultasArray; Edit: TcxCustomEdit);
begin
  If fPesqPortador(conSimples, Self, Nil, Nil, qryDados, Key, arrSelecao) And
     (Not fEmptyStr(qryDados.FieldByName('POR_CODPOR').AsString)) Then
    pSalvaDescricao(qryDados.FieldByName('POR_CODPOR').AsString, Edit, Key);
end;

procedure TfrmAltGlobCadClientes.pPesqOperador(qryDados: TUniQuery;
  Var Key: Char; Var arrSelecao: TConsultasArray; Edit: TcxCustomEdit);
begin
  If fPesqOperador(Self, Nil, Nil, qryDados, Key, arrSelecao) And
    (Not fEmptyStr(qryDados.FieldByName('OPE_CODOPE').AsString)) Then
    pSalvaDescricao(qryDados.FieldByName('OPE_CODOPE').AsString, Edit, Key);
end;

procedure TfrmAltGlobCadClientes.pPesqTipoCliente(qryDados: TUniQuery;
  Var Key: Char; Var arrSelecao: TConsultasArray; Edit: TcxCustomEdit);
begin
  If fPesqTipoCliente(Self, Nil, Nil, qryDados, Key, arrSelecao) And
     (Not fEmptyStr(qryDados.FieldByName('TIP_CODTIP').AsString)) Then
    pSalvaDescricao(qryDados.FieldByName('TIP_CODTIP').AsString, Edit, Key);
end;

procedure TfrmAltGlobCadClientes.pPesqEnquadramentoIPI(qryDados: TUniQuery;
  Var Key: Char; Var arrSelecao: TConsultasArray; Edit: TcxCustomEdit);
begin
  If fPesqEnquadramentoIPI(Self, Nil, Nil, qryDados, Key, arrSelecao) And
     (Not fEmptyStr(qryDados.FieldByName('EQI_CODIGO').AsString)) Then
    pSalvaDescricao(qryDados.FieldByName('EQI_CODIGO').AsString, Edit, Key);
end;

procedure TfrmAltGlobCadClientes.pPesqCondicoesPgto(qryDados: TUniQuery;
  Var Key: Char; Var arrSelecao: TConsultasArray; Edit: TcxCustomEdit);
begin
  If fPesqCondicoesPgto(Self, Nil, Nil, qryDados, Key, arrSelecao) And
     (Not fEmptyStr(qryDados.FieldByName('CND_CODIGO').AsString)) Then
    pSalvaDescricao(qryDados.FieldByName('CND_CODIGO').AsString, Edit, Key);
end;

procedure TfrmAltGlobCadClientes.pPesqTransportadora(qryDados: TUniQuery;
  Var Key: Char; Var arrSelecao: TConsultasArray; Edit: TcxCustomEdit);
begin
  If fPesqTransportadora(conTraSimples, Self, Nil, Nil, qryDados, Key, arrSelecao) And
     (Not fEmptyStr(qryDados.FieldByName('TRA_CODTRA').AsString)) Then
    pSalvaDescricao(qryDados.FieldByName('TRA_CODTRA').AsString, Edit, Key);
end;

function TfrmAltGlobCadClientes.fPersisteCndPag: Boolean;
begin
  if fCampoMarcado('CNDPAG') then
  begin
    if FqryCadCli.FieldByName('CNDPAG').Value <>  FqryCadCli.FieldByName('CNDPAG_ORI').Value then
    begin
      if rdbIncluir.Checked then
        fIncluirCliCnd(
          FqryCadCli.FieldByName('CLI_CODCLI').AsString,
          FqryCadCli.FieldByName('CNDPAG').Value)
      else
      if rdgExcluir.Checked then
      begin
        fExecutaSQL(
          ' DELETE FROM CLICND ' +
          ' WHERE CND_CODCLI = ' + FqryCadCli.FieldByName('CLI_CODCLI').AsString.QuotedString +
          '   AND CND_CODCND = ' + FqryCadCli.FieldByName('CNDPAG').AsString.QuotedString);
      end;
    end;
  end;

  Result := True;
end;

function TfrmAltGlobCadClientes.fIncluirCliCnd(const strCodCli, strCodCnd: String): Boolean;
var
  qryCliCnd: TUniQuery;
begin
  qryCliCnd := fCriaQuery;
  try
    qryCliCnd.SQL.Add('SELECT * FROM CLICND');
    qryCliCnd.SQL.Add('WHERE CND_CODCLI = :CODCLI');
    qryCliCnd.SQL.Add('  AND CND_CODCND = :CODCND');
    qryCliCnd.ParamByName('CODCLI').AsString := FqryCadCli.FieldByName('CLI_CODCLI').AsString;
    qryCliCnd.ParamByName('CODCND').AsString := FqryCadCli.FieldByName('CNDPAG').AsString;
    qryCliCnd.Open;

    if qryCliCnd.IsEmpty then
    begin
      qryCliCnd.Insert;
      qryCliCnd.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CLICND', VS_strCodEmp);
      qryCliCnd.FieldByName('CND_CODCLI').AsString   := FqryCadCli.FieldByName('CLI_CODCLI').AsString;
      qryCliCnd.FieldByName('CND_CODCND').Value      := FqryCadCli.FieldByName('CNDPAG').Value;
      qryCliCnd.FieldByName('CND_SUGEST').AsString   := 'N';
      qryCliCnd.FieldByName('CND_ULTALT').AsDateTime := fNow();
      qryCliCnd.Post;
    end;

    Result := True;
  finally
    FreeAndNil(qryCliCnd);
  end;
end;

function TfrmAltGlobCadClientes.fPersisteTipFre: Boolean;
begin
  if fCampoMarcado('TIPFRE') then
  begin
    if FqryCadCli.FieldByName('TIPFRE').Value <>  FqryCadCli.FieldByName('TIPFRE_ORI').Value then
    begin
      fExecutaSQL(
        ' UPDATE ENTCLI ' +
        ' SET ETC_TIPFRE = ' + FqryCadCli.FieldByName('TIPFRE').AsString.QuotedString +
        ' WHERE ETC_CODCLI = ' + FqryCadCli.FieldByName('CLI_CODCLI').AsString.QuotedString);
    end;
  end;

  Result := True;
end;

function TfrmAltGlobCadClientes.fPersisteCodReg: Boolean;
begin
  if fCampoMarcado('CLI_CODREG') then
  begin
    if FqryCadCli.FieldByName('CLI_CODREG').Value <>  FqryCadCli.FieldByName('CLI_CODREG_ORI').Value then
    begin
      fExecutaSQL(
        ' UPDATE ENTCLI ' +
        ' SET ETC_CODREG = ' + FqryCadCli.FieldByName('CLI_CODREG').AsString.QuotedString +
        ' WHERE ETC_CODCLI = ' + FqryCadCli.FieldByName('CLI_CODCLI').AsString.QuotedString);
    end;
  end;

  Result := True;
end;

function TfrmAltGlobCadClientes.fPersisteCodTra: Boolean;
begin
  if fCampoMarcado('CODTRA') then
  begin
    if FqryCadCli.FieldByName('CODTRA').Value <>  FqryCadCli.FieldByName('CODTRA_ORI').Value then
    begin
      fExecutaSQL(
        ' UPDATE ENTCLI ' +
        ' SET ETC_CODTRA = ' + FqryCadCli.FieldByName('CODTRA').AsString.QuotedString +
        ' WHERE ETC_CODCLI = ' + FqryCadCli.FieldByName('CLI_CODCLI').AsString.QuotedString);
    end;
  end;

  Result := True;
end;

function fRetDescTipoCli(strCodTip: String): String;
begin
  Result := untFuncoesSimples.fRetDescTipoCli(strCodTip)
end;

end.

