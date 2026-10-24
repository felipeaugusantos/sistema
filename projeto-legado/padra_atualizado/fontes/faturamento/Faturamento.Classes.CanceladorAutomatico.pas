unit Faturamento.Classes.CanceladorAutomatico;

interface

uses untUtilMonitor, Winapi.Windows, System.Classes, untLogCanRepository;

const
  CanceladorAutomaticoMonitorExeParam = 'CANCELADOR_AUTOMATICO';
  IdMonitorCanceladorAutomatico = 'MONITOR_CANCELADOR_AUTOMATICO_%s_%s';
  TimeLimitMonitorCanceladorAutomatico = 9999;
  IdInactivityMonitorCanceladorAutomatico = 'TESTE_INATIVIDADE_CANCELADOR_%s';
  AttemptsLockMonitorCanceladorAutomatico = 30;
  HistoricoDelecaoCancelador = 'CANCELAMENTO AUTOMÁTICO - LOGCAN';
  MinutosNovaTentativaCanceladorAutomatico = 60;
  MinutosVerificacaoDePendenciaCanceladorAutomatico = 7;
  DiasMaximoTentativasCanceladorAutomatico = 7;
  TentativasPorDiaCanceladorAutomatico = 3;
  QuantidadeMaximaRobos = 1;

type
  TCanceladorAutomaticoParams = record
    strNumDoc : String;
    strEspDoc : String;
    strCodEmp : String;
    strCliFor : String;
    strTip_Fc : String;
    strSerie : String;
    blnInutilizacao : Boolean;
    strDesMot : String;
    strMotDel : String;
    strHisCom : String;
    strOpcDel : String;
  End;

  TCanceladorAutomaticoMonitor = class sealed(TInterfacedObject, IMonitorProcedure)
  private
    class var FMensagens : TStringList;
    class function fValidarConfiguracoes: Boolean;
    class function fExistePendencia: Boolean;
  private
    procedure ClearLog;
  protected
    FParams : TCanceladorAutomaticoParams;
    constructor Create(const AParams : TCanceladorAutomaticoParams);
  public
    procedure pExecute;
    procedure pExecuteAll;
    function fExecute : TResultExecute;
    class procedure AddLog(AText : String);
    class function New(const AParams : TCanceladorAutomaticoParams) : IMonitorProcedure;
    class procedure ExecutarRobo();
  end;

Var
  VS_strLockMonitorCanceladorAutomatico : String;
  VS_dtaUltimaExecucaoMonitorCanceladorAutomatico : TDateTime;
  VS_objProcessoMonitorCanceladorAutomatico : TProcessInformation;

implementation

uses untFuncoesSimples, System.SysUtils, untTypesSistema, untFuncoesGenerica,
  untCancelamentoDocumentos, Uni, System.Generics.Collections,
  untDtoLogCan, untConnection, untUnidac, DateUtils, untLogCancelamento, untTypesCancelamento;

{ TCanceladorAutomaticoMonitor }

class procedure TCanceladorAutomaticoMonitor.AddLog(AText: String);
begin
  If Not Assigned(Self.FMensagens) Then
    Exit;
  Self.FMensagens.Add(DateTimeToStr(fNow()) + ' - ' + AText);
end;

procedure TCanceladorAutomaticoMonitor.ClearLog;
begin
  If (Not Assigned(Self.FMensagens)) Then
    Exit;
  Self.FMensagens.Clear;
end;

constructor TCanceladorAutomaticoMonitor.Create(const AParams: TCanceladorAutomaticoParams);
begin
  FParams := AParams;
end;

class procedure TCanceladorAutomaticoMonitor.ExecutarRobo;
  Var
    LId : String;
begin
  If Not fValidarConfiguracoes Then
    Exit;

  LId := Format(IdMonitorCanceladorAutomatico, [VS_strCodEmp, strLoginUsuarioLogado]);

  TUtilMonitor.pTestInactivity(IdInactivityMonitorCanceladorAutomatico, TimeLimitMonitorCanceladorAutomatico, VS_objProcessoMonitorCanceladorAutomatico, VS_dtaUltimaExecucaoMonitorCanceladorAutomatico);

  If (fQuantidadeRobosDeMonitaramentoExecutando(Format(IdMonitorCanceladorAutomatico, [VS_strCodEmp, '%'])) < QuantidadeMaximaRobos) And
     fExistePendencia Then
  Begin
    TUtilMonitor.pRunMonitor(LId,
                             VS_objProcessoMonitorCanceladorAutomatico,
                             VS_dtaUltimaExecucaoMonitorCanceladorAutomatico,
                             ExtractFileName(ParamStr(0)),
                             Concat(CanceladorAutomaticoMonitorExeParam, ' ', VS_strCodEmp, ' ', strLoginUsuarioLogado));
  End;

  TUtilMonitor.pClearAttemptsLock(LId, AttemptsLockMonitorCanceladorAutomatico);
end;

function TCanceladorAutomaticoMonitor.fExecute: TResultExecute;
begin
  Result := Default(TResultExecute);
  pExecute;
end;

class function TCanceladorAutomaticoMonitor.fExistePendencia: Boolean;
begin
  Try
    Result := TLogCancelamento.ExistePendenciaParaCanceladorAutomatico(VS_strCodEmp, MinutosVerificacaoDePendenciaCanceladorAutomatico);
  Except
    On E: Exception Do
    Begin
      pGravarErro(True, E.Message, E.StackTrace);
      // Na dúvida sobe o robo: o pExecuteAll é quem decide de fato
      Result := True;
    End;
  End;
end;

class function TCanceladorAutomaticoMonitor.fValidarConfiguracoes: Boolean;
begin
  Try
    Result := True;

    If TOSVersion.ToString.ToUpper.Contains('WINDOWS 7') Then
      Exit(False);

    If (fCfgSis('CANAUT', varString) <> 'S') Then
      Exit(False);
  Except
    On E: Exception Do
    Begin
      pGravarErro(True, E.Message, E.StackTrace);
      Result := False;
    End;
  End;
end;

class function TCanceladorAutomaticoMonitor.New(const AParams : TCanceladorAutomaticoParams): IMonitorProcedure;
begin
  Result := Self.Create(AParams);
end;

procedure TCanceladorAutomaticoMonitor.pExecute;
  Var
    LInput : TInputCancAut;
    LOutput : TOutputCancAut;
begin
  If Not fValidarConfiguracoes Then
    Exit;
  Self.ClearLog;
  LInput := Default(TInputCancAut);
  LInput.strNumDoc := FParams.strNumDoc;
  LInput.strEspDoc := FParams.strEspDoc;
  LInput.strCodEmp := FParams.strCodEmp;
  LInput.strCliFor := FParams.strCliFor;
  LInput.strTipFC := FParams.strTip_Fc;
  LInput.strSerie := FParams.strSerie;
  LInput.blnInutilizacao := FParams.blnInutilizacao;
  LInput.strDesMot := FParams.strDesMot;
  LInput.strMotDel := FParams.strMotDel;
  LInput.strHisCom := FParams.strHisCom;
  LInput.strOpcDel := FParams.strOpcDel;
  LOutput := TfrmCancelamentoDocumentos.fExecutarCancelamentoAutomatico(LInput);
  If (Not LOutput.blnCancelamentoComitadoComSucesso) Then
    Raise Exception.Create('Falha na tentativa de executar o cancelamento automatico');
end;

procedure TCanceladorAutomaticoMonitor.pExecuteAll;
  Var
    LIdMonitor : String;
    LPendencias : TList<TDtoLogCan>;
    LLogCan : TDtoLogCan;
    LParams : TCanceladorAutomaticoParams;
    LLogCanRepository : TLogCanRepository;
    LLogCancelamento : TLogCancelamento;
    LConnection : IConnection;
    LKeyLock : String;
    LDiasDecorridos : Integer;
    LMaxTentativas : Integer;
begin
  If Not fValidarConfiguracoes Then
    Exit;

  LConnection := TUnidacConnection.Create;
  Try
    LLogCanRepository := TLogCanRepository.Create(LConnection);
    Try
      LPendencias := LLogCanRepository.PendenciasDeCancelamento(VS_strCodEmp);
      Try
        LIdMonitor := Format(IdMonitorCanceladorAutomatico, [VS_strCodEmp, strLoginUsuarioLogado]);

        LLogCancelamento := TLogCancelamento.Create;
        Try
          For LLogCan In LPendencias Do
          Begin
            Try
              If (DaysBetween(fNow(), LLogCan.dtaDtaHraCan) >= DiasMaximoTentativasCanceladorAutomatico) Then
              Begin
                LLogCanRepository.FinalizarPendenciaComErroMultiplasTentativas(LLogCan.strAutInc);
                Continue;
              End;
              LDiasDecorridos := DaysBetween(fNow(), LLogCan.dtaDtaHraCan);
              LMaxTentativas  := (LDiasDecorridos + 1) * TentativasPorDiaCanceladorAutomatico;
              If (LLogCan.intTentat >= LMaxTentativas) Then
                Continue;
              If (MinutesBetween(fNow(), LLogCan.dtaDtaHraCan) > MinutosVerificacaoDePendenciaCanceladorAutomatico) And
                 (MinutesBetween(fNow(), LLogCan.dtaDhuTen) > MinutosNovaTentativaCanceladorAutomatico) Then
              Begin
                LKeyLock := 'CANAUT_' + LLogCan.strAutInc;
                pDestravaLockForcado(LKeyLock, AttemptsLockMonitorCanceladorAutomatico * QuantidadeMaximaRobos);
                If fLock_Unlock(LKeyLock, True, False, False, EmptyStr, False) Then
                Begin
                  Try
                    If (LLogCancelamento.ValidouIntegridadeDocumentos(LLogCan.strAutInc, EmptyStr)) Then
                      Continue;
                    LParams := Default(TCanceladorAutomaticoParams);
                    LParams.strNumDoc := LLogCan.strNumDoc;
                    LParams.strEspDoc := LLogCan.strEspDoc;
                    LParams.strCodEmp := LLogCan.strCodEmp;
                    LParams.strCliFor := LLogCan.strCliFor;
                    LParams.strTip_Fc := LLogCan.strTip_Fc;
                    LParams.strSerie := LLogCan.strSerie;
                    LParams.blnInutilizacao := LLogCan.blnInutil;
                    LParams.strOpcDel := LLogCan.strOpcDel;
                    LParams.strDesMot := LLogCan.strDesMot;
                    LParams.strMotDel := LLogCan.strMotDel;
                    LParams.strHisCom := LLogCan.strHisCom;
                    TCanceladorAutomaticoMonitor.New(LParams).pExecute;
                    LLogCanRepository.IncrementaTentativasDeCancelamento(LLogCan.strAutInc);
                    pZerarTentativasLock(LIdMonitor);
                    Sleep(500);
                    pTrimAppMemorySize();
                  Finally
                    fLock_Unlock(LKeyLock, False, False, False, EmptyStr, False);
                  End;
                End;
              End;
            Except
              On E: ExceptionEstornoMalsucedido Do
              Begin
                LLogCanRepository.FinalizarPendenciaComErroEstorno(LLogCan.strAutInc, E.Message);
              End;
              On E: Exception Do
              Begin
                LLogCanRepository.AtualizaHistorico(LLogCan.strAutInc, Format('Tentativa de cancelamento %d - %s', [LLogCan.intTentat + 1, E.Message]) + sLineBreak + Self.FMensagens.Text);
                LLogCanRepository.IncrementaTentativasDeCancelamento(LLogCan.strAutInc);
              End;
            End;
          End;
        Finally
          FreeAndNil(LLogCancelamento);
        End;
      Finally
        FreeAndNil(LPendencias);
      End;
    Finally
      FreeAndNil(LLogCanRepository);
    End;
  Except
    On E: Exception Do
      pGravarErro(True, 'ERRO CANCELADOR AUTOMATICO - ' + E.Message, E.StackTrace);
  End;
end;

initialization
  TCanceladorAutomaticoMonitor.FMensagens := TStringList.Create;

finalization
  FreeAndNil(TCanceladorAutomaticoMonitor.FMensagens);

end.
