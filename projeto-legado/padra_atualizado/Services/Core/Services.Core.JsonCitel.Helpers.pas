unit Services.Core.JsonCitel.Helpers;

interface

uses Services.Core.JsonCitel.Serializer;

type
  TObjectJsonCitelHelper = class helper for TObject
  public
    function ToJson: String;
    function FromJson<T: class, constructor>(AJson: string): T;
  end;

implementation

{ TObjectJsonCitelHelper }

function TObjectJsonCitelHelper.FromJson<T>(AJson: string): T;
begin
  Result := TJSONCitel.JSONToObject<T>(AJson);
end;

function TObjectJsonCitelHelper.ToJson: String;
Var
  LSerializer: TJSONCitel;
begin
  LSerializer := TJSONCitel.Create;
  try
    Result := LSerializer.ObjectToJSON(Self);
  finally
    LSerializer.Free;
  end;
end;

end.
