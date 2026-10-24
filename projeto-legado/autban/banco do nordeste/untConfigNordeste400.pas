unit untConfigNordeste400;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Mask, DirectoryEditFocus, Buttons,
  ExtCtrls, QColorLabel, Menus, ComCtrls, ShellApi, AppEvnts, Uni, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, StrUtils,
  cxTextEdit, cxMaskEdit, cxButtonEdit, ComboBoxFocus, dxScreenTip, cxClasses,
  dxCustomHint, cxHint, 
  untFrameDirectoryEditFocus, untFramePlanoDeContasMaskEdit, dxBarBuiltInMenu,
  cxPC;

type
  TfrmConfigNordeste400 = class(TfrmPai)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
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
    lblCodCart: TLabel;
    lblProNum: TLabel;
    lblIdentBanco: TLabel;
    lblCodAgenc: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    lblResp: TLabel;
    ColorLabel1: TColorLabel;
    Label3: TLabel;
    Label1: TLabel;
    ColorLabel3: TColorLabel;
    Label13: TLabel;
    Label7: TLabel;
    Label24: TLabel;
    Label8: TLabel;
    Label14: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label17: TLabel;
    edtResp: TEditFocus;
    edtProxNumArqRem: TEditFocus;
    edtIdentBanc: TEditFocus;
    edtCodAgencia: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtProAce: TEditFocus;
    edtDigCta: TEditFocus;
    edtNumContr: TEditFocus;
    edtDiasProt: TEditFocus;
    cmbInstrucao1: TComboBoxFocus;
    cmbCodCar: TComboBoxFocus;
    edtObservacao1: TEditFocus;
    edtDiasCred: TEditFocus;
    edtObservacao2: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtObservacao5: TEditFocus;
    edtPerMul: TEditFocus;
    fraPathRetorno: TfraDirectoryEditFocus;
    fraPathRemessa: TfraDirectoryEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    procedure btnGravarClick(Sender: TObject);
    procedure pCarregaDados;
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
    procedure BtnOcorrenciaClick(Sender: TObject);
    procedure BtnOcorrenciaEnter(Sender: TObject);
    procedure BtnOcorrenciaMouseEnter(Sender: TObject);
    procedure BtnOcorrenciaMouseLeave(Sender: TObject);
    procedure BtnOcorrenciaExit(Sender: TObject);
    procedure ApplicationEventsDeactivate(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorRemKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;

    procedure pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pHabilitaDesabilitaCamposCorrespondente;
    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
    procedure pAlteraHintBotao(btnBotao: TBitBtnLocked; strNovoHint: String);
    procedure pShowHintBotao(btnBotao: TBitBtnLocked; strTitulo: String);
    procedure pHideHint;
  public
    blnNaoEditar: Boolean;
    strConfig   : String;
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigNordeste400: TfrmConfigNordeste400;

implementation

uses  untfuncoesSimples, untFuncoes, untPesqAux, untCfgGenericas_AutBan,
      untConsultas, untFuncoesGenerica, untTypesSistema, untMemo;

{$R *.dfm}

procedure TfrmConfigNordeste400.btnEditarClick(Sender: TObject);
begin
  If ((Not fVerificaDireitoAutBan('PERCARBAN')) and (strLoginUsuarioLogado <> '999')) Then
  begin
    fMensagem('ATENÇÃO','Usuário sem permissão!', ['&Ok ']);
    Exit;
  end
  else
  begin
    pnlAtivo.Enabled      := True;
    pnlComplemento.Enabled := pnlAtivo.Enabled;
    btnGravar.Enabled     := True;
    btnConfigurar.Enabled := True;
    btnEditar.Visible     := False;
    btnCancelar.Visible   := true;

    if edtProxNumArqRem.Enabled then
      pSetFocus(edtProxNumArqRem)
    else
      pSetFocus(edtNumContr);

  end;
end;

procedure TfrmConfigNordeste400.btnGravarClick(Sender: TObject);
Var
  stlCfgAnt : TStringList;
begin
  inherited;

  If fVerificaCampos Then
  Begin
    If blnNaoEditar Then
    Begin
      Close;
      ModalResult := mrOk;
      Exit;
    End;

    stlCfgAnt := TStringList.Create;
    pCarregaCfg(stlCfgAnt);

    Try
      fGetBancoConfig(1, 'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', edtProxNumArqRem.Text);
      fGetBancoConfig(1, 'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', LeftStr(cmbCodCar.Text,1));
      fGetBancoConfig(1, 'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtIdentBanc.Text    );
      fGetBancoConfig(1, 'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', edtDigCta.Text       );
      fGetBancoConfig(1, 'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text   );
      fGetBancoConfig(1, 'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text         );
      fGetBancoConfig(1, 'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', LeftStr(cmbInstrucao1.Text,2));
      fGetBancoConfig(1, 'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text  );
      fGetBancoConfig(1, 'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text  );
      fGetBancoConfig(1, 'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text  );
      fGetBancoConfig(1, 'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text  );
      fGetBancoConfig(1, 'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text  );
      fGetBancoConfig(1, 'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessa.edtDirectory.text  );
      fGetBancoConfig(1, 'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetorno.edtDirectory.text  );
      fGetBancoConfig(1, 'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text       );
      fGetBancoConfig(1, 'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text       );
      fGetBancoConfig(1, 'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContas.MskCodCta.Text       );
      fGetBancoConfig(1, 'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text     );
      fGetBancoConfig(1, 'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text       );
      fGetBancoConfig(1, 'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCONT', edtNumContr.Text     );
      fGetBancoConfig(1, 'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text     );
      fGetBancoConfig(1, 'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', edtPerMul.Text        );

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        pBackupCnfBco;
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        blnMudarFoco          := True;
        pnlAtivo.Enabled      := False;
        pnlComplemento.Enabled := pnlAtivo.Enabled;
        btnGravar.Enabled     := False;
        btnConfigurar.Enabled := False;
        btnEditar.Visible     := True;
        btnCancelar.Visible   := False;
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

procedure TfrmConfigNordeste400.pCarregaDados;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************AF*}
  edtProxNumArqRem.Enabled := True;
  edtProxNumArqRem.Text    := fGetBancoConfig(0,'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '');

  If Not fEmptyStr(fGetBancoConfig(0,'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', '')) Then
  Begin
    Case AnsiIndexStr((fGetBancoConfig(0,'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', '')), ['1','2','4','5','I']) Of
      0: cmbCodCar.ItemIndex := 0;
      1: cmbCodCar.ItemIndex := 1;
      2: cmbCodCar.ItemIndex := 2;
      3: cmbCodCar.ItemIndex := 3;
      4: cmbCodCar.ItemIndex := 4;
    End;
  End
  Else
    cmbCodCar.ItemIndex := -1;

  edtIdentBanc.Text     := fGetBancoConfig(0,'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', '');
  edtDigCta.Text        := fGetBancoConfig(0,'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', '');
  edtCodAgencia.Text    := fGetBancoConfig(0,'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtResp.Text          := fGetBancoConfig(0,'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', '');

  If Not fEmptyStr(fGetBancoConfig(0,'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '')) Then
  Begin
    Case AnsiIndexStr(fGetBancoConfig(0,'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', ''), ['05', '08', '12', '15', '00']) Of
      0: cmbInstrucao1.ItemIndex := 0;
      1: cmbInstrucao1.ItemIndex := 1;
      2: cmbInstrucao1.ItemIndex := 2;
      3: cmbInstrucao1.ItemIndex := 3;
      4: cmbInstrucao1.ItemIndex := 4;
    End;
  End
  Else
    cmbInstrucao1.ItemIndex := -1;

  edtDesPor.Text    := '';
  edtDescPorRem.Text := '';
  fraPlanoDeContas.edtDesCta.Text := '';
  edtObservacao1.Text   := fGetBancoConfig(0,'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text   := fGetBancoConfig(0,'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text   := fGetBancoConfig(0,'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text   := fGetBancoConfig(0,'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text   := fGetBancoConfig(0,'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');
  fraPathRemessa.edtDirectory.text   := fGetBancoConfig(0,'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '');
  fraPathRetorno.edtDirectory.text   := fGetBancoConfig(0,'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '');
  edtCodPor.Text        := fGetBancoConfig(0,'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  edtCodPorRem.Text      := fGetBancoConfig(0, 'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');
  fraPlanoDeContas.MskCodCta.Text        := fGetBancoConfig(0,'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');
  edtDiasCred.Text      := fGetBancoConfig(0,'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', '');
  edtProAce.Text        := fGetBancoConfig(0,'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', '');
  edtNumContr.Text      := fGetBancoConfig(0,'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCONT', '');
  edtDiasProt.Text      := fGetBancoConfig(0,'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '');
  edtPerMul.Text        := fGetBancoConfig(0,'CONFIG004-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', '');

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCodPorRem.Text ) Then
    pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);

  If Not fEmptyStr( fraPlanoDeContas.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);

  pHabilitaDesabilitaCamposCorrespondente;

  if edtProxNumArqRem.Text <> '' then edtProxNumArqRem.Enabled := False;

end;

procedure TfrmConfigNordeste400.FormShow(Sender: TObject);
begin
  inherited;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);  
  pCarregaDados;
  pSetFocus(edtProxNumArqRem);

  pSetFocus(btnEditar);

  if blnNaoEditar then
  begin
     pnlAtivo.Enabled      := False;
     pnlComplemento.Enabled := pnlAtivo.Enabled;
     btnConfigurar.Enabled := False;
     btnConfigurar.Visible := False;
     btnGravar.Enabled     := True;
     btnEditar.Visible     := False;
     pSetFocus(btnGravar);
  end;

end;

procedure TfrmConfigNordeste400.fraPlanoDeContasMskCodCtaKeyPress(
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

function TfrmConfigNordeste400.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
var
  strMensagemConfig: String;
  strRespCar: String;
Begin

  if blnNaoEditar then
     strMensagemConfig := #13 + 'Por favor acesse a tela de configuração do banco selecionado ' + #13  + ' e corrija as informações necessárias!'
  else
     strMensagemConfig := '';

  Result := True;

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
        fMensagem('','Os Campos de instruções devem ser preenchidos!'+strMensagemConfig,['&OK']);
        Result := False;
      End;

    End

    Else If Sender = edtResp Then
    Begin
      Case AnsiIndexStr(Copy(cmbCodCar.Text, 1 , 1), ['1', '2', '4', '5', 'I']) Of
        0: strRespCar := 'B';
        1: strRespCar := 'B';
        2: strRespCar := 'E';
        3: strRespCar := 'E';
        4: strRespCar := 'E';
      End;

      If (edtResp.Text <> 'B') And (edtResp.Text <> 'E') Then
      Begin
        fMensagem('','O campo Resp. por emissão de boletos deve ser B ou E!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

      if (edtResp.Text = 'E') then
      begin
        if (edtResp.Text <> strRespCar) then
        begin
          fMensagem('','O responsável pela emissão dos boletos não pode ser a empresa para a carteira selecionada!'+strMensagemConfig,['&O K']);
          Result := False;
        end;
      end;

      if (edtResp.Text = 'B') then
      begin
        if (edtResp.Text <> strRespCar) then
        begin
          fMensagem('','O responsável pela emissão dos boletos não pode ser o banco para a carteira selecionada!'+strMensagemConfig,['&O K']);
          Result := False;
        end;
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

    Else If (Sender = edtDiasProt) And
            (edtDiasProt.Enabled)  Then
    Begin
      If fEmptyStr(edtDiasProt.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Dias para protesto deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtNumContr) Then
    Begin
      If fEmptyStr(edtNumContr.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Número do contrato deve ser preenchido!'+strMensagemConfig,['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodAgencia) Then
    Begin
      If fEmptyStr(edtCodAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Código da Agência deve ser preenchido!'+strMensagemConfig,['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtIdentBanc) Then
    Begin
      If fEmptyStr(edtIdentBanc.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Conta Corrente deve ser preenchido!'+strMensagemConfig,['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigCta) Then
    Begin
      If fEmptyStr(edtDigCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Dígito da Conta Corrente deve ser preenchido!'+strMensagemConfig,['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = cmbCodCar)Then
    Begin
      If cmbCodCar.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Código da carteita deve ser informado!'+strMensagemConfig,['&Ok']);
        Result := False;
      End;
    End

  End;

  If Not Result Then
    if not blnNaoEditar then
        pSetFocus(Sender);

End;

procedure TfrmConfigNordeste400.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmConfigNordeste400.tabCarteiraChanging(Sender: TObject;
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

procedure TfrmConfigNordeste400.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
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

procedure TfrmConfigNordeste400.edtCodPorRemKeyPress(Sender: TObject;
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

procedure TfrmConfigNordeste400.pAlteraHintBotao(btnBotao: TBitBtnLocked;
  strNovoHint: String);
begin
   btnBotao.Hint := strNovoHint;
end;

procedure TfrmConfigNordeste400.pCarregaCentroCusto(strCtaBai: String;
  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmConfigNordeste400.pCarregaPortador(strCodPor: String;
  edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtLabel.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmConfigNordeste400.pGravaLogCarteira(stlCfgAnt: TStringList);
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
    pGravaLogAtb('004', 'NORDESTE', strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

procedure TfrmConfigNordeste400.pHabilitaDesabilitaCamposCorrespondente;
begin
end;

procedure TfrmConfigNordeste400.pHideHint;
begin
   HintControler.HideHint;
end;

procedure TfrmConfigNordeste400.pShowHintBotao(btnBotao: TBitBtnLocked;
  strTitulo: String);
begin
  HintControler.ShowHint(btnBotao.ClientOrigin.X,btnBotao.ClientOrigin.Y, strTitulo, btnBotao.Hint);
end;

procedure TfrmConfigNordeste400.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Seq. Remessa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  stlCampos.Add('Num. Contrato     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCONT', ''));
  stlCampos.Add('Código Agência    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Num. C. Corrente  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  stlCampos.Add('Dig. C. Corrente  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', ''));
  stlCampos.Add('Cód. Instrução 1  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', ''));
  stlCampos.Add('Cód. Carteira     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', ''));
  stlCampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  stlCampos.Add('Percentual Multa  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', ''));
  stlCampos.Add('Dias p/ protesto  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  stlCampos.Add('Observação 1      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Observação 3      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  stlCampos.Add('Observação 4      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  stlCampos.Add('Observação 5      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  stlCampos.Add('Arquivo Remessa   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo Retorno   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  stlCampos.Add('Resp. Emissão Bol :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', ''));
  stlCampos.Add('Protocolo Aceite  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', ''));
  stlCampos.Add('Portador de Baixa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Portador da remessa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', ''));
  stlCampos.Add('Conta Baixa       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
end;

procedure TfrmConfigNordeste400.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  pCarKeyAutBan;
  cxPaginas.Properties.ActivePage := tbsGeral;
end;

procedure TfrmConfigNordeste400.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigNordeste400.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigNordeste400.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do registro da carteira selecionada?', ['&S i m', '&N ã o'], 2) = 1 then
  begin
    btnCancelar.Visible   := False;
    btnEditar.Visible     := True;
    pnlAtivo.Enabled      := False;
    pnlComplemento.Enabled := pnlAtivo.Enabled;
    btnEditar.Visible     := True;
    btnGravar.Enabled     := False;
    btnConfigurar.Enabled := False;
    pSetFocus(btnEditar);
    pCarregaDados;
  end;
end;

procedure TfrmConfigNordeste400.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '004';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;
end;

procedure TfrmConfigNordeste400.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile   := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\004400p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\004400p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigNordeste400.BtnOcorrenciaClick(Sender: TObject);
Var
    strDetalhe : String;
begin
  inherited;
  pHideHint;

  strDetalhe := #13#10 +
                '02 - Entrada Confirmada; ' + #13#10 +
                '06 - Liquidação Normal; ' + #13#10 +
                '09 - Baixa Simples;' + #13#10 +
                '15 - Baixa Automática.' + #13#10 +
                'As demais ocorrências são gravadas na rotina ' +
                'de retorno e mostradas no relatório apenas em ' +
                'caráter informativo.'+ #13#10 +
                #13#10 +
                'Pressione Esc para voltar à tela de configurações.';

  TfrmMemo.pShowMessage('Banco 004 - Banco do Nordeste - Detalhamento de Ocorrências.' + #13#10 +
                        strDetalhe);
end;

procedure TfrmConfigNordeste400.BtnOcorrenciaEnter(Sender: TObject);
begin
  inherited;
  pAlteraHintBotao(btnOcorrencia, 'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
                                  'que são tratados pelas rotinas do sistema.');
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigNordeste400.BtnOcorrenciaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigNordeste400.BtnOcorrenciaMouseEnter(Sender: TObject);
begin
  inherited;
  pAlteraHintBotao(btnOcorrencia, 'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
                                  'que são tratados pelas rotinas do sistema.');
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigNordeste400.BtnOcorrenciaMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

end.
