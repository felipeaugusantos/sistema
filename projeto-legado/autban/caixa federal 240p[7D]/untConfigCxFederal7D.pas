unit untConfigCxFederal7D;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, Mask, DirectoryEditFocus,
  EditFocus, QColorLabel, Menus, ComCtrls, ShellApi, Uni, AppEvnts, ComboBoxFocus,
  BitBtnLockedIncrem, untTypesSistema, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, StrUtils, cxTextEdit, cxMaskEdit, cxButtonEdit, dxScreenTip,
  cxClasses, dxCustomHint, cxHint, 
  untFrameDirectoryEditFocus, untFramePlanoDeContasMaskEdit, dxBarBuiltInMenu,
  cxPC;

type
  TfrmConfigCxFederal7D = class(TfrmPai)
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
    tbsComplemento: TcxTabSheet;
    pnlComplemento: TPanel;
    Label45: TLabel;
    edtCodPorRem: TEditFocus;
    edtDescPorRem: TEditFocus;
    pnlAtivo: TPanel;
    lblDigitoVerifi: TLabel;
    lblCedente: TLabel;
    lblCodAgenc: TLabel;
    lblContCorr: TLabel;
    lblDiasProt: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    lblProNum: TLabel;
    lblResp: TLabel;
    lblEmpBan: TColorLabel;
    lblCodPor: TLabel;
    lblCodCart: TLabel;
    lblObservacao1: TLabel;
    lblObservacao2: TLabel;
    lblObservacao3: TLabel;
    lblObservacao4: TLabel;
    lblObservacao5: TLabel;
    lblDiasCred: TLabel;
    lblSimNao: TColorLabel;
    lblProAce: TLabel;
    lblPerMul: TLabel;
    lblNumNos: TLabel;
    lblNumNos2: TColorLabel;
    lblBaiDev: TLabel;
    lblDiasDev: TLabel;
    lblInfAdi: TLabel;
    lblTipDia: TLabel;
    Label23: TLabel;
    lblVerArq: TLabel;
    lblVerLot: TLabel;
    lblTipDistri: TLabel;
    edtDigCtaCor: TEditFocus;
    edtResp: TEditFocus;
    edtProxNumArqRem: TEditFocus;
    cmbSisCob: TComboBoxFocus;
    cmbSIGCB: TComboBoxFocus;
    edtNumConvenio: TEditFocus;
    edtDigitoVerifi: TEditFocus;
    edtDigAgencia: TEditFocus;
    cmbBaiDev: TComboBoxFocus;
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
    edtDiasCred: TEditFocus;
    edtProAce: TEditFocus;
    edtPerMul: TEditFocus;
    edtNumNos: TEditFocus;
    edtInfAdi: TEditFocus;
    cmbTipDia: TComboBoxFocus;
    edtVerArq: TEditFocus;
    edtVerLot: TEditFocus;
    cmbTipDistribuicao: TComboBoxFocus;
    fraPathRemessaCXF: TfraDirectoryEditFocus;
    fraPathRetornoCXF: TfraDirectoryEditFocus;
    edtDiasDev: TEditFocus;
    cmbSICOB: TComboBoxFocus;
    cmbSINCO: TComboBoxFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
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
    procedure cmbSisCobChange(Sender: TObject);
    procedure edtRespChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cmbSIGCBChange(Sender: TObject);
    procedure edtNumConvenioEnter(Sender: TObject);
    procedure edtNumConvenioExit(Sender: TObject);
    procedure edtDiasCredEnter(Sender: TObject);
    procedure edtDiasCredExit(Sender: TObject);
    procedure btnConfigurarEnter(Sender: TObject);
    procedure btnConfigurarExit(Sender: TObject);
    procedure BtnOcorrenciaEnter(Sender: TObject);
    procedure BtnOcorrenciaExit(Sender: TObject);
    procedure BtnOcorrenciaClick(Sender: TObject);
    procedure edtNumNosEnter(Sender: TObject);
    procedure edtNumNosExit(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure ApplicationEventsDeactivate(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorRemKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;
    intMaxDev : Integer;
    intMinDev : Integer;
    intMinPro : Integer;

    procedure pCarregaCentroCusto(strCtaBai: String; edtLabel: TEdit);
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pVerificaSistemaCobranca(blnComboChange: Boolean = False; blnTabChange: Boolean = False);
    procedure pShowHint(edtEdit: TEditFocus; strTitulo: String);
    procedure pHideHint;
    procedure pShowHintBotao(btnBotao: TBitBtnLocked; strTitulo: String);
    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
    procedure pValidaProximoNumero;
    procedure pValidaCarteira;
    procedure pValidaTipoCarteira;
    procedure pValidaDistribuicao;
    procedure pGravarDistribuicao;
    procedure pValidaComboBoxs;
    procedure pValidaBaixaDevolucao;
    procedure pValidaResponsavel;
    function fRetStrCfg(stlCfg : TStringList) : String;
  public
    { Public declarations }
    blnNaoEditar : Boolean;
    strConfig    : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigCxFederal7D: TfrmConfigCxFederal7D;

implementation

uses untfuncoesSimples, untFuncoes,
     untPesqAux, untCfgGenericas_AutBan,  untConsultas, untMemo;

{$R *.dfm}

procedure TfrmConfigCxFederal7D.fraPlanoDeContasMskCodCtaKeyPress(
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

function TfrmConfigCxFederal7D.fRetStrCfg(stlCfg : TStringList) : String;
  Var
  intCont : Integer;
begin
  Result := '';

  For intCont := 0 To stlCfg.Count - 1 Do
    Result := Result + stlCfg.Strings[intCont] + #13+#10;
end;

procedure TfrmConfigCxFederal7D.pValidaResponsavel;
Begin
  If (cmbSIGCB.ItemIndex = 0) Then
    edtResp.Enabled := False
  Else If (cmbSIGCB.ItemIndex = 1) Then
    edtResp.Enabled := False
  Else
    edtResp.Enabled := True;
End;

procedure TfrmConfigCxFederal7D.pValidaBaixaDevolucao;
Begin
  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIXDEV', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIXDEV', '')) Of
      1: cmbBaiDev.ItemIndex := 0;
      2: cmbBaiDev.ItemIndex := 1;
    End;
  End
  Else
    cmbBaiDev.ItemIndex := -1;

  If cmbBaiDev.ItemIndex = 1 Then
  Begin
    intMinDev := 0;
    intMinPro := 2;
  End
  Else
  If cmbBaiDev.ItemIndex = 0 Then
  Begin
    intMinDev := 5;
    intMinPro := 0;
  End;
End;

procedure TfrmConfigCxFederal7D.pValidaComboBoxs;
Begin
    If cmbSICOB.Visible Then
    Begin
      Case StrToInt(fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', '')) Of
        11: cmbSICOB.ItemIndex := 0;
        12: cmbSICOB.ItemIndex := 1;
        14: cmbSICOB.ItemIndex := 2;
        41: cmbSICOB.ItemIndex := 3;
      End;
    End
    Else If cmbSIGCB.Visible Then
    Begin
      Case StrToInt(fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', '')) Of
        11: cmbSIGCB.ItemIndex := 0;
        12: cmbSIGCB.ItemIndex := 1;
        14: cmbSIGCB.ItemIndex := 2;
        24: cmbSIGCB.ItemIndex := 3;
      End;
      pValidaResponsavel;
    End
    Else If cmbSINCO.Visible Then
    Begin
      Case StrToInt(fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', '')) Of
        1: cmbSINCO.ItemIndex := 0;
        8: cmbSINCO.ItemIndex := 1;
      End;
    End;
End;

procedure TfrmConfigCxFederal7D.pGravarDistribuicao;
Begin
  If cmbTipDistribuicao.Visible Then
  Begin
    If edtResp.Text = 'E' Then
    Begin
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'DISTRI' , '0');
    End
    Else
    Begin
      If  cmbTipDistribuicao.ItemIndex >= 0 Then
      Begin
        fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'DISTRI' ,  IntToStr((cmbTipDistribuicao.ItemIndex + 1)));
      End;
    End;
  End;

  If cmbSisCob.ItemIndex >= 0 Then
    fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'SISCOB' , cmbSisCob.Text      );
End;

procedure TfrmConfigCxFederal7D.pValidaProximoNumero;
begin
  If fEmptyStr(fGetBancoConfig(0, 'CONFIG1047D', 'PROXNUM', '')) Then
  Begin
    edtProxNumArqRem.Enabled := True;
    edtProxNumArqRem.Clear;
    pSetFocus(edtProxNumArqRem);
  End
  Else
  Begin
    edtProxNumArqRem.Text := fGetBancoConfig(0, 'CONFIG1047D', 'PROXNUM', '');
    edtProxNumArqRem.Enabled := False;
    pSetFocus(cmbSisCob);
  End;
end;

procedure TfrmConfigCxFederal7D.pValidaCarteira;
begin
  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', '')) Then
  Begin
    pValidaComboBoxs;
  End
  Else
  Begin
    If cmbSICOB.Visible Then
      cmbSICOB.ItemIndex := -1
    Else If cmbSIGCB.Visible Then
      cmbSIGCB.ItemIndex := -1
    Else If cmbSINCO.Visible Then
      cmbSINCO.ItemIndex := -1;
  End;
end;

procedure TfrmConfigCxFederal7D.pValidaTipoCarteira;
begin

  If fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'SISCOB',  '') = 'SICOB' Then
  begin
    cmbSisCob.ItemIndex := 0;
    intMaxDev := 90;
    cmbTipDistribuicao.Visible:= False;
    lblTipDistri.Visible := False;
  End
  Else
  If fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'SISCOB',  '') = 'SIGCB' Then
  Begin
    cmbSisCob.ItemIndex := 1;
    intMaxDev := 120;

    cmbTipDistribuicao.Enabled   := (edtResp.Text = 'B');
    cmbTipDistribuicao.Visible   := (edtResp.Text = 'B');
    lblTipDistri.Visible         := (edtResp.Text = 'B');
    cmbTipDistribuicao.ItemIndex := IIF ((edtResp.Text = 'B'),-1,cmbTipDistribuicao.ItemIndex);

  End
  Else
  If fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'SISCOB',  '') = 'SINCO' Then
  Begin
    cmbSisCob.ItemIndex := 2;
    intMaxDev := 90;
    cmbTipDistribuicao.Visible:= False;
    lblTipDistri.Visible := False;
  End
  Else
  Begin
    cmbSisCob.ItemIndex := -1;
    cmbTipDistribuicao.Visible:= False;
    lblTipDistri.Visible := False;
  End;

end;

procedure TfrmConfigCxFederal7D.pValidaDistribuicao;
Begin
  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'DISTRI',  '')) Then
    cmbTipDistribuicao.ItemIndex := (StrToInt( fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'DISTRI',  '')) - 1);

  If edtResp.Text = 'B' Then
  Begin
    cmbTipDistribuicao.ItemIndex := 1;
  End;

  If cmbSisCob.ItemIndex <> - 1 Then
    fValidaCampos(cmbSisCob);
End;

procedure TfrmConfigCxFederal7D.pCarregaDados;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************AF*}
  pValidaProximoNumero;
  edtNumConvenio.Text   := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', '');
  edtCodAgencia.Text    := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtDigAgencia.Text    := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', '');
  edtContaCorr.Text     := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', '');
  edtDigCtaCor.Text     := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', '');
  edtDigitoVerifi.Text  := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGVERI', '');
  edtDiasProt.Text      := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '');
  edtResp.Text          := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', '');

  pValidaCarteira;
  edtDesPor.Text := '';
  edtDescPorRem.Text := '';
  fraPlanoDeContas.edtDesCta.Text := '';

  edtObservacao1.Text   := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text   := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text   := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text   := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text   := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');

  fraPathRemessaCXF.edtDirectory.text:= fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '');
  fraPathRetornoCXF.edtDirectory.text:= fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '');
  edtCodPor.Text        := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  edtCodPorRem.Text      := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');
  edtDesPor.Text        := '';
  fraPlanoDeContas.MskCodCta.Text        := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');
  fraPlanoDeContas.edtDesCta.Text     := '';

  edtDiasCred.Text      := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', '');
  edtProAce.Text        := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', '');

  pValidaBaixaDevolucao;

  edtPerMul.Text        := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', '');
  edtNumNos.Text        := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMNOSS', '');
  edtDiasDev.Text       := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'DIASDEV', '');
  edtInfAdi.Text        := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', '');
  edtVerArq.Text        := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'VERARQ',  '');
  edtVerLot.Text        := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'VERLOT',  '');
  cmbTipDia.ItemIndex   := StrToInt(fGetBancoConfig(0,'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1),'TIPDIA', '1'))-1;

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCodPorRem.Text ) Then
    pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);

  If Not fEmptyStr( fraPlanoDeContas.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);

  edtPerImpBol.Text     := fGetBancoConfig(0,'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', '');
  If fEmptyStr(edtPerImpBol.Text) Then
    edtPerImpBol.Text := 'S';

  pValidaTipoCarteira;

  pValidaDistribuicao;
end;

procedure TfrmConfigCxFederal7D.FormShow(Sender: TObject);
begin
  inherited;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  pVerificaSistemaCobranca;
  pCarregaDados;

  If edtProxNumArqRem.Enabled Then
    pSetFocus(edtProxNumArqRem)
  Else
    pSetFocus(cmbSisCob);

  pSetFocus(btnEditar);

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

procedure TfrmConfigCxFederal7D.btnConfigurarEnter(Sender: TObject);
begin
  inherited;
  btnConfigurar.Hint := 'Configurar percentual de ' + #13+#10 +
                        'juros para remessa.';
  pShowHintBotao(btnConfigurar, 'Cofigurações específicas.');
end;

procedure TfrmConfigCxFederal7D.btnConfigurarExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCxFederal7D.btnEditarClick(Sender: TObject);
begin
  If ((Not fVerificaDireitoAutBan('PERCARBAN'))) Then
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

    if edtProxNumArqRem.Enabled then
      pSetFocus(edtProxNumArqRem)
    else
      pSetFocus(cmbSisCob);

  end;
end;

procedure TfrmConfigCxFederal7D.btnGravarClick(Sender: TObject);
Var
  stlCfgAnt : TStringList;
begin
  inherited;
  If fVerificaCampos Then
  Begin
    Try
      stlCfgAnt := TStringList.Create;
      pCarregaCfg(stlCfgAnt);

      fGetBancoConfig(1, 'CONFIG1047D', 'PROXNUM', edtProxNumArqRem.Text );
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', edtNumConvenio.Text   );
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text    );
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', edtDigAgencia.Text    );
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text     );
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', edtDigCtaCor.Text     );
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGVERI', edtDigitoVerifi.Text  );
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text      );
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text          );

      If cmbSICOB.Visible Then
        fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', cmbSICOB.Text      )
      Else If cmbSIGCB.Visible Then
        fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', cmbSIGCB.Text      )
      Else If cmbSINCO.Visible Then
        fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', cmbSINCO.Text      );

      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text   );
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text   );
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text   );
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text   );
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text   );

      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessaCXF.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetornoCXF.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text        );
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text       );
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContas.MskCodCta.Text        );

      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text      );
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text        );
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIXDEV', LeftStr(cmbBaiDev.Text,1));
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'DIASDEV', edtDiasDev.Text       );

      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', edtPerMul.Text        );
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMNOSS', edtNumNos.Text        );
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text        );
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPDIA' , IntToStr(cmbTipDia.ItemIndex+1));

      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'VERARQ' , edtVerArq.Text        );
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'VERLOT' , edtVerLot.Text        );
      fGetBancoConfig(1, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', edtPerImpBol.Text   );

      pGravarDistribuicao;

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        pBackupCnfBco;
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        edtProxNumArqRem.Enabled := False;
        pSetFocus(cmbSisCob);
        pnlAtivo.Enabled  := False;
        pnlComplemento.Enabled := pnlAtivo.Enabled;
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
    Except
      On E:Exception Do
      Begin
        fMensagem('Erro','Ocorreu um erro ao tentar salvar os dados.' + #13 + E.Message,['&O K']);
      End;
    End;

    FreeAndNil(stlCfgAnt);
  End;
end;

function TfrmConfigCxFederal7D.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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

    Else If Sender = edtResp Then
    Begin

      If (edtResp.Text <> 'E') And (edtResp.Text <> 'B') Then
      Begin
        fMensagem('','O campo Resp. por emissão de boletos deve ser E ou B!'+strMensagemConfig,['&O K']);
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

    Else If Sender = edtNumNos Then
    Begin
      If Pos(edtNumNos.Text, '12') <= 0 Then
      Begin
        fMensagem('','O Nosso número deve ser preenchido com (1 ou 2)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = fraPathRemessaCXF Then
    Begin

      If fEmptyStr(fraPathRemessaCXF.edtDirectory.text) Then
      Begin
        fMensagem('','Preencha o campo Path de Remessa'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If Sender = fraPathRetornoCXF Then
    Begin

      If fEmptyStr(fraPathRetornoCXF.edtDirectory.text) Then
      Begin
        fMensagem('','Preencha o campo Path de Retorno'+strMensagemConfig,['&O K']);
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

    Else If (Sender = edtPerMul) Then
    Begin
      If Not fValidaEscala(edtPerMul.Text, 0, 100) Then
      begin
        fMensagem('ATENÇÃO!','O campo percentual de multa deve estar entre 0 e 100!'+strMensagemConfig,['&OK']);
        Result := False;
      end;
    End

    Else If (Sender = cmbSICOB) And
            (cmbSICOB.Visible)  Then
    Begin

      If cmbSICOB.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo código da carteira deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;

    End

    Else If (Sender = cmbSIGCB) And
            (cmbSIGCB.Visible)  Then
    Begin

      If (cmbSIGCB.ItemIndex = 0) or (cmbSIGCB.ItemIndex = 1) Then
      Begin
        edtResp.Text    := 'B';
        edtResp.Enabled := False;
      End
      Else
        edtResp.Enabled := True;

      If cmbSIGCB.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo código da carteira deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;

    End

    Else If (Sender = cmbSINCO) And
            (cmbSINCO.Visible)  Then
    Begin

      If cmbSINCO.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo código da carteira deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;

    End

    Else If (Sender = edtVerArq) Then
    Begin
      Case cmbSisCob.ItemIndex Of
        0,2:Begin
              If edtVerArq.Text <> '030' Then
              Begin
                fMensagem('ATENÇÃO!','O campo versão do arquivo deve ser 030!'+strMensagemConfig, ['&OK']);
                Result := False;
              End;
            End;
        1 : Begin
              If (edtVerArq.Text <> '050') and (edtVerArq.Text <> '101') and  (edtVerArq.Text <> '107') Then
              Begin
                fMensagem('ATENÇÃO!','O campo versão do arquivo deve ser 050,101 ou 107!'+strMensagemConfig, ['&OK']);
                Result := False;
              End;
            End;
      End;
    End

    Else If (Sender = edtVerLot) Then
    Begin
      Case cmbSisCob.ItemIndex Of
        0,2:Begin
              If edtVerLot.Text <> '020' Then
              Begin
                fMensagem('ATENÇÃO!','O campo versão do arquivo deve ser 020!'+strMensagemConfig, ['&OK']);
                Result := False;
              End;
            End;
        1 : Begin
              If (edtVerLot.Text <> '030') and (edtVerLot.Text <> '060') and  (edtVerLot.Text <> '067') Then
              Begin
                fMensagem('ATENÇÃO!','O campo versão do arquivo deve ser 030, 060 ou 067!'+strMensagemConfig, ['&OK']);
                Result := False;
              End;
            End;
      End;
    End
    Else If Sender = cmbSisCob Then
    Begin
      If cmbSisCob.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Sistema de cobrança deve ser informado!'+strMensagemConfig, ['&OK']);
        Result := False;
      End
      Else
      Begin
        Case cmbSisCob.ItemIndex Of
          0,2: Begin
                 intMaxDev := 90;
                 edtNumConvenio.TamCampo := 12;
                 edtNumConvenio.MaxLength:= 12;

                 edtNumConvenio.Hint := 'Informar convênio no formato OOOCCCCCCCCD' + #13+#10 +
                                        'Onde: OOO = código da operação;' + #13+#10 +
                                        '      CCCCCCCC = código do cedente;' + #13+#10 +
                                        '      D = dígito';
                 lblCedente.Caption := 'Número do Convênio (Com Dígito):'
               End;
          1  : Begin
                 intMaxDev := 120;
                 edtNumConvenio.TamCampo := 7;
                 edtNumConvenio.MaxLength:= 7;

                 edtNumConvenio.Hint := 'O dígito será calculado na rotina de impressão de boletos';
                 lblCedente.Caption := 'Número do Convênio (Sem Dígito):'
               End;
        End;
      End;
    End

    Else If Sender = edtNumConvenio Then
    Begin
      If (Length(edtNumConvenio.Text) <> edtNumConvenio.TamCampo) Then
      Begin
        Case cmbSisCob.ItemIndex Of
          0,2: fMensagem('ATENÇÃO!','O Campo Número do convênio deve ser preenchido com 12 caracteres!'+strMensagemConfig, ['&OK']);
          1  : fMensagem('ATENÇÃO!','O Campo Número do convênio deve ser preenchido com 7 caracteres!'+strMensagemConfig, ['&OK']);
        End;

        Result := False;
      End;

    End

    Else If (Sender = edtDigAgencia) And (edtDigAgencia.Visible) Then
    Begin
      If fEmptyStr(edtDigAgencia.Text) Then
      Begin
        fMensagem('ATNEÇÃO!','O campo Dígito da Agência deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigitoVerifi) And (edtDigitoVerifi.Visible) Then
    Begin
      If fEmptyStr(edtDigitoVerifi.Text) Then
      Begin
        fMensagem('ATNEÇÃO!','O campo Dígito verificador deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodAgencia) And (edtCodAgencia.Visible) Then
    Begin
      If fEmptyStr(edtCodAgencia.Text) Then
      Begin
        fMensagem('ATNEÇÃO!','O campo Código da Agência deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else If Length(edtCodAgencia.Text) <> edtCodAgencia.MaxLength Then
      Begin
        fMensagem('ATNEÇÃO!','O campo Código da Agência deve ter 5 caracteres!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = cmbBaiDev) Then
    Begin
      If cmbBaiDev.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Procedimento com títulos vencidos deve ser informado!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtDiasDev) Then
    Begin
      If cmbBaiDev.ItemIndex = 0 Then
        intMinDev := 5
      Else
      If cmbBaiDev.ItemIndex = 1 Then
        intMinDev := 0;

      If fEmptyStr(edtDiasDev.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Dias para Baixa/Devolução deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result:= False;
      End
      Else
      Begin
        If (StrToInt(edtDiasDev.Text) < intMinDev) Or
           (StrToInt(edtDiasDev.Text) > intMaxDev) Then
        Begin
          fMensagem('ATENÇÃO!','O valor campo Dias para Baixa/Devolução deve ser entre ' + IntToStr(intMinDev) + ' e ' + IntToStr(intMaxDev) + '!'+strMensagemConfig,['&OK']);
          Result:= False;
        End;
      End;
    End

    Else If (Sender = edtContaCorr) And
            (edtContaCorr.Visible)  Then
    Begin
      If fEmptyStr(edtContaCorr.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Número da Conta Corrente deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigCtaCor) And
            (edtDigCtaCor.Visible)  Then
    Begin
      If fEmptyStr(edtDigCtaCor.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Dígito da Conta Corrente deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtDiasProt) Then
    Begin
      If cmbBaiDev.ItemIndex = 1 Then
        intMinPro := 2
      Else
      If cmbBaiDev.ItemIndex = 0 Then
        intMinPro := 0;

      If fEmptyStr(edtDiasProt.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Dias para protesto deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result:= False;
      End
      Else
      Begin
        If (StrToInt(edtDiasProt.Text) < intMinPro) Or
           (StrToInt(edtDiasProt.Text) > 90)        Then
        Begin
          fMensagem('ATENÇÃO!','O valor campo Dias para protesto deve ser entre ' + IntToStr(intMinPro) + ' e 90!'+strMensagemConfig,['&OK']);
          Result:= False;
        End;
      End;
    End;

  End;

  If Not Result Then
    if not blnNaoEditar then
      pSetFocus(Sender);

End;

procedure TfrmConfigCxFederal7D.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  If edtNumConvenio.Focused Then
    Self.SelectNext(ActiveControl, True, True);

  pVerificaSistemaCobranca(False, True);
  pCarregaDados;
end;

procedure TfrmConfigCxFederal7D.tabCarteiraChanging(Sender: TObject;
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

procedure TfrmConfigCxFederal7D.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, nil, Key, arrSel) then
    Begin
      If fValidaCampos(edtCodPor, True)Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigCxFederal7D.edtCodPorRemKeyPress(Sender: TObject;
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

procedure TfrmConfigCxFederal7D.edtDiasCredEnter(Sender: TObject);
begin
  inherited;
  edtDiasCred.Hint := 'Informar quantidade de dias ' + #13+#10 +
                      'do intervalo entre a efetuação ' + #13+#10 +
                      'do pagamento e o crédito na ' + #13+#10 +
                      'conta corrente.';

  pShowHint(edtDiasCred, 'Dias para Crédito');
end;

procedure TfrmConfigCxFederal7D.edtDiasCredExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCxFederal7D.edtNumConvenioEnter(Sender: TObject);
begin
  inherited;
  pShowHint(edtNumConvenio, 'Preenchimento do convênio (Cedente)');
end;

procedure TfrmConfigCxFederal7D.edtNumConvenioExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCxFederal7D.edtNumNosEnter(Sender: TObject);
begin
  inherited;
  inherited;
  If cmbSisCob.ItemIndex = 0 Then
  Begin
    edtNumNos.Hint := 'Verifique no cadastro de bancos (Autcom)' + #13+#10 +
                      'se o nosso número correspondente ao' + #13+#10 +
                      'cadastrado aqui é iniciado com' + #13+#10 +
                      '80, 81 ou 82';
    pShowHint(edtNumNos, 'Índice do nosso número');
  End;
end;

procedure TfrmConfigCxFederal7D.edtNumNosExit(Sender: TObject);
begin
  inherited;
  If cmbSisCob.ItemIndex = 0 Then
    pHideHint;
end;

procedure TfrmConfigCxFederal7D.edtRespChange(Sender: TObject);
begin
  inherited;
  If edtResp.Text = 'E' Then
  Begin
    cmbTipDistribuicao.Visible:= False;
    lblTipDistri.Visible := False;
  End
  Else
  Begin
    If (cmbSisCob.ItemIndex = 0) Then
    Begin
      cmbTipDistribuicao.Visible:= False;
      lblTipDistri.Visible := False;
    End
    Else  If (cmbSisCob.ItemIndex = 2) Then
    Begin
      cmbTipDistribuicao.Visible:= False;
      lblTipDistri.Visible := False;
    End
    Else
    Begin
      cmbTipDistribuicao.ItemIndex := 1;
      cmbTipDistribuicao.Enabled   := True;
      cmbTipDistribuicao.Visible   := True;
      lblTipDistri.Visible         := True;
    End;
  End;
end;

procedure TfrmConfigCxFederal7D.pCarregaCentroCusto(strCtaBai: String; edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  fraPlanoDeContas.edtDesCta.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;
end;

procedure TfrmConfigCxFederal7D.pCarregaPortador(strCodPor: String; edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  edtLabel.Text := qryCadPor.FieldByName('POR_NOMPOR').AsString;
end;

procedure TfrmConfigCxFederal7D.pHideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmConfigCxFederal7D.pShowHint(edtEdit: TEditFocus; strTitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,edtEdit.ClientOrigin.Y, strTitulo, edtEdit.Hint);
end;

procedure TfrmConfigCxFederal7D.pShowHintBotao(btnBotao: TBitBtnLocked;
  strTitulo: String);
begin
  HintControler.ShowHint(btnBotao.ClientOrigin.X,btnBotao.ClientOrigin.Y, strTitulo, btnBotao.Hint);
end;

procedure TfrmConfigCxFederal7D.pVerificaSistemaCobranca(blnComboChange: Boolean = False; blnTabChange: Boolean = False);
begin
  If ((Not blnComboChange)                                                                            And
      (fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'SISCOB',  '') = 'SIGCB')) Or
     ((cmbSisCob.ItemIndex = 1)                                                                       And
      (Not blnTabChange))                                                                             Then
  Begin
    edtVerArq.Text := '107';
    edtVerLot.Text := '067';

    If edtDigitoVerifi.Visible Then
    Begin
      lblTipDia.Top          := lblTipDia.Top - 21;
      lblVerArq.Top          := lblVerArq.Top - 21;
      lblVerLot.Top          := lblVerLot.Top - 21;
      cmbTipDia.Top          := cmbTipDia.Top - 21;
      edtVerArq.Top          := edtVerArq.Top - 21;
      edtVerLot.Top          := edtVerLot.Top - 21;
      lblNumNos.Top          := lblNumNos.Top - 21;
      lblNumNos2.Top         := lblNumNos2.Top - 21;
      lblNumNos2.Caption     := 'Nosso número (1) / Nosso número (2';
      lblNumNos2.Caption     := 'Nosso número (1) / Nosso número (2)';
      lblInfAdi.Top          := lblInfAdi.Top - 21;
      edtNumNos.Top          := edtNumNos.Top - 21;
      edtInfAdi.Top          := edtInfAdi.Top - 21;
      lblPerMul.Top          := lblPerMul.Top - 21;
      lblBaiDev.Top          := lblBaiDev.Top - 21;
      cmbBaiDev.Top          := cmbBaiDev.Top - 21;
      lblDiasDev.Top         := lblDiasDev.Top - 21;
      edtPerMul.Top          := edtPerMul.Top - 21;
      edtDiasDev.Top         := edtDiasDev.Top - 21;
      fraPlanoDeContas.Top   := fraPlanoDeContas.Top -21;
      //lblCtaBai.Top          := lblCtaBai.Top - 21;
      //edtCtaBai.Top          := edtCtaBai.Top - 21;
      //edtDesCtaBai.Top       := edtDesCtaBai.Top - 21;
      lblCodPor.Top          := lblCodPor.Top - 21;
      edtCodPor.Top          := edtCodPor.Top - 21;
      edtDesPor.Top          := edtDesPor.Top - 21;
      lblProAce.Top          := lblProAce.Top - 21;
      lblSimNao.Top          := lblSimNao.Top - 21;
      lblSimNao.Caption      := '(S)im (N)ã';
      lblSimNao.Caption      := '(S)im (N)ão';
      edtProAce.Top          := edtProAce.Top - 21;
      lblResp.Top            := lblResp.Top - 21;
      lblEmpBan.Top          := lblEmpBan.Top - 21;
      lblEmpBan.Caption      := '(E)mpresa (B)anc';
      lblEmpBan.Caption      := '(E)mpresa (B)anco';
      lblTipDistri.Top       := lblTipDistri.Top - 21;
      edtResp.Top            := edtResp.Top - 21;
      cmbTipDistribuicao.Top := cmbTipDistribuicao.Top - 21;
      lblPathArquivosRet.Top := lblPathArquivosRet.Top - 21;
      fraPathRetornoCXF.Top  := fraPathRetornoCXF.Top - 21;
      lblPathArquivosRem.Top := lblPathArquivosRem.Top - 21;
      fraPathRemessaCXF.Top  := fraPathRemessaCXF.Top - 21;
      lblDiasProt.Top        := lblDiasProt.Top - 21;
      lblDiasCred.Top        := lblDiasCred.Top - 21;
      edtDiasProt.Top        := edtDiasProt.Top - 21;
      edtDiasCred.Top        := edtDiasCred.Top - 21;
      lblObservacao5.Top     := lblObservacao5.Top - 21;
      edtObservacao5.Top     := edtObservacao5.Top - 21;
      lblObservacao4.Top     := lblObservacao4.Top - 21;
      edtObservacao4.Top     := edtObservacao4.Top - 21;
      lblObservacao3.Top     := lblObservacao3.Top - 21;
      edtObservacao3.Top     := edtObservacao3.Top - 21;
      lblObservacao2.Top     := lblObservacao2.Top - 21;
      edtObservacao2.Top     := edtObservacao2.Top - 21;
      lblObservacao1.Top     := lblObservacao1.Top - 21;
      edtObservacao1.Top     := edtObservacao1.Top - 21;

      edtDigitoVerifi.Clear;
      edtDigitoVerifi.Visible:= False;
      lblDigitoVerifi.Visible:= False;
      edtContaCorr.Clear;
      edtContaCorr.Visible   := False;
      lblContCorr.Visible    := False;
      edtDigCtaCor.Clear;
      edtDigCtaCor.Visible   := False;

      cmbSIGCB.Visible := True;
      cmbSIGCB.Left    := cmbSICOB.Left;
      cmbSIGCB.TabOrder:= 3;
      cmbSICOB.Visible := False;
      cmbSINCO.Visible := False;
    End;
  End
  Else
  Begin
    edtVerArq.Text := '030';
    edtVerLot.Text := '020';

    edtResp.Enabled := True;

    If Not edtDigitoVerifi.Visible Then
    Begin
      lblTipDia.Top          := lblTipDia.Top + 21;
      lblVerArq.Top          := lblVerArq.Top + 21;
      lblVerLot.Top          := lblVerLot.Top + 21;
      cmbTipDia.Top          := cmbTipDia.Top + 21;
      edtVerArq.Top          := edtVerArq.Top + 21;
      edtVerLot.Top          := edtVerLot.Top + 21;
      lblNumNos.Top          := lblNumNos.Top + 21;
      lblNumNos2.Top         := lblNumNos2.Top + 21;
      lblNumNos2.Caption     := 'Nosso número (1) / Nosso número (2';
      lblNumNos2.Caption     := 'Nosso número (1) / Nosso número (2)';
      lblInfAdi.Top          := lblInfAdi.Top + 21;
      edtNumNos.Top          := edtNumNos.Top + 21;
      edtInfAdi.Top          := edtInfAdi.Top + 21;
      lblPerMul.Top          := lblPerMul.Top + 21;
      lblBaiDev.Top          := lblBaiDev.Top + 21;
      cmbBaiDev.Top          := cmbBaiDev.Top + 21;
      lblDiasDev.Top         := lblDiasDev.Top + 21;
      edtPerMul.Top          := edtPerMul.Top + 21;
      edtDiasDev.Top         := edtDiasDev.Top + 21;
      fraPlanoDeContas.Top   := fraPlanoDeContas.Top + 21;
      //lblCtaBai.Top          := lblCtaBai.Top + 21;
      //edtCtaBai.Top          := edtCtaBai.Top + 21;
      //edtDesCtaBai.Top       := edtDesCtaBai.Top + 21;
      lblCodPor.Top          := lblCodPor.Top + 21;
      edtCodPor.Top          := edtCodPor.Top + 21;
      edtDesPor.Top          := edtDesPor.Top + 21;
      lblProAce.Top          := lblProAce.Top + 21;
      lblSimNao.Top          := lblSimNao.Top + 21;
      lblSimNao.Caption      := '(S)im (N)ã';
      lblSimNao.Caption      := '(S)im (N)ão';
      edtProAce.Top          := edtProAce.Top + 21;
      lblResp.Top            := lblResp.Top + 21;
      lblEmpBan.Top          := lblEmpBan.Top + 21;
      lblEmpBan.Caption      := '(E)mpresa (B)anc';
      lblEmpBan.Caption      := '(E)mpresa (B)anco';
      lblTipDistri.Top       := lblTipDistri.Top + 21;
      edtResp.Top            := edtResp.Top + 21;
      cmbTipDistribuicao.Top := cmbTipDistribuicao.Top + 21;
      lblPathArquivosRet.Top := lblPathArquivosRet.Top + 21;
      fraPathRetornoCXF.Top  := fraPathRetornoCXF.Top + 21;
      lblPathArquivosRem.Top := lblPathArquivosRem.Top + 21;
      fraPathRemessaCXF.Top  := fraPathRemessaCXF.Top + 21;
      lblDiasProt.Top        := lblDiasProt.Top + 21;
      lblDiasCred.Top        := lblDiasCred.Top + 21;
      edtDiasProt.Top        := edtDiasProt.Top + 21;
      edtDiasCred.Top        := edtDiasCred.Top + 21;
      lblObservacao5.Top     := lblObservacao5.Top + 21;
      edtObservacao5.Top     := edtObservacao5.Top + 21;
      lblObservacao4.Top     := lblObservacao4.Top + 21;
      edtObservacao4.Top     := edtObservacao4.Top + 21;
      lblObservacao3.Top     := lblObservacao3.Top + 21;
      edtObservacao3.Top     := edtObservacao3.Top + 21;
      lblObservacao2.Top     := lblObservacao2.Top + 21;
      edtObservacao2.Top     := edtObservacao2.Top + 21;
      lblObservacao1.Top     := lblObservacao1.Top + 21;
      edtObservacao1.Top     := edtObservacao1.Top + 21;

      edtDigitoVerifi.Visible:= True;
      lblDigitoVerifi.Visible:= True;
      edtContaCorr.Visible   := True;
      lblContCorr.Visible    := True;
      edtDigCtaCor.Visible   := True;
    End;

    cmbSIGCB.Visible := False;
    If (fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'SISCOB',  '') = 'SICOB') Or
       (cmbSisCob.ItemIndex = 0)                                                                      Then
    Begin
      cmbSICOB.Visible := True;
      cmbSICOB.TabOrder:= 3;
      cmbSINCO.Visible := False;
    End
    Else If (fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(tabCarteira.TabIndex + 1), 'SISCOB',  '') = 'SINCO') Or
            (cmbSisCob.ItemIndex = 2)                                                                      Then
    Begin
      cmbSINCO.Visible := True;
      cmbSINCO.Left    := cmbSICOB.Left;
      cmbSINCO.TabOrder:= 3;
      cmbSICOB.Visible := False;
    End;
  End;
end;

procedure TfrmConfigCxFederal7D.FormActivate(Sender: TObject);
begin
  inherited;
  If edtProxNumArqRem.Enabled Then
    pSetFocus(edtProxNumArqRem)
  Else
    pSetFocus(cmbSisCob);
end;

procedure TfrmConfigCxFederal7D.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  pCarKeyAutBan;
  strConfig := 'CONFIG1047D-';
  cxPaginas.Properties.ActivePage := tbsGeral;
end;

procedure TfrmConfigCxFederal7D.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigCxFederal7D.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCxFederal7D.btnCancelarClick(Sender: TObject);
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
    pCarregaDados;
    pSetFocus(btnEditar);
  end;
end;

procedure TfrmConfigCxFederal7D.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pHideHint;

    pCriarFormularios(TfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '104';
    frmCfgGenericas_AutBan.ShowModal;
  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigCxFederal7D.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\104240p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\104240p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigCxFederal7D.BtnOcorrenciaClick(Sender: TObject);
  Var
    strDetalhe : String;
begin
  inherited;
  pHideHint;

  strDetalhe := #13#10 +
                '06, 09' + IIF(cmbSisCob.ItemIndex = 1, '', ', 17') + ' - Baixa duplicata; ' + #13#10 +
                '02, 04 - Atualiza nosso número caso não tenha gravado; ' + #13#10 +
                '23 - Lança histórico de protesto; ' + #13#10 +
                '24 - Lança histórico de estorno de protesto. ' + #13#10 +
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


  TfrmMemo.pShowMessage('Banco 104 - Caixa Econômica Federal - Detalhamento de Ocorrências (posições 16 - 17 arquivo retorno).' + #13#10 +
                        strDetalhe);
end;

procedure TfrmConfigCxFederal7D.BtnOcorrenciaEnter(Sender: TObject);
begin
  inherited;
  btnOcorrencia.Hint := 'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
                        'que são tratados pelas rotinas do sistema.';
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigCxFederal7D.BtnOcorrenciaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCxFederal7D.cmbSIGCBChange(Sender: TObject);
begin
  inherited;
  If (cmbSIGCB.ItemIndex = 0) Then
  Begin
    edtResp.Text    := 'B';
    edtResp.Enabled := False;
  End
  Else If (cmbSIGCB.ItemIndex = 1) Then
  Begin
    edtResp.Text    := 'B';
    edtResp.Enabled := False;
  End
  Else
    edtResp.Enabled := True;
end;

procedure TfrmConfigCxFederal7D.cmbSisCobChange(Sender: TObject);
begin
  inherited;
  Case cmbSisCob.ItemIndex Of
  0,2: Begin
         cmbTipDistribuicao.Visible := False;
         lblTipDistri.Visible       := False;
         cmbTipDistribuicao.Enabled := False;

         pVerificaSistemaCobranca(True);

         edtNumConvenio.MaxLength:= 12;
         edtNumConvenio.TamCampo := 12;
         edtNumConvenio.Hint := 'Informar convênio no formato OOOCCCCCCCCD' + #13+#10 +
                                'Onde: OOO = código da operação;' + #13+#10 +
                                '      CCCCCCCC = código do cedente;' + #13+#10 +
                                '      D = dígito';
         lblCedente.Caption := 'Número do Convênio (Com Dígito):';
         intMaxDev := 90;
       End;
  1  : Begin
         pVerificaSistemaCobranca(True);

         edtNumConvenio.MaxLength:= 7;
         edtNumConvenio.TamCampo := 7;
         edtNumConvenio.Hint := 'O dígito será calculado na rotina de impressão de boletos';
         lblCedente.Caption := 'Número do Convênio (Sem Dígito):';
         intMaxDev := 120;
       End;
  End;

end;

procedure TfrmConfigCxFederal7D.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Seq. remessa      :' + fGetBancoConfig(0, 'CONFIG1047D', 'PROXNUM', ''));
  stlCampos.Add('Sist. de cobrança :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SISCOB', ''));
  stlCampos.Add('Número convênio   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', ''));
  stlCampos.Add('Cód. carteira     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', ''));
  stlCampos.Add('Cód. da agência   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Díg. da agência   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', ''));
  stlCampos.Add('Díg. Verificador  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGVERI', ''));
  stlCampos.Add('Cód. da C/C       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  stlCampos.Add('Díg. da C/C       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', ''));
  stlCampos.Add('Observação 1      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Observação 3      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  stlCampos.Add('Observação 4      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  stlCampos.Add('Observação 5      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  stlCampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  stlCampos.Add('Arquivo remessa   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo retorno   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  stlCampos.Add('Responsável Bol.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', ''));
  stlCampos.Add('Distribuição      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DISTRI', ''));
  stlCampos.Add('Protocolo aceite  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', ''));
  stlCampos.Add('Portador de baixa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Portador da remessa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', ''));
  stlCampos.Add('Conta de baixa    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Percentual multa  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', ''));
  stlCampos.Add('Nosso número      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMNOSS', ''));
  stlCampos.Add('Info Adicional    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', ''));
  stlCampos.Add('Tipo dias (U/C)   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TIPDIA', ''));
  stlCampos.Add('Versão do arquivo :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'VERARQ', ''));
  stlCampos.Add('Versão do lote    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'VERLOT', ''));
  stlCampos.Add('Baixa / devolucao :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'BAIXDEV', ''));
  stlCampos.Add('Dias p/ baixa/dev :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIASDEV', ''));
  stlCampos.Add('Dias p/ protesto  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  stlCampos.Add('Ident. tipo pag.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'IDENTPAG', ''));
end;

procedure TfrmConfigCxFederal7D.pGravaLogCarteira(stlCfgAnt : TStringList);
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
    pGravaLogAtb('104', 'CAIXA 240d7 POSIÇÕES', strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

end.
