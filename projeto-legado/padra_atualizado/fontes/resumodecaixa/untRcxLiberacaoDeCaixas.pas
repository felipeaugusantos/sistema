unit untRcxLiberacaoDeCaixas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCalendar, cxCurrencyEdit, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel,
  cxGrid, ComboBoxFocus, EditFocus, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  Uni, UniClientDataSet, cxProgressBar, StrUtils, untTypesSistema,
  cxGridBandedTableView, cxGridDBBandedTableView, cxButtonEdit,
  cxEditRepositoryItems, untRcxTLiberacaoDeCaixas;

type
  TfrmRcxLiberacaoDeCaixas = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    edtDataInicial: TcxDateEdit;
    edtCodigoCaixa: TEditFocus;
    edtDescricaoCaixa: TEditFocus;
    edtCodigoOperador: TEditFocus;
    edtNomeOperador: TEditFocus;
    btnCarregarLancamentos: TBitBtnLocked;
    Label4: TLabel;
    edtDataFinal: TcxDateEdit;
    Label5: TLabel;
    cmbFechamento: TComboBoxFocus;
    Label6: TLabel;
    cmbStatus: TComboBoxFocus;
    pnlDados: TPanel;
    grdLancamentos: TcxGridCitel;
    grdLancamentosDados: TcxGridDBTableViewCitel;
    grdLancamentosDadosCAIXA: TcxGridDBColumn;
    grdLancamentosDadosOPERADOR: TcxGridDBColumn;
    grdLancamentosDadosRCX_NUMLAC: TcxGridDBColumn;
    grdLancamentosDadosRCX_DTACAD: TcxGridDBColumn;
    grdLancamentosDadosRCX_VALDIV: TcxGridDBColumn;
    grdLancamentosDadosRCX_MARDES: TcxGridDBColumn;
    grdLancamentosNivel: TcxGridLevel;
    grdLancamentosDadosRCX_DTAPER: TcxGridDBColumn;
    grdLancamentosDadosRCX_OPEPER: TcxGridDBColumn;
    grdLancamentosDadosRCX_STATUS: TcxGridDBColumn;
    pnlTotais: TPanel;
    Label7: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edtQtdLancamentos: TEditFocus;
    edtValorLancamentos: TEditFocus;
    edtQtdSelecionados: TEditFocus;
    edtLancamentosSel: TEditFocus;
    edtValorDivergente: TEditFocus;
    edtValorDivergenteSel: TEditFocus;
    btnDesmarcarTodos: TBitBtnLocked;
    BtnMarcarTodos: TBitBtnLocked;
    btnLiberar: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    grdLancamentosDadosRCX_VALDOC: TcxGridDBColumn;
    grdLancamentosDadosRCX_OPELIB: TcxGridDBColumn;
    grdLancamentosDadosRCX_DTALIB: TcxGridDBColumn;
    btnExportarCSV: TBitBtnLocked;
    chkLimparFiltros: TCheckBox;
    dlgSalvarCSV: TSaveDialog;
    gpbTransferencias: TGroupBox;
    gpbLegenda: TGroupBox;
    Shape3: TShape;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Shape4: TShape;
    Label19: TLabel;
    Label20: TLabel;
    Shape5: TShape;
    Label21: TLabel;
    lblValorTransferencia: TLabel;
    edtValorTransferencia: TEditFocus;
    lblDinheiroTransferencia: TLabel;
    edtDinheiroTransferencia: TEditFocus;
    lblCartaoTransferencia: TLabel;
    edtCartaoTransferencia: TEditFocus;
    lblChequeAVistaTransferencia: TLabel;
    edtChequeAVistaTransferencia: TEditFocus;
    lblChequePreTransferencia: TLabel;
    edtChequePreTransferencia: TEditFocus;
    lblOrdemPagamentoTransferencia: TLabel;
    edtOrdemPagamentoTransferencia: TEditFocus;
    grdLancamentosLevelTF: TcxGridLevel;
    grdLancamentosDadosTFs: TcxGridDBTableViewCitel;
    grdLancamentosDadosTFsMODALIDADE: TcxGridDBColumn;
    grdLancamentosDadosTFsVALOR: TcxGridDBColumn;
    grdLancamentosDadosTFsRCX_CODOPE: TcxGridDBColumn;
    grdLancamentosDadosTFsRCX_SEQCON: TcxGridDBColumn;
    grdLancamentosDadosTFsRCX_STATUS: TcxGridDBColumn;
    grdLancamentosDadosTFsDOCUMENTOS: TcxGridDBColumn;
    reqEditor: TcxEditRepository;
    reqEditorbtnDocumentos: TcxEditRepositoryButtonItem;
    reqEditortxtTexto: TcxEditRepositoryTextItem;
    reqEditorbtnAcoes: TcxEditRepositoryButtonItem;
    grdLancamentosDadosTFsACOES: TcxGridDBColumn;
    reqEditorbtnAcoesDivergencia: TcxEditRepositoryButtonItem;
    reqEditorbtnAcaoAceitar: TcxEditRepositoryButtonItem;
    grdLancamentosDadosTFsVALORSELECIONADO: TcxGridDBColumn;
    grdLancamentosDadosTFsTRF_OPELIB: TcxGridDBColumn;
    grdLancamentosDadosTFsTRF_DTALIB: TcxGridDBColumn;
    grdLancamentosDadosTFsTRF_MOTIVO: TcxGridDBColumn;
    reqEditorbtnAcoesDisabled: TcxEditRepositoryButtonItem;
    reqEditorbtnAcaoAceitarDisabled: TcxEditRepositoryButtonItem;
    reqEditorbtnAcoesDivergenciaDisabled: TcxEditRepositoryButtonItem;
    reqEditorbtnDocumentosDisabled: TcxEditRepositoryButtonItem;
    btnAjuda: TBitBtnLocked;
    lblEmpresa: TLabel;
    edtCodigoEmpresa: TEditFocus;
    edtNomeEmpresa: TEditFocus;
    grdLancamentosDadosEMPRESA: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure btnCarregarLancamentosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdLancamentosDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdLancamentosDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodigoCaixaKeyPress(Sender: TObject; var Key: Char);
    procedure BtnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure btnLiberarClick(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure btnExportarCSVClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdLancamentosDadosTFsDOCUMENTOSGetProperties(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure reqEditorbtnDocumentosPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure grdLancamentosDadosTFsACOESGetProperties(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure reqEditorbtnAcaoAceitarPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure grdLancamentosDadosTFsCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure reqEditorbtnAcoesPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure reqEditorbtnAcoesDivergenciaPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnAjudaClick(Sender: TObject);
    procedure edtCodigoEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoEmpresaExit(Sender: TObject);
  private
    { Private declarations }
    cdsLancamentos,
    FTransferencias: TUniClientDataSet;

    blnExibirLacre: Boolean;

    FAutenticacaoTransferencias: Boolean;

    FExibeDinheiro,
    FExibeCartao,
    FExibeChequeAVista,
    FExibeChequePre,
    FExibeOrdemPagamento,
    FExibeDivergencia: Boolean;

    FprcScroll: TprcScroll;

    FLiberacaoDeCaixas: TLiberacaoDeCaixas;

    FEmpresasArray: TConsultasArray;

    procedure pCriaTemporaria;
    procedure pCriaAggregateFields;
    procedure pExibeTotalLancamentos;
    procedure pLimparDados;

    procedure pSelecionarLancamentos(blnTodosLancamentos: Boolean = False; blnDesmarcar: Boolean = False);

    function ExisteTransferenciasPendentes: Boolean;

    function fMarcarLancamentos(prgStatus: TcxProgressBar): Boolean;
    function fDesmarcarLancamentos(prgStatus: TcxProgressBar): Boolean;

    procedure pCarregaOperador;
    procedure pCarregaCaixa;
    procedure CarregaEmpresa;

    function fLiberarLancamentos(prgStatus: TcxProgressBar): Boolean;
    function fRestaurarLancamentos(prgStatus: TcxProgressBar): Boolean;

    function fExportarCSV(prgStatus: TcxProgressBar): Boolean;

    procedure AfterScrollDataset(Dataset: TDataset);

    procedure UtilizacaoAutenticacaoTransferencias;

    procedure DeterminaFechamentosTFs;

    function ValidarValorSelecionadoDocumentosVinculados: Boolean;

    function TravouFechamentoCaixa: Boolean;
    procedure DestravaFechamentoCaixa;

    procedure AceitarModalidadeVinculada;
    procedure AceitarModalidadeDivergencia;
    procedure RecusarModalidadeDivergencia;
    procedure AjustarModalidadeDivergencia;
    procedure AceitarModalidadePortador;
    procedure RecusarModalidade;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    { Protected declarations }
  end;

implementation
Uses untGravando, untFuncoesSimples, untConsultas, untPesqAux,
     untRcxTResumoDeCaixa, untLiberacao, untRcxLiberacaoDeCaixasDocumentosTF,
     untRcxLiberacaoDeCaixasRel, untFuncoesConsulta;

{$R *.dfm}

procedure TfrmRcxLiberacaoDeCaixas.btnExportarCSVClick(Sender: TObject);
  Var
    frmAguarde: TfrmGravando;
begin
  inherited;
  If (cdsLancamentos.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário selecionar registros para utilizar essa função.', ['&OK']);
    Exit;
  End;

  If (fMensagem('CONFIRMAÇÃO', 'Deseja realmente exportar todos os lançamentos para um arquivo CSV?', ['&Sim', '&Não']) = 2) Then
    Exit;

  pCriarFormularios(TfrmGravando,frmAguarde);
  frmAguarde.fExecutarAcao := fExportarCSV;
  frmAguarde.lblGravando.Caption := 'Aguarde... Exportando registros.';
  frmAguarde.ShowModal;
  pFreeAndNil(frmAguarde);
end;

procedure TfrmRcxLiberacaoDeCaixas.AceitarModalidadeDivergencia;
  Var
    LTravou: Boolean;
begin
  inherited;
  LTravou := False;

  Try
    Try
      If fMensagem('ATENÇÃO', 'Deseja realmente aceitar o valor de ' + FormatFloat(',0.00', FTransferencias.FieldByName('VALOR').AsFloat) +
                              ' na modalidade ' + FTransferencias.FieldByName('MODALIDADE').AsString + '?',
                              ['&Sim', '&Não']) = 2 Then
        Exit;

      LTravou := TravouFechamentoCaixa;
      If LTravou Then
        FLiberacaoDeCaixas.AceitarModalidadeDivergencia(FTransferencias);
    Finally
      If LTravou Then
        DestravaFechamentoCaixa;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[FLiberacaoDeCaixas.AceitarModalidadeDivergencia]');
  End;
end;

procedure TfrmRcxLiberacaoDeCaixas.AceitarModalidadePortador;
  Var
    LTravou: Boolean;
begin
  inherited;
  LTravou := False;

  Try
    Try
      If fMensagem('ATENÇÃO', 'Deseja realmente aceitar o valor de ' + FormatFloat(',0.00', FTransferencias.FieldByName('VALOR').AsFloat) +
                              ' na modalidade ' + FTransferencias.FieldByName('MODALIDADE').AsString + '?',
                              ['&Sim', '&Não']) = 2 Then
        Exit;

      LTravou := TravouFechamentoCaixa;
      If LTravou Then
        FLiberacaoDeCaixas.AceitarModalidadePortador(FTransferencias);
    Finally
      If LTravou Then
        DestravaFechamentoCaixa;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[FLiberacaoDeCaixas.AceitarModalidadePortador]');
  End;
end;

procedure TfrmRcxLiberacaoDeCaixas.AceitarModalidadeVinculada;
  Var
    LTravou: Boolean;
begin
  inherited;
  If Not ValidarValorSelecionadoDocumentosVinculados Then
    Exit;

  If fMensagem('ATENÇÃO', 'Deseja realmente aceitar o valor de ' + FormatFloat(',0.00', FTransferencias.FieldByName('VALOR').AsFloat) +
                          ' na modalidade ' + FTransferencias.FieldByName('MODALIDADE').AsString + '?',
                          ['&Sim', '&Não']) = 2 Then
    Exit;

  LTravou := False;

  Try
    Try
      LTravou := TravouFechamentoCaixa;
      If LTravou Then
        FLiberacaoDeCaixas.AceitarModalidadeVinculada(FTransferencias);
    Finally
      If LTravou Then
        DestravaFechamentoCaixa;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[FLiberacaoDeCaixas.AceitarModalidadeVinculada]');
  End;
end;

procedure TfrmRcxLiberacaoDeCaixas.AfterScrollDataset(Dataset: TDataset);
begin
  edtValorTransferencia.Clear;
  edtDinheiroTransferencia.Clear;
  edtCartaoTransferencia.Clear;
  edtChequeAVistaTransferencia.Clear;
  edtChequePreTransferencia.Clear;
  edtOrdemPagamentoTransferencia.Clear;

  If Not cdsLancamentos.IsEmpty Then
  Begin
    edtValorTransferencia.Text := FormatFloat(',0.00', cdsLancamentos.FieldByName('RCX_VALTRA').AsFloat);
    edtDinheiroTransferencia.Text := FormatFloat(',0.00', cdsLancamentos.FieldByName('RCX_DINREC').AsFloat);
    edtCartaoTransferencia.Text := FormatFloat(',0.00', cdsLancamentos.FieldByName('RCX_CARREC').AsFloat);
    edtChequeAVistaTransferencia.Text := FormatFloat(',0.00', cdsLancamentos.FieldByName('RCX_CHQAVI').AsFloat);
    edtChequePreTransferencia.Text := FormatFloat(',0.00', cdsLancamentos.FieldByName('RCX_CHQPRE').AsFloat);
    edtOrdemPagamentoTransferencia.Text := FormatFloat(',0.00', cdsLancamentos.FieldByName('RCX_ORDREC').AsFloat);
  End;
end;

procedure TfrmRcxLiberacaoDeCaixas.AjustarModalidadeDivergencia;
  Var
    LTravou: Boolean;
begin
  inherited;
  LTravou := False;

  Try
    Try
      If fMensagem('ATENÇÃO', 'Deseja realmente ajustar o valor de ' + FormatFloat(',0.00', FTransferencias.FieldByName('VALOR').AsFloat) +
                              ' na modalidade ' + FTransferencias.FieldByName('MODALIDADE').AsString + '?',
                              ['&Sim', '&Não']) = 2 Then
        Exit;

      LTravou := TravouFechamentoCaixa;
      If LTravou Then
        FLiberacaoDeCaixas.AjustarValorDivergenciaCaixa(FTransferencias);
    Finally
      If LTravou Then
        DestravaFechamentoCaixa;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[FLiberacaoDeCaixas.AjustarValorDivergenciaCaixa]');
  End;
end;

procedure TfrmRcxLiberacaoDeCaixas.btnAjudaClick(Sender: TObject);
  Var
    LRcxLiberacaoDeCaixasRel: TfrmRcxLiberacaoDeCaixasRel;
begin
  inherited;
  Try
    pCriarFormularios(TfrmRcxLiberacaoDeCaixasRel, LRcxLiberacaoDeCaixasRel);
    pPreviewReport(Self.Name, Self.Caption + ' (Help)', LRcxLiberacaoDeCaixasRel.frxLiberacaoAjuda);
  Finally
    FreeAndNil(LRcxLiberacaoDeCaixasRel);
  End;
end;

procedure TfrmRcxLiberacaoDeCaixas.btnCarregarLancamentosClick(
  Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  TfrmGravando.fExecutarModal(pCriaTemporaria, 'Aguarde... Consultando fechamentos.', '');

  If cdsLancamentos.IsEmpty Then
    fMensagem('AVISO', 'Nenhum fechamento encontrado.', ['&OK']);
end;

procedure TfrmRcxLiberacaoDeCaixas.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  pSelecionarLancamentos(True, True);
end;

procedure TfrmRcxLiberacaoDeCaixas.btnLiberarClick(Sender: TObject);
  Var
    frmGravando: TfrmGravando;
begin
  inherited;
  If (cdsLancamentos.IsEmpty) Or (fIntAggregate(cdsLancamentos, 'TOT_QTDSEL') <= 0) Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário selecionar registros de fechamento para utilizar essa função.', ['&OK']);
    Exit;
  End;

  If Not fVerPermissaoOperador('LIBRCXLIBCAX', strLoginUsuarioLogado) Then
  Begin
    fMensagem('ATENÇÃO', 'Usuário sem permissão para liberar os caixas', ['&OK']);
    Exit;
  End;

  If cdsLancamentos.Locate('RCX_MARDES;RCX_STATUS', VarArrayOf(['M', 'LIBERADO']), []) Then
  Begin
    fMensagem('ATENÇÃO', 'Para utilizar essa função, não pode conter registros com status "LIBERADO" selecionados.', ['&OK']);
    Exit;
  End;

  If (fMensagem('CONFIRMAÇÃO', 'Deseja realmente liberar os lançamentos selecionados?', ['&Sim', '&Não']) = 2) Then
    Exit;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Aguarde... Liberando lançamentos.';
    frmGravando.pgbStatus.Visible   := False;
    frmGravando.fExecutarAcao       := fLiberarLancamentos;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;
end;

procedure TfrmRcxLiberacaoDeCaixas.BtnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  pSelecionarLancamentos(True);
end;

procedure TfrmRcxLiberacaoDeCaixas.btnRestaurarClick(Sender: TObject);
  Var
    frmGravando: TfrmGravando;
begin
  inherited;
  If (cdsLancamentos.IsEmpty) Or (fIntAggregate(cdsLancamentos, 'TOT_QTDSEL') <= 0) Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário selecionar registros de fechamento para utilizar essa função.', ['&OK']);
    Exit;
  End;

  If Not fVerPermissaoOperador('LIBRCXLIBCAX', strLoginUsuarioLogado) Then
  Begin
    fMensagem('ATENÇÃO', 'Usuário sem permissão para restaurar as liberações dos caixas', ['&OK']);
    Exit;
  End;

  If cdsLancamentos.Locate('RCX_MARDES;RCX_STATUS', VarArrayOf(['M', 'PENDENTE']), []) Then
  Begin
    fMensagem('ATENÇÃO', 'Para utilizar essa função, não pode conter registros com status "PENDENTE" selecionados.', ['&OK']);
    Exit;
  End;

  If (fMensagem('CONFIRMAÇÃO', 'Deseja realmente restaurar os lançamentos selecionados?', ['&Sim', '&Não']) = 2) Then
    Exit;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Aguarde... Restaurando lançamentos.';
    frmGravando.pgbStatus.Visible   := False;
    frmGravando.fExecutarAcao       := fRestaurarLancamentos;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;
end;

procedure TfrmRcxLiberacaoDeCaixas.CarregaEmpresa;
begin
  edtNomeEmpresa.Text := '+1';

  If edtCodigoEmpresa.Text <> '000' Then
    edtNomeEmpresa.Text := fRetNomeEmpresaSelec(edtCodigoEmpresa.Text);
end;

procedure TfrmRcxLiberacaoDeCaixas.DestravaFechamentoCaixa;
begin
  fLock_Unlock(TResumoDeCaixa.Create('C')
                             .fRetornaTextoDaTravaDoFechamento(FTransferencias.FieldByName('RCX_CODCAX').AsString),
               False);
end;

procedure TfrmRcxLiberacaoDeCaixas.DeterminaFechamentosTFs;
begin
  Try
    cdsLancamentos.IndexFieldNames := 'AUTOINCREM;RCX_DTAGRV;RCX_CODEMP;RCX_CODCAX';

    FTransferencias.Filter := 'MODALIDADE<>''Nenhum'' ';
    FTransferencias.Filtered := True;

    FTransferencias.First;

    While Not FTransferencias.Eof Do
    Begin
      If FTransferencias.FieldByName('MODALIDADE').AsString = 'Dvergência' Then
      Begin
        FTransferencias.Next;

        Continue;
      End;

      cdsLancamentos.Filter := 'RCX_DTACAD=' + FTransferencias.FieldByName('RCX_DTACAD').AsString.QuotedString + ' AND ' +
                               'RCX_DTAGRV>=' + FTransferencias.FieldByName('RCX_DTAGRV').AsString.QuotedString + ' AND ' +
                               'RCX_CODEMP=' + FTransferencias.FieldByName('RCX_CODEMP').AsString.QuotedString + ' AND ' +
                               'RCX_CODCAX=' + FTransferencias.FieldByName('RCX_CODCAX').AsString.QuotedString;
      cdsLancamentos.Filtered := True;
      cdsLancamentos.First;

      FTransferencias.Edit;
      FTransferencias.FieldByName('AUTOINCREM_FEC').AsString := cdsLancamentos.FieldByName('AUTOINCREM').AsString;
      FTransferencias.Post;

      FTransferencias.Next;
    End;
  Finally
    cdsLancamentos.Filter := '';
    cdsLancamentos.Filtered := False;

    FTransferencias.IndexFieldNames := 'AUTOINCREM_FEC;RCX_DTAGRV;RCX_CODEMP;RCX_CODCAX';

    cdsLancamentos.First;
  End;
end;

procedure TfrmRcxLiberacaoDeCaixas.edtCodigoCaixaKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrCaixa: TConsultasArray;
begin
  inherited;
  If fPesqCaixas(Self, edtCodigoCaixa, edtDescricaoCaixa, Nil, Key, arrCaixa, True, '', True) Then
  Begin
    If fValidaCampos(edtCodigoCaixa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRcxLiberacaoDeCaixas.edtCodigoEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodigoEmpresa, edtNomeEmpresa, FEmpresasArray, fRetNomeEmpresa, Nil, 'da Empresa');
end;

procedure TfrmRcxLiberacaoDeCaixas.edtCodigoEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodigoEmpresa, edtNomeEmpresa, Nil, Key, FEmpresasArray, False, True) Then
  Begin
    If fValidaCampos(edtCodigoEmpresa) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRcxLiberacaoDeCaixas.ExisteTransferenciasPendentes: Boolean;
  Var
    LTransferenciasPendentes: TUniQuery;
begin
  Result := False;

  If Not FAutenticacaoTransferencias Then
    Exit;

  Try
    LTransferenciasPendentes := fCriaQuery;
    LTransferenciasPendentes.SQL.Text := FLiberacaoDeCaixas.RetornaSQLTransferenciasFechamento(cdsLancamentos.FieldByName('AUTOINCREM').AsString);
    LTransferenciasPendentes.Open;

    LTransferenciasPendentes.Filter := 'MODALIDADE<>''Nenhum'' ';
    LTransferenciasPendentes.Filtered := True;

    Result := Not LTransferenciasPendentes.IsEmpty;
  Finally
    FreeAndNil(LTransferenciasPendentes);
  End;
end;

function TfrmRcxLiberacaoDeCaixas.fDesmarcarLancamentos(
  prgStatus: TcxProgressBar): Boolean;
  Var
    strAutoincrem: String;
Begin
  strAutoIncrem := cdsLancamentos.FieldByName('AUTOINCREM').AsString;

  pDisableControls(cdsLancamentos, FprcScroll);

  prgStatus.Properties.Max := cdsLancamentos.RecordCount;
  cdsLancamentos.First;
  While Not cdsLancamentos.Eof Do
  Begin
    cdsLancamentos.Edit;

    cdsLancamentos.FieldByName('RCX_MARDES').AsString  := 'D';
    cdsLancamentos.FieldByName('RCX_QTDSEL').AsInteger := 0;
    cdsLancamentos.FieldByName('RCX_DOCSEL').AsFloat   := 0.00;
    cdsLancamentos.FieldByName('RCX_DIVSEL').AsFloat   := 0.00;

    cdsLancamentos.Post;

    cdsLancamentos.Next;

    prgStatus.Position := prgStatus.Position + 1;
  End;

  cdsLancamentos.Filter   := '';
  cdsLancamentos.Filtered := False;

  Result := cdsLancamentos.Locate('AUTOINCREM', strAutoIncrem, []);

  pEnableControls(cdsLancamentos, FprcScroll);
  cdsLancamentos.AfterScroll := AfterScrollDataset;
end;

function TfrmRcxLiberacaoDeCaixas.fExportarCSV(
  prgStatus: TcxProgressBar): Boolean;
  Var
    txtTexto : TextFile;

    strLinha,
    strNomeDoArquivo: String;
begin
  prgStatus.Position := 0;
  prgStatus.Properties.Max :=  cdsLancamentos.RecordCount;

  dlgSalvarCSV.FileName := '';
  If Not dlgSalvarCSV.Execute Then
    Exit(False);

  strNomeDoArquivo := dlgSalvarCSV.FileName;
  If RightStr(strNomeDoArquivo, 4).ToUpper <> '.CSV' Then
    strNomeDoArquivo := strNomeDoArquivo + '.CSV';

  If FileExists(strNomeDoArquivo) And
     (fMensagem('ATENÇÃO', 'Este arquivo já existe na pasta selecionada. Deseja sobrepor o arquivo existente?', ['&Sim', '&Não'], 1) = 2) Then
    Exit(False);

  pDisableControls(cdsLancamentos, FprcScroll);

  Try
    AssignFile(txtTexto, strNomeDoArquivo);
    Rewrite(txtTexto);
  Except
    fMensagem('ATENÇÃO', 'Erro ao criar o arquivo. Verifique se esse não está aberto em outro programa.', ['&OK']);
    Exit(False);
  End;

  strLinha := 'Caixa;Operador;Data do Fechamento;Valor do Lançamento;Valor Divergente;' +
              IIF(blnExibirLacre, 'Núm. Lacre;', '') +
              'Permitido por;Data/Hora Permissão;Status;Liberado por;Data/Hora Liberação';
  Writeln(txtTexto,strLinha);

  cdsLancamentos.First;
  While Not cdsLancamentos.Eof Do
  Begin
    strLinha := cdsLancamentos.FieldByName('CAIXA').AsString + ';' +
                cdsLancamentos.FieldByName('EMPRESA').AsString + ';' +
                cdsLancamentos.FieldByName('OPERADOR').AsString + ';' +
                FormatDateTime('dd/mm/yyyy', cdsLancamentos.FieldByName('RCX_DTACAD').AsDateTime) + ';' +
                FormatFloat(',0.00', cdsLancamentos.FieldByName('RCX_VALDOC').AsFloat) + ';' +
                FormatFloat('-,0.00;,0.00', cdsLancamentos.FieldByName('RCX_VALDIV').AsFloat) + ';' +
                IIF(blnExibirLacre, cdsLancamentos.FieldByName('RCX_NUMLAC').AsString + ';', '') +
                cdsLancamentos.FieldByName('RCX_OPEPER').AsString + ';' +
                IIF(cdsLancamentos.FieldByName('RCX_DTAPER').IsNull,
                    '',
                    FormatDateTime('dd/mm/yyyy hh:mm:ss', cdsLancamentos.FieldByName('RCX_DTAPER').AsDateTime)) + ';' +
                cdsLancamentos.FieldByName('RCX_STATUS').AsString + ';' +
                cdsLancamentos.FieldByName('RCX_OPELIB').AsString + ';' +
                IIF(cdsLancamentos.FieldByName('RCX_DTALIB').IsNull,
                    '',
                    FormatDateTime('dd/mm/yyyy hh:mm:ss', cdsLancamentos.FieldByName('RCX_DTALIB').AsDateTime));

    Writeln(txtTexto,strLinha);

    cdsLancamentos.Next;
  End;
  cdsLancamentos.First;

  CloseFile(txtTexto);

  Result := True;

  fMensagem('AVISO', 'Registros exportados com sucesso.', ['&OK']);

  pEnableControls(cdsLancamentos, FprcScroll);
  cdsLancamentos.AfterScroll := AfterScrollDataset;
end;

function TfrmRcxLiberacaoDeCaixas.fLiberarLancamentos(
  prgStatus: TcxProgressBar): Boolean;
  Var
    objLiberacao: TLiberacao;
begin
  objLiberacao := TLiberacao.Create;
  objLiberacao.objMsgLibera.pAddTexto('Liberação de fechamentos de caixa.');

  objLiberacao.strDirAce := 'LIBRCXLIBCAX';
  objLiberacao.strMsgSen := 'Liberação de fechamentos de caixa.';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;

  Result := objLiberacao.fLibera;

  FreeAndNil(objLiberacao);

  If Not Result Then
    Exit(False);

  pDisableControls(cdsLancamentos, FprcScroll);

  Try
    Result := TResumoDeCaixa.fRealizarLiberacaoDeFechamentos(cdsLancamentos, True, prgStatus);
    If Result Then
      fMensagem('AVISO', 'Fechamentos liberados com sucesso!', ['&OK']);
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro('Ocorreu um erro ao liberar os fechamentos. ' + #13 +
                     'Erro gerado: ' + E.Message, '[TfrmRcxLiberacaoDeCaixas.fLiberarLancamentos]');
    End;

  End;

  pLimparDados;

  pEnableControls(cdsLancamentos, FprcScroll);
  cdsLancamentos.AfterScroll := AfterScrollDataset;

  pSetFocus(edtCodigoCaixa);
end;

function TfrmRcxLiberacaoDeCaixas.fMarcarLancamentos(
  prgStatus: TcxProgressBar): Boolean;
  Var
    strAutoincrem: String;

    prcScroll: TprcScroll;
Begin
  strAutoIncrem := cdsLancamentos.FieldByName('AUTOINCREM').AsString;

  pDisableControls(cdsLancamentos, prcScroll);

  prgStatus.Properties.Max := cdsLancamentos.RecordCount;
  cdsLancamentos.First;
  While Not cdsLancamentos.Eof Do
  Begin
    If ExisteTransferenciasPendentes Then
    Begin
      cdsLancamentos.Next;

      Continue;
    End;

    cdsLancamentos.Edit;

    cdsLancamentos.FieldByName('RCX_MARDES').AsString   := 'M';
    cdsLancamentos.FieldByName('RCX_QTDSEL').AsInteger  := 1;
    cdsLancamentos.FieldByName('RCX_DOCSEL').AsFloat    := fFormataFloat(cdsLancamentos.FieldByName('RCX_VALDOC').AsFloat, 2);
    cdsLancamentos.FieldByName('RCX_DIVSEL').AsFloat    := fFormataFloat(cdsLancamentos.FieldByName('RCX_VALDIV').AsFloat, 2);

    cdsLancamentos.Post;

    cdsLancamentos.Next;

    prgStatus.Position := prgStatus.Position + 1;
  End;

  cdsLancamentos.Filter   := '';
  cdsLancamentos.Filtered := False;

  Result := cdsLancamentos.Locate('AUTOINCREM', strAutoIncrem, []);

  pEnableControls(cdsLancamentos, prcScroll);
  cdsLancamentos.AfterScroll := AfterScrollDataset;
end;

procedure TfrmRcxLiberacaoDeCaixas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Assigned(cdsLancamentos) Then
    FreeAndNil(cdsLancamentos);

  If Assigned(FTransferencias) Then
    FreeAndNil(FTransferencias);

  FreeAndNil(FLiberacaoDeCaixas);
end;

procedure TfrmRcxLiberacaoDeCaixas.FormCreate(Sender: TObject);
begin
  inherited;
  Self.WindowState := wsMaximized;

  FExibeDinheiro := True;
  FExibeCartao := True;
  FExibeChequeAVista := True;
  FExibeChequePre := True;
  FExibeOrdemPagamento := True;
  FExibeDivergencia := True;

  grdLancamentosLevelTF.Visible := False;

  FLiberacaoDeCaixas := TLiberacaoDeCaixas.Create;
end;

procedure TfrmRcxLiberacaoDeCaixas.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
    btnSair.Click
  Else If Key = VK_F7 Then
    btnMarcarTodos.Click
  Else If Key = VK_F8 Then
    btnDesmarcarTodos.Click
  Else If Key = VK_F10 Then
    btnLiberar.Click
  Else If Key = VK_F11 Then
    btnRestaurar.Click
  Else If Key = VK_F12 Then
    btnExportarCSV.Click;
end;

procedure TfrmRcxLiberacaoDeCaixas.FormShow(Sender: TObject);
begin
  inherited;
  cdsLancamentos := TUniClientDataset.Create(Self);
  cdsLancamentos.AggregatesActive := True;
  pCriaAggregateFields;

  blnExibirLacre := fCfgSis('RCXLAC') = 'S';

  edtCodigoEmpresa.Text := VS_strCodEmp;
  fValidaCampos(edtCodigoEmpresa);

  grdLancamentosDadosRCX_NUMLAC.Visible := blnExibirLacre;

  UtilizacaoAutenticacaoTransferencias;

  pSetFocus(edtCodigoCaixa);
end;

function TfrmRcxLiberacaoDeCaixas.fRestaurarLancamentos(
  prgStatus: TcxProgressBar): Boolean;
  Var
    objLiberacao: TLiberacao;
begin
  objLiberacao := TLiberacao.Create;
  objLiberacao.objMsgLibera.pAddTexto('Restaurar liberação de fechamentos de caixa.');

  objLiberacao.strDirAce := 'LIBRCXLIBCAX';
  objLiberacao.strMsgSen := 'Restaurar liberação de fechamentos de caixa.';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;

  Result := objLiberacao.fLibera;

  FreeAndNil(objLiberacao);

  If Not Result Then
    Exit(False);

  pDisableControls(cdsLancamentos, FprcScroll);

  Try
    Result := TResumoDeCaixa.fRealizarLiberacaoDeFechamentos(cdsLancamentos, False, prgStatus);
    If Result Then
      fMensagem('AVISO', 'Fechamentos restaurados com sucesso!', ['&OK']);
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro('Ocorreu um erro ao restaurar os fechamentos. ' + #13 +
                     'Erro gerado: ' + E.Message, '[TfrmRcxLiberacaoDeCaixas.fLiberarLancamentos]');
    End;

  End;

  pLimparDados;

  pEnableControls(cdsLancamentos, FprcScroll);
  cdsLancamentos.AfterScroll := AfterScrollDataset;

  pSetFocus(edtCodigoCaixa);
end;

function TfrmRcxLiberacaoDeCaixas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodigoOperador) Then
    Begin

      pCarregaOperador;
      If (fEmptyStr(edtNomeOperador.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse operador não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodigoCaixa) Then
    Begin

      pCarregaCaixa;
      If (fEmptyStr(edtDescricaoCaixa.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse caixa não está cadastrado!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtCodigoEmpresa) Then
    Begin
      If (fEmptyStr(edtCodigoEmpresa.Text)) Then
      Begin
        edtNomeEmpresa.Clear;
        fMensagem('ATENÇÃO', 'É necessário selecionar uma ou mais empresas para continuar.', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If Not SameText(edtCodigoEmpresa.Text, '000') Then
        Begin
          SetLength(FEmpresasArray, 0);

          CarregaEmpresa;
          If fEmptyStr(edtNomeEmpresa.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
            Result := False;
          End
          Else If Pos(edtCodigoEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = edtDataInicial) Then
    Begin

      If (fEmptyStr(edtDataInicial.Text)) Or (edtDataInicial.Date = 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtDataFinal) Then
    Begin
      Result := (Not blnBuscaPorChave) Or
                (fValidaCampos(edtDataInicial, blnBuscaPorChave));

      If Result Then
      Begin
        If (fEmptyStr(edtDataFinal.Text)) Or (edtDataFinal.Date = 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A data final deve ser preenchida!', ['&Ok']);
          Result := False;
        End
        Else If StrToDate(edtDataInicial.Text) > StrToDate(edtDataFinal.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A data inicial deve ser menor ou igual que a data final!', ['&Ok']);
          Result := False;
        End;
      End;


    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRcxLiberacaoDeCaixas.grdLancamentosDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strMarDes: String;
    strStatus: String;
begin
  inherited;

  If (Not Assigned(cdsLancamentos)) Or (cdsLancamentos.IsEmpty) Then
    Exit;

  strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdLancamentosDadosRCX_MARDES.Index]);
  strStatus := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdLancamentosDadosRCX_STATUS.Index]);

  ACanvas.Font.Color := clBlack;
  If (strMarDes = 'M') Then
    ACanvas.Font.Color := clBlue
  Else If strStatus = 'LIBERADO' Then
    ACanvas.Font.Color := clGreen;
end;

procedure TfrmRcxLiberacaoDeCaixas.grdLancamentosDadosKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Return Then
    pSelecionarLancamentos(False, cdsLancamentos.FieldByName('RCX_MARDES').AsString = 'M');
end;

procedure TfrmRcxLiberacaoDeCaixas.grdLancamentosDadosTFsACOESGetProperties(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
  Var
    LModalidade,
    LStatus: String;
begin
  inherited;
  LStatus := ARecord.Values[grdLancamentosDadosTFsRCX_STATUS.Index];
  LModalidade := ARecord.Values[grdLancamentosDadosTFsMODALIDADE.Index];

  If MatchStr(LModalidade, ['Divergência']) Then
  Begin
    If LStatus = 'PENDENTE' Then
      AProperties := reqEditorbtnAcoesDivergencia.Properties
    Else
      AProperties := reqEditorbtnAcoesDivergenciaDisabled.Properties;
  End
  Else If MatchStr(LModalidade, ['Cartão', 'Cheque a Vista', 'Cheque Pré']) Then
  Begin
    If LStatus = 'PENDENTE' Then
      AProperties := reqEditorbtnAcaoAceitar.Properties
    Else
      AProperties := reqEditorbtnAcaoAceitarDisabled.Properties;
  End
  Else
  Begin
    If LStatus = 'PENDENTE' Then
      AProperties := reqEditorbtnAcoes.Properties
    Else
      AProperties := reqEditorbtnAcoesDisabled.Properties;
  End;
end;

procedure TfrmRcxLiberacaoDeCaixas.grdLancamentosDadosTFsCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    LStatus,
    LModalidade,
    LValor,
    LValorSelecionado: String;
begin
  inherited;

  If (Not Assigned(FTransferencias)) Or (FTransferencias.IsEmpty) Then
    Exit;

  LValor := FormatFloat(',0.00', Abs(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdLancamentosDadosTFsVALOR.Index]));
  LValorSelecionado := FormatFloat(',0.00', Abs(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdLancamentosDadosTFsVALORSELECIONADO.Index]));

  LStatus := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdLancamentosDadosTFsRCX_STATUS.Index]);

  LModalidade := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdLancamentosDadosTFsMODALIDADE.Index]);

  ACanvas.Font.Color := clBlack;
  If MatchStr(LStatus, ['LIBERADO', 'AJUSTADO']) Then
    ACanvas.Font.Color := clGreen
  Else If LStatus = 'RECUSADO' Then
    ACanvas.Font.Color := clRed
  Else If (LValor = LValorSelecionado) Then
    ACanvas.Font.Color := clBlue;

  If LStatus = 'PENDENTE' Then
  Begin
    If LModalidade <> 'Divergência' Then
      Exit;

    If Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdLancamentosDadosTFsVALOR.Index] > 0 Then
      Exit;

    If AViewInfo.Item.Index = 3 Then
      ACanvas.Font.Color := clRed;
  End;
end;

procedure TfrmRcxLiberacaoDeCaixas.grdLancamentosDadosTFsDOCUMENTOSGetProperties(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  inherited;
  If Not MatchStr(ARecord.Values[grdLancamentosDadosTFsMODALIDADE.Index], ['Divergência', 'Dinheiro', 'Ordem Pag.']) Then
  Begin
    If ARecord.Values[grdLancamentosDadosTFsRCX_STATUS.Index] = 'PENDENTE' Then
      AProperties := reqEditorbtnDocumentos.Properties
    Else
      AProperties := reqEditorbtnDocumentosDisabled.Properties;
  End
  Else
    AProperties := reqEditortxtTexto.Properties;
end;

procedure TfrmRcxLiberacaoDeCaixas.pCarregaCaixa;
begin
  edtDescricaoCaixa.Text := 'TODOS';
  If Not fEmptyStr(edtCodigoCaixa.Text) Then
    edtDescricaoCaixa.Text := fCampoTabela('GROUP_CONCAT(CONCAT(" ", CAX_DESCRI))',
                                           'CADCAX',
                                           ['CAX_CODCAX'],
                                           [edtCodigoCaixa.Text]);
end;

procedure TfrmRcxLiberacaoDeCaixas.pCarregaOperador;
begin
  edtNomeOperador.Text := 'TODOS';
  If Not fEmptyStr(edtCodigoOperador.Text) Then
    edtNomeOperador.Text := fRetNomeOperador(edtCodigoOperador.Text);
end;

procedure TfrmRcxLiberacaoDeCaixas.pCriaAggregateFields;
begin
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_VALDOC';
    FieldName     := 'TOT_VALDOC';
    DataSet       := cdsLancamentos;
    Expression    := 'SUM(RCX_VALDOC)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_VALDIV';
    FieldName     := 'TOT_VALDIV';
    DataSet       := cdsLancamentos;
    Expression    := 'SUM(RCX_VALDIV)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_DOCSEL';
    FieldName     := 'TOT_DOCSEL';
    DataSet       := cdsLancamentos;
    Expression    := 'SUM(RCX_DOCSEL)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_DIVSEL';
    FieldName     := 'TOT_DIVSEL';
    DataSet       := cdsLancamentos;
    Expression    := 'SUM(RCX_DIVSEL)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_QTDREG';
    FieldName     := 'TOT_QTDREG';
    DataSet       := cdsLancamentos;
    Expression    := 'COUNT(AUTOINCREM)';
    Active        := True;
  End;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_QTDSEL';
    FieldName     := 'TOT_QTDSEL';
    DataSet       := cdsLancamentos;
    Expression    := 'SUM(RCX_QTDSEL)';
    Active        := True;
  End;
end;

procedure TfrmRcxLiberacaoDeCaixas.pCriaTemporaria;
  Var
    qryLancamentos,
    LTransferencias: TUniQuery;

    LFiltros: TFiltrosTelaLiberacao;
begin
  LFiltros.DataInicial := edtDataInicial.Date;
  LFiltros.DataFinal := edtDataFinal.Date;
  LFiltros.CodigoCaixa := edtCodigoCaixa.Text;
  LFiltros.Operador := edtCodigoOperador.Text;
  LFiltros.Fechamento := cmbFechamento.ItemIndex;
  LFiltros.Status := cmbStatus.ItemIndex;

  LFiltros.Empresas := fRetArrToSQLIn(FEmpresasArray, edtCodigoEmpresa.Text);

  Try
    qryLancamentos := fCriaQuery;
    qryLancamentos.SQL.Text := FLiberacaoDeCaixas.RetornaSQLLancamentos(LFiltros);

    qryLancamentos.Options.SetFieldsReadOnly := False;
    qryLancamentos.Open;

    cdsLancamentos.Close;

    pDisableControls(cdsLancamentos, FprcScroll);
    pSetaClient(qryLancamentos);
    pSetaClientDataSet(qryLancamentos, cdsLancamentos);
    cdsLancamentos.AggregatesActive := True;
    cdsLancamentos.Open;

    If FAutenticacaoTransferencias Then
    Begin
      LTransferencias := fCriaQuery;
      LTransferencias.SQL.Text := FLiberacaoDeCaixas.RetornaSQLTransferencias(LFiltros);
      LTransferencias.Open;

      FTransferencias := fCriaClientDatSet(LTransferencias);
      FTransferencias.Open;

      FreeAndNil(LTransferencias);

      DeterminaFechamentosTFs;

      grdLancamentosDadosTFs.DataController.DataSource := fCriaDataSource(FTransferencias);
      grdLancamentosDadosTFs.DataController.DataSource.AutoEdit := False;
    End;

    TResumoDeCaixa.RetornaTransferenciasDoCaixaParaLiberacao(cdsLancamentos);

    pEnableControls(cdsLancamentos, FprcScroll);

    cdsLancamentos.AfterScroll := AfterScrollDataset;

    cdsLancamentos.First;

    grdLancamentosDados.DataController.DataSource := fCriaDataSource(cdsLancamentos);
    grdLancamentosDados.DataController.DataSource.AutoEdit := False;
  Finally
    FreeAndNil(qryLancamentos);

    pExibeTotalLancamentos;
    pSetFocus(grdLancamentos);
  End;
end;

procedure TfrmRcxLiberacaoDeCaixas.pExibeTotalLancamentos;
begin
  pDisableControls(cdsLancamentos, FprcScroll);

  edtQtdLancamentos.Text  := '( ' + IntToStr(cdsLancamentos.RecordCount) + ' )';
  edtQtdSelecionados.Text := '( ' + IntToStr(fIntAggregate(cdsLancamentos, 'TOT_QTDSEL')) + ' )';

  edtValorLancamentos.Text    := FormatFloat('#,##0.00;-#,##0.00', fDoubleAggregate(cdsLancamentos, 'TOT_VALDOC'));
  edtLancamentosSel.Text      := FormatFloat('#,##0.00;-#,##0.00', fDoubleAggregate(cdsLancamentos, 'TOT_DOCSEL'));
  edtValorDivergente.Text     := FormatFloat('#,##0.00;-#,##0.00', fDoubleAggregate(cdsLancamentos, 'TOT_VALDIV'));
  edtValorDivergenteSel.Text  := FormatFloat('#,##0.00;-#,##0.00', fDoubleAggregate(cdsLancamentos, 'TOT_DIVSEL'));

  pEnableControls(cdsLancamentos, FprcScroll);
  cdsLancamentos.AfterScroll := AfterScrollDataset;
end;

procedure TfrmRcxLiberacaoDeCaixas.pLimparDados;
begin
  cdsLancamentos.Filter   := '';
  cdsLancamentos.Filtered := False;
  cdsLancamentos.EmptyDataSet;

  If Not chkLimparFiltros.Checked Then
    Exit;

  edtCodigoCaixa.Clear;
  edtDescricaoCaixa.Clear;
  edtCodigoOperador.Clear;
  edtNomeOperador.Clear;
  edtDataInicial.Clear;
  edtDataFinal.Clear;

  edtQtdLancamentos.Clear;
  edtQtdSelecionados.Clear;

  edtValorLancamentos.Clear;
  edtLancamentosSel.Clear;
  edtValorDivergente.Clear;
  edtValorDivergenteSel.Clear;

  edtCodigoEmpresa.Text := VS_strCodEmp;
  CarregaEmpresa;

  cmbFechamento.ItemIndex := 3;
  cmbStatus.ItemIndex     := 2;
end;

procedure TfrmRcxLiberacaoDeCaixas.pSelecionarLancamentos(
  blnTodosLancamentos, blnDesmarcar: Boolean);
  Var
    frmGravando: TfrmGravando;
begin
  If (Not Assigned(cdsLancamentos)) Or (cdsLancamentos.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário carregar registros para utilizar essa função.', ['&OK']);
    Exit;
  End;

  If Not blnTodosLancamentos Then
  Begin
    If ExisteTransferenciasPendentes Then
    Begin
      fMensagem('ATENÇÃO', 'É necessário que todas as transferências não estejam pendentes para utilizar essa função.', ['&OK']);
      Exit;
    End;
  End;

  pDisableControls(cdsLancamentos, FprcScroll);

  If Not blnTodosLancamentos Then
  Begin
    cdsLancamentos.Filter   := 'AUTOINCREM=' + cdsLancamentos.FieldByName('AUTOINCREM').AsString;
    cdsLancamentos.Filtered := True;
  End;

  pCriarFormularios(TfrmGravando, frmGravando);
  If Not blnDesmarcar Then
  Begin
    frmGravando.lblGravando.Caption := 'Aguarde... Marcando lançamentos.';
    frmGravando.fExecutarAcao := fMarcarLancamentos;
  End
  Else
  Begin
    frmGravando.lblGravando.Caption := 'Aguarde... Desmarcando lançamentos.';
    frmGravando.fExecutarAcao := fDesmarcarLancamentos;
  End;

  frmGravando.ShowModal;
  FreeAndNil(frmGravando);

  pExibeTotalLancamentos;

  pEnableControls(cdsLancamentos, FprcScroll);
  cdsLancamentos.AfterScroll := AfterScrollDataset;

  pSetFocus(grdLancamentos);
end;

procedure TfrmRcxLiberacaoDeCaixas.RecusarModalidade;
  Var
    LTravou: Boolean;
begin
  inherited;
  LTravou := False;

  Try
    Try
      If fMensagem('ATENÇÃO', 'Deseja realmente recusar o valor de ' + FormatFloat(',0.00', FTransferencias.FieldByName('VALOR').AsFloat) +
                              ' na modalidade ' + FTransferencias.FieldByName('MODALIDADE').AsString + '?',
                              ['&Sim', '&Não']) = 2 Then
        Exit;

      LTravou := TravouFechamentoCaixa;
      If LTravou Then
        FLiberacaoDeCaixas.RecusarModalidade(FTransferencias);
    Finally
      If LTravou Then
        DestravaFechamentoCaixa;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[FLiberacaoDeCaixas.RecusarModalidade]');
  End;
end;

procedure TfrmRcxLiberacaoDeCaixas.RecusarModalidadeDivergencia;
  Var
    LTravou: Boolean;
begin
  inherited;
  LTravou := False;

  Try
    Try
      If fMensagem('ATENÇÃO', 'Deseja realmente recusar o valor de ' + FormatFloat(',0.00', FTransferencias.FieldByName('VALOR').AsFloat) +
                              ' na modalidade ' + FTransferencias.FieldByName('MODALIDADE').AsString + '?',
                              ['&Sim', '&Não']) = 2 Then
        Exit;

      LTravou := TravouFechamentoCaixa;
      If LTravou Then
        FLiberacaoDeCaixas.RecusarModalidadeDivergencia(FTransferencias);
    Finally
      If LTravou Then
        DestravaFechamentoCaixa;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[FLiberacaoDeCaixas.RecusarModalidadeDivergencia]');
  End;
end;

procedure TfrmRcxLiberacaoDeCaixas.reqEditorbtnAcaoAceitarPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  TfrmGravando.fExecutarModal(AceitarModalidadeVinculada, 'Aguarde... Aceitando modalidade.', '');
end;

procedure TfrmRcxLiberacaoDeCaixas.reqEditorbtnAcoesDivergenciaPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;

  If AButtonIndex = 0 Then
    TfrmGravando.fExecutarModal(AceitarModalidadeDivergencia, 'Aguarde... Aceitando divergência.', '')
  Else If AButtonIndex = 1 Then
    TfrmGravando.fExecutarModal(RecusarModalidadeDivergencia, 'Aguarde... Recusando divergência.', '')
  Else If AButtonIndex = 2 Then
    TfrmGravando.fExecutarModal(AjustarModalidadeDivergencia, 'Aguarde... Ajustando divergência.', '');
end;

procedure TfrmRcxLiberacaoDeCaixas.reqEditorbtnAcoesPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  If AButtonIndex = 0 Then
    TfrmGravando.fExecutarModal(AceitarModalidadePortador, 'Aguarde... Aceitando modalidade.', '')
  Else If AButtonIndex = 1 Then
    TfrmGravando.fExecutarModal(RecusarModalidade, 'Aguarde... Recusando modalidade.', '');
end;

procedure TfrmRcxLiberacaoDeCaixas.reqEditorbtnDocumentosPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  Var
    LRcxLiberacaoDocumentos: TfrmRcxLiberacaoDeCaixasDocumentosTF;
begin
  inherited;
  Try
    pCriarFormularios(TfrmRcxLiberacaoDeCaixasDocumentosTF, LRcxLiberacaoDocumentos);
    LRcxLiberacaoDocumentos.CodigoCaixa := cdsLancamentos.FieldByName('RCX_CODCAX').AsString;

    LRcxLiberacaoDocumentos.SequencialControle := FTransferencias.FieldByName('RCX_SEQCON').AsString;

    LRcxLiberacaoDocumentos.Operador := FTransferencias.FieldByName('RCX_CODOPE').AsString;
    LRcxLiberacaoDocumentos.CodigoEmpresa := FTransferencias.FieldByName('RCX_CODEMP').AsString;

    LRcxLiberacaoDocumentos.TipoDoRegistro := tprCartoes;
    If FTransferencias.FieldByName('MODALIDADE').AsString = 'Cheque a Vista' Then
      LRcxLiberacaoDocumentos.TipoDoRegistro := tprChequesAVista
    Else If FTransferencias.FieldByName('MODALIDADE').AsString = 'Cheque Pré' Then
      LRcxLiberacaoDocumentos.TipoDoRegistro := tprChequesPre;

    LRcxLiberacaoDocumentos.ShowModal;

    FTransferencias.Edit;
    FTransferencias.FieldByName('VALORSELECIONADO').AsFloat := LRcxLiberacaoDocumentos.ValorSelecionado;
    FTransferencias.Post;
  Finally
    FreeAndNil(LRcxLiberacaoDocumentos);
  End;
end;

function TfrmRcxLiberacaoDeCaixas.TravouFechamentoCaixa: Boolean;
begin
  Result := fLock_Unlock(TResumoDeCaixa.Create('C')
                                       .fRetornaTextoDaTravaDoFechamento(FTransferencias.FieldByName('RCX_CODCAX').AsString),
                          True,
                          False,
                          False,
                          '',
                          False);

  If Not Result Then
    fMensagem('ATENÇÃO', 'Não será possível efetuar essa função pois outra estação está fazendo o fechamento!', ['&Ok']);
end;

procedure TfrmRcxLiberacaoDeCaixas.UtilizacaoAutenticacaoTransferencias;
begin
  FAutenticacaoTransferencias := fCfgSis('USAAUT', varBoolean);

  btnAjuda.Visible := FAutenticacaoTransferencias;

  If Not FAutenticacaoTransferencias Then
    Exit;

  FExibeDinheiro := FLiberacaoDeCaixas.ExibeDinheiro;
  FExibeCartao := FLiberacaoDeCaixas.ExibeCartao;
  FExibeChequeAVista := FLiberacaoDeCaixas.ExibeChequeAVista;
  FExibeChequePre := FLiberacaoDeCaixas.ExibeChequePre;
  FExibeOrdemPagamento := FLiberacaoDeCaixas.ExibeOrdemPagamento;
  FExibeDivergencia := FLiberacaoDeCaixas.ExibeDivergencia;

  lblDinheiroTransferencia.Visible := FExibeDinheiro;
  edtDinheiroTransferencia.Visible := FExibeDinheiro;
  lblCartaoTransferencia.Visible := FExibeCartao;
  edtCartaoTransferencia.Visible := FExibeCartao;
  lblChequeAVistaTransferencia.Visible := FExibeChequeAVista;
  edtChequeAVistaTransferencia.Visible := FExibeChequeAVista;
  lblChequePreTransferencia.Visible := FExibeChequePre;
  edtChequePreTransferencia.Visible := FExibeChequePre;
  lblOrdemPagamentoTransferencia.Visible := FExibeOrdemPagamento;
  edtOrdemPagamentoTransferencia.Visible := FExibeOrdemPagamento;

  grdLancamentosLevelTF.Visible := True;
end;

function TfrmRcxLiberacaoDeCaixas.ValidarValorSelecionadoDocumentosVinculados: Boolean;
begin
  Result := fFormataFloat(Abs(FTransferencias.FieldByName('VALOR').AsFloat), 2) =
            fFormataFloat(FTransferencias.FieldByName('VALORSELECIONADO').AsFloat, 2);

  If Not Result Then
    fMensagem('ATENÇÃO', 'É necessário marcar todos os documentos da modalidade ' + FTransferencias.FieldByName('MODALIDADE').AsString +
                         ' antes de realizar o aceite.', ['&Ok']);
end;

end.
