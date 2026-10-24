unit Services.Processa.Cobranca.Eletronica;

interface

uses
  System.Classes, System.SysUtils, System.UITypes, Services.Core.Utils,
  Services.Core.Settings, Services.Core.Connection.Manager,
  Services.Core.Task.Monitor, Services.Core.Task.Lock;

type
  TProcessarCobrancaEletronica = class sealed(TInterfacedObject, ITaskMonitorProcedure)
  private
  public
    procedure pExecute;
    procedure pExecuteAll;
  end;

function ProcessarCobrancaEletronica: Boolean;

implementation

uses
  CobrancaEletronica.Controller.PagarMe, CobrancaEletronica.Lib.Types;

function ProcessarCobrancaEletronica: Boolean;
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
      LIdLock := SP_COBRANCA_ELETRONICA;

      If HasParam('-f') Then
        TTaskLock.pDestravaLockForcado(Format(LIdLock, [VS_strCodEmp]), 0)
      Else
        TUtilTaskMonitor.pClearAttemptsLock(Format(LIdLock, [VS_strCodEmp]), SP_ATTEMPTS_LOCK);

      If TUtilTaskMonitor.fLockTaskMonitor(LIdLock, VS_strLockMonitorAudit) Then
      Begin
        Try
          LTask := TTaskMonitor.Create(LIdLock, NO_TIME_LIMIT,
            VS_strLockMonitorAudit, TProcessarCobrancaEletronica.Create());
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
      Writeln(DateTimeToStr(nOw()) + ' - ' + 'Encerrando servico ...');
      TUtilTaskMonitor.fRemoveLockTaskMonitor(LIdLock);
    End;
  Finally
    objConnectionsManager.EndConnection;
  End;
end;

{ TProcessarCobrancaEletronica }

procedure TProcessarCobrancaEletronica.pExecute;
begin
  Raise Exception.Create('Utilize somente o método pExecuteAll');
end;

procedure TProcessarCobrancaEletronica.pExecuteAll;
begin
  TControllerPagarMe.New
    .fProcessarLinksCancelados
    .fProcessarGerarNovosLinksPagamento
    .fProcessarFormaCobrancaLinks
    .fProcessarPagamentoLinks
    .fProcessarPedidosCancelados
    .fProcessarLinksPagamentoExpirados
    .Free;
end;

end.
