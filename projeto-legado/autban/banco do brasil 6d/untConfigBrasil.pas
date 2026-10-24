unit untConfigBrasil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, DirectoryEditFocus, StdCtrls, EditFocus, Buttons, ExtCtrls,
  QColorLabel, Menus, ComCtrls, ShellApi, Uni, AppEvnts, MaskEditFocus, ComboBoxFocus,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, untTypesSistema,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, StrUtils, dxCustomHint, cxTextEdit, cxMaskEdit, cxButtonEdit,
  dxScreenTip, cxClasses, cxHint, dxBarBuiltInMenu, cxGroupBox, cxPC, 
  untFrameDirectoryEditFocus, untFramePlanoDeContasMaskEdit;

type
  TfrmConfigBrasil = class(TfrmPai)
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
    Label6: TLabel;
    lblCodAgenc: TLabel;
    lblCodCart: TLabel;
    lblContCorr: TLabel;
    lblDiasProt: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    lblProNum: TLabel;
    lblResp: TLabel;
    ColorLabel1: TColorLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
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
    Label17: TLabel;
    lblNomAgencia: TLabel;
    lblDtaConv: TLabel;
    lbl1: TLabel;
    Label7: TLabel;
    ColorLabel5: TColorLabel;
    lbl2: TLabel;
    lblValidaOco: TLabel;
    ColorLabel6: TColorLabel;
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
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtMandMsg: TEditFocus;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtObservacao5: TEditFocus;
    edtDiasCred: TEditFocus;
    edtProAce: TEditFocus;
    edtTipCob: TEditFocus;
    edtCodigoLider: TEditFocus;
    edtNomAgencia: TEditFocus;
    edtDtaConvenio: TMaskEditFocus;
    cmbTipDia: TComboBoxFocus;
    edtSolDta: TEditFocus;
    edtInfAdi: TEditFocus;
    fraPathRemessaBB: TfraDirectoryEditFocus;
    fraPathRetornoBB: TfraDirectoryEditFocus;
    cmbCodCar: TComboBoxFocus;
    edtValidaOco: TEditFocus;
    cmbInstrucao1: TComboBoxFocus;
    cmbInstrucao2: TComboBoxFocus;
    chkCartSeq: TCheckBox;
    edtCartSeq: TEditFocus;
    pnlAtivo2: TPanel;
    cxGroupBox1: TcxGroupBox;
    Label26: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    edtDesPorTar: TEditFocus;
    edtPorTar: TEditFocus;
    edtValorTarifa: TEditFocus;
    edtDesForTar: TEditFocus;
    edtForTar: TEditFocus;
    Label18: TLabel;
    edtEmpBol: TEditFocus;
    edtDesEmpresa: TEditFocus;
    Label36: TLabel;
    tbsBeneficiario: TcxTabSheet;
    pnlAtivo3: TPanel;
    cxGroupBox2: TcxGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    edtCpfBenef: TEditFocus;
    edtNomeBenef: TEditFocus;
    Label28: TLabel;
    edtCnpjSacAvalista: TEditFocus;
    Label27: TLabel;
    edtSacAvalista: TEditFocus;
    cmbDataCompTaxa: TComboBoxFocus;
    fraPlanoDeContasEnc: TfraPlanoDeContasMskEdit;
    fraPlanoDeContasBai: TfraPlanoDeContasMskEdit;
    tbsComplemento: TcxTabSheet;
    pnlAtivo4: TPanel;
    Label2: TLabel;
    edtCodPorRem: TEditFocus;
    edtDescPorRem: TEditFocus;
    Label21: TLabel;
    edtEnvCaracEsp: TEditFocus;
    ColorLabel7: TColorLabel;
    lblPerImpBol: TLabel;
    edtPerImpBol: TEditFocus;
    clbPerImpBol: TColorLabel;
    procedure pCarregaDados;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure tabCarteiraChange(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure BtnManualClick(Sender: TObject);
    procedure cmbCodCarChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cmbInstrucao1Change(Sender: TObject);
    procedure cmbInstrucao2Change(Sender: TObject);
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
    procedure edtPorTarKeyPress(Sender: TObject; var Key: Char);
    procedure edtForTarKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorTarifaExit(Sender: TObject);
    procedure edtEmpBolKeyPress(Sender: TObject; var Key: Char);
    procedure ApplicationEventsDeactivate(Sender: TObject);
    procedure edtCnpjSacAvalistaEnter(Sender: TObject);
    procedure edtCnpjSacAvalistaExit(Sender: TObject);
    procedure edtCnpjSacAvalistaChange(Sender: TObject);
    procedure fraPlanoDeContasEncMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasBaiMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure edtCodPorRemKeyPress(Sender: TObject; var Key: Char);
  private

    { Private declarations }

    qryCadPor : TUniQuery;
    qryCadEmp : TUniQuery;
    qryCadCta : TUniQuery;
    qryCadFor : TUniQuery;

    procedure pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pCarregaEmpresa(strCodEmp: String; edtLabel: TEdit);
    procedure pVerificaCodigoTipoCarteira;
    procedure pShowHint(edtEdit: TEditFocus; strTitulo: String);
    procedure pShowHintBotao(btnBotao: TBitBtnLocked; strTitulo: String);
    procedure pHideHint;
    procedure pAlteraHint(edtEdit: TEditFocus; strNovoHint: String);
    procedure pAlteraHintBotao(btnBotao: TBitBtnLocked; strNovoHint: String);
    procedure pSetaDiasProtesto();
    procedure pLimpaCampos;
    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
    procedure pShowHintCnpj(edtEdit: TEditFocus; strTitulo: String);
    function RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;

    procedure pHabilitaObservacao(blnHabilita: Boolean = True);
  public
    { Public declarations }
    blnNaoEditar: Boolean;
    strConfig   : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigBrasil: TfrmConfigBrasil;

implementation

uses untfuncoesSimples, untPesqAux, untFuncoes,
     untCfgGenericas_AutBan, untConsultas, untMemo, untTBancoDoBrasilAPI;

{$R *.dfm}

procedure TfrmConfigBrasil.pCarregaDados;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************AF*}
  //Limpando Valores Carregados;
  pLimpaCampos;

  If fEmptyStr(fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '')) Then
  Begin
    edtProxNumArqRem.Enabled := True;
    edtProxNumArqRem.Clear;
    pSetFocus(edtProxNumArqRem);
  End
  Else
  Begin
    edtProxNumArqRem.Text := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '');
    edtProxNumArqRem.Enabled := False;
    pSetFocus(cmbCodCar);
  End;

  if (strLoginUsuarioLogado='997') or(strLoginUsuarioLogado='998') or (strLoginUsuarioLogado='999') Then
  begin
    edtProxNumArqRem.Enabled := True;
    pSetFocus(edtProxNumArqRem);
  End;

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', '')) Of
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

  edtVarCarteira.Text   := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'VARCART', '');
  edtDtaConvenio.Text   := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'DTACONV', '');

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', '')) Then
    edtNumConvenio.Text   := fPadL(fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', ''),edtNumConvenio.MaxLength,'0')
  Else
    edtNumConvenio.Clear;

  If tbsBeneficiario.TabVisible Then
  Begin
    edtNomeBenef.Text := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMBENE', '');
    edtCpfBenef.Text  := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'CPFBENE', '');
  End;

  edtCnpjSacAvalista.Text := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJSAC', '');
  edtSacAvalista.Text			:= fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', '');

  edtCodigoLider.Text   := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'CODLIDE', '');
  edtCodAgencia.Text    := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtDigAgencia.Text    := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', '');
  edtNomAgencia.Text    := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMAGEN', '');
  edtContaCorr.Text     := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', '');

  edtDigCtaCor.Text     := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', '');
  edtDiasProt.Text      := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '');
  edtResp.Text          := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', '');

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '')) Of
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
    End;
  End
  Else
    cmbInstrucao1.ItemIndex := -1;

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', '')) Of
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
    End;
  End
  Else
    cmbInstrucao2.ItemIndex := -1;

  edtDesPor.Text := '';
  edtDescPorRem.Text := '';
  fraPlanoDeContasBai.edtDesCta.Text := '';

  edtObservacao1.Text   := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text   := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text   := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text   := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text   := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');

  fraPathRemessaBB.edtDirectory.text := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '');
  fraPathRetornoBB.edtDirectory.text := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '');
  edtMandMsg.Text       := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'MANDMSG', '');
  edtCodPor.Text        := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  edtCodPorRem.Text      := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');
  fraPlanoDeContasBai.MskCodCta.Text := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');
  edtSolDta.Text        := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'SOLIDTA', 'N');

  edtDiasCred.Text      := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', '');
  edtProAce.Text        := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', '');
  edtTipCob.Text        := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPCOBR', '');
  edtInfAdi.Text        := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', '');
  cmbTipDia.ItemIndex   := StrToIntDef(fGetBancoConfig(0,'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1),'TIPDIA', '1'),0)-1;
  edtValidaOco.Text     := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOCO5', '');
  edtEnvCaracEsp.Text   := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVCESP', '');
  chkCartSeq.Checked    := (fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', '') = 'S');
  edtCartSeq.Text       := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', '');
  edtPorTar.Text        := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', '');
  fraPlanoDeContasEnc.MskCodCta.Text := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', '');
  edtForTar.Text        := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', '');
  edtValorTarifa.Text   := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', '');
  edtEmpBol.Text        := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'EMPRBOL', '');

  If Not fEmptyStr(fGetBancoConfig(0,'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1),'DTCOMTA', '2')) Then
    cmbDataCompTaxa.ItemIndex := StrToInt(fGetBancoConfig(0,'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1),'DTCOMTA', '2'))-1
  Else
    cmbDataCompTaxa.ItemIndex := 1;

  edtPerImpBol.Text     := fGetBancoConfig(0,'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', '');
  If fEmptyStr(edtPerImpBol.Text) Then
    edtPerImpBol.Text := 'S';

  If fEmptyStr(edtEnvCaracEsp.Text) Then
    edtEnvCaracEsp.Text := 'N';

  chkCartSeq.OnClick(chkCartSeq);

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCodPorRem.Text ) Then
    pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);

  If Not fEmptyStr( fraPlanoDeContasBai.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContasBai.MskCodCta.Text, fraPlanoDeContasBai.edtDesCta);

  If Not fEmptyStr( edtPorTar.Text ) Then pCarregaPortador(edtPorTar.Text, edtDesPorTar);
  If Not fEmptyStr( fraPlanoDeContasEnc.MskCodCta.Text ) Then pCarregaCentroCusto(fraPlanoDeContasEnc.MskCodCta.Text, fraPlanoDeContasEnc.edtDesCta);
  If Not fEmptyStr( edtEmpBol.Text ) Then pCarregaEmpresa(edtEmpBol.Text, edtDesEmpresa);

  If Not fEmptyStr( edtForTar.Text ) Then
  begin
    pPesquisaCadFor(qryCadFor, qryCadFor, edtForTar.Text);
    edtDesForTar.Text  := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
  end;

  pSetaDiasProtesto();
end;

procedure TfrmConfigBrasil.pCarregaEmpresa(strCodEmp: String; edtLabel: TEdit);
begin
  pPesquisaCadEmp(Nil, qryCadEmp, strCodEmp);
  With qryCadEmp Do
  Begin
    edtLabel.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmConfigBrasil.FormShow(Sender: TObject);
begin
  inherited;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  pCarregaDados;
  pVerificaCodigoTipoCarteira;

  If edtProxNumArqRem.Enabled Then
    pSetFocus(edtProxNumArqRem)
  Else
    pSetFocus(cmbCodCar);

  pSetFocus(btnEditar);

  pnlAtivo1.Enabled := False;
  pnlAtivo2.Enabled := False;
  pnlAtivo3.Enabled := False;
  pnlAtivo4.Enabled := False;

  if blnNaoEditar then
  begin
     btnConfigurar.Enabled := False;
     btnConfigurar.Visible := False;
     btnGravar.Enabled     := True;
     btnEditar.Visible     := False;
     pSetFocus(btnGravar);
  end;

end;

procedure TfrmConfigBrasil.btnConfigurarEnter(Sender: TObject);
begin
  inherited;
  pAlteraHintBotao(btnConfigurar, 'Configurar percentual de ' + #13+#10 +
                                  'juros para remessa.');
  pShowHintBotao(btnConfigurar, 'Cofigurações específicas.');
end;

procedure TfrmConfigBrasil.btnConfigurarExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBrasil.btnEditarClick(Sender: TObject);
begin
  If ((Not fVerificaDireitoAutBan('PERCARBAN')) and (strLoginUsuarioLogado <> '999')) Then
  begin
    fMensagem('ATENÇÃO','Usuário sem permissão!', ['&Ok ']);
    Exit;
  end
  else
  begin
    pnlAtivo1.Enabled := True;
    pnlAtivo4.Enabled := pnlAtivo1.Enabled;
    pnlAtivo3.Enabled := tbsBeneficiario.TabVisible;

    if tbsEncBan.tabVisible then
      pnlAtivo2.Enabled := True;

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

procedure TfrmConfigBrasil.btnGravarClick(Sender: TObject);
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
      If edtProxNumArqRem.Text <> fRetProxNumAutBan('CONFIG001-' + edtCartSeq.Text) Then
      Begin
        If fMensagem('ATENÇÃO','Ao utilizar a sequência do arquivo de remessa de outra carteira, o campo Último Núm. de Seq. Arq. Remessa será sobrescrito pelo da carteira principal. Deseja continuar?',['&SIM', '&NÃO'], 1) = 2 Then
          Exit;
      End;
    End;

    Try
      stlCfgAnt := TStringList.Create;
      pCarregaCfg(stlCfgAnt);

      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', IIF(chkCartSeq.Checked, fRetProxNumAutBan('CONFIG001-' + edtCartSeq.Text), edtProxNumArqRem.Text));
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', cmbCodCar.Text        );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'VARCART', edtVarCarteira.Text   );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'DTACONV', edtDtaConvenio.Text   );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', edtNumConvenio.Text   );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'CODLIDE', edtCodigoLider.Text   );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text    );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', edtDigAgencia.Text    );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMAGEN', edtNomAgencia.Text    );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text     );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', edtDigCtaCor.Text     );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text      );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text          );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', LeftStr(cmbInstrucao1.Text,2));
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', LeftStr(cmbInstrucao2.Text,2));

      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text  );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text  );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text  );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text  );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text  );

      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessaBB.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetornoBB.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'MANDMSG', edtMandMsg.Text      );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text       );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text       );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContasBai.MskCodCta.Text);
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'SOLIDTA', edtSolDta.Text       );

      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text     );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text       );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPCOBR', edtTipCob.Text       );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPDIA' , IntToStr(cmbTipDia.ItemIndex+1));
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text       );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOCO5', edtValidaOco.Text    );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVCESP', edtenvCaracEsp.Text  );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', IIF(chkCartSeq.Checked, 'S', 'N'));
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', IIF(chkCartSeq.Checked, edtCartSeq.Text, ''));
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', edtPorTar.Text    );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', fraPlanoDeContasEnc.MskCodCta.Text);
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', edtForTar.Text    );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', edtValorTarifa.Text  );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'EMPRBOL', edtEmpBol.Text  );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'DTCOMTA', IntToStr(cmbDataCompTaxa.ItemIndex+1));
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', edtSacAvalista.Text     );
      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJSAC', edtCnpjSacAvalista.Text );

      fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', edtPerImpBol.Text       );

      If tbsBeneficiario.TabVisible Then
      Begin
        fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMBENE', edtNomeBenef.Text  );
        fGetBancoConfig(1, 'CONFIG001-' + IntToStr(tabCarteira.TabIndex + 1), 'CPFBENE', edtCpfBenef.Text   );
      End;

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        pBackupCnfBco;
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        edtProxNumArqRem.Enabled := False;
        pSetFocus(cmbCodCar);
        cxPaginas.ActivePage :=  tbsGeral;
        pnlAtivo1.Enabled := False;
        pnlAtivo4.Enabled := pnlAtivo1.Enabled;
        pnlAtivo3.Enabled := False;

        if tbsEncBan.tabVisible then
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

procedure TfrmConfigBrasil.fraPlanoDeContasBaiMskCodCtaKeyPress(Sender: TObject;
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

procedure TfrmConfigBrasil.fraPlanoDeContasEncMskCodCtaKeyPress(Sender: TObject;
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

function TfrmConfigBrasil.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
var
  strMensagemConfig: String;
Begin

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

    Else If Sender = edtDiasProt Then
    Begin
      If (cmbInstrucao1.ItemIndex = 11) Or
         (cmbInstrucao2.ItemIndex = 11) Then
      Begin
        If fEmptyStr(edtDiasProt.Text) Then
        Begin
          fMensagem('','Ao utilizar o código da instrução 06, o preenchimento da quantidade de dias para protesto é obrigatório!'+strMensagemConfig,['&O K']);
          Result := False;
        End;
        If Not (StrToInt(edtDiasProt.Text) in [6 .. 29, 35, 40]) Then
        Begin
          fMensagem('','A quantidade de dias para protesto deve ser de 6 a 29, 35 ou 40 dias!'+strMensagemConfig,['&O K']);
          Result := False;
        End;
      End;
    End

    Else If Sender = edtResp Then
    Begin

      If (edtResp.Text <> 'E') And (edtResp.Text <> 'B') Then
      Begin
        fMensagem('','O campo Resp. por emissão de boletos deve ser E ou B!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

      pHabilitaObservacao((edtResp.Text = 'E') Or
                          ((fEmptyStr(edtSacAvalista.Text)) And (fEmptySTr(edtCnpjSacAvalista.Text))));

    End

    Else If Sender = edtTipCob Then
    Begin

      If Pos(edtTipCob.Text,'DS') <= 0 Then
      Begin
        fMensagem('','O campo tipo de cobrança deve ser S ou D!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else
        pVerificaCodigoTipoCarteira;

    End

    Else If Sender = edtProAce Then
    Begin
      If Pos(edtProAce.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Imprime Protocolo de Aceite deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
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
        else
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

    Else If (Sender = edtNumConvenio) Then
    Begin
      If fEmptyStr(edtNumConvenio.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Número do convênio deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End
      Else If Length(edtNumConvenio.Text) <> edtNumConvenio.MaxLength Then
      Begin
        fMensagem('ATENÇÃO!','O campo Número do convênio deve ter 6 caracteres!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodAgencia) Then
    Begin
      If fEmptyStr(edtCodAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Código da Agência deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End
      Else If Length(edtCodAgencia.Text) <> edtCodAgencia.MaxLength Then
      Begin
        fMensagem('ATENÇÃO!','O campo Código da Agência deve ter 4 caracteres!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodigoLider) Then
    Begin
      If Not fEmptyStr(edtCodigoLider.Text) Then
      Begin
        If Length(edtCodigoLider.Text) <> edtCodigoLider.MaxLength Then
        Begin
          fMensagem('ATENÇÃO!','O campo Código Lider deve ter 6 caracteres!'+strMensagemConfig, ['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtContaCorr) Then
    Begin
      If fEmptyStr(edtContaCorr.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Conta Corrente deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtSolDta) Then
    Begin
      If Pos(edtSolDta.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Solicita data de pag. deve ser S ou N!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigAgencia) Then
    Begin
      If fEmptyStr(edtDigAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Dígito da Agência deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigCtaCor) Then
    Begin
      If fEmptyStr(edtDigCtaCor.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Dígito da Conta Corrente deve ser preenchido!'+strMensagemConfig,['&OK']);
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
        fMensagem('ATENÇÃO!','O campo Variação da Carteira deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else If Length(edtVarCarteira.Text) <> edtVarCarteira.MaxLength Then
      Begin
        fMensagem('ATENÇÃO!','O campo Variação da Carteira deve ter 3 caracteres!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
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

    Else If (Sender = edtEnvCaracEsp) Then
    Begin
      If Pos(edtEnvCaracEsp.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo envia carcteres especiais na remessa deve ser S ou N!'+strMensagemConfig, ['&OK']);
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
        If fVerificaCartPrimariaAutBan('CONFIG001-', tabCarteira.TabIndex + 1) Then
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
          If fEmptyStr(fGetBancoConfig(0, 'CONFIG001-' + edtCartSeq.Text, 'PROXNUM', '')) Then
          Begin
            fMensagem('ATENÇÃO','Não pode ser usada essa carteira no campo Carteira Seq., pois essa não possui Último Núm. Seq. Remessa cadastrado!' ,['&O K']);
            Result := False;
          End
          Else
          If fVerificaCartFilhaAutBan('CONFIG001-' + edtCartSeq.Text) Then
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

procedure TfrmConfigBrasil.lblValidaOcoMouseEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtValidaOco, 'Este campo só é habilitado ' + #13+#10 +
                            'quando utilizada a carteira 17.');

  pShowHint(edtValidaOco, 'Condições para uso do campo');
end;

procedure TfrmConfigBrasil.lblValidaOcoMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBrasil.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
  cxPaginas.ActivePage := tbsGeral;
end;

procedure TfrmConfigBrasil.tabCarteiraChanging(Sender: TObject;
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

procedure TfrmConfigBrasil.edtCnpjSacAvalistaChange(Sender: TObject);
begin
  inherited;
  pHabilitaObservacao((edtResp.Text = 'E') Or
                      ((fEmptyStr(edtSacAvalista.Text)) And (fEmptySTr(edtCnpjSacAvalista.Text))));
end;

procedure TfrmConfigBrasil.edtCnpjSacAvalistaEnter(Sender: TObject);
begin
  inherited;
  pShowHintCnpj(TEditFocus(Sender),'Instruções permitidas:');
end;

procedure TfrmConfigBrasil.edtCnpjSacAvalistaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBrasil.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var 
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, nil, Key, arrSel) then
    Begin
      if fValidaCampos(edtCodPor) then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigBrasil.edtCodPorRemKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmConfigBrasil.edtDiasCredEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtDiasCred, 'Informar quantidade de dias ' + #13+#10 +
                           'do intervalo entre a efetuação ' + #13+#10 +
                           'do pagamento e o crédito na ' + #13+#10 +
                           'conta corrente.');

  pShowHint(edtDiasCred, 'Dias para Crédito');
end;

procedure TfrmConfigBrasil.edtDiasCredExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBrasil.edtEmpBolKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmConfigBrasil.edtForTarKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmConfigBrasil.pAlteraHint(edtEdit: TEditFocus; strNovoHint: String);
begin
  edtEdit.Hint := strNovoHint;
end;

procedure TfrmConfigBrasil.pAlteraHintBotao(btnBotao: TBitBtnLocked;
  strNovoHint: String);
begin
  btnBotao.Hint := strNovoHint;
end;

procedure TfrmConfigBrasil.pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    edtLabel.Text := FieldByName('CTA_DESCTA').AsString;
  End;

end;

procedure TfrmConfigBrasil.pCarregaPortador(strCodPor: String; edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtLabel.Text := FieldByName('POR_NOMPOR').AsString;
  End;

end;


procedure TfrmConfigBrasil.pHabilitaObservacao(blnHabilita: Boolean);
  Var
    clrCorCampos: TColor;
begin
  clrCorCampos := clWindow;
  If Not blnHabilita THen
    clrCorCampos := cl3Dlight;

  edtObservacao1.Color      := clrCorCampos;
  edtObservacao1.FocusColor := clrCorCampos;
  edtObservacao2.Color      := clrCorCampos;
  edtObservacao2.FocusColor := clrCorCampos;
  edtObservacao3.Color      := clrCorCampos;
  edtObservacao3.FocusColor := clrCorCampos;
  edtObservacao4.Color      := clrCorCampos;
  edtObservacao4.FocusColor := clrCorCampos;
  edtObservacao5.Color      := clrCorCampos;
  edtObservacao5.FocusColor := clrCorCampos;

  edtObservacao1.Enabled := blnHabilita;
  edtObservacao2.Enabled := blnHabilita;
  edtObservacao3.Enabled := blnHabilita;
  edtObservacao4.Enabled := blnHabilita;
  edtObservacao5.Enabled := blnHabilita;

  If Not blnHabilita Then
  Begin
    edtObservacao1.Clear;
    edtObservacao2.Clear;
    edtObservacao3.Clear;
    edtObservacao4.Clear;
    edtObservacao5.Clear;
  End;
end;

procedure TfrmConfigBrasil.pHideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmConfigBrasil.pLimpaCampos;
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

procedure TfrmConfigBrasil.pSetaDiasProtesto();
var
  intItemIndex: Integer;
begin
  if cmbInstrucao1.ItemIndex in [2..11] then
    intItemIndex := cmbInstrucao1.ItemIndex
  else if cmbInstrucao2.ItemIndex in [2..11] then
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

  edtDiasProt.Enabled := (intItemIndex = 11);

  Case intItemIndex Of
    0: cmbTipDia.ItemIndex := -1;
    2,3,4: cmbTipDia.ItemIndex := 0;
    5,6,7,8,9,10,11: cmbTipDia.ItemIndex := 1;
  End;
end;

procedure TfrmConfigBrasil.pShowHint(edtEdit: TEditFocus; strTitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,edtEdit.ClientOrigin.Y, strTitulo, edtEdit.Hint);
end;

procedure TfrmConfigBrasil.pShowHintBotao(btnBotao: TBitBtnLocked;
  strTitulo: String);
begin
  HintControler.ShowHint(btnBotao.ClientOrigin.X,btnBotao.ClientOrigin.Y, strTitulo, btnBotao.Hint);
end;

procedure TfrmConfigBrasil.pVerificaCodigoTipoCarteira;
begin
  If cmbCodCar.ItemIndex = 3 Then
    edtValidaOco.Enabled := True
  Else
  Begin
    edtValidaOco.Enabled := False;
    edtValidaOco.Text := 'S';
  End;
end;

function TfrmConfigBrasil.RetornaAbaDoComponete(
  Sender: TWinControl): TCxTabSheet;
begin
  While Not Sender.ClassName.Equals('TcxTabSheet') Do
  Begin
    Sender := Sender.Parent;
  End;
  Result := TcxTabSheet(Sender);
end;

procedure TfrmConfigBrasil.FormActivate(Sender: TObject);
begin
  inherited;
  If edtProxNumArqRem.Enabled Then
    pSetFocus(edtProxNumArqRem)
  Else
    pSetFocus(cmbCodCar);
end;

procedure TfrmConfigBrasil.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  qryCadFor := fCriaQuery(Self);
  qryCadEmp := fCriaQuery(Self);
  pCarKeyAutBan;
  cxPaginas.Properties.ActivePage := tbsGeral;
  tbsBeneficiario.TabVisible := fCfgSis('BENBOL', varBoolean);


  If fCfgSis('ENCBAN', varBoolean) Then
    tbsEncBan.TabVisible := True
  else
    tbsEncBan.TabVisible := False;

end;

procedure TfrmConfigBrasil.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigBrasil.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBrasil.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do registro da carteira selecionada?', ['&S i m', '&N ã o'], 2) = 1 then
  begin
    cxPaginas.ActivePage :=  tbsGeral;
    btnCancelar.Visible := False;
    btnEditar.Visible   := True;
    pnlAtivo1.Enabled := False;
    pnlAtivo4.Enabled := pnlAtivo1.Enabled;
    pnlAtivo3.Enabled := False;

    if tbsEncBan.tabVisible then
       pnlAtivo2.Enabled:= False;

    btnEditar.Visible   := True;
    btnGravar.Enabled   := False;
    btnConfigurar.Enabled := False;
    pCarregaDados;
    pSetFocus(btnEditar);
  end;
end;

procedure TfrmConfigBrasil.btnConfigurarClick(Sender: TObject);
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

procedure TfrmConfigBrasil.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\001400p6d.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\001400p6d.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigBrasil.btnOcorrenciaClick(Sender: TObject);
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
                'quando estiver setada a configuração '+
                '"Valida a Ocorrência 05" com N.' + #13#10 +
                #13#10 +
                'Se configurado através do botão "Configurar" as ocorrências 02, 05, 06, 07, 08, 09, 15 e 23, será ' +
                'feita a atualização de Portador e Evento quando realizada a "Atualização/Baixa Automática de Duplicatas".' + #13#10 +
                #13#10 +
                'As demais ocorrências são gravadas na rotina ' +
                'de retorno e mostradas no relatório apenas em ' +
                'caráter informativo.'+ #13#10 +
                #13#10 +
                'Pressione Esc para voltar à tela de configurações.';

  TfrmMemo.pShowMessage('Banco 001 - Banco do Brasil - Detalhamento de Ocorrências (posições 109 - 110 arquivo retorno).' + #13#10 +
                        strDetalhe);
end;

procedure TfrmConfigBrasil.btnOcorrenciaEnter(Sender: TObject);
begin
  inherited;
  pAlteraHintBotao(btnOcorrencia, 'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
                                  'que são tratados pelas rotinas do sistema.');
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigBrasil.btnOcorrenciaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBrasil.chkCartSeqClick(Sender: TObject);
begin
  inherited;
  If Not fValidaCampos(chkCartSeq) Then
    TCheckBox(Sender).Checked := False;

  lblCartSeq.Enabled := TCheckBox(Sender).Checked;
  edtCartSeq.Enabled := TCheckBox(Sender).Checked;
end;

procedure TfrmConfigBrasil.cmbCodCarChange(Sender: TObject);
begin
  inherited;
  pVerificaCodigoTipoCarteira;
end;

procedure TfrmConfigBrasil.cmbInstrucao1Change(Sender: TObject);
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

procedure TfrmConfigBrasil.cmbInstrucao2Change(Sender: TObject);
begin
  inherited;

  pSetaDiasProtesto();
end;

procedure TfrmConfigBrasil.edtPorTarKeyPress(Sender: TObject; var Key: Char);
var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtPorTar, edtDesPorTar, nil, Key, arrSel) then
    Begin
      if fValidaCampos(edtPorTar) then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;

end;

procedure TfrmConfigBrasil.pShowHintCnpj(edtEdit: TEditFocus;
  strTitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,edtEdit.ClientOrigin.Y, strTitulo, edtEdit.Hint);
end;

procedure TfrmConfigBrasil.edtValorTarifaExit(Sender: TObject);
begin
  inherited;
  try
    if not fEmptyStr(edtValorTarifa.Text) then
       edtValorTarifa.Text := FormatFloat('###,##0.00', fStrToFloat(edtValorTarifa.Text));
  except

  end
end;

procedure TfrmConfigBrasil.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Seq. Remessa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  stlCampos.Add('Util Outra Cart.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', ''));
  stlCampos.Add('Carteira Seq.     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', ''));
  stlCampos.Add('Código Carteira   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', ''));
  stlCampos.Add('Variação Carteira :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'VARCART', ''));
  stlCampos.Add('Número Convênio   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', ''));
  stlCampos.Add('Código Líder      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODLIDE', ''));
  stlCampos.Add('Código Agência    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Dígito Agência    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', ''));
  stlCampos.Add('Nome Agência      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NOMAGEN', ''));
  stlCampos.Add('Num. C. Corrente  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  stlCampos.Add('Díg. C. Corrente  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', ''));
  stlCampos.Add('Data do Convênio  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DTACONV', ''));
  stlCampos.Add('Cód. Instrução 1  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', ''));
  stlCampos.Add('Cód. Instrução 2  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', ''));
  stlCampos.Add('Observação 1      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Observação 3      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  stlCampos.Add('Observação 4      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  stlCampos.Add('Observação 5      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  stlCampos.Add('Dias p/ protesto  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  stlCampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  stlCampos.Add('Arquivo Remessa   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo Retorno   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  stlCampos.Add('Resp. Emissão Bol :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', ''));
  stlCampos.Add('Protocolo Aceite  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', ''));
  stlCampos.Add('Tipo de Cobrança  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TIPCOBR', ''));
  stlCampos.Add('Nro Dupl. Agrup.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'MANDMSG', ''));
  stlCampos.Add('Portador de baixa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Portador da remessa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', ''));
  stlCampos.Add('Conta de baixa    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Tipo dia protesto :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TIPDIA', ''));
  stlCampos.Add('Data Pagto Baixa  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SOLIDTA', ''));
  stlCampos.Add('Info Adicional    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', ''));
  stlCampos.Add('Valida Ocorr. 05  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'VALOCO5', ''));
  stlCampos.Add('Conv. Serasa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CVSERAS', ''));
  stlCampos.Add('Enc.Ban. Vr Tarifa:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', ''));
  stlCampos.Add('Enc.Ban. Portador :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', ''));
  stlCampos.Add('Enc.Ban. Pl Conta :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', ''));
  stlCampos.Add('Enc.Ban. Fornec.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', ''));
  stlCampos.Add('Data Compensação das taxas:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DTCOMTA', '2'));
  stlCampos.Add('Empresa para informações do boleto:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'EMPRBOL', ''));
  stlCampos.Add('Nome Sacador/Avalista:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', ''));
  stlCampos.Add('CPF/ CNPJ Sacador/Avalista :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CNPJSAC', ''));
  stlCampos.Add('Envia caracteres especiais :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ENVCESP', ''));
  stlCampos.Add('Permitir impressão de boletos? :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', ''));

end;

procedure TfrmConfigBrasil.pGravaLogCarteira(stlCfgAnt : TStringList);
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
    pGravaLogAtb('001', 'BANCO DO BRASIL 6D', strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

end.


