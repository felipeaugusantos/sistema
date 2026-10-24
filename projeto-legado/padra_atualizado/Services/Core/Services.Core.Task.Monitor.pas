unit Services.Core.Task.Monitor;

interface

uses System.Classes;

type
  TResultExecute = record
    Modified : Boolean;
  End;

  ITaskMonitorProcedure = interface
    ['{33A9A1B2-8EFB-4FF6-AE80-455173B50571}']
    procedure pExecute;
    procedure pExecuteAll;
    function fExecute : TResultExecute;
  end;

  TTaskMonitor = class sealed(TThread)
  private
    FIdTaskMonitor: String;
    FTimeLimit: Integer;
    FLockTaskMonitor: String;
    FProcedureExec: ITaskMonitorProcedure;
  public
    class var SleepTimeout: Integer;
  protected
    procedure Execute; override;
  public
    constructor Create(IdTaskMonitor: String; TimeLimit: Integer;
      LockTaskMonitor: String; ProcedureExec: ITaskMonitorProcedure);
  end;

  TUtilTaskMonitor = class sealed
  public
    class function FLockTaskMonitor(const AId: String;
      var ALockTaskMonitor: String): Boolean;
    class function fRemoveLockTaskMonitor(const AId: String): Boolean;
    class function fTaskMonitorIsRunning(const AId: String): Boolean;

    class procedure pClearAttemptsLock(const AId: String;
      const AAttempts: Integer);
  end;

implementation

uses
  System.SysUtils, System.StrUtils, System.DateUtils, Services.Core.Task.Lock,
  Services.Core.Settings, Services.Core.Utils, Services.Core.Connection.Manager;

{ TUtilTaskMonitor }

class function TUtilTaskMonitor.FLockTaskMonitor(const AId: String;
  var ALockTaskMonitor: String): Boolean;
begin
  Result := TTasklock.fLock_Unlock(Format(AId, [VS_strCodEmp]), True, False);
  If Result Then
    ALockTaskMonitor := TTasklock.fGetIdConnectionLock
      (Format(AId, [VS_strCodEmp]));
end;

class function TUtilTaskMonitor.fTaskMonitorIsRunning
  (const AId: String): Boolean;
begin
  Result := Not TTasklock.fGetHostLock(Format(AId, [VS_strCodEmp]),
    True).IsEmpty;
  If Result Then
    TTasklock.fLock_Unlock(Format(AId, [VS_strCodEmp]), True, False);
end;

class function TUtilTaskMonitor.fRemoveLockTaskMonitor
  (const AId: String): Boolean;
begin
  TTasklock.fLock_Unlock(Format(AId, [VS_strCodEmp]), False, False);
  Result := True;
end;

class procedure TUtilTaskMonitor.pClearAttemptsLock(const AId: String;
  const AAttempts: Integer);
begin
  If (TTasklock.fGetTentativasLock(AId) > AAttempts) Then
    TTasklock.pDestravaLockForcado(AId, AAttempts);
end;

{ TTaskMonitor }

constructor TTaskMonitor.Create(IdTaskMonitor: String; TimeLimit: Integer;
  LockTaskMonitor: String; ProcedureExec: ITaskMonitorProcedure);
begin
  inherited Create(True);
  FIdTaskMonitor := IdTaskMonitor;
  FTimeLimit := TimeLimit;
  FLockTaskMonitor := LockTaskMonitor;
  FProcedureExec := ProcedureExec;
end;

procedure TTaskMonitor.Execute;
var
  LParams: string;
  LNomExe: string;
  LIndex: Integer;
  LLastLog: TDateTime;
  LStart: TDateTime;
begin
  inherited;
  objConnectionsManager.BeginConnection;
  Try
    LParams := '';

    If (ParamCount > 0) Then
      For LIndex := 1 To ParamCount Do
        LParams := LParams + IfThen(LParams.IsEmpty, '', ' ') + ParamStr(LIndex);

    LNomExe := ExtractFileName(System.SysUtils.GetModuleName(HInstance));

    Writeln(DateTimeToStr(Now()) + ' - ' + LNomExe + ' ' + LParams  + ' is running ...');

    LStart := fNow;
    LLastLog := fNow;
    Try
      While True do
      Begin
        If SecondsBetween(fNow, LLastLog) >= 30 then
        begin
          Writeln(DateTimeToStr(Now()) + ' - ' + LNomExe + ' ' + LParams  + ' is running ...');
          LLastLog := fNow;
        end;

        If FTimeLimit > 0 Then
          If (MinutesBetween(fNow, LStart) > FTimeLimit) Then
            Break;

        If (FLockTaskMonitor <> TTasklock.fGetIdConnectionLock
          (Format(FIdTaskMonitor, [VS_strCodEmp]))) Then
          Break;

        If Assigned(FProcedureExec) Then
          FProcedureExec.pExecuteAll();

        If VS_ExitProcessSignal Then
          Break;

        TTasklock.pZerarTentativasLock(Format(FIdTaskMonitor, [VS_strCodEmp]));
        Sleep(SleepTimeout);
      End;
    Except
      On E: Exception Do
      Begin
        WriteError(E.ClassName + ': ' + E.Message);
      End;
    End;
  Finally
    TUtilTaskMonitor.fRemoveLockTaskMonitor(FIdTaskMonitor);
    objConnectionsManager.EndConnection;
  End;
end;

initialization
  TTaskMonitor.SleepTimeout := 3000;

end.
