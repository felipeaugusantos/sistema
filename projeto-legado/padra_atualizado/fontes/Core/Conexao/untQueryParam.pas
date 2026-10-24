unit untQueryParam;

interface

type
  IQueryParam = interface
    ['{8C4872CD-A4E5-41CB-87C7-6B0D5BAA4DA6}']
    function getAsString: String;
    function getAsInteger: Integer;
    function getAsDateTime: TDateTime;
    procedure setAsInteger(const Value: Integer);
    procedure setAsString(const Value: String);
    procedure setAsDateTime(const Value: TDateTime);
    property AsString: String read getAsString write setAsString;
    property AsInteger: Integer read getAsInteger write setAsInteger;
    property AsDateTime: TDateTime read getAsDateTime write setAsDateTime;
  end;

implementation

end.
