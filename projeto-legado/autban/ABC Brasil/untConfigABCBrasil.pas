unit untConfigABCBrasil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, DirectoryEditFocus, StdCtrls, EditFocus, Buttons,
  ExtCtrls, QColorLabel, Menus, ComCtrls, ShellApi, Uni, AppEvnts, ComboBoxFocus,
  BitBtnLockedIncrem, untTypesSistema, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus, untFramePlanoDeContasMaskEdit, strutils,
  dxBarBuiltInMenu, cxPC;

type
  TfrmConfigABCBrasil = class(TfrmPai)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
    btnCancelar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    BtnManual: TBitBtnLocked;
    cxPaginas: TcxPageControl;
    tbsGeral: TcxTabSheet;
    tbsComplemento: TcxTabSheet;
    pnlComplemento: TPanel;
    Label45: TLabel;
    edtCodPorRem: TEditFocus;
    edtDescPorRem: TEditFocus;
    pnlAtivo: TPanel;
    lblCodCart: TLabel;
    lblDiasProt: TLabel;
    lblIdentBanco: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    lblProNum: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    ColorLabel3: TColorLabel;
    Label14: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lblCodAgenc: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    ColorLabel1: TColorLabel;
    Label2: TLabel;
    Label18: TLabel;
    Label16: TLabel;
    lblmulta: TLabel;
    Label17: TLabel;
    lblNumNos: TLabel;
    lblNumNos2: TColorLabel;
    edtDiasProt: TEditFocus;
    edtIdentBanc: TEditFocus;
    edtCodCar: TEditFocus;
    edtProxNumArqRem: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtInstrucao1: TEditFocus;
    edtInstrucao2: TEditFocus;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtObservacao5: TEditFocus;
    edtExpCgc: TEditFocus;
    edtDiasCred: TEditFocus;
    cmbTipDia: TComboBoxFocus;
    edtInfAdi: TEditFocus;
    fraPathRemessaABCBrasil: TfraDirectoryEditFocus;
    fraPathRetornoABCBrasil: TfraDirectoryEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    edtCodAgencia: TEditFocus;
    edtDigAgencia: TEditFocus;
    edtNumOperacao: TEditFocus;
    edtcodBeneficiario: TEditFocus;
    edtResp: TEditFocus;
    edtCodCarRem: TEditFocus;
    cmbTipoMulta: TComboBoxFocus;
    edtDiasMora: TEditFocus;
    edtValMulta: TEditFocus;
    cmbCodigoOcorrencia: TComboBoxFocus;
    edtNumNos: TEditFocus;
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
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorRemKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;

    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
  public
    { Public declarations }
    blnNaoEditar: Boolean;
    strConfig   : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigABCBrasil: TfrmConfigABCBrasil;

implementation

uses  untfuncoesSimples,  untPesqAux,  untFuncoes,
  untCfgGenericas_AutBan, untConsultas;

{$R *.dfm}

procedure TfrmConfigABCBrasil.pCarregaDados;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************AF*}
  edtProxNumArqRem.Text  := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '');
  edtCodCar.Text         := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', '');
  edtCodCarRem.Text      := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCARR', '');
  edtIdentBanc.Text      := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', '');
  edtcodBeneficiario.Text:= fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'CODBENE', '');
  edtCodAgencia.Text     := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtDigAgencia.Text     := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', '');
  edtNumOperacao.Text    := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMOPER', '');
  edtCodPor.Text         := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  edtCodPorRem.Text      := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');
  fraPlanoDeContas.MskCodCta.Text         := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');
  edtDiasProt.Text       := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '');
  edtInstrucao1.Text     := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '');
  edtInstrucao2.Text     := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', '');

  edtObservacao1.Text    := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text    := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text    := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text    := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text    := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');

  cmbTipoMulta.ItemIndex := StrToInt(fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'TPMULTA', '0'));
  edtDiasMora.Text       := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAMORA', '');
  edtValMulta.Text       := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'VALMULT', '');

  Try
    Case StrToInt(fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'CODOCOR', '')) Of
      01: cmbCodigoOCorrencia.ItemIndex := 0;
      02: cmbCodigoOCorrencia.ItemIndex := 1;
      04: cmbCodigoOCorrencia.ItemIndex := 2;
      05: cmbCodigoOCorrencia.ItemIndex := 3;
      06: cmbCodigoOCorrencia.ItemIndex := 4;
      07: cmbCodigoOCorrencia.ItemIndex := 5;
      08: cmbCodigoOCorrencia.ItemIndex := 6;
      09: cmbCodigoOCorrencia.ItemIndex := 7;
      10: cmbCodigoOCorrencia.ItemIndex := 8;
      18: cmbCodigoOCorrencia.ItemIndex := 9;
      47: cmbCodigoOCorrencia.ItemIndex := 10;
    end;
  except
     cmbCodigoOCorrencia.ItemIndex := -1;
  end;

  fraPathRemessaABCBrasil.edtDirectory.text:= fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '');
  fraPathRetornoABCBrasil.edtDirectory.text:= fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '');
  edtResp.Text           := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', '');
  edtNumNos.Text         := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMNOSS', '1');
  edtExpCgc.Text         := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPCNPJ', '');
  edtDiasCred.Text       := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', '');

  edtInfAdi.Text         := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', '');
  cmbTipDia.ItemIndex    := StrToIntDef(fGetBancoConfig(0,'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1),'TIPDIA', '1'),0)-1;

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCodPorRem.Text ) Then
    pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);

  If Not fEmptyStr( fraPlanoDeContas.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);

end;

procedure TfrmConfigABCBrasil.FormShow(Sender: TObject);
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

procedure TfrmConfigABCBrasil.btnEditarClick(Sender: TObject);
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

procedure TfrmConfigABCBrasil.btnGravarClick(Sender: TObject);
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

      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', edtProxNumArqRem.Text);
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', edtCodCar.Text       );
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCARR', edtCodCarRem.Text    );
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', edtIdentBanc.Text    );
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text   );
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', edtDigAgencia.Text   );
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMOPER', edtNumOperacao.Text  );
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'CODBENE', edtcodBeneficiario.Text    );
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text       );
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text       );
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContas.MskCodCta.Text       );
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text     );
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', edtInstrucao1.Text   );
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', edtInstrucao2.Text   );

      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text);
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text);
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text);
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text);
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text);

      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'TPMULTA', IntToStr(cmbTipoMulta.ItemIndex));
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAMORA', edtDiasMora.Text     );
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'VALMULT', edtValMulta.Text     );
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'CODOCOR', LeftStr(cmbCodigoOcorrencia.Text,2));

      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessaABCBrasil.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetornoABCBrasil.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text         );
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMNOSS', edtNumNos.Text       );

      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPCNPJ', edtExpCgc.Text         );

      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text     );
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text       );
      fGetBancoConfig(1, 'CONFIG246-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPDIA' , IntToStr(cmbTipDia.ItemIndex+1));

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        pBackupCnfBco;
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
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

procedure TfrmConfigABCBrasil.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
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

function TfrmConfigABCBrasil.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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
        fMensagem('', 'O Próximo Núm. Arq. Remessa deve conter um valor!'+strMensagemConfig,['&O K']);
        Result := False;
      End

      Else If StrToInt(edtProxNumArqRem.Text) <= 0 Then
      Begin
        fMensagem('', 'O Próximo Núm. Arq. Remessa deve ser maior que zero!'+strMensagemConfig,['&O K']);
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

    End

    Else If (Sender = edtInstrucao2) Then
    Begin

      If fEmptyStr(edtInstrucao2.Text) Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!'+strMensagemConfig,['&O K']);
        Result := False;
      End

    End

    Else If Sender = fraPathRemessaABCBrasil Then
    Begin

      If fEmptyStr(fraPathRemessaABCBrasil.edtDirectory.text) Then
      Begin
        fMensagem('','Preencha o campo Path de Remessa'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If Sender = fraPathRetornoABCBrasil Then
    Begin

      If fEmptyStr(fraPathRetornoABCBrasil.edtDirectory.text) Then
      Begin
        fMensagem('','Preencha o campo Path de Retorno'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtCodCar) Then
    Begin

      If (Length(edtCodCar.Text) < 3) Then
      Begin
         fMensagem('ATENÇÃO!','O Campo código da carteira (Boleto) deve ser preenchido com 3 dígitos ! ', ['&OK']);
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

    Else If (Sender = edtNumOperacao) Then
    Begin
      If fEmptyStr(edtNumOperacao.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Número da Operação deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodBeneficiario) Then
    Begin
      If fEmptyStr(edtCodBeneficiario.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo código do beneficiário deve ser preenchido!'+strMensagemConfig,['&O K']);
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

    End

    Else If Sender = edtNumNos Then
    Begin
      If Pos(edtNumNos.Text, '12') <= 0 Then
      Begin
        fMensagem('','O campo utilizar nosso número deve ser preenchido com (1 ou 2)!'+strMensagemConfig,['&O K']);
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

    Else If (Sender = edtExpCgc) Then
    Begin

      If fEmptyStr(edtExpCgc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Exp. Cnpj do cedente deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else
      Begin
        If Pos(edtExpCgc.Text, 'S_N_') = 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo Exp. Cnpj do cedente deve conter apenas (S/N)!'+strMensagemConfig,['&O K']);
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
    if not blnNaoEditar then
      pSetFocus(Sender);

End;

procedure TfrmConfigABCBrasil.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmConfigABCBrasil.edtCodPorRemKeyPress(Sender: TObject;
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

procedure TfrmConfigABCBrasil.pCarregaPortador(strCodPor: String; edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtLabel.Text := FieldByName('POR_NOMPOR').AsString;
  End;

end;

procedure TfrmConfigABCBrasil.pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;

end;

procedure TfrmConfigABCBrasil.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmConfigABCBrasil.tabCarteiraChanging(Sender: TObject;
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

procedure TfrmConfigABCBrasil.FormCreate(Sender: TObject);
begin
  inherited;
  pCarKeyAutBan;
  qryCadPor := fCriaQuery(Self);
  cxPaginas.Properties.ActivePage := tbsGeral;
end;

procedure TfrmConfigABCBrasil.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigABCBrasil.btnCancelarClick(Sender: TObject);
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

procedure TfrmConfigABCBrasil.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '246';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigABCBrasil.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\246400p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\246400p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigABCBrasil.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Seq. Remessa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  stlCampos.Add('Cód. Carteira     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', ''));
  stlCampos.Add('Cód. Carteira Rem.:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCARR', ''));
  stlCampos.Add('Cód. Empresa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', ''));
  stlCampos.Add('Cód. Beneficiário :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODBENE', ''));
  stlCampos.Add('Cód. Agencia      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Dig. Agencia      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', ''));
  stlCampos.Add('Número Operação   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMOPER', ''));
  stlCampos.Add('Portador de baixa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Portador da remessa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', ''));
  stlCampos.Add('Conta de baixa    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Cód. Instrução 1  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', ''));
  stlCampos.Add('Cód. Instrução 2  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', ''));
  stlCampos.Add('Observação 1      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Observação 3      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  stlCampos.Add('Observação 4      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  stlCampos.Add('Observação 5      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  stlCampos.Add('Dias p/ protesto  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  stlCampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  stlCampos.Add('Tipo Multa        :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TPMULTA', ''));
  stlCampos.Add('Dias de Mora      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAMORA', ''));
  stlCampos.Add('Valor Multa       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'VALMULT', ''));
  stlCampos.Add('Código da Ocorr.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODOCOR', ''));
  stlCampos.Add('Arquivo Remessa   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo Retorno   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  stlCampos.Add('Exp. CNPJ Cedente :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'EXPCNPJ', ''));
  stlCampos.Add('Tipo dias protesto:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TIPDIA', ''));
  stlCampos.Add('Inf. adicional    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', ''));
  stlCampos.Add('Utilizar:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMNOSS', ''));
  stlCampos.Add('Resp. por Emissão de Boletos:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', ''));

end;

procedure TfrmConfigABCBrasil.pGravaLogCarteira(stlCfgAnt : TStringList);
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
    pGravaLogAtb('246', 'ABCBRASIL', strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;
end.
