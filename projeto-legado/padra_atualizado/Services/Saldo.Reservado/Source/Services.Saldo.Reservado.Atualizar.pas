unit Services.Saldo.Reservado.Atualizar;

interface

uses
{$I '..\..\..\core\services.core.uses.inc'}, System.Classes, System.SysUtils,
  System.UITypes, untTFatReservaSaldo;

function AtualizarSaldoReservado(): Boolean;

implementation

uses
  untLogAut;

const
  NO_TIME_LIMIT = 0;

function AtualizarSaldoReservado(): Boolean;
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
      pCriarReservaAnalitico;
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
        LIdLock := spIdMonitorAudit + IIF(not fEmptyStr(GetParamValue('-t')), '_' + GetParamValue('-t'), '');

        If HasParam('-f') Then
          TTaskLock.pDestravaLockForcado(Format(LIdLock, [VS_strCodEmp]), 0);

        If TUtilTaskMonitor.fLockTaskMonitor(LIdLock, VS_strLockMonitorAudit) Then
        Begin
          Try
            LTask := TTaskMonitor.Create(LIdLock, NO_TIME_LIMIT,
              VS_strLockMonitorAudit, TAuditoriaReserva.New());
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
