unit untImportarArquivoParaAnalise_de_Compras;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxButtonEdit, FilenameEditFocus, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Vcl.ComCtrls, untTValidaExcel,
  System.Character, untZClient, uni, cxCurrencyEdit,
  untImportarArquivoParaAnalise_de_Compras_Totais,
  untGerarOrcamentoCompraAuto, cxProgressBar, System.strUtils,
  cxDBLookupComboBox, cxDropDownEdit, untSaldoLojas, untTProcessaArquivo_Deceuninck_Kommerling;

type

  TfrmImportarArquivoParaAnalise_de_Compras = class(TfrmPai)
    Panel1: TPanel;
    edtPath: TFilenameEditFocus;
    Label1: TLabel;
    btnCarregar: TBitBtnLocked;
    Panel2: TPanel;
    cxDados: TcxGrid;
    cxDadosDB: TcxGridDBTableView;
    cxDadosLvl: TcxGridLevel;
    dtsDados: TDataSource;
    cxDadosCODITE: TcxGridDBColumn;
    cxDadosDESITE: TcxGridDBColumn;
    cxDadosSIGUNI: TcxGridDBColumn;
    cxDadosSALDOS: TcxGridDBColumn;
    cxDadosSALDIS: TcxGridDBColumn;
    cxDadosPEDCOM: TcxGridDBColumn;
    cxDadosQTDIMP: TcxGridDBColumn;
    cxDadosQTDSUG: TcxGridDBColumn;
    cxDadosVLRUNI: TcxGridDBColumn;
    cxDadosVLRTOT: TcxGridDBColumn;
    cxDadosCODFOR: TcxGridDBColumn;
    cxDadosNOMFOR: TcxGridDBColumn;
    cxDadosIDENTIFICADO: TcxGridDBColumn;
    cxDadosMARCADO: TcxGridDBColumn;
    Panel3: TPanel;
    Shape1: TShape;
    Label2: TLabel;
    Shape2: TShape;
    Label3: TLabel;
    Label4: TLabel;
    btnGerarDocumentos: TBitBtnLocked;
    btnTotaisPorFornecedor: TBitBtnLocked;
    pgbProgresso: TcxProgressBar;
    rdgTipoLayout: TRadioGroup;
    Label5: TLabel;
    Shape3: TShape;
    dtsDuplicados: TDataSource;
    procedure btnCarregarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxDadosDBCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxDadosDBCanFocusRecord(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; var AAllow: Boolean);

    procedure cxDadosDBCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxDadosDBKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnTotaisPorFornecedorClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGerarDocumentosClick(Sender: TObject);
    procedure cxDadosDBKeyPress(Sender: TObject; var Key: Char);
    procedure cxDadosDBEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure cxDadosDBDblClick(Sender: TObject);

  private
    ProcessaArquivo: TProcessaArquivo;
    procedure pMarcaDesmarcaItem;

    { Private declarations }
  public

    { Public declarations }
  end;

Const  tsiNaoEncontrado = 0;
       tsiEncontrado = 1;
       tsiInformado = 2;
       tsiDuplicado = 3;

implementation

uses
  untFuncoesSimples, untGravando, untConsultas, untTypesSistema, untImportarListaDeMateriais,
  untFuncoes, untSelecionaItemDuplicadoCodFabrica;


{$R *.dfm}

procedure TfrmImportarArquivoParaAnalise_de_Compras.btnCarregarClick(
  Sender: TObject);
begin
  inherited;

  ProcessaArquivo.TipoLayout := IIf(rdgTipoLayout.ItemIndex = 0, tlDeceuninck, tlKommerling);
  dtsDados.DataSet := ProcessaArquivo.FQryDados;
  ProcessaArquivo.Arquivo := edtPath.Text;
end;

procedure TfrmImportarArquivoParaAnalise_de_Compras.btnGerarDocumentosClick(
  Sender: TObject);
begin
  inherited;
  If ProcessaArquivo.fGeraPedidoCompra Then
  Begin
    edtPath.Text := '';
    pSetFocus(edtPath);
  End;

end;

procedure TfrmImportarArquivoParaAnalise_de_Compras.btnTotaisPorFornecedorClick(
  Sender: TObject);
begin
  inherited;
  ProcessaArquivo.pVisualizaTotais;
end;

procedure TfrmImportarArquivoParaAnalise_de_Compras.cxDadosDBCanFocusRecord(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
  var blnEditing: Boolean;
begin
  inherited;
  blnEditing := True;
  If ProcessaArquivo.FqryDados.FieldByname('IDENTIFICADO').AsInteger = tsiNaoEncontrado Then
    blnEditing := False;
  cxDadosCODFOR.Options.Editing := blnEditing;
  cxDadosQTDSUG.Options.Editing := blnEditing;
  cxDadosCODITE.Options.Editing := Not  blnEditing;
end;

procedure TfrmImportarArquivoParaAnalise_de_Compras.cxDadosDBCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If (AShift = [ssCtrl]) And (AButton = mbLeft) Then
    pMarcaDesmarcaItem;
end;

procedure TfrmImportarArquivoParaAnalise_de_Compras.cxDadosDBCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If Not VarIsNull(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxDadosMARCADO.Index]) Then
    If Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxDadosMARCADO.Index] = 1 Then
    Begin
      ACanvas.Brush.Color :=  clAqua;
      ACanvas.Font.Color :=  clBlack;
    End;
  If (AViewInfo.Item = cxDadosCODFOR) Or
     (AViewInfo.Item = cxDadosQTDSUG) Then
  Begin
    ACanvas.Brush.Color := clYellow;
    ACanvas.Font.Color :=  clBlack;
  End;

  If Not VarIsNull(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxDadosIDENTIFICADO.Index]) Then
  Begin
    If Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxDadosIDENTIFICADO.Index] = tsiNaoEncontrado Then
      ACanvas.Font.Color := clRed;
    If Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxDadosIDENTIFICADO.Index] = tsiDuplicado Then
      ACanvas.Font.Color := clBlue;
  End;
end;

procedure TfrmImportarArquivoParaAnalise_de_Compras.cxDadosDBDblClick(
  Sender: TObject);
begin
  ProcessaArquivo.pEscolheItensDuplicados;
end;

procedure TfrmImportarArquivoParaAnalise_de_Compras.cxDadosDBEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
  var qryConIte: TUniQuery;
    arrSel: TConsultasArray;
    IntRecNo: Integer;
begin
  inherited;
  qryConIte := fCriaQuery;
  Try
    If (fEntraCons(Key)) And ((cxDadosCODITE.Focused) And (cxDadosCODITE.Options.Editing)) Then
    Begin
      if fPesqItem(conIteSimples,
                   Self,
                   Nil,
                   Nil,
                   qryConIte,
                   Key,
                   arrSel,
                   True,
                   Nil,
                   'Consulta de Itens',
                   '1',
                   '',
                   0,
                   false,
                   false,
                   0) Then
      Begin
        IntRecNo := ProcessaArquivo.FqryDados.RecNo;
        If ProcessaArquivo.FqryDados.State <> dsEdit Then
          ProcessaArquivo.FqryDados.Edit;
        ProcessaArquivo.FqryDados.FieldByName('CODITE').AsString :=  qryConIte.FieldByName('ITE_CODITE').AsString;
        ProcessaArquivo.FqryDados.Post;
        ProcessaArquivo.FqryDados.RecNo := IntRecNo;
      End;
    End;
    If (fEntraCons(Key)) And ((cxDadosCODFOR.Focused) And (cxDadosCODFOR.Options.Editing)) Then
    Begin
      if fPesqFornecedor(conForSimples,
                   Self,
                   Nil,
                   Nil,
                   qryConIte,
                   Key,
                   arrSel) Then
      Begin
        IntRecNo := ProcessaArquivo.FqryDados.RecNo;
        If ProcessaArquivo.FqryDados.State <> dsEdit Then
          ProcessaArquivo.FqryDados.Edit;
        ProcessaArquivo.FqryDados.FieldByName('CODFOR').AsString :=  qryConIte.FieldByName('FOR_CODFOR').AsString;
        ProcessaArquivo.FqryDados.Post;
        ProcessaArquivo.FqryDados.RecNo := IntRecNo;

      End;
    End;
  Finally
    FreeAndNil(qryConIte);
  End;

end;

procedure TfrmImportarArquivoParaAnalise_de_Compras.cxDadosDBKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Shift = [ssShift]) And (Key in [VK_UP, VK_DOWN]) Then
    pMarcaDesmarcaItem;

end;

procedure TfrmImportarArquivoParaAnalise_de_Compras.cxDadosDBKeyPress(
  Sender: TObject; var Key: Char);
  var qryConIte: TUniQuery;
    arrSel: TConsultasArray;
    IntRecNo: Integer;
begin
  inherited;
  qryConIte := fCriaQuery;
  Try
    If (fEntraCons(Key)) And ((cxDadosCODITE.Focused) And (cxDadosCODITE.Options.Editing)) Then
    Begin
      if fPesqItem(conIteSimples,
                   Self,
                   Nil,
                   Nil,
                   qryConIte,
                   Key,
                   arrSel,
                   True,
                   Nil,
                   'Consulta de Itens',
                   '1',
                   '',
                   0,
                   false,
                   false,
                   0) Then
      Begin
        IntRecNo := ProcessaArquivo.FqryDados.RecNo;
        If ProcessaArquivo.FqryDados.State <> dsEdit Then
          ProcessaArquivo.FqryDados.Edit;
        ProcessaArquivo.FqryDados.FieldByName('CODITE').AsString :=  qryConIte.FieldByName('ITE_CODITE').AsString;
        ProcessaArquivo.FqryDados.Post;
        ProcessaArquivo.FqryDados.RecNo := IntRecNo;
      End;
    End;
    If (fEntraCons(Key)) And ((cxDadosCODFOR.Focused) And (cxDadosCODFOR.Options.Editing)) Then
    Begin
      if fPesqFornecedor(conForSimples,
                   Self,
                   Nil,
                   Nil,
                   qryConIte,
                   Key,
                   arrSel) Then
      Begin
        IntRecNo := ProcessaArquivo.FqryDados.RecNo;
        If ProcessaArquivo.FqryDados.State <> dsEdit Then
          ProcessaArquivo.FqryDados.Edit;
        ProcessaArquivo.FqryDados.FieldByName('CODFOR').AsString :=  qryConIte.FieldByName('FOR_CODFOR').AsString;
        ProcessaArquivo.FqryDados.Post;
        ProcessaArquivo.FqryDados.RecNo := IntRecNo;
      End;
    End;
  Finally
    FreeAndNil(qryConIte);
  End;
end;

procedure TfrmImportarArquivoParaAnalise_de_Compras.FormCreate(Sender: TObject);
begin
  inherited;
  ProcessaArquivo := TProcessaArquivo.Create(pgbProgresso, toAnaliseDeCompra);
end;

procedure TfrmImportarArquivoParaAnalise_de_Compras.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F2 Then
    btnTotaisPorFornecedor.OnClick(Sender);
  If Key = VK_F1 Then
    btnGerarDocumentos.OnClick(Sender);
end;

procedure TfrmImportarArquivoParaAnalise_de_Compras.pMarcaDesmarcaItem;
var blnMarca: Boolean;
begin
  If ProcessaArquivo.FqryDados.FieldByName('IDENTIFICADO').AsInteger = tsiNaoEncontrado Then
    Exit;
  ProcessaArquivo.FqryDados.Edit;
  blnMarca := ProcessaArquivo.FqryDados.FieldByName('MARCADO').AsInteger = 0;
  ProcessaArquivo.FqryDados.FieldByName('MARCADO').AsInteger := IIf(blnMarca, 1, 0);
  ProcessaArquivo.FqryDados.Post;
end;


end.
