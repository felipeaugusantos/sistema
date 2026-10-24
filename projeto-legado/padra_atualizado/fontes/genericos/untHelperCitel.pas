unit untHelperCitel;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  UniClientDataSet, cxProgressBar,
{$ENDIF LINUX}
  System.SysUtils, System.Variants, Data.DB;

Type
  TcxProgressBarHelper = Class Helper For TCxProgressBar
    procedure pStep;
    procedure pStepBy(fltQtdStep : Double = 1);
    procedure pSetMax(fltValMax: Double);
  End;

  TStringHelper = record helper for String
    function ToDateTime: TDateTime;
    function IsDateTimeValid: Boolean;
    function IsEmpty: Boolean;
    function QuotedString: string;
    function Replace(const OldValue: string; const NewValue: string): string;
    function ReplaceEx(const OldValue: string; const NewValue: string): string;
    function Equals(const Value: string): Boolean;
  end;

  TDateTimeHelper = record helper for TDateTime
    function isNull: Boolean;
  end;

  TUniClientDataSetHelper = class helper for TUniClientDataSet
  strict private
    function RoleCondicionalToValidadeUpdateIndex(const NewIndexName: string): boolean;
  public
    procedure CloneData(Source: TUniClientDataSet);
  end;

implementation

procedure TcxProgressBarHelper.pSetMax(fltValMax: Double);
begin
  Self.Properties.Max := fltValMax;
end;

procedure TcxProgressBarHelper.pStep;
begin
  pStepBy;
end;

procedure TcxProgressBarHelper.pStepBy(fltQtdStep: Double);
begin
  Self.Position := Self.Position + fltQtdStep;
end;

function TDateTimeHelper.isNull: Boolean;
begin
  result := Self = 0;
end;

function TStringHelper.IsDateTimeValid: Boolean;
begin
  result := Self.ToDateTime <> - 1;
end;

function TStringHelper.IsEmpty: Boolean;
begin
  result := Self = NullAsstringValue
end;

function TStringHelper.ToDateTime: TDateTime;
begin
  result := StrToDateDef(Self, -1);
end;

function TStringHelper.QuotedString: string;
begin
  Result := QuotedStr(Self);
end;

function TStringHelper.Replace(const OldValue, NewValue: string): string;
begin
  Result := System.SysUtils.StringReplace(Self, OldValue, NewValue, [rfReplaceAll]);
end;

function TUniClientDataSetHelper.RoleCondicionalToValidadeUpdateIndex(const NewIndexName: string): boolean;
begin
  if (NewIndexName.IsEmpty)  then
    Exit(False);

  result := (Pos(UpperCase('__Idx'), UpperCase(NewIndexName)) > 0);
end;

procedure TUniClientDataSetHelper.CloneData(Source: TUniClientDataSet);
var
  NewIndexName: string;
  IndexOptions: TIndexOptions;
  FieldName: string;
  intRecNo: integer;
begin
  NewIndexName := Source.IndexName;
  intRecNo := Source.RecNo;

  Source.IndexName := NullAsStringValue;
  Self.IndexName := NullAsStringValue;

  Self.Data := Source.Data;

  if RoleCondicionalToValidadeUpdateIndex(NewIndexName) then
  begin
    Self.IndexDefs.Update;
    FieldName := Copy(NewIndexName, 1, Pos(UpperCase('__Idx'), UpperCase(NewIndexName)) - 1);
    IndexOptions := [];

    if Pos(UpperCase('__IdxA'), UpperCase(NewIndexName)) = 0 then
      IndexOptions := [ixDescending];

    Self.AddIndex(NewIndexName, FieldName, IndexOptions);
  end;

  if not NewIndexName.IsEmpty then
  begin
    Self.IndexName := NewIndexName;
    Source.IndexName := NewIndexName;
  end;

  Self.RecNo := intRecNo;
  Source.RecNo := intRecNo;
end;

function TStringHelper.ReplaceEx(const OldValue, NewValue: string): string;
begin
  Result := Self;
  while Pos(AnsiUpperCase(OldValue), AnsiUpperCase(Result)) > 0 do
    Result := System.SysUtils.StringReplace(Result, OldValue, NewValue, [rfReplaceAll, rfIgnoreCase]);
end;

function TStringHelper.Equals(const Value: string): Boolean;
begin
  Result := Self = Value;
end;


end.
