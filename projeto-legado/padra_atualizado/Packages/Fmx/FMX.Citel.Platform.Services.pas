unit FMX.Citel.Platform.Services;

interface

uses
  FMX.Platform, FMX.Types, FMX.VirtualKeyboard, FMX.Forms, Winapi.MMSystem,
  System.Generics.Collections, System.Types, System.Classes, System.IOUtils,
  System.SysUtils, Winapi.Windows, System.SyncObjs;

type
  IFMXTimerServiceCitel = interface
    ['{E50DBC3C-6198-4013-A334-CAE4C71B3D0A}']
    function CreateTimer(Interval: Integer; TimerFunc: TTimerProc): TFmxHandle;
    function DestroyTimer(Timer: TFmxHandle): Boolean;
    function GetTick: Extended;
    procedure ClearAllTimers;
  end;

var
  FMXTimerServiceCitel: IFMXTimerServiceCitel;

implementation

type
  TWin32TimerInfo = record
    TimerID: UIntPtr; // the Windows timer ID for this timer
    TimerHandle: TFmxHandle; // the unique FMX Handle for this timer
    TimerFunc: TTimerProc; // owner function to handle timer
  end;

  { TPlatformWinCitelServices }

  TFMXWinTimerService = class(TInterfacedObject, IFMXTimerService, IFMXTimerServiceCitel)
  private
    FHandleCounter: TFmxHandle;
    FTimerData: TList<TWin32TimerInfo>;
    FPerformanceFrequency: Int64;
  public
    constructor Create;
    destructor Destroy; override;
    { IFMXTimerService }
    function CreateTimer(Interval: Integer; TimerFunc: TTimerProc): TFmxHandle;
    function DestroyTimer(Timer: TFmxHandle): Boolean;
    function GetTick: Extended;
    { IFMXTimerServiceCitel }
    procedure ClearAllTimers;
  end;

var
  FInstance: TFMXWinTimerService;
  FProcessId: string;

procedure LogTimer(AText: string);
begin
 {$IFDEF TIMERLOG}
  TRY
    if FileExists(FProcessId + '.tmr') then
      TFile.AppendAllText(FProcessId + '.tmr', DateTimeToStr(now()) + ' - ' + AText + sLineBreak);
  except
  end;
 {$ENDIF}
end;

procedure RegisterServices;
begin
  TPlatformServices.Current.RemovePlatformService(IFMXVirtualKeyboardService);
  TPlatformServices.Current.RemovePlatformService(IFMXTimerService);

  FMX.Forms.Application.ActionUpdateDelay := ActionUpdateDelayNever;

  FInstance := TFMXWinTimerService.Create;
  FMXTimerServiceCitel := FInstance;
  TPlatformServices.Current.AddPlatformService(IFMXTimerService, FInstance);
end;

procedure UnregisterServices;
begin
  TPlatformServices.Current.RemovePlatformService(IFMXTimerService);
end;

{ Timer }

procedure TimerCallBackProc(window_hwnd: HWND; Msg: Longint; idEvent: UINT; dwTime: Longint); stdcall;
var
  Index: Integer;
begin
  LogTimer(Format('TimerCallBackProc = {window_hwnd: %d, Msg: %d, idEvent: %d, dwTime: %d}', [window_hwnd, Msg, idEvent, dwTime]));
  try
    Index := FInstance.FTimerData.Count;
    while (Index > 0) do
    begin
      Dec(Index);
      if FInstance.FTimerData[Index].TimerID = idEvent then
      begin
        FInstance.FTimerData[Index].TimerFunc;
        Break;
      end;
    end;
  except
    on E: Exception do
    begin
      if Application <> nil then
        Application.HandleException(nil)
      else
        Raise;
    end;
  end;
end;

constructor TFMXWinTimerService.Create;
begin
  FTimerData := TList<TWin32TimerInfo>.Create;
  if not QueryPerformanceFrequency(FPerformanceFrequency) then
    FPerformanceFrequency := 0;
end;

function TFMXWinTimerService.CreateTimer(Interval: Integer; TimerFunc: TTimerProc): TFmxHandle;
var
  TimerInfo: TWin32TimerInfo;
begin
  Result := 0;
  if not Application.Terminated and (Interval > 0) and Assigned(TimerFunc) then
  begin
    TimerInfo.TimerFunc := TimerFunc;
    TimerInfo.TimerID := Winapi.Windows.SetTimer(0, 0, Interval, @TimerCallBackProc);
    if TimerInfo.TimerID <> 0 then
    begin
{$IFDEF CPUX64}
      TimerInfo.TimerHandle := TInterlocked.Add(Int64(FHandleCounter), 16);
{$ENDIF}
{$IFDEF CPUX86}
      TimerInfo.TimerHandle := TInterlocked.Add(Integer(FHandleCounter), 16);
{$ENDIF}
      FTimerData.Add(TimerInfo);
      Result := TimerInfo.TimerHandle;
    end;
  end;
  LogTimer(Format('TFMXWinTimerService.CreateTimer = {TimerHandle: %d, TimerID: %d, Interval: %d}',
    [TimerInfo.TimerHandle, TimerInfo.TimerID, Interval]));
end;

destructor TFMXWinTimerService.Destroy;
begin
  FreeAndNil(FTimerData);
  inherited;
end;

function TFMXWinTimerService.DestroyTimer(Timer: TFmxHandle): Boolean;
var
  Index: Integer;
begin
  Result := False;
  Index := FTimerData.Count;
  while (Index > 0) do
  begin
    Dec(Index);
    if FTimerData[Index].TimerHandle = Timer then
    begin
      Result := Winapi.Windows.KillTimer(0, FTimerData[Index].TimerID);
      LogTimer(Format('TFMXWinTimerService.DestroyTimer = {TimerHandle: %d, TimerID: %d}',
        [FTimerData[Index].TimerHandle, FTimerData[Index].TimerID]));
      FTimerData.Delete(Index);
    end;
  end;
end;

function TFMXWinTimerService.GetTick: Extended;
var
  PerformanceCounter: Int64;
begin
  if FPerformanceFrequency <> 0 then
  begin
    QueryPerformanceCounter(PerformanceCounter);
    Result := PerformanceCounter / FPerformanceFrequency;
  end
  else
    Result := timeGetTime / 1000;
end;

procedure TFMXWinTimerService.ClearAllTimers;
var
  D: TWin32TimerInfo;
  L: TList<TFmxHandle>;
  I: Integer;
begin
  L := TList<TFmxHandle>.Create;
  try
    for D in Self.FTimerData do
      if D.TimerHandle <> 0 then
        L.Add(D.TimerHandle);
    for I := L.Count - 1 downto 0 do
      try
        Self.DestroyTimer(L[I]);
      except
        Continue;
      end;
  finally
    FreeAndNil(L);
  end;
end;

initialization
  FProcessId := GetCurrentProcessId.ToString;
  FMX.Citel.Platform.Services.RegisterServices;

finalization
//  FMX.Platform.Win.Citel.UnregisterServices;

end.
