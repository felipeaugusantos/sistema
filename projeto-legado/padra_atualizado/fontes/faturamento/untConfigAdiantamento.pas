unit untConfigAdiantamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid,
  Vcl.ComCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls,
  UniClientDataSet, untSelPedidoAdiantamento, untCfgColAdt, Uni,
  untcxGridDBColumnHelper, Datasnap.DBClient;

type
  TfrmConfigAdiantamento = class(TfrmPai)
    pnlCfgAdt: TPanel;
    pgcCfgAdt: TPageControl;
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
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    pnlGrdAdt: TPanel;
    dbgVisAdt: TcxGridCitel;
    dbgVisAdtDBView: TcxGridDBTableViewCitel;
    cxGridLevel2: TcxGridLevel;
    btnPadroes: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    cdsColAdt: TUniClientDataSet;
    cdsColAdtEXIBIR: TStringField;
    cdsColAdtCOLCAP: TStringField;
    cdsColAdtCOLNAM: TStringField;
    cdsColAdtORDCAM: TIntegerField;
    cdsColAdtCOLTAM: TIntegerField;
    dtsVisAdt: TDataSource;
    dtsCfgCol: TDataSource;
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPadroesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure cxgColunasTableView1EXIBIRPropertiesEditValueChanged(
      Sender: TObject);
    procedure dbgVisAdtDBViewColumnPosChanged(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
  private
    { Private declarations }
    blnFecharForm       : Boolean;
    blnFinalizouFormShow: Boolean;
    procedure pIniciarDados;
    procedure pVisibilidadeColuna;
    procedure pAdicionarColunaExibicaoEOrdem(recColAdt: TrecColAdt);
    procedure pAdicionarColunaPreVisualizacao(intIndex: Integer; recColAdt: TrecColAdt);
    procedure pAlteraOrdemColuna(blnSobe: Boolean);
    procedure pIndexarColunasVisiveis;
    procedure pMarcarColunasExibicao(blnMarcar: Boolean);
    procedure pAjustaColunasDeExibicao;
  public
    { Public declarations }
    blnConfirma             : Boolean;
    frmSelPedidoAdiantamento: TfrmSelPedidoAdiantamento;
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples;

{ TfrmConfigAdiantamento }

procedure TfrmConfigAdiantamento.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarColunasExibicao(False);
  pAjustaColunasDeExibicao;
end;

procedure TfrmConfigAdiantamento.btnDownClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemColuna(False);
  pIndexarColunasVisiveis;
end;

procedure TfrmConfigAdiantamento.btnGravarClick(Sender: TObject);
var
  arrCol: TArrayOfColAdt;
begin
  inherited;

  TCfgColAdt.pSalvarEstado(dbgVisAdtDBView, arrCol);
  TCfgColAdt.pGravarDadosNoBanco(arrCol);
  blnConfirma := True;
end;

procedure TfrmConfigAdiantamento.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarColunasExibicao(True);
  pAjustaColunasDeExibicao;
end;

procedure TfrmConfigAdiantamento.btnPadroesClick(Sender: TObject);
begin
  inherited;
  TCfgColAdt.pSetarPadrao(dbgVisAdtDBView);
  pAjustaColunasDeExibicao;
end;

procedure TfrmConfigAdiantamento.btnUpClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemColuna(True);
  pIndexarColunasVisiveis;
end;

procedure TfrmConfigAdiantamento.cxgColunasTableView1EXIBIRPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  pVisibilidadeColuna;
end;

procedure TfrmConfigAdiantamento.dbgVisAdtDBViewColumnPosChanged(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;
  pAjustaColunasDeExibicao;
end;

procedure TfrmConfigAdiantamento.FormCreate(Sender: TObject);
begin
  inherited;

  blnFinalizouFormShow := False;
  blnFecharForm := False;
  blnConfirma := False;
  cdsColAdt.CreateDataSet;
  cdsColAdt.IndexFieldNames := 'ORDCAM';
  WindowState := wsMaximized;
end;

procedure TfrmConfigAdiantamento.FormPaint(Sender: TObject);
begin
  inherited;

  if blnFecharForm then
    Close;
end;

procedure TfrmConfigAdiantamento.FormShow(Sender: TObject);
begin
  inherited;

  if (not Assigned(frmSelPedidoAdiantamento)) then
  begin
    fMensagem('ATENÇÃO!', 'A configuração do adiantamento deve ser chamada sempre através da tela de adiantamento!', ['&OK']);
    blnFecharForm := True;
  end
  Else
  begin
    pgcCfgAdt.ActivePageIndex := 0;
    dtsVisAdt.DataSet := frmSelPedidoAdiantamento.cxgPedidosDados.DataController.DataSet;
    pIniciarDados;
    blnFinalizouFormShow := True;
  end;
end;

procedure TfrmConfigAdiantamento.pAdicionarColunaExibicaoEOrdem(recColAdt: TrecColAdt);
begin
  cdsColAdt.Append;
  cdsColAdt.FieldByName('EXIBIR').AsString  := IIF(recColAdt.blnVisible, 'S', 'N');
  cdsColAdt.FieldByName('ORDCAM').AsInteger := recColAdt.intIndex + 1;
  cdsColAdt.FieldByName('COLCAP').AsString  := recColAdt.strCaption;
  cdsColAdt.FieldByName('COLNAM').AsString  := recColAdt.strFieldName;
  cdsColAdt.Post;
  cdsColAdt.First;
end;

procedure TfrmConfigAdiantamento.pAdicionarColunaPreVisualizacao(intIndex: Integer; recColAdt: TrecColAdt);
begin
  dbgVisAdtDBView.CreateColumn;
  dbgVisAdtDBView.Columns[intIndex].DataBinding.FieldName       := recColAdt.strFieldName;
  dbgVisAdtDBView.Columns[intIndex].Caption                     := recColAdt.strCaption;
  dbgVisAdtDBView.Columns[intIndex].Width                       := recColAdt.intWidth;
  dbgVisAdtDBView.Columns[intIndex].Visible                     := recColAdt.blnVisible;
  dbgVisAdtDBView.Columns[intIndex].DataBinding.Field.Alignment := recColAdt.Alignment;
end;

procedure TfrmConfigAdiantamento.pAjustaColunasDeExibicao;
var
  intCnt : Integer;
  intRecNo : Integer;
begin
  intRecNo := cdsColAdt.RecNo;
  cdsColAdt.DisableControls;

  try
    for intCnt := 0 To Pred(dbgVisAdtDBView.ColumnCount) do
    begin
      if cdsColAdt.Locate('COLNAM', dbgVisAdtDBView.Columns[intCnt].DataBinding.FieldName, []) then
      begin
        cdsColAdt.Edit;
        cdsColAdt.FieldByName('ORDCAM').AsInteger := intCnt + 1;
        cdsColAdt.FieldByName('EXIBIR').AsString := IIF(dbgVisAdtDBView.Columns[intCnt].Visible, 'S', 'N');
        cdsColAdt.Post;
      end;
    end;
  finally
    cdsColAdt.RecNo := intRecNo;
    cdsColAdt.EnableControls;
  end;
end;

procedure TfrmConfigAdiantamento.pAlteraOrdemColuna(blnSobe: Boolean);
var
  strCodAtu: String;
begin
  if cdsColAdt.RecordCount < 2 then
    Exit;

  if (cdsColAdt.FieldByName('ORDCAM').AsInteger = 1) And blnSobe then
    Exit;

  if (cdsColAdt.FieldByName('ORDCAM').AsInteger = cdsColAdt.RecordCount) And (not blnSobe) then
    Exit;

  cdsColAdt.DisableControls;
  try
    strCodAtu := cdsColAdt.FieldByName('COLNAM').AsString;

    if blnSobe then
    begin
      cdsColAdt.Prior;
      cdsColAdt.Edit;
      cdsColAdt.FieldByName('ORDCAM').AsInteger := Succ(cdsColAdt.FieldByName('ORDCAM').AsInteger);
      cdsColAdt.Post;

      if cdsColAdt.Locate('COLNAM', strCodAtu, []) then
      begin
        cdsColAdt.Edit;
        cdsColAdt.FieldByName('ORDCAM').AsInteger := Pred(cdsColAdt.FieldByName('ORDCAM').AsInteger);
        cdsColAdt.Post;
      end;
    end
    Else
    begin
      cdsColAdt.Next;
      cdsColAdt.Edit;
      cdsColAdt.FieldByName('ORDCAM').AsInteger := Pred(cdsColAdt.FieldByName('ORDCAM').AsInteger);
      cdsColAdt.Post;

      if cdsColAdt.Locate('COLNAM', strCodAtu, []) then
      begin
        cdsColAdt.Edit;
        cdsColAdt.FieldByName('ORDCAM').AsInteger := Succ(cdsColAdt.FieldByName('ORDCAM').AsInteger);
        cdsColAdt.Post;
      end;
    end;
  finally
    cdsColAdt.EnableControls;
  end;
end;

procedure TfrmConfigAdiantamento.pIndexarColunasVisiveis;
var
  Column  : TcxGridDBColumn;
  intRecNo: Integer;
begin
  cdsColAdt.DisableControls;
  intRecNo := cdsColAdt.RecNo;

  try
    cdsColAdt.First;

    while not cdsColAdt.Eof do
    begin
      Column := TcxGridDBColumnHelper.fFindColumnByNameView(dbgVisAdtDBView, cdsColAdt.FieldByName('COLNAM').AsString);

      if (Column <> Nil) then
        Column.Index := cdsColAdt.FieldByName('ORDCAM').AsInteger - 1;

      cdsColAdt.Next;
    end;

    cdsColAdt.First;
  finally
    cdsColAdt.RecNo := intRecNo;
    cdsColAdt.EnableControls;
  end;
end;

procedure TfrmConfigAdiantamento.pIniciarDados;
var
  intCnt   : Integer;
  recColAdt: TrecColAdt;
begin
  dtsVisAdt.DataSet.DisableControls;

  try
    for intCnt := Low(TCfgColAdt.arrColsOri) To High(TCfgColAdt.arrColsOri) do
    begin
      recColAdt := TCfgColAdt.arrColsOri[intCnt];
      pAdicionarColunaExibicaoEOrdem(recColAdt);
      pAdicionarColunaPreVisualizacao(intCnt, recColAdt);
    end;

    TCfgColAdt.pSetarUltimosDadosCarregados(dbgVisAdtDBView);
    pAjustaColunasDeExibicao;

    cdsColAdt.First;
  finally
    dtsVisAdt.DataSet.EnableControls;
  end;
end;

procedure TfrmConfigAdiantamento.pMarcarColunasExibicao(blnMarcar: Boolean);
var
  intRecNo : Integer;
begin
  cdsColAdt.DisableControls;
  intRecNo := cdsColAdt.RecNo;

  try
    cdsColAdt.First;

    while not cdsColAdt.Eof do
    begin
      cdsColAdt.Edit;

      if blnMarcar then
        cdsColAdt.FieldByName('EXIBIR').AsString :=  'S'
      Else
        cdsColAdt.FieldByName('EXIBIR').AsString :=  'N';

      cdsColAdt.Post;

      pVisibilidadeColuna;

      cdsColAdt.Next;
    end;

    cdsColAdt.First;
  finally
    cdsColAdt.RecNo := intRecNo;
    cdsColAdt.EnableControls;
  end;
end;

procedure TfrmConfigAdiantamento.pVisibilidadeColuna;
var
  Column: TcxGridDBColumn;
begin
  inherited;

  if (not fEmptyStr(cdsColAdt.FieldByName('COLNAM').AsString)) then
  begin
    Column := TcxGridDBColumnHelper.fFindColumnByNameView(dbgVisAdtDBView, cdsColAdt.FieldByName('COLNAM').AsString);

    if (Column <> Nil) then
      Column.Visible := (cdsColAdt.FieldByName('EXIBIR').AsString = 'S');
  end;
end;

end.
