unit untAncoraBase;

interface

type
  TAncoraJson = class
  public
    function ToJsonString: string;
    class function FromJsonString<T: class, constructor>(AJsonString: string): T;
  end;

implementation

uses
  REST.Json, System.Json;

{ TAncoraJson }
class function TAncoraJson.FromJsonString<T>(AJsonString: string): T;
begin
  Result := TJson.JsonToObject<T>(AJsonString);
end;

function TAncoraJson.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

end.
