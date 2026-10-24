unit untiLogMonitorSend;

interface

uses
  Winapi.Windows, Forms, System.Classes, System.SysUtils, Dialogs, System.UITypes;

  procedure iLogMonitorar;

implementation

uses
  untFuncoesSimples, untUtilMonitor, untLogAut, untFatRomaneioiLogMonitorSend;

procedure iLogMonitorar;
begin
  Try
    Try
      pDefinirEmpresa;
      pConectarModulos;
      pDefinirUsuario;
      pIniciarVariaveis;
      fAjustaDataSistema;

      untFatRomaneioiLogMonitorSend.Token := fCfgSis('TOKILO', varString);
      untFatRomaneioiLogMonitorSend.OpcRom := fCfgSis('OPCROM');
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

      If TUtilMonitor.fLockMonitor(spIdMonitoriLogSend, VS_strLockMonitoriLogSend) Then
      Begin
        Try
          TMonitor.New()
            .IdMonitor(spIdMonitoriLogSend)
            .TimeLimit(spTimeLimitMonitoriLogSend)
            .LockMonitor(VS_strLockMonitoriLogSend)
            .ProcedureExec(TMonitoriLogSend.New())
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
      TUtilMonitor.fRemoveLockMonitor(spIdMonitoriLogSend);
      TLogAut.New().pLogout();
      pFinalizarModulos;
    End;

  Finally
    If Not TerminateProcess(GetCurrentProcess, 0) Then
      Application.Terminate;
  End;

end;

end.
