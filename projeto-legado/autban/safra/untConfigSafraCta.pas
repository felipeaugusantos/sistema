unit untConfigSafraCta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, EditFocus, Vcl.Mask,
  DirectoryEditFocus, Vcl.ComCtrls, untTypesSistema, Uni, DB, untConsultas,
  untFuncoesSimples, untFuncoes, untPesqAux, StrUtils, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus, untFramePlanoDeContasMaskEdit, untConfigPagInfo,
  dxScreenTip, cxClasses, dxCustomHint, cxHint;

type
  TfrmConfigSafraCta = class(TfrmPai)
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
    btnGravar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    pnlAtivo: TPanel;
    lblProNum: TLabel;
    lblCodAgenc: TLabel;
    lblContCorr: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    Label1: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label14: TLabel;
    edtProxNumArqRem: TEditFocus;
    edtContaCorr: TEditFocus;
    edtCodAgencia: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtDiasCred: TEditFocus;
    fraPathRemessa: TfraDirectoryEditFocus;
    fraPathRetorno: TfraDirectoryEditFocus;
    btnCancelar: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    btnInfo: TBitBtnLocked;
    HintController: TcxHintStyleController;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure tabCarteiraChange(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure btnInfoClick(Sender: TObject);
    procedure btnInfoEnter(Sender: TObject);
    procedure btnInfoMouseEnter(Sender: TObject);
    procedure btnInfoMouseLeave(Sender: TObject);
    procedure btnInfoExit(Sender: TObject);
  private
    FstrConfig: String;
    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;

    procedure pCarregaDados;
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
    procedure pHideHint;
    procedure pShowHintBotao(btnBotao: TBitBtnLocked);
    { Private declarations }
  public
    { Public declarations }

    blnNaoEditar: Boolean;
    property strConfig: String read FstrConfig write FstrConfig; //Carrega a configuração do Banco da CNFBCO
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigSafraCta: TfrmConfigSafraCta;

implementation

{$R *.dfm}

uses untCfgGenericas_AutBan, SysUtils;

procedure TfrmConfigSafraCta.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do registro da carteira selecionada?', ['&S i m', '&N ã o'], 2) = 1 then
  begin
    btnCancelar.Visible := False;
    btnEditar.Visible   := True;
    pnlAtivo.Enabled    := False;
    btnEditar.Visible   := True;
    btnGravar.Enabled   := False;
    btnConfigurar.Enabled := False;
    pCarregaDados;
    pSetFocus(btnEditar);
  end;

end;

procedure TfrmConfigSafraCta.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try

    pCriarFormularios(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '422';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;
end;

procedure TfrmConfigSafraCta.btnEditarClick(Sender: TObject);
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

procedure TfrmConfigSafraCta.btnGravarClick(Sender: TObject);
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

      fGetBancoConfig(1, FstrConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', edtProxNumArqRem.Text);
      fGetBancoConfig(1, FstrConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text   );
      fGetBancoConfig(1, FstrConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', RightStr(edtContaCorr.Text, 8) );
      fGetBancoConfig(1, FstrConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessa.edtDirectory.text  );
      fGetBancoConfig(1, FstrConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetorno.edtDirectory.text  );
      fGetBancoConfig(1, FstrConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text       );
      fGetBancoConfig(1, FstrConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContas.MskCodCta.Text       );
      fGetBancoConfig(1, FstrConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text  );
      fGetBancoConfig(1, FstrConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text  );
      fGetBancoConfig(1, FstrConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text     );

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        pBackupCnfBco;
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        pnlAtivo.Enabled  := False;
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

procedure TfrmConfigSafraCta.btnInfoClick(Sender: TObject);
begin
  inherited;
  TConfigPagInfo.pShowInfo;
end;

procedure TfrmConfigSafraCta.btnInfoEnter(Sender: TObject);
begin
  inherited;
  pShowHintBotao(btnInfo);
end;

procedure TfrmConfigSafraCta.btnInfoExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSafraCta.btnInfoMouseEnter(Sender: TObject);
begin
  inherited;
  pShowHintBotao(btnInfo);
end;

procedure TfrmConfigSafraCta.btnInfoMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSafraCta.edtCodPorKeyPress(Sender: TObject; var Key: Char);
Var
  arrPortador : TConsultasArray;
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, Nil, Key, arrPortador) Then
    if fValidaCampos(edtCodPor) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfigSafraCta.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigSafraCta.FormShow(Sender: TObject);
begin
  inherited;
  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryCadPor := fCriarQuery('SELECT * FROM CADPOR WHERE FALSE', Self);

  pSetFocus(btnEditar);

  pCarregaDados;
  pSetFocus(edtProxNumArqRem);

  if blnNaoEditar then
  begin
    pnlAtivo.Enabled := False;
    btnConfigurar.Enabled := False;
    btnConfigurar.Visible := False;
    btnGravar.Enabled     := True;
    btnEditar.Visible     := False;
    pSetFocus(btnGravar);
  end;
end;

procedure TfrmConfigSafraCta.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
    if fValidaCampos(fraPlanoDeContas.MskCodCta) then
      SelectNext(ActiveControl, True, True);
end;

function TfrmConfigSafraCta.fValidaCampos(Sender: TWinControl;
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
        fMensagem('', 'O Próximo Núm. Arq. Remessa deve conter um valor!'+strMensagemConfig,['&O K']);
        Result := False;
      End

      Else If StrToInt(edtProxNumArqRem.Text) <= 0 Then
      Begin
       fMensagem('', 'O Próximo Núm. Arq. Remessa deve ser maior que zero!'+strMensagemConfig,['&O K']);
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
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este operador!'+strMensagemConfig,['&O K']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin

      If fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Centro de Custo deve ser preenchido!'+strMensagemConfig,['&O K']);
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
          fMensagem('ATENÇÃO!', 'Esse Centro de Custo não está cadastrado!'+strMensagemConfig,['&O K']);
          Result := False;
        End
        Else
        Begin
          Result := PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text,False);
          if not Result then
            fMensagem('ATENÇÃO!', 'O Centro de Custo está Inativo!',['&OK']);
        End;
      End;

    End;

  End;

  If Not Result Then
    if not blnNaoEditar then
      pSetFocus(Sender);

end;

procedure TfrmConfigSafraCta.pCarregaCentroCusto(strCtaBai: String;
  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmConfigSafraCta.pCarregaDados;
begin
  edtProxNumArqRem.Text := fGetBancoConfig(0,FstrConfig + IntToStr(tabCarteira.TabIndex + 1),'PROXNUM','');
  edtCodAgencia.Text    := fGetBancoConfig(0,FstrConfig + IntToStr(tabCarteira.TabIndex + 1),'CODAGEN','');
  edtContaCorr.Text     := RightStr(fGetBancoConfig(0,FstrConfig + IntToStr(tabCarteira.TabIndex + 1),'NUMCTAC',''), 8);
  edtObservacao1.Text   := fGetBancoConfig(0,FstrConfig + IntToStr(tabCarteira.TabIndex + 1),'OBSERV1','');
  edtObservacao2.Text   := fGetBancoConfig(0,FstrConfig + IntToStr(tabCarteira.TabIndex + 1),'OBSERV2','');
  fraPathRemessa.edtDirectory.text   := fGetBancoConfig(0,FstrConfig + IntToStr(tabCarteira.TabIndex + 1),'PATHREM','');
  fraPathRetorno.edtDirectory.text   := fGetBancoConfig(0,FstrConfig + IntToStr(tabCarteira.TabIndex + 1),'PATHRET','');
  edtCodPor.Text        := fGetBancoConfig(0,FstrConfig + IntToStr(tabCarteira.TabIndex + 1),'PORBAI_','');
  fraPlanoDeContas.MskCodCta.Text        := fGetBancoConfig(0,FstrConfig + IntToStr(tabCarteira.TabIndex + 1),'CTABAI_','');
  edtDiasCred.Text      := fGetBancoConfig(0,FstrConfig + IntToStr(tabCarteira.TabIndex + 1),'DIACRED','');
  
  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor)
  Else
    edtDesPor.Clear;

  If Not fEmptyStr( fraPlanoDeContas.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta)
  Else
    fraPlanoDeContas.edtDesCta.Clear;
end;

procedure TfrmConfigSafraCta.pCarregaPortador(strCodPor: String;
  edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtDesPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmConfigSafraCta.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmConfigSafraCta.tabCarteiraChanging(Sender: TObject;
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

procedure TfrmConfigSafraCta.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Seq. remessa      :' + fGetBancoConfig(0, FstrConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  stlCampos.Add('Cód. agência      :' + fGetBancoConfig(0, FstrConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Número C/C        :' + fGetBancoConfig(0, FstrConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  stlCampos.Add('Portador de baixa :' + fGetBancoConfig(0, FstrConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Conta de baixa    :' + fGetBancoConfig(0, FstrConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Observação 1      :' + fGetBancoConfig(0, FstrConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2      :' + fGetBancoConfig(0, FstrConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, FstrConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  stlCampos.Add('Arquivo remessa   :' + fGetBancoConfig(0, FstrConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo retorno   :' + fGetBancoConfig(0, FstrConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
end;

procedure TfrmConfigSafraCta.pGravaLogCarteira(stlCfgAnt : TStringList);
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
    pGravaLogAtb('422', 'BANCO SAFRA CTA', FstrConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

procedure TfrmConfigSafraCta.pHideHint;
begin
  HintController.HideHint;
end;

procedure TfrmConfigSafraCta.pShowHintBotao(btnBotao: TBitBtnLocked);
begin
  HintController
   .ShowHint(btnBotao.ClientOrigin.X,btnBotao.ClientOrigin.Y, 'Regras da Baixa Automática', btnBotao.Hint);
end;

end.
