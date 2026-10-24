unit Shared.Functions.DataSet;

interface

uses
  System.Classes, System.SysUtils, System.Variants, System.strUtils;

type
  IMyField = interface
    ['{204654D4-6FB4-467A-A122-7616CAF9BCBA}']

    function GetAsString: String;
    procedure SetAsString(const AValue: String);
    function GetAsFloat: Double;
    procedure SetAsFloat(const AValue: Double);
    function GetAsInteger: Integer;
    procedure SetAsInteger(const AValue: Integer);
    function GetAsDate: TDate;
    procedure SetAsDate(const AValue: TDate);
    function GetAsValue: Variant;
    procedure SetAsValue(const AValue: Variant);
    function getAsAnsiString: AnsiString;
    procedure setAsAnsiString(const AValue: AnsiString);

    property AsString: String read GetAsString write SetAsString;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsDate: TDate read GetAsDate write SetAsDate;
    property Value: Variant read GetAsValue write SetAsValue;
    property AsAnsiString: AnsiString read getAsAnsiString write setAsAnsiString;
  end;

  IMyParam = Interface
    ['{DA92D43A-691D-4807-A606-64147CFE59B1}']

    function getAsBoolean: Boolean;
    procedure setAsBoolean(const AValue: Boolean);
    function getAsInteger: Integer;
    procedure setAsInteger(const AValue: Integer);
    function getAsString: String;
    procedure setAsString(const AValue: String);
    function getAsDate: TDate;
    procedure setAsDate(const AValue: TDate);
    function getAsFloat: Double;
    procedure setasFloat(const AValue: Double);
    function getValue: Variant;
    procedure setValue(const AValue: Variant);
    function getAsDateTime: TDateTime;
    procedure setAsDateTime(const AValue: TDateTime);
    function getAsAnsiString: AnsiString;
    procedure setAsAnsiString(const AValue: AnsiString);
    property AsBoolean: Boolean read getAsBoolean write setAsBoolean;
    property AsInteger: Integer read getAsInteger write setAsInteger;
    property AsString: String read getAsString write setAsString;
    property AsDate: TDate read getAsDate write setAsDate;
    property AsFloat: Double read getAsFloat write setasFloat;
    property AsDateTime: TDateTime read getAsDateTime write setAsDateTime;
    property Value: Variant read getValue write setValue;
    property AsAnsiString: AnsiString read getAsAnsiString write setAsAnsiString;
  End;

  IMyQuery = Interface
    ['{73763095-A28F-4CBB-9E97-11742327B8C2}']

    function ExecSQL: Integer;
    procedure SetConnection(AConnection: TObject);
    function GetSQL: TStrings;
    procedure SetSQL(AValue: TStrings);
//    function GetFields: TFields;
    procedure Close;
    procedure Open;
    procedure First;
    procedure Last;
    procedure Next;
    function FindField(const AFieldName: String): IMyField;
    function Eof: Boolean;
    function FieldByName(const AFieldName: String): IMyField;
    function RecordCount: Integer;
    function ParamByName(const AParam: String): IMyParam;
    function FindParam(const AParam: String): IMyParam;
    function Active: Boolean;
    function IsEmpty: Boolean;
//    function getDataSet: TDataSet;
    procedure DisableControls;
    procedure EnableControls;
    procedure Append;
    procedure Post;
    property SQL: TStrings read GetSQL write SetSQL;
    function FieldExists(const AFieldName : String) : Boolean;
//    property Fields: TFields read GetFields;
//    property DataSet: TDataSet read getDataSet;
  End;

  IMyConnection = Interface
    ['{D40BDBAD-339A-4A4B-B10A-4833BE719A84}']
    function CreateQuery: IMyQuery;
    function GetConObj: TObject;
  End;

  IMyCampoTabelaAdd = Interface
    ['{A7FBA6EA-1EB7-4F52-AA75-092370EE8EDC}']

    procedure Add(AName: string; AValue: Variant);
    function BuscaChave(const AFieldName: String): Integer;
  End;

  TMyCampoTabelaValue = record
    Value: Variant;
    function AsString: String;
    function AsFloat: Double;
    function AsCurrency: Currency;
    function AsDateTime: TDateTime;
    function AsInteger: Integer;
    function AsBoolean: Boolean;
    class operator Implicit(Self: TMyCampoTabelaValue): String;
    class operator Implicit(Self: TMyCampoTabelaValue): Double;
    class operator Implicit(Self: TMyCampoTabelaValue): Currency;
    class operator Implicit(Self: TMyCampoTabelaValue): TDateTime;
    class operator Implicit(Self: TMyCampoTabelaValue): Integer;
    class operator Implicit(Self: TMyCampoTabelaValue): Boolean;
    class operator Implicit(Self: TMyCampoTabelaValue): Variant;
    class operator Implicit(Value: Variant): TMyCampoTabelaValue;
  end;

  IMyCampoTabela = Interface
    ['{422B75F3-EB26-4322-AEC9-A8CE7D4A1DF9}']
    function HasField(const AFieldName: String): Boolean;
    function FieldByName(const AFieldName: String): TMyCampoTabelaValue;
    function Fields(const AFieldIndex: Integer): TMyCampoTabelaValue;
  End;

  procedure SetObjDataSet(AValue: IMyConnection);

var
  objDataSet: IMyConnection;

implementation

procedure SetObjDataSet(AValue: IMyConnection);
begin
  objDataSet := AValue;
end;

{ TMyCampoTabelaValue }

function TMyCampoTabelaValue.AsBoolean: Boolean;
begin
  Try
    If AsString.IsEmpty Then
      Result := False
    Else If Pos(AsString, 'S_N_') > 0 Then
      Result := StrToBool(IfThen(AsString = 'S', 'True', 'False'))
    Else If Pos(AsString, '0_1_') > 0  Then
      Result := StrToBool(IfThen(AsString = '1', 'True', 'False'))
    Else
      Result := (Length(AsString) > 0) And CharInSet(AsString[1], ['T', 't', 'Y', 'y']);
  Except
    Result := False;
  End;
end;

function TMyCampoTabelaValue.AsCurrency: Currency;
begin
  Result := StrToCurrDef(AsString, 0);
end;

function TMyCampoTabelaValue.AsDateTime: TDateTime;
begin
  Result := StrToDateTimeDef(AsString, 0);
end;

function TMyCampoTabelaValue.AsFloat: Double;
begin
  Result := StrToFloatDef(AsString, 0);
end;

function TMyCampoTabelaValue.AsInteger: Integer;
begin
  Result := StrToIntDef(AsString, 0);
end;

function TMyCampoTabelaValue.AsString: String;
begin
  Result := VarToStrDef(Value, '');
end;

class operator TMyCampoTabelaValue.Implicit(
  Self: TMyCampoTabelaValue): Currency;
begin
  Result := Self.AsCurrency;
end;

class operator TMyCampoTabelaValue.Implicit(
  Value: Variant): TMyCampoTabelaValue;
begin
  Result.Value := Value;
end;

class operator TMyCampoTabelaValue.Implicit(Self: TMyCampoTabelaValue): Double;
begin
  Result := Self.AsFloat;
end;

class operator TMyCampoTabelaValue.Implicit(Self: TMyCampoTabelaValue): String;
begin
  Result := Self.AsString;
end;

class operator TMyCampoTabelaValue.Implicit(Self: TMyCampoTabelaValue): Integer;
begin
  Result := Self.AsInteger;
end;

class operator TMyCampoTabelaValue.Implicit(
  Self: TMyCampoTabelaValue): TDateTime;
begin
  Result := Self.AsDateTime;
end;

class operator TMyCampoTabelaValue.Implicit(Self: TMyCampoTabelaValue): Boolean;
begin
  Result := Self.AsBoolean;
end;

class operator TMyCampoTabelaValue.Implicit(Self: TMyCampoTabelaValue): Variant;
begin
  Result := Self.Value;
end;

end.
