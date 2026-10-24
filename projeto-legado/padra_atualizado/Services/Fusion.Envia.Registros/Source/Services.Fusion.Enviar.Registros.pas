unit Services.Fusion.Enviar.Registros;

interface

uses
{$I '..\..\..\core\services.core.uses.inc'}, System.Classes, System.SysUtils,
  System.UITypes, untTEnviaRegistrosFusion, untTEnviaRegistrosFaturadosFusion;

function EnviarRegistros(): Boolean;
function fServico(): ITaskMonitorProcedure;
implementation

const
  NO_TIME_LIMIT = 0;

function EnviarRegistros(): Boolean;
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
      LIdLock := spIdMonitorEnviaRegFusion;

      If HasParam('-f') Then
        TTaskLock.pDestravaLockForcado(Format(LIdLock, [VS_strCodEmp]), 0);

      If TUtilTaskMonitor.fLockTaskMonitor(LIdLock, VS_strLockMonitorEnviaRegFusion) Then
      Begin
        Try
          LTask := TTaskMonitor.Create(LIdLock, NO_TIME_LIMIT,
            VS_strLockMonitorEnviaRegFusion, fServico);
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

function fServico: ITaskMonitorProcedure;
begin
  Result := nil;

  if VS_intOPCROM = 1 then
    Result := TEnviaRegistrosFusion.New()
  else if VS_intOPCROM = 2 then
    Result := TEnviaRegistrosFaturadosFusion.New();
end;

end.
