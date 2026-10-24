unit untRelacaoPedidosPixGerados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, ComboBoxFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCalendar, cxCurrencyEdit, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel,
  cxGrid, UniClientDataSet, Uni, cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils,
  EditFocus, cxTextEdit, cxMaskEdit, cxDropDownEdit, untTypesSistema, Clipbrd,
  System.Generics.Collections, DateUtils, untLiberacao, cxProgressBar,
  System.StrUtils, untTCreditoClientePixAutcom;

type
  TfrmRelacaoPedidosPixGerados = class(TfrmPai)
    pnlTopo: TPanel;
    pnlGrid: TPanel;
    lblStatus: TLabel;
    cmbStatus: TComboBoxFocus;
    grdLancamentos: TcxGridCitel;
    grdLancamentosDados: TcxGridDBTableViewCitel;
    grdLancamentosNivel: TcxGridLevel;
    grdLancamentosDadosFGO_NUMDOC: TcxGridDBColumn;
    grdLancamentosDadosFGO_ESPDOC: TcxGridDBColumn;
    grdLancamentosDadosFGO_CODEMP: TcxGridDBColumn;
    grdLancamentosDadosFGO_DTAENT: TcxGridDBColumn;
    grdLancamentosDadosCLIENTE: TcxGridDBColumn;
    grdLancamentosDadosFGO_VLRCON: TcxGridDBColumn;
    grdLancamentosDadosMPX_STATUS: TcxGridDBColumn;
    grdLancamentosDadosMPX_CODEMP: TcxGridDBColumn;
    grdLancamentosDadosMPX_QRCODE: TcxGridDBColumn;
    lblPeriodoPix: TLabel;
    mskDtaIni: TcxDateEdit;
    Label3: TLabel;
    mskDtaFin: TcxDateEdit;
    btnRemoverPix: TBitBtnLocked;
    pnlTotais: TPanel;
    gpbLegenda: TGroupBox;
    shpLegendaPagos: TShape;
    lblLegendaPagos: TLabel;
    lblLegendaPagosA: TLabel;
    lblLegendaAtivos: TLabel;
    shpLegendaAtivos: TShape;
    lblLegendaAtivosA: TLabel;
    btnCopiarQRCode: TBitBtnLocked;
    grdLancamentosDadosMPX_CRIADO: TcxGridDBColumn;
    grdLancamentosDadosMPX_VALPIX: TcxGridDBColumn;
    cmbGeradoPelo: TComboBoxFocus;
    lblGeradoPor: TLabel;
    lblVendedor: TLabel;
    edtCodigoVendedor: TEditFocus;
    edtNomeVendedor: TEditFocus;
    shaVendedor: TShape;
    grdLancamentosDadosVENDEDOR: TcxGridDBColumn;
    grdLancamentosDadosFONE01: TcxGridDBColumn;
    grdLancamentosDadosEMAIL1: TcxGridDBColumn;
    pnlRodapeTotais: TPanel;
    lblTotal: TLabel;
    lblQuantidadeTotal: TLabel;
    lblValorTotal: TLabel;
    edtQtdLancamentos: TEditFocus;
    edtValorLancamentos: TEditFocus;
    btnReenviarEmail: TBitBtnLocked;
    btnRelatorioLOGMPX: TBitBtnLocked;
    btnReceberPix: TBitBtnLocked;
    btnGerarCreditoCliente: TBitBtnLocked;
    btnGerarCCPixRecebido: TBitBtnLocked;
    pnlAvisos: TPanel;
    pnlVendedor2: TPanel;
    lblVendedor2: TLabel;
    shaVendedor2: TShape;
    edtCodigoVendedor2: TEditFocus;
    edtNomeVendedor2: TEditFocus;
    pnlEmpresa: TPanel;
    lblEmpresa: TLabel;
    shaEmpresa: TShape;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    btnCarregarPedidos: TBitBtnLocked;
    btnConPagPix: TBitBtnLocked;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure btnCarregarPedidosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnRemoverPixClick(Sender: TObject);
    procedure grdLancamentosDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnCopiarQRCodeClick(Sender: TObject);
    procedure edtCodigoVendedorExit(Sender: TObject);
    procedure edtCodigoVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure btnReenviarEmailClick(Sender: TObject);
    procedure btnRelatorioLOGMPXClick(Sender: TObject);
    procedure btnReceberPixClick(Sender: TObject);
    procedure grdLancamentosDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGerarCreditoClienteClick(Sender: TObject);
    procedure btnGerarCCPixRecebidoClick(Sender: TObject);
    procedure edtCodigoVendedor2Exit(Sender: TObject);
    procedure edtCodigoVendedor2KeyPress(Sender: TObject; var Key: Char);
    procedure btnConPagPixClick(Sender: TObject);
  private
    { Private declarations }
    FDataSetPedidos,
    FDatasetPixGerarCC: TUniClientDataSet;

    FDataSoucePedidos: TDataSource;

    FArrayEmpresa,
    FArrayVendedor,
    FArrayVendedor2: TConsultasArray;

    FprcScroll: TprcScroll;

    FLiberacao: TLiberacao;

    FLiberadoOutrosVendedores: Boolean;
    FLiberadoOutrosVendedores2: Boolean;
    qryConEmp: TUniQuery;

    FAmbienteHomologacao: String;

    FExibirPixBoletos: Boolean;

    function RetornaSQLPedidos: String;
    function RetornaSQLDuplicatas: String;
    function RetornaSQLBoletosPix: String;

    procedure CriaTemporaria;

    procedure CalculaValorTotalPix(ASQL: String);

    procedure OnAfterScroll(Dataset: TDataset);

    procedure VerificacaoSistemaVerdeVermelho;

    function LiberaRemocaoPixGerado(Adocumentos: String): Boolean;

    function LiberaRecebimentoPedidoPix(Adocumentos: String): Boolean;

    procedure GravarLogCTRReenvioEmail(ADataset: TUniClientDataset);

    function EnviarEmailESMSDoPedido(pgbProgresso: TcxProgressBar): Boolean;

    procedure EnviarEmailSMSDeDuplicatas;
    
    function TravarRegistroDoPix(ATravar: Boolean): Boolean;

    procedure ReceberPixDoPedido;

    function ExisteAlgumModeloDePedidoConfigurado: Boolean;

    procedure RemovePixDoDocumento;
    procedure pCarregaEmpresa;
    function RetiraRegistrosPixDuplicados(pgbProgresso: TcxProgressBar): Boolean;
    procedure pStepStatusSelecao(pgbStatus: TcxProgressBar);
    procedure ValidaConsultaPix;

    function ValidarGeracaoDeCCPix: Boolean;
    function ValidacoesMensagensRemoverPix: Boolean;

    procedure CarregaDatasetPixGerarCC;
    procedure ExibirFiltroVendedor2;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmRelacaoPedidosPixGerados: TfrmRelacaoPedidosPixGerados;

implementation
Uses untFuncoesSimples, untGravando, untConsultas, untPesqAux, untFuncoesConsulta,
     untTPixDao, untFuncoes, untFuncFatTypes, untCadRec, untTBaixaReceberEmail,
     untLogCtr, untTLogMpx, untRelatorioAcompanhamentoPix, untTFuncoesPixAutcom,
     untDisparaEmailAut, untDisparaSMSAut, untTiposPix, untTFuncoesAuxiliaresPix,
     untRelacaoPixParaGerarCC, untFuncFat, untConsultaPagamentoPix;

{$R *.dfm}

{ TfrmRelacaoPedidosPixGerados }

procedure TfrmRelacaoPedidosPixGerados.btnCarregarPedidosClick(Sender: TObject);
begin
  inherited;

  If Not fValidaCampos(edtCodEmp, True) Then
    Exit;

  TfrmGravando.fExecutarModal(CriaTemporaria, 'Aguarde... Filtrando registros.', '');

  pSetFocus(grdLancamentos);
end;

procedure TfrmRelacaoPedidosPixGerados.btnConPagPixClick(Sender: TObject);
Var
    LConsultaPixPagamento: TfrmConsultaPagamentoPix;
    LGeradoBoleto: Boolean;
begin
  inherited;

  LConsultaPixPagamento := Nil;
  LGeradoBoleto := FDatasetPedidos.FieldByName('MPX_CRIADO').AsString.Equals('BOLETOS');

  If LGeradoBoleto Then
  Begin
    fMensagem('ATENÇÃO', 'A consulta gerada por boletos está desativada!', ['&Ok']);
    Exit;
  End;

  if TPixDao.ChavePixUtilizaTefScope(FDatasetPedidos.FieldByName('MPX_SEQPIX').AsString) = 'S' then
  begin
    fMensagem('ATENÇÃO', 'Pix via TEF Scope não possui consulta de pagamento!', ['&Ok']);
    Exit;
  end;

  Try
    pCriarFormularios(TfrmConsultaPagamentoPix, LConsultaPixPagamento);
    LConsultaPixPagamento.TxIdPix := FDatasetPedidos.FieldByName('MPX_TX_ID_').AsString;
    LConsultaPixPagamento.TSeqPix := FDatasetPedidos.FieldByName('MPX_SEQPIX').AsString;
    LConsultaPixPagamento.TJsoEnv := FDatasetPedidos.FieldByName('MPX_JSOENV').AsString;
    LConsultaPixPagamento.TCriado := FDatasetPedidos.FieldByName('MPX_CRIADO').AsString;

    LConsultaPixPagamento.NumeroDocumento  := FDatasetPedidos.FieldByName('FGO_NUMDOC').AsString;
    LConsultaPixPagamento.EspecieDocumento := FDatasetPedidos.FieldByName('FGO_ESPDOC').AsString;
    LConsultaPixPagamento.EmpresaDocumento := FDatasetPedidos.FieldByName('FGO_CODEMP').AsString;
    LConsultaPixPagamento.StatusPixAutcom  := FDatasetPedidos.FieldByName('MPX_STATUS').AsString;

    LConsultaPixPagamento.ShowModal;
  Finally
    FreeAndNil(LConsultaPixPagamento);
  End;
end;

procedure TfrmRelacaoPedidosPixGerados.btnCopiarQRCodeClick(Sender: TObject);
  Var
    LMensagem: String;
begin
  inherited;
  If FDatasetPedidos.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário selecionar algum documento para utilizar essa função.', ['&Ok']);

    Exit;
  End;

  Clipboard.AsText := FDatasetPedidos.FieldByName('MPX_QRCODE').AsString;
  LMensagem := 'Texto do QRCode (Pix Copia e Cola) copiado para a área de transferência';

  If Not FDatasetPedidos.FieldByName('MPX_LNKCIT').AsString.IsEmpty Then
  Begin
    Clipboard.AsText := TFuncoesPix.RetornaLinkCitel(FDatasetPedidos.FieldByName('MPX_LNKCIT').AsString,
                                                     FAmbienteHomologacao);
    LMensagem := 'Link do Texto do QRCode (Pix Copia e Cola) copiado para a área de transferência';
  End;

  fMensagem('AVISO', LMensagem, ['&Ok']);
end;

procedure TfrmRelacaoPedidosPixGerados.btnGerarCreditoClienteClick(
  Sender: TObject);
  Var
    LfrmGravando: TfrmGravando;

    LCreditoClientePix: TCreditoClientePixAutcom;

    LPixGerado: Boolean;
    LAutoIncremChavePix: string;
begin
  inherited;

  LAutoIncremChavePix := fCfgSis('CHAPIX');
  if TPixDao.ChavePixUtilizaTefScope(LAutoIncremChavePix) = 'S' then
  begin
    fMensagem('ATENÇÃO', 'Pix via TEF Scope não é possível Gerar Crédito Cliente!', ['&Ok']);
    Exit;
  end;

  If Not ValidarGeracaoDeCCPix Then
    Exit;

  Try
    LCreditoClientePix := TCreditoClientePixAutcom.Create(Self.Name);

    pCriarFormularios(TfrmGravando, LfrmGravando);
    LfrmGravando.fExecutarAcao := LCreditoClientePix.GerarPixParaCredito;
    LfrmGravando.lblGravando.Caption := 'Aguarde... Gerando Pix da cobrança';
    If fCfgSis('HOMPIX', varBoolean) Then
      LfrmGravando.lblGravando.Caption := LfrmGravando.lblGravando.Caption + ' (homologação)';
    LfrmGravando.lblGravando.Caption := LfrmGravando.lblGravando.Caption + '.';
    LfrmGravando.pgbStatus.Visible := False;

    LfrmGravando.ShowModal;

    LPixGerado := LfrmGravando.blnConfirma;

    FreeAndNil(LfrmGravando);

    If LPixGerado Then
      LCreditoClientePix.EnviarEmailSMSDeCreditoDeCliente;

    If LPixGerado Then
      fMensagem('ATENÇÃO', 'A cobrança Pix para geração de crédito de cliente foi gerada com sucesso.', ['&Ok']);
  Finally
    FreeAndNil(LCreditoClientePix);

    btnCarregarPedidos.Click;
  End;
end;

procedure TfrmRelacaoPedidosPixGerados.btnGerarCCPixRecebidoClick(
  Sender: TObject);
  Var
    LRelacaoPixParaGerarCC: TfrmRelacaoPixParaGerarCC;
begin
  inherited;

  If Not btnGerarCCPixRecebido.Visible Then
    Exit;

  Try
    pCriarFormularios(TfrmRelacaoPixParaGerarCC, LRelacaoPixParaGerarCC);
    LRelacaoPixParaGerarCC.ShowModal;
  Finally
    FreeAndNil(LRelacaoPixParaGerarCC);

    CarregaDatasetPixGerarCC;

    btnCarregarPedidos.Click;
  End;
end;

procedure TfrmRelacaoPedidosPixGerados.btnReceberPixClick(Sender: TObject);
begin
  inherited;
  If Not btnReceberPix.Enabled Then
    Exit;

  If fMensagem('ATENÇÃO', 'Você deseja realmente realizar o recebimento desse Pix?', ['&Sim', '&Não'], 2) = 2 Then
    Exit;

  Try
    ReceberPixDoPedido;
  Finally
    TravarRegistroDoPix(False);
    btnCarregarPedidos.Click;

    SetLength(untFuncoesSimples.arrLogLib, 0);
  End;

end;

procedure TfrmRelacaoPedidosPixGerados.btnReenviarEmailClick(Sender: TObject);
  Var
    LGravando: TfrmGravando;

    LCreditoClientePix: TCreditoClientePixAutcom;
begin
  inherited;
  If Not btnReenviarEmail.Enabled Then
    Exit;

  If Not Assigned(FDatasetPedidos.FindField('TABELA')) Then
    Exit;

  If FDatasetPedidos.FieldByName('TABELA').AsString = 'EXTGOR' Then
  Begin
    pCriarFormularios(TfrmGravando, LGravando);
    LGravando.fExecutarAcao := EnviarEmailESMSDoPedido;
    LGravando.lblGravando.Caption := 'Aguarde... Reenviando o pedido do Pix ao cliente.';
    LGravando.pgbStatus.Visible := False;
    LGravando.ShowModal;
  End
  Else If FDatasetPedidos.FieldByName('TABELA').AsString = 'CADREC' Then
  Begin
    If FDatasetPedidos.FieldByName('MPX_CHA_CC').AsString.IsEmpty Then
      EnviarEmailSMSDeDuplicatas
    Else
    Begin
      LCreditoClientePix := TCreditoClientePixAutcom.Create(Self.Name);
      LCreditoClientePix.AutoIncremMovPix := FDatasetPedidos.FieldByName('AUTOINCREM').AsString;
      LCreditoClientePix.ClienteSelecionado := LeftStr(FDatasetPedidos.FieldByName('CLIENTE').AsString, 8);
      LCreditoClientePix.EnviarEmailSMSDeCreditoDeCliente(True);

      FreeAndNil(LCreditoClientePix);
    End;
  End;
end;

procedure TfrmRelacaoPedidosPixGerados.btnRelatorioLOGMPXClick(Sender: TObject);
  Var
    LAcompanhamento: TfrmRelatorioAcompanhamentoPix;
begin
  inherited;
  If Not btnRelatorioLOGMPX.Enabled Then
    Exit;

  If FDatasetPedidos.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário selecionar algum documento para utilizar essa função.', ['&Ok']);

    Exit;
  End;

  Try
    pCriarFormularios(TfrmRelatorioAcompanhamentoPix, LAcompanhamento);
    LAcompanhamento.edtDocumento.Text := FDatasetPedidos.FieldByName('FGO_NUMDOC').AsString;
    LAcompanhamento.edtEspecie.Text := FDatasetPedidos.FieldByName('FGO_ESPDOC').AsString;
    LAcompanhamento.edtEmpresa.Text := FDatasetPedidos.FieldByName('FGO_CODEMP').AsString;
    LAcompanhamento.edtCliente.Text := FDatasetPedidos.FieldByName('CLIENTE').AsString;

    LAcompanhamento.TxIdPix := FDatasetPedidos.FieldByName('MPX_TX_ID_').AsString;
    LAcompanhamento.EmpresaPix := FDatasetPedidos.FieldByName('MPX_CODEMP').AsString;
    LAcompanhamento.TelaChamada := Self.Name;

    LAcompanhamento.ShowModal;
  Finally
    FreeAndNil(LAcompanhamento);
  End;
end;

procedure TfrmRelacaoPedidosPixGerados.btnRemoverPixClick(Sender: TObject);
  Var
    LStatusAtualizadoPix: String;
begin
  inherited;
  If Not btnRemoverPix.Enabled Then
    Exit;

  Try
    If Not ValidacoesMensagensRemoverPix Then
      Exit;

    LStatusAtualizadoPix :=  TPixDao.RetornaDadosDoPix(FDatasetPedidos.FieldByName('MPX_TX_ID_').AsString,
                                                       FDatasetPedidos.FieldByName('MPX_CODEMP').AsString)
                                                       .FieldByName('MPX_STATUS').AsString;

    If LStatusAtualizadoPix.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO', 'Não foi possível determinar o status do Pix selecionado.' + #13 +
                           'É necessário refazer a consulta dos documentos.', ['&Ok']);

      Exit;
    End;

    If MatchStr(LStatusAtualizadoPix, STATUS_PIX_PAGO) Then
    Begin
      If Not FDatasetPedidos.FieldByName('CTR_TX_PIX').AsString.IsEmpty Then
      Begin
        fMensagem('ATENÇÃO', 'Não é permitido remover um Pix que já foi pago!', ['&Ok']);

        Exit;
      End;
    End;

    If Not TravarRegistroDoPix(True) Then
    Begin
      fMensagem('ATENÇÃO', 'O Pix desse pedido está sendo utilizado em Outra Estação por ' +
                           fGetHostLock('CONSULTA_RECEBIMENTO_PIX_' + FDatasetPedidos.FieldByName('MPX_TX_ID_').AsString)  + '!', ['&Ok']);
      Exit;
    End;

    TfrmGravando.fExecutarModal(RemovePixDoDocumento, 'Aguarde... Removendo o Pix do documento.', '');
  Finally
    If Not TCreditoClientePixAutcom.FChaveLCKATC.IsEmpty Then
      fLock_Unlock(TCreditoClientePixAutcom.FChaveLCKATC, False);
  End;
end;

procedure TfrmRelacaoPedidosPixGerados.CriaTemporaria;
  Var
    LConsulta: TUniQuery;

    LSQLConsulta: String;
begin
  Try
    LConsulta := fCriaQuery;

    LConsulta.Options.SetFieldsReadOnly := False;

    LSQLConsulta := RetornaSQLPedidos +  ' UNION ' +
                    RetornaSQLDuplicatas;

    If FExibirPixBoletos Then
    Begin
      If MatchStr(UpperCase(cmbGeradoPelo.Text), ['TODOS', 'BOLETOS']) Then
        LSQLConsulta := LSQLConsulta + ' UNION ' + RetornaSQLBoletosPix;
    End;

    LConsulta.SQL.Text := LSQLConsulta;
    LConsulta.Open;

    FDataSetPedidos.Close;
    pDisableControls(FDataSetPedidos, FprcScroll);
    pSetaClient(LConsulta);
    pSetaClientDataSet(LConsulta, FDataSetPedidos);
    FDataSetPedidos.AggregatesActive := True;
    FDataSetPedidos.Open;

    ValidaConsultaPix;

    FDataSoucePedidos := fCriaDataSource(FDataSetPedidos);
    grdLancamentosDados.DataController.DataSource := FDataSoucePedidos;

    pEnableControls(FDataSetPedidos, FprcScroll);
    FDataSetPedidos.AfterScroll := OnAfterScroll;

    FDataSetPedidos.First;

    CalculaValorTotalPix(LSQLConsulta);
  Finally
    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmRelacaoPedidosPixGerados.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtDesEmp, FArrayEmpresa, fRetNomeEmpresa, Nil, 'da Empresa');
end;

procedure TfrmRelacaoPedidosPixGerados.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, FArrayEmpresa, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelacaoPedidosPixGerados.edtCodigoVendedor2Exit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodigoVendedor2,
                    edtNomeVendedor2,
                    FArrayVendedor2,
                    fRetNomVendRep,
                    nil,
                    'do Vendedor 2',
                    3,
                    False,
                    'Código',
                    False,
                    True);
end;

procedure TfrmRelacaoPedidosPixGerados.edtCodigoVendedor2KeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodigoVendedor2, edtNomeVendedor2, nil, Key, FArrayVendedor2, False) Then
  Begin
    If fValidaCampos(edtCodigoVendedor2, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelacaoPedidosPixGerados.edtCodigoVendedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodigoVendedor,
                    edtNomeVendedor,
                    FArrayVendedor,
                    fRetNomVendRep,
                    nil,
                    'do Vendedor',
                    3,
                    False,
                    'Código',
                    False,
                    True);
end;

procedure TfrmRelacaoPedidosPixGerados.edtCodigoVendedorKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodigoVendedor, edtNomeVendedor, nil, Key, FArrayVendedor, False) Then
  Begin
    If fValidaCampos(edtCodigoVendedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelacaoPedidosPixGerados.EnviarEmailESMSDoPedido(pgbProgresso: TcxProgressBar): Boolean;
  Var
    LAlgumEnviado: Boolean;

    LQRCodePix: String;
begin
  If Not ExisteAlgumModeloDePedidoConfigurado Then
    Exit(False);

  If fMensagem('ATENÇÃO', 'Deseja realmente reenviar o e-mail do pedido?', ['&Sim', '&Não']) = 2 Then
    Exit(False);

  LAlgumEnviado := False;

  Result := untFuncoes.fDisparaWhatsappAutomatico(FDatasetPedidos.FieldByName('FGO_NUMDOC').AsString,
                                                  'PD',
                                                  FDatasetPedidos.FieldByName('FGO_ESPDOC').AsString,
                                                  '',
                                                  '',
                                                  FDatasetPedidos.FieldByName('FGO_CODEMP').AsString,
                                                  FDatasetPedidos.FieldByName('FGO_CODCLI').AsString,
                                                  LQRCodePix,
                                                  True,
                                                  '',
                                                  TGeraArquivoAnexoEmailAutomatico.New(FDatasetPedidos.FieldByName('FGO_NUMDOC').AsString,
                                                                                       FDatasetPedidos.FieldByName('FGO_ESPDOC').AsString,
                                                                                       FDatasetPedidos.FieldByName('FGO_CODEMP').AsString,
                                                                                       FDatasetPedidos.FieldByName('FGO_CODCLI').AsString,
                                                                                       False,
                                                                                       'PD'),
                                                  '',
                                                  '',
                                                  '',
                                                  Self.UnitName);

  If Result Then
    LAlgumEnviado := True;

  Result := untFuncoes.fDisparaEmailAutomatico(FDatasetPedidos.FieldByName('FGO_NUMDOC').AsString,
                                               'PD',
                                               FDatasetPedidos.FieldByName('FGO_ESPDOC').AsString,
                                               '',
                                               '',
                                               FDatasetPedidos.FieldByName('FGO_CODEMP').AsString,
                                               FDatasetPedidos.FieldByName('FGO_CODCLI').AsString,
                                               FDatasetPedidos.FieldByName('MPX_QRCODE').AsString,
                                               TFuncoesPix.RetornaLinkCitel(FDatasetPedidos.FieldByName('MPX_LNKCIT').AsString, FAmbienteHomologacao),
                                               TGeraArquivoAnexoEmailAutomatico.New(FDatasetPedidos.FieldByName('FGO_NUMDOC').AsString,
                                                                                    FDatasetPedidos.FieldByName('FGO_ESPDOC').AsString,
                                                                                    FDatasetPedidos.FieldByName('FGO_CODEMP').AsString,
                                                                                    FDatasetPedidos.FieldByName('FGO_CODCLI').AsString,
                                                                                    False,
                                                                                    'PD'));
  If Result Then
    LAlgumEnviado := True;

  LQRCodePix := FDatasetPedidos.FieldByName('MPX_QRCODE').AsString;
  If Not FDatasetPedidos.FieldByName('MPX_LNKCIT').AsString.IsEmpty Then
    LQRCodePix := TFuncoesPix.RetornaLinkCitel(FDatasetPedidos.FieldByName('MPX_LNKCIT').AsString, FAmbienteHomologacao);

  Result := untFuncoes.fDisparaSMSAutomatico(FDatasetPedidos.FieldByName('FGO_NUMDOC').AsString,
                                             'PD',
                                             FDatasetPedidos.FieldByName('FGO_ESPDOC').AsString,
                                             '',
                                             '',
                                             FDatasetPedidos.FieldByName('FGO_CODEMP').AsString,
                                             FDatasetPedidos.FieldByName('FGO_CODCLI').AsString,
                                             LQRCodePix);

  If Result Then
    LAlgumEnviado := True;

  If Not LAlgumEnviado Then
  Begin
    fMensagem('ATENÇÃO', 'O e-mail/sms do pedido não foi enviado. Verifique os dados do cadastro do cliente.', ['&Ok']);
    Exit;
  End;

  Try
    fStartTransaction;
    TLogMpx.GravaLogMpxTxId(FDatasetPedidos.FieldByName('MPX_TX_ID_').AsString,
                            FDatasetPedidos.FieldByName('MPX_CODEMP').AsString,
                            'REENVIO EMAIL PIX',
                            Self.Name);
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;

      pMensagensErro('Ocorreu um erro ao gravar o log do Pix.' + #13 +
                     'Erro gerado: ' + E.Message, '[TfrmRelacaoPedidosPixGerados.EnviarEmailESMSDoPedido]');
    End;
  End;

  fMensagem('ATENÇÃO', 'O reenvio da cobrança Pix ao cliente foi realizado com sucesso!', ['&Ok']);
end;

procedure TfrmRelacaoPedidosPixGerados.EnviarEmailSMSDeDuplicatas;
  Var
    LDataset: TUniClientDataSet;

    LBaixaReceberEmail: TBaixaReceberEmail;

    LDadosEmail: TDadosDisparaEmail;

    LEnviarEmail,
    LEnviarSMS: Boolean;

    LGravando: TfrmGravando;
begin
  If fClienteConsumidor(fRetNomCliente(FDatasetPedidos.FieldByName('FGO_CODCLI').AsString) ,True, True) Then
  Begin
    fMensagem('ATENÇÃO', 'Essa operação não pode ser utilizada para cliente consumidor.', ['&Ok']);
    Exit;
  End;

  Try
    Try
      LDataset := untCadRec.RetornaDuplicatasDosPixJaGerado(FDatasetPedidos.FieldByName('MPX_TX_ID_').AsString,
                                                            FDatasetPedidos.FieldByName('MPX_CODEMP').AsString);

      LEnviarEmail := TBaixaReceberEmail.DeveEnviarEmail('PX',
                                                         staNenhumaAcao,
                                                         LDataset.FieldByName('CTR_EMACLI').AsString);
      LEnviarSMS := TBaixaReceberEmail.DeveEnviarSms('PX',
                                                     staNenhumaAcao,
                                                     LDataset.FieldByName('CLI_CELULA').AsString);

      If Not LEnviarEmail Then
      Begin
        If Not LEnviarSMS Then
        Begin
          fMensagem('ATENÇÃO', 'Não existe modelo de e-mail/sms ou dados do cliente faltando para o envio do Pix!', ['&Ok']);
          Exit;
        End;
      End;

      If fMensagem('ATENÇÃO', 'Deseja realmente reenviar o e-mail da(s) duplicata(s)?', ['&Sim', '&Não']) = 2 Then
        Exit;

      LDadosEmail.strCodCli := FDatasetPedidos.FieldByName('FGO_CODCLI').AsString;
      LDadosEmail.strEmaCob := LDataset.FieldByName('CTR_EMACLI').AsString;
      LDadosEmail.QRCodePix := FDatasetPedidos.FieldByName('MPX_QRCODE').AsString;
      LDadosEmail.LinkCitelPix := TFuncoesPix.RetornaLinkCitel(FDatasetPedidos.FieldByName('MPX_LNKCIT').AsString, FAmbienteHomologacao);
      LDadosEmail.strValDup := FormatFloat(',0.00', FDatasetPedidos.FieldByName('MPX_VALPIX').AsFloat);

      LBaixaReceberEmail := TBaixaReceberEmail.Create(LDadosEmail,
                                                      LDataset,
                                                      staNenhumaAcao);

      If LEnviarEmail Then
      Begin
        pCriarFormularios(TfrmGravando, LGravando);
        LGravando.fExecutarAcao := LBaixaReceberEmail.EnviarEmailBaixaReceberPix;
        LGravando.lblGravando.Caption := 'Aguarde... Reenviando o e-mail do Pix ao cliente.';
        LGravando.pgbStatus.Visible := False;
        LGravando.ShowModal;
      End;

      If LEnviarSMS Then
      Begin
        pCriarFormularios(TfrmGravando, LGravando);
        LGravando.fExecutarAcao := LBaixaReceberEmail.EnviarSMSBaixaReceberPix;
        LGravando.lblGravando.Caption := 'Aguarde... Reenviando o SMS do Pix ao cliente.';
        LGravando.pgbStatus.Visible := False;
        LGravando.ShowModal;
      End;

      GravarLogCTRReenvioEmail(LDataset);

      fMensagem('AVISO', 'O reenvio da cobrança Pix ao cliente foi realizado com sucesso!', ['&Ok']);
    Finally
      FreeAndNil(LDataset);

      If Assigned(LBaixaReceberEmail) Then
        FreeAndNil(LBaixaReceberEmail);
    End;
  Except
    On E: Exception Do
      pMensagensErro('Ocorreu um erro ao reenviar e-mail/sms do Pix ao cliente.' + #13 +
                     'Erro gerado: ' + E.Message, '[TfrmRelacaoPedidosPixGerados.EnviarEmailSMSDeDuplicatas]');
  End;
end;

procedure TfrmRelacaoPedidosPixGerados.ExibirFiltroVendedor2;
begin
  If Not fCfgSis('REPVEN', varBoolean) Then
  Begin
    pnlVendedor2.Visible := False;
    pnlEmpresa.Top := pnlVendedor2.Top;
    pnlTopo.Height := pnlTopo.Height - pnlVendedor2.Height;
  End;
end;

function TfrmRelacaoPedidosPixGerados.ExisteAlgumModeloDePedidoConfigurado: Boolean;
  Var
    LEmailAutomatico: TEmaAut;

    LSMSAutomatico: TSMSAut;
begin
  Try
    LEmailAutomatico := TEmaAut.Create(Nil);
    LEmailAutomatico.FOpcDoc := 'PD';
    LEmailAutomatico.FStatus := staIncluindo;
    LEmailAutomatico.QrCodePix := FDataSetPedidos.FieldByName('MPX_QRCODE').AsString;

    Result := LEmailAutomatico.fTemEmailAtivo;

    If Not Result Then
    Begin
      LSMSAutomatico := TSMSAut.Create(Nil);
      LSMSAutomatico.FOpcDoc := 'PD';
      LSMSAutomatico.FStatus := staIncluindo;
      LSMSAutomatico.QrCodePix := FDataSetPedidos.FieldByName('MPX_QRCODE').AsString;

      Result := LSMSAutomatico.fTemModeloAtivo;

      FreeAndNil(LSMSAutomatico);
    End;

    If Not Result Then
      fMensagem('ATENÇÃO', 'Não existe modelo de e-mail/sms para envio de inclusão de pedidos!', ['&Ok']);
  Finally
    FreeAndNil(LEmailAutomatico);
  End;
end;

procedure TfrmRelacaoPedidosPixGerados.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryConEmp);
  FreeAndNil(FDataSoucePedidos);
  FreeAndNil(FDataSetPedidos);
  FreeAndNil(FLiberacao);
  FreeAndNil(FDatasetPixGerarCC);
end;

procedure TfrmRelacaoPedidosPixGerados.FormCreate(Sender: TObject);
begin
  inherited;
  FLiberacao := TLiberacao.Create;

  FDataSetPedidos := TUniClientDataset.Create(Self);

  FAmbienteHomologacao := fCfgSis('HOMPIX', varString);

  FExibirPixBoletos := untCadRec.ExisteAlgumaCobrancaComQRCodePix;
  If FExibirPixBoletos Then
    cmbGeradoPelo.Items.Add('Boletos');
end;

procedure TfrmRelacaoPedidosPixGerados.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Shift = [ssCtrl] Then
  Begin
    If Key = Ord('H') Then
      btnRelatorioLOGMPX.Click
    Else If (Key = VK_F12) Then
      btnGerarCCPixRecebido.Click;
  End
  Else If (Key = VK_ESCAPE) Then
    btnSair.Click
  Else If (Key = VK_F3) Then
    btnRemoverPix.Click
  Else If (Key = VK_F4) Then
    btnCopiarQRCode.Click
  Else If (Key = VK_F11) Then
    btnGerarCreditoCliente.Click
  Else If (Key = VK_F12) Then
    btnReenviarEmail.Click
  Else If (Key = VK_F6) Then
    btnConPagPix.Click;
end;

procedure TfrmRelacaoPedidosPixGerados.FormShow(Sender: TObject);
begin
  inherited;
  edtCodEmp.Text := VS_strCodEmp;
  edtCodEmp.OnExit(edtCodEmp);

  mskDtaIni.Date := IncDay(VS_Date, -1);
  mskDtaFin.Date := VS_Date;

  FLiberadoOutrosVendedores := fVerificaAcessoSistema('PERFILVENPIXGER');
  FLiberadoOutrosVendedores2 := fVerificaAcessoSistema('PERFILVEN2PIXGER');
  ExibirFiltroVendedor2;

  btnGerarCreditoCliente.Visible := fVerificaAcessoSistema('PERMGERCCPIX');

  VerificacaoSistemaVerdeVermelho;
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  TfrmGravando.fExecutarModal(CriaTemporaria, 'Aguarde... Filtrando registros.', '');

  CarregaDatasetPixGerarCC;

  pSetFocus(cmbStatus);
end;

function TfrmRelacaoPedidosPixGerados.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {**********************}
    {* VALIDAÇÃO DE DATAS *}
    {*******************LE*}

    If (Sender = mskDtaFin) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (StrToDateDef(mskDtaFin.Text, 0) <= 0) Then
      Begin
        fMensagem('ATENÇÃO', 'A Data Final do período informada é inválida!', ['&Ok']);
        Result := False;
      End
      Else
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('ATENÇÃO', 'O campo Data Final do período deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'O campo Data Inicial do período deve ser preenchido!', ['&Ok']);
          Result := False;
          Sender := mskDtaIni;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('ATENÇÃO','A Data Inicial do período deve ser menor que a Data Final do período!',['&Ok']);
              Result := False;
              Sender := mskDtaIni;
            End;
          End;
        End;
      End;
    End
    Else If (Sender = mskDtaIni) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) and (StrToDateDef(mskDtaIni.Text, 0) <= 0) Then
      Begin
        fMensagem('ATENÇÃO', 'A Data Inicial do período informada é inválida!', ['&Ok']);
        Result := False;
        Sender := mskDtaIni;
      End;
    End


    Else If (Sender = edtCodEmp) Then
    Begin
      If (fEmptyStr(edtCodEmp.Text)) Then
      Begin
        edtDesEmp.Clear;
      End
      Else
      Begin
        If Not SameText(edtCodEmp.Text, '000') Then
        Begin
          SetLength(FArrayEmpresa, 0);

          pCarregaEmpresa;
          If fEmptyStr(edtDesEmp.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
            Result := False;
          End
          Else If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End


    Else If (Sender = edtCodigoVendedor) Then
    Begin
      If (fEmptyStr(edtCodigoVendedor.Text)) Then
        edtNomeVendedor.Clear
      Else
      If Not SameText(edtCodigoVendedor.Text, '000') Then
      Begin
        SetLength(FArrayVendedor, 0);

        edtNomeVendedor.Text := fRetNomVendRep(edtCodigoVendedor.Text);
        If fEmptyStr(edtNomeVendedor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Vendedor não está cadastrado!', ['&O k']);
          Result := False;
        End
      End;
    End

    Else If (Sender = edtCodigoVendedor2) Then
    Begin
      If (fEmptyStr(edtCodigoVendedor2.Text)) Then
        edtNomeVendedor2.Clear
      Else
      If Not SameText(edtCodigoVendedor2.Text, '000') Then
      Begin
        SetLength(FArrayVendedor2, 0);

        edtNomeVendedor2.Text := fRetNomVendRep(edtCodigoVendedor2.Text);
        If fEmptyStr(edtNomeVendedor2.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Vendedor 2 não está cadastrado!', ['&O k']);
          Result := False;
        End
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelacaoPedidosPixGerados.CalculaValorTotalPix(ASQL: String);
  Var
    LTotal: TUniQuery;
begin
  LTotal := fCriaQuery;

  Try
    LTotal.SQL.Text := 'SELECT IFNULL(COUNT(AUTOINCREM), 0) AS QTD, ' +
                       '       IFNULL(SUM(MPX_VALPIX), 0.00) AS TOTAL ' +
                       'FROM (SELECT * FROM (' + ASQL + ') AS TMP GROUP BY AUTOINCREM) TMP2 ';

    LTotal.Open;

    edtQtdLancamentos.Text := '(' + LTotal.FieldByName('QTD').AsString + ')';
    edtValorLancamentos.Text := FormatFloat(',0.00', IfNull(LTotal.FieldByName('TOTAL').Value, 0.00));
  Finally
    LTotal.Close;

    FreeAndNil(LTotal);
  End
end;

procedure TfrmRelacaoPedidosPixGerados.CarregaDatasetPixGerarCC;
begin
  FDatasetPixGerarCC := TPixDao.RetornaDadosPixParaGerarCCOperador(strLoginUsuarioLogado);
  pnlAvisos.Visible := not FDatasetPixGerarCC.IsEmpty;
  btnGerarCCPixRecebido.Visible := not FDatasetPixGerarCC.IsEmpty;
end;

procedure TfrmRelacaoPedidosPixGerados.GravarLogCTRReenvioEmail(
  ADataset: TUniClientDataset);
begin
  Try
    fStartTransaction;

    ADataset.First;
    While Not ADataset.Eof Do
    Begin
      untLogCtr.GravaLogCtr(ADataset.FieldByName('AUTOINCREM').AsString,
                            'REENVIO EMAIL PIX',
                            Self.Name);

      ADataset.Next;
    End;

    TLogMpx.GravaLogMpxTxId(ADataset.FieldByName('CTR_TX_PIX').AsString,
                            ADataset.FieldByName('CTR_EMPPIX').AsString,
                            'REENVIO EMAIL PIX',
                            Self.Name);

    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;

      Raise E;
    End;
  End;
end;

procedure TfrmRelacaoPedidosPixGerados.grdLancamentosDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    LStatus: String;
begin
  inherited;

  If FDataSetPedidos.IsEmpty Then
    Exit;

  LStatus := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdLancamentosDadosMPX_STATUS.Index]);

  ACanvas.Font.Color := clBlack;
  If (LStatus = 'CONCLUIDA') Then
    ACanvas.Font.Color := clBlue;
end;

procedure TfrmRelacaoPedidosPixGerados.grdLancamentosDadosKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
    btnReceberPix.Click;
end;

function TfrmRelacaoPedidosPixGerados.LiberaRecebimentoPedidoPix(
  Adocumentos: String): Boolean;
begin
  FLiberacao.Clear;
  FLiberacao.objMsgLibera.pAddTexto('PERMITIR RECEBER PEDIDOS COM PIX NA RELAÇÃO DE DOCUMENTOS COM PIX GERADOS');
  FLiberacao.objMsgLibera.pAddQuebra;
  FLiberacao.objMsgLibera.pAddTexto('Cliente: ' + FDatasetPedidos.FieldByName('CLIENTE').AsString);
  FLiberacao.objMsgLibera.pAddTexto('Data do Pix: ' + FormatDateTime('dd/mm/yyyy', FDatasetPedidos.FieldByName('MPX_DTACAD').AsDateTime));
  FLiberacao.objMsgLibera.pAddTexto('Valor do Pix: ' + FormatFloat(',0.00', FDatasetPedidos.FieldByName('MPX_VALPIX').AsFloat));
  FLiberacao.objMsgLibera.pAddTexto('Identificação: ' + FDatasetPedidos.FieldByName('MPX_TX_ID_').AsString);
  FLiberacao.objMsgLibera.pAddTexto('Texto QR Code: ' + FDatasetPedidos.FieldByName('MPX_QRCODE').AsString);
  FLiberacao.objMsgLibera.pAddQuebra;
  FLiberacao.objMsgLibera.pAddTexto('Documentos:');

  If ADocumentos.IsEmpty Then
    ADocumentos := FDatasetPedidos.FieldByName('FGO_NUMDOC').AsString + '-' +
                   FDatasetPedidos.FieldByName('FGO_ESPDOC').AsString + '-' +
                   FDatasetPedidos.FieldByName('FGO_CODEMP').AsString;

  FLiberacao.objMsgLibera.pAddTexto(ADocumentos);

  FLiberacao.strDirAce := 'PERRECPIXRELAC';
  FLiberacao.strCodOpe := strLoginUsuarioLogado;
  FLiberacao.strCodDig := strLoginUsuarioLogado;
  FLiberacao.objMsgLibera.strTitulo := 'PERMITIR RECEBER PEDIDOS COM PIX NA RELAÇÃO DE DOCUMENTOS COM PIX GERADOS';

  FLiberacao.pInformaNumDocEspDocCodEmp(
                   FDatasetPedidos.FieldByName('FGO_NUMDOC').AsString,
                   FDatasetPedidos.FieldByName('FGO_ESPDOC').AsString,
                   FDatasetPedidos.FieldByName('FGO_CODEMP').AsString);

  Result := FLiberacao.fLibera;
end;

function TfrmRelacaoPedidosPixGerados.LiberaRemocaoPixGerado(ADocumentos: String): Boolean;
begin
  FLiberacao.Clear;
  FLiberacao.objMsgLibera.pAddTexto('PERMITIR REMOVER PIX ATIVO NA RELAÇÃO DE DOCUMENTOS COM PIX GERADOS');
  FLiberacao.objMsgLibera.pAddQuebra;
  FLiberacao.objMsgLibera.pAddTexto('Cliente: ' + FDatasetPedidos.FieldByName('CLIENTE').AsString);
  FLiberacao.objMsgLibera.pAddTexto('Data do Pix: ' + FormatDateTime('dd/mm/yyyy', FDatasetPedidos.FieldByName('MPX_DTACAD').AsDateTime));
  FLiberacao.objMsgLibera.pAddTexto('Valor do Pix: ' + FormatFloat(',0.00', FDatasetPedidos.FieldByName('MPX_VALPIX').AsFloat));
  FLiberacao.objMsgLibera.pAddTexto('Identificação: ' + FDatasetPedidos.FieldByName('MPX_TX_ID_').AsString);
  FLiberacao.objMsgLibera.pAddTexto('Texto QR Code: ' + FDatasetPedidos.FieldByName('MPX_QRCODE').AsString);
  FLiberacao.objMsgLibera.pAddQuebra;
  FLiberacao.objMsgLibera.pAddTexto('Documentos:');

  If ADocumentos.IsEmpty Then
    ADocumentos := FDatasetPedidos.FieldByName('FGO_NUMDOC').AsString + '-' +
                   FDatasetPedidos.FieldByName('FGO_ESPDOC').AsString + '-' +
                   FDatasetPedidos.FieldByName('FGO_CODEMP').AsString;

  FLiberacao.objMsgLibera.pAddTexto(ADocumentos);

  FLiberacao.strDirAce := 'PERREMPIXRELAC';
  FLiberacao.strCodOpe := strLoginUsuarioLogado;
  FLiberacao.strCodDig := strLoginUsuarioLogado;
  FLiberacao.objMsgLibera.strTitulo := 'PERMITIR REMOVER PIX ATIVO NA RELAÇÃO DE DOCUMENTOS COM PIX GERADOS';
  FLiberacao.pInformaNumDocEspDocCodEmp(
                   FDatasetPedidos.FieldByName('FGO_NUMDOC').AsString,
                   FDatasetPedidos.FieldByName('FGO_ESPDOC').AsString,
                   FDatasetPedidos.FieldByName('FGO_CODEMP').AsString);

  Result := FLiberacao.fLibera;
end;

procedure TfrmRelacaoPedidosPixGerados.OnAfterScroll(Dataset: TDataset);
  Var
    LGeradoBoleto: Boolean;
begin
  LGeradoBoleto := Dataset.FieldByName('MPX_CRIADO').AsString = 'BOLETOS';

  btnRemoverPix.Enabled := Dataset.FieldByName('MPX_STATUS').AsString = 'ATIVA';
  If Not btnRemoverPix.Enabled Then
  Begin
    btnRemoverPix.Enabled := Dataset.FieldByName('CTR_TX_PIX').AsString.IsEmpty;

    If btnRemoverPix.Enabled Then
      btnRemoverPix.Enabled := Not Dataset.FieldByName('MPX_CHA_CC').AsString.IsEmpty;
  End;

  btnReenviarEmail.Enabled := Dataset.FieldByName('MPX_STATUS').AsString = 'ATIVA';

  btnReceberPix.Enabled := Concat(Dataset.FieldByName('MPX_STATUS').AsString, '-',
                                  Dataset.FieldByName('TABELA').AsString) = 'ATIVA-EXTGOR';

  btnRelatorioLOGMPX.Enabled := True;

  If LGeradoBoleto Then
  Begin
    btnRemoverPix.Enabled := False;
    btnReenviarEmail.Enabled := False;
    btnReceberPix.Enabled := False;
    btnRelatorioLOGMPX.Enabled := False;
  End;
end;

procedure TfrmRelacaoPedidosPixGerados.pCarregaEmpresa;
begin
  If Not fEmptyStr(edtCodEmp.Text) Then
  Begin
    edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
    pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  End
  Else
    edtDesEmp.Clear;
end;

procedure TfrmRelacaoPedidosPixGerados.pStepStatusSelecao(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

procedure TfrmRelacaoPedidosPixGerados.ReceberPixDoPedido;
  Var
    LNumeroPedido,
    LEmpresaPedido,
    LListaDePedidos,
    LChavePedido: String;

    LRegistroPix: TUniClientDataSet;
begin
  LNumeroPedido := FDatasetPedidos.FieldByName('FGO_NUMDOC').AsString;
  LEmpresaPedido := FDatasetPedidos.FieldByName('FGO_CODEMP').AsString;

  If FDatasetPedidos.FieldByName('MPX_CODEMP').AsString <> VS_strCodEmp Then
  Begin
    fMensagem('ATENÇÃO', 'Esse pedido possui um Pix vinculado da empresa ' + FDatasetPedidos.FieldByName('MPX_CODEMP').AsString + '.' + #13 +
                         'Portanto deve ser realizado o recebimento na empresa vinculada ao Pix.', ['&Ok']);

    Exit;
  End;

  If TPixDao.PixGeradoEmPedidosDesmembrados(FDatasetPedidos.FieldByName('MPX_CODEMP').AsString,
                                            FDatasetPedidos.FieldByName('MPX_TX_ID_').AsString,
                                            LListaDePedidos) Then
  Begin
    If fMensagem('ATENÇÃO!', 'Esse pedido foi desmembrado e o Pix está vinculado aos pedidos: ' +
                              LListaDePedidos + #13 +
                              'Deseja realizar o adiantamento de todos os pedidos listados?', ['&Sim', '&Não']) = 2 Then
    Begin
      pMensagemOk('Para realizar o adiantamento por Pix em pedidos desmembrados, deve ser realizado o adiantamento de todos os pedidos vinculados.');

      Exit;
    End;
  End;

  If Not LiberaRecebimentoPedidoPix(LListaDePedidos) Then
    Exit;

  If MatchStr(TPixDao.RetornaStatusSePedidoPossuirPix(FDatasetPedidos.FieldByName('MPX_CODEMP').AsString,
                                                      FDatasetPedidos.FieldByName('MPX_TX_ID_').AsString), STATUS_PIX_PAGO) Then
  Begin
    fMensagem('ATENÇÃO', 'O pagamento do pedido já foi realizado através de uma cobrança Pix.', ['&Ok']);

    Exit;
  End;

  LChavePedido := 'FATGOR' + FDatasetPedidos.FieldByName('FGO_NUMDOC').AsString +
                             FDatasetPedidos.FieldByName('FGO_ESPDOC').AsString +
                             FDatasetPedidos.FieldByName('FGO_CODEMP').AsString;

  If Not fLock_Unlock(LChavePedido, True, False) Then
  Begin
    fMensagem('ATENÇÃO', 'O pedido sendo utilizado em Outra Estação por ' +
                         fGetHostLock(LChavePedido)  + '!', ['&Ok']);
    Exit;
  End;

  If Not TravarRegistroDoPix(True) Then
  Begin
    fMensagem('ATENÇÃO', 'O Pix desse pedido está sendo utilizado em Outra Estação por ' +
                         fGetHostLock('CONSULTA_RECEBIMENTO_PIX_' + FDatasetPedidos.FieldByName('MPX_TX_ID_').AsString)  + '!', ['&Ok']);
    Exit;
  End;

  Try
    LRegistroPix := TPixDao.RetornaDadosDoPix(FDatasetPedidos.FieldByName('MPX_TX_ID_').AsString,
                                              FDatasetPedidos.FieldByName('MPX_CODEMP').AsString);

    TFuncoesPixAutcom.PagarPixViaPorQRCode(LRegistroPix,
                                           Self.Name,
                                           False,
                                           'CTR',
                                           LChavePedido,
                                           '');

    FreeAndNil(LRegistroPix);

    If MatchStr(TPixDao.RetornaStatusSePedidoPossuirPix(FDatasetPedidos.FieldByName('MPX_CODEMP').AsString,
                                                        FDatasetPedidos.FieldByName('MPX_TX_ID_').AsString), STATUS_PIX_PAGO) Then
    Begin
      fStartTransaction;
      pGeraLogLiberacao(FDatasetPedidos.FieldByName('FGO_NUMDOC').AsString,
                        FDatasetPedidos.FieldByName('FGO_ESPDOC').AsString,
                        FDatasetPedidos.FieldByName('FGO_CODEMP').AsString);
      fCommit;

      fMensagem('AVISO', 'Recebimento do pedido realizado com sucesso.', ['&Ok']);
    End
    Else
      fMensagem('AVISO', 'Recebimento do pedido não foi realizado.', ['&Ok']);
  Finally
    TravarRegistroDoPix(False);
  End;
end;

procedure TfrmRelacaoPedidosPixGerados.RemovePixDoDocumento;
  Var
    LRetornoStatus: String;

    LCadRecCredito: TUniQuery;
begin
  Try
    Try
      LRetornoStatus := FDatasetPedidos.FieldByName('STATUS_REGISTRO').AsString;
      If Not MatchStr(LRetornoStatus, STATUS_PIX_PAGO) Then
        LRetornoStatus := TFuncoesPixAutcom.MudarStatusDoPixParaRemovido(FDatasetPedidos.FieldByName('MPX_TX_ID_').AsString,
                                                                         FDatasetPedidos.FieldByName('MPX_SEQPIX').AsString);

      Application.ProcessMessages;

      fStartTransaction;

      If FDatasetPedidos.FieldByName('TABELA').AsString = 'EXTGOR' Then
        TPixDao.LimparPixDosPedidos(FDatasetPedidos.FieldByName('MPX_CODEMP').AsString,
                                    FDatasetPedidos.FieldByName('MPX_TX_ID_').AsString)
      Else
      Begin
        If Not FDatasetPedidos.FieldByName('CTR_TX_PIX').AsString.IsEmpty Then
          TPixDao.LimparPixDasDuplicatas(FDatasetPedidos.FieldByName('MPX_CODEMP').AsString,
                                         FDatasetPedidos.FieldByName('MPX_TX_ID_').AsString,
                                         Self.Name)
        Else If Not FDatasetPedidos.FieldByName('CTR_SEQMPX').AsString.IsEmpty Then
        Begin
          TCreditoClientePixAutcom.GravarMovimentacaoBancariaExclusaoCC(FDatasetPedidos);

          LCadRecCredito := fCriarQuery('SELECT * FROM CADREC WHERE CTR_SEQMPX="' + FDatasetPedidos.FieldByName('CTR_SEQMPX').AsString + '" AND CTR_SEQBAI=0');
          LCadRecCredito.Open;

          untCadRec.fApagaDuplicataContasReceber(LCadRecCredito,
                                                 Self.Name,
                                                 'EXCLUSÃO CC PIX',
                                                 False);
          FreeAndNil(LCadRecCredito);
        End;
      End;

      TPixDao.ExcluirRegistroDoPix(FDatasetPedidos.FieldByName('MPX_CODEMP').AsString,
                                   FDatasetPedidos.FieldByName('MPX_TX_ID_').AsString,
                                   Self.Name,
                                   'EXCLUSÃO - REMOÇÃO MANUAL',
                                   IIF(FDatasetPedidos.FieldByName('MPX_USASHP').AsString <> 'S',
                                       'REMOVIDA_PELO_USUARIO_RECEBEDOR',
                                       'cancelled'),
                                   LRetornoStatus);

      pGeraLogLiberacao(FDatasetPedidos.FieldByName('FGO_NUMDOC').AsString,
                        FDatasetPedidos.FieldByName('FGO_ESPDOC').AsString,
                        FDatasetPedidos.FieldByName('FGO_CODEMP').AsString);

      fCommit;

      fMensagem('AVISO', 'Pix removido do(s) documento(s) com sucesso.', ['&Ok']);

      btnCarregarPedidos.Click;
    Except
      On E: Exception Do
      Begin
        fRollBack;

        pMensagensErro('Ocorreu um erro ao remover o Pix do documento selecionado.' + #13 +
                       'Erro gerado: ' + E.Message, '[TfrmRelacaoPedidosPixGerados.btnRemoverPixClick]');
      End;
    End;
  Finally
    SetLength(untFuncoesSimples.arrLogLib, 0);

    TravarRegistroDoPix(False);
  End;
end;

function TfrmRelacaoPedidosPixGerados.RetiraRegistrosPixDuplicados(pgbProgresso: TcxProgressBar): Boolean;
  Var
    LCloneConsulta: TUniClientDataSet;
begin
  Result := True;
  Try
    If FDataSetPedidos.IsEmpty Then Exit;

    If Not Assigned(FDatasetPedidos.FindField('TABELA')) Then
      Exit;

    Try
      LCloneConsulta :=  fCriaClientDatSet(FDataSetPedidos);
      LCloneConsulta.Filtered := False;
      LCloneConsulta.Filter   := 'TABELA = ' + QuotedStr('CADREC');
      LCloneConsulta.Filtered := True;
      LCloneConsulta.First;

      pgbProgresso.Position := 0;
      pgbProgresso.Properties.Max := LCloneConsulta.RecordCount;

      While Not LCloneConsulta.Eof Do
      Begin
        If FDataSetPedidos.Locate('TABELA;MPX_TX_ID_', VarArrayOf(['EXTGOR', LCloneConsulta.FieldByName('MPX_TX_ID_').AsString]), []) Then
          FDataSetPedidos.Delete;

        LCloneConsulta.Next;
        pStepStatusSelecao(pgbProgresso);
      End;

      FDataSetPedidos.First;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    If Assigned(LCloneConsulta) Then
      FreeAndNil(LCloneConsulta);
  End;
end;

function TfrmRelacaoPedidosPixGerados.RetornaSQLBoletosPix: String;
  Var
    LStatus,
    LDataDoPix,
    LEmpresaPedido,
    LVendedor,
    LVendedor2: String;
begin
  LStatus := '';
  Case cmbStatus.ItemIndex Of
    0: LStatus := ' R.CTR_DTAREC IS NULL AND ';
    1: LStatus := ' R.CTR_DTAREC IS NOT NULL AND ';
  End;

  LDataDoPix := '';
  If Not fEmptyStr(mskDtaIni.Text) Then
    LDataDoPix := ' R.CTR_DTABOL BETWEEN "' + FormatDateTime('yyyy/mm/dd', mskDtaIni.Date) + '" AND ' +
                   '                      "' + FormatDateTime('yyyy/mm/dd', mskDtaFin.Date) + '" AND ';

  LEmpresaPedido := '';
  If Not fEmptyStr(edtCodEmp.Text) Then
    LEmpresaPedido := ' R.CTR_CODEMP IN (' + fRetArrToSQLIn(FArrayEmpresa, edtCodEmp.Text) + ') AND '
  Else If Not strEmpAcessoUsuarioLogado.IsEmpty Then
    LEmpresaPedido := ' R.CTR_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') AND ';

  LVendedor := '';
  If Not fEmptyStr(edtCodigoVendedor.Text) Then
    LVendedor := ' R.CTR_CODVEN IN (' + fRetArrToSQLIn(FArrayVendedor, edtCodigoVendedor.Text) + ') AND ';

  LVendedor2 := '';
  If Not fEmptyStr(edtCodigoVendedor2.Text) Then
    LVendedor2 := ' R.CTR_CODREP IN (' + fRetArrToSQLIn(FArrayVendedor2, edtCodigoVendedor2.Text) + ') AND ';


  Result := 'SELECT CONCAT(R.CTR_NUMDUP, R.CTR_PARCEL) AS FGO_NUMDOC, ' +
            '       R.CTR_ESPDOC AS FGO_ESPDOC, ' +
            '       R.CTR_CODEMP AS FGO_CODEMP, ' +
            '       R.CTR_CODCLI AS FGO_CODCLI, ' +

            '       CONCAT(R.CTR_CODCLI, "-", C.CLI_NOMCLI) AS CLIENTE,'+
            '       C.CLI_FONE01 AS FONE01,'+
            '       C.CLI_EMAIL_ AS EMAIL1,'+

            '       R.CTR_DTACAD AS FGO_DTAENT, ' +
            '       R.CTR_VALORI AS FGO_VLRCON, ' +
            '       R.CTR_SEQMPX, ' +
            '       R.CTR_TX_PIX, ' +

            'CASE ' +
            '    WHEN R.CTR_DTAREC IS NULL ' +
            '      THEN "ATIVA" ' +
            '    ELSE "CONCLUIDA" ' +
            '  END AS MPX_STATUS, ' +

            '       R.CTR_CODEMP AS MPX_CODEMP, ' +
            '       R.CTR_QRCODE AS MPX_QRCODE, ' +
            '       R.CTR_LNKCIT AS MPX_LNKCIT, ' +
            '       R.CTR_TX_BOL AS MPX_TX_ID_, ' +
            '       "BOLETOS" AS MPX_CRIADO, ' +
            '       IF(R.CTR_DTAREC IS NULL, CTR_VALDUP, CTR_DINHEI)  MPX_VALPIX, ' +
            '       R.CTR_DTABOL AS MPX_DTACAD, ' +
            '       "" AS MPX_JSOREC, ' +
            '       "" AS MPX_SEQPIX, ' +
            '       "" AS MPX_JSOENV, ' +
            '       "N" AS MPX_USASHP, ' +
            '       "" AS MPX_CHA_CC, ' +
            '       R.AUTOINCREM, ' +

            'CASE ' +
            '    WHEN R.CTR_DTAREC IS NULL ' +
            '      THEN "ATIVA" ' +
            '    ELSE "CONCLUIDA" ' +
            '  END AS STATUS_REGISTRO, ' +

            '       CONCAT(V.OPE_CODOPE, "-", V.OPE_NOMOPE) AS VENDEDOR, ' +
            '       "CADREC" AS TABELA ' +
            'FROM CADREC R ' +
            'LEFT JOIN CADCLI C ON C.CLI_CODCLI=R.CTR_CODCLI ' +
            'LEFT JOIN CADOPE V ON V.OPE_CODOPE=R.CTR_CODVEN ' +

            'WHERE ' +
            ' R.CTR_TX_BOL IS NOT NULL AND ' +
            ' R.CTR_TX_PIX IS NULL AND ' +
            LStatus +
            LDataDoPix +
            LEmpresaPedido +
            LVendedor +
            LVendedor2;

  Result := LeftStr(Result, Result.Length - 4);
end;

function TfrmRelacaoPedidosPixGerados.RetornaSQLDuplicatas: String;
  Var
    LStatus,
    LDataDoPix,
    LGeradoPelo,
    LEmpresaPedido,
    LVendedor,
    LVendedor2: String;
begin
  LStatus := '';
  Case cmbStatus.ItemIndex Of
    0: LStatus := ' M.MPX_STATUS IN ("ATIVA", "ATIVACC", "pending", "pendingv", "pendingvCC") AND ';
    1: LStatus := ' M.MPX_STATUS IN ("CONCLUIDA", "approved") AND ';
  End;

  LGeradoPelo := '';
  Case cmbGeradoPelo.ItemIndex Of
    0: LGeradoPelo := ' (M.MPX_CRIADO IS NULL OR M.MPX_CRIADO="CAIXA") AND ';
    1: LGeradoPelo := ' M.MPX_CRIADO="FATURAMENTO" AND ';
    2: LGeradoPelo := ' M.MPX_CRIADO="FINANCEIRO" AND ';
    3: LGeradoPelo := ' (M.MPX_CRIADO IS NULL OR M.MPX_CRIADO="PEDIDO") AND ';
  End;

  LDataDoPix := '';
  If Not fEmptyStr(mskDtaIni.Text) Then
    LDataDoPix := ' M.MPX_DTACAD BETWEEN "' + FormatDateTime('yyyy/mm/dd', mskDtaIni.Date) + '" AND ' +
                   '                      "' + FormatDateTime('yyyy/mm/dd', mskDtaFin.Date) + '" AND ';

  LEmpresaPedido := '';
  If Not fEmptyStr(edtCodEmp.Text) Then
    LEmpresaPedido := ' M.MPX_CODEMP IN (' + fRetArrToSQLIn(FArrayEmpresa, edtCodEmp.Text) + ') AND '
  Else If Not strEmpAcessoUsuarioLogado.IsEmpty Then
    LEmpresaPedido := ' M.MPX_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') AND ';

  LVendedor := '';
  If Not fEmptyStr(edtCodigoVendedor.Text) Then
    LVendedor := ' R.CTR_CODVEN IN (' + fRetArrToSQLIn(FArrayVendedor, edtCodigoVendedor.Text) + ') AND ';

  LVendedor2 := '';
  If Not fEmptyStr(edtCodigoVendedor2.Text) Then
    LVendedor2 := ' R.CTR_CODREP IN (' + fRetArrToSQLIn(FArrayVendedor2, edtCodigoVendedor2.Text) + ') AND ';


  Result := 'SELECT CONCAT(R.CTR_NUMDUP, R.CTR_PARCEL) AS FGO_NUMDOC, ' +
            '       R.CTR_ESPDOC AS FGO_ESPDOC, ' +
            '       R.CTR_CODEMP AS FGO_CODEMP, ' +
            '       R.CTR_CODCLI AS FGO_CODCLI, ' +

            'CASE'+
            '    WHEN (IFNULL(F.FGO_CGCCON, "") <> "")'+
            '    THEN CONCAT(F.FGO_CODCLI, "-", F.FGO_NOMCON)'+
            '    ELSE CONCAT(R.CTR_CODCLI, "-", C.CLI_NOMCLI)'+
            '  END AS CLIENTE,'+
            '  CASE'+
            '    WHEN (IFNULL(F.FGO_CGCCON, "") <> "")'+
            '    THEN F.FGO_TELCON'+
            '    ELSE C.CLI_FONE01'+
            '  END AS FONE01,'+
            '  CASE'+
            '    WHEN (IFNULL(F.FGO_CGCCON, "") <> "")'+
            '    THEN F.FGO_EMLCON'+
            '    ELSE C.CLI_EMAIL_'+
            '  END AS EMAIL1,'+

            '       R.CTR_DTACAD AS FGO_DTAENT, ' +
            '       IF(R.CTR_DTAREC IS NULL, R.CTR_VALDUP, R.CTR_VALORI) AS FGO_VLRCON, ' +
            '       R.CTR_SEQMPX, ' +
            '       R.CTR_TX_PIX, ' +

            'CASE ' +
            '    WHEN M.MPX_STATUS IN ("pending", "pendingv") ' +
            '      THEN "ATIVA" ' +
            '    WHEN M.MPX_STATUS IN ("approved") ' +
            '      THEN "CONCLUIDA" ' +
            '    ELSE M.MPX_STATUS ' +
            '  END AS MPX_STATUS, ' +

            '       M.MPX_CODEMP, ' +
            '       M.MPX_QRCODE, ' +
            '       M.MPX_LNKCIT, ' +
            '       M.MPX_TX_ID_, ' +
            '       M.MPX_CRIADO, ' +
            '       M.MPX_VALPIX, ' +
            '       M.MPX_DTACAD, ' +
            '       M.MPX_JSOREC, ' +
            '       M.MPX_SEQPIX, ' +
            '       M.MPX_JSOENV, ' +
            '       M.MPX_USASHP, ' +
            '       M.MPX_CHA_CC, ' +
            '       M.AUTOINCREM, ' +
            '       M.MPX_STATUS AS STATUS_REGISTRO, ' +
            '       CONCAT(V.OPE_CODOPE, "-", V.OPE_NOMOPE) AS VENDEDOR, ' +
            '       "CADREC" AS TABELA ' +
            'FROM MOVPIX M ' +
            'JOIN CADREC R ON R.CTR_EMPPIX=M.MPX_CODEMP ' +
            '             AND R.CTR_TX_PIX=M.MPX_TX_ID_ ' +
            'LEFT JOIN CADCLI C ON C.CLI_CODCLI=R.CTR_CODCLI ' +
            'LEFT JOIN CADOPE V ON V.OPE_CODOPE=R.CTR_CODVEN ' +

            'LEFT JOIN EXTGOR G ON G.FGO_EMPPIX=M.MPX_CODEMP ' +
            '                  AND G.FGO_TX_PIX=M.MPX_TX_ID_ ' +
            'LEFT JOIN FATGOR F ON F.AUTOINCREM=G.FGO_SEQFGO ' +

            'WHERE ';

  If cmbGeradoPelo.Text = 'Boletos' Then
    Exit(Result + ' FALSE');

  Result := Result +
            LStatus +
            LDataDoPix +
            LEmpresaPedido +
            LGeradoPelo +
            LVendedor +
            LVendedor2;

  Result := LeftStr(Result, Result.Length - 4) +
            ' UNION ' +

            'SELECT CONCAT(R.CTR_NUMDUP, R.CTR_PARCEL) AS FGO_NUMDOC, ' +
            '       R.CTR_ESPDOC AS FGO_ESPDOC, ' +
            '       R.CTR_CODEMP AS FGO_CODEMP, ' +
            '       R.CTR_CODCLI AS FGO_CODCLI, ' +

            'CASE'+
            '    WHEN (IFNULL(F.FGO_CGCCON, "") <> "")'+
            '      THEN CONCAT(F.FGO_CODCLI, "-", F.FGO_NOMCON)'+
            '    ELSE CONCAT(C.CLI_CODCLI, "-", C.CLI_NOMCLI)'+
            '  END AS CLIENTE,'+
            '  CASE'+
            '    WHEN (IFNULL(F.FGO_CGCCON, "") <> "")'+
            '    THEN F.FGO_TELCON'+
            '    ELSE C.CLI_FONE01'+
            '  END AS FONE01,'+
            '  CASE'+
            '    WHEN (IFNULL(F.FGO_CGCCON, "") <> "")'+
            '    THEN F.FGO_EMLCON'+
            '    ELSE C.CLI_EMAIL_'+
            '  END AS EMAIL1,'+

            '       R.CTR_DTACAD AS FGO_DTAENT, ' +
            '       IF(R.CTR_DTAREC IS NULL, R.CTR_VALDUP, R.CTR_VALORI) AS FGO_VLRCON, ' +
            '       R.CTR_SEQMPX, ' +
            '       IFNULL(R.CTR_TX_PIX, G.FGO_TX_PIX) AS CTR_TX_PIX, ' +

            'CASE ' +
            '    WHEN M.MPX_STATUS IN ("ATIVACC", "pending", "pendingv", "pendingvCC") ' +
            '      THEN "ATIVA" ' +
            '    WHEN M.MPX_STATUS IN ("approved") ' +
            '      THEN "CONCLUIDA" ' +
            '    ELSE M.MPX_STATUS ' +
            '  END AS MPX_STATUS, ' +

            '       M.MPX_CODEMP, ' +
            '       M.MPX_QRCODE, ' +
            '       M.MPX_LNKCIT, ' +
            '       M.MPX_TX_ID_, ' +
            '       M.MPX_CRIADO, ' +
            '       M.MPX_VALPIX, ' +
            '       M.MPX_DTACAD, ' +
            '       M.MPX_JSOREC, ' +
            '       M.MPX_SEQPIX, ' +
            '       M.MPX_JSOENV, ' +
            '       M.MPX_USASHP, ' +
            '       M.MPX_CHA_CC, ' +
            '       M.AUTOINCREM, ' +
            '       M.MPX_STATUS AS STATUS_REGISTRO, ' +
            '       CONCAT(V.OPE_CODOPE, "-", V.OPE_NOMOPE) AS VENDEDOR, ' +
            '       "CADREC" AS TABELA ' +
            'FROM MOVPIX M ' +
            'LEFT JOIN CADREC R ON R.CTR_SEQCON=M.MPX_SEQCON ' +
            '                  AND R.CTR_EMPBAI=M.MPX_CODEMP ' +
            '                  AND R.CTR_DTAREC=M.MPX_DTAREC ' +
            '                  AND R.CTR_ORDPAG > 0          ' +
            'LEFT JOIN CADCLI C ON C.CLI_CODCLI=R.CTR_CODCLI ' +
            'LEFT JOIN CADOPE V ON V.OPE_CODOPE=R.CTR_CODVEN ' +

            'LEFT JOIN EXTGOR G ON G.FGO_EMPPIX=M.MPX_CODEMP ' +
            '                  AND G.FGO_TX_PIX=M.MPX_TX_ID_ ' +
            'LEFT JOIN FATGOR F ON F.AUTOINCREM=G.FGO_SEQFGO ' +

            'WHERE ' +
            LStatus +
            LDataDoPix +
            LEmpresaPedido +
            LGeradoPelo +
            LVendedor +
            LVendedor2 +
            ' R.CTR_NUMDUP IS NOT NULL AND M.MPX_CHA_CC IS NULL ' +
            ' AND M.MPX_TX_ID_ NOT IN (SELECT CTR_TX_PIX FROM CADREC ' +
            '      WHERE CTR_EMPPIX=M.MPX_CODEMP AND CTR_TX_PIX=M.MPX_TX_ID_)';

  Result := Result +
            ' UNION ' +
            'SELECT CONCAT(R.CTR_NUMDUP, R.CTR_PARCEL) AS FGO_NUMDOC, ' +
            '       R.CTR_ESPDOC AS FGO_ESPDOC, ' +
            '       R.CTR_CODEMP AS FGO_CODEMP, ' +
            '       R.CTR_CODCLI AS FGO_CODCLI, ' +

            '       CONCAT(R.CTR_CODCLI, "-", C.CLI_NOMCLI) AS CLIENTE,'+
            '       C.CLI_FONE01 AS FONE01, ' +
            '       C.CLI_EMAIL_ AS EMAIL1, ' +

            '       R.CTR_DTACAD AS FGO_DTAENT, ' +
            '       R.CTR_VALORI AS FGO_VLRCON, ' +
            '       R.CTR_SEQMPX, ' +
            '       R.CTR_TX_PIX, ' +

            'CASE ' +
            '    WHEN M.MPX_STATUS IN ("pending", "pendingv") ' +
            '      THEN "ATIVA" ' +
            '    WHEN M.MPX_STATUS IN ("approved") ' +
            '      THEN "CONCLUIDA" ' +
            '    ELSE M.MPX_STATUS ' +
            '  END AS MPX_STATUS, ' +

            '       M.MPX_CODEMP, ' +
            '       M.MPX_QRCODE, ' +
            '       M.MPX_LNKCIT, ' +
            '       M.MPX_TX_ID_, ' +
            '       M.MPX_CRIADO, ' +
            '       M.MPX_VALPIX, ' +
            '       M.MPX_DTACAD, ' +
            '       M.MPX_JSOREC, ' +
            '       M.MPX_SEQPIX, ' +
            '       M.MPX_JSOENV, ' +
            '       M.MPX_USASHP, ' +
            '       M.MPX_CHA_CC, ' +
            '       M.AUTOINCREM, ' +
            '       M.MPX_STATUS AS STATUS_REGISTRO, ' +
            '       CONCAT(V.OPE_CODOPE, "-", V.OPE_NOMOPE) AS VENDEDOR, ' +
            '       "CADREC" AS TABELA ' +
            'FROM MOVPIX M ' +
            'JOIN CADRCXX X ON X.RCX_SEQCON=M.MPX_SEQCON ' +
            '              AND X.RCX_CODEMP=M.MPX_CODEMP ' +
            '              AND X.RCX_DTACAD=M.MPX_DTAREC ' +
            '              AND X.RCX_ESPDOC="CC"         ' +
            'JOIN CADREC R ON R.AUTOINCREM = X.RCX_CTR_CC ' +
            'LEFT JOIN CADCLI C ON C.CLI_CODCLI=R.CTR_CODCLI ' +
            'LEFT JOIN CADOPE V ON V.OPE_CODOPE=R.CTR_CODVEN ' +

            'WHERE ' +
            LStatus +
            LDataDoPix +
            LEmpresaPedido +
            LGeradoPelo +
            LVendedor +
            LVendedor2 +

            ' R.CTR_NUMDUP IS NOT NULL ' +
            ' AND M.MPX_TX_ID_ NOT IN (SELECT CTR_TX_PIX FROM CADREC ' +
            '      WHERE CTR_EMPPIX=M.MPX_CODEMP AND CTR_TX_PIX=M.MPX_TX_ID_) ';

  Result := Result +
            ' UNION ' +

            'SELECT IFNULL(CONCAT(R.CTR_NUMDUP, R.CTR_PARCEL), "CRÉDITO A SER GERADO") AS FGO_NUMDOC, ' +
            '       IFNULL(R.CTR_ESPDOC, SUBSTRING(M.MPX_CHA_CC, 14, 2)) AS FGO_ESPDOC, ' +
            '       IFNULL(R.CTR_CODEMP, SUBSTRING(M.MPX_CHA_CC, 17, 3)) AS FGO_CODEMP, ' +
            '       IFNULL(R.CTR_CODCLI, SUBSTRING(M.MPX_CHA_CC, 21, 8)) AS FGO_CODCLI, ' +

            '  CONCAT(C.CLI_CODCLI, "-", C.CLI_NOMCLI) AS CLIENTE,'+
            '  C.CLI_FONE01 AS FONE01,'+
            '  C.CLI_EMAIL_ AS EMAIL1,'+

            '       R.CTR_DTACAD AS FGO_DTAENT, ' +
            '       IF(R.CTR_NUMDUP IS NULL, M.MPX_VALPIX, R.CTR_VALORI) AS FGO_VLRCON, ' +
            '       R.CTR_SEQMPX, ' +
            '       R.CTR_TX_PIX, ' +

            'CASE ' +
            '    WHEN M.MPX_STATUS IN ("ATIVACC", "pending", "pendingv", "pendingvCC") ' +
            '      THEN "ATIVA" ' +
            '    WHEN M.MPX_STATUS IN ("approved") ' +
            '      THEN "CONCLUIDA" ' +
            '    ELSE M.MPX_STATUS ' +
            '  END AS MPX_STATUS, ' +

            '       M.MPX_CODEMP, ' +
            '       M.MPX_QRCODE, ' +
            '       M.MPX_LNKCIT, ' +
            '       M.MPX_TX_ID_, ' +
            '       M.MPX_CRIADO, ' +
            '       M.MPX_VALPIX, ' +
            '       M.MPX_DTACAD, ' +
            '       M.MPX_JSOREC, ' +
            '       M.MPX_SEQPIX, ' +
            '       M.MPX_JSOENV, ' +
            '       M.MPX_USASHP, ' +
            '       M.MPX_CHA_CC, ' +
            '       M.AUTOINCREM, ' +
            '       M.MPX_STATUS AS STATUS_REGISTRO, ' +
            '       CONCAT(V.OPE_CODOPE, "-", V.OPE_NOMOPE) AS VENDEDOR, ' +
            '       "CADREC" AS TABELA ' +
            'FROM MOVPIX M ' +
            'LEFT JOIN CADREC R ON R.CTR_SEQMPX=M.AUTOINCREM ' +
            '                  AND R.CTR_SEQBAI=0 ' +
            'LEFT JOIN CADCLI C ON C.CLI_CODCLI=IFNULL(R.CTR_CODCLI, SUBSTRING(M.MPX_CHA_CC, 21, 8)) ' +
            'LEFT JOIN CADOPE V ON V.OPE_CODOPE=IFNULL(R.CTR_CODVEN, SUBSTRING(M.MPX_CHA_CC, 30, 3)) ' +

            'WHERE ' +
            LStatus +
            LDataDoPix +
            LEmpresaPedido +
            LGeradoPelo +
            LVendedor +
            LVendedor2 +
            ' M.MPX_CHA_CC IS NOT NULL ' +
            ' AND M.MPX_TX_ID_ NOT IN (SELECT CTR_TX_PIX FROM CADREC ' +
            '      WHERE CTR_EMPPIX=M.MPX_CODEMP AND CTR_TX_PIX=M.MPX_TX_ID_)';

  Result := Result +
            ' UNION ' +

            'SELECT IFNULL(CONCAT(R.CTR_NUMDUP, R.CTR_PARCEL), "CRÉDITO A SER GERADO") AS FGO_NUMDOC, ' +
            '       IFNULL(R.CTR_ESPDOC, SUBSTRING(M.MPX_CHA_CC, 14, 2)) AS FGO_ESPDOC, ' +
            '       IFNULL(R.CTR_CODEMP, SUBSTRING(M.MPX_CHA_CC, 17, 3)) AS FGO_CODEMP, ' +
            '       IFNULL(R.CTR_CODCLI, SUBSTRING(M.MPX_CHA_CC, 21, 8)) AS FGO_CODCLI, ' +

            '  CONCAT(C.CLI_CODCLI, "-", C.CLI_NOMCLI) AS CLIENTE,'+
            '  C.CLI_FONE01 AS FONE01,'+
            '  C.CLI_EMAIL_ AS EMAIL1,'+

            '       R.CTR_DTACAD AS FGO_DTAENT, ' +
            '       IF(R.CTR_NUMDUP IS NULL, M.MPX_VALPIX, R.CTR_VALORI) AS FGO_VLRCON, ' +
            '       R.CTR_SEQMPX, ' +
            '       R.CTR_TX_PIX, ' +

            'CASE ' +
            '    WHEN M.MPX_STATUS IN ("ATIVACC", "pending", "pendingv", "pendingvCC") ' +
            '      THEN "ATIVA" ' +
            '    WHEN M.MPX_STATUS IN ("approved") ' +
            '      THEN "CONCLUIDA" ' +
            '    ELSE M.MPX_STATUS ' +
            '  END AS MPX_STATUS, ' +

            '       M.MPX_CODEMP, ' +
            '       M.MPX_QRCODE, ' +
            '       M.MPX_LNKCIT, ' +
            '       M.MPX_TX_ID_, ' +
            '       M.MPX_CRIADO, ' +
            '       M.MPX_VALPIX, ' +
            '       M.MPX_DTACAD, ' +
            '       M.MPX_JSOREC, ' +
            '       M.MPX_SEQPIX, ' +
            '       M.MPX_JSOENV, ' +
            '       M.MPX_USASHP, ' +
            '       M.MPX_CHA_CC, ' +
            '       M.AUTOINCREM, ' +
            '       M.MPX_STATUS AS STATUS_REGISTRO, ' +
            '       CONCAT(V.OPE_CODOPE, "-", V.OPE_NOMOPE) AS VENDEDOR, ' +
            '       "CADREC" AS TABELA ' +
            'FROM MOVPIX M ' +
            'LEFT JOIN DUPAGR R ON R.CTR_SEQMPX=M.AUTOINCREM ' +
            'LEFT JOIN CADCLI C ON C.CLI_CODCLI=IFNULL(R.CTR_CODCLI, SUBSTRING(M.MPX_CHA_CC, 21, 8)) ' +
            'LEFT JOIN CADOPE V ON V.OPE_CODOPE=IFNULL(R.CTR_CODVEN, SUBSTRING(M.MPX_CHA_CC, 30, 3)) ' +

            'WHERE ' +
            LStatus +
            LDataDoPix +
            LEmpresaPedido +
            LGeradoPelo +
            LVendedor +
            LVendedor2 +
            ' M.MPX_CHA_CC IS NOT NULL ' +
            ' AND M.MPX_TX_ID_ NOT IN (SELECT CTR_TX_PIX FROM CADREC ' +
            '      WHERE CTR_EMPPIX=M.MPX_CODEMP AND CTR_TX_PIX=M.MPX_TX_ID_)';
end;

function TfrmRelacaoPedidosPixGerados.RetornaSQLPedidos: String;
  Var
    LStatus,
    LDataDoPix,
    LGeradoPelo,
    LEmpresaPedido,
    LVendedor,
    LVendedor2: String;
begin
  LStatus := '';
  Case cmbStatus.ItemIndex Of
    0: LStatus := ' M.MPX_STATUS IN ("ATIVA", "pending", "pendingv") AND ';
    1: LStatus := ' M.MPX_STATUS IN ("CONCLUIDA", "approved") AND ';
  End;

  LGeradoPelo := '';
  Case cmbGeradoPelo.ItemIndex Of
    0: LGeradoPelo := ' (M.MPX_CRIADO IS NULL OR M.MPX_CRIADO="CAIXA") AND ';
    1: LGeradoPelo := ' M.MPX_CRIADO="FATURAMENTO" AND ';
    2: LGeradoPelo := ' M.MPX_CRIADO="FINANCEIRO" AND ';
    3: LGeradoPelo := ' (M.MPX_CRIADO IS NULL OR M.MPX_CRIADO="PEDIDO") AND ';
  End;

  LDataDoPix := '';
  If Not fEmptyStr(mskDtaIni.Text) Then
    LDataDoPix := ' M.MPX_DTACAD BETWEEN "' + FormatDateTime('yyyy/mm/dd', mskDtaIni.Date) + '" AND ' +
                  '                      "' + FormatDateTime('yyyy/mm/dd', mskDtaFin.Date) + '" AND ';

  LEmpresaPedido := '';
  If Not fEmptyStr(edtCodEmp.Text) Then
    LEmpresaPedido := ' M.MPX_CODEMP IN (' + fRetArrToSQLIn(FArrayEmpresa, edtCodEmp.Text) + ') AND '
  Else If Not strEmpAcessoUsuarioLogado.IsEmpty Then
    LEmpresaPedido := ' M.MPX_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') AND ';

  LVendedor := '';
  If Not fEmptyStr(edtCodigoVendedor.Text) Then
    LVendedor := ' F.FGO_CODVEN IN (' + fRetArrToSQLIn(FArrayVendedor, edtCodigoVendedor.Text) + ') AND ';

  LVendedor2 := '';
  If Not fEmptyStr(edtCodigoVendedor2.Text) Then
    LVendedor2 := '((SELECT                                 ' +
                  '  COUNT(FATDOR.FDO_CODVE2) AS FDO_CODVE2 ' +
                  'FROM                                     ' +
                  '  FATDOR                                 ' +
                  'WHERE FATDOR.FDO_SEQGER = F.AUTOINCREM   ' +
                  '  AND  FDO_CODVE2 IN (' + fRetArrToSQLIn(FArrayVendedor2, edtCodigoVendedor2.Text) + ')) > 0) AND ';

  Result := 'SELECT F.FGO_NUMDOC, ' +
            '       F.FGO_ESPDOC, ' +
            '       F.FGO_CODEMP, ' +
            '       F.FGO_CODCLI, ' +

            'CASE'+
            '    WHEN (IFNULL(F.FGO_CGCCON, "") <> "")'+
            '    THEN CONCAT(F.FGO_CODCLI, "-", F.FGO_NOMCON)'+
            '    ELSE CONCAT(F.FGO_CODCLI, "-", C.CLI_NOMCLI)'+
            '  END AS CLIENTE,'+
            '  CASE'+
            '    WHEN (IFNULL(F.FGO_CGCCON, "") <> "")'+
            '    THEN F.FGO_TELCON'+
            '    ELSE C.CLI_FONE01'+
            '  END AS FONE01,'+
            '  CASE'+
            '    WHEN (IFNULL(F.FGO_CGCCON, "") <> "")'+
            '    THEN F.FGO_EMLCON'+
            '    ELSE C.CLI_EMAIL_'+
            '  END AS EMAIL1,'+

            '       F.FGO_DTAENT, ' +
            '       F.FGO_VLRCON, ' +
            '       "" AS CTR_SEQMPX, ' +
            '       G.FGO_TX_PIX AS CTR_TX_PIX, ' +

            'CASE ' +
            '    WHEN M.MPX_STATUS IN ("pending", "pendingv") ' +
            '      THEN "ATIVA" ' +
            '    WHEN M.MPX_STATUS IN ("approved") ' +
            '      THEN "CONCLUIDA" ' +
            '    ELSE M.MPX_STATUS ' +
            '  END AS MPX_STATUS, ' +

            '       M.MPX_CODEMP, ' +
            '       M.MPX_QRCODE, ' +
            '       M.MPX_LNKCIT, ' +
            '       M.MPX_TX_ID_, ' +
            '       "PEDIDO" AS MPX_CRIADO, ' +
            '       M.MPX_VALPIX, ' +
            '       M.MPX_DTACAD, ' +
            '       M.MPX_JSOREC, ' +
            '       M.MPX_SEQPIX, ' +
            '       M.MPX_JSOENV, ' +
            '       M.MPX_USASHP, ' +
            '       M.MPX_CHA_CC, ' +
            '       M.AUTOINCREM, ' +
            '       M.MPX_STATUS AS STATUS_REGISTRO, ' +
            '       CONCAT(V.OPE_CODOPE, "-", V.OPE_NOMOPE) AS VENDEDOR, ' +
            '       "EXTGOR" AS TABELA ' +
            'FROM MOVPIX M ' +
            'JOIN EXTGOR G ON G.FGO_EMPPIX=M.MPX_CODEMP ' +
            '             AND G.FGO_TX_PIX=M.MPX_TX_ID_ ' +
            'JOIN FATGOR F ON F.AUTOINCREM=G.FGO_SEQFGO ' +
            'LEFT JOIN ADTCLI A ON A.ADT_NUMDOC=F.FGO_NUMDOC ' +
            '                  AND A.ADT_ESPDOC=F.FGO_ESPDOC ' +
            '                  AND A.ADT_CODEMP=F.FGO_CODEMP ' +
            '                  AND A.ADT_CODCLI=F.FGO_CODCLI ' +
            '                  AND A.ADT_SEQCON=M.MPX_SEQCON ' +
            '                  AND A.ADT_EMPLAN=M.MPX_CODEMP ' +
            'LEFT JOIN CADCLI C ON C.CLI_CODCLI=F.FGO_CODCLI ' +
            'LEFT JOIN CADOPE V ON V.OPE_CODOPE=F.FGO_CODVEN ' +
            'WHERE ';

  If cmbGeradoPelo.Text = 'Boletos' Then
    Exit(Result + ' FALSE');

  Result := Result +
            LStatus +
            LDataDoPix +
            LEmpresaPedido +
            LGeradoPelo +
            LVendedor +
            LVendedor2 +
            ' ((M.MPX_DTAREC IS NULL AND A.ADT_NUMDOC IS NULL) OR (A.ADT_RECPIX="S")) ';

  Result := Result +
            ' UNION ' +
            'SELECT F.FGO_NUMDOC, ' +
            '       F.FGO_ESPDOC, ' +
            '       F.FGO_CODEMP, ' +
            '       F.FGO_CODCLI, ' +

            'CASE'+
            '    WHEN (IFNULL(F.FGO_CGCCON, "") <> "")'+
            '    THEN CONCAT(F.FGO_CODCLI, "-", F.FGO_NOMCON)'+
            '    ELSE CONCAT(F.FGO_CODCLI, "-", C.CLI_NOMCLI)'+
            '  END AS CLIENTE,'+
            '  CASE'+
            '    WHEN (IFNULL(F.FGO_CGCCON, "") <> "")'+
            '    THEN F.FGO_TELCON'+
            '    ELSE C.CLI_FONE01'+
            '  END AS FONE01,'+
            '  CASE'+
            '    WHEN (IFNULL(F.FGO_CGCCON, "") <> "")'+
            '    THEN F.FGO_EMLCON'+
            '    ELSE C.CLI_EMAIL_'+
            '  END AS EMAIL1,'+

            '       F.FGO_DTAENT, ' +
            '       F.FGO_VLRCON, ' +
            '       "" AS CTR_SEQMPX, ' +
            '       G.FGO_TX_PIX AS CTR_TX_PIX, ' +

            'CASE ' +
            '    WHEN M.MPX_STATUS IN ("pending", "pendingv") ' +
            '      THEN "ATIVA" ' +
            '    WHEN M.MPX_STATUS IN ("approved") ' +
            '      THEN "CONCLUIDA" ' +
            '    ELSE M.MPX_STATUS ' +
            '  END AS MPX_STATUS, ' +

            '       M.MPX_CODEMP, ' +
            '       M.MPX_QRCODE, ' +
            '       M.MPX_LNKCIT, ' +
            '       M.MPX_TX_ID_, ' +
            '       M.MPX_CRIADO, ' +
            '       M.MPX_VALPIX, ' +
            '       M.MPX_DTACAD, ' +
            '       M.MPX_JSOREC, ' +
            '       M.MPX_SEQPIX, ' +
            '       M.MPX_JSOENV, ' +
            '       M.MPX_USASHP, ' +
            '       M.MPX_CHA_CC, ' +
            '       M.AUTOINCREM, ' +
            '       M.MPX_STATUS AS STATUS_REGISTRO, ' +
            '       CONCAT(V.OPE_CODOPE, "-", V.OPE_NOMOPE) AS VENDEDOR, ' +
            '       "EXTGOR" AS TABELA ' +
            'FROM MOVPIX M ' +
            'JOIN ADTCLI A ON A.ADT_SEQCON=M.MPX_SEQCON ' +
            '             AND A.ADT_EMPLAN=M.MPX_CODEMP ' +
            '             AND A.ADT_RECPIX="S" ' +
            'JOIN FATGOR F ON F.FGO_NUMDOC=A.ADT_NUMDOC ' +
            '             AND F.FGO_CODEMP=A.ADT_CODEMP ' +
            '             AND F.FGO_CODCLI=A.ADT_CODCLI ' +
            'LEFT JOIN EXTGOR G ON G.FGO_EMPPIX=M.MPX_CODEMP ' +
            '                  AND G.FGO_TX_PIX=M.MPX_TX_ID_ ' +
            'LEFT JOIN CADCLI C ON C.CLI_CODCLI=F.FGO_CODCLI ' +
            'LEFT JOIN CADOPE V ON V.OPE_CODOPE=F.FGO_CODVEN ' +
            'WHERE ' +
            LStatus +
            LDataDoPix +
            LEmpresaPedido +
            LGeradoPelo +
            LVendedor +
            LVendedor2 +
            ' G.FGO_TX_PIX IS NULL ';
end;

function TfrmRelacaoPedidosPixGerados.TravarRegistroDoPix(
  ATravar: Boolean): Boolean;
begin
  Result := fLock_Unlock('CONSULTA_RECEBIMENTO_PIX_' + FDataSetPedidos.FieldByName('MPX_TX_ID_').AsString,
                         ATravar,
                         False,
                         False,
                         '',
                         False);
end;

function TfrmRelacaoPedidosPixGerados.ValidacoesMensagensRemoverPix: Boolean;
  Var
    LListaDocumentos,
    LMensagem: String;
begin
  Result := True;

  If Not Assigned(FDatasetPedidos.FindField('TABELA')) Then
    Exit(False);

  LMensagem := 'Deseja realmente remover o Pix do documento selecionado?';

  If FDatasetPedidos.FieldByName('TABELA').AsString = 'EXTGOR' Then
  Begin
    If TPixDao.PixGeradoEmPedidosDesmembrados(FDatasetPedidos.FieldByName('MPX_CODEMP').AsString,
                                              FDatasetPedidos.FieldByName('MPX_TX_ID_').AsString,
                                              LListaDocumentos) Then
      LMensagem := 'Esse pedido foi desmembrado e o Pix está vinculado aos pedidos: ' +
                   LListaDocumentos + #13 +
                   'Deseja continuar com a exclusão do Pix dos pedidos?';

  End
  Else
  Begin
    If Not FDatasetPedidos.FieldByName('MPX_CHA_CC').AsString.IsEmpty Then
    Begin
      If Not TCreditoClientePixAutcom.ValidarPixGeradoAtravesCredito(FDatasetPedidos) Then
        Exit(False);
    End
    Else If TPixDao.PixGeradoParaVariasDuplicatas(FDatasetPedidos.FieldByName('MPX_CODEMP').AsString,
                                                  FDatasetPedidos.FieldByName('MPX_TX_ID_').AsString,
                                                  LListaDocumentos) Then
      LMensagem := 'Essa duplicata possui um Pix que está vinculado aos documentos: ' +
                   LListaDocumentos + #13 +
                   'Deseja continuar com a exclusão do Pix das duplicatas?';
  End;

  If Not TCreditoClientePixAutcom.FChaveLCKATC.IsEmpty Then
  Begin
    Result := fLock_Unlock(TCreditoClientePixAutcom.FChaveLCKATC,
                           True,
                           False,
                           False);

    If Not Result Then
    Begin
      fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(TCreditoClientePixAutcom.FChaveLCKATC), ['&Ok']);
      TCreditoClientePixAutcom.FChaveLCKATC := EmptyStr;
      Exit;
    End;
  End;

  If fMensagem('ATENÇÃO', LMensagem, ['&Sim', '&Não'], 2) = 2 Then
    Exit(False);

  If Not LiberaRemocaoPixGerado(LListaDocumentos) Then
    Exit(False);
end;

procedure TfrmRelacaoPedidosPixGerados.ValidaConsultaPix;
  Var
   LGravando : TfrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando, LGravando);
    LGravando.fExecutarAcao := RetiraRegistrosPixDuplicados;
    LGravando.lblGravando.Caption := 'Aguarde... Validando Consulta.';
    LGravando.ShowModal;
  Finally
    FreeAndNil(LGravando);
  End;
end;

function TfrmRelacaoPedidosPixGerados.ValidarGeracaoDeCCPix: Boolean;
begin
  If Not btnGerarCreditoCliente.Visible Then
    Exit(False);

  If fEmptyStr(fCfgSis('PORCCP', varString)) Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário escolher um portador na configuração "CFG_PORCCP" para gerar a cobrança.', ['&Ok']);
    Exit(False);
  End;

  If fCfgSis('EVE_CC', varBoolean) Then
  Begin
    If fEmptyStr(fCfgSis('EVECCP', varString)) Then
    Begin
      fMensagem('ATENÇÃO', 'É necessário escolher um centro de custos na configuração "CFG_EVECCP" para gerar a cobrança.', ['&Ok']);
      Exit(False);
    End;
  End;

  Result := fMensagem('ATENÇÃO', 'Essa rotina gerará uma cobrança Pix para criar um crédito ao cliente após o recebimento.' + #13 +
                                 'Deseja realmente gerar o Pix e enviar ao cliente?',
                                 ['&Sim', '&Não'], 2) = 1;
end;

procedure TfrmRelacaoPedidosPixGerados.VerificacaoSistemaVerdeVermelho;
begin
  If Not FLiberadoOutrosVendedores Then
  Begin
    shaVendedor.Brush.Color := clRed;
    edtCodigoVendedor.Text := strLoginUsuarioLogado;
    fValidaCampos(edtCodigoVendedor, True);

    edtCodigoVendedor.Enabled := False;
  End
  Else
    shaVendedor.Brush.Color := clGreen;

  If pnlVendedor2.Visible Then
  Begin
    If Not FLiberadoOutrosVendedores2 Then
    Begin
      shaVendedor2.Brush.Color := clRed;
      edtCodigoVendedor2.Text := strLoginUsuarioLogado;
      fValidaCampos(edtCodigoVendedor2, True);

      edtCodigoVendedor2.Enabled := False;
    End
    Else
      shaVendedor2.Brush.Color := clGreen;
  End;

  If Not fVerificaAcessoSistema('PERFILEMPPIXGER') Then
  Begin
    shaEmpresa.Brush.Color := clRed;
    edtCodEmp.Text := VS_strCodEmp;
    edtCodEmp.OnExit(edtCodEmp);

    edtCodEmp.Enabled := False;
  End
  Else
    shaEmpresa.Brush.Color := clGreen;
end;

end.
