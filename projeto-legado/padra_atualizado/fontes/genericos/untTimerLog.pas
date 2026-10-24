unit untTimerLog;

interface

uses
  System.Classes, System.SysUtils, MadExcept, madStackTrace, WinApi.Windows,
  System.Generics.Collections, System.StrUtils, Vcl.ExtCtrls, System.DateUtils,
  System.Variants, System.IOUtils, Vcl.AppEvnts;

type
  TTimerLog = class(TInterfacedObject, ITimerLog)
  private const
    EnabledIntervalChangedLog = False;
    EnabledEnabledChangedLog = False;
    EnabledTimerEventExecuted = True;
  private type
    TTimerInfo = record
      Handle: HWND;
      Owner: String;
      Interval: Integer;
      Enabled: Boolean;
      Created: TDateTime;
      Destroyed: TDateTime;
    end;
  private
    FFile: String;
    FDic: TDictionary<HWND, TTimerInfo>;
    FGDIObjBefore: Integer;
    FUSERObjBefore: Integer;
    FStartedAction: TDateTime;
  private
    function GetGDIObjects: Integer;
    function GetUserObjects: Integer;
    function GetStackTrace: String;
  private
    procedure WriteLog(ATimerInfo: TTimerInfo; AText: String;
      AGetStack: Boolean = False);
  private
    class var TimerCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure BeforeAction;
    procedure CreateTimer(AWindowHandle: HWND; AOwner: TComponent;
      AInterval: Integer; AEnabled: Boolean);
    procedure EnabledChanged(AWindowHandle: HWND; AEnabled: Boolean);
    procedure IntervalChanged(AWindowHandle: HWND; AInterval: Integer);
    procedure TimerEventExecuted(AWindowHandle: HWND);
    procedure DestroyTimer(AWindowHandle: HWND);
  end;

implementation

procedure TTimerLog.BeforeAction;
begin
  FGDIObjBefore := GetGDIObjects;
  FUSERObjBefore := GetUserObjects;
  FStartedAction := Now();
end;

constructor TTimerLog.Create;
var
  FPath: String;
  FNomExe: String;
begin
  inherited Create;
  FPath := ExtractFilePath(ParamStr(0)) + '\logs';
  FNomExe := ExtractFileName(ParamStr(0));
  If Not DirectoryExists(FPath) Then
    ForceDirectories(FPath);
  FFile := FPath + '\' + FNomExe + '.' + FormatDateTime('yyyymmddhhnnsszzz',
    Now()) + '.timer';
  FDic := TDictionary<HWND, TTimerInfo>.Create;
end;

procedure TTimerLog.CreateTimer(AWindowHandle: HWND; AOwner: TComponent;
  AInterval: Integer; AEnabled: Boolean);
Var
  LTimerInfo: TTimerInfo;
  LGetStack: Boolean;
begin
  Inc(TimerCount);

  LGetStack := Not Assigned(AOwner);

  LTimerInfo.Handle := AWindowHandle;
  LTimerInfo.Interval := AInterval;
  LTimerInfo.Enabled := AEnabled;
  LTimerInfo.Created := Now();
  LTimerInfo.Destroyed := 0;

  LTimerInfo.Owner := EmptyStr;
  While Assigned(AOwner) Do
  Begin
    If Not LTimerInfo.Owner.IsEmpty Then
      LTimerInfo.Owner := '.' + LTimerInfo.Owner;
    LTimerInfo.Owner := AOwner.ClassName + LTimerInfo.Owner;
    AOwner := AOwner.Owner;
  End;

  If LTimerInfo.Owner.Equals(EmptyStr) Then
    LTimerInfo.Owner := 'Not assigned';

  FDic.AddOrSetValue(AWindowHandle, LTimerInfo);
  WriteLog(LTimerInfo, 'Create timer', LGetStack);
end;

destructor TTimerLog.Destroy;
begin
  WinExec(PAnsiChar(AnsiString('notepad.exe "' + FFile + '"')), SW_SHOWNORMAL);
  FreeAndNil(FDic);
  inherited;
end;

procedure TTimerLog.DestroyTimer(AWindowHandle: HWND);
Var
  LTimerInfo: TTimerInfo;
begin
  Dec(TimerCount);
  If Not FDic.TryGetValue(AWindowHandle, LTimerInfo) Then
    Exit;
  LTimerInfo.Destroyed := Now();
  FDic.AddOrSetValue(AWindowHandle, LTimerInfo);
  WriteLog(LTimerInfo, 'Destroy timer');
end;

procedure TTimerLog.EnabledChanged(AWindowHandle: HWND; AEnabled: Boolean);
Var
  LTimerInfo: TTimerInfo;
begin
  If Not EnabledEnabledChangedLog Then
    Exit;
  If Not FDic.TryGetValue(AWindowHandle, LTimerInfo) Then
    Exit;
  LTimerInfo.Enabled := AEnabled;
  FDic.AddOrSetValue(AWindowHandle, LTimerInfo);
  WriteLog(LTimerInfo, 'Enabled changed');
end;

function TTimerLog.GetGDIObjects: Integer;
begin
  Result := GetGuiResources(GetCurrentProcess, GR_GDIOBJECTS)
end;

function TTimerLog.GetStackTrace: String;
Var
  LIndex: Integer;
  LStack: String;
  LSLStack: TStringList;
begin
  LStack := madStackTrace.StackTrace(True);
  LSLStack := TStringList.Create;
  Try
    LIndex := 0;
    LSLStack.Text := LStack;
    While LIndex < Pred(LSLStack.Count) Do
    Begin
      If LSLStack[LIndex].Contains('untTimerLog') Then
      Begin
        LSLStack.Delete(LIndex);
        LIndex := 0;
      End
      Else If LSLStack[LIndex].Contains('Vcl.ExtCtrls') And
        LSLStack[LIndex].Contains('TTimer.Create') Then
      Begin
        LSLStack.Delete(LIndex);
        LIndex := 0;
      End
      Else If LSLStack[LIndex].Contains('TNewTimer.Create') Or
        LSLStack[LIndex].Contains('TNewTimer.Get') Then
      Begin
        LSLStack.Delete(LIndex);
        LIndex := 0;
      End
      Else
        Inc(LIndex);
    End;
    While LSLStack.Count > 1 Do
      LSLStack.Delete(Pred(LSLStack.Count));
    Result := LSLStack.Text.Replace(#13, '').Replace(#10, '');
  Finally
    FreeAndNil(LSLStack);
  End;
end;

function TTimerLog.GetUserObjects: Integer;
begin
  Result := GetGuiResources(GetCurrentProcess, GR_USEROBJECTS)
end;

procedure TTimerLog.IntervalChanged(AWindowHandle: HWND; AInterval: Integer);
Var
  LTimerInfo: TTimerInfo;
begin
  If Not EnabledIntervalChangedLog Then
    Exit;
  If Not FDic.TryGetValue(AWindowHandle, LTimerInfo) Then
    Exit;
  LTimerInfo.Interval := AInterval;
  FDic.AddOrSetValue(AWindowHandle, LTimerInfo);
  WriteLog(LTimerInfo, 'Interval changed');
end;

procedure TTimerLog.TimerEventExecuted(AWindowHandle: HWND);
Var
  LTimerInfo: TTimerInfo;
begin
  If Not EnabledTimerEventExecuted Then
    Exit;
  If Not FDic.TryGetValue(AWindowHandle, LTimerInfo) Then
    Exit;
  FDic.AddOrSetValue(AWindowHandle, LTimerInfo);
  WriteLog(LTimerInfo, 'Timer event executed');
end;

procedure TTimerLog.WriteLog(ATimerInfo: TTimerInfo; AText: String;
  AGetStack: Boolean = False);
const
  sLine = '--------------------------------------------------------------------';
  sObjects = '%d/%d (Before/After)';
Var
  LLog: TextFile;
  LGDIOBJECTS: string;
  LUSEROBJECTS: string;
  LTotalTimeSec: Integer;
begin
  System.AssignFile(LLog, FFile);

  If System.SysUtils.FileExists(FFile) Then
    System.Append(LLog)
  Else
    System.Rewrite(LLog);

  LGDIOBJECTS := Format(sObjects, [FGDIObjBefore, GetGDIObjects]);
  LUSEROBJECTS := Format(sObjects, [FUSERObjBefore, GetUserObjects]);
  LTotalTimeSec := SecondsBetween(Now(), FStartedAction);

  System.WriteLn(LLog, '');
  System.WriteLn(LLog, sLine);
  System.WriteLn(LLog, 'DATE/TIME.....: ' + DateTimeToStr(Now));
  System.WriteLn(LLog, 'TIMER LOG.....: ' + AText);
  System.WriteLn(LLog, 'TIMER HANDLE..: ' + FloatToStr(ATimerInfo.Handle));
  System.WriteLn(LLog, 'TIMER OWNER...: ' + ATimerInfo.Owner);
  System.WriteLn(LLog, 'TIMER ENABLED.: ' + VarToStr(ATimerInfo.Enabled));
  System.WriteLn(LLog, 'TIMER INTERVAL: ' + ATimerInfo.Interval.ToString);
  System.WriteLn(LLog, 'TIMER COUNT...: ' + TimerCount.ToString);
  System.WriteLn(LLog, 'TOTAL TIME....: ' + LTotalTimeSec.ToString + ' sec');
  System.WriteLn(LLog, 'GDIOBJECTS....: ' + LGDIOBJECTS);
  System.WriteLn(LLog, 'USEROBJECTS...: ' + LUSEROBJECTS);
  { try to know where create the object timer }
  If AGetStack Then
    System.WriteLn(LLog, 'STACK TRACE...: ' + GetStackTrace);
  System.WriteLn(LLog, sLine);
  System.CloseFile(LLog);
end;

var
  ApplicationEvents: TApplicationEvents;

type
  TTimerMessage = class
  public
    class procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
  end;

class procedure TTimerMessage.ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
var
  sMsg: string;
begin
  if Msg.message <> 275 then Exit;
  if not FileExists(VS_ProcessId + '.tmr') then Exit;
  sMsg := Format('message = {time: %d, hwnd: %d, message: %d, wParam: %d, lParam: %d}',
    [Msg.time, Msg.hwnd, Msg.message, Msg.wParam, Msg.lParam]);
  try
    TFile.AppendAllText(VS_ProcessId + '.tmr', DateTimeToStr(Now()) + ' - ' + sMsg + sLineBreak);
  except
  end;
end;

initialization
  TFile.AppendAllText(VS_ProcessId + '.tmr', '--------------------------------' + sLineBreak);
  ApplicationEvents := TApplicationEvents.Create(nil);
  ApplicationEvents.OnMessage := TTimerMessage.ApplicationEventsMessage;
  Vcl.ExtCtrls.TimerLog := TTimerLog.Create;

finalization
  Vcl.ExtCtrls.TimerLog := nil;

end.
(*

needed changes in Vcl.ExtCtrls (class TTimer)

{$IFDEF TIMERLOG}
  ITimerLog = Interface
    ['{C38E23DA-B6AA-4462-BF0D-0385F29D07F4}']
    procedure BeforeAction;
    procedure CreateTimer(AWindowHandle: HWND; AOwner: TComponent;
      AInterval: Integer; AEnabled: Boolean);
    procedure EnabledChanged(AWindowHandle: HWND; AEnabled: Boolean);
    procedure IntervalChanged(AWindowHandle: HWND; AInterval: Integer);
    procedure TimerEventExecuted(AWindowHandle: HWND);
    procedure DestroyTimer(AWindowHandle: HWND);
  end;
{$ENDIF}

{$IFDEF TIMERLOG}
Var
  TimerLog: ITimerLog;
{$ENDIF}

constructor TTimer.Create(AOwner: TComponent);
begin
{$IFDEF TIMERLOG}
  If Assigned(TimerLog) Then
    TimerLog.BeforeAction;
{$ENDIF}
  inherited Create(AOwner);
  FEnabled := True;
  FInterval := 1000;
  FWindowHandle := AllocateHWnd(WndProc);
{$IFDEF TIMERLOG}
  If Assigned(TimerLog) Then
    TimerLog.CreateTimer(FWindowHandle, AOwner, FInterval, FEnabled);
{$ENDIF}
end;

destructor TTimer.Destroy;
{$IFDEF TIMERLOG}
Var
  LWindowHandle: HWND;
{$ENDIF}
begin
{$IFDEF TIMERLOG}
  LWindowHandle := FWindowHandle;
  If Assigned(TimerLog) Then
    TimerLog.BeforeAction;
{$ENDIF}
  FEnabled := False;
  if FWindowHandle <> 0 then
  begin
    UpdateTimer;
    DeallocateHWnd(FWindowHandle);
    FWindowHandle := 0;
  end;
{$IF DEFINED(CLR)}
  System.GC.SuppressFinalize(self);
{$ENDIF}
{$IFDEF TIMERLOG}
  If Assigned(TimerLog) Then
    TimerLog.DestroyTimer(LWindowHandle);
{$ENDIF}
  inherited Destroy;
end;

procedure TTimer.SetEnabled(Value: Boolean);
begin
  if Value <> FEnabled then
  begin
   {$IFDEF TIMERLOG}
    if Assigned(TimerLog) then TimerLog.BeforeAction;
   {$ENDIF}
    FEnabled := Value;
    UpdateTimer;
   {$IFDEF TIMERLOG}
    if Assigned(TimerLog) then TimerLog.EnabledChanged(FWindowHandle, Value);
   {$ENDIF}
  end;
end;

procedure TTimer.SetInterval(Value: Cardinal);
begin
  if Value <> FInterval then
  begin
   {$IFDEF TIMERLOG}
    if Assigned(TimerLog) then TimerLog.BeforeAction;
   {$ENDIF}
    FInterval := Value;
    UpdateTimer;
   {$IFDEF TIMERLOG}
    if Assigned(TimerLog) then TimerLog.IntervalChanged(FWindowHandle, Value);
   {$ENDIF}
  end;
end;

procedure TTimer.Timer;
begin
 {$IFDEF TIMERLOG}
  if Assigned(TimerLog) then TimerLog.BeforeAction;
 {$ENDIF}
  if Assigned(FOnTimer) then FOnTimer(Self);
 {$IFDEF TIMERLOG}
  if Assigned(TimerLog) then TimerLog.TimerEventExecuted(FWindowHandle);
 {$ENDIF}
end;

*)
