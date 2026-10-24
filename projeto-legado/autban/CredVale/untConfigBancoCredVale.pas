unit untConfigBancoCredVale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, DirectoryEditFocus, StdCtrls, EditFocus, Buttons,
  ExtCtrls, QColorLabel, Menus, ComCtrls, ShellApi, AppEvnts, Uni, BitBtnLockedIncrem,
  untTypesSistema, frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxButtonEdit, strUtils,
  dxScreenTip, cxClasses, dxCustomHint, cxHint, ComboBoxFocus, MaskEditFocus,
  untFrameDirectoryEditFocus, untFrameCheckComboBoxOcorrencia, dxBarBuiltInMenu,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridCustomView, cxGrid, cxGroupBox, cxPC,
  untCadOcoCartei, untCNFOCO_Class, untCNFOCO_Dao, Datasnap.DBClient,
  UniClientDataSet,System.Generics.Collections, untFramePlanoDeContasMaskEdit;

type
  TfrmConfigBancoCredVale = class(TfrmPai)
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
    lblVarNomRem: TLabel;
    edtVarNomRem: TEditFocus;
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
    edtEndBen: TEditFocus;
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
    cdsCnfOcoCNF_MOTOCO: TStringField;//MF: 284336 - 17/05/2023
    grdTarifasDBTableView1CNF_MOTOCO: TcxGridDBColumn;
    clDiasCreditoTarifa: TColorLabel;
    edtDiasCreditoTarifa: TEditFocus;
    lblDiasCreditoTarifa: TLabel;
    lblDupEmpLog: TLabel;
    clDupEmpLog: TColorLabel;
    edtDupEmpLog: TEditFocus;
    lblPerImpBol: TLabel;
    edtPerImpBol: TEditFocus;
    clbPerImpBol: TColorLabel;
    lblParcelasNegritoCarne: TLabel;
    edtParcelasNegritoCarne: TEditFocus;
    clParcelasNegritoCarne: TColorLabel;
    Label31: TLabel;
    edtEnviarChaveNFe: TEditFocus;
    ColorLabel11: TColorLabel;
    procedure btnGravarClick(Sender: TObject);
    procedure pCarregaDados;
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
    procedure fraPlanoDeContasEncMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    function RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;
    procedure edtCodPorRemKeyPress(Sender: TObject; var Key: Char);

    procedure edtDiasCreditoTarifaEnter(Sender: TObject);
    procedure edtDiasCreditoTarifaMouseEnter(Sender: TObject);
    procedure edtDiasCreditoTarifaMouseLeave(Sender: TObject);
    procedure edtDiasCreditoTarifaExit(Sender: TObject);

  private
    { Private declarations }

    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;
    qryCadFor : TUniQuery;

    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pCarregaCentroCusto(strCtaBai: String; edtLabel: TEdit);
    procedure pShowHint(edtEdit: TEditFocus; strTitulo: String);
    procedure pShowHintBotao(btnBotao: TBitBtnLocked; strTitulo: String);
    procedure pHideHint;
    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
    procedure pCarregaOcorrencias;
  public
    blnNaoEditar: Boolean;
    strConfig   : String;
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigBancoCredVale: TfrmConfigBancoCredVale;

implementation

uses untPesqAux, untFuncoesSimples, untFuncoes,
  untCfgGenericas_AutBan, untConsultas, untMemo;

{$R *.dfm}

procedure TfrmConfigBancoCredVale.btnConfigurarEnter(Sender: TObject);
begin
  inherited;
  btnConfigurar.Hint := 'Configurar percentual de ' + #13+#10 +
                        'juros para remessa.';
  pShowHintBotao(btnConfigurar, 'Cofigurações específicas.');
end;

procedure TfrmConfigBancoCredVale.btnConfigurarExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBancoCredVale.btnEditarClick(Sender: TObject);
begin
  If ((Not fVerificaDireitoAutBan('PERCARBAN')) and (strLoginUsuarioLogado <> '999')) Then
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

procedure TfrmConfigBancoCredVale.btnEdtOcoClick(Sender: TObject);
Var
  intRecNo_: Integer;
begin
  inherited;
  intRecNo_ := 0;
  If Not cdsCnfOco.isEmpty Then
  Begin
    intRecNo_ := cdsCnfOco.RecNo;
    frmCadOcoCartei := TfrmCadOcoCartei.Create(nil);
    frmCadOcoCartei.strCartei := 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp;
    frmCadOcoCartei.blnEditar := True;
    frmCadOcoCartei.edtCodOco.Text := cdsCnfOcoCNF_CODOCO.AsString;
    frmCadOcoCartei.fraPlanoDeContasOco.MskCodCta.Text := Copy(cdsCnfOcoCNF_PLNCON.AsString,1,7);
    frmCadOcoCartei.cmbTipDes.ItemIndex := cdsCnfOcoCNF_TIPDES.AsInteger;

    //MF: 284336 - 17/05/2023 - ini
    frmCadOcoCartei.edtMotOco.Visible := True;
    frmCadOcoCartei.edtMotOco.Text := cdsCnfOcoCNF_MOTOCO.AsString;
    frmCadOcoCartei.blnValidaMotOco := False;
    //MF: 284336 - 17/05/2023 - fim

    If cdsCnfOcoCNF_CODOCO.AsString = '02' Then
      frmCadOcoCartei.cmbTipDes.Visible := True;

    If cdsCnfOcoCNF_CODOCO.AsString = '02' Then
      frmCadOcoCartei.lblTipDes.Visible := True;

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

procedure TfrmConfigBancoCredVale.btnGravarClick(Sender: TObject);
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
      If edtProxNumArqRem.Text <> fRetProxNumAutBan('CONFIG962-' + edtCartSeq.Text) Then
      Begin
        If fMensagem('ATENÇÃO','Ao utilizar a sequência do arquivo de remessa de outra carteira, o campo Último Núm. de Seq. Arq. Remessa será sobrescrito pelo da carteira principal. Deseja continuar?',['&SIM', '&NÃO'], 1) = 2 Then
          Exit;
      End;
    End;

    stlCfgAnt := Nil;
    Try
      stlCfgAnt := TStringList.Create;
      pCarregaCfg(stlCfgAnt);

      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', IIF(chkCartSeq.Checked, fRetProxNumAutBan('CONFIG962-' + edtCartSeq.Text), edtProxNumArqRem.Text));
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'CODEMPR', edtCodEmpBanco.Text   );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', edtCodCar.Text        );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text    );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', edtDigAge.Text        );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text     );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', edtDigCtaCor.Text     );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMAUTO', edtNumAutBco.Text     );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text      );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text          );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', LeftStr(cmbInstrucao1.Text,2));
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTPER', LeftStr(cmbInstruPersonalizada.Text,2));
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text   );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text   );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text   );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text   );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text   );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPCOBR', edtTipoCob.Text       );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessaBDC.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetornoBDC.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text        );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'SOLIDTA', edtSolDta.Text       );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'DIASCREDITOTARIFA', edtDiasCreditoTarifa.Text       );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text       );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContas.MskCodCta.Text);
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text      );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text        );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'DUPEMPLOG', edtDupEmpLog.Text       );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', edtPerImpBol.Text       );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'PARCELASNEGRITOCARNE', edtParcelasNegritoCarne.Text);
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPOBOL', edtExpBol.Text        );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', edtPerMul.Text        );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'VARNOMREM', edtVarNomRem.Text        );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text        );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'OUTACRE', edtOutAcr.Text        );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'MANDMSG', edtMandMsg.Text       );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', IIF(chkCartSeq.Checked, 'S', 'N'));
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', IIF(chkCartSeq.Checked, edtCartSeq.Text, ''));
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', edtUsaSac.Text        );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'UTLDESDUP', edtUtlDesDup.Text   );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', edtDesBen.Text        );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', edtEndBen.Text        );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', edtBaiBen.Text        );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', edtCompBen.Text       );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', edtCidBen.Text        );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', edtEstBen.Text        );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', edtCepBen.Text        );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', edtCgCBen.Text        );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'EXIBMSG', edtExibMsg.Text       );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'DTACRED', edtDtaCre.Text        );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'OCOIGNORA', fraCheckComboBoxOcorrencia.fGetOcorrencias);
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', edtPorTar.Text    );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', fraPlanoDeContasEnc.MskCodCta.Text);
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', edtForTar.Text    );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', edtValorTarifa.Text  );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'DSNAME', edtDsName.Text         );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'ESPDOCBOL', edtEspecieDocumento.Text         );
      fGetBancoConfig(1, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'ENV_NFE', edtEnviarChaveNFe.Text);

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        pBackupCnfBco;
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        edtProxNumArqRem.Enabled := False;
        pSetFocus(edtExpBol);
        pnlAtivo.Enabled  := False;
        pnlComplemento.Enabled := pnlAtivo.Enabled;
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

procedure TfrmConfigBancoCredVale.pCarregaDados;
begin

  {*****************}
  {* CARREGA DADOS *}
  {**************AF*}
  If fEmptyStr(fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '')) Then
  Begin
    edtProxNumArqRem.Enabled := True;
    edtProxNumArqRem.Clear;
    pSetFocus(edtProxNumArqRem);
  End
  Else
  Begin
    edtProxNumArqRem.Text  := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '');
    edtProxNumArqRem.Enabled := False;
    pSetFocus(edtExpBol);
  End;

  if (strLoginUsuarioLogado='997') or(strLoginUsuarioLogado='998') or (strLoginUsuarioLogado='999') Then
  begin
    edtProxNumArqRem.Enabled := True;
    pSetFocus(edtProxNumArqRem);
  End;

  edtCodEmpBanco.Text    := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'CODEMPR', '');
  edtCodCar.Text         := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', '');
  edtCodAgencia.Text     := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtContaCorr.Text      := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', '');
  edtDigCtaCor.Text      := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', '');
  edtNumAutBco.Text      := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMAUTO', '');
  edtDiasProt.Text       := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '');
  edtResp.Text           := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', '');

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '')) Of
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
    End;
  End
  Else
    cmbInstrucao1.ItemIndex := -1;

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTPER', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTPER', '')) Of
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
    End;
  End
  Else
    cmbInstruPersonalizada.ItemIndex := -1;

  edtDesPor.Text := '';
  edtDescPorRem.Text := '';
  fraPlanoDeContas.edtDesCta.Text := '';

  edtObservacao1.Text    := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text    := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text    := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text    := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text    := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');
  edtTipoCob.Text        := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPCOBR', '');
  fraPathRemessaBDC.edtDirectory.text := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '');
  fraPathRetornoBDC.edtDirectory.text := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '');
  edtCodPor.Text         := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  edtCodPorRem.Text      := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');
  fraPlanoDeContas.MskCodCta.Text := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');
  edtDiasCred.Text       := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', '');
  edtProAce.Text         := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', '');
  edtDupEmpLog.Text     :=  fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1),'DUPEMPLOG','');
  edtDigAge.Text         := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', '');
  edtExpBol.Text         := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPOBOL', '');
  edtPerMul.Text         := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', '');
  edtVarNomRem.Text      := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'VARNOMREM', '');
  edtSolDta.Text         := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'SOLIDTA', 'N');
  edtSolDta.Text         := IIF(fEmptyStr(edtSolDta.Text), 'N', edtSolDta.Text);
  edtDiasCreditoTarifa.Text         := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'DIASCREDITOTARIFA', 'N');
  edtDiasCreditoTarifa.Text         := IIF(fEmptyStr(edtDiasCreditoTarifa.Text), 'N', edtDiasCreditoTarifa.Text);
  edtInfAdi.Text         := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', '');
  edtOutAcr.Text         := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'OUTACRE', '');
  edtMandMsg.Text        := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'MANDMSG', '');
  chkCartSeq.Checked     := (fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', '') = 'S');
  edtCartSeq.Text        := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', '');
  edtExibMsg.Text        := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'EXIBMSG', '');
  edtExibMsg.Text        := IIF(fEmptyStr(edtExibMsg.Text), 'S', edtExibMsg.Text);
  edtDtaCre.Text         := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'DTACRED', 'N');
  fraCheckComboBoxOcorrencia.pSetOcorrencias(fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'OCOIGNORA', ''));
  edtEnviarChaveNFe.Text := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'ENV_NFE', '');

  //Dados Beneficiário
  edtUsaSac.Text        := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', '');
  edtUsaSac.Text        := IIF(fEmptyStr(edtUsaSac.Text), 'N', edtUsaSac.Text);
  edtDesBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', ''), '');
  edtEndBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', ''), '');
  edtBaiBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', ''), '');
  edtCompBen.Text       := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', ''), '');
  edtCidBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', ''), '');
  edtEstBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', ''), '');
  edtCepBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', ''), '');
  edtCgcBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', ''), '');
  edtUtlDesDup.Text := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'UTLDESDUP', '');
  If fEmptyStr(edtUtlDesDup.Text) Then
    edtUtlDesDup.Text := 'S';

  If fEmptyStr(edtEnviarChaveNFe.Text) then
    edtEnviarChaveNFe.Text := 'N';

  If fEmptyStr(edtDupEmpLog.Text) Then
    edtDupEmpLog.Text := 'N';

  edtPerImpBol.Text     := fGetBancoConfig(0,'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', '');
  If fEmptyStr(edtPerImpBol.Text) Then
    edtPerImpBol.Text := 'S';

  edtParcelasNegritoCarne.Text     := fGetBancoConfig(0,'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'PARCELASNEGRITOCARNE', '');
  If fEmptyStr(edtParcelasNegritoCarne.Text) Then
    edtParcelasNegritoCarne.Text := 'N';

  edtDsName.Text := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'DSNAME', '');
  If fEmptyStr(edtDsName.Text) Then
    edtDsName.Text := 'N';

  edtEspecieDocumento.Text := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'ESPDOCBOL', '');
  If fEmptyStr(edtEspecieDocumento.Text) Then
    edtEspecieDocumento.Text := 'N';

  fValidaCampos(edtUsaSac);

  chkCartSeq.OnClick(chkCartSeq);

  If edtTipoCob.Text = 'S' Then
  Begin
    edtNumAutBco.Enabled := False;
    edtNumAutBco.Clear;
  End
  Else
    edtNumAutBco.Enabled := True;

  edtDesPor.Clear;
  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCodPorRem.Text ) Then
    pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);


  fraPlanoDeContas.edtDesCta.Clear;
  If Not fEmptyStr( fraPlanoDeContas.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);

  edtPorTar.Text         := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', '');
  fraPlanoDeContasEnc.MskCodCta.Text := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', '');
  edtForTar.Text         := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', '');
  edtValorTarifa.Text    := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', '');

  edtDesPorTar.Clear;
  If Not fEmptyStr( edtPorTar.Text ) Then
    pCarregaPortador(edtPorTar.Text, edtDesPorTar);

  fraPlanoDeContasEnc.edtDesCta.Clear;
  If Not fEmptyStr( fraPlanoDeContasEnc.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContasEnc.MskCodCta.Text, fraPlanoDeContasEnc.edtDesCta);

  edtDesForTar.Clear;
  If Not fEmptyStr( edtForTar.Text ) Then
  begin
    pPesquisaCadFor(qryCadFor, qryCadFor, edtForTar.Text);
    edtDesForTar.Text  := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
  end;

  pCarregaOcorrencias;

end;

procedure TfrmConfigBancoCredVale.pCarregaOcorrencias;
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

  pDesmembraCarteira('CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp, strCodBco,
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
        cdsCnfOcoCNF_GERREC.Value    := objCnfOco.blnGerRec;
        cdsCnfOcoCNF_FORNEC.AsString := objCnfOco.strCodFor + ' - ' + fRetNomFornecedor(objCnfOco.strCodFor);
        cdsCnfOcoCNF_PORTAD.AsString := objCnfOco.strCodPor + ' - ' + fRetNomPortador(objCnfOco.strCodPor);
        cdsCnfOcoCNF_PLNCON.AsString := objCnfOco.strCodCta + ' - ' + fRetDescCentroCusto(objCnfOco.strCodCta);
        cdsCnfOcoCNF_TIPDES.AsInteger:= objCnfOco.IntTipDes;
        cdsCnfOcoCNF_MOTOCO.AsString := objCnfOco.strMotOco;//MF: 284336 - 18/05/2023

        Case objCnfOco.IntTipDes of
          0: cdsCnfOcoCNF_DSTPDS.AsString := '';
          1: cdsCnfOcoCNF_DSTPDS.AsString := 'TARIFA IOF DESCONTO';
          2: cdsCnfOcoCNF_DSTPDS.AsString := 'TARIFA BOLETO DESC';
          3: cdsCnfOcoCNF_DSTPDS.AsString := 'TARIFA DESCONTADA';
          4: cdsCnfOcoCNF_DSTPDS.AsString := 'EST. DESCONTADA';
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


procedure TfrmConfigBancoCredVale.FormShow(Sender: TObject);
begin
  inherited;

  fraCheckComboBoxOcorrencia.strCodBco    := '962';
  fraCheckComboBoxOcorrencia.strCnab      := '400';
  fraCheckComboBoxOcorrencia.strCodIgnora := ['06','09'];
  fraCheckComboBoxOcorrencia.pCarregaOcorrencias;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  pCarregaDados;

  If edtProxNumArqRem.Enabled Then
    pSetFocus(edtProxNumArqRem)
  Else
    pSetFocus(edtExpBol);

  pSetFocus(btnEditar);

  pnlAtivo.Enabled := False;
  pnlAtivo2.Enabled := False;
  pnlComplemento.Enabled := pnlAtivo.Enabled;

  if blnNaoEditar then
  begin
    btnConfigurar.Enabled := False;
    btnConfigurar.Visible := False;
    btnGravar.Enabled     := True;
    btnEditar.Visible     := False;
    pSetFocus(btnGravar);
  end;

end;

procedure TfrmConfigBancoCredVale.fraPlanoDeContasEncMskCodCtaKeyPress(
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

procedure TfrmConfigBancoCredVale.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
    if fValidaCampos(fraPlanoDeContas.MskCodCta) then
      SelectNext(ActiveControl, True, True);
end;

function TfrmConfigBancoCredVale.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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
      Else
      If StrToInt(edtProxNumArqRem.Text) < 0 Then
      Begin
        fMensagem('', 'O Último Núm. Arq. Remessa deve ser maior ou igual a zero!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtExpBol Then
    Begin
      If Pos(edtExpBol.Text, '1_2_') <= 0 Then
      Begin
        fMensagem('','O campo a ser exportado para o boleto deve ser preenchido com (1/2)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtTipoCob Then
    Begin

      If (edtTipoCob.Text <> 'S') And (edtTipoCob.Text <> 'D') Then
      Begin
        fMensagem('','O campo Tipo de Cobrança deve ser S ou D!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

      If Result Then
      Begin
        If edtTipoCob.Text = 'S' Then
        Begin
          edtNumAutBco.Enabled := False;
          edtNumAutBco.Clear;
        End
        Else
          edtNumAutBco.Enabled := True;
      End
      Else
      Begin
        edtNumAutBco.Enabled := False;
        edtNumAutBco.Clear;
      End
    End

    Else If (Sender = cmbInstrucao1) Then
    Begin

      If cmbInstrucao1.ItemIndex = -1 Then
      Begin
        fMensagem('','O Campo de instrução devem ser preenchidos!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else If cmbInstrucao1.ItemIndex = 11 Then
        edtDiasProt.Clear;

    End

    Else If Sender = edtResp Then
    Begin

      If (edtResp.Text <> 'E') And (edtResp.Text <> 'B') Then
      Begin
        fMensagem('','O campo Resp. por emissão de boletos deve ser E ou B!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtDsName Then
    Begin
      If Pos(edtDsName.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Utilizar Nomenclatura DSNAME? deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtEnviarChaveNFe Then
    Begin
      If Pos(edtEnviarChaveNFe.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Enviar Chave NF-e deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtEspecieDocumento Then
    Begin
      If Pos(edtEspecieDocumento.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Apresentar Esp. Documento no Boleto? deve ser preenchido com (S/N)!',['&OK']);
        Result := False;
      End;
    End

    Else If Sender = edtProAce Then
    Begin
      If Pos(edtProAce.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Imprime Protocolo de Aceite deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtDupEmpLog Then
    Begin
      If Pos(edtDupEmpLog.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Na importação do retorno considerar apenas duplicatas da empresa logada? deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtSolDta) Then
    Begin
      If Pos(edtSolDta.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Solicita data de pagamento deve ser S ou N!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtDiasCreditoTarifa) Then
    Begin
      If Pos(edtDiasCreditoTarifa.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Considerar dias para crédito no lançamento de tarifa deve ser S ou N!'+strMensagemConfig, ['&OK']);
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

    Else If Sender = edtParcelasNegritoCarne Then
    Begin
      If Pos(edtParcelasNegritoCarne.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo "Enviar parcelas em negrito quando layout for carnê?" deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
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
        begin
          Result := PlanoDeContasAtivo(fraPlanoDeContasEnc.MskCodCta.Text,True);
          fraPlanoDeContasEnc.edtDesCta.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;
        end;
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

    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin

      If fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser informado!'+strMensagemConfig, ['&Ok']);
        fraPlanoDeContas.edtDesCta.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);
        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!'+strMensagemConfig, ['&Ok']);
          Result := False;
        End
        Else
          Result := PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text,True);
      End;

    End

    Else If (Sender = edtContaCorr) Then
    Begin

      If fEmptyStr(edtContaCorr.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Número Conta Corrente deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else If Length(edtContaCorr.Text) <> edtContaCorr.MaxLength Then
      Begin
        fMensagem('ATENÇÃO','O Número Conta Corrente deve ter 7 caracteres!',['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigCtaCor) Then
    Begin

      If fEmptyStr(edtDigCtaCor.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Dígito da Conta Corrente deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtPerMul) Then
    Begin
      If Not fValidaEscala(edtPerMul.Text, 0, 100) Then
      begin
        fMensagem('ATENÇÃO','O campo percentual de multa deve estar entre 0 e 100!'+strMensagemConfig,['&OK']);
        Result := False;
      end;
    End

    Else If Sender = edtMandMsg Then
    Begin
      If Pos(edtMandMsg.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO','Enviar Mensagem (Agrupamento) deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtExibMsg Then
    Begin
      If Pos(edtExibMsg.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO','"Exibir Núm. Dupl. Agrupadas" deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtDtaCre Then
    Begin
      If Pos(edtDtaCre.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO','"Utiliza data de crédito para movimentação" deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtCodCar Then
    Begin
      If fEmptyStr(edtCodCar.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Código da Carteira deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else If Length(edtCodCar.Text) < 3 Then
      Begin
        fMensagem('ATENÇÃO','O Campo Código da Carteira deve possuir 3 dígitos!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodEmpBanco) Then
    Begin
      If fEmptyStr(edtCodEmpBanco.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Cedente deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else If Length(edtCodEmpBanco.Text) <> edtCodEmpBanco.MaxLength Then
      Begin
        fMensagem('ATENÇÃO','O Campo Cedente deve ter 8 caracteres!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodAgencia) Then
    Begin
      If fEmptyStr(edtCodAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Código da Agência deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else If Length(edtCodAgencia.Text) <> edtCodAgencia.MaxLength Then
      Begin
        fMensagem('ATENÇÃO','O campo Código da Agência deve ter 5 caracteres!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigAge) Then
    Begin
      If fEmptyStr(edtDigAge.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Dígito da Agência deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtNumAutBco) Then
    Begin
      If edtTipoCob.Text = 'D' Then
      Begin
        If fEmptyStr(edtNumAutBco.Text) Then
        Begin
          fMensagem('ATENÇÃO','O campo Número de Autorização do Banco deve ser preenchido!'+strMensagemConfig,['&O K']);
          Result := False;
        End
        Else If Length(edtNumAutBco.Text) <> edtNumAutBco.MaxLength Then
        Begin
          fMensagem('ATENÇÃO','O campo Número de Autorização do Banco deve ter 4 caracteres!'+strMensagemConfig,['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtDiasProt) Then
    Begin
      If cmbInstrucao1.ItemIndex in [1,2,3,12] Then
      Begin
        If fEmptyStr(edtDiasProt.Text) Then
        Begin
          fMensagem('ATENÇÃO','O campo Dias para protesto/decurso deve ser preenchido!'+strMensagemConfig,['&O K']);
          Result := False;
        End
        Else If (StrToInt(edtDiasProt.Text) < 5) And (cmbInstrucao1.ItemIndex <> 12) Then
        Begin
          fMensagem('ATENÇÃO','A quantidade de dias informada deve ser de no mínimo 5 dias!'+strMensagemConfig,['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = chkCartSeq) Then
    Begin
      If (chkCartSeq.Checked) Then
      Begin
        If fVerificaCartPrimariaAutBan('CONFIG962-', tabCarteira.TabIndex + 1) Then
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
          If fEmptyStr(fGetBancoConfig(0, 'CONFIG962-' + edtCartSeq.Text, 'PROXNUM', '')) Then
          Begin
            fMensagem('ATENÇÃO','Não pode ser usada essa carteira no campo Carteira Seq., pois essa não possui Último Núm. Seq. Remessa cadastrado!' ,['&O K']);
            Result := False;
          End
          Else
          If fVerificaCartFilhaAutBan('CONFIG962-' + edtCartSeq.Text) Then
          Begin
            fMensagem('ATENÇÃO','Não pode ser usada essa carteira no campo Carteira Seq., pois essa já possui uma Carteira Seq. cadastrada!' ,['&O K']);
            Result := False;
          End;
        End;
      End;
    End

    Else If Sender = edtUsaSac Then
    Begin
      If Pos(edtUsaSac.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Enviar Sacador/Avalista deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      End;

      grpBeneficiario.Enabled := edtUsaSac.Text = 'S';
    End

    Else If Sender = edtUtlDesDup Then
    Begin
      If Pos(edtUtlDesDup.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Utl. Desconto de Duplicatas? deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      End;
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

procedure TfrmConfigBancoCredVale.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
  cxPaginas.ActivePage := tbsGeral;
end;

procedure TfrmConfigBancoCredVale.tabCarteiraChanging(Sender: TObject;
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

procedure TfrmConfigBancoCredVale.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmConfigBancoCredVale.edtCodPorRemKeyPress(Sender: TObject;
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

procedure TfrmConfigBancoCredVale.edtDiasCredEnter(Sender: TObject);
begin
  inherited;
  edtDiasCred.Hint := 'Informar quantidade de dias ' + #13+#10 +
                      'do intervalo entre a efetuação ' + #13+#10 +
                      'do pagamento e o crédito na ' + #13+#10 +
                      'conta corrente.';

  pShowHint(edtDiasCred, 'Dias para Crédito');
end;

procedure TfrmConfigBancoCredVale.edtDiasCredExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBancoCredVale.edtDtaCreExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtDiasCred.Text) Then
  Begin
    If (edtDtaCre.Text = 'S') And (StrToInt(edtDiasCred.Text) > 0 ) Then
    Begin
      fMensagem('Aviso', 'Para utilizar a data de crédito como movimentação não é permitido informar a configuração quantidade de dias para crédito!', ['&O k']);
      edtDtaCre.Text := 'N';
    End;
  End;
end;

procedure TfrmConfigBancoCredVale.edtForTarKeyPress(Sender: TObject; var Key: Char);
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


procedure TfrmConfigBancoCredVale.edtPorTarKeyPress(Sender: TObject; var Key: Char);
var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtPorTar, edtDesPorTar, nil, Key, arrSel) then
    Begin
      Self.SelectNext(ActiveControl, True, True);
    End;
  End;

end;

procedure TfrmConfigBancoCredVale.edtUsaSacExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtUsaSac);
end;

procedure TfrmConfigBancoCredVale.pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    edtLabel.Text := FieldByName('CTA_DESCTA').AsString;
  End;

end;

procedure TfrmConfigBancoCredVale.pCarregaPortador(strCodPor: String; edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtLabel.Text := FieldByName('POR_NOMPOR').AsString;
  End;

end;

procedure TfrmConfigBancoCredVale.pHideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmConfigBancoCredVale.pShowHint(edtEdit: TEditFocus; strTitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,edtEdit.ClientOrigin.Y, strTitulo, edtEdit.Hint);
end;

procedure TfrmConfigBancoCredVale.pShowHintBotao(btnBotao: TBitBtnLocked;
  strTitulo: String);
begin
  HintControler.ShowHint(btnBotao.ClientOrigin.X,btnBotao.ClientOrigin.Y, strTitulo, btnBotao.Hint);
end;

function TfrmConfigBancoCredVale.RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;
begin
  While Not Sender.ClassName.Equals('TcxTabSheet') Do
  Begin
    Sender := Sender.Parent;
  End;
  Result := TcxTabSheet(Sender);

end;

procedure TfrmConfigBancoCredVale.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  qryCadFor := fCriaQuery(Self);
  pCarKeyAutBan;

 cxPaginas.Properties.ActivePage := tbsGeral;

  If fCfgSis('ENCBAN', varBoolean) Then
    tbsEncBan.TabVisible := True
  else
    tbsEncBan.TabVisible := False;

end;

procedure TfrmConfigBancoCredVale.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigBancoCredVale.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBancoCredVale.btnAddOcoClick(Sender: TObject);
begin
  inherited;
  frmCadOcoCartei := TfrmCadOcoCartei.Create(nil);
  frmCadOcoCartei.strCartei := 'CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp;
  frmCadOcoCartei.cmbTipDes.Visible := True;
  frmCadOcoCartei.cmbTipDes.Enabled := True;
  frmCadOcoCartei.lblTipDes.Visible := True;

  //MF: 284336 - 17/05/2023 - ini
  frmCadOcoCartei.edtMotOco.Visible := True;
  frmCadOcoCartei.edtMotOco.Enabled := True;
  frmCadOcoCartei.blnValidaMotOco := False;
  //MF: 284336 - 17/05/2023 - fim

  Try
    frmCadOcoCartei.ShowModal;
  Finally
    FreeAndNil(frmCadOcoCartei);
  End;
  pCarregaOcorrencias;
end;

procedure TfrmConfigBancoCredVale.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do registro da carteira selecionada?', ['&S i m', '&N ã o'], 2) = 1 then
  begin
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
end;

procedure TfrmConfigBancoCredVale.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pHideHint;

    pCriarFormularios(TfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '962';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigBancoCredVale.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\962400p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\962400p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigBancoCredVale.BtnOcorrenciaClick(Sender: TObject);
  Var
    strDetalhe : String;
begin
  inherited;
  pHideHint;

  strDetalhe := #13#10 +
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


  TfrmMemo.pShowMessage('Banco 962 - Banco CredVale - Detalhamento de Ocorrências (posições 109 - 110 arquivo retorno).' + #13#10 +
                        strDetalhe);
end;

procedure TfrmConfigBancoCredVale.BtnOcorrenciaEnter(Sender: TObject);
begin
  inherited;
  btnOcorrencia.Hint := 'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
                        'que são tratados pelas rotinas do sistema.';
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigBancoCredVale.BtnOcorrenciaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBancoCredVale.btnRemOcoClick(Sender: TObject);
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
      pDesmembraCarteira('CONFIG962-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp,
                         strCodBco, strTipLay, strNumPos, strEspeci, strCodEmp, intCartei);

      objCnfDao := TCnfOcoDao.Create(strCodBco, strTipLay, strNumPos,
                                     strEspeci, strCodEmp, intCartei);

      objCnfOco := objCnfDao.fBuscaPorOcorrencia(cdsCnfOcoCNF_CODOCO.AsString,
                                                  cdsCnfOcoCNF_MOTOCO.AsString,//MF: 284336 - 18/05/2023
                                                  Copy(cdsCnfOcoCNF_PLNCON.AsString,1,7),
                                                  cdsCnfOcoCNF_TIPDES.AsInteger);
      If Assigned(objCnfOco) Then
      Begin
        If objCnfDao.fRemoverOcorrencia(objCnfOco.strCodOco,
                                        objCnfOco.strMotOco,//MF: 284336 - 22/05/2023
                                        objCnfOco.strCodCta,objCnfOco.intTipDes) Then
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

procedure TfrmConfigBancoCredVale.chkCartSeqClick(Sender: TObject);
begin
  inherited;
  If Not fValidaCampos(chkCartSeq) Then
    TCheckBox(Sender).Checked := False;

  lblCartSeq.Enabled := TCheckBox(Sender).Checked;
  edtCartSeq.Enabled := TCheckBox(Sender).Checked;
end;

procedure TfrmConfigBancoCredVale.cmbInstrucao1Change(Sender: TObject);
begin
  inherited;
  If cmbInstrucao1.ItemIndex = 0 Then
    edtDiasProt.Enabled := False
  Else
    edtDiasProt.Enabled := True;
end;

procedure TfrmConfigBancoCredVale.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Seq. Remessa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  stlCampos.Add('Util Seq outr Cart:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', ''));
  stlCampos.Add('Carteira Seq.     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', ''));
  stlCampos.Add('Exporta p/ Boleto :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'EXPOBOL', ''));
  stlCampos.Add('Cód. Carteira     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', ''));
  stlCampos.Add('Cód. Emp. Banco   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODEMPR', ''));
  stlCampos.Add('Cód. Agência      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Díg. Agência      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', ''));
  stlCampos.Add('Cta. Corrente     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  stlCampos.Add('Dígito C/C        :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', ''));
  stlCampos.Add('Tipo de cobrança  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TIPCOBR', ''));
  stlCampos.Add('Núm. Autorização  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMAUTO', ''));
  stlCampos.Add('Cód. Instrução    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', ''));
  stlCampos.Add('Cód. Inst. Persona:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTPER', ''));
  stlCampos.Add('Percentual multa  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', ''));
  stlCampos.Add('Variante da nomenclatura do arquivo remessa:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'VARNOMREM', ''));
  stlCampos.Add('Observação 1      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Observação 3      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  stlCampos.Add('Observação 4      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  stlCampos.Add('Observação 5      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  stlCampos.Add('Dias p/ protesto  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  stlCampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  stlCampos.Add('Arquivo Remessa   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo Retorno   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  stlCampos.Add('Responsável Bol.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', ''));
  stlCampos.Add('Prot. de aceite   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', ''));
  stlCampos.Add('Na importação do retorno considerar apenas duplicatas da empresa logada?:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DUPEMPLOG', ''));
  stlCampos.Add('Data Pagto Baixa  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SOLIDTA', ''));
  stlCampos.Add('Portador de baixa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Portador da remessa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', ''));
  stlCampos.Add('Conta de baixa    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Inf. adicional    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', ''));
  stlCampos.Add('Outros acréscimos :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OUTACRE', ''));
  stlCampos.Add('Envia mensagens   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'MANDMSG', ''));
  stlCampos.Add('Envia Sac/Avalista:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', ''));
  stlCampos.Add('Utl. Desconto de Duplicatas?:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'UTLDESDUP', ''));
  stlCampos.Add('Nome beneficiário :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', ''));
  stlCampos.Add('Endereço          :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', ''));
  stlCampos.Add('Bairro            :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', ''));
  stlCampos.Add('Complemento       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', ''));
  stlCampos.Add('Cidade            :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', ''));
  stlCampos.Add('Estado            :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', ''));
  stlCampos.Add('CEP               :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', ''));
  stlCampos.Add('CNPJ              :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', ''));
  stlCampos.Add('Exibe mensagens   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'EXIBMSG', ''));
  stlCampos.Add('Ocorrências a ignorar na baixa automática: ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OCOIGNORA', ''));
  stlCampos.Add('Utilizar Nomenclatura DSNAME?' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DSNAME', ''));
  stlCampos.Add('Valor da Tarifa:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', ''));
  stlCampos.Add('Portador:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', ''));
  stlCampos.Add('Fornecedor:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', ''));
  stlCampos.Add('Utiliza data de crédito para movimentação:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DTACRED', ''));
  stlCampos.Add('Considerar dias para crédito no lançamento de tarifa? :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIASCREDITOTARIFA', ''));
  stlCampos.Add('Permitir impressão de boletos? :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', ''));
  stlCampos.Add('Enviar parcelas em negrito quando layout for carnê? :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PARCELASNEGRITOCARNE', ''));
  stlCampos.Add('Enviar chave da Nf-e na remessa? :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ENV_NFE', 'N'));
end;

procedure TfrmConfigBancoCredVale.pGravaLogCarteira(stlCfgAnt : TStringList);
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
    pGravaLogAtb('962', 'BANCO CREDVALE', strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

procedure TfrmConfigBancoCredVale.edtDiasCreditoTarifaEnter(Sender: TObject);
begin
  inherited;
  pShowHint(edtDiasCreditoTarifa,'Aviso');
end;

procedure TfrmConfigBancoCredVale.edtDiasCreditoTarifaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBancoCredVale.edtDiasCreditoTarifaMouseEnter(Sender: TObject);
begin
  inherited;
  pShowHint(edtDiasCreditoTarifa,'Aviso');
end;

procedure TfrmConfigBancoCredVale.edtDiasCreditoTarifaMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

end.

