unit untComponentHelper;

interface

uses
  Classes, SysUtils;

type
  TComponentHelper = class helper for TComponent
  public
    function GetCopy(): TComponent;
  end;

implementation

{ TComponentHelper }

function TComponentHelper.GetCopy: TComponent;
var
  memStr: TMemoryStream;
  persistentClass: TPersistentClass;
begin
  memStr := nil;
  Result := nil;
  Try
    Try
      persistentClass := TPersistentClass(Self.ClassType);
      RegisterClass(persistentClass);
      memStr := TMemoryStream.Create;
      memStr.WriteComponent(Self);
      memStr.Position := soFromBeginning;
      Result := memStr.ReadComponent(nil);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(memStr) then FreeAndNil(memStr);
  End;                              
end;

end.
