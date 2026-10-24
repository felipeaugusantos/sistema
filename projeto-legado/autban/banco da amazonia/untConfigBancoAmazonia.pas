unit untConfigBancoAmazonia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Mask, DirectoryEditFocus, Buttons,
  ExtCtrls, QColorLabel, Menus, ComCtrls, ShellApi, AppEvnts, Uni, BitBtnLockedIncrem,
  untTypesSistema, frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, StrUtils, cxTextEdit, cxMaskEdit, cxButtonEdit,
  ComboBoxFocus, dxScreenTip, cxClasses, dxCustomHint, cxHint, 
  untFrameDirectoryEditFocus, untFramePlanoDeContasMaskEdit, dxBarBuiltInMenu,
  cxPC;

type
  TfrmConfigBancoAmazonia = class(TfrmPai)
    tabCarteira: TTabControl;
    pnlTopo: TPanel;
    btnCancelar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    BtnManual: TBitBtnLocked;
    BtnOcorrencia: TBitBtnLocked;
    HintControler: TcxHintStyleController;
    cxPaginas: TcxPageControl;
    tbsGeral: TcxTabSheet;
    tbsComplemento: TcxTabSheet;
    pnlComplemento: TPanel;
    Label45: TLabel;
    edtCodPorRem: TEditFocus;
    edtDescPorRem: TEditFocus;
    pnlAtivo: TPanel;
    lblProNum: TLabel;
    lblIdentBanco: TLabel;
    lblCodAgenc: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    Label1: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    ColorLabel3: TColorLabel;
    Label13: TLabel;
    lbl1: TLabel;
    Label15: TLabel;
    Label3: TLabel;
    ColorLabel1: TColorLabel;
    Label4: TLabel;
    ColorLabel2: TColorLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtProxNumArqRem: TEditFocus;
    edtCodIdeBan: TEditFocus;
    edtCodAgencia: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtDigAgencia: TEditFocus;
    edtDiasCred: TEditFocus;
    edtProAce: TEditFocus;
    edtInfAdi: TEditFocus;
    edtCtaCorr: TEditFocus;
    edtDigCta: TEditFocus;
    edtCobReg: TEditFocus;
    edtResp: TEditFocus;
    cmbInstrucao1: TComboBoxFocus;
    edtDiasProt: TEditFocus;
    fraPathRemessa: TfraDirectoryEditFocus;
    fraPathRetorno: TfraDirectoryEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    procedure btnGravarClick(Sender: TObject);
    procedure pCarregaDados;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tabCarteiraChange(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfigurarClick(Sender: TObject);
    procedure BtnManualClick(Sender: TObject);
    procedure cmbInstrucao1Change(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnOcorrenciaClick(Sender: TObject);
    procedure BtnOcorrenciaEnter(Sender: TObject);
    procedure BtnOcorrenciaExit(Sender: TObject);
    procedure BtnOcorrenciaMouseEnter(Sender: TObject);
    procedure BtnOcorrenciaMouseLeave(Sender: TObject);
    procedure ApplicationEventsDeactivate(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorRemKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;

    procedure pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
    procedure pAlteraHintBotao(btnBotao: TBitBtnLocked; strNovoHint: String);
    procedure pShowHintBotao(btnBotao: TBitBtnLocked; strTitulo: String);
    procedure pHideHint;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  public
    { Public declarations }
    blnNaoEditar: Boolean;
    strConfig   : String;
  end;

var
  frmConfigBancoAmazonia: TfrmConfigBancoAmazonia;

implementation

uses untPesqAux, untFuncoesSimples, untConsultas, untCfgGenericas_AutBan, untFuncoes, untMemo;

{$R *.dfm}

procedure TfrmConfigBancoAmazonia.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBancoAmazonia.btnCancelarClick(Sender: TObject);
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

procedure TfrmConfigBancoAmazonia.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '003';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigBancoAmazonia.btnEditarClick(Sender: TObject);
begin
  inherited;
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
      pSetFocus(edtCodIdeBan);

  end;
end;

procedure TfrmConfigBancoAmazonia.btnGravarClick(Sender: TObject);
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

      fGetBancoConfig(1, 'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', edtProxNumArqRem.Text);
      fGetBancoConfig(1, 'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', edtCodIdeBan.Text    );
      fGetBancoConfig(1, 'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text   );
      fGetBancoConfig(1, 'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', edtDigAgencia.Text   );
      fGetBancoConfig(1, 'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtCtaCorr.Text      );
      fGetBancoConfig(1, 'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', edtDigCta.Text       );
      fGetBancoConfig(1, 'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text  );
      fGetBancoConfig(1, 'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text  );
      fGetBancoConfig(1, 'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text  );
      fGetBancoConfig(1, 'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text  );
      fGetBancoConfig(1, 'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text     );
      fGetBancoConfig(1, 'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessa.edtDirectory.text  );
      fGetBancoConfig(1, 'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetorno.edtDirectory.text  );
      fGetBancoConfig(1, 'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text       );
      fGetBancoConfig(1, 'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text       );
      fGetBancoConfig(1, 'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text       );
      fGetBancoConfig(1, 'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContas.MskCodCta.Text   );
      fGetBancoConfig(1, 'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text       );
      fGetBancoConfig(1, 'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text         );
      fGetBancoConfig(1, 'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1), 'COBREG_', edtCobReg.Text       );
      fGetBancoConfig(1, 'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', LeftStr(cmbInstrucao1.Text,2));
      fGetBancoConfig(1, 'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text     );

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

procedure TfrmConfigBancoAmazonia.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\003.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\003.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigBancoAmazonia.BtnOcorrenciaClick(Sender: TObject);
 Var
    strDetalhe : String;
begin
  inherited;
  pHideHint;

  strDetalhe := #13#10 +
                '06 – Liquidação; ' + #13#10 +
                '15 – Franco de Pagamento; ' + #13#10 +
                '17 - Liquidação após baixa ou liquidação título não registrado. ' + #13#10 +
                'As demais ocorrências são gravadas na rotina ' +
                'de retorno e mostradas no relatório apenas em ' +
                'caráter informativo.'+ #13#10 +
                #13#10 +
                'Pressione Esc para voltar à tela de configurações.';

  TfrmMemo.pShowMessage('Banco 003 - Banco da Amazonia - S/A - Detalhamento de Ocorrências.' + #13#10 +
                        strDetalhe);
end;

procedure TfrmConfigBancoAmazonia.BtnOcorrenciaEnter(Sender: TObject);
begin
  inherited;
  pAlteraHintBotao(btnOcorrencia, 'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
                                  'que são tratados pelas rotinas do sistema.');
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigBancoAmazonia.BtnOcorrenciaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBancoAmazonia.BtnOcorrenciaMouseEnter(Sender: TObject);
begin
  inherited;
  pAlteraHintBotao(btnOcorrencia, 'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
                                  'que são tratados pelas rotinas do sistema.');
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigBancoAmazonia.BtnOcorrenciaMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBancoAmazonia.cmbInstrucao1Change(Sender: TObject);
begin
  inherited;
  If cmbInstrucao1.ItemIndex = 1 Then
  Begin
    edtDiasProt.Enabled := True;
    edtObservacao1.Clear;
  End
  Else
  Begin
    edtDiasProt.Enabled := False;
    edtDiasProt.Clear;

    If cmbInstrucao1.ItemIndex > 1 Then
      edtObservacao1.Text := Copy(cmbInstrucao1.Text, 6, Length(cmbInstrucao1.Text) - 1)
    Else
      edtObservacao1.Clear;
  End;
end;

procedure TfrmConfigBancoAmazonia.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrPortador: TConsultasArray;
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, Nil, Key, arrPortador) Then
    If fValidaCampos(edtCodPor) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfigBancoAmazonia.edtCodPorRemKeyPress(Sender: TObject;
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

procedure TfrmConfigBancoAmazonia.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  cxPaginas.Properties.ActivePage := tbsGeral;
  pCarKeyAutBan;
end;

procedure TfrmConfigBancoAmazonia.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigBancoAmazonia.FormShow(Sender: TObject);
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

procedure TfrmConfigBancoAmazonia.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
    if fValidaCampos(fraPlanoDeContas.MskCodCta) then
      SelectNext(ActiveControl, True, True);
end;

function TfrmConfigBancoAmazonia.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  strMensagemConfig: String;
begin

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

    Else If Sender = edtProAce Then
    Begin
      If Pos(edtProAce.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Imprime Protocolo de Aceite deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
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
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
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
        Else If Not PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text) Then
          Result := False;
      End;

    End

    Else If Sender = edtCtaCorr Then
    Begin
      If fEmptyStr(edtCtaCorr.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A conta corrente deve ser informada!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else If Length(edtCtaCorr.Text) <> edtCtaCorr.MaxLength Then
      Begin
        fMensagem('ATENÇÃO!', 'A conta corrente deve ter 6 caracteres!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtCodAgencia Then
    Begin
      If fEmptyStr(edtCodAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A agência deve ser informada!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else If Length(edtCodAgencia.Text) <> edtCodAgencia.Maxlength Then
      Begin
        fMensagem('ATENÇÃO!', 'A agência deve ter 3 caracteres!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtDigAgencia Then
    Begin
      If fEmptyStr(edtDigAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O dígito da agência deve ser informado!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtCodIdeBan Then
    Begin
      If fEmptyStr(edtCodIdeBan.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do convênio no banco deve ser informado!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else If Length(edtCodIdeBan.Text) <> edtCodIdeBan.MaxLength Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do convênio no banco deve ter 4 caracteres!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtDigCta Then
    Begin
      If fEmptyStr(edtDigCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O dígito da conta corrente deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtCobReg Then
    Begin
      If Pos(edtCobReg.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Cobrança Registrada deve ser S ou N!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else
      Begin
        If edtCobReg.Text = 'S' Then
          edtResp.Text:= 'B'
        Else
          edtResp.Text:= 'E';
      End;
    End

    Else If Sender = cmbInstrucao1 Then
    Begin
      If cmbInstrucao1.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Instrução 1 deve ser informado!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else If cmbInstrucao1.ItemIndex > 1 Then
      Begin
        edtObservacao1.Text := Copy(cmbInstrucao1.Text, 6, Length(cmbInstrucao1.Text) - 1);
        edtDiasProt.Clear;
        edtDiasProt.Enabled := False;
      End
      Else
      Begin
        If cmbInstrucao1.ItemIndex = 1 Then
          edtDiasProt.Enabled := True
        Else
        Begin
          edtDiasProt.Clear;
          edtDiasProt.Enabled := False;
        End;
      End;
    End

    Else If (Sender = edtDiasProt) And
            (edtDiasProt.Enabled)  Then
    Begin
      If cmbInstrucao1.ItemIndex = 1 Then
      Begin
        If (fEmptyStr(edtDiasProt.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo Quantidade de dias para protesto deve ser preenchido!'+strMensagemConfig,['&O K']);
          Result := False;
        End
        Else If StrToInt(edtDiasProt.Text) < 5 Then
        Begin
          fMensagem('ATENÇÃO!', 'A quantidade mínima de dias para protesto é 5 dias!'+strMensagemConfig,['&O K']);
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
    if not blnNaoEditar then
      pSetFocus(Sender);

end;

procedure TfrmConfigBancoAmazonia.pAlteraHintBotao(btnBotao: TBitBtnLocked;
  strNovoHint: String);
begin
  btnBotao.Hint := strNovoHint;
end;

procedure TfrmConfigBancoAmazonia.pCarregaCentroCusto(strCtaBai: String;
  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmConfigBancoAmazonia.pCarregaDados;
begin
  edtProxNumArqRem.Text:= fGetBancoConfig(0,'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1),'PROXNUM','');
  edtCodIdeBan.Text    := fGetBancoConfig(0,'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1),'CODCONV','');
  edtCodAgencia.Text   := fGetBancoConfig(0,'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1),'CODAGEN','');
  edtDigAgencia.Text   := fGetBancoConfig(0,'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1),'DIGAGEN','');
  edtCtaCorr.Text      := fGetBancoConfig(0,'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1),'NUMCTAC','');
  edtDigCta.Text       := fGetBancoConfig(0,'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1),'DIGCTAC','');
  edtObservacao1.Text  := fGetBancoConfig(0,'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1),'OBSERV1','');
  edtObservacao2.Text  := fGetBancoConfig(0,'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1),'OBSERV2','');
  edtObservacao3.Text  := fGetBancoConfig(0,'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1),'OBSERV3','');
  edtObservacao4.Text  := fGetBancoConfig(0,'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1),'OBSERV4','');
  edtDiasCred.Text     := fGetBancoConfig(0,'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1),'DIACRED','');
  fraPathRemessa.edtDirectory.text  := fGetBancoConfig(0,'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1),'PATHREM','');
  fraPathRetorno.edtDirectory.text  := fGetBancoConfig(0,'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1),'PATHRET','');
  edtProAce.Text       := fGetBancoConfig(0,'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1),'PROACEI','');
  edtCodPor.Text       := fGetBancoConfig(0,'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1),'PORBAI_','');
  edtCodPorRem.Text      := fGetBancoConfig(0, 'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');
  fraPlanoDeContas.MskCodCta.Text := fGetBancoConfig(0,'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1),'CTABAI_','');
  edtInfAdi.Text       := fGetBancoConfig(0,'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1),'INFADIC','');
  edtResp.Text         := fGetBancoConfig(0,'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1),'RESPONS','');
  edtCobReg.Text       := fGetBancoConfig(0,'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1),'COBREG_','');
  edtDiasProt.Text     := fGetBancoConfig(0,'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1),'DIAPROT','');

  If Not fEmptyStr(fGetBancoConfig(0,'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU1','')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0,'CONFIG003-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU1','')) Of
      00 : cmbInstrucao1.ItemIndex := 0;
      06 : cmbInstrucao1.ItemIndex := 1;
      08 : cmbInstrucao1.ItemIndex := 2;
      09 : cmbInstrucao1.ItemIndex := 3;
      10 : cmbInstrucao1.ItemIndex := 4;
      11 : cmbInstrucao1.ItemIndex := 5;
      12 : cmbInstrucao1.ItemIndex := 6;
      13 : cmbInstrucao1.ItemIndex := 7;
      14 : cmbInstrucao1.ItemIndex := 8;
      15 : cmbInstrucao1.ItemIndex := 9;
    End;
  End
  Else
    cmbInstrucao1.ItemIndex := -1;

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

   If Not fEmptyStr( edtCodPorRem.Text ) Then
    pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);

  If Not fEmptyStr( fraPlanoDeContas.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);

end;

procedure TfrmConfigBancoAmazonia.pCarregaPortador(strCodPor: String;
  edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtLabel.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmConfigBancoAmazonia.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmConfigBancoAmazonia.tabCarteiraChanging(Sender: TObject;
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

procedure TfrmConfigBancoAmazonia.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Seq. Remessa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  stlCampos.Add('Cód. Conv. Banco  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', ''));
  stlCampos.Add('Código Agência    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Dígito Agência    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', ''));
  stlCampos.Add('Num. C. Corrente  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  stlCampos.Add('Díg. C. Corrente  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', ''));
  stlCampos.Add('Instrução 1       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', ''));
  stlCampos.Add('Observação 1      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Observação 3      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  stlCampos.Add('Observação 4      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  stlCampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  stlCampos.Add('Arquivo Remessa   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo Retorno   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  stlCampos.Add('Protocolo Aceite  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', ''));
  stlCampos.Add('Portador de baixa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Portador da remessa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', ''));
  stlCampos.Add('Conta de baixa    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Info Adicional    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', ''));
  stlCampos.Add('Resp. Emissão Bol :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', ''));
  stlCampos.Add('Cobr. Registrada  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'COBREG_', ''));
  stlCampos.Add('Dias p/ Protesto  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
end;

procedure TfrmConfigBancoAmazonia.pGravaLogCarteira(stlCfgAnt : TStringList);
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
    pGravaLogAtb('003', 'BANCO DA AMAZONIA', strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

procedure TfrmConfigBancoAmazonia.pHideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmConfigBancoAmazonia.pShowHintBotao(btnBotao: TBitBtnLocked;
  strTitulo: String);
begin
  HintControler.ShowHint(btnBotao.ClientOrigin.X,btnBotao.ClientOrigin.Y, strTitulo, btnBotao.Hint);
end;

end.
