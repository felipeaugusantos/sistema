unit untConsultaPagamentosPix;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  Vcl.Forms, Vcl.ExtCtrls,
{$ENDIF LINUX}
  System.SysUtils, untLogAut, untTFuncoesPixMonitor, DateUtils;

Type
  TMonitorPix = class
    public
    public
      procedure ConsultaPagamentosPix;
      procedure ProcessarPagamentoPix(ATxId: string);
      procedure FinalizaMonitor;
      procedure pLiberarLock;
  end;

implementation

Uses
  untFuncoesSimples, untTypesSistema;

{ TMonitorPix }

procedure TMonitorPix.ProcessarPagamentoPix(ATxId: string);
begin
  Try
    pDefinirEmpresa;
   {$IFDEF LINUX}
    FormatSettings_ptBR;
    pIniciarConexao;
   {$ELSE}
    pConectarModulos;
   {$ENDIF}
    pDefinirUsuario;
    pIniciarVariaveis;
    fAjustaDataSistema;
  Except
    On E: Exception Do
    Begin
      TFuncoesPixMonitor.GravarLogErr_Pix('Erro ao executar o monitor de recebimentos do Pix. ' + #13 +
                                          'Erro gerado: ' + E.Message,
                                          fRetornaStack);
      pLiberarLock;
      FinalizaMonitor;
      Exit;
    End;
  End;

  Try
    TLogAut.New().pLogin();
    Try
      {$IFNDEF LINUX}
      TFuncoesPixMonitor.CarregaLibIntegracaoPixCitel;
      {$ENDIF}

      TFuncoesPixMonitor.ExecutarRotinasConsultaAtivasMonitorPix(ATxId,
                                                                 HasParam('--ignorarpixtela'));
      TFuncoesPixMonitor.ExecutarRotinasConsultaTemporariasAtivasMonitorPix(ATxId);
      TFuncoesPixMonitor.ExecutarRotinasConsultaTemporariasPagasMonitorPix(ATxId);
    Except
      On E: Exception Do
        TFuncoesPixMonitor.GravarLogErr_Pix(E.Message, fRetornaStack);
    End;
  Finally
    pLiberarLock;
    FinalizaMonitor;
  End;
end;

procedure TMonitorPix.ConsultaPagamentosPix;
const
  MINUTES_TIMEOUT = {$IFDEF LINUX}1440{$ELSE}5{$ENDIF};
var
  LStarted: TDateTime;
begin
  TFuncoesPixMonitor.ResetaTxIdJaGravadoLogErrPix404;

  Try
    pDefinirEmpresa;
   {$IFDEF LINUX}
    FormatSettings_ptBR;
    pIniciarConexao;
   {$ELSE}
    pConectarModulos;
   {$ENDIF}
    pDefinirUsuario;
    pIniciarVariaveis;
    fAjustaDataSistema;
  Except
    On E: Exception Do
    Begin
      TFuncoesPixMonitor.GravarLogErr_Pix('Erro ao executar o monitor de recebimentos do Pix. ' + #13 +
                                          'Erro gerado: ' + E.Message,
                                          fRetornaStack);
      pLiberarLock;
      FinalizaMonitor;
      Exit;
    End;
  End;

  Try
    LStarted := fTime();
    TLogAut.New().pLogin();
    While MinutesBetween(fTime(), LStarted) < MINUTES_TIMEOUT Do
    Begin
     {$IFDEF LINUX}
      WriteLog('Executando Consultar Pagamentos Pix Service ...', True);

      If VS_ExitProcessSignal Then
        Break;

      If HasParam('-f') then
      Begin
        // Renova a hora da propria trava em vez de destravar e travar de novo. O
        // autcom derruba trava parada ha mais de 5 minutos (fGetTempoDuracaoLock),
        // e a janela entre o DELETE e o INSERT era por onde o monitor Windows entrava.
        If Not fRenovarHoraLock('MONITOR_RECEBIMENTOS_PIX_' + VS_strCodEmp,
                                'MONITOR_RECEBIMENTOS_PIX_' + VS_strCodEmp) Then
        Begin
          pDestravaLockForcado('MONITOR_RECEBIMENTOS_PIX_' + VS_strCodEmp, 0);

          // A origem identifica o dono da trava. O autcom consulta fRetOrigemLock desta chave
          // em TFuncoesPixAutcom e, achando-a preenchida, desiste de subir o monitor Windows.
          // Travar sem origem fazia o autcom concluir que ninguém cuidava do PIX e executar
          // a rotina em paralelo com este robô.
          if not fLock_Unlock('MONITOR_RECEBIMENTOS_PIX_' + VS_strCodEmp,
                              True,
                              False,
                              False,
                              '',
                              True,
                              'MONITOR_RECEBIMENTOS_PIX_' + VS_strCodEmp) then
            Break;
        End;
      End;
     {$ENDIF}

      If fRetUserLock('MONITOR_RECEBIMENTOS_PIX_' + VS_strCodEmp) <> VS_UserFromWindows Then
        Break;

      Try
       {$IFNDEF LINUX}
        TFuncoesPixMonitor.CarregaLibIntegracaoPixCitel;
       {$ENDIF}

        TFuncoesPixMonitor.ExecutarRotinasConsultaAtivasMonitorPix;
        TFuncoesPixMonitor.ExecutarRotinasConsultaTemporariasAtivasMonitorPix;
        TFuncoesPixMonitor.ExecutarRotinasConsultaTemporariasPagasMonitorPix;
        Sleep(30000);
      Except
        On E: Exception Do
          TFuncoesPixMonitor.GravarLogErr_Pix(E.Message, fRetornaStack);
      End;
    End;
  Finally
    pLiberarLock;
    FinalizaMonitor;
  End;
end;

procedure TMonitorPix.FinalizaMonitor;
begin
  TLogAut.New().pLogout();
 {$IFDEF LINUX}
  objConnectionsManager.EndConnection;
 {$ELSE}
  pFinalizarModulos;
  Application.Terminate;
 {$ENDIF}
end;

procedure TMonitorPix.pLiberarLock;
begin
  if fRetUserLock('MONITOR_RECEBIMENTOS_PIX_' + VS_strCodEmp) <> VS_UserFromWindows then
    Exit;

  Sleep(30000);

  fLock_Unlock('MONITOR_RECEBIMENTOS_PIX_' + VS_strCodEmp,
               False,
               False,
               False,
               '',
               False,
               'MONITOR_RECEBIMENTOS_PIX_' + VS_strCodEmp);
end;

end.
