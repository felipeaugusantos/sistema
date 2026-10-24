unit untCRMGeracaoGlobalFrameParametros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Mask, MaskEditFocus, ComboBoxFocus, EditFocus, Vcl.ComCtrls,
  untTypesSistema, untTCRMGeracaoGlobal, System.StrUtils, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxGroupBox, dxCheckGroupBox, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, untFrameCentroCustoEditFocus,
  Vcl.Buttons, BitBtnLockedIncrem,
  Promocao.Classes.CatalogoPromocao, untFrameFiltrosCatPromocao;

type
  TfraCRMGeracaoGlobalFrameParametros = class(TFrame)
    pgcFiltros: TPageControl;
    tbsDadosCliente: TTabSheet;
    Label2: TLabel;
    Label4: TLabel;
    Label12: TLabel;
    Label1: TLabel;
    Label7: TLabel;
    lbl4: TLabel;
    Label16: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label25: TLabel;
    Label209: TLabel;
    Label248: TLabel;
    Label249: TLabel;
    Label250: TLabel;
    edtCodCid: TEditFocus;
    edtNomCid: TEditFocus;
    edtCodAti: TEditFocus;
    edtNomAti: TEditFocus;
    edtVendedor: TEditFocus;
    edtDesVendedor: TEditFocus;
    edtRepresentante: TEditFocus;
    edtDesRepresentante: TEditFocus;
    edtCodReg: TEditFocus;
    edtDesReg: TEditFocus;
    edtCodSub: TEditFocus;
    edtDesSub: TEditFocus;
    edtCodRede: TEditFocus;
    edtDesRede: TEditFocus;
    edtCodCac: TEditFocus;
    edtDesCac: TEditFocus;
    cmbRevista: TComboBoxFocus;
    cmbBoleto: TComboBoxFocus;
    cmbOrgPub: TComboBoxFocus;
    edtEstado: TEditFocus;
    cmbStatus: TComboBoxFocus;
    edtCodGat: TEditFocus;
    edtDesGat: TEditFocus;
    edtCrmFre: TEditFocus;
    edtDesFre: TEditFocus;
    edtCrmPor: TEditFocus;
    edtDesCrmPor: TEditFocus;
    edtCrmFai: TEditFocus;
    edtDesFai: TEditFocus;
    edtCrmFor: TEditFocus;
    edtDesFor: TEditFocus;
    rdgTipoPessoa: TRadioGroup;
    tbsDadosContatoCliente: TTabSheet;
    Label184: TLabel;
    Label211: TLabel;
    Label213: TLabel;
    Label214: TLabel;
    Label215: TLabel;
    Label218: TLabel;
    Label219: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    edtCgoCtt: TEditFocus;
    edtDesCgoCtt: TEditFocus;
    edtDptCtt: TEditFocus;
    edtDesDptCtt: TEditFocus;
    edtTfuCtt: TEditFocus;
    edtDesTfuCtt: TEditFocus;
    edtHobCtt: TEditFocus;
    edtDesHobCtt: TEditFocus;
    edtEscCtt: TEditFocus;
    edtDesEscCtt: TEditFocus;
    edtGmuCtt: TEditFocus;
    edtDesGmuCtt: TEditFocus;
    edtEciCtt: TEditFocus;
    edtDesEciCtt: TEditFocus;
    mskDtaIniCtt: TMaskEditFocus;
    mskDtaFinCtt: TMaskEditFocus;
    tbsClientesSemCompra: TTabSheet;
    rdgFiltrarPor: TRadioGroup;
    grbClientesQueCompraramNoPeriodo: TGroupBox;
    grbPeriodoComComp: TGroupBox;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    mskIniComComp: TMaskEditFocus;
    mskFinComComp: TMaskEditFocus;
    grbDiasComComp: TGroupBox;
    Label38: TLabel;
    edtDiasComComp: TEditFocus;
    grbClientesSemCompraNoPeriodo: TGroupBox;
    grbPeriodoEntreDatas: TGroupBox;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label29: TLabel;
    mskIniSem: TMaskEditFocus;
    mskFinSem: TMaskEditFocus;
    mskIniSemO: TMaskEditFocus;
    mskFinSemO: TMaskEditFocus;
    grbUltimosDias: TGroupBox;
    Label30: TLabel;
    Label31: TLabel;
    edtDiasSem: TEditFocus;
    edtDiasSemO: TEditFocus;
    lblCodDep: TLabel;
    edtDepVen: TEditFocus;
    edtDesDep: TEditFocus;
    Label32: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    Label33: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    edtCodIte: TEditFocus;
    lbl1: TLabel;
    edtDesIte: TEditFocus;
    rdgClasOfertaCon: TRadioGroup;
    Label34: TLabel;
    chkUtiCSC: TCheckBox;
    rdgClientesPor: TRadioGroup;
    grbPeriodoCliente: TGroupBox;
    mskDtaIniCli: TMaskEditFocus;
    mskDtaFinCli: TMaskEditFocus;
    Label9: TLabel;
    Label10: TLabel;
    Label19: TLabel;
    mskIniCom: TMaskEditFocus;
    Label21: TLabel;
    mskFinCom: TMaskEditFocus;
    Label22: TLabel;
    Label39: TLabel;
    Label20: TLabel;
    mskIniOrc: TMaskEditFocus;
    Label23: TLabel;
    mskFinOrc: TMaskEditFocus;
    Label24: TLabel;
    grbDiasCliente: TGroupBox;
    Label40: TLabel;
    Label41: TLabel;
    edtDiasAniversario: TEditFocus;
    edtDiasUltCom: TEditFocus;
    Label42: TLabel;
    edtDiasUltOrc: TEditFocus;
    tbsFinanceiro: TTabSheet;
    Label43: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    Label44: TLabel;
    edtCliVen: TEditFocus;
    edtDesCliVen: TEditFocus;
    Label45: TLabel;
    edtVenDup: TEditFocus;
    edtDesVenDup: TEditFocus;
    Label46: TLabel;
    edtCodPortador: TEditFocus;
    edtDesPortador: TEditFocus;
    Label48: TLabel;
    edtEmpDup: TEditFocus;
    edtNomEmpDup: TEditFocus;
    chkUtiFin: TCheckBox;
    rdgFinanceiroPor: TRadioGroup;
    grbPeriodoVencimento: TGroupBox;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    mskIniVenc: TMaskEditFocus;
    mskFinVenc: TMaskEditFocus;
    grbDiasVencimento: TGroupBox;
    Label53: TLabel;
    edtDiasVenc: TEditFocus;
    shpLiberadoVendedor: TShape;
    shpLiberadoRepresentante: TShape;
    rdgFiltrarPorEmpresa: TRadioGroup;
    fraCentroCusto: TfraCentroCustoEditFocus;
    edtCodQua: TEditFocus;
    labelCadQua: TLabel;
    edtDesQua: TEditFocus;
    rdgFiltrarClientesNaoCompEmpresa: TRadioGroup;
    Label49: TLabel;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    lblCategoria: TLabel;
    edtCodCat: TEditFocus;
    edtDesCat: TEditFocus;
    edtCodEmpCli: TEditFocus;
    Label54: TLabel;
    edtNomEmpCli: TEditFocus;
    grbDiasAVencer: TGroupBox;
    Label47: TLabel;
    edtDiasAVen: TEditFocus;
    grbDiasVencidosApos: TGroupBox;
    Label55: TLabel;
    edtDiasVenA: TEditFocus;
    chkOcoAbe: TdxCheckGroupBox;
    lblTipo: TLabel;
    lblGrupo: TLabel;
    lblObsFiltroOcorrenciasAbertas: TLabel;
    edtCodGoc: TEditFocus;
    edtDesGoc: TEditFocus;
    edtCodToc: TEditFocus;
    edtDesToc: TEditFocus;
    tsPromocoes: TTabSheet;
    pnlCabecalhoPromocao: TPanel;
    chkCatProm: TCheckBox;
    pnlFiltrosPromocao_Local: TPanel;
    frameFiltrosCatPromocao: TframeFiltrosCatPromocao;
    lblFornecedor: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtUltVnd: TEditFocus;
    edtNomUltVnd: TEditFocus;
    lblUltVnd: TLabel;
    lblUltDig: TLabel;
    edtUltDig: TEditFocus;
    edtNomUltDig: TEditFocus;
    procedure pgcFiltrosChange(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidExit(Sender: TObject);
    procedure edtVendedorExit(Sender: TObject);
    procedure edtVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiExit(Sender: TObject);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtRepresentanteKeyPress(Sender: TObject; var Key: Char);
    procedure edtRepresentanteExit(Sender: TObject);
    procedure edtCodRegExit(Sender: TObject);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRedeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRedeExit(Sender: TObject);
    procedure edtCodGatExit(Sender: TObject);
    procedure edtCodGatKeyPress(Sender: TObject; var Key: Char);
    procedure edtCrmFreExit(Sender: TObject);
    procedure edtCrmFreKeyPress(Sender: TObject; var Key: Char);
    procedure edtCrmFaiExit(Sender: TObject);
    procedure edtCrmFaiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodSubExit(Sender: TObject);
    procedure edtCodSubKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCacKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCacExit(Sender: TObject);
    procedure edtCrmPorExit(Sender: TObject);
    procedure edtCrmPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCrmForExit(Sender: TObject);
    procedure edtCrmForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCgoCttExit(Sender: TObject);
    procedure edtCgoCttKeyPress(Sender: TObject; var Key: Char);
    procedure edtTfuCttExit(Sender: TObject);
    procedure edtTfuCttKeyPress(Sender: TObject; var Key: Char);
    procedure edtEscCttExit(Sender: TObject);
    procedure edtEscCttKeyPress(Sender: TObject; var Key: Char);
    procedure edtEciCttExit(Sender: TObject);
    procedure edtEciCttKeyPress(Sender: TObject; var Key: Char);
    procedure edtDptCttExit(Sender: TObject);
    procedure edtDptCttKeyPress(Sender: TObject; var Key: Char);
    procedure edtHobCttExit(Sender: TObject);
    procedure edtHobCttKeyPress(Sender: TObject; var Key: Char);
    procedure edtGmuCttExit(Sender: TObject);
    procedure edtGmuCttKeyPress(Sender: TObject; var Key: Char);
    procedure edtDepVenExit(Sender: TObject);
    procedure edtDepVenKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruExit(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure rdgFiltrarPorClick(Sender: TObject);
    procedure chkUtiCSCClick(Sender: TObject);
    procedure rdgClientesPorClick(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCliVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCliVenExit(Sender: TObject);
    procedure edtVenDupExit(Sender: TObject);
    procedure edtVenDupKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPortadorExit(Sender: TObject);
    procedure edtCodPortadorKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpDupExit(Sender: TObject);
    procedure edtEmpDupKeyPress(Sender: TObject; var Key: Char);
    procedure chkUtiFinClick(Sender: TObject);
    procedure rdgFinanceiroPorClick(Sender: TObject);
    function fCarregaVendedor: Boolean;
    function fCarregaRepresentante: Boolean;
    procedure rdgFiltrarPorEmpresaClick(Sender: TObject);
    procedure fraCentroCustoedtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure fraCentroCustoedtCodEveExit(Sender: TObject);
    procedure edtCodQuaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodQuaExit(Sender: TObject);
    procedure rdgFiltrarClientesNaoCompEmpresaClick(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCatExit(Sender: TObject);
    procedure edtCodCatKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpCliExit(Sender: TObject);
    procedure edtCodEmpCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodGocKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodTocKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodGocExit(Sender: TObject);
    procedure edtCodTocExit(Sender: TObject);
    procedure chkOcoAbeClick(Sender: TObject);
    procedure chkCatPromClick(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtUltVndExit(Sender: TObject);
    procedure edtUltVndKeyPress(Sender: TObject; var Key: Char);
    procedure edtUltDigExit(Sender: TObject);
    procedure edtUltDigKeyPress(Sender: TObject; var Key: Char);
  private
    FParentForm: TForm;
    FParamCon: TParametroConGeracaoGlobal;
    FParamPrm: TParametroPRMGeracaoGlobal;

    FblnLiberadoRepresentante: Boolean;
    FblnLiberadoVendedor: Boolean;

    function fFiltrarPeriodoSemCompra: Boolean;
    function fFiltrarPeriodoSemOrcamento: Boolean;
    function fFiltrarPeriodoComCompra: Boolean;

    procedure pCarregaEvento;
    procedure pCarregaEmpresa;
    procedure pCarregaEmpresaFinanceiro;
    procedure pCarregaEmpresaCli;
    procedure pCarregaCliente;
    procedure pTrataCamposProduto;
    procedure pTrataFiltrosClientes;
    procedure pTrataFiltrosFinanceiro;
    procedure pExecutarEventosComponentes;
    procedure pTrataFiltrosClientesSemComprasNoPeriodo;
    procedure pSetLiberadoRepresentante(const value: Boolean);
    procedure psetLiberadoVendedor(const value: Boolean);
    procedure pSetFiltrosPromocao;
    procedure pTrataFiltrosPromocao;
  public
    arrCrmFre,
    arrCrmPor,
    arrCrmFai,
    arrCodQua,
    arrCrmFor,
    arrGruAti,
    arrCodCid,
    arrCodAti,
    arrCodVen,
    arrCodRep,
    arrCodReg,
    arrSubReg,
    arrCodRed,
    arrCanAce,
    arrCodCar,
    arrCodDep,
    arrTimFut,
    arrCodHob,
    arrCodEsc,
    arrGosMus,
    arrEstCiv,
    arrDepVen,
    arrCodMar,
    arrLinGru,
    arrCodIte,
    arrCliVen,
    arrVenDup,
    arrPortad,
    arrEvento,
    arrEmpres,
    arrCodEmp,
    arrCodCat,
    arrCodEmpCli,
    arrCodGoc,
    arrCodToc,
    arrFornec,
    arrUltVnd,
    arrUltDig: TConsultasArray;
    strCodCli: String;

    property ParentForm: TForm     read FParentForm write FParentForm;
    property ParamCon  : TParametroConGeracaoGlobal write FParamCon;
    property ParamPRM  : TParametroPrmGeracaoGlobal write FParamPRM;

    property blnLiberadoRepresentante: Boolean write pSetLiberadoRepresentante;
    property blnLiberadoVendedor     : Boolean write psetLiberadoVendedor;

    procedure pSetaParamClass;
    procedure pSetaDataScreen;
    procedure pLimparComponentes;
    procedure pHabilitarComponentes(Const blnHabilitar: Boolean);
    function  fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean = False): Boolean;
    procedure pCarregarTsPromocoes;
  end;

implementation

uses
  untConsultas, untFuncoesConsulta, untFuncoesSimples, System.DateUtils;

{$R *.dfm}

procedure TfraCRMGeracaoGlobalFrameParametros.chkCatPromClick(Sender: TObject);
begin
  pTrataFiltrosPromocao;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.chkOcoAbeClick(Sender: TObject);
begin
  edtCodGoc.Enabled := chkOcoAbe.Enabled And chkOcoAbe.CheckBox.Checked;
  edtCodToc.Enabled := chkOcoAbe.Enabled And chkOcoAbe.CheckBox.Checked;

  If Not chkOcoAbe.CheckBox.Checked Then
  Begin
    edtCodGoc.Clear;
    edtDesGoc.Clear;
    edtCodToc.Clear;
    edtDesToc.Clear;
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.chkUtiCSCClick(Sender: TObject);
begin
  pTrataFiltrosClientesSemComprasNoPeriodo();
end;

procedure TfraCRMGeracaoGlobalFrameParametros.chkUtiFinClick(Sender: TObject);
begin
  edtCodCli.Enabled := chkUtiFin.Enabled And chkUtiFin.Checked;
  edtCliVen.Enabled := chkUtiFin.Enabled And chkUtiFin.Checked;
  edtVenDup.Enabled := chkUtiFin.Enabled And chkUtiFin.Checked;
  fraCentroCusto.edtCodEve.Enabled := chkUtiFin.Enabled And chkUtiFin.Checked;
  edtEmpDup.Enabled := chkUtiFin.Enabled And chkUtiFin.Checked;
  edtCodPortador.Enabled := chkUtiFin.Enabled And chkUtiFin.Checked;

  rdgFinanceiroPorClick(rdgFinanceiroPor);
  rdgFiltrarPorEmpresaClick(rdgFiltrarPorEmpresa);
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCgoCttExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCgoCtt, edtDesCgoCtt, arrCodCar, fRetNomCargo, Nil, 'do cargo');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCgoCttKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqCargosCliCon(FParentForm, edtCgoCtt, edtDesCgoCtt, Nil, Key, arrCodCar, False) Then
  Begin
    If fValidaCampos(edtCgoCtt, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCliVenExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCliVen, edtDesCliVen, arrCliVen, fRetNomeOperador, nil, 'do Vendedor');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCliVenKeyPress(Sender: TObject;
  var Key: Char);
begin
  if fPesqOperador(FParentForm, edtCliVen, edtDesCliVen, Nil, Key, arrCliVen, False) then
  Begin
    If fValidaCampos(edtCliVen, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodAtiExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodAti, edtNomAti, arrCodAti, Nil, fRetNomAtividade, 'da atividade');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqAtividade(FParentForm, edtCodAti, edtNomAti, Nil, Key, arrCodAti, False) Then
	Begin
		If fValidaCampos(edtCodAti, False) Then
  		SelectNext(FParentForm.ActiveControl, True, True);
	End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodCacExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodCac, edtDesCac, arrCanAce, Nil, fRetNomCanalAcesso, 'do canal de acesso');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodCacKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqCanalAcesso(FParentForm, edtCodCac, edtDesCac, Nil, Key, arrCanAce, False) Then
  Begin
    if fValidaCampos(edtCodCac, True) then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodCatExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodCat, edtDesCat, arrCodCat, Nil, fRetDesCrmCat, 'da Categoria');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodCatKeyPress(Sender: TObject;
  var Key: Char);
begin
  if fPesqCategoriaCRM(FParentForm, edtCodCat, edtDesCat, nil, Key, arrCodCat, False) then
  Begin
    If fValidaCampos(edtCodCat, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodCidExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodCid, edtNomCid, arrCodCid, fRetNomCidadeSemOpc, Nil, 'da cidade');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqCidade(FParentForm, edtCodCid, edtNomCid, edtEstado, Nil, Key, arrCodCid, False) Then
	Begin
		If fValidaCampos(edtCodCid, False) Then
  		SelectNext(FParentForm.ActiveControl, True, True);
	End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  If fPesqCliente(conCliSimples, FParentForm, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtUltDigExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtUltDig, edtNomUltDig, arrUltDig, fRetNomVendRep, Nil, 'do digitador');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtUltDigKeyPress(
  Sender: TObject; var Key: Char);
begin
  If fPesqOperador(FParentForm, edtUltDig, edtNomUltDig, nil, Key, arrUltDig, False) then
  Begin
    If fValidaCampos(edtUltDig, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodEmpCliExit(Sender: TObject);
begin
  If (Not SameText(edtCodEmpCli.Text, '000')) Then
    pEdtCodSelectExit(edtCodEmpCli, edtNomEmpCli, arrCodEmpCli, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodEmpCliKeyPress(
  Sender: TObject; var Key: Char);
begin
  If fPesqEmpresa(conEmpSimples, FParentForm, edtCodEmpCli, edtNomEmpCli, Nil, Key, arrCodEmpCli, False, True) Then
  Begin
    If fValidaCampos(edtCodEmpCli) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodEmpExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrCodEmp, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqEmpresa(conEmpSimples, FParentForm, edtCodEmp, edtNomEmp, Nil, Key, arrCodEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodForExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrFornec, fRetNomFornecedor, Nil, 'do Fornecedor', 8);
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqFornecedor(conForSimples, FParentForm, edtCodFor, edtNomFor, Nil, Key, arrFornec, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtEmpDupExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtEmpDup, edtNomEmpDup, arrEmpres, fRetNomeEmpresa, Nil, 'da Empresa', 0, False, 'Código', True);
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtEmpDupKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqEmpresa(conEmpSimples, FParentForm, edtEmpDup, edtNomEmpDup, Nil, Key, arrEmpres, False, True) Then
  Begin
    If fValidaCampos(edtEmpDup) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodGatExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodGat, edtDesGat, arrGruAti, fRetDescGrupoAtividade, Nil, 'do Grupo de Atividade');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodGatKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqGrupoAtividade(FParentForm, edtCodGat, edtDesGat, Nil, Key, arrGruAti, False) Then
  Begin
    If fValidaCampos(edtCodGat, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodGocExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodGoc, edtDesGoc, arrCodGoc, Nil, fRetDescGoc, 'do Grupo de Ocorrência');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodGocKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGruposOcorrencias(FParentForm, edtCodGoc, edtDesGoc, nil, Key, arrCodGoc, False) Then
  Begin
    If fValidaCampos(edtCodGoc, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodIteExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodIte, edtDesIte, arrCodIte, Nil, fRetNomProduto, 'do produto');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  if fPesqItem(conIteSimples, FParentForm, edtCodIte, edtDesIte, Nil, Key, arrCodite, False, nil, 'Consulta de Itens', '1') then
  Begin
    If fValidaCampos(edtCodIte, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodMarExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodMar, edtDesMar, arrCodMar, fRetNomeMarca, Nil, 'da Marca');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqMarcas(FParentForm, edtCodMar, edtDesMar, Nil, Key, arrCodMar, False) Then
  Begin
    If fValidaCampos(edtCodMar, False) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodPortadorExit(
  Sender: TObject);
begin
  pEdtCodSelectExit(edtCodPortador, edtDesPortador, arrPortad, Nil, fRetNomPortador, 'do Portador');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodPortadorKeyPress(
  Sender: TObject; var Key: Char);
begin
  If fPesqPortador(conSimples,
                   FParentForm,
                   edtCodPortador,
                   edtDesPortador,
                   nil,
                   Key,
                   arrPortad,
                   False,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   edtEmpDup.Text)  then
  Begin
    If (fValidaCampos(edtCodPortador, True)) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodQuaExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodQua, edtDesQua, arrCodQua, fRetDesQua, Nil, 'da Qualificação');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodQuaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if fPesqQualificacao(FParentForm, edtCodQua, edtDesQua, Nil, Key, arrCodQua, False) then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodRedeExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodRede, edtDesRede, arrCodRed, fRetNomeRedeLojaSelect, Nil, 'da rede de lojas');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodRedeKeyPress(
  Sender: TObject; var Key: Char);
begin
  If fPesqRedeLojas(FParentForm, edtCodRede, edtDesRede, Nil, Key, arrCodRed, False) Then
  Begin
    If fValidaCampos(edtDesRede, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodRegExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodReg, edtDesReg, arrCodReg, Nil, fRetNomRegiao, 'da região');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodRegKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqRegiao(FParentForm, edtCodReg, edtDesReg, Nil, Key, arrCodReg, False) Then
  Begin
    if fValidaCampos(edtCodReg, True) then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodSubExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodSub, edtDesSub, arrSubReg, Nil, fRetNomSubRegiao, 'da sub-região');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodSubKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqSubRegiao(FParentForm, edtCodSub, edtDesSub, Nil, Key, arrSubReg, False) Then
  Begin
    If fValidaCampos(edtDesSub, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodTocExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodToc, edtDesToc, arrCodToc, fRetDescTipoOcorrencia, Nil, 'do Tipo de Ocorrência');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCodTocKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqTiposOcorrencias(FParentForm, edtCodToc, edtDesToc, nil, Key, arrCodToc, False, edtCodGOc.Text) Then
  Begin
    If fValidaCampos(edtCodToc, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtUltVndExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtUltVnd, edtNomUltVnd, arrUltVnd, fRetNomVendRep, Nil, 'do vendedor');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtUltVndKeyPress(
  Sender: TObject; var Key: Char);
begin
  If fPesqOperador(FParentForm, edtUltVnd, edtNomUltVnd, nil, Key, arrUltVnd, False) then
  Begin
    If fValidaCampos(edtUltVnd, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCrmFaiExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCrmFai, edtDesFai, arrCrmFai, fRetDesCrmFai, Nil, 'da Faixa de Faturamento Estimado');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCrmFaiKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqFaixaFaturamentoCRM(FParentForm, edtCrmFai, edtDesFai, Nil, Key, arrCrmFai, False) Then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCrmForExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCrmFor, edtDesFor, arrCrmFor, fRetDesCrmFor, Nil, 'do Fornecedor Atual');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCrmForKeyPress(Sender: TObject;
  var Key: Char);
begin
  if fPesqFornecedorAtualCRM(FParentForm, edtCrmFor, edtDesFor, nil, Key, arrCrmFor, False) then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCrmFreExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCrmFre, edtDesFre, arrCrmFre, fRetDesCrmFre, Nil, 'da Frequência');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCrmFreKeyPress(Sender: TObject;
  var Key: Char);
begin
  if fPesqFrequenciaCRM(FParentForm, edtCrmFre, edtDesFre, nil, Key, arrCrmFre, False) then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCrmPorExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCrmPor, edtDesCrmPor, arrCrmPor, fRetDesCrmPor, Nil, 'do Porte');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtCrmPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  if fPesqPorteCRM(FParentForm, edtCrmPor, edtDesCrmPor, nil, Key, arrCrmPor, False) then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtDepVenExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtDepVen, edtDesDep, arrDepVen, fRetDescDepartamento, Nil, 'do Departamento');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtDepVenKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqDepartamento(FParentForm, edtDepVen, edtDesDep, Nil, Key, arrDepVen, False) Then
  Begin
    If fValidaCampos(edtDepVen, False) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtDptCttExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtDptCtt, edtDesDptCtt, arrCodDep, fRetNomDepartamentoCliCon, Nil, 'do departamento');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtDptCttKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqDepartamentosCliCon(FParentForm, edtDptCtt, edtDesDptCtt, Nil, Key, arrCodDep, False) Then
  Begin
    If fValidaCampos(edtDptCtt, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtEciCttExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtEciCtt, edtDesEciCtt, arrEstCiv, fRetNomEstadoCivil, Nil, 'do estado civil');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtEciCttKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqEstadosCivisCliCon(FParentForm, edtEciCtt, edtDesEciCtt, Nil, Key, arrEstCiv, False) Then
  Begin
    If fValidaCampos(edtEciCtt, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtEscCttExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtEscCtt, edtDesEscCtt, arrCodEsc, fRetNomEscolaridade, Nil, 'da escolaridade');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtEscCttKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqEscolaridadesCliCon(FParentForm, edtEscCtt, edtDesEscCtt, Nil, Key, arrCodEsc, False) Then
  Begin
    If fValidaCampos(edtEscCtt, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtGmuCttExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtGmuCtt, edtDesGmuCtt, arrGosMus, fRetNomGostoMusical, Nil, 'do gosto musical');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtGmuCttKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqGostosMusicaisCliCon(FParentForm, edtGmuCtt, edtDesGmuCtt, Nil, Key, arrGosMus, False) Then
  Begin
    If fValidaCampos(edtGmuCtt, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtHobCttExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtHobCtt, edtDesHobCtt, arrCodHob, fRetNomHobby, Nil, 'do hobby');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtHobCttKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqHobbysCliCon(FParentForm, edtHobCtt, edtDesHobCtt, Nil, Key, arrCodHob, False) Then
  Begin
    If fValidaCampos(edtHobCtt, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtRepresentanteExit(
  Sender: TObject);
begin
  If FblnLiberadoRepresentante And (FParentForm.Name = 'frmCRMGeracaoGlobal') Then
    pEdtCodSelectExit(edtRepresentante, edtDesRepresentante, arrCodRep, fRetNomVendRep, Nil, 'do representante')
  Else If FParentForm.Name = 'frmCRMGeracaoGlobal' Then
    fCarregaRepresentante
  Else
    pEdtCodSelectExit(edtRepresentante, edtDesRepresentante, arrCodRep, fRetNomVendRep, Nil, 'do representante');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtRepresentanteKeyPress(
  Sender: TObject; var Key: Char);
begin
  if (Not FblnLiberadoRepresentante) and (FParentForm.Name = 'frmCRMGeracaoGlobal') Then
    Exit;
  If fPesqOperador(FParentForm, edtRepresentante, edtDesRepresentante, nil, Key, arrCodRep, False) then
  Begin
    If fValidaCampos(edtRepresentante, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtTfuCttExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtTfuCtt, edtDesTfuCtt, arrTimFut, fRetNomTimeFutebol, Nil, 'do time de futebol');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtTfuCttKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqTimesFutebolCliCon(FParentForm, edtTfuCtt, edtDesTfuCtt, Nil, Key, arrTimFut, False) Then
  Begin
    If fValidaCampos(edtTfuCtt, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtVendedorExit(Sender: TObject);
begin
  If FblnLiberadoVendedor And (FParentForm.Name = 'frmCRMGeracaoGlobal') Then
    pEdtCodSelectExit(edtVendedor, edtDesVendedor, arrCodVen, fRetNomVendRep, Nil, 'do vendedor')
  Else If FParentForm.Name = 'frmCRMGeracaoGlobal' Then
    fCarregaVendedor
  Else
    pEdtCodSelectExit(edtVendedor, edtDesVendedor, arrCodVen, fRetNomVendRep, Nil, 'do vendedor');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtVendedorKeyPress(
  Sender: TObject; var Key: Char);
begin
  if (Not FblnLiberadoVendedor) and (FParentForm.Name = 'frmCRMGeracaoGlobal') Then
    Exit;
  If fPesqOperador(FParentForm, edtVendedor, edtDesVendedor, nil, Key, arrCodVen, False) then
  Begin
    If fValidaCampos(edtVendedor, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtVenDupExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtVenDup, edtDesVenDup, arrVenDup, fRetNomeOperador, nil, 'do Vendedor');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.edtVenDupKeyPress(Sender: TObject;
  var Key: Char);
begin
  if fPesqOperador(FParentForm, edtVenDup, edtDesVenDup, Nil, Key, arrVenDup, False) then
  Begin
    If fValidaCampos(edtVenDup, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

function TfraCRMGeracaoGlobalFrameParametros.fFiltrarPeriodoComCompra: Boolean;
begin
  Result := ((Not fEmptyDate(mskIniComComp.Text)) And (Not fEmptyDate(mskFinComComp.Text)) And mskIniComComp.Enabled)
    Or ((Not fEmptyStr(edtDiasComComp.Text)) And edtDiasComComp.Enabled);
end;

function TfraCRMGeracaoGlobalFrameParametros.fFiltrarPeriodoSemCompra: Boolean;
begin
  Result := ((Not fEmptyDate(mskIniSem.Text) ) And (not fEmptyDate(mskFinSem.Text)) And mskIniSem.Enabled)
    Or ((Not fEmptyStr(edtDiasSem.Text)) And edtDiasSem.Enabled);
end;

function TfraCRMGeracaoGlobalFrameParametros.fFiltrarPeriodoSemOrcamento: Boolean;
begin
  Result := ((Not fEmptyDate(mskIniSemO.Text)) And (Not fEmptyDate(mskFinSemO.Text)) And mskIniSemO.Enabled)
    Or ((Not fEmptyStr(edtDiasSemO.Text)) And edtDiasSemO.Enabled);
end;

procedure TfraCRMGeracaoGlobalFrameParametros.fraCentroCustoedtCodEveExit(
  Sender: TObject);
begin
  pEdtCodSelectExit(fraCentroCusto.EdtCodEve, fraCentroCusto.edtDesEve, arrEvento, fRetNomEvento, Nil, 'do Centro de Custo');
end;

procedure TfraCRMGeracaoGlobalFrameParametros.fraCentroCustoedtCodEveKeyPress(
  Sender: TObject; var Key: Char);
begin
  If fPesqEventos(FParentForm, fraCentroCusto.edtCodEve, fraCentroCusto.edtDesEve, Nil, Key, arrEvento, False) Then
  Begin
    If fValidaCampos(fraCentroCusto.edtCodEve, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

function TfraCRMGeracaoGlobalFrameParametros.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean = False): Boolean;
begin
  Result := True;

  If (Sender = edtCodCid) Then
    pDesmarcaLista(edtCodCid, arrCodCid)
  Else If (Sender = edtCodAti) Then
    pDesmarcaLista(edtCodAti, ArrCodAti)
  Else If (Sender = edtVendedor) Then
  Begin
    pDesmarcaLista(edtVendedor, arrCodVen);
    If (Not FblnLiberadoVendedor) And (FParentForm.Name = 'frmCRMGeracaoGlobal') Then
      Result := fCarregaVendedor;
  End
  Else If (Sender = edtRepresentante) Then
  Begin
    pDesmarcaLista(edtRepresentante, arrCodRep);
    If (Not FblnLiberadoRepresentante) And (FParentForm.Name = 'frmCRMGeracaoGlobal') Then
      Result := fCarregaRepresentante;
  End
  Else If (Sender = edtCodReg) Then
    pDesmarcaLista(edtCodReg, arrCodReg)
  Else If (Sender = edtCodSub) Then
    pDesmarcaLista(edtCodSub, arrSubReg)
  Else If (Sender = edtCodRede) Then
    pDesmarcaLista(edtCodRede, arrCodRed)
  Else If (Sender = edtCodCac) Then
    pDesmarcaLista(edtCodCac, arrCanAce)
  Else If (Sender = edtCgoCtt) Then
    pDesmarcaLista(edtCgoCtt, arrCodCar)
  Else If (Sender = edtDptCtt) Then
    pDesmarcaLista(edtDptCtt, arrCodDep)
  Else If (Sender = edtTfuCtt) Then
    pDesmarcaLista(edtTfuCtt, arrTimFut)
  Else If (Sender = edtHobCtt) Then
    pDesmarcaLista(edtHobCtt, arrCodHob)
  Else If (Sender = edtEscCtt) Then
    pDesmarcaLista(edtEscCtt, arrCodEsc)
  Else If (Sender = edtGmuCtt) Then
    pDesmarcaLista(edtGmuCtt, arrGosMus)
  Else If (Sender = edtEciCtt) Then
    pDesmarcaLista(edtEciCtt, arrEstCiv)
  Else If (Sender = edtCliVen) Then
    pDesmarcaLista(edtCliVen, arrCliVen)
  Else If (Sender = edtVenDup) Then
    pDesmarcaLista(edtVenDup, arrVenDup)
  Else If Sender = edtCodPortador Then
  Begin
    pDesmarcaLista(edtVenDup, arrVenDup);

    If Not fEmptyStr(edtCodPortador.Text) And (edtCodPortador.Text <> '00000') Then
    Begin
      edtDesPortador.Text := fRetNomPortador(edtCodPortador.Text);

      If fEmptyStr(edtDesPortador.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Portador não cadastrado!', ['&O k']);
        Result := False;
      End
      {*REQ*145940**********RP*}
      Else If Not fEmpresaTemAcessoPortador(edtCodPortador.Text, edtEmpDup.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        Result := False;
      End
      Else If fCfgSis('DACPOR', varBoolean) Then
      Begin
        If Pos(edtCodPortador.Text, strPortadoresOperador) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão para visualizar lançamentos para este portador!', ['&O k']);
          Result := False;
        End;
      End;
    End
    Else
    Begin
      if (edtCodPortador.Text = '00000') Then
        edtDesPortador.Text := '+1'
      else
        edtDesPortador.Text := 'TODOS';
    End;
  End
  Else If (Sender = mskDtaIniCli) Then
  Begin
    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniCli.Text))) Then
    Begin
      Result := StrToDateDef(mskDtaIniCli.Text + '/' + IntToStr(YearOf(VS_Date)) ,0) > 0;
    End;

    mskDtaFinCli.Enabled := (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniCli.Text))) And
                            Result;
    If not mskDtaFinCli.Enabled Then
      mskDtaFinCli.Clear;
  End
  Else If (Sender = mskDtaFinCli) And (mskDtaFinCli.Enabled) Then
  Begin
    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinCli.Text))) Then
    Begin
      Result := StrToDateDef(mskDtaFinCli.Text + '/' + IntToStr(YearOf(VS_Date)) ,0) > 0;
    End;
  End
  Else If (Sender = mskDtaIniCtt) Then
  Begin
    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniCtt.Text))) Then
    Begin
      Result := StrToDateDef(mskDtaIniCtt.Text + '/'+ IntToStr(YearOf(VS_Date)), 0) > 0;
    End;

    mskDtaFinCtt.Enabled := (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniCtt.Text))) And
                            Result;
    If Not mskDtaFinCtt.Enabled Then
      mskDtaFinCtt.Clear;
  End
  Else If (Sender = mskDtaFinCtt) And (mskDtaFinCtt.Enabled) Then
  Begin
    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinCtt.Text))) Then
    Begin
      Result := StrToDateDef(mskDtaFinCtt.Text + '/' + IntToStr(YearOf(VS_Date)) ,0) > 0;
    End;

  End
  Else If (Sender = mskIniCom) Then
  Begin
    Result := True;
    If Not fEmptyDate(mskIniCom.Text) Then
    Begin
      mskIniCom.Text := FormatDateTime('dd/mm/yyyy', StrToDateDef(mskIniCom.Text,0));
      If StrToDateDef(mskIniCom.Text,0) = 0 Then
      Begin
        Result := False;
        fMensagem('','Informe uma data válida!', ['&OK']);
      End;
    End;

    mskFinCom.Enabled := (Not fEmptyDate(mskIniCom.Text)) And mskIniCom.Enabled;
  End
  Else If (Sender = mskFinCom) And (mskFinCom.Enabled) Then
  Begin
    Result := True;
    If Not fEmptyDate(mskFinCom.Text) Then
    Begin
      mskFinCom.Text := FormatDateTime('dd/mm/yyyy', StrToDateDef(mskFinCom.Text,0));

      If StrToDateDef(mskFinCom.Text,0) < StrToDateDef(mskIniCom.Text,0) Then
      Begin
        Result := False;
        fMensagem('', 'A data final deve ser maior ou igual a data inicial!', ['&OK']);
      End;
    End
    Else
    Begin
      Result := False;
      fMensagem('','Informe uma data válida!', ['&OK']);
    End;
  End
  Else If (Sender = mskIniOrc) Then
  Begin
    Result := True;
    If Not fEmptyDate(mskIniOrc.Text) Then
    Begin
      mskIniOrc.Text := FormatDateTime('dd/mm/yyyy', StrToDateDef(mskIniOrc.Text,0));
      If StrToDateDef(mskIniOrc.Text,0) = 0 Then
      Begin
        Result := False;
        fMensagem('','Informe uma data válida!', ['&OK']);
      End;
    End;

    mskFinOrc.Enabled := (Not fEmptyDate(mskIniOrc.Text)) And mskIniOrc.Enabled;
  End
  Else If (Sender = mskFinOrc) And (mskFinOrc.Enabled) Then
  Begin
    Result := True;
    If Not fEmptyDate(mskFinOrc.Text) Then
    Begin
      mskFinOrc.Text := FormatDateTime('dd/mm/yyyy', StrToDateDef(mskFinOrc.Text,0));

      If StrToDateDef(mskFinOrc.Text,0) < StrToDateDef(mskIniOrc.Text,0) Then
      Begin
        Result := False;
        fMensagem('', 'A data final deve ser maior ou igual a data inicial!', ['&OK']);
      End;

    End
    Else
    Begin
      Result := False;
      fMensagem('','Informe uma data válida!', ['&OK']);
    End;
  End
  Else If (Sender = edtCodGat) Then
    pDesmarcaLista(edtCodGat, arrGruAti)
  Else If (Sender = edtDepVen) Then
    pDesmarcaLista(edtDepVen, arrDepVen)
  Else If (Sender = edtCodMar) Then
    pDesmarcaLista(edtCodMar, arrCodMar)
  Else If (Sender = edtCodIte) Then
    pDesmarcaLista(edtCodIte, arrCodIte)
  Else If (Sender = mskIniSem) Then
  Begin
    Result := True;
    If Not fEmptyDate(mskIniSem.Text) Then
    Begin
      mskIniSem.Text := FormatDateTime('dd/mm/yyyy', StrToDateDef(mskIniSem.Text,0));
      If StrToDateDef(mskIniSem.Text,0) = 0 Then
      Begin
        Result := False;
        fMensagem('','Informe uma data válida!', ['&OK']);
      End;
    End;

    mskFinSem.Enabled := (Not fEmptyDate(mskIniSem.Text)) And mskIniSem.Enabled;
    pTrataCamposProduto();
  End
  Else If (Sender = mskFinSem) And (mskFinSem.Enabled) Then
  Begin
    Result := True;
    If Not fEmptyDate(mskFinSem.Text) Then
    Begin
      mskFinSem.Text := FormatDateTime('dd/mm/yyyy', StrToDateDef(mskFinSem.Text,0));

      If StrToDateDef(mskFinSem.Text,0) < StrToDateDef(mskIniSem.Text,0) Then
      Begin
        Result := False;
        fMensagem('', 'A data final deve ser maior ou igual a data inicial!', ['&OK']);
      End;

    End
    Else
    Begin
      Result := False;
      fMensagem('','Informe uma data válida!', ['&OK']);
    End;
    pTrataCamposProduto();
  End
  Else If (Sender = mskIniSemO) Then
  Begin
    Result := True;
    If Not fEmptyDate(mskIniSemO.Text) Then
    Begin
      mskIniSemO.Text := FormatDateTime('dd/mm/yyyy', StrToDateDef(mskIniSemO.Text,0));
      If StrToDateDef(mskIniSemO.Text,0) = 0 Then
      Begin
        Result := False;
        fMensagem('','Informe uma data válida!', ['&OK']);
      End;
    End;

    mskFinSemO.Enabled := (Not fEmptyDate(mskIniSemO.Text)) And mskIniSemO.Enabled;
    pTrataCamposProduto();
  End
  Else If (Sender = mskFinSemO) And (mskFinSemO.Enabled) Then
  Begin
    Result := True;
    If Not fEmptyDate(mskFinSemO.Text) Then
    Begin
      mskFinSemO.Text := FormatDateTime('dd/mm/yyyy', StrToDateDef(mskFinSemO.Text,0));

      If StrToDateDef(mskFinSemO.Text,0) < StrToDateDef(mskIniSemO.Text,0) Then
      Begin
        Result := False;
        fMensagem('', 'A data final deve ser maior ou igual a data inicial!', ['&OK']);
      End;
    End
    Else
    Begin
      Result := False;
      fMensagem('','Informe uma data válida!', ['&OK']);
    End;
    pTrataCamposProduto();
  End
  Else If (Sender = mskIniComComp) Then
  Begin
    Result := True;
    If Not fEmptyDate(mskIniComComp.Text) Then
    Begin
      mskIniComComp.Text := FormatDateTime('dd/mm/yyyy', StrToDateDef(mskIniComComp.Text,0));
      If StrToDateDef(mskIniComComp.Text,0) = 0 Then
      Begin
        Result := False;
        fMensagem('','Informe uma data válida!', ['&OK']);
      End;
    End;

    mskFinComComp.Enabled := (Not fEmptyDate(mskIniComComp.Text)) And mskIniComComp.Enabled;
    pTrataCamposProduto();
  End
  Else If (Sender = mskFinComComp) And (mskFinComComp.Enabled) Then
  Begin
    Result := True;
    If Not fEmptyDate(mskFinComComp.Text) Then
    Begin
      mskFinComComp.Text := FormatDateTime('dd/mm/yyyy', StrToDateDef(mskFinComComp.Text,0));

      If StrToDateDef(mskFinComComp.Text,0) < StrToDateDef(mskIniComComp.Text,0) Then
      Begin
        Result := False;
        fMensagem('', 'A data final deve ser maior ou igual a data inicial!', ['&OK']);
      End;
    End
    Else
    Begin
      Result := False;
      fMensagem('','Informe uma data válida!', ['&OK']);
    End;
    pTrataCamposProduto();
  End
  Else If (Sender = mskIniVenc) Then
  Begin
    Result := True;
    If Not fEmptyDate(mskIniVenc.Text) Then
    Begin
      mskIniVenc.Text := FormatDateTime('dd/mm/yyyy', StrToDateDef(mskIniVenc.Text,0));
      If StrToDateDef(mskIniVenc.Text,0) = 0 Then
      Begin
        Result := False;
        fMensagem('','Informe uma data válida!', ['&OK']);
      End;
    End;

    mskFinVenc.Enabled := (Not fEmptyDate(mskIniVenc.Text)) And mskIniVenc.Enabled;
  End
  Else If (Sender = mskFinVenc) And (mskFinVenc.Enabled) Then
  Begin
    Result := True;
    If Not fEmptyDate(mskFinVenc.Text) Then
    Begin
      mskFinVenc.Text := FormatDateTime('dd/mm/yyyy', StrToDateDef(mskFinVenc.Text,0));

      If StrToDateDef(mskFinVenc.Text,0) < StrToDateDef(mskIniVenc.Text,0) Then
      Begin
        Result := False;
        fMensagem('', 'A data final deve ser maior ou igual a data inicial!', ['&OK']);
      End;
    End
    Else
    Begin
      Result := False;
      fMensagem('','Informe uma data válida!', ['&OK']);
    End;
  End
  Else If (Sender = edtDiasSem) Then
    pTrataCamposProduto()
  Else If (Sender = edtDiasSemO) Then
    pTrataCamposProduto()
  Else If (Sender = edtDiasComComp) Then
    pTrataCamposProduto()
  Else If (Sender = edtCodCli) Then
  Begin
    If Not fEmptyStr(edtCodCli.Text) Then
    Begin
      pCarregaCliente;
      If fEmptyStr(edtNomCli.Text) Then
      Begin
        fMensagem('ATENÇÃO','Cliente não cadastrado!',['&O K']);
        Result := False;
      End;
    End
    Else
      edtNomCli.Text := 'TODOS';
  End
  Else If (Sender = fraCentroCusto.EdtCodEve) Then
  Begin
    pDesmarcaLista(fraCentroCusto.EdtCodEve, arrEvento);
    If Not fEmptyStr(fraCentroCusto.EdtCodEve.Text) Then
    Begin
      If Not SameText(fraCentroCusto.EdtCodEve.Text, '00000') Then
      Begin
        pCarregaEvento;
        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custo não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (fRetTipoEvento(fraCentroCusto.EdtCodEve.Text) = 'P') Then
        Begin
          fMensagem('ATENÇÃO', 'Esse Centro de Custo pode ser aplicado somente às contas a pagar!',['&OK']);
          Result := False;
        End;
      End;
    End
    Else
    Begin
      fraCentroCusto.edtDesEve.Text := 'TODOS';
    End;
  End
  Else If (Sender = edtEmpDup) Then
  Begin
    pDesmarcaLista(edtEmpDup, arrEmpres);
    If (not fEmptyStr(edtEmpDup.text)) Then
    Begin
      If (Not SameText(edtEmpDup.Text, '000')) Then
      Begin
        pCarregaEmpresaFinanceiro;
        If fEmptyStr(edtNomEmpDup.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If Pos(edtEmpDup.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else
    Begin
      edtNomEmpDup.Text := 'TODOS';
    End;
  End
  Else If (Sender = edtCodEmp) Then
  Begin
    pDesmarcaLista(edtCodEmp, arrCodEmp);
    If (not fEmptyStr(edtCodEmp.text)) Then
    Begin
      If (Not SameText(edtCodEmp.Text, '000')) Then
      Begin
        pCarregaEmpresa;
        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else
    Begin
      edtNomEmp.Text := 'TODOS';
    End;
  End
  Else If (Sender = edtCodEmpCli) Then
  Begin
    If (not fEmptyStr(edtCodEmpCli.text)) Then
    Begin
      pCarregaEmpresaCli;
      pDesmarcaLista(edtCodEmpCli, arrCodEmpCli);
      If (Not SameText(edtCodEmpCli.Text, '000')) Then
      Begin
        If fEmptyStr(edtNomEmpCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If Pos(edtCodEmpCli.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&Ok']);
          Result := False;
        End;
      End
    End;
  End

  Else If (Sender = chkOcoAbe) Then
  Begin
    If chkOcoAbe.CheckBox.Checked And fEmptyStr(edtCodGoc.text) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário informar o grupo de ocorrências!', ['&Ok']);
      Result := False;
    End
    Else If chkOcoAbe.CheckBox.Checked And fEmptyStr(edtCodToc.text) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário informar o tipo de ocorrências!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = chkCatProm) Then
  Begin
    If chkCatProm.Checked Then
    Begin
      Result :=  frameFiltrosCatPromocao.fVerificaCampos;
    End;
  End

  Else If (Sender = edtUltVnd) Then
    pDesmarcaLista(edtUltVnd, arrUltVnd)

  Else If (Sender = edtUltDig) Then
    pDesmarcaLista(edtUltDig, arrUltDig);

end;

procedure TfraCRMGeracaoGlobalFrameParametros.mskLinGruExit(Sender: TObject);
begin
  pEdtCodSelectExit(mskLinGru, edtDesGru, arrLinGru, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);
end;

procedure TfraCRMGeracaoGlobalFrameParametros.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqGrupo(FParentForm, mskLinGru, edtDesGru, nil, Key, arrLinGru, False) Then
  Begin
    If fValidaCampos(mskLinGru, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.pCarregaCliente;
begin
  If Not fEmptyStr(edtCodCli.Text) Then
    edtNomCli.Text := fRetNomCliente(edtCodCli.Text)
  Else
    edtNomCli.Clear;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.pCarregaEmpresaFinanceiro;
begin
  If Not fEmptyStr(edtEmpDup.Text) Then
    edtNomEmpDup.Text := fRetNomeEmpresaSelec(edtEmpDup.Text)
  Else
    edtNomEmpDup.Clear;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.pCarregaEvento;
begin
  If Not fEmptyStr(fraCentroCusto.EdtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.EdtCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.pCarregarTsPromocoes;
begin
  If Not fVerificaAcessoSistema('BTNPRM', strLoginUsuarioLogado) Then
    Exit;

  frameFiltrosCatPromocao.ParentForm := FParentForm;
  frameFiltrosCatPromocao.strCndPag := EmptyStr;
  frameFiltrosCatPromocao.strCodCli := strCodCli;
  frameFiltrosCatPromocao.blnFiltrosProm := True;
  frameFiltrosCatPromocao.pInicializaFiltros;

  chkCatProm.Checked := False;
end;

function TfraCRMGeracaoGlobalFrameParametros.fCarregaRepresentante;
var
  strCodRep: String;
  strNomRep: String;
begin
  Result := False;
  If Not fEmptyStr(edtRepresentante.text) Then
  Begin
    strCodRep := fRetCodVendedor(edtRepresentante.text);
    strNomRep := fRetNomVendRep(strCodRep);
  End
  Else
  Begin
    fMensagem('ATENÇÃO!','Representante não pode ficar em branco!',['&OK']);
    pSetFocus(edtRepresentante);
    Exit;
  End;

  If fEmptyStr(strCodRep) or fEmptyStr(strNomRep) Then
  Begin
    fMensagem('ATENÇÃO!','Representante não encontrado!',['&OK']);
    pSetFocus(edtRepresentante);
    Exit;
  End
  Else
  Begin
    edtDesRepresentante.Text := strNomRep;
    Result := True;
  End;
end;

function TfraCRMGeracaoGlobalFrameParametros.fCarregaVendedor;
var
  strCodVen: String;
  strNomVen: String;
begin
  Result := False;
  If Not fEmptyStr(edtVendedor.text) Then
  Begin
    strCodVen := fRetCodVendedor(edtVendedor.text);
    strNomVen := fRetNomVendRep(strCodVen);
  End
  Else
  Begin
    fMensagem('ATENÇÃO!','Vendedor não pode ficar em branco!',['&OK']);
    pSetFocus(edtVendedor);
    Exit;
  End;

  If fEmptyStr(strCodVen) or fEmptyStr(strNomVen) Then
  Begin
    fMensagem('ATENÇÃO!','Vendedor não encontrado!',['&OK']);
    pSetFocus(edtVendedor);
    Exit;
  End
  Else
  Begin
    edtDesVendedor.Text := strNomVen;
    Result := True;
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.pExecutarEventosComponentes;
begin
  fValidaCampos(mskDtaIniCli);
  fValidaCampos(mskDtaFinCli);
  fValidaCampos(mskDtaIniCtt);
  fValidaCampos(mskDtaFinCtt);
  fValidaCampos(mskIniCom);
  fValidaCampos(mskFinCom);
  fValidaCampos(mskIniOrc);
  fValidaCampos(mskFinOrc);
  fValidaCampos(mskIniSem);
  fValidaCampos(mskFinSem);
  fValidaCampos(mskIniSemO);
  fValidaCampos(mskFinSemO);
  fValidaCampos(mskIniComComp);
  fValidaCampos(mskFinComComp);
  fValidaCampos(mskIniVenc);
  fValidaCampos(mskFinVenc);

  fValidaCampos(edtDiasSem);
  fValidaCampos(edtDiasSemO);
  fValidaCampos(edtDiasComComp);

  fValidaCampos(edtCodCli);
  fValidaCampos(edtCodEmp);
  fValidaCampos(edtCodEmpCli);
  fValidaCampos(edtCodGoc);
  fValidaCampos(edtCodToc);
  fValidaCampos(chkOcoAbe);
  fValidaCampos(chkCatProm);

  edtCrmFreExit(edtCrmFre);
  edtCrmPorExit(edtCrmPor);
  edtCrmFaiExit(edtCrmFai);
  edtCodQuaExit(edtCodQua);
  edtCrmForExit(edtCrmFor);
  edtCodGatExit(edtCodGat);
  edtCodCidExit(edtCodCid);
  edtCodAtiExit(edtCodAti);
  edtCodEmpExit(edtCodEmp);
  edtCodCatExit(edtCodCat);
  edtCodGocExit(edtCodGoc);
  edtCodTocExit(edtCodToc);

  If FblnLiberadoVendedor And (FParentForm.Name = 'frmCRMGeracaoGlobal') Then
    edtVendedorExit(edtVendedor)
  Else If (FParentForm.Name = 'frmCRMGeracaoGlobal') Then
    fValidaCampos(edtVendedor)
  Else
    edtVendedorExit(edtVendedor);

  If FblnLiberadoRepresentante And (FParentForm.Name = 'frmCRMGeracaoGlobal') Then
    edtRepresentanteExit(edtRepresentante)
  Else If (FParentForm.Name = 'frmCRMGeracaoGlobal') Then
    fValidaCampos(edtRepresentante)
  Else
    edtRepresentanteExit(edtRepresentante);

  edtCodRegExit(edtCodReg);
  edtCodSubExit(edtCodSub);
  edtCodRedeExit(edtCodRede);
  edtCodCacExit(edtCodCac);
  edtCgoCttExit(edtCgoCtt);
  edtDepVenExit(edtDepVen);
  edtTfuCttExit(edtTfuCtt);
  edtHobCttExit(edtHobCtt);
  edtEscCttExit(edtEscCtt);
  edtGmuCttExit(edtGmuCtt);
  edtEciCttExit(edtEciCtt);
  edtDptCttExit(edtDptCtt);
  edtCodMarExit(edtCodMar);
  mskLinGruExit(mskLinGru);
  edtCodForExit(edtCodFor);
  edtCodIteExit(edtCodIte);
  edtCliVenExit(edtCliVen);
  edtVenDupExit(edtVenDup);
  edtCodPortadorExit(edtCodPortador);
  fraCentroCustoedtCodEveExit(fraCentroCusto.EdtCodEve);
  edtEmpDupExit(edtEmpDup);
  edtCodEmpCliExit(edtCodEmpCli);

  chkUtiFinClick(chkUtiFin);

  rdgFiltrarPorClick(rdgFiltrarPor);
  rdgClientesPorClick(rdgClientesPor);
  rdgFinanceiroPorClick(rdgFinanceiroPor);
  rdgFiltrarPorEmpresaClick(rdgFiltrarPorEmpresa);
  rdgFiltrarClientesNaoCompEmpresaClick(rdgFiltrarClientesNaoCompEmpresa);

  chkOcoAbeClick(chkOcoAbe);
  chkCatPromClick(chkCatProm);

  edtUltVndExit(edtUltVnd);
  edtUltDigExit(edtUltDig);

end;

procedure TfraCRMGeracaoGlobalFrameParametros.pgcFiltrosChange(Sender: TObject);
begin
  Case pgcFiltros.ActivePageIndex Of
    0: pSetFocus(edtCodCid);
    1: pSetFocus(edtCgoCtt);
    2: pSetFocus(chkUtiCSC);
    3: pSetFocus(chkUtiFin);
  End;

  If pgcFiltros.ActivePageIndex in [1, 2, 3] Then
  Begin
    chkUtiFinClick(chkUtiFin);
    rdgFiltrarPorClick(rdgFiltrarPor);
    rdgClientesPorClick(rdgClientesPor);
    rdgFinanceiroPorClick(rdgFinanceiroPor);
    rdgFiltrarPorEmpresaClick(rdgFiltrarPorEmpresa);
    rdgFiltrarClientesNaoCompEmpresaClick(rdgFiltrarClientesNaoCompEmpresa);
    chkOcoAbeClick(chkOcoAbe);
  End;

  If pgcFiltros.ActivePageIndex in [4] Then
    chkCatPromClick(chkCatProm);

end;

procedure TfraCRMGeracaoGlobalFrameParametros.pLimparComponentes;
begin
  SetLength(arrCrmFre, 0);
  SetLength(arrCrmPor, 0);
  SetLength(arrCrmFai, 0);
  SetLength(arrCodQua, 0);
  SetLength(arrCrmFor, 0);
  SetLength(arrGruAti, 0);
  SetLength(arrCodCid, 0);
  SetLength(arrCodAti, 0);
  SetLength(arrCodVen, 0);
  SetLength(arrCodRep, 0);
  SetLength(arrCodReg, 0);
  SetLength(arrSubReg, 0);
  SetLength(arrCodRed, 0);
  SetLength(arrCanAce, 0);
  SetLength(arrCodCar, 0);
  SetLength(arrCodDep, 0);
  SetLength(arrTimFut, 0);
  SetLength(arrCodHob, 0);
  SetLength(arrCodEsc, 0);
  SetLength(arrGosMus, 0);
  SetLength(arrEstCiv, 0);
  SetLength(arrDepVen, 0);
  SetLength(arrCodMar, 0);
  SetLength(arrLinGru, 0);
  SetLength(arrCodIte, 0);
  SetLength(arrCliVen, 0);
  SetLength(arrVenDup, 0);
  SetLength(arrPortad, 0);
  SetLength(arrEvento, 0);
  SetLength(arrEmpres, 0);
  SetLength(arrCodEmp, 0);
  SetLength(arrCodCat, 0);
  SetLength(arrCodGoc, 0);
  SetLength(arrCodToc, 0);
  SetLength(arrFornec, 0);

  mskDtaIniCli.Clear;
  mskDtaFinCli.Clear;
  mskDtaIniCtt.Clear;
  mskDtaFinCtt.Clear;
  mskIniCom.Clear;
  mskFinCom.Clear;
  mskIniOrc.Clear;
  mskFinOrc.Clear;
  mskIniSem.Clear;
  mskFinSem.Clear;
  mskIniSemO.Clear;
  mskFinSemO.Clear;
  mskIniComComp.Clear;
  mskFinComComp.Clear;
  mskIniVenc.Clear;
  mskFinVenc.Clear;

  edtDiasSem.Clear;
  edtDiasSemO.Clear;
  edtDiasComComp.Clear;
  edtDiasAniversario.Clear;
  edtDiasUltCom.Clear;
  edtDiasUltOrc.Clear;
  edtDiasVenc.Clear;
  edtDiasAVen.Clear;
  edtDiasVenA.Clear;

  edtCrmFre.Clear;
  edtDesFre.Clear;
  edtCrmPor.Clear;
  edtDesCrmPor.Clear;
  edtCrmFai.Clear;
  edtCodQua.Clear;
  edtDesFai.Clear;
  edtCrmFor.Clear;
  edtDesFor.Clear;
  edtCodGat.Clear;
  edtDesGat.Clear;
  edtCodCid.Clear;
  edtNomCid.Clear;
  edtEstado.Clear;
  edtCodAti.Clear;
  edtNomAti.Clear;
  edtVendedor.Clear;
  edtDesVendedor.Clear;
  edtRepresentante.Clear;
  edtDesRepresentante.Clear;
  edtCodReg.Clear;
  edtDesReg.Clear;
  edtCodSub.Clear;
  edtDesSub.Clear;
  edtCodRede.Clear;
  edtDesRede.Clear;
  edtCodCac.Clear;
  edtDesCac.Clear;
  edtCgoCtt.Clear;
  edtDesCgoCtt.Clear;
  edtDepVen.Clear;
  edtDesDep.Clear;
  edtTfuCtt.Clear;
  edtDesTfuCtt.Clear;
  edtHobCtt.Clear;
  edtDesHobCtt.Clear;
  edtEscCtt.Clear;
  edtDesEscCtt.Clear;
  edtGmuCtt.Clear;
  edtDesGmuCtt.Clear;
  edtEciCtt.Clear;
  edtDesEciCtt.Clear;
  edtDptCtt.Clear;
  edtDesDptCtt.Clear;
  edtCodMar.Clear;
  edtDesMar.Clear;
  mskLinGru.Clear;
  edtDesGru.Clear;
  edtCodFor.Clear;
  edtNomFor.Clear;
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtCliVen.Clear;
  edtDesCliVen.Clear;
  edtVenDup.Clear;
  edtDesVenDup.Clear;
  edtCodPortador.Clear;
  edtDesPortador.Clear;
  fraCentroCusto.edtCodEve.Clear;
  fraCentroCusto.edtDesEve.Clear;
  edtEmpDup.Clear;
  edtNomEmpDup.Clear;
  edtCodEmp.Clear;
  edtNomEmp.Clear;
  edtCodCat.Clear;
  edtDesCat.Clear;
  edtCodEmpCli.Clear;
  edtNomEmpCli.Clear;
  edtCodGoc.Clear;
  edtDesGoc.Clear;
  edtCodToc.Clear;
  edtDesToc.Clear;

  cmbRevista.ItemIndex      := 2;
  cmbBoleto.ItemIndex       := 2;
  cmbOrgPub.ItemIndex       := 2;
  cmbStatus.ItemIndex       := 0;
  rdgTipoPessoa.ItemIndex   := 0;
  rdgFiltrarPor.ItemIndex   := 0;
  rdgFinanceiroPor.ItemIndex:= 0;
  rdgClasOfertaCon.ItemIndex:= -1;

  chkUtiCSC.Checked := False;
  chkUtiFin.Checked := False;

  chkUtiFinClick(chkUtiFin);


  chkOcoAbe.CheckBox.Checked := False;
  chkOcoAbeClick(chkOcoAbe);

  rdgFiltrarPorClick(rdgFiltrarPor);
  rdgClientesPorClick(rdgClientesPor);
  rdgFinanceiroPorClick(rdgFinanceiroPor);
  rdgFiltrarPorEmpresaClick(rdgFiltrarPorEmpresa);
  rdgFiltrarClientesNaoCompEmpresaClick(rdgFiltrarClientesNaoCompEmpresa);

  chkCatProm.Checked := False;
  edtUltVnd.Clear;
  edtUltDig.Clear;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.pSetaDataScreen;
begin
  arrCrmFre                 := FParamCon.arrCrmFre;
  arrCrmPor                 := FParamCon.arrCrmPor;
  arrCrmFai                 := FParamCon.arrCrmFai;
  arrCodQua                 := FParamCon.arrCodQua;
  arrCrmFor                 := FParamCon.arrCrmFor;
  arrGruAti                 := FParamCon.arrGruAti;
  arrCodCid                 := FParamCon.arrCodCid;
  arrCodAti                 := FParamCon.arrCodAti;
  arrCodVen                 := FParamCon.arrCodVen;
  arrCodRep                 := FParamCon.arrCodRep;
  arrCodReg                 := FParamCon.arrCodReg;
  arrSubReg                 := FParamCon.arrSubReg;
  arrCodRed                 := FParamCon.arrCodRed;
  arrCanAce                 := FParamCon.arrCanAce;
  arrCodCar                 := FParamCon.arrCodCar;
  arrCodDep                 := FParamCon.arrCodDep;
  arrTimFut                 := FParamCon.arrTimFut;
  arrCodHob                 := FParamCon.arrCodHob;
  arrCodEsc                 := FParamCon.arrCodEsc;
  arrGosMus                 := FParamCon.arrGosMus;
  arrEstCiv                 := FParamCon.arrEstCiv;
  arrDepVen                 := FParamCon.arrDepVen;
  arrCodMar                 := FParamCon.arrCodMar;
  arrLinGru                 := FParamCon.arrLinGru;
  arrCodIte                 := FParamCon.arrCodIte;
  arrCliVen                 := FParamCon.arrCliVen;
  arrVenDup                 := FParamCon.arrVenDup;
  arrPortad                 := FParamCon.arrPortad;
  arrEvento                 := FParamCon.arrEvento;
  arrEmpres                 := FParamCon.arrEmpres;
  arrCodEmp                 := FParamCon.arrCodEmp;
  arrCodCat                 := FParamCon.arrCodCat;
  arrCodEmpCli              := FParamCon.arrCodEmpCli;
  arrCodGoc                 := FParamCon.arrCodGoc;
  arrCodToc                 := FParamCon.arrCodToc;
  arrFornec                 := FParamCon.arrFornec;

  chkUtiCSC.Checked         := FParamCon.chkUtiCSC;
  chkUtiFin.Checked         := FParamCon.chkUtiFin;

  mskDtaIniCli.Text         := FParamCon.dtaIniCli;
  mskDtaFinCli.Text         := FParamCon.dtaFinCli;
  mskDtaIniCtt.Text         := FParamCon.dtaIniCtt;
  mskDtaFinCtt.Text         := FParamCon.dtaFinCtt;
  mskIniCom.Text            := FParamCon.dtaIniCom;
  mskFinCom.Text            := FParamCon.dtaFinCom;
  mskIniOrc.Text            := FParamCon.dtaIniOrc;
  mskFinOrc.Text            := FParamCon.dtaFinOrc;
  mskIniSem.Text            := FParamCon.dtaIniSem;
  mskFinSem.Text            := FParamCon.dtaFinSem;
  mskIniSemO.Text           := FParamCon.dtaIniSeO;
  mskFinSemO.Text           := FParamCon.dtaFinSeO;
  mskIniComComp.Text        := FParamCon.dtaIniCCM;
  mskFinComComp.Text        := FParamCon.dtaFinCCM;
  mskIniVenc.Text           := FParamCon.dtaIniVen;
  mskFinVenc.Text           := FParamCon.dtaFinVen;

  edtDiasSem.Text           := FParamCon.edtDiaSem;
  edtDiasSemO.Text          := FParamCon.edtDiaSeO;
  edtDiasComComp.Text       := FParamCon.edtDiaCCM;
  edtDiasAniversario.Text   := FParamCon.edtDiaCli;
  edtDiasUltCom.Text        := FParamCon.edtDiaCom;
  edtDiasUltOrc.Text        := FParamCon.edtDiaOrc;
  edtDiasVenc.Text          := FParamCon.edtDiaVen;
  edtDiasAVen.Text          := FParamCon.edtDiaAVe;
  edtDiasVenA.Text          := FParamCon.edtDiaVenA;

  edtCrmFre.Text            := FParamCon.edtCrmFre;
  edtCrmPor.Text            := FParamCon.edtCrmPor;
  edtCrmFai.Text            := FParamCon.edtCrmFai;
  edtCodQua.Text            := FParamCon.edtCodQua;
  edtCrmFor.Text            := FParamCon.edtCrmFor;
  edtCodGat.Text            := FParamCon.edtCodGat;
  edtCodCid.Text            := FParamCon.edtCodCid;
  edtCodAti.Text            := FParamCon.edtCodAti;
  edtVendedor.Text          := FParamCon.edtCodVen;
  edtRepresentante.Text     := FParamCon.edtCodRep;
  edtCodReg.Text            := FParamCon.edtCodReg;
  edtCodSub.Text            := FParamCon.edtCodSub;
  edtCodRede.Text           := FParamCon.edtCodRed;
  edtCodCac.Text            := FParamCon.edtCodCac;
  edtCgoCtt.Text            := FParamCon.edtCgoCtt;
  edtDepVen.Text            := FParamCon.edtDepVen;
  edtTfuCtt.Text            := FParamCon.edtTfuCtt;
  edtHobCtt.Text            := FParamCon.edtHobCtt;
  edtEscCtt.Text            := FParamCon.edtEscCtt;
  edtGmuCtt.Text            := FParamCon.edtGmuCtt;
  edtEciCtt.Text            := FParamCon.edtEciCtt;
  edtDptCtt.Text            := FParamCon.edtDptCtt;
  edtCodMar.Text            := FParamCon.edtCodMar;
  mskLinGru.Text            := FParamCon.edtLinGru;
  edtCodFor.Text            := FParamCon.edtCodFor;
  edtCodIte.Text            := FParamCon.edtCodIte;
  edtCodCli.Text            := FParamCon.edtCodCli;
  edtCliVen.Text            := FParamCon.edtCliVen;
  edtVenDup.Text            := FParamCon.edtVenDup;
  edtCodPortador.Text       := FParamCon.edtCodPor;
  fraCentroCusto.EdtCodEve.Text            := FParamCon.edtCodEve;
  edtEmpDup.Text            := FParamCon.edtEmpDup;
  edtCodEmpCli.Text         := FParamCon.edtCodEmpCli;

  edtDesFre.Text            := FParamCon.edtDesFre;
  edtDesCrmPor.Text         := FParamCon.edtDesCPo;
  edtDesFai.Text            := FParamCon.edtDesFai;
  edtDesFor.Text            := FParamCon.edtDesFor;
  edtDesGat.Text            := FParamCon.edtDesGat;
  edtNomCid.Text            := FParamCon.edtNomCid;
  edtNomAti.Text            := FParamCon.edtNomAti;
  edtDesVendedor.Text       := FParamCon.edtDesVen;
  edtDesRepresentante.Text  := FParamCon.edtDesRep;
  edtDesReg.Text            := FParamCon.edtDesReg;
  edtDesSub.Text            := FParamCon.edtDesSub;
  edtDesRede.Text           := FParamCon.edtDesRed;
  edtDesCac.Text            := FParamCon.edtDesCac;
  edtDesCgoCtt.Text         := FParamCon.edtDesCgo;
  edtDesDep.Text            := FParamCon.edtDesDep;
  edtDesTfuCtt.Text         := FParamCon.edtDesTfu;
  edtDesHobCtt.Text         := FParamCon.edtDesHob;
  edtDesEscCtt.Text         := FParamCon.edtDesEsc;
  edtDesGmuCtt.Text         := FParamCon.edtDesGmu;
  edtDesEciCtt.Text         := FParamCon.edtDesEci;
  edtDesDptCtt.Text         := FParamCon.edtDesDpt;
  edtDesMar.Text            := FParamCon.edtDesMar;
  edtDesGru.Text            := FParamCon.edtDesGru;
  edtNomFor.Text            := FParamCon.edtNomFor;
  edtDesIte.Text            := FParamCon.edtDesIte;
  edtNomCli.Text            := FParamCon.edtNomCli;
  edtDesCliVen.Text         := FParamCon.edtDClVen;
  edtDesVenDup.Text         := FParamCon.edtDVeDup;
  edtDesPortador.Text       := FParamCon.edtDesPor;
  fraCentroCusto.edtDesEve.Text            := FParamCon.edtDesEve;
  edtNomEmpDup.Text         := FParamCon.edtNomEmpDup;
  edtNomEmp.Text            := FParamCon.edtNomEmp;
  edtCodEmp.Text            := FParamCon.edtCodEmp;
  edtCodCat.Text            := FParamCon.edtCodCat;
  edtDesCat.Text            := FParamCon.edtDesCat;
  edtNomEmpCli.Text         := FParamCon.edtCodEmpCli;

  edtCodGoc.Text            := FParamCon.edtCodGoc;
  edtDesGoc.Text            := FParamCon.edtDesGoc;
  edtCodToc.Text            := FParamCon.edtCodToc;
  edtDesToc.Text            := FParamCon.edtDesToc;

  cmbRevista.ItemIndex      := FParamCon.intCbxRev;
  cmbBoleto.ItemIndex       := FParamCon.intCbxBol;
  cmbOrgPub.ItemIndex       := FParamCon.intCbxOrg;
  cmbStatus.ItemIndex       := FParamCon.intCbxSta;

  rdgTipoPessoa.ItemIndex   := FParamCon.intTipPes;
  rdgFiltrarPor.ItemIndex   := FParamCon.intFilPor;
  rdgClientesPor.ItemIndex  := FParamCon.intCliPor;
  rdgClasOfertaCon.ItemIndex:= FParamCon.intOfeCon;
  rdgFinanceiroPor.ItemIndex:= FParamCon.intFinPor;
  rdgFiltrarPorEmpresa.ItemIndex := FParamCon.intEmpDup;
  rdgFiltrarClientesNaoCompEmpresa.ItemIndex := FParamCon.intTipEmp;

  chkOcoAbe.CheckBox.Checked := FParamCon.chkOcoAbe;

  chkCatProm.Checked := FParamPrm.chkCatProm;

  edtUltVnd.Text            := FParamCon.edtUltVnd;
  edtNomUltVnd.Text         := FParamCon.edtNomUltVnd;
  edtUltDig.Text            := FParamCon.edtUltDig;
  edtNomUltDig.Text         := FParamCon.edtNomUltDig;

  pExecutarEventosComponentes();
end;

procedure TfraCRMGeracaoGlobalFrameParametros.pSetaParamClass;
begin
  pExecutarEventosComponentes();

  FParamCon.chkUtiCSC := chkUtiCSC.Checked;
  FparamCon.chkUtiFin := chkUtiFin.Checked;

  FParamCon.dtaIniCli := mskDtaIniCli.Text;
  FParamCon.dtaFinCli := mskDtaFinCli.Text;
  FParamCon.dtaIniCtt := mskDtaIniCtt.Text;
  FParamCon.dtaFinCtt := mskDtaFinCtt.Text;
  FParamCon.dtaIniCom := mskIniCom.Text;
  FParamCon.dtaFinCom := mskFinCom.Text;
  FParamCon.dtaIniOrc := mskIniOrc.Text;
  FParamCon.dtaFinOrc := mskFinOrc.Text;
  FParamCon.dtaIniSem := mskIniSem.Text;
  FParamCon.dtaFinSem := mskFinSem.Text;
  FParamCon.dtaIniSeO := mskIniSemO.Text;
  FParamCon.dtaFinSeO := mskFinSemO.Text;
  FParamCon.dtaIniCCM := mskIniComComp.Text;
  FParamCon.dtaFinCCM := mskFinComComp.Text;
  FParamCon.dtaIniVen := mskIniVenc.Text;
  FParamCon.dtaFinVen := mskFinVenc.Text;

  FParamCon.edtDiaSem := edtDiasSem.Text;
  FParamCon.edtDiaSeO := edtDiasSemO.Text;
  FParamCon.edtDiaCCM := edtDiasComComp.Text;
  FParamCon.edtDiaCli := edtDiasAniversario.Text;
  FParamCon.edtDiaCom := edtDiasUltCom.Text;
  FParamCon.edtDiaOrc := edtDiasUltOrc.Text;
  FParamCon.edtDiaVen := edtDiasVenc.Text;
  FParamCon.edtDiaAVe := edtDiasAVen.Text;
  FParamCon.edtDiaVenA := edtDiasVenA.Text;

  FParamCon.edtCrmFre := edtCrmFre.Text;
  FParamCon.edtCrmPor := edtCrmPor.Text;
  FParamCon.edtCrmFai := edtCrmFai.Text;
  FParamCon.edtCodQua := edtCodQua.Text;
  FParamCon.edtCrmFor := edtCrmFor.Text;
  FParamCon.edtCodGat := edtCodGat.Text;
  FParamCon.edtCodCid := edtCodCid.Text;
  FParamCon.edtCodAti := edtCodAti.Text;
  If FParentForm.Name = 'frmCRMGeracaoGlobal' Then
  Begin
    FParamCon.edtCodVen := IIF(FblnLiberadoVendedor, edtVendedor.Text, fRetCodVendedor(edtVendedor.Text) );
    FParamCon.edtCodRep := IIF(FblnLiberadoRepresentante, edtRepresentante.Text, fRetCodVendedor(edtRepresentante.Text) )
  End
  Else
  Begin
    FParamCon.edtCodVen := edtVendedor.Text;
    FParamCon.edtCodRep := edtRepresentante.Text;
  End;
  FParamCon.edtCodReg := edtCodReg.Text;
  FParamCon.edtCodSub := edtCodSub.Text;
  FParamCon.edtCodRed := edtCodRede.Text;
  FParamCon.edtCodCac := edtCodCac.Text;
  FParamCon.edtCgoCtt := edtCgoCtt.Text;
  FParamCon.edtDepVen := edtDepVen.Text;
  FParamCon.edtTfuCtt := edtTfuCtt.Text;
  FParamCon.edtHobCtt := edtHobCtt.Text;
  FParamCon.edtEscCtt := edtEscCtt.Text;
  FParamCon.edtGmuCtt := edtGmuCtt.Text;
  FParamCon.edtEciCtt := edtEciCtt.Text;
  FParamCon.edtDptCtt := edtDptCtt.Text;
  FParamCon.edtCodMar := edtCodMar.Text;
  FParamCon.edtLinGru := mskLinGru.Text;
  FParamCon.edtCodFor := edtCodFor.Text;
  FParamCon.edtCodIte := edtCodIte.Text;
  FParamCon.edtCodCli := edtCodCli.Text;
  FParamCon.edtCliVen := edtCliVen.Text;
  FParamCon.edtVenDup := edtVenDup.Text;
  FParamCon.edtCodPor := edtCodPortador.Text;
  FParamCon.edtCodEve := fraCentroCusto.EdtCodEve.Text;
  FParamCon.edtEmpDup := edtEmpDup.Text;
  FParamCon.edtCodEmpCli := edtCodEmpCli.Text;

  FParamCon.edtDesFre := edtDesFre.Text;
  FParamCon.edtDesCPo := edtDesCrmPor.Text;
  FParamCon.edtDesFai := edtDesFai.Text;
  FParamCon.edtDesFor := edtDesFor.Text;
  FParamCon.edtDesGat := edtDesGat.Text;
  FParamCon.edtNomCid := edtNomCid.Text;
  FParamCon.edtNomAti := edtNomAti.Text;
  FParamCon.edtDesVen := edtDesVendedor.Text;
  FParamCon.edtDesRep := edtDesRepresentante.Text;
  FParamCon.edtDesReg := edtDesReg.Text;
  FParamCon.edtDesSub := edtDesSub.Text;
  FParamCon.edtDesRed := edtDesRede.Text;
  FParamCon.edtDesCac := edtDesCac.Text;
  FParamCon.edtDesCgo := edtDesCgoCtt.Text;
  FParamCon.edtDesDep := edtDesDep.Text;
  FParamCon.edtDesTfu := edtDesTfuCtt.Text;
  FParamCon.edtDesHob := edtDesHobCtt.Text;
  FParamCon.edtDesEsc := edtDesEscCtt.Text;
  FParamCon.edtDesGmu := edtDesGmuCtt.Text;
  FParamCon.edtDesEci := edtDesEciCtt.Text;
  FParamCon.edtDesDpt := edtDesDptCtt.Text;
  FParamCon.edtDesMar := edtDesMar.Text;
  FParamCon.edtDesGru := edtDesGru.Text;
  FParamCon.edtNomFor := edtNomFor.Text;
  FParamCon.edtDesIte := edtDesIte.Text;
  FParamCon.edtNomCli := edtNomCli.Text;
  FParamCon.edtDClVen := edtDesCliVen.Text;
  FParamCon.edtDVeDup := edtDesVenDup.Text;
  FParamCon.edtDesPor := edtDesPortador.Text;
  FParamCon.edtDesEve := fraCentroCusto.edtDesEve.Text;
  FParamCon.edtNomEmpDup := edtNomEmpDup.Text;
  FParamCon.edtCodEmp := edtCodEmp.Text;
  FParamCon.edtNomEmp := edtNomEmp.Text;
  FParamCon.edtCodCat := edtCodCat.Text;
  FParamCon.edtDesCat := edtDesCat.Text;
  FParamCon.edtNomEmpCli := edtNomEmpCli.Text;

  FParamCon.edtCodGoc := edtCodGoc.Text;
  FParamCon.edtDesGoc := edtDesGoc.Text;
  FParamCon.edtCodToc := edtCodToc.Text;
  FParamCon.edtDesToc := edtDesToc.Text;
  FParamCon.chkOcoAbe := chkOcoAbe.CheckBox.Checked;

  FParamCon.intCbxRev := cmbRevista.ItemIndex;
  FParamCon.intCbxBol := cmbBoleto.ItemIndex;
  FParamCon.intCbxOrg := cmbOrgPub.ItemIndex;
  FParamCon.intCbxSta := cmbStatus.ItemIndex;
  FParamCon.intTipPes := rdgTipoPessoa.ItemIndex;
  FParamCon.intFilPor := rdgFiltrarPor.ItemIndex;
  FParamCon.intOfeCon := rdgClasOfertaCon.ItemIndex;
  FParamCon.intCliPor := rdgClientesPor.ItemIndex;
  FParamCon.intFinPor := rdgFinanceiroPor.ItemIndex;
  FParamCon.intEmpDup := rdgFiltrarPorEmpresa.ItemIndex;
  FParamCon.intTipEmp := rdgFiltrarClientesNaoCompEmpresa.ItemIndex;

  If (rdgClasOfertaCon.ItemIndex > -1) Then
    FParamCon.strOfeCon := LeftStr(rdgClasOfertaCon.Items[rdgClasOfertaCon.ItemIndex], 1);

  FParamCon.edtUltVnd := edtUltVnd.Text;
  FParamCon.edtNomUltVnd := edtNomUltVnd.Text;
  FParamCon.edtUltDig := edtUltDig.Text;
  FParamCon.edtNomUltDig := edtNomUltDig.Text;

  FParamCon.arrCrmFre := arrCrmFre;
  FParamCon.arrCrmPor := arrCrmPor;
  FParamCon.arrCrmFai := arrCrmFai;
  FParamCon.arrCrmFor := arrCrmFor;
  FParamCon.arrGruAti := arrGruAti;
  FParamCon.arrCodCid := arrCodCid;
  FParamCon.arrCodAti := arrCodAti;
  FParamCon.arrCodVen := arrCodVen;
  FParamCon.arrCodRep := arrCodRep;
  FParamCon.arrCodReg := arrCodReg;
  FParamCon.arrSubReg := arrSubReg;
  FParamCon.arrCodRed := arrCodRed;
  FParamCon.arrCanAce := arrCanAce;
  FParamCon.arrCodCar := arrCodCar;
  FParamCon.arrCodDep := arrCodDep;
  FParamCon.arrTimFut := arrTimFut;
  FParamCon.arrCodHob := arrCodHob;
  FParamCon.arrCodEsc := arrCodEsc;
  FParamCon.arrGosMus := arrGosMus;
  FParamCon.arrEstCiv := arrEstCiv;
  FParamCon.arrDepVen := arrDepVen;
  FParamCon.arrCodMar := arrCodMar;
  FParamCon.arrLinGru := arrLinGru;
  FParamCon.arrCodIte := arrCodIte;
  FParamCon.arrCliVen := arrCliVen;
  FParamCon.arrVenDup := arrVenDup;
  FParamCon.arrPortad := arrPortad;
  FParamCon.arrEvento := arrEvento;
  FParamCon.arrEmpres := arrEmpres;
  FParamCon.arrCodEmp := arrCodEmp;
  FParamCon.arrCodCat := arrCodCat;
  FParamCon.arrCodEmpCli := arrCodEmpCli;
  FParamCon.arrCodGoc := arrCodGoc;
  FParamCon.arrCodToc := arrCodToc;
  FParamCon.arrFornec := arrFornec;
  FParamCon.arrUltVnd := arrUltVnd;
  FParamCon.arrUltDig := arrUltDig;

  pSetFiltrosPromocao;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.pSetFiltrosPromocao;
begin
  If Not Assigned(FParamPrm) Then
    Exit;

  FParamPrm.chkCatProm := chkCatProm.Checked;
  frameFiltrosCatPromocao.pSetParamObjCatProm(FParamPRM.ObjCatalogoPromocao);
end;

procedure TfraCRMGeracaoGlobalFrameParametros.pTrataCamposProduto;
  Var
    blnEnabled: Boolean;
begin
  If (Not chkUtiCSC.Enabled) Then
    Exit;

  blnEnabled := (fFiltrarPeriodoSemCompra() Or
                 fFiltrarPeriodoSemOrcamento() Or
                 fFiltrarPeriodoComCompra()) And chkUtiCSC.Checked;

  edtDepVen.Enabled := blnEnabled;
  edtCodMar.Enabled := blnEnabled;
  mskLinGru.Enabled := blnEnabled;
  edtCodFor.Enabled := blnEnabled;
  edtCodIte.Enabled := blnEnabled;
  rdgClasOfertaCon.Enabled := blnEnabled;

  If rdgClasOfertaCon.Enabled And (rdgClasOfertaCon.ItemIndex < 0) Then
    rdgClasOfertaCon.ItemIndex := 0
  Else
  If (Not rdgClasOfertaCon.Enabled) And Assigned(FParamCon) And
    FEmptyStr(FParamCon.strOfeCon) And chkUtiCSC.Checked Then
    rdgClasOfertaCon.ItemIndex := -1;

  If (Not edtDepVen.Enabled) And chkUtiCSC.Checked Then
  Begin
    edtDepVen.Clear;
    edtDesDep.Clear;
  End;

  If (Not edtCodMar.Enabled) And chkUtiCSC.Checked Then
  Begin
    edtCodMar.Clear;
    edtDesMar.Clear;
  End;

  If (Not mskLinGru.Enabled) And chkUtiCSC.Checked Then
  Begin
    mskLinGru.Clear;
    edtDesGru.Clear;
  End;

  If (Not edtCodFor.Enabled) And (chkUtiCSC.Checked) Then
  Begin
    edtCodFor.Clear;
    edtNomFor.Clear;
  End;

  If (Not edtCodIte.Enabled) And chkUtiCSC.Checked Then
  Begin
    edtCodIte.Clear;
    edtDesIte.Clear;
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.pTrataFiltrosClientes;
begin
  If (Not rdgClientesPor.Enabled) Then
    Exit;

  grbPeriodoCliente.Enabled := (rdgClientesPor.ItemIndex = 0);
  grbDiasCliente.Enabled    := (rdgClientesPor.ItemIndex = 1);

  mskIniCom.Enabled := grbPeriodoCliente.Enabled;
  mskIniOrc.Enabled := grbPeriodoCliente.Enabled;
  mskDtaIniCli.Enabled := grbPeriodoCliente.Enabled;

  edtDiasUltCom.Enabled := grbDiasCliente.Enabled;
  edtDiasUltOrc.Enabled := grbDiasCliente.Enabled;
  edtDiasAniversario.Enabled := grbDiasCliente.Enabled;

  If rdgClientesPor.Enabled Then
  Begin
    If Not grbPeriodoCliente.Enabled Then
    Begin
      mskIniCom.Clear;
      mskFinCom.Clear;
      mskFinCom.Enabled := False;
      mskIniOrc.Clear;
      mskFinOrc.Clear;
      mskFinOrc.Enabled := False;
      mskDtaIniCli.Clear;
      mskDtaFinCli.Clear;
      mskDtaFinCli.Enabled := False;
    End
    Else
    Begin
      edtDiasUltCom.Clear;
      edtDiasUltOrc.Clear;
      edtDiasAniversario.Clear;
    End;
  End;

  chkOcoAbeClick(chkOcoAbe);
end;

procedure TfraCRMGeracaoGlobalFrameParametros.pTrataFiltrosClientesSemComprasNoPeriodo;
begin
  If (Not rdgFiltrarPor.Enabled) And (Not chkUtiCSC.Enabled) Then
    Exit;

  rdgFiltrarPor.Enabled := chkUtiCSC.Checked;

  grbPeriodoEntreDatas.Enabled := rdgFiltrarPor.Enabled And
                                  (rdgFiltrarPor.ItemIndex = 0);
  grbPeriodoComComp.Enabled    := grbPeriodoEntreDatas.Enabled;
  grbUltimosDias.Enabled       := rdgFiltrarPor.Enabled And
                                  (rdgFiltrarPor.ItemIndex = 1);
  grbDiasComComp.Enabled       := grbUltimosDias.Enabled;

  mskIniSem.Enabled := grbPeriodoEntreDatas.Enabled;
  mskIniSemO.Enabled := grbPeriodoEntreDatas.Enabled;
  mskIniComComp.Enabled := grbPeriodoComComp.Enabled;

  edtDiasSem.Enabled := grbUltimosDias.Enabled;
  edtDiasSemO.Enabled := grbUltimosDias.Enabled;
  edtDiasComComp.Enabled := grbDiasComComp.Enabled;

  edtCodEmp.Enabled := chkUtiCSC.Checked;
  rdgFiltrarClientesNaoCompEmpresa.Enabled := chkUtiCSC.Checked;
  edtUltVnd.Enabled := chkUtiCSC.Checked;
  edtUltDig.Enabled := chkUtiCSC.Checked;

  If rdgFiltrarPor.Enabled Then
  Begin
    If Not grbPeriodoEntreDatas.Enabled Then
    Begin
      mskIniSem.Clear;
      mskFinSem.Clear;
      mskFinSem.Enabled := False;
      mskIniSemO.Clear;
      mskFinSemO.Clear;
      mskFinSemO.Enabled := False;
      mskIniComComp.Clear;
      mskFinComComp.Clear;
      mskFinComComp.Enabled := False;
    End
    Else
    Begin
      edtDiasSem.Clear;
      edtDiasSemO.Clear;
      edtDiasComComp.Clear;
    End;
  End;

  pTrataCamposProduto();
end;

procedure TfraCRMGeracaoGlobalFrameParametros.pTrataFiltrosFinanceiro;
begin
  If (Not rdgFinanceiroPor.Enabled) And (Not chkUtiFin.Enabled) Then
    Exit;

  rdgFinanceiroPor.Enabled := chkUtiFin.Checked;

  rdgFiltrarPorEmpresa.Enabled := chkUtiFin.Checked;

  grbPeriodoVencimento.Enabled := rdgFinanceiroPor.Enabled And
                                  (rdgFinanceiroPor.ItemIndex = 0);
  grbDiasVencimento.Enabled    := rdgFinanceiroPor.Enabled And
                                  (rdgFinanceiroPor.ItemIndex = 1);

  mskIniVenc.Enabled := grbPeriodoVencimento.Enabled;
  edtDiasVenc.Enabled:= grbDiasVencimento.Enabled;
  edtDiasAVen.Enabled:= grbDiasVencimento.Enabled;
  edtDiasVenA.Enabled:= grbDiasVencimento.Enabled;

  If rdgFinanceiroPor.Enabled Then
  Begin
    If Not grbPeriodoVencimento.Enabled Then
    Begin
      mskIniVenc.Clear;
      mskFinVenc.Clear;
      mskFinVenc.Enabled := False;
    End
    Else
    Begin
      edtDiasVenc.Clear;
      edtDiasAVen.Clear;
      edtDiasVenA.Clear;
    End;
  End;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.pTrataFiltrosPromocao;
begin
  frameFiltrosCatPromocao.pHabilitarDesabilitar(chkCatProm.Checked);
end;

procedure TfraCRMGeracaoGlobalFrameParametros.pHabilitarComponentes(
  const blnHabilitar: Boolean);
begin
  mskDtaIniCli.Enabled      := blnHabilitar;
  mskDtaIniCtt.Enabled      := blnHabilitar;
  mskIniCom.Enabled         := blnHabilitar;
  mskIniOrc.Enabled         := blnHabilitar;

  If Not blnHabilitar Then
  Begin
    mskDtaFinCli.Enabled    := blnHabilitar;
    mskDtaFinCtt.Enabled    := blnHabilitar;
    mskFinCom.Enabled       := blnHabilitar;
    mskFinOrc.Enabled       := blnHabilitar;
    mskFinSem.Enabled       := blnHabilitar;
    mskFinSemO.Enabled      := blnHabilitar;
    mskFinComComp.Enabled   := blnHabilitar;
    mskFinVenc.Enabled      := blnHabilitar;
  End;

  mskIniSem.Enabled         := blnHabilitar;
  mskIniSemO.Enabled        := blnHabilitar;
  mskIniComComp.Enabled     := blnHabilitar;
  mskIniVenc.Enabled        := blnHabilitar;

  edtDiasSem.Enabled        := blnHabilitar;
  edtDiasSemO.Enabled       := blnHabilitar;
  edtDiasComComp.Enabled    := blnHabilitar;
  edtDiasAniversario.Enabled:= blnHabilitar;
  edtDiasUltCom.Enabled     := blnHabilitar;
  edtDiasUltOrc.Enabled     := blnHabilitar;
  edtDiasVenc.Enabled       := blnHabilitar;
  edtDiasAVen.Enabled       := blnHabilitar;
  edtDiasVenA.Enabled       := blnHabilitar;

  edtCrmFre.Enabled         := blnHabilitar;
  edtCrmPor.Enabled         := blnHabilitar;
  edtCrmFai.Enabled         := blnHabilitar;
  edtCodQua.Visible         := blnHabilitar And fCfgSis('USAQUA', varBoolean);
  labelCadQua.Visible       := blnHabilitar And fCfgSis('USAQUA', varBoolean);
  edtDesQua.Visible         := blnHabilitar And fCfgSis('USAQUA', varBoolean);
  edtCrmFor.Enabled         := blnHabilitar;
  edtCodGat.Enabled         := blnHabilitar;
  edtCodCid.Enabled         := blnHabilitar;
  edtCodAti.Enabled         := blnHabilitar;
  edtVendedor.Enabled       := blnHabilitar;
  edtRepresentante.Enabled  := blnHabilitar;
  edtCodReg.Enabled         := blnHabilitar;
  edtCodSub.Enabled         := blnHabilitar;
  edtCodRede.Enabled        := blnHabilitar;
  edtCodCac.Enabled         := blnHabilitar;
  edtCgoCtt.Enabled         := blnHabilitar;
  edtDepVen.Enabled         := blnHabilitar;
  edtTfuCtt.Enabled         := blnHabilitar;
  edtHobCtt.Enabled         := blnHabilitar;
  edtEscCtt.Enabled         := blnHabilitar;
  edtGmuCtt.Enabled         := blnHabilitar;
  edtEciCtt.Enabled         := blnHabilitar;
  edtDptCtt.Enabled         := blnHabilitar;
  edtCodMar.Enabled         := blnHabilitar;
  mskLinGru.Enabled         := blnHabilitar;
  edtCodFor.Enabled         := blnHabilitar;
  edtCodIte.Enabled         := blnHabilitar;
  edtCodCli.Enabled         := blnHabilitar;
  edtCliVen.Enabled         := blnHabilitar;
  edtVenDup.Enabled         := blnHabilitar;
  edtCodPortador.Enabled    := blnHabilitar;
  fraCentroCusto.EdtCodEve.Enabled         := blnHabilitar;
  edtEmpDup.Enabled         := blnHabilitar;
  edtCodemp.Enabled         := blnHabilitar;
  edtCodCat.Enabled         := blnHabilitar;
  edtCodEmpCli.Enabled      := blnHabilitar;

  edtCodGoc.Enabled         := blnHabilitar;
  edtCodToc.Enabled         := blnHabilitar;
  chkOcoAbe.Enabled         := blnHabilitar;
  cmbRevista.Enabled        := blnHabilitar;
  cmbBoleto.Enabled         := blnHabilitar;
  cmbOrgPub.Enabled         := blnHabilitar;
  cmbStatus.Enabled         := blnHabilitar;

  chkUtiCSC.Enabled         := blnHabilitar;
  chkUtiFin.Enabled         := blnHabilitar;

  rdgTipoPessoa.Enabled     := blnHabilitar;
  rdgFiltrarPor.Enabled     := blnHabilitar;
  rdgClientesPor.Enabled    := blnHabilitar;
  rdgClasOfertaCon.Enabled  := blnHabilitar;
  rdgFinanceiroPor.Enabled  := blnHabilitar;

  If blnHabilitar Then
  Begin
    chkUtiFinClick(chkUtiFin);

    rdgFinanceiroPorClick(rdgFinanceiroPor);
    rdgClientesPorClick(rdgClientesPor);
    rdgFiltrarPorClick(rdgFiltrarPor);
    pTrataCamposProduto();
    rdgFiltrarClientesNaoCompEmpresaClick(rdgFiltrarClientesNaoCompEmpresa);

    chkOcoAbeClick(chkOcoAbe);
  End;

  shpLiberadoVendedor.Visible      := FParentForm.Name = 'frmCRMGeracaoGlobal';
  shpLiberadoRepresentante.Visible := FParentForm.Name = 'frmCRMGeracaoGlobal';

  chkCatProm.Enabled := fVerificaAcessoSistema('BTNPRM', strLoginUsuarioLogado);
  edtUltVnd.Enabled         := blnHabilitar;
  edtUltDig.Enabled         := blnHabilitar;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.rdgClientesPorClick(
  Sender: TObject);
begin
  pTrataFiltrosClientes();
end;

procedure TfraCRMGeracaoGlobalFrameParametros.rdgFiltrarClientesNaoCompEmpresaClick(
  Sender: TObject);
begin
  pTrataFiltrosClientesSemComprasNoPeriodo();
end;

procedure TfraCRMGeracaoGlobalFrameParametros.rdgFiltrarPorClick(
  Sender: TObject);
begin
  pTrataFiltrosClientesSemComprasNoPeriodo();
end;

procedure TfraCRMGeracaoGlobalFrameParametros.rdgFiltrarPorEmpresaClick(
  Sender: TObject);
begin
  pTrataFiltrosFinanceiro();
end;

procedure TfraCRMGeracaoGlobalFrameParametros.rdgFinanceiroPorClick(
  Sender: TObject);
begin
  pTrataFiltrosFinanceiro();
end;

procedure TfraCRMGeracaoGlobalFrameParametros.pSetLiberadoRepresentante(
  const value: Boolean);
begin
  FblnLiberadoRepresentante := value;
  If Not value Then
  Begin
    edtRepresentante.MaxLength := 10;
    edtRepresentante.TamCampo  := 0;
    edtRepresentante.CompZeros := False;
    edtRepresentante.PasswordChar := '*';
    edtRepresentante.TipoTexto := EditFocus.TControlTipoTexto(ttAlfanumerico);
    shpLiberadoRepresentante.Brush.Color  := clRed;
  End
  Else
    shpLiberadoRepresentante.Brush.Color  := clGreen;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.psetLiberadoVendedor(
  const value: Boolean);
begin
  FblnLiberadoVendedor := value;
  If Not value Then
  Begin
    edtVendedor.MaxLength := 10;
    edtVendedor.TamCampo  := 0;
    edtVendedor.PasswordChar := '*';
    shpLiberadoVendedor.Brush.Color  := clRed;
  End
  Else
    shpLiberadoVendedor.Brush.Color  := clGreen;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.pCarregaEmpresa;
begin
  If Not fEmptyStr(edtCodEmp.Text) Then
    edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text)
  Else
    edtNomEmp.Clear;
end;

procedure TfraCRMGeracaoGlobalFrameParametros.pCarregaEmpresaCli;
begin
  If Not fEmptyStr(edtCodEmpCli.Text) Then
  Begin
    If length(arrCodEmpCli) > 1 Then
    Begin
      edtNomEmpCli.Text := '+1';
    End
    Else
    edtNomEmpCli.Text := fRetNomeEmpresaSelec(edtCodEmpCli.Text)
  End
  Else
    edtNomEmpCli.Text := 'TODOS';
end;

end.
