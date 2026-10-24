unit untConfigBradescoCta240;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, DirectoryEditFocus, StdCtrls, EditFocus, Buttons,
  ExtCtrls, QColorLabel, Menus, ComCtrls, ShellApi, Uni, AppEvnts, BitBtnLockedIncrem,
  untTypesSistema, frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, strUtils, untConstantes,
  cxTextEdit, cxMaskEdit, cxButtonEdit, ComboBoxFocus, 
  untFrameDirectoryEditFocus, untFramePlanoDeContasMaskEdit, untConfigPagInfo,
  dxScreenTip, cxClasses, dxCustomHint, cxHint;

type
  TfrmConfigBradescoCta240 = class(TfrmPai)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
    pnlAtivo: TPanel;
    lblCodAgenc: TLabel;
    lblIdentBanco: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    Label1: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblProNum: TLabel;
    edtCodAgencia: TEditFocus;
    edtCodConv: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtProxNumArqRem: TEditFocus;
    fraPathRemessa: TfraDirectoryEditFocus;
    fraPathRetorno: TfraDirectoryEditFocus;
    Label6: TLabel;
    lblContCorr: TLabel;
    edtDigCtaCor: TEditFocus;
    edtContaCorr: TEditFocus;
    Label3: TLabel;
    edtDigAge: TEditFocus;
    Label4: TLabel;
    edtSeqArq: TEditFocus;
    btnCancelar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    BtnManual: TBitBtnLocked;
    GroupBox1: TGroupBox;
    cmbAvisoFavorecido: TComboBoxFocus;
    Label11: TLabel;
    cmbMovimento: TComboBoxFocus;
    lblMovimento: TLabel;
    clDsName: TColorLabel;
    edtDsName: TEditFocus;
    lblDsName: TLabel;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    chkPagamentoSalarios: TCheckBox;
    btnInfo: TBitBtnLocked;
    HintController: TcxHintStyleController;
    cblQuebraLinha: TColorLabel;
    lblQuebraLinha: TLabel;
    edtQuebraArqTrailer: TEditFocus;
    lblSolicDataPag: TLabel;
    edtSolicDataPag: TEditFocus;
    lblInfoSolicDataPag: TColorLabel;
    cbCaracterQuebraLinha: TComboBoxFocus;
    procedure pCarregaDados;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pCarregaCentroCusto(strCtaBai: String; edtLabel: TEdit);
    procedure tabCarteiraChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure BtnManualClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure btnInfoClick(Sender: TObject);
    procedure btnInfoEnter(Sender: TObject);
    procedure btnInfoExit(Sender: TObject);
    procedure btnInfoMouseEnter(Sender: TObject);
    procedure btnInfoMouseLeave(Sender: TObject);
    procedure edtQuebraArqTrailerChange(Sender: TObject);
    procedure cbCaracterQuebraLinhaEnter(Sender: TObject);
    procedure cbCaracterQuebraLinhaMouseEnter(Sender: TObject);
    procedure cbCaracterQuebraLinhaMouseLeave(Sender: TObject);
    procedure cbCaracterQuebraLinhaExit(Sender: TObject);
  private
    { Private declarations }
    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;

    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
    procedure pHideHint;
    procedure pShowHintBotao(btnBotao: TBitBtnLocked);
    procedure ShowHintComboBox(AComboBox: TComboBoxFocus; ATitulo: String; AHint:String);
  public
    { Public declarations }
    blnNaoEditar: Boolean;
    strConfig   : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigBradescoCta240: TfrmConfigBradescoCta240;

implementation

uses untfuncoesSimples,  untPesqAux,  untFuncoes,
  untCfgGenericas_AutBan, untConsultas;

{$R *.dfm}

procedure TfrmConfigBradescoCta240.pCarregaDados;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************KP*}
  If fEmptyStr(fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '')) Then
  Begin
    edtProxNumArqRem.Enabled := True;
    edtProxNumArqRem.Clear;
    pSetFocus(edtProxNumArqRem);
  End
  Else
  Begin
    edtProxNumArqRem.Text  := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '');
    edtProxNumArqRem.Enabled := False;
    pSetFocus(edtSeqArq);
  End;

  if (strLoginUsuarioLogado='997') or(strLoginUsuarioLogado='998') or (strLoginUsuarioLogado='999') Then
  begin
    edtProxNumArqRem.Enabled := True;
    pSetFocus(edtProxNumArqRem);
  End;

  edtDsName.Text := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'DSNAME', '');
  If fEmptyStr(edtDsName.Text) Then
    edtDsName.Text := 'N';

  edtQuebraArqTrailer.Text := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'QUEBRALINTRAILER', '');
  If fEmptyStr(edtQuebraArqTrailer.Text) Then
    edtQuebraArqTrailer.Text := 'S';

  edtQuebraArqTrailerChange(edtQuebraArqTrailer);

  edtCodConv.Text         := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CONVENI', '');
  edtCodAgencia.Text      := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtDigAge.Text          := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', '');
  edtContaCorr.Text       := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', '');
  edtDigCtaCor.Text       := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', '');
  edtCodPor.Text          := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  fraPlanoDeContas.MskCodCta.Text          := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');
  edtObservacao1.Text     := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text     := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  fraPathRemessa.edtDirectory.text     := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '');
  fraPathRetorno.edtDirectory.text     := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '');
  edtSeqArq.Text          := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQARQU', '');

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'AVISOFA', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'AVISOFA', '')) Of
      0 : cmbAvisoFavorecido.ItemIndex := 0;
      2 : cmbAvisoFavorecido.ItemIndex := 1;
      5 : cmbAvisoFavorecido.ItemIndex := 2;
      6 : cmbAvisoFavorecido.ItemIndex := 3;
      7 : cmbAvisoFavorecido.ItemIndex := 4;
    End;
  End
  Else
    cmbAvisoFavorecido.ItemIndex := -1;

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CARACTERQUEBRALINHA', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CARACTERQUEBRALINHA', '')) Of
     -1 : cbCaracterQuebraLinha.ItemIndex := -1;
      0 : cbCaracterQuebraLinha.ItemIndex :=  0;
      1 : cbCaracterQuebraLinha.ItemIndex :=  1;
    End;
  End
  Else
    cbCaracterQuebraLinha.ItemIndex := -1;

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODMOVI', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODMOVI', '')) Of
      00 : cmbMovimento.ItemIndex := 0;
      09 : cmbMovimento.ItemIndex := 1;
    End;
  End
  Else
    cmbMovimento.ItemIndex := 0;

  chkPagamentoSalarios.Checked := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CONVSAL', '') = 'S';


  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( fraPlanoDeContas.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);

  edtSolicDataPag.Text := fGetBancoConfig(0, 'CONFIGCTA237_240p-'+ IntToStr(tabCarteira.TabIndex + 1), 'SOLICDT', '');
  If fEmptyStr(edtSolicDataPag.Text) Then
    edtSolicDataPag.Text := 'N';

end;

procedure TfrmConfigBradescoCta240.FormShow(Sender: TObject);
begin
  inherited;

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

procedure TfrmConfigBradescoCta240.btnEditarClick(Sender: TObject);
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
      pSetFocus(edtCodConv);

  end;
end;

procedure TfrmConfigBradescoCta240.btnGravarClick(Sender: TObject);
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

      fGetBancoConfig(1, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', edtProxNumArqRem.Text);
      fGetBancoConfig(1, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQARQU', edtSeqArq.Text);
      fGetBancoConfig(1, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CONVENI', edtCodConv.Text    );
      fGetBancoConfig(1, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text   );
      fGetBancoConfig(1, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', edtDigAge.Text   );
      fGetBancoConfig(1, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text    );
      fGetBancoConfig(1, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'DSNAME', edtDsName.Text         );
      fGetBancoConfig(1, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'QUEBRALINTRAILER', edtQuebraArqTrailer.Text);
      fGetBancoConfig(1, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CARACTERQUEBRALINHA', cbCaracterQuebraLinha.ItemIndex.ToString());
      fGetBancoConfig(1, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', edtDigCtaCor.Text    );
      fGetBancoConfig(1, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text       );
      fGetBancoConfig(1, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContas.MskCodCta.Text       );
      fGetBancoConfig(1, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text);
      fGetBancoConfig(1, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text);
      fGetBancoConfig(1, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessa.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetorno.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'AVISOFA', LeftStr(cmbAvisoFavorecido.Text,2));
      fGetBancoConfig(1, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODMOVI', LeftStr(cmbMovimento.Text,2));

      fGetBancoConfig(1, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CONVSAL', IIF(chkPagamentoSalarios.Checked, 'S', 'N'));
      fGetBancoConfig(1, 'CONFIGCTA237_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'SOLICDT', edtSolicDataPag.Text);

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

procedure TfrmConfigBradescoCta240.btnInfoClick(Sender: TObject);
begin
  inherited;
  TConfigPagInfo.pShowInfo;
end;

procedure TfrmConfigBradescoCta240.btnInfoEnter(Sender: TObject);
begin
  inherited;
  pShowHintBotao(btnInfo);
end;

procedure TfrmConfigBradescoCta240.btnInfoExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBradescoCta240.btnInfoMouseEnter(Sender: TObject);
begin
  inherited;
  pShowHintBotao(btnInfo);
end;

procedure TfrmConfigBradescoCta240.btnInfoMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBradescoCta240.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
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

function TfrmConfigBradescoCta240.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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

    Else If (Sender = edtSolicDataPag) Then
    Begin
      If Pos(edtSolicDataPag.Text, 'SN') = 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Solicita Data de Pagamento" deve ser preenchido com S ou N!', ['&O K']);
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

    Else If Sender = edtDsName Then
    Begin
      If Pos(edtDsName.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Utl. Nomenclatura DSNAME? deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtQuebraArqTrailer Then
    Begin
      If Pos(edtQuebraArqTrailer.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo  Inserir quebra de linha no trailer do arquivo? deve ser preenchido com (S/N)!',['&O K']);
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
        fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser informado!'+strMensagemConfig,['&O K']);
        fraPlanoDeContas.edtDesCta.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);
        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!' + strMensagemConfig,['&O K']);
          Result := False;
        End
        Else If Not PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text) Then
          Result := False;
      End;

    End

    Else If (Sender = cmbAvisoFavorecido) Then
    Begin
      If cmbAvisoFavorecido.ItemIndex = -1 Then
      Begin
        fMensagem('','O Campo de Aviso ao Favorecido deve ser preenchido!' + strMensagemConfig,['&OK']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    if not blnNaoEditar then
      pSetFocus(Sender);
End;

procedure TfrmConfigBradescoCta240.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
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

procedure TfrmConfigBradescoCta240.edtQuebraArqTrailerChange(Sender: TObject);
begin
  inherited;
  If Trim(edtQuebraArqTrailer.Text).Equals('S') Then
  Begin
    cbCaracterQuebraLinha.Enabled := True;

    If cbCaracterQuebraLinha.ItemIndex = -1 Then
      cbCaracterQuebraLinha.ItemIndex := 0;

  End
  Else
  Begin
    cbCaracterQuebraLinha.ItemIndex := -1;
    cbCaracterQuebraLinha.Enabled := False;
  End;
end;

procedure TfrmConfigBradescoCta240.pCarregaPortador(strCodPor: String; edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtDesPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;

end;

procedure TfrmConfigBradescoCta240.pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;

end;

procedure TfrmConfigBradescoCta240.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmConfigBradescoCta240.tabCarteiraChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  if btnCancelar.Visible then
  begin
    btnCancelar.Click;
    if btnCancelar.Visible then
      AllowChange := False;
  end;
end;

procedure TfrmConfigBradescoCta240.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  pCarKeyAutBan;
end;

procedure TfrmConfigBradescoCta240.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigBradescoCta240.btnCancelarClick(Sender: TObject);
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

procedure TfrmConfigBradescoCta240.btnConfigurarClick(Sender: TObject);
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

procedure TfrmConfigBradescoCta240.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\237240p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\237240p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigBradescoCta240.cbCaracterQuebraLinhaEnter(Sender: TObject);
begin
  inherited;
  ShowHintComboBox(cbCaracterQuebraLinha,'Carácter de controle para quebra de linha do trailer',
                                         'CR - Move o cursor para o início da linha.' + #10#13 +
                                         'CR LF - Move o cursor para o início da linha e avança para a próxima linha.');
end;

procedure TfrmConfigBradescoCta240.cbCaracterQuebraLinhaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBradescoCta240.cbCaracterQuebraLinhaMouseEnter(
  Sender: TObject);
begin
  inherited;
  ShowHintComboBox(cbCaracterQuebraLinha,'Carácter de controle para quebra de linha do trailer',
                                         'CR - Move o cursor para o início da linha.' + #10#13 +
                                         'CR LF - Move o cursor para o início da linha e avança para a próxima linha.');
end;

procedure TfrmConfigBradescoCta240.cbCaracterQuebraLinhaMouseLeave(
  Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBradescoCta240.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Seq. Remessa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  stlCampos.Add('Seq. Envio Arquivo:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SEQARQU', ''));
  stlCampos.Add('Código Convênio   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CONVENI', ''));
  stlCampos.Add('Código Agência    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Dígito Agência    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', ''));
  stlCampos.Add('Num. C. Corrente  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  stlCampos.Add('Dig. C. Corrente  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', ''));
  stlCampos.Add('Portador de Baixa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Conta Baixa       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Observação 1      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Arquivo Remessa   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo Retorno   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  stlCampos.Add('Utilizar Nomenclatura DSNAME?   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DSNAME', ''));
  stlCampos.Add('Inserir quebra de linha no trailer do arquivo?   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'QUEBRALINTRAILER', ''));
  stlCampos.Add('Solicita Data de Pagamento ao gerar remessa:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SOLICDT', ''));
  stlCampos.Add('Caracter de quebra de linha do trailer   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CARACTERQUEBRALINHA', ''));
end;

procedure TfrmConfigBradescoCta240.pGravaLogCarteira(stlCfgAnt : TStringList);
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
    pGravaLogAtb('237', 'BRADESCO CTA 240', strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

procedure TfrmConfigBradescoCta240.pHideHint;
begin
  HintController.HideHint;
end;

procedure TfrmConfigBradescoCta240.pShowHintBotao(btnBotao: TBitBtnLocked);
begin
  HintController
   .ShowHint(btnBotao.ClientOrigin.X,btnBotao.ClientOrigin.Y, 'Regras da Baixa Automática', btnBotao.Hint);
end;

procedure TfrmConfigBradescoCta240.ShowHintComboBox(AComboBox: TComboBoxFocus;
  ATitulo: String; AHint:String);
begin
  HintController.ShowHint(AComboBox.ClientOrigin.X,AComboBox.ClientOrigin.Y, ATitulo, AHint);
end;

end.
