unit untFatManConsertoFluxoProcesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxGrid,
  cxGridCitel, untFluxoOrdemServico, cxEditRepositoryItems, System.ImageList,
  Vcl.ImgList, cxImageList, cxButtons, dxBar, cxPC, dxDockPanel, dxDockControl,
  EditFocus, Vcl.Mask, MaskEditFocus, DateUtils, dxRibbonGallery, cxImage,
  cxBarEditItem, dxBarExtItems, cxImageComboBox, cxLabel, cxRichEdit,
  cxContainer, dxGDIPlusClasses, MemoFocus, untFuncoesRel, cxTL, cxTextEdit,
  cxTLdxBarBuiltInMenu, cxInplaceContainer, System.TypInfo, strUtils;

type
  TTpFlxFas = (OSAberta, AnaliseTecnica, Orcamento, Manutencao, Faturamento,
    OSFinalizada);
  TTpFlxSit = (OSIncluida, AnaliseTecnicaAndamento, AnaliseTecnicaConcluida,
    OrcamentoAprovado, OrcamentoRealizado, OrcamentoReprovado, EmManutencao,
    AgPecas, ManutencaoFinalizada, Armazenada, Faturado, AgFaturamento,
    OSNaoFaturada, OSBaixadaDesistencia, AgSeparacao);
  TTpFlxCom = (AgAnaliseTecnica, AgOrcamento, OrcamentoInterrompido,
    ManutencaoInterrompida, AgEnvio, AgEnvioPecasFaltantes, EnviadoAgCliente,
    AgArmazenamento, ReprovacaoCancelada, AgRetiradadoEquipamento, AgManutencao,
    EquipamentoRetirado);

type
  TfrmFatManConsertoFluxoProcesso = class(TfrmPai)
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxEditRepository: TcxEditRepository;
    cxEditRepositoryButtonVisibleCenter: TcxEditRepositoryButtonItem;
    cxEditRepositoryTextItem: TcxEditRepositoryTextItem;
    cxgFluxo: TcxGridCitel;
    cxgFluxoTBV: TcxGridDBBandedTableView;
    cxgFluxoLVL: TcxGridLevel;
    cxEditRepositoryButtonVisibleConsultar: TcxEditRepositoryButtonItem;
    cxEditRepositoryButtonVisibleRealizar: TcxEditRepositoryButtonItem;
    cxStyle2: TcxStyle;
    pnlRestaurar: TPanel;
    pnlButtonsLat: TPanel;
    lblFiltros: TcxLabel;
    tmrAnimacaoFiltro: TTimer;
    pnlButLatOS: TPanel;
    btnCancelar: TcxButton;
    btnAtualizar: TcxButton;
    btnIncluirOS: TcxButton;
    ApplicationEvents1: TApplicationEvents;
    btnDocsFiscaisEnt: TcxButton;
    btnDocsFiscaisSai: TcxButton;
    btnAnaliseTec: TcxButton;
    btnOrcamento: TcxButton;
    btnEnviarCliente: TcxButton;
    btnInterromperOrc: TcxButton;
    btnAprovar: TcxButton;
    btnReprovar: TcxButton;
    btnCancelarRep: TcxButton;
    btnRealizarMan: TcxButton;
    btnInterromperMan: TcxButton;
    btnManutencao: TcxButton;
    btnApontamento: TcxButton;
    btnArmazenar: TcxButton;
    btnRetirar: TcxButton;
    lblLegSta: TLabel;
    imgLegPrtAtendimento: TImage;
    lblProAtd: TLabel;
    cxEditRepositoryImageComboBoxItem: TcxEditRepositoryImageComboBoxItem;
    imgCombo: TImageList;
    cxgFluxoTBVColumn1: TcxGridDBBandedColumn;
    btnRelOrdemServico: TcxButton;
    lblRetGar: TLabel;
    imgLegRetornoGar: TImage;
    tmrVerificaGarantiaAgPecas: TTimer;
    btnCancelarArm: TcxButton;
    btnBaixarOSDes: TcxButton;
    pnlFiltros: TPanel;
    pnlFiltros1: TPanel;
    grbGarant: TGroupBox;
    chkNaoGar: TCheckBox;
    chkGarLoj: TCheckBox;
    chkGarFab: TCheckBox;
    chkRetGar: TCheckBox;
    grbDadEqu: TGroupBox;
    pnlMarca: TPanel;
    lblMarca: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    pnlEquipamento: TPanel;
    lblEquipamento: TLabel;
    edtCodEqu: TEditFocus;
    edtDesEqu: TEditFocus;
    pnlObservacao: TPanel;
    lblObs: TLabel;
    memObserv: TMemoFocus;
    pnlNSerPatr: TPanel;
    lblNSerie: TLabel;
    lnlNumPat: TLabel;
    edtNSerie: TEditFocus;
    edtNumPat: TEditFocus;
    pnlNotEnt: TPanel;
    lblNotEnt: TLabel;
    lblEmpNot: TLabel;
    lblEspNot: TLabel;
    edtDocEnt: TEditFocus;
    edtEspEnt: TEditFocus;
    edtEmpEnt: TEditFocus;
    pnlCliente: TPanel;
    lblCliFor: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    pnlDtaCad: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    pnlNOSFab: TPanel;
    lblNOSFab: TLabel;
    edtNOSFab: TEditFocus;
    pnlProtoc: TPanel;
    lblProtoc: TLabel;
    edtProtoc: TEditFocus;
    pnlEmpresa: TPanel;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    pnlFilBut: TPanel;
    btnFiltrar: TcxButton;
    btnLimpar: TcxButton;
    pnlFilSta: TPanel;
    trlStatus: TcxTreeList;
    cxTreeList1Column1: TcxTreeListColumn;
    pnlButSta: TPanel;
    btnDesmarcar: TcxButton;
    btnMarcar: TcxButton;
    btnRetrair: TcxButton;
    btnExpandir: TcxButton;
    cxStyle3: TcxStyle;
    pnlNumOSe: TPanel;
    lblNumOSe: TLabel;
    edtNumOSe: TEditFocus;
    pnlPedCmp: TPanel;
    lblPedCmp: TLabel;
    edtPedCmp: TEditFocus;
    pnlButLat: TPanel;
    lblSepBut: TLabel;
    btnNegociacao: TcxButton;
    btnCancelarMan: TcxButton;
    btnCfgFlx: TcxButton;
    btnCancEntEquip: TcxButton;
    pnlVendedor: TPanel;
    lblVendedor: TLabel;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    cxEditRepositoryMemoItem: TcxEditRepositoryMemoItem;
    btnComunicacoesInternas: TcxButton;
    pnlDocCliPedCmp: TPanel;
    pnlDocCli: TPanel;
    edtDocCli: TEditFocus;
    lblDocCli: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxgFluxoTBVKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirOSClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure btnLimparClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tmrAnimacaoFiltroTimer(Sender: TObject);
    procedure edtCodEquKeyPress(Sender: TObject; var Key: Char);
    procedure btnRelOrdemServicoClick(Sender: TObject);
    procedure edtCodEquExit(Sender: TObject);
    procedure edtCodMarExit(Sender: TObject);
    procedure tmrVerificaGarantiaAgPecasTimer(Sender: TObject);
    procedure edtEmpEntKeyPress(Sender: TObject; var Key: Char);
    procedure cxgFluxoTBVMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lblFiltrosClick(Sender: TObject);
    procedure FlwBotoesClick(Sender: TObject);
    procedure memObservKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMarcarClick(Sender: TObject);
    procedure btnRetrairClick(Sender: TObject);
    procedure btnDesmarcarClick(Sender: TObject);
    procedure btnExpandirClick(Sender: TObject);
    procedure edtPedCmpExit(Sender: TObject);
    procedure btnNegociacaoClick(Sender: TObject);
    procedure btnCfgFlxClick(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    objFluxo: TFluxoOrdemServico;
    blnRestaurar,
    FblnAtivaFiltro,
    FblnFiltroAtivado: Boolean;
    procedure pExpandirRetrairTudo(blnExpandir: Boolean);
    procedure pMarcarDesmarcarTudo(blnMarcar: Boolean);
    procedure pGravarConfiguracoesFluxo;
    procedure pCarregandoConfiguracoesFluxo;
    procedure pRemoveFiltroAgSeparacao;
    function fStatusMarcados(var ACancel: Boolean): String;
    function fVerificaVarStatus(aStatus: String): String;
    function fGarantiaMarcados: String;
    function fValidaNotaEntrada: Boolean;
    function fRecuarFiltros: Boolean;
    function fGetFase(strFase: String): String;
    function fGetSituacao(strSituacao: String): String;
    function fGetComplemento(strComplemento: String): String;
    function fValidaFiltros: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pEscapePressed; override;
  public
    { Public declarations }
    blnFiltro  : Boolean;
    recFiltros : TFiltros;
    strNameForm: String;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema, untNegociacaoOrdemServico, 
  untConfigFluxoOrdemServico, untCfgColFlx, untGravando;

procedure TfrmFatManConsertoFluxoProcesso.btnIncluirOSClick(Sender: TObject);
begin
  inherited;
  if not btnIncluirOS.Enabled then
    Exit;

  objFluxo.pNovaOrdemServico;
end;

procedure TfrmFatManConsertoFluxoProcesso.btnLimparClick(Sender: TObject);
begin
  inherited;
  edtNumOSe.Clear;
  edtCodEmp.Clear;
  edtProtoc.Clear;
  edtNOSFab.Clear;
  edtDesEmp.Clear;
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtDocCli.Clear;
  edtPedCmp.Clear;
  edtCodVen.Clear;
  edtNomVen.Clear;
  edtCodMar.Clear;
  edtDesMar.Clear;
  edtCodEqu.Clear;
  edtDesEqu.Clear;
  edtNSerie.Clear;
  edtNumPat.Clear;
  memObserv.Clear;
  edtDocEnt.Clear;
  edtEspEnt.Clear;
  edtEmpEnt.Clear;
  mskDtaIni.Text := DateToStr(StartOfAMonth(YearOf(Date), MonthOf(Date)));
  mskDtaFin.Text := DateToStr(Date);

  chkNaoGar.Checked := True;
  chkGarLoj.Checked := True;
  chkGarFab.Checked := True;
  chkRetGar.Checked := True;

  btnRetrair.Click;
  btnDesmarcar.Click;

  recFiltros.dtaCadIni := 0;
  recFiltros.dtaCadFin := 0;
  recFiltros.strNumOSe := '';
  recFiltros.strCodEmp := '';
  recFiltros.strProtoc := '';
  recFiltros.strNOSFab := '';
  recFiltros.strCodCli := '';
  recFiltros.strDocCli := '';
  recFiltros.strPedCmp := '';
  recFiltros.strCodVen := '';
  recFiltros.strCodMar := '';
  recFiltros.strStatus := '';
  recFiltros.strCodEqu := '';
  recFiltros.strNSerie := '';
  recFiltros.strNumPat := '';
  recFiltros.strObserv := '';
  recFiltros.strGarant := '';
  recFiltros.strDocEnt := '';
  recFiltros.strEspEnt := '';
  recFiltros.strEmpEnt := '';
end;

procedure TfrmFatManConsertoFluxoProcesso.btnMarcarClick(Sender: TObject);
begin
  pMarcarDesmarcarTudo(True);
end;

procedure TfrmFatManConsertoFluxoProcesso.btnNegociacaoClick(Sender: TObject);
var
  frmNegociacaoOrdemServico: TfrmNegociacaoOrdemServico;
begin
  inherited;

  pCriarFormularios(TfrmNegociacaoOrdemServico, frmNegociacaoOrdemServico);

  try
    frmNegociacaoOrdemServico.ShowModal;
  finally
    pFreeAndNil(frmNegociacaoOrdemServico);
    objFluxo.pAtualizaDados;
  end;
end;

procedure TfrmFatManConsertoFluxoProcesso.btnRelOrdemServicoClick(
  Sender: TObject);
begin
  inherited;
  If Assigned(prcExecutaRelatorio) Then
    prcExecutaRelatorio(579, 42348, [42348,42349],
                        ['CODEMP','CODCLI','CODEQU','CODMAR','NSERIE'],
                        [edtCodEmp.Text, edtCodCli.Text, edtCodEqu.Text, edtCodMar.Text, edtNSerie.Text],
                        Sender);
end;

procedure TfrmFatManConsertoFluxoProcesso.btnRetrairClick(Sender: TObject);
begin
  pExpandirRetrairTudo(False);
end;

procedure TfrmFatManConsertoFluxoProcesso.btnFiltrarClick(Sender: TObject);
var
  frmFluxo: TfrmFatManConsertoFluxoProcesso;
  LStatus,
  LGarant: String;
  LCancel: Boolean;
begin
  inherited;

  LStatus := '';
  LCancel := False;

  if fEmptyStr(edtNumOSe.Text) then
  begin
    if not fValidaFiltros then
      Exit;

    LGarant := fGarantiaMarcados;

    if fEmptyStr(LGarant) then
    begin
      fMensagem('AVISO', 'Selecione o tipo de garantia a ser filtrada', ['&Ok']);
      Exit;
    end;

    LStatus := fStatusMarcados(LCancel);

    if fEmptyStr(LStatus) and (not LCancel) then
    begin
      fMensagem('AVISO', 'Selecione um Status.', ['&Ok']);
      Exit;
    end;
  end
  else
  begin
    if not fValidaCampos(edtNumOSe, True) Then
      Exit;

    if not fValidaCampos(edtCodEmp, True) Then
      Exit;
  end;

  recFiltros.dtaCadIni := StrToDate(mskDtaIni.Text);
  recFiltros.dtaCadFin := StrToDate(mskDtaFin.Text);
  recFiltros.strNumOSe := edtNumOSe.Text;
  recFiltros.strCodEmp := edtCodEmp.Text;
  recFiltros.strCodCli := edtCodCli.Text;
  recFiltros.strDocCli := edtDocCli.Text;
  recFiltros.strPedCmp := edtPedCmp.Text;
  recFiltros.strCodVen := edtCodVen.Text;
  recFiltros.strCodMar := edtCodMar.Text;
  recFiltros.strStatus := LStatus;
  recFiltros.strProtoc := edtProtoc.Text;
  recFiltros.strNOSFab := edtNOSFab.Text;
  recFiltros.strCodEqu := edtCodEqu.Text;
  recFiltros.strNSerie := edtNSerie.Text;
  recFiltros.strNumPat := edtNumPat.Text;
  recFiltros.strObserv := memObserv.Texto;
  recFiltros.blnCancel := LCancel;
  recFiltros.strGarant := LGarant;
  recFiltros.strDocEnt := edtDocEnt.Text;
  recFiltros.strEspEnt := edtEspEnt.Text;
  recFiltros.strEmpEnt := edtEmpEnt.Text;

  pCriarFormularios(TfrmFatManConsertoFluxoProcesso, frmFluxo);

  try
    frmFluxo.blnFiltro          := True;
    frmFluxo.recFiltros         := recFiltros;
    frmFluxo.lblFiltros.Visible := False;
    frmFluxo.strNameForm        := Self.strNameForm;
    frmFluxo.ShowModal;
  finally
    pFreeAndNil(frmFluxo);
  end;
end;

procedure TfrmFatManConsertoFluxoProcesso.btnCancelarClick(
  Sender: TObject);
begin
  inherited;
  if not btnCancelar.Enabled then
    Exit;

  objFluxo.pCancelarOrdemServico;
end;

procedure TfrmFatManConsertoFluxoProcesso.btnCfgFlxClick(Sender: TObject);
var
  frmConfigFluxoOrdemServico: TfrmConfigFluxoOrdemServico;
begin
  inherited;

  if (btnCfgFlx.Visible) then
  begin
    pCriarFormularios(TfrmConfigFluxoOrdemServico, frmConfigFluxoOrdemServico);

    try
      frmConfigFluxoOrdemServico.frmFatManConsertoFluxoProcesso := Self;
      frmConfigFluxoOrdemServico.ShowModal;

      if (frmConfigFluxoOrdemServico.blnConfirma) then
      begin
        TFrmGravando.fExecutarModal(pGravarConfiguracoesFluxo, 'Aguarde... Gravando Configurações!', '');
      end;
    finally
      pFreeAndNil(frmConfigFluxoOrdemServico);
    end;
  end;
end;

procedure TfrmFatManConsertoFluxoProcesso.btnDesmarcarClick(Sender: TObject);
begin
  pMarcarDesmarcarTudo(False);
end;

procedure TfrmFatManConsertoFluxoProcesso.btnExpandirClick(Sender: TObject);
begin
  pExpandirRetrairTudo(True);
end;

procedure TfrmFatManConsertoFluxoProcesso.btnAtualizarClick(
  Sender: TObject);
begin
  inherited;
  if not btnAtualizar.Enabled then
    Exit;

  objFluxo.pAtualizaDados(True);
end;

procedure TfrmFatManConsertoFluxoProcesso.cxgFluxoTBVKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: pEscapePressed;
  End;
end;

procedure TfrmFatManConsertoFluxoProcesso.cxgFluxoTBVMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  fRecuarFiltros;
end;

procedure TfrmFatManConsertoFluxoProcesso.edtCodCliKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrSel, True) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatManConsertoFluxoProcesso.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
var
  arrSel : TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrSel) Then
  Begin
    if fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatManConsertoFluxoProcesso.edtCodEquExit(Sender: TObject);
begin
  inherited;
  if (fEmptyStr(edtCodEqu.Text)) then
    edtDesEqu.Clear;
end;

procedure TfrmFatManConsertoFluxoProcesso.edtCodEquKeyPress(Sender: TObject; var Key: Char);
var
  arrEqu: TConsultasArray;
begin
  inherited;

  if fPesqEquipamento(Self, edtCodEqu, edtDesEqu, Nil, Key, arrEqu) then
  begin
    if fValidaCampos(edtCodEqu, True) Then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmFatManConsertoFluxoProcesso.edtCodMarExit(Sender: TObject);
begin
  inherited;
  if (fEmptyStr(edtCodMar.Text)) then
    edtDesMar.Clear;
end;

procedure TfrmFatManConsertoFluxoProcesso.edtCodMarKeyPress(Sender: TObject; var Key: Char);
var
  arrSel : TConsultasArray;
begin
  inherited;
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrSel, True) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatManConsertoFluxoProcesso.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel : TConsultasArray;
begin
  inherited;
  if fEntraCons(Key) then
  begin
    if (fPesqOperador(Self, edtCodVen, edtNomVen, nil, Key, arrSel)) then
    begin
        If fValidaCampos(edtCodVen, True) Then
          SelectNext(ActiveControl, True, True);
    end;
  end;
end;

procedure TfrmFatManConsertoFluxoProcesso.edtEmpEntKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtDocEnt, Nil, Nil, Key, arrSel) Then
  Begin
    if fValidaCampos(edtEmpEnt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatManConsertoFluxoProcesso.edtPedCmpExit(Sender: TObject);
begin
  inherited;
  if (not fEmptyStr(edtPedCmp.Text)) then
    edtPedCmp.Text := fPadL(edtPedCmp.Text, edtPedCmp.TamCampo, '0');
end;

function TfrmFatManConsertoFluxoProcesso.fGarantiaMarcados: String;
begin
  Result := '';

  if (chkNaoGar.Checked) then
    Result := Result + ' (EQU_GARANT = "N") ';

  if (chkGarLoj.Checked) then
    Result := Result + fVerificaVarStatus(Result) + ' (EQU_GARANT = "L") ';

  if (chkGarFab.Checked) then
    Result := Result + fVerificaVarStatus(Result) + ' (EQU_GARANT = "F") ';

  if (chkRetGar.Checked) then
    Result := Result + fVerificaVarStatus(Result) + ' (EQU_GARANT = "R") ';
end;

function TfrmFatManConsertoFluxoProcesso.fGetComplemento(strComplemento: String): String;
var
  tpFlxCom: TTpFlxCom;
begin
  Result := '';

  tpFlxCom := TTpFlxCom(GetEnumValue(TypeInfo(TTpFlxCom), strComplemento));

  case tpFlxCom of
    AgAnaliseTecnica:        Result := '"AT", ';
    AgOrcamento:             Result := '"AO", ';
    OrcamentoInterrompido:   Result := '"OI", ';
    ManutencaoInterrompida:  Result := '"MI", ';
    AgEnvio:                 Result := '"AE", ';
    AgEnvioPecasFaltantes:   Result := '"PF", ';
    EnviadoAgCliente:        Result := '"AC", ';
    AgArmazenamento:         Result := '"AA", ';
    ReprovacaoCancelada:     Result := '"RC", ';
    AgRetiradadoEquipamento: Result := '"AR", ';
    AgManutencao:            Result := '"AM", ';
    EquipamentoRetirado:     Result := '"ER", ';
    else if (strComplemento = 'AgFaturamento') then
      Result := '"AF", ';
  end;
end;

function TfrmFatManConsertoFluxoProcesso.fGetFase(strFase: String): String;
var
  tpFlxFas: TTpFlxFas;
begin
  tpFlxFas := TTpFlxFas(GetEnumValue(TypeInfo(TTpFlxFas), strFase));

  case tpFlxFas of
    OSAberta:       Result := '((EQU_FLXFAS = "A") AND (';
    AnaliseTecnica: Result := '((EQU_FLXFAS = "T") AND (';
    Orcamento:      Result := '((EQU_FLXFAS = "O") AND (';
    Manutencao:     Result := '((EQU_FLXFAS = "M") AND (';
    Faturamento:    Result := '((EQU_FLXFAS = "F") AND (';
    OSFinalizada:   Result := '((EQU_FLXFAS = "R") AND (';
  end;
end;

function TfrmFatManConsertoFluxoProcesso.fGetSituacao(strSituacao: String): String;
var
  tpFlxSit: TTpFlxSit;
begin
  Result := '';

  tpFlxSit := TTpFlxSit(GetEnumValue(TypeInfo(TTpFlxSit), strSituacao));

  case tpFlxSit of
    OSIncluida:              Result := '(EQU_FLXSIT = "OI" AND EQU_FLXCOM IN (';
    AnaliseTecnicaAndamento: Result := '(EQU_FLXSIT = "TA" AND EQU_FLXCOM IN (';
    AnaliseTecnicaConcluida: Result := '(EQU_FLXSIT = "TC" AND EQU_FLXCOM IN (';
    OrcamentoAprovado:       Result := '(EQU_FLXSIT = "OA" AND EQU_FLXCOM IN (';
    OrcamentoRealizado:      Result := '(EQU_FLXSIT = "OR" AND EQU_FLXCOM IN (';
    OrcamentoReprovado:      Result := '(EQU_FLXSIT = "ON" AND EQU_FLXCOM IN (';
    EmManutencao:            Result := '(EQU_FLXSIT = "EM" AND EQU_FLXCOM IN (';
    AgPecas:                 Result := '(EQU_FLXSIT = "AP" AND EQU_FLXCOM IN (';
    AgSeparacao:             Result := '(EQU_FLXSIT = "AS" AND EQU_FLXCOM IN (';
    ManutencaoFinalizada:    Result := '(EQU_FLXSIT = "MF" AND EQU_FLXCOM IN (';
    Armazenada:              Result := '(EQU_FLXSIT = "AR" AND EQU_FLXCOM IN (';
    Faturado:                Result := '(EQU_FLXSIT = "FA" AND EQU_FLXCOM IN (';
    AgFaturamento:           Result := '(EQU_FLXSIT = "AF" AND EQU_FLXCOM IN (';
    OSNaoFaturada:           Result := '(EQU_FLXSIT = "NF" AND EQU_FLXCOM IN (';
    OSBaixadaDesistencia:    Result := '(EQU_FLXSIT = "OB" AND EQU_FLXCOM IN (';
  end;
end;

procedure TfrmFatManConsertoFluxoProcesso.FlwBotoesClick(Sender: TObject);
begin
  inherited;
  fRecuarFiltros;
end;

procedure TfrmFatManConsertoFluxoProcesso.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  if (blnRestaurar) then
    Exit;

  if (blnFiltro) then
    Exit;

  if not fPergunta('Deseja abandonar a tarefa?') then
    Action := caNone;
end;

procedure TfrmFatManConsertoFluxoProcesso.FormCreate(Sender: TObject);
begin
  inherited;

  cxgFluxoTBV.OptionsView.ShowEditButtons := gsebAlways;
  
  btnIncluirOS.Visible   := fVerificaAcessoSistema('FLXNOS', strLoginUsuarioLogado);
  btnCancelar.Visible    := fVerificaAcessoSistema('FLXCOS', strLoginUsuarioLogado);
  btnBaixarOSDes.Visible := fVerificaAcessoSistema('FLXBOS', strLoginUsuarioLogado);
  btnNegociacao.Visible  := fVerificaAcessoSistema('FLXNEG', strLoginUsuarioLogado);
  btnCfgFlx.Visible      := fVerificaAcessoSistema('FLXCFG', strLoginUsuarioLogado);
  lblSepBut.Visible      := btnNegociacao.Visible;

  blnRestaurar := False;
  blnFiltro    := False;
  mskDtaIni.Text := DateToStr(StartOfAMonth(YearOf(Date), MonthOf(Date)));
  mskDtaFin.Text := DateToStr(Date);

  pnlProtoc.Visible := fCfgSis('PROSER', varBoolean);
  pnlNOSFab.Visible := fVerificaAcessoSistema('FXOSFA', strLoginUsuarioLogado);

  strNameForm := Self.Name;
end;

procedure TfrmFatManConsertoFluxoProcesso.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(objFluxo);
end;

procedure TfrmFatManConsertoFluxoProcesso.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if Shift = [] then
    case Key of
      VK_F1 : btnIncluirOS.Click;
      VK_F5 : btnAtualizar.Click;
      VK_F6 : btnCancelar.Click;
      VK_F2 : btnAnaliseTec.Click;
      VK_F3 : btnOrcamento.Click;
      VK_F4 : btnEnviarCliente.Click;
      VK_F7 : btnAprovar.Click;
      VK_F8 : btnReprovar.Click;
      VK_F9 : btnRealizarMan.Click;
      VK_F10: btnManutencao.Click;
      VK_F11: btnArmazenar.Click;
      VK_F12: btnRetirar.Click;
    end;

  if (Shift = [ssCtrl]) then
    case AnsiIndexStr(Char(Key), ['B', 'E', 'S', 'I', 'C', 'M', 'N', 'A']) of
      0: btnBaixarOSDes.Click;
      1: btnDocsFiscaisEnt.Click;
      2: btnDocsFiscaisSai.Click;
      3: btnInterromperOrc.Click;
      4: btnCancelarRep.Click;
      5: btnInterromperMan.Click;
      6: btnCancelarArm.Click;
      7: btnApontamento.Click;
      else
        if (Key = VK_F12) then
          btnCancEntEquip.Click;
    end;

  if (Shift = [ssAlt]) then
    case AnsiIndexStr(Char(Key), ['N', 'M']) of
      0: btnNegociacao.Click;
      1: btnCancelarMan.Click;
      else
        if (Key = VK_F2) then
          btnRelOrdemServico.Click;
    end;

  if (Shift = [ssShift]) then
    case Key of
      VK_F6: btnComunicacoesInternas.Click;
    end;
end;

procedure TfrmFatManConsertoFluxoProcesso.FormShow(Sender: TObject);
begin
  inherited;;

  btnCfgFlx.Visible := fVerificaAcessoSistema('FLXCFG', strLoginUsuarioLogado) and (not blnFiltro);
  tmrVerificaGarantiaAgPecas.Enabled := False;

  pnlFiltros.Left := -545;
  FblnAtivaFiltro := False;
  tmrAnimacaoFiltro.Enabled := False;

  objFluxo := TFluxoOrdemServico.Create(cxEditRepositoryTextItem,
                                        cxEditRepositoryImageComboBoxItem,
                                        cxEditRepositoryMemoItem,
                                        blnFiltro,
                                        recFiltros);
  cxgFluxo.BeginUpdate;

  try
    objFluxo.cxgFluxo := cxgFluxo;

    objFluxo.pSetButton(btnDocsFiscaisEnt);
    objFluxo.pSetButton(btnDocsFiscaisSai);
    objFluxo.pSetButton(btnAnaliseTec);
    objFluxo.pSetButton(btnOrcamento);
    objFluxo.pSetButton(btnEnviarCliente);
    objFluxo.pSetButton(btnInterromperOrc);
    objFluxo.pSetButton(btnAprovar);
    objFluxo.pSetButton(btnReprovar);
    objFluxo.pSetButton(btnCancelarRep);
    objFluxo.pSetButton(btnRealizarMan);
    objFluxo.pSetButton(btnInterromperMan);
    objFluxo.pSetButton(btnManutencao);
    objFluxo.pSetButton(btnCancelarMan);
    objFluxo.pSetButton(btnApontamento);
    objFluxo.pSetButton(btnArmazenar);
    objFluxo.pSetButton(btnCancelarArm);
    objFluxo.pSetButton(btnRetirar);
    objFluxo.pSetButton(btnCancEntEquip);
    objFluxo.pSetButton(btnBaixarOSDes);
    objFluxo.pAtualizaDados(True);
    objFluxo.pSetButton(btnComunicacoesInternas);

    TFrmGravando.fExecutarModal(pCarregandoConfiguracoesFluxo, 'Aguarde... Carregando configurações!', '');
  finally
    cxgFluxo.EndUpdate;
  end;

  if fCfgSis('FXRESS', varBoolean) then
    tmrVerificaGarantiaAgPecas.Enabled := True;

  if (not fCfgSis('FLXSEP', varBoolean)) then
    pRemoveFiltroAgSeparacao;
end;

function TfrmFatManConsertoFluxoProcesso.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
var
  strEmpresa: String;
begin
  Result := True;

  If (Sender = edtNumOSe) Then
  Begin
    If fEmptyStr(edtNumOSe.Text) Then
      Exit;

    edtNumOSe.Text := fPadL(edtNumOSe.Text, edtNumOSe.TamCampo, '0');

    if (not fCfgSis('MAOSEM', varBoolean)) then
    begin
      pSetFocus(btnFiltrar);
      blnMudarFoco := False;
    end;
  End
  Else If (Sender = edtCodEmp) Then
  Begin
    If fEmptyStr(edtCodEmp.Text) and (fCfgSis('MAOSEM', varBoolean)) and (not fEmptyStr(edtNumOSe.Text)) Then
    Begin
      fMensagem('','Informe a empresa da Ordem de Serviço!', ['&OK']);
      Result := False;
      Exit;
    End
    Else If fEmptyStr(edtCodEmp.Text) Then
      Exit;

    edtCodEmp.Text := fPadL(edtCodEmp.Text, edtCodEmp.TamCampo, '0');
    edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

    If fEmptyStr(edtDesEmp.Text) Then
    Begin
      fMensagem('','O código da empresa informado não é válido!', ['&OK']);
      edtCodEmp.Clear;
      Result := False;
    End
    Else if (not fEmptyStr(edtNumOSe.Text)) then
    begin
      pSetFocus(btnFiltrar);
      blnMudarFoco := False;
    end;
  End
  Else If (Sender = edtCodCli) Then
  Begin
    If fEmptyStr(edtCodCli.Text) Then
    Begin
      edtNomCli.Clear;
      Exit;
    End;

    edtCodCli.Text := fPadL(edtCodCli.Text, edtCodCli.TamCampo, '0');
    edtNomCli.Text := fRetNomCliente(edtCodCli.Text);

    If fEmptyStr(edtNomCli.Text) Then
    Begin
      fMensagem('AVISO', 'Cliente não encontrado!', ['&Ok']);
      edtCodCli.Clear;
      Result := False;
    End;
  End
  Else If (Sender = edtCodVen) Then
  Begin
    If fEmptyStr(edtCodVen.Text) Then
    Begin
      edtNomVen.Clear;
      Exit;
    End;

    edtCodVen.Text := fPadL(edtCodVen.Text, edtCodVen.TamCampo, '0');
    edtNomVen.Text := fRetNomVendRep(edtCodVen.Text);

    If fEmptyStr(edtNomVen.Text) Then
    Begin
      fMensagem('AVISO', 'Vendedor não encontrado!', ['&Ok']);
      edtCodVen.Clear;
      Result := False;
    End;
  End
  Else If (Sender = edtCodEqu) Then
  Begin
    If fEmptyStr(edtCodEqu.Text) Then
      Exit;

    edtCodEqu.Text := fPadL(edtCodEqu.Text, edtCodEqu.TamCampo, '0');
    edtDesEqu.Text := fRetNomEquipamentoOs(edtCodEqu.Text);

    If fEmptyStr(edtDesEqu.Text) Then
    Begin
      fMensagem('AVISO', 'Equipamento não encontrado!', ['&Ok']);
      Result := False;
    End;
  End
  Else If (Sender = edtCodMar) Then
  Begin
    If fEmptyStr(edtCodMar.Text) Then
      Exit;

    edtCodMar.Text := fPadL(edtCodMar.Text, edtCodMar.TamCampo, '0');
    edtDesMar.Text := fRetNomeMarca(edtCodMar.Text);

    If fEmptyStr(edtDesMar.Text) Then
    Begin
      fMensagem('AVISO', 'Marca não encontrada!', ['&Ok']);
      Result := False;
    End;
  End
  Else If (Sender = edtDocEnt) and blnBuscaPorChave Then
  Begin
    if (not fEmptyStr(edtDocEnt.Text)) then
      edtDocEnt.Text := fPadL(edtDocEnt.Text, edtDocEnt.TamCampo, '0');
  End
  Else If (Sender = edtEspEnt) and blnBuscaPorChave Then
  Begin
    if (not fEmptyStr(edtDocEnt.Text)) and fEmptyStr(edtEspEnt.Text) then
    begin
      fMensagem('AVISO', 'Informe a espécie do documento!', ['&Ok']);
      Result := False;
    end
    else if (not fEmptyStr(edtEspEnt.Text)) then
      edtEspEnt.Text := fPadL(edtEspEnt.Text, edtEspEnt.TamCampo, '0');
  End
  Else If (Sender = edtEmpEnt) and blnBuscaPorChave Then
  Begin
    if (not fEmptyStr(edtDocEnt.Text)) and fEmptyStr(edtEmpEnt.Text) then
    begin
      fMensagem('AVISO', 'Informe a empresa da nota!', ['&Ok']);
      Result := False;
    end
    else if (not fEmptyStr(edtEmpEnt.Text)) then
    begin
      edtEmpEnt.Text := fPadL(edtEmpEnt.Text, edtEmpEnt.TamCampo, '0');
      strEmpresa := fRetNomeEmpresaSelec(edtEmpEnt.Text);

      If fEmptyStr(strEmpresa) Then
      Begin
        fMensagem('','O código da empresa informado não é válido!', ['&OK']);
        edtEmpEnt.Clear;
        Result := False;
      End;
    end;
  End;
end;

function TfrmFatManConsertoFluxoProcesso.fValidaFiltros: Boolean;
begin
  Result := False;

  if not fValidaCampos(edtCodEmp, True) Then
    Exit;

  if (StrToDateDef(mskDtaIni.Text, 0) = 0) then
  begin
    fMensagem('AVISO', 'Informe a Data de Cadastro Inicial.', ['&Ok']);
    Exit;
  end;

  if (StrToDateDef(mskDtaFin.Text, 0) = 0) then
  begin
    fMensagem('AVISO', 'Informe a Data de Cadastro Final.', ['&Ok']);
    Exit;
  end;

  if (StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text)) then
  begin
    fMensagem('AVISO', 'A Data Inicial não pode ser maior que a Data Final.', ['&Ok']);
    Exit;
  end;

  if not fValidaCampos(edtCodCli, True) Then
    Exit;

  if not fValidaCampos(edtCodVen, True) Then
    Exit;

  if not fValidaCampos(edtCodEqu, True) Then
    Exit;

  if not fValidaCampos(edtCodMar, True) Then
    Exit;

  if not fValidaNotaEntrada then
    Exit;

  Result := True;
end;

function TfrmFatManConsertoFluxoProcesso.fValidaNotaEntrada: Boolean;
begin
  Result := True;

  if (fEmptyStr(edtDocEnt.Text)) and (fEmptyStr(edtEspEnt.Text)) and (fEmptyStr(edtEmpEnt.Text))then
    Exit;

  if not fValidaCampos(edtDocEnt, True) then
    Exit(False);

  if not fValidaCampos(edtEspEnt, True) then
    Exit(False);

  if not fValidaCampos(edtEmpEnt, True) then
    Exit(False);
end;

procedure TfrmFatManConsertoFluxoProcesso.lblFiltrosClick(Sender: TObject);
begin
  inherited;
  FblnAtivaFiltro := not FblnAtivaFiltro;

  if FblnAtivaFiltro then
  begin
    pnlFiltros.Visible := True;
    FblnFiltroAtivado := False;
    tmrAnimacaoFiltro.Enabled := True;
  end
  else
    FblnFiltroAtivado := False;

  tmrAnimacaoFiltro.Enabled := True;
end;

procedure TfrmFatManConsertoFluxoProcesso.memObservKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if Key = VK_ESCAPE then
    pEscapePressed;
end;

function TfrmFatManConsertoFluxoProcesso.fRecuarFiltros: Boolean;
begin
  Result := False;

  if (FblnFiltroAtivado) then
  begin
    FblnAtivaFiltro := False;
    tmrAnimacaoFiltro.Enabled := True;
    Result := True;
  end;
end;

procedure TfrmFatManConsertoFluxoProcesso.pCarregandoConfiguracoesFluxo;
begin
  TCfgColFlx.pIniciar(cxgFluxo, cxgFluxoTBV);
  objFluxo.pValidarPermissaoColunas;
end;

procedure TfrmFatManConsertoFluxoProcesso.pEscapePressed;
begin
  if (not fRecuarFiltros) then
    inherited;
end;

procedure TfrmFatManConsertoFluxoProcesso.pExpandirRetrairTudo(blnExpandir: Boolean);
var
  intNiv0,
  intNiv1: Integer;
  NodeNv0,
  NodeNv1: TcxTreeListNode;
begin
  for intNiv0 := 0 to Pred(trlStatus.Count) do
  begin
    NodeNv0 := trlStatus.Items[intNiv0];

    if blnExpandir then
      NodeNv0.Expand(True)
    else
      NodeNv0.Collapse(True);

    for intNiv1 := 0 to Pred(NodeNv0.Count) do
    begin
      NodeNv1 := NodeNv0.Items[intNiv1];

      if blnExpandir then
        NodeNv1.Expand(True)
      else
        NodeNv1.Collapse(True);
    end;
  end;
end;

procedure TfrmFatManConsertoFluxoProcesso.pGravarConfiguracoesFluxo;
var
  objAfterScroll: TDataSetNotifyEvent;
begin
  objAfterScroll := cxgFluxoTBV.DataController.DataSet.AfterScroll;
  cxgFluxoTBV.DataController.DataSet.AfterScroll := nil;

  TCfgColFlx.pCarregarDadosSalvos(cxgFluxoTBV);
  objFluxo.pValidarPermissaoColunas;

  cxgFluxoTBV.DataController.DataSet.AfterScroll := objAfterScroll;
end;

procedure TfrmFatManConsertoFluxoProcesso.pMarcarDesmarcarTudo(blnMarcar: Boolean);
var
  intNiv0: Integer;
  NodeNv0: TcxTreeListNode;
begin
  for intNiv0 := 0 to Pred(trlStatus.Count) do
  begin
    NodeNv0 := trlStatus.Items[intNiv0];

    if (not blnMarcar) and (NodeNv0.CheckState <> cbsUnchecked) then
      NodeNv0.CheckClick;

    if ((blnMarcar) and (NodeNv0.CheckState <> cbsChecked)) or ((not blnMarcar) and (NodeNv0.CheckState <> cbsUnchecked)) then
      NodeNv0.CheckClick;
  end;
end;

procedure TfrmFatManConsertoFluxoProcesso.pRemoveFiltroAgSeparacao;
var
  intNiv0,
  intNiv1: Integer;
  NodeNv0,
  NodeNv1: TcxTreeListNode;
  strValue: String;
begin
  for intNiv0 := 0 to Pred(trlStatus.Count) do
  begin
    NodeNv0 := trlStatus.Items[intNiv0];

    for intNiv1 := 0 to Pred(NodeNv0.Count) do
    begin
      NodeNv1 := NodeNv0.Items[intNiv1];
      strValue := StringReplace(fRemoveAcentoPontos(NodeNv1.Values[0]), ' ', '', [rfReplaceAll]);

      if (strValue = 'AgSeparacao') then
      begin
        NodeNv1.Delete;
        Exit;
      end;
    end;
  end;
end;

function TfrmFatManConsertoFluxoProcesso.fStatusMarcados(var ACancel: Boolean): String;
var
  intNiv0,
  intNiv1,
  intNiv2: Integer;
  NodeNv0,
  NodeNv1,
  NodeNv2: TcxTreeListNode;
  strValue: String;
begin
  Result := '';

  for intNiv0 := 0 to Pred(trlStatus.Count) do
  begin
    NodeNv0 := trlStatus.Items[intNiv0];

    if (NodeNv0.CheckState in [cbsChecked, cbsGrayed]) then
    begin
      strValue := StringReplace(fRemoveAcentoPontos(NodeNv0.Values[0]), ' ', '', [rfReplaceAll]);

      if (strValue = 'OSCancelada') then
      begin
        ACancel := True;
        Continue;
      end;

      Result := Result + fGetFase(strValue);

      for intNiv1 := 0 to Pred(NodeNv0.Count) do
      begin
        NodeNv1 := NodeNv0.Items[intNiv1];

        if (NodeNv1.CheckState in [cbsChecked, cbsGrayed]) then
        begin
          strValue := StringReplace(StringReplace(fRemoveAcentoPontos(NodeNv1.Values[0]), ' ', '', [rfReplaceAll]), '-', '', [rfReplaceAll]);
          Result := Result + fGetSituacao(strValue);

          for intNiv2 := 0 to Pred(NodeNv1.Count) do
          begin
            NodeNv2 := NodeNv1.Items[intNiv2];

            if (NodeNv2.CheckState in [cbsChecked, cbsGrayed]) then
            begin
              strValue := StringReplace(StringReplace(fRemoveAcentoPontos(NodeNv2.Values[0]), ' ', '', [rfReplaceAll]), '-', '', [rfReplaceAll]);
              Result := Result + fGetComplemento(strValue);
            end;
          end;

          Result := Copy(Result, 1, Length(Result) - 2) + ')) OR ';
        end;
      end;

      Result := Copy(Result, 1, Length(Result) - 3) + ')) OR ';
    end;
  end;

  if Trim(Result) <> '' then
    Result := '(' + Copy(Result, 1, Length(Result) - 3) + ')';
end;

procedure TfrmFatManConsertoFluxoProcesso.tmrAnimacaoFiltroTimer(Sender: TObject);
begin
  inherited;
  if (FblnAtivaFiltro) then
  begin
    if (pnlFiltros.Left < 27) then
      pnlFiltros.left := pnlFiltros.left + 44
    else
    begin
      tmrAnimacaoFiltro.Enabled := False;
      FblnFiltroAtivado := True;
      pSetFocus(edtNumOSe);
    end;
  end;

  if (not FblnAtivaFiltro) then
  begin
    if (pnlFiltros.Left > -545) then
      pnlFiltros.left := pnlFiltros.left - 44
    else
    begin
      tmrAnimacaoFiltro.Enabled := False;
      pnlFiltros.Visible := False;
      FblnFiltroAtivado := False;
    end;
  end;
end;

procedure TfrmFatManConsertoFluxoProcesso.tmrVerificaGarantiaAgPecasTimer(
  Sender: TObject);
begin
  inherited;;
  tmrVerificaGarantiaAgPecas.Enabled := False;
  objFluxo.pVerificaOSGarantiaAgPecas;
  tmrVerificaGarantiaAgPecas.Enabled := True;
end;

function TfrmFatManConsertoFluxoProcesso.fVerificaVarStatus(aStatus: String): String;
begin
  Result := '';

  if (not fEmptyStr(aStatus)) then
    Result := ' OR ';
end;

end.
