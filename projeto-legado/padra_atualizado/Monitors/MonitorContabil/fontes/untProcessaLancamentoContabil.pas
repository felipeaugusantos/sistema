unit untProcessaLancamentoContabil;

interface

uses
  Winapi.Windows, Forms, System.Classes, System.SysUtils, Dialogs, System.UITypes;

procedure pProcessaLancamentoContabil;
procedure pDefinirIdLancamento(var intId: int64);

implementation

uses
  untFuncoesSimples, untUtilMonitor, untLogAut, untTMonitoriaContabil,
  untTParametrosMonitorContabil, Contabilidade.Interfaces, DateUtils;

procedure pProcessaLancamentoContabil;
  var
    intId: int64;
    strTempID : string;
    intTempoEmMinutos : integer;
    sDestravaLock : string ;
    dDuracaoLock : double ;
    iMinutosLock : integer ;
    dtInicioLock : TDateTime ;
begin
  Try
    Try
      pDefinirEmpresa;
      pDefinirIdLancamento(intId);
      pConectarModulos;
      pDefinirUsuario;
      pIniciarVariaveis;
      fAjustaDataSistema;
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

      strTempID := Id_Monitor_Contabil_Sem_Empresa;
      intTempoEmMinutos := Time_Limit_Monitor_Contabil;
      if (intId > 0) then
      begin
        strTempID := Format('MONITOR_%d_CONTABIL_', [intId]) + '%s';
        intTempoEmMinutos := 1;
      end
      else
      begin
        ////verifica lock está em timeout, se estiver finaliza o lock
        sDestravaLock := Id_Monitor_Contabil_Sem_Empresa ;
        dDuracaoLock := TUtilMonitor.fGetTempoDuracaoLock(sDestravaLock, True) ;
        if dDuracaoLock > 0 then
        begin
          dtInicioLock := TDate(fNow()) + dDuracaoLock ;
          iMinutosLock := MinutesBetween(fNow(), dtInicioLock) ;
          if iMinutosLock >= (Time_Limit_Monitor_Contabil+5) then
          begin
            TUtilMonitor.pDestravaLockForcado(sDestravaLock, 0);
          end;
        end;

      end;

      If TUtilMonitor.fLockMonitor(strTempID, VS_strLockMonitorContabil) Then
      Begin
        Try
          TMonitor.New()
            .IdMonitor(strTempID)
            .TimeLimit(intTempoEmMinutos)
            .LockMonitor(VS_strLockMonitorContabil)
            .ProcedureExec(TMonitoriaContabil.New(TParametrosMonitorContabil.New
                                                    .EmpresaLancamento(VS_strCodEmp)
                                                    .IdLancamento(intId)))
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
      TUtilMonitor.fRemoveLockMonitor(strTempID);
      TLogAut.New().pLogout();
      pFinalizarModulos;
    End;

  Finally
    If Not TerminateProcess(GetCurrentProcess, 0) Then
      Application.Terminate;
  End;

end;

procedure pDefinirIdLancamento(var intId: int64);
begin
  If fEmptyStr(ParamStr(2)) Then
    intId := 0
  else
    intId := StrToInt64(ParamStr(2));
end;

end.
