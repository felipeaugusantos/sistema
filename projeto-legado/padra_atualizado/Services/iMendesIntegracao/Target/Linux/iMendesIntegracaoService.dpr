  program iMendesIntegracaoService;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  {$region}
  Services.Core.Cache in '..\..\..\Core\Services.Core.Cache.pas',
  Services.Core.Connection.Interfaces in '..\..\..\Core\Services.Core.Connection.Interfaces.pas',
  Services.Core.Connection.Manager in '..\..\..\Core\Services.Core.Connection.Manager.pas',
  Services.Core.Connection.UniDac in '..\..\..\Core\Services.Core.Connection.UniDac.pas',
  Services.Core.Settings in '..\..\..\Core\Services.Core.Settings.pas',
  Services.Core.Task.Lock in '..\..\..\Core\Services.Core.Task.Lock.pas',
  Services.Core.Task.Monitor in '..\..\..\Core\Services.Core.Task.Monitor.pas',
  Services.Core.Types in '..\..\..\Core\Services.Core.Types.pas',
  Services.Core.Utils in '..\..\..\Core\Services.Core.Utils.pas',
  Services.Core.Rest in '..\..\..\Core\Services.Core.Rest.pas',
  {$endregion}
  System.SysUtils,
  System.DateUtils,
  Posix.Signal,
  untTypesSistema in '..\..\..\..\fontes\genericos\untTypesSistema.pas',
  iMendes.TProcessamentoExterno in '..\..\..\..\iMendesIntegra\iMendes.TProcessamentoExterno.pas',
  iMendes.Comunicador in '..\..\..\..\fontes\util\operacoesrefitens\Saneamento\iMendes.Comunicador.pas',
  iMendes.Constantes in '..\..\..\..\fontes\util\operacoesrefitens\Saneamento\iMendes.Constantes.pas',
  iMendes.GerenciaEstado in '..\..\..\..\fontes\util\operacoesrefitens\Saneamento\iMendes.GerenciaEstado.pas',
  iMendes.Threads in '..\..\..\..\fontes\util\operacoesrefitens\Saneamento\iMendes.Threads.pas',
  iMendes.Functions in '..\..\..\..\fontes\util\operacoesrefitens\Saneamento\iMendes.Functions.pas',
  iMendes.Types in '..\..\..\..\fontes\util\operacoesrefitens\Saneamento\iMendes.Types.pas',
  iMendes.ProcessaAlterados in '..\..\..\..\fontes\util\operacoesrefitens\Saneamento\iMendes.ProcessaAlterados.pas';

procedure OnExitProcessSignal(SIGNUM: Integer);
begin
  WriteLog('Exit Process Signal (SIGNUM ' + IntToStr(SIGNUM) + ')...', True);
  VS_ExitProcessSignal := True;
  Halt;
end;

procedure RunService;
var
  LLastLog: TDateTime;
  ProcessamentoExterno: TProcessamentoExterno;
begin
  while not VS_ExitProcessSignal do
  Begin
    try
      objConnectionsManager := nil;
      Try
        pEscreveLog('Inciando conexão...', True);
        pIniciarConexao;
        pEscreveLog('Definindo empresa...', True);
        pDefinirEmpresa;
        pEscreveLog('Definindo Usuario...', True);
        pDefinirUsuario;
        pEscreveLog('iniciando variaveis de ambiente...', True);
        pIniciarVariaveis;
        blnNotificaExecucao := True;
        blnControlaTempoExecucao := False;
        imendes.Types.ContadorDeRequisicaoAtivado := fContadorDeRequisicaoAtivado;
        try
          LLastLog := VS_Date;
          iMendes.Types.IDUnicoExeImendesIntegra := GetNewID('IMENDES');
          while Not VS_ExitProcessSignal do
          begin
            ProcessamentoExterno := TProcessamentoExterno.Create(nil);
            try
              if not ProcessamentoExterno.fLocalizaPendencias then
              Begin
                if SecondsBetween(fNow, LLastLog) >= 30 then
                begin
                  WriteLog('Nenhuma pendencia para processar. Aguardando ...', True);
                  LLastLog := fNow;
                end;
                Sleep(1000);
              end
              else
              Begin
                blnNotificaExecucao := True;
                pIniciaNotificacaoTemporizada;              
                ProcessamentoExterno.ProcessaPendencias;
              End;
            finally
              blnNotificaExecucao := False;
              FreeAndNil(ProcessamentoExterno);
            end
          end;
        except
          on E: Exception Do
          Begin
            pEscreveLog('Falha durante execução de pendencias: ' + E.Message, True);
            blnNotificaExecucao := False;
            raise Exception.Create(e.message);

          End;
        end;
      finally
        blnNotificaExecucao := False;
        if Assigned(objConnectionsManager) then
          objConnectionsManager.EndConnection;
      end;
    Except
      on E: Exception Do
      Begin
        pEscreveLog('Falha na ultima execução: ' + E.Message, True);
        blnNotificaExecucao := False;

      End;
    end;
  End;
end;

begin
  Signal(SIGINT, @OnExitProcessSignal);
  FormatSettings := TFormatSettings.Create('pt-BR');
  try
    WriteLog('Iniciando iMendes Integracao ...  ', True, 60);
    RunService;
    WriteLog('Finalizando iMendes Integracao Service ...', True, 60);
  except
    on E: Exception do
      pEscreveLog('Falha Geral: ' + E.Message);
  end;
end.
