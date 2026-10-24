unit untAbrirQuery;

interface

uses
  Uni, Classes, SyncObjs, SysUtils, Windows;

type
  TAbrirQuery = class(TInterfacedObject)
  private
    class var lstThreads: TStringList;
    class var criticalSection: TCriticalSection;
  public
    class function AbrirQueryAssincrono(const qryGen: TUniQuery; const blnCancelar: Boolean): Boolean; overload;
    class function AbrirQueryAssincrono(const qryGen: TUniQuery): TThread; overload;
    class procedure CancelarAbrirQueryAssincrono(const qryGen: TUniQuery; const blnFreeQuery: Boolean);
    class procedure CancelarTodos(const blnFreeQuery: Boolean);
  end;

implementation

uses
  untThreadAbrirQuery;

{ TOpenQuery }

class function TAbrirQuery.AbrirQueryAssincrono(const qryGen: TUniQuery; const blnCancelar: Boolean): Boolean;
var
  intIndex: Integer;
  threadAbrirQuery: TThreadAbrirQuery;
begin
  Result := False;
  Try
    Try
      criticalSection.Enter;
      if not Assigned(TAbrirQuery.lstThreads) then
      begin
        TAbrirQuery.lstThreads := TStringList.Create;
        TAbrirQuery.lstThreads.Sorted := True;
      end;

      intIndex := lstThreads.IndexOf(IntToStr(Integer(qryGen)));

      if intIndex < 0 then
      begin
        threadAbrirQuery := TThreadAbrirQuery.Create(qryGen);
        lstThreads.AddObject(IntToStr(Integer(qryGen)), threadAbrirQuery);
      end
      else
      begin
        threadAbrirQuery := TThreadAbrirQuery(lstThreads.Objects[intIndex]);
      end;

      if blnCancelar then
      begin
        threadAbrirQuery.Terminate;
        TerminateThread(threadAbrirQuery.Handle, 0);
      end;

      Result := threadAbrirQuery.Terminated;

      if Result then
      begin
        if Assigned(threadAbrirQuery) then
        begin
          lstThreads.Delete(lstThreads.IndexOf(IntToStr(Integer(qryGen))));
          FreeAndNil(threadAbrirQuery);
        end;
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    criticalSection.Leave;
  End;
end;

class function TAbrirQuery.AbrirQueryAssincrono(const qryGen: TUniQuery): TThread;
var
  intIndex: Integer;
  threadAbrirQuery: TThreadAbrirQuery;
begin
  Result := nil;
  Try
    Try
      criticalSection.Enter;
      if not Assigned(TAbrirQuery.lstThreads) then
      begin
        TAbrirQuery.lstThreads := TStringList.Create;
        TAbrirQuery.lstThreads.Sorted := True;
      end;

      intIndex := lstThreads.IndexOf(IntToStr(Integer(qryGen)));

      if intIndex < 0 then
      begin
        threadAbrirQuery := TThreadAbrirQuery.Create(qryGen);
        lstThreads.AddObject(IntToStr(Integer(qryGen)), threadAbrirQuery);
      end
      else
      begin
        threadAbrirQuery := TThreadAbrirQuery(lstThreads.Objects[intIndex]);
      end;
      
      Result := threadAbrirQuery;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    criticalSection.Leave;
  End;
end;

class procedure TAbrirQuery.CancelarAbrirQueryAssincrono(const qryGen: TUniQuery; const blnFreeQuery: Boolean);
var
  intIndex: Integer;
  threadAbrirQuery: TThreadAbrirQuery;
begin
  Try
    Try
      criticalSection.Enter;
      if not Assigned(TAbrirQuery.lstThreads) then
      begin
        TAbrirQuery.lstThreads := TStringList.Create;
        TAbrirQuery.lstThreads.Sorted := True;
      end;

      intIndex := lstThreads.IndexOf(IntToStr(Integer(qryGen)));

      if intIndex >= 0 then
      begin
        threadAbrirQuery := TThreadAbrirQuery(lstThreads.Objects[intIndex]);
        threadAbrirQuery.OnTerminate := nil;
        threadAbrirQuery.Terminate;
        TerminateThread(threadAbrirQuery.Handle, 0);
        threadAbrirQuery.WaitFor;
        if blnFreeQuery then
        begin
          Try
            threadAbrirQuery.DataSet.Free;
          Except
          End;
        end;

        lstThreads.Delete(intIndex);
        FreeAndNil(threadAbrirQuery);
      end;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    criticalSection.Leave;
  End;
end;

class procedure TAbrirQuery.CancelarTodos(const blnFreeQuery: Boolean);
var
  threadAbrirQuery: TThreadAbrirQuery;
begin
  Try
    Try
      if not Assigned(TAbrirQuery.lstThreads) then
        Exit;

      while lstThreads.Count > 0 do
      begin
        criticalSection.Enter;
        threadAbrirQuery := TThreadAbrirQuery(lstThreads.Objects[0]);
        threadAbrirQuery.OnTerminate := nil;
        threadAbrirQuery.Terminate;
        TerminateThread(threadAbrirQuery.Handle, 0);
        threadAbrirQuery.WaitFor;
        if blnFreeQuery then
        begin
          Try
            threadAbrirQuery.DataSet.Free;
          Except
          End;
        end;
        lstThreads.Delete(0);
        FreeAndNil(threadAbrirQuery);
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    criticalSection.Leave;
  End;
end;

initialization
  TAbrirQuery.lstThreads := nil;
  TAbrirQuery.criticalSection := TCriticalSection.Create;

finalization
  TAbrirQuery.CancelarTodos(True);
  if Assigned(TAbrirQuery.lstThreads) then FreeAndNil(TAbrirQuery.lstThreads);
  if Assigned(TAbrirQuery.criticalSection) then FreeAndNil(TAbrirQuery.criticalSection);

end.
