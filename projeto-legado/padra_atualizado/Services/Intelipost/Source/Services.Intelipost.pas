unit Services.Intelipost;

interface

uses
{$I '..\..\..\core\services.core.uses.inc'}, System.Classes, System.SysUtils,
  System.UITypes;

function fIntelipost(): Boolean;

implementation

uses untProcessaIntelipost;

var
  VS_strLockMonitorAudit: string;

function fIntelipost(): Boolean;
Var
  LIdLock: String;
  LTask: TTaskMonitor;
begin
  Result := False;

  pIniciarConexao;
  Try
    Try
      pDefinirEmpresa;
      pDefinirUsuario;
      pIniciarVariaveis;
    Except
      On E: Exception Do
      Begin
        Writeln(DateTimeToStr(fNow) + ' - ' + E.ClassName, ': ', E.Message);
        Exit;
      End;
    End;

    Try
      LIdLock := spIdIntelipost;

      If HasParam('-f') Then
        TTaskLock.pDestravaLockForcado(Format(LIdLock, [VS_strCodEmp]), 0)
      Else
        TUtilTaskMonitor.pClearAttemptsLock(Format(LIdLock, [VS_strCodEmp]),
          spAttemptsLockIntelipost);

      If TUtilTaskMonitor.fLockTaskMonitor(LIdLock, VS_strLockMonitorAudit) Then
      Begin
        Try
          LTask := TTaskMonitor.Create(LIdLock, NO_TIME_LIMIT,
            VS_strLockMonitorAudit, TIntelipost.Create());
          Try
            LTask.Start;
            While Not LTask.Finished Do
              Sleep(2000);
            Result := True;
          Finally
            FreeAndNil(LTask);
          End;
        Except
          On E: Exception Do
          Begin
            Writeln(DateTimeToStr(fNow) + ' - ' + E.ClassName, ': ', E.Message);
            Exit;
          End;
        End;
      End
      Else
        Writeln(DateTimeToStr(fNow) + ' - ' +
          'O servico ja esta sendo executado ... ');

    Finally
      Writeln(DateTimeToStr(fNow) + ' - ' + 'Encerrando servico ...');
      TUtilTaskMonitor.fRemoveLockTaskMonitor(LIdLock);
    End;
  Finally
    objConnectionsManager.EndConnection;
  End;

end;

end.
