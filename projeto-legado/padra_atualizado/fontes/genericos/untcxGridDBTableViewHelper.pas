unit untcxGridDBTableViewHelper;

interface

uses
  cxGridDBTableView, Variants, SysUtils;

type
  TcxGridDBTableViewHelper = class helper for TcxGridDBTableView
  public
    function GetFooterSummaryValuesByFieldName(const strNomeCampo: string): Variant;
    procedure SetFooterSummaryValuesByFieldName(const strNomeCampo: string; const Value: Variant);

    function GetGroupSummaryValuesByFieldName(const intRowIndex, intLevel: Integer; const strNomeCampo: string): Variant;
    procedure SetGroupSummaryValuesByFieldName(const intRowIndex, intLevel: Integer; const strNomeCampo: string; const Value: Variant);

    property GroupSummaryValuesByFieldName[const intRowIndex, intLevel: Integer; const strNomeCampo: string]: Variant
      read GetGroupSummaryValuesByFieldName write SetGroupSummaryValuesByFieldName;
      
    property FooterSummaryValuesByFieldName[const strNomeCampo: string]: Variant
      read GetFooterSummaryValuesByFieldName write SetFooterSummaryValuesByFieldName;
  end;

implementation

{ TcxGridDBTableViewHelper }

function TcxGridDBTableViewHelper.GetFooterSummaryValuesByFieldName(const strNomeCampo: string): Variant;
var
  intIndex: Integer;
begin
  Try
    intIndex := Self.DataController.Summary.FooterSummaryItems.IndexOfItemLink(Self.GetColumnByFieldName(strNomeCampo));
    Result := Self.DataController.Summary.FooterSummaryValues[intIndex];
  Except
    on E: Exception do
    begin
      Result := Null;
    end;
  End;
end;

function TcxGridDBTableViewHelper.GetGroupSummaryValuesByFieldName(const intRowIndex, intLevel: Integer; const strNomeCampo: string): Variant;
var
  intIndex: Integer;
begin
  Try
    intIndex := Self.DataController.Summary.GroupSummaryItems[intLevel].IndexOfItemLink(Self.GetColumnByFieldName(strNomeCampo));
    Result := Self.DataController.Summary.GroupSummaryDisplayValues[intRowIndex, intLevel, intIndex];
  Except
    on E: Exception do
    begin
      Result := Null;
    end;
  End;

end;

procedure TcxGridDBTableViewHelper.SetFooterSummaryValuesByFieldName(const strNomeCampo: string; const Value: Variant);
var
  intIndex: Integer;
begin
  Try
    intIndex := Self.DataController.Summary.FooterSummaryItems.IndexOfItemLink(Self.GetColumnByFieldName(strNomeCampo));
    Self.DataController.Summary.FooterSummaryValues[intIndex] := Value;
  Except
    on E: Exception do
    begin
    end;
  End;
end;

procedure TcxGridDBTableViewHelper.SetGroupSummaryValuesByFieldName(const intRowIndex, intLevel: Integer; const strNomeCampo: string;
  const Value: Variant);
var
  intIndex: Integer;
begin
  Try
    intIndex := Self.DataController.Summary.GroupSummaryItems[intLevel].IndexOfItemLink(Self.GetColumnByFieldName(strNomeCampo));
    Self.DataController.Summary.GroupSummaryDisplayValues[intRowIndex, intLevel, intIndex] := Value;
  Except
    on E: Exception do
    begin
    end;
  End;
end;

end.
