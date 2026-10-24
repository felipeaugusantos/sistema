unit Services.Core.Connection.Interfaces;

interface

uses Data.DB, System.Classes;

type
  IField = interface
    ['{DFEE5AB4-4880-4EDB-8D81-2F1AD1FE89F2}']
    function GetAsString: String;
    procedure SetAsString(const AValue: String);
    function GetAsFloat: Double;
    procedure SetAsFloat(const AValue: Double);
    function GetAsInteger: Integer;
    procedure SetAsInteger(const AValue: Integer);
    function GetAsLargeInt: Int64;
    procedure SetAsLargeInt(const AValue: Int64);
    function GetAsBoolean: Boolean;
    procedure SetAsBoolean(const AValue: Boolean);
    function GetAsDate: TDate;
    procedure SetAsDate(const AValue: TDate);
    function GetAsDateTime: TDateTime;
    procedure SetAsDateTime(const AValue: TDateTime);
    function GetAsValue: Variant;
    function DataType: TFieldType;
    function FieldKind: TFieldKind;
    function FieldName: String;
    function IsNull: Boolean;
    function Required: Boolean;
    procedure Clear;
    procedure SetAsValue(const AValue: Variant);
    property AsString: String read GetAsString write SetAsString;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsLargeInt: Int64 read GetAsLargeInt write SetAsLargeInt;
    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
    property AsDate: TDate read GetAsDate write SetAsDate;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property Value: Variant read GetAsValue write SetAsValue;
  end;

  IParam = Interface
    ['{E840027F-F37C-47DA-9F7F-4675DBDC13CA}']
    function GetAsBoolean: Boolean;
    procedure SetAsBoolean(const AValue: Boolean);
    function GetAsInteger: Integer;
    procedure SetAsInteger(const AValue: Integer);
    function GetAsString: String;
    procedure SetAsString(const AValue: String);
    function GetAsDate: TDate;
    procedure SetAsDate(const AValue: TDate);
    function GetAsTime: TTime;
    procedure SetAsTime(const AValue: TTime);
    function GetAsFloat: Double;
    procedure SetAsFloat(const AValue: Double);
    function getValue: Variant;
    procedure setValue(const AValue: Variant);
    function GetAsDateTime: TDateTime;
    function Name: String;
    procedure Clear;
    procedure SetAsDateTime(const AValue: TDateTime);
    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsString: String read GetAsString write SetAsString;
    property AsDate: TDate read GetAsDate write SetAsDate;
    property AsTime: TTime read GetAsTime write SetAsTime;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property Value: Variant read getValue write setValue;
  End;

  IScript = interface
    ['{9F8337D8-DADD-464F-A41D-AC09B72598DD}']
    function SQL(): TStrings;
    procedure Execute;
  end;

  IQuery = Interface
    ['{CA4B72DE-3944-4BF1-9816-45FF2519D6AD}']
    function Active: Boolean;
    function GetRecNo: Integer;
    procedure SetRecNo(AValue: Integer);
    procedure Refresh;
    procedure Append;
    procedure Edit;
    procedure Post;
    procedure Cancel;
    procedure Delete;
    procedure First;
    procedure Last;
    procedure Next;
    procedure Prior;
    function RecordCount: Integer;
    function Eof(): Boolean;
    function SQL(): TStrings;
    procedure Open;
    procedure Close;
    function IsEmpty(): Boolean;
    procedure ExecSQL;
    function ParamCount(): Integer;
    function Params(AIndex: Integer): IParam;
    function ParamByName(AName: String): IParam;
    function FindParam(AName: String): IParam;
    function FieldByName(AName: String): IField;
    function FindField(AName: String): IField;
    function Fields(AIndex: Integer): IField;
    function FieldCount: Integer;
    function Locate(const KeyFields: string; const KeyValues: Variant;
      Options: TLocateOptions): Boolean;
    function GetObject: TObject;
    property RecNo: Integer read GetRecNo write SetRecNo;
  End;

  IConnection = Interface
    ['{48F87B53-BFC8-419C-9E38-C187659229BF}']
    function CreateQuery(ASQL: String = ''): IQuery;
    function CreateQueryObject(AOwner: TComponent): TObject;
    function CreateScript(): IScript;
    function SetServer(AValue: String): IConnection;
    function SetDatabase(AValue: String): IConnection;
    function SetUser(AValue: String): IConnection;
    function SetPassword(AValue: String): IConnection;
    function SetPort(AValue: Integer): IConnection;
    function GetTag(): NativeUInt;
    function Database(): String;
    procedure Connect();
    function Connected(): Boolean;
    procedure Disconnect();
    procedure StartTransaction();
    procedure Commit();
    procedure Rollback;
    function ConnectionID: String;
    function InTransaction(): Boolean;
    function GetObject: TObject;
  End;

implementation

end.
