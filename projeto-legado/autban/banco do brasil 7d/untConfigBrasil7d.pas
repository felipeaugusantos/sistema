unit untConfigBrasil7d;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  DirectoryEditFocus, EditFocus, QColorLabel, ComCtrls, ShellApi, Uni,
  AppEvnts, MaskEditFocus, cxContainer, cxEdit, cxGroupBox, cxPC,
  cxControls, ComboBoxFocus, BitBtnLockedIncrem, cxPCdxBarPopupMenu, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, dxBarBuiltInMenu, untTypesSistema, frxClass,
  frxExportCSVTestabilidade, dxScreenTip, cxClasses, dxCustomHint, cxHint,
  StrUtils, cxTextEdit, cxMaskEdit, cxButtonEdit, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator,
  Data.DB, cxDBData, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox, Datasnap.DBClient,
  System.Generics.Collections, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog, 
  untFrameDirectoryEditFocus, untFramePlanoDeContasMaskEdit;

type
  TfrmConfigBrasil7d = class(TfrmPai)
    pnlDados: TPanel;
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
    cxPaginas: TcxPageControl;
    tbsGeral: TcxTabSheet;
    tbsBaixa: TcxTabSheet;
    HintControler: TcxHintStyleController;
    btnCancelar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    BtnManual: TBitBtnLocked;
    BtnOcorrencia: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    tbsEncBan: TcxTabSheet;
    pnlAtivo1: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    lblCodAgenc: TLabel;
    lblCodCart: TLabel;
    lblContCorr: TLabel;
    lblDiasProt: TLabel;
    lblDtaConv: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    lblProNum: TLabel;
    lblResp: TLabel;
    ColorLabel1: TColorLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    ColorLabel2: TColorLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    ColorLabel3: TColorLabel;
    Label15: TLabel;
    Label16: TLabel;
    ColorLabel4: TColorLabel;
    lblNomAgencia: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    Label25: TLabel;
    ColorLabel6: TColorLabel;
    lblValidaOco: TLabel;
    ColorLabel7: TColorLabel;
    Label28: TLabel;
    Label27: TLabel;
    lblCartSeq: TLabel;
    edtVarCarteira: TEditFocus;
    edtResp: TEditFocus;
    edtProxNumArqRem: TEditFocus;
    edtNumConvenio: TEditFocus;
    edtDigCtaCor: TEditFocus;
    edtDigAgencia: TEditFocus;
    edtDiasProt: TEditFocus;
    edtContaCorr: TEditFocus;
    edtCodAgencia: TEditFocus;
    edtMandMsg: TEditFocus;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtObservacao5: TEditFocus;
    edtDiasCred: TEditFocus;
    edtProAce: TEditFocus;
    edtTipCob: TEditFocus;
    edtNomAgencia: TEditFocus;
    edtDtaConvenio: TMaskEditFocus;
    cmbTipDia: TComboBoxFocus;
    edtInfAdi: TEditFocus;
    edtPerMul: TEditFocus;
    edtValidaOco: TEditFocus;
    edtCnpjSacAvalista: TEditFocus;
    edtSacAvalista: TEditFocus;
    fraPathRemessaBB: TfraDirectoryEditFocus;
    fraPathRetornoBB: TfraDirectoryEditFocus;
    cmbCodCar: TComboBoxFocus;
    cmbInstrucao1: TComboBoxFocus;
    cmbInstrucao2: TComboBoxFocus;
    chkCartSeq: TCheckBox;
    edtCartSeq: TEditFocus;
    Label7: TLabel;
    ColorLabel5: TColorLabel;
    gpbSimples: TcxGroupBox;
    Label1: TLabel;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    gpbVinculada: TcxGroupBox;
    Label17: TLabel;
    edtDesPorVin: TEditFocus;
    edtCodPorVin: TEditFocus;
    gpbDescontada: TcxGroupBox;
    Label19: TLabel;
    edtDesPorDes: TEditFocus;
    edtCodPorDes: TEditFocus;
    gpbVendor: TcxGroupBox;
    Label21: TLabel;
    edtDesPorVen: TEditFocus;
    edtCodPorVen: TEditFocus;
    gpbDireta: TcxGroupBox;
    Label23: TLabel;
    edtDesPorDir: TEditFocus;
    edtCodPorDir: TEditFocus;
    edtSolDta: TEditFocus;
    pnlAtivo2: TPanel;
    pnlAtivo3: TPanel;
    cxGroupBox1: TcxGroupBox;
    Label26: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    edtDesPorTar: TEditFocus;
    edtPorTar: TEditFocus;
    edtValorTarifa: TEditFocus;
    edtDesForTar: TEditFocus;
    edtForTar: TEditFocus;
    cdsCnfOco: TUniClientDataSet;
    cdsCnfOcoCNF_CODOCO: TStringField;
    cdsCnfOcoCNF_DESOCO: TStringField;
    cdsCnfOcoCNF_GERPAG: TBooleanField;
    cdsCnfOcoCNF_FORNEC: TStringField;
    cdsCnfOcoCNF_PORTAD: TStringField;
    cdsCnfOcoCNF_PLNCON: TStringField;
    cdsCnfOcoCNF_CUSCAR: TBooleanField;
    cdsCnfOcoCNF_TIPDES: TIntegerField;
    cdsCnfOcoCNF_DSTPDS: TStringField;
    dsCnfOco: TDataSource;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    grpTarAux: TcxGroupBox;
    grdTarifas: TcxGrid;
    grdTarifasDBTableView1: TcxGridDBTableView;
    grdTarifasDBTableView1CNF_CODOCO: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_DESOCO: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_DSTPDS: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_GERPAG: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_CUSCAR: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_FORNEC: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_PLNCON: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_PORTAD: TcxGridDBColumn;
    grdTarifasLevel1: TcxGridLevel;
    btnAddOco: TBitBtnLocked;
    btnRemOco: TBitBtnLocked;
    btnEdtOco: TBitBtnLocked;
    cdsCnfOcoCNF_MOTOCO: TStringField;
    Label32: TLabel;
    cmbLancarTarifa: TComboBoxFocus;
    Label33: TLabel;
    edtPorDes: TEditFocus;
    edtDesPordescontada: TEditFocus;
    cdsCnfOcoCNF_USADIA: TBooleanField;
    grdTarifasDBTableView1CNF_USADIA: TcxGridDBColumn;
    Label34: TLabel;
    edtEmpBol: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtQtdDiasDataLimiteRec: TEditFocus;
    Label35: TLabel;
    Label36: TLabel;
    tbsBeneficiario: TcxTabSheet;
    pnlAtivo4: TPanel;
    cxGroupBox2: TcxGroupBox;
    edtCpfBenef: TEditFocus;
    edtNomeBenef: TEditFocus;
    cmbDataCompTaxa: TComboBoxFocus;
    ColorLabel8: TColorLabel;
    edtParNum: TEditFocus;
    lblParNum: TLabel;
    fraPlanoDeContasBai: TfraPlanoDeContasMskEdit;
    fraPlanoDeContasVin: TfraPlanoDeContasMskEdit;
    fraPlanoDeContasDes: TfraPlanoDeContasMskEdit;
    fraPlanoDeContasVen: TfraPlanoDeContasMskEdit;
    fraPlanoDeContasDir: TfraPlanoDeContasMskEdit;
    fraPlanoDeContasEnc: TfraPlanoDeContasMskEdit;
    clDesVinc: TColorLabel;
    edtDesVinc: TEditFocus;
    lblDesVinc: TLabel;
    clDesSuj: TColorLabel;
    edtConDesSuj: TEditFocus;
    lblDesSuj: TLabel;
    tbsComplemento: TcxTabSheet;
    pnlComplemento: TPanel;
    Label2: TLabel;
    edtCodPorRem: TEditFocus;
    edtDescPorRem: TEditFocus;
    Label18: TLabel;
    cmbInstruPersonalizada: TComboBoxFocus;
    Label20: TLabel;
    edtDiasProtPerso: TEditFocus;
    lblAtualizarOcorrencias: TLabel;
    edtAtualizarOcorrencias: TEditFocus;
    lblAtualizarOcorrenciasSN: TColorLabel;
    edtEnvCaracEsp: TEditFocus;
    ColorLabel9: TColorLabel;
    Label22: TLabel;
    gbIntrucao: TGroupBox;
    lblInstPessoaFisica: TLabel;
    Label29: TLabel;
    lblQtdDiasProtestoPF: TLabel;
    lblQtdDiasProtestoPJ: TLabel;
    cmbInstruPF: TComboBoxFocus;
    cmbInstruPJ: TComboBoxFocus;
    edtDiasProtestoPF: TEditFocus;
    edtDiasProtestoPJ: TEditFocus;
    clEnviaEmailBloqueto: TColorLabel;
    edtEnviaEmailBloqueto: TEditFocus;
    lblEnviaEmailBloqueto: TLabel;
    lblPerImpBol: TLabel;
    edtPerImpBol: TEditFocus;
    clbPerImpBol: TColorLabel;
    gbVendor: TGroupBox;
    lbVendorTaxaVendedor: TLabel;
    edtVendorTaxaVendedor: TEditFocus;
    lbVendorTaxaComprador: TLabel;
    edtVendorTaxaComprador: TEditFocus;
    cmbVendorIOF: TComboBoxFocus;
    lbVendorIOF: TLabel;

    procedure pCarregadados;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure tabCarteiraChange(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure BtnManualClick(Sender: TObject);
    procedure edtCnpjSacAvalistaChange(Sender: TObject);
    procedure edtCnpjSacAvalistaEnter(Sender: TObject);
    procedure edtCnpjSacAvalistaExit(Sender: TObject);
    procedure edtCnpjSacAvalistaKeyPress(Sender: TObject; var Key: Char);
    procedure edtSacAvalistaChange(Sender: TObject);
    procedure edtSacAvalistaEnter(Sender: TObject);
    procedure edtSacAvalistaExit(Sender: TObject);
    procedure cmbCodCarChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cmbInstrucao2Change(Sender: TObject);
    procedure cmbInstrucao1Change(Sender: TObject);
    procedure lblValidaOcoMouseEnter(Sender: TObject);
    procedure lblValidaOcoMouseLeave(Sender: TObject);
    procedure edtDiasCredEnter(Sender: TObject);
    procedure edtDiasCredExit(Sender: TObject);
    procedure btnConfigurarEnter(Sender: TObject);
    procedure btnConfigurarExit(Sender: TObject);
    procedure btnOcorrenciaEnter(Sender: TObject);
    procedure btnOcorrenciaExit(Sender: TObject);
    procedure btnOcorrenciaClick(Sender: TObject);
    procedure chkCartSeqClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtForTarKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorTarifaExit(Sender: TObject);
    procedure grdTarifasDBTableView1DblClick(Sender: TObject);
    procedure btnAddOcoClick(Sender: TObject);
    procedure btnEdtOcoClick(Sender: TObject);
    procedure btnRemOcoClick(Sender: TObject);
    procedure edtPorDesEnter(Sender: TObject);
    procedure edtPorDesExit(Sender: TObject);
    procedure edtPorDesKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpBolEnter(Sender: TObject);
    procedure edtEmpBolExit(Sender: TObject);
    procedure edtQtdDiasDataLimiteRecExit(Sender: TObject);
    procedure edtQtdDiasDataLimiteRecEnter(Sender: TObject);
    procedure ApplicationEventsDeactivate(Sender: TObject);
    procedure fraPlanoDeContasBaiMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasVinMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasDesMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasVenMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasDirMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasEncMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure edtConDesSujEnter(Sender: TObject);
    procedure edtConDesSujExit(Sender: TObject);
    procedure edtCodPorRemKeyPress(Sender: TObject; var Key: Char);
    procedure cmbInstruPersonalizadaKeyPress(Sender: TObject; var Key: Char);
    procedure cmbInstruPersonalizadaChange(Sender: TObject);
    procedure cmbInstruPFChange(Sender: TObject);
    procedure cmbInstruPJChange(Sender: TObject);
    procedure cmbInstruPFKeyPress(Sender: TObject; var Key: Char);
    procedure cmbInstruPJKeyPress(Sender: TObject; var Key: Char);
    procedure edtTipCobChange(Sender: TObject);
    procedure edtRespChange(Sender: TObject);
    procedure edtVendorTaxaCompradorExit(Sender: TObject);
    procedure edtVendorTaxaVendedorExit(Sender: TObject);
  private

    qryCadPor : TUniQuery;
    qryCadEmp : TUniQuery;
    qryCadCta : TUniQuery;
    qryCadFor : TUniQuery;

    procedure pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pCarregaEmpresa(strCodEmp: String; edtLabel: TEdit);
    procedure pShowHint(edtEdit: TEditFocus; strTitulo: String);
    procedure pShowHintCnpj(edtEdit: TEditFocus; strTitulo: String);
    procedure pHideHint;
    procedure pAlteraHint(edtEdit: TEditFocus; strNovoHint: String);
    procedure pAlteraHintBotao(btnBotao: TBitBtnLocked; strNovoHint: String);
    procedure pEnableObs;
    procedure pDisableObs;
    procedure pVerificaCodigoTipoCarteira;
    procedure ExibeEnviaEmailBloqueto;
    procedure pShowHintBotao(btnBotao: TBitBtnLocked; strTitulo: String);
    procedure pSetaDiasProtesto();
    procedure pLimpaCampos;
    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
    function RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;

    procedure pCarregaOcorrencias;
    procedure pSetaDiasProtestoPersonalizada;
    procedure pSetaDiasProtestoPF;
    procedure pSetaDiasProtestoPJ;
    { Private declarations }
  public
    { Public declarations }
    blnPeFin,
    blnNaoEditar : Boolean;
    strConfig    : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;

  end;

var
  frmConfigBrasil7d: TfrmConfigBrasil7d;

implementation

uses  untfuncoesSimples, untPesqAux, untFuncoes,
     untCfgGenericas_AutBan, untConsultas, untMemo,
     untCadOcoCartei, untCNFOCO_Class, untCNFOCO_Dao;

{$R *.dfm}

{ TfrmPai1 }

procedure TfrmConfigBrasil7d.pCarregadados;
begin

  {*****************}
  {* CARREGA DADOS *}
  {**************KP*}
  pLimpaCampos;
  if blnPeFin then
  begin
    If fEmptyStr(fGetBancoConfig(0,'PEFIN','SEQARQ','')) Then
    Begin
      edtProxNumArqRem.Enabled := True;
      edtProxNumArqRem.Clear;
      pSetFocus(edtProxNumArqRem);
    End
    Else
    Begin
      edtProxNumArqRem.Text := fGetBancoConfig(0,'PEFIN','SEQARQ','');
      edtProxNumArqRem.Enabled := False;
      pSetFocus(cmbCodCar);
    End;

  end
  else
  begin
    If fEmptyStr(fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '')) Then
    Begin
      edtProxNumArqRem.Enabled := True;
      edtProxNumArqRem.Clear;
      pSetFocus(edtProxNumArqRem);
    End
    Else
    Begin
      edtProxNumArqRem.Text := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '');
      edtProxNumArqRem.Enabled := False;
      pSetFocus(cmbCodCar);
    End;
  end;

  if (strLoginUsuarioLogado='997') or(strLoginUsuarioLogado='998') or (strLoginUsuarioLogado='999') Then
  begin
    edtProxNumArqRem.Enabled := True;
    pSetFocus(edtProxNumArqRem);
  End;

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', '')) Of
      11: cmbCodCar.ItemIndex := 0;
      12: cmbCodCar.ItemIndex := 1;
      16: cmbCodCar.ItemIndex := 2;
      17: cmbCodCar.ItemIndex := 3;
      18: cmbCodCar.ItemIndex := 4;
      31: cmbCodCar.ItemIndex := 5;
      51: cmbCodCar.ItemIndex := 6;
    End;
  End
  Else
    cmbCodCar.ItemIndex := -1;

  edtVarCarteira.Text   := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'VARCART', '');
  edtDtaConvenio.Text   := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'DTACONV', '');

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', '')) Then
    edtNumConvenio.Text   := fPadL(fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', ''),edtNumConvenio.MaxLength,'0')
  Else
    edtNumConvenio.Clear;

  edtCodAgencia.Text    := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtDigAgencia.Text    := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', '');
  edtNomAgencia.Text    := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMAGEN', '');
  edtContaCorr.Text     := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', '');

  edtDigCtaCor.Text     := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', '');
  edtDiasProt.Text      := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '');
  edtDiasProtPerso.Text := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPERS', '');
  edtResp.Text          := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', '');
  edtParNum.Text        := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PARCNUM', '');
  edtDiasProtestoPF.Text    := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAS_PROTESTO_PF', '');
  edtDiasProtestoPj.Text    := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAS_PROTESTO_PJ', '');
  edtDesVinc.Text       := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'UTLDESCOBVINC', '');
  edtConDesSuj.Text       := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'CONSIDESSUJ', '');
  edtPorTar.Text        := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', '');
  fraPlanoDeContasEnc.MskCodCta.Text := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', '');
  edtForTar.Text        := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', '');
  edtValorTarifa.Text   := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', '');
  edtEmpBol.Text        := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'EMPRBOL', '');
  edtQtdDiasDataLimiteRec.Text := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'DIALIMI', '');
  edtEnvCaracEsp.Text   := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVCESP', '');

  edtPerImpBol.Text     := fGetBancoConfig(0,'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', '');
  If fEmptyStr(edtPerImpBol.Text) Then
    edtPerImpBol.Text := 'S';

  If fEmptyStr(edtEnvCaracEsp.Text) Then
    edtEnvCaracEsp.Text := 'N';

  edtAtualizarOcorrencias.Text := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'ATUALIZA_DESPCOB', 'N');
  If fEmptyStr(edtAtualizarOcorrencias.Text) Then
    edtAtualizarOcorrencias.Text := 'N';

  If fEmptyStr(edtDesVinc.Text) Then
    edtDesVinc.Text := 'N';

  If fEmptyStr(edtConDesSuj.Text) Then
    edtConDesSuj.Text := 'N';

  If Not fEmptyStr(fGetBancoConfig(0,'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1),'DTCOMTA', '2')) Then
    cmbDataCompTaxa.ItemIndex    := StrToInt(fGetBancoConfig(0,'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1),'DTCOMTA', '2'))-1
  Else
    cmbDataCompTaxa.ItemIndex    := 1;

  If tbsBeneficiario.TabVisible Then
  Begin
    edtNomeBenef.Text := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMBENE', '');
    edtCpfBenef.Text  := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'CPFBENE', '');
  End;

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '')) Of
      00 : cmbInstrucao1.ItemIndex := 0;
      01 : cmbInstrucao1.ItemIndex := 1;
      03 : cmbInstrucao1.ItemIndex := 2;
      04 : cmbInstrucao1.ItemIndex := 3;
      05 : cmbInstrucao1.ItemIndex := 4;
      10 : cmbInstrucao1.ItemIndex := 5;
      15 : cmbInstrucao1.ItemIndex := 6;
      20 : cmbInstrucao1.ItemIndex := 7;
      25 : cmbInstrucao1.ItemIndex := 8;
      30 : cmbInstrucao1.ItemIndex := 9;
      45 : cmbInstrucao1.ItemIndex := 10;
      06 : cmbInstrucao1.ItemIndex := 11;
      07 : cmbInstrucao1.ItemIndex := 12;
      22 : cmbInstrucao1.ItemIndex := 13;
      88 : cmbInstrucao1.ItemIndex := 14;
    End;
  End
  Else
    cmbInstrucao1.ItemIndex := -1;

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', '')) Of
      00 : cmbInstrucao2.ItemIndex := 0;
      01 : cmbInstrucao2.ItemIndex := 1;
      03 : cmbInstrucao2.ItemIndex := 2;
      04 : cmbInstrucao2.ItemIndex := 3;
      05 : cmbInstrucao2.ItemIndex := 4;
      10 : cmbInstrucao2.ItemIndex := 5;
      15 : cmbInstrucao2.ItemIndex := 6;
      20 : cmbInstrucao2.ItemIndex := 7;
      25 : cmbInstrucao2.ItemIndex := 8;
      30 : cmbInstrucao2.ItemIndex := 9;
      45 : cmbInstrucao2.ItemIndex := 10;
      06 : cmbInstrucao2.ItemIndex := 11;
      07 : cmbInstrucao2.ItemIndex := 12;
      22 : cmbInstrucao2.ItemIndex := 13;
      88 : cmbInstrucao2.ItemIndex := 14;
    End;
  End
  Else
    cmbInstrucao2.ItemIndex := -1;

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTPER', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTPER', '')) Of
      00: cmbInstruPersonalizada.ItemIndex := 0;  // - Ausência de instruções
      01: cmbInstruPersonalizada.ItemIndex := 1;  // - Cobrar juros
      03: cmbInstruPersonalizada.ItemIndex := 2;  // - Protestar NO 3º dia útil após vencido
      04: cmbInstruPersonalizada.ItemIndex := 3;  // - Protestar NO 4º dia útil após vencido
      05: cmbInstruPersonalizada.ItemIndex := 4;  // - Protestar NO 5º dia útil após vencido
      10: cmbInstruPersonalizada.ItemIndex := 5;  // - Protestar NO 10º dia corrido após vencido
      15: cmbInstruPersonalizada.ItemIndex := 6;  // - Protestar NO 15º dia corrido após vencido
      20: cmbInstruPersonalizada.ItemIndex := 7;  // - Protestar NO 20º dia corrido após vencido
      25: cmbInstruPersonalizada.ItemIndex := 8;  // - Protestar NO 25º dia corrido após vencido
      30: cmbInstruPersonalizada.ItemIndex := 9;  // - Protestar NO 30º dia corrido após vencido
      45: cmbInstruPersonalizada.ItemIndex := 10; // - Protestar NO 45º dia corrido após vencido
      06: cmbInstruPersonalizada.ItemIndex := 11; // - Indica Protesto em dias corridos
      07: cmbInstruPersonalizada.ItemIndex := 12; // - Não protestar
      22: cmbInstruPersonalizada.ItemIndex := 13; // - Conceder desconto só até a DATA estipulada
      88: cmbInstruPersonalizada.ItemIndex := 14; // - Negativação Sem Protesto
    End;
  End
  Else
    cmbInstruPersonalizada.ItemIndex := -1;

  Case StrToIntDef(fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'LANTX02', '06'),-1) Of
    06 : cmbLancarTarifa.ItemIndex := 0;
    02 : cmbLancarTarifa.ItemIndex := 1;
  End;


 If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRUCAO_PF', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRUCAO_PF', '')) Of
      00 : cmbInstruPF.ItemIndex := 0;
      01 : cmbInstruPF.ItemIndex := 1;
      03 : cmbInstruPF.ItemIndex := 2;
      04 : cmbInstruPF.ItemIndex := 3;
      05 : cmbInstruPF.ItemIndex := 4;
      10 : cmbInstruPF.ItemIndex := 5;
      15 : cmbInstruPF.ItemIndex := 6;
      20 : cmbInstruPF.ItemIndex := 7;
      25 : cmbInstruPF.ItemIndex := 8;
      30 : cmbInstruPF.ItemIndex := 9;
      45 : cmbInstruPF.ItemIndex := 10;
      06 : cmbInstruPF.ItemIndex := 11;
      07 : cmbInstruPF.ItemIndex := 12;
      22 : cmbInstruPF.ItemIndex := 13;
      88 : cmbInstruPF.ItemIndex := 14;
    End;
  End
  Else
    cmbInstruPF.ItemIndex := -1;

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRUCAO_PJ', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRUCAO_PJ', '')) Of
      00 : cmbInstruPJ.ItemIndex := 0;
      01 : cmbInstruPJ.ItemIndex := 1;
      03 : cmbInstruPJ.ItemIndex := 2;
      04 : cmbInstruPJ.ItemIndex := 3;
      05 : cmbInstruPJ.ItemIndex := 4;
      10 : cmbInstruPJ.ItemIndex := 5;
      15 : cmbInstruPJ.ItemIndex := 6;
      20 : cmbInstruPJ.ItemIndex := 7;
      25 : cmbInstruPJ.ItemIndex := 8;
      30 : cmbInstruPJ.ItemIndex := 9;
      45 : cmbInstruPJ.ItemIndex := 10;
      06 : cmbInstruPJ.ItemIndex := 11;
      07 : cmbInstruPJ.ItemIndex := 12;
      22 : cmbInstruPJ.ItemIndex := 13;
      88 : cmbInstruPJ.ItemIndex := 14;
    End;
  End
  Else
    cmbInstruPJ.ItemIndex := -1;

  edtDescPorRem.Text := '';

  edtCnpjSacAvalista.Text := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJSAC', '');
  edtSacAvalista.Text			:= fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', '');

  edtObservacao1.Text   := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text   := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text   := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text   := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text   := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');

  fraPathRemessaBB.edtDirectory.text := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '');
  fraPathRetornoBB.edtDirectory.text := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '');
  edtMandMsg.Text       := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'MANDMSG', '');
  edtValidaOco.Text     := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOCO5', '');

  edtCodPor.Text        := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  fraPlanoDeContasBai.MskCodCta.Text := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');
  edtCodPorVin.Text     := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAII', '');
  fraPlanoDeContasVin.MskCodCta.Text := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAII', '');
  edtCodPorDes.Text     := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAID', '');
  fraPlanoDeContasDes.MskCodCta.Text := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAID', '');
  edtCodPorVen.Text     := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAIV', '');
  fraPlanoDeContasVen.MskCodCta.Text := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAIV', '');
  edtCodPorDir.Text     := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAIR', '');
  fraPlanoDeContasDir.MskCodCta.Text := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAIR', '');
  edtSolDta.Text        := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'SOLIDTA', 'N');
  edtPerMul.Text        := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', '');
  edtPorDes.Text        := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTDES', '');
  edtCodPorRem.Text      := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');

  edtDiasCred.Text      := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', '');
  edtProAce.Text        := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', '');
  edtTipCob.Text        := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPCOBR', '');
  edtInfAdi.Text        := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', '');
  cmbTipDia.ItemIndex   := StrToIntDef(fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPDIA', '1'),0)-1;
  chkCartSeq.Checked     := (fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', '') = 'S');
  edtCartSeq.Text        := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', '');

  edtVendorTaxaVendedor.Text   := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'TAXAVEN', '');
  edtVendorTaxaComprador.Text  := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'TAXACOM', '');
  cmbVendorIOF.ItemIndex   := StrToIntDef(fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'INDIOF', ''), -1);

  If chkCartSeq.Visible Then
    chkCartSeq.OnClick(chkCartSeq);

  If Not fEmptyStr( edtCodPor.Text ) Then pCarregaPortador(edtCodPor.Text, edtDesPor);
  If Not fEmptyStr( fraPlanoDeContasBai.MskCodCta.Text ) Then pCarregaCentroCusto(fraPlanoDeContasBai.MskCodCta.Text, fraPlanoDeContasBai.edtDesCta);
  If Not fEmptyStr( edtCodPorVin.Text ) Then pCarregaPortador(edtCodPorVin.Text, edtDesPorVin);
  If Not fEmptyStr( fraPlanoDeContasVin.MskCodCta.Text ) Then pCarregaCentroCusto(fraPlanoDeContasVin.MskCodCta.Text, fraPlanoDeContasVin.edtDesCta);
  If Not fEmptyStr( edtCodPorDes.Text ) Then pCarregaPortador(edtCodPorDes.Text, edtDesPorDes);
  If Not fEmptyStr( fraPlanoDeContasDes.MskCodCta.Text ) Then pCarregaCentroCusto(fraPlanoDeContasDes.MskCodCta.Text, fraPlanoDeContasDes.edtDesCta);
  If Not fEmptyStr( edtCodPorVen.Text ) Then pCarregaPortador(edtCodPorVen.Text, edtDesPorVen);
  If Not fEmptyStr( fraPlanoDeContasVen.MskCodCta.Text ) Then pCarregaCentroCusto(fraPlanoDeContasVen.MskCodCta.Text, fraPlanoDeContasVen.edtDesCta);
  If Not fEmptyStr( edtCodPorDir.Text ) Then pCarregaPortador(edtCodPorDir.Text, edtDesPorDir);
  If Not fEmptyStr( fraPlanoDeContasDir.MskCodCta.Text ) Then pCarregaCentroCusto(fraPlanoDeContasDir.MskCodCta.Text, fraPlanoDeContasDir.edtDesCta);

  If Not fEmptyStr( edtPorTar.Text ) Then pCarregaPortador(edtPorTar.Text, edtDesPorTar);
  If Not fEmptyStr( fraPlanoDeContasEnc.MskCodCta.Text ) Then pCarregaCentroCusto(fraPlanoDeContasEnc.MskCodCta.Text, fraPlanoDeContasEnc.edtDesCta);
  If Not fEmptyStr( edtEmpBol.Text ) Then pCarregaEmpresa(edtEmpBol.Text, edtDesEmpresa);

  If Not fEmptyStr( edtForTar.Text ) Then
  begin
    pPesquisaCadFor(qryCadFor, qryCadFor, edtForTar.Text);
    edtDesForTar.Text  := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
  end
  Else
    edtDesForTar.Clear;

  pSetaDiasProtesto();
  pCarregaOcorrencias;
  pSetaDiasProtestoPersonalizada();

  pCarregaPortador(edtPorDes.Text, edtDesPorDescontada);

  If Not fEmptyStr( edtCodPorRem.Text ) Then
    pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);


  edtParNum.Enabled := (edtResp.Text = 'E');
  edtParNum.Text := IIF((edtResp.Text = 'E'),IIF(fEmptyStr(edtParNum.Text),'N',edtParNum.Text),'N');

  edtEnviaEmailBloqueto.Text := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVIAEMAILBLOQUETO', '');
  If fEmptyStr(edtEnviaEmailBloqueto.Text) Then
    edtEnviaEmailBloqueto.Text := 'S';

  ExibeEnviaEmailBloqueto;
end;

procedure TfrmConfigBrasil7d.pCarregaEmpresa(strCodEmp: String;
  edtLabel: TEdit);
begin
  If Not fEmptyStr(strCodEmp) Then
  Begin
    pPesquisaCadEmp(Nil, qryCadEmp, strCodEmp);
    edtLabel.Text := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
  End
  Else
    edtLabel.Clear;

end;

procedure TfrmConfigBrasil7d.FormShow(Sender: TObject);
begin
  inherited;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  pCarregaDados;
  pVerificaCodigoTipoCarteira;

  pnlAtivo1.Enabled := False;
  pnlAtivo2.Enabled := False;
  pnlAtivo3.Enabled := False;
  pnlAtivo4.Enabled := False;
  pnlComplemento.Enabled := False;

  pSetFocus(btnEditar);

  If edtProxNumArqRem.Enabled Then
    pSetFocus(edtProxNumArqRem)
  Else
    pSetFocus(cmbCodCar);

  if blnNaoEditar then
  begin
    btnConfigurar.Enabled := False;
    btnConfigurar.Visible := False;
    btnGravar.Enabled     := True;
    btnEditar.Visible     := False;
    pSetFocus(btnGravar);
  end;

  chkCartSeq.Visible := (Not blnPeFin);
  lblCartSeq.Visible := (Not blnPeFin);
  edtCartSeq.Visible := (Not blnPeFin);

end;

procedure TfrmConfigBrasil7d.btnConfigurarEnter(Sender: TObject);
begin
  inherited;
  pAlteraHintBotao(btnConfigurar, 'Configurar percentual de ' + #13+#10 +
                                  'juros para remessa.');
  pShowHintBotao(btnConfigurar, 'Cofigurações específicas.');
end;

procedure TfrmConfigBrasil7d.btnConfigurarExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBrasil7d.btnEditarClick(Sender: TObject);
begin
  If ((Not fVerificaDireitoAutBan('PERCARBAN')) and (strLoginUsuarioLogado <> '999')) Then
  begin
    fMensagem('ATENÇÃO','Usuário sem permissão!', ['&Ok ']);
    Exit;
  end
  else
  begin
    pnlAtivo1.Enabled := True;
    pnlComplemento.Enabled := pnlAtivo1.Enabled;
    pnlAtivo2.Enabled := True;
    pnlAtivo4.Enabled := tbsBeneficiario.TabVisible;
    if tbsEncBan.tabVisible then
      pnlAtivo3.Enabled := True;

    btnGravar.Enabled := True;
    btnConfigurar.Enabled := True;
    btnEditar.Visible := False;
    btnCancelar.Visible := true;

    if edtProxNumArqRem.Enabled then
      pSetFocus(edtProxNumArqRem)
    else
      pSetFocus(cmbCodCar);

  end;
end;

procedure TfrmConfigBrasil7d.btnEdtOcoClick(Sender: TObject);
  Var
    intRecNo_: Integer;
begin
  inherited;
  intRecNo_ := 0;
  If Not cdsCnfOco.isEmpty Then
  Begin
    intRecNo_ := cdsCnfOco.RecNo;
    frmCadOcoCartei                     := TfrmCadOcoCartei.Create(nil);
    frmCadOcoCartei.strCartei           := 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp;
    frmCadOcoCartei.blnEditar           := True;
    frmCadOcoCartei.edtCodOco.Text      := cdsCnfOcoCNF_CODOCO.AsString;
    frmCadOcoCartei.edtMotOco.Text      := cdsCnfOcoCNF_MOTOCO.AsString;
    frmCadOcoCartei.fraPlanoDeContasOco.MskCodCta.Text := Copy(cdsCnfOcoCNF_PLNCON.AsString,1,7);
    frmCadOcoCartei.cmbTipDes.ItemIndex := cdsCnfOcoCNF_TIPDES.AsInteger;
    frmCadOcoCartei.cmbTipDes.Visible   := True;
    frmCadOcoCartei.lblTipDes.Visible   := True;
    Try
      frmCadOcoCartei.ShowModal;
    Finally
      FreeAndNil(frmCadOcoCartei);
    End;
  End
  Else
    pMensagemOk('É necessário possuir um registro selecionado para editar!');

  pCarregaOcorrencias;

  If intRecNo_ > 0 Then
  Begin
    cdsCnfOco.DisableControls;
    cdsCnfOco.RecNo := intRecNo_;
    cdsCnfOco.EnableControls;

  End;
end;

procedure TfrmConfigBrasil7d.btnGravarClick(Sender: TObject);
Var
  stlCfgAnt : TStringList;
begin
  inherited;

  If fVerificaCampos Then
  Begin
    If blnNaoEditar Then
    Begin
      Close;
      ModalResult := mrOk;
      Exit;
    End;

    If (chkCartSeq.Checked) And (chkCartSeq.Visible) Then
    Begin
      If edtProxNumArqRem.Text <> fRetProxNumAutBan('CONFIG001D7-' + edtCartSeq.Text) Then
      Begin
        If fMensagem('ATENÇÃO','Ao utilizar a sequência do arquivo de remessa de outra carteira, o campo Último Núm. de Seq. Arq. Remessa será sobrescrito pelo da carteira principal. Deseja continuar?',['&SIM', '&NÃO'], 1) = 2 Then
          Exit;
      End;
    End;

    Try
      stlCfgAnt := TStringList.Create;
      pCarregaCfg(stlCfgAnt);

      if blnPeFin then
        fGetBancoConfig(1, 'PEFIN', 'SEQARQ', edtProxNumArqRem.Text)
      else
        fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', IIF(chkCartSeq.Checked, fRetProxNumAutBan('CONFIG001D7-' + edtCartSeq.Text), edtProxNumArqRem.Text));

      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', cmbCodCar.Text        );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'VARCART', edtVarCarteira.Text   );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'DTACONV', edtDtaConvenio.Text   );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', edtNumConvenio.Text   );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text    );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', edtDigAgencia.Text    );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMAGEN', edtNomAgencia.Text    );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text     );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', edtDigCtaCor.Text     );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text      );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPERS', edtDiasProtPerso.Text );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text          );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', LeftStr(cmbInstrucao1.Text,2));
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', LeftStr(cmbInstrucao2.Text,2));
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTPER', LeftStr(cmbInstruPersonalizada.Text,2));

      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text);
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text);
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text);
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text);
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text);

      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAS_PROTESTO_PF', edtDiasProtestoPF.Text );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAS_PROTESTO_PJ', edtDiasProtestoPj.Text );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRUCAO_PF', LeftStr(cmbInstruPF.Text,2));
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRUCAO_PJ', LeftStr(cmbInstruPJ.Text,2));

      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessaBB.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetornoBB.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'MANDMSG', edtMandMsg.Text      );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOCO5', edtValidaOco.Text    );

      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text       );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContasBai.MskCodCta.Text);
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAII', edtCodPorVin.Text    );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAII', fraPlanoDeContasVin.MskCodCta.Text);
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAID', edtCodPorDes.Text    );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAID', fraPlanoDeContasDes.MskCodCta.Text);
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAIV', edtCodPorVen.Text    );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAIV', fraPlanoDeContasVen.MskCodCta.Text);
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAIR', edtCodPorDir.Text    );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAIR', fraPlanoDeContasDir.MskCodCta.Text);
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'SOLIDTA', edtSolDta.Text       );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', edtPerMul.Text       );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTDES', edtPorDes.Text       );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text      );

      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text     );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text       );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVIAEMAILBLOQUETO', edtEnviaEmailBloqueto.Text       );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PARCNUM', edtParNum.Text       );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'UTLDESCOBVINC', edtDesVinc.Text  );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'CONSIDESSUJ', edtConDesSuj.Text  );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPCOBR', edtTipCob.Text       );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPDIA' , IntToStr(cmbTipDia.ItemIndex+1));
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text       );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', edtSacAvalista.Text     ); //Sacador/Avalista
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJSAC', edtCnpjSacAvalista.Text ); //CNPJ Sacador/Avalista
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', IIF(chkCartSeq.Checked, 'S', 'N'));
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', IIF(chkCartSeq.Checked, edtCartSeq.Text, ''));
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', edtPorTar.Text    );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', fraPlanoDeContasEnc.MskCodCta.Text);
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', edtForTar.Text    );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', edtValorTarifa.Text  );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'LANTX02', IIF(cmbLancarTarifa.ItemIndex = 1, '02', '06'));
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'EMPRBOL', edtEmpBol.Text  );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'DIALIMI', edtQtdDiasDataLimiteRec.Text  );
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'DTCOMTA', IntToStr(cmbDataCompTaxa.ItemIndex+1));
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVCESP', edtenvCaracEsp.Text  );

      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'ATUALIZA_DESPCOB', edtAtualizarOcorrencias.Text);

      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', edtPerImpBol.Text       );

      If tbsBeneficiario.TabVisible Then
      Begin
        fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMBENE', edtNomeBenef.Text  );
        fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'CPFBENE', edtCpfBenef.Text   );
      End;

      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'TAXAVEN', IIF(gbVendor.Visible, edtVendorTaxaVendedor.Text, ''));
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'TAXACOM', IIF(gbVendor.Visible, edtVendorTaxaComprador.Text, ''));
      fGetBancoConfig(1, 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1), 'INDIOF', IIF(gbVendor.Visible, IntToStr(cmbVendorIOF.ItemIndex), ''));

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        pBackupCnfBco;
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        edtProxNumArqRem.Enabled := False;
        pSetFocus(cmbCodCar);
        cxPaginas.ActivePage :=  tbsGeral;
        pnlAtivo1.Enabled := False;
        pnlComplemento.Enabled := pnlAtivo1.Enabled;
        pnlAtivo2.Enabled := False;
        pnlAtivo4.Enabled := False;

        if tbsEncBan.tabVisible then
           pnlAtivo3.Enabled := False;

        btnGravar.Enabled := False;
        btnConfigurar.Enabled := False;
        btnEditar.Visible := True;
        btnCancelar.Visible := False;
        pSetFocus(btnEditar);
      End
      Else
      Begin
        Close;
        ModalResult := mrOk;
      End;

      pGravaLogCarteira(stlCfgAnt);
      pCarregaDados;

    Except
      On E:Exception Do
      Begin
        fMensagem('Erro','Ocorreu um erro ao tentar salvar os dados.' + #13 + E.Message,['&O K']);
      End;
    End;

    FreeAndNil(stlCfgAnt);
  End;
end;

procedure TfrmConfigBrasil7d.fraPlanoDeContasBaiMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContasBai.MskCodCta, fraPlanoDeContasBai.edtDesCta, Nil, Key, arrCentroCusto) Then
    if fValidaCampos(fraPlanoDeContasBai.MskCodCta) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfigBrasil7d.fraPlanoDeContasDesMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContasDes.MskCodCta, fraPlanoDeContasDes.edtDesCta, Nil, Key, arrCentroCusto) Then
    if fValidaCampos(fraPlanoDeContasDes.MskCodCta) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfigBrasil7d.fraPlanoDeContasDirMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContasDir.MskCodCta, fraPlanoDeContasDir.edtDesCta, Nil, Key, arrCentroCusto) Then
    if fValidaCampos(fraPlanoDeContasDir.MskCodCta) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfigBrasil7d.fraPlanoDeContasEncMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
  Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************KP*}
  If fPesqCentroCusto(Self, fraPlanoDeContasEnc.MskCodCta, fraPlanoDeContasEnc.edtDesCta, Nil, Key, arrCentroCusto) Then
  begin
    if fValidaCampos(fraPlanoDeContasEnc.MskCodCta)  then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmConfigBrasil7d.fraPlanoDeContasVenMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContasVen.MskCodCta, fraPlanoDeContasVen.edtDesCta, Nil, Key, arrCentroCusto) Then
    if fValidaCampos(fraPlanoDeContasVen.MskCodCta) then
      SelectNext(ActiveControl, True, True);

end;

procedure TfrmConfigBrasil7d.fraPlanoDeContasVinMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContasVin.MskCodCta, fraPlanoDeContasVin.edtDesCta, Nil, Key, arrCentroCusto) Then
    if fValidaCampos(fraPlanoDeContasVin.MskCodCta) then
      SelectNext(ActiveControl, True, True);
end;

function TfrmConfigBrasil7d.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  strMensagemConfig: String;
begin

  if blnNaoEditar then
     strMensagemConfig := #13 + 'Por favor acesse a tela de configuração do banco selecionado ' + #13  + ' e corrija as informações necessárias!'
  else
     strMensagemConfig := '';

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = edtProxNumArqRem Then
    Begin
      If fEmptyStr(edtProxNumArqRem.Text) Then
      Begin
        fMensagem('', 'O Último Núm. Arq. Remessa deve conter um valor!'+strMensagemConfig,['&O K']);
        Result := False;
      End

      Else If StrToInt(edtProxNumArqRem.Text) < 0 Then
      Begin
        fMensagem('', 'O Último Núm. Arq. Remessa deve ser maior ou igual a zero!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If Sender = edtResp Then
    Begin

      If (edtResp.Text <> 'E') And (edtResp.Text <> 'B') Then
      Begin
        fMensagem('','O campo Resp. por emissão de boletos deve ser E ou B!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
      edtParNum.Enabled := (edtResp.Text = 'E');
      edtParNum.Text := IIF((edtResp.Text = 'E'),IIF(fEmptyStr(edtParNum.Text),'N',edtParNum.Text),'N');
    End

    Else If Sender = edtProAce Then
    Begin
      If Pos(edtProAce.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Imprime Protocolo de Aceite deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtAtualizarOcorrencias Then
    Begin
      If Not MatchStr(edtAtualizarOcorrencias.Text, ['S', 'N']) Then
      Begin
        fMensagem('ATENÇÃO','O campo Atualizar Desp. Cobrança para ocorrência 98 deve ser preenchido com (S/N)!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If Sender = edtEnviaEmailBloqueto Then
    Begin
      If Pos(edtEnviaEmailBloqueto.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Enviar e-mail Bloqueto na remessa deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtParNum Then
    Begin
      If Pos(edtParNum.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Utilizar Parcela Numeral deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtEnvCaracEsp) Then
    Begin
      If Pos(edtEnvCaracEsp.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo envia carcteres especiais na remessa deve ser S ou N!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If Sender = edtTipCob Then
    Begin
      If Pos(edtTipCob.Text, 'D_V_I_S_') <= 0 Then
      Begin
        fMensagem('','O campo Tipo de Cobrança deve ser preenchido com (D/V/I/S)!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else
        pVerificaCodigoTipoCarteira;
    End

    Else If Sender = edtConDesSuj Then
    Begin
      If Pos(edtConDesSuj.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Considerar Desconto Sugerido na baixa? deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtDesVinc Then
    Begin
      If Pos(edtDesVinc.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Utl. Desconto de Duplicata para cobranças vinculada deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtPerImpBol Then
    Begin
      If Pos(edtPerImpBol.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Permitir impressão de boletos deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodPor) Then
    Begin
      If fEmptyStr(TEditFocus(Sender).Text) Then
      Begin
        fMensagem('', 'Todos os portadores devem ser preenchidos!'+strMensagemConfig, ['&Ok']);

             If (Sender = edtCodPor)    Then edtDesPor.Clear;

        cxPaginas.ActivePage := tbsBaixa;
        Result := False;
      End
      Else
      Begin

        If (Sender = edtCodPor)    Then pCarregaPortador(edtCodPor.Text, edtDesPor);

        If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('', 'Esse portador não está cadastrado!'+strMensagemConfig, ['&Ok']);
          cxPaginas.ActivePage := tbsBaixa;
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If (Pos(edtCodPor.Text, strPortadoresOperador) <= 0) Then
          Begin
            If Not fEmptyStr(edtCodPor.Text) Then
            Begin
              fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+strMensagemConfig, ['&Ok']);
              Result := False;
            End
          End;

        End
        Else If (Not fPortadorPermiteBaixa(edtCodPor.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtEmpBol) Then
    Begin
      edtDesEmpresa.Clear;
      if Not fEmptyStr(edtEmpBol.Text) then
      Begin
        pCarregaEmpresa(edtEmpBol.Text, edtDesEmpresa);
        If qryCadEmp.FieldByName('EMP_NOMEMP').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!'+strMensagemConfig, ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodPorRem) Then
    Begin
        If (edtCodPorRem.Text <> EmptyStr) Then
        Begin
          pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);
          If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!'+strMensagemConfig, ['&Ok']);
            Result := False;
          End
          {*REQ*145940**********RP*}
          Else If Not fEmpresaTemAcessoPortador(edtCodPorRem.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End
          Else If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtCodPorRem.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+strMensagemConfig, ['&Ok']);
              Result := False;
            End;
          End
          Else If (Not fPortadorPermiteBaixa(edtCodPorRem.Text)) Then
          Begin
            fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
            Result := False;
          End;
        End
        Else
          edtDescPorRem.Clear;
    End

    Else If (Sender = edtPorDes) Then
    Begin

      If fEmptyStr(edtPorDes.Text) Then
        edtDesPorDescontada.Clear
      Else
      Begin
        pCarregaPortador(edtPorDes.Text, edtDesPorDescontada);
        If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!'+strMensagemConfig, ['&Ok']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtPorDes.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtPorDes.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+strMensagemConfig, ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = edtCodPorVin) Then
    Begin
      If fEmptyStr(TEditFocus(Sender).Text) Then
      Begin
        fMensagem('', 'Todos os portadores devem ser preenchidos!'+strMensagemConfig, ['&Ok']);

        If (Sender = edtCodPorVin) Then edtDesPorVin.Clear;

        cxPaginas.ActivePage := tbsBaixa;
        Result := False;
      End
      Else
      Begin

        If (Sender = edtCodPorVin) Then pCarregaPortador(edtCodPorVin.Text, edtDesPorVin);

        If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('', 'Esse portador não está cadastrado!', ['&Ok']);
          cxPaginas.ActivePage := tbsBaixa;
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPorVin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin

          If (Pos(edtCodPorVin.Text, strPortadoresOperador) <= 0) Then
          Begin
            If Not fEmptyStr(edtCodPorVin.Text) Then
            Begin
              fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+strMensagemConfig, ['&Ok']);
              Result := False;
            End
          End;

        End
        Else If (Not fPortadorPermiteBaixa(edtCodPorVin.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtCodPorDes) Then
    Begin
      If fEmptyStr(TEditFocus(Sender).Text) Then
      Begin
        fMensagem('', 'Todos os portadores devem ser preenchidos!'+strMensagemConfig, ['&Ok']);

        If (Sender = edtCodPorDes) Then edtDesPorDes.Clear;

        cxPaginas.ActivePage := tbsBaixa;
        Result := False;
      End
      Else
      Begin

        If (Sender = edtCodPorDes) Then pCarregaPortador(edtCodPorDes.Text, edtDesPorDes);

        If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('', 'Esse portador não está cadastrado!'+strMensagemConfig, ['&Ok']);
          cxPaginas.ActivePage := tbsBaixa;
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPorDes.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin

          If (Pos(edtCodPorDes.Text, strPortadoresOperador) <= 0) Then
          Begin
            If Not fEmptyStr(edtCodPorDes.Text) Then
            Begin
              fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+strMensagemConfig, ['&Ok']);
              Result := False;
            End
          End;

        End
        Else If (Not fPortadorPermiteBaixa(edtCodPorDes.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
          Result := False;
        End;
      End;
    End
    Else If (tbsEncBan.TabVisible = True) and (Sender = edtPorTar) Then
    Begin
      If fEmptyStr(TEditFocus(Sender).Text) Then
      begin
        If (Sender = edtPorTar) Then edtDesPorTar.Clear;
        if (not fEmptyStr(edtValorTarifa.Text)) and (fStrToFloat(edtValorTarifa.Text)>0) then
        Begin
          fMensagem('', 'O portador para baixa da tarifa deve ser preenchido!'+strMensagemConfig, ['&Ok']);

          cxPaginas.ActivePage := tbsEncBan;
          Result := False;
        End
      end
      Else
      Begin
        pCarregaPortador(edtPorTar.Text, edtDesPorTar);

        If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('', 'Esse portador não está cadastrado!'+strMensagemConfig, ['&Ok']);
          cxPaginas.ActivePage := tbsEncBan;
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtPorTar.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin

          If (Pos(edtPorTar.Text, strPortadoresOperador) <= 0) Then
          Begin
            If Not fEmptyStr(edtPorTar.Text) Then
            Begin
              fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+strMensagemConfig, ['&Ok']);
              Result := False;
            End
          End;

        End;
      End;
    End
    Else If (Sender = edtCodPorDir)Then
    Begin
      If fEmptyStr(TEditFocus(Sender).Text) Then
      Begin
        fMensagem('', 'Todos os portadores devem ser preenchidos!'+strMensagemConfig, ['&Ok']);

        If (Sender = edtCodPorDir) Then edtDesPorDir.Clear;

        cxPaginas.ActivePage := tbsBaixa;
        Result := False;
      End
      Else
      Begin

        If (Sender = edtCodPorDir) Then pCarregaPortador(edtCodPorDir.Text, edtDesPorDir);

        If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('', 'Esse portador não está cadastrado!'+strMensagemConfig, ['&Ok']);
          cxPaginas.ActivePage := tbsBaixa;
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPorDir.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin

          If (Pos(edtCodPorDir.Text, strPortadoresOperador) <= 0) Then
          Begin
            If Not fEmptyStr(edtCodPorDir.Text) Then
            Begin
              fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+strMensagemConfig, ['&Ok']);
              Result := False;
            End
          End;

        End
        Else If (Not fPortadorPermiteBaixa(edtCodPorDir.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtCodPorVen) Then
    Begin

      If fEmptyStr(TEditFocus(Sender).Text) Then
      Begin
        fMensagem('', 'Todos os portadores devem ser preenchidos!'+strMensagemConfig, ['&Ok']);

        If (Sender = edtCodPorVen) Then edtDesPorVen.Clear;

        cxPaginas.ActivePage := tbsBaixa;
        Result := False;
      End
      Else
      Begin

        If (Sender = edtCodPorVen) Then pCarregaPortador(edtCodPorVen.Text, edtDesPorVen);

        If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('', 'Esse portador não está cadastrado!'+strMensagemConfig, ['&Ok']);
          cxPaginas.ActivePage := tbsBaixa;
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPorVen.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If (Pos(edtCodPorVen.Text, strPortadoresOperador) <= 0) Then
          Begin
            If Not fEmptyStr(edtCodPorVen.Text) Then
            Begin
              fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+strMensagemConfig, ['&Ok']);
              Result := False;
            End
          End;
        End
        Else If (Not fPortadorPermiteBaixa(edtCodPorVen.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = fraPlanoDeContasBai.MskCodCta) Or
            (Sender = fraPlanoDeContasVin.MskCodCta) Or
            (Sender = fraPlanoDeContasDes.MskCodCta) Or
            (Sender = fraPlanoDeContasDir.MskCodCta) Or
            (Sender = fraPlanoDeContasVen.MskCodCta) Then
    Begin

      If fEmptyStr(TMaskEdit(Sender).Text) Then
      Begin
        fMensagem('', 'Todas as Contas do Plano de Contas devem ser preenchidas!'+strMensagemConfig, ['&Ok']);

             If (Sender = fraPlanoDeContasBai.MskCodCta) Then fraPlanoDeContasBai.edtDesCta.Clear
        Else If (Sender = fraPlanoDeContasVin.MskCodCta) Then fraPlanoDeContasVin.edtDesCta.Clear
        Else If (Sender = fraPlanoDeContasDes.MskCodCta) Then fraPlanoDeContasDes.edtDesCta.Clear
        Else If (Sender = fraPlanoDeContasDir.MskCodCta) Then fraPlanoDeContasDir.edtDesCta.Clear
        Else If (Sender = fraPlanoDeContasVen.MskCodCta) Then fraPlanoDeContasVen.edtDesCta.Clear;

        cxPaginas.ActivePage := tbsBaixa;
        Result := False;
      End
      Else
      Begin

             If (Sender = fraPlanoDeContasBai.MskCodCta) Then pCarregaCentroCusto(fraPlanoDeContasBai.MskCodCta.Text, fraPlanoDeContasBai.edtDesCta)
        Else If (Sender = fraPlanoDeContasVin.MskCodCta) Then pCarregaCentroCusto(fraPlanoDeContasVin.MskCodCta.Text, fraPlanoDeContasVin.edtDesCta)
        Else If (Sender = fraPlanoDeContasDes.MskCodCta) Then pCarregaCentroCusto(fraPlanoDeContasDes.MskCodCta.Text, fraPlanoDeContasDes.edtDesCta)
        Else If (Sender = fraPlanoDeContasDir.MskCodCta) Then pCarregaCentroCusto(fraPlanoDeContasDir.MskCodCta.Text, fraPlanoDeContasDir.edtDesCta)
        Else If (Sender = fraPlanoDeContasVen.MskCodCta) Then pCarregaCentroCusto(fraPlanoDeContasVen.MskCodCta.Text, fraPlanoDeContasVen.edtDesCta);

        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('', 'Esse Plano de Contas não está cadastrado!'+strMensagemConfig, ['&Ok']);
          cxPaginas.ActivePage := tbsBaixa;
          Result := False;
        End
        Else
        Begin
          If (Sender = fraPlanoDeContasBai.MskCodCta) Then
            Result := PlanoDeContasAtivo(fraPlanoDeContasBai.MskCodCta.Text,True)
          Else If (Sender = fraPlanoDeContasVin.MskCodCta) Then
            Result := PlanoDeContasAtivo(fraPlanoDeContasVin.MskCodCta.Text,True)
          Else If (Sender = fraPlanoDeContasDes.MskCodCta) Then
            Result := PlanoDeContasAtivo(fraPlanoDeContasDes.MskCodCta.Text,True)
          Else If (Sender = fraPlanoDeContasDir.MskCodCta) Then
            Result := PlanoDeContasAtivo(fraPlanoDeContasDir.MskCodCta.Text,True)
          Else If (Sender = fraPlanoDeContasVen.MskCodCta) Then
            Result := PlanoDeContasAtivo(fraPlanoDeContasVen.MskCodCta.Text,True)
        End;
      End;

    End

    Else If (Sender = edtMandMsg) Then
    Begin

      If fEmptyStr(edtMandMsg.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Mandar Mensagem deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else
      Begin
        If (edtMandMsg.Text <> 'S') And (edtMandMsg.Text <> 'N') Then
        Begin
          fMensagem('ATENÇÃO','O Campo Mandar Mensagem deve conter somente S ou N!'+strMensagemConfig,['&OK']);
          Result := False;
        End;

      End;
    End

    Else If (tbsEncBan.TabVisible = True) and  (Sender = edtForTar)  Then
    Begin
      If fEmptyStr(edtForTar.Text) Then
      begin
        edtDesForTar.Clear;
        if (not fEmptyStr(edtValorTarifa.Text)) and (fStrToFloat(edtValorTarifa.Text)>0) then
        Begin
          fMensagem('ATENÇÃO','O Código do fornecedor para baixa da tarifa bancária deve ser preenchido!'+strMensagemConfig,['&OK']);
          Result := False;
        End;
      end
      else
      begin
        pPesquisaCadFor(qryCadFor, qryCadFor, edtForTar.Text);

        If qryCadFor.FieldByName('FOR_CODFOR').IsNull Then
        Begin
          fMensagem('', 'Esse fornecedor não está cadastrado!'+strMensagemConfig, ['&Ok']);
          cxPaginas.ActivePage := tbsEncBan;
          Result := False;
        End
        else
          edtDesForTar.Text  := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
      end;
    End

    Else If (Sender = edtValidaOco) Then
    Begin

      If cmbCodCar.ItemIndex = 3 Then
      Begin
        If fEmptyStr(edtValidaOco.Text) Then
        Begin
          fMensagem('ATENÇÃO','O Campo Valida Ocor. 05 (Cobr. Descontada) deve ser preenchido!'+strMensagemConfig,['&OK']);
          Result := False;
        End
        Else
        Begin
          If (edtValidaOco.Text <> 'S') And (edtValidaOco.Text <> 'N') Then
          Begin
            fMensagem('ATENÇÃO','O Campo Valida Ocor. 05 (Cobr. Descontada) deve conter somente S ou N!'+strMensagemConfig,['&OK']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = edtSacAvalista) Or (Sender = edtCnpjSacAvalista) Then
		Begin
      If (Sender = edtSacAvalista) Then
      Begin
        If Not(fEmptyStr(edtSacAvalista.Text)) Then
        Begin
          If fEmptyStr(edtCnpjSacAvalista.Text) Then
      	  Begin
      		  Sender := edtCnpjSacAvalista;
        	  fMensagem('ATENÇÃO', 'O campo CPF / CNPJ do Sacador Avalista precisa estar Preenchido!'+strMensagemConfig, ['&OK']);
        	  Result := False;
      	  End;
        End;

        If edtSacAvalista.Text = '' Then
        Begin
          If Not(fEmptyStr(edtCnpjSacAvalista.Text)) Then
          Begin
       	    fMensagem('ATENÇÃO', 'O Nome do Sacador Avalista precisa estar Preenchido!'+strMensagemConfig, ['&OK']);
            Result := False;
          End;
        End;

      End;

      If (Length(fTiraCaracEspeciais(edtCnpjSacAvalista.Text)) >= 13 ) Then
      Begin
        If Not fValidaCnpjCpf('1', fTiraCaracEspeciais(edtCnpjSacAvalista.Text)) Then
          Result := False;
      End
      Else If edtCnpjSacAvalista.Text <> '' Then
      Begin
        If Not fValidaCnpjCpf('2', fTiraCaracEspeciais(edtCnpjSacAvalista.Text)) Then
          Result := False;
      End;
    End

    Else If (Sender = cmbCodCar) Then
    Begin
      If cmbCodCar.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Código da Carteira deve ser informado!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else
        pVerificaCodigoTipoCarteira;
    End

    Else If (Sender = edtVarCarteira) Then
    Begin
      If fEmptyStr(edtVarCarteira.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Variação da Carteira deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End
      Else If Length(edtVarCarteira.Text) <> edtVarCarteira.MaxLength Then
      Begin
        fMensagem('ATENÇÃO!','O campo Variação da Carteira deve ter 3 caracteres!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtNumConvenio) Then
    Begin
      If fEmptyStr(edtNumConvenio.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Número do Convênio deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End
      Else If Length(edtNumConvenio.Text) <> edtNumConvenio.MaxLength Then
      Begin
        fMensagem('ATENÇÃO!','O campo Número do Convênio deve ter 7 caracteres!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtContaCorr) Then
    Begin
      If fEmptyStr(edtContaCorr.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Número da Conta Corrente deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If Sender = edtDigCtaCor Then
    Begin
      If fEmptyStr(edtDigCtaCor.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O Campo Dígito da Conta Corrente deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodAgencia) Then
    Begin
      If fEmptyStr(edtCodAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Código da Agencia deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End
      Else If Length(edtCodAgencia.Text) <> edtCodAgencia.MaxLength Then
      Begin
        fMensagem('ATENÇÃO!','O campo Código da Agência deve ter 4 caracteres!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If (tbsEncBan.TabVisible = True) and  (Sender = fraPlanoDeContasEnc.MskCodCta)  Then
    Begin
      If fEmptyStr(fraPlanoDeContasEnc.MskCodCta.Text) Then
      begin
        fraPlanoDeContasEnc.edtDesCta.Clear;
        if (not fEmptyStr(edtValorTarifa.Text)) and (fStrToFloat(edtValorTarifa.Text)>0) then
        Begin
          fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser informado!'+strMensagemConfig, ['&Ok']);
          fraPlanoDeContasEnc.edtDesCta.Clear;
          Result := False;
        End
      end
      Else
      Begin
        pCarregaCentroCusto(fraPlanoDeContasEnc.MskCodCta.Text, fraPlanoDeContasEnc.edtDesCta);
        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!'+strMensagemConfig, ['&Ok']);
          Result := False;
        End
        else
        Begin
          Result := PlanoDeContasAtivo(fraPlanoDeContasEnc.MskCodCta.Text,True);
          fraPlanoDeContasEnc.edtDesCta.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;
        End;

      End;
    End

    Else If Sender = edtDigAgencia Then
    Begin
      If fEmptyStr(edtDigAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O Campo Dígito da Agência deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If Sender = cmbInstrucao1 Then
    Begin
      If cmbInstrucao1.ItemIndex = -1 Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else
      If (cmbInstrucao1.ItemIndex = 0) Then
      Begin
        cmbInstrucao2.ItemIndex := 0;
        cmbInstrucao2.Enabled := False;
      End
      Else
      Begin
        cmbInstrucao2.Enabled := True;
      End;

      If Result Then
        pSetaDiasProtesto();

    End

    Else If (Sender = cmbInstrucao2) And
            (cmbInstrucao2.Enabled)  Then
    Begin

      If cmbInstrucao2.ItemIndex = -1 Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else
      If (cmbInstrucao1.ItemIndex = 12) Then
      Begin
        If (cmbInstrucao2.ItemIndex in [2,3,4,5,6,7,8,9,10,11,12]) Then
        Begin
          fMensagem('','O código da instrução 2 está em conflito com o código da instrução 1! Informe 00, 01 ou 22 para o código da instrução 2.'+strMensagemConfig,['&OK']);
          Result := False;
        End;
      End
      Else
      If cmbInstrucao2.ItemIndex in [2,3,4,5,6,7,8,9,10,11,12] Then
      Begin
        If cmbInstrucao1.ItemIndex in [2,3,4,5,6,7,8,9,10,11,12] Then
        Begin
          fMensagem('','O código da instrução 2 está em conflito com o código da instrução 1! Informe 00, 01 ou 22 para o código da instrução 2.'+strMensagemConfig,['&OK']);
          Result := False;
        End;
      End;

      If Result Then
        pSetaDiasProtesto();

    End


    Else If (Sender = cmbInstruPF) And
            (cmbInstruPF.Enabled)  Then
    Begin

      If (cmbInstrucao1.ItemIndex = 12) And
         (cmbInstruPF.ItemIndex in [2,3,4,5,6,7,8,9,10,11,12])  Then
      Begin
        fMensagem('','O código da instrução para pessoa física está em conflito com o código da instrução 1!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else
      If (cmbInstruPF.ItemIndex in [2,3,4,5,6,7,8,9,10,11,12]) And
         (cmbInstrucao1.ItemIndex in [2,3,4,5,6,7,8,9,10,11,12])  Then
      Begin
        fMensagem('','O código da instrução para pessoa física está em conflito com o código da instrução 1!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else If(cmbInstruPersonalizada.Enabled) And
             (cmbInstruPersonalizada.ItemIndex > -1) And
             (cmbInstruPF.ItemIndex > -1)  Then
      Begin
        fMensagem('ATENÇÃO','Não é permitido utilizar ocorrências personalizada por cliente ' +
                            'juntamento com ocorrências por pessoa física/pessoa jurídica',['&OK']);
        Result := False;
        cmbInstruPF.ItemIndex := -1;
        cmbInstruPJ.ItemIndex := -1;
      End;

      If Result Then
        pSetaDiasProtestoPF();

    End

    Else If (Sender = cmbInstruPJ) And
            (cmbInstruPJ.Enabled)  Then
    Begin

      If (cmbInstrucao1.ItemIndex = 12) And
         (cmbInstruPJ.ItemIndex in [2,3,4,5,6,7,8,9,10,11,12]) Then
      Begin
        fMensagem('','O código da instrução para pessoa juridica está em conflito com o código da instrução 1!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else
      If (cmbInstruPJ.ItemIndex in [2,3,4,5,6,7,8,9,10,11,12]) And
         (cmbInstrucao1.ItemIndex in [2,3,4,5,6,7,8,9,10,11,12]) Then
      Begin
        fMensagem('','O código da instrução para pessoa juridica está em conflito com o código da instrução 1!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else If(cmbInstruPersonalizada.Enabled) And
             (cmbInstruPersonalizada.ItemIndex > -1) And
             (cmbInstruPJ.ItemIndex > -1)  Then
      Begin
        fMensagem('ATENÇÃO','Não é permitido utilizar ocorrências personalizada por cliente ' +
                            'juntamento com ocorrências por pessoa física/pessoa jurídica',['&OK']);
        Result := False;
        cmbInstruPJ.ItemIndex := -1;
        cmbInstruPF.ItemIndex := -1;
      End;

      If Result Then
        pSetaDiasProtestoPJ();

    End

    Else If (Sender = cmbInstruPersonalizada) And
            (cmbInstruPersonalizada.Enabled)  Then
    Begin

      If (cmbInstrucao1.ItemIndex = 12) And
         (cmbInstruPersonalizada.ItemIndex in [2,3,4,5,6,7,8,9,10,11,12])  Then
      Begin
        fMensagem('','O código da instrução personalizada por cliente está em conflito com o código da instrução 1!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else
      If (cmbInstruPersonalizada.ItemIndex in [2,3,4,5,6,7,8,9,10,11,12]) And
         (cmbInstrucao1.ItemIndex in [2,3,4,5,6,7,8,9,10,11,12])  Then
      Begin
        fMensagem('','O código da instrução personalizada por cliente está em conflito com o código da instrução 1!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else If (((cmbInstruPF.Enabled) And
              (cmbInstruPF.ItemIndex > -1)) Or
              ((cmbInstruPJ.Enabled) And
              (cmbInstruPJ.ItemIndex > -1))) And (cmbInstruPersonalizada.ItemIndex > -1) Then
      Begin
        fMensagem('ATENÇÃO','Não é permitido utilizar ocorrências personalizada por cliente ' +
                            'juntamento com ocorrências por pessoa física/pessoa jurídica',['&OK']);
        Result := False;
        cmbInstruPersonalizada.ItemIndex := -1;
      End;

      If Result Then
        pSetaDiasProtestoPersonalizada();

    End

    Else If Sender = edtDiasProt Then
    Begin
      //INSTRUÇÃO 06 OU 88
      If (cmbInstrucao1.ItemIndex = 11) Or
         (cmbInstrucao1.ItemIndex = 14) Or
         (cmbInstrucao2.ItemIndex = 11) Or
         (cmbInstrucao2.ItemIndex = 14) Then
      Begin
        If fEmptyStr(edtDiasProt.Text) Then
        Begin
          fMensagem('','Ao utilizar o código da instrução 06 ou 88, o preenchimento da quantidade de dias para protesto é obrigatório!'+strMensagemConfig,['&O K']);
          Result := False;
        End;

        if (cmbInstrucao1.ItemIndex = 11) Or
           (cmbInstrucao2.ItemIndex = 11) then
        begin
          If Not (StrToInt(edtDiasProt.Text) in [6 .. 29, 35, 40]) Then
          Begin
            fMensagem('','A quantidade de dias para protesto deve ser de 6 a 29, 35 ou 40 dias!'+strMensagemConfig,['&O K']);
            Result := False;
          End;
        end
        else
        //QUANTIDADE DE DIAS PARA PROTESTO PARA INSTRUÇÃO 88
        begin
          If Not (StrToInt(edtDiasProt.Text) in [1 .. 99]) Then
          Begin
            fMensagem('','A quantidade de dias para protesto deve ser de 1 a 99 dias!'+strMensagemConfig,['&O K']);
            Result := False;
          End;
        end;
      End;
    End

    Else If Sender = edtDiasProtPerso Then
    Begin
      //INSTRUÇÃO 06 OU 88
      If (cmbInstruPersonalizada.ItemIndex = 11) Or
         (cmbInstruPersonalizada.ItemIndex = 14) Then
      Begin
        If fEmptyStr(edtDiasProtPerso.Text) Then
        Begin
          fMensagem('','Ao utilizar o código da instrução 06 ou 88 na instrução personalizada, o preenchimento da quantidade de dias para negativação personalizado é obrigatório!'+strMensagemConfig,['&O K']);
          Result := False;
        End;

        if (cmbInstruPersonalizada.ItemIndex = 11) then
        begin
          If Not (StrToInt(edtDiasProtPerso.Text) in [6 .. 29, 35, 40]) Then
          Begin
            fMensagem('','A quantidade de dias para negativação personalizado deve ser de 6 a 29, 35 ou 40 dias!'+strMensagemConfig,['&O K']);
            Result := False;
          End;
        end
        else
        //QUANTIDADE DE DIAS PARA PROTESTO PARA INSTRUÇÃO 88
        begin
          If Not (StrToInt(edtDiasProtPerso.Text) in [1 .. 99]) Then
          Begin
            fMensagem('','A quantidade de dias para negativação personalizado deve ser de 1 a 99 dias!'+strMensagemConfig,['&O K']);
            Result := False;
          End;
        end;
      End;
    End

    Else If Sender = edtDiasProtestoPF Then
    Begin
      //INSTRUÇÃO 06 OU 88
      If (cmbInstruPF.ItemIndex = 11) Or
         (cmbInstruPF.ItemIndex = 14) Then
      Begin
        If fEmptyStr(edtDiasProtestoPF.Text) Then
        Begin
          fMensagem('','Ao utilizar o código da instrução 06 ou 88, o preenchimento da quantidade de dias para protesto/negativação é obrigatório!'+strMensagemConfig,['&O K']);
          Result := False;
        End;

        if (cmbInstruPF.ItemIndex = 11)  then
        begin
          If Not (StrToInt(edtDiasProtestoPF.Text) in [6 .. 29, 35, 40]) Then
          Begin
            fMensagem('','A quantidade de dias para protesto deve ser de 6 a 29, 35 ou 40 dias!'+strMensagemConfig,['&O K']);
            Result := False;
          End;
        end
        else
        //QUANTIDADE DE DIAS PARA PROTESTO PARA INSTRUÇÃO 88
        begin
          If Not (StrToInt(edtDiasProtestoPF.Text) in [1 .. 99]) Then
          Begin
            fMensagem('','A quantidade de dias para negativação deve ser de 1 a 99 dias!'+strMensagemConfig,['&O K']);
            Result := False;
          End;
        end;
      End;
    End

    Else If Sender = edtDiasProtestoPJ Then
    Begin
      //INSTRUÇÃO 06 OU 88
      If (cmbInstruPJ.ItemIndex = 11) Or
         (cmbInstruPJ.ItemIndex = 14) Then
      Begin
        If fEmptyStr(edtDiasProtestoPJ.Text) Then
        Begin
          fMensagem('','Ao utilizar o código da instrução 06 ou 88, o preenchimento da quantidade de dias para protesto é obrigatório!'+strMensagemConfig,['&O K']);
          Result := False;
        End;

        if (cmbInstruPJ.ItemIndex = 11)  then
        begin
          If Not (StrToInt(edtDiasProtestoPJ.Text) in [6 .. 29, 35, 40]) Then
          Begin
            fMensagem('','A quantidade de dias para protesto deve ser de 6 a 29, 35 ou 40 dias!'+strMensagemConfig,['&O K']);
            Result := False;
          End;
        end
        else
        //QUANTIDADE DE DIAS PARA PROTESTO PARA INSTRUÇÃO 88
        begin
          If Not (StrToInt(edtDiasProtestoPJ.Text) in [1 .. 99]) Then
          Begin
            fMensagem('','A quantidade de dias para protesto deve ser de 1 a 99 dias!'+strMensagemConfig,['&O K']);
            Result := False;
          End;
        end;
      End;
    End

    Else If Sender = edtVendorTaxaComprador Then
    Begin
      If (edtTipCob.Text = 'V') And MatchStr(cmbCodCar.Text, ['11', '17']) And fEmptyStr(edtVendorTaxaComprador.Text) Then
      Begin
        fMensagem('','A taxa de juros do comprador deve ser preenchida!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

      If Not fEmptyStr(edtVendorTaxaComprador.Text) Then
      Begin
        If (fStrToFloat(edtVendorTaxaComprador.Text) < 0) Or (fStrToFloat(edtVendorTaxaComprador.Text) >= 100) Then
        Begin
          fMensagem('','O valor da taxa de juros do comprador está inválido!'+strMensagemConfig,['&O K']);
          Result := False;
        End
        Else
        Begin
          edtVendorTaxaComprador.Text := FormatFloat('#0.00#', fStrToFloat(edtVendorTaxaComprador.Text));
        End;
      End;
    End

    Else If Sender = edtVendorTaxaVendedor Then
    Begin
      If (edtTipCob.Text = 'V') And MatchStr(cmbCodCar.Text, ['11', '17']) And fEmptyStr(edtVendorTaxaVendedor.Text) Then
      Begin
        fMensagem('','A taxa de juros do vendedor deve ser preenchida!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

      If Not fEmptyStr(edtVendorTaxaVendedor.Text) Then
      Begin
        If (fStrToFloat(edtVendorTaxaVendedor.Text) < 0) Or (fStrToFloat(edtVendorTaxaVendedor.Text) >= 100) Then
        Begin
          fMensagem('','O valor da taxa de juros do vendedor está inválido!'+strMensagemConfig,['&O K']);
          Result := False;
        End
        Else
        Begin
          edtVendorTaxaVendedor.Text := FormatFloat('#0.00#', fStrToFloat(edtVendorTaxaVendedor.Text));
        End;
      End;
    End

    Else If Sender = cmbVendorIOF Then
    Begin
      If (edtTipCob.Text = 'V') And MatchStr(cmbCodCar.Text, ['11', '17']) And (cmbVendorIOF.ItemIndex < 0) Then
      Begin
        fMensagem('','Selecionar o Indicativo de IOF Financiado!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtSolDta Then
    Begin
      If Pos(edtSolDta.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Solicitar data de pag. para baixa de duplicata deve ser S ou N!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtDtaConvenio) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(edtDtaConvenio.Text))) And (StrToDateDef(edtDtaConvenio.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'A data do convênio informada é inválida! Necessário correção.'+strMensagemConfig, ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = chkCartSeq) Then
    Begin
      If (chkCartSeq.Checked) Then
      Begin
        If fVerificaCartPrimariaAutBan('CONFIG001D7-', tabCarteira.TabIndex + 1) Then
        Begin
          fMensagem('ATENÇÃO','Não pode ser utilizada sequência de Arquivo de Remessa de outra carteira, pois essa está cadastrada no campo Carteira Seq. de outra(s) carteira(s).' ,['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCartSeq) Then
    Begin
      If (chkCartSeq.Checked) Then
      Begin
        If fEmptyStr(edtCartSeq.Text) Then
        Begin
          fMensagem('ATENÇÃO','O campo Carteira Seq. deve ser preenchido!' ,['&O K']);
          Result := False;
        End
        Else
        Begin
          If (Pos(edtCartSeq.Text, '1_2_3_4_5_') <= 0) Then
          Begin
            fMensagem('ATENÇÃO','O campo Carteira Seq. deve ter valor entre 1 e 5!' ,['&O K']);
            Result := False;
          End
          Else
          If edtCartSeq.Text = IntToStr(tabCarteira.TabIndex + 1) Then
          Begin
            fMensagem('ATENÇÃO','O campo Carteira Seq. não pode ser igual a carteira selecionada!' ,['&O K']);
            Result := False;
          End
          Else
          If fEmptyStr(fGetBancoConfig(0, 'CONFIG001D7-' + edtCartSeq.Text, 'PROXNUM', '')) Then
          Begin
            fMensagem('ATENÇÃO','Não pode ser usada essa carteira no campo Carteira Seq., pois essa não possui Último Núm. Seq. Remessa cadastrado!' ,['&O K']);
            Result := False;
          End
          Else
          If fVerificaCartFilhaAutBan('CONFIG001D7-' + edtCartSeq.Text) Then
          Begin
            fMensagem('ATENÇÃO','Não pode ser usada essa carteira no campo Carteira Seq., pois essa já possui uma Carteira Seq. cadastrada!' ,['&O K']);
            Result := False;
          End;
        End;
      End;
    End

    Else If tbsBeneficiario.TabVisible Then
    Begin
      If (Sender = edtNomeBenef) Then
      Begin
        If (Not fEmptyStr(edtCpfBenef.Text)) And fEmptyStr(edtNomeBenef.Text) Then
        Begin
          fMensagem('ATENÇÃO!','O campo Nome do Beneficiário (Pessoa Física) deve ser preenchido!'+strMensagemConfig,['&OK']);
          Result := False;
        End;
      End

      Else If (Sender = edtCpfBenef) Then
      Begin
        If (Not fEmptyStr(edtNomeBenef.Text)) And fEmptyStr(fTiraCaracEspeciais(edtCpfBenef.Text, True, True, True, True, True)) Then
        Begin
          fMensagem('ATENÇÃO!','O campo CPF do Beneficiário (Pessoa Física) deve ser preenchido!'+strMensagemConfig,['&OK']);
          Result := False;
        End

        Else If (Not fEmptyStr(edtCpfBenef.Text)) And (Not fValidaCnpjCpf(edtCpfBenef.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', edtCpfBenef.Text + ' não é um número de CPF válido!'+strMensagemConfig,['&OK']);
          Result := False;
        End;

      End;

      If Not Result Then
        cxPaginas.ActivePage := tbsBeneficiario;
    End;

    If edtResp.Text = 'B' Then
    Begin
      If (Not fEmptyStr(edtSacAvalista.Text)) Or Not (fEmptySTr(edtCnpjSacAvalista.Text)) Then
        pDisableObs
      Else
		    pEnableObs;
    End
    Else
      pEnableObs;

  End;

  If Not Result Then
  begin
    if not blnNaoEditar then
    begin
      cxPaginas.ActivePage := RetornaAbaDoComponete(Sender);
      pSetFocus(Sender);
    end;

  end;



end;

procedure TfrmConfigBrasil7d.grdTarifasDBTableView1DblClick(Sender: TObject);
begin
  inherited;
  If Not cdsCnfOco.isEmpty Then
    btnEdtOco.Click;
end;

procedure TfrmConfigBrasil7d.lblValidaOcoMouseEnter(Sender: TObject);
begin
  inherited;
  edtValidaOco.Hint := 'Este campo só é habilitado ' + #13+#10+
                       'quando utilizada a carteira 17.';

  pShowHint(edtValidaOco, 'Condições para uso do campo');
end;

procedure TfrmConfigBrasil7d.lblValidaOcoMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBrasil7d.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregadados;
  cxPaginas.ActivePage := tbsGeral;
end;

procedure TfrmConfigBrasil7d.tabCarteiraChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if btnCancelar.Visible then
  begin
    btnCancelar.Click;
    if btnCancelar.Visible then
      AllowChange := False;
  end;

  inherited;
end;

procedure TfrmConfigBrasil7d.edtCnpjSacAvalistaChange(Sender: TObject);
begin
  inherited;
  If edtResp.Text = 'B' Then
  Begin
  	If (Not fEmptyStr(edtSacAvalista.Text)) Or Not (fEmptySTr(edtCnpjSacAvalista.Text)) Then
    Begin
    	pDisableObs;
    End
    Else
    Begin
			pEnableObs;
    End;
  End
  Else
  	pEnableObs;
end;

procedure TfrmConfigBrasil7d.edtCnpjSacAvalistaEnter(Sender: TObject);
begin
  inherited;
  pShowHintCnpj(TEditFocus(Sender),'Instruções permitidas:');
end;

procedure TfrmConfigBrasil7d.edtCnpjSacAvalistaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBrasil7d.edtCnpjSacAvalistaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if key = '-' then
    key := #0;
end;

procedure TfrmConfigBrasil7d.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var
    ArrSel: TConsultasArray;
    edtCPor, edtDPor: TEditFocus;
  Procedure AtribuirPonteiros(var ObjEdtCPor, ObjEdtDPor: TEditFocus);
  Begin
    edtCPor := ObjEdtCPor;
    edtDPor := ObjEdtDPor;
  End;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If (Sender = edtCodPor) Then
    Begin
      AtribuirPonteiros(edtCodPor, edtDesPor);

      If fPesqPortador(conSimples, Self, edtCPor, edtDPor, nil, Key, arrSel) then
      Begin
        If fValidaCampos(edtCodPor, True) Then
          Self.SelectNext(ActiveControl, True, True);
      End;
    End
    Else If (Sender = edtCodPorVin) Then
    Begin
      AtribuirPonteiros(edtCodPorVin, edtDesPorVin);

      If fPesqPortador(conSimples, Self, edtCPor, edtDPor, nil, Key, arrSel) then
      Begin
        If fValidaCampos(edtCodPorVin, True) Then
          Self.SelectNext(ActiveControl, True, True);
      End;
    End
    Else If (Sender = edtCodPorDes) Then
    Begin
      AtribuirPonteiros(edtCodPorDes, edtDesPorDes);

      If fPesqPortador(conSimples, Self, edtCPor, edtDPor, nil, Key, arrSel) then
      Begin
        If fValidaCampos(edtCodPorDes, True) Then
          Self.SelectNext(ActiveControl, True, True);
      End;
    End
    Else If (Sender = edtCodPorDir) Then
    Begin
      AtribuirPonteiros(edtCodPorDir, edtDesPorDir);

      If fPesqPortador(conSimples, Self, edtCPor, edtDPor, nil, Key, arrSel) then
      Begin
        If fValidaCampos(edtCodPorDir, True) Then
          Self.SelectNext(ActiveControl, True, True);
      End;
    End
    Else If (Sender = edtCodPorVen) Then
    Begin
      AtribuirPonteiros(edtCodPorVen, edtDesPorVen);

      If fPesqPortador(conSimples, Self, edtCPor, edtDPor, nil, Key, arrSel) then
      Begin
        If fValidaCampos(edtCodPorVen, True) Then
          Self.SelectNext(ActiveControl, True, True);
      End;
    End
    Else If (Sender = edtPorTar) Then
    Begin
      AtribuirPonteiros(edtPorTar, edtDesPorTar);

      If fPesqPortador(conSimples, Self, edtCPor, edtDPor, nil, Key, arrSel) then
      Begin
        If fValidaCampos(edtPorTar, True) Then
          Self.SelectNext(ActiveControl, True, True);
      End;
    End;

  End;
end;

procedure TfrmConfigBrasil7d.edtCodPorRemKeyPress(Sender: TObject;
  var Key: Char);
var
    ArrSel: TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtCodPorRem, edtDescPorRem, nil, Key, arrSel) then
    Begin
      If fValidaCampos(edtCodPorRem, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigBrasil7d.edtDiasCredEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtDiasCred, 'Informar quantidade de dias ' + #13+#10 +
                           'do intervalo entre a efetuação ' + #13+#10 +
                           'do pagamento e o crédito na ' + #13+#10 +
                           'conta corrente.');

  pShowHint(edtDiasCred, 'Dias para Crédito');
end;

procedure TfrmConfigBrasil7d.edtDiasCredExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBrasil7d.edtEmpBolEnter(Sender: TObject);
begin
  inherited;
  edtEmpBol.Hint := 'Caso a configuração "CFG_NOMCED - Nome ' + #13+#10 +
                    'do Cedente" esteja informada, o valor  ' + #13+#10 +
                    'contido nela que sairá na impressão do ' + #13+#10 +
                    'boleto e não o nome da empresa indicada ' + #13+#10 +
                    'neste campo.';

  pShowHint(edtEmpBol, 'Empresa para informação de boleto');
end;

procedure TfrmConfigBrasil7d.edtEmpBolExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBrasil7d.edtForTarKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************KP*}
  If fPesqFornecedor(conForCompleta, Self, edtForTar, edtDesForTar, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtForTar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConfigBrasil7d.edtPorDesEnter(Sender: TObject);
begin
  inherited;
  edtPorDes.Hint := 'Ao realizar o desconto das duplicatas, ' + #13+#10 +
                      'essa será transferida para o portador  ' + #13+#10 +
                      'selecionado nesse campo, até que seja ' + #13+#10 +
                      'realizada sua baixa.';

  pShowHint(edtPorDes, 'Portador de Duplicatas Descontadas');
end;

procedure TfrmConfigBrasil7d.edtPorDesExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBrasil7d.edtPorDesKeyPress(Sender: TObject; var Key: Char);
  Var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    pHideHint;
    If fPesqPortador(conSimples, Self, edtPorDes, edtDesPorDescontada, nil, Key, arrSel) then
    Begin
      If fValidaCampos(edtPorDes, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigBrasil7d.edtQtdDiasDataLimiteRecEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtQtdDiasDataLimiteRec, 'Informar quantidade de dias ' + #13+#10 +
                           'para Data Limnite de recebimento, ' + #13+#10 +
                           'usando como base a data de ' + #13+#10 +
                           'vencimento do título.');

  pShowHint(edtQtdDiasDataLimiteRec, 'Dias para Data Limite de Recibimento');
end;

procedure TfrmConfigBrasil7d.edtQtdDiasDataLimiteRecExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;


procedure TfrmConfigBrasil7d.edtRespChange(Sender: TObject);
begin
  inherited;
  ExibeEnviaEmailBloqueto;
end;

procedure TfrmConfigBrasil7d.edtSacAvalistaChange(Sender: TObject);
begin
inherited;
   pEnableObs;

  If (edtResp.Text = 'B') And
     (Not fEmptyStr(edtSacAvalista.Text)) Or Not (fEmptySTr(edtCnpjSacAvalista.Text)) Then
    pDisableObs;
end;

procedure TfrmConfigBrasil7d.edtSacAvalistaEnter(Sender: TObject);
begin
  inherited;
  pShowHint(TEditFocus(Sender),'Instruções permitidas:');
end;

procedure TfrmConfigBrasil7d.edtSacAvalistaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBrasil7d.edtTipCobChange(Sender: TObject);
begin
  inherited;
  ExibeEnviaEmailBloqueto;
end;

procedure TfrmConfigBrasil7d.pAlteraHint(edtEdit: TEditFocus;
  strNovoHint: String);
begin
  edtEdit.Hint := strNovoHint;
end;

procedure TfrmConfigBrasil7d.pAlteraHintBotao(btnBotao: TBitBtnLocked;
  strNovoHint: String);
begin
  btnBotao.Hint := strNovoHint;
end;

procedure TfrmConfigBrasil7d.pCarregaCentroCusto(strCtaBai: String; edtLabel: TEdit);
begin
  If Not fEmptyStr(strCtaBai) Then
  Begin
    pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
    edtLabel.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;
  End
  Else
    edtLabel.Clear;
end;

procedure TfrmConfigBrasil7d.pCarregaPortador(strCodPor: String; edtLabel: TEdit);
begin
  If Not fEmptyStr(strCodPor) Then
  Begin
    pPesquisaCadPor(Nil, qryCadPor, strCodPor);
    edtLabel.Text := qryCadPor.FieldByName('POR_NOMPOR').AsString;
  End
  Else
    edtLabel.Clear;
end;

procedure TfrmConfigBrasil7d.pDisableObs;
begin
  edtObservacao1.Clear;
  edtObservacao2.Clear;
  edtObservacao3.Clear;
  edtObservacao4.Clear;
  edtObservacao5.Clear;

  edtObservacao1.Color := cl3Dlight;
  edtObservacao1.FocusColor := cl3Dlight;
  edtObservacao2.Color := cl3Dlight;
  edtObservacao2.FocusColor := cl3Dlight;
  edtObservacao3.Color := cl3Dlight;
  edtObservacao3.FocusColor := cl3Dlight;
  edtObservacao4.Color := cl3Dlight;
  edtObservacao4.FocusColor := cl3Dlight;
  edtObservacao5.Color := cl3Dlight;
  edtObservacao5.FocusColor := cl3Dlight;

  edtObservacao1.Enabled := False;
  edtObservacao2.Enabled := False;
  edtObservacao3.Enabled := False;
  edtObservacao4.Enabled := False;
  edtObservacao5.Enabled := False;
end;

procedure TfrmConfigBrasil7d.pEnableObs;
begin
  edtObservacao1.Color := clWindow;
  edtObservacao1.FocusColor := clWindow;
  edtObservacao2.Color := clWindow;
  edtObservacao2.FocusColor := clWindow;
  edtObservacao3.Color := clWindow;
  edtObservacao3.FocusColor := clWindow;
  edtObservacao4.Color := clWindow;
  edtObservacao4.FocusColor := clWindow;
  edtObservacao5.Color := clWindow;
  edtObservacao5.FocusColor := clWindow;

  edtObservacao1.Enabled := True;
  edtObservacao2.Enabled := True;
  edtObservacao3.Enabled := True;
  edtObservacao4.Enabled := True;
  edtObservacao5.Enabled := True;
end;

procedure TfrmConfigBrasil7d.pHideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmConfigBrasil7d.pLimpaCampos;
var
  i: Integer;
begin
  for i := Self.ComponentCount -1 downto 0 do
  begin
    if (Self.Components[i] is TEditFocus) then
      (Self.Components[i] as TEditFocus).text := '';

    if (Self.Components[i] is TMaskEditFocus) then
      (Self.Components[i] as TMaskEditFocus).text := '  /  /    ';

    if (Self.Components[i] is TfraDirectoryEditFocus) then
      (Self.Components[i] as TfraDirectoryEditFocus).edtDirectory.text := '';

    if (Self.Components[i] is TCheckBox) then
      (Self.Components[i] as TCheckBox).Checked := False;

    if (Self.Components[i] is TComboBoxFocus) then
      (Self.Components[i] as TComboBoxFocus).ItemIndex := -1;
  end;

end;

procedure TfrmConfigBrasil7d.pSetaDiasProtesto;
var
  intItemIndex: Integer;
begin
  if cmbInstrucao1.ItemIndex in [2..11, 14] then
    intItemIndex := cmbInstrucao1.ItemIndex
  else if cmbInstrucao2.ItemIndex in [2..11, 14] then
    intItemIndex := cmbInstrucao2.ItemIndex
  else
    intItemIndex := 0;

  Case intItemIndex Of
    0 : edtDiasProt.Clear;
    2 : edtDiasProt.Text := '3';
    3 : edtDiasProt.Text := '4';
    4 : edtDiasProt.Text := '5';
    5 : edtDiasProt.Text := '10';
    6 : edtDiasProt.Text := '15';
    7 : edtDiasProt.Text := '20';
    8 : edtDiasProt.Text := '25';
    9 : edtDiasProt.Text := '30';
    10: edtDiasProt.Text := '45';
  End;

  if (intItemIndex = 11) or (intItemIndex = 14) then
    edtDiasProt.Enabled := True
  else
    edtDiasProt.Enabled := False;

  Case intItemIndex Of
    0: cmbTipDia.ItemIndex := -1;
    2,3,4: cmbTipDia.ItemIndex := 0;
    5,6,7,8,9,10,11,14: cmbTipDia.ItemIndex := 1;
  End;
end;

procedure TfrmConfigBrasil7d.pSetaDiasProtestoPersonalizada;
 var
     intItemIndex: Integer;
begin

  if cmbInstruPersonalizada.ItemIndex in [2..11, 14] then
     intItemIndex := cmbInstruPersonalizada.ItemIndex
  else
     intItemIndex := 0;

  Case intItemIndex Of
    0 : edtDiasProtPerso.Clear;
    2 : edtDiasProtPerso.Text := '3';
    3 : edtDiasProtPerso.Text := '4';
    4 : edtDiasProtPerso.Text := '5';
    5 : edtDiasProtPerso.Text := '10';
    6 : edtDiasProtPerso.Text := '15';
    7 : edtDiasProtPerso.Text := '20';
    8 : edtDiasProtPerso.Text := '25';
    9 : edtDiasProtPerso.Text := '30';
    10: edtDiasProtPerso.Text := '45';
  End;

  if (intItemIndex = 11) or (intItemIndex = 14) then
     edtDiasProtPerso.Enabled := True
  else
     edtDiasProtPerso.Enabled := False;

end;

procedure TfrmConfigBrasil7d.pShowHint(edtEdit: TEditFocus; strTitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,edtEdit.ClientOrigin.Y, strTitulo, edtEdit.Hint);
end;

procedure TfrmConfigBrasil7d.pShowHintBotao(btnBotao: TBitBtnLocked;
  strTitulo: String);
begin
  HintControler.ShowHint(btnBotao.ClientOrigin.X,btnBotao.ClientOrigin.Y, strTitulo, btnBotao.Hint);
end;

procedure TfrmConfigBrasil7d.pShowHintCnpj(edtEdit: TEditFocus;
  strTitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,edtEdit.ClientOrigin.Y, strTitulo, edtEdit.Hint);
end;

procedure TfrmConfigBrasil7d.pVerificaCodigoTipoCarteira;
begin
  If cmbCodCar.ItemIndex = 3 Then
    edtValidaOco.Enabled := True
  Else
  Begin
    edtValidaOco.Enabled := False;
    edtValidaOco.Text := 'S';
  End;

  gbVendor.Visible := (edtTipCob.Text = 'V') And (MatchStr(cmbCodCar.Text, ['11', '17']));
end;

function TfrmConfigBrasil7d.RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;
begin
  While Not Sender.ClassName.Equals('TcxTabSheet') Do
  Begin
    Sender := Sender.Parent;
  End;
  Result := TcxTabSheet(Sender);

end;

procedure TfrmConfigBrasil7d.FormActivate(Sender: TObject);
begin
  inherited;
  If edtProxNumArqRem.Enabled Then
    pSetFocus(edtProxNumArqRem)
  Else
    pSetFocus(cmbCodCar);
end;

procedure TfrmConfigBrasil7d.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  qryCadFor := fCriaQuery(Self);
  qryCadEmp := fCriaQuery(Self);
  pCarKeyAutBan;
  cxPaginas.Properties.ActivePage := tbsGeral;
  tbsBeneficiario.TabVisible      := fCfgSis('BENBOL', varBoolean);

  tbsEncBan.TabVisible := fCfgSis('ENCBAN', varBoolean);
end;

procedure TfrmConfigBrasil7d.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_Escape) then
  begin
    if btnCancelar.Visible then
    begin
      btnCancelar.Click;
      if btnCancelar.Visible then
        SysUtils.Abort;
    end;
  end;

  inherited;
end;

procedure TfrmConfigBrasil7d.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBrasil7d.btnAddOcoClick(Sender: TObject);
begin
  inherited;
  frmCadOcoCartei := TfrmCadOcoCartei.Create(nil);
  frmCadOcoCartei.strCartei :=  'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp;
  frmCadOcoCartei.cmbTipDes.Visible := True;
  frmCadOcoCartei.cmbTipDes.Enabled := True;
  frmCadOcoCartei.lblTipDes.Visible := True;

  Try
    frmCadOcoCartei.ShowModal;
  Finally
    FreeAndNil(frmCadOcoCartei);
  End;
  pCarregaOcorrencias;
end;

procedure TfrmConfigBrasil7d.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do registro da carteira selecionada?', ['&S i m', '&N ã o'], 2) = 1 then
  begin
    cxPaginas.ActivePage :=  tbsGeral;
    btnCancelar.Visible := False;
    btnEditar.Visible   := True;
    pnlAtivo1.Enabled := False;
    pnlComplemento.Enabled := pnlAtivo1.Enabled;
    pnlAtivo2.Enabled := False;
    pnlAtivo4.Enabled := False;
    if tbsEncBan.tabVisible then
       pnlAtivo3.Enabled:= False;
    btnEditar.Visible   := True;
    btnGravar.Enabled   := False;
    btnConfigurar.Enabled := False;
    pCarregaDados;
    pSetFocus(btnEditar);
  end;
end;

procedure TfrmConfigBrasil7d.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pHideHint;

    pCriarFormularios(TfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '001';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigBrasil7d.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\001400p7d.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\001400p7d.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigBrasil7d.btnOcorrenciaClick(Sender: TObject);
  Var
    strDetalhe : String;
begin
  inherited;
  pHideHint;

  strDetalhe := #13#10 +
                '05, 06, 07, 08, 15 - Baixa duplicata; ' + #13#10 +
                '02 - Atualiza nosso número caso não tenha gravado; ' + #13#10 +
                '09 - Baixa de Titulo;' + #13#10 +
                '23 - Lança histórico de protesto; ' + #13#10 +
                '72 - Alteração de tipo de cobrança.'+ #13#10 +
                #13#10 +
                'Obs.: Código 05 só é tratado para carteira 17, ' +
                'quando estiver setada a configuração ' +
                '"Valida a Ocorrência 05" com N.' + #13#10 +
                #13#10 +
                'As ocorrências listadas também fazem a atualização do código ' +
                'do Evento e do Portador das duplicatas, no caso dessas '+
                'ocorrências possuírem Evento/Portador vinculados.'+ #13#10 +
                #13#10 +
                'As demais ocorrências são gravadas na rotina ' +
                'de retorno e mostradas no relatório apenas em ' +
                'caráter informativo.'+ #13#10 +
                #13#10 +
                'Pressione Esc para voltar à tela de configurações.';

  TfrmMemo.pShowMessage('Banco 001 - Banco do Brasil - Detalhamento de Ocorrências (posições 109 - 110 arquivo retorno).' + #13#10 +
                        strDetalhe);
end;

procedure TfrmConfigBrasil7d.btnOcorrenciaEnter(Sender: TObject);
begin
  inherited;
  pAlteraHintBotao(btnOcorrencia, 'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
                                  'que são tratados pelas rotinas do sistema.');
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigBrasil7d.btnOcorrenciaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBrasil7d.btnRemOcoClick(Sender: TObject);
  Var
    objCnfOco: TCnfOco;
    objCnfDao: TCnfOcoDao;
    strCodBco: String;
    strTipLay: String;
    strNumPos: String;
    strEspeci: String;
    strCodEmp: String;
    intCartei: Integer;
begin
  inherited;
  If Not cdsCnfOco.isEmpty Then
  Begin
    if fMensagem('Aviso', 'Confirma remoção da ocorrência selecionada?', ['&S i m', '&N ã o']) = 1 then
    Begin
      pDesmembraCarteira('CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp,
                         strCodBco, strTipLay, strNumPos, strEspeci, strCodEmp, intCartei);

      objCnfDao := TCnfOcoDao.Create(strCodBco, strTipLay, strNumPos,
                                     strEspeci, strCodEmp, intCartei);

      objCnfOco := objCnfDao.fBuscaPorOcorrencia(cdsCnfOcoCNF_CODOCO.AsString,
                                                 cdsCnfOcoCNF_MOTOCO.AsString,
                                                 Copy(cdsCnfOcoCNF_PLNCON.AsString,1,7),
                                                 cdsCnfOcoCNF_TIPDES.AsInteger);
      If Assigned(objCnfOco) Then
      Begin
        If objCnfDao.fRemoverOcorrencia(objCnfOco.strCodOco,
                                        objCnfOco.strMotOco,
                                        objCnfOco.strCodCta,
                                        objCnfOco.intTipDes) Then
        Begin
          pCarregaOcorrencias;
          pMensagemOk('Registro removido com sucesso!');
        End;
        objCnfOco.Free;
      End;
      objCnfDao.Free;
    End;
  End;
end;

procedure TfrmConfigBrasil7d.chkCartSeqClick(Sender: TObject);
begin
  inherited;
  If Not fValidaCampos(chkCartSeq) Then
    TCheckBox(Sender).Checked := False;

  lblCartSeq.Enabled := TCheckBox(Sender).Checked;
  edtCartSeq.Enabled := TCheckBox(Sender).Checked;
end;

procedure TfrmConfigBrasil7d.cmbCodCarChange(Sender: TObject);
begin
  inherited;
  pVerificaCodigoTipoCarteira;
end;

procedure TfrmConfigBrasil7d.cmbInstrucao1Change(Sender: TObject);
begin
  inherited;
  If (cmbInstrucao1.ItemIndex = 0)  Then
  Begin
    cmbInstrucao2.ItemIndex := 0;
    cmbInstrucao2.Enabled := False;
  End
  Else
  Begin
    cmbInstrucao2.Enabled := True;
  End;

  pSetaDiasProtesto();
end;

procedure TfrmConfigBrasil7d.cmbInstrucao2Change(Sender: TObject);
begin
  inherited;

  pSetaDiasProtesto();
end;

procedure TfrmConfigBrasil7d.cmbInstruPersonalizadaChange(Sender: TObject);
begin
  inherited;
  pSetaDiasProtestoPersonalizada();
end;

procedure TfrmConfigBrasil7d.cmbInstruPersonalizadaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (Key = #8) Then
     cmbInstruPersonalizada.itemIndex := -1;
end;

procedure TfrmConfigBrasil7d.edtConDesSujEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtConDesSuj, 'Quando a diferença no valor recebido ' + #13+#10 +
                            'for exatamente o valor de desconto sugerido ' + #13+#10 +
                            'cadastrado no título a diferença será abatida '+ #13+#10+
                            'como desconto. ' );

  pShowHint(edtConDesSuj, 'Desconto Sugerido');
end;

procedure TfrmConfigBrasil7d.edtConDesSujExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBrasil7d.edtValorTarifaExit(Sender: TObject);
begin
  try
    if not fEmptyStr(edtValorTarifa.Text) then
       edtValorTarifa.Text := FormatFloat('###,##0.00', fStrToFloat(edtValorTarifa.Text));
  except

  end

end;

procedure TfrmConfigBrasil7d.ExibeEnviaEmailBloqueto;
  Var
    LExibir: Boolean;
begin
  LExibir := False;
  If Trim(edtResp.Text).Equals('B') Or MatchStr(edtTipCob.Text,['I','D']) Then
    LExibir := True;


  lblEnviaEmailBloqueto.Visible := LExibir;
  edtEnviaEmailBloqueto.Visible := LExibir;
  clEnviaEmailBloqueto.Visible  := LExibir;
end;

procedure TfrmConfigBrasil7d.edtVendorTaxaCompradorExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtVendorTaxaComprador);
end;

procedure TfrmConfigBrasil7d.edtVendorTaxaVendedorExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtVendorTaxaVendedor);
end;

procedure TfrmConfigBrasil7d.pCarregaCfg(Var stlCampos: TStringList);
begin
  If femptyStr(strConfig) Then
    strConfig := 'CONFIG001D7-';

  stlCampos.Clear;
  stlCampos.Add('Seq. Remessa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  stlCampos.Add('Util Outra Cart.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', ''));
  stlCampos.Add('Carteira Seq.     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', ''));
  stlCampos.Add('Código Carteira   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', ''));
  stlCampos.Add('Variação Carteira :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'VARCART', ''));
  stlCampos.Add('Número Convênio   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', ''));
  stlCampos.Add('Código Agência    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Dígito Agência    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', ''));
  stlCampos.Add('Num. C. Corrente  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  stlCampos.Add('Díg. C. Corrente  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', ''));
  stlCampos.Add('Nome Agência      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NOMAGEN', ''));
  stlCampos.Add('Cód. Instrução 1  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', ''));
  stlCampos.Add('Cód. Instrução 2  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', ''));
  stlCampos.Add('Cód. Inst. Persona:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTPER', ''));
  stlCampos.Add('Data do Convênio  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DTACONV', ''));
  stlCampos.Add('CNPJ Sac/Avalista :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CNPJSAC', ''));
  stlCampos.Add('Sacador/Avalista  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', ''));
  stlCampos.Add('Observação 1      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Observação 3      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  stlCampos.Add('Observação 4      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  stlCampos.Add('Observação 5      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  stlCampos.Add('Dias p/ protesto  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  stlCampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  stlCampos.Add('Arquivo Remessa   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo Retorno   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  stlCampos.Add('Percentual Multa  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', ''));
  stlCampos.Add('Protocolo Aceite  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', ''));
  stlCampos.Add('Enviar e-mail Bloqueto na remessa?  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ENVIAEMAILBLOQUETO', ''));
  stlCampos.Add('Resp. Emissão Bol :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', ''));

  stlCampos.Add('Cód. Instrução pessoa física  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRUCAO_PF', ''));
  stlCampos.Add('Cód. Instrução pessoa jurídica:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRUCAO_PJ', ''));
  stlCampos.Add('Dias para Protesto pessoa física  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAS_PROTESTO_PF', ''));
  stlCampos.Add('Dias para Protesto pessoa jurídica:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAS_PROTESTO_PJ', ''));

  stlCampos.Add('Nro Dupl. Agrup.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'MANDMSG', ''));
  stlCampos.Add('Tipo de Cobrança  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TIPCOBR', ''));
  stlCampos.Add('Valida Ocorr. 05  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'VALOCO5', ''));
  stlCampos.Add('Tipo dia protesto :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TIPDIA', ''));
  stlCampos.Add('Info Adicional    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', ''));
  stlCampos.Add('Conv. Serasa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CVSERAS', ''));
  stlCampos.Add('Baixa Simples Por.:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Baixa Simples Cta.:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Baixa Vincul Por. :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAII', ''));
  stlCampos.Add('Baixa Vincul Cta. :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAII', ''));
  stlCampos.Add('Baixa Descon Por. :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAID', ''));
  stlCampos.Add('Baixa Descon Cta. :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAID', ''));
  stlCampos.Add('Baixa Vendor Por. :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAIV', ''));
  stlCampos.Add('Baixa Vendor Cta. :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAIV', ''));
  stlCampos.Add('Baixa Direta Por. :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAIR', ''));
  stlCampos.Add('Baixa Direta Cta. :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAIR', ''));
  stlCampos.Add('Data Pagto Baixa  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SOLIDTA', ''));
  stlCampos.Add('Enc.Ban. Vr Tarifa:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', ''));
  stlCampos.Add('Enc.Ban. Portador :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', ''));
  stlCampos.Add('Enc.Ban. Pl Conta :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', ''));
  stlCampos.Add('Enc.Ban. Fornec.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', ''));
  stlCampos.Add('Lançar Tarifa Ban.:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'LANTX02', ''));
  stlCampos.Add('Portador Descontadas:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORTDES', ''));
  stlCampos.Add('Portador da remessa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', ''));
  stlCampos.Add('Data Compensação das taxas:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DTCOMTA', '2'));
  stlCampos.Add('Utl. Desconto de Duplicata para cobranças vinculada:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'UTLDESCOBVINC', ''));
  stlCampos.Add('Considerar Desconto Sugerido na baixa?:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CONSIDESSUJ', ''));
  stlCampos.Add('Utilizar Parcela Numeral?' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PARCNUM', ''));
  stlCampos.Add('Empresa p/ informações do boleto:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'EMPRBOL', ''));
  stlCampos.Add('Quantidade de Dias para Data Limite Rec.:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIALIMI', ''));
  stlCampos.Add('Nome:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NOMBENE', ''));
  stlCampos.Add('CPF:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CPFBENE', ''));
  stlCampos.Add('Envia caracteres especiais :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ENVCESP', ''));
  stlCampos.Add('Permitir impressão de boletos? :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', ''));

  stlCampos.Add('[Vendor] Taxa Vendedor:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TAXAVEN', ''));
  stlCampos.Add('[Vendor] Taxa Comprador:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TAXACOM', ''));
  stlCampos.Add('[Vendor] Indicativo de IOF Financiado:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INDIOF', ''));

end;

procedure TfrmConfigBrasil7d.pGravaLogCarteira(stlCfgAnt : TStringList);
Var
  stlCfgAtu: TStringList;
  strCmpAlt: String;
  intCont,
  intIndice: Integer;

  function fRetStrCfg(stlCfg : TStringList) : String;
  Var
    intCont : Integer;
  begin
    Result := '';

    For intCont := 0 To stlCfg.Count - 1 Do
      Result := Result + stlCfg.Strings[intCont] + #13+#10;
  end;

begin
  stlCfgAtu := TStringList.Create;
  pCarregaCfg(stlCfgAtu);
  strCmpAlt := '';

  For intCont := 0 To stlCfgAtu.Count - 1 Do
  Begin
    If stlCfgAnt.Strings[intCont] <> stlCfgAtu.Strings[intCont] Then
    Begin
      intIndice := Pos(':', stlCfgAnt.Strings[intCont]);

      If Not fEmptyStr(strCmpAlt) Then
        strCmpAlt := strCmpAlt + #13+#10;

      strCmpAlt := strCmpAlt + Copy(stlCfgAnt.Strings[intCont], 1, intIndice) +
                  ' Valor Anterior - ' + Copy(stlCfgAnt.Strings[intCont], intIndice + 1, Length(stlCfgAnt.Strings[intCont]) - intIndice) +
                  ' Valor Atual - ' + Copy(stlCfgAtu.Strings[intCont], intIndice + 1, Length(stlCfgAtu.Strings[intCont]) - intIndice);
    End;
  End;

  If Not fEmptyStr(strCmpAlt) Then
    pGravaLogAtb('001', 'BANCO DO BRASIL 7D', 'CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

procedure TfrmConfigBrasil7d.pCarregaOcorrencias;
var
  lstCnfOco: TObjectList<TCnfOco>;
  objCnfOco: TCnfOco;
  objCnfDao: TCnfOcoDao;
  strCodBco: String;
  strTipLay: String;
  strNumPos: String;
  strEspeci: String;
  strCodEmp: String;
  intCartei: Integer;
begin
  cdsCnfOco.DisableControls;
  cdsCnfOco.EmptyDataSet;
  cdsCnfOco.Close;
  cdsCnfOco.Open;

  pDesmembraCarteira('CONFIG001D7-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp, strCodBco,
                     strTipLay, strNumPos, strEspeci, strCodEmp, intCartei);

  objCnfDao := TCnfOcoDao.Create(strCodBco, strTipLay, strNumPos,
                                 strEspeci, strCodEmp, intCartei);

  lstCnfOco := objCnfDao.fBuscaTodas;

  If lstCnfOco.Count > 0 Then
  Begin
    For objCnfOco in lstCnfOco Do
    Begin
      With cdsCnfOco Do
      Begin
        Append;
        cdsCnfOcoCNF_CODOCO.AsString := objCnfOco.strCodOco;
        cdsCnfOcoCNF_DESOCO.AsString := objCnfOco.strDesOco;
        cdsCnfOcoCNF_MOTOCO.AsString := objCnfOco.strMotOco;
        cdsCnfOcoCNF_GERPAG.Value    := objCnfOco.blnGerpag;
        cdsCnfOcoCNF_CUSCAR.Value    := objCnfOco.blnCusCar;
        cdsCnfOcoCNF_USADIA.Value    := objCnfOco.blnUsaDia;
        cdsCnfOcoCNF_FORNEC.AsString := objCnfOco.strCodFor + ' - ' + fRetNomFornecedor(objCnfOco.strCodFor);
        cdsCnfOcoCNF_PORTAD.AsString := objCnfOco.strCodPor + ' - ' + fRetNomPortador(objCnfOco.strCodPor);
        cdsCnfOcoCNF_PLNCON.AsString := objCnfOco.strCodCta + ' - ' + fRetDescCentroCusto(objCnfOco.strCodCta);
        cdsCnfOcoCNF_TIPDES.AsInteger:= objCnfOco.IntTipDes;
        Case objCnfOco.IntTipDes of
          0: cdsCnfOcoCNF_DSTPDS.AsString := '';
          1: cdsCnfOcoCNF_DSTPDS.AsString := 'TARIFA IOF DESCONTO';
          2: cdsCnfOcoCNF_DSTPDS.AsString := 'TARIFA BOLETO DESC';
          3: cdsCnfOcoCNF_DSTPDS.AsString := 'TARIFA DESCONTADA';
        End;
        Post;
      End;
    End;
  End;

  lstCnfOco.Free;
  objCnfDao.Free;

  cdsCnfOco.First;
  cdsCnfOco.EnableControls;
end;

procedure TfrmConfigBrasil7d.pSetaDiasProtestoPF;
var
  intItemIndex: Integer;
begin
  if cmbInstruPF.ItemIndex in [2..11, 14] then
    intItemIndex := cmbInstruPF.ItemIndex
  else
    intItemIndex := 0;

  Case intItemIndex Of
    0 : edtDiasProtestoPF.Clear;
    2 : edtDiasProtestoPF.Text := '3';
    3 : edtDiasProtestoPF.Text := '4';
    4 : edtDiasProtestoPF.Text := '5';
    5 : edtDiasProtestoPF.Text := '10';
    6 : edtDiasProtestoPF.Text := '15';
    7 : edtDiasProtestoPF.Text := '20';
    8 : edtDiasProtestoPF.Text := '25';
    9 : edtDiasProtestoPF.Text := '30';
    10: edtDiasProtestoPF.Text := '45';
  End;

  if (intItemIndex = 11) or (intItemIndex = 14) then
    edtDiasProtestoPF.Enabled := True
  else
    edtDiasProtestoPF.Enabled := False;

  If  (intItemIndex = 14) Then
    lblQtdDiasProtestoPF.Caption := 'Dias para negativação:';
end;


procedure TfrmConfigBrasil7d.pSetaDiasProtestoPJ;
var
  intItemIndex: Integer;
begin
  if cmbInstruPJ.ItemIndex in [2..11, 14] then
    intItemIndex := cmbInstruPJ.ItemIndex
  else
    intItemIndex := 0;

  Case intItemIndex Of
    0 : edtDiasProtestoPJ.Clear;
    2 : edtDiasProtestoPJ.Text := '3';
    3 : edtDiasProtestoPJ.Text := '4';
    4 : edtDiasProtestoPJ.Text := '5';
    5 : edtDiasProtestoPJ.Text := '10';
    6 : edtDiasProtestoPJ.Text := '15';
    7 : edtDiasProtestoPJ.Text := '20';
    8 : edtDiasProtestoPJ.Text := '25';
    9 : edtDiasProtestoPJ.Text := '30';
    10: edtDiasProtestoPJ.Text := '45';
  End;

  if (intItemIndex = 11) or (intItemIndex = 14) then
    edtDiasProtestoPJ.Enabled := True
  else
    edtDiasProtestoPJ.Enabled := False;

  If (intItemIndex = 14) Then
    lblQtdDiasProtestoPJ.Caption := 'Dias para negativação:';
end;

procedure TfrmConfigBrasil7d.cmbInstruPFChange(Sender: TObject);
begin
  inherited;
  pSetaDiasProtestoPF;
end;

procedure TfrmConfigBrasil7d.cmbInstruPFKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (Key = #8) Then
    cmbInstruPF.itemIndex := -1;
end;

procedure TfrmConfigBrasil7d.cmbInstruPJChange(Sender: TObject);
begin
  inherited;
  pSetaDiasProtestoPJ;
end;

procedure TfrmConfigBrasil7d.cmbInstruPJKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (Key = #8) Then
    cmbInstruPJ.itemIndex := -1;
end;


end.
