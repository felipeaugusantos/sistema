unit untRTTISingletonCollection;

interface

Uses untRTTILayout, System.SysUtils, System.Generics.Collections;

Type
  TRTTISingletonCollection = class
  Strict Private
    FDicionario : TObjectDictionary<String, TObjectList<TLayout>>;

    Class Var FInstance : TRTTISingletonCollection;
    Constructor MakeInstance;
  Public
    Class Function Instance : TRTTISingletonCollection;
    Constructor Create; reintroduce; deprecated;
    Destructor Destroy; Override;

    procedure pAdd(obj : TLayout);
    function fGetListObj( Classe : TLayoutClass ) : TObjectList<TLayout>;

  End;

implementation

{ TRTTISingletonCollection }

constructor TRTTISingletonCollection.Create;
begin
  Raise Exception.Create('Utilizar: TRTTISingletonCollection.Instance');
end;

destructor TRTTISingletonCollection.Destroy;
begin
  FDicionario.Clear;
  FreeAndNil(FDicionario);
  inherited;
end;

function TRTTISingletonCollection.fGetListObj(Classe: TLayoutClass): TObjectList<TLayout>;
begin
  Result := Nil;
  If FDicionario.ContainsKey(Classe.ClassName) Then
    Result := FDicionario.Items[Classe.ClassName];
end;

class function TRTTISingletonCollection.Instance: TRTTISingletonCollection;
begin
  If Not Assigned(FInstance) Then
    FInstance := MakeInstance;
  Result := FInstance;
end;

constructor TRTTISingletonCollection.MakeInstance;
begin
  Inherited;
  FDicionario := TObjectDictionary<String, TObjectList<TLayout>>.Create;
end;

procedure TRTTISingletonCollection.pAdd(obj: TLayout);
  Var
    List : TObjectList<TLayout>;
begin
  If Not FDicionario.ContainsKey(obj.ClassName) Then
  Begin
    List := TObjectList<TLayout>.Create;
    FDicionario.Add(obj.ClassName, List);
  End;

  FDicionario.Items[obj.ClassName].Add(Obj);

end;

end.
