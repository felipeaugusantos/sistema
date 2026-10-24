unit untConfigCtaDDA;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Vcl.Mask,
  DirectoryEditFocus, Vcl.ComCtrls, Uni, untTypesSistema, StrUtils,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus, untFrameCentroCustoEditFocus,
  untFramePlanoDeContasMaskEdit, untDDAAPIAutenticacaoFrame,
  QColorLabel, cxPC, untFuncoesSimples, System.DateUtils;

type
  TfrmConfigCtaDDA = class(TfrmPai)
    pnlTopo: TPanel;
    tabContas: TTabControl;
    btnCancelar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    cxPaginas: TcxPageControl;
    tbsGeral: TcxTabSheet;
    tbsDadosAutenticacao: TcxTabSheet;
    pnlAtivo2: TPanel;
    pnlAtivo: TPanel;
    Label6: TLabel;
    lblCodAgenc: TLabel;
    lblContCorr: TLabel;
    lblPathArquivosRet: TLabel;
    Label1: TLabel;
    edtDigCtaCor: TEditFocus;
    edtContaCorr: TEditFocus;
    edtCodAgencia: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    fraPathRetorno: TfraDirectoryEditFocus;
    fraCentroCusto: TfraCentroCustoEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    pnlFiltraEmpresaLogada: TPanel;
    lbInfExibirApenasDuplicatas: TLabel;
    ColorLabel3: TColorLabel;
    edtEmpLog: TEditFocus;
    fraDDAAPIAutenticacaoFrame: TfraDDAAPIAutenticacaoFrame;
    procedure btnGravarClick(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure tabContasChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure tabContasChanging(Sender: TObject; var AllowChange: Boolean);
    procedure fraCentroCustoedtCodEveKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure fraDDAAPIAutenticacaoFramebtnGerarChaveBasicClick(
      Sender: TObject);
    private
    { Private declarations }
    FstrConfig: String;
    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;
    FBancoAPI: Boolean;
    FCarteira: String;

    procedure pCarregaDados;
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
    procedure pCarregaEvento();
    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
    procedure CarregaDadosAutorizacao;
    procedure GravaDadosDeAutenticacao;
  public
    { Public declarations }
    blnNaoEditar: Boolean;
    strCodBco   : String;
    property strConfig: String read FstrConfig write FstrConfig; //Carrega a configuração do Banco da CNFBCO
    property BancoAPI: Boolean read FBancoAPI write FBancoAPI;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigCtaDDA: TfrmConfigCtaDDA;

implementation
Uses untConsultas, untPesqAux, untFuncoes;
{$R *.dfm}

procedure TfrmConfigCtaDDA.fraCentroCustoedtCodEveKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  fraCentroCusto.edtCodEveKeyPress(Sender, Key);

end;

procedure TfrmConfigCtaDDA.fraDDAAPIAutenticacaoFramebtnGerarChaveBasicClick(
  Sender: TObject);
begin
  inherited;
  fraDDAAPIAutenticacaoFrame.btnGerarChaveBasicClick(Sender);
end;

procedure TfrmConfigCtaDDA.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
    if fValidaCampos(fraPlanoDeContas.MskCodCta) then
      SelectNext(ActiveControl, True, True);
end;

function TfrmConfigCtaDDA.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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

    If Sender = fraPathRetorno Then
    Begin
      if FBancoAPI = False then
      begin
        if fEmptyStr(fraPathRetorno.edtDirectory.text) then
        begin
          fMensagem(EmptyStr,'Preencha o campo Pasta para Arquivos de Retorno'+strMensagemConfig,['&O K']);
          Result := False;
        end;
      end;
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
        End;
      End;

      If (Result) And ((fCfgSis('DACPOR', varBoolean)) And  (Pos(edtCodPor.Text, fRetPortadoresOperador(strLoginUsuarioLogado)) <= 0)) then
      Begin
        fMensagem('ATENÇÃO!', 'O Operador não possui Direito de Acesso ao Portador selecionado!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = fraCentroCusto.edtCodEve) Then
    Begin

      If fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        If (fCfgSis('CTPOBE', varBoolean)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Centro de Custo deve ser preenchido!', ['&O k']);
          Result := False;
        End;
        fraCentroCusto.edtDesEve.Clear;
      End
      Else
      Begin
        pCarregaEvento();
        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custo não está cadastrado!'+strMensagemConfig,['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin

      If fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser preenchido!'+strMensagemConfig,['&O K']);
        fraPlanoDeContas.edtDesCta.Clear;
        Result := False;
      End
      Else If (RightStr(fraPlanoDeContas.MskCodCta.Text, 3) = '000') Then
      Begin
        fMensagem('ATENÇÃO!', 'Linha / Grupo não é permitido!'+strMensagemConfig,['&O K']);
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
    End;
  End;

  If Not Result Then
    if not blnNaoEditar then
      pSetFocus(Sender);

End;

procedure TfrmConfigCtaDDA.GravaDadosDeAutenticacao;
begin
  if not FBancoAPI Then
    Exit;

  if not MatchStr(fraDDAAPIAutenticacaoFrame.edtArquivoPFX.Text, [EmptyStr, 'certificado cadastrado']) then
  begin
    fGetBancoConfig(1, FCarteira, 'AUTHPFX', RetornaArquivoBase64(fraDDAAPIAutenticacaoFrame.edtArquivoPFX.Text));

    fGetBancoConfig(1, FCarteira, 'VALCERT', fraDDAAPIAutenticacaoFrame.edtValidadeCertificado.Text);
  end;

  if not MatchStr(fraDDAAPIAutenticacaoFrame.edtChaveAppDev.Text, [EmptyStr, 'Chave App cadastrada']) tHen
    fGetBancoConfig(1, FCarteira, 'KEY_USER', fraDDAAPIAutenticacaoFrame.edtChaveAppDev.Text);

  fGetBancoConfig(1, FCarteira, 'AUTHSEN', fraDDAAPIAutenticacaoFrame.edtSenhaCertificado.Text);
  fGetBancoConfig(1, FCarteira, 'CLIENT_ID', fraDDAAPIAutenticacaoFrame.edtClientID.Text);
  fGetBancoConfig(1, FCarteira, 'CLIENT_SECRET', fraDDAAPIAutenticacaoFrame.edtClientSecret.Text);

  if fraDDAAPIAutenticacaoFrame.edtChaveBasic.Text <> 'Autorização Basic cadastrada' then
    fGetBancoConfig(1, FCarteira, 'AUTHORIZATION', fraDDAAPIAutenticacaoFrame.edtChaveBasic.Text);

  if fGetBancoConfig(0, FCarteira, 'HOMOLOGACAO', EmptyStr) = EmptyStr then
    fGetBancoConfig(1, FCarteira, 'HOMOLOGACAO', 'N');
end;

procedure TfrmConfigCtaDDA.pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;

end;

procedure TfrmConfigCtaDDA.edtCodPorKeyPress(Sender: TObject; var Key: Char);
Var
  arrPortador : TConsultasArray;
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, Nil, Key, arrPortador) Then
    if fValidaCampos(edtCodPor) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfigCtaDDA.FormCreate(Sender: TObject);
begin
  inherited;
  FBancoAPI := False;
end;

procedure TfrmConfigCtaDDA.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigCtaDDA.FormShow(Sender: TObject);
var
  LMostrarCaminhoRetorno: Boolean;
  LExibirPanelEmpresa: Boolean;
  LAlturaFinal: Integer;
begin
  inherited;

  cxPaginas.ActivePageIndex := 0;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryCadPor := fCriarQuery('SELECT * FROM CADPOR WHERE FALSE', Self);

  pCarregaDados;
  pSetFocus(edtCodAgencia);
  pSetFocus(btnEditar);

  LMostrarCaminhoRetorno := not FBancoAPI;

  tbsDadosAutenticacao.TabVisible          := FBancoAPI;
  lblPathArquivosRet.Visible               := LMostrarCaminhoRetorno;
  fraPathRetorno.Visible                   := LMostrarCaminhoRetorno;
  fraPathRetorno.edtDirectory.Visible      := LMostrarCaminhoRetorno;
  fraPathRetorno.btnOpenDirectory.Visible  := LMostrarCaminhoRetorno;

  if FBancoAPI then
  begin
    fraDDAAPIAutenticacaoFrame.CarregaCampos(strCodBco);
    pnlFiltraEmpresaLogada.Top := fraPathRetorno.Top;
  end;

  if FBancoAPI then
    LExibirPanelEmpresa := True
  else
    LExibirPanelEmpresa := SameText(FstrConfig, 'CONFIGDDA341');

  pnlFiltraEmpresaLogada.Visible := LExibirPanelEmpresa;

  if FBancoAPI then
    LAlturaFinal := Self.Height
  else
    LAlturaFinal := 300;
  Self.Height := LAlturaFinal;

  if blnNaoEditar then
  begin
     pnlAtivo.Enabled := False;
     btnGravar.Enabled     := True;
     btnEditar.Visible     := False;
     pSetFocus(btnGravar);
  end;
end;

procedure TfrmConfigCtaDDA.pCarregaPortador(strCodPor: String; edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtDesPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;

end;

procedure TfrmConfigCtaDDA.pCarregaEvento();
begin
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmConfigCtaDDA.tabContasChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmConfigCtaDDA.tabContasChanging(Sender: TObject;
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

procedure TfrmConfigCtaDDA.pCarregaDados;
begin
  if FBancoAPI then
    FCarteira := FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1);
  edtCodAgencia.Text     := fGetBancoConfig(0, FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1), 'CODAGEN', '');
  edtContaCorr.Text      := fGetBancoConfig(0, FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1), 'NUMCTAC', '');
  edtDigCtaCor.Text      := fGetBancoConfig(0, FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1), 'DIGCTAC', '');
  edtCodPor.Text         := fGetBancoConfig(0, FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1), 'PORCTP_', '');
  fraPlanoDeContas.MskCodCta.Text         := fGetBancoConfig(0, FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1), 'CTACTP_', '');
  fraPathRetorno.edtDirectory.text    := fGetBancoConfig(0, FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1), 'PATHRET', '');
  fraCentroCusto.edtCodEve.Text := fGetBancoConfig(0, FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1), 'EVECTP_', '');

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor)
  Else
    edtDesPor.Text := '';

  If Not fEmptyStr( fraPlanoDeContas.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta)
  Else
    fraPlanoDeContas.edtDesCta.Text := '';

  If Not fEmptyStr( fraCentroCusto.edtCodEve.Text ) Then
    pCarregaEvento()
  Else
    fraCentroCusto.edtDesEve.Text := '';

  if FBancoAPI then
    CarregaDadosAutorizacao;
end;

procedure TfrmConfigCtaDDA.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do registro da carteira selecionada?', ['&S i m', '&N ã o'], 2) = 1 then
  begin
    btnCancelar.Visible := False;
    btnEditar.Visible   := True;
    pnlAtivo.Enabled    := False;
    btnEditar.Visible   := True;
    btnGravar.Enabled   := False;
    pCarregaDados;
    pSetFocus(btnEditar);
  end;

end;

procedure TfrmConfigCtaDDA.btnEditarClick(Sender: TObject);
begin
  If ((Not fVerificaDireitoAutBan('PERCARBAN')) and (strLoginUsuarioLogado <> '999')) Then
  begin
    fMensagem('ATENÇÃO','Usuário sem permissão!', ['&Ok ']);
    Exit;
  end
  else
  begin
    pnlAtivo.Enabled  := True;
    pnlAtivo2.Enabled := FBancoAPI;
    btnGravar.Enabled := True;
    btnEditar.Visible := False;
    btnCancelar.Visible := true;
    pSetFocus(edtCodAgencia);
  end;

end;

procedure TfrmConfigCtaDDA.btnGravarClick(Sender: TObject);
Var
  stlCfgAnt : TStringList;
begin
  inherited;
  If fVerificaCampos Then
  Begin
    Try
      if FBancoAPI then
        if blnNaoEditar then
        begin
          Close;
          ModalResult := mrOk;
          Exit;
        end;

      stlCfgAnt := TStringList.Create;
      pCarregaCfg(stlCfgAnt);

      fGetBancoConfig(1, FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text   );
      fGetBancoConfig(1, FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text    );
      fGetBancoConfig(1, FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1), 'DIGCTAC', edtDigCtaCor.Text    );
      fGetBancoConfig(1, FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1), 'PORCTP_', edtCodPor.Text       );
      fGetBancoConfig(1, FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1), 'CTACTP_', fraPlanoDeContas.MskCodCta.Text       );
      fGetBancoConfig(1, FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1), 'EVECTP_', fraCentroCusto.edtCodEve.Text       );
      fGetBancoConfig(1, FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1), 'PATHRET', fraPathRetorno.edtDirectory.text  );

      if FBancoAPI then
        GravaDadosDeAutenticacao;

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        pBackupCnfBco;
        fMensagem('', 'Configurações salvas com sucesso.', ['&O K'], 1, True);
        pnlAtivo.Enabled  := False;
        btnGravar.Enabled := False;
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
        fMensagem('Erro','Ocorreu um erro ao tentar salvar as configurações.' + #13 + E.Message,['&O K']);
      End;
    End;

    FreeAndNil(stlCfgAnt);
  End;
end;

procedure TfrmConfigCtaDDA.CarregaDadosAutorizacao;
begin
  fraDDAAPIAutenticacaoFrame.edtChaveAppDev.Clear;
  if (fGetBancoConfig(0, FCarteira, 'KEY_USER', EmptyStr) <> EmptyStr) Then
    fraDDAAPIAutenticacaoFrame.edtChaveAppDev.Text := 'Chave App cadastrada';

  fraDDAAPIAutenticacaoFrame.edtChaveBasic.Clear;
  if (fGetBancoConfig(0, FCarteira, 'AUTHORIZATION', EmptyStr) <> EmptyStr) Then
    fraDDAAPIAutenticacaoFrame.edtChaveBasic.Text := 'Autorização Basic cadastrada';

  fraDDAAPIAutenticacaoFrame.edtArquivoPFX.Clear;
  if fGetBancoConfig(0, FCarteira, 'AUTHPFX', EmptyStr) <> EmptyStr Then
    fraDDAAPIAutenticacaoFrame.edtArquivoPFX.Text := 'certificado cadastrado';

  fraDDAAPIAutenticacaoFrame.edtClientId.Text := fGetBancoConfig(0, FCarteira, 'CLIENT_ID', '');
  fraDDAAPIAutenticacaoFrame.edtClientSecret.Text := fGetBancoConfig(0, FCarteira, 'CLIENT_SECRET', '');
  fraDDAAPIAutenticacaoFrame.edtSenhaCertificado.Text := fGetBancoConfig(0, FCarteira, 'AUTHSEN', '');
  fraDDAAPIAutenticacaoFrame.edtValidadeCertificado.Text := fGetBancoConfig(0, FCarteira, 'VALCERT', '');

  if not fEmptyStr(fraDDAAPIAutenticacaoFrame.edtValidadeCertificado.Text) Then
  begin
    if StrToDateDef(fraDDAAPIAutenticacaoFrame.edtValidadeCertificado.Text,0) <= IncDay(VS_Date,30) Then
    begin
      fMensagem('ATENÇÃO','O certificado digital está próximo da data de validade, considere realizar a renovação!',['&O K']);
    end;
  end;

  fraDDAAPIAutenticacaoFrame.lblAmbienteAPI.Caption := 'PRODUÇÃO';
  fraDDAAPIAutenticacaoFrame.lblAmbienteAPI.Font.Color := clBlue;
  if fGetBancoConfig(0, FCarteira, 'HOMOLOGACAO', EmptyStr) = 'S' Then
  begin
    fraDDAAPIAutenticacaoFrame.lblAmbienteAPI.Caption := 'HOMOLOGAÇÃO';
    fraDDAAPIAutenticacaoFrame.lblAmbienteAPI.Font.Color := clRed;
  end;
end;

procedure TfrmConfigCtaDDA.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Cód. agência               :' + fGetBancoConfig(0, FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Número C/C                 :' + fGetBancoConfig(0, FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1), 'NUMCTAC', ''));
  stlCampos.Add('Dígito C/C                 :' + fGetBancoConfig(0, FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1), 'DIGCTAC', ''));
  stlCampos.Add('Portador de CTP            :' + fGetBancoConfig(0, FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1), 'PORCTP_', ''));
  stlCampos.Add('Conta de CTP               :' + fGetBancoConfig(0, FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1), 'CTACTP_', ''));
  stlCampos.Add('Centro de Custo de CTP     :' + fGetBancoConfig(0, FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1), 'EVECTP_', ''));
  stlCampos.Add('Arquivo retorno            :' + fGetBancoConfig(0, FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1), 'PATHRET', ''));
end;

procedure TfrmConfigCtaDDA.pGravaLogCarteira(stlCfgAnt : TStringList);
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
    pGravaLogAtb(strCodBco, 'BANCO ' + strCodBco + ' DDA CTA', FstrConfig + IntToStr(tabContas.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

end.
