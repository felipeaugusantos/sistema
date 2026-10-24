unit untFactoryClass;

interface

uses Classes, untBaseClass, untBaseIntf, untBaseListClass, untBaseListIntf;

type
  TFactory = Class(TObject)
  public
    class function Create(const EntityName:String):IBaseIntf;
    class function CreateProps(const EntityName: string;
      PropNames: array of string; PropValues: array of const): IBaseIntf;

    class function GetEntityName(const ClassName: String):String;
    class procedure RegisterClass(const Classe:TBaseClassRef;const EntityName: String);

    class function CreateList:IBaseList; overload;
    class function CreateList(const ListName:String):IBaseList; overload;
    class procedure RegisterList(const List:TBaseListRef;const ListName: String);
  end;
  Factory = TFactory;

implementation

uses SysUtils, Contnrs;

type
  TClasseRec = record
    ClassRef : TBaseClassRef;
    EntityName : String;
  end;

  TListRec = record
    ListRef : TBaseListRef;
    ListName : String;
  end;

var
  FClasses : array of TClasseRec;
  FLists : array of TListRec;

{ TObjectFactory }      

class function TFactory.Create(const EntityName: String): IBaseIntf;
var
  i : integer;
begin
  for i := Low(FClasses) to High(FClasses) do
  begin
    if SameText(FClasses[i].EntityName,EntityName) then
    begin
      Result := FClasses[i].ClassRef.Create;
      Exit;
    end;
  end;
  raise Exception.Create(EntityName);
end;

class function TFactory.CreateList: IBaseList;
begin
  Result := TBaseList.Create;
end;

class function TFactory.CreateList(const ListName: String): IBaseList;
var
  i : integer;
begin
  for i := Low(FLists) to High(FLists) do
  begin
    if SameText(FLists[i].ListName,ListName) then
    begin
      Result := FLists[i].ListRef.Create;
      Exit;
    end;
  end;
  raise Exception.Create(ListName);
end;

class function TFactory.CreateProps(const EntityName: string;
  PropNames: array of string; PropValues: array of const): IBaseIntf;
var
  I: Integer;
begin
  for I := Low(FClasses) to High(FClasses) do
  begin
    if SameText(FClasses[I].EntityName, EntityName) then
    begin
      Result := FClasses[I].ClassRef.CreateProps(PropNames, PropValues);
      Exit;
    end;
  end;
  raise Exception.Create(EntityName);
end;

class function TFactory.GetEntityName(const ClassName: String): String;
var
  i : integer;
begin
  Result := '';
  for i := Low(FClasses) to High(FClasses) do
  begin
    if FClasses[i].ClassRef.ClassName = ClassName then
    begin
      Result := FClasses[i].EntityName;
      Break;
    end;
  end;
end;

class procedure TFactory.RegisterClass(const Classe: TBaseClassRef;const EntityName: String);
var
  l : Integer;
begin
  l := Length(FClasses);
  SetLength(FClasses,l+1);
  FClasses[l].ClassRef   := Classe;
  FClasses[l].EntityName := EntityName;
end;

class procedure TFactory.RegisterList(const List: TBaseListRef;
  const ListName: String);
var
  l : Integer;
begin
  l := Length(FLists);
  SetLength(FLists,l+1);
  FLists[l].ListRef  := List;
  FLists[l].ListName := ListName;
end;

initialization
  SetLength(FClasses,0);
  SetLength(FLists,0);

finalization


end.
