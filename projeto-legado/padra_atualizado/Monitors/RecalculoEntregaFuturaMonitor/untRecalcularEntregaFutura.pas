unit untRecalcularEntregaFutura;

interface

uses
  Winapi.Windows, Forms, System.Classes, System.SysUtils, Dialogs, System.UITypes;

  procedure pRecalcularEntregaFutura;

implementation

uses
  untFuncoesSimples, untUtilMonitor, untLogAut, untTFatEntregaFutura, untModuloReplicacao,
  untIFatEntregaFutura;

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

procedure pRecalcularEntregaFutura;
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

    If fExecutandoPeloPortal Then
    Begin
      VS_SQL_TRACE_PRODUTO := InputBox(ParamStr(5), 'Informe o código do Produto:', '99999');

      If fRetNomeProduto(VS_SQL_TRACE_PRODUTO).IsEmpty Then
      Begin
        MessageDlg('Produto "' + VS_SQL_TRACE_PRODUTO + '" não existe!', mtError, [mbOK], 0);
        Exit;
      End;

      frmModuloReplicacao.pLigaSQLTrace;

      TEntregaFutura.New(
        TParamEF.New()
          .CodIte(VS_SQL_TRACE_PRODUTO)
          .CodEmp(VS_strCodEmp)
          .Reprocesso(True)
          .Atualizacao(True)
          .Auditoria(True)
          .TipoEF(tefTodos)
          .TipoTE(tteNenhuma)
      ).Total();

      frmModuloReplicacao.pDesligaSQLTrace;
      frmModuloReplicacao.pShowSQLTrace;
      Exit;
    End;

    If (fEncerrarSemExecutar) Then
      Exit;

    Try
      TLogAut.New().pLogin();

      If TUtilMonitor.fLockMonitor(spIdMonitorEntFut, VS_strLockMonitorEntregaFutura) Then
      Begin
        Try
          TMonitor.New()
            .IdMonitor(spIdMonitorEntFut)
            .TimeLimit(spTimeLimitMonitorEntFut)
            .LockMonitor(VS_strLockMonitorEntregaFutura)
            .ProcedureExec(TAuditoriaEF.New())
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
      TUtilMonitor.fRemoveLockMonitor(spIdMonitorEntFut);
      TLogAut.New().pLogout();
      pFinalizarModulos;
    End;

  Finally
    If Not TerminateProcess(GetCurrentProcess, 0) Then
      Application.Terminate;
  End;

end;

end.
