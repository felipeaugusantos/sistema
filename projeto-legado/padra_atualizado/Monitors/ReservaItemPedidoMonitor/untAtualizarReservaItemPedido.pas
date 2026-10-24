unit untAtualizarReservaItemPedido;

interface

uses
  Winapi.Windows, Forms, System.Classes, System.SysUtils, Dialogs, System.UITypes;

  procedure pAtualizarReservaItemPedido;

implementation

uses
  untFuncoesSimples, untUtilMonitor, untLogAut, untTSaldoReservadoPedido;

function fEncerrarSemExecutar:Boolean;
begin  
  Result := False;

  If (fConexaoAtiva) Then
    If (fCfgSis('LXRBSL', varString) = 'S') Then
      Result := True;
end;

procedure pMensagemErroLocal(strMessage: String);
begin
  If (fConexaoAtiva) Then
    pMensagensErro(strMessage,'')
  Else
    MessageDlg(strMessage, mtError, [mbOK], 0);
end; 

procedure pAtualizarReservaItemPedido;
begin
  Try
    Try
      pDefinirEmpresa;
      pConectarModulos;
      pDefinirUsuario;
      pIniciarVariaveis;
      fAjustaDataSistema;
    Except
      On E: Exception Do
      Begin
        pMensagemErroLocal(E.Message);
        Exit;
      End;
    End;

    If (fEncerrarSemExecutar) Then
      Exit;

    Try
      TLogAut.New().pLogin();

      If TUtilMonitor.fLockMonitor(spIdMonitorReservaItem, VS_strLockMonitorReservaItem) Then
      Begin
        Try
          TMonitor.New()
            .IdMonitor(spIdMonitorReservaItem)
            .TimeLimit(spTimeLimitMonitorReservaItem)
            .LockMonitor(VS_strLockMonitorReservaItem)
            .ProcedureExec(TUpdateReservaItem.New())
            .pStart();
        Except
          On E: Exception Do
          Begin
            pMensagemErroLocal(E.Message);
            Exit;
          End;
        End;
      End;

    Finally
      TUtilMonitor.fRemoveLockMonitor(spIdMonitorReservaItem);
      TLogAut.New().pLogout();
      pFinalizarModulos;
    End;

  Finally
    If Not TerminateProcess(GetCurrentProcess, 0) Then
      Application.Terminate;
  End;

end;

end.
