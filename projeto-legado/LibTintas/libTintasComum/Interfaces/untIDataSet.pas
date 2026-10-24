{******************************************************************************************}
{* Interface que representa a implementação de um DataSet, necessária para transportar os *}
{* datasets do autcom/autcomtinta/auttin para a dll especifica, pois a dll não tem        *}
{* conhecimento da conexão, e tem que ser compativel com mais de uma versão do Delphi     *}
{***************************************************************************************PH*}
unit untIDataSet;

interface

uses
  DB;

type
  IDataSetField = interface
    ['{7E83B67F-DF40-4D41-ABFC-12DA5E5872B3}']
    function GetAsString: String;
    procedure SetAsString(const strTexto: String);
    function GetAsFloat: Double;
    procedure SetAsFloat(const fltValor: Double);
    function GetAsInteger: Integer;
    procedure SetAsInteger(const intValor: Integer);
    function GetAsDate: TDate;
    procedure SetAsDate(const dtaData: TDate);
    function GetAsValue: Variant;
    procedure SetAsValue(const vValor: Variant);

    property AsString: String read GetAsString write SetAsString;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsDate: TDate read GetAsDate write SetAsDate;
    property Value: Variant read GetAsValue write SetAsValue;
  end;

  IDataSetParam = interface
    ['{2C08023B-5668-418D-B364-58B394E84588}']
    function GetAsString: String;
    function GetAsInteger: Integer;
    function GetAsFloat: Double;
    function GetAsVariant: Variant;
    function GetAsDateTime: TDateTime;

    procedure SetAsString(const strTexto: String);
    procedure SetAsFloat(const fltValor: Double);
    procedure SetAsInteger(const intValor: Integer);
    procedure SetAsVariant(const varValor: Variant);
    procedure SetAsDateTime(const dtaValor: TDateTime);

    property AsString: String read GetAsString write SetAsString;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property Value: Variant Read GetAsVariant Write SetAsVariant;
    property AsVariant: Variant Read GetAsVariant Write SetAsVariant;
    property AsDateTime: TDateTime Read GetAsDateTime Write SetAsDateTime;

  end;

  IDataSet = interface
    ['{7E60F783-DB1E-4B87-8ED0-3CE849955AA0}']
    function GetObject: TObject;
    function GetSQL: String;
    procedure SetSQL(const strSql: String);
    function GetActive(): Boolean;
    procedure SetActive(const Value: Boolean);

    procedure Open;
    procedure Close;
    procedure ExecSQL;
    function Locate(const KeyFields: String; const KeyValues: Variant; Options: TLocateOptions): Boolean;
    function IsEmpty: Boolean;
    function Eof: Boolean;
    procedure Next;
    procedure First;
    function RecordCount: Integer;
    function RecNo: Integer;

    function FieldByName(const strNome: String): IDataSetField;
    function FindField(const FieldName: String): IDataSetField;
    function ParamByName(const Value: String): IDataSetParam;
    function Params(const Value: Integer): IDataSetParam;

    procedure Insert;
    procedure Edit;
    procedure Delete;
    procedure Post;
    procedure Filtrar(const strFiltro: string);

    property SQL: String read GetSQL write SetSQL;
    property Active: Boolean read GetActive write SetActive;
  end;


implementation

end.
