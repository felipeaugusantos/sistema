unit Produto.GS1CNP.Interfaces.JSONParse;

interface

uses System.JSON, Produto.GS1CNP.Shared.Types;

type
  IProdutoGS1CNPJSONParse = interface
    ['{E5E71C95-AED6-44F8-B507-EA11D41C4628}']

    function GetEntryValue(AMemberName: String; ADefault: String = ''): String; overload;
    function GetEntryValue(AJSON: TJSONObject; AMemberName: String; ADefault: String = ''): String; overload;
    function GetEntryValueChild(AObjectName, AMemberName: String; ADefault: String): String; overload;
    function GetEntryValueChild(AObjectName, AObjectChildName, AMemberName: String; ADefault: String): String; overload;
    function GetEntryArrayValidations(AObjectName, AMemberName: String): TArrayValidations; overload;
    function GetEntryArrayValidations(AObjectName: String): TArrayValidations; overload;
    function GetEntryArrayValidationsSampleField(AObjectName: String): TArrayValidations;
    function GetEntryArray(AObjectName, AMemberName: String): String;
    function GetEntryNcmValueArray(AObjectName, AObjectChildName, AMemberName, AMemberValue: String): String;
  end;

implementation

end.
