unit untConfigSafra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Mask, DirectoryEditFocus,
  Buttons, ExtCtrls, QColorLabel, Menus, ComCtrls, ShellApi, AppEvnts, Uni,
  cxHint, BitBtnLockedIncrem, dxScreenTip, cxClasses, dxCustomHint,
  untTypesSistema, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus, untFramePlanoDeContasMaskEdit, dxBarBuiltInMenu,
  cxPC;

type
  TfrmConfigSafra = class(TfrmPai)
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
    lblCodCart: TLabel;
    lblProNum: TLabel;
    lblCodAgenc: TLabel;
    lblContCorr: TLabel;
    lblDiasProt: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    lblResp: TLabel;
    ColorLabel1: TColorLabel;
    Label13: TLabel;
    ColorLabel3: TColorLabel;
    lblIdentCed: TLabel;
    lblUsoCli: TLabel;
    lbl1: TLabel;
    Label5: TLabel;
    ColorLabel2: TColorLabel;
    Label22: TLabel;
    Label17: TLabel;
    Label27: TLabel;
    lblParNum: TLabel;
    ColorLabel8: TColorLabel;
    edtProxNumArqRem: TEditFocus;
    edtDiasProt: TEditFocus;
    edtContaCorr: TEditFocus;
    edtCodCar: TEditFocus;
    edtCodAgencia: TEditFocus;
    edtInstrucao1: TEditFocus;
    edtInstrucao2: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtObservacao5: TEditFocus;
    edtDiasCred: TEditFocus;
    edtResp: TEditFocus;
    edtProAce: TEditFocus;
    edtIdentCed: TEditFocus;
    edtUsoCliente: TEditFocus;
    edtInfAdi: TEditFocus;
    fraPathRetorno: TfraDirectoryEditFocus;
    fraPathRemessa: TfraDirectoryEditFocus;
    edtCorrBradesco: TEditFocus;
    edtCarBra: TEditFocus;
    edtPerMul: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtEmpBol: TEditFocus;
    edtParNum: TEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    procedure btnGravarClick(Sender: TObject);
    procedure pCarregaDados;
    procedure FormShow(Sender: TObject);
    procedure tabCarteiraChange(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure BtnManualClick(Sender: TObject);
    procedure edtCodCarEnter(Sender: TObject);
    procedure edtCodCarExit(Sender: TObject);
    procedure edtInstrucao1Enter(Sender: TObject);
    procedure edtInstrucao1Exit(Sender: TObject);
    procedure edtContaCorrExit(Sender: TObject);
    procedure edtCodCarChange(Sender: TObject);
    procedure edtIdentCedEnter(Sender: TObject);
    procedure edtIdentCedExit(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure BtnOcorrenciaClick(Sender: TObject);
    procedure BtnOcorrenciaEnter(Sender: TObject);
    procedure BtnOcorrenciaExit(Sender: TObject);
    procedure ApplicationEventsDeactivate(Sender: TObject);
    procedure edtEmpBolKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorRemKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;
    qryCadEmp : TUniQuery;

    procedure pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pShowHint(edtEdit: TEditFocus; strTitulo: String);
    procedure pHideHint;
    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
    procedure pShowHintBotao(btnBotao: TBitBtnLocked; strTitulo: String);
    procedure pAlteraHintBotao(btnBotao: TBitBtnLocked; strNovoHint: String);
    procedure pCarregaEmpresa(strCodEmp: String; edtLabel: TEdit);
  public
    { Public declarations }
    blnNaoEditar: Boolean;
    strConfig : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigSafra: TfrmConfigSafra;

implementation

uses  untfuncoesSimples, untFuncoes,
     untPesqAux, untCfgGenericas_AutBan, untConsultas, untMemo;

{$R *.dfm}

procedure TfrmConfigSafra.btnEditarClick(Sender: TObject);
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
      pSetFocus(edtCodCar);

  end;

end;

procedure TfrmConfigSafra.btnGravarClick(Sender: TObject);
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

      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', edtProxNumArqRem.Text);
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', edtCodCar.Text       );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text   );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text    );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text     );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text         );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', edtInstrucao1.Text   );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', edtInstrucao2.Text   );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessa.edtDirectory.text  );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetorno.edtDirectory.text  );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text       );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text       );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContas.MskCodCta.Text       );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text  );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text  );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text  );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text  );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text  );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text     );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text       );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'IDENCED', edtIdentCed.Text     );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'USOCLIE', edtUsoCliente.Text   );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text       );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'CORBRAD', edtCorrBradesco.Text );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'INDBRAD', edtCarBra.Text       );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', edtPerMul.Text       );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'EMPRBOL', edtEmpBol.Text       );
      fGetBancoConfig(1, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'PARCNUM', edtParNum.Text       );

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

procedure TfrmConfigSafra.pCarregaDados;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************AF*}
  edtPerMul.Text        := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'PERMULT', '');
  edtProxNumArqRem.Text := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'PROXNUM','');
  edtCodCar.Text        := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'CODCART','');
  edtCodAgencia.Text    := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'CODAGEN','');
  edtContaCorr.Text     := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'NUMCTAC','');
  edtDiasProt.Text      := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'DIAPROT','');
  edtResp.Text          := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'RESPONS','');
  edtInstrucao1.Text    := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU1','');
  edtInstrucao2.Text    := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU2','');
  edtObservacao1.Text   := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'OBSERV1','');
  edtObservacao2.Text   := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'OBSERV2','');
  edtObservacao3.Text   := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'OBSERV3','');
  edtObservacao4.Text   := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'OBSERV4','');
  edtObservacao5.Text   := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'OBSERV5','');
  fraPathRemessa.edtDirectory.text   := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'PATHREM','');
  fraPathRetorno.edtDirectory.text   := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'PATHRET','');
  edtCodPor.Text        := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'PORBAI_','');
  edtCodPorRem.Text      := fGetBancoConfig(0, 'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');
  fraPlanoDeContas.MskCodCta.Text        := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'CTABAI_','');
  edtDiasCred.Text      := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'DIACRED','');
  edtProAce.Text        := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'PROACEI','');
  edtIdentCed.Text      := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'IDENCED','');
  edtUsoCliente.Text    := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'USOCLIE','');
  edtInfAdi.Text        := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'INFADIC','');
  edtCorrBradesco.Text  := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'CORBRAD','');
  edtCarBra.Text        := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'INDBRAD','');
  edtEmpBol.Text        := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'EMPRBOL','');
  edtParNum.Text        := fGetBancoConfig(0,'CONFIG422-' + IntToStr(tabCarteira.TabIndex + 1),'PARCNUM',' ');

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCodPorRem.Text ) Then
    pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);

  If Not fEmptyStr( fraPlanoDeContas.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);

  If Not fEmptyStr( edtEmpBol.Text ) Then
    pCarregaEmpresa(edtEmpBol.Text, edtDesEmpresa);

  edtParNum.Enabled := (edtResp.Text = 'E');
  edtParNum.Text := IIF((edtResp.Text = 'E'),IIF(fEmptyStr(edtParNum.Text),'N',edtParNum.Text),'N');

end;

procedure TfrmConfigSafra.FormShow(Sender: TObject);
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

procedure TfrmConfigSafra.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
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

function TfrmConfigSafra.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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

    Else If (Sender = edtCodCar) Then
    Begin

      If fEmptyStr(edtCodCar.Text) Then
      Begin
        fMensagem('', 'Carteira deve ser preenchida!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else If Pos(edtCodCar.Text,'1249') <= 0 Then
      Begin
        fMensagem('', 'Carteira não permitida!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtInstrucao1) Then
    Begin

      If fEmptyStr(edtInstrucao1.Text) Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else If (Pos(edtInstrucao1.Text, '00_01_02_03_04_06_07_08_16_90') <= 0) Then
      Begin
        fMensagem('','O campo Instrução 1 deve ser preenchido com 00, 01, 02, 03, 04 ,06, 07, 08, 16 ou 90!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtInstrucao2) Then
    Begin

      If fEmptyStr(edtInstrucao2.Text) Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!'+strMensagemConfig,['&O K']);
        Result := False;
      End
       Else If (Pos(edtInstrucao2.Text, '00_01_02_03_04_06_07_08_10_16_90') <= 0) Then
      Begin
        fMensagem('','O campo Instrução 2 deve ser preenchido com 00, 01, 02, 03, 04 ,06, 07, 08, 10, 16 ou 90!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtResp Then
    Begin

      If (edtResp.Text <> 'B') And (edtResp.Text <> 'E') Then
      Begin
        fMensagem('','O campo Resp. por emissão de boletos deve ser B ou E!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
      edtParNum.Enabled := (edtResp.Text = 'E');
      edtParNum.Text := IIF((edtResp.Text = 'E'),IIF(fEmptyStr(edtParNum.Text),'N',edtParNum.Text),'N');

    End

    Else If Sender = edtProAce Then
    Begin
      If Pos(edtProAce.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Imprime Protocolo de Aceite deve ser preenchido com (S/N)!',['&O K']);
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

    Else If (Sender = edtPerMul) Then
    Begin
      If Not fValidaEscala(edtPerMul.Text, 0, 99.99) Then
      begin
        fMensagem('ATENÇÃO','O campo percentual de multa deve estar entre 0 e 99,99!'+strMensagemConfig,['&OK']);
        Result := False;
      end;

      If Not fEmptyStr(edtPerMul.Text) then
      begin
        If (fStrToFloat(edtPerMul.Text) > 0) and (edtInstrucao1.Text <> '16') Then
        Begin
          fMensagem('ATENÇÃO','Se informado percentual de multa, o campo "Instrução 1" tem que ser preenchido com 16!'+strMensagemConfig,['&OK']);
          Result := False;
          pSetFocus(edtInstrucao1);
        End;
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
        Else If Not PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text) Then
          Result := False;
      End;

    End

    Else If (Sender = edtCorrBradesco) Then
    Begin
      If (fEmptyStr(edtCorrBradesco.Text)) Or
         ((edtCorrBradesco.Text <> 'S')    And
          (edtCorrBradesco.Text <> 'N'))   Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Usa Correspondente (Bradesco) deve S ou N!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
      edtCarBra.Enabled := edtCorrBradesco.Text = 'S';
    End

    Else If (Sender = edtCarBra) Then
    Begin
      If (edtCorrBradesco.Text = 'S') Then
      Begin
        If fEmptyStr(edtCarBra.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe o índice da carteira do Bradesco que será usada na rotina de gração de boletos (correspondente)!'+strMensagemConfig,['&O K']);
          Result := False;
        End
        Else If Pos(edtCarBra.Text, '12345') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O índice da carteira do Bradesco deve ser 1, 2, 3, 4 ou 5!'+strMensagemConfig,['&O K']);
          Result := False;
        End;
      End
    End

    Else If (Sender = edtDiasProt) Then
    Begin
      If (edtInstrucao2.Text = '10') Then
      Begin
        If fEmptyStr(edtDiasProt.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo Dias para Protesto deve ser preenchido quando a Instrução 2 for igual a 10!'+strMensagemConfig,['&O K']);
          Result := False;
        End
        Else If StrToInt(edtDiasProt.Text) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo Dias para Protesto deve ser preenchido com valor maior que 0!'+strMensagemConfig,['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtEmpBol) Then
    Begin
      edtDesEmpresa.Clear;
      if Not fEmptyStr(edtEmpBol.Text) then
      Begin
        pCarregaEmpresa(edtEmpBol.Text, edtDesEmpresa);
        If qryCadEmp.FieldByName('EMP_NOMEMP').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!'+strMensagemConfig, ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If Sender = edtParNum Then
    Begin
      If Pos(edtParNum.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Utilizar Parcela Numeral deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    if not blnNaoEditar then
      pSetFocus(Sender);

End;

procedure TfrmConfigSafra.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmConfigSafra.tabCarteiraChanging(Sender: TObject;
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

procedure TfrmConfigSafra.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrPortador: TConsultasArray;
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, Nil, Key, arrPortador) Then
    If fValidaCampos(edtCodPor) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfigSafra.edtCodPorRemKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmConfigSafra.edtEmpBolKeyPress(Sender: TObject; var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqEmpresa(conEmpSimples, Self, edtEmpBol, edtDesEmpresa, nil, Key, arrSel) then
    Begin
      Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigSafra.pCarregaCentroCusto(strCtaBai: String;
  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmConfigSafra.pCarregaPortador(strCodPor: String;
  edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtLabel.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmConfigSafra.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  qryCadEmp := fCriaQuery(Self);
  pCarKeyAutBan;
  cxPaginas.Properties.ActivePage := tbsGeral;

end;

procedure TfrmConfigSafra.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigSafra.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSafra.btnCancelarClick(Sender: TObject);
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

procedure TfrmConfigSafra.btnConfigurarClick(Sender: TObject);
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

procedure TfrmConfigSafra.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\422400p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\422400p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigSafra.BtnOcorrenciaClick(Sender: TObject);
  Var
    strDetalhe : String;
begin
  inherited;
  pHideHint;

  strDetalhe := #13#10 +
                '32 - Baixa duplicata; ' + #13#10 +
                '02 - Atualiza nosso número caso não tenha gravado; ' + #13#10 +
                '21, 23 - Lança histórico de protesto. ' + #13#10 +
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

  TfrmMemo.pShowMessage('Banco 422 - Banco Safra - Detalhamento de Ocorrências (posições 109 - 110 arquivo retorno).' + #13#10 +
                        strDetalhe);
end;

procedure TfrmConfigSafra.BtnOcorrenciaEnter(Sender: TObject);
begin
  inherited;
  pAlteraHintBotao(btnOcorrencia, 'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
                                  'que são tratados pelas rotinas do sistema.');
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigSafra.BtnOcorrenciaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSafra.edtCodCarEnter(Sender: TObject);
begin
  inherited;
  pShowHint(edtCodCar,'Carteiras permitidas:');
end;

procedure TfrmConfigSafra.edtCodCarExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSafra.pShowHint(edtEdit: TEditFocus; strTitulo: String);
Begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,edtEdit.ClientOrigin.Y, strTitulo, edtEdit.Hint);
End;

procedure TfrmConfigSafra.pHideHint;
Begin
  HintControler.HideHint;
End;

procedure TfrmConfigSafra.edtInstrucao1Enter(Sender: TObject);
begin
  inherited;
  pShowHint(TEditFocus(Sender),'Instruções permitidas:');
end;

procedure TfrmConfigSafra.edtInstrucao1Exit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSafra.edtContaCorrExit(Sender: TObject);
begin
  inherited;
  TEditFocus(Sender).Text := fstrZero(TEditFocus(Sender).Text, TEditFocus(Sender).MaxLength);
end;

procedure TfrmConfigSafra.edtCodCarChange(Sender: TObject);
begin
  inherited;

  If SameText(edtCodCar.Text,'4') Then
  Begin
    lblIdentCed.Visible   := True;
    edtIdentCed.Visible   := True;
    lblUsoCli.Visible     := True;
    edtUsoCliente.Visible := True;
  End
  Else
  Begin
    lblIdentCed.Visible   := False;
    edtIdentCed.Visible   := False;
    lblUsoCli.Visible     := False;
    edtUsoCliente.Visible := False;
  End;

end;

procedure TfrmConfigSafra.edtIdentCedEnter(Sender: TObject);
begin
  inherited;
  pShowHint(TEditFocus(Sender),'Definição:');
end;

procedure TfrmConfigSafra.edtIdentCedExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSafra.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Seq. remessa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  stlCampos.Add('Cód. carteira     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', ''));
  stlCampos.Add('Cód. agência      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Identif. Cedente  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'IDENCED', ''));
  stlCampos.Add('Número C/C        :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  stlCampos.Add('Uso do Cliente    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'USOCLIE', ''));
  stlCampos.Add('Cód. instrução 1  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', ''));
  stlCampos.Add('Cód. instrução 2  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', ''));
  stlCampos.Add('Observação 1      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Observação 3      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  stlCampos.Add('Observação 4      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  stlCampos.Add('Observação 5      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  stlCampos.Add('Dias p/ protesto  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  stlCampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  stlCampos.Add('Arquivo remessa   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo retorno   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  stlCampos.Add('Responsável Bol.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', ''));
  stlCampos.Add('Protocolo aceite  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', ''));
  stlCampos.Add('Portador de baixa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Portador da remessa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', ''));
  stlCampos.Add('Conta de baixa    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Inf. adicional    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', ''));
  stlCampos.Add('Usa corr. Bradesco:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CORBRAD', ''));
  stlCampos.Add('Indice da carteira:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INDBRAD', ''));
  stlCampos.Add('Percentual de Multa:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', ''));
  stlCampos.Add('Empresa para informações do boleto:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'EMPRBOL', ''));
  stlCampos.Add('Utilizar Parcela Numeral?' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PARCNUM', ''));

end;

procedure TfrmConfigSafra.pGravaLogCarteira(stlCfgAnt : TStringList);
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
    pGravaLogAtb('422', 'BANCO SAFRA', strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

procedure TfrmConfigSafra.pAlteraHintBotao(btnBotao: TBitBtnLocked;
  strNovoHint: String);
begin
  btnBotao.Hint := strNovoHint;
end;

procedure TfrmConfigSafra.pShowHintBotao(btnBotao: TBitBtnLocked;
  strTitulo: String);
begin
  HintControler.ShowHint(btnBotao.ClientOrigin.X,btnBotao.ClientOrigin.Y, strTitulo, btnBotao.Hint);
end;

procedure TfrmConfigSafra.pCarregaEmpresa(strCodEmp: String; edtLabel: TEdit);
begin
  pPesquisaCadEmp(Nil, qryCadEmp, strCodEmp);
  With qryCadEmp Do
  Begin
    edtLabel.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

end.
