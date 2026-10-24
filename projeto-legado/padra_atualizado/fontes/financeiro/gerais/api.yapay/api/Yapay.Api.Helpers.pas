unit Yapay.Api.Helpers;

interface

uses
  System.SysUtils,
  System.DateUtils,
  System.JSON;

type
  TJSONValueHelper = class helper for TJSONValue
    function ToDatetime: TDateTime;
  end;

implementation

{ TJSONValueHelper }

function TJSONValueHelper.ToDatetime: TDateTime;
var
  Year, Month, Day, Hour, Minute, Second, Millisecond: Word;
begin
  Year        := StrToIntDef(Copy(Self.Value, 1, 4),0);
  Month       := StrToIntDef(Copy(Self.Value, 6, 2),0);
  Day         := StrToIntDef(Copy(Self.Value, 9, 2),0);
  Hour        := StrToIntDef(Copy(Self.Value, 12, 2),0);
  Minute      := StrToIntDef(Copy(Self.Value, 15, 2),0);
  Second      := StrToIntDef(Copy(Self.Value, 18, 2),0);
  Millisecond := Round(StrToFloatDef(Copy(Self.Value, 19, 4),0));
  Result := EncodeDateTime(Year, Month, Day, Hour, Minute, Second, Millisecond);
end;

end.
