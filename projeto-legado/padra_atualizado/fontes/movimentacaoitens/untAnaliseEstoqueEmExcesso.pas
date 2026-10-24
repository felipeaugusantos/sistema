unit untAnaliseEstoqueEmExcesso;

interface

uses
  Windows, Controls, untPaiSimples, StdCtrls, ComCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, EditFocus, MaskEditFocus, untFuncoesSimples, ComboBoxFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridDBTableView, cxGrid,
  Uni, cxGridBandedTableView, cxGridDBBandedTableView, untFiltrosRelatorio, Menus,
  Classes, DB, AppEvnts, cxGridTableView, untZClient, Mask, untTypesSistema,
  frxClass, frxExportCSVTestabilidade, cxProgressBar, System.Variants,
  cxDataControllerConditionalFormattingRulesManagerDialog, untTCamposExportaEstoqueEmExcesso;

type
  TfrmAnaliseEstoqueEmExcesso = class(TfrmPaiSimples)
    TabSheet1: TTabSheet;
    ntbPaginas: TNotebook;
    pnlFiltros: TPanel;
    lblLinhaGrupoIni: TLabel;
    lblProduto: TLabel;
    lblFornecedor: TLabel;
    lblMarca: TLabel;
    lblEmpresa: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    edtCodPro: TEditFocus;
    edtDesPro: TEditFocus;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    mskPeriodo: TMaskEditFocus;
    cmbComCus: TComboBoxFocus;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtNivelA: TEditFocus;
    edtNivelB: TEditFocus;
    edtNivelC: TEditFocus;
    rdgOpcGir: TRadioGroup;
    Label6: TLabel;
    cmbSintetico: TComboBoxFocus;
    Label7: TLabel;
    cmbOpcPreEst: TComboBoxFocus;
    btnExibir: TBitBtnLocked;
    pnlGrid: TPanel;
    dbgDados: TcxGrid;
    dbgDadosLevel1: TcxGridLevel;
    dbgDadosDBBandedTableView: TcxGridDBBandedTableView;
    colGRUPO: TcxGridDBBandedColumn;
    colQTDITE: TcxGridDBBandedColumn;
    colFATURA: TcxGridDBBandedColumn;
    colCUMVEN: TcxGridDBBandedColumn;
    colRESULT: TcxGridDBBandedColumn;
    colMARKUP: TcxGridDBBandedColumn;
    colMARGEM: TcxGridDBBandedColumn;
    colESTBRU: TcxGridDBBandedColumn;
    colEXCESS: TcxGridDBBandedColumn;
    colSEMMOV: TcxGridDBBandedColumn;
    colESTREA: TcxGridDBBandedColumn;
    colESTOBJ: TcxGridDBBandedColumn;
    colESTIDE: TcxGridDBBandedColumn;
    colCUSCOM: TcxGridDBBandedColumn;
    colCOMEXC: TcxGridDBBandedColumn;
    colREPRES: TcxGridDBBandedColumn;
    btnVoltar: TBitBtnLocked;
    pnlButtom: TPanel;
    btnExcel: TBitBtnLocked;
    colDESGRU: TcxGridDBBandedColumn;
    colSIGUNI: TcxGridDBBandedColumn;
    colCODFAB: TcxGridDBBandedColumn;
    colDIAEST: TcxGridDBBandedColumn;
    Label8: TLabel;
    edtGruCmp: TEditFocus;
    edtDesGruCmp: TEditFocus;
    colAGRUPA: TcxGridDBBandedColumn;
    colQTDFAT: TcxGridDBBandedColumn;
    colQTDEXC: TcxGridDBBandedColumn;
    colQTDSMO: TcxGridDBBandedColumn;
    colQTDOBJ: TcxGridDBBandedColumn;
    colQTDCOM: TcxGridDBBandedColumn;
    colEXCCOM: TcxGridDBBandedColumn;
    btnGeraTE: TBitBtnLocked;
    gpbPedCompra: TGroupBox;
    edtNumPcm: TEditFocus;
    edtEspPcm: TEditFocus;
    edtEmpPcm: TEditFocus;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    mskIniPcm: TMaskEditFocus;
    Label13: TLabel;
    mskFinPcm: TMaskEditFocus;
    gpbNFEntrada: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    edtNumNfe: TEditFocus;
    edtEspNfe: TEditFocus;
    edtEmpNfe: TEditFocus;
    mskIniNfe: TMaskEditFocus;
    mskFinNfe: TMaskEditFocus;
    colITECODITE: TcxGridDBBandedColumn;
    colITEDESITE: TcxGridDBBandedColumn;
    btnSelCampos: TBitBtnLocked;
    procedure mskLinGruExit(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProExit(Sender: TObject);
    procedure edtCodProKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnExibirClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgDadosDBBandedTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnExcelClick(Sender: TObject);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtGruCmpExit(Sender: TObject);
    procedure dbgDadosDBBandedTableViewMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure btnGeraTEClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtNumPcmKeyPress(Sender: TObject; var Key: Char);
    procedure edtEspPcmKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpPcmKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumNfeKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpNfeKeyPress(Sender: TObject; var Key: Char);
    procedure edtEspNfeKeyPress(Sender: TObject; var Key: Char);
    procedure btnSelCamposClick(Sender: TObject);
  private
    intRecIndex : Integer;
    CamposExportaEstoqueEmExcesso: TCamposExportaEstoqueEmExcesso;

    strUltGru : String;
    fltFiltro : TFiltrosRelatorio;

    arrLinGru,
    arrProduto,
    arrCodFor,
    arrMarca,
    arrEmpresa,
    arrGruCmp,
    arrPedCompra,
    arrNFEntrada : TConsultasArray;

    strCorZeb,
    strLinGru,
    strProduto,
    strCodFor,
    strMarca,
    strEmpresa,
    strGruCmp    : String;

    intWidth,
    intHeight: Integer;

    dtaIni,
    dtaFim : TDate;

    qryGirIte,
    qryMovFat,
    qryMovCom    : TUniQuery;

    qryEstoqu,
    qryRelatorio : TZClient;

    procedure pMostraResultado(blnMostraResultado : Boolean);
    procedure pSetParams(qryQuery : TUniQuery);

    function fGetSqlGirIte    : String;
    function fGetSqlMovDet    : String;
    function fGetSqlMovCompra : String;
    function fGetSqlEstoque   : String;
    function fGetSqlRelatorio : String;


    function fQtdMesesGiro : Integer;

    procedure pPreparaQuery(qry : TUniQuery);
    function fPreparaDados:Boolean;
    function fPreparaDadosProgresso(cxProgressbar : TcxProgressBar):Boolean;

    procedure pAddGrupoRelatorio(strCodIte, strGrupo, strDesGru : String; qryQueryP : TDataSet);
    procedure pPreparaQueryRelatorio;
    procedure pBuscaPedidoCompra(Key: Char);
    function fSQLPedCompra: String;
    function fSQLNFEntrada: String;
    procedure pBuscaNFEntrada(Key: Char);

  public
    { Public declarations }

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

implementation

uses SysUtils, Graphics, Forms, strUtils, DateUtils, untFuncoesConsulta,
     untConsultas, untConstantes, untGeraExcel, untGravando,
     untPreparaGeracaoTE, untTFatReservaSaldo;

{$R *.dfm}

procedure TfrmAnaliseEstoqueEmExcesso.btnExcelClick(Sender: TObject);
  Var
    objExcel : TGeraExcel;
    intIndex : Integer;
begin
  inherited;
  With fltFiltro Do
  Begin
    pLimpaFiltros;

    pIncluiFiltro('MESBAS', 'MÊS BASE PARA VENDAS/COMPRAS' + mskPeriodo.Text);
    pIncluiFiltro('LINGRU', fStrTitulo(mskLinGru.Text, edtDesGrupo, arrLinGru, strLinGru, 'LINHA/GRUPO') );
    pIncluiFiltro('CODFOR', fStrTitulo(edtCodFor.Text, edtNomFor, arrCodFor, strCodFor, 'FORNECEDOR') );
    pIncluiFiltro('CODMAR', fStrTitulo(edtCodMar.Text, edtDesMar, arrMarca, strMarca, 'MARCA') );
    pIncluiFiltro('CODITE', fStrTitulo(edtCodPro.Text, edtDesPro, arrProduto, strProduto, 'PRODUTO') );
    pIncluiFiltro('CODEMP', fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmpresa, strEmpresa, 'EMPRESA') );
    pIncluiFiltro('GRUCMP', fStrTitulo(edtGruCmp.Text, edtDesGruCmp, arrGruCmp, strGruCmp, 'GRUPO DE COMPRA') );


    pIncluiFiltro('PRECUS', 'COMPOSIÇÃO DO PREÇO DE CUSTO' + UpperCase(cmbComCus.Text));
    pIncluiFiltro('PREEST', 'OPÇÃO PARA PREÇO DE ESTOQUE: ' + UpperCase(cmbOpcPreEst.Text) );

    pIncluiFiltro('NIVELA', 'DIA DE DURAÇÂO DO ESTOQUE NIVEL A: ' + edtNivelA.Text );
    pIncluiFiltro('NIVELB', 'DIA DE DURAÇÂO DO ESTOQUE NIVEL B: ' + edtNivelB.Text );
    pIncluiFiltro('NIVELC', 'DIA DE DURAÇÂO DO ESTOQUE NIVEL C: ' + edtNivelC.Text );

    Case rdgOpcGir.ItemIndex Of
      0: pIncluiFiltro('OPCGIR', '3 MESES');
      1: pIncluiFiltro('OPCGIR', '6 MESES');
      2: pIncluiFiltro('OPCGIR', '12 MESES');
    End;

    if length(arrPedCompra) > 0 then
      pIncluiFiltro('PEDCOM','PRODUTOS DO PEDIDO DE COMPRA:' + IIF(length(arrPedCompra) = 1, (edtNumPcm.Text + '-' + edtEspPcm.Text + '-' + edtEmpPcm.Text), '+1') );

    if not fEmptyStr(fTiraCaracEspeciais(mskIniPcm.Text)) then
      pIncluiFiltro('PERCOM','PRODUTOS DO PEDIDO DE COMPRA NO PERÍODO: ' + mskIniPcm.Text + ' à ' + mskFinPcm.Text);

    if length(arrNFEntrada) > 0 then
      pIncluiFiltro('NFEENT','PRODUTOS DA NOTA FISCAL DE ENTRADA:' + IIF(length(arrNFEntrada) = 1, (edtNumNfe.Text + '-' + edtEspNfe.Text + '-' + edtEmpNfe.Text), '+1'));

    if not fEmptyStr(fTiraCaracEspeciais(mskIniNfe.Text)) then
      pIncluiFiltro('NFEPER','PRODUTOS DA NOTA FISCAL DE ENTRADA NO PERÍODO: ' + mskIniNfe.Text + ' à ' + mskFinNfe.Text);
  End;

  Try
    qryRelatorio.DisableControls;
    objExcel := TGeraExcel.Create(qryRelatorio, Nil);
    If cmbSintetico.ItemIndex = 4 Then
      objExcel.AddQuebra('CODITE', 'ITEM: ', True, 'CODITE');

  With objExcel, dbgDadosDBBandedTableView Do
  Begin
    pSetaFiltrosExcel(fltFiltro.arrFiltros);

    strNomRel := 'ANALISE DE ESTOQUE EM EXCESSO';

      For intIndex := 0 To ColumnCount -1 Do
      Begin
        If cmbSintetico.ItemIndex <> 4 Then
        Begin
          If Pos(Columns[intIndex].DataBinding.FieldName, '_SIGUNI_CODFAB_DIAEST_ITECODITE_ITEDESITE_') > 0 Then
            Continue;
        End;
        If (Not(Columns[intIndex].Visible)) and (Columns[intIndex].DataBinding.FieldName = 'CODITE') Then
          Continue;
        If CamposExportaEstoqueEmExcesso.CampoMarcado(Columns[intIndex].DataBinding.FieldName) Then
          AddCampo( Columns[intIndex].DataBinding.FieldName, Columns[intIndex].Caption  );
      End;

      if fGerarRelatorio Then
        pMensagemOk('Arquivo Gerado com Sucesso!');
    End;
  Finally
    qryRelatorio.EnableControls;
  End;

end;

procedure TfrmAnaliseEstoqueEmExcesso.btnExibirClick(Sender: TObject);
var i: integer;
begin
  inherited;
{}
  if not fVerificaCampos Then
    Exit;

  Try
    Screen.Cursor := crHourGlass;
    colGRUPO.Caption := UpperCase(cmbSintetico.Text);
    If cmbSintetico.ItemIndex = 4 Then
      colGRUPO.Caption := 'EMPRESA';

    if fPreparaDados Then
    Begin
      pPreparaQueryRelatorio;
      pMostraResultado(True);
    End
    Else
    Begin
      If (qryRelatorio.Active) And (qryRelatorio.RecordCount <= 0) Then
        fMensagem('', 'Não há dados para exibir!', ['&Ok']);
    End;
    btnGeraTE.Visible := cmbSintetico.ItemIndex = 4;

    CamposExportaEstoqueEmExcesso :=  TCamposExportaEstoqueEmExcesso.Create(strLoginUsuarioLogado, cmbSintetico.ItemIndex);
    For i := 0 To dbgDadosDBBandedTableView.ColumnCount -1 do
    Begin
      If dbgDadosDBBandedTableView.Columns[i].Visible Then
        CamposExportaEstoqueEmExcesso.pAddField(dbgDadosDBBandedTableView.Columns[i].DataBinding.FieldName,
                                                dbgDadosDBBandedTableView.Columns[i].Caption);
    End;


  Finally
    Screen.Cursor := crDefault;
  End;
end;

procedure TfrmAnaliseEstoqueEmExcesso.btnGeraTEClick(Sender: TObject);
  Var
    objPreparaGer: TPreparaGeracaoTE;
begin
  inherited;
  If Not btnGeraTE.Visible Then
    Exit;

  If Not fVerificaAcessoSistema('frmPreparaGerTE') Then
  Begin
    pMensagemOk('Usuário sem permissão para o módulo "Movimentação de Itens - ' +
                'Preparador para Geração de Transferência de Estoque"!');
    Exit;
  End;

  objPreparaGer := TPreparaGeracaoTE.Create;
  objPreparaGer.pInformaPreparacao(copy(qryRelatorio.FieldByName('CODITE').AsString, 0, fTamCodIte));

  FreeAndNil(objPreparaGer);

end;

procedure TfrmAnaliseEstoqueEmExcesso.btnSelCamposClick(Sender: TObject);
begin
  inherited;
  CamposExportaEstoqueEmExcesso.pSelecionaCampos;
end;

procedure TfrmAnaliseEstoqueEmExcesso.pPreparaQueryRelatorio;
Begin
  TFloatField(qryRelatorio.FieldByName('FATURA')).DisplayFormat := '#,##0.00';
  TFloatField(qryRelatorio.FieldByName('CUMVEN')).DisplayFormat := '#,##0.00';
  TFloatField(qryRelatorio.FieldByName('RESULT')).DisplayFormat := '#,##0.00';
  TFloatField(qryRelatorio.FieldByName('MARKUP')).DisplayFormat := '#,##0.00';
  TFloatField(qryRelatorio.FieldByName('MARGEM')).DisplayFormat := '#,##0.00';
  TFloatField(qryRelatorio.FieldByName('ESTBRU')).DisplayFormat := '#,##0.00';
  TFloatField(qryRelatorio.FieldByName('EXCESS')).DisplayFormat := '#,##0.00';
  TFloatField(qryRelatorio.FieldByName('SEMMOV')).DisplayFormat := '#,##0.00';
  TFloatField(qryRelatorio.FieldByName('ESTREA')).DisplayFormat := '#,##0.00';
  TFloatField(qryRelatorio.FieldByName('ESTOBJ')).DisplayFormat := '#,##0.00';
  TFloatField(qryRelatorio.FieldByName('ESTIDE')).DisplayFormat := '#,##0.00';
  TFloatField(qryRelatorio.FieldByName('CUSCOM')).DisplayFormat := '#,##0.00';
  TFloatField(qryRelatorio.FieldByName('COMEXC')).DisplayFormat := '#,##0.00';
  TFloatField(qryRelatorio.FieldByName('REPRES')).DisplayFormat := '#,##0.00';
  TFloatField(qryRelatorio.FieldByName('QTDFAT')).DisplayFormat := '#,##0.00';
  TFloatField(qryRelatorio.FieldByName('QTDEXC')).DisplayFormat := '#,##0.00';
  TFloatField(qryRelatorio.FieldByName('QTDSMO')).DisplayFormat := '#,##0.00';
  TFloatField(qryRelatorio.FieldByName('QTDOBJ')).DisplayFormat := '#,##0.00';
  TFloatField(qryRelatorio.FieldByName('QTDCOM')).DisplayFormat := '#,##0.00';
  TFloatField(qryRelatorio.FieldByName('EXCCOM')).DisplayFormat := '#,##0.00';

  dbgDadosDBBandedTableView.DataController.DataSource := qryRelatorio.dtsSource;

End;

procedure TfrmAnaliseEstoqueEmExcesso.btnVoltarClick(Sender: TObject);
begin
  inherited;
  pMostraResultado(False);
end;

procedure TfrmAnaliseEstoqueEmExcesso.dbgDadosDBBandedTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (intRecIndex = AViewInfo.GridRecord.RecordIndex) then
    ACanvas.Brush.Color := clGray
  Else
  If Odd(AViewInfo.GridRecord.Index) Then
  Begin
    ACanvas.Brush.Color := StrToIntDef(strCorZeb, clMoneyGreen);
    If AViewInfo.GridRecord.Selected Then
      ACanvas.Font.Color := clBlack;
  End;
end;

procedure TfrmAnaliseEstoqueEmExcesso.dbgDadosDBBandedTableViewMouseMove(
  Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  Site: TcxGridSite;
  HitTest: TcxCustomGridHitTest;
begin
  Site := Sender as TcxGridSite;
  HitTest := Site.GridView.ViewInfo.GetHitTest(X, Y);
  if HitTest is TcxGridRecordCellHitTest then
  begin
    intRecIndex := TcxGridRecordCellHitTest(HitTest).GridRecord.RecordIndex;
    Site.Repaint;
  end;
end;

procedure TfrmAnaliseEstoqueEmExcesso.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa,edtDesEmpresa,arrEmpresa,fRetNomeEmpresa,nil,'da Empresa');

end;

procedure TfrmAnaliseEstoqueEmExcesso.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa, False, True) Then
  Begin
    fvalidaCampos(edtCodEmpresa,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAnaliseEstoqueEmExcesso.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrCodFor, fRetNomFornecedor, nil, 'do Fornecedor');

end;

procedure TfrmAnaliseEstoqueEmExcesso.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrCodFor, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAnaliseEstoqueEmExcesso.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar,edtDesMar,arrMarca,fRetNomMarca,nil,'da Marca');

end;

procedure TfrmAnaliseEstoqueEmExcesso.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAnaliseEstoqueEmExcesso.edtCodProExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPro,edtDesPro,arrProduto,nil,fRetNomProduto,'do Produto');

end;

procedure TfrmAnaliseEstoqueEmExcesso.edtCodProKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtCodPro, edtDesPro, nil, Key, arrProduto, False, nil, 'Consulta de Itens', '1') Then
  Begin
    If fvalidaCampos(edtCodPro,True) Then
      self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAnaliseEstoqueEmExcesso.edtEmpNfeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  pBuscaNFEntrada(Key);
end;

procedure TfrmAnaliseEstoqueEmExcesso.edtEmpPcmKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  pBuscaPedidoCompra(Key);
end;

procedure TfrmAnaliseEstoqueEmExcesso.edtEspNfeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  pBuscaNFEntrada(Key);
end;

procedure TfrmAnaliseEstoqueEmExcesso.edtEspPcmKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  pBuscaPedidoCompra(Key);
end;

procedure TfrmAnaliseEstoqueEmExcesso.edtGruCmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtGruCmp, edtDesGruCmp, arrGruCmp, Nil, fRetDescGrupoCompra, 'do Grupo de Compra');
end;

procedure TfrmAnaliseEstoqueEmExcesso.edtGruCmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupoCompra(Self, edtGruCmp, edtDesGruCmp, Nil, Key, arrGruCmp, False) Then
  Begin
    If fValidaCampos(edtGruCmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAnaliseEstoqueEmExcesso.edtNumNfeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  pBuscaNFEntrada(Key);
end;

procedure TfrmAnaliseEstoqueEmExcesso.edtNumPcmKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  pBuscaPedidoCompra(Key);
end;

procedure TfrmAnaliseEstoqueEmExcesso.pBuscaPedidoCompra(Key : Char);
var
  qryPcmGer : TUniQuery;
  strDoc    : String;
begin

  If fPesqPedidoCompra(Self, nil, nil, Key , arrPedcompra, strDoc, '', 0 , False) Then
  Begin

      if Length(arrPedCompra) = 1 then
      begin
        qryPcmGer := fCriaQuery(nil);
        try
          qryPcmGer.SQL.Add('SELECT                                                          ');
          qryPcmGer.SQL.Add('  PCG_NUMPED,                                                   ');
          qryPcmGer.SQL.Add('  PCG_ESPDOC,                                                   ');
          qryPcmGer.SQL.Add('  PCG_CODEMP                                                    ');
          qryPcmGer.SQL.Add('FROM                                                            ');
          qryPcmGer.SQL.Add('  PCMGER                                                        ');
          qryPcmGer.SQL.Add('WHERE                                                           ');
          qryPcmGer.SQL.Add('  AUTOINCREM IN ('+   fArrCodigosToLista('', arrPedCompra) + ') ');
          qryPcmGer.Open;

          edtNumPcm.Text := qryPcmGer.FieldByName('PCG_NUMPED').AsString;
          edtEspPcm.Text := qryPcmGer.FieldByName('PCG_ESPDOC').AsString;
          edtEmpPcm.Text := qryPcmGer.FieldByName('PCG_CODEMP').AsString;

          blnMudarFoco := False;
          pSetFocus(mskIniPcm);
        finally
          FreeAndNil(qryPcmGer);
        end;

      end
      else
      begin

        edtNumPcm.Text := '000000000000';
        edtEspPcm.Text := '00';
        edtEmpPcm.Text := '000';

        pSetFocus(mskIniPcm);
      end;

  End;

end;


procedure TfrmAnaliseEstoqueEmExcesso.pBuscaNFEntrada(Key : Char);
var
  qryMovGer : TUniQuery;
begin

  If fPesqNFEntrada(Self, nil, nil, Key , arrNFEntrada, False) Then
  Begin

      if Length(arrNFEntrada) = 1 then
      begin
        qryMovGer := fCriaQuery(nil);
        try
          qryMovGer.SQL.Add('SELECT                                                          ');
          qryMovGer.SQL.Add('  GER_NUMDOC,                                                   ');
          qryMovGer.SQL.Add('  GER_ESPDOC,                                                   ');
          qryMovGer.SQL.Add('  GER_CODEMP                                                    ');
          qryMovGer.SQL.Add('FROM                                                            ');
          qryMovGer.SQL.Add('  MOVGER                                                        ');
          qryMovGer.SQL.Add('WHERE                                                           ');
          qryMovGer.SQL.Add('  AUTOINCREM IN ('+   fArrCodigosToLista('', arrNFEntrada) + ') ');
          qryMovGer.Open;

          edtNumNfe.Text := qryMovGer.FieldByName('GER_NUMDOC').AsString;
          edtEspNfe.Text := qryMovGer.FieldByName('GER_ESPDOC').AsString;
          edtEmpNfe.Text := qryMovGer.FieldByName('GER_CODEMP').AsString;

          blnMudarFoco := False;
          pSetFocus(mskIniNfe);
        finally
          FreeAndNil(qryMovGer);
        end;

      end
      else
      begin

        edtNumNfe.Text := '000000000000';
        edtEspNfe.Text := '00';
        edtEmpNfe.Text := '000';

        pSetFocus(mskIniNfe);
      end;

  End;

end;


function TfrmAnaliseEstoqueEmExcesso.fGetSqlEstoque: String;
  Var
    strSaldos: String;

  function fRetPrecoEstoque : String;
  Begin
    Case cmbOpcPreEst.ItemIndex Of
      0: Result := Result + IIF((Length(arrEmpresa) > 1) or fEmptyStr(edtCodEmpresa.Text), 'GP.', 'G.') + 'ITE_PRECUS ';
      1: Result := Result + IIF((Length(arrEmpresa) > 1) or fEmptyStr(edtCodEmpresa.Text), 'GP.', 'G.') + 'ITE_PREULT ';
      2: Result := Result + IIF((Length(arrEmpresa) > 1) or fEmptyStr(edtCodEmpresa.Text), 'GP.', 'G.') + 'ITE_IMPULT ';
      3: Result := Result + IIF((Length(arrEmpresa) > 1) or fEmptyStr(edtCodEmpresa.Text), 'GP.', 'G.') + 'ITE_PREMED ';
    End;
  End;

begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE ';

  Case cmbSintetico.ItemIndex Of
    0 : Result := Result + ' CONCAT(LEFT(ITE_CODGRU,3), "000") AS GRUPO, ' ;
    1 : Result := Result + ' ITE_CODGRU AS GRUPO, ';
    2 : Result := Result + ' ITE_CODFOR AS GRUPO, ';
    3 : Result := Result + ' ITE_CODMAR AS GRUPO, ';
    4 : Result := Result + ' G.ITE_CODEMP AS GRUPO, ';
  End;

  Case cmbSintetico.ItemIndex Of
    0 : Result := Result + ' GRU_DESGRU AS DESGRU, ';
    1 : Result := Result + ' GRU_DESGRU AS DESGRU, ';
    2 : Result := Result + ' FOR_NOMFOR AS DESGRU, ';
    3 : Result := Result + ' MAR_DESMAR AS DESGRU, ';
    4 : Result := Result + ' EMP_NOMEMP AS DESGRU, ';
  End;

  If cmbSintetico.ItemIndex = 4 Then
  Begin
    Result := Result + ' UNI_SIGUNI AS SIGUNI, ';
    Result := Result + ' ITE_CODFAB AS CODFAB, ';
    Result := Result + ' G.ITE_CODEMP AS CODEMP, ';
    Result := Result + ' CONCAT(G.ITE_CODITE, " - ", I.ITE_DESITE) AS CODITE, ';
    Result := Result + ' I.ITE_CODITE AS ITECODITE, ';
    Result := Result + ' I.ITE_DESITE AS ITEDESITE, ';
  End
  Else
    Result := Result + ' G.ITE_CODEMP AS CODEMP, ';

  Result := Result + ' 0000000000.000 AS QTDGIR, ';
  Result := Result + ' 0000000000.000 AS EXCESS, ';
  Result := Result + ' 0000000000.000 AS SEMMOV, ';
  Result := Result + ' 0000000000.000 AS QTDSMO, ';
  Result := Result + ' 0000000000.000 AS QTDEXC, ';

  Result := Result + '        G.ITE_CODITE,';
  Result := Result + '        I.ITE_NVLGIR,';
  Result := Result + ' COUNT(0) AS QTDITE, ';

  strSaldos := ' G.ITE_SALDOS + IF( ITE_CNV_ML > 0, G.ITE_SAL_ML / ITE_CNV_ML, 0 )';

  Result := Result + strSaldos + '       AS SALDOS, ';
  Result := Result + fRetPrecoEstoque + 'AS PREEST, ';

  Result := Result + 'SUM(' + fRetPrecoEstoque + ' * (' + strSaldos + ')) AS ESTBRU,  ';

  // SALDOS - PEDIDOS EM ABERTO - GARANTIAS EM ABERTO (ESTOQUE RUIM)
  Result := Result + 'SUM(((' + strSaldos + ')' ;

  Result := Result + ' - IFNULL((SELECT ';
  Result := Result + '      SUM(FDO_QTDITE - FDO_QTDBAI) ';
  Result := Result + '    FROM ';
  Result := Result + '      FATDOR ';
  Result := Result + '    INNER JOIN FATGOR ON ';
  Result := Result + '      FDO_ESPDOC = FGO_ESPDOC AND ';
  Result := Result + '      FDO_NUMDOC = FGO_NUMDOC AND ';
  Result := Result + '      FDO_CODEMP = FGO_CODEMP     ';
  Result := Result + '    WHERE FATDOR.FDO_ESPDOC = "PD"         ';
  Result := Result + '      AND FATDOR.FDO_JAFATU = 0            ';
  Result := Result + '      AND FATDOR.FDO_CODITE = G.ITE_CODITE ';
  Result := Result + '      AND FATGOR.FGO_CODEMP = G.ITE_CODEMP ';
  Result := Result + '    GROUP BY ';
  Result := Result + '      FDO_CODITE), 0) - ';

  Result := Result + 'IFNULL(( SELECT SUM(COALESCE(GAD_QTDREQ,0) - IFNULL((SELECT SUM(GAE_QTDENV) FROM MOVGAE WHERE GAE_SEQGAD = D.AUTOINCREM ),0) )  ';
  Result := Result + '  FROM   MOVGAG G INNER JOIN MOVGAD D ON G.AUTOINCREM = D.GAD_SEQGAG ';
  Result := Result + '  WHERE GAD_CODITE = G.ITE_CODITE ';
  Result := Result + '    AND GAG_CODEMP = G.ITE_CODEMP ';
  Result := Result + 'GROUP BY GAD_CODITE ';
  Result := Result + ' ),0 )) *  ' + fRetPrecoEstoque + ') AS ESTREA ';

  Result := Result + ' FROM ITEGER G       ';
  Result := Result + ' INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ';

  //FILTRA OS ITENS ESPECÍFICOS DE UM PEDIDO DE COMPRA
  if (Length(arrPedCompra) > 0) or (not fEmptyStr(fTiraCaracEspeciais(mskIniPcm.Text))) then
    Result := Result + ' INNER JOIN (' + fSQLPedCompra +') P ON PCD_CODITE = G.ITE_CODITE ';

  //FILTRA OS ITENS ESPECÍFICOS DE UMA NF DE ENTRADA
  if (Length(arrNFEntrada) > 0) or (not fEmptyStr(fTiraCaracEspeciais(mskIniNfe.Text))) then
    Result := Result + ' INNER JOIN (' + fSQLNFEntrada +') D ON D.DET_CODITE = G.ITE_CODITE ';

  {*************************************************}
  {* COMO É MULT SELEÇÃO E TAMBEM PODE PASSAR A   **}
  {* EMPRESA EM BRANCO, QUANDO O USUARIO NÃO       *}
  {* INFORMAR EMPRESA,CONSIDERA PARA O PREÇO DO EST.}
  {* OS PREÇOS DA EMPRESA LOGADA, CASO SELECIONOU  *}
  {* MAIS DE UMA EMPRESA CONSIDERA A PRIMEIRA      *}
  {**********************************************GB*}
  if (Length(arrEmpresa) > 1) Then
    Result := Result + ' INNER JOIN ITEGER GP ON GP.ITE_CODITE = G.ITE_CODITE AND GP.ITE_CODEMP = ' + QuotedStr(arrEmpresa[0].strCodigo)
  Else
  If fEmptyStr(edtCodEmpresa.Text) Then
    Result := Result + ' INNER JOIN ITEGER GP ON GP.ITE_CODITE = G.ITE_CODITE AND GP.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  Case cmbSintetico.ItemIndex Of
    0 : Result := Result + ' LEFT JOIN CADGRU ON GRU_CODGRU = CONCAT(LEFT(ITE_CODGRU,3), "000") ';
    1 : Result := Result + ' LEFT JOIN CADGRU ON GRU_CODGRU = ITE_CODGRU                        ';
    2 : Result := Result + ' LEFT JOIN CADFOR ON FOR_CODFOR = ITE_CODFOR                        ';
    3 : Result := Result + ' LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR                        ';
    4 : begin
          Result := Result + ' LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
          Result := Result + ' LEFT JOIN CADEMP ON EMP_CODEMP = G.ITE_CODEMP ';
        end;
  End;

  Result := Result + ' WHERE TRUE          ';
  Result := Result + fStrLocateLinGru(mskLinGru, arrLinGru, 'I.ITE_CODGRU', 'CODGRU');
  Result := Result + fStrLocate(edtCodFor, arrCodFor, 'I.ITE_CODFOR', 'CODFOR');
  Result := Result + fStrLocate(edtCodMar, arrMarca, 'I.ITE_CODMAR', 'CODMAR');
  Result := Result + fStrLocate(edtCodPro, arrProduto, 'G.ITE_CODITE', 'CODITE');
  Result := Result + fStrLocate(edtCodEmpresa, arrEmpresa, 'G.ITE_CODEMP', 'CODEMP');
  Result := Result + fStrLocate(edtGruCmp, arrGruCmp, 'I.ITE_GRUCMP', 'GRUCMP');

  Result := Result + 'GROUP BY G.ITE_CODEMP, G.ITE_CODITE ';


  If cmbSintetico.ItemIndex = 4 Then
    Result := Result + 'ORDER BY G.ITE_CODITE, G.ITE_CODEMP'
  Else
    Result := Result + 'ORDER BY GRUPO ';
end;

function TfrmAnaliseEstoqueEmExcesso.fQtdMesesGiro : Integer;
Begin
  Result := -1;
  Case rdgOpcGir.ItemIndex Of
    0: Result := 3;
    1: Result := 6;
    2: Result := 12;
  End;

End;

function TfrmAnaliseEstoqueEmExcesso.fGetSqlGirIte: String;

  function fQtdTabelasGiro : Integer;
    Var
      intAno,
      intIndex : Integer;
      dtaAux   : TDate;
  Begin
    Result := 1;
    dtaAux := dtaIni;
    intAno := YearOf(dtaAux);

    dtaAux := IncMonth(dtaAux, -1);
    if intAno <> YearOf(dtaAux) Then
      Exit;

    For intIndex := 2 To fQtdMesesGiro Do
    Begin
      dtaAux := IncMonth(dtaAux, -1);
      if intAno <> YearOf(dtaAux) Then
      Begin
        Inc(Result);
        Break;
      End;
    End;

  End;

  Var
    intIndex : Integer;
    intQtdCam: Integer;
    intAno   : Integer;
    intMes   : Integer;
    dtaAux   : TDate;
    strSql   : String;
begin
  intQtdCam := 0;
  dtaAux := dtaIni;
  dtaAux := IncMonth(dtaAux, -1);


  Result := '';
  For intIndex := 0 to fQtdTabelasGiro -1 Do
  Begin
    intAno := YearOf(dtaAux);
    Result := Result + ' SELECT SQL_NO_CACHE ';
    Result := Result + '        GIR_CODITE,  ';
    Result := Result + '        GIR_CODEMP,  ';
    Result := Result + '        SUM(         ';
    While ((intAno = YearOf(dtaAux)) And (intQtdCam < fQtdMesesGiro) ) Do
    Begin
      intMes := MonthOf(dtaAux);

      Result := Result + 'IFNULL(GIR_QSAI' + fStrZero(intToStr(intMes),2)+ ', 0)';

      Inc(intQtdCam);
      dtaAux := IncMonth(dtaAux, -1);

      if ((intAno = YearOf(dtaAux)) And (intQtdCam < fQtdMesesGiro)) Then
        Result := Result + ' + ' ;
    End;
    Result := Result + '   ) AS QTDGIR ';
    Result := Result + '  FROM GIRITE ';

    Result := Result + '  INNER JOIN CADITE ON ITE_CODITE = GIR_CODITE ';

    //FILTRA OS ITENS ESPECÍFICOS DE UM PEDIDO DE COMPRA
    if (Length(arrPedCompra) > 0) or (not fEmptyStr(fTiraCaracEspeciais(mskIniPcm.Text))) then
      Result := Result + ' INNER JOIN (' + fSQLPedCompra +') P ON PCD_CODITE = ITE_CODITE ';

    //FILTRA OS ITENS ESPECÍFICOS DE UMA NF DE ENTRADA
    if (Length(arrNFEntrada) > 0) or (not fEmptyStr(fTiraCaracEspeciais(mskIniNfe.Text))) then
      Result := Result + ' INNER JOIN (' + fSQLNFEntrada +') D ON D.DET_CODITE = ITE_CODITE ';

    Result := Result + '  WHERE GIR_A_N_O_ = ' + IntToStr( intAno ) ;
    Result := Result + fStrLocate(edtCodPro, arrProduto,      'GIR_CODITE', 'CODITE');
    Result := Result + fStrLocate(edtCodEmpresa, arrEmpresa,  'GIR_CODEMP', 'CODEMP');
    Result := Result + fStrLocateLinGru(mskLinGru, arrLinGru, 'ITE_CODGRU', 'CODGRU');
    Result := Result + fStrLocate(edtCodFor, arrCodFor,       'ITE_CODFOR', 'CODFOR');
    Result := Result + fStrLocate(edtCodMar, arrMarca,        'ITE_CODMAR', 'CODMAR');
    Result := Result + fStrLocate(edtGruCmp, arrGruCmp,    'ITE_GRUCMP', 'GRUCMP');

    Result := Result + ' GROUP BY GIR_CODITE, GIR_CODEMP  ';

    if intIndex < fQtdTabelasGiro-1 Then
      Result := Result + ' UNION ALL ';

  End;

  if Pos('UNION ALL', Result) > 0 Then
  Begin
    strSql := strSql + ' SELECT SQL_NO_CACHE             ';
    strSql := strSql + '        GIR_CODITE,              ';
    strSql := strSql + '        GIR_CODEMP,              ';
    strSql := strSql + '        SUM(QTDGIR) AS QTDGIR    ';
    strSql := strSql + ' FROM ( ' + Result + ' ) AS GIRO ';
    strSql := strSql + ' GROUP BY GIR_CODITE, GIR_CODEMP ';
    Result := strSql;

  End;

end;

procedure TfrmAnaliseEstoqueEmExcesso.pSetParams(qryQuery : TUniQuery);
begin
  With qryQuery Do
  Begin

    if (FindParam('DTAINI') <> Nil)     then ParamByName('DTAINI').AsDate     := dtaIni;
    if (FindParam('DTAFIN') <> Nil)     then ParamByName('DTAFIN').AsDate     := dtaFim;
    if (FindParam('CLACOM') <> Nil)     then ParamByName('CLACOM').AsString   := VS_strClaCom;
    if (FindParam('CLAFIS') <> Nil)     then ParamByName('CLAFIS').AsString   := VS_strClaVen;
    if (FindParam('CLADEV') <> Nil)     then ParamByName('CLADEV').AsString   := VS_strClaDev;
    if (FindParam('PCGENT_INI') <> Nil) then ParamByName('PCGENT_INI').AsDate := strToDate(mskIniPcm.Text);
    if (FindParam('PCGENT_FIN') <> Nil) then ParamByName('PCGENT_FIN').AsDate := strToDate(mskFinPcm.Text);
    if (FindParam('NFEINI') <> Nil)     then ParamByName('NFEINI').AsDate     := strToDate(mskIniPcm.Text);
    if (FindParam('NFEFIN') <> Nil)     then ParamByName('NFEFIN').AsDate     := strToDate(mskFinPcm.Text);

    pSetaParam(mskLinGru.Text,     arrLinGru,  strLinGru,  'CODGRU', qryQuery );
    pSetaParam(edtCodFor.Text,     arrCodFor,  strCodFor,  'CODFOR', qryQuery );
    pSetaParam(edtCodMar.Text,     arrMarca,   strMarca,   'CODMAR', qryQuery );
    pSetaParam(edtCodPro.Text,     arrProduto, strProduto, 'CODITE', qryQuery );
    pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', qryQuery );
    pSetaParam(edtGruCmp.Text,     arrGruCmp,  strGruCmp,  'GRUCMP', qryQuery );



  End;

end;


function TfrmAnaliseEstoqueEmExcesso.fGetSqlMovCompra: String;
  Var
    strCusTmp : String;
begin
  strCusTmp := '  IFNULL(' + fRetornaComposicao(cmbComCus.Items.Strings[cmbComCus.ItemIndex]) + ',0) ';

  Result := '';
  Result := Result + '  SELECT SQL_NO_CACHE                                  ';

  Case cmbSintetico.ItemIndex Of
    0 : Result := Result + ' CONCAT(LEFT(ITE_CODGRU,3), "000") AS GRUPO, ' ;
    1 : Result := Result + ' ITE_CODGRU AS GRUPO, ';
    2 : Result := Result + ' ITE_CODFOR AS GRUPO, ';
    3 : Result := Result + ' ITE_CODMAR AS GRUPO, ';
    4 : Result := Result + ' DET_CODEMP AS GRUPO, ';
  End;

  Case cmbSintetico.ItemIndex Of
    0 : Result := Result + ' GRU_DESGRU AS DESGRU, ';
    1 : Result := Result + ' GRU_DESGRU AS DESGRU, ';
    2 : Result := Result + ' FOR_NOMFOR AS DESGRU, ';
    3 : Result := Result + ' MAR_DESMAR AS DESGRU, ';
    4 : Result := Result + ' EMP_NOMEMP AS DESGRU, ';
  End;

  If cmbSintetico.ItemIndex = 4 Then
  Begin
    Result := Result + ' UNI_SIGUNI AS SIGUNI, ';
    Result := Result + ' ITE_CODFAB AS CODFAB, ';
    Result := Result + ' DET_CODEMP AS CODEMP, ';
    Result := Result + ' CONCAT(DET_CODITE, " - ", ITE_DESITE) AS CODITE, ';
    Result := Result + ' DET_CODITE AS ITECODITE, ';
    Result := Result + ' ITE_DESITE AS ITEDESITE, ';
  End;
  Result := Result + ' SUM( DET_QTDITE) AS QTDCOM, ';

  Result := Result + '         SUM(' + strCusTmp + ' * DET_QTDITE) AS CUSCOM ';
  Result := Result + ' FROM MOVDET D                  ';
  Result := Result + ' INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = D.AUTOINCREM ';
  Result := Result + ' LEFT  JOIN MOVICD ON        ICD_SEQGER = D.AUTOINCREM AND D.DET_VALRET = 0 ';

  Result := Result + '  INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ';

  //FILTRA OS ITENS ESPECÍFICOS DE UM PEDIDO DE COMPRA
  if (Length(arrPedCompra) > 0) or (not fEmptyStr(fTiraCaracEspeciais(mskIniPcm.Text))) then
    Result := Result + ' INNER JOIN (' + fSQLPedCompra +') P ON PCD_CODITE = D.DET_CODITE ';


  Case cmbSintetico.ItemIndex Of
    0 : Result := Result + ' LEFT JOIN CADGRU ON GRU_CODGRU = CONCAT(LEFT(ITE_CODGRU,3), "000") ';
    1 : Result := Result + ' LEFT JOIN CADGRU ON GRU_CODGRU = ITE_CODGRU                        ';
    2 : Result := Result + ' LEFT JOIN CADFOR ON FOR_CODFOR = ITE_CODFOR                        ';
    3 : Result := Result + ' LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR                        ';
    4 : begin
          Result := Result + ' LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
          Result := Result + ' LEFT JOIN CADEMP ON EMP_CODEMP = DET_CODEMP ';
        end;
  End;

  Result := Result + ' WHERE DET_TIP_FC = "F"                                ';
  Result := Result + '  AND DET_DTAENT BETWEEN :DTAINI AND :DTAFIN           ';
  Result := Result + '  AND DET_PROEMB <> "S"                                ';
  Result := Result + '  AND LOCATE(DET_CLAFIS, :CLACOM) > 0                  ';

  Result := Result + fStrLocateLinGru(mskLinGru, arrLinGru, 'ITE_CODGRU'  , 'CODGRU');
  Result := Result + fStrLocate(edtCodFor, arrCodFor,       'ITE_CODFOR'  , 'CODFOR');
  Result := Result + fStrLocate(edtCodMar, arrMarca,        'ITE_CODMAR'  , 'CODMAR');
  Result := Result + fStrLocate(edtCodPro, arrProduto,      'D.DET_CODITE', 'CODITE');
  Result := Result + fStrLocate(edtCodEmpresa, arrEmpresa,  'D.DET_CODEMP', 'CODEMP');
  Result := Result + fStrLocate(edtGruCmp, arrGruCmp,       'ITE_GRUCMP'  , 'GRUCMP');


  if Length(arrNFEntrada) > 0 then
    Result := Result + ' AND D.DET_SEQGER IN ('+   fArrCodigosToLista('', arrNFEntrada) + ') ';

  if (not fEmptyStr(fTiraCaracEspeciais(mskIniPcm.Text))) then
    Result := Result + ' AND D.DET_DTAENT BETWEEN :NFEINI AND :NFEFIN ';

  Result := Result + 'GROUP BY ';
  Case cmbSintetico.ItemIndex Of
    0 : Result := Result + ' CONCAT(LEFT(ITE_CODGRU,3), "000") ' ;
    1 : Result := Result + ' ITE_CODGRU ';
    2 : Result := Result + ' ITE_CODFOR ';
    3 : Result := Result + ' ITE_CODMAR ';
    4 : Result := Result + ' DET_CODEMP, ITE_CODITE ';
  End;

  Result := Result + 'ORDER BY DET_CODEMP, ITE_CODITE '
end;

function TfrmAnaliseEstoqueEmExcesso.fGetSqlMovDet: String;

  function fRetClientesFilialLocal: String;
    Var
      intContador: Integer;
      strSQL     : String;
      qryGenerica: TUniQuery;

  Begin
    qryGenerica := fCriaQuery;

    Result := '';

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  EMP_CLIFIL ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';

    With qryGenerica Do
    Begin
      CLose;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      For intContador := 0 To RecordCount -1 Do
      Begin

        If Not fEmptyStr( FieldByName('EMP_CLIFIL').AsString ) Then
          Result := Result + ' AND DET_CODCLI <> ' + QuotedStr(FieldByName('EMP_CLIFIL').AsString);

        Next;
      End;

      Close;
    End;

    FreeAndNil(qryGenerica);

    If (fEmptyStr(Result)) Then
      Result := '';
  end;

  Var
    strCusTmp : String;
begin
  strCusTmp := '  IFNULL(' + fRetornaComposicao(cmbComCus.Items.Strings[cmbComCus.ItemIndex]) + ',0) ';

  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE           ';

  Case cmbSintetico.ItemIndex Of
    0 : Result := Result + ' CONCAT(LEFT(ITE_CODGRU,3), "000") AS GRUPO, ' ;
    1 : Result := Result + ' ITE_CODGRU AS GRUPO, ';
    2 : Result := Result + ' ITE_CODFOR AS GRUPO, ';
    3 : Result := Result + ' ITE_CODMAR AS GRUPO, ';
    4 : Result := Result + ' DET_CODEMP AS GRUPO, ';
  End;

  Case cmbSintetico.ItemIndex Of
    0,
    1 : Begin
          Result := Result + ' GRU_DESGRU AS DESGRU, ';
          colDESGRU.Caption := 'DESC. GRUPO.'
        End;
    2 : Begin
          Result := Result + ' FOR_NOMFOR AS DESGRU, ';
          colDESGRU.Caption := 'NOME FORN.'
        End;
    3 : Begin
          Result := Result + ' MAR_DESMAR AS DESGRU, ';
          colDESGRU.Caption := 'DESC. MARCA'
        End;
    4 : Begin
          Result := Result + ' EMP_NOMEMP AS DESGRU, ';
          colDESGRU.Caption := 'NOM. EMPRESA'
        End;
  End;

  If cmbSintetico.ItemIndex = 4 Then
  Begin
    Result := Result + ' UNI_SIGUNI AS SIGUNI, ';
    Result := Result + ' ITE_CODFAB AS CODFAB, ';
    Result := Result + ' CONCAT(DET_CODITE, " - ", ITE_DESITE) AS CODITE, ';
    Result := Result + ' DET_CODEMP AS CODEMP, ';
    Result := Result + ' DET_CODITE AS ITECODITE, ';
    Result := Result + ' ITE_DESITE AS ITEDESITE, ';
  End;

  Result := Result + '  SUM(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -1, 1) * ' + strCusTmp + ')) AS TOTCUS, ';
  Result := Result + '  SUM(IF((D.DET_ESPDOC = "BR") OR LOCATE(D.DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(D.DET_CLAFIS,1) < 5, -(D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF), D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF))) AS TOTITE, ';
  Result := Result + '  SUM(IF((D.DET_ESPDOC = "BR") OR LOCATE(D.DET_CLAFIS,' +  CLAFIS_BR + '), 0.00, IF(LEFT(D.DET_CLAFIS, 1) < 5, - D.DET_QTDITE, D.DET_QTDITE))) AS QTDFAT ';
  Result := Result + ' FROM MOVDET D                  ';

  Result := Result + ' INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = D.AUTOINCREM ';
  Result := Result + ' LEFT  JOIN MOVICD ON        ICD_SEQGER = D.AUTOINCREM AND D.DET_VALRET = 0 ';

  Result := Result + '  INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE ';

  //FILTRA OS ITENS ESPECÍFICOS DE UM PEDIDO DE COMPRA
    if (Length(arrPedCompra) > 0) or (not fEmptyStr(fTiraCaracEspeciais(mskIniPcm.Text))) then
      Result := Result + ' INNER JOIN (' + fSQLPedCompra +') P ON PCD_CODITE = D.DET_CODITE ';

  Case cmbSintetico.ItemIndex Of
    0 : Result := Result + ' LEFT JOIN CADGRU ON GRU_CODGRU = CONCAT(LEFT(ITE_CODGRU,3), "000") ';
    1 : Result := Result + ' LEFT JOIN CADGRU ON GRU_CODGRU = ITE_CODGRU                        ';
    2 : Result := Result + ' LEFT JOIN CADFOR ON FOR_CODFOR = ITE_CODFOR                        ';
    3 : Result := Result + ' LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR                        ';
    4 : Begin
          Result := Result + ' LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
          Result := Result + ' LEFT JOIN CADEMP ON EMP_CODEMP = DET_CODEMP ';
        End;
  End;

  Result := Result + ' WHERE ';
  Result := Result + cnsFiltroFFDVTR;
  Result := Result + '       D.DET_PROEMB <> "S"  ';
  Result := Result + '   AND D.DET_TIP_FC = "C"  ';
  Result := Result + fRetClientesFilialLocal;
  Result := Result + '   AND D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN   ';
  Result := Result + '   AND ((LOCATE(D.DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(D.DET_CLAFIS, :CLADEV) > 0)';

  If fCfgSis('ENTBRF', varBoolean) Then
    Result := Result + ' OR (D.DET_ESPDOC = "BR") OR LOCATE(D.DET_CLAFIS,' + CLAFIS_BR + ')) '
  Else
    Result := Result + ') ';

  Result := Result + fStrLocateLinGru(mskLinGru, arrLinGru, 'ITE_CODGRU'  , 'CODGRU');
  Result := Result + fStrLocate(edtCodFor, arrCodFor,       'ITE_CODFOR'  , 'CODFOR');
  Result := Result + fStrLocate(edtCodMar, arrMarca,        'ITE_CODMAR'  , 'CODMAR');
  Result := Result + fStrLocate(edtCodPro, arrProduto,      'D.DET_CODITE', 'CODITE');
  Result := Result + fStrLocate(edtCodEmpresa, arrEmpresa,  'D.DET_CODEMP', 'CODEMP');
  Result := Result + fStrLocate(edtGruCmp, arrGruCmp,    'ITE_GRUCMP'  , 'GRUCMP');

  if Length(arrNFEntrada) > 0 then
    Result := Result + ' AND D.DET_SEQGER IN ('+   fArrCodigosToLista('', arrNFEntrada) + ') ';

  if (not fEmptyStr(fTiraCaracEspeciais(mskIniPcm.Text))) then
    Result := Result + ' AND D.DET_DTAENT BETWEEN :NFEINI AND :NFEFIN ';

  Result := Result + 'GROUP BY ';
  Case cmbSintetico.ItemIndex Of
    0 : Result := Result + ' CONCAT(LEFT(ITE_CODGRU,3), "000") ' ;
    1 : Result := Result + ' ITE_CODGRU ';
    2 : Result := Result + ' ITE_CODFOR ';
    3 : Result := Result + ' ITE_CODMAR ';
    4 : Result := Result + ' DET_CODEMP, ITE_CODITE  ';
  End;
  
  Result := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(Result,['D.']);

  Result := ' SELECT SQL_NO_CACHE                 ' +
            '        GRUPO,                       ' +
            '        DESGRU,                      ' +
            IfThen(cmbSintetico.ItemIndex = 4, ' SIGUNI, CODFAB, CODITE, CODEMP, ITECODITE , ITEDESITE, ', '') +
            '        SUM(TOTCUS) AS TOTCUS,       ' +
            '        SUM(TOTITE) AS TOTITE,       ' +
            '        SUM(QTDFAT) AS QTDFAT        ' +

            ' FROM ( ' + Result + ') AS fGetSqlMovDet GROUP BY ';
  If cmbSintetico.ItemIndex = 4 Then
    Result := Result + ' CODITE, ';
  Result := Result + 'GRUPO ';
  Result := Result + ' ORDER BY ';
  If cmbSintetico.ItemIndex = 4 Then
    Result := Result + ' CODITE, ';
  Result := Result + 'GRUPO ';
end;

function TfrmAnaliseEstoqueEmExcesso.fGetSqlRelatorio: String;
begin
  Result := '';

  Result := Result + ' SELECT SQL_NO_CACHE                             ';
  Result := Result + '        CONVERT(EMP_CODEMP , CHAR(10)) AS GRUPO,';
  Result := Result + '        CONVERT(EMP_CODEMP , CHAR(50)) AS DESGRU,';

  Result := Result + '        CONVERT(EMP_CODEMP , CHAR(04)) AS SIGUNI,';
  Result := Result + '        CONVERT(EMP_CODEMP , CHAR(50)) AS CODFAB,';
  Result := Result + '        000.000                        AS DIAEST,';

  Result := Result + '        0000000000.000 AS QTDITE,                ';
  Result := Result + '        0000000000.000 AS FATURA,                ';
  Result := Result + '        0000000000.000 AS CUMVEN,                ';
  Result := Result + '        0000000000.000 AS RESULT,                ';
  Result := Result + '        000.000        AS MARKUP,                ';
  Result := Result + '        000.000        AS MARGEM,                ';
  Result := Result + '        0000000000.000 AS ESTBRU,                ';
  Result := Result + '        0000000000.000 AS EXCESS,                ';
  Result := Result + '        0000000000.000 AS SEMMOV,                ';
  Result := Result + '        0000000000.000 AS ESTREA,                ';
  Result := Result + '        0000000000.000 AS ESTOBJ,                ';
  Result := Result + '        0000000000.000 AS ESTIDE,                ';
  Result := Result + '        0000000000.000 AS CUSCOM,                ';
  Result := Result + '        0000000000.000 AS COMEXC,                ';
  Result := Result + '        000.000        AS REPRES,                ';
  Result := Result + '        0000000000.000 AS QTDSMO,                ';
  Result := Result + '        EMP_CODEMP AS CODEMP,                    ';
  Result := Result + '        0000000000.000 AS QTDFAT,                ';
  Result := Result + '        0000000000.000 AS QTDEXC,                ';
  Result := Result + '        0000000000.000 AS QTDCOM,                ';
  Result := Result + '        0000000000.000 AS QTDOBJ,                ';
  Result := Result + '        0000000000.000 AS EXCCOM,                ';
  Result := Result + '       CONVERT(EMP_CODEMP , CHAR(75)) AS CODITE, ';

  Result := Result + '       CONVERT(EMP_CODEMP , CHAR(75)) AS ITECODITE, ';
  Result := Result + '       CONVERT(EMP_CODEMP , CHAR(75)) AS ITEDESITE  ';

  Result := Result + ' FROM CADEMP LIMIT 0                             ';
end;

procedure TfrmAnaliseEstoqueEmExcesso.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskLinGru);
end;

procedure TfrmAnaliseEstoqueEmExcesso.FormCreate(Sender: TObject);
begin
  ntbPaginas.PageIndex := 0;
  inherited;
  pCarregaComposicaoCusto(cmbComCus);
  intWidth  := Self.Width;
  intHeight := Self.Height;

  qryRelatorio := TZClient.Create(Self);
  qryEstoqu    := TZClient.Create(Self);

  qryGirIte := fCriaQuery(Self);
  qryMovFat := fCriaQuery(Self);
  qryMovCom := fCriaQuery(Self);

  strCorZeb := fCfgSis('CORZEB', VarString);
  fltFiltro := TFiltrosRelatorio.Create;

  pSetaCodIte(edtCodPro);

end;

procedure TfrmAnaliseEstoqueEmExcesso.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryGirIte);
  FreeAndNil(qryMovFat);
  FreeAndNil(qryMovCom);
  FreeAndNil(qryEstoqu);

  FreeAndNil(qryRelatorio);
  FreeAndNil(fltFiltro);
  If Assigned(CamposExportaEstoqueEmExcesso) Then
    FreeAndNil(CamposExportaEstoqueEmExcesso);
end;

procedure TfrmAnaliseEstoqueEmExcesso.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (ntbPaginas.PageIndex = 1) And (Key = VK_F4) Then
     btnGeraTE.Click;
end;

procedure TfrmAnaliseEstoqueEmExcesso.mskLinGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGru, edtDesGrupo, arrLinGru, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);

end;

procedure TfrmAnaliseEstoqueEmExcesso.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinGru, edtDesGrupo, Nil, Key , arrLinGru, False) Then
  Begin
    If fValidaCampos(mskLinGru, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAnaliseEstoqueEmExcesso.pAddGrupoRelatorio(strCodIte, strGrupo, strDesGru: String; qryQueryP : TDataSet);
  var
    blnLocate : Boolean;
begin
  if (strUltGru = strGrupo) and  (strCodIte =  '') Then
    Exit
  Else If (strCodIte <> '') And (strUltGru = strGrupo + strCodIte) Then
    Exit;

  If strCodIte = '' Then
  Begin
    strUltGru := strGrupo;
    blnLocate := qryRelatorio.Locate('GRUPO', strGrupo ,[])
  End
  Else
  Begin
    strUltGru := strGrupo + strCodIte;
    blnLocate := qryRelatorio.Locate('CODITE;CODEMP', VarArrayOf([qryQueryP.FieldByName('CODITE').AsString,
                                                      qryQueryP.FieldByName('CODEMP').AsString]), []);
  End;

  If Not blnLocate Then
  Begin
    With qryRelatorio Do
    Begin
      Append;
      FieldByName('GRUPO' ).AsString := strGrupo;
      FieldByName('DESGRU').AsString := strDesGru;
      If cmbSintetico.ItemIndex = 4 Then
      Begin
        FieldByName('SIGUNI').AsString := qryQueryP.FieldByName('SIGUNI').AsString;
        FieldByName('CODFAB').AsString := qryQueryP.FieldByName('CODFAB').AsString;
        FieldByName('CODITE').AsString := qryQueryP.FieldByName('CODITE').AsString;
        FieldByName('CODEMP').AsString := qryQueryP.FieldByName('CODEMP').AsString;
        FieldByName('ITECODITE').AsString := qryQueryP.FieldByName('ITECODITE').AsString;
        FieldByName('ITEDESITE').AsString := qryQueryP.FieldByName('ITEDESITE').AsString;
        FieldByName('DIAEST').Clear;
      End
      Else
      Begin
        FieldByName('SIGUNI').AsString := '';
        FieldByName('CODFAB').AsString := '';
        FieldByName('DIAEST').Clear;
      End;

      FieldByName('QTDITE').Value := Null;
      FieldByName('FATURA').Value := Null;
      FieldByName('CUMVEN').Value := Null;
      FieldByName('RESULT').Value := Null;
      FieldByName('MARKUP').AsFloat := 0.00;
      FieldByName('MARGEM').AsFloat := 0.00;
      FieldByName('ESTBRU').Value := Null;
      FieldByName('EXCESS').Value := Null;
      FieldByName('SEMMOV').Value := Null;
      FieldByName('ESTREA').Value := Null;
      FieldByName('ESTOBJ').Value := Null;
      FieldByName('ESTIDE').Value := Null;
      FieldByName('CUSCOM').Value := Null;
      FieldByName('COMEXC').Value := Null;
      FieldByName('REPRES').Value := Null;
      FieldByName('QTDFAT').Value := Null;
      FieldByName('QTDEXC').Value := Null;
      FieldByName('QTDSMO').Value := Null;
      FieldByName('QTDOBJ').Value := Null;
      FieldByName('QTDCOM').Value := Null;
      FieldByName('EXCCOM').Value := Null;
      Post;
    End;
  End;
end;

procedure TfrmAnaliseEstoqueEmExcesso.pMostraResultado(
  blnMostraResultado: Boolean);
begin
  if blnMostraResultado Then
  Begin
    colSIGUNI.Visible := cmbSintetico.ItemIndex = 4;
    colCODFAB.Visible := cmbSintetico.ItemIndex = 4;
    colDIAEST.Visible := cmbSintetico.ItemIndex = 4;
    colITECODITE.Visible := cmbSintetico.ItemIndex = 4;
    colITEDESITE.Visible := cmbSintetico.ItemIndex = 4;

    self.BorderIcons := self.BorderIcons + [biMaximize];
    ntbPaginas.PageIndex := 1;
    Self.BorderStyle := bsSizeable;
    Self.WindowState := wsMaximized;
    pSetFocus(dbgDados);
  End
  Else
  Begin
    self.BorderIcons := self.BorderIcons - [biMaximize];
    ntbPaginas.PageIndex := 0;
    Self.BorderStyle := bsSingle;
    Self.WindowState := wsNormal;
    Self.Width := intWidth ;
    Self.Height:= intHeight;
  End;

end;

function TfrmAnaliseEstoqueEmExcesso.fPreparaDados:Boolean;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fPreparaDadosProgresso;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;
  Finally
    FreeAndNil(frmGravando);
  End;

end;

procedure TfrmAnaliseEstoqueEmExcesso.pPreparaQuery(qry : TUniQuery);
Begin
  qry.Close;
  qry.SQL.Clear;
End;

function TfrmAnaliseEstoqueEmExcesso.fPreparaDadosProgresso(
  cxProgressbar: TcxProgressBar): Boolean;
  Var
    intMaxStep : Integer;
    fltMesEst  : Double;
    fltQtdEst, fltCnvMl : Double;

  procedure pSalvaEstoque(
    fltQTDITE : Double;
    fltESTREA : Double;
    fltESTBRU : Double;
    fltEXCESS : Double;
    fltQTDEXC : Double;
    fltSEMMOV : Double;
    fltQTDSMO : Double;
    fltQTDGIR : Double;
    fltSALDOS : Double;
    fltDIAEST : Double);

  Begin
    qryRelatorio.Edit;
    qryRelatorio.FieldByName('QTDITE').AsFloat := fltQTDITE;
    qryRelatorio.FieldByName('ESTREA').AsFloat := fltESTREA;
    qryRelatorio.FieldByName('ESTBRU').AsFloat := fltESTBRU;
    qryRelatorio.FieldByName('EXCESS').AsFloat := fltEXCESS;
    qryRelatorio.FieldByName('QTDEXC').AsFloat := fltQTDEXC;
    qryRelatorio.FieldByName('SEMMOV').AsFloat := fltSEMMOV;
    qryRelatorio.FieldByName('QTDSMO').AsFloat := fltQTDSMO;

    If qryRelatorio.FieldByName('EXCESS').AsFloat <> 0 Then
    Begin
      qryRelatorio.FieldByName('ESTOBJ').AsFloat := qryRelatorio.FieldByName('ESTBRU').AsFloat - qryRelatorio.FieldByName('EXCESS').AsFloat;
      qryRelatorio.FieldByName('QTDOBJ').AsFloat := fltSaldos - fltQTDEXC;
    End;

    if qryRelatorio.FieldByName('ESTOBJ').AsFloat = 0 Then
    Begin
      qryRelatorio.FieldByName('ESTOBJ').Value := Null;
      qryRelatorio.FieldByName('QTDOBJ').Value := Null;
    End;

    If qryRelatorio.FieldByName('SEMMOV').AsFloat <> 0 Then
      qryRelatorio.FieldByName('ESTIDE').AsFloat := qryRelatorio.FieldByName('ESTOBJ').AsFloat - qryRelatorio.FieldByName('SEMMOV').AsFloat;

    if qryRelatorio.FieldByName('ESTIDE').AsFloat = 0 Then
      qryRelatorio.FieldByName('ESTIDE').Value := Null;

    If qryRelatorio.FieldByName('CUSCOM').AsFloat <> 0 Then
    begin
      qryRelatorio.FieldByName('COMEXC').AsFloat := qryRelatorio.FieldByName('CUMVEN').AsFloat - qryRelatorio.FieldByName('CUSCOM').AsFloat;
      qryRelatorio.FieldByName('EXCCOM').AsFloat := qryRelatorio.FieldByName('QTDFAT').AsFloat - qryRelatorio.FieldByName('QTDCOM').AsFloat;
    End;

    if qryRelatorio.FieldByName('EXCESS').AsFloat = 0 Then
      qryRelatorio.FieldByName('EXCESS').Value := Null;

    if qryRelatorio.FieldByName('COMEXC').AsFloat = 0 then
    begin
      qryRelatorio.FieldByName('COMEXC').Value := Null;
      qryRelatorio.FieldByName('EXCCOM').Value := Null;
    End;

    if qryRelatorio.FieldByName('CUSCOM').AsFloat <> 0 Then
      qryRelatorio.FieldByName('REPRES').AsFloat := ((qryRelatorio.FieldByName('COMEXC').AsFloat / qryRelatorio.FieldByName('CUSCOM').AsFloat) * 100);

    If cmbSintetico.ItemIndex = 4 Then
      qryRelatorio.FieldByName('DIAEST').AsFloat := fltDIAEST;


    qryRelatorio.Post;
  End;

  procedure pMessages;
  Begin
    Application.ProcessMessages;
  End;

  procedure pStep(intIndex : Integer = -1);
  Begin
    If intIndex > -1 Then
      cxProgressbar.Position := intIndex
    Else
      cxProgressbar.Position := cxProgressbar.Position + 1;
  End;

  procedure pCalculaEstoque;
    Var
      fltNivel: Double;

    function fEdtNivel : Double;
    Begin
      If qryEstoqu.FieldByName('ITE_NVLGIR').AsString = 'A' Then
        Result := fStrToFloat(edtNivelA.Text)
      Else
      If qryEstoqu.FieldByName('ITE_NVLGIR').AsString = 'B' Then
        Result := fStrToFloat(edtNivelB.Text)
      Else
        Result := fStrToFloat(edtNivelC.Text);
    End;

  Begin
    With qryEstoqu Do
    Begin
      Try
        First;
        DisableControls;
        cxProgressbar.Properties.Max := RecordCount;
        pStep(0);

        While not Eof Do
        Begin
          If qryGirIte.Locate('GIR_CODITE;GIR_CODEMP', VarArrayOf([ FieldByName('ITE_CODITE').AsString, FieldByName('CODEMP').AsString ]), []) Then
          Begin
            Edit;
            FieldByName('QTDGIR').AsFloat := qryGirIte.FieldByName('QTDGIR').AsFloat;
            fltNivel := FieldByName('SALDOS').AsFloat - ((( FieldByName('QTDGIR').AsFloat / fQtdMesesGiro) / 30) * fEdtNivel);
            FieldByName('EXCESS').AsFloat := IIF(fltNivel < 0, 0, fltNivel * FieldByName('PREEST').AsFloat);
            FieldByName('QTDEXC').AsFloat := fltNivel;
            FieldByName('SEMMOV').AsFloat := IIF( FieldByName('QTDGIR').AsFloat <= 0, FieldByName('PREEST').AsFloat * FieldByName('SALDOS').AsFloat, 0);
            FieldByName('QTDSMO').AsFloat := IIF( FieldByName('QTDGIR').AsFloat <= 0, FieldByName('SALDOS').AsFloat, 0);

            Post;
          End;

          pStep;
          If (RecNo Mod 100) = 0 Then
            pMessages;
          Next;
        End;

      Finally
        First;
        EnableControls;
      End;
    End;

  End;

  Procedure pJuntaDados;
  Begin
    cxProgressbar.Properties.Max := qryMovFat.RecordCount + qryMovCom.RecordCount + qryEstoqu.RecordCount;
    pStep(0);

    With qryMovFat Do
    Begin
      Try
        First;
        DisableControls;

        While not Eof Do
        Begin
          //if Not qryRelatorio.Locate('GRUPO', FieldByName('GRUPO').AsString,[]) Then
          If cmbSintetico.ItemIndex = 4 Then
            pAddGrupoRelatorio(FieldByName('CODITE').AsString, FieldByName('GRUPO').AsString, FieldByName('DESGRU').AsString, qryMovFat)
          Else
            pAddGrupoRelatorio('', FieldByName('GRUPO').AsString, FieldByName('DESGRU').AsString, qryMovFat);

          qryRelatorio.Edit;
          qryRelatorio.FieldByName('FATURA').AsFloat := FieldByName('TOTITE').AsFloat;
          qryRelatorio.FieldByName('QTDFAT').AsFloat := FieldByName('QTDFAT').AsFloat;
          qryRelatorio.FieldByName('CUMVEN').AsFloat := FieldByName('TOTCUS').AsFloat;
          qryRelatorio.FieldByName('RESULT').AsFloat := FieldByName('TOTITE').AsFloat -  FieldByName('TOTCUS').AsFloat;

          qryRelatorio.FieldByName('MARKUP').AsFloat := 0.00;
          qryRelatorio.FieldByName('MARGEM').AsFloat := 0.00;

          If (FieldByName('TOTCUS').AsFloat > 0) Then
            qryRelatorio.FieldByName('MARKUP').AsFloat := ((( FieldByName('TOTITE').AsFloat / FieldByName('TOTCUS').AsFloat ) * 100) - 100 );

          If ( FieldByName('TOTITE').AsFloat > 0 ) Then
            qryRelatorio.FieldByName('MARGEM').AsFloat := ( ( 1 - (FieldByName('TOTCUS').AsFloat / FieldByName('TOTITE').AsFloat)) * 100);

          qryRelatorio.Post;

          pStep;
          If (RecNo Mod 100) = 0 Then
            pMessages;
          Next;
        End;

      Finally
        First;
        EnableControls;
      End;
    End;

    // -------------------------- COMPRAS ------------------------------------

    With qryMovCom Do
    Begin
      Try
        First;
        DisableControls;

        While not Eof Do
        Begin
          //if not qryRelatorio.Locate('GRUPO', FieldByName('GRUPO').AsString,[]) Then
          If cmbSintetico.ItemIndex = 4 Then
            pAddGrupoRelatorio(FieldByName('CODITE').AsString, FieldByName('GRUPO').AsString, FieldByName('DESGRU').AsString, qryMovCom)
          Else
            pAddGrupoRelatorio('', FieldByName('GRUPO').AsString, FieldByName('DESGRU').AsString, qryMovCom);

          if FieldByName('CUSCOM').AsFloat <> 0 then
          Begin
            qryRelatorio.Edit;
            qryRelatorio.FieldByName('CUSCOM').AsFloat := FieldByName('CUSCOM').AsFloat;
            qryRelatorio.FieldByName('QTDCOM').AsFloat := FieldByName('QTDCOM').AsFloat;

            qryRelatorio.Post;
          End;

          pStep;
          If (RecNo Mod 100) = 0 Then
            pMessages;
          Next;
        End;

      Finally
        First;
        EnableControls;
      End;
    End;

    // -------------------------- ESTOQUE ------------------------------------

    With qryEstoqu Do
    Begin
      Try
        First;
        DisableControls;

        While not Eof Do
        Begin

          fltMesEst := ((FieldByName('QTDGIR').AsFloat / fQtdMesesGiro)/ 30);
          If fltMesEst < 0 Then
             fltMesEst := 0;

          //if not qryRelatorio.Locate('GRUPO', FieldByName('GRUPO').AsString,[]) Then
          If cmbSintetico.ItemIndex = 4 Then
            pAddGrupoRelatorio(FieldByName('CODITE').AsString, FieldByName('GRUPO').AsString, FieldByName('DESGRU').AsString, qryEstoqu)
          Else
            pAddGrupoRelatorio('', FieldByName('GRUPO').AsString, FieldByName('DESGRU').AsString, qryEstoqu);

          If cmbSintetico.ItemIndex = 4 Then
          Begin
            fltQtdEst := FieldByName('SALDOS').AsFloat - TSaldoReservado.New(
                                                           TReservaParametros.New()
                                                             .EmpresaItem(FieldByName('CODEMP').AsString)
                                                             .CodigoItem(copy(FieldByName('CODITE').AsString, 0, fTamCodIte))
                                                             .CodEmpresa(FieldByName('CODEMP').AsString)
                                                           ).fGetQuantidade();

            fltCnvMl := fCampoTabela('ITE_CNV_ML','CADITE',['ITE_CODITE'],[copy(FieldByName('CODITE').AsString, 0, fTamCodIte)]);

            fltQtdEst := fltQtdEst * Iif(fltCnvML = 0, 1, fltCnvML);
          End
          Else
            fltQtdEst := FieldByName('QTDITE').AsFloat;
          pSalvaEstoque(fltQtdEst,
                        FieldByName('ESTREA').AsFloat,
                        FieldByName('ESTBRU').AsFloat,
                        FieldByName('EXCESS').AsFloat,
                        FieldByName('QTDEXC').AsFloat,
                        FieldByName('SEMMOV').AsFloat,
                        FieldByName('QTDSMO').AsFloat,
                        Iif(cmbSintetico.ItemIndex = 4, FieldByName('QTDGIR').AsFloat, 0),
                        Iif(cmbSintetico.ItemIndex = 4, FieldByName('SALDOS').AsFloat, 0),
                        IIf(cmbSintetico.ItemIndex = 4, fltMesEst, 0));

          pStep;

          If (RecNo Mod 100) = 0 Then
            pMessages;
          Next;
        End;
        If cmbSintetico.ItemIndex = 4 Then
          dbgDadosDBBandedTableView.GetColumnByFieldName('CODITE').GroupIndex :=
            dbgDadosDBBandedTableView.GetColumnByFieldName('CODITE').Index;

      Finally
        First;
        EnableControls;
      End;
    End;

  End;

begin
  Try
    Result := True;

    intMaxStep := 4;

    pStep(0);
    cxProgressbar.Properties.Max := intMaxStep;
    frmGravando.lblGravando.Caption := 'Aguarde, Preparando Dados...';

    If qryRelatorio.Active Then
      qryRelatorio.EmptyDataSet;

    if qryEstoqu.Active Then
      qryEstoqu.EmptyDataSet;

    strUltGru := '';

    If qryRelatorio.Active Then
      qryRelatorio.EmptyDataSet
    Else
      qryRelatorio.Close;
    qryRelatorio.qryQuery.SQL.Clear;
    qryRelatorio.qryQuery.SQL.Add(fGetSqlRelatorio);
    qryRelatorio.fAbreClient(True, 'TfrmAnaliseEstoqueEmExcesso.fPreparaDadosProgresso');
    If cmbSintetico.ItemIndex = 4 Then
      qryRelatorio.IndexFieldNames := 'CODITE;CODEMP'
    Else
      qryRelatorio.IndexFieldNames := 'GRUPO';
    qryRelatorio.LogChanges := False;
    qryRelatorio.DisableControls;

    pPreparaQuery(qryGirIte);
    pPreparaQuery(qryMovFat);
    pPreparaQuery(qryMovCom);
    pPreparaQuery(qryEstoqu.qryQuery);

    qryGirIte.SQL.Add(fGetSqlGirIte);
    qryMovFat.SQL.Add(fGetSqlMovDet);
    qryMovCom.SQL.Add(fGetSqlMovCompra);
    qryEstoqu.qryQuery.SQL.Add(fGetSqlEstoque);

    pSetParams(qryGirIte);
    pSetParams(qryMovFat);
    pSetParams(qryMovCom);
    pSetParams(qryEstoqu.qryQuery);

    frmGravando.lblGravando.Caption := 'Coletando Informações - 1/' + intToStr(intMaxStep) + ' - Giro de Estoque...';
    pMessages;
    qryGirIte.Open;
    If cmbSintetico.ItemIndex = 4 Then
      qryGirIte.IndexFieldNames := 'GIR_CODITE;GIR_CODEMP'
    Else
      qryGirIte.IndexFieldNames := 'GIR_CODEMP;GIR_CODITE';
    pStep;

    frmGravando.lblGravando.Caption := 'Coletando Informações - 2/' + intToStr(intMaxStep) + ' - Faturamento...';
    pMessages;
    qryMovFat.Open;
    pStep;

    frmGravando.lblGravando.Caption := 'Coletando Informações - 3/' + intToStr(intMaxStep) + ' - Compras...';
    pMessages;
    qryMovCom.Open;
    pStep;

    frmGravando.lblGravando.Caption := 'Coletando Informações - 4/' + intToStr(intMaxStep) + ' - Estoque...';
    pMessages;
    qryEstoqu.fAbreClient(True, 'TfrmAnaliseEstoqueEmExcesso.fPreparaDadosProgresso');
    qryEstoqu.LogChanges := False;
    pStep;

    frmGravando.lblGravando.Caption := 'Calculando Valores do Estoque...';
    pMessages;
    pCalculaEstoque;

    frmGravando.lblGravando.Caption := 'Sintetizando Relatório...';
    pMessages;
    pJuntaDados;

    qryRelatorio.First;
    qryRelatorio.EnableControls;
  Except
    On E : Exception Do
    Begin
      qryRelatorio.EnableControls;
      qryRelatorio.Close;
      Result := False;
      pMensagensErro(E.Message, 'TfrmAnaliseEstoqueEmExcesso.fPreparaDadosProgresso')
    End;
  End;

end;

function TfrmAnaliseEstoqueEmExcesso.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
  var
    strAutInc : String;
  procedure pLimpaPedCompra(Sender : TWinControl);
  begin
    if (Sender is TEditFocus) and fEmptyStr(TEditFocus(Sender).Text) then
      setLength(arrPedCompra, 0)
  end;

  procedure pLimpaNFEntrada(Sender : TWinControl);
  begin
    if (Sender is TEditFocus) and fEmptyStr(TEditFocus(Sender).Text) then
      setLength(arrNFEntrada, 0)
  end;
begin
  Result := False;
  
  if (Inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    Result := True;
    If (Sender = mskLinGru) Then
    Begin
      pDesmarcaLista(mskLinGru,arrLinGru,'', 6);
    End

    Else If (Sender = edtCodPro) Then
    Begin
      pDesmarcaLista(edtCodPro,arrProduto);
    End

    Else If (Sender = edtCodFor) Then
    Begin
      pDesmarcaLista(edtCodFor,arrCodFor);
    End

    Else If (Sender = edtCodMar) Then
    Begin
      pDesmarcaLista(edtCodMar,arrMarca);
    End

    Else
    If (Sender = edtCodEmpresa) Then
    Begin
      pDesmarcaLista(edtCodEmpresa, arrEmpresa);
    End

    Else
    If (Sender = edtGruCmp) Then
    Begin
      pDesmarcaLista(edtGruCmp, arrGruCmp);
    End

    else

    If (Sender = edtNumPcm) Then
    Begin
      pLimpaPedCompra(Sender);
    End

    else if (Sender = edtEspPcm) then
    begin

      if fEmptyStr(edtEspPcm.Text) then
        pLimpaPedCompra(Sender)
      else
      begin
        if fEmptyStr(edtNumPcm.Text) then
        begin
          pMensagemOk('Informe o número do documento do pedido de compra!');
          pSetFocus(edtNumPCM);
          Exit(False);
        end
        else if (Length(arrPedCompra) = 0) and (not MatchStr(edtEspPCM.Text, ['PD','OR'])) then
        begin
          pMensagemOK('A espécie do documento deve ser igual a PD ou OR!');
          Result :=False;
        end;
      end;

    end
    else if  (Sender = edtEmpPcm) Then
    begin
      pLimpaPedCompra(Sender);

      if (not fEmptyStr(edtNumPCM.Text)) or (not fEmptyStr(edtEspPCM.Text)) or (not fEmptyStr(edtEmpPcm.Text))then
      begin
        if fEmptyStr(edtNumPCM.Text) then
        begin
          pMensagemOk('Informe o número do documento do pedido de compra!');
          pSetFocus(edtNumPcm);
          exit(False);
        end
        else if fEmptyStr(edtEspPCM.Text) then
        begin
          pMensagemOk('Informe a espécie do pedido de compra!');
          pSetFocus(edtEspPcm);
          exit(False);
        end
        else if fEmptyStr(edtEmpPCM.Text) then
        begin
          pMensagemOk('Informe o código da empresa do pedido de compra!');
          Result := False;
        end
        else if Length(arrPedCompra) = 0 then
        begin
          strAutInc := fCampoTabela('AUTOINCREM', 'PCMGER', ['PCG_NUMPED', 'PCG_ESPDOC', 'PCG_CODEMP'], [edtNumPcm.Text, edtEspPcm.Text, edtEmpPcm.Text]);
          if not fEmptyStr(strAutInc) then
          begin
            setLength(arrPedCompra, 1);
            arrPedCompra[0].strCodigo := strAutInc;
            arrPedCompra[0].strdescri := 'AUTOINCREM';
          end
          else
          begin
            pMensagemOk('Pedido de Compra inválido!');
            Result := False;
          end;
        end;
      end;
    end


    else If (Sender = edtNumNfe) Then
    Begin
      pLimpaNFEntrada(Sender);
    End

    else if (Sender = edtEspNfe) then
    begin

      if fEmptyStr(edtEspNfe.Text) then
        pLimpaNFEntrada(Sender)
      else
      begin
        if fEmptyStr(edtNumNfe.Text) then
        begin
          pMensagemOk('Informe o número do documento de entrada!');
          pSetFocus(edtNumNfe);
          Exit(False);
        end;
      end;

    end


    else if  (Sender = edtEmpNfe) Then
    begin
      pLimpaNFEntrada(Sender);

      if (not fEmptyStr(edtNumNfe.Text)) or (not fEmptyStr(edtEspNfe.Text)) or (not fEmptyStr(edtEmpNfe.Text))then
      begin
        if fEmptyStr(edtNumNfe.Text) then
        begin
          pMensagemOk('Informe o número do documento de entrada!');
          pSetFocus(edtNumNfe);
          exit(False);
        end
        else if fEmptyStr(edtEspNfe.Text) then
        begin
          pMensagemOk('Informe a espécie do documento de compra!');
          pSetFocus(edtEspNfe);
          exit(False);
        end
        else if fEmptyStr(edtEmpNfe.Text) then
        begin
          pMensagemOk('Informe o código da empresa do documento de entrada!');
          Result := False;
        end
        else if Length(arrNFEntrada) = 0 then
        begin
          strAutInc := fCampoTabela('AUTOINCREM', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [edtNumNfe.Text, edtEspNfe.Text, edtEmpNfe.Text]);
          if not fEmptyStr(strAutInc) then
          begin
            setLength(arrNFEntrada, 1);
            arrNFEntrada[0].strCodigo := strAutInc;
            arrNFEntrada[0].strdescri := 'AUTOINCREM';
          end
          else
          begin
            pMensagemOk('Documento de Entrada inválido!');
            Result := False;
          end;
        end;
      end;
    end


    Else if (sender = mskFinNfe) then
    begin
      if not fEmptyStr(fTiraCaracEspeciais(mskFinNfe.Text)) then
      begin
        if fEmptyStr(fTiraCaracEspeciais(mskIniNfe.Text)) then
        begin
          pMensagemOk('Informe a data inicial do documento de entrada!');
          pSetFocus(mskIniNfe);
          exit(False);
        end;
      end;
    end

    Else if (sender = mskIniNfe) then
    begin
      if (not blnValidaIndividual) and (not fEmptyStr(fTiraCaracEspeciais(mskIniNfe.Text))) then
      begin
        if fEmptyStr(fTiraCaracEspeciais(mskFinNfe.Text)) then
        begin
          pMensagemOk('Informe a data final do documento de entrada!');
          pSetFocus(mskFinNfe);
          exit(False);
        end;
      end;
    end

    else
    If (Sender = mskPeriodo) Then
    Begin
      If StrToDateDef('01/'+mskPeriodo.Text,0) > 0 Then
      Begin
        mskPeriodo.Text := RightStr( FormatDateTime('dd/mm/yyyy', StrToDateDef('01/'+mskPeriodo.Text,0)) , 7);
      End;


      if (not (StrToIntDef(Copy(mskPeriodo.Text, 1, 2),0) in [1..12])) Or
         (StrToIntDef(Copy(mskPeriodo.Text, 4, 4),0) < 1900) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO', 'O Período Informado é Inválido!', ['&OK']);
      End
      Else
      Begin
        dtaIni := EncodeDate(StrToIntDef(Copy(mskPeriodo.Text, 4, 4),0), StrToIntDef(Copy(mskPeriodo.Text, 1, 2),0), 1);
        dtaFim := EndOfTheMonth(dtaIni);
      End;

    End;

  End;

  if (not Result) Then
    pSetFocus(Sender);
end;

function TfrmAnaliseEstoqueEmExcesso.fSQLPedCompra : String;
var
  strWhere : String;

  procedure pAddWhere(strFiltro : String);
  begin
    if strWhere = '' then
      strWhere := ' WHERE '
    else
      strWhere := strWhere + ' AND ';

    strWhere := strWhere + '(' + strFiltro + ')';
  end;
begin
  Result   := '';
  strWhere := '';

  if Length(arrPedCompra) > 0 then
    pAddWhere('PCMGER.AUTOINCREM IN ('+   fArrCodigosToLista('', arrPedCompra) + ')');

  if (not fEmptyStr(fTiraCaracEspeciais(mskIniPcm.Text))) then
    pAddWhere('  PCD_DTAENT BETWEEN :PCGENT_INI AND :PCGENT_FIN');

  Result := Result + 'SELECT                                                                     ';
  Result := Result + '  PCD_CODITE                                                               ';
  Result := Result + 'FROM                                                                       ';
  Result := Result + '  PCMGER                                                                   ';
  Result := Result + '  INNER JOIN PCMDET ON                                                     ';
  Result := Result + '        PCG_NUMPED = PCD_NUMPED                                            ';
  Result := Result + '    AND PCG_CODEMP = PCD_CODEMP                                            ';
  Result := Result + '    AND PCG_ESPDOC = PCD_ESPDOC                                            ';
  Result := Result + '    AND PCG_NUMCTN = PCD_NUMCTN                                            ';
  Result := Result + strWhere;
end;



function TfrmAnaliseEstoqueEmExcesso.fSQLNFEntrada : String;
var
  strWhere : String;

  procedure pAddWhere(strFiltro : String);
  begin
    if strWhere = '' then
      strWhere := ' WHERE '
    else
      strWhere := strWhere + ' AND ';

    strWhere := strWhere + '(' + strFiltro + ')';
  end;
begin
  Result   := '';
  strWhere := '';

  if Length(arrNFEntrada) > 0 then
    pAddWhere('DET_SEQGER IN ('+   fArrCodigosToLista('', arrNFEntrada) + ')');

  if (not fEmptyStr(fTiraCaracEspeciais(mskIniPcm.Text))) then
    pAddWhere('  DET_DTAENT BETWEEN :NFEINI AND :NFEFIN');

  Result := Result + ' SELECT       ';
  Result := Result + '   DET_CODITE ';
  Result := Result + ' FROM         ';
  Result := Result + '   MOVDET     ';
  Result := Result + strWhere;
end;

end.
