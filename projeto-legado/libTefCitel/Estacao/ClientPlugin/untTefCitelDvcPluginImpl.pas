unit untTefCitelDvcPluginImpl;

{ Plugin cliente do canal RDP Dynamic Virtual Channel "TefCitelCh" (Req.
  456190), adaptado de DVC\src\client\TefDvcPluginImpl.pas (prototipo
  escolhido como base tecnica oficial - ver IA\456190\plans.md item 1,
  secao "Lado estacao").

  Responsabilidade unica: relay puro de bytes entre o canal DVC (aberto
  pelo autcom.exe via WTSVirtualChannelOpenEx, ver untTefCitelDvcTransporte.pas)
  e o TefEstacaoService.exe (untTefEstacaoTcpTransporte.pas), via socket
  TCP loopback. Nenhuma logica de protocolo RPC/JSON e interpretada aqui -
  o framing por tamanho ja viaja dentro dos bytes repassados, montado/
  desmontado nas duas pontas reais.

  HISTORICO DA ARQUITETURA (Req. 456190) - resumo pra quem chegar agora,
  detalhe completo em IA\specs\456190\plans.md/tasks.md:

  1) Desenho original: este plugin falava direto com TefEstacaoService.exe
     via named pipe "TefCitelCh". Achado (2026-08-24 a 27): o WriteFile
     deste plugin (dentro do mstsc.exe) contra esse pipe (servico rodando
     em sessao 0/LocalSystem) travava por minutos, sem teto - triangulado
     como a combinacao especifica "mstsc.exe cliente cruzando pra sessao
     0" (Bitdefender/Defender/MDE/RDP Shortpath/identidade de thread todos
     descartados individualmente).

  2) Tentativa intermediaria (2026-08-27): processo relay de sessao
     (TefCitelDvcRelay.exe) rodando na mesma sessao do mstsc.exe, criando
     um salto extra so pra evitar "mstsc.exe cruzando sessao". O plugin
     passou a falar com o relay via named pipe NA MESMA SESSAO. Resultado:
     a MESMA trava sem fim reapareceu nesse pipe tambem (3 testes de campo
     seguidos) - provando que o problema nao era especifico de cruzar
     sessao, e sim do driver de named pipe (NPFS) em si, usado a partir de
     thread hospedada no mstsc.exe.

  3) Substituido named pipe por SOCKET TCP LOOPBACK so no salto
     plugin<->relay: funcionou perfeitamente (0ms em todo teste). Mas o
     relay ainda falava com TefEstacaoService.exe via named pipe (o hop
     que nunca tinha sido mudado) - e ESSE WriteFile passou a travar
     (2026-08-27/28), confirmando que named pipe e o problema em qualquer
     combinacao de processos que o usa, nao um caso especifico.

  4) DECISAO FINAL (Rafael, 2026-08-28): eliminar named pipe por completo
     e o processo relay de sessao junto (nao tem mais motivo de existir -
     so fazia ponte pro named pipe). Este plugin agora conecta DIRETO em
     TefEstacaoService.exe via socket TCP loopback
     (127.0.0.1:TEF_ESTACAO_TCP_PORTA, untTefEstacaoTcpTransporte.pas do
     lado servico). TCP nunca falhou uma unica vez em nenhum teste desta
     investigacao (isolado ou em producao) - socket usa a pilha
     Winsock/AFD, caminho de kernel diferente do NPFS.

  A porta TCP (TEF_ESTACAO_TCP_PORTA) e o nome do canal DVC
  (untTefCitelDvcPluginApi.TEF_DVC_PLUGIN_CANAL) sao duplicados por
  literal em vez de referenciar a unit do servico da estacao de proposito
  - esta DLL roda dentro do processo do cliente RDP (mstsc.exe/TSPlus) e
  precisa ficar leve, sem arrastar as dependencias dessa outra unit
  (UniDAC, etc.). Qualquer mudanca de porta precisa ser replicada nas
  duas pontas manualmente (aqui e untTefEstacaoTcpTransporte.pas).

  Historico da escrita (Req. 456190) - por que existe uma thread dedicada
    de escrita (FthrEscritaWorker) em vez de escrever direto em
    OnDataReceived - o raciocinio abaixo nasceu com named pipe mas
    continua igualmente valido com socket (troca de transporte nao muda a
    logica de concorrencia, so a API usada por baixo):

    Confirmado em campo (2026-08-24): uma escrita sincrona (sem
    FILE_FLAG_OVERLAPPED/bloqueante) as vezes demora bastante pra
    retornar - a demora nao e sinal de conexao morta, e sim (suspeita, nao
    fechada) de uma inspecao de seguranca no I/O. O dado acaba chegando
    certinho do outro lado minutos ou segundos depois, mesmo quando a
    demora bate qualquer teto razoavel de timeout.

    A primeira versao desta unit tentava um timeout (thread auxiliar +
    cancelamento se nao voltasse a tempo) e tratava estouro de timeout
    como falha - fechava a conexao e reenviava o mesmo frame numa conexao
    nova. Isso causava dispatch em DOBRO do lado da estacao pra TODO
    metodo, confirmado em campo mesmo com a margem de timeout subida de
    5s pra 15s (a demora real as vezes excede 15s tambem - nao e um custo
    fixo). Pra fConfiguraTefCitel/fObtemVersao isso e so desperdicio
    (metodos idempotentes); pra fPassarCartao e grave - repetir uma
    transacao de cartao de verdade nao e seguro.

    A correcao: nao existe mais timeout nenhum sobre a escrita em si. Uma
    unica thread de longa duracao (FthrEscritaWorker, criada uma vez no
    construtor, nao a cada reconexao) consome FlstPendente em ordem, uma
    escrita de cada vez, e so avanca pro proximo frame depois que a
    escrita atual retorna - nunca ha dois envios simultaneos no mesmo
    socket. Uma escrita lenta so atrasa a fila (quem esta atras dela
    espera) - nunca mais gera reenvio duplicado. So um erro REAL devolvido
    pela escrita (nao demora) e tratado como desconexao
    (pFechaConexaoJaTravada). OnDataReceived virou so "enfileira e acorda
    o worker" - sem escrita nenhuma na thread de callback do canal DVC.

    Segundo achado (Req. 456190, 2026-08-24, mesmo dia, ainda com named
    pipe): a primeira versao desta correcao ainda tinha uma corrida -
    fechar o handle de outra thread enquanto uma escrita sincrona ainda
    podia estar em andamento nele e comportamento indefinido no Win32; foi
    confirmado em campo que isso fazia uma escrita presa "completar com
    sucesso" bem na hora em que o autcom.exe era fechado - nao porque a
    escrita tinha terminado sozinha, mas porque o fechamento concorrente
    forcava esse retorno. Corrigido: nunca fechar uma conexao que
    FthrEscritaWorker possa estar usando (flag FblnEscritaEmAndamento) -
    so abandonar a referencia. O proprio FthrEscritaWorker fecha sozinho,
    no momento seguro em que sua escrita finalmente devolve o controle pra
    ele (ver pLoopEscritaWorker).

    Nota (2026-08-27, migracao pra socket): com TCP, shutdown() e seguro
    de chamar a qualquer momento/de qualquer thread para destravar um
    recv/send pendente em OUTRA thread (ao contrario do CloseHandle de
    named pipe, que era comportamento indefinido) - closesocket()
    concorrente tambem e mais tolerante no Winsock do que CloseHandle era
    pra pipe. Mesmo assim, o padrao de posse (so quem tem I/O pendente
    fecha) foi mantido por consistencia e seguranca extra, sem custo real. }

interface

uses
  Winapi.Windows, Winapi.Winsock2, System.SysUtils, System.Classes, System.SyncObjs,
  System.Generics.Collections, untTefCitelDvcPluginApi;

const
  { TefEstacaoService.exe, via socket TCP loopback - ver historico da
    arquitetura no cabecalho da unit (Req. 456190, 2026-08-28). }
  TEF_ESTACAO_TCP_HOST = '127.0.0.1';
  TEF_ESTACAO_TCP_PORTA = 47991;
  TEF_PLUGIN_INTERVALO_RETENTATIVA_MS = 2000;
  TEF_PLUGIN_TAMANHO_BUFFER = 65536;
  TEF_PLUGIN_FILA_PENDENTE_MAX = 500; // protecao contra crescimento indefinido se o servico ficar fora do ar
  TEF_PLUGIN_ESCRITA_WORKER_POLL_MS = 500; // intervalo de reavaliacao de FblnParar no worker de escrita

  { RF22 (Req. 456190, Passo 8 da Fase 5) - nivel/rotacao do log. COPIA
    das mesmas constantes de untTefEstacaoLog.pas e de
    untTefCitelDvcTransporte.pas: os tres processos leem o MESMO .ini,
    com a mesma secao e as mesmas chaves, mas cada projeto tem search
    path proprio e nao compartilha unit (mesma decisao ja tomada para
    fCrc32 - ver IA\rules\tef-dvc.md). Qualquer mudanca aqui precisa ser
    replicada nos tres na MESMA sessao, senao eles passam a se comportar
    diferente com o mesmo arquivo de configuracao.

    Uma linha e gravada quando o nivel DELA e menor ou igual ao
    configurado. As linhas por quadro (relay de bytes, duracao de
    escrita) entraram como DIAGNOSTICO no Passo 8 - eram elas que faziam
    o volume de ~100 linhas por transacao de cartao. }
  TEF_LOG_NIVEL_DESLIGADO   = 0;
  TEF_LOG_NIVEL_NORMAL      = 1;
  TEF_LOG_NIVEL_DIAGNOSTICO = 2;

  TEF_LOG_INI_ARQUIVO = 'TefCitelDvcLog.ini';
  TEF_LOG_INI_SECAO   = 'Log';
  TEF_LOG_ARQUIVO     = 'TefCitelDvcPlugin.log';

  TEF_LOG_NIVEL_DEFAULT          = TEF_LOG_NIVEL_NORMAL;
  TEF_LOG_TAMANHO_MAX_MB_DEFAULT = 10;
  TEF_LOG_ARQUIVOS_DEFAULT       = 3;
  TEF_LOG_CHECAR_TAMANHO_CADA    = 64;
  { Item 3 do Passo 8 (Req. 456190, 2026-09-12) - COPIA de
    untTefCitelDvcTransporte.pas, mesma regra das demais constantes de log
    deste bloco. Acima disto o custo da gravacao da linha anterior entra no
    prefixo da linha seguinte; abaixo, o formato da linha nao muda. }
  TEF_LOG_GRAVACAO_LENTA_MS      = 100;

type
  TTefCitelDvcPlugin = class(TInterfacedObject, IWTSPlugin, IWTSListenerCallback)
  private
    FListener: IWTSListener;
  public
    function Initialize(const ChannelMgr: IWTSVirtualChannelManager): HRESULT; stdcall;
    function Connected: HRESULT; stdcall;
    function Disconnected(DisconnectCode: DWORD): HRESULT; stdcall;
    function Terminated: HRESULT; stdcall;

    function OnNewChannelConnection(const Channel: IWTSVirtualChannel;
      Data: PWideChar; Accept: PBOOL;
      out Callback: IWTSVirtualChannelCallback): HRESULT; stdcall;
  end;

implementation

{ Nao declarada em Winapi.Windows nesta versao do Delphi (confirmado no
  build, Req. 456190, 2026-08-24). Usada so como diagnostico de duracao no
  log do worker de escrita (pLoopEscritaWorker). }
function GetTickCount64: UInt64; stdcall; external 'kernel32.dll';

var
  { Estado do log (RF22, Req. 456190, Passo 8). FcsLogArq serializa as
    chamadas: este processo e multithread (FthrRelay + FthrEscritaWorker de
    cada canal, mais os callbacks do proprio canal DVC) e a versao anterior
    desta funcao nao tinha protecao NENHUMA, alem de usar FormatDateTime -
    que o lado autcom abandonou em 2026-08-28 depois de dois
    EAccessViolation em campo, os dois dentro de
    FormatDateTime/DateTimeToString e os dois lendo o mesmo endereco fixo
    (locale global da RTL nao thread-safe nesta versao do Delphi). Ver
    IA\rules\tef-dvc.md. }
  FcsLogArq: TCriticalSection;
  FblnLogConfigLida: Boolean;
  FintLogNivel: Integer;
  FintLogTamanhoMaxBytes: Int64;
  FintLogArquivos: Integer;
  FstrLogPasta: String;
  FdwLogLinhasDesdeChecagem: DWORD;
  { ITEM 3 DO PASSO 8 (Req. 456190, 2026-09-12) - mesmo instrumento e mesmo
    motivo do FdwLogGravacaoMs de untTefCitelDvcTransporte.pas: o carimbo de
    hora e tirado dentro do FcsLogArq e a gravacao em arquivo tambem, entao
    o custo de gravar uma linha desloca o carimbo da linha SEGUINTE sem
    aparecer em lugar nenhum. Este log e metade do cruzamento que prova de
    que lado esta a retencao do canal - se ele tambem mente na hora, o
    cruzamento nao vale nada. Protegida pelo FcsLogArq. }
  FdwLogGravacaoMs: DWORD;
  { Id sequencial de canal DVC dentro deste processo. A topologia esperada e
    "1 estacao = 1 canal", mas o log de 10/09 mostrou os DOIS canais DVC de
    uma sessao caindo no mesmo arquivo sem nada que os distinguisse - e o
    cenario que mais precisa deste log (a disputa do pinpad, RF27) e por
    definicao sobre dois autcom ao mesmo tempo. }
  FintLogProximoIdCanal: Integer;

{ Pasta do PROPRIO plugin, nao a do processo hospedeiro: aqui ParamStr(0) e
  o mstsc.exe (System32), e nao a pasta de instalacao da estacao. O
  GetModuleFileName com HInstance devolve o caminho desta DLL, que fica na
  mesma pasta flat do TefEstacaoService.exe e do TefCitelDvcLog.ini (ver
  install\register-plugin.ps1). }
function fPastaDoPlugin: String;
var
  LarrCaminho: array[0..MAX_PATH] of Char;
begin
  FillChar(LarrCaminho, SizeOf(LarrCaminho), 0);
  if GetModuleFileName(HInstance, @LarrCaminho[0], Length(LarrCaminho)) = 0 then
    Exit(IncludeTrailingPathDelimiter(GetEnvironmentVariable('TEMP')));
  Result := ExtractFilePath(String(PChar(@LarrCaminho[0])));
end;

{ Le o .ini uma unica vez. Chamada SEMPRE de dentro do FcsLogArq. O arquivo
  NAO e criado aqui: quem cria e o servico da estacao (untTefEstacaoLog.pas,
  com CREATE_NEW), que sobe antes e roda com mais privilegio. Se ainda nao
  existir, GetPrivateProfileInt devolve os defaults - o plugin funciona
  igual, so nao deixa o arquivo pronto para o suporte editar. }
procedure pCarregaConfigLog;
var
  LstrIni: String;
  LintMb: Integer;
  LarrPasta: array[0..MAX_PATH] of Char;
begin
  FblnLogConfigLida := True;
  FstrLogPasta := fPastaDoPlugin;
  LstrIni := FstrLogPasta + TEF_LOG_INI_ARQUIVO;

  FintLogNivel := GetPrivateProfileInt(TEF_LOG_INI_SECAO, 'Nivel',
    TEF_LOG_NIVEL_DEFAULT, PChar(LstrIni));
  if FintLogNivel < TEF_LOG_NIVEL_DESLIGADO then
    FintLogNivel := TEF_LOG_NIVEL_DESLIGADO;
  if FintLogNivel > TEF_LOG_NIVEL_DIAGNOSTICO then
    FintLogNivel := TEF_LOG_NIVEL_DIAGNOSTICO;

  LintMb := GetPrivateProfileInt(TEF_LOG_INI_SECAO, 'TamanhoMaxMB',
    TEF_LOG_TAMANHO_MAX_MB_DEFAULT, PChar(LstrIni));
  if LintMb < 1 then
    LintMb := 1;
  if LintMb > 1024 then
    LintMb := 1024;
  FintLogTamanhoMaxBytes := Int64(LintMb) * 1024 * 1024;

  FintLogArquivos := GetPrivateProfileInt(TEF_LOG_INI_SECAO, 'Arquivos',
    TEF_LOG_ARQUIVOS_DEFAULT, PChar(LstrIni));
  if FintLogArquivos < 1 then
    FintLogArquivos := 1;
  if FintLogArquivos > 20 then
    FintLogArquivos := 20;

  FillChar(LarrPasta, SizeOf(LarrPasta), 0);
  GetPrivateProfileString(TEF_LOG_INI_SECAO, 'Pasta', '', @LarrPasta[0],
    Length(LarrPasta), PChar(LstrIni));
  if (LarrPasta[0] <> #0) and DirectoryExists(String(PChar(@LarrPasta[0]))) then
    FstrLogPasta := IncludeTrailingPathDelimiter(String(PChar(@LarrPasta[0])));
end;

{ Tamanho pelo caminho, nao pelo handle - o handle do log e aberto so com
  FILE_APPEND_DATA e GetFileSize exige direito de leitura. Devolve 0 se o
  arquivo nao existir. }
function fTamanhoArquivoLog(const AstrArquivo: String): Int64;
var
  LFad: TWin32FileAttributeData;
begin
  Result := 0;
  if not GetFileAttributesEx(PChar(AstrArquivo), GetFileExInfoStandard, @LFad) then
    Exit;
  Result := (Int64(LFad.nFileSizeHigh) shl 32) or Int64(LFad.nFileSizeLow);
end;

{ .log -> .1.log -> .2.log ..., descartando o mais antigo. Best effort: uma
  falha de renomeacao so deixa o arquivo passar do teto por algumas linhas,
  nunca perde linha gravada nem corrompe nada. Chamada de dentro do
  FcsLogArq. }
procedure pRotacionaLog(const AstrArquivo: String);
var
  LstrBase, LstrExt: String;
  LintInd: Integer;
begin
  if FintLogArquivos <= 1 then
  begin
    System.SysUtils.DeleteFile(AstrArquivo);
    Exit;
  end;

  LstrBase := ChangeFileExt(AstrArquivo, '');
  LstrExt := ExtractFileExt(AstrArquivo);

  System.SysUtils.DeleteFile(LstrBase + '.' + IntToStr(FintLogArquivos - 1) + LstrExt);
  for LintInd := FintLogArquivos - 2 downto 1 do
    System.SysUtils.RenameFile(
      LstrBase + '.' + IntToStr(LintInd) + LstrExt,
      LstrBase + '.' + IntToStr(LintInd + 1) + LstrExt);
  System.SysUtils.RenameFile(AstrArquivo, LstrBase + '.1' + LstrExt);
end;

function fLogPluginAtivo(const AintNivel: Integer): Boolean;
begin
  FcsLogArq.Enter;
  try
    if not FblnLogConfigLida then
      pCarregaConfigLog;
    Result := AintNivel <= FintLogNivel;
  finally
    FcsLogArq.Leave;
  end;
end;

{ AintIdCanal = 0 para as linhas que nao pertencem a um canal (listener,
  Connected/Disconnected/Terminated do plugin). }
procedure pLogArquivoCanal(const AintNivel, AintIdCanal: Integer;
  const AstrMsg: String);
var
  LstrArquivo: String;
  LstrLinha, LstrPrefixo: AnsiString;
  LhndArquivo: THandle;
  LintEscritos: DWORD;
  LSystemTime: TSystemTime;
  LdwTickGrav: DWORD;
begin
  FcsLogArq.Enter;
  try
    if not FblnLogConfigLida then
    begin
      pCarregaConfigLog;
      FdwLogLinhasDesdeChecagem := TEF_LOG_CHECAR_TAMANHO_CADA; // forca a 1a checagem
    end;

    if AintNivel > FintLogNivel then
      Exit;

    LstrArquivo := IncludeTrailingPathDelimiter(FstrLogPasta) + TEF_LOG_ARQUIVO;

    Inc(FdwLogLinhasDesdeChecagem);
    if FdwLogLinhasDesdeChecagem >= TEF_LOG_CHECAR_TAMANHO_CADA then
    begin
      FdwLogLinhasDesdeChecagem := 0;
      if fTamanhoArquivoLog(LstrArquivo) >= FintLogTamanhoMaxBytes then
        pRotacionaLog(LstrArquivo);
    end;

    if AintIdCanal > 0 then
      LstrPrefixo := AnsiString(Format('[pid=%d canal=%d]  ',
        [GetCurrentProcessId, AintIdCanal]))
    else
      LstrPrefixo := AnsiString(Format('[pid=%d]  ', [GetCurrentProcessId]));

    { So aparece quando a gravacao da linha anterior passou do limiar -
      quando aparece, diz quantos ms deste carimbo sao atraso do proprio
      log, e nao do evento narrado. }
    if FdwLogGravacaoMs >= TEF_LOG_GRAVACAO_LENTA_MS then
      LstrPrefixo := AnsiString(Format('[gravAnterior=%dms]  ',
        [FdwLogGravacaoMs])) + LstrPrefixo;

    { Carimbo montado a mao a partir de GetLocalTime, sem FormatDateTime -
      ver o comentario do FcsLogArq acima. Mesmo formato de sempre. }
    GetLocalTime(LSystemTime);
    LstrLinha := AnsiString(Format('%.4d-%.2d-%.2d %.2d:%.2d:%.2d.%.3d  ',
      [LSystemTime.wYear, LSystemTime.wMonth, LSystemTime.wDay,
       LSystemTime.wHour, LSystemTime.wMinute, LSystemTime.wSecond,
       LSystemTime.wMilliseconds])) + LstrPrefixo +
      AnsiString(AstrMsg) + AnsiString(#13#10);

    { Log por append simples - usado dentro dos callbacks do canal DVC, onde
      qualquer demora pode interferir no handshake do cliente RDP. Sem
      console disponivel (o processo host e o mstsc.exe/TSPlus).

      Se a pasta do plugin nao for gravavel pelo usuario interativo, cai
      para %TEMP% - que era o local usado ate 2026-09-10 - e fica nele pelo
      resto do processo. A pasta do plugin e preferida porque %TEMP% e
      candidato a Limpeza de Disco, que pode apagar justamente a evidencia
      que se quer guardar (RF22), e porque deixa este log ao lado do
      TefEstacaoService.log, que o suporte ja coleta. }
    { Comeca DEPOIS do carimbo de proposito - o que desloca o carimbo da
      proxima linha e o que vem daqui para baixo. O fallback para %TEMP%
      entra na conta, e deve entrar: ele custa um CreateFile perdido. }
    LdwTickGrav := GetTickCount;
    LhndArquivo := CreateFile(PChar(LstrArquivo), FILE_APPEND_DATA,
      FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_ALWAYS,
      FILE_ATTRIBUTE_NORMAL, 0);
    if LhndArquivo = INVALID_HANDLE_VALUE then
    begin
      FstrLogPasta := IncludeTrailingPathDelimiter(GetEnvironmentVariable('TEMP'));
      LstrArquivo := FstrLogPasta + TEF_LOG_ARQUIVO;
      LhndArquivo := CreateFile(PChar(LstrArquivo), FILE_APPEND_DATA,
        FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_ALWAYS,
        FILE_ATTRIBUTE_NORMAL, 0);
      if LhndArquivo = INVALID_HANDLE_VALUE then
      begin
        FdwLogGravacaoMs := GetTickCount - LdwTickGrav;
        Exit;
      end;
    end;

    try
      WriteFile(LhndArquivo, PAnsiChar(LstrLinha)^, Length(LstrLinha),
        LintEscritos, nil);
    finally
      CloseHandle(LhndArquivo);
      FdwLogGravacaoMs := GetTickCount - LdwTickGrav;
    end;
  finally
    FcsLogArq.Leave;
  end;
end;

procedure pLogArquivo(const AstrMsg: String);
begin
  { Assinatura preservada para as chamadas que NAO pertencem a um canal
    (listener e ciclo de vida do plugin). As de dentro de
    TTefCitelDvcCanalCallback passaram a usar o pLog do proprio objeto, que
    carrega o id do canal. }
  pLogArquivoCanal(TEF_LOG_NIVEL_NORMAL, 0, AstrMsg);
end;

type
  { Um canal DVC por conexao (um pinpad por estacao, ver plans.md/specs.md -
    topologia "1 estacao = 1 servico = 1 pinpad = 1 canal DVC"); simplificacao
    valida enquanto isso se mantiver verdadeiro. }
  TTefCitelDvcCanalCallback = class(TInterfacedObject, IWTSVirtualChannelCallback)
  private
    FChannel: IWTSVirtualChannel;
    FsckEstacao: TSocket;
    FblnConectado: Boolean;
    FblnParar: Boolean;
    FblnEscritaEmAndamento: Boolean;
    FcsEstado: TCriticalSection;
    FlstPendente: TList<TBytes>;
    FevtNovoFramePendente: TEvent;
    FthrRelay: TThread;
    FthrEscritaWorker: TThread;
    { Id deste canal DVC dentro do processo (RF22, Req. 456190, Passo 8
      da Fase 5) - vai no prefixo de toda linha de log deste objeto. Ver
      FintLogProximoIdCanal. }
    FintIdCanal: Integer;
    procedure pLog(const AstrMsg: String);
    procedure pLogDiag(const AstrMsg: String);
    function fTentaConectarSocket: TSocket;
    function fEscreveNoSocket(AsckSocket: TSocket; const AbytDados: TBytes): Boolean;
    procedure pFechaConexaoJaTravada;
    procedure pLoopConectorELeitura;
    procedure pLoopEscritaWorker;
  public
    constructor Create(const AChannel: IWTSVirtualChannel);
    destructor Destroy; override;
    function OnDataReceived(Size: ULONG; Buffer: PByte): HRESULT; stdcall;
    function OnClose: HRESULT; stdcall;
  end;

{ TTefCitelDvcCanalCallback }

{ Toda linha deste objeto sai identificada com o id do canal - sem isso
  os dois canais DVC de uma mesma sessao RDP caem no mesmo arquivo sem
  nada que os separe (visto no log de 2026-09-10). }
procedure TTefCitelDvcCanalCallback.pLog(const AstrMsg: String);
begin
  pLogArquivoCanal(TEF_LOG_NIVEL_NORMAL, FintIdCanal, AstrMsg);
end;

{ Linha POR QUADRO: so aparece com Nivel=2 no TefCitelDvcLog.ini. Eram
  estas que faziam o volume de ~100 linhas por transacao de cartao. }
procedure TTefCitelDvcCanalCallback.pLogDiag(const AstrMsg: String);
begin
  pLogArquivoCanal(TEF_LOG_NIVEL_DIAGNOSTICO, FintIdCanal, AstrMsg);
end;

constructor TTefCitelDvcCanalCallback.Create(const AChannel: IWTSVirtualChannel);
var
  LobjWsaData: TWSAData;
begin
  inherited Create;
  FChannel := AChannel;
  FsckEstacao := INVALID_SOCKET;
  FblnConectado := False;
  FblnParar := False;
  FblnEscritaEmAndamento := False;
  FcsEstado := TCriticalSection.Create;
  FlstPendente := TList<TBytes>.Create;
  FevtNovoFramePendente := TEvent.Create(nil, False, False, '');
  { Antes de qualquer chamada de pLog deste objeto, e antes de subir as
    duas threads (que tambem logam). }
  FintIdCanal := TInterlocked.Increment(FintLogProximoIdCanal);
  pLog('Canal DVC aberto pelo autcom.exe - id de canal atribuido para o log.');

  { WSAStartup e referenciado internamente pelo Winsock (seguro chamar
    mais de uma vez, mesmo processo) - "1 estacao = 1 canal" na pratica,
    entao isso roda uma vez por sessao RDP. Sem WSACleanup correspondente
    de proposito - mesma filosofia de nao ter parada graciosa ja usada
    nesta unit (custo aceito, o processo encerra junto com a sessao). }
  WSAStartup($0202, LobjWsaData);

  FthrRelay := TThread.CreateAnonymousThread(pLoopConectorELeitura);
  FthrRelay.FreeOnTerminate := False;
  FthrRelay.Start;

  { Uma unica thread de escrita para toda a vida deste callback (nao
    recriada a cada reconexao, ao contrario de FthrRelay) - ver o
    historico no cabecalho da unit. Fica dormindo enquanto nao ha frame
    pendente ou a conexao esta caida. }
  FthrEscritaWorker := TThread.CreateAnonymousThread(pLoopEscritaWorker);
  FthrEscritaWorker.FreeOnTerminate := False;
  FthrEscritaWorker.Start;
end;

destructor TTefCitelDvcCanalCallback.Destroy;
begin
  FblnParar := True;
  FevtNovoFramePendente.SetEvent; // acorda FthrEscritaWorker pra ele reavaliar FblnParar e sair

  FcsEstado.Enter;
  try
    pFechaConexaoJaTravada; // desbloqueia o recv/send em espera nas duas threads
  finally
    FcsEstado.Leave;
  end;

  if Assigned(FthrRelay) then
  begin
    { shutdown() (ja chamado dentro de pFechaConexaoJaTravada) e confiavel
      pra destravar recv/send pendente - mais confiavel do que
      CancelSynchronousIo se mostrou para named pipe neste ambiente (ver
      historico da unit). Mesmo assim, mantido o mesmo padrao defensivo:
      um WaitFor incondicional aqui travaria a destruicao deste objeto (e
      quem estiver chamando Destroy) para sempre se, por algum motivo,
      nao destravar. Da um tempo limitado e abandona a thread
      (FreeOnTerminate) se necessario - vazamento e mal menor frente a
      travar a aplicacao. }
    if WaitForSingleObject(FthrRelay.Handle, 5000) = WAIT_TIMEOUT then
    begin
      pLog('Destroy: FthrRelay nao terminou a tempo - abandonando.');
      FthrRelay.FreeOnTerminate := True;
      FthrRelay := nil;
    end;
  end;
  if Assigned(FthrRelay) then
    FthrRelay.Free;

  if Assigned(FthrEscritaWorker) then
  begin
    if WaitForSingleObject(FthrEscritaWorker.Handle, 5000) = WAIT_TIMEOUT then
    begin
      pLog('Destroy: FthrEscritaWorker nao terminou a tempo - abandonando.');
      FthrEscritaWorker.FreeOnTerminate := True;
      FthrEscritaWorker := nil;
    end;
  end;
  if Assigned(FthrEscritaWorker) then
    FthrEscritaWorker.Free;

  FevtNovoFramePendente.Free;
  FlstPendente.Free;
  FcsEstado.Free;
  inherited;
end;

function TTefCitelDvcCanalCallback.fTentaConectarSocket: TSocket;
var
  LsockAddr: TSockAddrIn;
begin
  { Sem logica de "subir sob demanda" - TefEstacaoService.exe e um
    servico Windows gerenciado pelo SCM, sempre de pe (ou reiniciando
    sozinho apos falha, RF07); ao contrario do extinto processo relay de
    sessao, nao ha nada pra este plugin criar. Se a conexao falhar (ex.:
    servico reiniciando), o chamador (pLoopConectorELeitura) so tenta de
    novo mais tarde - mesma regra de sempre, nunca trata demora como
    falha permanente. }
  FillChar(LsockAddr, SizeOf(LsockAddr), 0);
  LsockAddr.sin_family := AF_INET;
  LsockAddr.sin_addr.S_addr := inet_addr(TEF_ESTACAO_TCP_HOST);
  LsockAddr.sin_port := htons(TEF_ESTACAO_TCP_PORTA);

  Result := socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
  if Result = INVALID_SOCKET then
    Exit;

  if connect(Result, TSockAddr(LsockAddr), SizeOf(LsockAddr)) <> 0 then
  begin
    closesocket(Result);
    Result := INVALID_SOCKET;
  end;
end;

function TTefCitelDvcCanalCallback.fEscreveNoSocket(AsckSocket: TSocket; const AbytDados: TBytes): Boolean;
var
  LintEnviado: Integer;
  LintTotalEnviado: Integer;
begin
  { Recebe o socket por parametro (nao le FsckEstacao direto) de proposito
    - ver pLoopEscritaWorker e o comentario grande em
    pFechaConexaoJaTravada. Quem chama captura o valor de FsckEstacao UMA
    vez, antes de soltar o lock pra bloquear aqui - assim esta chamada
    nunca fica olhando pra um socket que mudou de baixo dela enquanto
    estava presa. }
  Result := True;
  if Length(AbytDados) = 0 then
    Exit;

  LintTotalEnviado := 0;
  while LintTotalEnviado < Length(AbytDados) do
  begin
    LintEnviado := send(AsckSocket, AbytDados[LintTotalEnviado], Length(AbytDados) - LintTotalEnviado, 0);
    if (LintEnviado = SOCKET_ERROR) or (LintEnviado = 0) then
      Exit(False);
    Inc(LintTotalEnviado, LintEnviado);
  end;
end;

procedure TTefCitelDvcCanalCallback.pFechaConexaoJaTravada;
begin
  FblnConectado := False;
  if FsckEstacao <> INVALID_SOCKET then
  begin
    { shutdown(SD_BOTH) destrava qualquer recv/send pendente NAS DUAS
      threads (FthrRelay lendo, FthrEscritaWorker escrevendo) com uma
      unica chamada - ao contrario do named pipe (que precisava de
      CancelSynchronousIo separado por thread, e nem sempre confiavel
      neste ambiente - ver historico da unit), shutdown() em socket e
      seguro de chamar de qualquer thread, a qualquer momento, sem
      invalidar o handle. }
    shutdown(FsckEstacao, SD_BOTH);

    if FblnEscritaEmAndamento then
    begin
      { Mesmo com shutdown() sendo mais confiavel que CancelSynchronousIo,
        mantido o mesmo padrao de posse ja estabelecido (nunca fechar uma
        conexao que FthrEscritaWorker possa estar usando, de outra
        thread) por consistencia e seguranca extra - custo zero, so
        abandona a referencia; o proprio FthrEscritaWorker fecha o socket
        sozinho assim que seu send() (agora destravado pelo shutdown)
        devolver o controle pra ele. }
    end
    else
      closesocket(FsckEstacao);

    FsckEstacao := INVALID_SOCKET;
  end;
end;

procedure TTefCitelDvcCanalCallback.pLoopConectorELeitura;
var
  LsckEstacao: TSocket;
  LarrBufLeitura: array[0..TEF_PLUGIN_TAMANHO_BUFFER - 1] of Byte;
  LintBytesLidos: Integer;
  LarrPayload: TBytes;
  { Item 1 do Passo 8 - ver o bloco do FChannel.Write abaixo. }
  LdwTickWrite: DWORD;
  LhrWrite: HRESULT;
begin
  while not FblnParar do
  begin
    LsckEstacao := fTentaConectarSocket;
    if LsckEstacao = INVALID_SOCKET then
    begin
      if not FblnParar then
        Sleep(TEF_PLUGIN_INTERVALO_RETENTATIVA_MS);
      Continue;
    end;

    FcsEstado.Enter;
    try
      if FblnParar then
      begin
        closesocket(LsckEstacao);
        Break;
      end;
      FsckEstacao := LsckEstacao;
      FblnConectado := True;
    finally
      FcsEstado.Leave;
    end;

    pLog('Socket conectado ao TefEstacaoService.exe (127.0.0.1:' + IntToStr(TEF_ESTACAO_TCP_PORTA) + ').');
    { Acorda o worker de escrita - pode haver frames que ficaram em
      FlstPendente de uma desconexao anterior, esperando esta reconexao. }
    FevtNovoFramePendente.SetEvent;

    { FblnConectado e lido aqui sem o critical section de proposito -
      mesmo padrao de blnConectado em untTefCitelDvcTransporte.pas/
      untTefEstacaoTcpTransporte.pas: um flag simples cuja pior
      consequencia de uma leitura desatualizada e mais uma volta do loop,
      nunca corrupcao de dados. }
    while (not FblnParar) and FblnConectado do
    begin
      LintBytesLidos := recv(FsckEstacao, LarrBufLeitura, SizeOf(LarrBufLeitura), 0);
      if LintBytesLidos <= 0 then
        Break; // 0 = conexao fechada pelo servico; SOCKET_ERROR (-1) = erro real

      { Log de sucesso adicionado em 2026-08-27 - esta e a direcao
        estacao->autcom.exe (resposta de RPC/evento). Sem isso, nao da
        pra saber se uma resposta chegou aqui e FChannel.Write (canal DVC
        de volta pro autcom.exe) que travou, ou se os bytes nunca
        chegaram ate este ponto. }
      pLogDiag(Format('Socket->canal DVC: %d bytes lidos do servico, repassando ao autcom.exe...', [LintBytesLidos]));
      SetLength(LarrPayload, LintBytesLidos);
      Move(LarrBufLeitura[0], LarrPayload[0], LintBytesLidos);

      { ITEM 1 DO PASSO 8 (Req. 456190, 2026-09-12) - a medida que faltava
        para fechar a retencao de ~10 s do canal. Ate aqui o log so dizia
        que o repasse aconteceu; com a duracao e o HRESULT da chamada da
        API da para separar "o Write demorou" de "o Write voltou na hora e
        o canal segurou os bytes depois". O retorno era descartado desde
        sempre - um Write que falhava em silencio se parecia, no log, com
        um Write que deu certo. }
      LdwTickWrite := GetTickCount;
      LhrWrite := S_OK;
      if Assigned(FChannel) then
        LhrWrite := FChannel.Write(LintBytesLidos, @LarrPayload[0], nil);
      pLogDiag(Format('Socket->canal DVC: %d bytes repassados ao autcom.exe - ' +
        'IWTSVirtualChannel.Write levou %d ms e devolveu 0x%.8x.',
        [LintBytesLidos, GetTickCount - LdwTickWrite, LhrWrite]));
    end;

    FcsEstado.Enter;
    try
      pFechaConexaoJaTravada;
    finally
      FcsEstado.Leave;
    end;

    if not FblnParar then
      pLog('Socket desconectado do TefEstacaoService.exe - tentando reconectar.');
  end;
end;

procedure TTefCitelDvcCanalCallback.pLoopEscritaWorker;
var
  LarrFrame: TBytes;
  LblnTemFrame: Boolean;
  LblnEscreveu: Boolean;
  LsckEstacaoLocal: TSocket;
  LqwInicio: UInt64;
begin
  { Ver o historico completo no cabecalho da unit. Resumo: consome
    FlstPendente em ordem, uma escrita de cada vez, sem nenhum timeout
    artificial sobre o send() - uma escrita lenta so atrasa quem esta
    atras dela na fila, nunca mais e tratada como falha/desconexao. }
  while not FblnParar do
  begin
    if WaitForSingleObject(FevtNovoFramePendente.Handle, TEF_PLUGIN_ESCRITA_WORKER_POLL_MS) = WAIT_TIMEOUT then
      Continue; // acorda periodicamente so pra reavaliar FblnParar

    while not FblnParar do
    begin
      LblnTemFrame := False;
      LsckEstacaoLocal := INVALID_SOCKET;
      FcsEstado.Enter;
      try
        if FblnConectado and (FlstPendente.Count > 0) then
        begin
          LarrFrame := FlstPendente[0];
          LsckEstacaoLocal := FsckEstacao;
          { Marcado ANTES de soltar o lock pra bloquear no send() - avisa
            pFechaConexaoJaTravada (chamado de outra thread, ex.:
            Destroy) que ha I/O pendente neste socket exato, pra ele
            nunca arriscar um closesocket concorrente (ver comentario
            la). Ver tambem: capturamos LsckEstacaoLocal agora, nao lemos
            FsckEstacao direto la embaixo - assim esta chamada fica imune
            a FsckEstacao mudar de valor enquanto estamos presos. }
          FblnEscritaEmAndamento := True;
          LblnTemFrame := True;
        end;
      finally
        FcsEstado.Leave;
      end;

      if not LblnTemFrame then
        Break;

      LqwInicio := GetTickCount64;
      LblnEscreveu := fEscreveNoSocket(LsckEstacaoLocal, LarrFrame);

      if LblnEscreveu then
        pLogDiag(Format('pLoopEscritaWorker: escrita de %d bytes concluida em %d ms.',
          [Length(LarrFrame), Integer(GetTickCount64 - LqwInicio)]))
      else
        pLog(Format('pLoopEscritaWorker: escrita de %d bytes FALHOU apos %d ms (erro %d).',
          [Length(LarrFrame), Integer(GetTickCount64 - LqwInicio), WSAGetLastError]));

      FcsEstado.Enter;
      try
        FblnEscritaEmAndamento := False; // o send() devolveu o controle - ninguem mais tem I/O pendente neste socket

        if LblnEscreveu and (FlstPendente.Count > 0) then
          FlstPendente.Delete(0); // entregue de verdade (mesmo que atrasado) - nao reenviar

        if LsckEstacaoLocal <> FsckEstacao then
        begin
          { Fomos abandonados enquanto essa escrita estava presa
            (pFechaConexaoJaTravada rodou em outra thread e, por causa do
            FblnEscritaEmAndamento acima, so limpou a referencia sem
            fechar o socket de verdade). Agora que nosso send() ja
            devolveu o controle, somos os unicos donos desse socket
            antigo - fechar aqui e seguro, sem risco de corrida com mais
            ninguem. }
          closesocket(LsckEstacaoLocal);
          pLog('pLoopEscritaWorker: socket antigo (geracao abandonada) fechado com seguranca apos a escrita retornar.');
          Break; // essa geracao acabou - a atual (se houver) ja foi sinalizada por quem reconectou
        end;

        if not LblnEscreveu then
          pFechaConexaoJaTravada; // erro real do send(), ainda na mesma geracao - desconexao de verdade
      finally
        FcsEstado.Leave;
      end;

      if not LblnEscreveu then
        Break; // so volta a tentar depois que pLoopConectorELeitura reconectar e sinalizar de novo
    end;
  end;
end;

function TTefCitelDvcCanalCallback.OnDataReceived(Size: ULONG; Buffer: PByte): HRESULT;
var
  LarrDados: TBytes;
begin
  Result := S_OK;
  if (Buffer = nil) or (Size = 0) then
    Exit;

  SetLength(LarrDados, Size);
  Move(Buffer^, LarrDados[0], Size);

  { So enfileira e acorda o worker de escrita - nenhuma escrita acontece
    nesta thread (a mesma que recebe os callbacks do canal DVC; bloquear
    aqui atrasaria o proprio canal). O worker decide sozinho, ao acordar,
    se ha conexao pra tentar entregar. Este metodo continua simples de
    proposito: so enfileira - ver historico completo no cabecalho da unit. }
  FcsEstado.Enter;
  try
    if FlstPendente.Count >= TEF_PLUGIN_FILA_PENDENTE_MAX then
    begin
      pLog('Fila de pendentes do plugin cheia - descartando o frame mais antigo.');
      FlstPendente.Delete(0);
    end;
    FlstPendente.Add(LarrDados);
  finally
    FcsEstado.Leave;
  end;

  FevtNovoFramePendente.SetEvent;
end;

function TTefCitelDvcCanalCallback.OnClose: HRESULT;
begin
  pLog('Canal DVC fechado pelo lado autcom.exe.');
  FblnParar := True;
  FevtNovoFramePendente.SetEvent;
  FChannel := nil;
  Result := S_OK;
end;

{ TTefCitelDvcPlugin }

function TTefCitelDvcPlugin.Initialize(const ChannelMgr: IWTSVirtualChannelManager): HRESULT;
var
  LCallback: IWTSListenerCallback;
begin
  if ChannelMgr = nil then
    Exit(E_POINTER);

  LCallback := Self;
  Result := ChannelMgr.CreateListener(PAnsiChar(TEF_DVC_PLUGIN_CANAL), 0, LCallback, FListener);
  if Succeeded(Result) then
    pLogArquivo('Listener "' + String(TEF_DVC_PLUGIN_CANAL) + '" criado.')
  else
    pLogArquivo(Format('CreateListener falhou. HRESULT = 0x%.8x', [Cardinal(Result)]));
end;

function TTefCitelDvcPlugin.Connected: HRESULT;
begin
  pLogArquivo('Sessao RDP conectada.');
  Result := S_OK;
end;

function TTefCitelDvcPlugin.Disconnected(DisconnectCode: DWORD): HRESULT;
begin
  pLogArquivo('Sessao RDP desconectada. Codigo = ' + IntToStr(DisconnectCode));
  Result := S_OK;
end;

function TTefCitelDvcPlugin.Terminated: HRESULT;
begin
  pLogArquivo('Plugin terminado.');
  FListener := nil;
  Result := S_OK;
end;

function TTefCitelDvcPlugin.OnNewChannelConnection(const Channel: IWTSVirtualChannel;
  Data: PWideChar; Accept: PBOOL; out Callback: IWTSVirtualChannelCallback): HRESULT;
begin
  Pointer(Callback) := nil;
  if (Channel = nil) or (Accept = nil) then
    Exit(E_POINTER);

  Accept^ := True;
  Callback := TTefCitelDvcCanalCallback.Create(Channel);
  pLogArquivo('Conexao aceita no canal "' + String(TEF_DVC_PLUGIN_CANAL) + '".');
  Result := S_OK;
end;

initialization
  { FcsLogArq precisa existir antes da primeira linha de log, e a
    primeira pode sair de dentro do DllMain (Initialize do plugin). }
  FcsLogArq := TCriticalSection.Create;

finalization
  FcsLogArq.Free;

end.
