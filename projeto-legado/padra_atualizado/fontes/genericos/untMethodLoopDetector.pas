unit untMethodLoopDetector;

{ ==========================================================================
  TMethodLoopDetector
  --------------------------------------------------------------------------
  Detector de loop por frequencia de chamadas. Comporta-se em 2 fases:

  FASE 1 (observador): cada chamada de fRegisterCall() registra tick no buffer
  circular e retorna True. Enquanto o loop NAO foi detectado, nada bloqueia ou
  desacelera -- o metodo continua rodando todas as vezes, preservando o sintoma
  original (CPU alto, queries visiveis no log) para diagnostico.

  FASE 2 (mitigador): quando N chamadas ocorrem dentro da janela de tempo,
  o detector entra em modo de mitigacao e fRegisterCall() passa a retornar
  False. Com ALogTrace=True, o 1o trace ainda retorna True (preserva captura
  autentica) e a mitigacao engaja apos log bem-sucedido; com ALogTrace=False,
  engaja imediatamente na deteccao.

  A ESTRATEGIA DE MITIGACAO FICA A CARGO DO CALLER. fRegisterCall apenas
  sinaliza via Boolean -- o caller escolhe como responder:
    - Exit imediato: caller sai sem trabalho. Message pump livre, UI responsiva,
      mas sem feedback ao usuario nem refresh de dados.
    - Sleep + continua: caller espera N ms e executa o corpo. BLOQUEIA o
      message pump durante o Sleep (efeito esperado nessa via). Faz sentido
      quando ha um modal "Aguarde..." visivel envelopando a chamada -- a UI
      "travada" coincide com afordancia de operacao em andamento. Throttle
      efetivo: serializa fila de mensagens, reduz cadencia, mantem refresh.
    - Sleep + Exit: caller pacota a UI e sai. Combina pacing com economia
      de trabalho.
    - Application.ProcessMessages entre chamadas: mantem UI viva mas serializa
      menos efetivamente.

  Quando o loop cessar (gap real sem chamadas), o detector volta a retornar
  True automaticamente -- volta a FASE 1.

  Cooldown entre traces: 60s (mesmo burst continuo gera no maximo 1 trace por 60s).
  Anti-spam por sessao: maximo de 5 traces.

  Uso tipico:
    // FormCreate:
    FAtualizarGridDetector := TMethodLoopDetector.Create(
      'TfrmFatExpedicao.pAtualizarGrid');  // defaults: 30 calls em 10s

    // FormDestroy:
    FreeAndNil(FAtualizarGridDetector);

    // Inicio do metodo a observar (caller escolhe estrategia):
    //   (a) Exit imediato sem trabalho:
    If Not FAtualizarGridDetector.fRegisterCall(ACaller) Then Exit;
    //
    //   (b) Sleep + continua (throttle com refresh, ex.: F7 com modal "Aguarde"):
    If Not FAtualizarGridDetector.fRegisterCall(ACaller) Then
      Sleep(1500);
    //
    //   (c) Sleep + Exit (throttle sem trabalho):
    If Not FAtualizarGridDetector.fRegisterCall(ACaller) Then
    Begin
      Sleep(1500);
      Exit;
    End;
    // ... corpo executa normalmente ...
  ========================================================================== }

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes;

Type
  TMethodLoopDetector = Class(TObject)
    Private
      FMethodName            : String;
      FCallsThreshold        : Integer;
      FWindowMs              : Cardinal;
      FCooldownMs            : Cardinal;
      FMaxTracesPerSession   : Integer;

      FCallTicks             : Array of Cardinal;
      FCallTicksIdx          : Integer;
      FCallTicksFilled       : Boolean;
      FTracesLoggedInSession : Integer;
      FLastTraceTick         : Cardinal;

      // Diagnostico: ultima excecao capturada em pTryLogLoopTrace (preservada
      // para inspecao por property mesmo com o Except silencioso).
      FLastTraceErrorMsg     : String;
      FLastTraceErrorTick    : Cardinal;

      // Latch da FASE 2 (mitigacao): uma vez ativo, persiste ate gap real
      // de FGapToExitMitigationMs sem chamadas (= loop verdadeiramente parou).
      // Evita oscilacao FASE 1 <-> FASE 2 que aconteceria se basassemos somente
      // no buffer circular (que se "diluiria" durante a mitigacao).
      FInMitigationMode      : Boolean;
      FLastCallTick          : Cardinal;
      FGapToExitMitigationMs : Cardinal;

      FLogTrace              : Boolean;   // True: loga em LOGERR ao detectar; False: mitiga em silencio

      Function  fTickElapsed(const ATickInicial: Cardinal): Cardinal;
      Procedure pTryLogLoopTrace(const AAdditionalContext: String);
    Public
      Constructor Create(const AMethodName        : String;
                         ACallsThreshold          : Integer  = 30;
                         AWindowMs                : Cardinal = 10000;
                         ACooldownMs              : Cardinal = 60000;
                         AMaxTracesPerSession     : Integer  = 5;
                         AGapToExitMitigationMs   : Cardinal = 5000;
                         ALogTrace                : Boolean  = True);

      Destructor Destroy; Override;

      { Registra uma chamada do metodo protegido e indica se o caller deve prosseguir.
        Retorna True se o metodo deve executar normalmente, False se o caller deve
        pular a execucao (Exit). Logica:
          - Sem loop detectado: SEMPRE retorna True (FASE 1, observador)
          - Loop detectado mas trace ainda nao gravado: retorna True (preserva
            captura autentica do 1o trace com o metodo executando normal)
          - Loop detectado e 1+ traces ja gravados: retorna False (caller deve
            fazer Exit para nao consumir CPU executando trabalho real)
          - Loop cessou: volta a retornar True automaticamente }
      Function fRegisterCall(const AAdditionalContext: String = ''): Boolean;

      Property MethodIdent           : String   Read FMethodName;
      Property TracesLoggedInSession : Integer  Read FTracesLoggedInSession;
      // Inspecionavel via depuracao para diagnosticar falhas silenciosas no log
      Property LastTraceErrorMsg     : String   Read FLastTraceErrorMsg;
      Property LastTraceErrorTick    : Cardinal Read FLastTraceErrorTick;
      Property InMitigationMode      : Boolean  Read FInMitigationMode;
  End;

implementation

uses
  System.StrUtils, untFuncoesSimples;

Constructor TMethodLoopDetector.Create(const AMethodName        : String;
                                       ACallsThreshold          : Integer  = 30;
                                       AWindowMs                : Cardinal = 10000;
                                       ACooldownMs              : Cardinal = 60000;
                                       AMaxTracesPerSession     : Integer  = 5;
                                       AGapToExitMitigationMs   : Cardinal = 5000;
                                       ALogTrace                : Boolean  = True);
Begin
  Inherited Create;
  If ACallsThreshold <= 0 Then
    Raise Exception.Create('TMethodLoopDetector: ACallsThreshold deve ser > 0');

  FMethodName             := AMethodName;
  FCallsThreshold         := ACallsThreshold;
  FWindowMs               := AWindowMs;
  FCooldownMs             := ACooldownMs;
  FMaxTracesPerSession    := AMaxTracesPerSession;
  FGapToExitMitigationMs  := AGapToExitMitigationMs;
  FLogTrace               := ALogTrace;

  SetLength(FCallTicks, FCallsThreshold);
  FCallTicksIdx          := 0;
  FCallTicksFilled       := False;
  FTracesLoggedInSession := 0;
  FLastTraceTick         := 0;

  FLastTraceErrorMsg     := '';
  FLastTraceErrorTick    := 0;

  FInMitigationMode      := False;
  FLastCallTick          := 0;
End;

Destructor TMethodLoopDetector.Destroy;
Begin
  SetLength(FCallTicks, 0);
  Inherited;
End;

Function TMethodLoopDetector.fTickElapsed(const ATickInicial: Cardinal): Cardinal;
  Var
    LTickAtual : Cardinal;
Begin
  // Wraparound-safe (padrao de untThreadUtils.TempoDecorrido)
  LTickAtual := GetTickCount;
  If ATickInicial <= LTickAtual Then
    Result := LTickAtual - ATickInicial
  Else
    Result := (High(Cardinal) - ATickInicial) + LTickAtual;
End;

Function TMethodLoopDetector.fRegisterCall(const AAdditionalContext: String = ''): Boolean;
  Var
    LNowTick : Cardinal;
Begin
  Result := True;   // por padrao, o caller deve prosseguir com a execucao normal
  LNowTick := GetTickCount;

  // [GAP REAL] Se passou FGapToExitMitigationMs sem nenhuma chamada, o loop
  // realmente parou. Sai da FASE 2 e reseta o buffer para voltar a observar.
  If (FLastCallTick > 0) And
     (fTickElapsed(FLastCallTick) > FGapToExitMitigationMs) Then
  Begin
    FInMitigationMode := False;
    FCallTicksIdx     := 0;
    FCallTicksFilled  := False;
  End;
  FLastCallTick := LNowTick;

  // [FASE 2 LATCH] Em modo mitigacao: retorna False SEM atualizar o buffer.
  // Nao atualizar o buffer evita "diluicao" que poderia tirar do modo
  // artificialmente -- so o gap real (acima) tira da FASE 2.
  // A estrategia de mitigacao (Exit, Sleep+continua, Sleep+Exit, etc.) eh
  // responsabilidade do caller -- vide docstring no topo da unit.
  If FInMitigationMode Then
  Begin
    Result := False;
    Exit;
  End;

  // [FASE 1] Observador: registra tick e checa se atingiu threshold de loop
  FCallTicks[FCallTicksIdx] := LNowTick;
  FCallTicksIdx := (FCallTicksIdx + 1) Mod FCallsThreshold;
  If FCallTicksIdx = 0 Then
    FCallTicksFilled := True;

  // So checa loop quando o buffer ja deu pelo menos 1 volta
  If Not FCallTicksFilled Then Exit;

  // Tick mais antigo do buffer = FCallTicksIdx (proximo a sobrescrever)
  // Se ele esta dentro da janela, temos FCallsThreshold chamadas em <=FWindowMs
  If fTickElapsed(FCallTicks[FCallTicksIdx]) <= FWindowMs Then
  Begin
    // FASE 1->2: deteccao confirmada. Tenta logar trace se configurado.
    If FLogTrace Then
      pTryLogLoopTrace(AAdditionalContext);

    // [MITIGACAO] Latch engaja quando:
    //  - FLogTrace=False: imediatamente na deteccao (proteca silenciosa,
    //    sem dependencia de log).
    //  - FLogTrace=True: somente apos 1o trace gravado com sucesso. O 1o
    //    trace ainda executa com o metodo rodando normal (preserva captura
    //    autentica), e respeita "log-failure = mitigation-failure" -- se o
    //    log falhar, sintoma original reaparece para diagnostico.
    If (Not FLogTrace) Or (FTracesLoggedInSession >= 1) Then
    Begin
      FInMitigationMode := True;   // ativa latch da FASE 2
      Result := False;
    End;
  End;
End;

Procedure TMethodLoopDetector.pTryLogLoopTrace(const AAdditionalContext: String);
  Var
    strTrace, strFormsAtivos, strContexto : String;
    LDeltaJanelaMs : Cardinal;
Begin
  // Cooldown: nao grava 2 traces dentro de FCooldownMs
  If (FLastTraceTick > 0) And (fTickElapsed(FLastTraceTick) < FCooldownMs) Then
    Exit;

  // Anti-spam por sessao
  If FTracesLoggedInSession >= FMaxTracesPerSession Then Exit;

  Try
    LDeltaJanelaMs := fTickElapsed(FCallTicks[FCallTicksIdx]);
    strFormsAtivos := fGetNomeFormularios;
    strTrace       := fRetornaStack;

    strContexto :=
      '== TMethodLoopDetector ==' + #13#10 +
      'Method........: ' + FMethodName + #13#10 +
      'CallsThreshold: ' + IntToStr(FCallsThreshold) + #13#10 +
      'WindowMs......: ' + IntToStr(FWindowMs) + #13#10 +
      'DeltaJanelaMs.: ' + IntToStr(LDeltaJanelaMs) + #13#10 +
      'TracesGravados: ' + IntToStr(FTracesLoggedInSession + 1) + '/' +
                          IntToStr(FMaxTracesPerSession) + #13#10 +
      'CtxAdicional..: ' + AAdditionalContext + #13#10 +
      '== FORMS ATIVOS ==' + #13#10 + strFormsAtivos +
      '== STACK ==' + #13#10 + strTrace;

    pGravarErro(True,
                '[' + FMethodName + '] Loop detectado: ' +
                IntToStr(FCallsThreshold) + ' chamadas em ' +
                IntToStr(LDeltaJanelaMs) + 'ms',
                strContexto,
                '');

    Inc(FTracesLoggedInSession);
    FLastTraceTick := GetTickCount;
  Except
    On E: Exception Do
    Begin
      // Silencioso: instrumentacao nunca quebra fluxo principal nem aciona
      // mitigacao (FTracesLoggedInSession nao eh incrementado de proposito --
      // log-failure = mitigation-failure, sintoma original reaparece).
      // Mas preservamos a ultima mensagem para inspecao via property
      // LastTraceErrorMsg, permitindo diagnosticar falha do proprio detector.
      FLastTraceErrorMsg  := E.ClassName + ': ' + E.Message;
      FLastTraceErrorTick := GetTickCount;
      FLastTraceTick      := GetTickCount;
    End;
  End;
End;

end.
