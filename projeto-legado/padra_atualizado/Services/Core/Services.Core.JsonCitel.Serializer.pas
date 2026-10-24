unit Services.Core.JsonCitel.Serializer;

interface

uses
  System.RTTI,
  SysUtils,
  System.TypInfo,
  StrUtils,
  System.Generics.Collections,
  System.Classes,
  Variants,
  Data.DB,
  System.JSON,
  Services.Core.Converter.Attribute;

type
  TJSONVariantKind = (jvUndefined, jvObject, jvArray);
  TJSONParserKind = (kNone, kNull, kFalse, kTrue, kString, kInteger, kFloat,
    kObject, kArray);
  TStringDynamicArray = array of String;
  TVariantDynamicArray = array of Variant;
  EJSONException = class(Exception);

  TJsonCitelConverter = Class
  public
    class function ListOfObjectToJson<T: class, constructor>
      (AList: TList<T>): String;
    class procedure ListOfObjectFromJson<T: class, constructor>(AList: TList<T>;
      AJson: string);
  End;

  TJSONVariantData = record
  private
    FVType: TVarType;
    FVKind: TJSONVariantKind;
    FVCount: Integer;
    function GetKind: TJSONVariantKind;
    function GetCount: Integer;
    function GetVarData(const AName: String; var ADest: TVarData): Boolean;
    function GetValue(const AName: String): Variant;
    function GetValueCopy(const AName: String): Variant;
    procedure SetValue(const AName: String; const AValue: Variant);
    function GetItem(AIndex: Integer): Variant;
    procedure SetItem(AIndex: Integer; const AItem: Variant);
    function GetListType(LRttiType: TRttiType): TRttiType;
    function GetValueArrayJson(AName: String): Variant;
  public
    FNames: TStringDynamicArray;
    FValues: TVariantDynamicArray;
    procedure Init; overload;
    procedure Init(const AJson: String); overload;
    procedure InitFrom(const AValues: TVariantDynamicArray); overload;
    procedure Clear;
    function Data(const AName: String): TJSONVariantData; inline;
    function EnsureData(const APath: String): TJSONVariantData;
    function AddItem: TJSONVariantData;
    function NameIndex(const AName: String): Integer;
    function FromJSON(const AJson: String): Boolean;
    function ToJSON: String;
    function ToJSONSimples: String;
    function ToObject(AObject: TObject): Boolean;
    procedure AddValue(const AValue: Variant);
    procedure AddNameValue(const AName: String; const AValue: Variant);
    procedure SetPath(const APath: String; const AValue: Variant);
    property Kind: TJSONVariantKind read GetKind;
    property Count: Integer read GetCount;
    property Value[const AName: String]: Variant read GetValue
      write SetValue; default;
    property ValueCopy[const AName: String]: Variant read GetValueCopy;
    property Item[AIndex: Integer]: Variant read GetItem write SetItem;
  end;

  TJSONCitel = class
  private
    class function StringToJSON(const AText: string): string;
    class function ValueToJSON(const AValue: Variant): string;
    class procedure AppendChar(var AStr: String; AChr: Char);
    class function DateTimeToJSON(AValue: TDateTime): string;
    class procedure DoubleToJSON(AValue: Double; out AResult: string);
    class function JSONVariantData(const JSONVariant: Variant)
      : TJSONVariantData;
    class procedure SetInstanceProp(AInstance: TObject; AField: TRttiField;
      const AValue: Variant);
    class procedure FillListObjects(AObject: TObject; AField: TRttiField;
      AList: TObject; AJson: string);
    class function GetEnumValue(AObj: TObject; AValue: string;
      AField: string): TValue;
  public
    function ToJSON(AObject: TObject; AStoreClassName: Boolean = False): String;
    function ToObject(AObject: TObject; const AJson: String): Boolean;
    class function ObjectToJSON(AObject: TObject;
      AStoreClassName: Boolean = False): String;
    class function JSONToObject<T: class, constructor>(AJson: String): T; overload;
  end;

  TJSONParser = record
    FJson: String;
    FIndex: Integer;
    FJsonLength: Integer;
    procedure Init(const AJson: String; AIndex: Integer);
    function GetNextChar: Char; inline;
    function GetNextNonWhiteChar: Char; inline;
    function CheckNextNonWhiteChar(AChar: Char): Boolean; inline;
    function GetNextString(out AStr: String): Boolean; overload;
    function GetNextString: String; overload; inline;
    function GetNextJSON(out AValue: Variant): TJSONParserKind;
    function CheckNextIdent(const AExpectedIdent: string): Boolean;
    function GetNextAlphaPropName(out AFieldName: string): Boolean;
    function ParseJSONObject(out AData: TJSONVariantData): Boolean;
    function ParseJSONArray(out AData: TJSONVariantData): Boolean;
    procedure GetNextStringUnEscape(var AStr: string);
  end;

  TObjectHelper = class helper for TObject
  public
    function &GetType(out AType: TRttiType): Boolean;
    function GetColumns: TArray<TRttiProperty>;
    function MethodCall(AMethodName: string;
      const AParameters: array of TValue): TValue;
  end;

  TJSONVariant = class(TInvokeableVariantType)
  public
    procedure Copy(var ADest: TVarData; const ASource: TVarData;
      const AIndirect: Boolean); override;
    procedure Clear(var AVarData: TVarData); override;
    procedure Cast(var ADest: TVarData; const ASource: TVarData); override;
    procedure CastTo(var ADest: TVarData; const ASource: TVarData;
      const AVarType: TVarType); override;
  end;

  IUtilSingleton = interface
    ['{D41BA6C1-EFDB-4C58-937A-59B864A8F0F4}']
    function DateTimeToIso8601(AValue: TDateTime): string;
    function Iso8601ToDateTime(const AValue: string): TDateTime;
    function ParseCommandNoSQL(const ASubStr, ACommandText: string;

      ADefault: String = ''): string;

  end;

  TUtilSingleton = class sealed(TInterfacedObject, IUtilSingleton)
  private
    class var FInstance: IUtilSingleton;
  private
    constructor CreatePrivate;
  public
    { Public declarations }
    constructor Create;
    class function GetInstance: IUtilSingleton;

    function DateTimeToIso8601(AValue: TDateTime): string;
    function Iso8601ToDateTime(const AValue: string): TDateTime;
    function ParseCommandNoSQL(const ASubStr, ASQL: string;
      ADefault: String): string;
  end;

  TRttiPropertyHelper = class helper for TRttiProperty
  private
  public
    function IsBlob: Boolean;
  end;

  IRttiSingleton = interface
    ['{AF40524E-2027-46C3-AAAE-5F4267689CD8}']
    function CreateObject(ARttiType: TRttiType): TObject;
  end;

var
  JSONVariantType: TInvokeableVariantType;
  Context: TRttiContext;
  FJsonDefault: String;
  RegisteredClass:
    array of record
      ClassName: String;
      ClassType: TClass;
    end;

implementation

{ TJSONCitel }

class procedure TJSONCitel.AppendChar(var AStr: String; AChr: Char);
begin
  AStr := AStr + String(AChr);
end;

class function TJSONCitel.DateTimeToJSON(AValue: TDateTime): string;
begin
  Result := AnsiQuotedStr(TUtilSingleton.GetInstance.DateTimeToIso8601
    (AValue), '"');
end;

class procedure TJSONCitel.DoubleToJSON(AValue: Double; out AResult: string);
begin
  AResult := FloatToStr(AValue).Replace(',', '.');
end;

class procedure TJSONCitel.FillListObjects(AObject: TObject; AField: TRttiField;
  AList: TObject; AJson: string);
Var
  Att: TCustomAttribute;
  attListConverter: TJsonListConverter;
begin
  For Att In AField.GetAttributes Do
  Begin
    If (Att Is TJsonListConverter) Then
    Begin
      attListConverter := Att as TJsonListConverter;
      if Assigned(attListConverter) then
        attListConverter.FromJSON(AList, AJson);
      Exit;
    End;
  End;
end;

class function TJSONCitel.GetEnumValue(AObj: TObject; AValue: string;
  AField: string): TValue;
Var
  Ctx: TRttiContext;
  RTT: TRttiType;
  RTF: TRttiField;
  Att: TCustomAttribute;
  AttConverter: TAttributeConverter;
begin
  Result := '';
  Ctx := TRttiContext.Create;
  Try
    RTT := Ctx.GetType(AObj.ClassType);
    For RTF In RTT.GetFields Do
    Begin
      if (VarCompareValue('F' + RTF.Name, AField) <> vrEqual) then
        Continue;

      AttConverter := nil;
      For Att in RTF.GetAttributes Do
      Begin
        If Assigned(Att) then
        Begin
          If Att is TAttributeConverter Then
            AttConverter := Att as TAttributeConverter;
        End;
      End;

      For Att In RTF.GetAttributes Do
      Begin
        If (Att Is TAttributeConverter) Then
        Begin
          if Assigned(AttConverter) then
            Result := AttConverter.ConvertToEntityAttribute
              (TValue.From(AValue));

          Exit;
        End;
      End;
    End;
  Finally
    Ctx.Free;
  End;
end;

function TJSONCitel.ToObject(AObject: TObject; const AJson: String): Boolean;
var
  LDoc: TJSONVariantData;
begin
  if AObject = nil then
    Result := False
  else
  begin
    FJsonDefault := AJson;
    LDoc.Init(AJson);
    Result := LDoc.ToObject(AObject);
  end;
end;

class function TJSONCitel.JSONVariantData(const JSONVariant: Variant)
  : TJSONVariantData;
begin
  with TVarData(JSONVariant) do
  begin
    if VType = JSONVariantType.VarType then
      Result := TJSONVariantData(JSONVariant)
    else if VType = varByRef or varVariant then
      Result := TJSONVariantData(PVariant(VPointer)^)
    else
      raise EJSONException.CreateFmt
        ('JSONVariantData.Data(%d<>JSONVariant)', [VType]);
  end;
end;

class function TJSONCitel.ObjectToJSON(AObject: TObject;
  AStoreClassName: Boolean): String;
var
  LSerializer: TJSONCitel;
begin
  LSerializer := TJSONCitel.Create;
  try
    Result := LSerializer.ToJSON(AObject, AStoreClassName);
  finally
    LSerializer.Free;
  end;
end;

class function TJSONCitel.JSONToObject<T>(AJson: String): T;
var
  LJsonObject: TJSONObject;
  LDoc: TJSONVariantData;
begin
  AJson := AJson.Replace('\"', '"').Replace('\t', ' ');
  LJsonObject := TJSONObject.ParseJSONValue(AJson) as TJSONObject;
  try
    Result := T.Create;
    FJsonDefault := AJson;
    LDoc.Init(AJson);
    LDoc.ToObject(Result);
  finally
    LJsonObject.Free;
  end;
end;

function TJSONCitel.ToJSON(AObject: TObject; AStoreClassName: Boolean): String;
var
  LValue: TValue;
  LName: String;
  Ctx: TRttiContext;
  RTT: TRttiType;
  RTF: TRttiField;
  Att: TCustomAttribute;
  Val: TValue;
  LRet: String;
  LFName: string;
  LConverter: Boolean;
  attListConverter: TJsonListConverter;
  AttConverter: TAttributeConverter;
  attJsonIgnore: TJsonIgnore;
begin
  LValue := nil;
  LName := '';
  LRet := '';

  if AObject = nil then
  begin
    Result := 'null';
    Exit;
  end;

  Result := '{';

  Ctx := TRttiContext.Create;

  Try
    RTT := Ctx.GetType(AObject.ClassType);
    For RTF In RTT.GetFields Do
    Begin
      LFName := RTF.Name;
      if LFName.StartsWith('F') then
        Delete(LFName, 1, 1);
      LFName := StringToJSON(LFName);

      LConverter := True;

      attListConverter := nil;
      AttConverter := nil;
      attJsonIgnore := nil;

      For Att in RTF.GetAttributes Do
      Begin
        If Assigned(Att) then
        Begin
          If Att is TJsonListConverter Then
            attListConverter := Att as TJsonListConverter;

          If Att is TJsonIgnore Then
            attJsonIgnore := Att as TJsonIgnore;

          If Att is TAttributeConverter Then
            AttConverter := Att as TAttributeConverter;
        End;
      End;

      For Att in RTF.GetAttributes Do
      Begin
        If (Att Is TJsonListConverter) Then
        Begin
          if Assigned(attListConverter) And Not Assigned(attJsonIgnore) then
          begin
            Val := RTF.GetValue(AObject);
            Result := Result + LFName + ':' + attListConverter.ToJSON
              (Val.AsObject);
            LConverter := False;
          end;
        End;

        If (Att Is TAttributeConverter) Then
        Begin
          if Assigned(AttConverter) then
          begin
            Val := RTF.GetValue(AObject);
            Result := Result + LFName + ':' +
              ValueToJSON(AttConverter.ConvertToDatabaseColumn(Val)
              .ToString) + ',';
            LConverter := False;
          end;
        End;
      End;

      If LConverter And Not Assigned(attJsonIgnore) Then
      Begin
        Val := RTF.GetValue(AObject);
        Result := Result + LFName + ':' + ValueToJSON(Val.AsVariant) + ',';
      End;
    End;

    Result := IfThen(Result.EndsWith(','),
      Copy(Result, 1, Length(Result) - 1), Result);

    Result := Result + '}';
  Finally
    Ctx.Free;
  End;

end;

class procedure TJSONCitel.SetInstanceProp(AInstance: TObject;
  AField: TRttiField; const AValue: Variant);
var
  LObject: TObject;
  LValue: TValue;
begin
  if (AField <> nil) and (AInstance <> nil) then
  begin
    case AField.FieldType.TypeKind of
      tkString, tkWString, tkUString, tkWChar, tkLString, tkChar:
        if TVarData(AValue).VType <= varNull then
          AField.SetValue(AInstance, '')
        else
          AField.SetValue(AInstance, String(AValue));
      tkInteger, tkSet, tkInt64:
        AField.SetValue(AInstance, Integer(AValue));
      tkFloat:
        if TVarData(AValue).VType <= varNull then
          AField.SetValue(AInstance, 0)
        else if AField.FieldType.Handle = TypeInfo(TDateTime) then
          AField.SetValue(AInstance,
            TUtilSingleton.GetInstance.Iso8601ToDateTime(AValue))
        else if AField.FieldType.Handle = TypeInfo(TTime) then
          AField.SetValue(AInstance,
            TUtilSingleton.GetInstance.Iso8601ToDateTime(AValue))
        else
          AField.SetValue(AInstance, Double(AValue));
      tkVariant:
        AField.SetValue(AInstance, TValue.FromVariant(AValue));
      tkRecord:
        begin
        end;
      tkClass:
        begin
          LObject := AField.GetValue(AInstance).AsObject;
          if (Pos('TList<', LObject.ClassName) > 0) then
            FillListObjects(AInstance, AField, LObject, AValue)
          else
            raise Exception.Create
              ('função não implementada para tkClass no methodo SetInstanceProp');
        end;
      tkEnumeration:
        begin
          if TVarData(AValue).VType = varUString then
          begin
            LValue := GetEnumValue(AInstance, AValue, AField.Name);
            AField.SetValue(AInstance, LValue);
          end;
          if TVarData(AValue).VType = varBoolean then
          begin
            LValue := TVarData(AValue).VBoolean;
            AField.SetValue(AInstance, LValue);
          end;
        end;
      tkDynArray:
        begin
        end;
    end;
  end;
end;

class function TJSONCitel.StringToJSON(const AText: string): string;
var
  LLen, LFor: Integer;

  procedure DoEscape;
  var
    LChr: Integer;
  begin
    Result := '"' + Copy(AText, 1, LFor - 1);
    for LChr := LFor to LLen do
    begin
      case AText[LChr] of
        #8:
          Result := Result + '\b';
        #9:
          Result := Result + '\t';
        #10:
          Result := Result + '\n';
        #12:
          Result := Result + '\f';
        #13:
          Result := Result + '\r';
        '\':
          Result := Result + '\\';
        '"':
          Result := Result + '\"';
      else
        if AText[LChr] < ' ' then
          Result := Result + '\u00' + IntToHex(Ord(AText[LChr]), 2)
        else
          AppendChar(Result, AText[LChr]);
      end;
    end;
    AppendChar(Result, '"');
  end;

begin
  LLen := Length(AText);
  for LFor := 1 to LLen do
    case AText[LFor] of
      #0 .. #31, '\', '"':
        begin
          DoEscape;
          Exit;
        end;
    end;
  Result := AnsiQuotedStr(AText, '"');
end;

class function TJSONCitel.ValueToJSON(const AValue: Variant): string;
var
  LInt64: Int64;
  LDouble: Double;
begin
  case TVarData(AValue).VType of
    varByRef, varVariant:
      Result := ValueToJSON(PVariant(TVarData(AValue).VPointer)^);
    varNull:
      Result := 'null';
    varBoolean:
      begin
        if TVarData(AValue).VBoolean then
          Result := 'true'
        else
          Result := 'false';
      end;
    varDate:
      Result := DateTimeToJSON(TVarData(AValue).VDouble);
  else
    if VarIsOrdinal(AValue) then
    begin
      LInt64 := AValue;
      Result := IntToStr(LInt64);
    end
    else if VarIsFloat(AValue) then
    begin
      LDouble := AValue;
      DoubleToJSON(LDouble, Result)
    end
    else if VarIsStr(AValue) then
      Result := StringToJSON(VarToStr(AValue))
    else
      Result := VarToStr(AValue);
  end;
end;

{ TJSONVariantData }

function TJSONVariantData.AddItem: TJSONVariantData;
var
  LNew: TJSONVariantData;
begin
  LNew.Init;
  AddValue(Variant(LNew));
  Result := TJSONVariantData(FValues[FVCount - 1]);
end;

procedure TJSONVariantData.AddNameValue(const AName: String;
  const AValue: Variant);
begin
  if FVKind = jvUndefined then
    FVKind := jvObject
  else if FVKind <> jvObject then
    raise EJSONException.CreateFmt('AddNameValue(%s) over array', [AName]);
  if FVCount <= Length(FValues) then
  begin
    SetLength(FValues, FVCount + FVCount shr 3 + 32);
    SetLength(FNames, FVCount + FVCount shr 3 + 32);
  end;
  FValues[FVCount] := AValue;
  FNames[FVCount] := AName;
  Inc(FVCount);
end;

procedure TJSONVariantData.AddValue(const AValue: Variant);
begin
  if FVKind = jvUndefined then
    FVKind := jvArray
  else if FVKind <> jvArray then
    raise EJSONException.Create('AddValue() over object');
  if FVCount <= Length(FValues) then
    SetLength(FValues, FVCount + FVCount shr 3 + 32);
  FValues[FVCount] := AValue;
  Inc(FVCount);
end;

procedure TJSONVariantData.Clear;
begin
  FNames := nil;
  FValues := nil;
  Init;
end;

function TJSONVariantData.Data(const AName: String): TJSONVariantData;
var
  LFor: Integer;
begin
  LFor := NameIndex(AName);
  if (LFor < 0) or (TVarData(FValues[LFor]).VType <> JSONVariantType.VarType)
  then
    Result := TJSONVariantData(Variant(Null))
  else
    Result := TJSONVariantData(FValues[LFor]);
end;

function TJSONVariantData.EnsureData(const APath: String): TJSONVariantData;
var
  LFor: Integer;
  LNew: TJSONVariantData;
begin
  LFor := Pos('.', APath);
  if LFor = 0 then
  begin
    LFor := NameIndex(APath);
    if LFor < 0 then
    begin
      LNew.Init;
      AddNameValue(APath, Variant(LNew));
      Result := TJSONVariantData(FValues[FVCount - 1]);
    end
    else
    begin
      if TVarData(FValues[LFor]).VType <> JSONVariantType.VarType then
      begin
        VarClear(FValues[LFor]);
        TJSONVariantData(FValues[LFor]).Init;
      end;
      Result := TJSONVariantData(FValues[LFor]);
    end;
  end
  else
    Result := EnsureData(Copy(APath, 1, LFor - 1))
      .EnsureData(Copy(APath, LFor + 1, maxInt));
end;

function TJSONVariantData.FromJSON(const AJson: String): Boolean;
var
  LParser: TJSONParser;
begin
  LParser.Init(AJson, 1);
  Result := LParser.GetNextJSON(Variant(Self)) in [kObject, kArray];
end;

function TJSONVariantData.GetCount: Integer;
begin
  if (@Self = nil) or (FVType <> JSONVariantType.VarType) then
    Result := 0
  else
    Result := FVCount;
end;

function TJSONVariantData.GetItem(AIndex: Integer): Variant;
begin
  VarClear(Result);
  if (@Self <> nil) and (FVType = JSONVariantType.VarType) and (FVKind = jvArray)
  then
    if Cardinal(AIndex) < Cardinal(FVCount) then
      Result := FValues[AIndex];
end;

function TJSONVariantData.GetKind: TJSONVariantKind;
begin
  if (@Self = nil) or (FVType <> JSONVariantType.VarType) then
    Result := jvUndefined
  else
    Result := FVKind;
end;

function TJSONVariantData.GetListType(LRttiType: TRttiType): TRttiType;
var
  LTypeName: String;
  LContext: TRttiContext;
begin
  LContext := TRttiContext.Create;
  try
    LTypeName := LRttiType.ToString;
    LTypeName := StringReplace(LTypeName, 'TObjectList<', '', []);
    LTypeName := StringReplace(LTypeName, 'TList<', '', []);
    LTypeName := StringReplace(LTypeName, '>', '', []);
    Result := LContext.FindType(LTypeName);
  finally
    LContext.Free;
  end;
end;

function TJSONVariantData.GetValue(const AName: String): Variant;
begin
  VarClear(Result);
  if (@Self <> nil) and (FVType = JSONVariantType.VarType) and
    (FVKind = jvObject) then
    GetVarData(AName, TVarData(Result));
end;

function TJSONVariantData.GetValueArrayJson(AName: String): Variant;
begin
  Result := FJsonDefault;
  Result := Trim(Copy(Result, Pos(AName, Result), Length(Result)));
  Result := Trim(Copy(Result, Pos('[', Result),
    ((Pos(']', Result) + 1) - Pos('[', Result))));
end;

function TJSONVariantData.GetValueCopy(const AName: String): Variant;
var
  LFor: Cardinal;
begin
  VarClear(Result);
  if (@Self <> nil) and (FVType = JSONVariantType.VarType) and
    (FVKind = jvObject) then
  begin
    LFor := Cardinal(NameIndex(AName));
    if LFor < Cardinal(Length(FValues)) then
      Result := FValues[LFor];
  end;
end;

function TJSONVariantData.GetVarData(const AName: String;
  var ADest: TVarData): Boolean;
var
  LFor: Cardinal;
begin
  LFor := Cardinal(NameIndex(AName));
  if LFor < Cardinal(Length(FValues)) then
  begin
    ADest.VType := varVariant or varByRef;
    ADest.VPointer := @FValues[LFor];
    Result := True;
  end
  else
    Result := False;
end;

procedure TJSONVariantData.Init;
begin
  FVType := JSONVariantType.VarType;
  FVKind := jvUndefined;
  FVCount := 0;
  Pointer(FNames) := nil;
  Pointer(FValues) := nil;
end;

procedure TJSONVariantData.Init(const AJson: String);
begin
  Init;
  FromJSON(AJson);
  if FVType = varNull then
    FVKind := jvObject
  else if FVType <> JSONVariantType.VarType then
    Init;
end;

procedure TJSONVariantData.InitFrom(const AValues: TVariantDynamicArray);
begin
  Init;
  FVKind := jvArray;
  FValues := AValues;
  FVCount := Length(AValues);
end;

function TJSONVariantData.NameIndex(const AName: String): Integer;
begin
  if (@Self <> nil) and (FVType = JSONVariantType.VarType) and (FNames <> nil)
  then
    for Result := 0 to FVCount - 1 do
      if FNames[Result] = AName then
        Exit;
  Result := -1;
end;

procedure TJSONVariantData.SetItem(AIndex: Integer; const AItem: Variant);
begin
  if (@Self <> nil) and (FVType = JSONVariantType.VarType) and (FVKind = jvArray)
  then
    if Cardinal(AIndex) < Cardinal(FVCount) then
      FValues[AIndex] := AItem;
end;

procedure TJSONVariantData.SetPath(const APath: String; const AValue: Variant);
var
  LFor: Integer;
begin
  for LFor := Length(APath) downto 1 do
  begin
    if APath[LFor] = '.' then
    begin
      EnsureData(Copy(APath, 1, LFor - 1))
        .SetValue(Copy(APath, LFor + 1, maxInt), AValue);
      Exit;
    end;
  end;
  SetValue(APath, AValue);
end;

procedure TJSONVariantData.SetValue(const AName: String; const AValue: Variant);
var
  LFor: Integer;
begin
  if @Self = nil then
    raise EJSONException.Create('Unexpected Value[] access');
  if AName = '' then
    raise EJSONException.Create('Unexpected Value['''']');
  LFor := NameIndex(AName);
  if LFor < 0 then
    AddNameValue(AName, AValue)
  else
    FValues[LFor] := String(AValue);
end;

function TJSONVariantData.ToJSON: String;
var
  LFor: Integer;
begin
  case FVKind of
    jvObject:
      if FVCount = 0 then
        Result := '{}'
      else
      begin
        Result := '{';
        for LFor := 0 to FVCount - 1 do
          Result := Result + TJSONCitel.StringToJSON(FNames[LFor]) + ':' +
            TJSONCitel.ValueToJSON(FValues[LFor]) + ',';
        Result[Length(Result)] := '}';
      end;
    jvArray:
      if FVCount = 0 then
        Result := '[]'
      else
      begin
        Result := '[';
        for LFor := 0 to FVCount - 1 do
          Result := Result + TJSONCitel.ValueToJSON(FValues[LFor]) + ',';
        Result[Length(Result)] := ']';
      end;
  else
    Result := 'null';
  end;
end;

function TJSONVariantData.ToJSONSimples: String;
var
  LFor: Integer;
begin
  case FVKind of
    jvObject:
      if FVCount = 0 then
        Result := '{}'
      else
      begin
        Result := '{';
        for LFor := 0 to FVCount - 1 do
          Result := Result + FNames[LFor] + ':' + FValues[LFor] + ',';
        Result[Length(Result)] := '}';
      end;
    jvArray:
      if FVCount = 0 then
        Result := '[]'
      else
      begin
        Result := '[';
        for LFor := 0 to FVCount - 1 do
          Result := Result + FValues[LFor] + ',';
        Result[Length(Result)] := ']';
      end;
  else
    Result := 'null';
  end;
end;

function TJSONVariantData.ToObject(AObject: TObject): Boolean;
var
  LFor: Integer;
  LItem: TCollectionItem;
  LListType: TRttiType;
  LObjectType: TObject;
  LField: TRttiField;
begin
  Result := False;
  if AObject = nil then
    Exit;
  case FVKind of
    jvObject:
      begin
        AObject.GetType(LListType);
        if LListType <> nil then
        begin
          for LFor := 0 to Count - 1 do
          begin
            LField := LListType.GetField('F' + FNames[LFor]);
            if LField <> nil then
            begin
              if VarCompareValue(FValues[LFor], Unassigned) = vrEqual then
                TJSONCitel.SetInstanceProp(AObject, LField,
                  GetValueArrayJson(FNames[LFor]))
              else
                TJSONCitel.SetInstanceProp(AObject, LField, FValues[LFor]);
            end;
          end;
        end;
      end;
    jvArray:
      if AObject.InheritsFrom(TCollection) then
      begin
        TCollection(AObject).Clear;
        for LFor := 0 to Count - 1 do
        begin
          LItem := TCollection(AObject).Add;
          if not TJSONCitel.JSONVariantData(FValues[LFor]).ToObject(LItem) then
            Exit;
        end;
      end
      else if AObject.InheritsFrom(TStrings) then
        try
          TStrings(AObject).BeginUpdate;
          TStrings(AObject).Clear;
          for LFor := 0 to Count - 1 do
            TStrings(AObject).Add(FValues[LFor]);
        finally
          TStrings(AObject).EndUpdate;
        end
      else if (Pos('TObjectList<', AObject.ClassName) > 0) or
        (Pos('TList<', AObject.ClassName) > 0) then
      begin
        AObject.GetType(LListType);
        LListType := GetListType(LListType);
        if LListType.IsInstance then
        begin
          for LFor := 0 to Count - 1 do
          begin
            LObjectType := LListType.AsInstance.MetaclassType.Create;
            LObjectType.MethodCall('Create', []);
            if not TJSONCitel.JSONVariantData(FValues[LFor])
              .ToObject(LObjectType) then
              Exit;
            AObject.MethodCall('Add', [LObjectType]);
          end;
        end;
      end
      else
        Exit;
  else
    Exit;
  end;
  Result := True;
end;

{ TJSONParser }

function TJSONParser.CheckNextIdent(const AExpectedIdent: string): Boolean;
begin
  Result := (GetNextNonWhiteChar = '"') and
    (CompareText(GetNextString, AExpectedIdent) = 0) and
    (GetNextNonWhiteChar = ':');
end;

function TJSONParser.CheckNextNonWhiteChar(AChar: Char): Boolean;
begin
  Result := False;
  if FIndex <= FJsonLength then
  begin
    repeat
      if FJson[FIndex] > ' ' then
      begin
        Result := FJson[FIndex] = AChar;
        if Result then
          Inc(FIndex);
        Exit;
      end;
      Inc(FIndex);
    until FIndex > FJsonLength;
  end;
end;

function TJSONParser.GetNextAlphaPropName(out AFieldName: string): Boolean;
var
  LFor: Integer;
begin
  Result := False;
  if (FIndex >= FJsonLength) or not(Ord(FJson[FIndex]) in [Ord('A') .. Ord('Z'),
    Ord('a') .. Ord('z'), Ord('_'), Ord('$')]) then
    Exit;
  for LFor := FIndex + 1 to FJsonLength do
    case Ord(FJson[LFor]) of
      Ord('0') .. Ord('9'), Ord('A') .. Ord('Z'), Ord('a') .. Ord('z'),
        Ord('_'):
        ; // allow MongoDB extended syntax, e.g. {age:{$gt:18}}
      Ord(':'), Ord('='):
        begin
          AFieldName := Copy(FJson, FIndex, LFor - FIndex);
          FIndex := LFor + 1;
          Result := True;
          Exit;
        end;
    else
      Exit;
    end;
end;

function TJSONParser.GetNextChar: Char;
begin
  Result := #0;
  if FIndex <= FJsonLength then
  begin
    Result := Char(FJson[FIndex]);
    Inc(FIndex);
  end;
end;

function TJSONParser.GetNextJSON(out AValue: Variant): TJSONParserKind;
var
  LStr: String;
  LInt64: Int64;
  LValue: Double;
  LStart, LErr: Integer;
begin
  Result := kNone;
  case GetNextNonWhiteChar of
    'n', 'N':
      if Copy(FJson, FIndex, 3).ToLower = 'ull' then
      begin
        Inc(FIndex, 3);
        Result := kNull;
        AValue := Null;
      end;
    'f', 'F':
      if Copy(FJson, FIndex, 4).ToLower = 'alse' then
      begin
        Inc(FIndex, 4);
        Result := kFalse;
        AValue := False;
      end;
    't', 'T':
      if Copy(FJson, FIndex, 3).ToLower = 'rue' then
      begin
        Inc(FIndex, 3);
        Result := kTrue;
        AValue := True;
      end;
    '"':
      if GetNextString(LStr) = True then
      begin
        Result := kString;
        AValue := LStr;
      end;
    '{':
      if ParseJSONObject(TJSONVariantData(AValue)) then
      begin
        Result := kObject;
      end;
    '[':
      if ParseJSONArray(TJSONVariantData(AValue)) then
      begin
        Result := kArray;
      end;
    '-', '0' .. '9':
      begin
        LStart := FIndex - 1;
        while True do
          case FJson[FIndex] of
            '-', '+', '0' .. '9', '.', 'E', 'e':
              Inc(FIndex);
          else
            Break;
          end;
        LStr := Copy(FJson, LStart, FIndex - LStart);
        Val(LStr, LInt64, LErr);
        if LErr = 0 then
        begin
          Result := kInteger;
          AValue := LInt64;
        end
        else
        begin
          Val(LStr, LValue, LErr);
          if LErr <> 0 then
            Exit;
          AValue := LValue;
          Result := kFloat;
        end;
      end;
  end;
end;

function TJSONParser.GetNextNonWhiteChar: Char;
begin
  Result := #0;
  if FIndex <= FJsonLength then
  begin
    repeat
      if FJson[FIndex] > ' ' then
      begin
        Result := Char(FJson[FIndex]);
        Inc(FIndex);
        Exit;
      end;
      Inc(FIndex);
    until FIndex > FJsonLength;
  end;
end;

function TJSONParser.GetNextString: String;
begin
  if not GetNextString(Result) then
    Result := '';
end;

function TJSONParser.GetNextString(out AStr: String): Boolean;
var
  LFor: Integer;
begin
  Result := False;
  for LFor := FIndex to FJsonLength do
  begin
    case FJson[LFor] of
      '"':
        begin // end of String without escape -> direct copy
          AStr := Copy(FJson, FIndex, LFor - FIndex);
          FIndex := LFor + 1;
          Result := True;
          Exit;
        end;
      '\':
        begin // need unescaping
          AStr := Copy(FJson, FIndex, LFor - FIndex);
          FIndex := LFor;
          GetNextStringUnEscape(AStr);
          Result := True;
          Exit;
        end;
    end;
  end;
end;

procedure TJSONParser.GetNextStringUnEscape(var AStr: string);
var
  LChar: Char;
  LCopy: String;
  LUnicode, LErr: Integer;
begin
  repeat
    LChar := GetNextChar;
    case LChar of
      #0:
        Exit;
      '"':
        Break;
      '\':
        begin
          LChar := GetNextChar;
          case LChar of
            #0:
              Exit;
            'b':
              TJSONCitel.AppendChar(AStr, #08);
            't':
              TJSONCitel.AppendChar(AStr, #09);
            'n':
              TJSONCitel.AppendChar(AStr, #$0a);
            'f':
              TJSONCitel.AppendChar(AStr, #$0c);
            'r':
              TJSONCitel.AppendChar(AStr, #$0d);
            'u':
              begin
                LCopy := Copy(FJson, FIndex, 4);
                if Length(LCopy) <> 4 then
                  Exit;
                Inc(FIndex, 4);
                Val('$' + LCopy, LUnicode, LErr);
                if LErr <> 0 then
                  Exit;
                TJSONCitel.AppendChar(AStr, Char(LUnicode));
              end;
          else
            TJSONCitel.AppendChar(AStr, LChar);
          end;
        end;
    else
      TJSONCitel.AppendChar(AStr, LChar);
    end;
  until False;
end;

procedure TJSONParser.Init(const AJson: String; AIndex: Integer);
begin
  FJson := AJson;
  FJsonLength := Length(FJson);
  FIndex := AIndex;
end;

function TJSONParser.ParseJSONArray(out AData: TJSONVariantData): Boolean;
var
  LItem: Variant;
begin
  Result := False;
  AData.Init;
  if not CheckNextNonWhiteChar(']') then
  begin
    repeat
      if GetNextJSON(LItem) = kNone then
        Exit;
      AData.AddValue(LItem);
      case GetNextNonWhiteChar of
        ',':
          Continue;
        ']':
          Break;
      else
        Exit;
      end;
    until False;
    SetLength(AData.FValues, AData.FVCount);
  end;
  AData.FVKind := jvArray;
  Result := True;
end;

function TJSONParser.ParseJSONObject(out AData: TJSONVariantData): Boolean;
var
  LKey: String;
  LItem: Variant;
begin
  Result := False;
  AData.Init;
  if not CheckNextNonWhiteChar('}') then
  begin
    repeat
      if CheckNextNonWhiteChar('"') then
      begin
        if (not GetNextString(LKey)) or (GetNextNonWhiteChar <> ':') then
          Exit;
      end
      else if not GetNextAlphaPropName(LKey) then
        Exit;
      if GetNextJSON(LItem) = kNone then
        Exit;
      AData.AddNameValue(LKey, LItem);
      case GetNextNonWhiteChar of
        ',':
          Continue;
        '}':
          Break;
      else
        Exit;
      end;
    until False;
    SetLength(AData.FNames, AData.FVCount);
  end;
  SetLength(AData.FValues, AData.FVCount);
  AData.FVKind := jvObject;
  Result := True;
end;

{ TObjectHelper }

function TObjectHelper.GetColumns: TArray<TRttiProperty>;
begin

end;

function TObjectHelper.GetType(out AType: TRttiType): Boolean;
begin
  Result := False;
  if Assigned(Self) then
  begin
    AType := Context.GetType(Self.ClassType);
    Result := Assigned(AType);
  end;
end;

function TObjectHelper.MethodCall(AMethodName: string;
  const AParameters: array of TValue): TValue;
var
  LRttiType: TRttiType;
  LMethod: TRttiMethod;
begin
  LRttiType := Context.GetType(Self.ClassType);
  LMethod := LRttiType.GetMethod(AMethodName);
  if Assigned(LMethod) then
    Result := LMethod.Invoke(Self, AParameters)
  else
    raise Exception.CreateFmt('Cannot find method "%s" in the object',
      [AMethodName]);
end;

{ TJSONVariant }

procedure TJSONVariant.Cast(var ADest: TVarData; const ASource: TVarData);
begin
  inherited;

end;

procedure TJSONVariant.CastTo(var ADest: TVarData; const ASource: TVarData;
  const AVarType: TVarType);
begin
  inherited;

end;

procedure TJSONVariant.Clear(var AVarData: TVarData);
begin
  AVarData.VType := varEmpty;
  Finalize(TJSONVariantData(AVarData).FNames);
  Finalize(TJSONVariantData(AVarData).FValues);
end;

procedure TJSONVariant.Copy(var ADest: TVarData; const ASource: TVarData;
  const AIndirect: Boolean);
begin
  inherited;

end;

{ TUtilSingleton }

constructor TUtilSingleton.Create;
begin

end;

constructor TUtilSingleton.CreatePrivate;
begin

end;

function TUtilSingleton.DateTimeToIso8601(AValue: TDateTime): string;
begin
  if AValue = 0 then
    Result := ''
  else if Frac(AValue) = 0 then
    Result := FormatDateTime('yyyy"-"mm"-"dd', AValue)
  else if Trunc(AValue) = 0 then
    Result := FormatDateTime('"T"hh":"nn":"ss', AValue)
  else
    Result := FormatDateTime('yyyy"-"mm"-"dd"T"hh":"nn":"ss', AValue);
end;

class function TUtilSingleton.GetInstance: IUtilSingleton;
begin
  if not Assigned(FInstance) then
    FInstance := TUtilSingleton.CreatePrivate;
  Result := FInstance;
end;

function TUtilSingleton.Iso8601ToDateTime(const AValue: string): TDateTime;
var
  Y, M, D, HH, MI, SS: Cardinal;
begin
  // YYYY-MM-DD   Thh:mm:ss  or  YYYY-MM-DDThh:mm:ss
  // 1234567890   123456789      1234567890123456789
  Result := 0;
  case Length(AValue) of
    9:
      if (AValue[1] = 'T') and (AValue[4] = ':') and (AValue[7] = ':') then
      begin
        HH := Ord(AValue[2]) * 10 + Ord(AValue[3]) - (48 + 480);
        MI := Ord(AValue[5]) * 10 + Ord(AValue[6]) - (48 + 480);
        SS := Ord(AValue[8]) * 10 + Ord(AValue[9]) - (48 + 480);
        if (HH < 24) and (MI < 60) and (SS < 60) then
          Result := EncodeTime(HH, MI, SS, 0);
      end;
    10:
      if (AValue[5] = AValue[8]) and (Ord(AValue[8]) in [Ord('-'), Ord('/')])
      then
      begin
        Y := Ord(AValue[1]) * 1000 + Ord(AValue[2]) * 100 + Ord(AValue[3]) * 10
          + Ord(AValue[4]) - (48 + 480 + 4800 + 48000);
        M := Ord(AValue[6]) * 10 + Ord(AValue[7]) - (48 + 480);
        D := Ord(AValue[9]) * 10 + Ord(AValue[10]) - (48 + 480);
        if (Y <= 9999) and ((M - 1) < 12) and ((D - 1) < 31) then
          Result := EncodeDate(Y, M, D);
      end;
    19, 24:
      if (AValue[5] = AValue[8]) and (Ord(AValue[8]) in [Ord('-'), Ord('/')])
        and (Ord(AValue[11]) in [Ord(' '), Ord('T')]) and (AValue[14] = ':') and
        (AValue[17] = ':') then
      begin
        Y := Ord(AValue[1]) * 1000 + Ord(AValue[2]) * 100 + Ord(AValue[3]) * 10
          + Ord(AValue[4]) - (48 + 480 + 4800 + 48000);
        M := Ord(AValue[6]) * 10 + Ord(AValue[7]) - (48 + 480);
        D := Ord(AValue[9]) * 10 + Ord(AValue[10]) - (48 + 480);
        HH := Ord(AValue[12]) * 10 + Ord(AValue[13]) - (48 + 480);
        MI := Ord(AValue[15]) * 10 + Ord(AValue[16]) - (48 + 480);
        SS := Ord(AValue[18]) * 10 + Ord(AValue[19]) - (48 + 480);
        if (Y <= 9999) and ((M - 1) < 12) and ((D - 1) < 31) and (HH < 24) and
          (MI < 60) and (SS < 60) then
          Result := EncodeDate(Y, M, D) + EncodeTime(HH, MI, SS, 0);
      end;
  end;
end;

function TUtilSingleton.ParseCommandNoSQL(const ASubStr, ASQL: string;
  ADefault: String): string;
var
  LFor: Integer;
  LPosI: Integer;
  LPosF: Integer;
begin
  Result := '';
  LPosI := Pos(ASubStr + '=', ASQL);
  try
    if LPosI > 0 then
    begin
      LPosI := LPosI + Length(ASubStr);
      for LFor := LPosI to Length(ASQL) do
      begin
        case ASQL[LFor] of
          '=':
            LPosI := LFor;
          ',':
            begin
              if (not MatchText(ASubStr, ['values', 'json'])) then
                Break;
            end;
        end;
        // if (ASQL[LFor] = '=') then
        // LPosI := LFor
        // else
        // if (ASQL[LFor] = ',') and
        // (not MatchText(ASubStr, ['values','json'])) then
        // Break;
      end;
      LPosF := LFor - LPosI;
      Result := Copy(ASQL, LPosI + 1, LPosF - 1);
    end;
  finally
    if (Result = '') and (ADefault <> '') then
      Result := ADefault
  end;
end;

{ TRttiPropertyHelper }

function TRttiPropertyHelper.IsBlob: Boolean;
const
  LPrefixString = 'TBlob';
var
  LTypeInfo: PTypeInfo;
begin
  LTypeInfo := Self.PropertyType.Handle;
  Result := Assigned(LTypeInfo) and (LTypeInfo.Kind = tkRecord) and
    StartsText(LPrefixString, GetTypeName(LTypeInfo));
end;

{ TJsonCitelConverter }

class procedure TJsonCitelConverter.ListOfObjectFromJson<T>(AList: TList<T>;
  AJson: string);
var
  LJsonArray: TJSONArray;
  LJsonObject: TJSONObject;
  LObject: T;
  LIndex: Integer;
begin
  AList.Clear;
  LJsonArray := TJSONObject.ParseJSONValue(AJson) as TJSONArray;
  for LIndex := 0 to LJsonArray.Count - 1 do
  begin
    LJsonObject := LJsonArray.Items[LIndex] as TJSONObject;
    LObject := TJSONCitel.JSONToObject<T>(LJsonObject.ToString);
    if Assigned(LObject) then
      AList.Add(LObject);
  end;
end;

class function TJsonCitelConverter.ListOfObjectToJson<T>
  (AList: TList<T>): String;
var
  LObject: T;
begin
  if AList.Count = 0 then
    Exit('[]');
  Result := '[';
  for LObject in AList do
    Result := Result + TJSONCitel.ObjectToJSON(LObject) + ',';
  Result[Length(Result)] := ']';
end;

initialization

JSONVariantType := TJSONVariant.Create;

end.
