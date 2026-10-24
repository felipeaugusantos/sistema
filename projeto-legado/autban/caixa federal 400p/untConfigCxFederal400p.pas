unit untConfigCxFederal400p;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask, DirectoryEditFocus,
  EditFocus, QColorLabel, ComCtrls, ShellApi, Uni, AppEvnts, BitBtnLockedIncrem,
  untTypesSistema, frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, StrUtils, cxTextEdit, cxMaskEdit, cxButtonEdit,
  ComboBoxFocus, dxScreenTip, cxClasses, dxCustomHint, cxHint, 
  untFrameDirectoryEditFocus, untFramePlanoDeContasMaskEdit, dxBarBuiltInMenu,
  cxPC;

type
  TfrmConfigCxFederal400p = class(TfrmPai)
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
    Label30: TLabel;
    edtCodPorRem: TEditFocus;
    edtDescPorRem: TEditFocus;
    pnlAtivo: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    lblCodAgenc: TLabel;
    lblContCorr: TLabel;
    lblDiasProt: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    lblProNum: TLabel;
    lblResp: TLabel;
    ColorLabel1: TColorLabel;
    Label3: TLabel;
    Label1: TLabel;
    lblCodCart: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    ColorLabel3: TColorLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    ColorLabel2: TColorLabel;
    lbl1: TLabel;
    edtResp: TEditFocus;
    edtProxNumArqRem: TEditFocus;
    edtNumConvenio: TEditFocus;
    edtDigitoVerifi: TEditFocus;
    edtDigCtaCor: TEditFocus;
    edtDigAgencia: TEditFocus;
    edtDiasProt: TEditFocus;
    edtContaCorr: TEditFocus;
    edtCodAgencia: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtObservacao5: TEditFocus;
    edtDiasCred: TEditFocus;
    edtCodOperacao: TEditFocus;
    edtProAce: TEditFocus;
    edtPerMul: TEditFocus;
    edtDiasMul: TEditFocus;
    edtNumNos: TEditFocus;
    edtInfAdi: TEditFocus;
    fraPathRemessaCXF: TfraDirectoryEditFocus;
    fraPathRetornoCXF: TfraDirectoryEditFocus;
    cmbCodCar: TComboBoxFocus;
    cmbTaxComPer: TComboBoxFocus;
    cmbInstrucao1: TComboBoxFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    lblPerImpBol: TLabel;
    edtPerImpBol: TEditFocus;
    clbPerImpBol: TColorLabel;


    procedure pCarregaDados;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure tabCarteiraChange(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure BtnManualClick(Sender: TObject);
    procedure edtNumConvenioEnter(Sender: TObject);
    procedure edtNumConvenioExit(Sender: TObject);
    procedure edtDiasCredEnter(Sender: TObject);
    procedure btnConfigurarEnter(Sender: TObject);
    procedure btnConfigurarExit(Sender: TObject);
    procedure edtDiasCredExit(Sender: TObject);
    procedure BtnOcorrenciaEnter(Sender: TObject);
    procedure BtnOcorrenciaExit(Sender: TObject);
    procedure BtnOcorrenciaClick(Sender: TObject);
    procedure edtNumNosEnter(Sender: TObject);
    procedure edtNumNosExit(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure ApplicationEventsDeactivate(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorRemKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }

    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;

    procedure pCarregaCentroCusto(strCtaBai: String; edtLabel: TEdit);
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pShowHint(edtEdit: TEditFocus; strTitulo: String);
    procedure pShowHintBotao(btnBotao: TBitBtnLocked; strTitulo: String);
    procedure pHideHint;
    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  public
    blnNaoEditar: Boolean;
    strConfig   : String;
    { Public declarations }
  end;

var
  frmConfigCxFederal400p: TfrmConfigCxFederal400p;

implementation

uses untfuncoesSimples, untFuncoes,
     untPesqAux, untCfgGenericas_AutBan,
     untConsultas, untMemo;

{$R *.dfm}

{ TfrmConfigCxFederal400p }

procedure TfrmConfigCxFederal400p.pCarregaDados;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************AF*}
  If fEmptyStr(fGetBancoConfig(0, 'CONFIG104p400', 'PROXNUM', '')) Then
  Begin
    edtProxNumArqRem.Enabled := True;
    edtProxNumArqRem.Clear;
    pSetFocus(edtProxNumArqRem);
  End
  Else
  Begin
    edtProxNumArqRem.Text := fGetBancoConfig(0, 'CONFIG104p400', 'PROXNUM', '');
    edtProxNumArqRem.Enabled := False;
    pSetFocus(cmbCodCar);
  End;

  if (strLoginUsuarioLogado='997') or(strLoginUsuarioLogado='998') or (strLoginUsuarioLogado='999') Then
  begin
    edtProxNumArqRem.Enabled := True;
    pSetFocus(edtProxNumArqRem);
  End;

  edtNumConvenio.Text   := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', '');
  edtCodAgencia.Text    := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtDigAgencia.Text    := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', '');
  edtContaCorr.Text     := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', '');
  edtDigCtaCor.Text     := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', '');
  edtDigitoVerifi.Text  := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGVERI', '');
  edtDiasProt.Text      := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '');
  edtResp.Text          := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', '');

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', '')) Of
      11: cmbCodCar.ItemIndex := 0;
      12: cmbCodCar.ItemIndex := 1;
      14: cmbCodCar.ItemIndex := 2;
      41: cmbCodCar.ItemIndex := 3;
    End;
  End
  Else
    cmbCodCar.ItemIndex := -1;

  edtCodOperacao.Text   := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'OPERACA', '');

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'TAXCOMP', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'TAXCOMP', '')) Of
      00: cmbTaxComPer.ItemIndex := 0;
      51: cmbTaxComPer.ItemIndex := 1;
    End;
  End
  Else
    cmbTaxComPer.ItemIndex := -1;

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '')) Of
      1: cmbInstrucao1.ItemIndex := 0;
      2: cmbInstrucao1.ItemIndex := 1;
    End;
  End
  Else
    cmbInstrucao1.ItemIndex := -1;

  edtDesPor.Text := '';
  edtDescPorRem.Text := '';
  fraPlanoDeContas.edtDesCta.Text := '';

  edtObservacao1.Text   := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text   := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text   := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text   := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text   := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');

  fraPathRemessaCXF.edtDirectory.text:= fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '');
  fraPathRetornoCXF.edtDirectory.text:= fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '');
  edtCodPor.Text        := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  edtCodPorRem.Text      := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');
  fraPlanoDeContas.MskCodCta.Text := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');
  edtDiasCred.Text      := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', '');
  edtProAce.Text        := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', '');
  edtDiasMul.Text       := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAMULT', '');
  edtPerMul.Text        := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', '');
  edtNumNos.Text        := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMNOSS', '');
  edtInfAdi.Text        := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', '');

  edtPerImpBol.Text     := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', '');
  If fEmptyStr(edtPerImpBol.Text) Then
    edtPerImpBol.Text := 'S';

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCodPorRem.Text ) Then
    pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);


  If Not fEmptyStr( fraPlanoDeContas.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);

end;

procedure TfrmConfigCxFederal400p.FormShow(Sender: TObject);
begin
  inherited;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  pCarregaDados;

  If edtProxNumArqRem.Enabled Then
    pSetFocus(edtProxNumArqRem)
  Else
    pSetFocus(cmbCodCar);

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

procedure TfrmConfigCxFederal400p.btnConfigurarEnter(Sender: TObject);
begin
  inherited;
  btnConfigurar.Hint := 'Configurar percentual de ' + #13+#10 +
                        'juros para remessa.';
  pShowHintBotao(btnConfigurar, 'Cofigurações específicas.');
end;

procedure TfrmConfigCxFederal400p.btnConfigurarExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCxFederal400p.btnEditarClick(Sender: TObject);
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
      pSetFocus(cmbCodCar);

  end;
end;

procedure TfrmConfigCxFederal400p.btnGravarClick(Sender: TObject);
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

      fGetBancoConfig(1, 'CONFIG104p400', 'PROXNUM', edtProxNumArqRem.Text );
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', edtNumConvenio.Text   );
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text    );
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', edtDigAgencia.Text    );
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text     );
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', edtDigCtaCor.Text     );
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGVERI', edtDigitoVerifi.Text  );
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text      );
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text          );
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', LeftStr(cmbCodCar.Text,2));
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'OPERACA', edtCodOperacao.Text   );
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'TAXCOMP', LeftStr(cmbTaxComPer.Text,2));
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', LeftStr(cmbInstrucao1.Text,2));

      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text   );
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text   );
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text   );
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text   );
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text   );

      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessaCXF.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetornoCXF.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text        );
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text       );
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContas.MskCodCta.Text);

      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text      );
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text        );

      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAMULT', edtDiasMul.Text       );
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', edtPerMul.Text        );
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMNOSS', edtNumNos.Text        );
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text        );
      fGetBancoConfig(1, 'CONFIG104p400-' + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', edtPerImpBol.Text   );

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        pBackupCnfBco;
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        edtProxNumArqRem.Enabled := False;
        pSetFocus(cmbCodCar);
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

procedure TfrmConfigCxFederal400p.fraPlanoDeContasMskCodCtaKeyPress(
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

function TfrmConfigCxFederal400p.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
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

    Else If (Sender = cmbInstrucao1) Then
    Begin

      If cmbInstrucao1.ItemIndex = -1 Then
      Begin
        fMensagem('','O Campo de instruções deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End;

    End

    Else If Sender = edtResp Then
    Begin

      If (edtResp.Text <> 'E') And (edtResp.Text <> 'B') Then
      Begin
        fMensagem('','O campo Resp. por emissão de boletos deve ser E ou B!'+strMensagemConfig,['&O K']);
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

    Else If Sender = edtNumNos Then
    Begin
      If Pos(edtNumNos.Text, '12') <= 0 Then
      Begin
        fMensagem('','O Nosso número deve ser preenchido com (1 ou 2)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End
    
    Else If (Sender = edtPerMul) Then
    Begin
      If Not fValidaEscala(edtPerMul.Text, 0, 100) Then
      begin
        fMensagem('ATENÇÃO','O campo percentual de multa deve estar entre 0 e 100!'+strMensagemConfig,['&OK']);
        Result := False;
      end;
    End

    Else If Sender = edtDiasMul Then
    Begin
      If (fStrToFloat(edtDiasMul.Text) < 0) Then
      Begin
        fMensagem('','A quantidade de dias para a multa deve ser maior ou igual a zero!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = cmbCodCar) Then
    Begin

      If cmbCodCar.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO','O Código da Carteira deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End               

    End

    Else If Sender = edtPerImpBol Then
    Begin
      If Pos(edtPerImpBol.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Permitir impressão de boletos deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
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

    Else If (Sender = edtContaCorr) Then
    Begin
      If Length(edtContaCorr.Text) <> edtContaCorr.MaxLength Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Conta Corrente deve ter 8 caracteres!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigCtaCor) Then
    Begin
      If fEmptyStr(edtDigCtaCor.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Dígito da Conta Corrente deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtNumConvenio) Then
    Begin
      If Length(edtNumConvenio.Text) <> edtNumConvenio.MaxLength Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Número do convênio deve ter 12 caracteres!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodAgencia) Then
    Begin
      If Length(edtCodAgencia.Text) <> edtCodAgencia.MaxLength Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Código da Agência deve ter 4 caracteres!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigAgencia) Then
    Begin
      If fEmptyStr(edtDigAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Dígito da Agência deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodOperacao) Then
    Begin
      If Length(edtCodOperacao.Text) <> edtCodOperacao.MaxLength Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Código da Operação deve ter 3 caracteres!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = cmbTaxComPer) Then
    Begin
      If cmbTaxComPer.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo Taxa de Comissão de Permanência deve ser informado!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtDiasProt) Then
    Begin
      If fEmptyStr(edtDiasProt.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo Dias para Protesto/Devolução deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End
      Else
      Begin
        Case cmbInstrucao1.ItemIndex Of
          0 : If (StrToIntDef(edtDiasProt.Text, 0) < 2)  Or
                 (StrToIntDef(edtDiasProt.Text, 0) > 90) Then
              Begin
                fMensagem('ATENÇÃO!', 'O valor do campo Dias para Protesto/Devolução deve estar entre 02 e 90!'+strMensagemConfig, ['&OK']);
                Result := False;
              End;
          1 : If (StrToIntDef(edtDiasProt.Text, 0) < 5)  Or
                 (StrToIntDef(edtDiasProt.Text, 0) > 90) Then
              Begin
                fMensagem('ATENÇÃO!', 'O valor do campo Dias para Protesto/Devolução deve estar entre 05 e 90!'+strMensagemConfig, ['&OK']);
                Result := False;
              End;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmConfigCxFederal400p.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmConfigCxFederal400p.tabCarteiraChanging(Sender: TObject;
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

procedure TfrmConfigCxFederal400p.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var 
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, nil, Key, arrSel) then
    Begin
      If fValidaCampos(edtCodPor, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigCxFederal400p.edtCodPorRemKeyPress(Sender: TObject;
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
End;


procedure TfrmConfigCxFederal400p.edtDiasCredEnter(Sender: TObject);
begin
  inherited;
  edtDiasCred.Hint := 'Informar quantidade de dias ' + #13+#10 +
                      'do intervalo entre a efetuação ' + #13+#10 +
                      'do pagamento e o crédito na ' + #13+#10 +
                      'conta corrente.';

  pShowHint(edtDiasCred, 'Dias para Crédito');
end;

procedure TfrmConfigCxFederal400p.edtDiasCredExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCxFederal400p.edtNumConvenioEnter(Sender: TObject);
begin
  inherited;
   edtNumConvenio.Hint := 'Informar convênio no formato OOOCCCCCCCCD' + #13+#10 +
                          'Onde: OOO = código da operação;' + #13+#10 +
                          '      CCCCCCCC = número da conta;' + #13+#10 +
                          '      D = dígito';

   pShowHint(edtNumConvenio, 'Preenchimento do convênio (Cedente)');
end;

procedure TfrmConfigCxFederal400p.edtNumConvenioExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCxFederal400p.edtNumNosEnter(Sender: TObject);
begin
  inherited;
  edtNumNos.Hint := 'Verifique no cadastro de bancos (Autcom)' + #13+#10 +
                    'se o nosso número correspondente ao' + #13+#10 +
                    'cadastrado aqui é iniciado com' + #13+#10 +
                    '80, 81 ou 82';
  pShowHint(edtNumNos, 'Índice do nosso número');
end;

procedure TfrmConfigCxFederal400p.edtNumNosExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCxFederal400p.pCarregaCentroCusto(strCtaBai: String;
  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmConfigCxFederal400p.pCarregaPortador(strCodPor: String;
  edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtLabel.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmConfigCxFederal400p.pHideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmConfigCxFederal400p.pShowHint(edtEdit: TEditFocus;
  strTitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,edtEdit.ClientOrigin.Y, strTitulo, edtEdit.Hint);
end;

procedure TfrmConfigCxFederal400p.pShowHintBotao(btnBotao: TBitBtnLocked;
  strTitulo: String);
begin
  HintControler.ShowHint(btnBotao.ClientOrigin.X,btnBotao.ClientOrigin.Y, strTitulo, btnBotao.Hint);
end;

procedure TfrmConfigCxFederal400p.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  pCarKeyAutBan;
  cxPaginas.Properties.ActivePage := tbsGeral;
end;

procedure TfrmConfigCxFederal400p.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigCxFederal400p.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCxFederal400p.btnCancelarClick(Sender: TObject);
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

procedure TfrmConfigCxFederal400p.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try

    pCriarFormularios(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '104';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigCxFederal400p.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\104400p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\104400p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigCxFederal400p.BtnOcorrenciaClick(Sender: TObject);
  Var
    strDetalhe : String;
begin
  inherited;
  pHideHint;

  strDetalhe := #13#10 +
                '02, 32, 21 - Baixa duplicata; ' + #13#10 +
                '01 - Atualiza nosso número caso não tenha gravado; ' + #13#10 +
                '26 - Lança histórico de protesto; ' + #13#10 +
                '28 - Lança histórico de estorno de protesto. ' + #13#10 +
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

  TfrmMemo.pShowMessage('Banco 104 - Caixa Econômica Federal - Detalhamento de Ocorrências (posições 109 - 110 arquivo retorno).' + #13#10 +
                        strDetalhe);
end;

procedure TfrmConfigCxFederal400p.BtnOcorrenciaEnter(Sender: TObject);
begin
  inherited;
  btnOcorrencia.Hint := 'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
                        'que são tratados pelas rotinas do sistema.';
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigCxFederal400p.BtnOcorrenciaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigCxFederal400p.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Seq. remessa      :' + fGetBancoConfig(0, 'CONFIG104p400', 'PROXNUM', ''));
  stlCampos.Add('Cód. carteira     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', ''));
  stlCampos.Add('Cód. do convênio  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', ''));
  stlCampos.Add('Cód. da agência   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Díg. da agência   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', ''));
  stlCampos.Add('Cód. da C/C       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  stlCampos.Add('Díg. da C/C       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', ''));
  stlCampos.Add('Díg. verificador  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGVERI', ''));
  stlCampos.Add('Cód. operação     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OPERACA', ''));
  stlCampos.Add('Taxa de comissão  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TAXCOMP', ''));
  stlCampos.Add('Cód. instrução    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', ''));
  stlCampos.Add('Observação 1      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Observação 3      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  stlCampos.Add('Observação 4      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  stlCampos.Add('Observação 5      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  stlCampos.Add('Dias p/ protesto  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  stlCampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  stlCampos.Add('Percentual multa  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', ''));
  stlCampos.Add('Dias para multa   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAMULT', ''));
  stlCampos.Add('Arquivo remessa   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo retorno   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  stlCampos.Add('Responsável Bol.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', ''));
  stlCampos.Add('Protocolo aceite  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', ''));
  stlCampos.Add('Portador de baixa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Portador da remessa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', ''));
  stlCampos.Add('Conta de baixa    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Nosso número      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMNOSS', ''));
  stlCampos.Add('Inf. adicional    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', ''));
  stlCampos.Add('Permitir impressão de boletos? :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', ''));
end;

procedure TfrmConfigCxFederal400p.pGravaLogCarteira(stlCfgAnt : TStringList);
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
    pGravaLogAtb('104', 'CAIXA 400 POSIÇÕES', strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

end.
