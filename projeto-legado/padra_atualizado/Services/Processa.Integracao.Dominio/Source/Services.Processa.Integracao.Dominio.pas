unit Services.Processa.Integracao.Dominio;

interface

uses
  System.Classes, System.SysUtils, System.UITypes, Services.Core.Utils,
  Services.Core.Settings, Services.Core.Connection.Manager,
  Services.Core.Task.Monitor, Services.Core.Task.Lock;

type
  TProcessarIntegracaoDominio = class sealed(TInterfacedObject, ITaskMonitorProcedure)
  private
  public
    procedure pExecute;
    procedure pExecuteAll;
    function fExecute : TResultExecute;
  end;

  function ProcessarIntegracaoDominio(): Boolean;

implementation

uses untLogAut, DominioSistemas.Infra.Config, DominioSistemas.Controller.Robo.Exec ;

var
  VS_strLockMonitor: String;

function ProcessarIntegracaoDominio(): Boolean;
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
        Writeln(DateTimeToStr(nOw()) + ' - ' + E.ClassName, ': ', E.Message);
        Exit;
      End;
    End;

    Try
      TLogAut.New().pLogin();
      Try
        LIdLock := ID_LOCK_LCKATC;

        If HasParam('-f') Then
          TTaskLock.pDestravaLockForcado(Format(LIdLock, [VS_strCodEmp]), 0)
        Else
          TUtilTaskMonitor.pClearAttemptsLock(Format(LIdLock, [VS_strCodEmp]), ATTEMPTSLOCKCITEL);

        If TUtilTaskMonitor.fLockTaskMonitor(LIdLock,  VS_strLockMonitor) Then
        Begin
          Try
            LTask := TTaskMonitor.Create(LIdLock, NO_TIME_LIMIT,
               VS_strLockMonitor, TProcessarIntegracaoDominio.Create());
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
              Writeln(DateTimeToStr(nOw()) + ' - ' + E.ClassName, ': ', E.Message);
              Exit;
            End;
          End;
        End
        Else
          Writeln(DateTimeToStr(nOw()) + ' - ' +
            'O servico ja esta sendo executado ... ');
      Finally
        TLogAut.New().pLogout();
      End;

    Finally
      Writeln(DateTimeToStr(nOw()) + ' - ' + 'Encerrando servico ...');
      TUtilTaskMonitor.fRemoveLockTaskMonitor(LIdLock);
    End;
  Finally
    objConnectionsManager.EndConnection;
  End;

end;

{ TProcessarIntegracaoDominio }

function TProcessarIntegracaoDominio.fExecute: TResultExecute;
begin
  FillChar(Result, SizeOf(Result), #0);
  Self.pExecute ;
end;

procedure TProcessarIntegracaoDominio.pExecute;
begin
  Raise Exception.Create('Utilize somente o método pExecuteAll');
end;

procedure TProcessarIntegracaoDominio.pExecuteAll;
var
  LControllerIntegracao : TControllerIntegracaoDominioExec;
  I: Integer;
begin
  LControllerIntegracao := TControllerIntegracaoDominioExec.Create;
  try
    LControllerIntegracao.pProcessarDocumentos;
    for I := 1 to 8 do
    begin
      if VS_ExitProcessSignal then
        Break;
      Sleep(15000);
      Writeln(DateTimeToStr(nOw()) + ' - ' + 'INFO: All good here...');
    end;
  finally
    LControllerIntegracao.Free;
  end;
end;

end.
