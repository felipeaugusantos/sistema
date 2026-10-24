unit Services.Pesquisa.Satisfacao;

interface

uses
{$I '..\..\..\core\services.core.uses.inc'}, System.Classes, System.SysUtils,
  System.UITypes;

type
  TPesquisaSatisfacaoTracksale = class sealed(TInterfacedObject,
    ITaskMonitorProcedure)
  private
  public
    procedure pExecute;
    procedure pExecuteAll;
  end;

function fPesquisaSatisfacaoTracksale(): Boolean;

implementation

uses untTracksale.Campaign.Dispatch;

function fPesquisaSatisfacaoTracksale(): Boolean;
Var
  LIdLock: String;
  LTask: TTaskMonitor;
begin
  Result := False;

  Try
    pIniciarConexao;
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
    LIdLock := spIdPesquisaSatisfacaoTracksale;

    If HasParam('-f') Then
      TTaskLock.pDestravaLockForcado(Format(LIdLock, [VS_strCodEmp]), 0)
    Else
      TUtilTaskMonitor.pClearAttemptsLock(Format(LIdLock, [VS_strCodEmp]),
        spAttemptsLockPesquisaSatisfacaoTracksale);

    If TUtilTaskMonitor.fLockTaskMonitor(LIdLock, VS_strLockMonitorAudit) Then
    Begin
      Try
        LTask := TTaskMonitor.Create(LIdLock, NO_TIME_LIMIT,
          VS_strLockMonitorAudit, TPesquisaSatisfacaoTracksale.Create());
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
    MainConnection.Disconnect;
  End;

end;

{ TPesquisaSatisfacaoTracksale }

procedure TPesquisaSatisfacaoTracksale.pExecute;
begin
  Raise Exception.Create('Utilize somente o método pExecuteAll');
end;

procedure TPesquisaSatisfacaoTracksale.pExecuteAll;
var
  ControllerTracksaleCampaignDispatch: TControllerTracksaleCampaignDispatch;
begin
  ControllerTracksaleCampaignDispatch := TControllerTracksaleCampaignDispatch.Create;
  try
    ControllerTracksaleCampaignDispatch.pDisparaPesquisaSatisfacao;
  finally
    ControllerTracksaleCampaignDispatch.Free;
  end;
end;

end.
