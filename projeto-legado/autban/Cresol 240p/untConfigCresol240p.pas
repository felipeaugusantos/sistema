unit untConfigCresol240p;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Mask, DirectoryEditFocus, StrUtils,
  Buttons, ExtCtrls, QColorLabel, Menus, ComCtrls, ShellApi, AppEvnts, Uni,
  cxHint, ComboBoxFocus, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxDBLookupComboBox, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, UniClientDataSet, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, dxScreenTip, dxCustomHint,
  untTypesSistema, frxClass, frxExportCSVTestabilidade, MaskEditFocus, cxContainer,
  untFrameDirectoryEditFocus, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFramePlanoDeContasMaskEdit, dxBarBuiltInMenu,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxCheckBox,
  cxGroupBox, cxPC, untCNFOCO_Class, untCNFOCO_Dao, Datasnap.DBClient, System.Generics.Collections;

type
  TfrmConfigCresol240p = class(TfrmPai)
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
    tbsEncBan: TcxTabSheet;
    pnlAtivo: TPanel;
    lblProNum: TLabel;
    lblCodAgenc: TLabel;
    lblContCorr: TLabel;
    lblDiasProt: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
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
    ColorLabel3: TColorLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label3: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    edtProxNumArqRem: TEditFocus;
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
    edtProAce: TEditFocus;
    edtCodTrans: TEditFocus;
    cbCodMov: TComboBoxFocus;
    edtDigAge: TEditFocus;
    edtDigCtaCor: TEditFocus;
    edtDigCtaCob: TEditFocus;
    cbTipoCob: TComboBoxFocus;
    cbFormaCad: TComboBoxFocus;
    CbTipoDoc: TComboBoxFocus;
    edtDigAgeC: TEditFocus;
    edtNumAgeC: TEditFocus;
    CbCodPro: TComboBoxFocus;
    cbCodBaixa: TComboBoxFocus;
    edtDiasBaixa: TEditFocus;
    fraPathRemessa: TfraDirectoryEditFocus;
    fraPathRetorno: TfraDirectoryEditFocus;
    edtCedente: TEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    edtPerMul: TEditFocus;
    pnlAtivo2: TPanel;
    grpTarAux: TcxGroupBox;
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
    fraPlanoDeContasEnc: TfraPlanoDeContasMskEdit;
    cdsCnfOco: TUniClientDataSet;
    cdsCnfOcoCNF_CODOCO: TStringField;
    cdsCnfOcoCNF_DESOCO: TStringField;
    cdsCnfOcoCNF_GERPAG: TBooleanField;
    cdsCnfOcoCNF_FORNEC: TStringField;
    cdsCnfOcoCNF_PORTAD: TStringField;
    cdsCnfOcoCNF_PLNCON: TStringField;
    cdsCnfOcoCNF_CUSCAR: TBooleanField;
    cdsCnfOcoCNF_GERREC: TBooleanField;
    cdsCnfOcoCNF_TIPDES: TIntegerField;
    cdsCnfOcoCNF_DSTPDS: TStringField;
    dsCnfOco: TDataSource;
    grdTarifas: TcxGrid;
    grdTarifasDBTableView1: TcxGridDBTableView;
    grdTarifasDBTableView1CNF_CODOCO: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_DESOCO: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_DSTPDS: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_GERPAG: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_GERREC: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_CUSCAR: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_FORNEC: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_PLNCON: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_PORTAD: TcxGridDBColumn;
    grdTarifasLevel1: TcxGridLevel;
    tbsComplemento: TcxTabSheet;
    pnlComplemento: TPanel;
    Label7: TLabel;
    edtUsaSac: TEditFocus;
    ColorLabel5: TColorLabel;
    grpBeneficiario: TGroupBox;
    lblDesCrr: TLabel;
    Label4: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    edtDesBen: TEditFocus;
    edtEndBen: TEditFocus;
    edtCompBen: TEditFocus;
    edtBaiBen: TEditFocus;
    edtCidBen: TEditFocus;
    edtEstBen: TEditFocus;
    edtCepBen: TMaskEditFocus;
    edtCgcBen: TMaskEditFocus;
    cbCodCar: TComboBoxFocus;
    lblCodCart: TLabel;
    Label45: TLabel;
    edtCodPorRem: TEditFocus;
    edtDescPorRem: TEditFocus;
    lblCedente: TLabel;
    edtNumConvenio: TEditFocus;
    Label2: TLabel;
    cmbEspDoc: TComboBoxFocus;
    procedure btnGravarClick(Sender: TObject);
    procedure pCarregaDados;
    procedure pCarregaCombos;
    function  fRetornaConfiguracao(strValCfg: String): Integer;
    procedure pProcessaLogAtb;
    procedure pInsertLogAtb;
    procedure FormShow(Sender: TObject);
    procedure tabCarteiraChange(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure BtnManualClick(Sender: TObject);
    procedure edtContaCorrExit(Sender: TObject);
    procedure edtDiasCredEnter(Sender: TObject);
    procedure edtDiasCredExit(Sender: TObject);
    procedure btnConfigurarEnter(Sender: TObject);
    procedure btnConfigurarExit(Sender: TObject);
    procedure BtnOcorrenciaEnter(Sender: TObject);
    procedure BtnOcorrenciaExit(Sender: TObject);
    procedure BtnOcorrenciaClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtDigCtaCorEnter(Sender: TObject);
    procedure edtDigCtaCorExit(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddOcoClick(Sender: TObject);
    procedure btnEdtOcoClick(Sender: TObject);
    procedure btnRemOcoClick(Sender: TObject);
    procedure edtPorTarKeyPress(Sender: TObject; var Key: Char);
    procedure edtForTarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorRemKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    qryCadFor : TUniQuery;
    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;
    qryPorCmb : TUniQuery;
    qryCtaCmb : TUniQuery;
    strCfgAnt,
    strCfgAtu,
    strCmpAlt: String;
    stlCfgAnt,
    stlCfgAtu: TStringList;
    intIndice,
    intIndice2: Integer;

    strCfg_PORPGR,
    strCfg_CTAGCP : String;

    procedure pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pShowHint(edtEdit: TEditFocus; strTitulo: String);
    procedure pShowHintBotao(btnBotao: TBitBtnLocked; strTitulo: String);
    procedure pHideHint;
    function fCarregaCfg(Var stlCampos: TStringList): String;
    procedure pCarregaOcorrencias;
    function fPortadorContasAPagarDoCaixa(strCodPor: String): Boolean;
    function fPlanoDeContasContasAPagarDoCaixa(strCodCta: String): Boolean;
  public
    { Public declarations }
    blnNaoEditar: Boolean;
    strConfig   : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigCresol240p: TfrmConfigCresol240p;

implementation

uses untfuncoesSimples, untFuncoes,
     untPesqAux, untCfgGenericas_AutBan,  untConsultas, untMemo,
  untCadOcoCartei;

{$R *.dfm}

procedure TfrmConfigCresol240p.btnConfigurarEnter(Sender: TObject);
begin
  inherited;
  btnConfigurar.Hint := 'Configurar percentual de ' + #13+#10 +
                        'juros para remessa.';
  pShowHintBotao(btnConfigurar, 'Cofigurações específicas.');
end;

procedure TfrmConfigCresol240p.btnConfigurarExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCresol240p.btnEditarClick(Sender: TObject);
begin
  If (Not fVerificaDireitoAutBan('PERCARBAN')) Then
  begin
    fMensagem('ATENÇÃO','Usuário sem permissão!', ['&Ok ']);
    Exit;
  end
  else
  begin
    pnlAtivo.Enabled  := True;
    pnlComplemento.Enabled := pnlAtivo.Enabled;
    btnGravar.Enabled := True;
    btnConfigurar.Enabled := True;
    btnEditar.Visible := False;
    btnCancelar.Visible := true;

    if tbsEncBan.tabVisible then
       pnlAtivo2.Enabled := True;

    if edtProxNumArqRem.Enabled then
      pSetFocus(edtProxNumArqRem);

  end;

end;

procedure TfrmConfigCresol240p.btnEdtOcoClick(Sender: TObject);
Var
  intRecNo_: Integer;
begin
  inherited;
  intRecNo_ := 0;
  If Not cdsCnfOco.isEmpty Then
  Begin
    intRecNo_ := cdsCnfOco.RecNo;
    frmCadOcoCartei := TfrmCadOcoCartei.Create(nil);
    frmCadOcoCartei.strCartei := strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp;
    frmCadOcoCartei.blnEditar := True;
    frmCadOcoCartei.edtCodOco.Text := cdsCnfOcoCNF_CODOCO.AsString;
    frmCadOcoCartei.fraPlanoDeContasOco.MskCodCta.Text := Copy(cdsCnfOcoCNF_PLNCON.AsString,1,7);
    frmCadOcoCartei.cmbTipDes.ItemIndex := cdsCnfOcoCNF_TIPDES.AsInteger;

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

procedure TfrmConfigCresol240p.btnGravarClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    Try
      stlCfgAnt := TStringList.Create;
      strCfgAnt := fCarregaCfg(stlCfgAnt);

      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', edtDesBen.Text        );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', edtEndBen.Text        );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', edtBaiBen.Text        );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', edtCompBen.Text       );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', edtCidBen.Text        );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', edtEstBen.Text        );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', edtCepBen.Text        );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', edtCgCBen.Text        );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', edtProxNumArqRem.Text);
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODMOV', cbCodMov.Text);
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TIPOCOB',cbTipoCob.Text);
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODPRO',cbCodPro.Text);
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'FORMACAD',cbFormaCad.Text);
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODBAIXA',cbCodBaixa.Text);
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TIPODOC',cbTipoDoc.Text);
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODTRANS', edtCodTrans.Text    );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text   );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', edtDigAge.Text   );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCORR', edtDigCtaCor.Text   );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text    );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', edtDigCtaCob.Text    );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CEDENTE', edtCedente.Text    );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMAGEC', edtNumAgeC.Text    );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEC', edtDigAgeC.Text    );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAB', edtContaCobr.Text    );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text     );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIABAIXA', edtDiasBaixa.Text     );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text         );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessa.edtDirectory.Text  );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetorno.edtDirectory.Text  );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text       );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text       );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContas.MskCodCta.Text       );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text  );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text  );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text  );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text  );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text  );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text     );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text       );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', edtUsaSac.Text       );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', edtPerMul.Text       );

      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', edtPorTar.Text    );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', fraPlanoDeContasEnc.MskCodCta.Text );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', edtForTar.Text    );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', edtValorTarifa.Text  );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', cbCodCar.Text  );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', edtNumConvenio.Text  );
      fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ESPDOC_', cmbEspDoc.Text);

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        edtProxNumArqRem.Enabled := False;
        blnMudarFoco := True;
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
      pProcessaLogAtb;
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

procedure TfrmConfigCresol240p.pCarregaDados;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************AF*}
  If fEmptyStr(fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'PROXNUM','')) Then
  Begin
    edtProxNumArqRem.Enabled := True;
    edtProxNumArqRem.Clear;
    pSetFocus(edtProxNumArqRem);
  End
  Else
  Begin
    edtProxNumArqRem.Text := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'PROXNUM','');
    edtProxNumArqRem.Enabled := False;
  End;

  if (strLoginUsuarioLogado='997') or(strLoginUsuarioLogado='998') or (strLoginUsuarioLogado='999') Then
  begin
    edtProxNumArqRem.Enabled := True;
    pSetFocus(edtProxNumArqRem);
  End;

  edtCodTrans .Text     := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'CODTRANS','');
  edtCodAgencia.Text    := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'CODAGEN','');
  edtDigAge.Text        := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'DIGAGEN','');
  edtDigCtaCor.Text     := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'DIGCORR','');
  edtCedente.Text       := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'CEDENTE','');
  edtContaCorr.Text     := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'NUMCTAC','');
  edtDigCtaCob.Text     := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'DIGCTAC','');
  edtNumAgeC.Text       := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'NUMAGEC','');
  edtDigAgeC.Text       := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'DIGAGEC','');
  edtContaCobr.Text     := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'NUMCTAB','');
  edtDiasProt.Text      := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'DIAPROT','');
  edtDiasBaixa.Text     := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'DIABAIXA','');
  edtResp.Text          := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'RESPONS','');
  edtDesPor.Text := '';
  edtDescPorRem.Text := '';
  fraPlanoDeContas.edtDesCta.Text := '';
  edtObservacao1.Text   := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'OBSERV1','');
  edtObservacao2.Text   := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'OBSERV2','');
  edtObservacao3.Text   := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'OBSERV3','');
  edtObservacao4.Text   := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'OBSERV4','');
  edtObservacao5.Text   := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'OBSERV5','');
  fraPathRemessa.edtDirectory.Text   := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'PATHREM','');
  fraPathRetorno.edtDirectory.Text   := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'PATHRET','');
  edtCodPor.Text        := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'PORBAI_','');
  edtCodPorRem.Text      := fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');
  fraPlanoDeContas.MskCodCta.Text        := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'CTABAI_','');
  edtDiasCred.Text      := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'DIACRED','');
  edtProAce.Text        := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'PROACEI','');
  edtPerMul.Text        := fGetBancoConfig(0,strConfig + IntToStr(tabCarteira.TabIndex + 1),'PERMULT','');
  edtPorTar.Text         := fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', '');
  fraPlanoDeContasEnc.MskCodCta.Text := fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', '');
  edtForTar.Text         := fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', '');
  edtValorTarifa.Text    := fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', '');
  edtNumConvenio.Text    := fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', '');

  //Dados Beneficiário
  edtUsaSac.Text        := fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', '');
  edtUsaSac.Text        := IIF(fEmptyStr(edtUsaSac.Text), 'N', edtUsaSac.Text);
  edtDesBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', ''), '');
  edtEndBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', ''), '');
  edtBaiBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', ''), '');
  edtCompBen.Text       := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', ''), '');
  edtCidBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', ''), '');
  edtEstBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', ''), '');
  edtCepBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', ''), '');
  edtCgcBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', ''), '');

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCodPorRem.Text ) Then
    pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);

  If Not fEmptyStr( fraPlanoDeContas.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);

  edtDesPorTar.Text := '';
  If Not fEmptyStr( edtPorTar.Text ) Then pCarregaPortador(edtPorTar.Text, edtDesPorTar);

  fraPlanoDeContasEnc.edtDesCta.Text := '';
  If Not fEmptyStr( fraPlanoDeContasEnc.MskCodCta.Text ) Then pCarregaCentroCusto(fraPlanoDeContasEnc.MskCodCta.Text, fraPlanoDeContasEnc.edtDesCta);

  edtDesForTar.Text := '';
  If Not fEmptyStr( edtForTar.Text ) Then
  begin
    pPesquisaCadFor(qryCadFor, qryCadFor, edtForTar.Text);
    edtDesForTar.Text  := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
  end;

  pCarregaOcorrencias;

  pCarregaCombos;
end;
procedure TfrmConfigCresol240p.pHideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmConfigCresol240p.pShowHint(edtEdit: TEditFocus;
  strTitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,edtEdit.ClientOrigin.Y, strTitulo, edtEdit.Hint);
end;

procedure TfrmConfigCresol240p.pShowHintBotao(btnBotao: TBitBtnLocked;
  strTitulo: String);
begin
  HintControler.ShowHint(btnBotao.ClientOrigin.X,btnBotao.ClientOrigin.Y, strTitulo, btnBotao.Hint);
end;

procedure TfrmConfigCresol240p.FormShow(Sender: TObject);
begin
  inherited;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  pCarregaDados;
  If edtProxNumArqRem.Enabled Then
    pSetFocus(edtProxNumArqRem)
  Else
    pSetFocus(edtCodAgencia);

  pSetFocus(btnEditar);

  strCfg_PORPGR := fCfgSis('PORPGR');

  pnlAtivo.Enabled := False;
  pnlComplemento.Enabled := pnlAtivo.Enabled;
  pnlAtivo2.Enabled := False;

  if blnNaoEditar then
  begin
     pnlAtivo.Enabled := False;
     pnlComplemento.Enabled := pnlAtivo.Enabled;
     btnConfigurar.Enabled := False;
     btnConfigurar.Visible := False;
     btnGravar.Enabled     := True;
     btnEditar.Visible     := False;
     pSetFocus(btnGravar);
  end;

end;

procedure TfrmConfigCresol240p.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
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

function TfrmConfigCresol240p.fRetornaConfiguracao(strValCfg: String): Integer;
begin
 If fEmptyStr(strValCfg) Then
   Result := 999
 Else
   if strValCfg = 'B' Then
     Result := 10
   Else
     Result := StrToInt(strValCfg);
end;

function TfrmConfigCresol240p.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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

    Else If Sender = edtUsaSac Then
    Begin
      If Pos(edtUsaSac.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Enviar Sacador/Avalista deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
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

    Else If Sender = edtResp Then
    Begin

      If (edtResp.Text <> 'B') And (edtResp.Text <> 'E') Then
      Begin
        fMensagem('','O campo Resp. por emissão de boletos deve ser B ou E!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If Sender = edtProAce Then
    Begin
      If Pos(edtProAce.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Imprime Protocolo de Aceite deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtUsaSac Then
    Begin
      If Pos(edtUsaSac.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Enviar Sacador Avalista deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
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
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+strMensagemConfig, ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin

      If fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Centro de Custo deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        fraPlanoDeContas.edtDesCta.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);
        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custo não está cadastrado!'+strMensagemConfig, ['&Ok']);
          Result := False;
        End
        Else
        Begin
          Result := PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text,False);
          if not Result then
            fMensagem('ATENÇÃO!', 'O Centro de Custo está Inativo!', ['&Ok']);
        End;
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
    Else If (Sender = edtNumConvenio) Then
    Begin
      If fEmptyStr(edtNumConvenio.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Número do Convênio de Cobrança deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End
    End
    Else If (Sender = edtDiasProt) Then
    Begin
      If (cbCodPro.ItemIndex = 1) Then
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

    Else If (Sender = edtPerMul) Then
    Begin
      If Not fValidaEscala(edtPerMul.Text, 0, 100) Then
      begin
        fMensagem('ATENÇÃO','O campo percentual de multa deve estar entre 0 e 100!'+strMensagemConfig,['&OK']);
        Result := False;
      end;
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
    End;

  End;

  If Not Result Then
    if not blnNaoEditar then
        pSetFocus(Sender);
End;

procedure TfrmConfigCresol240p.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmConfigCresol240p.tabCarteiraChanging(Sender: TObject;
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

procedure TfrmConfigCresol240p.edtCodPorKeyPress(Sender: TObject;
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

procedure TfrmConfigCresol240p.edtCodPorRemKeyPress(Sender: TObject;
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

procedure TfrmConfigCresol240p.edtDiasCredEnter(Sender: TObject);
begin
  inherited;
  edtDiasCred.Hint := 'Informar quantidade de dias ' + #13+#10 +
                      'do intervalo entre a efetuação ' + #13+#10 +
                      'do pagamento e o crédito na ' + #13+#10 +
                      'conta corrente.';

  pShowHint(edtDiasCred, 'Dias para Crédito');
end;

procedure TfrmConfigCresol240p.edtDiasCredExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCresol240p.edtDigCtaCorEnter(Sender: TObject);
begin
  inherited;
  edtDigCtaCor.Hint := 'Informar dígito verificador ' + #13+#10 +
                       'da conta corrente.';

  pShowHint(edtDigCtaCor, 'ATENÇÃO!');
end;

procedure TfrmConfigCresol240p.edtDigCtaCorExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCresol240p.edtForTarKeyPress(Sender: TObject;
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

procedure TfrmConfigCresol240p.edtPorTarKeyPress(Sender: TObject;
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

function TfrmConfigCresol240p.fCarregaCfg(Var stlCampos: TStringList): String;
begin
  Result := '';

  Result := Result + 'Tipo de Cobrança     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TIPOCOB', '') + #13+#10;
  stlCampos.Add('Tipo de Cobrança     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TIPOCOB', ''));
  Result := Result + 'Código para protesto     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODPRO', '') + #13+#10;
  stlCampos.Add('Código para protesto     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODPRO', ''));
  Result := Result + 'Forma de Cadastramento     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'FORMACAD', '') + #13+#10;
  stlCampos.Add('Forma de Cadastramento    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'FORMACAD', ''));
  Result := Result + 'Dias para Baixa/Devolução     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIABAIXA', '') + #13+#10;
  stlCampos.Add('Dias para Baixa/Devolução    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIABAIXA', ''));
  Result := Result + 'Código para Baixa/Devolução     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODBAIXA', '') + #13+#10;
  stlCampos.Add('Código para Baixa/Devolução    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODBAIXA', ''));
  Result := Result + 'Tipo de Documento     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TIPODOC', '') + #13+#10;
  stlCampos.Add('Tipo de Documento    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TIPODOC', ''));
  Result := Result + 'Código de movimento remessa     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODMOV', '') + #13+#10;
  stlCampos.Add('Código de movimento remessa     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODMOV', ''));
  Result := Result + 'Seq. remessa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '') + #13+#10;
  stlCampos.Add('Seq. remessa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  Result := Result + 'Dig. da agência   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', '') + #13+#10;
  stlCampos.Add('Dig. da agência   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', ''));
  Result := Result + 'Dig. Cta. Corrente   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCORR', '') + #13+#10;
  stlCampos.Add('Dig. Cta. Corrente   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCORR', ''));
  Result := Result + 'Díg. da C/C       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', '') + #13+#10;
  stlCampos.Add('Díg. da C/C            :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', ''));
  Result := Result + 'Agencia Cobrança      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMAGEC', '') + #13+#10;
  stlCampos.Add('Agencia Cobrança           :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMAGEC', ''));
  Result := Result + 'Dig. Agencia Cobrança      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEC', '') + #13+#10;
  stlCampos.Add('Dig. Agencia Cobrança           :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEC', ''));
  Result := Result + 'Cód. da agência   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '') + #13+#10;
  stlCampos.Add('Cód. da agência   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  Result := Result + 'Código de Transmissão  :   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODTRANS', '') + #13+#10;
  stlCampos.Add('Código de Transmissão  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODTRANS', ''));
  Result := Result + 'Cód. da C/C       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', '') + #13+#10;
  stlCampos.Add('Cód. da C/C       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  Result := Result + 'Conta cobrança    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAB', '') + #13+#10;
  stlCampos.Add('Conta cobrança    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAB', ''));
  Result := Result + 'Dias p/ protesto  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '') + #13+#10;
  stlCampos.Add('Dias p/ protesto  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  Result := Result + 'Responsável Bol.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', '') + #13+#10;
  stlCampos.Add('Responsável Bol.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', ''));
  Result := Result + 'Observação 1      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '') + #13+#10;
  stlCampos.Add('Observação 1      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  Result := Result + 'Observação 2      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '') + #13+#10;
  stlCampos.Add('Observação 2      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  Result := Result + 'Observação 3      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '') + #13+#10;
  stlCampos.Add('Observação 3      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  Result := Result + 'Observação 4      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '') + #13+#10;
  stlCampos.Add('Observação 4      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  Result := Result + 'Observação 5      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '') + #13+#10;
  stlCampos.Add('Observação 5      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  Result := Result + 'Arquivo remessa   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '') + #13+#10;
  stlCampos.Add('Arquivo remessa   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  Result := Result + 'Arquivo retorno   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '') + #13+#10;
  stlCampos.Add('Arquivo retorno   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  Result := Result + 'Portador de baixa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '') + #13+#10;
  stlCampos.Add('Portador de baixa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  Result := Result + 'Portador da remessa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '') + #13+#10;
  stlCampos.Add('Portador de remessa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', ''));
  Result := Result + 'Conta de baixa    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '') + #13+#10;
  stlCampos.Add('Conta de baixa    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  Result := Result + 'Dias p/ crédito   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', '') + #13+#10;
  stlCampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  Result := Result + 'Protocolo aceite  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', '') + #13+#10;
  stlCampos.Add('Protocolo aceite  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', ''));
  Result := Result + 'Percentual multa  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', '') + #13+#10;
  stlCampos.Add('Percentual multa  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', ''));
  Result := Result + 'Usa sac. aval. :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', '') + #13+#10;
  stlCampos.Add('Usa sac. aval. :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', ''));
  Result := Result + 'Gera Remessa local:' + fGetBancoConfig(0, strConfig, 'RELOCAL',  '') + #13+#10;
  stlCampos.Add('Gera Remessa local:' + fGetBancoConfig(0, strConfig, 'RELOCAL',  ''));            //VER ESSE CONFIG
  Result := Result + 'Juros (%)         :' + fGetBancoConfig(0, strConfig, 'JUROSDI',  '') + #13+#10;
  stlCampos.Add('Juros (%)         :' + fGetBancoConfig(0, strConfig, 'JUROSDI',  ''));               //VER ESSE CONFIG
  Result := Result + 'Não deixa val div :' + fGetBancoConfig(0, strConfig, 'BAIDIVAUT','') + #13+#10;
  stlCampos.Add('Não deixa val div :' + fGetBancoConfig(0, strConfig, 'BAIDIVAUT',''));             //VER ESSE CONFIG
  Result := Result + 'Nome beneficiário       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', '') + #13+#10;
  stlCampos.Add('Nome beneficiário            :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', ''));
  Result := Result + 'Endereço       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', '') + #13+#10;
  stlCampos.Add('Endereço            :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', ''));
  Result := Result + 'Bairro       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', '') + #13+#10;
  stlCampos.Add('Bairro            :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', ''));
  Result := Result + 'Complemento  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', '') + #13+#10;
  stlCampos.Add('Complemento       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', ''));
  Result := Result + 'Cidade  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', '') + #13+#10;
  stlCampos.Add('Cidade       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', ''));
  Result := Result + 'Estado  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', '') + #13+#10;
  stlCampos.Add('Estado       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', ''));
  Result := Result + 'CEP  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', '') + #13+#10;
  stlCampos.Add('CEP       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', ''));
  Result := Result + 'CNPJ  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', '') + #13+#10;
  stlCampos.Add('CNPJ       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', ''));
  Result := Result + 'CNPJ  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', '') + #13+#10;
  stlCampos.Add('CEDENTE       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CEDENTE', ''));
  Result := Result + 'Enc.Ban. Vr Tarifa:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', '') + #13+#10;
  stlCampos.Add('Enc.Ban. Vr Tarifa:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', ''));
  Result := Result + 'Enc.Ban. Portador :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', '') + #13+#10;
  stlCampos.Add('Enc.Ban. Portador :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', ''));
  Result := Result + 'Enc.Ban. Pl Conta :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', '') + #13+#10;
  stlCampos.Add('Enc.Ban. Pl Conta :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', ''));
  Result := Result + 'Enc.Ban. Fornec.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', '') + #13+#10;
  stlCampos.Add('Enc.Ban. Fornec.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', ''));
  Result := Result + 'Código da Carteira  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', '') + #13+#10;
  stlCampos.Add('Código da Carteira  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', ''));
  Result := Result + 'Número do Convênio de Cobrança :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', '') + #13+#10;
  stlCampos.Add('Número do Convênio de Cobrança :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', ''));
  Result := Result + 'Espécie Título :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ESPDOC_', '') + #13+#10;
  stlCampos.Add('Espécie Título :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ESPDOC_', ''));

end;

procedure TfrmConfigCresol240p.pCarregaCentroCusto(strCtaBai: String;
  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    edtLabel.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmConfigCresol240p.pProcessaLogAtb;
Var
  intCont : Integer;
Begin
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
  pInsertLogAtb;
end;

procedure TfrmConfigCresol240p.pCarregaCombos;
begin

  Case fRetornaConfiguracao(LeftStr(fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TIPOCOB', ''),1)) Of
    1 : cbTipoCob.ItemIndex := 0;
    3 : cbTipoCob.ItemIndex := 1;
    4 : cbTipoCob.ItemIndex := 2;
    5 : cbTipoCob.ItemIndex := 3;
    6 : cbTipoCob.ItemIndex := 4;
    7 : cbTipoCob.ItemIndex := 5;
    8 : cbTipoCob.ItemIndex := 6;
    9 : cbTipoCob.ItemIndex := 7;
    10 : cbTipoCob.ItemIndex := 8;
    999 : cbTipoCob.ItemIndex := -1;
  End;

  Case fRetornaConfiguracao(LeftStr(fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'FORMACAD', ''),1)) Of
    1 : cbFormaCad.ItemIndex := 0;
    2 : cbFormaCad.ItemIndex := 1;
    3 : cbFormaCad.ItemIndex := 2;
    999 : cbFormaCad.ItemIndex := -1;
  End;

  Case fRetornaConfiguracao(LeftStr(fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODPRO', ''),1)) Of
    3 : cbCodPro.ItemIndex := 0;
    1 : cbCodPro.ItemIndex := 1;
    999 : cbCodPro.ItemIndex := -1;
  End;

  Case fRetornaConfiguracao(LeftStr(fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODBAIXA', ''),1)) Of
    1 : cbCodBaixa.ItemIndex := 0;
    2 : cbCodBaixa.ItemIndex := 1;
    3 : cbCodBaixa.ItemIndex := 2;
    999 : cbCodBaixa.ItemIndex := -1;
  End;

  Case fRetornaConfiguracao(LeftStr(fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODMOV', ''),2)) Of
    01 : cbCodMov.ItemIndex := 0;
    02 : cbCodMov.ItemIndex := 1;
    04 : cbCodMov.ItemIndex := 2;
    05 : cbCodMov.ItemIndex := 3;
    06 : cbCodMov.ItemIndex := 4;
    07 : cbCodMov.ItemIndex := 5;
    08 : cbCodMov.ItemIndex := 6;
    09 : cbCodMov.ItemIndex := 7;
    18 : cbCodMov.ItemIndex := 8;
    10 : cbCodMov.ItemIndex := 9;
    11 : cbCodMov.ItemIndex := 10;
    12 : cbCodMov.ItemIndex := 11;
    31 : cbCodMov.ItemIndex := 12;
    47 : cbCodMov.ItemIndex := 13;
    48 : cbCodMov.ItemIndex := 14;
    49 : cbCodMov.ItemIndex := 15;
    98 : cbCodMov.ItemIndex := 16;
    999 : cbCodMov.ItemIndex := -1;
  End;

  Case fRetornaConfiguracao(LeftStr(fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TIPODOC', ''),1)) Of
    0 : cbTipoDoc.ItemIndex := 0;
    1 : cbTipoDoc.ItemIndex := 1;
    2 : cbTipoDoc.ItemIndex := 2;
    999 : cbTipoDoc.ItemIndex := -1;
  End;

  Case fRetornaConfiguracao(LeftStr(fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', ''),2)) Of
    9 : cbCodCar.ItemIndex := 0;
    999 : cbCodCar.ItemIndex := -1;
  End;

  cmbEspDoc.ItemIndex := cmbEspDoc.Items.IndexOf(fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1),
                                            'ESPDOC_', '02 - Duplicata mercantil'));
end;

procedure TfrmConfigCresol240p.pCarregaPortador(strCodPor: String;
  edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  //edtDesPor.Text := qryCadPor.FieldByName('POR_NOMPOR').AsString;

  With qryCadPor Do
  Begin
    edtLabel.Text := FieldByName('POR_NOMPOR').AsString;
  End;

end;

procedure TfrmConfigCresol240p.pInsertLogAtb;
  Var
    intCont : Integer;
begin
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
    pGravaLogAtb('133', 'Cresol', strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, strCfgAnt, strCfgAtu, strCmpAlt);
end;

procedure TfrmConfigCresol240p.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  qryCadFor := fCriaQuery(Self);
  pCarKeyAutBan;

  qryPorCmb := fCriaQuery(Self);
  dtsCadPor.DataSet := qryPorCmb;
  qryPorCmb.SQL.Text := 'SELECT POR_CODPOR, CONCAT(POR_CODPOR, "-", POR_NOMPOR) AS POR_NOMPOR FROM CADPOR ORDER BY POR_NOMPOR';
  qryPorCmb.Open;


  qryCtaCmb := fCriaQuery(Self);
  dtsCadCta.DataSet := qryCtaCmb;
  qryCtaCmb.SQL.Text := 'SELECT CTA_CODCTA, CONCAT(CTA_CODCTA, "-", CTA_DESCTA) AS CTA_DESCTA  FROM CADCTA ORDER BY CTA_DESCTA';
  qryCtaCmb.Open;

  cxPaginas.Properties.ActivePage := tbsGeral;

  //If fCfgSis('ENCBAN', varBoolean) Then
  //  tbsEncBan.TabVisible := True
  //else
  //  tbsEncBan.TabVisible := False;

end;

procedure TfrmConfigCresol240p.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigCresol240p.btnAddOcoClick(Sender: TObject);
begin
  inherited;
  frmCadOcoCartei := TfrmCadOcoCartei.Create(nil);
  frmCadOcoCartei.strCartei :=  strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp;
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

procedure TfrmConfigCresol240p.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do registro da carteira selecionada?', ['&S i m', '&N ã o'], 2) = 1 then
  begin
    btnCancelar.Visible := False;
    btnEditar.Visible   := True;
    pnlAtivo.Enabled    := False;
    pnlComplemento.Enabled := pnlAtivo.Enabled;
    btnEditar.Visible   := True;
    btnGravar.Enabled   := False;
    btnConfigurar.Enabled := False;

    if tbsEncBan.tabVisible then
       pnlAtivo2.Enabled:= False;

    pCarregaDados;
    pSetFocus(btnEditar);
  end;

end;

procedure TfrmConfigCresol240p.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pHideHint;

    pCriarFormularios(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '133';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigCresol240p.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\133240p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\133240p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigCresol240p.BtnOcorrenciaClick(Sender: TObject);
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
                'Se configurado através do botão "Configurar" as ocorrências 02, 06, 15 e 21, será ' +
                'feita a atualização de Portador e Evento quando realizada a "Atualização/Baixa Automática de Duplicatas".' + #13#10 +
                #13#10 +
                'As Demais ocorrências são gravadas na rotina ' +
                'de retorno e mostradas no relatório apenas em ' +
                'caráter informativo.'+ #13#10 +
                #13#10 +
                'Pressione Esc para voltar à tela de configurações.';


  TfrmMemo.pShowMessage('Banco 133 - Cresol - Detalhamento de Ocorrências (posições 109 - 110 arquivo retorno).' + #13#10 +
                        strDetalhe);
end;

procedure TfrmConfigCresol240p.BtnOcorrenciaEnter(Sender: TObject);
begin
  inherited;
  btnOcorrencia.Hint := 'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
                        'que são tratados pelas rotinas do sistema.';
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigCresol240p.BtnOcorrenciaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCresol240p.btnRemOcoClick(Sender: TObject);
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
      pDesmembraCarteira(strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp,
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

procedure TfrmConfigCresol240p.edtContaCorrExit(Sender: TObject);
begin
  inherited;
  TEditFocus(Sender).Text := fstrZero(TEditFocus(Sender).Text, TEditFocus(Sender).MaxLength);
end;

procedure TfrmConfigCresol240p.pCarregaOcorrencias;
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

  pDesmembraCarteira(strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp, strCodBco,
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

function TfrmConfigCresol240p.fPortadorContasAPagarDoCaixa(
  strCodPor: String): Boolean;
begin
  Result := (Not fEmptyStr(strCfg_PORPGR)) And
            (strCfg_PORPGR = strCodPor);
end;

function TfrmConfigCresol240p.fPlanoDeContasContasAPagarDoCaixa(
  strCodCta: String): Boolean;
begin
  Result := (Not fEmptyStr(strCfg_CTAGCP)) And
            (strCfg_CTAGCP = strCodCta);
end;

end.
