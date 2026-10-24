unit untConfigSantanderAPI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, System.DateUtils,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, dxBarBuiltInMenu, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxTextEdit, cxCheckBox, cxButtons, untFrameGerarPixBoleto, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, cxGroupBox, Vcl.Mask, MaskEditFocus,
  untFramePlanoDeContasMaskEdit, ComboBoxFocus, EditFocus, QColorLabel, cxPC,
  Vcl.ComCtrls, Uni, cxProgressBar, dxScreenTip, dxCustomHint, cxHint,
  System.StrUtils, untTypesSistema;

type
  TfrmConfigSantanderAPI = class(TfrmPai)
    btnEditar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
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
    lblCodCart: TLabel;
    lblIdentBanco: TLabel;
    lblCodAgenc: TLabel;
    lblContCorr: TLabel;
    lblDiasProt: TLabel;
    lblInstrucao1: TLabel;
    lblInstrucao2: TLabel;
    lblPortadorBaixa: TLabel;
    lblObservacao1: TLabel;
    lblObservacao2: TLabel;
    lblObservacao3: TLabel;
    lblObservacao4: TLabel;
    lblObservacao5: TLabel;
    lblDiasCred: TLabel;
    Label14: TLabel;
    lblProAce: TLabel;
    lblSAcAva: TLabel;
    lblDupAgrSN: TColorLabel;
    lblSAcAvaSN: TColorLabel;
    lblDupAgr: TLabel;
    lblTipDia: TLabel;
    lblPerMul: TLabel;
    lblInfAdi: TLabel;
    lblContaCobr: TLabel;
    lblProAceSN: TColorLabel;
    edtIdentBanc: TEditFocus;
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
    edtContaCobr: TEditFocus;
    edtDiasCred: TEditFocus;
    edtSacAva: TEditFocus;
    edtDupAgr: TEditFocus;
    cmbTipDia: TComboBoxFocus;
    edtPerMul: TEditFocus;
    edtInfAdi: TEditFocus;
    cmbCodCar: TComboBoxFocus;
    cmbInstrucao1: TComboBoxFocus;
    cmbInstrucao2: TComboBoxFocus;
    edtProAce: TEditFocus;
    fraPlanoDeContasBai: TfraPlanoDeContasMskEdit;
    tbsComplemento: TcxTabSheet;
    pnlComplemento: TPanel;
    lblUsaSac: TLabel;
    lblUsaSacSN: TColorLabel;
    grpBeneficiario: TGroupBox;
    lblDesCrr: TLabel;
    lblEndBen: TLabel;
    lblCompBen: TLabel;
    lblBaiBen: TLabel;
    lblCidBen: TLabel;
    lblEstBen: TLabel;
    lblCepBen: TLabel;
    lblCNPJBen: TLabel;
    edtDesBen: TEditFocus;
    edtEndBen: TEditFocus;
    edtCompBen: TEditFocus;
    edtBaiBen: TEditFocus;
    edtCidBen: TEditFocus;
    edtEstBen: TEditFocus;
    edtCepBen: TMaskEditFocus;
    edtCgcBen: TMaskEditFocus;
    edtUsaSac: TEditFocus;
    tbsEncBan: TcxTabSheet;
    pnlAtivo2: TPanel;
    grpTarAux: TcxGroupBox;
    grdTarifas: TcxGrid;
    grdTarifasDBTableView1: TcxGridDBTableView;
    grdTarifasDBTableView1CNF_CODOCO: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_DESOCO: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_GERPAG: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_CUSCAR: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_FORNEC: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_PLNCON: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_PORTAD: TcxGridDBColumn;
    grdTarifasLevel1: TcxGridLevel;
    btnAddOco: TBitBtnLocked;
    btnRemOco: TBitBtnLocked;
    btnEdtOco: TBitBtnLocked;
    grpTarLiq: TcxGroupBox;
    Label51: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    edtDesPorTar: TEditFocus;
    edtPorTar: TEditFocus;
    edtValorTarifa: TEditFocus;
    edtDesForTar: TEditFocus;
    edtForTar: TEditFocus;
    fraPlanoDeContasEnc: TfraPlanoDeContasMskEdit;
    fraGerarPixBoleto: TfraGerarPixBoleto;
    grpDadosAutorizacao: TGroupBox;
    pnlAuthV2: TPanel;
    lblClientSecret: TLabel;
    lblClientID: TLabel;
    edtClientSecret: TEditFocus;
    edtClientID: TEditFocus;
    pnlCertificado: TPanel;
    lblValidadeCertificado: TLabel;
    lblVallidadeCertificadoDesc: TLabel;
    lblArquivoPFX: TLabel;
    edtArquivoPFX: TEditFocus;
    btnArquivoPFX: TcxButton;
    btnValidarDadosAutorizacao: TBitBtnLocked;
    edtWorkspace: TEditFocus;
    lblWorkspace: TLabel;
    lblSenhaCertificado: TLabel;
    edtSenhaCertificado: TEditFocus;
    HintControler: TcxHintStyleController;
    btnGerarWorkSpace: TBitBtnLocked;
    lblEmpresaConvenio: TLabel;
    edtEmpresaConvenio: TEditFocus;
    edtDescricaoEmpresaConvenio: TEditFocus;
    lblPerImpBol: TLabel;
    edtPerImpBol: TEditFocus;
    clbPerImpBol: TColorLabel;
    lblCreditDate: TLabel;
    edtCreditDate: TEditFocus;
    lblCreditDateSN: TColorLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnArquivoPFXClick(Sender: TObject);
    procedure tabCarteiraChange(Sender: TObject);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure fraGerarPixBoletoedtGerarPixChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnOcorrenciaClick(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasBaiMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure btnValidarDadosAutorizacaoClick(Sender: TObject);
    procedure btnGerarWorkSpaceClick(Sender: TObject);
    procedure edtEmpresaConvenioKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpresaConvenioMouseEnter(Sender: TObject);
    procedure edtEmpresaConvenioMouseLeave(Sender: TObject);
    procedure cxPaginasChange(Sender: TObject);
    procedure edtCreditDateMouseEnter(Sender: TObject);
    procedure edtCreditDateMouseLeave(Sender: TObject);
  private
    FPortador,
    FPlanoDeContas,
    FEmpresa: TUniQuery;

    FCarteira: String;

    FCfg_PORPGR,
    FCfg_CTAGCP: String;

    procedure Carregadados;
    procedure LimpaCampos;
    procedure CarregaCodigoDaCarteira;
    procedure CarregaInstrucoes;

    procedure CarregaCfg(Var ACampos: TStringList);
    procedure GravaLogCarteira(ACfgAnt: TStringList);
    function RetStrCfg(AConfig: TStringList): String;

    procedure CarregaPlanoDeContas(APlanoDeContas: String;  edtLabel: TEdit);
    procedure CarregaPortador(APortador: String; edtLabel: TEdit);
    procedure CarregaEmpresa(AEmpresa: String; edtLabel: TEdit);
    procedure ShowHint(edtEdit: TEditFocus; ATitulo: String);
    procedure HideHint;
    procedure HabilitaBotaoAutenticacao;

    function RetornaDadosCertificadoPFX(pgbStatus: TcxProgressBar): Boolean;

    function RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;
    { Private declarations }
  public
    blnNaoEditar : Boolean;
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigSantanderAPI: TfrmConfigSantanderAPI;

implementation

Uses untFuncoesSimples, untFuncoes, untGravando, untFuncAutban, untPesqAux,
     untConsultas, untCfgGenericas_AutBan, untMemo, untTBancoSantanderAPI;

{$R *.dfm}

procedure TfrmConfigSantanderAPI.btnArquivoPFXClick(Sender: TObject);
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

procedure TfrmConfigSantanderAPI.btnCancelarClick(Sender: TObject);
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
  HabilitaBotaoAutenticacao;

  CarregaDados;
  pSetFocus(btnEditar);
end;

procedure TfrmConfigSantanderAPI.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    HideHint;

    pCriarFormularios(TfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '033';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;
end;

procedure TfrmConfigSantanderAPI.btnEditarClick(Sender: TObject);
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
  HabilitaBotaoAutenticacao;

  fraGerarPixBoleto.edtGerarPix.OnChange(fraGerarPixBoleto.edtGerarPix);

  pSetFocus(cmbCodCar);
end;

procedure TfrmConfigSantanderAPI.btnGerarWorkSpaceClick(Sender: TObject);
  Var
    LBancoSantanderAPI: TBancoSantanderAPI;
begin
  inherited;
  If Not MatchStr(edtClientID.Text, ['', 'Client ID cadastrado']) Then
  Begin
    fGetBancoConfig(1, FCarteira, 'CLIENT_ID', edtClientID.Text);

    edtClientID.Text := 'Client ID cadastrado';
  End;


  If Not MatchStr(edtClientSecret.Text, ['', 'Client Secret cadastrado']) Then
  Begin
    fGetBancoConfig(1, FCarteira, 'CLIENT_SECRET', edtClientSecret.Text);

    edtClientSecret.Text := 'Client Secret cadastrado';
  End;

  If Not fVerificaCampos Then
    Exit;

  If Not fEmptyStr(edtWorkspace.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'Não é possível gerar uma nova Workspace.', ['&Ok']);
    Exit;
  End;

  If fGetBancoConfig(0, FCarteira, 'CLIENT_ID', '').IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário gravar o Client Id para a carteira.', ['&Ok']);
    Exit;
  End;

  If fGetBancoConfig(0, FCarteira, 'CLIENT_SECRET', '').IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário gravar o Client Secret para a carteira.', ['&Ok']);
    Exit;
  End;

  if fMensagem('ATENÇÃO', 'Deseja realmente gerar e/ou vincular uma Workspace ao CNPJ/Cedente?', ['&Sim', '&Não']) = 2 Then
    Exit;

  LBancoSantanderAPI := TBancoSantanderAPI.Create(FCarteira + '-' + VS_strCodEmp);

  Try
    TfrmGravando.fExecutarModal(LBancoSantanderAPI.ImportarCertificadoCitel,
                                'Aguarde... Validando dados de certificado.',
                                '');

    TfrmGravando.fExecutarModal(LBancoSantanderAPI.GerarWorkspaceSantander,
                                'Aguarde... Gerando/Vinculando uma Workspace.',
                                '');

    edtWorkspace.Text := fGetBancoConfig(0, FCarteira, 'WORKSPACE', '');

    If Not fEmptyStr(edtWorkSpace.Text) Then
      btnGravar.Click;
  Finally
    FreeAndNil(LBancoSantanderAPI);
  End;
end;

procedure TfrmConfigSantanderAPI.btnGravarClick(Sender: TObject);
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

    fGetBancoConfig(1, FCarteira, 'CODCART', LeftStr(cmbCodCar.Text, 1));
    fGetBancoConfig(1, FCarteira, 'IDENTBC', edtIdentBanc.Text    );
    fGetBancoConfig(1, FCarteira, 'CODAGEN', edtCodAgencia.Text   );
    fGetBancoConfig(1, FCarteira, 'NUMCTAC', edtContaCorr.Text    );
    fGetBancoConfig(1, FCarteira, 'NUMCTAB', edtContaCobr.Text    );
    fGetBancoConfig(1, FCarteira, 'DIAPROT', edtDiasProt.Text     );
    fGetBancoConfig(1, FCarteira, 'RESPONS', 'E');
    fGetBancoConfig(1, FCarteira, 'INSTRU1', LeftStr(cmbInstrucao1.Text, 2));
    fGetBancoConfig(1, FCarteira, 'INSTRU2', LeftStr(cmbInstrucao2.Text, 2));
    fGetBancoConfig(1, FCarteira, 'PORBAI_', edtCodPor.Text       );
    fGetBancoConfig(1, FCarteira, 'CTABAI_', fraPlanoDeContasBai.MskCodCta.Text);
    fGetBancoConfig(1, FCarteira, 'OBSERV1', edtObservacao1.Text  );
    fGetBancoConfig(1, FCarteira, 'OBSERV2', edtObservacao2.Text  );
    fGetBancoConfig(1, FCarteira, 'OBSERV3', edtObservacao3.Text  );
    fGetBancoConfig(1, FCarteira, 'OBSERV4', edtObservacao4.Text  );
    fGetBancoConfig(1, FCarteira, 'OBSERV5', edtObservacao5.Text  );
    fGetBancoConfig(1, FCarteira, 'DIACRED', edtDiasCred.Text     );
    fGetBancoConfig(1, FCarteira, 'PROACEI', edtProAce.Text       );
    fGetBancoConfig(1, FCarteira, 'DTACRED', edtCreditDate.Text   );
    fGetBancoConfig(1, FCarteira, 'MSACAVA', edtSacAva.Text       );
    fGetBancoConfig(1, FCarteira, 'ENVDPAG', edtDupAgr.Text       );
    fGetBancoConfig(1, FCarteira, 'PERMULT', edtPerMul.Text       );
    fGetBancoConfig(1, FCarteira, 'INFADIC', edtInfAdi.Text       );
    fGetBancoConfig(1, FCarteira, 'TIPDIA' , IntToStr(cmbTipDia.ItemIndex+1));
    fGetBancoConfig(1, FCarteira, 'PERIMPBOL', edtPerImpBol.Text);

    // dados beneficiario
    fGetBancoConfig(1, FCarteira, 'SACAVAL', edtUsaSac.Text        );
    fGetBancoConfig(1, FCarteira, 'NOMEBEN', edtDesBen.Text        );
    fGetBancoConfig(1, FCarteira, 'ENDEBEN', edtEndBen.Text        );
    fGetBancoConfig(1, FCarteira, 'BAIRBEN', edtBaiBen.Text        );
    fGetBancoConfig(1, FCarteira, 'COMPBEN', edtCompBen.Text       );
    fGetBancoConfig(1, FCarteira, 'CIDABEN', edtCidBen.Text        );
    fGetBancoConfig(1, FCarteira, 'ESTABEN', edtEstBen.Text        );
    fGetBancoConfig(1, FCarteira, 'CEP_BEN', edtCepBen.Text        );
    fGetBancoConfig(1, FCarteira, 'CNPJBEN', edtCgCBen.Text        );

    fGetBancoConfig(1, FCarteira, 'EMPCONV', edtEmpresaConvenio.Text);

    fGetBancoConfig(1, FCarteira, 'GERAPIX', fraGerarPixBoleto.edtGerarPix.Text);
    fGetBancoConfig(1, FCarteira, 'CHAPIX', IIF(fraGerarPixBoleto.edtGerarPix.Text = 'N', '', fraGerarPixBoleto.cmbChavePix.EditValue));

    If Not MatchStr(edtClientID.Text, ['', 'Client ID cadastrado']) Then
      fGetBancoConfig(1, FCarteira, 'CLIENT_ID', edtClientID.Text);

    If Not MatchStr(edtClientSecret.Text, ['', 'Client Secret cadastrado']) Then
      fGetBancoConfig(1, FCarteira, 'CLIENT_SECRET',edtClientSecret.Text);

    If Not MatchStr(edtWorkspace.Text, ['', 'Workspace da API registrado']) Then
      fGetBancoConfig(1, FCarteira, 'WORKSPACE',edtWorkspace.Text);

    If Not (btnGravar.Caption = '&OK') Then
    Begin
      pBackupCnfBco;

      fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);

      pSetFocus(cmbCodCar);
      blnMudarFoco := True;
      pnlAtivo1.Enabled := False;
      pnlComplemento.Enabled := pnlAtivo1.Enabled;
      pnlAtivo2.Enabled := False;
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

  HabilitaBotaoAutenticacao;
  FreeAndNil(LCfgAnt);
end;

procedure TfrmConfigSantanderAPI.BtnOcorrenciaClick(Sender: TObject);
  Var
    LDetalhe: String;
begin
  inherited;
  HideHint;

  LDetalhe := #13#10 +
              '02 - Atualiza nosso número caso não tenha gravado; ' + #13#10 +
              '06 - Baixa duplicata; ' + #13#10 +
              '06.01 - Baixa duplicata por Pix; ' + #13#10 +
              'As demais ocorrências são gravadas na rotina ' +
              'de retorno e mostradas no relatório apenas em ' +
              'caráter informativo.'+ #13#10 +
              #13#10 +
              'Pressione Esc para voltar à tela de configurações.';

  TfrmMemo.pShowMessage('Banco 033 - Santander [Online] - Detalhamento de Ocorrências.' + #13#10 +
                        LDetalhe);
end;

procedure TfrmConfigSantanderAPI.btnValidarDadosAutorizacaoClick(
  Sender: TObject);
  Var
    LBancoSantanderAPI: TBancoSantanderAPI;
begin
  inherited;

  LBancoSantanderAPI := TBancoSantanderAPI.Create(FCarteira + '-' + VS_strCodEmp);

  Try
    TfrmGravando.fExecutarModal(LBancoSantanderAPI.ValidarDadosAutorizacao,
                                'Aguarde... Validando dados de autorização.', '');
  Finally
    FreeAndNil(LBancoSantanderAPI);
  End;
end;

procedure TfrmConfigSantanderAPI.CarregaCfg(var ACampos: TStringList);
begin
  ACampos.Add('Cód. carteira     :' + fGetBancoConfig(0, FCarteira, 'CODCART', ''));
  ACampos.Add('Cód. da agência   :' + fGetBancoConfig(0, FCarteira, 'CODAGEN', ''));
  ACampos.Add('Ident. no banco   :' + fGetBancoConfig(0, FCarteira, 'IDENTBC', ''));
  ACampos.Add('Cód. da C/C       :' + fGetBancoConfig(0, FCarteira, 'NUMCTAC', ''));
  ACampos.Add('Conta cobrança    :' + fGetBancoConfig(0, FCarteira, 'NUMCTAB', ''));
  ACampos.Add('Dias p/ protesto  :' + fGetBancoConfig(0, FCarteira, 'DIAPROT', ''));
  ACampos.Add('Responsável Bol.  :' + fGetBancoConfig(0, FCarteira, 'RESPONS', ''));
  ACampos.Add('Observação 1      :' + fGetBancoConfig(0, FCarteira, 'OBSERV1', ''));
  ACampos.Add('Observação 2      :' + fGetBancoConfig(0, FCarteira, 'OBSERV2', ''));
  ACampos.Add('Observação 3      :' + fGetBancoConfig(0, FCarteira, 'OBSERV3', ''));
  ACampos.Add('Observação 4      :' + fGetBancoConfig(0, FCarteira, 'OBSERV4', ''));
  ACampos.Add('Observação 5      :' + fGetBancoConfig(0, FCarteira, 'OBSERV5', ''));
  ACampos.Add('Portador de baixa :' + fGetBancoConfig(0, FCarteira, 'PORBAI_', ''));
  ACampos.Add('Conta de baixa    :' + fGetBancoConfig(0, FCarteira, 'CTABAI_', ''));
  ACampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, FCarteira, 'DIACRED', ''));
  ACampos.Add('Protocolo aceite  :' + fGetBancoConfig(0, FCarteira, 'PROACEI', ''));
  ACampos.Add('Considerar liquidação pela data de crédito:' + fGetBancoConfig(0, FCarteira, 'DTACRED', ''));
  ACampos.Add('Cód. instrução 1  :' + fGetBancoConfig(0, FCarteira, 'INSTRU1', ''));
  ACampos.Add('Cód. instrução 2  :' + fGetBancoConfig(0, FCarteira, 'INSTRU2', ''));
  ACampos.Add('Inf. adicional    :' + fGetBancoConfig(0, FCarteira, 'INFADIC', ''));
  ACampos.Add('Env.nro. dup. agr.:' + fGetBancoConfig(0, FCarteira, 'ENVDPAG', ''));
  ACampos.Add('Percentual multa  :' + fGetBancoConfig(0, FCarteira, 'PERMULT', ''));
  ACampos.Add('Tipo dias (U/C)   :' + fGetBancoConfig(0, FCarteira, 'TIPDIA', ''));
  ACampos.Add('Mostra sac. aval. :' + fGetBancoConfig(0, FCarteira, 'MSACAVA', ''));
  ACampos.Add('Gera Remessa local:' + fGetBancoConfig(0, 'CONFIG033API', 'RELOCAL',  ''));
  ACampos.Add('Juros (%)         :' + fGetBancoConfig(0, 'CONFIG033API', 'JUROSDI',  ''));
  ACampos.Add('Não deixa val div :' + fGetBancoConfig(0, 'CONFIG033API', 'BAIDIVAUT',''));

  ACampos.Add('Envia Sacador/Avalista:' + fGetBancoConfig(0, FCarteira, 'SACAVAL', ''));
  ACampos.Add('Beneficiário      :' + fGetBancoConfig(0, FCarteira, 'NOMEBEN', ''));
  ACampos.Add('Endereço          :' + fGetBancoConfig(0, FCarteira, 'ENDEBEN', ''));
  ACampos.Add('Bairro            :' + fGetBancoConfig(0, FCarteira, 'BAIRBEN', ''));
  ACampos.Add('Complemento       :' + fGetBancoConfig(0, FCarteira, 'COMPBEN', ''));
  ACampos.Add('Cidade            :' + fGetBancoConfig(0, FCarteira, 'CIDABEN', ''));
  ACampos.Add('Estado            :' + fGetBancoConfig(0, FCarteira, 'ESTABEN', ''));
  ACampos.Add('CEP               :' + fGetBancoConfig(0, FCarteira, 'CEP_BEN', ''));
  ACampos.Add('CNPJ              :' + fGetBancoConfig(0, FCarteira, 'CNPJBEN', ''));

  ACampos.Add('Gera Pix QRCode :' + fGetBancoConfig(0, FCarteira, 'GERAPIX', ''));
  ACampos.Add('Chave Pix       :' + fGetBancoConfig(0, FCarteira, 'CHAPIX', ''));
  ACampos.Add('Client ID         :' + fGetBancoConfig(0, FCarteira, 'CLIENT_ID', ''));
  ACampos.Add('Client Secret     :' + fGetBancoConfig(0, FCarteira, 'CLIENT_SECRET', ''));
  ACampos.Add('Workstace API     :' + fGetBancoConfig(0, FCarteira, 'WORKSPACE', ''));
  ACampos.Add('Empresa Detent. Convênio:' + fGetBancoConfig(0, FCarteira, 'EMPCONV', ''));
  ACampos.Add('Permitir impressão de boletos:' + fGetBancoConfig(0, FCarteira, 'PERIMPBOL', ''));
end;

procedure TfrmConfigSantanderAPI.CarregaCodigoDaCarteira;
begin
  Try
    Case StrToInt(fGetBancoConfig(0, FCarteira, 'CODCART', '')) Of
      1: cmbCodCar.ItemIndex := 0;
      3: cmbCodCar.ItemIndex := 1;
      4: cmbCodCar.ItemIndex := 2;
      5: cmbCodCar.ItemIndex := 3;
      6: cmbCodCar.ItemIndex := 4;
      7: cmbCodCar.ItemIndex := 5;
      Else cmbCodCar.ItemIndex := -1;
    End;
  Except
    cmbCodCar.ItemIndex := -1;
  End;
end;

procedure TfrmConfigSantanderAPI.Carregadados;
begin
  tbsEncBan.TabVisible := False;

  fraGerarPixBoleto.CarregarChavesPix('033');
  FCarteira := 'CONFIG033API-' + (tabCarteira.TabIndex + 1).ToString;
  LimpaCampos;

  CarregaCodigoDaCarteira;
  CarregaInstrucoes;

  edtIdentBanc.Text     := fGetBancoConfig(0,FCarteira,'IDENTBC','');
  edtCodAgencia.Text    := fGetBancoConfig(0,FCarteira,'CODAGEN','');
  edtContaCorr.Text     := fGetBancoConfig(0,FCarteira,'NUMCTAC','');
  edtContaCobr.Text     := fGetBancoConfig(0,FCarteira,'NUMCTAB','');
  edtDiasProt.Text      := fGetBancoConfig(0,FCarteira,'DIAPROT','');

  edtDesPor.Clear;
  fraPlanoDeContasBai.edtDesCta.Clear;

  edtObservacao1.Text   := fGetBancoConfig(0,FCarteira,'OBSERV1','');
  edtObservacao2.Text   := fGetBancoConfig(0,FCarteira,'OBSERV2','');
  edtObservacao3.Text   := fGetBancoConfig(0,FCarteira,'OBSERV3','');
  edtObservacao4.Text   := fGetBancoConfig(0,FCarteira,'OBSERV4','');
  edtObservacao5.Text   := fGetBancoConfig(0,FCarteira,'OBSERV5','');

  edtCodPor.Text        := fGetBancoConfig(0,FCarteira,'PORBAI_','');
  fraPlanoDeContasBai.MskCodCta.Text := fGetBancoConfig(0,FCarteira,'CTABAI_','');
  edtDiasCred.Text      := fGetBancoConfig(0,FCarteira,'DIACRED','');
  edtProAce.Text        := fGetBancoConfig(0,FCarteira,'PROACEI','');
  edtSacAva.Text        := fGetBancoConfig(0,FCarteira,'MSACAVA','');
  edtDupAgr.Text        := fGetBancoConfig(0,FCarteira,'ENVDPAG','');
  edtPerMul.Text        := fGetBancoConfig(0,FCarteira,'PERMULT','');
  edtInfAdi.Text        := fGetBancoConfig(0,FCarteira,'INFADIC', '');
  cmbTipDia.ItemIndex   := StrToIntDef(fGetBancoConfig(0,FCarteira,'TIPDIA', '1'),0)-1;
  
  CarregaPortador(edtCodPor.Text, edtDesPor);
  CarregaPlanoDeContas(fraPlanoDeContasBai.MskCodCta.Text, fraPlanoDeContasBai.edtDesCta);

  //Dados Beneficiário
  edtUsaSac.Text        := fGetBancoConfig(0, FCarteira, 'SACAVAL', '');
  edtUsaSac.Text        := IIF(fEmptyStr(edtUsaSac.Text), 'N', edtUsaSac.Text);
  edtDesBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, FCarteira, 'NOMEBEN', ''), '');
  edtEndBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, FCarteira, 'ENDEBEN', ''), '');
  edtBaiBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, FCarteira, 'BAIRBEN', ''), '');
  edtCompBen.Text       := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, FCarteira, 'COMPBEN', ''), '');
  edtCidBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, FCarteira, 'CIDABEN', ''), '');
  edtEstBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, FCarteira, 'ESTABEN', ''), '');
  edtCepBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, FCarteira, 'CEP_BEN', ''), '');
  edtCgcBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, FCarteira, 'CNPJBEN', ''), '');

  edtEmpresaConvenio.Text := fGetBancoConfig(0, FCarteira, 'EMPCONV', '');
  CarregaEmpresa(edtEmpresaConvenio.Text, edtDescricaoEmpresaConvenio);

  fraGerarPixBoleto.edtGerarPix.Text := fGetBancoConfig(0, FCarteira, 'GERAPIX', '');
  fraGerarPixBoleto.cmbChavePix.EditValue := fGetBancoConfig(0, FCarteira, 'CHAPIX', '');
  fraGerarPixBoleto.cmbChavePix.Enabled := False;

  edtClientID.Clear;
  If fGetBancoConfig(0, FCarteira, 'CLIENT_ID', '') <> '' Then
    edtClientID.Text := 'Client ID cadastrado';

  edtClientSecret.Clear;
  If fGetBancoConfig(0, FCarteira, 'CLIENT_SECRET', '') <> '' Then
    edtClientSecret.Text := 'Client Secret cadastrado';

  edtPerImpBol.Text := fGetBancoConfig(0, FCarteira, 'PERIMPBOL', '');
  If fEmptyStr(edtPerImpBol.Text) Then
    edtPerImpBol.Text := 'S';

  edtWorkspace.Clear;
  If fGetBancoConfig(0, FCarteira, 'WORKSPACE', '') <> '' Then
    edtWorkspace.Text := 'Workspace da API registrado';

  edtCreditDate.Text := fGetBancoConfig(0, FCarteira, 'DTACRED', '');
  If fEmptyStr(edtCreditDate.Text) Then
    edtCreditDate.Text := 'S';

  fValidaCampos(edtUsaSac);
  fraGerarPixBoleto.edtGerarPix.OnChange(fraGerarPixBoleto.edtGerarPix);
end;

procedure TfrmConfigSantanderAPI.CarregaInstrucoes;
begin
  Try
    Case StrToInt(fGetBancoConfig(0, FCarteira,'INSTRU1', '')) Of
      0: cmbInstrucao1.ItemIndex := 0;
      6: cmbInstrucao1.ItemIndex := 1;
      7: cmbInstrucao1.ItemIndex := 2;
      Else cmbInstrucao1.ItemIndex := -1;
    End;
  Except
    cmbInstrucao1.ItemIndex := -1;
  End;

  Try
    Case StrToInt(fGetBancoConfig(0, FCarteira, 'INSTRU2', '')) Of
       0: cmbInstrucao2.ItemIndex := 0;
       2: cmbInstrucao2.ItemIndex := 1;
       3: cmbInstrucao2.ItemIndex := 2;
       4: cmbInstrucao2.ItemIndex := 3;
       Else cmbInstrucao2.ItemIndex := -1;
    End;
  Except
    cmbInstrucao2.ItemIndex := -1;
  End;
end;

procedure TfrmConfigSantanderAPI.CarregaPlanoDeContas(APlanoDeContas: String;
  edtLabel: TEdit);
begin
  edtLabel.Clear;

  If Not APlanoDeContas.IsEmpty Then
  Begin
    pPesquisaCadCta(Nil, FPlanoDeContas, APlanoDeContas);
    edtLabel.Text := FPlanoDeContas.FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmConfigSantanderAPI.CarregaPortador(APortador: String;
  edtLabel: TEdit);
begin
  edtLabel.Clear;

  If Not APortador.IsEmpty Then
  Begin
    pPesquisaCadPor(Nil, FPortador, APortador);
    edtLabel.Text := FPortador.FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmConfigSantanderAPI.cxPaginasChange(Sender: TObject);
begin
  inherited;
  HabilitaBotaoAutenticacao;
end;

procedure TfrmConfigSantanderAPI.CarregaEmpresa(AEmpresa: String;
  edtLabel: TEdit);
begin
  edtLabel.Clear;

  If Not AEmpresa.IsEmpty Then
  Begin
    pPesquisaCadEmp(Nil, FEmpresa, AEmpresa);
    edtLabel.Text := FEmpresa.FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmConfigSantanderAPI.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
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

procedure TfrmConfigSantanderAPI.edtCreditDateMouseEnter(Sender: TObject);
begin
  inherited;
  edtCreditDate.Hint := 'Ao habilitar esta opção, os títulos com data de crédito '+ #13 +
                        'informada serão considerados liquidados somente quando a ' + #13 +
                        'data de crédito for menor ou igual à data atual.';
  ShowHint(edtCreditDate,
           'Considerar liquidação pela data de crédito');
end;

procedure TfrmConfigSantanderAPI.edtCreditDateMouseLeave(Sender: TObject);
begin
  inherited;
  HideHint;
end;

procedure TfrmConfigSantanderAPI.edtEmpresaConvenioKeyPress(Sender: TObject;
  var Key: Char);
  var
    LArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqEmpresa(conEmpSimples, Self, edtEmpresaConvenio, edtDescricaoEmpresaConvenio, nil, Key, LArrSel) then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConfigSantanderAPI.edtEmpresaConvenioMouseEnter(Sender: TObject);
begin
  inherited;
  edtEmpresaConvenio.Hint := 'Caso o convênio não seja da empresa atual, ' + #13 +
                             'é necessário selecionar a empresa dona do convênio dessa carteira.';
  ShowHint(edtEmpresaConvenio,
           'Empresa detentora do convênio');
end;

procedure TfrmConfigSantanderAPI.edtEmpresaConvenioMouseLeave(Sender: TObject);
begin
  inherited;
  HideHint;
end;

procedure TfrmConfigSantanderAPI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(FPortador);
  FreeAndNil(FPlanoDeContas);
  FreeAndNil(FEmpresa);
end;

procedure TfrmConfigSantanderAPI.FormCreate(Sender: TObject);
begin
  inherited;
  FPortador := fCriaQuery;
  FPlanoDeContas := fCriaQuery;
  FEmpresa := fCriaQuery;

  fraGerarPixBoleto.CarregarChavesPix('033');

  pCarKeyAutBan;
  cxPaginas.Properties.ActivePage := tbsGeral;

  FCfg_PORPGR := fCfgSis('PORPGR', varString);
  FCfg_CTAGCP := fCfgSis('CTAGCP', varString);
end;

procedure TfrmConfigSantanderAPI.FormShow(Sender: TObject);
begin
  inherited;
  tbsEncBan.TabVisible := False;
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

  HabilitaBotaoAutenticacao;
end;

procedure TfrmConfigSantanderAPI.fraGerarPixBoletoedtGerarPixChange(
  Sender: TObject);
begin
  inherited;
  fraGerarPixBoleto.edtGerarPixChange(Sender);

end;

procedure TfrmConfigSantanderAPI.fraPlanoDeContasBaiMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  fraPlanoDeContasBai.MskCodCtaKeyPress(Sender, Key);

end;

function TfrmConfigSantanderAPI.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  var
    LMensagemConfig: String;
Begin
  LMensagemConfig := EmptyStr;
  if blnNaoEditar then
     LMensagemConfig := #13 + 'Por favor acesse a tela de configuração do banco selecionado ' + #13  + ' e corrija as informações necessárias!';

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = cmbCodCar) Then
    Begin

      If cmbCodCar.ItemIndex = -1 Then
      Begin
        fMensagem('', 'Carteira deve ser preenchida!'+LMensagemConfig,['&O K']);
        Result := False;
      End;

      If Result Then
        edtIdentBanc.Text := '033';

    End

    Else If (Sender = cmbInstrucao1) Then
    Begin

      If cmbInstrucao1.ItemIndex = -1 Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!'+LMensagemConfig,['&OK']);
        Result := False;
      End;

    End

    Else If (Sender = cmbInstrucao2) Then
    Begin

      If cmbInstrucao2.ItemIndex = -1 Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!'+LMensagemConfig,['&OK']);
        Result := False;
      End;

    End

    Else If Sender = edtPerImpBol Then
    Begin
      If Not MatchStr(edtPerImpBol.Text, ['S', 'N']) Then
      Begin
        fMensagem('ATENÇÃO','O campo Permitir impressão de boletos deve ser preenchido com (S/N)!'+LMensagemConfig,['&O K']);
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
        fMensagem('ATENÇÃO','O campo Beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtEndBen Then
    Begin
      If (fEmptyStr(edtEndBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Endereço do beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtBaiBen Then
    Begin
      If (fEmptyStr(edtBaiBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Bairro do beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtCidBen Then
    Begin
      If (fEmptyStr(edtCidBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Cidade do beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtEstBen Then
    Begin
      If (fEmptyStr(edtEstBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Estado do beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtCepBen Then
    Begin
      If (edtUsaSac.Text = 'S') Then
      Begin
        If (fEmptyStr(fRetSomenteNumeros(edtCepBen.Text))) Then
        Begin
          fMensagem('ATENÇÃO','O campo CEP do beneficiário deve ser preenchido!' ,['&O K']);
          Result := False;
        End
        Else If Length(fRetSomenteNumeros(edtCepBen.Text)) < 8 Then
        Begin
          fMensagem('ATENÇÃO','O campo CEP do beneficiário deve ser preenchido com 8 números!' ,['&O K']);
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
          fMensagem('ATENÇÃO','O campo CNPJ do beneficiário deve ser preenchido!' ,['&O K']);
          Result := False;
        End
        Else If (Length(fTiraCaracEspeciaisPonto(edtCgcBen.Text)) < 14) Or (Not fValidaCnpjCpf(edtCgcBen.Text)) Then
        Begin
          fMensagem('ATENÇÃO','O campo CNPJ do beneficiário deve conter um número válido!' ,['&O K']);
          Result := False;
        End;
      End;
    End
    // END DADOS BENEFICIARIO

    Else If Sender = edtProAce Then
    Begin
      If Not MatchStr(edtProAce.Text, ['S', 'N']) Then
      Begin
        fMensagem('','O campo Imprime Protocolo de Aceite deve ser preenchido com (S/N)!'+LMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtCreditDate Then
    Begin
      If Not MatchStr(edtCreditDate.Text, ['S', 'N']) Then
      Begin
        fMensagem('','O campo Considerar liquidação pela data de crédito deve ser preenchido com (S/N)!'+LMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtDupAgr Then
    Begin
      If Not MatchStr(edtDupAgr.Text, ['S', 'N']) Then
      Begin
        fMensagem('','O campo Enviar Núm. Dupl. Agrupadas deve ser preenchido com (S/N)!'+LMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtSacAva Then
    Begin

      If Pos(edtSacAva.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Mostrar Sacador Avalista deve ser preenchido com (S/N)!'+LMensagemConfig,['&O K']);
        Result := False;
      End
      Else If (edtUsaSac.Text = 'S') Then
      Begin
        If (edtSacAva.Text = 'N') Then
        Begin
          fMensagem('','O campo Mostrar Sacador Avalista deve ser preenchido com (S)im pois essa carteira está configurado para enviar sacador avalista!'+LMensagemConfig,['&O K']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtCodPor) Then
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
        If FPortador.FieldByName('POR_CODPOR').IsNull Then
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
        Else If FCfg_PORPGR.Equals(TEditFocus(Sender).Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Portador ' + FCfg_PORPGR + ' não permitido, pois está configurado para ' +
                               'baixa de Contas a Pagar no Resumo de Caixa.' + LMensagemConfig, ['&Ok']);
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

    Else If (Sender = edtEmpresaConvenio) Then
    Begin
      edtDescricaoEmpresaConvenio.Clear;
      if Not fEmptyStr(edtEmpresaConvenio.Text) then
      Begin
        CarregaEmpresa(edtEmpresaConvenio.Text, edtDescricaoEmpresaConvenio);
        If FEmpresa.FieldByName('EMP_NOMEMP').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!'+LMensagemConfig, ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender.Owner = fraPlanoDeContasBai) And (Sender.name = 'MskCodCta') Then
    Begin
      If fEmptyStr(fraPlanoDeContasBai.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser informado!'+LMensagemConfig, ['&Ok']);
        fraPlanoDeContasBai.edtDesCta.Clear;
        Result := False;
      End
      Else
      Begin
        CarregaPlanoDeContas(fraPlanoDeContasBai.MskCodCta.Text, fraPlanoDeContasBai.edtDesCta);
        If FPlanoDeContas.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!'+LMensagemConfig, ['&Ok']);
          Result := False;
        End
        Else If FCfg_CTAGCP.Equals(TEditFocus(Sender).Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Plano de Contas ' + FCfg_CTAGCP + ' não permitido, pois está configurado para ' +
                               'baixa de Contas a Pagar no Resumo de Caixa.' + LMensagemConfig, ['&Ok']);
          Result := False;
        End
        Else
          Result := PlanoDeContasAtivo(fraPlanoDeContasBai.MskCodCta.Text,True);
      End;

    End

    Else If (Sender = edtCodAgencia) Then
    Begin
      If fEmptyStr(edtCodAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Código da Agência deve ser preenchido!'+LMensagemConfig, ['&Ok']);
        Result := False;
      End
      Else If Length(edtCodAgencia.Text) <> edtCodAgencia.MaxLength Then
      Begin
        fMensagem('ATENÇÃO','O campo Código da Agência deve ter 4 caracteres!'+LMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtContaCorr) Then
    Begin
      If fEmptyStr(edtContaCorr.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Convênio do Cedente deve ser preenchido!'+LMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtContaCobr) Then
    Begin
      If fEmptyStr(edtContaCobr.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Número da Conta Cobrança deve ser preenchido!'+LMensagemConfig, ['&Ok']);
        Result := False;
      End
      Else If Length(edtContaCobr.Text) <> edtContaCobr.MaxLength Then
      Begin
        fMensagem('ATENÇÃO','O campo Número da Conta Cobrança deve ter 10 caracteres!'+LMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtDiasProt) Then
    Begin
      If LeftStr(cmbInstrucao1.Text, 2).Equals('06') Then
      Begin
        If fEmptyStr(edtDiasProt.Text) Then
        Begin
          fMensagem('ATENÇÃO','O campo Quantidade de dias para protesto deve ser preenchido!'+LMensagemConfig, ['&Ok']);
          Result := False;
        End
        Else If StrToInt(edtDiasProt.Text) <= 0 Then
        Begin
          fMensagem('ATENÇÃO','O campo Quantidade de dias para protesto deve ser maior que zero!'+LMensagemConfig, ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If Sender = fraGerarPixBoleto.edtGerarPix Then
    Begin
      If Not MatchStr(fraGerarPixBoleto.edtGerarPix.Text, ['S', 'N']) Then
      Begin
        fMensagem('ATENÇÃO','O campo Gerar boletos Pix QRCode deve ser preenchido com S ou N!' +LMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If Sender = fraGerarPixBoleto.cmbChavePix Then
    Begin
      If fraGerarPixBoleto.edtGerarPix.Text = 'S' Then
      Begin
        If VarToString(fraGerarPixBoleto.cmbChavePix.EditValue).IsEmpty Then
        Begin
          fMensagem('ATENÇÃO','O campo Chave Pix da Conta deve ser preenchido!' + LMensagemConfig, ['&OK']);
          Result := False;
        End;
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
end;

procedure TfrmConfigSantanderAPI.HabilitaBotaoAutenticacao;
begin
  btnValidarDadosAutorizacao.Visible := cxPaginas.ActivePageIndex = 0;
  btnValidarDadosAutorizacao.Enabled := not btnGravar.Enabled;
end;

procedure TfrmConfigSantanderAPI.HideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmConfigSantanderAPI.LimpaCampos;
  Var
    LIndice: Integer;
begin
  for LIndice := Self.ComponentCount -1 downto 0 do
  begin
    if (Self.Components[LIndice] is TEditFocus) then
      (Self.Components[LIndice] as TEditFocus).text := '';

    if (Self.Components[LIndice] is TCheckBox) then
      (Self.Components[LIndice] as TCheckBox).Checked := False;

    if (Self.Components[LIndice] is TComboBoxFocus) then
      (Self.Components[LIndice] as TComboBoxFocus).ItemIndex := -1;
  end;
end;

function TfrmConfigSantanderAPI.RetornaDadosCertificadoPFX(
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

function TfrmConfigSantanderAPI.RetStrCfg(AConfig: TStringList): String;
  Var
    LContador: Integer;
begin
  Result := '';

  For LContador := 0 To AConfig.Count - 1 Do
    Result := Result + AConfig.Strings[LContador] + #13+#10;
end;

procedure TfrmConfigSantanderAPI.ShowHint(edtEdit: TEditFocus; ATitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,
                         edtEdit.ClientOrigin.Y,
                         ATitulo,
                         edtEdit.Hint);
end;

procedure TfrmConfigSantanderAPI.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  Carregadados;
  cxPaginas.ActivePage := tbsGeral;
end;

procedure TfrmConfigSantanderAPI.tabCarteiraChanging(Sender: TObject;
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

function TfrmConfigSantanderAPI.RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;
begin
  While Not Sender.ClassName.Equals('TcxTabSheet') Do
  Begin
    Sender := Sender.Parent;
  End;
  Result := TcxTabSheet(Sender);
end;

procedure TfrmConfigSantanderAPI.GravaLogCarteira(ACfgAnt: TStringList);
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
    pGravaLogAtb('033',
                 'SANTANDER [Online]',
                  FCarteira + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado,
                 VS_StrCodEmp,
                 RetStrCfg(ACfgAnt),
                 RetStrCfg(LCfgAtu),
                 LCampoAlterado);

  FreeAndNil(LCfgAtu);
end;

end.
