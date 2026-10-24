unit untConfigMostraDebCtrChq2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, untcxGridDBColumnHelper,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, cxColorComboBox, cxVGrid, cxInplaceContainer, Vcl.Samples.Spin,
  Vcl.Samples.Gauges, Vcl.Grids, Vcl.DBGrids, DBGridCitel, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGridCitel, cxGrid, Vcl.ComCtrls, cxExtEditRepositoryItems,
  Datasnap.DBClient, UniClientDataSet, untCfgColDebCtr, Uni, untMostraDebCtrChq2;

type
  TfrmConfigMostraDebCtrChq2 = class(TfrmPai)
    pgcCfgRom: TPageControl;
    tbsColunas: TTabSheet;
    pnlGrdCol: TPanel;
    cxgColunas: TcxGridCitel;
    cxgColunasTableView1: TcxGridDBTableViewCitel;
    cxgColunasTableView1EXIBIR: TcxGridDBColumn;
    cxgColunasTableView1COLCAP: TcxGridDBColumn;
    cxgColunasTableView1ORDCAM: TcxGridDBColumn;
    cxgColunasTableView1COLNAM: TcxGridDBColumn;
    cxgColunasLevel1: TcxGridLevel;
    pnlCfgCol: TPanel;
    btnUp: TSpeedButton;
    btnDown: TSpeedButton;
    btnUpOrd: TSpeedButton;
    btnDownOrd: TSpeedButton;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    cxgColunasOrdenacao: TcxGridCitel;
    cxgColunasOrdenacaoTableView1: TcxGridDBTableViewCitel;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    pnlCentral: TPanel;
    btnRight: TSpeedButton;
    btnLeft: TSpeedButton;
    pnlGrdRom: TPanel;
    btnGravar: TBitBtnLocked;
    btnPadroes: TBitBtnLocked;
    ApplicationEvents1: TApplicationEvents;
    frxCSVExportTestabilidade1: TfrxCSVExportTestabilidade;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    cdsColVisualizacao: TUniClientDataSet;
    cdsColVisualizacaoEXIBIR: TStringField;
    cdsColVisualizacaoCOLCAP: TStringField;
    cdsColVisualizacaoCOLNAM: TStringField;
    cdsColVisualizacaoORDCAM: TIntegerField;
    cdsColVisualizacaoCOLTAM: TIntegerField;
    dtsCfgCol: TDataSource;
    dtsColOrd: TDataSource;
    cdsColOrd: TUniClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    IntegerField1: TIntegerField;
    StringField3: TStringField;
    dtsVisualizacao: TDataSource;
    cxEditRepository1: TcxEditRepository;
    ccbCores: TcxEditRepositoryColorComboBox;
    dbgVisualizacao: TcxGridCitel;
    dbgVisualizacaoDBView: TcxGridDBTableViewCitel;
    cxGridLevel2: TcxGridLevel;
    procedure btnGravarClick(Sender: TObject);
    procedure btnPadroesClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnRightClick(Sender: TObject);
    procedure btnLeftClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnUpOrdClick(Sender: TObject);
    procedure btnDownOrdClick(Sender: TObject);
    procedure cdsColOrdAfterPost(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxgColunasTableView1EXIBIRPropertiesEditValueChanged(
      Sender: TObject);
    procedure cxGridDBColumn3PropertiesEditValueChanged(Sender: TObject);
  private
    { Private declarations }
    blnColOrd             : Boolean;
    blnFecharForm         : Boolean;
    blnFinalizouFormShow  : Boolean;

    procedure pIniciarDados;
    procedure pAdicionarColunaPreVisualizacao(intIndex: Integer; recColDebCtr: TrecColDebCtr);
    procedure pAdicionarColunaExibicaoEOrdem(recColDebCtr: TrecColDebCtr);
    procedure pMarcarColunasExibicao(blnMarcar: Boolean);

    procedure pAlteraOrdemColuna(blnSobe: Boolean);
    procedure pAlteraOrdemColunaSubirDescer(blnSobe: Boolean);
    function fValidarAlterarColunaSubir(blnSobe: Boolean) : Boolean;
    function fValidarAlterarColunaDescer(blnSobe: Boolean) : Boolean;

    procedure pAlteraOrdemColunaSubir;
    procedure pAlteraOrdemColunaDescer;

    procedure pIndexarColunasVisiveis;
    procedure pAjustaColunasDeExibicao;
    procedure pOrdenaColunas;
    function  fRetornarDescFields(strDescFields : String; strOrdNam : String; strFields : String) : String;
    function fRetornarFields(strFields : String; strOrdNam : String): String;

    procedure pGravarCdsOrdemDosRegistros(blnSobe: Boolean);
    procedure pGravarCdsOrdemDosRegistrosSubir;
    procedure pGravarCdsOrdemDosRegistrosDescer;

    procedure pAlteraOrdemRegistros(blnSobe: Boolean);
    procedure pCarregaOrdCtr;

    procedure pVisibilidadeColuna;
    function VerificarOrdenacaoSubir(blnSobe : Boolean) : Boolean;
    function VerificarOrdenacaoDescer(blnSobe : Boolean) : Boolean;
  public
    { Public declarations }
    frmMostraDebCtrChq2 : TfrmMostraDebCtrChq2;
    blnConfirma         : Boolean;
  end;

implementation

Uses
  untFuncoesSimples, untTypesSistema;

{$R *.dfm}

procedure TfrmConfigMostraDebCtrChq2.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarColunasExibicao(False);
  pAjustaColunasDeExibicao;
end;

procedure TfrmConfigMostraDebCtrChq2.btnDownClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemColuna(False);
  pIndexarColunasVisiveis;

end;

procedure TfrmConfigMostraDebCtrChq2.btnDownOrdClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemRegistros(False);
  pOrdenaColunas;
end;

procedure TfrmConfigMostraDebCtrChq2.btnGravarClick(Sender: TObject);
  Var
    arrCol : TArrayOfColDebCtr;
begin
  inherited;
  TCfgColDebCtr.pSalvarEstado(dbgVisualizacaoDBView, arrCol);
  TCfgColDebCtr.pGravarDadosNoBanco(arrCol, cdsColOrd);
  blnConfirma := True;
end;

procedure TfrmConfigMostraDebCtrChq2.btnLeftClick(Sender: TObject);
begin
  inherited;
  if not cdsColOrd.isEmpty then
  Begin
    cdsColOrd.Delete;
    pOrdenaColunas;
  End;

end;

procedure TfrmConfigMostraDebCtrChq2.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarColunasExibicao(True);
  pAjustaColunasDeExibicao;
end;

procedure TfrmConfigMostraDebCtrChq2.btnPadroesClick(Sender: TObject);
begin
  inherited;
  TCfgColDebCtr.pSetarPadrao(dbgVisualizacaoDbView);
  pAjustaColunasDeExibicao;
end;

procedure TfrmConfigMostraDebCtrChq2.btnRightClick(Sender: TObject);
var intOrd: Integer;
begin
  inherited;
  intOrd := cdsColOrd.RecordCount;
  if not cdsColOrd.locate('ORDNAM', cdsColVisualizacao.FieldByName('COLNAM').AsString, []) then
  Begin
    Inc(intOrd);
    cdsColOrd.Insert;
    cdsColOrd.FieldByName('ORDNAM').AsString  := cdsColVisualizacao.FieldByName('COLNAM').AsString ;
    cdsColOrd.FieldByName('ORDCAP').AsString  := cdsColVisualizacao.FieldByName('COLCAP').AsString ;
    cdsColOrd.FieldByName('ORDCAM').AsInteger := intOrd;
    cdsColOrd.FieldByName('ORDDSC').AsString  := 'N' ;
    cdsColOrd.Post;

    pOrdenaColunas;
  End;

end;

procedure TfrmConfigMostraDebCtrChq2.btnUpClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemColuna(True);
  pIndexarColunasVisiveis;

end;

procedure TfrmConfigMostraDebCtrChq2.btnUpOrdClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemRegistros(True);
  pOrdenaColunas;

end;

procedure TfrmConfigMostraDebCtrChq2.cdsColOrdAfterPost(DataSet: TDataSet);
begin
  inherited;
  if blnColOrd then
  Begin
    pOrdenaColunas;
    blnColOrd := False;
  End;

end;

procedure TfrmConfigMostraDebCtrChq2.cxgColunasTableView1EXIBIRPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  pVisibilidadeColuna;
end;

procedure TfrmConfigMostraDebCtrChq2.cxGridDBColumn3PropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  if cdsColOrd.State = dsEdit then
  begin
    blnColOrd := True;
    cdsColOrd.Post;
  End;
end;

procedure TfrmConfigMostraDebCtrChq2.FormCreate(Sender: TObject);
begin
  inherited;

  blnColOrd := False;
  blnFinalizouFormShow := False;
  blnFecharForm := False;
  blnConfirma := False;
  cdsColVisualizacao.CreateDataSet;
  cdsColVisualizacao.IndexFieldNames := 'ORDCAM';

  cdsColOrd.CreateDataSet;
  cdsColOrd.IndexFieldNames := 'ORDCAM';

  pCarregaOrdCtr;
end;

procedure TfrmConfigMostraDebCtrChq2.FormShow(Sender: TObject);
begin
  inherited;
  WindowState               := wsMaximized;
  pgcCfgRom.ActivePageIndex := 0;
  dtsVisualizacao.DataSet   := frmMostraDebCtrChq2.dbgDuplicatasDados.DataController.DataSet;
  pIniciarDados;
  blnFinalizouFormShow      := True;
end;

function TfrmConfigMostraDebCtrChq2.fRetornarDescFields(strDescFields, strOrdNam,
  strFields: String): String;
begin
  Result := strOrdNam;

  if fEmptyStr(strDescFields) then
    Exit;

  Result := strFields + ';' + strOrdNam ;
end;

function TfrmConfigMostraDebCtrChq2.fRetornarFields(strFields,
  strOrdNam: String): String;
begin
  Result := strOrdNam;

  if fEmptyStr(strFields) then
   Exit;

  Result := strFields + ';' + strOrdNam;
end;

function TfrmConfigMostraDebCtrChq2.fValidarAlterarColunaDescer(
  blnSobe: Boolean): Boolean;
begin
  result := true;

  If Not (cdsColVisualizacao.FieldByName('ORDCAM').AsInteger = cdsColVisualizacao.RecordCount)Then
    Exit;

  if (blnSobe)then
    Exit;

  Result := false;
end;

function TfrmConfigMostraDebCtrChq2.fValidarAlterarColunaSubir(
  blnSobe: Boolean): Boolean;
begin
  Result := true;

  If Not (cdsColVisualizacao.FieldByName('ORDCAM').AsInteger = 1) then
    Exit;

  If not blnSobe then
    exit;

  Result := false;

end;

procedure TfrmConfigMostraDebCtrChq2.pAdicionarColunaExibicaoEOrdem(
  recColDebCtr: TrecColDebCtr);
begin
  cdsColVisualizacao.Append;
  cdsColVisualizacao.FieldByName('EXIBIR').AsString  := IIF(recColDebCtr.blnVisible, 'S', 'N');
  cdsColVisualizacao.FieldByName('ORDCAM').AsInteger := recColDebCtr.intIndex + 1;
  cdsColVisualizacao.FieldByName('COLCAP').AsString  := recColDebCtr.strCaption;
  cdsColVisualizacao.FieldByName('COLNAM').AsString  := recColDebCtr.strFieldName;
  cdsColVisualizacao.Post;
  cdsColVisualizacao.First;

end;

procedure TfrmConfigMostraDebCtrChq2.pAdicionarColunaPreVisualizacao(intIndex: Integer;
  recColDebCtr: TrecColDebCtr);
begin
  dbgVisualizacaoDBView.CreateColumn;
  dbgVisualizacaoDBView.Columns[intIndex].DataBinding.FieldName := recColDebCtr.strFieldName;
  dbgVisualizacaoDBView.Columns[intIndex].Caption   := recColDebCtr.strCaption;
  dbgVisualizacaoDBView.Columns[intIndex].Width     := recColDebCtr.intWidth;
  dbgVisualizacaoDBView.Columns[intIndex].Visible   := recColDebCtr.blnVisible;
  dbgVisualizacaoDBView.Columns[intIndex].DataBinding.Field.Alignment := recColDebCtr.Alignment;
end;

procedure TfrmConfigMostraDebCtrChq2.pAjustaColunasDeExibicao;
  Var
    intCnt : Integer;
    intRecNo : Integer;
begin
  intRecNo := cdsColVisualizacao.RecNo;
  cdsColVisualizacao.DisableControls;
  Try
    For intCnt := 0 To dbgVisualizacaoDBView.ColumnCount-1 Do
    begin
      If cdsColVisualizacao.Locate('COLNAM', dbgVisualizacaoDBView.Columns[intCnt].DataBinding.FieldName, []) Then
      begin
        cdsColVisualizacao.Edit;
        cdsColVisualizacao.FieldByName('ORDCAM').AsInteger := intCnt + 1;
        cdsColVisualizacao.FieldByName('EXIBIR').AsString := IIF(dbgVisualizacaoDBView.Columns[intCnt].Visible, 'S', 'N');
        cdsColVisualizacao.Post;
      end;
    end;
  Finally
    cdsColVisualizacao.RecNo := intRecNo;
    cdsColVisualizacao.EnableControls;
  End;

end;

procedure TfrmConfigMostraDebCtrChq2.pAlteraOrdemColuna(blnSobe: Boolean);
Begin
  If cdsColVisualizacao.RecordCount < 2 then
    Exit;

  If Not fValidarAlterarColunaSubir(blnSobe)Then
    Exit;

  If Not fValidarAlterarColunaDescer(blnSobe) then
    Exit;


  pAlteraOrdemColunaSubirDescer(blnSobe);
end;

procedure TfrmConfigMostraDebCtrChq2.pAlteraOrdemColunaDescer;
Var
  strCodAtu: String;
Begin
  cdsColVisualizacao.DisableControls;

  Try
    strCodAtu := cdsColVisualizacao.FieldByName('COLNAM').AsString;

    cdsColVisualizacao.Next;
    cdsColVisualizacao.Edit;
    cdsColVisualizacao.FieldByName('ORDCAM').AsInteger := Pred(cdsColVisualizacao.FieldByName('ORDCAM').AsInteger);
    cdsColVisualizacao.Post;

    If cdsColVisualizacao.Locate('COLNAM', strCodAtu, []) Then
    Begin
      cdsColVisualizacao.Edit;
      cdsColVisualizacao.FieldByName('ORDCAM').AsInteger := Succ(cdsColVisualizacao.FieldByName('ORDCAM').AsInteger);
      cdsColVisualizacao.Post;
    End;

  Finally
    cdsColVisualizacao.EnableControls;
  End;
end;

procedure TfrmConfigMostraDebCtrChq2.pAlteraOrdemColunaSubir;
  Var
    strCodAtu: String;
Begin
  cdsColVisualizacao.DisableControls;

  Try
    strCodAtu := cdsColVisualizacao.FieldByName('COLNAM').AsString;

    cdsColVisualizacao.Prior;
    cdsColVisualizacao.Edit;
    cdsColVisualizacao.FieldByName('ORDCAM').AsInteger := Succ(cdsColVisualizacao.FieldByName('ORDCAM').AsInteger);
    cdsColVisualizacao.Post;

    If cdsColVisualizacao.Locate('COLNAM', strCodAtu, []) Then
    Begin
      cdsColVisualizacao.Edit;
      cdsColVisualizacao.FieldByName('ORDCAM').AsInteger := Pred(cdsColVisualizacao.FieldByName('ORDCAM').AsInteger);
      cdsColVisualizacao.Post;
    End;

  Finally
    cdsColVisualizacao.EnableControls;
  End;
end;

procedure TfrmConfigMostraDebCtrChq2.pAlteraOrdemColunaSubirDescer(blnSobe: Boolean);
begin
  If blnSobe Then
  begin
    pAlteraOrdemColunaSubir;
    Exit;
  end;

  pAlteraOrdemColunaDescer;

end;

procedure TfrmConfigMostraDebCtrChq2.pAlteraOrdemRegistros(blnSobe: Boolean);
Begin
  If cdsColOrd.RecordCount < 2 then
    Exit;

   If VerificarOrdenacaoSubir(blnSobe) then
    Exit;

  if VerificarOrdenacaoDescer(blnSobe) Then
    Exit;

  pGravarCdsOrdemDosRegistros(blnSobe);
end;

procedure TfrmConfigMostraDebCtrChq2.pCarregaOrdCtr;
Var
  qryTmp : TUniQuery;
Begin
  Try
    qryTmp := fCriaQuery;
    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add('SELECT * FROM ORDCTR         ');
    qryTmp.SQL.Add(' WHERE CTR_CODEMP = :CODEMP  ');
    qryTmp.SQL.Add(' ORDER BY CTR_ORDCAM ');
    qryTmp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTmp.Open;

    While not qryTmp.eof do
    Begin
      cdsColOrd.Insert;
      cdsColOrd.FieldByName('ORDNAM').AsString  := qryTmp.FieldByName('CTR_ORDNAM').AsString ;
      cdsColOrd.FieldByName('ORDCAP').AsString  := qryTmp.FieldByName('CTR_ORDCAP').AsString ;
      cdsColOrd.FieldByName('ORDCAM').AsInteger := qryTmp.FieldByName('CTR_ORDCAM').AsInteger ;
      cdsColOrd.FieldByName('ORDDSC').AsString  := qryTmp.FieldByName('CTR_ORDDSC').AsString ;
      cdsColOrd.Post;

      qryTmp.Next;
    End;
  Finally
    FreeAndNil(qryTmp);
  End;
end;


procedure TfrmConfigMostraDebCtrChq2.pGravarCdsOrdemDosRegistros(blnSobe: Boolean);
begin
  If blnSobe Then
  begin
    pGravarCdsOrdemDosRegistrosSubir;
    Exit;
  end;

  pGravarCdsOrdemDosRegistrosDescer;
end;

procedure TfrmConfigMostraDebCtrChq2.pGravarCdsOrdemDosRegistrosDescer;
Var
  strCodAtu : String;
begin
  cdsColOrd.DisableControls;

  Try
    strCodAtu := cdsColOrd.FieldByName('ORDNAM').AsString;

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

  Finally
    cdsColOrd.EnableControls;
  End;
end;

procedure TfrmConfigMostraDebCtrChq2.pGravarCdsOrdemDosRegistrosSubir;
Var
  strCodAtu : String;
begin
  cdsColOrd.DisableControls;

  Try
    strCodAtu := cdsColOrd.FieldByName('ORDNAM').AsString;

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
  Finally
    cdsColOrd.EnableControls;
  End;
end;

procedure TfrmConfigMostraDebCtrChq2.pIndexarColunasVisiveis;
  Var
    Column   : TcxGridDBColumn;
    intRecNo : Integer;
begin
  inherited;
  cdsColVisualizacao.DisableControls;
  intRecNo := cdsColVisualizacao.RecNo;
  Try
    cdsColVisualizacao.First;
    While Not cdsColVisualizacao.Eof Do
    Begin
      Column := TcxGridDBColumnHelper.fFindColumnByNameView(dbgVisualizacaoDBView, cdsColVisualizacao.FieldByName('COLNAM').AsString);

      If (Column <> Nil) Then
        Column.Index := cdsColVisualizacao.FieldByName('ORDCAM').AsInteger - 1;

      cdsColVisualizacao.Next;
    End;
    cdsColVisualizacao.First;
  Finally
    cdsColVisualizacao.RecNo := intRecNo;
    cdsColVisualizacao.EnableControls;
  End;

end;

procedure TfrmConfigMostraDebCtrChq2.pIniciarDados;
  Var
    intCnt    : Integer;
begin
  dtsVisualizacao.DataSet.DisableControls;
  Try
    For intCnt := Low(TCfgColDebCtr.arrColsOri) To High(TCfgColDebCtr.arrColsOri) Do
    Begin
      pAdicionarColunaExibicaoEOrdem(TCfgColDebCtr.arrColsOri[intCnt]);
      pAdicionarColunaPreVisualizacao(intCnt, TCfgColDebCtr.arrColsOri[intCnt]);
    End;

    TCfgColDebCtr.pSetarUltimosDadosCarregados(dbgVisualizacaoDBView);

    pAjustaColunasDeExibicao;
  Finally
    dtsVisualizacao.DataSet.EnableControls;
  End;
end;

procedure TfrmConfigMostraDebCtrChq2.pMarcarColunasExibicao(blnMarcar: Boolean);
  Var
    intRecNo : Integer;
begin
  cdsColVisualizacao.DisableControls;
  intRecNo := cdsColVisualizacao.RecNo;
  Try
    cdsColVisualizacao.First;

    While Not cdsColVisualizacao.Eof do
    Begin
      cdsColVisualizacao.Edit;

      If blnMarcar Then
        cdsColVisualizacao.FieldByName('EXIBIR').AsString :=  'S'
      Else
        cdsColVisualizacao.FieldByName('EXIBIR').AsString :=  'N';

      cdsColVisualizacao.Post;

      pVisibilidadeColuna;

      cdsColVisualizacao.Next;
    End;

    cdsColVisualizacao.First;
  Finally
    cdsColVisualizacao.RecNo := intRecNo;
    cdsColVisualizacao.EnableControls;
  End;
end;

procedure TfrmConfigMostraDebCtrChq2.pOrdenaColunas;
var cdsOrd,
    cdsBkp: TUniClientDataSet;
    strFields: String;
    strDescFields: String;
    strBookMark : TBookMark;
    indexDef : TIndexDef;
begin
  Try
    cdsOrd := TUniClientDataSet( frmMostraDebCtrChq2.dbgDuplicatasDados.DataController.DataSet );

    cdsBkp := TUniClientDataSet.Create(Self);
    cdsBkp.Data := cdsOrd.data;

    if not cdsColOrd.isEmpty then
    Begin
      cdsOrd.IndexDefs.Clear;
      cdsOrd.IndexName := '';
      cdsOrd.StoreDefs := False;
      cdsOrd.IndexFieldNames := '';

      strBookMark := cdsColOrd.GetBookMark;
      cdsColOrd.DisableControls;
      cdsColOrd.first;

      While not cdsColOrd.eof do
      Begin
        if cdsColOrd.FieldByName('ORDDSC').AsString = 'S' then
        Begin
          strDescFields := fRetornarDescFields(strDescFields, cdsColOrd.FieldByName('ORDNAM').AsString, strFields);
        End;

        strFields := fRetornarFields(strFields,cdsColOrd.FieldByName('ORDNAM').AsString);

        cdsColOrd.Next;
      End;

      cdsColOrd.EnableControls;
      cdsColOrd.BookMark := strBookMark;

      cdsOrd.Active := false;
      indexDef := TIndexDef.Create(cdsOrd.IndexDefs, 'IDX_001', strFields, []);
      indexDef.DescFields := strDescFields;
      cdsOrd.IndexDefs.Update;

      cdsOrd.IndexName := 'IDX_001';
      cdsOrd.CreateDataSet;
      cdsOrd.Data := cdsBkp.Data;
    End;

  Finally
    FreeAndNil(cdsBkp);
  End;

end;


procedure TfrmConfigMostraDebCtrChq2.pVisibilidadeColuna;
  Var
    Column : TcxGridDBColumn;
begin
  inherited;
  If (Not fEmptyStr(cdsColVisualizacao.FieldByName('COLNAM').AsString)) Then
  Begin
    Column := TcxGridDBColumnHelper.fFindColumnByNameView(dbgVisualizacaoDBView, cdsColVisualizacao.FieldByName('COLNAM').AsString);

    If (Column <> Nil) Then
      Column.Visible := (cdsColVisualizacao.FieldByName('EXIBIR').AsString = 'S');
  End;
end;

function TfrmConfigMostraDebCtrChq2.VerificarOrdenacaoDescer(blnSobe: Boolean): Boolean;
begin
  Result := false;

  If Not(cdsColOrd.FieldByName('ORDCAM').AsInteger = cdsColVisualizacao.RecordCount)then
    Exit;

  if (blnSobe)  then
     exit;

  Result := true;
end;

function TfrmConfigMostraDebCtrChq2.VerificarOrdenacaoSubir(blnSobe: Boolean): Boolean;
begin
  Result := false;

  If Not (cdsColOrd.FieldByName('ORDCAM').AsInteger = 1) Then
    Exit;

  If Not blnSobe then
    Exit;

  Result := true;
end;

end.
