unit untConfigSicoobApi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, System.DateUtils,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, dxBarBuiltInMenu, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxTextEdit, cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxGroupBox,
  untFramePlanoDeContasMaskEdit, untFrameCheckComboBoxOcorrencia,
  untFrameDirectoryEditFocus, ComboBoxFocus, EditFocus, QColorLabel, cxPC,
  Vcl.ComCtrls, untFrameGerarPixBoleto, cxButtons, Uni, cxProgressBar,
  dxScreenTip, dxCustomHint, cxHint, System.StrUtils;

type
  TfrmConfigSicoobApi = class(TfrmPai)
    btnGravar: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    BtnManual: TBitBtnLocked;
    BtnOcorrencia: TBitBtnLocked;
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
    pnlAtivo: TPanel;
    cxPaginas: TcxPageControl;
    tbsGeral: TcxTabSheet;
    pnlAtivo1: TPanel;
    lblCodCart: TLabel;
    lblCodAgenc: TLabel;
    lblIdentBanco: TLabel;
    lblContaCorrente: TLabel;
    lblModalidade: TLabel;
    lblInstrucao1: TLabel;
    lblObservacao1: TLabel;
    lblObservacao2: TLabel;
    lblObservacao3: TLabel;
    lblObservacao4: TLabel;
    lblObservacao5: TLabel;
    Label6: TLabel;
    lblDiasParaMora: TLabel;
    lblMulta: TLabel;
    lblPortadorBaixa: TLabel;
    lblInformacaoAdicional: TLabel;
    lblProtocoloAceite: TLabel;
    lblProtocoloAceiteSN: TColorLabel;
    lblDiasProt: TLabel;
    lblEspecieTitulo: TLabel;
    lblDigitoCooperativa: TLabel;
    lblDigitoCedente: TLabel;
    lblDigitoContaCorrente: TLabel;
    lblContCorr: TLabel;
    Label27: TLabel;
    ColorLabel6: TColorLabel;
    lblDiasParaCredito: TLabel;
    lblDesSuj: TLabel;
    clDesSuj: TColorLabel;
    lblDiasParaBaixa: TLabel;
    edtCodCar: TEditFocus;
    edtCodCop: TEditFocus;
    edtCodCed: TEditFocus;
    edtCtaCor: TEditFocus;
    cmbModali: TComboBoxFocus;
    cmbInstrucao1: TComboBoxFocus;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtObservacao5: TEditFocus;
    cmbProtesto: TComboBoxFocus;
    edtDiasMora: TEditFocus;
    edtPerMul: TEditFocus;
    edtCodPor: TEditFocus;
    edtInfAdi: TEditFocus;
    edtDesPor: TEditFocus;
    edtProAce: TEditFocus;
    edtDiasProt: TEditFocus;
    cmbEspDoc: TComboBoxFocus;
    edtDigCop: TEditFocus;
    edtDigCed: TEditFocus;
    edtDigCta: TEditFocus;
    edtNumCon: TEditFocus;
    edtEnviarSacador: TEditFocus;
    fraPlanoDeContasBai: TfraPlanoDeContasMskEdit;
    cmbTipoDtaCre: TComboBoxFocus;
    edtDiasCred: TEditFocus;
    cmbCodigoMulta: TComboBoxFocus;
    edtConDesSuj: TEditFocus;
    edtDiasLimiteRec: TEditFocus;
    tbsDadosAutorizacao: TcxTabSheet;
    pnlAtivo2: TPanel;
    fraGerarPixBoleto: TfraGerarPixBoleto;
    grpDadosAutorizacao: TGroupBox;
    pnlAuthV2: TPanel;
    lblAccessToken: TLabel;
    lblClientID: TLabel;
    edtAccessToken: TEditFocus;
    edtClientID: TEditFocus;
    pnlCertificado: TPanel;
    lblValidadeCertificado: TLabel;
    lblVallidadeCertificadoDesc: TLabel;
    lblArquivoPFX: TLabel;
    lblSenhaCertificado: TLabel;
    edtArquivoPFX: TEditFocus;
    btnArquivoPFX: TcxButton;
    edtSenhaCertificado: TEditFocus;
    HintControler: TcxHintStyleController;
    lblCodigoNegativacao: TLabel;
    lblDiasNegativacao: TLabel;
    cmbCodigoNegativacao: TComboBoxFocus;
    edtDiasNegativacao: TEditFocus;
    lblVersaoAPI: TLabel;
    cmbVersaoAPI: TComboBoxFocus;
    lblPerImpBol: TLabel;
    edtPerImpBol: TEditFocus;
    clbPerImpBol: TColorLabel;
    btnValidarDadosAutorizacao: TBitBtnLocked;
    lblVersaoObsoleta: TLabel;
    lbRestBoleto: TLabel;
    ColorLabel1: TColorLabel;
    edtRestBoleto: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure fraGerarPixBoletoedtGerarPixChange(Sender: TObject);
    procedure btnArquivoPFXClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure cmbProtestoChange(Sender: TObject);
    procedure cmbCodigoMultaChange(Sender: TObject);
    procedure edtConDesSujEnter(Sender: TObject);
    procedure edtConDesSujExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasBaiMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure cmbCodigoNegativacaoChange(Sender: TObject);
    procedure tabCarteiraChange(Sender: TObject);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure btnValidarDadosAutorizacaoClick(Sender: TObject);
    procedure cmbVersaoAPIChange(Sender: TObject);
  private
    FPortador,
    FPlanoDeContas: TUniQuery;

    FCarteira: String;

    FCfg_PORPGR,
    FCfg_CTAGCP: String;

    procedure CarregaDados;
    procedure LimpaCampos;

    procedure CarregaCfg(Var ACampos: TStringList);
    procedure GravaLogCarteira(ACfgAnt: TStringList);
    function RetStrCfg(AConfig: TStringList): String;

    procedure CarregaPortador(APortador: String; edtLabel: TEdit);
    procedure CarregaPlanoDeContas(APlanoDeContas: String;  edtLabel: TEdit);

    procedure ShowHint(edtEdit: TEditFocus; ATitulo: String);
    procedure HideHint;
    procedure AlteraHint(edtEdit: TEditFocus; ANovoHint: String);
    function RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;

    function RetornaDadosCertificadoPFX(pgbStatus: TcxProgressBar): Boolean;
    procedure MudaCorDaValidadeDoCertificado;

    procedure DefineDescricaoTipoMulta;

    function DadosDeAutorizacaoPreenchidos: Boolean;

    function ValidaDadosAutorizacao(prgStatus: TcxProgressBar): Boolean;
    { Private declarations }
  public
    blnNaoEditar : Boolean;
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigSicoobApi: TfrmConfigSicoobApi;

implementation
Uses untFuncoesSimples, untFuncoes, untPesqAux, untFuncAutban, untGravando,
  untCfgGenericas_AutBan, untTypesSistema, untConsultas, untTBancoSicoobAPI;

{$R *.dfm}

procedure TfrmConfigSicoobApi.AlteraHint(edtEdit: TEditFocus;
  ANovoHint: String);
begin
  edtEdit.Hint := ANovoHint;
end;

procedure TfrmConfigSicoobApi.btnArquivoPFXClick(Sender: TObject);
  Var
    LCaixaDialogo: TOpenDialog;

    LGravando: TfrmGravando;
begin
  LCaixaDialogo := TOpenDialog.Create(nil);
  try
    LCaixaDialogo.Title := 'Selecione o arquivo PFX';

    LCaixaDialogo.Options := [ofPathMustExist];

    LCaixaDialogo.Filter := 'Certificado PFX|*.pfx';

    If LCaixaDialogo.Execute Then
    Begin
      edtArquivopfx.Text := LCaixaDialogo.FileName;

      pCriarFormularios(TfrmGravando, LGravando);
      LGravando.lblGravando.Caption := 'Aguarde... Carregando Arquivo PFX.';
      LGravando.fExecutarAcao := RetornaDadosCertificadoPFX;
      LGravando.ShowModal;
      FreeAndNil(LGravando);
    End;
  finally
    LCaixaDialogo.Free;
  end;
end;

procedure TfrmConfigSicoobApi.btnCancelarClick(Sender: TObject);
begin
  if fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do registro da carteira selecionada?', ['&Sim', '&Não'], 2) = 2 then
    Exit;

  cxPaginas.ActivePage :=  tbsGeral;
  btnCancelar.Visible := False;
  btnEditar.Visible := True;
  pnlAtivo1.Enabled := False;
  pnlAtivo2.Enabled := False;
  btnEditar.Visible := True;
  btnGravar.Enabled := False;
  btnConfigurar.Enabled := False;

  CarregaDados;
  pSetFocus(btnEditar);
end;

procedure TfrmConfigSicoobApi.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    HideHint;

    pCriarFormularios(TfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '756';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;
end;

procedure TfrmConfigSicoobApi.btnEditarClick(Sender: TObject);
begin
  If Not strLoginUsuarioLogado.Equals('999') Then
  Begin
    If Not fVerificaDireitoAutBan('PERCARBAN')Then
    begin
      fMensagem('ATENÇÃO','Usuário sem permissão!', ['&Ok ']);
      Exit;
    end;
  End;

  pnlAtivo1.Enabled := True;
  pnlAtivo2.Enabled := True;

  btnGravar.Enabled := True;
  btnConfigurar.Enabled := True;
  btnEditar.Visible := False;
  btnCancelar.Visible := true;

  fraGerarPixBoleto.edtGerarPix.OnChange(fraGerarPixBoleto.edtGerarPix);

  pSetFocus(edtCodCar);
end;

procedure TfrmConfigSicoobApi.btnGravarClick(Sender: TObject);
  Var
    LCfgAnt: TStringList;
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  If blnNaoEditar Then
  Begin
    Self.Close;
    Self.ModalResult := mrOk;
    Exit;
  End;

  Try
    LCfgAnt := TStringList.Create;
    CarregaCfg(LCfgAnt);

    fGetBancoConfig(1, FCarteira, 'CODCART', edtCodCar.Text       );

    fGetBancoConfig(1, FCarteira, 'CODCOPE', edtCodCop.Text       );
    fGetBancoConfig(1, FCarteira, 'DIGCOPE', edtDigCop.Text       );
    fGetBancoConfig(1, FCarteira, 'CODCEDE', edtCodCed.Text       );
    fGetBancoConfig(1, FCarteira, 'DIGCEDE', edtDigCed.Text       );
    fGetBancoConfig(1, FCarteira, 'CODCCOR', edtCtaCor.Text       );
    fGetBancoConfig(1, FCarteira, 'DIGCCOR', edtDigCta.Text       );
    fGetBancoConfig(1, FCarteira, 'NUMCONV', edtNumCon.Text       );

    fGetBancoConfig(1, FCarteira, 'INSTRU1', LeftStr(cmbInstrucao1.Text,2));
    fGetBancoConfig(1, FCarteira, 'OBSERV1', edtObservacao1.Text  );
    fGetBancoConfig(1, FCarteira, 'OBSERV2', edtObservacao2.Text  );
    fGetBancoConfig(1, FCarteira, 'OBSERV3', edtObservacao3.Text  );
    fGetBancoConfig(1, FCarteira, 'OBSERV4', edtObservacao4.Text  );
    fGetBancoConfig(1, FCarteira, 'OBSERV5', edtObservacao5.Text  );

    fGetBancoConfig(1, FCarteira, 'DIAPROT', edtDiasProt.Text     );
    fGetBancoConfig(1, FCarteira, 'DIACRED', edtDiasCred.Text     );
    fGetBancoConfig(1, FCarteira, 'DIANEGA', edtDiasNegativacao.Text);
    fGetBancoConfig(1, FCarteira, 'DIAMORA', edtDiasMora.Text);

    fGetBancoConfig(1, FCarteira, 'PROACEI', edtProAce.Text       );
    fGetBancoConfig(1, FCarteira, 'RESPONS', 'E'                  );

    fGetBancoConfig(1, FCarteira, 'PORBAI_', edtCodPor.Text       );
    fGetBancoConfig(1, FCarteira, 'CTABAI_', fraPlanoDeContasBai.MskCodCta.Text);

    fGetBancoConfig(1, FCarteira, 'MODALID', LeftStr(cmbModali.Text,2));

    fGetBancoConfig(1, FCarteira, 'PERMULT', edtPerMul.Text       );
    fGetBancoConfig(1, FCarteira, 'INFADIC', edtInfAdi.Text       );
    fGetBancoConfig(1, FCarteira, 'CODPROT', LeftStr(cmbProtesto.Text,1));
    fGetBancoConfig(1, FCarteira, 'CODNEGA', LeftStr(cmbCodigoNegativacao.Text,1));
    fGetBancoConfig(1, FCarteira, 'TIPODTACRE', IntToStr(cmbTipoDtaCre.ItemIndex));
    fGetBancoConfig(1, FCarteira, 'CODIGOMULTA', IntToStr(cmbCodigoMulta.ItemIndex + 1));
    fGetBancoConfig(1, FCarteira, 'ESPDOC_', cmbEspDoc.Text);

    fGetBancoConfig(1, FCarteira, 'ENVSACA', edtEnviarSacador.Text);
    fGetBancoConfig(1, FCarteira, 'CONSIDESSUJ', edtConDesSuj.Text  );
    fGetBancoConfig(1, FCarteira, 'DIALIMR', edtDiasLimiteRec.Text     );

    fGetBancoConfig(1, FCarteira, 'GERAPIX', fraGerarPixBoleto.edtGerarPix.Text);
    fGetBancoConfig(1, FCarteira, 'CHAPIX', IIF(fraGerarPixBoleto.edtGerarPix.Text = 'N', '', fraGerarPixBoleto.cmbChavePix.EditValue));

    fGetBancoConfig(1, FCarteira, 'VERSAPI', cmbVersaoAPI.Text);
    fGetBancoConfig(1, FCarteira, 'PERIMPBOL', edtPerImpBol.Text);
    fGetBancoConfig(1, FCarteira, 'RESTAURABOL09', edtRestBoleto.Text);

    If Not MatchStr(edtArquivoPFX.Text, ['', 'certificado cadastrado']) Then
    Begin
      fGetBancoConfig(1, FCarteira, 'AUTHPFX', RetornaArquivoBase64(edtArquivoPFX.Text));

      fGetBancoConfig(1, FCarteira, 'VALCERT', lblValidadeCertificado.Caption);
    End;

    fGetBancoConfig(1, FCarteira, 'SENCERT', edtSenhaCertificado.Text);

    If Not MatchStr(edtClientID.Text, ['', 'Client ID cadastrado']) Then
      fGetBancoConfig(1, FCarteira, 'CLIENT_ID', edtClientID.Text);

    If Not MatchStr(edtAccessToken.Text, ['', 'Access Token cadastrado']) Then
      fGetBancoConfig(1, FCarteira, 'ACCESS_TOKEN',edtAccessToken.Text);

    If Not (btnGravar.Caption = '&OK') Then
    Begin
      pBackupCnfBco;
      fMensagem('', 'Dados salvos com sucesso.', ['&OK'], 1, True);
      pSetFocus(edtCodCar);
      blnMudarFoco := True;
      pnlAtivo1.Enabled := False;
      pnlAtivo2.Enabled := pnlAtivo1.Enabled;
      btnGravar.Enabled := False;
      btnConfigurar.Enabled := False;
      btnEditar.Visible := True;
      btnCancelar.Visible := False;
      pSetFocus(btnEditar);
    End
    Else
    Begin
      Self.Close;
      Self.ModalResult := mrOk;
    End;

    GravaLogCarteira(LCfgAnt);
    CarregaDados;
  Except
    On E:Exception Do
    Begin
      fMensagem('Erro','Ocorreu um erro ao tentar salvar os dados.' + #13 + E.Message,['&OK']);
    End;
  End;

  FreeAndNil(LCfgAnt);
end;

procedure TfrmConfigSicoobApi.btnValidarDadosAutorizacaoClick(Sender: TObject);
  Var
    LGravando: TfrmGravando;
begin
  inherited;
  If btnGravar.Enabled Then
  Begin
    fMensagem('ATENÇÃO', 'Para validar os dados de autorização, a configuração da carteira não pode estar em edição.', ['&Ok']);
    Exit;
  End;

  If Not DadosDeAutorizacaoPreenchidos Then
    Exit;

  Try
    pCriarFormularios(TfrmGravando, LGravando);
    LGravando.fExecutarAcao := ValidaDadosAutorizacao;
    LGravando.lblGravando.Caption := 'Aguarde... Validando credenciais.';
    LGravando.ShowModal;
  Finally
    FreeAndNil(LGravando);
  End;
end;

procedure TfrmConfigSicoobApi.CarregaCfg(var ACampos: TStringList);
begin
  ACampos.Clear;

  ACampos.Add('Código Carteira   : ' + fGetBancoConfig(0, FCarteira, 'CODCART', ''));
  ACampos.Add('Espécie Título    : ' + fGetBancoConfig(0, FCarteira, 'ESPDOC_', ''));
  ACampos.Add('Código Cooperativa: ' + fGetBancoConfig(0, FCarteira, 'CODCOPE', ''));
  ACampos.Add('Dígito Cooperativa: ' + fGetBancoConfig(0, FCarteira, 'DIGCOPE', ''));
  ACampos.Add('Código Cedente    : ' + fGetBancoConfig(0, FCarteira, 'CODCEDE', ''));
  ACampos.Add('Dígito Cedente    : ' + fGetBancoConfig(0, FCarteira, 'DIGCEDE', ''));
  ACampos.Add('Conta Corrente    : ' + fGetBancoConfig(0, FCarteira, 'CODCCOR', ''));
  ACampos.Add('Dig Cta Corrente  : ' + fGetBancoConfig(0, FCarteira, 'DIGCCOR', ''));
  ACampos.Add('Modalidade        : ' + fGetBancoConfig(0, FCarteira, 'MODALID', ''));
  ACampos.Add('Número Convênio   : ' + fGetBancoConfig(0, FCarteira, 'NUMCONV', ''));
  ACampos.Add('Cód. Instrução 1  : ' + fGetBancoConfig(0, FCarteira, 'INSTRU1', ''));
  ACampos.Add('Cód. Instrução 2  : ' + fGetBancoConfig(0, FCarteira, 'INSTRU2', ''));
  ACampos.Add('Observação 1      : ' + fGetBancoConfig(0, FCarteira, 'OBSERV1', ''));
  ACampos.Add('Observação 2      : ' + fGetBancoConfig(0, FCarteira, 'OBSERV2', ''));
  ACampos.Add('Observação 3      : ' + fGetBancoConfig(0, FCarteira, 'OBSERV3', ''));
  ACampos.Add('Observação 4      : ' + fGetBancoConfig(0, FCarteira, 'OBSERV4', ''));
  ACampos.Add('Observação 5      : ' + fGetBancoConfig(0, FCarteira, 'OBSERV5', ''));
  ACampos.Add('Código Protesto   : ' + fGetBancoConfig(0, FCarteira, 'CODPROT', ''));
  ACampos.Add('Dias p/ Protesto  : ' + fGetBancoConfig(0, FCarteira, 'DIAPROT', ''));
  ACampos.Add('Código Negativação: ' + fGetBancoConfig(0, FCarteira, 'CODNEGA', ''));
  ACampos.Add('Dias Negativação  : ' + fGetBancoConfig(0, FCarteira, 'DIANEGA', ''));
  ACampos.Add('Dias para mora    : ' + fGetBancoConfig(0, FCarteira, 'DIAMORA', ''));
  ACampos.Add('Dias p/ crédito   : ' + fGetBancoConfig(0, FCarteira, 'DIACRED', ''));
  ACampos.Add('Quant. dias para recebimento: ' + fGetBancoConfig(0, FCarteira, 'DIALIMR', ''));
  ACampos.Add('Percentual Multa  : ' + fGetBancoConfig(0, FCarteira, 'PERMULT', ''));
  ACampos.Add('Resp. Emissão Bol : ' + fGetBancoConfig(0, FCarteira, 'RESPONS', ''));
  ACampos.Add('Protocolo Aceite  : ' + fGetBancoConfig(0, FCarteira, 'PROACEI', ''));
  ACampos.Add('Portador de Baixa : ' + fGetBancoConfig(0, FCarteira, 'PORBAI_', ''));
  ACampos.Add('Conta Baixa       : ' + fGetBancoConfig(0, FCarteira, 'CTABAI_', ''));
  ACampos.Add('Info Adicional    : ' + fGetBancoConfig(0, FCarteira, 'INFADIC', ''));
  ACampos.Add('Enviar Sacador/Avalista na Remessa: ' + fGetBancoConfig(0, FCarteira, 'ENVSACA', ''));
  ACampos.Add('Tipo Dias para Crédito: ' + fGetBancoConfig(0, FCarteira, 'TIPODTACRE', ''));
  ACampos.Add('Codigo da Multa: ' + fGetBancoConfig(0, FCarteira, 'CODIGOMULTA', ''));
  ACampos.Add('Considerar Desconto Sugerido na baixa?:' + fGetBancoConfig(0, FCarteira, 'CONSIDESSUJ', ''));

  ACampos.Add('Gera Pix QRCode :' + fGetBancoConfig(0, FCarteira, 'GERAPIX', ''));
  ACampos.Add('Chave Pix       :' + fGetBancoConfig(0, FCarteira, 'CHAPIX', ''));
  ACampos.Add('Versão API Cobrança:' + fGetBancoConfig(0, FCarteira, 'VERSAPI', ''));
  ACampos.Add('Certificado PFX :' + fGetBancoConfig(0, FCarteira, 'AUTHPFX', ''));
  ACampos.Add('Senha Certificado:' + fGetBancoConfig(0, FCarteira, 'SENCERT', ''));
  ACampos.Add('Validade Certific.:' + fGetBancoConfig(0, FCarteira, 'VALCERT', ''));
  ACampos.Add('Client ID         :' + fGetBancoConfig(0, FCarteira, 'CLIENT_ID', ''));
  ACampos.Add('Access Token      :' + fGetBancoConfig(0, FCarteira, 'ACCESS_TOKEN', ''));
  ACampos.Add('Permitir impressão de boletos? :' + fGetBancoConfig(0, FCarteira, 'PERIMPBOL', ''));
  ACampos.Add('Restautar boletos com a ocorrência 09? :' + fGetBancoConfig(0, FCarteira, 'RESTAURABOL09', ''));
end;

procedure TfrmConfigSicoobApi.CarregaDados;
begin
  fraGerarPixBoleto.CarregarChavesPix('756');
  FCarteira := 'CONFIG756API-' + (tabCarteira.TabIndex + 1).ToString;
  LimpaCampos;

  edtCodCar.Text        := fGetBancoConfig(0,FCarteira,'CODCART','');

  edtCodCop.Text        := fGetBancoConfig(0,FCarteira,'CODCOPE','');
  edtDigCop.Text        := fGetBancoConfig(0,FCarteira,'DIGCOPE','');
  edtCodCed.Text        := fGetBancoConfig(0,FCarteira,'CODCEDE','');
  edtDigCed.Text        := fGetBancoConfig(0,FCarteira,'DIGCEDE','');
  edtCtaCor.Text        := fGetBancoConfig(0,FCarteira,'CODCCOR','');
  edtDigCta.Text        := fGetBancoConfig(0,FCarteira,'DIGCCOR','');
  edtNumCon.Text        := fGetBancoConfig(0,FCarteira,'NUMCONV','');
  edtEnviarSacador.Text := fGetBancoConfig(0,FCarteira,'ENVSACA','S');
  cmbEspDoc.ItemIndex   := cmbEspDoc.Items.IndexOf(fGetBancoConfig(0,FCarteira,'ESPDOC_', '02 - DM  Duplicata Mercantil'));

  try
    Case StrToInt(fGetBancoConfig(0,FCarteira,'INSTRU1','')) Of
      0: cmbInstrucao1.ItemIndex := 0;
      1: cmbInstrucao1.ItemIndex := 1;
      2: cmbInstrucao1.ItemIndex := 2;
      4: cmbInstrucao1.ItemIndex := 3;
      5: cmbInstrucao1.ItemIndex := 4;
      9: cmbInstrucao1.ItemIndex := 5;
      10: cmbInstrucao1.ItemIndex := 6;
      11: cmbInstrucao1.ItemIndex := 7;
      19: cmbInstrucao1.ItemIndex := 8;
      20: cmbInstrucao1.ItemIndex := 9;
      23: cmbInstrucao1.ItemIndex := 10;
      31: cmbInstrucao1.ItemIndex := 11;
    End;

  except
     cmbInstrucao1.ItemIndex := -1;
  end;

  Try
    Case StrToInt(fGetBancoConfig(0,FCarteira,'CODPROT', '')) Of
      1: cmbProtesto.ItemIndex := 0;
      2: cmbProtesto.ItemIndex := 1;
      3: cmbProtesto.ItemIndex := 2;
    End;
  except
    cmbProtesto.ItemIndex := -1;
  end;

  Try
    Case StrToInt(fGetBancoConfig(0,FCarteira,'CODNEGA', '')) Of
      2: cmbCodigoNegativacao.ItemIndex := 0;
      3: cmbCodigoNegativacao.ItemIndex := 1;
    End;
  except
    cmbCodigoNegativacao.ItemIndex := -1;
  end;

  Try
    Case StrToInt(fGetBancoConfig(0,FCarteira,'TIPODTACRE', '')) Of
      0: cmbTipoDtaCre.ItemIndex := 0;
      1: cmbTipoDtaCre.ItemIndex := 1;
    End;
  except
    cmbTipoDtaCre.ItemIndex := 0;
  end;

  Try
    Case StrToInt(fGetBancoConfig(0,FCarteira,'CODIGOMULTA', '')) Of
      1: cmbCodigoMulta.ItemIndex := 0;
      2: cmbCodigoMulta.ItemIndex := 1;
    End;
  except
    cmbCodigoMulta.ItemIndex := -1;
  end;

  edtDiasProt.Enabled := Copy(cmbProtesto.Text, 1, 1) <> '3';
  edtDiasNegativacao.Enabled := Copy(cmbCodigoNegativacao.Text, 1, 1) <> '3';

  edtObservacao1.Text   := fGetBancoConfig(0,FCarteira,'OBSERV1','');
  edtObservacao2.Text   := fGetBancoConfig(0,FCarteira,'OBSERV2','');
  edtObservacao3.Text   := fGetBancoConfig(0,FCarteira,'OBSERV3','');
  edtObservacao4.Text   := fGetBancoConfig(0,FCarteira,'OBSERV4','');
  edtObservacao5.Text   := fGetBancoConfig(0,FCarteira,'OBSERV5','');

  edtDiasProt.Text      := fGetBancoConfig(0,FCarteira,'DIAPROT','');
  edtDiasCred.Text      := fGetBancoConfig(0,FCarteira,'DIACRED','');
  edtDiasNegativacao.Text := fGetBancoConfig(0,FCarteira,'DIANEGA','');

  edtProAce.Text        := fGetBancoConfig(0,FCarteira,'PROACEI','');

  edtCodPor.Text        := fGetBancoConfig(0,FCarteira,'PORBAI_','');
  fraPlanoDeContasBai.MskCodCta.Text := fGetBancoConfig(0,FCarteira,'CTABAI_','');

  edtDiasLimiteRec.Text     := fGetBancoConfig(0,FCarteira,'DIALIMR','');

  edtPerImpBol.Text     := fGetBancoConfig(0,FCarteira, 'PERIMPBOL', '');
  If fEmptyStr(edtPerImpBol.Text) Then
    edtPerImpBol.Text := 'S';

  edtRestBoleto.Text := fGetBancoConfig(0,FCarteira,'RESTAURABOL09','');
  If fEmptyStr(edtRestBoleto.Text) Then
    edtRestBoleto.Text := 'N';

  fraGerarPixBoleto.edtGerarPix.Text := fGetBancoConfig(0, FCarteira, 'GERAPIX', '');
  fraGerarPixBoleto.cmbChavePix.EditValue := fGetBancoConfig(0, FCarteira, 'CHAPIX', '');
  fraGerarPixBoleto.cmbChavePix.Enabled := False;

  Try
    Case StrToInt(fGetBancoConfig(0,FCarteira,'VERSAPI', '')) Of
      2: cmbVersaoAPI.ItemIndex := 0;
      3: cmbVersaoAPI.ItemIndex := 1;
    End;
  except
    cmbVersaoAPI.ItemIndex := -1;
  end;

  lblVersaoObsoleta.Visible := cmbVersaoAPI.Text = '2';

  edtArquivoPFX.Clear;
  If fGetBancoConfig(0, FCarteira, 'AUTHPFX', '') <> '' Then
    edtArquivoPFX.Text := 'certificado cadastrado';

  edtSenhaCertificado.Text := fGetBancoConfig(0, FCarteira, 'SENCERT', '');
  lblValidadeCertificado.Caption := fGetBancoConfig(0, FCarteira, 'VALCERT', '');
  MudaCorDaValidadeDoCertificado;

  edtClientID.Clear;
  If fGetBancoConfig(0, FCarteira, 'CLIENT_ID', '') <> '' Then
    edtClientID.Text := 'Client ID cadastrado';

  edtAccessToken.Clear;
  If fGetBancoConfig(0, FCarteira, 'ACCESS_TOKEN', '') <> '' Then
    edtAccessToken.Text := 'Access Token cadastrado';

  try
    Case StrToInt(fGetBancoConfig(0,FCarteira,'MODALID','')) Of
      1: cmbModali.ItemIndex := 0;
      2: cmbModali.ItemIndex := 1;
      3: cmbModali.ItemIndex := 2;
    End;
  except
    cmbModali.ItemIndex := -1;
  end;

  edtPerMul.Text        := fGetBancoConfig(0,FCarteira,'PERMULT','');
  edtInfAdi.Text        := fGetBancoConfig(0,FCarteira,'INFADIC','');
  edtDiasLimiteRec.Text    := fGetBancoConfig(0,FCarteira, 'DIALIMR', '');

  edtDiasMora.Text := fGetBancoConfig(0,FCarteira, 'DIAMORA', '');
  If fEmptyStr(edtDiasMora.Text) then
    edtDiasMora.Text := '1';

  If Not fEmptyStr( edtCodPor.Text ) Then
    CarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( fraPlanoDeContasBai.MskCodCta.Text ) Then
    CarregaPlanoDeContas(fraPlanoDeContasBai.MskCodCta.Text, fraPlanoDeContasBai.edtDesCta);

  edtConDesSuj.Text := fGetBancoConfig(0, FCarteira, 'CONSIDESSUJ', '');

  If fEmptyStr(edtConDesSuj.Text) Then
    edtConDesSuj.Text := 'N';

  DefineDescricaoTipoMulta;

  lblAccessToken.Visible := fGetBancoConfig(0, FCarteira, 'HOMOLOGACAO', '').Equals('S');
  edtAccessToken.Visible := lblAccessToken.Visible;
  btnValidarDadosAutorizacao.Enabled := Not edtAccessToken.Visible;
end;

procedure TfrmConfigSicoobApi.CarregaPlanoDeContas(APlanoDeContas: String;
  edtLabel: TEdit);
begin
  edtLabel.Clear;

  If Not APlanoDeContas.IsEmpty Then
  Begin
    pPesquisaCadCta(Nil, FPlanoDeContas, APlanoDeContas);
    edtLabel.Text := FPlanoDeContas.FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmConfigSicoobApi.CarregaPortador(APortador: String;
  edtLabel: TEdit);
begin
  edtLabel.Clear;

  If Not APortador.IsEmpty Then
  Begin
    pPesquisaCadPor(Nil, FPortador, APortador);
    edtLabel.Text := FPortador.FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmConfigSicoobApi.cmbCodigoMultaChange(Sender: TObject);
begin
  inherited;
  DefineDescricaoTipoMulta;
end;

procedure TfrmConfigSicoobApi.cmbCodigoNegativacaoChange(Sender: TObject);
begin
  inherited;
  edtDiasNegativacao.Enabled := Copy(cmbCodigoNegativacao.Text, 1, 1) <> '3';

  If Not edtDiasNegativacao.Enabled Then
    edtDiasNegativacao.Text := '0';
end;

procedure TfrmConfigSicoobApi.cmbProtestoChange(Sender: TObject);
begin
  inherited;
  edtDiasProt.Enabled := Copy(cmbProtesto.Text, 1, 1) <> '3';

  If Not edtDiasProt.Enabled Then
    edtDiasProt.Text := '0';
end;

procedure TfrmConfigSicoobApi.cmbVersaoAPIChange(Sender: TObject);
begin
  inherited;
  lblVersaoObsoleta.Visible := cmbVersaoAPI.Text = '2';
end;

function TfrmConfigSicoobApi.DadosDeAutorizacaoPreenchidos: Boolean;
begin
  Result := True;

  If fEmptyStr(edtArquivoPfx.Text) Then
    Result := False;

  If fEmptyStr(edtSenhaCertificado.Text) Then
    Result := False;

  If fEmptyStr(edtClientID.Text) Then
    Result := False;

  If fGetBancoConfig(0, FCarteira, 'HOMOLOGACAO', '') = 'S' Then
    Result := Not fEmptyStr(edtAccessToken.Text);

  If Not Result Then
    fMensagem('ATENÇÃo', 'É necessário preencher todos os campos dos dados de autorização.', ['&Ok']);
end;

procedure TfrmConfigSicoobApi.DefineDescricaoTipoMulta;
begin
  lblMulta.Caption := 'Percentual de Multa:';
  If cmbCodigoMulta.ItemIndex = 0 Then
   lblMulta.Caption := 'Valor fixo de Multa:';
end;

procedure TfrmConfigSicoobApi.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmConfigSicoobApi.edtConDesSujEnter(Sender: TObject);
begin
  inherited;
  AlteraHint(edtConDesSuj, 'Quando a diferença no valor recebido ' + #13+#10 +
                           'for exatamento o valor de desconto sugerido ' + #13+#10 +
                           'cadastrado no título a diferença será abatida '+ #13+#10+
                           'como desconto. ' );

  ShowHint(edtConDesSuj, 'Desconto Sugerido');
end;

procedure TfrmConfigSicoobApi.edtConDesSujExit(Sender: TObject);
begin
  inherited;
  HideHint;
end;

procedure TfrmConfigSicoobApi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(FPortador);
  FreeAndNil(FPlanoDeContas);
end;

procedure TfrmConfigSicoobApi.FormCreate(Sender: TObject);
begin
  inherited;
  FPortador := fCriaQuery;
  FPlanoDeContas := fCriaQuery;

  fraGerarPixBoleto.CarregarChavesPix('756');

  pCarKeyAutBan;
  cxPaginas.Properties.ActivePage := tbsGeral;

  FCfg_PORPGR := fCfgSis('PORPGR', varString);
  FCfg_CTAGCP := fCfgSis('CTAGCP', varString);
end;

procedure TfrmConfigSicoobApi.FormShow(Sender: TObject);
begin
  inherited;
  FPlanoDeContas := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE');

  CarregaDados;

  pnlAtivo1.Enabled := False;
  pnlAtivo2.Enabled := False;

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

procedure TfrmConfigSicoobApi.fraGerarPixBoletoedtGerarPixChange(
  Sender: TObject);
begin
  inherited;
  fraGerarPixBoleto.edtGerarPixChange(Sender);
end;

procedure TfrmConfigSicoobApi.fraPlanoDeContasBaiMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContasBai.MskCodCta, fraPlanoDeContasBai.edtDesCta, Nil, Key, arrCentroCusto) Then
    if fValidaCampos(fraPlanoDeContasBai.MskCodCta) then
      SelectNext(ActiveControl, True, True);
end;

function TfrmConfigSicoobApi.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  var
  strMensagemConfig: String;
Begin

  Result := True;

  strMensagemConfig := EmptyStr;
  if blnNaoEditar then
    strMensagemConfig := #13 + 'Por favor acesse a tela de configuração do banco selecionado ' + #13  + ' e corrija as informações necessárias!';

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = cmbInstrucao1) Then
    Begin

      If cmbInstrucao1.ItemIndex = -1 Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!'+strMensagemConfig,['&OK']);
        Result := False;
      End

    End

    Else If Sender = edtProAce Then
    Begin
      If Pos(edtProAce.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Imprime Protocolo de Aceite deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtEnviarSacador Then
    Begin
      If Pos(edtEnviarSacador.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Enviar Sacador/Avalista na Rem. deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtDiasProt Then
    Begin

      If ((Copy(cmbProtesto.Text, 1, 1) <> '3') and ((edtDiasProt.Text = '') or (StrToInt(edtDiasProt.Text) = 0))) Then
      Begin
        fMensagem('','Para o código de protesto informado é obrigatório informar ' + #13 + ' os dias para protesto! '+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If Sender = edtPerImpBol Then
    Begin
      If Not MatchStr(edtPerImpBol.Text, ['S', 'N']) Then
      Begin
        fMensagem('','O campo Permitir impressão de boletos deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = cmbVersaoAPI) Then
    Begin

      If cmbVersaoAPI.ItemIndex = -1 Then
      Begin
        cxPaginas.Properties.ActivePage := tbsDadosAutorizacao;
        fMensagem('ATENÇÃO','O campo Versão API Cobrança deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else If cmbVersaoAPI.Text = '2' Then
      Begin
        If fraGerarPixBoleto.edtGerarPix.Text = 'S' Then
        Begin
          fMensagem('ATENÇÃO','Quando o campo Versão API Cobrança estiver selecionado a opção 2, não é possível Gerar Boletos com Pix QRCode!'+strMensagemConfig,['&OK']);
          Result := False;
        End;
      End;

    End

    Else If Sender = edtRestBoleto Then
    Begin
      If Not MatchStr(edtRestBoleto.Text, ['S', 'N']) Then
      Begin
        fMensagem('','O campo restaura boletos com a ocorrência 09 deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtDiasNegativacao Then
    Begin

      If ((Copy(cmbCodigoNegativacao.Text, 1, 1) <> '3') and ((edtDiasNegativacao.Text = '') or (StrToInt(edtDiasNegativacao.Text) = 0))) Then
      Begin
        fMensagem('','Para o código de negativação informado é obrigatório informar ' + #13 + ' os dias para negativação! '+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If Sender = edtDiasLimiteRec Then
    Begin

      If (edtDiasLimiteRec.Text = '') Then
      Begin
        fMensagem('','O campo quantidade de dias limite para recebimento deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If Sender = edtConDesSuj Then
    Begin
      If Pos(edtConDesSuj.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Considerar Desconto Sugerido na baixa? deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
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
        CarregaPortador(edtCodPor.Text, edtDesPor);
        If FPortador.FieldByName('POR_CODPOR').IsNull Then
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

    Else If (Sender = fraPlanoDeContasBai.MskCodCta) Then
    Begin

      If fEmptyStr(fraPlanoDeContasBai.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser informado!'+strMensagemConfig, ['&Ok']);
        fraPlanoDeContasBai.edtDesCta.Clear;
        Result := False;
      End
      Else
      Begin
        CarregaPlanoDeContas(fraPlanoDeContasBai.MskCodCta.Text, fraPlanoDeContasBai.edtDesCta);
        If FPlanoDeContas.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!'+strMensagemConfig, ['&Ok']);
          Result := False;
        End
        Else
          Result := PlanoDeContasAtivo(fraPlanoDeContasBai.MskCodCta.Text,True);
      End;

    End

    Else If Sender = edtDiasProt Then
    Begin

      If ((Pos(Copy(cmbProtesto.Text, 1, 1), '1_') > 0) and ((edtDiasProt.Text = '') or (StrToInt(edtDiasProt.Text) = 0))) Then
      Begin
        fMensagem('','Para o código de protesto informado é obrigatório informar ' + #13 + ' os dias para protesto! ', ['&O K']);
        Result := False;
      End;

    End

    Else If Sender = cmbProtesto Then
    Begin

      If fEmptyStr(cmbProtesto.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O Campo Código p/ protesto deve ser Preenchido!',['&O K']);
        Result := False;
      End;

    End

    Else If Sender = cmbCodigoNegativacao Then
    Begin

      If fEmptyStr(cmbCodigoNegativacao.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O Campo Código para negativação deve ser preenchido!',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtCodCar) Then
    Begin
      If fEmptyStr(edtCodCar.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Código da Carteira deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodCop) Then
    Begin
      If fEmptyStr(edtCodCop.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Código da Cooperativa deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End
      Else
      If Length(edtCodCop.Text) <> edtCodCop.MaxLength Then
      Begin
        fMensagem('ATENÇÃO','O campo Código da Cooperativa deve 4 caracteres!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigCop) Then
    Begin
      If fEmptyStr(edtDigCop.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Dígito da Cooperativa deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End
    End

    Else If (Sender = edtCodCed) Then
    Begin
      If fEmptyStr(edtCodCed.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Código do Cedente deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End
      Else
      If Length(edtCodCed.Text) <> edtCodCed.MaxLength Then
      Begin
        fMensagem('ATENÇÃO','O campo Código do Cedente deve ter 7 caracteres!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigCed) Then
    Begin
      If fEmptyStr(edtDigCed.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Dígito do Cedente deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCtaCor) Then
    Begin
      If fEmptyStr(edtCtaCor.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Conta Corrente deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigCta) Then
    Begin
      If fEmptyStr(edtDigCta.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Dígito da Conta Corrente deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = cmbModali) Then
    Begin
      If cmbModali.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO','O Campo Modalidade deve ser informado!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtNumCon) Then
    Begin
      If Not(fEmptyStr(edtNumCon.Text)) And
        (Length(edtNumCon.Text) <> edtNumCon.MaxLength) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Número do Convênio deve ter 6 caracteres!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If Sender = fraGerarPixBoleto.edtGerarPix Then
    Begin
      If Not MatchStr(fraGerarPixBoleto.edtGerarPix.Text, ['S', 'N']) Then
      Begin
        fMensagem('ATENÇÃO','O campo Gerar boletos Pix QRCode deve ser preenchido com S ou N!' +strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If Sender = fraGerarPixBoleto.cmbChavePix Then
    Begin
      If fraGerarPixBoleto.edtGerarPix.Text = 'S' Then
      Begin
        If VarToString(fraGerarPixBoleto.cmbChavePix.EditValue).IsEmpty Then
        Begin
          fMensagem('ATENÇÃO','O campo Chave Pix da Conta deve ser preenchido!' + strMensagemConfig, ['&OK']);
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
  begin
    cxPaginas.ActivePage := RetornaAbaDoComponete(Sender);
    if not blnNaoEditar then
    begin
      pSetFocus(Sender);
    end;
  end;
end;

procedure TfrmConfigSicoobApi.GravaLogCarteira(ACfgAnt: TStringList);
  Var
    LCfgAtu: TStringList;

    LCampoAlterado: String;

    LContador,
    LIndice: Integer;
begin
  LCfgAtu := TStringList.Create;
  CarregaCfg(LCfgAtu);
  LCampoAlterado := EmptyStr;

  For LContador := 0 To LCfgAtu.Count - 1 Do
  Begin
    If ACfgAnt.Strings[LContador] <> LCfgAtu.Strings[LContador] Then
    Begin
      LIndice := Pos(':', ACfgAnt.Strings[LContador]);

      If Not fEmptyStr(LCampoAlterado) Then
        LCampoAlterado := LCampoAlterado + #13+#10;

      LCampoAlterado := LCampoAlterado + Copy(ACfgAnt.Strings[LContador], 1, LIndice) +
                  ' Valor Anterior - ' + Copy(ACfgAnt.Strings[LContador], LIndice + 1, Length(ACfgAnt.Strings[LContador]) - LIndice) +
                  ' Valor Atual - ' + Copy(LCfgAtu.Strings[LContador], LIndice + 1, Length(LCfgAtu.Strings[LContador]) - LIndice);
    End;
  End;

  If Not fEmptyStr(LCampoAlterado) Then
    pGravaLogAtb('756',
                 'SICOOB [Online]',
                  FCarteira + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado,
                 VS_StrCodEmp,
                 RetStrCfg(ACfgAnt),
                 RetStrCfg(LCfgAtu),
                 LCampoAlterado);

  FreeAndNil(LCfgAtu);
end;

procedure TfrmConfigSicoobApi.HideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmConfigSicoobApi.LimpaCampos;
  Var
    LIndice: Integer;
begin
  for LIndice := Self.ComponentCount -1 downto 0 do
  begin
    if (Self.Components[LIndice] is TEditFocus) then
      (Self.Components[LIndice] as TEditFocus).text := '';

    if (Self.Components[LIndice] is TfraDirectoryEditFocus) then
      (Self.Components[LIndice] as TfraDirectoryEditFocus).edtDirectory.text := '';

    if (Self.Components[LIndice] is TCheckBox) then
      (Self.Components[LIndice] as TCheckBox).Checked := False;

    if (Self.Components[LIndice] is TComboBoxFocus) then
      (Self.Components[LIndice] as TComboBoxFocus).ItemIndex := -1;
  end;
end;

procedure TfrmConfigSicoobApi.MudaCorDaValidadeDoCertificado;
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

function TfrmConfigSicoobApi.RetornaAbaDoComponete(
  Sender: TWinControl): TCxTabSheet;
begin
  While Not Sender.ClassName.Equals('TcxTabSheet') Do
    Sender := Sender.Parent;

  Result := TcxTabSheet(Sender);
end;

function TfrmConfigSicoobApi.RetornaDadosCertificadoPFX(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    LOpenSSL,
    LComando,
    LArqPem,
    LArqDados,
    LPastaOpenSSL,
    LMensagemErro: String;

    LDataCertificado: TDateTime;
begin
  Result := True;

  LPastaOpenSSL := untFuncAutban.RetornaPastaOpenSSL;

  If LPastaOpenSSL.IsEmpty Then
  Begin
    edtArquivoPfx.Clear;
    Exit(False);
  End;

  If edtSenhaCertificado.Visible Then
  Begin
    If fEmptyStr(edtSenhaCertificado.Text) Then
    Begin
      fMensagem('ATENÇÃO', 'É necessário digitar a senha do certificado antes de selecionar o arquivo.', ['&Ok']);
      edtArquivoPfx.Clear;
      Exit(False);
    End;
  End;

  pgbStatus.Position := 0;
  pgbStatus.Properties.Max := 3;

  LOpenSSL := LPastaOpenSSL + 'openssl.exe';

  LArqPem  := LPastaOpenSSL + 'certificado.pem';

  LComando := ' /C ' + LOpenSSL + ' pkcs12 -in "' + edtArquivoPFX.Text + '" ';
  LComando := LComando + ' -passin pass:'+ edtSenhaCertificado.Text;
  LComando := LComando + ' -out "' + LArqPem + '" -nokeys';

  DeleteFile(LArqPem);
  Sleep(200);

  If FileExists(LArqPem) Then
  Begin
    fMensagem('ATENÇÃO', 'Apague o arquivo ' + LArqPem + ' para que possa ser gerado um novo.' , ['&Ok'], 0);
    edtArquivoPfx.Clear;
    Exit(False);
  End;

  ExecutaComandoWindows('', 'cmd.exe', PWideChar(LComando), '', SW_HIDE, True);
  Sleep(800);

  pgbStatus.Position := 1;

  //Validade
  LArqDados := LPastaOpenSSL + 'validade.pem';
  LComando := ' /C ' + LOpenSSL + ' x509 -in "' + LArqPem + '" ';
  LComando := LComando + ' -passin pass:'+ edtSenhaCertificado.Text;
  LComando := LComando + ' -noout -enddate > "' + LArqDados + '"';

  ExecutaComandoWindows('', 'cmd.exe', PWideChar(LComando), '', SW_HIDE, True);
  Sleep(800);

  LDataCertificado := untFuncoesSimples.RetornaDataValidadeArquivoPEM(LArqDados);
  DeleteFile(LArqDados);

  pgbStatus.Position := 2;

  If LDataCertificado = 0 Then
  Begin
    LMensagemErro := 'Não foi possível retornar a validade do certificado selecionado. ' + #13 +
                     'Verifique se é um arquivo válido de certificado';

    If edtSenhaCertificado.Visible Then
      LMensagemErro := LMensagemErro + ' ou se a senha digitada está correta';
    LMensagemErro := LMensagemErro + '.';

    fMensagem('ATENÇÃO', LMensagemErro, ['&Ok']);

    edtArquivoPfx.Clear;
    Exit(False);
  End;

  lblValidadeCertificado.Caption := FormatDateTime('dd/mm/yyyy', LDataCertificado);

  pgbStatus.Position := 3;
end;

function TfrmConfigSicoobApi.RetStrCfg(AConfig: TStringList): String;
begin

end;

procedure TfrmConfigSicoobApi.ShowHint(edtEdit: TEditFocus; ATitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,
                         edtEdit.ClientOrigin.Y,
                         ATitulo,
                         edtEdit.Hint);
end;

procedure TfrmConfigSicoobApi.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  Carregadados;
  cxPaginas.ActivePage := tbsGeral;
end;

procedure TfrmConfigSicoobApi.tabCarteiraChanging(Sender: TObject;
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

function TfrmConfigSicoobApi.ValidaDadosAutorizacao(prgStatus: TcxProgressBar): Boolean;
begin
  prgStatus.Visible := False;

  Result := True;

  Try
    TBancoSicoobAPI.Create(FCarteira + '-' + VS_strCodEmp).GerarToken;

    fMensagem('ATENÇÃO', 'Dados de autorização validados com sucesso!', ['&Ok']);
  Except
    On E: Exception Do
      fMensagem('ATENÇÃO', E.Message, ['&Ok']);
  End;
end;

end.
