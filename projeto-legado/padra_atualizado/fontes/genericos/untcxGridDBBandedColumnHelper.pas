unit untcxGridDBBandedColumnHelper;

interface

uses
  cxGridBandedTableView, cxGridDBBandedTableView;

type
  TcxGridDBBandedColumnHelper = class
  public
    class function fFindBandedColumnByNameView(dbgData: TcxGridDBBandedTableView; strField: String): TcxGridDBBandedColumn;
    class function fFindBandByNameView(dbgData: TcxGridDBBandedTableView; strCaption: String): TcxGridBand;
  end;

implementation

{ TcxGridDBColumnHelper }

class function TcxGridDBBandedColumnHelper.fFindBandByNameView(dbgData: TcxGridDBBandedTableView; strCaption: String): TcxGridBand;
var
  intIndex: Integer;
begin
  Result := nil;
  for intIndex := 0 to Pred(dbgData.Bands.Count) do
    if dbgData.Bands[intIndex].Caption = strCaption then
    begin
      Result := dbgData.Bands[intIndex];
      Break;
    end;
end;

class function TcxGridDBBandedColumnHelper.fFindBandedColumnByNameView(
  dbgData: TcxGridDBBandedTableView; strField: String): TcxGridDBBandedColumn;
var
  intIndex: Integer;
begin
  Result := nil;
  for intIndex := 0 to Pred(dbgData.ColumnCount) do
    if dbgData.Columns[intIndex].DataBinding.FieldName = strField then
    begin
      Result := dbgData.Columns[intIndex];
      Break;
    end;
end;

end.
