unit untConfigEtiqProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Data.DB, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Vcl.Samples.Spin, Vcl.Samples.Gauges, Vcl.Grids, Vcl.DBGrids, DBGridCitel,
  Datasnap.DBClient, UniClientDataSet, untImpEtiquetas, untCfgColEtiqItens, Uni, untcxGridDBColumnHelper;

type
  TfrmConfigEtiqProduto = class(TfrmPai)
    pnlGrdExp: TPanel;
    pnlAreaVis: TPanel;
    pnlCfgCol: TPanel;
    btnUp: TSpeedButton;
    btnDown: TSpeedButton;
    btnMarcaTodos: TBitBtnLocked;
    cxgColunas: TcxGridCitel;
    cxgColunasTableView1: TcxGridDBTableViewCitel;
    cxgColunasTableView1EXIBIR: TcxGridDBColumn;
    cxgColunasTableView1COLCAP: TcxGridDBColumn;
    cxgColunasTableView1ORDCAM: TcxGridDBColumn;
    cxgColunasTableView1COLNAM: TcxGridDBColumn;
    cxgColunasLevel1: TcxGridLevel;
    cdsColEti: TUniClientDataSet;
    cdsColEtiEXIBIR: TStringField;
    cdsColEtiCOLCAP: TStringField;
    cdsColEtiCOLNAM: TStringField;
    cdsColEtiORDCAM: TIntegerField;
    cdsColEtiCOLTAM: TIntegerField;
    dtsCfgCol: TDataSource;
    dtsVisEti: TDataSource;
    btnGravar: TBitBtnLocked;
    btnPadroes: TBitBtnLocked;
    cdsColOrd: TUniClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    IntegerField1: TIntegerField;
    StringField3: TStringField;
    dtsColOrd: TDataSource;
    dbgVisRom: TcxGrid;
    dbgVisEtiDBView: TcxGridDBTableView;
    cxGridLevel2: TcxGridLevel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnPadroesClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure cxgColunasTableView1EXIBIRPropertiesEditValueChanged(Sender: TObject);
  private
    { Private declarations }
    blnFinalizouFormShow  : Boolean;
    blnFecharForm : Boolean;
    blnColOrd   : Boolean;
    procedure pCarregaOrdEti;
    procedure pMarcarColunasExibicao(blnMarcar: Boolean);
    procedure pVisibilidadeColuna;
    procedure pAjustaColunasDeExibicao;
    procedure pAlteraOrdemColuna(blnSobe: Boolean);
    procedure pIndexarColunasVisiveis;

    procedure pIniciarDados;
    function fValidarAlterarColunaSubir(blnSobe: Boolean) : Boolean;
    function fValidarAlterarColunaDescer(blnSobe: Boolean) : Boolean;
    procedure pAlteraOrdemColunaSubirDescer(blnSobe: Boolean);
    procedure pAlteraOrdemColunaSubir;
    procedure pAlteraOrdemColunaDescer;
    procedure pAdicionarColunaExibicaoEOrdem(recColEtiqItens: TrecColEtiqItens);
    procedure pAdicionarColunaPreVisualizacao(intIndex: Integer; recColEtiqItens: TrecColEtiqItens);
    function fExisteColunaVisivel: boolean;
  public
    { Public declarations }
    frmImpEtiquetas : TfrmImpEtiquetas;
    blnConfirma : Boolean;

  end;

implementation

uses
  untFuncoesSimples;


{$R *.dfm}

procedure TfrmConfigEtiqProduto.btnDownClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemColuna(False);
  pIndexarColunasVisiveis;
end;

procedure TfrmConfigEtiqProduto.btnGravarClick(Sender: TObject);
  Var
    arrCol : TArrayOfColEtiqItens;
begin
  inherited;

  if not fExisteColunaVisivel then
  begin
    fMensagem('', 'Não é possível salvar a configuração com nenhuma coluna visível.', ['&OK']);
    blnConfirma := false;
  end
  else
  begin
    TCfgColEtiqItens.pSalvarEstado(dbgVisEtiDBView, arrCol);
    TCfgColEtiqItens.pGravarDadosNoBanco(arrCol, cdsColOrd);
    blnConfirma := True;
  end;

end;

procedure TfrmConfigEtiqProduto.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarColunasExibicao(True);
  pAjustaColunasDeExibicao;
end;

procedure TfrmConfigEtiqProduto.btnPadroesClick(Sender: TObject);
begin
  inherited;
  TCfgColEtiqItens.pSetarPadrao(dbgVisEtiDBView);
  pAjustaColunasDeExibicao;
end;

procedure TfrmConfigEtiqProduto.btnUpClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemColuna(True);
  pIndexarColunasVisiveis;
end;

procedure TfrmConfigEtiqProduto.cxgColunasTableView1EXIBIRPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  pVisibilidadeColuna;
end;

function TfrmConfigEtiqProduto.fExisteColunaVisivel: boolean;
begin
  result := false;
  cdsColEti.DisableControls;
  cdsColEti.First;
  while not cdsColEti.Eof do
  begin
    if (cdsColEtiEXIBIR.AsString = 'S') then
      result := true;
    cdsColEti.Next;
  end;
  cdsColEti.EnableControls;
end;

procedure TfrmConfigEtiqProduto.FormCreate(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;
  blnColOrd := False;
  blnFinalizouFormShow := False;
  blnFecharForm := False;
  blnConfirma := False;

  cdsColEti.CreateDataSet;
  cdsColEti.IndexFieldNames := 'ORDCAM';

  cdsColOrd.CreateDataSet;
  cdsColOrd.IndexFieldNames := 'ORDCAM';

  pCarregaOrdEti;

end;

procedure TfrmConfigEtiqProduto.FormShow(Sender: TObject);
begin
  inherited;
  dtsVisEti.DataSet := frmImpEtiquetas.dbgEtiquetasTableView.DataController.DataSet;
  pIniciarDados;
  blnFinalizouFormShow := True;
end;

function TfrmConfigEtiqProduto.fValidarAlterarColunaDescer(blnSobe: Boolean): Boolean;
begin
  result := true;

  If Not (cdsColEti.FieldByName('ORDCAM').AsInteger = cdsColEti.RecordCount)Then
    Exit;

  if (blnSobe)then
    Exit;

  Result := false;

end;

function TfrmConfigEtiqProduto.fValidarAlterarColunaSubir(blnSobe: Boolean): Boolean;
begin
  Result := true;

  If Not (cdsColEti.FieldByName('ORDCAM').AsInteger = 1) then
    Exit;

  If not blnSobe then
    exit;

  Result := false;
end;

procedure TfrmConfigEtiqProduto.pAdicionarColunaExibicaoEOrdem(recColEtiqItens: TrecColEtiqItens);
begin
  cdsColEti.Append;
  cdsColEti.FieldByName('EXIBIR').AsString  := IIF(recColEtiqItens.blnVisible, 'S', 'N');
  cdsColEti.FieldByName('ORDCAM').AsInteger := recColEtiqItens.intIndex + 1;
  cdsColEti.FieldByName('COLCAP').AsString  := recColEtiqItens.strCaption;
  cdsColEti.FieldByName('COLNAM').AsString  := recColEtiqItens.strFieldName;
  cdsColEti.Post;
  cdsColEti.First;

end;

procedure TfrmConfigEtiqProduto.pAjustaColunasDeExibicao;
  Var
    intCnt : Integer;
    intRecNo : Integer;
begin
  intRecNo := cdsColEti.RecNo;
  cdsColEti.DisableControls;
  Try
    For intCnt := 0 To dbgVisEtiDBView.ColumnCount-1 Do
    begin
      If cdsColEti.Locate('COLNAM', dbgVisEtiDBView.Columns[intCnt].DataBinding.FieldName, []) Then
      begin
        cdsColEti.Edit;
        cdsColEti.FieldByName('ORDCAM').AsInteger := intCnt + 1;
        cdsColEti.FieldByName('EXIBIR').AsString := IIF(dbgVisEtiDBView.Columns[intCnt].Visible, 'S', 'N');
        cdsColEti.Post;
      end;
    end;
  Finally
    cdsColEti.RecNo := intRecNo;
    cdsColEti.EnableControls;
  End;

end;

procedure TfrmConfigEtiqProduto.pAlteraOrdemColuna(blnSobe: Boolean);
begin
  If cdsColEti.RecordCount < 2 then
    Exit;

  If Not fValidarAlterarColunaSubir(blnSobe)Then
    Exit;

  If Not fValidarAlterarColunaDescer(blnSobe) then
    Exit;


  pAlteraOrdemColunaSubirDescer(blnSobe);
end;

procedure TfrmConfigEtiqProduto.pAlteraOrdemColunaDescer;
Var
  strCodAtu: String;
Begin
  cdsColEti.DisableControls;

  Try
    strCodAtu := cdsColEti.FieldByName('COLNAM').AsString;

    cdsColEti.Next;
    cdsColEti.Edit;
    cdsColEti.FieldByName('ORDCAM').AsInteger := Pred(cdsColEti.FieldByName('ORDCAM').AsInteger);
    cdsColEti.Post;

    If cdsColEti.Locate('COLNAM', strCodAtu, []) Then
    Begin
      cdsColEti.Edit;
      cdsColEti.FieldByName('ORDCAM').AsInteger := Succ(cdsColEti.FieldByName('ORDCAM').AsInteger);
      cdsColEti.Post;
    End;

  Finally
    cdsColEti.EnableControls;
  End;

end;

procedure TfrmConfigEtiqProduto.pAlteraOrdemColunaSubir;
  Var
    strCodAtu: String;
Begin
  cdsColEti.DisableControls;

  Try
    strCodAtu := cdsColEti.FieldByName('COLNAM').AsString;

    cdsColEti.Prior;
    cdsColEti.Edit;
    cdsColEti.FieldByName('ORDCAM').AsInteger := Succ(cdsColEti.FieldByName('ORDCAM').AsInteger);
    cdsColEti.Post;

    If cdsColEti.Locate('COLNAM', strCodAtu, []) Then
    Begin
      cdsColEti.Edit;
      cdsColEti.FieldByName('ORDCAM').AsInteger := Pred(cdsColEti.FieldByName('ORDCAM').AsInteger);
      cdsColEti.Post;
    End;

  Finally
    cdsColEti.EnableControls;
  End;
end;

procedure TfrmConfigEtiqProduto.pAlteraOrdemColunaSubirDescer(blnSobe: Boolean);
begin
  If blnSobe Then
  begin
    pAlteraOrdemColunaSubir;
    Exit;
  end;

  pAlteraOrdemColunaDescer;

end;

procedure TfrmConfigEtiqProduto.pCarregaOrdEti;
Var
  qryTmp : TUniQuery;
Begin
  Try
    qryTmp := fCriaQuery;
    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add('SELECT * FROM ORDETI         ');
    qryTmp.SQL.Add(' WHERE ETI_CODEMP = :CODEMP  ');
    qryTmp.SQL.Add(' ORDER BY ETI_ORDCAM ');
    qryTmp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTmp.Open;

    While not qryTmp.eof do
    Begin
      cdsColOrd.Insert;
      cdsColOrd.FieldByName('ORDNAM').AsString  := qryTmp.FieldByName('ETI_ORDNAM').AsString ;
      cdsColOrd.FieldByName('ORDCAP').AsString  := qryTmp.FieldByName('ETI_ORDCAP').AsString ;
      cdsColOrd.FieldByName('ORDCAM').AsInteger := qryTmp.FieldByName('ETI_ORDCAM').AsInteger ;
      cdsColOrd.FieldByName('ORDDSC').AsString  := qryTmp.FieldByName('ETI_ORDDSC').AsString ;
      cdsColOrd.Post;

      qryTmp.Next;
    End;
  Finally
    FreeAndNil(qryTmp);
  End;
end;

procedure TfrmConfigEtiqProduto.pIndexarColunasVisiveis;
  Var
    Column   : TcxGridDBColumn;
    intRecNo : Integer;
begin
  inherited;
  cdsColEti.DisableControls;
  intRecNo := cdsColEti.RecNo;
  Try
    cdsColEti.First;
    While Not cdsColEti.Eof Do
    Begin
      Column := TcxGridDBColumnHelper.fFindColumnByNameView(dbgVisEtiDBView, cdsColEti.FieldByName('COLNAM').AsString);

      If (Column <> Nil) Then
        Column.Index := cdsColEti.FieldByName('ORDCAM').AsInteger - 1;

      cdsColEti.Next;
    End;
    cdsColEti.First;
  Finally
    cdsColEti.RecNo := intRecNo;
    cdsColEti.EnableControls;
  End;

end;

procedure TfrmConfigEtiqProduto.pIniciarDados;
  Var
    intCnt    : Integer;
begin

  dtsVisEti.DataSet.DisableControls;
  Try
    For intCnt := Low(TCfgColEtiqItens.arrColsOri) To High(TCfgColEtiqItens.arrColsOri) Do
    Begin
      If TCfgColEtiqItens.fUtilizarColuna(TCfgColEtiqItens.arrColsOri[intCnt].strFieldName) Then
        pAdicionarColunaExibicaoEOrdem(TCfgColEtiqItens.arrColsOri[intCnt])
      Else
        TCfgColEtiqItens.arrColsOri[intCnt].blnVisible := False;

      pAdicionarColunaPreVisualizacao(intCnt, TCfgColEtiqItens.arrColsOri[intCnt]);
    End;

    TCfgColEtiqItens.pSetarUltimosDadosCarregados(dbgVisEtiDBView);

    pAjustaColunasDeExibicao;
  Finally
    dtsVisEti.DataSet.EnableControls;
  End;
end;

procedure TfrmConfigEtiqProduto.pAdicionarColunaPreVisualizacao(intIndex: Integer;
  recColEtiqItens: TrecColEtiqItens);
begin
  dbgVisEtiDBView.CreateColumn;
  dbgVisEtiDBView.Columns[intIndex].DataBinding.FieldName := recColEtiqItens.strFieldName;
  dbgVisEtiDBView.Columns[intIndex].Caption   := recColEtiqItens.strCaption;
  dbgVisEtiDBView.Columns[intIndex].Width     := recColEtiqItens.intWidth;
  dbgVisEtiDBView.Columns[intIndex].Visible   := recColEtiqItens.blnVisible;
end;

procedure TfrmConfigEtiqProduto.pMarcarColunasExibicao(blnMarcar: Boolean);
  Var
    intRecNo : Integer;
begin
  cdsColEti.DisableControls;
  intRecNo := cdsColEti.RecNo;
  Try
    cdsColEti.First;

    While Not cdsColEti.Eof do
    Begin
      cdsColEti.Edit;

      If blnMarcar Then
        cdsColEti.FieldByName('EXIBIR').AsString :=  'S'
      Else
        cdsColEti.FieldByName('EXIBIR').AsString :=  'N';

      cdsColEti.Post;

      pVisibilidadeColuna;

      cdsColEti.Next;
    End;

    cdsColEti.First;
  Finally
    cdsColEti.RecNo := intRecNo;
    cdsColEti.EnableControls;
  End;
end;

procedure TfrmConfigEtiqProduto.pVisibilidadeColuna;
  Var
    Column : TcxGridDBColumn;
begin
  inherited;

  Column := TcxGridDBColumnHelper.fFindColumnByNameView(dbgVisEtiDBView, cdsColEti.FieldByName('COLNAM').AsString);

  If (Not fEmptyStr(cdsColEti.FieldByName('COLNAM').AsString)) Then
  Begin
    If (Column <> Nil) Then
      Column.Visible := (cdsColEti.FieldByName('EXIBIR').AsString = 'S');
  End;

end;

end.
