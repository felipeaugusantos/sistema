unit untConfigMercantil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, DirectoryEditFocus, StdCtrls, EditFocus, Buttons,
  ExtCtrls, QColorLabel, Menus, ComCtrls, ShellApi, Uni, AppEvnts, BitBtnLockedIncrem,
  untTypesSistema, frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  dxScreenTip, cxClasses, dxCustomHint, cxHint, cxDropDownEdit, ComboBoxFocus,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, strUtils, 
  untFrameDirectoryEditFocus, untFramePlanoDeContasMaskEdit, dxBarBuiltInMenu,
  cxPC;

type
  TfrmConfigMercantil = class(TfrmPai)
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
    lblCodAgenc: TLabel;
    lblCodCart: TLabel;
    lblContCorr: TLabel;
    lblIdentBanco: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    lblProNum: TLabel;
    lblResp: TLabel;
    ColorLabel1: TColorLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    ColorLabel3: TColorLabel;
    Label13: TLabel;
    lbl1: TLabel;
    edtResp: TEditFocus;
    edtContaCorr: TEditFocus;
    edtCodAgencia: TEditFocus;
    edtIdentBanc: TEditFocus;
    edtProxNumArqRem: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtDigCtaCor: TEditFocus;
    edtTipConta: TEditFocus;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtObservacao5: TEditFocus;
    edtProAce: TEditFocus;
    edtInfAdi: TEditFocus;
    fraPathRemessaMERC: TfraDirectoryEditFocus;
    fraPathRetornoMERC: TfraDirectoryEditFocus;
    cmbInstrucao1: TComboBoxFocus;
    cmbInstrucao2: TComboBoxFocus;
    cmbCodCar: TComboBoxFocus;
    edtDiasCred: TEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    procedure pCarregaDados;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure tabCarteiraChange(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure BtnManualClick(Sender: TObject);
    procedure BtnOcorrenciaClick(Sender: TObject);
    procedure BtnOcorrenciaEnter(Sender: TObject);
    procedure BtnOcorrenciaExit(Sender: TObject);
    procedure cmbInstrucao1Change(Sender: TObject);
    procedure cmbCodCarChange(Sender: TObject);
    procedure edtTipContaEnter(Sender: TObject);
    procedure edtDiasCredEnter(Sender: TObject);
    procedure edtTipContaExit(Sender: TObject);
    procedure edtDiasCredExit(Sender: TObject);
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

    procedure pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pShowHint(edtEdit: TEditFocus; strTitulo: String);
    procedure pShowHintBotao(btnBotao: TBitBtnLocked; strTitulo: String);
    procedure pHideHint;
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
  frmConfigMercantil: TfrmConfigMercantil;

implementation

uses untPesqAux, untFuncoes,
     untCfgGenericas_AutBan,  untConsultas, untFuncoesSimples, untMemo;

{$R *.dfm}

procedure TfrmConfigMercantil.pCarregaDados;
var
  strCodCart: String;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************AF*}
  edtProxNumArqRem.Text  := fGetBancoConfig(0,'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1),'PROXNUM','');

  strCodCart := fGetBancoConfig(0, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', '');
  If Not fEmptyStr(strCodCart) Then
  Begin
    Case StrToInt(strCodCart) Of
      1 : cmbCodCar.ItemIndex := 0;
      2 : cmbCodCar.ItemIndex := 1;
      3 : cmbCodCar.ItemIndex := 2;
      5 : cmbCodCar.ItemIndex := 3;
      6 : cmbCodCar.ItemIndex := 4;
      8 : cmbCodCar.ItemIndex := 5;
    End;
  End
  Else
    cmbCodCar.ItemIndex := -1;

  edtIdentBanc.Text      := fGetBancoConfig(0,'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1),'IDENTBC','');
  edtCodAgencia.Text     := fGetBancoConfig(0,'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1),'CODAGEN','');
//  edtCodAgenciaCta.Text  := fGetBancoConfig(0,'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1),'CODAGCT','',ARQCNFBCO);
  edtContaCorr.Text      := fGetBancoConfig(0,'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1),'NUMCTAC','');
  edtDigCtaCor.Text      := fGetBancoConfig(0,'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1),'DIGCTAC','');
  edtTipConta.Text       := fGetBancoConfig(0,'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1),'TIPCTAC','');
  edtResp.Text           := fGetBancoConfig(0,'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1),'RESPONS','');

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '')) Of
      00 : cmbInstrucao1.ItemIndex := 0;
      11 : cmbInstrucao1.ItemIndex := 1;
      19 : cmbInstrucao1.ItemIndex := 2;
      20 : cmbInstrucao1.ItemIndex := 3;
      21 : cmbInstrucao1.ItemIndex := 4;
      22 : cmbInstrucao1.ItemIndex := 5;
      23 : cmbInstrucao1.ItemIndex := 6;
      24 : cmbInstrucao1.ItemIndex := 7;
      25 : cmbInstrucao1.ItemIndex := 8;
      26 : cmbInstrucao1.ItemIndex := 9;
      27 : cmbInstrucao1.ItemIndex := 10;
      28 : cmbInstrucao1.ItemIndex := 11;
      29 : cmbInstrucao1.ItemIndex := 12;
      30 : cmbInstrucao1.ItemIndex := 13;
      31 : cmbInstrucao1.ItemIndex := 14;
      32 : cmbInstrucao1.ItemIndex := 15;
      52 : cmbInstrucao1.ItemIndex := 16;
      53 : cmbInstrucao1.ItemIndex := 17;
      54 : cmbInstrucao1.ItemIndex := 18;
      55 : cmbInstrucao1.ItemIndex := 19;
    End;
  End
  Else
    cmbInstrucao1.ItemIndex := -1;

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', '')) Of
      00 : cmbInstrucao2.ItemIndex := 0;
      11 : cmbInstrucao2.ItemIndex := 1;
      19 : cmbInstrucao2.ItemIndex := 2;
      20 : cmbInstrucao2.ItemIndex := 3;
      21 : cmbInstrucao2.ItemIndex := 4;
      22 : cmbInstrucao2.ItemIndex := 5;
      23 : cmbInstrucao2.ItemIndex := 6;
      24 : cmbInstrucao2.ItemIndex := 7;
      25 : cmbInstrucao2.ItemIndex := 8;
      26 : cmbInstrucao2.ItemIndex := 9;
      27 : cmbInstrucao2.ItemIndex := 10;
      28 : cmbInstrucao2.ItemIndex := 11;
      29 : cmbInstrucao2.ItemIndex := 12;
      30 : cmbInstrucao2.ItemIndex := 13;
      31 : cmbInstrucao2.ItemIndex := 14;
      32 : cmbInstrucao2.ItemIndex := 15;
      52 : cmbInstrucao2.ItemIndex := 16;
      53 : cmbInstrucao2.ItemIndex := 17;
      54 : cmbInstrucao2.ItemIndex := 18;
      55 : cmbInstrucao2.ItemIndex := 19;
    End;
  End
  Else
    cmbInstrucao2.ItemIndex := -1;

  edtObservacao1.Text    := fGetBancoConfig(0, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text    := fGetBancoConfig(0, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text    := fGetBancoConfig(0, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text    := fGetBancoConfig(0, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text    := fGetBancoConfig(0, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');

  fraPathRemessaMERC.edtDirectory.text:= fGetBancoConfig(0,'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1),'PATHREM','');
  fraPathRetornoMERC.edtDirectory.text:= fGetBancoConfig(0,'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1),'PATHRET','');
  edtCodPor.Text         := fGetBancoConfig(0,'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1),'PORBAI_','');
  edtCodPorRem.Text      := fGetBancoConfig(0, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');
  fraPlanoDeContas.MskCodCta.Text := fGetBancoConfig(0,'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1),'CTABAI_','');
  edtDiasCred.Text       := fGetBancoConfig(0,'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1),'DIACRED','');
  edtProAce.Text         := fGetBancoConfig(0,'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1),'PROACEI', '');
  edtInfAdi.Text         := fGetBancoConfig(0,'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1),'INFADIC', '');


  If Not fEmptyStr(edtCodPor.Text) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCodPorRem.Text ) Then
    pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);

  If Not fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
    pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);

end;

procedure TfrmConfigMercantil.FormShow(Sender: TObject);
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

procedure TfrmConfigMercantil.btnEditarClick(Sender: TObject);
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

procedure TfrmConfigMercantil.btnGravarClick(Sender: TObject);
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

      fGetBancoConfig(1, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', edtProxNumArqRem.Text);
      fGetBancoConfig(1, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', LeftStr(cmbCodCar.Text, 2));
      fGetBancoConfig(1, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', edtIdentBanc.Text    );
      fGetBancoConfig(1, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text   );
//      fGetBancoConfig(1, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGCT', edtCodAgenciaCta.Text,  ARQCNFBCO);
      fGetBancoConfig(1, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text );
      fGetBancoConfig(1, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', edtDigCtaCor.Text );
      fGetBancoConfig(1, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPCTAC', edtTipConta.Text  );
      fGetBancoConfig(1, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text      );
      fGetBancoConfig(1, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', LeftStr(cmbInstrucao1.Text, 2));
      fGetBancoConfig(1, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', LeftStr(cmbInstrucao2.Text, 2));

      fGetBancoConfig(1, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text);
      fGetBancoConfig(1, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text);
      fGetBancoConfig(1, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text);
      fGetBancoConfig(1, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text);
      fGetBancoConfig(1, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text);

      fGetBancoConfig(1, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessaMERC.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetornoMERC.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text         );
      fGetBancoConfig(1, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text       );
      fGetBancoConfig(1, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContas.MskCodCta.Text);

      fGetBancoConfig(1, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text     );
      fGetBancoConfig(1, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text       );
      fGetBancoConfig(1, 'CONFIG389-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text       );


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

procedure TfrmConfigMercantil.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
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

function TfrmConfigMercantil.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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
      If (cmbInstrucao1.ItemIndex = 0) Then
      Begin
        If cmbCodCar.ItemIndex = 3 Then
        Begin
          cmbInstrucao2.ItemIndex := 0;
          cmbInstrucao2.Enabled := False;
        End
        Else
        Begin
          fMensagem('','O código de instrução 00 é permitido apenas para a carteira 5!'+strMensagemConfig,['&O K']);
          Result := False;
        End;
      End
      Else
        cmbInstrucao2.Enabled := True;

    End

    Else If (Sender = cmbInstrucao2) And
            (cmbInstrucao2.Enabled)  Then
    Begin

      If cmbInstrucao2.ItemIndex = -1 Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else
      If cmbInstrucao1.ItemIndex = 1 Then
      Begin
        If cmbInstrucao2.ItemIndex = 9 Then
        Begin
          fMensagem('','O código da instrução 2 está em conflito com o código da instrução 1! Informe outro código de instrução 2.'+strMensagemConfig,['&O K']);
          Result := False;
        End;
      End
      Else If cmbInstrucao1.ItemIndex = 9 Then
      Begin
        If cmbInstrucao2.ItemIndex = 1 Then
        Begin
          fMensagem('','O código da instrução 2 está em conflito com o código da instrução 1! Informe outro código de instrução 2.'+strMensagemConfig,['&O K']);
          Result := False;
        End;
      End
      Else
      If cmbInstrucao1.ItemIndex in [2,3,4,5,10,17,18,19] Then
      Begin
        If cmbInstrucao2.ItemIndex in [2,3,4,5,10,17,18,19] Then
        Begin
          fMensagem('','O código da instrução 2 está em conflito com o código da instrução 1! Informe 11, 23, 24, 25, 26, 28, 29, 30, 32 ou 52' +
                       ' para o código da instrução 2.'+strMensagemConfig,['&O K']);
          Result := False;
        End;
      End
      Else
      If cmbInstrucao1.ItemIndex in [6,7,8,11,12,13,14,15] Then
      Begin
        If cmbInstrucao2.ItemIndex in [6,7,8,11,12,13,14,15] Then
        Begin
          fMensagem('','O código da instrução 2 está em conflito com o código da instrução 1! Informe 11, 19, 20, 21, 22, 26, 27, 52, 53, 54 ou 55' +
                       ' para o código da instrução 2.'+strMensagemConfig,['&O K']);
          Result := False;
        End;
      End;

      If (cmbInstrucao2.ItemIndex = 0) And
         (cmbCodCar.ItemIndex <> 3)    Then
      Begin
        fMensagem('','O código de instrução 00 é permitido apenas para a carteira 5!'+strMensagemConfig,['&O K']);
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
        Else
          Result := PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text,True);
      End;

    End

    Else If (Sender = cmbCodCar) Then
    Begin
      If cmbCodCar.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO!', 'O código da carteira deve ser informado!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else If cmbCodCar.ItemIndex = 3 Then
      Begin
        cmbInstrucao1.ItemIndex := 0;
        cmbInstrucao1.Enabled   := False;
        cmbInstrucao2.ItemIndex := 0;
        cmbInstrucao2.Enabled   := False;
      End
      Else
      Begin
        cmbInstrucao1.Enabled   := True;
        cmbInstrucao2.Enabled   := True;
      End
    End

    Else If (Sender = edtTipConta) Then
    Begin
      If fEmptyStr(edtTipConta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O tipo de conta (faixa) deve ser informado!'+strMensagemConfig,['&O K']);
        Result := False;
      End
      Else If edtTipConta.Text = '01' Then
      Begin
        edtResp.Text := 'B';
        edtResp.Enabled := False;
      End
      Else
        edtResp.Enabled := True;
    End

    Else If (Sender = edtCodAgencia) Then
    Begin
      If fEmptyStr(edtCodAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A agência deve ser informada!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtIdentBanc) Then
    Begin
      If fEmptyStr(edtIdentBanc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A identificação no banco deve ser informada!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtContaCorr) Then
    Begin
      If fEmptyStr(edtContaCorr.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A conta corrente deve ser informada!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigCtaCor) Then
    Begin
      If fEmptyStr(edtDigCtaCor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O dígito da conta corrente deve ser informado!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

  End;

  If Not Result Then
    if not blnNaoEditar then
      pSetFocus(Sender);

End;

procedure TfrmConfigMercantil.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmConfigMercantil.tabCarteiraChanging(Sender: TObject;
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

procedure TfrmConfigMercantil.pCarregaCentroCusto(strCtaBai: String;
  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmConfigMercantil.pCarregaPortador(strCodPor: String;
  edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtLabel.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmConfigMercantil.pHideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmConfigMercantil.pShowHint(edtEdit: TEditFocus; strTitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,edtEdit.ClientOrigin.Y, strTitulo, edtEdit.Hint);
end;

procedure TfrmConfigMercantil.pShowHintBotao(btnBotao: TBitBtnLocked;
  strTitulo: String);
begin
  HintControler.ShowHint(btnBotao.ClientOrigin.X,btnBotao.ClientOrigin.Y, strTitulo, btnBotao.Hint);
end;

procedure TfrmConfigMercantil.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmConfigMercantil.edtCodPorRemKeyPress(Sender: TObject;
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

procedure TfrmConfigMercantil.edtDiasCredEnter(Sender: TObject);
begin
  inherited;
  edtDiasCred.Hint := 'Informar quantidade de dias ' + #13+#10 +
                      'do intervalo entre a efetuação ' + #13+#10 +
                      'do pagamento e o crédito na ' + #13+#10 +
                      'conta corrente.';

  pShowHint(edtDiasCred, 'Dias para Crédito');
end;

procedure TfrmConfigMercantil.edtDiasCredExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigMercantil.edtTipContaEnter(Sender: TObject);
begin
  inherited;
  edtTipConta.Hint := 'Para a faixa 01 a emissão de boletos ' +#13+#10+
                      'é sempre feita pelo banco.';

  pShowHint(edtTipConta, 'Faixa');
end;

procedure TfrmConfigMercantil.edtTipContaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigMercantil.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  pCarKeyAutBan;
  cxPaginas.Properties.ActivePage := tbsGeral;
end;

procedure TfrmConfigMercantil.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigMercantil.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigMercantil.btnCancelarClick(Sender: TObject);
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

procedure TfrmConfigMercantil.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '389';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigMercantil.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\389400p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\389400p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigMercantil.BtnOcorrenciaClick(Sender: TObject);
  Var
    strDetalhe : String;
begin
  inherited;
  pHideHint;

  strDetalhe := #13#10 +
                '06, 15, 16 - Baixa duplicata; ' + #13#10 +
                '02 - Atualiza nosso número caso não tenha gravado; ' + #13#10 +
                #13#10 +
                'Demais códigos de ocorrências são gravados na rotina ' + #13#10 +
                'de retorno e mostrados no relatório apenas em ' + #13#10 +
                'caráter informativo.'+ #13#10 +
                #13#10 +
                'Pressione Esc para voltar à tela de configurações.';

  TfrmMemo.pShowMessage('Banco 389 - Mercantil - Detalhamento de Ocorrências (posições 109 - 110 arquivo retorno).' + #13#10 +
                        strDetalhe);
end;

procedure TfrmConfigMercantil.BtnOcorrenciaEnter(Sender: TObject);
begin
  inherited;
  btnOcorrencia.Hint := 'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
                        'que são tratados pelas rotinas do sistema.';
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigMercantil.BtnOcorrenciaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigMercantil.cmbCodCarChange(Sender: TObject);
begin
  inherited;
  If cmbCodCar.ItemIndex = 3 Then
  Begin
    cmbInstrucao1.ItemIndex := 0;
    cmbInstrucao1.Enabled   := False;
    cmbInstrucao2.ItemIndex := 0;
    cmbInstrucao2.Enabled   := False;
  End
  Else
  Begin
    cmbInstrucao1.Enabled   := True;
    cmbInstrucao2.Enabled   := True;
  End;
end;

procedure TfrmConfigMercantil.cmbInstrucao1Change(Sender: TObject);
begin
  inherited;

  If (cmbInstrucao1.ItemIndex = 0)  Then
  Begin
    If cmbCodCar.ItemIndex = 3 Then
    Begin
      cmbInstrucao2.ItemIndex := 0;
      cmbInstrucao2.Enabled := False;
    End
  End
  Else
    cmbInstrucao2.Enabled := True;

end;

procedure TfrmConfigMercantil.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Seq. remessa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  stlCampos.Add('Cód. carteira     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', ''));
  stlCampos.Add('Cód. agência      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Identif. Bancária :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', ''));
  stlCampos.Add('Número C/C        :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  stlCampos.Add('Dígito C/C        :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', ''));
  stlCampos.Add('Tipo de conta     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TIPCTAC', ''));
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
end;

procedure TfrmConfigMercantil.pGravaLogCarteira(stlCfgAnt : TStringList);
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
    pGravaLogAtb('389', 'BANCO MERCANTIL', strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

end.
