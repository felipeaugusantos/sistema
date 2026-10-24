unit untSelecionaUnidadesCores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, UniDataSetProvider,
    Uni, UniClientDataSet, cxDropDownEdit,
  cxCheckBox, cxDBLookupComboBox, EditFocus, BitBtnLockedIncrem, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, MemDS, DBAccess, Datasnap.Provider, frxClass,
  frxExportCSVTestabilidade, StrUtils, Datasnap.DBClient,
  cxDataControllerConditionalFormattingRulesManagerDialog;


type
  TfrmSelecionaUnidadesCores = class(TfrmPai)
    pnlGeral: TPanel;
    pnlUnidades: TPanel;
    pnlCores: TPanel;
    Splitter1: TSplitter;
    gbUnidades: TGroupBox;
    gbCores: TGroupBox;
    dbgUnidades: TcxGrid;
    dbgUnidadesDBTableView1: TcxGridDBTableView;
    dbgUnidadesLevel1: TcxGridLevel;
    dbgCores: TcxGrid;
    dbgCoresDBTableView1: TcxGridDBTableView;
    dbgCoresLevel1: TcxGridLevel;
    dtsUnidades: TDataSource;
    cdsUnidades: TUniClientDataSet;
    qryUnidades: TUniQuery;
    dspUnidades: TUniDataSetProvider;
    dtsCores: TDataSource;
    cdsCores: TUniClientDataSet;
    qryCores: TUniQuery;
    dspCores: TUniDataSetProvider;
    dbgUnidadesDBTableView1UNI_CODUNI: TcxGridDBColumn;
    dbgUnidadesDBTableView1UNI_DESUNI: TcxGridDBColumn;
    dbgUnidadesDBTableView1UNI_SIGUNI: TcxGridDBColumn;
    dbgCoresDBTableView1COR_CODCOR: TcxGridDBColumn;
    dbgCoresDBTableView1COR_DESCOR: TcxGridDBColumn;
    dbgCoresDBTableView1COR_DESRES: TcxGridDBColumn;
    MARDES: TcxGridDBColumn;
    dbgCoresDBTableView1MARDES: TcxGridDBColumn;
    dbgUnidadesDBTableView1COMPOSICAO: TcxGridDBColumn;
    dtsGerCom: TDataSource;
    qryGerCom: TUniQuery;
    dbgUnidadesDBTableView1UNI_PESLIT: TcxGridDBColumn;
    pnlLegUni: TPanel;
    Label1: TLabel;
    Shape1: TShape;
    Label2: TLabel;
    pnlLegCor: TPanel;
    Label3: TLabel;
    Shape2: TShape;
    Label4: TLabel;
    dbgCoresDBTableView1FORMULA: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    rdbComFor: TRadioButton;
    rdbSemFor: TRadioButton;
    rdbTodos: TRadioButton;
    popSelecao: TPopupMenu;
    MarcarTodos1: TMenuItem;
    DesmarcarTodos1: TMenuItem;
    InverterSeleo1: TMenuItem;
    N1: TMenuItem;
    btnSelCor: TBitBtnLocked;
    btnSelUni: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgUnidadesDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure MARDESPropertiesChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgCoresDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure dbgCoresDBTableView1MARDESPropertiesChange(Sender: TObject);
    procedure rdbComForClick(Sender: TObject);
    procedure btnSelUniClick(Sender: TObject);
    procedure MarcarTodos1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FCodIte: String;

    procedure pAbrirUnidades;
    procedure pAbrirCores;
    procedure pAbrirComposicao;
    procedure pSelecionarUnidades;
    procedure pSelecionarCores;

    function fRetornaSQLUnidades: String;
    function fRetornaSQLCores: String;
    function fRetornaSQLComposicao: String;

  protected
    function getCodIte: String;

    procedure setCodIte(const Value: String);
  public
    { Public declarations }
    arrUnidades   : Array Of String;
    arrComposicao : Array Of String;
    arrCores      : Array Of String;

    property strCodIte: String Read getCodIte Write setCodIte;
  end;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmSelecionaUnidadesCores.btnConfirmaClick(Sender: TObject);
begin
  inherited;

(*  If Not fInformouComposicao Then
    Exit;
 *) // NAO SERÁ MAIS OBRIGATÓRIO

  pSelecionarUnidades;
  pSelecionarCores;
  Close;
end;

procedure TfrmSelecionaUnidadesCores.btnSelUniClick(Sender: TObject);
begin
  inherited;
  popSelecao.Tag := TControl(Sender).Tag;
  popSelecao.Popup( Mouse.CursorPos.X, Mouse.CursorPos.Y );
end;

procedure TfrmSelecionaUnidadesCores.dbgCoresDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strFormula: String;
begin
  inherited;
  strFormula := VarAsType( dbgCoresDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ dbgCoresDBTableView1FORMULA.Index], varString );
  If strFormula = 'N' Then
  Begin
    If (Not AViewInfo.Selected) Then
      ACanvas.Font.Color := clRed
    Else
      ACanvas.Font.Color := clWhite;
  End;
end;

procedure TfrmSelecionaUnidadesCores.dbgCoresDBTableView1MARDESPropertiesChange(
  Sender: TObject);
begin
  inherited;
  If cdsCores.FieldByName('FORMULA').AsString = 'N' Then
  Begin
    cdsCores.Edit;
    cdsCores.FieldByName('COR_MARDES').AsString := 'D';
    cdsCores.Post;
  End;
end;

procedure TfrmSelecionaUnidadesCores.dbgUnidadesDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  fltPesLit: Double;
begin
  inherited;
  fltPesLit := VarAsType( IIF(dbgUnidadesDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ dbgUnidadesDBTableView1UNI_PESLIT.Index] = null,0,dbgUnidadesDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ dbgUnidadesDBTableView1UNI_PESLIT.Index]), varDouble );
  If fltPesLit = 0 Then
  Begin
    If (Not AViewInfo.Selected) Then
      ACanvas.Font.Color := clRed
    Else
      ACanvas.Font.Color := clWhite;
  End;
end;

procedure TfrmSelecionaUnidadesCores.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  cdsUnidades.Close;
  cdsCores.Close;
end;

procedure TfrmSelecionaUnidadesCores.FormCreate(Sender: TObject);
begin
  inherited;
  strCodIte := '';
end;

procedure TfrmSelecionaUnidadesCores.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) Then
    If btnConfirma.Enabled Then
      btnConfirma.Click;
end;

procedure TfrmSelecionaUnidadesCores.FormShow(Sender: TObject);
begin
  inherited;
  pAbrirUnidades;
  pAbrirCores;
  pAbrirComposicao;
  btnConfirma.Enabled := True;
end;

function TfrmSelecionaUnidadesCores.fRetornaSQLComposicao: String;
begin
  Result := '';
  Result := Result + 'SELECT   ';
  Result := Result + '  GCO_CODCOM, ';
  Result := Result + '  GCO_DESCOM  ';
  Result := Result + 'FROM     ';
  Result := Result + '  GERCOM ';
  Result := Result + 'ORDER BY ';
  Result := Result + '  GCO_DESCOM ';
end;

function TfrmSelecionaUnidadesCores.fRetornaSQLCores: String;
begin
  Result := '';
  Result := Result + ' SELECT COR_CODCOR, ';
  Result := Result + '        COR_DESCOR, ';
  Result := Result + '        COR_DESRES, ';
  Result := Result + '        AUTOINCREM, ';
  Result := Result + '        COR_CODEMP, ';
  Result := Result + '        "D" AS COR_MARDES, ';
  Result := Result + '        IFNULL((SELECT "S"        ';
  Result := Result + '                  FROM GEIMAT     ';
  Result := Result + '                 WHERE GMT_CODITE = :CODITE ';
  Result := Result + '                   AND GMT_CODCOR = CADCOR.COR_CODCOR ';
  Result := Result + '                   AND GMT_STATUS = "A" LIMIT 1),"N") AS FORMULA '; //se existe a formula para a cor
  Result := Result + '   FROM CADCOR      ';
end;

function TfrmSelecionaUnidadesCores.fRetornaSQLUnidades: String;
begin
  Result := '';
  Result := Result + ' SELECT UNI_CODUNI, ';
  Result := Result + '        UNI_DESUNI, ';
  Result := Result + '        UNI_CODEMP, ';
  Result := Result + '        AUTOINCREM, ';
  Result := Result + '        UNI_PESLIT, ';
  Result := Result + '        UNI_ITEFRA, ';
  Result := Result + '        UNI_SIGUNI, ';
  Result := Result + '        UNI_METFAT, ';
  Result := Result + '        "D"     AS UNI_MARDES, ';
  Result := Result + '        "     " AS UNI_CODCOM  ';
  Result := Result + '   FROM CADUNI      ';
end;

function TfrmSelecionaUnidadesCores.getCodIte: String;
begin
  Result := FCodIte;
end;

procedure TfrmSelecionaUnidadesCores.MarcarTodos1Click(Sender: TObject);
  Var
    cdsMarcar : TUniClientDataSet;
    strPrefix : String;

  procedure pMarcarDesmarcar(intTag : Integer);
  begin
    With cdsMarcar Do
    Begin
      Try
        DisableControls;
        First;
        While not Eof Do
        Begin
          If (cdsMarcar = cdsUnidades) And (cdsUnidades.FieldByName('UNI_PESLIT').AsFloat = 0) Then
          Begin
            Next;
            Continue;
          End;

          If (cdsMarcar = cdsCores) And (cdsCores.FieldByName('FORMULA').AsString = 'N') Then
          Begin
            Next;
            Continue;
          End;

          Edit;

          Case intTag Of
            0 : FieldByName(strPrefix + 'MARDES').AsString := 'M';
            1 : FieldByName(strPrefix + 'MARDES').AsString := 'D';
            2 : FieldByName(strPrefix + 'MARDES').AsString := IfThen(FieldByName(strPrefix + 'MARDES').AsString = 'M', 'D', 'M') ;
          End;

          Post;
          Next;
        End;
      Finally
        First;
        EnableControls;
      End;
    End;

  end;


begin
  inherited;
  Case popSelecao.Tag Of
    0: Begin
         cdsMarcar := cdsUnidades;
         strPrefix := 'UNI_';
       End;

    1: Begin
         cdsMarcar := cdsCores;
         strPrefix := 'COR_';
       End;

  End;

  pMarcarDesmarcar(TMenuItem(Sender).Tag);

end;

procedure TfrmSelecionaUnidadesCores.MARDESPropertiesChange(Sender: TObject);
begin
  inherited;
  If cdsUnidades.FieldByName('UNI_PESLIT').AsFloat = 0 Then
  Begin
    cdsUnidades.Edit;
    cdsUnidades.FieldByName('UNI_MARDES').AsString := 'D';
    cdsUnidades.Post;
  End;
end;

procedure TfrmSelecionaUnidadesCores.pAbrirComposicao;
begin

  With qryGerCom Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(fRetornaSQLComposicao);
    Open;
    pSetaClient(qryCores);
  End;

end;

procedure TfrmSelecionaUnidadesCores.pAbrirCores;
begin

  With qryCores Do
  Begin
    cdsCores.Close;
    Close;
    SQL.Clear;
    SQL.Add(fRetornaSQLCores);
    ParamByName('CODITE').AsString := FCodIte;
    Open;
    pSetaClient(qryCores);
    cdsCores.Open;
    pSetaClient(cdsCores);
  End;

end;

procedure TfrmSelecionaUnidadesCores.pAbrirUnidades;
begin

  With qryUnidades Do
  Begin
    cdsUnidades.Close;
    Close;
    SQL.Clear;
    SQL.Add(fRetornaSQLUnidades);
    Open;
    pSetaClient(qryUnidades);
    cdsUnidades.Open;
    pSetaClient(cdsUnidades);
  End;
  
end;

procedure TfrmSelecionaUnidadesCores.pSelecionarCores;
begin
  SetLength(arrCores, 0);

  With cdsCores Do
  Begin
    cdsCores.Filter := 'COR_MARDES = ' + QuotedStr('M');
    cdsCores.Filtered := True;
    First;

    While Not Eof Do
    Begin
      SetLength(arrCores, Length(arrCores) + 1);
      arrCores[Length(arrCores) - 1] := FieldByName('COR_CODCOR').AsString;
      Next;
    End;

    cdsCores.Filter   := '';
    cdsCores.Filtered := False;
  End;


 { With dbgCoresDBTableView1.DataController Do
  Begin
    For intCon := 0 To Pred(GetSelectedCount) do
    Begin
      intARowIndex := GetSelectedRowIndex(intCon);
      ARowInfo     := GetRowInfo(intARowIndex);
      SetLength(arrCores, Length(arrCores) + 1);
      arrCores[Length(arrCores) - 1] := VarToStr(Values[ARowInfo.RecordIndex, dbgCoresDBTableView1.GetColumnByFieldName('COR_CODCOR').Index]);
    End;
  End;}
end;

procedure TfrmSelecionaUnidadesCores.pSelecionarUnidades;
begin
  SetLength(arrUnidades, 0);
  SetLength(arrComposicao, 0);

  With cdsUnidades Do
  Begin
    cdsUnidades.Filter   := 'UNI_MARDES = ' + QuotedStr('M');
    cdsUnidades.Filtered := True;
    First;

    While Not Eof Do
    Begin
      SetLength(arrUnidades, Length(arrUnidades) + 1);
      arrUnidades[Length(arrUnidades) - 1] := FieldByName('UNI_CODUNI').AsString;

      SetLength(arrComposicao, Length(arrComposicao) + 1);
      arrComposicao[Length(arrComposicao) - 1] := FieldByName('UNI_CODCOM').AsString;

      Next;
    End;

    cdsUnidades.Filter   := '';
    cdsUnidades.Filtered := False;
  End;

  {With dbgUnidadesDBTableView1.DataController Do
  Begin
    For intCon := 0 To Pred(GetSelectedCount) do
    Begin
      intARowIndex := GetSelectedRowIndex(intCon);
      ARowInfo     := GetRowInfo(intARowIndex);
      SetLength(arrUnidades, Length(arrUnidades) + 1);
      arrUnidades[Length(arrUnidades) - 1] := VarToStr(Values[ARowInfo.RecordIndex, dbgUnidadesDBTableView1.GetColumnByFieldName('UNI_CODUNI').Index]);
    End;
  End;}
end;

procedure TfrmSelecionaUnidadesCores.rdbComForClick(Sender: TObject);
begin
  inherited;

  if rdbComFor.Checked Then
    cdsCores.Filter := 'FORMULA = ' + QuotedStr('S');
  if rdbSemFor.Checked Then
    cdsCores.Filter := 'FORMULA = ' + QuotedStr('N');
  if rdbTodos.Checked Then
    cdsCores.Filter := '';

  cdsCores.Filtered := not fEmptyStr(cdsCores.Filter);
end;

procedure TfrmSelecionaUnidadesCores.setCodIte(const Value: String);
begin
  If (FCodIte <> Value) Then
    FCodIte := Value;
end;

end.
