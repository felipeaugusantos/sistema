unit untConfigPagFor;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade,DateUtils, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Vcl.Mask,
  DirectoryEditFocus, Vcl.ComCtrls, untFuncoesSimples, Uni, untTypesSistema, StrUtils,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, ComboBoxFocus, 
  untFrameDirectoryEditFocus, QColorLabel, untFramePlanoDeContasMaskEdit,untMemo,
  untConfigPagInfo, dxScreenTip, cxClasses, dxCustomHint, cxHint,
  dxBarBuiltInMenu, cxPC, untPagForAPIAutenticacaoFrame;

type
  TfrmConfigPagFor = class(TfrmPai)
    pnlTopo: TPanel;
    tabContas: TTabControl;
    btnCancelar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    btnInfo: TBitBtnLocked;
    HintController: TcxHintStyleController;
    cxPaginas: TcxPageControl;
    tbsGeral: TcxTabSheet;
    pnlAtivo1: TPanel;
    Label6: TLabel;
    lblCodAgenc: TLabel;
    lblContCorr: TLabel;
    lblPathArquivosRet: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    lblCodCart: TLabel;
    lblIdentBanco: TLabel;
    lblProNum: TLabel;
    lblPathArquivosRem: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label14: TLabel;
    lblSolicDataPag: TLabel;
    lblInfoSolicDataPag: TColorLabel;
    lblCodComp: TLabel;
    lblParTran: TLabel;
    lblOpeCon: TLabel;
    edtDigCtaCor: TEditFocus;
    edtContaCorr: TEditFocus;
    edtCodAgencia: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtCodEve: TEditFocus;
    edtDesEve: TEditFocus;
    fraPathRetorno: TfraDirectoryEditFocus;
    edtIdentBanc: TEditFocus;
    edtCodCar: TEditFocus;
    edtNumCart: TEditFocus;
    edtProxNumArqRem: TEditFocus;
    fraPathRemessa: TfraDirectoryEditFocus;
    grpDadDep: TGroupBox;
    Label11: TLabel;
    cmbAvisoFavorecido: TComboBoxFocus;
    edtDigAge: TEditFocus;
    edtCodConv: TEditFocus;
    edtDiasCred: TEditFocus;
    edtSolicDataPag: TEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    edtCodComp: TEditFocus;
    edtParTran: TEditFocus;
    edtOpeCon: TEditFocus;
    pnlRelatorioPorInconsistencia: TPanel;
    lblRelatorioPorInconsistencia: TLabel;
    clRelatorioPorInconsistencia: TColorLabel;
    edtRelatorioPorInconsistencia: TEditFocus;
    tbsDadosAutenticacao: TcxTabSheet;
    pnlAtivo2: TPanel;
    fraPagForAPIAutenticacao: TfraPagForAPIAutenticacaoFrame;
    edtLiberarPagamento: TEditFocus;
    lblLiberarPagamento: TLabel;
    lblInfoLiberarPagamento: TColorLabel;
    procedure btnGravarClick(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure tabContasChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure btnEditarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure tabContasChanging(Sender: TObject; var AllowChange: Boolean);
    procedure btnConfigurarClick(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure btnInfoClick(Sender: TObject);
    procedure btnInfoEnter(Sender: TObject);
    procedure btnInfoMouseEnter(Sender: TObject);
    procedure btnInfoMouseLeave(Sender: TObject);
    procedure btnInfoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FstrConfig: String;
    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;
    qryCadEve : TUniQuery;

    FBancoAPI: Boolean;

    FCarteira: String;

    procedure pCarregaDados;
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
    procedure pCarregaEvento(strCodEve: String; edtLabel: TEdit);
    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
    procedure pHideHint;
    procedure pShowHintBotao(btnBotao: TBitBtnLocked);

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
  frmConfigPagFor: TfrmConfigPagFor;

implementation
Uses untConsultas, untPesqAux, untFuncoes, untCfgGenericas_AutBan;
{$R *.dfm}

procedure TfrmConfigPagFor.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
    if fValidaCampos(fraPlanoDeContas.MskCodCta) then
      SelectNext(ActiveControl, True, True);
end;

function TfrmConfigPagFor.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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
      If fraPathRetorno.Visible Then
      Begin
        If fEmptyStr(fraPathRetorno.edtDirectory.text) Then
        Begin
          fMensagem('','Preencha o campo Pasta para Arquivos de Retorno'+strMensagemConfig,['&O K']);
          Result := False;
        End;
      End;
    End

    Else If Sender = fraPathRemessa Then
    Begin
      If fraPathRemessa.Visible Then
      Begin
        If fEmptyStr(fraPathRemessa.edtDirectory.text) Then
        Begin
          fMensagem('','Preencha o campo Path de Remessa'+strMensagemConfig,['&O K']);
          Result := False;
        End;
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

      If (Result) And ((fCfgSis('DACPOR', varBoolean)) And  (Pos(edtCodPor.Text, fRetPortadoresOperador(strLoginUsuarioLogado)) <= 0)) then
      Begin
        fMensagem('ATENÇÃO!', 'O Operador não possui Direito de Acesso ao Portador selecionado!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodEve) Then
    Begin

      If fEmptyStr(edtCodEve.Text) Then
        edtDesEve.Clear
      Else
      Begin
        pCarregaEvento(edtCodEve.Text, edtDesEve);
        If qryCadEve.FieldByName('EVE_CODEVE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse evento não está cadastrado!'+strMensagemConfig,['&O K']);
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
        Else
          Result := PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text,True);
      End;

    End

    Else If (Sender = cmbAvisoFavorecido) Then
    Begin
      If cmbAvisoFavorecido.ItemIndex = -1 Then
      Begin
        fMensagem('','O Campo de Aviso ao Favorecido deve ser preenchido!' + strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtSolicDataPag) Then
    Begin
      If edtSolicDataPag.Visible Then
        If Pos(edtSolicDataPag.Text, 'SN') = 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo "Solicita Data de Pagamento" deve ser preenchido com S ou N!', ['&O K']);
          Result := False;
        End;
    End

    Else If (Sender = edtLiberarPagamento) Then
    Begin
      If edtLiberarPagamento.Visible Then
        If Pos(edtLiberarPagamento.Text, 'SN') = 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo "Liberar pagamento automaticamente" deve ser preenchido com S ou N!', ['&O K']);
          Result := False;
        End;
    End

    Else If (Sender = edtRelatorioPorInconsistencia) And pnlRelatorioPorInconsistencia.Visible Then
    Begin
      If Pos(edtRelatorioPorInconsistencia.Text, 'SN') = 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Exibir o motivo no relatório de inconsistência da importação" deve ser preenchido com S ou N!', ['&O K']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    if not blnNaoEditar then
      pSetFocus(Sender);

End;

procedure TfrmConfigPagFor.GravaDadosDeAutenticacao;
begin
  If Not FBancoAPI Then
    Exit;

  If Not MatchStr(fraPagForAPIAutenticacao.edtArquivoPFX.Text, ['', 'certificado cadastrado']) Then
  Begin
    fGetBancoConfig(1, FCarteira, 'AUTHPFX', RetornaArquivoBase64(fraPagForAPIAutenticacao.edtArquivoPFX.Text));

    fGetBancoConfig(1, FCarteira, 'VALCERT', fraPagForAPIAutenticacao.edtValidadeCertificado.Text);
  End;

  If Not MatchStr(fraPagForAPIAutenticacao.edtChaveAppDev.Text, ['', 'Chave App cadastrada']) THen
    fGetBancoConfig(1, FCarteira, 'KEY_USER', fraPagForAPIAutenticacao.edtChaveAppDev.Text);

  fGetBancoConfig(1, FCarteira, 'AUTHSEN', fraPagForAPIAutenticacao.edtSenhaCertificado.Text);
  fGetBancoConfig(1, FCarteira, 'CLIENT_ID', fraPagForAPIAutenticacao.edtClientID.Text);
  fGetBancoConfig(1, FCarteira, 'CLIENT_SECRET', fraPagForAPIAutenticacao.edtClientSecret.Text);

  If fraPagForAPIAutenticacao.edtChaveBasic.Text <> 'Autorização Basic cadastrada' Then
    fGetBancoConfig(1, FCarteira, 'AUTHORIZATION', fraPagForAPIAutenticacao.edtChaveBasic.Text);

  If fGetBancoConfig(0, FCarteira, 'HOMOLOGACAO', '') = EmptyStr Then
    fGetBancoConfig(1, FCarteira, 'HOMOLOGACAO', 'N');
end;

procedure TfrmConfigPagFor.pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;

end;

procedure TfrmConfigPagFor.edtCodEveKeyPress(Sender: TObject; var Key: Char);
Var
  arrEvento : TConsultasArray;
begin
  inherited;
  If fPesqEventos(Self, edtCodEve, edtDesEve, Nil, Key, arrEvento) Then
    if fValidaCampos(edtCodEve) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfigPagFor.edtCodPorKeyPress(Sender: TObject; var Key: Char);
Var
  arrPortador : TConsultasArray;
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, Nil, Key, arrPortador) Then
    if fValidaCampos(edtCodPor) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfigPagFor.FormCreate(Sender: TObject);
begin
  inherited;
  FBancoAPI := False;
end;

procedure TfrmConfigPagFor.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigPagFor.FormShow(Sender: TObject);
begin
  inherited;
  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryCadPor := fCriarQuery('SELECT * FROM CADPOR WHERE FALSE', Self);
  qryCadEve := fCriarQuery('SELECT * FROM CADEVE WHERE FALSE', Self);
  pCarregaDados;
  pSetFocus(edtCodAgencia);

  pSetFocus(btnEditar);

  tbsDadosAutenticacao.Visible    := FBancoAPI;
  edtLiberarPagamento.Visible     := (FBancoAPI and (strCodBco = '001'));
  lblLiberarPagamento.Visible     := edtLiberarPagamento.Visible;
  lblInfoLiberarPagamento.Visible := edtLiberarPagamento.Visible;
  fraPathRetorno.Visible          := Not FBancoAPI;
  fraPathRemessa.Visible          := Not FBancoAPI;
  lblPathArquivosRem.Visible      := Not FBancoAPI;
  lblPathArquivosRet.Visible      := Not FBancoAPI;
  If FBancoAPI Then
    fraPagForAPIAutenticacao.CarregaCampos(strCodBco);

  cxPaginas.ActivePageIndex := 0;
  tbsDadosAutenticacao.TabVisible := FBancoAPI;

  if blnNaoEditar then
  begin
    pnlAtivo1.Enabled := False;
    pnlAtivo2.Enabled := False;
    btnGravar.Enabled := True;
    btnEditar.Visible := False;
    pSetFocus(btnGravar);
  end;

  lblSolicDataPag.Visible     := MatchStr(strCodBco, ['341', '001']);
  lblInfoSolicDataPag.Visible := MatchStr(strCodBco, ['341', '001']);
  edtSolicDataPag.Visible     := MatchStr(strCodBco, ['341', '001']);

  edtCodComp.Visible          := (RightStr(strConfig,3) = '104');
  lblCodComp.Visible          := (RightStr(strConfig,3) = '104');
  edtParTran.Visible          := (RightStr(strConfig,3) = '104');
  lblParTran.Visible          := (RightStr(strConfig,3) = '104');
  edtOpeCon.Visible           := (RightStr(strConfig,3) = '104');
  lblOpeCon.Visible           := (RightStr(strConfig,3) = '104');

  pnlRelatorioPorInconsistencia.Visible :=  (RightStr(strConfig,3) = '341');
end;

procedure TfrmConfigPagFor.pCarregaPortador(strCodPor: String; edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtDesPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;

end;

procedure TfrmConfigPagFor.pCarregaEvento(strCodEve: String; edtLabel: TEdit);
begin
  pPesquisaCadEve(Nil, qryCadEve, strCodEve);
  With qryCadEve Do
  Begin
    edtDesEve.Text := FieldByName('EVE_DESEVE').AsString;
  End;

end;

procedure TfrmConfigPagFor.tabContasChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmConfigPagFor.tabContasChanging(Sender: TObject;
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

procedure TfrmConfigPagFor.pCarregaDados;
begin
  If fEmptyStr(fGetBancoConfig(0, FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1), 'PROXNUM', '')) Then
  Begin
    edtProxNumArqRem.Enabled := True;
    edtProxNumArqRem.Clear;
    pSetFocus(edtProxNumArqRem);
  End
  Else
  Begin
    edtProxNumArqRem.Text  := fGetBancoConfig(0, FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1), 'PROXNUM', '');
    edtProxNumArqRem.Enabled := False;
    pSetFocus(edtCodConv);
  End;

  if (strLoginUsuarioLogado='997') or(strLoginUsuarioLogado='998') or (strLoginUsuarioLogado='999') Then
  begin
    edtProxNumArqRem.Enabled := True;
    pSetFocus(edtProxNumArqRem);
  End;

  FCarteira := FstrConfig + '-' + IntToStr(tabContas.TabIndex + 1);

  edtProxNumArqRem.Text  := fGetBancoConfig(0, FCarteira, 'PROXNUM', '');
  edtNumCart.Text        := fGetBancoConfig(0, FCarteira, 'NUMCART', '');
  edtIdentBanc.Text      := fGetBancoConfig(0, FCarteira, 'IDENTBC', '');
  edtCodCar.Text         := fGetBancoConfig(0, FCarteira, 'CODCART', '');
  edtCodAgencia.Text     := fGetBancoConfig(0, FCarteira, 'CODAGEN', '');
  edtCodConv.Text        := fGetBancoConfig(0, FCarteira, 'CONVENI', '');
  edtDigAge.Text         := fGetBancoConfig(0, FCarteira, 'DIGAGEN', '');
  edtContaCorr.Text      := fGetBancoConfig(0, FCarteira, 'NUMCTAC', '');
  edtOpeCon.Text         := fGetBancoConfig(0, FCarteira, 'OPERCONTA', '');
  edtDigCtaCor.Text      := fGetBancoConfig(0, FCarteira, 'DIGCTAC', '');
  edtCodPor.Text         := fGetBancoConfig(0, FCarteira, 'PORBAI_', '');
  fraPlanoDeContas.MskCodCta.Text := fGetBancoConfig(0, FCarteira, 'CTABAI_', '');
  edtCodEve.Text         := fGetBancoConfig(0, FCarteira, 'EVECTP_', '');
  edtDiasCred.Text       := fGetBancoConfig(0, FCarteira, 'DIACRED', '');
  fraPathRemessa.edtDirectory.text    := fGetBancoConfig(0, FCarteira, 'PATHREM', '');
  fraPathRetorno.edtDirectory.text    := fGetBancoConfig(0, FCarteira, 'PATHRET', '');

  edtCodComp.Text        := fGetBancoConfig(0, FCarteira, 'CODCOMPROMI', '');
  edtParTran.Text        := fGetBancoConfig(0, FCarteira, 'CODPARTRAN',  '');

  If edtSolicDataPag.Visible Then
  Begin
    edtSolicDataPag.Text := fGetBancoConfig(0, FCarteira, 'SOLICDT', '');

    If fEmptyStr(edtSolicDataPag.Text) Then
      edtSolicDataPag.Text := 'N';
  End;

  If edtLiberarPagamento.Visible Then
  Begin
    edtLiberarPagamento.Text := fGetBancoConfig(0, FCarteira, 'LIBPAG_', '');

    If fEmptyStr(edtLiberarPagamento.Text) Then
      edtLiberarPagamento.Text := 'S';
  End;

  If pnlRelatorioPorInconsistencia.Visible Then
  Begin
    edtRelatorioPorInconsistencia.Text := fGetBancoConfig(0, FCarteira, 'REL_MOTIVO_INCONS', '');
    If fEmptyStr(edtRelatorioPorInconsistencia.Text) Then
      edtRelatorioPorInconsistencia.Text := 'N';
  End;

  If Not fEmptyStr(fGetBancoConfig(0, FCarteira, 'AVISOFA', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, FCarteira, 'AVISOFA', '')) Of
      0 : cmbAvisoFavorecido.ItemIndex := 0;
      2 : cmbAvisoFavorecido.ItemIndex := 1;
      5 : cmbAvisoFavorecido.ItemIndex := 2;
      6 : cmbAvisoFavorecido.ItemIndex := 3;
      7 : cmbAvisoFavorecido.ItemIndex := 4;
    End;
  End
  Else
    cmbAvisoFavorecido.ItemIndex := -1;

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor)
  Else
    edtDesPor.Text := '';

  If Not fEmptyStr( fraPlanoDeContas.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta)
  Else
    fraPlanoDeContas.edtDesCta.Text := '';

  If Not fEmptyStr( edtCodEve.Text ) Then
    pCarregaEvento(edtCodEve.Text, edtDesEve)
  Else
    edtDesEve.Text := '';

  If FBancoAPI Then
    CarregaDadosAutorizacao;
end;

procedure TfrmConfigPagFor.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do registro da carteira selecionada?', ['&S i m', '&N ã o'], 2) = 1 then
  begin
    btnCancelar.Visible   := False;
    btnEditar.Visible     := True;
    pnlAtivo1.Enabled     := False;
    pnlAtivo2.Enabled     := False;
    btnEditar.Visible     := True;
    btnGravar.Enabled     := False;
    btnConfigurar.Enabled := False;
    pCarregaDados;
    pSetFocus(btnEditar);
  end;

end;

procedure TfrmConfigPagFor.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := strCodBco;
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;
end;

procedure TfrmConfigPagFor.btnEditarClick(Sender: TObject);
begin
  If ((Not fVerificaDireitoAutBan('PERCARBAN')) and (strLoginUsuarioLogado <> '999')) Then
  begin
    fMensagem('ATENÇÃO','Usuário sem permissão!', ['&Ok ']);
    Exit;
  end
  else
  begin
    pnlAtivo1.Enabled     := True;
    pnlAtivo2.Enabled     := True;
    btnGravar.Enabled     := True;
    btnEditar.Visible     := False;
    btnCancelar.Visible   := true;
    btnConfigurar.Enabled := True;

    If edtProxNumArqRem.Enabled Then
      pSetFocus(edtProxNumArqRem)
    Else
      pSetFocus(edtCodConv);

  end;

end;

procedure TfrmConfigPagFor.btnGravarClick(Sender: TObject);
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

      fGetBancoConfig(1, FCarteira, 'PROXNUM', edtProxNumArqRem.Text);
      fGetBancoConfig(1, FCarteira, 'NUMCART', edtNumCart.Text      );
      fGetBancoConfig(1, FCarteira, 'CONVENI', edtCodConv.Text      );
      fGetBancoConfig(1, FCarteira, 'IDENTBC', edtIdentBanc.Text    );
      fGetBancoConfig(1, FCarteira, 'CODCART', edtCodCar.Text       );
      fGetBancoConfig(1, FCarteira, 'CODAGEN', edtCodAgencia.Text   );
      fGetBancoConfig(1, FCarteira, 'DIGAGEN', edtDigAge.Text       );
      fGetBancoConfig(1, FCarteira, 'NUMCTAC', edtContaCorr.Text    );
      fGetBancoConfig(1, FCarteira, 'OPERCONTA', edtOpeCon.Text    );
      fGetBancoConfig(1, FCarteira, 'DIGCTAC', edtDigCtaCor.Text    );
      fGetBancoConfig(1, FCarteira, 'PORBAI_', edtCodPor.Text       );
      fGetBancoConfig(1, FCarteira, 'CTABAI_', fraPlanoDeContas.MskCodCta.Text   );
      fGetBancoConfig(1, FCarteira, 'EVECTP_', edtCodEve.Text       );
      fGetBancoConfig(1, FCarteira, 'DIACRED', edtDiasCred.Text     );
      fGetBancoConfig(1, FCarteira, 'PATHREM', fraPathRemessa.edtDirectory.text  );
      fGetBancoConfig(1, FCarteira, 'PATHRET', fraPathRetorno.edtDirectory.text  );
      fGetBancoConfig(1, FCarteira, 'AVISOFA', LeftStr(cmbAvisoFavorecido.Text,2));

      fGetBancoConfig(1, FCarteira, 'CODCOMPROMI', edtCodComp.Text  );
      fGetBancoConfig(1, FCarteira, 'CODPARTRAN', edtParTran.Text  );

      If edtSolicDataPag.Visible Then
        fGetBancoConfig(1, FCarteira, 'SOLICDT', edtSolicDataPag.Text);

      If edtLiberarPagamento.Visible Then
        fGetBancoConfig(1, FCarteira, 'LIBPAG_', edtLiberarPagamento.Text);

      If pnlRelatorioPorInconsistencia.Visible Then
        fGetBancoConfig(1, FCarteira, 'REL_MOTIVO_INCONS', edtRelatorioPorInconsistencia.Text);

      GravaDadosDeAutenticacao;

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        pBackupCnfBco;
        fMensagem('', 'Configurações salvas com sucesso.', ['&O K'], 1, True);
        pnlAtivo1.Enabled := False;
        pnlAtivo2.Enabled := False;
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

procedure TfrmConfigPagFor.btnInfoClick(Sender: TObject);
begin
  inherited;
  TConfigPagInfo.pShowInfo;
end;

procedure TfrmConfigPagFor.btnInfoEnter(Sender: TObject);
begin
  inherited;
  pShowHintBotao(btnInfo);
end;

procedure TfrmConfigPagFor.btnInfoExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigPagFor.btnInfoMouseEnter(Sender: TObject);
begin
  inherited;
  pShowHintBotao(btnInfo);
end;

procedure TfrmConfigPagFor.btnInfoMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigPagFor.CarregaDadosAutorizacao;
begin
  fraPagForAPIAutenticacao.edtChaveAppDev.Clear;
  If (fGetBancoConfig(0, FCarteira, 'KEY_USER', '') <> '') Then
    fraPagForAPIAutenticacao.edtChaveAppDev.Text := 'Chave App cadastrada';

  fraPagForAPIAutenticacao.edtChaveBasic.Clear;
  If (fGetBancoConfig(0, FCarteira, 'AUTHORIZATION', '') <> '') Then
    fraPagForAPIAutenticacao.edtChaveBasic.Text := 'Autorização Basic cadastrada';

  fraPagForAPIAutenticacao.edtArquivoPFX.Clear;
  If fGetBancoConfig(0, FCarteira, 'AUTHPFX', '') <> '' Then
    fraPagForAPIAutenticacao.edtArquivoPFX.Text := 'certificado cadastrado';

  fraPagForAPIAutenticacao.edtClientId.Text := fGetBancoConfig(0, FCarteira, 'CLIENT_ID', '');
  fraPagForAPIAutenticacao.edtClientSecret.Text := fGetBancoConfig(0, FCarteira, 'CLIENT_SECRET', '');
  fraPagForAPIAutenticacao.edtSenhaCertificado.Text := fGetBancoConfig(0, FCarteira, 'AUTHSEN', '');
  fraPagForAPIAutenticacao.edtValidadeCertificado.Text := fGetBancoConfig(0, FCarteira, 'VALCERT', '');

  If Not fEmptyStr(fraPagForAPIAutenticacao.edtValidadeCertificado.Text) Then
  Begin
    If StrToDateDef(fraPagForAPIAutenticacao.edtValidadeCertificado.Text,0) <= IncDay(VS_Date,30) Then
    Begin
      fMensagem('ATENÇÃO','O certificado digital está próximo da data de validade, considere realizar a renovação!',['&O K']);
    End;
  End;

  fraPagForAPIAutenticacao.lblAmbienteAPI.Caption := 'PRODUÇÃO';
  fraPagForAPIAutenticacao.lblAmbienteAPI.Font.Color := clBlue;
  If fGetBancoConfig(0, FCarteira, 'HOMOLOGACAO', '') = 'S' Then
  Begin
    fraPagForAPIAutenticacao.lblAmbienteAPI.Caption := 'HOMOLOGAÇÃO';
    fraPagForAPIAutenticacao.lblAmbienteAPI.Font.Color := clRed;
  End;
end;

procedure TfrmConfigPagFor.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Últ. Número       :' + fGetBancoConfig(0, FCarteira, 'PROXNUM', ''));
  stlCampos.Add('Núm. Carteira     :' + fGetBancoConfig(0, FCarteira, 'NUMCART', ''));
  stlCampos.Add('Cód. Convênio     :' + fGetBancoConfig(0, FCarteira, 'CONVENI', ''));
  stlCampos.Add('Cód. Carteira     :' + fGetBancoConfig(0, FCarteira, 'CODCART', ''));
  stlCampos.Add('Exibir o motivo no relatório de inconsistência da importação:' + fGetBancoConfig(0, FCarteira, 'REL_MOTIVO_INCONS', ''));
  stlCampos.Add('Identif. Banco    :' + fGetBancoConfig(0, FCarteira, 'IDENTBC', ''));
  stlCampos.Add('Cód. agência      :' + fGetBancoConfig(0, FCarteira, 'CODAGEN', ''));
  stlCampos.Add('Dig. agência      :' + fGetBancoConfig(0, FCarteira, 'DIGAGEN', ''));
  stlCampos.Add('Número C/C        :' + fGetBancoConfig(0, FCarteira, 'NUMCTAC', ''));
  stlCampos.Add('Dígito C/C        :' + fGetBancoConfig(0, FCarteira, 'DIGCTAC', ''));
  stlCampos.Add('Portador de Baixa :' + fGetBancoConfig(0, FCarteira, 'PORBAI_', ''));
  stlCampos.Add('Conta de Baixa    :' + fGetBancoConfig(0, FCarteira, 'CTABAI_', ''));
  stlCampos.Add('Evento de CTP     :' + fGetBancoConfig(0, FCarteira, 'EVECTP_', ''));
  stlCampos.Add('Dias para Crédito :' + fGetBancoConfig(0, FCarteira, 'DIACRED', ''));
  stlCampos.Add('Arquivo Remessa   :' + fGetBancoConfig(0, FCarteira, 'PATHREM', ''));
  stlCampos.Add('Arquivo retorno   :' + fGetBancoConfig(0, FCarteira, 'PATHRET', ''));

  stlCampos.Add('Código de Compromisso   :'  + fGetBancoConfig(0, FCarteira, 'CODCOMPROMI', ''));
  stlCampos.Add('Parâmetro de Transmissão: ' + fGetBancoConfig(0, FCarteira, 'CODPARTRAN', ''));
  stlCampos.Add('Operação da Conta: ' + fGetBancoConfig(0, FCarteira, 'OPERCONTA', ''));

end;

procedure TfrmConfigPagFor.pGravaLogCarteira(stlCfgAnt : TStringList);
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

procedure TfrmConfigPagFor.pHideHint;
begin
  HintController.HideHint;
end;

procedure TfrmConfigPagFor.pShowHintBotao(btnBotao: TBitBtnLocked);
begin
  HintController
   .ShowHint(btnBotao.ClientOrigin.X,btnBotao.ClientOrigin.Y, 'Regras da Baixa Automática', btnBotao.Hint);

              {Self.Left + btnBotao.Left
              , Self.Top + Self.Height - 22 + btnBotao.Top
              , 'Regras da Baixa Automática', btnBotao.Hint}
end;

end.
