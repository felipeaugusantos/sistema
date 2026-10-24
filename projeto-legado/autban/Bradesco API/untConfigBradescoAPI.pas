unit untConfigBradescoAPI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, System.StrUtils,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, dxBarBuiltInMenu, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxTextEdit, cxCheckBox, cxButtons, untFrameGerarPixBoleto, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, cxGroupBox, Vcl.Mask, MaskEditFocus,
  untFramePlanoDeContasMaskEdit, untFrameCheckComboBoxOcorrencia, ComboBoxFocus,
  EditFocus, QColorLabel, cxPC, Vcl.ComCtrls, Uni, dxScreenTip, dxCustomHint,
  cxHint, untConstantes, untTypesSistema, System.Json;

type
  TfrmConfigBradescoAPI = class(TfrmPai)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
    cxPaginas: TcxPageControl;
    tbsGeral: TcxTabSheet;
    pnlAtivo: TPanel;
    lblCodigoCedente: TLabel;
    lblCodAgenc: TLabel;
    lblCodCart: TLabel;
    lblContCorr: TLabel;
    lblDiasProt: TLabel;
    lblNumAutBco: TLabel;
    lblTipCob: TLabel;
    lblTipCobSD: TColorLabel;
    lblCodigoInstrucao: TLabel;
    lblPortadorBaixa: TLabel;
    lblObservacao1: TLabel;
    lblObservacao2: TLabel;
    lblObservacao3: TLabel;
    lblObservacao4: TLabel;
    lblObservacao5: TLabel;
    lblDiasCredito: TLabel;
    lblProtocoloAceiteSN: TColorLabel;
    lblProtocoloAceite: TLabel;
    lblPercentualMulta: TLabel;
    lblInformacaoAdicional: TLabel;
    lblDiasLimitePagamento: TLabel;
    lblExibirAgrupadas: TLabel;
    lblExibirAgrupadasSN: TColorLabel;
    lblEspecieDocumento: TLabel;
    lblEspecieDocumentoSN: TColorLabel;
    lblInstrucaoPersonalizada: TLabel;
    edtTipoCob: TEditFocus;
    edtNumAutBco: TEditFocus;
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
    edtPerMul: TEditFocus;
    edtInfAdi: TEditFocus;
    edtDiasLimitePagamento: TEditFocus;
    cmbInstrucao1: TComboBoxFocus;
    edtDigAge: TEditFocus;
    edtExibMsg: TEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    edtEspecieDocumento: TEditFocus;
    cmbInstruPersonalizada: TComboBoxFocus;
    bsComplemento: TcxTabSheet;
    pnlComplemento: TPanel;
    lblSacadorAvalista: TLabel;
    lblSacadorAvalistaSN: TColorLabel;
    lblSolicitarDataSN: TColorLabel;
    lblSolicitarData: TLabel;
    lblPerImpBol: TLabel;
    clbPerImpBol: TColorLabel;
    edtUsaSac: TEditFocus;
    grpBeneficiario: TGroupBox;
    lblDesCrr: TLabel;
    lblEnderecoBen: TLabel;
    lblComplementoBen: TLabel;
    lblBairroBen: TLabel;
    lblCidadeBen: TLabel;
    lblEstadoBen: TLabel;
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
    edtSolDta: TEditFocus;
    edtPerImpBol: TEditFocus;
    btnGravar: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    BtnManual: TBitBtnLocked;
    BtnOcorrencia: TBitBtnLocked;
    grpDadosAutorizacao: TGroupBox;
    pnlAuthV2: TPanel;
    lblClientID: TLabel;
    edtClientID: TEditFocus;
    pnlAuthV1: TPanel;
    lblValidadeCertificado: TLabel;
    lblValidadeCertificadoCaption: TLabel;
    lblArquivoCRT: TLabel;
    edtArquivoPFX: TEditFocus;
    btnArquivoPFX: TcxButton;
    HintControler: TcxHintStyleController;
    btnValidarDadosAutorizacao: TBitBtnLocked;
    lblImportarEmpresas: TLabel;
    lblImportarEmpresasSN: TColorLabel;
    lblBaixarBoletosArquivo: TLabel;
    lblBaixarBoletosArquivoSN: TColorLabel;
    edtImportarEmpresas: TEditFocus;
    edtBaixarBoletosArquivo: TEditFocus;
    lblSenhaCertificado: TLabel;
    edtSenhaCertificado: TEditFocus;
    lblClientSecret: TLabel;
    edtClientSecret: TEditFocus;
    fraGerarPixBoleto: TfraGerarPixBoleto;
    lblEmpresaConta: TLabel;
    edtEmpresaConta: TEditFocus;
    edtDescricaoEmpresaConta: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tabCarteiraChange(Sender: TObject);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure btnEditarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure BtnOcorrenciaClick(Sender: TObject);
    procedure btnValidarDadosAutorizacaoClick(Sender: TObject);
    procedure btnArquivoPFXClick(Sender: TObject);
    procedure edtDiasLimitePagamentoEnter(Sender: TObject);
    procedure edtDiasLimitePagamentoExit(Sender: TObject);
    procedure edtImportarEmpresasEnter(Sender: TObject);
    procedure fraGerarPixBoletoedtGerarPixChange(Sender: TObject);
    procedure edtEmpresaContaMouseEnter(Sender: TObject);
    procedure edtEmpresaContaMouseLeave(Sender: TObject);
    procedure edtEmpresaContaKeyPress(Sender: TObject; var Key: Char);
  private
    FPortador,
    FPlanoDeContas,
    FEmpresa: TUniQuery;

    FCarteira: String;

    FCfg_PORPGR,
    FCfg_CTAGCP: String;

    FJsonCertificado: TJsonObject;

    procedure Carregadados;
    procedure LimpaCampos;
    procedure CarregaInstrucoes;

    procedure CarregaCfg(Var ACampos: TStringList);
    procedure GravaLogCarteira(ACfgAnt: TStringList);
    function RetStrCfg(AConfig: TStringList): String;

    function RetornaDataJsonFormatada(ADataJson: String): String;

    procedure CarregaPlanoDeContas(APlanoDeContas: String;  edtLabel: TEdit);
    procedure CarregaPortador(APortador: String; edtLabel: TEdit);
    procedure CarregaEmpresa(AEmpresa: String; edtLabel: TEdit);
    procedure ShowHint(edtEdit: TEditFocus; ATitulo: String);
    procedure HideHint;

    function RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;

    function PossuiTodosOsDadosDeAutorizacao: Boolean;
    { Private declarations }
  public
    blnNaoEditar : Boolean;
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

implementation
Uses untFuncoesSimples, untFuncoes, untConsultas, untPesqAux, untMemo,
  untCfgGenericas_AutBan, untTBancoBradescoAPI, untFuncAutBan,
  untFuncoesBoleto;

{$R *.dfm}

procedure TfrmConfigBradescoAPI.btnArquivoPFXClick(Sender: TObject);
    Var
    LCaixaDialogo: TOpenDialog;
begin
  LCaixaDialogo := TOpenDialog.Create(nil);
  Try
    try
      LCaixaDialogo.Title := 'Selecione o arquivo PFX';

      LCaixaDialogo.Options := [ofPathMustExist];

      LCaixaDialogo.Filter := 'Certificado PFX|*.pfx';

      If Not LCaixaDialogo.Execute Then
        Exit;

      If Assigned(FJsonCertificado) Then
        FreeAndnil(FJsonCertificado);

      FJsonCertificado := TFuncoesPixBoleto.ConversorCertificadoPfxWebServiceCitelSemTela(LCaixaDialogo.FileName,
                                                                                          edtSenhaCertificado.Text);

      If FJsonCertificado = Nil Then
        Exit;

      If FJsonCertificado.GetValue('nomeEmpresa') <> Nil Then
      Begin
        edtArquivoPFX.Text := FJsonCertificado.GetValue<String>('nomeEmpresa') + ':' +
                              FJsonCertificado.GetValue<String>('cnpjEmpresa');
        lblValidadeCertificado.Caption := RetornaDataJsonFormatada(FJsonCertificado.GetValue<String>('dataValidade'));
      End;
    finally
      FreeAndNil(LCaixaDialogo);
    end;
  Except
    On E: Exception Do
      fMensagem('ATENÇÃO', 'Ocorreu um erro ao importar os dados do certificado.' + #13 +
                           'Erro gerado: ' + E.Message, ['&Ok']);
  End;
End;

procedure TfrmConfigBradescoAPI.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do registro da carteira selecionada?', ['&Sim', '&Não'], 2) = 2 then
    Exit;

  cxPaginas.ActivePage :=  tbsGeral;
  btnCancelar.Visible := False;
  btnEditar.Visible := True;
  pnlAtivo.Enabled := False;
  pnlComplemento.Enabled := False;
  btnEditar.Visible := True;
  btnGravar.Enabled := False;
  btnConfigurar.Enabled := False;

  CarregaDados;
  pSetFocus(btnEditar);
end;

procedure TfrmConfigBradescoAPI.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    HideHint;

    pCriarFormularios(TfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '237';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;
end;

procedure TfrmConfigBradescoAPI.btnEditarClick(Sender: TObject);
begin
  If Not strLoginUsuarioLogado.Equals('999') Then
  Begin
    If Not fVerificaDireitoAutBan('PERCARBAN')Then
    begin
      fMensagem('ATENÇÃO','Usuário sem permissão!', ['&Ok ']);
      Exit;
    end;
  End;

  pnlAtivo.Enabled := True;
  pnlComplemento.Enabled := True;

  btnGravar.Enabled := True;
  btnConfigurar.Enabled := True;
  btnEditar.Visible := False;
  btnCancelar.Visible := true;

  fraGerarPixBoleto.edtGerarPix.OnChange(fraGerarPixBoleto.edtGerarPix);

  pSetFocus(edtCodEmpBanco);
end;

procedure TfrmConfigBradescoAPI.btnGravarClick(Sender: TObject);
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

    fGetBancoConfig(1, FCarteira, 'CODEMPR', edtCodEmpBanco.Text   );
    fGetBancoConfig(1, FCarteira, 'CODCART', edtCodCar.Text        );
    fGetBancoConfig(1, FCarteira, 'CODAGEN', edtCodAgencia.Text    );
    fGetBancoConfig(1, FCarteira, 'DIGAGEN', edtDigAge.Text        );
    fGetBancoConfig(1, FCarteira, 'NUMCTAC', edtContaCorr.Text     );
    fGetBancoConfig(1, FCarteira, 'DIGCTAC', edtDigCtaCor.Text     );
    fGetBancoConfig(1, FCarteira, 'NUMAUTO', edtNumAutBco.Text     );
    fGetBancoConfig(1, FCarteira, 'DIAPROT', edtDiasProt.Text      );
    fGetBancoConfig(1, FCarteira, 'RESPONS', 'E');
    fGetBancoConfig(1, FCarteira, 'INSTRU1', LeftStr(cmbInstrucao1.Text,2));
    fGetBancoConfig(1, FCarteira, 'INSTPER', LeftStr(cmbInstruPersonalizada.Text,2));
    fGetBancoConfig(1, FCarteira, 'OBSERV1', edtObservacao1.Text   );
    fGetBancoConfig(1, FCarteira, 'OBSERV2', edtObservacao2.Text   );
    fGetBancoConfig(1, FCarteira, 'OBSERV3', edtObservacao3.Text   );
    fGetBancoConfig(1, FCarteira, 'OBSERV4', edtObservacao4.Text   );
    fGetBancoConfig(1, FCarteira, 'OBSERV5', edtObservacao5.Text   );
    fGetBancoConfig(1, FCarteira, 'TIPCOBR', edtTipoCob.Text       );
    fGetBancoConfig(1, FCarteira, 'PORBAI_', edtCodPor.Text        );
    fGetBancoConfig(1, FCarteira, 'SOLIDTA', edtSolDta.Text       );
    fGetBancoConfig(1, FCarteira, 'CTABAI_', fraPlanoDeContas.MskCodCta.Text);
    fGetBancoConfig(1, FCarteira, 'DIACRED', edtDiasCred.Text      );
    fGetBancoConfig(1, FCarteira, 'PROACEI', edtProAce.Text        );
    fGetBancoConfig(1, FCarteira, 'PERMULT', edtPerMul.Text        );
    fGetBancoConfig(1, FCarteira, 'INFADIC', edtInfAdi.Text        );
    fGetBancoConfig(1, FCarteira, 'DIALIMI', edtDiasLimitePagamento.Text);
    fGetBancoConfig(1, FCarteira, 'SACAVAL', edtUsaSac.Text        );
    fGetBancoConfig(1, FCarteira, 'NOMEBEN', edtDesBen.Text        );
    fGetBancoConfig(1, FCarteira, 'ENDEBEN', edtEndBen.Text        );
    fGetBancoConfig(1, FCarteira, 'BAIRBEN', edtBaiBen.Text        );
    fGetBancoConfig(1, FCarteira, 'COMPBEN', edtCompBen.Text       );
    fGetBancoConfig(1, FCarteira, 'CIDABEN', edtCidBen.Text        );
    fGetBancoConfig(1, FCarteira, 'ESTABEN', edtEstBen.Text        );
    fGetBancoConfig(1, FCarteira, 'CEP_BEN', edtCepBen.Text        );
    fGetBancoConfig(1, FCarteira, 'CNPJBEN', edtCgCBen.Text        );
    fGetBancoConfig(1, FCarteira, 'EXIBMSG', edtExibMsg.Text       );
    fGetBancoConfig(1, FCarteira, 'ESPDOCBOL', edtEspecieDocumento.Text         );
    fGetBancoConfig(1, FCarteira, 'PERIMPBOL', edtPerImpBol.Text       );
    fGetBancoConfig(1, FCarteira, 'IMPORTEMP', edtImportarEmpresas.Text);
    fGetBancoConfig(1, FCarteira, 'BAIBOLARQ', edtBaixarBoletosArquivo.Text);

    fGetBancoConfig(1, FCarteira, 'EMPCONT', edtEmpresaConta.Text);

    fGetBancoConfig(1, FCarteira, 'GERAPIX', fraGerarPixBoleto.edtGerarPix.Text);
    fGetBancoConfig(1, FCarteira, 'CHAPIX', IIF(fraGerarPixBoleto.edtGerarPix.Text = 'N', '', fraGerarPixBoleto.cmbChavePix.EditValue));

    If Not MatchStr(edtClientID.Text, ['', 'Client ID cadastrado']) Then
      fGetBancoConfig(1, FCarteira, 'CLIENT_ID', edtClientID.Text);

    If Not MatchStr(edtClientSecret.Text, ['', 'Client Secret cadastrado']) Then
      fGetBancoConfig(1, FCarteira, 'CLIENT_SECRET', edtClientSecret.Text);

    fGetBancoConfig(1, FCarteira, 'SENCERT', edtSenhaCertificado.Text);

    If (Not MatchStr(edtArquivoPFX.Text, ['', 'Certificado cadastrado'])) And (FJsonCertificado <> Nil) Then
    Begin
      fGetBancoConfig(1, FCarteira, 'AUTHPFX', RetornaValorJson(FJsonCertificado, 'base64'));
      fGetBancoConfig(1, FCarteira, 'AUTHCRT', RetornaValorJson(FJsonCertificado, 'chavePublica'));
      fGetBancoConfig(1, FCarteira, 'AUTHKEY', RetornaValorJson(FJsonCertificado, 'chavePrivada'));
      fGetBancoConfig(1, FCarteira, 'VALCERT', RetornaDataJsonFormatada(RetornaValorJson(FJsonCertificado, 'dataValidade')));
    End;

    If btnGravar.Caption = '&OK' Then
    Begin
      Self.Close;
      Self.ModalResult := mrOk;
    End
    Else
    Begin
      fMensagem('ATENÇÃO', 'Dados salvos com sucesso.', ['&OK'], 1, True);

      pSetFocus(edtCodEmpBanco);
      blnMudarFoco := True;
      pnlAtivo.Enabled := False;
      pnlComplemento.Enabled := pnlAtivo.Enabled;
      btnGravar.Enabled := False;
      btnConfigurar.Enabled := False;
      btnEditar.Visible := True;
      btnCancelar.Visible := False;
      pSetFocus(btnEditar);
    End;

    GravaLogCarteira(LCfgAnt);
    CarregaDados;
  Except
    On E:Exception Do
      fMensagem('Erro','Ocorreu um erro ao tentar salvar os dados.' + #13 + E.Message,['&OK']);
  End;

  FreeAndNil(LCfgAnt);
end;

procedure TfrmConfigBradescoAPI.BtnOcorrenciaClick(Sender: TObject);
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

  TfrmMemo.pShowMessage('Banco 237 - Bradesco [Online] - Detalhamento de Ocorrências.' + #13#10 +
                        LDetalhe);
end;

procedure TfrmConfigBradescoAPI.btnValidarDadosAutorizacaoClick(
  Sender: TObject);
  Var
    LBradesco: TBancoBradescoAPI;
begin
  inherited;
  If btnGravar.Enabled Then
  Begin
    fMensagem('ATENÇÃO', 'A carteira não pode estar em edição para utilizar essa função.', ['&Ok']);
    Exit;
  End;

  If Not PossuiTodosOsDadosDeAutorizacao Then
    Exit;

  LBradesco := TBancoBradescoAPI.Create(FCarteira + '-' + VS_strCodEmp);

  Try
    Try
      LBradesco.GerarToken(True);

      If LBradesco.TokenUsoAtual.IsEmpty Then
        Raise Exception.Create('Não foi possível realizar a validação. Verifique!');

      fMensagem('ATENÇÃO', 'Dados de autorização validados com sucesso.', ['&Ok']);
    Except
      On E: Exception Do
      Begin
        pGravarErro(True, E.Message, fRetornaStack);

        fMensagem('ERRO', E.Message, ['&Ok']);
      End;
    End;
  Finally
    FreeAndNil(LBradesco);
  End;
end;

procedure TfrmConfigBradescoAPI.CarregaCfg(var ACampos: TStringList);
begin
  ACampos.Add('Cód. Carteira     :' + fGetBancoConfig(0, FCarteira, 'CODCART', ''));
  ACampos.Add('Cód. Emp. Banco   :' + fGetBancoConfig(0, FCarteira, 'CODEMPR', ''));
  ACampos.Add('Cód. Agência      :' + fGetBancoConfig(0, FCarteira, 'CODAGEN', ''));
  ACampos.Add('Díg. Agência      :' + fGetBancoConfig(0, FCarteira, 'DIGAGEN', ''));
  ACampos.Add('Cta. Corrente     :' + fGetBancoConfig(0, FCarteira, 'NUMCTAC', ''));
  ACampos.Add('Dígito C/C        :' + fGetBancoConfig(0, FCarteira, 'DIGCTAC', ''));
  ACampos.Add('Tipo de cobrança  :' + fGetBancoConfig(0, FCarteira, 'TIPCOBR', ''));
  ACampos.Add('Núm. Autorização  :' + fGetBancoConfig(0, FCarteira, 'NUMAUTO', ''));
  ACampos.Add('Cód. Instrução    :' + fGetBancoConfig(0, FCarteira, 'INSTRU1', ''));
  ACampos.Add('Cód. Inst. Persona:' + fGetBancoConfig(0, FCarteira, 'INSTPER', ''));
  ACampos.Add('Percentual multa  :' + fGetBancoConfig(0, FCarteira, 'PERMULT', ''));
  ACampos.Add('Observação 1      :' + fGetBancoConfig(0, FCarteira, 'OBSERV1', ''));
  ACampos.Add('Observação 2      :' + fGetBancoConfig(0, FCarteira, 'OBSERV2', ''));
  ACampos.Add('Observação 3      :' + fGetBancoConfig(0, FCarteira, 'OBSERV3', ''));
  ACampos.Add('Observação 4      :' + fGetBancoConfig(0, FCarteira, 'OBSERV4', ''));
  ACampos.Add('Observação 5      :' + fGetBancoConfig(0, FCarteira, 'OBSERV5', ''));
  ACampos.Add('Dias p/ protesto  :' + fGetBancoConfig(0, FCarteira, 'DIAPROT', ''));
  ACampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, FCarteira, 'DIACRED', ''));
  ACampos.Add('Responsável Bol.  :' + fGetBancoConfig(0, FCarteira, 'RESPONS', ''));
  ACampos.Add('Prot. de aceite   :' + fGetBancoConfig(0, FCarteira, 'PROACEI', ''));
  ACampos.Add('Data Pagto Baixa  :' + fGetBancoConfig(0, FCarteira, 'SOLIDTA', ''));
  ACampos.Add('Portador de baixa :' + fGetBancoConfig(0, FCarteira, 'PORBAI_', ''));
  ACampos.Add('Conta de baixa    :' + fGetBancoConfig(0, FCarteira, 'CTABAI_', ''));
  ACampos.Add('Inf. adicional    :' + fGetBancoConfig(0, FCarteira, 'INFADIC', ''));
  ACampos.Add('Outros acréscimos :' + fGetBancoConfig(0, FCarteira, 'OUTACRE', ''));
  ACampos.Add('Envia Sac/Avalista:' + fGetBancoConfig(0, FCarteira, 'SACAVAL', ''));
  ACampos.Add('Nome beneficiário :' + fGetBancoConfig(0, FCarteira, 'NOMEBEN', ''));
  ACampos.Add('Endereço          :' + fGetBancoConfig(0, FCarteira, 'ENDEBEN', ''));
  ACampos.Add('Bairro            :' + fGetBancoConfig(0, FCarteira, 'BAIRBEN', ''));
  ACampos.Add('Complemento       :' + fGetBancoConfig(0, FCarteira, 'COMPBEN', ''));
  ACampos.Add('Cidade            :' + fGetBancoConfig(0, FCarteira, 'CIDABEN', ''));
  ACampos.Add('Estado            :' + fGetBancoConfig(0, FCarteira, 'ESTABEN', ''));
  ACampos.Add('CEP               :' + fGetBancoConfig(0, FCarteira, 'CEP_BEN', ''));
  ACampos.Add('CNPJ              :' + fGetBancoConfig(0, FCarteira, 'CNPJBEN', ''));
  ACampos.Add('Exibe mensagens   :' + fGetBancoConfig(0, FCarteira, 'EXIBMSG', ''));
  ACampos.Add('Permitir impressão de boletos? :' + fGetBancoConfig(0, FCarteira, 'PERIMPBOL', ''));
  ACampos.Add('Importar boletos de outras empresas:' + fGetBancoConfig(0, FCarteira, 'IMPORTEMP', ''));
  ACampos.Add('Baixar boletos gerados por arquivo remessa:' + fGetBancoConfig(0, FCarteira, 'BAIBOLARQ', ''));
  ACampos.Add('Client ID         :' + fGetBancoConfig(0, FCarteira, 'CLIENT_ID', ''));
  ACampos.Add('Client Secret     :' + fGetBancoConfig(0, FCarteira, 'CLIENT_SECRET', ''));
  ACampos.Add('Certificado PFX   :' + fGetBancoConfig(0, FCarteira, 'AUTHPFX', ''));
  ACampos.Add('Validade Certific.:' + fGetBancoConfig(0, FCarteira, 'VALCERT', ''));
  ACampos.Add('Gera Pix QRCode   :' + fGetBancoConfig(0, FCarteira, 'GERAPIX', ''));
  ACampos.Add('Chave Pix         :' + fGetBancoConfig(0, FCarteira, 'CHAPIX', ''));
  ACampos.Add('Empresa detentora da conta:' + fGetBancoConfig(0, FCarteira, 'EMPCONT', ''));
end;

procedure TfrmConfigBradescoAPI.Carregadados;
begin
  fraGerarPixBoleto.CarregarChavesPix('237');
  FCarteira := 'CONFIG237API-' + (tabCarteira.TabIndex + 1).ToString;
  LimpaCampos;

  edtCodEmpBanco.Text    := fGetBancoConfig(0, FCarteira, 'CODEMPR', '');
  edtCodCar.Text         := fGetBancoConfig(0, FCarteira, 'CODCART', '');
  edtCodAgencia.Text     := fGetBancoConfig(0, FCarteira, 'CODAGEN', '');
  edtContaCorr.Text      := fGetBancoConfig(0, FCarteira, 'NUMCTAC', '');
  edtDigCtaCor.Text      := fGetBancoConfig(0, FCarteira, 'DIGCTAC', '');
  edtNumAutBco.Text      := fGetBancoConfig(0, FCarteira, 'NUMAUTO', '');
  edtDiasProt.Text       := fGetBancoConfig(0, FCarteira, 'DIAPROT', '');
  
  CarregaInstrucoes;

  edtObservacao1.Text    := fGetBancoConfig(0, FCarteira, 'OBSERV1', '');
  edtObservacao2.Text    := fGetBancoConfig(0, FCarteira, 'OBSERV2', '');
  edtObservacao3.Text    := fGetBancoConfig(0, FCarteira, 'OBSERV3', '');
  edtObservacao4.Text    := fGetBancoConfig(0, FCarteira, 'OBSERV4', '');
  edtObservacao5.Text    := fGetBancoConfig(0, FCarteira, 'OBSERV5', '');
  edtTipoCob.Text        := fGetBancoConfig(0, FCarteira, 'TIPCOBR', '');
  edtCodPor.Text         := fGetBancoConfig(0, FCarteira, 'PORBAI_', '');
  fraPlanoDeContas.MskCodCta.Text := fGetBancoConfig(0, FCarteira, 'CTABAI_', '');
  edtDiasCred.Text       := fGetBancoConfig(0, FCarteira, 'DIACRED', '');
  edtProAce.Text         := fGetBancoConfig(0, FCarteira, 'PROACEI', '');
  edtDigAge.Text         := fGetBancoConfig(0, FCarteira, 'DIGAGEN', '');
  edtPerMul.Text         := fGetBancoConfig(0, FCarteira, 'PERMULT', '');
  edtSolDta.Text         := fGetBancoConfig(0, FCarteira, 'SOLIDTA', 'N');
  edtSolDta.Text         := IIF(fEmptyStr(edtSolDta.Text), 'N', edtSolDta.Text);
  edtInfAdi.Text         := fGetBancoConfig(0, FCarteira, 'INFADIC', '');
  edtDiasLimitePagamento.Text := fGetBancoConfig(0, FCarteira, 'DIALIMI', '');
  edtExibMsg.Text        := fGetBancoConfig(0, FCarteira, 'EXIBMSG', '');
  edtExibMsg.Text        := IIF(fEmptyStr(edtExibMsg.Text), 'S', edtExibMsg.Text);
  edtImportarEmpresas.Text := fGetBancoConfig(0, FCarteira, 'IMPORTEMP', 'N');
  edtBaixarBoletosArquivo.Text := fGetBancoConfig(0, FCarteira, 'BAIBOLARQ', 'N');

  If edtImportarEmpresas.Text = EmptyStr Then
    edtImportarEmpresas.Text   := 'N';

  If edtBaixarBoletosArquivo.Text = EmptyStr Then
    edtBaixarBoletosArquivo.Text   := 'N';

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

  edtEmpresaConta.Text := fGetBancoConfig(0, FCarteira, 'EMPCONT', '');
  CarregaEmpresa(edtEmpresaConta.Text, edtDescricaoEmpresaConta);

  edtPerImpBol.Text := fGetBancoConfig(0,FCarteira, 'PERIMPBOL', '');
  If fEmptyStr(edtPerImpBol.Text) Then
    edtPerImpBol.Text := 'S';

  edtEspecieDocumento.Text := fGetBancoConfig(0, FCarteira, 'ESPDOCBOL', '');
  If fEmptyStr(edtEspecieDocumento.Text) Then
    edtEspecieDocumento.Text := 'N';

  fValidaCampos(edtUsaSac);

  edtNumAutBco.Enabled := True;
  If edtTipoCob.Text = 'S' Then
  Begin
    edtNumAutBco.Enabled := False;
    edtNumAutBco.Clear;
  End;

  fraGerarPixBoleto.edtGerarPix.Text := fGetBancoConfig(0, FCarteira, 'GERAPIX', '');
  fraGerarPixBoleto.cmbChavePix.EditValue := fGetBancoConfig(0, FCarteira, 'CHAPIX', '');
  fraGerarPixBoleto.cmbChavePix.Enabled := False;

  If Not fGetBancoConfig(0, FCarteira, 'AUTHPFX', '').IsEmpty Then
  Begin
    edtArquivoPFX.Text := 'Certificado cadastrado';
    lblValidadeCertificado.Caption := fGetBancoConfig(0, FCarteira, 'VALCERT', '');
  End;

  If Not fGetBancoConfig(0, FCarteira, 'CLIENT_ID', '').IsEmpty Then
    edtClientID.Text := 'Client ID cadastrado';

  If Not fGetBancoConfig(0, FCarteira, 'CLIENT_SECRET', '').IsEmpty Then
    edtClientSecret.Text := 'Client Secret cadastrado';

  edtSenhaCertificado.Text := fGetBancoConfig(0, FCarteira, 'SENCERT', '');

  CarregaPortador(edtCodPor.Text, edtDesPor);

  CarregaPlanoDeContas(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);

  fraGerarPixBoleto.edtGerarPix.OnChange(fraGerarPixBoleto.edtGerarPix);
end;

procedure TfrmConfigBradescoAPI.CarregaInstrucoes;
begin
  Case StrToIntDef(fGetBancoConfig(0, FCarteira, 'INSTRU1', ''), -1) Of
    00: cmbInstrucao1.ItemIndex := 0;
    05: cmbInstrucao1.ItemIndex := 1;
    06: cmbInstrucao1.ItemIndex := 2;
    07: cmbInstrucao1.ItemIndex := 3;
    08: cmbInstrucao1.ItemIndex := 4;
    09: cmbInstrucao1.ItemIndex := 5;
    10: cmbInstrucao1.ItemIndex := 6;
    11: cmbInstrucao1.ItemIndex := 7;
    12: cmbInstrucao1.ItemIndex := 8;
    13: cmbInstrucao1.ItemIndex := 9;
    14: cmbInstrucao1.ItemIndex := 10;
    15: cmbInstrucao1.ItemIndex := 11;
    18: cmbInstrucao1.ItemIndex := 12;
    Else cmbInstrucao1.ItemIndex := -1;
  End;

  Case StrToIntDef(fGetBancoConfig(0, FCarteira, 'INSTPER', ''), -1) Of
    00: cmbInstruPersonalizada.ItemIndex := 0;
    05: cmbInstruPersonalizada.ItemIndex := 1;
    06: cmbInstruPersonalizada.ItemIndex := 2;
    07: cmbInstruPersonalizada.ItemIndex := 3;
    08: cmbInstruPersonalizada.ItemIndex := 4;
    09: cmbInstruPersonalizada.ItemIndex := 5;
    10: cmbInstruPersonalizada.ItemIndex := 6;
    11: cmbInstruPersonalizada.ItemIndex := 7;
    12: cmbInstruPersonalizada.ItemIndex := 8;
    13: cmbInstruPersonalizada.ItemIndex := 9;
    14: cmbInstruPersonalizada.ItemIndex := 10;
    15: cmbInstruPersonalizada.ItemIndex := 11;
    18: cmbInstruPersonalizada.ItemIndex := 12;
    Else cmbInstruPersonalizada.ItemIndex := -1;
  End;
end;

procedure TfrmConfigBradescoAPI.CarregaEmpresa(AEmpresa: String;
  edtLabel: TEdit);
begin
  edtLabel.Clear;

  If Not AEmpresa.IsEmpty Then
  Begin
    pPesquisaCadEmp(Nil, FEmpresa, AEmpresa);
    edtLabel.Text := FEmpresa.FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmConfigBradescoAPI.CarregaPlanoDeContas(APlanoDeContas: String;
  edtLabel: TEdit);
begin
  edtLabel.Clear;

  If Not APlanoDeContas.IsEmpty Then
  Begin
    pPesquisaCadCta(Nil, FPlanoDeContas, APlanoDeContas);
    edtLabel.Text := FPlanoDeContas.FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmConfigBradescoAPI.CarregaPortador(APortador: String;
  edtLabel: TEdit);
begin
  edtLabel.Clear;

  If Not APortador.IsEmpty Then
  Begin
    pPesquisaCadPor(Nil, FPortador, APortador);
    edtLabel.Text := FPortador.FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmConfigBradescoAPI.edtCodPorKeyPress(Sender: TObject;
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

procedure TfrmConfigBradescoAPI.edtDiasLimitePagamentoEnter(Sender: TObject);
begin
  inherited;
  edtDiasLimitepagamento.Hint := 'Deve ser informado a quantidade de dias ' +
                                 'para o limite de pagamento ' + #13 +
                                 'do boleto após o vencimento.';

  ShowHint(edtDiasLimitePagamento, 'Dias para Limite de Pagamento');
end;

procedure TfrmConfigBradescoAPI.edtDiasLimitePagamentoExit(Sender: TObject);
begin
  inherited;
  HideHint;
end;

procedure TfrmConfigBradescoAPI.edtEmpresaContaKeyPress(Sender: TObject;
  var Key: Char);
  var
    LArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqEmpresa(conEmpSimples, Self, edtEmpresaConta, edtDescricaoEmpresaConta, nil, Key, LArrSel) then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConfigBradescoAPI.edtEmpresaContaMouseEnter(Sender: TObject);
begin
  inherited;
  edtEmpresaConta.Hint := 'Caso a conta não seja da empresa atual, ' + #13 +
                          'é necessário selecionar a empresa dona da conta dessa carteira.';
  ShowHint(edtEmpresaConta,
           'Empresa detentora da conta');
end;

procedure TfrmConfigBradescoAPI.edtEmpresaContaMouseLeave(Sender: TObject);
begin
  inherited;
  HideHint;
end;

procedure TfrmConfigBradescoAPI.edtImportarEmpresasEnter(Sender: TObject);
begin
  inherited;
  edtImportarEmpresas.Hint := 'Quando essa configuração estiver "S", ao importar ' + #13+#10 +
                              'os boletos do Bradesco API, o sistema irá importar ' + #13+#10 +
                              'os boletos de todas as carteiras API de todas as lojas. ' + #13+#10 +
                              'ATENÇÃO: Isso pode gerar lentidão no processo de importação.';

  ShowHint(edtImportarEmpresas, 'Importar boletos de outras carteiras');
end;

procedure TfrmConfigBradescoAPI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FPortador.Close;
  FreeAndNil(FPortador);

  FPlanoDeContas.Close;
  FreeAndNil(FPlanoDeContas);

  FEmpresa.Close;
  FreeAndNil(FEmpresa);

  If Assigned(FJsonCertificado) Then
    FreeAndNil(FJsonCertificado);
end;

procedure TfrmConfigBradescoAPI.FormCreate(Sender: TObject);
begin
  inherited;
  FPortador := fCriaQuery;
  FPlanoDeContas := fCriaQuery;
  FEmpresa := fCriaQuery;

  fraGerarPixBoleto.CarregarChavesPix('237');
  pCarKeyAutBan;
  cxPaginas.Properties.ActivePage := tbsGeral;

  FCfg_PORPGR := fCfgSis('PORPGR', varString);
  FCfg_CTAGCP := fCfgSis('CTAGCP', varString);

  FJsonCertificado := Nil;
end;

procedure TfrmConfigBradescoAPI.FormShow(Sender: TObject);
begin
  inherited;
  FPlanoDeContas := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE');
  FEmpresa := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE');

  CarregaDados;

  pnlAtivo.Enabled := False;
  pnlComplemento.Enabled := False;

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

procedure TfrmConfigBradescoAPI.fraGerarPixBoletoedtGerarPixChange(
  Sender: TObject);
begin
  inherited;
  fraGerarPixBoleto.edtGerarPixChange(Sender);

end;

procedure TfrmConfigBradescoAPI.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  fraPlanoDeContas.MskCodCtaKeyPress(Sender, Key);

end;

function TfrmConfigBradescoAPI.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    LMensagemConfig: String;
Begin
  LMensagemConfig := EmptyStr;
  If blnNaoEditar Then
     LMensagemConfig := #13 + 'Por favor acesse a tela de configuração do banco selecionado ' +
                          #13 + ' e corrija as informações necessárias!';

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender = edtTipoCob Then
    Begin

      If Not MatchStr(edtTipoCob.Text, ['S', 'D']) Then
      Begin
        fMensagem('ATENÇÃO','O campo Tipo de Cobrança deve ser S ou D!'+LMensagemConfig,['&OK']);
        Result := False;

        edtNumAutBco.Enabled := False;
        edtNumAutBco.Clear;
      End;

      If Result Then
      Begin
        edtNumAutBco.Enabled := edtTipoCob.Text = 'D';
        If Not edtNumAutBco.Enabled Then
          edtNumAutBco.Clear;
      End;
    End

    Else If (Sender = cmbInstrucao1) Then
    Begin

      If cmbInstrucao1.ItemIndex = -1 Then
      Begin
        fMensagem('','O Campo de instrução devem ser preenchidos!'+LMensagemConfig,['&OK']);
        Result := False;
      End
      Else If cmbInstrucao1.ItemIndex = 11 Then
        edtDiasProt.Clear;
    End

    Else If Sender = edtEspecieDocumento Then
    Begin
      If Not MatchStr(edtEspecieDocumento.Text, ['S', 'N']) Then
      Begin
        fMensagem('ATENÇÃO','O campo Apresentar Esp. Documento no Boleto? deve ser preenchido com (S/N)!',['&OK']);
        Result := False;
      End;
    End

    Else If Sender = edtProAce Then
    Begin
      If Not MatchStr(edtProAce.Text, ['S', 'N']) Then
      Begin
        fMensagem('ATENÇÃO','O campo Imprime Protocolo de Aceite deve ser preenchido com (S/N)!'+LMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtSolDta) Then
    Begin
      If Not MatchStr(edtSolDta.Text, ['S', 'N']) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Solicita data de pagamento deve ser S ou N!'+LMensagemConfig, ['&OK']);
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

    Else If Sender = fraGerarPixBoleto.edtGerarPix Then
    Begin
      If Not MatchStr(fraGerarPixBoleto.edtGerarPix.Text, ['S', 'N']) Then
      Begin
        fMensagem('ATENÇÃO','O campo Gerar boletos Pix QRCode deve ser preenchido com S ou N!' + LMensagemConfig, ['&OK']);
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
    End

    Else If Sender = edtDiasLimitePagamento Then
    Begin
      If fEmptyStr(edtDiasLimitePagamento.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Dias para Limite de Pagamento deve ser preenchido!'+LMensagemConfig, ['&Ok']);
        Result := False;
      End
      Else If Not fBetween(StrToInt(edtDiasLimitePagamento.Text), 0, 365) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Dias para Limite de Pagamento deve estar entre 0 e 365 dias!'+LMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If Sender = edtImportarEmpresas Then
    Begin
      If Not MatchStr(edtImportarEmpresas.Text, ['S', 'N']) Then
      Begin
        fMensagem('ATENÇÃO','O campo Importar boletos de outras carteiras deve ser preenchido com S ou N!'+LMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtBaixarBoletosArquivo) Then
    Begin
      If Not MatchStr(edtBaixarBoletosArquivo.Text, ['S', 'N']) Then
      Begin
        fMensagem('ATENÇÃO','O campo Baixar boletos gerados por arquivo remessa deve ser preenchido com S ou N!'+LMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtEmpresaConta) Then
    Begin
      edtDescricaoEmpresaConta.Clear;
      if Not fEmptyStr(edtEmpresaConta.Text) then
      Begin
        CarregaEmpresa(edtEmpresaConta.Text, edtDescricaoEmpresaConta);
        If FEmpresa.FieldByName('EMP_NOMEMP').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!'+LMensagemConfig, ['&Ok']);
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
          fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin

      If fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser informado!'+LMensagemConfig, ['&Ok']);
        fraPlanoDeContas.edtDesCta.Clear;
        Result := False;
      End
      Else
      Begin
        CarregaPlanoDeContas(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);
        If FPlanoDeContas.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!'+LMensagemConfig, ['&Ok']);
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
        fMensagem('ATENÇÃO','O Número Conta Corrente deve ser preenchido!'+LMensagemConfig,['&OK']);
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
        fMensagem('ATENÇÃO','O Dígito da Conta Corrente deve ser preenchido!'+LMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtPerMul) Then
    Begin
      If Not fValidaEscala(edtPerMul.Text, 0, 100) Then
      begin
        fMensagem('ATENÇÃO','O campo percentual de multa deve estar entre 0 e 100!'+LMensagemConfig,['&OK']);
        Result := False;
      end;
    End

    Else If Sender = edtExibMsg Then
    Begin
      If Not MatchStr(edtExibMsg.Text, ['S', 'N']) Then
      Begin
        fMensagem('ATENÇÃO','"Exibir Núm. Dupl. Agrupadas" deve ser preenchido com (S/N)!'+LMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If Sender = edtCodCar Then
    Begin
      If fEmptyStr(edtCodCar.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Código da Carteira deve ser preenchido!'+LMensagemConfig,['&OK']);
        Result := False;
      End
      Else If Length(edtCodCar.Text) < 3 Then
      Begin
        fMensagem('ATENÇÃO','O Campo Código da Carteira deve possuir 3 dígitos!'+LMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodEmpBanco) Then
    Begin
      If fEmptyStr(edtCodEmpBanco.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Cedente deve ser preenchido!'+LMensagemConfig,['&OK']);
        Result := False;
      End
      Else If Length(edtCodEmpBanco.Text) <> edtCodEmpBanco.MaxLength Then
      Begin
        fMensagem('ATENÇÃO','O Campo Cedente deve ter 8 caracteres!'+LMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodAgencia) Then
    Begin
      If fEmptyStr(edtCodAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Código da Agência deve ser preenchido!'+LMensagemConfig,['&O K']);
        Result := False;
      End
      Else If Length(edtCodAgencia.Text) <> edtCodAgencia.MaxLength Then
      Begin
        fMensagem('ATENÇÃO','O campo Código da Agência deve ter 4 caracteres!'+LMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigAge) Then
    Begin
      If fEmptyStr(edtDigAge.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Dígito da Agência deve ser preenchido!'+LMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtNumAutBco) Then
    Begin
      If edtTipoCob.Text = 'D' Then
      Begin
        If fEmptyStr(edtNumAutBco.Text) Then
        Begin
          fMensagem('ATENÇÃO','O campo Número de Autorização do Banco deve ser preenchido!'+LMensagemConfig,['&O K']);
          Result := False;
        End
        Else If Length(edtNumAutBco.Text) <> edtNumAutBco.MaxLength Then
        Begin
          fMensagem('ATENÇÃO','O campo Número de Autorização do Banco deve ter 4 caracteres!'+LMensagemConfig,['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtDiasProt) Then
    Begin
      If cmbInstrucao1.ItemIndex in [1,2,3,12] Then
      Begin
        If fEmptyStr(edtDiasProt.Text) Then
        Begin
          fMensagem('ATENÇÃO','O campo Dias para protesto/decurso deve ser preenchido!'+LMensagemConfig,['&O K']);
          Result := False;
        End
        Else If (StrToInt(edtDiasProt.Text) < 5) And (cmbInstrucao1.ItemIndex <> 12) Then
        Begin
          fMensagem('ATENÇÃO','A quantidade de dias informada deve ser de no mínimo 5 dias!'+LMensagemConfig,['&O K']);
          Result := False;
        End;
      End;
    End

    Else If Sender = edtUsaSac Then
    Begin
      If Not MatchStr(edtUsaSac.Text, ['S', 'N']) Then
      Begin
        fMensagem('ATENÇÃO','O campo Enviar Sacador/Avalista deve ser preenchido com (S/N)!',['&OK']);
        Result := False;
      End;

      grpBeneficiario.Enabled := edtUsaSac.Text = 'S';
    End

    Else If Sender = edtDesBen Then
    Begin
      If (fEmptyStr(edtDesBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Beneficiário deve ser preenchido!' ,['&OK']);
        Result := False;
      End
    End

    Else If Sender = edtEndBen Then
    Begin
      If (fEmptyStr(edtEndBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Endereço do beneficiário deve ser preenchido!' ,['&OK']);
        Result := False;
      End
    End

    Else If Sender = edtBaiBen Then
    Begin
      If (fEmptyStr(edtBaiBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Bairro do beneficiário deve ser preenchido!' ,['&OK']);
        Result := False;
      End
    End

    Else If Sender = edtCidBen Then
    Begin
      If (fEmptyStr(edtCidBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Cidade do beneficiário deve ser preenchido!' ,['&OK']);
        Result := False;
      End
    End

    Else If Sender = edtEstBen Then
    Begin
      If (fEmptyStr(edtEstBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Estado do beneficiário deve ser preenchido!' ,['&OK']);
        Result := False;
      End
    End

    Else If Sender = edtCepBen Then
    Begin
      If (edtUsaSac.Text = 'S') Then
      Begin
        If (fEmptyStr(fRetSomenteNumeros(edtCepBen.Text))) Then
        Begin
          fMensagem('ATENÇÃO','O campo CEP do beneficiário deve ser preenchido!' ,['&OK']);
          Result := False;
        End
        Else If Length(fRetSomenteNumeros(edtCepBen.Text)) < 8 Then
        Begin
          fMensagem('ATENÇÃO','O campo CEP do beneficiário deve ser preenchido com 8 números!' ,['&OK']);
          Result := False;
        End;
      End;
    End

    Else If Sender = edtCgcBen Then
    Begin
      If (edtUsaSac.Text = 'S') Then
      Begin
        If (fEmptyStr(fRetSomenteNumeros(edtCgcBen.Text))) Then
        Begin
          fMensagem('ATENÇÃO','O campo CNPJ do beneficiário deve ser preenchido!' ,['&OK']);
          Result := False;
        End
        Else If (Length(fRetSomenteNumeros(edtCgcBen.Text)) < 14) Or (Not fValidaCnpjCpf(edtCgcBen.Text)) Then
        Begin
          fMensagem('ATENÇÃO','O campo CNPJ do beneficiário deve conter um número válido!' ,['&OK']);
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

procedure TfrmConfigBradescoAPI.GravaLogCarteira(ACfgAnt: TStringList);
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
    pGravaLogAtb('237',
                 'BRADESCO [Online]',
                 FCarteira + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado,
                 VS_StrCodEmp,
                 RetStrCfg(ACfgAnt),
                 RetStrCfg(LCfgAtu),
                 LCampoAlterado);

  FreeAndNil(LCfgAtu);
end;

procedure TfrmConfigBradescoAPI.HideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmConfigBradescoAPI.LimpaCampos;
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

  If Assigned(FJsonCertificado) Then
    FreeAndNil(FJsonCertificado);

  lblValidadeCertificado.Caption := EmptyStr;
  fraPlanoDeContas.edtDesCta.Clear;
  fraPlanoDeContas.MskCodCta.Clear;

  fraGerarPixBoleto.edtGerarPix.Clear;
  fraGerarPixBoleto.cmbChavePix.Clear;
end;

function TfrmConfigBradescoAPI.PossuiTodosOsDadosDeAutorizacao: Boolean;
begin
  Result := Not fGetBancoConfig(0, FCarteira, 'CLIENT_ID', '').Trim.IsEmpty;

  If Result Then
    Result := Not fGetBancoConfig(0, FCarteira, 'CLIENT_SECRET', '').Trim.IsEmpty;

  If Result Then
    Result := Not fGetBancoConfig(0, FCarteira, 'AUTHPFX', '').Trim.IsEmpty;
end;

function TfrmConfigBradescoAPI.RetornaAbaDoComponete(
  Sender: TWinControl): TCxTabSheet;
begin
  While Not Sender.ClassName.Equals('TcxTabSheet') Do
    Sender := Sender.Parent;

  Result := TcxTabSheet(Sender);
end;

function TfrmConfigBradescoAPI.RetornaDataJsonFormatada(
  ADataJson: String): String;
begin
  Result := ADataJson;

  If Result.Length < 10 Then
    Exit;

  Result := Copy(Result, 9, 2) + '/' +
            Copy(Result, 6, 2) + '/' +
            Copy(Result, 1, 4);
end;

function TfrmConfigBradescoAPI.RetStrCfg(AConfig: TStringList): String;
  Var
    LContador: Integer;
begin
  Result := EmptyStr;

  For LContador := 0 To AConfig.Count - 1 Do
    Result := Result + AConfig.Strings[LContador] + #13+#10;
end;

procedure TfrmConfigBradescoAPI.ShowHint(edtEdit: TEditFocus; ATitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,
                         edtEdit.ClientOrigin.Y,
                         ATitulo,
                         edtEdit.Hint);
end;

procedure TfrmConfigBradescoAPI.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  CarregaDados;
  cxPaginas.ActivePage := tbsGeral;
end;

procedure TfrmConfigBradescoAPI.tabCarteiraChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  if btnCancelar.Visible then
  begin
    btnCancelar.Click;
    if btnCancelar.Visible then
      AllowChange := False;
  end;
end;

end.
