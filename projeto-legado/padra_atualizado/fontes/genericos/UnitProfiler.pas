unit UnitProfiler;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  System.Math, System.Generics.Defaults, Winapi.Windows, Winapi.PsAPI,
  System.SyncObjs, Uni, Data.DB;

procedure InitProfiler;
procedure EnterMethod(const AUnit, AClass, AMethod: string);
procedure ExitMethod(const AUnit, AClass, AMethod: string);
procedure Allocate(const AMethod, AVarName: string);
procedure Deallocate(const AMethod, AVarName: string);
function DumpStats(const AConnection : TUniConnection; const AConnID, APid, AMnuAceKey : String) : String;
procedure ClearStats;
function MicroToSecondsStr(const AMicro : Int64) : String;
procedure CreateProfilerDirectory;
function ProfilerDirectory : String;
procedure InsertProfilerQueue(const AFileName : String; const AConnection: TUniConnection);
procedure CallProfilerImporter;
procedure pInitProfilerUser(const AOperadorLogado : String; const AConnection: TUniConnection);

Var
  VS_TrackTiming : Boolean;
  VS_TrackMemory : Boolean;
  VS_TrackLeaks  : Boolean;

implementation

type
  TMemSnapshot = record
    WorkingSetKB:    Int64;
    PrivateUsageKB:  Int64;
    PageFaultCount:  Cardinal;
    PagefileUsageKB: Int64;
  end;

type
  PROCESS_MEMORY_COUNTERS_EX = record
    cb: DWORD;                          // Tamanho da estrutura em bytes (obrigatório preencher antes da chamada)
    PageFaultCount: DWORD;              // Quantidade total de page faults desde o início do processo (Inclui soft + hard faults, é acumulativo)
    PeakWorkingSetSize: SIZE_T;         // Maior valor já atingido pelo Working Set (pico de RAM usada)
    WorkingSetSize: SIZE_T;             // Memória atualmente na RAM (Working Set) (Inclui memória privada + compartilhada (DLLs, etc))
    QuotaPeakPagedPoolUsage: SIZE_T;    // Pico de uso do pool paginado do kernel (uso interno do Windows)
    QuotaPagedPoolUsage: SIZE_T;        // Uso atual do pool paginado do kernel
    QuotaPeakNonPagedPoolUsage: SIZE_T; // Pico do pool não paginado (kernel)
    QuotaNonPagedPoolUsage: SIZE_T;     // Uso atual do pool não paginado (kernel)
    PagefileUsage: SIZE_T;              // Memória comprometida do processo (RAM + pagefile) (Em Delphi antigo, é o melhor "proxy" de memória real usada)
    PeakPagefileUsage: SIZE_T;          // Pico histórico de memória comprometida
    PrivateUsage: SIZE_T;               // Memória privada do processo (não compartilhada) (Melhor métrica para detectar vazamento de memória)
  end;

type
  TCallInfo = record
    TotalTime: Int64; // total em µs
    Calls: Int64;
  end;

  TStackItem = record
    Key: string;
    StartStamp: Int64;
    ChildTime: Int64;
    StartMemKB: Int64;  // PrivateUsageKB na entrada do metodo
    EntryTimeStamp: TDateTime;
    ExitTimeStamp: TDateTime;
  end;

  TMemoryEntry = record
    Key: string;
    EntryPrivateKB: Int64;
    ExitPrivateKB: Int64;
    EntryStampUs: Int64;
    ExitStampUs: Int64;
    EntryTimeStamp: TDateTime;
    ExitTimeStamp: TDateTime;
  end;

threadvar
  CallStack: TStack<TStackItem>;

var
  PerfFreq: Int64 = 0;
  SessionStartStamp: Int64 = 0;
  Stats: TDictionary<string, TCallInfo>;
  MemoryLog: TList<TMemoryEntry>;
  AllocMap: TDictionary<string, Integer>;
  GProfilerActive: Boolean = False;
  GProfilerLock: TCriticalSection;

function GetMemSnapshot: TMemSnapshot;
var
  PMC: PROCESS_MEMORY_COUNTERS_EX;
begin
  ZeroMemory(@PMC, SizeOf(PMC));
  PMC.cb := SizeOf(PMC);
  if GetProcessMemoryInfo(GetCurrentProcess, @PMC, SizeOf(PMC)) then
  begin
    Result.WorkingSetKB    := PMC.WorkingSetSize div 1024;
    Result.PrivateUsageKB  := PMC.PrivateUsage div 1024;
    Result.PageFaultCount  := PMC.PageFaultCount;
    Result.PagefileUsageKB := PMC.PagefileUsage div 1024;
  end
  else
  begin
    Result.WorkingSetKB    := 0;
    Result.PrivateUsageKB  := 0;
    Result.PageFaultCount  := 0;
    Result.PagefileUsageKB := 0;
  end;
end;

function GetTimestamp: Int64;
begin
  QueryPerformanceCounter(Result);
end;

function BuildMethodKey(const AUnit, AClass, AMethod: String): String;
begin
  Result := AUnit;
  If Not AClass.IsEmpty Then
    Result := Result + '.' + AClass;
  If Not AMethod.IsEmpty Then
    Result := Result + '.' + AMethod;
end;

procedure InitProfiler;
begin
  if PerfFreq = 0 then
  begin
    QueryPerformanceFrequency(PerfFreq);
    QueryPerformanceCounter(SessionStartStamp);
  end;
  if Stats = nil then
    Stats := TDictionary<string, TCallInfo>.Create;
  if MemoryLog = nil then
    MemoryLog := TList<TMemoryEntry>.Create;
  if AllocMap = nil then
    AllocMap := TDictionary<string, Integer>.Create;
  if CallStack = nil then
    CallStack := TStack<TStackItem>.Create;
  GProfilerActive := True;
end;

procedure EnterMethod(const AUnit, AClass, AMethod: string);
var
  Item: TStackItem;
  MemKB: Int64;
begin
  if (not GProfilerActive) or (CallStack = nil) or (PerfFreq = 0) or ((not VS_TrackTiming) and (not VS_TrackMemory)) then
    Exit;

  if VS_TrackMemory then
    MemKB := GetMemSnapshot.PrivateUsageKB
  else
    MemKB := 0;

  Item.Key := BuildMethodKey(AUnit, AClass, AMethod);
  Item.StartStamp := GetTimestamp;
  Item.ChildTime := 0;
  Item.StartMemKB := MemKB;
  Item.EntryTimeStamp := Now();

  CallStack.Push(Item);
end;

procedure ExitMethod(const AUnit, AClass, AMethod: string);
  Var
    EndStamp, TotalElapsed, ExclusiveElapsed : Int64;
    Item : TStackItem;
    Parent : TStackItem;
    Info : TCallInfo;
    Key : String;
    ExitMemKB : Int64;
    ExitTimeStamp : TDateTime;
    Entry : TMemoryEntry;
    LExpectedKey : String;
begin
  if (not GProfilerActive) or (CallStack = nil) or (PerfFreq = 0) or ((not VS_TrackTiming) and (not VS_TrackMemory)) then
    Exit;

  LExpectedKey := BuildMethodKey(AUnit, AClass, AMethod);
  while (CallStack.Count > 0) and (CallStack.Peek.Key <> LExpectedKey) do
    CallStack.Pop;
  if CallStack.Count = 0 then
    Exit;

  EndStamp := GetTimestamp;

  ExitTimeStamp := Now();

  if VS_TrackMemory then
    ExitMemKB := GetMemSnapshot.PrivateUsageKB
  else
    ExitMemKB := 0;

  Item := CallStack.Pop;
  Item.ExitTimeStamp := ExitTimeStamp;
  Key := Item.Key;

  // Tempo total bruto
  TotalElapsed := (EndStamp - Item.StartStamp) * 1000000 div PerfFreq; // µs

  // Tempo exclusivo (descontando filhos)
  ExclusiveElapsed := TotalElapsed - Item.ChildTime;

  // Se ainda tem alguém na stack, significa que existe um método pai
  if CallStack.Count > 0 then
  begin
    Parent := CallStack.Pop;
    Inc(Parent.ChildTime, TotalElapsed); // soma o tempo total no pai
    CallStack.Push(Parent);
  end;

  GProfilerLock.Enter;
  try
    if not Stats.TryGetValue(Key, Info) then
      Info := Default(TCallInfo);
    Inc(Info.Calls);
    Inc(Info.TotalTime, ExclusiveElapsed);
    Stats.AddOrSetValue(Key, Info);

    if VS_TrackMemory then
    begin
      Entry.Key := Key;
      Entry.EntryPrivateKB := Item.StartMemKB;
      Entry.ExitPrivateKB := ExitMemKB;
      Entry.EntryStampUs := (Item.StartStamp - SessionStartStamp) * 1000000 div PerfFreq;
      Entry.ExitStampUs := (EndStamp - SessionStartStamp) * 1000000 div PerfFreq;
      Entry.EntryTimeStamp := Item.EntryTimeStamp;
      Entry.ExitTimeStamp := Item.ExitTimeStamp;
      if Entry.ExitPrivateKB > Entry.EntryPrivateKB then
        MemoryLog.Add(Entry);
    end;
  finally
    GProfilerLock.Leave;
  end;
end;

procedure Allocate(const AMethod, AVarName: string);
Var
  LKey   : String;
  LCount : Integer;
Begin
  If (Not GProfilerActive) Or (Not VS_TrackLeaks) Or (AVarName.IsEmpty) Then
    Exit;
  LKey := AMethod + '|' + AVarName;
  GProfilerLock.Enter;
  try
    If Not AllocMap.TryGetValue(LKey, LCount) Then
      LCount := 0;
    AllocMap.AddOrSetValue(LKey, LCount + 1);
  finally
    GProfilerLock.Leave;
  end;
End;

procedure Deallocate(const AMethod, AVarName: string);
Var
  LKey   : String;
  LCount : Integer;
Begin
  If (Not GProfilerActive) Or (Not VS_TrackLeaks) Or AVarName.IsEmpty Then
    Exit;
  LKey := AMethod + '|' + AVarName;
  GProfilerLock.Enter;
  try
    If Not AllocMap.TryGetValue(LKey, LCount) Then
      LCount := 0;
    AllocMap.AddOrSetValue(LKey, LCount - 1);
  finally
    GProfilerLock.Leave;
  end;
End;

procedure ClearStats;
begin
  GProfilerLock.Enter;
  try
    if Stats <> nil then
      Stats.Clear;
    if MemoryLog <> nil then
      MemoryLog.Clear;
    if AllocMap <> nil then
      AllocMap.Clear;
  finally
    GProfilerLock.Leave;
  end;
end;

function SaveTimingCSV(const AConnection: TUniConnection; const AConnID, APid, AMnuAceKey, AStamp: String): Integer;
Var
  LPairList   : TList<TPair<string, TCallInfo>>;
  LPair       : TPair<string, TCallInfo>;
  LStringList : TStringList;
  LFileName   : String;
begin
  Result := 0;
  If (Stats = Nil) Or (Stats.Count = 0) Then
    Exit;

  LPairList   := TList<TPair<string, TCallInfo>>.Create;
  LStringList := TStringList.Create;
  Try
    GProfilerLock.Enter;
    try
      For LPair In Stats Do
        LPairList.Add(LPair);
    finally
      GProfilerLock.Leave;
    end;

    LPairList.Sort(
      TComparer<TPair<string, TCallInfo>>.Construct(
        function(const L, R: TPair<string, TCallInfo>): Integer
        begin
          if L.Value.TotalTime > R.Value.TotalTime then Result := -1
          else if L.Value.TotalTime < R.Value.TotalTime then Result := 1
          else Result := 0;
        end));

    LStringList.Add('PID;CONID;Metodo;Chamadas;Tempo_Total_us;Tempo_Medio_us;Tempo_Total_s;Tempo_Medio_s;MNUKEY');
    For LPair In LPairList Do
      If LPair.Value.Calls > 0 Then
        LStringList.Add(
          APid + ';' + AConnID + ';' + LPair.Key + ';' +
          LPair.Value.Calls.ToString + ';' +
          LPair.Value.TotalTime.ToString + ';' +
          (LPair.Value.TotalTime div LPair.Value.Calls).ToString + ';' +
          MicroToSecondsStr(LPair.Value.TotalTime) + ';' +
          MicroToSecondsStr(LPair.Value.TotalTime div LPair.Value.Calls) + ';' +
          AMnuAceKey
        );

    LFileName := ProfilerDirectory + '\' + Format('ProfilerTiming_%s.csv', [AStamp]);
    LStringList.SaveToFile(LFileName, TEncoding.UTF8);
    Result := LStringList.Count;
    InsertProfilerQueue(LFileName, AConnection);
  Finally
    LStringList.Free;
    LPairList.Free;
  End;
end;

function SaveMemoryCSV(const AConnection: TUniConnection; const AConnID, APid, AMnuAceKey, AStamp: String): Integer;
Var
  LStringList : TStringList;
  LEntry      : TMemoryEntry;
  LFileName   : String;
begin
  Result := 0;
  If (Not VS_TrackMemory) Or (MemoryLog = Nil) Or (MemoryLog.Count = 0) Then
    Exit;

  LStringList := TStringList.Create;
  Try
    LStringList.Add('PID;CONID;Metodo;PrivateKBEntrada;PrivateKBSaida;Inicio_us;Fim_us;InicioTimeStamp;FimTimeStamp;MNUKEY');
    GProfilerLock.Enter;
    try
      For LEntry In MemoryLog Do
        LStringList.Add(
          APid + ';' + AConnID + ';' + LEntry.Key + ';' +
          LEntry.EntryPrivateKB.ToString + ';' +
          LEntry.ExitPrivateKB.ToString + ';' +
          LEntry.EntryStampUs.ToString + ';' +
          LEntry.ExitStampUs.ToString + ';' +
          FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz', LEntry.EntryTimeStamp) + ';' +
          FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz', LEntry.ExitTimeStamp) + ';' +
          AMnuAceKey
        );
    finally
      GProfilerLock.Leave;
    end;

    LFileName := ProfilerDirectory + '\' + Format('ProfilerMemory_%s.csv', [AStamp]);
    LStringList.SaveToFile(LFileName, TEncoding.UTF8);
    Result := LStringList.Count;
    InsertProfilerQueue(LFileName, AConnection);
  Finally
    LStringList.Free;
  End;
end;

procedure SplitMethodKey(const AKey: String; out AUnit, AClass, AMethod: String);
Var
  LParts : TArray<String>;
Begin
  LParts := AKey.Split(['::']);
  Case Length(LParts) Of
    1: Begin AUnit := LParts[0]; AClass := ''; AMethod := ''; End;
    2: Begin AUnit := LParts[0]; AClass := ''; AMethod := LParts[1]; End;
  Else
    AUnit   := LParts[0];
    AClass  := LParts[1];
    AMethod := LParts[2];
  End;
End;

function SaveLeaksCSV(const AConnection: TUniConnection; const AConnID, APid, AMnuAceKey, AStamp: String): Integer;
Var
  LStringList : TStringList;
  LAllocPair  : TPair<string, Integer>;
  LFileName   : String;
  LHasLeaks   : Boolean;
  LUnit, LClass, LMethod : String;
begin
  Result := 0;
  If (AllocMap = Nil) Or (AllocMap.Count = 0) Then
    Exit;

  GProfilerLock.Enter;
  try
    LHasLeaks := False;
    For LAllocPair In AllocMap Do
      If LAllocPair.Value <> 0 Then
      Begin
        LHasLeaks := True;
        Break;
      End;
  finally
    GProfilerLock.Leave;
  end;

  If Not LHasLeaks Then
    Exit;

  LStringList := TStringList.Create;
  Try
    LStringList.Add('PID;CONID;MNUKEY;Unit;Class;Method;VarName;Balance');
    GProfilerLock.Enter;
    try
      For LAllocPair In AllocMap Do
        If LAllocPair.Value <> 0 Then
        Begin
          SplitMethodKey(LAllocPair.Key.Split(['|'])[0], LUnit, LClass, LMethod);
          LStringList.Add(
            APid + ';' + AConnID + ';' + AMnuAceKey + ';' +
            LUnit + ';' + LClass + ';' + LMethod + ';' +
            LAllocPair.Key.Split(['|'])[1] + ';' +
            LAllocPair.Value.ToString
          );
        End;
    finally
      GProfilerLock.Leave;
    end;

    LFileName := ProfilerDirectory + '\' + Format('ProfilerLeaks_%s.csv', [AStamp]);
    LStringList.SaveToFile(LFileName, TEncoding.UTF8);
    Result := LStringList.Count;
    InsertProfilerQueue(LFileName, AConnection);
  Finally
    LStringList.Free;
  End;
end;

function DumpStats(const AConnection : TUniConnection; const AConnID, APid, AMnuAceKey : String): String;
Var
  LStamp : String;
  LRows  : Integer;
begin
  Try
    if ((Stats = Nil) or (Stats.Count = 0)) And
       ((MemoryLog = Nil) or (MemoryLog.Count = 0)) And
       ((AllocMap = Nil) or (AllocMap.Count = 0)) Then
    Begin
      Result := 'Sem informacoes';
      Exit;
    End;

    CreateProfilerDirectory;
    If Not DirectoryExists(ProfilerDirectory) Then
      Exit;

    LStamp := FormatDateTime('yyyy-mm-dd_HH-nn-ss', Now());
    LRows  := 0;
    Inc(LRows, SaveTimingCSV(AConnection, AConnID, APid, AMnuAceKey, LStamp));
    Inc(LRows, SaveMemoryCSV(AConnection, AConnID, APid, AMnuAceKey, LStamp));
    Inc(LRows, SaveLeaksCSV(AConnection, AConnID, APid, AMnuAceKey, LStamp));
    CallProfilerImporter;
    Result := IntToStr(LRows) + ' registros salvos...';
  Except
    On E: Exception Do
      Result := 'DumpStats: ' + E.Message; //Não deve registrar nenhum erro ou log (profiler)
  End;
end;

procedure CallProfilerImporter;
Var
  LImporterPath : String;
  LStartupInfo  : TStartupInfo;
  LProcessInfo  : TProcessInformation;
begin
  LImporterPath := ExtractFilePath(ParamStr(0)) + 'ProfilerImporter.exe';
  If Not FileExists(LImporterPath) Then
    Exit;
  FillChar(LStartupInfo, SizeOf(LStartupInfo), 0);
  LStartupInfo.cb          := SizeOf(LStartupInfo);
  LStartupInfo.dwFlags     := STARTF_USESHOWWINDOW Or STARTF_FORCEOFFFEEDBACK;
  LStartupInfo.wShowWindow := SW_HIDE;
  FillChar(LProcessInfo, SizeOf(LProcessInfo), 0);
  If CreateProcess(nil, PChar(LImporterPath), nil, nil, False,
                   CREATE_NO_WINDOW, nil, nil, LStartupInfo, LProcessInfo) Then
  Begin
    CloseHandle(LProcessInfo.hThread);
    CloseHandle(LProcessInfo.hProcess);
  End;
end;

function MicroToSecondsStr(const AMicro : Int64) : String;
begin
  Result := FormatFloat(
              '0.000000',
              AMicro * 1e-6,
              TFormatSettings.Invariant
            );
end;

function fCriaQuery(const AOwner: TComponent; const Conexao: TUniConnection) : TUniQuery;
begin
  Result := TUniQuery.Create(AOwner);
  Result.Connection := Conexao;
  Result.Tag := Result.Connection.Tag;
  Result.Options.RequiredFields := False;
end;

procedure CreateProfilerDirectory;
  Var
    strDirectory : String;
begin
  strDirectory := ProfilerDirectory;
  If Not DirectoryExists(strDirectory) Then
    ForceDirectories(strDirectory);
end;

function ProfilerDirectory : String;
begin
  Result := ExtractFilePath(ParamStr(0)) + '\profiler_data';
end;

procedure InsertProfilerQueue(const AFileName : String; const AConnection: TUniConnection);
  Var
    LQuery : TUniQuery;
begin
  LQuery := fCriaQuery(Nil, AConnection);
  Try
    LQuery.SQL.Text := 'INSERT INTO profiler_queue (file_path) VALUES (:file_path)';
    LQuery.ParamByName('file_path').AsString := AFileName;
    LQuery.ExecSQL;
  Finally
    FreeAndNil(LQuery);
  End;
end;

procedure pInitProfilerUser(const AOperadorLogado : String; const AConnection: TUniConnection);
  Var
    LOperador : TUniQuery;
begin
  VS_TrackTiming := False;
  VS_TrackMemory := False;
  VS_TrackLeaks  := False;
  If Trim(AOperadorLogado) = '' Then
    Exit;
  If AConnection = Nil Then
    Exit;
  LOperador := fCriaQuery(Nil, AConnection);
  Try
    Try
      LOperador.SQL.Text := 'SELECT OPE_PFLTIM, OPE_PFLMEM, OPE_PFLLKS FROM CADOPE WHERE OPE_CODOPE = :CODOPE';
      LOperador.ParamByName('CODOPE').AsString := AOperadorLogado;
      LOperador.Open;
      If LOperador.IsEmpty Then
        Exit;
      VS_TrackTiming := (LOperador.FieldByName('OPE_PFLTIM').AsString = 'S');
      VS_TrackMemory := (LOperador.FieldByName('OPE_PFLMEM').AsString = 'S');
      VS_TrackLeaks := (LOperador.FieldByName('OPE_PFLLKS').AsString = 'S');
      If (VS_TrackTiming) Or
         (VS_TrackMemory) Or
         (VS_TrackLeaks) Then
        InitProfiler;
    Except
      Exit;
    End;
  Finally
    FreeAndNil(LOperador);
  End;
end;

initialization
  VS_TrackTiming := False;
  VS_TrackMemory := False;
  VS_TrackLeaks  := False;
  GProfilerLock  := TCriticalSection.Create;

finalization
  GProfilerActive := False;
  FreeAndNil(Stats);
  FreeAndNil(MemoryLog);
  FreeAndNil(AllocMap);
  if CallStack <> nil then
  begin
    CallStack.Free;
    CallStack := nil;
  end;
  FreeAndNil(GProfilerLock);

end.
