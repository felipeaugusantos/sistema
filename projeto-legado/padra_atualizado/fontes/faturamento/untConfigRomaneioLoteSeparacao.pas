unit untConfigRomaneioLoteSeparacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, Vcl.Samples.Spin, Vcl.Samples.Gauges, Vcl.Grids, Vcl.DBGrids,
  DBGridCitel, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid,
  Vcl.ComCtrls, untFatRomaneioLoteSeparacao, untFuncoesSimples,
  untCfgColRomLoteSep, Datasnap.DBClient, UniClientDataSet, Uni;

type
  TfrmConfigRomaneioLoteSeparacao = class(TfrmPai)
    btnGravar: TBitBtnLocked;
    btnPadroes: TBitBtnLocked;
    pgcCfgLoteSep: TPageControl;
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
    pnlGrdExp: TPanel;
    dbgVisLoteSepRom: TDBGridCitel;
    dtsVisLoteSepRom: TDataSource;
    cdsColExi: TUniClientDataSet;
    cdsColExiEXIBIR: TStringField;
    cdsColExiCOLCAP: TStringField;
    cdsColExiCOLNAM: TStringField;
    cdsColExiORDCAM: TIntegerField;
    cdsColExiCOLTAM: TIntegerField;
    cdsColOrd: TUniClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    IntegerField1: TIntegerField;
    StringField3: TStringField;
    dtsColOrd: TDataSource;
    dtsCfgCol: TDataSource;
    TabSheet1: TTabSheet;
    dsCamRod: TDataSource;
    cxGridCitel1: TcxGridCitel;
    cxGridDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    cdsCamRod: TUniClientDataSet;
    cdsCamRodVISIVEL: TStringField;
    cdsCamRodDESCRICAO: TStringField;
    cdsCamRodCAMPO: TStringField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPadroesClick(Sender: TObject);
    procedure cxgColunasTableView1EXIBIRPropertiesEditValueChanged(
      Sender: TObject);
    procedure dbgVisLoteSepRomColumnMoved(Sender: TObject; FromIndex,
      ToIndex: Integer);
    procedure cdsColOrdAfterPost(DataSet: TDataSet);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnRightClick(Sender: TObject);
    procedure btnLeftClick(Sender: TObject);
    procedure btnUpOrdClick(Sender: TObject);
    procedure btnDownOrdClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    blnColOrd,
    blnFecharForm : Boolean;
    blnFinalizouFormShow : Boolean;
    procedure pIniciarDados;
    procedure pAdicionarColunaPreVisualizacao(intIndex: Integer; recColRomLoteSep: TrecColRomLoteSep);
    procedure pAdicionarColunaExibicaoEOrdem(recColRomLoteSep: TrecColRomLoteSep);
    procedure pMarcarColunasExibicao(blnMarcar: Boolean);
    procedure pAlteraOrdemColuna(blnSobe: Boolean);
    procedure pIndexarColunasVisiveis;
    procedure pVisibilidadeColuna;
    procedure pAjustaColunasDeExibicao;
    procedure pOrdenaColunas;
    procedure pAlteraOrdemRegistros(blnSobe: Boolean);
    procedure pCarregaOrdExp;
    procedure pCarregaCamposRodape;
  public
    { Public declarations }
    blnConfirma : Boolean;
    dtsLotSep : TDataSet;
  end;

implementation

{$R *.dfm}

uses
  StrUtils;

procedure TfrmConfigRomaneioLoteSeparacao.btnDesmarcaTodosClick(
  Sender: TObject);
begin
  inherited;
  pMarcarColunasExibicao(False);
  pAjustaColunasDeExibicao;
end;

procedure TfrmConfigRomaneioLoteSeparacao.btnDownClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemColuna(False);
  pIndexarColunasVisiveis;
end;

procedure TfrmConfigRomaneioLoteSeparacao.btnDownOrdClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemRegistros(False);
  pOrdenaColunas;
end;

procedure TfrmConfigRomaneioLoteSeparacao.btnGravarClick(Sender: TObject);
  Var
    arrCol : TArrayOfColRomLoteSep;
begin
  inherited;
  TCfgColRomLoteSep.pSalvarEstado(nil, dbgVisLoteSepRom, arrCol);
  TCfgColRomLoteSep.pGravarDadosNoBanco(arrCol, cdsColOrd);
  TCfgColRomLoteSep.pGravarDadosRodape(cdsCamRod);
  blnConfirma := True;
end;

procedure TfrmConfigRomaneioLoteSeparacao.btnLeftClick(Sender: TObject);
begin
  inherited;
  if not cdsColOrd.isEmpty then
  Begin
    cdsColOrd.Delete;
    pOrdenaColunas;
  End;
end;

procedure TfrmConfigRomaneioLoteSeparacao.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarColunasExibicao(True);
  pAjustaColunasDeExibicao;
end;

procedure TfrmConfigRomaneioLoteSeparacao.btnPadroesClick(Sender: TObject);
begin
  inherited;
  TCfgColRomLoteSep.pSetarPadrao(dbgVisLoteSepRom);
  pAjustaColunasDeExibicao;
end;

procedure TfrmConfigRomaneioLoteSeparacao.btnRightClick(Sender: TObject);
  var
    intOrd: Integer;
begin
  inherited;
  intOrd := cdsColOrd.RecordCount;
  if not cdsColOrd.locate('ORDNAM', cdsColExi.FieldByName('COLNAM').AsString, []) then
  Begin
    Inc(intOrd);
    cdsColOrd.Insert;
    cdsColOrd.FieldByName('ORDNAM').AsString  := cdsColExi.FieldByName('COLNAM').AsString ;
    cdsColOrd.FieldByName('ORDCAP').AsString  := cdsColExi.FieldByName('COLCAP').AsString ;
    cdsColOrd.FieldByName('ORDCAM').AsInteger := intOrd;
    cdsColOrd.FieldByName('ORDDSC').AsString  := 'N' ;
    cdsColOrd.Post;

    pOrdenaColunas;
  End;
end;

procedure TfrmConfigRomaneioLoteSeparacao.btnUpClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemColuna(True);
  pIndexarColunasVisiveis;
end;

procedure TfrmConfigRomaneioLoteSeparacao.btnUpOrdClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemRegistros(True);
  pOrdenaColunas;
end;

procedure TfrmConfigRomaneioLoteSeparacao.cdsColOrdAfterPost(DataSet: TDataSet);
begin
  inherited;
  if blnColOrd then
  Begin
    pOrdenaColunas;
    blnColOrd := False;
  End;
end;

procedure TfrmConfigRomaneioLoteSeparacao.cxgColunasTableView1EXIBIRPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  pVisibilidadeColuna;
end;

procedure TfrmConfigRomaneioLoteSeparacao.dbgVisLoteSepRomColumnMoved(
  Sender: TObject; FromIndex, ToIndex: Integer);
begin
  inherited;
  pAjustaColunasDeExibicao;
end;

procedure TfrmConfigRomaneioLoteSeparacao.FormCreate(Sender: TObject);
begin
  inherited;
  blnColOrd := False;
  blnFinalizouFormShow := False;
  blnFecharForm := False;
  blnConfirma := False;
  cdsColExi.CreateDataSet;
  cdsColExi.IndexFieldNames := 'ORDCAM';

  cdsColOrd.CreateDataSet;
  cdsColOrd.IndexFieldNames := 'ORDCAM';

  pCarregaOrdExp;

  pCarregaCamposRodape;
end;

procedure TfrmConfigRomaneioLoteSeparacao.FormShow(Sender: TObject);
begin
  inherited;
  If (Not Assigned(dtsLotSep)) Then
  Begin
    blnFecharForm := True;
  End
  Else
  Begin
    WindowState := wsMaximized;
    pgcCfgLoteSep.ActivePageIndex := 0;
    dtsVisLoteSepRom.DataSet := dtsLotSep;
    pIniciarDados;
    blnFinalizouFormShow := True;
  End;
end;

procedure TfrmConfigRomaneioLoteSeparacao.pIniciarDados;
  Var
    intCnt : Integer;
    recColSepLoteRom : TrecColRomLoteSep;
begin
  dtsVisLoteSepRom.DataSet.DisableControls;
  Try
    For intCnt := Low(TCfgColRomLoteSep.arrColsOri) To High(TCfgColRomLoteSep.arrColsOri) Do
    Begin
      recColSepLoteRom := TCfgColRomLoteSep.arrColsOri[intCnt];
      pAdicionarColunaExibicaoEOrdem(recColSepLoteRom);
      pAdicionarColunaPreVisualizacao(intCnt, recColSepLoteRom);
    End;

    TCfgColRomLoteSep.pSetarUltimosDadosCarregados(dbgVisLoteSepRom);

    pAjustaColunasDeExibicao;

    cdsColExi.First;
  Finally
    dtsVisLoteSepRom.DataSet.EnableControls;
  End;
end;

procedure TfrmConfigRomaneioLoteSeparacao.pVisibilidadeColuna;
Var
    Column : TColumn;
begin
  inherited;
  If (Not fEmptyStr(cdsColExi.FieldByName('COLNAM').AsString)) Then
  Begin
    Column := fFindColumnByName(dbgVisLoteSepRom, cdsColExi.FieldByName('COLNAM').AsString);

    If (Column <> Nil) Then
      Column.Visible := (cdsColExi.FieldByName('EXIBIR').AsString = 'S');
  End;
end;

procedure TfrmConfigRomaneioLoteSeparacao.pCarregaCamposRodape;
var
  qryCamposRodape : TUniQuery;
begin
  qryCamposRodape := fCriaQuery;

  try
    qryCamposRodape.Close;
    qryCamposRodape.SQL.Clear;
    qryCamposRodape.SQL.Add('SELECT * FROM VISRLS WHERE RLS_CODEMP = :CODEMP');
    qryCamposRodape.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCamposRodape.Open;

    if not cdsCamRod.Active then
      cdsCamRod.CreateDataSet;
    cdsCamRod.EmptyDataSet;

    qryCamposRodape.First;
    while not qryCamposRodape.Eof do
    begin
      cdsCamRod.Append;
      cdsCamRodDESCRICAO.AsString := qryCamposRodape.FieldByName('RLS_DESCOM').AsString;
      cdsCamRodVISIVEL.AsString := qryCamposRodape.FieldByName('RLS_VISIBL').AsString;
      cdsCamRodCAMPO.AsString := qryCamposRodape.FieldByName('RLS_NAMCOM').AsString;
      cdsCamRod.Post;

      qryCamposRodape.Next;
    end;
  finally
    FreeAndNil(qryCamposRodape);
  end;

end;

procedure TfrmConfigRomaneioLoteSeparacao.pCarregaOrdExp;
  var
    qryTmp : TUniQuery;
Begin
  Try
    qryTmp := fCriaQuery;

    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add('SELECT * FROM ORDRLS          ');
    qryTmp.SQL.Add(' WHERE RLS_CODEMP = :CODEMP   ');
    qryTmp.SQL.Add(' ORDER BY RLS_ORDCAM ');
    qryTmp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTmp.Open;

    While not qryTmp.eof do
    Begin
      cdsColOrd.Insert;
      cdsColOrd.FieldByName('ORDNAM').AsString  := qryTmp.FieldByName('RLS_ORDNAM').AsString ;
      cdsColOrd.FieldByName('ORDCAP').AsString  := qryTmp.FieldByName('RLS_ORDCAP').AsString ;
      cdsColOrd.FieldByName('ORDCAM').AsInteger := qryTmp.FieldByName('RLS_ORDCAM').AsInteger ;
      cdsColOrd.FieldByName('ORDDSC').AsString  := qryTmp.FieldByName('RLS_ORDDSC').AsString ;
      cdsColOrd.Post;

      qryTmp.Next;
    End;
  Finally
    FreeAndNil(qryTmp);
  End;

end;

procedure TfrmConfigRomaneioLoteSeparacao.pAdicionarColunaExibicaoEOrdem(recColRomLoteSep: TrecColRomLoteSep);
begin
  if AnsiMatchStr(recColRomLoteSep.strFieldName, COLUNAS_INGNORADAS) then
    Exit;

  cdsColExi.Append;
  cdsColExi.FieldByName('EXIBIR').AsString := IIF(recColRomLoteSep.blnVisible, 'S', 'N');
  cdsColExi.FieldByName('ORDCAM').AsInteger := recColRomLoteSep.intIndex + 1;
  cdsColExi.FieldByName('COLCAP').AsString := recColRomLoteSep.strCaption;
  cdsColExi.FieldByName('COLNAM').AsString := recColRomLoteSep.strFieldName;
  cdsColExi.Post;
  cdsColExi.First;
end;

procedure TfrmConfigRomaneioLoteSeparacao.pAdicionarColunaPreVisualizacao(intIndex: Integer; recColRomLoteSep: TrecColRomLoteSep);
begin
  dbgVisLoteSepRom.Columns.Add;
  dbgVisLoteSepRom.Columns[intIndex].FieldName     := recColRomLoteSep.strFieldName;
  dbgVisLoteSepRom.Columns[intIndex].Title.Caption := recColRomLoteSep.strCaption;
  dbgVisLoteSepRom.Columns[intIndex].Alignment     := recColRomLoteSep.Alignment;
  dbgVisLoteSepRom.Columns[intIndex].Width         := recColRomLoteSep.intWidth;
  dbgVisLoteSepRom.Columns[intIndex].Visible       := recColRomLoteSep.blnVisible;
end;

procedure TfrmConfigRomaneioLoteSeparacao.pAjustaColunasDeExibicao;
  Var
    intCnt : Integer;
    intRecNo : Integer;
begin
  intRecNo := cdsColExi.RecNo;
  cdsColExi.DisableControls;
  Try
    For intCnt := 0 To dbgVisLoteSepRom.Columns.Count-1 Do
    begin
      If cdsColExi.Locate('COLNAM', dbgVisLoteSepRom.Columns[intCnt].FieldName, []) Then
      begin
        cdsColExi.Edit;
        cdsColExi.FieldByName('ORDCAM').AsInteger := intCnt + 1;
        cdsColExi.FieldByName('EXIBIR').AsString := IIF(dbgVisLoteSepRom.Columns[intCnt].Visible, 'S', 'N');
        cdsColExi.Post;
      end;
    end;
  Finally
    cdsColExi.RecNo := intRecNo;
    cdsColExi.EnableControls;
  End;
end;

procedure TfrmConfigRomaneioLoteSeparacao.pMarcarColunasExibicao(blnMarcar: Boolean);
  Var
    intRecNo : Integer;
begin
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
end;

procedure TfrmConfigRomaneioLoteSeparacao.pAlteraOrdemColuna(blnSobe: Boolean);
  Var
    strCodAtu: String;
Begin
  If cdsColExi.RecordCount < 2 then
    Exit;

  If (cdsColExi.FieldByName('ORDCAM').AsInteger = 1) And blnSobe then
    Exit;

  If (cdsColExi.FieldByName('ORDCAM').AsInteger = cdsColExi.RecordCount) And (Not blnSobe) then
    Exit;

  cdsColExi.DisableControls;
  Try
    strCodAtu := cdsColExi.FieldByName('COLNAM').AsString;

    If blnSobe Then
    Begin
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
    End
    Else
    Begin
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
    End;
  Finally
    cdsColExi.EnableControls;
  End;
end;

procedure TfrmConfigRomaneioLoteSeparacao.pIndexarColunasVisiveis;
  Var
    Column : TColumn;
    intRecNo : Integer;
begin
  cdsColExi.DisableControls;
  intRecNo := cdsColExi.RecNo;
  Try
    cdsColExi.First;
    While Not cdsColExi.Eof Do
    Begin
      Column := fFindColumnByName(dbgVisLoteSepRom, cdsColExi.FieldByName('COLNAM').AsString);

      If (Column <> Nil) Then
        Column.Index := cdsColExi.FieldByName('ORDCAM').AsInteger - 1;

      cdsColExi.Next;
    End;
    cdsColExi.First;
  Finally
    cdsColExi.RecNo := intRecNo;
    cdsColExi.EnableControls;
  End;
end;

procedure TfrmConfigRomaneioLoteSeparacao.pAlteraOrdemRegistros(blnSobe: Boolean);
  Var
    strCodAtu: String;
Begin
  If cdsColOrd.RecordCount < 2 then
    Exit;

  If (cdsColOrd.FieldByName('ORDCAM').AsInteger = 1) And blnSobe then
    Exit;

  If (cdsColOrd.FieldByName('ORDCAM').AsInteger = cdsColExi.RecordCount) And (Not blnSobe) then
    Exit;

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
end;

procedure TfrmConfigRomaneioLoteSeparacao.pOrdenaColunas;
  var
    cdsOrd, cdsBkp: TUniClientDataSet;
    strFields: String;
    strDescFields: String;
    strBookMark : TBookMark;
begin
  Try
    cdsOrd := TUniClientDataSet( dtsLotSep );

    cdsBkp := TUniClientDataSet.Create(Self);
    cdsBkp.Data := cdsOrd.data;

    cdsOrd.IndexDefs.Clear;
    cdsOrd.IndexName := '';
    cdsOrd.StoreDefs := False;
    cdsOrd.IndexFieldNames := '';

    if not cdsColOrd.isEmpty then
    Begin
      strBookMark := cdsColOrd.GetBookMark;
      cdsColOrd.DisableControls;
      cdsColOrd.first;
      While not cdsColOrd.eof do
      Begin
        if cdsColOrd.FieldByName('ORDDSC').AsString = 'S' then
        Begin
          if fEmptyStr(strDescFields) then
            strDescFields := cdsColOrd.FieldByName('ORDNAM').AsString
          else
            strDescFields := strFields + ';' + cdsColOrd.FieldByName('ORDNAM').AsString ;
        End;

        if fEmptyStr(strFields) then
          strFields := cdsColOrd.FieldByName('ORDNAM').AsString
        else
          strFields := strFields + ';' + cdsColOrd.FieldByName('ORDNAM').AsString ;

        cdsColOrd.Next;
      End;
      cdsColOrd.EnableControls;
      cdsColOrd.BookMark := strBookMark;

      cdsOrd.Active := false;

      cdsOrd.IndexDefs.AddIndexDef.Name   := 'IDX_001';
      cdsOrd.IndexDefs.AddIndexDef.Fields := strFields;
      cdsOrd.IndexDefs.AddIndexDef.DescFields := strDescFields;

      cdsOrd.IndexName := 'IDX_001';

      cdsOrd.CreateDataSet;
      cdsOrd.Data := cdsBkp.Data;
    End;
  Finally
    FreeAndNil(cdsBkp);
  End;
end;

end.
