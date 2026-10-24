unit untDigSenVarFactory;

interface

Uses untIDigSenVar, System.Classes;

  Procedure pSetDigSenVar(objSenVar : IDigSenVar); stdcall;

Type
  TDigSenVarFactory = Class
  Private
    Class var SenVar : IDigSenVar;
  Public
    Class Procedure pSetDigSenVar(objSenVar : IDigSenVar);
    Class Function fGetDigSenVar : IDigSenVar;
  End;

implementation


Procedure pSetDigSenVar(objSenVar : IDigSenVar);
Begin
  TDigSenVarFactory.pSetDigSenVar(objSenVar);
End;

{ TDigSenVarFactory }

class function TDigSenVarFactory.fGetDigSenVar: IDigSenVar;
var
  DigSenVarClass: TClass;
  objDigSenVar: TObject;
begin
  If Not Assigned(SenVar) Then
  Begin
    DigSenVarClass := FindClass('TDigSenVar');
    objDigSenVar := DigSenVarClass.Create;
    If objDigSenVar.GetInterfaceEntry(IDigSenVar) <> nil Then
      objDigSenVar.GetInterface(IDigSenVar, SenVar);
  End;

  Result := SenVar;
end;

class procedure TDigSenVarFactory.pSetDigSenVar(objSenVar: IDigSenVar);
begin
  SenVar := objSenVar;
end;

initialization
  TDigSenVarFactory.SenVar := nil;

end.
