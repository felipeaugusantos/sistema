unit untConfigImpulsionadorVendasCRM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxCheckBox,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, Datasnap.DBClient,
  UniClientDataSet, Vcl.Grids, Vcl.DBGrids, DBGridCitel, cxGridCitel,
  Vcl.ComCtrls, Uni, Vcl.Samples.Gauges,
  ComboBoxFocus, cxImageComboBox, cxContainer, cxProgressBar,
  cxDataControllerConditionalFormattingRulesManagerDialog, Vcl.Samples.Spin,
  untCorGrid, dxColorEdit, cxColorComboBox, cxButtonEdit,
  cxVGrid, cxInplaceContainer, cxExtEditRepositoryItems,
  untCfgTel, untcxGridDBColumnHelper, untImpulsionadorVendasCRM;

 type

  TfrmConfigImpulsuonadorVendasCRM = class(TfrmPai)
    pnlCfgExp: TPanel;
    cdsColExi: TUniClientDataSet;
    cdsColExiCOLCAP: TStringField;
    cdsColExiCOLNAM: TStringField;
    dtsCfgCol: TDataSource;
    cdsColExiEXIBIR: TStringField;
    pnlGrdCol: TPanel;
    pnlGrdExp: TPanel;
    cxgColunasLevel1: TcxGridLevel;
    cxgColunasTableView1: TcxGridDBTableViewCitel;
    cxgColunas: TcxGridCitel;
    cxgColunasTableView1EXIBIR: TcxGridDBColumn;
    cxgColunasTableView1ORDCAM: TcxGridDBColumn;
    cxgColunasTableView1COLCAP: TcxGridDBColumn;
    cxgColunasTableView1COLNAM: TcxGridDBColumn;
    pnlCfgCol: TPanel;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    btnUp: TSpeedButton;
    btnDown: TSpeedButton;
    cdsColExiORDCAM: TIntegerField;
    btnGravar: TBitBtnLocked;
    dtsVis: TDataSource;
    pgcCfg: TPageControl;
    tbsColunas: TTabSheet;
    cdsColExiCOLTAM: TIntegerField;
    pnlAreaVis: TPanel;
    gagAreGrid: TGauge;
    Label1: TLabel;
    cxgColunasOrdenacao: TcxGridCitel;
    cxgColunasOrdenacaoTableView1: TcxGridDBTableViewCitel;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    pnlCentral: TPanel;
    btnRight: TSpeedButton;
    btnLeft: TSpeedButton;
    btnUpOrd: TSpeedButton;
    btnDownOrd: TSpeedButton;
    btnPadroes: TBitBtnLocked;
    cdsColOrd: TUniClientDataSet;
    IntegerField1: TIntegerField;
    dtsColOrd: TDataSource;
    StringField3: TStringField;
    cxGridDBColumn3: TcxGridDBColumn;
    StringField1: TStringField;
    StringField2: TStringField;
    grbTamanhoFonte: TGroupBox;
    speTamanhoFonteConfig: TSpinEdit;
    tsCores: TTabSheet;
    cxVerticalGrid1: TcxVerticalGrid;
    crCorFonte: TcxCategoryRow;
    crCorFundo: TcxCategoryRow;
    ccbFonteLinhaSelecionada: TcxEditorRow;
    ccbFundoLinhaSelecionada: TcxEditorRow;
    dbgVisDB: TcxGridCitel;
    dbgVisDBTableView1: TcxGridDBTableViewCitel;
    dbgVisDBView: TcxGridDBTableViewCitel;
    dbgVisDBLvl1: TcxGridLevel;
    ccbCorFontePadrao: TcxEditorRow;
    ccbFundoLinhaGrid: TcxEditorRow;
    crCorFonteColunas: TcxCategoryRow;
    ccbFonteColunaQtdIte: TcxEditorRow;
    ccbFonteColunaUniTar: TcxEditorRow;
    crCorFundoColunas: TcxCategoryRow;
    ccbFundoColunaQtdIte: TcxEditorRow;
    ccbFundoColunaUniTar: TcxEditorRow;
    procedure FormShow(Sender: TObject);
    procedure FormCreate
    (Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure cxgColunasTableView1EXIBIRPropertiesEditValueChanged(
      Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnPadroesClick(Sender: TObject);
    procedure dbgVisColumnMoved(Sender: TObject; FromIndex,
      ToIndex: Integer);
    procedure btnRightClick(Sender: TObject);
    procedure btnLeftClick(Sender: TObject);
    procedure btnUpOrdClick(Sender: TObject);
    procedure btnDownOrdClick(Sender: TObject);
    procedure cdsColOrdAfterPost(DataSet: TDataSet);
    procedure cxGridDBColumn3PropertiesEditValueChanged(Sender: TObject);
    procedure speTamanhoFonteConfigChange(Sender: TObject);
    procedure dbgVisDBViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxVerticalGrid1Exit(Sender: TObject);
  private
    { Private declarations }
    blnColOrd,
    blnFecharForm : Boolean;
    blnFinalizouFormShow : Boolean;
    FCfgTela: TCfgTelaImpulsionadorVendasCRM;
    procedure pIniciarDados;
    procedure pAdicionarColunaPreVisualizacao(intIndex: Integer; recCol: TrecColGrid);
    procedure pAdicionarColunaExibicaoEOrdem(recCol: TrecColGrid);
    procedure pMarcarColunasExibicao(blnMarcar: Boolean);
    procedure pAlteraOrdemColuna(blnSobe: Boolean);
    procedure pIndexarColunasVisiveis;
    procedure pVisibilidadeColuna;
    procedure pAjustaColunasDeExibicao;
    procedure pOrdenaColunas(DataSet: TDataSet);
    procedure pAlteraOrdemRegistros(blnSobe: Boolean);
    procedure pMoverParaCima;
    procedure pMoverParaBaixo;
    procedure pCarregaCoresGrid;
    procedure pSetarCoresGrid;
    procedure pGravaCoresGrid;
    procedure pRestaurarCoresGrid;
    procedure pCarregaOrd;
    function fGetWidthAtualGrid: Integer;
    function fGetWidthGrid: Integer;
  public
    blnConfirma : Boolean;
  End;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmConfigImpulsuonadorVendasCRM.FormClose(Sender: TObject;
  var Action: TCloseAction);
Begin
  inherited;

  If Assigned(FCfgTela) Then
    FreeAndNil(FCfgTela);
End;

procedure TfrmConfigImpulsuonadorVendasCRM.FormCreate(Sender: TObject);
Begin
  inherited;

  blnColOrd := False;
  blnFinalizouFormShow := False;
  blnFecharForm := False;
  blnConfirma := False;
  cdsColExi.CreateDataSet;
  cdsColExi.IndexFieldNames := 'ORDCAM';
  cdsColOrd.CreateDataSet;
  cdsColOrd.IndexFieldNames := 'ORDCAM';
  FCfgTela := TCfgTelaImpulsionadorVendasCRM.Create;

  pCarregaOrd;
  Application.ProcessMessages;
  WindowState := wsMaximized;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.FormShow(Sender: TObject);
Begin
  inherited;

  pgcCfg.ActivePageIndex := 0;

  try
    FCfgTela.Sugestao.pCarregarTamanhoFonteObj;
    speTamanhoFonteConfig.Value := FCfgTela.Sugestao.TamanhoFonte;

    If cxgColunas.Font.Size <= 0 Then
    Begin
      speTamanhoFonteConfig.Value := FCfgTela.TamanhoFontePadrao;
    End;

    dtsVis.DataSet := frmImpulsionadorVendasCRM.grdResumoVendasView.DataController.DataSet;
    pIniciarDados;
    blnFinalizouFormShow := True;

    Self.Repaint;
    Application.ProcessMessages;

  except
    On Erro: Exception  Do
    Begin
      pMensagensErro(Erro.Message,'[TfrmConfigImpulsuonadorVendasCRM.FormShow]');
    End;
  End;

End;

procedure TfrmConfigImpulsuonadorVendasCRM.btnDesmarcaTodosClick(Sender: TObject);
Begin
  inherited;

  pMarcarColunasExibicao(False);
  pAjustaColunasDeExibicao;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.btnDownClick(Sender: TObject);
Begin
  inherited;

  pAlteraOrdemColuna(False);
  pIndexarColunasVisiveis;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.btnGravarClick(Sender: TObject);
Begin
  inherited;

  FCfgTela.pGravarDadosNoBanco(dbgVisDBView, cdsColOrd);
  FCfgTela.Sugestao.pGravarFonteGrid(speTamanhoFonteConfig.Value);
  pGravaCoresGrid;
  blnConfirma := True;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.btnMarcaTodosClick(Sender: TObject);
Begin
  inherited;

  pMarcarColunasExibicao(True);
  pAjustaColunasDeExibicao;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.btnPadroesClick(Sender: TObject);
Begin
  inherited;

  FCfgTela.pSetarPadrao(dbgVisDbView);
  pAjustaColunasDeExibicao;
  FCfgTela.Sugestao.pGravarFonteGrid(FCfgTela.TamanhoFontePadrao);
  speTamanhoFonteConfig.Value := FCfgTela.TamanhoFontePadrao;
  pRestaurarCoresGrid;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.pCarregaCoresGrid;
Begin
  FCfgTela.Sugestao.pCarregarCoresGrid('grdResumoVendas');

  ccbCorFontePadrao.Properties.Value := FCfgTela.Sugestao.CorFonteLinha;
  ccbFonteLinhaSelecionada.Properties.Value := FCfgTela.Sugestao.CorFonteLinhaSelecionada;
  ccbFundoLinhaGrid.Properties.Value := FCfgTela.Sugestao.CorFundoLinha;
  ccbFundoLinhaSelecionada.Properties.Value := FCfgTela.Sugestao.CorFundoLinhaSelecionada;
  ccbFonteColunaQtdIte.Properties.Value := FCfgTela.Sugestao.CorFonteColunaQtdIte;
  ccbFonteColunaUniTar.Properties.Value := FCfgTela.Sugestao.CorFonteColunaUniTar;
  ccbFundoColunaQtdIte.Properties.Value := FCfgTela.Sugestao.CorFundoColunaQtdIte;
  ccbFundoColunaUniTar.Properties.Value := FCfgTela.Sugestao.CorFundoColunaUniTar;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.pCarregaOrd;
const
  SQLSelect = 'SELECT * FROM ORDCOL  ' +
              ' WHERE  ' +
              '   ORD_CODEMP = :CODEMP   ' +
              '   AND ORD_NOMFOR = :NOMFOR ' +
              ' ORDER BY ORD_ORDCAM ';
var
  qryTmp : TUniQuery;
Begin
  Try
    qryTmp := fCriaQuery;
    qryTmp.DisableControls;
    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add(SQLSelect);
    qryTmp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTmp.ParamByName('NOMFOR').AsString := FCfgTela.nomeFormulario;
    qryTmp.Open;

    cdsColOrd.DisableControls;
    try

      While not qryTmp.eof do
      Begin
        cdsColOrd.Insert;
        cdsColOrd.FieldByName('ORDNAM').AsString  := qryTmp.FieldByName('ORD_ORDNAM').AsString ;
        cdsColOrd.FieldByName('ORDCAP').AsString  := qryTmp.FieldByName('ORD_ORDCAP').AsString ;
        cdsColOrd.FieldByName('ORDCAM').AsInteger := qryTmp.FieldByName('ORD_ORDCAM').AsInteger;
        cdsColOrd.FieldByName('ORDDSC').AsString  := qryTmp.FieldByName('ORD_ORDDSC').AsString ;
        cdsColOrd.Post;

        qryTmp.Next;
      End;
    finally
      cdsColOrd.EnableControls;
    end;

  Finally
    FreeAndNil(qryTmp);
  End;

End;

procedure TfrmConfigImpulsuonadorVendasCRM.pGravaCoresGrid;
Begin
  pSetarCoresGrid;
  FCfgTela.Sugestao.pGravarCoresGrid('grdResumoVendas');
End;

procedure TfrmConfigImpulsuonadorVendasCRM.btnRightClick(Sender: TObject);
var
  intOrd: Integer;
Begin
  inherited;

  intOrd := cdsColOrd.RecordCount;
  If not cdsColOrd.locate('ORDNAM', cdsColExi.FieldByName('COLNAM').AsString, []) Then
  Begin
    Inc(intOrd);
    cdsColOrd.Insert;
    cdsColOrd.FieldByName('ORDNAM').AsString  := cdsColExi.FieldByName('COLNAM').AsString ;
    cdsColOrd.FieldByName('ORDCAP').AsString  := cdsColExi.FieldByName('COLCAP').AsString ;
    cdsColOrd.FieldByName('ORDCAM').AsInteger := intOrd;
    cdsColOrd.FieldByName('ORDDSC').AsString  := 'N' ;
    cdsColOrd.Post;

    pOrdenaColunas(frmImpulsionadorVendasCRM.grdResumoVendasView.DataController.DataSet);
  End;

End;

procedure TfrmConfigImpulsuonadorVendasCRM.pAlteraOrdemRegistros(blnSobe: Boolean);
var
  strCodAtu: String;
Begin
  If cdsColOrd.RecordCount < 2 Then
    Exit;

  If blnSobe Then
  Begin
    If (cdsColOrd.FieldByName('ORDCAM').AsInteger = 1) Then
      Exit;
  End;

  If (Not blnSobe) Then
  Begin
    If (cdsColOrd.FieldByName('ORDCAM').AsInteger = cdsColExi.RecordCount) Then
      Exit;
  End;

  cdsColOrd.DisableControls;
  Try
    strCodAtu := cdsColOrd.FieldByName('ORDNAM').AsString;

    If blnSobe Then
    Begin
      cdsColOrd.Prior;
      cdsColOrd.Edit;
      cdsColOrd.FieldByName('ORDCAM').AsInteger := Succ(cdsColOrd.FieldByName('ORDCAM').AsInteger);
      cdsColOrd.Post;

      If cdsColOrd.Locate('ORDNAM', strCodAtu, []) Then
      Begin
        cdsColOrd.Edit;
        cdsColOrd.FieldByName('ORDCAM').AsInteger := Pred(cdsColOrd.FieldByName('ORDCAM').AsInteger);
        cdsColOrd.Post;
      End;
    End
    Else
    Begin
      cdsColOrd.Next;
      cdsColOrd.Edit;
      cdsColOrd.FieldByName('ORDCAM').AsInteger := Pred(cdsColOrd.FieldByName('ORDCAM').AsInteger);
      cdsColOrd.Post;

      If cdsColOrd.Locate('ORDNAM', strCodAtu, []) Then
      Begin
        cdsColOrd.Edit;
        cdsColOrd.FieldByName('ORDCAM').AsInteger := Succ(cdsColOrd.FieldByName('ORDCAM').AsInteger);
        cdsColOrd.Post;
      End;
    End;
  Finally
    cdsColOrd.EnableControls;
  End;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.btnUpOrdClick(Sender: TObject);
Begin
  inherited;

  pAlteraOrdemRegistros(True);
  pOrdenaColunas(frmImpulsionadorVendasCRM.grdResumoVendasView.DataController.DataSet);
End;

procedure TfrmConfigImpulsuonadorVendasCRM.btnDownOrdClick(Sender: TObject);
Begin
  inherited;

  pAlteraOrdemRegistros(False);
  pOrdenaColunas(frmImpulsionadorVendasCRM.grdResumoVendasView.DataController.DataSet);
End;

procedure TfrmConfigImpulsuonadorVendasCRM.btnLeftClick(Sender: TObject);
Begin
  inherited;

  If not cdsColOrd.isEmpty Then
  Begin
    cdsColOrd.Delete;
    pOrdenaColunas(frmImpulsionadorVendasCRM.grdResumoVendasView.DataController.DataSet);
  End;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.pOrdenaColunas(DataSet: TDataSet);
var
  cdsOrd, cdsColOrdBkp: TUniClientDataSet;
  strFields: String;
  strDescFields: String;
  strBookMark : TBookMark;
  Index: TIndexDef;
  intField: Integer;
Begin

  cdsOrd := TUniClientDataSet( DataSet );

  cdsColOrdBkp := TUniClientDataSet.Create(Self);
  cdsColOrdBkp.Data := cdsOrd.data;

  cdsOrd.IndexDefs.Clear;
  cdsOrd.IndexName := '';
  cdsOrd.StoreDefs := False;
  cdsOrd.IndexFieldNames := '';

  If not cdsColOrd.isEmpty Then
  Begin
    strBookMark := cdsColOrd.GetBookMark;
    cdsColOrd.DisableControls;
    cdsColOrd.first;
    While not cdsColOrd.eof do
    Begin
      If cdsColOrd.FieldByName('ORDDSC').AsString = 'S' Then
      Begin
        If fEmptyStr(strDescFields) Then
          strDescFields := cdsColOrd.FieldByName('ORDNAM').AsString
        Else
          strDescFields := strFields + ';' + cdsColOrd.FieldByName('ORDNAM').AsString ;
      End;

      If fEmptyStr(strFields) Then
        strFields := cdsColOrd.FieldByName('ORDNAM').AsString
      Else
        strFields := strFields + ';' + cdsColOrd.FieldByName('ORDNAM').AsString ;

      cdsColOrd.Next;
    End;
    cdsColOrd.EnableControls;
    cdsColOrd.BookMark := strBookMark;

    cdsOrd.Active := false;
    Index:= cdsOrd.IndexDefs.AddIndexDef;
    Index.Name   := 'IDX_001';
    Index.Fields := strFields;
    Index.DescFields := strDescFields;

    cdsOrd.IndexName := 'IDX_001';

    cdsOrd.CreateDataSet;
    cdsOrd.Data := cdsColOrdBkp.Data;

    For intField := 0 To cdsOrd.Fields.Count -1 Do
      Begin
        If cdsOrd.Fields[intField].DataType = ftFloat Then
          TFloatField(cdsOrd.Fields[intField]).DisplayFormat := '#,##0.00';
      End;
  End;

End;

procedure TfrmConfigImpulsuonadorVendasCRM.pRestaurarCoresGrid;
Begin
  FCfgTela.Sugestao.pRestaurarCoresPadraoGrid;
  pCarregaCoresGrid;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.pSetarCoresGrid;
Begin
  FCfgTela.Sugestao.CorFonteLinha := ccbCorFontePadrao.Properties.Value;
  FCfgTela.Sugestao.CorFonteLinhaSelecionada := ccbFonteLinhaSelecionada.Properties.Value;
  FCfgTela.Sugestao.CorFundoLinha := ccbFundoLinhaGrid.Properties.Value;
  FCfgTela.Sugestao.CorFundoLinhaSelecionada := ccbFundoLinhaSelecionada.Properties.Value;
  FCfgTela.Sugestao.CorFonteColunaQtdIte := ccbFonteColunaQtdIte.Properties.Value;
  FCfgTela.Sugestao.CorFundoColunaQtdIte := ccbFundoColunaQtdIte.Properties.Value;
  FCfgTela.Sugestao.CorFonteColunaUniTar := ccbFonteColunaUniTar.Properties.Value;
  FCfgTela.Sugestao.CorFundoColunaUniTar := ccbFundoColunaUniTar.Properties.Value;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.btnUpClick(Sender: TObject);
Begin
  inherited;

  pAlteraOrdemColuna(True);
  pIndexarColunasVisiveis;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.cdsColOrdAfterPost(DataSet: TDataSet);
Begin
  inherited;

  If blnColOrd Then
  Begin
    pOrdenaColunas(frmImpulsionadorVendasCRM.grdResumoVendasView.DataController.DataSet);
    blnColOrd := False;
  End;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.cxgColunasTableView1EXIBIRPropertiesEditValueChanged(
  Sender: TObject);
Begin
  inherited;

  pVisibilidadeColuna;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.cxGridDBColumn3PropertiesEditValueChanged(
  Sender: TObject);
Begin
  inherited;

  If cdsColOrd.State = dsEdit Then
  Begin
    blnColOrd := True;
    cdsColOrd.Post;
  End;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.cxVerticalGrid1Exit(Sender: TObject);
Begin
  inherited;

  pSetarCoresGrid;
  dbgVisDB.Refresh;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.dbgVisColumnMoved(Sender: TObject; FromIndex,
  ToIndex: Integer);
Begin
  inherited;

  pAjustaColunasDeExibicao;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.dbgVisDBViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Begin
  inherited;

  If Not blnFinalizouFormShow Then
    Exit;

  gagAreGrid.Progress := fGetWidthAtualGrid;

  If AViewInfo.GridRecord.Selected Then
  Begin
    TCfgTelaImpulsionadorVendasCRM.pFormatarCelula(ACanvas,
                                                   FCfgTela.Sugestao.CorFonteLinhaSelecionada,
                                                   FCfgTela.Sugestao.CorFundoLinhaSelecionada,
                                                   False);
  End
  Else
  Begin
    TCfgTelaImpulsionadorVendasCRM.pFormatarCelula(ACanvas,
                                                   FCfgTela.Sugestao.CorFonteLinha,
                                                   FCfgTela.Sugestao.CorFundoLinha,
                                                   False);
  End;

  If (TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName = 'UNITAR') Then
  Begin
    TCfgTelaImpulsionadorVendasCRM.pFormatarCelula(ACanvas,
                                                   FCfgTela.Sugestao.CorFonteColunaUniTar,
                                                   FCfgTela.Sugestao.CorFundoColunaUniTar,
                                                   AViewInfo.GridRecord.Selected);
  End;

  If (TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName = 'QTDITE') Then
  Begin
    TCfgTelaImpulsionadorVendasCRM.pFormatarCelula(ACanvas,
                                                   FCfgTela.Sugestao.CorFonteColunaQtdIte,
                                                   FCfgTela.Sugestao.CorFundoColunaQtdIte,
                                                   AViewInfo.GridRecord.Selected);
  End;

End;

function TfrmConfigImpulsuonadorVendasCRM.fGetWidthGrid: Integer;
Var
  intCnt : Integer;
Begin
  Result := 0;
  For intCnt := 0 To dbgVisDBView.ColumnCount -1 Do
  Begin
    Result := Result + dbgVisDBView.Columns[intCnt].Width;
  End;
End;

function TfrmConfigImpulsuonadorVendasCRM.fGetWidthAtualGrid: Integer;
Var
  intCnt : Integer;
Begin
  Result := 0;
  For intCnt := 0 To dbgVisDBView.ColumnCount -1 Do
  Begin
    If (dbgVisDBView.Columns[intCnt].Visible) Then
      Result := Result + dbgVisDBView.Columns[intCnt].Width;
  End;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.FormPaint(Sender: TObject);
Begin
  inherited;

  If blnFecharForm Then
    Close;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.pIniciarDados;
Var
  intCnt: Integer;
  recCol: TrecColGrid;
Begin
  FCfgTela.pIniciar(frmImpulsionadorVendasCRM.grdResumoVendas, frmImpulsionadorVendasCRM.grdResumoVendasView);


  dtsVis.DataSet.DisableControls;
  dbgVisDB.BeginUpdate();
  cxgColunas.BeginUpdate();
  cxgColunasOrdenacao.BeginUpdate();

  Try
    For intCnt := Low(FCfgTela.arrColsOri) To High(FCfgTela.arrColsOri) Do
    Begin
      recCol:= FCfgTela.arrColsOri[intCnt];
      pAdicionarColunaExibicaoEOrdem(recCol);
      pAdicionarColunaPreVisualizacao(intCnt, recCol);
    End;


    FCfgTela.pSetarUltimosDadosCarregados(dbgVisDBView);
    FCfgTela.pConfigurarGrid(dbgVisDBView);

    cdsColExi.First;
    gagAreGrid.MaxValue := fGetWidthGrid;

    pCarregaCoresGrid;

  Finally
    dtsVis.DataSet.EnableControls;
    dbgVisDB.EndUpdate;
    cxgColunas.EndUpdate;
    cxgColunasOrdenacao.EndUpdate;
    Application.ProcessMessages;
  End;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.pVisibilidadeColuna;
Var
  Column: TcxGridDBColumn;
Begin
  inherited;

  If (Not fEmptyStr(cdsColExi.FieldByName('COLNAM').AsString)) Then
  Begin
    Column := TcxGridDBColumnHelper.fFindColumnByNameView(dbgVisDBView, cdsColExi.FieldByName('COLNAM').AsString);

    If (Column <> Nil) Then
      Column.Visible := (cdsColExi.FieldByName('EXIBIR').AsString = 'S');
  End;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.speTamanhoFonteConfigChange(Sender: TObject);
Begin
  inherited;

  If speTamanhoFonteConfig.Value <= 0 Then
  Begin
    speTamanhoFonteConfig.Value := 1;
  End;

  cxgColunas.Font.Size := speTamanhoFonteConfig.Value;
  cxgColunasOrdenacao.Font.Size := speTamanhoFonteConfig.Value;
  dbgVisDB.Font.Size  := speTamanhoFonteConfig.Value;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.pAdicionarColunaExibicaoEOrdem(recCol: TrecColGrid);
Begin
  cdsColExi.Append;
  cdsColExi.FieldByName('EXIBIR').AsString := IIF(recCol.blnVisible, 'S', 'N');
  cdsColExi.FieldByName('ORDCAM').AsInteger := recCol.intIndex + 1;
  cdsColExi.FieldByName('COLCAP').AsString := recCol.strCaption;
  cdsColExi.FieldByName('COLNAM').AsString := recCol.strFieldName;
  cdsColExi.Post;
  cdsColExi.First;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.pAdicionarColunaPreVisualizacao(intIndex: Integer; recCol: TrecColGrid);
Begin
  dbgVisDBView.CreateColumn;
  Try
    dbgVisDBView.Columns[intIndex].DataBinding.FieldName := recCol.strFieldName;
    dbgVisDBView.Columns[intIndex].Caption   := recCol.strCaption;
    dbgVisDBView.Columns[intIndex].Width     := recCol.intWidth;
    dbgVisDBView.Columns[intIndex].Visible   := recCol.blnVisible;
    If recCol.blnCheckBox Then
    Begin
      dbgVisDBView.Columns[intIndex].PropertiesClass := TcxCheckBoxProperties;
      TcxCheckBoxProperties(dbgVisDBView.Columns[intIndex].Properties).ValueChecked := 1;
      TcxCheckBoxProperties(dbgVisDBView.Columns[intIndex].Properties).ValueUnChecked := 0;
    End;
  Except
    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmConfigImpulsuonadorVendasCRM.pAdicionarColunaPreVisualizacao]');
    End;
  End;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.pMoverParaBaixo;
var
  strCodAtu: String;
Begin
  If (cdsColExi.FieldByName('ORDCAM').AsInteger = cdsColExi.RecordCount) Then
    Exit;

  cdsColExi.DisableControls;
  Try
    strCodAtu := cdsColExi.FieldByName('COLNAM').AsString;

    cdsColExi.Next;
    cdsColExi.Edit;
    cdsColExi.FieldByName('ORDCAM').AsInteger := Pred(cdsColExi.FieldByName('ORDCAM').AsInteger);
    cdsColExi.Post;

    If cdsColExi.Locate('COLNAM', strCodAtu, []) Then
    Begin
      cdsColExi.Edit;
      cdsColExi.FieldByName('ORDCAM').AsInteger := Succ(cdsColExi.FieldByName('ORDCAM').AsInteger);
      cdsColExi.Post;
    End;

  Finally
    cdsColExi.EnableControls;
  End;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.pMoverParaCima;
var
  strCodAtu: String;
Begin
  If (cdsColExi.FieldByName('ORDCAM').AsInteger = 1) Then
    Exit;

  cdsColExi.DisableControls;
  Try
    strCodAtu := cdsColExi.FieldByName('COLNAM').AsString;
    cdsColExi.Prior;
    cdsColExi.Edit;
    cdsColExi.FieldByName('ORDCAM').AsInteger := Succ(cdsColExi.FieldByName('ORDCAM').AsInteger);
    cdsColExi.Post;

    If cdsColExi.Locate('COLNAM', strCodAtu, []) Then
    Begin
      cdsColExi.Edit;
      cdsColExi.FieldByName('ORDCAM').AsInteger := Pred(cdsColExi.FieldByName('ORDCAM').AsInteger);
      cdsColExi.Post;
    End;
  Finally
    cdsColExi.EnableControls;
  End;

End;


procedure TfrmConfigImpulsuonadorVendasCRM.pAlteraOrdemColuna(blnSobe: Boolean);
Begin
  If cdsColExi.RecordCount < 2 Then
    Exit;

  If blnSobe Then
    pMoverParaCima
  Else
    pMoverParaBaixo;

End;

procedure TfrmConfigImpulsuonadorVendasCRM.pIndexarColunasVisiveis;
Var
  Column : TcxGridDBColumn;
  intRecNo : Integer;
Begin
  cdsColExi.DisableControls;
  intRecNo := cdsColExi.RecNo;
  Try
    cdsColExi.First;
    While Not cdsColExi.Eof Do
    Begin
      Column :=  TcxGridDBColumnHelper.fFindColumnByNameView(dbgVisDBView, cdsColExi.FieldByName('COLNAM').AsString);

      If (Column <> Nil) Then
        Column.Index := cdsColExi.FieldByName('ORDCAM').AsInteger - 1;

      cdsColExi.Next;
    End;
    cdsColExi.First;
  Finally
    cdsColExi.RecNo := intRecNo;
    cdsColExi.EnableControls;
  End;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.pMarcarColunasExibicao(blnMarcar: Boolean);
var
  intRecNo: Integer;
Begin
  cdsColExi.DisableControls;
  intRecNo := cdsColExi.RecNo;
  Try
    cdsColExi.First;

    While Not cdsColExi.Eof do
    Begin
      cdsColExi.Edit;
      If blnMarcar Then
        cdsColExi.FieldByName('EXIBIR').AsString :=  'S'
      Else
        cdsColExi.FieldByName('EXIBIR').AsString :=  'N';
      cdsColExi.Post;

      pVisibilidadeColuna;

      cdsColExi.Next;
    End;

    cdsColExi.First;
  Finally
    cdsColExi.RecNo := intRecNo;
    cdsColExi.EnableControls;
  End;
End;

procedure TfrmConfigImpulsuonadorVendasCRM.pAjustaColunasDeExibicao;
Var
  intCnt : Integer;
  intRecNo : Integer;
Begin
  intRecNo := cdsColExi.RecNo;
  cdsColExi.DisableControls;
  Try
    For intCnt := 0 To dbgVisDBView.ColumnCount -1 Do
    Begin
      If cdsColExi.Locate('COLNAM', dbgVisDBView.Columns[intCnt].DataBinding.FieldName, []) Then
      Begin
        cdsColExi.Edit;
        cdsColExi.FieldByName('ORDCAM').AsInteger := intCnt + 1;
        cdsColExi.FieldByName('EXIBIR').AsString := IIF(dbgVisDBView.Columns[intCnt].Visible, 'S', 'N');
        cdsColExi.Post;
      End;
    End;
  Finally
    cdsColExi.RecNo := intRecNo;
    cdsColExi.EnableControls;
  End;
End;


End.
