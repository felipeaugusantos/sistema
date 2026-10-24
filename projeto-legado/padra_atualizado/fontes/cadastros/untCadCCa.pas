unit untCadCCa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Uni, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, DBMemoFocus, DBComboBoxFocus, Data.DB, untFuncoesSimples,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxGroupBox, Vcl.Grids, Vcl.DBGrids, DBGridCitel, ComboBoxFocus,
  UniClientDataset, EditFocus, cxButtons, QColorLabel, cxProgressBar,
  System.StrUtils,untContasBancariasAutenticacaoFrame,
  untTAutCCA, dxBarBuiltInMenu, cxPC;

type
  TfrmCadCCa = class(TfrmPaiCad)
    dtsCadCCa: TDataSource;
    btnAjuda: TBitBtnLocked;
    cxPaginas: TcxPageControl;
    cxtabDadosGerais: TcxTabSheet;
    cxTabExtratoBancario: TcxTabSheet;
    pnlExtratoBancario: TPanel;
    pnlAutenticacao: TPanel;
    pnlUsaPixScope: TPanel;
    lblUsaPixScope: TLabel;
    lblUsaPixScopeSN: TColorLabel;
    dbeUsaPixScope: TDBEditFocus;
    btnAssocChavePixScope: TBitBtnLocked;
    fraContasBancariasAutenticacao: TfraContasBancariasAutenticacaoFrame;
    pnlDadosGerais: TPanel;
    Label2: TLabel;
    Label4: TLabel;
    Label163: TLabel;
    Label7: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblFornecedorFiscal: TLabel;
    lblPortadorVinculado: TLabel;
    dbeCodEmp: TDBEditFocus;
    dbedtCodCta: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    dbeCodBco: TDBEditFocus;
    edtNomBan: TEditFocus;
    edtNomEmp: TEditFocus;
    dbedtDigCta: TDBEditFocus;
    dbedtAgenci: TDBEditFocus;
    dbeDigAge: TDBEditFocus;
    dbCmbTipoCC: TDBComboBoxFocus;
    dbMemObs: TDBMemoFocus;
    dbeChaveOFX: TDBEditFocus;
    pnlChavesPix: TPanel;
    pgcDadosPix: TPageControl;
    tabChavesPix: TTabSheet;
    grpPixDaConta: TGroupBox;
    pnlCamposPix: TPanel;
    Label88: TLabel;
    Label89: TLabel;
    cmbTipoDoPix: TComboBoxFocus;
    edtCPFCNPJPix: TEditFocus;
    edtChavePix: TEditFocus;
    chkChaveAtiva: TCheckBox;
    pnlAcoesPix: TPanel;
    btnIncluirPix: TBitBtnLocked;
    btnAlterarPix: TBitBtnLocked;
    btnExcluirPix: TBitBtnLocked;
    btnCancelarPix: TBitBtnLocked;
    btnGravarPix: TBitBtnLocked;
    dbgChavesPix: TDBGridCitel;
    pnlMensagem: TPanel;
    lblBancoPixImplementado: TLabel;
    tabAutorizacaoPix: TTabSheet;
    lblAmbientePixTexto: TLabel;
    lblAmbientePix: TLabel;
    pnlChaveAppDev: TPanel;
    lblChaveAppDev: TLabel;
    lblVersaoAPI: TLabel;
    dbeChaveAppDev: TDBEditFocus;
    cmbVersaoAPI: TComboBoxFocus;
    pnlChavesClientPix: TPanel;
    lblClientID: TLabel;
    lblClientSecret: TLabel;
    dbeClientID: TDBEditFocus;
    dbeClientSecret: TDBEditFocus;
    pnlCertificados: TPanel;
    lblArquivoCRT: TLabel;
    lblArquivoKey: TLabel;
    edtArquivoCRT: TEditFocus;
    edtArquivoKey: TEditFocus;
    btnArquivoKey: TcxButton;
    btnArquivoCRT: TcxButton;
    pnlChaveBasic: TPanel;
    lblChaveBasic: TLabel;
    btnGerarChaveBasic: TBitBtnLocked;
    dbeChaveBasic: TDBMemoFocus;
    pnlCertificadoPFX: TPanel;
    Label8: TLabel;
    edtArquivoPFX: TEditFocus;
    btnArquivoPFX: TcxButton;
    pnlSenhaCertificado: TPanel;
    lblSenhaCertificado: TLabel;
    lblValidadeCertificado: TLabel;
    dbeSenhaCertificado: TDBEditFocus;
    dbeValidadeCertificado: TDBEditFocus;
    btnValidarDadosPix: TBitBtnLocked;
    btnImportarItau: TBitBtnLocked;
    pnlSantanderParceiro: TPanel;
    lblParceiroCitel: TLabel;
    lblParceiroCitelSN: TColorLabel;
    dbeParceiroCitel: TDBEditFocus;
    pnlUtilizaShipay: TPanel;
    lblUtilizaShipay: TLabel;
    lblUtilizaShipaySN: TColorLabel;
    dbeUsaShp: TDBEditFocus;
    dbeCodigoFornecedorFiscal: TDBEditFocus;
    edtNomeFornecedorFiscal: TEditFocus;
    pnlEntraSped: TPanel;
    lblEntraSped: TLabel;
    lblEntraSpedSN: TColorLabel;
    dbeEntraSped: TDBEditFocus;
    pnlContaGravame: TPanel;
    lblContaGravame: TLabel;
    cblContaGravame: TColorLabel;
    dbeCcaGra: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure dbeCodBcoKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbeCodBcoExit(Sender: TObject);
    procedure dbedtAgenciExit(Sender: TObject);
    procedure cmbTipoDoPixChange(Sender: TObject);
    procedure edtCPFCNPJPixEnter(Sender: TObject);
    procedure edtCPFCNPJPixExit(Sender: TObject);
    procedure btnIncluirPixClick(Sender: TObject);
    procedure btnAlterarPixClick(Sender: TObject);
    procedure btnExcluirPixClick(Sender: TObject);
    procedure btnGravarPixClick(Sender: TObject);
    procedure btnCancelarPixClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgChavesPixDblClick(Sender: TObject);
    procedure dbgChavesPixKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAjudaClick(Sender: TObject);
    procedure btnArquivoKeyClick(Sender: TObject);
    procedure btnArquivoCRTClick(Sender: TObject);
    procedure btnGerarChaveBasicClick(Sender: TObject);
    procedure btnArquivoPFXClick(Sender: TObject);
    procedure dbgChavesPixDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnValidarDadosPixClick(Sender: TObject);
    procedure dbeCodigoFornecedorFiscalKeyPress(Sender: TObject; var Key: Char);
    procedure dbeEntraSpedChange(Sender: TObject);
    procedure btnImportarItauClick(Sender: TObject);
    procedure cmbVersaoAPIChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAssocChavePixScopeClick(Sender: TObject);
    procedure dbeUsaPixScopeExit(Sender: TObject);
  private
    { Private declarations }
    qryCadCCa: TUniQuery;
    qryConEmp : TUniQuery;

    FDatasetCcaPix,
    FDatasetCcaPixClone: TUniClientDataSet;
    FAutenticacaoExtrato: TAutCCA;

    FWidthCampoChavePix: Integer;
    FLeftCampoChavePix: Integer;

    FTipoDocumentoAnterior: String;
    FUsaPixScope: Boolean;

    procedure qryCadCCaAfterScroll(DataSet: TDataSet);
    procedure pCarregaBanco;
    procedure pCarregaEmpresa;
    procedure CarregaFornecedor;

    procedure pLimpaCampos;
    procedure pHabilitaDesabilitaCamposChaves(blnOpcao: Boolean = True);
    function ContaJaCadastrada(ABanco, AEmpresa, AAgencia, ADigitoAg, AConta, ADigitoC, ATipoConta: String; var AContaEncontrada: String): Boolean;
    function fChaveOFXJaVinculada(AChaveOFX, ABanco : String; var AContaConrrente : String) : Boolean;

    procedure HabilitarBotoesPix(AEmEdicao: Boolean);
    function RetornaTipoChavePix(AIndiceComboBox: Integer): String;

    function ValidaCamposPix: Boolean;
    function ValidaPixUtilizado: Boolean;

    procedure CarregaDadosPix;
    procedure GravarDadosPix;
    procedure LimpaDadosPix(ALimpaTodos: Boolean = True);
    procedure FDatasetCcaPixOnAfterScroll(DataSet: TDataSet);
    procedure ImportaCertificadoParceiroCitel;

    procedure MostraCamposPixBanco(ABanco: String);

    function ValidacoesCamposChavesPix: Boolean;
    procedure GravaDadosDeAutenticacaoExtrato;
    procedure CarregaDadosAutenticacaoExtrato;

    procedure HabilitaCamposChavesPix(AHabilitar: Boolean);

    function RetornaValidadeCertificado(pgbStatus: TcxProgressBar): Boolean;
    function RetornaDadosCertificadoPFX(pgbStatus: TcxProgressBar): Boolean;

    procedure ExibeCamposConfiguracaoPix(AExibir: Boolean);

    function GerarCertificadosCRTeKey(prgStatus: TcxProgressBar): Boolean;
    function ValidaCertificadosGeradosPeloPfx(AArquivoKey,
                                              AArquivoCRT: String): Boolean;

    procedure RemoveBagAtributes(AArquivo,
                                 ATextoInicio: String);

    function RetornaPastaOpenSSL(AArquivoPfx: Boolean): String;

    procedure ValidaDadosDeAutenticacaoPix;
    procedure ImportaDadosDeAutenticacaoPix;
    function ValidacoesImportarDadosDeAutenticacaoPix: Boolean;

    procedure HabilitarFornecedorFiscal;

    procedure ExibePortadorVinculado;
    function RetornaPortadorVinculadoConaBancaria(AAutoIncremCadCCA: String): String;
    procedure pAjustaAssocChavePixScope;
    procedure pAtualizaCamposPixScope;
    function fChaveAleatorioAtivaPixScope(): Boolean;
    function fConsultaDadosPixScope(pgbProgresso: TcxProgressBar): Boolean;
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

{$R *.dfm}

uses untConsultas , untTypesSistema, untPesqAux, untConstantes, DateUtils,
     untRelatoriosAjudaPixDtm, untTFuncoesAuxiliaresPix, untTPixDao, untTFuncoesPixAutcom,
     untGravando, untTiposPix, untTefCitelUtil, untFuncMacro;


{ TfrmCadCCa }

procedure TfrmCadCCa.btnAjudaClick(Sender: TObject);
  Var
    LBancosPix: String;
 begin
   inherited;

  LBancosPix := VS_BancosPix;
  If Not fEmptyStr(dbeCodBco.Text) Then
  Begin
    If Pos(dbeCodBco.Text, VS_BancosPix) > 0 Then
    Begin
      If fMensagem('CONFIRMAÇÃO', 'Deseja exibir as informações de ajuda apenas do banco selecionado?', ['&Sim', '&Não']) = 1 Then
        LBancosPix := dbeCodBco.Text + '_';
    End;
  End;

  Try
    pCriarFormularios(TdtmRelatoriosAjudaPixDtm, dtmRelatoriosAjudaPixDtm);
    TfrxBand(dtmRelatoriosAjudaPixDtm.frxChavesAutorizacao.FindObject('rlbBancoDoBrasil')).Visible := Pos('001_', LBancosPix) > 0;
    TfrxBand(dtmRelatoriosAjudaPixDtm.frxChavesAutorizacao.FindObject('rlbItau')).Visible := Pos('341_', LBancosPix) > 0;
    TfrxBand(dtmRelatoriosAjudaPixDtm.frxChavesAutorizacao.FindObject('rlbBradesco')).Visible := Pos('237_', LBancosPix) > 0;
    TfrxBand(dtmRelatoriosAjudaPixDtm.frxChavesAutorizacao.FindObject('rlbSicoob')).Visible := Pos('756_', LBancosPix) > 0;
    TfrxBand(dtmRelatoriosAjudaPixDtm.frxChavesAutorizacao.FindObject('rlbSicredi')).Visible := Pos('748_', LBancosPix) > 0;
    TfrxBand(dtmRelatoriosAjudaPixDtm.frxChavesAutorizacao.FindObject('rlbSantander')).Visible := Pos('033_', LBancosPix) > 0;
    TfrxBand(dtmRelatoriosAjudaPixDtm.frxChavesAutorizacao.FindObject('rlbSafra')).Visible := Pos('422_', LBancosPix) > 0;
    pPreviewReport(Self.Name, Self.Caption + ' (Help)', dtmRelatoriosAjudaPixDtm.frxChavesAutorizacao);
  Finally
    FreeAndNil(dtmRelatoriosAjudaPixDtm);
  End;
end;

procedure TfrmCadCCa.btnAlterarClick(Sender: TObject);
  Var
    LHabilitaCamposPix: Boolean;
begin
  inherited;
  pHabilitaDesabilitaCamposChaves(False);

  LHabilitaCamposPix := (dbeUsaShp.Text = 'S') or (dbeUsaPixScope.Text = 'S');
  If Not LHabilitaCamposPix Then
    LHabilitaCamposPix := Pos(dbeCodBco.Text, untFuncoesSimples.VS_BancosPix) > 0;

  HabilitaCamposChavesPix(LHabilitaCamposPix);
  HabilitarFornecedorFiscal;
  pnlExtratoBancario.Enabled := True;
end;

procedure TfrmCadCCa.btnAlterarPixClick(Sender: TObject);
begin
  inherited;
  If FDatasetCcaPix.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'Você deve selecionar um registro para utilizar essa opção.', ['&Ok']);
    Exit;
  End;

  FDatasetCcaPixClone := fCriaClientDatSet(FDatasetCcaPix);

  FDatasetCcaPix.Edit;
  If Not FDatasetCcaPix.FieldByName('AUTOINCREM').AsString.IsEmpty Then
  Begin
    FDatasetCcaPix.FieldByName('TIPOACAO').AsString := '2';

    FDatasetCcaPixClone.Filter := 'AUTOINCREM<>''' + FDatasetCcaPix.FieldByName('AUTOINCREM').AsString + '''';
    FDatasetCcaPixClone.Filtered := True;
  End;

  inherited;
  HabilitarBotoesPix(True);
  pSetFocus(edtChavePix);
end;

procedure TfrmCadCCa.btnArquivoCRTClick(Sender: TObject);
  Var
    LCaixaDialogo: TOpenDialog;

    LGravando: TfrmGravando;
begin
  LCaixaDialogo := TOpenDialog.Create(nil);
  try
    LCaixaDialogo.Title := 'Selecione o arquivo CRT';
    LCaixaDialogo.Filter := 'Certificado CRT|*.crt';

    If Concat(dbeCodBco.Text, IfEmptyStr(dbeUsaShp.Text, 'N')) = '748N' Then
    Begin
      LCaixaDialogo.Title := 'Selecione o arquivo CER';
      LCaixaDialogo.Filter := 'Certificado CER|*.cer';
    End;

    LCaixaDialogo.Options := [ofPathMustExist];

    If LCaixaDialogo.Execute Then
    Begin
      edtArquivoCRT.Text := LCaixaDialogo.FileName;

      pCriarFormularios(TfrmGravando, LGravando);
      LGravando.lblGravando.Caption := 'Aguarde... Selecionando certificado.';
      LGravando.fExecutarAcao := RetornaValidadeCertificado;
      LGravando.ShowModal;

      FreeAndNil(LGravando);
    End;
  finally
    LCaixaDialogo.Free;
  end;
end;

procedure TfrmCadCCa.btnArquivoKeyClick(Sender: TObject);
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

procedure TfrmCadCCa.btnArquivoPFXClick(Sender: TObject);
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

procedure TfrmCadCCa.btnAssocChavePixScopeClick(Sender: TObject);
var
  LGravando: TfrmGravando;
begin
  pCriarFormularios(TfrmGravando, LGravando);
  try
    LGravando.lblGravando.Caption := 'Aguarde... Consultando dados do Pix Scope.';
    LGravando.fExecutarAcao := fConsultaDadosPixScope;
    LGravando.ShowModal;
  finally
    FreeAndNil(LGravando);
  end;
end;

procedure TfrmCadCCa.btnCancelaClick(Sender: TObject);
begin
  pHabilitaDesabilitaCamposChaves(True);
  inherited;
  pCarregaBanco;
  pCarregaEmpresa;
  CarregaFornecedor;
  LimpaDadosPix;
  CarregaDadosPix;
  CarregaDadosAutenticacaoExtrato;

  HabilitaCamposChavesPix(False);
  HabilitarFornecedorFiscal;
  pnlExtratoBancario.Enabled := False;
  cxPaginas.ActivePage :=  cxtabDadosGerais;
  ExibePortadorVinculado;
end;

procedure TfrmCadCCa.btnCancelarPixClick(Sender: TObject);
begin
  FDatasetCcaPix.Cancel;

  inherited;
  HabilitarBotoesPix(False);

  FreeAndNil(FDatasetCcaPixClone);

  FDatasetCcaPixOnAfterScroll(FDatasetCcaPix);

  If FDatasetCcaPix.IsEmpty Then
    LimpaDadosPix(False);

  pAjustaAssocChavePixScope;
end;

procedure TfrmCadCCa.btnExcluirClick(Sender: TObject);
begin
  If Not FDatasetCcaPix.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário excluir as Chaves Pix da Conta antes de continuar.', ['&Ok']);
    Exit;
  End;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadCaixas.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
  Begin
    FAutenticacaoExtrato.Excluir;
    fCommit;
  End
  Else
    fRollBack;

  pCarregaBanco;
  pCarregaEmpresa;
  CarregaFornecedor;
  CarregaDadosPix;
  CarregaDadosAutenticacaoExtrato;
  HabilitarFornecedorFiscal;
  pnlExtratoBancario.Enabled := False;
  cxPaginas.ActivePage :=  cxtabDadosGerais;
  ExibePortadorVinculado;
end;

procedure TfrmCadCCa.btnExcluirPixClick(Sender: TObject);
begin
  If FDatasetCcaPix.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'Deve selecionar um registro para utilizar essa opção.', ['&Ok']);
    Exit;
  End;

  If ValidaPixUtilizado Then
  Begin
    fMensagem('ATENÇÃO', 'Essa chave não pode ser excluída pois já está sendo utilizada.', ['&Ok']);
    Exit;
  End;

  If (fMensagem('CONFIRMAÇÃO!', 'Deseja excluir a chave Pix selecionada?', ['&Sim', '&Não'], 2) = 2) Then
    Exit;

  If Not FDatasetCcaPix.FieldByName('AUTOINCREM').AsString.IsEmpty Then
  Begin
    FDatasetCcaPix.Edit;
    FDatasetCcaPix.FieldByName('TIPOACAO').AsString := '3';
    FDatasetCcaPix.Post;
  End
  Else
    FDatasetCcaPix.Delete;

  FDatasetCcaPixOnAfterScroll(FDatasetCcaPix);

  HabilitarBotoesPix(False);
  inherited;
  pAjustaAssocChavePixScope;
end;

procedure TfrmCadCCa.btnGerarChaveBasicClick(Sender: TObject);
begin
  inherited;
  If fEmptyStr(dbeClientID.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'O campo Client ID deve ser preenchido.', ['&Ok']);
    pSetFocus(dbeClientID);

    Exit;
  End;

  If fEmptyStr(dbeClientSecret.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'O campo Client Secret deve ser preenchido.', ['&Ok']);
    pSetFocus(dbeClientSecret);

    Exit;
  End;

  If Not fEmptyStr(dbeChaveBasic.Text) Then
  Begin
    If fMensagem('ATENÇÃO', 'Já existe dados no campo Autorização Basic. Se utilizar essa função, irá sobrepor seu conteúdo.' + #13 +
                            'Deseja realmente continuar?', ['&Sim', '&Não']) = 2 Then
      Exit;
  End;

  dbeChaveBasic.Text := TFuncoesPix.RetornaChaveBasic(dbeClientID.Text,
                                                      dbeClientSecret.Text);
end;

procedure TfrmCadCCa.btnGravarClick(Sender: TObject);
  Var
    LGravando: TfrmGravando;
begin
  If Not ValidacoesCamposChavesPix Then
    Exit;

  if not fChaveAleatorioAtivaPixScope then
  begin
    fMensagem('ATENÇÃO',
              format('Quando o campo "%s" igual a "Sim" a chave aleatória deve ser cadastrada e ser ativa!',
              [lblUsaPixScope.Caption]),
              ['&Ok']);
    exit;
  end;

  pHabilitaDesabilitaCamposChaves(True);

  if fEmptyStr(dbeChaveOFX.Text) then
    qryTabela.FieldByName('CCA_CHVOFX').Clear;

  if fEmptyStr(dbeCodigoFornecedorFiscal.Text) Or (dbeEntraSped.Text <> 'S') then
    qryTabela.FieldByName('CCA_FORFIS').Value := Null;

  qryTabela.FieldByName('CCA_VERAPI').Clear;
  If cmbVersaoAPI.Visible Then
  Begin
    qryTabela.FieldByName('CCA_VERAPI').AsString := cmbVersaoAPI.Text;
    If qryTabela.FieldByName('CCA_VERAPI').AsString.IsEmpty Then
      qryTabela.FieldByName('CCA_VERAPI').Clear;
  End;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    If Not MatchStr(edtArquivoCRT.Text, ['', 'certificado cadastrado']) Then
    Begin
      qryTabela.FieldByName('CCA_ARQCRT').AsString := RetornaArquivoBase64(edtArquivoCRT.Text);

      If dbeCodBco.Text = '748' Then
        qryTabela.FieldByName('CCA_SICPFX').AsString := 'N';
    End;

    If Not MatchStr(edtArquivoKey.Text, ['', 'certificado cadastrado']) Then
      qryTabela.FieldByName('CCA_ARQKEY').AsString := RetornaArquivoBase64(edtArquivoKey.Text);

    If Not MatchStr(edtArquivoPFX.Text, ['', 'certificado cadastrado']) Then
    Begin
      qryTabela.FieldByName('CCA_ARQPFX').AsString := RetornaArquivoBase64(edtArquivoPFX.Text);

      pCriarFormularios(TfrmGravando, LGravando);
      LGravando.lblGravando.Caption := 'Aguarde... Convertendo certificado.';
      LGravando.fExecutarAcao := GerarCertificadosCRTeKey;
      LGravando.ShowModal;
      FreeAndNil(LGravando);
    End;

    inherited;

    If blnGravou Then
    Begin
      GravarDadosPix;
      GravaDadosDeAutenticacaoExtrato;
      fCommit;
    End
    Else
      fRollBack;
  Except
    On E: ExceptionAutcom Do
    Begin
      fRollBack;
      fMensagem('ATENÇÃO', E.Message, ['&Ok']);
      Exit;
    End;

    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro('Ocorreu um erro ao gravar a conta bancária.' + #13 +
                     'Erro gerado: ' + E.Message, '[TfrmCadCCa.btnGravarClick]');
    End;
  End;

  CarregaDadosPix;
  CarregaDadosAutenticacaoExtrato;
  CarregaFornecedor;
  HabilitaCamposChavesPix(False);
  HabilitarFornecedorFiscal;
  pnlExtratoBancario.Enabled := False;
end;

procedure TfrmCadCCa.btnGravarPixClick(Sender: TObject);
begin
  edtChavePix.text := TrimLeft(TrimRight(edtChavePix.Text));

  If Not ValidaCamposPIX Then
    Exit;

  FDatasetCcaPix.FieldByName('PIX_TIPCHV').AsString := RetornaTipoChavePix(cmbTipoDoPix.ItemIndex);
  FDatasetCcaPix.FieldByName('PIX_CHAVE_').AsString := edtChavePix.Text;
  FDatasetCcaPix.FieldByName('PIX_ATIVA_').AsString := IIF(chkChaveAtiva.Checked, 'S', 'N');
  FDatasetCcaPix.FieldByName('ATIVA').AsString := IIF(chkChaveAtiva.Checked, 'Sim', 'Não');

  FDatasetCcaPix.Post;

  inherited;
  HabilitarBotoesPix(False);

  FreeAndNil(FDatasetCcaPixClone);
end;

procedure TfrmCadCCa.btnImportarItauClick(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(ImportaDadosDeAutenticacaoPix, 'Aguarde... Importando dados de autenticação Pix.', '');
end;

procedure TfrmCadCCa.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaDesabilitaCamposChaves(True);
  pLimpaCampos;
  FDatasetCcaPix.EmptyDataSet;
  pSetFocus(dbeCodBco);

  HabilitaCamposChavesPix(True);
  pnlAcoesPix.Enabled := False;
  pnlCamposPix.Enabled := False;

  lblBancoPixImplementado.Caption := '';
  btnGerarChaveBasic.Enabled := True;

  dbeUsaShp.Field.AsString := 'N';
  dbeUsaPixScope.Field.AsString := 'N';
  dbeCcaGra.Field.AsString := 'N';
  dbeEntraSped.Field.AsString := 'N';

  cmbVersaoAPI.ItemIndex := 1;

  HabilitarFornecedorFiscal;

  pnlExtratoBancario.Enabled := True;
  cxPaginas.ActivePage :=  cxtabDadosGerais;
  fraContasBancariasAutenticacao.CarregaCampos(dbeCodBco.Text);
  cxTabExtratoBancario.TabVisible := False;
  FAutenticacaoExtrato.Limpar;

  ExibePortadorVinculado;
end;

procedure TfrmCadCCa.btnIncluirPixClick(Sender: TObject);
begin
  inherited;
  HabilitarBotoesPix(True);

  FDatasetCcaPixClone := fCriaClientDatSet(FDatasetCcaPix);

  FDatasetCcaPix.Last;
  FDatasetCcaPix.Append;
  FDatasetCcaPix.FieldByName('TIPOACAO').AsString := '1';
  FDatasetCcaPix.FieldByName('PIX_SEQCCA').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;

  cmbTipoDoPix.ItemIndex := -1;
  edtCPFCNPJPix.Visible := False;
  edtChavePix.Clear;
  chkChaveAtiva.Checked := True;

  cmbTipoDoPix.Enabled := True;
  if dbeUsaPixScope.Field.AsString = 'S' then
  begin
    cmbTipoDoPix.ItemIndex := 3;
    cmbTipoDoPix.Enabled := False;
    pAjustaAssocChavePixScope;
    pSetFocus(btnAssocChavePixScope);
  end;

  pSetFocus(cmbTipoDoPix);
end;

procedure TfrmCadCCa.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    chrKey: Char;
begin
  chrKey := '?';
  if fPesqCCa(Self,
              qryTabela,
              chrKey,
              arrSel)  then
  Begin
    pCarregaBanco;
    pCarregaEmpresa;
    CarregaFornecedor;
    CarregaDadosPix;
    CarregaDadosAutenticacaoExtrato;
    If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
      pSetFocus(btnAlterar);

    HabilitaCamposChavesPix(False);

    HabilitarFornecedorFiscal;
    pnlExtratoBancario.Enabled := False;
    ExibePortadorVinculado;
  End;
end;

procedure TfrmCadCCa.CarregaDadosAutenticacaoExtrato;
begin

  If Not cxTabExtratoBancario.TabVisible Then
    Exit;

  FAutenticacaoExtrato.Limpar;
  FAutenticacaoExtrato.BuscarPorID(fCampoTabela('CCA_AUTCCA', 'CADCCA', ['AUTOINCREM'], [qryTabela.FieldByName('AUTOINCREM').AsString], True));

  fraContasBancariasAutenticacao.edtChaveAppDev.Clear;
  If Not FAutenticacaoExtrato.AppKey.IsEmpty Then
    fraContasBancariasAutenticacao.edtChaveAppDev.Text := 'chave App cadastrada';

  fraContasBancariasAutenticacao.edtChaveBasic.Clear;
  If Not FAutenticacaoExtrato.AutenticacaoBasic.IsEmpty Then
    fraContasBancariasAutenticacao.edtChaveBasic.Text := 'autorização Basic cadastrada';

  fraContasBancariasAutenticacao.edtArquivoPFX.Clear;
  If Not FAutenticacaoExtrato.ArquivoPfx.IsEmpty Then
    fraContasBancariasAutenticacao.edtArquivoPFX.Text := 'certificado cadastrado';

  fraContasBancariasAutenticacao.edtArquivoCRT.Clear;
  If Not FAutenticacaoExtrato.ArquivoCRT.IsEmpty Then
    fraContasBancariasAutenticacao.edtArquivoCRT.Text := 'certificado cadastrado';

  fraContasBancariasAutenticacao.edtArquivoKEY.Clear;
  If Not FAutenticacaoExtrato.ArquivoKEY.IsEmpty Then
    fraContasBancariasAutenticacao.edtArquivoKEY.Text := 'arquivo key cadastrado';

  fraContasBancariasAutenticacao.edtClientId.Text := FAutenticacaoExtrato.ClientID;
  fraContasBancariasAutenticacao.edtClientSecret.Text := FAutenticacaoExtrato.ClientSecret;
  fraContasBancariasAutenticacao.edtSenhaCertificado.Text := FAutenticacaoExtrato.SenhaCertificado;

  fraContasBancariasAutenticacao.edtValidadeCertificado.Clear;
  if FAutenticacaoExtrato.DataValidadeCertificado > 0 then
    fraContasBancariasAutenticacao.edtValidadeCertificado.Text :=
      FormatDateTime('dd/MM/yyyy', FAutenticacaoExtrato.DataValidadeCertificado);


  fraContasBancariasAutenticacao.lblAmbienteAPI.Caption := 'PRODUÇÃO';
  fraContasBancariasAutenticacao.lblAmbienteAPI.Font.Color := clBlue;

end;

procedure TfrmCadCCa.btnValidarDadosPixClick(Sender: TObject);
begin
  inherited;
  If Not ValidacoesCamposChavesPix Then
    Exit;

  TfrmGravando.fExecutarModal(ValidaDadosDeAutenticacaoPix, 'Aguarde... Validando dados de autenticação Pix.', '');
end;

procedure TfrmCadCCa.CarregaDadosPix;
  Var
    LDataset: TUniQuery;
begin
  Try
    LDataset := fCriarQuery('SELECT *, "0"  AS TIPOACAO, ' +
                            'IF(PIX_ATIVA_="S", "Sim", "Não") AS ATIVA ' +
                            'FROM CCAPIX WHERE PIX_SEQCCA="' + qryTabela.FieldByName('AUTOINCREM').AsString + '"');
    LDataset.Open;

    FDatasetCcaPix := fCriaClientDatSet(LDataset);
    FDatasetCcaPix.Open;
    FDatasetCcaPix.Filter := 'TIPOACAO<>''3'' ';
    FDatasetCcaPix.Filtered := True;

    FDatasetCcaPix.AfterScroll := FDatasetCcaPixOnAfterScroll;
    FDatasetCcaPix.First;

    dbgChavesPix.DataSource := fCriaDataSource(FDatasetCcaPix);

    pnlAcoesPix.Enabled := False;

    HabilitarBotoesPix(False);

    edtArquivoCRT.Clear;
    If Not qryTabela.FieldByName('CCA_ARQCRT').AsString.IsEmpty Then
      edtArquivoCRT.Text := 'certificado cadastrado';

    edtArquivoKey.Clear;
    If Not qryTabela.FieldByName('CCA_ARQKEY').AsString.IsEmpty Then
      edtArquivoKey.Text := 'certificado cadastrado';

    edtArquivoPfx.Clear;
    If Not qryTabela.FieldByName('CCA_ARQPFX').AsString.IsEmpty Then
      edtArquivoPfx.Text := 'certificado cadastrado';

    cmbVersaoAPI.ItemIndex := cmbVersaoAPI.Items.IndexOf(qryTabela.FieldByName('CCA_VERAPI').AsString);
    If cmbVersaoAPI.ItemIndex = -1 Then
    Begin
      If Not qryTabela.IsEmpty Then
        cmbVersaoAPI.ItemIndex := 0;
    End;
    cmbVersaoAPI.OnChange(cmbVersaoAPI);
  Finally
    If Assigned(LDataset) Then
      FreeAndNil(LDataset);
  End;
end;

procedure TfrmCadCCa.cmbTipoDoPixChange(Sender: TObject);
begin
  inherited;
  edtCPFCNPJPix.Visible := False;
  edtChavePix.Clear;
  edtChavePix.TipoTexto := ttAlfaNumerico;

  Case cmbTipoDoPix.ItemIndex Of
    1: edtChavePix.MaxLength := 15;
    2: edtChavePix.MaxLength := 60;
    3: edtChavePix.MaxLength := 36;
    0:
    Begin
      edtCPFCNPJPix.Visible := True;
      If edtCPFCNPJPix.Text = '' Then
        edtCPFCNPJPix.Text := '1';

      edtChavePix.MaxLength := 14;
      If edtCPFCNPJPix.Text = '2' Then
        edtChavePix.MaxLength := 11;
    End;
  End;

  If cmbTipoDoPix.ItemIndex in [0] Then
    edtChavePix.TipoTexto := ttInteiro;

  pAjustaAssocChavePixScope;
end;

procedure TfrmCadCCa.cmbVersaoAPIChange(Sender: TObject);
begin
  inherited;
  If Not pnlChaveAppDev.Visible Then
    Exit;

  If Not cmbVersaoAPI.Visible Then
    Exit;

  If dbeCodBco.Text <> '001' Then
    Exit;

  pnlCertificadoPFX.Visible := cmbVersaoAPI.Text = '2';
  pnlSenhaCertificado.Visible := cmbVersaoAPI.Text = '2';
end;

function TfrmCadCCa.ContaJaCadastrada(ABanco, AEmpresa, AAgencia, ADigitoAg,
                                      AConta, ADigitoC, ATipoConta: String;
                                      var AContaEncontrada: String): Boolean;
Var
  qryBusca: TUniQuery;
begin
  qryBusca := fCriaQuery;
  Result   := False;
  Try
    qryBusca.Close;
    qryBusca.SQL.Clear;
    qryBusca.SQL.Add('SELECT * FROM CADCCA ');
    qryBusca.SQL.Add('WHERE CCA_CODBCO = :CODBCO AND ');
    qryBusca.SQL.Add('      CCA_CODEMP = :CODEMP AND ');
    qryBusca.SQL.Add('      CCA_CODCTA = :CODCTA AND ');
    qryBusca.SQL.Add('      CCA_DIGCTA = :DIGCTA AND ');
    qryBusca.SQL.Add('      CCA_AGENCI = :AGENCI AND ');
    qryBusca.SQL.Add('      CCA_DIGAGE = :DIGAGE AND ');
    qryBusca.SQL.Add('      CCA_TIPCON = :TIPCON ');
    qryBusca.ParamByName('CODBCO').AsString  := ABanco;
    qryBusca.ParamByName('CODEMP').AsString  := AEmpresa;
    qryBusca.ParamByName('CODCTA').AsString  := AConta;
    qryBusca.ParamByName('DIGCTA').AsString  := ADigitoC;
    qryBusca.ParamByName('AGENCI').AsString  := AAgencia;
    qryBusca.ParamByName('DIGAGE').AsString  := ADigitoAg;
    qryBusca.ParamByName('TIPCON').AsString  := ATipoConta;
    qryBusca.Open;

    If qryBusca.RecordCount > 0 Then
    begin
      Result := True;
      AContaEncontrada := qryBusca.FieldByName('AUTOINCREM').AsString;
    end;

    qryBusca.Close;
  Finally
    FreeAndNil(qryBusca);
  End;
end;

procedure TfrmCadCCa.dbeCodBcoExit(Sender: TObject);
begin
  dbeCodBco.Text := fPadL(dbeCodBco.Text, 3, '0');
end;

procedure TfrmCadCCa.dbeUsaPixScopeExit(Sender: TObject);
begin
  If (qryTabela.State In [dsEdit, dsInsert]) And MatchStr(dbeUsaPixScope.Text, ['S', 'N']) Then
    pAtualizaCamposPixScope;
end;

procedure TfrmCadCCa.dbeCodBcoKeyPress(Sender: TObject; var Key: Char);
Var
  arrBancos: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE BANCOS     *}
  {*******************************}
  If fPesqBanco(Self, dbeCodBco, edtNomBan, nil, Key, arrBancos) Then
  Begin
    if fValidaCampos(dbeCodBco, True) then
      SelectNext(ActiveControl, True, True);
    pCarregaBanco;
  End;
end;

procedure TfrmCadCCa.dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, dbeCodEmp, edtNomEmp, Nil, Key, arrEmp, True, True) Then
  Begin
    If fValidaCampos(dbeCodEmp, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadCCa.dbeCodigoFornecedorFiscalKeyPress(Sender: TObject;
  var Key: Char);
  Var
    LFornecedorArray: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForCompleta, Self, dbeCodigoFornecedorFiscal, edtNomeFornecedorFiscal, Nil, Key, LFornecedorArray) Then
  Begin
    If fValidaCampos(dbeCodigoFornecedorFiscal, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCCa.dbgChavesPixDblClick(Sender: TObject);
begin
  inherited;
  If(qryTabela.State in dsEditModes) Then
    btnAlterarPix.Click();
end;

procedure TfrmCadCCa.dbgChavesPixDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if Column.FieldName <> 'ATIVA' then
    Exit;

  If Column.Field.AsString = 'Sim' Then
  Begin
    dbgChavesPix.Canvas.Font.Color := clGreen;
    dbgChavesPix.Canvas.Font.Style := [fsBold];
  End
  Else
  Begin
    dbgChavesPix.Canvas.Font.Color := clRed;
    dbgChavesPix.Canvas.Font.Style := [];
  End;

  dbgChavesPix.Canvas.FillRect(Rect);
  dbgChavesPix.DefaultDrawColumnCell(Rect, DataCol, Column, state);
end;

procedure TfrmCadCCa.dbgChavesPixKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) And
    (btnAlterarPix.Enabled) And
    (qryTabela.State in dsEditModes) Then
    btnAlterarPix.Click();

  If (Key = VK_ESCAPE) And
    (btnCancelarPix.Enabled) And
    (qryTabela.State in dsEditModes) Then
    btnCancelarPix.Click();

  If (Key = VK_DELETE) And
    (btnExcluirPix.Enabled) And
    (qryTabela.State in dsEditModes) Then
    btnExcluirPix.Click();
end;

procedure TfrmCadCCa.edtCPFCNPJPixEnter(Sender: TObject);
begin
  inherited;
  FTipoDocumentoAnterior := edtCPFCNPJPix.Text;
end;

procedure TfrmCadCCa.edtCPFCNPJPixExit(Sender: TObject);
begin
  inherited;
  If FTipoDocumentoAnterior <> edtCPFCNPJPix.Text Then
    cmbTipoDoPix.OnChange(cmbTipoDoPix);
end;

procedure TfrmCadCCa.ExibeCamposConfiguracaoPix(AExibir: Boolean);
begin
  //Feito por conta do posicionamento dos panels
  If Not AExibir Then
  Begin
    btnValidarDadosPix.Visible := AExibir;
    pnlChaveBasic.Visible := AExibir;
    pnlSenhaCertificado.Visible := AExibir;
    pnlCertificadoPfx.Visible := AExibir;
    pnlSantanderParceiro.Visible := AExibir;
    pnlCertificados.Visible := AExibir;
    pnlChavesClientPix.Visible := AExibir;
    pnlChaveAppDev.Visible := AExibir;

    Exit;
  End;

  pnlChaveAppDev.Visible := AExibir;
  pnlChavesClientPix.Visible := AExibir;
  pnlCertificados.Visible := AExibir;
  pnlSantanderParceiro.Visible := AExibir;
  pnlCertificadoPfx.Visible := AExibir;
  pnlSenhaCertificado.Visible := AExibir;
  pnlChaveBasic.Visible := AExibir;
  btnValidarDadosPix.Visible := AExibir;
end;

procedure TfrmCadCCa.ExibePortadorVinculado;
  Var
    LPortador: String;
begin
  lblPortadorVinculado.Caption := 'Portador da Conta: Não vinculado';
  lblPortadorVinculado.Font.Color := clRed;

  If qryTabela.FieldByName('AUTOINCREM').AsString.isEmpty Then
    Exit;

  LPortador := RetornaPortadorVinculadoConaBancaria(qryTabela.FieldByName('AUTOINCREM').AsString);
  If Not LPortador.IsEmpty Then
  Begin
    lblPortadorVinculado.Caption := 'Portador da Conta: ' + LPortador;
    lblPortadorVinculado.Font.Color := clBlue;
  End;
end;

procedure TfrmCadCCa.dbedtAgenciExit(Sender: TObject);
begin
  dbedtAgenci.Text := fPadL(dbedtAgenci.Text, 4, '0');
end;

procedure TfrmCadCCa.dbeEntraSpedChange(Sender: TObject);
begin
  inherited;
  HabilitarFornecedorFiscal;
end;

function TfrmCadCCa.fChaveAleatorioAtivaPixScope: Boolean;
var
  LcdsChavePix: TUniClientDataSet;
begin
  if fCfgSis('PIXSCP') = 'N' then
    Exit(True);

  if qryTabela.State = dsInsert then
    Exit(True);

  if dbeUsaPixScope.Field.AsString <> 'S' then
    Exit(True);

  LcdsChavePix := TUniClientDataSet.Create(nil);
  try
    LcdsChavePix.Data := FDatasetCcaPix.Data;
    LcdsChavePix.First;
    while not LcdsChavePix.Eof do
    begin
      if LcdsChavePix.FieldByName('TIPOACAO').AsString = '3' then
      begin
        LcdsChavePix.Next;
        Continue;
      end;

      if (LcdsChavePix.FieldByName('PIX_TIPCHV').AsString = 'ALEATORIA') and
         (pos(String('SCOPE'), LcdsChavePix.FieldByName('PIX_CHAVE_').AsString) > 0) and
         (LcdsChavePix.FieldByName('PIX_ATIVA_').AsString = 'S') then
      begin
        Exit(True);
      end;
      LcdsChavePix.Next;
    end;
  finally
    FreeAndNil(LcdsChavePix);
  end;
  Result := False;
end;

function TfrmCadCCa.fChaveOFXJaVinculada(AChaveOFX, ABanco: String; var AContaConrrente : String): Boolean;
var SQuery : TUniQuery;
begin
  Result := False;
  SQuery := fCriaQuery;
  try
    SQuery.SQL.Text := ' SELECT CCA_CODCTA '+
                       '   FROM CADCCA '+
                       '  WHERE CCA_CODBCO = :CCA_CODBCO '+
                       '    AND CCA_CHVOFX = :CCA_CHVOFX ';
    SQuery.ParamByName('CCA_CODBCO').AsString := ABanco;
    SQuery.ParamByName('CCA_CHVOFX').AsString := AChaveOFX;
    SQuery.Open;
    if not SQuery.IsEmpty then
      begin
        AContaConrrente := SQuery.FieldByName('CCA_CODCTA').AsString;
        Result := True;
      end;
    SQuery.Close;
  finally
    FreeAndNil(SQuery);
  end;
end;

function TfrmCadCCa.fConsultaDadosPixScope(
  pgbProgresso: TcxProgressBar): Boolean;
var
  LMensagemErro: String;
  LArrInfo: TArrayBandeiraRedePixScope;
  LItemInfo: TInfoBandeiraRedePixScope;
  LarrMenu: Array Of String;
  LSel: Integer;
begin
  Result := False;
  if not fRetornaDadosBandeiraRedePixScope(LarrInfo, LMensagemErro) then
  begin
    fRollBack;
    pGravaLogErro(Concat('[btnAssocChavePixScopeClick] ', LMensagemErro));
    fMensagem('ATENÇÃO', LMensagemErro, ['&Ok']);
    Exit;
  end;

  if Length(LarrInfo) = 0 then
  begin
    fMensagem('ATENÇÃO', 'Nenhuma Bandeira/Rede parametrizada no Pix da empresa!', ['&Ok']);
    exit;
  end
  else if Length(LarrInfo) = 1 then
  begin
    edtChavePix.Text := fRetornaInfoContaPix(LarrInfo[0]);
  end
  else
  begin
    SetLength(LarrMenu,0);
    for LItemInfo in LarrInfo do
    begin
      SetLength(LarrMenu,Succ(Length(LarrMenu)));
      LarrMenu[High(LarrMenu)] := LItemInfo.Descricao;
    end;

    LSel := fGetMenu('Selecione uma conta PIX', LarrMenu, 0, True);
    if LSel = -1 then
    begin
      fMensagem('ATENÇÃO', 'Nenhuma conta PIX selecionada!', ['&Ok']);
      Exit(False);
    end
    else
    begin
      if (LSel <= 0) or (LSel > Length(LarrInfo)) then
        Exit(False);
      edtChavePix.Text := fRetornaInfoContaPix(LarrInfo[LSel-1]);
    end;
  end;
  Result := True;
end;

procedure TfrmCadCCa.FDatasetCcaPixOnAfterScroll(DataSet: TDataSet);
begin
  edtChavePix.Clear;
  cmbTipoDoPix.ItemIndex := -1;
  edtCPFCNPJPix.Visible := False;

  If (Dataset.IsEmpty) Then
    Exit;

  If (Dataset.State in dsEditModes) Then
    Exit;

  If Dataset.FieldByName('PIX_TIPCHV').AsString = 'CNPJ-CPF' Then
  Begin
    cmbTipoDoPix.ItemIndex := 0;
    edtCPFCNPJPix.Text := '1';
    If Dataset.FieldByName('PIX_CHAVE_').AsString.Length = 11 Then
      edtCPFCNPJPix.Text := '2';
  End
  Else If Dataset.FieldByName('PIX_TIPCHV').AsString = 'CELULAR' Then
    cmbTipoDoPix.ItemIndex := 1
  Else If Dataset.FieldByName('PIX_TIPCHV').AsString = 'EMAIL' Then
    cmbTipoDoPix.ItemIndex := 2
  Else If Dataset.FieldByName('PIX_TIPCHV').AsString = 'ALEATORIA' Then
    cmbTipoDoPix.ItemIndex := 3;

  cmbTipoDoPix.OnChange(cmbTipoDoPix);

  edtChavePix.Text := Dataset.FieldByName('PIX_CHAVE_').AsString;
  chkChaveAtiva.Checked := Dataset.FieldByName('PIX_ATIVA_').AsString = 'S';
end;

procedure TfrmCadCCa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(FDatasetCcaPix);
end;

procedure TfrmCadCCa.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela := 'CADCCA';
  strNomeCampo  := 'AUTOINCREM';

  qryConEmp := fCriaQuery(Self);
  qryCadCCa := fCriaQuery(Self);
  qryTabela := qryCadCCa;

  qryCadCCa.AfterScroll := qryCadCCaAfterScroll;

  dtsCadCCa.DataSet := qryTabela;

  FDatasetCcaPix := fCriaClientDataset('SELECT *, "0" AS TIPOACAO FROM CCAPIX WHERE FALSE');

  pnlAcoesPix.Enabled := False;

  FAutenticacaoExtrato := TAutCca.Create;

  FUsaPixScope := fCfgSis('PIXSCP', varBoolean);
end;

procedure TfrmCadCCa.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(FAutenticacaoExtrato) Then
    FreeAndNil(FAutenticacaoExtrato);
end;

procedure TfrmCadCCa.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
  FWidthCampoChavePix := edtChavePix.Width;
  FLeftCampoChavePix := edtChavePix.Left;
  pnlUtilizaShipay.Visible := False;
  pnlUsaPixScope.Visible := False;

  If Not fCfgSis('USAPIX', varBoolean) Then
  Begin
    pnlChavesPix.Visible := False;
    Self.Height := 460;
    pnlContaGravame.Top := pnlUtilizaShipay.Top;
  End
  Else
  Begin
    tabAutorizacaoPix.TabVisible := fVerificaAcessoSistema('ALTCHAVPIX', strLoginUsuarioLogado);
    pgcDadosPix.ActivePage := tabChavesPix;

    If Not fCfgSis('HOMPIX', varBoolean) Then
    Begin
      lblAmbientePix.Caption := 'PRODUÇÃO';
      lblAmbientePix.Font.Color := clBlue;
    End;

    pnlUtilizaShipay.Visible := True;
  End;

  btnAjuda.Visible := pnlChavesPix.Visible;

  lblBancoPixImplementado.Caption := '';
  cxPaginas.ActivePage :=  cxtabDadosGerais;
end;

procedure TfrmCadCCa.GravaDadosDeAutenticacaoExtrato;
begin

  If Not cxTabExtratoBancario.TabVisible Then
    Exit;

  If Not MatchStr(fraContasBancariasAutenticacao.edtArquivoPFX.Text, ['', 'certificado cadastrado']) Then
    FAutenticacaoExtrato.ArquivoPfx := RetornaArquivoBase64(fraContasBancariasAutenticacao.edtArquivoPFX.Text);

  If Not MatchStr(fraContasBancariasAutenticacao.edtArquivoCRT.Text, ['', 'certificado cadastrado']) Then
    FAutenticacaoExtrato.ArquivoCRT := RetornaArquivoBase64(fraContasBancariasAutenticacao.edtArquivoCRT.Text);


  If Not MatchStr(fraContasBancariasAutenticacao.edtArquivoKEY.Text, ['', 'arquivo key cadastrado']) Then
    FAutenticacaoExtrato.ArquivoKEY := RetornaArquivoBase64(fraContasBancariasAutenticacao.edtArquivoKEY.Text);

  FAutenticacaoExtrato.DataValidadeCertificado := 0;
  if Not Trim(fraContasBancariasAutenticacao.edtValidadeCertificado.Text).IsEmpty then
    FAutenticacaoExtrato.DataValidadeCertificado :=
      StrToDate(fraContasBancariasAutenticacao.edtValidadeCertificado.Text);

  If Not MatchStr(fraContasBancariasAutenticacao.edtChaveAppDev.Text, ['', 'chave App cadastrada']) THen
    FAutenticacaoExtrato.AppKey :=  fraContasBancariasAutenticacao.edtChaveAppDev.Text;

  FAutenticacaoExtrato.SenhaCertificado := fraContasBancariasAutenticacao.edtSenhaCertificado.Text;
  FAutenticacaoExtrato.ClientID := fraContasBancariasAutenticacao.edtClientID.Text;
  FAutenticacaoExtrato.ClientSecret := fraContasBancariasAutenticacao.edtClientSecret.Text;

  If fraContasBancariasAutenticacao.edtChaveBasic.Text <> 'autorização Basic cadastrada' Then
    FAutenticacaoExtrato.AutenticacaoBasic := fraContasBancariasAutenticacao.edtChaveBasic.Text;

  FAutenticacaoExtrato.Gravar(qryTabela.FieldByName('AUTOINCREM').AsString);

end;

function TfrmCadCCa.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  AutoIncremEncontrado: String;
  SContaCorrente : String;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    Try
      If (Sender = dbeCodBco) Then
      Begin
        If Not fEmptyStr(dbeCodBco.Text) Then
        Begin
          pCarregaBanco;
          If fEmptyStr(edtNomBan.Text) Then
          Begin
            fMensagem('','Nenhum banco cadastrado com este código', ['&Ok']);
            Result := False;
          End;
        End
        Else
        Begin
          edtNomBan.Clear;
          dbeCodBco.Field.Value := Null;
          fMensagem('','O código do banco é obrigatório!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeCodEmp) Then
      Begin

        If Not fEmptyStr(dbeCodEmp.Text) Then
        Begin
          pCarregaEmpresa;
          If (qryConEmp.IsEmpty) Then
          Begin
            fMensagem('ATENÇÃO', 'Essa empresa não está cadastrada!', ['&Ok']);
            Result := False;
          End
          Else If Pos(dbeCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
          Begin
            fMensagem('', 'Usuário sem permissão de acesso a essa Empresa!', ['&Ok']);
            Result := False;
          End;
        End
        Else
        Begin
          edtNomEmp.Clear;
          dbeCodEmp.Field.Value := Null;
          fMensagem('','O código da empresa é obrigatório!', ['&Ok']);
          Result := False;
        End;

      End

      Else If (Sender = dbeUsaPixScope) Then
      Begin
        if Not MatchStr(dbeUsaPixScope.Text, ['S', 'N']) then
        begin
          fMensagem('ATENÇÃO','O campo Usa Pix Scope deve ser preenchido com "S" ou "N"!', ['&Ok']);
          Result := False;
        end;

        If Result Then
          pAtualizaCamposPixScope;
      End

      Else If (Sender = dbedtAgenci) Then
      Begin
        if fEmptyStr(dbedtAgenci.Text) then
        begin
          fMensagem('','O número da agência é obrigatório!', ['&Ok']);
          Result := False;
        end;
      end

      Else If (Sender = dbedtCodCta) Then
      Begin
        if fEmptyStr(dbedtCodCta.Text) then
        begin
          fMensagem('','O número da conta corrente é obrigatório!', ['&Ok']);
          Result := False;
        end;
      end

      Else If (Sender = dbCmbTipoCC) Then
      Begin
        If blnBuscaPorChave Then
        Begin
          If ContaJaCadastrada(dbeCodBco.Text, dbeCodEmp.Text, dbedtAgenci.Text,
                               dbeDigAge.Text, dbedtCodCta.Text, dbedtDigCta.Text,
                               dbCmbTipoCC.Text, AutoIncremEncontrado) Then
          Begin
            If (qryTabela.State In [dsInsert,dsEdit]) Then
            Begin
              qryTabela.Close;
              qryTabela.SQL.Clear;
              qryTabela.SQL.Add('SELECT * FROM CADCCA ');
              qryTabela.SQL.Add('WHERE AUTOINCREM = ' + AutoIncremEncontrado);
              qryTabela.Open;
              qryTabela.Edit;

              btnCancela.Click;
              pSetFocus(btnAlterar);
              Result := False;
              Exit;
            End;
          End;
        end;
      End

      Else If (Sender = dbeChaveOFX) Then
      Begin
        if not fEmptyStr(dbeChaveOFX.Text) and
           fChaveOFXJaVinculada(dbeChaveOFX.Text,
                                dbeCodBco.Text,
                                SContaCorrente) then
        begin
          if SContaCorrente <> dbedtCodCta.Text then
          begin
            fMensagem('','Essa chave OFX já esta vinculada a conta bancaria "'+SContaCorrente+'" deste mesmo banco.',['&Ok']);
            Result := False;
          end;
        end;
      end

      Else If (Sender = dbeCcaGra) Then
      Begin
        if Not MatchStr(dbeCcaGra.Text, ['S', 'N']) then
        begin
          fMensagem('ATENÇÃO','O campo Conta Gravame deve ser preenchido com "S" ou "N"!', ['&Ok']);
          Result := False;
        end;
      End

      Else If (Sender = dbeUsaShp) Then
      Begin
        if Not MatchStr(dbeUsaShp.Text, ['S', 'N']) then
        begin
          fMensagem('ATENÇÃO','O campo Usa Pix Todos Bancos deve ser preenchido com "S" ou "N"!', ['&Ok']);
          Result := False;
        end;

        If Result Then
          pAtualizaCamposPixScope;
      End

      Else If (Sender = dbeParceiroCitel) And (pnlSantanderParceiro.Visible) Then
      Begin
        if (Not MatchStr(dbeParceiroCitel.Text, ['S', 'N'])) then
        begin
          if not (fEmptyStr(dbeClientID.Text + dbeClientSecret.Text)) or not (fEmptyStr(dbeParceiroCitel.Text))  then
          begin
            fMensagem('ATENÇÃO','O campo Parceiro Citel deve ser preenchido com "S" ou "N"!', ['&Ok']);
            pgcDadosPix.ActivePage  :=  tabAutorizacaoPix;
            dbeParceiroCitel.SetFocus;
            Result := False;
          end;
        end;

        pnlCertificadoPFX.Visible := dbeParceiroCitel.Text <> 'S';
        pnlSenhaCertificado.Visible := pnlCertificadoPFX.Visible;
      End

      Else If (Sender = cmbVersaoAPI) And (cmbVersaoAPI.Visible) And (fCfgSis('USAPIX', varBoolean)) Then
      Begin
        If FDataSetCcaPix.State in dsEditModes Then
        Begin
          If fEmptyStr(cmbVersaoAPI.Text) Then
          Begin
            fMensagem('ATENÇÃO','O campo Versão da API deve ser preenchida!', ['&Ok']);
            Result := False;
          End;
        End;
      End

      Else If (Sender = dbeEntraSped) Then
      Begin

        If Not fValidoSimNao(dbeEntraSped.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'No campo "Entrar no SPED" deve ser informado S ou N!', ['&Ok']);
          Result := False;
        End;

      End

      Else If (Sender = dbeCodigoFornecedorFiscal) And (dbeCodigoFornecedorFiscal.Enabled) Then
      Begin
        edtNomeFornecedorFiscal.Clear;
        If Not fEmptyStr(dbeCodigoFornecedorFiscal.Text) Then
        Begin
          CarregaFornecedor;
          If fEmptyStr(edtNomeFornecedorFiscal.Text) Then
          Begin
            fMensagem('ATENÇÃO','Fornecedor Fiscal não encontrado!', ['&Ok']);
            Result := False;
          End;
        End
        Else
        Begin
          If dbeEntraSped.Text = 'S' Then
          Begin
            fMensagem('ATENÇÃO','O Fornecedor Fiscal deve ser preenchido!', ['&Ok']);
            Result := False;
          End;
        End;
      End

      {*****************************************}
      {* VALIDA DADOS DA CHAVE PIX             *}
      {**************************************AJ*}
      Else If (Sender = cmbTipoDoPix) Then
      Begin
        If FDataSetCcaPix.State in dsEditModes Then
        Begin
          If cmbTipoDoPix.ItemIndex < 0 Then
          Begin
            fMensagem('', 'É necessário selecionar o Tipo do Pix!', ['&Ok']);
            pgcDados.TabIndex := 3;
            Result := False;
          End;
        End;
      End
      Else If (Sender = edtCPFCNPJPix) Then
      Begin
        If FDataSetCcaPix.State in dsEditModes Then
        Begin
          If edtCPFCNPJPix.Visible Then
          Begin
            If Not MatchStr(edtCPFCNPJPix.Text, ['1', '2']) Then
            Begin
              fMensagem('', 'Deve ser selecionado 1 para CNPJ e 2 para CPF para a chave do Pix!', ['&Ok']);
              pgcDados.TabIndex := 3;
              Result := False;
            End;
          End;
        End;
      End
      Else If (Sender = edtChavePix) Then
      Begin
        If FDataSetCcaPix.State in dsEditModes Then
        Begin
          If fEmptyStr(edtChavePix.Text) Then
          Begin
            fMensagem('','O campo Chave deve ser preenchido!',['&Ok']);
            pgcDados.TabIndex := 3;
            Result := False;
          End
          Else
          Begin
            If cmbTipoDoPix.ItemIndex In [0, 3] Then
            Begin
              If (Length(edtChavePix.Text) < edtChavePix.MaxLength) and (dbeUsaPixScope.Field.AsString <> 'S') Then
              Begin
                fMensagem('', 'O campo Chave deve possuir ' + edtChavePix.MaxLength.ToString + ' dígitos!', ['&Ok']);
                pgcDados.TabIndex := 3;
                Result := False;
              End;
            End
            Else If cmbTipoDoPix.ItemIndex = 1 Then
            Begin
              If Length(edtChavePix.Text) < edtChavePix.MaxLength - 1 Then
              Begin
                fMensagem('', 'O campo Chave deve possuir ao menos ' + (edtChavePix.MaxLength - 1).ToString + ' dígitos!', ['&Ok']);
                pgcDados.TabIndex := 3;
                Result := False;
              End;
            End
            Else
            Begin
              If Not fEmailValido(edtChavePix.Text, False) Then
              Begin
                fMensagem('', 'O campo Chave deve ser preenchido com um email válido!', ['&Ok']);
                pgcDados.TabIndex := 3;
                Result := False;
              End;
            End;
          End;
        End;

      End;

    Except
      On E: Exception Do
      Begin
        fMensagem('',E.Message,['&OK']);
        Result := False;
      End;
    end;

  end;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadCCa.GerarCertificadosCRTeKey(prgStatus: TcxProgressBar): Boolean;
  Var
    LArquivoKey,
    LArquivoCRT,
    LOpenSSL,
    LPastaOpenSSL,
    LComando: String;

    LArquivosValidos: Boolean;
begin
  Result := True;

  LPastaOpenSSL := RetornaPastaOpenSSL(False);

  If LPastaOpenSSL.IsEmpty Then
    Exit(False);

  LOpenSSL := LPastaOpenSSL + 'openssl.exe';

  prgStatus.Position := 0;
  prgStatus.Properties.Max := 3;

  Try
    LArquivoKey := Trim(edtArquivoPFX.Text).ToUpper.Replace('PFX', 'KEY');
    LArquivoCrt := Trim(edtArquivoPFX.Text).ToUpper.Replace('PFX', 'CRT');

    LComando := ' /C ' + LOpenSSL + ' pkcs12 -in "' + edtArquivoPFX.Text + '" ' +
                ' -nocerts -out "' + LArquivoKey  + '" ' +
                ' -passin pass:' + dbeSenhaCertificado.Text + ' ' +
                ' -passout pass:'+ dbeSenhaCertificado.Text;

    ExecutaComandoWindows('', 'cmd.exe', PWideChar(LComando), '', SW_HIDE, True);
    Sleep(200);

    prgStatus.Position := 1;

    LComando := ' /C ' + LOpenSSL + ' pkcs12 -in "' + edtArquivoPFX.Text + '" ' +
                ' -clcerts -nokeys -out "' + LArquivoCrt  + '" ' +
                ' -passin pass:' + dbeSenhaCertificado.Text;

    ExecutaComandoWindows('', 'cmd.exe', PWideChar(LComando), '', SW_HIDE, True);
    Sleep(200);

    LArquivosValidos := ValidaCertificadosGeradosPeloPfx(LArquivoKey,
                                                         LArquivoCrt);

    prgStatus.Position := 2;

    If LArquivosValidos Then
    Begin
      RemoveBagAtributes(LArquivoCrt, 'BEGIN CERTIFICATE');
      RemoveBagAtributes(LArquivoKey, 'BEGIN ENCRYPTED PRIVATE KEY');

      qryTabela.FieldByName('CCA_ARQCRT').AsString := RetornaArquivoBase64(LArquivoCrt);
      qryTabela.FieldByName('CCA_ARQKEY').AsString := RetornaArquivoBase64(LArquivoKey);
    End
    Else
      Raise ExceptionAutcom.Create('O certificado não foi gravado corretamente. Verifique a senha digitada para o certificado selecionado.');

    prgStatus.Position := 3;
  Finally
    If FileExists(LArquivoCrt) Then
      DeleteFile(LArquivoCrt);

    If FileExists(LArquivoKey) Then
      DeleteFile(LArquivoKey);
  End;
end;

procedure TfrmCadCCa.GravarDadosPix;
  Var
    LDataset: TUniQuery;

    LDatasetExclusao: TUniClientDataset;
begin
  LDataSet := fCriaQuery;

  //Exclusão
  FDatasetCcaPix.Filter := 'TIPOACAO=''3'' ';
  If Not FDatasetCcaPix.IsEmpty Then
  Begin
    LDatasetExclusao := fCriaClientDatSet(FDatasetCcaPix);
    LDatasetExclusao.Fields.Remove(LDatasetExclusao.FindField('TIPOACAO'));
    LDatasetExclusao.Fields.Remove(LDatasetExclusao.FindField('ATIVA'));

    LDataset.SQL.Text := 'DELETE FROM CCAPIX WHERE AUTOINCREM=:AUTOINC';

    FDatasetCcaPix.First;
    While Not FDatasetCcaPix.Eof Do
    Begin
      LDatasetExclusao.Locate('AUTOINCREM', FDatasetCcaPix.FieldByName('AUTOINCREM').AsString, []);
      fVerificaIntegridade(Self.Name, 'CCAPIX', LDatasetExclusao, True);

      LDataset.ParamByName('AUTOINC').AsString := FDatasetCcaPix.FieldByName('AUTOINCREM').AsString;
      LDataset.ExecSQL;

      FDatasetCcaPix.Next;
    End;

    FreeAndNil(LDatasetExclusao);
  End;

  //Inclusao
  FDatasetCcaPix.Filter := 'TIPOACAO=''1'' ';
  If Not FDatasetCcaPix.IsEmpty Then
  Begin
    LDataset.SQL.Text := Concat('INSERT INTO CCAPIX (AUTOINCREM, ',
                                '                    PIX_SEQCCA, ',
                                '                    PIX_TIPCHV, ',
                                '                    PIX_CHAVE_, ',
                                '                    PIX_DTACAD) ',
                                '           VALUES (:AUTOINCREM, ',
                                '                   :PIX_SEQCCA, ',
                                '                   :PIX_TIPCHV, ',
                                '                   :PIX_CHAVE_, ',
                                '                   :PIX_DTACAD) ');

    While Not FDatasetCcaPix.Eof Do
    Begin
      LDataset.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CCAPIX', VS_strCodEmp);
      LDataset.ParamByName('PIX_SEQCCA').AsString := FDatasetCcaPix.FieldByName('PIX_SEQCCA').AsString;
      LDataset.ParamByName('PIX_TIPCHV').AsString := FDatasetCcaPix.FieldByName('PIX_TIPCHV').AsString;
      LDataset.ParamByName('PIX_CHAVE_').AsString := FDatasetCcaPix.FieldByName('PIX_CHAVE_').AsString;
      LDataset.ParamByName('PIX_DTACAD').AsDateTime := fRetDataServidor;

      LDataset.ExecSQL;

      FDatasetCcaPix.Next;
    End;
  End;

  //Alteração
  FDatasetCcaPix.Filter := 'TIPOACAO=''2'' ';
  If Not FDatasetCcaPix.IsEmpty Then
  Begin
    LDataset.SQL.Text := Concat('UPDATE CCAPIX SET PIX_TIPCHV = :PIX_TIPCHV, ',
                                '                  PIX_CHAVE_ = :PIX_CHAVE_, ',
                                '                  PIX_ATIVA_ = :PIX_ATIVA_, ',
                                '                  PIX_DTAALT = :PIX_DTAALT, ',
                                '                  PIX_OPEALT = :PIX_OPEALT  ',
                                '            WHERE AUTOINCREM = :AUTOINCREM  ');

    While Not FDatasetCcaPix.Eof Do
    Begin
      LDataset.ParamByName('AUTOINCREM').AsString := FDatasetCcaPix.FieldByName('AUTOINCREM').AsString;
      LDataset.ParamByName('PIX_TIPCHV').AsString := FDatasetCcaPix.FieldByName('PIX_TIPCHV').AsString;
      LDataset.ParamByName('PIX_CHAVE_').AsString := FDatasetCcaPix.FieldByName('PIX_CHAVE_').AsString;
      LDataset.ParamByName('PIX_ATIVA_').AsString := IIF(chkChaveAtiva.Checked, 'S', 'N');
      LDataset.ParamByName('PIX_DTAALT').AsDateTime := fRetDtaHraServidor;
      LDataset.ParamByName('PIX_OPEALT').AsString := strLoginUsuarioLogado;

      LDataset.ExecSQL;

      FDatasetCcaPix.Next;
    End;
  End;

  FreeAndNil(LDataset);

  FDatasetCcaPix.Filter := 'TIPOACAO <> ''3'' ';

  ImportaCertificadoParceiroCitel;
end;

procedure TfrmCadCCa.HabilitaCamposChavesPix(AHabilitar: Boolean);
begin
  pnlAcoesPix.Enabled := AHabilitar;
  btnGerarChaveBasic.Enabled := AHabilitar;
  edtArquivoCRT.Enabled := AHabilitar;
  edtArquivoKey.Enabled := AHabilitar;
  edtArquivoPfx.Enabled := AHabilitar;
  btnArquivoCRT.Enabled := AHabilitar;
  btnArquivoKey.Enabled := AHabilitar;
  btnArquivoPfx.Enabled := AHabilitar;
  dbeSenhaCertificado.Enabled := AHabilitar;
  dbeChaveBasic.Enabled := AHabilitar;
  dbeClientID.Enabled := AHabilitar;
  dbeClientSecret.Enabled := AHabilitar;

  If pnlAcoesPix.Enabled Then
    pnlAcoesPix.Enabled := qryTabela.State <> dsInsert;
end;

procedure TfrmCadCCa.HabilitarBotoesPix(AEmEdicao: Boolean);
begin
  btnGravarPix.Enabled   := AEmEdicao;
  btnCancelarPix.Enabled := AEmEdicao;
  btnIncluirPix.Enabled  := Not AEmEdicao;
  btnAlterarPix.Enabled  := Not AEmEdicao;
  btnExcluirPix.Enabled  := Not AEmEdicao;

  pnlCamposPix.Enabled := AEmEdicao;
  dbgChavesPix.Enabled := Not AEmEdicao;
end;

procedure TfrmCadCCa.HabilitarFornecedorFiscal;
begin
  lblFornecedorFiscal.Enabled := dbeEntraSped.Text = 'S';
  dbeCodigoFornecedorFiscal.Enabled := (dbeEntraSped.Text = 'S') And
                                       (qryTabela.State <> dsBrowse);
  edtNomeFornecedorFiscal.Enabled := (dbeEntraSped.Text = 'S') And
                                     (qryTabela.State <> dsBrowse);
end;

procedure TfrmCadCCa.ImportaCertificadoParceiroCitel;
begin
  If Not fCfgSis('USAPIX', varBoolean) Then
    Exit;

  If dbeCodBco.Text <> '033' Then
    Exit;

  If fCampoTabela('CER_CODBCO', 'ATBCER', ['CER_CODBCO'], ['033']) <> EmptyStr Then
    Exit;

  TFuncoesPixAutcom.ImportarCertificadoCitelSantander(EmptyStr);
end;

procedure TfrmCadCCa.ImportaDadosDeAutenticacaoPix;
  Var
    LDadosChave: TDadosWebhook;
begin
  If Not ValidacoesImportarDadosDeAutenticacaoPix Then
    Exit;

  If FDatasetCcaPix.FieldByName('ATIVA').AsString <> 'Sim' Then
    FDatasetCcaPix.Locate('ATIVA', 'Sim', []);

  Try
    LDadosChave := TFuncoesPixAutcom.ImportarDadosAutenticacao(FDatasetCcaPix.FieldByName('AUTOINCREM').AsString,
                                                               FDatasetCcaPix.FieldByName('PIX_CHAVE_').AsString,
                                                               qryTabela.FieldByName('CCA_CODEMP').AsString);

    If MatchStr(LDadosChave.Status, ['EMITIDO', 'ALTERADO']) Then
    Begin
      fStartTransaction;
      qryTabela.Edit;
      qryTabela.FieldByName('CCA_CLI_ID').AsString := LDadosChave.ClientID;
      qryTabela.FieldByName('CCA_CLISEC').AsString := LDadosChave.ClientSecret;
      qryTabela.FieldByName('CCA_ARQCRT').AsString := LDadosChave.CertificadoCrt;
      qryTabela.FieldByName('CCA_ARQKEY').AsString := LDadosChave.CertificadoKey;
      qryTabela.FieldByName('CCA_VALCER').AsDateTime := LDadosChave.ValidadeCertificado;
      qryTabela.FieldByName('CCA_IMPAUT').AsString := 'S';
      qryTabela.Post;

      fCommit;

      CarregaDadosPix;

      fMensagem('AVISO', 'Importação dos dados de autenticação Pix foi realizada com sucesso', ['&Ok']);
    End
    Else
    Begin
      If LDadosChave.Status.IsEmpty Then
      Begin
        If fMensagem('ATENÇÃO', 'Não existe os dados referente a chave Pix da empresa selecionada.' + #13 +
                                'Empresa: ' + qryTabela.FieldByName('CCA_CODEMP').AsString + #13 +
                                'Chave Pix: ' + FDatasetCcaPix.FieldByName('PIX_CHAVE_').AsString + '.' + #13 + #13 +
                                'Deseja importar apenas os novos certificados?', ['&Sim', '&Não']) = 1 Then
        Begin
          fStartTransaction;
          qryTabela.Edit;
          qryTabela.FieldByName('CCA_ARQCRT').AsString := LDadosChave.CertificadoCrt;
          qryTabela.FieldByName('CCA_ARQKEY').AsString := LDadosChave.CertificadoKey;
          qryTabela.FieldByName('CCA_VALCER').AsDateTime := LDadosChave.ValidadeCertificado;
          qryTabela.Post;
          fCommit;

          CarregaDadosPix;

          fMensagem('AVISO', 'Importação dos novos certificados Pix foi realizada com sucesso', ['&Ok']);
        End;
      End
      Else
      Begin
        If LDadosChave.DataStatus.IsEmpty Then
          LDadosChave.DataStatus := FormatDateTime('dd/mm/yyyy hh:mm:ss', fRetDtaHraServidor);

        fMensagem('ATENÇÃO', 'Os dados não podem ser importados pois o status está ' + LDadosChave.Status + '.' + #13 +
                             'Data status: ' + LDadosChave.DataStatus + #13 +
                             'Mensagem retorno: ' + LDadosChave.MensagemRetorno, ['&Ok']);
      End;
    End;

    FreeAndNil(LDadosChave);
  Except
    On E: Exception Do
    Begin
      fRollback;

      fMensagem('ERRO', E.Message, ['&Ok']);
    End;
  End;
end;

procedure TfrmCadCCa.MostraCamposPixBanco(ABanco: String);
  Var
    LTabOrder: Integer;
begin
  ExibeCamposConfiguracaoPix(False);
  ExibeCamposConfiguracaoPix(True);
  ExibeCamposConfiguracaoPix(False);

  lblChaveAppDev.Caption := 'Chave APP Pix:';

  lblVersaoAPI.Visible := False;
  cmbVersaoAPI.Visible := False;

  lblArquivoCRT.Caption := 'Certitificado CRT:';

  LTabOrder := 0;

  tabAutorizacaoPix.TabVisible := fVerificaAcessoSistema('ALTCHAVPIX', strLoginUsuarioLogado);
  pAjustaAssocChavePixScope;
  if dbeUsaPixScope.Text = 'S' then
  begin
    pgcDadosPix.ActivePage  :=  tabChavesPix;
    tabAutorizacaoPix.TabVisible := False;
    Exit;
  end;

  If dbeUsaShp.Text = 'S' Then
  Begin
    lblChaveAppDev.Visible := True;
    dbeChaveAppDev.Visible := True;
    lblChaveAppDev.Caption := 'Access Key:';
    pnlChaveAppDev.Visible := True;
    pnlChaveAppDev.TabOrder := LTabOrder;
    Inc(LTabOrder);

    pnlChavesClientPix.Visible := True;
    pnlChavesClientPix.TabOrder := LTabOrder;
    Inc(LTabOrder);

    btnValidarDadosPix.Visible := True;
    btnValidarDadosPix.TabOrder := LTabOrder;

    Exit;
  End;

  If MatchStr(ABanco, ['001', '237']) Then
  Begin
    pnlChaveAppDev.Visible := True;
    pnlChaveAppDev.TabOrder := LTabOrder;

    lblVersaoAPI.Visible := True;
    cmbVersaoAPI.Visible := True;

    lblChaveAppDev.Visible := ABanco.Equals('001');
    dbeChaveAppDev.Visible := ABanco.Equals('001');

    lblSenhaCertificado.Visible := True;
    dbeSenhaCertificado.Visible := True;

    Inc(LTabOrder);
  End;

  pnlChavesClientPix.Visible := True;
  pnlChavesClientPix.TabOrder := LTabOrder;
  Inc(LTabOrder);

  If MatchStr(ABanco, ['341', '237', '748']) Then
  Begin
    pnlCertificados.Visible := True;
    pnlCertificados.TabOrder := LTabOrder;
    Inc(LTabOrder);

    pnlSenhaCertificado.Visible := True;
    Inc(LTabOrder);

    lblSenhaCertificado.Visible := Not MatchStr(ABanco, ['341']);
    dbeSenhaCertificado.Visible := Not MatchStr(ABanco, ['341']);

    If Concat(ABanco, dbeUsaShp.Text).Equals('748N') Then
      lblArquivoCRT.Caption := 'Certitificado CER:';
  End;

  If ABanco.Equals('033') Then
  Begin
    pnlSantanderParceiro.Visible := True;
    pnlSantanderParceiro.TabOrder := LTabOrder;
    Inc(LTabOrder);
  End;

  If MatchStr(ABanco, ['756', '033','422']) Then
  Begin
    If dbeParceiroCitel.Text <> 'S' Then
    Begin
      pnlCertificadoPfx.Visible := True;
      pnlCertificadoPfx.TabOrder := LTabOrder;
      Inc(LTabOrder);

      pnlSenhaCertificado.Visible := True;
      Inc(LTabOrder);

      lblSenhaCertificado.Visible := True;
      dbeSenhaCertificado.Visible := True;
    End;
  End;

  If Not MatchStr(ABanco, ['341', '756','422']) Then
  Begin
    pnlChaveBasic.Visible := True;
    pnlChaveBasic.TabOrder := LTabOrder;
    Inc(LTabOrder);
  End;

  btnValidarDadosPix.Visible := True;
  btnValidarDadosPix.TabOrder := LTabOrder;

  btnImportarItau.Visible := MatchStr(ABanco, ['341']);
  If btnImportarItau.Visible THen
  Begin
    Inc(LTabOrder);
    btnImportarItau.TabOrder := LTabOrder;
  End;
end;

procedure TfrmCadCCa.limpaDadosPix(ALimpaTodos: Boolean = True);
begin
  cmbTipoDoPix.ItemIndex := -1;
  cmbTipoDoPix.OnChange(cmbTipoDoPix);
  edtChavePix.Clear;
  chkChaveAtiva.Checked := False;

  If ALimpaTodos Then
    cmbVersaoAPI.ItemIndex := -1;
end;

procedure TfrmCadCCa.pAjustaAssocChavePixScope;
begin
  if fCfgSis('PIXSCP') = 'N' then
    Exit;

  edtChavePix.Width := FWidthCampoChavePix;
  edtChavePix.Left := FLeftCampoChavePix;
  edtChavePix.Enabled := True;
  btnAssocChavePixScope.Visible := False;

  if cmbTipoDoPix.ItemIndex <> 3 then
    Exit;

  if dbeUsaPixScope.Text = 'S' then
  begin
    edtChavePix.Width := edtChavePix.Width + edtCPFCNPJPix.Width - btnAssocChavePixScope.Width;
    edtChavePix.Left := edtCPFCNPJPix.Left;
    btnAssocChavePixScope.Top := edtChavePix.Top - 2;
    btnAssocChavePixScope.Left := edtChavePix.Left + 2 + edtChavePix.Width;
    edtChavePix.Enabled := False;
    btnAssocChavePixScope.Visible := True;
  end;
end;

procedure TfrmCadCCa.pAtualizaCamposPixScope;
  Var
    LHabilitaCamposPix: Boolean;
begin
  pCarregaBanco;

  LHabilitaCamposPix := (dbeUsaShp.Text = 'S') or (dbeUsaPixScope.Text = 'S');
  If Not LHabilitaCamposPix Then
    LHabilitaCamposPix := Pos(dbeCodBco.Text, untFuncoesSimples.VS_BancosPix) > 0;

  HabilitaCamposChavesPix((qryTabela.State <> dsBrowse) And LHabilitaCamposPix);
end;

procedure TfrmCadCCa.pCarregaBanco;
begin
  edtNomBan.Text := fRetNomeBancoSelec(dbeCodBco.Text);

  lblBancoPixImplementado.Caption := '';

  If fEmptyStr(dbeCodBco.Text) Then
    Exit;

  lblBancoPixImplementado.Caption := '*Esse banco não está ativado para o recebimento por Pix nessa versão.';
  lblBancoPixImplementado.Font.Color := clRed;
  pnlAcoesPix.Enabled := False;
  btnGerarChaveBasic.Enabled := False;

  If (dbeUsaShp.Text = 'S') or (dbeUsaPixScope.Text = 'S') Then
  Begin
    lblBancoPixImplementado.Caption := '*Conta selecionada para o uso do Pix Citel.';
    lblBancoPixImplementado.Font.Color := clBlue;
    pnlAcoesPix.Enabled := qryTabela.State In [dsEdit];
    btnGerarChaveBasic.Enabled := True;
  End
  Else If Pos(dbeCodBco.Text, untFuncoesSimples.VS_BancosPix) > 0 Then
  Begin
    lblBancoPixImplementado.Caption := '*Banco ativado para o recebimento por Pix.';
    lblBancoPixImplementado.Font.Color := clBlue;
    pnlAcoesPix.Enabled := qryTabela.State In [dsEdit];
    btnGerarChaveBasic.Enabled := True;
  End;

  MostraCamposPixBanco(dbeCodBco.Text);
  fraContasBancariasAutenticacao.CarregaCampos(dbeCodBco.Text);
  cxTabExtratoBancario.TabVisible := MatchStr(dbeCodBco.Text, ['001','341']);
end;

procedure TfrmCadCCa.pCarregaEmpresa;
begin
  pPesquisaCadEmp(Nil, qryConEmp, dbeCodEmp.Text);
  edtNomEmp.Text := qryConEmp.FieldByName('EMP_NOMEMP').AsString;
end;

procedure TfrmCadCCa.CarregaFornecedor;
begin
  edtNomeFornecedorFiscal.Clear;
  If Not fEmptyStr(dbeCodigoFornecedorFiscal.Text) Then
    edtNomeFornecedorFiscal.Text := fCampoTabela('FOR_NOMFOR', 'CADFOR', ['FOR_CODFOR'], [dbeCodigoFornecedorFiscal.Text]);
end;

procedure TfrmCadCCa.pHabilitaDesabilitaCamposChaves(blnOpcao: Boolean = True);
begin
  dbeCodBco.Enabled   := blnOpcao;
  If Not blnOpcao Then
    dbeCodBco.Color := $00FFDFB8
  Else
    dbeCodBco.Color := clWhite;

  dbeCodEmp.Enabled   := blnOpcao;
  If Not blnOpcao Then
    dbeCodEmp.Color := $00FFDFB8
  Else
    dbeCodEmp.Color := clWhite;

  dbedtAgenci.Enabled := blnOpcao;
  If Not blnOpcao Then
    dbedtAgenci.Color := $00FFDFB8
  Else
    dbedtAgenci.Color := clWhite;

  dbeDigAge.Enabled   := blnOpcao;
  If Not blnOpcao Then
    dbeDigAge.Color := $00FFDFB8
  Else
    dbeDigAge.Color := clWhite;

  dbedtCodCta.Enabled := blnOpcao;
  If Not blnOpcao Then
    dbedtCodCta.Color := $00FFDFB8
  Else
    dbedtCodCta.Color := clWhite;

  dbedtDigCta.Enabled := blnOpcao;
  If Not blnOpcao Then
    dbedtDigCta.Color := $00FFDFB8
  Else
    dbedtDigCta.Color := clWhite;

  dbCmbTipoCC.Enabled := blnOpcao;
  If Not blnOpcao Then
    dbCmbTipoCC.Color := $00FFDFB8
  Else
    dbCmbTipoCC.Color := clWhite;

  If not blnOpcao Then
    pSetFocus(dbeChaveOFX);
end;

procedure TfrmCadCCa.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CCA_CODBCO');
  stlCampos.Add('CCA_CODEMP');
  stlCampos.Add('CCA_CODCTA');
  stlCampos.Add('CCA_DIGCTA');
  stlCampos.Add('CCA_AGENCI');
  stlCampos.Add('CCA_DIGAGE');
  stlCampos.Add('CCA_DESCRI');
  stlCampos.Add('CCA_TIPCON');
  stlCampos.Add('CCA_OBSERV');
  stlCampos.Add('CCA_CHVOFX');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CCA_CODBCO');
  stlCamInd.Add('CCA_DESCRI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadCCa.pLimpaCampos;
var
  i, j: Integer;
  AFrame: TFrame;
begin
  for i := Self.ComponentCount - 1 downto 0 do
  begin
    if (Self.Components[i] is TEditFocus) then
      (Self.Components[i] as TEditFocus).Text := '';

    if (Self.Components[i] is TFrame) then
    begin
      AFrame := Self.Components[i] as TFrame;
      for j := 0 to AFrame.ComponentCount - 1 do
      begin
        if (AFrame.Components[j] is TEditFocus) then
          (AFrame.Components[j] as TEditFocus).Text := '';
      end;
    end;
  end;

  LimpaDadosPix;
  FAutenticacaoExtrato.Limpar;
end;

procedure TfrmCadCCa.RemoveBagAtributes(AArquivo, ATextoInicio: String);
  Var
    LEncontrou: Boolean;

    LArquivo: TStringList;
Begin
  Try
    LArquivo := TStringList.Create;
    LArquivo.LoadFromFile(AArquivo);

    If Pos(ATextoInicio, LArquivo.Text) <= 0 Then
      Exit;

    LEncontrou := False;
    While Not LEncontrou Do
    Begin
      LEncontrou := Pos(ATextoInicio, LArquivo[0]) > 0;

      If LEncontrou Then
        Break;

      LArquivo.Delete(0);
    End;

    LArquivo.SaveToFile(AArquivo);
  Finally
    FreeAndNil(LArquivo);
  End;
End;

function TfrmCadCCa.RetornaDadosCertificadoPFX(pgbStatus: TcxProgressBar): Boolean;
  Var
    LOpenSSL,
    LComando,
    LArqPem,
    LArqDados,
    LPastaOpenSSL,
    LMensagemErro: String;

    LContador: Integer;

    LDados: TStringList;

    LDataCertificado: TDateTime;
begin
  Result := True;

  LPastaOpenSSL := RetornaPastaOpenSSL(True);

  If LPastaOpenSSL.IsEmpty Then
  Begin
    edtArquivoPfx.Clear;
    Exit(False);
  End;

  If dbeSenhaCertificado.Visible Then
  Begin
    If fEmptyStr(dbeSenhaCertificado.Text) Then
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
  LComando := LComando + ' -passin pass:'+ dbeSenhaCertificado.Text;
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
  LComando := LComando + ' -passin pass:'+ dbeSenhaCertificado.Text;
  LComando := LComando + ' -noout -enddate > "' + LArqDados + '"';

  ExecutaComandoWindows('', 'cmd.exe', PWideChar(LComando), '', SW_HIDE, True);
  Sleep(800);

  LDataCertificado := RetornaDataValidadeArquivoPEM(LArqDados);
  DeleteFile(LArqDados);

  pgbStatus.Position := 2;

  dbeValidadeCertificado.Field.Value := Null;
  If LDataCertificado = 0 Then
  Begin
    LMensagemErro := 'Não foi possível retornar a validade do certificado selecionado. ' + #13 +
                     'Verifique se é um arquivo válido de certificado';

    If dbeSenhaCertificado.Visible Then
      LMensagemErro := LMensagemErro + ' ou se a senha digitada está correta';
    LMensagemErro := LMensagemErro + '.';

    fMensagem('ATENÇÃO', LMensagemErro, ['&Ok']);

    edtArquivoPfx.Clear;
    Exit(False);
  End
  Else
    dbeValidadeCertificado.Field.AsDateTime := LDataCertificado;

  //Nome certificado
  LArqDados := LPastaOpenSSL + 'certname.pem';
  LComando := ' /C ' + LOpenSSL + ' x509 -in "' + LArqPem + '" ';
  LComando := LComando + ' -passin pass:'+ dbeSenhaCertificado.Text;
  LComando := LComando + ' -noout -subject > "' + LArqDados + '"';

  DeleteFile(LArqDados);
  Sleep(400);

  If FileExists(LArqDados) Then
  Begin
    fMensagem('ATENÇÃO', 'Apague o arquivo ' + LArqDados + ' para que possa ser gerado um novo.' , ['&Ok'], 0);
    edtArquivoPfx.Clear;
    Exit(False);
  End;

  ExecutaComandoWindows('', 'cmd.exe', PWideChar(LComando), '', SW_HIDE, True);
  Sleep(800);

  LDados := TStringList.Create;
  LDados.LoadFromFile(LArqDados);
  If fEmptyStr(LDados.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'Não foi possível retornar os dados do certificado selecionado. ' + #13 +
                         'Verifique se é um arquivo válido de certificado.', ['&Ok']);

    edtArquivoPfx.Clear;
    Result := False;
  End
  Else
  Begin
    LDados.Delimiter := ',';
    LDados.StrictDelimiter := True;
    LDados.DelimitedText := LDados.Text;

    qryTabela.FieldByName('CCA_NOMCER').AsString := '';
    For LContador := 0 To LDados.Count - 1 Do
    Begin
      If LeftStr(LDados[LContador], 6) = ' CN = ' Then
      Begin
        qryTabela.FieldByName('CCA_NOMCER').AsString := LDados[LContador].Replace(' CN = ', EmptyStr);

        Break;
      End;
    End;

    If qryTabela.FieldByName('CCA_NOMCER').AsString.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO', 'Não foi possível retornar os dados do certificado selecionado. ' + #13 +
                           'Verifique se é um arquivo válido de certificado.', ['&Ok']);

      edtArquivoPfx.Clear;

      Result := False;
    End;
  End;

  pgbStatus.Position := 3;

  FreeAndNil(LDados);

  DeleteFile(LArqDados);
end;

function TfrmCadCCa.RetornaPastaOpenSSL(AArquivoPfx: Boolean): String;
  Var
    LOpenSSL: String;
begin
  Result := ExtractFilePath(Application.ExeName) + 'openssl32\';

  LOpenSSL := Result + 'openssl.exe';

  If FileExists(LOpenSSL) Then
    Exit;

  If AArquivoPfx Then
  Begin
    fMensagem('ATENÇÃO', 'Não foi possível obter os dados do certificado selecionado, pois o aplicativo openssl não está na pasta openssl32 do Autcom.' + #13 +
                         'Entre em contato com a Citel!', ['&Ok'], 0);
    Exit('');
  End;

  Result := ExtractFilePath(Application.ExeName) + 'openssl\';
  LOpenSSL := Result + 'openssl.exe';

  If (Not FileExists(LOpenSSL)) Then
  Begin
    fMensagem('ATENÇÃO', 'Não foi possível obter a validade do certificado selecionado, pois o aplicativo openssl não está na pasta do Autcom.' + #13 +
                         'Entre em contato com a Citel!', ['&Ok'], 0);
    Exit('');
  End;
end;

function TfrmCadCCa.RetornaPortadorVinculadoConaBancaria(
  AAutoIncremCadCCA: String): String;
begin
  Result := fCampoTabela('CONCAT(POR_CODPOR, "-", POR_NOMPOR)',
                         'CADPOR',
                         ['POR_CCAAUT'],
                         [AAutoIncremCadCCA]);
end;

function TfrmCadCCa.RetornaTipoChavePix(AIndiceComboBox: Integer): String;
begin
  Result := 'CNPJ-CPF';
  Case AIndiceComboBox Of
    1: Result := 'CELULAR';
    2: Result := 'EMAIL';
    3: Result := 'ALEATORIA';
  End;
end;

function TfrmCadCCa.RetornaValidadeCertificado(pgbStatus: TcxProgressBar): Boolean;
  Var
    LOpenSSL,
    LComando,
    LArqPem,
    LPastaOpenSSL: String;

    LDataCertificado: TDateTime;
begin
  Result := True;

  LPastaOpenSSL := RetornaPastaOpenSSL(False);

  If LPastaOpenSSL.IsEmpty Then
    Exit(False);

  If dbeSenhaCertificado.Visible Then
  Begin
    If fEmptyStr(dbeSenhaCertificado.Text) Then
    Begin
      fMensagem('ATENÇÃO', 'É necessário digitar a senha do certificado antes de selecionar o arquivo.', ['&Ok']);
      edtArquivoCrt.Clear;
      Exit(False);
    End;
  End;

  LOpenSSL := LPastaOpenSSL + 'openssl.exe';

  LArqPem  := LPastaOpenSSL + 'validade.pem';

  pgbStatus.Position := 0;
  pgbStatus.Properties.Max := 2;

  LComando := ' /C ' + LOpenSSL + ' x509 -in "' + edtArquivoCRT.Text + '" ';
  If (Not fEmptyStr(dbeSenhaCertificado.Text)) Then
    LComando := LComando + ' -passin pass:'+ dbeSenhaCertificado.Text;
  LComando := LComando + ' -noout -enddate > "' + LArqPem + '"';

  DeleteFile(LArqPem);
  Sleep(200);

  If FileExists(LArqPem) Then
  Begin
    fMensagem('ATENÇÃO', 'Apague o arquivo ' + LArqPem + ' para que possa ser gerado um novo.' , ['&Ok'], 0);
    Exit(False);
  End;

  pgbStatus.Position := 1;

  ExecutaComandoWindows('', 'cmd.exe', PWideChar(LComando), '', SW_HIDE, True);
  Sleep(400);

  LDataCertificado := RetornaDataValidadeArquivoPEM(LArqPem);
  If LDataCertificado = 0 Then
  Begin
    fMensagem('ATENÇÃO', 'Não foi possível retornar a validade do certificado selecionado. ' + #13 +
                         'Verifique se é um arquivo válido de certificado.', ['&Ok']);

    Result := False;
  End
  Else
    dbeValidadeCertificado.Field.AsDateTime := LDataCertificado;

  pgbStatus.Position := 2;

  DeleteFile(LArqPem);
end;

procedure TfrmCadCCa.qryCadCCaAfterScroll(DataSet: TDataSet);
begin
  pnlUsaPixScope.Visible := (qryCadCCa.FieldbyName('CCA_PIXSCP').AsString = 'S') Or (FUsaPixScope);
end;

function TfrmCadCCa.ValidaCamposPix: Boolean;
  Var
    LEmpresas: String;
begin
  Result := True;

  If Not fValidaCampos(cmbTipoDoPix) Then
    Exit(False);

  If Not fValidaCampos(edtCPFCNPJPix) Then
    Exit(False);

  If Not fValidaCampos(edtChavePix) Then
    Exit(False);

  If (FDatasetCcaPix.State = dsInsert) and
   (FDatasetCcaPixClone.Locate('PIX_TIPCHV;PIX_CHAVE_', VarArrayOf([RetornaTipoChavePix(cmbTipoDoPix.ItemIndex), edtChavePix.Text]), [])) Then
  Begin
    fMensagem('ATENÇÃO', 'Essa chave Pix já está cadastrada para essa conta!', ['&Ok']);
    pSetFocus(edtChavePix);
    Exit(False);
  End;

  If Not chkChaveAtiva.Checked Then
  Begin
    LEmpresas := TPixDao.RetornaEmpresasComChavePixConfigurada(FDatasetCcaPix.FieldByName('AUTOINCREM').AsString);
    If Not LEmpresas.IsEmpty Then
      Result := fMensagem('ATENÇÃO', 'Essa chave Pix está sendo desativada, mas essa está ' +
                                     'sendo usada na configuração da(s) empresa(s) ' + LEmpresas + '.' + #13 +
                                     'Será necessário que realize a alteração das configurações dessa(s) empresa(s).' + #13 +
                                     'Deseja realmente continuar?', ['&Sim', '&Não'], 2) = 1;
  End;
end;

function TfrmCadCCa.ValidaCertificadosGeradosPeloPfx(AArquivoKey,
  AArquivoCrt: String): Boolean;
  Var
    LDadosArquivo: TStringList;
begin
  If Not FileExists(AArquivoKey) Then
    Exit(False);

  If Not FileExists(AArquivoCrt) Then
    Exit(False);

  Try
    LDadosArquivo := TStringList.Create;

    LDadosArquivo.LoadFromFile(AArquivoKey);
    If LDadosArquivo.Text.IsEmpty Then
      Exit(False);
  Finally
    FreeAndNil(LDadosArquivo);
  End;

  Try
    LDadosArquivo := TStringList.Create;

    LDadosArquivo.LoadFromFile(AArquivoCrt);
    If LDadosArquivo.Text.IsEmpty Then
      Exit(False);
  Finally
    FreeAndNil(LDadosArquivo);
  End;

  Result := True;
end;

function TfrmCadCCa.ValidacoesCamposChavesPix: Boolean;
  Var
    LPossuiChavesPix,
    LFazerPergunta,
    LVerificarCriarBasic: Boolean;
begin
  Result := True;

  If Not fCfgSis('USAPIX', varBoolean) Then
    Exit;

  If Not fVerificaAcessoSistema('ALTCHAVPIX', strLoginUsuarioLogado) Then
    Exit;

  if (dbeUsaShp.Text = 'S') and (dbeUsaPixScope.Text = 'S') then
  begin
    fMensagem('ATENÇÃO', Format('Apenas um dos campos "%s" "%s" pode ser "SIM"!', [lblUtilizaShipay.Caption, lblUsaPixScope.Caption]), ['&Ok']);
    Exit(False);
  end;

  If (Pos(dbeCodBco.Text, untFuncoesSimples.VS_BancosPix) = 0) and (dbeUsaPixScope.Text <> 'S') Then
    Exit;

  If FDatasetCcaPix.State in [dsInsert, dsEdit] Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário finalizar a edição do registro da chave Pix antes de gravar.', ['&Ok']);
    Exit(False);
  End;

  LPossuiChavesPix := Not FDatasetCcaPix.IsEmpty;

  If Not LPossuiChavesPix Then
    Exit;

  LFazerPergunta := False;
  LVerificarCriarBasic := False;

  If dbeUsaShp.Text = 'S' Then
  Begin
    LFazerPergunta := fEmptyStr(dbeChaveAppDev.Text);
    If Not LFazerPergunta Then
      LFazerPergunta := fEmptyStr(dbeClientID.Text);

    If Not LFazerPergunta Then
      LFazerPergunta := fEmptyStr(dbeClientSecret.Text);
  End
  else if dbeUsaPixScope.Text = 'S' then
  begin
    LFazerPergunta := False;
  end
  Else If dbeCodBco.Text = '001' Then
  Begin
    LFazerPergunta := fEmptyStr(dbeChaveAppDev.Text);
    If Not LFazerPergunta Then
    Begin
      LFazerPergunta := fEmptyStr(dbeChaveBasic.Text);

      If Not LFazerPergunta Then
        LFazerPergunta := Concat(cmbVersaoAPI.Text, edtArquivoPFX.Text) = '2';
    End;

    LVerificarCriarBasic := Not fEmptyStr(dbeClientID.Text + dbeClientSecret.Text);
    If LVerificarCriarBasic Then
      LVerificarCriarBasic := fEmptyStr(dbeChaveBasic.Text);
  End
  Else If MatchStr(dbeCodBco.Text, ['237', '748']) Then
  Begin
    LVerificarCriarBasic := Not fEmptyStr(dbeClientID.Text + dbeClientSecret.Text);
    If LVerificarCriarBasic Then
      LVerificarCriarBasic := fEmptyStr(dbeChaveBasic.Text);

    LFazerPergunta := fEmptyStr(edtArquivoCRT.Text);
  End
  Else If MatchStr(dbeCodBco.Text, ['341', '756', '033','422']) Then
  Begin
    LFazerPergunta := fEmptyStr(dbeClientID.Text);
    If Not LFazerPergunta Then
    Begin
      LFazerPergunta := fEmptyStr(dbeClientSecret.Text);

      If MatchStr(Concat(dbeCodBco.Text, lblAmbientePix.Caption), ['341PRODUÇÃO']) Then
        LFazerPergunta := fEmptyStr(edtArquivoCRT.Text);

      If MatchStr(dbeCodBco.Text, ['756', '033','422']) Then
      Begin
        If dbeParceiroCitel.Text <> 'S' Then
          LFazerPergunta := fEmptyStr(edtArquivoPFX.Text);
      End;

      If MatchStr(dbeCodBco.Text, ['033']) Then
      Begin
        LVerificarCriarBasic := fEmptyStr(dbeChaveBasic.Text);

        If Not LFazerPergunta Then
          LFazerPergunta := LVerificarCriarBasic;
      End;
    End;
  End
  Else If MatchStr(dbeCodBco.Text, ['748']) Then
  Begin
    LVerificarCriarBasic := fEmptyStr(dbeChaveBasic.Text);

    LFazerPergunta := fEmptyStr(edtArquivoPFX.Text);
  End;

  If LVerificarCriarBasic Then
    fMensagem('ATENÇÃO', 'Essa conta necessita que a chave Basic seja cadastrada/gerada. Utilize os dados dos campos Client ID, Client Secret e ' +
                         'clique em Gerar Chave Basic', ['&Ok']);


  If LFazerPergunta Then
    Result := fMensagem('ATENÇÃO', 'A conta possui chave Pix cadastrada, mas os dados de autenticação não estão completos. ' +
                                   'Dessa forma, a rotina de recebimentos do Pix não funcionará para essa conta.' + #13 +
                                   'Deseja realmente continuar?', ['&Sim', '&Não']) = 1;
end;

function TfrmCadCCa.ValidacoesImportarDadosDeAutenticacaoPix: Boolean;
begin
  Result := True;

  If qryTabela.State <> dsBrowse Then
  Begin
    fMensagem('ATENÇÃO', 'Essa função não pode ser utilizada com o registro em modo de inserção ou alteração.', ['&Ok']);
    Exit(False);
  End;

  If FDatasetCcaPix.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'Para importação, é necessário possuir pelo menos uma chave Pix cadastrada.', ['&Ok']);
    Exit(False);
  End;

  If fMensagem('ATENÇÃO', 'Deseja realmente importar os dados de autenticação Pix da conta selecionada?', ['&Sim', '&Não']) = 2 Then
    Exit(False);
end;

procedure TfrmCadCCa.ValidaDadosDeAutenticacaoPix;
begin
  If qryTabela.State <> dsBrowse Then
  Begin
    fMensagem('ATENÇÃO', 'Essa função não pode ser utilizada com o registro em modo de inserção ou alteração.', ['&Ok']);
    Exit;
  End;

  If FDatasetCcaPix.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'Para realizar a validação, é necessário possuir pelo menos uma chave Pix cadastrada.', ['&Ok']);
    Exit;
  End;

  If fMensagem('ATENÇÃO', 'Deseja realmente validar os dados de autenticação Pix da conta selecionada?', ['&Sim', '&Não']) = 2 Then
    Exit;

  FDatasetCcaPix.First;

  Try
    ImportaCertificadoParceiroCitel;

    If TFuncoesPixAutcom.ValidarDadosAutenticacao(FDatasetCcaPix.FieldByName('AUTOINCREM').AsString) Then
      fMensagem('AVISO', 'Validação dos dados de autenticação Pix foi realizada com sucesso', ['&Ok']);
  Except
    On E: Exception Do
      fMensagem('ERRO', E.Message, ['&Ok']);
  End;
end;

function TfrmCadCCa.ValidaPixUtilizado: Boolean;
  Var
    LConsulta: TUniQuery;
begin
  If FDatasetCcaPix.FieldByName('AUTOINCREM').AsString.IsEmpty Then
    Exit(False);

  Try
    LConsulta := fCriarQuery('SELECT SIS_CODEMP FROM CFGSIS WHERE SIS_CODCFG="CFG_CHAPIX" AND ' +
                             '       SIS_VALCFG="' + FDatasetCcaPix.FieldByName('AUTOINCREM').AsString + '" LIMIT 1');
    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;

    If Not Result Then
    Begin
      LConsulta := fCriarQuery('SELECT MPX_SEQPIX FROM MOVPIX WHERE MPX_SEQPIX="' + FDatasetCcaPix.FieldByName('AUTOINCREM').AsString + '" LIMIT 1');
      LConsulta.Open;

      Result := Not LConsulta.IsEmpty;
    End;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

end.
