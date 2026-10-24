unit untcxGridDBBandedTableViewHelper;

interface

uses cxGridDBBandedTableView, Variants, SysUtils, cxProgressBar, untGravando,
     untFuncFat, untFuncoesSimples, cxGridCitel, Math, System.Classes,
     cxCustomData;

type
  TcxGridDBBandedTableViewHelper = class helper for TcxGridDBBandedTableView
  private
    function fExecAdjustColumnsWidth(pgbStatus: TcxProgressBar = Nil): Boolean;
  public
    function GetFooterSummaryValuesByFieldName(const strNomeCampo: string): Variant;
    procedure SetFooterSummaryValuesByFieldName(const strNomeCampo: string; const Value: Variant);
    function GetGroupSummaryValuesByFieldName(const intRowIndex, intLevel: Integer; const strNomeCampo: string): Variant;
    procedure SetGroupSummaryValuesByFieldName(const intRowIndex, intLevel: Integer; const strNomeCampo: string; const Value: Variant);
    property GroupSummaryValuesByFieldName[const intRowIndex, intLevel: Integer; const strNomeCampo: string]: Variant
      read GetGroupSummaryValuesByFieldName write SetGroupSummaryValuesByFieldName;
    property FooterSummaryValuesByFieldName[const strNomeCampo: string]: Variant
      read GetFooterSummaryValuesByFieldName write SetFooterSummaryValuesByFieldName;
    procedure AdjustColumnsWidth;
    procedure SetColumnVisible(strFieldName: String; blnVisible: Boolean);
    procedure SetColumnEditing(strFieldName: String; blnEditing: Boolean);
    procedure SetColumnWidth(strFieldName: String; intWidth: Integer);
    function GetColumnWidth(strFieldName: String): Integer;
    procedure SetColumnIndex(strFieldName: String);
    function ColumnSelected(strFieldName: String): Boolean;
    procedure SetAllBandsMoving(blnMoving: Boolean);
    procedure SetAllColumnsMoving(blnMoving: Boolean);
    procedure SetAllColumnsEditing(blnEditing: Boolean);
    procedure SetBandVisible(intIndex: Integer; blnVisible: Boolean);
    function GroupSummaryIndexExists(strNomeCampo: String; intLevel: Integer): Boolean;
    function GetVisibleColumnCount(const intBandIndex: Integer): Integer;
  end;

implementation

{ TcxGridDBBandedTableViewHelper }

procedure TcxGridDBBandedTableViewHelper.AdjustColumnsWidth;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fExecAdjustColumnsWidth;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
end;

function TcxGridDBBandedTableViewHelper.fExecAdjustColumnsWidth(
  pgbStatus: TcxProgressBar): Boolean;
  var
    intColumn: Integer;
    intTamUti: Integer;
    intDispon: Integer;
    intWidth : Integer;
begin

  intWidth :=  TcxGridCitel(Self.GetParentComponent).Width;
  pInformacao('Aguarde, Ajustando colunas...', pgbStatus);
  pProgresso(0, 0, pgbStatus);

  Self.ApplyBestFit;

  intTamUti := 0;
  For intColumn := 0 To Self.ColumnCount -1 Do
  Begin
    pProgresso(Succ(intColumn), Self.ColumnCount, pgbStatus);
    With Self.Columns[intColumn] Do
      If Visible Then
        Inc(intTamUti, Width);
  End;

  intDispon :=  intWidth - intTamUti - 50;

  If intDispon <= 0 Then
    Exit(True);

  For intColumn := 0 To Self.ColumnCount -1 Do
  Begin
    pProgresso(Succ(intColumn), Self.ColumnCount, pgbStatus);
    With Self.Columns[intColumn] Do
      If Visible Then
        Width := Width + Floor(intDispon * (Width/ intTamUti));
  End;

  Result := True;
end;

function TcxGridDBBandedTableViewHelper.GetFooterSummaryValuesByFieldName(const strNomeCampo: string): Variant;
  Var
    intIndex : Integer;
begin
  Try
    intIndex := Self.DataController.Summary.FooterSummaryItems.IndexOfItemLink(Self.GetColumnByFieldName(strNomeCampo));

    If intIndex > -1 Then
      Result := Self.DataController.Summary.FooterSummaryValues[intIndex]
    Else
      Result := Null;
  Except
    on E: Exception do
    begin
      Result := Null;
    end;
  End;
end;

function TcxGridDBBandedTableViewHelper.GetGroupSummaryValuesByFieldName(const intRowIndex, intLevel: Integer; const strNomeCampo: string): Variant;
  Var
    intIndex : Integer;
begin
  Try
    intIndex := Self.DataController.Summary.GroupSummaryItems[intLevel].IndexOfItemLink(Self.GetColumnByFieldName(strNomeCampo));

    If intIndex > -1 Then
      Result := Self.DataController.Summary.GroupSummaryDisplayValues[intRowIndex, intLevel, intIndex]
    Else
      Result := Null;
  Except
    on E: Exception do
    Begin
      Result := Null;
    End;
  End;
end;

function TcxGridDBBandedTableViewHelper.GetVisibleColumnCount(const intBandIndex: Integer): Integer;
  Var
    intIndex: Integer;
begin
  Result := 0;

  For intIndex := 0 To Self.Bands[intBandIndex].ColumnCount -1 Do
  Begin
    If Self.Bands[intBandIndex].Columns[intIndex].Visible Then
      Inc(Result);
  End;
end;

function TcxGridDBBandedTableViewHelper.GroupSummaryIndexExists(strNomeCampo: String; intLevel: Integer) : Boolean;
  Var
    Column : TcxGridDBBandedColumn;
    SumIte : TcxDataGroupSummaryItems;
begin
  Try
    Result := False;

    Column := Self.GetColumnByFieldName(strNomeCampo);
    SumIte := Self.DataController.Summary.GroupSummaryItems[intLevel];

    If (Column <> Nil) And (SumIte <> Nil) And (SumIte.Count > 0) Then
      Result := (SumIte.IndexOfItemLink(Column) > -1);
  Except
    On E: Exception do
      Result := False;
  End;
end;

procedure TcxGridDBBandedTableViewHelper.SetFooterSummaryValuesByFieldName(const strNomeCampo: string; const Value: Variant);
  Var
    intIndex : Integer;
begin
  Try
    intIndex := Self.DataController.Summary.FooterSummaryItems.IndexOfItemLink(Self.GetColumnByFieldName(strNomeCampo));

    If intIndex > -1 Then
      Self.DataController.Summary.FooterSummaryValues[intIndex] := Value;
  Except
    on E: Exception do
    begin
    end;
  End;
end;

procedure TcxGridDBBandedTableViewHelper.SetGroupSummaryValuesByFieldName(const intRowIndex, intLevel: Integer; const strNomeCampo: string;
  const Value: Variant);
  Var
    intIndex: Integer;
begin
  Try
    intIndex := Self.DataController.Summary.GroupSummaryItems[intLevel].IndexOfItemLink(Self.GetColumnByFieldName(strNomeCampo));

    If intIndex > -1 Then
      Self.DataController.Summary.GroupSummaryDisplayValues[intRowIndex, intLevel, intIndex] := Value;
  Except
    on E: Exception do
    begin
    end;
  End;
end;

procedure TcxGridDBBandedTableViewHelper.SetColumnEditing(strFieldName: String;
  blnEditing: Boolean);
  Var
    intCnt : Integer;
begin
  For intCnt := 0 To Self.ColumnCount - 1 Do
  Begin
    If SameText(Self.Columns[intCnt].DataBinding.FieldName, strFieldName) Then
    Begin
      Self.Columns[intCnt].Options.Editing := blnEditing;
      Break;
    End;
  End;
end;

procedure TcxGridDBBandedTableViewHelper.SetColumnVisible(strFieldName: String;
  blnVisible: Boolean);
  Var
    intCnt : Integer;
begin
  For intCnt := 0 To Self.ColumnCount - 1 Do
  Begin
    If SameText(Self.Columns[intCnt].DataBinding.FieldName, strFieldName) Then
    Begin
      Self.Columns[intCnt].Visible := blnVisible;
      Break;
    End;
  End;
end;

procedure TcxGridDBBandedTableViewHelper.SetColumnWidth(strFieldName: String;
  intWidth: Integer);
  Var
    intCnt : Integer;
begin
  For intCnt := 0 To Self.ColumnCount - 1 Do
  Begin
    If SameText(Self.Columns[intCnt].DataBinding.FieldName, strFieldName) Then
    Begin
      Self.Columns[intCnt].Width := intWidth;
      Break;
    End;
  End;
end;

procedure TcxGridDBBandedTableViewHelper.SetAllBandsMoving(blnMoving: Boolean);
  Var
    intCnt : Integer;
begin
  For intCnt := 0 To Self.Bands.Count-1 Do
    Self.Bands[intCnt].Options.Moving := blnMoving;
end;

procedure TcxGridDBBandedTableViewHelper.SetBandVisible(intIndex: Integer; blnVisible: Boolean);
  Var
    intCnt : Integer;
begin
  For intCnt := 0 To Self.Bands.Count-1 Do
  Begin
    If (intCnt = intIndex) Then
      Self.Bands[intCnt].Visible := blnVisible;
  End;
end;

procedure TcxGridDBBandedTableViewHelper.SetColumnIndex(strFieldName: String);
  Var
    intCnt : Integer;
begin
  For intCnt := 0 To Self.ColumnCount - 1 Do
  Begin
    If SameText(Self.Columns[intCnt].DataBinding.FieldName, strFieldName) Then
    Begin
      Self.Columns[intCnt].Focused := True;
      {Self.Controller.FocusedColumnIndex := Self.Columns[intCnt].Index;}
      Break;
    End;
  End;
end;

procedure TcxGridDBBandedTableViewHelper.SetAllColumnsEditing(blnEditing: Boolean);
  Var
    intCnt : Integer;
begin
  For intCnt := 0 To Self.ColumnCount - 1 Do
    Self.Columns[intCnt].Options.Editing := blnEditing;
end;

procedure TcxGridDBBandedTableViewHelper.SetAllColumnsMoving(blnMoving: Boolean);
  Var
    intCnt : Integer;
begin
  For intCnt := 0 To Self.ColumnCount - 1 Do
    Self.Columns[intCnt].Options.Moving := blnMoving;
end;

function TcxGridDBBandedTableViewHelper.ColumnSelected(strFieldName: String): Boolean;
  Var
    intCnt : Integer;
begin
  Result := False;
  For intCnt := 0 To Self.ColumnCount - 1 Do
  Begin
    If SameText(Self.Columns[intCnt].DataBinding.FieldName, strFieldName) Then
    Begin
      Result := Self.Columns[intCnt].Focused; {(Self.Controller.FocusedColumnIndex = Self.Columns[intCnt].Index)};
      Break;
    End;
  End;
end;

function TcxGridDBBandedTableViewHelper.GetColumnWidth(strFieldName: String): Integer;
  Var
    intCnt : Integer;
begin
  Result := 1;
  For intCnt := 0 To Self.ColumnCount - 1 Do
  Begin
    If SameText(Self.Columns[intCnt].DataBinding.FieldName, strFieldName) Then
    Begin
      Result := Self.Columns[intCnt].Width;
      Break;
    End;
  End;
end;

end.

