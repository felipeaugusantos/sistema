unit PontoEntrada.Script.Classes;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, System.Rtti,
  Vcl.stdCtrls, fs_ipascal, fs_iinterpreter, fs_itools, Forms, Variants,
  PontoEntrada.Script.Interfaces;

type
  TMethodParams = array of TValue;

  TfsClassInfo = class(TInterfacedObject, IfsClassInfo)
  private
    FClassRef: TClass;
    FCategory: String;
    FMethods: TArray<string>;
    FProperties: TArray<string>;
  private
    function CallerToMethodParams(Caller: TfsMethodHelper): TMethodParams;
  public
    constructor Create(ACategory: String; AClass: TClass);
    function Category: String;
    function ClassRef: TClass;
    function ClassName: String;
    function Properties: TArray<String>;
    function Methods: TArray<String>;
    function Execute(Instance: TObject; const MethodName: String;
      Caller: TfsMethodHelper): Variant; virtual;
  end;

  TfsObjectInfo = class(TInterfacedObject, IfsObjectInfo)
  private
    FCategory: String;
    FName: String;
    FObjectRef: TObject;
  public
    constructor Create(ACategory, AName: String; AObject: TObject);
    function Category: String;
    function Name: String;
    function ObjectRef: TObject; overload;
    function ObjectRef(AValue: TObject): IfsObjectInfo; overload;
  end;

  TfsVariableInfo = class(TInterfacedObject, IfsVariableInfo)
  private
    FCategory: String;
    FName: String;
    FTyp: String;
    FValue: Variant;
  public
    constructor Create(ACategory, AName, AType: String; AValue: Variant);
    function Category: String;
    function Name: String;
    function Typ: String;
    function Value: Variant;
  end;

  TfsGlobalMethods = class
  private
    class function fCampoTabela(strCampo: String; strTabela: String;
      arrKeys, arrValues: Variant; blnSempreLerBanco: Boolean = True): Variant;
    class function CallMethod(Instance: TObject; ClassType: TClass;
      const MethodName: String; Caller: TfsMethodHelper): Variant;
  public
    class procedure RegisterMethods;
  end;

  TfsPascalScript = class(TComponent)
  private
    FScript: TfsScript;
    FPascal: TfsPascal;
    FParams: IfsPascalScriptParams;
  private
    function GetProp(Instance: TObject; ClassType: TClass;
      const PropName: String): Variant;
    procedure SetProp(Instance: TObject; ClassType: TClass;
      const PropName: String; Value: Variant);
    function CallMethod(Instance: TObject; ClassType: TClass;
      const MethodName: String; Caller: TfsMethodHelper): Variant;
    function GetOnRunLine: TfsRunLineEvent;
    procedure SetOnRunLine(const Value: TfsRunLineEvent);
    procedure LoadObjects;
    procedure AddGlobalVariables;
    function GetLines: TStrings;
    function GetErrorMsg: String;
    function GetErrorPos: String;
    procedure SetParams(const Value: IfsPascalScriptParams);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    procedure AddClass(AClassInfo: IfsClassInfo);
    procedure AddObject(AName: String; AObject: TObject);
    procedure Clear;
    function Compile: Boolean;
    procedure Execute;
    procedure Terminate;
    property OnRunLine: TfsRunLineEvent read GetOnRunLine write SetOnRunLine;
    property objScript: TfsScript read FScript;
    property Lines: TStrings read GetLines;
    property ErrorPos: String read GetErrorPos;
    property ErrorMsg: String read GetErrorMsg;
    property Params: IfsPascalScriptParams read FParams write SetParams;
  public
    class procedure RunScript(AParams: IfsPascalScriptParams);
    class function EditScript(AParams: IfsPascalScriptParams): Boolean;
  end;

  TfsForm = class; // Forms wrapper pattern Proxy

  TfsPascalScriptParams = class(TInterfacedObject, IfsPascalScriptParams)
  private
    FText: String;
    FWatch: String;
    FDescription: String;
    FClasses: TDictionary<String, IfsClassInfo>;
    FObjects: TDictionary<String, IfsObjectInfo>;
    FVariables: TDictionary<String, IfsVariableInfo>;
    FForms: TList<TfsForm>;
  private
    function AddForm(AForm: TForm): TfsForm;
    procedure LoadGlobalVariables;
  protected
    constructor Create;
  public
    destructor Destroy; override;
  public
    function Description(): String; overload;
    function Description(AValue: String): IfsPascalScriptParams; overload;
    function ScriptText(): String; overload;
    function ScriptText(AValue: String): IfsPascalScriptParams; overload;
    function WatchList(): String; overload;
    function WatchList(AValue: String): IfsPascalScriptParams; overload;
    function AddClass(AClass: IfsClassInfo): IfsPascalScriptParams;
    function AddObject(AObject: IfsObjectInfo): IfsPascalScriptParams;
    function AddVariable(AVariable: IfsVariableInfo): IfsPascalScriptParams;
    function Classes: TDictionary<String, IfsClassInfo>;
    function Objects: TDictionary<String, IfsObjectInfo>;
    function Variables: TDictionary<String, IfsVariableInfo>;
    class function New(): IfsPascalScriptParams;
  end;

  TfsRttiUtils = class sealed
  public
    class function HasField(AObject: TObject; AField: string): Boolean;
    class function GetField<T>(AObject: TObject; AField: string): T;overload;
    class procedure SetField<T>(AObject: TObject; AField: string; AValue: T);overload;
    class function GetField(AObject: TObject; AField: string): Variant; overload;
    class procedure SetField(AObject: TObject; AField: string; AValue: Variant);overload;
    class function HasProp(AObject: TObject; APropName: string): Boolean;
    class function GetProp<T>(AObject: TObject; APropName: string): T;
    class procedure SetProp<T>(AObject: TObject; APropName: string; AValue: T);
    class function GetClassMethods(AClass: TClass): TArray<String>;
    class function GetClassProperties(AClass: TClass): TArray<String>;
    class function ExecuteMethod(AObject: TObject; MethodName: string;
      MethosParams: TMethodParams): TValue;
  end;

  // Edit wrapper pattern Proxy
  TfsEdit = class
  private
    FEdit: TEdit;
    function GetText: String;
    procedure SetText(const Value: String);
  public
    constructor Create(AEdit: TEdit);
    procedure SetFocus;
    property Text: String read GetText write SetText;
  end;

  // Memo wrapper pattern Proxy
  TfsMemo = class
  private
    FMemo: TMemo;
    function GetText: String;
    procedure SetText(const Value: String);
    function GetLines: TStrings;
  public
    constructor Create(AMemo: TMemo);
    procedure SetFocus;
    property Text: String read GetText write SetText;
    property Lines: TStrings read GetLines;
  end;

  // Button wrapper pattern Proxy
  TfsButton = class
  private
    FButton: TButton;
  public
    constructor Create(AButton: TButton);
    procedure Click;
    procedure SetFocus;
  end;

  // Forms wrapper pattern Proxy
  TfsForm = class(TComponent)
  private
    FForm: TForm;
    FObjects: TDictionary<String, TObject>;
    class var FDicVar: TDictionary<String, Variant>;
  private
    function GetFormClass: String;
    function GetCaption: String;
    function FindObject(AName: string): TObject;
  public
    constructor Create(AForm: TForm); reintroduce;
    destructor Destroy; override;
  public
    //Form components
    function Edit(AName: String): TfsEdit;
    function Memo(AName: String): TfsMemo;
    function Button(AName: string): TfsButton;
  public
    //Variables Dictionary
    function HasVar(AName: String): Boolean;
    function GetVar(AName: String): Variant;
    procedure SetVar(AName: String; AValue: Variant);
  public
    property FormClass: String read GetFormClass;
    property Caption: String read GetCaption;
  end;

implementation

uses
  PontoEntrada.Script.Editor, Vcl.Controls, untFuncoesSimples;

class procedure TfsPascalScript.RunScript(AParams: IfsPascalScriptParams);
var
  LScript: TfsPascalScript;
begin
  LScript := TfsPascalScript.Create(nil);
  try
    LScript.Params := AParams;
    if not LScript.Compile then
      raise Exception.Create(LScript.ErrorMsg + ' na posição ' + LScript.ErrorPos);
    LScript.Execute;
  finally
    LScript.Free;
  end;
end;

class function TfsPascalScript.EditScript(AParams: IfsPascalScriptParams): Boolean;
var
  LScript: TfsPascalScript;
  LEditor: TfrmScriptEditor;
begin
  LScript := TfsPascalScript.Create(nil);
  try
    LScript.Params := AParams;
    LEditor := TfrmScriptEditor.Create(nil);
    try
      LEditor.Script := LScript;
      Result := LEditor.ShowModal = mrOk;
    finally
      FreeAndNil(LEditor);
    end;
  finally
    LScript.Free;
  end;
end;

{ TfsPascalScript }

constructor TfsPascalScript.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FScript := TfsScript.Create(Self);
  FScript.Parent := fsGlobalUnit;
  FScript.SyntaxType := 'PascalScript';
  FPascal := TfsPascal.Create(Self);
end;

procedure TfsPascalScript.AddClass(AClassInfo: IfsClassInfo);
Var
  LValue: String;
  LPropName: String;
  LPropType: String;
  LClass: TfsClassVariable;
begin
  LClass := FScript.AddClass(AClassInfo.ClassRef,
    AClassInfo.ClassRef.ClassParent.ClassName);
  for LValue in AClassInfo.Methods do
    if LValue.ToLower.StartsWith('constructor') then
      LClass.AddConstructor(LValue, Self.CallMethod)
    else
      LClass.AddMethod(LValue, Self.CallMethod);
  for LValue in AClassInfo.Properties do
  begin
    LPropName := LValue.Split([':'])[0].Replace('property', '').Trim;
    LPropType := LValue.Split([':'])[1].Trim;
    LClass.AddProperty(LPropName, LPropType, Self.GetProp, Self.SetProp);
  end;
end;

destructor TfsPascalScript.Destroy;
begin
  inherited;
end;

procedure TfsPascalScript.Execute;
begin
  FScript.Execute;
end;

function TfsPascalScript.GetErrorMsg: String;
begin
  Result := FScript.ErrorMsg;
end;

function TfsPascalScript.GetErrorPos: String;
begin
  Result := FScript.ErrorPos;
end;

function TfsPascalScript.GetLines: TStrings;
begin
  Result := FScript.Lines;
end;

function TfsPascalScript.GetOnRunLine: TfsRunLineEvent;
begin
  Result := Self.FScript.OnRunLine;
end;

function TfsPascalScript.GetProp(Instance: TObject; ClassType: TClass;
  const PropName: String): Variant;
begin
  if FParams.Classes.ContainsKey(ClassType.ClassName) and Assigned(Instance)
  then
    Result := TfsRttiUtils.GetProp<Variant>(Instance, PropName);
end;

procedure TfsPascalScript.AddGlobalVariables;
var
  LVar: IfsVariableInfo;
begin
  for LVar in FParams.Variables.Values do
    FScript.AddVariable(LVar.Name, LVar.Typ, LVar.Value);
end;

procedure TfsPascalScript.AddObject(AName: String; AObject: TObject);
begin
  FScript.AddObject(AName, AObject);
end;

procedure TfsPascalScript.LoadObjects;
Var
  LKey: String;
begin
  AddGlobalVariables;
  for LKey in FParams.Classes.Keys do
    AddClass(FParams.Classes[LKey]);
  for LKey in FParams.Objects.Keys do
    AddObject(LKey, FParams.Objects[LKey].ObjectRef);
end;

procedure TfsPascalScript.SetOnRunLine(const Value: TfsRunLineEvent);
begin
  Self.FScript.OnRunLine := Value;
end;

procedure TfsPascalScript.SetParams(const Value: IfsPascalScriptParams);
begin
  FParams := Value;
  Self.Lines.Text := FParams.ScriptText;
  LoadObjects;
end;

procedure TfsPascalScript.SetProp(Instance: TObject; ClassType: TClass;
  const PropName: String; Value: Variant);
begin
  if FParams.Classes.ContainsKey(ClassType.ClassName) and Assigned(Instance)
  then
    TfsRttiUtils.SetProp(Instance, PropName, Value);
end;

procedure TfsPascalScript.Terminate;
begin
  FScript.Terminate;
end;

function TfsPascalScript.CallMethod(Instance: TObject; ClassType: TClass;
  const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  Result := Null;
  if FParams.Classes.ContainsKey(ClassType.ClassName) then
    Result := FParams.Classes[ClassType.ClassName].Execute(Instance,
      MethodName, Caller);
end;

procedure TfsPascalScript.Clear;
begin
  FScript.Clear;
  LoadObjects;
end;

function TfsPascalScript.Compile: Boolean;
begin
  Self.Clear;
  Result := FScript.Compile;
end;

{ TfsPascalScriptParams }

function TfsPascalScriptParams.AddClass(AClass: IfsClassInfo)
  : IfsPascalScriptParams;
begin
  Result := Self;
  FClasses.AddOrSetValue(AClass.ClassRef.ClassName, AClass);
end;

function TfsPascalScriptParams.AddForm(AForm: TForm): TfsForm;
begin
  Result := TfsForm.Create(AForm);
  if not FClasses.ContainsKey(TfsForm.ClassName) then
    Self.AddClass(TfsClassInfo.Create('Formulários', TfsForm));
  if not FClasses.ContainsKey(TfsEdit.ClassName) then
    Self.AddClass(TfsClassInfo.Create('Formulários', TfsEdit));
  if not FClasses.ContainsKey(TfsMemo.ClassName) then
    Self.AddClass(TfsClassInfo.Create('Formulários', TfsMemo));
  if not FClasses.ContainsKey(TfsButton.ClassName) then
    Self.AddClass(TfsClassInfo.Create('Formulários', TfsButton));
  FForms.Add(Result);
end;

function TfsPascalScriptParams.AddObject(AObject: IfsObjectInfo)
  : IfsPascalScriptParams;
begin
  Result := Self;
  if AObject.ObjectRef is TForm then
    AObject.ObjectRef(AddForm(TForm(AObject.ObjectRef)));
  FObjects.AddOrSetValue(AObject.Name, AObject);
end;

function TfsPascalScriptParams.Classes: TDictionary<String, IfsClassInfo>;
begin
  Result := Self.FClasses;
end;

constructor TfsPascalScriptParams.Create;
begin
  inherited;
  FClasses := TDictionary<String, IfsClassInfo>.Create();
  FObjects := TDictionary<String, IfsObjectInfo>.Create();
  FVariables := TDictionary<String, IfsVariableInfo>.Create();
  FForms := TList<TfsForm>.Create();
  LoadGlobalVariables;
end;

function TfsPascalScriptParams.Description: String;
begin
  Result := FDescription;
end;

function TfsPascalScriptParams.Description(
  AValue: String): IfsPascalScriptParams;
begin
  Result := Self;
  FDescription := AValue;
end;

destructor TfsPascalScriptParams.Destroy;
begin
  FreeAndNil(FClasses);
  FreeAndNil(FObjects);
  FreeAndNil(FForms);
  FreeAndNil(FVariables);
  inherited;
end;

function TfsPascalScriptParams.AddVariable(AVariable: IfsVariableInfo)
  : IfsPascalScriptParams;
begin
  Result := Self;
  FVariables.AddOrSetValue(AVariable.Name, AVariable);
end;

procedure TfsPascalScriptParams.LoadGlobalVariables;
begin
  AddVariable(TfsVariableInfo.Create('Aplicação', 'strLoginUsuarioLogado',
    'String', strLoginUsuarioLogado));
  AddVariable(TfsVariableInfo.Create('Aplicação', 'VS_strCodEmp', 'String',
    VS_strCodEmp));
  AddVariable(TfsVariableInfo.Create('Aplicação', 'VS_Date', 'TDate', VS_Date));
end;

class function TfsPascalScriptParams.New: IfsPascalScriptParams;
begin
  Result := Self.Create;
end;

function TfsPascalScriptParams.Objects: TDictionary<String, IfsObjectInfo>;
begin
  Result := Self.FObjects;
end;

function TfsPascalScriptParams.ScriptText(AValue: String)
  : IfsPascalScriptParams;
begin
  Result := Self;
  FText := AValue;
end;

function TfsPascalScriptParams.Variables: TDictionary<String, IfsVariableInfo>;
begin
  Result := Self.FVariables;
end;

function TfsPascalScriptParams.WatchList: String;
begin
  Result := FWatch;
end;

function TfsPascalScriptParams.WatchList(AValue: String): IfsPascalScriptParams;
begin
  Result := Self;
  FWatch := AValue;
end;

function TfsPascalScriptParams.ScriptText: String;
begin
  Result := FText;
end;

{ TfsForm }

function TfsForm.Button(AName: string): TfsButton;
var
  LObject: TObject;
begin
  Result := nil;
  LObject := Self.FindObject(AName);
  if Assigned(LObject) and (LObject is TButton) then
    Result := TfsButton.Create(TButton(LObject));
end;

constructor TfsForm.Create(AForm: TForm);
begin
  inherited Create(AForm);
  FForm := AForm;
  FObjects := TDictionary<String, TObject>.Create;
  if not assigned(FDicVar) then
    FDicVar := TDictionary<String, Variant>.Create;
end;

destructor TfsForm.Destroy;
begin
  FreeAndNil(FObjects);
  inherited;
end;

function TfsForm.Edit(AName: String): TfsEdit;
var
  LObject: TObject;
begin
  Result := nil;
  LObject := Self.FindObject(AName);
  if Assigned(LObject) and (LObject is TEdit) then
    Result := TfsEdit.Create(TEdit(LObject));
end;

function TfsForm.FindObject(AName: string): TObject;
var
  LObject: TComponent;
begin
  if FObjects.ContainsKey(AName) then
    Exit(FObjects[AName]);
  LObject := FForm.FindComponent(AName);
  if not Assigned(LObject) then
    Exit(nil);
  Result := LObject;
  FObjects.Add(AName, Result);
end;

function TfsForm.GetCaption: String;
begin
  Result := FForm.Caption;
end;

function TfsForm.GetFormClass: String;
begin
  Result := FForm.ClassName;
end;

function TfsForm.GetVar(AName: String): Variant;
var
  LKey: String;
begin
  Result := Null;
  if TfsRttiUtils.HasField(FForm, AName) then
  begin
    Result := TfsRttiUtils.GetField(FForm, AName);
    Exit;
  end;
  LKey := FForm.ClassName + FForm.GetHashCode.ToString + AName.ToUpper;
  if FDicVar.ContainsKey(LKey) then
    Result := FDicVar[LKey];
end;

function TfsForm.HasVar(AName: String): Boolean;
begin
  Result := TfsRttiUtils.HasField(FForm, AName);
end;

{ TfsEdit }

constructor TfsEdit.Create(AEdit: TEdit);
begin
  FEdit := AEdit;
end;

function TfsEdit.GetText: String;
begin
  Result := FEdit.Text;
end;

procedure TfsEdit.SetFocus;
begin
  pSetFocus(FEdit);
end;

procedure TfsEdit.SetText(const Value: String);
begin
  FEdit.Text := Value;
end;

{ TfsObjectInfo }

function TfsObjectInfo.Category: String;
begin
  Result := FCategory;
end;

constructor TfsObjectInfo.Create(ACategory, AName: String; AObject: TObject);
begin
  FCategory := ACategory;
  FName := AName;
  FObjectRef := AObject;
end;

function TfsObjectInfo.Name: String;
begin
  Result := FName;
end;

function TfsObjectInfo.ObjectRef(AValue: TObject): IfsObjectInfo;
begin
  Result := Self;
  FObjectRef := AValue;
end;

function TfsObjectInfo.ObjectRef: TObject;
begin
  Result := FObjectRef;
end;

{ TfsVariableInfo }

function TfsVariableInfo.Category: String;
begin
  Result := FCategory;
end;

constructor TfsVariableInfo.Create(ACategory, AName, AType: String;
  AValue: Variant);
begin
  FCategory := ACategory;
  FName := AName;
  FTyp := AType;
  FValue := AValue;
end;

function TfsVariableInfo.Name: String;
begin
  Result := FName;
end;

function TfsVariableInfo.Typ: String;
begin
  Result := FTyp;
end;

function TfsVariableInfo.Value: Variant;
begin
  Result := FValue;
end;

{ TfsClassInfo }

function TfsClassInfo.CallerToMethodParams(Caller: TfsMethodHelper): TMethodParams;
var
  LIndex: Integer;
  LParams: TMethodParams;
  LValue: TValue;
begin
  SetLength(LParams, Caller.Count);
  for LIndex := 0 to Caller.Count - 1 do
  begin
    LValue := TValue.FromVariant(Caller.Params[LIndex]);
    LParams[LIndex] := LValue;
  end;
  Result := LParams;
end;

function TfsClassInfo.Category: String;
begin
  Result := FCategory;
end;

function TfsClassInfo.ClassName: String;
begin
  Result := FClassRef.ClassName;
end;

function TfsClassInfo.ClassRef: TClass;
begin
  Result := FClassRef;
end;

constructor TfsClassInfo.Create(ACategory: String; AClass: TClass);
begin
  FClassRef := AClass;
  FCategory := ACategory;
  FMethods := TfsRttiUtils.GetClassMethods(AClass);
  FProperties := TfsRttiUtils.GetClassProperties(AClass);
end;

function TfsClassInfo.Execute(Instance: TObject; const MethodName: String; Caller: TfsMethodHelper): Variant;
var
  LResult: TValue;
begin
  Result := Null;
  LResult := TfsRttiUtils.ExecuteMethod(Instance, MethodName, CallerToMethodParams(Caller));
  if not LResult.IsEmpty then
    Result := LResult.AsVariant;
end;

function TfsClassInfo.Methods: TArray<String>;
begin
  Result := FMethods;
end;

function TfsClassInfo.Properties: TArray<String>;
begin
  Result := FProperties;
end;

{ TfsRttiUtils }

class function TfsRttiUtils.GetProp<T>(AObject: TObject; APropName: string): T;
var
  LContext: TRttiContext;
  LType: TRttiType;
  LProp: TRttiProperty;
begin
  LContext := TRttiContext.Create;
  Try
    LType := LContext.GetType(AObject.ClassInfo);
    If Assigned(LType) Then
    Begin
      LProp := LType.GetProperty(APropName);
      If Assigned(LProp) Then
        Result := LProp.GetValue(AObject).AsType<T>;
    End;
  Finally
    LContext.Free;
  End;
end;

class function TfsRttiUtils.HasField(AObject: TObject;
  AField: string): Boolean;
var
  LContext: TRttiContext;
  LType: TRttiType;
begin
  LContext := TRttiContext.Create;
  Try
    LType := LContext.GetType(AObject.ClassInfo);
    Result := Assigned(LType) and Assigned(LType.GetField(AField));
  Finally
    LContext.Free;
  End;
end;

class function TfsRttiUtils.HasProp(AObject: TObject;
  APropName: string): Boolean;
var
  LContext: TRttiContext;
  LType: TRttiType;
begin
  LContext := TRttiContext.Create;
  Try
    LType := LContext.GetType(AObject.ClassInfo);
    Result := Assigned(LType) And Assigned(LType.GetProperty(APropName));
  Finally
    LContext.Free;
  End;
end;

class function TfsRttiUtils.ExecuteMethod(AObject: TObject; MethodName: string;
  MethosParams: TMethodParams): TValue;
var
  LContext: TRttiContext;
  LType: TRttiType;
  LMethod: TRttiMethod;
begin
  Result := nil;
  LContext := TRttiContext.Create;
  Try
    LType := LContext.GetType(AObject.ClassInfo);
    If Assigned(LType) Then
    Begin
      LMethod := LType.GetMethod(MethodName);
      If Assigned(LMethod) Then
        Result := LMethod.Invoke(AObject, MethosParams);
    End;
  Finally
    LContext.Free;
  End;
end;

class function TfsRttiUtils.GetClassMethods(AClass: TClass): TArray<String>;
var
  LContext: TRttiContext;
  LType: TRttiType;
  LMethod: TRttiMethod;
  LMethodText: String;
begin
  LContext := TRttiContext.Create;
  try
    LType := LContext.GetType(AClass.ClassInfo);
    SetLength(Result, 0);
    if not Assigned(LType) then
      Exit;
    for LMethod in LType.GetMethods do
      try
        if (LMethod.Parent.ClassInfo = nil) or (LMethod.Parent.Name = '') or
          (LMethod.Parent.Name = AClass.ClassName) then
        begin
          LMethodText := LMethod.ToString;
          if LMethodText.Trim.ToLower.Contains('constructor') then
            LMethodText := LMethodText.Replace('class ', '').Trim;
          if LMethodText.Trim.ToLower.Contains('destructor') then
            LMethodText := LMethodText.Replace('class ', '').Trim;
          SetLength(Result, Length(Result) + 1);
          Result[Length(Result) - 1] := LMethodText;
        end;
      except
        on E: Exception do
          Raise Exception.Create(Format('%s - %s - %s - %s',[AClass.Classname,
            LMethod.Name, LMethod.ToString, E.Message]));
      end;
  finally
    LContext.Free;
  end;
end;

class function TfsRttiUtils.GetClassProperties(AClass: TClass): TArray<String>;
var
  LContext: TRttiContext;
  LType: TRttiType;
  LProp: TRttiProperty;
begin
  LContext := TRttiContext.Create;
  Try
    LType := LContext.GetType(AClass.ClassInfo);
    SetLength(Result, 0);
    If Assigned(LType) Then
      for LProp in LType.GetProperties do
        if (LProp.Parent.ClassInfo = nil) or (LProp.Parent.Name = '') or
          (LProp.Parent.Name = AClass.ClassName) then
        begin
          SetLength(Result, Length(Result) + 1);
          Result[Length(Result) - 1] := LProp.ToString;
        end;
  Finally
    LContext.Free;
  End;
end;

class function TfsRttiUtils.GetField(AObject: TObject; AField: string): Variant;
begin
  Result := GetField<Variant>(AObject, AField);
end;

class function TfsRttiUtils.GetField<T>(AObject: TObject; AField: string): T;
var
  LContext: TRttiContext;
  LType: TRttiType;
  LField: TRttiField;
begin
  LContext := TRttiContext.Create;
  Try
    LType := LContext.GetType(AObject.ClassInfo);
    If Assigned(LType) Then
    Begin
      LField := LType.GetField(AField);
      If Assigned(LField) Then
        Result := LField.GetValue(AObject).AsType<T>;
    End;
  Finally
    LContext.Free;
  End;
end;

class procedure TfsRttiUtils.SetField(AObject: TObject; AField: string;
  AValue: Variant);
begin
  SetField<Variant>(AObject, AField, AValue);
end;

class procedure TfsRttiUtils.SetField<T>(AObject: TObject; AField: string;
  AValue: T);
var
  LContext: TRttiContext;
  LType: TRttiType;
  LField: TRttiField;
begin
  LContext := TRttiContext.Create;
  Try
    LType := LContext.GetType(AObject.ClassInfo);
    If Assigned(LType) Then
    Begin
      LField := LType.GetField(AField);
      If Assigned(LField) Then
        LField.SetValue(AObject, TValue.From<T>(AValue));
    End;
  Finally
    LContext.Free;
  End;
end;

class procedure TfsRttiUtils.SetProp<T>(AObject: TObject; APropName: string;
  AValue: T);
var
  LContext: TRttiContext;
  LType: TRttiType;
  LProp: TRttiProperty;
begin
  LContext := TRttiContext.Create;
  Try
    LType := LContext.GetType(AObject.ClassInfo);
    If Assigned(LType) Then
    Begin
      LProp := LType.GetProperty(APropName);
      If Assigned(LProp) Then
        LProp.SetValue(AObject, TValue.From<T>(AValue));
    End;
  Finally
    LContext.Free;
  End;
end;

{ TfsMemo }

constructor TfsMemo.Create(AMemo: TMemo);
begin
  FMemo := AMemo;
end;

function TfsMemo.GetLines: TStrings;
begin
  Result := FMemo.Lines;
end;

function TfsMemo.GetText: String;
begin
  Result := FMemo.Text;
end;

procedure TfsMemo.SetFocus;
begin
  pSetFocus(FMemo);
end;

procedure TfsMemo.SetText(const Value: String);
begin
  FMemo.Text := Value;
end;

function TfsForm.Memo(AName: String): TfsMemo;
var
  LObject: TObject;
begin
  Result := nil;
  LObject := Self.FindObject(AName);
  if Assigned(LObject) and (LObject is TMemo) then
    Result := TfsMemo.Create(TMemo(LObject));
end;

procedure TfsForm.SetVar(AName: String; AValue: Variant);
var
  LKey: String;
begin
  if TfsRttiUtils.HasField(FForm, AName) then
  begin
    TfsRttiUtils.SetField(FForm, AName, AValue);
    Exit;
  end;
  LKey := FForm.ClassName + FForm.GetHashCode.ToString + AName.ToUpper;
  FDicVar.AddOrSetValue(LKey, AValue);
end;

{ TfsButton }

procedure TfsButton.Click;
begin
  FButton.Click;
end;

constructor TfsButton.Create(AButton: TButton);
begin
  FButton := AButton;
end;

procedure TfsButton.SetFocus;
begin
  pSetFocus(FButton);
end;

{ TfsGlobalMethods }

class function TfsGlobalMethods.CallMethod(Instance: TObject; ClassType: TClass;
  const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  if SameText(MethodName, 'fCurrentDate') then
    Result := fCurrentDate
  else if SameText(MethodName, 'fCurrentTime') then
    Result := fCurrentTime
  else if SameText(MethodName, 'fCurrentDateTime') then
    Result := fCurrentDateTime
  else if SameText(MethodName, 'fNow') then
    Result := fNow
  else if SameText(MethodName, 'fIsNumber') then
    Result := fIsNumber(Caller.Params[0])
  else if SameText(MethodName, 'fEmptyStr') then
    Result := fEmptyStr(Caller.Params[0], Caller.Params[1])
  else if SameText(MethodName, 'fPadL') then
    Result := fPadL(Caller.Params[0], Caller.Params[1], Caller.Params[2])
  else if SameText(MethodName, 'fPadR') then
    Result := fPadR(Caller.Params[0], Caller.Params[1], String(Caller.Params[2]))
  else if SameText(MethodName, 'fPadC') then
    Result := fPadC(Caller.Params[0], Caller.Params[1], Caller.Params[2])
  else if SameText(MethodName, 'pMensagemOk') then
    pMensagemOk(Caller.Params[0])
  else if SameText(MethodName, 'fPergunta') then
    Result := fPergunta(Caller.Params[0])
  else if SameText(MethodName, 'fCampoTabela') then
    Result := Self.fCampoTabela(Caller.Params[0], Caller.Params[1], Caller.Params[2],
      Caller.Params[3], Caller.Params[4]);
end;

class function TfsGlobalMethods.fCampoTabela(strCampo, strTabela: String;
  arrKeys, arrValues: Variant; blnSempreLerBanco: Boolean): Variant;
var
  arrCampoChave: Array Of String;
  arrValorChave: Array Of Variant;
begin
  arrCampoChave := arrKeys;
  arrValorChave := arrValues;
  Result := untFuncoesSimples.fCampoTabela(strCampo, strTabela, arrCampoChave, arrValorChave, blnSempreLerBanco);
end;

class procedure TfsGlobalMethods.RegisterMethods;
begin
  //ctDate methods
  fsGlobalUnit.AddMethod('function fCurrentTime: String;', CallMethod, 'ctDate');
  fsGlobalUnit.AddMethod('function fCurrentDate: String;', CallMethod, 'ctDate');
  fsGlobalUnit.AddMethod('function fCurrentDateTime: String;', CallMethod, 'ctDate');
  fsGlobalUnit.AddMethod('function fNow: TDateTime;', CallMethod, 'ctDate');

  //ctString methods
  fsGlobalUnit.AddMethod('function fIsNumber(Const strNumber: String): Boolean;', CallMethod, 'ctString');
  fsGlobalUnit.AddMethod('function fEmptyStr(strString : String; blnTiraCaracEspecial: Boolean = False): Boolean;', CallMethod, 'ctString');
  fsGlobalUnit.AddMethod('function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = '' ''): String;', CallMethod, 'ctString');
  fsGlobalUnit.AddMethod('function fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = '' ''): String;', CallMethod, 'ctString');
  fsGlobalUnit.AddMethod('function fPadC(strTexto: String; intTamanho: Integer; strCaracter: String = '' ''): String;', CallMethod, 'ctString');

  //ctOther methods
  fsGlobalUnit.AddMethod('procedure pMensagemOk(strMensagem: string);', CallMethod, 'ctOther');
  fsGlobalUnit.AddMethod('function fPergunta(strMensagem: String): Boolean;', CallMethod, 'ctOther');
  fsGlobalUnit.AddMethod('function fCampoTabela(strCampo: String; strTabela: String; arrKeys, arrValues: Array; blnSempreLerBanco: Boolean = True): Variant;', CallMethod, 'ctOther');
end;

initialization
  TfsGlobalMethods.RegisterMethods;

end.
