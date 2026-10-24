unit Services.Status.Pedido.Atualizar;

interface

uses
{$I '..\..\..\core\services.core.uses.inc'},
  System.Classes, System.SysUtils, System.UITypes, untTSituacaoPedidoVenda;

function AtualizarStatusPedido(): Boolean;

implementation

uses
  untLogAut;

const
  NO_TIME_LIMIT = 0;

function AtualizarStatusPedido(): Boolean;
Var
  LIdLock: String;
  LTask: TTaskMonitor;
begin
  Result := False;
  Try
    pIniciarConexao;
  Except
    On E: Exception Do
    Begin
      Writeln(E.Message);
      Exit;
    End;
  End;
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

    TRepositoryStatus.New.pCheck;

    Try
      TLogAut.New().pLogin();
      Try
        LIdLock := spIdMonitorStatus;

        If Not fCfgSis('EXISTA', varBoolean) Then
        Begin
          Writeln(DateTimeToStr(fNow) +
            ' - Empresa configurada para nao utilizar status do pedido (' +
            VS_strCodEmp + ')');
          Exit;
        End;

        If HasParam('-f') Then
          TTaskLock.pDestravaLockForcado(Format(LIdLock, [VS_strCodEmp]), 0);

        If TUtilTaskMonitor.fLockTaskMonitor(LIdLock, VS_strLockMonitorStatus) Then
        Begin
          Try
            LTask := TTaskMonitor.Create(LIdLock, NO_TIME_LIMIT,
              VS_strLockMonitorStatus, TUpdateStatus.New());
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
