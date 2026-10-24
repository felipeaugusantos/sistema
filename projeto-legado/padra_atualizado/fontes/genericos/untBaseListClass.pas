unit untBaseListClass;

interface

uses Classes, untBaseIntf, untBaseListIntf, untBaseListTypes;

type
  TIteratorList = function : IBaseList of object;

  {$M+}
  TBaseList = class(TInterfaceList, IBaseList)
  private
    FIterator : IBaseIterator;
    function GetList: IBaseList;
  public
    function GetIterator:IBaseIterator;
    procedure AddBaseList(BaseList: IBaseList);
    procedure Sort(Compare: TListSortCompare);
    property Iterator : IBaseIterator read GetIterator;
  end;
  {$M-}
  TBaseListRef = class of TBaseList;

  TBaseIterator = class(TInterfacedObject, IBaseIterator)
  protected
    FIndex : Integer;
    FIteratorList: TIteratorList;
  public
    constructor Create(AIteratorList: TIteratorList);
    function Next: Boolean;
    procedure Reset;
    function CurrentItem: IBaseIntf;
    function GetIndex: Integer;
  end;

implementation

{ TBaseIterator }

procedure QuickSort(SortList: IBaseList; L, R: Integer;
  SCompare: TListSortCompare);
begin
  Sorting.QuickSort(SortList, L, R, SCompare);
end;

constructor TBaseIterator.Create(AIteratorList: TIteratorList);
begin
  inherited Create;
  FIteratorList := AIteratorList;
end;

function TBaseIterator.CurrentItem: IBaseIntf;
begin
 if (Assigned(FIteratorList)) and ((FIndex >= 0) and (FIndex < FIteratorList.Count)) then
    Result := (FIteratorList[FIndex] as IBaseIntf)
  else
    Result := nil;
end;

function TBaseIterator.GetIndex: Integer;
begin
  Result := FIndex;
end;

function TBaseIterator.Next: Boolean;
begin
  Result := (Assigned(FIteratorList)) and (FIndex < (FIteratorList.Count - 1));
  if Result then
    Inc(FIndex);
end;

procedure TBaseIterator.Reset;
begin
  FIndex := -1;
end;

{ TBaseList }

procedure TBaseList.AddBaseList(BaseList: IBaseList);
begin
  BaseList.Iterator.Reset;
  while BaseList.Iterator.Next do
  begin
    Add(BaseList.Iterator.CurrentItem);
  end;
end;

function TBaseList.GetIterator: IBaseIterator;
begin
  if FIterator = nil then
    FIterator := TBaseIterator.Create(GetList);
  Result := FIterator;
end;

function TBaseList.GetList: IBaseList;
begin
  result := Self;
end;

procedure TBaseList.Sort(Compare: TListSortCompare);
begin
  if Self.Count > 0 then
    Sorting.QuickSort(Self, 0, Self.Count - 1, Compare);
end;

end.
