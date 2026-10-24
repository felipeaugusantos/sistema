unit untRomaneioIntegFusion;

interface

uses
  Winapi.Windows, Forms, System.Classes, System.SysUtils, Dialogs, System.UITypes,
  System.strUtils;

  procedure pRomaneioIntegFusion;

implementation

uses
  untFuncoesSimples, untUtilMonitor, untLogAut, untTObtemRomaneioIntegFusion;

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

procedure pRomaneioIntegFusion;
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

      if TUtilMonitor.fLockMonitor(spIdMonitorRomaneioIntegFusion, VS_strLockMonitorRomaneioIntegFusion) then
      begin
        try
          TMonitor.New()
            .IdMonitor(spIdMonitorRomaneioIntegFusion)
            .TimeLimit(spTimeLimitMonitorRomaneioIntegFusion)
            .LockMonitor(VS_strLockMonitorRomaneioIntegFusion)
            .ProcedureExec(TObtemRomaneioIntegFusion.New())
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
      TUtilMonitor.fRemoveLockMonitor(spIdMonitorRomaneioIntegFusion);
      TLogAut.New().pLogout();
      pFinalizarModulos;
    end;
  finally
    if (not TerminateProcess(GetCurrentProcess, 0)) then
      Application.Terminate;
  end;
end;

end.
