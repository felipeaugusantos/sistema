unit PontoEntrada.FormEvent.Classes;

interface

uses System.Classes, System.SysUtils, Vcl.Forms, System.Generics.Collections,
  Vcl.StdCtrls, PontoEntrada.Script.Interfaces, Vcl.Dialogs, Data.DB;

type
  TFormEntryPointAction = class
  private
    FId: String;
    FExecuteIndex: Integer;
    FDescription: String;
    FEnabled: Boolean;
    FScript: String;
    FWatchList: String;
  private
    procedure UpdateScript(ADescription, AScript, AWatchList: String);
    procedure UpdateEnabled(AValue: Boolean);
    procedure UpdateExecuteIndex(const AValue: Integer);
    procedure DeleteScript;
  public
    property Id: String read FId;
    property ExecuteIndex: Integer read FExecuteIndex;
    property Description: String read FDescription;
    property Enabled: Boolean read FEnabled;
    property Script: String read FScript;
    property WatchList: String read FWatchList;
  end;

  TFormEntryPointManager = class;

  TFormEntryPoint = class
  private
    FEvent: String;
    FManager: TFormEntryPointManager;
    FActions: TDictionary<String, TFormEntryPointAction>;
  private
    procedure ExecuteActions;
  public
    constructor Create(AManager: TFormEntryPointManager; AEvent: String);
    destructor Destroy; override;
    property Event: String read FEvent;
    property Actions: TDictionary<String, TFormEntryPointAction> read FActions;
    property Manager: TFormEntryPointManager read FManager;
  end;

  TFormEntryPointDict = TDictionary<String,TFormEntryPoint>;

  TFormEntryPointControl = class
  private
    FControlName: String;
    FControlType: String;
    FEntryPoints: TFormEntryPointDict;
  public
    constructor Create(AName, AType: String);
    destructor Destroy; override;
    property ControlName: String read FControlName;
    property ControlType: String read FControlType;
    property EntryPoints: TFormEntryPointDict read FEntryPoints;
  end;

  TFormEntryPointManager = class(TComponent)
  private
    FForm: TForm;
    FClasses: TDictionary<String, IfsClassInfo>;
    FObjects: TDictionary<String, IfsObjectInfo>;
    FVariables: TDictionary<String, IfsVariableInfo>;
    FSelectedControls: TDictionary<String,TFormEntryPointControl>;
    FAvailableControls: TDictionary<String,TFormEntryPointControl>;
    FCheckUserPermission: Boolean;
  private
    procedure LinkFormEvents;
    procedure LinkEditEvents;
    procedure LinkButtonEvents;
    procedure LoadSelectedEntryPoints;
    procedure LoadAvailableEntryPoints;
    function GetFormName: string;
    function CheckUserPermission: Boolean;
  public
    constructor Create(AForm: TForm); reintroduce;
    destructor Destroy; override;
    procedure AddClass(AClass: IfsClassInfo);
    procedure AddObject(AObject: IfsObjectInfo);
    procedure AddVariable(AVariable: IfsVariableInfo);
    function AddActionScript(AControl: TFormEntryPointControl; AEvent: String): Boolean;
    function EditActionScript(Action: TFormEntryPointAction): Boolean;
    procedure ExecuteActionScript(Action: TFormEntryPointAction);
    function DeleteActionScript(AEntry: TFormEntryPoint; Action: TFormEntryPointAction): Boolean;
    procedure EnableAction(Action: TFormEntryPointAction);
    procedure DisableAction(Action: TFormEntryPointAction);
    function UpdateExecuteIndex(Action: TFormEntryPointAction; AIndex: Integer): Boolean;
    property FormInstance: TForm read FForm;
    property FormName: string read GetFormName;
    property SelectedControls: TDictionary<String, TFormEntryPointControl> read FSelectedControls;
    property AvailableControls: TDictionary<String, TFormEntryPointControl> read FAvailableControls;
  end;

implementation

uses
  untFuncoesSimples, Uni, PontoEntrada.Script.Classes, untConstantes;

type
  TLinkFormEvent = class(TComponent)
  private
    FForm: TForm;
    FEntry: TFormEntryPoint;
    FCloseEvent: TCloseEvent;
    FNotifyEvent: TNotifyEvent;
  protected
    procedure OnNotifyEvent(Sender: TObject);
    procedure OnCloseEvent(Sender: TObject; var Action: TCloseAction);
  public
    constructor New(AForm: TForm; AEntry: TFormEntryPoint);
  end;

  TLinkButtonEvent = class(TComponent)
  private
    FButton: TButton;
    FEntry: TFormEntryPoint;
    FNotifyEvent: TNotifyEvent;
  protected
    procedure OnNotifyEvent(Sender: TObject);
  public
    constructor New(AButton: TButton; AEntry: TFormEntryPoint);
  end;

  TLinkEditEvent = class(TComponent)
  private
    FEdit: TEdit;
    FEntry: TFormEntryPoint;
    FNotifyEvent: TNotifyEvent;
  protected
    procedure OnNotifyEvent(Sender: TObject);
  public
    constructor New(AEdit: TEdit; AEntry: TFormEntryPoint);
  end;

{ TFormEntryPoint }

procedure TFormEntryPointManager.LinkButtonEvents;
var
  I: Integer;
  LComponent: TComponent;
  LEntryPoint: TFormEntryPoint;
begin
  for I := 0 to FForm.ComponentCount -1 do
  begin
    LComponent := FForm.Components[I];
    if not (LComponent is TButton) then
      Continue;
    if not FSelectedControls.ContainsKey(LComponent.Name) then
      Continue;
    for LEntryPoint in FSelectedControls[LComponent.Name].FEntryPoints.Values do
      TLinkButtonEvent.New(TButton(LComponent), LEntryPoint);
  end;
end;

procedure TFormEntryPointManager.LinkEditEvents;
var
  I: Integer;
  LComponent: TComponent;
  LEntryPoint: TFormEntryPoint;
begin
  for I := 0 to FForm.ComponentCount -1 do
  begin
    LComponent := FForm.Components[I];
    if not (LComponent is TEdit) then
      Continue;
    if not FSelectedControls.ContainsKey(LComponent.Name) then
      Continue;
    for LEntryPoint in FSelectedControls[LComponent.Name].FEntryPoints.Values do
      TLinkEditEvent.New(TEdit(LComponent), LEntryPoint);
  end;
end;

procedure TFormEntryPointManager.LinkFormEvents;
var
  LEntryPoint: TFormEntryPoint;
begin
  if FSelectedControls.ContainsKey(GetFormName) then
    for LEntryPoint in FSelectedControls[GetFormName].FEntryPoints.Values do
      TLinkFormEvent.New(FForm, LEntryPoint);
end;

procedure TFormEntryPointManager.LoadAvailableEntryPoints;
var
  LIndex: Integer;
  LControl: TFormEntryPointControl;
begin
  //Add TForm entry points (events)
  LControl := TFormEntryPointControl.Create(GetFormName, 'TForm');
  LControl.EntryPoints.Add('OnShow', TFormEntryPoint.Create(Self, 'OnShow'));
  LControl.EntryPoints.Add('OnClose', TFormEntryPoint.Create(Self, 'OnClose'));
  LControl.EntryPoints.Add('OnActivate', TFormEntryPoint.Create(Self, 'OnActivate'));
  FAvailableControls.Add(GetFormName, LControl);

  for LIndex := 0 to FForm.ComponentCount - 1 do
  begin
    //add TEdit entry points (events)
    if FForm.Components[LIndex] is TEdit then
    begin
      LControl := TFormEntryPointControl.Create(FForm.Components[LIndex].Name, 'TEdit');
      LControl.EntryPoints.Add('OnEnter', TFormEntryPoint.Create(Self, 'OnEnter'));
      LControl.EntryPoints.Add('OnExit', TFormEntryPoint.Create(Self, 'OnExit'));
      FAvailableControls.Add(FForm.Components[LIndex].Name, LControl);
    end;
    //add TButton entry points (events)
    if FForm.Components[LIndex] is TButton then
    begin
      LControl := TFormEntryPointControl.Create(FForm.Components[LIndex].Name, 'TButton');
      LControl.EntryPoints.Add('OnClick', TFormEntryPoint.Create(Self, 'OnClick'));
      FAvailableControls.Add(FForm.Components[LIndex].Name, LControl);
    end;
  end;
end;

procedure TFormEntryPointManager.LoadSelectedEntryPoints;
Var
  LQuery: TUniQuery;
  LName: String;
  LType: String;
  LEvent: String;
  LAction: TFormEntryPointAction;
begin
  if not fConexaoAtiva then
    Exit;
  LQuery := fCriaQuery;
  try
    LQuery.SQL.Clear;
    LQuery.SQL.Add('SELECT SQL_NO_CACHE ');
    LQuery.SQL.Add('  * ');
    LQuery.SQL.Add('FROM ');
    LQuery.SQL.Add('  PONTO_ENTRADA ');
    LQuery.SQL.Add('WHERE TRUE ');
    LQuery.SQL.Add('  AND PEN_TIPENT = "EVENTO_FORMULARIO" ');
    LQuery.SQL.Add('  AND PEN_NOMFRM = "' + FForm.ClassName + '" ');
    LQuery.SQL.Add('ORDER BY ');
    LQuery.SQL.Add('  PEN_NOMOBJ, ');
    LQuery.SQL.Add('  PEN_NOMEVE, ');
    LQuery.SQL.Add('  PEN_SEQEXE  ');
    LQuery.Open;

    while not LQuery.Eof do
    begin
      LName := LQuery.FieldByName('PEN_NOMOBJ').AsString;
      LType := LQuery.FieldByName('PEN_TIPOBJ').AsString;
      LEvent := LQuery.FieldByName('PEN_NOMEVE').AsString;

      LAction := TFormEntryPointAction.Create;
      LAction.FId := LQuery.FieldByName('AUTOINCREM').AsString;
      LAction.FEnabled := LQuery.FieldByName('PEN_ATIEXE').AsString = 'S';
      LAction.FDescription := LQuery.FieldByName('PEN_DESCRI').AsString;
      LAction.FScript := LQuery.FieldByName('PEN_SCRIPT').AsString;
      LAction.FWatchList := LQuery.FieldByName('PEN_WATLST').AsString;

      if not FSelectedControls.ContainsKey(LName) then
        FSelectedControls.AddOrSetValue(LName, TFormEntryPointControl.Create(LName, LType));

      if not FSelectedControls[LName].EntryPoints.ContainsKey(LEvent) then
        FSelectedControls[LName].EntryPoints.AddOrSetValue(LEvent, TFormEntryPoint.Create(Self, LEvent));

      FSelectedControls[LName].EntryPoints[LEvent].Actions.AddOrSetValue(LAction.Id, LAction);

      LAction.FExecuteIndex := FSelectedControls[LName].EntryPoints[LEvent].Actions.Count;

      LQuery.Next;
    end;
  finally
    LQuery.Free;
  end;
end;

function TFormEntryPointManager.CheckUserPermission: Boolean;
var
  LSenha: String;
begin
  if FCheckUserPermission then
    if not strLoginUsuarioLogado.Equals(LOG_PRG) then
      if not ffrmSenha(LSenha) then
        Exit(False)
      else if not fRetCodVendedor(LSenha).Equals(LOG_PRG) Then
      begin
        pMensagemOk('Usuário informado não tem permissão para este recurso!');
        Exit(False);
      end;
  Result := True;
  FCheckUserPermission := False;
end;

function TFormEntryPointManager.UpdateExecuteIndex(Action: TFormEntryPointAction; AIndex: Integer): Boolean;
begin
  if not Assigned(Action) then
    Exit(False);
  if not CheckUserPermission then
    Exit(False);
  Action.UpdateExecuteIndex(AIndex);
  Result := True;
end;

function TFormEntryPointManager.AddActionScript(AControl: TFormEntryPointControl; AEvent: String): Boolean;
var
  LDescription: String;
  LQuery: TUniQuery;
  LAction: TFormEntryPointAction;
begin
  if not fConexaoAtiva then
    Exit(False);

  if not CheckUserPermission then
    Exit(False);

  LDescription := InputBox('Ponto de entrada (' + AControl.ControlName +
    '.' + AEvent + ')', 'Informe a descrição:', EmptyStr);

  if fEmptyStr(LDescription) then
    Exit(False);

  LQuery := fCriaQuery;
  try
    LQuery.SQL.Clear;
    LQuery.SQL.Add('SELECT SQL_NO_CACHE * FROM PONTO_ENTRADA WHERE FALSE');
    LQuery.Open;

    LAction := TFormEntryPointAction.Create;
    LAction.FId := fRetAutoIncrem('PONTO_ENTRADA', VS_strCodEmp);
    LAction.FExecuteIndex := AControl.EntryPoints.Count + 1;
    LAction.FEnabled := False;
    LAction.FDescription := LDescription;
    LAction.FScript := 'begin' + sLineBreak + sLineBreak + 'end.';

    AControl.EntryPoints[AEvent].Actions.AddOrSetValue(LAction.Id, LAction);

    LAction.FExecuteIndex := AControl.EntryPoints[AEvent].Actions.Count;

    LQuery.Append;
    LQuery.FieldByName('PEN_TIPENT').AsString := 'EVENTO_FORMULARIO';
    LQuery.FieldByName('PEN_NOMFRM').AsString := FForm.ClassName;
    LQuery.FieldByName('PEN_NOMOBJ').AsString := AControl.FControlName;
    LQuery.FieldByName('PEN_TIPOBJ').AsString := AControl.FControlType;
    LQuery.FieldByName('PEN_NOMEVE').AsString := AEvent;
    LQuery.FieldByName('PEN_SEQEXE').AsInteger:= LAction.FExecuteIndex;
    LQuery.FieldByName('PEN_ATIEXE').AsString := 'N';
    LQuery.FieldByName('PEN_DESCRI').AsString := LAction.FDescription;
    LQuery.FieldByName('PEN_SCRIPT').AsString := LAction.FScript;
    LQuery.FieldByName('AUTOINCREM').AsString := LAction.FId;
    LQuery.Post;

    Result := True;
  finally
    LQuery.Free;
  end;
end;

procedure TFormEntryPointManager.AddClass(AClass: IfsClassInfo);
begin
  FClasses.AddOrSetValue(AClass.ClassRef.ClassName, AClass);
end;

procedure TFormEntryPointManager.AddObject(AObject: IfsObjectInfo);
begin
  AddClass(TfsClassInfo.Create(AObject.Category, AObject.ObjectRef.ClassType));
  FObjects.AddOrSetValue(AObject.Name, AObject);
end;

procedure TFormEntryPointManager.AddVariable(AVariable: IfsVariableInfo);
begin
  FVariables.AddOrSetValue(AVariable.Name, AVariable);
end;

constructor TFormEntryPointManager.Create(AForm: TForm);
begin
  inherited Create(AForm);
  FClasses := TDictionary<String, IfsClassInfo>.Create;
  FObjects := TDictionary<String, IfsObjectInfo>.Create;
  FVariables := TDictionary<String, IfsVariableInfo>.Create;
  FSelectedControls := TDictionary<String,TFormEntryPointControl>.Create;
  FAvailableControls := TDictionary<String,TFormEntryPointControl>.Create;
  FCheckUserPermission := True;
  FForm := AForm;
  LoadSelectedEntryPoints;
  LoadAvailableEntryPoints;
  LinkFormEvents;
  LinkEditEvents;
  LinkButtonEvents;
end;

function TFormEntryPointManager.DeleteActionScript(AEntry: TFormEntryPoint;
  Action: TFormEntryPointAction): Boolean;
begin
  if not Assigned(Action) then
    Exit(False);
  if not CheckUserPermission then
    Exit(False);
  AEntry.Actions.Remove(Action.Id);
  Action.DeleteScript;
  Action.Free;
  Result := True;
end;

destructor TFormEntryPointManager.Destroy;
var
  LControl: TFormEntryPointControl;
begin
  for LControl in FSelectedControls.Values do
    LControl.Free;
  for LControl in FAvailableControls.Values do
    LControl.Free;
  FreeAndNil(FSelectedControls);
  FreeAndNil(FAvailableControls);
  FreeAndNil(FClasses);
  FreeAndNil(FObjects);
  FreeAndNil(FVariables);
  inherited;
end;

procedure TFormEntryPointManager.DisableAction(Action: TFormEntryPointAction);
begin
  if not Assigned(Action) then
    Exit;
  if not strLoginUsuarioLogado.Equals(LOG_ATD) then
    if not strLoginUsuarioLogado.Equals(LOG_IMP) then
      if not CheckUserPermission then
        Exit;
  Action.UpdateEnabled(False);
end;

function TFormEntryPointManager.EditActionScript(Action: TFormEntryPointAction): Boolean;
var
  LParams: IfsPascalScriptParams;
  LObjForm: IfsObjectInfo;
  LClass: IfsClassInfo;
  LObject: IfsObjectInfo;
  LVariable: IfsVariableInfo;
begin
  Result := False;

  if not Assigned(Action) then
    Exit;

  if not CheckUserPermission then
    Exit(False);

  LObjForm := TfsObjectInfo.Create('Formulários', GetFormName, FForm);

  LParams := TfsPascalScriptParams.New
    .Description(Action.Description)
    .ScriptText(Action.Script)
    .WatchList(Action.WatchList)
    .AddObject(LObjForm);

  for LClass In FClasses.Values do
    LParams.AddClass(LClass);

  for LObject In FObjects.Values do
    LParams.AddObject(LObject);

  for LVariable In FVariables.Values do
    LParams.AddVariable(LVariable);

  if TfsPascalScript.EditScript(LParams) Then
  begin
    Action.UpdateScript(LParams.Description, LParams.ScriptText, LParams.WatchList);
    Result := True;
  end;
end;

procedure TFormEntryPointManager.EnableAction(Action: TFormEntryPointAction);
begin
  if not Assigned(Action) then
    Exit;
  if not strLoginUsuarioLogado.Equals(LOG_ATD) then
    if not strLoginUsuarioLogado.Equals(LOG_IMP) then
      if not CheckUserPermission then
        Exit;
  Action.UpdateEnabled(True);
end;

procedure TFormEntryPointManager.ExecuteActionScript(Action: TFormEntryPointAction);
var
  LParams: IfsPascalScriptParams;
  LObjForm: IfsObjectInfo;
  LClass: IfsClassInfo;
  LObject: IfsObjectInfo;
  LVariable: IfsVariableInfo;
begin
  if not Assigned(Action) then
    Exit;

  if not Action.Enabled then
    Exit;

  LObjForm := TfsObjectInfo.Create('Formulários', GetFormName, FForm);

  LParams := TfsPascalScriptParams.New
    .Description(Action.Description)
    .ScriptText(Action.Script)
    .WatchList(Action.WatchList)
    .AddObject(LObjForm);

  for LClass In FClasses.Values do
    LParams.AddClass(LClass);

  for LObject In FObjects.Values do
    LParams.AddObject(LObject);

  for LVariable In FVariables.Values do
    LParams.AddVariable(LVariable);

  TfsPascalScript.RunScript(LParams);
end;

function TFormEntryPointManager.GetFormName: string;
var
  LTokens: TArray<String>;
begin
  Result := FForm.Name;
  if not Result.Contains('_') then
    Exit;
  LTokens := Result.Split(['_']);
  if fIsNumber(LTokens[Pred(Length(LTokens))]) then
    Result := Result.Replace('_' + LTokens[Pred(Length(LTokens))],'');
end;

constructor TFormEntryPoint.Create(AManager: TFormEntryPointManager; AEvent: String);
begin
  FEvent := AEvent;
  FManager := AManager;
  FActions := TDictionary<String, TFormEntryPointAction>.Create;
end;

destructor TFormEntryPoint.Destroy;
var
  LAction: TFormEntryPointAction;
begin
  for LAction in FActions.Values do
    LAction.Free;
  FActions.Free;
  inherited;
end;

procedure TFormEntryPoint.ExecuteActions;
var
  LSL: TStringList;
  LIndex: Integer;
  LAction: TFormEntryPointAction;
begin
  LSL := TStringList.Create;
  try
    LSL.Sorted := True;//Execute actions in order by ExecuteIndex
    for LAction in FActions.Values do
      LSL.AddObject(LAction.ExecuteIndex.ToString().PadLeft(6, '0'), LAction);
    for LIndex := 0 to LSL.Count -1 do
      FManager.ExecuteActionScript(TFormEntryPointAction(LSL.Objects[LIndex]));
  finally
    LSL.Free;
  end;
end;

constructor TFormEntryPointControl.Create(AName, AType: String);
begin
  FEntryPoints := TDictionary<String,TFormEntryPoint>.Create;
  FControlName := AName;
  FControlType := AType;
end;

destructor TFormEntryPointControl.Destroy;
var
  LEntry: TFormEntryPoint;
begin
  for LEntry in FEntryPoints.Values do
    LEntry.Free;
  FEntryPoints.Free;
  inherited;
end;

{ TLinkFormEvent }

constructor TLinkFormEvent.New(AForm: TForm; AEntry: TFormEntryPoint);
begin
  inherited Create(AForm);
  FForm := AForm;
  FEntry := AEntry;
  if AEntry.Event.Equals('OnShow') Then
  begin
    FNotifyEvent := FForm.OnShow;
    FForm.OnShow := Self.OnNotifyEvent;
  end;
  if AEntry.Event.Equals('OnClose') Then
  begin
    FCloseEvent := FForm.OnClose;
    FForm.OnClose := Self.OnCloseEvent;
  end;
  if AEntry.Event.Equals('OnActivate') Then
  begin
    FNotifyEvent := FForm.OnActivate;
    FForm.OnActivate := Self.OnNotifyEvent;
  end;
end;

procedure TLinkFormEvent.OnCloseEvent(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FCloseEvent) then
    FCloseEvent(Sender, Action);
  if Assigned(FEntry) then
    FEntry.ExecuteActions;
end;

procedure TLinkFormEvent.OnNotifyEvent(Sender: TObject);
begin
  if Assigned(FNotifyEvent) then
    FNotifyEvent(Sender);
  if Assigned(FEntry) then
    FEntry.ExecuteActions;
end;

{ TLinkButtonEvent }

constructor TLinkButtonEvent.New(AButton: TButton; AEntry: TFormEntryPoint);
begin
  inherited Create(AButton);
  FButton := AButton;
  FEntry := AEntry;
  if AEntry.Event.Equals('OnClick') Then
  begin
    FNotifyEvent := FButton.OnClick;
    FButton.OnClick := Self.OnNotifyEvent;
  end;
end;

procedure TLinkButtonEvent.OnNotifyEvent(Sender: TObject);
begin
  if Assigned(FNotifyEvent) then
    FNotifyEvent(Sender);
  if Assigned(FEntry) then
    FEntry.ExecuteActions;
end;

{ TLinkEditEvent }

constructor TLinkEditEvent.New(AEdit: TEdit; AEntry: TFormEntryPoint);
begin
  inherited Create(AEdit);
  FEdit := AEdit;
  FEntry := AEntry;
  if AEntry.Event.Equals('OnEnter') Then
  begin
    FNotifyEvent := FEdit.OnEnter;
    FEdit.OnEnter := Self.OnNotifyEvent;
  end;
  if AEntry.Event.Equals('OnExit') Then
  begin
    FNotifyEvent := FEdit.OnExit;
    FEdit.OnExit := Self.OnNotifyEvent;
  end;
end;

procedure TLinkEditEvent.OnNotifyEvent(Sender: TObject);
begin
  if Assigned(FNotifyEvent) then
    FNotifyEvent(Sender);
  if Assigned(FEntry) then
    FEntry.ExecuteActions;
end;

{ TFormEntryPointAction }

procedure TFormEntryPointAction.DeleteScript;
var
  LQuery: TUniQuery;
begin
  LQuery := fCriaQuery;
  try
    LQuery.SQL.Add('DELETE FROM PONTO_ENTRADA WHERE AUTOINCREM = :AUTINC');
    LQuery.ParamByName('AUTINC').AsString := Self.FId;
    LQuery.ExecSQL;
  finally
    LQuery.Free;
  end;
end;

procedure TFormEntryPointAction.UpdateExecuteIndex(const AValue: Integer);
var
  LQuery: TUniQuery;
begin
  if AValue = FExecuteIndex then
    Exit;
  FExecuteIndex := AValue;
  LQuery := fCriaQuery;
  try
    LQuery.SQL.Add('SELECT * FROM PONTO_ENTRADA WHERE AUTOINCREM = :AUTINC');
    LQuery.ParamByName('AUTINC').AsString := Self.FId;
    LQuery.Open;
    if not LQuery.IsEmpty then
    begin
      LQuery.Edit;
      LQuery.FieldByName('PEN_SEQEXE').AsInteger := AValue;
      LQuery.Post;
    end;
  finally
    LQuery.Free;
  end;
end;

procedure TFormEntryPointAction.UpdateEnabled(AValue: Boolean);
var
  LQuery: TUniQuery;
begin
  if Self.FEnabled = AValue then
    Exit;
  Self.FEnabled := AValue;
  LQuery := fCriaQuery;
  try
    LQuery.SQL.Add('SELECT * FROM PONTO_ENTRADA WHERE AUTOINCREM = :AUTINC');
    LQuery.ParamByName('AUTINC').AsString := Self.FId;
    LQuery.Open;
    if not LQuery.IsEmpty then
    begin
      LQuery.Edit;
      LQuery.FieldByName('PEN_ATIEXE').AsString := IIF(AValue, 'S', 'N');
      LQuery.Post;
    end;
  finally
    LQuery.Free;
  end;
end;

procedure TFormEntryPointAction.UpdateScript(ADescription, AScript, AWatchList: String);
var
  LQuery: TUniQuery;
begin
  if (Self.FDescription = ADescription) and
    (Self.FScript = AScript) and
    (Self.FWatchList = AWatchList) then
    Exit;

  LQuery := fCriaQuery;
  try
    LQuery.SQL.Add('SELECT * FROM PONTO_ENTRADA WHERE AUTOINCREM = :AUTINC');
    LQuery.ParamByName('AUTINC').AsString := Self.FId;
    LQuery.Open;
    if not LQuery.IsEmpty then
    begin
      LQuery.Edit;
      LQuery.FieldByName('PEN_DESCRI').AsString := ADescription;
      LQuery.FieldByName('PEN_SCRIPT').AsString := AScript;
      LQuery.FieldByName('PEN_WATLST').AsString := AWatchList;
      LQuery.Post;
    end;
  finally
    LQuery.Free;
  end;

  Self.FDescription := ADescription;
  Self.FScript := AScript;
  Self.FWatchList := AWatchList;
end;

end.
