unit untBaseIntf;

interface

type
  IBaseIntf = interface(IInterface)
    ['{931F0AAF-1DB7-488C-A235-25DF3B5C12DE}']
    function Implements(const IID: TGUID): Boolean;
    function GetClass:TClass;
    procedure Validate;
    function HasPrimaryKey: Boolean;
    function GetIsPersistent: Boolean;
    procedure SetIsPersistent(const Value: Boolean);
    property IsPersistent: Boolean read GetIsPersistent;
  end;

implementation

end.

