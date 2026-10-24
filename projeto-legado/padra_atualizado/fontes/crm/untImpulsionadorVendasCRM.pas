unit untImpulsionadorVendasCRM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls,
  frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxCurrencyEdit,
  cxLabel, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  Data.DB, cxDBData, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridCitel, cxClasses, cxGridLevel, cxGrid, EditFocus,
  Vcl.Mask, Vcl.DBCtrls, DBEditFocus, Uni, untTypesSistema,
  untTImpulsionadorVendasCRM,
  cxCheckBox, cxProgressBar, System.UITypes,
  cxDataControllerConditionalFormattingRulesManagerDialog, untCfgTel,
  MaskEditFocus;

type
  TfrmImpulsionadorVendasCRM = class(TfrmPai)
    pnlAnaliseResumoVendas: TPanel;
    lblTitulo3: TcxLabel;
    pnlMes6: TPanel;
    grbMes6: TGroupBox;
    lblQtdMes6: TLabel;
    lblVlrMes6: TLabel;
    edtQtdMes6: TcxCurrencyEdit;
    edtVlrMes6: TcxCurrencyEdit;
    pnlMes5: TPanel;
    grbMes5: TGroupBox;
    lblQtdMes5: TLabel;
    lblVlrMes5: TLabel;
    edtQtdMes5: TcxCurrencyEdit;
    edtVlrMes5: TcxCurrencyEdit;
    pnlMes4: TPanel;
    grbMes4: TGroupBox;
    lblQtdMes4: TLabel;
    lblVlrMes4: TLabel;
    edtQtdMes4: TcxCurrencyEdit;
    edtVlrMes4: TcxCurrencyEdit;
    pnlMes3: TPanel;
    grbMes3: TGroupBox;
    lblQtdMes3: TLabel;
    lblVlrMes3: TLabel;
    edtQtdMes3: TcxCurrencyEdit;
    edtVlrMes3: TcxCurrencyEdit;
    pnlMes2: TPanel;
    grbMes2: TGroupBox;
    lblQtdMes2: TLabel;
    lblVlrMes2: TLabel;
    edtQtdMes2: TcxCurrencyEdit;
    edtVlrMes2: TcxCurrencyEdit;
    pnlMes1: TPanel;
    grbMes1: TGroupBox;
    lblQtdMes1: TLabel;
    lblVlrMes1: TLabel;
    edtQtdMes1: TcxCurrencyEdit;
    edtVlrMes1: TcxCurrencyEdit;
    pnlFiltros: TPanel;
    lblFiltro1: TcxLabel;
    pnlResumoVendas: TPanel;
    lblFiltro2: TcxLabel;
    grdResumoVendasLvl1: TcxGridLevel;
    grdResumoVendasView: TcxGridDBTableViewCitel;
    grdResumoVendas: TcxGridCitel;
    lblCliente: TcxLabel;
    lblFornecedor: TLabel;
    edtCodFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    lblMarca: TLabel;
    edtDesMar: TEditFocus;
    edtCodMar: TEditFocus;
    lblLinGru: TLabel;
    edtLinGru: TEditFocus;
    edtCodGru: TEditFocus;
    lblPrdGru: TLabel;
    edtPrdGru: TEditFocus;
    pnlBotoes1: TPanel;
    btnFiltrar: TBitBtnLocked;
    btnLimparFiltro: TBitBtnLocked;
    btnGerarOrcamento: TBitBtnLocked;
    edtDesPrdPro: TEditFocus;
    btnSelecionarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    dtsResumoVendas: TDataSource;
    grdResumoVendasSELECT: TcxGridDBColumn;
    grdResumoVendasCODITE: TcxGridDBColumn;
    grdResumoVendasDESITE: TcxGridDBColumn;
    grdResumoVendasUNIDAD: TcxGridDBColumn;
    grdResumoVendasDTAUVE: TcxGridDBColumn;
    grdResumoVendasQTDUVE: TcxGridDBColumn;
    grdResumoVendasPREUVE: TcxGridDBColumn;
    grdResumoVendasQTDITE: TcxGridDBColumn;
    grdResumoVendasUNITAR: TcxGridDBColumn;
    grdResumoVendasTOTITE: TcxGridDBColumn;
    grdResumoVendasMARGEM: TcxGridDBColumn;
    grdResumoVendasQTDORC: TcxGridDBColumn;
    grdResumoVendasTOTORC: TcxGridDBColumn;
    grdResumoVendasQTDPED: TcxGridDBColumn;
    grdResumoVendasTOTPED: TcxGridDBColumn;
    pnlMes7: TPanel;
    grbMes7: TGroupBox;
    lblQtdMes7: TLabel;
    lblVlrMes7: TLabel;
    edtQtdMes7: TcxCurrencyEdit;
    edtVlrMes7: TcxCurrencyEdit;
    btnEstoqueLojas: TBitBtnLocked;
    cxStyleRepository1: TcxStyleRepository;
    cxConteudo: TcxStyle;
    grdResumoVendasNUMDOC: TcxGridDBColumn;
    btnCfg: TBitBtnLocked;
    grdResumoVendasNVLGIR: TcxGridDBColumn;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    lblDepartamento: TLabel;
    Label6: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label7: TLabel;
    mskDtaFin: TMaskEditFocus;
    rdgTipPre: TRadioGroup;
    Panel1: TPanel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtPrdGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodFornecedorExit(Sender: TObject);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodGruExit(Sender: TObject);
    procedure edtPrdGruExit(Sender: TObject);
    procedure btnLimparFiltroClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdResumoVendasViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnEstoqueLojasClick(Sender: TObject);
    procedure btnSelecionarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure grdResumoVendasViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnFiltrarClick(Sender: TObject);
    procedure grdResumoVendasViewEditValueChanged
      (Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
    procedure btnGerarOrcamentoClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnCfgClick(Sender: TObject);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    objImpulsionadorVendasCRM: TImpulsionadorVendasCRM;
    FCfgTela: TCfgTelaImpulsionadorVendasCRM;

    procedure pLimparFiltros;
    procedure pLimparArraysConsulta;
    procedure pOnFormKeyDown(var Key: Word);
    procedure pMostrarEstoqueLojas;
    function fMostrarEstoqueLojas(pgbProgresso: TcxProgressBar): Boolean;
    procedure pAfterScrollResumoVendas(DataSet: TDataSet);
    procedure pBeforePostResumoVendas(DataSet: TDataSet);
    procedure pLimparEditsResumoMeses;
    procedure pSelecionarRegistro;
    procedure pSelecionarTodosRegistro(blnSelecionar: Boolean);
    procedure pFiltrarRegistros;
    function fFiltrarRegistros(pgbProgresso: TcxProgressBar): Boolean;
    procedure pGerarOrcamento;
    function fGerarOrcamento(pgbProgresso: TcxProgressBar): Boolean;
    procedure pGravarConfiguracoes;
    procedure pCarregarCores;
    procedure pSugerirDataFiltro;
  protected
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strCodCli: String;
  end;

var
  frmImpulsionadorVendasCRM: TfrmImpulsionadorVendasCRM;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untPesqAux, untCadGru, untFuncoesConsulta,
  untFatMostraEstoqueEmp, untGravando, untConfigImpulsionadorVendasCRM, UniClientDataSet;

procedure TfrmImpulsionadorVendasCRM.edtCodGruExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodGru, edtLinGru, objImpulsionadorVendasCRM.arrLinGru,
    fRetNomeLinhaGrupo, nil, 'da linha/grupo');
end;

procedure TfrmImpulsionadorVendasCRM.edtCodGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, edtCodGru, edtLinGru, nil, Key,
    objImpulsionadorVendasCRM.arrLinGru, False) Then
  Begin
    If fValidaCampos(edtCodGru) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmImpulsionadorVendasCRM.btnCfgClick(Sender: TObject);
var
  frmConfigImpulsuonadorVendasCRM: TfrmConfigImpulsuonadorVendasCRM;
begin
  inherited;

  pCriarFormularios(TfrmConfigImpulsuonadorVendasCRM, frmConfigImpulsuonadorVendasCRM);
  Try
    frmConfigImpulsuonadorVendasCRM.ShowModal;
    If (frmConfigImpulsuonadorVendasCRM.blnConfirma) Then
    begin
      TFrmGravando.fExecutarModal(pGravarConfiguracoes, 'Aguarde... Gravando Configurações!', '');
    end;

  Finally
    pFreeAndNil(frmConfigImpulsuonadorVendasCRM);
  End;

end;

procedure TfrmImpulsionadorVendasCRM.pGravarConfiguracoes;
begin
  Try
    FCfgTela.pIniciar(grdResumoVendas, grdResumoVendasView);
    FCfgTela.Sugestao.pCarregarTamanhoFonteObj;
    grdResumoVendas.Font.Size := FCfgTela.Sugestao.TamanhoFonte;
    pCarregarCores;

  If Not fValidaCampos(mskDtaIni) Then
    Exit;

  If Not fValidaCampos(mskDtaFin) Then
    Exit;

  pFiltrarRegistros();
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,
        '[TfrmImpulsionadorVendasCRM.pGravarConfiguracoes]');
    End;
  End;
end;

procedure TfrmImpulsionadorVendasCRM.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;

  pSelecionarTodosRegistro(False);
end;

procedure TfrmImpulsionadorVendasCRM.btnEstoqueLojasClick(Sender: TObject);
begin
  inherited;

  If (Not btnEstoqueLojas.Visible) Then
    Exit;

  If (dtsResumoVendas.DataSet.RecordCount = 0) Then
    fMensagem('ATENÇÃO', 'Selecione um item para acessar esta rotina!', ['&OK'])
  Else
  Begin
    If Not fVerificaAcessoSistema('CPELOJ', strLoginUsuarioLogado) Then
      fMensagem('ATENÇÃO',
        'Esse usuário não tem acesso a esse recurso.', ['&OK'])
    Else
      pMostrarEstoqueLojas();
  End;
end;

procedure TfrmImpulsionadorVendasCRM.btnFiltrarClick(Sender: TObject);
begin
  inherited;

  edtCodFornecedorExit(nil);
  edtCodMarExit(nil);
  edtCodGruExit(nil);
  edtPrdGruExit(nil);

  pFiltrarRegistros();

end;

procedure TfrmImpulsionadorVendasCRM.btnGerarOrcamentoClick(Sender: TObject);
begin
  inherited;

  pGerarOrcamento();
end;

procedure TfrmImpulsionadorVendasCRM.btnLimparFiltroClick(Sender: TObject);
begin
  inherited;

  pLimparFiltros();
end;

procedure TfrmImpulsionadorVendasCRM.btnSelecionarTodosClick(Sender: TObject);
begin
  inherited;

  pSelecionarTodosRegistro(True);
end;

procedure TfrmImpulsionadorVendasCRM.edtCodDepExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodDep, edtDesDep, objImpulsionadorVendasCRM.arrDepart ,
    fRetDescDepartamento, nil, 'do departamento');
end;

procedure TfrmImpulsionadorVendasCRM.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, objImpulsionadorVendasCRM.arrDepart, False) Then
  Begin
    If fValidaCampos(edtCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmImpulsionadorVendasCRM.edtCodFornecedorExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodFornecedor, edtDesFornecedor, objImpulsionadorVendasCRM.arrFornec, fRetNomFornecedor, nil,
    'do fornecedor');
end;

procedure TfrmImpulsionadorVendasCRM.edtCodFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFornecedor, edtDesFornecedor,
    Nil, Key, objImpulsionadorVendasCRM.arrFornec, False) Then
  Begin
    If fValidaCampos(edtCodFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmImpulsionadorVendasCRM.edtCodMarExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodMar, edtDesMar, objImpulsionadorVendasCRM.arrMarca,
    fRetNomeMarca, nil, 'da marca');
end;

procedure TfrmImpulsionadorVendasCRM.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key,
    objImpulsionadorVendasCRM.arrMarca, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmImpulsionadorVendasCRM.edtPrdGruExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtPrdGru, edtDesPrdPro,
    objImpulsionadorVendasCRM.arrCadGru, fRetNomeGrupoProduto, nil,
    'do grupo de produto');
end;

procedure TfrmImpulsionadorVendasCRM.edtPrdGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupoProduto(Self, edtPrdGru, edtDesPrdPro, Nil, Key,
    objImpulsionadorVendasCRM.arrCadGru, False) Then
  Begin
    If fValidaCampos(edtPrdGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmImpulsionadorVendasCRM.fFiltrarRegistros
  (pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := False;

  pLimparEditsResumoMeses();
  objImpulsionadorVendasCRM.intTipPreco := rdgTipPre.ItemIndex;
  If (objImpulsionadorVendasCRM.fFiltrarRegistros()) Then
  Begin
    If Not btnCfg.Visible Then
      grdResumoVendasView.ApplyBestFit();
    pSetFocus(grdResumoVendas);

    Result := True;
  End
  Else
    fMensagem('INFORMAÇÃO',
      'Nenhum item foi encontrado para a oferta de consumíveis. Verifique os filtros!',
      ['&OK']);
end;

function TfrmImpulsionadorVendasCRM.fGerarOrcamento(pgbProgresso : TcxProgressBar): Boolean;
var
  cdsVendas : TUniClientDataSet;
begin
  Result := False;

  If (Assigned(dtsResumoVendas.DataSet)) And
    (dtsResumoVendas.DataSet.RecordCount > 0) Then
  Begin
    If (Not objImpulsionadorVendasCRM.fPossuiItensGerarOrcamento()) Then
      fMensagem('ALERTA',
        'Nenhum item foi selecionado para geração do orçamento. Verifique!',
        ['&OK'])
    Else
      Result := objImpulsionadorVendasCRM.fRealizarOrcamento();

    If (Result) Then
    Begin
      btnLimparFiltro.Click();
      objImpulsionadorVendasCRM.pLimparClientDataSet();
    End
    Else
    Begin
      cdsVendas := objImpulsionadorVendasCRM.fGetCdsVendas;
      cdsVendas.First;
      While not cdsVendas.Eof Do
      Begin
        If cdsVendas.FieldByName('INSORC').AsString = 'S' Then
        Begin
          cdsVendas.Edit;
          cdsVendas.FieldByName('INSORC').AsString := 'N';
        End;
        cdsVendas.Next;
      End;
      If cdsVendas.State = dsEdit Then
        cdsVendas.Post;
    End;
  End
  Else
    fMensagem('ALERTA',
      'Nenhum item foi encontrado para geração do orçamento. Verifique!',
      ['&OK']);
end;

procedure TfrmImpulsionadorVendasCRM.FormCreate(Sender: TObject);
begin
  inherited;

  strCodCli := '';

  btnCfg.Visible := fVerificaAcessoSistema('CFGCON');
  FCfgTela:= TCfgTelaImpulsionadorVendasCRM.Create;

  pSugerirDataFiltro;
end;

procedure TfrmImpulsionadorVendasCRM.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(objImpulsionadorVendasCRM);
  If Assigned(FCfgTela) Then
    FreeAndNil(FCfgTela);
end;

procedure TfrmImpulsionadorVendasCRM.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  pOnFormKeyDown(Key);
end;

procedure TfrmImpulsionadorVendasCRM.FormResize(Sender: TObject);
begin
  inherited;

  If (Self.WindowState <> wsMaximized) Then
  Begin
    Self.Left := (Screen.Width - Width) div 2;
    Self.Top := (Screen.Height - Height) div 2;
  End;
end;

procedure TfrmImpulsionadorVendasCRM.FormShow(Sender: TObject);
begin
  inherited;

  lblCliente.Caption := ' Cliente: ' + strCodCli + ' - ' +
    fRetNomCliente(strCodCli);
  objImpulsionadorVendasCRM := TImpulsionadorVendasCRM.Create(strCodCli,
    pAfterScrollResumoVendas, pBeforePostResumoVendas, edtCodFornecedor,
    edtCodMar, edtCodGru, edtPrdGru, edtCodDep, mskDtaIni, mskDtaFin);
  dtsResumoVendas.DataSet := objImpulsionadorVendasCRM.fGetCdsVendas();

  btnEstoqueLojas.Visible := True;
  pSetFocus(edtCodFornecedor);

  FCfgTela.pIniciar(grdResumoVendas, grdResumoVendasView);
  FCfgTela.Sugestao.pCarregarTamanhoFonteObj;
  grdResumoVendas.Font.Size := FCfgTela.Sugestao.TamanhoFonte;
  pCarregarCores;

end;

function TfrmImpulsionadorVendasCRM.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodFornecedor) Then
    Begin
      pDesmarcaLista(edtCodFornecedor,
        objImpulsionadorVendasCRM.arrFornec, '', 8);
    End

    Else If (Sender = edtCodMar) Then
    Begin
      pDesmarcaLista(edtCodMar, objImpulsionadorVendasCRM.arrMarca, '', 6);
    End

    Else If (Sender = edtCodGru) Then
    Begin
      pDesmarcaLista(edtCodGru, objImpulsionadorVendasCRM.arrLinGru, '', 6);
    End

    Else If (Sender = edtPrdGru) Then
    Begin
      pDesmarcaLista(edtPrdGru, objImpulsionadorVendasCRM.arrCadGru, '', 5);
    End

    Else If ((Sender = mskDtaIni) Or (Sender = mskDtaFin)) Then
    Begin
      If (fEmptyDate(mskDtaIni.Text)) Or (fEmptyDate(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe os campos "Data Inicial" e "Data Final" para prosseguir !', ['&Ok']);
        Result := False;
      End
      Else
      If (Not fEmptyDate(mskDtaIni.Text)) And (Not fEmptyDate(mskDtaFin.Text)) And
         (StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text))  Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial não pode ser maior que a data final!', ['&Ok']);
        Result := False;
      End

      Else If Not objImpulsionadorVendasCRM.fValidarFiltroData(mskDtaIni, mskDtaFin)  Then
      Begin
        fMensagem('ATENÇÃO!', 'Permitido Análise de Resumo de Vendas dos Últimos 6 Meses!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmImpulsionadorVendasCRM.grdResumoVendasViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If Assigned(FCfgTela) Then
  Begin
    If AViewInfo.GridRecord.Selected Then
    Begin
      TCfgTelaImpulsionadorVendasCRM.pFormatarCelula(ACanvas,
                                                     FCfgTela.Sugestao.CorFonteLinhaSelecionada,
                                                     FCfgTela.Sugestao.CorFundoLinhaSelecionada,
                                                     False);
    End
    Else
    begin
      TCfgTelaImpulsionadorVendasCRM.pFormatarCelula(ACanvas,
                                                     FCfgTela.Sugestao.CorFonteLinha,
                                                     FCfgTela.Sugestao.CorFundoLinha,
                                                     False);
    end;

    If (TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName = 'QTDITE') Then
    Begin
      TCfgTelaImpulsionadorVendasCRM.pFormatarCelula(ACanvas,
                                                     FCfgTela.Sugestao.CorFonteColunaQtdIte,
                                                     FCfgTela.Sugestao.CorFundoColunaQtdIte,
                                                     AViewInfo.GridRecord.Selected);
    End;
  End
  Else
  Begin
    If (TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName = 'QTDITE') Then
    Begin
      ACanvas.Font.Color := clBlack;

      If ACanvas.Brush.Color = clHighlight Then
        ACanvas.Font.Style := [fsBold]
      Else
        ACanvas.Font.Style := [];

      ACanvas.Brush.Color := clYellow;
    End;
  End;

  If (TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName = 'TOTITE') Then
  Begin
    ACanvas.Font.Style := [fsBold];
  End;
end;

procedure TfrmImpulsionadorVendasCRM.grdResumoVendasViewEditValueChanged
  (Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
begin
  inherited;

  If (TcxGridDBColumn(AItem).DataBinding.FieldName = 'QTDITE') Or
    (TcxGridDBColumn(AItem).DataBinding.FieldName = 'UNITAR') Then
  Begin
    dtsResumoVendas.DataSet.Post();
  End;
end;

procedure TfrmImpulsionadorVendasCRM.grdResumoVendasViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  pOnFormKeyDown(Key);
end;

procedure TfrmImpulsionadorVendasCRM.pAfterScrollResumoVendas
  (DataSet: TDataSet);

  function fRetCorLetra(fltValor: Double): TColor;
  begin
    If (fltValor > 0) Then
      Result := clBlack
    Else
      Result := clRed;
  end;

begin
  If (Assigned(DataSet)) And (DataSet.RecordCount > 0) Then
  Begin
    grbMes1.Caption := objImpulsionadorVendasCRM.recPeriodoAnalise.strDescMes1;
    grbMes2.Caption := objImpulsionadorVendasCRM.recPeriodoAnalise.strDescMes2;
    grbMes3.Caption := objImpulsionadorVendasCRM.recPeriodoAnalise.strDescMes3;
    grbMes4.Caption := objImpulsionadorVendasCRM.recPeriodoAnalise.strDescMes4;
    grbMes5.Caption := objImpulsionadorVendasCRM.recPeriodoAnalise.strDescMes5;
    grbMes6.Caption := objImpulsionadorVendasCRM.recPeriodoAnalise.strDescMes6;
    grbMes7.Caption := objImpulsionadorVendasCRM.recPeriodoAnalise.strDescMes7;

    edtQtdMes1.Text := FormatFloat('#,##0.00',
      DataSet.FieldByName('QTDITE_MES_1').AsFloat);
    edtVlrMes1.Text := FormatFloat('#,##0.00',
      DataSet.FieldByName('VLRITE_MES_1').AsFloat);
    edtQtdMes2.Text := FormatFloat('#,##0.00',
      DataSet.FieldByName('QTDITE_MES_2').AsFloat);
    edtVlrMes2.Text := FormatFloat('#,##0.00',
      DataSet.FieldByName('VLRITE_MES_2').AsFloat);
    edtQtdMes3.Text := FormatFloat('#,##0.00',
      DataSet.FieldByName('QTDITE_MES_3').AsFloat);
    edtVlrMes3.Text := FormatFloat('#,##0.00',
      DataSet.FieldByName('VLRITE_MES_3').AsFloat);
    edtQtdMes4.Text := FormatFloat('#,##0.00',
      DataSet.FieldByName('QTDITE_MES_4').AsFloat);
    edtVlrMes4.Text := FormatFloat('#,##0.00',
      DataSet.FieldByName('VLRITE_MES_4').AsFloat);
    edtQtdMes5.Text := FormatFloat('#,##0.00',
      DataSet.FieldByName('QTDITE_MES_5').AsFloat);
    edtVlrMes5.Text := FormatFloat('#,##0.00',
      DataSet.FieldByName('VLRITE_MES_5').AsFloat);
    edtQtdMes6.Text := FormatFloat('#,##0.00',
      DataSet.FieldByName('QTDITE_MES_6').AsFloat);
    edtVlrMes6.Text := FormatFloat('#,##0.00',
      DataSet.FieldByName('VLRITE_MES_6').AsFloat);
    edtQtdMes7.Text := FormatFloat('#,##0.00',
      DataSet.FieldByName('QTDITE_MES_7').AsFloat);
    edtVlrMes7.Text := FormatFloat('#,##0.00',
      DataSet.FieldByName('VLRITE_MES_7').AsFloat);

    edtQtdMes1.Style.TextColor :=
      fRetCorLetra(DataSet.FieldByName('QTDITE_MES_1').AsFloat);
    edtVlrMes1.Style.TextColor :=
      fRetCorLetra(DataSet.FieldByName('VLRITE_MES_1').AsFloat);
    edtQtdMes2.Style.TextColor :=
      fRetCorLetra(DataSet.FieldByName('QTDITE_MES_2').AsFloat);
    edtVlrMes2.Style.TextColor :=
      fRetCorLetra(DataSet.FieldByName('VLRITE_MES_2').AsFloat);
    edtQtdMes3.Style.TextColor :=
      fRetCorLetra(DataSet.FieldByName('QTDITE_MES_3').AsFloat);
    edtVlrMes3.Style.TextColor :=
      fRetCorLetra(DataSet.FieldByName('VLRITE_MES_3').AsFloat);
    edtQtdMes4.Style.TextColor :=
      fRetCorLetra(DataSet.FieldByName('QTDITE_MES_4').AsFloat);
    edtVlrMes4.Style.TextColor :=
      fRetCorLetra(DataSet.FieldByName('VLRITE_MES_4').AsFloat);
    edtQtdMes5.Style.TextColor :=
      fRetCorLetra(DataSet.FieldByName('QTDITE_MES_5').AsFloat);
    edtVlrMes5.Style.TextColor :=
      fRetCorLetra(DataSet.FieldByName('VLRITE_MES_5').AsFloat);
    edtQtdMes6.Style.TextColor :=
      fRetCorLetra(DataSet.FieldByName('QTDITE_MES_6').AsFloat);
    edtVlrMes6.Style.TextColor :=
      fRetCorLetra(DataSet.FieldByName('VLRITE_MES_6').AsFloat);
    edtQtdMes7.Style.TextColor :=
      fRetCorLetra(DataSet.FieldByName('QTDITE_MES_7').AsFloat);
    edtVlrMes7.Style.TextColor :=
      fRetCorLetra(DataSet.FieldByName('VLRITE_MES_7').AsFloat);
  End
  Else
    pLimparEditsResumoMeses();
end;

procedure TfrmImpulsionadorVendasCRM.pBeforePostResumoVendas(DataSet: TDataSet);
begin
  If (Assigned(DataSet)) And (DataSet.RecordCount > 0) And
    (DataSet.State = dsEdit) Then
  Begin
    If (DataSet.FieldByName('QTDITE').AsFloat < 0) Then
    Begin
      fMensagem('ALERTA',
        'Campo Qtde. Venda não pode ser menor que zero!', ['&OK']);
      DataSet.FieldByName('QTDITE').AsFloat :=
        DataSet.FieldByName('QTDUVE').AsFloat;
    End
    Else If (DataSet.FieldByName('UNITAR').AsFloat <= 0) Then
    Begin
      fMensagem('ALERTA',
        'Campo Preço Venda não pode ser menor ou igual a que zero!', ['&OK']);
      DataSet.FieldByName('UNITAR').AsFloat :=
        DataSet.FieldByName('UNITAR').OldValue;
    End
    Else If (DataSet.FieldByName('TOTITE').AsFloat <= 0) Then
    Begin
      fMensagem('ALERTA',
        'Campo Valor Total não pode ser menor que zero!', ['&OK']);
    End;

    DataSet.FieldByName('TOTITE').AsFloat := DataSet.FieldByName('QTDITE')
      .AsFloat * DataSet.FieldByName('UNITAR').AsFloat;

    grdResumoVendasView.ApplyBestFit();
  End;
end;

procedure TfrmImpulsionadorVendasCRM.pFiltrarRegistros;
begin


  Try
    pCriarFormularios(TFrmGravando, frmGravando);

    Try
      frmGravando.pgbStatus.Visible := False;
      frmGravando.lblGravando.Caption := 'Analisando vendas. Aguarde...';
      frmGravando.fExecutarAcao := fFiltrarRegistros;
      frmGravando.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,
          '[TfrmImpulsionadorVendasCRM.pFiltrarRegistros]');
      End;
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmImpulsionadorVendasCRM.pGerarOrcamento;
begin
  Try
    pCriarFormularios(TFrmGravando, frmGravando);

    Try
      frmGravando.pgbStatus.Visible := False;
      frmGravando.lblGravando.Caption := 'Inicializando orçamento. Aguarde...';
      frmGravando.fExecutarAcao := fGerarOrcamento;
      frmGravando.ShowModal;
      Self.Repaint();
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,
          '[TfrmImpulsionadorVendasCRM.pFiltrarRegistros]');
      End;
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmImpulsionadorVendasCRM.pLimparArraysConsulta;
begin
  objImpulsionadorVendasCRM.pLimparFiltros();
end;

procedure TfrmImpulsionadorVendasCRM.pLimparEditsResumoMeses;
begin
  edtQtdMes1.Text := '0,00';
  edtVlrMes1.Text := '0,00';
  edtQtdMes2.Text := '0,00';
  edtVlrMes2.Text := '0,00';
  edtQtdMes3.Text := '0,00';
  edtVlrMes3.Text := '0,00';
  edtQtdMes4.Text := '0,00';
  edtVlrMes4.Text := '0,00';
  edtQtdMes5.Text := '0,00';
  edtVlrMes5.Text := '0,00';
  edtQtdMes6.Text := '0,00';
  edtVlrMes6.Text := '0,00';
  edtQtdMes7.Text := '0,00';
  edtVlrMes7.Text := '0,00';
end;

procedure TfrmImpulsionadorVendasCRM.pLimparFiltros;
begin
  edtCodFornecedor.Clear();
  edtDesFornecedor.Clear();
  edtCodMar.Clear();
  edtDesMar.Clear();
  edtCodGru.Clear();
  edtLinGru.Clear();
  edtPrdGru.Clear();
  edtDesPrdPro.Clear();
  edtCodDep.Clear();
  edtDesDep.Clear();
  mskDtaIni.Clear;
  mskDtaFin.Clear;
  pSugerirDataFiltro;

  pLimparArraysConsulta();

  pSetFocus(edtCodFornecedor);
end;

function TfrmImpulsionadorVendasCRM.fMostrarEstoqueLojas
  (pgbProgresso: TcxProgressBar): Boolean;
Var
  frmFatMostraEstoqueEmp: TfrmFatMostraEstoqueEmp;
begin
  Result := True;

  Try
    pCriarFormularios(TfrmFatMostraEstoqueEmp, frmFatMostraEstoqueEmp);

    Try
      frmFatMostraEstoqueEmp.blnFaturamento := False;
      frmFatMostraEstoqueEmp.strCodIte := dtsResumoVendas.DataSet.FieldByName
        ('CODITE').AsString;
      frmFatMostraEstoqueEmp.strTabPre :=
        objImpulsionadorVendasCRM.fGetTabPre();
      frmFatMostraEstoqueEmp.edtItem.Text := dtsResumoVendas.DataSet.FieldByName
        ('CODITE').AsString + ' - ' + dtsResumoVendas.DataSet.FieldByName
        ('DESCRI').AsString;
      frmFatMostraEstoqueEmp.blnEstrutura :=
        fItemEstrutura(dtsResumoVendas.DataSet.FieldByName('CODITE').AsString);
      frmFatMostraEstoqueEmp.ShowModal();
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message,
          '[TfrmImpulsionadorVendasCRM.pMostrarEstoqueLojas]');
      End;
    End;
  Finally
    pFreeAndNil(frmFatMostraEstoqueEmp);
  End;
end;

procedure TfrmImpulsionadorVendasCRM.pMostrarEstoqueLojas;
begin
  Try
    pCriarFormularios(TFrmGravando, frmGravando);

    Try
      frmGravando.pgbStatus.Visible := False;
      frmGravando.lblGravando.Caption :=
        'Analisando estoque do produto. Aguarde...';
      frmGravando.fExecutarAcao := fMostrarEstoqueLojas;
      frmGravando.ShowModal;
      Self.Repaint();
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,
          '[TfrmImpulsionadorVendasCRM.pMostrarEstoqueLojas]');
      End;
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmImpulsionadorVendasCRM.pOnFormKeyDown(var Key: Word);
Var
  blnEventoGrid: Boolean;
begin
  blnEventoGrid := (Assigned(ActiveControl)) And
    (ActiveControl Is TcxGridSiteCitel);

  Case Key Of
    VK_F4:
      Begin
        btnLimparFiltro.Click();
        Key := 0;
      End;
    VK_F5:
      Begin
        btnFiltrar.Click();
        Key := 0;
      End;
    VK_F6:
      Begin
        btnEstoqueLojas.Click();
        Key := 0;
      End;
    VK_F7:
      Begin
        btnSelecionarTodos.Click();
        Key := 0;
      End;
    VK_F8:
      Begin
        btnDesmarcarTodos.Click();
        Key := 0;
      End;
    VK_F10:
      Begin
        btnGerarOrcamento.Click();
        Key := 0;
      End;
    VK_ESCAPE:
      Begin
        If (blnEventoGrid) Then
          btnSair.Click();
        Key := 0;
      End;
    VK_SPACE:
      Begin
        If (blnEventoGrid) Then
          pSelecionarRegistro();
        Key := 0;
      End;
    VK_RETURN:
      Begin
        If (blnEventoGrid) Then
        Begin
          pSelecionarRegistro();
          Key := 0;
        End;
      End;
  End;
end;

procedure TfrmImpulsionadorVendasCRM.pSelecionarRegistro;
begin
  If (Assigned(dtsResumoVendas.DataSet)) And
    (dtsResumoVendas.DataSet.RecordCount > 0) Then
  Begin
    dtsResumoVendas.DataSet.Edit();

    If (dtsResumoVendas.DataSet.FieldByName('SELECT').AsInteger = 0) Then
      dtsResumoVendas.DataSet.FieldByName('SELECT').AsInteger := 1
    Else
      dtsResumoVendas.DataSet.FieldByName('SELECT').AsInteger := 0;

    dtsResumoVendas.DataSet.Post();
  End;
end;

procedure TfrmImpulsionadorVendasCRM.pSelecionarTodosRegistro
  (blnSelecionar: Boolean);
begin
  If (Assigned(dtsResumoVendas.DataSet)) And
    (dtsResumoVendas.DataSet.RecordCount > 0) Then
  Begin
    Try
      dtsResumoVendas.DataSet.DisableControls();
      dtsResumoVendas.DataSet.First();

      While (Not dtsResumoVendas.DataSet.Eof) Do
      Begin
        dtsResumoVendas.DataSet.Edit();

        If (blnSelecionar) Then
          dtsResumoVendas.DataSet.FieldByName('SELECT').AsInteger := 1
        Else
          dtsResumoVendas.DataSet.FieldByName('SELECT').AsInteger := 0;

        dtsResumoVendas.DataSet.Post();

        dtsResumoVendas.DataSet.Next();
      End;
    Finally
      dtsResumoVendas.DataSet.EnableControls();
    End;
  End;
end;

procedure TfrmImpulsionadorVendasCRM.pSugerirDataFiltro;
var
  dtaIniAux : TDateTime;
  dtaFimAux : TDateTime;
begin
  dtaIniAux := VS_Date;
  dtaFimAux := IncMonth(dtaIniAux, -1);

  mskDtaFin.Text := DateTimeToStr(dtaIniAux);
  mskDtaIni.Text := DateTimeToStr(dtaFimAux);
end;

procedure TfrmImpulsionadorVendasCRM.pCarregarCores;
begin
  FCfgTela.Sugestao.pCarregarCoresGrid('grdResumoVendas');
end;

end.
