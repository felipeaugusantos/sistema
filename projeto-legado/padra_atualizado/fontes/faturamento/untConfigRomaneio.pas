unit untConfigRomaneio;

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
  Datasnap.DBClient, UniClientDataSet,untCorGrid, untCfgColRom,Uni,untFatRomaneio ;

type
  TfrmConfigRomaneio = class(TfrmPai)
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
    pnlAreaVis: TPanel;
    btnGravar: TBitBtnLocked;
    btnPadroes: TBitBtnLocked;
    ApplicationEvents1: TApplicationEvents;
    frxCSVExportTestabilidade1: TfrxCSVExportTestabilidade;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    cdsColRom: TUniClientDataSet;
    cdsColRomEXIBIR: TStringField;
    cdsColRomCOLCAP: TStringField;
    cdsColRomCOLNAM: TStringField;
    cdsColRomORDCAM: TIntegerField;
    cdsColRomCOLTAM: TIntegerField;
    dtsCfgCol: TDataSource;
    dtsColOrd: TDataSource;
    cdsColOrd: TUniClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    IntegerField1: TIntegerField;
    StringField3: TStringField;
    dtsVisRom: TDataSource;
    cxEditRepository1: TcxEditRepository;
    ccbCores: TcxEditRepositoryColorComboBox;
    dbgVisRom: TcxGridCitel;
    dbgVisRomDBView: TcxGridDBTableViewCitel;
    cxGridLevel2: TcxGridLevel;
    grbPainelObservacoes: TGroupBox;
    chkDadosAdicionaisNF: TCheckBox;
    chkObservacoesExpedicao: TCheckBox;
    chkObservacoes: TCheckBox;
    chkFeriados: TCheckBox;
    chkOrientacoes: TCheckBox;
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
    procedure pAdicionarColunaPreVisualizacao(intIndex: Integer; recColRom: TrecColRom);
    procedure pAdicionarColunaExibicaoEOrdem(recColRom: TrecColRom);
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
    procedure pCarregaOrdRom;

    procedure pCarregaObsRom;
    procedure pGravar_ObsRom;

    procedure pVisibilidadeColuna;
    function VerificarOrdenacaoSubir(blnSobe : Boolean) : Boolean;
    function VerificarOrdenacaoDescer(blnSobe : Boolean) : Boolean;

  public
    { Public declarations }
    frmFatRomaneio        : TfrmFatRomaneio;
    blnConfirma : Boolean;
  end;

implementation

Uses untFuncoesSimples, untTypesSistema;

{$R *.dfm}

procedure TfrmConfigRomaneio.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarColunasExibicao(False);
  pAjustaColunasDeExibicao;
end;

procedure TfrmConfigRomaneio.btnDownClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemColuna(False);
  pIndexarColunasVisiveis;

end;

procedure TfrmConfigRomaneio.btnDownOrdClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemRegistros(False);
  pOrdenaColunas;

end;

procedure TfrmConfigRomaneio.btnGravarClick(Sender: TObject);
  Var
    arrCol : TArrayOfColRom;
begin
  inherited;
  TCfgColRom.pSalvarEstado(dbgVisRomDBView, arrCol);
  TCfgColRom.pGravarDadosNoBanco(arrCol, cdsColOrd);
  pGravar_ObsRom;
  blnConfirma := True;
end;

procedure TfrmConfigRomaneio.btnLeftClick(Sender: TObject);
begin
  inherited;
  if not cdsColOrd.isEmpty then
  Begin
    cdsColOrd.Delete;
    pOrdenaColunas;
  End;

end;

procedure TfrmConfigRomaneio.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarColunasExibicao(True);
  pAjustaColunasDeExibicao;
end;

procedure TfrmConfigRomaneio.btnPadroesClick(Sender: TObject);
begin
  inherited;
  TCfgColRom.pSetarPadrao(dbgVisRomDbView);
  pAjustaColunasDeExibicao;

  chkDadosAdicionaisNF.Checked    := True;
  chkObservacoesExpedicao.Checked := True;
  chkObservacoes.Checked          := True;
  chkFeriados.Checked             := False;
  chkOrientacoes.Checked          := False;
end;

procedure TfrmConfigRomaneio.btnRightClick(Sender: TObject);
var intOrd: Integer;
begin
  inherited;
  intOrd := cdsColOrd.RecordCount;
  if not cdsColOrd.locate('ORDNAM', cdsColRom.FieldByName('COLNAM').AsString, []) then
  Begin
    Inc(intOrd);
    cdsColOrd.Insert;
    cdsColOrd.FieldByName('ORDNAM').AsString  := cdsColRom.FieldByName('COLNAM').AsString ;
    cdsColOrd.FieldByName('ORDCAP').AsString  := cdsColRom.FieldByName('COLCAP').AsString ;
    cdsColOrd.FieldByName('ORDCAM').AsInteger := intOrd;
    cdsColOrd.FieldByName('ORDDSC').AsString  := 'N' ;
    cdsColOrd.Post;

    pOrdenaColunas;
  End;

end;

procedure TfrmConfigRomaneio.btnUpClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemColuna(True);
  pIndexarColunasVisiveis;

end;

procedure TfrmConfigRomaneio.btnUpOrdClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemRegistros(True);
  pOrdenaColunas;

end;

procedure TfrmConfigRomaneio.cdsColOrdAfterPost(DataSet: TDataSet);
begin
  inherited;
  if blnColOrd then
  Begin
    pOrdenaColunas;
    blnColOrd := False;
  End;

end;

procedure TfrmConfigRomaneio.cxgColunasTableView1EXIBIRPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  pVisibilidadeColuna;
end;

procedure TfrmConfigRomaneio.cxGridDBColumn3PropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  if cdsColOrd.State = dsEdit then
  begin
    blnColOrd := True;
    cdsColOrd.Post;
  End;
end;

procedure TfrmConfigRomaneio.FormCreate(Sender: TObject);
begin
  inherited;

  blnColOrd := False;
  blnFinalizouFormShow := False;
  blnFecharForm := False;
  blnConfirma := False;
  cdsColRom.CreateDataSet;
  cdsColRom.IndexFieldNames := 'ORDCAM';

  cdsColOrd.CreateDataSet;
  cdsColOrd.IndexFieldNames := 'ORDCAM';

  pCarregaOrdRom;
  pCarregaObsRom;

end;

procedure TfrmConfigRomaneio.FormShow(Sender: TObject);
begin
  inherited;
  WindowState       := wsMaximized;
  pgcCfgRom.ActivePageIndex := 0;
  dtsVisRom.DataSet := frmFatRomaneio.dbgDocumentosDBView.DataController.DataSet;
  pIniciarDados;
  blnFinalizouFormShow := True;

end;

function TfrmConfigRomaneio.fRetornarDescFields(strDescFields, strOrdNam,
  strFields: String): String;
begin
  Result := strOrdNam;

  if fEmptyStr(strDescFields) then
    Exit;

  Result := strFields + ';' + strOrdNam ;
end;

function TfrmConfigRomaneio.fRetornarFields(strFields,
  strOrdNam: String): String;
begin
  Result := strOrdNam;

  if fEmptyStr(strFields) then
   Exit;

  Result := strFields + ';' + strOrdNam;
end;

function TfrmConfigRomaneio.fValidarAlterarColunaDescer(
  blnSobe: Boolean): Boolean;
begin
  result := true;

  If Not (cdsColRom.FieldByName('ORDCAM').AsInteger = cdsColRom.RecordCount)Then
    Exit;

  if (blnSobe)then
    Exit;

  Result := false;
end;

function TfrmConfigRomaneio.fValidarAlterarColunaSubir(
  blnSobe: Boolean): Boolean;
begin
  Result := true;

  If Not (cdsColRom.FieldByName('ORDCAM').AsInteger = 1) then
    Exit;

  If not blnSobe then
    exit;

  Result := false;
end;

procedure TfrmConfigRomaneio.pAdicionarColunaExibicaoEOrdem(
  recColRom: TrecColRom);
var
  strOpcRom: String;
  blnAdicionarCol: Boolean;
begin

  blnAdicionarCol := True;

  If (recColRom.strFieldName = 'ENTURG') Then
  Begin
    strOpcRom := fCfgSis('OPCROM', varstring);
    blnAdicionarCol := (Pos(strOpcRom, '1_5_') > 0);
  End;

  If blnAdicionarCol Then
  Begin
    cdsColRom.Append;
    cdsColRom.FieldByName('EXIBIR').AsString  := IIF(recColRom.blnVisible, 'S', 'N');
    cdsColRom.FieldByName('ORDCAM').AsInteger := recColRom.intIndex + 1;
    cdsColRom.FieldByName('COLCAP').AsString  := recColRom.strCaption;
    cdsColRom.FieldByName('COLNAM').AsString  := recColRom.strFieldName;
    cdsColRom.Post;
    cdsColRom.First;
  End;

end;

procedure TfrmConfigRomaneio.pAdicionarColunaPreVisualizacao(intIndex: Integer;
  recColRom: TrecColRom);
begin
  dbgVisRomDBView.CreateColumn;
  dbgVisRomDBView.Columns[intIndex].DataBinding.FieldName := recColRom.strFieldName;
  dbgVisRomDBView.Columns[intIndex].Caption   := recColRom.strCaption;
  dbgVisRomDBView.Columns[intIndex].Width     := recColRom.intWidth;
  dbgVisRomDBView.Columns[intIndex].Visible   := recColRom.blnVisible;
  dbgVisRomDBView.Columns[intIndex].DataBinding.Field.Alignment := recColRom.Alignment;
end;

procedure TfrmConfigRomaneio.pAjustaColunasDeExibicao;
  Var
    intCnt : Integer;
    intRecNo : Integer;
begin
  intRecNo := cdsColRom.RecNo;
  cdsColRom.DisableControls;
  Try
    For intCnt := 0 To dbgVisRomDBView.ColumnCount-1 Do
    begin
      If cdsColRom.Locate('COLNAM', dbgVisRomDBView.Columns[intCnt].DataBinding.FieldName, []) Then
      begin
        cdsColRom.Edit;
        cdsColRom.FieldByName('ORDCAM').AsInteger := intCnt + 1;
        cdsColRom.FieldByName('EXIBIR').AsString := IIF(dbgVisRomDBView.Columns[intCnt].Visible, 'S', 'N');
        cdsColRom.Post;
      end;
    end;
  Finally
    cdsColRom.RecNo := intRecNo;
    cdsColRom.EnableControls;
  End;

end;

procedure TfrmConfigRomaneio.pAlteraOrdemColuna(blnSobe: Boolean);
Begin
  If cdsColRom.RecordCount < 2 then
    Exit;

  If Not fValidarAlterarColunaSubir(blnSobe)Then
    Exit;

  If Not fValidarAlterarColunaDescer(blnSobe) then
    Exit;


  pAlteraOrdemColunaSubirDescer(blnSobe);
end;

procedure TfrmConfigRomaneio.pAlteraOrdemColunaDescer;
Var
  strCodAtu: String;
Begin
  cdsColRom.DisableControls;

  Try
    strCodAtu := cdsColRom.FieldByName('COLNAM').AsString;

    cdsColRom.Next;
    cdsColRom.Edit;
    cdsColRom.FieldByName('ORDCAM').AsInteger := Pred(cdsColRom.FieldByName('ORDCAM').AsInteger);
    cdsColRom.Post;

    If cdsColRom.Locate('COLNAM', strCodAtu, []) Then
    Begin
      cdsColRom.Edit;
      cdsColRom.FieldByName('ORDCAM').AsInteger := Succ(cdsColRom.FieldByName('ORDCAM').AsInteger);
      cdsColRom.Post;
    End;

  Finally
    cdsColRom.EnableControls;
  End;

end;

procedure TfrmConfigRomaneio.pAlteraOrdemColunaSubir;
  Var
    strCodAtu: String;
Begin
  cdsColRom.DisableControls;

  Try
    strCodAtu := cdsColRom.FieldByName('COLNAM').AsString;

    cdsColRom.Prior;
    cdsColRom.Edit;
    cdsColRom.FieldByName('ORDCAM').AsInteger := Succ(cdsColRom.FieldByName('ORDCAM').AsInteger);
    cdsColRom.Post;

    If cdsColRom.Locate('COLNAM', strCodAtu, []) Then
    Begin
      cdsColRom.Edit;
      cdsColRom.FieldByName('ORDCAM').AsInteger := Pred(cdsColRom.FieldByName('ORDCAM').AsInteger);
      cdsColRom.Post;
    End;

  Finally
    cdsColRom.EnableControls;
  End;
end;

procedure TfrmConfigRomaneio.pAlteraOrdemColunaSubirDescer(blnSobe: Boolean);
begin
  If blnSobe Then
  begin
    pAlteraOrdemColunaSubir;
    Exit;
  end;

  pAlteraOrdemColunaDescer;

end;

procedure TfrmConfigRomaneio.pAlteraOrdemRegistros(blnSobe: Boolean);
Begin
  If cdsColOrd.RecordCount < 2 then
    Exit;

   If VerificarOrdenacaoSubir(blnSobe) then
    Exit;

  if VerificarOrdenacaoDescer(blnSobe) Then
    Exit;

  pGravarCdsOrdemDosRegistros(blnSobe);
end;

procedure TfrmConfigRomaneio.pCarregaObsRom;
Var
  qryTmp : TUniQuery;
Begin

  {Habilitado por padrão}
  chkDadosAdicionaisNF.Checked    := True;
  chkObservacoesExpedicao.Checked := True;
  chkObservacoes.Checked          := True;
  chkFeriados.Checked             := False;
  chkOrientacoes.Checked          := False;

  Try

    qryTmp := fCriaQuery;
    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add('SELECT * FROM OBSROM         ');
    qryTmp.SQL.Add(' WHERE ROM_TIPROM = :TIPROM  ');
    qryTmp.SQL.Add('   AND ROM_CODEMP = :CODEMP  ');
    qryTmp.ParamByName('TIPROM').AsString := fCfgSis('OPCROM', varString);
    qryTmp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTmp.Open;

    If Not qryTmp.IsEmpty Then
    Begin

      qryTmp.First;
      While Not qryTmp.Eof Do
      Begin

        Case TTipoObservacoes(qryTmp.FieldByName('ROM_TIPOBS').AsInteger) Of
          tpoDadosAdicionaisNF    : chkDadosAdicionaisNF.Checked    := (qryTmp.FieldByName('ROM_MOSTRA').AsString = 'S');
          tpoObservacoesExpedicao : chkObservacoesExpedicao.Checked := (qryTmp.FieldByName('ROM_MOSTRA').AsString = 'S');
          tpoObservacoes          : chkObservacoes.Checked          := (qryTmp.FieldByName('ROM_MOSTRA').AsString = 'S');
          tpoFeriados             : chkFeriados.Checked             := (qryTmp.FieldByName('ROM_MOSTRA').AsString = 'S');
          tpoOrientacoes          : chkOrientacoes.Checked          := (qryTmp.FieldByName('ROM_MOSTRA').AsString = 'S');
        End;

        qryTmp.Next;

      End;

    End;

  Finally
    FreeAndNil(qryTmp);
  End;

end;

procedure TfrmConfigRomaneio.pCarregaOrdRom;
Var
  qryTmp : TUniQuery;
Begin
  Try
    qryTmp := fCriaQuery;
    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add('SELECT * FROM ORDROM         ');
    qryTmp.SQL.Add(' WHERE ROM_TIPROM = :TIPROM  ');
    qryTmp.SQL.Add('   AND ROM_CODEMP = :CODEMP  ');
    qryTmp.SQL.Add(' ORDER BY ROM_ORDCAM ');
    qryTmp.ParamByName('TIPROM').AsString := fCfgSis('OPCROM', varString);
    qryTmp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTmp.Open;

    While not qryTmp.eof do
    Begin
      cdsColOrd.Insert;
      cdsColOrd.FieldByName('ORDNAM').AsString  := qryTmp.FieldByName('ROM_ORDNAM').AsString ;
      cdsColOrd.FieldByName('ORDCAP').AsString  := qryTmp.FieldByName('ROM_ORDCAP').AsString ;
      cdsColOrd.FieldByName('ORDCAM').AsInteger := qryTmp.FieldByName('ROM_ORDCAM').AsInteger ;
      cdsColOrd.FieldByName('ORDDSC').AsString  := qryTmp.FieldByName('ROM_ORDDSC').AsString ;
      cdsColOrd.Post;

      qryTmp.Next;
    End;
  Finally
    FreeAndNil(qryTmp);
  End;
end;


procedure TfrmConfigRomaneio.pGravarCdsOrdemDosRegistros(blnSobe: Boolean);
begin
  If blnSobe Then
  begin
    pGravarCdsOrdemDosRegistrosSubir;
    Exit;
  end;

  pGravarCdsOrdemDosRegistrosDescer;
end;

procedure TfrmConfigRomaneio.pGravarCdsOrdemDosRegistrosDescer;
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

procedure TfrmConfigRomaneio.pGravarCdsOrdemDosRegistrosSubir;
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

procedure TfrmConfigRomaneio.pGravar_ObsRom;
Var
  qryTmp : TUniQuery;
Begin

  Try

    qryTmp := fCriaQuery;

    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add('DELETE FROM OBSROM           ');
    qryTmp.SQL.Add(' WHERE ROM_TIPROM = :TIPROM  ');
    qryTmp.SQL.Add('   AND ROM_CODEMP = :CODEMP  ');
    qryTmp.ParamByName('TIPROM').AsString := fCfgSis('OPCROM', varString);
    qryTmp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTmp.ExecSQL;

    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add('SELECT * FROM OBSROM  WHERE FALSE ');
    qryTmp.Open;

    qryTmp.Append;
    qryTmp.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('OBSROM', VS_strCodEmp);
    qryTmp.FieldByName('ROM_TIPROM').AsString  := fCfgSis('OPCROM', varString);
    qryTmp.FieldByName('ROM_CODEMP').AsString  := VS_strCodEmp;
    qryTmp.FieldByName('ROM_TIPOBS').AsInteger := tpoDadosAdicionaisNF.GetValue;
    qryTmp.FieldByName('ROM_MOSTRA').AsString  := IIF(chkDadosAdicionaisNF.Checked, 'S', 'N');
    qryTmp.Post;

    qryTmp.Append;
    qryTmp.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('OBSROM', VS_strCodEmp);
    qryTmp.FieldByName('ROM_TIPROM').AsString  := fCfgSis('OPCROM', varString);
    qryTmp.FieldByName('ROM_CODEMP').AsString  := VS_strCodEmp;
    qryTmp.FieldByName('ROM_TIPOBS').AsInteger := tpoObservacoesExpedicao.GetValue;
    qryTmp.FieldByName('ROM_MOSTRA').AsString  := IIF(chkObservacoesExpedicao.Checked, 'S', 'N');
    qryTmp.Post;

    qryTmp.Append;
    qryTmp.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('OBSROM', VS_strCodEmp);
    qryTmp.FieldByName('ROM_TIPROM').AsString  := fCfgSis('OPCROM', varString);
    qryTmp.FieldByName('ROM_CODEMP').AsString  := VS_strCodEmp;
    qryTmp.FieldByName('ROM_TIPOBS').AsInteger := tpoObservacoes.GetValue;
    qryTmp.FieldByName('ROM_MOSTRA').AsString  := IIF(chkObservacoes.Checked, 'S', 'N');
    qryTmp.Post;

    qryTmp.Append;
    qryTmp.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('OBSROM', VS_strCodEmp);
    qryTmp.FieldByName('ROM_TIPROM').AsString  := fCfgSis('OPCROM', varString);
    qryTmp.FieldByName('ROM_CODEMP').AsString  := VS_strCodEmp;
    qryTmp.FieldByName('ROM_TIPOBS').AsInteger := tpoFeriados.GetValue;
    qryTmp.FieldByName('ROM_MOSTRA').AsString  := IIF(chkFeriados.Checked, 'S', 'N');
    qryTmp.Post;

    qryTmp.Append;
    qryTmp.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('OBSROM', VS_strCodEmp);
    qryTmp.FieldByName('ROM_TIPROM').AsString  := fCfgSis('OPCROM', varString);
    qryTmp.FieldByName('ROM_CODEMP').AsString  := VS_strCodEmp;
    qryTmp.FieldByName('ROM_TIPOBS').AsInteger := tpoOrientacoes.GetValue;
    qryTmp.FieldByName('ROM_MOSTRA').AsString  := IIF(chkOrientacoes.Checked, 'S', 'N');
    qryTmp.Post;
  Finally
    FreeAndNil(qryTmp);
  End;

end;

procedure TfrmConfigRomaneio.pIndexarColunasVisiveis;
  Var
    Column   : TcxGridDBColumn;
    intRecNo : Integer;
begin
  inherited;
  cdsColRom.DisableControls;
  intRecNo := cdsColRom.RecNo;
  Try
    cdsColRom.First;
    While Not cdsColRom.Eof Do
    Begin
      Column := TcxGridDBColumnHelper.fFindColumnByNameView(dbgVisRomDBView, cdsColRom.FieldByName('COLNAM').AsString);

      If (Column <> Nil) Then
        Column.Index := cdsColRom.FieldByName('ORDCAM').AsInteger - 1;

      cdsColRom.Next;
    End;
    cdsColRom.First;
  Finally
    cdsColRom.RecNo := intRecNo;
    cdsColRom.EnableControls;
  End;

end;

procedure TfrmConfigRomaneio.pIniciarDados;
  Var
    intCnt    : Integer;
begin
  dtsVisRom.DataSet.DisableControls;
  Try
    For intCnt := Low(TCfgColRom.arrColsOri) To High(TCfgColRom.arrColsOri) Do
    Begin
      If TCfgColRom.fUtilizarColuna(TCfgColRom.arrColsOri[intCnt].strFieldName) Then
        pAdicionarColunaExibicaoEOrdem(TCfgColRom.arrColsOri[intCnt])
      Else
        TCfgColRom.arrColsOri[intCnt].blnVisible := False;

      pAdicionarColunaPreVisualizacao(intCnt, TCfgColRom.arrColsOri[intCnt]);
    End;

    TCfgColRom.pSetarUltimosDadosCarregados(dbgVisRomDBView);

    pAjustaColunasDeExibicao;
  Finally
    dtsVisRom.DataSet.EnableControls;
  End;
end;

procedure TfrmConfigRomaneio.pMarcarColunasExibicao(blnMarcar: Boolean);
  Var
    intRecNo : Integer;
begin
  cdsColRom.DisableControls;
  intRecNo := cdsColRom.RecNo;
  Try
    cdsColRom.First;

    While Not cdsColRom.Eof do
    Begin
      cdsColRom.Edit;

      If blnMarcar Then
        cdsColRom.FieldByName('EXIBIR').AsString :=  'S'
      Else
        cdsColRom.FieldByName('EXIBIR').AsString :=  'N';

      cdsColRom.Post;

      pVisibilidadeColuna;

      cdsColRom.Next;
    End;

    cdsColRom.First;
  Finally
    cdsColRom.RecNo := intRecNo;
    cdsColRom.EnableControls;
  End;
end;

procedure TfrmConfigRomaneio.pOrdenaColunas;
var cdsOrd,
    cdsBkp: TUniClientDataSet;
    strFields: String;
    strDescFields: String;
    strBookMark : TBookMark;
    indexDef : TIndexDef;
begin
  Try
    cdsOrd := TUniClientDataSet( frmFatRomaneio.dbgDocumentosDBView.DataController.DataSet );

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


procedure TfrmConfigRomaneio.pVisibilidadeColuna;
  Var
    Column : TcxGridDBColumn;
begin
  inherited;
  If (Not fEmptyStr(cdsColRom.FieldByName('COLNAM').AsString)) Then
  Begin
    Column := TcxGridDBColumnHelper.fFindColumnByNameView(dbgVisRomDBView, cdsColRom.FieldByName('COLNAM').AsString);

    If (Column <> Nil) Then
      Column.Visible := (cdsColRom.FieldByName('EXIBIR').AsString = 'S');
  End;
end;


function TfrmConfigRomaneio.VerificarOrdenacaoDescer(blnSobe: Boolean): Boolean;
begin
  Result := false;

  If Not(cdsColOrd.FieldByName('ORDCAM').AsInteger = cdsColRom.RecordCount)then
    Exit;

  if (blnSobe)  then
     exit;

  Result := true;
end;

function TfrmConfigRomaneio.VerificarOrdenacaoSubir(blnSobe: Boolean): Boolean;
begin
  Result := false;

  If Not (cdsColOrd.FieldByName('ORDCAM').AsInteger = 1) Then
    Exit;

  If Not blnSobe then
    Exit;

  Result := true;
end;

end.
