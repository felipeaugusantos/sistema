unit Contabilidade.Classes.Helpers;

interface

uses DBXJSON, DBXJSONReflect, System.JSON, Contabilidade.Interfaces;

type
  TObjectHelper = class helper for TObject
    function Clone: TObject;
  end;

  TLayoutImportacaoContabilHelper = record helper for TLayoutImportacaoContabil
  public
    function toCodigo: string;
  end;

implementation

uses
  SysUtils, StrUtils;

{ TObjectHelper }

function TObjectHelper.Clone: TObject;
  var
    MarshalObj : TJSONMarshal;
    UnMarshalObj : TJSONUnMarshal;
    JSONValue : TJSONValue;
begin
  Result := nil;
  MarshalObj := TJSONMarshal.Create;
  UnMarshalObj := TJSONUnMarshal.Create;
  try
    JSONValue := MarshalObj.Marshal(Self);
    try
      if Assigned(JSONValue) then
        Result := UnMArshalObj.Unmarshal(JSONValue);
    finally
      JSONValue.Free;
    end;
  finally
    MarshalObj.Free;
    UnMarshalObj.Free;
  end;
end;

{ TLayoutImportacaoContabilHelper }

function TLayoutImportacaoContabilHelper.toCodigo: string;
begin
  result := RightStr(StringOfChar('0', 6) + IntToStr(integer(Self)), 6);
end;

end.
