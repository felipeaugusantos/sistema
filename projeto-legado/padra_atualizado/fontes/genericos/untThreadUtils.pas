unit untThreadUtils;

interface

uses SysUtils, Classes, Contnrs, System.Types, Uni, Windows, Data.DB,
  SyncObjs, Dialogs, DateUtils, UniClientDataSet, untTypesSistema;

type
  TPrcAfterConnect = reference to procedure (const AConnection : TUniConnection);

  TSafeThread = class
  public
    class var Connections: IThreadConnections;
    class var EnableLogging: Boolean;
    class var MaxThreads: Integer;
    class var ThreadCount: Integer;
    class var PrcAfterConnect : TPrcAfterConnect;
  private
    const
      MaxCardinal = Cardinal(High(Cardinal));
  private type
    TThreadExecute = class(TThread)
    private
      ThreadName: string;
      ExecuteMethod: TGenericProcedure;
    protected
      procedure Execute; override;
    end;
  private
    FThread: TThreadExecute;
    FOnTerminateProp: TNotifyEvent;
    FFreeOnTerminate: Boolean;
  private
    procedure OnTerminateEvent(Sender: TObject);
    function GetFreeOnTerminate: Boolean;
    procedure SetFreeOnTerminate(const Value: Boolean);
   {$WARNINGS OFF}
    function GetPriority: TThreadPriority;
    procedure SetPriority(const Value: TThreadPriority);
   {$WARNINGS ON}
    function GetTerminated: Boolean;
    function GetStarted: Boolean;
    function GetHandle: THandle;
    function GetFinished: Boolean;
    function TempoDecorrido(const TickCountInicial, TempoDeEspera : Cardinal): Boolean;
  protected
    procedure Execute; virtual; abstract;
    procedure Synchronize(AMethod: TThreadMethod); overload;
    procedure Synchronize(AThreadProc: TThreadProcedure); overload;
    procedure ThreadSleep(const TempoDeEspera : Cardinal);
  public
    constructor Create(CreateSuspended: Boolean = False);
    destructor Destroy; override;
  public
    procedure Start;
    procedure Terminate;
    procedure WaitFor;
  public
    property FreeOnTerminate: Boolean read GetFreeOnTerminate write SetFreeOnTerminate;
   {$WARNINGS OFF}
    property Priority: TThreadPriority read GetPriority write SetPriority;
   {$WARNINGS ON}
    property Terminated: Boolean read GetTerminated;
    property Handle: THandle read GetHandle;
    property Started: Boolean read GetStarted;
    property Finished: Boolean read GetFinished;
    property OnTerminate: TNotifyEvent read FOnTerminateProp write FOnTerminateProp;
  end;

  TExecSQLNoWait = class
  public
    class procedure Exec(strSQL: String; blnRaise: Boolean = False); overload;
    class procedure Exec(strSQL: String; procSync: TThreadMethod); overload;
    class procedure Exec(strSQL: String; procSync: TThreadProcedure); overload;
   {$IFNDEF ENVIA_EMAIL_BOLETO}
    class procedure Open(strSQL: String; cdsData: TUniClientDataSet; procSync: TThreadProcedure);
   {$ENDIF}
  end;

  TThreadFinalizarAutcomMonitor = class(TThread)
  private
    class var FInstance: TThreadFinalizarAutcomMonitor;
  private
    const FTimeout = 60;
  private
    FBegin: TDateTime;
    FPID: Integer;
    FRunning: Boolean;
  protected
    procedure Execute; override;
  public
    constructor Create(APID: Integer);
    destructor Destroy; override;

    class procedure Monitorar;
    class procedure Parar;
  end;

type
  TThreadFileExists = class(TThread)
  public type
    ExceptionClass = Class Of Exception;
    TTestResult = (tfNoFile, tfFileExists, tfTimeOut);
  private
    FFileName: String;
    FErr    : String;
    FErrclass: ExceptionClass;
    FResult : Boolean;
  protected
    procedure Execute; override;
  private
    function TestForFile( const filename: String; timeoutMSecs: Dword): TTestResult;
  public
    class function TryFileExists(AFile: string; ATimeoutSecs: Integer = 10): Boolean; static;
  end;

type
  TThreadDirectoryExists = class(TThread)
  public type
    ExceptionClass = Class Of Exception;
    TTestResult = (trNoDirectory, trDirectoryExists, trTimeout);
  private
    FDirname: String;
    FErr    : String;
    FErrclass: ExceptionClass;
    FResult : Boolean;
  protected
    procedure Execute; override;
  private
    function TestForDir( const dirname: String; timeoutMSecs: Dword): TTestResult;
  public
    class function TryDirectoryExists(APath: string; ATimeoutSecs: Integer): Boolean; static;
  end;

type
  ESafeThreadHandledException = Class(Exception)
  private
    FMySqlStatementsHistory: string;
  public
    constructor Create(const AErrorMsg, AMySqlStatementsHistory: string);
    property MySqlStatementsHistory: string read FMySqlStatementsHistory;
  end;

implementation

uses
  untModulo;

type
  TThreadConnection = class(TObject)
  private
    FThreadId: Cardinal;
    FThreadInfo: string;
    FConnection: TUniConnection;
    FConnectionID: string;
    FLogThr: ILogThr;
  private
    procedure AfterConnect(Sender: TObject);
    procedure BeforeDisconnect(Sender: TObject);
  public
    constructor Create(Conn: TUniConnection; ThreadId: Cardinal; ThreadInfo: string);
    destructor Destroy; override;
    procedure Connect;
    procedure Disconnect;
  End;

  TThreadConnections = class(TInterfacedObject, IThreadConnections)
  private
    const sLineSeparator = '--------------------------------------------------------------------------------';
  private
    FCount: Integer;
    FConexoes: TObjectList;
    FSemaphore: TCriticalSection;
  private
    function CreateConnection(intThreadId: Cardinal): TUniConnection;
  public
    constructor Create;
    destructor Destroy; override;
  public
    function GetThreadConnection(intThreadId: Cardinal; AThreadInfo: string): TUniConnection; overload;
    function HasThreadConnection(intThreadId: Cardinal): Boolean;
    function RemoveThreadConnection(intThreadId: Cardinal): Boolean; overload;
    function GetThreadConnectionInfo(intThreadId: Cardinal): string;
  public
    function GetLocalConnection(AMethodName: string): TUniConnection; overload;
    function RemoveLocalConnection(AConn: TUniConnection): Boolean; overload;
    function GetAllMySqlStatementsHistory: string;
  End;

Type
  TLogThr = class sealed(TInterfacedObject, ILogThr)
  private
    class var FProcessId: Cardinal;
  private
    FThreadId: string;
    FQuery: TUniQuery;
    FConnection: TUniConnection;
  private
    function Enter(const AMessage: string = ''): ILogThr;
    function Exit(const AMessage: string = ''): ILogThr;
  private
    constructor Create(AThreadId: string; AConnection: TUniConnection);
  public
    destructor Destroy; override;
  public
    class function New(AThreadId: string; AConnection: TUniConnection = nil): ILogThr;
  end;

function fPadC(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  Var
    intDir, intEsq: Integer;
    intContador: Integer;
begin
  If Length(strTexto) < intTamanho Then
  begin
    intTamanho := intTamanho - Length(strTexto);
    intDir := (intTamanho Div 2);
    intEsq := (intTamanho Div 2) + intTamanho Mod 2;
    Result := strTexto;
    For intContador := 1 To intDir Do
      Result := Result + strCaracter;
    For intContador := 1 To intEsq Do
      Result := strCaracter + Result;
  end
  else
    Result := Copy(strTexto,1,intTamanho);
end;

procedure ForceKill(AProcess: Integer); overload;
begin
  WinExec(PAnsiChar(AnsiString('taskkill /F /PID ' + AProcess.ToString)), SW_HIDE);
end;

function KillProcess(pid: cardinal; AForceKill: Boolean = True): Boolean;
var
  killer: THandle;
begin
  killer := OpenProcess(PROCESS_TERMINATE, False, pid);
  Result := TerminateProcess(killer, 0);
  if not Result and AForceKill Then
    ForceKill(pid);
end;

function fCriaClientDataSet(qryOrigem: TDataset; blnVazio: Boolean = False;
 AOwner: TComponent = Nil; blnRegistroAtual: Boolean = False): TUniClientDataSet;
  Var
    intCont  : Integer;
    intRecno : Integer;
begin
  Result := TUniClientDataSet.Create(AOwner);

  For intCont := 0 To qryOrigem.Fields.Count -1 Do
    With Result.FieldDefs.AddFieldDef Do
    Begin
      Name     := qryOrigem.Fields[intCont].FieldName;
      DataType := qryOrigem.Fields[intCont].DataType;
      Size     := qryOrigem.Fields[intCont].Size;
      Required := False;
    End;

  Result.CreateDataSet;
  Result.Open;

  Result.LogChanges := False;

  If blnVazio Then
    Exit;

  With qryOrigem Do
  Begin
    intRecno := RecNo;
    DisableControls;

    If Not blnRegistroAtual Then
      First;

    While (Not Eof) Or blnRegistroAtual Do
    Begin
      Result.Append;

      For intCont := 0 To Fields.Count -1 Do
        Result.Fields[intCont].Value := Fields[intCont].Value;

      Result.Post;

      If blnRegistroAtual Then
        Break;

      Next;
    End;
    RecNo := intRecno;
    EnableControls;
  End;
end;

{$IFNDEF ENVIA_EMAIL_BOLETO}
class procedure TExecSQLNoWait.Open(strSQL: String; cdsData: TUniClientDataSet; procSync: TThreadProcedure);
  Var
    cdsTemp: TUniClientDataSet;
    qryTemp: TUniQuery;
Begin
  TThread.CreateAnonymousThread(
    procedure
    var
      LConn: TUniConnection;
    begin
      LConn := TSafeThread.Connections.GetThreadConnection(GetCurrentThreadId,
        'TExecSQLNoWait.Open.CreateAnonymousThread');
      try
        qryTemp := TUniQuery.Create(nil);
        try
          qryTemp.Connection := LConn;
          qryTemp.SQL.Add(strSQL);
          qryTemp.Open;
          cdsTemp := fCriaClientDataSet(qryTemp);
          try
            TThread.Synchronize(TThread.CurrentThread, procedure
              begin
                cdsData.Data := cdsTemp.Data;
              end);
            if Assigned(procSync) then
              TThread.Synchronize(TThread.CurrentThread, procSync);
          finally
            FreeAndNil(cdsTemp);
          end;
        finally
          FreeAndNil(qryTemp);
        end;
      finally
        TSafeThread.Connections.RemoveThreadConnection(GetCurrentThreadId);
      end;
    end
  ).Start;
end;
{$ENDIF}

class procedure TExecSQLNoWait.Exec(strSQL: String; blnRaise: Boolean = False);
  Var
    qryGen: TUniQuery;
Begin
  TThread.CreateAnonymousThread(
    procedure
    var
      LConn: TUniConnection;
    begin
      LConn := TSafeThread.Connections.GetThreadConnection(GetCurrentThreadId,
        'TExecSQLNoWait.Exec.CreateAnonymousThread');
      try
        try
          qryGen := TUniQuery.Create(nil);
          try
            qryGen.Connection := LConn;
            qryGen.Tag := qryGen.Connection.Tag;
            qryGen.SQL.Add(strSQL);
            qryGen.ExecSQL;
          finally
            FreeAndNil(qryGen);
          end;
        except
          On E: Exception do
            if blnRaise then
              raise;
        end;
      finally
        TSafeThread.Connections.RemoveThreadConnection(GetCurrentThreadId);
      end;
    end
  ).Start;
end;

class procedure TExecSQLNoWait.Exec(strSQL: String; procSync: TThreadMethod);
  Var
    qryGen: TUniQuery;
Begin
  TThread.CreateAnonymousThread(
    procedure
    var
      LConn: TUniConnection;
    begin
      LConn := TSafeThread.Connections.GetThreadConnection(GetCurrentThreadId,
        'TExecSQLNoWait.Exec.CreateAnonymousThread');
      try
        try
          qryGen := TUniQuery.Create(nil);
          try
            qryGen.Connection := LConn;
            qryGen.Tag := qryGen.Connection.Tag;
            qryGen.SQL.Add(strSQL);
            qryGen.ExecSQL;
            if Assigned(procSync) then
              TThread.Synchronize(TThread.CurrentThread, procSync);
          finally
            FreeAndNil(qryGen);
          end;
        except
          On E: Exception do
            raise;
        end;
      finally
        TSafeThread.Connections.RemoveThreadConnection(GetCurrentThreadId);
      end;
    end
  ).Start;
End;

class procedure TExecSQLNoWait.Exec(strSQL: String; procSync: TThreadProcedure);
  Var
    qryGen: TUniQuery;
Begin
  TThread.CreateAnonymousThread(
    procedure
    var
      LConn: TUniConnection;
    begin
      LConn := TSafeThread.Connections.GetThreadConnection(GetCurrentThreadId,
        'TExecSQLNoWait.Exec.CreateAnonymousThread');
      try
        try
          qryGen := TUniQuery.Create(nil);
          try
            qryGen.Connection := LConn;
            qryGen.Tag := qryGen.Connection.Tag;
            qryGen.SQL.Add(strSQL);
            qryGen.ExecSQL;
            if Assigned(procSync) then
              TThread.Synchronize(TThread.CurrentThread, procSync);
          finally
            FreeAndNil(qryGen);
          end;
        except
          On E: Exception do
            raise;
        end;
      finally
        TSafeThread.Connections.RemoveThreadConnection(GetCurrentThreadId);
      end;
    end
  ).Start;
End;

function fGetConnectionID(AConnection: TUniConnection): String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := TUniQuery.Create(nil);
  Try
    qryAux.Connection := AConnection;
    qryAux.SQL.Add('SELECT CONNECTION_ID()');
    qryAux.Open;
    Result := qryAux.Fields[0].AsString;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function fGetTimeFromDatabase(AConnection: TUniConnection): TDateTime;
  Var
    qryAux: TUniQuery;
begin
  qryAux := TUniQuery.Create(nil);
  Try
    qryAux.Connection := AConnection;
    qryAux.SQL.Add('SELECT CURRENT_TIME');
    qryAux.Open;
    Result := qryAux.Fields[0].AsDateTime;
  Finally
    FreeAndNil(qryAux);
  End;
end;

{ TLogThr }

constructor TLogThr.Create(AThreadId: string; AConnection: TUniConnection);
begin
  If TSafeThread.EnableLogging Then
  Begin
    FThreadId := AThreadId;
    FConnection := AConnection;
    FQuery := TUniQuery.Create(nil);
    FQuery.Connection := FConnection;
    FQuery.SQL.Text := 'SELECT * FROM LOGTHR WHERE FALSE';
    FQuery.Open;
  End;
end;

destructor TLogThr.Destroy;
begin
  If Assigned(FQuery) Then
    FreeAndNil(FQuery);
  inherited;
end;

class function TLogThr.New(AThreadId: string; AConnection: TUniConnection = nil): ILogThr;
begin
  Result := Self.Create(AThreadId, AConnection);
end;

function TLogThr.Enter(const AMessage: string): ILogThr;
begin
  Result := Self;
  If Assigned(FQuery) and FConnection.Connected Then
  Begin
    FQuery.Append;
    FQuery.FieldByName('LOG_PROCID').AsString   := FProcessId.ToString;
    FQuery.FieldByName('LOG_CON_ID').AsString   := fGetConnectionID(FConnection);
    FQuery.FieldByName('LOG_THR_ID').AsString   := FThreadId;
    FQuery.FieldByName('LOG_INITHR').AsDateTime := Date + fGetTimeFromDatabase(FConnection);
    FQuery.FieldByName('LOG_INIMSG').AsString   := AMessage;
    FQuery.Post;
  End;
end;

function TLogThr.Exit(const AMessage: string): ILogThr;
begin
  Result := Self;
  try
    if Assigned(FQuery) and FConnection.Connected then
    begin
      FQuery.Edit;
      FQuery.FieldByName('LOG_FINTHR').AsDateTime := Date + fGetTimeFromDatabase(FConnection);
      FQuery.FieldByName('LOG_FINMSG').AsString := AMessage;
      FQuery.Post;
    end;
  except
    on E: Exception do
      raise ESafeThreadHandledException.Create(FThreadId + ' - ' + E.Message, '');
  end;
end;

{ TThreadConnection }

procedure TThreadConnection.AfterConnect(Sender: TObject);
begin
  FLogThr := TLogThr.New(FThreadInfo, FConnection).Enter('TThreadConnection.AfterConnect');

  If Not FConnection.Connected Then
    Exit;

  {$IFNDEF LINUX}
  TDiretivasDaConexao.DefineIsolationLevel(FConnection);
  {$ENDIF}

  If Not Assigned(TSafeThread.PrcAfterConnect) Then
    Exit;

  TSafeThread.PrcAfterConnect(FConnection);
end;

procedure TThreadConnection.BeforeDisconnect(Sender: TObject);
begin
  if assigned(FLogThr) then
    FLogThr.Exit('TThreadConnection.BeforeDisconnect');
end;

procedure TThreadConnection.Connect;
begin
  try
    FConnection.Connect;
  except
    on E: Exception do
    begin
      if E.message.ToLower.Contains('Maximum connections reached in pool'.ToLower) then
      begin
        FConnection.Pooling := False;
        FConnection.Connect;
        TfrmModulo.fGravarRelErro('Número máximo de conexões atingido', 'TThreadConnection.Connect - ' + FThreadInfo,
          TfrmModulo.GetMySqlStatementsHistory(FConnection), FConnection);
      end
      else
        Raise;
    end;
  end;
  FConnectionID := fGetConnectionID(FConnection);
end;

constructor TThreadConnection.Create(Conn: TUniConnection; ThreadId: Cardinal; ThreadInfo: string);
begin
  FThreadId := ThreadId;
  FThreadInfo := ThreadInfo;
  FConnection := Conn;
  FConnection.AfterConnect := Self.AfterConnect;
  FConnection.BeforeDisconnect := Self.BeforeDisconnect;
end;

procedure TThreadConnection.Disconnect;
begin
  FConnection.Disconnect;
end;

destructor TThreadConnection.Destroy;
begin
  If (Not Assigned(frmModulo)) Or (FConnection <> frmModulo.Database) Then
  Begin
    FConnection.Disconnect;
    FreeAndNil(FConnection);
  End;
  inherited;
end;

{ TThreadConnections }

constructor TThreadConnections.Create;
begin
  FSemaphore := TCriticalSection.Create;
  FConexoes := TObjectList.Create;
  FConexoes.OwnsObjects := True;
end;

destructor TThreadConnections.Destroy;
begin
  FConexoes.Clear;
  FreeAndNil(FConexoes);
  FreeAndNil(FSemaphore);
  inherited;
end;

function TThreadConnections.GetAllMySqlStatementsHistory: string;
Var
  intIndice: Integer;
  LMySqlStmts: string;
  LConnInfo: string;
  LThreadConn: TThreadConnection;
begin
  Result := EmptyStr;
  FSemaphore.Enter;
  Try
    If assigned(frmModulo) Then
    Begin
      LConnInfo := fPadC('MAIN CONNECTION (frmModulo.Database)', Length(sLineSeparator));
      LMySqlStmts := TfrmModulo.GetMySqlStatementsHistory(frmModulo.Database);

      Result := sLineSeparator + sLineBreak + LConnInfo + sLineBreak + sLineSeparator + sLineBreak +
        LMySqlStmts + sLineBreak + sLineSeparator + sLineBreak;
    End;

    For intIndice := 0 To FConexoes.Count - 1 Do
    Begin
      LThreadConn := TThreadConnection(FConexoes[intIndice]);

      If LThreadConn.FThreadInfo.StartsWith('TThread') Then
        LConnInfo := fPadC(LThreadConn.FThreadInfo, Length(sLineSeparator))
      Else
        LConnInfo := fPadC('SECONDARY CONNECTION (' + LThreadConn.FConnectionID + ')', Length(sLineSeparator));

      LMySqlStmts := TfrmModulo.GetMySqlStatementsHistory(LThreadConn.FConnection);

      Result := Result + sLineSeparator + sLineBreak + LConnInfo + sLineBreak + sLineSeparator + sLineBreak +
        LMySqlStmts + sLineBreak + sLineSeparator + sLineBreak;
    End;
  Finally
    FSemaphore.Leave;
  End;
end;

function TThreadConnections.GetLocalConnection(AMethodName: string): TUniConnection;
Var
  LRandomId: Integer;
  LThreadConn: TThreadConnection;
  LConn: TUniConnection;
begin
  LRandomId := Random(MaxInt);
  FSemaphore.Enter;
  Try
    LConn := CreateConnection(LRandomId);
    LThreadConn := TThreadConnection.Create(LConn, LRandomId,
      'Proc/Func -> ' + AMethodName + ' [TID: ' + GetCurrentThreadId.ToString + ']');
    FConexoes.Add(LThreadConn);
    FCount := FConexoes.Count;
    LThreadConn.Connect;
    Result := LThreadConn.FConnection;
  Finally
    FSemaphore.Leave;
  End;
end;

function TThreadConnections.CreateConnection(intThreadId: Cardinal): TUniConnection;
begin
  Result := TUniConnection.Create(Nil);
  Result.Tag := intThreadId;
  Result.ProviderName := frmModulo.Database.ProviderName;
  Result.Username := frmModulo.Database.Username;
  Result.Password := frmModulo.Database.Password;
  Result.Server := frmModulo.Database.Server;
  Result.Database := frmModulo.Database.Database;
  Result.Port := frmModulo.Database.Port;
  Result.DefaultTransaction.IsolationLevel := frmModulo.Database.DefaultTransaction.IsolationLevel;
  Result.LoginPrompt := False;
  Result.PoolingOptions.MaxPoolSize := TDefaultPoolingOptions.MaxPoolSize;
  Result.PoolingOptions.MinPoolSize := TDefaultPoolingOptions.MinPoolSize;
  Result.PoolingOptions.Validate := TDefaultPoolingOptions.Validate;
  Result.PoolingOptions.ConnectionLifetime := TDefaultPoolingOptions.ConnectionLifetime;
  Result.Pooling := TDefaultPoolingOptions.Pooling;
end;

function TThreadConnections.GetThreadConnection(intThreadId: Cardinal; AThreadInfo: string): TUniConnection;
Var
  intContador: Integer;
  LThreadConn: TThreadConnection;
  LConn: TUniConnection;
begin
  Result := Nil;
  if TDefaultPoolingOptions.Pooling then
    while FCount >= Round(TDefaultPoolingOptions.MaxPoolSize * 0.8) do
      Sleep(1000);
  FSemaphore.Enter;
  Try
    For intContador := 0 To FConexoes.Count - 1 Do
    Begin
      LThreadConn := TThreadConnection(FConexoes[intContador]);
      If LThreadConn.FThreadId = intThreadId Then
      Begin
        Result := LThreadConn.FConnection;
        Break;
      End;
    End;

    If Not Assigned(Result) Then
    Begin
      LConn := CreateConnection(intThreadId);
      LThreadConn := TThreadConnection.Create(LConn, intThreadId,
        'TThread -> ' + AThreadInfo + ' [TID: ' + intThreadId.ToString +']');
      FConexoes.Add(LThreadConn);
      FCount := FConexoes.Count;
      LThreadConn.Connect;
      Result := LThreadConn.FConnection;
    End;
  Finally
    FSemaphore.Leave;
  End;
end;

function TThreadConnections.HasThreadConnection(intThreadId: Cardinal): Boolean;
Var
  intContador: Integer;
  LThreadConn: TThreadConnection;
begin
  Result := False;
  FSemaphore.Enter;
  Try
    For intContador := 0 To FConexoes.Count - 1 Do
    Begin
      LThreadConn := TThreadConnection(FConexoes[intContador]);
      If LThreadConn.FThreadId = intThreadId Then
      Begin
        Result := True;
        Break;
      End;
    End;
  Finally
    FSemaphore.Leave;
  End;
end;

function TThreadConnections.GetThreadConnectionInfo(intThreadId: Cardinal): string;
Var
  intContador: Integer;
  LThreadConn: TThreadConnection;
begin
  Result := EmptyStr;
  FSemaphore.Enter;
  Try
    For intContador := 0 To FConexoes.Count - 1 Do
    Begin
      LThreadConn := TThreadConnection(FConexoes[intContador]);
      If LThreadConn.FThreadId = intThreadId Then
      Begin
        Result := LThreadConn.FThreadInfo;
        Break;
      End;
    End;
  Finally
    FSemaphore.Leave;
  End;
end;

function TThreadConnections.RemoveLocalConnection(AConn: TUniConnection): Boolean;
Var
  intIndice: Integer;
  LThreadConn: TThreadConnection;
begin
  Result := False;
  FSemaphore.Enter;
  Try
    For intIndice := 0 To FConexoes.Count - 1 Do
    Begin
      LThreadConn := TThreadConnection(FConexoes[intIndice]);
      If LThreadConn.FConnection = AConn Then
      Begin
        LThreadConn.Disconnect;
        FConexoes.Remove(LThreadConn);
        FCount := FConexoes.Count;
        Result := True;
        Break;
      End;
    End;
  Finally
    FSemaphore.Leave;
  End;
end;

function TThreadConnections.RemoveThreadConnection(intThreadId: Cardinal): Boolean;
Var
  intIndice: Integer;
  LThreadConn: TThreadConnection;
begin
  Result := False;
  FSemaphore.Enter;
  Try
    For intIndice := 0 To FConexoes.Count - 1 Do
    Begin
      LThreadConn := TThreadConnection(FConexoes[intIndice]);
      If LThreadConn.FThreadId = intThreadId Then
      Begin
        LThreadConn.Disconnect;
        FConexoes.Remove(LThreadConn);
        FCount := FConexoes.Count;
        Result := True;
        Break;
      End;
    End;
  Finally
    FSemaphore.Leave;
  End;
end;

{ TSafeThread }

constructor TSafeThread.Create(CreateSuspended: Boolean = False);
begin
  FThread := TThreadExecute.Create(CreateSuspended);
  FThread.FreeOnTerminate := FFreeOnTerminate;
  FThread.ExecuteMethod := Self.Execute;
  FThread.ThreadName := Self.ClassName;
  FThread.OnTerminate := Self.OnTerminateEvent;
  FFreeOnTerminate := FThread.FreeOnTerminate;
end;

destructor TSafeThread.Destroy;
begin
  if not FFreeOnTerminate then
    FThread.Free;
  inherited;
end;

function TSafeThread.GetFinished: Boolean;
begin
  Result := FThread.Finished;
end;

function TSafeThread.GetFreeOnTerminate: Boolean;
begin
  Result := FFreeOnTerminate;
end;

function TSafeThread.GetHandle: THandle;
begin
  Result := FThread.Handle;
end;

{$WARNINGS OFF}
function TSafeThread.GetPriority: TThreadPriority;
begin
  Result := FThread.Priority;
end;
{$WARNINGS ON}


function TSafeThread.GetStarted: Boolean;
begin
  Result := FThread.Started;
end;

function TSafeThread.GetTerminated: Boolean;
begin
  Result := FThread.Terminated;
end;

procedure TSafeThread.OnTerminateEvent(Sender: TObject);
begin
  if Assigned(FOnTerminateProp) Then
    FOnTerminateProp(Self);

  if FFreeOnTerminate then
    Self.Free;
end;

procedure TSafeThread.SetFreeOnTerminate(const Value: Boolean);
begin
  FFreeOnTerminate := Value;
  FThread.FreeOnTerminate := Value;
end;

{$WARNINGS OFF}
procedure TSafeThread.SetPriority(const Value: TThreadPriority);
begin
  FThread.Priority := Value;
end;
{$WARNINGS ON}

procedure TSafeThread.Start;
begin
  FThread.Start;
end;

procedure TSafeThread.Synchronize(AMethod: TThreadMethod);
begin
  FThread.Synchronize(AMethod);
end;

procedure TSafeThread.Synchronize(AThreadProc: TThreadProcedure);
begin
  FThread.Synchronize(AThreadProc);
end;

procedure TSafeThread.Terminate;
begin
  FThread.Terminate;
end;

function TSafeThread.TempoDecorrido(const TickCountInicial, TempoDeEspera : Cardinal): Boolean;
  Var
    TickCountAtual : Cardinal;
begin
  TickCountAtual := GetTickCount;
  If TickCountInicial <= TickCountAtual Then
    Result := (TickCountAtual - TickCountInicial) >= TempoDeEspera
  Else
    Result := ((MaxCardinal - TickCountInicial) + TickCountAtual) >= TempoDeEspera;
end;

procedure TSafeThread.ThreadSleep(const TempoDeEspera : Cardinal);
  Var
    TickCountAtual : Cardinal;
begin
  TickCountAtual := GetTickCount;
  While Not TempoDecorrido(TickCountAtual, TempoDeEspera) Do
  Begin
    If (FThread.CheckTerminated) Then
      Break;
    Sleep(10);
  End;
end;

procedure TSafeThread.WaitFor;
begin
  FThread.WaitFor;
end;

{ TSafeThread.TThreadExecute }

procedure TSafeThread.TThreadExecute.Execute;
var
  LConn: TUniConnection;
begin
  inherited;
  while TSafeThread.ThreadCount >= TSafeThread.MaxThreads do
    Sleep(1000);
  AtomicIncrement(TSafeThread.ThreadCount);
  try
    LConn := TSafeThread.Connections.GetThreadConnection(GetCurrentThreadId, ThreadName + '.Execute');
    try
      try
        ExecuteMethod;
      except
        on E: ESafeThreadHandledException do
          raise;

        on E: Exception do
          raise ESafeThreadHandledException.Create(ThreadName + '.Execute' + ' - ' + E.Message,
            TfrmModulo.GetMySqlStatementsHistory(LConn));
      end;
    finally
      TSafeThread.Connections.RemoveThreadConnection(GetCurrentThreadId);
    end;
  finally
    AtomicDecrement(TSafeThread.ThreadCount);
  end;
end;

{ TThreadFinalizarAutcomMonitor }

constructor TThreadFinalizarAutcomMonitor.Create(APID: Integer);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  FBegin := Date + Time();
  FPID := APID;
end;

destructor TThreadFinalizarAutcomMonitor.Destroy;
begin
  Self.FInstance := nil;
  inherited;
end;

procedure TThreadFinalizarAutcomMonitor.Execute;
begin
  inherited;
  FRunning := True;
  While Not Terminated Do
  Begin
    If SecondsBetween(Date + Time(), FBegin) > FTimeout Then
    Begin
      KillProcess(FPID);
      Break;
    End;
    Sleep(500);
  End;
  FRunning := False;
end;

class procedure TThreadFinalizarAutcomMonitor.Monitorar;
begin
  If Not Assigned(Self.FInstance) Then
    Self.FInstance := TThreadFinalizarAutcomMonitor.Create(GetCurrentProcessId);
  If Not Self.FInstance.FRunning Then
    Self.FInstance.Start;
end;

class procedure TThreadFinalizarAutcomMonitor.Parar;
begin
  If Assigned(Self.FInstance) Then
    Self.FInstance.Terminate;
end;

{TThreadDirectoryExists}

procedure TThreadDirectoryExists.Execute;
begin
  try
    FResult := DirectoryExists( FDirname );
  except
    On E: Exception Do
    begin
      FErr := E.Message;
      FErrclass := ExceptionClass( E.Classtype );
    end;
  end;
end;

function TThreadDirectoryExists.TestForDir(const dirname: String;
   timeoutMSecs: Dword): TTestResult;
begin
  FDirname := dirname;
  Start;
  If WaitForSingleObject( Handle, timeoutMSecs ) = WAIT_TIMEOUT Then
  Begin
    Result := trTimeout;
    FreeOnTerminate := true;
  End
  Else
  Begin
    If Assigned( FErrclass ) Then
      raise FErrClass.Create( FErr );
    If FResult Then
      Result := trDirectoryExists
    Else
      Result := trNoDirectory;
  End;
end;

class function TThreadDirectoryExists.TryDirectoryExists(APath: string; ATimeoutSecs: Integer): Boolean;
Var
  res: TThreadDirectoryExists.TTestResult;
  thread: TThreadDirectoryExists;
Begin
  if APath = '' then Exit(False);
  Assert(ATimeoutSecs > 0, 'TryDirectoryExists: timeout cannot be 0.');
  thread:= TThreadDirectoryExists.Create( true );
  try
    res:= thread.TestForDir( APath, ATimeoutSecs * 1000);
    Result := res = trDirectoryExists;
    If res <> trTimeout Then
      thread.Free;
  except
    thread.free;
    raise
  end;
End;

{ TThreadFileExists }

procedure TThreadFileExists.Execute;
begin
  try
    FResult := FileExists( FFileName );
  except
    On E: Exception Do
    begin
      FErr := E.Message;
      FErrclass := ExceptionClass( E.Classtype );
    end;
  end;
end;

function TThreadFileExists.TestForFile(const filename: String;
  timeoutMSecs: Dword): TTestResult;
begin
  FFileName := filename;
  Start;
  If WaitForSingleObject( Handle, timeoutMSecs ) = WAIT_TIMEOUT Then
  Begin
    Result := tfTimeout;
    FreeOnTerminate := true;
  End
  Else
  Begin
    If Assigned( FErrclass ) Then
      raise FErrClass.Create( FErr );
    If FResult Then
      Result := tfFileExists
    Else
      Result := tfNoFile;
  End;
end;

class function TThreadFileExists.TryFileExists(AFile: string; ATimeoutSecs: Integer = 10): Boolean;
Var
  res: TThreadFileExists.TTestResult;
  thread: TThreadFileExists;
Begin
  if AFile = '' then Exit(False);
  Assert(ATimeoutSecs > 0, 'TThreadFileExists: timeout cannot be 0.');
  thread:= TThreadFileExists.Create( true );
  try
    res:= thread.TestForFile( AFile, ATimeoutSecs * 1000);
    Result := res = tfFileExists;
    If res <> tfTimeout Then
      thread.Free;
  except
    thread.free;
    raise
  end;
end;

{ ESafeThreadHandledException }

constructor ESafeThreadHandledException.Create(const AErrorMsg, AMySqlStatementsHistory: string);
begin
  inherited Create(AErrorMsg);
  FMySqlStatementsHistory := AMySqlStatementsHistory;
end;

initialization

TSafeThread.EnableLogging := False;
TSafeThread.MaxThreads := 3;

TSafeThread.Connections := TThreadConnections.Create;
TLogThr.FProcessId := GetCurrentProcessId;
TSafeThread.PrcAfterConnect := Nil;

finalization

TThreadFinalizarAutcomMonitor.Parar;

TSafeThread.Connections := nil;
TSafeThread.PrcAfterConnect := Nil;

end.
