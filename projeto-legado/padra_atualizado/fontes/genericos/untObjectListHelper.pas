unit untObjectListHelper;

interface

uses
  System.Generics.Collections,
  SysUtils;

type
  TCompare<T> = reference to function ( element : T ) : boolean;
  TMethod<T> = reference to procedure ( element : T );

  TObjectListHelper<T:class> = class(TObjectList<T>)
  private
  public
    function findFirst(compare : TCompare<T> ) : T;
    function anyMatch(compare : TCompare<T> ) : Boolean;
    procedure forEach(method : TMethod<T> );
  end;

implementation

{ TObjectListHelper }
function TObjectListHelper<T>.anyMatch(compare: TCompare<T>): Boolean;
var
  element : T;
begin
  Result := False;
  for element in self do
    if compare(element) then
      exit(True);
end;

function TObjectListHelper<T>.findFirst(compare : TCompare<T> ): T;
var
  element : T;
begin
  Result := T(nil);
  for element in self do
    if compare(element) then
      exit(element);
end;

procedure TObjectListHelper<T>.forEach(method: TMethod<T>);
var
  element : T;
begin
  for element in self do
    method(element)
end;

end.
