unit untTefCitelDvcTransporte;

{ Transporte de baixo nivel do canal RDP Dynamic Virtual Channel (DVC) usado
  pelo lado AUTCOM (dentro do autcom.exe, rodando na sessao RDP do operador)
  para conversar com o servico Windows da estacao (Req. 456190).

  Responsabilidade unica desta unit: abrir/fechar o canal WTS e entregar/
  receber frames de bytes ja delimitados (framing por tamanho). Nenhuma
  logica de protocolo RPC ou de negocio do TEF vive aqui - isso fica em
  untTefCitelDvc.pas.

  Portado do prototipo DVC/src/server/TefDvcServer.dpr (canal "TefCitelCh"),
  que so foi validado ponta a ponta com uma mensagem PING/PONG de 4 bytes.
  A deteccao de CHANNEL_PDU_HEADER abaixo replica exatamente a heuristica do
  prototipo (nunca exercitada com payloads maiores) - precisa ser validada
  com hardware real na Fase 3; se o enquadramento vier corrompido em campo,
  comece a investigacao por aqui.

  RECONEXAO DO CANAL (Req. 456190, Fase 5, 2026-09-09). Antes desta versao o
  canal era aberto UMA vez no construtor e a primeira falha real de leitura
  matava a thread de leitura de vez: o autcom.exe ficava com um canal morto
  ate o pIniciaTefCitel (untTefCitelUtil.pas:749) descartar o objTefCitel e
  criar uma instancia nova. Isso significava que qualquer oscilacao da sessao
  RDP - que em cliente com internet ruim e o caso comum, nao a excecao -
  deixava o TEF inutilizavel ate o operador reentrar na rotina.

  Agora a falha real de leitura entra num laco de reabertura, no mesmo
  formato que o pLoopConectorELeitura do plugin ja usa do outro lado deste
  mesmo link (Estacao\ClientPlugin\untTefCitelDvcPluginImpl.pas): fecha o
  handle morto, tenta abrir de novo em intervalos, e volta a ler quando
  conseguir. Sem timeout artificial em nada e sem teto de tentativas - quem
  encerra e o FblnParar do Destroy.

  O QUE ESTA VERSAO **NAO** MUDA, de proposito: a chamada RPC pendente
  continua morrendo na desconexao. O pNotificaDesconexao continua sendo
  disparado a cada queda real, e o untTefCitelDvc.pas continua marcando
  ErroCanal nas chamadas de FdictChamadas - ou seja, para o operador o
  comportamento e identico ao de antes. O ganho isolado desta etapa e so
  este: o canal se cura, e a chamada SEGUINTE funciona sem trocar a
  instancia. Fazer a chamada pendente sobreviver a queda e o passo seguinte
  da Fase 5 (RF25 parte 2 + RF26), que depende do frame "reata" para saber
  se a estacao ainda tem aquele id. Ver IA\specs\456190\plans.md, secao 9. }

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, System.SyncObjs,
  System.Generics.Collections;

const
  TEF_DVC_CANAL = 'TefCitelCh';
  { Era 2000ms - achado real de campo (2026-08-31, Req. 456190, comparando
    com DVC_v2\relatorio-teste-viabilidade-dvc.md): um WTSVirtualChannelRead
    que expira com erro ERROR_IO_INCOMPLETE parece descartar dados que
    estavam prestes a chegar, nao so "nao ter chegado nada ainda" - o
    prototipo DVC_v2 (mesma API, mesmo canal) usa 15000ms e nunca perdeu um
    byte em 105.600 idas e voltas de ate 1 MiB; o de producao, com 2000ms,
    perdia deterministicamente o restante de mensagens grandes (~2.3KB) no
    debito, sempre apos o mesmo padrao (chunk parcial, depois nada por
    ~30s). Subir para 15000ms nao viola IA\rules\tef-dvc.md - esse timeout
    e so o intervalo de poll (o loop nunca desiste de verdade, so re-chama
    WTSVirtualChannelRead), e o Destroy ja desbloqueia leitura pendente via
    WTSVirtualChannelClose direto, sem depender deste valor pra encerrar
    rapido. }
  TEF_DVC_TIMEOUT_LEITURA_MS = 15000;
  TEF_DVC_TAMANHO_MAX_FRAME  = 16 * 1024 * 1024; // cobre fragmentos base64 de DLL (RF10)
  { Protocolo de quadro v2 (Req. 456190, 2026-08-31) - achado de campo (hook
    DepoisPassarCartao processado 2x no credito, mesmo conteudo reaparecendo
    numa extracao que nao deveria ter acontecido) mostrou que o quadro
    logico (4 bytes de tamanho + JSON cru) nao tem como o receptor detectar
    duplicata nem corrupcao. Layout novo, identico nos dois lados (espelhado
    em untTefEstacaoTcpTransporte.pas - QUALQUER mudanca aqui precisa ir
    junto la, o plugin so repassa bytes crus, nao reencapsula):
      [4 bytes] tamanho total (= TEF_DVC_FRAME_METADATA_SIZE + tamanho do payload)
      [4 bytes] messageId (UInt32, monotonico por remetente, reinicia a
                 cada conexao nova)
      [4 bytes] CRC32 do payload (poucos KB no maximo - bit a bit e rapido
                 o bastante, sem precisar de tabela)
      [1 byte]  tipo (TEF_DVC_FRAME_TIPO_DADO ou _ACK - ver Fase 2 abaixo)
      [N bytes] payload (JSON UTF-8 se tipo=DADO; 4 bytes de messageId
                 confirmado se tipo=ACK)
    CRC invalido ou messageId <= ultimo aceito = quadro descartado e logado,
    sem repassar pro roteador - nao derruba mais a thread com excecao por
    causa de um quadro que nunca deveria ter sido processado (excecao um
    duplicado ainda manda ACK de volta - ver Fase 2, o emissor pode estar
    reenviando por nao ter visto o ACK original). }
  { Fragmentacao propria (Req. 456190, 2026-08-31) - achado de campo definitivo:
    o canal WTS, quando uma mensagem precisa de 2+ chunks fisicos
    (WTSVirtualChannelRead/Write acima de ~1,6KB), entrega repetidamente um
    pedaco de dado que NAO e o inicio real da mensagem (com o CABECALHO WTS
    correto, mas o DADO vindo de outro ponto do payload - confirmado por hex
    dump batendo byte a byte em leituras sucessivas) - varias camadas de
    defesa foram adicionadas em cima disso (dedup, CRC, ACK, deteccao de
    overshoot, validacao do inicio da mensagem) mas nenhuma resolve a causa
    fisica, so evita que o sintoma corrompa dados ou derrube a sessao;
    quando o canal so entrega ruido e nunca entrega o chunk real (visto em
    campo no debito), a mensagem fica presa para sempre. Decisao (Rafael,
    2026-08-31): parar de depender da remontagem multi-chunk do WTS -
    fragmentar toda mensagem grande NA ORIGEM em pedacos pequenos o
    suficiente pra cada um caber, sempre, num UNICO chunk fisico, e remontar
    no DESTINO usando o proprio protocolo de quadro (que ja tem
    messageId/CRC/ACK por quadro) em vez do enquadramento do canal. }
  TEF_DVC_TAMANHO_MAX_FRAGMENTO = 1400; // bytes de payload por quadro - margem confortavel abaixo do ~1604 observado como teto de 1 chunk fisico WTS
  TEF_DVC_FRAME_METADATA_SIZE = SizeOf(UInt32) * 2 + SizeOf(Byte) + SizeOf(Word) * 2; // messageId + crc32 + tipo + numFragmento + totalFragmentos
  TEF_DVC_FRAME_TIPO_DADO = 0;
  TEF_DVC_FRAME_TIPO_ACK  = 1;

  { Fase 2 (2026-08-31) - ACK de transporte + retry, independente do
    "resposta"/"hook_resposta" de negocio. Achado de campo: o hook
    DepoisPassarCartao as vezes trava no meio do canal DVC (chunk 2 nunca
    chega) e so descobrimos isso 30s depois, quando o timeout de negocio
    do lado estacao desiste (TEF_ESTACAO_TIMEOUT_HOOK_MS). Com ACK de
    transporte, a FALTA de confirmacao vira visivel em poucos segundos, e
    o reenvio (mesmo messageId, mesmo CRC) e seguro porque o receptor
    dedupica - na pior das hipoteses o dado chega 2x fisicamente mas so e
    processado 1 vez. Nao viola IA\rules\tef-dvc.md: isso e um teto sobre
    um sinal auxiliar de entrega entre os dois transportes, nao sobre a
    chamada TEF/pinpad em si - se todas as tentativas esgotarem, o
    comportamento e identico ao de uma falha de escrita no canal (excecao
    ETefCitelDvcTransporte), que ja era tratada em todos os pontos de
    chamada. }
  TEF_DVC_ACK_TIMEOUT_MS = 2000;
  TEF_DVC_ACK_MAX_TENTATIVAS = 5; // ~10s de retry no pior caso antes de desistir

  { Teto para uma chamada cujo quadro NUNCA foi confirmado pelo servico da
    estacao (Req. 456190, 2026-09-12). ISTO NAO E TIMEOUT SOBRE O PINPAD e a
    regra de IA\rules\tef-dvc.md continua valendo integralmente - o
    comentario extenso em TTefCitelDvc.fChamaRpcUmaVez explica por que as duas
    coisas sao diferentes. Resumo: o ACK vem do SERVICO, entao "sem ACK"
    significa que o pedido nao chegou a ele e nada pode estar em curso no
    pinpad.

    30 s e 3x o orcamento de ACK (5 x 2000 ms): da folga para um reinicio do
    servico se completar sem virar erro na cara do operador. }
  TEF_DVC_TIMEOUT_SEM_CONFIRMACAO_MS = 30000;
  { Quantos messageId recentemente aceitos ficam guardados para deduplicar
    (Req. 456190, 2026-09-04) - ver fAceitaMessageId. Com o retry de ACK
    desistindo em ~10s (5 x TEF_DVC_ACK_TIMEOUT_MS), 512 quadros de folga
    cobrem qualquer retransmissao legitima com margem enorme: no pico de
    trafego medido em campo (Modalidade Dinamica - evento, pInfo21 e ACK a
    cada poucas centenas de ms) sao algumas dezenas de quadros nesses 10s. }
  TEF_DVC_DEDUP_MAX_IDS = 512;
  { Idade acima da qual um messageId repetido NAO pode mais ser
    retransmissao legitima (Req. 456190, Passo 8 - achado de campo
    2026-09-11, log das 07:35:55 e 07:36:31). Ver fAceitaMessageId:
    passado este prazo, id repetido quer dizer que o OUTRO lado zerou o
    contador, e o certo e esvaziar o dedup em vez de descartar o quadro.
    Tres vezes o orcamento de retransmissao (TEF_DVC_ACK_MAX_TENTATIVAS x
    TEF_DVC_ACK_TIMEOUT_MS = ~10s): fora do alcance de qualquer
    retransmissao, e ordens de grandeza abaixo do intervalo entre dois
    reinicios do servico da estacao. Derivado das duas constantes de
    proposito - se o orcamento do ACK mudar, este prazo acompanha. }
  TEF_DVC_DEDUP_EPOCA_MS = 3 * TEF_DVC_ACK_MAX_TENTATIVAS * TEF_DVC_ACK_TIMEOUT_MS;

  { Reconexao do canal (Req. 456190, Fase 5). O intervalo nao e timeout de
    nada - e so o descanso entre duas tentativas de abrir o canal enquanto a
    sessao RDP nao voltou. A espera e fatiada em pedacos de
    TEF_DVC_RECONEXAO_PASSO_MS para o Destroy nao ficar preso ate o fim de um
    intervalo inteiro.

    O log e limitado porque a sessao RDP pode ficar desconectada por muito
    tempo (o TSPlus mantem por ~100 min, ver specs.md 9.1): logar cada
    tentativa encheria o arquivo do mesmo jeito que o timeout de leitura
    encheria se nao fosse so em DEBUG. Loga a primeira, uma a cada
    TEF_DVC_RECONEXAO_LOG_CADA, e sempre o sucesso com a contagem total. }
  TEF_DVC_INTERVALO_RECONEXAO_MS = 2000;
  TEF_DVC_RECONEXAO_PASSO_MS     = 200;
  TEF_DVC_RECONEXAO_LOG_CADA     = 15; // ~30 s de silencio entre linhas

  { RF22 (Req. 456190, Passo 8 da Fase 5) - nivel/rotacao do log. COPIA
    das mesmas constantes de libTefCitel\Estacao\untTefEstacaoLog.pas e
    de untTefCitelDvcPluginImpl.pas: os tres processos leem um .ini com a
    MESMA secao e as MESMAS chaves, mas cada projeto tem search path
    proprio e nao compartilha unit (mesma decisao ja tomada para fCrc32 -
    ver IA\rules\tef-dvc.md). Mudanca aqui precisa ser replicada nos tres
    na MESMA sessao, senao eles passam a se comportar diferente com a
    mesma configuracao.

    Uma linha e gravada quando o nivel DELA e menor ou igual ao
    configurado. Toda chamada que existia antes do Passo 8 continua
    NORMAL, MENOS as que registram POR QUADRO/POR LEITURA - essas foram
    para DIAGNOSTICO, porque eram elas que produziam as ~100 linhas por
    transacao de cartao (da ordem de 3 MB/dia numa estacao movimentada).

    ATENCAO ao ligar Nivel=2 em producao: o volume de chamada de log que
    isso restabelece e exatamente o que expos o "Bug 6" (corrupcao de
    alocacao de string sob ShareMem/BORLNDMM.DLL com log de todo chunk,
    2026-08-28 - ver o comentario do FcsLog abaixo). O FcsLog corrigiu a
    falta de lock, mas o modo verboso segue sendo modo de investigacao,
    nao de operacao. }
  TEF_LOG_NIVEL_DESLIGADO   = 0;
  TEF_LOG_NIVEL_NORMAL      = 1;
  TEF_LOG_NIVEL_DIAGNOSTICO = 2;

  TEF_LOG_INI_ARQUIVO = 'TefCitelDvcLog.ini';
  TEF_LOG_INI_SECAO   = 'Log';
  TEF_LOG_ARQUIVO     = 'TefCitelDvcTransporte.log';

  { Pasta padrao do log, ao lado do autcom.exe (pedido do Rafael,
    2026-09-21). Antes o default era %TEMP%, que separa por sessao mas
    espalha o log por perfis e e candidato a Limpeza de Disco - o suporte
    precisava saber em qual %TEMP% procurar. }
  TEF_LOG_PASTA_PADRAO = 'TefLog';

  TEF_LOG_NIVEL_DEFAULT          = TEF_LOG_NIVEL_NORMAL;
  TEF_LOG_TAMANHO_MAX_MB_DEFAULT = 10;
  TEF_LOG_ARQUIVOS_DEFAULT       = 3;
  TEF_LOG_CHECAR_TAMANHO_CADA    = 64;


{ Log de diagnostico do canal DVC do lado autcom (Req. 456190) - grava em
  <pasta do autcom.exe>\TefLog, num arquivo por ESTACAO (ver
  implementacao). Exposta na interface para uso
  tambem em untTefCitelDvc.pas (ex.: confirmar que um envelope RPC foi
  realmente enviado), nao so no transporte.

  pLogaDiagnosticoDvc grava em TEF_LOG_NIVEL_NORMAL - assinatura
  preservada, as dezenas de chamadas que ja existiam continuam iguais.
  Para uma linha por quadro/por leitura, usar
  pLogaDiagnosticoDvcNivel(TEF_LOG_NIVEL_DIAGNOSTICO, ...).

  fLogDvcAtivo existe para quem monta mensagem CARA (hex dump, JSON
  inteiro): sem ele o custo do Format e pago mesmo com o nivel
  desligado, porque o argumento e avaliado antes da chamada. }
procedure pLogaDiagnosticoDvc(const AstrMsg: String);
procedure pLogaDiagnosticoDvcNivel(const AintNivel: Integer; const AstrMsg: String);
function fLogDvcAtivo(const AintNivel: Integer): Boolean;

type
  ETefCitelDvcTransporte = class(Exception);

  TprocTefDvcFrameRecebido = procedure(const AbytFrame: TBytes) of object;
  TprocTefDvcDesconectado  = procedure of object;
  { Disparado depois de uma REABERTURA bem-sucedida do canal (Req. 456190,
    RF26, Passo 3) - nao na abertura do construtor, onde o dono ainda nao
    teve chance de atribuir o handler. E por aqui que o dono sabe que precisa
    mandar o "reata". }
  TprocTefDvcConectado     = procedure of object;

  TTefCitelDvcTransporte = class
  private
    FhndCanal: THandle;
    { Nome do canal guardado para a reabertura (Req. 456190, Fase 5) - antes
      ele so existia como parametro do construtor, porque o canal era aberto
      uma unica vez. }
    FstrCanal: AnsiString;
    FthrLeitura: TThread;
    FcsEscrita: TCriticalSection;
    { Contador de escritas nossas no canal (Req. 456190, item 1 do Passo 8
      da Fase 5). Serve para atribuir uma leitura abortada a uma escrita
      nossa: leitura e escrita compartilham o estado overlapped do MESMO
      handle e toda escrita aborta a leitura em curso com
      ERROR_IO_INCOMPLETE (ver o comentario extenso em pLoopLeitura,
      medido em campo em 2026-09-04). Incrementado por pEnviaFrameBruto,
      lido em pLoopLeitura e em pEnviaUmFragmento - so como diagnostico,
      nenhuma decisao depende dele. }
    FintSeqEscritas: Integer;

    FblnConectado: Boolean;
    FblnParar: Boolean;
    FarrBuffer: TBytes;
    { Bug real confirmado em campo (2026-08-28, dump forense de
      pExtraiFramesDisponiveis): as flags CHANNEL_FLAG_FIRST/LAST do
      CHANNEL_PDU_HEADER NAO se comportam como o padrao MS-RDPBCGR sugere
      nesta combinacao mstsc.exe/mensagem grande - um chunk chegou com
      flags=LAST (2) declarando totalLength=2298, mas so trazia 1596 bytes
      de dados (o buffer estava vazio antes dele - nao era o segundo
      chunk de nada). Ou seja, nao da pra confiar nas flags pra decidir
      quando uma mensagem multi-chunk terminou. fProcessaChunkWts (ver
      mais abaixo) ignora as flags para essa decisao - acumula chunks
      neste par de campos ate o total de bytes bater com o "totalLength"
      declarado pelo PRIMEIRO chunk visto (esse valor sempre bateu com o
      tamanho real do payload em todos os testes de campo, mesmo quando
      as flags nao faziam sentido). }
    FarrPayloadWtsParcial: TBytes;
    FdwTotalWtsEsperado: DWORD;
    { Protocolo de quadro v2 (2026-08-31) - ver TEF_DVC_FRAME_METADATA_SIZE.
      FintProximoMessageId numera os quadros que ESTE lado envia.

      Deduplicacao (Req. 456190, refeita em 2026-09-04): FdictIdsAceitos e
      FqueIdsAceitos guardam os ultimos TEF_DVC_DEDUP_MAX_IDS messageId
      aceitos do OUTRO lado - o criterio passa a ser "ja vi ESTE id" em vez
      de "id menor ou igual ao maior que ja vi". FdwUltimoIdRecebido continua
      existindo, mas SO como marca d'agua de diagnostico (maior id ja aceito);
      0 significa "nenhum quadro aceito ainda nesta conexao" (o primeiro
      messageId de verdade e sempre >= 1).

      O VALOR do FdictIdsAceitos e o GetTickCount do momento do aceite
      (era um Boolean sem uso ate 2026-09-11). E o que separa duplicata de
      verdade de contador zerado pelo outro lado - ver fAceitaMessageId e
      TEF_DVC_DEDUP_EPOCA_MS.

      Motivo da troca - achado de campo 2026-09-04, log das 15:04:30: o dedup
      por ordem estrita confundia RETRANSMISSAO LEGITIMA com duplicata. O
      canal DVC perdeu o quadro messageId=23 (resposta de um pInfo21 aninhado
      dentro de fPassarCartao); o outro lado retransmitiu 2s depois por falta
      de ACK, mas nesse meio tempo o 24 ja tinha sido aceito - o 23 foi
      descartado como "duplicado" E re-ACKado, entao o emissor deu por
      entregue e parou de retransmitir. Resultado: a fChamaRpc do pInfo21
      nunca desenrolou e, como a de fPassarCartao esta abaixo dela na mesma
      pilha reentrante, a tela do autcom travou em "NAO AUTORIZADA" mesmo com
      a resposta do fPassarCartao tendo chegado inteira.

      Ou seja: a retransmissao existe justamente pra sobreviver a perda no
      canal, e o dedup a estava anulando. Com o conjunto, perda no trecho DVC
      vira ~2s de atraso em vez de trava permanente.

      Isto NAO conserta a causa da perda, que continua de pe - ver o
      comentario em pLoopLeitura sobre WTSVirtualChannelWrite abortando o
      WTSVirtualChannelRead pendente. }
    FintProximoMessageId: Integer;
    FdwUltimoIdRecebido: UInt32;
    FdictIdsAceitos: TDictionary<UInt32, DWORD>; // valor = GetTickCount do aceite
    FqueIdsAceitos: TQueue<UInt32>;
    { Pedido de zerar o dedup na proxima chegada de quadro DADO (Req. 456190,
      achado de campo 2026-09-16). Interlocked porque quem PEDE e a thread da
      chamada RPC e quem EXECUTA e a thread de leitura - o reset acontece
      dentro do fAceitaMessageId, de modo que ninguem alem da thread de
      leitura mexe em FdictIdsAceitos/FqueIdsAceitos/FdwUltimoIdRecebido.
      Sem isso seria preciso um lock novo em cima de estrutura que, ate hoje,
      e de uma thread so. }
    FintZerarDedupNaProxima: Integer;
    { Fase 2 (2026-08-31) - ACKs de transporte pendentes, chave = messageId
      do quadro DADO enviado por este lado, aguardando confirmacao. A
      thread de leitura sinaliza o TEvent quando um ACK correspondente
      chega; pEnviaFrame (chamador original, qualquer thread) espera nele
      com timeout curto e reenvia se estourar.

      O dicionario NAO e dono dos TEvent (Req. 456190, 2026-09-11). Ele era
      um TObjectDictionary com doOwnsValues, e isso era um use-after-free em
      cima de objeto de sincronizacao: pZeraEstadoDoCanal zera
      FintProximoMessageId a CADA reconexao, entao um messageId ainda
      registrado por quem espera ACK volta a ser emitido no canal novo, e o
      AddOrSetValue da espera nova DESTRUIA o TEvent em que a thread antiga
      estava parada dentro do WaitFor - e o finally dela, logo depois,
      liberava o TEvent da thread NOVA, em cascata. Agora quem espera e quem
      cria e quem libera o proprio evento; o dicionario so aponta. }
    FcsAcks: TCriticalSection;
    FdictAcksPendentes: TDictionary<UInt32, TEvent>;
    { Fragmentacao propria (2026-08-31) - acumula os fragmentos de uma
      mensagem grande recebida (0..N-1, nesta ordem) ate o ultimo chegar;
      so entao FOnFrameRecebido e chamado com o payload completo. So a
      thread de leitura toca nestes campos (mesma unica-thread de sempre),
      igual FarrBuffer/FarrPayloadWtsParcial. }
    FarrPayloadFragmentado: TBytes;
    FwProximoFragmentoEsperado: Word;
    FOnFrameRecebido: TprocTefDvcFrameRecebido;
    FOnDesconectado: TprocTefDvcDesconectado;
    FOnConectado: TprocTefDvcConectado;
    procedure pAbreCanal(const AstrCanal: AnsiString);
    { Fase 5 (Req. 456190) - reabertura do canal apos queda real. }
    function fReconectaCanal: Boolean;
    procedure pZeraEstadoDoCanal;
    procedure pAcordaAcksPendentes;
    procedure pLoopLeitura;
    function fProcessaChunkWts(ABuffer: PByte; const AintBytesLidos: ULONG): TBytes;
    procedure pAcumulaBytesRecebidos(const AarrDados: TBytes);
    procedure pExtraiFramesDisponiveis;
    function fAceitaMessageId(const AdwMessageId: UInt32;
      out AblnEpocaNova: Boolean; out AdwIdadeDaDuplicata: DWORD): Boolean;
    procedure pNotificaDesconexao;
    function fMontaFrame(const AdwMessageId: UInt32; const AbytTipo: Byte;
      const AwNumFragmento, AwTotalFragmentos: Word; const AbytPayload: TBytes): TBytes;
    procedure pEnviaFrameBruto(const AarrFrame: TBytes);
    procedure pEnviaAck(const AdwMessageIdConfirmado: UInt32);
    { True = o SERVICO da estacao confirmou este fragmento. Ver
      TEF_DVC_TIMEOUT_SEM_CONFIRMACAO_MS. }
    function fEnviaUmFragmento(const AbytPayload: TBytes; const AwNumFragmento, AwTotalFragmentos: Word): Boolean;
  public
    constructor Create(const AstrCanal: AnsiString = TEF_DVC_CANAL);
    destructor Destroy; override;
    { fEnviaFrame devolve False quando ALGUM fragmento saiu no canal sem ser
      confirmado pelo servico. pEnviaFrame e a casca que ignora a confirmacao,
      mantida com o mesmo nome da publica de TTefEstacaoConexao - a simetria
      entre os dois transportes e proposital (ver o cabecalho daquela unit). }
    function fEnviaFrame(const AbytPayload: TBytes): Boolean;
    procedure pEnviaFrame(const AbytPayload: TBytes);

    { Avisa que o outro lado VAI reiniciar e, com ele, o contador de
      messageId volta a 1 (Req. 456190, achado de campo 2026-09-16).

      O PROBLEMA. O messageId reinicia "a cada conexao nova", mas os dois
      lados discordam do que e uma conexao: para a estacao e o socket TCP,
      que morre junto com o processo; para o autcom e o CANAL DVC, que no
      reinicio da atualizacao NAO cai - quem cai e o socket plugin->servico,
      que o plugin reconecta sozinho. Resultado medido em campo: o servico
      novo respondeu com messageId=2, o autcom estava com a marca d'agua em
      6, e a resposta foi descartada como duplicata. Como o fChamaRpc espera
      com WaitFor(INFINITE) e so desiste quando o CANAL cai (regra do topo de
      IA\rules\tef-dvc.md - nao pode ter teto), o autcom ficou parado para
      sempre na tela "Aguardando o servico da estacao voltar...".

      POR QUE NAO BASTA O QUE JA EXISTIA. O fAceitaMessageId ja sabe
      reconhecer epoca nova, mas pelo TEMPO (TEF_DVC_DEDUP_EPOCA_MS, 30 s):
      id repetido depois disso "e o outro lado que zerou". O reinicio do
      TefEstacaoAtualizador leva ~1,5 s - indistinguivel de retransmissao.

      POR QUE AQUI E DETERMINISTICO. Quem chama sabe, sem adivinhar, que a
      estacao vai reiniciar: acabou de receber aplicado=true do fAtuAplica.
      Nao ha heuristica nenhuma nisto.

      RISCO ACEITO: entre o pedido e o reinicio, uma retransmissao legitima
      da epoca velha seria aceita duas vezes. A janela e de ~1,5 s e a
      estacao estar OCIOSA foi condicao para o fAtuAplica ter aceitado - nao
      ha transacao em voo para duplicar. }
    procedure pAgendaZeraDedupPorReinicioDaEstacao;
    property blnConectado: Boolean read FblnConectado;
    property OnFrameRecebido: TprocTefDvcFrameRecebido read FOnFrameRecebido write FOnFrameRecebido;
    property OnDesconectado: TprocTefDvcDesconectado read FOnDesconectado write FOnDesconectado;
    property OnConectado: TprocTefDvcConectado read FOnConectado write FOnConectado;
  end;

implementation

const
  WTS_CURRENT_SESSION        = DWORD(-1);
  WTS_CHANNEL_OPTION_DYNAMIC = $00000001;
  CHANNEL_HEADER_SIZE        = 8;
  CHANNEL_FLAG_FIRST         = $00000001;
  CHANNEL_FLAG_LAST          = $00000002;
  ERROR_TIMEOUT_WIN32        = 1460; // ERROR_TIMEOUT - nao exposto em Winapi.Windows
  ERROR_IO_INCOMPLETE_WIN32  = 996;  // ERROR_IO_INCOMPLETE - confirmado em campo (Req. 456190, 2026-08-20, Windows Server 2019) como o erro real devolvido por WTSVirtualChannelRead no timeout

function WTSVirtualChannelOpenEx(SessionId: DWORD; VirtualName: PAnsiChar;
  Flags: DWORD): THandle; stdcall; external 'wtsapi32.dll';
function WTSVirtualChannelClose(ChannelHandle: THandle): BOOL; stdcall;
  external 'wtsapi32.dll';
function WTSVirtualChannelRead(ChannelHandle: THandle; TimeOut: ULONG;
  Buffer: PAnsiChar; BufferSize: ULONG; var BytesRead: ULONG): BOOL; stdcall;
  external 'wtsapi32.dll';
function fHexDump(ABuffer: TBytes; const AintMax: Integer): String; forward;

function WTSVirtualChannelWrite(ChannelHandle: THandle; Buffer: PAnsiChar;
  Length: ULONG; var BytesWritten: ULONG): BOOL; stdcall;
  external 'wtsapi32.dll';

function fEhErroDeTimeoutLeitura(const AintErro: DWORD): Boolean;
begin
  { A documentacao publica da API nao afirma explicitamente qual erro e
    devolvido quando o timeout de leitura expira sem dados no canal
    dinamico. Confirmado em campo (Req. 456190, 2026-08-20, teste real com
    fConfiguraTefCitel em Windows Server 2019): o erro real e
    ERROR_IO_INCOMPLETE (996), nao ERROR_TIMEOUT/WAIT_TIMEOUT como
    assumido antes - o PING/PONG do prototipo nunca bateu nesse caminho
    por responder sempre na hora (0-16ms), enquanto fConfiguraTefCitel
    demora mais (carrega DLLs nativas do Scope/CliSiTef do lado da
    estacao) e expunha o timeout de verdade. Mantidos os dois candidatos
    antigos tambem, por seguranca (documentacao da Microsoft nao garante
    que o codigo seja sempre o mesmo em toda versao/config de Windows).
    Qualquer outro erro continua tratado como desconexao real do canal. }
  Result := (AintErro = ERROR_TIMEOUT_WIN32) or (AintErro = WAIT_TIMEOUT) or
    (AintErro = ERROR_IO_INCOMPLETE_WIN32);
end;

var
  { Bug real confirmado em campo (2026-08-28, EAccessViolation dentro de
    @UStrClr, dentro do proprio pLogaDiagnosticoDvc): esta funcao e chamada
    concorrentemente pela thread de leitura do canal (pLoopLeitura, nesta
    unit) E pela thread principal (fChamaRpc/pEnviaEnvelope em
    untTefCitelDvc.pas, quando uma chamada RPC sai de um clique) - sem
    nenhuma protecao contra chamada simultanea. Corrompeu a alocacao de
    string sob o gerenciador ShareMem/BORLNDMM.DLL (exigido pelo import
    "delayed" desta DLL) quando a frequencia de chamadas aumentou (log de
    todo chunk, nao so os grandes, adicionado na mesma sessao pra
    diagnosticar o bug de framing). Trava com FcsLog abaixo. }
  FcsLog: TCriticalSection;
  { Contador monotonico (Req. 456190, 2026-08-31) - achado de campo (dump do
    hook DepoisPassarCartao processado 2x no credito) precisa de prova
    definitiva de ORDEM DE CHAMADA, independente da resolucao de
    GetLocalTime (so milissegundos - varias chamadas legitimamente
    diferentes caem no mesmo milissegundo). Incrementado dentro do
    FcsLog abaixo, entao a sequencia narra a ORDEM REAL em que as chamadas
    entraram nesta funcao, mesmo vindas de threads diferentes. }
  FdwSeqLog: DWORD;
  { Configuracao do log (RF22, Passo 8) - lida UMA VEZ, na primeira linha
    do processo, e mantida em cache: alterar o .ini exige reiniciar o
    autcom. Deliberado - ler o .ini a cada linha poria uma abertura de
    arquivo extra no caminho de toda chamada TEF. }
  FblnLogConfigLida: Boolean;
  FintLogNivel: Integer;
  FintLogTamanhoMaxBytes: Int64;
  FintLogArquivos: Integer;
  FstrLogPasta: String;
  FdwLogLinhasDesdeChecagem: DWORD;
  { Caminho completo do log, montado UMA vez em pCarregaConfigLogDvc.
    Era montado a cada linha (IncludeTrailingPathDelimiter + concatenacao),
    e isso era uma alocacao de string por linha de log - ver o comentario
    extenso antes de pLogaDiagnosticoDvcNivel. Global de propria: o
    CreateFile do caminho quente usa PChar() dela, que nao aloca nada. }
  FstrLogArquivo: String;
  { ITEM 3 DO PASSO 8 (Req. 456190, 2026-09-12). Quanto a CHAMADA ANTERIOR
    gastou dentro do CreateFile/WriteFile/CloseHandle, em ms.

    O motivo de existir: o carimbo de hora desta funcao e tirado DENTRO do
    FcsLog, e a gravacao em arquivo tambem - entao o tempo gasto gravando
    uma linha desloca o carimbo da linha SEGUINTE, sem aparecer em lugar
    nenhum. No log de 11/09 isso valeu 14.930 ms num caso e 8.338 ms em
    outro, e so foi descoberto porque a leitura correspondente se reportou
    com "0 ms" de GetTickCount contra 14.930 ms de relogio de parede. Ver
    a secao do reata em IA\rules\tef-dvc.md.

    Protegida pelo FcsLog, como FdwSeqLog. Nao precisa ser exata: serve
    para dizer "esta linha chegou atrasada e o culpado foi o proprio log". }
  FdwLogGravacaoMs: DWORD;



{ O .ini fica ao lado do autcom.exe, e nao em %TEMP%: assim vale para TODAS
  as sessoes do servidor TS de uma vez, que e o comportamento desejado de
  uma configuracao. O LOG e que continua em %TEMP%, porque ali ele separa
  por usuario/sessao. Os dois processos da estacao leem o arquivo de mesmo
  nome na pasta de instalacao deles. }
function fPastaDoExeDvc: String;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

{ Nome da ESTACAO - a maquina fisica do operador, NAO o servidor TS onde
  este processo roda (pedido do Rafael, 2026-09-21).

  Vem de CLIENTNAME, que o Terminal Services define na sessao com o nome do
  cliente RDP. E a unica coisa no processo que sabe de qual maquina veio a
  sessao: COMPUTERNAME devolveria o TS, que e igual para todos e nao serve
  para separar log nenhum.

  Sem CLIENTNAME - autcom rodando direto no console da maquina, sem RDP -
  cai em COMPUTERNAME, e ai ele esta certo: nesse caso a "estacao" E esta
  maquina.

  Sanitizado porque o nome vai para dentro de um nome de arquivo. }
function fNomeEstacaoDvc: String;
var
  LintI: Integer;
begin
  Result := Trim(GetEnvironmentVariable('CLIENTNAME'));

  { O console de um servidor TS aparece como "Console" - nao e nome de
    maquina e nao ajuda a separar nada. }
  if SameText(Result, 'Console') then
    Result := '';

  if Result = '' then
    Result := Trim(GetEnvironmentVariable('COMPUTERNAME'));

  for LintI := 1 to Length(Result) do
    if not CharInSet(Result[LintI], ['A'..'Z', 'a'..'z', '0'..'9', '-', '_']) then
      Result[LintI] := '_';

  { Nome absurdamente longo nao pode estourar o MAX_PATH do caminho todo. }
  if Length(Result) > 32 then
    Result := Copy(Result, 1, 32);
end;

{ Cria o .ini com os defaults e um comentario por chave, para o suporte
  encontrar o arquivo pronto em vez de ter que saber inventar o nome.
  CREATE_NEW: dois autcom.exe da mesma estacao (ou de estacoes diferentes,
  num compartilhamento) podem tentar criar ao mesmo tempo, e quem chegar
  depois nao pode truncar o do outro. Best effort - se a pasta do autcom
  for somente leitura, os defaults valem em memoria do mesmo jeito. }
procedure pCriaIniDefaultDvc(const AstrIni: String);
const
  MODELO =
    '; TefCitelDvcLog.ini - log do TEF pelo canal DVC (Req. 456190, RF22)'#13#10 +
    ';'#13#10 +
    '; Criado automaticamente com os valores default.'#13#10 +
    ';'#13#10 +
    '; A configuracao e lida UMA VEZ, na primeira linha de log de cada'#13#10 +
    '; processo. Depois de alterar este arquivo, o autcom precisa ser'#13#10 +
    '; reiniciado para a mudanca valer.'#13#10 +
    ';'#13#10 +
    '[Log]'#13#10 +
    '; 0 = desligado, 1 = normal, 2 = diagnostico. O nivel 2 registra por'#13#10 +
    '; quadro do canal (da ordem de 100 linhas por transacao de cartao) -'#13#10 +
    '; ligar apenas durante uma investigacao, a pedido do suporte, e'#13#10 +
    '; voltar para 1 depois.'#13#10 +
    'Nivel=1'#13#10 +
    '; Tamanho maximo de cada arquivo de log, em MB. Ao passar deste'#13#10 +
    '; tamanho o arquivo e rotacionado (.log -> .1.log -> .2.log) e o mais'#13#10 +
    '; antigo e descartado.'#13#10 +
    'TamanhoMaxMB=10'#13#10 +
    '; Quantos arquivos manter no total, contando o atual. Com Arquivos=3'#13#10 +
    '; e TamanhoMaxMB=10 o log ocupa no maximo ~30 MB por pasta de log.'#13#10 +
    'Arquivos=3'#13#10 +
    '; Pasta onde gravar os logs. Vazio = subpasta TefLog ao lado do'#13#10 +
    '; autcom.exe, criada sozinha. Cada arquivo leva o nome da estacao no'#13#10 +
    '; final (TefCitelDvcTransporte_NOMEDAESTACAO.log), entao varias'#13#10 +
    '; estacoes podem gravar na mesma pasta sem se atrapalhar. Informe um'#13#10 +
    '; caminho completo para gravar em outro lugar - a pasta tem que'#13#10 +
    '; existir e ser gravavel por todos os usuarios. Se o TefLog nao puder'#13#10 +
    '; ser criado, o log cai para o %TEMP% do processo.'#13#10 +
    'Pasta='#13#10;
var
  LhndArquivo: THandle;
  LstrConteudo: AnsiString;
  LintEscritos: DWORD;
begin
  LhndArquivo := CreateFile(PChar(AstrIni), GENERIC_WRITE,
    FILE_SHARE_READ, nil, CREATE_NEW, FILE_ATTRIBUTE_NORMAL, 0);
  if LhndArquivo = INVALID_HANDLE_VALUE then
    Exit;
  try
    LstrConteudo := AnsiString(MODELO);
    WriteFile(LhndArquivo, PAnsiChar(LstrConteudo)^, Length(LstrConteudo),
      LintEscritos, nil);
  finally
    CloseHandle(LhndArquivo);
  end;
end;

{ Chamada SEMPRE de dentro do FcsLog. }
procedure pCarregaConfigLogDvc;
var
  LstrIni, LstrPastaLog: String;
  LintMb: Integer;
  LarrPasta: array[0..MAX_PATH] of Char;
begin
  FblnLogConfigLida := True;

  { Pasta padrao: <pasta do autcom.exe>\TefLog. Criada na primeira linha de
    log de cada processo.

    A QUEDA PARA %TEMP% NAO E DECORATIVA: a pasta do autcom pode ser
    somente leitura para o operador - e por isso que a criacao do .ini logo
    abaixo ja e "best effort". Se o TefLog nao puder ser criado, o log volta
    para %TEMP% em vez de simplesmente deixar de existir, que seria uma
    troca ruim para um arquivo de diagnostico. }
  LstrPastaLog := fPastaDoExeDvc + TEF_LOG_PASTA_PADRAO;
  if not DirectoryExists(LstrPastaLog) then
    ForceDirectories(LstrPastaLog);

  if DirectoryExists(LstrPastaLog) then
    FstrLogPasta := IncludeTrailingPathDelimiter(LstrPastaLog)
  else
    FstrLogPasta := IncludeTrailingPathDelimiter(GetEnvironmentVariable('TEMP'));

  LstrIni := fPastaDoExeDvc + TEF_LOG_INI_ARQUIVO;
  if not FileExists(LstrIni) then
    pCriaIniDefaultDvc(LstrIni);

  { GetPrivateProfileInt devolve o default quando o arquivo ou a chave nao
    existe, entao nao ha necessidade de conferir a criacao acima. }
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

  { Uma vez por processo. Daqui para frente o caminho quente do log nao
    monta mais string nenhuma.

    SUFIXO COM O NOME DA ESTACAO (2026-09-21): tirando o log de %TEMP%, os
    arquivos de TODAS as estacoes passam a cair na mesma pasta. Sem o
    sufixo, um autcom sobrescreveria a rotacao do outro e o log deixaria de
    responder "o que aconteceu NAQUELA estacao". A rotacao acompanha
    sozinha: ela deriva os .1/.2 deste mesmo nome. }
  FstrLogArquivo := IncludeTrailingPathDelimiter(FstrLogPasta) +
    ChangeFileExt(TEF_LOG_ARQUIVO, '') + '_' + fNomeEstacaoDvc +
    ExtractFileExt(TEF_LOG_ARQUIVO);
end;

{ Tamanho pelo CAMINHO, nao pelo handle: o handle do log e aberto so com
  FILE_APPEND_DATA e GetFileSize exige direito de leitura. Devolve 0 se o
  arquivo nao existir. }
function fTamanhoArquivoLogDvc(const AstrArquivo: String): Int64;
var
  LFad: TWin32FileAttributeData;
begin
  Result := 0;
  if not GetFileAttributesEx(PChar(AstrArquivo), GetFileExInfoStandard, @LFad) then
    Exit;
  Result := (Int64(LFad.nFileSizeHigh) shl 32) or Int64(LFad.nFileSizeLow);
end;

{ .log -> .1.log -> .2.log ..., descartando o mais antigo. Chamada de dentro
  do FcsLog.

  BEST EFFORT de proposito, e o motivo importa neste lado em especial: o
  FcsLog serializa as threads DESTE processo, e %TEMP% e por sessao TS -
  os DOIS autcom.exe da mesma sessao gravam neste mesmo arquivo (e por isso
  que existe o pid= no prefixo). Um MoveFile falha enquanto o outro
  processo tem o handle de append aberto; falhar aqui e inofensivo, o
  arquivo passa do teto por algumas linhas e a rotacao acontece na proxima
  checagem. Se o outro processo rotacionar primeiro, o OPEN_ALWAYS da
  escrita cria um arquivo novo. Nenhum dos casos perde linha ja gravada nem
  corrompe arquivo - o que nao justificaria a complexidade de um mutex
  nomeado entre processos. }
procedure pRotacionaLogDvc(const AstrArquivo: String);
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

function fLogDvcAtivo(const AintNivel: Integer): Boolean;
begin
  FcsLog.Enter;
  try
    if not FblnLogConfigLida then
      pCarregaConfigLogDvc;
    Result := AintNivel <= FintLogNivel;
  finally
    FcsLog.Leave;
  end;
end;

{ ---------------------------------------------------------------------
  AV DE CAMPO EM 2026-09-10 17:13:37 - E POR QUE ESTE LOG NAO ALOCA MAIS
  ---------------------------------------------------------------------

  O AV estourou dentro desta funcao, no antigo
  "LstrCarimbo := AnsiString(Format(...))". Foram tres excecoes
  aninhadas; a primeira - a que importa - foi um @LStrSetLength lendo o
  endereco C00000A8. Ou seja: o heap de strings JA ESTAVA CORROMPIDO
  quando esta funcao rodou. O log e a VITIMA, nao o culpado - e a funcao
  que aloca mais nesta thread, entao e onde a corrupcao aparece primeiro.

  Aconteceu no pid=80288, na queda de sessao TS das 17:13:37, no log de
  "WTSVirtualChannelRead falhou ... desconexao real do canal" - linha
  que existe desde antes do Passo 8. O outro autcom da mesma sessao
  (pid=48520) passou pela MESMA queda 28 ms antes, logou a mesma linha e
  nao estourou.

  ISTO CORRIGE O REGISTRO DE 2026-08-28 (o "Bug 6"). A causa atribuida
  naquele dia - FormatDateTime e o locale global da RTL - NUNCA FOI
  PROVADA: naquela mesma sessao tirou-se o FormatDateTime E tirou-se o
  log incondicional de pAcumulaBytesRecebidos, que era o de maior
  frequencia. O volume caiu junto, e o crash sumiu. Agora o volume voltou
  (Nivel=2, ~5x mais chamadas) e o crash voltou COM A MESMA ASSINATURA e
  SEM FormatDateTime em lugar nenhum do caminho. O que discrimina e
  volume de alocacao, nao a funcao de data.

  DECISAO (Rafael, 2026-09-10): tornar o log sem alocacao no caminho
  quente, para o INSTRUMENTO parar de ser o ponto de crash. Isto NAO
  conserta a corrupcao - ela existe com ou sem este log, e segue como
  investigacao propria (trocar o gerenciador de memoria por FastMM4 em
  FullDebugMode no autcom.exe + DLL para achar o culpado). O que se ganha
  e tirar a thread de leitura do canal de cima dela.

  O QUE ISTO NAO COBRE, e precisa ficar claro: o texto da mensagem
  (AstrMsg) e montado com Format pelo CHAMADOR, e aquele Format aloca. Se
  o heap estiver corrompido o estouro pode acontecer la. O que passa a
  ser aritmetica em buffer de pilha e todo o resto - carimbo, prefixo,
  concatenacao e conversao para AnsiString - que era a maior parte das
  alocacoes por linha.

  As copias deste nucleo no plugin (untTefCitelDvcPluginImpl.pas) e no
  servico (untTefEstacaoLog.pas) NAO receberam esta mudanca, de proposito:
  nenhum dos dois crashou, os dois sao processos pequenos, e nenhum deles
  compartilha o gerenciador de memoria com o autcom.exe (445 MB, ShareMem
  /BORLNDMM, DLLs de terceiro). O contrato do .ini - secao, chaves,
  semantica de nivel e de rotacao - continua IDENTICO nos tres, que e o
  que a regra de IA\rules\tef-dvc.md manda replicar; a implementacao
  interna divergiu por um motivo registrado. }
const
  TEF_LOG_LINHA_MAX = 4096;

  { PAnsiChar tipado, e nao literal solto: garante array estatico de
    AnsiChar, sem nenhuma conversao de UnicodeString em tempo de execucao. }
  TEF_LOG_LIT_PID: PAnsiChar = '  [pid=';
  TEF_LOG_LIT_SEQ: PAnsiChar = ' seq=';
  TEF_LOG_LIT_TID: PAnsiChar = ' tid=';
  TEF_LOG_LIT_FIM: PAnsiChar = ']  ';
  { Item 3 do Passo 8 (Req. 456190, 2026-09-12) - ver FdwLogGravacaoMs. }
  TEF_LOG_LIT_GRAV: PAnsiChar = ' gravAnterior=';
  TEF_LOG_LIT_MS: PAnsiChar = 'ms';

  { Acima disto, o custo da gravacao da linha ANTERIOR entra no prefixo da
    linha seguinte. Nao e ajuste fino: 100 ms ja e absurdo para um append de
    ~200 bytes, e abaixo do limiar o campo simplesmente nao aparece - em
    operacao normal o formato da linha nao muda em nada. }
  TEF_LOG_GRAVACAO_LENTA_MS = 100;

type
  TTefLogLinha = array[0..TEF_LOG_LINHA_MAX - 1] of AnsiChar;

{ Grava um decimal em ABuf com AintMinDigitos casas no minimo (zero a
  esquerda) e devolve a posicao seguinte. Nao aloca. }
function fLogEscreveInt(var ABuf: TTefLogLinha; const AintPos: Integer;
  const AdwValor: DWORD; const AintMinDigitos: Integer): Integer;
var
  LarrDig: array[0..15] of AnsiChar;
  LintQtd, LintPos: Integer;
  LdwValor: DWORD;
begin
  LdwValor := AdwValor;
  LintQtd := 0;
  repeat
    LarrDig[LintQtd] := AnsiChar(Byte(Ord('0') + (LdwValor mod 10)));
    Inc(LintQtd);
    LdwValor := LdwValor div 10;
  until (LdwValor = 0) or (LintQtd = Length(LarrDig));

  while (LintQtd < AintMinDigitos) and (LintQtd < Length(LarrDig)) do
  begin
    LarrDig[LintQtd] := '0';
    Inc(LintQtd);
  end;

  { LarrDig tem os digitos ao contrario - sai de tras para frente. }
  LintPos := AintPos;
  while (LintQtd > 0) and (LintPos < TEF_LOG_LINHA_MAX - 2) do
  begin
    Dec(LintQtd);
    ABuf[LintPos] := LarrDig[LintQtd];
    Inc(LintPos);
  end;
  Result := LintPos;
end;

{ Grava um literal ASCII terminado em #0. Nao aloca. }
function fLogEscreveLit(var ABuf: TTefLogLinha; const AintPos: Integer;
  const ApchLit: PAnsiChar): Integer;
var
  LpchAtual: PAnsiChar;
  LintPos: Integer;
begin
  LintPos := AintPos;
  LpchAtual := ApchLit;
  while (LpchAtual^ <> #0) and (LintPos < TEF_LOG_LINHA_MAX - 2) do
  begin
    ABuf[LintPos] := LpchAtual^;
    Inc(LintPos);
    Inc(LpchAtual);
  end;
  Result := LintPos;
end;

{ Grava o texto da mensagem byte a byte, sem conversao de string.
  Caractere acima de 255 vira '?' - o mesmo destino que a conversao
  AnsiString dava ao que nao cabe no codepage. Truncar em silencio e
  aceitavel: o teto e 4 KB por linha e a maior linha real deste log (hex
  dump de 16 bytes) nao passa de ~400 caracteres. Nao aloca. }
function fLogEscreveMsg(var ABuf: TTefLogLinha; const AintPos: Integer;
  const AstrMsg: String): Integer;
var
  LintInd, LintPos: Integer;
  LwChar: Word;
begin
  LintPos := AintPos;
  for LintInd := 1 to Length(AstrMsg) do
  begin
    if LintPos >= TEF_LOG_LINHA_MAX - 2 then
      Break;
    LwChar := Word(AstrMsg[LintInd]);
    if LwChar <= 255 then
      ABuf[LintPos] := AnsiChar(Byte(LwChar))
    else
      ABuf[LintPos] := '?';
    Inc(LintPos);
  end;
  Result := LintPos;
end;

procedure pLogaDiagnosticoDvcNivel(const AintNivel: Integer; const AstrMsg: String);
var
  { 4 KB de pilha por chamada, na thread de leitura do canal - trivial
    contra o buffer de 64 KB que pLoopLeitura ja tem. }
  LarrLinha: TTefLogLinha;
  LintPos: Integer;
  LhndArquivo: THandle;
  LintEscritos: DWORD;
  LSystemTime: TSystemTime;
  LdwSeq: DWORD;
  LdwTickGrav: DWORD;
begin
  { Log de diagnostico temporario (Fase 3, Req. 456190) para descobrir, com
    o ambiente real, qual erro o Windows realmente devolve no timeout de
    leitura do canal DVC - a suposicao em fEhErroDeTimeoutLeitura esta
    levando a falsos "canal desconectado" quando fConfiguraTefCitel demora
    mais que TEF_DVC_TIMEOUT_LEITURA_MS pra responder (carregamento real
    das DLLs do Scope/CliSiTef do lado da estacao, ao contrario do
    PING/PONG de 4 bytes do prototipo, que sempre respondeu na hora).

    Bug real confirmado em campo (2026-08-28): mesmo com FcsLog protegendo
    esta funcao inteira, dois EAccessViolation distintos (um em @UStrClr,
    outro em @UStrAsg/DateTimeToString/FormatDateTime, ambos lendo o MESMO
    endereco fixo 0x2BE - nao e coincidencia, indica corrupcao de estado
    compartilhado, nao falta de lock local) aconteceram exatamente dentro
    de FormatDateTime(..., Now). Troca de teoria: nao e (so) falta de
    sincronizacao nesta funcao - FormatDateTime/DateTimeToString usam
    configuracoes de locale globais (TFormatSettings) que podem nao ser
    thread-safe nesta versao do Delphi quando chamadas concorrentemente
    (esta funcao roda tanto na thread de leitura quanto, via
    fChamaRpc/pEnviaEnvelope em untTefCitelDvc.pas, na thread principal) -
    mesmo com FcsLog serializando as chamadas A ESTA funcao, qualquer
    OUTRO ponto do autcom.exe chamando FormatDateTime/Now ao mesmo tempo
    (fora do nosso controle, codigo legado extenso) ainda colide no
    estado global da RTL. Corrigido evitando FormatDateTime por completo -
    monta o carimbo de data/hora manualmente a partir de GetLocalTime
    (API do Windows, sem estado global compartilhado do Delphi). }
  FcsLog.Enter;
  try
    if not FblnLogConfigLida then
    begin
      pCarregaConfigLogDvc;
      FdwLogLinhasDesdeChecagem := TEF_LOG_CHECAR_TAMANHO_CADA; // forca a 1a checagem
    end;

    { A checagem de nivel vem ANTES do Inc(FdwSeqLog) para o seq nao
      pular numero por causa de linha filtrada - quem le o arquivo usa a
      sequencia para provar ordem de chamada, e um buraco na numeracao
      pareceria linha perdida. }
    if AintNivel > FintLogNivel then
      Exit;

    Inc(FdwSeqLog);
    LdwSeq := FdwSeqLog;

    { Conferir o tamanho a cada linha custaria uma consulta de atributo
      por linha; a cada TEF_LOG_CHECAR_TAMANHO_CADA o excedente maximo e
      de ~13 KB sobre o limite, irrelevante contra um teto de MB. }
    Inc(FdwLogLinhasDesdeChecagem);
    if FdwLogLinhasDesdeChecagem >= TEF_LOG_CHECAR_TAMANHO_CADA then
    begin
      FdwLogLinhasDesdeChecagem := 0;
      { Passa a global por referencia const - nao copia nem aloca. A
        rotacao em si (pRotacionaLogDvc) continua montando string, e isso
        esta aceito: ela roda uma vez por TamanhoMaxMB, nao por linha. }
      if fTamanhoArquivoLogDvc(FstrLogArquivo) >= FintLogTamanhoMaxBytes then
        pRotacionaLogDvc(FstrLogArquivo);
    end;

    { Mesmo formato de sempre (yyyy-mm-dd hh:nn:ss.zzz), escrito digito por
      digito no buffer de pilha. As posicoes fixas abaixo vao no maximo ate
      a 23a do buffer de 4096 - nao precisam de checagem de limite. }
    GetLocalTime(LSystemTime);
    LintPos := 0;
    LintPos := fLogEscreveInt(LarrLinha, LintPos, LSystemTime.wYear, 4);
    LarrLinha[LintPos] := '-';
    Inc(LintPos);
    LintPos := fLogEscreveInt(LarrLinha, LintPos, LSystemTime.wMonth, 2);
    LarrLinha[LintPos] := '-';
    Inc(LintPos);
    LintPos := fLogEscreveInt(LarrLinha, LintPos, LSystemTime.wDay, 2);
    LarrLinha[LintPos] := ' ';
    Inc(LintPos);
    LintPos := fLogEscreveInt(LarrLinha, LintPos, LSystemTime.wHour, 2);
    LarrLinha[LintPos] := ':';
    Inc(LintPos);
    LintPos := fLogEscreveInt(LarrLinha, LintPos, LSystemTime.wMinute, 2);
    LarrLinha[LintPos] := ':';
    Inc(LintPos);
    LintPos := fLogEscreveInt(LarrLinha, LintPos, LSystemTime.wSecond, 2);
    LarrLinha[LintPos] := '.';
    Inc(LintPos);
    LintPos := fLogEscreveInt(LarrLinha, LintPos, LSystemTime.wMilliseconds, 3);
    { pid= foi acrescentado em 2026-09-10 e e o campo mais importante dos
      tres, por um motivo que so aparece com dois autcom: %TEMP% e por
      USUARIO/SESSAO, e os dois autcom.exe da mesma sessao TS gravam neste
      MESMO arquivo. Sem o pid, uma linha nao tem dono - e o cenario que mais
      precisa deste log (a disputa do pinpad, RF27) e por definicao sobre dois
      autcom ao mesmo tempo. Antes so dava para agrupar por tid na mao.

      seq= narra a ordem real de chamada DENTRO DE UM PROCESSO, e so isso: o
      contador e uma global de unit, protegida pelo FcsLog deste processo. Com
      dois autcom no arquivo aparecem duas sequencias intercaladas, cada uma
      reiniciando em 1 - o que e confuso de ler sem o pid ao lado (visto em
      campo em 2026-09-10, 07:43:30). Entre processos a unica ordenacao e o
      carimbo de tempo.

      tid= identifica se a chamada veio da thread de leitura ou da thread
      principal (VCL), sem precisar adivinhar pelo texto da mensagem. }
    LintPos := fLogEscreveLit(LarrLinha, LintPos, TEF_LOG_LIT_PID);
    LintPos := fLogEscreveInt(LarrLinha, LintPos, GetCurrentProcessId, 1);
    LintPos := fLogEscreveLit(LarrLinha, LintPos, TEF_LOG_LIT_SEQ);
    LintPos := fLogEscreveInt(LarrLinha, LintPos, LdwSeq, 1);
    LintPos := fLogEscreveLit(LarrLinha, LintPos, TEF_LOG_LIT_TID);
    LintPos := fLogEscreveInt(LarrLinha, LintPos, GetCurrentThreadId, 1);

    { gravAnterior= so aparece quando a gravacao da linha anterior passou do
      limiar. Quando aparece, ele diz quantos ms deste carimbo sao atraso do
      proprio log e nao do evento narrado - e, junto com o seq=, de quem foi
      a espera no FcsLog. }
    if FdwLogGravacaoMs >= TEF_LOG_GRAVACAO_LENTA_MS then
    begin
      LintPos := fLogEscreveLit(LarrLinha, LintPos, TEF_LOG_LIT_GRAV);
      LintPos := fLogEscreveInt(LarrLinha, LintPos, FdwLogGravacaoMs, 1);
      LintPos := fLogEscreveLit(LarrLinha, LintPos, TEF_LOG_LIT_MS);
    end;

    LintPos := fLogEscreveLit(LarrLinha, LintPos, TEF_LOG_LIT_FIM);
    LintPos := fLogEscreveMsg(LarrLinha, LintPos, AstrMsg);

    { Todos os helpers param em TEF_LOG_LINHA_MAX - 2, entao estas duas
      posicoes existem sempre. }
    LarrLinha[LintPos] := #13;
    Inc(LintPos);
    LarrLinha[LintPos] := #10;
    Inc(LintPos);

    { PChar de uma global - nao aloca, nao copia. Se FstrLogArquivo estiver
      vazia (pasta nao resolvida) o CreateFile falha e a linha e perdida em
      silencio, que e o comportamento de sempre deste log. }
    { O GetTickCount comeca DEPOIS do carimbo de propósito: o que desloca o
      carimbo da proxima linha e exatamente o que vem daqui para baixo. A
      rotacao (acima) desloca o carimbo desta mesma linha e por isso nao
      entra nesta conta. }
    LdwTickGrav := GetTickCount;
    LhndArquivo := CreateFile(PChar(FstrLogArquivo), FILE_APPEND_DATA,
      FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
    if LhndArquivo = INVALID_HANDLE_VALUE then
    begin
      FdwLogGravacaoMs := GetTickCount - LdwTickGrav;
      Exit;
    end;
    try
      WriteFile(LhndArquivo, LarrLinha[0], LintPos, LintEscritos, nil);
    finally
      CloseHandle(LhndArquivo);
      FdwLogGravacaoMs := GetTickCount - LdwTickGrav;
    end;
  finally
    FcsLog.Leave;
  end;
end;

procedure pLogaDiagnosticoDvc(const AstrMsg: String);
begin
  pLogaDiagnosticoDvcNivel(TEF_LOG_NIVEL_NORMAL, AstrMsg);
end;

{ TTefCitelDvcTransporte }

constructor TTefCitelDvcTransporte.Create(const AstrCanal: AnsiString);
begin
  inherited Create;
  FcsEscrita := TCriticalSection.Create;
  FcsAcks := TCriticalSection.Create;
  FdictAcksPendentes := TDictionary<UInt32, TEvent>.Create;
  FblnConectado := False;
  FblnParar := False;
  SetLength(FarrBuffer, 0);
  FintProximoMessageId := 0;
  FdwUltimoIdRecebido := 0;
  FintZerarDedupNaProxima := 0;
  FdictIdsAceitos := TDictionary<UInt32, DWORD>.Create;
  FqueIdsAceitos := TQueue<UInt32>.Create;
  SetLength(FarrPayloadFragmentado, 0);
  FwProximoFragmentoEsperado := 0;

  FstrCanal := AstrCanal;
  pAbreCanal(AstrCanal);
  FblnConectado := True;

  FthrLeitura := TThread.CreateAnonymousThread(pLoopLeitura);
  FthrLeitura.FreeOnTerminate := False;
  FthrLeitura.Start;
end;

destructor TTefCitelDvcTransporte.Destroy;
var
  LobjEvento: TEvent;
begin
  FblnParar := True;
  FblnConectado := False;

  if FhndCanal <> 0 then
    WTSVirtualChannelClose(FhndCanal); // desbloqueia o WTSVirtualChannelRead em espera

  if Assigned(FthrLeitura) then
  begin
    FthrLeitura.WaitFor;
    FthrLeitura.Free;
  end;

  { Acorda qualquer pEnviaFrame ainda preso esperando ACK - sem isso, um
    Destroy no meio de uma espera de ACK ficaria bloqueado ate o timeout
    (TEF_DVC_ACK_TIMEOUT_MS) de cada tentativa restante. }
  FcsAcks.Enter;
  try
    for LobjEvento in FdictAcksPendentes.Values do
      LobjEvento.SetEvent;
  finally
    FcsAcks.Leave;
  end;
  FdictAcksPendentes.Free;
  FcsAcks.Free;

  FdictIdsAceitos.Free;
  FqueIdsAceitos.Free;

  FcsEscrita.Free;
  inherited;
end;

procedure TTefCitelDvcTransporte.pAbreCanal(const AstrCanal: AnsiString);
begin
  FhndCanal := WTSVirtualChannelOpenEx(WTS_CURRENT_SESSION, PAnsiChar(AstrCanal),
    WTS_CHANNEL_OPTION_DYNAMIC);
  if FhndCanal = 0 then
    raise ETefCitelDvcTransporte.CreateFmt(
      'Nao foi possivel abrir o canal DVC "%s" (erro %d). O autcom.exe precisa ' +
      'estar rodando dentro de uma sessao RDP com o plugin cliente da estacao ' +
      'ja registrado.', [String(AstrCanal), GetLastError]);
end;

function TTefCitelDvcTransporte.fProcessaChunkWts(ABuffer: PByte;
  const AintBytesLidos: ULONG): TBytes;
var
  LTotalLength, LFlags, LDataLength: DWORD;
  LintTamAntigo: Integer;
  LarrDadoChunk: TBytes;
  LdwCandidatoTamanho: UInt32;
begin
  { Causa raiz encontrada (2026-08-31, Req. 456190) - a causa real de TODA a
    investigacao de "duplicacao"/corrupcao desta sessao (incluindo o achado
    original do hook processado 2x): esta funcao tem multiplos caminhos que
    devem devolver "mensagem incompleta" (Result vazio) sem nunca atribuir
    Result explicitamente - dependendo so da inicializacao implicita de
    Result em Delphi. Um log de campo provou que isso NAO estava confiavel
    aqui: Length(Result) saia igual ao tamanho da MENSAGEM ANTERIOR (a
    ultima que realmente completou e atribuiu Result), em TODO chunk
    incompleto/overshoot subsequente - ou seja, pLoopLeitura reaproveitava
    o conteudo antigo (que sobrou em LarrPayload do lado do chamador) como
    se fosse um quadro novo, e pExtraiFramesDisponiveis corretamente
    descartava como "duplicado" (porque, byte a byte, ERA o quadro
    anterior). Nao era o canal duplicando nada fisicamente - nunca foi.
    Corrigido zerando Result explicitamente logo na entrada, garantindo que
    todo caminho que nao atribuir Result de proposito devolva vazio de
    verdade. }
  Result := nil;

  { Historico do bug de framing com payload grande (Req. 456190, 2026-08-28):
    1a tentativa - so removia o header quando a flag FIRST/LAST estava
    setada; um chunk sem nenhuma das duas corrompia tudo. 2a tentativa -
    removeu essa exigencia, confiando que toda leitura comeca com um
    header de verdade (o que e verdade) e assumindo que a flag LAST
    marcaria corretamente o ultimo chunk de uma mensagem multi-chunk.

    Essa 2a suposicao caiu por terra com um dump forense em campo: um
    chunk chegou com flags=LAST (2) declarando totalLength=2298, mas so
    trazia 1596 bytes de dados - e o buffer estava vazio antes dele (nao
    era o segundo chunk de nada acumulado). Ou seja, as flags
    FIRST/LAST do CHANNEL_PDU_HEADER simplesmente NAO tem o significado
    esperado nesta combinacao especifica (canal DVC dentro do mstsc.exe) -
    nao da pra usar como sinal de "mensagem completa".

    Corrigido usando so o "totalLength" (esse valor, ao contrario das
    flags, sempre bateu com o tamanho real do payload em TODOS os testes
    de campo) - acumula os dados de cada chunk em FarrPayloadWtsParcial
    ate a soma atingir FdwTotalWtsEsperado (definido pelo totalLength do
    PRIMEIRO chunk de uma mensagem nova). So repassa pra frente
    (Result <> vazio) quando a mensagem estiver de fato completa -
    chunks parciais retornam Result vazio, pLoopLeitura simplesmente
    aguarda a proxima leitura. }
  if AintBytesLidos < CHANNEL_HEADER_SIZE then
  begin
    // buffer menor que um header - nao deveria acontecer (todo read do
    // canal comeca com um CHANNEL_PDU_HEADER de verdade); repassa cru
    // como salvaguarda, sem tentar interpretar.
    pLogaDiagnosticoDvc(Format(
      'fProcessaChunkWts: leitura menor que um header (%d bytes) - repassada crua.',
      [AintBytesLidos]));
    SetLength(Result, AintBytesLidos);
    if AintBytesLidos > 0 then
      Move(ABuffer[0], Result[0], AintBytesLidos);
    Exit;
  end;

  Move(ABuffer[0], LTotalLength, SizeOf(LTotalLength));
  Move(ABuffer[4], LFlags, SizeOf(LFlags));

  if LTotalLength > TEF_DVC_TAMANHO_MAX_FRAME then
  begin
    pLogaDiagnosticoDvc(Format(
      'fProcessaChunkWts: totalLength invalido (%d) - repassada crua.',
      [LTotalLength]));
    SetLength(Result, AintBytesLidos);
    if AintBytesLidos > 0 then
      Move(ABuffer[0], Result[0], AintBytesLidos);
    Exit;
  end;

  LDataLength := AintBytesLidos - CHANNEL_HEADER_SIZE;

  if FdwTotalWtsEsperado = 0 then
  begin
    { Achado de campo (2026-08-31, Req. 456190) - hex dump provou (byte a
      byte, nao so por tamanho) que o canal as vezes entrega, bem quando
      FdwTotalWtsEsperado ainda esta em 0 (ou seja, no lugar onde deveria
      vir o INICIO de uma mensagem nova), um pedaco de dado que na
      verdade nao e o comeco real do quadro - e sim meio de um payload
      (texto de comprovante, cheio de espacos/"\n" escapado) repetido
      identico em leituras fisicas sucessivas, ate o chunk verdadeiro
      finalmente chegar. O totalLength do header WTS bate (o cabecalho em
      si nao esta corrompido), so o DADO que vem junto nao e o inicio de
      verdade - resultado: FarrPayloadWtsParcial acumula lixo + dado real
      ate bater o tamanho esperado por coincidencia, e
      pExtraiFramesDisponiveis le um "tamanho de quadro" (nosso, os 4
      bytes que deveriam vir logo no inicio do dado) que cai em cima
      desse lixo (ex.: 0x20202020 = 4 bytes ' ' ASCII).
      Validacao adicionada aqui: um comeco de mensagem de verdade sempre
      tem, logo apos o header WTS, o NOSSO proprio prefixo de tamanho (4
      bytes) - e esse valor + 4 tem que bater exatamente com o
      totalLength que o proprio header WTS ja informou (sao os mesmos
      bytes contados de duas formas diferentes, uma pelo WTS, outra pelo
      nosso protocolo por cima). Se nao bater, este chunk nao e um comeco
      de verdade - descarta so ele (sem acumular, sem setar
      FdwTotalWtsEsperado) e aguarda a proxima leitura. }
    if LDataLength >= SizeOf(UInt32) then
    begin
      Move(ABuffer[CHANNEL_HEADER_SIZE], LdwCandidatoTamanho, SizeOf(UInt32));
      if LdwCandidatoTamanho + SizeOf(UInt32) <> LTotalLength then
      begin
        pLogaDiagnosticoDvc(Format(
          'fProcessaChunkWts: chunk recebido no lugar do INICIO de uma mensagem ' +
          'nao comeca com um quadro valido (tamanho embutido=%d, esperado=%d) - ' +
          'descartando como ruido do canal, aguardando o inicio real.',
          [LdwCandidatoTamanho, LTotalLength - SizeOf(UInt32)]));
        Exit; // Result ja e nil (zerado no topo) - nao acumula nada, FdwTotalWtsEsperado continua 0
      end;
    end;
    FdwTotalWtsEsperado := LTotalLength; // primeiro chunk desta mensagem, validado
  end
  else if LTotalLength <> FdwTotalWtsEsperado then
  begin
    { Chunk anterior nunca completou (mensagem abandonada - ex.: hook que
      estourou o timeout do lado da estacao) e este chunk pertence a uma
      mensagem NOVA e diferente (totalLength proprio nao bate com o que
      estava em andamento). Nao da pra remontar duas mensagens diferentes
      no mesmo buffer - descarta o resto pendente e comeca do zero com
      esta. }
    pLogaDiagnosticoDvc(Format(
      'fProcessaChunkWts: mensagem anterior abandonada (totalLength=%d, so ' +
      'chegou %d bytes) - descartando e iniciando nova mensagem com totalLength=%d.',
      [FdwTotalWtsEsperado, Length(FarrPayloadWtsParcial), LTotalLength]));
    SetLength(FarrPayloadWtsParcial, 0);
    FdwTotalWtsEsperado := LTotalLength;
  end;

  LintTamAntigo := Length(FarrPayloadWtsParcial);
  SetLength(FarrPayloadWtsParcial, LintTamAntigo + Integer(LDataLength));
  if LDataLength > 0 then
    Move(ABuffer[CHANNEL_HEADER_SIZE], FarrPayloadWtsParcial[LintTamAntigo], LDataLength);

  { Achado de campo (2026-08-31, Req. 456190): duas leituras seguidas do
    WTSVirtualChannelRead reportaram o MESMO tamanho de chunk (1604 bytes)
    dentro da remontagem da mesma mensagem multi-chunk - **isso so prova
    que os TAMANHOS bateram, nunca foi confirmado que o CONTEUDO (bytes)
    das duas leituras e de fato identico**. A hipotese de "canal duplica um
    chunk fisico" ainda nao esta provada - o hex dump adicionado logo
    abaixo (achado de 2026-08-31, mesma sessao) existe exatamente pra
    fechar essa duvida byte a byte, e um teste de campo seguinte reproduziu
    o mesmo padrao de tamanhos repetidos de novo, sem ainda ter capturado
    o hex das duas ocorrencias lado a lado pra comparar - Rafael pediu
    explicitamente pra nao aceitar "e o canal" sem essa prova. Sem a
    checagem de overshoot abaixo, FarrPayloadWtsParcial passava de
    FdwTotalWtsEsperado e o excesso virava lixo prefixado a um "proximo
    quadro" inexistente - pExtraiFramesDisponiveis lia um LintTamanhoFrame
    de dentro do meio de um payload (ex.: texto de cupom, "0x20202020"),
    levantava excecao, e essa excecao (sem try/except em pLoopLeitura, ate
    aquela correcao) matava a thread de leitura. A checagem abaixo detecta
    o overshoot e descarta o acumulado inteiro (impossivel separar com
    seguranca o que e a causa do que e dado novo dentro do overshoot sem
    saber ainda a causa raiz), recomecando do zero - o proximo chunk que
    chegar sera tratado como inicio de mensagem nova (mesma logica de
    "mensagem anterior abandonada" logo acima). Isso evita o crash, mas
    NAO resolve a causa raiz - continua em aberto. }
  if Cardinal(Length(FarrPayloadWtsParcial)) > FdwTotalWtsEsperado then
  begin
    pLogaDiagnosticoDvc(Format(
      'fProcessaChunkWts: overshoot na remontagem WTS (acumulado=%d, esperado=%d) - ' +
      'canal DVC duplicou/reenviou um chunk fisico. Descartando o acumulado e reiniciando.',
      [Length(FarrPayloadWtsParcial), FdwTotalWtsEsperado]));
    SetLength(FarrPayloadWtsParcial, 0);
    FdwTotalWtsEsperado := 0;
    Exit;
  end;

  { So loga chunk grande - chunks pequenos (eventos/pInfo21) ja foram
    exaustivamente confirmados corretos em campo; logar todos so
    aumentava a frequencia de chamada desta funcao sem necessidade
    (contribuiu pro Bug 6, corrupcao de heap sob chamada concorrente
    intensa).

    DIAGNOSTICO REFORCADO (2026-08-31, Req. 456190) - o achado de "chunk
    duplicado" so provava tamanhos iguais, nunca bytes iguais. Adicionado
    hex dump dos primeiros 16 bytes do DADO do chunk (apos o header de 8
    bytes) - permite comparar byte a byte se duas leituras de mesmo
    tamanho realmente carregam o mesmo conteudo (replay de verdade no
    canal) ou se sao chunks DIFERENTES que so coincidem em tamanho (nesse
    caso o bug seria nosso, na remontagem/indexacao, nao do canal). Mesmo
    gate de tamanho de sempre - nao aumenta a frequencia de chamada. }
  { O gate de nivel entra ANTES do SetLength/Move: sem ele a copia do chunk
    inteiro e o hex dump seriam pagos mesmo com o log em Nivel=1. }
  if (LDataLength > CHANNEL_HEADER_SIZE * 4) and
     fLogDvcAtivo(TEF_LOG_NIVEL_DIAGNOSTICO) then
  begin
    SetLength(LarrDadoChunk, LDataLength);
    Move(ABuffer[CHANNEL_HEADER_SIZE], LarrDadoChunk[0], LDataLength);
    pLogaDiagnosticoDvcNivel(TEF_LOG_NIVEL_DIAGNOSTICO, Format(
      'fProcessaChunkWts: chunk lido=%d bytes, totalLength=%d flags=%d, ' +
      'acumulado=%d/%d bytes, inicio do dado (hex): %s',
      [AintBytesLidos, LTotalLength, LFlags, Length(FarrPayloadWtsParcial),
       FdwTotalWtsEsperado, fHexDump(LarrDadoChunk, 16)]));
  end;

  if Cardinal(Length(FarrPayloadWtsParcial)) >= FdwTotalWtsEsperado then
  begin
    Result := FarrPayloadWtsParcial;
    SetLength(FarrPayloadWtsParcial, 0);
    FdwTotalWtsEsperado := 0;
  end;
  // senao: mensagem WTS ainda incompleta - Result fica vazio, aguarda o
  // proximo WTSVirtualChannelRead trazer o restante.

  { DIAGNOSTICO REFORCADO (2026-08-31) - fecha a duvida de "Result saiu
    vazio ou nao" sem ambiguidade nenhuma, direto no ponto de retorno -
    ate agora so inferiamos isso de fora, comparando os numeros de
    acumulado/esperado logados ACIMA, o que se mostrou insuficiente pra
    explicar uma sequencia real de campo (chunk logado como incompleto,
    seguido imediatamente por um log que so pode vir de dentro de
    pExtraiFramesDisponiveis - ou seja, algo chamou pAcumulaBytesRecebidos
    logo depois de um retorno que deveria ter sido vazio). Mesmo gate de
    tamanho - so loga quando o chunk em si ja era grande o bastante pra
    ter sido logado acima. }
  if (LDataLength > CHANNEL_HEADER_SIZE * 4) and
     fLogDvcAtivo(TEF_LOG_NIVEL_DIAGNOSTICO) then
  begin
    if Length(Result) > 0 then
      pLogaDiagnosticoDvcNivel(TEF_LOG_NIVEL_DIAGNOSTICO, Format(
        'fProcessaChunkWts: retornando com Length(Result)=%d (MENSAGEM COMPLETA).', [Length(Result)]))
    else
      pLogaDiagnosticoDvcNivel(TEF_LOG_NIVEL_DIAGNOSTICO,
        'fProcessaChunkWts: retornando com Length(Result)=0 (incompleto, aguardando mais dados).');
  end;
end;

procedure TTefCitelDvcTransporte.pZeraEstadoDoCanal;
begin
  { Canal novo = protocolo do zero, exatamente como acontecia antes quando
    uma instancia nova era criada. O par do outro lado faz o mesmo por
    conexao (ver o comentario de TTefEstacaoConexao em
    Estacao\untTefEstacaoTcpTransporte.pas): messageId e dedup so precisam
    ser monotonicos DENTRO de um mesmo canal. Nao zerar isto faria o dedup
    do outro lado descartar os primeiros quadros do canal novo como
    duplicados. }
  SetLength(FarrBuffer, 0);
  SetLength(FarrPayloadWtsParcial, 0);
  FdwTotalWtsEsperado := 0;

  { FintProximoMessageId sob FcsEscrita, e nao solto: quem o incrementa
    (pEnviaAck/pEnviaUmFragmento) faz isso com o lock tomado, junto da
    escrita do quadro - foi a correcao da corrida de 2026-09-02 documentada
    naquelas duas funcoes. Zerar por fora reabriria a mesma janela pelo
    outro lado: um writer podia pegar um id, este reset baixar o contador, e
    o proximo writer reemitir o mesmo id no canal novo. Chegar aqui com um
    writer preso e improvavel porque pAcordaAcksPendentes ja rodou antes de
    tudo, mas o lock nao custa nada e mantem a regra da unit inteira. }
  FcsEscrita.Enter;
  try
    FintProximoMessageId := 0;
  finally
    FcsEscrita.Leave;
  end;

  { Esvazia o registro de esperas de ACK junto com o contador (Req. 456190,
    2026-09-11). Sem isto um id da epoca anterior continuaria registrado e o
    ACK de MESMO numero na epoca nova acordaria a espera errada. Nao libera
    nada: o dono de cada TEvent e quem espera, e todos ja foram acordados por
    pAcordaAcksPendentes, que fReconectaCanal chama antes desta. }
  FcsAcks.Enter;
  try
    FdictAcksPendentes.Clear;
  finally
    FcsAcks.Leave;
  end;

  FdwUltimoIdRecebido := 0;
  { Queda real do canal ja zera tudo, entao um pedido pendente de
    pAgendaZeraDedupPorReinicioDaEstacao perdeu o sentido - deixa-lo de pe so
    gastaria um reset a toa no primeiro quadro da conexao nova. }
  InterlockedExchange(FintZerarDedupNaProxima, 0);
  FdictIdsAceitos.Clear;
  FqueIdsAceitos.Clear;
  SetLength(FarrPayloadFragmentado, 0);
  FwProximoFragmentoEsperado := 0;
end;

procedure TTefCitelDvcTransporte.pAcordaAcksPendentes;
var
  LobjEvento: TEvent;
begin
  { Um pEnviaFrame pode estar esperando ACK de um quadro que saiu pelo canal
    que acabou de morrer - esse ACK nunca vem. Acordar aqui faz ele falhar
    de imediato em vez de queimar TEF_DVC_ACK_MAX_TENTATIVAS x
    TEF_DVC_ACK_TIMEOUT_MS (~10 s) contra um handle fechado.

    O Destroy tem este mesmo laco inline; nao foi trocado por uma chamada a
    esta procedure de proposito, para nao mexer num destrutor com historico
    de corrida documentado (ver os comentarios dele). }
  FcsAcks.Enter;
  try
    for LobjEvento in FdictAcksPendentes.Values do
      LobjEvento.SetEvent;
  finally
    FcsAcks.Leave;
  end;
end;

function TTefCitelDvcTransporte.fReconectaCanal: Boolean;
var
  LintTentativa, LintEsperado: Integer;
  LdwErro, LdwInicio: DWORD;
begin
  Result := False;
  { GetTickCount de 32 bits, e nao GetTickCount64: e o que esta unit tem
    disponivel (o Winapi.Windows do Seattle nao declara a versao de 64) e e o
    mesmo idioma de untTefEstacaoRoteadorMensagens.pas:2139. A subtracao de
    DWORD trata a volta do contador sozinha, e aqui se mede segundos ou
    minutos - nunca os 49 dias do estouro. }
  LdwInicio := GetTickCount;

  { Fecha o handle morto ANTES de tentar abrir outro. Nao ha garantia
    documentada de que o WTSVirtualChannelOpenEx devolva um handle novo
    utilizavel com o antigo ainda aberto, e deixar handle vazando por
    oscilacao seria pior ainda. }
  if FhndCanal <> 0 then
  begin
    WTSVirtualChannelClose(FhndCanal);
    FhndCanal := 0;
  end;

  pAcordaAcksPendentes;

  LintTentativa := 0;
  while not FblnParar do
  begin
    Inc(LintTentativa);

    FhndCanal := WTSVirtualChannelOpenEx(WTS_CURRENT_SESSION,
      PAnsiChar(FstrCanal), WTS_CHANNEL_OPTION_DYNAMIC);

    if FhndCanal <> 0 then
    begin
      pZeraEstadoDoCanal;
      FblnConectado := True;
      pLogaDiagnosticoDvc(Format(
        'fReconectaCanal: canal "%s" REABERTO na tentativa %d, %d ms depois da queda. ' +
        'Estado de protocolo zerado (messageId, dedup, fragmentacao).',
        [String(FstrCanal), LintTentativa, GetTickCount - LdwInicio]));

      { Avisa o dono para mandar o "reata" (RF26). O handler NAO pode
        escrever no canal a partir daqui: esta e a thread de leitura, e o
        pEnviaFrame espera o ACK - que so pode ser recebido por ESTA thread.
        Seria a mesma espera circular ja documentada em pTrataEvento e
        pTrataHook do untTefCitelDvc.pas. Por isso o dono despacha o envio
        numa thread curta (ver TTefCitelDvc.pOnConectado). }
      if Assigned(FOnConectado) then
        FOnConectado();

      Exit(True);
    end;

    LdwErro := GetLastError;
    if (LintTentativa = 1) or (LintTentativa mod TEF_DVC_RECONEXAO_LOG_CADA = 0) then
      pLogaDiagnosticoDvc(Format(
        'fReconectaCanal: tentativa %d de reabrir o canal "%s" falhou com erro %d (%s) - ' +
        'a sessao RDP provavelmente ainda nao voltou. Continuando a tentar a cada %d ms.',
        [LintTentativa, String(FstrCanal), LdwErro, SysErrorMessage(LdwErro),
         TEF_DVC_INTERVALO_RECONEXAO_MS]));

    { Espera fatiada: o Destroy sinaliza FblnParar e faz WaitFor nesta
      thread, entao ela nao pode ficar presa num Sleep longo. }
    LintEsperado := 0;
    while (not FblnParar) and (LintEsperado < TEF_DVC_INTERVALO_RECONEXAO_MS) do
    begin
      Sleep(TEF_DVC_RECONEXAO_PASSO_MS);
      Inc(LintEsperado, TEF_DVC_RECONEXAO_PASSO_MS);
    end;
  end;

  pLogaDiagnosticoDvc(Format(
    'fReconectaCanal: encerrado por FblnParar depois de %d tentativa(s) - o transporte ' +
    'esta sendo destruido.', [LintTentativa]));
end;

procedure TTefCitelDvcTransporte.pLoopLeitura;
var
  LarrBufLeitura: array[0..65535] of Byte;
  LintBytesLidos: ULONG;
  LarrPayload: TBytes;
  LintErro: DWORD;
  { Instrumentacao do item 1 do Passo 8 (Req. 456190, 2026-09-10) - ver
    FintSeqEscritas e o bloco de captura logo abaixo. }
  LdwInicioLeitura, LdwDuracaoLeitura: DWORD;
  LintEscritasAntes, LintEscritasDurante: Integer;
begin
  while not FblnParar do
  begin
    LintBytesLidos := 0;
    { ITEM 1 DO PASSO 8 (Req. 456190, 2026-09-10) - a hipotese a confirmar
      ou refutar. Em 14:53-15:00 de 10/09 a resposta do "reata" levou 9,0 /
      9,1 / 9,7 s para ser LIDA, consumindo 4 das 5 retransmissoes, com as
      copias chegando JUNTAS (2 ms entre elas) - ou seja, nao e latencia
      por quadro, e a leitura que fica retida. A perda do PRIMEIRO quadro
      ja tem causa conhecida (colisao com a expiracao da leitura); o
      atraso das retransmissoes nao.

      A suspeita e que a causa seja NOSSA: pelo que foi medido em
      2026-09-04 (comentario extenso no ramo de erro abaixo), toda escrita
      da thread chamadora aborta a leitura em curso nesta thread. Se cada
      retransmissao de 2 em 2 s aborta a leitura que traria o proprio ACK,
      o atraso passa a ser proporcional ao numero de tentativas e as copias
      so aparecem quando as escritas param - exatamente o que foi medido.

      Estes dois valores sao o que falta para decidir: com eles, uma
      leitura de ~15000 ms e timeout de verdade, e uma de poucos ms com
      escrita no intervalo e aborto causado por nos. Custo em Nivel=1:
      duas leituras de variavel por iteracao, nada mais - as linhas de log
      correspondentes so existem em Nivel=2. }
    LdwInicioLeitura := GetTickCount;
    LintEscritasAntes := FintSeqEscritas;
    if not WTSVirtualChannelRead(FhndCanal, TEF_DVC_TIMEOUT_LEITURA_MS,
      PAnsiChar(@LarrBufLeitura[0]), SizeOf(LarrBufLeitura), LintBytesLidos) then
    begin
      LdwDuracaoLeitura := GetTickCount - LdwInicioLeitura;
      LintEscritasDurante := FintSeqEscritas - LintEscritasAntes;
      if FblnParar then
        Break;
      LintErro := GetLastError;
      { CUIDADO ao ler este caminho (Req. 456190, medido em campo 2026-09-04):
        nem todo erro 996 aqui e timeout de verdade. WTSVirtualChannelRead e
        WTSVirtualChannelWrite compartilham o estado overlapped do MESMO
        handle, e nao ha nada serializando a escrita (FcsEscrita so protege
        escritor contra escritor) contra a leitura pendente nesta thread -
        toda escrita da thread chamadora aborta a leitura em curso, que volta
        com ERROR_IO_INCOMPLETE (996), que e literalmente "o evento do
        overlapped nao esta sinalizado". No log de 2026-09-04 isso bateu 13
        de 13 vezes: todo 996 que NAO estava a 15000 ms exatos da leitura
        anterior caiu entre o "Enviando envelope" e o "enviado com sucesso"
        da thread principal, sempre a ~1 ms da escrita; a conexao do segundo
        autcom, que nao escreveu nada depois do login, so teve os de 15 s.
        Na maioria das vezes os bytes sobrevivem e chegam na leitura seguinte,
        mas nao sempre: foi assim que o messageId=23 se perdeu naquele log.
        Recuperar disso e trabalho do dedup por conjunto (ver os campos
        FdictIdsAceitos/FqueIdsAceitos) + retransmissao; ELIMINAR a perda
        exige uma thread unica dona do handle - leitura com timeout curto e
        fila FIFO de escrita drenada no mesmo laco, igual ao
        pLoopEscritaWorker que o plugin ja faz do lado cliente. Decisao
        pendente com Rafael. }
      { Era compilado sob IFDEF DEBUG ate 2026-09-10 - trocado pelo gate de NIVEL
        (RF22, Passo 8). O motivo do IFDEF continua valendo (em uso normal,
        aguardando o operador no pinpad, este timeout acontece a cada
        poucos segundos durante minutos seguidos, e logar cada ocorrencia
        em producao inundaria o arquivo), mas o IFDEF tinha um problema
        pior: a linha simplesmente NAO EXISTIA no binario de Release, e e
        justamente esta linha que o item 1 do Passo 8 precisa ler em campo.
        Com o nivel, ela existe sempre e aparece so quando pedida. O
        caminho de desconexao real (raro) continua logado sempre. }
      if fEhErroDeTimeoutLeitura(LintErro) then
      begin
        if fLogDvcAtivo(TEF_LOG_NIVEL_DIAGNOSTICO) then
          pLogaDiagnosticoDvcNivel(TEF_LOG_NIVEL_DIAGNOSTICO, Format(
            'pLoopLeitura: leitura encerrada em %d ms com erro %d (reconhecido como ' +
            'timeout; o timeout configurado e %d ms) - escritas NOSSAS no canal durante ' +
            'esta leitura: %d. Continuando a espera.',
            [LdwDuracaoLeitura, LintErro, TEF_DVC_TIMEOUT_LEITURA_MS,
             LintEscritasDurante]));
        Continue;
      end;
      pLogaDiagnosticoDvc(Format(
        'WTSVirtualChannelRead falhou com erro %d, NAO reconhecido como timeout - tratando como desconexao real do canal.',
        [LintErro]));
      { Notifica primeiro (semantica inalterada: quem espera resposta RPC
        falha com ErroCanal, igual a antes desta versao) e SO DEPOIS tenta
        reabrir. A ordem importa: reabrir antes deixaria o autcom achando
        que a chamada pendente ainda pode ser respondida no canal novo, o
        que so passa a valer no passo seguinte da Fase 5, com o "reata". }
      pNotificaDesconexao;
      if not fReconectaCanal then
        Break; // FblnParar - o transporte esta sendo destruido
      Continue;
    end;

    LdwDuracaoLeitura := GetTickCount - LdwInicioLeitura;
    LintEscritasDurante := FintSeqEscritas - LintEscritasAntes;

    if LintBytesLidos = 0 then
      Continue;

    { Era "so loga leitura grande, pra reduzir a frequencia desta chamada
      (Bug 6)" - o gate de TAMANHO deu lugar ao gate de NIVEL (RF22, Passo
      8), que e mais forte: em Nivel=1 nem o Format e avaliado, enquanto o
      gate de tamanho ainda deixava passar toda leitura grande. Em troca a
      linha passa a cobrir TODA leitura quando pedida, inclusive as
      pequenas - e o ACK e uma leitura pequena, o que era exatamente o
      ponto cego do item 1. Ganhou duracao e contagem de escritas nossas
      no intervalo (ver a captura acima). }
    if fLogDvcAtivo(TEF_LOG_NIVEL_DIAGNOSTICO) then
      pLogaDiagnosticoDvcNivel(TEF_LOG_NIVEL_DIAGNOSTICO, Format(
        'pLoopLeitura: WTSVirtualChannelRead retornou %d bytes em %d ms - escritas ' +
        'NOSSAS no canal durante esta leitura: %d.',
        [LintBytesLidos, LdwDuracaoLeitura, LintEscritasDurante]));

    LarrPayload := fProcessaChunkWts(@LarrBufLeitura[0], LintBytesLidos);
    if Length(LarrPayload) > 0 then
    begin
      try
        pAcumulaBytesRecebidos(LarrPayload);
      except
        on E: Exception do
        begin
          { Mesma protecao ja existente do lado estacao
            (untTefEstacaoTcpTransporte.pas, pLoopServidor) - faltava aqui.
            Achado de campo (2026-08-31): uma excecao de framing (ex.:
            "tamanho de frame invalido" apos um chunk WTS duplicado -
            ver comentario em fProcessaChunkWts) nao era capturada em
            lugar nenhum nesta cadeia, matando esta thread de leitura em
            silencio (ou derrubando o processo, dependendo de como o
            madExcept trata excecao nao tratada em thread). Agora vira
            log + desconexao tratada normalmente, igual a qualquer outra
            falha real do canal. }
          pLogaDiagnosticoDvc(Format(
            'pLoopLeitura: excecao processando bytes recebidos: %s - tratando como desconexao do canal.',
            [E.Message]));
          pNotificaDesconexao;
          if not fReconectaCanal then
            Break; // FblnParar - o transporte esta sendo destruido
          Continue;
        end;
      end;
    end;
  end;
end;

procedure TTefCitelDvcTransporte.pNotificaDesconexao;
begin
  FblnConectado := False;
  if Assigned(FOnDesconectado) then
    FOnDesconectado();
end;

procedure TTefCitelDvcTransporte.pAcumulaBytesRecebidos(const AarrDados: TBytes);
var
  LintTamAntigo: Integer;
begin
  LintTamAntigo := Length(FarrBuffer);
  { Log de diagnostico temporario (2026-08-31) - a versao anterior deste
    log (incondicional, em TODA chamada) foi removida por suspeita de
    contribuir pro Bug 6 (corrupcao de heap sob log em alta frequencia,
    2026-08-28). Reintroduzido AQUI com o mesmo gate de tamanho ja usado
    em fProcessaChunkWts/pLoopLeitura (so loga quando o payload desta
    chamada e grande) - achado de campo (2026-08-31) mostrou uma sequencia
    onde um chunk WTS logado como INCOMPLETO (Length(Result)=0 em
    fProcessaChunkWts) e imediatamente seguido de um log que so pode vir
    de dentro de pExtraiFramesDisponiveis - ou seja, esta funcao esta
    sendo chamada em momentos que a leitura isolada dos logs anteriores
    nao explicava. Este log fecha essa lacuna: prova, sem ambiguidade, TODA
    vez que esta funcao roda com payload grande, e com qual tamanho. }
  if (Length(AarrDados) > 32) and fLogDvcAtivo(TEF_LOG_NIVEL_DIAGNOSTICO) then
    pLogaDiagnosticoDvcNivel(TEF_LOG_NIVEL_DIAGNOSTICO, Format(
      'pAcumulaBytesRecebidos: chamada com %d bytes (FarrBuffer tinha %d bytes antes).',
      [Length(AarrDados), LintTamAntigo]));
  SetLength(FarrBuffer, LintTamAntigo + Length(AarrDados));
  Move(AarrDados[0], FarrBuffer[LintTamAntigo], Length(AarrDados));
  pExtraiFramesDisponiveis;
end;

function fHexDump(ABuffer: TBytes; const AintMax: Integer): String;
var
  I, LintQtd: Integer;
begin
  Result := '';
  LintQtd := Length(ABuffer);
  if LintQtd > AintMax then
    LintQtd := AintMax;
  for I := 0 to LintQtd - 1 do
    Result := Result + IntToHex(ABuffer[I], 2) + ' ';
end;

function fCrc32(const ABuffer: TBytes): UInt32;
const
  CRC32_POLINOMIO = $EDB88320;
var
  I, J: Integer;
  LdwCrc: UInt32;
begin
  { CRC-32 (IEEE 802.3) bit a bit, sem tabela - payloads desta feature sao
    no maximo poucos KB (RF10/base64 e a excecao, ate 16MB, ainda assim
    bit a bit termina em poucos ms), nao justifica a tabela de 256 words
    so pra ganhar velocidade que ninguem vai notar aqui. }
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

procedure TTefCitelDvcTransporte.pExtraiFramesDisponiveis;
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
  LblnEpocaNova: Boolean;
  LdwIdadeDaDuplicata: DWORD;
  LdwMaiorAceitoAntes: UInt32;
begin
  while Cardinal(Length(FarrBuffer)) >= SizeOf(UInt32) do
  begin
    Move(FarrBuffer[0], LintTamanhoFrame, SizeOf(UInt32));

    if (LintTamanhoFrame > TEF_DVC_TAMANHO_MAX_FRAME) or
       (LintTamanhoFrame < TEF_DVC_FRAME_METADATA_SIZE) then
    begin
      { DIAGNOSTICO (2026-08-28): dump forense antes de lancar - achado de
        campo (mesma sessao) mostrou LintTamanhoFrame = 0x20202020 (4 bytes
        ' ' ASCII, meio de texto de cupom com padding de espacos) - o
        enquadramento desalinhou em algum ponto anterior. Com o protocolo
        v2 (2026-08-31, messageId+CRC32) um quadro corrompido no MEIO do
        payload passa a ser pego pelo CRC (abaixo, sem excecao) - este
        ramo so cobre o proprio prefixo de tamanho vir corrompido (nem da
        pra saber onde o proximo quadro comeca), caso mais raro mas ainda
        possivel.

        Req. 470363: aqui era raise, e o pLoopLeitura tratava a excecao como
        queda - fechava e reabria o canal, e a estacao, vendo a conexao cair,
        abortava a transacao no pinpad (Avenida, 14/10 09:09:14, sem queda de
        rede nenhuma). Agora descarta o buffer inteiro e espera a proxima
        leitura comecar num quadro: o que se perdeu volta pelo reenvio por
        falta de ACK, com o mesmo messageId, e o dedup cuida de repeticao. }
      pLogaDiagnosticoDvc(Format(
        'pExtraiFramesDisponiveis: LintTamanhoFrame invalido (%d bytes). ' +
        'FarrBuffer tem %d bytes no total, primeiros bytes (hex): %s',
        [LintTamanhoFrame, Length(FarrBuffer), fHexDump(FarrBuffer, 64)]));
      pLogaDiagnosticoDvc(
        'pExtraiFramesDisponiveis: buffer descartado, canal mantido - aguardando o reenvio.');
      SetLength(FarrBuffer, 0);
      Exit;
    end;

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
    SetLength(LarrPayload, Integer(LintTamanhoFrame) - TEF_DVC_FRAME_METADATA_SIZE);
    if Length(LarrPayload) > 0 then
      Move(LarrFrameCompleto[TEF_DVC_FRAME_METADATA_SIZE], LarrPayload[0], Length(LarrPayload));

    { Protocolo v2 (2026-08-31) - CRC e deduplicacao por messageId. Um
      quadro invalido (CRC nao bate, ou messageId ja visto - replay do
      canal RDP ou reprocessamento indevido, causa exata ainda em aberto
      nesta investigacao) e descartado aqui, logado, e NUNCA repassado ao
      roteador - em vez de disparar hook/RPC duas vezes ou derrubar a
      thread com uma excecao de framing corrompido. }
    LdwCrcCalculado := fCrc32(LarrPayload);
    if LdwCrcCalculado <> LdwCrcRecebido then
    begin
      pLogaDiagnosticoDvc(Format(
        'pExtraiFramesDisponiveis: quadro descartado - CRC invalido (messageId=%d, recebido=%.8x, calculado=%.8x, %d bytes de payload).',
        [LdwMessageId, LdwCrcRecebido, LdwCrcCalculado, Length(LarrPayload)]));
      Continue; // CRC nao bate - nao da pra confiar nem no messageId, nao manda ACK
    end;

    { Fase 2 (2026-08-31) - quadro tipo ACK: so sinaliza o TEvent que
      pEnviaFrame esta esperando, nunca repassa ao roteador (nao e um
      envelope de aplicacao). Payload = 4 bytes do messageId confirmado. }
    if LbytTipo = TEF_DVC_FRAME_TIPO_ACK then
    begin
      if Length(LarrPayload) >= SizeOf(UInt32) then
      begin
        Move(LarrPayload[0], LdwMessageIdConfirmado, SizeOf(UInt32));
        FcsAcks.Enter;
        try
          if FdictAcksPendentes.TryGetValue(LdwMessageIdConfirmado, LobjEventoAck) then
            LobjEventoAck.SetEvent;
          // senao: ACK de um messageId que ja desistimos de esperar (excedeu
          // tentativas) ou duplicado - inofensivo, so ignora.
        finally
          FcsAcks.Leave;
        end;
      end;
      Continue;
    end;

    LdwMaiorAceitoAntes := FdwUltimoIdRecebido;
    if not fAceitaMessageId(LdwMessageId, LblnEpocaNova, LdwIdadeDaDuplicata) then
    begin
      { A idade entra na linha porque sem ela duplicata legitima e contador
        zerado pelo outro lado produziam log IDENTICO - foi o que custou a
        leitura do achado de 2026-09-11, onde nove descartes benignos e dois
        fatais sairam com o mesmo texto e so a hora da chamada os separou. }
      pLogaDiagnosticoDvc(Format(
        'pExtraiFramesDisponiveis: quadro duplicado descartado (messageId=%d, maior aceito=%d, '
        + 'id ja aceito ha %d ms, dentro do orcamento de %d ms) - reenviando ACK mesmo assim.',
        [LdwMessageId, FdwUltimoIdRecebido, LdwIdadeDaDuplicata, TEF_DVC_DEDUP_EPOCA_MS]));
      { Manda o ACK de novo mesmo descartando o quadro - o emissor pode
        estar reenviando exatamente porque o ACK original se perdeu; sem
        isso ele ficaria retentando ate esgotar TEF_DVC_ACK_MAX_TENTATIVAS
        por um dado que ja tinhamos recebido direito. Envolvido em
        try/except: uma falha aqui e so o ACK que nao saiu (o emissor
        vai tentar de novo sozinho) - nao pode derrubar a thread de
        leitura por conta disso. }
      try
        pEnviaAck(LdwMessageId);
      except
        on E: Exception do
          pLogaDiagnosticoDvc(Format(
            'pExtraiFramesDisponiveis: falha ao reenviar ACK do messageId=%d: %s',
            [LdwMessageId, E.Message]));
      end;
      Continue;
    end;

    { Log fora de qualquer diretiva e em nivel normal: e raro (so em
      reinicio do servico ou reconexao do socket do plugin) e e a unica
      evidencia de que o conserto de 2026-09-11 atuou. }
    if LblnEpocaNova then
      pLogaDiagnosticoDvc(Format(
        'pExtraiFramesDisponiveis: messageId=%d repetido %d ms depois do aceite anterior, '
        + 'acima do orcamento de retransmissao (%d ms) - NAO e duplicata: o outro lado zerou '
        + 'o contador (reinicio do TefEstacaoService.exe ou reconexao do socket do plugin sem '
        + 'queda do canal). Dedup e marca d''agua ZERADOS e quadro ACEITO. Maior id aceito na '
        + 'epoca anterior=%d.',
        [LdwMessageId, LdwIdadeDaDuplicata, TEF_DVC_DEDUP_EPOCA_MS, LdwMaiorAceitoAntes]));

    { Quadro ATRASADO: id menor que a marca d'agua e mesmo assim novo. So
      acontece quando o canal perdeu a primeira entrega e o outro lado
      retransmitiu - antes de 2026-09-04 era exatamente este quadro que ia
      pro lixo. Log fora da diretiva DEBUG de proposito: e raro, e e a
      evidencia direta de que o canal DVC esta perdendo quadro. Se aparecer
      com frequencia em campo, a causa da perda (leitura abortada por escrita
      concorrente, ver pLoopLeitura) precisa ser atacada de vez. }
    if (FdwUltimoIdRecebido <> 0) and (LdwMessageId < FdwUltimoIdRecebido) then
      pLogaDiagnosticoDvc(Format(
        'pExtraiFramesDisponiveis: quadro ATRASADO aceito (messageId=%d, maior aceito=%d) - ' +
        'primeira entrega perdida no canal, recuperado pela retransmissao do emissor.',
        [LdwMessageId, FdwUltimoIdRecebido]));

    if LdwMessageId > FdwUltimoIdRecebido then
      FdwUltimoIdRecebido := LdwMessageId;
    try
      pEnviaAck(LdwMessageId);
    except
      on E: Exception do
        pLogaDiagnosticoDvc(Format(
          'pExtraiFramesDisponiveis: falha ao enviar ACK do messageId=%d: %s - quadro aceito mesmo assim.',
          [LdwMessageId, E.Message]));
    end;

    { DIAGNOSTICO TEMPORARIO (2026-08-28) - ver comentario acima. So loga
      frame grande - ver nota em fProcessaChunkWts sobre reduzir a
      frequencia desta chamada (Bug 6). }
    if Length(LarrPayload) > CHANNEL_HEADER_SIZE * 4 then
      pLogaDiagnosticoDvcNivel(TEF_LOG_NIVEL_DIAGNOSTICO, Format(
        'pExtraiFramesDisponiveis: quadro aceito (messageId=%d, tamanho=%d), restante no buffer=%d bytes.',
        [LdwMessageId, Length(LarrPayload), LintRestante]));

    if LwTotalFragmentos <= 1 then
    begin
      { caso comum, sem fragmentacao - comportamento identico ao de sempre. }
      if Assigned(FOnFrameRecebido) then
        FOnFrameRecebido(LarrPayload);
      Continue;
    end;

    { Fragmentacao propria (2026-08-31) - ver TEF_DVC_TAMANHO_MAX_FRAGMENTO.
      Cada fragmento ja passou pelo dedup por messageId acima (um reenvio
      do MESMO fragmento, por falta de ACK, e descartado la em cima, antes
      de chegar aqui) - o que falta e so remontar os fragmentos 0..N-1, EM
      ORDEM (o emissor so manda o fragmento seguinte depois de confirmar o
      anterior - pEnviaUmFragmento), e so despachar ao roteador quando o
      ULTIMO chegar. }
    if LwNumFragmento = 0 then
    begin
      if FwProximoFragmentoEsperado <> 0 then
        pLogaDiagnosticoDvc(Format(
          'pExtraiFramesDisponiveis: nova mensagem fragmentada comecando (messageId=%d) com uma ' +
          'reassemblagem anterior incompleta (%d fragmentos acumulados) - descartando a anterior.',
          [LdwMessageId, FwProximoFragmentoEsperado]));
      SetLength(FarrPayloadFragmentado, 0);
      FwProximoFragmentoEsperado := 0;
    end
    else if LwNumFragmento <> FwProximoFragmentoEsperado then
    begin
      { Nao deveria acontecer (envio e sequencial, ACK-gated) - mas nao da
        pra montar a mensagem com um fragmento fora de ordem sem risco de
        corromper o resultado. So loga e ignora ESTE fragmento, sem mexer
        na reassemblagem que ja estava em andamento. }
      pLogaDiagnosticoDvc(Format(
        'pExtraiFramesDisponiveis: fragmento fora de ordem descartado (messageId=%d, recebido=%d, esperado=%d).',
        [LdwMessageId, LwNumFragmento, FwProximoFragmentoEsperado]));
      Continue;
    end;

    LintTamAntigoFrag := Length(FarrPayloadFragmentado);
    SetLength(FarrPayloadFragmentado, LintTamAntigoFrag + Length(LarrPayload));
    if Length(LarrPayload) > 0 then
      Move(LarrPayload[0], FarrPayloadFragmentado[LintTamAntigoFrag], Length(LarrPayload));
    FwProximoFragmentoEsperado := LwNumFragmento + 1;

    pLogaDiagnosticoDvcNivel(TEF_LOG_NIVEL_DIAGNOSTICO, Format(
      'pExtraiFramesDisponiveis: fragmento %d/%d aceito (messageId=%d, %d bytes), acumulado=%d bytes.',
      [LwNumFragmento + 1, LwTotalFragmentos, LdwMessageId, Length(LarrPayload), Length(FarrPayloadFragmentado)]));

    if LwNumFragmento = LwTotalFragmentos - 1 then
    begin
      pLogaDiagnosticoDvc(Format(
        'pExtraiFramesDisponiveis: mensagem fragmentada completa (%d fragmentos, %d bytes no total).',
        [LwTotalFragmentos, Length(FarrPayloadFragmentado)]));
      if Assigned(FOnFrameRecebido) then
        FOnFrameRecebido(FarrPayloadFragmentado);
      SetLength(FarrPayloadFragmentado, 0);
      FwProximoFragmentoEsperado := 0;
    end;
  end;
end;

function TTefCitelDvcTransporte.fMontaFrame(const AdwMessageId: UInt32;
  const AbytTipo: Byte; const AwNumFragmento, AwTotalFragmentos: Word;
  const AbytPayload: TBytes): TBytes;
var
  LintTamanho: UInt32;
  LdwCrc: UInt32;
  LintOffsetTipo: Integer;
begin
  LdwCrc := fCrc32(AbytPayload);
  LintTamanho := TEF_DVC_FRAME_METADATA_SIZE + Length(AbytPayload);
  LintOffsetTipo := SizeOf(UInt32) * 2 + SizeOf(UInt32); // = apos [len][messageId][crc]

  SetLength(Result, SizeOf(UInt32) + LintTamanho);
  Move(LintTamanho, Result[0], SizeOf(UInt32));
  Move(AdwMessageId, Result[SizeOf(UInt32)], SizeOf(UInt32));
  Move(LdwCrc, Result[SizeOf(UInt32) * 2], SizeOf(UInt32));
  Result[LintOffsetTipo] := AbytTipo;
  Move(AwNumFragmento, Result[LintOffsetTipo + SizeOf(Byte)], SizeOf(Word));
  Move(AwTotalFragmentos, Result[LintOffsetTipo + SizeOf(Byte) + SizeOf(Word)], SizeOf(Word));
  if Length(AbytPayload) > 0 then
    Move(AbytPayload[0], Result[TEF_DVC_FRAME_METADATA_SIZE + SizeOf(UInt32)], Length(AbytPayload));
end;

{ Deduplicacao pelo conjunto dos ultimos TEF_DVC_DEDUP_MAX_IDS ids aceitos
  (Req. 456190, 2026-09-04 - comentario completo na declaracao dos campos).
  Devolve True quando o messageId e NOVO, ja o registrando; False quando ele
  ja foi aceito antes nesta conexao (duplicata de verdade).

  EPOCA NOVA (Req. 456190, Passo 8 - achado de campo 2026-09-11). O escopo
  em que o messageId e monotonico NAO e o mesmo nos dois lados:

    - estacao: zera POR CONEXAO TCP (TTefEstacaoConexao.Create zera
      FintProximoMessageId; ver Estacao\untTefEstacaoTcpTransporte.pas);
    - aqui:    zera POR CANAL DVC (pZeraEstadoDoCanal).

  Um canal DVC sobrevive a N conexoes da estacao: o plugin tem um socket
  POR CANAL e o reconecta sozinho sem derrubar o canal ("Socket
  desconectado do TefEstacaoService.exe - tentando reconectar", em
  Estacao\ClientPlugin\untTefCitelDvcPluginImpl.pas). Nas quedas de TS os
  dois zeram juntos - o mstsc morre, o plugin morre, o socket cai com ele -
  e era por isso que o defeito nunca aparecia nelas. Mas no REINICIO do
  TefEstacaoService.exe o canal DVC fica de pe: a estacao volta numerando de
  1 e este dedup descartava as primeiras respostas como duplicata,
  reenviando ACK - a estacao considerava entregue e nunca retransmitia.
  Perda SILENCIOSA, e como a regra da unit proibe timeout artificial sobre
  tempo de pinpad a chamada sincrona ficava presa para sempre (medido em
  campo: as duas telas travadas de 07:35:55 e 07:36:31, janela igual ao
  maior id aceito na epoca anterior - 2 num autcom, 14 no outro).

  O discriminador e a IDADE do aceite anterior. Retransmissao legitima
  sempre chega dentro do orcamento de ACK (~10s); id repetido depois de
  TEF_DVC_DEDUP_EPOCA_MS so pode ser contador zerado do outro lado - e ai o
  dedup inteiro e esvaziado e o quadro ACEITO. O risco do criterio e o
  inverso: uma retransmissao atrasadissima seria tomada por epoca nova e o
  envelope processado duas vezes - dano ja tratado e visto em campo sem
  consequencia ("pTrataResposta: id=N NAO ENCONTRADO em FdictChamadas"),
  contra travamento sem saida no comportamento antigo.

  O contador de SAIDA (FintProximoMessageId) de proposito NAO e zerado
  aqui: o dedup do outro lado acabou de nascer vazio e aceita os nossos ids
  altos sem problema. Zerar criaria a colisao espelhada.

  Roda so na thread de leitura (pLoopLeitura -> pAcumulaBytesRecebidos ->
  pExtraiFramesDisponiveis), igual ao FdwUltimoIdRecebido que ela substitui -
  por isso sem trava, mesmo criterio de sempre. }
procedure TTefCitelDvcTransporte.pAgendaZeraDedupPorReinicioDaEstacao;
begin
  InterlockedExchange(FintZerarDedupNaProxima, 1);
  pLogaDiagnosticoDvc(
    'pAgendaZeraDedupPorReinicioDaEstacao: a estacao aceitou aplicar e vai reiniciar - o dedup '
    + 'sera zerado na chegada do proximo quadro DADO, porque o contador de messageId dela volta '
    + 'a 1 e o canal DVC nao cai para zerar sozinho. Maior id aceito ate agora=' +
    UIntToStr(FdwUltimoIdRecebido) + '.');
end;

function TTefCitelDvcTransporte.fAceitaMessageId(const AdwMessageId: UInt32;
  out AblnEpocaNova: Boolean; out AdwIdadeDaDuplicata: DWORD): Boolean;
var
  LdwMaisAntigo: UInt32;
  LdwTickDoAceite: DWORD;
begin
  AblnEpocaNova := False;
  AdwIdadeDaDuplicata := 0;

  { Reset pedido por quem SABE do reinicio (ver
    pAgendaZeraDedupPorReinicioDaEstacao). Executado aqui, e nao no pedido,
    para que so a thread de leitura toque nestas estruturas.

    O pedido NAO e consumido pelo primeiro quadro que aparecer: entre o
    pedido e o reinicio ainda chegam respostas do servico VELHO, com o id
    subindo normalmente, e zerar ali deixaria a marca d'agua alta de novo
    bem a tempo de descartar o servico novo - foi o erro da primeira versao
    deste conserto. O pedido fica de pe ate o id ANDAR PARA TRAS, que e o
    unico momento em que o contador do outro lado so pode ter recomecado. }
  if (FintZerarDedupNaProxima = 1) and (FdwUltimoIdRecebido <> 0) and
     (AdwMessageId <= FdwUltimoIdRecebido) then
  begin
    InterlockedExchange(FintZerarDedupNaProxima, 0);
    pLogaDiagnosticoDvc(Format(
      'fAceitaMessageId: dedup ZERADO - messageId=%d veio ABAIXO da marca d''agua %d logo depois '
      + 'do reinicio anunciado da estacao. Nao e duplicata: e o servico novo comecando a contar '
      + 'do zero. Quadro ACEITO.', [AdwMessageId, FdwUltimoIdRecebido]));
    FdictIdsAceitos.Clear;
    FqueIdsAceitos.Clear;
    FdwUltimoIdRecebido := 0;
  end;

  if FdictIdsAceitos.TryGetValue(AdwMessageId, LdwTickDoAceite) then
  begin
    { Subtracao de DWORD, igual ao resto da unit (ver pLoopLeitura): o
      estouro dos 32 bits a cada 49 dias se resolve sozinho na aritmetica
      sem sinal. }
    AdwIdadeDaDuplicata := GetTickCount - LdwTickDoAceite;
    if AdwIdadeDaDuplicata <= TEF_DVC_DEDUP_EPOCA_MS then
    begin
      Result := False; // duplicata de verdade - quem chama reenvia o ACK
      Exit;
    end;

    { Epoca nova. A marca d'agua tambem tem de voltar a zero, senao todo
      quadro da epoca nova seria logado como "quadro ATRASADO aceito"
      contra a marca da epoca velha - falsa evidencia de perda no canal,
      exatamente a linha que serve pra provar o contrario. }
    AblnEpocaNova := True;
    FdictIdsAceitos.Clear;
    FqueIdsAceitos.Clear;
    FdwUltimoIdRecebido := 0;
  end;

  Result := True;
  FdictIdsAceitos.Add(AdwMessageId, GetTickCount);
  FqueIdsAceitos.Enqueue(AdwMessageId);
  while FqueIdsAceitos.Count > TEF_DVC_DEDUP_MAX_IDS do
  begin
    LdwMaisAntigo := FqueIdsAceitos.Dequeue;
    FdictIdsAceitos.Remove(LdwMaisAntigo);
  end;
end;

procedure TTefCitelDvcTransporte.pEnviaFrameBruto(const AarrFrame: TBytes);
var
  LintEscrito: ULONG;
  LintTotalEscrito: Integer;
begin
  { Antes do lock de proposito: e um contador atomico de diagnostico, e o
    que interessa e o momento em que a escrita PASSA a existir do ponto de
    vista da leitura concorrente - nao a ordem entre escritores. }
  TInterlocked.Increment(FintSeqEscritas);
  FcsEscrita.Enter;
  try
    LintTotalEscrito := 0;
    while LintTotalEscrito < Length(AarrFrame) do
    begin
      LintEscrito := 0;
      if not WTSVirtualChannelWrite(FhndCanal, PAnsiChar(@AarrFrame[LintTotalEscrito]),
        Length(AarrFrame) - LintTotalEscrito, LintEscrito) then
        raise ETefCitelDvcTransporte.CreateFmt(
          'Falha ao escrever no canal TEF DVC (erro %d).', [GetLastError]);

      if LintEscrito = 0 then
        raise ETefCitelDvcTransporte.Create('Escrita no canal TEF DVC nao avancou (0 bytes).');

      Inc(LintTotalEscrito, LintEscrito);
    end;
  finally
    FcsEscrita.Leave;
  end;
end;

procedure TTefCitelDvcTransporte.pEnviaAck(const AdwMessageIdConfirmado: UInt32);
var
  LdwMessageIdDoAck: UInt32;
  LarrPayload: TBytes;
begin
  { O ACK em si e um quadro tipo=ACK normal, com seu proprio messageId da
    sequencia deste lado (nao reaproveita o id do quadro confirmado) - mas
    NUNCA espera um ACK de volta (senao virava recursao infinita).

    Corrigido (Req. 456190, 2026-09-02) - esta funcao tinha o MESMO gap ja
    identificado e corrigido em pEnviaUmFragmento (comentario completo la):
    TInterlocked.Increment e pEnviaFrameBruto eram dois passos separados,
    sem lock cobrindo os dois juntos. Esta funcao roda na thread de LEITURA
    (ACK de todo quadro DADO recebido), concorrente com a thread que despacha
    o metodo e manda a resposta via pEnviaUmFragmento (ja protegido) - se esta
    funcao pegar seu messageId e for preemptada antes de enviar, enquanto
    outro quadro pega o proximo id e envia primeiro, o ACK atrasado chega
    DEPOIS de um id maior ja aceito e e descartado como "duplicado" pelo lado
    receptor (visto em campo: "quadro duplicado descartado (messageId=73,
    ultimo aceito=74)", 2026-09-02).

    IMPORTANTE, para nao induzir a erro quem ler isto depois: perder/reordenar
    um ACK e benigno por si so (o remetente reenvia o quadro DADO, o receptor
    deduplica e reenvia o ACK). Este fix NAO era a causa da trava investigada
    naquele dia - a causa raiz real foi encontrada em 2026-09-03 e e outra,
    do lado autcom, sem relacao com transporte: evento enfileirado por
    TThread.Queue ficando orfao porque o laco de espera de fChamaRpc saia sem
    drenar a fila (ver comentario completo em untTefCitelDvc.pas, fChamaRpc).
    O gap aqui e real e do mesmo tipo ja provado em pEnviaUmFragmento, e foi
    fechado por consistencia. Ver o espelho em
    untTefEstacaoTcpTransporte.pas, pEnviaAck. }
  FcsEscrita.Enter;
  try
    LdwMessageIdDoAck := UInt32(TInterlocked.Increment(FintProximoMessageId));
    SetLength(LarrPayload, SizeOf(UInt32));
    Move(AdwMessageIdConfirmado, LarrPayload[0], SizeOf(UInt32));
    pEnviaFrameBruto(fMontaFrame(LdwMessageIdDoAck, TEF_DVC_FRAME_TIPO_ACK, 0, 1, LarrPayload));
  finally
    FcsEscrita.Leave;
  end;
end;

procedure TTefCitelDvcTransporte.pEnviaFrame(const AbytPayload: TBytes);
begin
  fEnviaFrame(AbytPayload);
end;

function TTefCitelDvcTransporte.fEnviaFrame(const AbytPayload: TBytes): Boolean;
var
  LwTotalFragmentos, LwFrag: Word;
  LintOffset, LintTamanhoFragmento: Integer;
  LarrFragmento: TBytes;
begin
  if Length(AbytPayload) <= TEF_DVC_TAMANHO_MAX_FRAGMENTO then
  begin
    Result := fEnviaUmFragmento(AbytPayload, 0, 1);
    Exit;
  end;

  Result := True;

  { Fragmentacao propria (2026-08-31) - ver TEF_DVC_TAMANHO_MAX_FRAGMENTO.
    Envio sequencial, ACK-gated: pEnviaUmFragmento so retorna depois de
    confirmar (ou esgotar as tentativas de) o fragmento anterior, entao o
    receptor sempre ve os fragmentos em ordem - nao precisa de logica de
    reordenacao do lado de la. }
  LwTotalFragmentos := (Length(AbytPayload) + TEF_DVC_TAMANHO_MAX_FRAGMENTO - 1)
    div TEF_DVC_TAMANHO_MAX_FRAGMENTO;
  pLogaDiagnosticoDvc(Format(
    'pEnviaFrame: payload de %d bytes excede %d - fragmentando em %d pedacos de ate %d bytes.',
    [Length(AbytPayload), TEF_DVC_TAMANHO_MAX_FRAGMENTO, LwTotalFragmentos, TEF_DVC_TAMANHO_MAX_FRAGMENTO]));

  LintOffset := 0;
  for LwFrag := 0 to LwTotalFragmentos - 1 do
  begin
    LintTamanhoFragmento := Length(AbytPayload) - LintOffset;
    if LintTamanhoFragmento > TEF_DVC_TAMANHO_MAX_FRAGMENTO then
      LintTamanhoFragmento := TEF_DVC_TAMANHO_MAX_FRAGMENTO;

    SetLength(LarrFragmento, LintTamanhoFragmento);
    if LintTamanhoFragmento > 0 then
      Move(AbytPayload[LintOffset], LarrFragmento[0], LintTamanhoFragmento);

    { Segue mandando os fragmentos seguintes mesmo depois de um sem
      confirmacao - e o comportamento de sempre, e a mensagem so serve
      inteira. O que muda e que agora o chamador FICA SABENDO. }
    if not fEnviaUmFragmento(LarrFragmento, LwFrag, LwTotalFragmentos) then
      Result := False;

    Inc(LintOffset, LintTamanhoFragmento);
  end;
end;

function TTefCitelDvcTransporte.fEnviaUmFragmento(const AbytPayload: TBytes;
  const AwNumFragmento, AwTotalFragmentos: Word): Boolean;
var
  LdwMessageId: UInt32;
  LarrFrame: TBytes;
  LobjEventoAck, LobjEventoRegistrado: TEvent;
  LintTentativa: Integer;
  { Item 1 do Passo 8 (Req. 456190, 2026-09-10) - medicao da espera do
    ACK. Ver o bloco de captura em pLoopLeitura para a hipotese completa. }
  LdwInicioEnvio: DWORD;
  LintEscritasAntes: Integer;
begin
  Result := False;
  if not FblnConectado then
    raise ETefCitelDvcTransporte.Create('Canal TEF DVC nao esta conectado.');

  { O TEvent nasce ANTES de tudo que pode levantar excecao, e o try que o
    libera cobre daqui ate o fim do metodo (Req. 456190, 2026-09-11). Antes
    ele era criado e registrado DENTRO do bloco do FcsEscrita, e o try de
    limpeza so comecava depois dele: um raise em pEnviaFrameBruto (a escrita
    levanta quando o canal cai no meio) deixava a entrada pendurada no
    dicionario. Enquanto o dicionario era dono aquilo ainda se resolvia no
    Destroy; com o dono passando a ser esta procedure, manter a ordem antiga
    viraria vazamento de verdade - por isso as duas coisas mudam juntas.

    LdwMessageId comeca em 0 (id nunca emitido - TInterlocked.Increment
    entrega 1 na primeira vez) para o finally saber que ainda nao havia
    registro nenhum a remover se a excecao vier antes da atribuicao. }
  LdwMessageId := 0;
  LobjEventoAck := TEvent.Create(nil, True, False, '');
  try
    { Corrida de campo encontrada e corrigida (Req. 456190, 2026-09-02) - espelhado de
      untTefEstacaoTcpTransporte.pas, pEnviaUmFragmento (ver comentario completo la):
      atribuir o messageId e escrever o quadro (pEnviaFrameBruto, que so protege a
      escrita em si via FcsEscrita) eram dois passos separados - threads diferentes
      enviando concorrentemente (ex.: hook_resposta despachado da thread principal via
      TThread.Queue, ao mesmo tempo que um ACK sai da thread de leitura) podiam pegar
      messageId em ordem mas escrever fora de ordem, fazendo o dedup por ordem estrita
      do lado estacao descartar um quadro novo como "duplicado". Corrigido: FcsEscrita
      (reentrante por thread) agora tambem protege a atribuicao do messageId e o
      primeiro envio. Retentativas de ACK continuam fora do lock (mesmo messageId, nao
      ha ordem nova pra preservar). }
    FcsEscrita.Enter;
    try
      LdwMessageId := UInt32(TInterlocked.Increment(FintProximoMessageId));
      LarrFrame := fMontaFrame(LdwMessageId, TEF_DVC_FRAME_TIPO_DADO, AwNumFragmento, AwTotalFragmentos, AbytPayload);

      { Fase 2 (2026-08-31) - ACK de transporte com retry. O TEvent fica
        registrado em FdictAcksPendentes durante toda a espera; a thread de
        leitura (pExtraiFramesDisponiveis) o sinaliza quando o ACK chega,
        rodando em paralelo com o loop abaixo - nao ha risco de deadlock
        porque a leitura nunca depende de nada que este metodo faca. }
      FcsAcks.Enter;
      try
        FdictAcksPendentes.AddOrSetValue(LdwMessageId, LobjEventoAck);
      finally
        FcsAcks.Leave;
      end;

      pEnviaFrameBruto(LarrFrame);

      { DEPOIS da 1a escrita de proposito: o que se quer medir e o que
        acontece durante a ESPERA, e a 1a escrita e nossa por definicao.
        Assim LintEscritasAntes exclui esta escrita e inclui as
        retransmissoes deste mesmo quadro e as escritas de outras threads -
        que sao exatamente as candidatas a abortar a leitura que traz o ACK. }
      LdwInicioEnvio := GetTickCount;
      LintEscritasAntes := FintSeqEscritas;
    finally
      FcsEscrita.Leave;
    end;

    for LintTentativa := 1 to TEF_DVC_ACK_MAX_TENTATIVAS do
    begin
      if LintTentativa > 1 then
      begin
        if not FblnConectado then
          raise ETefCitelDvcTransporte.Create(
            'Canal TEF DVC desconectou enquanto aguardava confirmacao de entrega.');

        pEnviaFrameBruto(LarrFrame); // retentativa - mesmo messageId, fora do lock de propósito
      end;

      if LobjEventoAck.WaitFor(TEF_DVC_ACK_TIMEOUT_MS) = wrSignaled then
      begin
        { Destroy tambem sinaliza todo TEvent pendente pra nao deixar
          ninguem preso indefinidamente (ver destructor) - confere de novo
          se ainda estamos conectados antes de tratar isso como confirmacao
          de entrega de verdade. }
        if FblnConectado then
        begin
          if fLogDvcAtivo(TEF_LOG_NIVEL_DIAGNOSTICO) then
            pLogaDiagnosticoDvcNivel(TEF_LOG_NIVEL_DIAGNOSTICO, Format(
              'pEnviaFrame: ACK do messageId=%d confirmado em %d ms (tentativa %d/%d) - ' +
              'escritas NOSSAS no canal desde a 1a escrita deste quadro: %d.',
              [LdwMessageId, GetTickCount - LdwInicioEnvio, LintTentativa,
               TEF_DVC_ACK_MAX_TENTATIVAS, FintSeqEscritas - LintEscritasAntes]));
          Exit(True); // confirmado - a maioria dos casos cai aqui na 1a tentativa
        end;
        raise ETefCitelDvcTransporte.Create(
          'Canal TEF DVC desconectou enquanto aguardava confirmacao de entrega.');
      end;

      { Continua em NORMAL: e uma linha de anomalia, e e a que o item 1 do
        Passo 8 vai ler em producao. Ganhou os ms desde a 1a escrita e a
        contagem de escritas nossas no intervalo - com eles a linha sozinha
        ja diz se o atraso acompanha as nossas escritas. }
      pLogaDiagnosticoDvc(Format(
        'pEnviaFrame: sem ACK do messageId=%d apos %d ms (tentativa %d/%d; %d ms e ' +
        '%d escrita(s) nossa(s) no canal desde a 1a escrita deste quadro) - reenviando.',
        [LdwMessageId, TEF_DVC_ACK_TIMEOUT_MS, LintTentativa, TEF_DVC_ACK_MAX_TENTATIVAS,
         GetTickCount - LdwInicioEnvio, FintSeqEscritas - LintEscritasAntes]));
    end;

    { Achado de campo (2026-08-31): tratar isso como excecao fatal (como a
      1a versao desta Fase 2 fazia) e PIOR do que o comportamento de antes
      - um ETefCitelDvcTransporte aqui nao e capturado em NENHUM ponto da
      cadeia de chamada (fConfiguraTefCitel/fChamaRpc/pEnviaEnvelope),
      propaga ate o loop principal da VCL e derruba a sessao inteira. Isso
      aconteceu de verdade em campo, inclusive na PRIMEIRA chamada
      (fConfiguraTefCitel) - o mesmo problema de fundo que so afetava
      mensagens grandes (hook DepoisPassarCartao, 30s de espera) tambem
      pode acontecer com um quadro pequeno qualquer, em qualquer ponto -
      so que agora, sem ACK, virava crash em vez de demora.

      Antes da Fase 2, uma escrita "bem sucedida" (WTSVirtualChannelWrite
      sem erro) era so isso que dava pra confirmar - sem NENHUMA garantia
      de entrega. O retry aqui em cima so AUMENTA a chance de entrega (a
      maioria confirma na 1a ou 2a tentativa), mas quando NENHUMA das
      TEF_DVC_ACK_MAX_TENTATIVAS confirma, o certo e voltar pro mesmo
      "melhor esforco" de antes - loga bem alto e segue, sem lancar. Se o
      dado realmente nao chegou, o proprio timeout de negocio (hook de
      30s, ou o chamador RPC correspondente) ainda pega isso, do jeito
      que sempre pegou. }
    pLogaDiagnosticoDvc(Format(
      'pEnviaFrame: canal DVC NAO confirmou a entrega do messageId=%d apos %d tentativas ' +
      'e %d ms (%d escrita(s) nossa(s) no canal no intervalo) - seguindo sem ' +
      'confirmacao (melhor esforco, como antes da Fase 2 - o proprio timeout de ' +
      'negocio no nivel de aplicacao continua sendo o backstop final).',
      [LdwMessageId, TEF_DVC_ACK_MAX_TENTATIVAS, GetTickCount - LdwInicioEnvio,
       FintSeqEscritas - LintEscritasAntes]));
  finally
    { Remocao por IDENTIDADE (Req. 456190, 2026-09-11): se o id ja foi
      reemitido no canal novo (pZeraEstadoDoCanal zera o contador a cada
      reconexao), a entrada desta chave pode ser o TEvent de OUTRA thread -
      remove-la mataria a espera dela. So sai do dicionario o que for
      comprovadamente nosso; depois o dono libera o proprio evento. }
    if LdwMessageId <> 0 then
    begin
      FcsAcks.Enter;
      try
        if FdictAcksPendentes.TryGetValue(LdwMessageId, LobjEventoRegistrado) and
           (LobjEventoRegistrado = LobjEventoAck) then
          FdictAcksPendentes.Remove(LdwMessageId);
      finally
        FcsAcks.Leave;
      end;
    end;
    LobjEventoAck.Free;
  end;
end;

initialization
  FcsLog := TCriticalSection.Create;

finalization
  FcsLog.Free;

end.
