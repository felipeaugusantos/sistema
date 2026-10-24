unit untConfigBanrisul240;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Mask, DirectoryEditFocus, Buttons, ExtCtrls,
  QColorLabel, Menus, ComCtrls, ShellApi, Uni, AppEvnts, BitBtnLockedIncrem,
  untTypesSistema, frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxButtonEdit,
  dxScreenTip, cxClasses, dxCustomHint, cxHint, dxBarBuiltInMenu, cxGroupBox,
  cxPC, ComboBoxFocus,untFrameDirectoryEditFocus, untFramePlanoDeContasMaskEdit,
  untFrameCheckComboBoxOcorrencia;

type
  TfrmConfigBanrisul240 = class(TfrmPai)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
    btnCancelar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    BtnManual: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    cxPaginas: TcxPageControl;
    tbsGeral: TcxTabSheet;
    tbsEncBan: TcxTabSheet;
    pnlAtivo1: TPanel;
    lblProNum: TLabel;
    lblIdentBanco: TLabel;
    lblDiasProt: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    lblResp: TLabel;
    ColorLabel1: TColorLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    lbl1: TLabel;
    Label15: TLabel;
    Label6: TLabel;
    edtResp: TEditFocus;
    edtProxNumArqRem: TEditFocus;
    edtIdentBanc: TEditFocus;
    edtDiasProt: TEditFocus;
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
    edtInfAdi: TEditFocus;
    edtMulAtr: TEditFocus;
    fraPathRemessa: TfraDirectoryEditFocus;
    fraPathRetorno: TfraDirectoryEditFocus;
    pnlAtivo2: TPanel;
    cxGroupBox1: TcxGroupBox;
    Label26: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    edtDesPorTar: TEditFocus;
    edtPorTar: TEditFocus;
    edtValorTarifa: TEditFocus;
    edtDesForTar: TEditFocus;
    edtForTar: TEditFocus;
    BtnOcorrencia: TBitBtnLocked;
    HintControler: TcxHintStyleController;
    edtCodConv: TEditFocus;
    Label18: TLabel;
    lblCodAgenc: TLabel;
    edtCodAgencia: TEditFocus;
    Label7: TLabel;
    edtDigAgencia: TEditFocus;
    lblCodCart: TLabel;
    edtCodCar: TEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    fraPlanoDeContasEncBan: TfraPlanoDeContasMskEdit;
    fraCheckComboBoxOcorrencia: TfraCheckComboBoxOcorrencia;
    Label28: TLabel;
    tbsComplemento: TcxTabSheet;
    pnlComplemento: TPanel;
    Label2: TLabel;
    edtCodPorRem: TEditFocus;
    edtDescPorRem: TEditFocus;
    Label5: TLabel;
    edtDiasBaixa: TEditFocus;
    lblEnviarInfoAdicNF: TLabel;
    edtEnviarInfoAdicionaisNF: TEditFocus;
    clbEnviarInfoAdicNF: TColorLabel;
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
    procedure edtPorTarKeyPress(Sender: TObject; var Key: Char);
    procedure edtForTarKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorTarifaExit(Sender: TObject);
    procedure BtnOcorrenciaClick(Sender: TObject);
    procedure BtnOcorrenciaEnter(Sender: TObject);
    procedure BtnOcorrenciaExit(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasEncBanMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    function RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;
    procedure edtCodPorRemKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }

    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;
    qryCadFor : TUniQuery;

    procedure pHideHint;
    procedure pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pLimpaCampos;
    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
    procedure pShowHintBotao(btnBotao: TBitBtnLocked; strTitulo: String);
  public
    { Public declarations }
    blnNaoEditar: Boolean;
    strConfig   : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigBanrisul240: TfrmConfigBanrisul240;

implementation

uses untfuncoesSimples, untFuncoes,
     untPesqAux, untCfgGenericas_AutBan, untConsultas, untMemo;

{$R *.dfm}

procedure TfrmConfigBanrisul240.btnEditarClick(Sender: TObject);
begin
  If ((Not fVerificaDireitoAutBan('PERCARBAN')) and (strLoginUsuarioLogado <> '999')) Then
  begin
    fMensagem('ATENÇÃO','Usuário sem permissão!', ['&Ok ']);
    Exit;
  end
  else
  begin
    pnlAtivo1.Enabled := True;
    pnlComplemento.Enabled := pnlAtivo1.Enabled;

    if tbsEncBan.tabVisible then
      pnlAtivo2.Enabled := True;

    btnGravar.Enabled := True;
    btnConfigurar.Enabled := True;
    btnEditar.Visible := False;
    btnCancelar.Visible := true;

    if edtProxNumArqRem.Enabled then
      pSetFocus(edtProxNumArqRem)
    else
      pSetFocus(edtIdentBanc);

  end;
end;

procedure TfrmConfigBanrisul240.btnGravarClick(Sender: TObject);
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

    Try
      stlCfgAnt := TStringList.Create;
      pCarregaCfg(stlCfgAnt);

      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', edtProxNumArqRem.Text);
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', edtIdentBanc.Text    );
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', edtCodCar.Text       );
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text   );
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', edtDigAgencia.Text   );
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text     );
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text         );
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', edtInstrucao1.Text   );
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', edtInstrucao2.Text   );

      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text  );
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text  );
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text  );
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text  );
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text  );

      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessa.edtDirectory.text  );
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetorno.edtDirectory.text  );
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text       );
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text       );
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContas.MskCodCta.Text       );

      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text     );
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text       );
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', edtMulAtr.Text       );

      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', edtPorTar.Text       );
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', fraPlanoDeContasEncBan.MskCodCta.Text       );
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', edtForTar.Text       );
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', edtValorTarifa.Text  );
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', edtCodConv.Text      );
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'OCOIGNORA', fraCheckComboBoxOcorrencia.fGetOcorrencias);
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIASBAI', edtDiasbaixa.Text     );
      fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVADNF', edtEnviarInfoAdicionaisNF.Text     );

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        pBackupCnfBco;
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        edtProxNumArqRem.Enabled := False;
        pSetFocus(edtCodConv);
        blnMudarFoco := True;
        cxPaginas.ActivePage :=  tbsGeral;
        pnlAtivo1.Enabled := False;
        pnlComplemento.Enabled := pnlAtivo1.Enabled;

        if tbsEncBan.tabVisible then
           pnlAtivo2.Enabled := False;

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

procedure TfrmConfigBanrisul240.pCarregaDados;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************AF*}
  //Limpando Valores Carregados;
  pLimpaCampos;

  If fEmptyStr(fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '')) Then
  Begin
    edtProxNumArqRem.Enabled := True;
    edtProxNumArqRem.Clear;
    pSetFocus(edtProxNumArqRem);
  End
  Else
  Begin
    edtProxNumArqRem.Text := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '');
    edtProxNumArqRem.Enabled := False;
    pSetFocus(edtCodConv);
  End;

  if (strLoginUsuarioLogado='997') or(strLoginUsuarioLogado='998') or (strLoginUsuarioLogado='999') Then
  begin
    edtProxNumArqRem.Enabled := True;
    pSetFocus(edtProxNumArqRem);
  End;
  edtCodCar.Text        := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', '');
  edtIdentBanc.Text     := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', '');
  edtCodAgencia.Text    := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtDigAgencia.Text    := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', '');
  edtDiasProt.Text      := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '');
  edtResp.Text          := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', '');
  edtInstrucao1.Text    := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '');
  edtInstrucao2.Text    := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', '');
  edtObservacao1.Text   := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text   := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text   := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text   := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text   := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');

  fraPathRemessa.edtDirectory.text   := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '');
  fraPathRetorno.edtDirectory.text   := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '');
  edtCodPor.Text        := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  edtCodPorRem.Text      := fGetBancoConfig(0, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');
  fraPlanoDeContas.MskCodCta.Text        := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');
  edtDiasCred.Text      := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', '');
  edtInfAdi.Text        := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', '');
  edtPorTar.Text        := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', '');
  fraPlanoDeContasEncBan.MskCodCta.Text        := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', '');
  edtForTar.Text        := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', '');
  edtValorTarifa.Text   := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', '');
  edtCodConv.Text       := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', '');
  fraCheckComboBoxOcorrencia.pSetOcorrencias(fGetBancoConfig(0, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'OCOIGNORA', ''));
  edtDiasBaixa.Text     := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1),'DIASBAI','');

  if ((fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'MULATR_', '') <> '') and
      (fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', '') = ''))   then
  Begin
    fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'MULATR_', ''));
  end;

  edtMulAtr.Text        := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', '');
  edtEnviarInfoAdicionaisNF.Text := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVADNF', '');

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCodPorRem.Text ) Then
    pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);


  If Not fEmptyStr( fraPlanoDeContas.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);

  If Not fEmptyStr( edtPorTar.Text ) Then pCarregaPortador(edtPorTar.Text, edtDesPorTar);
  If Not fEmptyStr( fraPlanoDeContasEncBan.MskCodCta.Text ) Then pCarregaCentroCusto(fraPlanoDeContasEncBan.MskCodCta.Text, fraPlanoDeContasEncBan.edtDesCta);

  If Not fEmptyStr( edtForTar.Text ) Then
  begin
    pPesquisaCadFor(qryCadFor, qryCadFor, edtForTar.Text);
    edtDesForTar.Text  := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
  end;

  If fEmptyStr(edtEnviarInfoAdicionaisNF.Text) Then edtEnviarInfoAdicionaisNF.Text := 'N';
end;

procedure TfrmConfigBanrisul240.FormShow(Sender: TObject);
begin
  inherited;
  fraCheckComboBoxOcorrencia.strCodBco    := '041';
  fraCheckComboBoxOcorrencia.strCnab      := '240';
  fraCheckComboBoxOcorrencia.strCodIgnora := ['06'];
  fraCheckComboBoxOcorrencia.pCarregaOcorrencias;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  pCarregaDados;

  cxPaginas.ActivePage := tbsGeral;

  If edtProxNumArqRem.Enabled Then
    pSetFocus(edtProxNumArqRem)
  Else
    pSetFocus(edtIdentBanc);

  pnlAtivo1.Enabled := False;
  pnlAtivo2.Enabled := False;
  pnlComplemento.Enabled := pnlAtivo1.Enabled;

  pSetFocus(btnEditar);

  if blnNaoEditar then
  begin

     btnConfigurar.Enabled := False;
     btnConfigurar.Visible := False;
     btnGravar.Enabled     := True;
     btnEditar.Visible     := False;
     pSetFocus(btnGravar);
  end;

end;

procedure TfrmConfigBanrisul240.fraPlanoDeContasEncBanMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************KP*}
  If fPesqCentroCusto(Self, fraPlanoDeContasEncBan.MskCodCta, fraPlanoDeContasEncBan.edtDesCta, Nil, Key, arrCentroCusto) Then
  begin
    if fValidaCampos(fraPlanoDeContasEncBan.MskCodCta)  then
      SelectNext(ActiveControl, True, True);
  end;

end;

procedure TfrmConfigBanrisul240.fraPlanoDeContasMskCodCtaKeyPress(
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

function TfrmConfigBanrisul240.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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

    Else If Sender = edtCodConv Then
    Begin
      If fEmptyStr(edtCodConv.Text) Then
      Begin
        fMensagem('','O Código do Convênio deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (tbsEncBan.TabVisible = True) and (Sender = edtPorTar) Then
    Begin
      If fEmptyStr(TEditFocus(Sender).Text) Then
      begin
        if (not fEmptyStr(edtValorTarifa.Text)) and (fStrToFloat(edtValorTarifa.Text)>0) then
        Begin
          fMensagem('', 'O portador para baixa da tarifa deve ser preenchido!'+strMensagemConfig, ['&Ok']);

          If (Sender = edtPorTar) Then edtDesPorTar.Clear;

          cxPaginas.ActivePage := tbsEncBan;
          Result := False;
        End;
      end
      else
      begin
        pCarregaPortador(edtPorTar.Text, edtDesPorTar);

        If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('', 'Esse portador não está cadastrado!'+strMensagemConfig, ['&Ok']);
          cxPaginas.ActivePage := tbsEncBan;
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtPorTar.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin

          If (Pos(edtPorTar.Text, strPortadoresOperador) <= 0) Then
          Begin
            If Not fEmptyStr(edtDesPorTar.Text) Then
            Begin
              fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+strMensagemConfig, ['&Ok']);
              Result := False;
            End
          End;

        End;
      end;
    End

    Else If (tbsEncBan.TabVisible = True) and  (Sender = fraPlanoDeContasEncBan.MskCodCta)  Then
    Begin
      If fEmptyStr(fraPlanoDeContasEncBan.MskCodCta.Text) Then
      begin
        if (not fEmptyStr(edtValorTarifa.Text)) and (fStrToFloat(edtValorTarifa.Text)>0) then
        Begin
          fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser informado!'+strMensagemConfig, ['&Ok']);
          fraPlanoDeContasEncBan.edtDesCta.Clear;
          Result := False;
        End
      end
      Else
      Begin
        pCarregaCentroCusto(fraPlanoDeContasEncBan.MskCodCta.Text, fraPlanoDeContasEncBan.edtDesCta);
        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!'+strMensagemConfig, ['&Ok']);
          Result := False;
        End
        else
        Begin
          Result := PlanoDeContasAtivo(fraPlanoDeContasEncBan.MskCodCta.Text,True);
          fraPlanoDeContasEncBan.edtDesCta.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;
        End;
      end;

    End

    Else If (tbsEncBan.TabVisible = True) and  (Sender = edtForTar)  Then
    Begin
      If fEmptyStr(edtForTar.Text) Then
      begin
        if (not fEmptyStr(edtValorTarifa.Text)) and (fStrToFloat(edtValorTarifa.Text)>0) then
        Begin
          fMensagem('ATENÇÃO','O Código do fornecedor para baixa da tarifa bancária deve ser preenchido!'+strMensagemConfig,['&OK']);
          Result := False;
        End;
      end
      else
      begin
        pPesquisaCadFor(qryCadFor, qryCadFor, edtForTar.Text);

        If qryCadFor.FieldByName('FOR_CODFOR').IsNull Then
        Begin
          fMensagem('', 'Esse fornecedor não está cadastrado!'+strMensagemConfig, ['&Ok']);
          cxPaginas.ActivePage := tbsEncBan;
          Result := False;
        End
        else
          edtDesForTar.Text  := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
      end;
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

    Else If Sender = edtResp Then
    Begin

      If (edtResp.Text <> 'B') And (edtResp.Text <> 'E') Then
      Begin
        fMensagem('','O campo Resp. por emissão de boletos deve ser B ou E!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If Sender = edtDiasBaixa Then
    Begin

      If ( ((Pos(Copy(edtInstrucao1.Text, 1, 2), '02_') > 0) or (Pos(Copy(edtInstrucao2.Text, 1, 2), '02_') > 0)) and ((edtDiasBaixa.Text = '') or (StrToInt(edtDiasBaixa.Text) = 0))) Then
      Begin
        fMensagem('','Para a instrução selecionada é obrigatório informar ' + #13 + ' a quantidade de dias para a baixa!'+strMensagemConfig,['&O K']);
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
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+strMensagemConfig,['&O K']);
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
        Else
          Result := PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text,True);
      End;
    End

    Else If Sender = edtEnviarInfoAdicionaisNF Then
    Begin

      If (edtEnviarInfoAdicionaisNF.Text <> 'S') And (edtEnviarInfoAdicionaisNF.Text <> 'N') Then
      Begin
        fMensagem('','O campo "Enviar Informações Adicionais de Nota Fiscal?" deve ser S ou N!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End;

  End;

  If Not Result Then
  begin
    if not blnNaoEditar then
    begin
      cxPaginas.ActivePage := RetornaAbaDoComponete(Sender);
      pSetFocus(Sender);
    end;

    end;


End;

procedure TfrmConfigBanrisul240.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
  cxPaginas.ActivePage := tbsGeral;
end;


procedure TfrmConfigBanrisul240.tabCarteiraChanging(Sender: TObject;
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

procedure TfrmConfigBanrisul240.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmConfigBanrisul240.edtCodPorRemKeyPress(Sender: TObject;
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

procedure TfrmConfigBanrisul240.pCarregaCentroCusto(strCtaBai: String;
  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    edtLabel.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;


procedure TfrmConfigBanrisul240.edtForTarKeyPress(Sender: TObject; var Key: Char);
Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************KP*}
  If fPesqFornecedor(conForCompleta, Self, edtForTar, edtDesForTar, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtForTar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConfigBanrisul240.edtPorTarKeyPress(Sender: TObject; var Key: Char);
var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtPorTar, edtDesPorTar, nil, Key, arrSel) then
    Begin
      If fValidaCampos(edtPorTar, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;

    if fEmptyStr(edtValorTarifa.Text) or (fStrToFloat(edtValorTarifa.Text) = 0 ) then
         Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmConfigBanrisul240.edtValorTarifaExit(Sender: TObject);
begin
  inherited;
  try
    if not fEmptyStr(edtValorTarifa.Text) then
       edtValorTarifa.Text := FormatFloat('###,##0.00', fStrToFloat(edtValorTarifa.Text));
  except

  end
end;

procedure TfrmConfigBanrisul240.pCarregaPortador(strCodPor: String;
  edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtLabel.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmConfigBanrisul240.pHideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmConfigBanrisul240.pLimpaCampos;
var
  i: Integer;
begin
  for i := Self.ComponentCount -1 downto 0 do
  begin
    if (Self.Components[i] is TEditFocus) then
      (Self.Components[i] as TEditFocus).text := '';

    if (Self.Components[i] is TfraDirectoryEditFocus) then
      (Self.Components[i] as TfraDirectoryEditFocus).edtDirectory.text := '';
  end;
end;

procedure TfrmConfigBanrisul240.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  qryCadFor := fCriaQuery(Self);
  pCarKeyAutBan;

  cxPaginas.Properties.ActivePage := tbsGeral;

  If fCfgSis('ENCBAN', varBoolean) Then
    tbsEncBan.TabVisible := True
  else
    tbsEncBan.TabVisible := False;

end;

procedure TfrmConfigBanrisul240.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigBanrisul240.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do registro da carteira selecionada?', ['&S i m', '&N ã o'], 2) = 1 then
  begin
    cxPaginas.ActivePage :=  tbsGeral;
    btnCancelar.Visible := False;
    btnEditar.Visible   := True;
    pnlAtivo1.Enabled := False;
    pnlComplemento.Enabled := pnlAtivo1.Enabled;

    if tbsEncBan.tabVisible then
       pnlAtivo2.Enabled:= False;

    btnEditar.Visible   := True;
    btnGravar.Enabled   := False;
    btnConfigurar.Enabled := False;
    pCarregaDados;
    pSetFocus(btnEditar);
  end;

end;

procedure TfrmConfigBanrisul240.btnConfigurarClick(Sender: TObject);
begin
  inherited;

  Try
    pCriarFormularios(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '041_240p';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;
end;

procedure TfrmConfigBanrisul240.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\041400p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\041400p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigBanrisul240.BtnOcorrenciaClick(Sender: TObject);
  Var
    strDetalhe : String;
begin
  inherited;
  pHideHint;

  strDetalhe := #13#10 +
                '10 - Baixado Conforme Instrução; ' + #13#10 +
                '02 - Confirmação de Entrada; ' + #13#10 +
                '06 - Liquidação Normal;' + #13#10 +
                '21, 23 - Lança histórico de protesto. ' + #13#10 +
                '30 - Lança histórico de cobrança (liquidação em trânsito). ' + #13#10 +
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

  TfrmMemo.pShowMessage('Banco 041 - Banrisul - Detalhamento de Ocorrências (posições 109 - 110 arquivo retorno).' + #13#10 +
                        strDetalhe);
end;

procedure TfrmConfigBanrisul240.BtnOcorrenciaEnter(Sender: TObject);
begin
  inherited;
  btnOcorrencia.Hint := 'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
                        'que são tratados pelas rotinas do sistema.';
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigBanrisul240.BtnOcorrenciaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBanrisul240.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Seq. Remessa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  stlCampos.Add('Código Carteira   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', ''));
  stlCampos.Add('Cedente           :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', ''));
  stlCampos.Add('Código Agência    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Dígito Agência    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', ''));
  stlCampos.Add('Cód. Instrução 1  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', ''));
  stlCampos.Add('Cód. Instrução 2  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', ''));
  stlCampos.Add('Observação 1      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Observação 3      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  stlCampos.Add('Observação 4      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  stlCampos.Add('Observação 5      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  stlCampos.Add('Dias p/ protesto  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  stlCampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  stlCampos.Add('Arquivo Remessa   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo Retorno   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  stlCampos.Add('Resp. Emissão Bol :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', ''));
  stlCampos.Add('Portador de Baixa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Portador da remessa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', ''));
  stlCampos.Add('Conta Baixa       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Percentual Multa  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', ''));
  stlCampos.Add('Info Adicional    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', ''));
  stlCampos.Add('Enc.Ban. Vr Tarifa:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', ''));
  stlCampos.Add('Enc.Ban. Portador :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', ''));
  stlCampos.Add('Enc.Ban. Pl Conta :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', ''));
  stlCampos.Add('Enc.Ban. Fornec.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', ''));
  stlCampos.Add('Código do Convênio:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', ''));
  stlCampos.Add('Ocorrências a ignorar na baixa automática: ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OCOIGNORA', ''));
  stlCampos.Add('Enviar Informações Adicionais de Nota Fiscal? ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ENVADNF', ''));
end;

procedure TfrmConfigBanrisul240.pGravaLogCarteira(stlCfgAnt : TStringList);
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
    pGravaLogAtb('041', 'BANRISUL', strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

procedure TfrmConfigBanrisul240.pShowHintBotao(btnBotao: TBitBtnLocked;
  strTitulo: String);
begin
  HintControler.ShowHint(btnBotao.ClientOrigin.X,btnBotao.ClientOrigin.Y, strTitulo, btnBotao.Hint);
end;

function TfrmConfigBanrisul240.RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;
begin
  While Not Sender.ClassName.Equals('TcxTabSheet') Do
  Begin
    Sender := Sender.Parent;
  End;
  Result := TcxTabSheet(Sender);

end;

end.
