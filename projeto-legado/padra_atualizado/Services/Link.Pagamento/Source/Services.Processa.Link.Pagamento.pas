unit Services.Processa.Link.Pagamento;

interface

uses
  System.Classes, System.SysUtils, System.UITypes, Services.Core.Utils,
  Services.Core.Settings, Services.Core.Connection.Manager, Services.Core.Types,
  Services.Core.Task.Monitor, Services.Core.Task.Lock,
  Services.Core.Connection.Interfaces, untInterfaceLinkPagamentoCitel;

type
  TProcessarLinkPagamento = class sealed(TInterfacedObject, ITaskMonitorProcedure)
  private
    FInfo: TInfoLinkPagamentoExec ;
  public
    constructor Create(const AInfo: TInfoLinkPagamentoExec) ; reintroduce ;
    procedure pExecute;
    procedure pExecuteAll;
    function fExecute : TResultExecute;
  end;

function ProcessarLinkPagamento(): Boolean;

implementation

uses untLinkPagamentoCitelRetorno, Data.DB;

procedure pDestravaRobosAntigos();
var
  LId: string;
  LConsulta: {$IFDEF LINUX} IQuery {$ELSE } TDataset {$ENDIF LINUX};
  LNomeAntigo: string;
begin
  LConsulta := TApplicationContext.fGetEmpresasRoboAntigo;
  try
    LConsulta.First;
    while not LConsulta.Eof do
    begin
      LNomeAntigo := Format('LINK_PAGTO_ONLINE_CITEL_%s', [LConsulta.FieldByName('SIS_CODEMP').AsString]);
      LId := TTaskLock.fGetIdConnectionLock(LNomeAntigo);
      if Trim(LId) <> EmptyStr then
      begin
        pDestravaLCKATC(LNomeAntigo, LId);
      end;
      LConsulta.Next;
    end;
  finally
    {$IFNDEF LINUX}
      FreeAndNil(LConsulta);
    {$ENDIF LINUX};
  end;
end;

function ProcessarLinkPagamento(): Boolean;
Var
  LIdLock: String;
  LTask: TTaskMonitor;
  LInfo: TInfoLinkPagamentoExec;
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
        LIdLock := TApplicationContext.fStrNomeDoRobo;

        If HasParam('-f') Then
        begin
          Try
            pDestravaRobosAntigos();
          Except
            On E: Exception Do
              Writeln(DateTimeToStr(nOw()) + ' - pDestravaRobosAntigos: ' +
                E.ClassName + ': ' + E.Message);
          End;
          TTaskLock.pDestravaLockForcado(LIdLock, 0);
        end
        Else
          TUtilTaskMonitor.pClearAttemptsLock(LIdLock, spAttemptsLockCitel);

      If TUtilTaskMonitor.fLockTaskMonitor(LIdLock, VS_strLockMonitorAudit) Then
      Begin

        LInfo.TabelaSitDocExist := fTabelaExiste('SITDOC') ;

        Try
          LTask := TTaskMonitor.Create(LIdLock, NO_TIME_LIMIT,
            VS_strLockMonitorAudit, TProcessarLinkPagamento.Create(LInfo));
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

{ TProcessarLinkPagamento }

constructor TProcessarLinkPagamento.Create(const AInfo: TInfoLinkPagamentoExec);
begin
  FInfo := AInfo ;
end;

function TProcessarLinkPagamento.fExecute: TResultExecute;
begin
  FillChar(Result, SizeOf(Result), #0);
  Self.pExecute ;
end;

procedure TProcessarLinkPagamento.pExecute;
begin
  Raise Exception.Create('Utilize somente o método pExecuteAll');
end;

procedure TProcessarLinkPagamento.pExecuteAll;
var
  ControllerPagamentoOnline : TController_Recebimento;
begin
  ControllerPagamentoOnline := TController_Recebimento.Create;
  try
    ControllerPagamentoOnline.pProcessarRecebimentos(FInfo);
  finally
    ControllerPagamentoOnline.Free;
  end;
end;

end.
