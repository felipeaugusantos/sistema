unit untBaseListIntf;

interface

uses Classes, untBaseIntf, untBaseListTypes;

type
  IBaseIterator = interface;

  IBaseList = interface(IInterfaceList)
    ['{6DEA2B62-63DA-4C94-8EC4-221239DD7203}']
    function GetIterator:IBaseIterator;
    procedure AddBaseList(BaseList: IBaseList);
    procedure Sort(Compare: TListSortCompare);
    property Iterator : IBaseIterator read GetIterator;
  end;

  IBaseIterator = interface(IInterface)
    ['{E56E6895-2579-4464-8225-CD640CC79CF1}']
    procedure Reset;
    function Next:Boolean;
    function CurrentItem:IBaseIntf;
    function GetIndex:Integer;
  end;

implementation

end.
