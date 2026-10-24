unit Services.Processa.Recebiveis.Alpe;

interface

uses
{$I '..\..\..\core\services.core.uses.inc'}, System.Classes, System.SysUtils,
  System.UITypes;

type
  TProcessarRecebiveisAlpe = class sealed(TInterfacedObject,
    ITaskMonitorProcedure)
  private
  public
    procedure pExecute;
    procedure pExecuteAll;
  end;

function ProcessarRecebiveisAlpe(): Boolean;

implementation

uses untAlpeBillReceivablesCessions, untAlpeCancelReceivablesCessions,
  untAlpeCreateReceivablesCessions, untAlpeReceivablesSummaries;

function ProcessarRecebiveisAlpe(): Boolean;
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
      LIdLock := spIdRecebiveisAlpe;

      If HasParam('-f') Then
        TTaskLock.pDestravaLockForcado(Format(LIdLock, [VS_strCodEmp]), 0)
      Else
        TUtilTaskMonitor.pClearAttemptsLock(Format(LIdLock, [VS_strCodEmp]),
          spAttemptsLockAlpe);

      If TUtilTaskMonitor.fLockTaskMonitor(LIdLock, VS_strLockMonitorAudit) Then
      Begin
        Try
          LTask := TTaskMonitor.Create(LIdLock, NO_TIME_LIMIT,
            VS_strLockMonitorAudit, TProcessarRecebiveisAlpe.Create());
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

{ TProcessarRecebiveisAlpe }

procedure TProcessarRecebiveisAlpe.pExecute;
begin
  Raise Exception.Create('Utilize somente o método pExecuteAll');
end;

procedure TProcessarRecebiveisAlpe.pExecuteAll;
var
  ControllerAlpeSummaries: TControllerReceivablesSummaries;
  ControllerAlpeCreate: TControllerCreateReceivablesCessions;
  ControllerAlpeBill: TControllerBillReceivablesCessions;
  ControllerAlpeCancel: TControllerCancelReceivablesCessions;
begin
  ControllerAlpeSummaries := TControllerReceivablesSummaries.Create;
  ControllerAlpeCreate := TControllerCreateReceivablesCessions.Create;
  ControllerAlpeBill := TControllerBillReceivablesCessions.Create;
  ControllerAlpeCancel := TControllerCancelReceivablesCessions.Create;
  try
    ControllerAlpeSummaries.pProcessarReceivablesSummaries;
    ControllerAlpeCreate.pProcessarCreateReceivablesCessions;
    ControllerAlpeBill.pProcessarBillReceivablesCessions;
    ControllerAlpeCancel.pProcessarBaixasCancelReceivablesCessions;
    ControllerAlpeCancel.pProcessarCancelReceivablesCessions;
  finally
    ControllerAlpeSummaries.Free;
    ControllerAlpeBill.Free;
    ControllerAlpeCreate.Free;
    ControllerAlpeCancel.Free;
  end;
end;

end.
