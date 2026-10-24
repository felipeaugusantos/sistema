unit Contabilidade.View.ConferenciaEstoqueContabil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, UniClientDataSet, untExcel, untGeraExcel,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Vcl.ComCtrls,
  Vcl.Mask, MaskEditFocus, EditFocus, cxProgressBar, Uni, cxButtonEdit,
  untTypesSistema, Contabilidade.View.TfrmPaiContabilidade, cxContainer, cxTextEdit, cxCurrencyEdit,
  CurrencyEditFocus, cxEditRepositoryItems;

type
  TfrmConferenciaEstoqueContabil = class(TfrmPaiContabilidade)
    pnlFundo: TPanel;
    cxgDadosDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxgDadosLevel1: TcxGridLevel;
    cxgDados: TcxGridCitel;
    pgcDados: TPageControl;
    tbsFiltros: TTabSheet;
    tbsDados: TTabSheet;
    lblCodEmp: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    Label2: TLabel;
    btnGerar: TBitBtnLocked;
    mskPeriodo: TMaskEditFocus;
    cxgDadosDBTableViewCitel1tipmov: TcxGridDBColumn;
    cxgDadosDBTableViewCitel1valor: TcxGridDBColumn;
    dtsDados: TDataSource;
    cxgDadosDBTableViewCitel1subTipo: TcxGridDBColumn;
    cxgDadosDBTableViewCitel1operac: TcxGridDBColumn;
    cxgDadosDBTableViewCitel1btnsql: TcxGridDBColumn;
    cxgDadosDBTableViewCitel1detalhe: TcxGridDBColumn;
    btnGeraExcel: TSpeedButton;
    lbl4: TLabel;
    mskLinGru: TMaskEditFocus;
    edtNomGru: TEditFocus;
    cxgDadosDBTableViewCitel1SomaQtd: TcxGridDBColumn;
    Label3: TLabel;
    edtProdutos: TEditFocus;
    edtDesProduto: TEditFocus;
    gpbModoDebug: TGroupBox;
    edtFiltroValor: TCurrencyEditFocus;
    Label1: TLabel;
    edtFiltroQuantidade: TCurrencyEditFocus;
    Label4: TLabel;
    chkModoDebug: TCheckBox;
    chkEmpCol: TCheckBox;
    cxEditRepository: TcxEditRepository;
    cxButtonItemSQL: TcxEditRepositoryButtonItem;
    cxButtonItemDetalhes: TcxEditRepositoryButtonItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnGerarClick(Sender: TObject);
    procedure cxgDadosDBTableViewCitel1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgDadosDBTableViewCitel1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgDadosDBTableViewCitel1btnsqlPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure cxgDadosDBTableViewCitel1detalhePropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure btnGeraExcelClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
    procedure mskLinGruExit(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure cxgDadosDBTableViewCitel1TcxGridDBDataControllerTcxDataSummaryDefaultGroupSummaryItems0GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
      var AText: string);
    procedure edtProdutosExit(Sender: TObject);
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure chkModoDebugClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure pButtonSQLClick(Sender: TObject; AButtonIndex: Integer);
    procedure pButtonDetalheClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxButtonItemPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxButtonEditDetalhesPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = true): Boolean; override;
  private
    { Private declarations }
    intTamanhoCodIte : Integer;
    arrCadIte: TConsultasArray;
    arrCodEmp: TConsultasArray;
    arrLinGru: TConsultasArray;
    strCadIte : String;
    strLinGru : String;
    strCadEmp : String;

    strSQLInicial,
    strSQLEntradas,
    strSQLSaidas,
    strSQLSaldoFinal,
    strSQLDiferenca: String;

    strSQLDetInicial,
    strSQLDetEntradas,
    strSQLDetSaidas,
    strSQLDetSaldoFinal,
    strSQLDetDiferenca: String;

    pgbProgresso: TcxProgressBar;
    intSequen : Integer;
    cdsDados : TUniClientDataSet;
    fltSaldoFinal : Double;
    fltQtdFinal : Double;
    qryItensPeriodo : TUniQuery;
    strPeriodoCarregado : String;
    cdsColunado : TUniClientDataSet;
    FClienteFilialLocate: string;
    strEmpCfg: string;
    function fCriarCdsDados(arrEmpresas: TConsultasArray = nil): TUniClientDataSet;
    procedure pInsertDados(strTipMov, strSubTipo: String;
      fltValor: Double; strOperac, strBtnSQL, strSqlDetail: String; blnNegativar: Boolean = False;
      fltSomaQtd: Double = 0);
    procedure pGerar;
    function fGerarTodosItens(pgbProgresso: TcxProgressBar): Boolean;
    function fGerarColunado(pgbProgresso: TcxProgressBar): Boolean;
    function fConfirmar(pgbProgresso: TcxProgressBar): Boolean;
    function fDataInicial: TDateTime;
    function fDataFinal: TDateTime;
    function fPeriodoAtual: String;
    function fPeriodoAnterior: String;
    function fPeriodoAnteriorMascara: String;
    procedure pSetaTextoStatus(strInformacao: String);
    function fGetColunasAgrupamentoCfop(blnMedNovo: Boolean = False; blnVlrConMaisConFreMaisVlrGnre: boolean = false): String;
    function fFiltroExclusaoLinhaGrupo(strAliasCadIte: String = 'CADITE.'): String;
    //function fCfopGarantiaEntrada: String;

    // Saldo Inicial
    procedure pSaldoInicial;

    // Entradas
    procedure pCompras;
    procedure pImpostosRecuperaveisDeCompras;
    procedure pTransferenciasEntradas;
    procedure pOutrasEntradas;
    procedure pGarantiaClienteEntradas;
    procedure pAjusteEntradas;
    procedure pDevolucoesDeClientes;
    procedure pBonificadaoDeFornecedores;

    // Saídas
    procedure pSaidas;
    procedure pTransferenciasSaidas;
    procedure pOutrasSaidas;
    procedure pGarantiaClienteSaidas;
    procedure pAjustesSaidas;
    procedure pUsoConsumo;
    procedure pBonificacaoDeClientes;
    procedure pDevolucaoAFornecedores;

    procedure pSaldoInventario;
    procedure pTransferenciaDeMercadorias;

    procedure pEstoqueEmGarantia;

    function fSQLBind(qryDados: TUniQuery): String;
    procedure OnGeraExcel(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
    procedure pSetaFiltroComum(qryFiltro: TUniQuery);
    procedure pSetaParametros(qryParam: TUniQuery);
    procedure pCarregaItensDoPeriodoAtual;
    procedure pLimparFiltroDoProduto;
    procedure pApresentarDados(arrEmpresas: TConsultasArray);
    procedure pLimparColunasCxGridEmpresa;
    procedure GetPropertiesButtonSQL(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure GetPropertiesButtonDetalhes(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure pColorirColunasDasEmpresas(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure pDefineDataSetExibicao(Sender: TObject; var strField: string; var DataSet: TDataSet);
    function fRetClientesFilialLocate: String;
  public
    { Public declarations }
  end;

var
  frmConferenciaEstoqueContabil: TfrmConferenciaEstoqueContabil;

implementation

uses
  DateUtils, StrUtils, Contabilidade.View.ConferenciaEstoqueContabilDetalhe,
  untFuncoesSimples, untConsultas, untFuncoesConsulta, untObservacao,
  untFuncoes, Contabilidade.Funcoes;

{$R *.dfm}

function fRetNomeLinhaGrupo(strCodigo: String): String;
begin
  Result := untFuncoesSimples.fRetNomeLinhaGrupo(strCodigo);
end;

procedure TfrmConferenciaEstoqueContabil.btnGeraExcelClick(Sender: TObject);
begin
  If TGeraExcel.fGerarRelatorio(cxgDadosDBTableViewCitel1, 'Conferência Estoque Contábil', OnGeraExcel) Then
    fMensagem('','Arquivo Salvo com Sucesso!', ['&OK']);
end;

procedure TfrmConferenciaEstoqueContabil.btnGerarClick(Sender: TObject);
  Var
    strPeriodo : String;
begin
  inherited;

  If fEmptyStr(mskPeriodo.Text, True) Then
  Begin
    fMensagem('ATENÇÃO!', 'Obrigatório preenchimento do período!', ['&OK']);
    Exit;
  End;

  strPeriodo := fPeriodoAnterior;

  If Not fTabelaExiste('I_' + strPeriodo) Then
  Begin
    fMensagem('ATENÇÃO!', Format('O inventário do período [%s] não existe!', [strPeriodo]), ['&OK']);
    Exit;
  End;

  If Not fVerificaCampos Then
    Exit;

  pLimparColunasCxGridEmpresa;

  dtsDados.DataSet := cdsDados;
  cxgDadosDBTableViewCitel1btnsql.Visible := fEhAdministrador(strLoginUsuarioLogado);
  cxgDadosDBTableViewCitel1detalhe.Visible := True;
  cxgDadosDBTableViewCitel1valor.Caption := 'Valor';
  cxgDadosDBTableViewCitel1SomaQtd.Caption := 'Quantidade';

  if chkEmpCol.Checked then
    fChamaTelaGravando(fGerarColunado)
  else if chkModoDebug.Checked then
    fChamaTelaGravando(fGerarTodosItens)
  else
    pGerar;
end;

procedure TfrmConferenciaEstoqueContabil.chkModoDebugClick(Sender: TObject);
begin
  inherited;
  gpbModoDebug.Visible := chkModoDebug.Checked;
  edtFiltroValor.TabStop := chkModoDebug.Checked;
  edtFiltroQuantidade.TabStop := chkModoDebug.Checked;
  edtProdutos.Enabled := not chkModoDebug.Checked;
  edtDesProduto.Enabled := not chkModoDebug.Checked;
  if (chkModoDebug.Checked) then
    pLimparFiltroDoProduto;
end;

procedure TfrmConferenciaEstoqueContabil.pButtonDetalheClick(Sender: TObject;
  AButtonIndex: Integer);
  var
    strField : string;
    DataSet : TDataSet;
begin
  strField := 'SqlDet';
  pDefineDataSetExibicao(Sender, strField, DataSet);

  if not Assigned(DataSet) then
    exit;

  if not DataSet.Active then
    exit;

  if not Assigned(DataSet.FindField(strField)) then
    exit;

  If fEmptyStr(DataSet.FieldByName(strField).AsString) Then
  Begin
    fMensagem('', 'Não há detalhes para essa opção!', ['&OK']);
    Exit;
  End;

  pCriarFormularios(TfrmConferenciaEstoqueContabilDetalhe, frmConferenciaEstoqueContabilDetalhe);
  Try
    If (DataSet.FieldByName('subtip').AsString = 'SALDO INICIAL') Or
       (DataSet.FieldByName('subtip').AsString = 'SALDO DE INVENTÁRIO') Or
       (DataSet.FieldByName('subtip').AsString = 'ESTOQUE EM GARANTIA') Or
       (DataSet.FieldByName('subtip').AsString = 'SALDO FINAL') Or
       (DataSet.FieldByName('subtip').AsString = 'DIFERENÇA')  Then
      frmConferenciaEstoqueContabilDetalhe.cxGridCitel1Level1.GridView := frmConferenciaEstoqueContabilDetalhe.cxGridCitel1DBTableViewSaldoInicial
    Else If (DataSet.FieldByName('subtip').AsString = '(+) GARANTIA DE CLIENTE') Or
            (DataSet.FieldByName('subtip').AsString = '(-) VENDAS') Or
            (DataSet.FieldByName('subtip').AsString = '(+) DEVOLUÇÕES DE CLIENTES') Or
            (DataSet.FieldByName('subtip').AsString = '(-) OUTRAS SAÍDAS') Or
            (DataSet.FieldByName('subtip').AsString = '(-) BONIFICAÇÃO DE CLIENTES') Or
   //         (DataSet.FieldByName('subtip').AsString = '(+) TRANSFERÊNCIAS ( ENTRADAS )') Or
            (DataSet.FieldByName('subtip').AsString = '(-) TRANSFERÊNCIAS') Or
            (DataSet.FieldByName('subtip').AsString = '(+) OUTRAS ENTRADAS') Or
            (DataSet.FieldByName('subtip').AsString = '(+) BONIFICAÇÃO DE FORNECEDORES') Or
            (DataSet.FieldByName('subtip').AsString = '(-) DEVOLUÇÃO A FORNECEDORES') Or
            (DataSet.FieldByName('subtip').AsString = '(-) GARANTIA DE CLIENTE') Then
    Begin
      frmConferenciaEstoqueContabilDetalhe.cxGridCitelAgrupadoCfopVLRCON.Caption := 'Tot.Med.';
      frmConferenciaEstoqueContabilDetalhe.cxGridCitelAgrupadoCfopVLRCON.DataBinding.FieldName := 'TOTMED';
      frmConferenciaEstoqueContabilDetalhe.cxGridCitel1Level1.GridView := frmConferenciaEstoqueContabilDetalhe.cxGridCitelAgrupadoCfop;
    End

    Else If (DataSet.FieldByName('subtip').AsString = 'TRANSFERÊNCIAS DE MERCADORIAS') Then
    Begin
      frmConferenciaEstoqueContabilDetalhe.cxGridCitelAgrupadoCfopVLRCON.Caption := 'Tot.VlrCon.';
      frmConferenciaEstoqueContabilDetalhe.cxGridCitelAgrupadoCfopVLRCON.DataBinding.FieldName := 'VLRCON';
      frmConferenciaEstoqueContabilDetalhe.cxGridCitel1Level1.GridView := frmConferenciaEstoqueContabilDetalhe.cxGridCitelAgrupadoCfop;
    End

    Else If (DataSet.FieldByName('subtip').AsString = '(+) COMPRAS') Or
            (DataSet.FieldByName('subtip').AsString = '(-) USO/CONSUMO') Then
      frmConferenciaEstoqueContabilDetalhe.cxGridCitel1Level1.GridView := frmConferenciaEstoqueContabilDetalhe.cxGridCitelAgrupadoCfop
    Else If (DataSet.FieldByName('subtip').AsString = '(-) IMPOSTOS RECUPERÁVEIS DE COMPRAS - ICMS') Then
    Begin
      frmConferenciaEstoqueContabilDetalhe.cxGridCitel1Level1.GridView := frmConferenciaEstoqueContabilDetalhe.cxGridCitelAgrupadoCfopRecuperaveis;
      frmConferenciaEstoqueContabilDetalhe.cxGridCitelAgrupadoCfopRecuperaveisIMPREC.Caption := 'Vlr. ICMS';
    End
    Else If (DataSet.FieldByName('subtip').AsString = '(-) IMPOSTOS RECUPERÁVEIS DE COMPRAS - PIS') Then
    Begin
      frmConferenciaEstoqueContabilDetalhe.cxGridCitel1Level1.GridView := frmConferenciaEstoqueContabilDetalhe.cxGridCitelAgrupadoCfopRecuperaveis;
      frmConferenciaEstoqueContabilDetalhe.cxGridCitelAgrupadoCfopRecuperaveisIMPREC.Caption := 'Vlr. PIS';
    End
    Else If (DataSet.FieldByName('subtip').AsString = '(-) IMPOSTOS RECUPERÁVEIS DE COMPRAS - COFINS') Then
    Begin
      frmConferenciaEstoqueContabilDetalhe.cxGridCitel1Level1.GridView := frmConferenciaEstoqueContabilDetalhe.cxGridCitelAgrupadoCfopRecuperaveis;
      frmConferenciaEstoqueContabilDetalhe.cxGridCitelAgrupadoCfopRecuperaveisIMPREC.Caption := 'Vlr. COFINS';
    End
    Else If (DataSet.FieldByName('subtip').AsString = '(+) CONHECIMENTO DE FRETE') Then
    Begin
      frmConferenciaEstoqueContabilDetalhe.cxGridCitel1Level1.GridView := frmConferenciaEstoqueContabilDetalhe.cxGridCitelAgrupadoCfopRecuperaveis;
      frmConferenciaEstoqueContabilDetalhe.cxGridCitelAgrupadoCfopRecuperaveisIMPREC.Caption := 'Vlr. ConFre';
    End
    Else If (DataSet.FieldByName('subtip').AsString = '(+) GNRE') Then
    Begin
      frmConferenciaEstoqueContabilDetalhe.cxGridCitel1Level1.GridView := frmConferenciaEstoqueContabilDetalhe.cxGridCitelAgrupadoCfopRecuperaveis;
      frmConferenciaEstoqueContabilDetalhe.cxGridCitelAgrupadoCfopRecuperaveisIMPREC.Caption := 'Vlr. GNRE';
    End
    Else If (DataSet.FieldByName('subtip').AsString = '(+) AJUSTE DE ESTOQUE') Or
            (DataSet.FieldByName('subtip').AsString = '(-) AJUSTE DE ESTOQUE') Then
      frmConferenciaEstoqueContabilDetalhe.cxGridCitel1Level1.GridView := frmConferenciaEstoqueContabilDetalhe.cxGridCitelAjustes;

    frmConferenciaEstoqueContabilDetalhe.Caption := 'Detalhe: ' + DataSet.FieldByName('subtip').AsString;
    frmConferenciaEstoqueContabilDetalhe.strSqlDetail := DataSet.FieldByName(strField).AsString;
    frmConferenciaEstoqueContabilDetalhe.ShowModal;
  Finally
    pFreeAndNil(frmConferenciaEstoqueContabilDetalhe);
  End;
end;

procedure TfrmConferenciaEstoqueContabil.pButtonSQLClick(Sender: TObject; AButtonIndex: Integer);
  var
    strField : string;
    DataSet : TDataSet;
begin
  strField := 'btnsql';
  pDefineDataSetExibicao(Sender, strField, DataSet);

  if not Assigned(DataSet) then
    exit;

  if not DataSet.Active then
    exit;

  if not Assigned(DataSet.FindField(strField)) then
    exit;

  pCriarFormularios(TfrmObservacao, frmObservacao);
  Try
    frmObservacao.Caption := 'SQL: ' + DataSet.FieldByName('subtip').AsString;
    frmObservacao.btnClipBoard.Visible := True;
    frmObservacao.lblMensagem.Caption := '';
    frmObservacao.memObs.Texto := Trim(DataSet.FieldByName(strField).AsString);
    frmObservacao.BorderIcons := [biSystemMenu, biMaximize];
    frmObservacao.ClientWidth := 800;
    frmObservacao.ClientHeight := 600;
    frmObservacao.ShowModal;
  Finally
    pFreeAndNil(frmObservacao);
  End;
end;

procedure TfrmConferenciaEstoqueContabil.cxButtonEditDetalhesPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pButtonDetalheClick(Sender, AButtonIndex);
end;

procedure TfrmConferenciaEstoqueContabil.cxButtonItemPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pButtonSQLClick(Sender, AButtonIndex);
end;

procedure TfrmConferenciaEstoqueContabil.cxgDadosDBTableViewCitel1btnsqlPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pButtonSQLClick(Sender, AButtonIndex);
end;

procedure TfrmConferenciaEstoqueContabil.cxgDadosDBTableViewCitel1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strOperac: String;
begin
  With cdsDados Do
  Begin
    If Not Active Then
      Exit;

    strOperac := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgDadosDBTableViewCitel1operac.Index]);

    If (strOperac = '+') Then
      ACanvas.Font.Color := clGreen
    Else If (strOperac = '-') Then
      ACanvas.Font.Color := clRed;
  End;
end;

procedure TfrmConferenciaEstoqueContabil.cxgDadosDBTableViewCitel1detalhePropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pButtonDetalheClick(Sender, AButtonIndex);
end;

procedure TfrmConferenciaEstoqueContabil.cxgDadosDBTableViewCitel1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) And (pgcDados.ActivePage = tbsDados) Then
  begin
    pgcDados.ActivePage := tbsFiltros;
    Caption := 'Conferência Estoque Contábil';
    btnGeraExcel.Visible := False;

    if (chkModoDebug.Checked) and (not cdsDados.IsEmpty) and (not fEmptyStr(edtProdutos.Text)) then
    begin
      if (fMensagem('', 'Continuar o processo?', ['&Sim','&Não']) = 1) then
        btnGerar.Click;
    end;
  end;
end;

procedure TfrmConferenciaEstoqueContabil.cxgDadosDBTableViewCitel1TcxGridDBDataControllerTcxDataSummaryDefaultGroupSummaryItems0GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: string);
begin
  inherited;
  AText := ' ' + FloatToStrF(AValue, ffNumber, 15, 2) + ' ';
end;

procedure TfrmConferenciaEstoqueContabil.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrCodEmp, Nil, fRetNomeEmpresaSelec, 'da Empresa', edtCodEmp.TamCampo);
end;

procedure TfrmConferenciaEstoqueContabil.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrCodEmp, False) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConferenciaEstoqueContabil.edtProdutosExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtProdutos, edtDesProduto, arrCadIte, Nil, fRetNomProduto, 'do Produto', edtProdutos.TamCampo);
end;

procedure TfrmConferenciaEstoqueContabil.edtProdutosKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryGenIte: TUniQuery;
begin
  qryGenIte := fCriaQuery(nil);
  try
    If fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, qryGenIte, Key, arrCadIte, False, nil, 'Consulta de Itens', '1') Then
      Self.SelectNext(ActiveControl, True, True);
  finally
    FreeAndNil(qryGenIte);
  end;
end;

procedure TfrmConferenciaEstoqueContabil.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskPeriodo);
end;

procedure TfrmConferenciaEstoqueContabil.FormCreate(Sender: TObject);
begin
  inherited;
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa;
  cdsDados := fCriarCdsDados;
  dtsDados.DataSet := cdsDados;
  pgcDados.ActivePageIndex := 0;
  mskPeriodo.Text := fPeriodoAnteriorMascara;
  qryItensPeriodo := fCriaQuery(Self);
  strPeriodoCarregado := '';
  intTamanhoCodIte := Contabilidade.Funcoes.fTamCodIte;
  cdsColunado := nil;

  strSQLInicial    := '';
  strSQLEntradas   := '';
  strSQLSaidas     := '';
  strSQLSaldoFinal := '';
  strSQLDiferenca  := '';

  strSQLDetInicial    := '';
  strSQLDetEntradas   := '';
  strSQLDetSaidas     := '';
  strSQLDetSaldoFinal := '';
  strSQLDetDiferenca  := '';
end;

procedure TfrmConferenciaEstoqueContabil.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsDados);
  FreeAndNil(qryItensPeriodo);

  if Assigned(cdsColunado) then
    FreeAndNil(cdsColunado);

  inherited;
end;

procedure TfrmConferenciaEstoqueContabil.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Shift = [ssAlt]) And (Key = VK_F7) Then
    chkModoDebug.Visible := not chkModoDebug.Visible;
end;

procedure TfrmConferenciaEstoqueContabil.FormShow(Sender: TObject);
begin
  inherited;
  cxgDadosDBTableViewCitel1btnsql.Visible := fEhAdministrador(strLoginUsuarioLogado);
  cxgDadosDBTableViewCitel1SomaQtd.Visible := True;
  chkModoDebug.Visible := False;

  edtProdutos.MaxLength := intTamanhoCodIte;
  edtProdutos.TamCampo := intTamanhoCodIte;
  FClienteFilialLocate := fRetClientesFilialLocate;
end;

procedure TfrmConferenciaEstoqueContabil.pAjusteEntradas;
  Var
    qryDados : TUniQuery;
    qryDetal : TUniQuery;
begin
  pSetaTextoStatus('Ajustes de Estoque...');
  qryDados := fCriaQuery(Self);
  qryDetal := fCriaQuery(Self);
  Try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(' SELECT SUM(D.DET_TOTMED) AS VALTOT, SUM(DET_QTDITE) AS QTDITE ');
    qryDados.SQL.Add('   FROM MOVDET D ');
    qryDados.SQL.Add(' 	INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDados.SQL.Add(' 	INNER JOIN CADITE ON ITE_CODITE = DET_CODITE ');
    qryDados.SQL.Add('  WHERE TRUE ');
    qryDados.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDados.SQL.Add('  	AND D.DET_CLAFIS = "1999" ');
    qryDados.SQL.Add('    AND D.DET_ESPDOC = "AJ" ');

    pSetaFiltroComum(qryDados);
    pSetaParametros(qryDados);

    //--
    qryDetal.Close;
    qryDetal.SQL.Clear;
    qryDetal.SQL.Add(' SELECT ' + fGetColunasAgrupamentoCfop );
    qryDetal.SQL.Add('   FROM MOVDET D ');
    qryDetal.SQL.Add(' 	INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDetal.SQL.Add(' 	INNER JOIN CADITE ON ITE_CODITE = DET_CODITE ');
    qryDetal.SQL.Add('   LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ');
    qryDetal.SQL.Add('   LEFT JOIN CADCLI ON CLI_CODCLI = D.DET_CODCLI ');
    qryDetal.SQL.Add('   LEFT JOIN CADFOR ON FOR_CODFOR = D.DET_CODFOR ');
    qryDetal.SQL.Add('  WHERE TRUE ');
    qryDetal.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDetal.SQL.Add('  	AND D.DET_CLAFIS = "1999" ');
    qryDetal.SQL.Add('    AND D.DET_ESPDOC = "AJ" ');

    pSetaFiltroComum(qryDetal);
    pSetaParametros(qryDetal);
    //--

    qryDados.Open;
    strSQLEntradas := strSQLEntradas + IIF(fEmptyStr(strSQLEntradas), '', ' UNION ALL ') + ' SELECT IFNULL(VALTOT,0) AS VALTOT, IFNULL(QTDITE,0) AS QTDITE FROM ( ' + fSQLBind(qryDados) + ' ) AS TAB';
    strSQLDetEntradas := strSQLDetEntradas + IIF(fEmptyStr(strSQLDetEntradas), '', ' UNION ALL ') + ' SELECT ENT.CODITE, ENT.DESCRI, ENT.REFERE, ENT.UNIDAD, SUM(IFNULL(ENT.QTDITE,0)) AS VALTOT FROM ( ' + fSQLBind(qryDetal) + ' ) AS ENT GROUP BY ENT.CODITE';
    pInsertDados('2 - ENTRADAS', '(+) AJUSTE DE ESTOQUE', qryDados.FieldByName('VALTOT').AsFloat, '+', fSQLBind(qryDados), fSQLBind(qryDetal), False, qryDados.FieldByName('QTDITE').AsFloat);
    qryDados.Close;
  Finally
    FreeAndNil(qryDados);
    FreeAndNil(qryDetal);
  End;
end;

procedure TfrmConferenciaEstoqueContabil.pAjustesSaidas;
  Var
    qryDados : TUniQuery;
    qryDetal : TUniQuery;
begin
  pSetaTextoStatus('Ajustes de Saída...');
  qryDados := fCriaQuery(Self);
  qryDetal := fCriaQuery(Self);
  Try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(' SELECT SUM(D.DET_TOTMED) AS VALTOT, SUM(D.DET_QTDITE) AS QTDITE ');
    qryDados.SQL.Add('   FROM MOVDET D ');
    qryDados.SQL.Add(' 	INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDados.SQL.Add(' 	INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDados.SQL.Add('  WHERE TRUE ');
    qryDados.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDados.SQL.Add(' 	  AND D.DET_CLAFIS = "5999" ');
    qryDados.SQL.Add('    AND D.DET_ESPDOC = "AJ" ');

    pSetaFiltroComum(qryDados);
    pSetaParametros(qryDados);

    //--
    qryDetal.Close;
    qryDetal.SQL.Clear;
    qryDetal.SQL.Add(' SELECT ' + fGetColunasAgrupamentoCfop);
    qryDetal.SQL.Add('   FROM MOVDET D ');
    qryDetal.SQL.Add(' 	INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDetal.SQL.Add(' 	INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDetal.SQL.Add('   LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ');
    qryDetal.SQL.Add('   LEFT JOIN CADCLI ON CLI_CODCLI = D.DET_CODCLI ');
    qryDetal.SQL.Add('   LEFT JOIN CADFOR ON FOR_CODFOR = D.DET_CODFOR ');
    qryDetal.SQL.Add('  WHERE TRUE ');
    qryDetal.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDetal.SQL.Add(' 	  AND D.DET_CLAFIS = "5999" ');
    qryDetal.SQL.Add('    AND D.DET_ESPDOC = "AJ" ');

    pSetaFiltroComum(qryDetal);
    pSetaParametros(qryDetal);

    //--

    qryDados.Open;
    strSQLSaidas := strSQLSaidas + IIF(fEmptyStr(strSQLSaidas), '', ' UNION ALL ') + ' SELECT -IFNULL(VALTOT,0) AS VALTOT, -IFNULL(QTDITE,0) AS QTDITE FROM ( ' + fSQLBind(qryDados) + ' ) AS TAB ';
    strSQLDetSaidas := strSQLDetSaidas + IIF(fEmptyStr(strSQLDetSaidas), '', ' UNION ALL ') + ' SELECT SAI.CODITE, SAI.DESCRI, SAI.REFERE, SAI.UNIDAD, SUM(-IFNULL(SAI.QTDITE,0)) AS VALTOT FROM ( ' + fSQLBind(qryDetal) + ' ) AS SAI GROUP BY SAI.CODITE';
    pInsertDados('3 - SAÍDAS', '(-) AJUSTE DE ESTOQUE', qryDados.FieldByName('VALTOT').AsFloat, '-', fSQLBind(qryDados), fSQLBind(qryDetal), False, qryDados.FieldByName('QTDITE').AsFloat);
    qryDados.Close;
  Finally
    FreeANdNil(qryDados);
    FreeAndNil(qryDetal);
  End;
end;

procedure TfrmConferenciaEstoqueContabil.pApresentarDados(arrEmpresas: TConsultasArray);
begin
  Caption := 'Conferência Estoque Contábil - Período: ' + mskPeriodo.Text;

  if not fEmptyStr(edtCodEmp.Text) then
  begin
    if (Length(arrEmpresas) > 1) then
      Caption := Caption + ' - Empresas: ' + fGetStrCodigos(edtCodEmp, arrEmpresas, False)
    else
      Caption := Caption + ' - Empresa: ' + edtCodEmp.Text + ' - ' + edtNomEmp.Text;
  end;

  if not fEmptyStr(edtProdutos.Text) then
  begin
    if (edtProdutos.Text = StringOfChar('0', edtProdutos.TamCampo)) then
      Caption := Caption + ' - Produtos: ' + fGetStrCodigos(edtProdutos, arrCadIte, False)
    else
      Caption := Caption + ' - Produto: ' + edtProdutos.Text + ' - ' + edtDesProduto.Text;
  end;

  cxgDadosDBTableViewCitel1.ViewData.Expand(True);
  cxgDadosDBTableViewCitel1.DataController.GotoFirst;
  pgcDados.ActivePage := tbsDados;
  btnGeraExcel.Visible := True;
end;

procedure TfrmConferenciaEstoqueContabil.pBonificacaoDeClientes;
  Var
    qryDados : TUniQuery;
    qryDetal : TUniQuery;
begin
  pSetaTextoStatus('Saídas (Bonificação de Clientes)...');
  qryDados := fCriaQuery(Self);
  qryDetal := fCriaQuery(Self);
  Try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add('	SELECT ');
    qryDados.SQL.Add('		SUM(IF(LEFT(D.DET_CLAFIS,1) < 5, -D.DET_TOTMED,D.DET_TOTMED)) AS VALTOT, ');
    qryDados.SQL.Add('		SUM(D.DET_QTDITE) AS QTDITE ');
    qryDados.SQL.Add('	FROM MOVDET D ');
    qryDados.SQL.Add('		INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDados.SQL.Add(' 	  INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDados.SQL.Add('	WHERE TRUE ');
    qryDados.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDados.SQL.Add('		AND D.DET_PROEMB <> "S" ');
    qryDados.SQL.Add('    AND D.DET_CLAFIS IN ("5910", "6910") ');

    pSetaFiltroComum(qryDados);
    pSetaParametros(qryDados);

    //--
    qryDetal.Close;
    qryDetal.SQL.Clear;
    qryDetal.SQL.Add(' SELECT ' + fGetColunasAgrupamentoCfop);
    qryDetal.SQL.Add('   FROM MOVDET D ');
    qryDetal.SQL.Add('		INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDetal.SQL.Add(' 	  INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDetal.SQL.Add('     LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ');
    qryDetal.SQL.Add('     LEFT JOIN CADCLI ON CLI_CODCLI = D.DET_CODCLI ');
    qryDetal.SQL.Add('     LEFT JOIN CADFOR ON FOR_CODFOR = D.DET_CODFOR ');
    qryDetal.SQL.Add('	WHERE TRUE ');
    qryDetal.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDetal.SQL.Add('		AND D.DET_PROEMB <> "S" ');
    qryDetal.SQL.Add('    AND D.DET_CLAFIS IN ("5910", "6910") ');

    pSetaFiltroComum(qryDetal);
    pSetaParametros(qryDetal);
    //--

    qryDados.Open;
    strSQLSaidas := strSQLSaidas + IIF(fEmptyStr(strSQLSaidas), '', ' UNION ALL ') + ' SELECT -IFNULL(VALTOT,0) AS VALTOT, -IFNULL(QTDITE,0) AS QTDITE FROM ( ' + fSQLBind(qryDados) + ' ) AS TAB ';
    strSQLDetSaidas := strSQLDetSaidas + IIF(fEmptyStr(strSQLDetSaidas), '', ' UNION ALL ') + ' SELECT SAI.CODITE, SAI.DESCRI, SAI.REFERE, SAI.UNIDAD, SUM(-IFNULL(SAI.QTDITE,0)) AS VALTOT FROM ( ' + fSQLBind(qryDetal) + ' ) AS SAI GROUP BY SAI.CODITE';
    pInsertDados('3 - SAÍDAS', '(-) BONIFICAÇÃO DE CLIENTES', qryDados.FieldByName('VALTOT').AsFloat, '-', fSQLBind(qryDados), fSQLBind(qryDetal), False, qryDados.FieldByName('QTDITE').AsFloat);
    qryDados.Close;

  Finally
    FreeAndNil(qryDados);
    FreeAndNil(qryDetal);
  End;
end;

procedure TfrmConferenciaEstoqueContabil.pBonificadaoDeFornecedores;
  Var
    qryDados : TUniQuery;
    qryDetal : TUniQuery;
begin
  pSetaTextoStatus('Entradas (Bonificação de Fornecedores)...');
  qryDados := fCriaQuery(Self);
  qryDetal := fCriaQuery(Self);
  Try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add('	SELECT ');
    qryDados.SQL.Add('		SUM(D.DET_TOTMED) AS VALTOT, SUM(D.DET_QTDITE) AS QTDITE ');
    qryDados.SQL.Add('	FROM MOVDET D ');
    qryDados.SQL.Add('		INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDados.SQL.Add(' 	  INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDados.SQL.Add('	WHERE TRUE ');
    qryDados.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDados.SQL.Add('		AND D.DET_PROEMB <> "S" ');
    qryDados.SQL.Add('    AND D.DET_CLAFIS IN ("1910", "2910") ');

    pSetaFiltroComum(qryDados);
    pSetaParametros(qryDados);

    //--
    qryDetal.Close;
    qryDetal.SQL.Clear;
    qryDetal.SQL.Add(' SELECT ' + fGetColunasAgrupamentoCfop);
    qryDetal.SQL.Add('   FROM MOVDET D ');
    qryDetal.SQL.Add('		INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDetal.SQL.Add(' 	  INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDetal.SQL.Add('     LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ');
    qryDetal.SQL.Add('     LEFT JOIN CADCLI ON CLI_CODCLI = D.DET_CODCLI ');
    qryDetal.SQL.Add('     LEFT JOIN CADFOR ON FOR_CODFOR = D.DET_CODFOR ');
    qryDetal.SQL.Add('	WHERE TRUE ');
    qryDetal.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDetal.SQL.Add('		AND D.DET_PROEMB <> "S" ');
    qryDetal.SQL.Add('    AND D.DET_CLAFIS IN ("1910", "2910") ');

    pSetaFiltroComum(qryDetal);
    pSetaParametros(qryDetal);
    //--

    qryDados.Open;
    strSQLEntradas := strSQLEntradas + IIF(fEmptyStr(strSQLEntradas), '', ' UNION ALL ') + ' SELECT IFNULL(VALTOT,0) AS VALTOT, IFNULL(QTDITE,0) AS QTDITE FROM ( ' + fSQLBind(qryDados) + ' ) AS TAB ';
    strSQLDetEntradas := strSQLDetEntradas + IIF(fEmptyStr(strSQLDetEntradas), '', ' UNION ALL ') + ' SELECT ENT.CODITE, ENT.DESCRI, ENT.REFERE, ENT.UNIDAD, SUM(IFNULL(ENT.QTDITE,0)) AS VALTOT FROM ( ' + fSQLBind(qryDetal) + ' ) AS ENT GROUP BY ENT.CODITE';
    pInsertDados('2 - ENTRADAS', '(+) BONIFICAÇÃO DE FORNECEDORES', qryDados.FieldByName('VALTOT').AsFloat, '+', fSQLBind(qryDados), fSQLBind(qryDetal), False, qryDados.FieldByName('QTDITE').AsFloat);
    qryDados.Close;

  Finally
    FreeAndNil(qryDados);
    FreeAndNil(qryDetal);
  End;
end;

procedure TfrmConferenciaEstoqueContabil.pColorirColunasDasEmpresas(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  var
    strEmp : string;
    intCor : Integer;
begin
  strEmp := RightStr(TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName, 3);
  if not fEmptyStr(strEmp) then
  begin
    intCor := StrToIntDef(fCampoTabela('EMP_CORFUN', 'CADEMP', ['EMP_CODEMP'], [strEmp], False), 0);
    if intCor = 0 then
      intCor := clWhite;
    ACanvas.Brush.Color := intCor;
  end;
end;

procedure TfrmConferenciaEstoqueContabil.pCompras;
  Var
    qryDados : TUniQuery;
    qryDetal : TUniQuery;
begin
  pSetaTextoStatus('Compras...');

  qryDados := fCriaQuery(Self);
  qryDetal := fCriaQuery(Self);
  Try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(' SELECT SUM(DET_VLRCON) AS VALTOT, SUM(DET_QTDITE) AS QTDITE ');
    qryDados.SQL.Add('   FROM MOVDET D ');
   	qryDados.SQL.Add('  INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
  	qryDados.SQL.Add('  INNER JOIN MOVGER G ON G.AUTOINCREM = D.DET_SEQGER ');
    qryDados.SQL.Add(' 	INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDados.SQL.Add('  WHERE TRUE ');
    qryDados.SQL.Add('  AND D.DET_FILKAR = 0 ');
    qryDados.SQL.Add('	AND D.DET_TIP_FC = "F" ');
    qryDados.SQL.Add('  AND D.DET_PROEMB <> "S" ');
    qryDados.SQL.Add('	AND LOCATE(D.DET_CLAFIS, :CLACOM) ');
    //qryDados.SQL.Add('  AND NOT(LOCATE(D.DET_CODFOR, :FORFIL)) ');

    pSetaFiltroComum(qryDados);
    pSetaParametros(qryDados);

    qryDados.ParamByName('CLACOM').AsString := fTransform(fCfgSis('CLACOM', varString), 4, '_');
    //qryDados.ParamByName('FORFIL').AsString := fRetForFilialTodos(False);

    //
    qryDetal.Close;
    qryDetal.SQL.Clear;
    qryDetal.SQL.Add(' SELECT ' + fGetColunasAgrupamentoCfop);
    qryDetal.SQL.Add('   FROM MOVDET D ');
   	qryDetal.SQL.Add('  INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
  	qryDetal.SQL.Add('  INNER JOIN MOVGER G ON G.AUTOINCREM = D.DET_SEQGER ');
    qryDetal.SQL.Add(' 	INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDetal.SQL.Add('   LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ');
    qryDetal.SQL.Add('   LEFT JOIN CADCLI ON CLI_CODCLI = D.DET_CODCLI ');
    qryDetal.SQL.Add('   LEFT JOIN CADFOR ON FOR_CODFOR = D.DET_CODFOR ');
    qryDetal.SQL.Add('  WHERE TRUE ');
    qryDetal.SQL.Add('  AND D.DET_FILKAR = 0 ');
    qryDetal.SQL.Add('	AND D.DET_TIP_FC = "F" ');
    qryDetal.SQL.Add('  AND D.DET_PROEMB <> "S" ');
    qryDetal.SQL.Add('	AND LOCATE(D.DET_CLAFIS, :CLACOM) ');
    //qryDetal.SQL.Add('  AND NOT(LOCATE(D.DET_CODFOR, :FORFIL)) ');

    pSetaFiltroComum(qryDetal);
    pSetaParametros(qryDetal);

    qryDetal.ParamByName('CLACOM').AsString := fTransform(fCfgSis('CLACOM', varString), 4, '_');
    //qryDetal.ParamByName('FORFIL').AsString := fRetForFilialTodos(False);
    //

    qryDados.Open;
    strSQLEntradas := strSQLEntradas + IIF(fEmptyStr(strSQLEntradas), '', ' UNION ALL ') + ' SELECT IFNULL(VALTOT,0) AS VALTOT, IFNULL(QTDITE,0) AS QTDITE FROM ( ' + fSQLBind(qryDados) + ' ) AS TAB ';
    strSQLDetEntradas := strSQLDetEntradas + IIF(fEmptyStr(strSQLDetEntradas), '', ' UNION ALL ') + ' SELECT ENT.CODITE, ENT.DESCRI, ENT.REFERE, ENT.UNIDAD, SUM(IFNULL(ENT.QTDITE,0)) AS VALTOT FROM ( ' + fSQLBind(qryDetal) + ' ) AS ENT GROUP BY ENT.CODITE';
    pInsertDados('2 - ENTRADAS', '(+) COMPRAS', qryDados.FieldByName('VALTOT').AsFloat, '+', fSQLBind(qryDados), fSQLBind(qryDetal), False, qryDados.FieldByName('QTDITE').AsFloat);
    qryDados.Close;
  Finally
    FreeAndNil(qryDados);
    FreeAndNil(qryDetal);
  End;
end;

function TfrmConferenciaEstoqueContabil.fCriarCdsDados(arrEmpresas: TConsultasArray = nil): TUniClientDataSet;
  var
    intCnt : Integer;
begin
  Result := TUniClientDataSet.Create(Nil);
  With Result, FieldDefs Do
  Begin
    With AddFieldDef Do
    Begin
      Name     := 'tipmov';
      DataType := ftString;
      Size     := 50;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name     := 'subtip';
      DataType := ftString;
      Size     := 50;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'valor';
      DataType := ftFloat;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'detalh';
      DataType := ftString;
      Size     := 3;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'operac';
      DataType := ftString;
      Size     := 1;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'sequen';
      DataType := ftInteger;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'btnsql';
      DataType := ftMemo;
    End;

    With AddFieldDef Do
    Begin
      Name := 'SomaQtd';
      DataType := ftFloat;
    End;

    With AddFieldDef Do
    Begin
      Name := 'SqlDet';
      DataType := ftMemo;
    End;

    if (Length(arrEmpresas) > 0) then
    begin
      for intCnt := Low(arrEmpresas) to High(arrEmpresas) do
      begin
        With AddFieldDef Do
        Begin
          Name := 'valor_' + arrEmpresas[intCnt].strCodigo;
          DataType := ftFloat;
          Required := False;
        End;

        With cxgDadosDBTableViewCitel1.CreateColumn Do
        Begin
          Tag := 99;
          DataBinding.FieldName := 'valor_' + arrEmpresas[intCnt].strCodigo;
          Caption := 'Valor (' + arrEmpresas[intCnt].strCodigo + ')';
          Width := cxgDadosDBTableViewCitel1valor.Width;
          Options := cxgDadosDBTableViewCitel1valor.Options;
          OnCustomDrawCell := pColorirColunasDasEmpresas;
        End;

        With AddFieldDef Do
        Begin
          Name := 'btnsql_' + arrEmpresas[intCnt].strCodigo;
          DataType := ftMemo;
        End;

        With cxgDadosDBTableViewCitel1.CreateColumn Do
        Begin
          Tag := 99;
          DataBinding.FieldName := 'btnsql_' + arrEmpresas[intCnt].strCodigo;
          Caption := 'SQL (' + arrEmpresas[intCnt].strCodigo + ')';
          Width := cxgDadosDBTableViewCitel1btnsql.Width;
          Visible := fEhAdministrador(strLoginUsuarioLogado);
          OnGetProperties := GetPropertiesButtonSQL;
          OnCustomDrawCell := pColorirColunasDasEmpresas;
        End;

        With AddFieldDef Do
        Begin
          Name := 'SomaQtd_' + arrEmpresas[intCnt].strCodigo;
          DataType := ftFloat;
        End;

        With cxgDadosDBTableViewCitel1.CreateColumn Do
        Begin
          Tag := 99;
          DataBinding.FieldName := 'SomaQtd_' + arrEmpresas[intCnt].strCodigo;
          Caption := 'Quantidade (' + arrEmpresas[intCnt].strCodigo + ')';
          Width := cxgDadosDBTableViewCitel1SomaQtd.Width;
          OnCustomDrawCell := pColorirColunasDasEmpresas;
        End;

        With AddFieldDef Do
        Begin
          Name := 'detalh_' + arrEmpresas[intCnt].strCodigo;
          DataType := ftString;
          Size     := 3;
          Required := False;
        End;

        With cxgDadosDBTableViewCitel1.CreateColumn Do
        Begin
          Tag := 99;
          DataBinding.FieldName := 'detalh_' + arrEmpresas[intCnt].strCodigo;
          Caption := 'Detalhe (' + arrEmpresas[intCnt].strCodigo + ')';
          Width := cxgDadosDBTableViewCitel1detalhe.Width;
          OnGetProperties := GetPropertiesButtonDetalhes;
          OnCustomDrawCell := pColorirColunasDasEmpresas;
        End;

        With AddFieldDef Do
        Begin
          Name := 'SqlDet_' + arrEmpresas[intCnt].strCodigo;
          DataType := ftMemo;
        End;
      end;
    end;

    IndexFieldNames := 'tipmov;sequen';
    CreateDataSet;
    Open;

    TFloatField(Result.FieldByName('valor')).DisplayFormat := '##,#0.00';
    TFloatField(Result.FieldByName('SomaQtd')).DisplayFormat := '##,#0.00';

    if (Length(arrEmpresas) > 0) then
    begin
      for intCnt := Low(arrEmpresas) to High(arrEmpresas) do
      begin
        TFloatField(Result.FieldByName('valor_' + arrEmpresas[intCnt].strCodigo)).DisplayFormat := '##,#0.00';
        TFloatField(Result.FieldByName('SomaQtd_' + arrEmpresas[intCnt].strCodigo)).DisplayFormat := '##,#0.00';
      end;
    end;
  End;
end;

procedure TfrmConferenciaEstoqueContabil.pImpostosRecuperaveisDeCompras;

  function fGetColunasAgrupamentoRecuperaveis(strCampo: String; strTabela: String): String;
  begin
    Result := '';
    Result := Result + ' DET_CLAFIS AS CLAFIS, DET_DTAENT AS DTAENT, DET_NUMDOC AS NUMDOC, ';
    Result := Result + ' DET_ESPDOC AS ESPDOC, DET_CODEMP AS CODEMP, IFNULL(DET_CODCLI, DET_CODFOR) AS CLIFOR, ';
    Result := Result + ' DET_CODITE AS CODITE, DET_DESCRI AS DESCRI, DET_QTDITE AS QTDITE, DET_UNITAR AS UNITAR, ';
    Result := Result + ' DET_TOTITE AS TOTITE, ITE_REFERE AS REFERE, UNI_SIGUNI AS UNIDAD, ';

    If (strCampo = 'VALICM') Then
      Result := Result + ' D.DET_VALICM AS IMPREC, '
    Else If (strCampo = 'VALPIS') Then
      Result := Result + ' IF(F.FIS_CLFSC1 IN ("5929", "6929"), 0, 1) * COALESCE(T.DET_VALPIS, 0) AS IMPREC, '
    Else If (strCampo = 'VALCOF') Then
      Result := Result + ' IF(F.FIS_CLFSC1 IN ("5929", "6929"), 0, 1) * COALESCE(T.DET_VALCOF, 0) AS IMPREC, '
    Else If (strCampo = 'CONFRE') And (strTabela = 'MOVDET') Then
      Result := Result + ' T.DET_CONFRE AS IMPREC, '
    Else If (strCampo = 'CONFRE') And (strTabela = 'NOTDET') Then
      Result := Result + ' 0.00 AS IMPREC, '
    Else If (strCampo = 'VLGNRE') Then
      Result := Result + ' T.DET_VLGNRE AS IMPREC, ';

    Result := Result + ' CONCAT(DATE_FORMAT(DET_DTAENT, "%d/%m/%Y"), "-", DET_NUMDOC, "-", DET_ESPDOC, "-", DET_CODEMP, "-", IFNULL(DET_CODCLI, DET_CODFOR), "-", IFNULL(FOR_NOMFOR,"")) AS AGRUP2 ';
  end;

  procedure pGetDetal(strDesVal: String; qryDetal: TUniQuery);
  begin
    qryDetal.Close;
    qryDetal.SQL.Clear;
    qryDetal.SQL.Add('  SELECT ' + fGetColunasAgrupamentoRecuperaveis(strDesVal, 'MOVDET'));
    qryDetal.SQL.Add('   	FROM MOVDET D ');
    qryDetal.SQL.Add('   		INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDetal.SQL.Add('   		INNER JOIN CADFIS F ON D.DET_NUMDOC = F.FIS_NUMDOC ');
    qryDetal.SQL.Add('                         AND D.DET_ESPDOC = F.FIS_ESPDOC ');
    qryDetal.SQL.Add('                         AND D.DET_CODEMP = F.FIS_CODEMP ');
    qryDetal.SQL.Add('                         AND D.DET_CODFOR = F.FIS_FORCLI ');
    qryDetal.SQL.Add('                         AND D.DET_TIP_FC = F.FIS_TIP_FC ');
    qryDetal.SQL.Add('                         AND D.DET_ORIDOC = F.FIS_ORIDOC ');
    qryDetal.SQL.Add('                         AND IFNULL(D.DET_SERIE_, "") = IFNULL(F.FIS_SERIE_, "") ');
    qryDetal.SQL.Add('   				JOIN CADFOR ON FOR_CODFOR = D.DET_CODFOR ');
    qryDetal.SQL.Add(' 	  INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDetal.SQL.Add(' 	   LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ');
    qryDetal.SQL.Add('   	WHERE TRUE ');
    qryDetal.SQL.Add('   	  AND D.DET_FILKAR = 0 ');
    qryDetal.SQL.Add('   		AND D.DET_TIP_FC = "F" ');
    qryDetal.SQL.Add('   		AND D.DET_PROEMB <> "S" ');
    qryDetal.SQL.Add('   		AND LOCATE(D.DET_CLAFIS, :CLACOM) ');
    //qryDetal.SQL.Add('   		AND NOT(LOCATE(D.DET_CODFOR,:FORFIL)) ');

    pSetaFiltroComum(qryDetal);

    qryDetal.SQL.Add('   		AND (IFNULL(F.FIS_HISTOR, "") <> "CANCELADO") ');
    qryDetal.SQL.Add('   		AND (LOCATE(IFNULL(D.DET_CLAFIS, ""), "1999_5999") <= 0) ');

    qryDetal.ParamByName('CLACOM').AsString := fTransform(fCfgSis('CLACOM'), 4, '_');
    //qryDetal.ParamByName('FORFIL').AsString := fRetForFilialTodos(False);

    pSetaParametros(qryDetal);
  end;

  Var
    qryDados : TUniQuery;
    qryDetIcm : TUniQuery;
    qryDetPis : TUniQuery;
    qryDetCof : TUniQuery;
    qryConFre : TUniQuery;
    qryVlgNre : TUniQuery;
begin
  pSetaTextoStatus('Impostos Recuperáveis de Compras...');
  qryDados := fCriaQuery(Self);
  qryDetIcm := fCriaQuery(Self);
  qryDetPis := fCriaQuery(Self);
  qryDetCof := fCriaQuery(Self);
  qryConFre := fCriaQuery(Self);
  qryVlgNre := fCriaQuery(Self);
  Try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(' SELECT SUM(VALICM) AS VALICM, ');
   	qryDados.SQL.Add('        SUM(VALPIS) AS VALPIS, ');
  	qryDados.SQL.Add('        SUM(VALCOF) AS VALCOF, ');
    qryDados.SQL.Add('   		  SUM(CONFRE) AS CONFRE, ');
    qryDados.SQL.Add('   		  SUM(VLGNRE) AS VLGNRE, ');
    qryDados.SQL.Add('        SUM(QTDITE) AS QTDITE  ');
    qryDados.SQL.Add('   FROM ');
    qryDados.SQL.Add('   ( ');
    qryDados.SQL.Add('   	SELECT ');
    qryDados.SQL.Add('   		SUM(D.DET_VALICM) AS VALICM, ');
    qryDados.SQL.Add('   		SUM(IFNULL(T.DET_CONFRE,0)) AS CONFRE, ');
    qryDados.SQL.Add('   		SUM(IFNULL(T.DET_VLGNRE,0)) AS VLGNRE, ');
    qryDados.SQL.Add('   		SUM(IF(F.FIS_CLFSC1 IN ("5929", "6929"), 0, 1) * COALESCE(T.DET_VALPIS, 0)) AS VALPIS, ');
    qryDados.SQL.Add('   		SUM(IF(F.FIS_CLFSC1 IN ("5929", "6929"), 0, 1) * COALESCE(T.DET_VALCOF, 0)) AS VALCOF, ');
    qryDados.SQL.Add('   		SUM(D.DET_QTDITE) AS QTDITE  ');
    qryDados.SQL.Add('   	FROM MOVDET D ');
    qryDados.SQL.Add('   		INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDados.SQL.Add('   		INNER JOIN CADFIS F ON D.DET_NUMDOC = F.FIS_NUMDOC ');
    qryDados.SQL.Add('                         AND D.DET_ESPDOC = F.FIS_ESPDOC ');
    qryDados.SQL.Add('                         AND D.DET_CODEMP = F.FIS_CODEMP ');
    qryDados.SQL.Add('                         AND D.DET_CODFOR = F.FIS_FORCLI ');
    qryDados.SQL.Add('                         AND D.DET_TIP_FC = F.FIS_TIP_FC ');
    qryDados.SQL.Add('                         AND D.DET_ORIDOC = F.FIS_ORIDOC ');
    qryDados.SQL.Add('                         AND IFNULL(D.DET_SERIE_, "") = IFNULL(F.FIS_SERIE_, "") ');
    qryDados.SQL.Add(' 	  INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDados.SQL.Add('   	WHERE TRUE ');
    qryDados.SQL.Add('   	  AND D.DET_FILKAR = 0 ');
    qryDados.SQL.Add('   		AND D.DET_TIP_FC = "F" ');
    qryDados.SQL.Add('   		AND D.DET_PROEMB <> "S" ');
    qryDados.SQL.Add('   		AND LOCATE(D.DET_CLAFIS, :CLACOM) ');
    //qryDados.SQL.Add('   		AND NOT(LOCATE(D.DET_CODFOR,:FORFIL)) ');

    pSetaFiltroComum(qryDados);

    qryDados.SQL.Add('   		AND (IFNULL(F.FIS_HISTOR, "") <> "CANCELADO") ');
    qryDados.SQL.Add('   		AND (LOCATE(IFNULL(D.DET_CLAFIS, ""), "1999_5999") <= 0) ');

    qryDados.SQL.Add('	) AS TAB ');

    qryDados.ParamByName('CLACOM').AsString := fTransform(fCfgSis('CLACOM'), 4, '_');
    //qryDados.ParamByName('FORFIL').AsString := fRetForFilialTodos(False);

    pSetaParametros(qryDados);

    //--
    pGetDetal('VALICM', qryDetIcm);
    pGetDetal('VALPIS', qryDetPis);
    pGetDetal('VALCOF', qryDetCof);
    pGetDetal('CONFRE', qryConFre);
    pGetDetal('VLGNRE', qryVlgNre);
    //--

    qryDados.Open;
    strSQLEntradas := strSQLEntradas + IIF(fEmptyStr(strSQLEntradas), '', ' UNION ALL ') + ' SELECT (-IFNULL(VALICM,0) -IFNULL(VALPIS,0) -IFNULL(VALCOF,0) +IFNULL(CONFRE,0) +IFNULL(VLGNRE,0)) AS VALTOT, 0 AS QTDITE FROM ( ' + fSQLBind(qryDados) + ' ) AS TAB ';
    strSQLDetEntradas := strSQLDetEntradas + IIF(fEmptyStr(strSQLDetEntradas), '', ' UNION ALL ') + ' SELECT ENT.CODITE, ENT.DESCRI, ENT.REFERE, ENT.UNIDAD, SUM(IFNULL(ENT.QTDITE,0)) AS VALTOT FROM ( ';
    strSQLDetEntradas := strSQLDetEntradas + ' SELECT ENT1.CODITE, ENT1.DESCRI, ENT1.REFERE, ENT1.UNIDAD, -ENT1.QTDITE AS QTDITE FROM ( ' + fSQLBind(qryDetIcm) + ' ) AS ENT1 ';
    strSQLDetEntradas := strSQLDetEntradas + ' UNION ALL ';
    strSQLDetEntradas := strSQLDetEntradas + ' SELECT ENT2.CODITE, ENT2.DESCRI, ENT2.REFERE, ENT2.UNIDAD, -ENT2.QTDITE AS QTDITE FROM ( ' + fSQLBind(qryDetPis) + ' ) AS ENT2 ';
    strSQLDetEntradas := strSQLDetEntradas + ' UNION ALL ';
    strSQLDetEntradas := strSQLDetEntradas + ' SELECT ENT3.CODITE, ENT3.DESCRI, ENT3.REFERE, ENT3.UNIDAD, -ENT3.QTDITE AS QTDITE FROM ( ' + fSQLBind(qryDetCof) + ' ) AS ENT3 ';
    strSQLDetEntradas := strSQLDetEntradas + ' UNION ALL ';
    strSQLDetEntradas := strSQLDetEntradas + ' SELECT ENT4.CODITE, ENT4.DESCRI, ENT4.REFERE, ENT4.UNIDAD,  ENT4.QTDITE FROM ( ' + fSQLBind(qryConFre) + ' ) AS ENT4 ';
    strSQLDetEntradas := strSQLDetEntradas + ' UNION ALL ';
    strSQLDetEntradas := strSQLDetEntradas + ' SELECT ENT5.CODITE, ENT5.DESCRI, ENT5.REFERE, ENT5.UNIDAD,  ENT5.QTDITE FROM ( ' + fSQLBind(qryVlgNre) + ' ) AS ENT5 ';
    strSQLDetEntradas := strSQLDetEntradas + ' ) AS ENT GROUP BY ENT.CODITE';
    pInsertDados('2 - ENTRADAS', '(-) IMPOSTOS RECUPERÁVEIS DE COMPRAS - ICMS',   qryDados.FieldByName('VALICM').AsFloat, '-', fSQLBind(qryDados), fSQLBind(qryDetIcm), True);
    pInsertDados('2 - ENTRADAS', '(-) IMPOSTOS RECUPERÁVEIS DE COMPRAS - PIS',    qryDados.FieldByName('VALPIS').AsFloat, '-', fSQLBind(qryDados), fSQLBind(qryDetPis), True);
    pInsertDados('2 - ENTRADAS', '(-) IMPOSTOS RECUPERÁVEIS DE COMPRAS - COFINS', qryDados.FieldByName('VALCOF').AsFloat, '-', fSQLBind(qryDados), fSQLBind(qryDetCof), True);

    pInsertDados('2 - ENTRADAS', '(+) CONHECIMENTO DE FRETE',                     qryDados.FieldByName('CONFRE').AsFloat, '+', fSQLBind(qryDados), fSQLBind(qryConFre), False);

    pInsertDados('2 - ENTRADAS', '(+) GNRE',                                      qryDados.FieldByName('VLGNRE').AsFloat, '+', fSQLBind(qryDados), fSQLBind(qryVlgNre), False);

    qryDados.Close;
  Finally
    FreeAndNil(qryDados);
    FreeAndNil(qryDetIcm);
    FreeAndNil(qryDetPis);
    FreeAndNil(qryDetCof);
    FreeAndNil(qryConFre);
    FreeAndNil(qryVlgNre);
  End;
end;

procedure TfrmConferenciaEstoqueContabil.pInsertDados(strTipMov, strSubTipo: String;
  fltValor: Double; strOperac, strBtnSQL, strSqlDetail: String; blnNegativar: Boolean = False;
  fltSomaQtd: Double = 0);
//  var
//    stlSQL : TStringList;
begin
  intSequen := intSequen + 1;

  cdsDados.Insert;
  cdsDados.FieldByName('tipmov').AsString := strTipMov;
  cdsDados.FieldByName('subtip').AsString := strSubTipo;

  If (blnNegativar) Then
  begin
    cdsDados.FieldByName('valor').AsFloat := -Abs(fltValor);
    cdsDados.FieldByName('SomaQtd').AsFloat := -Abs(fltSomaQtd);
  end
  else
  begin
    cdsDados.FieldByName('valor').AsFloat := fltValor;
    cdsDados.FieldByName('SomaQtd').AsFloat := fltSomaQtd;
  end;

  cdsDados.FieldByName('detalh').AsString := '...';
  cdsDados.FieldByName('operac').AsString := strOperac;
  cdsDados.FieldByName('sequen').AsInteger := intSequen;
  cdsDados.FieldByName('btnsql').AsString := '          ' + strBtnSQL;
  cdsDados.FieldByName('SqlDet').AsString := strSqlDetail;

  cdsDados.Post;

  If (strOperac = '+') Then
  begin
    fltSaldoFinal := fltSaldoFinal + fltValor;
    fltQtdFinal := fltQtdFinal + fltSomaQtd;
  end
  Else If (strOperac = '-') Then
  begin
    fltSaldoFinal := fltSaldoFinal - fltValor;
    fltQtdFinal := fltQtdFinal - fltSomaQtd;
  end;

  {if not femptyStr(strBtnSQL) then
  begin
    stlSQL := TStringList.Create;
    try
      stlSQL.Add(strBtnSQL);
      stlSQL.SaveToFile('.\' + strTipMov + ' - ' + AnsiReplaceStr(strSubTipo, '/', '') + '.sql');
    finally
      FreeANdNil(stlSQL);
    end;
  end;}
end;

procedure TfrmConferenciaEstoqueContabil.pLimparColunasCxGridEmpresa;
  var
    intCnt : Integer;
    cxColumn : TcxGridDbColumn;
    blnTerminou : boolean;
begin
  repeat
    blnTerminou := True;
    for intCnt := 0 to cxgDadosDBTableViewCitel1.ColumnCount-1 do
    begin
      if (cxgDadosDBTableViewCitel1.Columns[intCnt].Tag = 99) then
      begin
        cxColumn := cxgDadosDBTableViewCitel1.GetColumnByFieldName(cxgDadosDBTableViewCitel1.Columns[intCnt].DataBinding.FieldName);
        if Assigned(cxColumn) then
        begin
          FreeAndNil(cxColumn);
          blnTerminou := False;
          Break;
        end;
      end;
    end;
  until blnTerminou;
end;

procedure TfrmConferenciaEstoqueContabil.pLimparFiltroDoProduto;
begin
  edtProdutos.Clear;
  edtDesProduto.Clear;
  SetLength(arrCadIte, 0);
  strCadIte := EmptyStr;
end;

procedure TfrmConferenciaEstoqueContabil.pOutrasEntradas;
  Var
    qryDados : TUniQuery;
    qryDetal : TUniQuery;
begin
  pSetaTextoStatus('Outras Entradas...');
  qryDados := fCriaQuery(Self);
  qryDetal := fCriaQuery(Self);
  Try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(' SELECT SUM(DET_TOTMED) AS VALTOT, SUM(DET_QTDITE) AS QTDITE ');
    qryDados.SQL.Add('   FROM MOVDET D ');
    qryDados.SQL.Add(' 	INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDados.SQL.Add(' 	INNER JOIN MOVGER G ON G.AUTOINCREM = D.DET_SEQGER ');
    qryDados.SQL.Add(' 	INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDados.SQL.Add('  WHERE TRUE ');
    qryDados.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDados.SQL.Add('    AND D.DET_PROEMB <> "S" ');
    qryDados.SQL.Add('    AND IF( RIGHT( D.DET_CLAFIS, 3 ) IN ( "409", "152", "659" ), FALSE, TRUE ) ');
    qryDados.SQL.Add('    AND ( ( D.DET_TIP_FC = "C" AND LOCATE(D.DET_CLAFIS, :CLANOE ) > 0 AND LOCATE(D.DET_CODCLI, :CLIFIL ) > 0 AND RIGHT(D.DET_CLAFIS, 3) =  "949" ) ');
    qryDados.SQL.Add('       OR ( D.DET_TIP_FC = "F" AND LOCATE(D.DET_CLAFIS, :CLANOE ) > 0 AND LOCATE(D.DET_CODFOR, :FORFIL ) = 0 AND RIGHT(D.DET_CLAFIS, 3) <> "910" ) ) ');

    pSetaFiltroComum(qryDados);
    pSetaParametros(qryDados);

    qryDados.ParamByName('CLIFIL').AsString := FClienteFilialLocate;
    qryDados.ParamByName('FORFIL').AsString := fRetForFilialTodos(False);
    qryDados.ParamByName('CLANOE').AsString := fTransform(fCfgSis('CLANOE'),4,'_');

    //--
    qryDetal.Close;
    qryDetal.SQL.Clear;
    qryDetal.SQL.Add(' SELECT ' + fGetColunasAgrupamentoCfop);
    qryDetal.SQL.Add('   FROM MOVDET D ');
    qryDetal.SQL.Add(' 	INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDetal.SQL.Add(' 	INNER JOIN MOVGER G ON G.AUTOINCREM = D.DET_SEQGER ');
    qryDetal.SQL.Add(' 	INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDetal.SQL.Add('   LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ');
    qryDetal.SQL.Add('   LEFT JOIN CADCLI ON CLI_CODCLI = D.DET_CODCLI ');
    qryDetal.SQL.Add('   LEFT JOIN CADFOR ON FOR_CODFOR = D.DET_CODFOR ');
    qryDetal.SQL.Add('  WHERE TRUE ');
    qryDetal.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDetal.SQL.Add('    AND D.DET_PROEMB <> "S" ');
    qryDetal.SQL.Add('    AND IF( RIGHT( D.DET_CLAFIS, 3 ) IN ( "409", "152", "659" ), FALSE, TRUE ) ');
    qryDetal.SQL.Add('    AND ( ( D.DET_TIP_FC = "C" AND LOCATE(D.DET_CLAFIS, :CLANOE ) > 0 AND LOCATE(D.DET_CODCLI, :CLIFIL ) > 0 AND RIGHT(D.DET_CLAFIS, 3) =  "949" ) ');
    qryDetal.SQL.Add('       OR ( D.DET_TIP_FC = "F" AND LOCATE(D.DET_CLAFIS, :CLANOE ) > 0 AND LOCATE(D.DET_CODFOR, :FORFIL ) = 0 AND RIGHT(D.DET_CLAFIS, 3) <> "910" ) ) ');

    pSetaFiltroComum(qryDetal);
    pSetaParametros(qryDetal);

    qryDetal.ParamByName('CLIFIL').AsString := FClienteFilialLocate;
    qryDetal.ParamByName('FORFIL').AsString := fRetForFilialTodos(False);
    qryDetal.ParamByName('CLANOE').AsString := fTransform(fCfgSis('CLANOE'),4,'_');
    //--

    qryDados.Open;
    strSQLEntradas := strSQLEntradas + IIF(fEmptyStr(strSQLEntradas), '', ' UNION ALL ') + ' SELECT IFNULL(VALTOT,0) AS VALTOT, IFNULL(QTDITE,0) AS QTDITE FROM ( ' + fSQLBind(qryDados) + ' ) AS TAB ';
    strSQLDetEntradas := strSQLDetEntradas + IIF(fEmptyStr(strSQLDetEntradas), '', ' UNION ALL ') + ' SELECT ENT.CODITE, ENT.DESCRI, ENT.REFERE, ENT.UNIDAD, SUM(IFNULL(ENT.QTDITE,0)) AS VALTOT FROM ( ' + fSQLBind(qryDetal) + ' ) AS ENT GROUP BY ENT.CODITE';
    pInsertDados('2 - ENTRADAS', '(+) OUTRAS ENTRADAS', qryDados.FieldByName('VALTOT').AsFloat, '+', fSQLBind(qryDados), fSQLBind(qryDetal), False, qryDados.FieldByName('QTDITE').AsFloat);
    qryDados.Close;
  Finally
    FreeAndNil(qryDados);
    FreeAndNil(qryDetal);
  End;
end;

procedure TfrmConferenciaEstoqueContabil.pGarantiaClienteEntradas;
  Var
    qryDados : TUniQuery;
    qryDetal : TUniQuery;
begin
  pSetaTextoStatus('Garantia de Clientes (Entradas)...');
  qryDados := fCriaQuery(Self);
  qryDetal := fCriaQuery(Self);
  Try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(' SELECT	SUM(D.DET_TOTMED) AS VALTOT, SUM(D.DET_QTDITE) AS QTDITE ');
    qryDados.SQL.Add('   FROM MOVDET D ');
    qryDados.SQL.Add('  INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDados.SQL.Add(' 	INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDados.SQL.Add('  WHERE TRUE ');
    qryDados.SQL.Add(' 	  AND D.DET_ESPDOC IN ("GC", "GA") ');
    qryDados.SQL.Add(' 	  AND LEFT(D.DET_CLAFIS,1) < 5 ');
    qryDados.SQL.Add(' 	  AND D.DET_FILKAR = 0 ');

    pSetaFiltroComum(qryDados);
    pSetaParametros(qryDados);

    //--
    qryDetal.Close;
    qryDetal.SQL.Clear;
    qryDetal.SQL.Add(' SELECT	' + fGetColunasAgrupamentoCfop);
    qryDetal.SQL.Add('   FROM MOVDET D ');
    qryDetal.SQL.Add('  INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDetal.SQL.Add(' 	INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDetal.SQL.Add('   LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ');
    qryDetal.SQL.Add('   LEFT JOIN CADCLI ON CLI_CODCLI = D.DET_CODCLI ');
    qryDetal.SQL.Add('   LEFT JOIN CADFOR ON FOR_CODFOR = D.DET_CODFOR ');
    qryDetal.SQL.Add('  WHERE TRUE ');
    qryDetal.SQL.Add(' 	  AND D.DET_ESPDOC IN ("GC", "GA") ');
    qryDetal.SQL.Add(' 	  AND LEFT(D.DET_CLAFIS,1) < 5 ');
    qryDetal.SQL.Add(' 	  AND D.DET_FILKAR = 0 ');

    pSetaFiltroComum(qryDetal);
    pSetaParametros(qryDetal);

    //--
    qryDados.Open;
    strSQLEntradas := strSQLEntradas + IIF(fEmptyStr(strSQLEntradas), '', ' UNION ALL ') + ' SELECT IFNULL(VALTOT,0) AS VALTOT, IFNULL(QTDITE,0) AS QTDITE FROM ( ' + fSQLBind(qryDados) + ' ) AS TAB ';
    strSQLDetEntradas := strSQLDetEntradas + IIF(fEmptyStr(strSQLDetEntradas), '', ' UNION ALL ') + ' SELECT ENT.CODITE, ENT.DESCRI, ENT.REFERE, ENT.UNIDAD, SUM(IFNULL(ENT.QTDITE,0)) AS VALTOT FROM ( ' + fSQLBind(qryDetal) + ' ) AS ENT GROUP BY ENT.CODITE';
    pInsertDados('2 - ENTRADAS', '(+) GARANTIA DE CLIENTE', qryDados.FieldByName('VALTOT').AsFloat, '+', fSQLBind(qryDados), fSQLBind(qryDetal), False, qryDados.FieldByName('QTDITE').AsFloat);
    qryDados.Close;
  Finally
    FreeAndNil(qryDados);
    FreeAndNil(qryDetal);
  End;
end;

procedure TfrmConferenciaEstoqueContabil.pOutrasSaidas;
  Var
    qryDados : TUniQuery;
    qryDetal : TUniQuery;
begin
  pSetaTextoStatus('Outras Saídas...');
  qryDados := fCriaQuery(Self);
  qryDetal := fCriaQuery(Self);
  Try
    qryDados.Close;
    qryDados.SQL.Clear;

    qryDados.SQL.Add(' SELECT SUM(DET_TOTMED) AS VALTOT, SUM(DET_QTDITE) AS QTDITE ');
    qryDados.SQL.Add('   FROM MOVDET D ');
    qryDados.SQL.Add('	INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDados.SQL.Add('	INNER JOIN MOVGER G ON G.AUTOINCREM = D.DET_SEQGER ');
    qryDados.SQL.Add(' 	INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDados.SQL.Add('  WHERE TRUE ');
    qryDados.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDados.SQL.Add('    AND D.DET_PROEMB <> "S" ');
    qryDados.SQL.Add('    AND IF( RIGHT( D.DET_CLAFIS, 3 ) IN ( "409", "152", "659", "927" ), FALSE, TRUE ) ');
    qryDados.SQL.Add('	  AND ((LOCATE(D.DET_CLAFIS, :CLANFO) ');
    qryDados.SQL.Add('         AND  NOT(LOCATE(D.DET_CODCLI, :CLIFIL)) ');
    qryDados.SQL.Add('         AND  RIGHT(D.DET_CLAFIS, 3) <> "910"    ');
    qryDados.SQL.Add('	       AND D.DET_TIP_FC = "C") ');
    qryDados.SQL.Add('          OR    ');
    qryDados.SQL.Add('          (D.DET_CLAFIS IN ( "5949", "6949", "5915", "6915" ) AND D.DET_TIP_FC = "F" AND LOCATE(D.DET_CODFOR, :FORFIL ) = 0 )) ');
    pSetaFiltroComum(qryDados);
    pSetaParametros(qryDados);

    qryDados.ParamByName('CLANFO').AsString := fTransform(fCfgSis('CLANFO'),4,'_');
    qryDados.ParamByName('CLIFIL').AsString := FClienteFilialLocate;
    qryDados.ParamByName('FORFIL').AsString := fRetForFilialTodos(False);

    //--
    qryDetal.Close;
    qryDetal.SQL.Clear;
    qryDetal.SQL.Add(' SELECT ' + fGetColunasAgrupamentoCfop);
    qryDetal.SQL.Add('   FROM MOVDET D ');
    qryDetal.SQL.Add('	INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDetal.SQL.Add('	INNER JOIN MOVGER G ON G.AUTOINCREM = D.DET_SEQGER ');
    qryDetal.SQL.Add(' 	INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDetal.SQL.Add('   LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ');
    qryDetal.SQL.Add('   LEFT JOIN CADCLI ON CLI_CODCLI = D.DET_CODCLI ');
    qryDetal.SQL.Add('   LEFT JOIN CADFOR ON FOR_CODFOR = D.DET_CODFOR ');
    qryDetal.SQL.Add('  WHERE TRUE ');
    qryDetal.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDetal.SQL.Add('    AND D.DET_PROEMB <> "S" ');
    qryDetal.SQL.Add('    AND IF( RIGHT( D.DET_CLAFIS, 3 ) IN ( "409", "152", "659", "927" ), FALSE, TRUE ) ');
    qryDetal.SQL.Add('	  AND ((LOCATE(D.DET_CLAFIS, :CLANFO) ');
    qryDetal.SQL.Add('         AND  NOT(LOCATE(D.DET_CODCLI, :CLIFIL)) ');
    qryDetal.SQL.Add('         AND  RIGHT(D.DET_CLAFIS, 3) <> "910"    ');
    qryDetal.SQL.Add('	       AND D.DET_TIP_FC = "C") ');
    qryDetal.SQL.Add('          OR    ');
    qryDetal.SQL.Add('        (D.DET_CLAFIS IN ( "5949", "6949", "5915", "6915" ) AND D.DET_TIP_FC = "F" AND LOCATE(D.DET_CODFOR, :FORFIL ) = 0 )) ');

    pSetaFiltroComum(qryDetal);
    pSetaParametros(qryDetal);

    qryDetal.ParamByName('CLANFO').AsString := fTransform(fCfgSis('CLANFO'),4,'_');
    qryDetal.ParamByName('CLIFIL').AsString := FClienteFilialLocate;
    qryDetal.ParamByName('FORFIL').AsString := fRetForFilialTodos(False);
    //--

    qryDados.Open;
    strSQLSaidas := strSQLSaidas + IIF(fEmptyStr(strSQLSaidas), '', ' UNION ALL ') + ' SELECT -IFNULL(VALTOT,0) AS VALTOT, -IFNULL(QTDITE,0) AS QTDITE FROM ( ' + fSQLBind(qryDados) + ' ) AS TAB ';
    strSQLDetSaidas := strSQLDetSaidas + IIF(fEmptyStr(strSQLDetSaidas), '', ' UNION ALL ') + ' SELECT SAI.CODITE, SAI.DESCRI, SAI.REFERE, SAI.UNIDAD, SUM(-IFNULL(SAI.QTDITE,0)) AS VALTOT FROM ( ' + fSQLBind(qryDetal) + ' ) AS SAI GROUP BY SAI.CODITE';
    pInsertDados('3 - SAÍDAS', '(-) OUTRAS SAÍDAS', qryDados.FieldByName('VALTOT').AsFloat, '-', fSQLBind(qryDados), fSQLBind(qryDetal), False, qryDados.FieldByName('QTDITE').AsFloat);
    qryDados.Close;

  Finally
    FreeAndNil(qryDados);
    FreeAndNil(qryDetal);
  End;
end;

procedure TfrmConferenciaEstoqueContabil.pGarantiaClienteSaidas;
  Var
    qryDados : TUniQuery;
    qryDetal : TUniQuery;
begin
  pSetaTextoStatus('Garantia de Clientes (Saídas)...');
  qryDados := fCriaQuery(Self);
  qryDetal := fCriaQuery(Self);
  Try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(' SELECT	SUM(D.DET_TOTMED) AS VALTOT, SUM(D.DET_QTDITE) AS QTDITE ');
    qryDados.SQL.Add('   FROM MOVDET D ');
    qryDados.SQL.Add('  INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDados.SQL.Add(' 	INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDados.SQL.Add('  WHERE TRUE ');
    qryDados.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDados.SQL.Add(' 	  AND D.DET_ESPDOC IN ("GC", "GA", "GF") ');
    qryDados.SQL.Add(' 	  AND LEFT(D.DET_CLAFIS,1) >= 5 ');

    pSetaFiltroComum(qryDados);
    pSetaParametros(qryDados);

    //--
    qryDetal.Close;
    qryDetal.SQL.Clear;
    qryDetal.SQL.Add(' SELECT	' + fGetColunasAgrupamentoCfop);
    qryDetal.SQL.Add('   FROM MOVDET D ');
    qryDetal.SQL.Add('  INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDetal.SQL.Add(' 	INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDetal.SQL.Add('   LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ');
    qryDetal.SQL.Add('   LEFT JOIN CADCLI ON CLI_CODCLI = D.DET_CODCLI ');
    qryDetal.SQL.Add('   LEFT JOIN CADFOR ON FOR_CODFOR = D.DET_CODFOR ');
    qryDetal.SQL.Add('  WHERE TRUE ');
    qryDetal.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDetal.SQL.Add(' 	  AND D.DET_ESPDOC IN ("GC", "GA", "GF") ');
    qryDetal.SQL.Add(' 	  AND LEFT(D.DET_CLAFIS,1) >= 5 ');

    pSetaFiltroComum(qryDetal);
    pSetaParametros(qryDetal);

    //--
    qryDados.Open;
    strSQLSaidas := strSQLSaidas + IIF(fEmptyStr(strSQLSaidas), '', ' UNION ALL ') + ' SELECT -IFNULL(VALTOT,0) AS VALTOT, -IFNULL(QTDITE,0) AS QTDITE FROM ( ' + fSQLBind(qryDados) + ' ) AS TAB ';
    strSQLDetSaidas := strSQLDetSaidas + IIF(fEmptyStr(strSQLDetSaidas), '', ' UNION ALL ') + ' SELECT SAI.CODITE, SAI.DESCRI, SAI.REFERE, SAI.UNIDAD, SUM(-IFNULL(SAI.QTDITE,0)) AS VALTOT FROM ( ' + fSQLBind(qryDetal) + ' ) AS SAI GROUP BY SAI.CODITE';
    pInsertDados('3 - SAÍDAS', '(-) GARANTIA DE CLIENTE', qryDados.FieldByName('VALTOT').AsFloat, '-', fSQLBind(qryDados), fSQLBind(qryDetal), False, qryDados.FieldByName('QTDITE').AsFloat);
    qryDados.Close;
  Finally
    FreeAndNil(qryDados);
    FreeAndNil(qryDetal);
  End;
end;

procedure TfrmConferenciaEstoqueContabil.pSaidas;
  Var
    qryDados : TUniQuery;
    qryDetal : TUniQuery;
begin
  pSetaTextoStatus('Saídas (Vendas)...');
  qryDados := fCriaQuery(Self);
  qryDetal := fCriaQuery(Self);
  Try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add('SELECT ');
    qryDados.SQL.Add('	SUM(VALTOT) AS VALTOT, SUM(QTDITE) AS QTDITE ');
    qryDados.SQL.Add('FROM ');
    qryDados.SQL.Add('	( ');
    qryDados.SQL.Add('	SELECT ');
    qryDados.SQL.Add('		SUM(IF(LEFT(D.DET_CLAFIS,1) < 5, -D.DET_TOTMED,D.DET_TOTMED)) AS VALTOT, ');
    qryDados.SQL.Add('		SUM(D.DET_QTDITE) AS QTDITE  ');
    qryDados.SQL.Add('	FROM MOVDET D ');
    qryDados.SQL.Add('		INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDados.SQL.Add(' 	INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDados.SQL.Add('	WHERE TRUE ');
    qryDados.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDados.SQL.Add('		AND D.DET_PROEMB <> "S" ');
    qryDados.SQL.Add('		AND D.DET_TIP_FC = "C" ');
    qryDados.SQL.Add('		AND ((LOCATE(D.DET_CLAFIS, :CLAVEN) > 0) ');
    qryDados.SQL.Add('					OR (LOCATE(D.DET_CLAFIS, :CLADEV) > 0) ');
    qryDados.SQL.Add('				) ');
    qryDados.SQL.Add('    AND LEFT(D.DET_CLAFIS, 1) >= 5 ');
    qryDados.SQL.Add('    AND RIGHT(D.DET_CLAFIS, 3) <> "910" ');

    pSetaFiltroComum(qryDados);

    qryDados.SQL.Add('	) AS TAB ');

    pSetaParametros(qryDados);

    qryDados.ParamByName('CLAVEN').AsString := VS_strClaVen;
    qryDados.ParamByName('CLADEV').AsString := VS_strClaDev;
    //qryDados.ParamByName('FATCLF').AsString := fCfgSis('FATCLF');

    //--
    qryDetal.Close;
    qryDetal.SQL.Clear;
    qryDetal.SQL.Add(' SELECT ' + fGetColunasAgrupamentoCfop);
    qryDetal.SQL.Add('   FROM MOVDET D ');
    qryDetal.SQL.Add('		INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDetal.SQL.Add('  	INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDetal.SQL.Add('     LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ');
    qryDetal.SQL.Add('     LEFT JOIN CADCLI ON CLI_CODCLI = D.DET_CODCLI ');
    qryDetal.SQL.Add('     LEFT JOIN CADFOR ON FOR_CODFOR = D.DET_CODFOR ');
    qryDetal.SQL.Add('	WHERE TRUE ');
    qryDetal.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDetal.SQL.Add('		AND D.DET_PROEMB <> "S" ');
    qryDetal.SQL.Add('		AND D.DET_TIP_FC = "C" ');
    qryDetal.SQL.Add('		AND ((LOCATE(D.DET_CLAFIS, :CLAVEN) > 0) ');
    qryDetal.SQL.Add('					OR (LOCATE(D.DET_CLAFIS, :CLADEV) > 0) ');
    qryDetal.SQL.Add('				) ');
    qryDetal.SQL.Add('    AND LEFT(D.DET_CLAFIS, 1) >= 5 ');
    qryDetal.SQL.Add('    AND RIGHT(D.DET_CLAFIS, 3) <> "910" ');

    pSetaFiltroComum(qryDetal);
    pSetaParametros(qryDetal);

    qryDetal.ParamByName('CLAVEN').AsString := VS_strClaVen;
    qryDetal.ParamByName('CLADEV').AsString := VS_strClaDev;
    //qryDetal.ParamByName('FATCLF').AsString := fCfgSis('FATCLF');
    //--

    qryDados.Open;
    strSQLSaidas := strSQLSaidas + IIF(fEmptyStr(strSQLSaidas), '', ' UNION ALL ') + ' SELECT -IFNULL(VALTOT,0) AS VALTOT, -IFNULL(QTDITE,0) AS QTDITE FROM ( ' + fSQLBind(qryDados) + ' ) AS TAB ';
    strSQLDetSaidas := strSQLDetSaidas + IIF(fEmptyStr(strSQLDetSaidas), '', ' UNION ALL ') + ' SELECT SAI.CODITE, SAI.DESCRI, SAI.REFERE, SAI.UNIDAD, SUM(-IFNULL(SAI.QTDITE,0)) AS VALTOT FROM ( ' + fSQLBind(qryDetal) + ' ) AS SAI GROUP BY SAI.CODITE';
    pInsertDados('3 - SAÍDAS', '(-) VENDAS', qryDados.FieldByName('VALTOT').AsFloat, '-', fSQLBind(qryDados), fSQLBind(qryDetal), False, qryDados.FieldByName('QTDITE').AsFloat);
    qryDados.Close;

  Finally
    FreeAndNil(qryDados);
    FreeAndNil(qryDetal);
  End;

end;

procedure TfrmConferenciaEstoqueContabil.pSaldoInicial;
  Var
    qryDados : TUniQuery;
    qryDetal : TUniQuery;
    strSalInv, strDecQtd, strDecUni: string;
begin
  pSetaTextoStatus('Saldo Inicial...');

  strSalInv := IIF(fCfgSis('SALINV', varString, strEmpCfg) = 'SALDOS', 'TRUE', 'FALSE');
  strDecQtd := '4'; // Req 417796, em decorrência do Req 396187
  strDecUni := '4'; // Req 417796, em decorrência do Req 396187

  qryDados := fCriaQuery(Self);
  qryDetal := fCriaQuery(Self);
  Try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(' SELECT SUM(ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(G.ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / G.ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+') ) AS QTDITE, ');
    qryDados.SQL.Add('        SUM(');
    qryDados.SQL.Add('          IF(LOCATE(".", (ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(G.ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / G.ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+'))) > 0 ');
    qryDados.SQL.Add('               AND LENGTH((ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(G.ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / G.ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+'))) ');
    qryDados.SQL.Add('                 - LOCATE(".", (ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(G.ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / G.ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+'))) > 2 ');
    qryDados.SQL.Add('               AND MID((ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(G.ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / G.ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+') ');
    qryDados.SQL.Add('                         * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+')), ');
    qryDados.SQL.Add('                       LENGTH((ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(G.ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / G.ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+'))), 1) = "5",');
    qryDados.SQL.Add('             CONCAT(LEFT((ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(G.ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / G.ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+')), ');
    qryDados.SQL.Add('                         LENGTH((ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(G.ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / G.ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+'))) - 1), "6"),');
    qryDados.SQL.Add('            (ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(G.ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / G.ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+'))');
    qryDados.SQL.Add('          )');
    qryDados.SQL.Add('        ) AS VALTOT ');
    qryDados.SQL.Add('   FROM CADITE I ');
    qryDados.SQL.Add('   JOIN I_' + fPeriodoAnterior + ' G ON G.ITE_CODITE = I.ITE_CODITE ');
    qryDados.SQL.Add('  WHERE TRUE ');

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      qryDados.SQL.Add(fStrLocate(edtCodEmp, arrCodEmp, 'G.ITE_CODEMP', 'CODEMP'));

    // POSITIVOS!
    qryDados.SQL.Add('  	AND IFNULL(G.ITE_SALDOS, 0) + IF(IFNULL(G.ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / G.ITE_CNV_ML, 0) > 0 ');

    If Not fEmptyStr(mskLinGru.Text) Then
      qryDados.SQL.Add(fFiltroExclusaoLinhaGrupo('G.'));

    if not fEmptyStr(edtProdutos.Text) then
      qryDados.SQL.Add(fStrLocate(edtProdutos, arrCadIte, 'I.ITE_CODITE', 'CODITE'));

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      pSetaParam(edtCodEmp.Text, arrCodEmp, strCadEmp, 'CODEMP', qryDados);

    If Not fEmptyStr(mskLinGru.Text) Then
      pSetaParam(mskLinGru.Text, arrLinGru, strLinGru, 'CODGRU', qryDados);

    if not fEmptyStr(edtProdutos.Text) then
      pSetaParam(edtProdutos.Text, arrCadIte, strCadIte, 'CODITE', qryDados);

    qryDetal.Close;
    qryDetal.SQL.Clear;
    qryDetal.SQL.Add(' SELECT I.ITE_CODITE AS CODITE, I.ITE_DESITE AS DESCRI, I.ITE_REFERE AS REFERE, UNI_SIGUNI AS UNIDAD, ');
    qryDetal.SQL.Add('        IF(LOCATE(".", (ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(G.ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / G.ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+'))) > 0 ');
    qryDetal.SQL.Add('             AND LENGTH((ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(G.ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / G.ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+'))) ');
    qryDetal.SQL.Add('               - LOCATE(".", (ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(G.ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / G.ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+'))) > 2 ');
    qryDetal.SQL.Add('             AND MID((ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(G.ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / G.ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+') ');
    qryDetal.SQL.Add('                       * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+')), ');
    qryDetal.SQL.Add('                     LENGTH((ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(G.ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / G.ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+'))), 1) = "5",');
    qryDetal.SQL.Add('           CONCAT(LEFT((ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(G.ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / G.ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+')), ');
    qryDetal.SQL.Add('                       LENGTH((ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(G.ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / G.ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+'))) - 1), "6"),');
    qryDetal.SQL.Add('          (ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(G.ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / G.ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+'))');
    qryDetal.SQL.Add('        ) AS VALTOT ');
    qryDetal.SQL.Add('   FROM CADITE I ');
    qryDetal.SQL.Add('   JOIN I_' + fPeriodoAnterior + ' G ON G.ITE_CODITE = I.ITE_CODITE ');
    qryDetal.SQL.Add('   LEFT JOIN CADUNI ON UNI_CODUNI = I.ITE_CODUNI ');
    qryDetal.SQL.Add('  WHERE TRUE ');

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      qryDetal.SQL.Add(fStrLocate(edtCodEmp, arrCodEmp, 'G.ITE_CODEMP', 'CODEMP'));

    // POSITIVOS!
    qryDetal.SQL.Add('  	AND IFNULL(G.ITE_SALDOS, 0) + IF(IFNULL(G.ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / G.ITE_CNV_ML, 0) > 0 ');

    If Not fEmptyStr(mskLinGru.Text) Then
      qryDetal.SQL.Add(fFiltroExclusaoLinhaGrupo('G.'));

    if not fEmptyStr(edtProdutos.Text) then
      qryDetal.SQL.Add(fStrLocate(edtProdutos, arrCadIte, 'I.ITE_CODITE', 'CODITE'));

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      pSetaParam(edtCodEmp.Text, arrCodEmp, strCadEmp, 'CODEMP', qryDetal);

    If Not fEmptyStr(mskLinGru.Text) Then
      pSetaParam(mskLinGru.Text, arrLinGru, strLinGru, 'CODGRU', qryDetal);

    if not fEmptyStr(edtProdutos.Text) then
      pSetaParam(edtProdutos.Text, arrCadIte, strCadIte, 'CODITE', qryDetal);

    qryDados.Open;
    strSQLInicial := 'SELECT IFNULL(VALTOT,0) AS VALTOT, IFNULL(QTDITE,0) AS QTDITE FROM ( ' + fSQLBind(qryDados) + ' ) AS TAB';
    strSQLDetInicial := 'SELECT INI.CODITE, INI.DESCRI, INI.REFERE, INI.UNIDAD, SUM(IFNULL(INI.VALTOT,0)) AS VALTOT FROM ( ' + fSQLBind(qryDetal) + ' ) AS INI GROUP BY INI.CODITE';
    pInsertDados('1 - SALDO INICIAL', 'SALDO INICIAL', qryDados.FieldByName('VALTOT').AsFloat, '+', fSQLBind(qryDados), fSQLBind(qryDetal), False, qryDados.FieldByName('QTDITE').AsFloat);
    qryDados.Close;
  Finally
    FreeAndNil(qryDados);
    FreeAndNil(qryDetal);
  End;
end;

procedure TfrmConferenciaEstoqueContabil.pSaldoInventario;

  function fTabelaSaldos: String;
  begin
    Result := 'I_' + fPeriodoAtual;
    If Not fTabelaExiste(Result) Then
      Result := 'ITEGER';
  end;

  function fAliasTabelaSaldos: String;
  var
    strTabela: string;
  begin
    Result := 'G.';
    strTabela := 'I_' + fPeriodoAtual;
    If Not fTabelaExiste(strTabela) Then
      Result := 'I.';
  end;

  Var
    qryDados : TUniQuery;
    qryDetal : TUniQuery;
    strSalInv, strDecQtd, strDecUni: string;
    qryInsere : TUniQuery;
begin
  pSetaTextoStatus('Saldo de Inventário...');

  strSalInv := IIF(fCfgSis('SALINV', varString, strEmpCfg) = 'SALDOS', 'TRUE', 'FALSE');
  strDecQtd := '4'; // Req 417796, em decorrência do Req 396187
  strDecUni := '4'; // Req 417796, em decorrência do Req 396187

  qryDados := fCriaQuery(Self);
  qryDetal := fCriaQuery(Self);
  Try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(' SELECT SUM(ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / ' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+') ) AS QTDITE, ');
    qryDados.SQL.Add('        SUM(');
    qryDados.SQL.Add('          IF(LOCATE(".", (ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / ' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+'))) > 0 ');
    qryDados.SQL.Add('               AND LENGTH((ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / ' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+'))) ');
    qryDados.SQL.Add('                 - LOCATE(".", (ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / ' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+'))) > 2 ');
    qryDados.SQL.Add('               AND MID((ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / ' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+') ');
    qryDados.SQL.Add('                         * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+')), ');
    qryDados.SQL.Add('                       LENGTH((ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / ' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+'))), 1) = "5",');
    qryDados.SQL.Add('             CONCAT(LEFT((ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / ' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+')), ');
    qryDados.SQL.Add('                         LENGTH((ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / ' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+'))) - 1), "6"),');
    qryDados.SQL.Add('            (ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / ' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+'))');
    qryDados.SQL.Add('          )');
    qryDados.SQL.Add('        ) AS VALTOT ');
    qryDados.SQL.Add('   FROM CADITE I ');
    qryDados.SQL.Add('   JOIN ' + fTabelaSaldos + ' G ON G.ITE_CODITE = I.ITE_CODITE ');
    qryDados.SQL.Add('  WHERE TRUE ');

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      qryDados.SQL.Add(fStrLocate(edtCodEmp, arrCodEmp, 'G.ITE_CODEMP', 'CODEMP'));

    // POSITIVOS!
    qryDados.SQL.Add('    AND IFNULL(G.ITE_SALDOS, 0) + IF(IFNULL(' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / ' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0) > 0 ');

    If Not fEmptyStr(mskLinGru.Text) Then
      qryDados.SQL.Add(fFiltroExclusaoLinhaGrupo(fAliasTabelaSaldos));

    if not fEmptyStr(edtProdutos.Text) then
      qryDados.SQL.Add(fStrLocate(edtProdutos, arrCadIte, 'I.ITE_CODITE', 'CODITE'));

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      pSetaParam(edtCodEmp.Text, arrCodEmp, strCadEmp, 'CODEMP', qryDados);

    If Not fEmptyStr(mskLinGru.Text) Then
      pSetaParam(mskLinGru.Text, arrLinGru, strLinGru, 'CODGRU', qryDados);

    if not fEmptyStr(edtProdutos.Text) then
      pSetaParam(edtProdutos.Text, arrCadIte, strCadIte, 'CODITE', qryDados);

    qryDetal.Close;
    qryDetal.SQL.Clear;
    qryDetal.SQL.Add(' SELECT I.ITE_CODITE AS CODITE, I.ITE_DESITE AS DESCRI, I.ITE_REFERE AS REFERE, UNI_SIGUNI AS UNIDAD, ');
    qryDetal.SQL.Add('        IF(LOCATE(".", (ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / ' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+'))) > 0 ');
    qryDetal.SQL.Add('             AND LENGTH((ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / ' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+'))) ');
    qryDetal.SQL.Add('               - LOCATE(".", (ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / ' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+'))) > 2 ');
    qryDetal.SQL.Add('             AND MID((ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / ' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+') ');
    qryDetal.SQL.Add('                       * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+')), ');
    qryDetal.SQL.Add('                     LENGTH((ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / ' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+'))), 1) = "5",');
    qryDetal.SQL.Add('           CONCAT(LEFT((ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / ' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+')), ');
    qryDetal.SQL.Add('                       LENGTH((ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / ' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+'))) - 1), "6"),');
    qryDetal.SQL.Add('          (ROUND(ROUND((IFNULL(IF(' + strSalInv + ', G.ITE_SALDOS + IF(IFNULL(' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / ' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0), G.ITE_SALBAL), 0)),'+strDecQtd+'),'+strDecQtd+')  * ROUND((G.ITE_PREMED) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV), '+strDecUni+'))');
    qryDetal.SQL.Add('        ) AS VALTOT ');
    qryDetal.SQL.Add('   FROM CADITE I ');
    qryDetal.SQL.Add('   JOIN ' + fTabelaSaldos + ' G ON G.ITE_CODITE = I.ITE_CODITE ');
    qryDetal.SQL.Add('   LEFT JOIN CADUNI ON UNI_CODUNI = I.ITE_CODUNI ');
    qryDetal.SQL.Add('  WHERE TRUE ');

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      qryDetal.SQL.Add(fStrLocate(edtCodEmp, arrCodEmp, 'G.ITE_CODEMP', 'CODEMP'));

    // POSITIVOS!
    qryDetal.SQL.Add('    AND IFNULL(G.ITE_SALDOS, 0) + IF(IFNULL(' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / ' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0) > 0 ');

    If Not fEmptyStr(mskLinGru.Text) Then
      qryDetal.SQL.Add(fFiltroExclusaoLinhaGrupo(fAliasTabelaSaldos));

    if not fEmptyStr(edtProdutos.Text) then
      qryDetal.SQL.Add(fStrLocate(edtProdutos, arrCadIte, 'I.ITE_CODITE', 'CODITE'));

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      pSetaParam(edtCodEmp.Text, arrCodEmp, strCadEmp, 'CODEMP', qryDetal);

    If Not fEmptyStr(mskLinGru.Text) Then
      pSetaParam(mskLinGru.Text, arrLinGru, strLinGru, 'CODGRU', qryDetal);

    if not fEmptyStr(edtProdutos.Text) then
      pSetaParam(edtProdutos.Text, arrCadIte, strCadIte, 'CODITE', qryDetal);

    qryDados.Open;
    strSQLDiferenca := 'SELECT SUM(VALTOT) AS VALTOT, SUM(QTDITE) AS QTDITE FROM ( ' + strSQLSaldoFinal + ' UNION ALL SELECT -IFNULL(VALTOT,0) AS VALTOT, -IFNULL(QTDITE,0) AS QTDITE FROM ( ' + fSQLBind(qryDados) + ' ) AS INV ) AS TAB';

    strSQLDetDiferenca := 'SELECT ITE_CODITE AS CODITE, ITE_DESITE AS DESCRI, ITE_REFERE AS REFERE, UNI_SIGUNI AS UNIDAD, SUM(IFNULL(INI.VALTOT,0) + IFNULL(ENT.VALTOT,0) + IFNULL(SAI.VALTOT,0) + IFNULL(DIF.VALTOT,0)) AS VALTOT ';
    strSQLDetDiferenca := strSQLDetDiferenca + ' FROM CADITE ';
    strSQLDetDiferenca := strSQLDetDiferenca + ' LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ';
    strSQLDetDiferenca := strSQLDetDiferenca + ' LEFT JOIN ( ' + strSQLDetInicial + ' ) AS INI ON ITE_CODITE = INI.CODITE ';
    strSQLDetDiferenca := strSQLDetDiferenca + ' LEFT JOIN ( SELECT CODITE, DESCRI, REFERE, UNIDAD, SUM(IFNULL(VALTOT,0)) AS VALTOT FROM ( ' + strSQLDetEntradas + ' ) AS TAB GROUP BY CODITE ) AS ENT ON ITE_CODITE = ENT.CODITE ';
    strSQLDetDiferenca := strSQLDetDiferenca + ' LEFT JOIN ( SELECT CODITE, DESCRI, REFERE, UNIDAD, SUM(IFNULL(VALTOT,0)) AS VALTOT FROM ( ' + strSQLDetSaidas + ' ) AS TAB GROUP BY CODITE ) AS SAI ON ITE_CODITE = SAI.CODITE ';
    strSQLDetDiferenca := strSQLDetDiferenca + ' LEFT JOIN ( SELECT CODITE, DESCRI, REFERE, UNIDAD, SUM(-IFNULL(VALTOT,0)) AS VALTOT FROM ( ' + fSQLBind(qryDetal) + ' ) AS TAB GROUP BY CODITE ) AS DIF ON ITE_CODITE = DIF.CODITE ';
    strSQLDetDiferenca := strSQLDetDiferenca + ' WHERE ((INI.CODITE IS NOT NULL) OR (ENT.CODITE IS NOT NULL) OR (SAI.CODITE IS NOT NULL) OR (DIF.CODITE IS NOT NULL)) ';
    strSQLDetDiferenca := strSQLDetDiferenca + ' GROUP BY ITE_CODITE ';

    qryInsere := fCriaQuery(nil);
    try
      // Essa for a forma que consegui de não dar erro de TableName cannot be empty no SELECT: Criando uma TMP com os dados dentro dela e usando a TMP no botão de detalhe
      qryInsere.SQL.Clear;
      qryInsere.SQL.Add('DROP TEMPORARY TABLE IF EXISTS TMP_DET_DIFERENCA;');
      qryInsere.SQL.Add('CREATE TEMPORARY TABLE TMP_DET_DIFERENCA AS (' + strSQLDetDiferenca + ');');
      qryInsere.ExecSQL;
    finally
      FreeAndNil(qryInsere);
    end;

    pInsertDados('5 - SALDO DE INVENTÁRIO', 'SALDO DE INVENTÁRIO', qryDados.FieldByName('VALTOT').AsFloat, '', fSQLBind(qryDados), fSQLBind(qryDetal), False, qryDados.FieldByName('QTDITE').AsFloat);
    pInsertDados('5 - SALDO DE INVENTÁRIO', 'DIFERENÇA', fltSaldoFinal - qryDados.FieldByName('VALTOT').AsFloat, '', strSQLDiferenca, 'SELECT * FROM TMP_DET_DIFERENCA', False, fltQtdFinal - qryDados.FieldByName('QTDITE').AsFloat);
    qryDados.Close;
  Finally
    FreeAndNil(qryDados);
    FreeAndNil(qryDetal);
  End;
end;

procedure TfrmConferenciaEstoqueContabil.pTransferenciaDeMercadorias;
  Var
    qryDados : TUniQuery;
    qryDetal : TUniQuery;
begin
  pSetaTextoStatus('Transferência de Mercadorias...');
  qryDados := fCriaQuery(Self);
  qryDetal := fCriaQuery(Self);
  Try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(' SELECT SUM(DET_VLRCON) AS VALTOT, SUM(DET_QTDITE) AS QTDITE ');
    qryDados.SQL.Add('   FROM MOVDET ');
    qryDados.SQL.Add('   JOIN ( SELECT * ');
    qryDados.SQL.Add('          FROM ( SELECT FIS_NUMDOC, FIS_ESPDOC, FIS_CODEMP, ');
    qryDados.SQL.Add('                        FIS_ACESSO, EMP_CODEMP ');
    qryDados.SQL.Add('                   FROM CADFIS ');

    qryDados.SQL.Add('                  INNER JOIN CADEMP ON FIS_FORCLI = EMP_CLIFIL ');

    qryDados.SQL.Add('                  WHERE FIS_TIP_FC = "C" ');
    qryDados.SQL.Add('                    AND FIS_HISTOR NOT LIKE "%CANCEL%" ');
    qryDados.SQL.Add('                    AND FIS_HISTOR NOT LIKE "%DENEGAD%" ');
    qryDados.SQL.Add('                    AND FIS_HISTOR NOT LIKE "%INUTILIZAD%" ');
    qryDados.SQL.Add('                    AND FIS_DTAENT >= :DTAINI ');

    qryDados.SQL.Add('                  UNION ALL ');

    qryDados.SQL.Add('                 SELECT FIS_NUMDOC, FIS_ESPDOC, FIS_CODEMP, ');
    qryDados.SQL.Add('                        FIS_ACESSO, "" AS EMP_CODEMP ');
    qryDados.SQL.Add('                   FROM CADFIS ');

    qryDados.SQL.Add('                  INNER JOIN CADEMP ON FIS_FORCLI = EMP_FORFIL ');

    qryDados.SQL.Add('                  WHERE FIS_TIP_FC = "F" ');
    qryDados.SQL.Add('                    AND FIS_HISTOR NOT LIKE "%CANCEL%" ');
    qryDados.SQL.Add('                    AND FIS_HISTOR NOT LIKE "%DENEGAD%" ');
    qryDados.SQL.Add('                    AND FIS_HISTOR NOT LIKE "%INUTILIZAD%" ');
    qryDados.SQL.Add('                    AND FIS_DTAENT >= :DTAINI ) AS TMP ');

    qryDados.SQL.Add('                  GROUP BY FIS_ACESSO ');
    qryDados.SQL.Add('                 HAVING IFNULL(EMP_CODEMP,"") <> "" AND COUNT(*)=1 ) AS TMP2 ');

    qryDados.SQL.Add('     ON TMP2.FIS_NUMDOC = DET_NUMDOC ');
    qryDados.SQL.Add('    AND TMP2.FIS_ESPDOC = DET_ESPDOC ');
    qryDados.SQL.Add('    AND TMP2.FIS_CODEMP = DET_CODEMP ');
    qryDados.SQL.Add('   JOIN CADITE ON ITE_CODITE = DET_CODITE ');

    If Not fEmptyStr(mskLinGru.Text) Then
      qryDados.SQL.Add(fFiltroExclusaoLinhaGrupo());

    if not fEmptyStr(edtProdutos.Text) then
      qryDados.SQL.Add(fStrLocate(edtProdutos, arrCadIte, 'CADITE.ITE_CODITE', 'CODITE'));

    if not fEmptyStr(edtProdutos.Text) then
      pSetaParam(edtProdutos.Text, arrCadIte, strCadIte, 'CODITE', qryDados);

    if fCfgApresentarCfop949TransSaiConfEstCont = 'N' then
      qryDados.SQL.Add(' WHERE  MOVDET.DET_CLAFIS > 5000 AND (RIGHT(MOVDET.DET_CLAFIS, 3) IN ("152", "409", "659", "949", "209")) ');

    qryDados.ParamByName('DTAINI').AsDate := fDataInicial;

    If Not fEmptyStr(mskLinGru.Text) Then
      pSetaParam(mskLinGru.Text, arrLinGru, strLinGru, 'CODGRU', qryDados);

    qryDados.Open;

    //--
    qryDetal.Close;
    qryDetal.SQL.Clear;
    qryDetal.SQL.Add(' SELECT ' + fGetColunasAgrupamentoCfop(False, False) );
    qryDetal.SQL.Add('   FROM MOVDET D');
    qryDetal.SQL.Add('   JOIN ( SELECT * ');
    qryDetal.SQL.Add('          FROM ( SELECT FIS_NUMDOC, FIS_ESPDOC, FIS_CODEMP, ');
    qryDetal.SQL.Add('                        FIS_ACESSO, EMP_CODEMP ');
    qryDetal.SQL.Add('                   FROM CADFIS ');

    qryDetal.SQL.Add('                  INNER JOIN CADEMP ON FIS_FORCLI = EMP_CLIFIL ');

    qryDetal.SQL.Add('                  WHERE FIS_TIP_FC = "C" ');
    qryDetal.SQL.Add('                    AND FIS_HISTOR NOT LIKE "%CANCEL%" ');
    qryDetal.SQL.Add('                    AND FIS_HISTOR NOT LIKE "%DENEGAD%" ');
    qryDetal.SQL.Add('                    AND FIS_HISTOR NOT LIKE "%INUTILIZAD%" ');
    qryDetal.SQL.Add('                    AND FIS_DTAENT >= :DTAINI ');

    qryDetal.SQL.Add('                  UNION ALL ');

    qryDetal.SQL.Add('                 SELECT FIS_NUMDOC, FIS_ESPDOC, FIS_CODEMP, ');
    qryDetal.SQL.Add('                        FIS_ACESSO, "" AS EMP_CODEMP ');
    qryDetal.SQL.Add('                   FROM CADFIS ');

    qryDetal.SQL.Add('                  INNER JOIN CADEMP ON FIS_FORCLI = EMP_FORFIL ');

    qryDetal.SQL.Add('                  WHERE FIS_TIP_FC = "F" ');
    qryDetal.SQL.Add('                    AND FIS_HISTOR NOT LIKE "%CANCEL%" ');
    qryDetal.SQL.Add('                    AND FIS_HISTOR NOT LIKE "%DENEGAD%" ');
    qryDetal.SQL.Add('                    AND FIS_HISTOR NOT LIKE "%INUTILIZAD%" ');
    qryDetal.SQL.Add('                    AND FIS_DTAENT >= :DTAINI ) AS TMP ');

    qryDetal.SQL.Add('                  GROUP BY FIS_ACESSO ');
    qryDetal.SQL.Add('                 HAVING IFNULL(EMP_CODEMP,"") <> "" AND COUNT(*)=1 ) AS TMP2 ');

    qryDetal.SQL.Add('     ON TMP2.FIS_NUMDOC = DET_NUMDOC ');
    qryDetal.SQL.Add('    AND TMP2.FIS_ESPDOC = DET_ESPDOC ');
    qryDetal.SQL.Add('    AND TMP2.FIS_CODEMP = DET_CODEMP ');

    qryDetal.SQL.Add(' 	INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDetal.SQL.Add('   LEFT JOIN CADCLI ON CLI_CODCLI = D.DET_CODCLI ');
    qryDetal.SQL.Add('   LEFT JOIN CADFOR ON FOR_CODFOR = D.DET_CODFOR ');

    qryDetal.SQL.Add('   JOIN CADITE ON ITE_CODITE = DET_CODITE ');

    If Not fEmptyStr(mskLinGru.Text) Then
      qryDetal.SQL.Add(fFiltroExclusaoLinhaGrupo());

    if not fEmptyStr(edtProdutos.Text) then
      qryDetal.SQL.Add(fStrLocate(edtProdutos, arrCadIte, 'CADITE.ITE_CODITE', 'CODITE'));

    qryDetal.SQL.Add('   LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ');

    if fCfgApresentarCfop949TransSaiConfEstCont = 'N' then
      qryDetal.SQL.Add(' WHERE  D.DET_CLAFIS > 5000 AND (RIGHT(D.DET_CLAFIS, 3) IN ("152", "409", "659", "949", "209")) ');

    qryDetal.ParamByName('DTAINI').AsDate := fDataInicial;

    if not fEmptyStr(edtProdutos.Text) then
      pSetaParam(edtProdutos.Text, arrCadIte, strCadIte, 'CODITE', qryDetal);

    If Not fEmptyStr(mskLinGru.Text) Then
      pSetaParam(mskLinGru.Text, arrLinGru, strLinGru, 'CODGRU', qryDetal);
    //--

    If (fFormataFloat(qryDados.FieldByName('VALTOT').AsFloat, 2) <> 0) Then
      pInsertDados('6 - TRANSFERÊNCIAS DE MERCADORIAS', 'TRANSFERÊNCIAS DE MERCADORIAS', qryDados.FieldByName('VALTOT').AsFloat, '', fSQLBind(qryDados), fSQLBind(qryDetal), False, qryDados.FieldByName('QTDITE').AsFloat);

    qryDados.Close;

  Finally
    FreeAndNil(qryDados);
    FreeAndNil(qryDetal);
  End;
end;

procedure TfrmConferenciaEstoqueContabil.pTransferenciasEntradas;
  Var
    qryDados : TUniQuery;
    qryDetal : TUniQuery;
begin
  pSetaTextoStatus('Transferências de Entrada...');
  qryDados := fCriaQuery(Self);
  qryDetal := fCriaQuery(Self);
  Try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(' SELECT SUM(DET_VLRCON + IFNULL(DET_CONFRE,0) + IFNULL(DET_VLGNRE,0)) AS VALTOT, SUM(DET_QTDITE) AS QTDITE ');
    qryDados.SQL.Add('   FROM MOVDET D ');
    qryDados.SQL.Add(' 	INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDados.SQL.Add(' 	INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDados.SQL.Add('  WHERE TRUE ');
    qryDados.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDados.SQL.Add('    AND (LOCATE(D.DET_CODFOR, :FORFIL) > 0 OR RIGHT( D.DET_CLAFIS, 3 ) IN ( "409", "152", "659" ) ) ');
    qryDados.SQL.Add('    AND LOCATE(D.DET_CLAFIS, :CLACOM ) = 0 ');
    qryDados.SQL.Add('    AND D.DET_PROEMB <> "S" ');
    qryDados.SQL.Add('    AND LEFT(D.DET_CLAFIS,1) < 5 ');
  	qryDados.SQL.Add('    AND ((D.DET_ESPDOC = "TE") OR ((D.DET_ESPDOC IN ("NF", "NV", "IF", "IV", "EL")) AND ');
    qryDados.SQL.Add('         ((RIGHT(D.DET_CLAFIS, 3) IN ("152", "409", "659", "949", "209")) ');
    qryDados.SQL.Add('         OR LOCATE(D.DET_CLAFIS, :CLACOM) > 0))) ');

    pSetaFiltroComum(qryDados);
    pSetaParametros(qryDados);

    qryDados.ParamByName('CLACOM').AsString := fTransform(fCfgSis('CLACOM', varString), 4, '_');
    qryDados.ParamByName('FORFIL').AsString := fRetForFilialTodos(False);

    //--
    qryDetal.Close;
    qryDetal.SQL.Clear;
    qryDetal.SQL.Add(' SELECT ' + fGetColunasAgrupamentoCfop(False, True) );
    qryDetal.SQL.Add('   FROM MOVDET D ');
    qryDetal.SQL.Add(' 	INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDetal.SQL.Add(' 	INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDetal.SQL.Add('   LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ');
    qryDetal.SQL.Add('   LEFT JOIN CADCLI ON CLI_CODCLI = D.DET_CODCLI ');
    qryDetal.SQL.Add('   LEFT JOIN CADFOR ON FOR_CODFOR = D.DET_CODFOR ');
    qryDetal.SQL.Add('  WHERE TRUE ');
    qryDetal.SQL.Add('    AND D.DET_FILKAR = 0 ');

    qryDetal.SQL.Add('    AND (LOCATE(D.DET_CODFOR, :FORFIL) > 0 OR RIGHT( D.DET_CLAFIS, 3 ) IN ( "409", "152", "659" )) ');

    qryDetal.SQL.Add('    AND LOCATE(D.DET_CLAFIS, :CLACOM ) = 0 ');
    qryDetal.SQL.Add('    AND D.DET_PROEMB <> "S" ');
    qryDetal.SQL.Add('    AND LEFT(D.DET_CLAFIS,1) < 5 ');
  	qryDetal.SQL.Add('    AND ((D.DET_ESPDOC = "TE") OR ((D.DET_ESPDOC IN ("NF", "NV", "IF", "IV", "EL")) AND ');
    qryDetal.SQL.Add('         ((RIGHT(D.DET_CLAFIS, 3) IN ("152", "409", "659", "949", "209")) ');
    qryDetal.SQL.Add('         OR LOCATE(D.DET_CLAFIS, :CLACOM)> 0))) ');

    pSetaFiltroComum(qryDetal);
    pSetaParametros(qryDetal);

    qryDetal.ParamByName('CLACOM').AsString := fTransform(fCfgSis('CLACOM', varString), 4, '_');
    qryDetal.ParamByName('FORFIL').AsString := fRetForFilialTodos(False);
    //--

    qryDados.Open;
    strSQLEntradas := strSQLEntradas + IIF(fEmptyStr(strSQLEntradas), '', ' UNION ALL ') + ' SELECT IFNULL(VALTOT,0) AS VALTOT, IFNULL(QTDITE,0) AS QTDITE FROM ( ' + fSQLBind(qryDados) + ' ) AS TAB ';
    strSQLDetEntradas := strSQLDetEntradas + IIF(fEmptyStr(strSQLDetEntradas), '', ' UNION ALL ') + ' SELECT ENT.CODITE, ENT.DESCRI, ENT.REFERE, ENT.UNIDAD, SUM(IFNULL(ENT.QTDITE,0)) AS VALTOT FROM ( ' + fSQLBind(qryDetal) + ' ) AS ENT GROUP BY ENT.CODITE';
    pInsertDados('2 - ENTRADAS', '(+) TRANSFERÊNCIAS ( ENTRADAS )', qryDados.FieldByName('VALTOT').AsFloat, '+', fSQLBind(qryDados), fSQLBind(qryDetal), False, qryDados.FieldByName('QTDITE').AsFloat);
    qryDados.Close;

  Finally
    FreeAndNil(qryDados);
    FreeAndNil(qryDetal);
  End;
end;

procedure TfrmConferenciaEstoqueContabil.pTransferenciasSaidas;
  Var
    qryDados : TUniQuery;
    qryDetal : TUniQuery;
begin
  pSetaTextoStatus('Transferências de Saída...');
  qryDados := fCriaQuery(Self);
  qryDetal := fCriaQuery(Self);
  Try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(' SELECT SUM(D.DET_TOTMED) AS VALTOT, SUM(D.DET_QTDITE) AS QTDITE ');
    qryDados.SQL.Add('   FROM MOVDET D ');
    qryDados.SQL.Add(' 	INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDados.SQL.Add(' 	INNER JOIN CADEMP E ON E.EMP_CODEMP = D.DET_CODEMP ');
    qryDados.SQL.Add(' 	INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDados.SQL.Add('  WHERE TRUE ');
    qryDados.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDados.SQL.Add('    AND ( (LOCATE(D.DET_CLAFIS, :CLAVEN) = 0) AND (LOCATE(D.DET_CLAFIS, :CLADEV) = 0) ) ');
    qryDados.SQL.Add('    AND ( (( D.DET_TIP_FC = "C" AND LOCATE( D.DET_CODCLI, :CLIFIL ) > 0 ) OR RIGHT( D.DET_CLAFIS, 3 ) IN ( "409", "152", "659" )) ');
    qryDados.SQL.Add('          OR                                                                            ');
    qryDados.SQL.Add('          (( D.DET_TIP_FC = "F" AND LOCATE( D.DET_CODFOR, :FORFIL ) > 0 ) OR RIGHT( D.DET_CLAFIS, 3 ) IN ( "409", "152", "659" )) ) ');
    qryDados.SQL.Add('    AND D.DET_CLAFIS > 5000 ');
    qryDados.SQL.Add('    AND D.DET_PROEMB <> "S" ');
    qryDados.SQL.Add('    AND ((D.DET_ESPDOC = "TE") OR ((D.DET_ESPDOC IN ("NF", "NV", "IF", "IV", "EL")) ');
    if fCfgApresentarCfop949TransSaiConfEstCont = 'S' then
      qryDados.SQL.Add('         AND ((RIGHT(D.DET_CLAFIS, 3) IN ("152", "409", "659", "949", "209")) ')
    else
      qryDados.SQL.Add('         AND ((RIGHT(D.DET_CLAFIS, 3) IN ("152", "409", "659", "209")) ') ;
    qryDados.SQL.Add('          OR (LOCATE(D.DET_CLAFIS, :CLAVEN) > 0) ))) ');

    pSetaFiltroComum(qryDados);
    pSetaParametros(qryDados);

    qryDados.ParamByName('CLAVEN').AsString := VS_strClaVen;
    qryDados.ParamByName('CLADEV').AsString := VS_strClaDev;
    qryDados.ParamByName('CLIFIL').AsString := FClienteFilialLocate;
    qryDados.ParamByName('FORFIL').AsString := fRetForFilialTodos(False);

    //--
    qryDetal.Close;
    qryDetal.SQL.Clear;
    qryDetal.SQL.Add(' SELECT ' + fGetColunasAgrupamentoCfop);
    qryDetal.SQL.Add('   FROM MOVDET D ');
    qryDetal.SQL.Add(' 	INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDetal.SQL.Add(' 	INNER JOIN CADEMP E ON E.EMP_CODEMP = D.DET_CODEMP ');
    qryDetal.SQL.Add(' 	INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDetal.SQL.Add('   LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ');
    qryDetal.SQL.Add('   LEFT JOIN CADCLI ON CLI_CODCLI = D.DET_CODCLI ');
    qryDetal.SQL.Add('   LEFT JOIN CADFOR ON FOR_CODFOR = D.DET_CODFOR ');
    qryDetal.SQL.Add('  WHERE TRUE ');
    qryDetal.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDetal.SQL.Add('    AND ( (LOCATE(D.DET_CLAFIS, :CLAVEN) = 0) AND (LOCATE(D.DET_CLAFIS, :CLADEV) = 0) ) ');
    qryDetal.SQL.Add('    AND ( ( D.DET_TIP_FC = "C" AND LOCATE( D.DET_CODCLI, :CLIFIL ) > 0 OR RIGHT( D.DET_CLAFIS, 3 ) IN ( "409", "152", "659" )) ');
    qryDetal.SQL.Add('          OR                                                                            ');
    qryDetal.SQL.Add('          ( D.DET_TIP_FC = "F" AND LOCATE( D.DET_CODFOR, :FORFIL ) > 0 OR RIGHT( D.DET_CLAFIS, 3 ) IN ( "409", "152", "659" )) ) ');
    qryDetal.SQL.Add('    AND D.DET_CLAFIS > 5000 ');
    qryDetal.SQL.Add('    AND D.DET_PROEMB <> "S" ');
    qryDetal.SQL.Add('    AND ((D.DET_ESPDOC = "TE") OR ((D.DET_ESPDOC IN ("NF", "NV", "IF", "IV", "EL")) ');
    if fCfgApresentarCfop949TransSaiConfEstCont = 'S' then
      qryDetal.SQL.Add('         AND ((RIGHT(D.DET_CLAFIS, 3) IN ("152", "409", "659", "949", "209")) ')
    else
      qryDetal.SQL.Add('         AND ((RIGHT(D.DET_CLAFIS, 3) IN ("152", "409", "659", "209")) ') ;
    qryDetal.SQL.Add('          OR (LOCATE(D.DET_CLAFIS, :CLAVEN) > 0) ))) ');

    pSetaFiltroComum(qryDetal);
    pSetaParametros(qryDetal);

    qryDetal.ParamByName('CLAVEN').AsString := VS_strClaVen;
    qryDetal.ParamByName('CLADEV').AsString := VS_strClaDev;
    qryDetal.ParamByName('CLIFIL').AsString := FClienteFilialLocate;
    qryDetal.ParamByName('FORFIL').AsString := fRetForFilialTodos(False);
    //--

    qryDados.Open;
    strSQLSaidas := strSQLSaidas + IIF(fEmptyStr(strSQLSaidas), '', ' UNION ALL ') + ' SELECT -IFNULL(VALTOT,0) AS VALTOT, -IFNULL(QTDITE,0) AS QTDITE FROM ( ' + fSQLBind(qryDados) + ' ) AS TAB ';
    strSQLDetSaidas := strSQLDetSaidas + IIF(fEmptyStr(strSQLDetSaidas), '', ' UNION ALL ') + ' SELECT SAI.CODITE, SAI.DESCRI, SAI.REFERE, SAI.UNIDAD, SUM(-IFNULL(SAI.QTDITE,0)) AS VALTOT FROM ( ' + fSQLBind(qryDetal) + ' ) AS SAI GROUP BY SAI.CODITE';
    pInsertDados('3 - SAÍDAS', '(-) TRANSFERÊNCIAS', qryDados.FieldByName('VALTOT').AsFloat, '-', fSQLBind(qryDados), fSQLBind(qryDetal), False, qryDados.FieldByName('QTDITE').AsFloat);
    qryDados.Close;
  Finally
    FreeAndNil(qryDados);
    FreeAndNil(qryDetal);
  End;
end;

procedure TfrmConferenciaEstoqueContabil.pUsoConsumo;
  Var
    qryDados : TUniQuery;
    qryDetal : TUniQuery;
begin
  pSetaTextoStatus('Uso/Consumo...');
  qryDados := fCriaQuery(Self);
  qryDetal := fCriaQuery(Self);
  Try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(' SELECT	SUM(D.DET_TOTMED) AS VALTOT, SUM(D.DET_QTDITE) AS QTDITE ');
    qryDados.SQL.Add('   FROM MOVDET D ');
    qryDados.SQL.Add('  INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDados.SQL.Add(' 	INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDados.SQL.Add('  WHERE TRUE ');
    qryDados.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDados.SQL.Add(' 	  AND (LOCATE(RIGHT(D.DET_CLAFIS,3), :CLA_UC) OR D.DET_ESPDOC = "UC") ');

    pSetaFiltroComum(qryDados);
    pSetaParametros(qryDados);

    qryDados.ParamByName('CLA_UC').AsString := fTransform(fCfgSis('CLA_UC'), 3, '_');

    //--
    qryDetal.Close;
    qryDetal.SQL.Clear;
    qryDetal.SQL.Add(' SELECT	' + fGetColunasAgrupamentoCfop);
    qryDetal.SQL.Add('   FROM MOVDET D ');
    qryDetal.SQL.Add('  INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDetal.SQL.Add(' 	INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDetal.SQL.Add('   LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ');
    qryDetal.SQL.Add('   LEFT JOIN CADCLI ON CLI_CODCLI = D.DET_CODCLI ');
    qryDetal.SQL.Add('   LEFT JOIN CADFOR ON FOR_CODFOR = D.DET_CODFOR ');
    qryDetal.SQL.Add('  WHERE TRUE ');
    qryDetal.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDetal.SQL.Add(' 	  AND (LOCATE(RIGHT(D.DET_CLAFIS,3), :CLA_UC) OR D.DET_ESPDOC = "UC") ');

    pSetaFiltroComum(qryDetal);
    pSetaParametros(qryDetal);

    qryDetal.ParamByName('CLA_UC').AsString := fTransform(fCfgSis('CLA_UC'), 3, '_');
    //--

    qryDados.Open;
    strSQLSaidas := strSQLSaidas + IIF(fEmptyStr(strSQLSaidas), '', ' UNION ALL ') + ' SELECT -IFNULL(VALTOT,0) AS VALTOT, -IFNULL(QTDITE,0) AS QTDITE FROM ( ' + fSQLBind(qryDados) + ' ) AS TAB ';
    strSQLDetSaidas := strSQLDetSaidas + IIF(fEmptyStr(strSQLDetSaidas), '', ' UNION ALL ') + ' SELECT SAI.CODITE, SAI.DESCRI, SAI.REFERE, SAI.UNIDAD, SUM(-IFNULL(SAI.QTDITE,0)) AS VALTOT FROM ( ' + fSQLBind(qryDetal) + ' ) AS SAI GROUP BY SAI.CODITE';
    pInsertDados('3 - SAÍDAS', '(-) USO/CONSUMO', qryDados.FieldByName('VALTOT').AsFloat, '-', fSQLBind(qryDados), fSQLBind(qryDetal), False, qryDados.FieldByName('QTDITE').AsFloat);
    qryDados.Close;
  Finally
    FreeAndNil(qryDados);
    FreeAndNil(qryDetal);
  End;
end;

function TfrmConferenciaEstoqueContabil.fPeriodoAtual: String;
  Var
    wordDia, wordMes, wordAno: Word;
    periodoAtual : TDateTime;
begin
  wordDia := 1;
  wordMes := StrToInt(LeftStr(mskPeriodo.Text, 2));
  wordAno := StrToInt(RightStr(mskPeriodo.Text, 4));
  periodoAtual := EncodeDate(wordAno, wordMes, wordDia);
  Result := FormatDateTime('yyyymm', periodoAtual);
end;

function TfrmConferenciaEstoqueContabil.fPeriodoAnterior: String;
  Var
    wordDia, wordMes, wordAno: Word;
    periodoAtual : TDateTime;
    periodoAnterior : TDateTime;
begin
  wordDia := 1;
  wordMes := StrToInt(LeftStr(mskPeriodo.Text, 2));
  wordAno := StrToInt(RightStr(mskPeriodo.Text, 4));
  periodoAtual := EncodeDate(wordAno, wordMes, wordDia);
  periodoAnterior := IncMonth(periodoAtual, -1);
  Result := FormatDateTime('yyyymm', periodoAnterior);
end;

function TfrmConferenciaEstoqueContabil.fPeriodoAnteriorMascara: String;
  Var
    periodoAnterior : TDateTime;
begin
  periodoAnterior := IncMonth(VS_Date, -1);
  Result := FormatDateTime('mm/yyyy', periodoAnterior);
end;

function TfrmConferenciaEstoqueContabil.fSQLBind(qryDados: TUniQuery): String;
  Var
    intCnt : Integer;
begin
  Result := qryDados.SQL.Text;

  For intCnt := 0 To qryDados.ParamCount-1 Do
  Begin
    Case qryDados.Params[intCnt].DataType Of
      ftDateTime:
        Result := ReplaceStr(Result, ':' + qryDados.Params[intCnt].Name, QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', qryDados.Params[intCnt].AsDateTime)));

      ftDate:
        Result := ReplaceStr(Result, ':' + qryDados.Params[intCnt].Name, QuotedStr(FormatDateTime('yyyy-mm-dd', qryDados.Params[intCnt].AsDate)));

      ftFloat:
        Result := ReplaceStr(Result, ':' + qryDados.Params[intCnt].Name, QuotedStr(fFloatToStrPonto(qryDados.Params[intCnt].AsFloat, 12, 2)));
      Else
        Result := ReplaceStr(Result, ':' + qryDados.Params[intCnt].Name, QuotedStr(qryDados.Params[intCnt].AsString));
    End;
  End;
end;

function TfrmConferenciaEstoqueContabil.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodEmp) Then
    Begin
      if (Not fEmptyStr(edtCodEmp.Text)) Then
      begin
        if not (edtCodEmp.Text = StringOfChar('0', edtCodEmp.TamCampo)) then
        begin
          edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtCodEmp.Text], False);
          If (fEmptyStr(edtNomEmp.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
            Result := False;
          End;
        end;
      end
      else
      begin
        edtNomEmp.Clear;
        pDesmarcaLista(edtCodEmp, arrCodEmp);
      end;

      chkEmpCol.Visible := (Length(arrCodEmp) > 1) and (not chkModoDebug.Visible);
      if not chkEmpCol.Visible then
        chkEmpCol.Checked := False;
    End

    Else If (Sender = mskLinGru) Then
    Begin
      pDesmarcaLista(mskLinGru, arrLinGru, '', 6);
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmConferenciaEstoqueContabil.GetPropertiesButtonDetalhes(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := cxButtonItemDetalhes.Properties;
end;

procedure TfrmConferenciaEstoqueContabil.GetPropertiesButtonSQL(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := cxButtonItemSQL.Properties;
end;

procedure TfrmConferenciaEstoqueContabil.mskLinGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGru, edtNomGru, arrLinGru, fRetNomeLinhaGrupo, Nil, 'da Linha/Grupo', 6);
end;

procedure TfrmConferenciaEstoqueContabil.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinGru, edtNomGru, Nil, Key, arrLinGru, False) Then
  Begin
    If fValidaCampos(mskLinGru, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConferenciaEstoqueContabil.OnGeraExcel(Excel: TExcel;
  Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
begin

end;

procedure TfrmConferenciaEstoqueContabil.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnGeraExcel.Visible := (pgcDados.ActivePage = tbsDados) And (Not cdsDados.IsEmpty);
end;

procedure TfrmConferenciaEstoqueContabil.pGerar;
begin
  fChamaTelaGravando(fConfirmar);
end;

function TfrmConferenciaEstoqueContabil.fGerarColunado(
  pgbProgresso: TcxProgressBar): Boolean;
  var
    arrClone : TConsultasArray;
    intCnt : Integer;
    intFields : Integer;
    strField : string;
begin
  Result := True;

  if Assigned(cdsColunado) then
    FreeAndNil(cdsColunado);

  arrClone := arrCodEmp;
  cdsColunado := fCriarCdsDados(arrCodEmp);
  try
    cxgDadosDBTableViewCitel1btnsql.Visible := False;
    cxgDadosDBTableViewCitel1detalhe.Visible := False;
    cxgDadosDBTableViewCitel1valor.Caption := 'Valor Total';
    cxgDadosDBTableViewCitel1SomaQtd.Caption := 'Qtd. Total';
    dtsDados.DataSet := cdsColunado;

    SetLength(arrCodEmp, 0);
    for intCnt := Low(arrClone) to High(arrClone) do
    begin
      edtCodEmp.Text := arrClone[intCnt].strCodigo;
      pGerar;

      if (cdsColunado.IsEmpty) then
      begin
        cdsDados.First;
        while not cdsDados.Eof do
        begin
          cdsColunado.Append;
          For intFields := 0 To cdsDados.Fields.Count -1 Do
          begin
            if not cdsDados.Fields[intFields].IsNull then
              cdsColunado.Fields[intFields].Value := cdsDados.Fields[intFields].Value;
          end;
          cdsColunado.FieldByName('valor').AsFloat := 0;
          cdsColunado.FieldByName('SomaQtd').AsFloat := 0;
          cdsColunado.Post;
          cdsDados.Next;
        end;
      end;

      cdsDados.First;
      while not cdsDados.Eof do
      begin
        if cdsColunado.FindKey([cdsDados.FieldByName('tipmov').AsString, cdsDados.FieldByName('sequen').AsString]) then
        begin
          For intFields := 0 To cdsColunado.Fields.Count -1 Do
          begin
            if RightStr(cdsColunado.Fields[intFields].FieldName, 3) = arrClone[intCnt].strCodigo then
            begin
              strField := Copy(cdsColunado.Fields[intFields].FieldName, 1, Length(cdsColunado.Fields[intFields].FieldName)-4);
              if (Assigned(cdsDados.FindField(strField))) and
                 (not cdsDados.FieldByName(strField).IsNull) then
              begin
                cdsColunado.Edit;
                cdsColunado.FieldByName(cdsColunado.Fields[intFields].FieldName).Value := cdsDados.FieldByName(strField).Value;
                cdsColunado.Post;
              end;
            end;
          end;
        end;
        cdsDados.Next;
      end;

      cdsColunado.First;
      while not cdsColunado.Eof do
      begin
        cdsColunado.Edit;
        cdsColunado.FieldByName('valor').AsFloat := 0;
        cdsColunado.FieldByName('SomaQtd').AsFloat := 0;
        cdsColunado.Post;
        cdsColunado.Next;
      end;

      cdsColunado.First;
      while not cdsColunado.Eof do
      begin
        cdsColunado.Edit;
        For intFields := Low(arrClone) To High(arrClone) Do
        begin
          cdsColunado.FieldByName('valor').AsFloat := cdsColunado.FieldByName('valor').AsFloat + cdsColunado.FieldByName('valor_' + arrClone[intFields].strCodigo).AsFloat;
          cdsColunado.FieldByName('SomaQtd').AsFloat := cdsColunado.FieldByName('SomaQtd').AsFloat + cdsColunado.FieldByName('SomaQtd_' + arrClone[intFields].strCodigo).AsFloat;
        end;
        cdsColunado.Post;
        cdsColunado.Next;
      end;

      pApresentarDados(arrClone);
    end;
  finally
    arrCodEmp := arrClone;
    edtCodEmp.Text := StringOfChar('0', edtCodEmp.TamCampo);
    edtNomEmp.Text := '+1';
  end;
end;

function TfrmConferenciaEstoqueContabil.fGerarTodosItens(pgbProgresso: TcxProgressBar): Boolean;
begin
  Self.pgbProgresso := pgbProgresso;
  try
    pSetaTextoStatus('Abrindo itens inventário atual...');
    pCarregaItensDoPeriodoAtual;
    pSetaTextoStatus('Processando Itens...');
  finally
    Self.pgbProgresso := nil;
  end;

  qryItensPeriodo.First;

  if (not fEmptyStr(edtProdutos.Text)) then
  begin
    if qryItensPeriodo.Locate('ITE_CODITE', edtProdutos.Text, []) then
      qryItensPeriodo.Next;
  end;

  while not qryItensPeriodo.Eof Do
  begin
    edtProdutos.Text := qryItensPeriodo.FieldByName('ITE_CODITE').AsString;
    edtDesProduto.Text := qryItensPeriodo.FieldByName('ITE_DESITE').AsString;

    pGerar;

    if (pgcDados.ActivePage = tbsDados) then
      break;

    qryItensPeriodo.Next;
  end;

  Result := True;
end;

procedure TfrmConferenciaEstoqueContabil.pCarregaItensDoPeriodoAtual;

  function fTabelaSaldos: String;
  begin
    Result := 'I_' + fPeriodoAtual;
    If Not fTabelaExiste(Result) Then
      Result := 'ITEGER';
  end;

  function fAliasTabelaSaldos: String;
  var
    strTabela: string;
  begin
    Result := 'G.';
    strTabela := 'I_' + fPeriodoAtual;
    If Not fTabelaExiste(strTabela) Then
      Result := 'I.';
  end;

begin
  if (qryItensPeriodo.Active) and (not qryItensPeriodo.IsEmpty) and
     (strPeriodoCarregado = fTabelaSaldos) then
    Exit;

  strPeriodoCarregado := fTabelaSaldos;

  qryItensPeriodo.Close;
  qryItensPeriodo.SQL.Clear;
  qryItensPeriodo.SQL.Add(' SELECT I.ITE_CODITE, I.ITE_DESITE ');
  qryItensPeriodo.SQL.Add('   FROM CADITE I ');
  qryItensPeriodo.SQL.Add('   JOIN ' + fTabelaSaldos + ' G ON G.ITE_CODITE = I.ITE_CODITE ');
  qryItensPeriodo.SQL.Add('  WHERE TRUE ');

  If (Not fEmptyStr(edtCodEmp.Text)) Then
    qryItensPeriodo.SQL.Add(fStrLocate(edtCodEmp, arrCodEmp, 'G.ITE_CODEMP', 'CODEMP'));

  // POSITIVOS!
  qryItensPeriodo.SQL.Add('  	AND IFNULL(G.ITE_SALDOS, 0) + IF(IFNULL(' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / ' + fAliasTabelaSaldos + 'ITE_CNV_ML, 0) > 0 ');

  If Not fEmptyStr(mskLinGru.Text) Then
    qryItensPeriodo.SQL.Add(fFiltroExclusaoLinhaGrupo(fAliasTabelaSaldos));

  If (Not fEmptyStr(edtCodEmp.Text)) Then
    pSetaParam(edtCodEmp.Text, arrCodEmp, strCadEmp, 'CODEMP', qryItensPeriodo);

  If Not fEmptyStr(mskLinGru.Text) Then
    pSetaParam(mskLinGru.Text, arrLinGru, strLinGru, 'CODGRU', qryItensPeriodo);

  qryItensPeriodo.Open;
end;

function TfrmConferenciaEstoqueContabil.fConfirmar(pgbProgresso: TcxProgressBar): Boolean;
  var
    blnExibirDados : boolean;
    qryInsere : TUniQuery;
begin

  strEmpCfg := IIF(fEmptyStr(edtCodEmp.Text), VS_strCodEmp, IIF(edtCodEmp.Text = '000', VS_strCodEmp, edtCodEmp.Text));

  Self.pgbProgresso := pgbProgresso;
  Try
    intSequen := 0;
    fltSaldoFinal := 0;
    fltQtdFinal := 0;

    cdsDados.EmptyDataSet;

    pSaldoInicial;
    pCompras;
    pImpostosRecuperaveisDeCompras;
    pTransferenciasEntradas;
    pOutrasEntradas;
    pGarantiaClienteEntradas;
    pAjusteEntradas;
    pDevolucoesDeClientes;
    pBonificadaoDeFornecedores;

    pSaidas;
    pTransferenciasSaidas;
    pOutrasSaidas;
    pGarantiaClienteSaidas;
    pAjustesSaidas;
    pUsoConsumo;
    pBonificacaoDeClientes;
    pDevolucaoAFornecedores;

    strSQLSaldoFinal := 'SELECT SUM(VALTOT) AS VALTOT, SUM(QTDITE) AS QTDITE FROM ( ' + strSQLInicial + ' UNION ALL ' + strSQLEntradas + ' UNION ALL ' + strSQLSaidas + ' ) AS TAB';
    strSQLDetSaldoFinal := 'SELECT ITE_CODITE AS CODITE, ITE_DESITE AS DESCRI, ITE_REFERE AS REFERE, UNI_SIGUNI AS UNIDAD, SUM(IFNULL(INI.VALTOT,0) + IFNULL(ENT.VALTOT,0) + IFNULL(SAI.VALTOT,0)) AS VALTOT ';
    strSQLDetSaldoFinal := strSQLDetSaldoFinal + ' FROM CADITE ';
    strSQLDetSaldoFinal := strSQLDetSaldoFinal + ' LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ';
    strSQLDetSaldoFinal := strSQLDetSaldoFinal + ' LEFT JOIN ( ' + strSQLDetInicial + ' ) AS INI ON ITE_CODITE = INI.CODITE ';
    strSQLDetSaldoFinal := strSQLDetSaldoFinal + ' LEFT JOIN ( SELECT CODITE, DESCRI, REFERE, UNIDAD, SUM(IFNULL(VALTOT,0)) AS VALTOT FROM ( ' + strSQLDetEntradas + ' ) AS TAB GROUP BY CODITE ) AS ENT ON ITE_CODITE = ENT.CODITE ';
    strSQLDetSaldoFinal := strSQLDetSaldoFinal + ' LEFT JOIN ( SELECT CODITE, DESCRI, REFERE, UNIDAD, SUM(IFNULL(VALTOT,0)) AS VALTOT FROM ( ' + strSQLDetSaidas + ' ) AS TAB GROUP BY CODITE ) AS SAI ON ITE_CODITE = SAI.CODITE ';
    strSQLDetSaldoFinal := strSQLDetSaldoFinal + ' WHERE ((INI.CODITE IS NOT NULL) OR (ENT.CODITE IS NOT NULL) OR (SAI.CODITE IS NOT NULL)) ';
    strSQLDetSaldoFinal := strSQLDetSaldoFinal + ' GROUP BY ITE_CODITE ';

    qryInsere := fCriaQuery(nil);
    try
      // Essa for a forma que consegui de não dar erro de TableName cannot be empty no SELECT: Criando uma TMP com os dados dentro dela e usando a TMP no botão de detalhe
      qryInsere.SQL.Clear;
      qryInsere.SQL.Add('DROP TEMPORARY TABLE IF EXISTS TMP_DET_SALDO_FINAL;');
      qryInsere.SQL.Add('CREATE TEMPORARY TABLE TMP_DET_SALDO_FINAL AS (' + strSQLDetSaldoFinal + ');');
      qryInsere.ExecSQL;
    finally
      FreeAndNil(qryInsere);
    end;

    pInsertDados('4 - SALDO FINAL', 'SALDO FINAL', fltSaldoFinal, '', strSQLSaldoFinal, 'SELECT * FROM TMP_DET_SALDO_FINAL', False, fltQtdFinal);

    pSaldoInventario;
    pTransferenciaDeMercadorias;

    pEstoqueEmGarantia;

    blnExibirDados := not chkEmpCol.Checked;

    if chkModoDebug.Checked then
    begin
      blnExibirDados := False;

      if (cdsDados.Locate('subtip', 'DIFERENÇA', [])) then
        blnExibirDados := (fFormataFloat(cdsDados.FieldByName('valor').AsFloat, 2) > edtFiltroValor.Value) Or (fFormataFloat(cdsDados.FieldByName('SomaQtd').AsFloat, 2) > edtFiltroQuantidade.Value);
    end;

    If (cdsdados.IsEmpty) Then
    begin
      if not chkModoDebug.Checked then
        fMensagem('ATENÇÃO!', 'Não há dados para exibir!', ['&OK']);
    end
    Else if (blnExibirDados) then
    Begin
      pApresentarDados(arrCodEmp);
    End;

    Result := True;
  Finally
    Self.pgbProgresso := Nil;
  End;
end;

function TfrmConferenciaEstoqueContabil.fDataFinal: TDateTime;
begin
  Result := DateOf(EndOfTheMonth(fDataInicial));
end;

function TfrmConferenciaEstoqueContabil.fDataInicial: TDateTime;
  Var
    wordDia, wordMes, wordAno: Word;
begin
  wordDia := 1;
  wordMes := StrToInt(LeftStr(mskPeriodo.Text, 2));
  wordAno := StrToInt(RightStr(mskPeriodo.Text, 4));
  Result := EncodeDate(wordAno, wordMes, wordDia);
end;

function TfrmConferenciaEstoqueContabil.fGetColunasAgrupamentoCfop(blnMedNovo: Boolean = False; blnVlrConMaisConFreMaisVlrGnre: boolean = false): String;
begin
  Result := '';
  Result := Result + ' DET_CLAFIS AS CLAFIS, DET_DTAENT AS DTAENT, DET_NUMDOC AS NUMDOC, ';
  Result := Result + ' DET_ESPDOC AS ESPDOC, DET_CODEMP AS CODEMP, IFNULL(DET_CODCLI, DET_CODFOR) AS CLIFOR, ';
  Result := Result + ' DET_CODITE AS CODITE, DET_DESCRI AS DESCRI, DET_QTDITE AS QTDITE, DET_UNITAR AS UNITAR, ';
  Result := Result + ' DET_TOTITE AS TOTITE, DET_TOTFRE AS TOTFRE, DET_DESACE AS DESACE, ';
  Result := Result + ' ITE_REFERE AS REFERE, UNI_SIGUNI AS UNIDAD, ';

  If (blnMedNovo) Then
    Result := Result + ' (DET_QTDITE * ITE_MEDNOV) AS TOTMED, '
  Else
    Result := Result + ' DET_TOTMED AS TOTMED, ';

  if (blnVlrConMaisConFreMaisVlrGnre) then
    Result := Result + ' DET_VLRCON + IFNULL(DET_CONFRE,0) + IFNULL(DET_VLGNRE,0) AS VLRCON, '
  else
    Result := Result + ' DET_VLRCON AS VLRCON, ';

  Result := Result + ' DET_VALIPI AS VALIPI, DET_VALRET AS VALRET, ';
  Result := Result + ' CONCAT(DATE_FORMAT(DET_DTAENT, "%d/%m/%Y"), "-", DET_NUMDOC, "-", DET_ESPDOC, "-", DET_CODEMP, "-", IFNULL(DET_CODCLI, DET_CODFOR), "-", IFNULL(CLI_NOMCLI, FOR_NOMFOR)) AS AGRUP2 ';
end;

procedure TfrmConferenciaEstoqueContabil.pSetaParametros(qryParam: TUniQuery);
begin
  qryParam.ParamByName('DTAINI').AsDate := fDataInicial;
  qryParam.ParamByName('DTAFIN').AsDate := fDataFinal;

  If (Not fEmptyStr(edtCodEmp.Text)) Then
    pSetaParam(edtCodEmp.Text, arrCodEmp, strCadEmp, 'CODEMP', qryParam);

  If Not fEmptyStr(mskLinGru.Text) Then
    pSetaParam(mskLinGru.Text, arrLinGru, strLinGru, 'CODGRU', qryParam);

  if not fEmptyStr(edtProdutos.Text) then
    pSetaParam(edtProdutos.Text, arrCadIte, strCadIte, 'CODITE', qryParam);
end;

procedure TfrmConferenciaEstoqueContabil.pSetaFiltroComum(qryFiltro: TUniQuery);
begin
  if (Not fEmptyStr(edtCodEmp.Text)) then
    qryFiltro.SQL.Add(fStrLocate(edtCodEmp, arrCodEmp, 'D.DET_CODEMP', 'CODEMP'));

  qryFiltro.SQL.Add('    AND D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ');

  if (not fEmptyStr(mskLinGru.Text)) then
    qryFiltro.SQL.Add(fFiltroExclusaoLinhaGrupo());

  if (not fEmptyStr(edtProdutos.Text)) then
    qryFiltro.SQL.Add(fStrLocate(edtProdutos, arrCadIte, 'D.DET_CODITE', 'CODITE'));
end;

procedure TfrmConferenciaEstoqueContabil.pSetaTextoStatus(strInformacao: String);
begin
  If Assigned(pgbProgresso) And (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strInformacao;
    Application.ProcessMessages;
  End;
end;

procedure TfrmConferenciaEstoqueContabil.pDefineDataSetExibicao(Sender: TObject; var strField: string; var DataSet: TDataSet);
  var
    AGridView : TcxGridDBTableView;
    strCodEmp : string;
begin
  DataSet := cdsDados;
  if (chkEmpCol.Checked) then
  begin
    AGridView := TcxGridDBTableView(TcxButtonEdit(Sender).owner);
    strCodEmp := RightStr(TcxGridDBColumn(AGridView.Controller.FocusedItem).DataBinding.FieldName, 3);
    strField := strField + '_' + strCodEmp;
    DataSet := cdsColunado;
  end;
end;

procedure TfrmConferenciaEstoqueContabil.pDevolucaoAFornecedores;
  Var
    qryDados : TUniQuery;
    qryDetal : TUniQuery;
begin
  pSetaTextoStatus('Devolução a Fornecedores (Saídas)...');
  qryDados := fCriaQuery(Self);
  qryDetal := fCriaQuery(Self);
  Try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(' SELECT SUM(D.DET_TOTMED) AS VALTOT, SUM(D.DET_QTDITE) AS QTDITE ');
    qryDados.SQL.Add('   FROM MOVDET D ');
    qryDados.SQL.Add(' 	INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDados.SQL.Add(' 	INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDados.SQL.Add('  WHERE TRUE ');
    qryDados.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDados.SQL.Add('    AND LOCATE(D.DET_CODFOR, :FORFIL ) = 0 ');
    qryDados.SQL.Add(' 	  AND D.DET_CLAFIS IN ("5411", "6411", "5202", "6202", "5661", "6661") ');
    qryDados.SQL.Add('    AND D.DET_TIP_FC = "F" ');

    pSetaFiltroComum(qryDados);
    pSetaParametros(qryDados);

    qryDados.ParamByName('FORFIL').AsString := fRetForFilialTodos(False);

    //-
    qryDetal.Close;
    qryDetal.SQL.Clear;
    qryDetal.SQL.Add(' SELECT ' + fGetColunasAgrupamentoCfop);
    qryDetal.SQL.Add('   FROM MOVDET D ');
    qryDetal.SQL.Add(' 	INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDetal.SQL.Add(' 	INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDetal.SQL.Add('   LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ');
    qryDetal.SQL.Add('   LEFT JOIN CADCLI ON CLI_CODCLI = D.DET_CODCLI ');
    qryDetal.SQL.Add('   LEFT JOIN CADFOR ON FOR_CODFOR = D.DET_CODFOR ');
    qryDetal.SQL.Add('  WHERE TRUE ');
    qryDetal.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDetal.SQL.Add('    AND LOCATE(D.DET_CODFOR, :FORFIL ) = 0 ');
    qryDetal.SQL.Add(' 	  AND D.DET_CLAFIS IN ("5411", "6411", "5202", "6202", "5661", "6661") ');
    qryDetal.SQL.Add('    AND D.DET_TIP_FC = "F" ');

    pSetaFiltroComum(qryDetal);
    pSetaParametros(qryDetal);

    qryDetal.ParamByName('FORFIL').AsString := fRetForFilialTodos(False);
    //-

    qryDados.Open;
    strSQLSaidas := strSQLSaidas + IIF(fEmptyStr(strSQLSaidas), '', ' UNION ALL ') + ' SELECT -IFNULL(VALTOT,0) AS VALTOT, -IFNULL(QTDITE,0) AS QTDITE FROM ( ' + fSQLBind(qryDados) + ' ) AS TAB ';
    strSQLDetSaidas := strSQLDetSaidas + IIF(fEmptyStr(strSQLDetSaidas), '', ' UNION ALL ') + ' SELECT SAI.CODITE, SAI.DESCRI, SAI.REFERE, SAI.UNIDAD, SUM(-IFNULL(SAI.QTDITE,0)) AS VALTOT FROM ( ' + fSQLBind(qryDetal) + ' ) AS SAI GROUP BY SAI.CODITE';
    pInsertDados('3 - SAÍDAS', '(-) DEVOLUÇÃO A FORNECEDORES', qryDados.FieldByName('VALTOT').AsFloat, '-', fSQLBind(qryDados), fSQLBind(qryDetal), False, qryDados.FieldByName('QTDITE').AsFloat);
    qryDados.Close;
  Finally
    FreeAndNil(qryDados);
    FreeAndNil(qryDetal);
  End;
end;

procedure TfrmConferenciaEstoqueContabil.pDevolucoesDeClientes;
  Var
    qryDados : TUniQuery;
    qryDetal : TUniQuery;
begin
  pSetaTextoStatus('Devoluções de Clientes...');
  qryDados := fCriaQuery(Self);
  qryDetal := fCriaQuery(Self);
  Try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add('SELECT ');
    qryDados.SQL.Add('	SUM(VALTOT) AS VALTOT, SUM(QTDITE) AS QTDITE ');
    qryDados.SQL.Add('FROM ');
    qryDados.SQL.Add('	( ');
    qryDados.SQL.Add('	SELECT ');
    qryDados.SQL.Add('		SUM(D.DET_TOTMED) AS VALTOT, SUM(D.DET_QTDITE) AS QTDITE ');
    qryDados.SQL.Add('	FROM MOVDET D ');
    qryDados.SQL.Add('		INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDados.SQL.Add(' 	  INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDados.SQL.Add('	WHERE TRUE ');
    qryDados.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDados.SQL.Add('		AND D.DET_PROEMB <> "S" ');
    qryDados.SQL.Add('		AND D.DET_TIP_FC = "C" ');
    qryDados.SQL.Add('		AND IF(:FATCLF = "N",LOCATE(D.DET_CODCLI, :CLIFIL) <= 0, TRUE) ');
    qryDados.SQL.Add('		AND ((LOCATE(D.DET_CLAFIS, :CLAVEN) > 0) ');
    qryDados.SQL.Add('					OR (LOCATE(D.DET_CLAFIS, :CLADEV) > 0) ');
    qryDados.SQL.Add('				  OR (D.DET_CLAFIS IN ("1949", "2949"))  ');
    qryDados.SQL.Add('				) ');
    qryDados.SQL.Add('    AND LEFT(D.DET_CLAFIS, 1) < 5 ');
    qryDados.SQL.Add('    AND RIGHT(D.DET_CLAFIS, 3) <> "910" ');

    pSetaFiltroComum(qryDados);

    qryDados.SQL.Add('	) AS TAB ');

    pSetaParametros(qryDados);

    qryDados.ParamByName('CLIFIL').AsString := FClienteFilialLocate;
    qryDados.ParamByName('CLAVEN').AsString := VS_strClaVen;
    qryDados.ParamByName('CLADEV').AsString := VS_strClaDev;
    qryDados.ParamByName('FATCLF').AsString := fCfgSis('FATCLF');

    //--
    qryDetal.Close;
    qryDetal.SQL.Clear;
    qryDetal.SQL.Add(' SELECT ' + fGetColunasAgrupamentoCfop);
    qryDetal.SQL.Add('   FROM MOVDET D ');
    qryDetal.SQL.Add('		INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    qryDetal.SQL.Add(' 	  INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ');
    qryDetal.SQL.Add('     LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ');
    qryDetal.SQL.Add('     LEFT JOIN CADCLI ON CLI_CODCLI = D.DET_CODCLI ');
    qryDetal.SQL.Add('     LEFT JOIN CADFOR ON FOR_CODFOR = D.DET_CODFOR ');
    qryDetal.SQL.Add('	WHERE TRUE ');
    qryDetal.SQL.Add('    AND D.DET_FILKAR = 0 ');
    qryDetal.SQL.Add('		AND D.DET_PROEMB <> "S" ');
    qryDetal.SQL.Add('		AND D.DET_TIP_FC = "C" ');
    qryDetal.SQL.Add('		AND IF(:FATCLF = "N",LOCATE(D.DET_CODCLI, :CLIFIL) <= 0, TRUE) ');
    qryDetal.SQL.Add('		AND ((LOCATE(D.DET_CLAFIS, :CLAVEN) > 0) ');
    qryDetal.SQL.Add('					OR (LOCATE(D.DET_CLAFIS, :CLADEV) > 0) ');
    qryDetal.SQL.Add('				  OR (D.DET_CLAFIS IN ("1949", "2949"))  ');
    qryDetal.SQL.Add('				) ');
    qryDetal.SQL.Add('    AND LEFT(D.DET_CLAFIS, 1) < 5 ');
    qryDetal.SQL.Add('    AND RIGHT(D.DET_CLAFIS, 3) <> "910" ');

    pSetaFiltroComum(qryDetal);

    pSetaParametros(qryDetal);

    qryDetal.ParamByName('CLIFIL').AsString := FClienteFilialLocate;
    qryDetal.ParamByName('CLAVEN').AsString := VS_strClaVen;
    qryDetal.ParamByName('CLADEV').AsString := VS_strClaDev;
    qryDetal.ParamByName('FATCLF').AsString := fCfgSis('FATCLF');
    //--

    qryDados.Open;
    strSQLEntradas := strSQLEntradas + IIF(fEmptyStr(strSQLEntradas), '', ' UNION ALL ') + ' SELECT IFNULL(VALTOT,0) AS VALTOT, IFNULL(QTDITE,0) AS QTDITE FROM ( ' + fSQLBind(qryDados) + ' ) AS TAB ';
    strSQLDetEntradas := strSQLDetEntradas + IIF(fEmptyStr(strSQLDetEntradas), '', ' UNION ALL ') + ' SELECT ENT.CODITE, ENT.DESCRI, ENT.REFERE, ENT.UNIDAD, SUM(IFNULL(ENT.QTDITE,0)) AS VALTOT FROM ( ' + fSQLBind(qryDetal) + ' ) AS ENT GROUP BY ENT.CODITE';
    pInsertDados('2 - ENTRADAS', '(+) DEVOLUÇÕES DE CLIENTES', qryDados.FieldByName('VALTOT').AsFloat, '+', fSQLBind(qryDados), fSQLBind(qryDetal), False, qryDados.FieldByName('QTDITE').AsFloat);
    qryDados.Close;

  Finally
    FreeAndNil(qryDados);
    FreeAndNil(qryDetal);
  End;

end;

function TfrmConferenciaEstoqueContabil.fFiltroExclusaoLinhaGrupo(strAliasCadIte: String = 'CADITE.'): String;
  Var
    strSQL : String;
    strSQLLinGru : String;
    intCnt : Integer;
Begin
  strSQL := '';
  If Not fEmptyStr(mskLinGru.Text) Then
  Begin
    If Length(arrLinGru) > 1 Then
    Begin
      For intCnt := Low(arrLinGru) To High(arrLinGru) Do
      Begin
        If Not fEmptyStr(arrLinGru[intCnt].strCodigo) Then
        Begin
          If Not fEmptyStr(strSQLLinGru) Then
            strSQLLinGru := strSQLLinGru + ' AND ';

          If RightStr(arrLinGru[intCnt].strCodigo,3) = '000' Then
            strSQLLinGru := strSQLLinGru + '(LEFT(' + strAliasCadIte + 'ITE_CODGRU,3) <> ' + QuotedStr(LeftStr(arrLinGru[intCnt].strCodigo,3)) + ')'
          Else
            strSQLLinGru := strSQLLinGru + '(' + strAliasCadIte + 'ITE_CODGRU <> ' + QuotedStr(arrLinGru[intCnt].strCodigo) + ')';
        End;
      End;

      If Not fEmptyStr(strSQLLinGru) Then
        strSQL := strSQL + ' AND (' + strSQLLinGru + ') ';
    End
    Else
    Begin
      If RightStr(mskLinGru.Text,3) = '000' Then
        strSQL := strSQL + '  AND LEFT(' + strAliasCadIte + 'ITE_CODGRU,3) <> LEFT(:CODGRU,3) '
      Else
        strSQL := strSQL + '  AND ' + strAliasCadIte + 'ITE_CODGRU <> :CODGRU ';
    End;
  End;
  Result := strSQL;
End;

procedure TfrmConferenciaEstoqueContabil.pEstoqueEmGarantia;

  function fTabelaSaldos: String;
  begin
    Result := 'I_' + fPeriodoAtual;
    If Not fTabelaExiste(Result) Then
      Result := 'ITEGER';
  end;

  function fAliasTabelaSaldos: String;
  var
    strTabela: string;
  begin
    Result := 'G.';
    strTabela := 'I_' + fPeriodoAtual;
    If Not fTabelaExiste(strTabela) Then
      Result := 'I.';
  end;

  Var
    qryDados : TUniQuery;
    qryDetal : TUniQuery;
begin
  pSetaTextoStatus('Estoque em Garantia...');

  qryDados := fCriaQuery(Self);
  qryDetal := fCriaQuery(Self);
  Try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(' SELECT ');
    qryDados.SQL.Add('  SUM(G.ITE_SALREG) AS QTDITE, ');
   	qryDados.SQL.Add('  SUM(ROUND(ROUND(IFNULL(IF(:SALINV = "SALDOS", G.ITE_SALREG, G.ITE_SALBAL), 0), :DECQTD) * ( ');
		qryDados.SQL.Add('  (IFNULL(CASE TRIM(:PREINV) ');
		qryDados.SQL.Add('  					WHEN "COM" THEN G.ITE_PRECOM ');
		qryDados.SQL.Add('  					WHEN "CUS" THEN G.ITE_PRECUS ');
		qryDados.SQL.Add('  					WHEN "MED" THEN G.ITE_PREMED ');
		qryDados.SQL.Add('  					WHEN "ULT" THEN G.ITE_PREULT ');
		qryDados.SQL.Add('  					WHEN "ULTFED" THEN G.ITE_PREULT - IFNULL(G.ITE_IMPFED, 0) ');
		qryDados.SQL.Add('  					WHEN "VE1" THEN G.ITE_PREVE1 ');
		qryDados.SQL.Add('  					WHEN "VE2" THEN G.ITE_PREVE2 ');
		qryDados.SQL.Add('  					WHEN "VE3" THEN G.ITE_PREVE3 ');
		qryDados.SQL.Add('  					WHEN "VE4" THEN G.ITE_PREVE4 ');
		qryDados.SQL.Add('  					WHEN "VE5" THEN G.ITE_PREVE5 ');
		qryDados.SQL.Add('  					WHEN "VE6" THEN G.ITE_PREVE6 ');
		qryDados.SQL.Add('  					WHEN "VE7" THEN G.ITE_PREVE7 ');
		qryDados.SQL.Add('  				END, 0) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL),  1, I.ITE_FATCNV))), 2)) AS VALTOT ');
    qryDados.SQL.Add('  FROM ');
    qryDados.SQL.Add('    CADITE I ');
    qryDados.SQL.Add('    JOIN ' + fTabelaSaldos + ' G ON G.ITE_CODITE = I.ITE_CODITE ');
    qryDados.SQL.Add('  WHERE TRUE ');

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      qryDados.SQL.Add(fStrLocate(edtCodEmp, arrCodEmp, 'G.ITE_CODEMP', 'CODEMP'));

    // POSITIVOS!
    qryDados.SQL.Add('  	AND IFNULL(G.ITE_SALREG, 0) > 0 ');

    If Not fEmptyStr(mskLinGru.Text) Then
      qryDados.SQL.Add(fFiltroExclusaoLinhaGrupo(fAliasTabelaSaldos));

    if not fEmptyStr(edtProdutos.Text) then
      qryDados.SQL.Add(fStrLocate(edtProdutos, arrCadIte, 'I.ITE_CODITE', 'CODITE'));

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      pSetaParam(edtCodEmp.Text, arrCodEmp, strCadEmp, 'CODEMP', qryDados);

    If Not fEmptyStr(mskLinGru.Text) Then
      pSetaParam(mskLinGru.Text, arrLinGru, strLinGru, 'CODGRU', qryDados);

    if not fEmptyStr(edtProdutos.Text) then
      pSetaParam(edtProdutos.Text, arrCadIte, strCadIte, 'CODITE', qryDados);

    qryDados.ParamByName('PREINV').AsString := fCfgSis('PREINV', varString);
    qryDados.ParamByName('SALINV').AsString  := fCfgSis('SALINV', varString);
    qryDados.ParamByName('DECQTD').AsInteger := fCfgSis('DECQTD', varInteger);

    qryDetal.Close;
    qryDetal.SQL.Clear;
    qryDetal.SQL.Add(' SELECT I.ITE_CODITE AS CODITE, I.ITE_DESITE AS DESCRI, I.ITE_REFERE AS REFERE, UNI_SIGUNI AS UNIDAD, ');
   	qryDetal.SQL.Add('  ROUND(ROUND(IFNULL(IF(:SALINV = "SALDOS", G.ITE_SALREG, G.ITE_SALBAL), 0), :DECQTD) * ( ');
		qryDetal.SQL.Add('  (IFNULL(CASE TRIM(:PREINV) ');
		qryDetal.SQL.Add('  					WHEN "COM" THEN G.ITE_PRECOM ');
		qryDetal.SQL.Add('  					WHEN "CUS" THEN G.ITE_PRECUS ');
		qryDetal.SQL.Add('  					WHEN "MED" THEN G.ITE_PREMED ');
		qryDetal.SQL.Add('  					WHEN "ULT" THEN G.ITE_PREULT ');
		qryDetal.SQL.Add('  					WHEN "ULTFED" THEN G.ITE_PREULT - IFNULL(G.ITE_IMPFED, 0) ');
		qryDetal.SQL.Add('  					WHEN "VE1" THEN G.ITE_PREVE1 ');
		qryDetal.SQL.Add('  					WHEN "VE2" THEN G.ITE_PREVE2 ');
		qryDetal.SQL.Add('  					WHEN "VE3" THEN G.ITE_PREVE3 ');
		qryDetal.SQL.Add('  					WHEN "VE4" THEN G.ITE_PREVE4 ');
		qryDetal.SQL.Add('  					WHEN "VE5" THEN G.ITE_PREVE5 ');
		qryDetal.SQL.Add('  					WHEN "VE6" THEN G.ITE_PREVE6 ');
		qryDetal.SQL.Add('  					WHEN "VE7" THEN G.ITE_PREVE7 ');
		qryDetal.SQL.Add('  				END, 0) / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL),  1, I.ITE_FATCNV))), 2) AS VALTOT ');
    qryDetal.SQL.Add('  FROM ');
    qryDetal.SQL.Add('    CADITE I ');
    qryDetal.SQL.Add('    JOIN ' + fTabelaSaldos + ' G ON G.ITE_CODITE = I.ITE_CODITE ');
    qryDetal.SQL.Add('    LEFT JOIN CADUNI ON UNI_CODUNI = I.ITE_CODUNI ');
    qryDetal.SQL.Add('  WHERE TRUE ');

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      qryDetal.SQL.Add(fStrLocate(edtCodEmp, arrCodEmp, 'G.ITE_CODEMP', 'CODEMP'));

    // POSITIVOS!
    qryDetal.SQL.Add('  	AND IFNULL(G.ITE_SALREG, 0) > 0 ');

    If Not fEmptyStr(mskLinGru.Text) Then
      qryDetal.SQL.Add(fFiltroExclusaoLinhaGrupo(fAliasTabelaSaldos));

    if not fEmptyStr(edtProdutos.Text) then
      qryDetal.SQL.Add(fStrLocate(edtProdutos, arrCadIte, 'I.ITE_CODITE', 'CODITE'));

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      pSetaParam(edtCodEmp.Text, arrCodEmp, strCadEmp, 'CODEMP', qryDetal);

    If Not fEmptyStr(mskLinGru.Text) Then
      pSetaParam(mskLinGru.Text, arrLinGru, strLinGru, 'CODGRU', qryDetal);

    if not fEmptyStr(edtProdutos.Text) then
      pSetaParam(edtProdutos.Text, arrCadIte, strCadIte, 'CODITE', qryDetal);

    qryDetal.ParamByName('PREINV').AsString := fCfgSis('PREINV', varString);
    qryDetal.ParamByName('SALINV').AsString  := fCfgSis('SALINV', varString);
    qryDetal.ParamByName('DECQTD').AsInteger := fCfgSis('DECQTD', varInteger);

    qryDados.Open;
    pInsertDados('7 - ESTOQUE EM GARANTIA', 'ESTOQUE EM GARANTIA', qryDados.FieldByName('VALTOT').AsFloat, '', fSQLBind(qryDados), fSQLBind(qryDetal), False, qryDados.FieldByName('QTDITE').AsFloat);
    qryDados.Close;
  Finally
    FreeAndNil(qryDados);
    FreeAndNil(qryDetal);
  End;
end;

function TfrmConferenciaEstoqueContabil.fRetClientesFilialLocate: String;
  var
    qryCliFil : TUniQuery;
Begin
  qryCliFil := fCriaQuery;
  try
    qryCliFil.Close;
    qryCliFil.SQL.Clear;
    qryCliFil.SQL.Add(' SELECT SQL_NO_CACHE EMP_CLIFIL ');
    qryCliFil.SQL.Add('   FROM CADEMP ');
    qryCliFil.Open;

    Result := '';
    qryCliFil.First;
    while not qryCliFil.Eof do
    begin
      if not fEmptyStr(qryCliFil.FieldByName('EMP_CLIFIL').AsString) then
        Result := Result + qryCliFil.FieldByName('EMP_CLIFIL').AsString + '_';
      qryCliFil.Next;
    end;

    qryCliFil.Close;
  finally
    FreeAndNil(qryCliFil);
  end;
End;

end.

