unit Produto.GS1CNP.Shared.JSONParse;

interface

uses System.JSON, Produto.GS1CNP.Interfaces.JSONParse, Produto.GS1CNP.Shared.Types,
 System.Variants, untFuncoesSimples;

type
  TProdutoGS1CNPJSONParse = class(TInterfacedObject, IProdutoGS1CNPJSONParse)
  private
    FJsonObj: TJSONObject;
  public
    constructor Create(const AJson: String); overload;

    function GetEntryValue(AMemberName: String; ADefault: String = ''): String; overload;
    function GetEntryValue(AJSON: TJSONObject; AMemberName: String; ADefault: String = ''): String; overload;
    function GetEntryValueChild(AObjectName, AMemberName: String; ADefault: String): String; overload;
    function GetEntryValueChild(AObjectName, AObjectChildName, AMemberName: String; ADefault: String): String; overload;
    function GetEntryArrayValidations(AObjectName, AMemberName: String): TArrayValidations; overload;
    function GetEntryArrayValidations(AObjectName: String): TArrayValidations; overload;
    function GetEntryArrayValidationsSampleField(AObjectName: String): TArrayValidations;
    function GetEntryArray(AObjectName, AMemberName: String): String;
    function GetEntryNcmValueArray(AObjectName, AObjectChildName, AMemberName, AMemberValue: String): String;

    class function New(const AJson: String): IProdutoGS1CNPJSONParse;
  end;

implementation

{ TProdutoGS1CNPJSONParse }

constructor TProdutoGS1CNPJSONParse.Create(const AJson: String);
begin
  inherited Create;

  FJsonObj := TJSONObject.ParseJSONValue( AJson ) as TJSONObject;
end;

function TProdutoGS1CNPJSONParse.GetEntryArrayValidations(AObjectName,
  AMemberName: String): TArrayValidations;
var
  LObject: TJSONObject;
  LArray: TJSONArray;
  LArrayElement: TJSONValue;
  LArrayFields: TJSONArray;
  LArrayElementField: TJSONValue;
  LObjectField: TJSONObject;
begin
  SetLength(Result, 0);

  LObject := TJSONObject(FJsonObj.GetValue(AObjectName));

  If Not Assigned(LObject) Then
    Exit;

  LArray  := TJSONArray(LObject.GetValue(AMemberName));

  for LArrayElement in LArray do
  begin
    LObject := (LArrayElement as TJSONObject);

    SetLength(Result, Length(Result) + 1);

    Result[Length(Result) - 1].code := (LObject.GetValue('code') as TJSONString).Value;
    Result[Length(Result) - 1].messageValidations := (LObject.GetValue('message') as TJSONString).Value;

    LArrayFields := TJSONArray(LObject.GetValue('fields'));

    SetLength(Result[Length(Result) - 1].fields, 0);
    for LArrayElementField in LArrayFields do
    begin
      LObject := (LArrayElementField as TJSONObject);

      LObjectField := TJSONObject(LObject.GetValue('field'));

      SetLength(Result[Length(Result) - 1].fields, Length(Result[Length(Result) - 1].fields) + 1);

      If Pos('"field"', LObjectField.ToJSON) > 0 then
      Begin
        Result[Length(Result) - 1].fields[Length(Result[Length(Result) - 1].fields) - 1].field.field := (LObjectField.GetValue('field') as TJSONString).Value;
        Exit;
      End;

      Result[Length(Result) - 1].fields[Length(Result[Length(Result) - 1].fields) - 1].field.field := (LObject.GetValue('field') as TJSONString).Value;
    end;
  end;
end;

function TProdutoGS1CNPJSONParse.GetEntryArray(AObjectName,
  AMemberName: String): String;
var
  LObject: TJSONObject;
  LArray: TJSONArray;
  LArrayElement: TJSONValue;
begin
  Result := '';

  LArray := TJSONArray(FJsonObj.GetValue('referencedFileInformations'));

  for LArrayElement in LArray do
  begin
    LObject := (LArrayElement as TJSONObject);

    If (LObject.GetValue('uniformResourceIdentifier') as TJSONString).Value <> Null Then
    Begin
      Result := (LObject.GetValue('uniformResourceIdentifier') as TJSONString).Value;
      Exit;
    End;
  end;
end;

function TProdutoGS1CNPJSONParse.GetEntryArrayValidations(
  AObjectName: String): TArrayValidations;
var
  LObject: TJSONObject;
  LArray: TJSONArray;
  LArrayElement: TJSONValue;
  LArrayFields: TJSONArray;
  LArrayElementField: TJSONValue;
  LObjectField: TJSONObject;
begin
  SetLength(Result, 0);

  LArray := TJSONArray(FJsonObj.GetValue(AObjectName));

  If Not Assigned(LArray) Then
    Exit;

  for LArrayElement in LArray do
  begin
    LObject := (LArrayElement as TJSONObject);

    SetLength(Result, Length(Result) + 1);

    Result[Length(Result) - 1].code := (LObject.GetValue('code') as TJSONString).Value;
    Result[Length(Result) - 1].messageValidations := (LObject.GetValue('message') as TJSONString).Value;

    LArrayFields := TJSONArray(LObject.GetValue('fields'));

    SetLength(Result[Length(Result) - 1].fields, 0);
    for LArrayElementField in LArrayFields do
    begin
      LObject := (LArrayElementField as TJSONObject);

      LObjectField := TJSONObject(LObject.GetValue('field'));

      SetLength(Result[Length(Result) - 1].fields, Length(Result[Length(Result) - 1].fields) + 1);

      Result[Length(Result) - 1].fields[Length(Result[Length(Result) - 1].fields) - 1].field.field := (LObjectField.GetValue('field') as TJSONString).Value;
    end;
  end;
end;

function TProdutoGS1CNPJSONParse.GetEntryArrayValidationsSampleField(
  AObjectName: String): TArrayValidations;
var
  LObject: TJSONObject;
  LArray: TJSONArray;
  LArrayElement: TJSONValue;
  LArrayFields: TJSONArray;
  LArrayElementField: TJSONValue;
begin
  SetLength(Result, 0);

  LArray := TJSONArray(FJsonObj.GetValue(AObjectName));

  If Not Assigned(LArray) Then
    Exit;

  for LArrayElement in LArray do
  begin
    LObject := (LArrayElement as TJSONObject);

    SetLength(Result, Length(Result) + 1);

    Result[Length(Result) - 1].code := (LObject.GetValue('code') as TJSONString).Value;
    Result[Length(Result) - 1].messageValidations := (LObject.GetValue('message') as TJSONString).Value;

    LArrayFields := TJSONArray(LObject.GetValue('fields'));

    SetLength(Result[Length(Result) - 1].fields, 0);
    for LArrayElementField in LArrayFields do
    begin
      LObject := (LArrayElementField as TJSONObject);

      SetLength(Result[Length(Result) - 1].fields, Length(Result[Length(Result) - 1].fields) + 1);

      Result[Length(Result) - 1].fields[Length(Result[Length(Result) - 1].fields) - 1].field.field := (LObject.GetValue('field') as TJSONString).Value;
    end;
  end;
end;

function TProdutoGS1CNPJSONParse.GetEntryNcmValueArray(AObjectName,
  AObjectChildName, AMemberName, AMemberValue: String): String;
var
  LObject: TJSONObject;
  LArray: TJSONArray;
  LArrayElement: TJSONValue;
begin
  Result := '';

  LObject := TJSONObject(FJsonObj.GetValue(AObjectName));

  LArray := TJSONArray(LObject.GetValue(AObjectChildName));

  for LArrayElement in LArray do
  begin
    LObject := (LArrayElement as TJSONObject);

    If (LObject.GetValue(AMemberName) as TJSONString).Value = 'NCM' Then
    Begin
      Result := fTiraCaracEspeciais((LObject.GetValue(AMemberValue) as TJSONString).Value, False, False, True, False, False, False);
      Exit;
    End;
  end;
end;

function TProdutoGS1CNPJSONParse.GetEntryValue(AJSON: TJSONObject; AMemberName: String; ADefault: String = ''): String;
var
  LJSONPair: TJSONPair;
  LJSONScenarioEntry: TJSONValue;
  LJSONScenarioValue: TJSONString;
begin
  Result := ADefault;

  LJSONPair := AJSON.Get(AMemberName);
  LJSONScenarioEntry := LJSONPair.JsonValue;

  If LJSONScenarioEntry.Null Then
    Exit;

  LJSONScenarioValue := LJSONScenarioEntry as TJSONString;

  Result := LJSONScenarioValue.Value;
end;

function TProdutoGS1CNPJSONParse.GetEntryValueChild(
  AObjectName, AMemberName, ADefault: String): String;
var
  LObject: TJSONObject;
begin
  Result := ADefault;

  LObject := TJSONObject(FJsonObj.GetValue(AObjectName));

  If Not Assigned(LObject) Then
    Exit;

  Result := GetEntryValue(LObject, AMemberName, ADefault);
end;

function TProdutoGS1CNPJSONParse.GetEntryValue(AMemberName,
  ADefault: String): String;
begin
  Result := GetEntryValue(FJsonObj, AMemberName, ADefault);
end;

function TProdutoGS1CNPJSONParse.GetEntryValueChild(
  AObjectName, AObjectChildName, AMemberName, ADefault: String): String;
var
  LObject: TJSONObject;
  LObjectChild: TJSONObject;
begin
  Result := ADefault;

  LObject := TJSONObject(FJsonObj.GetValue(AObjectName));

  If Not Assigned(LObject) Then
    Exit;

  LObjectChild := TJSONObject(LObject.GetValue(AObjectChildName));

  Result := GetEntryValue(LObjectChild, AMemberName, ADefault);
end;

class function TProdutoGS1CNPJSONParse.New(
  const AJson: String): IProdutoGS1CNPJSONParse;
begin
  Result := Self.Create(AJson);
end;

end.
