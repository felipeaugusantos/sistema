unit untConfigSantanderBan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Mask, DirectoryEditFocus, StrUtils,
  Buttons, ExtCtrls, QColorLabel, Menus, ComCtrls, ShellApi, AppEvnts, Uni,
  cxHint, ComboBoxFocus, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxDBLookupComboBox, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, UniClientDataSet, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, dxScreenTip, dxCustomHint, untTypesSistema,
  frxClass, frxExportCSVTestabilidade, cxContainer,
  cxTextEdit, cxMaskEdit, cxButtonEdit, cxCheckBox, dxBarBuiltInMenu, System.Generics.Collections,
  cxGroupBox, cxPC, Datasnap.DBClient, untCadOcoCartei, untCNFOCO_Class, untCNFOCO_Dao,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  untFrameDirectoryEditFocus, untFramePlanoDeContasMaskEdit, MaskEditFocus;

type
  TfrmConfigSantanderBan = class(TfrmPai)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
    HintControler: TcxHintStyleController;
    dtsConRet: TDataSource;
    dtsCadCta: TDataSource;
    dtsCadPor: TDataSource;
    btnCancelar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    BtnManual: TBitBtnLocked;
    BtnOcorrencia: TBitBtnLocked;
    cxPaginas: TcxPageControl;
    tbsGeral: TcxTabSheet;
    pnlAtivo1: TPanel;
    lblCodCart: TLabel;
    lblProNum: TLabel;
    lblIdentBanco: TLabel;
    lblCodAgenc: TLabel;
    lblContCorr: TLabel;
    lblDiasProt: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label5: TLabel;
    Label14: TLabel;
    lblResp: TLabel;
    ColorLabel1: TColorLabel;
    Label13: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ColorLabel4: TColorLabel;
    ColorLabel5: TColorLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    lbl1: TLabel;
    lblInfo: TLabel;
    Label19: TLabel;
    ColorLabel6: TColorLabel;
    Label20: TLabel;
    Label21: TLabel;
    ColorLabel2: TColorLabel;
    ColorLabel3: TColorLabel;
    lblCartSeq: TLabel;
    edtProxNumArqRem: TEditFocus;
    edtIdentBanc: TEditFocus;
    edtDiasProt: TEditFocus;
    edtContaCorr: TEditFocus;
    edtCodAgencia: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtObservacao5: TEditFocus;
    edtContaCobr: TEditFocus;
    edtDiasCred: TEditFocus;
    edtResp: TEditFocus;
    edtSacAva: TEditFocus;
    edtDupAgr: TEditFocus;
    cmbTipDia: TComboBoxFocus;
    edtPerMul: TEditFocus;
    cxgConRet: TcxGrid;
    cxgConRetDBTableView1: TcxGridDBTableView;
    cxgConRetDBTableView1Column1: TcxGridDBColumn;
    cxgConRetDBTableView1Column2: TcxGridDBColumn;
    cxgConRetDBTableView1Column3: TcxGridDBColumn;
    cxgConRetLevel1: TcxGridLevel;
    edtInfAdi: TEditFocus;
    cmbCodCar: TComboBoxFocus;
    cmbInstrucao1: TComboBoxFocus;
    cmbInstrucao2: TComboBoxFocus;
    edtConGar: TEditFocus;
    edtUtiConGar: TEditFocus;
    edtEnvNosNum: TEditFocus;
    edtProAce: TEditFocus;
    chkCartSeq: TCheckBox;
    edtCartSeq: TEditFocus;
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
    Label51: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    edtDesPorTar: TEditFocus;
    edtPorTar: TEditFocus;
    edtValorTarifa: TEditFocus;
    edtDesForTar: TEditFocus;
    edtForTar: TEditFocus;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    dsCnfOco: TDataSource;
    cdsCnfOco: TUniClientDataSet;
    cdsCnfOcoCNF_CODOCO: TStringField;
    cdsCnfOcoCNF_DESOCO: TStringField;
    cdsCnfOcoCNF_GERPAG: TBooleanField;
    cdsCnfOcoCNF_FORNEC: TStringField;
    cdsCnfOcoCNF_PORTAD: TStringField;
    cdsCnfOcoCNF_PLNCON: TStringField;
    cdsCnfOcoCNF_CUSCAR: TBooleanField;
    Label22: TLabel;
    edtAltNomRem: TEditFocus;
    ColorLabel7: TColorLabel;
    fraPathRemessa: TfraDirectoryEditFocus;
    fraPathRetorno: TfraDirectoryEditFocus;
    lblParNum: TLabel;
    edtParNum: TEditFocus;
    ColorLabel8: TColorLabel;
    ColorLabel9: TColorLabel;
    edt05Descon: TEditFocus;
    Label23: TLabel;
    fraPlanoDeContasBai: TfraPlanoDeContasMskEdit;
    fraPlanoDeContasEnc: TfraPlanoDeContasMskEdit;
    tbsComplemento: TcxTabSheet;
    pnlComplemento: TPanel;
    Label35: TLabel;
    ColorLabel10: TColorLabel;
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
    edtCodPorRem: TEditFocus;
    edtDescPorRem: TEditFocus;
    lblCodigoCarteiraRetorno: TLabel;
    edtCodigoCarteiraRetorno: TEditFocus;
    lblCodigoCarteiraRetornoSN: TColorLabel;
    lblDupEmpLog: TLabel;
    clDupEmpLog: TColorLabel;
    edtDupEmpLog: TEditFocus;
    clbPerImpBol: TColorLabel;
    edtPerImpBol: TEditFocus;
    lblPerImpBol: TLabel;
    lblParcelasNegritoCarne: TLabel;
    edtParcelasNegritoCarne: TEditFocus;
    clParcelasNegritoCarne: TColorLabel;
    procedure btnGravarClick(Sender: TObject);
    procedure pCarregaDados;
    procedure FormShow(Sender: TObject);
    procedure tabCarteiraChange(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure BtnManualClick(Sender: TObject);
    procedure edtContaCorrExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxgConRetEnter(Sender: TObject);
    procedure cxgConRetExit(Sender: TObject);
    procedure edtDiasCredEnter(Sender: TObject);
    procedure edtDiasCredExit(Sender: TObject);
    procedure btnConfigurarEnter(Sender: TObject);
    procedure btnConfigurarExit(Sender: TObject);
    procedure cmbInstrucao1Change(Sender: TObject);
    procedure cmbCodCarChange(Sender: TObject);
    procedure BtnOcorrenciaEnter(Sender: TObject);
    procedure BtnOcorrenciaExit(Sender: TObject);
    procedure BtnOcorrenciaClick(Sender: TObject);
    procedure edtConGarExit(Sender: TObject);
    procedure chkCartSeqClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtPorTarKeyPress(Sender: TObject; var Key: Char);
    procedure edtForTarKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddOcoClick(Sender: TObject);
    procedure btnEdtOcoClick(Sender: TObject);
    procedure btnRemOcoClick(Sender: TObject);
    procedure cxgConRetDBTableView1EditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure ApplicationEventsDeactivate(Sender: TObject);
    procedure fraPlanoDeContasBaiMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasEncMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure edtUsaSacExit(Sender: TObject);
    procedure edtCodPorRemKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;
    qryCadFor : TUniQuery;

    cdsConRet : TUniClientDataSet;
    qryPorCmb : TUniQuery;
    qryCtaCmb : TUniQuery;

    strCfg_PORPGR,
    strCfg_CTAGCP: String;

    procedure pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pGravaContasRetorno;
    procedure pcdsConRetAfterInsert(DataSet: TDataSet);
    procedure pcdsConRetBeforePost(DataSet: TDataSet);
    procedure pcdsConRetAfterPost(DataSet: TDataSet);
    procedure pcdsConRetBeforeEdit(DataSet: TDataSet);
    procedure pShowHint(edtEdit: TEditFocus; strTitulo: String);
    procedure pShowHintBotao(btnBotao: TBitBtnLocked; strTitulo: String);
    procedure pHideHint;
    function fCarregaCfg(Var stlCampos: TStringList): String;
    procedure pCarregaOcorrencias;

    function fPortadorContasAPagarDoCaixa(strCodPor: String): Boolean;
    function fPlanoDeContasContasAPagarDoCaixa(strCodCta: String): Boolean;
    function fValidaConRet(cdsConRet: TDataset): Boolean;
    function RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;

  public
    { Public declarations }
    blnNaoEditar: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigSantanderBan: TfrmConfigSantanderBan;
  lstRecada : TStringList;
  strContAnt: String;

  procedure pLeContasRetorno(cdsConRet: TUniClientDataSet; intTabInd: Integer);
  procedure pCriaCdsContaRetorno(Var cdsConRet: TUniClientDataSet;
                                     pcdsConRetAfterInsert,
                                     pcdsConRetBeforePost,
                                     pcdsConRetAfterPost,
                                     pcdsConRetBeforeEdit: TDataSetNotifyEvent);

implementation

uses untfuncoesSimples, untFuncoes,
     untPesqAux, untCfgGenericas_AutBan,  untConsultas, untMemo;

{$R *.dfm}

procedure TfrmConfigSantanderBan.btnConfigurarEnter(Sender: TObject);
begin
  inherited;
  btnConfigurar.Hint := 'Configurar percentual de ' + #13+#10 +
                        'juros para remessa.';
  pShowHintBotao(btnConfigurar, 'Cofigurações específicas.');
end;

procedure TfrmConfigSantanderBan.btnConfigurarExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSantanderBan.btnEditarClick(Sender: TObject);
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
      pSetFocus(cmbCodCar);
  end;

end;

procedure TfrmConfigSantanderBan.btnEdtOcoClick(Sender: TObject);
Var
  intRecNo_: Integer;
begin
  inherited;
  intRecNo_ := 0;
  If Not cdsCnfOco.isEmpty Then
  Begin
    intRecNo_ := cdsCnfOco.RecNo;
    frmCadOcoCartei := TfrmCadOcoCartei.Create(nil);
    frmCadOcoCartei.strCartei := 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp;
    frmCadOcoCartei.blnEditar := True;
    frmCadOcoCartei.edtCodOco.Text := cdsCnfOcoCNF_CODOCO.AsString;

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

procedure TfrmConfigSantanderBan.btnGravarClick(Sender: TObject);
  Var
    strCfgAnt,
    strCfgAtu,
    strCmpAlt,
    strMenCon: String;
    stlCfgAnt,
    stlCfgAtu: TStringList;
    intCont,
    intIndice,
    intIndice2: Integer;
begin
  inherited;

  Try
    If cdsConRet.State in [dsEdit, dsInsert] Then
      cdsConRet.Post;
  Except
    On E: EAbort Do
    Begin
      Exit;
    End;
  End;

  //Verificando as contas de retorno
  strMenCon := '';
  If lstRecada.Count > 0 Then
  Begin
    For intCont := 0 to lstRecada.Count - 1 do
      strMenCon := strMenCon + lstRecada[intCont] + ', ';
    pMensagemOK('Existe inconsistência nas Contas de Retorno cadastradas no arquivo de configuração. '
                + #13 + 'Favor recadastrar a(s) conta(s) ' + Copy(strMenCon,1 , Length(strMenCon) - 2) + '.');
    Exit;
  End;

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
      If edtProxNumArqRem.Text <> fRetProxNumAutBan('CONFIG033B-' + edtCartSeq.Text) Then
      Begin
        If fMensagem('ATENÇÃO','Ao utilizar a sequência do arquivo de remessa de outra carteira, o campo Último Núm. de Seq. Arq. Remessa será sobrescrito pelo da carteira principal. Deseja continuar?',['&SIM', '&NÃO'], 1) = 2 Then
          Exit;
      End;
    End;

    //Verificando Portadores e Plano de Contas da cdsConRet
    If Not fValidaConRet(cdsConRet) Then
      Exit;

    Try
      stlCfgAnt := TStringList.Create;
      strCfgAnt := fCarregaCfg(stlCfgAnt);
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', IIF(chkCartSeq.Checked, fRetProxNumAutBan('CONFIG033B-' + edtCartSeq.Text), edtProxNumArqRem.Text));
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', LeftStr(cmbCodCar.Text, 1));
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', edtIdentBanc.Text    );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text   );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text    );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAB', edtContaCobr.Text    );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text     );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text         );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', LeftStr(cmbInstrucao1.Text, 2));
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', LeftStr(cmbInstrucao2.Text, 2));
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessa.edtDirectory.Text  );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetorno.edtDirectory.Text  );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text       );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text       );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContasBai.MskCodCta.Text);
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text  );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text  );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text  );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text  );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text  );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text     );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text       );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'DUPEMPLOG', edtDupEmpLog.Text       );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PARCNUM', edtParNum.Text       );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), '05DESCON', edt05Descon.Text       );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVNOSN', edtEnvNosNum.Text    );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'MSACAVA', edtSacAva.Text       );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVDPAG', edtDupAgr.Text       );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', edtPerMul.Text       );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text       );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'UTICGAR', edtUtiConGar.Text    );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'CONGARA', edtConGar.Text       );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPDIA' , IntToStr(cmbTipDia.ItemIndex+1));
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', IIF(chkCartSeq.Checked, 'S', 'N'));
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', IIF(chkCartSeq.Checked, edtCartSeq.Text, ''));
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', edtPorTar.Text    );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', fraPlanoDeContasEnc.MskCodCta.Text );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', edtForTar.Text    );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', edtValorTarifa.Text  );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMREME', edtAltNomRem.Text       );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', edtPerImpBol.Text);
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PARCELASNEGRITOCARNE', edtParcelasNegritoCarne.Text);

      // dados beneficiario
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', edtUsaSac.Text        );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', edtDesBen.Text        );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', edtEndBen.Text        );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', edtBaiBen.Text        );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', edtCompBen.Text       );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', edtCidBen.Text        );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', edtEstBen.Text        );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', edtCepBen.Text        );
      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', edtCgCBen.Text        );

      fGetBancoConfig(1, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'TRACARTRET', edtCodigoCarteiraRetorno.Text);

      pGravaContasRetorno;

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        pBackupCnfBco;
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        edtProxNumArqRem.Enabled := False;
        pSetFocus(cmbCodCar);
        blnMudarFoco := True;
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

      stlCfgAtu := TStringList.Create;
      strCfgAtu := fCarregaCfg(stlCfgAtu);
      strCmpAlt := '';

      If stlCfgAtu.Count > stlCfgAnt.Count Then
      Begin
        intIndice := stlCfgAnt.Count;
        intIndice2:= stlCfgAtu.Count - 1;

        For intCont := intIndice To intIndice2 Do
          stlCfgAnt.Add(Copy(stlCfgAtu.Strings[intCont], 01, 14));
      End
      Else If stlCfgAtu.Count < stlCfgAnt.Count Then
      Begin
        intIndice := stlCfgAtu.Count;
        intIndice2:= stlCfgAnt.Count - 1;

        For intCont := intIndice To intIndice2 Do
          stlCfgAtu.Add(Copy(stlCfgAnt.Strings[intCont], 01, 14));
      End;

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
        pGravaLogAtb('033', 'SANTANDER', 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                     strLoginUsuarioLogado, VS_StrCodEmp, strCfgAnt, strCfgAtu, strCmpAlt);

      pCarregaDados;
    Except
      On E:Exception Do
      Begin
        fMensagem('Erro','Ocorreu um erro ao tentar salvar os dados.' + #13 + E.Message,['&O K']);
      End;
    End;
  End;
  FreeAndNil(stlCfgAnt);
  FreeAndNil(stlCfgAtu);
end;

procedure TfrmConfigSantanderBan.pCarregaDados;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************AF*}
  If fEmptyStr(fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'PROXNUM','')) Then
  Begin
    edtProxNumArqRem.Enabled := True;
    edtProxNumArqRem.Clear;
    pSetFocus(edtProxNumArqRem);
  End
  Else
  Begin
    edtProxNumArqRem.Text := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'PROXNUM','');
    edtProxNumArqRem.Enabled := False;
    pSetFocus(cmbCodcar);
  End;

  if (strLoginUsuarioLogado='997') or(strLoginUsuarioLogado='998') or (strLoginUsuarioLogado='999') Then
  begin
    edtProxNumArqRem.Enabled := True;
    pSetFocus(edtProxNumArqRem);
  End;

  If fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'CODCART','') = '1' Then
    cmbCodCar.ItemIndex := 0
  Else If fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'CODCART','') = '3' Then
    cmbCodCar.ItemIndex := 1
  Else If fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'CODCART','') = '4' Then
    cmbCodCar.ItemIndex := 2
  Else If fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'CODCART','') = '5' Then
    cmbCodCar.ItemIndex := 3
  Else If fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'CODCART','') = '6' Then
    cmbCodCar.ItemIndex := 4
  Else If fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'CODCART','') = '7' Then
    cmbCodCar.ItemIndex := 5
  Else
    cmbCodCar.ItemIndex := -1;

  edtIdentBanc.Text     := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'IDENTBC','');
  edtCodAgencia.Text    := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'CODAGEN','');
  edtContaCorr.Text     := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'NUMCTAC','');
  edtContaCobr.Text     := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'NUMCTAB','');
  edtDiasProt.Text      := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'DIAPROT','');
  edtResp.Text          := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'RESPONS','');

  If fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'UTICGAR','') = '' Then
  Begin
    edtUtiConGar.Text := 'N';
    edtConGar.Enabled := False;
    edtConGar.Clear;
  end
  else
    edtUtiConGar.Text     := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'UTICGAR','');

  if fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'UTICGAR','') = 'S' Then
    edtConGar.Enabled := True;

  edtConGar.Text        := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'CONGARA','');

  If fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU1','') = '00' Then
    cmbInstrucao1.ItemIndex := 0
  Else If fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU1','') = '02' Then
    cmbInstrucao1.ItemIndex := 1
  Else If fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU1','') = '03' Then
    cmbInstrucao1.ItemIndex := 2
  Else If fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU1','') = '04' Then
    cmbInstrucao1.ItemIndex := 3
  Else If fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU1','') = '06' Then
    cmbInstrucao1.ItemIndex := 4
  Else If fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU1','') = '07' Then
    cmbInstrucao1.ItemIndex := 5
  Else If fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU1','') = '08' Then
    cmbInstrucao1.ItemIndex := 6
  Else
    cmbInstrucao1.ItemIndex := -1;

  If fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU2','') = '00' Then
    cmbInstrucao2.ItemIndex := 0
  Else If fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU2','') = '02' Then
    cmbInstrucao2.ItemIndex := 1
  Else If fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU2','') = '03' Then
    cmbInstrucao2.ItemIndex := 2
  Else If fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU2','') = '04' Then
    cmbInstrucao2.ItemIndex := 3
  Else If fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU2','') = '06' Then
    cmbInstrucao2.ItemIndex := 4
  Else If fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU2','') = '07' Then
    cmbInstrucao2.ItemIndex := 5
  Else If fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU2','') = '08' Then
    cmbInstrucao2.ItemIndex := 6
  Else
    cmbInstrucao2.ItemIndex := -1;

  edtDesPor.Text := '';
  edtDescPorRem.Text := '';
  fraPlanoDeContasBai.edtDesCta.Text := '';

  edtObservacao1.Text   := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'OBSERV1','');
  edtObservacao2.Text   := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'OBSERV2','');
  edtObservacao3.Text   := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'OBSERV3','');
  edtObservacao4.Text   := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'OBSERV4','');
  edtObservacao5.Text   := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'OBSERV5','');

  fraPathRemessa.edtDirectory.Text := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'PATHREM','');
  fraPathRetorno.edtDirectory.Text := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'PATHRET','');

  edtCodPor.Text        := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'PORBAI_','');
  edtCodPorRem.Text      := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');
  fraPlanoDeContasBai.MskCodCta.Text := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'CTABAI_','');
  edtDiasCred.Text      := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'DIACRED','');
  edtProAce.Text        := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'PROACEI','');
  edtDupEmpLog.Text     :=  fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'DUPEMPLOG','');
  edtParNum.Text        := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'PARCNUM',' ');
  edt05Descon.Text        := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'05DESCON',' ');
  edtEnvNosNum.Text     := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'ENVNOSN','N');
  edtSacAva.Text        := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'MSACAVA','');
  edtDupAgr.Text        := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'ENVDPAG','');
  edtAltNomRem.Text     := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'NOMREME','N');
  edtPerMul.Text        := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'PERMULT','');
  edtInfAdi.Text        := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'INFADIC', '');
  cmbTipDia.ItemIndex   := StrToIntDef(fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'TIPDIA', '1'),0)-1;
  chkCartSeq.Checked    := (fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', '') = 'S');
  edtCartSeq.Text       := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', '');
  edtPorTar.Text         := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', '');
  fraPlanoDeContasEnc.MskCodCta.Text := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', '');
  edtForTar.Text         := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', '');
  edtValorTarifa.Text    := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', '');

  If fEmptyStr(edtDupEmpLog.Text) Then
    edtDupEmpLog.Text := 'N';

  edtPerImpBol.Text     := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', '');
  If fEmptyStr(edtPerImpBol.Text) Then
    edtPerImpBol.Text := 'S';

  edtParcelasNegritoCarne.Text := fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PARCELASNEGRITOCARNE', '');
  If fEmptyStr(edtParcelasNegritoCarne.Text) Then
    edtParcelasNegritoCarne.Text := 'N';

  chkCartSeq.OnClick(chkCartSeq);

  pLeContasRetorno(cdsConRet, Succ(tabCarteira.TabIndex));

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCodPorRem.Text ) Then
    pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);


  If Not fEmptyStr( fraPlanoDeContasBai.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContasBai.MskCodCta.Text, fraPlanoDeContasBai.edtDesCta);

  If Not fEmptyStr( edtPorTar.Text ) Then pCarregaPortador(edtPorTar.Text, edtDesPorTar);
  If Not fEmptyStr( fraPlanoDeContasEnc.MskCodCta.Text ) Then pCarregaCentroCusto(fraPlanoDeContasEnc.MskCodCta.Text, fraPlanoDeContasEnc.edtDesCta);

  If Not fEmptyStr( edtForTar.Text ) Then
  begin
    pPesquisaCadFor(qryCadFor, qryCadFor, edtForTar.Text);
    edtDesForTar.Text  := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
  end;

  pCarregaOcorrencias;
  edtParNum.Enabled := (edtResp.Text = 'E');
  edtParNum.Text := IIF((edtResp.Text = 'E'),IIF(fEmptyStr(edtParNum.Text),'N',edtParNum.Text),'N');
  edt05Descon.Text := IIF(fEmptyStr(edt05Descon.Text),'N',edt05Descon.Text);

  edtCodigoCarteiraRetorno.Text := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'TRACARTRET', '');
  If edtCodigoCarteiraRetorno.Text = '' THen
    edtCodigoCarteiraRetorno.Text := 'N';

  //Dados Beneficiário
  edtUsaSac.Text        := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', '');
  edtUsaSac.Text        := IIF(fEmptyStr(edtUsaSac.Text), 'N', edtUsaSac.Text);
  edtDesBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', ''), '');
  edtEndBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', ''), '');
  edtBaiBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', ''), '');
  edtCompBen.Text       := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', ''), '');
  edtCidBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', ''), '');
  edtEstBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', ''), '');
  edtCepBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', ''), '');
  edtCgcBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', ''), '');

  fValidaCampos(edtUsaSac);
end;

procedure TfrmConfigSantanderBan.pCarregaOcorrencias;
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

  pDesmembraCarteira('CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp, strCodBco,
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
        cdsCnfOcoCNF_FORNEC.AsString := objCnfOco.strCodFor + ' - ' + fRetNomFornecedor(objCnfOco.strCodFor);
        cdsCnfOcoCNF_PORTAD.AsString := objCnfOco.strCodPor + ' - ' + fRetNomPortador(objCnfOco.strCodPor);
        cdsCnfOcoCNF_PLNCON.AsString := objCnfOco.strCodCta + ' - ' + fRetDescCentroCusto(objCnfOco.strCodCta);
        Post;
      End;
    End;
  End;

  lstCnfOco.Free;
  objCnfDao.Free;

  cdsCnfOco.First;
  cdsCnfOco.EnableControls;
end;

procedure TfrmConfigSantanderBan.pGravaContasRetorno;
  Var
    intIndice: Integer;
Begin
  fGetBancoConfig(1,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'NROCONTAS', IntToStr(cdsConRet.RecordCount));
  fGetBancoConfig(2,'CONFIG033BCONRET-' + IntToStr(tabCarteira.TabIndex + 1), '', '');

  With cdsConRet Do
  Begin
    intIndice := 0;
    First;
    While Not Eof Do
    Begin
      Inc(intIndice);

      fGetBancoConfig(1,'CONFIG033BCONRET-' + IntToStr(tabCarteira.TabIndex + 1),
                      'CONRET' + IntToStr(intIndice), FieldByName('CONRET').AsString);

      fGetBancoConfig(1,'CONFIG033BCONRET-' + IntToStr(tabCarteira.TabIndex + 1),
                      'PORBAI' + IntToStr(intIndice), FieldByName('PORBAI').AsString);

      fGetBancoConfig(1,'CONFIG033BCONRET-' + IntToStr(tabCarteira.TabIndex + 1),
                      'CONBAI' + IntToStr(intIndice), FieldByName('CONBAI').AsString);
      Next;
    End;
  End;

End;

procedure TfrmConfigSantanderBan.pHideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmConfigSantanderBan.pShowHint(edtEdit: TEditFocus;
  strTitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,edtEdit.ClientOrigin.Y, strTitulo, edtEdit.Hint);
end;

procedure TfrmConfigSantanderBan.pShowHintBotao(btnBotao: TBitBtnLocked;
  strTitulo: String);
begin
  HintControler.ShowHint(btnBotao.ClientOrigin.X,btnBotao.ClientOrigin.Y, strTitulo, btnBotao.Hint);
end;

function TfrmConfigSantanderBan.RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;
begin
  While Not Sender.ClassName.Equals('TcxTabSheet') Do
  Begin
    Sender := Sender.Parent;
  End;
  Result := TcxTabSheet(Sender);
end;

procedure TfrmConfigSantanderBan.FormShow(Sender: TObject);
begin
  inherited;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  pCarregaDados;
  If edtProxNumArqRem.Enabled Then
    pSetFocus(edtProxNumArqRem)
  Else
    pSetFocus(cmbCodcar);

  pnlAtivo1.Enabled := False;
  pnlComplemento.Enabled := pnlAtivo1.Enabled;
  pnlAtivo2.Enabled := False;

  strCfg_PORPGR := fCfgSis('PORPGR');
  strCfg_CTAGCP := fCfgSis('CTAGCP');

  pSetFocus(btnEditar);

  if blnNaoEditar then
  begin
    btnConfigurar.Enabled := False;
    btnConfigurar.Visible := False;
    btnGravar.Enabled     := True;
    btnEditar.Visible     := False;
    pSetFocus(btnGravar);
  end;

end;

function TfrmConfigSantanderBan.fPortadorContasAPagarDoCaixa(
  strCodPor: String): Boolean;
begin
  Result := (Not fEmptyStr(strCfg_PORPGR)) And
            (strCfg_PORPGR = strCodPor);
end;

procedure TfrmConfigSantanderBan.fraPlanoDeContasBaiMskCodCtaKeyPress(
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

procedure TfrmConfigSantanderBan.fraPlanoDeContasEncMskCodCtaKeyPress(
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

function TfrmConfigSantanderBan.fPlanoDeContasContasAPagarDoCaixa(
  strCodCta: String): Boolean;
begin
  Result := (Not fEmptyStr(strCfg_CTAGCP)) And
            (strCfg_CTAGCP = strCodCta);
end;

function TfrmConfigSantanderBan.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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

    Else If (Sender = cmbCodCar) Then
    Begin

      If cmbCodCar.ItemIndex = -1 Then
      Begin
        fMensagem('', 'Carteira deve ser preenchida!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

      If Result Then
        edtIdentBanc.Text := '033';

    End

    Else If (Sender = cmbInstrucao1) Then
    Begin

      If cmbInstrucao1.ItemIndex = -1 Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else
      If cmbInstrucao1.ItemIndex = 0 Then
      Begin
        cmbInstrucao2.ItemIndex := 0;
        cmbInstrucao2.Enabled := False;
      End
      Else
        cmbInstrucao2.Enabled := True;

    End

    Else If (Sender = cmbInstrucao2) Then
    Begin

      If cmbInstrucao2.ItemIndex = -1 Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else
      If (cmbInstrucao2.ItemIndex In [1,2,3]) And
         (cmbInstrucao1.ItemIndex In [1,2,3]) Then
      Begin
        fMensagem('','A Instrução 2 está em conflito com a Instrução 1! Informe o código 00, 06, 07 ou 08 para instrução 2.'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else
      If (cmbInstrucao2.ItemIndex In [4,5]) And
         (cmbInstrucao1.ItemIndex In [4,5]) Then
      Begin
        fMensagem('','A Instrução 2 está em conflito com a Instrução 1! Informe o código 00, 04, 03, 04 ou 08 para instrução 2.'+strMensagemConfig,['&OK']);
        Result := False;
      End;

    End

    Else If Sender = edtResp Then
    Begin

      If (edtResp.Text <> 'B') And (edtResp.Text <> 'E') Then
      Begin
        fMensagem('','O campo Resp. por emissão de boletos deve ser B ou E!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
      edtParNum.Enabled := (edtResp.Text = 'E');
      edtParNum.Text := IIF((edtResp.Text = 'E'),IIF(fEmptyStr(edtParNum.Text),'N',edtParNum.Text),'N');
    End
    Else If Sender = edtUtiConGar Then
    Begin

      If Pos(edtUtiConGar.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Conta Garantida deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else
      If (edtUtiConGar.Text = 'S') Then
      begin
        edtConGar.Enabled := True;
      end
      Else
      begin
        edtConGar.Enabled := False;
        edtConGar.Clear;
      end;
    End
    Else If Sender = edtConGar Then
    Begin
      If (edtUtiConGar.Text = 'S') And  fEmptyStr(edtConGar.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Número da Conta Garantida deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End
      Else If (edtUtiConGar.Text = 'S') And (Length(edtConGar.Text) <> edtConGar.MaxLength) Then
      Begin
        fMensagem('ATENÇÃO','O campo Número da Conta Garantida deve ter 10 caracteres!'+strMensagemConfig, ['&Ok']);
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
      Else
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
        Else If fPortadorContasAPagarDoCaixa(TEditFocus(Sender).Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Portador ' + strCfg_PORPGR + ' não permitido, pois está configurado para ' +
                               'baixa de Contas a Pagar no Resumo de Caixa.' + strMensagemConfig, ['&Ok']);
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
      End;


      grpBeneficiario.Enabled := edtUsaSac.Text = 'S';
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
        Else If fPlanoDeContasContasAPagarDoCaixa(TEditFocus(Sender).Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Plano de Contas ' + strCfg_CTAGCP + ' não permitido, pois está configurado para ' +
                               'baixa de Contas a Pagar no Resumo de Caixa.' + strMensagemConfig, ['&Ok']);
          Result := False;
        End
        else
        begin
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
      If Pos(edtProAce.Text, 'SN') <= 0 Then
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


    Else If Sender = edtParNum Then
    Begin
      If Pos(edtParNum.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Utilizar Parcela Numeral deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edt05Descon Then
    Begin
      If Pos(edt05Descon.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Ocorrência 05 é Descontada deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtCodigoCarteiraRetorno Then
    Begin
      If Pos(edtCodigoCarteiraRetorno.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Tratar conta pelo código da carteira no retorno deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtDupAgr Then
    Begin
      If Pos(edtDupAgr.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Enviar Núm. Dupl. Agrupadas deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtAltNomRem Then
    Begin
      If Pos(edtAltNomRem.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Permitir alterar nomenclatura do arquivo remessa deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtSacAva Then
    Begin

      If Pos(edtSacAva.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Mostrar Sacador Avalista deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else If (edtUsaSac.Text = 'S') Then
      Begin
        If (edtSacAva.Text = 'N') Then
        Begin
          fMensagem('','O campo Mostrar Sacador Avalista deve ser preenchido com (S)im pois essa carteira está configurado para enviar sacador avalista!'+strMensagemConfig,['&O K']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtEnvNosNum) Then
    Begin
      If Pos(edtEnvNosNum.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo atual deve ser preenchido com (S/N)!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender.Owner = fraPathRemessa) And (Sender.name = 'edtDirectory') Then
    Begin

      If fEmptyStr(fraPathRemessa.edtDirectory.Text) Then
      Begin
        fMensagem('','Preencha o campo Path de remessa!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender.Owner = fraPathRetorno) And (Sender.name = 'edtDirectory') Then
    Begin

      If fEmptyStr(fraPathRetorno.edtDirectory.Text) Then
      Begin
        fMensagem('','Preencha o campo Path de retorno!'+strMensagemConfig,['&O K']);
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
        Else If fPortadorContasAPagarDoCaixa(TEditFocus(Sender).Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Portador ' + strCfg_PORPGR + ' não permitido, pois está configurado para ' +
                               'baixa de Contas a Pagar no Resumo de Caixa.' + strMensagemConfig, ['&Ok']);
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

    Else If (Sender.Owner = fraPlanoDeContasBai) And (Sender.name = 'MskCodCta') Then
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
        Else If fPlanoDeContasContasAPagarDoCaixa(TEditFocus(Sender).Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Plano de Contas ' + strCfg_CTAGCP + ' não permitido, pois está configurado para ' +
                               'baixa de Contas a Pagar no Resumo de Caixa.' + strMensagemConfig, ['&Ok']);
          Result := False;
        End
        Else
          Result := PlanoDeContasAtivo(fraPlanoDeContasBai.MskCodCta.Text,True);
      End;

    End

    Else If (Sender = edtCodAgencia) Then
    Begin
      If fEmptyStr(edtCodAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Código da Agência deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End
      Else If Length(edtCodAgencia.Text) <> edtCodAgencia.MaxLength Then
      Begin
        fMensagem('ATENÇÃO','O campo Código da Agência deve ter 4 caracteres!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtContaCorr) Then
    Begin
      If fEmptyStr(edtContaCorr.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Número da Conta Corrente deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End
      Else If Length(edtContaCorr.Text) <> edtContaCorr.MaxLength Then
      Begin
        fMensagem('ATENÇÃO','O campo Número da Conta Corrente deve ter 8 caracteres!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtContaCobr) Then
    Begin
      If fEmptyStr(edtContaCobr.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Número da Conta Cobrança deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End
      Else If Length(edtContaCobr.Text) <> edtContaCobr.MaxLength Then
      Begin
        fMensagem('ATENÇÃO','O campo Número da Conta Cobrança deve ter 10 caracteres!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtDiasProt) Then
    Begin
      If (cmbInstrucao1.ItemIndex = 4) Or
         (cmbInstrucao2.ItemIndex = 4) Then
      Begin
        If fEmptyStr(edtDiasProt.Text) Then
        Begin
          fMensagem('ATENÇÃO','O campo Quantidade de dias para protesto deve ser preenchido!'+strMensagemConfig, ['&Ok']);
          Result := False;
        End
        Else If StrToInt(edtDiasProt.Text) <= 0 Then
        Begin
          fMensagem('ATENÇÃO','O campo Quantidade de dias para protesto deve ser maior que zero!'+strMensagemConfig, ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = chkCartSeq) Then
    Begin
      If (chkCartSeq.Checked) Then
      Begin
        If fVerificaCartPrimariaAutBan('CONFIG033B-', tabCarteira.TabIndex + 1) Then
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
          If fEmptyStr(fGetBancoConfig(0, 'CONFIG033B-' + edtCartSeq.Text, 'PROXNUM', '')) Then
          Begin
            fMensagem('ATENÇÃO','Não pode ser usada essa carteira no campo Carteira Seq., pois essa não possui Último Núm. Seq. Remessa cadastrado!' ,['&O K']);
            Result := False;
          End
          Else
          If fVerificaCartFilhaAutBan('CONFIG033B-' + edtCartSeq.Text) Then
          Begin
            fMensagem('ATENÇÃO','Não pode ser usada essa carteira no campo Carteira Seq., pois essa já possui uma Carteira Seq. cadastrada!' ,['&O K']);
            Result := False;
          End;
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

function TfrmConfigSantanderBan.fValidaConRet(cdsConRet: TDataset): Boolean;
begin
  Result := cdsConret.IsEmpty;

  If Not Result Then
  Begin
    Result := (fEmptyStr(strCfg_PORPGR)) Or
              (Not cdsConret.Locate('PORBAI', strCfg_PORPGR, []));

    If Not Result Then
    Begin
      fMensagem('ATENÇÃO', 'Portador ' + strCfg_PORPGR + ' não permitido, pois está configurado para ' +
                           'baixa de Contas a Pagar no Resumo de Caixa.', ['&Ok']);

      Exit;
    End;

    Result := (fEmptyStr(strCfg_CTAGCP)) Or
              (Not cdsConret.Locate('CONBAI', strCfg_CTAGCP, []));

    If Not Result Then
      fMensagem('ATENÇÃO', 'Plano de Contas ' + strCfg_CTAGCP + ' não permitido, pois está configurado para ' +
                           'baixa de Contas a Pagar no Resumo de Caixa.', ['&Ok']);
  End;
end;

procedure TfrmConfigSantanderBan.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
  cxPaginas.ActivePage := tbsGeral;
end;

procedure TfrmConfigSantanderBan.tabCarteiraChanging(Sender: TObject;
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

procedure TfrmConfigSantanderBan.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodPor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConfigSantanderBan.edtCodPorRemKeyPress(Sender: TObject;
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


procedure TfrmConfigSantanderBan.edtDiasCredEnter(Sender: TObject);
begin
  inherited;
  edtDiasCred.Hint := 'Informar quantidade de dias ' + #13+#10 +
                      'do intervalo entre a efetuação ' + #13+#10 +
                      'do pagamento e o crédito na ' + #13+#10 +
                      'conta corrente.';

  pShowHint(edtDiasCred, 'Dias para Crédito');
end;

procedure TfrmConfigSantanderBan.edtDiasCredExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSantanderBan.edtForTarKeyPress(Sender: TObject;
  var Key: Char);
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

procedure TfrmConfigSantanderBan.edtPorTarKeyPress(Sender: TObject;
  var Key: Char);
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

procedure TfrmConfigSantanderBan.edtUsaSacExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtUsaSac);
end;

function TfrmConfigSantanderBan.fCarregaCfg(Var stlCampos: TStringList): String;
  Var
    intNroCon : Integer;
    intIndice : Integer;
begin
  Result := '';
  Result := Result + 'Seq. remessa      :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '') + #13+#10;
  stlCampos.Add('Seq. remessa      :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  Result := Result + 'Cód. carteira     :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', '') + #13+#10;
  stlCampos.Add('Cód. carteira     :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', ''));
  Result := Result + 'Cód. da agência   :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '') + #13+#10;
  stlCampos.Add('Cód. da agência   :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  Result := Result + 'Ident. no banco   :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', '') + #13+#10;
  stlCampos.Add('Ident. no banco   :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', ''));
  Result := Result + 'Cód. da C/C       :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', '') + #13+#10;
  stlCampos.Add('Cód. da C/C       :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  Result := Result + 'Conta cobrança    :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAB', '') + #13+#10;
  stlCampos.Add('Conta cobrança    :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAB', ''));
  Result := Result + 'Dias p/ protesto  :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '') + #13+#10;
  stlCampos.Add('Dias p/ protesto  :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  Result := Result + 'Responsável Bol.  :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', '') + #13+#10;
  stlCampos.Add('Responsável Bol.  :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', ''));
  Result := Result + 'Observação 1      :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '') + #13+#10;
  stlCampos.Add('Observação 1      :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  Result := Result + 'Observação 2      :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '') + #13+#10;
  stlCampos.Add('Observação 2      :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  Result := Result + 'Observação 3      :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '') + #13+#10;
  stlCampos.Add('Observação 3      :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  Result := Result + 'Observação 4      :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '') + #13+#10;
  stlCampos.Add('Observação 4      :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  Result := Result + 'Observação 5      :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '') + #13+#10;
  stlCampos.Add('Observação 5      :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  Result := Result + 'Arquivo remessa   :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '') + #13+#10;
  stlCampos.Add('Arquivo remessa   :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  Result := Result + 'Arquivo retorno   :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '') + #13+#10;
  stlCampos.Add('Arquivo retorno   :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  Result := Result + 'Portador de baixa :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '') + #13+#10;
  stlCampos.Add('Portador de baixa :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  Result := Result + 'Portador da remessa :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '') + #13+#10;
  stlCampos.Add('Portador da remessa :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', ''));
  Result := Result + 'Conta de baixa    :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '') + #13+#10;
  stlCampos.Add('Conta de baixa    :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  Result := Result + 'Dias p/ crédito   :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', '') + #13+#10;
  stlCampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  Result := Result + 'Protocolo aceite  :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', '') + #13+#10;
  stlCampos.Add('Protocolo aceite  :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', ''));
  Result := Result + 'Na importação do retorno considerar apenas duplicatas da empresa logada?  :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'DUPEMPLOG', '') + #13+#10;
  stlCampos.Add('Na importação do retorno considerar apenas duplicatas da empresa logada?  :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'DUPEMPLOG', ''));
  Result := Result + 'Cód. instrução 1  :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '') + #13+#10;
  stlCampos.Add('Cód. instrução 1  :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', ''));
  Result := Result + 'Cód. instrução 2  :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', '') + #13+#10;
  stlCampos.Add('Cód. instrução 2  :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', ''));
  Result := Result + 'Inf. adicional    :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', '') + #13+#10;
  stlCampos.Add('Inf. adicional    :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', ''));
  Result := Result + 'Env.nro. dup. agr.:' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVDPAG', '') + #13+#10;
  stlCampos.Add('Env.nro. dup. agr.:' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVDPAG', ''));
  Result := Result + 'Percentual multa  :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', '') + #13+#10;
  stlCampos.Add('Percentual multa  :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', ''));
  Result := Result + 'Tipo dias (U/C)   :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPDIA' , '') + #13+#10;
  stlCampos.Add('Tipo dias (U/C)   :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPDIA', ''));
  Result := Result + 'Env. nos. número  :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVNOSN', '') + #13+#10;
  stlCampos.Add('Env. nos. número  :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVNOSN', ''));
  Result := Result + 'Mostra sac. aval. :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'MSACAVA', '') + #13+#10;
  stlCampos.Add('Mostra sac. aval. :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'MSACAVA', ''));
  Result := Result + 'Uti. C. Garantida :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'UTICGAR', '') + #13+#10;
  stlCampos.Add('Uti. C. Garantida :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'UTICGAR', ''));
  Result := Result + 'Conta Garantida   :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'CONGARA', '') + #13+#10;
  stlCampos.Add('Conta Garantida   :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'CONGARA', ''));
  Result := Result + 'Utilizar Seq. de Outra Carteira:' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', '') + #13+#10;
  stlCampos.Add('Utilizar Seq. de Outra Carteira:' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', ''));
  Result := Result + 'Carteira Seq.     :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', '') + #13+#10;
  stlCampos.Add('Carteira Seq.     :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', ''));
  Result := Result + 'Gera Remessa local:' + fGetBancoConfig(0, 'CONFIG033B', 'RELOCAL',  '') + #13+#10;
  stlCampos.Add('Gera Remessa local:' + fGetBancoConfig(0, 'CONFIG033B', 'RELOCAL',  ''));
  Result := Result + 'Juros (%)         :' + fGetBancoConfig(0, 'CONFIG033B', 'JUROSDI',  '') + #13+#10;
  stlCampos.Add('Juros (%)         :' + fGetBancoConfig(0, 'CONFIG033B', 'JUROSDI',  ''));
  Result := Result + 'Não deixa val div :' + fGetBancoConfig(0, 'CONFIG033B', 'BAIDIVAUT','') + #13+#10;
  stlCampos.Add('Não deixa val div :' + fGetBancoConfig(0, 'CONFIG033B', 'BAIDIVAUT',''));

  Result := Result + 'Ocorrência 05 é Descontada:' + fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'05DESCON', '') + #13+#10;
  stlCampos.Add('Ocorrência 05 é Descontada:' + fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'05DESCON', ''));

  Result := Result + 'Contas Retorno    :' + fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'NROCONTAS', '') + #13+#10;
  stlCampos.Add('Contas Retorno    :' + fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'NROCONTAS', ''));

  Result := Result + 'Enc.Ban. Vr Tarifa:' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', '') + #13+#10;
  stlCampos.Add('Enc.Ban. Vr Tarifa:' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', ''));
  Result := Result + 'Enc.Ban. Portador :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', '') + #13+#10;
  stlCampos.Add('Enc.Ban. Portador :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', ''));
  Result := Result + 'Enc.Ban. Pl Conta :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', '') + #13+#10;
  stlCampos.Add('Enc.Ban. Pl Conta :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', ''));
  Result := Result + 'Enc.Ban. Fornec.  :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', '') + #13+#10;
  stlCampos.Add('Enc.Ban. Fornec.  :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', ''));
  Result := Result + 'Permitir alterar nomenclatura do arquivo remessa?' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMREME', '') + #13+#10;
  stlCampos.Add('Permitir alterar nomenclatura do arquivo remessa?' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMREME', ''));
  Result := Result + 'Utilizar Parcela Numeral?' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PARCNUM', '') + #13+#10;
  stlCampos.Add('Utilizar Parcela Numeral?' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PARCNUM', ''));
  Result := Result + 'Tratar conta pelo código da carteira no retorno?' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'TRACARTRET', '') + #13+#10;
  stlCampos.Add('Tratar conta pelo código da carteira no retorno?' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'TRACARTRET', ''));
  stlCampos.Add('Permitir impressão de boletos? :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', ''));
  stlCampos.Add('Enviar parcelas em negrito quando layout for carnê? :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'PARCELASNEGRITOCARNE', ''));

  intNroCon := StrToIntDef(fGetBancoConfig(0,'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1),'NROCONTAS','0'), 0);

  For intIndice := 0 To intNroCon Do
  Begin
      Result := Result + 'Conta ret.' + IntToStr(intIndice) + '       :' + fGetBancoConfig(0,'CONFIG033BCONRET-' + IntToStr(tabCarteira.TabIndex + 1), 'CONRET' + IntToStr(intIndice),'') + #13+#10;
      stlCampos.Add('Conta ret.' + IntToStr(intIndice) + '       :' + fGetBancoConfig(0,'CONFIG033BCONRET-' + IntToStr(tabCarteira.TabIndex + 1), 'CONRET' + IntToStr(intIndice),''));
      Result := Result + 'Portador' + IntToStr(intIndice) + '         :' + fGetBancoConfig(0,'CONFIG033BCONRET-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI' + IntToStr(intIndice),'') + #13+#10;
      stlCampos.Add('Portador' + IntToStr(intIndice) + '         :' + fGetBancoConfig(0,'CONFIG033BCONRET-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI' + IntToStr(intIndice),''));
      Result := Result + 'Conta bai.' + IntToStr(intIndice) + '       :' + fGetBancoConfig(0,'CONFIG033BCONRET-' + IntToStr(tabCarteira.TabIndex + 1), 'CONBAI' + IntToStr(intIndice),'') + #13+#10;
      stlCampos.Add('Conta bai.' + IntToStr(intIndice) + '       :' + fGetBancoConfig(0,'CONFIG033BCONRET-' + IntToStr(tabCarteira.TabIndex + 1), 'CONBAI' + IntToStr(intIndice),''))
  End;

  stlCampos.Add('Envia Sacador/Avalista:' + fGetBancoConfig(0, 'CONFIG033B-'  + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', ''));
  stlCampos.Add('Beneficiário      :' + fGetBancoConfig(0, 'CONFIG033B-'  + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', ''));
  stlCampos.Add('Endereço          :' + fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', ''));
  stlCampos.Add('Bairro            :' + fGetBancoConfig(0, 'CONFIG033B-'  + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', ''));
  stlCampos.Add('Complemento       :' + fGetBancoConfig(0, 'CONFIG033B-'  + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', ''));
  stlCampos.Add('Cidade            :' + fGetBancoConfig(0, 'CONFIG033B-'  + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', ''));
  stlCampos.Add('Estado            :' + fGetBancoConfig(0, 'CONFIG033B-'  + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', ''));
  stlCampos.Add('CEP               :' + fGetBancoConfig(0, 'CONFIG033B-'  + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', ''));
  stlCampos.Add('CNPJ              :' + fGetBancoConfig(0, 'CONFIG033B-'  + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', ''));
  Result := stlCampos.Text;

end;

procedure TfrmConfigSantanderBan.pCarregaCentroCusto(strCtaBai: String;
  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    edtLabel.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmConfigSantanderBan.pCarregaPortador(strCodPor: String;
  edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtLabel.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmConfigSantanderBan.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(cdsConRet);
end;

procedure TfrmConfigSantanderBan.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  qryCadFor := fCriaQuery(Self);
  pCarKeyAutBan;

  pCriaCdsContaRetorno(cdsConRet, pcdsConRetAfterInsert, pcdsConRetBeforePost, pcdsConRetAfterPost,
                       pcdsConRetBeforeEdit);
  dtsConRet.DataSet := cdsConRet;

  qryPorCmb := fCriaQuery(Self);
  dtsCadPor.DataSet := qryPorCmb;
  qryPorCmb.SQL.Text := 'SELECT POR_CODPOR, CONCAT(POR_CODPOR, "-", POR_NOMPOR) AS POR_NOMPOR FROM CADPOR WHERE POR_PERBAI = "S" ORDER BY POR_NOMPOR';
  qryPorCmb.Open;


  qryCtaCmb := fCriaQuery(Self);
  dtsCadCta.DataSet := qryCtaCmb;
  qryCtaCmb.SQL.Text := 'SELECT CTA_CODCTA, CONCAT(CTA_CODCTA, "-", CTA_DESCTA) AS CTA_DESCTA  FROM CADCTA ORDER BY CTA_DESCTA';
  qryCtaCmb.Open;

  cxPaginas.Properties.ActivePage := tbsGeral;

  If fCfgSis('ENCBAN', varBoolean) Then
    tbsEncBan.TabVisible := True
  else
    tbsEncBan.TabVisible := False;
end;

procedure TfrmConfigSantanderBan.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigSantanderBan.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSantanderBan.btnAddOcoClick(Sender: TObject);
begin
  inherited;
  frmCadOcoCartei := TfrmCadOcoCartei.Create(nil);
  frmCadOcoCartei.strCartei :=  'CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp;
  Try
    frmCadOcoCartei.ShowModal;
  Finally
    FreeAndNil(frmCadOcoCartei);
  End;
  pCarregaOcorrencias;
end;

procedure TfrmConfigSantanderBan.btnCancelarClick(Sender: TObject);
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

procedure TfrmConfigSantanderBan.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pHideHint;

    pCriarFormularios(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '033B';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigSantanderBan.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\033B400p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\033B400p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigSantanderBan.BtnOcorrenciaClick(Sender: TObject);
  Var
    strDetalhe : String;
begin
  inherited;
  pHideHint;

  strDetalhe := #13#10 +
                '06 - Baixa duplicata; ' + #13#10 +
                '02 - Atualiza nosso número caso não tenha gravado; ' + #13#10 +
                '15, 21 - Lança histórico de protesto; ' + #13#10 +
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


  TfrmMemo.pShowMessage('Banco 033 - Santander - Detalhamento de Ocorrências (posições 109 - 110 arquivo retorno).' + #13#10 +
                        strDetalhe);
end;

procedure TfrmConfigSantanderBan.BtnOcorrenciaEnter(Sender: TObject);
begin
  inherited;
  btnOcorrencia.Hint := 'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
                        'que são tratados pelas rotinas do sistema.';
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigSantanderBan.BtnOcorrenciaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSantanderBan.btnRemOcoClick(Sender: TObject);
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
      pDesmembraCarteira('CONFIG033B-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp,
                         strCodBco, strTipLay, strNumPos, strEspeci, strCodEmp, intCartei);

      objCnfDao := TCnfOcoDao.Create(strCodBco, strTipLay, strNumPos,
                                     strEspeci, strCodEmp, intCartei);

      objCnfOco := objCnfDao.fBuscaPorOcorrencia(cdsCnfOcoCNF_CODOCO.AsString);
      If Assigned(objCnfOco) Then
      Begin
        If objCnfDao.fRemoverOcorrencia(objCnfOco.strCodOco) Then
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

procedure TfrmConfigSantanderBan.chkCartSeqClick(Sender: TObject);
begin
  inherited;
  If Not fValidaCampos(chkCartSeq) Then
    TCheckBox(Sender).Checked := False;

  lblCartSeq.Enabled := TCheckBox(Sender).Checked;
  edtCartSeq.Enabled := TCheckBox(Sender).Checked;
end;

procedure TfrmConfigSantanderBan.cmbCodCarChange(Sender: TObject);
begin
  inherited;
  edtIdentBanc.Text := '033';
end;

procedure TfrmConfigSantanderBan.cmbInstrucao1Change(Sender: TObject);
begin
  inherited;
  If cmbInstrucao1.ItemIndex = 0 Then
  Begin
    cmbInstrucao2.ItemIndex := 0;
    cmbInstrucao2.Enabled := False;
  End
  Else
    cmbInstrucao2.Enabled := True;
end;

procedure TfrmConfigSantanderBan.cxgConRetDBTableView1EditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  inherited;
  If Key = #$1B Then
    cdsConRet.Cancel;
end;

procedure TfrmConfigSantanderBan.cxgConRetEnter(Sender: TObject);
begin
  inherited;
  lblInfo.Visible := True;
end;

procedure TfrmConfigSantanderBan.cxgConRetExit(Sender: TObject);
begin
  inherited;
  lblInfo.Visible := False;
end;

procedure TfrmConfigSantanderBan.edtConGarExit(Sender: TObject);
begin
  inherited;
  TEditFocus(Sender).Text := fstrZero(TEditFocus(Sender).Text, TEditFocus(Sender).MaxLength);
end;

procedure TfrmConfigSantanderBan.edtContaCorrExit(Sender: TObject);
begin
  inherited;
  TEditFocus(Sender).Text := fstrZero(TEditFocus(Sender).Text, TEditFocus(Sender).MaxLength);
end;

procedure pCriaCdsContaRetorno(Var cdsConRet: TUniClientDataSet;
                               pcdsConRetAfterInsert,
                               pcdsConRetBeforePost,
                               pcdsConRetAfterPost,
                               pcdsConRetBeforeEdit: TDataSetNotifyEvent);
Begin
  cdsConRet := TUniClientDataSet.Create(Application);

  With cdsConRet, FieldDefs Do
  Begin
    With AddFieldDef Do Begin Name := 'CONRET'; DataType := ftString; Size := 8; Required := False; End;
    With AddFieldDef Do Begin Name := 'PORBAI'; DataType := ftString; Size := 20; Required := False; End;
    With AddFieldDef Do Begin Name := 'CONBAI'; DataType := ftString; Size := 20; Required := False; End;

    cdsConRet.AfterInsert := pcdsConRetAfterInsert;
    cdsConRet.BeforeEdit   := pcdsConRetBeforeEdit;
    cdsConRet.BeforePost  := pcdsConRetBeforePost;
    cdsConRet.AfterPost   := pcdsConRetAfterPost;

    CreateDataSet;
    cdsConRet.IndexFieldNames := 'CONRET';
    cdsConRet.Open;
  End;
End;

procedure pLeContasRetorno(cdsConRet: TUniClientDataSet; intTabInd: Integer);
  Var
    intIndice: Integer;
    intNroCon: Integer;
Begin
  intNroCon := StrToIntDef(fGetBancoConfig(0,'CONFIG033B-' + IntToStr(intTabInd),'NROCONTAS','0'), 0);
  If Assigned(lstRecada) Then
    FreeAndNil(lstRecada);
  lstRecada := TStringList.Create;

  With cdsConRet Do
  Begin
    EmptyDataSet;

    For intIndice := 1 To intNroCon Do
    Begin
      Insert;
      If (Length(fGetBancoConfig(0,'CONFIG033BCONRET-' + IntToStr(intTabInd),
                                           'CONRET' + IntToStr(intIndice),'')) > 8) Then
        lstRecada.Add(fGetBancoConfig(0,'CONFIG033BCONRET-' + IntToStr(intTabInd),
                                           'CONRET' + IntToStr(intIndice),''));

      FieldByName('CONRET').AsString := fGetBancoConfig(0,'CONFIG033BCONRET-' + IntToStr(intTabInd),
                                                        'CONRET' + IntToStr(intIndice),'');

      FieldByName('PORBAI').AsString := fGetBancoConfig(0,'CONFIG033BCONRET-' + IntToStr(intTabInd),
                                                        'PORBAI' + IntToStr(intIndice),'');

      FieldByName('CONBAI').AsString := fGetBancoConfig(0,'CONFIG033BCONRET-' + IntToStr(intTabInd),
                                                        'CONBAI' + IntToStr(intIndice),'');
      Post;
    End;
  End;
End;

procedure TfrmConfigSantanderBan.pcdsConRetAfterPost(DataSet: TDataSet);
Var intCont : Integer;
Begin
  If (lstRecada.Count > 0) And (DataSet.State <> dsInsert) Then
  Begin
    For intCont := 0 to lstRecada.Count - 1 Do
    Begin
      If Copy(lstRecada[intCont], 1, 8) = strContAnt Then
      Begin
        lstRecada.Delete(intCont);
        Break;
      End;
    End;
  End;
End;

procedure TfrmConfigSantanderBan.pcdsConRetBeforeEdit(DataSet: TDataSet);
Begin
  strContAnt := DataSet.FieldByName('CONRET').AsString;
End;

procedure TfrmConfigSantanderBan.pcdsConRetAfterInsert(DataSet: TDataSet);
begin
  inherited;

  With DataSet Do
  Begin
    FieldByName('CONRET').FocusControl;
  End;

end;

procedure TfrmConfigSantanderBan.pcdsConRetBeforePost(DataSet: TDataSet);
begin
  inherited;
  With DataSet Do
  Begin
    If fEmptyStr(FieldByName('CONRET').AsString) Then
    Begin
      pMensagemOk('Informe a Conta de Retorno');
       Abort;
    End;

    If fEmptyStr(FieldByName('PORBAI').AsString) Then
    Begin
      pMensagemOk('Informe o Portador da Baixa');
      Abort;
    End;

    If fEmptyStr(FieldByName('CONBAI').AsString) Then
    Begin
      pMensagemOk('Informe a Conta da Baixa');
      Abort;
    End;
  End;
end;

end.
