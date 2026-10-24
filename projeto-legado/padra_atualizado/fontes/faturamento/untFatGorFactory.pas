unit untFatGorFactory;

interface

Uses untIFatGor, System.Classes;

  Procedure pSetFatGor(objFatGor : IFatGor); stdcall;

Type
  TFatGorFactory = Class
  Private
    Class var FatGor : IFatGor;
  Public
    Class Procedure pSetFatGor(objFatGor : IFatGor);
    Class Function fGetFatGor : IFatGor;
  End;

implementation


Procedure pSetFatGor(objFatGor : IFatGor);
Begin
  TFatGorFactory.pSetFatGor(objFatGor);
End;

{ TFatGorFactory }

class function TFatGorFactory.fGetFatGor: IFatGor;
var
  FatGorClass: TClass;
  objFatGor: TObject;
begin
  If Not Assigned(FatGor) Then
  Begin
    FatGorClass := FindClass('TFatGor');
    objFatGor := FatGorClass.Create;
    If objFatGor.GetInterfaceEntry(IFatGor) <> nil Then
    begin
      objFatGor.GetInterface(IFatGor, FatGor);

    end;
  End;

  Result := FatGor;
end;

class procedure TFatGorFactory.pSetFatGor(objFatGor: IFatGor);
begin
  FatGor := objFatGor;
end;

initialization

  TFatGorFactory.FatGor := nil;

end.
