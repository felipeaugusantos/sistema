unit untConfigBancoob;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Mask, DirectoryEditFocus, Buttons,
  ExtCtrls, QColorLabel, Menus, ComCtrls, ShellApi, AppEvnts, Uni, BitBtnLockedIncrem,
  untTypesSistema, frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  dxScreenTip, cxClasses, dxCustomHint, cxHint, 
  untFrameDirectoryEditFocus, untFramePlanoDeContasMaskEdit, dxBarBuiltInMenu,
  cxPC;

type
  TfrmConfigBancoob = class(TfrmPai)
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
    Label7: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    lbl1: TLabel;
    Label20: TLabel;
    ColorLabel2: TColorLabel;
    Label21: TLabel;
    ColorLabel4: TColorLabel;
    lblCartSeq: TLabel;
    edtProxNumArqRem: TEditFocus;
    edtCodCed: TEditFocus;
    edtDiasProt: TEditFocus;
    edtNumCon: TEditFocus;
    edtCodCar: TEditFocus;
    edtCodCop: TEditFocus;
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
    edtDigCed: TEditFocus;
    edtDigCop: TEditFocus;
    edtComand: TEditFocus;
    edtModali: TEditFocus;
    edtConCli: TEditFocus;
    edtPerMul: TEditFocus;
    edtCtaCor: TEditFocus;
    edtDigCta: TEditFocus;
    edtInfAdi: TEditFocus;
    edtLayPar: TEditFocus;
    edtResEnv: TEditFocus;
    fraPathRemessa: TfraDirectoryEditFocus;
    fraPathRetorno: TfraDirectoryEditFocus;
    chkCartSeq: TCheckBox;
    edtCartSeq: TEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    lblPerImpBol: TLabel;
    edtPerImpBol: TEditFocus;
    clbPerImpBol: TColorLabel;
    procedure btnGravarClick(Sender: TObject);
    procedure pCarregaDados;
    procedure FormShow(Sender: TObject);
    procedure tabCarteiraChange(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure BtnManualClick(Sender: TObject);
    procedure chkCartSeqClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure BtnOcorrenciaClick(Sender: TObject);
    procedure BtnOcorrenciaEnter(Sender: TObject);
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
    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
    procedure pAlteraHintBotao(btnBotao: TBitBtnLocked; strNovoHint: String);
    procedure pShowHintBotao(btnBotao: TBitBtnLocked; strTitulo: String);
    procedure pHideHint;
  public
    { Public declarations }
    blnNaoEditar : Boolean;
    strConfig    : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigBancoob: TfrmConfigBancoob;

implementation

uses untfuncoesSimples, untFuncoes,
     untPesqAux, untCfgGenericas_AutBan, untConsultas, untMemo;

{$R *.dfm}

procedure TfrmConfigBancoob.btnEditarClick(Sender: TObject);
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

procedure TfrmConfigBancoob.btnGravarClick(Sender: TObject);
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

    If (chkCartSeq.Checked) Then
    Begin
      If edtProxNumArqRem.Text <> fRetProxNumAutBan('CONFIG756-' + edtCartSeq.Text) Then
      Begin
        If fMensagem('ATENÇÃO','Ao utilizar a sequência do arquivo de remessa de outra carteira, o campo Último Núm. de Seq. Arq. Remessa será sobrescrito pelo da carteira principal. Deseja continuar?',['&SIM', '&NÃO'], 1) = 2 Then
          Exit;
      End;
    End;

    Try
      stlCfgAnt := TStringList.Create;
      pCarregaCfg(stlCfgAnt);

      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', IIF(chkCartSeq.Checked, fRetProxNumAutBan('CONFIG756-' + edtCartSeq.Text), edtProxNumArqRem.Text));
      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', edtCodCar.Text       );

      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCOPE', edtCodCop.Text       );
      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCOPE', edtDigCop.Text       );
      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCEDE', edtCodCed.Text       );
      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCEDE', edtDigCed.Text       );
      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCCOR', edtCtaCor.Text       );
      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCCOR', edtDigCta.Text       );
      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCONV', edtNumCon.Text       );
      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'CONVCLI', edtConCli.Text       );

      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', edtInstrucao1.Text   );
      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', edtInstrucao2.Text   );
      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text  );
      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text  );
      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text  );
      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text  );
      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text  );

      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text     );
      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text     );

      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessa.edtDirectory.text  );
      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetorno.edtDirectory.text  );

      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text       );

      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text         );
      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text       );

      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text       );
      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text       );

      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContas.MskCodCta.Text   );

      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'COMANDO', edtComand.Text       );
      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'MODALID', edtModali.Text       );

      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', edtPerMul.Text       );
      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text       );

      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'LAYPARA', edtLayPar.Text       );
      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPENV', edtResEnv.Text       );
      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', IIF(chkCartSeq.Checked, 'S', 'N'));
      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', IIF(chkCartSeq.Checked, edtCartSeq.Text, ''));
      fGetBancoConfig(1, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', edtPerImpBol.Text       );

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        pBackupCnfBco;
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        pCarregaDados;
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

procedure TfrmConfigBancoob.pCarregaDados;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************JB*}

  edtDesPor.Text        := '';
  edtDescPorRem.Text := '';
  fraPlanoDeContas.edtDesCta.Text := '';
  edtProxNumArqRem.Text := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'PROXNUM','');
  edtCodCar.Text        := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'CODCART','');

  edtCodCop.Text        := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'CODCOPE','');
  edtDigCop.Text        := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'DIGCOPE','');
  edtCodCed.Text        := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'CODCEDE','');
  edtDigCed.Text        := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'DIGCEDE','');
  edtCtaCor.Text        := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'CODCCOR','');
  edtDigCta.Text        := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'DIGCCOR','');
  edtNumCon.Text        := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'NUMCONV','');
  edtConCli.Text        := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'CONVCLI','');

  edtInstrucao1.Text    := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU1','');
  edtInstrucao2.Text    := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU2','');
  edtObservacao1.Text   := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'OBSERV1','');
  edtObservacao2.Text   := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'OBSERV2','');
  edtObservacao3.Text   := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'OBSERV3','');
  edtObservacao4.Text   := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'OBSERV4','');
  edtObservacao5.Text   := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'OBSERV5','');

  edtDiasProt.Text      := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'DIAPROT','');
  edtDiasCred.Text      := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'DIACRED','');

  fraPathRemessa.edtDirectory.text   := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'PATHREM','');
  fraPathRetorno.edtDirectory.text   := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'PATHRET','');

  edtProAce.Text        := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'PROACEI','');

  edtResp.Text          := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'RESPONS','');
  edtProAce.Text        := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'PROACEI','');

  edtCodPor.Text        := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'PORBAI_','');
  edtCodPorRem.Text      := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');

  fraPlanoDeContas.MskCodCta.Text := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'CTABAI_','');

  edtComand.Text        := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'COMANDO','');
  edtModali.Text        := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'MODALID','');

  edtPerMul.Text        := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'PERMULT','');
  edtInfAdi.Text        := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'INFADIC','');

  edtLayPar.Text        := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'LAYPARA','');
  edtResEnv.Text        := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1),'RESPENV','');
  chkCartSeq.Checked    := (fGetBancoConfig(0, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', '') = 'S');
  edtCartSeq.Text       := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', '');

  chkCartSeq.OnClick(chkCartSeq);

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCodPorRem.Text ) Then
    pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);

  If Not fEmptyStr( fraPlanoDeContas.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);

  edtPerImpBol.Text     := fGetBancoConfig(0,'CONFIG756-' + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', '');
  If fEmptyStr(edtPerImpBol.Text) Then
    edtPerImpBol.Text := 'S';

  edtproxNumArqRem.Enabled := fEmptyStr(edtProxNumArqRem.Text);


  if (strLoginUsuarioLogado='997') or(strLoginUsuarioLogado='998') or (strLoginUsuarioLogado='999') Then
  begin
    edtProxNumArqRem.Enabled := True;
    pSetFocus(edtProxNumArqRem);
  End;

end;

procedure TfrmConfigBancoob.FormShow(Sender: TObject);
begin
  inherited;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  pCarregaDados;
  If fEmptyStr(edtProxNumArqRem.Text) Then
    pSetFocus(edtProxNumArqRem)
  Else
    pSetFocus(edtCodCar);

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

procedure TfrmConfigBancoob.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
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

function TfrmConfigBancoob.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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

    Else If (Sender = edtInstrucao1) Then
    Begin

      If fEmptyStr(edtInstrucao1.Text) Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!'+strMensagemConfig,['&OK']);
        Result := False;
      End

    End

    Else If (Sender = edtInstrucao2) Then
    Begin

      If fEmptyStr(edtInstrucao2.Text) Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!'+strMensagemConfig,['&OK']);
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
            fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este operador!'+strMensagemConfig, ['&Ok']);
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
        Else If Not PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text) Then
          Result := False;

      End;

    End

    Else If Sender = edtLayPar Then
    Begin
      If Pos(edtLayPar.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Usa layout do Paraná deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtResEnv Then
    Begin

      If (edtResEnv.Text <> 'B') And (edtResEnv.Text <> 'E') Then
      Begin
        fMensagem('','O campo Resp. pelo envio dos boletos deve ser B ou E!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = chkCartSeq) Then
    Begin
      If (chkCartSeq.Checked) Then
      Begin
        If fVerificaCartPrimariaAutBan('CONFIG756-', tabCarteira.TabIndex + 1) Then
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
          If fEmptyStr(fGetBancoConfig(0, 'CONFIG756-' + edtCartSeq.Text, 'PROXNUM', '')) Then
          Begin
            fMensagem('ATENÇÃO','Não pode ser usada essa carteira no campo Carteira Seq., pois essa não possui Último Núm. Seq. Remessa cadastrado!' ,['&O K']);
            Result := False;
          End
          Else
          If fVerificaCartFilhaAutBan('CONFIG756-' + edtCartSeq.Text) Then
          Begin
            fMensagem('ATENÇÃO','Não pode ser usada essa carteira no campo Carteira Seq., pois essa já possui uma Carteira Seq. cadastrada!' ,['&O K']);
            Result := False;
          End;
        End;
      End;
    End;

  End;

  If Not Result Then
    if not blnNaoEditar then
      pSetFocus(Sender);

End;

procedure TfrmConfigBancoob.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmConfigBancoob.tabCarteiraChanging(Sender: TObject;
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

procedure TfrmConfigBancoob.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmConfigBancoob.edtCodPorRemKeyPress(Sender: TObject;
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

procedure TfrmConfigBancoob.pCarregaCentroCusto(strCtaBai: String;
  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmConfigBancoob.pCarregaPortador(strCodPor: String;
  edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtLabel.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmConfigBancoob.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  pCarKeyAutBan;
  cxPaginas.Properties.ActivePage := tbsGeral;

end;

procedure TfrmConfigBancoob.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigBancoob.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBancoob.btnCancelarClick(Sender: TObject);
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

procedure TfrmConfigBancoob.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '756';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigBancoob.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\756400p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\756400p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigBancoob.BtnOcorrenciaClick(Sender: TObject);
  Var
    strDetalhe : String;
begin
  inherited;
  pHideHint;

  strDetalhe := #13#10 +
                '06, 09 - Baixa duplicata; ' + #13#10 +
                '02 - Atualiza nosso número caso não tenha gravado; ' + #13#10 +
                '19 - Confirmação de instrução de protesto; ' + #13#10 +
                '23 - Lança histórico de protesto. ' + #13#10 +
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

  TfrmMemo.pShowMessage('Banco 756 - Bancoob - Detalhamento de Ocorrências (posições 109 - 110 arquivo retorno).' + #13#10 +
                        strDetalhe);
end;

procedure TfrmConfigBancoob.BtnOcorrenciaEnter(Sender: TObject);
begin
  inherited;
  pAlteraHintBotao(btnOcorrencia, 'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
                                  'que são tratados pelas rotinas do sistema.');
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigBancoob.BtnOcorrenciaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBancoob.chkCartSeqClick(Sender: TObject);
begin
  inherited;
  If Not fValidaCampos(chkCartSeq) Then
    TCheckBox(Sender).Checked := False;

  lblCartSeq.Enabled := TCheckBox(Sender).Checked;
  edtCartSeq.Enabled := TCheckBox(Sender).Checked;
end;

procedure TfrmConfigBancoob.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Seq. Remessa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  stlCampos.Add('Código Carteira   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', ''));
  stlCampos.Add('Código Cooperativa:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCOPE', ''));
  stlCampos.Add('Dígito Cooperativa:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCOPE', ''));
  stlCampos.Add('Código Cedente    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCEDE', ''));
  stlCampos.Add('Dígito Cedente    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCEDE', ''));
  stlCampos.Add('Conta Corrente    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCCOR', ''));
  stlCampos.Add('Dig Cta Corrente  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCCOR', ''));
  stlCampos.Add('Número Convênio   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCONV', ''));
  stlCampos.Add('Convênio Cliente  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CONVCLI', ''));
  stlCampos.Add('Cód. Instrução 1  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', ''));
  stlCampos.Add('Cód. Instrução 2  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', ''));
  stlCampos.Add('Observação 1      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Observação 3      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  stlCampos.Add('Observação 4      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  stlCampos.Add('Observação 5      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  stlCampos.Add('Dias p/ Protesto  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  stlCampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  stlCampos.Add('Arquivo Remessa   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo Retorno   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  stlCampos.Add('Protocolo Aceite  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', ''));
  stlCampos.Add('Resp. Emissão Bol :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', ''));
  stlCampos.Add('Portador de Baixa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Portador da remessa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', ''));
  stlCampos.Add('Conta Baixa       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Comando/Movimento :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'COMANDO', ''));
  stlCampos.Add('Modalidade        :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'MODALID', ''));
  stlCampos.Add('Percentual Multa  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', ''));
  stlCampos.Add('Info Adicional    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', ''));
  stlCampos.Add('Usa Layout Paraná :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'LAYPARA', ''));
  stlCampos.Add('Resp Envio Boleto :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'RESPENV', ''));
  stlCampos.Add('Util Outra Cart.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', ''));
  stlCampos.Add('Carteira Seq.     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', ''));
  stlCampos.Add('Permitir impressão de boletos? :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', ''));
end;

procedure TfrmConfigBancoob.pGravaLogCarteira(stlCfgAnt : TStringList);
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
    pGravaLogAtb('756', 'BANCOOB', strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

procedure TfrmConfigBancoob.pAlteraHintBotao(btnBotao: TBitBtnLocked;
  strNovoHint: String);
begin
  btnBotao.Hint := strNovoHint;
end;

procedure TfrmConfigBancoob.pShowHintBotao(btnBotao: TBitBtnLocked;
  strTitulo: String);
begin
  HintControler.ShowHint(btnBotao.ClientOrigin.X,btnBotao.ClientOrigin.Y, strTitulo, btnBotao.Hint);
end;

procedure TfrmConfigBancoob.pHideHint;
begin
  HintControler.HideHint;
end;

end.
