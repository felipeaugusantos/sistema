unit untQuery;

interface

uses untQueryParam, DB, Classes;

type
  IQuery = Interface
    ['{6C44D810-678E-4FE4-9BD9-80AF3A69E7AE}']
    procedure Close;
    procedure Open;
    procedure ExecSQL;
    function FieldByName(const FieldName: string): TField;
    function ParamByName(const ParamName: String): IQueryParam;
    function IsEmpty : Boolean;
    procedure Insert;
    procedure Post;
    procedure setSQL(const Value: TStrings);
    function getSQL: TStrings;
    property SQL: TStrings read getSQL write setSQL;
    procedure First;
    function Eof : Boolean;
    procedure Next;
    function FindField(const FieldName: string): TField;
    procedure Append;
    function Active : Boolean;
    procedure Edit;
  end;

implementation

end.
