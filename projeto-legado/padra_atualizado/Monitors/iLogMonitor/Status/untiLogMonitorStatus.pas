unit untiLogMonitorStatus;

interface

uses
  Winapi.Windows, Forms, System.Classes, System.SysUtils, Dialogs, System.UITypes;

  procedure iLogMonitorar;

implementation

uses
  untFuncoesSimples, untUtilMonitor, untLogAut, untFatRomaneioiLogMonitorStatus;

procedure iLogMonitorar;
begin
  Try
    Try
      pDefinirEmpresa;
      pConectarModulos;
      pDefinirUsuario;
      pIniciarVariaveis;
      fAjustaDataSistema;

      untFatRomaneioiLogMonitorStatus.Token := fCfgSis('TOKILO', varString);
      untFatRomaneioiLogMonitorStatus.Tempo := fCfgSis('TEMILO', varInteger);
    Except
      On E: Exception Do
      Begin
        If fConexaoAtiva Then
          pMensagensErro(E.Message,'')
        Else
          MessageDlg(E.Message, mtError, [mbOK], 0);
        Exit;
      End;
    End;

    Try
      TLogAut.New().pLogin();

      If TUtilMonitor.fLockMonitor(spIdMonitoriLogStatus, VS_strLockMonitoriLogStatus) Then
      Begin
        Try
          TMonitor.New()
            .IdMonitor(spIdMonitoriLogStatus)
            .TimeLimit(spTimeLimitMonitoriLogStatus)
            .LockMonitor(VS_strLockMonitoriLogStatus)
            .ProcedureExec(TMonitoriLogStatus.New())
            .pStart();
        Except
          On E: Exception Do
          Begin
            If fConexaoAtiva Then
              pMensagensErro(E.Message,'')
            Else
              MessageDlg(E.Message, mtError, [mbOK], 0);
            Exit;
          End;
        End;
      End;

    Finally
      TUtilMonitor.fRemoveLockMonitor(spIdMonitoriLogStatus);
      TLogAut.New().pLogout();
      pFinalizarModulos;
    End;

  Finally
    If Not TerminateProcess(GetCurrentProcess, 0) Then
      Application.Terminate;
  End;

end;

end.
