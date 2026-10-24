unit untConfigBradesco240Vendor;

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
  TfrmConfigBradesco240Vendor = class(TfrmPai)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
    HintControler: TcxHintStyleController;
    btnCancelar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    BtnOcorrencia: TBitBtnLocked;
    cxPaginas: TcxPageControl;
    tbsGeral: TcxTabSheet;
    tbsComplemento: TcxTabSheet;
    pnlComplemento: TPanel;
    Label32: TLabel;
    edtCodPorRem: TEditFocus;
    edtDescPorRem: TEditFocus;
    pnlAtivo: TPanel;
    lblCedente: TLabel;
    lblCodAgenc: TLabel;
    lblContCorr: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    lblProNum: TLabel;
    lblCodPor: TLabel;
    Label23: TLabel;
    Label25: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label16: TLabel;
    edtDigCtaCor: TEditFocus;
    edtProxNumArqRem: TEditFocus;
    edtNumConvenio: TEditFocus;
    edtDigAgencia: TEditFocus;
    edtContaCorr: TEditFocus;
    edtCodAgencia: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    fraPathRemessa: TfraDirectoryEditFocus;
    fraPathRetorno: TfraDirectoryEditFocus;
    edtCodOpe: TEditFocus;
    edtTaxaVendedor: TEditFocus;
    edtTaxaComprador: TEditFocus;
    cmbFormaPagamento: TComboBoxFocus;
    cmbFormaIOF: TComboBoxFocus;
    cmbCodProt: TComboBoxFocus;
    edtDiasProt: TEditFocus;
    edtPerVenc: TEditFocus;
    edtPrazoTrans: TEditFocus;
    edtValMult: TEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    procedure pCarregaDados;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure tabCarteiraChange(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnConfigurarEnter(Sender: TObject);
    procedure btnConfigurarExit(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtTaxaVendedorExit(Sender: TObject);
    procedure edtTaxaCompradorExit(Sender: TObject);
    procedure edtValMultExit(Sender: TObject);
    procedure BtnOcorrenciaClick(Sender: TObject);
    procedure BtnOcorrenciaEnter(Sender: TObject);
    procedure BtnOcorrenciaExit(Sender: TObject);
    procedure ApplicationEventsDeactivate(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorRemKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;

    procedure pCarregaCentroCusto(strCtaBai: String; edtLabel: TEdit);
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    //procedure pShowHint(edtEdit: TEditFocus; strTitulo: String);
    procedure pHideHint;
    procedure pShowHintBotao(btnBotao: TBitBtnLocked; strTitulo: String);
    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
  public
    { Public declarations }
    blnNaoEditar : Boolean;
    strConfig    : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigBradesco240Vendor: TfrmConfigBradesco240Vendor;

implementation

uses untfuncoesSimples, untFuncoes,
     untPesqAux, untCfgGenericas_AutBan,  untConsultas, untMemo;

{$R *.dfm}

procedure TfrmConfigBradesco240Vendor.pCarregaDados;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************AF*}
  If fEmptyStr(fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '')) Then
  Begin
    edtProxNumArqRem.Enabled := True;
    edtProxNumArqRem.Clear;
    pSetFocus(edtProxNumArqRem);
  End
  Else
  Begin
    edtProxNumArqRem.Text := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '');
    edtProxNumArqRem.Enabled := False;
    pSetFocus(edtNumConvenio);
  End;

  if (strLoginUsuarioLogado='997') or(strLoginUsuarioLogado='998') or (strLoginUsuarioLogado='999') Then
  begin
    edtProxNumArqRem.Enabled := True;
    pSetFocus(edtProxNumArqRem);
  End;

  edtNumConvenio.Text   := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', '');
  edtCodOpe.Text        := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'CODOPER', '');
  edtCodAgencia.Text    := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtDigAgencia.Text    := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', '');
  edtContaCorr.Text     := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', '');
  edtDigCtaCor.Text     := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', '');
  edtTaxaVendedor.Text  := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'TAXAVEN', '');
  edtTaxaComprador.Text := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'TAXACOM', '');
  edtValMult.Text       := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'VALMULT', '');

  cmbFormaIOF.ItemIndex       := cmbFormaIOF.Items.IndexOf(fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'FORMIOF', ''));
  cmbCodProt.ItemIndex        := cmbCodProt.Items.IndexOf(fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'CODPROT', ''));

  fraPathRemessa.edtDirectory.text   := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '');
  edtPrazoTrans.Text    := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'PRAZTRA', '');
  fraPathRetorno.edtDirectory.text   := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '');
  edtCodPor.Text        := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  edtCodPorRem.Text      := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');
  edtDescPorRem.Text := '';
  edtDesPor.Text        := '';
  fraPlanoDeContas.MskCodCta.Text        := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');
  fraPlanoDeContas.edtDesCta.Text     := '';
  edtDiasProt.Text      := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '');
  edtPerVenc.Text       := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'PERVENC', '');

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCodPorRem.Text ) Then
    pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);

  If Not fEmptyStr( fraPlanoDeContas.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);
end;

procedure TfrmConfigBradesco240Vendor.FormShow(Sender: TObject);
begin
  inherited;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);

  pCarregaDados;

  If edtProxNumArqRem.Enabled Then
    pSetFocus(edtProxNumArqRem)
  Else
    pSetFocus(edtNumConvenio);

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

procedure TfrmConfigBradesco240Vendor.btnConfigurarEnter(Sender: TObject);
begin
  inherited;
  btnConfigurar.Hint := 'Configurar percentual de ' + #13+#10 +
                        'juros para remessa.';
  pShowHintBotao(btnConfigurar, 'Cofigurações específicas.');
end;

procedure TfrmConfigBradesco240Vendor.btnConfigurarExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBradesco240Vendor.btnEditarClick(Sender: TObject);
begin
  If ((Not fVerificaDireitoAutBan('PERCARBAN')) and (strLoginUsuarioLogado <> '999')) Then
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
      pSetFocus(edtNumConvenio);

  end;
end;

procedure TfrmConfigBradesco240Vendor.btnGravarClick(Sender: TObject);
Var
  stlCfgAnt : TStringList;
begin
  inherited;

  If fVerificaCampos Then
  Begin
    Try
      If blnNaoEditar Then
      Begin
        Close;
        ModalResult := mrOk;
        Exit;
      End;

      stlCfgAnt := TStringList.Create;
      pCarregaCfg(stlCfgAnt);

      fGetBancoConfig(1, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', edtProxNumArqRem.Text );
      fGetBancoConfig(1, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', edtNumConvenio.Text   );
      fGetBancoConfig(1, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'CODOPER', edtCodOpe.Text        );
      fGetBancoConfig(1, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text    );
      fGetBancoConfig(1, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'VALMULT', edtValMult.Text    );
      fGetBancoConfig(1, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', edtDigAgencia.Text    );
      fGetBancoConfig(1, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text     );
      fGetBancoConfig(1, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', edtDigCtaCor.Text     );
      fGetBancoConfig(1, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'TAXAVEN', edtTaxaVendedor.Text  );
      fGetBancoConfig(1, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'TAXACOM', edtTaxaComprador.Text );
      fGetBancoConfig(1, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'FORMPAG', cmbFormaPagamento.Text);
      fGetBancoConfig(1, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'FORMIOF', cmbFormaIOF.Text      );
      fGetBancoConfig(1, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'CODPROT', cmbCodProt.Text       );
      fGetBancoConfig(1, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text      );
      fGetBancoConfig(1, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'PERVENC', edtPerVenc.Text       );
      fGetBancoConfig(1, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessa.edtDirectory.text   );
      fGetBancoConfig(1, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetorno.edtDirectory.text   );
      fGetBancoConfig(1, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text        );
      fGetBancoConfig(1, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text       );
      fGetBancoConfig(1, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContas.MskCodCta.Text        );
      fGetBancoConfig(1, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'PRAZTRA', edtPrazoTrans.Text    );
      fGetBancoConfig(1, 'CONFIG237_VENDOR-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', 'B'    );
      If Not (btnGravar.Caption = '&OK') Then
      Begin
        pBackupCnfBco;
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        edtProxNumArqRem.Enabled := False;
        pSetFocus(edtNumConvenio);
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

procedure TfrmConfigBradesco240Vendor.BtnOcorrenciaClick(Sender: TObject);
  Var
    strDetalhe : String;
begin
  inherited;
  pHideHint;

  strDetalhe := #13#10 +
                '06, 15, 17 - Baixa duplicata; ' + #13#10 +
                '02 - Atualiza nosso número caso não tenha gravado; ' + #13#10 +
                '23 - Lança histórico de protesto; ' + #13#10 +
                '15 - Franco de Pagamento. '+ #13#10 +
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


  TfrmMemo.pShowMessage('Banco 237 - Bradesco - Detalhamento de Ocorrências (posições 109 - 110 arquivo retorno).' + #13#10 +
                        strDetalhe);
end;

procedure TfrmConfigBradesco240Vendor.BtnOcorrenciaEnter(Sender: TObject);
begin
  inherited;
  btnOcorrencia.Hint := 'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
                        'que são tratados pelas rotinas do sistema.';
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigBradesco240Vendor.BtnOcorrenciaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBradesco240Vendor.fraPlanoDeContasMskCodCtaKeyPress(
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

function TfrmConfigBradesco240Vendor.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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

    Else If Sender = fraPathRemessa Then
    Begin

      If fEmptyStr(fraPathRemessa.edtDirectory.text) Then
      Begin
        fMensagem('','Preencha o campo Path de Remessa'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If Sender = fraPathRetorno Then
    Begin

      If fEmptyStr(fraPathRetorno.edtDirectory.text) Then
      Begin
        fMensagem('','Preencha o campo Path de Retorno'+strMensagemConfig,['&O K']);
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

    Else If Sender = edtNumConvenio Then
    Begin
      If fEmptyStr(edtNumConvenio.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo Número do convênio deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;

    End

    Else If Sender = edtValMult Then
    Begin
      If fEmptyStr(edtValMult.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo Valor da Multa deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;

    End

    Else If Sender = edtCodOpe Then
    Begin
      If fEmptyStr(edtCodOpe.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo Código do Programa Operacional deve ser preenchido!'+strMensagemConfig, ['&Ok']);
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

    Else If (Sender = edtCodAgencia) Then
    Begin
      If fEmptyStr(edtCodAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Código da Agência deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End
    End

    Else If (Sender = edtContaCorr) Then
    Begin
      If fEmptyStr(edtContaCorr.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Número da Conta Corrente deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtPrazoTrans) Then
    Begin
      If fEmptyStr(edtPrazoTrans.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Prazo para Débito e Transferência deve ser preenchido!'+strMensagemConfig,['&OK']);
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

    Else If (Sender = edtDiasProt) Then
    Begin
      If fEmptyStr(edtDiasProt.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Dias para protesto deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result:= False;
      End
    End

    Else If (Sender = cmbCodProt) Then
    Begin
      If fEmptyStr(edtDiasProt.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo código para protesto deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result:= False;
      End
    End

    Else If (Sender = edtTaxaComprador) Then
    Begin
      If fEmptyStr(edtTaxaComprador.Text) Then
      Begin
        fMensagem('ATENÇÃO!','A taxa do comprador deve ser preenchida!'+strMensagemConfig,['&OK']);
        Result:= False;
      End
    End

    Else If (Sender = cmbFormaPagamento) Then
    Begin
      If fEmptyStr(cmbFormaPagamento.Text) Then
      Begin
        fMensagem('ATENÇÃO!','A forma de pagamento deve ser preenchida!'+strMensagemConfig,['&OK']);
        Result:= False;
      End
    End

    Else If (Sender = cmbFormaIOF) Then
    Begin
      If fEmptyStr(cmbFormaIOF.Text) Then
      Begin
        fMensagem('ATENÇÃO!','A forma de pagamento do IOF deve ser preenchida!'+strMensagemConfig,['&OK']);
        Result:= False;
      End
    End

    Else If (Sender = edtPerVenc) Then
    Begin
      If fEmptyStr(edtPerVenc.Text) Then
      Begin
        fMensagem('ATENÇÃO!','A periodicidade do vencimento deve ser preenchida!'+strMensagemConfig,['&OK']);
        Result:= False;
      End
      Else If StrToInt(edtPerVenc.Text) < 15 Then
      Begin
        fMensagem('ATENÇÃO!','A periodicidade de vencimento não deve ser menor que 15 dias!'+strMensagemConfig,['&OK']);
        Result:= False;
      End
      Else If StrToInt(edtPerVenc.Text) > 60 Then
      Begin
        fMensagem('ATENÇÃO!','A periodicidade de vencimento não deve ser maior que 60 dias!'+strMensagemConfig,['&OK']);
        Result:= False;
      End
    End

    Else If (Sender = edtTaxaVendedor) Then
    Begin
      If fEmptyStr(edtTaxaVendedor.Text) Then
      Begin
        fMensagem('ATENÇÃO!','A taxa do vendedor deve ser preenchida!'+strMensagemConfig,['&OK']);
        Result:= False;
      End
    End;

  End;

  If Not Result Then
    if not blnNaoEditar then
      pSetFocus(Sender);

End;

procedure TfrmConfigBradesco240Vendor.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  If edtNumConvenio.Focused Then
    Self.SelectNext(ActiveControl, True, True);

  pCarregaDados;
end;

procedure TfrmConfigBradesco240Vendor.tabCarteiraChanging(Sender: TObject;
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

procedure TfrmConfigBradesco240Vendor.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmConfigBradesco240Vendor.edtCodPorRemKeyPress(Sender: TObject;
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

procedure TfrmConfigBradesco240Vendor.edtTaxaCompradorExit(Sender: TObject);
begin
  inherited;
  if edtTaxaComprador.Text <> '' then
    edtTaxaComprador.Text := FormatFloat('#0.00000', fStrToFloat(edtTaxaComprador.Text));
end;

procedure TfrmConfigBradesco240Vendor.edtTaxaVendedorExit(Sender: TObject);
begin
  inherited;
  if edtTaxaVendedor.Text <> '' then
    edtTaxaVendedor.Text := FormatFloat('#0.00000', fStrToFloat(edtTaxaVendedor.Text));
end;

procedure TfrmConfigBradesco240Vendor.edtValMultExit(Sender: TObject);
begin
  inherited;
  if edtValMult.Text <> '' then
    edtValMult.Text := FormatFloat('##0.00', fStrToFloat(edtValMult.Text));
end;

procedure TfrmConfigBradesco240Vendor.pCarregaCentroCusto(strCtaBai: String; edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmConfigBradesco240Vendor.pCarregaPortador(strCodPor: String; edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtLabel.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmConfigBradesco240Vendor.pHideHint;
begin
  HintControler.HideHint;
end;

{procedure TfrmConfigBradesco240Vendor.pShowHint(edtEdit: TEditFocus; strTitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,edtEdit.ClientOrigin.Y, strTitulo, edtEdit.Hint);
end;}

procedure TfrmConfigBradesco240Vendor.pShowHintBotao(btnBotao: TBitBtnLocked;
  strTitulo: String);
begin
  HintControler.ShowHint(btnBotao.ClientOrigin.X,btnBotao.ClientOrigin.Y, strTitulo, btnBotao.Hint);
end;


procedure TfrmConfigBradesco240Vendor.FormActivate(Sender: TObject);
begin
  inherited;
  If edtProxNumArqRem.Enabled Then
    pSetFocus(edtProxNumArqRem)
  Else
    pSetFocus(edtNumConvenio);
end;

procedure TfrmConfigBradesco240Vendor.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  pCarKeyAutBan;
  cxPaginas.Properties.ActivePage := tbsGeral;
end;

procedure TfrmConfigBradesco240Vendor.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigBradesco240Vendor.ApplicationEventsDeactivate(
  Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBradesco240Vendor.btnCancelarClick(Sender: TObject);
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

procedure TfrmConfigBradesco240Vendor.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pHideHint;

    pCriarFormularios(TfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '237';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigBradesco240Vendor.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Seq. Remessa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  stlCampos.Add('Código Prog Oper  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODOPER', ''));
  stlCampos.Add('Número Convênio   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', ''));
  stlCampos.Add('Prazo Deb/Transf. :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PRAZTRA', ''));
  stlCampos.Add('Código Agência    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Dígito Agência    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', ''));
  stlCampos.Add('Num. C. Corrente  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  stlCampos.Add('Dig. C. Corrente  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', ''));
  stlCampos.Add('Taxa Vendedor     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TAXAVEN', ''));
  stlCampos.Add('Taxa Comprador    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TAXACOM', ''));
  stlCampos.Add('Forma Pagto IOF   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'FORMIOF', ''));
  stlCampos.Add('Valor da Multa    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'VALMULT', ''));
  stlCampos.Add('Forma Pagamento   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'FORMPAG', ''));
  stlCampos.Add('Código Protesto   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODPROT', ''));
  stlCampos.Add('Dias Protesto     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  stlCampos.Add('Period. Vencimento:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERVENC', ''));
  stlCampos.Add('Arquivo Remessa   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo Retorno   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  stlCampos.Add('Portador de Baixa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Portador da remessa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', ''));
  stlCampos.Add('Conta Baixa       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
end;

procedure TfrmConfigBradesco240Vendor.pGravaLogCarteira(stlCfgAnt : TStringList);
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
    pGravaLogAtb('237', 'BRADESCO 240P VENDOR', strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

end.
