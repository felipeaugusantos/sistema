unit untCadTabelaPrecosItem;

interface

uses
  Windows, Classes, Controls, Forms, untPaiConfirma, AppEvnts, Menus, StdCtrls,
  Buttons, ExtCtrls, EditFocus, DBCtrls, DBEditFocus, DB, Uni,
  untTabelaPreco, ComCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, MaskEditFocus,
  BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, Mask, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, QColorLabel,
  ComboBoxFocus, cxGridBandedTableView, cxGridDBBandedTableView,
  cxDBLookupComboBox, cxTextEdit, cxEditRepositoryItems, cxCurrencyEdit,
  cxContainer, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  untTabelasDoItemFrame, untTabelasDoItem, untTypesTabelaPreco, cxLabel;

type
  TfrmCadTabelaPrecosItem = class(TfrmPaiConfirma)
    dtsItens: TDataSource;
    pgcItens: TPageControl;
    tbsFiltros: TTabSheet;
    tbsDados: TTabSheet;
    pnlDados1: TPanel;
    Label8: TLabel;
    Label1: TLabel;
    Label49: TLabel;
    Label32: TLabel;
    Label118: TLabel;
    lblUniCom: TLabel;
    Label147: TLabel;
    dbeCodFab: TDBEditFocus;
    dbeDesFab: TDBEditFocus;
    dbeClaIpi: TDBEditFocus;
    dbeCodAbr: TDBEditFocus;
    edtDesAbf: TEditFocus;
    dbeMultCompra: TDBEditFocus;
    dbeUniCom: TDBEditFocus;
    edtDesUniCom: TEditFocus;
    dbeDiaFor: TDBEditFocus;
    pnlFiltros: TPanel;
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    Label2: TLabel;
    edtRefere: TEditFocus;
    Label3: TLabel;
    edtDesIte: TEditFocus;
    Label4: TLabel;
    edtCodUni: TEditFocus;
    Label5: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    Label6: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    Label9: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    pnlDados2: TPanel;
    pnlItem: TPanel;
    Label7: TLabel;
    dbeCodIte: TDBEditFocus;
    dbeDesIte: TDBEditFocus;
    dtsIteSel: TDataSource;
    cxgItensCodIte: TcxGridDBColumn;
    cxgItensViewColumn2: TcxGridDBColumn;
    cxgItensViewColumn3: TcxGridDBColumn;
    cxgItensViewColumn4: TcxGridDBColumn;
    cxgItensViewColumn5: TcxGridDBColumn;
    cxgItensViewColumn6: TcxGridDBColumn;
    btnExcluiItem: TBitBtnLocked;
    Label48: TLabel;
    Label50: TLabel;
    shpRefere: TShape;
    dbeRefere: TDBEditFocus;
    dbeBarEmb: TDBEditFocus;
    Label55: TLabel;
    dbeAbfPis: TDBEditFocus;
    edtDesPis: TEditFocus;
    shpAbfPis: TShape;
    Label56: TLabel;
    dbePesoIt: TDBEditFocus;
    shpPesoIt: TShape;
    shpCodAbf: TShape;
    Label52: TLabel;
    dbeAbfIpi: TDBEditFocus;
    edtDesIpi: TEditFocus;
    Label54: TLabel;
    dbeAbfCof: TDBEditFocus;
    shpAbfCof: TShape;
    edtDesCof: TEditFocus;
    shpClaIpi: TShape;
    shpMltCom: TShape;
    shpCodFab: TShape;
    Label51: TLabel;
    dbeEmbala: TDBEditFocus;
    lbl1: TLabel;
    dbeCodBar: TDBEditFocus;
    lbl14: TLabel;
    dbeNotEsp: TDBEditFocus;
    shpNotEsp: TShape;
    ColorLabel15: TColorLabel;
    shpCobBar: TShape;
    shpUniCom: TShape;
    pnlSitPro: TPanel;
    lblSitPro: TLabel;
    shpSitPro: TShape;
    dbeSitPro: TDBEditFocus;
    edtSitPro: TEditFocus;
    lbl50: TLabel;
    dbeExcIpi: TDBEditFocus;
    dtsTabDet: TDataSource;
    Label58: TLabel;
    dbeGruPro: TDBEditFocus;
    edtDesGrp: TEditFocus;
    tbsAltGlobal: TTabSheet;
    pnlTopo: TPanel;
    lbl4: TLabel;
    pnlHeranca: TPanel;
    lbl8: TLabel;
    btnHeranca: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    btnMarDes: TBitBtnLocked;
    btnExcel: TBitBtnLocked;
    cxgDadosPorEmpresaLevel1: TcxGridLevel;
    cxgDadosPorEmpresa: TcxGrid;
    cxvDadosPorEmpresa: TcxGridDBBandedTableView;
    cxvDadosPorEmpresaCODITE: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaDESITE: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaCODFAB: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaSIGUNI: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaPRECOM: TcxGridDBBandedColumn;
    cxstylesTabelasPreco: TcxStyleRepository;
    cxsZebra: TcxStyle;
    cxsEnfaseCusto: TcxStyle;
    cxsPorEmpresa: TcxStyle;
    cxvDadosPorEmpresaICMENT: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaCONLIQ: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaDESF06: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaDESF05: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaDESF04: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaDESF03: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaDESF02: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaDESF01: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaSUBFED: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaIPIENT: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaVALFRE: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaFREENT: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaACRFIN: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaSUBSTI: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaDESADB: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaPRECUS: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaOUTVAL: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaICMSAI: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaIMPFED: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaDESOPE: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaCUSREA: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaMARBRU: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaCOMTBL: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaPREVEN: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaPREREV: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaDESREV: TcxGridDBBandedColumn;
    cxlFiltroEmpresa: TcxLookupComboBox;
    prbProgresso: TProgressBar;
    cxvDadosPorEmpresaPRINC: TcxGridDBBandedColumn;
    tbsAltComuns: TTabSheet;
    Panel4: TPanel;
    btnExcelComuns: TBitBtnLocked;
    cxgDadosComuns: TcxGrid;
    cxvDadosComuns: TcxGridDBBandedTableView;
    cxvDadosComunsCODITE: TcxGridDBBandedColumn;
    cxvDadosComunsDESITE: TcxGridDBBandedColumn;
    cxvDadosComunsCODFAB: TcxGridDBBandedColumn;
    cxGridLevel1: TcxGridLevel;
    cxvDadosComunsREFERE: TcxGridDBBandedColumn;
    cxvDadosComunsSITPRO: TcxGridDBBandedColumn;
    cxvDadosComunsBAREMB: TcxGridDBBandedColumn;
    cxvDadosComunsEMBALA: TcxGridDBBandedColumn;
    cxvDadosComunsCODBAR: TcxGridDBBandedColumn;
    cxvDadosComunsCLAIPI: TcxGridDBBandedColumn;
    cxvDadosComunsPESOIT: TcxGridDBBandedColumn;
    cxvDadosComunsDIAFOR: TcxGridDBBandedColumn;
    cxvDadosComunsNOTESP: TcxGridDBBandedColumn;
    cxvDadosComunsUNICOM: TcxGridDBBandedColumn;
    cxvDadosComunsMLTCOM: TcxGridDBBandedColumn;
    cxvDadosComunsPRDGRU: TcxGridDBBandedColumn;
    cxvDadosComunsPRINC: TcxGridDBBandedColumn;
    cxEditRepository: TcxEditRepository;
    btnPesquisaGrid: TcxEditRepositoryButtonItem;
    tbsPreVen: TTabSheet;
    Label46: TLabel;
    rdgMarPre: TRadioGroup;
    cxgPreVen: TcxGrid;
    cxgPreVenView: TcxGridDBTableView;
    cxvPreVen: TcxGridDBBandedTableView;
    cxvPreVenColumn1: TcxGridDBBandedColumn;
    cxcPreVenMARORI: TcxGridDBBandedColumn;
    cxcPreVenMARBRU: TcxGridDBBandedColumn;
    cxvPreVenColumn5: TcxGridDBBandedColumn;
    cxvPreVenColumn4: TcxGridDBBandedColumn;
    cxvPreVenColumn6: TcxGridDBBandedColumn;
    cxgPreVenLevel1: TcxGridLevel;
    dbePreCus2: TDBEditFocus;
    cxvDadosPorEmpresaABFICM: TcxGridDBBandedColumn;
    pnlPrecos: TPanel;
    pnlPrecom: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    Label33: TLabel;
    Label15: TLabel;
    Label34: TLabel;
    Label16: TLabel;
    Label35: TLabel;
    Label17: TLabel;
    Label36: TLabel;
    Label18: TLabel;
    Label37: TLabel;
    Label19: TLabel;
    Label38: TLabel;
    Label137: TLabel;
    Label20: TLabel;
    Label39: TLabel;
    Label135: TLabel;
    Label136: TLabel;
    Label21: TLabel;
    Label40: TLabel;
    Label22: TLabel;
    Label41: TLabel;
    lblValFre: TLabel;
    Label23: TLabel;
    Label42: TLabel;
    Label24: TLabel;
    Label43: TLabel;
    lblDesAdi: TLabel;
    Label133: TLabel;
    dbePreCom: TDBEditFocus;
    dbeDesf01: TDBEditFocus;
    dbeDesf02: TDBEditFocus;
    dbeDesf03: TDBEditFocus;
    dbeDesf04: TDBEditFocus;
    dbeDesf05: TDBEditFocus;
    dbeDesf06: TDBEditFocus;
    dbeIcmEnt: TDBEditFocus;
    dbeSubFed: TDBEditFocus;
    dbeIpiEnt: TDBEditFocus;
    dbeFreEnt: TDBEditFocus;
    dbeValFre: TDBEditFocus;
    dbeSubsti: TDBEditFocus;
    dbeDesAdb: TDBEditFocus;
    dbeAcrFin: TDBEditFocus;
    chkPreDol: TDBCheckBox;
    dbeComLiq: TDBEditFocus;
    pnlSuframa: TPanel;
    Label221: TLabel;
    Label222: TLabel;
    Label223: TLabel;
    Label224: TLabel;
    Label225: TLabel;
    Label227: TLabel;
    Label228: TLabel;
    Label229: TLabel;
    Label230: TLabel;
    Label231: TLabel;
    dbeTCIFCu: TDBEditFocus;
    dbeTSCust: TDBEditFocus;
    dbeDePiCo: TDBEditFocus;
    dbeDeICMS: TDBEditFocus;
    dbeFatReg: TDBEditFocus;
    pnlPrecoCusto: TPanel;
    Panel1: TPanel;
    Label26: TLabel;
    lblOutVal: TLabel;
    Label25: TLabel;
    Label28: TLabel;
    Label66: TLabel;
    Label138: TLabel;
    Label44: TLabel;
    lblDesOpePer: TLabel;
    Label29: TLabel;
    dbeOutVal: TDBEditFocus;
    dbeIcmSai: TDBEditFocus;
    dbeImpFed: TDBEditFocus;
    dbeDesOpe: TDBEditFocus;
    dbeCusRea: TDBEditFocus;
    dbePreCus: TDBEditFocus;
    pnlPrecoVenda: TPanel;
    Label12: TLabel;
    Label27: TLabel;
    lblMarBr1: TLabel;
    lbl3: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lblComTbl: TLabel;
    dbeMarBru: TDBEditFocus;
    dbePreVen: TDBEditFocus;
    dbePREREV: TDBEditFocus;
    dbeDesRev: TDBEditFocus;
    dbeComTbl: TDBEditFocus;
    Panel3: TPanel;
    Panel2: TPanel;
    Label10: TLabel;
    dbeCnvCus: TDBEditFocus;
    rdgAlterarTipo: TRadioGroup;
    cxvDadosPorEmpresaColumn1: TcxGridDBBandedColumn;
    cxvDadosPorEmpresaCUSATI: TcxGridDBBandedColumn;
    pnlLegendaComuns: TPanel;
    Shape3: TShape;
    Label11: TLabel;
    shp1: TShape;
    lbl7: TLabel;
    pnlCaption: TPanel;
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure dbeCodAbrKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluiItemClick(Sender: TObject);
    procedure pgcItensChange(Sender: TObject);
    procedure edtCodForEnter(Sender: TObject);
    procedure tbsDadosShow(Sender: TObject);
    procedure dbeUniComKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure chkPreDolClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbeAbfIpiKeyPress(Sender: TObject; var Key: Char);
    procedure dbeAbfPisKeyPress(Sender: TObject; var Key: Char);
    procedure dbeAbfCofKeyPress(Sender: TObject; var Key: Char);
    procedure dbeSitProKeyPress(Sender: TObject; var Key: Char);
    procedure dbeClaIpiKeyPress(Sender: TObject; var Key: Char);
    procedure dbeExcIpiKeyPress(Sender: TObject; var Key: Char);
    procedure dbeExcIpiExit(Sender: TObject);
    procedure dbeGruProKeyPress(Sender: TObject; var Key: Char);
    procedure cxlFiltroEmpresaPropertiesCloseUp(Sender: TObject);
    procedure cxvDadosGeraisPRECOMPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnMarDesClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnHerancaClick(Sender: TObject);
    procedure cxvDadosPorEmpresaCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnPesquisaGridPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnPesquisaGridPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcelComunsClick(Sender: TObject);
    procedure rdgMarPreClick(Sender: TObject);
    procedure cxvDadosPorEmpresaABFICMPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvDadosPorEmpresaABFICMGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxvDadosPorEmpresaEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure cxvDadosPorEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure rdgAlterarTipoClick(Sender: TObject);
    procedure cxvDadosPorEmpresaCUSATIGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxvDadosPorEmpresaColumn1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure tbsAltGlobalShow(Sender: TObject);
    procedure dbeCnvCusExit(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxvDadosPorEmpresaFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure cxvDadosPorEmpresaFocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    function dbeCodIteChamaCadastro(Key: Word): string;
    function dbeCodAbrChamaCadastro(Key: Word): string;
  private
    { Private declarations }
    MSG_VALIDACAO_MARGEM,
    strMarMkp,
    strDesValFre: String;
    blnRecalculaPreco: Boolean;
    objTabelas : TTabelasDoItem;
    frmTabelasDoItem : TfrmTabelasDoItemFrame;
    FIteTmp: String;

    qryCadNcm: TUniQuery;
    Procedure pSetaComuns;

    Procedure pSetaParametrosSelecao;
    function fVerificaCamposParaGravacao: TCloseAction;

    procedure pRecalculaPrecos(blnReplica: Boolean = True; strCodAbf: String ='');
    Procedure pAbreSelecaoItens;

    function fValidaCodigoBarrasInterna(strCodBar: String): Boolean;

    function  fRetPrecoCusto: Double;
    function  fCalculaPrecoCompraLiq: Double;
    function  fCalculaCustoReal: Double;

    Function fSQLItensSelecao: String;
    procedure pReplicaAbreviacoes(AAbfIcm, AAbfPIS, AAbfCofins, AAbfIPI : String);
    function fValidaCamposDados(Sender: TWinControl;
        blnBuscaPorChave: Boolean): Boolean;

    function fValidaCamposFiltros(Sender: TWinControl;
        blnBuscaPorChave: Boolean): Boolean;

    Function fVerificaCamposFiltros: Boolean;

    function fValidaMargem: Boolean;

    Procedure pSetaAltGlobalPorEmpresa;
    Procedure pSetaAltGlobalComuns;

    Function fFindDBEditByField(AOwner: TWincontrol; Field: TField): TDBEditFocus;

    Function fGeraExelGlobalPrecos(prbProgresso: TProgressBar): Boolean;
    Function fGeraExelGlobalComuns(prbProgresso: TProgressBar): Boolean;

    Procedure pAfterScrollTabDet(dataSet: TDataSet);

    procedure pAtualizaPrecosIteger;

    Function fHeranca: Boolean;

  public
    { Public declarations }
    objTabPre: TTabelaPreco;
    blnOrigemImportacao: boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses
  Graphics,
  Variants,
  cxDataUtils,
  untGeraExcel,
  Math, StrUtils,
  SysUtils, untConstantes, untConsultas, untFuncoesSimples, untTConfiguracao,
  untSelEmpPrecos,
  untParCalculaPrecoCusto, untTypesSistema, untIteBar,
  untCalculaComposicaoCusto, untTabelasDoItemGrid,
  untFuncIns, untFuncIns2, untCadAbreviacaoFiscal;

{$R *.dfm}

procedure TfrmCadTabelaPrecosItem.btnExcelComunsClick(Sender: TObject);
begin
  inherited;

  fGeraExelGlobalComuns(prbProgresso);
end;

procedure TfrmCadTabelaPrecosItem.btnConfirmaClick(Sender: TObject);
begin
  if objTabPre.blnTabPrD Then
  If objTabPre.State In dsEditModes Then
  Begin
    objTabPre.FieldByName('PRECUS').AsFloat :=  objTabPre.cdsTabDet.FieldByName('ITE_PRECUS').AsFloat;
    objTabPre.FieldByName('PRECOM').AsFloat :=  objTabPre.cdsTabDet.FieldByName('ITE_PRECOM').AsFloat;
    objTabPre.FieldByName('COMLIQ').AsFloat :=  objTabPre.cdsTabDet.FieldByName('ITE_COMLIQ').AsFloat;
  End;
  inherited;

end;

procedure TfrmCadTabelaPrecosItem.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;

  objTabPre.pMarcaTodosTabDet(False);
  pSetFocus(cxgDadosPorEmpresa);
end;

procedure TfrmCadTabelaPrecosItem.btnExcelClick(Sender: TObject);
begin
  inherited;

  fGeraExelGlobalPrecos(prbProgresso);
end;

procedure TfrmCadTabelaPrecosItem.btnExcluiItemClick(Sender: TObject);
begin
  inherited;

  objTabPre.pExcluiItemSelecao;
end;

Function TfrmCadTabelaPrecosItem.fHeranca: Boolean;
  Var
    intContador: Integer;
    stlLista: TStringList;
Begin
  Result := False;

  If objTabPre.stlMarcados.Count = 0 Then
  Begin
    pMensagemOk('Selecione os itens que terão os preços alterados!');
    Exit;
  End;

  pCriarFormularios(TfrmSelEmpPrecos, frmSelEmpPrecos);

  frmSelEmpPrecos.objTabPre := objTabPre;

  If frmSelEmpPrecos.ShowModal = mrOk Then
  Begin
    objTabPre.strEmpOri := frmSelEmpPrecos.edtEmpOri.Text;

    stlLista := TStringList.Create;

    For intContador := Low(frmSelEmpPrecos.arrEmpDes) To High(frmSelEmpPrecos.arrEmpDes) Do
      stlLista.Add(frmSelEmpPrecos.arrEmpDes[intContador].strCodigo);

    objTabPre.strEmpDes := fCommaText(stlLista, True);

    FreeAndNil(stlLista);

    Result := objTabPre.fCopiaPrecos;
  End;

  FreeAndNil(frmSelEmpPrecos);
End;

procedure TfrmCadTabelaPrecosItem.btnHerancaClick(Sender: TObject);
begin
  inherited;

  If fHeranca Then
    objTabPre.pMarcaTodosTabDet(False);

  pSetFocus(cxgDadosPorEmpresa);
end;

procedure TfrmCadTabelaPrecosItem.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;

  objTabPre.pMarcaTodosTabDet(True);
  pSetFocus(cxgDadosPorEmpresa);

end;

procedure TfrmCadTabelaPrecosItem.btnMarDesClick(Sender: TObject);
begin
  inherited;

  objTabPre.pMarcaDesmarcaTabDet;
  pSetFocus(cxgDadosPorEmpresa);

end;

procedure TfrmCadTabelaPrecosItem.btnPesquisaGridPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  Var
    Key : Char;
    dbEdit: TDBEditFocus;

  function fIndexFocusedColumn: Integer;
    var
      intIndex: Integer;
  begin
    Result := 0;

    For intIndex := 0 To cxvDadosComuns.ColumnCount -1 Do
    Begin
      If cxvDadosComuns.Columns[intIndex].Focused Then
        Result := intIndex;
    End;
  end;

begin
  inherited;
  dbEdit := fFindDBEditByField(tbsDados, cxvDadosComuns.Columns[fIndexFocusedColumn].DataBinding.Field);

  If Assigned(dbEdit) And Assigned(dbEdit.OnKeyPress) Then
  Begin
    Key := '?';
    dbEdit.OnKeyPress(dbEdit, Key);
    cxvDadosComuns.DataController.SetEditValue(fIndexFocusedColumn, dbEdit.Text, evsValue);
  End;
end;

procedure TfrmCadTabelaPrecosItem.btnPesquisaGridPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  Var
    dbEdit  : TDBEditFocus;
begin
  inherited;

  dbEdit := fFindDBEditByField(tbsDados, TcxGridDBBandedColumn(cxvDadosComuns.Controller.FocusedColumn).DataBinding.Field);

  If Assigned(dbEdit) And (Not dbEdit.ReadOnly) Then
  Begin
    dbEdit.Text := DisplayValue;

    If (Not fValidaCamposDados(dbEdit, True)) Then
    Begin
      ErrorText := '';
      Error := True;

      If objTabPre.State = dsEdit Then
        objTabPre.Cancel;
    End;
  End;

end;

procedure TfrmCadTabelaPrecosItem.chkPreDolClick(Sender: TObject);
begin
  inherited;
  If Assigned(dtsItens.DataSet) And (dtsItens.DataSet.State in DsEditModes) Then
    pRecalculaPrecos;
end;

procedure TfrmCadTabelaPrecosItem.cxlFiltroEmpresaPropertiesCloseUp(
  Sender: TObject);
begin
  inherited;
  objTabPre.pFiltraEmpresaCorrenteTabDet(True, cxlFiltroEmpresa.EditValue);
end;

procedure TfrmCadTabelaPrecosItem.cxvDadosPorEmpresaABFICMGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  AText := AText + ' - ' + fRetDesAbfIcm(AText);
end;

procedure TfrmCadTabelaPrecosItem.cxvDadosPorEmpresaABFICMPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
Var
  dbEdtAbf  : TDBEditFocus;
begin
  inherited;
  If DisplayValue = '' then
  Begin
    ErrorText := '';
    pMensagemOk('A Abreviação Fiscal de ICMS deve ser informada!');
    Error := True;
    Exit;
  End

  Else If fRetDesAbfIcm(DisplayValue) = '' Then
  Begin
    ErrorText := '';
    pMensagemOk('A Abreviação ' + DisplayValue  + ' Fiscal informada não foi encontrada!');
    Error := True;
    Exit;
  End;

  dbEdtAbf := fFindDBEditByField(tbsDados, TcxGridDBBandedColumn(cxvDadosPorEmpresa.Controller.FocusedColumn).DataBinding.Field);

  If Assigned(dbEdtAbf) And (Not dbEdtAbf.ReadOnly) Then
  Begin
    dbEdtAbf.Text := DisplayValue;
    FIteTmp := dtsTabDet.DataSet.FieldByName('ITE_CODITE').AsString;

    If (Not fValidaCamposDados(dbEdtAbf, True)) Then
    Begin
      ErrorText := '';
      Error := True;

      If objTabPre.cdsTabDet.State = dsEdit Then
        objTabPre.cdsTabDet.Cancel;
    End;
  End;
end;

procedure TfrmCadTabelaPrecosItem.cxvDadosPorEmpresaColumn1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvDadosPorEmpresaCUSATI.Index]) = '1' Then
      ACanvas.brush.Color := clYellow
    Else
      ACanvas.brush.Color := clSilver;

end;

procedure TfrmCadTabelaPrecosItem.cxvDadosPorEmpresaCUSATIGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If AText = '1' Then
    AText := 'Sim'
  Else
    AText := 'Não';

end;

procedure TfrmCadTabelaPrecosItem.cxvDadosPorEmpresaCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If objTabPre.fItemMarcadoTabDet(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxvDadosPorEmpresaCODITE.Index])) Then
    ACanvas.Font.Color := clRed;

end;

procedure TfrmCadTabelaPrecosItem.cxvDadosPorEmpresaEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
  var qryAbf: TUniQuery;
      arrSel : TConsultasArray;
begin
  inherited;
  qryAbf := fCriaQuery;
  Try

    If AItem = cxvDadosPorEmpresaABFICM Then
    Begin
      If fPesqAbrevFiscal(Self, nil, nil, qryAbf, Key, arrSel, True) Then
      Begin
        AEdit.EditValue := qryAbf.FieldByname('ABF_CODABF').AsString;
        IF cxvDadosPorEmpresa.DataController.DataSource.DataSet.State in dsEditModes Then
          cxvDadosPorEmpresa.DataController.DataSource.DataSet.FieldByName('ITE_CODABF').AsString  := qryAbf.FieldByname('ABF_CODABF').AsString
        Else
        Begin
          cxvDadosPorEmpresa.DataController.DataSource.DataSet.Edit;
          cxvDadosPorEmpresa.DataController.DataSource.DataSet.FieldByName('ITE_CODABF').AsString  := qryAbf.FieldByname('ABF_CODABF').AsString;
          cxvDadosPorEmpresa.DataController.DataSource.DataSet.Post;
        End;
      End;
    End;
  Finally
    FreeAndNil(qryAbf);
  End;

end;

procedure TfrmCadTabelaPrecosItem.cxvDadosPorEmpresaFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  objTabelas.strCampoFocado := TcxGridDBBandedColumn(AFocusedItem).DataBinding.FieldName;

end;

procedure TfrmCadTabelaPrecosItem.cxvDadosPorEmpresaFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  inherited;
  If Assigned(objTabelas) Then
    objTabelas.strCodIteFocado := cxvDadosPorEmpresa.DataController.DataSource.DataSet.FieldByName('ITE_CODITE').AsString;
end;

procedure TfrmCadTabelaPrecosItem.cxvDadosPorEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  var qryAbf: TUniQuery;
      arrSel : TConsultasArray;
begin
  inherited;
  qryAbf := fCriaQuery;
  Try

    If  cxvDadosPorEmpresaABFICM.Focused Then
    Begin
      If fPesqAbrevFiscal(Self, nil, nil, qryAbf, Key, arrSel, True) Then
      Begin
        IF cxvDadosPorEmpresa.DataController.DataSource.DataSet.State in dsEditModes Then
          cxvDadosPorEmpresa.DataController.DataSource.DataSet.FieldByName('ITE_CODABF').AsString  := qryAbf.FieldByname('ABF_CODABF').AsString
        Else
        Begin
          cxvDadosPorEmpresa.DataController.DataSource.DataSet.Edit;
          cxvDadosPorEmpresa.DataController.DataSource.DataSet.FieldByName('ITE_CODABF').AsString  := qryAbf.FieldByname('ABF_CODABF').AsString;
          cxvDadosPorEmpresa.DataController.DataSource.DataSet.Post;
        End;
      End;
    End;
  Finally
    FreeAndNil(qryAbf);
  End;
end;

procedure TfrmCadTabelaPrecosItem.cxvDadosGeraisPRECOMPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  Var
    dbEdit  : TDBEditFocus;
begin
  inherited;

  dbEdit := fFindDBEditByField(tbsDados, TcxGridDBBandedColumn(cxvDadosPorEmpresa.Controller.FocusedColumn).DataBinding.Field);

  If Assigned(dbEdit) And (Not dbEdit.ReadOnly) Then
  Begin
    dbEdit.Text := DisplayValue;
    dbEdit.Field.Value := DisplayValue;

    If (Not fValidaCamposDados(dbEdit, True)) Then
    Begin
      ErrorText := '';
      Error := True;

      If objTabPre.cdsTabDet.State = dsEdit Then
        objTabPre.cdsTabDet.Cancel;
    End;
  End;

end;

procedure TfrmCadTabelaPrecosItem.dbeAbfCofKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  fPesqCofSai(Self, dbeAbfCof, edtDesCof, Nil, Key, arrSel, True, 'Consultas de Abreviação de Cofins', dbeClaIpi.Text, dbeExcIpi.Text);
end;

procedure TfrmCadTabelaPrecosItem.dbeAbfIpiKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  fPesqIPISai(Self, dbeAbfIpi, Nil, Key, arrSel, True, 'Consultas de Abreviação de IPI', dbeClaIpi.Text, dbeExcIpi.Text);
end;

procedure TfrmCadTabelaPrecosItem.dbeClaIpiKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel: TConsultasArray;
  prcAfterPost,
  prcBeforePost: TprcScroll;
begin
  inherited;

  If fPesqNCM(Self.Name, qryCadNcm, Key, arrSel) Then
  Begin
    dbeClaIpi.Text := qryCadNcm.FieldByName('NCM_CODNCM').AsString;

    If (pgcItens.ActivePage = tbsAltComuns) And
        objTabPre.cdsTabDet.Locate('ITE_CODITE;ITE_CODEMP', VarArrayOf([objTabPre.FieldByName('ITE_CODITE').AsString, VS_strCodEmp]), []) Then
    Begin
      If (Not (dbeExcIpi.DataSource.State In dsEditModes)) Then
        dbeExcIpi.DataSource.Edit;
    End;

    If dbeExcIpi.DataSource.State In dsEditModes Then
      dbeExcIpi.Field.AsString := qryCadNcm.FieldByName('NCM_CODEXC').AsString;

    If fValidaCampos(dbeClaIpi) Then
    Begin
      If fValidaCampos(dbeExcIpi) Then
      Begin
        If (pgcItens.ActivePage = tbsAltComuns) And (dbeExcIpi.DataSource.State In dsEditModes) Then
        Begin
          prcAfterPost :=  dbeExcIpi.DataSource.DataSet.AfterPost;
          prcBeforePost := dbeExcIpi.DataSource.DataSet.BeforePost;

          dbeExcIpi.DataSource.DataSet.BeforePost := Nil;
          dbeExcIpi.DataSource.DataSet.AfterPost  := Nil;
          dbeExcIpi.DataSource.DataSet.Post;

          dbeExcIpi.DataSource.DataSet.AfterPost  := prcAfterPost;
          dbeExcIpi.DataSource.DataSet.BeforePost := prcBeforePost;
        End;

        If (pgcItens.ActivePage = tbsDados) Then
          SelectNext(dbeExcIpi, True, True);
      End

      Else If (pgcItens.ActivePage = tbsAltComuns) Then
      Begin
        pgcItens.ActivePage := tbsDados;
        pSetFocus(dbeExcIpi);
      End;

    End;
  End;

end;

procedure TfrmCadTabelaPrecosItem.dbeCnvCusExit(Sender: TObject);
var fltCnv: Double;
begin
  inherited;
  If Assigned(objTabelas) Then
  Begin
    If fEmptyStr(dbeCnvCus.Text) Then
      fltCnv := 1
    Else
      fltCnv := fStrToFloat(dbeCnvCus.Text);
    objTabelas.pReplicaCNV(fltCnv);
  End;
end;

function TfrmCadTabelaPrecosItem.dbeCodAbrChamaCadastro(Key: Word): string;
Var
  frmCadAbreviacaoFiscal: TfrmCadAbreviacaoFiscal;
begin
  inherited;
  If fIsInsert(Key) Then
  Begin
    If fVerificaAcessoSistema('frmCadAbrevFiscal') Then
    Begin
      pCriarFormularios(TfrmCadAbreviacaoFiscal, frmCadAbreviacaoFiscal);
      Try
        frmCadAbreviacaoFiscal.strAbrExterna := dbeCodAbr.Text;
        frmCadAbreviacaoFiscal.Showmodal;
      Finally
        FreeAndNil(frmCadAbreviacaoFiscal)
      End;
    End
    Else
      fMensagem('','Sem permissão para Cadastro de Fiscal',['&Ok']);
  End;
end;

procedure TfrmCadTabelaPrecosItem.dbeCodAbrKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If not(dbeCodAbr.DataSource.DataSet.State  in dsEditModes) Then
    dbeCodAbr.DataSource.DataSet.Edit;

  If fPesqAbrevFiscal(Self, dbeCodAbr, edtDesAbf, Nil, Key, arrSel, True, dbeClaIpi.Text, dbeExcIpi.Text) Then
  Begin
    dbeCodAbr.DataSource.DataSet.FieldByName('ITE_CODABF').AsString := fStrZero(dbeCodAbr.Text, 3);

    If fValidaCampos(dbeCodAbr, True) And (pgcItens.ActivePage = tbsDados) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadTabelaPrecosItem.dbeCodIteChamaCadastro(Key: Word): string;
begin
  inherited;
  If fIsInsert(Key) Then
  Begin
    dbeCodIte.Text := fChamaCadIte(Key, dbeCodIte.Text);
  End;
end;

procedure TfrmCadTabelaPrecosItem.dbeCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If dbeCodIte.Enabled And
     fPesqItem(conIteSimples, Self, dbeCodIte, dbeDesIte, Nil, Key, arrSel,
               True, nil, 'Consulta de Itens', '1') then
    If (fValidaCampos(dbeCodIte, True)) And (pgcItens.ActivePage = tbsDados) Then
      SelectNext(ActiveControl, True, True);

end;

procedure TfrmCadTabelaPrecosItem.dbeExcIpiExit(Sender: TObject);
begin
  inherited;

  If (Not fEmptyStr(dbeExcIpi.Text)) And (dtsItens.DataSet.State In [dsInsert, dsEdit]) Then
  Begin
    If dtsItens.DataSet.State In dsEditModes Then
      dtsItens.DataSet.FieldByName('ITE_EXCIPI').AsString := fStrZero(dbeExcIpi.Text, 3);
    dbeExcIpi.Text := fStrZero(dbeExcIpi.Text, 3);
  End;
end;

procedure TfrmCadTabelaPrecosItem.dbeExcIpiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If Not CharInSet(Key, ['0'..'9', #8]) Then
    Key := #0;

end;

procedure TfrmCadTabelaPrecosItem.dbeGruProKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrGrupoProd: TConsultasArray;
begin
  inherited;

  If fPesqGrupoProduto(Self, dbeGruPro, edtDesGrp, Nil, Key, arrGrupoProd, True, objTabPre.strCodForDef) Then
  Begin
    If fValidaCampos(dbeGruPro, True) And (activeControl = dbeGruPro) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadTabelaPrecosItem.dbeSitProKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqSituacaoProduto(Self,
                          dbeSitPro,
                          edtSitPro,
                          Nil,
                          Key,
                          arrSel) And
    fValidaCampos(dbeSitPro, True) And (pgcItens.ActivePage = tbsDados) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadTabelaPrecosItem.dbeAbfPisKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  fPesqPisSai(Self, dbeAbfPis, edtDesPis, Nil, Key, arrSel, True, 'Consultas de Abreviação de Pis', dbeClaIpi.Text, dbeExcIpi.Text);
end;

procedure TfrmCadTabelaPrecosItem.dbeUniComKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrUnidades: TConsultasArray;
begin
  inherited;

  If fPesqUnidade(Self, dbeUniCom, edtDesUniCom, Nil, Nil, Key, arrUnidades) then
  begin
    If fValidaCampos(dbeUniCom, True) And (pgcItens.ActivePage = tbsDados) Then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmCadTabelaPrecosItem.edtCodForEnter(Sender: TObject);
begin
  inherited;

  blnMudarFoco := False;
end;

procedure TfrmCadTabelaPrecosItem.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) And (pgcItens.ActivePage = tbsDados) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadTabelaPrecosItem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  If (ModalResult = mrOk) Then
  Begin

    If (pgcItens.ActivePage = tbsFiltros) Then
    Begin

      If objTabPre.cdsIteSel.IsEmpty Then
      Begin
        pMensagemOk('Nemhum item selecionado para inclusão!');
      End Else
      Begin
        pgcItens.ActivePage := tbsDados;
        pSetFocus(dbeRefere);
      End;

      Action := caNone;
    End

    Else If blnOrigemImportacao and (Not objTabPre.cdsIteSel.IsEmpty) Then
    Begin
      Action := fVerificaCamposParaGravacao;
    End

    Else If (pgcItens.ActivePage = tbsDados) Then
    Begin

      If fVerificaCampos Then
      Begin
        If tbsFiltros.TabVisible And objTabPre.cdsIteSel.IsEmpty Then
        Begin
          Action := caNone;
          pMensagemOk('Nemhum item selecionado para inclusão!');
        End;

      End
      Else Action := caNone;

    End

  End Else
  Begin

    If (pgcItens.ActivePage = tbsAltGlobal) And (objTabPre.cdsIteSel.State = dsEdit) Then
    Begin
      objTabPre.cdsIteSel.Cancel;
      Action := caNone;
    End

    Else If Not fPergunta('Deseja abandonar a tarefa?') Then
      Action := caNone;

  End;

end;

procedure TfrmCadTabelaPrecosItem.FormCreate(Sender: TObject);
begin
  inherited;
  chkPreDol.OnClick := nil;
  blnRecalculaPreco := True;
  blnOrigemImportacao := False;
  qryCadNcm := fCriaQuery(Self);
  strMarMkp := fCfgSis('MARMKP');

  MSG_VALIDACAO_MARGEM := 'A soma do ( ICMS Saída + Impostos Federais + Despesas Operacionais + Margem Bruta ' + IIF(fCfgSis('PCMPRO') = '2', '+ Comissão ', '') + '  ) não pode ser superior a 100%.';

  dbeAbfPis.OnChamaCadastro := TFuncIns.fChamaCadAbreviacaoPIS;
  dbeAbfIpi.OnChamaCadastro := TFuncIns.fChamaCadAbreviacaoIPI;
  dbeAbfCof.OnChamaCadastro := TFuncIns.fChamaCadAbreviacaoCOFINS;
end;


procedure TfrmCadTabelaPrecosItem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If pgcItens.ActivePage = tbsAltGlobal Then
    Case Key Of
      VK_F5: btnMarDes.Click;
      VK_F6: btnMarcaTodos.Click;
      VK_F7: btnDesmarcaTodos.Click;
      VK_F8: btnHeranca.Click;
      VK_F9: btnExcel.Click;
    End;

  If pgcItens.ActivePage = tbsAltComuns Then
    Case Key Of
      VK_F9: btnExcelComuns.Click;
    End;

end;

procedure TfrmCadTabelaPrecosItem.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If (pgcItens.ActivePage = tbsAltComuns) And fEntraCons(Key) And
     (cxvDadosComuns.Controller.FocusedColumn.RepositoryItem = btnPesquisaGrid) Then
    Begin
      Key := #0;
      btnPesquisaGridPropertiesButtonClick(Sender, 0);
    End;

end;

procedure TfrmCadTabelaPrecosItem.FormShow(Sender: TObject);
begin
  inherited;
  pnlPrecoVenda.Visible := objTabPre.blnTabPrD;
  If Not pnlPrecoVenda.Visible Then
    Self.Height := Self.Height - 30;

  If pnlPrecoVenda.Visible Then
  Begin
    dbeComTbl.Visible := fCfgSis('PCMPRO') <> '1';
    lblComTbl.Visible := dbeComTbl.Visible;
    cxvDadosPorEmpresaCOMTBL.Visible := dbeComTbl.Visible;

    If lblComTbl.Visible Then
    Begin
      lblComTbl.Caption := fCfgSis('TCOMTB') + ':';
      cxvDadosPorEmpresaCOMTBL.Caption := AnsiReplaceStr(lblComTbl.Caption, ':', '');
    End;
  End;

  If Not objTabPre.blnTabPrD Then
    chkPreDol.OnClick := chkPreDolClick;

  chkPreDol.Visible := fCfgSis('COTDOR', VarBoolean);

  edtDesUniCom.Text := fRetNomUnidade(dbeUniCom.Text);
  edtDesAbf.Text    := fRetDesAbfIcm(dbeCodAbr.Text);
  edtDesPis.Text    := fRetDesAbfPis(dbeAbfPis.Text);
  edtDesIpi.Text    := fRetDesAbfIpi(dbeAbfIpi.Text);
  edtDesCof.Text    := fRetDesAbfCof(dbeAbfCof.Text);
  edtSitPro.Text    := fRetNomSituacaoProduto(dbeSitPro.Text);
  edtDesGrp.Text    := fRetNomeGrupoProduto(dbeGruPro.Text);

  If Assigned(dtsItens.DataSet) And (dtsItens.DataSet.State in DsEditModes) Then
  Begin
    If (Not chkPreDol.Visible) Then
      chkPreDol.Checked := False;
  End;

  If pnlItem.Enabled Then
    pSetFocus(dbeCodIte)
  Else
    pSetFocus(dbeRefere);

  lblOutVal.Caption := fCfgSis('DOVCPP') + ' (+):';
  cxvDadosPorEmpresaOUTVAL.Caption := AnsiReplaceStr(lblOutVal.Caption, ':', '');

  lblDesAdi.Caption := fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + '):';
  cxvDadosPorEmpresaDESADB.Caption := AnsiReplaceStr(lblDesAdi.Caption, ':', '');

  If objTabPre.blnSufram and (objTabPre.strFrmCus = '4') then
  begin
    pnlSuframa.Visible := True;
    pnlPrecoCusto.Left := 766;
  end
  else
  begin
    pnlSuframa.Visible := False;
    pnlPrecoCusto.Left := 526;
  end;

  strDesValFre := fCfgSis('DESVFR');
  lblValFre.Caption := strDesValFre + ' (+):';
  cxvDadosPorEmpresaVALFRE.Caption := strDesValFre + ' (+)';

//  If objTabPre.intTipAbf = 2 Then
//  Begin
    dbeCodAbr.DataSource := dtsTabDet;
//  End Else
//  Begin
//    dbeCodAbr.DataSource := dtsItens;
//  End;

 (* If fCfgSis('TPABPC') = '2' Then
  Begin *)
    dbeAbfPis.DataSource := dtsTabDet;
    dbeAbfCof.DataSource := dtsTabDet;
    dbeAbfIpi.DataSource := dtsTabDet;
 (* End Else
  Begin
    dbeAbfPis.DataSource := dtsItens;
    dbeAbfCof.DataSource := dtsItens;
    dbeAbfIpi.DataSource := dtsItens;
  End; *)

  tbsAltGlobal.TabVisible := objTabPre.opcAlteraPreco = opcGlobalPreco;
  tbsAltComuns.TabVisible := objTabPre.opcAlteraPreco = opcGlobalComuns;

  Case objTabPre.opcAlteraPreco Of
    opcGlobalPreco : pSetaAltGlobalPorEmpresa;
    opcGlobalComuns: pSetaAltGlobalComuns;

    opcAlteraItem: Begin
                     pgcItens.ActivePage := tbsDados;

                     If Not (dtsTabDet.State In dsEditModes) Then
                       dtsTabDet.Edit;

                     If Not (dtsItens.State In dsEditModes) Then
                       dtsItens.Edit;
                    End;
  End;

  cxvPreVen.DataController.DataSource := objTabPre.cdsPreVen.dtsSource;
  If objTabPre.blnTabPrD Then
  Begin
    dbeIcmEnt.ReadOnly := True;
    dbeSubsti.ReadOnly := True;
    dbeIcmSai.ReadOnly := True;

    dbeSubFed.ReadOnly := True;
    dbeImpFed.ReadOnly := True;
    dbeDesOpe.ReadOnly := True;
    dbeOutVal.ReadOnly := True;
  End;


  tbsPreVen.TabVisible := False;

  If blnOrigemImportacao And (objTabPre.blnTabPrD) Then
  Begin
    tbsAltGlobal.TabVisible := False;
    tbsAltComuns.TabVisible := False;
    //tbsPreVen.TabVisible := False;
  End;

  If (objTabPre.blnTabPrD) and (objTabPre.blnIncluindoTabela) And (objTabPre.opcAlteraPreco = opcIncluiItem) Then
  Begin
    tbsAltGlobal.TabVisible := False;
    tbsFiltros.TabVisible := False;
    tbsAltGlobal.TabVisible := False;
    tbsAltComuns.TabVisible := False;
//    tbsPreVen.TabVisible := False;
  End;

  pSetaComuns;


  cxvDadosPorEmpresaICMENT.Options.Editing := True;
  cxvDadosPorEmpresaSUBFED.Options.Editing := True;
  cxvDadosPorEmpresaSUBSTI.Options.Editing := True;
  cxvDadosPorEmpresaOUTVAL.Options.Editing := True;
  cxvDadosPorEmpresaICMSAI.Options.Editing := True;
  cxvDadosPorEmpresaIMPFED.Options.Editing := True;
  cxvDadosPorEmpresaDESOPE.Options.Editing := True;
  rdgAlterarTipo.Visible := False;
  If  objTabPre.blnTabPrD Then
  Begin
    rdgAlterarTipo.Visible := True;
    pnlPrecom.Visible := false;
    pnlSuframa.Visible := false;
    pnlPrecoCusto.Visible := false;
    cxvDadosPorEmpresaICMENT.Options.Editing := False;
    cxvDadosPorEmpresaSUBFED.Options.Editing := False;
    cxvDadosPorEmpresaSUBSTI.Options.Editing := False;
    cxvDadosPorEmpresaOUTVAL.Options.Editing := False;
    cxvDadosPorEmpresaICMSAI.Options.Editing := False;
    cxvDadosPorEmpresaIMPFED.Options.Editing := False;
    cxvDadosPorEmpresaDESOPE.Options.Editing := False;


    objTabelas := TTabelasDoItem.Create(Self, dtsItens.DataSet, dtsTabDet.DataSet);
    If objTabPre.FopcMarPre = opcMargem Then
      rdgAlterarTipo.ItemIndex := 0
    Else
      rdgAlterarTipo.ItemIndex := 1;
//    objTabelas.dbeCodFor := dbeCodFor;
//    objTabelas.dbeIncPis := dbeIncPis;
//    objTabelas.OnSetaCodAbf := OnSetaCodAbf;


    frmTabelasDoItem := TfrmTabelasDoItemFrame.Create(Self);
    frmTabelasDoItem.objTabelas := objTabelas;
    frmTabelasDoItem.frmPai := Self;
    frmTabelasDoItem.Dock(pnlPrecos, pnlPrecos.BoundsRect);
    objTabelas.blnCadTabelaPreco := True;
    Try
      objTabPre.DisableControls;
      If (objTabPre.opcAlteraPreco = opcIncluiItem) Or blnOrigemImportacao then
        objTabelas.fCarregaPrecos(False, objTabPre.FIncDet)
      Else
        objTabelas.fCarregaPrecos(False, objTabPre.cdsTabDet);
    Finally
      objTabPre.EnableControls;
    End;

    frmTabelasDoItem.cxvPrecos.OptionsData.Editing := True;
    If blnOrigemImportacao Then
    Begin
      frmTabelasDoItem.pInicializaDados(objTabPre.FIncIte, objTabPre.FIncDet, True, objTabPre.FIncDet.dtsSource);
    End
    Else
    If (objTabPre.opcAlteraPreco = opcIncluiItem)  Or blnOrigemImportacao then
      frmTabelasDoItem.pInicializaDados(objTabPre.FIncIte, objTabPre.FIncDet, True)
    Else
      frmTabelasDoItem.pInicializaDados(dtsItens.DataSet, dtsTabDet.DataSet, True);
  End;
  If tbsAltGlobal.TabVisible Then
    objTabPre.pFiltraEmpresaCorrenteTabDet(True, cxlFiltroEmpresa.EditValue);

  If objTabPre.opcAlteraPreco = opcGlobalPreco Then
    objTabelas.AlteracaoGlobalEmpresa := (pgcItens.ActivePage = tbsAltGlobal);

end;

Procedure TfrmCadTabelaPrecosItem.pSetaComuns;
Begin
  shpRefere.Visible := objTabPre.blnTabPrD;
  shpAbfPis.Visible := objTabPre.blnTabPrD;
  shpPesoIt.Visible := objTabPre.blnTabPrD;
  shpCodAbf.Visible := objTabPre.blnTabPrD;
  shpAbfCof.Visible := objTabPre.blnTabPrD;
  shpClaIpi.Visible := objTabPre.blnTabPrD;
  shpMltCom.Visible := objTabPre.blnTabPrD;
  shpCodFab.Visible := objTabPre.blnTabPrD;
  shpNotEsp.Visible := objTabPre.blnTabPrD;
  shpCobBar.Visible := objTabPre.blnTabPrD;
  shpUniCom.Visible := objTabPre.blnTabPrD;
  shpSitPro.Visible := objTabPre.blnTabPrD;

  pnlLegendaComuns.Visible := objTabPre.blnTabPrD;
End;

Procedure TfrmCadTabelaPrecosItem.pSetaAltGlobalComuns;
Begin
  cxvDadosComuns.DataController.DataSource := objTabPre.dtsSource;
  pgcItens.ActivePage := tbsAltComuns;
  Self.WindowState := wsMaximized;
end;

Procedure TfrmCadTabelaPrecosItem.pSetaAltGlobalPorEmpresa;
Begin
  objTabPre.pLimpaMasterTabDet(objTabPre.cdsTabDet);
  cxvDadosPorEmpresa.DataController.DataSource := objTabPre.cdsTabDet.dtsSource;
  dtsTabDet := objTabPre.cdsTabDet.dtsSource;
  dtsItens := objTabPre.dtsSource;
  TcxLookupComboBoxProperties(cxvDadosPorEmpresaDESITE.Properties).ListSource := objTabPre.dtsSource;
  TcxLookupComboBoxProperties(cxvDadosPorEmpresaCODFAB.Properties).ListSource := objTabPre.dtsSource;
  TcxLookupComboBoxProperties(cxvDadosPorEmpresaSIGUNI.Properties).ListSource := objTabPre.dtsSource;
  TcxLookupComboBoxProperties(cxvDadosPorEmpresaPRINC.Properties).ListSource  := objTabPre.dtsSource;

  cxlFiltroEmpresa.Properties.ListSource := objTabPre.cdsEmpresas.dtsSource;
  cxlFiltroEmpresa.EditValue := VS_strCodEmp;

  pgcItens.ActivePage := tbsAltGlobal;
  Self.WindowState := wsMaximized;
end;

function TfrmCadTabelaPrecosItem.fRetPrecoCusto: Double;
  Var
    cpcParams: TParCalculaPrecoCusto;
    blnUtilizarConversorDeMoeda: Boolean;
begin
  Try
    cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);

    If fEmptyStr(dbePreCom.Text) Then
      dbePreCom.Field.Value := 0;

    If fEmptyStr(dbeDesf01.Text) Then
      dbeDesf01.Field.Value := 0;

    If fEmptyStr(dbeDesf02.Text) Then
      dbeDesf02.Field.Value := 0;

    If fEmptyStr(dbeDesf03.Text) Then
      dbeDesf03.Field.Value := 0;

    If fEmptyStr(dbeDesf04.Text) Then
      dbeDesf04.Field.Value := 0;

    If fEmptyStr(dbeDesf05.Text) Then
      dbeDesf05.Field.Value := 0;

    If fEmptyStr(dbeDesf06.Text) Then
      dbeDesf06.Field.Value := 0;

    If fEmptyStr(dbeIcmEnt.Text) Then
      dbeIcmEnt.Field.Value := 0;

    If fEmptyStr(dbeIpiEnt.Text) Then
      dbeIpiEnt.Field.Value := 0;

    If fEmptyStr(dbeFreEnt.Text) Then
      dbeFreEnt.Field.Value := 0;

    If fEmptyStr(dbeValFre.Text) Then
      dbeValFre.Field.Value := 0;

    If fEmptyStr(dbeAcrFin.Text) Then
      dbeAcrFin.Field.Value := 0;

    If fEmptyStr(dbeSubsti.Text) Then
      dbeSubsti.Field.Value := 0;

    If fEmptyStr(dbeImpFed.Text) Then
      dbeImpFed.Field.Value := 0;

    If fEmptyStr(dbeSubFed.Text) Then
      dbeSubFed.Field.Value := 0;

    If fEmptyStr(dbeDesOpe.Text) Then
      dbeDesOpe.Field.Value := 0;

    If fEmptyStr(dbeTCIFCu.Text) Then
      dbeTCIFCu.Field.Value := 0;

    If fEmptyStr(dbeTSCust.Text) Then
      dbeTSCust.Field.Value := 0;

    If fEmptyStr(dbeDePiCo.Text) Then
      dbeDePiCo.Field.Value := 0;

    If fEmptyStr(dbeDeICMS.Text) Then
      dbeDeICMS.Field.Value := 0;

    If fEmptyStr(dbeFatReg.Text) Then
      dbeFatReg.Field.Value := 0;

    {**********************************}
    {* CALCULA PREÇOS DE CUSTO        *}
    {*******************************JB*}
    With cpcParams Do
    Begin
      curPreCom := fStrToFloat(dbePreCom.Text);
      curDesF01 := fStrToFloat(dbeDesf01.Text);
      curDesF02 := fStrToFloat(dbeDesf02.Text);
      curDesF03 := fStrToFloat(dbeDesf03.Text);
      curDesF04 := fStrToFloat(dbeDesf04.Text);
      curDesF05 := fStrToFloat(dbeDesf05.Text);
      curDesF06 := fStrToFloat(dbeDesf06.Text);
      curICMSEnt:= fStrToFloat(dbeIcmEnt.Text);
      curIPIEnt := fStrToFloat(dbeIpiEnt.Text);
      curFrete  := fStrToFloat(dbeFreEnt.Text);
      curAcrFin := fStrToFloat(dbeAcrFin.Text);
      curSubsti := fStrToFloat(dbeSubsti.Text);
      curValFre := fStrToFloat(dbeValFre.Text);
      curDesAdb := fStrToFloat(dbeDesAdb.Text);
      curSubFed := fStrToFloat(dbeSubFed.Text);

      if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
      begin
        curTCIFCu := fStrToFloat(dbeTCIFCu.Text);
        curTSCust := fStrToFloat(dbeTSCust.Text);
        curDePiCo := fStrToFloat(dbeDePiCo.Text);
        curDeICMS := fStrToFloat(dbeDeICMS.Text);
        curFatReg := fStrToFloat(dbeFatReg.Text);
      end
      else
      begin
        curTCIFCu := 0;
        curTSCust := 0;
        curDePiCo := 0;
        curDeICMS := 0;
        curFatReg := 0;
      end;
    End;

    blnUtilizarConversorDeMoeda := chkPreDol.Checked;

    Result := cpcParams.fCalculaPrecoCusto(blnUtilizarConversorDeMoeda);

  Finally
    FreeAndNil(cpcParams);
  End;

end;

function TfrmCadTabelaPrecosItem.fCalculaPrecoCompraLiq: Double;
Begin
  Result := untfuncoesSimples.fCalculaPrecoCompraLiq(fStrToFloat(dbePreCom.Text),
                                   fStrToFloat(dbeDesf01.Text),
                                   fStrToFloat(dbeDesf02.Text),
                                   fStrToFloat(dbeDesf03.Text),
                                   fStrToFloat(dbeDesf04.Text),
                                   fStrToFloat(dbeDesf05.Text),
                                   fStrToFloat(dbeDesf06.Text),
                                   objTabPre.intDecUni,
                                   chkPreDol.Checked);
End;

function TfrmCadTabelaPrecosItem.fCalculaCustoReal: Double;
Begin
  Result := untfuncoesSimples.fCalculaCustoReal(fStrToFloat(dbePreCus.Text),
                                                fStrToFloat(dbeIcmSai.Text),
                                                fStrToFloat(dbeImpFed.Text),
                                                fStrToFloat(dbeDesOpe.Text),
                                                fStrToFloat(dbeOutVal.Text));
End;

procedure TfrmCadTabelaPrecosItem.pRecalculaPrecos(blnReplica: Boolean = True; strCodAbf: String ='');
var CalculaComposicaoCusto: TCalculaComposicaoCusto;
    intRecNo: integer;
    blnIncidePis: Boolean;
    strCodIte: String;
    index, intTabela: integer;
begin
  If objTabPre.blnInclusaoItem Then
    Exit;

  If not blnRecalculaPreco then
    Exit;

  intRecNo := dtsTabDet.DataSet.RecNo;
  If (pgcItens.ActivePage = tbsDados) Or (pgcItens.ActivePage = tbsAltGlobal) Then
  Begin

    If Not (dtsTabDet.DataSet.State in dsEditModes) Then
      dtsTabDet.DataSet.Edit;

    If Not (dtsTabDet.DataSet.State in dsEditModes) Then
      dtsTabDet.DataSet.Edit;

    dtsTabDet.DataSet.FieldByName('ITE_COMLIQ').AsFloat := fCalculaPrecoCompraLiq;
    blnIncidePis := fIncidePis(dbeCodIte.Field.AsString);
    If (strCodAbf <> '') And (strCodAbf <> dbeCodAbr.Field.AsString) Then
      dbeCodAbr.Field.AsString := strCodAbf;

    CalculaComposicaoCusto := TCalculaComposicaoCusto.fCalcula(blnIncidePis,
                                                               100,
                                                               objTabPre.strCodForDef,
                                                               dbeCodAbr.Field.AsString,
                                                               dbeIpiEnt.Field.AsFloat);
    If objTabPre.blnTabPrD Then
    Begin
      Try
        If CalculaComposicaoCusto.blnSemST Then
        begin
          If Assigned(frmTabelasDoItem) Then
            frmTabelasDoItem.pGerenciaEdicaoIcmsSaida(True);
        //  dbeIcmSai.Field.Value := CalculaComposicaoCusto.AliquotaICMSSai;
          dbeIcmEnt.Field.Value := CalculaComposicaoCusto.AliquotaICMSEnt;
          dbeSubsti.Field.Value := 0;
        End
        Else
        Begin
          If Assigned(frmTabelasDoItem) Then
            frmTabelasDoItem.pGerenciaEdicaoIcmsSaida(False);
          dbeIcmSai.Field.Value := 0;
          dbeIcmEnt.Field.Value := 0;
          dbeSubsti.Field.Value := CalculaComposicaoCusto.AliquotaST;
        End;

        If Assigned(frmTabelasDoItem) Then
          frmTabelasDoItem.pGerenciaEdicaoImpostosFederais(blnIncidePis);
        If not blnIncidePis then
        Begin
          dbeImpFed.Field.Value := 0;
          dbeSubFed.Field.Value := 0;
        End;

  //      dbeImpFed.Field.Value := CalculaComposicaoCusto.ImpFed;
  //      dbeSubFed.Field.Value := CalculaComposicaoCusto.SubFed;
  //      dbeDesOpe.Field.Value := CalculaComposicaoCusto.DesOpe;
  //      dbeOutVal.Field.Value := CalculaComposicaoCusto.OutVal;
      Finally
        FreeAndNil(CalculaComposicaoCusto);
      End;
    End;


    dtsTabDet.DataSet.FieldByName('ITE_PRECUS').AsFloat := fRetPrecoCusto;
    dtsTabDet.DataSet.FieldByName('ITE_CUSREA').AsFloat := fCalculaCustoReal;

    objTabPre.pCalculaPrecoMargem(dtsTabDet.DataSet, fStrToFloat(dbeComTbl.Text));
  End;

  If objTabPre.blnTabPrD And blnReplica Then
  begin
    Try
      dtsTabDet.DataSet.DisableControls;
      intRecNo := dtsTabDet.DataSet.RecNo;
      strCodIte := dtsTabDet.DataSet.FieldByName('ITE_CODITE').AsString;
      strCodAbf := dbeCodAbr.Field.AsString;
      intTabela := dtsTabDet.DataSet.FieldByName('TABELA').AsInteger;
      dtsTabDet.DataSet.First;
      For index := 1  To 7 do
      begin
        If intTabela <> index then
        begin
          If VS_strTabPrc[index] = 'S' Then
          begin
            If dtsTabDet.DataSet.Locate('ITE_CODITE;TABELA', varArrayOf([strCodIte, index.ToString]), []) Then
            begin
              If Not (dtsTabDet.DataSet.State in dsEditModes) Then
                dtsTabDet.DataSet.Edit;
              //dbeCodAbr.Field.AsString := strCodAbf;
              pRecalculaPrecos(False, strCodAbf);
            End;
          End;
        End;
      End;


    Finally
      If intRecNo < dtsTabDet.DataSet.RecordCount Then
        dtsTabDet.DataSet.RecNo := intRecNo;
      dtsTabDet.DataSet.EnableControls;
    End;
  End;

end;

procedure TfrmCadTabelaPrecosItem.pReplicaAbreviacoes(AAbfIcm, AAbfPIS, AAbfCofins, AAbfIPI : String);
var recNo : integer;
    index, intTabela: integer;
    strCodIte: String;
begin
  If Not fCfgSis('TABPRD', VarBoolean) Then
    Exit;

  strCodIte := dtsTabDet.DataSet.FieldByName('ITE_CODITE').AsString;
  recno := dtsTabDet.DataSet.RecNo;
  intTabela := dtsTabDet.DataSet.FieldByName('TABELA').AsInteger;
  dtsTabDet.DataSet.First;
  Try
    For index := 1  To 7 do
    begin
      If intTabela <> index then
      begin
        If dtsTabDet.DataSet.Locate('ITE_CODITE;TABELA', varArrayOf([strCodIte, index.ToString]), []) Then
        begin
          dtsTabDet.DataSet.Edit;
          If fEmptyStr(AAbfIcm) Then
            dtsTabDet.DataSet.FieldByName('ITE_CODABF').Clear
          Else
            dtsTabDet.DataSet.FieldByName('ITE_CODABF').AsString := AAbfIcm;

          If fEmptyStr(AAbfPIS) Then
            dtsTabDet.DataSet.FieldByName('ITE_ABFPIS').Clear
          Else
            dtsTabDet.DataSet.FieldByName('ITE_ABFPIS').AsString := AAbfPIS;

          If fEmptyStr(AAbfCofins) Then
            dtsTabDet.DataSet.FieldByName('ITE_ABFCOF').Clear
          Else
            dtsTabDet.DataSet.FieldByName('ITE_ABFCOF').AsString := AAbfCofins;

          If fEmptyStr(AAbfIPI) Then
            dtsTabDet.DataSet.FieldByName('ITE_ABFIPI').Clear
          Else
            dtsTabDet.DataSet.FieldByName('ITE_ABFIPI').AsString := AAbfIPI;

          dtsTabDet.DataSet.Post;
        End;
      End;
    End
  finally
    dtsTabDet.DataSet.RecNo := recno;
  End;
end;

function TfrmCadTabelaPrecosItem.fValidaCodigoBarrasInterna(strCodBar: String): Boolean;
  Var
    strItem: String;
begin
  strItem := '';

  Result := fValidaCodBarra(strCodBar, dbeCodIte.Text, strItem);

  If Result Then
  Begin
    strItem := IfNull(objTabPre.dicCodBar[strCodBar], '');

    If (Not fEmptyStr(strItem)) And (strItem <> dbeCodIte.Text) Then
    Begin
      Result := False;
      strItem := strItem + ' - ' + fRetNomProduto(strItem);
    End;

  End;

  If Not Result Then
    pMensagemOk('Este código de barras já esta sendo utilizado ' +
                'pelo produto ' + #13#10 + strItem);
end;

function TfrmCadTabelaPrecosItem.fValidaMargem: Boolean;
begin
  Result := Not ((dtsTabDet.DataSet.FieldByName('ITE_MARBRU').AsFloat +
                  dtsTabDet.DataSet.FieldByName('ITE_COMTBL').AsFloat +
                  dtsTabDet.DataSet.FieldByName('ITE_ICMSAI').AsFloat +
                  dtsTabDet.DataSet.FieldByName('ITE_IMPFED').AsFloat +
                  dtsTabDet.DataSet.FieldByName('ITE_DESOPE').AsFloat) > 100);
End;

function TfrmCadTabelaPrecosItem.fValidaCamposDados(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strItem: String;
Begin
  Result := True;

  If (pgcItens.ActivePage <> tbsDados) And
     (pgcItens.ActivePage <> tbsAltComuns) And
     (pgcItens.ActivePage <> tbsAltGlobal) Then
    Exit;

  If (Sender = dbeCodIte) And pnlItem.Visible Then
  Begin

    If (fEmptyStr(dbeCodIte.Text)) And (dbeCodIte.Enabled) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código do Produto deve ser preenchido!', ['&Ok']);
      Result := False;
    End Else
    Begin

      If dtsItens.DataSet.State In dsEditModes Then
        dtsItens.DataSet.FieldByName('ITE_DESITE').AsString := fRetNomProduto(dbeCodIte.Text);

      If fEmptyStr(dtsItens.DataSet.FieldByName('ITE_DESITE').AsString) Then
      Begin
        pMensagemOk('Código do Item não econtrado!');
        Result := False;
      End Else
      Begin

        objTabPre.pCarregaItemAlteracao(dbeCodIte.Text, blnBuscaPorChave, dtsItens, dtsTabDet);
        pRecalculaPrecos;
      End;

    End;

  End

  Else If (Sender = dbeBarEmb) Then
  Begin

    If Not fEmptyStr(dbeBarEmb.Text) Then
    Begin
      dbeEmbala.Enabled := True;
      Result := fValidaCodigoBarrasInterna(dbeBarEmb.Text);
    End Else
    Begin
      If dbeEmbala.DataSource.State In dsEditModes Then
        dbeEmbala.Field.Clear;
      dbeEmbala.Enabled := False;
    End;

  End

  Else If (Sender = dbeEmbala) Then
  Begin

    If dbeEmbala.Enabled And (Not fEmptyStr(dbeBarEmb.Text)) Then
    Begin

      If fStrToFloat(dbeEmbala.Text) < 0 Then
      Begin
        Result := False;
        pMensagemOk('A quantidade na embalagem deve ser maior que zero!');
      End;

    End

    Else If dbeEmbala.DataSource.State In dsEditModes Then
           dbeEmbala.Field.Clear;

  End

  Else If (Sender = dbeCodFab) Then
  Begin

    If Not fEmptyStr(dbeCodFab.Text) Then
    Begin
      strItem := IfNull(objTabPre.dicCodFab[dbeCodFab.Text], '');

      If (Not fEmptyStr(strItem)) And (strItem <> dbeCodIte.Text) Then
      Begin
        Result := False;
        strItem := strItem + ' - ' + fRetNomProduto(strItem);
      End;

      If Not Result Then
        pMensagemOk('Este código de Fábrica já esta sendo utilizado ' +
                    'pelo produto ' + #13#10 + strItem);
    End;

  End

  Else If (Sender = dbeMultCompra) Then
  Begin
    If (fStrToFloat(dbeMultCompra.Text) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Múltiplo de Compra deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbePesoIt) Then
  Begin

    If Not (RoundTo(fStrToFloat(dbePesoIt.Text),-3) > 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Peso do Item deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeNotEsp) Then
  Begin

    If Pos(dbeNotEsp.Text, 'SN') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Permitir este item em Nota Especial deve ser S ou N!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeDiaFor) Then
  Begin

    If StrToIntDef(dbeDiaFor.Text, -1) < 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Dias para entrega do fornecedor dever ser maior ou igual a zero!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeClaIpi) Then
  Begin
    If Not fEmptyStr(dbeClaIpi.Text) And (Length(dbeClaIpi.Text) <> MAX_CLAIPI) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Classificação de IPI deve ter ' + IntToStr(MAX_CLAIPI) +  ' caracteres!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeExcIpi) Then
  Begin
    If Not fEmptyStr(dbeExcIpi.Text) Then
    Begin
      If (StrToIntDef(dbeExcIpi.Text, 0) <= 0) Or
         (StrToIntDef(dbeExcIpi.Text, 0)  > 11) Then
      Begin
        fMensagem('', 'O campo EX IPI deve ser (vazio) ou estar na faixa de 1 até 11!', ['&OK']);
        Result := False;
      End;
    End;

    If Result And fEmptyStr(fRetDescricaoNcm(dbeClaIpi.Text, dbeExcIpi.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não foi encontrado cadastro de NCM com o Código e Exceção informados. '+
        'Verifique o "Cadastro de Nomenclatura Comum do Mercosul (NCM)"!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeCodAbr) Then
  Begin
    If fEmptyStr(dbeCodAbr.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Abreviação Fiscal deve ser preenchida!', ['&Ok']);
      Result := False;
    End Else
    Begin
      edtDesAbf.Text := fRetDesAbfIcm(dbeCodAbr.Text);
      If fEmptyStr(edtDesAbf.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Abreviação não está cadastrada!', ['&Ok']);
        Result := False;
      End

      Else If Not fAbreviacaoIcmsPermitidaParaNCM(dbeCodAbr.Text, dbeClaIpi.Text, dbeExcIpi.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Abreviação não é permitida para o NCM ' + dbeClaIpi.Text + '!', ['&Ok']);
        Result := False;
      End;

      If Result Then
      begin
        If dbeIcmSai.DataSource.DataSet.State in dsEditModes Then
          pRecalculaPrecos(True, dbeCodAbr.Text);
        If Result And blnBuscaPorChave Then
          pReplicaAbreviacoes(dbeCodAbr.Text, dbeAbfPis.Text, dbeAbfCof.Text, dbeAbfIpi.Text);
      End;
    End;
  End


  Else If (Sender = dbeAbfIpi) Then
  Begin
    If fEmptyStr(dbeAbfIpi.Text) Then
    Begin
      edtDesIpi.Clear;
    End
    Else
    Begin
      edtDesIpi.Text := fRetDesAbfIpi(dbeAbfIpi.Text);
      If fEmptyStr(edtDesIpi.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Abreviação de IPI não cadastrada!', ['&Ok']);
        Result := False;
      End
      Else If Not fAbreviacaoIpiPermitidaParaNCM(dbeAbfIpi.Text, dbeClaIpi.Text, dbeExcIpi.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Abreviação não é permitida para o NCM ' + dbeClaIpi.Text + '!', ['&Ok']);
        Result := False;
      End;

      If Result And blnBuscaPorChave Then
        pReplicaAbreviacoes(dbeCodAbr.Text, dbeAbfPis.Text, dbeAbfCof.Text, dbeAbfIpi.Text);
    End;
  End

  Else If (Sender = dbeAbfPis) Then
  Begin
    If fEmptyStr(dbeAbfPis.Text) Then
    Begin
      If dbeAbfPis.DataSource.State In dsEditModes Then
        dbeAbfPis.Field.Clear;

      edtDesPis.Clear;
    End
    Else
    Begin
      edtDesPis.Text := fRetDesAbfPis(dbeAbfPis.Text);
      If fEmptyStr(edtDesPis.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Abreviação de PIS não cadastrada!', ['&Ok']);
        Result := False;
      End
      Else If Not fAbreviacaoPisPermitidaParaNCM(dbeAbfPis.Text, dbeClaIpi.Text, dbeExcIpi.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Abreviação não é permitida para o NCM ' + dbeClaIpi.Text + '!', ['&Ok']);
        Result := False;
      End;

      If Result And blnBuscaPorChave Then
        pReplicaAbreviacoes(dbeCodAbr.Text, dbeAbfPis.Text, dbeAbfCof.Text, dbeAbfIpi.Text);
    End;
  End

  Else if (Sender = dbeAbfCof) Then
  Begin
    If fEmptyStr(dbeAbfCof.Text) Then
    Begin
      If dbeAbfCof.DataSource.State In dsEditModes Then
        dbeAbfCof.Field.Clear;

      edtDesCof.Clear;
    End
    Else
    Begin
      edtDesCof.Text := fRetDesAbfCof(dbeAbfCof.Text);
      If fEmptyStr(edtDesCof.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Abreviação de COFINS não cadastrada!', ['&Ok']);
        Result := False;
      End
      Else If Not fAbreviacaoCofinsPermitidaParaNCM(dbeAbfCof.Text, dbeClaIpi.Text, dbeExcIpi.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Abreviação não é permitida para o NCM ' + dbeClaIpi.Text + '!', ['&Ok']);
        Result := False;
      End;
      If Result And blnBuscaPorChave Then
        pReplicaAbreviacoes(dbeCodAbr.Text, dbeAbfPis.Text, dbeAbfCof.Text, dbeAbfIpi.Text);
    End;
  End

  Else If (Sender = dbeMultCompra) Then
  Begin
    If (fStrToFloat(dbeMultCompra.Text) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Múltiplo de Compra deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeUniCom) And (dbeUniCom.Visible) Then
  Begin
    If fEmptyStr(dbeUniCom.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A unidade de compra deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      edtDesUniCom.Text := fRetNomUnidade(dbeUniCom.Text);
      If fEmptyStr(edtDesUniCom.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa unidade de compra não está cadastrada!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = dbeSitPro) Then
  Begin

    If pnlSitPro.Visible Then
    Begin
      If fEmptyStr(dbeSitPro.Text) Then
      Begin
        edtSitPro.Clear;

        If dbeSitPro.DataSource.State In dsEditModes Then
          dbeSitPro.Field.Clear;

      End Else
      Begin
        edtSitPro.Text := fRetNomSituacaoProduto(dbeSitPro.Text);
        If fEmptyStr(edtSitPro.Text) Then
        Begin
          pMensagemOk('Código da Situação do Produto não econtrado!');
          Result := False;
        End;
      End;

    End;

  End

  Else If (Sender = dbeGruPro) Then
  Begin

    If fEmptyStr(dbeGruPro.Text) Then
    Begin
      edtDesGrp.Clear;

      If dbeGruPro.DataSource.State In dsEditModes Then
        dbeGruPro.Field.Clear;

    End Else
    Begin
      edtDesGrp.Text := fRetNomeGrupoProduto(dbeGruPro.Text);
      If fEmptyStr(edtDesGrp.Text) Then
      Begin
        pMensagemOk('Grupo de Produto não econtrado!');
        Result := False;
      End;
    End;

  End

  Else If (Sender = dbePreCom) Then
  Begin
    If fEmptyStr(dbePreCom.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Preço de Compra deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbePreCom.Text) < 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Preço de Compra deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pRecalculaPrecos;
    End;
  End

  Else If (Sender = dbeDesf01) Or
          (Sender = dbeDesf02) Or
          (Sender = dbeDesf03) Or
          (Sender = dbeDesf04) Or
          (Sender = dbeDesf05) Or
          (Sender = dbeDesf06) Then
  Begin

    If Not fEmptyStr((Sender As TDBEditFocus).Text) Then
    Begin
      If Not fValidaEscala((Sender As TDBEditFocus).Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Desconto deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      (Sender As TDBEditFocus).Text := '0';
    End;

    pRecalculaPrecos;
  End

  Else If (Sender = dbeImpFed) Then
  Begin
    If Not fEmptyStr(dbeImpFed.Text) Then
    Begin
      If Not fValidaEscala(dbeImpFed.Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Imposto Federal deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      dbeImpFed.Text := '0';
    End;

    pRecalculaPrecos;
  End

  Else If (Sender = dbeIcmEnt) And (dbeIcmEnt.Enabled) Then
  Begin
    If Not fEmptyStr(dbeIcmEnt.Text) Then
    Begin
      If Not fValidaEscala(dbeIcmEnt.Text, 0, 100) Then
      Begin
        Result := False;
      End;
    End
    Else
    Begin
      dbeIcmEnt.Text := '0';
    End;
    pRecalculaPrecos;
  End

  Else If (Sender = dbeSubFed) And (dbeSubFed.Enabled) Then
  Begin
    If Not fEmptyStr(dbeSubFed.Text) Then
    Begin
      If Not fValidaEscala(dbeSubFed.Text, 0, 100) Then
      Begin
        Result := False;
      End;
    End
    Else
    Begin
      dbeSubFed.Text := '0';
    End;
    pRecalculaPrecos;
  End

  Else If (Sender = dbeIcmSai) And (dbeIcmSai.Enabled) Then
  Begin
    If Not fEmptyStr(dbeIcmSai.Text) Then
    Begin
      If Not fValidaEscala(dbeIcmSai.Text, 0, 100) Then
      Begin
        Result := False;
      End;
    End
    Else
    Begin
      dbeIcmSai.Text := '0';
    End;
    pRecalculaPrecos;
  End

  Else If (Sender = dbeOutVal) Then
  Begin
    If fStrToFloat(dbeOutVal.Text) < 0 Then
    Begin
      fMensagem('','O Valor do campo ' + LowerCase(fCfgSis('DOVCPP')) + ' deve ser maior ou igual à zero!', ['&Ok']);
      Result := False;
    End;
    pRecalculaPrecos;
  End

  Else If (Sender = dbeIpiEnt) Or
          (Sender = dbeAcrFin) Then
  Begin
    If Not fEmptyStr((Sender As TDBEditFocus).Text) Then
    Begin
      If Not fValidaEscala((Sender As TDBEditFocus).Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo ' + (Sender As TDBEditFocus).Field.DisplayLabel + ' deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      (Sender As TDBEditFocus).Text := '0';
    End;

    pRecalculaPrecos;
  End

  Else If (Sender = dbeFreEnt) Then
  Begin
    If Not fEmptyStr((Sender As TDBEditFocus).Text) Then
    Begin
      If Not fValidaEscala((Sender As TDBEditFocus).Text, 0, 1000) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo ' + (Sender As TDBEditFocus).Field.DisplayLabel + ' deve estar entre 0 e 1000!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      (Sender As TDBEditFocus).Text := '0';
    End;
    pRecalculaPrecos;
  End

  Else If (Sender = dbeSubsti) Then
  Begin
    If Not fEmptyStr(dbeSubsti.Text) Then
    Begin
      If Not fValidaEscala(dbeSubsti.Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo Substituição Tributária deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End
    End
    Else
    Begin
      dbeSubsti.Text := '0';
    End;
    pRecalculaPrecos;
  End

  Else If (Sender = dbeTCIFCu) And (pnlSuframa.Visible) Then
  Begin
    If Not fEmptyStr((Sender As TDBEditFocus).Text) Then
    Begin
      If Not fValidaEscala((Sender As TDBEditFocus).Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo ' + (Sender As TDBEditFocus).Field.DisplayLabel + ' deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      (Sender As TDBEditFocus).Text := '0';
    End;
    pRecalculaPrecos;
  End

  Else If (Sender = dbeTSCust) And (pnlSuframa.Visible) Then
  Begin
    If Not fEmptyStr((Sender As TDBEditFocus).Text) Then
    Begin
      If Not fValidaEscala((Sender As TDBEditFocus).Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo ' + (Sender As TDBEditFocus).Field.DisplayLabel + ' deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      (Sender As TDBEditFocus).Text := '0';
    End;
    pRecalculaPrecos;
  End

  Else If (Sender = dbeDePiCo) And (pnlSuframa.Visible) Then
  Begin
    If Not fEmptyStr((Sender As TDBEditFocus).Text) Then
    Begin
      If Not fValidaEscala((Sender As TDBEditFocus).Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo ' + (Sender As TDBEditFocus).Field.DisplayLabel + ' deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      (Sender As TDBEditFocus).Text := '0';
    End;
    pRecalculaPrecos;
  End

  Else If (Sender = dbeDeICMS) And (pnlSuframa.Visible) Then
  Begin
    If Not fEmptyStr((Sender As TDBEditFocus).Text) Then
    Begin
      If Not fValidaEscala((Sender As TDBEditFocus).Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo ' + (Sender As TDBEditFocus).Field.DisplayLabel + ' deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      (Sender As TDBEditFocus).Text := '0';
    End;
    pRecalculaPrecos;
  End

  Else If (Sender = dbeFatReg) And (pnlSuframa.Visible) Then
  Begin
    If Not fEmptyStr((Sender As TDBEditFocus).Text) Then
    Begin
      If Not fValidaEscala((Sender As TDBEditFocus).Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo ' + (Sender As TDBEditFocus).Field.DisplayLabel + ' deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      (Sender As TDBEditFocus).Text := '0';
    End;
    pRecalculaPrecos;
  End

  Else If (Sender = dbeDesAdb) Then
  Begin

    Result := fValidaPercentual(dbeDesAdb.Text, 'O ' + fCfgSis('DESADI'));

    pRecalculaPrecos;
  End

  Else If (Sender = dbeValFre) Then
  Begin
    If Not fEmptyStr(dbeValFre.Text) Then
    Begin
      If (fStrToFloat(dbeValFre.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo "' + strDesValFre + '" deve ser maior ou igual a  zero!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      dbeValFre.Text := '0';
    End;
    pRecalculaPrecos;
  End

  Else If (Sender = dbeDesOpe) Then
  Begin

    If Not fEmptyStr(dbeDesOpe.Text) Then
    Begin
      If Not objTabPre.blnTabPrD Then
      If Not fValidaEscala(dbeDesOpe.Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo Despesas Operacionais deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      dbeDesOpe.Field.AsFloat := 0.0;
    End;

    pRecalculaPrecos;
  End

  Else If (Sender = dbeComTbl) Then
  Begin

    If Not fEmptyStr(dbeComTbl.Text) Then
    Begin
      If fStrToFloat(dbeComTbl.Text) > MAX_VALMON Then
        dbeComTbl.Text := FloatToStr(MAX_VALMON);

      {*******************************************}
      {* CASO SEJA MARGEM                        *}
      {****************************************JB*}
      If (Pos(strMarMkp, '1_5_') > 0) Then
      Begin
        If (fStrToFloat(dbeComTbl.Text) >= 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'Comissão não permitida: maior ou igual a 100!', ['&Ok']);
          Result := False;
        End
        Else If (fStrToFloat(dbeComTbl.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Comissão não permitida: menor que zero!', ['&Ok']);
          Result := False;
        End
        Else If Not fValidaMargem Then
        Begin
          fMensagem('', MSG_VALIDACAO_MARGEM, ['&Ok']);
          Result := False;
        End;

      End;

    End;

    pRecalculaPrecos;
  End

  Else If (Sender = dbeCnvCus) Then
  Begin

    Result := fValidaConversorCustoFor(dbeCnvCus.Text, 'O Divisor de Conversão para Custo');

  End

End;

function TfrmCadTabelaPrecosItem.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  blnRecalculaPreco := blnBuscaPorChave;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If pgcItens.ActivePage = tbsDados Then
      Result := fValidaCamposDados(Sender, blnBuscaPorChave)
    Else
      Result := fValidaCamposFiltros(Sender, blnBuscaPorChave);

  End;

  If Not Result Then
    pSetFocus(Sender);

  blnRecalculaPreco := True;
end;

Function TfrmCadTabelaPrecosItem.fVerificaCamposFiltros: Boolean;
Begin
  Result := fValidaCampos(mskLinGru, False) And
            fValidaCampos(edtCodUni, False) And
            fValidaCampos(edtCodMar, False);
End;

function TfrmCadTabelaPrecosItem.fVerificaCamposParaGravacao: TCloseAction;
begin
  If dtsItens.DataSet.State in dsEditModes Then
    dtsItens.DataSet.Post;

  Result := caFree;

  dtsItens.DataSet.Filtered := False;
  dtsItens.DataSet.Filter := 'ITE_CODEMP = ' +QuotedStr(VS_strCodEMp);
  dtsItens.DataSet.Filtered := True;
  Try
    while not dtsItens.DataSet.Eof do
    Begin
      dtsItens.DataSet.Edit;
      If Not fVerificaCampos Then
      Begin
        Result := caNone;
        dtsItens.DataSet.Cancel;
        Exit;
      End;
      dtsItens.DataSet.Post;
      dtsItens.DataSet.Next;
    End;
  Finally
  End;
end;

function TfrmCadTabelaPrecosItem.fValidaCamposFiltros(Sender: TWinControl;
        blnBuscaPorChave: Boolean): Boolean;
Begin
  Result := True;

  If pgcItens.ActivePage <> tbsFiltros Then
    Exit;

  If (Sender = mskLinGru) Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskLinGru.Text)) Then
    Begin
      edtDesGru.Text := 'TODOS';
    End
    Else
    Begin
      edtDesGru.Text := fRetNomeLinhaGrupo(fTiraCaracEspeciais(mskLinGru.Text));

      If fEmptyStr(edtDesGru.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Linha / Grupo não está cadastrada!', ['&O k']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtDesIte) Then
  Begin
  End

  Else If (Sender = edtRefere) Then
  Begin
  End

  Else If (Sender = edtCodUni) Then
  Begin
    If (Not fEmptyStr(edtCodUni.Text)) And fEmptyStr(fRetNomUnidade(edtCodUni.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa Unidade não está cadastrada!', ['&O k']);
      Result := False;
    End;
  End

  Else If (Sender = edtCodMar) Then
  Begin
    If fEmptyStr(edtCodMar.Text) Then
    Begin
      edtDesMar.Text := 'TODOS';
    End
    Else
    Begin
      edtDesMar.Text := fRetNomMarca(edtCodMar.Text);
      If fEmptyStr(edtDesMar.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Marca não está cadastrada!', ['&O k']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtCodFor) Then
  Begin
    blnMudarFoco := False;

    If fEmptyStr(edtCodFor.Text) Then
    Begin

      edtNomFor.Text := 'TODOS';

    End
    Else
    Begin

      edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);

      If fEmptyStr(edtNomFor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&O k']);
        Result := False;
      End

    End;

    If Result And blnBuscaPorChave And fVerificaCamposFiltros Then
    Begin
      pAbreSelecaoItens;
      pSetFocus(btnConfirma);
      blnMudarFoco := False;
    End;

  End

End;

Function TfrmCadTabelaPrecosItem.fSQLItensSelecao: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  ITE_CODITE,        ';
  strSQL := strSQL + '  ITE_CODGRU,        ';
  strSQL := strSQL + '  ITE_DESITE,        ';
  strSQL := strSQL + '  ITE_REFERE,        ';
  strSQL := strSQL + '  UNI_SIGUNI,        ';
  strSQL := strSQL + '  ITE_CODFOR,        ';
  strSQL := strSQL + '  FOR_NOMFOR,        ';
  strSQL := strSQL + '  ITE_CODMAR,        ';
  strSQL := strSQL + '  MAR_DESMAR         ';

  strSQL := strSQL + ' FROM                ';
  strSQL := strSQL + '   CADITE I          ';
  strSQL := strSQL + ' LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
  strSQL := strSQL + ' LEFT JOIN CADFOR ON FOR_CODFOR = ITE_CODFOR ';
  strSQL := strSQL + ' LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ';

  strSQL := strSQL + ' WHERE               ';
  strSQL := strSQL + '   ITE_ITEATI = "S"  ';

  If Not fEmptyStr(mskLinGru.Text) Then
  Begin
    If Copy(mskLinGru.Text,3,3) = '000' then
      strSQL := strSQL + '  AND I.ITE_CODGRU LIKE :CODGRU '
    Else
      strSQL := strSQL + '  AND I.ITE_CODGRU = :CODGRU ';
  End;

  If Not fEmptyStr(edtDesIte.Text) Then
  Begin
    strSQL := strSQL + '  AND I.ITE_DESITE LIKE :DESITE ';
  End;

  If Not fEmptyStr(edtRefere.Text) Then
  Begin
    strSQL := strSQL + '  AND I.ITE_REFERE LIKE :REFERE ';
  End;

  If Not fEmptyStr(edtCodUni.Text) Then
  Begin
    strSQL := strSQL + '  AND I.ITE_CODUNI = :CODUNI ';
  End;

  If Not fEmptyStr(edtCodMar.Text) Then
  Begin
    strSQL := strSQL + '  AND I.ITE_CODMAR = :CODMAR ';
  End;

  If Not fEmptyStr(edtCodFor.Text) Then
  Begin
    strSQL := strSQL + '  AND I.ITE_CODFOR = :CODFOR ';
  End;

  Result := strSQL;
End;

Procedure TfrmCadTabelaPrecosItem.pSetaParametrosSelecao;
Begin
  With objTabPre.cdsIteSel.qryQuery Do
  Begin

    If Not fEmptyStr(mskLinGru.Text) Then
    Begin
      If Copy(mskLinGru.Text,3,3) = '000' then
        ParamByName('CODGRU').AsString := Copy(mskLinGru.Text,1,3)+'%'
      Else
        ParamByName('CODGRU').AsString := mskLinGru.Text;
    End;

    If Not fEmptyStr(edtDesIte.Text) Then
    Begin
      ParamByName('DESITE').AsString := edtDesIte.Text + '%';
    End;

    If Not fEmptyStr(edtRefere.Text) Then
    Begin
      ParamByName('REFERE').AsString := edtRefere.Text;
    End;

    If Not fEmptyStr(edtCodUni.Text) Then
    Begin
      ParamByName('CODUNI').AsString := edtCodUni.Text;
    End;

    If Not fEmptyStr(edtCodMar.Text) Then
    Begin
      ParamByName('CODMAR').AsString := edtCodMar.Text;
    End;

    If Not fEmptyStr(edtCodFor.Text) Then
    Begin
      ParamByName('CODFOR').AsString := edtCodFor.Text;
    End;

  End;
End;

procedure TfrmCadTabelaPrecosItem.rdgAlterarTipoClick(Sender: TObject);
begin
  inherited;
  If Assigned(objTabelas)  Then
  Begin
    if rdgAlterarTipo.ItemIndex = 0 then
      objTabelas.FopcMarPre := opcMargem
    Else
      objTabelas.FopcMarPre := opcPrecoVenda;
  End;
end;

procedure TfrmCadTabelaPrecosItem.rdgMarPreClick(Sender: TObject);
begin
  inherited;

  pAtualizaPrecosIteger;
end;

procedure TfrmCadTabelaPrecosItem.pAtualizaPrecosIteger;
begin

  If rdgMarPre.ItemIndex = 0 Then
    objTabPre.fMontaPrecosVenda(opcMargem)
  Else
    objTabPre.fMontaPrecosVenda(opcPrecoVenda);

end;


procedure TfrmCadTabelaPrecosItem.tbsAltGlobalShow(Sender: TObject);
begin
  inherited;
  objTabPre.RestauraFiltro;
end;

procedure TfrmCadTabelaPrecosItem.tbsDadosShow(Sender: TObject);
begin
  inherited;
  If tbsAltGlobal.Visible Then
  Begin
    btnExcluiItem.Visible := False;
    objTabPre.pFiltraItem(cxlFiltroEmpresa.EditValue);
  End;

end;

Procedure TfrmCadTabelaPrecosItem.pAbreSelecaoItens;
Begin

  With objTabPre.cdsIteSel, qryQuery Do
  Begin
    SQL.Text := fSQLItensSelecao;
    pSetaParametrosSelecao;
    fAbreClient(True, 'TfrmCadTabelaPrecosItem.pAbreSelecaoItens');
  End;

  dtsIteSel.DataSet := objTabPre.cdsIteSel;
End;

procedure TfrmCadTabelaPrecosItem.pgcItensChange(Sender: TObject);
begin
  inherited;

  btnExcluiItem.Visible := pgcItens.ActivePage = tbsFiltros;

  If pgcItens.ActivePage = tbsPreVen Then
    pAtualizaPrecosIteger;
  If ( pgcItens.ActivePage = tbsDados ) And
     (objTabPre.opcAlteraPreco = opcGlobalPreco) Then
  Begin

    If objTabPre.cdsTabDet.dtsSource.DataSet.FieldByName('ITE_CODITE').AsString <>  objTabPre.dtsSource.DataSet.FieldByName('ITE_CODITE').AsString Then
      objTabPre.dtsSource.DataSet.Locate('ITE_CODITE', objTabPre.cdsTabDet.dtsSource.DataSet.FieldByName('ITE_CODITE').AsString, []);
  End;

  If objTabPre.opcAlteraPreco = opcGlobalPreco Then
   objTabelas.AlteracaoGlobalEmpresa := (pgcItens.ActivePage = tbsAltGlobal);
end;

function TfrmCadTabelaPrecosItem.fFindDBEditByField(AOwner: TWincontrol; Field: TField): TDBEditFocus;
  Var
    intIndex: Integer;
begin
  Result := Nil;

  For IntIndex := 0 To AOwner.ControlCount -1 Do
  Begin
    If (AOwner.Controls[intIndex] Is TDBEditFocus) And
       (TDBEditFocus(AOwner.Controls[intIndex]).Field = Field) Then
    Begin
      Result := TDBEditFocus(AOwner.Controls[intIndex])
    End

    Else If (AOwner.Controls[intIndex] Is TWinControl) Then
      Result := fFindDBEditByField(TWinControl(AOwner.Controls[intIndex]), Field);

    If Assigned(Result) Then
      Break;
  End;
end;

Procedure TfrmCadTabelaPrecosItem.pAfterScrollTabDet(dataSet: TDataSet);
Begin
  objTabPre.Locate('ITE_CODITE', dataSet.FieldByName('ITE_CODITE').AsString, []);
End;

Function TfrmCadTabelaPrecosItem.fGeraExelGlobalPrecos(prbProgresso: TProgressBar): Boolean;
  Var
    objExcel : TGeraExcel;
    intContador: Integer;
Begin
  Try
    objTabPre.DisableControls;
    objTabPre.cdsTabDet.DisableControls;

    objTabPre.cdsTabDet.AfterScroll := pAfterScrollTabDet;
    objTabPre.cdsTabDet.First;

    objExcel := TGeraExcel.Create(objTabPre.cdsTabDet, prbProgresso);

    objExcel.blnAlinhaEsquerdaTitulo := True;

    objExcel.strNomRel := 'TABELA DE PREÇO ' + objTabPre.cdsTabDet.FieldByName('ITE_CODTAB').AsString + ' - ' + fRetNomeTabelaPreco(objTabPre.cdsTabDet.FieldByName('ITE_CODTAB').AsString);
    objExcel.AddFiltro('FORNECEDOR ' + objTabPre.cdsTabDet.FieldByName('ITE_CODFOR').AsString + ' - ' + fRetNomFornecedor(objTabPre.cdsTabDet.FieldByName('ITE_CODFOR').AsString));
    objExcel.AddFiltro('EMPRESA ' + objTabPre.cdsTabDet.FieldByName('ITE_CODEMP').AsString + ' - ' + fRetNomeEmpresaSelec(objTabPre.cdsTabDet.FieldByName('ITE_CODEMP').AsString));

    ObjExcel.AddCampo('ITE_CODITE', 'Código');
    ObjExcel.AddCampo('ITE_DESITE', 'Descrição do Produto.', 2, objTabPre);
    ObjExcel.AddCampo('ITE_CODFAB', 'Código de Fábrica', 2, objTabPre);
    ObjExcel.AddCampo('ITE_SIGUNI', 'Unidade', 2, objTabPre);

    For intContador := 4 To cxvDadosPorEmpresa.ColumnCount - 1 Do
      If cxvDadosPorEmpresa.Columns[intContador].Visible And (objTabPre.cdsTabDet.Fields.FindField(cxvDadosPorEmpresa.Columns[intContador].DataBinding.FieldName) <> Nil) Then
        objExcel.AddCampo(cxvDadosPorEmpresa.Columns[intContador].DataBinding.FieldName, cxvDadosPorEmpresa.Columns[intContador].Caption);

    ObjExcel.AddCampo('ITE_CODABF', 'Abrev. Fiscal');
    ObjExcel.AddCampo('ITE_ABFPIS', 'Abrev. PIS');
    ObjExcel.AddCampo('ITE_ABFCOF', 'Abrev. COFINS');

    ObjExcel.AddCampo('ITE_CLAIPI', 'Classificação IPI.', 2, objTabPre);
    ObjExcel.AddCampo('TFO_BAREMB', 'Cód. Barras da Embalagem', 2, objTabPre);
    ObjExcel.AddCampo('TFO_EMBALA', 'Qtd. Embalagem', 2, objTabPre);
    ObjExcel.AddCampo('TFO_CODBAR', 'Cód. Barras', 2, objTabPre);
    ObjExcel.AddCampo('TFO_PESOIT', 'Peso do Item', 2, objTabPre);
    ObjExcel.AddCampo('ITE_DIAFOR', 'Dias p/ Entrega', 2, objTabPre);
    ObjExcel.AddCampo('TFO_PRDGRU', 'Grupo do Produto', 2, objTabPre);

    Result := objExcel.fGerarRelatorio;

    If Result Then
      pMensagemOk('Arquivo gerado com sucesso!');

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TTabelaPreco.fGeraExelGlobal]');
    End;
  End;

  objTabPre.cdsTabDet.AfterScroll := Nil;
  objTabPre.cdsTabDet.EnableControls;
  objTabPre.EnableControls;
  FreeAndNil(objExcel);
End;

Function TfrmCadTabelaPrecosItem.fGeraExelGlobalComuns(prbProgresso: TProgressBar): Boolean;
  Var
    objExcel : TGeraExcel;
    intContador: Integer;
Begin
  Try
    objTabPre.DisableControls;
    objExcel := TGeraExcel.Create(objTabPre, prbProgresso);

    objExcel.blnAlinhaEsquerdaTitulo := True;

    objExcel.strNomRel := 'TABELA DE PREÇO ' + objTabPre.FieldByName('ITE_CODTAB').AsString + ' - ' + fRetNomeTabelaPreco(objTabPre.FieldByName('ITE_CODTAB').AsString);
    objExcel.AddFiltro('FORNECEDOR ' + objTabPre.FieldByName('ITE_CODFOR').AsString + ' - ' + fRetNomFornecedor(objTabPre.FieldByName('ITE_CODFOR').AsString));
    objExcel.AddFiltro('EMPRESA ' + objTabPre.cdsTabDet.FieldByName('ITE_CODEMP').AsString + ' - ' + fRetNomeEmpresaSelec(objTabPre.FieldByName('ITE_CODEMP').AsString));

    For intContador := 0 To cxvDadosComuns.ColumnCount - 1 Do
      If cxvDadosComuns.Columns[intContador].Visible And (objTabPre.Fields.FindField(cxvDadosComuns.Columns[intContador].DataBinding.FieldName) <> Nil) Then
      Begin
        objExcel.AddCampo(cxvDadosComuns.Columns[intContador].DataBinding.FieldName, cxvDadosComuns.Columns[intContador].Caption);

        If SameText(cxvDadosComuns.Columns[intContador].DataBinding.FieldName, 'ITE_UNICOM') Then
          ObjExcel.AddCampo('ITE_SIGUNI', 'Unidade Compra-Sigla');
      End;


    Result := objExcel.fGerarRelatorio;

    If Result Then
      pMensagemOk('Arquivo gerado com sucesso!');

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TTabelaPreco.fGeraExelGlobalComuns]');
    End;
  End;

  objTabPre.EnableControls;
  FreeAndNil(objExcel);
End;


end.

