unit untConfigItau;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, DirectoryEditFocus, StdCtrls, EditFocus, Buttons,
  ExtCtrls, QColorLabel, Menus, ComCtrls, ShellApi, Uni, AppEvnts, ComboBoxFocus,
  BitBtnLockedIncrem, untTypesSistema, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, StrUtils, cxTextEdit, cxMaskEdit, cxButtonEdit,
  dxScreenTip, cxClasses, dxCustomHint, cxHint, dxBarBuiltInMenu, cxGroupBox,
  cxPC, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  Data.DB, cxDBData, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox, Datasnap.DBClient,
  System.Generics.Collections, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog, 
  untFrameDirectoryEditFocus, untFramePlanoDeContasMaskEdit,MaskEditFocus,
  untFrameGerarPixBoleto;

type
  TfrmConfigItau = class(TfrmPai)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
    HintControler: TcxHintStyleController;
    btnCancelar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    BtnManual: TBitBtnLocked;
    BtnOcorrencia: TBitBtnLocked;
    cxPaginas: TcxPageControl;
    tbsGeral: TcxTabSheet;
    tbsEncBan: TcxTabSheet;
    pnlAtivo1: TPanel;
    Label5: TLabel;
    lblCodAgenc: TLabel;
    lblCodCart: TLabel;
    lblContCorr: TLabel;
    lblDiasProt: TLabel;
    lblIdentBanco: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    lblProNum: TLabel;
    lblResp: TLabel;
    ColorLabel1: TColorLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    ColorLabel3: TColorLabel;
    Label14: TLabel;
    ColorLabel4: TColorLabel;
    Label15: TLabel;
    lblMulta: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    Label16: TLabel;
    Label6: TLabel;
    lblCartSeq: TLabel;
    edtResp: TEditFocus;
    edtDiasProt: TEditFocus;
    edtContaCorr: TEditFocus;
    edtCodAgencia: TEditFocus;
    edtIdentBanc: TEditFocus;
    edtCodCar: TEditFocus;
    edtProxNumArqRem: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtObservacao5: TEditFocus;
    edtExpCgc: TEditFocus;
    edtDiasCred: TEditFocus;
    edtProAce: TEditFocus;
    edtPerMul: TEditFocus;
    cmbTipDia: TComboBoxFocus;
    edtInfAdi: TEditFocus;
    edtCodFsh: TEditFocus;
    fraPathRemessaITAU: TfraDirectoryEditFocus;
    fraPathRetornoITAU: TfraDirectoryEditFocus;
    cmbNumCart: TComboBoxFocus;
    cmbInstrucao1: TComboBoxFocus;
    cmbInstrucao2: TComboBoxFocus;
    edtDiasMora: TEditFocus;
    chkCartSeq: TCheckBox;
    edtCartSeq: TEditFocus;
    edtDigCtaCor: TEditFocus;
    pnlAtivo2: TPanel;
    grpTarAux: TcxGroupBox;
    edtMandMsg: TEditFocus;
    ColorLabel6: TColorLabel;
    Label19: TLabel;
    grpTarLiq: TcxGroupBox;
    Label7: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    edtDesPorTar: TEditFocus;
    edtPorTar: TEditFocus;
    edtValorTarifa: TEditFocus;
    edtDesForTar: TEditFocus;
    edtForTar: TEditFocus;
    grdTarifasDBTableView1: TcxGridDBTableView;
    grdTarifasLevel1: TcxGridLevel;
    grdTarifas: TcxGrid;
    grdTarifasDBTableView1CNF_CODOCO: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_DESOCO: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_GERPAG: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_FORNEC: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_PLNCON: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_PORTAD: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    btnAddOco: TBitBtnLocked;
    btnRemOco: TBitBtnLocked;
    cxStyle2: TcxStyle;
    btnEdtOco: TBitBtnLocked;
    Label22: TLabel;
    cdsCnfOco: TUniClientDataSet;
    cdsCnfOcoCNF_CODOCO: TStringField;
    cdsCnfOcoCNF_DESOCO: TStringField;
    cdsCnfOcoCNF_GERPAG: TBooleanField;
    cdsCnfOcoCNF_FORNEC: TStringField;
    cdsCnfOcoCNF_PORTAD: TStringField;
    cdsCnfOcoCNF_PLNCON: TStringField;
    dsCnfOco: TDataSource;
    cdsCnfOcoCNF_CUSCAR: TBooleanField;
    grdTarifasDBTableView1CNF_CUSCAR: TcxGridDBColumn;
    Label23: TLabel;
    edtCodLiq: TEditFocus;
    ColorLabel2: TColorLabel;
    cdsCnfOcoCNF_TIPDES: TIntegerField;
    cdsCnfOcoCNF_DSTPDS: TStringField;
    grdTarifasDBTableView1CNF_DSTPDS: TcxGridDBColumn;
    Label24: TLabel;
    edtPorDes: TEditFocus;
    edtDesPorDes: TEditFocus;
    grdTarifasDBTableView1CNF_USADIA: TcxGridDBColumn;
    cdsCnfOcoCNF_USADIA: TBooleanField;
    Label25: TLabel;
    cmbDataCompTaxa: TComboBoxFocus;
    Label26: TLabel;
    edtUtilizarPortadorDescontada: TEditFocus;
    ColorLabel5: TColorLabel;
    Label27: TLabel;
    edtEmpBol: TEditFocus;
    edtDesEmpresa: TEditFocus;
    chkOb5Des: TCheckBox;
    fraPlanoDeContasEnc: TfraPlanoDeContasMskEdit;
    fraPlanoDeContasBai: TfraPlanoDeContasMskEdit;
    tbsComplemento: TcxTabSheet;
    pnlComplemento: TPanel;
    Label35: TLabel;
    ColorLabel7: TColorLabel;
    grpBeneficiario: TGroupBox;
    lblDesCrr: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    edtDesBen: TEditFocus;
    edtEndBen: TEditFocus;
    edtCompBen: TEditFocus;
    edtBaiBen: TEditFocus;
    edtCidBen: TEditFocus;
    edtEstBen: TEditFocus;
    edtCepBen: TMaskEditFocus;
    edtCgcBen: TMaskEditFocus;
    edtUsaSac: TEditFocus;
    Label2: TLabel;
    edtConsDtArqRet: TEditFocus;
    ColorLabel8: TColorLabel;
    Label36: TLabel;
    cmbInstruPersonalizada: TComboBoxFocus;
    cmbCodigoMulta: TComboBoxFocus;
    Label17: TLabel;
    edtCodPorRem: TEditFocus;
    edtDescPorRem: TEditFocus;
    lblAtualizarOcorrencias: TLabel;
    edtAtualizarOcorrencias: TEditFocus;
    lblAtualizarOcorrenciasSN: TColorLabel;
    lblTraOco47Ant: TLabel;
    edtTraOco47Ant: TEditFocus;
    clbSimNaoOco47: TColorLabel;
    ColorLabel9: TColorLabel;
    Label37: TLabel;
    edtEnvCaracEsp: TEditFocus;
    gbInstrucao: TGroupBox;
    lblInstPessoaFisica: TLabel;
    lblPessoaJuridica: TLabel;
    lblQtdDiasProtestoPF: TLabel;
    lblQtdDiasProtestoPJ: TLabel;
    cmbInstruPF: TComboBoxFocus;
    cmbInstruPJ: TComboBoxFocus;
    edtDiasProtestoPF: TEditFocus;
    edtDiasProtestoPJ: TEditFocus;
    cmbTipDiaPF: TComboBoxFocus;
    cmbTipDiaPJ: TComboBoxFocus;
    clDetalheMulta: TColorLabel;
    lblDetalheMulta: TLabel;
    edtDetalheMulta: TEditFocus;
    pnlChavePIX: TPanel;
    fraGerarPixBoleto: TfraGerarPixBoleto;
    lblPerImpBol: TLabel;
    edtPerImpBol: TEditFocus;
    clbPerImpBol: TColorLabel;
    lblParcelasNegritoCarne: TLabel;
    edtParcelasNegritoCarne: TEditFocus;
    clParcelasNegritoCarne: TColorLabel;
    lblEntregueBanco: TLabel;
    edtEntregueBanco: TEditFocus;
    ColorLabel10: TColorLabel;
    procedure pCarregaDados;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pCarregaCentroCusto(strCtaBai: String; edtLabel: TEdit);
    procedure tabCarteiraChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure BtnManualClick(Sender: TObject);
    procedure edtDiasCredEnter(Sender: TObject);
    procedure edtDiasCredExit(Sender: TObject);
    procedure btnConfigurarEnter(Sender: TObject);
    procedure btnConfigurarExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtCodFshEnter(Sender: TObject);
    procedure edtCodFshExit(Sender: TObject);
    procedure cmbNumCartChange(Sender: TObject);
    procedure BtnOcorrenciaEnter(Sender: TObject);
    procedure BtnOcorrenciaExit(Sender: TObject);
    procedure BtnOcorrenciaClick(Sender: TObject);
    procedure chkCartSeqClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtPorTarKeyPress(Sender: TObject; var Key: Char);
    procedure edtForTarKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorTarifaExit(Sender: TObject);
    procedure edtMandMsgEnter(Sender: TObject);
    procedure edtMandMsgExit(Sender: TObject);
    procedure btnAddOcoClick(Sender: TObject);
    procedure btnEdtOcoClick(Sender: TObject);
    procedure btnRemOcoClick(Sender: TObject);
    procedure grdTarifasDBTableView1DblClick(Sender: TObject);
    procedure edtCodLiqEnter(Sender: TObject);
    procedure edtCodLiqExit(Sender: TObject);
    procedure edtPorDesEnter(Sender: TObject);
    procedure edtPorDesExit(Sender: TObject);
    procedure edtPorDesKeyPress(Sender: TObject; var Key: Char);
    procedure edtUtilizarPortadorDescontadaEnter(Sender: TObject);
    procedure edtUtilizarPortadorDescontadaExit(Sender: TObject);
    procedure ApplicationEventsDeactivate(Sender: TObject);
    procedure edtEmpBolKeyPress(Sender: TObject; var Key: Char);
    procedure chkOb5DesClick(Sender: TObject);
    procedure chkOb5DesEnter(Sender: TObject);
    procedure chkOb5DesExit(Sender: TObject);
    procedure fraPlanoDeContasEncMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasBaiMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure edtUsaSacExit(Sender: TObject);
    procedure edtConsDtArqRetEnter(Sender: TObject);
    procedure edtConsDtArqRetExit(Sender: TObject);
    procedure cmbCodigoMultaChange(Sender: TObject);
    procedure edtCodPorRemKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCodigoMultaEnter(Sender: TObject);
    procedure cmbCodigoMultaExit(Sender: TObject);
    procedure cmbInstruPFKeyPress(Sender: TObject; var Key: Char);
    procedure cmbInstruPJKeyPress(Sender: TObject; var Key: Char);
    procedure cmbInstruPFChange(Sender: TObject);
    procedure cmbInstruPJChange(Sender: TObject);
    procedure edtEntregueBancoExit(Sender: TObject);
    procedure edtEntregueBancoEnter(Sender: TObject);

  private
    { Private declarations }
    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;
    qryCadFor : TUniQuery;
    qryCadEmp : TUniQuery;

    blnVirtualUI: Boolean;

    procedure pShowHint(edtEdit: TEditFocus; strTitulo: String);
    procedure pShowHintBotao(btnBotao: TBitBtnLocked; strTitulo: String);
    procedure pHideHint;
    procedure pLimpaCampos;
    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
    procedure pCarregaOcorrencias;
    procedure pCarregaEmpresa(strCodEmp: String; edtLabel: TEdit);
    function RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;
    procedure DefineDescricaoTipoMulta;

  public
    { Public declarations }
    blnNaoEditar: Boolean;
    strConfig   : String;
    strOcoTar   : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigItau: TfrmConfigItau;

implementation

uses  untPesqAux, untCfgGenericas_AutBan, untConsultas, untFuncoesSimples,
  untMemo, untFuncoes, untCadOcoCartei, untCNFOCO_Class, untCNFOCO_Dao,
  VirtualUI_SDK;

{$R *.dfm}

procedure TfrmConfigItau.pCarregaDados;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************AF*}
  //Limpando Valores Carregados;
  pLimpaCampos;

  If fEmptyStr(fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '')) Then
  Begin
    edtProxNumArqRem.Enabled  := True;
    edtProxNumArqRem.Clear;
    pSetFocus(edtProxNumArqRem);
  End
  Else
  Begin
    edtProxNumArqRem.Text  := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '');
    edtProxNumArqRem.Enabled := False;
    pSetFocus(cmbNumCart);
  End;

  if (strLoginUsuarioLogado='997') or(strLoginUsuarioLogado='998') or (strLoginUsuarioLogado='999') Then
  begin
    edtProxNumArqRem.Enabled := True;
    pSetFocus(edtProxNumArqRem);
  End;

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', '')) Of
      102: cmbNumCart.ItemIndex := 0;
      101: cmbNumCart.ItemIndex := 1;
      104: cmbNumCart.ItemIndex := 2;
      107: cmbNumCart.ItemIndex := 3;
      108: cmbNumCart.ItemIndex := 4;
      109: cmbNumCart.ItemIndex := 5;
      112: cmbNumCart.ItemIndex := 6;
      115: cmbNumCart.ItemIndex := 7;
      121: cmbNumCart.ItemIndex := 8;
      129: cmbNumCart.ItemIndex := 9;
      139: cmbNumCart.ItemIndex := 10;
      142: cmbNumCart.ItemIndex := 11;
      143: cmbNumCart.ItemIndex := 12;
      147: cmbNumCart.ItemIndex := 13;
      150: cmbNumCart.ItemIndex := 14;
      169: cmbNumCart.ItemIndex := 15;
      172: cmbNumCart.ItemIndex := 16;
      173: cmbNumCart.ItemIndex := 17;
      174: cmbNumCart.ItemIndex := 18;
      175: cmbNumCart.ItemIndex := 19;
      177: cmbNumCart.ItemIndex := 20;
      180: cmbNumCart.ItemIndex := 21;
      188: cmbNumCart.ItemIndex := 22;
      198: cmbNumCart.ItemIndex := 23;
      352: cmbNumCart.ItemIndex := 24;
      354: cmbNumCart.ItemIndex := 25;
      358: cmbNumCart.ItemIndex := 26;
      359: cmbNumCart.ItemIndex := 27;
      364: cmbNumCart.ItemIndex := 28;
      365: cmbNumCart.ItemIndex := 29;
      458: cmbNumCart.ItemIndex := 30;
      459: cmbNumCart.ItemIndex := 31;
    End;
  End
  Else
    cmbNumCart.ItemIndex := -1;

  Try
    Case StrToInt(fGetBancoConfig(0,'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1),'CODIGOMULTA', '')) Of
      1: cmbCodigoMulta.ItemIndex := 1;
      2: cmbCodigoMulta.ItemIndex := 2;
      Else cmbCodigoMulta.ItemIndex := 0;
    End;
  except
    cmbCodigoMulta.ItemIndex := 0;
  end;

  edtDesPor.Text := '';
  edtDescPorRem.Text := '';

  fraPlanoDeContasBai.edtDesCta.Text := '';

  edtCodCar.Text         := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', '');
  edtIdentBanc.Text      := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', '');
  edtCodAgencia.Text     := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtContaCorr.Text      := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', '');
  edtDigCtaCor.Text      := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', '');
  edtCodPor.Text         := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  edtCodPorRem.Text      := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');
  fraPlanoDeContasBai.MskCodCta.Text := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');
  edtDiasProt.Text       := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '');
  edtDiasProtestoPF.Text    := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAS_PROTESTO_PF', '');
  edtDiasProtestoPj.Text    := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAS_PROTESTO_PJ', '');
  edtDiasMora.Text       := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAMORA', '');
  edtResp.Text           := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', '');
  edtMandMsg.Text        := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVDUPAG', 'N');
  edtConsDtArqRet.Text   := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'CONDTRET', 'N');
  edtTraOco47Ant.Text    := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'TRAOC47A', 'N');
  edtPorDes.Text         := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTDES', '');
  edtUtilizarPortadorDescontada.Text := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PORDESPORBAI', 'N');
  edtEmpBol.Text         := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'EMPRBOL', '');

  If fEmptyStr(edtMandMsg.Text) then
    edtMandMsg.Text := 'S';

  edtEnvCaracEsp.Text   := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVCESP', '');

  If fEmptyStr(edtEnvCaracEsp.Text) Then
    edtEnvCaracEsp.Text := 'S';

  If fEmptyStr(edtConsDtArqRet.Text) then
    edtConsDtArqRet.Text := 'N';

  If fEmptyStr(edtTraOco47Ant.Text) Then
    edtTraOco47Ant.Text := 'N';

  If fEmptyStr(edtDiasMora.Text) then
    edtDiasMora.Text := '1';

  If Not fEmptyStr( edtEmpBol.Text ) Then
    pCarregaEmpresa(edtEmpBol.Text, edtDesEmpresa);

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '')) Of
      00: cmbInstrucao1.ItemIndex := 0;  // AUSÊNCIA DE INSTRUÇÕES
      02: cmbInstrucao1.ItemIndex := 1;  // DEVOLVER APÓS 05 DIAS DO VENCIMENTO
      03: cmbInstrucao1.ItemIndex := 2;  // DEVOLVER APÓS 30 DIAS DO VENCIMENTO
      05: cmbInstrucao1.ItemIndex := 3;  // RECEBER CONFORME INSTRUÇÕES NO PRÓPRIO TÍTULO
      06: cmbInstrucao1.ItemIndex := 4;  // DEVOLVER APÓS 10 DIAS DO VENCIMENTO
      07: cmbInstrucao1.ItemIndex := 5;  // DEVOLVER APÓS 15 DIAS DO VENCIMENTO
      08: cmbInstrucao1.ItemIndex := 6;  // DEVOLVER APÓS 20 DIAS DO VENCIMENTO
      09: cmbInstrucao1.ItemIndex := 7;  // PROTESTAR (emite aviso ao sacado após XX dias do vencimento, e envia ao cartório após 5 dias úteis)
      10: cmbInstrucao1.ItemIndex := 8;  // NÃO PROTESTAR (inibe protesto, quando houver instrução permanente na conta corrente)
      11: cmbInstrucao1.ItemIndex := 9;  // DEVOLVER APÓS 25 DIAS DO VENCIMENTO
      12: cmbInstrucao1.ItemIndex := 10; // DEVOLVER APÓS 35 DIAS DO VENCIMENTO
      13: cmbInstrucao1.ItemIndex := 11; // DEVOLVER APÓS 40 DIAS DO VENCIMENTO
      14: cmbInstrucao1.ItemIndex := 12; // DEVOLVER APÓS 45 DIAS DO VENCIMENTO
      15: cmbInstrucao1.ItemIndex := 13; // DEVOLVER APÓS 50 DIAS DO VENCIMENTO
      16: cmbInstrucao1.ItemIndex := 14; // DEVOLVER APÓS 55 DIAS DO VENCIMENTO
      17: cmbInstrucao1.ItemIndex := 15; // DEVOLVER APÓS 60 DIAS DO VENCIMENTO
      18: cmbInstrucao1.ItemIndex := 16; // DEVOLVER APÓS 90 DIAS DO VENCIMENTO
      19: cmbInstrucao1.ItemIndex := 17; // NÃO RECEBER APÓS 05 DIAS DO VENCIMENTO
      20: cmbInstrucao1.ItemIndex := 18; // NÃO RECEBER APÓS 10 DIAS DO VENCIMENTO
      21: cmbInstrucao1.ItemIndex := 19; // NÃO RECEBER APÓS 15 DIAS DO VENCIMENTO
      22: cmbInstrucao1.ItemIndex := 20; // NÃO RECEBER APÓS 20 DIAS DO VENCIMENTO
      23: cmbInstrucao1.ItemIndex := 21; // NÃO RECEBER APÓS 25 DIAS DO VENCIMENTO
      24: cmbInstrucao1.ItemIndex := 22; // NÃO RECEBER APÓS 30 DIAS DO VENCIMENTO
      25: cmbInstrucao1.ItemIndex := 23; // NÃO RECEBER APÓS 35 DIAS DO VENCIMENTO
      26: cmbInstrucao1.ItemIndex := 24; // NÃO RECEBER APÓS 40 DIAS DO VENCIMENTO
      27: cmbInstrucao1.ItemIndex := 25; // NÃO RECEBER APÓS 45 DIAS DO VENCIMENTO
      28: cmbInstrucao1.ItemIndex := 26; // NÃO RECEBER APÓS 50 DIAS DO VENCIMENTO
      29: cmbInstrucao1.ItemIndex := 27; // NÃO RECEBER APÓS 55 DIAS DO VENCIMENTO E
      30: cmbInstrucao1.ItemIndex := 28; // IMPORTÂNCIA DE DESCONTO POR DIA
      31: cmbInstrucao1.ItemIndex := 29; // NÃO RECEBER APÓS 60 DIAS DO VENCIMENTO
      32: cmbInstrucao1.ItemIndex := 30; // NÃO RECEBER APÓS 90 DIAS DO VENCIMENTO
      33: cmbInstrucao1.ItemIndex := 31; // CONCEDER ABATIMENTO REF. À PIS-PASEP/COFIN/CSSL, MESMO APÓS VENCIMENTO
      34: cmbInstrucao1.ItemIndex := 32; // PROTESTAR APÓS XX DIAS CORRIDOS DO VENCIMENTO
      35: cmbInstrucao1.ItemIndex := 33; // PROTESTAR APÓS XX DIAS ÚTEIS DO VENCIMENTO
      37: cmbInstrucao1.ItemIndex := 34; // RECEBER ATÉ O ÚLTIMO DIA DO MÊS DE VENCIMENTO
      38: cmbInstrucao1.ItemIndex := 35; // CONCEDER DESCONTO MESMO APÓS VENCIMENTO
      39: cmbInstrucao1.ItemIndex := 36; // NÃO RECEBER APÓS O VENCIMENTO
      40: cmbInstrucao1.ItemIndex := 37; // CONCEDER DESCONTO CONFORME NOTA DE CRÉDITO A
      42: cmbInstrucao1.ItemIndex := 38; // PROTESTO PARA FINS FALIMENTARES
      43: cmbInstrucao1.ItemIndex := 39; // SUJEITO A PROTESTO SE NÃO FOR PAGO NO VENCIMENTO F
      44: cmbInstrucao1.ItemIndex := 40; // IMPORTÂNCIA POR DIA DE ATRASO A PARTIR DE DDMMAA
      45: cmbInstrucao1.ItemIndex := 41; // TEM DIA DA GRAÇA
      47: cmbInstrucao1.ItemIndex := 42; // DISPENSAR JUROS/COMISSÃO DE PERMANÊNCIA
      51: cmbInstrucao1.ItemIndex := 43; // RECEBER SOMENTE COM A PARCELA ANTERIOR QUITADA
      52: cmbInstrucao1.ItemIndex := 44; // EFETUAR O PAGAMENTO SOMENTE ATRAVÉS DESTE BOLETO E NA REDE BANCÁRIA
      54: cmbInstrucao1.ItemIndex := 45; // APÓS VENCIMENTO PAGÁVEL SOMENTE NA EMPRESA
      57: cmbInstrucao1.ItemIndex := 46; // SOMAR VALOR DO TÍTULO AO VALOR DO CAMPO MORA/MULTA CASO EXISTA
      58: cmbInstrucao1.ItemIndex := 47; // DEVOLVER APÓS 365 DIAS DE VENCIDO
      59: cmbInstrucao1.ItemIndex := 48; // COBRANÇA NEGOCIADA. PAGÁVEL SOMENTE POR ESTE BOLETO NA REDE BANCÁRIA
      61: cmbInstrucao1.ItemIndex := 49; // TÍTULO ENTREGUE EM PENHOR EM FAVOR DO CEDENTE ACIMA
      62: cmbInstrucao1.ItemIndex := 50; // TÍTULO TRANSFERIDO A FAVOR DO CEDENTE
      66: cmbInstrucao1.ItemIndex := 51; // ENTRADA EM NEGATIVAÇÃO EXPRESSA (IMPRIME: SUJEITO A NEGATIVAÇÃO APÓS O VENCIMENTO)
      67: cmbInstrucao1.ItemIndex := 52; // NÃO NEGATIVAR (INIBE A ENTRADA EM NEGATIVAÇÃO EXPRESSA)
      78: cmbInstrucao1.ItemIndex := 53; // VALOR DA IDA ENGLOBA MULTA DE 10% PRO RATA
      79: cmbInstrucao1.ItemIndex := 54; // COBRAR JUROS APÓS 15 DIAS DA EMISSÃO (para títulos com vencimento à vista)
      80: cmbInstrucao1.ItemIndex := 55; // PAGAMENTO EM CHEQUE: SOMENTE RECEBER COM CHEQUE DE EMISSÃO DO SACADO
      81: cmbInstrucao1.ItemIndex := 56; // PROTESTAR APÓS XX DIAS CORRIDOS DO VENCIMENTO
      82: cmbInstrucao1.ItemIndex := 57; // PROTESTAR APÓS XX DIAS ÚTEIS DO VENCIMENTO
      83: cmbInstrucao1.ItemIndex := 58; // OPERAÇÃO REF A VENDOR
      84: cmbInstrucao1.ItemIndex := 59; // APÓS VENCIMENTO CONSULTAR A AGÊNCIA CEDENTE
      86: cmbInstrucao1.ItemIndex := 60; // ANTES DO VENCIMENTO OU APÓS 15 DIAS, PAGÁVEL SOMENTE EM NOSSA SEDE
      88: cmbInstrucao1.ItemIndex := 61; // NÃO RECEBER ANTES DO VENCIMENTO
      90: cmbInstrucao1.ItemIndex := 62; // NO VENCIMENTO PAGÁVEL EM QUALQUER AGÊNCIA BANCÁRIA
      91: cmbInstrucao1.ItemIndex := 63; // NÃO RECEBER APÓS XX DIAS DO VENCIMENTO A
      92: cmbInstrucao1.ItemIndex := 64; // DEVOLVER APÓS XX DIAS DO VENCIMENTO
      93: cmbInstrucao1.ItemIndex := 65; // MENSAGENS NOS BOLETOS COM 30 POSIÇÕES
      94: cmbInstrucao1.ItemIndex := 66; // MENSAGENS NOS BOLETOS COM 40 POSIÇÕES
      98: cmbInstrucao1.ItemIndex := 67; // DUPLICATA / FATURA Nº
    End;
  End
  Else
    cmbInstrucao1.ItemIndex := -1;

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', '')) Of
      00: cmbInstrucao2.ItemIndex := 0;  // AUSÊNCIA DE INSTRUÇÕES
      02: cmbInstrucao2.ItemIndex := 1;  // DEVOLVER APÓS 05 DIAS DO VENCIMENTO
      03: cmbInstrucao2.ItemIndex := 2;  // DEVOLVER APÓS 30 DIAS DO VENCIMENTO
      05: cmbInstrucao2.ItemIndex := 3;  // RECEBER CONFORME INSTRUÇÕES NO PRÓPRIO TÍTULO
      06: cmbInstrucao2.ItemIndex := 4;  // DEVOLVER APÓS 10 DIAS DO VENCIMENTO
      07: cmbInstrucao2.ItemIndex := 5;  // DEVOLVER APÓS 15 DIAS DO VENCIMENTO
      08: cmbInstrucao2.ItemIndex := 6;  // DEVOLVER APÓS 20 DIAS DO VENCIMENTO
      09: cmbInstrucao2.ItemIndex := 7;  // PROTESTAR (emite aviso ao sacado após XX dias do vencimento, e envia ao cartório após 5 dias úteis)
      10: cmbInstrucao2.ItemIndex := 8;  // NÃO PROTESTAR (inibe protesto, quando houver instrução permanente na conta corrente)
      11: cmbInstrucao2.ItemIndex := 9;  // DEVOLVER APÓS 25 DIAS DO VENCIMENTO
      12: cmbInstrucao2.ItemIndex := 10; // DEVOLVER APÓS 35 DIAS DO VENCIMENTO
      13: cmbInstrucao2.ItemIndex := 11; // DEVOLVER APÓS 40 DIAS DO VENCIMENTO
      14: cmbInstrucao2.ItemIndex := 12; // DEVOLVER APÓS 45 DIAS DO VENCIMENTO
      15: cmbInstrucao2.ItemIndex := 13; // DEVOLVER APÓS 50 DIAS DO VENCIMENTO
      16: cmbInstrucao2.ItemIndex := 14; // DEVOLVER APÓS 55 DIAS DO VENCIMENTO
      17: cmbInstrucao2.ItemIndex := 15; // DEVOLVER APÓS 60 DIAS DO VENCIMENTO
      18: cmbInstrucao2.ItemIndex := 16; // DEVOLVER APÓS 90 DIAS DO VENCIMENTO
      19: cmbInstrucao2.ItemIndex := 17; // NÃO RECEBER APÓS 05 DIAS DO VENCIMENTO
      20: cmbInstrucao2.ItemIndex := 18; // NÃO RECEBER APÓS 10 DIAS DO VENCIMENTO
      21: cmbInstrucao2.ItemIndex := 19; // NÃO RECEBER APÓS 15 DIAS DO VENCIMENTO
      22: cmbInstrucao2.ItemIndex := 20; // NÃO RECEBER APÓS 20 DIAS DO VENCIMENTO
      23: cmbInstrucao2.ItemIndex := 21; // NÃO RECEBER APÓS 25 DIAS DO VENCIMENTO
      24: cmbInstrucao2.ItemIndex := 22; // NÃO RECEBER APÓS 30 DIAS DO VENCIMENTO
      25: cmbInstrucao2.ItemIndex := 23; // NÃO RECEBER APÓS 35 DIAS DO VENCIMENTO
      26: cmbInstrucao2.ItemIndex := 24; // NÃO RECEBER APÓS 40 DIAS DO VENCIMENTO
      27: cmbInstrucao2.ItemIndex := 25; // NÃO RECEBER APÓS 45 DIAS DO VENCIMENTO
      28: cmbInstrucao2.ItemIndex := 26; // NÃO RECEBER APÓS 50 DIAS DO VENCIMENTO
      29: cmbInstrucao2.ItemIndex := 27; // NÃO RECEBER APÓS 55 DIAS DO VENCIMENTO E
      30: cmbInstrucao2.ItemIndex := 28; // IMPORTÂNCIA DE DESCONTO POR DIA
      31: cmbInstrucao2.ItemIndex := 29; // NÃO RECEBER APÓS 60 DIAS DO VENCIMENTO
      32: cmbInstrucao2.ItemIndex := 30; // NÃO RECEBER APÓS 90 DIAS DO VENCIMENTO
      33: cmbInstrucao2.ItemIndex := 31; // CONCEDER ABATIMENTO REF. À PIS-PASEP/COFIN/CSSL, MESMO APÓS VENCIMENTO
      34: cmbInstrucao2.ItemIndex := 32; // PROTESTAR APÓS XX DIAS CORRIDOS DO VENCIMENTO
      35: cmbInstrucao2.ItemIndex := 33; // PROTESTAR APÓS XX DIAS ÚTEIS DO VENCIMENTO
      37: cmbInstrucao2.ItemIndex := 34; // RECEBER ATÉ O ÚLTIMO DIA DO MÊS DE VENCIMENTO
      38: cmbInstrucao2.ItemIndex := 35; // CONCEDER DESCONTO MESMO APÓS VENCIMENTO
      39: cmbInstrucao2.ItemIndex := 36; // NÃO RECEBER APÓS O VENCIMENTO
      40: cmbInstrucao2.ItemIndex := 37; // CONCEDER DESCONTO CONFORME NOTA DE CRÉDITO A
      42: cmbInstrucao2.ItemIndex := 38; // PROTESTO PARA FINS FALIMENTARES
      43: cmbInstrucao2.ItemIndex := 39; // SUJEITO A PROTESTO SE NÃO FOR PAGO NO VENCIMENTO F
      44: cmbInstrucao2.ItemIndex := 40; // IMPORTÂNCIA POR DIA DE ATRASO A PARTIR DE DDMMAA
      45: cmbInstrucao2.ItemIndex := 41; // TEM DIA DA GRAÇA
      47: cmbInstrucao2.ItemIndex := 42; // DISPENSAR JUROS/COMISSÃO DE PERMANÊNCIA
      51: cmbInstrucao2.ItemIndex := 43; // RECEBER SOMENTE COM A PARCELA ANTERIOR QUITADA
      52: cmbInstrucao2.ItemIndex := 44; // EFETUAR O PAGAMENTO SOMENTE ATRAVÉS DESTE BOLETO E NA REDE BANCÁRIA
      54: cmbInstrucao2.ItemIndex := 45; // APÓS VENCIMENTO PAGÁVEL SOMENTE NA EMPRESA
      57: cmbInstrucao2.ItemIndex := 46; // SOMAR VALOR DO TÍTULO AO VALOR DO CAMPO MORA/MULTA CASO EXISTA
      58: cmbInstrucao2.ItemIndex := 47; // DEVOLVER APÓS 365 DIAS DE VENCIDO
      59: cmbInstrucao2.ItemIndex := 48; // COBRANÇA NEGOCIADA. PAGÁVEL SOMENTE POR ESTE BOLETO NA REDE BANCÁRIA
      61: cmbInstrucao2.ItemIndex := 49; // TÍTULO ENTREGUE EM PENHOR EM FAVOR DO CEDENTE ACIMA
      62: cmbInstrucao2.ItemIndex := 50; // TÍTULO TRANSFERIDO A FAVOR DO CEDENTE
      66: cmbInstrucao2.ItemIndex := 51; // ENTRADA EM NEGATIVAÇÃO EXPRESSA (IMPRIME: SUJEITO A NEGATIVAÇÃO APÓS O VENCIMENTO)
      67: cmbInstrucao2.ItemIndex := 52; // NÃO NEGATIVAR (INIBE A ENTRADA EM NEGATIVAÇÃO EXPRESSA)
      78: cmbInstrucao2.ItemIndex := 53; // VALOR DA IDA ENGLOBA MULTA DE 10% PRO RATA
      79: cmbInstrucao2.ItemIndex := 54; // COBRAR JUROS APÓS 15 DIAS DA EMISSÃO (para títulos com vencimento à vista)
      80: cmbInstrucao2.ItemIndex := 55; // PAGAMENTO EM CHEQUE: SOMENTE RECEBER COM CHEQUE DE EMISSÃO DO SACADO
      81: cmbInstrucao2.ItemIndex := 56; // PROTESTAR APÓS XX DIAS CORRIDOS DO VENCIMENTO
      82: cmbInstrucao2.ItemIndex := 57; // PROTESTAR APÓS XX DIAS ÚTEIS DO VENCIMENTO
      83: cmbInstrucao2.ItemIndex := 58; // OPERAÇÃO REF A VENDOR
      84: cmbInstrucao2.ItemIndex := 59; // APÓS VENCIMENTO CONSULTAR A AGÊNCIA CEDENTE
      86: cmbInstrucao2.ItemIndex := 60; // ANTES DO VENCIMENTO OU APÓS 15 DIAS, PAGÁVEL SOMENTE EM NOSSA SEDE
      88: cmbInstrucao2.ItemIndex := 61; // NÃO RECEBER ANTES DO VENCIMENTO
      90: cmbInstrucao2.ItemIndex := 62; // NO VENCIMENTO PAGÁVEL EM QUALQUER AGÊNCIA BANCÁRIA
      91: cmbInstrucao2.ItemIndex := 63; // NÃO RECEBER APÓS XX DIAS DO VENCIMENTO A
      92: cmbInstrucao2.ItemIndex := 64; // DEVOLVER APÓS XX DIAS DO VENCIMENTO
      93: cmbInstrucao2.ItemIndex := 65; // MENSAGENS NOS BOLETOS COM 30 POSIÇÕES
      94: cmbInstrucao2.ItemIndex := 66; // MENSAGENS NOS BOLETOS COM 40 POSIÇÕES
      98: cmbInstrucao2.ItemIndex := 67; // DUPLICATA / FATURA Nº
    End;
  End
  Else
    cmbInstrucao2.ItemIndex := -1;

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTPER', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTPER', '')) Of
      00: cmbInstruPersonalizada.ItemIndex := 0;  // AUSÊNCIA DE INSTRUÇÕES
      02: cmbInstruPersonalizada.ItemIndex := 1;  // DEVOLVER APÓS 05 DIAS DO VENCIMENTO
      03: cmbInstruPersonalizada.ItemIndex := 2;  // DEVOLVER APÓS 30 DIAS DO VENCIMENTO
      05: cmbInstruPersonalizada.ItemIndex := 3;  // RECEBER CONFORME INSTRUÇÕES NO PRÓPRIO TÍTULO
      06: cmbInstruPersonalizada.ItemIndex := 4;  // DEVOLVER APÓS 10 DIAS DO VENCIMENTO
      07: cmbInstruPersonalizada.ItemIndex := 5;  // DEVOLVER APÓS 15 DIAS DO VENCIMENTO
      08: cmbInstruPersonalizada.ItemIndex := 6;  // DEVOLVER APÓS 20 DIAS DO VENCIMENTO
      09: cmbInstruPersonalizada.ItemIndex := 7;  // PROTESTAR (emite aviso ao sacado após XX dias do vencimento, e envia ao cartório após 5 dias úteis)
      10: cmbInstruPersonalizada.ItemIndex := 8;  // NÃO PROTESTAR (inibe protesto, quando houver instrução permanente na conta corrente)
      11: cmbInstruPersonalizada.ItemIndex := 9;  // DEVOLVER APÓS 25 DIAS DO VENCIMENTO
      12: cmbInstruPersonalizada.ItemIndex := 10; // DEVOLVER APÓS 35 DIAS DO VENCIMENTO
      13: cmbInstruPersonalizada.ItemIndex := 11; // DEVOLVER APÓS 40 DIAS DO VENCIMENTO
      14: cmbInstruPersonalizada.ItemIndex := 12; // DEVOLVER APÓS 45 DIAS DO VENCIMENTO
      15: cmbInstruPersonalizada.ItemIndex := 13; // DEVOLVER APÓS 50 DIAS DO VENCIMENTO
      16: cmbInstruPersonalizada.ItemIndex := 14; // DEVOLVER APÓS 55 DIAS DO VENCIMENTO
      17: cmbInstruPersonalizada.ItemIndex := 15; // DEVOLVER APÓS 60 DIAS DO VENCIMENTO
      18: cmbInstruPersonalizada.ItemIndex := 16; // DEVOLVER APÓS 90 DIAS DO VENCIMENTO
      19: cmbInstruPersonalizada.ItemIndex := 17; // NÃO RECEBER APÓS 05 DIAS DO VENCIMENTO
      20: cmbInstruPersonalizada.ItemIndex := 18; // NÃO RECEBER APÓS 10 DIAS DO VENCIMENTO
      21: cmbInstruPersonalizada.ItemIndex := 19; // NÃO RECEBER APÓS 15 DIAS DO VENCIMENTO
      22: cmbInstruPersonalizada.ItemIndex := 20; // NÃO RECEBER APÓS 20 DIAS DO VENCIMENTO
      23: cmbInstruPersonalizada.ItemIndex := 21; // NÃO RECEBER APÓS 25 DIAS DO VENCIMENTO
      24: cmbInstruPersonalizada.ItemIndex := 22; // NÃO RECEBER APÓS 30 DIAS DO VENCIMENTO
      25: cmbInstruPersonalizada.ItemIndex := 23; // NÃO RECEBER APÓS 35 DIAS DO VENCIMENTO
      26: cmbInstruPersonalizada.ItemIndex := 24; // NÃO RECEBER APÓS 40 DIAS DO VENCIMENTO
      27: cmbInstruPersonalizada.ItemIndex := 25; // NÃO RECEBER APÓS 45 DIAS DO VENCIMENTO
      28: cmbInstruPersonalizada.ItemIndex := 26; // NÃO RECEBER APÓS 50 DIAS DO VENCIMENTO
      29: cmbInstruPersonalizada.ItemIndex := 27; // NÃO RECEBER APÓS 55 DIAS DO VENCIMENTO E
      30: cmbInstruPersonalizada.ItemIndex := 28; // IMPORTÂNCIA DE DESCONTO POR DIA
      31: cmbInstruPersonalizada.ItemIndex := 29; // NÃO RECEBER APÓS 60 DIAS DO VENCIMENTO
      32: cmbInstruPersonalizada.ItemIndex := 30; // NÃO RECEBER APÓS 90 DIAS DO VENCIMENTO
      33: cmbInstruPersonalizada.ItemIndex := 31; // CONCEDER ABATIMENTO REF. À PIS-PASEP/COFIN/CSSL, MESMO APÓS VENCIMENTO
      34: cmbInstruPersonalizada.ItemIndex := 32; // PROTESTAR APÓS XX DIAS CORRIDOS DO VENCIMENTO
      35: cmbInstruPersonalizada.ItemIndex := 33; // PROTESTAR APÓS XX DIAS ÚTEIS DO VENCIMENTO
      37: cmbInstruPersonalizada.ItemIndex := 34; // RECEBER ATÉ O ÚLTIMO DIA DO MÊS DE VENCIMENTO
      38: cmbInstruPersonalizada.ItemIndex := 35; // CONCEDER DESCONTO MESMO APÓS VENCIMENTO
      39: cmbInstruPersonalizada.ItemIndex := 36; // NÃO RECEBER APÓS O VENCIMENTO
      40: cmbInstruPersonalizada.ItemIndex := 37; // CONCEDER DESCONTO CONFORME NOTA DE CRÉDITO A
      42: cmbInstruPersonalizada.ItemIndex := 38; // PROTESTO PARA FINS FALIMENTARES
      43: cmbInstruPersonalizada.ItemIndex := 39; // SUJEITO A PROTESTO SE NÃO FOR PAGO NO VENCIMENTO F
      44: cmbInstruPersonalizada.ItemIndex := 40; // IMPORTÂNCIA POR DIA DE ATRASO A PARTIR DE DDMMAA
      45: cmbInstruPersonalizada.ItemIndex := 41; // TEM DIA DA GRAÇA
      47: cmbInstruPersonalizada.ItemIndex := 42; // DISPENSAR JUROS/COMISSÃO DE PERMANÊNCIA
      51: cmbInstruPersonalizada.ItemIndex := 43; // RECEBER SOMENTE COM A PARCELA ANTERIOR QUITADA
      52: cmbInstruPersonalizada.ItemIndex := 44; // EFETUAR O PAGAMENTO SOMENTE ATRAVÉS DESTE BOLETO E NA REDE BANCÁRIA
      54: cmbInstruPersonalizada.ItemIndex := 45; // APÓS VENCIMENTO PAGÁVEL SOMENTE NA EMPRESA
      57: cmbInstruPersonalizada.ItemIndex := 46; // SOMAR VALOR DO TÍTULO AO VALOR DO CAMPO MORA/MULTA CASO EXISTA
      58: cmbInstruPersonalizada.ItemIndex := 47; // DEVOLVER APÓS 365 DIAS DE VENCIDO
      59: cmbInstruPersonalizada.ItemIndex := 48; // COBRANÇA NEGOCIADA. PAGÁVEL SOMENTE POR ESTE BOLETO NA REDE BANCÁRIA
      61: cmbInstruPersonalizada.ItemIndex := 49; // TÍTULO ENTREGUE EM PENHOR EM FAVOR DO CEDENTE ACIMA
      62: cmbInstruPersonalizada.ItemIndex := 50; // TÍTULO TRANSFERIDO A FAVOR DO CEDENTE
      66: cmbInstruPersonalizada.ItemIndex := 51; // ENTRADA EM NEGATIVAÇÃO EXPRESSA (IMPRIME: SUJEITO A NEGATIVAÇÃO APÓS O VENCIMENTO)
      67: cmbInstruPersonalizada.ItemIndex := 52; // NÃO NEGATIVAR (INIBE A ENTRADA EM NEGATIVAÇÃO EXPRESSA)
      78: cmbInstruPersonalizada.ItemIndex := 53; // VALOR DA IDA ENGLOBA MULTA DE 10% PRO RATA
      79: cmbInstruPersonalizada.ItemIndex := 54; // COBRAR JUROS APÓS 15 DIAS DA EMISSÃO (para títulos com vencimento à vista)
      80: cmbInstruPersonalizada.ItemIndex := 55; // PAGAMENTO EM CHEQUE: SOMENTE RECEBER COM CHEQUE DE EMISSÃO DO SACADO
      81: cmbInstruPersonalizada.ItemIndex := 56; // PROTESTAR APÓS XX DIAS CORRIDOS DO VENCIMENTO
      82: cmbInstruPersonalizada.ItemIndex := 57; // PROTESTAR APÓS XX DIAS ÚTEIS DO VENCIMENTO
      83: cmbInstruPersonalizada.ItemIndex := 58; // OPERAÇÃO REF A VENDOR
      84: cmbInstruPersonalizada.ItemIndex := 59; // APÓS VENCIMENTO CONSULTAR A AGÊNCIA CEDENTE
      86: cmbInstruPersonalizada.ItemIndex := 60; // ANTES DO VENCIMENTO OU APÓS 15 DIAS, PAGÁVEL SOMENTE EM NOSSA SEDE
      88: cmbInstruPersonalizada.ItemIndex := 61; // NÃO RECEBER ANTES DO VENCIMENTO
      90: cmbInstruPersonalizada.ItemIndex := 62; // NO VENCIMENTO PAGÁVEL EM QUALQUER AGÊNCIA BANCÁRIA
      91: cmbInstruPersonalizada.ItemIndex := 63; // NÃO RECEBER APÓS XX DIAS DO VENCIMENTO A
      92: cmbInstruPersonalizada.ItemIndex := 64; // DEVOLVER APÓS XX DIAS DO VENCIMENTO
      93: cmbInstruPersonalizada.ItemIndex := 65; // MENSAGENS NOS BOLETOS COM 30 POSIÇÕES
      94: cmbInstruPersonalizada.ItemIndex := 66; // MENSAGENS NOS BOLETOS COM 40 POSIÇÕES
      98: cmbInstruPersonalizada.ItemIndex := 67; // DUPLICATA / FATURA Nº
    End;
  End
  Else
    cmbInstruPersonalizada.ItemIndex := -1;

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRUCAO_PF', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRUCAO_PF', '')) Of
      00: cmbInstruPF.ItemIndex := 0;  // AUSÊNCIA DE INSTRUÇÕES
      02: cmbInstruPF.ItemIndex := 1;  // DEVOLVER APÓS 05 DIAS DO VENCIMENTO
      03: cmbInstruPF.ItemIndex := 2;  // DEVOLVER APÓS 30 DIAS DO VENCIMENTO
      05: cmbInstruPF.ItemIndex := 3;  // RECEBER CONFORME INSTRUÇÕES NO PRÓPRIO TÍTULO
      06: cmbInstruPF.ItemIndex := 4;  // DEVOLVER APÓS 10 DIAS DO VENCIMENTO
      07: cmbInstruPF.ItemIndex := 5;  // DEVOLVER APÓS 15 DIAS DO VENCIMENTO
      08: cmbInstruPF.ItemIndex := 6;  // DEVOLVER APÓS 20 DIAS DO VENCIMENTO
      09: cmbInstruPF.ItemIndex := 7;  // PROTESTAR (emite aviso ao sacado após XX dias do vencimento, e envia ao cartório após 5 dias úteis)
      10: cmbInstruPF.ItemIndex := 8;  // NÃO PROTESTAR (inibe protesto, quando houver instrução permanente na conta corrente)
      11: cmbInstruPF.ItemIndex := 9;  // DEVOLVER APÓS 25 DIAS DO VENCIMENTO
      12: cmbInstruPF.ItemIndex := 10; // DEVOLVER APÓS 35 DIAS DO VENCIMENTO
      13: cmbInstruPF.ItemIndex := 11; // DEVOLVER APÓS 40 DIAS DO VENCIMENTO
      14: cmbInstruPF.ItemIndex := 12; // DEVOLVER APÓS 45 DIAS DO VENCIMENTO
      15: cmbInstruPF.ItemIndex := 13; // DEVOLVER APÓS 50 DIAS DO VENCIMENTO
      16: cmbInstruPF.ItemIndex := 14; // DEVOLVER APÓS 55 DIAS DO VENCIMENTO
      17: cmbInstruPF.ItemIndex := 15; // DEVOLVER APÓS 60 DIAS DO VENCIMENTO
      18: cmbInstruPF.ItemIndex := 16; // DEVOLVER APÓS 90 DIAS DO VENCIMENTO
      19: cmbInstruPF.ItemIndex := 17; // NÃO RECEBER APÓS 05 DIAS DO VENCIMENTO
      20: cmbInstruPF.ItemIndex := 18; // NÃO RECEBER APÓS 10 DIAS DO VENCIMENTO
      21: cmbInstruPF.ItemIndex := 19; // NÃO RECEBER APÓS 15 DIAS DO VENCIMENTO
      22: cmbInstruPF.ItemIndex := 20; // NÃO RECEBER APÓS 20 DIAS DO VENCIMENTO
      23: cmbInstruPF.ItemIndex := 21; // NÃO RECEBER APÓS 25 DIAS DO VENCIMENTO
      24: cmbInstruPF.ItemIndex := 22; // NÃO RECEBER APÓS 30 DIAS DO VENCIMENTO
      25: cmbInstruPF.ItemIndex := 23; // NÃO RECEBER APÓS 35 DIAS DO VENCIMENTO
      26: cmbInstruPF.ItemIndex := 24; // NÃO RECEBER APÓS 40 DIAS DO VENCIMENTO
      27: cmbInstruPF.ItemIndex := 25; // NÃO RECEBER APÓS 45 DIAS DO VENCIMENTO
      28: cmbInstruPF.ItemIndex := 26; // NÃO RECEBER APÓS 50 DIAS DO VENCIMENTO
      29: cmbInstruPF.ItemIndex := 27; // NÃO RECEBER APÓS 55 DIAS DO VENCIMENTO E
      30: cmbInstruPF.ItemIndex := 28; // IMPORTÂNCIA DE DESCONTO POR DIA
      31: cmbInstruPF.ItemIndex := 29; // NÃO RECEBER APÓS 60 DIAS DO VENCIMENTO
      32: cmbInstruPF.ItemIndex := 30; // NÃO RECEBER APÓS 90 DIAS DO VENCIMENTO
      33: cmbInstruPF.ItemIndex := 31; // CONCEDER ABATIMENTO REF. À PIS-PASEP/COFIN/CSSL, MESMO APÓS VENCIMENTO
      34: cmbInstruPF.ItemIndex := 32; // PROTESTAR APÓS XX DIAS CORRIDOS DO VENCIMENTO
      35: cmbInstruPF.ItemIndex := 33; // PROTESTAR APÓS XX DIAS ÚTEIS DO VENCIMENTO
      37: cmbInstruPF.ItemIndex := 34; // RECEBER ATÉ O ÚLTIMO DIA DO MÊS DE VENCIMENTO
      38: cmbInstruPF.ItemIndex := 35; // CONCEDER DESCONTO MESMO APÓS VENCIMENTO
      39: cmbInstruPF.ItemIndex := 36; // NÃO RECEBER APÓS O VENCIMENTO
      40: cmbInstruPF.ItemIndex := 37; // CONCEDER DESCONTO CONFORME NOTA DE CRÉDITO A
      42: cmbInstruPF.ItemIndex := 38; // PROTESTO PARA FINS FALIMENTARES
      43: cmbInstruPF.ItemIndex := 39; // SUJEITO A PROTESTO SE NÃO FOR PAGO NO VENCIMENTO F
      44: cmbInstruPF.ItemIndex := 40; // IMPORTÂNCIA POR DIA DE ATRASO A PARTIR DE DDMMAA
      45: cmbInstruPF.ItemIndex := 41; // TEM DIA DA GRAÇA
      47: cmbInstruPF.ItemIndex := 42; // DISPENSAR JUROS/COMISSÃO DE PERMANÊNCIA
      51: cmbInstruPF.ItemIndex := 43; // RECEBER SOMENTE COM A PARCELA ANTERIOR QUITADA
      52: cmbInstruPF.ItemIndex := 44; // EFETUAR O PAGAMENTO SOMENTE ATRAVÉS DESTE BOLETO E NA REDE BANCÁRIA
      54: cmbInstruPF.ItemIndex := 45; // APÓS VENCIMENTO PAGÁVEL SOMENTE NA EMPRESA
      57: cmbInstruPF.ItemIndex := 46; // SOMAR VALOR DO TÍTULO AO VALOR DO CAMPO MORA/MULTA CASO EXISTA
      58: cmbInstruPF.ItemIndex := 47; // DEVOLVER APÓS 365 DIAS DE VENCIDO
      59: cmbInstruPF.ItemIndex := 48; // COBRANÇA NEGOCIADA. PAGÁVEL SOMENTE POR ESTE BOLETO NA REDE BANCÁRIA
      61: cmbInstruPF.ItemIndex := 49; // TÍTULO ENTREGUE EM PENHOR EM FAVOR DO CEDENTE ACIMA
      62: cmbInstruPF.ItemIndex := 50; // TÍTULO TRANSFERIDO A FAVOR DO CEDENTE
      66: cmbInstruPF.ItemIndex := 51; // ENTRADA EM NEGATIVAÇÃO EXPRESSA (IMPRIME: SUJEITO A NEGATIVAÇÃO APÓS O VENCIMENTO)
      67: cmbInstruPF.ItemIndex := 52; // NÃO NEGATIVAR (INIBE A ENTRADA EM NEGATIVAÇÃO EXPRESSA)
      78: cmbInstruPF.ItemIndex := 53; // VALOR DA IDA ENGLOBA MULTA DE 10% PRO RATA
      79: cmbInstruPF.ItemIndex := 54; // COBRAR JUROS APÓS 15 DIAS DA EMISSÃO (para títulos com vencimento à vista)
      80: cmbInstruPF.ItemIndex := 55; // PAGAMENTO EM CHEQUE: SOMENTE RECEBER COM CHEQUE DE EMISSÃO DO SACADO
      81: cmbInstruPF.ItemIndex := 56; // PROTESTAR APÓS XX DIAS CORRIDOS DO VENCIMENTO
      82: cmbInstruPF.ItemIndex := 57; // PROTESTAR APÓS XX DIAS ÚTEIS DO VENCIMENTO
      83: cmbInstruPF.ItemIndex := 58; // OPERAÇÃO REF A VENDOR
      84: cmbInstruPF.ItemIndex := 59; // APÓS VENCIMENTO CONSULTAR A AGÊNCIA CEDENTE
      86: cmbInstruPF.ItemIndex := 60; // ANTES DO VENCIMENTO OU APÓS 15 DIAS, PAGÁVEL SOMENTE EM NOSSA SEDE
      88: cmbInstruPF.ItemIndex := 61; // NÃO RECEBER ANTES DO VENCIMENTO
      90: cmbInstruPF.ItemIndex := 62; // NO VENCIMENTO PAGÁVEL EM QUALQUER AGÊNCIA BANCÁRIA
      91: cmbInstruPF.ItemIndex := 63; // NÃO RECEBER APÓS XX DIAS DO VENCIMENTO A
      92: cmbInstruPF.ItemIndex := 64; // DEVOLVER APÓS XX DIAS DO VENCIMENTO
      93: cmbInstruPF.ItemIndex := 65; // MENSAGENS NOS BOLETOS COM 30 POSIÇÕES
      94: cmbInstruPF.ItemIndex := 66; // MENSAGENS NOS BOLETOS COM 40 POSIÇÕES
      98: cmbInstruPF.ItemIndex := 67; // DUPLICATA / FATURA Nº
    End;
  End
  Else
    cmbInstruPF.ItemIndex := -1;

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRUCAO_PJ', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRUCAO_PJ', '')) Of
      00: cmbInstruPJ.ItemIndex := 0;  // AUSÊNCIA DE INSTRUÇÕES
      02: cmbInstruPJ.ItemIndex := 1;  // DEVOLVER APÓS 05 DIAS DO VENCIMENTO
      03: cmbInstruPJ.ItemIndex := 2;  // DEVOLVER APÓS 30 DIAS DO VENCIMENTO
      05: cmbInstruPJ.ItemIndex := 3;  // RECEBER CONFORME INSTRUÇÕES NO PRÓPRIO TÍTULO
      06: cmbInstruPJ.ItemIndex := 4;  // DEVOLVER APÓS 10 DIAS DO VENCIMENTO
      07: cmbInstruPJ.ItemIndex := 5;  // DEVOLVER APÓS 15 DIAS DO VENCIMENTO
      08: cmbInstruPJ.ItemIndex := 6;  // DEVOLVER APÓS 20 DIAS DO VENCIMENTO
      09: cmbInstruPJ.ItemIndex := 7;  // PROTESTAR (emite aviso ao sacado após XX dias do vencimento, e envia ao cartório após 5 dias úteis)
      10: cmbInstruPJ.ItemIndex := 8;  // NÃO PROTESTAR (inibe protesto, quando houver instrução permanente na conta corrente)
      11: cmbInstruPJ.ItemIndex := 9;  // DEVOLVER APÓS 25 DIAS DO VENCIMENTO
      12: cmbInstruPJ.ItemIndex := 10; // DEVOLVER APÓS 35 DIAS DO VENCIMENTO
      13: cmbInstruPJ.ItemIndex := 11; // DEVOLVER APÓS 40 DIAS DO VENCIMENTO
      14: cmbInstruPJ.ItemIndex := 12; // DEVOLVER APÓS 45 DIAS DO VENCIMENTO
      15: cmbInstruPJ.ItemIndex := 13; // DEVOLVER APÓS 50 DIAS DO VENCIMENTO
      16: cmbInstruPJ.ItemIndex := 14; // DEVOLVER APÓS 55 DIAS DO VENCIMENTO
      17: cmbInstruPJ.ItemIndex := 15; // DEVOLVER APÓS 60 DIAS DO VENCIMENTO
      18: cmbInstruPJ.ItemIndex := 16; // DEVOLVER APÓS 90 DIAS DO VENCIMENTO
      19: cmbInstruPJ.ItemIndex := 17; // NÃO RECEBER APÓS 05 DIAS DO VENCIMENTO
      20: cmbInstruPJ.ItemIndex := 18; // NÃO RECEBER APÓS 10 DIAS DO VENCIMENTO
      21: cmbInstruPJ.ItemIndex := 19; // NÃO RECEBER APÓS 15 DIAS DO VENCIMENTO
      22: cmbInstruPJ.ItemIndex := 20; // NÃO RECEBER APÓS 20 DIAS DO VENCIMENTO
      23: cmbInstruPJ.ItemIndex := 21; // NÃO RECEBER APÓS 25 DIAS DO VENCIMENTO
      24: cmbInstruPJ.ItemIndex := 22; // NÃO RECEBER APÓS 30 DIAS DO VENCIMENTO
      25: cmbInstruPJ.ItemIndex := 23; // NÃO RECEBER APÓS 35 DIAS DO VENCIMENTO
      26: cmbInstruPJ.ItemIndex := 24; // NÃO RECEBER APÓS 40 DIAS DO VENCIMENTO
      27: cmbInstruPJ.ItemIndex := 25; // NÃO RECEBER APÓS 45 DIAS DO VENCIMENTO
      28: cmbInstruPJ.ItemIndex := 26; // NÃO RECEBER APÓS 50 DIAS DO VENCIMENTO
      29: cmbInstruPJ.ItemIndex := 27; // NÃO RECEBER APÓS 55 DIAS DO VENCIMENTO E
      30: cmbInstruPJ.ItemIndex := 28; // IMPORTÂNCIA DE DESCONTO POR DIA
      31: cmbInstruPJ.ItemIndex := 29; // NÃO RECEBER APÓS 60 DIAS DO VENCIMENTO
      32: cmbInstruPJ.ItemIndex := 30; // NÃO RECEBER APÓS 90 DIAS DO VENCIMENTO
      33: cmbInstruPJ.ItemIndex := 31; // CONCEDER ABATIMENTO REF. À PIS-PASEP/COFIN/CSSL, MESMO APÓS VENCIMENTO
      34: cmbInstruPJ.ItemIndex := 32; // PROTESTAR APÓS XX DIAS CORRIDOS DO VENCIMENTO
      35: cmbInstruPJ.ItemIndex := 33; // PROTESTAR APÓS XX DIAS ÚTEIS DO VENCIMENTO
      37: cmbInstruPJ.ItemIndex := 34; // RECEBER ATÉ O ÚLTIMO DIA DO MÊS DE VENCIMENTO
      38: cmbInstruPJ.ItemIndex := 35; // CONCEDER DESCONTO MESMO APÓS VENCIMENTO
      39: cmbInstruPJ.ItemIndex := 36; // NÃO RECEBER APÓS O VENCIMENTO
      40: cmbInstruPJ.ItemIndex := 37; // CONCEDER DESCONTO CONFORME NOTA DE CRÉDITO A
      42: cmbInstruPJ.ItemIndex := 38; // PROTESTO PARA FINS FALIMENTARES
      43: cmbInstruPJ.ItemIndex := 39; // SUJEITO A PROTESTO SE NÃO FOR PAGO NO VENCIMENTO F
      44: cmbInstruPJ.ItemIndex := 40; // IMPORTÂNCIA POR DIA DE ATRASO A PARTIR DE DDMMAA
      45: cmbInstruPJ.ItemIndex := 41; // TEM DIA DA GRAÇA
      47: cmbInstruPJ.ItemIndex := 42; // DISPENSAR JUROS/COMISSÃO DE PERMANÊNCIA
      51: cmbInstruPJ.ItemIndex := 43; // RECEBER SOMENTE COM A PARCELA ANTERIOR QUITADA
      52: cmbInstruPJ.ItemIndex := 44; // EFETUAR O PAGAMENTO SOMENTE ATRAVÉS DESTE BOLETO E NA REDE BANCÁRIA
      54: cmbInstruPJ.ItemIndex := 45; // APÓS VENCIMENTO PAGÁVEL SOMENTE NA EMPRESA
      57: cmbInstruPJ.ItemIndex := 46; // SOMAR VALOR DO TÍTULO AO VALOR DO CAMPO MORA/MULTA CASO EXISTA
      58: cmbInstruPJ.ItemIndex := 47; // DEVOLVER APÓS 365 DIAS DE VENCIDO
      59: cmbInstruPJ.ItemIndex := 48; // COBRANÇA NEGOCIADA. PAGÁVEL SOMENTE POR ESTE BOLETO NA REDE BANCÁRIA
      61: cmbInstruPJ.ItemIndex := 49; // TÍTULO ENTREGUE EM PENHOR EM FAVOR DO CEDENTE ACIMA
      62: cmbInstruPJ.ItemIndex := 50; // TÍTULO TRANSFERIDO A FAVOR DO CEDENTE
      66: cmbInstruPJ.ItemIndex := 51; // ENTRADA EM NEGATIVAÇÃO EXPRESSA (IMPRIME: SUJEITO A NEGATIVAÇÃO APÓS O VENCIMENTO)
      67: cmbInstruPJ.ItemIndex := 52; // NÃO NEGATIVAR (INIBE A ENTRADA EM NEGATIVAÇÃO EXPRESSA)
      78: cmbInstruPJ.ItemIndex := 53; // VALOR DA IDA ENGLOBA MULTA DE 10% PRO RATA
      79: cmbInstruPJ.ItemIndex := 54; // COBRAR JUROS APÓS 15 DIAS DA EMISSÃO (para títulos com vencimento à vista)
      80: cmbInstruPJ.ItemIndex := 55; // PAGAMENTO EM CHEQUE: SOMENTE RECEBER COM CHEQUE DE EMISSÃO DO SACADO
      81: cmbInstruPJ.ItemIndex := 56; // PROTESTAR APÓS XX DIAS CORRIDOS DO VENCIMENTO
      82: cmbInstruPJ.ItemIndex := 57; // PROTESTAR APÓS XX DIAS ÚTEIS DO VENCIMENTO
      83: cmbInstruPJ.ItemIndex := 58; // OPERAÇÃO REF A VENDOR
      84: cmbInstruPJ.ItemIndex := 59; // APÓS VENCIMENTO CONSULTAR A AGÊNCIA CEDENTE
      86: cmbInstruPJ.ItemIndex := 60; // ANTES DO VENCIMENTO OU APÓS 15 DIAS, PAGÁVEL SOMENTE EM NOSSA SEDE
      88: cmbInstruPJ.ItemIndex := 61; // NÃO RECEBER ANTES DO VENCIMENTO
      90: cmbInstruPJ.ItemIndex := 62; // NO VENCIMENTO PAGÁVEL EM QUALQUER AGÊNCIA BANCÁRIA
      91: cmbInstruPJ.ItemIndex := 63; // NÃO RECEBER APÓS XX DIAS DO VENCIMENTO A
      92: cmbInstruPJ.ItemIndex := 64; // DEVOLVER APÓS XX DIAS DO VENCIMENTO
      93: cmbInstruPJ.ItemIndex := 65; // MENSAGENS NOS BOLETOS COM 30 POSIÇÕES
      94: cmbInstruPJ.ItemIndex := 66; // MENSAGENS NOS BOLETOS COM 40 POSIÇÕES
      98: cmbInstruPJ.ItemIndex := 67; // DUPLICATA / FATURA Nº
    End;
  End
  Else
    cmbInstruPJ.ItemIndex := -1;

  edtDesPor.Text := '';
  edtDescPorRem.Text := '';
  fraPlanoDeContasBai.edtDesCta.Text := '';

  edtObservacao1.Text    := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text    := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text    := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text    := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text    := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');
  chkOb5Des.Checked      := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSV5DE', '') = 'S';

  fraPathRemessaITAU.edtDirectory.text:= fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '');
  fraPathRetornoITAU.edtDirectory.text:= fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '');
  edtExpCgc.Text         := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPCNPJ', '');
  edtDiasCred.Text       := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', '');
  edtProAce.Text         := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', '');

  edtPerMul.Text         := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', '');
  edtInfAdi.Text         := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', '');

  edtCodFsh.Text         := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'CDFLASH', '');
  chkCartSeq.Checked     := (fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', '') = 'S');
  edtCartSeq.Text        := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', '');
  edtPorTar.Text         := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', '');
  fraPlanoDeContasEnc.MskCodCta.Text := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', '');
  edtForTar.Text         := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', '');
  edtValorTarifa.Text    := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', '');
  edtCodLiq.Text         := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'CODLIQU', 'N');
  edtEntregueBanco.Text  := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'ENTREGUEBANCOEMAIL', 'N');
  If fEmptyStr(edtEntregueBanco.Text) Then
    edtEntregueBanco.Text := 'N';

  edtAtualizarOcorrencias.Text := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'ATUALIZA_DESPCOB', 'N');
  If fEmptyStr(edtAtualizarOcorrencias.Text) Then
    edtAtualizarOcorrencias.Text := 'N';

  edtDetalheMulta.Text := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'DETALHEMULTA', 'N');
  If fEmptyStr(edtDetalheMulta.Text) Then
    edtDetalheMulta.Text := 'S';

  edtPerImpBol.Text     := fGetBancoConfig(0,'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', '');
  If fEmptyStr(edtPerImpBol.Text) Then
    edtPerImpBol.Text := 'S';

  edtParcelasNegritoCarne.Text := fGetBancoConfig(0,'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PARCELASNEGRITOCARNE', '');
  If fEmptyStr(edtParcelasNegritoCarne.Text) Then
    edtParcelasNegritoCarne.Text := 'N';

  //Dados Beneficiário
  edtUsaSac.Text        := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', '');
  edtUsaSac.Text        := IIF(fEmptyStr(edtUsaSac.Text), 'N', edtUsaSac.Text);
  edtDesBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', ''), '');
  edtEndBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', ''), '');
  edtBaiBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', ''), '');
  edtCompBen.Text       := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', ''), '');
  edtCidBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', ''), '');
  edtEstBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', ''), '');
  edtCepBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', ''), '');
  edtCgcBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', ''), '');

  fValidaCampos(edtUsaSac);

  If Not fEmptyStr(fGetBancoConfig(0,'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1),'DTCOMTA', '2')) Then
    cmbDataCompTaxa.ItemIndex    := StrToInt(fGetBancoConfig(0,'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1),'DTCOMTA', '2'))-1
  Else
    cmbDataCompTaxa.ItemIndex    := -1;

  chkCartSeq.OnClick(chkCartSeq);
  chkOb5Des.OnClick(chkOb5Des);

  If Not fEmptyStr(fGetBancoConfig(0,'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1),'TIPDIA', '1')) Then
    cmbTipDia.ItemIndex    := StrToInt(fGetBancoConfig(0,'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1),'TIPDIA', '1'))-1
  Else
    cmbTipDia.ItemIndex    := -1;

  If Not fEmptyStr(fGetBancoConfig(0,'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1),'TIPDIA_PF', '1')) Then
    cmbTipDiaPF.ItemIndex    := StrToInt(fGetBancoConfig(0,'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1),'TIPDIA_PF', '1'))-1
  Else
    cmbTipDiaPF.ItemIndex    := -1;

  If Not fEmptyStr(fGetBancoConfig(0,'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1),'TIPDIA_PJ', '1')) Then
    cmbTipDiaPJ.ItemIndex    := StrToInt(fGetBancoConfig(0,'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1),'TIPDIA_PJ', '1'))-1
  Else
    cmbTipDiaPJ.ItemIndex    := -1;

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCodPorRem.Text ) Then
    pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);

  pCarregaCentroCusto(fraPlanoDeContasBai.MskCodCta.Text, fraPlanoDeContasBai.edtDesCta);

  If Not fEmptyStr( edtPorTar.Text ) Then pCarregaPortador(edtPorTar.Text, edtDesPorTar);
  If Not fEmptyStr( fraPlanoDeContasEnc.MskCodCta.Text ) Then pCarregaCentroCusto(fraPlanoDeContasEnc.MskCodCta.Text, fraPlanoDeContasEnc.edtDesCta);

  If Not fEmptyStr( edtForTar.Text ) Then
  begin
    pPesquisaCadFor(qryCadFor, qryCadFor, edtForTar.Text);
    edtDesForTar.Text  := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
  end;

  fraGerarPixBoleto.edtGerarPix.Text := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'GERAPIX', 'N');
  If fEmptyStr(fraGerarPixBoleto.edtGerarPix.Text) Then
    fraGerarPixBoleto.edtGerarPix.Text := 'N';
  fraGerarPixBoleto.cmbChavePix.EditValue :=  fGetBancoConfig(0, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'CHAPIX', '');
  fraGerarPixBoleto.cmbChavePix.Enabled := False;

  pCarregaOcorrencias;

  pCarregaPortador(edtPorDes.Text, edtDesPorDes);

end;

procedure TfrmConfigItau.pCarregaEmpresa(strCodEmp: String; edtLabel: TEdit);
begin
  pPesquisaCadEmp(Nil, qryCadEmp, strCodEmp);
  With qryCadEmp Do
  Begin
    edtLabel.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmConfigItau.pCarregaOcorrencias;
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

  pDesmembraCarteira('CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp, strCodBco,
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
        cdsCnfOcoCNF_GERPAG.Value    := objCnfOco.blnGerpag;
        cdsCnfOcoCNF_CUSCAR.Value    := objCnfOco.blnCusCar;
        cdsCnfOcoCNF_UsaDia.Value    := objCnfOco.blnUsaDia;
        cdsCnfOcoCNF_FORNEC.AsString := objCnfOco.strCodFor + ' - ' + fRetNomFornecedor(objCnfOco.strCodFor);
        cdsCnfOcoCNF_PORTAD.AsString := objCnfOco.strCodPor + ' - ' + fRetNomPortador(objCnfOco.strCodPor);
        cdsCnfOcoCNF_PLNCON.AsString := objCnfOco.strCodCta + ' - ' + fRetDescCentroCusto(objCnfOco.strCodCta);
        cdsCnfOcoCNF_TIPDES.AsInteger:= objCnfOco.IntTipDes;
        Case objCnfOco.IntTipDes of
          0: cdsCnfOcoCNF_DSTPDS.AsString := 'OUTRAS TARIFAS';
          1: cdsCnfOcoCNF_DSTPDS.AsString := 'TARIFA IOF DESCONTO';
          2: cdsCnfOcoCNF_DSTPDS.AsString := 'TARIFA BOLETO DESC';
          3: cdsCnfOcoCNF_DSTPDS.AsString := 'TARIFA DESCONTADA';
          4: cdsCnfOcoCNF_DSTPDS.AsString := 'JUROS OPERAÇÃO';
          5: cdsCnfOcoCNF_DSTPDS.AsString := 'EST. DESCONTADA';
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

procedure TfrmConfigItau.FormShow(Sender: TObject);
begin
  inherited;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  fraGerarPixBoleto.CarregarChavesPix('341');

  pCarregaDados;

  If edtProxNumArqRem.Enabled Then
    pSetFocus(edtProxNumArqRem)
  Else
    pSetFocus(edtCodAgencia);

  pnlAtivo1.Enabled := False;
  pnlAtivo2.Enabled := False;
  pnlComplemento.Enabled := pnlAtivo1.Enabled;

  pSetFocus(btnEditar);

  if blnNaoEditar then
  begin
    btnConfigurar.Enabled := False;
    btnConfigurar.Visible := False;
    btnGravar.Enabled     := True;
    btnEditar.Visible     := False;
    pSetFocus(btnGravar);
  end;

  blnVirtualUI := VirtualUI.Active;

  fraPathRetornoITAU.Visible := Not blnVirtualUI;
  lblPathArquivosRet.Visible := Not blnVirtualUI;
  If blnVirtualUI Then
    lblPathArquivosRem.Caption := 'Path temporário para Remessa:';

  DefineDescricaoTipoMulta;
end;

procedure TfrmConfigItau.btnConfigurarEnter(Sender: TObject);
begin
  inherited;
  btnConfigurar.Hint := 'Configurar percentual de ' + #13+#10 +
                        'juros para remessa.';
  pShowHintBotao(btnConfigurar, 'Cofigurações específicas.');
end;

procedure TfrmConfigItau.btnConfigurarExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigItau.btnEditarClick(Sender: TObject);
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

    if tbsEncBan.tabVisible then
      pnlAtivo2.Enabled := True;

    btnGravar.Enabled := True;
    btnConfigurar.Enabled := True;
    btnEditar.Visible := False;
    btnCancelar.Visible := true;

    if edtProxNumArqRem.Enabled then
      pSetFocus(edtProxNumArqRem)
    else
      pSetFocus(edtCodAgencia);

    If Not fCfgSis('USAPIX', VarBoolean) Then
      fraGerarPixBoleto.edtGerarPix.Text := 'N';

    fraGerarPixBoleto.edtGerarPix.OnChange(fraGerarPixBoleto.edtGerarPix);
  end;

end;

procedure TfrmConfigItau.btnEdtOcoClick(Sender: TObject);
Var
  intRecNo_: Integer;
begin
  inherited;
  intRecNo_ := 0;
  If Not cdsCnfOco.isEmpty Then
  Begin
    intRecNo_ := cdsCnfOco.RecNo;
    frmCadOcoCartei                     := TfrmCadOcoCartei.Create(nil);
    frmCadOcoCartei.strCartei           := 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp;
    frmCadOcoCartei.blnEditar           := True;
    frmCadOcoCartei.edtCodOco.Text      := cdsCnfOcoCNF_CODOCO.AsString;
    frmCadOcoCartei.fraPlanoDeContasOco.MskCodCta.Text := Copy(cdsCnfOcoCNF_PLNCON.AsString,1,7);
    frmCadOcoCartei.cmbTipDes.ItemIndex := cdsCnfOcoCNF_TIPDES.AsInteger;

    frmCadOcoCartei.cmbTipDes.Visible := cdsCnfOcoCNF_CODOCO.AsString = '02';
    frmCadOcoCartei.lblTipDes.Visible := cdsCnfOcoCNF_CODOCO.AsString = '02';

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

procedure TfrmConfigItau.btnGravarClick(Sender: TObject);
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

    If (chkCartSeq.Checked) Then
    Begin
      If edtProxNumArqRem.Text <> fRetProxNumAutBan('CONFIG341-' + edtCartSeq.Text) Then
      Begin
        If fMensagem('ATENÇÃO','Ao utilizar a sequência do arquivo de remessa de outra carteira, o campo Último Núm. de Seq. Arq. Remessa será sobrescrito pelo da carteira principal. Deseja continuar?',['&SIM', '&NÃO'], 1) = 2 Then
          Exit;
      End;
    End;

    Try
      stlCfgAnt := TStringList.Create;
      pCarregaCfg(stlCfgAnt);

      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', IIF(chkCartSeq.Checked, fRetProxNumAutBan('CONFIG341-' + edtCartSeq.Text), edtProxNumArqRem.Text));
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', LeftStr(cmbNumCart.Text, 3));
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', edtCodCar.Text       );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', edtIdentBanc.Text    );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text   );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text    );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', edtDigCtaCor.Text    );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text       );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text       );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContasBai.MskCodCta.Text);
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text     );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAS_PROTESTO_PF', edtDiasProtestoPF.Text );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAS_PROTESTO_PJ', edtDiasProtestoPj.Text );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAMORA', edtDiasMora.Text     );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text         );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', LeftStr(cmbInstrucao1.Text,2));
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', LeftStr(cmbInstrucao2.Text,2));
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTPER', LeftStr(cmbInstruPersonalizada.Text,2));
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRUCAO_PF', LeftStr(cmbInstruPF.Text,2));
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRUCAO_PJ', LeftStr(cmbInstruPJ.Text,2));

      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text);
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text);
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text);
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text);
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text);
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSV5DE', IIF(chkOb5Des.Checked, 'S', 'N'));


      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessaITAU.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetornoITAU.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPCNPJ', edtExpCgc.Text         );

      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text     );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text       );

      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'ATUALIZA_DESPCOB', edtAtualizarOcorrencias.Text);
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'DETALHEMULTA', edtDetalheMulta.Text);

      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', edtPerMul.Text       );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text       );

      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'CDFLASH', edtCodFsh.Text       );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVDUPAG', edtMandMsg.Text      );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'CONDTRET', edtConsDtArqRet.Text );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'TRAOC47A', edtTraOco47Ant.Text  );

      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPDIA' , IntToStr(cmbTipDia.ItemIndex+1));
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPDIA_PF' , IntToStr(cmbTipDiaPF.ItemIndex+1));
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPDIA_PJ' , IntToStr(cmbTipDiaPJ.ItemIndex+1));
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', IIF(chkCartSeq.Checked, 'S', 'N'));
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', IIF(chkCartSeq.Checked, edtCartSeq.Text, ''));
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', edtPorTar.Text    );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', fraPlanoDeContasEnc.MskCodCta.Text);
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', edtForTar.Text    );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', edtValorTarifa.Text  );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'CODLIQU', edtCodLiq.Text  );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTDES', edtPorDes.Text    );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'DTCOMTA' , IntToStr(cmbDataCompTaxa.ItemIndex+1));
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PORDESPORBAI', edtUtilizarPortadorDescontada.Text    );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'EMPRBOL', edtEmpBol.Text  );

      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'CODIGOMULTA', IntToStr(cmbCodigoMulta.ItemIndex));
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', edtPerImpBol.Text       );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'PARCELASNEGRITOCARNE', edtParcelasNegritoCarne.Text);

      // dados beneficiario
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', edtUsaSac.Text        );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', edtDesBen.Text        );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', edtEndBen.Text        );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', edtBaiBen.Text        );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', edtCompBen.Text       );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', edtCidBen.Text        );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', edtEstBen.Text        );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', edtCepBen.Text        );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', edtCgCBen.Text        );
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVCESP', edtenvCaracEsp.Text  );

      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'GERAPIX', fraGerarPixBoleto.edtGerarPix.Text);
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'CHAPIX', IIF(fraGerarPixBoleto.edtGerarPix.Text = 'N', '', fraGerarPixBoleto.cmbChavePix.EditValue));
      fGetBancoConfig(1, 'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1), 'ENTREGUEBANCOEMAIL', edtEntregueBanco.Text);

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        pBackupCnfBco;
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        edtProxNumArqRem.Enabled := False;
        pSetFocus(cmbNumCart);
        btnEditar.Visible := True;
        pnlAtivo1.Enabled := False;
        pnlComplemento.Enabled := pnlAtivo1.Enabled;

        If tbsEncBan.tabVisible Then
          pnlAtivo2.Enabled := False;

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

procedure TfrmConfigItau.fraPlanoDeContasBaiMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
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

procedure TfrmConfigItau.fraPlanoDeContasEncMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
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

function TfrmConfigItau.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
var
  strMensagemConfig: String;
Begin

  Result := True;
  edtDiasProtestoPJ.Enabled := (cmbInstruPJ.ItemIndex <> -1);
  edtDiasProtestoPF.Enabled := (cmbInstruPF.ItemIndex <> -1);
  cmbTipDiaPJ.Enabled := (cmbInstruPJ.ItemIndex <> -1);
  cmbTipDiaPF.Enabled := (cmbInstruPF.ItemIndex <> -1);

   if blnNaoEditar then
     strMensagemConfig := #13 + 'Por favor acesse a tela de configuração do banco selecionado ' + #13  + ' e corrija as informações necessárias!'
  else
     strMensagemConfig := '';

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

    Else If (Sender = cmbInstrucao1) Then
    Begin

      If cmbInstrucao1.ItemIndex = -1 Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
      edtCodFsh.Enabled := (cmbInstrucao1.ItemIndex in [65,66]);
    End

    Else If (Sender = edtEnvCaracEsp) Then
    Begin
      If Pos(edtEnvCaracEsp.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo envia carcteres especiais na remessa deve ser S ou N!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = cmbInstrucao2) Then
    Begin

      If cmbInstrucao2.ItemIndex = -1 Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
      edtCodFsh.Enabled := (cmbInstrucao2.ItemIndex in [65,66]);
    End

    Else If (Sender = cmbInstruPF) And (cmbInstruPF.Enabled) Then
    Begin
      If (cmbInstruPersonalizada.Enabled) And
             (cmbInstruPersonalizada.ItemIndex > -1) And
             (cmbInstruPF.ItemIndex > -1)  Then
      Begin
        fMensagem('ATENÇÃO','Não é permitido utilizar ocorrências personalizada por cliente ' +
                            'juntamento com ocorrências por pessoa física/pessoa jurídica',['&OK']);
        Result := False;
        cmbInstruPF.ItemIndex := -1;
        cmbInstruPJ.ItemIndex := -1;
      End;
      edtCodFsh.Enabled := (cmbInstruPF.ItemIndex in [65,66]);
    End

    Else If (Sender = cmbInstruPJ) And (cmbInstruPJ.Enabled) Then
    Begin
      If (cmbInstruPersonalizada.Enabled) And
             (cmbInstruPersonalizada.ItemIndex > -1) And
             (cmbInstruPJ.ItemIndex > -1)  Then
      Begin
        fMensagem('ATENÇÃO','Não é permitido utilizar ocorrências personalizada por cliente ' +
                            'juntamento com ocorrências por pessoa física/pessoa jurídica',['&OK']);
        Result := False;
        cmbInstruPJ.ItemIndex := -1;
        cmbInstruPF.ItemIndex := -1;
      End;
      edtCodFsh.Enabled := (cmbInstruPJ.ItemIndex in [65,66]);
    End

    Else If (Sender = cmbInstruPersonalizada) And  (cmbInstruPersonalizada.Enabled)  Then
    Begin
      If (((cmbInstruPF.Enabled) And
              (cmbInstruPF.ItemIndex > -1)) Or
              ((cmbInstruPJ.Enabled) And
              (cmbInstruPJ.ItemIndex > -1))) And (cmbInstruPersonalizada.ItemIndex > -1) Then
      Begin
        fMensagem('ATENÇÃO','Não é permitido utilizar ocorrências personalizada por cliente ' +
                            'juntamento com ocorrências por pessoa física/pessoa jurídica',['&OK']);
        Result := False;
        cmbInstruPersonalizada.ItemIndex := -1;
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

    // DADOS BENEFICIARIO
    Else If Sender = edtUsaSac Then
    Begin

      If Pos(edtUsaSac.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Enviar Sacador/Avalista deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      End
      Else If (edtUsaSac.Text = 'N') Then
      Begin
        edtCompBen.Clear;
        edtDesBen.Clear;
        edtEndBen.Clear;
        edtBaiBen.Clear;
        edtCidBen.Clear;
        edtEstBen.Clear;
        edtCepBen.Clear;
        edtCgcBen.Clear;
      End
      Else If (edtUsaSac.Text = 'S')  Then
      Begin
        edtEntregueBanco.Text := 'S';
      End;


      grpBeneficiario.Enabled := edtUsaSac.Text = 'S';
      edtEntregueBanco.ReadOnly := edtUsaSac.Text = 'S';
    End

    Else If Sender = edtDesBen Then
    Begin
      If (fEmptyStr(edtDesBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtEndBen Then
    Begin
      If (fEmptyStr(edtEndBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Endereço do beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtBaiBen Then
    Begin
      If (fEmptyStr(edtBaiBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Bairro do beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtCidBen Then
    Begin
      If (fEmptyStr(edtCidBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Cidade do beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtEstBen Then
    Begin
      If (fEmptyStr(edtEstBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Estado do beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtCepBen Then
    Begin
      If (edtUsaSac.Text = 'S') Then
      Begin
        If (fEmptyStr(fRetSomenteNumeros(edtCepBen.Text))) Then
        Begin
          fMensagem('ATENÇÃO','O campo CEP do beneficiário deve ser preenchido!' ,['&O K']);
          Result := False;
        End
        Else If Length(fRetSomenteNumeros(edtCepBen.Text)) < 8 Then
        Begin
          fMensagem('ATENÇÃO','O campo CEP do beneficiário deve ser preenchido com 8 números!' ,['&O K']);
          Result := False;
        End;
      End;
    End

    Else If Sender = edtCgcBen Then
    Begin
      If (edtUsaSac.Text = 'S') Then
      Begin
        If (fEmptyStr(fTiraCaracEspeciaisPonto(edtCgcBen.Text))) Then
        Begin
          fMensagem('ATENÇÃO','O campo CNPJ do beneficiário deve ser preenchido!' ,['&O K']);
          Result := False;
        End
        Else If (Length(fTiraCaracEspeciaisPonto(edtCgcBen.Text)) < 14) Or (Not fValidaCnpjCpf(edtCgcBen.Text)) Then
        Begin
          fMensagem('ATENÇÃO','O campo CNPJ do beneficiário deve conter um número válido!' ,['&O K']);
          Result := False;
        End;
      End;
    End
    // END DADOS BENEFICIARIO


    Else If Sender = edtResp Then
    Begin

      If (edtResp.Text <> 'E') And (edtResp.Text <> 'B') Then
      Begin
        fMensagem('','O campo Resp. por emissão de boletos deve ser E ou B!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If Sender = edtMandMsg Then
    Begin
      if fEmptyStr(edtMandMsg.Text) Then
        edtMandMsg.Text := 'S';

      If Pos(edtMandMsg.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO','Enviar Mensagem (Agrupamento) deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtConsDtArqRet Then
    Begin
      if fEmptyStr(edtConsDtArqRet.Text) Then
        edtConsDtArqRet.Text := 'N';

      If Pos(edtConsDtArqRet.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO','Considerar data de vencimento deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtTraOco47Ant Then
    Begin
      If fEmptyStr(edtTraOco47Ant.Text) Then
        edtTraOco47Ant.Text := 'N';

      If Pos(edtTraOco47Ant.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'O campo tratar ocorrencia 47 como antecipação deve ser preenchido com (S/N) ', ['&Ok']);
        Result := False;
      End;
    End

    Else If (tbsEncBan.TabVisible = True) and (Sender = edtPorTar) Then
    Begin
      If fEmptyStr(TEditFocus(Sender).Text) Then
      begin
        if (not fEmptyStr(edtValorTarifa.Text)) and (fStrToFloat(edtValorTarifa.Text)>0) then
        Begin
          fMensagem('', 'O portador para baixa da tarifa deve ser preenchido!'+strMensagemConfig, ['&Ok']);

          If (Sender = edtPorTar) Then edtDesPorTar.Clear;

          cxPaginas.ActivePage := tbsEncBan;
          Result := False;
        End;
      end
      else
      begin
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
            If Not fEmptyStr(edtDesPorTar.Text) Then
            Begin
              fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+strMensagemConfig, ['&Ok']);
              Result := False;
            End
          End;

        End;
      end;
    End

    Else If (tbsEncBan.TabVisible = True) and  (Sender = fraPlanoDeContasEnc.MskCodCta)  Then
    Begin
      If fEmptyStr(fraPlanoDeContasEnc.MskCodCta.Text) Then
      begin
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
        Else
        Begin
          Result := PlanoDeContasAtivo(fraPlanoDeContasEnc.MskCodCta.Text,True);
          fraPlanoDeContasEnc.edtDesCta.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;
        End;
      end;

    End

    Else If (tbsEncBan.TabVisible = True) and  (Sender = edtForTar)  Then
    Begin
      If fEmptyStr(edtForTar.Text) Then
      begin
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
        fMensagem('ATENÇÃO','O campo Atualizar Desp. Cobrança para ocorrências 32 e 35 deve ser preenchido com (S/N)!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If Sender = edtDetalheMulta Then
    Begin
      If Not MatchStr(edtDetalheMulta.Text, ['S', 'N']) Then
      Begin
        fMensagem('ATENÇÃO','O campo Enviar na remessa o detalhe multa deve ser preenchido com (S/N)!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If Sender = edtPerImpBol Then
    Begin
      If Pos(edtPerImpBol.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO','O campo Permitir impressão de boletos deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtParcelasNegritoCarne Then
    Begin
      If Pos(edtParcelasNegritoCarne.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO','O campo "Enviar parcelas em negrito quando layout for carnê?" deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtUtilizarPortadorDescontada Then
    Begin
      If Pos(edtUtilizarPortadorDescontada.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Utilizar Portador de Dupl. Descontadas no Portador de Baixa deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

      If (edtUtilizarPortadorDescontada.Text = 'S') And
         fEmptyStr(edtPorDes.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O campo Portador de Duplicatas Descontadas deve ser informado!'+strMensagemConfig, ['&Ok']);
        edtPorDes.Clear;
        Result := False;
      end;
    End

    Else If Sender = edtCodLiq Then
    Begin
      If Pos(edtCodLiq.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Considerar código de liquidação deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
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



    Else If (Sender = edtCodPor) Then
    Begin

      If fEmptyStr(edtCodPor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O portador deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        edtDesPor.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaPortador(edtCodPor.Text, edtDesPor);
        If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!'+strMensagemConfig, ['&Ok']);
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
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+strMensagemConfig, ['&Ok']);
            Result := False;
          End;
        End
        Else If (Not fPortadorPermiteBaixa(edtCodPor.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtPorDes) Then
    Begin

      If fEmptyStr(edtPorDes.Text) Then
        edtDesPorDes.Clear
      Else
      Begin
        pCarregaPortador(edtPorDes.Text, edtDesPorDes);
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

    Else If (Sender = fraPlanoDeContasBai.MskCodCta) Then
    Begin

      If fEmptyStr(fraPlanoDeContasBai.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser informado!'+strMensagemConfig, ['&Ok']);
        fraPlanoDeContasBai.edtDesCta.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaCentroCusto(fraPlanoDeContasBai.MskCodCta.Text, fraPlanoDeContasBai.edtDesCta);
        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!'+strMensagemConfig, ['&Ok']);
          Result := False;
        End
        Else
          Result := PlanoDeContasAtivo(fraPlanoDeContasBai.MskCodCta.Text,True);
      End;
    End

    Else If (Sender = edtExpCgc) Then
    Begin

      If fEmptyStr(edtExpCgc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Exp. Cnpj do cedente deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If Pos(edtExpCgc.Text, 'S_N_') = 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo Exp. Cnpj do cedente deve conter apenas (S/N)!'+strMensagemConfig, ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtPerMul) Then
    Begin
      If Not fValidaEscala(edtPerMul.Text, 0, 99.99) Then
      begin
        fMensagem('ATENÇÃO','O campo percentual de multa deve estar entre 0 e 99,99!'+strMensagemConfig,['&OK']);
        Result := False;
      end;
    End

    Else If (Sender = cmbNumCart) Then
    Begin
      If cmbNumCart.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO','O campo Número da Carteira deve ser informado!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else
      Begin
        If cmbNumCart.ItemIndex = 13 Then
          edtCodCar.Text := 'E'
        Else If cmbNumCart.ItemIndex = 14 Then
          edtCodCar.Text := 'U'
        Else If cmbNumCart.ItemIndex >= 24 Then
          edtCodCar.Text := 'D'
        Else
          edtCodCar.Text := 'I';
      End;
    End

    Else If (Sender = edtCodFsh) Then
    Begin
      If (Not fEmptyStr(edtCodFsh.Text)) Then
      Begin
        If (cmbInstrucao1.ItemIndex <> 65) And
           (cmbInstrucao2.ItemIndex <> 65) And
           (cmbInstrucao1.ItemIndex <> 66) And
           (cmbInstrucao2.ItemIndex <> 66) Then
        Begin
          fMensagem('ATENÇÃO','O Código Flash só deve ser preenchido quando utilizado o código 93 ou código 94 para instrução 1 ou para instrução 2!'+strMensagemConfig,['&OK']);
          Result := False;
        End
        Else If (cmbInstruPF.ItemIndex <> 65) And
                (cmbInstruPF.ItemIndex <> 66) Then
        Begin
          fMensagem('ATENÇÃO','O Código Flash só deve ser preenchido quando utilizado o código 93 ou código 94 para instrução de pessoa fisica!'+strMensagemConfig,['&OK']);
          Result := False;
        End
        Else If (cmbInstruPJ.ItemIndex <> 65) And
                (cmbInstruPJ.ItemIndex <> 66) Then
        Begin
          fMensagem('ATENÇÃO','O Código Flash só deve ser preenchido quando utilizado o código 93 ou código 94 para instrução de pessoa juridica!'+strMensagemConfig,['&OK']);
          Result := False;
        End
        Else If (Length(edtCodFsh.Text) <> edtCodFsh.MaxLength) Then
        Begin
          fMensagem('ATENÇÃO','O campo Código Flash, quando informado, deve ter 3 caracteres!'+strMensagemConfig,['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodAgencia) Then
    Begin
      If fEmptyStr(edtCodAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Código da Agência deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtContaCorr) Then
    Begin
      If fEmptyStr(edtContaCorr.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Conta Corrente deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      else
      begin
        if Length(edtContaCorr.Text) <> 5 then
        begin
          fMensagem('ATENÇÃO','O campo Conta Corrente deve ter 5 (cinco) caracteres. Caso tenha 0 (zero) favor informar!' + strMensagemConfig,['&OK']);
          Result := False;
        end;
      end;
    End

    Else If (Sender = edtDigCtaCor) Then
    Begin
      If fEmptyStr(edtDigCtaCor.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Dígito da Conta Corrente deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End;

      If Result Then
        edtIdentBanc.Text := edtContaCorr.Text + edtDigCtaCor.Text;
    End

    Else If (Sender = edtDiasProtestoPF) Then
    Begin
      If (cmbInstruPF.ItemIndex in [7, 32, 33, 38, 51, 56, 57, 63, 64])  Then
      Begin
        If (fEmptyStr(edtDiasProtestoPF.Text)) Then
        Begin
          fMensagem('ATENÇÃO','O campo Quantidade de dias para Protesto/Devolução/Negativação deve ser preenchido!'+strMensagemConfig,['&OK']);
          Result := False;
        End
        Else If StrToInt(edtDiasProtestoPF.Text) <= 0 Then
        Begin
          fMensagem('ATENÇÃO','O campo Quantidade de dias para Protesto/Devolução/Negativação deve ser maior que zero!'+strMensagemConfig,['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtDiasProtestoPJ) Then
    Begin
      If (cmbInstruPJ.ItemIndex in [7, 32, 33, 38, 51, 56, 57, 63, 64]) Then
      Begin
        If (fEmptyStr(edtDiasProtestoPJ.Text)) Then
        Begin
          fMensagem('ATENÇÃO','O campo Quantidade de dias para Protesto/Devolução/Negativação deve ser preenchido!'+strMensagemConfig,['&OK']);
          Result := False;
        End
        Else If StrToInt(edtDiasProtestoPJ.Text) <= 0 Then
        Begin
          fMensagem('ATENÇÃO','O campo Quantidade de dias para Protesto/Devolução/Negativação deve ser maior que zero!'+strMensagemConfig,['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtDiasProt) Then
    Begin
      If ((cmbInstrucao1.ItemIndex in [7, 32, 33, 38, 51, 56, 57, 63, 64])  Or
          (cmbInstrucao2.ItemIndex in [7, 32, 33, 38, 51, 56, 57, 63, 64]) Or
          (cmbInstruPersonalizada.ItemIndex In [7, 32, 33, 38, 51, 56, 57, 63, 64])) Then
      Begin
        If (fEmptyStr(edtDiasProt.Text)) Then
        Begin
          fMensagem('ATENÇÃO','O campo Quantidade de dias para Protesto/Devolução/Negativação deve ser preenchido!'+strMensagemConfig,['&OK']);
          Result := False;
        End
        Else If StrToInt(edtDiasProt.Text) <= 0 Then
        Begin
          fMensagem('ATENÇÃO','O campo Quantidade de dias para Protesto/Devolução/Negativação deve ser maior que zero!'+strMensagemConfig,['&OK']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = cmbTipDia) Then
    Begin
      If ((cmbInstrucao1.ItemIndex in [32, 56])  Or
          (cmbInstrucao2.ItemIndex in [32, 56])) And
         (cmbTipDia.ItemIndex = 0) Then
      Begin
        fMensagem('ATENÇÃO','O tipo de dias para protesto deve ser "Corridos" conforme a instrução!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
      If ((cmbInstrucao1.ItemIndex in [33, 57])  Or
          (cmbInstrucao2.ItemIndex in [33, 57])) And
         (cmbTipDia.ItemIndex = 1) Then
      Begin
        fMensagem('ATENÇÃO','O tipo de dias para protesto deve ser "Úteis" conforme a instrução!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = cmbTipDiaPF) Then
    Begin
      If (cmbInstruPF.ItemIndex In [32, 56]) And
         (cmbTipDiaPF.ItemIndex = 0) Then
      Begin
        fMensagem('ATENÇÃO','O tipo de dias para protesto deve ser "Corridos" conforme a instrução!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
      If (cmbInstruPF.ItemIndex In [33, 57]) And
         (cmbTipDiaPF.ItemIndex = 1) Then
      Begin
        fMensagem('ATENÇÃO','O tipo de dias para protesto deve ser "Úteis" conforme a instrução!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = cmbTipDiaPJ) Then
    Begin
      If (cmbInstruPJ.ItemIndex In [32, 56]) And
         (cmbTipDiaPJ.ItemIndex = 0) Then
      Begin
        fMensagem('ATENÇÃO','O tipo de dias para protesto deve ser "Corridos" conforme a instrução!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
      If (cmbInstruPJ.ItemIndex In [33, 57]) And
         (cmbTipDiaPJ.ItemIndex = 1) Then
      Begin
        fMensagem('ATENÇÃO','O tipo de dias para protesto deve ser "Úteis" conforme a instrução!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = chkCartSeq) Then
    Begin
      If (chkCartSeq.Checked) Then
      Begin
        If fVerificaCartPrimariaAutBan('CONFIG341-', tabCarteira.TabIndex + 1) Then
        Begin
          fMensagem('ATENÇÃO','Não pode ser utilizada sequência de Arquivo de Remessa de outra carteira, pois essa está cadastrada no campo Carteira Seq. de outra(s) carteira(s).' ,['&O K']);
          Result := False;
        End;
      End;
    End

    Else If Sender = fraGerarPixBoleto.edtGerarPix Then
    Begin
      If Not MatchStr(fraGerarPixBoleto.edtGerarPix.Text, ['S', 'N']) Then
      Begin
        fMensagem('ATENÇÃO','O campo Gerar boletos Pix QRCode deve ser preenchido com S ou N!' + strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If Sender = fraGerarPixBoleto.cmbChavePix Then
    Begin
      If fraGerarPixBoleto.edtGerarPix.Text = 'S' Then
      Begin
        If VarToString(fraGerarPixBoleto.cmbChavePix.EditValue).IsEmpty Then
        Begin
          fMensagem('ATENÇÃO','O campo Chave Pix da Conta deve ser preenchido!' + strMensagemConfig, ['&OK']);
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
          If fEmptyStr(fGetBancoConfig(0, 'CONFIG341-' + edtCartSeq.Text, 'PROXNUM', '')) Then
          Begin
            fMensagem('ATENÇÃO','Não pode ser usada essa carteira no campo Carteira Seq., pois essa não possui Último Núm. Seq. Remessa cadastrado!' ,['&O K']);
            Result := False;
          End
          Else
          If fVerificaCartFilhaAutBan('CONFIG341-' + edtCartSeq.Text) Then
          Begin
            fMensagem('ATENÇÃO','Não pode ser usada essa carteira no campo Carteira Seq., pois essa já possui uma Carteira Seq. cadastrada!' ,['&O K']);
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = edtEntregueBanco) then
    begin
      If Not MatchStr(edtEntregueBanco.Text, ['S', 'N']) Then
      Begin
        fMensagem('ATENÇÃO','O campo Entregue pelo banco por e-mail deve ser preenchido com S ou N!' + strMensagemConfig, ['&OK']);
        Result := False;
      End;
    end;

  End;

  If Not Result Then
  begin
    if not blnNaoEditar then
    begin
      cxPaginas.ActivePage := RetornaAbaDoComponete(Sender);
      pSetFocus(Sender);
    end;

  end;
End;

procedure TfrmConfigItau.grdTarifasDBTableView1DblClick(Sender: TObject);
begin
  inherited;
  If Not cdsCnfOco.isEmpty Then
    btnEdtOco.Click;

end;

procedure TfrmConfigItau.edtCodFshEnter(Sender: TObject);
begin
  inherited;
  edtCodFsh.Hint := 'Código fornecido pelo banco ' + #13+#10 +
                    'para envio de mensagens na ' + #13+#10 +
                    'remessa quando utilizada a ' + #13+#10 +
                    'instrução 93 ou a instrução 94.';
  pShowHint(edtCodFsh, 'Código Flash');
end;

procedure TfrmConfigItau.edtCodFshExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigItau.edtCodLiqEnter(Sender: TObject);
begin
  inherited;
  edtCodLiq.Hint := 'O código de liquidação vem na posição 393-394    ' + #13 + #10 +
                    'do arquivo de retorno. Se esse campo estiver     ' + #13 + #10 +
                    'gravado como "S", para o registro que possuir um ' + #13 + #10 +
                    'desses códigos: AC, B0, B1, B2, B3, B4, B5, B6,  ' + #13 + #10 +
                    'B7, CC, ou LC, será adicionado um dia útil à data' + #13 + #10 +
                    'do crédito da Movimentação Bancária na baixa do  ' + #13 + #10 +
                    'título.';

  pShowHint(edtCodLiq, 'Considerar código de liquidação');
end;

procedure TfrmConfigItau.edtCodLiqExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigItau.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, nil, Key, arrSel) then
    Begin
      If fValidaCampos(edtCodPor, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigItau.edtCodPorRemKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmConfigItau.edtConsDtArqRetEnter(Sender: TObject);
begin
  inherited;
  edtConsDtArqRet.Hint := 'Considera a data do vencimento do arquivo retorno.';

  pShowHint(edtConsDtArqRet, 'Datas');
end;

procedure TfrmConfigItau.edtConsDtArqRetExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigItau.pCarregaPortador(strCodPor: String; edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtLabel.Text := FieldByName('POR_NOMPOR').AsString;
  End;

end;

procedure TfrmConfigItau.pHideHint;
begin
  HintControler.HideHint;
end;


procedure TfrmConfigItau.pLimpaCampos;
var
  i: Integer;
begin
  for i := Self.ComponentCount -1 downto 0 do
  begin
    if (Self.Components[i] is TEditFocus) then
      (Self.Components[i] as TEditFocus).text := '';

    if (Self.Components[i] is TfraDirectoryEditFocus) then
      (Self.Components[i] as TfraDirectoryEditFocus).edtDirectory.text := '';

    if (Self.Components[i] is TCheckBox) then
      (Self.Components[i] as TCheckBox).Checked := False;

    if (Self.Components[i] is TComboBoxFocus) then
      (Self.Components[i] as TComboBoxFocus).ItemIndex := -1;
  end;
end;

procedure TfrmConfigItau.pShowHint(edtEdit: TEditFocus; strTitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,edtEdit.ClientOrigin.Y, strTitulo, edtEdit.Hint);
end;

procedure TfrmConfigItau.pShowHintBotao(btnBotao: TBitBtnLocked;
  strTitulo: String);
begin
  HintControler.ShowHint(btnBotao.ClientOrigin.X,btnBotao.ClientOrigin.Y, strTitulo, btnBotao.Hint);
end;

function TfrmConfigItau.RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;
begin
  While Not Sender.ClassName.Equals('TcxTabSheet') Do
  Begin
    Sender := Sender.Parent;
  End;
  Result := TcxTabSheet(Sender);

end;

procedure TfrmConfigItau.edtDiasCredEnter(Sender: TObject);
begin
  inherited;

  edtDiasCred.Hint := 'Informar quantidade de dias ' + #13+#10 +
                      'do intervalo entre a efetuação ' + #13+#10 +
                      'do pagamento e o crédito na ' + #13+#10 +
                      'conta corrente.';

  pShowHint(edtDiasCred, 'Dias para Crédito');

end;

procedure TfrmConfigItau.edtDiasCredExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigItau.edtEmpBolKeyPress(Sender: TObject; var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqEmpresa(conEmpSimples, Self, edtEmpBol, edtDesEmpresa, nil, Key, arrSel) then
    Begin
      Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigItau.edtEntregueBancoEnter(Sender: TObject);
begin
  inherited;
  if edtEntregueBanco.ReadOnly then
  begin
    edtEntregueBanco.Hint := 'Quando o sacador avalista está configurado, ' +
                             'o envio do e-mail torna-se obrigatório.';

    pShowHint(edtEntregueBanco, 'Entregue Pelo Banco');
  end;
end;

procedure TfrmConfigItau.edtEntregueBancoExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtEntregueBanco);
  pHideHint;
end;

procedure TfrmConfigItau.pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    edtLabel.Text := FieldByName('CTA_DESCTA').AsString;
  End;

end;

procedure TfrmConfigItau.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
  cxPaginas.ActivePage := tbsGeral;
end;


procedure TfrmConfigItau.tabCarteiraChanging(Sender: TObject;
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

procedure TfrmConfigItau.FormActivate(Sender: TObject);
begin
  inherited;
  If edtProxNumArqRem.Enabled Then
    pSetFocus(edtProxNumArqRem)
  Else
    pSetFocus(edtCodAgencia);
end;


procedure TfrmConfigItau.FormCreate(Sender: TObject);
begin
  inherited;
  pCarKeyAutBan;
  qryCadPor := fCriaQuery(Self);
  qryCadFor := fCriaQuery(Self);
  qryCadEmp := fCriaQuery(Self);
  cxPaginas.Properties.ActivePage := tbsGeral;

  tbsEncBan.TabVisible := fCfgSis('ENCBAN', varBoolean);

  fraGerarPixBoleto.Visible := fCfgSis('USAPIX', varBoolean);
end;

procedure TfrmConfigItau.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigItau.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigItau.btnAddOcoClick(Sender: TObject);
begin
  inherited;
  frmCadOcoCartei := TfrmCadOcoCartei.Create(nil);
  frmCadOcoCartei.strCartei :=  'CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp;
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

procedure TfrmConfigItau.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do registro da carteira selecionada?', ['&S i m', '&N ã o'], 2) = 1 then
  begin
    cxPaginas.ActivePage :=  tbsGeral;
    btnCancelar.Visible := False;
    btnEditar.Visible   := True;
    pnlAtivo1.Enabled := False;
    pnlComplemento.Enabled := pnlAtivo1.Enabled;

    if tbsEncBan.tabVisible then
       pnlAtivo2.Enabled:= False;

    btnEditar.Visible   := True;
    btnGravar.Enabled   := False;
    btnConfigurar.Enabled := False;
    pCarregaDados;
    pSetFocus(btnEditar);
  end;
end;

procedure TfrmConfigItau.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pHideHint;

    pCriarFormularios(TfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '341';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigItau.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\341400p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\341400p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigItau.BtnOcorrenciaClick(Sender: TObject);
  Var
    strDetalhe : String;
begin
  inherited;
  pHideHint;


  strDetalhe := #13#10 +
                '06, 08 - Baixa duplicata; ' + #13#10 +
                '02, 04 - Atualiza nosso número caso não tenha gravado; ' + #13#10 +
                '15 - Baixas Rejeitadas;'+ #13#10 +
                '19 - Confirma Recebimento de Instrução de Protesto;'+ #13#10 +
                '23 - Lança histórico de protesto; ' + #13#10 +
                '24 - Instrução de Protesto Rejeitada/Sustada;'+ #13#10 +
                '32 - Baixa por ter sido Protestado.'
                +#13#10+
                'As ocorrências listadas também fazem a atualização do código ' +
                'do Evento e do Portador das duplicatas, no caso dessas '+
                'ocorrências possuírem Evento/Portador vinculados.'+ #13#10 +
                #13#10 +
                'As demais ocorrências são gravadas na rotina ' +
                'de retorno e mostradas no relatório apenas em ' +
                'caráter informativo.'+ #13#10 +
                #13#10 +
                'Pressione Esc para voltar à tela de configurações.';


  TfrmMemo.pShowMessage('Banco 341 - Itaú - Detalhamento de Ocorrências (posições 109 - 110 arquivo retorno).' + #13#10 +
                        strDetalhe);
end;

procedure TfrmConfigItau.BtnOcorrenciaEnter(Sender: TObject);
begin
  inherited;
  btnOcorrencia.Hint := 'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
                        'que são tratados pelas rotinas do sistema.';
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigItau.BtnOcorrenciaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigItau.btnRemOcoClick(Sender: TObject);
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
      pDesmembraCarteira('CONFIG341-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp,
                         strCodBco, strTipLay, strNumPos, strEspeci, strCodEmp, intCartei);

      objCnfDao := TCnfOcoDao.Create(strCodBco, strTipLay, strNumPos,
                                     strEspeci, strCodEmp, intCartei);

      objCnfOco := objCnfDao.fBuscaPorOcorrencia(cdsCnfOcoCNF_CODOCO.AsString,'',Copy(cdsCnfOcoCNF_PLNCON.AsString,1,7),cdsCnfOcoCNF_TIPDES.AsInteger);
      If Assigned(objCnfOco) Then
      Begin
        If objCnfDao.fRemoverOcorrencia(objCnfOco.strCodOco,'',objCnfOco.strCodCta,objCnfOco.intTipDes) Then
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

procedure TfrmConfigItau.chkCartSeqClick(Sender: TObject);
begin
  inherited;
  If Not fValidaCampos(chkCartSeq) Then
    TCheckBox(Sender).Checked := False;

  lblCartSeq.Enabled := TCheckBox(Sender).Checked;
  edtCartSeq.Enabled := TCheckBox(Sender).Checked;
end;

procedure TfrmConfigItau.chkOb5DesClick(Sender: TObject);
begin
  inherited;
  If Not fValidaCampos(chkOb5Des) Then
    TCheckBox(Sender).Checked := False;

  if TCheckBox(Sender).Checked then
    edtObservacao5.font.style := [fsBold]
  else
    edtObservacao5.font.style := [];
end;

procedure TfrmConfigItau.chkOb5DesEnter(Sender: TObject);
begin
  inherited;
  pShowHint(edtObservacao5, 'Texto Impresso no Boleto em Negrito');
end;

procedure TfrmConfigItau.chkOb5DesExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigItau.cmbCodigoMultaChange(Sender: TObject);
begin
  inherited;
  DefineDescricaoTipoMulta;
end;

procedure TfrmConfigItau.cmbCodigoMultaEnter(Sender: TObject);
begin
  inherited;
  cmbCodigoMulta.Hint := 'Quando o campo estiver selecionado: ' + #13#10 +
                         '-"Padrão": o valor da multa e da mora serão calculados sobre o valor do boleto.' + #13#10 +
                         '-"Valor Fixo": a multa será o valor do campo Valor Fixo da Multa e o valor da ' + #13#10 +
                         '               mora será calculado sobre o valor do boleto.'+ #13#10 +
                         '-"Percentual de Multa": o valor da multa e da mora do boleto serão impressos ' + #13#10 +
                         '                        com os percentuais cadastrados.';


  HintControler.ShowHint(cmbCodigoMulta.ClientOrigin.X,
                         cmbCodigoMulta.ClientOrigin.Y,
                         'Tipo de impressão da Multa',
                         cmbCodigoMulta.Hint);
end;

procedure TfrmConfigItau.cmbCodigoMultaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigItau.cmbInstruPFChange(Sender: TObject);
begin
  inherited;
  edtDiasProtestoPF.Enabled := (cmbInstruPF.ItemIndex <> -1);
  cmbTipDiaPF.Enabled := (cmbInstruPF.ItemIndex <> -1);
end;

procedure TfrmConfigItau.cmbInstruPFKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (Key = #8) Then
    cmbInstruPF.itemIndex := -1;
end;

procedure TfrmConfigItau.cmbInstruPJChange(Sender: TObject);
begin
  inherited;
  edtDiasProtestoPJ.Enabled := (cmbInstruPJ.ItemIndex <> -1);
  cmbTipDiaPJ.Enabled := (cmbInstruPJ.ItemIndex <> -1);
end;

procedure TfrmConfigItau.cmbInstruPJKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (Key = #8) Then
    cmbInstruPJ.itemIndex := -1;
end;

procedure TfrmConfigItau.cmbNumCartChange(Sender: TObject);
begin
  inherited;
  If cmbNumCart.ItemIndex = 13 Then
    edtCodCar.Text := 'E'
  Else If cmbNumCart.ItemIndex = 14 Then
    edtCodCar.Text := 'U'
  Else If cmbNumCart.ItemIndex >= 24 Then
    edtCodCar.Text := 'D'
  Else
    edtCodCar.Text := 'I';
end;

procedure TfrmConfigItau.edtPorDesEnter(Sender: TObject);
begin
  inherited;
  edtPorDes.Hint := 'Ao realizar o desconto das duplicatas, ' + #13+#10 +
                      'essa será transferida para o portador  ' + #13+#10 +
                      'selecionado nesse campo, até que seja ' + #13+#10 +
                      'realizada sua baixa.';

  pShowHint(edtPorDes, 'Portador de Duplicatas Descontadas');
end;

procedure TfrmConfigItau.edtPorDesExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigItau.edtPorDesKeyPress(Sender: TObject; var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    pHideHint;
    If fPesqPortador(conSimples, Self, edtPorDes, edtDesPorDes, nil, Key, arrSel) then
    Begin
      If fValidaCampos(edtPorDes, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigItau.edtForTarKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmConfigItau.edtPorTarKeyPress(Sender: TObject; var Key: Char);
var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtPorTar, edtDesPorTar, nil, Key, arrSel) then
    Begin
      If fValidaCampos(edtPorTar, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigItau.edtUsaSacExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtUsaSac);
end;

procedure TfrmConfigItau.edtUtilizarPortadorDescontadaEnter(Sender: TObject);
begin
  inherited;
  edtUtilizarPortadorDescontada.Hint := 'Quando for liquidação (Ocorrência 06) e o arquivo for de ' + #13+#10 +
                                        'Duplicata Descontada, utilizar como portador de baixa o '+ #13+#10 +
                                        'portador configurado para Duplicata Descontada?';

  pShowHint(edtUtilizarPortadorDescontada, 'Utilizar Portador de Dupl. Descontada no Portador de Baixa');
end;

procedure TfrmConfigItau.edtUtilizarPortadorDescontadaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigItau.edtValorTarifaExit(Sender: TObject);
begin
  inherited;
  try
    if not fEmptyStr(edtValorTarifa.Text) then
       edtValorTarifa.Text := FormatFloat('###,##0.00', fStrToFloat(edtValorTarifa.Text));
  except
      edtValorTarifa.Text := FormatFloat('###,##0.00', 0);
  end
end;

procedure TfrmConfigItau.edtMandMsgEnter(Sender: TObject);
begin
  inherited;
  edtMandMsg.Hint := 'Enviar número de duplicatas agrupadas.  '+ #13#10 +
                     'Configuração válida apenas para intruções 93 ou 94. ';

  pShowHint(edtMandMsg, 'Duplicatas agrupadas');
end;

procedure TfrmConfigItau.edtMandMsgExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigItau.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Seq. remessa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  stlCampos.Add('Util. outra cart. :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', ''));
  stlCampos.Add('Seq. carteira     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', ''));
  stlCampos.Add('Cód. agência      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Número C/C        :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  stlCampos.Add('Dígito C/C        :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', ''));
  stlCampos.Add('Identif. Bancária :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', ''));
  stlCampos.Add('Cód. carteira     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', ''));
  stlCampos.Add('Num. carteira     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', ''));
  stlCampos.Add('Portador de baixa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Conta de baixa    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Cód. instrução 1  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', ''));
  stlCampos.Add('Cód. instrução 2  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', ''));
  stlCampos.Add('Cód. Inst. Persona:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTPER', ''));
  stlCampos.Add('Cód. Instrução pessoa física  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRUCAO_PF', ''));
  stlCampos.Add('Cód. Instrução pessoa jurídica:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRUCAO_PJ', ''));
  stlCampos.Add('Dias para Protesto pessoa física  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAS_PROTESTO_PF', ''));
  stlCampos.Add('Dias para Protesto pessoa jurídica:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAS_PROTESTO_PJ', ''));
  stlCampos.Add('Observação 1      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Observação 3      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  stlCampos.Add('Observação 4      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  stlCampos.Add('Observação 5      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  stlCampos.Add('Dias p/ protesto  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  stlCampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  stlCampos.Add('Dias p/ mora      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAMORA', ''));
  stlCampos.Add('Arquivo remessa   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo retorno   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  stlCampos.Add('Percentual Multa  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', ''));
  stlCampos.Add('Inf. adicional    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', ''));
  stlCampos.Add('Responsável Bol.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', ''));
  stlCampos.Add('Protocolo aceite  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', ''));
  stlCampos.Add('Exp. CNPJ Cedente :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'EXPCNPJ', ''));
  stlCampos.Add('Tipo dia protesto :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TIPDIA', ''));
  stlCampos.Add('Tipo dia protesto pessoa física:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TIPDIA_PF', ''));
  stlCampos.Add('Tipo dia protesto pessoa jurídica:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TIPDIA_PJ', ''));
  stlCampos.Add('Código do Flash   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CDFLASH', ''));
  stlCampos.Add('Envia Dup. Agrup. :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ENVDUPAG', ''));
  stlCampos.Add('Conv. Serasa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CVSERAS', ''));
  stlCampos.Add('EncBan - Vr Tarifa:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', ''));
  stlCampos.Add('EncBan - Portador :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', ''));
  stlCampos.Add('EncBan - Conta    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', ''));
  stlCampos.Add('EncBan - Fornec.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', ''));
  stlCampos.Add('Considerar código liquidação:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODLIQU', 'N'));
  stlCampos.Add('Portador Descontadas:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORTDES', ''));
  stlCampos.Add('Data Compensação das taxas  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DTCOMTA', '2'));

  stlCampos.Add('Envia Sacador/Avalista:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', ''));
  stlCampos.Add('Beneficiário      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', ''));
  stlCampos.Add('Endereço          :' + fGetBancoConfig(0, strConfig+ IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', ''));
  stlCampos.Add('Bairro            :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', ''));
  stlCampos.Add('Complemento       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', ''));
  stlCampos.Add('Cidade            :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', ''));
  stlCampos.Add('Estado            :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', ''));
  stlCampos.Add('CEP               :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', ''));
  stlCampos.Add('CNPJ              :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', ''));
  stlCampos.Add('Considerar data de vencimento do arquivo retorno:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CONDTRET', ''));
  stlCampos.Add('Tratar ocorrencia 47 como antecipação:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TRAOC47A', ''));
  stlCampos.Add('Utilizar Portador de Dupl. Descontada no Portador de Baixa:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORDESPORBAI', ''));
  stlCampos.Add('Empresa para informações do boleto:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'EMPRBOL', ''));
  stlCampos.Add('Negrito:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSV5DE', ''));

  stlCampos.Add('Codigo da Multa: ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODIGOMULTA', ''));
  stlCampos.Add('Envia caracteres especiais :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ENVCESP', ''));
  stlCampos.Add('Enviar na remessa o detalhe de multa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DETALHEMULTA', ''));
  stlCampos.Add('Permitir impressão de boletos? :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', ''));
  stlCampos.Add('Enviar parcelas em negrito quando layout for carnê? :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PARCELASNEGRITOCARNE', ''));
  stlCampos.Add('Gera Pix QRCode :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'GERAPIX', ''));
  stlCampos.Add('Chave Pix       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CHAPIX', ''));
  stlCampos.Add('Entregue pelo banco por e-mail?' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ENTREGUEBANCOEMAIL', ''));

end;

procedure TfrmConfigItau.pGravaLogCarteira(stlCfgAnt : TStringList);
Var
  intCont,
  intIndice: Integer;
  stlCfgAtu: TStringList;
  strCmpAlt: String;

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
    pGravaLogAtb('341', 'ITAÚ', strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

procedure TfrmConfigItau.DefineDescricaoTipoMulta;
begin
  lblMulta.Caption := 'Percentual de Multa:';
  If cmbCodigoMulta.ItemIndex = 1 Then
   lblMulta.Caption := 'Valor fixo de Multa:';
end;

end.
