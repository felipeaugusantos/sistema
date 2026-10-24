unit untTefEstacaoTcpTransporte;

{ Transporte de baixo nivel do lado estacao (Req. 456190) - SOCKET TCP
  LOOPBACK. Substitui untTefEstacaoPipeTransporte.pas (named pipe,
  removida em 2026-08-28).

  Historico da migracao: o desenho original (TefEstacaoService.exe
  servindo um named pipe "TefCitelCh") passou por duas arquiteturas de
  cliente - primeiro o plugin direto, depois um processo relay de sessao
  intermediario (TefCitelDvcRelay.exe) - e em AMBAS o WriteFile de
  resposta/dado para este pipe (ou o WriteFile do lado cliente escrevendo
  nele) travou sem fim, de forma imprevisivel, em testes de campo
  repetidos (ver IA\specs\456190\tasks.md, 2026-08-24 a 2026-08-28).
  Named pipe foi a UNICA constante em toda essa investigacao de quase 2
  semanas - EDR/AV, identidade de thread (mstsc.exe vs processo comum) e
  fronteira de sessao (interativa vs sessao 0) foram todos descartados um
  a um como causa isolada, mas a trava sempre reaparecia em QUALQUER
  combinacao que envolvesse named pipe. Socket TCP loopback, testado
  isoladamente e depois em producao (plugin<->relay), nunca falhou uma
  unica vez. Decisao (Rafael, 2026-08-28): eliminar named pipe e o
  processo relay de sessao por completo - o plugin conecta direto neste
  socket.

  ESTRUTURA (Req. 456190, Fase 3.5, 2026-09-03): o estado de protocolo
  que antes ficava em campos desta classe (buffer, messageId, dedup,
  ACKs pendentes, remontagem de fragmentos) mora agora em
  TTefEstacaoConexao - UMA instancia por conexao aceita, ou seja, por
  autcom.exe. Motivo: o operador abre VARIOS autcom.exe dentro da MESMA
  sessao TS, e WTSVirtualChannelOpenEx e chamado por processo, entao cada
  autcom.exe abre seu proprio canal DVC e o plugin abre seu proprio
  socket aqui. Com o desenho anterior (uma conexao por vez, listen(1)) o
  segundo autcom.exe conectava com sucesso mas nunca era lido, e travava
  no proprio login esperando a resposta de fConfiguraTefCitel. Ver
  IA\specs\456190\specs.md, secao 9 (P1).

  Confirmado em campo (2026-09-04, com o build do Passo 2 ainda em
  listen(1)): o AUTCOM B abriu, o plugin conectou (o connect() tem
  sucesso porque o kernel aceita no backlog), mandou fConfiguraTefCitel e
  ficou 5 retentativas de ACK sem resposta - o servico nunca chegou ao
  accept() seguinte, e o login do B so completou quando o AUTCOM A foi
  fechado. Passos 3 e 4 (2026-09-04) corrigem: accept() em laco, uma
  thread de leitura por conexao, e o roteador enderecando cada envelope a
  uma conexao especifica em vez de "a conexao viva".

  Interface publica compativel com TTefEstacaoPipeTransporte de proposito -
  untTefEstacaoRoteadorMensagens.pas so trocou o tipo/unit no Create, TODA
  a logica de despacho/hooks/observer/fila local (RF07) ficou intacta.
  pEnviaFrame mantem o mesmo contrato sincrono-com-excecao-em-falha de
  antes (levanta excecao se a escrita falhar) - pEnviaOuEnfileira
  continua funcionando sem alteracao nenhuma.

  Seguranca: socket ligado exclusivamente a 127.0.0.1 (nunca exposto na
  rede da estacao) - equivalente ao isolamento que o named pipe tinha,
  mas sem precisar de DACL/SDDL customizada (a superficie e so a propria
  maquina). O risco ja documentado em specs.md secao 5 ("canal sem
  autenticacao/autorizacao, precisa de validacao minima antes de
  producao") continua identico - TCP loopback nao resolve nem piora isso,
  qualquer processo local ainda pode conectar. }

interface

uses
  Winapi.Windows, Winapi.Winsock2, System.SysUtils, System.Classes, System.SyncObjs,
  System.Generics.Collections, untTefEstacaoLog;

const
  TEF_ESTACAO_TCP_PORTA = 47991;
  TEF_ESTACAO_TCP_TAMANHO_BUFFER = 65536;
  TEF_ESTACAO_TAMANHO_MAX_FRAME = 16 * 1024 * 1024; // cobre fragmentos base64 de DLL (RF10)
  TEF_ESTACAO_TCP_INTERVALO_RETENTATIVA_MS = 1000;
  { Protocolo de quadro v2 (Req. 456190, 2026-08-31) - espelha EXATAMENTE
    untTefCitelDvcTransporte.pas, TEF_DVC_FRAME_METADATA_SIZE (ver
    comentario completo la) - o plugin so repassa bytes crus entre o
    socket TCP e o canal DVC, sem reencapsular nada, entao os dois lados
    precisam concordar byte a byte no formato do quadro:
      [4 bytes] tamanho total (= TEF_ESTACAO_FRAME_METADATA_SIZE + payload)
      [4 bytes] messageId (UInt32, monotonico por remetente)
      [4 bytes] CRC32 do payload
      [1 byte]  tipo (TEF_ESTACAO_FRAME_TIPO_DADO ou _ACK - Fase 2)
      [N bytes] payload (JSON UTF-8 se tipo=DADO; 4 bytes de messageId
                 confirmado se tipo=ACK) }
  { Fragmentacao propria (Req. 456190, 2026-08-31) - espelha
    untTefCitelDvcTransporte.pas, TEF_DVC_TAMANHO_MAX_FRAGMENTO (ver
    comentario completo la) - achado de campo definitivo: o canal WTS do
    lado autcom, ao remontar uma mensagem que chega em 2+ chunks fisicos,
    as vezes entrega um pedaco que nao e o inicio real (cabecalho WTS
    correto, dado de outro ponto do payload) - varias defesas foram
    tentadas em cima disso sem eliminar a causa fisica. Decisao (Rafael,
    2026-08-31): fragmentar na ORIGEM (aqui, ou no autcom, dependendo de
    quem envia) em pedacos que cabem, sempre, num unico chunk fisico, e
    remontar no DESTINO pelo proprio protocolo de quadro. }
  TEF_ESTACAO_TAMANHO_MAX_FRAGMENTO = 1400; // bytes de payload por quadro - mesma margem do lado autcom
  TEF_ESTACAO_FRAME_METADATA_SIZE = SizeOf(UInt32) * 2 + SizeOf(Byte) + SizeOf(Word) * 2; // messageId + crc32 + tipo + numFragmento + totalFragmentos
  TEF_ESTACAO_FRAME_TIPO_DADO = 0;
  TEF_ESTACAO_FRAME_TIPO_ACK  = 1;

  { Fase 2 (2026-08-31) - espelha EXATAMENTE untTefCitelDvcTransporte.pas
    (ver comentario completo la) - ACK de transporte + retry, pra detectar
    perda de entrega em segundos em vez dos 30s do timeout de hook de
    negocio (TEF_ESTACAO_TIMEOUT_HOOK_MS, em untTefEstacaoRoteadorMensagens.pas). }
  TEF_ESTACAO_ACK_TIMEOUT_MS = 2000;
  TEF_ESTACAO_ACK_MAX_TENTATIVAS = 5;
  { Req. 456190, 2026-09-04 - espelha TEF_DVC_DEDUP_MAX_IDS (ver o motivo
    completo em untTefCitelDvcTransporte.pas). }
  TEF_ESTACAO_DEDUP_MAX_IDS = 512;

type
  ETefEstacaoTcpTransporte = class(Exception);

  TTefEstacaoConexao = class;

  TprocTefEstacaoFrameRecebido = procedure(AConexao: TTefEstacaoConexao; const AbytFrame: TBytes) of object;
  TprocTefEstacaoConectado      = procedure(AConexao: TTefEstacaoConexao) of object;
  TprocTefEstacaoDesconectado   = procedure(AConexao: TTefEstacaoConexao) of object;

  { Uma conexao TCP aceita = um plugin/canal DVC = UM autcom.exe
    (Req. 456190, Fase 3.5). Todo o estado de protocolo e por conexao:
    o messageId e o dedup so precisam ser monotonicos/ordenados dentro de
    um mesmo socket, e o par do outro lado (untTefCitelDvcTransporte.pas)
    tambem reinicia do zero a cada canal novo. }
  TTefEstacaoConexao = class
  private
    FsckCliente: TSocket;
    FcsEscrita: TCriticalSection;
    FblnConectado: Boolean;
    FarrBuffer: TBytes;
    FintProximoMessageId: Integer;
    { Deduplicacao por conjunto dos ultimos TEF_ESTACAO_DEDUP_MAX_IDS ids
      aceitos (Req. 456190, 2026-09-04) - espelha untTefCitelDvcTransporte.pas,
      onde esta o comentario completo com o achado de campo que motivou a
      troca. FdwUltimoIdRecebido virou marca d'agua so de diagnostico.

      Vale aqui pelo mesmo motivo que vale la, mesmo o trecho TCP entre
      plugin e servico nao perdendo nada: o quadro que chega neste socket
      atravessou ANTES o canal DVC (autcom -> plugin), e e esse trecho que
      perde. Uma retransmissao pode chegar aqui depois de um id maior
      exatamente como do outro lado. }
    FdwUltimoIdRecebido: UInt32;
    FdictIdsAceitos: TDictionary<UInt32, Boolean>;
    FqueIdsAceitos: TQueue<UInt32>;
    { Fase 2 (2026-08-31) - espelha untTefCitelDvcTransporte.pas (ver
      comentario completo la). }
    FcsAcks: TCriticalSection;
    FdictAcksPendentes: TObjectDictionary<UInt32, TEvent>;
    { Fragmentacao propria (2026-08-31) - espelha untTefCitelDvcTransporte.pas
      (mesmos campos, mesmo papel). }
    FarrPayloadFragmentado: TBytes;
    FwProximoFragmentoEsperado: Word;
    { Identidade do autcom.exe do outro lado (Req. 456190, Fase 3.5) -
      preenchida pelo roteador na PRIMEIRA chamada recebida, a partir de
      "contexto.pid"; no accept() ela ainda e desconhecida. }
    FdwPid: DWORD;
    { Passo 8 (RF21): marca que a fila local ja foi esvaziada para esta
      conexao. Vive aqui, junto de FdwPid, pelo mesmo motivo dele: e estado
      POR CONEXAO que o roteador preenche - o transporte nao olha nem um nem
      outro. Integer em vez de Boolean porque o test-and-set e feito com
      TInterlocked (ver fMarcaFilaLocalReenviada). }
    FintFilaLocalReenviada: Integer;
    FintIdConexao: Integer; // sequencial, so pra correlacionar linhas de log
    FthrLeitura: TThread;
    FOnFrameRecebido: TprocTefEstacaoFrameRecebido;
    FOnDesconectado: TprocTefEstacaoDesconectado;
    procedure pAcumulaBytesRecebidos(const AarrDados: TBytes);
    procedure pExtraiFramesDisponiveis;
    function fAceitaMessageId(const AdwMessageId: UInt32): Boolean;
    function fMontaFrame(const AdwMessageId: UInt32; const AbytTipo: Byte;
      const AwNumFragmento, AwTotalFragmentos: Word; const AbytPayload: TBytes): TBytes;
    procedure pEnviaFrameBruto(const AarrFrame: TBytes);
    procedure pEnviaAck(const AdwMessageIdConfirmado: UInt32);
    procedure pEnviaUmFragmento(const AbytPayload: TBytes; const AwNumFragmento, AwTotalFragmentos: Word);
    procedure pAcordaAcksPendentes;
    procedure pLoopLeitura;
  public
    constructor Create(const AsckCliente: TSocket; const AintIdConexao: Integer;
      AOnFrameRecebido: TprocTefEstacaoFrameRecebido;
      AOnDesconectado: TprocTefEstacaoDesconectado);
    destructor Destroy; override;
    procedure pIniciaLeitura;
    procedure pNotificaDesconexao;
    procedure pDesligaSocket;
    procedure pFechaSocket;
    procedure pAguardaFimDaLeitura;
    procedure pEnviaFrame(const AbytPayload: TBytes);
    property blnConectado: Boolean read FblnConectado;
    property dwPid: DWORD read FdwPid write FdwPid;
    property intIdConexao: Integer read FintIdConexao;
    { Devolve True uma UNICA vez por conexao, para quem chamar primeiro
      (Passo 8, RF21) - quem receber True e o dono do reenvio da fila
      local. Duas threads de despacho da mesma conexao rodam concorrentes
      (ver comentario em pEnviaUmFragmento), dai o TInterlocked. }
    function fMarcaFilaLocalReenviada: Boolean;
  end;

  TTefEstacaoTcpTransporte = class
  private
    FsckOuvinte: TSocket;
    FthrAceitador: TThread;
    FblnParar: Boolean;
    FcsConexoes: TCriticalSection;
    { FlstConexoes = so as vivas, NAO possui os objetos.
      FlstTodasConexoes = dono unico de toda conexao ja aceita, viva ou
      nao, e so libera no destructor (Req. 456190, Fase 3.5). Nenhuma
      conexao e destruida enquanto o servico roda: uma thread de despacho
      pode estar dentro de pEnviaFrame de uma conexao no exato momento em
      que a thread de leitura dela detecta a queda, e nao ha ponto seguro
      barato pra liberar o objeto sob ela. Mesmo raciocinio adotado para
      as instancias ITefCitel orfas no roteador. O que e devolvido cedo e
      o recurso caro - o handle do socket, fechado em pFechaSocket assim
      que o laco de leitura termina; o que fica e um objeto pequeno (dois
      criticals e um dicionario vazio), em quantidade limitada pelo numero
      de reconexoes ate o servico reiniciar. }
    FlstConexoes: TObjectList<TTefEstacaoConexao>;
    FlstTodasConexoes: TObjectList<TTefEstacaoConexao>;
    FintProximoIdConexao: Integer;
    FOnFrameRecebido: TprocTefEstacaoFrameRecebido;
    FOnConectado: TprocTefEstacaoConectado;
    FOnDesconectado: TprocTefEstacaoDesconectado;
    function fCriaSocketOuvinte: TSocket;
    procedure pLoopAceitador;
    { Repassadores. A conexao chama ESTES, nunca o campo FOnXxx capturado
      no accept(): o roteador atribui os callbacks depois de construir o
      transporte, e a thread de accept ja esta rodando nesse meio tempo -
      capturar o valor no accept() daria nil numa conexao muito rapida.
      Assim a resolucao acontece na hora do evento, como era antes. }
    procedure pOnConexaoFrameRecebido(AConexao: TTefEstacaoConexao; const AbytFrame: TBytes);
    procedure pOnConexaoDesconectada(AConexao: TTefEstacaoConexao);
  public
    constructor Create;
    destructor Destroy; override;
    { Nao existe mais "a conexao" do transporte (Req. 456190, Passo 4): quem
      envia sempre escolhe a conexao de destino - TTefEstacaoConexao.pEnviaFrame.
      Ver untTefEstacaoRoteadorMensagens.pas, fConexaoDeSaida. }
    property OnFrameRecebido: TprocTefEstacaoFrameRecebido read FOnFrameRecebido write FOnFrameRecebido;
    property OnConectado: TprocTefEstacaoConectado read FOnConectado write FOnConectado;
    property OnDesconectado: TprocTefEstacaoDesconectado read FOnDesconectado write FOnDesconectado;
  end;

implementation

procedure pLogaTcpEstacao(const AstrMsg: String);
begin
  { Corpo migrado para untTefEstacaoLog em 2026-09-10 (Req. 456190, RF22).
    Continua gravando no MESMO arquivo do roteador, de proposito, para as
    linhas intercalarem em ordem cronologica - e agora com o mesmo lock,
    que antes nao existia entre as duas funcoes. Ver untTefEstacaoLog.pas. }
  pLogaEstacaoNivel(TEF_LOG_NIVEL_NORMAL, AstrMsg);
end;

function fCrc32(const ABuffer: TBytes): UInt32;
const
  CRC32_POLINOMIO = $EDB88320;
var
  I, J: Integer;
  LdwCrc: UInt32;
begin
  { Identica a untTefCitelDvcTransporte.pas, fCrc32 - CRC-32 (IEEE 802.3)
    bit a bit, sem tabela (payloads desta feature sao poucos KB, exceto
    RF10/base64 ate 16MB, ainda assim rapido o bastante). }
  LdwCrc := $FFFFFFFF;
  for I := 0 to Length(ABuffer) - 1 do
  begin
    LdwCrc := LdwCrc xor ABuffer[I];
    for J := 0 to 7 do
      if (LdwCrc and 1) <> 0 then
        LdwCrc := (LdwCrc shr 1) xor CRC32_POLINOMIO
      else
        LdwCrc := LdwCrc shr 1;
  end;
  Result := not LdwCrc;
end;

{ TTefEstacaoConexao }

constructor TTefEstacaoConexao.Create(const AsckCliente: TSocket; const AintIdConexao: Integer;
  AOnFrameRecebido: TprocTefEstacaoFrameRecebido;
  AOnDesconectado: TprocTefEstacaoDesconectado);
begin
  inherited Create;
  FsckCliente := AsckCliente;
  FintIdConexao := AintIdConexao;
  FOnFrameRecebido := AOnFrameRecebido;
  FOnDesconectado := AOnDesconectado;

  FcsEscrita := TCriticalSection.Create;
  FcsAcks := TCriticalSection.Create;
  FdictAcksPendentes := TObjectDictionary<UInt32, TEvent>.Create([doOwnsValues]);

  FdwPid := 0;
  FintFilaLocalReenviada := 0;
  FblnConectado := True;
  SetLength(FarrBuffer, 0);
  FintProximoMessageId := 0;
  FdwUltimoIdRecebido := 0;
  FdictIdsAceitos := TDictionary<UInt32, Boolean>.Create;
  FqueIdsAceitos := TQueue<UInt32>.Create;
  SetLength(FarrPayloadFragmentado, 0);
  FwProximoFragmentoEsperado := 0;
end;

destructor TTefEstacaoConexao.Destroy;
begin
  FblnConectado := False;
  pAcordaAcksPendentes;
  pFechaSocket;

  if Assigned(FthrLeitura) then
    FthrLeitura.Free;

  FdictAcksPendentes.Free;
  FcsAcks.Free;
  FdictIdsAceitos.Free;
  FqueIdsAceitos.Free;
  FcsEscrita.Free;
  inherited;
end;

function TTefEstacaoConexao.fMarcaFilaLocalReenviada: Boolean;
begin
  Result := TInterlocked.Exchange(FintFilaLocalReenviada, 1) = 0;
end;

procedure TTefEstacaoConexao.pIniciaLeitura;
begin
  FthrLeitura := TThread.CreateAnonymousThread(pLoopLeitura);
  FthrLeitura.FreeOnTerminate := False;
  FthrLeitura.Start;
end;

procedure TTefEstacaoConexao.pAguardaFimDaLeitura;
begin
  if Assigned(FthrLeitura) then
    FthrLeitura.WaitFor;
end;

procedure TTefEstacaoConexao.pDesligaSocket;
begin
  { shutdown()/closesocket() sao seguros de chamar de qualquer thread a
    qualquer momento pra destravar um recv() pendente - mais confiavel
    que o CancelSynchronousIo que o named pipe precisava (ver historico
    documentado no cabecalho desta unit e em untTefCitelDvcPluginImpl.pas). }
  if FsckCliente <> INVALID_SOCKET then
    shutdown(FsckCliente, SD_BOTH);
end;

procedure TTefEstacaoConexao.pFechaSocket;
begin
  { Fecha sob FcsEscrita, o MESMO lock de pEnviaFrameBruto, de proposito
    (Req. 456190, Fase 3.5): closesocket devolve o valor do handle ao
    Winsock, que pode reaproveita-lo numa conexao NOVA - um send()
    atrasado de outra thread escreveria no socket errado. Com o lock, ou
    o envio acontece antes do fechamento (handle valido), ou ele ve
    INVALID_SOCKET e falha limpo. Idempotente: chamada no fim do laco de
    leitura e de novo no destructor.
    pDesligaSocket (shutdown) continua FORA do lock - e justamente ela que
    precisa destravar um send()/recv() bloqueado que esta segurando o
    lock. }
  FcsEscrita.Enter;
  try
    if FsckCliente <> INVALID_SOCKET then
    begin
      closesocket(FsckCliente);
      FsckCliente := INVALID_SOCKET;
    end;
  finally
    FcsEscrita.Leave;
  end;
end;

procedure TTefEstacaoConexao.pAcordaAcksPendentes;
var
  LobjEvento: TEvent;
begin
  { Acorda qualquer pEnviaFrame ainda preso esperando ACK - ver comentario
    espelhado em untTefCitelDvcTransporte.pas, destructor. }
  FcsAcks.Enter;
  try
    for LobjEvento in FdictAcksPendentes.Values do
      LobjEvento.SetEvent;
  finally
    FcsAcks.Leave;
  end;
end;

procedure TTefEstacaoConexao.pNotificaDesconexao;
begin
  FblnConectado := False;
  pAcordaAcksPendentes;
  if Assigned(FOnDesconectado) then
    FOnDesconectado(Self);
end;

procedure TTefEstacaoConexao.pLoopLeitura;
var
  LarrBufLeitura: array[0..TEF_ESTACAO_TCP_TAMANHO_BUFFER - 1] of Byte;
  LintBytesLidos: Integer;
  LarrPayload: TBytes;
begin
  while FblnConectado do
  begin
    LintBytesLidos := recv(FsckCliente, LarrBufLeitura, SizeOf(LarrBufLeitura), 0);
    if LintBytesLidos <= 0 then
    begin
      pLogaTcpEstacao(Format('TCP[con=%d]: recv retornou %d (erro %d) - desconectando.',
        [FintIdConexao, LintBytesLidos, WSAGetLastError]));
      pNotificaDesconexao;
      Break;
    end;

    pLogaTcpEstacao(Format('TCP[con=%d]: recebidos %d bytes.', [FintIdConexao, LintBytesLidos]));
    SetLength(LarrPayload, LintBytesLidos);
    Move(LarrBufLeitura[0], LarrPayload[0], LintBytesLidos);
    try
      pAcumulaBytesRecebidos(LarrPayload);
    except
      on E: Exception do
      begin
        { Mesma protecao ja existente na versao named pipe: uma excecao
          aqui (ex.: frame maior que TEF_ESTACAO_TAMANHO_MAX_FRAME) nao
          pode derrubar esta thread em silencio. }
        pLogaTcpEstacao(Format('TCP[con=%d]: excecao processando bytes recebidos: %s - desconectando.',
          [FintIdConexao, E.Message]));
        pNotificaDesconexao;
        Break;
      end;
    end;
  end;

  { Devolve o handle ao sistema assim que a conexao acaba - o OBJETO
    continua vivo (ver comentario de FlstTodasConexoes), mas o socket nao
    precisa ficar em CLOSE_WAIT ate o servico reiniciar. }
  pFechaSocket;
end;

procedure TTefEstacaoConexao.pAcumulaBytesRecebidos(const AarrDados: TBytes);
var
  LintTamAntigo: Integer;
begin
  LintTamAntigo := Length(FarrBuffer);
  SetLength(FarrBuffer, LintTamAntigo + Length(AarrDados));
  Move(AarrDados[0], FarrBuffer[LintTamAntigo], Length(AarrDados));
  pExtraiFramesDisponiveis;
end;

procedure TTefEstacaoConexao.pExtraiFramesDisponiveis;
var
  LintTamanhoFrame: UInt32;
  LarrFrameCompleto, LarrPayload: TBytes;
  LintRestante: Integer;
  LdwMessageId, LdwCrcRecebido, LdwCrcCalculado: UInt32;
  LbytTipo: Byte;
  LwNumFragmento, LwTotalFragmentos: Word;
  LdwMessageIdConfirmado: UInt32;
  LobjEventoAck: TEvent;
  LintTamAntigoFrag: Integer;
begin
  while Cardinal(Length(FarrBuffer)) >= SizeOf(UInt32) do
  begin
    Move(FarrBuffer[0], LintTamanhoFrame, SizeOf(UInt32));

    if (LintTamanhoFrame > TEF_ESTACAO_TAMANHO_MAX_FRAME) or
       (LintTamanhoFrame < TEF_ESTACAO_FRAME_METADATA_SIZE) then
      raise ETefEstacaoTcpTransporte.CreateFmt(
        'Frame recebido no socket excede o tamanho maximo suportado (%d bytes).', [LintTamanhoFrame]);

    if Cardinal(Length(FarrBuffer)) < SizeOf(UInt32) + LintTamanhoFrame then
      Break; // frame ainda incompleto - aguarda mais leituras

    SetLength(LarrFrameCompleto, LintTamanhoFrame);
    Move(FarrBuffer[SizeOf(UInt32)], LarrFrameCompleto[0], LintTamanhoFrame);

    LintRestante := Length(FarrBuffer) - SizeOf(UInt32) - Integer(LintTamanhoFrame);
    if LintRestante > 0 then
      Move(FarrBuffer[SizeOf(UInt32) + Integer(LintTamanhoFrame)], FarrBuffer[0], LintRestante);
    SetLength(FarrBuffer, LintRestante);

    Move(LarrFrameCompleto[0], LdwMessageId, SizeOf(UInt32));
    Move(LarrFrameCompleto[SizeOf(UInt32)], LdwCrcRecebido, SizeOf(UInt32));
    LbytTipo := LarrFrameCompleto[SizeOf(UInt32) * 2];
    Move(LarrFrameCompleto[SizeOf(UInt32) * 2 + SizeOf(Byte)], LwNumFragmento, SizeOf(Word));
    Move(LarrFrameCompleto[SizeOf(UInt32) * 2 + SizeOf(Byte) + SizeOf(Word)], LwTotalFragmentos, SizeOf(Word));
    SetLength(LarrPayload, Integer(LintTamanhoFrame) - TEF_ESTACAO_FRAME_METADATA_SIZE);
    if Length(LarrPayload) > 0 then
      Move(LarrFrameCompleto[TEF_ESTACAO_FRAME_METADATA_SIZE], LarrPayload[0], Length(LarrPayload));

    { Protocolo v2 (2026-08-31) - ver comentario espelhado em
      untTefCitelDvcTransporte.pas, pExtraiFramesDisponiveis. Quadro com
      CRC invalido ou messageId ja visto e descartado aqui, sem repassar
      ao roteador. }
    LdwCrcCalculado := fCrc32(LarrPayload);
    if LdwCrcCalculado <> LdwCrcRecebido then
    begin
      pLogaTcpEstacao(Format(
        'TCP[con=%d]: quadro descartado - CRC invalido (messageId=%d, recebido=%.8x, calculado=%.8x, %d bytes de payload).',
        [FintIdConexao, LdwMessageId, LdwCrcRecebido, LdwCrcCalculado, Length(LarrPayload)]));
      Continue; // CRC nao bate - nao da pra confiar nem no messageId, nao manda ACK
    end;

    { Fase 2 (2026-08-31) - quadro tipo ACK: so sinaliza o TEvent que
      pEnviaFrame esta esperando, nunca repassa ao roteador. }
    if LbytTipo = TEF_ESTACAO_FRAME_TIPO_ACK then
    begin
      if Length(LarrPayload) >= SizeOf(UInt32) then
      begin
        Move(LarrPayload[0], LdwMessageIdConfirmado, SizeOf(UInt32));
        FcsAcks.Enter;
        try
          if FdictAcksPendentes.TryGetValue(LdwMessageIdConfirmado, LobjEventoAck) then
            LobjEventoAck.SetEvent;
        finally
          FcsAcks.Leave;
        end;
      end;
      Continue;
    end;

    if not fAceitaMessageId(LdwMessageId) then
    begin
      pLogaTcpEstacao(Format(
        'TCP[con=%d]: quadro duplicado descartado (messageId=%d, maior aceito=%d) - reenviando ACK mesmo assim.',
        [FintIdConexao, LdwMessageId, FdwUltimoIdRecebido]));
      try
        pEnviaAck(LdwMessageId);
      except
        on E: Exception do
          pLogaTcpEstacao(Format(
            'TCP[con=%d]: falha ao reenviar ACK do messageId=%d: %s', [FintIdConexao, LdwMessageId, E.Message]));
      end;
      Continue;
    end;

    { Quadro ATRASADO - ver o comentario equivalente em
      untTefCitelDvcTransporte.pas: id menor que a marca d'agua e mesmo assim
      novo, ou seja, a primeira entrega se perdeu no canal DVC e o autcom
      retransmitiu. Antes de 2026-09-04 este quadro ia pro lixo. }
    if (FdwUltimoIdRecebido <> 0) and (LdwMessageId < FdwUltimoIdRecebido) then
      pLogaTcpEstacao(Format(
        'TCP[con=%d]: quadro ATRASADO aceito (messageId=%d, maior aceito=%d) - ' +
        'primeira entrega perdida no canal, recuperado pela retransmissao do autcom.',
        [FintIdConexao, LdwMessageId, FdwUltimoIdRecebido]));

    if LdwMessageId > FdwUltimoIdRecebido then
      FdwUltimoIdRecebido := LdwMessageId;
    try
      pEnviaAck(LdwMessageId);
    except
      on E: Exception do
        pLogaTcpEstacao(Format(
          'TCP[con=%d]: falha ao enviar ACK do messageId=%d: %s - quadro aceito mesmo assim.',
          [FintIdConexao, LdwMessageId, E.Message]));
    end;

    pLogaTcpEstacao(Format('TCP[con=%d]: quadro aceito (messageId=%d, tamanho=%d) - repassando ao roteador.',
      [FintIdConexao, LdwMessageId, Length(LarrPayload)]));

    if LwTotalFragmentos <= 1 then
    begin
      { caso comum, sem fragmentacao - comportamento identico ao de sempre. }
      if Assigned(FOnFrameRecebido) then
        FOnFrameRecebido(Self, LarrPayload);
      Continue;
    end;

    { Fragmentacao propria (2026-08-31) - espelha untTefCitelDvcTransporte.pas
      (ver comentario completo la). }
    if LwNumFragmento = 0 then
    begin
      if FwProximoFragmentoEsperado <> 0 then
        pLogaTcpEstacao(Format(
          'TCP[con=%d]: nova mensagem fragmentada comecando (messageId=%d) com uma reassemblagem ' +
          'anterior incompleta (%d fragmentos acumulados) - descartando a anterior.',
          [FintIdConexao, LdwMessageId, FwProximoFragmentoEsperado]));
      SetLength(FarrPayloadFragmentado, 0);
      FwProximoFragmentoEsperado := 0;
    end
    else if LwNumFragmento <> FwProximoFragmentoEsperado then
    begin
      pLogaTcpEstacao(Format(
        'TCP[con=%d]: fragmento fora de ordem descartado (messageId=%d, recebido=%d, esperado=%d).',
        [FintIdConexao, LdwMessageId, LwNumFragmento, FwProximoFragmentoEsperado]));
      Continue;
    end;

    LintTamAntigoFrag := Length(FarrPayloadFragmentado);
    SetLength(FarrPayloadFragmentado, LintTamAntigoFrag + Length(LarrPayload));
    if Length(LarrPayload) > 0 then
      Move(LarrPayload[0], FarrPayloadFragmentado[LintTamAntigoFrag], Length(LarrPayload));
    FwProximoFragmentoEsperado := LwNumFragmento + 1;

    pLogaTcpEstacao(Format(
      'TCP[con=%d]: fragmento %d/%d aceito (messageId=%d, %d bytes), acumulado=%d bytes.',
      [FintIdConexao, LwNumFragmento + 1, LwTotalFragmentos, LdwMessageId, Length(LarrPayload), Length(FarrPayloadFragmentado)]));

    if LwNumFragmento = LwTotalFragmentos - 1 then
    begin
      pLogaTcpEstacao(Format(
        'TCP[con=%d]: mensagem fragmentada completa (%d fragmentos, %d bytes no total).',
        [FintIdConexao, LwTotalFragmentos, Length(FarrPayloadFragmentado)]));
      if Assigned(FOnFrameRecebido) then
        FOnFrameRecebido(Self, FarrPayloadFragmentado);
      SetLength(FarrPayloadFragmentado, 0);
      FwProximoFragmentoEsperado := 0;
    end;
  end;
end;

function TTefEstacaoConexao.fMontaFrame(const AdwMessageId: UInt32;
  const AbytTipo: Byte; const AwNumFragmento, AwTotalFragmentos: Word;
  const AbytPayload: TBytes): TBytes;
var
  LintTamanho: UInt32;
  LdwCrc: UInt32;
  LintOffsetTipo: Integer;
begin
  LdwCrc := fCrc32(AbytPayload);
  LintTamanho := TEF_ESTACAO_FRAME_METADATA_SIZE + Length(AbytPayload);
  LintOffsetTipo := SizeOf(UInt32) * 2 + SizeOf(UInt32); // = apos [len][messageId][crc]

  SetLength(Result, SizeOf(UInt32) + LintTamanho);
  Move(LintTamanho, Result[0], SizeOf(UInt32));
  Move(AdwMessageId, Result[SizeOf(UInt32)], SizeOf(UInt32));
  Move(LdwCrc, Result[SizeOf(UInt32) * 2], SizeOf(UInt32));
  Result[LintOffsetTipo] := AbytTipo;
  Move(AwNumFragmento, Result[LintOffsetTipo + SizeOf(Byte)], SizeOf(Word));
  Move(AwTotalFragmentos, Result[LintOffsetTipo + SizeOf(Byte) + SizeOf(Word)], SizeOf(Word));
  if Length(AbytPayload) > 0 then
    Move(AbytPayload[0], Result[TEF_ESTACAO_FRAME_METADATA_SIZE + SizeOf(UInt32)], Length(AbytPayload));
end;

{ Espelha TTefCitelDvcTransporte.fAceitaMessageId (Req. 456190, 2026-09-04) -
  o comentario completo esta la. True = messageId novo (e ja registrado);
  False = duplicata de verdade. Roda so na thread de leitura desta conexao. }
function TTefEstacaoConexao.fAceitaMessageId(const AdwMessageId: UInt32): Boolean;
var
  LdwMaisAntigo: UInt32;
begin
  Result := not FdictIdsAceitos.ContainsKey(AdwMessageId);
  if not Result then
    Exit;

  FdictIdsAceitos.Add(AdwMessageId, True);
  FqueIdsAceitos.Enqueue(AdwMessageId);
  while FqueIdsAceitos.Count > TEF_ESTACAO_DEDUP_MAX_IDS do
  begin
    LdwMaisAntigo := FqueIdsAceitos.Dequeue;
    FdictIdsAceitos.Remove(LdwMaisAntigo);
  end;
end;

procedure TTefEstacaoConexao.pEnviaFrameBruto(const AarrFrame: TBytes);
var
  LintEnviado: Integer;
  LintTotalEnviado: Integer;
begin
  FcsEscrita.Enter;
  try
    if FsckCliente = INVALID_SOCKET then
      raise ETefEstacaoTcpTransporte.Create('Socket da estacao ja foi fechado - conexao encerrada.');

    LintTotalEnviado := 0;
    while LintTotalEnviado < Length(AarrFrame) do
    begin
      LintEnviado := send(FsckCliente, AarrFrame[LintTotalEnviado], Length(AarrFrame) - LintTotalEnviado, 0);
      if (LintEnviado = SOCKET_ERROR) or (LintEnviado = 0) then
        raise ETefEstacaoTcpTransporte.CreateFmt('Falha ao escrever no socket da estacao (erro %d).', [WSAGetLastError]);
      Inc(LintTotalEnviado, LintEnviado);
    end;
  finally
    FcsEscrita.Leave;
  end;
end;

procedure TTefEstacaoConexao.pEnviaAck(const AdwMessageIdConfirmado: UInt32);
var
  LdwMessageIdDoAck: UInt32;
  LarrPayload: TBytes;
begin
  { Corrigido (Req. 456190, 2026-09-02) - mesmo gap ja identificado e
    corrigido em pEnviaUmFragmento (comentario completo la): esta funcao
    fazia TInterlocked.Increment e pEnviaFrameBruto como dois passos
    separados, sem lock cobrindo os dois juntos. Espelhado em
    untTefCitelDvcTransporte.pas, pEnviaAck - ver o comentario la para o
    achado de campo que motivou esta correcao. }
  FcsEscrita.Enter;
  try
    LdwMessageIdDoAck := UInt32(TInterlocked.Increment(FintProximoMessageId));
    SetLength(LarrPayload, SizeOf(UInt32));
    Move(AdwMessageIdConfirmado, LarrPayload[0], SizeOf(UInt32));
    pEnviaFrameBruto(fMontaFrame(LdwMessageIdDoAck, TEF_ESTACAO_FRAME_TIPO_ACK, 0, 1, LarrPayload));
  finally
    FcsEscrita.Leave;
  end;
end;

procedure TTefEstacaoConexao.pEnviaFrame(const AbytPayload: TBytes);
var
  LwTotalFragmentos, LwFrag: Word;
  LintOffset, LintTamanhoFragmento: Integer;
  LarrFragmento: TBytes;
begin
  if Length(AbytPayload) <= TEF_ESTACAO_TAMANHO_MAX_FRAGMENTO then
  begin
    pEnviaUmFragmento(AbytPayload, 0, 1);
    Exit;
  end;

  { Fragmentacao propria (2026-08-31) - espelha untTefCitelDvcTransporte.pas
    (ver comentario completo la). Envio sequencial, ACK-gated: cada
    fragmento so e enviado depois do anterior confirmar (ou esgotar
    tentativas) - o receptor sempre ve os fragmentos em ordem. }
  LwTotalFragmentos := (Length(AbytPayload) + TEF_ESTACAO_TAMANHO_MAX_FRAGMENTO - 1)
    div TEF_ESTACAO_TAMANHO_MAX_FRAGMENTO;
  pLogaTcpEstacao(Format(
    'TCP[con=%d]: payload de %d bytes excede %d - fragmentando em %d pedacos de ate %d bytes.',
    [FintIdConexao, Length(AbytPayload), TEF_ESTACAO_TAMANHO_MAX_FRAGMENTO, LwTotalFragmentos, TEF_ESTACAO_TAMANHO_MAX_FRAGMENTO]));

  LintOffset := 0;
  for LwFrag := 0 to LwTotalFragmentos - 1 do
  begin
    LintTamanhoFragmento := Length(AbytPayload) - LintOffset;
    if LintTamanhoFragmento > TEF_ESTACAO_TAMANHO_MAX_FRAGMENTO then
      LintTamanhoFragmento := TEF_ESTACAO_TAMANHO_MAX_FRAGMENTO;

    SetLength(LarrFragmento, LintTamanhoFragmento);
    if LintTamanhoFragmento > 0 then
      Move(AbytPayload[LintOffset], LarrFragmento[0], LintTamanhoFragmento);

    pEnviaUmFragmento(LarrFragmento, LwFrag, LwTotalFragmentos);

    Inc(LintOffset, LintTamanhoFragmento);
  end;
end;

procedure TTefEstacaoConexao.pEnviaUmFragmento(const AbytPayload: TBytes;
  const AwNumFragmento, AwTotalFragmentos: Word);
var
  LdwMessageId: UInt32;
  LarrFrame: TBytes;
  LobjEventoAck: TEvent;
  LintTentativa: Integer;
begin
  if not FblnConectado then
    raise ETefEstacaoTcpTransporte.Create('Socket da estacao nao esta conectado ao plugin.');

  { Corrida de campo encontrada e corrigida (Req. 456190, 2026-09-02): atribuir o
    messageId (TInterlocked.Increment) e escrever o quadro no socket (pEnviaFrameBruto,
    que so protege a escrita em si via FcsEscrita) eram dois passos separados - duas
    threads despachando chamadas concorrentemente (Bug 2, 2026-08-28) podiam pegar
    messageId em ordem (ex.: 202, depois 203/204/205 de outra thread) mas escrever fora
    de ordem (203-205 primeiro), fazendo o messageId mais antigo chegar no autcom DEPOIS
    de ids maiores ja aceitos. O dedup por ordem estrita em
    untTefCitelDvcTransporte.pas (LdwMessageId <= FdwUltimoIdRecebido) descartava esse
    quadro como "duplicado" mesmo sendo a primeira entrega real, deixando a fChamaRpc
    correspondente esperando pra sempre - achado em campo: um pInfo21 aninhado dentro
    de fPassarCartao nunca recebia resposta, travando a tela do autcom mesmo com a
    resposta do fPassarCartao ja tendo chegado certinha (a fChamaRpc de fora so
    desenrola depois que a de dentro, na mesma pilha reentrante, tambem desenrolar).
    Corrigido: FcsEscrita (TCriticalSection, reentrante por thread) agora tambem
    protege a atribuicao do messageId e o primeiro envio, garantindo que a ordem de
    atribuicao bata com a ordem real no socket - TCP preserva ordem depois disso, e o
    worker de escrita do plugin (pLoopEscritaWorker, untTefCitelDvcPluginImpl.pas) e
    FIFO estrito (confirmado no codigo), entao nada mais no caminho pode reordenar.
    Retentativas de ACK continuam fora do lock (reenviam o MESMO messageId - nao ha
    ordem nova pra preservar contra elas).
    Req. 456190, Fase 3.5: o lock e por CONEXAO agora, que e exatamente o escopo em
    que essa garantia precisa valer - a ordem so importa dentro de um mesmo socket. }
  FcsEscrita.Enter;
  try
    LdwMessageId := UInt32(TInterlocked.Increment(FintProximoMessageId));
    LarrFrame := fMontaFrame(LdwMessageId, TEF_ESTACAO_FRAME_TIPO_DADO, AwNumFragmento, AwTotalFragmentos, AbytPayload);

    { Fase 2 (2026-08-31) - ver comentario espelhado em
      untTefCitelDvcTransporte.pas, pEnviaFrame. }
    LobjEventoAck := TEvent.Create(nil, True, False, '');
    FcsAcks.Enter;
    try
      FdictAcksPendentes.AddOrSetValue(LdwMessageId, LobjEventoAck);
    finally
      FcsAcks.Leave;
    end;

    pEnviaFrameBruto(LarrFrame);
  finally
    FcsEscrita.Leave;
  end;

  try
    for LintTentativa := 1 to TEF_ESTACAO_ACK_MAX_TENTATIVAS do
    begin
      if LintTentativa > 1 then
      begin
        if not FblnConectado then
          raise ETefEstacaoTcpTransporte.Create(
            'Socket da estacao desconectou enquanto aguardava confirmacao de entrega.');

        pEnviaFrameBruto(LarrFrame); // retentativa - mesmo messageId, fora do lock de propósito
      end;

      if LobjEventoAck.WaitFor(TEF_ESTACAO_ACK_TIMEOUT_MS) = wrSignaled then
      begin
        if FblnConectado then
          Exit;
        raise ETefEstacaoTcpTransporte.Create(
          'Socket da estacao desconectou enquanto aguardava confirmacao de entrega.');
      end;

      pLogaTcpEstacao(Format(
        'TCP[con=%d]: sem ACK do messageId=%d apos %d ms (tentativa %d/%d) - reenviando.',
        [FintIdConexao, LdwMessageId, TEF_ESTACAO_ACK_TIMEOUT_MS, LintTentativa, TEF_ESTACAO_ACK_MAX_TENTATIVAS]));
    end;

    { Achado de campo (2026-08-31) - ver comentario completo espelhado em
      untTefCitelDvcTransporte.pas, pEnviaFrame: lancar excecao aqui e PIOR
      que o comportamento de antes da Fase 2 (nao capturada em nenhum
      ponto da cadeia de chamada, derruba a sessao inteira - aconteceu de
      verdade em campo, ate na 1a chamada). Sem ACK apos todas as
      tentativas, segue como melhor esforco (igual a uma escrita
      "bem sucedida" de antes, sem garantia de entrega) - o timeout de
      negocio correspondente (hook de 30s, etc.) continua sendo o
      backstop final se o dado realmente nao chegou. }
    pLogaTcpEstacao(Format(
      'TCP[con=%d]: socket NAO confirmou a entrega do messageId=%d apos %d tentativas ' +
      '- seguindo sem confirmacao (melhor esforco, como antes da Fase 2).',
      [FintIdConexao, LdwMessageId, TEF_ESTACAO_ACK_MAX_TENTATIVAS]));
  finally
    FcsAcks.Enter;
    try
      FdictAcksPendentes.Remove(LdwMessageId);
    finally
      FcsAcks.Leave;
    end;
  end;
end;

{ TTefEstacaoTcpTransporte }

constructor TTefEstacaoTcpTransporte.Create;
var
  LobjWsaData: TWSAData;
begin
  inherited Create;
  WSAStartup($0202, LobjWsaData);

  FsckOuvinte := INVALID_SOCKET;
  FblnParar := False;
  FintProximoIdConexao := 0;
  FcsConexoes := TCriticalSection.Create;
  FlstConexoes := TObjectList<TTefEstacaoConexao>.Create(False);     // nao possui: quem libera e FlstTodasConexoes
  FlstTodasConexoes := TObjectList<TTefEstacaoConexao>.Create(True); // dono unico - libera so no destructor

  FthrAceitador := TThread.CreateAnonymousThread(pLoopAceitador);
  FthrAceitador.FreeOnTerminate := False;
  FthrAceitador.Start;
end;

destructor TTefEstacaoTcpTransporte.Destroy;
var
  LConexao: TTefEstacaoConexao;
  LarrTodas: TArray<TTefEstacaoConexao>;
begin
  FblnParar := True;

  { closesocket no ouvinte desbloqueia um accept() pendente; shutdown em
    cada conexao viva desbloqueia o recv() da thread de leitura dela. }
  if FsckOuvinte <> INVALID_SOCKET then
    closesocket(FsckOuvinte);

  FcsConexoes.Enter;
  try
    LarrTodas := FlstTodasConexoes.ToArray;
  finally
    FcsConexoes.Leave;
  end;

  for LConexao in LarrTodas do
  begin
    LConexao.FblnConectado := False;
    LConexao.pDesligaSocket;
  end;

  if Assigned(FthrAceitador) then
  begin
    FthrAceitador.WaitFor;
    FthrAceitador.Free;
  end;

  { Espera as threads de leitura sairem, FORA de FcsConexoes: ao terminar,
    cada uma chama pNotificaDesconexao -> pOnConexaoDesconectada, que entra
    nesse mesmo lock. Esperar segurando-o seria deadlock certo. }
  for LConexao in LarrTodas do
    LConexao.pAguardaFimDaLeitura;

  FcsConexoes.Enter;
  try
    FlstConexoes.Clear;
  finally
    FcsConexoes.Leave;
  end;

  FlstTodasConexoes.Free; // libera de fato cada TTefEstacaoConexao
  FlstConexoes.Free;
  FcsConexoes.Free;
  inherited;
end;

function TTefEstacaoTcpTransporte.fCriaSocketOuvinte: TSocket;
var
  LsockAddr: TSockAddrIn;
begin
  Result := socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
  if Result = INVALID_SOCKET then
    Exit;

  FillChar(LsockAddr, SizeOf(LsockAddr), 0);
  LsockAddr.sin_family := AF_INET;
  LsockAddr.sin_addr.S_addr := inet_addr('127.0.0.1'); // so loopback - o plugin conecta de dentro da mesma maquina
  LsockAddr.sin_port := htons(TEF_ESTACAO_TCP_PORTA);

  if bind(Result, TSockAddr(LsockAddr), SizeOf(LsockAddr)) <> 0 then
  begin
    closesocket(Result);
    Exit(INVALID_SOCKET);
  end;

  { Uma conexao por autcom.exe (Req. 456190, Fase 3.5). 8 e folga
    confortavel: o backlog so precisa cobrir conexoes que chegam entre
    dois accept() consecutivos, e o laco de accept nao bloqueia mais em
    nenhuma delas. }
  if listen(Result, 8) <> 0 then
  begin
    closesocket(Result);
    Exit(INVALID_SOCKET);
  end;
end;

procedure TTefEstacaoTcpTransporte.pOnConexaoFrameRecebido(AConexao: TTefEstacaoConexao;
  const AbytFrame: TBytes);
begin
  if Assigned(FOnFrameRecebido) then
    FOnFrameRecebido(AConexao, AbytFrame);
end;

procedure TTefEstacaoTcpTransporte.pOnConexaoDesconectada(AConexao: TTefEstacaoConexao);
begin
  FcsConexoes.Enter;
  try
    FlstConexoes.Remove(AConexao); // nao libera - FlstConexoes nao possui os objetos
  finally
    FcsConexoes.Leave;
  end;

  pLogaTcpEstacao(Format('TCP[con=%d]: conexao encerrada (pid=%d).',
    [AConexao.intIdConexao, AConexao.dwPid]));

  if Assigned(FOnDesconectado) then
    FOnDesconectado(AConexao);
end;

procedure TTefEstacaoTcpTransporte.pLoopAceitador;
var
  LsckCliente: TSocket;
  LConexao: TTefEstacaoConexao;
begin
  FsckOuvinte := fCriaSocketOuvinte;
  if FsckOuvinte = INVALID_SOCKET then
  begin
    pLogaTcpEstacao(Format('TCP: falha ao criar o socket ouvinte na porta %d (erro %d) - servico nao vai aceitar conexoes.',
      [TEF_ESTACAO_TCP_PORTA, WSAGetLastError]));
    Exit;
  end;
  pLogaTcpEstacao(Format('TCP: ouvindo em 127.0.0.1:%d.', [TEF_ESTACAO_TCP_PORTA]));

  while not FblnParar do
  begin
    LsckCliente := accept(FsckOuvinte, nil, nil);
    if LsckCliente = INVALID_SOCKET then
    begin
      if FblnParar then
        Break; // closesocket(FsckOuvinte) no Destroy forcou o accept() a retornar assim
      pLogaTcpEstacao(Format('TCP: accept() falhou (erro %d) - tentando de novo.', [WSAGetLastError]));
      Sleep(TEF_ESTACAO_TCP_INTERVALO_RETENTATIVA_MS);
      Continue;
    end;

    if FblnParar then
    begin
      closesocket(LsckCliente);
      Break;
    end;

    Inc(FintProximoIdConexao);
    LConexao := TTefEstacaoConexao.Create(LsckCliente, FintProximoIdConexao,
      pOnConexaoFrameRecebido, pOnConexaoDesconectada);

    FcsConexoes.Enter;
    try
      FlstTodasConexoes.Add(LConexao); // dono unico, do nascimento ate o destructor do transporte
      FlstConexoes.Add(LConexao);
    finally
      FcsConexoes.Leave;
    end;

    pLogaTcpEstacao(Format('TCP[con=%d]: cliente (plugin) conectado.', [LConexao.intIdConexao]));
    LConexao.pIniciaLeitura;

    if Assigned(FOnConectado) then
      FOnConectado(LConexao);

    { Sem espera aqui (Req. 456190, Passo 3): a conexao ja tem thread de
      leitura propria, entao este laco volta imediatamente ao accept() e
      atende o proximo autcom.exe em paralelo. Era exatamente esta espera
      (e o listen(1)) que travava o login do segundo AUTCOM. }
  end;
end;

end.
