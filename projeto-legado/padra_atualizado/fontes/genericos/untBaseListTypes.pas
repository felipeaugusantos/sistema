unit untBaseListTypes;

interface

uses Classes;

type
  TListSortCompare = function(Item1, Item2: IInterface): Integer of object;

  TSorting = class
  public
    class procedure QuickSort(SortList: IInterfaceList; L, R: Integer;
      SCompare: TListSortCompare);
  end;

  Sorting = TSorting;

implementation

{ TSorting }

class procedure TSorting.QuickSort(SortList: IInterfaceList; L, R: Integer;
  SCompare: TListSortCompare);
var
  I, J: Integer;
  P, T: IInterface;
begin
  repeat
    I := L;
    J := R;
    P := SortList.Items[(L + R) shr 1];
    repeat
      while SCompare(SortList[I], P) < 0 do
        Inc(I);
      while SCompare(SortList[J], P) > 0 do
        Dec(J);
      if I <= J then
      begin
        T := SortList[I];
        SortList[I] := SortList[J];
        SortList[J] := T;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      QuickSort(SortList, L, J, SCompare);
    L := I;
  until I >= R;
end;

end.
