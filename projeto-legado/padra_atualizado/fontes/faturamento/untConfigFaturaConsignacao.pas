unit untConfigFaturaConsignacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, Vcl.Grids, Vcl.DBGrids, DBGridCitel, Vcl.StdCtrls, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGridCitel, cxGrid, Vcl.ComCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Datasnap.DBClient, UniClientDataSet,
  untFatFaturaConsignacao, untCfgColExpFaturaConsig, Uni;

type
  TfrmConfigFaturaConsignacao = class(TfrmPai)
    pgcCfgExp: TPageControl;
    tbsColunas: TTabSheet;
    pnlGrdCol: TPanel;
    pnlCfgCol: TPanel;
    btnUpSintet: TSpeedButton;
    btnDownSintet: TSpeedButton;
    btnUpAnalit: TSpeedButton;
    btnDownAnalit: TSpeedButton;
    btnUpOrdSintet: TSpeedButton;
    btnDownOrdSintet: TSpeedButton;
    btnDownOrdAnalit: TSpeedButton;
    btnUpOrdAnalit: TSpeedButton;
    btnMarcaTodosSintet: TBitBtnLocked;
    btnDesmarcaTodosSintet: TBitBtnLocked;
    btnMarcaTodosAnalit: TBitBtnLocked;
    btnDesmarcaTodosAnalit: TBitBtnLocked;
    pnlTitulos: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    pnlGrdExp: TPanel;
    dbgSintetEstrutura: TDBGridCitel;
    dbgAnalitEstrutura: TDBGridCitel;
    Panel2: TPanel;
    pnlAreaVis: TPanel;
    cdsSintetico: TUniClientDataSet;
    cdsSinteticoEXIBIR: TStringField;
    cdsSinteticoCOLCAP: TStringField;
    cdsSinteticoCOLNAM: TStringField;
    cdsSinteticoORDCAM: TIntegerField;
    cdsSinteticoCOLTAM: TIntegerField;
    dtsSintetico: TDataSource;
    dtsColOrdSintetico: TDataSource;
    cdsColOrdSintetico: TUniClientDataSet;
    dtsAnalitico: TDataSource;
    cdsAnalitico: TUniClientDataSet;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    dtsColOrdAnalitico: TDataSource;
    cdsColOrdAnalitico: TUniClientDataSet;
    cdsColOrdSinteticoORDCAP: TStringField;
    cdsColOrdSinteticoORDNAM: TStringField;
    cdsColOrdSinteticoORDCAM: TIntegerField;
    cdsColOrdSinteticoORDDSC: TStringField;
    cdsColOrdAnaliticoORDCAP: TStringField;
    cdsColOrdAnaliticoORDNAM: TStringField;
    cdsColOrdAnaliticoORDCAM: TIntegerField;
    cdsColOrdAnaliticoORDDSC: TStringField;
    btnGravar: TBitBtnLocked;
    btnPadroes: TBitBtnLocked;
    dtsSinteticoCol: TDataSource;
    dtsAnaliticoCol: TDataSource;
    Panel1: TPanel;
    cxgColOrdSintet: TcxGridCitel;
    cxgColOrdSintetTableView1: TcxGridDBTableViewCitel;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    cxgSintEstrutura: TcxGridCitel;
    cxgSintEstruturaTableView1: TcxGridDBTableViewCitel;
    cxgSintEstruturaTableView1EXIBIR: TcxGridDBColumn;
    cxgSintEstruturaTableView1COLCAP: TcxGridDBColumn;
    cxgSintEstruturaTableView1ORDCAM: TcxGridDBColumn;
    cxgSintEstruturaTableView1COLNAM: TcxGridDBColumn;
    cxgSintEstruturaLevel1: TcxGridLevel;
    Panel3: TPanel;
    btnLeftSintet: TSpeedButton;
    btnRightSintet: TSpeedButton;
    Panel4: TPanel;
    cxgAnalitEstrutura: TcxGridCitel;
    cxgAnalitEstruturaTableViewCitel1: TcxGridDBTableViewCitel;
    cxgAnalitEstruturaTableViewCitel1EXIBIR: TcxGridDBColumn;
    cxgAnalitEstruturaTableViewCitel1COLCAP: TcxGridDBColumn;
    cxgAnalitEstruturaTableViewCitel1ORDCAM: TcxGridDBColumn;
    cxgAnalitEstruturaTableViewCitel1COLNAM: TcxGridDBColumn;
    cxgAnalitEstruturaLevel1: TcxGridLevel;
    cxgColOrdAnalit: TcxGridCitel;
    cxgColOrdAnalitTableView1: TcxGridDBTableViewCitel;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxgColOrdAnalitLevel1: TcxGridLevel;
    Panel5: TPanel;
    btnRightAnalit: TSpeedButton;
    btnLeftAnalit: TSpeedButton;
    procedure btnDesmarcaTodosAnalitClick(Sender: TObject);
    procedure btnDesmarcaTodosSintetClick(Sender: TObject);
    procedure btnDownAnalitClick(Sender: TObject);
    procedure btnDownSintetClick(Sender: TObject);
    procedure btnDownOrdAnalitClick(Sender: TObject);
    procedure btnDownOrdSintetClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnLeftSintetClick(Sender: TObject);
    procedure btnMarcaTodosAnalitClick(Sender: TObject);
    procedure btnMarcaTodosSintetClick(Sender: TObject);
    procedure btnPadroesClick(Sender: TObject);
    procedure btnRightSintetClick(Sender: TObject);
    procedure btnUpAnalitClick(Sender: TObject);
    procedure btnUpSintetClick(Sender: TObject);
    procedure btnUpOrdAnalitClick(Sender: TObject);
    procedure btnUpOrdSintetClick(Sender: TObject);
    procedure cdsColOrdAnaliticoAfterPost(DataSet: TDataSet);
    procedure cdsColOrdSinteticoAfterPost(DataSet: TDataSet);
    procedure cxGridDBColumn3PropertiesEditValueChanged(Sender: TObject);
    procedure cxGridDBColumn6PropertiesEditValueChanged(Sender: TObject);
    procedure dbgSintetEstruturaColumnMoved(Sender: TObject;
      FromIndex, ToIndex: Integer);
    procedure dbgSintetEstruturaDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure dbgAnalitEstruturaColumnMoved(Sender: TObject;
      FromIndex, ToIndex: Integer);
    procedure dbgAnalitEstruturaDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnRightAnalitClick(Sender: TObject);
    procedure btnLeftAnalitClick(Sender: TObject);
    procedure cxgSintEstruturaTableView1EXIBIRPropertiesEditValueChanged
      (Sender: TObject);
    procedure cxgAnalitEstruturaTableViewCitel1EXIBIRPropertiesEditValueChanged(
      Sender: TObject);
  private
    { Private declarations }
    blnFecharForm: Boolean;
    blnFinalizouFormShow: Boolean;
    blnColOrdSintet: Boolean;
    blnColOrdAnalit: Boolean;
    procedure pOrdenaColunasSintet;
    procedure pVisibilidadeColunaAnalit;
    procedure pVisibilidadeColunaSintet;
    procedure pMarcarColunasExibicaoAnalit(blnMarcar: Boolean);
    procedure pMarcarColunasExibicaoSintet(blnMarcar: Boolean);
    procedure pAjustaColunasDeExibicaoAnalit;
    procedure pAjustaColunasDeExibicaoSintet;
    procedure pIndexarColunasVisiveisAnalit;
    procedure pIndexarColunasVisiveisSintet;
    procedure pAlteraOrdemColunaAnalit(blnSobe: Boolean);
    procedure pAlteraOrdemColunaSintet(blnSobe: Boolean);
    procedure pAlteraOrdemRegistrosAnalit(blnSobe: Boolean);
    procedure pAlteraOrdemRegistrosSintet(blnSobe: Boolean);
    procedure pOrdenaColunasAnalit;
    procedure pCarregaOrdExpSintet;
    procedure pCarregaOrdExpAnalit;
    procedure pAdicionarColunaExibicaoEOrdemAnalit(recColExp: TrecColExpFaturaConsig);
    procedure pAdicionarColunaExibicaoEOrdemSintet(recColExp: TrecColExpFaturaConsig);
    procedure pAdicionarColunaPreVisualizacaoAnalit(intIndex: Integer; recColExp: TrecColExpFaturaConsig);
    procedure pAdicionarColunaPreVisualizacaoSintet(intIndex: Integer; recColExp: TrecColExpFaturaConsig);
    procedure pIniciarDadosSintet;
    procedure pIniciarDadosAnalit;
  public
    { Public declarations }
    blnConfirma : Boolean;
    {Dataset´s externos a serem atribuidos par ao funcionamento da configuração}
    dtsSintetExt : TDataSet;
    dtsAnalitExt : TDataSet;
    Class function fIniciaConfiguracaoFatura(dtsSinteticoExt : TDataset; dtsAnaliticoExt : TDataset) : Boolean;

  end;

implementation

{$R *.dfm}

Uses untFuncoesSimples;

procedure TfrmConfigFaturaConsignacao.btnDesmarcaTodosAnalitClick
  (Sender: TObject);
begin
  inherited;
  pMarcarColunasExibicaoAnalit(False);
  pAjustaColunasDeExibicaoAnalit;
end;

procedure TfrmConfigFaturaConsignacao.btnDesmarcaTodosSintetClick
  (Sender: TObject);
begin
  inherited;
  pMarcarColunasExibicaoSintet(False);
  pAjustaColunasDeExibicaoSintet;
end;

procedure TfrmConfigFaturaConsignacao.btnDownAnalitClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemColunaAnalit(False);
  pIndexarColunasVisiveisAnalit;
end;

procedure TfrmConfigFaturaConsignacao.btnDownSintetClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemColunaSintet(False);
  pIndexarColunasVisiveisSintet;
end;

procedure TfrmConfigFaturaConsignacao.btnDownOrdAnalitClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemRegistrosAnalit(False);
  pOrdenaColunasAnalit;
end;

procedure TfrmConfigFaturaConsignacao.btnDownOrdSintetClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemRegistrosSintet(False);
  pOrdenaColunasSintet;
end;

procedure TfrmConfigFaturaConsignacao.btnGravarClick(Sender: TObject);
Var
  arrCol: TArrayOfColExpFaturaConsig;
  arrColAnalitico: TArrayOfColExpFaturaConsig;
begin
  inherited;
  TCfgColExpFaturaConsig.pSalvarEstado(nil, dbgSintetEstrutura, arrCol);
  TCfgColExpFaturaConsig.pGravarDadosNoBancoSintet(arrCol, cdsColOrdSintetico);

  TCfgColExpFaturaConsig.pSalvarEstadoAnalit(Nil, dbgAnalitEstrutura,  arrColAnalitico);
  TCfgColExpFaturaConsig.pGravarDadosNoBancoAnalit(arrColAnalitico,  cdsColOrdAnalitico);

  blnConfirma := True;
end;

procedure TfrmConfigFaturaConsignacao.btnLeftAnalitClick(Sender: TObject);
begin
  inherited;
  if not cdsColOrdAnalitico.IsEmpty then
  begin
    cdsColOrdAnalitico.Delete;
    pOrdenaColunasAnalit;
  end;
end;

procedure TfrmConfigFaturaConsignacao.btnLeftSintetClick(Sender: TObject);
begin
  inherited;
  if not cdsColOrdSintetico.IsEmpty then
  begin
    cdsColOrdSintetico.Delete;
    pOrdenaColunasSintet;
  end;
end;

procedure TfrmConfigFaturaConsignacao.btnMarcaTodosAnalitClick(Sender: TObject);
begin
  inherited;
  pMarcarColunasExibicaoAnalit(True);
  pAjustaColunasDeExibicaoAnalit;
end;

procedure TfrmConfigFaturaConsignacao.btnMarcaTodosSintetClick(Sender: TObject);
begin
  inherited;
  pMarcarColunasExibicaoSintet(True);
  pAjustaColunasDeExibicaoSintet;
end;

procedure TfrmConfigFaturaConsignacao.btnPadroesClick(Sender: TObject);
begin
  inherited;
  TCfgColExpFaturaConsig.pSetarPadrao(dbgSintetEstrutura);
  TCfgColExpFaturaConsig.pSetarPadraoAnalit(dbgAnalitEstrutura);

  pAjustaColunasDeExibicaoSintet;
  pAjustaColunasDeExibicaoAnalit;
end;

procedure TfrmConfigFaturaConsignacao.btnRightAnalitClick(Sender: TObject);
var
  intOrd: Integer;
begin
  inherited;
  intOrd := cdsColOrdAnalitico.RecordCount;
  if not cdsColOrdAnalitico.locate('ORDNAM', cdsAnalitico.FieldByName('COLNAM').AsString, []) then
  Begin
    Inc(intOrd);
    cdsColOrdAnalitico.Insert;
    cdsColOrdAnalitico.FieldByName('ORDNAM').AsString := cdsAnalitico.FieldByName('COLNAM').AsString;
    cdsColOrdAnalitico.FieldByName('ORDCAP').AsString := cdsAnalitico.FieldByName('COLCAP').AsString;
    cdsColOrdAnalitico.FieldByName('ORDCAM').AsInteger := intOrd;
    cdsColOrdAnalitico.FieldByName('ORDDSC').AsString := 'N';
    cdsColOrdAnalitico.Post;

    pOrdenaColunasAnalit;
  End;
end;

procedure TfrmConfigFaturaConsignacao.btnRightSintetClick(Sender: TObject);
var
  intOrd: Integer;
begin
  inherited;
  intOrd := cdsColOrdSintetico.RecordCount;
  if not cdsColOrdSintetico.locate('ORDNAM', cdsSintetico.FieldByName('COLNAM').AsString, []) then
  Begin
    Inc(intOrd);
    cdsColOrdSintetico.Insert;
    cdsColOrdSintetico.FieldByName('ORDNAM').AsString := cdsSintetico.FieldByName('COLNAM').AsString;
    cdsColOrdSintetico.FieldByName('ORDCAP').AsString := cdsSintetico.FieldByName('COLCAP').AsString;
    cdsColOrdSintetico.FieldByName('ORDCAM').AsInteger := intOrd;
    cdsColOrdSintetico.FieldByName('ORDDSC').AsString := 'N';
    cdsColOrdSintetico.Post;

    pOrdenaColunasSintet;
  End;
end;

procedure TfrmConfigFaturaConsignacao.btnUpAnalitClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemColunaAnalit(True);
  pIndexarColunasVisiveisAnalit;
end;

procedure TfrmConfigFaturaConsignacao.btnUpSintetClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemColunaSintet(True);
  pIndexarColunasVisiveisSintet;
end;

procedure TfrmConfigFaturaConsignacao.btnUpOrdAnalitClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemRegistrosAnalit(True);
  pOrdenaColunasAnalit;
end;

procedure TfrmConfigFaturaConsignacao.btnUpOrdSintetClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemRegistrosSintet(True);
  pOrdenaColunasSintet;
end;

procedure TfrmConfigFaturaConsignacao.cdsColOrdAnaliticoAfterPost
  (DataSet: TDataSet);
begin
  inherited;
  if blnColOrdAnalit then
  begin
    pOrdenaColunasAnalit;
    blnColOrdAnalit := False;
  end;
end;

procedure TfrmConfigFaturaConsignacao.cdsColOrdSinteticoAfterPost
  (DataSet: TDataSet);
begin
  inherited;
  if blnColOrdSintet then
  begin
    pOrdenaColunasSintet;
    blnColOrdSintet := False;
  end;
end;

procedure TfrmConfigFaturaConsignacao.cxgAnalitEstruturaTableViewCitel1EXIBIRPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  pVisibilidadeColunaAnalit;
end;

procedure TfrmConfigFaturaConsignacao.cxGridDBColumn3PropertiesEditValueChanged
  (Sender: TObject);
begin
  inherited;
  if cdsColOrdSintetico.State = dsEdit then
  begin
    blnColOrdSintet := True;
    cdsColOrdSintetico.Post;
  end;

end;

procedure TfrmConfigFaturaConsignacao.cxGridDBColumn6PropertiesEditValueChanged
  (Sender: TObject);
begin
  inherited;
  if cdsColOrdAnalitico.State = dsEdit then
  begin
    blnColOrdAnalit := True;
    cdsColOrdAnalitico.Post;
  end;
end;

procedure TfrmConfigFaturaConsignacao.
  cxgSintEstruturaTableView1EXIBIRPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  pVisibilidadeColunaSintet;
end;

procedure TfrmConfigFaturaConsignacao.dbgAnalitEstruturaColumnMoved
  (Sender: TObject; FromIndex, ToIndex: Integer);
begin
  inherited;
  pAjustaColunasDeExibicaoAnalit;
end;

procedure TfrmConfigFaturaConsignacao.dbgAnalitEstruturaDrawColumnCell
  (Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if not blnFinalizouFormShow then
  begin
    Exit;
  end;
end;

procedure TfrmConfigFaturaConsignacao.dbgSintetEstruturaColumnMoved
  (Sender: TObject; FromIndex, ToIndex: Integer);
begin
  inherited;
  pAjustaColunasDeExibicaoSintet;
end;

procedure TfrmConfigFaturaConsignacao.dbgSintetEstruturaDrawColumnCell
  (Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if not blnFinalizouFormShow then
  begin
    Exit;
  end;
end;

procedure TfrmConfigFaturaConsignacao.FormCreate(Sender: TObject);
begin
  inherited;
  blnFinalizouFormShow := False;
  blnFecharForm := False;
  blnConfirma := False;

  cdsSintetico.CreateDataSet;
  cdsSintetico.IndexFieldNames := 'ORDCAM';

  cdsAnalitico.CreateDataSet;
  cdsAnalitico.IndexFieldNames := 'ORDCAM';

  cdsColOrdSintetico.CreateDataSet;
  cdsColOrdSintetico.IndexFieldNames := 'ORDCAM';

  cdsColOrdAnalitico.CreateDataSet;
  cdsColOrdAnalitico.IndexFieldNames := 'ORDCAM';

  pCarregaOrdExpSintet;
  pCarregaOrdExpAnalit;
end;

procedure TfrmConfigFaturaConsignacao.FormPaint(Sender: TObject);
begin
  inherited;
  if blnFecharForm then
  begin
    Close;
  end;
end;

procedure TfrmConfigFaturaConsignacao.FormShow(Sender: TObject);
begin
  inherited;
  If (Not Assigned(dtsSintetExt)) Or (Not Assigned(dtsAnalitExt)) Then
    blnFecharForm := True
  Else
  Begin
    WindowState := wsMaximized;
    dtsSinteticoCol.DataSet := dtsSintetExt;
    dtsAnaliticoCol.DataSet := dtsAnalitExt;
    pIniciarDadosSintet;
    pIniciarDadosAnalit;
    blnFinalizouFormShow := True;
  End;
end;

procedure TfrmConfigFaturaConsignacao.pOrdenaColunasSintet;
var
  cdsOrd, cdsBkp: TUniClientDataSet;
  strFields: String;
  strDescFields: String;
  strBookMark: TBookMark;
  idxIndice : TIndexDef;
begin
  Try
    cdsOrd := TUniClientDataSet(dtsSintetExt);

    cdsBkp := TUniClientDataSet.Create(Self);
    cdsBkp.Data := cdsOrd.Data;

    cdsOrd.IndexDefs.Clear;
    cdsOrd.IndexName := '';
    cdsOrd.StoreDefs := False;
    cdsOrd.IndexFieldNames := '';

    if not cdsColOrdSintetico.IsEmpty then
    Begin
      strBookMark := cdsColOrdSintetico.GetBookMark;
      cdsColOrdSintetico.DisableControls;
      cdsColOrdSintetico.first;
      While not cdsColOrdSintetico.eof do
      Begin
        if cdsColOrdSintetico.FieldByName('ORDDSC').AsString = 'S' then
        Begin
          if fEmptyStr(strDescFields) then
            strDescFields := cdsColOrdSintetico.FieldByName('ORDNAM').AsString
          else
            strDescFields := strFields + ';' + cdsColOrdSintetico.FieldByName('ORDNAM').AsString;
        End;

        if fEmptyStr(strFields) then
          strFields := cdsColOrdSintetico.FieldByName('ORDNAM').AsString
        else
          strFields := strFields + ';' + cdsColOrdSintetico.FieldByName('ORDNAM').AsString;

        cdsColOrdSintetico.Next;
      End;
      cdsColOrdSintetico.EnableControls;
      cdsColOrdSintetico.BookMark := strBookMark;

      cdsOrd.Active := False;

      idxIndice            := cdsOrd.IndexDefs.AddIndexDef;
      idxIndice.Name       := 'IDX_001';
      idxIndice.Fields     := strFields;
      idxIndice.DescFields := strDescFields;

      cdsOrd.IndexName := 'IDX_001';

      cdsOrd.CreateDataSet;
      cdsOrd.Data := cdsBkp.Data;
    End;

  Finally
    FreeAndNil(cdsBkp);
  End;
end;

procedure TfrmConfigFaturaConsignacao.pMarcarColunasExibicaoAnalit
  (blnMarcar: Boolean);
Var
  intRecNo: Integer;
begin
  cdsAnalitico.DisableControls;
  intRecNo := cdsAnalitico.RecNo;
  Try
    cdsAnalitico.first;

    While Not cdsAnalitico.eof do
    Begin
      cdsAnalitico.Edit;

      If blnMarcar Then
        cdsAnalitico.FieldByName('EXIBIR').AsString := 'S'
      Else
        cdsAnalitico.FieldByName('EXIBIR').AsString := 'N';

      cdsAnalitico.Post;

      pVisibilidadeColunaAnalit;

      cdsAnalitico.Next;
    End;

    cdsAnalitico.first;
  Finally
    cdsAnalitico.RecNo := intRecNo;
    cdsAnalitico.EnableControls;
  End;
end;

procedure TfrmConfigFaturaConsignacao.pMarcarColunasExibicaoSintet
  (blnMarcar: Boolean);
Var
  intRecNo: Integer;
begin
  cdsSintetico.DisableControls;
  intRecNo := cdsSintetico.RecNo;
  Try
    cdsSintetico.first;

    While Not cdsSintetico.eof do
    Begin
      cdsSintetico.Edit;

      If blnMarcar Then
        cdsSintetico.FieldByName('EXIBIR').AsString := 'S'
      Else
        cdsSintetico.FieldByName('EXIBIR').AsString := 'N';

      cdsSintetico.Post;

      pVisibilidadeColunaSintet;

      cdsSintetico.Next;
    End;

    cdsSintetico.first;
  Finally
    cdsSintetico.RecNo := intRecNo;
    cdsSintetico.EnableControls;
  End;
end;

procedure TfrmConfigFaturaConsignacao.pVisibilidadeColunaAnalit;
Var
  Column: TColumn;
begin
  inherited;
  If (Not fEmptyStr(cdsAnalitico.FieldByName('COLNAM').AsString)) Then
  Begin
    Column := fFindColumnByName(dbgAnalitEstrutura,
      cdsAnalitico.FieldByName('COLNAM').AsString);

    If (Column <> Nil) Then
      Column.Visible := (cdsAnalitico.FieldByName('EXIBIR').AsString = 'S');
  End;
end;

procedure TfrmConfigFaturaConsignacao.pVisibilidadeColunaSintet;
Var
  Column: TColumn;
begin
  inherited;
  If (Not fEmptyStr(cdsSintetico.FieldByName('COLNAM').AsString)) Then
  Begin
    Column := fFindColumnByName(dbgSintetEstrutura,
      cdsSintetico.FieldByName('COLNAM').AsString);

    If (Column <> Nil) Then
      Column.Visible := (cdsSintetico.FieldByName('EXIBIR').AsString = 'S');
  End;
end;

procedure TfrmConfigFaturaConsignacao.pAjustaColunasDeExibicaoAnalit;
Var
  intCnt: Integer;
  intRecNo: Integer;
begin
  intRecNo := cdsAnalitico.RecNo;
  cdsAnalitico.DisableControls;
  Try
    For intCnt := 0 To dbgAnalitEstrutura.Columns.Count - 1 Do
    begin
      If cdsAnalitico.locate('COLNAM', dbgAnalitEstrutura.Columns[intCnt].FieldName, []) Then
      begin
        cdsAnalitico.Edit;
        cdsAnalitico.FieldByName('ORDCAM').AsInteger := intCnt + 1;
        cdsAnalitico.FieldByName('EXIBIR').AsString :=
          IIF(dbgAnalitEstrutura.Columns[intCnt].Visible, 'S', 'N');
        cdsAnalitico.Post;
      end;
    end;
  Finally
    cdsAnalitico.RecNo := intRecNo;
    cdsAnalitico.EnableControls;
  End;
end;

procedure TfrmConfigFaturaConsignacao.pAjustaColunasDeExibicaoSintet;
Var
  intCnt: Integer;
  intRecNo: Integer;
begin
  intRecNo := cdsSintetico.RecNo;
  cdsSintetico.DisableControls;
  Try
    For intCnt := 0 To dbgSintetEstrutura.Columns.Count - 1 Do
    begin
      If cdsSintetico.locate('COLNAM', dbgSintetEstrutura.Columns[intCnt]
        .FieldName, []) Then
      begin
        cdsSintetico.Edit;
        cdsSintetico.FieldByName('ORDCAM').AsInteger := intCnt + 1;
        cdsSintetico.FieldByName('EXIBIR').AsString :=
          IIF(dbgSintetEstrutura.Columns[intCnt].Visible, 'S', 'N');
        cdsSintetico.Post;
      end;
    end;
  Finally
    cdsSintetico.RecNo := intRecNo;
    cdsSintetico.EnableControls;
  End;
end;

procedure TfrmConfigFaturaConsignacao.pIndexarColunasVisiveisAnalit;
Var
  Column: TColumn;
  intRecNo: Integer;
begin
  cdsAnalitico.DisableControls;
  intRecNo := cdsAnalitico.RecNo;
  Try
    cdsAnalitico.first;
    While Not cdsAnalitico.eof Do
    Begin
      Column := fFindColumnByName(dbgAnalitEstrutura,
        cdsAnalitico.FieldByName('COLNAM').AsString);

      If (Column <> Nil) Then
        Column.Index := cdsAnalitico.FieldByName('ORDCAM').AsInteger - 1;

      cdsAnalitico.Next;
    End;
    cdsAnalitico.first;
  Finally
    cdsAnalitico.RecNo := intRecNo;
    cdsAnalitico.EnableControls;
  End;
end;

procedure TfrmConfigFaturaConsignacao.pIndexarColunasVisiveisSintet;
Var
  Column: TColumn;
  intRecNo: Integer;
begin
  cdsSintetico.DisableControls;
  intRecNo := cdsSintetico.RecNo;
  Try
    cdsSintetico.first;
    While Not cdsSintetico.eof Do
    Begin
      Column := fFindColumnByName(dbgSintetEstrutura,
        cdsSintetico.FieldByName('COLNAM').AsString);

      If (Column <> Nil) Then
        Column.Index := cdsSintetico.FieldByName('ORDCAM').AsInteger - 1;

      cdsSintetico.Next;
    End;
    cdsSintetico.first;
  Finally
    cdsSintetico.RecNo := intRecNo;
    cdsSintetico.EnableControls;
  End;
end;

procedure TfrmConfigFaturaConsignacao.pAlteraOrdemColunaAnalit
  (blnSobe: Boolean);
Var
  strCodAtu: String;
Begin
  If cdsAnalitico.RecordCount < 2 then
    Exit;

  If (cdsAnalitico.FieldByName('ORDCAM').AsInteger = 1) And blnSobe then
    Exit;

  If (cdsAnalitico.FieldByName('ORDCAM').AsInteger = cdsAnalitico.RecordCount)
    And (Not blnSobe) then
    Exit;

  cdsAnalitico.DisableControls;
  Try
    strCodAtu := cdsAnalitico.FieldByName('COLNAM').AsString;

    If blnSobe Then
    Begin
      cdsAnalitico.Prior;
      cdsAnalitico.Edit;
      cdsAnalitico.FieldByName('ORDCAM').AsInteger :=
        Succ(cdsAnalitico.FieldByName('ORDCAM').AsInteger);
      cdsAnalitico.Post;

      If cdsAnalitico.locate('COLNAM', strCodAtu, []) Then
      Begin
        cdsAnalitico.Edit;
        cdsAnalitico.FieldByName('ORDCAM').AsInteger :=
          Pred(cdsAnalitico.FieldByName('ORDCAM').AsInteger);
        cdsAnalitico.Post;
      End;
    End
    Else
    Begin
      cdsAnalitico.Next;
      cdsAnalitico.Edit;
      cdsAnalitico.FieldByName('ORDCAM').AsInteger :=
        Pred(cdsAnalitico.FieldByName('ORDCAM').AsInteger);
      cdsAnalitico.Post;

      If cdsAnalitico.locate('COLNAM', strCodAtu, []) Then
      Begin
        cdsAnalitico.Edit;
        cdsAnalitico.FieldByName('ORDCAM').AsInteger :=
          Succ(cdsAnalitico.FieldByName('ORDCAM').AsInteger);
        cdsAnalitico.Post;
      End;
    End;
  Finally
    cdsAnalitico.EnableControls;
  End;
end;

procedure TfrmConfigFaturaConsignacao.pAlteraOrdemColunaSintet
  (blnSobe: Boolean);
Var
  strCodAtu: String;
Begin
  If cdsSintetico.RecordCount < 2 then
    Exit;

  If (cdsSintetico.FieldByName('ORDCAM').AsInteger = 1) And blnSobe then
    Exit;

  If (cdsSintetico.FieldByName('ORDCAM').AsInteger = cdsSintetico.RecordCount)
    And (Not blnSobe) then
    Exit;

  cdsSintetico.DisableControls;
  Try
    strCodAtu := cdsSintetico.FieldByName('COLNAM').AsString;

    If blnSobe Then
    Begin
      cdsSintetico.Prior;
      cdsSintetico.Edit;
      cdsSintetico.FieldByName('ORDCAM').AsInteger :=
        Succ(cdsSintetico.FieldByName('ORDCAM').AsInteger);
      cdsSintetico.Post;

      If cdsSintetico.locate('COLNAM', strCodAtu, []) Then
      Begin
        cdsSintetico.Edit;
        cdsSintetico.FieldByName('ORDCAM').AsInteger :=
          Pred(cdsSintetico.FieldByName('ORDCAM').AsInteger);
        cdsSintetico.Post;
      End;
    End
    Else
    Begin
      cdsSintetico.Next;
      cdsSintetico.Edit;
      cdsSintetico.FieldByName('ORDCAM').AsInteger :=
        Pred(cdsSintetico.FieldByName('ORDCAM').AsInteger);
      cdsSintetico.Post;

      If cdsSintetico.locate('COLNAM', strCodAtu, []) Then
      Begin
        cdsSintetico.Edit;
        cdsSintetico.FieldByName('ORDCAM').AsInteger :=
          Succ(cdsSintetico.FieldByName('ORDCAM').AsInteger);
        cdsSintetico.Post;
      End;
    End;
  Finally
    cdsSintetico.EnableControls;
  End;
end;

procedure TfrmConfigFaturaConsignacao.pAlteraOrdemRegistrosAnalit
  (blnSobe: Boolean);
Var
  strCodAtu: String;
Begin
  If cdsColOrdAnalitico.RecordCount < 2 then
    Exit;

  If (cdsColOrdAnalitico.FieldByName('ORDCAM').AsInteger = 1) And blnSobe then
    Exit;

  If (cdsColOrdAnalitico.FieldByName('ORDCAM')
    .AsInteger = cdsAnalitico.RecordCount) And (Not blnSobe) then
    Exit;

  cdsColOrdAnalitico.DisableControls;
  Try
    strCodAtu := cdsColOrdAnalitico.FieldByName('ORDNAM').AsString;

    If blnSobe Then
    Begin
      cdsColOrdAnalitico.Prior;
      cdsColOrdAnalitico.Edit;
      cdsColOrdAnalitico.FieldByName('ORDCAM').AsInteger :=
        Succ(cdsColOrdAnalitico.FieldByName('ORDCAM').AsInteger);
      cdsColOrdAnalitico.Post;

      If cdsColOrdAnalitico.locate('ORDNAM', strCodAtu, []) Then
      Begin
        cdsColOrdAnalitico.Edit;
        cdsColOrdAnalitico.FieldByName('ORDCAM').AsInteger :=
          Pred(cdsColOrdAnalitico.FieldByName('ORDCAM').AsInteger);
        cdsColOrdAnalitico.Post;
      End;
    End
    Else
    Begin
      cdsColOrdAnalitico.Next;
      cdsColOrdAnalitico.Edit;
      cdsColOrdAnalitico.FieldByName('ORDCAM').AsInteger :=
        Pred(cdsColOrdAnalitico.FieldByName('ORDCAM').AsInteger);
      cdsColOrdAnalitico.Post;

      If cdsColOrdAnalitico.locate('ORDNAM', strCodAtu, []) Then
      Begin
        cdsColOrdAnalitico.Edit;
        cdsColOrdAnalitico.FieldByName('ORDCAM').AsInteger :=
          Succ(cdsColOrdAnalitico.FieldByName('ORDCAM').AsInteger);
        cdsColOrdAnalitico.Post;
      End;
    End;
  Finally
    cdsColOrdAnalitico.EnableControls;
  End;
end;

procedure TfrmConfigFaturaConsignacao.pAlteraOrdemRegistrosSintet
  (blnSobe: Boolean);
Var
  strCodAtu: String;
Begin
  If cdsColOrdSintetico.RecordCount < 2 then
    Exit;

  If (cdsColOrdSintetico.FieldByName('ORDCAM').AsInteger = 1) And blnSobe then
    Exit;

  If (cdsColOrdSintetico.FieldByName('ORDCAM')
    .AsInteger = cdsSintetico.RecordCount) And (Not blnSobe) then
    Exit;

  cdsColOrdSintetico.DisableControls;
  Try
    strCodAtu := cdsColOrdSintetico.FieldByName('ORDNAM').AsString;

    If blnSobe Then
    Begin
      cdsColOrdSintetico.Prior;
      cdsColOrdSintetico.Edit;
      cdsColOrdSintetico.FieldByName('ORDCAM').AsInteger :=
        Succ(cdsColOrdSintetico.FieldByName('ORDCAM').AsInteger);
      cdsColOrdSintetico.Post;

      If cdsColOrdSintetico.locate('ORDNAM', strCodAtu, []) Then
      Begin
        cdsColOrdSintetico.Edit;
        cdsColOrdSintetico.FieldByName('ORDCAM').AsInteger :=
          Pred(cdsColOrdSintetico.FieldByName('ORDCAM').AsInteger);
        cdsColOrdSintetico.Post;
      End;
    End
    Else
    Begin
      cdsColOrdSintetico.Next;
      cdsColOrdSintetico.Edit;
      cdsColOrdSintetico.FieldByName('ORDCAM').AsInteger :=
        Pred(cdsColOrdSintetico.FieldByName('ORDCAM').AsInteger);
      cdsColOrdSintetico.Post;

      If cdsColOrdSintetico.locate('ORDNAM', strCodAtu, []) Then
      Begin
        cdsColOrdSintetico.Edit;
        cdsColOrdSintetico.FieldByName('ORDCAM').AsInteger :=
          Succ(cdsColOrdSintetico.FieldByName('ORDCAM').AsInteger);
        cdsColOrdSintetico.Post;
      End;
    End;
  Finally
    cdsColOrdSintetico.EnableControls;
  End;
end;

procedure TfrmConfigFaturaConsignacao.pOrdenaColunasAnalit;
var
  cdsOrd, cdsBkp: TUniClientDataSet;
  strFields: String;
  strDescFields: String;
  strBookMark: TBookMark;
  idxIndice : TIndexDef;
begin
  Try
    cdsOrd := TUniClientDataSet(dtsAnalitExt);

    cdsBkp := TUniClientDataSet.Create(Self);
    cdsBkp.Data := cdsOrd.Data;

    cdsOrd.IndexDefs.Clear;
    cdsOrd.IndexName := '';
    cdsOrd.StoreDefs := False;
    cdsOrd.IndexFieldNames := '';

    if not cdsColOrdAnalitico.IsEmpty then
    Begin
      strBookMark := cdsColOrdAnalitico.GetBookMark;
      cdsColOrdAnalitico.DisableControls;
      cdsColOrdAnalitico.first;
      While not cdsColOrdAnalitico.eof do
      Begin
        if cdsColOrdAnalitico.FieldByName('ORDDSC').AsString = 'S' then
        Begin
          if fEmptyStr(strDescFields) then
            strDescFields := cdsColOrdAnalitico.FieldByName('ORDNAM').AsString
          else
            strDescFields := strFields + ';' + cdsColOrdAnalitico.FieldByName('ORDNAM').AsString;
        End;

        if fEmptyStr(strFields) then
          strFields := cdsColOrdAnalitico.FieldByName('ORDNAM').AsString
        else
          strFields := strFields + ';' + cdsColOrdAnalitico.FieldByName('ORDNAM').AsString;

        cdsColOrdAnalitico.Next;
      End;
      cdsColOrdAnalitico.EnableControls;
      cdsColOrdAnalitico.BookMark := strBookMark;

      cdsOrd.Active := False;

      idxIndice            := cdsOrd.IndexDefs.AddIndexDef;
      idxIndice.Name       := 'IDX_001';
      idxIndice.Fields     := strFields;
      idxIndice.DescFields := strDescFields;

      cdsOrd.IndexName := 'IDX_001';

      cdsOrd.CreateDataSet;
      cdsOrd.Data := cdsBkp.Data;
    End;

  Finally
    FreeAndNil(cdsBkp);
  End;
end;

procedure TfrmConfigFaturaConsignacao.pCarregaOrdExpAnalit;
var
  qryTmp: TUniQuery;
Begin
  Try
    qryTmp := fCriaQuery;

    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add('SELECT * FROM ORDFCA          ');
    qryTmp.SQL.Add(' WHERE FCA_CODEMP = :CODEMP   ');
    qryTmp.SQL.Add(' ORDER BY FCA_ORDCAM ');
    qryTmp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTmp.Open;

    While not qryTmp.eof do
    Begin
      cdsColOrdAnalitico.Insert;
      cdsColOrdAnalitico.FieldByName('ORDNAM').AsString  := qryTmp.FieldByName('FCA_ORDNAM').AsString;
      cdsColOrdAnalitico.FieldByName('ORDCAP').AsString  := qryTmp.FieldByName('FCA_ORDCAP').AsString;
      cdsColOrdAnalitico.FieldByName('ORDCAM').AsInteger := qryTmp.FieldByName('FCA_ORDCAM').AsInteger;
      cdsColOrdAnalitico.FieldByName('ORDDSC').AsString :=  qryTmp.FieldByName('FCA_ORDDSC').AsString;
      cdsColOrdAnalitico.Post;

      qryTmp.Next;
    End;
  Finally
    FreeAndNil(qryTmp);
  End;
end;

procedure TfrmConfigFaturaConsignacao.pCarregaOrdExpSintet;
var
  qryTmp: TUniQuery;
Begin
  Try
    qryTmp := fCriaQuery;

    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add('SELECT * FROM ORDFCS          ');
    qryTmp.SQL.Add(' WHERE FCS_CODEMP = :CODEMP   ');
    qryTmp.SQL.Add(' ORDER BY FCS_ORDCAM ');
    qryTmp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTmp.Open;

    While not qryTmp.eof do
    Begin
      cdsColOrdSintetico.Insert;
      cdsColOrdSintetico.FieldByName('ORDNAM').AsString  := qryTmp.FieldByName('FCS_ORDNAM').AsString;
      cdsColOrdSintetico.FieldByName('ORDCAP').AsString  := qryTmp.FieldByName('FCS_ORDCAP').AsString;
      cdsColOrdSintetico.FieldByName('ORDCAM').AsInteger := qryTmp.FieldByName('FCS_ORDCAM').AsInteger;
      cdsColOrdSintetico.FieldByName('ORDDSC').AsString  := qryTmp.FieldByName('FCS_ORDDSC').AsString;
      cdsColOrdSintetico.Post;

      qryTmp.Next;
    End;
  Finally
    FreeAndNil(qryTmp);
  End;

end;

procedure TfrmConfigFaturaConsignacao.pIniciarDadosSintet;
Var
  intCnt: Integer;
  recColExpFatCon: TrecColExpFaturaConsig;
begin
  dtsSinteticoCol.DataSet.DisableControls;
  Try
    For intCnt := Low(TCfgColExpFaturaConsig.arrColsOri) To High(TCfgColExpFaturaConsig.arrColsOri) Do
    Begin
      recColExpFatCon := TCfgColExpFaturaConsig.arrColsOri[intCnt];
      pAdicionarColunaExibicaoEOrdemSintet(recColExpFatCon);
      pAdicionarColunaPreVisualizacaoSintet(intCnt, recColExpFatCon);
    End;

    TCfgColExpFaturaConsig.pSetarUltimosDadosCarregados(dbgSintetEstrutura);

    pAjustaColunasDeExibicaoSintet;

    cdsSintetico.first;
  Finally
    dtsSinteticoCol.DataSet.EnableControls;
  End;
end;

procedure TfrmConfigFaturaConsignacao.pIniciarDadosAnalit;
Var
  intCnt: Integer;
  recColExpFatCon: TrecColExpFaturaConsig;
begin
  dtsAnaliticoCol.DataSet.DisableControls;
  Try
    For intCnt := Low(TCfgColExpFaturaConsig.arrColsOriAnalit) To High(TCfgColExpFaturaConsig.arrColsOriAnalit) Do
    Begin
      recColExpFatCon := TCfgColExpFaturaConsig.arrColsOriAnalit[intCnt];
      pAdicionarColunaExibicaoEOrdemAnalit(recColExpFatCon);
      pAdicionarColunaPreVisualizacaoAnalit(intCnt, recColExpFatCon);
    End;

    TCfgColExpFaturaConsig.pSetarUltimosDadosCarregadosAnalit(dbgAnalitEstrutura);

    pAjustaColunasDeExibicaoAnalit;

    cdsAnalitico.first;
  Finally
    dtsAnaliticoCol.DataSet.EnableControls;
  End;
end;

procedure TfrmConfigFaturaConsignacao.pAdicionarColunaExibicaoEOrdemAnalit(recColExp: TrecColExpFaturaConsig);
begin
  cdsAnalitico.Append;
  cdsAnalitico.FieldByName('EXIBIR').AsString :=
    IIF(recColExp.blnVisible, 'S', 'N');
  cdsAnalitico.FieldByName('ORDCAM').AsInteger := recColExp.intIndex + 1;
  cdsAnalitico.FieldByName('COLCAP').AsString := recColExp.strCaption;
  cdsAnalitico.FieldByName('COLNAM').AsString := recColExp.strFieldName;
  cdsAnalitico.Post;
  cdsAnalitico.first;
end;

procedure TfrmConfigFaturaConsignacao.pAdicionarColunaExibicaoEOrdemSintet(recColExp: TrecColExpFaturaConsig);
begin
  cdsSintetico.Append;
  cdsSintetico.FieldByName('EXIBIR').AsString :=
    IIF(recColExp.blnVisible, 'S', 'N');
  cdsSintetico.FieldByName('ORDCAM').AsInteger := recColExp.intIndex + 1;
  cdsSintetico.FieldByName('COLCAP').AsString := recColExp.strCaption;
  cdsSintetico.FieldByName('COLNAM').AsString := recColExp.strFieldName;
  cdsSintetico.Post;
  cdsSintetico.first;
end;

procedure TfrmConfigFaturaConsignacao.pAdicionarColunaPreVisualizacaoAnalit(intIndex: Integer; recColExp: TrecColExpFaturaConsig);
begin
  dbgAnalitEstrutura.Columns.Add;
  dbgAnalitEstrutura.Columns[intIndex].FieldName := recColExp.strFieldName;
  dbgAnalitEstrutura.Columns[intIndex].Title.Caption := recColExp.strCaption;
  dbgAnalitEstrutura.Columns[intIndex].Alignment := recColExp.Alignment;
  dbgAnalitEstrutura.Columns[intIndex].Width := recColExp.intWidth;
  dbgAnalitEstrutura.Columns[intIndex].Visible := recColExp.blnVisible;
end;

procedure TfrmConfigFaturaConsignacao.pAdicionarColunaPreVisualizacaoSintet(intIndex: Integer; recColExp: TrecColExpFaturaConsig);
begin
  dbgSintetEstrutura.Columns.Add;
  dbgSintetEstrutura.Columns[intIndex].FieldName := recColExp.strFieldName;
  dbgSintetEstrutura.Columns[intIndex].Title.Caption := recColExp.strCaption;
  dbgSintetEstrutura.Columns[intIndex].Alignment := recColExp.Alignment;
  dbgSintetEstrutura.Columns[intIndex].Width := recColExp.intWidth;
  dbgSintetEstrutura.Columns[intIndex].Visible := recColExp.blnVisible;
end;

Class function TfrmConfigFaturaConsignacao.fIniciaConfiguracaoFatura(dtsSinteticoExt : TDataset; dtsAnaliticoExt : TDataset) : Boolean;
var
  frmConfigFaturaConsignacao: TfrmConfigFaturaConsignacao;
begin
  pCriarFormularios(TfrmConfigFaturaConsignacao, frmConfigFaturaConsignacao);
  try
    frmConfigFaturaConsignacao.dtsSintetExt := dtsSinteticoExt;
    frmConfigFaturaConsignacao.dtsAnalitExt := dtsAnaliticoExt;
    frmConfigFaturaConsignacao.ShowModal;
    Result := frmConfigFaturaConsignacao.blnConfirma;
  finally
    pFreeAndNil(frmConfigFaturaConsignacao);
  end;
end;



end.
