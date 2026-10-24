unit Services.Gestor.Equipe.Contele;

interface

uses
{$I '..\..\..\core\services.core.uses.inc'}, System.Classes, System.SysUtils,
  System.UITypes;

type
  TProcessarGestorEquipeContele = class sealed(TInterfacedObject,
    ITaskMonitorProcedure)
  private
  public
    procedure pExecute;
    procedure pExecuteAll;
  end;

function fProcessarGestorEquipeContele(): Boolean;

implementation

uses untContele.Pois;

function fProcessarGestorEquipeContele(): Boolean;
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
      LIdLock := spIdGestorEquipeContele;

      If HasParam('-f') Then
        TTaskLock.pDestravaLockForcado(Format(LIdLock, [VS_strCodEmp]), 0)
      Else
        TUtilTaskMonitor.pClearAttemptsLock(Format(LIdLock, [VS_strCodEmp]),
          spAttemptsLockGestorEquipeContele);

      If TUtilTaskMonitor.fLockTaskMonitor(LIdLock, VS_strLockMonitorAudit) Then
      Begin
        Try
          LTask := TTaskMonitor.Create(LIdLock, NO_TIME_LIMIT,
            VS_strLockMonitorAudit, TProcessarGestorEquipeContele.Create());
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

{ TProcessarGestorEquipeContele }

procedure TProcessarGestorEquipeContele.pExecute;
begin
  Raise Exception.Create('Utilize somente o método pExecuteAll');
end;

procedure TProcessarGestorEquipeContele.pExecuteAll;
var
  ControllerGestorDeEquipesContele: TControllerGestorDeEquipesContele;
begin
  ControllerGestorDeEquipesContele := TControllerGestorDeEquipesContele.Create;
  try
    ControllerGestorDeEquipesContele.pSincronizarClientes;
  finally
    ControllerGestorDeEquipesContele.Free;
  end;
end;

end.
