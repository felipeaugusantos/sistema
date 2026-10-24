unit untConfigUnicred400_136;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Mask, DirectoryEditFocus, Buttons,
  ExtCtrls, QColorLabel, Menus, ComCtrls, ShellApi, AppEvnts, Uni, BitBtnLockedIncrem,
  untTypesSistema, frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, StrUtils,
  ComboBoxFocus, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus, untFramePlanoDeContasMaskEdit, dxScreenTip,
  cxClasses, dxCustomHint, cxHint, dxBarBuiltInMenu, cxPC;

type
  TfrmConfigUnicred400_136 = class(TfrmPai)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
    btnCancelar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    BtnManual: TBitBtnLocked;
    HintControler: TcxHintStyleController;
    cxPaginas: TcxPageControl;
    tbsGeral: TcxTabSheet;
    tbsComplemento: TcxTabSheet;
    pnlComplemento: TPanel;
    Label45: TLabel;
    edtCodPorRem: TEditFocus;
    edtDescPorRem: TEditFocus;
    pnlAtivo: TPanel;
    lblCodCart: TLabel;
    lblProNum: TLabel;
    lblIdentBanco: TLabel;
    lblCodAgenc: TLabel;
    lblContCorr: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    lblResp: TLabel;
    ColorLabel1: TColorLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    ColorLabel3: TColorLabel;
    Label13: TLabel;
    lbl1: TLabel;
    Label7: TLabel;
    Label15: TLabel;
    Label24: TLabel;
    Label16: TLabel;
    lblDesBen: TLabel;
    ColorLabel2: TColorLabel;
    lblObsAg: TLabel;
    edtResp: TEditFocus;
    edtProxNumArqRem: TEditFocus;
    edtIdentBanc: TEditFocus;
    edtParMov: TEditFocus;
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
    edtInfAdi: TEditFocus;
    edtDigAgencia: TEditFocus;
    edtDigCta: TEditFocus;
    edtNumContr: TEditFocus;
    edtSeqDia: TEditFocus;
    fraPathRemessa: TfraDirectoryEditFocus;
    fraPathRetorno: TfraDirectoryEditFocus;
    edtDiasProt: TEditFocus;
    cmbInstrucao1: TComboBoxFocus;
    cmbCodCar: TComboBoxFocus;
    edtPerMul: TEditFocus;
    edtDesBen: TEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    chkExportaObs1: TCheckBox;
    chkExportaObs2: TCheckBox;
    chkExportaObs3: TCheckBox;
    edtObsAg: TEditFocus;
    Label2: TLabel;
    edtDiasCred01: TEditFocus;
    procedure btnGravarClick(Sender: TObject);
    procedure pCarregaDados;
    procedure pValidaDados;
    procedure FormShow(Sender: TObject);
    procedure tabCarteiraChange(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure BtnManualClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure cmbInstrucao1Exit(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure chkExportaObs1Enter(Sender: TObject);
    procedure chkExportaObs2Enter(Sender: TObject);
    procedure chkExportaObs3Enter(Sender: TObject);
    procedure chkExportaObs1Exit(Sender: TObject);
    procedure edtCodPorRemKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;

    procedure pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
    function  fRetStrCfg(stlCfg : TStringList) : String;

    procedure ShowHint(AObjeto: TCheckBox; ATitulo: String);
    procedure HideHint;
  public
    { Public declarations }
    blnNaoEditar: Boolean;
    strConfig   : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigUnicred400_136: TfrmConfigUnicred400_136;

implementation

uses  untfuncoesSimples, untFuncoes,
     untPesqAux, untCfgGenericas_AutBan, untConsultas, untFuncoesGenerica;

{$R *.dfm}

procedure TfrmConfigUnicred400_136.btnEditarClick(Sender: TObject);
begin
  If ((Not fVerificaDireitoAutBan('PERCARBAN'))) Then
  begin
    If (strLoginUsuarioLogado <> '999') Then
    Begin
      fMensagem('ATENÇÃO','Usuário sem permissão!', ['&Ok ']);
      Exit;
    end;
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
      pSetFocus(cmbCodCar);

  end;

end;

procedure TfrmConfigUnicred400_136.btnGravarClick(Sender: TObject);
Var
  stlCfgAnt : TStringList;
begin
  inherited;

  If fVerificaCampos Then
  Begin
    Try
      stlCfgAnt := TStringList.Create;
      pCarregaCfg(stlCfgAnt);

      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', edtPerMul.Text);
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', edtProxNumArqRem.Text);
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', LeftStr(cmbCodCar.Text,2));
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCEDE', edtIdentBanc.Text    );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCEDE', edtDigCta.Text       );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text   );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', edtDigAgencia.Text   );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text         );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', LeftStr(cmbInstrucao1.Text,1));
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text  );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text  );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text  );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text  );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text  );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessa.edtDirectory.text  );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetorno.edtDirectory.text  );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text       );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text       );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContas.MskCodCta.Text       );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text     );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACR01', edtDiasCred01.Text   );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text       );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSIMPAG', edtObsAg.Text       );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text       );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PARMMOV', edtParMov.Text       );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCONT', edtNumContr.Text     );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQDIAR', edtSeqDia.Text       );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text     );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMBENE', edtDesBen.Text       );
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPOBS1', IIF(chkExportaObs1.Checked, 'S', 'N'));
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPOBS2', IIF(chkExportaObs2.Checked, 'S', 'N'));
      fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPOBS3', IIF(chkExportaObs3.Checked, 'S', 'N'));

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        pBackupCnfBco;
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        blnMudarFoco := True;
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

procedure TfrmConfigUnicred400_136.pCarregaDados;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************AF*}
  edtProxNumArqRem.Text := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '');

  If Not fEmptyStr(fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', '')) Of
      21: cmbCodCar.ItemIndex := 0;
    End;
  End
  Else
    cmbCodCar.ItemIndex := -1;

  edtIdentBanc.Text     := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCEDE', '');
  edtDigCta.Text        := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCEDE', '');
  edtCodAgencia.Text    := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtResp.Text          := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', '');

  If Not fEmptyStr(fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '')) Of
      1: cmbInstrucao1.ItemIndex := 0;
      2: cmbInstrucao1.ItemIndex := 1;
      3: cmbInstrucao1.ItemIndex := 2;
    End;
  End
  Else
    cmbInstrucao1.ItemIndex := -1;

  edtPerMul.Text    := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', '');
  edtDigAgencia.Text    := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', '');
  edtObservacao1.Text   := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text   := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text   := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text   := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text   := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');
  fraPathRemessa.edtDirectory.text   := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '');
  fraPathRetorno.edtDirectory.text   := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '');
  edtCodPor.Text        := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  edtCodPorRem.Text      := fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');
  fraPlanoDeContas.MskCodCta.Text        := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');
  edtDiasCred.Text      := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', '');
  edtDiasCred01.Text    := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACR01', '');
  edtProAce.Text        := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', '');
  edtObsAG.Text         := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSIMPAG', 'N');
  edtInfAdi.Text        := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', '');
  edtParMov.Text        := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PARMMOV', '');
  edtNumContr.Text      := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCONT', '');
  edtDiasProt.Text      := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '');
  edtDesBen.Text        := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMBENE', '');
  chkExportaObs1.Checked := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPOBS1', '') = 'S';
  chkExportaObs2.Checked := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPOBS2', '') = 'S';
  chkExportaObs3.Checked := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPOBS3', '') = 'S';
  pValidaDados;
end;

procedure TfrmConfigUnicred400_136.FormShow(Sender: TObject);
begin
  inherited;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  pCarregaDados;
  pSetFocus(edtProxNumArqRem);

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

procedure TfrmConfigUnicred400_136.fraPlanoDeContasMskCodCtaKeyPress(
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

function TfrmConfigUnicred400_136.fRetStrCfg(stlCfg: TStringList): String;
Var
  intCont : Integer;
begin
  Result := '';

  For intCont := 0 To stlCfg.Count - 1 Do
    Result := Result + stlCfg.Strings[intCont] + #13+#10;
end;

function TfrmConfigUnicred400_136.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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

    Else If (Sender = edtPerMul) Then
    Begin
      If Not fValidaEscala(edtPerMul.Text, 0, 100) Then
      begin
        fMensagem('ATENÇÃO','O campo percentual de multa deve estar entre 0 e 100!'+strMensagemConfig,['&OK']);
        Result := False;
      end;
    End

    Else If (Sender = cmbInstrucao1) Then
    Begin

      If cmbInstrucao1.ItemIndex = -1 Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else
      If cmbInstrucao1.ItemIndex = 2 Then
        edtDiasProt.Text := '00';

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
      If Pos(edtProAce.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Imprime Protocolo de Aceite deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtObsAg Then
    Begin
      If Pos(edtObsAg.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Boleto "AG" Priorizar Impressão das Observações deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = fraPathRemessa Then
    Begin

      If fEmptyStr(fraPathRemessa.edtDirectory.text) Then
      Begin
        fMensagem('','Preencha o campo Path de remessa!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = fraPathRetorno Then
    Begin

      If fEmptyStr(fraPathRetorno.edtDirectory.text) Then
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
        fMensagem('ATENÇÃO!', 'O portador deve ser preenchido!'+strMensagemConfig,['&O K']);
        edtDesPor.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaPortador(edtCodPor.Text, edtDesPor);
        If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!'+strMensagemConfig,['&O K']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este operador!'+strMensagemConfig,['&O K']);
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
        fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser informado!'+strMensagemConfig,['&O K']);
        fraPlanoDeContas.edtDesCta.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);
        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!'+strMensagemConfig,['&O K']);
          Result := False;
        End
        Else
          Result := PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text,True);
      End;

    End

    Else If (Sender = edtNumContr) Then
    Begin
      If fEmptyStr(edtNumContr.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Número do contrato deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodAgencia) Then
    Begin
      If fEmptyStr(edtCodAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Código da Agência deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigAgencia) Then
    Begin
      If fEmptyStr(edtDigAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Dígito da Agência deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtIdentBanc) Then
    Begin
      If fEmptyStr(edtIdentBanc.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Conta Corrente deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigCta) Then
    Begin
      If fEmptyStr(edtDigCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Dígito da Conta Corrente deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtParMov) Then
    Begin
      If fEmptyStr(edtParMov.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Parâmetro de Movimento deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = cmbCodCar)Then
    Begin
      If cmbCodCar.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Código da carteita deve ser informado!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = chkExportaObs1 Then
    Begin
      If chkExportaObs1.Checked Then
      Begin
        If fEmptyStr(edtObservacao1.text) Then
        Begin
          fMensagem('','O campo Observação 1 deve ser informado para que seja feita a exportação!'+strMensagemConfig,['&O K']);
          Result := False;
        End;
      End;
    End

    Else If Sender = chkExportaObs2 Then
    Begin
      If chkExportaObs2.Checked Then
      Begin
        If fEmptyStr(edtObservacao2.text) Then
        Begin
          fMensagem('','O campo Observação 2 deve ser informado para que seja feita a exportação!'+strMensagemConfig,['&O K']);
          Result := False;
        End;
      End;
    End

    Else If Sender = chkExportaObs3 Then
    Begin
      If chkExportaObs3.Checked Then
      Begin
        If fEmptyStr(edtObservacao3.text) Then
        Begin
          fMensagem('','O campo Observação 3 deve ser informado para que seja feita a exportação!'+strMensagemConfig,['&O K']);
          Result := False;
        End;
      End;
    End

    Else If Sender = chkExportaObs1 Then
    Begin
      If chkExportaObs1.Checked Then
      Begin
        If fEmptyStr(edtObservacao1.text) Then
        Begin
          fMensagem('','O campo Observação 1 deve ser informado para que seja feita a exportação!'+strMensagemConfig,['&O K']);
          Result := False;
        End;
      End;
    End

    Else If Sender = chkExportaObs2 Then
    Begin
      If chkExportaObs2.Checked Then
      Begin
        If fEmptyStr(edtObservacao2.text) Then
        Begin
          fMensagem('','O campo Observação 2 deve ser informado para que seja feita a exportação!'+strMensagemConfig,['&O K']);
          Result := False;
        End;
      End;
    End

    Else If Sender = chkExportaObs3 Then
    Begin
      If chkExportaObs3.Checked Then
      Begin
        If fEmptyStr(edtObservacao3.text) Then
        Begin
          fMensagem('','O campo Observação 3 deve ser informado para que seja feita a exportação!'+strMensagemConfig,['&O K']);
          Result := False;
        End;
      End;
    End

  End;

  If Not Result Then
    if not blnNaoEditar then
      pSetFocus(Sender);

End;

procedure TfrmConfigUnicred400_136.HideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmConfigUnicred400_136.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmConfigUnicred400_136.tabCarteiraChanging(Sender: TObject;
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

procedure TfrmConfigUnicred400_136.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, nil, Key, arrSel) then
    Begin
      Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigUnicred400_136.edtCodPorRemKeyPress(Sender: TObject;
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

procedure TfrmConfigUnicred400_136.pCarregaCentroCusto(strCtaBai: String;
  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  fraPlanoDeContas.edtDesCta.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;
end;

procedure TfrmConfigUnicred400_136.pCarregaPortador(strCodPor: String;
  edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  edtLabel.Text := qryCadPor.FieldByName('POR_NOMPOR').AsString;
end;

procedure TfrmConfigUnicred400_136.FormCreate(Sender: TObject);
begin
  inherited;

  qryCadPor := fCriaQuery(Self);
  pCarKeyAutBan;
  cxPaginas.Properties.ActivePage := tbsGeral;
end;

procedure TfrmConfigUnicred400_136.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigUnicred400_136.btnCancelarClick(Sender: TObject);
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

procedure TfrmConfigUnicred400_136.btnConfigurarClick(Sender: TObject);
begin
  inherited;

  Try
    pCriarFormularios(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '136';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;


end;

procedure TfrmConfigUnicred400_136.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\136400p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\136400p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigUnicred400_136.chkExportaObs1Enter(Sender: TObject);
begin
  inherited;
  ShowHint(chkExportaObs1, '  Ao selecionar esse campo, o conteúdo do campo Observações 1' + #13 +
                           'será exportado no arquivo de remessa.');
end;

procedure TfrmConfigUnicred400_136.chkExportaObs1Exit(Sender: TObject);
begin
  inherited;
  HideHint;
end;

procedure TfrmConfigUnicred400_136.chkExportaObs2Enter(Sender: TObject);
begin
  inherited;
  ShowHint(chkExportaObs2, '  Ao selecionar esse campo, o conteúdo do campo Observações 2' + #13 +
                           'será exportado no arquivo de remessa.');
end;

procedure TfrmConfigUnicred400_136.chkExportaObs3Enter(Sender: TObject);
begin
  inherited;
  ShowHint(chkExportaObs3, '  Ao selecionar esse campo, o conteúdo do campo Observações 3' + #13 +
                           'será exportado no arquivo de remessa.');
end;

procedure TfrmConfigUnicred400_136.cmbInstrucao1Exit(Sender: TObject);
begin
  inherited;
  If cmbInstrucao1.ItemIndex = 2 Then
    edtDiasProt.Text := '00';
end;

procedure TfrmConfigUnicred400_136.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Seq. remessa      :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  stlCampos.Add('Num. contrato     :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCONT', ''));
  stlCampos.Add('Cód. agência      :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Díg. agência      :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', ''));
  stlCampos.Add('Cód. C/C          :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCEDE', ''));
  stlCampos.Add('Díg. C/C          :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCEDE', ''));
  stlCampos.Add('Parâm. movimento  :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PARMMOV', ''));
  stlCampos.Add('Cód. carteira     :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', ''));
  stlCampos.Add('Cód. instrução 1  :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', ''));
  stlCampos.Add('Cód. instrução 2  :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', ''));
  stlCampos.Add('Observação 1      :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2      :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Observação 3      :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  stlCampos.Add('Observação 4      :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  stlCampos.Add('Observação 5      :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  stlCampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  stlCampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACR01', ''));
  stlCampos.Add('Arquivo remessa   :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo retorno   :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  stlCampos.Add('Responsável Bol.  :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', ''));
  stlCampos.Add('Protocolo aceite  :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', ''));
  stlCampos.Add('Portador de baixa :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Portador da remessa :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', ''));
  stlCampos.Add('Conta de baixa    :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Inf. adicional    :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', ''));
  stlCampos.Add('Seq. diário       :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQDIAR', ''));
  stlCampos.Add('Índice carteira   :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'INDCART', ''));
  stlCampos.Add('Dias p/ protesto  :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  stlCampos.Add('Percentual Multa  :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', ''));
  stlCampos.Add('Beneficiario      :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMBENE', ''));
  stlCampos.Add('Boleto "AG" Priorizar Impressão das Observações?  :' + fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSIMPAG', ''));
end;

procedure TfrmConfigUnicred400_136.pGravaLogCarteira(stlCfgAnt : TStringList);
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
    pGravaLogAtb('136', 'BANCO UNICRED 400', 'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

procedure TfrmConfigUnicred400_136.pValidaDados;
begin
  If Not fEmptyStr(fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1),'SEQDIAR','')) Then
  Begin
    If Not fEmptyStr (fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1),'ULTREME', DateToStr(VS_Date))) and
           (StrToDate(fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1),'ULTREME', DateToStr(VS_Date))) = VS_Date) Then
      edtSeqDia.Text    := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(tabCarteira.TabIndex + 1),'SEQDIAR','')
    Else
      edtSeqDia.Text    := '01';
  End
  Else
    edtSeqDia.Text      := '01';

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCodPorRem.Text ) Then
    pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);

  If Not fEmptyStr( fraPlanoDeContas.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);

end;

procedure TfrmConfigUnicred400_136.ShowHint(AObjeto: TCheckBox;
  ATitulo: String);
begin
  HintControler.ShowHint(AObjeto.ClientOrigin.X,AObjeto.ClientOrigin.Y, ATitulo, AObjeto.Hint);
end;

end.
