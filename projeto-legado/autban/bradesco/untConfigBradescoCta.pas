unit untConfigBradescoCta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, DirectoryEditFocus, StdCtrls, EditFocus, Buttons,
  ExtCtrls, QColorLabel, Menus, ComCtrls, ShellApi, Uni, AppEvnts,
  BitBtnLockedIncrem, untTypesSistema, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, untFrameDirectoryEditFocus,
  untFramePlanoDeContasMaskEdit, untConfigPagInfo, dxScreenTip, cxClasses,
  dxCustomHint, cxHint;

type
  TfrmConfigBradescoCta = class(TfrmPai)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
    pnlAtivo: TPanel;
    lblCodAgenc: TLabel;
    lblCodCart: TLabel;
    lblContCorr: TLabel;
    lblIdentBanco: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    Label1: TLabel;
    lblProNum: TLabel;
    Label2: TLabel;
    edtContaCorr: TEditFocus;
    edtCodAgencia: TEditFocus;
    edtIdentBanc: TEditFocus;
    edtCodCar: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtProxNumArqRem: TEditFocus;
    edtContComp: TEditFocus;
    fraPathRemessaBradesco: TfraDirectoryEditFocus;
    fraPathRetornoBradesco: TfraDirectoryEditFocus;
    btnCancelar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    BtnManual: TBitBtnLocked;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    btnInfo: TBitBtnLocked;
    HintController: TcxHintStyleController;
    procedure pCarregaDados;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure tabCarteiraChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure BtnManualClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure btnInfoClick(Sender: TObject);
    procedure btnInfoEnter(Sender: TObject);
    procedure btnInfoExit(Sender: TObject);
    procedure btnInfoMouseEnter(Sender: TObject);
    procedure btnInfoMouseLeave(Sender: TObject);
  private
    { Private declarations }
    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;

    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pCarregaCentroCusto(strCtaBai: String; edtLabel: TEdit);
    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
    procedure pHideHint;
    procedure pShowHintBotao(btnBotao: TBitBtnLocked);
  public
    { Public declarations }
    blnNaoEditar: Boolean;
    strConfig   : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigBradescoCta: TfrmConfigBradescoCta;

implementation

uses  untfuncoesSimples, untPesqAux,  untFUncoes,
  untCfgGenericas_AutBan, untConsultas;

{$R *.dfm}

procedure TfrmConfigBradescoCta.pCarregaCentroCusto(strCtaBai: String;
  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;

end;

procedure TfrmConfigBradescoCta.pCarregaDados;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************AF*}
  edtProxNumArqRem.Text      := fGetBancoConfig(0, 'CONFIGCTA237-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '');
  edtCodCar.Text             := fGetBancoConfig(0, 'CONFIGCTA237-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', '');
  edtIdentBanc.Text          := fGetBancoConfig(0, 'CONFIGCTA237-' + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', '');
  edtCodAgencia.Text         := fGetBancoConfig(0, 'CONFIGCTA237-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtContaCorr.Text          := fGetBancoConfig(0, 'CONFIGCTA237-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', '');
  edtCodPor.Text             := fGetBancoConfig(0, 'CONFIGCTA237-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  fraPlanoDeContas.MskCodCta.Text := fGetBancoConfig(0, 'CONFIGCTA237-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');
  fraPathRemessaBradesco.edtDirectory.text:= fGetBancoConfig(0, 'CONFIGCTA237-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '');
  fraPathRetornoBradesco.edtDirectory.text:= fGetBancoConfig(0, 'CONFIGCTA237-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '');
  edtContComp.Text           := fGetBancoConfig(0, 'CONFIGCTA237-' + IntToStr(tabCarteira.TabIndex + 1), 'CONCOMP', '');

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( fraPlanoDeContas.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);

end;

procedure TfrmConfigBradescoCta.FormShow(Sender: TObject);
begin
  inherited;

  qryCadPor := fCriarQuery('SELECT * FROM CADPOR WHERE FALSE', Self);
  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);

  pCarregaDados;
  pSetFocus(edtProxNumArqRem);

  pSetFocus(btnEditar);

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

procedure TfrmConfigBradescoCta.btnEditarClick(Sender: TObject);
begin
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
      pSetFocus(edtCodCar);
  end;

end;

procedure TfrmConfigBradescoCta.btnGravarClick(Sender: TObject);
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

      fGetBancoConfig(1, 'CONFIGCTA237-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', edtProxNumArqRem.Text      );
      fGetBancoConfig(1, 'CONFIGCTA237-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', edtCodCar.Text             );
      fGetBancoConfig(1, 'CONFIGCTA237-' + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', edtIdentBanc.Text          );
      fGetBancoConfig(1, 'CONFIGCTA237-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text         );
      fGetBancoConfig(1, 'CONFIGCTA237-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text          );
      fGetBancoConfig(1, 'CONFIGCTA237-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text             );
      fGetBancoConfig(1, 'CONFIGCTA237-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContas.MskCodCta.Text);
      fGetBancoConfig(1, 'CONFIGCTA237-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessaBradesco.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIGCTA237-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetornoBradesco.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIGCTA237-' + IntToStr(tabCarteira.TabIndex + 1), 'CONCOMP', edtContComp.Text           );

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

procedure TfrmConfigBradescoCta.btnInfoClick(Sender: TObject);
begin
  inherited;
  TConfigPagInfo.pShowInfo;
end;

procedure TfrmConfigBradescoCta.btnInfoEnter(Sender: TObject);
begin
  inherited;
  pShowHintBotao(btnInfo);
end;

procedure TfrmConfigBradescoCta.btnInfoExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBradescoCta.btnInfoMouseEnter(Sender: TObject);
begin
  inherited;
  pShowHintBotao(btnInfo);
end;

procedure TfrmConfigBradescoCta.btnInfoMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBradescoCta.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
    if fValidaCampos(fraPlanoDeContas.MskCodCta) then
      SelectNext(ActiveControl, True, True);
end;

function TfrmConfigBradescoCta.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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
  
    Else If Sender = fraPathRemessaBradesco Then
    Begin

      If fEmptyStr(fraPathRemessaBradesco.edtDirectory.text) Then
      Begin
        fMensagem('','Preencha o campo Path de Remessa'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If Sender = fraPathRetornoBradesco Then
    Begin

      If fEmptyStr(fraPathRetornoBradesco.edtDirectory.text) Then
      Begin
        fMensagem('','Preencha o campo Path de Retorno'+strMensagemConfig,['&O K']);
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

    End;
  End;

  If Not Result Then
    if not blnNaoEditar then
      pSetFocus(Sender);
End;

procedure TfrmConfigBradescoCta.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, nil, Key, arrSel) then
    Begin
      if fValidaCampos(edtCodPor) then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigBradescoCta.pCarregaPortador(strCodPor: String; edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtDesPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;

end;

procedure TfrmConfigBradescoCta.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmConfigBradescoCta.tabCarteiraChanging(Sender: TObject;
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

procedure TfrmConfigBradescoCta.FormCreate(Sender: TObject);
begin
  inherited;
  pCarKeyAutBan;
end;

procedure TfrmConfigBradescoCta.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigBradescoCta.btnCancelarClick(Sender: TObject);
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

procedure TfrmConfigBradescoCta.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '237';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigBradescoCta.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\layout_pagfor.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\layout_pagfor.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigBradescoCta.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Seq. Remessa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  stlCampos.Add('Código Carteira   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', ''));
  stlCampos.Add('Identificação Bco :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', ''));
  stlCampos.Add('Código Agência    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Num. C. Corrente  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  stlCampos.Add('Portador de Baixa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Conta Baixa       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Arquivo Remessa   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo Retorno   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  stlCampos.Add('Conta Complementar:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CONCOMP', ''));
end;

procedure TfrmConfigBradescoCta.pGravaLogCarteira(stlCfgAnt : TStringList);
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
    pGravaLogAtb('237', 'BRADESCO CTA', strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

procedure TfrmConfigBradescoCta.pHideHint;
begin
  HintController.HideHint;
end;

procedure TfrmConfigBradescoCta.pShowHintBotao(btnBotao: TBitBtnLocked);
begin
  HintController
   .ShowHint(btnBotao.ClientOrigin.X,btnBotao.ClientOrigin.Y, 'Regras da Baixa Automática', btnBotao.Hint);
end;


end.
