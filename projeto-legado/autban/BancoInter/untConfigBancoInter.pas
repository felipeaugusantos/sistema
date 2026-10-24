unit untConfigBancoInter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass, StrUtils,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, dxBarBuiltInMenu, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxTextEdit, cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxGroupBox,
  ComboBoxFocus, EditFocus, QColorLabel, cxPC, Vcl.ComCtrls, Uni,
  UniClientDataset, dxScreenTip, dxCustomHint, cxHint,
  untFrameDirectoryEditFocus,  System.NetEncoding, Soap.EncdDecd, IdCoderMIME,
  cxButtons, DateUtils, Vcl.OleCtrls, SHDocVw,MSHTML,untGravando,WinInet,
  System.Win.Registry, cxMaskEdit, cxDropDownEdit, Vcl.Mask, MaskEditFocus;

Type
  TRetornaDataValidadeWS = class
  Private
    CurDispatch: IDispatch;
    FDocLoaded: Boolean;
    LDataCertificado : TDateTime;
    LArquivo         : String;
    LWebBrowser      : TWebBrowser;

    procedure WebBrowser1BeforeNavigate2(ASender: TObject;
      const pDisp: IDispatch; const URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    procedure WebBrowser1DocumentComplete(ASender: TObject;
      const pDisp: IDispatch; const URL: OleVariant);
    procedure WebBrowser1NavigateComplete2(ASender: TObject;
      const pDisp: IDispatch; const URL: OleVariant);

    procedure Aguarde(msecs: Integer);
    function RetornaValorCertificado : String;
    procedure ExecutaJavaScript(WebBrowser: TWebBrowser; Js: String);
    function GetTextOfSite(WebBrowser: TWebBrowser): WideString;
    function FormataDataValidade(AData:String): TDateTime;
  public
    procedure RetornaDataValidadeOnline;

    property ADataCertificado: TDateTime   Read LDataCertificado Write LDataCertificado;
    property AArquivo        : String      Read LArquivo         Write LArquivo;
    property AWebBrowser     : TWebBrowser Read LWebBrowser      Write LWebBrowser;

  end;


type
  TfrmConfigBancoInter = class(TfrmPai)
    btnGravar: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    BtnManual: TBitBtnLocked;
    BtnOcorrencia: TBitBtnLocked;
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
    cxPaginas: TcxPageControl;
    tbsGeral: TcxTabSheet;
    pnlAtivo1: TPanel;
    lblCodAgenc: TLabel;
    lblCodCart: TLabel;
    lblContCorr: TLabel;
    lblDiasProt: TLabel;
    lblIdentBanco: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    ColorLabel3: TColorLabel;
    Label14: TLabel;
    Label17: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    Label6: TLabel;
    Label22: TLabel;
    edtDiasProt: TEditFocus;
    edtContaCorr: TEditFocus;
    edtCodAgencia: TEditFocus;
    edtCodigoBeneficiario: TEditFocus;
    edtCodCar: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtDesCtaBai: TEditFocus;
    edtCtaBai: TEditFocus;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtObservacao5: TEditFocus;
    edtExpCgc: TEditFocus;
    edtDiasCred: TEditFocus;
    edtPerMul: TEditFocus;
    cmbTipDia: TComboBoxFocus;
    edtInfAdi: TEditFocus;
    edtDiasMora: TEditFocus;
    edtDigCtaCor: TEditFocus;
    Label5: TLabel;
    HintControler: TcxHintStyleController;
    edtDigitoAgencia: TEditFocus;
    pnlAuthV1: TPanel;
    WebBrowser: TWebBrowser;
    lblArquivoCRT: TLabel;
    lblArquivoKey: TLabel;
    edtArquivoCRT: TEditFocus;
    btnArquivoCRT: TcxButton;
    edtArquivoKey: TEditFocus;
    btnArquivoKey: TcxButton;
    lblValidadeCertificado: TLabel;
    Label3: TLabel;
    edtSenhaCertificado: TEditFocus;
    Label4: TLabel;
    pnlAuthV2: TPanel;
    edtClientSecret: TEditFocus;
    lblClientSecret: TLabel;
    lblClientID: TLabel;
    edtClientID: TEditFocus;
    lblVersaoAPi: TLabel;
    cmbVersaoAPi: TComboBox;
    lblVersaoObs: TLabel;
    lblAmbiente: TLabel;
    cmbAmbiente: TcxComboBox;
    cxTabDadosSacadorAvalista: TcxTabSheet;
    pnlAtivo2: TPanel;
    pnlSacAva: TPanel;
    Label7: TLabel;
    ColorLabel7: TColorLabel;
    grpBeneficiario: TGroupBox;
    lblDesCrr: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    edtDesBen: TEditFocus;
    edtEndBen: TEditFocus;
    edtCompBen: TEditFocus;
    edtBaiBen: TEditFocus;
    edtCidBen: TEditFocus;
    edtEstBen: TEditFocus;
    edtCepBen: TMaskEditFocus;
    edtCgcBen: TMaskEditFocus;
    edtUsaSac: TEditFocus;
    edtDiasBaixaAutomatica: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure tabCarteiraChange(Sender: TObject);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure btnConfigurarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCtaBaiKeyPress(Sender: TObject; var Key: Char);
    procedure btnEditarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnArquivoCRTClick(Sender: TObject);
    procedure btnArquivoKeyClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmbVersaoAPiChange(Sender: TObject);
    procedure edtClientIDEnter(Sender: TObject);
    procedure edtClientIDExit(Sender: TObject);
    procedure edtClientSecretEnter(Sender: TObject);
    procedure edtClientSecretExit(Sender: TObject);

  private
    FNaoEditar: Boolean;

    FCadPor,
    FCadCta,
    FCadFor,
    FCadEmp: TUniQuery;

    FCarteira: String;

    procedure CarregaDadosDaCarteira;
    procedure LimpaCampos;

    procedure CarregaPortador(ACodPor: String; ALabel: TEdit);
    procedure CarregaPlanoDeContas(ACtaBai: String; ALabel: TEdit);

    procedure CarregaCfg(Var stlCampos: TStringList);
    procedure GravaLogCarteira(ACfgAnt: TStringList);

    function fRetornaStringCfg(ACofiguracao: TStringList): String;

    procedure ExibeCamposCertificados(AExibir: Boolean);

    function RetornaValidadeCertificado(AArquivo: String): String;
    function VerificaAValidadeDoCertificado(): Boolean;

    function RetornaValidadeCertificadoWebserviceCitel(AArquivo: String): String;

    procedure MudaCorDaValidadeDoCertificado;
    procedure Aguarde(msecs: Integer);
    procedure PreparaAutenticacaoAPI;
    { Private declarations }
  public
    property NaoEditar: Boolean read FNaoEditar write FNaoeditar;
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigBancoInter: TfrmConfigBancoInter;

const
  CONFIG: String = 'CONFIG077-';

implementation
Uses untFuncoesSimples, untPesqAux, untConsultas, untFuncAutban, untCfgGenericas_AutBan,
     untTypesSistema, untFuncoes, untTRestSynalistAutban;
{$R *.dfm}

{ TfrmConfigBancoInter }

procedure TfrmConfigBancoInter.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do registro da carteira selecionada?', ['&Sim', '&Não'], 2) = 2 then
    Exit;

  cxPaginas.ActivePage :=  tbsGeral;
  btnCancelar.Visible := False;
  btnEditar.Visible   := True;
  pnlAtivo1.Enabled := False;
  pnlAtivo2.Enabled := False;

  btnEditar.Visible   := True;
  btnGravar.Enabled   := False;
  btnConfigurar.Enabled := False;
  CarregaDadosDaCarteira;
  pSetFocus(btnEditar);
end;

procedure TfrmConfigBancoInter.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    HintControler.HideHint;

    pCriarFormularios(TfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '077';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;
end;

procedure TfrmConfigBancoInter.btnEditarClick(Sender: TObject);
begin
  If ((Not fVerificaDireitoAutBan('PERCARBAN')) and (strLoginUsuarioLogado <> '999')) Then
  begin
    fMensagem('ATENÇÃO','Usuário sem permissão!', ['&Ok ']);
    Exit;
  end
  else
  begin
    pnlAtivo2.Enabled := True;

    pnlAtivo1.Enabled := True;
    btnGravar.Enabled := True;
    btnConfigurar.Enabled := True;
    btnEditar.Visible := False;
    btnCancelar.Visible := true;

    If fEmptyStr(edtCodCar.Text) Then
      edtCodCar.Text := '112';

    pSetFocus(edtCodAgencia);
  end;
end;

procedure TfrmConfigBancoInter.btnGravarClick(Sender: TObject);
  Var
    LCfgAnt : TStringList;

begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  If pnlAuthV1.Visible And Not VerificaAValidadeDoCertificado Then
    Exit;

  If FNaoEditar Then
  Begin
    Close;
    ModalResult := mrOk;
    Exit;
  End;


  Try
    LCfgAnt := TStringList.Create;
    CarregaCfg(LCfgAnt);

    fGetBancoConfig(1, CONFIG + FCarteira, 'CODCART', edtCodCar.Text       );
    fGetBancoConfig(1, CONFIG + FCarteira, 'IDENTBC', edtCodigoBeneficiario.Text);
    fGetBancoConfig(1, CONFIG + FCarteira, 'CODAGEN', edtCodAgencia.Text   );
    fGetBancoConfig(1, CONFIG + FCarteira, 'DIGAGEN', edtDigitoAgencia.Text);
    fGetBancoConfig(1, CONFIG + FCarteira, 'NUMCTAC', edtContaCorr.Text    );
    fGetBancoConfig(1, CONFIG + FCarteira, 'DIGCTAC', edtDigCtaCor.Text    );
    fGetBancoConfig(1, CONFIG + FCarteira, 'PORBAI_', edtCodPor.Text       );
    fGetBancoConfig(1, CONFIG + FCarteira, 'CTABAI_', edtCtaBai.Text       );
    fGetBancoConfig(1, CONFIG + FCarteira, 'DIAPROT', edtDiasProt.Text     );
    fGetBancoConfig(1, CONFIG + FCarteira, 'DIAMORA', edtDiasMora.Text     );

    fGetBancoConfig(1, CONFIG + FCarteira, 'RESPONS', 'E'); //Seleção de carteira do Autcom

    fGetBancoConfig(1, CONFIG + FCarteira, 'OBSERV1', edtObservacao1.Text);
    fGetBancoConfig(1, CONFIG + FCarteira, 'OBSERV2', edtObservacao2.Text);
    fGetBancoConfig(1, CONFIG + FCarteira, 'OBSERV3', edtObservacao3.Text);
    fGetBancoConfig(1, CONFIG + FCarteira, 'OBSERV4', edtObservacao4.Text);
    fGetBancoConfig(1, CONFIG + FCarteira, 'OBSERV5', edtObservacao5.Text);

    fGetBancoConfig(1, CONFIG + FCarteira, 'EXPCNPJ', edtExpCgc.Text         );

    fGetBancoConfig(1, CONFIG + FCarteira, 'DIACRED', edtDiasCred.Text     );

    fGetBancoConfig(1, CONFIG + FCarteira, 'PERMULT', edtPerMul.Text       );
    fGetBancoConfig(1, CONFIG + FCarteira, 'INFADIC', edtInfAdi.Text       );

    fGetBancoConfig(1, CONFIG + FCarteira, 'TIPDIA' , IntToStr(cmbTipDia.ItemIndex+1));
    
    fGetBancoConfig(1, CONFIG + FCarteira, 'AUTHSEN', edtSenhaCertificado.Text  );

    If Not MatchStr(edtArquivoCRT.Text, ['', 'certificado cadastrado']) Then
    Begin
      fGetBancoConfig(1, CONFIG + FCarteira, 'AUTHCRT', RetornaArquivoBase64(edtArquivoCRT.Text));

      fGetBancoConfig(1, CONFIG + FCarteira, 'VALCERT', lblValidadeCertificado.Caption);
    End;

    If Not MatchStr(edtArquivoKey.Text, ['', 'certificado cadastrado']) Then
      fGetBancoConfig(1, CONFIG + FCarteira, 'AUTHKEY', RetornaArquivoBase64(edtArquivoKey.Text));

    fGetBancoConfig(1, CONFIG + FCarteira, 'BAIAUTO', edtDiasBaixaAutomatica.Text);

    // Versão 2.0
    If Not MatchStr(edtClientID.Text, ['', 'Client ID cadastrado']) Then
      fGetBancoConfig(1, CONFIG + FCarteira, 'CLIENT_ID', edtClientID.Text);

    If Not MatchStr(edtClientSecret.Text, ['', 'Client Secret cadastrado']) Then
      fGetBancoConfig(1, CONFIG + FCarteira, 'CLIENT_SECRET',edtClientSecret.Text);

    fGetBancoConfig(1, CONFIG + FCarteira, 'VERSAO_API', cmbVersaoAPi.Text);

    fGetBancoConfig(1, CONFIG + FCarteira, 'AMBIENTE', Inttostr(cmbAmbiente.ItemIndex)); //0-Homologação; 1-Produção;

    // dados beneficiario
    fGetBancoConfig(1, CONFIG + FCarteira, 'SACAVAL', edtUsaSac.Text  );
    fGetBancoConfig(1, CONFIG + FCarteira, 'NOMEBEN', edtDesBen.Text  );
    fGetBancoConfig(1, CONFIG + FCarteira, 'ENDEBEN', edtEndBen.Text  );
    fGetBancoConfig(1, CONFIG + FCarteira, 'BAIRBEN', edtBaiBen.Text  );
    fGetBancoConfig(1, CONFIG + FCarteira, 'COMPBEN', edtCompBen.Text );
    fGetBancoConfig(1, CONFIG + FCarteira, 'CIDABEN', edtCidBen.Text  );
    fGetBancoConfig(1, CONFIG + FCarteira, 'ESTABEN', edtEstBen.Text  );
    fGetBancoConfig(1, CONFIG + FCarteira, 'CEP_BEN', edtCepBen.Text  );
    fGetBancoConfig(1, CONFIG + FCarteira, 'CNPJBEN', edtCgCBen.Text  );


    If Not (btnGravar.Caption = '&OK') Then
    Begin
      pBackupCnfBco;
      fMensagem('ATENÇÃO', 'Dados salvos com sucesso.', ['&Ok'], 1, True);
      pSetFocus(edtCodAgencia);
      btnEditar.Visible := True;
      pnlAtivo1.Enabled := False;
      btnGravar.Enabled := False;
      btnConfigurar.Enabled := False;
      btnEditar.Visible := True;
      btnCancelar.Visible := False;
      pnlAtivo2.Enabled := False;
      cxPaginas.ActivePage :=  tbsGeral;
      pSetFocus(btnEditar);
    End
    Else
    Begin
      Close;
      ModalResult := mrOk;
    End;

    GravaLogCarteira(LCfgAnt);

    CarregaDadosDaCarteira;
  Except
    On E:Exception Do
    Begin
      fMensagem('Erro','Ocorreu um erro ao tentar salvar os dados.' + #13 + E.Message,['&O K']);
    End;
  End;

  FreeAndNil(LCfgAnt);
end;

procedure TfrmConfigBancoInter.btnArquivoCRTClick(Sender: TObject);
  Var
    LCaixaDialogo: TOpenDialog;
begin
  LCaixaDialogo := TOpenDialog.Create(nil);
  try
    LCaixaDialogo.Title := 'Selecione o arquivo CRT';

    LCaixaDialogo.Options := [ofPathMustExist];

    LCaixaDialogo.Filter := 'Certificado CRT|*.crt';

    If LCaixaDialogo.Execute Then
    Begin
      edtArquivoCRT.Text := LCaixaDialogo.FileName;

      lblValidadeCertificado.Caption := LeftStr(RetornaValidadeCertificadoWebserviceCitel(edtArquivoCRT.Text), 10);
    End;
  finally
    LCaixaDialogo.Free;

    MudaCorDaValidadeDoCertificado;
  end;
end;

procedure TfrmConfigBancoInter.btnArquivoKeyClick(Sender: TObject);
  Var
    LCaixaDialogo: TOpenDialog;
begin
  LCaixaDialogo := TOpenDialog.Create(nil);
  try
    LCaixaDialogo.Title := 'Selecione o arquivo KEY';

    LCaixaDialogo.Options := [ofPathMustExist];

    LCaixaDialogo.Filter := 'Certificado KEY|*.key';

    If LCaixaDialogo.Execute Then
      edtArquivoKey.Text := LCaixaDialogo.FileName;
  finally
    LCaixaDialogo.Free;
  end;
end;

procedure TfrmConfigBancoInter.CarregaCfg(var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Cód. agência      :' + fGetBancoConfig(0, CONFIG + FCarteira, 'CODAGEN', ''));
  stlCampos.Add('Dig. agência      :' + fGetBancoConfig(0, CONFIG + FCarteira, 'DIGAGEN', ''));
  stlCampos.Add('Número C/C        :' + fGetBancoConfig(0, CONFIG + FCarteira, 'NUMCTAC', ''));
  stlCampos.Add('Dígito C/C        :' + fGetBancoConfig(0, CONFIG + FCarteira, 'DIGCTAC', ''));
  stlCampos.Add('Identif. Bancária :' + fGetBancoConfig(0, CONFIG + FCarteira, 'IDENTBC', ''));
  stlCampos.Add('Cód. carteira     :' + fGetBancoConfig(0, CONFIG + FCarteira, 'CODCART', ''));
  stlCampos.Add('Portador de baixa :' + fGetBancoConfig(0, CONFIG + FCarteira, 'PORBAI_', ''));
  stlCampos.Add('Conta de baixa    :' + fGetBancoConfig(0, CONFIG + FCarteira, 'CTABAI_', ''));
  stlCampos.Add('Observação 1      :' + fGetBancoConfig(0, CONFIG + FCarteira, 'OBSERV1', ''));
  stlCampos.Add('Observação 2      :' + fGetBancoConfig(0, CONFIG + FCarteira, 'OBSERV2', ''));
  stlCampos.Add('Observação 3      :' + fGetBancoConfig(0, CONFIG + FCarteira, 'OBSERV3', ''));
  stlCampos.Add('Observação 4      :' + fGetBancoConfig(0, CONFIG + FCarteira, 'OBSERV4', ''));
  stlCampos.Add('Observação 5      :' + fGetBancoConfig(0, CONFIG + FCarteira, 'OBSERV5', ''));
  stlCampos.Add('Dias p/ protesto  :' + fGetBancoConfig(0, CONFIG + FCarteira, 'DIAPROT', ''));
  stlCampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, CONFIG + FCarteira, 'DIACRED', ''));
  stlCampos.Add('Dias p/ mora      :' + fGetBancoConfig(0, CONFIG + FCarteira, 'DIAMORA', ''));
  stlCampos.Add('Percentual Multa  :' + fGetBancoConfig(0, CONFIG + FCarteira, 'PERMULT', ''));
  stlCampos.Add('Inf. adicional    :' + fGetBancoConfig(0, CONFIG + FCarteira, 'INFADIC', ''));
  stlCampos.Add('Responsável Bol.  :' + fGetBancoConfig(0, CONFIG + FCarteira, 'RESPONS', ''));
  stlCampos.Add('Exp. CNPJ Cedente :' + fGetBancoConfig(0, CONFIG + FCarteira, 'EXPCNPJ', ''));
  stlCampos.Add('Tipo dia protesto :' + fGetBancoConfig(0, CONFIG + FCarteira, 'TIPDIA', ''));
  stlCampos.Add('Dias Baixa Autom. :' + fGetBancoConfig(0, CONFIG + FCarteira, 'BAIAUTO', ''));
  stlCampos.Add('Senha Certificado :' + fGetBancoConfig(0, CONFIG + FCarteira, 'AUTHSEN', ''));
  stlCampos.Add('Certificado CRT   :' + fGetBancoConfig(0, CONFIG + FCarteira, 'AUTHCRT', ''));
  stlCampos.Add('Certificado KEY   :' + fGetBancoConfig(0, CONFIG + FCarteira, 'AUTHKEY', ''));
  stlCampos.Add('Validade Certific.:' + fGetBancoConfig(0, CONFIG + FCarteira, 'VALCERT', ''));
  stlCampos.Add('Client ID         :' + fGetBancoConfig(0, CONFIG + FCarteira, 'CLIENT_ID', ''));
  stlCampos.Add('Client Secret     :' + fGetBancoConfig(0, CONFIG + FCarteira, 'CLIENT_SECRET', ''));
  stlCampos.Add('Versão            :' + fGetBancoConfig(0, CONFIG + FCarteira, 'VERSAO_API', ''));
  stlCampos.Add('Ambiente          :' + fGetBancoConfig(0, CONFIG + FCarteira, 'AMBIENTE', ''));

  stlCampos.Add('Usa sacador        :' + fGetBancoConfig(0, CONFIG + FCarteira, 'SACAVAL', ''));
  stlCampos.Add('Nome beneficiário  :' + fGetBancoConfig(0, CONFIG + FCarteira, 'NOMEBEN', ''));
  stlCampos.Add('End. beneficiário  :' + fGetBancoConfig(0, CONFIG + FCarteira, 'ENDEBEN', ''));
  stlCampos.Add('Bairro beneficiário:' + fGetBancoConfig(0, CONFIG + FCarteira, 'BAIRBEN', ''));
  stlCampos.Add('Comp. beneficiário :' + fGetBancoConfig(0, CONFIG + FCarteira, 'COMPBEN', ''));
  stlCampos.Add('Cidade beneficiário:' + fGetBancoConfig(0, CONFIG + FCarteira, 'CIDABEN', ''));
  stlCampos.Add('Est. beneficiário  :' + fGetBancoConfig(0, CONFIG + FCarteira, 'ESTABEN', ''));
  stlCampos.Add('Cep beneficiário   :' + fGetBancoConfig(0, CONFIG + FCarteira, 'CEP_BEN', ''));
  stlCampos.Add('Cnpj beneficiário  :' + fGetBancoConfig(0, CONFIG + FCarteira, 'CNPJBEN', ''));

end;

procedure TfrmConfigBancoInter.CarregaDadosDaCarteira;
begin
  LimpaCampos;

  pSetFocus(edtCodAgencia);

  FCarteira := IntToStr(tabCarteira.TabIndex + 1);

  edtCodCar.Text         := fGetBancoConfig(0, CONFIG + FCarteira, 'CODCART', '');
  edtCodigoBeneficiario.Text := fGetBancoConfig(0, CONFIG + FCarteira, 'IDENTBC', '');
  edtCodAgencia.Text     := fGetBancoConfig(0, CONFIG + FCarteira, 'CODAGEN', '');
  edtDigitoAgencia.Text  := fGetBancoConfig(0, CONFIG + FCarteira, 'DIGAGEN', '');
  edtContaCorr.Text      := fGetBancoConfig(0, CONFIG + FCarteira, 'NUMCTAC', '');
  edtDigCtaCor.Text      := fGetBancoConfig(0, CONFIG + FCarteira, 'DIGCTAC', '');
  edtCodPor.Text         := fGetBancoConfig(0, CONFIG + FCarteira, 'PORBAI_', '');
  edtCtaBai.Text         := fGetBancoConfig(0, CONFIG + FCarteira, 'CTABAI_', '');
  edtDiasProt.Text       := fGetBancoConfig(0, CONFIG + FCarteira, 'DIAPROT', '');
  edtDiasMora.Text       := fGetBancoConfig(0, CONFIG + FCarteira, 'DIAMORA', '');

  If fEmptyStr(edtDiasMora.Text) then
    edtDiasMora.Text := '1';

  edtObservacao1.Text    := fGetBancoConfig(0, CONFIG + FCarteira, 'OBSERV1', '');
  edtObservacao2.Text    := fGetBancoConfig(0, CONFIG + FCarteira, 'OBSERV2', '');
  edtObservacao3.Text    := fGetBancoConfig(0, CONFIG + FCarteira, 'OBSERV3', '');
  edtObservacao4.Text    := fGetBancoConfig(0, CONFIG + FCarteira, 'OBSERV4', '');
  edtObservacao5.Text    := fGetBancoConfig(0, CONFIG + FCarteira, 'OBSERV5', '');

  edtExpCgc.Text         := fGetBancoConfig(0, CONFIG + FCarteira, 'EXPCNPJ', '');
  edtDiasCred.Text       := fGetBancoConfig(0, CONFIG + FCarteira, 'DIACRED', '');

  edtPerMul.Text         := fGetBancoConfig(0, CONFIG + FCarteira, 'PERMULT', '');
  edtInfAdi.Text         := fGetBancoConfig(0, CONFIG + FCarteira, 'INFADIC', '');

  //Dados Beneficiário
  edtUsaSac.Text  := fGetBancoConfig(0, CONFIG + FCarteira, 'SACAVAL', '');
  edtUsaSac.Text  := IIF(fEmptyStr(edtUsaSac.Text), 'N', edtUsaSac.Text);
  edtDesBen.Text  := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, CONFIG + FCarteira, 'NOMEBEN', ''), '');
  edtEndBen.Text  := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, CONFIG + FCarteira, 'ENDEBEN', ''), '');
  edtBaiBen.Text  := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, CONFIG + FCarteira, 'BAIRBEN', ''), '');
  edtCompBen.Text := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, CONFIG + FCarteira, 'COMPBEN', ''), '');
  edtCidBen.Text  := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, CONFIG + FCarteira, 'CIDABEN', ''), '');
  edtEstBen.Text  := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, CONFIG + FCarteira, 'ESTABEN', ''), '');
  edtCepBen.Text  := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, CONFIG + FCarteira, 'CEP_BEN', ''), '');
  edtCgcBen.Text  := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, CONFIG + FCarteira, 'CNPJBEN', ''), '');

  edtArquivoCRT.Clear;
  If fGetBancoConfig(0, CONFIG + FCarteira, 'AUTHCRT', '') <> '' Then
    edtArquivoCRT.Text     := 'certificado cadastrado';

  edtArquivoKey.Clear;
  If fGetBancoConfig(0, CONFIG + FCarteira, 'AUTHKEY', '') <> '' Then
    edtArquivoKey.Text     := 'certificado cadastrado';

  // versão 2.0
  edtClientID.Clear;
  If fGetBancoConfig(0, CONFIG + FCarteira, 'CLIENT_ID', '') <> '' Then
    edtClientID.Text     := 'Client ID cadastrado';

  edtClientSecret.Clear;
  If fGetBancoConfig(0, CONFIG + FCarteira, 'CLIENT_SECRET', '') <> '' Then
    edtClientSecret.Text     := 'Client Secret cadastrado';

  Try
    Case StrToInt(LeftStr(fGetBancoConfig(0, CONFIG + FCarteira, 'VERSAO_API', ''),1)) Of
      1: cmbVersaoAPi.ItemIndex := 0;
      2: cmbVersaoAPi.ItemIndex := 1;
      3: cmbVersaoAPi.ItemIndex := 2;
    End;
  Except
    cmbVersaoAPi.ItemIndex := IIF(fEmptyStr(fGetBancoConfig(0, CONFIG + FCarteira, 'AUTHKEY', '')),1,0);
  End;

  cmbAmbiente.ItemIndex := IIF(fEmptyStr(fGetBancoConfig(0, CONFIG + FCarteira, 'AMBIENTE', '0')),0, fGetBancoConfig(0, CONFIG + FCarteira, 'AMBIENTE', '0') );

  PreparaAutenticacaoAPI;

  edtSenhaCertificado.Text       := fGetBancoConfig(0, CONFIG + FCarteira, 'AUTHSEN', '');

  lblValidadeCertificado.Caption := fGetBancoConfig(0, CONFIG + FCarteira, 'VALCERT', '');
  MudaCorDaValidadeDoCertificado;

  If fGetBancoConfig(0, CONFIG + FCarteira, 'BAIAUTO', '') = 'TRINTA' Then
     edtDiasBaixaAutomatica.Text := '30'
  Else If fGetBancoConfig(0, CONFIG + FCarteira, 'BAIAUTO', '') = 'SESSENTA' Then
     edtDiasBaixaAutomatica.Text := '60'
  Else
     edtDiasBaixaAutomatica.Text := fGetBancoConfig(0, CONFIG + FCarteira, 'BAIAUTO', '');

  cmbTipDia.ItemIndex    := -1;
  If Not fEmptyStr(fGetBancoConfig(0, CONFIG + FCarteira,'TIPDIA', '1')) Then
    cmbTipDia.ItemIndex    := StrToInt(fGetBancoConfig(0, CONFIG + FCarteira,'TIPDIA', '1'))-1;

  CarregaPortador(edtCodPor.Text, edtDesPor);


  CarregaPlanoDeContas(edtCtaBai.Text, edtDesCtaBai);

  fValidaCampos(edtUsaSac);

end;

procedure TfrmConfigBancoInter.CarregaPlanoDeContas(ACtaBai: String;
  ALabel: TEdit);
begin
  pPesquisaCadCta(Nil, FCadCta, ACtaBai);

  ALabel.Clear;

  If ACtaBai.IsEmpty Then
    Exit;

  If Not FCadCta.FieldByName('CTA_DESCTA').AsString.IsEmpty Then
    ALabel.Text := FCadCta.FieldByName('CTA_DESCTA').AsString;
end;

procedure TfrmConfigBancoInter.CarregaPortador(ACodPor: String;
  ALabel: TEdit);
begin
  pPesquisaCadPor(Nil, FCadPor, ACodPor);

  ALabel.Clear;

  If ACodPor.IsEmpty THen
    Exit;

  If Not FCadPor.FieldByName('POR_NOMPOR').AsString.IsEmpty Then
    ALabel.Text := FCadPor.FieldByName('POR_NOMPOR').AsString;
end;

procedure TfrmConfigBancoInter.cmbVersaoAPiChange(Sender: TObject);
begin
  inherited;
  PreparaAutenticacaoAPI;
end;

procedure TfrmConfigBancoInter.edtClientIDEnter(Sender: TObject);
begin
  inherited;
  If edtClientID.Text = 'Client ID cadastrado' Then
    edtClientID.Clear;
end;

procedure TfrmConfigBancoInter.edtClientIDExit(Sender: TObject);
begin
  inherited;
  If  fEmptyStr(edtClientID.Text) And
      (fGetBancoConfig(0, CONFIG + FCarteira, 'CLIENT_ID', '') <> '') Then
    edtClientID.Text     := 'Client ID cadastrado';
end;

procedure TfrmConfigBancoInter.edtClientSecretEnter(Sender: TObject);
begin
  inherited;
  If edtClientSecret.Text = 'Client Secret cadastrado' Then
    edtClientSecret.Clear;
end;

procedure TfrmConfigBancoInter.edtClientSecretExit(Sender: TObject);
begin
  inherited;
  If  fEmptyStr(edtClientSecret.Text) And
      (fGetBancoConfig(0, CONFIG + FCarteira, 'CLIENT_SECRET', '') <> '') Then
    edtClientSecret.Text     := 'Client Secret cadastrado';
end;

procedure TfrmConfigBancoInter.edtCodPorKeyPress(Sender: TObject;
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

procedure TfrmConfigBancoInter.edtCtaBaiKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, edtCtaBai, edtDesCtaBai, Nil, Key, arrCentroCusto) Then
  Begin
    if fValidaCampos(edtCtaBai) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConfigBancoInter.ExibeCamposCertificados(AExibir: Boolean);
begin
  pnlAuthV1.Enabled := AExibir;
  pnlAuthV2.Enabled := AExibir;
end;

procedure TfrmConfigBancoInter.FormCreate(Sender: TObject);
begin
  inherited;
  pCarKeyAutBan;
  FCadPor := fCriaQuery(Self);
  FCadFor := fCriaQuery(Self);
  FCadEmp := fCriaQuery(Self);
  FCadCta := fCriaQuery(Self);

  cxPaginas.Properties.ActivePage := tbsGeral;

  FCarteira := (tabCarteira.TabIndex + 1).ToString;
  CarregaDadosDaCarteira;

  ExibeCamposCertificados(fVerificaAcessoSistema('ALTCERTINT'));
end;

procedure TfrmConfigBancoInter.FormShow(Sender: TObject);
begin
  inherited;

  pnlAtivo2.Enabled := False;

  if FNaoEditar then
  begin
    btnConfigurar.Enabled := False;
    btnConfigurar.Visible := False;
    btnGravar.Enabled     := True;
    btnEditar.Visible     := False;
    pSetFocus(btnGravar);
  end;
end;

function TfrmConfigBancoInter.fRetornaStringCfg(
  ACofiguracao: TStringList): String;
  Var
    LCont : Integer;
begin
  Result := '';

  For LCont := 0 To ACofiguracao.Count - 1 Do
    Result := Result + ACofiguracao.Strings[LCont] + #13+#10;
end;

function TfrmConfigBancoInter.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  var
    LMensagemConfig: String;
Begin
  Result := True;

  LMensagemConfig := '';
  if FNaoEditar then
    LMensagemConfig := #13 + 'Por favor acesse a tela de configuração do banco selecionado ' + #13  + ' e corrija as informações necessárias!';

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodPor) Then
    Begin

      If fEmptyStr(edtCodPor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O portador deve ser preenchido!'+LMensagemConfig, ['&Ok']);
        edtDesPor.Clear;
        Result := False;
      End
      Else
      Begin
        CarregaPortador(edtCodPor.Text, edtDesPor);
        If FCadPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!'+LMensagemConfig, ['&Ok']);
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
            fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+LMensagemConfig, ['&Ok']);
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

    Else If (Sender = edtCtaBai) Then
    Begin

      If fEmptyStr(edtCtaBai.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser informado!'+LMensagemConfig, ['&Ok']);
        edtDesCtaBai.Clear;
        Result := False;
      End
      Else
      Begin
        CarregaPlanoDeContas(edtCtaBai.Text, edtDesCtaBai);
        If FCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!'+LMensagemConfig, ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtExpCgc) Then
    Begin

      If fEmptyStr(edtExpCgc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Exp. Cnpj do cedente deve ser preenchido!'+LMensagemConfig, ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If Pos(edtExpCgc.Text, 'S_N_') = 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo Exp. Cnpj do cedente deve conter apenas (S/N)!'+LMensagemConfig, ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtPerMul) Then
    Begin
      If Not fValidaEscala(edtPerMul.Text, 0, 99.99) Then
      begin
        fMensagem('ATENÇÃO','O campo percentual de multa deve estar entre 0 e 99,99!'+LMensagemConfig,['&OK']);
        Result := False;
      end;
    End

    Else If (Sender = edtCodAgencia) Then
    Begin
      If fEmptyStr(edtCodAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Código da Agência deve ser preenchido!'+LMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigitoAgencia) Then
    Begin
      If fEmptyStr(edtDigitoAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Dígito da Agência deve ser preenchido!'+LMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtContaCorr) Then
    Begin
      If fEmptyStr(edtContaCorr.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Conta Corrente deve ser preenchido!'+LMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigCtaCor) Then
    Begin
      If fEmptyStr(edtDigCtaCor.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Dígito da Conta Corrente deve ser preenchido!'+LMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodigoBeneficiario) Then
    Begin
      If fEmptyStr(edtCodigoBeneficiario.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Código do Beneficiário deve ser preenchido!'+LMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtArquivoCRT) And pnlAuthV1.Visible Then
    Begin

      If fEmptyStr(edtArquivoCRT.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O arquivo do certificado CRT deve ser selecionado!'+LMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtClientId) And pnlAuthV2.Visible Then
    Begin

      If fEmptyStr(edtClientId.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'o Campo Client ID deve ser preenchido!'+LMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtClientSecret) And pnlAuthV2.Visible Then
    Begin

      If fEmptyStr(edtClientSecret.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'o Campo Client Secret deve ser preenchido!'+LMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End


    Else If (Sender = edtArquivoKey) And pnlAuthV1.Visible Then
    Begin

      If fEmptyStr(edtArquivoKEY.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O arquivo do certificado KEY deve ser selecionado!'+LMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtDiasBaixaAutomatica) Then
    Begin

      If fEmptyStr(edtDiasBaixaAutomatica.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo dias corridos para baixa automática deve ser informado!'+LMensagemConfig, ['&Ok']);
        Result := False;
      End
      Else
      If Not fValidaEscala(edtDiasBaixaAutomatica.Text, 0, 60) Then
      Begin
        fMensagem('ATENÇÃO','O campo dias corridos para baixa automática deve deve estar entre 0 e 60!'+LMensagemConfig,['&OK']);
        Result := False;
      End;

    End

    // DADOS BENEFICIARIO
    Else If Sender = edtUsaSac Then
    Begin

      If Not MatchStr(edtUsaSac.Text, ['S', 'N']) Then
      Begin
        fMensagem('','O campo Enviar Sacador/Avalista deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      End
      Else If (edtUsaSac.Text = 'N') Then
      Begin
        edtCompBen.Clear;
        edtDesBen.Clear;
        edtEndBen.Clear;
        edtBaiBen.Clear;
        edtCidBen.Clear;
        edtEstBen.Clear;
        edtCepBen.Clear;
        edtCgcBen.Clear;
      End;


      grpBeneficiario.Enabled := edtUsaSac.Text = 'S';
    End

    Else If Sender = edtDesBen Then
    Begin
      If (fEmptyStr(edtDesBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Sacador/Avalista deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtEndBen Then
    Begin
      If (fEmptyStr(edtEndBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Endereço do Sacador/Avalista deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtBaiBen Then
    Begin
      If (fEmptyStr(edtBaiBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Bairro do Sacador/Avalista deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtCidBen Then
    Begin
      If (fEmptyStr(edtCidBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Cidade do Sacador/Avalista deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtEstBen Then
    Begin
      If (fEmptyStr(edtEstBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Estado do Sacador/Avalista deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtCepBen Then
    Begin
      If (edtUsaSac.Text = 'S') Then
      Begin
        If (fEmptyStr(fRetSomenteNumeros(edtCepBen.Text))) Then
        Begin
          fMensagem('ATENÇÃO','O campo CEP do Sacador/Avalista deve ser preenchido!' ,['&O K']);
          Result := False;
        End
        Else If Length(fRetSomenteNumeros(edtCepBen.Text)) < 8 Then
        Begin
          fMensagem('ATENÇÃO','O campo CEP do Sacador/Avalista deve ser preenchido com 8 números!' ,['&O K']);
          Result := False;
        End;
      End;
    End

    Else If Sender = edtCgcBen Then
    Begin
      If (edtUsaSac.Text = 'S') Then
      Begin
        If (fEmptyStr(fTiraCaracEspeciaisPonto(edtCgcBen.Text))) Then
        Begin
          fMensagem('ATENÇÃO','O campo CNPJ do Sacador/Avalista deve ser preenchido!' ,['&O K']);
          Result := False;
        End
        Else If (Length(fTiraCaracEspeciaisPonto(edtCgcBen.Text)) < 14) Or (Not fValidaCnpjCpf(edtCgcBen.Text)) Then
        Begin
          fMensagem('ATENÇÃO','O campo CNPJ do Sacador/Avalista deve conter um número válido!' ,['&O K']);
          Result := False;
        End;
      End;
    End;
    // END DADOS BENEFICIARIO

  End;

  If Not Result Then
  begin
    if not FNaoEditar then
    begin
     if (Sender is TEditFocus) then
       cxPaginas.ActivePage := TCxTabSheet(TEditFocus(Sender).Parent);

     if (Sender is TComboBoxFocus) then
       cxPaginas.ActivePage := TCxTabSheet(TComboBoxFocus(Sender).Parent);

      pSetFocus(Sender);
    end;
  end;
end;

procedure TfrmConfigBancoInter.LimpaCampos;
  Var
    LContador: Integer;
begin
  For LContador := Self.ComponentCount -1 downto 0 do
  begin
    if (Self.Components[LContador] is TEditFocus) then
      (Self.Components[LContador] as TEditFocus).Clear;

    if (Self.Components[LContador] is TCheckBox) then
      (Self.Components[LContador] as TCheckBox).Checked := False;

    if (Self.Components[LContador] is TComboBoxFocus) then
      (Self.Components[LContador] as TComboBoxFocus).ItemIndex := -1;
  end;
end;

procedure TfrmConfigBancoInter.MudaCorDaValidadeDoCertificado;
  Var
    LValidade: TDateTime;
begin
  lblValidadeCertificado.Font.Color := clBlack;

  If fEmptyStr(lblValidadeCertificado.Caption) Then
    Exit;

  LValidade := StrToDate(lblValidadeCertificado.Caption);
  If LValidade <= VS_Date Then
    lblValidadeCertificado.Font.Color := clRed
  Else If DaysBetween(LValidade, VS_Date) <= 30 Then
    lblValidadeCertificado.Font.Color := clGreen;
end;

procedure TfrmConfigBancoInter.PreparaAutenticacaoAPI;
begin
  Self.Enabled := False;
  Try
    Case StrToInt(LeftStr(cmbVersaoAPi.Text,1)) Of
      1: Begin
           // Versão 1.0
           pnlAuthV2.Visible := False;
           lblVersaoObs.Visible := True;
           pnlAuthV1.Visible := True;
           Self.Height := (540 - pnlAuthV2.Height);
           lblAmbiente.visible := False;
           cmbAmbiente.visible := False;
         End;
      2:
         Begin
           // Versão 2.0
           pnlAuthV2.Visible := True;
           lblVersaoObs.Visible := False;
           Self.Height := 540;
           lblAmbiente.visible := False;
           cmbAmbiente.visible := False;
         End;
      3:
         Begin
           // Versão 3.0
           pnlAuthV2.Visible := True;
           lblVersaoObs.Visible := False;
           Self.Height := 540;
           lblAmbiente.visible := True;
           cmbAmbiente.visible := True;
         End;
    End;
  Except
    cmbVersaoAPi.ItemIndex := 1;
  End;
  Self.Enabled := True;
end;

function TfrmConfigBancoInter.RetornaValidadeCertificado(
  AArquivo: String): String;
  Var
    LOpenSSL,
    LComando,
    LArqPem: String;

    LDataCertificado: TDateTime;
    LRetornaDataValidadeWS : TRetornaDataValidadeWS;
    i: dword;
begin
  Result := '';

  LOpenSSL := ExtractFilePath(Application.ExeName) + 'openssl\openssl.exe';
  LArqPem  := ExtractFilePath(Application.ExeName) + 'openssl\validade.pem';


  LComando := ' /C openssl x509 -in "' + AArquivo + '" ';
  If (Not fEmptyStr(edtSenhaCertificado.Text)) Then
    LComando := LComando + ' -passin pass:'+ edtSenhaCertificado.Text;
  LComando := LComando + ' -noout -enddate > validade.pem';

  If FileExists(LArqPem) Then
  Begin
    DeleteFile(LArqPem);
    Aguarde(200);
  End;

  If FileExists(LOpenSSL) Then
    ExecutaComandoWindows('', 'cmd.exe', PWideChar(LComando), PWideChar(ExtractFilePath(Application.ExeName) + 'openssl\'), SW_HIDE, True);
  Aguarde(1000);

  LDataCertificado := RetornaDataValidadeArquivoPEM(LArqPem);
  If LDataCertificado = 0 Then
  Begin

    If InternetGetConnectedState(@i,0) Then
    Begin

      Try
        LRetornaDataValidadeWS := TRetornaDataValidadeWS.Create;
        LRetornaDataValidadeWS.AArquivo := AArquivo;
        LRetornaDataValidadeWS.AWebBrowser := WebBrowser;
        TfrmGravando.fExecutarModalA(LRetornaDataValidadeWS.RetornaDataValidadeOnline,'Aguarde, Consultando Data de Validade.', '');
        LDataCertificado :=  LRetornaDataValidadeWS.ADataCertificado;
      Finally
        FreeAndNil(LRetornaDataValidadeWS);
      End;

      If (LDataCertificado = 0) Then
        fMensagem('ATENÇÃO', 'Não foi possível retornar a validade do certificado selecionado. ' + #13 +
                             'Verifique se a senha está correta ou se esse é um arquivo válido de certificado do Banco Inter.', ['&Ok']);
    End
    Else
      fMensagem('ATENÇÃO', 'Não foi possível retornar a validade do certificado selecionado. ' + #13 +
                           'Verifique sua conexão com a Internet.', ['&Ok']);
  End;

  If LDataCertificado <> 0 Then
    Result := FormatDateTime('dd/mm/yyyy', LDataCertificado);

  DeleteFile(LArqPem);
end;

function TfrmConfigBancoInter.RetornaValidadeCertificadoWebserviceCitel(
  AArquivo: String): String;
  Var
    LArquivoBase64: String;
begin
  LArquivoBase64 := RetornaArquivoBase64(AArquivo);

  Try
    Result := TRestSynalistAutBan.RetornaValidadeCertificadoCrtCitelWebhook(LArquivoBase64);
  Except
    On E: Exception Do
    Begin
      Result := RetornaValidadeCertificado(AArquivo);

      If Not Result.IsEmpty Then
        Exit;

      pMensagensErro('Ocorreu um erro ao retornar a validade do certificado.' + #13 +
                     'Erro gerado: ' + E.Message, '[TfrmConfigBancoInter.RetornaValidadeCertificadoWebserviceCitel]');

    End;
  End;
end;

procedure TfrmConfigBancoInter.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  CarregaDadosDaCarteira;
  cxPaginas.ActivePage := tbsGeral;
end;

procedure TfrmConfigBancoInter.tabCarteiraChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  if Not btnCancelar.Visible then
    Exit;

  btnCancelar.Click;

  AllowChange := Not btnCancelar.Visible;
end;

function TfrmConfigBancoInter.VerificaAValidadeDoCertificado: Boolean;
  Var
    LValidade: String;
begin
  Result := True;

  LValidade := lblValidadeCertificado.Caption;

  If LValidade.IsEmpty Then
    Exit;

  Result := StrToDate(LValidade) >= VS_Date;
  If Not Result Then
    fMensagem('ATENÇÃO', 'A validade do certificado está expirada. ' +
                         'É necessário gerar outro certificado com o Banco Inter e adicioná-lo na configuração.', ['&Ok']);
end;

procedure TfrmConfigBancoInter.GravaLogCarteira(ACfgAnt: TStringList);
  Var
    LCont,
    LIndice: Integer;

    LCfgAtu: TStringList;

    LCmpAlt: String;
begin
  LCfgAtu := TStringList.Create;
  CarregaCfg(LCfgAtu);
  LCmpAlt := '';

  For LCont := 0 To LCfgAtu.Count - 1 Do
  Begin
    If ACfgAnt.Strings[LCont] <> LCfgAtu.Strings[LCont] Then
    Begin
      LIndice := Pos(':', ACfgAnt.Strings[LCont]);

      If Not fEmptyStr(LCmpAlt) Then
        LCmpAlt := LCmpAlt + #13+#10;

      LCmpAlt := LCmpAlt + Copy(ACfgAnt.Strings[LCont], 1, LIndice) +
                 ' Valor Anterior - ' + Copy(ACfgAnt.Strings[LCont], LIndice + 1, Length(ACfgAnt.Strings[LCont]) - LIndice) +
                 ' Valor Atual - ' + Copy(LCfgAtu.Strings[LCont], LIndice + 1, Length(LCfgAtu.Strings[LCont]) - LIndice);
    End;
  End;

  If Not fEmptyStr(LCmpAlt) Then
    pGravaLogAtb('077', 'BANCO INTER', CONFIG + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetornaStringCfg(ACfgAnt), fRetornaStringCfg(LCfgAtu), LCmpAlt);

  FreeAndNil(LCfgAtu);
end;

procedure TfrmConfigBancoInter.Aguarde(msecs: Integer);
var
  FirstTickCount: LongInt;
begin
  FirstTickCount := GetTickCount;
  repeat
    Application.ProcessMessages;
  until ((LongInt(GetTickCount) - LongInt(FirstTickCount)) >= LongInt(msecs));
end;

{ TRetornaDataValidadeWS }

procedure TRetornaDataValidadeWS.Aguarde(msecs: Integer);
var
  FirstTickCount: LongInt;
begin

  repeat
    Application.ProcessMessages
  until FDocLoaded;// primeiro aguarda a pagina carregar por completo

  FirstTickCount := GetTickCount;
  repeat
    Application.ProcessMessages;
  until ((LongInt(GetTickCount) - LongInt(FirstTickCount)) >= LongInt(msecs));
end;

procedure TRetornaDataValidadeWS.ExecutaJavaScript(WebBrowser: TWebBrowser; Js: String);
var
  Doc: IHTMLDocument2;
  HTMLWindow: IHTMLWindow2;
begin
  Doc := WebBrowser.Document as IHTMLDocument2;
  if not Assigned(Doc) then
    Exit;
  HTMLWindow := Doc.parentWindow;
  if not Assigned(HTMLWindow) then
    Exit;
  try
    HTMLWindow.execScript(Js, 'JavaScript');
  except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  end;
end;

function TRetornaDataValidadeWS.FormataDataValidade(AData: String): TDateTime;
  Var
    LMeses: TStringList;
    LDD : String;
    LMM : String;
    LYY : String;
begin
  LMeses := TStringList.Create;
  Try
    LMeses.Add('JAN');
    LMeses.Add('FEB');
    LMeses.Add('MAR');
    LMeses.Add('APR');
    LMeses.Add('MAY');
    LMeses.Add('JUN');
    LMeses.Add('JUL');
    LMeses.Add('AUG');
    LMeses.Add('SEP');
    LMeses.Add('OCT');
    LMeses.Add('NOV');
    LMeses.Add('DEC');
    Try
      LDD := LeftStr(AData,2);
      LMM := (LMeses.IndexOf(Copy(AData.ToUpper, 4, 3)) + 1).ToString;
      LYY := RightStr(AData,4);
      Result := StrToDate(Concat(LDD,'/',LMM,'/',LYY));
    Except
    On E : Exception Do
      Begin
        Result := 0;
      End;
    End;

  Finally
    FreeAndNil(LMeses);
  End;
end;

function TRetornaDataValidadeWS.GetTextOfSite(
  WebBrowser: TWebBrowser): WideString;
var
  Doc: IHTMLDocument2;
begin
  Doc := WebBrowser.Document as IHTMLDocument2;
  repeat
    Application.ProcessMessages;
  until Assigned(Doc.body);

  Result := Doc.body.InnerText;
end;

procedure TRetornaDataValidadeWS.RetornaDataValidadeOnline;
  Var
    LTextOfSite: String;
    LData: String;
begin
  LWebBrowser.Silent := True;
  LWebBrowser.Visible := False;
  LWebBrowser.OnBeforeNavigate2   := WebBrowser1BeforeNavigate2;
  LWebBrowser.OnNavigateComplete2 := WebBrowser1NavigateComplete2;
  LWebBrowser.OnDocumentComplete  := WebBrowser1DocumentComplete;

  Try
    LWebBrowser.Navigate('https://certlogik.com/decoder/');
    Self.Aguarde(200);

    LWebBrowser.OleObject.Document.GetElementByID('textarea',0).value := RetornaValorCertificado;
    Self.Aguarde(200);

    ExecutaJavaScript(LWebBrowser,' document.getElementById("textarea").click(); ');
    Self.Aguarde(200);

    ExecutaJavaScript(LWebBrowser,' document.getElementById("submit.highlight").click(); ');
    Self.Aguarde(300);

    LTextOfSite := GetTextOfSite(LWebBrowser);
    LData       := Copy(LTextOfSite, Pos('Valid To',LTextOfSite) + 8, 11);

    Self.LDataCertificado := FormataDataValidade(LData);
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

function TRetornaDataValidadeWS.RetornaValorCertificado: String;
var
  LTextFile: TextFile;
  LLinha   : String;
  LTexto   : TStringList;
begin
  Result := '';
  Try
    LTexto := TStringList.Create;
    Try
      AssignFile(LTextFile, Self.LArquivo);
      Reset(LTextFile);

      While Not Eof(LTextFile) do
      begin
        ReadLn(LTextFile, LLinha);
        LTexto.Add(LLinha);
      end;

      CloseFile(LTextFile);
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    Result := LTexto.Text;
    FreeAndNil(LTexto);
  End;
end;

procedure TRetornaDataValidadeWS.WebBrowser1BeforeNavigate2(ASender: TObject;
  const pDisp: IDispatch; const URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
begin
  CurDispatch := nil;
  FDocLoaded := False;
end;

procedure TRetornaDataValidadeWS.WebBrowser1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
begin
  If (pDisp = CurDispatch) then
  begin
    FDocLoaded := True;
    CurDispatch := nil;
  end;
end;

procedure TRetornaDataValidadeWS.WebBrowser1NavigateComplete2(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
begin
  if CurDispatch = nil then
    CurDispatch := pDisp;
end;

end.
