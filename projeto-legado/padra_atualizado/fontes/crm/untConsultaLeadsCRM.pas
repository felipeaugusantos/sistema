unit untConsultaLeadsCRM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  Mask, MaskEditFocus, EditFocus, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, strUtils,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, UniClientDataSet, UniDataSetProvider,Uni,
  ComboBoxFocus, BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters,
  cxNavigator, MemDS, DBAccess, Provider, Datasnap.DBClient, frxClass,
  frxExportCSVTestabilidade, cxGridCitel, untTypesSistema,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxScreenTip,
  cxSplitter, dxCustomHint, cxHint, System.ImageList, Vcl.ImgList, untZClient,
  cxButtonEdit, cxImage, Vcl.Samples.Spin, Vcl.DBCtrls, cxVGrid,
  cxDBVGrid, cxInplaceContainer, cxImageComboBox, dxBarBuiltInMenu, cxPC, dxColorEdit,
  untHelperCitel, untCadLeads, ShellAPI, dxCore, dxCoreClasses, dxHashUtils, dxSpreadSheetCore,
  dxSpreadSheetCoreHistory, dxSpreadSheetConditionalFormatting,
  dxSpreadSheetConditionalFormattingRules, dxSpreadSheetClasses,
  dxSpreadSheetContainers, dxSpreadSheetFormulas, dxSpreadSheetHyperlinks,
  dxSpreadSheetFunctions, dxSpreadSheetGraphics, dxSpreadSheetPrinting,
  dxSpreadSheetTypes, dxSpreadSheetUtils, dxSpreadSheet,
  cxGridExportLink, untConfiguraConsulta, untCfgTel, cxCheckBox, cxContainer,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCheckComboBox;

type
  TcxPainterAccess = class(TcxGridTableDataCellPainter);
  TcxViewInfoAcess = class(TcxGridTableDataCellViewInfo);
  TTipoVisualizacaoGrid = (tpExpandido, tpRecolhido);

  TfrmConsultaLeadsCRM = class(TfrmPaiSimples)
    pnlGeral: TPanel;
    pnlGrid: TPanel;
    pnlFiltros: TPanel;
    lblCodCli: TLabel;
    lblDtaIni: TLabel;
    lblAteDtaIniObr: TLabel;
    edtCodCli: TEditFocus;
    mskDtaIni: TMaskEditFocus;
    mskDtaFim: TMaskEditFocus;
    edtNomCli: TEditFocus;
    dbgLeadsDBTableView1: TcxGridDBTableViewCitel;
    dbgLeadsLevel1: TcxGridLevel;
    dbgLeads: TcxGridCitel;
    dtsLeads: TDataSource;
    cdsLeads: TUniClientDataSet;
    qryLeads: TUniQuery;
    dspLeads: TUniDataSetProvider;
    edtCodPrj: TEditFocus;
    edtDesCodPrj: TEditFocus;
    lblCodPrj: TLabel;
    btnCarrega: TBitBtnLocked;
    lblCodVen: TLabel;
    edtNomVen: TEditFocus;
    lblCodVenExt: TLabel;
    edtCodVenExt: TEditFocus;
    edtNomVenExt: TEditFocus;
    edtDesFasObr: TEditFocus;
    lblFasObr: TLabel;
    edtFasObr: TEditFocus;
    imgButton: TImageList;
    cxHint: TcxHintStyleController;
    splDivisor: TcxSplitter;
    lblDtaPrevOrc: TLabel;
    mskDtaPrevOrc: TMaskEditFocus;
    lblAteDtaPrvOrc: TLabel;
    mskDtaFimPrevOrc: TMaskEditFocus;
    pnlBotoesAgregados: TFlowPanel;
    pnlBotoesInferiores: TPanel;
    btnConfirma: TBitBtnLocked;
    Splitter1: TSplitter;
    lblCodCat: TLabel;
    edtDesCat: TEditFocus;
    lblDtaIniFin: TLabel;
    lblAteDtaIniFin: TLabel;
    mskDtaIniFin: TMaskEditFocus;
    mskDtaFimFin: TMaskEditFocus;
    edtNumDoc: TEditFocus;
    lblNumDoc: TLabel;
    lblCodOper: TLabel;
    edtCodOper: TEditFocus;
    edtDesOper: TEditFocus;
    btnCancelar: TBitBtnLocked;
    cdsLeadsLDG_NUMDOC: TStringField;
    cdsLeadsCLI_NOMCLI: TStringField;
    dbgLeadsDBTableView1LDG_NUMDOC: TcxGridDBColumn;
    dbgLeadsDBTableView1CLI_NOMCLI: TcxGridDBColumn;
    cdsLeadsFAS_OBR: TStringField;
    dbgLeadsDBTableView1FAS_OBR: TcxGridDBColumn;
    cdsLeadsLDG_NOMPRO: TStringField;
    cdsLeadsNOM_VEN: TStringField;
    cdsLeadsNOM_EXT: TStringField;
    cdsLeadsLDG_TOTVPR: TCurrencyField;
    cdsLeadsSTATUS: TStringField;
    cdsLeadsOPE_FIN: TStringField;
    cdsLeadsNOM_INS: TStringField;
    dbgLeadsDBTableView1LDG_NOMPRO: TcxGridDBColumn;
    dbgLeadsDBTableView1NOM_VEN: TcxGridDBColumn;
    dbgLeadsDBTableView1NOM_EXT: TcxGridDBColumn;
    dbgLeadsDBTableView1LDG_INIOBR: TcxGridDBColumn;
    dbgLeadsDBTableView1LDG_PREORC: TcxGridDBColumn;
    dbgLeadsDBTableView1LDG_TOTVPR: TcxGridDBColumn;
    dbgLeadsDBTableView1STATUS: TcxGridDBColumn;
    dbgLeadsDBTableView1LDG_DTAFIN: TcxGridDBColumn;
    dbgLeadsDBTableView1OPE_FIN: TcxGridDBColumn;
    dbgLeadsDBTableView1NOM_INS: TcxGridDBColumn;
    edtCodIns: TEditFocus;
    lblCodIns: TLabel;
    edtNomIns: TEditFocus;
    cdsLeadsLDG_STATUS: TStringField;
    cdsLeadsLDG_PREORC: TDateField;
    cdsLeadsCODCLI: TStringField;
    cdsLeadsAUTOINCREM: TStringField;
    edtDesNumDoc: TEditFocus;
    cdsLeadsLDG_INIOBR: TDateField;
    cdsLeadsLDG_DTAFIN: TDateField;
    edtCodVen: TEditFocus;
    edtCodCat: TEditFocus;
    cdsLeadsCAT_DESCRI: TStringField;
    dbgLeadsDBTableView1CAT_DESCRI: TcxGridDBColumn;
    btnAbrirCadLead: TBitBtnLocked;
    Label1: TLabel;
    mskDtaCadIni: TMaskEditFocus;
    Label2: TLabel;
    mskDtaCadFim: TMaskEditFocus;
    Label3: TLabel;
    cbContemLinGrp: TComboBoxFocus;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    cbContemReg: TComboBoxFocus;
    cbContemMarca: TComboBoxFocus;
    edtCodPVe: TEditFocus;
    cdsLeadsPREVND: TStringField;
    dbgLeadsDBTableView1PREVND: TcxGridDBColumn;
    cdsLeadsQTDORC: TLargeintField;
    dbgLeadsDBTableView1QTDORC: TcxGridDBColumn;
    cdsLeadsQTDOCO: TLargeintField;
    dbgLeadsDBTableView1QTDOCO: TcxGridDBColumn;
    pnlItens: TPanel;
    pnlRodapeItens: TPanel;
    lblPrevOrcLead: TLabel;
    cbExibirLinhaGrupo: TCheckBox;
    btnExibirLinhaGrupo: TBitBtnLocked;
    qryItens: TUniQuery;
    dspItens: TUniDataSetProvider;
    dtsItens: TDataSource;
    cdsItens: TUniClientDataSet;
    cdsItensLDD_LINGRU: TStringField;
    cdsItensLDD_VALPRE: TCurrencyField;
    cdsItensLDD_KAMFOR: TStringField;
    cdsItensLDD_PREVEN: TStringField;
    cdsItensLDD_MOEDA_: TStringField;
    cdsItensLDD_REGIST: TStringField;
    cdsItensLDD_DESCON: TStringField;
    cdsItensLDD_NUMREG: TStringField;
    cdsItensLDD_AUTDES: TStringField;
    cdsItensLDD_KAFORN: TStringField;
    cdsItensLDD_CODMAR: TStringField;
    cdsItensLDD_SEQGER: TStringField;
    btnExportaCSV: TBitBtnLocked;
    cdsItensLDD_OBSERV: TMemoField;
    SaveDialog1: TSaveDialog;
    cxGridItens: TcxGridCitel;
    cxGridItensView: TcxGridDBTableViewCitel;
    cxGridLevel1: TcxGridLevel;
    cxGridItensViewLDD_LINGRU: TcxGridDBColumn;
    cxGridItensViewLDD_KAMFOR: TcxGridDBColumn;
    cxGridItensViewLDD_PREVEN: TcxGridDBColumn;
    cxGridItensViewLDD_MOEDA_: TcxGridDBColumn;
    cxGridItensViewLDD_REGIST: TcxGridDBColumn;
    cxGridItensViewLDD_DESCON: TcxGridDBColumn;
    cxGridItensViewLDD_NUMREG: TcxGridDBColumn;
    cxGridItensViewLDD_CODMAR: TcxGridDBColumn;
    cdsItensDESGRU: TStringField;
    cxGridItensViewDESGRU: TcxGridDBColumn;
    cdsItensNOMPVE: TStringField;
    cxGridItensViewNOMPVE: TcxGridDBColumn;
    cdsItensDESMAR: TStringField;
    cxGridItensViewDESMAR: TcxGridDBColumn;
    edtTotPrev: TEditFocus;
    cxGridItensViewLDD_VALPRE: TcxGridDBColumn;
    edtNomPve: TEditFocus;
    cdsLeadsLDG_ULTALT: TDateTimeField;
    dbgLeadsDBTableView1LDG_ULTALT: TcxGridDBColumn;
    cxGridItensViewLDD_AUTDES: TcxGridDBColumn;
    cxGridItensViewLDD_OBSERV: TcxGridDBColumn;
    cdsLeadsLDG_DTACAD: TDateField;
    dbgLeadsDBTableView1LDG_DTACAD: TcxGridDBColumn;
    cdsItensTOTPREVI: TFloatField;
    cdsItensVLR_PREVIS: TAggregateField;
    btnPadrao: TBitBtnLocked;
    btnLarCol: TBitBtnLocked;
    dtsColOrd: TDataSource;
    cdsColOrd: TUniClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    IntegerField1: TIntegerField;
    StringField3: TStringField;
    cdsColOrdItens: TUniClientDataSet;
    StringField4: TStringField;
    StringField5: TStringField;
    IntegerField2: TIntegerField;
    StringField6: TStringField;
    dtsColOrdItens: TDataSource;
    btnSairBaixa: TBitBtnLocked;
    lblTotalPrevOrc: TLabel;
    edtTotPrevOrc: TEditFocus;
    edtQtdTotOrc: TEditFocus;
    lblQtdTotOrc: TLabel;
    cdsLeadsTOT_VLRORC: TAggregateField;
    cdsLeadsTOT_QTDORC: TAggregateField;
    lblStatus: TLabel;
    cbStatus: TcxCheckComboBox;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    lblMarca: TLabel;
    Label7: TLabel;
    cbOrdemExibicao: TComboBoxFocus;
    cdsLeadsQTDORC_LIS: TFloatField;
    lblLinhaGrupo: TLabel;
    edtCodGru: TEditFocus;
    edtDesGru: TEditFocus;
    shpPermissaoVEN: TShape;
    shpPermissaoVEE: TShape;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSairBaixaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cdsLeadsAfterScroll(DataSet: TDataSet);
    procedure dbgLeadsDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnCarregaClick(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenExtExit(Sender: TObject);
    procedure edtCodVenExtKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenExit(Sender: TObject);
    procedure edtFasObrKeyPress(Sender: TObject; var Key: Char);
    procedure dbgLeadsDBTableView1DblClick(Sender: TObject);
    procedure edtCodCatKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtFasObrExit(Sender: TObject);
    procedure edtCodCatExit(Sender: TObject);
    procedure edtCodPrjKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOperKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOperExit(Sender: TObject);
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodInsKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodInsExit(Sender: TObject);
    procedure pSetNumLead(strNumLead: String);
    procedure edtNumDocExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodPrjExit(Sender: TObject);
    procedure btnAbrirCadLeadClick(Sender: TObject);
    procedure edtCodPVeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPVeExit(Sender: TObject);
    procedure btnExibirLinhaGrupoClick(Sender: TObject);
    procedure btnExportaCSVClick(Sender: TObject);
    procedure dbgLeadsDBTableView1CellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnLarColClick(Sender: TObject);
    procedure btnPadraoClick(Sender: TObject);
    procedure dbgLeadsDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure cbContemMarcaChange(Sender: TObject);
    procedure dbgLeadsDBTableView1ColumnHeaderClick(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
    procedure edtCodGruExit(Sender: TObject);
    procedure edtCodGruKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    strValFil: String;
    strCamFil: String;
    arrCliente,
    arrVendedor,
    arrVendedorExt,
    arrFaseObra,
    arrCategoria,
    arrProjeto,
    arrDocumento,
    arrOperadorFin,
    arrInstalador,
    arrPreVnd,
    arrMarca,
    arrGrupo,
    arrStatus : TConsultasArray;

    strClientes,
    strVendedores,
    strVendedoresExt,
    strFaseObra,
    strCategoria,
    strProjeto,
    strDocumento,
    strOperadorFin,
    strInstalador,
    strCnsCodMar,
    strCnsStatus: String;

    strCodVen : String;
    strCodVenExt : String;

    FCarregando: Boolean;
    FNumLead: string;
    TamanhoPanelItensOriginal: Integer;
    FEstadoGridItens: TTipoVisualizacaoGrid;
    FCfgTela: TCfgTela;

    procedure pCarregaCliente;
    procedure pCarregaVendedor;
    procedure pCarregaVendedorExt;
    procedure pCarregaPreVenda;
    procedure pCarregaFaseObr;
    procedure pCarregaCategoria;
    procedure pCarregaProjeto;
    procedure pCarregaDocumento;
    procedure pCarregaOperaFin;
    procedure pCarregaInstalador;
    procedure pConsultaLeads;
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);
    procedure pAbrirCadastroLeads(const CodCli, Chave: string);
    procedure pHabilitaBotoesPanelInferior;
    procedure pDesabilitaBotoesPanelInferior;
    procedure pCarregaPesquisaLeads;
    procedure pCarregaItensLeads;
    procedure pExpandirGridItens;
    procedure pRecolherGridItens;
    procedure pAjustarVisualizacaoGridItens;
    procedure pPreencherTotalPrevisaoOrcamento;
    function fObtemParametroGrupo(const Indice: Integer): string;
    function fObtemParametroMarca(const Indice: Integer): string;
    function fObtemParametroRegistro(const Indice: Integer): string;
    procedure pAdicionaClausulaWherePreVenda;
    procedure pAjustaColunas(cxConsultaView: TcxGridDBTableView;
      cdsConsulta: TUniClientDataSet);
    procedure pValidaCamposSemMensagem;
    procedure pCarregarTotais;
    procedure pAdicionaClausulaWhereMarca;
    procedure pCarregarMarca;
    procedure pStatusMarcados;
    procedure pAdicionarFiltroStatus;
    procedure pOrdenaConsulta;
    procedure pOrdenaGrid;
    procedure pCarregarGrupo;
    procedure pAdicionaClausulaWhereLinhaGrupo;
    procedure pConfiguraPermissaoCamposVendedor;
  protected

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    strCodCli,
    strNumDoc: string;
    pChamaOrcamento: TProcedureChamaOrcamento;
  End;

implementation

uses untFuncoesSimples, untConsultas, untGravando, untFuncoesConsulta,
  untFuncoesGenerica, untFuncoesCRM, untFuncoesAuxiliares, untILeads, untLeads,
  untTypesCRM;

{$R *.dfm}

{ TfrmConsultaLeadsCRM }

procedure TfrmConsultaLeadsCRM.FormCreate(Sender: TObject);
var
  statusAux: TStatusLead;
  ordCns: TOrdCnsLead;
Begin
  inherited;

  strCodVen := '';
  strCodVenExt := '';

  blnConfirma := False;
  FCarregando := False;

  cdsLeads.CreateDataSet;
  cdsLeads.OnFilterRecord := pFilterRecord;

  cbStatus.Clear;
  For statusAux := Low(TStatusLead) to High(TStatusLead) Do
  Begin
    cbStatus.Properties.Items.AddCheckItem(descricaoStatusLead[statusAux]);
  End;

  cbOrdemExibicao.Clear;
  For ordCns := Low(TOrdCnsLead) to High(TOrdCnsLead) Do
  Begin
    cbOrdemExibicao.Items.Add(arrOrdCnsLead[ordCns]);
  End;

  TamanhoPanelItensOriginal := pnlItens.Height;

  FCfgTela:= TCfgTelaConsultaLeadCRM.Create;
  cdsColOrd.CreateDataSet;
  cdsColOrd.IndexFieldNames := 'ORDCAM';
  cdsColOrdItens.CreateDataSet;
  cdsColOrdItens.IndexFieldNames := 'ORDCAM';
  FCfgTela.pCarregaOrd(cdsColOrd, dbgLeads.Name);
  FCfgTela.pCarregaOrd(cdsColOrdItens, cxGridItens.Name);

  dbgLeadsDBTableView1.Zebra := False;
  dbgLeadsDBTableView1.OnCustomDrawCell := dbgLeadsDBTableView1CustomDrawCell;

  cxGridItensView.Zebra := False;
  cxGridItensView.OnCustomDrawCell := dbgLeadsDBTableView1CustomDrawCell;
end;

procedure TfrmConsultaLeadsCRM.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F2    : Begin
                 If btnAbrirCadLead.Enabled Then
                   btnAbrirCadLead.Click;
               End;
    VK_F3    : Begin
                 btnExibirLinhaGrupo.Click;
               End;
    VK_F4    : Begin
                 If btnExportaCsv.Enabled Then
                   btnExportaCsv.Click;
               End;
    VK_F10   : Begin
                 If btnConfirma.Enabled Then
                   btnConfirma.Click;
               End;
    VK_ESCAPE: Begin
                 If btnSairBaixa.Enabled Then
                   btnSairBaixa.Click;
               End;
  End;

end;

procedure TfrmConsultaLeadsCRM.pConfiguraPermissaoCamposVendedor;
begin
  If (Not fVerificaAcessoSistema('CRMCONSLEADSVEN')) Then
  Begin
    edtCodVen.MaxLength := 10;
    edtCodVen.TamCampo  := 0;
    edtCodVen.CompZeros := False;
    edtCodVen.PasswordChar := '*';
    edtCodVen.TipoTexto := ttAlfanumerico;
    shpPermissaoVEN.Brush.Color := clRed;
  End
  Else
    shpPermissaoVEN.Brush.Color := clGreen;

  If (Not fVerificaAcessoSistema('CRMCONSLEADSVEE')) Then
  Begin
    edtCodVenExt.MaxLength := 10;
    edtCodVenExt.TamCampo  := 0;
    edtCodVenExt.CompZeros := False;
    edtCodVenExt.PasswordChar := '*';
    edtCodVenExt.TipoTexto := ttAlfanumerico;
    shpPermissaoVEE.Brush.Color := clRed;
  End
  Else
    shpPermissaoVEE.Brush.Color := clGreen;
end;

procedure TfrmConsultaLeadsCRM.FormShow(Sender: TObject);
Var
  intRecNo: Integer;
Begin
  inherited;

  pCarregaCamposForm(Self, 'frmConsultaLeadsCRM.Campos', False);
  pValidaCamposSemMensagem;

  fGetFuncoesCxGrid.fCarregarView(dbgLeadsDBTableView1, 'frmConsultaLeadsCRM.dbgLeadsDBTableView1', cdsLeads, intRecNo);

  FCfgTela.pIniciar(dbgLeads, dbgLeadsDBTableView1);
  FCfgTela.pIniciar(cxGridItens, cxGridItensView);

  If cbStatus.ItemIndex < 0 Then
    cbStatus.ItemIndex := 0;

  If fEmptyStr(edtCodCli.Text) Then
    edtCodCli.Text := strCodCli;

  If cbExibirLinhaGrupo.Checked Then
   FEstadoGridItens := tpExpandido
  Else
   FEstadoGridItens := tpRecolhido;

  pAjustarVisualizacaoGridItens;
  pConfiguraPermissaoCamposVendedor;

  If Not fEmptyStr(edtCodCli.Text) or
     Not fEmptyStr(edtCodVen.Text) or
     Not fEmptyStr(edtCodVenExt.Text) or
     Not fEmptyStr(edtFasObr.Text) or
     Not fEmptyStr(edtCodCat.Text) or
     Not fEmptyStr(edtCodPrj.Text) or
     Not fEmptyStr(edtNumDoc.Text) or
     Not(fEmptyDate(mskDtaIni.Text)) or
     Not(fEmptyDate(mskDtaFim.Text)) or
     Not(fEmptyDate(mskDtaPrevOrc.Text)) or
     Not(fEmptyDate(mskDtaFimPrevOrc.Text)) or
     Not(fEmptyDate(mskDtaIniFin.Text)) or
     Not(fEmptyDate(mskDtaFimFin.Text)) or
     Not fEmptyStr(edtCodOper.Text) or
     Not fEmptyStr(edtCodIns.Text) or
     (cbStatus.ItemIndex > 0) or
     Not(fEmptyDate(mskDtaCadIni.Text)) or
     Not(fEmptyDate(mskDtaCadFim.Text)) or
     (cbContemLinGrp.ItemIndex > 0)Or
     Not fEmptyStr(edtCodMar.Text)
  Then
    pCarregaPesquisaLeads;
End;

procedure TfrmConsultaLeadsCRM.FormClose(Sender: TObject;
  var Action: TCloseAction);
Begin
  inherited;

  pValidaCamposSemMensagem;
  pSalvaCamposForm(Self, 'frmConsultaLeadsCRM.Campos', False);
  fGetFuncoesCxGrid.pSalvarView(dbgLeadsDBTableView1, 'frmConsultaLeadsCRM.dbgLeadsDBTableView1', cdsLeads);

  cdsLeads.Close;

  FreeAndNil(FCfgTela);
End;

procedure TfrmConsultaLeadsCRM.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
Begin
  inherited;

  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrCliente, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
End;

procedure TfrmConsultaLeadsCRM.edtCodGruExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodGru.Text) Then
    edtDesGru.Text := 'TODOS'
  Else
    pEdtCodSelectExit(edtCodGru, edtDesGru, arrGrupo, Nil, fRetNomLinhaGrupo, 'do Grupo');
end;

procedure TfrmConsultaLeadsCRM.edtCodGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, edtCodGru, edtDesGru, Nil, Key, arrGrupo, False) Then
  Begin
    If fValidaCampos(edtCodGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaLeadsCRM.edtCodCliExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodCli.Text) Then
    edtNomCli.Text := 'TODOS'
  Else
    pEdtCodSelectExit(edtCodCli, edtNomCli, arrCliente, Nil, fRetNomCliente, 'do Cliente');
end;

procedure TfrmConsultaLeadsCRM.pCarregaCliente;
Begin
  If (Length(arrCliente) > 1) Then
  Begin
    edtCodCli.Text := StringOfChar('0', edtCodCli.TamCampo);
    edtNomCli.Text := '+1';
  End
  else
    edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
End;

procedure TfrmConsultaLeadsCRM.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
Begin
  inherited;
  If (fVerificaAcessoSistema('CRMCONSLEADSVEN')) Then
  Begin
    If fPesqOperador(Self, edtCodVen, edtNomVen, nil, Key, arrVendedor, False) then
    Begin
      If fValidaCampos(edtCodVen, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
End;

procedure TfrmConsultaLeadsCRM.pCarregaVendedor;
begin
  If (fVerificaAcessoSistema('CRMCONSLEADSVEN')) Then
  Begin
    If (StrToIntDef(edtCodVen.Text, 0) > 0) Then
    Begin
      If Length(edtCodVen.Text) < edtCodVen.TamCampo  Then
        edtCodVen.Text := fStrZero('0', edtCodVen.TamCampo - Length(edtCodVen.Text) ) + edtCodVen.Text;
    End;

    strCodVen := edtCodVen.Text;

    If (Length(arrVendedor) > 1) Then
    Begin
      edtNomVen.Text := '+1';
    End
    Else
    Begin
      edtNomVen.Text := fRetNomeOperador(strCodVen);
    End;
  End
  Else
  Begin
    strCodVen := fRetCodVendedor(edtCodVen.Text);
    edtNomVen.Text := fRetNomeOperador(strCodVen);
  End;
end;

procedure TfrmConsultaLeadsCRM.edtCodVenExit(Sender: TObject);
Begin
  inherited;

  If fEmptyStr(edtCodVen.Text) Then
    edtNomVen.Text := 'TODOS'
  Else
  Begin
    pCarregaVendedor;
  End;

End;

procedure TfrmConsultaLeadsCRM.edtCodVenExtKeyPress(Sender: TObject;
  var Key: Char);
Begin
  inherited;

  If (fVerificaAcessoSistema('CRMCONSLEADSVEE')) Then
  Begin
    If fPesqOperador(Self, edtCodVenExt, edtNomVenExt, nil, Key, arrVendedorExt, False) Then
    Begin
      If fValidaCampos(edtCodVenExt, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
End;

procedure TfrmConsultaLeadsCRM.edtCodVenExtExit(Sender: TObject);
Begin
  inherited;

  If fEmptyStr(edtCodVenExt.Text) Then
    edtNomVenExt.Text := 'TODOS'
  Else
    pCarregaVendedorExt;
End;

procedure TfrmConsultaLeadsCRM.pCarregaVendedorExt;
begin
  If (fVerificaAcessoSistema('CRMCONSLEADSVEE')) Then
  Begin
    If (StrToIntDef(edtCodVenExt.Text, 0) > 0) Then
    Begin
      If Length(edtCodVenExt.Text) < edtCodVenExt.TamCampo Then
        edtCodVenExt.Text := fStrZero('0', edtCodVenExt.TamCampo - Length(edtCodVenExt.Text) ) + edtCodVenExt.Text;
    End;

    If (Length(arrVendedorExt) > 1) Then
    Begin
      If (StrToInt(edtCodVenExt.Text) > 0) Then
        edtCodVenExt.Text := StringOfChar('0', edtCodVenExt.TamCampo);

      strCodVenExt      := edtCodVenExt.Text;
      edtNomVenExt.Text := '+1';
    End
    Else
    Begin
      strCodVenExt := edtCodVenExt.Text;
      edtNomVenExt.Text := fRetNomeOperador(edtCodVenExt.Text);
    End;
  End
  Else
  Begin
    strCodVenExt := fRetCodVendedor(edtCodVenExt.Text);
    edtNomVenExt.Text := fRetNomeOperador(strCodVenExt);
  End;
end;

procedure TfrmConsultaLeadsCRM.edtFasObrKeyPress(Sender: TObject; var Key: Char);
Begin
  inherited;

  If fPesqFaseObra(Self, edtFasObr, edtDesFasObr, nil, Key, arrFaseObra, False) Then
  Begin
    If fValidaCampos(edtFasObr, True) Then
      SelectNext(ActiveControl, True, True);
  End;
End;

procedure TfrmConsultaLeadsCRM.edtFasObrExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtFasObr.Text) Then
    edtDesFasObr.Text := 'TODOS'
  Else
    pEdtCodSelectExit(edtFasObr, edtDesFasObr, arrFaseObra, fRetFaseObra, Nil, 'da Fase da Obra');
end;

procedure TfrmConsultaLeadsCRM.pCarregaFaseObr;
begin
  If (Length(arrFaseObra) > 1) Then
  Begin
    edtFasObr.Text := StringOfChar('0', edtFasObr.TamCampo);
    edtDesFasObr.Text := '+1';
  End
  else
    edtDesFasObr.Text := fRetNomFaseObra(edtFasObr.Text);
end;

procedure TfrmConsultaLeadsCRM.edtCodCatKeyPress(Sender: TObject; var Key: Char);
Begin
  If fPesqCategoriaOrPd(Self, edtCodCat, edtDesCat, Nil, Key, arrCategoria, False) Then
  Begin
    If fValidaCampos(edtCodCat, True) Then
      SelectNext(ActiveControl, True, True);
  End;

End;

procedure TfrmConsultaLeadsCRM.edtCodCatExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodCat.Text) Then
    edtDesCat.Text := 'TODAS'
  Else
    pEdtCodSelectExit(edtCodCat, edtDesCat, arrCategoria, Nil, fRetDesCat, 'da Categoria');

end;

procedure TfrmConsultaLeadsCRM.pCarregaCategoria;
begin
  If (Length(arrCategoria) > 1) Then
  Begin
    edtCodCat.Text := StringOfChar('0', edtCodCat.TamCampo);
    edtDesCat.Text := '+1';
  End
  else
    edtDesCat.Text := fRetDescCatego(edtCodCat.Text);
end;

procedure TfrmConsultaLeadsCRM.edtCodPrjExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodPrj.Text) Then
    edtDesCodPrj.Text := 'TODOS'
  Else
    fValidaCampos(edtCodPrj, True);

end;

procedure TfrmConsultaLeadsCRM.edtCodPrjKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    If fPesqProjetoLeads(Self, edtCodPrj, edtDesCodPrj, Nil, Key, arrProjeto, False) Then
    Begin
      If fValidaCampos(edtCodPrj, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End
  Else If Not (Key = Char(VK_RETURN)) Then
  Begin
    Key := #0;
    pSetFocus(edtCodPrj);
  End;

end;

procedure TfrmConsultaLeadsCRM.edtCodPVeExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodPVe.Text) Then
    edtNomPVe.Text := 'TODOS'
  Else
    pEdtCodSelectExit(edtCodPVe, edtNomPVe, arrPreVnd, fRetNomeOperador, Nil, 'da Pré-Venda');
end;

procedure TfrmConsultaLeadsCRM.edtCodPVeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  if fPesqOperador(Self, edtCodPVe, edtNomPVe, Nil, Key, arrPreVnd) then
  Begin
    If fValidaCampos(edtCodPVe, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaLeadsCRM.pCarregaPreVenda;
begin
  If (StrToIntDef(edtCodPVe.Text, 0) > 0) Then
  Begin
    If Length(edtCodPVe.Text) < edtCodPVe.TamCampo  Then
      edtCodPVe.Text := fStrZero('0', edtCodPVe.TamCampo - Length(edtCodPVe.Text) ) + edtCodPVe.Text;
  End;

  If (Length(arrPreVnd) > 1) Then
  Begin
    edtNomPVe.Text := '+1';
  End
  Else
    edtNomPVe.Text := fRetNomeOperador(edtCodPVe.Text);
end;

procedure TfrmConsultaLeadsCRM.pCarregaProjeto;
begin
  If (Length(arrProjeto) > 1) Then
    edtDesCodPrj.Text := '+1';
end;

procedure TfrmConsultaLeadsCRM.pCarregarGrupo;
begin
  If (Not SameText(edtCodGru.Text, '000000')) Then
    pEdtCodSelectExit(edtCodGru, edtDesGru, arrGrupo, Nil, fRetNomLinhaGrupo, 'do Grupo');
end;

procedure TfrmConsultaLeadsCRM.pCarregarMarca;
begin
  If (Not SameText(edtCodMar.Text, '000000')) Then
    pEdtCodSelectExit(edtCodMar, edtDesMar, arrMarca, fRetNomMarca, Nil, 'da Marca');
end;

procedure TfrmConsultaLeadsCRM.pCarregarTotais;
Begin
  edtTotPrevOrc.Text := FormatFloat('#,##0.0000', fDoubleAggregate(cdsLeads, 'TOT_VLRORC'));
  edtQtdTotOrc.Text := FormatFloat('#,##0.0000', fDoubleAggregate(cdsLeads, 'TOT_QTDORC'));
end;

procedure TfrmConsultaLeadsCRM.edtNumDocKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqNumDocLeads(Self, edtNumDoc, edtDesNumDoc, nil, Key, arrDocumento, False) Then
  Begin
    If fValidaCampos(edtNumDoc, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaLeadsCRM.edtNumDocExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtNumDoc.Text) Then
    edtDesNumDoc.Text := 'TODOS'
  Else
    fValidaCampos(edtNumDoc, True);

end;

procedure TfrmConsultaLeadsCRM.pCarregaDocumento;
begin
  If (Length(arrDocumento) > 1) Then
    edtDesNumDoc.Text := '+1';
end;

procedure TfrmConsultaLeadsCRM.edtCodOperKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqOperador(Self, edtCodOper, edtDesOper, nil, Key, arrOperadorFin, False) Then
    If fValidaCampos(edtCodOper, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmConsultaLeadsCRM.edtCodOperExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodOper.Text) Then
    edtDesOper.Text := 'TODOS'
  Else
    pEdtCodSelectExit(edtCodOper, edtDesOper, arrOperadorFin, fRetNomeOperador, Nil, 'do Operador de Finalização');
end;

procedure TfrmConsultaLeadsCRM.pCarregaOperaFin;
begin
  If (StrToIntDef(edtCodOper.Text, 0) > 0) Then
  Begin
    If Length(edtCodOper.Text) < edtCodOper.TamCampo Then
      edtCodOper.Text := fStrZero('0', edtCodOper.TamCampo - Length(edtCodOper.Text) ) + edtCodOper.Text;
  End;

  If (Length(arrOperadorFin) > 1) Then
  Begin
    edtCodOper.Text := StringOfChar('0', edtCodOper.TamCampo);
    edtDesOper.Text := '+1';
  End
  else
    edtDesOper.Text := fRetNomeOperador(edtCodOper.Text);
end;

procedure TfrmConsultaLeadsCRM.edtCodInsKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqCliente(conCliSimples, Self, edtCodIns, edtNomIns, Nil, Key, arrInstalador, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaLeadsCRM.edtCodMarExit(Sender: TObject);
begin
  inherited;

  If (Not SameText(edtCodMar.Text, '000000')) Then
    pEdtCodSelectExit(edtCodMar, edtDesMar, arrMarca, fRetNomMarca, Nil, 'da Marca');
end;

procedure TfrmConsultaLeadsCRM.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaLeadsCRM.edtCodInsExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodIns.Text) Then
    edtNomIns.Text := 'TODOS'
  Else
    pEdtCodSelectExit(edtCodIns, edtNomIns, arrInstalador, Nil, fRetNomCliente, 'do Instalador');
end;

procedure TfrmConsultaLeadsCRM.pCarregaInstalador;
Begin
  If (Length(arrInstalador) > 1) Then
  Begin
    edtCodIns.Text := StringOfChar('0', edtCodIns.TamCampo);
    edtNomIns.Text := '+1';
  End
  else
    edtNomIns.Text := fRetNomCliente(edtCodIns.Text);
End;

function TfrmConsultaLeadsCRM.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
Begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = edtCodCli) Then
    Begin
      If Not fEmptyStr(edtCodCli.Text) Then
      Begin
        pCarregaCliente;
        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este Código de CLIENTE não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        edtNomCli.Text := 'TODOS';
    End

    Else If (Sender = edtCodVen)  Then
    Begin
      If Not fEmptyStr(edtCodVen.Text) Then
      Begin
        pCarregaVendedor;
        If fEmptyStr(edtNomVen.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este Código de VENDEDOR não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        If (fVerificaAcessoSistema('CRMCONSLEADSVEN')) Then
          edtNomVen.Text := 'TODOS'
        Else
        Begin
          fMensagem('ATENÇÃO!', 'Código do VENDEDOR obrigatório!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodVenExt) Then
    Begin
      If Not fEmptyStr(edtCodVenExt.Text) Then
      Begin
        pCarregaVendedorExt;
        If fEmptyStr(edtNomVenExt.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este Código de VENDEDOR EXTERNO não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        If (fVerificaAcessoSistema('CRMCONSLEADSVEE')) Then
          edtNomVenExt.Text := 'TODOS'
        Else
        Begin
          fMensagem('ATENÇÃO!', 'Código do VENDEDOR EXTERNO obrigatório!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtFasObr) Then
    Begin
      If Not fEmptyStr(edtFasObr.Text) Then
      Begin
        pCarregaFaseObr;
        If fEmptyStr(edtDesFasObr.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este Código da FASE DA OBRA não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        edtDesFasObr.Text := 'TODAS';
    End

    Else If (Sender = edtCodCat) Then
    Begin
      If Not fEmptyStr(edtCodCat.Text) Then
      Begin
        pCarregaCategoria;
        If fEmptyStr(edtDesCat.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este Código da CATEGORIA não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        edtDesCat.Text := 'TODAS';
    End

    Else If (Sender = edtCodPrj)  Then
    Begin
      If Not fEmptyStr(edtCodPrj.Text) Then
      Begin
        pCarregaProjeto;
        If fEmptyStr(edtDesCodPrj.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este PROJETO não está lançado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        edtDesCodPrj.Text := 'TODOS';
    End

    Else If (Sender = edtNumDoc) Then
    Begin
      If Not fEmptyStr(edtNumDoc.Text) Then
      Begin
        pCarregaDocumento;
        If fEmptyStr(edtNumDoc.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este DOCUMENTO não está lançado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        edtDesNumDoc.Text := 'TODOS';
    End

    Else If (Sender = edtCodOper) Then
    Begin
      If Not fEmptyStr(edtCodOper.Text) Then
      Begin
        pCarregaOperaFin;
        If fEmptyStr(edtDesOper.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este Código de OPERADOR DE FINALIZAÇÃO não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        edtDesOper.Text := 'TODOS';
    End

    Else If (Sender = edtCodIns) Then
    Begin
      If Not fEmptyStr(edtCodIns.Text) Then
      Begin
        pCarregaInstalador;
        If fEmptyStr(edtNomIns.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este Código de INSTALADOR não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        edtNomIns.Text := 'TODOS';
    End

    Else If ((Sender = mskDtaIni) or (Sender = mskDtaFim)) Then
    Begin
      If ((Not fEmptyStr(mskDtaIni.Text)) And (mskDtaIni.Text <> '  /  /    ')) And
         ((Not fEmptyStr(mskDtaFim.Text)) And (mskDtaFim.Text <> '  /  /    ')) And
         (StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFim.Text))  Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial não pode ser maior que a data final!', ['&Ok']);
        Result := False;
      End;
    End

    Else If ((Sender = mskDtaPrevOrc) or (Sender = mskDtaFimPrevOrc)) Then
    Begin
      If ((Not fEmptyStr(mskDtaPrevOrc.Text)) And (mskDtaPrevOrc.Text <> '  /  /    ')) And
         ((Not fEmptyStr(mskDtaFimPrevOrc.Text)) And (mskDtaFimPrevOrc.Text <> '  /  /    ')) And
         (StrToDate(mskDtaPrevOrc.Text) > StrToDate(mskDtaFimPrevOrc.Text))  Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial não pode ser maior que a data final!', ['&Ok']);
        Result := False;
      End;
    End

    Else If ((Sender = mskDtaIniFin) or (Sender = mskDtaFimPrevOrc)) Then
    Begin
      If ((Not fEmptyStr(mskDtaIniFin.Text)) And (mskDtaIniFin.Text <> '  /  /    ')) And
         ((Not fEmptyStr(mskDtaFimFin.Text)) And (mskDtaFimFin.Text <> '  /  /    ')) And
         (StrToDate(mskDtaIniFin.Text) > StrToDate(mskDtaFimFin.Text))  Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial não pode ser maior que a data final!', ['&Ok']);
        Result := False;
      End;
    End

    Else If ((Sender = mskDtaCadIni) or (Sender = mskDtaCadFim)) Then
    Begin
      If ((Not fEmptyStr(mskDtaCadIni.Text)) And (mskDtaCadIni.Text <> '  /  /    ')) And
         ((Not fEmptyStr(mskDtaCadFim.Text)) And (mskDtaCadFim.Text <> '  /  /    ')) And
         (StrToDate(mskDtaCadIni.Text) > StrToDate(mskDtaCadFim.Text) )  Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial não pode ser maior que a data final!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodPVe)  Then
    Begin
      If Not fEmptyStr(edtCodPVe.Text) Then
      Begin
        pCarregaPreVenda;
        If fEmptyStr(edtNomPVe.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este Código de PRÉ-VENDA não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        edtNomPVe.Text := 'TODOS';
    End

    Else If (Sender = edtCodMar)  Then
    Begin
      If Not fEmptyStr(edtCodMar.Text) Then
      Begin
        pCarregarMarca;
        If fEmptyStr(edtCodMar.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este Código de MARCA não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        edtDesMar.Text := 'TODAS';
    End

    Else If (Sender = edtCodGru) Then
    Begin
      If Not fEmptyStr(edtCodGru.Text) Then
      Begin
        pCarregarGrupo;
        If fEmptyStr(edtDesGru.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este Código do GRUPO não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        edtDesGru.Text := 'TODOS';
     End;

    If (Not Result) Then
      pSetFocus(Sender);

  End;
End;

procedure TfrmConsultaLeadsCRM.btnAbrirCadLeadClick(Sender: TObject);
begin
  inherited;

  blnConfirma := False;

  If (Not cdsLeads.IsEmpty) Then
  Begin
    pAbrirCadastroLeads(cdsLeads.FieldByName('CODCLI').AsString,
                        cdsLeads.FieldByName('AUTOINCREM').AsString);
  End;
end;

procedure TfrmConsultaLeadsCRM.btnCancelarClick(Sender: TObject);
begin
  inherited;

  If (fMensagem('ATENÇÃO!', 'Deseja realmente cancelar a consulta?', ['&S I M', '&N Ã O'], 2) = 2) Then
    Exit;

  edtCodCli.Clear;
  edtNomCli.Clear;
  edtCodVen.Clear;
  edtNomVen.Clear;
  edtCodVenExt.Clear;
  edtNomVenExt.Clear;
  edtFasObr.Clear;
  edtDesFasObr.Clear;
  edtCodCat.Clear;
  edtDesCat.Clear;
  edtCodPrj.Clear;
  edtDesCodPrj.Clear;
  edtNumDoc.Clear;
  cdsLeads.Close;
  cbStatus.ItemIndex := 0;
  edtCodOper.Clear;
  edtDesOper.Clear;
  edtCodIns.Clear;
  edtNomIns.Clear;
  edtDesNumDoc.Clear;
  mskDtaIni.Clear;
  mskDtaFim.Clear;
  mskDtaPrevOrc.Clear;
  mskDtaFimPrevOrc.Clear;
  mskDtaIniFin.Clear;
  mskDtaFimFin.Clear;
  mskDtaCadIni.Clear;
  mskDtaCadFim.Clear;
  edtCodPVe.Clear;
  edtCodMar.Clear;
  edtDesMar.Clear;
  edtCodGru.Clear;
  edtDesGru.Clear;
  cbContemMarca.ItemIndex := 0;
  cbOrdemExibicao.ItemIndex := 0;
end;

procedure TfrmConsultaLeadsCRM.btnCarregaClick(Sender: TObject);
Begin
  inherited;

  pCarregaPesquisaLeads;
End;

function TfrmConsultaLeadsCRM.fObtemParametroGrupo(const Indice: Integer): string;
Begin

  If Indice <= 0 Then
    Exit;

  Result := 'AND (SELECT COUNT(LDD_LINGRU) ' +
                          'FROM LADDET  ' +
                          'WHERE LDD_LINGRU IS NOT NULL ';
  Case  Indice Of
    1 : Result := Result + ' AND  LDD_SEQGER = G.AUTOINCREM) > 0 ';
    2 : Result := Result + ' AND  LDD_SEQGER = G.AUTOINCREM) <= 0 ';
  End;

  If Not fEmptyStr(Result) Then
    qryLeads.SQL.Add(Result);

End;

function TfrmConsultaLeadsCRM.fObtemParametroRegistro(const Indice: Integer): string;
Begin

  If Indice <= 0 Then
    Exit;

  Result := 'AND (SELECT COUNT(LDD_REGIST) ' +
                          'FROM LADDET  ' +
                          'WHERE LDD_REGIST = "S" ';
  Case  Indice Of
    1 : Result := Result + ' AND  LDD_SEQGER = G.AUTOINCREM) > 0 ';
    2 : Result := Result + ' AND  LDD_SEQGER = G.AUTOINCREM) <= 0 ';
  End;

  If Not fEmptyStr(Result) Then
    qryLeads.SQL.Add(Result);
End;

function TfrmConsultaLeadsCRM.fObtemParametroMarca(const Indice: Integer): string;
Begin

  If Indice <= 0 Then
    Exit;

  Result := 'AND (SELECT COUNT(LDD_CODMAR) ' +
                          'FROM LADDET  ' +
                          'WHERE LDD_CODMAR IS NOT NULL  ';
  Case  Indice Of
    1 : Result := Result + ' AND  LDD_SEQGER = G.AUTOINCREM) > 0 ';
    2 : Result := Result + ' AND  LDD_SEQGER = G.AUTOINCREM) <= 0 ';
  End;

  If Not fEmptyStr(Result) Then
    qryLeads.SQL.Add(Result);
End;

procedure TfrmConsultaLeadsCRM.pAdicionaClausulaWhereLinhaGrupo;
begin
  If fEmptyStr(edtCodGru.Text) Then
    Exit;

  qryLeads.SQL.Add('AND (SELECT COUNT(LDD_LINGRU) ' +
                        'FROM LADDET  ' +
                        'WHERE LDD_SEQGER = G.AUTOINCREM  ' +
                        fStrLocate(edtCodGru, arrGrupo, 'LDD_LINGRU', 'CODGRU') +
                        '   )');
  pSetaParam(edtCodGru.Text, arrGrupo, strCnsCodMar, 'CODGRU', qryLeads);
end;

procedure TfrmConsultaLeadsCRM.pAdicionaClausulaWhereMarca;
begin
  If fEmptyStr(edtCodMar.Text) Then
    Exit;

  qryLeads.SQL.Add('AND (SELECT COUNT(LDD_CODMAR) ' +
                        'FROM LADDET  ' +
                        'WHERE LDD_SEQGER = G.AUTOINCREM  ' +
                        fStrLocate(edtCodMar, arrMarca, 'LDD_CODMAR', 'CODMAR') +
                        '   )');
  pSetaParam(edtCodMar.Text, arrMarca, strCnsCodMar, 'CODMAR', qryLeads);
end;

procedure TfrmConsultaLeadsCRM.pAdicionaClausulaWherePreVenda;
Begin
  If fEmptyStr(edtCodPVe.Text) Then
    Exit;

  qryLeads.SQL.Add('AND (SELECT COUNT(LDD_PREVEN) ' +
                        'FROM LADDET  ' +
                        'WHERE LDD_SEQGER = G.AUTOINCREM  ' +
                        '  AND LDD_PREVEN = :PREVEN )');
  qryLeads.ParamByName('PREVEN').AsString := edtCodPVe.Text;
End;

procedure TfrmConsultaLeadsCRM.pAdicionarFiltroStatus;
var
  strWhereStatus: string;
begin
  pStatusMarcados;
  If ((Length(arrStatus)) > 0 ) Then
  Begin
    strWhereStatus := fStrLocate(arrStatus[0].strCodigo, arrStatus, 'LDG_STATUS', 'STATUS');

    qryLeads.SQL.Add(strWhereStatus);
    pSetaParam(arrStatus[0].strCodigo, arrStatus, strCnsStatus, 'STATUS', qryLeads);
  End;
end;

procedure TfrmConsultaLeadsCRM.pConsultaLeads;
const
  strSQLLeads  =  ' SELECT LDG_NUMDOC,                                                   ' +
                  '        LDG_CODCLI AS CODCLI,                                         ' +
                  '        CONCAT( LDG_CODCLI , " - ", CLI.CLI_NOMCLI ) AS CLI_NOMCLI,   ' +
                  '        LDG_CODVEN AS CODVEN,                                         ' +
                  '        (CASE WHEN LDG_CODVEN IS NOT NULL THEN CONCAT( LDG_CODVEN, " - ", VEN.OPE_NOMOPE ) ' +
                  '              END) AS NOM_VEN,' +
                  '        (CASE WHEN LDG_VENEXT IS NOT NULL THEN CONCAT( LDG_VENEXT, " - ", EXT.OPE_NOMOPE ) ' +
                  '              END) AS NOM_EXT, ' +
                  '        (CASE WHEN LDG_CODFAS IS NOT NULL THEN CONCAT( LDG_CODFAS, " - ", FAS_DESCRI ) ' +
                  '              END) AS FAS_OBR,' +
                  '        LDG_CODCAT, ' +
                  '        (CASE WHEN LDG_CODCAT IS NOT NULL THEN CONCAT( LDG_CODCAT, " - ", CAT_DESCRI ) ' +
                  '              END) AS CAT_DESCRI,' +
                  '        LDG_INIOBR, ' +
                  '        LDG_PREORC, ' +
                  '        LDG_NOMPRO, ' +
                  '        LDG_TOTVPR, ' +
                  '        LDG_STATUS, ' +
                  '        (CASE LDG_STATUS ' +
                  '                  WHEN ''A'' THEN ''ANDAMENTO'' ' +
                  '                  WHEN ''F'' THEN ''FINALIZADO'' '+
                  '                  WHEN ''B'' THEN ''ABERTO'' '+
                  '                  WHEN ''P'' THEN ''FATURAMENTO PARCIAL'' '+
                  '                END) AS STATUS,' +
                  '        LDG_DTAFIN, ' +
                  '        LDG_OPEFIN, ' +
                  '        (CASE WHEN LDG_OPEFIN IS NOT NULL THEN CONCAT( LDG_OPEFIN, " - ", OPEFIN.OPE_NOMOPE ) ' +
                  '              END) AS OPE_FIN,' +
                  '        LDG_CODINS, ' +
                  '        (CASE WHEN LDG_CODINS IS NOT NULL THEN CONCAT( LDG_CODINS, " - ", INS.CLI_NOMCLI ) ' +
                  '              END) AS NOM_INS,' +
                  '        G.AUTOINCREM, ' +
                  '        G.LDG_DTACAD, ' +
                  '        P.PREVND,     ' +
                  '        O.QTDORC,     ' +
                  '        C.QTDOCO,     ' +
                  '        G.LDG_ULTALT, ' +
                  '       (CASE WHEN (IFNULL(LDG_TOTVPR, 0.00) > 0) THEN 1.00 ELSE 0.00 END) AS QTDORC_LIS ' +
                  ' FROM LADGER G        ' +
                  '   INNER JOIN CADCLI CLI ON CLI.CLI_CODCLI = LDG_CODCLI ' +
                  '   LEFT JOIN CADOPE VEN ON VEN.OPE_CODOPE = LDG_CODVEN ' +
                  '   LEFT JOIN CADOPE EXT ON EXT.OPE_CODOPE = LDG_VENEXT ' +
                  '   LEFT JOIN FASOBR OBR ON OBR.FAS_CODFAS = LDG_CODFAS ' +
                  '   LEFT JOIN CATEGO CTE ON CTE.CAT_CODIGO = LDG_CODCAT ' +
                  '   LEFT JOIN CADOPE OPEFIN ON OPEFIN.OPE_CODOPE = LDG_OPEFIN ' +
                  '   LEFT JOIN CADCLI INS ON INS.CLI_CODCLI = LDG_CODINS ' +
                  '   LEFT JOIN (SELECT FGO_NLEADS, COALESCE(COUNT(FGO_SEQFGO), 0) AS QTDORC ' +
                                 '  FROM FATGOR  ' +
                                 '  INNER JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM  ' +
                                 'WHERE FGO_NLEADS IS NOT NULL ' +
                                 'GROUP BY FGO_NLEADS  ' +
                                 'ORDER BY FGO_NLEADS ) O ON (G.LDG_NUMDOC = O.FGO_NLEADS ) '+
                  '   LEFT JOIN (SELECT CONCAT( LDD_PREVEN, " - ",  INS.OPE_NOMOPE) AS PREVND, ' +
                                 '      LDD_SEQGER, ' +
                                 '      MIN(LADDET.AUTOINCREM) AS SEQITE ' +
                                 'FROM LADDET ' +
                                 'LEFT JOIN CADOPE INS ON INS.OPE_CODOPE = LDD_PREVEN ' +
                                 'GROUP BY LDD_SEQGER ' +
                                 'ORDER BY LDD_SEQGER  ) AS P ON P.LDD_SEQGER = G.AUTOINCREM ' +
                  '   LEFT JOIN (SELECT COUNT(OCO_SEQLAG) AS QTDOCO, OCO_SEQLAG '+
                                 'FROM MOVOCO                       '+
                                 ' WHERE OCO_SEQLAG IS NOT NULL     '+
                                 ' GROUP BY OCO_SEQLAG              '+
                                 ' ORDER BY OCO_SEQLAG              '+
                                 '   ) C ON (G.AUTOINCREM = C.OCO_SEQLAG ) '+

                  ' WHERE 1 = 1 ';
Begin

  Try
    cdsLeads.Close;
    qryLeads.SQL.Clear;

    qryLeads.SQL.Add(strSQLLeads);

    pAdicionaClausulaWhereQry(qryLeads, strClientes, edtCodCli, arrCliente, 'LDG_CODCLI', 'CODCLI', edtCodCli.Text);
    pAdicionaClausulaWhereQry(qryLeads, strVendedores, edtCodVen, arrVendedor, 'LDG_CODVEN', 'CODVEN', strCodVen);
    pAdicionaClausulaWhereQry(qryLeads, strVendedoresExt, edtCodVenExt, arrVendedorExt, 'LDG_VENEXT', 'LDG_VENEXT', strCodVenExt);
    pAdicionaClausulaWhereQry(qryLeads, strFaseObra, edtFasObr, arrFaseObra, 'LDG_CODFAS', 'LDG_CODFAS', edtFasObr.Text);
    pAdicionaClausulaWhereQry(qryLeads, strCategoria, edtCodCat, arrCategoria, 'LDG_CODCAT', 'LDG_CODCAT', edtCodCat.Text);
    pAdicionaClausulaWhereQry(qryLeads, strProjeto, edtCodPrj, arrProjeto, 'LDG_NOMPRO', 'LDG_NOMPRO', edtCodPrj.Text);
    pAdicionaClausulaWhereQry(qryLeads, strDocumento, edtNumDoc, arrDocumento, 'LDG_NUMDOC', 'LDG_NUMDOC', edtNumDoc.Text);
    pAdicionaClausulaWhereQry(qryLeads, strOperadorFin, edtCodOper, arrOperadorFin, 'LDG_OPEFIN', 'LDG_OPEFIN', edtCodOper.Text);
    pAdicionaClausulaWhereQry(qryLeads, strInstalador, edtCodIns, arrInstalador, 'LDG_CODINS', 'LDG_CODINS', edtCodIns.Text);

    If (Not fEmptyDate(mskDtaIni.Text)) Then
    Begin
      qryLeads.SQL.Add('AND LDG_INIOBR >= :LDG_INIOBR_INI');
      qryLeads.ParamByName('LDG_INIOBR_INI').AsDateTime := StrToDate(mskDtaIni.Text);
    End;

    If (Not fEmptyDate(mskDtaFim.Text)) Then
    Begin
      qryLeads.SQL.Add('AND LDG_INIOBR <= :LDG_INIOBR_FIM');
      qryLeads.ParamByName('LDG_INIOBR_FIM').AsDateTime := StrToDate(mskDtaFim.Text);
    End;

    If (Not fEmptyDate(mskDtaPrevOrc.Text)) Then
    Begin
      qryLeads.SQL.Add('AND LDG_PREORC >= :LDG_PREORC_INI');
      qryLeads.ParamByName('LDG_PREORC_INI').AsDateTime := StrToDate(mskDtaPrevOrc.Text);
    End;

    If (Not fEmptyDate(mskDtaFimPrevOrc.Text)) Then
    Begin
      qryLeads.SQL.Add('AND LDG_PREORC <= :LDG_PREORC_FIM');
      qryLeads.ParamByName('LDG_PREORC_FIM').AsDateTime := StrToDate(mskDtaFimPrevOrc.Text);
    End;

    If (Not fEmptyDate(mskDtaIniFin.Text)) Then
    Begin
      qryLeads.SQL.Add('AND LDG_DTAFIN >= :LDG_DTAFIN_INI');
      qryLeads.ParamByName('LDG_DTAFIN_INI').AsDateTime := StrToDate(mskDtaIniFin.Text);
    End;

    If (Not fEmptyDate(mskDtaFimFin.Text)) Then
    Begin
      qryLeads.SQL.Add('AND LDG_DTAFIN <= :LDG_DTAFIN_FIM');
      qryLeads.ParamByName('LDG_DTAFIN_FIM').AsDateTime := StrToDate(mskDtaFimFin.Text);
    End;

    pAdicionarFiltroStatus;

    fObtemParametroGrupo(cbContemLinGrp.ItemIndex);
    fObtemParametroRegistro(cbContemReg.ItemIndex);
    fObtemParametroMarca(cbContemMarca.ItemIndex);

    If (Not fEmptyDate(mskDtaCadIni.Text)) Then
    Begin
      qryLeads.SQL.Add('AND LDG_DTACAD >= :LDG_DTACAD_INI');
      qryLeads.ParamByName('LDG_DTACAD_INI').AsDateTime := StrToDate(mskDtaCadIni.Text);
    End;

    If (Not fEmptyDate(mskDtaCadFim.Text)) Then
    Begin
      qryLeads.SQL.Add('AND LDG_DTACAD <= :LDG_DTACAD_FIM');
      qryLeads.ParamByName('LDG_DTACAD_FIM').AsDateTime := StrToDate(mskDtaCadFim.Text);
    End;

    pAdicionaClausulaWherePreVenda;
    pAdicionaClausulaWhereMarca;
    pAdicionaClausulaWhereLinhaGrupo;
    pOrdenaConsulta;

    qryLeads.Open;
    cdsLeads.Open;

  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmConsultaLeadsCRM.pConsultaLeads]');
    End;
  End;

End;

procedure TfrmConsultaLeadsCRM.pDesabilitaBotoesPanelInferior;
begin
  btnConfirma.Enabled := False;
  btnExportaCsv.Enabled := False;
end;

procedure TfrmConsultaLeadsCRM.pAbrirCadastroLeads(const CodCli, Chave: string);
Begin
  inherited;

  If (Not pnlBotoesAgregados.Visible) Then
    Exit;

  TfrmCadLeads.fCadLeads(CodCli, pChamaOrcamento, pSetNumLead, Chave);

End;

procedure TfrmConsultaLeadsCRM.btnConfirmaClick(Sender: TObject);
Begin
  inherited;

  If (Not cdsLeads.IsEmpty) Then
  Begin
    strCodCli := cdsLeads.FieldByName('CODCLI').AsString;
    strNumDoc := cdsLeads.FieldByName('AUTOINCREM').AsString;
    blnConfirma := True;
  End;

  Close;
End;

procedure TfrmConsultaLeadsCRM.btnExibirLinhaGrupoClick(Sender: TObject);
begin
  inherited;

  pAjustarVisualizacaoGridItens;
end;

procedure TfrmConsultaLeadsCRM.btnSairBaixaClick(Sender: TObject);
Begin
  inherited;

  blnConfirma := False;

  Close;
End;

procedure TfrmConsultaLeadsCRM.cbContemMarcaChange(Sender: TObject);
begin
  inherited;

  If cbContemMarca.ItemIndex = 2 Then
  Begin
    edtCodMar.Enabled := False;
    edtCodMar.Clear;
  End
  Else
    edtCodMar.Enabled := True;
end;

procedure TfrmConsultaLeadsCRM.cdsLeadsAfterScroll(
  DataSet: TDataSet);
Begin
  inherited;

  If FCarregando Then
    Exit;

  If Not DataSet.IsEmpty Then
  Begin
    pHabilitaBotoesPanelInferior;
    pCarregaItensLeads;
    pPreencherTotalPrevisaoOrcamento;
    pSetFocus(dbgLeads);
  End
  Else
    pDesabilitaBotoesPanelInferior;
End;

procedure TfrmConsultaLeadsCRM.dbgLeadsDBTableView1CellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  pHabilitaBotoesPanelInferior;
  pCarregaItensLeads;
  pPreencherTotalPrevisaoOrcamento;
end;

procedure TfrmConsultaLeadsCRM.dbgLeadsDBTableView1ColumnHeaderClick(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;

  cdsLeads.IndexFieldNames := TcxGridDBColumn(AColumn).DataBinding.FieldName;
end;

procedure TfrmConsultaLeadsCRM.dbgLeadsDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If Odd(AViewInfo.GridRecord.Index) Then
  Begin
    If (AViewInfo.GridRecord.Selected) Then
    Begin
      If AViewInfo.GridView.Site.Focused Then
      Begin
        ACanvas.Font.Color := clWhite;
      End
      Else
      Begin
        ACanvas.Brush.Color := TcxGridDBTableViewCitel(Sender).CorZebra;
      End;
    End
    Else
    Begin
      ACanvas.Brush.Color := TcxGridDBTableViewCitel(Sender).CorZebra;
    End;
  End;
end;

procedure TfrmConsultaLeadsCRM.dbgLeadsDBTableView1DblClick(
  Sender: TObject);
Begin
  inherited;

  btnConfirma.Click;
End;

procedure TfrmConsultaLeadsCRM.dbgLeadsDBTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
Begin
  inherited;

  If FCarregando Then
    Exit;

  case Key  of
    VK_RETURN : btnConfirma.Click;
  end;
End;

procedure TfrmConsultaLeadsCRM.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
Begin
  Accept := (Pos(strValFil, DataSet.FieldByName(strCamFil).AsString) > 0);
End;

procedure TfrmConsultaLeadsCRM.pHabilitaBotoesPanelInferior;
begin
  btnConfirma.Enabled := True;
  btnExportaCsv.Enabled := True;
end;

procedure TfrmConsultaLeadsCRM.pOrdenaConsulta;
var
  strOrd,
  strSQL: String;
begin
  If cbOrdemExibicao.ItemIndex <= 0 Then
    Exit;

  strOrd := arrOrdSQLCnsL[TLeads.IndiceToTipoOrdenacao(cbOrdemExibicao.ItemIndex)];

  If Not fEmptyStr(strOrd) Then
  Begin
    strSQL := ' ORDER BY ' + strOrd;
    qryLeads.SQL.Add(strSQL);
  End;

end;

procedure TfrmConsultaLeadsCRM.pOrdenaGrid;
var
  strOrd: String;
Begin
  If cbOrdemExibicao.ItemIndex > 0 Then
  Begin
    strOrd := arrOrdSQLCnsL[TLeads.IndiceToTipoOrdenacao(cbOrdemExibicao.ItemIndex)];
    strOrd := AnsiReplaceStr(strOrd, ',',';');
    cdsLeads.IndexFieldNames := strOrd;
  End;
End;

procedure TfrmConsultaLeadsCRM.pCarregaPesquisaLeads;
begin
  If Not fVerificaCampos Then
    Exit;

  FCarregando := True;
  TfrmGravando.fExecutarModal(pConsultaLeads, 'Aguarde carregando leads....', 'ConsultaLeadsCRM');

  FCarregando := False;

  If Not cdsLeads.IsEmpty Then
  Begin
    pOrdenaGrid;

    pSetFocus(dbgLeads);
    dbgLeadsDBTableView1.DataController.FocusedRowIndex := 0;
    cdsLeads.First;

    pCarregarTotais;
  End;

end;

procedure TfrmConsultaLeadsCRM.pSetNumLead(strNumLead: String);
begin
  Self.FNumLead := strNumLead;
end;

procedure TfrmConsultaLeadsCRM.pStatusMarcados;
var
  intCnt: Integer;
begin
  SetLength(arrStatus, 0);
  For intCnt := 1 To cbStatus.Properties.Items.Count Do
  Begin
    If cbStatus.States[intCnt] = cbsChecked Then
    Begin
      SetLength(arrStatus, Length(arrStatus)+1);
      arrStatus[Length(arrStatus)-1].strCodigo :=  arrStatusLead[TLeads.IndiceToStatusLead(intCnt)];
    End;
  End;
end;

procedure TfrmConsultaLeadsCRM.pValidaCamposSemMensagem;
begin
  VS_ExibirMensagemAoUsuario := False;
  Try
    VS_ExibirMensagemAoUsuario := fVerificaCampos;
  Finally
    VS_ExibirMensagemAoUsuario := True;
  End;
end;

procedure TfrmConsultaLeadsCRM.pCarregaItensLeads;
const
  strSQLItens  = ' SELECT LDD_LINGRU,               ' +
                 '        LDD_SEQGER,               ' +
                 '        GRU_DESGRU AS DESGRU,     ' +
                 '        LDD_VALPRE,               ' +
                 '        LDD_OBSERV,               ' +
                 '        LDD_KAMFOR,               ' +
                 '        LDD_KAFORN,               ' +
                 '        KAM.OPE_NOMOPE AS NOMKAM, ' +
                 '        LDD_PREVEN,               ' +
                 '        INS.OPE_NOMOPE AS NOMPVE, ' +
                 '        LDD_MOEDA_,               ' +
                 '        LDD_REGIST,               ' +
                 '        LDD_DESCON,               ' +
                 '        LDD_NUMREG,               ' +
                 '        LDD_AUTDES,               ' +
                 '        LDD_CODMAR,               ' +
                 '        MAR_DESMAR AS DESMAR      ' +
                 ' FROM LADDET                      ' +
                 '   LEFT JOIN CADOPE KAM ON KAM.OPE_CODOPE = LDD_KAMFOR ' +
                 '   LEFT JOIN CADOPE INS ON INS.OPE_CODOPE = LDD_PREVEN ' +
                 '   LEFT JOIN CADGRU GRU ON GRU.GRU_CODGRU = LDD_LINGRU ' +
                 '   LEFT JOIN CADMAR MAR ON MAR.MAR_CODMAR = LDD_CODMAR ' +
                 ' WHERE LDD_SEQGER = :SEQGER                            ';
Begin

  cdsItens.Close;
  qryItens.SQL.Clear;
  qryItens.SQL.Add(strSQLItens);
  qryItens.ParamByName('SEQGER').AsString := cdsLeads.FieldByName('AUTOINCREM').AsString;

  qryItens.Open;
  cdsItens.Open;

End;

procedure TfrmConsultaLeadsCRM.pExpandirGridItens;
Begin
  FEstadoGridItens := tpExpandido;
  pnlItens.Height := TamanhoPanelItensOriginal;
  cbExibirLinhaGrupo.Checked := False;
  btnExibirLinhaGrupo.Caption := 'Ocultar Linha/Grupo[F3]';
End;

procedure TfrmConsultaLeadsCRM.pRecolherGridItens;
Begin
  FEstadoGridItens := tpRecolhido;
  pnlItens.Height := 0;
  cbExibirLinhaGrupo.Checked := True;
  btnExibirLinhaGrupo.Caption := 'Exibir Linha/Grupo[F3]';
End;

procedure TfrmConsultaLeadsCRM.pAjustarVisualizacaoGridItens;
Begin
  Case FEstadoGridItens of
    tpExpandido: pRecolherGridItens;
    tpRecolhido: pExpandirGridItens;
  End;
End;

procedure TfrmConsultaLeadsCRM.btnExportaCSVClick(Sender: TObject);
var
  strNomeArquivo,
  strNomeArquivoItens: string;
begin
  inherited;

  SaveDialog1.Filter := 'Arquivo (*.csv)';
  SaveDialog1.Title := 'Consulta de Leads';
  SaveDialog1.DefaultExt := 'csv';
  SaveDialog1.FileName := 'Consulta_Leads';

  If SaveDialog1.Execute Then
  Begin
    strNomeArquivo := SaveDialog1.FileName;
    strNomeArquivoItens := ExtractFilePath(SaveDialog1.FileName) + 'itens_' + ExtractFileName(SaveDialog1.FileName);

    ExportGridToCSV(strNomeArquivo, dbgLeads, True, True,';');
    If FileExists( strNomeArquivo ) Then
    Begin
      fMensagem('AVISO!', 'Exportação consulta de Leads efetuada com sucesso!', ['&Ok']);
    End;

    If Not cdsItens.IsEmpty Then
    Begin
      ExportGridToCSV(strNomeArquivoItens, cxGridItens, True, True,';');
      If FileExists( strNomeArquivoItens ) Then
      Begin
        fMensagem('AVISO!', 'Exportação dos itens do Lead efetuada com sucesso!', ['&Ok']);
      End;
    End;
  End;

end;

procedure TfrmConsultaLeadsCRM.pPreencherTotalPrevisaoOrcamento;
begin
  edtTotPrev.Text := FormatFloat('#,##0.0000', fDoubleAggregate(cdsItens, 'VLR_PREVIS'));
end;

procedure TfrmConsultaLeadsCRM.btnLarColClick(Sender: TObject);
begin
  inherited;

  FCfgTela.pGravarDadosNoBanco(dbgLeadsDBTableView1, cdsColOrd);
  FCfgTela.pGravarDadosNoBanco(cxGridItensView, cdsColOrdItens);

end;

procedure TfrmConsultaLeadsCRM.btnPadraoClick(Sender: TObject);
begin
  inherited;

  pAjustaColunas(dbgLeadsDBTableView1, cdsLeads);
  pAjustaColunas(cxGridItensView, cdsItens);
end;

procedure TfrmConsultaLeadsCRM.pAjustaColunas(cxConsultaView: TcxGridDBTableView;
 cdsConsulta: TUniClientDataSet);
begin
  Application.ProcessMessages;

  If Not cdsConsulta.IsEmpty Then
    cxConsultaView.ApplyBestFit;

end;


End.

