unit untCfgConsultaOcorrenciasCRM;

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
  dxColorEdit, cxColorComboBox, cxButtonEdit,
  cxVGrid, cxInplaceContainer, cxExtEditRepositoryItems,
  untCfgTel, untcxGridDBColumnHelper, untTypesCRM;

 type

  TfrmCfgConsultaOcorrenciaCRM = class(TfrmPai)
    pnlCfgExp: TPanel;
    cdsColExi: TUniClientDataSet;
    cdsColExiCOLCAP: TStringField;
    cdsColExiCOLNAM: TStringField;
    dtsCfgCol: TDataSource;
    cdsColExiEXIBIR: TStringField;
    cdsColExiORDCAM: TIntegerField;
    btnGravar: TBitBtnLocked;
    dtsVis: TDataSource;
    cdsColExiCOLTAM: TIntegerField;
    btnPadroes: TBitBtnLocked;
    cdsColOrd: TUniClientDataSet;
    IntegerField1: TIntegerField;
    dtsColOrd: TDataSource;
    StringField3: TStringField;
    StringField1: TStringField;
    StringField2: TStringField;
    pgcCfg: TPageControl;
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
    pnlAreaVis: TPanel;
    gagAreGrid: TGauge;
    lblPercentualGrid: TLabel;
    grbTamanhoFonte: TGroupBox;
    speTamanhoFonteConfig: TSpinEdit;
    dbgVisDB: TcxGridCitel;
    dbgVisDBTableView1: TcxGridDBTableViewCitel;
    dbgVisDBView: TcxGridDBTableViewCitel;
    dbgVisDBLvl1: TcxGridLevel;
    cdsColExiCOLEDI: TStringField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  private
    { Private declarations }
    blnColOrd,
    blnFecharForm : Boolean;
    blnFinalizouFormShow : Boolean;
    FCfgTela: TCfgTelaConsultaOcorrenciaCRM;

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
    procedure pCarregaOrd;
    function fGetWidthAtualGrid: Integer;
    function fGetWidthGrid: Integer;
    procedure pGravarDadosModoGrid;
    procedure pGravarDadosModoCalendario;
    procedure pAjustarExibicaoTela;
  public
    blnConfirma : Boolean;
    strTip_FC: String;
    FTipoExibicaoDados: tTipoExibicaoOcorrenciasCRM;
  End;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultaOcorrenciasCRM;

procedure TfrmCfgConsultaOcorrenciaCRM.FormClose(Sender: TObject; var Action: TCloseAction);
Begin
  inherited;

  If Assigned(FCfgTela) Then
    FreeAndNil(FCfgTela);
End;

procedure TfrmCfgConsultaOcorrenciaCRM.FormCreate(Sender: TObject);
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
End;

procedure TfrmCfgConsultaOcorrenciaCRM.FormShow(Sender: TObject);
Begin
  inherited;

  pgcCfg.ActivePageIndex := 0;

  Try
    FCfgTela := TCfgTelaConsultaOcorrenciaCRM.Create(strTip_FC);
    FCfgTela.CfgPorUsuario := True;
    pCarregaOrd;
    dtsVis.DataSet := frmConsultaOcorrenciasCRM.dbgOcorrenciasDBTableView1.DataController.DataSet;

    Application.ProcessMessages;
    WindowState := wsMaximized;
    Self.Repaint;
    Application.ProcessMessages;
    pIniciarDados;
    blnFinalizouFormShow := True;

  Except
    On Erro: Exception  Do
    Begin
      pMensagensErro(Erro.Message,'[TfrmConfigCnsOcorrenciaCRM.FormShow]');
    End;
  End;

End;

procedure TfrmCfgConsultaOcorrenciaCRM.btnDesmarcaTodosClick(Sender: TObject);
Begin
  inherited;

  pMarcarColunasExibicao(False);
  pAjustaColunasDeExibicao;
End;

procedure TfrmCfgConsultaOcorrenciaCRM.btnDownClick(Sender: TObject);
Begin
  inherited;

  pAlteraOrdemColuna(False);
  pIndexarColunasVisiveis;
End;

procedure TfrmCfgConsultaOcorrenciaCRM.btnGravarClick(Sender: TObject);

Begin
  inherited;

  Case FTipoExibicaoDados of
    tpGrid      :  pGravarDadosModoGrid;
    tpCalendario:  pGravarDadosModoCalendario;
  End;

  blnConfirma := True;
End;

procedure TfrmCfgConsultaOcorrenciaCRM.pGravarDadosModoCalendario;
begin
  pOrdenaColunas(frmConsultaOcorrenciasCRM.dbgOcorrenciasDBTableView1.DataController.DataSet);
  FCfgTela.pGravarDadosNoBanco(dbgVisDBView, cdsColOrd);
  FCfgTela.Sugestao.pGravarFonteGrid(speTamanhoFonteConfig.Value, FCfgTela.NomeObjeto);
end;

procedure TfrmCfgConsultaOcorrenciaCRM.pGravarDadosModoGrid;
begin
  pOrdenaColunas(frmConsultaOcorrenciasCRM.dbgOcorrenciasDBTableView1.DataController.DataSet);
  FCfgTela.pGravarDadosNoBanco(dbgVisDBView, cdsColOrd);
  FCfgTela.Sugestao.pGravarFonteGrid(speTamanhoFonteConfig.Value, FCfgTela.NomeObjeto);
end;

procedure TfrmCfgConsultaOcorrenciaCRM.btnMarcaTodosClick(Sender: TObject);
Begin
  inherited;

  pMarcarColunasExibicao(True);
  pAjustaColunasDeExibicao;
End;

procedure TfrmCfgConsultaOcorrenciaCRM.btnPadroesClick(Sender: TObject);
Begin
  inherited;

  FCfgTela.pRestaurarPadrao(dbgVisDbView);
  pAjustaColunasDeExibicao;
  FCfgTela.Sugestao.pGravarFonteGrid(FCfgTela.TamanhoFontePadrao);
  speTamanhoFonteConfig.Value := FCfgTela.TamanhoFontePadrao;
End;

procedure TfrmCfgConsultaOcorrenciaCRM.pCarregaOrd;
const
  SQLSelect = 'SELECT * FROM   ORDCOL      ' +
              ' WHERE                      ' +
              '   ORD_CODEMP = :CODEMP     ' +
              '   AND ORD_NOMFOR = :NOMFOR ' +
              '   AND ORD_CODOPE = :CODOPE ' +
              '   AND ORD_NOMGRD = :NOMGRD ' +
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
    qryTmp.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryTmp.ParamByName('NOMGRD').AsString := IIF(FTipoExibicaoDados = tpCalendario,
                                                 frmConsultaOcorrenciasCRM.ListViewCalendario.name,
                                                 frmConsultaOcorrenciasCRM.dbgOcorrenciasDBTableView1.name);
    qryTmp.Open;

    cdsColOrd.DisableControls;
    Try

      While Not qryTmp.eof do
      Begin
        cdsColOrd.Insert;
        cdsColOrd.FieldByName('ORDNAM').AsString  := qryTmp.FieldByName('ORD_ORDNAM').AsString ;
        cdsColOrd.FieldByName('ORDCAP').AsString  := qryTmp.FieldByName('ORD_ORDCAP').AsString ;
        cdsColOrd.FieldByName('ORDCAM').AsInteger := qryTmp.FieldByName('ORD_ORDCAM').AsInteger;
        cdsColOrd.FieldByName('ORDDSC').AsString  := qryTmp.FieldByName('ORD_ORDDSC').AsString ;
        cdsColOrd.Post;

        qryTmp.Next;
      End;

    Finally
      cdsColOrd.EnableControls;
    End;

  Finally
    FreeAndNil(qryTmp);
  End;

End;

procedure TfrmCfgConsultaOcorrenciaCRM.btnRightClick(Sender: TObject);
var
  intOrd: Integer;
Begin
  inherited;

  intOrd := cdsColOrd.RecordCount;
  If Not cdsColOrd.locate('ORDNAM', cdsColExi.FieldByName('COLNAM').AsString, []) Then
  Begin
    Inc(intOrd);

    cdsColOrd.DisableControls;
    Try
      cdsColOrd.Insert;
      cdsColOrd.FieldByName('ORDNAM').AsString  := cdsColExi.FieldByName('COLNAM').AsString ;
      cdsColOrd.FieldByName('ORDCAP').AsString  := cdsColExi.FieldByName('COLCAP').AsString ;
      cdsColOrd.FieldByName('ORDCAM').AsInteger := intOrd;
      cdsColOrd.FieldByName('ORDDSC').AsString  := 'N' ;
      cdsColOrd.Post;
    Finally
      cdsColOrd.EnableControls;
    End;
  End;

End;

procedure TfrmCfgConsultaOcorrenciaCRM.pAlteraOrdemRegistros(blnSobe: Boolean);
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

procedure TfrmCfgConsultaOcorrenciaCRM.btnUpOrdClick(Sender: TObject);
Begin
  inherited;

  pAlteraOrdemRegistros(True);
  pOrdenaColunas(dbgVisDBView.DataController.DataSet);
End;

procedure TfrmCfgConsultaOcorrenciaCRM.btnDownOrdClick(Sender: TObject);
Begin
  inherited;

  pAlteraOrdemRegistros(False);
  pOrdenaColunas(dbgVisDBView.DataController.DataSet);
End;

procedure TfrmCfgConsultaOcorrenciaCRM.btnLeftClick(Sender: TObject);
Begin
  inherited;

  If Not cdsColOrd.isEmpty Then
  Begin
    cdsColOrd.Delete;
    pOrdenaColunas(dbgVisDBView.DataController.DataSet);
  End;
End;

procedure TfrmCfgConsultaOcorrenciaCRM.pOrdenaColunas(DataSet: TDataSet);
Begin
  FCfgTela.pOrdenaColunas(DataSet, cdsColOrd);
End;

procedure TfrmCfgConsultaOcorrenciaCRM.btnUpClick(Sender: TObject);
Begin
  inherited;

  pAlteraOrdemColuna(True);
  pIndexarColunasVisiveis;
End;

procedure TfrmCfgConsultaOcorrenciaCRM.cdsColOrdAfterPost(DataSet: TDataSet);
Begin
  inherited;

  If blnColOrd Then
  Begin
    pOrdenaColunas(dbgVisDBView.DataController.DataSet);
    blnColOrd := False;
  End;
End;

procedure TfrmCfgConsultaOcorrenciaCRM.cxgColunasTableView1EXIBIRPropertiesEditValueChanged(
  Sender: TObject);
Begin
  inherited;

  pVisibilidadeColuna;
End;

procedure TfrmCfgConsultaOcorrenciaCRM.cxGridDBColumn3PropertiesEditValueChanged(
  Sender: TObject);
Begin
  inherited;

  If cdsColOrd.State = dsEdit Then
  Begin
    blnColOrd := True;
    cdsColOrd.Post;
  End;
End;

procedure TfrmCfgConsultaOcorrenciaCRM.dbgVisColumnMoved(Sender: TObject; FromIndex,
  ToIndex: Integer);
Begin
  inherited;

  pAjustaColunasDeExibicao;
End;

procedure TfrmCfgConsultaOcorrenciaCRM.dbgVisDBViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Begin
  inherited;

  If Not blnFinalizouFormShow Then
    Exit;

  gagAreGrid.Progress := fGetWidthAtualGrid;

End;

function TfrmCfgConsultaOcorrenciaCRM.fGetWidthGrid: Integer;
Var
  intCnt : Integer;
Begin
  Result := 0;
  For intCnt := 0 To dbgVisDBView.ColumnCount -1 Do
  Begin
    Result := Result + dbgVisDBView.Columns[intCnt].Width;
  End;
End;

function TfrmCfgConsultaOcorrenciaCRM.fGetWidthAtualGrid: Integer;
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

procedure TfrmCfgConsultaOcorrenciaCRM.FormPaint(Sender: TObject);
Begin
  inherited;

  If blnFecharForm Then
    Close;
End;

procedure TfrmCfgConsultaOcorrenciaCRM.pIniciarDados;
Var
  intCnt: Integer;
  recCol: TrecColGrid;
  strDescriCfg,
  strNomObjCfg: String;
Begin
  Case FTipoExibicaoDados of
    tpGrid      : Begin
                    strDescriCfg := FCfgTela.NomeFormulario + '.' + frmConsultaOcorrenciasCRM.dbgOcorrenciasDBTableView1.name;
                    strNomObjCfg := frmConsultaOcorrenciasCRM.dbgOcorrenciasDBTableView1.name;
                  End;
    tpCalendario: Begin
                    strDescriCfg := FCfgTela.NomeFormulario + '.' + frmConsultaOcorrenciasCRM.ListViewCalendario.name;
                    strNomObjCfg := frmConsultaOcorrenciasCRM.ListViewCalendario.name;
                  End;
  End;

  FCfgTela.pIniciar(frmConsultaOcorrenciasCRM.dbgOcorrencias,
                    frmConsultaOcorrenciasCRM.dbgOcorrenciasDBTableView1,
                    strNomObjCfg);

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

    FCfgTela.pConfigurarGrid(dbgVisDBView);
    pAjustarExibicaoTela;
    cdsColExi.First;
    gagAreGrid.MaxValue := fGetWidthGrid;

  Finally
    dtsVis.DataSet.EnableControls;
    dbgVisDB.EndUpdate;
    cxgColunas.EndUpdate;
    cxgColunasOrdenacao.EndUpdate;
    Application.ProcessMessages;
  End;
End;

procedure TfrmCfgConsultaOcorrenciaCRM.pVisibilidadeColuna;
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

procedure TfrmCfgConsultaOcorrenciaCRM.speTamanhoFonteConfigChange(
  Sender: TObject);
Begin
  inherited;

  If speTamanhoFonteConfig.Value <= 0 Then
  Begin
    speTamanhoFonteConfig.Value := 1;
  End;

  cxgColunas.Font.Size := speTamanhoFonteConfig.Value;
  cxgColunasOrdenacao.Font.Size  := speTamanhoFonteConfig.Value;
  dbgVisDB.Font.Size  := speTamanhoFonteConfig.Value;
End;

procedure TfrmCfgConsultaOcorrenciaCRM.pAdicionarColunaExibicaoEOrdem(recCol: TrecColGrid);
Begin
  If recCol.blnInterno Then
    Exit;

  If Not(fCfgSis('OCOAST', varBoolean)) and (recCol.strFieldName = 'OCO_ASSUNT') Then
    Exit;

  If Not(fCfgSis('SEGCND', varBoolean)) and (recCol.strFieldName = 'FGO_PREVIS') Then
    Exit;

  If (Not fUtilizarCategoriaParaPedidoOrcamento) Then
  Begin
   If (recCol.strFieldName = 'CAT_CORCAT') or (recCol.strFieldName = 'CAT_DESCRI') Then
     Exit;
  End;

  If Not(fCfgSis('USADEP', varBoolean)) and (recCol.strFieldName = 'STATUSDEPS') Then
    Exit;

  If Not(Pos(strTip_Fc, 'C_P_') > 0) and (recCol.strFieldName = 'FGO_VLRCON') Then
    Exit;

  If Not((Pos(strTip_Fc, 'C_P_') > 0) And fCfgSis('IFVLOR', varBoolean)) and (recCol.strFieldName = 'FGO_VALORC') Then
    Exit;

  If Not(Pos(strTip_Fc, 'C_P_') > 0) and (recCol.strFieldName = 'DOCUMENTO') Then
    Exit;

  cdsColExi.Append;
  cdsColExi.FieldByName('EXIBIR').AsString := IIF(recCol.blnVisible, 'S', 'N');
  cdsColExi.FieldByName('ORDCAM').AsInteger := recCol.intIndex + 1;
  cdsColExi.FieldByName('COLCAP').AsString := recCol.strCaption;
  cdsColExi.FieldByName('COLNAM').AsString := recCol.strFieldName;
  cdsColExi.Post;
  cdsColExi.First;
End;

procedure TfrmCfgConsultaOcorrenciaCRM.pAdicionarColunaPreVisualizacao(intIndex: Integer; recCol: TrecColGrid);
Begin

  dbgVisDBView.CreateColumn;
  Try
    dbgVisDBView.Columns[intIndex].DataBinding.FieldName := recCol.strFieldName;
    dbgVisDBView.Columns[intIndex].Caption   := recCol.strCaption;
    dbgVisDBView.Columns[intIndex].Width     := recCol.intWidth;
    dbgVisDBView.Columns[intIndex].Visible   := recCol.blnVisible And (Not recCol.blnInterno);
    If recCol.blnCheckBox Then
    Begin
      dbgVisDBView.Columns[intIndex].PropertiesClass := TcxCheckBoxProperties;
      TcxCheckBoxProperties(dbgVisDBView.Columns[intIndex].Properties).ValueChecked := 1;
      TcxCheckBoxProperties(dbgVisDBView.Columns[intIndex].Properties).ValueUnChecked := 0;
    End;
  Except
    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmConfigCnsOcorrenciaCRM.pAdicionarColunaPreVisualizacao]');
    End;
  End;
End;

procedure TfrmCfgConsultaOcorrenciaCRM.pMoverParaBaixo;
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

procedure TfrmCfgConsultaOcorrenciaCRM.pMoverParaCima;
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

procedure TfrmCfgConsultaOcorrenciaCRM.pAlteraOrdemColuna(blnSobe: Boolean);
Begin
  If cdsColExi.RecordCount < 2 Then
    Exit;

  If blnSobe Then
    pMoverParaCima
  Else
    pMoverParaBaixo;

End;

procedure TfrmCfgConsultaOcorrenciaCRM.pIndexarColunasVisiveis;
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

procedure TfrmCfgConsultaOcorrenciaCRM.pMarcarColunasExibicao(blnMarcar: Boolean);
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

procedure TfrmCfgConsultaOcorrenciaCRM.pAjustaColunasDeExibicao;
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


procedure TfrmCfgConsultaOcorrenciaCRM.pAjustarExibicaoTela;
begin
  Case FTipoExibicaoDados of
    tpGrid      : Begin
                    lblPercentualGrid.Caption := '% Utilizado do Grid';
                    tbsColunas.Caption := 'Colunas do Grid';
                  End;
    tpCalendario: Begin
                    lblPercentualGrid.Caption := '% Campos Utilizados ';
                    tbsColunas.Caption := 'Colunas do Detalhamento de Agendamento';

                  End;
  End;

  FCfgTela.Sugestao.pCarregarTamanhoFonteObj(FCfgTela.NomeObjeto);
  speTamanhoFonteConfig.Value := FCfgTela.Sugestao.TamanhoFonte;
  If cxgColunas.Font.Size <= 0 Then
  Begin
    speTamanhoFonteConfig.Value := FCfgTela.TamanhoFontePadrao;
  End;

end;

End.
