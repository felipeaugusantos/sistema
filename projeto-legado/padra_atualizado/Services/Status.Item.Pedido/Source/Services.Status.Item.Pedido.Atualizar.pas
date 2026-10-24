unit Services.Status.Item.Pedido.Atualizar;

interface

uses
  {$I '..\..\..\core\services.core.uses.inc'},
  System.Classes, System.SysUtils, System.UITypes, untTSituacaoItemPedidoVenda;

function AtualizarStatusItemPedido(): Boolean;

implementation

uses
  untLogAut;

const
  NO_TIME_LIMIT = 0;

function AtualizarStatusItemPedido(): Boolean;
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
        Writeln(DateTimeToStr(Now()) + ' - ' + E.ClassName, ': ', E.Message);
        Exit;
      End;
    End;

    Try
      TLogAut.New().pLogin();
      Try
        LIdLock := spIdMonitorStatusItem;

        If Not fCfgSis('EXISTA', varBoolean) Then
        Begin
          Writeln(DateTimeToStr(Now()) +
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
              VS_strLockMonitorStatus, TUpdateStatusItemPedido.New());
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
              Writeln(DateTimeToStr(Now()) + ' - ' + E.ClassName, ': ', E.Message);
              Exit;
            End;
          End;
        End
        Else
          Writeln(DateTimeToStr(Now()) + ' - ' +
            'O servico ja esta sendo executado ... ');
      Finally
        TLogAut.New().pLogout();
      End;

    Finally
      Writeln(DateTimeToStr(Now()) + ' - ' + 'Encerrando servico ...');
      TUtilTaskMonitor.fRemoveLockTaskMonitor(LIdLock);
    End;
  Finally
    objConnectionsManager.EndConnection;
  End;
end;

end.
