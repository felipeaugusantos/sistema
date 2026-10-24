unit untConfigCapitalFinancas;

interface

uses
  Windows, Messages, SysUtils, variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, DirectoryEditFocus, StdCtrls, EditFocus, Buttons,
  ExtCtrls, QColorLabel, Menus, ComCtrls, ShellApi, AppEvnts, Uni, BitBtnLockedIncrem,
  untTypesSistema, frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxButtonEdit, strUtils,Datasnap.Midas,
  dxScreenTip, cxClasses, dxCustomHint, cxHint, ComboBoxFocus, MaskEditFocus,
  untFrameDirectoryEditFocus, untFrameCheckComboBoxOcorrencia, dxBarBuiltInMenu,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridCustomView, cxGrid, cxGroupBox, cxPC,
  untCadOcoCartei, untCNFOCO_Class, untCNFOCO_Dao, Datasnap.DBClient,
  UniClientDataSet,System.Generics.Collections, untFramePlanoDeContasMaskEdit;

type
  TfrmConfigCapitalFinancas = class(TfrmPai)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
    HintControler: TcxHintStyleController;
    pnlAtivo: TPanel;
    Label5: TLabel;
    lblCodAgenc: TLabel;
    lblCodCart: TLabel;
    lblContCorr: TLabel;
    lblDiasProt: TLabel;
    lblNumAutBco: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    lblProNum: TLabel;
    lblResp: TLabel;
    lblTipCob: TLabel;
    ColorLabel1: TColorLabel;
    ColorLabel2: TColorLabel;
    Label4: TLabel;
    Label1: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    ColorLabel3: TColorLabel;
    Label7: TLabel;
    Label2: TLabel;
    ColorLabel5: TColorLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    ColorLabel6: TColorLabel;
    Label19: TLabel;
    edtTipoCob: TEditFocus;
    edtResp: TEditFocus;
    edtProxNumArqRem: TEditFocus;
    edtNumAutBco: TEditFocus;
    edtDigCtaCor: TEditFocus;
    edtDiasProt: TEditFocus;
    edtContaCorr: TEditFocus;
    edtCodEmpBanco: TEditFocus;
    edtCodCar: TEditFocus;
    edtCodAgencia: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtObservacao5: TEditFocus;
    edtDiasCred: TEditFocus;
    edtProAce: TEditFocus;
    edtExpBol: TEditFocus;
    edtPerMul: TEditFocus;
    edtInfAdi: TEditFocus;
    edtOutAcr: TEditFocus;
    edtMandMsg: TEditFocus;
    fraPathRemessaBDC: TfraDirectoryEditFocus;
    fraPathRetornoBDC: TfraDirectoryEditFocus;
    cmbInstrucao1: TComboBoxFocus;
    lblCartSeq: TLabel;
    edtCartSeq: TEditFocus;
    chkCartSeq: TCheckBox;
    edtDigAge: TEditFocus;
    btnCancelar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    BtnManual: TBitBtnLocked;
    BtnOcorrencia: TBitBtnLocked;
    Label25: TLabel;
    edtExibMsg: TEditFocus;
    ColorLabel7: TColorLabel;
    Label26: TLabel;
    edtDtaCre: TEditFocus;
    ColorLabel8: TColorLabel;
    fraCheckComboBoxOcorrencia: TfraCheckComboBoxOcorrencia;
    Label28: TLabel;
    cxPaginas: TcxPageControl;
    tbsGeral: TcxTabSheet;
    tbsEncBan: TcxTabSheet;
    pnlAtivo2: TPanel;
    grpTarAux: TcxGroupBox;
    grdTarifas: TcxGrid;
    grdTarifasDBTableView1: TcxGridDBTableView;
    grdTarifasDBTableView1CNF_CODOCO: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_DESOCO: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_GERPAG: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_CUSCAR: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_FORNEC: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_PLNCON: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_PORTAD: TcxGridDBColumn;
    grdTarifasLevel1: TcxGridLevel;
    btnAddOco: TBitBtnLocked;
    btnRemOco: TBitBtnLocked;
    btnEdtOco: TBitBtnLocked;
    grpTarLiq: TcxGroupBox;
    Label60: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    edtDesPorTar: TEditFocus;
    edtPorTar: TEditFocus;
    edtValorTarifa: TEditFocus;
    edtDesForTar: TEditFocus;
    edtForTar: TEditFocus;
    dsCnfOco: TDataSource;
    cdsCnfOco: TUniClientDataSet;
    cdsCnfOcoCNF_CODOCO: TStringField;
    cdsCnfOcoCNF_DESOCO: TStringField;
    cdsCnfOcoCNF_GERPAG: TBooleanField;
    cdsCnfOcoCNF_FORNEC: TStringField;
    cdsCnfOcoCNF_PORTAD: TStringField;
    cdsCnfOcoCNF_PLNCON: TStringField;
    cdsCnfOcoCNF_CUSCAR: TBooleanField;
    ColorLabel9: TColorLabel;
    edtUtlDesDup: TEditFocus;
    Label27: TLabel;
    clDsName: TColorLabel;
    edtDsName: TEditFocus;
    lblDsName: TLabel;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    fraPlanoDeContasEnc: TfraPlanoDeContasMskEdit;
    lblvarNomRem: TLabel;
    edtvarNomRem: TEditFocus;
    pnlAlpe: TPanel;
    clAlpe: TColorLabel;
    lblAlpe: TLabel;
    edtUtilizaAlpe: TEditFocus;
    bsComplemento: TcxTabSheet;
    pnlComplemento: TPanel;
    Label24: TLabel;
    edtUsaSac: TEditFocus;
    ColorLabel4: TColorLabel;
    grpBeneficiario: TGroupBox;
    lblDesCrr: TLabel;
    Label3: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    edtDesBen: TEditFocus;
    edtendBen: TEditFocus;
    edtCompBen: TEditFocus;
    edtBaiBen: TEditFocus;
    edtCidBen: TEditFocus;
    edtEstBen: TEditFocus;
    edtCepBen: TMaskEditFocus;
    edtCgcBen: TMaskEditFocus;
    lblEspecieDocumento: TLabel;
    lblEspecieDocumentoSN: TColorLabel;
    edtEspecieDocumento: TEditFocus;
    cdsCnfOcoCNF_GERREC: TBooleanField;
    grdTarifasDBTableView1CNF_GERREC: TcxGridDBColumn;
    pnlAlpeTaxas: TPanel;
    lblPercentualAlpe: TLabel;
    edtPercentualAlpe: TEditFocus;
    lblTarifaTed: TLabel;
    edtTarifaTed: TEditFocus;
    cdsCnfOcoCNF_TIPDES: TIntegerField;
    cdsCnfOcoCNF_DSTPDS: TStringField;
    grdTarifasDBTableView1CNF_DSTPDS: TcxGridDBColumn;
    Label29: TLabel;
    cmbInstruPersonalizada: TComboBoxFocus;
    Label30: TLabel;
    edtCodPorRem: TEditFocus;
    edtDescPorRem: TEditFocus;
    ColorLabel10: TColorLabel;
    edtSolDta: TEditFocus;
    Label6: TLabel;
    cdsCnfOcoCNF_MOTOCO: TStringField;
    grdTarifasDBTableView1CNF_MOTOCO: TcxGridDBColumn;
    clDiasCreditoTarifa: TColorLabel;
    edtDiasCreditoTarifa: TEditFocus;
    lblDiasCreditoTarifa: TLabel;
    pnlExtrant: TPanel;
    clExtrant: TColorLabel;
    lblExtrant: TLabel;
    edtUtilizaExtrant: TEditFocus;
    lblDupEmpLog: TLabel;
    clDupEmpLog: TColorLabel;
    edtDupEmpLog: TEditFocus;
    lblPerImpBol: TLabel;
    edtPerImpBol: TEditFocus;
    clbPerImpBol: TColorLabel;

    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tabCarteiraChange(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure BtnManualClick(Sender: TObject);
    procedure edtDiasCredEnter(Sender: TObject);
    procedure edtDiasCredExit(Sender: TObject);
    procedure btnConfigurarEnter(Sender: TObject);
    procedure btnConfigurarExit(Sender: TObject);
    procedure cmbInstrucao1Change(Sender: TObject);
    procedure BtnOcorrenciaEnter(Sender: TObject);
    procedure BtnOcorrenciaExit(Sender: TObject);
    procedure BtnOcorrenciaClick(Sender: TObject);
    procedure chkCartSeqClick(Sender: TObject);
    procedure edtUsaSacExit(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure edtDtaCreExit(Sender: TObject);
    procedure ApplicationEventsDeactivate(Sender: TObject);
    procedure btnEdtOcoClick(Sender: TObject);
    procedure edtForTarKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorTarKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddOcoClick(Sender: TObject);
    procedure btnRemOcoClick(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasEncMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    function RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;
    procedure edtUtilizaAlpeChange(Sender: TObject);
    procedure edtCodPorRemKeyPress(Sender: TObject; var Key: Char);
    procedure edtDiasCreditoTarifaEnter(Sender: TObject);
    procedure edtDiasCreditoTarifaMouseEnter(Sender: TObject);
    procedure edtDiasCreditoTarifaMouseLeave(Sender: TObject);
    procedure edtDiasCreditoTarifaExit(Sender: TObject);
  private
    FQryCadPor: TUniQuery;
    FQryCadCta: TUniQuery;
    FQryCadFor: TUniQuery;
    FConfig: String;
    FNaoEditar: Boolean;

    procedure pCarregaCentroCusto(ACodigoCentroCusto: String; AEditNomeCentroCusto: TEdit);
    procedure pCarregaCfg(var ACampos: TStringList);
    procedure pCarregaDados;
    procedure pCarregaOcorrencias;
    procedure pCarregaPortador(ACodigoPortador: String; AEditNome: TEdit);
    procedure pGravaLogCarteira(ACfgsAnteriores: TStringList);
    procedure pHideHint;
    procedure pShowHint(AEdit: TEditFocus; ATitulo: String);
    procedure pShowHintBotao(ABotao: TBitBtnLocked; ATitulo: String);

    function fRetornaStringComQuebraDeLinha(AListaString: TStringList): String;
  public
    property blnNaoEditar: Boolean read FNaoEditar write FNaoEditar;
    property strConfig: String read FConfig write FConfig;
  protected
    function fValidaCampos(ASender: TWinControl; ABuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigCapitalFinancas: TfrmConfigCapitalFinancas;

implementation

uses
  untPesqAux, untFuncoesSimples, untFuncoes,
  untCfgGenericas_AutBan, untConsultas, untMemo;

{$R *.dfm}

procedure TfrmConfigCapitalFinancas.btnConfigurarEnter(Sender: TObject);
begin
  inherited;
  btnConfigurar.Hint := 'Configurar percentual de ' + #13+#10 + 'juros para remessa.';
  pShowHintBotao(btnConfigurar, 'Configurações específicas.');
end;

procedure TfrmConfigCapitalFinancas.btnConfigurarExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCapitalFinancas.btnEditarClick(Sender: TObject);
begin
  if ((not fVerificaDireitoAutBan('PERCARBAN')) and (strLoginUsuarioLogado <> '999')) then
  begin
    fMensagem('ATENÇÃO','Usuário sem permissão!', ['&Ok ']);
    Exit;
  end
  else
  begin
    pnlAtivo.Enabled := True;
    pnlComplemento.Enabled := pnlAtivo.Enabled;
    pnlComplemento.Enabled := True;
    if tbsEncBan.tabVisible then
      pnlAtivo2.Enabled := True;
    btnGravar.Enabled := True;
    btnConfigurar.Enabled := True;
    btnEditar.Visible := False;
    btnCancelar.Visible := true;

    if edtProxNumArqRem.Enabled then
      pSetFocus(edtProxNumArqRem)
    else
      pSetFocus(edtExpBol);
  end;
end;

procedure TfrmConfigCapitalFinancas.btnEdtOcoClick(Sender: TObject);
var
  ABackupRecNo: Integer;
begin
  inherited;
  ABackupRecNo := 0;
  if not cdsCnfOco.isEmpty then
  begin
    pMensagemOk('É necessário possuir um registro selecionado para editar!');
    Exit;
  end;

  ABackupRecNo := cdsCnfOco.RecNo;
  frmCadOcoCartei := TfrmCadOcoCartei.Create(nil);
  try
    frmCadOcoCartei.strCartei := 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp;
    frmCadOcoCartei.blnEditar := True;
    frmCadOcoCartei.edtCodOco.Text := cdsCnfOcoCNF_CODOCO.AsString;
    frmCadOcoCartei.fraPlanoDeContasOco.MskCodCta.Text := Copy(cdsCnfOcoCNF_PLNCON.AsString,1,7);
    frmCadOcoCartei.cmbTipDes.ItemIndex := cdsCnfOcoCNF_TIPDES.AsInteger;
    frmCadOcoCartei.edtMotOco.Visible := True;
    frmCadOcoCartei.edtMotOco.Text := cdsCnfOcoCNF_MOTOCO.AsString;
    frmCadOcoCartei.blnValidaMotOco := False;

    if cdsCnfOcoCNF_CODOCO.AsString = '02' then
      frmCadOcoCartei.cmbTipDes.Visible := True;

    if cdsCnfOcoCNF_CODOCO.AsString = '02' then
      frmCadOcoCartei.lblTipDes.Visible := True;

    frmCadOcoCartei.ShowModal;
  finally
    FreeAndNil(frmCadOcoCartei);
  end;

  pCarregaOcorrencias;

  if ABackupRecNo > 0 then
  begin
    cdsCnfOco.DisableControls;
    cdsCnfOco.RecNo := ABackupRecNo;
    cdsCnfOco.EnableControls;
  end;
end;

procedure TfrmConfigCapitalFinancas.btnGravarClick(Sender: TObject);
var
  LCfgsAnteriores: TStringList;
begin
  inherited;

  if not fVerificaCampos then
    Exit;

  if FNaoEditar then
  begin
    Close;
    ModalResult := mrOk;
    Exit;
  end;

  if (chkCartSeq.Checked) then
  begin
    if edtProxNumArqRem.Text <> fRetProxNumAutBan('CONFIG978-' + edtCartSeq.Text) then
    begin
      if fMensagem('ATENÇÃO','Ao utilizar a sequência do arquivo de remessa de outra carteira, o campo Último Núm. de Seq. Arq. Remessa será sobrescrito pelo da carteira principal. Deseja continuar?',['&SIM', '&NÃO'], 1) = 2 then
        Exit;
    end;
  end;

  LCfgsAnteriores := TStringList.Create;
  try
    try
      pCarregaCfg(LCfgsAnteriores);
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', IIF(chkCartSeq.Checked, fRetProxNumAutBan('CONFIG978-' + edtCartSeq.Text), edtProxNumArqRem.Text));
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'CODEMPR', edtCodEmpBanco.Text   );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', edtCodCar.Text        );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text    );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', edtDigAge.Text        );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text     );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', edtDigCtaCor.Text     );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMAUTO', edtNumAutBco.Text     );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text      );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text          );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', LeftStr(cmbInstrucao1.Text,2));
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTPER', LeftStr(cmbInstruPersonalizada.Text,2));
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text   );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text   );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text   );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text   );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text   );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPCOBR', edtTipoCob.Text       );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessaBDC.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetornoBDC.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text        );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'SOLIDTA', edtSolDta.Text       );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'DIASCREDITOTARIFA', edtDiasCreditoTarifa.Text       );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text       );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContas.MskCodCta.Text);
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text      );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text        );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'DUPEMPLOG', edtDupEmpLog.Text       );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', edtPerImpBol.Text       );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPOBOL', edtExpBol.Text        );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', edtPerMul.Text        );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'varNOMREM', edtvarNomRem.Text        );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text        );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'OUTACRE', edtOutAcr.Text        );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'MANDMSG', edtMandMsg.Text       );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', IIF(chkCartSeq.Checked, 'S', 'N'));
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', IIF(chkCartSeq.Checked, edtCartSeq.Text, ''));
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', edtUsaSac.Text        );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'UTLDESDUP', edtUtlDesDup.Text   );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'UTILIZA_ALPE', edtUtilizaAlpe.Text   );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', edtDesBen.Text        );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'endEBEN', edtendBen.Text        );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', edtBaiBen.Text        );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', edtCompBen.Text       );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', edtCidBen.Text        );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', edtEstBen.Text        );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', edtCepBen.Text        );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', edtCgCBen.Text        );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'EXIBMSG', edtExibMsg.Text       );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'DTACRED', edtDtaCre.Text        );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'OCOIGNORA', fraCheckComboBoxOcorrencia.fGetOcorrencias);
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', edtPorTar.Text    );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', fraPlanoDeContasEnc.MskCodCta.Text);
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', edtForTar.Text    );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', edtValorTarifa.Text  );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'DSNAME', edtDsName.Text         );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'ESPDOCBOL', edtEspecieDocumento.Text         );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'PERALPE', edtPercentualAlpe.Text );
      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'TEDALPE', edtTarifaTed.Text );

      if edtUtilizaAlpe.Text = 'N' then
      begin
        fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'PERALPE', '0,00' );
        fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'TEDALPE', '0,00' );
      end;

      fGetBancoConfig(1, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'UTILIZA_EXTRANT', edtUtilizaExtrant.Text   );

      if not (btnGravar.Caption = '&OK') then
      begin
        pBackupCnfBco;
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        edtProxNumArqRem.Enabled := False;
        pSetFocus(edtExpBol);
        pnlAtivo.Enabled  := False;
        pnlComplemento.Enabled := pnlAtivo.Enabled;
        if tbsEncBan.tabVisible then
          pnlAtivo2.Enabled := False;
        btnGravar.Enabled := False;
        btnConfigurar.Enabled := False;
        btnEditar.Visible := True;
        btnCancelar.Visible := False;
        pSetFocus(btnEditar);
      end
      else
      begin
        Close;
        ModalResult := mrOk;
      end;

      pGravaLogCarteira(LCfgsAnteriores);

      pCarregaDados;
    except
      on E:Exception do
      begin
        fMensagem('Erro','Ocorreu um erro ao tentar salvar os dados.' + #13 + E.Message,['&O K']);
      end;
    end;
  finally
    FreeAndNil(LCfgsAnteriores);
  end;
end;

procedure TfrmConfigCapitalFinancas.pCarregaDados;
begin
  if fEmptyStr(fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '')) then
  begin
    edtProxNumArqRem.Enabled := True;
    edtProxNumArqRem.Clear;
    pSetFocus(edtProxNumArqRem);
  end
  else
  begin
    edtProxNumArqRem.Text  := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '');
    edtProxNumArqRem.Enabled := False;
    pSetFocus(edtExpBol);
  end;

  if (strLoginUsuarioLogado='997') or(strLoginUsuarioLogado='998') or (strLoginUsuarioLogado='999') then
  begin
    edtProxNumArqRem.Enabled := True;
    pSetFocus(edtProxNumArqRem);
  end;

  edtCodEmpBanco.Text    := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'CODEMPR', '');
  edtCodCar.Text         := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', '');
  edtCodAgencia.Text     := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtContaCorr.Text      := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', '');
  edtDigCtaCor.Text      := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', '');
  edtNumAutBco.Text      := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMAUTO', '');
  edtDiasProt.Text       := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '');
  edtResp.Text           := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', '');

  if not fEmptyStr(fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '')) then
  begin
    case StrToInt(fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '')) of
      00 : cmbInstrucao1.ItemIndex := 0;
      05 : cmbInstrucao1.ItemIndex := 1;
      06 : cmbInstrucao1.ItemIndex := 2;
      07 : cmbInstrucao1.ItemIndex := 3;
      08 : cmbInstrucao1.ItemIndex := 4;
      09 : cmbInstrucao1.ItemIndex := 5;
      10 : cmbInstrucao1.ItemIndex := 6;
      11 : cmbInstrucao1.ItemIndex := 7;
      12 : cmbInstrucao1.ItemIndex := 8;
      13 : cmbInstrucao1.ItemIndex := 9;
      14 : cmbInstrucao1.ItemIndex := 10;
      15 : cmbInstrucao1.ItemIndex := 11;
      18 : cmbInstrucao1.ItemIndex := 12;
    end;
  end
  else
    cmbInstrucao1.ItemIndex := -1;

  if not fEmptyStr(fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTPER', '')) then
  begin
    case StrToInt(fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTPER', '')) of
      00 : cmbInstruPersonalizada.ItemIndex := 0;
      05 : cmbInstruPersonalizada.ItemIndex := 1;
      06 : cmbInstruPersonalizada.ItemIndex := 2;
      07 : cmbInstruPersonalizada.ItemIndex := 3;
      08 : cmbInstruPersonalizada.ItemIndex := 4;
      09 : cmbInstruPersonalizada.ItemIndex := 5;
      10 : cmbInstruPersonalizada.ItemIndex := 6;
      11 : cmbInstruPersonalizada.ItemIndex := 7;
      12 : cmbInstruPersonalizada.ItemIndex := 8;
      13 : cmbInstruPersonalizada.ItemIndex := 9;
      14 : cmbInstruPersonalizada.ItemIndex := 10;
      15 : cmbInstruPersonalizada.ItemIndex := 11;
      18 : cmbInstruPersonalizada.ItemIndex := 12;
    end;
  end
  else
    cmbInstruPersonalizada.ItemIndex := -1;

  edtDesPor.Text := '';
  edtDescPorRem.Text := '';
  fraPlanoDeContas.edtDesCta.Text := '';

  edtObservacao1.Text    := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text    := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text    := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text    := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text    := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');
  edtTipoCob.Text        := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPCOBR', '');
  fraPathRemessaBDC.edtDirectory.text := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '');
  fraPathRetornoBDC.edtDirectory.text := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '');
  edtCodPor.Text         := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  edtCodPorRem.Text      := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');
  fraPlanoDeContas.MskCodCta.Text := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');
  edtDiasCred.Text       := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', '');
  edtProAce.Text         := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', '');
  edtDupEmpLog.Text     :=  fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1),'DUPEMPLOG','');
  edtDigAge.Text         := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', '');
  edtExpBol.Text         := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPOBOL', '');
  edtPerMul.Text         := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', '');
  edtvarNomRem.Text      := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'varNOMREM', '');
  edtSolDta.Text         := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'SOLIDTA', 'N');
  edtSolDta.Text         := IIF(fEmptyStr(edtSolDta.Text), 'N', edtSolDta.Text);
  edtDiasCreditoTarifa.Text         := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'DIASCREDITOTARIFA', 'N');
  edtDiasCreditoTarifa.Text         := IIF(fEmptyStr(edtDiasCreditoTarifa.Text), 'N', edtDiasCreditoTarifa.Text);
  edtInfAdi.Text         := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', '');
  edtOutAcr.Text         := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'OUTACRE', '');
  edtMandMsg.Text        := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'MANDMSG', '');
  chkCartSeq.Checked     := (fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', '') = 'S');
  edtCartSeq.Text        := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', '');
  edtExibMsg.Text        := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'EXIBMSG', '');
  edtExibMsg.Text        := IIF(fEmptyStr(edtExibMsg.Text), 'S', edtExibMsg.Text);
  edtDtaCre.Text         := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'DTACRED', 'N');
  fraCheckComboBoxOcorrencia.pSetOcorrencias(fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'OCOIGNORA', ''));
  edtPercentualAlpe.Text := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'PERALPE', '');
  edtTarifaTed.Text      := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'TEDALPE', '');

  //Dados Beneficiário
  edtUsaSac.Text        := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', '');
  edtUsaSac.Text        := IIF(fEmptyStr(edtUsaSac.Text), 'N', edtUsaSac.Text);
  edtDesBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', ''), '');
  edtendBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'endEBEN', ''), '');
  edtBaiBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', ''), '');
  edtCompBen.Text       := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', ''), '');
  edtCidBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', ''), '');
  edtEstBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', ''), '');
  edtCepBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', ''), '');
  edtCgcBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', ''), '');
  edtUtlDesDup.Text := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'UTLDESDUP', '');
  if fEmptyStr(edtUtlDesDup.Text) then
    edtUtlDesDup.Text := 'S';

  if fEmptyStr(edtDupEmpLog.Text) then
    edtDupEmpLog.Text := 'N';

  edtPerImpBol.Text     := fGetBancoConfig(0,'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', '');
  if fEmptyStr(edtPerImpBol.Text) then
    edtPerImpBol.Text := 'S';

  edtDsName.Text := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'DSNAME', '');
  if fEmptyStr(edtDsName.Text) then
    edtDsName.Text := 'N';

  edtUtilizaAlpe.Text := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'UTILIZA_ALPE', '');
  if fEmptyStr(edtUtilizaAlpe.Text) Or (not pnlAlpe.Visible) then
    edtUtilizaAlpe.Text := 'N';

  edtEspecieDocumento.Text := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'ESPDOCBOL', '');
  if fEmptyStr(edtEspecieDocumento.Text) then
    edtEspecieDocumento.Text := 'N';

  edtUtilizaExtrant.Text := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'UTILIZA_EXTRANT', '');
  if fEmptyStr(edtUtilizaExtrant.Text) Or (not pnlExtrant.Visible) then
    edtUtilizaExtrant.Text := 'N';

  fValidaCampos(edtUsaSac);

  chkCartSeq.OnClick(chkCartSeq);

  if edtTipoCob.Text = 'S' then
  begin
    edtNumAutBco.Enabled := False;
    edtNumAutBco.Clear;
  end
  else
    edtNumAutBco.Enabled := True;

  edtDesPor.Clear;
  if not fEmptyStr( edtCodPor.Text ) then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  if not fEmptyStr( edtCodPorRem.Text ) then
    pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);

  fraPlanoDeContas.edtDesCta.Clear;
  if not fEmptyStr( fraPlanoDeContas.MskCodCta.Text ) then
    pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);

  edtPorTar.Text         := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', '');
  fraPlanoDeContasEnc.MskCodCta.Text := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', '');
  edtForTar.Text         := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', '');
  edtValorTarifa.Text    := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', '');

  edtDesPorTar.Clear;
  if not fEmptyStr( edtPorTar.Text ) then
    pCarregaPortador(edtPorTar.Text, edtDesPorTar);

  fraPlanoDeContasEnc.edtDesCta.Clear;
  if not fEmptyStr( fraPlanoDeContasEnc.MskCodCta.Text ) then
    pCarregaCentroCusto(fraPlanoDeContasEnc.MskCodCta.Text, fraPlanoDeContasEnc.edtDesCta);

  edtDesForTar.Clear;
  if not fEmptyStr( edtForTar.Text ) then
  begin
    pPesquisaCadFor(FQryCadFor, FQryCadFor, edtForTar.Text);
    edtDesForTar.Text  := FQryCadFor.FieldByName('FOR_NOMFOR').AsString;
  end;

  pCarregaOcorrencias;

end;

procedure TfrmConfigCapitalFinancas.pCarregaOcorrencias;
var
  LListaOcorrencias: TObjectList<TCnfOco>;
  LOcorrencia: TCnfOco;
  LDaoOcorrencia: TCnfOcoDao;
  LCodigoBanco,
  LTipoLayout,
  LQtdCaracteresLayout,
  LEspecificacao,
  LCodigoEmpresa: String;
  LNumeroCarteira: Integer;
begin
  cdsCnfOco.DisableControls;

  if cdsCnfOco.Active then
  begin
    cdsCnfOco.EmptyDataSet;
    cdsCnfOco.Close;
  end;

  cdsCnfOco.CreateDataset;
  cdsCnfOco.Open;

  pDesmembraCarteira(
    'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp, LCodigoBanco,
    LTipoLayout, LQtdCaracteresLayout, LEspecificacao, LCodigoEmpresa, LNumeroCarteira);

  LDaoOcorrencia := TCnfOcoDao.Create(LCodigoBanco, LTipoLayout, LQtdCaracteresLayout, LEspecificacao, LCodigoEmpresa, LNumeroCarteira);
  LListaOcorrencias := LDaoOcorrencia.fBuscaTodas;
  try
    if LListaOcorrencias.Count = 0 then
      Exit;

    for LOcorrencia in LListaOcorrencias do
    begin
      cdsCnfOco.Append;
      cdsCnfOcoCNF_CODOCO.AsString := LOcorrencia.strCodOco;
      cdsCnfOcoCNF_DESOCO.AsString := LOcorrencia.strDesOco;
      cdsCnfOcoCNF_GERPAG.Value    := LOcorrencia.blnGerpag;
      cdsCnfOcoCNF_CUSCAR.Value    := LOcorrencia.blnCusCar;
      cdsCnfOcoCNF_GERREC.Value    := LOcorrencia.blnGerRec;
      cdsCnfOcoCNF_FORNEC.AsString := LOcorrencia.strCodFor + ' - ' + fRetNomFornecedor(LOcorrencia.strCodFor);
      cdsCnfOcoCNF_PORTAD.AsString := LOcorrencia.strCodPor + ' - ' + fRetNomPortador(LOcorrencia.strCodPor);
      cdsCnfOcoCNF_PLNCON.AsString := LOcorrencia.strCodCta + ' - ' + fRetDescCentroCusto(LOcorrencia.strCodCta);
      cdsCnfOcoCNF_TIPDES.AsInteger:= LOcorrencia.IntTipDes;
      cdsCnfOcoCNF_MOTOCO.AsString := LOcorrencia.strMotOco;

      case LOcorrencia.IntTipDes of
        0: cdsCnfOcoCNF_DSTPDS.AsString := '';
        1: cdsCnfOcoCNF_DSTPDS.AsString := 'TARIFA IOF DESCONTO';
        2: cdsCnfOcoCNF_DSTPDS.AsString := 'TARIFA BOLETO DESC';
        3: cdsCnfOcoCNF_DSTPDS.AsString := 'TARIFA DESCONTADA';
        4: cdsCnfOcoCNF_DSTPDS.AsString := 'EST. DESCONTADA';
      end;
      cdsCnfOco.Post;
    end;
  finally
    FreeAndNil(LListaOcorrencias);
    FreeAndNil(LDaoOcorrencia);
    cdsCnfOco.First;
    cdsCnfOco.EnableControls;
  end;
end;

procedure TfrmConfigCapitalFinancas.FormShow(Sender: TObject);
begin
  inherited;

  fraCheckComboBoxOcorrencia.strCodBco    := '978';
  fraCheckComboBoxOcorrencia.strCnab      := '400';
  fraCheckComboBoxOcorrencia.strCodIgnora := ['06','09'];
  fraCheckComboBoxOcorrencia.pCarregaOcorrencias;

  pCarregaDados;

  if edtProxNumArqRem.Enabled then
    pSetFocus(edtProxNumArqRem)
  else
    pSetFocus(edtExpBol);

  pSetFocus(btnEditar);

  pnlAtivo.Enabled := False;
  pnlAtivo2.Enabled := False;
  pnlComplemento.Enabled := pnlAtivo.Enabled;

  if FNaoEditar then
  begin
    btnConfigurar.Enabled := False;
    btnConfigurar.Visible := False;
    btnGravar.Enabled     := True;
    btnEditar.Visible     := False;
    pSetFocus(btnGravar);
  end;

  pnlAlpe.Visible := fCfgSis('ALPKNK', varBoolean);
  pnlExtrant.Visible := fCfgSis('USAEXT', varBoolean);

  edtUtilizaAlpe.OnChange(edtUtilizaAlpe);
end;

procedure TfrmConfigCapitalFinancas.fraPlanoDeContasEncMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
var
  LArrCentroCusto: TConsultasArray;
begin
  inherited;
  if fPesqCentroCusto(Self, fraPlanoDeContasEnc.MskCodCta, fraPlanoDeContasEnc.edtDesCta, Nil, Key, LArrCentroCusto) then
  begin
    if fValidaCampos(fraPlanoDeContasEnc.MskCodCta) then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmConfigCapitalFinancas.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
var
  LArrCentroCusto: TConsultasArray;
begin
  inherited;
  if fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, LArrCentroCusto) then
    if fValidaCampos(fraPlanoDeContas.MskCodCta) then
      SelectNext(ActiveControl, True, True);
end;

function TfrmConfigCapitalFinancas.fValidaCampos(ASender: TWinControl; ABuscaPorChave: Boolean = True): Boolean;
var
  LMensagemConfig: String;
begin
  if FNaoEditar then
     LMensagemConfig := #13 + 'Por favor acesse a tela de configuração do banco selecionado ' + #13  + ' e corrija as informações necessárias!'
  else
     LMensagemConfig := '';

  Result := True;

  if (inherited fValidaCampos(ASender, ABuscaPorChave)) then
  begin
    if ASender = edtProxNumArqRem then
    begin
      if fEmptyStr(edtProxNumArqRem.Text) then
      begin
        fMensagem('', 'O Último Núm. Arq. Remessa deve conter um valor!'+LMensagemConfig,['&O K']);
        Result := False;
      end
      else
      if StrToInt(edtProxNumArqRem.Text) < 0 then
      begin
        fMensagem('', 'O Último Núm. Arq. Remessa deve ser maior ou igual a zero!'+LMensagemConfig,['&O K']);
        Result := False;
      end;
    end

    else if ASender = edtExpBol then
    begin
      if Pos(edtExpBol.Text, '1_2_') <= 0 then
      begin
        fMensagem('','O campo a ser exportado para o boleto deve ser preenchido com (1/2)!'+LMensagemConfig,['&O K']);
        Result := False;
      end;
    end

    else if ASender = edtTipoCob then
    begin

      if (edtTipoCob.Text <> 'S') And (edtTipoCob.Text <> 'D') then
      begin
        fMensagem('','O campo Tipo de Cobrança deve ser S ou D!'+LMensagemConfig,['&O K']);
        Result := False;
      end;

      if Result then
      begin
        if edtTipoCob.Text = 'S' then
        begin
          edtNumAutBco.Enabled := False;
          edtNumAutBco.Clear;
        end
        else
          edtNumAutBco.Enabled := True;
      end
      else
      begin
        edtNumAutBco.Enabled := False;
        edtNumAutBco.Clear;
      end
    end

    else if (ASender = cmbInstrucao1) then
    begin

      if cmbInstrucao1.ItemIndex = -1 then
      begin
        fMensagem('','O Campo de instrução devem ser preenchidos!'+LMensagemConfig,['&OK']);
        Result := False;
      end
      else if cmbInstrucao1.ItemIndex = 11 then
        edtDiasProt.Clear;
    end

    else if ASender = edtResp then
    begin
      if (edtResp.Text <> 'E') And (edtResp.Text <> 'B') then
      begin
        fMensagem('','O campo Resp. por emissão de boletos deve ser E ou B!'+LMensagemConfig,['&O K']);
        Result := False;
      end;
    end

    else if ASender = edtDsName then
    begin
      if Pos(edtDsName.Text, 'SN') <= 0 then
      begin
        fMensagem('','O campo Utilizar Nomenclatura DSNAME? deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      end;
    end

    else if ASender = edtEspecieDocumento then
    begin
      if Pos(edtEspecieDocumento.Text, 'SN') <= 0 then
      begin
        fMensagem('','O campo Apresentar Esp. Documento no Boleto? deve ser preenchido com (S/N)!',['&OK']);
        Result := False;
      end;
    end

    else if ASender = edtProAce then
    begin
      if Pos(edtProAce.Text, 'S_N_') <= 0 then
      begin
        fMensagem('','O campo Imprime Protocolo de Aceite deve ser preenchido com (S/N)!'+LMensagemConfig,['&O K']);
        Result := False;
      end;
    end

    else if ASender = edtDupEmpLog then
    begin
      if Pos(edtDupEmpLog.Text, 'SN') <= 0 then
      begin
        fMensagem('','O campo Na importação do retorno considerar apenas duplicatas da empresa logada? deve ser preenchido com (S/N)!'+LMensagemConfig,['&O K']);
        Result := False;
      end;
    end

    else if (ASender = edtSolDta) then
    begin
      if Pos(edtSolDta.Text, 'SN') <= 0 then
      begin
        fMensagem('ATENÇÃO!','O campo Solicita data de pagamento deve ser S ou N!'+LMensagemConfig, ['&OK']);
        Result := False;
      end;
    end

    else if (ASender = edtDiasCreditoTarifa) then
    begin
      if Pos(edtDiasCreditoTarifa.Text, 'SN') <= 0 then
      begin
        fMensagem('ATENÇÃO!','O campo Considerar dias para crédito no lançamento de tarifa deve ser S ou N!'+LMensagemConfig, ['&OK']);
        Result := False;
      end;
    end

    else if ASender = edtPerImpBol then
    begin
      if Pos(edtPerImpBol.Text, 'SN') <= 0 then
      begin
        fMensagem('','O campo Permitir impressão de boletos deve ser preenchido com (S/N)!'+LMensagemConfig,['&O K']);
        Result := False;
      end;
    end

    else if (ASender = edtCodPorRem) then
    begin
      if (edtCodPorRem.Text <> EmptyStr) then
      begin
        pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);
        if FQryCadPor.FieldByName('POR_CODPOR').IsNull then
        begin
          fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!'+LMensagemConfig, ['&Ok']);
          Result := False;
        end
        else if not fEmpresaTemAcessoPortador(edtCodPorRem.Text) then
        begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        end
        else if fCfgSis('DACPOR', varBoolean) then
        begin
          if Pos(edtCodPorRem.Text, strPortadoresOperador) <= 0 then
          begin
            fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+LMensagemConfig, ['&Ok']);
            Result := False;
          end;
        end
        else if (not fPortadorPermiteBaixa(edtCodPorRem.Text)) then
        begin
          fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
          Result := False;
        end;
      end
      else
        edtDescPorRem.Clear;
    end

    else if (ASender = edtCodPor) then
    begin
      if fEmptyStr(edtCodPor.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O portador deve ser preenchido!'+LMensagemConfig, ['&Ok']);
        edtDesPor.Clear;
        Result := False;
      end
      else
      begin
        pCarregaPortador(edtCodPor.Text, edtDesPor);
        if FQryCadPor.FieldByName('POR_CODPOR').IsNull then
        begin
          fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!'+LMensagemConfig, ['&Ok']);
          Result := False;
        end
        else if not fEmpresaTemAcessoPortador(edtCodPor.Text) then
        begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        end
        else if fCfgSis('DACPOR', varBoolean) then
        begin
          if Pos(edtCodPor.Text, strPortadoresOperador) <= 0 then
          begin
            fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+LMensagemConfig, ['&Ok']);
            Result := False;
          end;
        end
        else if (not fPortadorPermiteBaixa(edtCodPor.Text)) then
        begin
          fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
          Result := False;
        end;
      end;
    end

    else if (tbsEncBan.TabVisible = True) and (ASender = edtPorTar) then
    begin
      if fEmptyStr(TEditFocus(ASender).Text) then
      begin
        if (not fEmptyStr(edtValorTarifa.Text)) and (fStrToFloat(edtValorTarifa.Text)>0) then
        begin
          fMensagem('', 'O portador para baixa da tarifa deve ser preenchido!'+LMensagemConfig, ['&Ok']);

          if (ASender = edtPorTar) then edtDesPorTar.Clear;

          cxPaginas.ActivePage := tbsEncBan;
          Result := False;
        end;
      end
      else
      begin
        pCarregaPortador(edtPorTar.Text, edtDesPorTar);

        if FQryCadPor.FieldByName('POR_CODPOR').IsNull then
        begin
          fMensagem('', 'Esse portador não está cadastrado!'+LMensagemConfig, ['&Ok']);
          cxPaginas.ActivePage := tbsEncBan;
          Result := False;
        end
        else if not fEmpresaTemAcessoPortador(edtPorTar.Text) then
        begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        end
        else if fCfgSis('DACPOR', varBoolean) then
        begin

          if (Pos(edtPorTar.Text, strPortadoresOperador) <= 0) then
          begin
            if not fEmptyStr(edtDesPorTar.Text) then
            begin
              fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+LMensagemConfig, ['&Ok']);
              Result := False;
            end
          end;
        end;
      end;
    end

    else if (tbsEncBan.TabVisible = True) and  (ASender = fraPlanoDeContasEnc.MskCodCta)  then
    begin
      if fEmptyStr(fraPlanoDeContasEnc.MskCodCta.Text) then
      begin
        if (not fEmptyStr(edtValorTarifa.Text)) and (fStrToFloat(edtValorTarifa.Text)>0) then
        begin
          fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser informado!'+LMensagemConfig, ['&Ok']);
          fraPlanoDeContasEnc.edtDesCta.Clear;
          Result := False;
        end
      end
      else
      begin
        pCarregaCentroCusto(fraPlanoDeContasEnc.MskCodCta.Text, fraPlanoDeContasEnc.edtDesCta);
        if FQryCadCta.FieldByName('CTA_CODCTA').IsNull then
        begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!'+LMensagemConfig, ['&Ok']);
          Result := False;
        end
        else
        begin
          Result := PlanoDeContasAtivo(fraPlanoDeContasEnc.MskCodCta.Text,True);
          fraPlanoDeContasEnc.edtDesCta.Text := FQryCadCta.FieldByName('CTA_DESCTA').AsString;
        end;
      end;

    end

    else if (tbsEncBan.TabVisible = True) And (pnlAlpeTaxas.Visible) And (ASender = edtTarifaTed) then
    begin
      if fEmptyStr(edtTarifaTed.Text) then
      begin
        fMensagem('ATENÇÃO','O campo tarifa TED Alpe deve ser preenchido!'+LMensagemConfig,['&OK']);
        Result := False;
      end
      else
        edtTarifaTed.Text := FormatFloat(',0.00', fStrToFloat(edtTarifaTed.Text));
    end

    else if (tbsEncBan.TabVisible = True) And (ASender = edtPercentualAlpe) then
    begin
      if not fValidaEscala(edtPercentualAlpe.Text, 0, 99.9) then
      begin
        fMensagem('ATENÇÃO','O campo percentual de desconto Alpe deve estar entre 0 e 99,90!'+LMensagemConfig,['&OK']);
        Result := False;
      end
      else
        edtPercentualAlpe.Text := FormatFloat(',0.00', fStrToFloat(edtPercentualAlpe.Text))
    end

    else if (tbsEncBan.TabVisible = True) and  (ASender = edtForTar)  then
    begin
      if fEmptyStr(edtForTar.Text) then
      begin
        if (not fEmptyStr(edtValorTarifa.Text)) and (fStrToFloat(edtValorTarifa.Text)>0) then
        begin
          fMensagem('ATENÇÃO','O Código do fornecedor para baixa da tarifa bancária deve ser preenchido!'+LMensagemConfig,['&OK']);
          Result := False;
        end;
      end
      else
      begin
        pPesquisaCadFor(FQryCadFor, FQryCadFor, edtForTar.Text);

        if FQryCadFor.FieldByName('FOR_CODFOR').IsNull then
        begin
          fMensagem('', 'Esse fornecedor não está cadastrado!'+LMensagemConfig, ['&Ok']);
          cxPaginas.ActivePage := tbsEncBan;
          Result := False;
        end
        else
          edtDesForTar.Text  := FQryCadFor.FieldByName('FOR_NOMFOR').AsString;
      end;
    end

    else if (ASender = fraPlanoDeContas.MskCodCta) then
    begin
      if fEmptyStr(fraPlanoDeContas.MskCodCta.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser informado!'+LMensagemConfig, ['&Ok']);
        fraPlanoDeContas.edtDesCta.Clear;
        Result := False;
      end
      else
      begin
        pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);
        if FQryCadCta.FieldByName('CTA_CODCTA').IsNull then
        begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!'+LMensagemConfig, ['&Ok']);
          Result := False;
        end
        else
          Result := PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text,True);
      end;
    end

    else if (ASender = edtContaCorr) then
    begin
      if fEmptyStr(edtContaCorr.Text) then
      begin
        fMensagem('ATENÇÃO','O Número Conta Corrente deve ser preenchido!'+LMensagemConfig,['&OK']);
        Result := False;
      end
      else if Length(edtContaCorr.Text) <> edtContaCorr.MaxLength then
      begin
        fMensagem('ATENÇÃO','O Número Conta Corrente deve ter 7 caracteres!',['&OK']);
        Result := False;
      end;
    end

    else if (ASender = edtDigCtaCor) then
    begin
      if fEmptyStr(edtDigCtaCor.Text) then
      begin
        fMensagem('ATENÇÃO','O Dígito da Conta Corrente deve ser preenchido!'+LMensagemConfig,['&OK']);
        Result := False;
      end;
    end

    else if (ASender = edtPerMul) then
    begin
      if not fValidaEscala(edtPerMul.Text, 0, 100) then
      begin
        fMensagem('ATENÇÃO','O campo percentual de multa deve estar entre 0 e 100!'+LMensagemConfig,['&OK']);
        Result := False;
      end;
    end

    else if ASender = edtMandMsg then
    begin
      if Pos(edtMandMsg.Text, 'S_N_') <= 0 then
      begin
        fMensagem('ATENÇÃO','Enviar Mensagem (Agrupamento) deve ser preenchido com (S/N)!'+LMensagemConfig,['&O K']);
        Result := False;
      end;
    end

    else if ASender = edtExibMsg then
    begin
      if Pos(edtExibMsg.Text, 'S_N_') <= 0 then
      begin
        fMensagem('ATENÇÃO','"Exibir Núm. Dupl. Agrupadas" deve ser preenchido com (S/N)!'+LMensagemConfig,['&O K']);
        Result := False;
      end;
    end

    else if ASender = edtDtaCre then
    begin
      if Pos(edtDtaCre.Text, 'S_N_') <= 0 then
      begin
        fMensagem('ATENÇÃO','"Utiliza data de crédito para movimentação" deve ser preenchido com (S/N)!'+LMensagemConfig,['&O K']);
        Result := False;
      end;
    end

    else if ASender = edtCodCar then
    begin
      if fEmptyStr(edtCodCar.Text) then
      begin
        fMensagem('ATENÇÃO','O Campo Código da Carteira deve ser preenchido!'+LMensagemConfig,['&O K']);
        Result := False;
      end
      else if Length(edtCodCar.Text) < 3 then
      begin
        fMensagem('ATENÇÃO','O Campo Código da Carteira deve possuir 3 dígitos!'+LMensagemConfig,['&O K']);
        Result := False;
      end;
    end

    else if (ASender = edtCodEmpBanco) then
    begin
      if fEmptyStr(edtCodEmpBanco.Text) then
      begin
        fMensagem('ATENÇÃO','O Campo Cedente deve ser preenchido!'+LMensagemConfig,['&O K']);
        Result := False;
      end
      else if Length(edtCodEmpBanco.Text) <> edtCodEmpBanco.MaxLength then
      begin
        fMensagem('ATENÇÃO','O Campo Cedente deve ter 8 caracteres!'+LMensagemConfig,['&O K']);
        Result := False;
      end;
    end

    else if (ASender = edtCodAgencia) then
    begin
      if fEmptyStr(edtCodAgencia.Text) then
      begin
        fMensagem('ATENÇÃO','O campo Código da Agência deve ser preenchido!'+LMensagemConfig,['&O K']);
        Result := False;
      end
      else if Length(edtCodAgencia.Text) <> edtCodAgencia.MaxLength then
      begin
        fMensagem('ATENÇÃO','O campo Código da Agência deve ter 5 caracteres!'+LMensagemConfig,['&O K']);
        Result := False;
      end;
    end

    else if (ASender = edtDigAge) then
    begin
      if fEmptyStr(edtDigAge.Text) then
      begin
        fMensagem('ATENÇÃO','O campo Dígito da Agência deve ser preenchido!'+LMensagemConfig,['&O K']);
        Result := False;
      end;
    end

    else if (ASender = edtNumAutBco) then
    begin
      if edtTipoCob.Text = 'D' then
      begin
        if fEmptyStr(edtNumAutBco.Text) then
        begin
          fMensagem('ATENÇÃO','O campo Número de Autorização do Banco deve ser preenchido!'+LMensagemConfig,['&O K']);
          Result := False;
        end
        else if Length(edtNumAutBco.Text) <> edtNumAutBco.MaxLength then
        begin
          fMensagem('ATENÇÃO','O campo Número de Autorização do Banco deve ter 4 caracteres!'+LMensagemConfig,['&O K']);
          Result := False;
        end;
      end;
    end

    else if (ASender = edtDiasProt) then
    begin
      if cmbInstrucao1.ItemIndex in [1,2,3,12] then
      begin
        if fEmptyStr(edtDiasProt.Text) then
        begin
          fMensagem('ATENÇÃO','O campo Dias para protesto/decurso deve ser preenchido!'+LMensagemConfig,['&O K']);
          Result := False;
        end
        else if (StrToInt(edtDiasProt.Text) < 5) And (cmbInstrucao1.ItemIndex <> 12) then
        begin
          fMensagem('ATENÇÃO','A quantidade de dias informada deve ser de no mínimo 5 dias!'+LMensagemConfig,['&O K']);
          Result := False;
        end;
      end;
    end

    else if (ASender = chkCartSeq) then
    begin
      if (chkCartSeq.Checked) then
      begin
        if fVerificaCartPrimariaAutBan('CONFIG978-', tabCarteira.TabIndex + 1) then
        begin
          fMensagem('ATENÇÃO','Não pode ser utilizada sequência de Arquivo de Remessa de outra carteira, pois essa está cadastrada no campo Carteira Seq. de outra(s) carteira(s).' ,['&O K']);
          Result := False;
        end;
      end;
    end

    else if (ASender = edtCartSeq) then
    begin
      if (chkCartSeq.Checked) then
      begin
        if fEmptyStr(edtCartSeq.Text) then
        begin
          fMensagem('ATENÇÃO','O campo Carteira Seq. deve ser preenchido!' ,['&O K']);
          Result := False;
        end
        else
        begin
          if (Pos(edtCartSeq.Text, '1_2_3_4_5_') <= 0) then
          begin
            fMensagem('ATENÇÃO','O campo Carteira Seq. deve ter valor entre 1 e 5!' ,['&O K']);
            Result := False;
          end
          else
          if edtCartSeq.Text = IntToStr(tabCarteira.TabIndex + 1) then
          begin
            fMensagem('ATENÇÃO','O campo Carteira Seq. não pode ser igual a carteira selecionada!' ,['&O K']);
            Result := False;
          end
          else
          if fEmptyStr(fGetBancoConfig(0, 'CONFIG978-' + edtCartSeq.Text, 'PROXNUM', '')) then
          begin
            fMensagem('ATENÇÃO','Não pode ser usada essa carteira no campo Carteira Seq., pois essa não possui Último Núm. Seq. Remessa cadastrado!' ,['&O K']);
            Result := False;
          end
          else
          if fVerificaCartFilhaAutBan('CONFIG978-' + edtCartSeq.Text) then
          begin
            fMensagem('ATENÇÃO','Não pode ser usada essa carteira no campo Carteira Seq., pois essa já possui uma Carteira Seq. cadastrada!' ,['&O K']);
            Result := False;
          end;
        end;
      end;
    end

    else if ASender = edtUsaSac then
    begin
      if Pos(edtUsaSac.Text, 'S_N_') <= 0 then
      begin
        fMensagem('','O campo Enviar Sacador/Avalista deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      end;

      grpBeneficiario.Enabled := edtUsaSac.Text = 'S';
    end

    else if ASender = edtUtlDesDup then
    begin
      if Pos(edtUtlDesDup.Text, 'SN') <= 0 then
      begin
        fMensagem('','O campo Utl. Desconto de Duplicatas? deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      end;
    end

    else if ASender = edtUtilizaAlpe then
    begin
      if Pos(edtUtilizaAlpe.Text, 'SN') <= 0 then
      begin
        fMensagem('','O campo Utilizar integração Alpe? deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      end;
    end

    else if ASender = edtUtilizaExtrant then
    begin
      if Pos(edtUtilizaExtrant.Text, 'SN') <= 0 then
      begin
        fMensagem('','O campo Utilizar integração Extrant? deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      end;
    end

    else if ASender = edtDesBen then
    begin
      if (fEmptyStr(edtDesBen.Text)) And (edtUsaSac.Text = 'S') then
      begin
        fMensagem('ATENÇÃO','O campo Beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      end
    end

    else if ASender = edtendBen then
    begin
      if (fEmptyStr(edtendBen.Text)) And (edtUsaSac.Text = 'S') then
      begin
        fMensagem('ATENÇÃO','O campo endereço do beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      end
    end

    else if ASender = edtBaiBen then
    begin
      if (fEmptyStr(edtBaiBen.Text)) And (edtUsaSac.Text = 'S') then
      begin
        fMensagem('ATENÇÃO','O campo Bairro do beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      end
    end

    else if ASender = edtCidBen then
    begin
      if (fEmptyStr(edtCidBen.Text)) And (edtUsaSac.Text = 'S') then
      begin
        fMensagem('ATENÇÃO','O campo Cidade do beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      end
    end

    else if ASender = edtEstBen then
    begin
      if (fEmptyStr(edtEstBen.Text)) And (edtUsaSac.Text = 'S') then
      begin
        fMensagem('ATENÇÃO','O campo Estado do beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      end
    end

    else if ASender = edtCepBen then
    begin
      if (edtUsaSac.Text = 'S') then
      begin
        if (fEmptyStr(fRetSomenteNumeros(edtCepBen.Text))) then
        begin
          fMensagem('ATENÇÃO','O campo CEP do beneficiário deve ser preenchido!' ,['&O K']);
          Result := False;
        end
        else if Length(fRetSomenteNumeros(edtCepBen.Text)) < 8 then
        begin
          fMensagem('ATENÇÃO','O campo CEP do beneficiário deve ser preenchido com 8 números!' ,['&O K']);
          Result := False;
        end;
      end;
    end

    else if ASender = edtCgcBen then
    begin
      if (edtUsaSac.Text = 'S') then
      begin
        if (fEmptyStr(fTiraCaracEspeciaisPonto(edtCgcBen.Text))) then
        begin
          fMensagem('ATENÇÃO','O campo CNPJ do beneficiário deve ser preenchido!' ,['&O K']);
          Result := False;
        end
        else if (Length(fTiraCaracEspeciaisPonto(edtCgcBen.Text)) < 14) Or (not fValidaCnpjCpf(edtCgcBen.Text)) then
        begin
          fMensagem('ATENÇÃO','O campo CNPJ do beneficiário deve conter um número válido!' ,['&O K']);
          Result := False;
        end;
      end;
    end;
  end;

  if not Result then
  begin
    if not FNaoEditar then
    begin
      cxPaginas.ActivePage := RetornaAbaDoComponete(ASender);
      pSetFocus(ASender);
    end;
  end;
end;

procedure TfrmConfigCapitalFinancas.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
  cxPaginas.ActivePage := tbsGeral;
end;

procedure TfrmConfigCapitalFinancas.tabCarteiraChanging(Sender: TObject;
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

procedure TfrmConfigCapitalFinancas.edtCodPorKeyPress(Sender: TObject; var Key: Char);
var
  LArrSel: TConsultasArray;
begin
  inherited;
  if fEntraCons(Key) then
  begin
    if fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, nil, Key, LArrSel) then
    begin
      if fValidaCampos(edtCodPor, True) then
        Self.SelectNext(ActiveControl, True, True);
    end;
  end;
end;

procedure TfrmConfigCapitalFinancas.edtCodPorRemKeyPress(Sender: TObject;
  var Key: Char);
var
  LArrSel: TConsultasArray;
begin
  inherited;

  if fEntraCons(Key) then
  begin
    if fPesqPortador(conSimples, Self, edtCodPorRem, edtDescPorRem, nil, Key, LArrSel) then
    begin
      if fValidaCampos(edtCodPorRem, True) then
        Self.SelectNext(ActiveControl, True, True);
    end;
  end;
end;

procedure TfrmConfigCapitalFinancas.edtDiasCredEnter(Sender: TObject);
begin
  inherited;
  edtDiasCred.Hint := 'Informar quantidade de dias ' + #13+#10 +
                      'do intervalo entre a efetuação ' + #13+#10 +
                      'do pagamento e o crédito na ' + #13+#10 +
                      'conta corrente.';

  pShowHint(edtDiasCred, 'Dias para Crédito');
end;

procedure TfrmConfigCapitalFinancas.edtDiasCredExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCapitalFinancas.edtDtaCreExit(Sender: TObject);
begin
  inherited;
  if not fEmptyStr(edtDiasCred.Text) then
  begin
    if (edtDtaCre.Text = 'S') And (StrToInt(edtDiasCred.Text) > 0 ) then
    begin
      fMensagem('Aviso', 'Para utilizar a data de crédito como movimentação não é permitido informar a configuração quantidade de dias para crédito!', ['&O k']);
      edtDtaCre.Text := 'N';
    end;
  end;
end;

procedure TfrmConfigCapitalFinancas.edtForTarKeyPress(Sender: TObject; var Key: Char);
var
  LArrFornec: TConsultasArray;
begin
  inherited;
  if fPesqFornecedor(conForCompleta, Self, edtForTar, edtDesForTar, Nil, Key, LArrFornec) then
  begin
    if fValidaCampos(edtForTar, True) then
      SelectNext(ActiveControl, True, True);
  end;
end;


procedure TfrmConfigCapitalFinancas.edtPorTarKeyPress(Sender: TObject; var Key: Char);
var
  LArrSel: TConsultasArray;
begin
  inherited;
  if fEntraCons(Key) then
  begin
    if fPesqPortador(conSimples, Self, edtPorTar, edtDesPorTar, nil, Key, LArrSel) then
      Self.SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmConfigCapitalFinancas.edtUsaSacExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtUsaSac);
end;

procedure TfrmConfigCapitalFinancas.edtUtilizaAlpeChange(Sender: TObject);
begin
  inherited;
  pnlAlpeTaxas.Visible := edtUtilizaAlpe.Text = 'S';
end;

procedure TfrmConfigCapitalFinancas.pCarregaCentroCusto(ACodigoCentroCusto: String; AEditNomeCentroCusto: TEdit);
begin
  pPesquisaCadCta(FQryCadCta, FQryCadCta, ACodigoCentroCusto);
  AEditNomeCentroCusto.Text := FQryCadCta.FieldByName('CTA_DESCTA').AsString;
end;

procedure TfrmConfigCapitalFinancas.pCarregaPortador(ACodigoPortador: String; AEditNome: TEdit);
begin
  pPesquisaCadPor(Nil, FQryCadPor, ACodigoPortador);
  AEditNome.Text := FQryCadPor.FieldByName('POR_NOMPOR').AsString;
end;

procedure TfrmConfigCapitalFinancas.pHideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmConfigCapitalFinancas.pShowHint(AEdit: TEditFocus; ATitulo: String);
begin
  HintControler.ShowHint(AEdit.ClientOrigin.X,AEdit.ClientOrigin.Y, ATitulo, AEdit.Hint);
end;

procedure TfrmConfigCapitalFinancas.pShowHintBotao(ABotao: TBitBtnLocked; ATitulo: String);
begin
  HintControler.ShowHint(ABotao.ClientOrigin.X,ABotao.ClientOrigin.Y, ATitulo, ABotao.Hint);
end;

function TfrmConfigCapitalFinancas.RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;
begin
  while not Sender.ClassName.Equals('TcxTabSheet') do
    Sender := Sender.Parent;
  Result := TcxTabSheet(Sender);
end;

procedure TfrmConfigCapitalFinancas.FormCreate(Sender: TObject);
begin
  inherited;
  FQryCadPor := fCriaQuery(Self);
  FQryCadCta := fCriaQuery(Self);
  FQryCadFor := fCriaQuery(Self);
  pCarKeyAutBan;

  cxPaginas.Properties.ActivePage := tbsGeral;

  if fCfgSis('ENCBAN', varBoolean) then
    tbsEncBan.TabVisible := True
  else
    tbsEncBan.TabVisible := False;
end;

procedure TfrmConfigCapitalFinancas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_Escape) then
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

procedure TfrmConfigCapitalFinancas.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCapitalFinancas.btnAddOcoClick(Sender: TObject);
begin
  inherited;
  frmCadOcoCartei := TfrmCadOcoCartei.Create(nil);
  try
    frmCadOcoCartei.strCartei := 'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp;
    frmCadOcoCartei.cmbTipDes.Visible := True;
    frmCadOcoCartei.cmbTipDes.Enabled := True;
    frmCadOcoCartei.lblTipDes.Visible := True;
    frmCadOcoCartei.edtMotOco.Visible := True;
    frmCadOcoCartei.edtMotOco.Enabled := True;
    frmCadOcoCartei.blnValidaMotOco := False;
    frmCadOcoCartei.ShowModal;
  finally
    FreeAndNil(frmCadOcoCartei);
  end;
  pCarregaOcorrencias;
end;

procedure TfrmConfigCapitalFinancas.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if not fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do registro da carteira selecionada?', ['&S i m', '&N ã o'], 2) = 1 then
    Exit;

  cxPaginas.ActivePage :=  tbsGeral;
  if tbsEncBan.tabVisible then
    pnlAtivo2.Enabled:= False;
  btnCancelar.Visible := False;
  btnEditar.Visible   := True;
  pnlAtivo.Enabled    := False;
  pnlComplemento.Enabled := pnlAtivo.Enabled;
  btnEditar.Visible   := True;
  btnGravar.Enabled   := False;
  btnConfigurar.Enabled := False;
  pCarregaDados;
  pSetFocus(btnEditar);
end;

procedure TfrmConfigCapitalFinancas.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  pHideHint;
  pCriarFormularios(TfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
  try
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '978';
    frmCfgGenericas_AutBan.ShowModal;
  finally
    FreeAndNil(frmCfgGenericas_AutBan);
  end;
end;

procedure TfrmConfigCapitalFinancas.BtnManualClick(Sender: TObject);
var
  LCaminhoExe,
  LPastaArquivo,
  LNomeArquivo: String;
begin
  inherited;

  LCaminhoExe := ExtractFilePath(Application.ExeName);
  LPastaArquivo := LCaminhoExe+'layout';

  if DirectoryExists(LPastaArquivo) then
  begin
    LNomeArquivo := LPastaArquivo+'\978400p.pdf';

    if FileExists(LNomeArquivo) then
      ShellExecute(Application.Handle, 'open',PChar(LNomeArquivo),nil,nil,SW_SHOWNORMAL)
    else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  end;
end;

procedure TfrmConfigCapitalFinancas.BtnOcorrenciaClick(Sender: TObject);
var
  LDetalhe: String;
begin
  inherited;
  pHideHint;

  LDetalhe :=
    #13#10 +
    'Independente da ocorrência, duplicatas com data de recebimento (296-301) e valor recebido (254-266) serão baixadas,'
    +'entretanto, é possível configurar na carteira para ignorar '
    +'certas ocorrências durante a baixa;'+ #13#10
    + #13#10 +'06 - Liquidação Normal (Não pode ser ignorada para baixa) '
    + #13#10 +'02 - Atualiza nosso número caso não tenha gravado; ' + #13#10 +
    '23 - Lança histórico de protesto; ' + #13#10 +
    '10 - Marca a duplicata como ''DP DESCONTADA'' igual a ''Sim''; ' + #13#10 +
    '32 - Instrução Rejeitada;'+ #13#10 +
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

  TfrmMemo.pShowMessage(
    'Banco 978 - Capital Finanças - Detalhamento de Ocorrências (posições 109 - 110 arquivo retorno).' + #13#10 + LDetalhe);
end;

procedure TfrmConfigCapitalFinancas.BtnOcorrenciaEnter(Sender: TObject);
begin
  inherited;
  btnOcorrencia.Hint :=
    'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
    'que são tratados pelas rotinas do sistema.';
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigCapitalFinancas.BtnOcorrenciaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCapitalFinancas.btnRemOcoClick(Sender: TObject);
var
  LOcorrencia: TCnfOco;
  LDaoOcorrencia: TCnfOcoDao;
  LCodigoBanco,
  LTipoLayout,
  LQtdCaracteresLayout,
  LEspecificacao,
  LCodigoEmpresa: String;
  LNumeroCarteira: Integer;
begin
  inherited;
  if cdsCnfOco.isEmpty then
    Exit;

  if fMensagem('Aviso', 'Confirma remoção da ocorrência selecionada?', ['&S i m', '&N ã o']) <> 1 then
    Exit;

  pDesmembraCarteira(
    'CONFIG978-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp,
    LCodigoBanco, LTipoLayout, LQtdCaracteresLayout, LEspecificacao, LCodigoEmpresa, LNumeroCarteira);

  LDaoOcorrencia := TCnfOcoDao.Create(LCodigoBanco, LTipoLayout, LQtdCaracteresLayout, LEspecificacao, LCodigoEmpresa, LNumeroCarteira);
  try
    LOcorrencia := LDaoOcorrencia.fBuscaPorOcorrencia(
      cdsCnfOcoCNF_CODOCO.AsString,
      cdsCnfOcoCNF_MOTOCO.AsString,
      Copy(cdsCnfOcoCNF_PLNCON.AsString, 1, 7),
      cdsCnfOcoCNF_TIPDES.AsInteger);

    if not Assigned(LOcorrencia) then
      Exit;

    if LDaoOcorrencia.fRemoverOcorrencia(
      LOcorrencia.strCodOco,
      LOcorrencia.strMotOco,
      LOcorrencia.strCodCta,
      LOcorrencia.intTipDes) then
    begin
      pCarregaOcorrencias;
      pMensagemOk('Registro removido com sucesso!');
    end;
  finally
    if Assigned(LOcorrencia) then
      FreeAndNil(LOcorrencia);
    FreeAndNil(LDaoOcorrencia);
  end;
end;

procedure TfrmConfigCapitalFinancas.chkCartSeqClick(Sender: TObject);
begin
  inherited;
  if not fValidaCampos(chkCartSeq) then
    TCheckBox(Sender).Checked := False;

  lblCartSeq.Enabled := TCheckBox(Sender).Checked;
  edtCartSeq.Enabled := TCheckBox(Sender).Checked;
end;

procedure TfrmConfigCapitalFinancas.cmbInstrucao1Change(Sender: TObject);
begin
  inherited;
  if cmbInstrucao1.ItemIndex = 0 then
    edtDiasProt.Enabled := False
  else
    edtDiasProt.Enabled := True;
end;

procedure TfrmConfigCapitalFinancas.pCarregaCfg(var ACampos: TStringList);
begin
  ACampos.Clear;
  ACampos.Add('Seq. Remessa      :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  ACampos.Add('Util Seq outr Cart:' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', ''));
  ACampos.Add('Carteira Seq.     :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', ''));
  ACampos.Add('Exporta p/ Boleto :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'EXPOBOL', ''));
  ACampos.Add('Cód. Carteira     :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', ''));
  ACampos.Add('Cód. Emp. Banco   :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODEMPR', ''));
  ACampos.Add('Cód. Agência      :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  ACampos.Add('Díg. Agência      :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', ''));
  ACampos.Add('Cta. Corrente     :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  ACampos.Add('Dígito C/C        :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', ''));
  ACampos.Add('Tipo de cobrança  :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'TIPCOBR', ''));
  ACampos.Add('Núm. Autorização  :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMAUTO', ''));
  ACampos.Add('Cód. Instrução    :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', ''));
  ACampos.Add('Cód. Inst. Persona:' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTPER', ''));
  ACampos.Add('Percentual multa  :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', ''));
  ACampos.Add('variante da nomenclatura do arquivo remessa:' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'varNOMREM', ''));
  ACampos.Add('Observação 1      :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  ACampos.Add('Observação 2      :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  ACampos.Add('Observação 3      :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  ACampos.Add('Observação 4      :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  ACampos.Add('Observação 5      :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  ACampos.Add('Dias p/ protesto  :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  ACampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  ACampos.Add('Arquivo Remessa   :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  ACampos.Add('Arquivo Retorno   :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  ACampos.Add('Responsável Bol.  :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', ''));
  ACampos.Add('Prot. de aceite   :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', ''));
  ACampos.Add('Na importação do retorno considerar apenas duplicatas da empresa logada?:' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'DUPEMPLOG', ''));
  ACampos.Add('Data Pagto Baixa  :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'SOLIDTA', ''));
  ACampos.Add('Portador de baixa :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  ACampos.Add('Portador da remessa :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', ''));
  ACampos.Add('Conta de baixa    :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  ACampos.Add('Inf. adicional    :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', ''));
  ACampos.Add('Outros acréscimos :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'OUTACRE', ''));
  ACampos.Add('Envia mensagens   :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'MANDMSG', ''));
  ACampos.Add('Envia Sac/Avalista:' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', ''));
  ACampos.Add('Utl. Desconto de Duplicatas?:' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'UTLDESDUP', ''));
  ACampos.Add('Utilizar integração Alpe?:' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'UTILIZA_ALPE', ''));
  ACampos.Add('Nome beneficiário :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', ''));
  ACampos.Add('endereço          :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'endEBEN', ''));
  ACampos.Add('Bairro            :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', ''));
  ACampos.Add('Complemento       :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', ''));
  ACampos.Add('Cidade            :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', ''));
  ACampos.Add('Estado            :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', ''));
  ACampos.Add('CEP               :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', ''));
  ACampos.Add('CNPJ              :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', ''));
  ACampos.Add('Exibe mensagens   :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'EXIBMSG', ''));
  ACampos.Add('Ocorrências a ignorar na baixa automática: ' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'OCOIGNORA', ''));
  ACampos.Add('Utilizar Nomenclatura DSNAME?' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'DSNAME', ''));
  ACampos.Add('Valor da Tarifa:' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', ''));
  ACampos.Add('Portador:' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', ''));
  ACampos.Add('Fornecedor:' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', ''));
  ACampos.Add('Utiliza data de crédito para movimentação:' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'DTACRED', ''));
  ACampos.Add('Percentual Desconto Alpe:' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERALPE', ''));
  ACampos.Add('Taxa TED Alpe:' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'TEDALPE', ''));
  ACampos.Add('Considerar dias para crédito no lançamento de tarifa? :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIASCREDITOTARIFA', ''));
  ACampos.Add('Utilizar integração Extrant?:' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'UTILIZA_EXTRANT', ''));
  ACampos.Add('Permitir impressão de boletos? :' + fGetBancoConfig(0, FConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', ''));
end;

function TfrmConfigCapitalFinancas.fRetornaStringComQuebraDeLinha(AListaString: TStringList): String;
var
  LContador: Integer;
begin
  Result := '';
  for LContador := 0 To AListaString.Count - 1 do
    Result := Result + AListaString.Strings[LContador] + #13+#10;
end;

procedure TfrmConfigCapitalFinancas.pGravaLogCarteira(ACfgsAnteriores: TStringList);
var
  LContador,
  LIndice: Integer;
  LListaCfgsAtual: TStringList;
  LDescricaoLog: String;
begin
  LListaCfgsAtual := TStringList.Create;
  try
    pCarregaCfg(LListaCfgsAtual);
    LDescricaoLog := '';

    for LContador := 0 To LListaCfgsAtual.Count - 1 do
    begin
      if ACfgsAnteriores.Strings[LContador] <> LListaCfgsAtual.Strings[LContador] then
      begin
        LIndice := Pos(':', ACfgsAnteriores.Strings[LContador]);

        if not fEmptyStr(LDescricaoLog) then
          LDescricaoLog := LDescricaoLog + #13+#10;

        LDescricaoLog :=
          LDescricaoLog + Copy(ACfgsAnteriores.Strings[LContador], 1, LIndice) +
          ' Valor Anterior - ' + Copy(ACfgsAnteriores.Strings[LContador], LIndice + 1, Length(ACfgsAnteriores.Strings[LContador]) - LIndice) +
          ' Valor Atual - ' + Copy(LListaCfgsAtual.Strings[LContador], LIndice + 1, Length(LListaCfgsAtual.Strings[LContador]) - LIndice);
      end;
    end;

    if not fEmptyStr(LDescricaoLog) then
      pGravaLogAtb(
        '978', 'Capital Finanças',
        FConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
        strLoginUsuarioLogado, VS_StrCodEmp,
        fRetornaStringComQuebraDeLinha(ACfgsAnteriores),
        fRetornaStringComQuebraDeLinha(LListaCfgsAtual), LDescricaoLog);
  finally
    FreeAndNil(LListaCfgsAtual);
  end;
end;

procedure TfrmConfigCapitalFinancas.edtDiasCreditoTarifaEnter(Sender: TObject);
begin
  inherited;
  pShowHint(edtDiasCreditoTarifa,'Aviso');
end;

procedure TfrmConfigCapitalFinancas.edtDiasCreditoTarifaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCapitalFinancas.edtDiasCreditoTarifaMouseEnter(Sender: TObject);
begin
  inherited;
  pShowHint(edtDiasCreditoTarifa,'Aviso');
end;

procedure TfrmConfigCapitalFinancas.edtDiasCreditoTarifaMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

end.

