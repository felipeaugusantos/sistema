unit untEnviarRegistrosFusion;

interface

uses
  Winapi.Windows, Forms, System.Classes, System.SysUtils, Dialogs, System.UITypes,
  System.strUtils;

  procedure pEnviarRegistros;

implementation

uses
  untFuncoesSimples, untUtilMonitor, untLogAut, untTEnviaRegistrosFusion;

function fEncerrarSemExecutar:Boolean;
begin
  Result := False;

  If (fConexaoAtiva) Then
    If (fCfgSis('LXRBSL', varString) = 'S') Then
      Result := True;
end;

procedure pMensagemErroLocal(strMessage: String);
begin
  if (fConexaoAtiva) then
    pMensagensErro(strMessage,'')
  else
    MessageDlg(strMessage, mtError, [mbOK], 0);
end;

procedure pEnviarRegistros;
begin
  try
    try
      pDefinirEmpresa;
      pConectarModulos;
      pDefinirUsuario;
      pIniciarVariaveis;
      fAjustaDataSistema;
    except
      on E: Exception Do
      begin
        pMensagemErroLocal(E.Message);
        Exit;
      end;
    end;

    if (fEncerrarSemExecutar) then
      Exit;

    try
      TLogAut.New().pLogin();

      if TUtilMonitor.fLockMonitor(spIdMonitorEnviaRegFusion, VS_strLockMonitorEnviaRegFusion) then
      begin
        try
          TMonitor.New()
            .IdMonitor(spIdMonitorEnviaRegFusion)
            .TimeLimit(spTimeLimitMonitorEnviaRegFusion)
            .LockMonitor(VS_strLockMonitorEnviaRegFusion)
            .ProcedureExec(TEnviaRegistrosFusion.New())
            .pStart();
        except
          on E: Exception do
          begin
            pMensagemErroLocal(E.Message);
            Exit;
          end;
        end;
      end;
    finally
      TUtilMonitor.fRemoveLockMonitor(spIdMonitorEnviaRegFusion);
      TLogAut.New().pLogout();
      pFinalizarModulos;
    end;
  finally
    if (not TerminateProcess(GetCurrentProcess, 0)) then
      Application.Terminate;
  end;
end;

end.
