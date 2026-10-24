unit Services.Processa.CobrancaEletronica;

interface

uses
  System.Classes, System.SysUtils, System.UITypes, Services.Core.Utils,
  Services.Core.Settings, Services.Core.Connection.Manager,
  Services.Core.Task.Monitor, Services.Core.Task.Lock;

type
  TProcessarLinkPagamento = class sealed(TInterfacedObject, ITaskMonitorProcedure)
  private
  public
    procedure pExecute;
    procedure pExecuteAll;
  end;

function ProcessarLinkPagamento(): Boolean;

implementation

uses
  PagamentoOnline.Api;

function ProcessarLinkPagamento(): Boolean;
Var
  LIdLock: String;
  LTask: TTaskMonitor;
begin
  Result := False;

  Try
    pIniciarConexao(False);
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
    LIdLock := spIdLinkPagamento;

    If Not fCfgSis('LINKPG', varBoolean) Then
    Begin
      Writeln(DateTimeToStr(Now()) +
        ' - Empresa configurada para não utilizar link de pagamento (' +
        VS_strCodEmp + ')');
      Exit;
    End;

    If HasParam('-f') Then
      TTaskLock.pDestravaLockForcado(Format(LIdLock, [VS_strCodEmp]), 0)
    Else
      TUtilTaskMonitor.pClearAttemptsLock(Format(LIdLock, [VS_strCodEmp]), spAttemptsLockAlpe);

    If TUtilTaskMonitor.fLockTaskMonitor(LIdLock, VS_strLockMonitorAudit) Then
    Begin
      Try
        LTask := TTaskMonitor.Create(LIdLock, NO_TIME_LIMIT,
          VS_strLockMonitorAudit, TProcessarLinkPagamento.Create());
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
    MainConnection.Disconnect;
  End;

end;

{ TProcessarLinkPagamento }

procedure TProcessarLinkPagamento.pExecute;
begin
  Raise Exception.Create('Utilize somente o método pExecuteAll');
end;

procedure TProcessarLinkPagamento.pExecuteAll;
{var
  ControllerAlpeSummaries : TControllerReceivablesSummaries;
  ControllerAlpeCreate    : TControllerCreateReceivablesCessions;
  ControllerAlpeBill      : TControllerBillReceivablesCessions;
  ControllerAlpeCancel    : TControllerCancelReceivablesCessions;}
begin
  {ControllerAlpeSummaries := TControllerReceivablesSummaries.Create;
  ControllerAlpeCreate    := TControllerCreateReceivablesCessions.Create;
  ControllerAlpeBill      := TControllerBillReceivablesCessions.Create;
  ControllerAlpeCancel    := TControllerCancelReceivablesCessions.Create;
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
  end;}
end;

end.
