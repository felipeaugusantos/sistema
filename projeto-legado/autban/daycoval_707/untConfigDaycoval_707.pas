unit untConfigDaycoval_707;

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
  System.Generics.Collections, untFrameDirectoryEditFocus;

type
  TfrmConfigDaycoval_707 = class(TfrmPai)
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
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxPaginas: TcxPageControl;
    tbsGeral: TcxTabSheet;
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
    Label2: TLabel;
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
    Label17: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    Label16: TLabel;
    Label6: TLabel;
    lblCartSeq: TLabel;
    ColorLabel6: TColorLabel;
    Label19: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    ColorLabel2: TColorLabel;
    edtResp: TEditFocus;
    edtDiasProt: TEditFocus;
    edtContaCorr: TEditFocus;
    edtCodAgencia: TEditFocus;
    edtIdentBanc: TEditFocus;
    edtCodCar: TEditFocus;
    edtProxNumArqRem: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtDesCtaBai: TEditFocus;
    edtCtaBai: TEditFocus;
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
    cmbNumCart: TComboBoxFocus;
    edtDiasMora: TEditFocus;
    chkCartSeq: TCheckBox;
    edtCartSeq: TEditFocus;
    edtDigCtaCor: TEditFocus;
    edtMandMsg: TEditFocus;
    edtCodLiq: TEditFocus;
    tbsEncBan: TcxTabSheet;
    pnlAtivo2: TPanel;
    grpTarLiq: TcxGroupBox;
    Label7: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    edtDesPorTar: TEditFocus;
    edtPorTar: TEditFocus;
    edtDesConTar: TEditFocus;
    edtConTar: TEditFocus;
    edtValorTarifa: TEditFocus;
    edtDesForTar: TEditFocus;
    edtForTar: TEditFocus;
    fraPathRemessaDaycoval: TfraDirectoryEditFocus;
    fraPathRetornoDaycoval: TfraDirectoryEditFocus;
    cmbInstrucao1: TComboBoxFocus;
    Label3: TLabel;
    edtNomPre: TEditFocus;
    Label4: TLabel;
    tbsComplemento: TcxTabSheet;
    pnlComplemento: TPanel;
    Label45: TLabel;
    edtCodPorRem: TEditFocus;
    edtDescPorRem: TEditFocus;
    procedure pCarregaDados;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCtaBaiKeyPress(Sender: TObject; var Key: Char);
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
    procedure edtConTarKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorTarKeyPress(Sender: TObject; var Key: Char);
    procedure edtForTarKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorTarifaExit(Sender: TObject);
    procedure edtMandMsgEnter(Sender: TObject);
    procedure edtMandMsgExit(Sender: TObject);
    procedure edtCodLiqEnter(Sender: TObject);
    procedure edtCodLiqExit(Sender: TObject);
    procedure edtCodPorRemKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;
    qryCadFor : TUniQuery;
    blnVirtualUI: Boolean;

    procedure pShowHint(edtEdit: TEditFocus; strTitulo: String);
    procedure pShowHintBotao(btnBotao: TBitBtnLocked; strTitulo: String);
    procedure pHideHint;
    procedure pLimpaCampos;
    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
    function fRetStrCfg(stlCfg : TStringList) : String;
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pCarregaFornecedor(strCodFor : String);
    procedure pCarregaCentroCusto(strCtaBai: String; edtLabel: TEdit);
    function RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;


  public
    { Public declarations }
    blnNaoEditar: Boolean;
    strConfig   : String;
    strOcoTar   : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigDaycoval_707: TfrmConfigDaycoval_707;

implementation

uses  untPesqAux, untCfgGenericas_AutBan, untConsultas, untFuncoesSimples,
  untMemo, untFuncoes;

{$R *.dfm}

procedure TfrmConfigDaycoval_707.pCarregaDados;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************AF*}
  pLimpaCampos;

  If fEmptyStr(fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '')) Then
  Begin
    edtProxNumArqRem.Enabled  := True;
    edtProxNumArqRem.Clear;
    pSetFocus(edtProxNumArqRem);
  End
  Else
  Begin
    edtProxNumArqRem.Text  := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '');
    edtProxNumArqRem.Enabled := False;
    pSetFocus(cmbNumCart);
  End;

  if (strLoginUsuarioLogado='997') or(strLoginUsuarioLogado='998') or (strLoginUsuarioLogado='999') Then
  begin
    edtProxNumArqRem.Enabled := True;
    pSetFocus(edtProxNumArqRem);
  End;

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', '')) Of
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
    Case StrToInt(fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '')) Of
      01: cmbInstrucao1.ItemIndex := 0;
      02: cmbInstrucao1.ItemIndex := 1;
      04: cmbInstrucao1.ItemIndex := 2;
      06: cmbInstrucao1.ItemIndex := 3;
      09: cmbInstrucao1.ItemIndex := 4;
      10: cmbInstrucao1.ItemIndex := 5;
      18: cmbInstrucao1.ItemIndex := 6;
    end;
   except
     cmbInstrucao1.ItemIndex := -1;
  end;

  edtDesPor.Text := '';
  edtDescPorRem.Text := '';
  edtDesCtaBai.Text := '';

  edtCodCar.Text         := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', '');
  edtNomPre.Text         := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMPREF', '');
  edtIdentBanc.Text      := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', '');
  edtCodAgencia.Text     := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtContaCorr.Text      := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', '');
  edtDigCtaCor.Text      := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', '');
  edtCodPor.Text         := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  edtCtaBai.Text         := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');
  edtCodPorRem.Text      := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');
  edtDiasProt.Text       := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '');
  edtDiasMora.Text       := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAMORA', '');
  edtResp.Text           := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', '');
  edtMandMsg.Text        := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVDUPAG', 'N');

  If fEmptyStr(edtMandMsg.Text) then
    edtMandMsg.Text := 'S';

  If fEmptyStr(edtDiasMora.Text) then
    edtDiasMora.Text := '1';

  edtDesPor.Text := '';
  edtDescPorRem.Text := '';
  edtDesCtaBai.Text := '';

  edtObservacao1.Text    := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text    := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text    := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text    := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text    := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');

  fraPathRemessaDaycoval.edtDirectory.Text:= fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '');
  fraPathRetornoDaycoval.edtDirectory.Text:= fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '');
  edtExpCgc.Text         := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPCNPJ', '');
  edtDiasCred.Text       := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', '');
  edtProAce.Text         := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', '');

  edtPerMul.Text         := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', '');
  edtInfAdi.Text         := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', '');

  edtCodFsh.Text         := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'CDFLASH', '');
  chkCartSeq.Checked     := (fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', '') = 'S');
  edtCartSeq.Text        := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', '');
  edtPorTar.Text         := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', '');
  edtConTar.Text         := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', '');
  edtForTar.Text         := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', '');
  edtValorTarifa.Text    := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', '');
  edtCodLiq.Text         := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'CODLIQU', 'N');

  chkCartSeq.OnClick(chkCartSeq);

  If Not fEmptyStr(fGetBancoConfig(0,'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1),'TIPDIA', '1')) Then
    cmbTipDia.ItemIndex    := StrToInt(fGetBancoConfig(0,'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1),'TIPDIA', '1'))-1
  Else
    cmbTipDia.ItemIndex    := -1;

  pCarregaPortador(edtCodPor.Text, edtDesPor);
  pCarregaCentroCusto(edtCtaBai.Text, edtDesCtaBai);

  pCarregaPortador(edtPorTar.Text, edtDesPorTar);
  pCarregaCentroCusto(edtConTar.Text, edtDesConTar);

  pCarregaFornecedor(edtForTar.text);
end;

procedure TfrmConfigDaycoval_707.pCarregaFornecedor(strCodFor: String);
begin
  If fEmptyStr(strCodFor) Then
    Exit;

  pPesquisaCadFor(qryCadFor, qryCadFor, strCodFor);
  edtDesForTar.Text  := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
end;

procedure TfrmConfigDaycoval_707.FormShow(Sender: TObject);
begin
  inherited;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  pCarregaDados;

  If edtProxNumArqRem.Enabled Then
    pSetFocus(edtProxNumArqRem)
  Else
    pSetFocus(edtCodAgencia);

  pnlAtivo1.Enabled := False;
  pnlComplemento.Enabled := pnlAtivo1.Enabled;
  pnlAtivo2.Enabled := False;

  pSetFocus(btnEditar);

  if blnNaoEditar then
  begin
    btnConfigurar.Enabled := False;
    btnConfigurar.Visible := False;
    btnGravar.Enabled     := True;
    btnEditar.Visible     := False;
    pSetFocus(btnGravar);
  end;

  fraPathRetornoDaycoval.edtDirectory.Visible := Not blnVirtualUI;
  lblPathArquivosRet.Visible := Not blnVirtualUI;
  If blnVirtualUI Then
    lblPathArquivosRem.Caption := 'Path temporário para Remessa:';

 If fEmptyStr(strConfig) Then
   strConfig := 'CONFIG707-';

end;

procedure TfrmConfigDaycoval_707.btnConfigurarEnter(Sender: TObject);
begin
  inherited;
  btnConfigurar.Hint := 'Configurar percentual de ' + #13+#10 +
                        'juros para remessa.';
  pShowHintBotao(btnConfigurar, 'Cofigurações específicas.');
end;

procedure TfrmConfigDaycoval_707.btnConfigurarExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigDaycoval_707.btnEditarClick(Sender: TObject);
begin
  If (Not fVerificaDireitoAutBan('PERCARBAN')) Then
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
  end;
end;

procedure TfrmConfigDaycoval_707.btnGravarClick(Sender: TObject);
Var
  stlCfgAnt : TStringList;

begin
  inherited;

  If fVerificaCampos Then
  Begin

    Try
      stlCfgAnt := TStringList.Create;
      pCarregaCfg(stlCfgAnt);

      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', edtProxNumArqRem.Text);
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', LeftStr(cmbNumCart.Text, 3));
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', edtCodCar.Text       );
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMPREF', edtNomPre.Text       );
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', edtIdentBanc.Text    );
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text   );
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text    );
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', edtDigCtaCor.Text    );
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text       );
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text       );
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', edtCtaBai.Text       );
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text     );
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAMORA', edtDiasMora.Text     );
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text         );

      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text);
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text);
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text);
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text);
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text);


      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessaDaycoval.edtDirectory.Text);
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetornoDaycoval.edtDirectory.Text);
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPCNPJ', edtExpCgc.Text         );

      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text     );
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text       );

      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', edtPerMul.Text       );
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text       );

      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'CDFLASH', edtCodFsh.Text       );
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVDUPAG', edtMandMsg.Text      );

      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPDIA' , IntToStr(cmbTipDia.ItemIndex+1));
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', IIF(chkCartSeq.Checked, 'S', 'N'));
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', IIF(chkCartSeq.Checked, edtCartSeq.Text, ''));
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', edtPorTar.Text    );
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', edtConTar.Text    );
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', edtForTar.Text    );
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', edtValorTarifa.Text  );
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'CODLIQU', edtCodLiq.Text  );
      fGetBancoConfig(1, 'CONFIG707-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', LeftStr(cmbInstrucao1.Text,2));

      If Not (btnGravar.Caption = '&OK') Then
      Begin
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

function TfrmConfigDaycoval_707.fRetStrCfg(stlCfg: TStringList): String;
  Var
    intCont : Integer;
begin
  Result := '';

  For intCont := 0 To stlCfg.Count - 1 Do
    Result := Result + stlCfg.Strings[intCont] + #13+#10;
end;


function TfrmConfigDaycoval_707.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
var
  strMensagemConfig: String;
Begin

  Result := True;

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
        fMensagem('','O Campo de instrução deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
      edtCodFsh.Enabled := (cmbInstrucao1.ItemIndex in [65,66]);

    End

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

    Else If (tbsEncBan.TabVisible = True) and  (Sender = edtConTar)  Then
    Begin
      If fEmptyStr(edtConTar.Text) Then
      begin
        if (not fEmptyStr(edtValorTarifa.Text)) and (fStrToFloat(edtValorTarifa.Text)>0) then
        Begin
          fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser informado!'+strMensagemConfig, ['&Ok']);
          edtDesConTar.Clear;
          Result := False;
        End
      end
      Else
      Begin
        pCarregaCentroCusto(edtConTar.Text, edtDesConTar);
        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!'+strMensagemConfig, ['&Ok']);
          Result := False;
        End
        else
          edtDesConTar.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;
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

    Else If (Sender = edtCtaBai) Then
    Begin

      If fEmptyStr(edtCtaBai.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser informado!'+strMensagemConfig, ['&Ok']);
        edtDesCtaBai.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaCentroCusto(edtCtaBai.Text, edtDesCtaBai);
        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!'+strMensagemConfig, ['&Ok']);
          Result := False;
        End;
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
        if Length(edtContaCorr.Text) <> 7 then
        begin
          fMensagem('ATENÇÃO','O campo Conta Corrente deve ter 7 (sete) caracteres. Caso tenha 0 (zero) favor informar!' + strMensagemConfig,['&OK']);
          Result := False;
        end;
      end;
    End

    Else If (Sender = edtInfAdi) Then
    Begin
      If fEmptyStr(edtInfAdi.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Código da Operação deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      else
      begin
        if Length(edtInfAdi.Text) <> 7 then
        begin
          fMensagem('ATENÇÃO','O campo Código da Operação deve ter 7 (sete) caracteres. Caso tenha 0 (zero) favor informar!' + strMensagemConfig,['&OK']);
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
          If fEmptyStr(fGetBancoConfig(0, 'CONFIG707-' + edtCartSeq.Text, 'PROXNUM', '')) Then
          Begin
            fMensagem('ATENÇÃO','Não pode ser usada essa carteira no campo Carteira Seq., pois essa não possui Último Núm. Seq. Remessa cadastrado!' ,['&O K']);
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

procedure TfrmConfigDaycoval_707.edtCodFshEnter(Sender: TObject);
begin
  inherited;
  edtCodFsh.Hint := 'Código fornecido pelo banco ' + #13+#10 +
                    'para envio de mensagens na ' + #13+#10 +
                    'remessa quando utilizada a ' + #13+#10 +
                    'instrução 93 ou a instrução 94.';
  pShowHint(edtCodFsh, 'Código Flash');
end;

procedure TfrmConfigDaycoval_707.edtCodFshExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigDaycoval_707.edtCodLiqEnter(Sender: TObject);
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

procedure TfrmConfigDaycoval_707.edtCodLiqExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigDaycoval_707.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmConfigDaycoval_707.edtCodPorRemKeyPress(Sender: TObject;
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

procedure TfrmConfigDaycoval_707.edtConTarKeyPress(Sender: TObject; var Key: Char);
  Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************KP*}
  If fPesqCentroCusto(Self, edtConTar, edtDesConTar, Nil, Key, arrCentroCusto) Then
  begin
    if fValidaCampos(edtConTar)  then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmConfigDaycoval_707.pCarregaPortador(strCodPor: String; edtLabel: TEdit);
begin

  If fEmptyStr(strCodPor) Then
    Exit;

  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  edtLabel.Text := qryCadPor.FieldByName('POR_NOMPOR').AsString;
end;

procedure TfrmConfigDaycoval_707.pHideHint;
begin
  HintControler.HideHint;
end;


procedure TfrmConfigDaycoval_707.pLimpaCampos;
var
  i: Integer;
begin
  for i := Self.ComponentCount -1 downto 0 do
  begin
    if (Self.Components[i] is TEditFocus) then
      (Self.Components[i] as TEditFocus).text := '';

    if (Self.Components[i] is TDirectoryEditFocus) then
      (Self.Components[i] as TDirectoryEditFocus).text := '';

    if (Self.Components[i] is TCheckBox) then
      (Self.Components[i] as TCheckBox).Checked := False;

    if (Self.Components[i] is TComboBoxFocus) then
      (Self.Components[i] as TComboBoxFocus).ItemIndex := -1;
  end;
end;

procedure TfrmConfigDaycoval_707.pShowHint(edtEdit: TEditFocus; strTitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,edtEdit.ClientOrigin.Y, strTitulo, edtEdit.Hint);
end;

procedure TfrmConfigDaycoval_707.pShowHintBotao(btnBotao: TBitBtnLocked;
  strTitulo: String);
begin
  HintControler.ShowHint(btnBotao.ClientOrigin.X,btnBotao.ClientOrigin.Y, strTitulo, btnBotao.Hint);
end;

function TfrmConfigDaycoval_707.RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;
begin
  While Not Sender.ClassName.Equals('TcxTabSheet') Do
  Begin
    Sender := Sender.Parent;
  End;
  Result := TcxTabSheet(Sender);
end;

procedure TfrmConfigDaycoval_707.edtCtaBaiKeyPress(Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, edtCtaBai, edtDesCtaBai, Nil, Key, arrCentroCusto) Then
    if fValidaCampos(edtCtaBai) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfigDaycoval_707.edtDiasCredEnter(Sender: TObject);
begin
  inherited;

  edtDiasCred.Hint := 'Informar quantidade de dias ' + #13+#10 +
                      'do intervalo entre a efetuação ' + #13+#10 +
                      'do pagamento e o crédito na ' + #13+#10 +
                      'conta corrente.';

  pShowHint(edtDiasCred, 'Dias para Crédito');

end;

procedure TfrmConfigDaycoval_707.edtDiasCredExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigDaycoval_707.pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
begin
  If fEmptyStr(strCtaBai) Then
    Exit;

  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  edtLabel.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;
end;

procedure TfrmConfigDaycoval_707.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
  cxPaginas.ActivePage := tbsGeral;
end;


procedure TfrmConfigDaycoval_707.tabCarteiraChanging(Sender: TObject;
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

procedure TfrmConfigDaycoval_707.FormActivate(Sender: TObject);
begin
  inherited;
  If edtProxNumArqRem.Enabled Then
    pSetFocus(edtProxNumArqRem)
  Else
    pSetFocus(edtCodAgencia);
end;

procedure TfrmConfigDaycoval_707.FormCreate(Sender: TObject);
begin
  inherited;
  pCarKeyAutBan;
  qryCadPor := fCriaQuery(Self);
  qryCadFor := fCriaQuery(Self);
  cxPaginas.Properties.ActivePage := tbsGeral;

  If fCfgSis('ENCBAN', varBoolean) Then
    tbsEncBan.TabVisible := True
  else
    tbsEncBan.TabVisible := False;
end;

procedure TfrmConfigDaycoval_707.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigDaycoval_707.btnCancelarClick(Sender: TObject);
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

procedure TfrmConfigDaycoval_707.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pHideHint;

    pCriarFormularios(TfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '707';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigDaycoval_707.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\707400p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\707400p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigDaycoval_707.BtnOcorrenciaClick(Sender: TObject);
  Var
    strDetalhe : String;
begin
  inherited;
  pHideHint;


  strDetalhe := #13#10 +
                '06, 08 - Baixa duplicata; ' + #13#10 +
                '02, 04 - Atualiza nosso número caso não tenha gravado; ' + #13#10 +
                '23 - Lança histórico de protesto; ' + #13#10 +
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


  TfrmMemo.pShowMessage('Banco 707 - Itaú - Detalhamento de Ocorrências (posições 109 - 110 arquivo retorno).' + #13#10 +
                        strDetalhe);
end;

procedure TfrmConfigDaycoval_707.BtnOcorrenciaEnter(Sender: TObject);
begin
  inherited;
  btnOcorrencia.Hint := 'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
                        'que são tratados pelas rotinas do sistema.';
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigDaycoval_707.BtnOcorrenciaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigDaycoval_707.chkCartSeqClick(Sender: TObject);
begin
  inherited;
  If Not fValidaCampos(chkCartSeq) Then
    TCheckBox(Sender).Checked := False;

  lblCartSeq.Enabled := TCheckBox(Sender).Checked;
  edtCartSeq.Enabled := TCheckBox(Sender).Checked;
end;

procedure TfrmConfigDaycoval_707.cmbNumCartChange(Sender: TObject);
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

procedure TfrmConfigDaycoval_707.edtForTarKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmConfigDaycoval_707.edtPorTarKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmConfigDaycoval_707.edtValorTarifaExit(Sender: TObject);
begin
  inherited;
  try
    if not fEmptyStr(edtValorTarifa.Text) then
       edtValorTarifa.Text := FormatFloat('###,##0.00', fStrToFloat(edtValorTarifa.Text));
  except
      edtValorTarifa.Text := FormatFloat('###,##0.00', 0);
  end
end;

procedure TfrmConfigDaycoval_707.edtMandMsgEnter(Sender: TObject);
begin
  inherited;
  edtMandMsg.Hint := 'Enviar número de duplicatas agrupadas.  '+ #13#10 +
                     'Configuração não válida para intruções 93 ou 94. ';

  pShowHint(edtMandMsg, 'Duplicatas agrupadas');
end;

procedure TfrmConfigDaycoval_707.edtMandMsgExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigDaycoval_707.pCarregaCfg(Var stlCampos: TStringList);
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
  stlCampos.Add('Portador da remessa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', ''));
  stlCampos.Add('Conta de baixa    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Cód. instrução 1  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', ''));
  stlCampos.Add('Cód. instrução 2  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', ''));
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
  stlCampos.Add('Código do Flash   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CDFLASH', ''));
  stlCampos.Add('Envia Dup. Agrup. :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ENVDUPAG', ''));
  stlCampos.Add('Conv. Serasa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CVSERAS', ''));
  stlCampos.Add('EncBan - Vr Tarifa:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', ''));
  stlCampos.Add('EncBan - Portador :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', ''));
  stlCampos.Add('EncBan - Conta    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', ''));
  stlCampos.Add('EncBan - Fornec.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', ''));
  stlCampos.Add('Considerar código liquidação:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODLIQU', 'N'));
  stlCampos.Add('Prefixo do Nome dos Arquivos de Remessa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NOMPREF', ''));
end;

procedure TfrmConfigDaycoval_707.pGravaLogCarteira(stlCfgAnt : TStringList);
Var
  intCont,
  intIndice: Integer;
  stlCfgAtu: TStringList;
  strCmpAlt: String;
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
    pGravaLogAtb('707', 'Daycoval', strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

end.
