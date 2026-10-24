unit untAtualizarStatusPedidos;

interface

uses
  Winapi.Windows, Forms, System.Classes, System.SysUtils, Dialogs, System.UITypes,
  System.strUtils;

  procedure pAtualizarStatusPedidos;

implementation

uses
  untFuncoesSimples, untUtilMonitor, untTSituacaoPedidoVenda, untLogAut, untModuloReplicacao;

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

procedure pAtualizarStatusPedidos;
Var
  LCodCli: String;
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
      Try
        VS_SQL_TRACE_DOC_NUMERO := InputBox(ParamStr(5), 'Informe o número do documento:', '999999999999');
        VS_SQL_TRACE_DOC_ESPECIE := InputBox(ParamStr(5), 'Informe a espécie do documento:', 'PD');
        VS_SQL_TRACE_DOC_EMPRESA := InputBox(ParamStr(5), 'Informe a empresa do documento:', VS_strCodEmp);

        LCodCli := fCampoTabelaFatgor('FGO_CODCLI', VS_SQL_TRACE_DOC_NUMERO, VS_SQL_TRACE_DOC_ESPECIE, VS_SQL_TRACE_DOC_EMPRESA);

        If LCodCli.IsEmpty Then
        Begin
          MessageDlg('Documento "' + VS_SQL_TRACE_DOC_NUMERO + '-'
                                   + VS_SQL_TRACE_DOC_ESPECIE+ '-'
                                   + VS_SQL_TRACE_DOC_EMPRESA+'" não existe!', mtError, [mbOK], 0);
          Exit;
        End;

        frmModuloReplicacao.pLigaSQLTrace;

        TUpdateStatus.New(TParamStatus.New()
                            .NumDoc(VS_SQL_TRACE_DOC_NUMERO)
                            .EspDoc(VS_SQL_TRACE_DOC_ESPECIE)
                            .CodEmp(VS_SQL_TRACE_DOC_EMPRESA)
                            .CodCli(LCodCli)).pExecute();

        frmModuloReplicacao.pDesligaSQLTrace;
        frmModuloReplicacao.pShowSQLTrace;

        Exit;
      Finally
        KillProcess(ExtractFileName(ParamStr(0)));
      End;
    End;

    If (fEncerrarSemExecutar) Then
      Exit;

    Try
      TLogAut.New().pLogin();

      If TUtilMonitor.fLockMonitor(spIdMonitorStatus, VS_strLockMonitorStatus) Then
      Begin
        TRepositoryStatus.New().pCheck();

        Try
          TMonitor.New()
            .IdMonitor(spIdMonitorStatus)
            .TimeLimit(spTimeLimitMonitorStatus)
            .LockMonitor(VS_strLockMonitorStatus)
            .ProcedureExec(TUpdateStatus.New())
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
      TUtilMonitor.fRemoveLockMonitor(spIdMonitorStatus);
      TLogAut.New().pLogout();
      pFinalizarModulos;
    End;

  Finally
    If Not TerminateProcess(GetCurrentProcess, 0) Then
      Application.Terminate;
  End;

end;

end.
