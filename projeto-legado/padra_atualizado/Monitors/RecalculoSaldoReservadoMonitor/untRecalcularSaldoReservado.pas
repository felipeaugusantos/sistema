unit untRecalcularSaldoReservado;

interface

uses
  Winapi.Windows, Forms, System.Classes, System.SysUtils, Dialogs, System.UITypes;

  procedure pRecalcularSaldoReservado;

implementation

uses
  untFuncoesSimples, untUtilMonitor, untLogAut, untTFatReservaSaldo, untModuloReplicacao;

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

procedure pRecalcularSaldoReservado;
begin
  Try
    Try
      pDefinirEmpresa;
      pConectarModulos;

      If Not fValidarEmpresa Then
        Exit;

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

    If fExecutandoPeloPortal Then
    Begin
      VS_SQL_TRACE_PRODUTO := InputBox(ParamStr(5), 'Informe o código do Produto:', '99999');

      If fRetNomeProduto(VS_SQL_TRACE_PRODUTO).IsEmpty Then
      Begin
        MessageDlg('Produto "' + VS_SQL_TRACE_PRODUTO + '" não existe!', mtError, [mbOK], 0);
        Exit;
      End;

      frmModuloReplicacao.pLigaSQLTrace;

      TAuditoriaReserva.New(TReservaParametros.New()
          .CodigoItem(VS_SQL_TRACE_PRODUTO)
          .EmpresaItem(VS_strCodEmp)
          .CodEmpresa(VS_strCodEmp)
          .EhReprocesso(True)
          .TabelaAudit(tblIteGer)
        ).pExecute();

      frmModuloReplicacao.pDesligaSQLTrace;
      frmModuloReplicacao.pShowSQLTrace;
      Exit;
    End;

    If (fEncerrarSemExecutar) Then
      Exit;

    Try
      TLogAut.New().pLogin();

      If TUtilMonitor.fLockMonitor(spIdMonitorAudit, VS_strLockMonitorAudit) Then
      Begin
        Try
          TMonitor.New()
            .IdMonitor(spIdMonitorAudit)
            .TimeLimit(spTimeLimitMonitorAudit)
            .LockMonitor(VS_strLockMonitorAudit)
            .ProcedureExec(TAuditoriaReserva.New())
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
      TUtilMonitor.fRemoveLockMonitor(spIdMonitorAudit);
      TLogAut.New().pLogout();
      pFinalizarModulos;
    End;

  Finally
    If Not TerminateProcess(GetCurrentProcess, 0) Then
      Application.Terminate;
  End;

end;

end.
