unit untConfigAthenaAtlanta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, DirectoryEditFocus, StdCtrls, EditFocus, Buttons,
  ExtCtrls, QColorLabel, Menus, ComCtrls, ShellApi, AppEvnts, Uni, BitBtnLockedIncrem,
  untTypesSistema, frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxButtonEdit, strUtils,
  dxScreenTip, cxClasses, dxCustomHint, cxHint, ComboBoxFocus, MaskEditFocus, 
  untFrameDirectoryEditFocus, untFramePlanoDeContasMaskEdit, dxBarBuiltInMenu,
  cxPC;

type
  TfrmConfigAthenaAtlanta = class(TfrmPai)
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
    Label5: TLabel;
    lblCodAgenc: TLabel;
    lblCodCart: TLabel;
    lblContCorr: TLabel;
    lblDiasProt: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    lblProNum: TLabel;
    lblResp: TLabel;
    ColorLabel2: TColorLabel;
    Label4: TLabel;
    Label1: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    ColorLabel3: TColorLabel;
    Label7: TLabel;
    Label2: TLabel;
    ColorLabel5: TColorLabel;
    Label16: TLabel;
    Label17: TLabel;
    lblCartSeq: TLabel;
    Label27: TLabel;
    Label3: TLabel;
    ColorLabel1: TColorLabel;
    edtResp: TEditFocus;
    edtProxNumArqRem: TEditFocus;
    edtDigCtaCor: TEditFocus;
    edtDiasProt: TEditFocus;
    edtContaCorr: TEditFocus;
    edtCodEmpBanco: TEditFocus;
    edtCodCar: TEditFocus;
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
    edtExpBol: TEditFocus;
    edtPerMul: TEditFocus;
    edtInfAdi: TEditFocus;
    fraPathRemessaBDC: TfraDirectoryEditFocus;
    fraPathRetornoBDC: TfraDirectoryEditFocus;
    cmbInstrucao1: TComboBoxFocus;
    edtCartSeq: TEditFocus;
    chkCartSeq: TCheckBox;
    edtDigAge: TEditFocus;
    edtDiasCartorio: TEditFocus;
    edtEnviarChaveNFe: TEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    procedure btnGravarClick(Sender: TObject);
    procedure pCarregaDados;
    procedure FormShow(Sender: TObject);
    procedure tabCarteiraChange(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure BtnManualClick(Sender: TObject);
    procedure edtDiasCredEnter(Sender: TObject);
    procedure edtDiasCredExit(Sender: TObject);
    procedure btnConfigurarEnter(Sender: TObject);
    procedure btnConfigurarExit(Sender: TObject);
    procedure cmbInstrucao1Change(Sender: TObject);
    procedure BtnOcorrenciaEnter(Sender: TObject);
    procedure BtnOcorrenciaExit(Sender: TObject);
    procedure BtnOcorrenciaClick(Sender: TObject);
    procedure chkCartSeqClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure edtDiasCartorioEnter(Sender: TObject);
    procedure edtDiasCartorioExit(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorRemKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;

    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pCarregaCentroCusto(strCtaBai: String; edtLabel: TEdit);
    procedure pShowHint(edtEdit: TEditFocus; strTitulo: String);
    procedure pShowHintBotao(btnBotao: TBitBtnLocked; strTitulo: String);
    procedure pHideHint;
    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
  public
    blnNaoEditar: Boolean;
    strConfig   : String;
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigAthenaAtlanta: TfrmConfigAthenaAtlanta;

implementation

uses untPesqAux, untFuncoesSimples, untFuncoes,
  untCfgGenericas_AutBan, untConsultas, untMemo;

{$R *.dfm}

procedure TfrmConfigAthenaAtlanta.btnConfigurarEnter(Sender: TObject);
begin
  inherited;
  btnConfigurar.Hint := 'Configurar percentual de ' + #13+#10 +
                        'juros para remessa.';
  pShowHintBotao(btnConfigurar, 'Cofigurações específicas.');
end;

procedure TfrmConfigAthenaAtlanta.btnConfigurarExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigAthenaAtlanta.btnEditarClick(Sender: TObject);
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
      pSetFocus(edtExpBol);

  end;
end;

procedure TfrmConfigAthenaAtlanta.btnGravarClick(Sender: TObject);
Var
  stlCfgAnt : TStringList;
begin
  inherited;

  If fVerificaCampos Then
  Begin
    If (chkCartSeq.Checked) Then
    Begin
      If edtProxNumArqRem.Text <> fRetProxNumAutBan('CONFIG996-' + edtCartSeq.Text) Then
      Begin
        If fMensagem('ATENÇÃO','Ao utilizar a sequência do arquivo de remessa de outra carteira, o campo Último Núm. de Seq. Arq. Remessa será sobrescrito pelo da carteira principal. Deseja continuar?',['&SIM', '&NÃO'], 1) = 2 Then
          Exit;
      End;
    End;

    Try
      stlCfgAnt := TStringList.Create;
      pCarregaCfg(stlCfgAnt);

      fGetBancoConfig(1, 'CONFIG237-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', IIF(chkCartSeq.Checked, fRetProxNumAutBan('CONFIG237-' + edtCartSeq.Text), edtProxNumArqRem.Text));
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', IIF(chkCartSeq.Checked, fRetProxNumAutBan('CONFIG996-' + edtCartSeq.Text), edtProxNumArqRem.Text));
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'CODEMPR', edtCodEmpBanco.Text   );
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', edtCodCar.Text        );
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text    );
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', edtDigAge.Text        );
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text     );
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', edtDigCtaCor.Text     );
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text      );
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text          );
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', LeftStr(cmbInstrucao1.Text,2));
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text   );
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text   );
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text   );
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text   );
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text   );
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessaBDC.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetornoBDC.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text        );
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text       );
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContas.MskCodCta.Text        );
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text      );
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACART', edtDiasCartorio.Text  );
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text        );
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPOBOL', edtExpBol.Text        );
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', edtPerMul.Text        );
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text        );
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', IIF(chkCartSeq.Checked, 'S', 'N'));
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', IIF(chkCartSeq.Checked, edtCartSeq.Text, ''));
      fGetBancoConfig(1, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'ENV_NFE', edtEnviarChaveNFe.Text);

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        pBackupCnfBco;
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        edtProxNumArqRem.Enabled := False;
        pSetFocus(edtExpBol);
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

      pCarregaDados;
    Except
      On E:Exception Do
      Begin
        fMensagem('Erro','Ocorreu um erro ao tentar salvar os dados.' + #13 + E.Message,['&O K']);
      End;
    End;

    FreeAndNil(stlCfgAnt);

  End;
end;

procedure TfrmConfigAthenaAtlanta.pCarregaDados;
begin

  {*****************}
  {* CARREGA DADOS *}
  {**************AF*}
  If fEmptyStr(fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '')) Then
  Begin
    edtProxNumArqRem.Enabled := True;
    edtProxNumArqRem.Clear;
    pSetFocus(edtProxNumArqRem);
  End
  Else
  Begin
    edtProxNumArqRem.Text  := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '');
    edtProxNumArqRem.Enabled := False;
    pSetFocus(edtExpBol);
  End;

  if (strLoginUsuarioLogado='997') or(strLoginUsuarioLogado='998') or (strLoginUsuarioLogado='999') Then
  begin
    edtProxNumArqRem.Enabled := True;
    pSetFocus(edtProxNumArqRem);
  End;

  edtCodEmpBanco.Text    := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'CODEMPR', '');
  edtCodCar.Text         := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', '');
  edtCodAgencia.Text     := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtContaCorr.Text      := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', '');
  edtDigCtaCor.Text      := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', '');
  edtDiasProt.Text       := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '');
  edtResp.Text           := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', '');

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '')) Of
      00 : cmbInstrucao1.ItemIndex := 0;
      05 : cmbInstrucao1.ItemIndex := 1;
      06 : cmbInstrucao1.ItemIndex := 2;
      07 : cmbInstrucao1.ItemIndex := 3;
      08 : cmbInstrucao1.ItemIndex := 4;
      09 : cmbInstrucao1.ItemIndex := 5;
      10 : cmbInstrucao1.ItemIndex := 6;
      11 : cmbInstrucao1.ItemIndex := 7;
      12 : cmbInstrucao1.ItemIndex := 8;
      13 : cmbInstrucao1.ItemIndex := 9;
      14 : cmbInstrucao1.ItemIndex := 10;
      15 : cmbInstrucao1.ItemIndex := 11;
      18 : cmbInstrucao1.ItemIndex := 12;
    End;
  End
  Else
    cmbInstrucao1.ItemIndex := -1;

  edtDesPor.Text := '';
  edtDescPorRem.Text := '';
  fraPlanoDeContas.edtDesCta.Text := '';

  edtObservacao1.Text    := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text    := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text    := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text    := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text    := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');
  fraPathRemessaBDC.edtDirectory.text := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '');
  fraPathRetornoBDC.edtDirectory.text := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '');
  edtCodPor.Text         := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  edtCodPorRem.Text      := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');
  fraPlanoDeContas.MskCodCta.Text         := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');
  edtDiasCred.Text       := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', '');
  edtDiasCartorio.Text   := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACART', '');
  edtProAce.Text         := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', '');
  edtDigAge.Text         := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', '');
  edtExpBol.Text         := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPOBOL', '');
  edtPerMul.Text         := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', '');
  edtInfAdi.Text         := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', '');
  chkCartSeq.Checked     := (fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', '') = 'S');
  edtCartSeq.Text        := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', '');
  edtEnviarChaveNFe.Text := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(tabCarteira.TabIndex + 1), 'ENV_NFE', '');

  chkCartSeq.OnClick(chkCartSeq);

  If fEmptyStr(edtEnviarChaveNFe.Text) then
    edtEnviarChaveNFe.Text := 'N';

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCodPorRem.Text ) Then
    pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);

  If Not fEmptyStr( fraPlanoDeContas.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);

end;

procedure TfrmConfigAthenaAtlanta.FormShow(Sender: TObject);
begin
  inherited;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  pCarregaDados;

  If edtProxNumArqRem.Enabled Then
    pSetFocus(edtProxNumArqRem)
  Else
    pSetFocus(edtExpBol);

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

procedure TfrmConfigAthenaAtlanta.fraPlanoDeContasMskCodCtaKeyPress(
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

function TfrmConfigAthenaAtlanta.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
var
  strMensagemConfig: String;
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
      Else
      If StrToInt(edtProxNumArqRem.Text) < 0 Then
      Begin
        fMensagem('', 'O Último Núm. Arq. Remessa deve ser maior ou igual a zero!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtExpBol Then
    Begin
      If Pos(edtExpBol.Text, '1_2_') <= 0 Then
      Begin
        fMensagem('','O campo a ser exportado para o boleto deve ser preenchido com (1/2)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = cmbInstrucao1) Then
    Begin

      If cmbInstrucao1.ItemIndex = -1 Then
      Begin
        fMensagem('','O Campo de instrução devem ser preenchidos!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else If cmbInstrucao1.ItemIndex = 11 Then
        edtDiasProt.Clear;

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

    Else If Sender = edtEnviarChaveNFe Then
    Begin
      If Pos(edtEnviarChaveNFe.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Enviar Chave NF-e deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
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

      If fEmptyStr(edtContaCorr.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Número Conta Corrente deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else If Length(edtContaCorr.Text) <> edtContaCorr.MaxLength Then
      Begin
        fMensagem('ATENÇÃO','O Número Conta Corrente deve ter 7 caracteres!',['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigCtaCor) Then
    Begin

      If fEmptyStr(edtDigCtaCor.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Dígito da Conta Corrente deve ser preenchido!'+strMensagemConfig,['&OK']);
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

    Else If Sender = edtCodCar Then
    Begin
      If fEmptyStr(edtCodCar.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Código da Carteira deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End
    End

    Else If (Sender = edtCodEmpBanco) Then
    Begin
      If fEmptyStr(edtCodEmpBanco.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Cedente deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else If Length(edtCodEmpBanco.Text) <> edtCodEmpBanco.MaxLength Then
      Begin
        fMensagem('ATENÇÃO','O Campo Cedente deve ter 8 caracteres!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodAgencia) Then
    Begin
      If fEmptyStr(edtCodAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Código da Agência deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else If Length(edtCodAgencia.Text) <> edtCodAgencia.MaxLength Then
      Begin
        fMensagem('ATENÇÃO','O campo Código da Agência deve ter 5 caracteres!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigAge) Then
    Begin
      If fEmptyStr(edtDigAge.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Dígito da Agência deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtDiasProt) Then
    Begin
      If cmbInstrucao1.ItemIndex in [1,2,3,12] Then
      Begin
        If fEmptyStr(edtDiasProt.Text) Then
        Begin
          fMensagem('ATENÇÃO','O campo Dias para protesto/decurso deve ser preenchido!'+strMensagemConfig,['&O K']);
          Result := False;
        End
        Else If (StrToInt(edtDiasProt.Text) < 5) And (cmbInstrucao1.ItemIndex <> 12) Then
        Begin
          fMensagem('ATENÇÃO','A quantidade de dias informada deve ser de no mínimo 5 dias!'+strMensagemConfig,['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = chkCartSeq) Then
    Begin
      If (chkCartSeq.Checked) Then
      Begin
        If fVerificaCartPrimariaAutBan('CONFIG996-', tabCarteira.TabIndex + 1) Then
        Begin
          fMensagem('ATENÇÃO','Não pode ser utilizada sequência de Arquivo de Remessa de outra carteira, pois essa está cadastrada no campo Carteira Seq. de outra(s) carteira(s).' ,['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCartSeq) Then
    Begin
      If (chkCartSeq.Checked) Then
      Begin
        If fEmptyStr(edtCartSeq.Text) Then
        Begin
          fMensagem('ATENÇÃO','O campo Carteira Seq. deve ser preenchido!' ,['&O K']);
          Result := False;
        End
        Else
        Begin
          If (Pos(edtCartSeq.Text, '1_2_3_4_5_') <= 0) Then
          Begin
            fMensagem('ATENÇÃO','O campo Carteira Seq. deve ter valor entre 1 e 5!' ,['&O K']);
            Result := False;
          End
          Else
          If edtCartSeq.Text = IntToStr(tabCarteira.TabIndex + 1) Then
          Begin
            fMensagem('ATENÇÃO','O campo Carteira Seq. não pode ser igual a carteira selecionada!' ,['&O K']);
            Result := False;
          End
          Else
          If fEmptyStr(fGetBancoConfig(0, 'CONFIG996-' + edtCartSeq.Text, 'PROXNUM', '')) Then
          Begin
            fMensagem('ATENÇÃO','Não pode ser usada essa carteira no campo Carteira Seq., pois essa não possui Último Núm. Seq. Remessa cadastrado!' ,['&O K']);
            Result := False;
          End
          Else
          If fVerificaCartFilhaAutBan('CONFIG996-' + edtCartSeq.Text) Then
          Begin
            fMensagem('ATENÇÃO','Não pode ser usada essa carteira no campo Carteira Seq., pois essa já possui uma Carteira Seq. cadastrada!' ,['&O K']);
            Result := False;
          End;
        End;
      End;
    End
  End;
  If Not Result Then
    if not blnNaoEditar then
        pSetFocus(Sender);

End;

procedure TfrmConfigAthenaAtlanta.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmConfigAthenaAtlanta.tabCarteiraChanging(Sender: TObject;
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

procedure TfrmConfigAthenaAtlanta.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmConfigAthenaAtlanta.edtCodPorRemKeyPress(Sender: TObject;
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


procedure TfrmConfigAthenaAtlanta.edtDiasCartorioEnter(Sender: TObject);
begin
  inherited;
  edtDiasCartorio.Hint := 'Informar quantidade de dias ' + #13+#10 +
                          'após data de vencimento ' + #13+#10 +
                          'para ir ao cartório. ';

  pShowHint(edtDiasCartorio, 'Dias para Cartório');
end;

procedure TfrmConfigAthenaAtlanta.edtDiasCartorioExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigAthenaAtlanta.edtDiasCredEnter(Sender: TObject);
begin
  inherited;
  edtDiasCred.Hint := 'Informar quantidade de dias ' + #13+#10 +
                      'do intervalo entre a efetuação ' + #13+#10 +
                      'do pagamento e o crédito na ' + #13+#10 +
                      'conta corrente.';

  pShowHint(edtDiasCred, 'Dias para Crédito');
end;

procedure TfrmConfigAthenaAtlanta.edtDiasCredExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigAthenaAtlanta.pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;

end;

procedure TfrmConfigAthenaAtlanta.pCarregaPortador(strCodPor: String; edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtLabel.Text := FieldByName('POR_NOMPOR').AsString;
  End;

end;                   

procedure TfrmConfigAthenaAtlanta.pHideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmConfigAthenaAtlanta.pShowHint(edtEdit: TEditFocus; strTitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,edtEdit.ClientOrigin.Y, strTitulo, edtEdit.Hint);
end;

procedure TfrmConfigAthenaAtlanta.pShowHintBotao(btnBotao: TBitBtnLocked;
  strTitulo: String);
begin
  HintControler.ShowHint(btnBotao.ClientOrigin.X,btnBotao.ClientOrigin.Y, strTitulo, btnBotao.Hint);
end;

procedure TfrmConfigAthenaAtlanta.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  pCarKeyAutBan;
  cxPaginas.Properties.ActivePage := tbsGeral;
end;

procedure TfrmConfigAthenaAtlanta.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigAthenaAtlanta.btnCancelarClick(Sender: TObject);
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

procedure TfrmConfigAthenaAtlanta.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pHideHint;

    pCriarFormularios(TfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '996';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigAthenaAtlanta.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\996400p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\996400p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigAthenaAtlanta.BtnOcorrenciaClick(Sender: TObject);
  Var
    strDetalhe : String;
begin
  inherited;
  pHideHint;

  strDetalhe := #13#10 +
                '06, 15, 17 - Baixa duplicata; ' + #13#10 +
                '02 - Atualiza nosso número caso não tenha gravado; ' + #13#10 +
                '23 - Lança histórico de protesto; ' + #13#10 +
                '10 - Marca a duplicata como ''DP DESCONTADA'' igual a ''Sim''; ' + #13#10 +
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


  TfrmMemo.pShowMessage('Banco 996 - Athena Atlanta - Detalhamento de Ocorrências (posições 109 - 110 arquivo retorno).' + #13#10 +
                        strDetalhe);
end;

procedure TfrmConfigAthenaAtlanta.BtnOcorrenciaEnter(Sender: TObject);
begin
  inherited;
  btnOcorrencia.Hint := 'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
                        'que são tratados pelas rotinas do sistema.';
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigAthenaAtlanta.BtnOcorrenciaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigAthenaAtlanta.chkCartSeqClick(Sender: TObject);
begin
  inherited;
  If Not fValidaCampos(chkCartSeq) Then
    TCheckBox(Sender).Checked := False;

  lblCartSeq.Enabled := TCheckBox(Sender).Checked;
  edtCartSeq.Enabled := TCheckBox(Sender).Checked;
end;

procedure TfrmConfigAthenaAtlanta.cmbInstrucao1Change(Sender: TObject);
begin
  inherited;
  If cmbInstrucao1.ItemIndex = 0 Then
    edtDiasProt.Enabled := False
  Else
    edtDiasProt.Enabled := True;
end;

procedure TfrmConfigAthenaAtlanta.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Seq. Remessa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  stlCampos.Add('Util Seq outr Cart:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', ''));
  stlCampos.Add('Carteira Seq.     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', ''));
  stlCampos.Add('Exporta p/ Boleto :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'EXPOBOL', ''));
  stlCampos.Add('Cód. Carteira     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', ''));
  stlCampos.Add('Cód. Emp. Banco   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODEMPR', ''));
  stlCampos.Add('Cód. Agência      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Díg. Agência      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', ''));
  stlCampos.Add('Cta. Corrente     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  stlCampos.Add('Dígito C/C        :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', ''));
  stlCampos.Add('Tipo de cobrança  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TIPCOBR', ''));
  stlCampos.Add('Núm. Autorização  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMAUTO', ''));
  stlCampos.Add('Cód. Instrução    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', ''));
  stlCampos.Add('Percentual multa  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', ''));
  stlCampos.Add('Observação 1      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Observação 3      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  stlCampos.Add('Observação 4      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  stlCampos.Add('Observação 5      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  stlCampos.Add('Dias p/ protesto  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  stlCampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  stlCampos.Add('Arquivo Remessa   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo Retorno   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  stlCampos.Add('Responsável Bol.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', ''));
  stlCampos.Add('Prot. de aceite   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', ''));
  stlCampos.Add('Portador de baixa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Portador da remessa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', ''));
  stlCampos.Add('Conta de baixa    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Inf. adicional    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', ''));
  stlCampos.Add('Outros acréscimos :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OUTACRE', ''));
  stlCampos.Add('Envia mensagens   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'MANDMSG', ''));
  stlCampos.Add('Envia Sac/Avalista:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', ''));
  stlCampos.Add('Nome beneficiário :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', ''));
  stlCampos.Add('Endereço          :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', ''));
  stlCampos.Add('Bairro            :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', ''));
  stlCampos.Add('Complemento       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', ''));
  stlCampos.Add('Cidade            :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', ''));
  stlCampos.Add('Estado            :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', ''));
  stlCampos.Add('CEP               :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', ''));
  stlCampos.Add('CNPJ              :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', ''));
  stlCampos.Add('Exibe mensagens   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'EXIBMSG', ''));
  stlCampos.Add('Quantidade de Dias para Cartório:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACART', ''));
  stlCampos.Add('Enviar chave da NF-e (Remessa):' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ENV_NFE', ''));


end;

procedure TfrmConfigAthenaAtlanta.pGravaLogCarteira(stlCfgAnt : TStringList);
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
    pGravaLogAtb('996', 'Athena Atlanta', strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

end.

