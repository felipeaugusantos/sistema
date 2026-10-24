unit untcxGridDBColumnHelper;


interface

uses
  cxGridDBTableView;

type
  TcxGridDBColumnHelper = class
  public
    class function fFindColumnByNameView(dbgData: TcxGridDBTableView; strField: String): TcxGridDBColumn;
    class function fFindColumnByName(dbgData: TcxGridDBTableView; strColumnName: String): TcxGridDBColumn;
  end;

implementation

{ TcxGridDBColumnHelper }

class function TcxGridDBColumnHelper.fFindColumnByName(
  dbgData: TcxGridDBTableView; strColumnName: String): TcxGridDBColumn;
var
  intIndex: Integer;
begin
  Result := Nil;
  For intIndex := 0 To dbgData.ColumnCount -1 Do
  Begin
    If dbgData.Columns[intIndex].Name = strColumnName Then
    Begin
      Result := dbgData.Columns[intIndex];
      Break;
    End;
  End;
end;

class function TcxGridDBColumnHelper.fFindColumnByNameView(
  dbgData: TcxGridDBTableView; strField: String): TcxGridDBColumn;
  var
    intIndex: Integer;
begin
  Result := Nil;
  For intIndex := 0 To dbgData.ColumnCount -1 Do
    If dbgData.Columns[intIndex].DataBinding.FieldName = strField Then
    Begin
      Result := dbgData.Columns[intIndex];
      Break;
    End;

end;

end.
