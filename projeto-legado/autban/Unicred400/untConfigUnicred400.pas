unit untConfigUnicred400;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Mask, DirectoryEditFocus, Buttons,
  ExtCtrls, QColorLabel, Menus, ComCtrls, ShellApi, AppEvnts, Uni, BitBtnLockedIncrem,
  untTypesSistema, frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, StrUtils,
  ComboBoxFocus, cxTextEdit, cxMaskEdit, cxButtonEdit, dxScreenTip, cxClasses,
  dxCustomHint, cxHint,
  untFrameDirectoryEditFocus, untFramePlanoDeContasMaskEdit, dxBarBuiltInMenu,
  cxPC;

type
  TfrmConfigUnicred400 = class(TfrmPai)
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
    Label46: TLabel;
    edtCodPorRem: TEditFocus;
    edtDescPorRem: TEditFocus;
    pnlAtivo: TPanel;
    lblCodCart: TLabel;
    lblProNum: TLabel;
    lblIdentBanco: TLabel;
    lblCodAgenc: TLabel;
    lblContCorr: TLabel;
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
    ColorLabel3: TColorLabel;
    Label13: TLabel;
    lbl1: TLabel;
    Label7: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    ColorLabel2: TColorLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    lblDesCrr: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    edtResp: TEditFocus;
    edtProxNumArqRem: TEditFocus;
    edtIdentBanc: TEditFocus;
    edtParMov: TEditFocus;
    edtCodAgencia: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtObservacao5: TEditFocus;
    edtDiasCred: TEditFocus;
    edtProAce: TEditFocus;
    edtInfAdi: TEditFocus;
    edtDigAgencia: TEditFocus;
    edtDigCta: TEditFocus;
    edtNumContr: TEditFocus;
    edtSeqDia: TEditFocus;
    fraPathRemessa: TfraDirectoryEditFocus;
    fraPathRetorno: TfraDirectoryEditFocus;
    edtBraCrr: TEditFocus;
    edtEndCrr: TEditFocus;
    edtCompCrr: TEditFocus;
    edtBaiCrr: TEditFocus;
    edtCidCrr: TEditFocus;
    edtEstCrr: TEditFocus;
    edtCepCrr: TEditFocus;
    edtCgcCrr: TEditFocus;
    edtDesCrr: TEditFocus;
    edtDiasProt: TEditFocus;
    cmbIndCar: TComboBoxFocus;
    cmbInstrucao1: TComboBoxFocus;
    cmbInstrucao2: TComboBoxFocus;
    cmbCodCar: TComboBoxFocus;
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
    procedure BtnOcorrenciaEnter(Sender: TObject);
    procedure BtnOcorrenciaMouseEnter(Sender: TObject);
    procedure BtnOcorrenciaMouseLeave(Sender: TObject);
    procedure BtnOcorrenciaExit(Sender: TObject);
    procedure BtnOcorrenciaClick(Sender: TObject);
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
    { Public declarations }
    blnNaoEditar: Boolean;
    strConfig   : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigUnicred400: TfrmConfigUnicred400;

implementation

uses  untfuncoesSimples, untFuncoes,
     untPesqAux, untCfgGenericas_AutBan, untConsultas, untFuncoesGenerica, untMemo;

{$R *.dfm}

procedure TfrmConfigUnicred400.btnEditarClick(Sender: TObject);
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

procedure TfrmConfigUnicred400.btnGravarClick(Sender: TObject);
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

      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', edtProxNumArqRem.Text);
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', LeftStr(cmbCodCar.Text,2));
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCEDE', edtIdentBanc.Text    );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCEDE', edtDigCta.Text       );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text   );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', edtDigAgencia.Text   );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text         );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', LeftStr(cmbInstrucao1.Text,2));
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', LeftStr(cmbInstrucao2.Text,2));
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text  );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text  );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text  );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text  );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text  );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessa.edtDirectory.text  );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetorno.edtDirectory.text  );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text       );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text       );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContas.MskCodCta.Text       );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text     );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text       );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text       );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PARMMOV', edtParMov.Text       );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCONT', edtNumContr.Text     );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQDIAR', edtSeqDia.Text       );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CORBRAD', edtBraCrr.Text       );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DESCORR', edtDesCrr.Text       );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'ENDCORR', edtEndCrr.Text       );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'COMCORR', edtCompCrr.Text      );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'BAICORR', edtBaiCrr.Text       );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CIDCORR', edtCidCrr.Text       );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'ESTCORR', edtEstCrr.Text       );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CEPCORR', edtCepCrr.Text       );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CGCCORR', edtCgcCrr.Text       );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text     );
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'INDCART', cmbIndCar.Text       );


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

procedure TfrmConfigUnicred400.pCarregaDados;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************AF*}
  edtProxNumArqRem.Text := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '');

  If Not fEmptyStr(fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', '')) Of
      11: cmbCodCar.ItemIndex := 0;
      21: cmbCodCar.ItemIndex := 1;
      31: cmbCodCar.ItemIndex := 2;
      41: cmbCodCar.ItemIndex := 3;
      09: cmbCodCar.ItemIndex := 4;
    End;
  End
  Else
    cmbCodCar.ItemIndex := -1;

  edtIdentBanc.Text     := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCEDE', '');
  edtDigCta.Text        := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCEDE', '');
  edtCodAgencia.Text    := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtResp.Text          := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', '');

  If Not fEmptyStr(fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '')) Of
      0: cmbInstrucao1.ItemIndex := 0;
      6: cmbInstrucao1.ItemIndex := 1;
    End;
  End
  Else
    cmbInstrucao1.ItemIndex := -1;

  If Not fEmptyStr(fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', '')) Of
      0: cmbInstrucao2.ItemIndex := 0;
      6: cmbInstrucao2.ItemIndex := 1;
    End;
  End
  Else
    cmbInstrucao2.ItemIndex := -1;

  edtDigAgencia.Text    := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', '');
  edtObservacao1.Text   := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text   := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text   := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text   := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text   := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');
  fraPathRemessa.edtDirectory.text   := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '');
  fraPathRetorno.edtDirectory.text   := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '');
  edtCodPor.Text        := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  edtCodPorRem.Text      := fGetBancoConfig(0, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');
  fraPlanoDeContas.MskCodCta.Text        := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');
  edtDiasCred.Text      := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', '');
  edtProAce.Text        := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', '');
  edtInfAdi.Text        := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', '');
  edtParMov.Text        := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'PARMMOV', '');
  edtNumContr.Text      := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCONT', '');
  edtBraCrr.Text        := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CORBRAD', '');
  edtDesCrr.Text        := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DESCORR', '');
  edtEndCrr.Text        := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'ENDCORR', '');
  edtCompCrr.Text       := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'COMCORR', '');
  edtBaiCrr.Text        := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'BAICORR', '');
  edtCidCrr.Text        := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CIDCORR', '');
  edtEstCrr.Text        := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'ESTCORR', '');
  edtCepCrr.Text        := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CEPCORR', '');
  edtCgcCrr.Text        := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'CGCCORR', '');
  edtDiasProt.Text      := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '');

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'INDCART', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1), 'INDCART', '')) Of
      1: cmbIndCar.ItemIndex := 0;
      2: cmbIndCar.ItemIndex := 1;
      3: cmbIndCar.ItemIndex := 2;
      4: cmbIndCar.ItemIndex := 3;
      5: cmbIndCar.ItemIndex := 4;
    End;
  End
  Else
    cmbIndCar.ItemIndex := -1;

  If (Not fEmptyStr(fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1),'SEQDIAR',''))) Then
  Begin
    If StrToDateDef(fGetBancoConfig(0,'CONFIG090-' + IntToStr(tabCarteira.TabIndex + 1),'ULTREME', DateToStr(VS_Date)),VS_Date) = VS_Date Then
      edtSeqDia.Text    := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(tabCarteira.TabIndex + 1),'SEQDIAR','')
    Else
      edtSeqDia.Text    := '01';
  End
  Else
    edtSeqDia.Text      := '01';

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCodPorRem.Text ) Then
    pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);

  If Not fEmptyStr( fraPlanoDeContas.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);

  pHabilitaDesabilitaCamposCorrespondente;

end;

procedure TfrmConfigUnicred400.FormShow(Sender: TObject);
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

procedure TfrmConfigUnicred400.fraPlanoDeContasMskCodCtaKeyPress(
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

function TfrmConfigUnicred400.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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
        fMensagem('','Os Campos de instruções devem ser preenchidos!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else
      If cmbInstrucao1.ItemIndex = 0 Then
        edtDiasProt.Text := '00';

    End

    Else If (Sender = cmbInstrucao2) Then
    Begin

      If cmbInstrucao2.ItemIndex = -1 Then
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

    Else If (Sender = edtBraCrr) Then
    Begin
      If Pos(edtBraCrr.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Usa Correspondente (Bradesco) deve ser S ou N!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else
        pHabilitaDesabilitaCamposCorrespondente;

    End

    Else If (Sender = edtDesCrr) And
            (edtDesCrr.Enabled)  Then
    Begin
      If fEmptyStr(edtDesCrr.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Descrição (Singular Unicred) deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtEndCrr) And
            (edtEndCrr.Enabled)  Then
    Begin
      If fEmptyStr(edtEndCrr.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Endereço (Singular Unicred) deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtBaiCrr) And
            (edtBaiCrr.Enabled)  Then
    Begin
      If fEmptyStr(edtBaiCrr.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Bairro deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCidCrr) And
            (edtCidCrr.Enabled)  Then
    Begin
      If fEmptyStr(edtCidCrr.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Cidade deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtEstCrr) And
            (edtEstCrr.Enabled)  Then
    Begin
      If fEmptyStr(edtEstCrr.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Estado deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCepCrr) And
            (edtCepCrr.Enabled)  Then
    Begin
      If fEmptyStr(edtCepCrr.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo CEP deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else
        edtCepCrr.Text := fFormataCEP(edtCepCrr.Text);
    End

    Else If (Sender = edtCgcCrr) And
            (edtCgcCrr.Enabled)  Then
    Begin
      If fEmptyStr(edtCgcCrr.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo CNPJ deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else
        edtCgcCrr.Text := fFormataCpfCgc(edtCgcCrr.Text, fSetaPais);
    End

    Else If (Sender = edtDiasProt) And
            (edtDiasProt.Enabled)  Then
    Begin
      If fEmptyStr(edtDiasProt.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Dias para protesto deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else If (cmbInstrucao1.ItemIndex = 1)    And
              (StrToInt(edtDiasProt.Text) < 3) Then
      Begin
        fMensagem('ATENÇÃO!','O valor informado deve ser de no mínimo 3 dias!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else If (cmbInstrucao1.ItemIndex = 0)     And
              (StrToInt(edtDiasProt.Text) <> 0) Then
      Begin
        fMensagem('ATENÇÃO!','O valor informado deve ser 0 (zero) quando estiver utilizando a instrução 00 - Não Protestar!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = cmbIndCar) And
            (cmbIndCar.Enabled)  Then
    Begin
      If cmbIndCar.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Índice da carteira (Bradesco) deve ser informado!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtNumContr) Then
    Begin
      If fEmptyStr(edtNumContr.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Número do contrato deve ser preenchido!'+strMensagemConfig,['&O K']);
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

    Else If (Sender = edtDigAgencia) Then
    Begin
      If fEmptyStr(edtDigAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Dígito da Agência deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtIdentBanc) Then
    Begin
      If fEmptyStr(edtIdentBanc.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Conta Corrente deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigCta) Then
    Begin
      If fEmptyStr(edtDigCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Dígito da Conta Corrente deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtParMov) Then
    Begin
      If fEmptyStr(edtParMov.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Parâmetro de Movimento deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = cmbCodCar)Then
    Begin
      If cmbCodCar.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Código da carteita deve ser informado!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

  End;

  If Not Result Then
    if not blnNaoEditar then
      pSetFocus(Sender);

End;

procedure TfrmConfigUnicred400.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmConfigUnicred400.tabCarteiraChanging(Sender: TObject;
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

procedure TfrmConfigUnicred400.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
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

procedure TfrmConfigUnicred400.edtCodPorRemKeyPress(Sender: TObject;
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

procedure TfrmConfigUnicred400.pAlteraHintBotao(btnBotao: TBitBtnLocked;
  strNovoHint: String);
begin
  btnBotao.Hint := strNovoHint;
end;

procedure TfrmConfigUnicred400.pCarregaCentroCusto(strCtaBai: String;
  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmConfigUnicred400.pCarregaPortador(strCodPor: String;
  edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtLabel.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmConfigUnicred400.pHabilitaDesabilitaCamposCorrespondente;
begin
  If edtBraCrr.Text = 'S' Then
  Begin
    edtDesCrr.Enabled  := True;
    edtEndCrr.Enabled  := True;
    edtCompCrr.Enabled := True;
    edtBaiCrr.Enabled  := True;
    edtCidCrr.Enabled  := True;
    edtEstCrr.Enabled  := True;
    edtCepCrr.Enabled  := True;
    edtCgcCrr.Enabled  := True;
    edtDiasProt.Enabled:= True;
    cmbIndCar.Enabled  := True;
  End
  Else
  Begin
    edtDesCrr.Enabled  := False;
    edtEndCrr.Enabled  := False;
    edtCompCrr.Enabled := False;
    edtBaiCrr.Enabled  := False;
    edtCidCrr.Enabled  := False;
    edtEstCrr.Enabled  := False;
    edtCepCrr.Enabled  := False;
    edtCgcCrr.Enabled  := False;
    edtDiasProt.Enabled:= False;
    cmbIndCar.Enabled  := False;
  End;
end;

procedure TfrmConfigUnicred400.pHideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmConfigUnicred400.pShowHintBotao(btnBotao: TBitBtnLocked;
  strTitulo: String);
begin
  HintControler.ShowHint(btnBotao.ClientOrigin.X,btnBotao.ClientOrigin.Y, strTitulo, btnBotao.Hint);
end;

procedure TfrmConfigUnicred400.FormCreate(Sender: TObject);
begin
  inherited;
  cxPaginas.Properties.ActivePage := tbsGeral;
  qryCadPor := fCriaQuery(Self);
  pCarKeyAutBan;

end;

procedure TfrmConfigUnicred400.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigUnicred400.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigUnicred400.btnCancelarClick(Sender: TObject);
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

procedure TfrmConfigUnicred400.btnConfigurarClick(Sender: TObject);
begin
  inherited;

  Try
    pCriarFormularios(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '090';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;


end;

procedure TfrmConfigUnicred400.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\090400p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\090400p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigUnicred400.BtnOcorrenciaClick(Sender: TObject);
Var
  strDetalhe : String;
begin
  inherited;
  pHideHint;

  strDetalhe := #13#10 +
                '02 - Entrada Confirmada; ' + #13#10 +
                '06 - Liquidação normal; ' + #13#10 +
                '09 - Baixado Automaticamente via Arquivo;' + #13#10 +
                'As demais ocorrências são gravadas na rotina ' +
                'de retorno e mostradas no relatório apenas em ' +
                'caráter informativo.'+ #13#10 +
                #13#10 +
                'Pressione Esc para voltar à tela de configurações.';

  TfrmMemo.pShowMessage('Banco 090 - Banco Unicred400 - Detalhamento de Ocorrências.' + #13#10 +
                        strDetalhe);
end;

procedure TfrmConfigUnicred400.BtnOcorrenciaEnter(Sender: TObject);
begin
  inherited;
  pAlteraHintBotao(btnOcorrencia, 'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
                                  'que são tratados pelas rotinas do sistema.');
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigUnicred400.BtnOcorrenciaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigUnicred400.BtnOcorrenciaMouseEnter(Sender: TObject);
begin
  inherited;
  pAlteraHintBotao(btnOcorrencia, 'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
                                  'que são tratados pelas rotinas do sistema.');
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigUnicred400.BtnOcorrenciaMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigUnicred400.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Seq. remessa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  stlCampos.Add('Num. contrato     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCONT', ''));
  stlCampos.Add('Cód. agência      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Díg. agência      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', ''));
  stlCampos.Add('Cód. C/C          :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCEDE', ''));
  stlCampos.Add('Díg. C/C          :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCEDE', ''));
  stlCampos.Add('Parâm. movimento  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PARMMOV', ''));
  stlCampos.Add('Cód. carteira     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', ''));
  stlCampos.Add('Cód. instrução 1  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', ''));
  stlCampos.Add('Cód. instrução 2  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', ''));
  stlCampos.Add('Observação 1      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Observação 3      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  stlCampos.Add('Observação 4      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  stlCampos.Add('Observação 5      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  stlCampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  stlCampos.Add('Arquivo remessa   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo retorno   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  stlCampos.Add('Responsável Bol.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', ''));
  stlCampos.Add('Protocolo aceite  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', ''));
  stlCampos.Add('Portador de baixa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Portador da remessa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', ''));
  stlCampos.Add('Conta de baixa    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Inf. adicional    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', ''));
  stlCampos.Add('Seq. diário       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SEQDIAR', ''));
  stlCampos.Add('Corresp. Bradesco :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CORBRAD', ''));
  stlCampos.Add('Índice carteira   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INDCART', ''));
  stlCampos.Add('Descrição         :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DESCORR', ''));
  stlCampos.Add('Endereço          :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ENDCORR', ''));
  stlCampos.Add('Complemento       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'COMCORR', ''));
  stlCampos.Add('Bairro            :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'BAICORR', ''));
  stlCampos.Add('Cidade            :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CIDCORR', ''));
  stlCampos.Add('Estado            :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ESTCORR', ''));
  stlCampos.Add('CEP               :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CEPCORR', ''));
  stlCampos.Add('CGC               :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CGCCORR', ''));
  stlCampos.Add('Dias p/ protesto  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
end;

procedure TfrmConfigUnicred400.pGravaLogCarteira(stlCfgAnt : TStringList);
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
    pGravaLogAtb('090', 'BANCO UNICRED 400', strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

end.
