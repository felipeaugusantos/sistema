unit Services.Entrega.Futura.Atualizar;

interface

uses
  System.Classes, System.SysUtils, System.UITypes,
  {$I '..\..\..\core\services.core.uses.inc'};

function AtualizarEntregaFutura(): Boolean;

implementation

uses untIFatEntregaFutura, untTFatEntregaFutura, untLogAut;

const
  NO_TIME_LIMIT = 0;

function AtualizarEntregaFutura(): Boolean;
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
      TLogAut.New().pLogin();
      Try
        LIdLock := spIdMonitorEntFut;

        If Not fCfgSis('ENTFUT', varBoolean) Then
        Begin
          Writeln(DateTimeToStr(fNow) +
            ' - Empresa configurada para não utilizar entrega futura (' +
            VS_strCodEmp + ')');
          Exit;
        End;

        If HasParam('-f') Then
          TTaskLock.pDestravaLockForcado(Format(LIdLock, [VS_strCodEmp]), 0);

        If TUtilTaskMonitor.fLockTaskMonitor(LIdLock, VS_strLockMonitorAudit) Then
        Begin
          Try
            LTask := TTaskMonitor.Create(LIdLock, NO_TIME_LIMIT,
              VS_strLockMonitorAudit, TAuditoriaEF.New());
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
        TLogAut.New().pLogout();
      End;

    Finally
      Writeln(DateTimeToStr(fNow) + ' - ' + 'Encerrando servico ...');
      TUtilTaskMonitor.fRemoveLockTaskMonitor(LIdLock);
    End;
  Finally
    objConnectionsManager.EndConnection;
  End;
end;

end.
