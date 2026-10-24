unit untTefEstacaoRoteadorMensagens;

(* Roteador de mensagens do servico Windows da estacao (Req. 456190).

  Recebe pelo socket TCP loopback local (untTefEstacaoTcpTransporte,
  alimentado diretamente pelo plugin cliente DVC - ver historico da
  migracao no cabecalho daquela unit) o mesmo envelope RPC definido em
  untTefCitelDvc.pas (lado AUTCOM), na direcao inversa:
    chamada       (AUTCOM -> estacao) - resolve/instancia a ITefCitel REAL
                  (TTefCitelNCR/TTefCitel) via fCriarTefCitel compartilhada
                  (sem duplicar a decisao Scope/SiTef), invoca o metodo
                  pedido, devolve o resultado.
    hook_resposta (AUTCOM -> estacao) - resposta a um "hook" sincrono
                  enviado por este roteador.

  E envia:
    resposta - resultado do metodo pedido em "chamada" (campos ok/erro/result
               no topo do envelope, nao aninhados em "dados").
    evento   - repasse de ISubjectTEFCitel.AtualizaTefCitel (Observer local
               registrado na instancia real).
    hook     - pedido sincrono ao AUTCOM quando a instancia real precisa de
               um callback Antes*/Depois*/SucessoTefCartao ou grava um erro
               (GravaLogErr). Se o AUTCOM nao responder a tempo (pipe/canal
               indisponivel), assume um default seguro (continuar) e deixa a
               transacao terminar sozinha na estacao - RF07.

  untTefCitelNCR.pas/untTefCitel.pas (a logica de negocio real, incluindo
  Banrisul e o laco de polling local) nao sofrem NENHUMA alteracao - so
  passam a rodar aqui dentro do servico em vez de dentro do autcom.exe.

  RF07/RN03: resultado de metodo de transacao (fPassarCartao,
  fCancelaTransacaoTerminal, fReimpressao) que nao pode ser entregue de
  imediato (pipe desconectado) e persistido em untTefEstacaoFilaLocal e
  reenviado ao reconectar, com o MESMO "id" da chamada original - funciona
  enquanto o TTefCitelDvc do lado AUTCOM ainda estiver com aquela chamada
  pendente (ver comentario em pReenviaFilaLocal sobre o limite dessa
  garantia). *)

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, System.SyncObjs, System.JSON,
  System.Generics.Collections, System.Types, System.IOUtils, System.NetEncoding,
  untInterfaceTefCitel, untTefCitelComum, untTefCitelAtuComum,
  untTefCitelIntervalos,
  untTefEstacaoTcpTransporte, untTefEstacaoFilaLocal, untTefEstacaoLog,
  untTefEstacaoAtualizacao;

const
  { Tempo maximo esperando o AUTCOM responder um "hook" antes de assumir um
    default seguro e deixar a transacao seguir sozinha na estacao (RF07). }
  TEF_ESTACAO_TIMEOUT_HOOK_MS = 30000;
  { Quanto tempo uma sessao DESANEXADA (RF24) espera o mesmo processo
    voltar antes de ser orfanada por idade (Req. 456190, item 2 do Passo 8
    da Fase 5). Passado o prazo, ela entra no caminho normal de
    orfanamento e a RF28 a coleta quando a estacao ficar ociosa.

    30 minutos e uma escolha por ORDEM DE GRANDEZA, nao por medicao: uma
    oscilacao de TS foi medida em 47-53 s do inicio da queda ao "reata"
    completo (10/09, 10:45), duas ordens de grandeza abaixo - qualquer
    reconexao real reata muito antes. E um operador que fecha o autcom e
    reabre em menos de meia hora ganha o reatamento de graca, que e o
    proposito da RF24. Nao ha custo em errar para o lado do prazo maior:
    o unico efeito de uma desanexada de pe e memoria.

    NAO e timeout sobre chamada de pinpad - nao viola a regra do topo de
    IA\rules\tef-dvc.md. E prazo de retencao de um objeto de sessao, sem
    nenhuma transacao em curso por definicao (desanexada = sem conexao). }
  TEF_ESTACAO_DESANEXADA_MAX_MS = 30 * 60 * 1000;

{ Teto da espera pelos despachos em voo na PARADA do servico (Req. 456190,
  achado de campo 2026-09-11 09:21:41 - ver pParaComSeguranca).

  Nao e timeout sobre tempo de pinpad, e nao viola a regra do topo de
  IA\rules\tef-dvc.md: o servico esta PARANDO, a transacao em voo acabou de
  receber o pSair de aborto, e passado o teto nos seguimos com o teardown de
  qualquer forma - ninguem fica esperando pinpad. E o oposto: hoje nao se
  espera NADA e o descarregamento da DLL atropela a thread de despacho.

  10 s por dois motivos: a coleta abortada pelo pSair devolve em ~2 s
  (medido em campo nos abortos por queda de conexao), e o Windows da ~30 s
  para um servico parar antes de matar o processo - 10 s deixa folga de
  sobra para o resto do teardown. }
  TEF_ESTACAO_PARADA_TETO_MS = 10 * 1000;

{ Log de diagnostico do servico da estacao (Req. 456190) - grava ao lado do
  proprio .exe (ver implementacao). Exposta na interface para uso tambem em
  untTefEstacaoServiceMain.pas (ex.: marcar Start/Stop do servico), nao so
  no roteador. }
procedure pLogaEstacao(const AstrMsg: String);

type
  ETefEstacaoRoteador = class(Exception);
  { Recusa por posse do pinpad (RF17 itens 1 e 2). Classe separada porque
    pTrataChamada a responde de um jeito diferente das demais: nao e erro de
    aplicacao, e uma negativa de negocio, e chega no operador como tal. }
  ETefEstacaoPinpadOcupado = class(ETefEstacaoRoteador);
  { Este autcom precisa refazer o login do TEF (RF29, Req. 456190, item 3
    do Passo 8 da Fase 5). Classe separada por um motivo so: o autcom
    precisa RECONHECER esta recusa para refazer o login sozinho, e
    reconhecer por texto de mensagem seria fragil. pTrataChamada a responde
    com motivo="loginNecessario" no envelope, mesmo mecanismo ja usado pela
    recusa contestavel.

    Quando acontece: o servico reiniciou (processo novo, FdictSessoes vazio,
    FstrConfigAplicada em branco) e o canal DVC continuou de pe, porque o
    plugin reconecta o socket sem tocar no canal - o autcom nao teve como
    saber que estava falando com outra instancia. A mensagem acionavel
    continua sendo a mesma de antes, para o caso de o autcom nao tratar o
    motivo (versao antiga da DLL contra servico novo). }
  ETefEstacaoLoginNecessario = class(ETefEstacaoRoteador);
  { Recusa CONTESTAVEL (Req. 456190, RF27/RN16, Passo 6). Diferente da de
    cima: aqui o detentor NAO provou estar vivo - ou a sonda de vivacidade
    ficou muda, ou ele nem tem conexao aberta para ser sondado.

    A estacao nao decide sozinha o que fazer com isso (RN15/RN16): ela
    devolve os fatos ao autcom requisitante - qual pid detem, com que
    identidade de processo, e se havia conexao viva - e e o requisitante que
    verifica o processo (ele roda no MESMO servidor e tem OpenProcess) e,
    se o processo existir, pergunta ao operador. So entao ele volta com
    "disputaPinpad" no contexto e a tomada acontece.

    Nenhum caminho daqui mata processo alheio, e um detentor que RESPONDE a
    sonda nunca chega nesta classe - ele levanta ETefEstacaoPinpadOcupado, que
    o requisitante nao tem como contestar. }
  ETefEstacaoPinpadContestavel = class(ETefEstacaoRoteador)
  public
    FdwPidDetentor: DWORD;
    FstrInicioProcessoDetentor: String;
    FstrTerminalDetentor: String;
    FblnConexaoVivaDetentor: Boolean;
  end;

  TTefEstacaoRoteador = class; // forward - usado por TTefEstacaoObserver

  { Uma sessao = UM autcom.exe, identificado pelo PID que vem no
    "contexto" (Req. 456190, Fase 3.5, Passo 5). Cada uma tem sua propria
    ITefCitel real.

    Motivo de existir: com uma instancia unica compartilhada, o login do
    segundo autcom.exe sobrescrevia loja/filial/PDV do primeiro
    (fConfiguraTefCitel grava esses campos mesmo com
    blnSomenteCarregarLib=True - o if so protege o AbreSessaoTEF), e
    AddInfo/pSetDadosAdicionaisTefTra de um contaminavam a transacao do
    outro. Ver IA\specs\456190\specs.md, secao 9.2 (P2).

    ATENCAO - o que isto NAO isola: a configuracao efetiva do Scope vive em
    variaveis GLOBAIS DE UNIT (untScopeNCR.pas, secao interface: FstrEmpresa,
    FstrFilial, FstrPdv, FintComPort, FintSinc) e, nas duas modalidades, na
    propria DLL de terceiro - ou seja, e uma so por processo do servico.
    Instancias separadas isolam o estado de OBJETO (observers, retorno, log,
    recCartao, dados adicionais, hooks, flags de transacao); a reaplicacao da
    configuracao na troca de PID e assunto do Passo 6. }
  TTefEstacaoSessaoAutcom = class
  public
    FdwPid: DWORD;
    { Identidade da instancia do processo do autcom (Req. 456190, RF23,
      Fase 5) - "contexto.inicioProcesso". O pid sozinho deixou de bastar
      quando a sessao passou a sobreviver a queda de conexao (RF24): sem
      isto, um autcom.exe novo que caisse no mesmo numero de pid herdaria
      esta sessao, com a loja/terminal de outra empresa. Vazio = autcom
      anterior a esta versao (compatibilidade para tras). }
    FstrInicioProcesso: String;
    FTefCitel: ITefCitel;
    FstrOpcao: String;
    FstrPath: String;

    { Argumentos do ultimo fConfiguraTefCitel deste autcom, guardados para
      REAPLICAR quando outro PID tiver reconfigurado a DLL no meio
      (Req. 456190, Passo 6). Confirmado em campo em 2026-09-04: a
      transacao do autcom do terminal 003 saiu registrada no terminal 004,
      porque o login do outro autcom sobrescreveu a configuracao global. }
    FblnCfgRecebida: Boolean;
    { O fConfiguraTefCitel NATIVO ja rodou para ESTA sessao? (Req. 456190,
      achado em campo por Rafael em 2026-09-09, 17:28 - erro 64004.)

      Nao confundir com FblnCfgRecebida, que significa apenas "recebi os
      argumentos do login". Quando o login e ADIADO (RF17 item 4, outro
      autcom com o pinpad), os argumentos ficam guardados mas a DLL nao e
      chamada - e a instancia ITefCitel desta sessao continua sem o estado
      que o fConfiguraTefCitel monta nela.

      Ate aqui a reaplicacao dependia so da impressao digital, e ela e
      IGUAL entre dois autcom da mesma empresa e mesmo terminal (ver
      fImpressaoDigitalConfig). Resultado: com dois autcom do terminal 003,
      o login adiado do segundo NUNCA era aplicado, e o primeiro
      fPassarCartao dele voltava com erro 64004 do Scope em ~140 ms, sem
      chegar ao pinpad. }
    FblnCfgAplicadaNaInstancia: Boolean;
    FstrCfgEnderecoIp: String;
    FstrCfgCodigoLoja: String;
    FstrCfgNumTerminal: String;
    FstrCfgParametrosAdicionais: String;
    FintCfgConfigResultado: Integer;
    FblnCfgSomenteCarregarLib: Boolean;

    { Transacao concluida sem fFinalizarTransacao correspondente (RN06,
      segunda metade). No Passo 6 so alimenta log; o orfanamento que ela
      dispara entra no Passo 7. }
    FblnTransacaoPendenteConfirmacao: Boolean;

    { Conexao por onde este autcom fala AGORA (Req. 456190, RF24/RF26, Passo
      3). Preenchida no "reata" e em pAtualizaContexto; zerada quando ELA
      cai. Existe porque, com a sessao sobrevivendo a queda (RF24), a conexao
      capturada no despacho de um metodo pode estar morta quando a resposta
      finalmente sai: foi o que aconteceu em campo em 2026-09-09 as 10:43:20,
      quando a resposta foi para a fila local mesmo havendo con=6 viva do
      mesmo pid. Quem envia resolve o destino na HORA DO ENVIO por aqui, e
      nao pelo parametro capturado. }
    FConexaoAtual: TTefEstacaoConexao;
    { Momento em que esta sessao DESANEXOU (Req. 456190, item 2 do Passo 8
      da Fase 5). 0 = anexada, ou nunca desanexou. Alimenta
      fOrfanaDesanexadasVencidas.

      GetTickCount de 32 bits, o mesmo idioma do resto desta unit; a
      subtracao de DWORD trata a volta do contador sozinha. Se o
      GetTickCount devolver exatamente 0 (uma vez a cada 49 dias de
      uptime), grava 1 - o valor 0 esta reservado para "anexada". }
    FdwTickDesanexada: DWORD;

    { Disputa do pinpad declarada por ESTE autcom no contexto da chamada
      (Req. 456190, RF27/RN15/RN16, Passo 6).

      FblnSuportaDisputa distingue autcom que entende o fluxo de disputa de
      autcom anterior a esta versao - o servico e a libTefCitel.dll sao
      implantados separadamente, entao a versao de um nao garante a do outro.
      Quem nao suporta continua recebendo a recusa seca de sempre.

      Os demais campos sao o VEREDITO do requisitante sobre o detentor, e
      valem uma vez so: pAtualizaContexto reescreve todos a cada chamada, e
      uma chamada sem "disputaPinpad" no contexto os zera. Sem isso um "sim"
      do operador ficaria valendo para sempre, e a tomada seguinte
      aconteceria sem ninguem autorizar. }
    FblnSuportaDisputa: Boolean;
    FdwPidDisputa: DWORD;
    FstrInicioProcessoDisputa: String;
    FblnDisputaProcessoMorto: Boolean;
    FblnDisputaConfirmadaPeloOperador: Boolean;

    function fImpressaoDigitalConfig: String;
  end;

  TTefEstacaoObserver = class(TInterfacedObject, IObserverTEFCitel)
  private
    FRoteador: TTefEstacaoRoteador;
  public
    constructor Create(ARoteador: TTefEstacaoRoteador);
    procedure AtualizaTefCitel(Resposta: IRetornoTEFCitel);
  end;

  TTefEstacaoRoteador = class
  private
    FTransporte: TTefEstacaoTcpTransporte;
    FFila: TTefEstacaoFilaLocal;
    { Uma ITefCitel por PID (Req. 456190, Passo 5) - ver TTefEstacaoSessaoAutcom.
      FdictSessoes e protegido por FcsInstancia; FdictSessaoPorThread, por
      FcsThreads (mesmo par de locks ja usado para a conexao por thread). }
    { FdictSessoes NAO possui as sessoes - quem possui e FlstTodasSessoes, e
      so o destrutor libera. Nenhuma ITefCitel pode ser liberada enquanto o
      servico roda (Req. 456190, RN08): os destrutores de TTefCitelNCR e
      TTefCitel anulam os ponteiros GLOBAIS das DLLs de terceiro
      (UnLoadDLLFunctions no primeiro; FreeLibrary + x* := nil no segundo),
      cegando todas as outras instancias vivas. Ver specs.md 9.3. }
    FdictSessoes: TDictionary<DWORD, TTefEstacaoSessaoAutcom>;
    FlstTodasSessoes: TObjectList<TTefEstacaoSessaoAutcom>;
    FdictSessaoPorThread: TDictionary<DWORD, TTefEstacaoSessaoAutcom>;
    { Orfas (Req. 456190, Passo 7 / RF18) - sessoes que sairam do
      FdictSessoes mas continuam VIVAS. Lista sem posse: quem possui
      continua sendo FlstTodasSessoes. So pColetaOrfasSeOcioso libera, e so
      quando nao houver mais nenhuma sessao ativa nem thread de despacho -
      unico instante em que anular os ponteiros globais das DLLs nao cega
      ninguem. }
    FlstOrfas: TList<TTefEstacaoSessaoAutcom>;
    { NAO existe marca de "pendencia abandonada" por PID (RF19 foi reescrita em
      2026-09-04). Um autcom so perde a instancia DESCONECTANDO, e volta com PID
      novo - a marca seria inalcancavel. O criterio de posse do pinpad passou a
      ser "a conexao daquele autcom ainda esta aberta?", e isso o FdictSessoes
      acima ja responde sozinho: sessao no dicionario = autcom vivo, porque
      pOnDesconectado tira de la. }
    FObserverLocal: IObserverTEFCitel;

    FcsHooks: TCriticalSection;
    FdictHooksPendentes: TObjectDictionary<Integer, TObject>;
    FintProximoIdHook: Integer;

    { protege so a criacao/busca de sessao (fGaranteSessao) -
      agora pode ser chamada por mais de uma thread de despacho ao mesmo
      tempo (ver pDespachaChamadaEmThreadPropria). NAO usar para envolver
      chamadas inteiras a metodos da ITefCitel - isso devolveria o
      travamento que a thread-por-chamada corrige. }
    FcsInstancia: TCriticalSection;

    { single-flight especifico para os 3 metodos de TRANSACAO
      (fPassarCartao/fCancelaTransacaoTerminal/fReimpressao) - ver
      pTrataChamada. Esses 3 nao sao idempotentes (repetem uma transacao de
      cartao REAL) e a instancia nativa (untTefCitelNCR/untScopeNCR,
      off-limits) nunca foi desenhada pra ser chamada por duas threads ao
      mesmo tempo (porta serial/pinpad unico). Achado em campo (2026-08-28):
      duplo-clique no AUTCOM despachou dois fPassarCartao concorrentes,
      corrompendo a comunicacao nativa o suficiente pra derrubar a thread de
      leitura do canal DVC do lado autcom. Isso NAO reintroduz a trava que a
      thread-por-chamada corrigiu - metodos rapidos (pInfo21/pInfo30/etc.)
      continuam livres para chegar enquanto uma transacao esta em andamento,
      so uma SEGUNDA chamada de transacao concorrente e rejeitada. }
    FcsTransacao: TCriticalSection;
    FblnTransacaoEmAndamento: Boolean;
    { Quem detem o pinpad neste instante (Req. 456190, Passo 6). Usado por
      pGarantePinpadConfigurado para NAO reconfigurar a DLL debaixo de uma
      transacao de outro autcom. }
    FdwPidTransacaoEmAndamento: DWORD;
    { Id da chamada de transacao em voo (Req. 456190, RF26, Passo 3) - anda
      junto dos dois campos acima e sob o mesmo FcsTransacao. E o que permite
      o "reata" responder "emVoo" para um id que o autcom ainda tem pendente. }
    FintIdTransacaoEmAndamento: Integer;
    { Identidade desta INSTANCIA do servico (Req. 456190, RF29). Vai na
      resposta do "reata": se o autcom ve uma identidade diferente da que
      conhecia, o servico reiniciou e o TEF dele precisa ser refeito - a
      sessao Scope daquela transacao morreu com o processo anterior. }
    FstrInstanciaServico: String;

    { Roteamento de saida por natureza da mensagem (Req. 456190, Fase 3.5,
      Passo 4). Com mais de um autcom.exe conectado ao mesmo servico, nao
      existe mais "a conexao":
        - resposta de RPC volta pela conexao que ORIGINOU a chamada (escopo
          de requisicao; vai por parametro em pEnviaResposta/pEnviaOuEnfileira);
        - evento (Observer) e hook vao pela conexao da THREAD DE DESPACHO
          corrente (fConexaoDeSaida), que e correlacao exata: a instancia
          nativa dispara observer e hooks Antes* DENTRO da chamada, na mesma
          thread criada por pDespachaChamadaEmThreadPropria.
      Sem isso, o evento do pinpad de um AUTCOM apareceria na tela do outro,
      e as respostas colidiriam - cada TTefCitelDvc numera seus ids a partir
      de 1, entao o id=1 de um casaria com o id=1 do outro. }
    FcsThreads: TCriticalSection;
    FdictConexaoPorThread: TDictionary<DWORD, TTefEstacaoConexao>;

    { O pinpad e um so, e a configuracao efetiva dele vive na DLL de
      terceiro - uma por processo do servico (specs.md 9.3). FstrConfigAplicada
      guarda a impressao digital do ULTIMO fConfiguraTefCitel que de fato
      entrou na DLL; pGarantePinpadConfigurado compara com a da sessao que
      vai usar o pinpad e reaplica quando diferem (Req. 456190, Passo 6). }
    FcsPinpad: TCriticalSection;
    FstrConfigAplicada: String;
    FdwPidConfigAplicada: DWORD;

    { Atualizacao de arquivos da estacao (Req. 456190, Fase 6).

      FblnReiniciarAposResposta e consumido no finally da thread anonima de
      pDespachaChamadaEmThreadPropria, e NAO dentro do fAtuAplica, por duas
      razoes de ordem que nao aparecem no diff:

        1. a resposta ao autcom precisa SAIR antes de o SCM parar o servico,
           e quem envia e pTrataChamada, depois de fDespachaMetodo retornar;
        2. pParaComSeguranca espera FdictConexaoPorThread chegar a zero, e
           esta thread so sai do dicionario no finally daquela thread -
           disparar antes faria o servico esperar por si mesmo ate o teto. }
    FAtualizacao: TTefEstacaoAtualizacao;
    FblnReiniciarAposResposta: Boolean;

    { transporte - os callbacks recebem a conexao de origem desde o
      Req. 456190/Fase 3.5 (uma conexao por autcom.exe). No Passo 2 o
      roteador ainda ignora o parametro; ele passa a ser usado no Passo 4,
      quando resposta/evento/hook deixam de sair sempre pela mesma conexao. }
    procedure pOnFrameRecebido(AConexao: TTefEstacaoConexao; const AbytFrame: TBytes);
    procedure pDespachaChamadaEmThreadPropria(AConexao: TTefEstacaoConexao; AJson: TJSONObject);
    procedure pOnDesconectado(AConexao: TTefEstacaoConexao);
    { Passo 8 (RF21): chamado de pAtualizaContexto, no momento em que o PID
      da conexao fica conhecido - nao mais do callback de conexao aceita,
      onde ele ainda e desconhecido e a fila saia inteira para quem
      chegasse primeiro. }
    procedure pReenviaFilaLocal(AConexao: TTefEstacaoConexao);
    function fConexaoDeSaida: TTefEstacaoConexao;
    function fMetodoUsaPinpad(const AstrMetodo: String): Boolean;
    function fMetodoDispensaTefCitel(const AstrMetodo: String): Boolean;
    { As tres condicoes de ociosidade da RN21, todas ja existentes e ja
      exercitadas em campo. AstrMotivo sai preenchido quando False e vai
      tanto para o log quanto para a resposta do fAtuAplica - o autcom
      registra o motivo e segue a carga. }
    function fEstacaoOciosa(out AstrMotivo: String): Boolean;
    { Os cinco metodos da Fase 6. Nenhum toca o pinpad e nenhum e metodo de
      transacao - ver os comentarios de fMetodoUsaPinpad e fMetodoDeTransacao. }
    function fMetodoFAtuConsulta(ADados: TJSONObject): TJSONObject;
    function fMetodoPAtuAbre(ADados: TJSONObject): TJSONObject;
    procedure pMetodoPAtuParte(ADados: TJSONObject);
    function fMetodoFAtuFecha(ADados: TJSONObject): TJSONObject;
    function fMetodoFAtuAplica(ADados: TJSONObject): TJSONObject;
    { Os tres metodos que o operador dispara de fato e que competem pelo
      single-flight de pTrataChamada. Virou funcao no Passo 6 porque a disputa
      do pinpad (RF27) tambem precisa do criterio: so eles tem como expressar
      "negado" num retorno vazio, e so eles justificam incomodar o operador. }
    function fMetodoDeTransacao(const AstrMetodo: String): Boolean;
    procedure pGarantePinpadConfigurado(ASessao: TTefEstacaoSessaoAutcom; const AstrMetodo: String);
    procedure pOrfanaSessao(ASessao: TTefEstacaoSessaoAutcom; const AstrMotivo: String);
    function fSessaoVivaComPendencia(const AdwPidAtual: DWORD): TTefEstacaoSessaoAutcom;
    procedure pRecusaSePendenciaDeAutcomVivo(ASessao: TTefEstacaoSessaoAutcom;
      const AstrMetodo: String);
    { Disputa do pinpad (Req. 456190, RF27/RN15/RN16, Passo 6). }
    function fTomadaAutorizada(ASessaoRequisitante,
      ASessaoDetentora: TTefEstacaoSessaoAutcom; const AblnConexaoViva: Boolean;
      out AstrPorQue: String): Boolean;
    procedure pResolveDisputaPinpad(ASessaoRequisitante,
      ASessaoDetentora: TTefEstacaoSessaoAutcom; const AstrMetodo: String);
    function fOutroAutcomDetemPinpad(const AdwPidAtual: DWORD;
      out AstrQuem: String): Boolean;
    { Coleta de orfas (RF18/RF28). Duas portas, um nucleo.

      Liberar uma orfa chama o destrutor da instancia nativa, e ele termina em
      UnLoadDLLFunctions (untTefCitelNCR.pas:342), que ANULA os ~25 ponteiros
      globais das DLLs de terceiro (untScopeNCR.pas:784). Nao ha como evitar:
      a chamada esta dentro do destrutor, guardada por FblnDllCarregada, que e
      privado e sem setter, numa unit que nao pode ser alterada (specs.md 9.3).
      E repovoar de fora tambem nao da - os globais moram DENTRO da
      libTefCitel.dll e o roteador esta no .exe; um "uses untScopeNCR" aqui
      daria uma SEGUNDA copia dos globais, e repovoaria a copia errada.

      Por isso a garantia vem da ORDEM, e nao de uma restauracao avulsa:
      fConfiguraTefCitel chama fLoadDLLFunctions INCONDICIONALMENTE
      (untTefCitelNCR.pas:649), antes de qualquer trabalho de sessao. Colando a
      coleta imediatamente antes dele, os ponteiros ficam nulos apenas dentro
      de um trecho onde nenhuma outra thread de despacho existe - e saem
      povoados. }
    function fColetaOrfas(const AblnAntesDeReconfigurar: Boolean;
      const AdwPidChamador: DWORD): Integer;
    { Caminho antigo (pOnDesconectado): exige ociosidade TOTAL, inclusive
      FdictSessoes vazio. Conservador de proposito - ninguem reconfigura
      depois dele. }
    { Orfana as sessoes DESANEXADA que passaram de
      TEF_ESTACAO_DESANEXADA_MAX_MS sem o processo voltar (item 2 do Passo 8
      da Fase 5). Devolve quantas orfanou. Nao destroi nada - quem destroi
      continua sendo o fColetaOrfas, no ocioso. }
    function fOrfanaDesanexadasVencidas: Integer;
    procedure pColetaOrfasSeOcioso;
    { Parada ordenada: aborta a transacao em voo e espera as threads de
      despacho sairem da DLL nativa antes de o teardown descarrega-la. }
    procedure pParaComSeguranca;
    { RF28: chamada colada antes do fConfiguraTefCitel nativo. Dispensa a
      contagem de sessoes (era ela que fazia a orfa nunca ser coletada quando
      um autcom novo entrava) e ignora a PROPRIA thread na guarda de despacho -
      sem isso a coleta no caminho do login seria um no-op, porque
      pAtualizaContexto registra a thread corrente em FdictSessaoPorThread
      antes de o metodo rodar. }
    procedure pColetaOrfasAntesDeReconfigurar(const AdwPidChamador: DWORD;
      const AstrPorQue: String);
    { RF29 - descarta a fila local herdada de uma instancia anterior do
      servico. Roda no construtor, antes de existir qualquer conexao. }
    procedure pVarreFilaNaSubida;

    { protocolo }
    procedure pTrataChamada(AConexao: TTefEstacaoConexao; AJson: TJSONObject);
    procedure pTrataHookResposta(AJson: TJSONObject);
    procedure pAtualizaContexto(AConexao: TTefEstacaoConexao; AContexto: TJSONObject;
      const AstrMetodo: String);
    { Passo 3 (RF26) - "reata": primeiro frame de cada conexao nova do lado
      autcom, com a identidade dele e os ids que ele ainda tem pendentes. }
    procedure pTrataReata(AConexao: TTefEstacaoConexao; AJson: TJSONObject);
    procedure pDespachaReataEmThreadPropria(AConexao: TTefEstacaoConexao; AJson: TJSONObject);
    { Busca SEM criar: o "reata" nao pode instanciar ITefCitel (seria efeito
      colateral de uma mensagem que so pergunta). Devolve nil se nao ha
      sessao para o par, e ai a resposta e "desconhecido" para todos os ids. }
    function fSessaoDoPid(const AdwPid: DWORD;
      const AstrInicioProcesso: String): TTefEstacaoSessaoAutcom;
    function fGaranteSessao(const AdwPid: DWORD;
      const AstrInicioProcesso, AstrOpcao, AstrPath: String): TTefEstacaoSessaoAutcom;
    function fSessaoDaThread: TTefEstacaoSessaoAutcom;
    function fTefDaThread: ITefCitel;

    procedure pEnviaResposta(AConexao: TTefEstacaoConexao; const AintId: Integer;
      ARespostaResult: TJSONObject; const ABlnPersistirSeFalhar: Boolean);
    procedure pEnviaRespostaErro(AConexao: TTefEstacaoConexao; const AintId: Integer;
      const AstrErro: String; const AstrMotivo: String = '');
    procedure pEnviaRespostaContestavel(AConexao: TTefEstacaoConexao; const AintId: Integer;
      AErro: ETefEstacaoPinpadContestavel);
    procedure pEnviaOuEnfileira(AConexao: TTefEstacaoConexao; AEnvelope: TJSONObject;
      const ABlnPersistirSeFalhar: Boolean);
    procedure pEnviaEvento(ARetorno: IRetornoTEFCitel);
    procedure pEnviaEventoNegado(const AstrMensagem: String);
    function fEnviaHook(const AintId: Integer; const AstrHook: String; ADados: TJSONObject): Boolean;
    function fEnviaHookEAguarda(const AstrHook: String; ADados: TJSONObject): TJSONObject;
    function fPerguntaHookBooleano(const AstrHook: String; ADados: TJSONObject): Boolean;

    { hooks ligados na instancia real - so os "Antes*" (decidem algo que so
      o autcom sabe responder, via round-trip) e GravaLogErr (dado real)
      continuam ligados aqui. Os "Depois*"/SucessoTefCartao foram
      removidos (Req. 456190, 2026-08-31) - ver comentario em
      untTefCitelDvc.pas, pTrataHook/fPassarCartao: o unico payload
      grande/multi-chunk deste protocolo era o DepoisPassarCartao, causa
      da corrupcao de framing investigada nesta sessao, e os callbacks do
      autcom para todos eles ou ja ignoravam o retorno recebido ou eram
      no-op - emulados localmente no lado autcom agora, sem rede. }
    function fHookAntesPassarCartao: Boolean;
    function fHookAntesCancelarTransacao: Boolean;
    function fHookAntesReimpressao: Boolean;
    procedure pHookGravaLogErr(const AblnGravarErro: Boolean; AstrMensagemErro: String;
      AstrRelatorio: String = ''; AstrUltSQL: String = '');

    { despacho de metodos RPC ("chamada") }
    function fDespachaMetodo(const AstrMetodo: String; ADados: TJSONObject): TJSONObject;
    function fMetodoFConfiguraTefCitel(ADados: TJSONObject): TJSONObject;
    function fMetodoFPassarCartao(ADados: TJSONObject): TJSONObject;
    procedure pMetodoFFinalizarTransacao(ADados: TJSONObject);
    function fMetodoFCancelaTransacaoTerminal(ADados: TJSONObject): TJSONObject;
    function fMetodoFReimpressao(ADados: TJSONObject): TJSONObject;
    procedure pMetodoPSair(ADados: TJSONObject);
    procedure pMetodoPInfo34(ADados: TJSONObject);
    procedure pMetodoPInfo21(ADados: TJSONObject);
    procedure pMetodoPInfo30(ADados: TJSONObject);
    function fMetodoFObtemDadoPinPadDireto(ADados: TJSONObject): TJSONObject;
    function fMetodoPRetornaLog(ADados: TJSONObject): TJSONObject;
    function fMetodoFConteudoLogErro(ADados: TJSONObject): TJSONObject;
    procedure pMetodoPInfo30DebitoPreDatado(ADados: TJSONObject);
    procedure pMetodoPInfo30DebitoCredito1Minuto(ADados: TJSONObject);
    procedure pMetodoPInfo30DebitoParcelado(ADados: TJSONObject);
    function fMetodoFVerificaPresencaPinPad(ADados: TJSONObject): TJSONObject;
    function fMetodoFObtemVersao(ADados: TJSONObject): TJSONObject;
    function fMetodoFInfoPixCadastro(ADados: TJSONObject): TJSONObject;
    procedure pMetodoPEnviarQrCode(ADados: TJSONObject);
    procedure pMetodoPLimpaQrCode(ADados: TJSONObject);
    function fMetodoFTraduzirErro(ADados: TJSONObject): TJSONObject;
    function fMetodoFObtemInfoPinPad(ADados: TJSONObject): TJSONObject;
  public
    constructor Create(const AstrDiretorioFila: String);
    destructor Destroy; override;

    { So leitura, e o roteador CONTINUA dono (Req. 456190, Fase 6.1). Existe
      para o TTefEstacaoUpdateListener poder entregar os blocos do canal de
      volume no mesmo objeto que o pAtuParte usa - dois donos de _Preparo
      seria o comeco de duas verdades sobre o mesmo diretorio. }
    property Atualizacao: TTefEstacaoAtualizacao read FAtualizacao;
  end;

implementation

{ fCriarTefCitel carregado via delay-load de libTefCitel.dll - mesma DLL que
  o autcom.exe ja usa em modo classico (CFG_TEFDVC = N), mesmo padrao de
  import ja usado em
  padra_atualizado\fontes\tef\TefCitel\untTefCitelUtil.pas ("external
  'libTefCitel.dll' delayed"). Ate 2026-08-28 este projeto compilava
  untTefCitelNCR/untScopeNCR/untTefCitel/untFuncoesLibTefCitel direto no
  fonte (native business logic + libs do Scope/CliSiTef linkadas
  estaticamente dentro do proprio TefEstacaoService.exe) - trocado por
  decisao do Rafael: "delayed" faz o runtime chamar
  LoadLibrary/GetProcAddress só na PRIMEIRA chamada real, mantendo a DLL
  carregada dali em diante (singleton gerenciado pelo proprio Delphi, sem
  codigo extra aqui) - alinha com o comportamento do autcom.exe (evita o
  custo de carregamento repetido percebido no teste de campo) e prepara
  terreno pra rotina de atualizacao remota de DLL (scope.zip/sitef.zip,
  RF10, ainda a desenhar em sessao futura): trocar o arquivo
  libTefCitel.dll na pasta plana da estacao passa a bastar, sem precisar
  recompilar/redistribuir o TefEstacaoService.exe inteiro. `ShareMem`
  precisou virar a primeira unit de TefEstacaoService.dpr por causa deste
  import (Strings cruzando a fronteira da DLL - mesma exigencia documentada
  no cabecalho de libTefCitel.dpr). }
function fCriarTefCitel(const AstrPath, AstrOpcao: String;
  const AblnUsaDvc: Boolean = False): ITefCitel; stdcall; external 'libTefCitel.dll' delayed;

{ Identidade desta execucao do servico (Req. 456190, RF29). GUID e o
  suficiente: nao precisa ser legivel nem ordenavel, so diferente a cada
  subida do processo. }
function fNovaIdentidadeDeInstancia: String;
var
  LGuid: TGUID;
begin
  if CreateGUID(LGuid) = S_OK then
    Result := GUIDToString(LGuid)
  else
    Result := Format('inst-%d-%d', [GetCurrentProcessId, GetTickCount]);
end;

procedure pLogaEstacao(const AstrMsg: String);
begin
  { Corpo migrado para untTefEstacaoLog em 2026-09-10 (Req. 456190, RF22 -
    Passo 8 da Fase 5). O nome e a assinatura NAO mudaram: as 58 chamadas
    deste arquivo e as de untTefEstacaoServiceMain.pas continuam iguais, e
    todas entram como TEF_LOG_NIVEL_NORMAL - o log em uso normal e
    exatamente o de antes. O que a unit nova acrescenta: nivel
    configuravel por .ini, rotacao por tamanho, carimbo por GetLocalTime
    (sem FormatDateTime) e secao critica. Justificativa completa,
    inclusive de por que o arquivo fica ao lado do .exe e nao em %TEMP%,
    no cabecalho de untTefEstacaoLog.pas.

    Para uma linha de DIAGNOSTICO (so aparece com Nivel=2 no .ini),
    chamar pLogaEstacaoNivel(TEF_LOG_NIVEL_DIAGNOSTICO, ...) direto. }
  pLogaEstacaoNivel(TEF_LOG_NIVEL_NORMAL, AstrMsg);
end;

type
  TTefEstacaoHookPendente = class
  private
    FEvento: TEvent;
    FResposta: TJSONObject;
    FConexao: TTefEstacaoConexao;
  public
    constructor Create;
    destructor Destroy; override;
    property Evento: TEvent read FEvento;
    property Resposta: TJSONObject read FResposta write FResposta;
    { De qual autcom.exe este hook espera resposta (Req. 456190, Fase 3.5).
      Sem isso, a queda de UMA conexao acordava os hooks pendentes de TODAS -
      ver pOnDesconectado. }
    property Conexao: TTefEstacaoConexao read FConexao write FConexao;
  end;

  TDadosAdicionaisTefTraEstacao = class(TInterfacedObject, IDadosAdicionaisTefTra)
  private
    FstrPixS_N: String;
    FstrOpcDoc: String;
    FArrDocs: TArrayInfoTraDoc;
    FstrOpeRcx: String;
    FstrNumDoc: String;
    FfltValor: Double;
    FintOperacao: Integer;
    FstrModalidade: String;
    FintQtdParcelas: Integer;
    FstrStatus: String;
    FstrPrePago: String;
    FstrParcAdm: String;
  public
    function PixS_N(const AstrValor: String): IDadosAdicionaisTefTra ; overload ;
    function PixS_N: String ; overload ;
    function OpcDoc(const AstrValor: String): IDadosAdicionaisTefTra ; overload ;
    function OpcDoc: String ; overload ;
    function ArrDocs(const AarrValor: TArrayInfoTraDoc): IDadosAdicionaisTefTra ; overload ;
    function ArrDocs: TArrayInfoTraDoc ; overload ;
    function OpeRcx(const AstrValor: String): IDadosAdicionaisTefTra ; overload ;
    function OpeRcx: String ; overload ;
    function NumDoc(const AstrValor: String): IDadosAdicionaisTefTra ; overload ;
    function NumDoc: String ; overload ;
    function Valor(const AfltValor: Double): IDadosAdicionaisTefTra ; overload ;
    function Valor: Double ; overload ;
    function Operacao(const AintValor: Integer): IDadosAdicionaisTefTra ; overload ;
    function Operacao: Integer ; overload ;
    function Modalidade(const AstrValor: String): IDadosAdicionaisTefTra ; overload ;
    function Modalidade: String ; overload ;
    function QtdParcelas(const AintValor: Integer): IDadosAdicionaisTefTra ; overload ;
    function QtdParcelas: Integer ; overload ;
    function Status(const AstrValor: String): IDadosAdicionaisTefTra ; overload ;
    function Status: String ; overload ;
    function PrePago(const AstrValor: String): IDadosAdicionaisTefTra ; overload ;
    function PrePago: String ; overload ;
    function ParcAdm(const AstrValor: String): IDadosAdicionaisTefTra ; overload ;
    function ParcAdm: String ; overload ;
  end;

{ Helpers JSON - mesmo protocolo de untTefCitelDvc.pas (lado AUTCOM); GetValue
  (publico) em vez de FindValue (protected em TJSONObject nesta versao do
  Delphi), ambos retornam nil se a chave nao existir. }

function fJsonStr(AObj: TJSONObject; const AName: String; const ADefault: String = ''): String;
var
  LValor: TJSONValue;
begin
  Result := ADefault;
  if not Assigned(AObj) then Exit;
  LValor := AObj.GetValue(AName);
  if Assigned(LValor) and not (LValor is TJSONNull) then
    Result := LValor.Value;
end;

function fJsonBool(AObj: TJSONObject; const AName: String; const ADefault: Boolean = False): Boolean;
var
  LValor: TJSONValue;
begin
  Result := ADefault;
  if not Assigned(AObj) then Exit;
  LValor := AObj.GetValue(AName);
  if Assigned(LValor) and (LValor is TJSONBool) then
    Result := TJSONBool(LValor).AsBoolean;
end;

function fJsonInt(AObj: TJSONObject; const AName: String; const ADefault: Integer = 0): Integer;
var
  LValor: TJSONValue;
begin
  Result := ADefault;
  if not Assigned(AObj) then Exit;
  LValor := AObj.GetValue(AName);
  if Assigned(LValor) and (LValor is TJSONNumber) then
    Result := TJSONNumber(LValor).AsInt;
end;

function fJsonFloat(AObj: TJSONObject; const AName: String; const ADefault: Double = 0): Double;
var
  LValor: TJSONValue;
begin
  Result := ADefault;
  if not Assigned(AObj) then Exit;
  LValor := AObj.GetValue(AName);
  if Assigned(LValor) and (LValor is TJSONNumber) then
    Result := TJSONNumber(LValor).AsDouble;
end;

function fJsonObj(AObj: TJSONObject; const AName: String): TJSONObject;
var
  LValor: TJSONValue;
begin
  Result := nil;
  if not Assigned(AObj) then Exit;
  LValor := AObj.GetValue(AName);
  if Assigned(LValor) and (LValor is TJSONObject) then
    Result := TJSONObject(LValor);
end;

function fJsonArr(AObj: TJSONObject; const AName: String): TJSONArray;
var
  LValor: TJSONValue;
begin
  Result := nil;
  if not Assigned(AObj) then Exit;
  LValor := AObj.GetValue(AName);
  if Assigned(LValor) and (LValor is TJSONArray) then
    Result := TJSONArray(LValor);
end;

function fJsonDeData(const AData: TDate): String;
begin
  if AData = 0 then
    Result := ''
  else
    Result := FormatDateTime('yyyy"-"mm"-"dd', AData);
end;

function fDataDeJsonStr(const AStr: String): TDate;
var
  LintAno, LintMes, LintDia: Integer;
begin
  Result := 0;
  if Length(AStr) < 10 then Exit;
  LintAno := StrToIntDef(Copy(AStr, 1, 4), 0);
  LintMes := StrToIntDef(Copy(AStr, 6, 2), 0);
  LintDia := StrToIntDef(Copy(AStr, 9, 2), 0);
  if (LintAno = 0) or (LintMes = 0) or (LintDia = 0) then Exit;
  Result := EncodeDate(LintAno, LintMes, LintDia);
end;

function fJsonDeHora(const AHora: TTime): String;
begin
  Result := FormatDateTime('hh":"nn":"ss', AHora);
end;

function fHoraDeJsonStr(const AStr: String): TTime;
var
  LintHora, LintMin, LintSeg: Integer;
begin
  Result := 0;
  if Length(AStr) < 8 then Exit;
  LintHora := StrToIntDef(Copy(AStr, 1, 2), 0);
  LintMin  := StrToIntDef(Copy(AStr, 4, 2), 0);
  LintSeg  := StrToIntDef(Copy(AStr, 7, 2), 0);
  Result := EncodeTime(LintHora, LintMin, LintSeg, 0);
end;

function fJsonDeDataHora(const ADataHora: TDateTime): String;
begin
  if ADataHora = 0 then
    Result := ''
  else
    Result := FormatDateTime('yyyy"-"mm"-"dd"T"hh":"nn":"ss', ADataHora);
end;

function fDataHoraDeJsonStr(const AStr: String): TDateTime;
begin
  Result := fDataDeJsonStr(AStr);
  if (Result <> 0) and (Length(AStr) >= 19) then
    Result := Result + fHoraDeJsonStr(Copy(AStr, 12, 8));
end;

function fJsonDeInfoTraDoc(const AInfo: TInfoTraDoc): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('numDoc', AInfo.NumDoc);
  Result.AddPair('dtaTra', fJsonDeDataHora(AInfo.DtaTra));
  Result.AddPair('codEmp', AInfo.CodEmp);
  Result.AddPair('numDup', AInfo.NumDup);
  Result.AddPair('espDoc', AInfo.EspDoc);
  Result.AddPair('parcel', AInfo.Parcel);
  Result.AddPair('empDoc', AInfo.EmpDoc);
end;

function fInfoTraDocDeJson(AJson: TJSONObject): TInfoTraDoc;
begin
  Result.NumDoc := fJsonStr(AJson, 'numDoc');
  Result.DtaTra := fDataHoraDeJsonStr(fJsonStr(AJson, 'dtaTra'));
  Result.CodEmp := fJsonStr(AJson, 'codEmp');
  Result.NumDup := fJsonStr(AJson, 'numDup');
  Result.EspDoc := fJsonStr(AJson, 'espDoc');
  Result.Parcel := fJsonStr(AJson, 'parcel');
  Result.EmpDoc := fJsonStr(AJson, 'empDoc');
end;

function fJsonDeArrayInfoTraDoc(const AArr: TArrayInfoTraDoc): TJSONArray;
var
  I: Integer;
begin
  Result := TJSONArray.Create;
  for I := 0 to Length(AArr) - 1 do
    Result.AddElement(fJsonDeInfoTraDoc(AArr[I]));
end;

function fArrayInfoTraDocDeJson(AJson: TJSONArray): TArrayInfoTraDoc;
var
  I: Integer;
begin
  SetLength(Result, 0);
  if not Assigned(AJson) then Exit;
  SetLength(Result, AJson.Count);
  for I := 0 to AJson.Count - 1 do
    Result[I] := fInfoTraDocDeJson(AJson.Items[I] as TJSONObject);
end;

function fJsonDeDadosAdicionais(ADados: IDadosAdicionaisTefTra): TJSONObject;
begin
  if not Assigned(ADados) then
    Exit(nil);
  Result := TJSONObject.Create;
  Result.AddPair('pixS_N', ADados.PixS_N);
  Result.AddPair('opcDoc', ADados.OpcDoc);
  Result.AddPair('arrDocs', fJsonDeArrayInfoTraDoc(ADados.ArrDocs));
  Result.AddPair('opeRcx', ADados.OpeRcx);
  Result.AddPair('numDoc', ADados.NumDoc);
  Result.AddPair('valor', TJSONNumber.Create(ADados.Valor));
  Result.AddPair('operacao', TJSONNumber.Create(ADados.Operacao));
  Result.AddPair('modalidade', ADados.Modalidade);
  Result.AddPair('qtdParcelas', TJSONNumber.Create(ADados.QtdParcelas));
  Result.AddPair('status', ADados.Status);
  Result.AddPair('prePago', ADados.PrePago);
  Result.AddPair('parcAdm', ADados.ParcAdm);
end;

function fDadosAdicionaisDeJson(AJson: TJSONObject): IDadosAdicionaisTefTra;
var
  LResult: TDadosAdicionaisTefTraEstacao;
begin
  if not Assigned(AJson) then
    Exit(nil);
  LResult := TDadosAdicionaisTefTraEstacao.Create;
  Result := LResult;
  Result.PixS_N(fJsonStr(AJson, 'pixS_N'));
  Result.OpcDoc(fJsonStr(AJson, 'opcDoc'));
  Result.ArrDocs(fArrayInfoTraDocDeJson(fJsonArr(AJson, 'arrDocs')));
  Result.OpeRcx(fJsonStr(AJson, 'opeRcx'));
  Result.NumDoc(fJsonStr(AJson, 'numDoc'));
  Result.Valor(fJsonFloat(AJson, 'valor'));
  Result.Operacao(fJsonInt(AJson, 'operacao'));
  Result.Modalidade(fJsonStr(AJson, 'modalidade'));
  Result.QtdParcelas(fJsonInt(AJson, 'qtdParcelas'));
  Result.Status(fJsonStr(AJson, 'status'));
  Result.PrePago(fJsonStr(AJson, 'prePago'));
  Result.ParcAdm(fJsonStr(AJson, 'parcAdm'));
end;

function fJsonDeIntervalo(AIntervalo: IIntervalo): TJSONObject;
begin
  if not Assigned(AIntervalo) then
    Exit(nil);
  Result := TJSONObject.Create;
  Result.AddPair('inicio', fJsonDeDataHora(AIntervalo.Inicio));
  Result.AddPair('fim', fJsonDeDataHora(AIntervalo.Fim));
  Result.AddPair('tipo', TJSONNumber.Create(Ord(AIntervalo.Tipo)));
end;

function fIntervaloDeJson(AJson: TJSONObject): IIntervalo;
begin
  if not Assigned(AJson) then
    Exit(nil);
  Result := TIntervalo.New;
  Result.Inicio(fDataHoraDeJsonStr(fJsonStr(AJson, 'inicio')));
  Result.Fim(fDataHoraDeJsonStr(fJsonStr(AJson, 'fim')));
  Result.Tipo(TTipoIntervalo(fJsonInt(AJson, 'tipo')));
end;

function fJsonDeIntervalos(AIntervalos: IIntervalosTEF): TJSONObject;
var
  LArr: TJSONArray;
  LIntervalo: IIntervalo;
begin
  if not Assigned(AIntervalos) then
    Exit(nil);
  Result := TJSONObject.Create;
  Result.AddPair('transacao', fJsonDeIntervalo(AIntervalos.Transacao));
  LArr := TJSONArray.Create;
  for LIntervalo in AIntervalos.Espera do
    LArr.AddElement(fJsonDeIntervalo(LIntervalo));
  Result.AddPair('espera', LArr);
end;

function fIntervalosDeJson(AJson: TJSONObject): IIntervalosTEF;
var
  LArr: TJSONArray;
  LTransacao: IIntervalo;
  I: Integer;
begin
  if not Assigned(AJson) then
    Exit(nil);
  Result := TIntervalosTEF.New;
  LTransacao := fIntervaloDeJson(fJsonObj(AJson, 'transacao'));
  if Assigned(LTransacao) then
    Result.Transacao.Inicio(LTransacao.Inicio).Fim(LTransacao.Fim);
  LArr := fJsonArr(AJson, 'espera');
  if Assigned(LArr) then
    for I := 0 to LArr.Count - 1 do
      Result.Espera.Add(fIntervaloDeJson(LArr.Items[I] as TJSONObject));
end;

function fJsonDeDadosCartao(ADados: TDadosCartao): TJSONObject;
var
  LArrCupom: TJSONArray;
  I: Integer;
begin
  Result := TJSONObject.Create;
  LArrCupom := TJSONArray.Create;
  if Assigned(ADados.strCupom) then
    for I := 0 to ADados.strCupom.Count - 1 do
      LArrCupom.AddElement(TJSONString.Create(ADados.strCupom[I]));
  Result.AddPair('strCupom', LArrCupom);
  Result.AddPair('strValor', ADados.strValor);
  Result.AddPair('strBandeira', ADados.strBandeira);
  Result.AddPair('strNomeRede', ADados.strNomeRede);
  Result.AddPair('strAutorizacao', ADados.strAutorizacao);
  Result.AddPair('strNSU', ADados.strNSU);
  Result.AddPair('strTipoTransacao', ADados.strTipoTransacao);
  Result.AddPair('strQuantidadeParcelas', ADados.strQuantidadeParcelas);
  Result.AddPair('strNumeroControle', ADados.strNumeroControle);
  Result.AddPair('strConteudoCupom', ADados.strConteudoCupom);
  Result.AddPair('strConteudoViaCliente', ADados.strConteudoViaCliente);
  Result.AddPair('strConteudoViaLojista', ADados.strConteudoViaLojista);
  Result.AddPair('strDataHoraTrans', ADados.strDataHoraTrans);
  Result.AddPair('blnCancelado', TJSONBool.Create(ADados.blnCancelado));
  Result.AddPair('strChaPix', ADados.strChaPix);
  Result.AddPair('strPixS_N', ADados.strPixS_N);
  Result.AddPair('strCodigoCarteiraDigital', ADados.strCodigoCarteiraDigital);
  Result.AddPair('intPrimeiroVencimento', TJSONNumber.Create(ADados.intPrimeiroVencimento));
  Result.AddPair('intPeriodo', TJSONNumber.Create(ADados.intPeriodo));
  Result.AddPair('strControle', ADados.strControle);
  Result.AddPair('strTipDeb', ADados.strTipDeb);
  Result.AddPair('strCodigoEstabeleci', ADados.strCodigoEstabeleci);
  Result.AddPair('strPrePago', ADados.strPrePago);
  Result.AddPair('strParcAdm', ADados.strParcAdm);
  Result.AddPair('strModoEntrada', ADados.strModoEntrada);
  Result.AddPair('strTipoOperacao', ADados.strTipoOperacao);
  Result.AddPair('strXIdPix', ADados.strXIdPix);
  Result.AddPair('strCampoReferenciaPix', ADados.strCampoReferenciaPix);
  Result.AddPair('strQrCodePix', ADados.strQrCodePix);
  Result.AddPair('strRequestPagamentoPix', ADados.strRequestPagamentoPix);
  Result.AddPair('strResponsePagamentoPix', ADados.strResponsePagamentoPix);
  Result.AddPair('strDadosPagamentoPix', ADados.strDadosPagamentoPix);
  Result.AddPair('strResponseDevolucaoPix', ADados.strResponseDevolucaoPix);
end;

procedure pPreencheDadosCartaoComJson(ADados: TDadosCartao; AJson: TJSONObject);
var
  LArrCupom: TJSONArray;
  LstrTipDeb: String;
  I: Integer;
begin
  if not Assigned(AJson) then Exit;
  LArrCupom := fJsonArr(AJson, 'strCupom');
  if Assigned(LArrCupom) then
  begin
    if not Assigned(ADados.strCupom) then
      ADados.strCupom := TStringList.Create;
    ADados.strCupom.Clear;
    for I := 0 to LArrCupom.Count - 1 do
      ADados.strCupom.Add(LArrCupom.Items[I].Value);
  end;
  ADados.strValor                 := fJsonStr(AJson, 'strValor');
  ADados.strBandeira              := fJsonStr(AJson, 'strBandeira');
  ADados.strNomeRede              := fJsonStr(AJson, 'strNomeRede');
  ADados.strAutorizacao           := fJsonStr(AJson, 'strAutorizacao');
  ADados.strNSU                   := fJsonStr(AJson, 'strNSU');
  ADados.strTipoTransacao         := fJsonStr(AJson, 'strTipoTransacao');
  ADados.strQuantidadeParcelas    := fJsonStr(AJson, 'strQuantidadeParcelas');
  ADados.strNumeroControle        := fJsonStr(AJson, 'strNumeroControle');
  ADados.strConteudoCupom         := fJsonStr(AJson, 'strConteudoCupom');
  ADados.strConteudoViaCliente    := fJsonStr(AJson, 'strConteudoViaCliente');
  ADados.strConteudoViaLojista    := fJsonStr(AJson, 'strConteudoViaLojista');
  ADados.strDataHoraTrans         := fJsonStr(AJson, 'strDataHoraTrans');
  ADados.blnCancelado             := fJsonBool(AJson, 'blnCancelado');
  ADados.strChaPix                := fJsonStr(AJson, 'strChaPix');
  ADados.strPixS_N                := fJsonStr(AJson, 'strPixS_N');
  ADados.strCodigoCarteiraDigital := fJsonStr(AJson, 'strCodigoCarteiraDigital');
  ADados.intPrimeiroVencimento    := fJsonInt(AJson, 'intPrimeiroVencimento');
  ADados.intPeriodo               := fJsonInt(AJson, 'intPeriodo');
  ADados.strControle              := fJsonStr(AJson, 'strControle');
  LstrTipDeb := fJsonStr(AJson, 'strTipDeb');
  if Length(LstrTipDeb) > 0 then
    ADados.strTipDeb := LstrTipDeb[1]
  else
    ADados.strTipDeb := #0;
  ADados.strCodigoEstabeleci      := fJsonStr(AJson, 'strCodigoEstabeleci');
  ADados.strPrePago               := fJsonStr(AJson, 'strPrePago');
  ADados.strParcAdm               := fJsonStr(AJson, 'strParcAdm');
  ADados.strModoEntrada           := fJsonStr(AJson, 'strModoEntrada');
  ADados.strTipoOperacao          := fJsonStr(AJson, 'strTipoOperacao');
  ADados.strXIdPix                := fJsonStr(AJson, 'strXIdPix');
  ADados.strCampoReferenciaPix    := fJsonStr(AJson, 'strCampoReferenciaPix');
  ADados.strQrCodePix             := fJsonStr(AJson, 'strQrCodePix');
  ADados.strRequestPagamentoPix   := fJsonStr(AJson, 'strRequestPagamentoPix');
  ADados.strResponsePagamentoPix  := fJsonStr(AJson, 'strResponsePagamentoPix');
  ADados.strDadosPagamentoPix     := fJsonStr(AJson, 'strDadosPagamentoPix');
  ADados.strResponseDevolucaoPix  := fJsonStr(AJson, 'strResponseDevolucaoPix');
end;

function fJsonDeIRetornoTEFCitel(ARetorno: IRetornoTEFCitel): TJSONObject;
var
  LArrCupom: TJSONArray;
  LObjStatus: TJSONObject;
  I: Integer;
begin
  if not Assigned(ARetorno) then
    Exit(nil);
  Result := TJSONObject.Create;
  LArrCupom := TJSONArray.Create;
  if Assigned(ARetorno.Cupom) then
    for I := 0 to ARetorno.Cupom.Count - 1 do
      LArrCupom.AddElement(TJSONString.Create(ARetorno.Cupom[I]));
  Result.AddPair('cupom', LArrCupom);
  Result.AddPair('dadosCartao', fJsonDeDadosCartao(ARetorno.DadosCartao));

  LObjStatus := TJSONObject.Create;
  LObjStatus.AddPair('strStatus', ARetorno.StatusTEF.strStatus);
  LObjStatus.AddPair('strMensagem', ARetorno.StatusTEF.strMensagem);
  Result.AddPair('statusTEF', LObjStatus);

  Result.AddPair('dadosAdicionaisTefTra', fJsonDeDadosAdicionais(ARetorno.DadosAdicionaisTefTra));
  Result.AddPair('intervalos', fJsonDeIntervalos(ARetorno.Intervalos));
end;

function fIRetornoTEFCitelDeJson(AJson: TJSONObject): IRetornoTEFCitel;
var
  LResult: TRetornoTEFCitel;
  LArrCupom: TJSONArray;
  LObjStatus: TJSONObject;
  I: Integer;
begin
  if not Assigned(AJson) then
    Exit(nil);

  LResult := TRetornoTEFCitel.Create;
  Result := LResult;

  LArrCupom := fJsonArr(AJson, 'cupom');
  if Assigned(LArrCupom) then
    for I := 0 to LArrCupom.Count - 1 do
      Result.Cupom.Add(LArrCupom.Items[I].Value);

  pPreencheDadosCartaoComJson(Result.DadosCartao, fJsonObj(AJson, 'dadosCartao'));

  LObjStatus := fJsonObj(AJson, 'statusTEF');
  if Assigned(LObjStatus) then
  begin
    Result.StatusTEF.strStatus := fJsonStr(LObjStatus, 'strStatus');
    Result.StatusTEF.strMensagem := fJsonStr(LObjStatus, 'strMensagem');
  end;

  Result.DadosAdicionaisTefTra(fDadosAdicionaisDeJson(fJsonObj(AJson, 'dadosAdicionaisTefTra')));
  Result.Intervalos(fIntervalosDeJson(fJsonObj(AJson, 'intervalos')));
end;

{ TTefEstacaoHookPendente }

constructor TTefEstacaoHookPendente.Create;
begin
  inherited Create;
  FEvento := TEvent.Create(nil, True, False, '');
end;

destructor TTefEstacaoHookPendente.Destroy;
begin
  FResposta.Free;
  FEvento.Free;
  inherited;
end;

{ TDadosAdicionaisTefTraEstacao }

function TDadosAdicionaisTefTraEstacao.PixS_N(const AstrValor: String): IDadosAdicionaisTefTra;
begin FstrPixS_N := AstrValor; Result := Self; end;
function TDadosAdicionaisTefTraEstacao.PixS_N: String;
begin Result := FstrPixS_N; end;
function TDadosAdicionaisTefTraEstacao.OpcDoc(const AstrValor: String): IDadosAdicionaisTefTra;
begin FstrOpcDoc := AstrValor; Result := Self; end;
function TDadosAdicionaisTefTraEstacao.OpcDoc: String;
begin Result := FstrOpcDoc; end;
function TDadosAdicionaisTefTraEstacao.ArrDocs(const AarrValor: TArrayInfoTraDoc): IDadosAdicionaisTefTra;
begin FArrDocs := AarrValor; Result := Self; end;
function TDadosAdicionaisTefTraEstacao.ArrDocs: TArrayInfoTraDoc;
begin Result := FArrDocs; end;
function TDadosAdicionaisTefTraEstacao.OpeRcx(const AstrValor: String): IDadosAdicionaisTefTra;
begin FstrOpeRcx := AstrValor; Result := Self; end;
function TDadosAdicionaisTefTraEstacao.OpeRcx: String;
begin Result := FstrOpeRcx; end;
function TDadosAdicionaisTefTraEstacao.NumDoc(const AstrValor: String): IDadosAdicionaisTefTra;
begin FstrNumDoc := AstrValor; Result := Self; end;
function TDadosAdicionaisTefTraEstacao.NumDoc: String;
begin Result := FstrNumDoc; end;
function TDadosAdicionaisTefTraEstacao.Valor(const AfltValor: Double): IDadosAdicionaisTefTra;
begin FfltValor := AfltValor; Result := Self; end;
function TDadosAdicionaisTefTraEstacao.Valor: Double;
begin Result := FfltValor; end;
function TDadosAdicionaisTefTraEstacao.Operacao(const AintValor: Integer): IDadosAdicionaisTefTra;
begin FintOperacao := AintValor; Result := Self; end;
function TDadosAdicionaisTefTraEstacao.Operacao: Integer;
begin Result := FintOperacao; end;
function TDadosAdicionaisTefTraEstacao.Modalidade(const AstrValor: String): IDadosAdicionaisTefTra;
begin FstrModalidade := AstrValor; Result := Self; end;
function TDadosAdicionaisTefTraEstacao.Modalidade: String;
begin Result := FstrModalidade; end;
function TDadosAdicionaisTefTraEstacao.QtdParcelas(const AintValor: Integer): IDadosAdicionaisTefTra;
begin FintQtdParcelas := AintValor; Result := Self; end;
function TDadosAdicionaisTefTraEstacao.QtdParcelas: Integer;
begin Result := FintQtdParcelas; end;
function TDadosAdicionaisTefTraEstacao.Status(const AstrValor: String): IDadosAdicionaisTefTra;
begin FstrStatus := AstrValor; Result := Self; end;
function TDadosAdicionaisTefTraEstacao.Status: String;
begin Result := FstrStatus; end;
function TDadosAdicionaisTefTraEstacao.PrePago(const AstrValor: String): IDadosAdicionaisTefTra;
begin FstrPrePago := AstrValor; Result := Self; end;
function TDadosAdicionaisTefTraEstacao.PrePago: String;
begin Result := FstrPrePago; end;
function TDadosAdicionaisTefTraEstacao.ParcAdm(const AstrValor: String): IDadosAdicionaisTefTra;
begin FstrParcAdm := AstrValor; Result := Self; end;
function TDadosAdicionaisTefTraEstacao.ParcAdm: String;
begin Result := FstrParcAdm; end;

{ TTefEstacaoObserver }

constructor TTefEstacaoObserver.Create(ARoteador: TTefEstacaoRoteador);
begin
  inherited Create;
  FRoteador := ARoteador;
end;

procedure TTefEstacaoObserver.AtualizaTefCitel(Resposta: IRetornoTEFCitel);
begin
  if Assigned(FRoteador) then
    FRoteador.pEnviaEvento(Resposta);
end;

{ TTefEstacaoSessaoAutcom }

function TTefEstacaoSessaoAutcom.fImpressaoDigitalConfig: String;
begin
  { O que define a configuracao EFETIVA do TEF na DLL (Req. 456190, RF20).
    configResultado e somenteCarregarLib ficam de fora de proposito: nao
    mudam qual loja/terminal/porta esta configurada, so o que a chamada faz
    alem de gravar isso. Dois autcom da MESMA empresa e MESMO terminal
    produzem a mesma impressao digital - e ai a reaplicacao e pulada. }
  Result := FstrOpcao + '|' + FstrPath + '|' + FstrCfgEnderecoIp + '|' +
    FstrCfgCodigoLoja + '|' + FstrCfgNumTerminal + '|' + FstrCfgParametrosAdicionais;
end;

{ TTefEstacaoRoteador }

constructor TTefEstacaoRoteador.Create(const AstrDiretorioFila: String);
begin
  inherited Create;
  FcsHooks := TCriticalSection.Create;
  FdictHooksPendentes := TObjectDictionary<Integer, TObject>.Create([doOwnsValues]);
  FintProximoIdHook := 0;
  FcsInstancia := TCriticalSection.Create;
  FcsTransacao := TCriticalSection.Create;
  FblnTransacaoEmAndamento := False;
  FintIdTransacaoEmAndamento := 0;
  FstrInstanciaServico := fNovaIdentidadeDeInstancia;
  FcsThreads := TCriticalSection.Create;
  FdictConexaoPorThread := TDictionary<DWORD, TTefEstacaoConexao>.Create;
  FcsPinpad := TCriticalSection.Create;
  FstrConfigAplicada := '';
  FdwPidConfigAplicada := 0;
  FAtualizacao := TTefEstacaoAtualizacao.Create(ExtractFilePath(ParamStr(0)));
  FblnReiniciarAposResposta := False;
  FdictSessoes := TDictionary<DWORD, TTefEstacaoSessaoAutcom>.Create;   // nao possui
  FlstTodasSessoes := TObjectList<TTefEstacaoSessaoAutcom>.Create(True); // dono unico
  FdictSessaoPorThread := TDictionary<DWORD, TTefEstacaoSessaoAutcom>.Create;
  FlstOrfas := TList<TTefEstacaoSessaoAutcom>.Create;              // nao possui
  FFila := TTefEstacaoFilaLocal.Create(AstrDiretorioFila);
  pVarreFilaNaSubida;
  FObserverLocal := TTefEstacaoObserver.Create(Self);

  FTransporte := TTefEstacaoTcpTransporte.Create;
  FTransporte.OnFrameRecebido := pOnFrameRecebido;
  { OnConectado fica sem handler de proposito (Passo 8, RF21): a unica coisa
    que o roteador fazia no accept() era esvaziar a fila local, e ali o PID
    do autcom.exe ainda e desconhecido. O reenvio passou para
    pAtualizaContexto; o log do accept em si e do transporte. }
  FTransporte.OnDesconectado := pOnDesconectado;
end;

{ PARADA ORDENADA (Req. 456190, achado de campo 2026-09-11 09:21:41).

  O Destroy descarrega a DLL nativa em FlstTodasSessoes.Free - cada
  ITefCitel liberada roda o UnLoadDLLFunctions, que ANULA os ponteiros
  globais das funcoes do Scope (untScopeNCR.pas). Ate aqui isso acontecia
  sem olhar se alguma thread de despacho ainda estava DENTRO da DLL, e em
  campo deu exatamente nisso:

    09:21:41.464  pOnDesconectado: o pid=163036 caiu com a chamada id=21 EM VOO
    09:21:41.468  ServiceStop concluido.
    09:21:41.468  Metodo "fPassarCartao" (id=21) lancou excecao: Access violation
                  at address 00000000 ... Read of address 00000000

  E corrida, nao certeza: na outra parada com chamada em voo (09:25:44,
  id=31) o processo saiu antes de a thread acordar e nao houve AV. Mesma
  classe do AV de 2026-09-09 (ponteiro nulo depois do unload, causa raiz
  completa em pColetaOrfasSeOcioso), gatilho novo: a parada do servico.

  Ordem escolhida, e o porque de cada passo:

  1. ABORTA a transacao em voo primeiro. Sem isso a espera abaixo duraria o
     tempo do pinpad inteiro. Usa o mesmo pSair(True) do pOnDesconectado -
     ver o veredito completo sobre por que isso e seguro (nao chama
     FechaSessaoTEF, so levanta a flag lida durante a coleta) e a ressalva
     pre-existente da string compartilhada.

  2. ESPERA as threads deixarem pTrataChamada, com teto. O indicador exato
     e FdictConexaoPorThread: pOnFrameRecebido registra a thread ANTES de
     despachar e baixa num finally, entao Count = quantos despachos estao
     dentro da DLL agora.

  3. Roda ANTES de FTransporte.Free de proposito. Com o transporte de pe a
     thread que termina ainda consegue ENTREGAR a resposta ao autcom (ou
     persistir na fila local, que so e liberada no fim do Destroy). Esperar
     depois do Free daria o mesmo resultado do bug: a resposta sairia por
     cima de um transporte ja destruido.

  Janela conhecida e aceita: durante a espera o listener ainda aceita, e uma
  chamada nova pode entrar. O teto limita o estrago, e o caso e improvavel
  (parar o servico no mesmo instante de uma chamada nova). Se o Count nao
  chegar a zero, a linha de log abaixo e o aviso de que o AV pode acontecer
  nesta parada - e ai a causa esta identificada em vez de ser um AV solto. }
procedure TTefEstacaoRoteador.pParaComSeguranca;
var
  LSessao: TTefEstacaoSessaoAutcom;
  LblnAbortar: Boolean;
  LintIdEmVoo: Integer;
  LdwPidEmVoo: DWORD;
  LdwInicio: DWORD;
  LintEmVoo: Integer;
begin
  FcsTransacao.Enter;
  try
    LblnAbortar := FblnTransacaoEmAndamento;
    LintIdEmVoo := FintIdTransacaoEmAndamento;
    LdwPidEmVoo := FdwPidTransacaoEmAndamento;
  finally
    FcsTransacao.Leave;
  end;

  LSessao := nil;
  if LblnAbortar and (LdwPidEmVoo <> 0) then
  begin
    FcsInstancia.Enter;
    try
      FdictSessoes.TryGetValue(LdwPidEmVoo, LSessao);
    finally
      FcsInstancia.Leave;
    end;
  end;

  if LblnAbortar and Assigned(LSessao) and Assigned(LSessao.FTefCitel) then
  begin
    pLogaEstacao(Format(
      'pParaComSeguranca: o servico esta parando com a chamada id=%d do pid=%d EM VOO no ' +
      'pinpad - ABORTANDO pelo pSair antes do teardown, pelo mesmo caminho do aborto por ' +
      'queda de conexao. A transacao volta sem retorno e fica pendente no servidor do TEF ' +
      'se o cartao ja tinha sido autorizado (RN09).',
      [LintIdEmVoo, LdwPidEmVoo]));
    try
      LSessao.FTefCitel.pSair(True);
    except
      on E: Exception do
        pLogaEstacao(Format(
          'pParaComSeguranca: pSair de aborto falhou para o pid=%d - %s: %s. Seguindo para a ' +
          'espera de qualquer forma.', [LdwPidEmVoo, E.ClassName, E.Message]));
    end;
  end;

  LdwInicio := GetTickCount;
  repeat
    FcsThreads.Enter;
    try
      LintEmVoo := FdictConexaoPorThread.Count;
    finally
      FcsThreads.Leave;  { fora do lock para dormir - a thread que termina precisa dele }
    end;
    if LintEmVoo = 0 then
      Break;
    Sleep(50);
  until GetTickCount - LdwInicio > TEF_ESTACAO_PARADA_TETO_MS;

  { "Seguro CHAMAR o UnLoadDLLFunctions", e nao "seguro descarregar" - a
    frase antiga prometia mais do que acontece. O UnLoadDLLFunctions anula
    os ponteiros, mas NAO devolve as referencias que o FunctionDetect toma
    (untScopeNCR.pas: LoadLibrary sem FreeLibrary, uma por ponteiro), entao
    scopeapi.dll e a arvore de dependencias dela ficam mapeadas ate o
    processo sair. Quem precisa que elas saiam de verdade - o
    TefEstacaoAtualizador.exe, para poder sobrescrever os arquivos - espera
    o processo, nao esta linha. Residuo registrado no record.md do 456190
    (bateria de 2026-09-16, csmsg.dll). }
  if LintEmVoo = 0 then
    pLogaEstacao(Format(
      'pParaComSeguranca: nenhum despacho em voo depois de %d ms - seguro chamar o ' +
      'UnLoadDLLFunctions. (Os arquivos da DLL seguem mapeados ate o processo sair.)',
      [GetTickCount - LdwInicio]))
  else
    pLogaEstacao(Format(
      'pParaComSeguranca: ATENCAO - %d despacho(s) ainda dentro da DLL nativa depois de %d ms ' +
      '(teto %d ms). Seguindo com o teardown: o UnLoadDLLFunctions vai anular os ponteiros ' +
      'debaixo dessa(s) thread(s) e um Access violation em 00000000 pode aparecer logo abaixo ' +
      '- se aparecer, a causa e esta linha, nao um AV solto.',
      [LintEmVoo, GetTickCount - LdwInicio, TEF_ESTACAO_PARADA_TETO_MS]));
end;

destructor TTefEstacaoRoteador.Destroy;
begin
  { Antes de tudo: nada aqui pode descarregar a DLL nativa com uma thread de
    despacho dentro dela (achado de campo 2026-09-11, comentario completo em
    pParaComSeguranca). }
  pParaComSeguranca;
  FTransporte.Free;
  FdictSessaoPorThread.Free;
  FlstOrfas.Free;        // nao possui as sessoes
  FdictSessoes.Free;     // nao possui as sessoes
  FlstTodasSessoes.Free; // so aqui cada ITefCitel e de fato liberada
  FdictHooksPendentes.Free;
  FcsHooks.Free;
  FcsInstancia.Free;
  FcsTransacao.Free;
  FdictConexaoPorThread.Free;
  FcsThreads.Free;
  FcsPinpad.Free;
  FFila.Free;
  FAtualizacao.Free;
  inherited;
end;

{ transporte }

procedure TTefEstacaoRoteador.pOnFrameRecebido(AConexao: TTefEstacaoConexao;
  const AbytFrame: TBytes);
var
  LstrJson: String;
  LJson: TJSONObject;
  LstrTipo: String;
begin
  LstrJson := TEncoding.UTF8.GetString(AbytFrame);
  LJson := TJSONObject.ParseJSONValue(LstrJson) as TJSONObject;
  if not Assigned(LJson) then
  begin
    pLogaEstacao('Frame recebido pelo pipe nao e JSON valido - descartado.');
    Exit; // frame corrompido/nao-JSON - descartado
  end;

  try
    LstrTipo := fJsonStr(LJson, 'tipo');
    if LstrTipo = 'chamada' then
    begin
      pLogaEstacao(Format('Frame "chamada" recebido: metodo="%s".', [fJsonStr(LJson, 'metodo')]));
      pDespachaChamadaEmThreadPropria(AConexao, LJson.Clone as TJSONObject);
    end
    else if LstrTipo = 'hook_resposta' then
      pTrataHookResposta(LJson)
    else if LstrTipo = 'reata' then
      { Em thread propria, pelo MESMO motivo que "chamada" (ver
        pDespachaChamadaEmThreadPropria): pTrataReata escreve no socket -
        a resposta do reata e a drenagem da fila - e o pEnviaFrame espera o
        ACK, que so pode ser recebido por ESTA thread de leitura. Tratar
        aqui seria espera circular, a mesma ja documentada em pTrataEvento e
        pTrataHook do lado autcom. "hook_resposta" pode ficar inline porque
        nao escreve nada. }
      pDespachaReataEmThreadPropria(AConexao, LJson.Clone as TJSONObject);
  finally
    LJson.Free;
  end;
end;

procedure TTefEstacaoRoteador.pDespachaChamadaEmThreadPropria(AConexao: TTefEstacaoConexao;
  AJson: TJSONObject);
var
  LThread: TThread;
begin
  { Bug de campo confirmado em 2026-08-28 (ver tasks.md): pTrataChamada
    despachava direto aqui, na mesma thread de leitura do socket
    (untTefEstacaoTcpTransporte.pLoopServidor). fPassarCartao/etc. bloqueiam
    essa thread por minutos esperando o pinpad - enquanto isso, qualquer
    "chamada" seguinte (ex.: pInfo21/pInfo30, que a Modalidade Dinamica
    precisa mandar ENQUANTO fPassarCartao ainda esta rodando) fica presa no
    buffer do socket, nunca lida, ate a chamada anterior terminar.

    Corrigido despachando toda "chamada" em thread propria, fogo-e-esquece -
    decisao do Rafael (2026-08-28): despachar TODA chamada (nao so as 3 de
    transacao), mais simples, e a UI so dispara uma chamada por vez em
    condicoes normais. Isso expoe a ITefCitel a acesso concorrente real de
    mais de uma thread (algo que untTefCitelNCR/untTefCitel - off-limits,
    nao alteraveis - nunca foram desenhados para: so toleravam reentrancia
    dentro da MESMA thread, via bombeamento de mensagens, no modelo
    classico). Risco aceito conscientemente por decisao do Rafael; nao
    reintroduzir um lock global em volta da ITefCitel sem antes reler
    esta nota - um lock cobrindo TODA chamada devolveria exatamente o
    travamento que este fix corrige (pInfo21 esperaria fPassarCartao
    terminar do mesmo jeito). }
  LThread := TThread.CreateAnonymousThread(
    procedure
    var
      LdwThread: DWORD;
      LstrErroAtualizador: String;
    begin
      { Registra thread -> conexao ANTES de despachar: e por este mapa que
        pEnviaEvento/pEnviaHook descobrem para qual autcom.exe mandar
        (Req. 456190, Passo 4). Baixa no finally, sempre. }
      LdwThread := GetCurrentThreadId;
      FcsThreads.Enter;
      try
        FdictConexaoPorThread.AddOrSetValue(LdwThread, AConexao);
      finally
        FcsThreads.Leave;
      end;
      try
        pTrataChamada(AConexao, AJson);
      finally
        FcsThreads.Enter;
        try
          FdictConexaoPorThread.Remove(LdwThread);
          FdictSessaoPorThread.Remove(LdwThread);
        finally
          FcsThreads.Leave;
        end;
        AJson.Free;

        { Req. 456190, Fase 6, Passo 3 - o gatilho do reinicio mora AQUI, e
          nao dentro do fAtuAplica, por duas razoes de ordem:

            1. pTrataChamada ja terminou, entao a resposta ao autcom ja saiu
               e ja foi confirmada pelo ACK do transporte;
            2. esta thread ja saiu do FdictConexaoPorThread, logo acima. O
               pParaComSeguranca que o ServiceStop dispara espera esse
               dicionario chegar a zero - com o gatilho la dentro, o servico
               esperaria por si mesmo ate estourar o teto de 10 s.

          Uma leitura de boolean por chamada despachada e o preco, e ele e
          menor que qualquer alternativa com temporizador. }
        if FblnReiniciarAposResposta then
        begin
          FblnReiniciarAposResposta := False;
          FAtualizacao.fDisparaAtualizador(LstrErroAtualizador);
        end;
      end;
    end);
  LThread.FreeOnTerminate := True;
  LThread.Start;
end;

procedure TTefEstacaoRoteador.pOnDesconectado(AConexao: TTefEstacaoConexao);
var
  LObj: TObject;
  LintAcordados, LintMantidos: Integer;
  LSessao: TTefEstacaoSessaoAutcom;
  LblnAbortarEmVoo: Boolean;
  LintIdEmVoo: Integer;
begin
  { Libera os hooks que estavam esperando resposta DESTA conexao - sem
    "Resposta" atribuida, fEnviaHookEAguarda/fPerguntaHookBooleano tratam isso
    como default seguro (continuar), igual a um timeout. A transacao real
    continua rodando sozinha (RF07).

    O filtro por conexao e o ponto (Req. 456190, achado em campo por Rafael em
    2026-09-04, com dois autcom.exe): antes acordava TODOS os pendentes, de
    todos os autcom. Fechar o AUTCOM B com o AUTCOM A no meio de uma transacao
    acordava o AntesPassarCartao do A com Resposta=nil, e o default seguro
    (fJsonBool(nil,'ok',True) = True) deixava a transacao do A seguir como se
    ele tivesse autorizado - sem ter respondido, e sem rastro no log. }
  LintAcordados := 0;
  LintMantidos := 0;
  FcsHooks.Enter;
  try
    for LObj in FdictHooksPendentes.Values do
      if TTefEstacaoHookPendente(LObj).Conexao = AConexao then
      begin
        TTefEstacaoHookPendente(LObj).Evento.SetEvent;
        Inc(LintAcordados);
      end
      else
        Inc(LintMantidos);
  finally
    FcsHooks.Leave;
  end;

  { Sempre registra, mesmo com 0/0 (Req. 456190, 2026-09-04): a janela em que
    existe hook pendente e de dezenas de milissegundos por transacao - todos
    os hooks sao "Antes*", disparados no inicio da operacao, nao enquanto o
    pinpad espera o cartao. Sem a linha incondicional, o filtro por conexao
    fica invisivel no log e ninguem consegue confirmar que ele esta ativo. }
  pLogaEstacao(Format(
    'pOnDesconectado: conexao con=%d (pid=%d) caiu - %d hook(s) dela liberados com default seguro, ' +
    '%d hook(s) de outros autcom mantidos aguardando.',
    [AConexao.intIdConexao, AConexao.dwPid, LintAcordados, LintMantidos]));

  { A sessao NAO sai mais do dicionario aqui (Req. 456190, RF24, Fase 5).

    O texto que estava neste lugar justificava o orfanamento assim: "do lado
    autcom NAO existe reconexao... um autcom que volta chega como conexao
    NOVA e refaz o fConfiguraTefCitel do login". Essa premissa morreu com o
    laco de reconexao do untTefCitelDvcTransporte (RF25): o autcom volta com
    o MESMO processo, o mesmo objTefCitel e sem refazer login nenhum - ele
    nem soube que a sessao TS caiu.

    Provado em campo em 2026-09-09: a conexao caiu as 09:57:29, a sessao foi
    orfanada e coletada no mesmo milissegundo, o plugin reconectou as
    09:58:04 e o "fPassarCartao" das 09:58:46 chegou sem login numa DLL com
    os ponteiros descarregados. Da primeira vez isso foi um Access violation
    em 00000000; depois da correcao de contabilidade no pColetaOrfasSeOcioso
    virou uma recusa com mensagem - mas o TEF continuava inutilizavel ate o
    operador sair e entrar na rotina. O conserto do FLUXO e este: a sessao
    fica.

    Ela apenas DESANEXA - continua em FdictSessoes, sem conexao associada,
    preservando a ITefCitel viva, a digital de configuracao (FstrCfg*) e a
    marca de pendencia. Quando o mesmo processo volta, fGaranteSessao reata
    pela identidade (RF23) e nao ha login, nem reconfiguracao, nem
    ponteiro descarregado.

    O orfanamento continua existindo, com outros gatilhos: identidade
    diferente no mesmo pid (o autcom morreu de verdade - ver fGaranteSessao)
    e, desde o Passo 6, a TOMADA DO PINPAD por outro autcom quando o detentor
    nao responde a sonda de vivacidade (RF27, pResolveDisputaPinpad) - que e
    o que impede um autcom TRAVADO de segurar a sessao para sempre. }
  LSessao := nil;
  if AConexao.dwPid <> 0 then
  begin
    FcsInstancia.Enter;
    try
      FdictSessoes.TryGetValue(AConexao.dwPid, LSessao);
    finally
      FcsInstancia.Leave;
    end;
  end;

  { ABORTO DA TRANSACAO EM VOO (Req. 456190, Fase 5, decisao do Rafael em
    2026-09-09). Se o autcom que caiu tinha transacao em voo, a estacao
    manda parar - o operador ve a mensagem de canal caido que ele ja ve hoje
    e tenta de novo do zero.

    Por que a ESTACAO e nao o autcom: ela sabe da queda neste instante,
    enquanto o autcom so poderia mandar o pSair depois de o canal voltar -
    23 s na medicao de campo das 11:27. Abortar agora maximiza a chance de a
    flag ser lida antes de a transacao sair da fase de coleta.

    Por que isso e seguro (conferido no nativo em 2026-09-09): pSair NAO
    chama FechaSessaoTEF. Ele so faz FintContinua := -1
    (untTefCitelNCR.pas), e essa flag e lida num callback que a DLL do Scope
    consulta ENQUANTO COLETA - o comentario do proprio codigo diz "pega a
    tecla 9 da aplicacao". Ou seja: equivale ao operador apertar cancelar no
    pinpad, pelo caminho nativo normal. Nao confirma nem desfaz nada por
    conta propria.

    E ha protecao por construcao: o laco so consulta a flag enquanto
    iRet = SCO_TRN_EM_ANDAMENTO. Passada a coleta, a transacao vai para
    autorizacao e a flag NAO e mais lida - o aborto chega tarde e e
    ignorado, e o desfecho fica igual ao de hoje (transacao completa, com o
    autcom tendo registrado TRN CANCEL). Nao existe o risco de abortar uma
    transacao ja autorizada.

    Ressalva conhecida, pre-existente: pSair escreve um campo string
    (FstrMensagemOperadorAguardar) que a thread de despacho pode estar
    lendo. A corrida ja existe hoje, todas as vezes que o operador fecha a
    tela do TEF com transacao em voo - foi exercitada em campo as 11:28:17 e
    funcionou. Chamar daqui e da mesma natureza; nao piora, e sair disso
    exigiria mexer no untTefCitelNCR.pas, que e off-limits (specs.md 9.3). }
  LblnAbortarEmVoo := False;
  LintIdEmVoo := 0;
  if AConexao.dwPid <> 0 then
  begin
    FcsTransacao.Enter;
    try
      LblnAbortarEmVoo := FblnTransacaoEmAndamento and
                          (FdwPidTransacaoEmAndamento = AConexao.dwPid);
      LintIdEmVoo := FintIdTransacaoEmAndamento;
    finally
      FcsTransacao.Leave;
    end;
  end;

  if LblnAbortarEmVoo and Assigned(LSessao) and Assigned(LSessao.FTefCitel) then
  begin
    pLogaEstacao(Format(
      'pOnDesconectado: o pid=%d caiu com a chamada id=%d EM VOO no pinpad - ABORTANDO pelo ' +
      'pSair, para o operador tentar de novo (decisao do Rafael, 2026-09-09). Equivale a tecla ' +
      'de cancelar do pinpad: so levanta a flag que a DLL le enquanto coleta. Se a transacao ja ' +
      'tiver passado da coleta, a flag nao e mais lida e ela termina normalmente.',
      [AConexao.dwPid, LintIdEmVoo]));
    try
      LSessao.FTefCitel.pSair(True);
    except
      on E: Exception do
        pLogaEstacao(Format(
          'pOnDesconectado: pSair de aborto falhou para o pid=%d - %s: %s. A transacao segue o ' +
          'curso dela no pinpad.', [AConexao.dwPid, E.ClassName, E.Message]));
    end;
  end;

  if Assigned(LSessao) and (LSessao.FConexaoAtual = AConexao) then
  begin
    LSessao.FConexaoAtual := nil; // desanexada de fato: sem conexao atual (Passo 3)
    { Item 2 do Passo 8: a partir daqui comeca a contar o prazo da RF24. }
    LSessao.FdwTickDesanexada := GetTickCount;
    if LSessao.FdwTickDesanexada = 0 then
      LSessao.FdwTickDesanexada := 1; // 0 esta reservado para "anexada"
  end;

  if Assigned(LSessao) then
    pLogaEstacao(Format(
      'pOnDesconectado: sessao do pid=%d (terminal="%s") DESANEXADA, nao orfanada (RF24) - ' +
      'a conexao con=%d caiu mas a instancia, a configuracao aplicada e a marca de pendencia ' +
      '(%s) ficam de pe esperando o mesmo processo voltar. %d sessao(oes) no dicionario.',
      [LSessao.FdwPid, LSessao.FstrCfgNumTerminal, AConexao.intIdConexao,
       BoolToStr(LSessao.FblnTransacaoPendenteConfirmacao, True), FdictSessoes.Count]));

  pColetaOrfasSeOcioso;
end;

procedure TTefEstacaoRoteador.pReenviaFilaLocal(AConexao: TTefEstacaoConexao);
var
  LarrItens: TArray<TTefEstacaoItemFila>;
  LItem: TTefEstacaoItemFila;
  LEnvelope: TJSONObject;
  LdtaLimite: TDateTime;
  LintEntregues, LintDeOutro, LintExpirados, LintIlegiveis, LintFalharam: Integer;
begin
  LarrItens := FFila.fListaPendentes;
  if Length(LarrItens) = 0 then
    Exit; // caminho normal - nada a fazer e nada a logar

  { Limite do que ainda vale entregar. A garantia do RF07 so vale enquanto o
    TTefCitelDvc do lado autcom ainda estiver com aquela chamada pendente
    (ver cabecalho desta unit); passado o prazo nao ha mais ninguem
    esperando, e manter o arquivo apenas faz cada passe seguinte reler lixo.
    Nao e timeout sobre o pinpad - a transacao que gerou este resultado ja
    havia terminado quando ele foi gravado (IA\rules\tef-dvc.md).
    TDateTime e medido em dias, dai a divisao por 24 * 60. }
  LdtaLimite := System.SysUtils.Now - (TEF_ESTACAO_FILA_VALIDADE_MINUTOS / (24 * 60));

  LintEntregues := 0;
  LintDeOutro := 0;
  LintExpirados := 0;
  LintIlegiveis := 0;
  LintFalharam := 0;

  for LItem in LarrItens do
  begin
    { Expirado sai independentemente de PID - inclusive item de outro
      autcom.exe, que ninguem mais vem buscar. Item de nome ilegivel chega
      aqui com dtaEnfileirado = 0 e cai neste mesmo ramo. }
    if LItem.dtaEnfileirado < LdtaLimite then
    begin
      FFila.pRemove(LItem.strArquivo);
      Inc(LintExpirados);
      Continue;
    end;

    { O ponto do Passo 8 (RF21): item de outro autcom.exe FICA na fila,
      esperando a conexao do dono. Antes desta versao ele era entregue a
      esta conexao - e o que a fila guarda e resposta de metodo de
      transacao. }
    if LItem.dwPidDestino <> AConexao.dwPid then
    begin
      Inc(LintDeOutro);
      Continue;
    end;

    if not AConexao.blnConectado then
      Break; // caiu de novo no meio do reenvio - o restante fica na fila

    LEnvelope := FFila.fCarregaEnvelope(LItem.strArquivo);
    if not Assigned(LEnvelope) then
    begin
      FFila.pRemove(LItem.strArquivo); // conteudo corrompido - nao ha como reenviar
      Inc(LintIlegiveis);
      Continue;
    end;

    try
      try
        AConexao.pEnviaFrame(TEncoding.UTF8.GetBytes(LEnvelope.ToJSON));
        FFila.pRemove(LItem.strArquivo);
        Inc(LintEntregues);
      except
        // ainda sem conexao de fato (corrida com uma nova queda) - mantem na fila
        Inc(LintFalharam);
      end;
    finally
      LEnvelope.Free;
    end;
  end;

  { Log incondicional quando havia fila (RF22): e a unica evidencia de que o
    filtro por PID esta ativo, e de para quem cada item foi. }
  pLogaEstacao(Format(
    'pReenviaFilaLocal: con=%d (pid=%d) - fila tinha %d item(ns): %d entregue(s), ' +
    '%d de outro autcom mantido(s), %d descartado(s) por expiracao (> %d min) ou ' +
    'nome ilegivel, %d com conteudo corrompido, %d que falharam no envio.',
    [AConexao.intIdConexao, AConexao.dwPid, Length(LarrItens), LintEntregues,
     LintDeOutro, LintExpirados, TEF_ESTACAO_FILA_VALIDADE_MINUTOS, LintIlegiveis,
     LintFalharam]));
end;

{ protocolo }

procedure TTefEstacaoRoteador.pDespachaReataEmThreadPropria(AConexao: TTefEstacaoConexao;
  AJson: TJSONObject);
var
  LThread: TThread;
begin
  LThread := TThread.CreateAnonymousThread(
    procedure
    begin
      try
        pTrataReata(AConexao, AJson);
      except
        on E: Exception do
          pLogaEstacao(Format('pTrataReata falhou: %s: %s.', [E.ClassName, E.Message]));
      end;
      AJson.Free; // o clone e desta thread
    end);
  LThread.FreeOnTerminate := True;
  LThread.Start;
end;

procedure TTefEstacaoRoteador.pTrataReata(AConexao: TTefEstacaoConexao; AJson: TJSONObject);
var
  LObjContexto, LObjDados, LObjResposta: TJSONObject;
  LarrEstados, LarrIdsPedidos: TJSONArray;
  LValorIds: TJSONValue;
  LObjEstado: TJSONObject;
  LEnvelope: TJSONObject;
  LSessao: TTefEstacaoSessaoAutcom;
  LdwPid: DWORD;
  LstrInicio, LstrInstanciaConhecida, LstrEstado: String;
  LstrQualSessao, LstrAvisoInstancia: String;
  LintIdx, LintId, LintEmVoo, LintNaFila, LintDesconhecidos: Integer;
  LarrIdsNaFila: TArray<Integer>;
  LblnAchou: Boolean;
  LintJ: Integer;
begin
  { "reata" (Req. 456190, RF26, Passo 3): primeiro frame de cada conexao nova
    do lado autcom. Ele diz quem e (pid + inicioProcesso), qual instancia do
    servico conhecia, e quais ids de chamada ainda tem pendentes. A estacao
    reata a sessao, responde o estado de cada id e drena a fila local.

    Por que existe: antes disto a estacao so descobria o pid na PRIMEIRA
    CHAMADA depois de reconectar (pAtualizaContexto), e um autcom bloqueado
    esperando resposta nao faz chamada nova - o gatilho nunca disparava. Era
    o furo registrado no Passo 8. Agora a drenagem acontece no accept.

    Nao cria instancia: usa fSessaoDoPid, que so busca. Uma mensagem que
    pergunta nao pode ter efeito colateral de carregar DLL de terceiro. }
  LObjContexto := fJsonObj(AJson, 'contexto');
  LObjDados := fJsonObj(AJson, 'dados');

  LdwPid := DWORD(fJsonInt(LObjContexto, 'pid', 0));
  LstrInicio := fJsonStr(LObjContexto, 'inicioProcesso');
  LstrInstanciaConhecida := fJsonStr(LObjDados, 'instanciaServico');

  AConexao.dwPid := LdwPid;
  LSessao := fSessaoDoPid(LdwPid, LstrInicio);
  if Assigned(LSessao) then
  begin
    LSessao.FConexaoAtual := AConexao;
    LSessao.FdwTickDesanexada := 0; // reatou: para de contar o prazo (item 2 do Passo 8)
  end;

  { Estado de cada id pedido. emVoo: a thread de despacho ainda esta dentro da
    DLL nativa. naFila: o resultado ja existe e esta em disco esperando
    entrega. desconhecido: a estacao nao tem nada com esse id - o autcom pode
    desistir dele na hora, em vez de esperar para sempre. }
  LintEmVoo := 0;
  LintNaFila := 0;
  LintDesconhecidos := 0;
  { A consulta a fila faz I/O e pode levantar - por isso vem ANTES de criar o
    TJSONArray, que nao tem dono ate entrar no LObjResposta. }
  LarrIdsNaFila := FFila.fIdsPendentesDoPid(LdwPid);

  LarrIdsPedidos := nil;
  if Assigned(LObjDados) then
  begin
    LValorIds := LObjDados.GetValue('ids');
    { "is" e nao "as": um frame malformado (versao antiga, cliente estranho)
      levantaria EInvalidCast aqui dentro da cadeia de leitura, e o
      transporte trata excecao nessa cadeia como DESCONEXAO - derrubaria a
      conexao por causa de um campo torto. }
    if (LValorIds <> nil) and (LValorIds is TJSONArray) then
      LarrIdsPedidos := TJSONArray(LValorIds);
  end;

  LarrEstados := TJSONArray.Create;

  if Assigned(LarrIdsPedidos) then
    for LintIdx := 0 to LarrIdsPedidos.Count - 1 do
    begin
      LintId := StrToIntDef(LarrIdsPedidos.Items[LintIdx].Value, -1);
      if LintId < 0 then
        Continue;

      FcsTransacao.Enter;
      try
        LblnAchou := FblnTransacaoEmAndamento and
                     (FdwPidTransacaoEmAndamento = LdwPid) and
                     (FintIdTransacaoEmAndamento = LintId);
      finally
        FcsTransacao.Leave;
      end;

      if LblnAchou then
      begin
        LstrEstado := 'emVoo';
        Inc(LintEmVoo);
      end
      else
      begin
        LblnAchou := False;
        for LintJ := 0 to High(LarrIdsNaFila) do
          if LarrIdsNaFila[LintJ] = LintId then
          begin
            LblnAchou := True;
            Break;
          end;
        if LblnAchou then
        begin
          LstrEstado := 'naFila';
          Inc(LintNaFila);
        end
        else
        begin
          LstrEstado := 'desconhecido';
          Inc(LintDesconhecidos);
        end;
      end;

      LObjEstado := TJSONObject.Create;
      LObjEstado.AddPair('id', TJSONNumber.Create(LintId));
      LObjEstado.AddPair('estado', LstrEstado);
      LarrEstados.AddElement(LObjEstado);
    end;

  if Assigned(LSessao) then
    LstrQualSessao := 'a sessao existente'
  else
    LstrQualSessao := 'SEM sessao na estacao';

  if (LstrInstanciaConhecida <> '') and (LstrInstanciaConhecida <> FstrInstanciaServico) then
    LstrAvisoInstancia := ' - SERVICO REINICIOU desde a ultima conexao deste autcom'
  else
    LstrAvisoInstancia := '';

  pLogaEstacao(Format(
    'pTrataReata: con=%d pid=%d (inicio="%s") reatou %s. Instancia do servico: conhecida pelo ' +
    'autcom="%s", atual="%s"%s. Ids pedidos: %d emVoo, %d naFila, %d desconhecido(s).',
    [AConexao.intIdConexao, LdwPid, LstrInicio, LstrQualSessao,
     LstrInstanciaConhecida, FstrInstanciaServico, LstrAvisoInstancia,
     LintEmVoo, LintNaFila, LintDesconhecidos]));

  { Resposta ANTES da drenagem, de proposito: o autcom precisa saber o estado
    de cada id antes de comecar a receber as respostas guardadas, senao um id
    que sai da fila agora chegaria como "desconhecido" na resposta do reata. }
  LObjResposta := TJSONObject.Create;
  LObjResposta.AddPair('instanciaServico', FstrInstanciaServico);
  LObjResposta.AddPair('estados', LarrEstados); // LObjResposta assume a posse

  LEnvelope := TJSONObject.Create;
  try
    LEnvelope.AddPair('v', TJSONNumber.Create(1));
    LEnvelope.AddPair('id', TJSONNumber.Create(0));
    LEnvelope.AddPair('tipo', 'reata_resposta');
    LEnvelope.AddPair('dados', LObjResposta); // LEnvelope assume a posse
    pEnviaOuEnfileira(AConexao, LEnvelope, False); // reata_resposta nao sobrevive a reconexao
  finally
    LEnvelope.Free;
  end;

  { E agora a fila: com o pid conhecido no accept, a drenagem acontece aqui -
    nao mais na primeira chamada (RF21 revisto). }
  if AConexao.fMarcaFilaLocalReenviada then
  try
    pReenviaFilaLocal(AConexao);
  except
    on E: Exception do
      pLogaEstacao(Format(
        'pTrataReata: pReenviaFilaLocal falhou para con=%d (pid=%d) e foi ignorado - %s: %s.',
        [AConexao.intIdConexao, LdwPid, E.ClassName, E.Message]));
  end;
end;

procedure TTefEstacaoRoteador.pAtualizaContexto(AConexao: TTefEstacaoConexao;
  AContexto: TJSONObject; const AstrMetodo: String);
var
  LstrOpcao, LstrPath: String;
  LObjTefInfo, LObjDadosAdic, LObjDisputa: TJSONObject;
  LdwPid: DWORD;
  LSessao: TTefEstacaoSessaoAutcom;
begin
  if not Assigned(AContexto) then Exit;

  { O pid identifica o autcom.exe de origem (Req. 456190, Passo 5). Todos
    rodam no MESMO servidor, entao o PID e unico entre eles. Um contexto sem
    pid vem de um autcom anterior a esta versao: cai em pid=0, que e uma
    sessao valida como outra qualquer - compatibilidade para tras. }
  LdwPid := DWORD(fJsonInt(AContexto, 'pid', 0));
  AConexao.dwPid := LdwPid; // so pra correlacionar as linhas de log da conexao

  { Aqui - e nao no accept() - e o primeiro momento em que da pra saber de
    quem e a fila local (Passo 8, RF21). Uma vez por conexao: este metodo
    roda em TODA chamada, e varrer o diretorio da fila a cada uma sairia no
    caminho de fPassarCartao. O test-and-set e atomico porque duas threads
    de despacho da MESMA conexao rodam concorrentes (Bug 2, 2026-08-28) e um
    "if not flag then flag := True" entre elas entregaria o mesmo item duas
    vezes - duplicidade de resposta de metodo de transacao, exatamente o que
    a RN03 nao admite. }
  if AConexao.fMarcaFilaLocalReenviada then
  try
    pReenviaFilaLocal(AConexao);
  except
    on E: Exception do
      { A fila local e escrituracao, nao parte do pedido de quem chamou:
        um tropeco no diretorio dela (permissao, disco, arquivo em uso) nao
        pode derrubar a chamada que apenas passou por aqui - menos ainda um
        fPassarCartao. Fica no log e segue. Nao ha nova tentativa: a marca
        de reenvio ja caiu, e a proxima conexao deste PID pega o que
        sobrou. }
      pLogaEstacao(Format(
        'pReenviaFilaLocal: falhou para con=%d (pid=%d) e foi ignorado - %s: %s. ' +
        'Os itens seguem na fila para a proxima conexao deste pid.',
        [AConexao.intIdConexao, LdwPid, E.ClassName, E.Message]));
  end;

  { PARA AQUI nos cinco metodos da Fase 6 (Req. 456190, 2026-09-20). Tudo
    daqui para baixo mexe na sessao, e criar sessao significa carregar o
    libTefCitel.dll por delay-load - que e exatamente o que pode nao existir
    ainda quando estes metodos chegam. Ver fMetodoDispensaTefCitel.

    Sair antes deixa fSessaoDaThread devolvendo nil para eles, e isso e
    seguro: nenhum dos cinco handlers usa sessao nem fTefDaThread, e os usos
    de fSessaoDaThread depois do despacho estao todos dentro de ramos de
    "fPassarCartao"/"fFinalizarTransacao".

    O reenvio da fila local, acima, fica de fora desta saida de proposito:
    ele e por conexao e nao depende de sessao nenhuma. }
  if fMetodoDispensaTefCitel(AstrMetodo) then
  begin
    pLogaEstacao(Format(
      'pAtualizaContexto: "%s" e metodo de atualizacao - seguindo SEM instanciar ' +
      'a ITefCitel (a estacao pode ainda nao ter o libTefCitel.dll).', [AstrMetodo]));
    Exit;
  end;

  LstrOpcao := fJsonStr(AContexto, 'opcao');
  LstrPath := fJsonStr(AContexto, 'path');
  LSessao := fGaranteSessao(LdwPid, fJsonStr(AContexto, 'inicioProcesso'), LstrOpcao, LstrPath);

  { Conexao atual da sessao (Passo 3). Tambem aqui, e nao so no "reata", para
    funcionar com autcom que ainda nao manda "reata" - e para corrigir a
    referencia se ela tiver ficado velha. }
  LSessao.FConexaoAtual := AConexao;
  LSessao.FdwTickDesanexada := 0; // reatou: para de contar o prazo (item 2 do Passo 8)

  { Disputa do pinpad (Req. 456190, RF27, Passo 6). Reescrito a CADA chamada,
    inclusive quando o contexto nao traz "disputaPinpad" - e o que torna o
    veredito do requisitante uma autorizacao de uso unico. Se ficasse
    guardado, um "sim" do operador autorizaria silenciosamente a tomada
    seguinte, que pode ser contra outro detentor e sem ninguem perguntar. }
  LSessao.FblnSuportaDisputa := fJsonBool(AContexto, 'suportaDisputa', False);
  LObjDisputa := fJsonObj(AContexto, 'disputaPinpad');
  if Assigned(LObjDisputa) then
  begin
    LSessao.FdwPidDisputa := DWORD(fJsonInt(LObjDisputa, 'pid', 0));
    LSessao.FstrInicioProcessoDisputa := fJsonStr(LObjDisputa, 'inicioProcesso');
    LSessao.FblnDisputaProcessoMorto := fJsonBool(LObjDisputa, 'morto', False);
    LSessao.FblnDisputaConfirmadaPeloOperador := fJsonBool(LObjDisputa, 'confirmado', False);
    pLogaEstacao(Format(
      'pAtualizaContexto: o pid=%d chegou com VEREDITO de disputa sobre o pid=%d ' +
      '(inicio="%s"): morto=%s, confirmadoPeloOperador=%s.',
      [LdwPid, LSessao.FdwPidDisputa, LSessao.FstrInicioProcessoDisputa,
       BoolToStr(LSessao.FblnDisputaProcessoMorto, True),
       BoolToStr(LSessao.FblnDisputaConfirmadaPeloOperador, True)]));
  end
  else
  begin
    LSessao.FdwPidDisputa := 0;
    LSessao.FstrInicioProcessoDisputa := '';
    LSessao.FblnDisputaProcessoMorto := False;
    LSessao.FblnDisputaConfirmadaPeloOperador := False;
  end;

  { Registra a sessao desta thread de despacho ANTES de qualquer uso de
    fTefDaThread - e por este mapa que os ~22 fMetodo* acham a instancia
    certa sem precisar receber a sessao por parametro. Baixa no finally de
    pDespachaChamadaEmThreadPropria, junto com a conexao. }
  FcsThreads.Enter;
  try
    FdictSessaoPorThread.AddOrSetValue(GetCurrentThreadId, LSessao);
  finally
    FcsThreads.Leave;
  end;

  LObjTefInfo := fJsonObj(AContexto, 'tefInfo');
  if Assigned(LObjTefInfo) then
    LSessao.FTefCitel.AddInfo(
      fJsonStr(LObjTefInfo, 'macAdress'), fJsonStr(LObjTefInfo, 'ipNumber'),
      fJsonStr(LObjTefInfo, 'userName'), fJsonStr(LObjTefInfo, 'computerName'),
      fJsonStr(LObjTefInfo, 'terminalTEF'));

  LObjDadosAdic := fJsonObj(AContexto, 'dadosAdicionaisTefTra');
  LSessao.FTefCitel.pSetDadosAdicionaisTefTra(fDadosAdicionaisDeJson(LObjDadosAdic));
end;

function TTefEstacaoRoteador.fSessaoDaThread: TTefEstacaoSessaoAutcom;
begin
  Result := nil;
  FcsThreads.Enter;
  try
    FdictSessaoPorThread.TryGetValue(GetCurrentThreadId, Result);
  finally
    FcsThreads.Leave;
  end;
end;

function TTefEstacaoRoteador.fTefDaThread: ITefCitel;
var
  LSessao: TTefEstacaoSessaoAutcom;
begin
  { Referencia LOCAL forte, de proposito: quem chama usa o resultado desta
    funcao, entao a ITefCitel fica viva pela duracao da chamada mesmo que a
    sessao saia do dicionario no meio (Req. 456190, RN08). }
  LSessao := fSessaoDaThread;
  if not Assigned(LSessao) then
    raise ETefEstacaoRoteador.Create(
      'Nenhuma sessao de autcom registrada nesta thread - metodo despachado sem contexto?');
  Result := LSessao.FTefCitel;
end;

function TTefEstacaoRoteador.fSessaoDoPid(const AdwPid: DWORD;
  const AstrInicioProcesso: String): TTefEstacaoSessaoAutcom;
begin
  Result := nil;
  FcsInstancia.Enter;
  try
    if not FdictSessoes.TryGetValue(AdwPid, Result) then
      Exit;
    { Identidade diferente = outro processo pegou este numero de pid (RF23).
      Aqui NAO orfana: quem faz isso e fGaranteSessao, no caminho de uma
      chamada de verdade. Uma mensagem que so pergunta nao muda estado. }
    if Result.FstrInicioProcesso <> AstrInicioProcesso then
      Result := nil;
  finally
    FcsInstancia.Leave;
  end;
end;

function TTefEstacaoRoteador.fGaranteSessao(const AdwPid: DWORD;
  const AstrInicioProcesso, AstrOpcao, AstrPath: String): TTefEstacaoSessaoAutcom;
var
  LSessaoAnterior: TTefEstacaoSessaoAutcom;
begin
  { Mais de uma thread de despacho pode chamar isto ao mesmo tempo (ver
    pDespachaChamadaEmThreadPropria) - o lock cobre so a busca/criacao da
    sessao (rapida, uma vez por autcom.exe), nunca uma chamada inteira a
    ITefCitel. }
  FcsInstancia.Enter;
  try
    if FdictSessoes.TryGetValue(AdwPid, LSessaoAnterior) then
    begin
      if LSessaoAnterior.FstrInicioProcesso <> AstrInicioProcesso then
      begin
        { Mesmo pid, processo DIFERENTE (Req. 456190, RF23): o autcom que
          tinha esta sessao morreu de verdade e o Windows reciclou o numero.
          Aqui sim a sessao antiga vai embora - este e o gatilho legitimo do
          orfanamento depois da RF24, que tirou a queda de conexao dessa
          lista. Reaproveita-la entregaria ao processo novo a loja/terminal
          da empresa do processo velho. }
        pOrfanaSessao(LSessaoAnterior, Format(
          'o pid=%d e de outro processo agora (inicio "%s" -> "%s") - o autcom anterior morreu',
          [AdwPid, LSessaoAnterior.FstrInicioProcesso, AstrInicioProcesso]));
      end
      else if LSessaoAnterior.FstrOpcao = AstrOpcao then
      begin
        { REATACAO (RF24). Mesmo processo, mesma opcao: devolve a sessao que
          ele ja tinha, com a ITefCitel viva, a digital de configuracao e a
          marca de pendencia intactas. E isto que faz a oscilacao de TS
          deixar de custar um login - e de cair no ponteiro descarregado. }
        Result := LSessaoAnterior;
        if Result.FstrPath <> AstrPath then
        begin
          Result.FTefCitel.pSetPath(AstrPath);
          Result.FstrPath := AstrPath;
        end;
        Exit;
      end;
    end;

    pLogaEstacao(Format('Instanciando ITefCitel real para o pid=%d (opcao="%s", path="%s")...',
      [AdwPid, AstrOpcao, AstrPath]));
    { fCriarTefCitel sem o 3o parametro (AblnUsaDvc) - aqui e sempre a
      instancia REAL (Scope/NCR ou SiTef Express), nunca TTefCitelDvc. }
    Result := TTefEstacaoSessaoAutcom.Create;
    Result.FdwPid := AdwPid;
    Result.FstrInicioProcesso := AstrInicioProcesso;
    Result.FstrOpcao := AstrOpcao;
    Result.FstrPath := AstrPath;
    Result.FTefCitel := fCriarTefCitel(AstrPath, AstrOpcao);
    if not Assigned(Result.FTefCitel) then
    begin
      Result.Free; // ainda nao entrou em FlstTodasSessoes, e a ITefCitel e nil
      Result := nil;
      pLogaEstacao(Format('fCriarTefCitel devolveu nil para a opcao "%s".', [AstrOpcao]));
      raise ETefEstacaoRoteador.CreateFmt(
        'Nao foi possivel instanciar o ITefCitel real para a opcao "%s".', [AstrOpcao]);
    end;

    { AddOrSetValue e nao Add: o mesmo pid pode ja ter uma sessao com OUTRA
      opcao. A antiga apenas SAI do dicionario - continua viva em
      FlstTodasSessoes ate o servico parar, porque libera-la anularia os
      ponteiros globais das DLLs e cegaria as outras (RN08). }
    FlstTodasSessoes.Add(Result);
    FdictSessoes.AddOrSetValue(AdwPid, Result);
    pLogaEstacao(Format('Instancia ITefCitel real criada para o pid=%d (%d sessao(oes) ativa(s)).',
      [AdwPid, FdictSessoes.Count]));

    { "Depois*"/SucessoTefCartao nao sao mais ligados aqui (Req. 456190,
      2026-08-31) - ver comentario na declaracao destes hooks, acima. A
      classe real (TTefCitelNCR/TTefCitel) ja guarda com Assigned() antes
      de chamar cada hook (ver pDepoisEvento em untTefCitelNCR.pas) -
      deixar sem atribuir e seguro, nenhum comportamento novo precisa ser
      emulado deste lado. }
    Result.FTefCitel.AntesPassarCartao := fHookAntesPassarCartao;
    Result.FTefCitel.AntesCancelarTransacao := fHookAntesCancelarTransacao;
    Result.FTefCitel.AntesReimpressao := fHookAntesReimpressao;
    Result.FTefCitel.pSetLogErr(pHookGravaLogErr);
    { Observer unico compartilhado entre as instancias: o roteamento do evento
      nao vem dele e sim da thread de despacho (fConexaoDeSaida), entao um
      observer por sessao nao acrescentaria precisao nenhuma. }
    Result.FTefCitel.AdicionaObserver(FObserverLocal);
  finally
    FcsInstancia.Leave;
  end;
end;

procedure TTefEstacaoRoteador.pTrataChamada(AConexao: TTefEstacaoConexao; AJson: TJSONObject);
var
  LintId: Integer;
  LstrMetodo: String;
  LObjDados, LObjContexto, LResultado: TJSONObject;
  LblnPersistir, LblnMetodoTransacao, LblnReservou: Boolean;
  LblnCancelaPropria: Boolean;
  LdwPidChamador, LdwPidEmVoo: DWORD;
  LblnOutroPidEmVoo: Boolean;
  LstrQuemDetem: String;
begin
  LintId := fJsonInt(AJson, 'id', -1);
  LstrMetodo := fJsonStr(AJson, 'metodo');
  LObjDados := fJsonObj(AJson, 'dados');
  LObjContexto := fJsonObj(AJson, 'contexto');

  LblnMetodoTransacao := fMetodoDeTransacao(LstrMetodo);
  LblnReservou := False;

  if LblnMetodoTransacao then
  begin
    { Single-flight: ver comentario em FblnTransacaoEmAndamento. So metodos
      de transacao competem por isso - pInfo21/pInfo30/fConfiguraTefCitel/
      etc. nunca passam por aqui, continuam livres pra chegar em paralelo. }
    LblnOutroPidEmVoo := False;
    LdwPidEmVoo := 0;

    FcsTransacao.Enter;
    try
      if FblnTransacaoEmAndamento then
      begin
        LdwPidEmVoo := FdwPidTransacaoEmAndamento;
        LblnOutroPidEmVoo := LdwPidEmVoo <> DWORD(fJsonInt(LObjContexto, 'pid', 0));
      end
      else
      begin
        FblnTransacaoEmAndamento := True;
        FdwPidTransacaoEmAndamento := DWORD(fJsonInt(LObjContexto, 'pid', 0));
        FintIdTransacaoEmAndamento := LintId; // RF26 - o "reata" responde "emVoo" por este id
        LblnReservou := True;
      end;
    finally
      FcsTransacao.Leave;
    end;

    { Em voo do MESMO pid - duplo-clique de verdade. Continua recusado aqui,
      e continua como ERRO: nao e negativa de negocio, e uma chamada que nao
      deveria ter sido feita, e na pratica o operador nem chega a ver (o
      FdictMetodosEmAndamento de fChamaRpcUmaVez, do lado autcom, barra o
      segundo clique antes de virar frame). }
    if (not LblnReservou) and (not LblnOutroPidEmVoo) then
    begin
      pLogaEstacao(Format(
        'Metodo "%s" (id=%d) REJEITADO: o pid=%d ja tem uma chamada de transacao em andamento ' +
        '(duplo-clique no AUTCOM) - repetir fPassarCartao/fCancelaTransacaoTerminal/fReimpressao ' +
        'concorrentemente pode duplicar uma transacao de cartao real.',
        [LstrMetodo, LintId, LdwPidEmVoo]));
      pEnviaRespostaErro(AConexao, LintId,
        'Ja existe uma transacao de cartao em andamento nesta estacao - aguarde a conclusao antes de tentar novamente.');
      Exit;
    end;

    { Em voo de OUTRO pid - NAO responde aqui (Req. 456190, achado em campo
      por Rafael em 2026-09-09, 17:08:36).

      Este ramo respondia com pEnviaRespostaErro, e isso tinha duas
      consequencias ruins. A primeira: resposta com ok=false chega no autcom
      como ETefCitelDvcRpc e o operador ve o dialogo do madExcept com o texto
      cru "Estacao retornou erro em fPassarCartao", em vez de uma mensagem
      que diga o que fazer.

      A segunda e mais sutil: esta guarda SOMBREAVA a RF17 item 1, em
      pGarantePinpadConfigurado, que barra exatamente o mesmo caso - outro pid
      com transacao em voo - e ja responde do jeito certo (evento 500 +
      resposta sem retorno, que na tela e um fMensagem normal do projeto).
      Ela nunca era alcancada porque esta linha vem antes.

      Entao aqui nao se responde nada: deixa seguir. Nada e despachado no
      caminho - pGarantePinpadConfigurado recusa antes de encostar na DLL - e
      o slot do single-flight NAO foi reservado, entao o finally la embaixo
      nao mexe no que pertence a transacao do outro.

      Efeito colateral bem-vindo: o pequeno intervalo entre esta checagem e a
      guarda de posse deixa passar o caso legitimo em que a transacao do
      outro terminou nesse meio tempo.

      Observacao sobre a trava LCKATC (a pergunta do Rafael na mesma bateria):
      ela NAO e consultada neste caminho, e nao ha como ser. Sob DVC a trava
      vive dentro do hook "AntesPassarCartao" (fAntesPassarCartaoEvent,
      untTefCitelUtil.pas), que e a ESTACAO que dispara - se a chamada e
      recusada antes do despacho, o hook nunca sai e o fLockUnlockTefCitel
      nunca roda no autcom que chegou. A ordem se invertou em relacao a
      arquitetura classica, onde o nativo rodava no proprio processo e a trava
      era a primeira coisa a ser consultada. Isso nao e perda de protecao: a
      guarda da estacao e mais forte que a LCKATC, porque a LCKATC e por
      empresa (fRetornaChaveLockTefCitel) e nao alcanca dois autcom de
      empresas diferentes. }
    if LblnOutroPidEmVoo then
      pLogaEstacao(Format(
        'Metodo "%s" (id=%d) do pid=%d chegou com o pid=%d EM VOO no pinpad - seguindo para a ' +
        'guarda de posse (RF17 item 1), que responde como negativa em vez de erro. Nada foi ' +
        'reservado nem despachado.',
        [LstrMetodo, LintId, DWORD(fJsonInt(LObjContexto, 'pid', 0)), LdwPidEmVoo]));
  end;

  try
    try
      { FURO 2 (Req. 456190, 2026-09-04): pSair de um autcom que NAO detem o
        pinpad e respondido como no-op, sem despachar e sem criar instancia.
        Recusar com excecao prenderia o operador na tela do TEF -
        TfrmTefCitelOperacoes.pEncerrar chama ObjTefCitel.pSair(True) sem
        try/except e so faz Self.Close depois. Deixar passar seria pior: pSair
        encerra sessao/pinpad na DLL compartilhada e atropelaria a operacao de
        quem esta com o pinpad. }
      if (LstrMetodo = 'pSair') and
         fOutroAutcomDetemPinpad(DWORD(fJsonInt(LObjContexto, 'pid', 0)), LstrQuemDetem) then
      begin
        pLogaEstacao(Format(
          '"pSair" do pid=%d respondido como no-op: %s. O autcom fecha a tela do TEF ' +
          'normalmente, sem encostar na DLL compartilhada.',
          [DWORD(fJsonInt(LObjContexto, 'pid', 0)), LstrQuemDetem]));
        pEnviaResposta(AConexao, LintId, nil, False);
        Exit; // LblnReservou e False aqui - pSair nao e metodo de transacao
      end;

      { pSair do PROPRIO autcom que esta com transacao EM VOO (Req. 456190,
        achado em campo 2026-09-09 as 10:43:18). O no-op acima nao alcanca
        este caso de proposito: fOutroAutcomDetemPinpad isenta o proprio pid,
        e pSair nao e metodo de transacao, entao o single-flight tambem nao o
        barra. Resultado observado: o pSair encerra a sessao no pinpad e a
        transacao em voo volta "SEM retorno" - ou seja, ele CANCELA a
        transacao do proprio autcom.

        Decisao do Rafael, 2026-09-09: **manter**, tratando como cancelamento
        explicito e deliberado do operador. O pSair vem de
        TfrmTefCitelOperacoes.pEncerrar, que e o operador fechando a tela do
        TEF - barrar prenderia ele ali, e a intencao dele e justamente sair.

        O que FALTAVA era o log: sem esta linha, o arquivo mostra o pSair com
        sucesso e, separado, a transacao voltando sem retorno, sem nada
        ligando um ao outro. Quem for investigar depois "por que esta
        transacao foi cancelada?" precisa achar a causa aqui, nao deduzir
        (RF22). Nao altera comportamento nenhum - so registra. }
      if LstrMetodo = 'pSair' then
      begin
        LdwPidChamador := DWORD(fJsonInt(LObjContexto, 'pid', 0));
        FcsTransacao.Enter;
        try
          LblnCancelaPropria := FblnTransacaoEmAndamento and
                                (FdwPidTransacaoEmAndamento = LdwPidChamador);
        finally
          FcsTransacao.Leave;
        end;

        if LblnCancelaPropria then
          pLogaEstacao(Format(
            '"pSair" do pid=%d recebido com transacao EM VOO do MESMO pid - seguindo como ' +
            'CANCELAMENTO DELIBERADO do operador (decisao do Rafael, 2026-09-09). O pSair ' +
            'encerra a sessao no pinpad, entao a transacao em voo vai voltar sem retorno; se ' +
            'o cartao ja tinha sido autorizado, ela fica pendente no servidor do TEF (RN09). ' +
            'Isto NAO e falha: e o operador fechando a tela do TEF (pEncerrar).',
            [LdwPidChamador]));
      end;

      pAtualizaContexto(AConexao, LObjContexto, LstrMetodo);

      { Antes de tocar o pinpad, garantir que a DLL esta com a configuracao
        DESTE autcom (Req. 456190, Passo 6) e que ninguem mais esta com o
        pinpad ou com pendencia em aberto (Passo 7). }
      if fMetodoUsaPinpad(LstrMetodo) then
        pGarantePinpadConfigurado(fSessaoDaThread, LstrMetodo);

      pLogaEstacao(Format('Despachando metodo "%s" (id=%d)...', [LstrMetodo, LintId]));
      LResultado := fDespachaMetodo(LstrMetodo, LObjDados);
      pLogaEstacao(Format('Metodo "%s" (id=%d) retornou com sucesso.', [LstrMetodo, LintId]));
      try
        { RN06, segunda metade - PENDENCIA SO DO fPassarCartao (revisto duas vezes
          em 2026-09-08; ler as duas revisoes, uma explica a outra).

          1a revisao - deixou de ser pelo NOME do metodo e passou a olhar o
          RETORNO. untTefCitelNCR.pas:1720 inicia Result := Nil e so atribui
          Result := FRetorno quando a transacao deu certo; todo caminho de falha
          devolve nil E ja desfez a sessao com FechaSessaoTEF(SCO_DESFAZ_TEF)
          (:1814 e mais cinco pontos). Motivo: o autcom NAO chama
          fFinalizarTransacao depois de uma negativa, entao a marca ficava presa
          em True e travava o OUTRO autcom pelas RF17 itens 2 e 4.

          2a revisao - fCancelaTransacaoTerminal saiu da marcacao. O criterio
          verdadeiro nao e "devolveu retorno", e sim "devolveu retorno DEIXANDO A
          SESSAO ABERTA". Comparando os tres metodos no nativo:

            fPassarCartao (:1834)             Result := FRetorno, SEM FechaSessaoTEF
                                              -> fica pendente, o autcom confirma
                                                 depois com fFinalizarTransacao
            fCancelaTransacaoTerminal (:576)  FechaSessaoTEF(SCO_CONFIRMA_TEF) e
                                              SO ENTAO Result := FRetorno
                                              -> ja confirmado, nada pendente
            fReimpressao                      idem cancelamento

          E por isso que TfrmTefCitelAdministracao (a tela "Administracao do TEF")
          chama fCancelamentoNormal e nunca chama fFinalizarTransacao: nao ha o
          que confirmar. A unit inteira nao tem uma referencia sequer ao metodo.

          Sem esta 2a revisao, um cancelamento bem-sucedido no autcom A travava o
          autcom B ate o A fechar - visto em campo em 2026-09-08 as 10:33:58, com
          o pid=93852 recusado por causa do pid=118320 que tinha cancelado as
          10:33:39 e nao tinha o que confirmar.

          Resumo: SO o fPassarCartao marca, e so quando devolve retorno. Sem
          retorno a marca nao e tocada - nem posta, nem limpada. Limpar seria o
          lado perigoso, e ha um caso real que depende disso: no fluxo de
          multiplos cartoes o nativo PULA o DESFAZ quando ja havia sessao aberta
          (FblnMultCartoes, :1781 e :1813), justamente porque o cartao ANTERIOR
          continua pendente. }
        if LstrMetodo = 'fPassarCartao' then
        begin
          if Assigned(fJsonObj(LResultado, 'retorno')) then
            fSessaoDaThread.FblnTransacaoPendenteConfirmacao := True
          else
            pLogaEstacao(Format(
              '"fPassarCartao" do pid=%d voltou SEM retorno (negativa, cancelamento ou ' +
              'aborto antes de transacionar) - marca de pendencia NAO alterada, o proprio ' +
              'nativo ja desfez a sessao. Marca continua em %s.',
              [fSessaoDaThread.FdwPid,
               BoolToStr(fSessaoDaThread.FblnTransacaoPendenteConfirmacao, True)]));
        end
        else if LstrMetodo = 'fFinalizarTransacao' then
          fSessaoDaThread.FblnTransacaoPendenteConfirmacao := False;

        LblnPersistir := LblnMetodoTransacao;
        pEnviaResposta(AConexao, LintId, LResultado, LblnPersistir);
      finally
        LResultado.Free;
      end;
    except
      on E: ETefEstacaoPinpadContestavel do
      begin
        { RF27 - nao e desfecho, e meio de caminho: o autcom vai verificar o
          processo do detentor e, se ele existir, perguntar ao operador; se a
          tomada for autorizada, ele repete ESTA MESMA chamada com o veredito
          no contexto. Nada foi executado no pinpad ate aqui - a recusa
          acontece em pGarantePinpadConfigurado, antes de qualquer despacho -
          entao repetir e seguro. }
        pLogaEstacao(Format(
          'Metodo "%s" (id=%d) devolvido como CONTESTAVEL para o pid=%d decidir: %s',
          [LstrMetodo, LintId, AConexao.dwPid, E.Message]));
        pEnviaRespostaContestavel(AConexao, LintId, E);
      end;
      on E: ETefEstacaoPinpadOcupado do
      begin
        { Recusa por posse do pinpad NAO e erro de aplicacao - e uma negativa, e o
          operador precisa ve-la do mesmo jeito que ve uma "NAO AUTORIZADA"
          (pedido do Rafael, 2026-09-04). Sem isto a excecao sobe ate o madExcept
          e vira dialogo de erro com "Salvar o erro em txt" / "Mostrar o relatorio
          do erro", que assusta o operador e nao diz o que fazer.

          Evento 500 primeiro, resposta depois - mesma ordem de uma negativa real,
          e o laco de fChamaRpc drena a fila de notificacoes antes de sair (ver
          untTefCitelDvc.pas, correcao de 2026-09-03). }
        pLogaEstacao(Format(
          'Metodo "%s" (id=%d) RECUSADO por posse do pinpad - respondendo como negativa ' +
          '(evento 500 + resposta sem retorno): %s', [LstrMetodo, LintId, E.Message]));

        if LblnMetodoTransacao then
        begin
          pEnviaEventoNegado(E.Message);
          { Sem "retorno" no resultado: fIRetornoTEFCitelDeJson(nil) devolve nil, o
            fPassarCartao do autcom devolve nil e fPassaCartao marca a TEFTRA como
            TRANSACAO_CANCELADA no finally dele. }
          pEnviaResposta(AConexao, LintId, nil, False);
        end
        else
          { Metodos que nao sao de transacao (pInfo*, fVerificaPresencaPinPad,
            fObtemDadoPinPadDireto...) nao tem como expressar "negado" num retorno
            vazio sem virar resposta errada - seguem como erro. Na pratica o
            operador nao dispara nenhum deles direto. }
          pEnviaRespostaErro(AConexao, LintId, E.Message);
      end;
      on E: ETefEstacaoLoginNecessario do
      begin
        { RF29, item 3 do Passo 8 (2026-09-10). Como a contestavel, nao e
          desfecho: e um pedido para o autcom refazer o proprio login e
          repetir a chamada. Nada foi executado no pinpad - a recusa acontece
          em pGarantePinpadConfigurado, antes de qualquer despacho - entao
          repetir e seguro, pelo mesmo argumento ja escrito no ramo
          contestavel acima. }
        pLogaEstacao(Format(
          'Metodo "%s" (id=%d) recusado por FALTA DE LOGIN do pid=%d - respondendo com ' +
          'motivo="loginNecessario" para ele refazer o fConfiguraTefCitel e repetir: %s',
          [LstrMetodo, LintId, AConexao.dwPid, E.Message]));
        pEnviaRespostaErro(AConexao, LintId, E.Message, 'loginNecessario');
      end;
      on E: Exception do
      begin
        pLogaEstacao(Format('Metodo "%s" (id=%d) lancou excecao: %s', [LstrMetodo, LintId, E.Message]));
        pEnviaRespostaErro(AConexao, LintId, E.Message);
      end;
    end;
  finally
    if LblnReservou then
    begin
      FcsTransacao.Enter;
      try
        FblnTransacaoEmAndamento := False;
        FdwPidTransacaoEmAndamento := 0;
        FintIdTransacaoEmAndamento := 0;
      finally
        FcsTransacao.Leave;
      end;
    end;
  end;
end;

procedure TTefEstacaoRoteador.pTrataHookResposta(AJson: TJSONObject);
var
  LintId: Integer;
  LObj: TObject;
  LDadosResposta: TJSONObject;
begin
  LintId := fJsonInt(AJson, 'id', -1);
  LDadosResposta := fJsonObj(AJson, 'dados');

  FcsHooks.Enter;
  try
    if not FdictHooksPendentes.TryGetValue(LintId, LObj) then
      Exit; // hook desconhecido/ja expirado (default ja foi aplicado) - ignora

    if Assigned(LDadosResposta) then
      TTefEstacaoHookPendente(LObj).Resposta := LDadosResposta.Clone as TJSONObject
    else
    begin
      TTefEstacaoHookPendente(LObj).Resposta := TJSONObject.Create;
      TTefEstacaoHookPendente(LObj).Resposta.AddPair('ok', TJSONBool.Create(True));
    end;
    TTefEstacaoHookPendente(LObj).Evento.SetEvent;
  finally
    FcsHooks.Leave;
  end;
end;

{ envio de envelopes }

function TTefEstacaoRoteador.fConexaoDeSaida: TTefEstacaoConexao;
begin
  { Conexao do autcom.exe que originou a chamada em execucao NESTA thread
    (Req. 456190, Passo 4 - ver comentario em FdictConexaoPorThread).
    nil quando nao ha despacho em curso na thread corrente: quem chama
    trata como "sem destino" (a fila local cobre o que for persistivel).
    A partir do Passo 6 o dono do pinpad entra aqui como fallback. }
  Result := nil;
  FcsThreads.Enter;
  try
    FdictConexaoPorThread.TryGetValue(GetCurrentThreadId, Result);
  finally
    FcsThreads.Leave;
  end;
end;

function TTefEstacaoRoteador.fMetodoUsaPinpad(const AstrMetodo: String): Boolean;
begin
  { Metodos que chegam ao pinpad fisico e que, portanto, dependem da
    configuracao (loja/terminal/porta) certa estar na DLL (Req. 456190,
    RF16). fConfiguraTefCitel NAO entra: ela E a configuracao, e e tratada
    em fMetodoFConfiguraTefCitel.
    Ficam de fora, por nao tocarem o pinpad: fObtemVersao (le versao da
    DLL), fTraduzirErro (tabela estatica), pRetornaLog, fInfoPixCadastro.

    Os dois metodos da ITefCitelV2 caem em lados opostos, e nao ha regra de
    interface que ajude: fTraduzirErro fica fora e fObtemInfoPinPad entra,
    porque este ultimo le o pinpad de verdade (Req. 456497). O criterio e o
    que o metodo FAZ, nunca de qual interface ele veio.

    E os cinco da Fase 6 - fAtuConsulta, pAtuAbre, pAtuParte, fAtuFecha e
    fAtuAplica - que mexem em disco e no SCM, nunca no pinpad. A ausencia
    deles aqui NAO e esquecimento: esta funcao e uma lista de permissao, e
    e justamente por nao estarem nela que pGarantePinpadConfigurado nao e
    chamado para eles. Isso importa porque os cinco rodam ANTES do
    fConfiguraTefCitel, quando a sessao ainda chega com FblnCfgRecebida =
    False, e aquela guarda virou incondicional em 2026-09-11: se um dia
    algum deles entrar nesta lista, a atualizacao para de acontecer e o
    sintoma nao vai apontar para ca. }
  Result :=
    (AstrMetodo = 'fPassarCartao') or
    (AstrMetodo = 'fCancelaTransacaoTerminal') or
    (AstrMetodo = 'fReimpressao') or
    (AstrMetodo = 'fFinalizarTransacao') or
    (AstrMetodo = 'fVerificaPresencaPinPad') or
    (AstrMetodo = 'fObtemDadoPinPadDireto') or
    (AstrMetodo = 'fObtemInfoPinPad') or
    (AstrMetodo = 'pEnviarQrCode') or
    (AstrMetodo = 'pLimpaQrCode') or
    (AstrMetodo = 'pSair') or
    (AstrMetodo = 'pInfo21') or
    (AstrMetodo = 'pInfo30') or
    (AstrMetodo = 'pInfo34') or
    (AstrMetodo = 'pInfo30DebitoPreDatado') or
    (AstrMetodo = 'pInfo30DebitoCredito1Minuto') or
    (AstrMetodo = 'pInfo30DebitoParcelado');
end;

function TTefEstacaoRoteador.fMetodoDispensaTefCitel(const AstrMetodo: String): Boolean;
begin
  { Os cinco metodos da Fase 6 nao tocam a ITefCitel: sao operacao de disco e
    de SCM, servidas pelo FAtualizacao. Esta lista existe para que
    pAtualizaContexto NAO instancie a ITefCitel real por causa deles.

    POR QUE ISSO E OBRIGATORIO, e nao otimizacao (campo, 2026-09-20)

    fCriarTefCitel e "external 'libTefCitel.dll' delayed". Numa estacao
    recem-instalada essa DLL AINDA NAO EXISTE - ela chega justamente pelo
    pacote "libtefcitel", que e o fAtuConsulta que pede. Enquanto a sessao
    era criada antes do despacho, o fAtuConsulta morria com
    "External exception C06D007E" (o codigo que o Delphi levanta quando o
    delay-load nao acha o modulo) ANTES de chegar no proprio handler. A
    estacao ficava num impasse do qual nao saia sozinha: nao tinha a DLL, e
    a unica chamada capaz de traze-la precisava dela.

    O sintoma nao apontava para ca - o AUTCOM mostrava "Nao foi possivel
    falar com o servico de TEF da estacao", e a suspeita natural era o
    atualizador, que nunca chegou a rodar.

    Nao apareceu antes porque ate o instalador da Fase 7 o libTefCitel.dll
    era copiado a mao no preparo da estacao. O instalador foi a primeira
    coisa a criar uma estacao de verdade vazia.

    Mesmo espirito do fSessaoDoPid, que o "reata" usa: mensagem que so
    pergunta nao pode ter como efeito colateral instanciar a DLL nativa.

    Se um dia um metodo novo da atualizacao precisar da ITefCitel, ele NAO
    entra nesta lista - e ai a estacao volta a depender de a DLL ja estar
    la. }
  Result :=
    (AstrMetodo = 'fAtuConsulta') or
    (AstrMetodo = 'pAtuAbre') or
    (AstrMetodo = 'pAtuParte') or
    (AstrMetodo = 'fAtuFecha') or
    (AstrMetodo = 'fAtuAplica');
end;

function TTefEstacaoRoteador.fMetodoDeTransacao(const AstrMetodo: String): Boolean;
begin
  Result := (AstrMetodo = 'fPassarCartao') or
            (AstrMetodo = 'fCancelaTransacaoTerminal') or
            (AstrMetodo = 'fReimpressao');
end;

procedure TTefEstacaoRoteador.pGarantePinpadConfigurado(ASessao: TTefEstacaoSessaoAutcom;
  const AstrMetodo: String);
var
  LstrImpressaoDigital, LstrPorQue: String;
  LintValor: Integer;
  LblnOutroEmVoo: Boolean;
  LdwPidEmVoo: DWORD;
begin
  FcsPinpad.Enter;
  try
    { RF17 item 1 - transacao EM VOO de outro autcom. Vem ANTES da comparacao
      de impressao digital de proposito (Req. 456190, Passo 7): o pinpad e um
      so, entao nenhum outro PID pode encostar nele enquanto uma transacao
      esta correndo - nem quando a configuracao por acaso for identica (mesma
      empresa e mesmo terminal). O single-flight de pTrataChamada so barra os
      3 metodos de transacao; e por esta guarda que pSair,
      fVerificaPresencaPinPad e fObtemDadoPinPadDireto do outro autcom tambem
      ficam de fora. Chamada do PROPRIO pid detentor passa (e o padrao
      status=131 -> pInfo21 da Modalidade Dinamica, que roda dezenas de vezes
      dentro do fPassarCartao dele mesmo). }
    FcsTransacao.Enter;
    try
      LblnOutroEmVoo := FblnTransacaoEmAndamento and
                        (FdwPidTransacaoEmAndamento <> ASessao.FdwPid);
      LdwPidEmVoo := FdwPidTransacaoEmAndamento;
    finally
      FcsTransacao.Leave;
    end;

    if LblnOutroEmVoo then
    begin
      pLogaEstacao(Format(
        'pGarantePinpadConfigurado: "%s" do pid=%d recusado - o pid=%d esta com transacao ' +
        'EM VOO no pinpad (RF17 item 1).',
        [AstrMetodo, ASessao.FdwPid, LdwPidEmVoo]));
      raise ETefEstacaoPinpadOcupado.CreateFmt(
        'O pinpad está sendo usado por outro terminal desta estação. Aguarde a ' +
        'conclusão e tente novamente.', []);
    end;

    { RF17 item 2 - algum outro autcom VIVO passou cartao e ainda nao
      confirmou. Recusa (RF19).

      Desenho anterior (ate 2026-09-04): orfanava o detentor e seguia. Caiu no
      primeiro teste de campo, e por um motivo que nao tem contorno deste lado -
      a pendencia do AUTCOM A foi RESOLVIDA pela transacao do AUTCOM B.
      FechaSessaoTEF(SCO_CONFIRMA_TEF) nao recebe identificador de transacao
      (untTefCitelNCR.pas:980 em fFinalizarTransacao, :2013 em
      fVerificaPresencaPinPad, untScopeNCR.pas:867 em AbreSCOPE): confirma o que
      estiver pendente na sessao global, que e UMA SO por processo (as globais de
      unit FintSinc/FstrEmpresa/FstrFilial/FstrPdv, untScopeNCR.pas:474). Nao ha
      como enderecar "a transacao do autcom A" - logo, tomar o pinpad de um
      autcom vivo nunca e seguro, por mais cuidado que se tenha com o objeto
      Delphi dele. Ver specs.md 9.3.

      Isto e a trava LCKATC implementada onde ela pode de fato ser cumprida: a
      LCKATC e por empresa e nao protege autcom de empresas DIFERENTES, e o
      servico e o unico ponto que enxerga todos os autcom da estacao. }
    pRecusaSePendenciaDeAutcomVivo(ASessao, AstrMetodo);

    { So o item 3 depende da configuracao DESTA sessao; os itens 1 e 2 acima
      falam de posse do pinpad por OUTRO autcom e valem sempre. Por isso esta
      saida antecipada fica aqui embaixo, e nao no topo do metodo como estava
      ate 2026-09-04 - la ela deixava um autcom sem config furar as duas
      guardas. }
    if not ASessao.FblnCfgRecebida then
      { Sessao sem login PROPRIO nunca pode ser despachada, e isto deixou de
        ser condicional em 2026-09-11 (achado de campo, log das 08:26:11).

        A recusa exigia tambem FstrConfigAplicada = '' - "nao ha configuracao
        de outra pessoa para aproveitar, ha ponteiro nulo" - e quando havia
        alguma, o ramo de baixo emprestava a configuracao alheia e so
        registrava em log. No reinicio do servico isso virou loteria pela
        ORDEM das chamadas: o PRIMEIRO autcom a chamar era recusado (nada
        aplicado ainda), refazia o login e PREENCHIA FstrConfigAplicada; o
        SEGUNDO entao emprestava a configuracao do primeiro e o cartao dele
        voltava com erro 64004 do Scope - terminal errado, e sem o estado que
        o fConfiguraTefCitel monta na instancia. Em campo foi o pid=86700
        despachado com o terminal "004" do pid=88584.

        O comentario da RF17 item 3, logo abaixo, ja registrava que aproveitar
        digital sem o login DA INSTANCIA da exatamente 64004 (campo,
        2026-09-09 17:28:50). O ramo emprestado era a mesma falha pelo outro
        caminho - e era tambem por onde passava o AV de 2026-09-09 (causa raiz
        completa em pColetaOrfasSeOcioso).

        NAO atinge o login ADIADO (RF17 item 4): FblnCfgRecebida e marcado no
        TOPO de fMetodoFConfiguraTefCitel, antes de qualquer decisao de
        adiar, entao a sessao adiada chega aqui com True e segue para a
        reaplicacao abaixo. FblnCfgRecebida = False significa uma coisa so:
        esta sessao nunca mandou login.

        Do lado autcom isto chega com motivo="loginNecessario" e ele refaz o
        login por conta propria, repetindo a chamada em seguida (item 3 do
        Passo 8, 2026-09-10). A mensagem continua acionavel para o caso de o
        autcom nao tratar o motivo - DLL antiga contra servico novo, ou
        re-login que falhou - e ai e o operador que refaz, como era antes.

        A mensagem perdeu a afirmacao sobre os ponteiros da DLL: ela era
        verdadeira so no caso antigo (FstrConfigAplicada vazia) e agora a
        recusa cobre tambem o caso em que a DLL esta carregada com a
        configuracao de outro autcom. }
      raise ETefEstacaoLoginNecessario.CreateFmt(
        'A estacao nao tem o TEF configurado para o autcom pid=%d: o metodo "%s" chegou ' +
        'sem que este autcom tenha feito o login do TEF (fConfiguraTefCitel). Saia e entre ' +
        'novamente na rotina de TEF do AUTCOM para refazer o login, e repita a operacao.',
        [ASessao.FdwPid, AstrMetodo]);

    { RF17 item 3 - impressao digital.

      A impressao digital responde "a DLL ja esta configurada assim?" - e
      isso NAO basta. Ela e um fato de PROCESSO (o que esta na DLL nativa
      compartilhada); o login e tambem um fato de INSTANCIA (o que o
      fConfiguraTefCitel monta dentro da ITefCitel daquela sessao). Uma
      sessao cujo login foi ADIADO tem a digital igual a de quem esta na DLL
      - se as duas forem da mesma empresa e mesmo terminal, sao a mesma
      string - e mesmo assim nunca executou o proprio login.

      Por isso a saida antecipada exige as DUAS coisas. Sem o
      FblnCfgAplicadaNaInstancia, dois autcom do terminal 003 davam erro
      64004 no primeiro cartao do segundo (campo, 2026-09-09 17:28:50). }
    LstrImpressaoDigital := ASessao.fImpressaoDigitalConfig;
    if (LstrImpressaoDigital = FstrConfigAplicada) and ASessao.FblnCfgAplicadaNaInstancia then
      Exit; // caso comum: mesma empresa/terminal, ou o mesmo autcom de novo - custo zero

    if not ASessao.FblnCfgAplicadaNaInstancia then
    begin
      if LstrImpressaoDigital = FstrConfigAplicada then
        LstrPorQue := 'BATE com'
      else
        LstrPorQue := 'NAO bate com';
      pLogaEstacao(Format(
        'pGarantePinpadConfigurado: o pid=%d nunca executou o proprio fConfiguraTefCitel (login ' +
        'ADIADO pela RF17 item 4) - aplicando agora, ANTES de "%s". A impressao digital dele %s ' +
        'a da DLL, mas isso nao substitui o login desta instancia.',
        [ASessao.FdwPid, AstrMetodo, LstrPorQue]));
    end;

    pLogaEstacao(Format(
      'pGarantePinpadConfigurado: "%s" do pid=%d, mas a DLL esta configurada para o pid=%d ' +
      '("%s") - REAPLICANDO a configuracao do pid=%d ("%s").',
      [AstrMetodo, ASessao.FdwPid, FdwPidConfigAplicada, FstrConfigAplicada,
       ASessao.FdwPid, LstrImpressaoDigital]));

    { RF28 - mesmo raciocinio do fMetodoFConfiguraTefCitel: colado na
      reconfiguracao, que e quem repovoa os ponteiros. Aqui a coleta vem DEPOIS
      do log de "REAPLICANDO" de proposito, porque aquele log le
      FstrConfigAplicada e a coleta zera essa variavel. }
    pColetaOrfasAntesDeReconfigurar(ASessao.FdwPid,
      Format('reaplicacao para o pid=%d', [ASessao.FdwPid]));

    { Repetir fConfiguraTefCitel e seguro - esta na lista de metodos
      idempotentes de IA\rules\tef-dvc.md. Reproduz os MESMOS argumentos que
      este autcom mandou no login dele, inclusive somenteCarregarLib. }
    LintValor := ASessao.FTefCitel.fConfiguraTefCitel(
      PAnsiChar(AnsiString(ASessao.FstrCfgEnderecoIp)),
      PAnsiChar(AnsiString(ASessao.FstrCfgCodigoLoja)),
      PAnsiChar(AnsiString(ASessao.FstrCfgNumTerminal)),
      Smallint(ASessao.FintCfgConfigResultado),
      PAnsiChar(AnsiString(ASessao.FstrCfgParametrosAdicionais)),
      ASessao.FblnCfgSomenteCarregarLib);

    if LintValor <> 0 then
      pLogaEstacao(Format(
        'pGarantePinpadConfigurado: reaplicacao para o pid=%d retornou %d (nao-zero) - ' +
        'seguindo mesmo assim; o metodo "%s" vai reportar o proprio erro se houver.',
        [ASessao.FdwPid, LintValor, AstrMetodo]))
    else
      pLogaEstacao(Format('pGarantePinpadConfigurado: reaplicacao para o pid=%d concluida (terminal="%s").',
        [ASessao.FdwPid, ASessao.FstrCfgNumTerminal]));

    FstrConfigAplicada := LstrImpressaoDigital;
    FdwPidConfigAplicada := ASessao.FdwPid;
    ASessao.FblnCfgAplicadaNaInstancia := True;
  finally
    FcsPinpad.Leave;
  end;
end;

{ RF18 - orfanar, nunca destruir. A sessao sai do dicionario de ativas e vai
  para FlstOrfas, mas o objeto (e a ITefCitel dentro dele) continua vivo:
  liberar agora chamaria o destrutor da instancia nativa, que anula os
  ponteiros GLOBAIS das DLLs de terceiro e cegaria todas as outras (RN08,
  specs.md 9.3). Quem libera e pColetaOrfasSeOcioso, e so no ocioso. }
procedure TTefEstacaoRoteador.pOrfanaSessao(ASessao: TTefEstacaoSessaoAutcom;
  const AstrMotivo: String);
var
  LSessaoNoDict: TTefEstacaoSessaoAutcom;
  LblnSaiu, LblnTinhaPendencia: Boolean;
  LintAtivas, LintOrfas: Integer;
begin
  LblnSaiu := False;
  FcsInstancia.Enter;
  try
    { So remove se o dicionario ainda aponta para ESTA sessao - entre a busca
      do chamador e este ponto o PID pode ter ganhado outra. }
    if FdictSessoes.TryGetValue(ASessao.FdwPid, LSessaoNoDict) and
       (LSessaoNoDict = ASessao) then
    begin
      FdictSessoes.Remove(ASessao.FdwPid);
      LblnSaiu := True;
    end;

    if LblnSaiu and (FlstOrfas.IndexOf(ASessao) < 0) then
      FlstOrfas.Add(ASessao);

    LblnTinhaPendencia := ASessao.FblnTransacaoPendenteConfirmacao;
    LintAtivas := FdictSessoes.Count;
    LintOrfas := FlstOrfas.Count;
  finally
    FcsInstancia.Leave;
  end;

  if not LblnSaiu then
    Exit; // ja tinha saido antes - nada a registrar de novo

  pLogaEstacao(Format(
    'pOrfanaSessao: instancia do pid=%d (terminal="%s") ORFANADA - %s. ' +
    'Transacao pendente de confirmacao: %s. ' +
    'Restam %d sessao(oes) ativa(s) e %d orfa(s).',
    [ASessao.FdwPid, ASessao.FstrCfgNumTerminal, AstrMotivo,
     BoolToStr(LblnTinhaPendencia, True), LintAtivas, LintOrfas]));

  if LblnTinhaPendencia then
    pLogaEstacao(Format(
      'pOrfanaSessao: ATENCAO - o pid=%d saiu com transacao passada e NAO confirmada ' +
      '(sem fFinalizarTransacao). Ela DEVERIA ficar pendente no servidor TEF para a ' +
      'rotina de pendencias, mas com um slot unico de pendencia por processo ' +
      '(specs.md 9.3) a proxima transacao ou confirmacao de outro autcom pode ' +
      'resolve-la. Perda aceita (RN09) - o mesmo ja acontece quando o autcom trava.',
      [ASessao.FdwPid]));
end;

{ Devolve a sessao de OUTRO autcom que esteja com transacao pendente de
  confirmacao, ou nil.

  ATENCAO ao que este metodo NAO diz mais (Req. 456190, RF24, Fase 5). Ate o
  Passo 7 da Fase 3.5 a sessao saia do FdictSessoes em pOnDesconectado, entao
  estar no dicionario equivalia a estar VIVO - "vivo" saia de graca. A RF24
  acabou com essa equivalencia de proposito: a sessao agora sobrevive a queda
  da conexao, que e o que faz a transacao atravessar a oscilacao de TS.

  Quem precisa de vivacidade de verdade tem que apurar, e desde 2026-09-09
  17:28 quem apura e o autcom REQUISITANTE, pelo IsHungAppWindow (RF27) -
  ver pResolveDisputaPinpad. Este metodo devolve o DETENTOR, nao um
  atestado de saude. }
function TTefEstacaoRoteador.fSessaoVivaComPendencia(
  const AdwPidAtual: DWORD): TTefEstacaoSessaoAutcom;
var
  LSessao: TTefEstacaoSessaoAutcom;
begin
  Result := nil;
  FcsInstancia.Enter;
  try
    for LSessao in FdictSessoes.Values do
      if (LSessao.FdwPid <> AdwPidAtual) and LSessao.FblnTransacaoPendenteConfirmacao then
        Exit(LSessao);
  finally
    FcsInstancia.Leave;
  end;
end;

{ Outro autcom detem o pinpad agora - por transacao EM VOO (RF17 item 1) ou por
  pendencia de confirmacao (item 2)? Devolve tambem uma descricao pronta para o
  log. Usado pelo no-op de pSair em pTrataChamada e pela guarda de login
  adiado em fMetodoFConfiguraTefCitel (RF17 item 4). }
function TTefEstacaoRoteador.fOutroAutcomDetemPinpad(const AdwPidAtual: DWORD;
  out AstrQuem: String): Boolean;
var
  LSessaoPendente: TTefEstacaoSessaoAutcom;
  LdwPidEmVoo: DWORD;
begin
  AstrQuem := '';

  FcsTransacao.Enter;
  try
    if FblnTransacaoEmAndamento and (FdwPidTransacaoEmAndamento <> AdwPidAtual) then
      LdwPidEmVoo := FdwPidTransacaoEmAndamento
    else
      LdwPidEmVoo := 0;
  finally
    FcsTransacao.Leave;
  end;

  if LdwPidEmVoo <> 0 then
  begin
    AstrQuem := Format('o pid=%d esta com transacao EM VOO no pinpad', [LdwPidEmVoo]);
    Exit(True);
  end;

  LSessaoPendente := fSessaoVivaComPendencia(AdwPidAtual);
  if LSessaoPendente <> nil then
  begin
    AstrQuem := Format('o pid=%d (terminal="%s") esta vivo e com transacao pendente ' +
                       'de confirmacao', [LSessaoPendente.FdwPid, LSessaoPendente.FstrCfgNumTerminal]);
    Exit(True);
  end;

  Result := False;
end;

{ RF17 item 2 / RF19 - recusa a chamada quando OUTRO autcom esta com transacao
  pendente de confirmacao no pinpad. Desde o Passo 6 da Fase 5, a recusa passa
  antes pela DISPUTA (RF27): ver o comentario dentro do metodo.

  Roda com FcsPinpad ja tomado por pGarantePinpadConfigurado. }
procedure TTefEstacaoRoteador.pRecusaSePendenciaDeAutcomVivo(ASessao: TTefEstacaoSessaoAutcom;
  const AstrMetodo: String);
var
  LSessaoDetentora: TTefEstacaoSessaoAutcom;
begin
  LSessaoDetentora := fSessaoVivaComPendencia(ASessao.FdwPid);
  if LSessaoDetentora = nil then
    Exit;

  { RF27 (Passo 6) - "vivo" deixou de sair de graca.

    O comentario acima descrevia a realidade ate a Fase 5: a sessao saia do
    FdictSessoes em pOnDesconectado, entao tudo que restava no dicionario
    pertencia a uma conexao aberta. A RF24 acabou com isso - a sessao agora
    SOBREVIVE a queda da conexao, de proposito, porque e o que faz a
    transacao atravessar a oscilacao de TS. O efeito colateral e este: um
    AUTCOM travado, ou um cuja conexao nunca mais volta, segura o pinpad para
    sempre.

    Por isso, antes de recusar, a estacao PERGUNTA - e so ao detentor por
    PENDENCIA. Transacao em voo nao chega aqui (a guarda do item 1 recusa
    antes) e nem poderia: tomar o pinpad significa orfanar a sessao do
    detentor, e a RN08 proibe destruir instancia com thread de despacho
    rodando. Alem disso "em voo" e transitorio - se a conexao do detentor
    cair, o Passo 4 aborta a transacao dele em milissegundos.

    Metodo que nao e de transacao tambem nao dispara disputa: a disputa custa
    ate 5 s de sonda e pode acabar em pergunta ao operador, e nada disso se
    justifica num pInfo21 ou num fVerificaPresencaPinPad, que o operador nem
    sabe que existem. }
  if ASessao.FblnSuportaDisputa and fMetodoDeTransacao(AstrMetodo) then
  begin
    pResolveDisputaPinpad(ASessao, LSessaoDetentora, AstrMetodo);
    Exit; // sobreviveu a disputa: o detentor foi orfanado, o pinpad e deste autcom
  end;

  pLogaEstacao(Format(
    'pRecusaSePendenciaDeAutcomVivo: "%s" do pid=%d RECUSADO - o pid=%d ' +
    '(terminal="%s") esta VIVO e com transacao pendente de confirmacao no pinpad ' +
    '(RF17 item 2 / RF19). A trava LCKATC nao pegou: ou foi removida na mao, ou os ' +
    'dois autcom sao de empresas diferentes (a LCKATC e por empresa). Sem disputa ' +
    'de pinpad neste caminho (suportaDisputa=%s, metodo de transacao=%s).',
    [AstrMetodo, ASessao.FdwPid, LSessaoDetentora.FdwPid,
     LSessaoDetentora.FstrCfgNumTerminal,
     BoolToStr(ASessao.FblnSuportaDisputa, True),
     BoolToStr(fMetodoDeTransacao(AstrMetodo), True)]));

  raise ETefEstacaoPinpadOcupado.CreateFmt(
    'Existe uma transação do TEF pendente no terminal %s, que continua aberto.' + #13#13 +
    'Conclua ou desfaça a transação naquele terminal antes de iniciar outra aqui.',
    [LSessaoDetentora.FstrCfgNumTerminal]);
end;

{ O requisitante ja voltou com veredito sobre ESTE detentor? (RN15/RN16)

  A conferencia do par (pid, inicioProcesso) e o que impede um veredito de
  virar cheque em branco: sem ela, um "o operador confirmou" emitido para o
  detentor A autorizaria tomar o pinpad do detentor B, que pode ser de outra
  empresa e estar perfeitamente saudavel. }
function TTefEstacaoRoteador.fTomadaAutorizada(ASessaoRequisitante,
  ASessaoDetentora: TTefEstacaoSessaoAutcom; const AblnConexaoViva: Boolean;
  out AstrPorQue: String): Boolean;
begin
  AstrPorQue := '';
  Result := False;

  if ASessaoRequisitante.FdwPidDisputa = 0 then
    Exit; // nao veio veredito nenhum nesta chamada

  if (ASessaoRequisitante.FdwPidDisputa <> ASessaoDetentora.FdwPid) or
     (ASessaoRequisitante.FstrInicioProcessoDisputa <> ASessaoDetentora.FstrInicioProcesso) then
  begin
    pLogaEstacao(Format(
      'fTomadaAutorizada: o pid=%d mandou veredito para o detentor pid=%d/inicio="%s", mas quem ' +
      'detem o pinpad agora e o pid=%d/inicio="%s" - veredito IGNORADO. O detentor mudou entre a ' +
      'recusa e a volta do requisitante.',
      [ASessaoRequisitante.FdwPid, ASessaoRequisitante.FdwPidDisputa,
       ASessaoRequisitante.FstrInicioProcessoDisputa, ASessaoDetentora.FdwPid,
       ASessaoDetentora.FstrInicioProcesso]));
    Exit;
  end;

  { Processo morto dispensa confirmacao humana (RN16): ali nao ha ambiguidade
    nenhuma, e o proprio requisitante verificou por OpenProcess + creation
    time. So vale com a conexao do detentor CAIDA - conexao aberta e prova de
    que o processo existe, e aceitar "morto" contra ela seria aceitar o
    relato em vez do fato. E a unica guarda que a estacao ainda consegue
    fazer sozinha depois que a sonda saiu; a outra e a conferencia do par
    (pid, inicioProcesso) logo acima. }
  if ASessaoRequisitante.FblnDisputaProcessoMorto then
  begin
    if AblnConexaoViva then
      pLogaEstacao(Format(
        'fTomadaAutorizada: o pid=%d relatou o detentor pid=%d como MORTO, mas a conexao dele esta ' +
        'ABERTA - relato descartado (a conexao aberta prova que o processo existe).',
        [ASessaoRequisitante.FdwPid, ASessaoDetentora.FdwPid]))
    else
    begin
      AstrPorQue := Format('o autcom pid=%d nao existe mais (verificado pelo pid=%d, que roda no ' +
                           'mesmo servidor)', [ASessaoDetentora.FdwPid, ASessaoRequisitante.FdwPid]);
      Exit(True);
    end;
  end;

  if ASessaoRequisitante.FblnDisputaConfirmadaPeloOperador then
  begin
    AstrPorQue := Format('o operador do autcom pid=%d confirmou a tomada do pinpad do pid=%d ' +
                         '(que nao respondeu a sonda)',
                         [ASessaoRequisitante.FdwPid, ASessaoDetentora.FdwPid]);
    Exit(True);
  end;
end;

{ RF27/RN15/RN16 - o fluxo de disputa.

  Roda com FcsPinpad ja tomado por pGarantePinpadConfigurado, dentro da thread
  de despacho do REQUISITANTE. pOrfanaSessao toma FcsInstancia, mantendo a
  ordem FcsPinpad -> FcsInstancia que o resto da unit ja usa.

  A ESTACAO NAO DECIDE se o detentor esta travado (mudanca de 2026-09-09,
  17:28, depois do primeiro teste de campo). O desenho original mandava um
  hook de vivacidade e tratava o silencio como "travado". Caiu no primeiro
  teste, e por um motivo estrutural, nao de prazo: a disputa so acontece
  contra o detentor por PENDENCIA, e um autcom com pendencia esta, por
  definicao, FORA de qualquer chamada de TEF - parado esperando o operador
  confirmar ou desfazer. O argumento que sustentava a sonda ("um autcom
  saudavel responde mesmo dentro de um fPassarCartao, porque o fChamaRpc
  bombeia CheckSynchronize") e verdadeiro e irrelevante: o unico caso que
  chega aqui e o caso em que ele NAO esta dentro de chamada nenhuma. Em campo,
  um autcom perfeitamente saudavel esperando o operador ficou 5 s sem
  responder e foi classificado como travado.

  Quem responde essa pergunta agora e o REQUISITANTE, pelo IsHungAppWindow -
  a mesma API que o Windows usa para escrever "Nao Esta Respondendo" na barra
  de titulo. Ele ja verifica o processo do detentor por OpenProcess (RN17,
  mesmo servidor), entao verificar tambem a janela nao adiciona dependencia
  nenhuma.

  O que a estacao continua garantindo (RN15): o veredito so vale se o par
  (pid, inicioProcesso) bater com o detentor DAQUELE instante, e a tomada de
  um processo vivo continua exigindo confirmacao humana. A estacao nunca toma
  o pinpad sozinha, e nenhum caminho mata processo alheio.

  Sai de dois jeitos: sem excecao (tomada concedida, detentor orfanado) ou
  ETefEstacaoPinpadContestavel (o requisitante apura e decide se recusa
  sozinho ou se pergunta ao operador). }
procedure TTefEstacaoRoteador.pResolveDisputaPinpad(ASessaoRequisitante,
  ASessaoDetentora: TTefEstacaoSessaoAutcom; const AstrMetodo: String);
var
  LConexaoDetentor: TTefEstacaoConexao;
  LblnConexaoViva: Boolean;
  LstrPorQue: String;
  LErro: ETefEstacaoPinpadContestavel;
begin
  LConexaoDetentor := ASessaoDetentora.FConexaoAtual;
  LblnConexaoViva := Assigned(LConexaoDetentor) and LConexaoDetentor.blnConectado;

  { O requisitante ja voltou com veredito? }
  if fTomadaAutorizada(ASessaoRequisitante, ASessaoDetentora, LblnConexaoViva, LstrPorQue) then
  begin
    pLogaEstacao(Format(
      'pResolveDisputaPinpad: TOMADA DO PINPAD concedida ao pid=%d para "%s" - %s. O detentor ' +
      'pid=%d (terminal="%s") vai ser ORFANADO; o processo dele NAO e tocado (RN15).',
      [ASessaoRequisitante.FdwPid, AstrMetodo, LstrPorQue, ASessaoDetentora.FdwPid,
       ASessaoDetentora.FstrCfgNumTerminal]));

    { Orfanar tira a pendencia do alcance de fSessaoVivaComPendencia (que so
      varre FdictSessoes), que e exatamente o que libera o requisitante. A
      instancia em si continua viva ate pColetaOrfasSeOcioso poder destrui-la
      sem cegar as outras (RN08) - ver RF18. }
    pOrfanaSessao(ASessaoDetentora, Format('tomada do pinpad pelo pid=%d - %s',
      [ASessaoRequisitante.FdwPid, LstrPorQue]));
    Exit;
  end;

  { Sem veredito: devolve os FATOS e deixa a decisao com quem tem como
    apura-los. A estacao nao le processo alheio nem toca banco (RN17), e nunca
    toma o pinpad sozinha no caso "travado" (RN16). }
  if LblnConexaoViva then
    LstrPorQue := 'tem conexao aberta com a estacao (o processo dele existe)'
  else
    LstrPorQue := 'nao tem conexao aberta com a estacao';

  pLogaEstacao(Format(
    'pResolveDisputaPinpad: "%s" do pid=%d CONTESTAVEL - o detentor pid=%d (terminal="%s") %s. ' +
    'Devolvendo os dados dele para o requisitante verificar o processo e a janela ' +
    '(IsHungAppWindow) e, se estiver travado, perguntar ao operador (RN16).',
    [AstrMetodo, ASessaoRequisitante.FdwPid, ASessaoDetentora.FdwPid,
     ASessaoDetentora.FstrCfgNumTerminal, LstrPorQue]));

  { A mensagem NAO afirma que o detentor nao esta respondendo - a estacao nao
    tem como saber isso. Quem descobre e o requisitante, e e ele quem escolhe
    o texto final que o operador ve. }
  LErro := ETefEstacaoPinpadContestavel.CreateFmt(
    'Existe uma transação do TEF pendente no terminal %s, que continua aberto.' + #13#13 +
    'Conclua ou desfaça a transação naquele terminal antes de iniciar outra aqui.',
    [ASessaoDetentora.FstrCfgNumTerminal]);
  LErro.FdwPidDetentor := ASessaoDetentora.FdwPid;
  LErro.FstrInicioProcessoDetentor := ASessaoDetentora.FstrInicioProcesso;
  LErro.FstrTerminalDetentor := ASessaoDetentora.FstrCfgNumTerminal;
  LErro.FblnConexaoVivaDetentor := LblnConexaoViva;
  raise LErro;
end;

{ RF18, segunda metade - o unico instante seguro para liberar as orfas: nenhuma
  sessao ativa E nenhuma thread de despacho com sessao registrada. Ai nao
  existe mais nenhuma instancia nativa em uso, e anular os ponteiros globais
  das DLLs no destrutor nao cega ninguem.

  Na pratica isso acontece quando o ultimo autcom.exe da estacao fecha. A
  proxima chamada que chegar recria tudo do zero pelo fConfiguraTefCitel do
  login, que e o caminho normal. }
function TTefEstacaoRoteador.fColetaOrfas(
  const AblnAntesDeReconfigurar: Boolean;
  const AdwPidChamador: DWORD): Integer;
var
  LSessao: TTefEstacaoSessaoAutcom;
  LarrColetar: TArray<TTefEstacaoSessaoAutcom>;
  LlstEmUso: TList<TTefEstacaoSessaoAutcom>;
  LPar: TPair<DWORD, TTefEstacaoSessaoAutcom>;
  LdwThreadPropria, LdwPidEmVoo: DWORD;
  LintOutrasThreads, LintAnexadas: Integer;
  LblnEmVoo, LblnEmVooEhDoChamador: Boolean;
begin
  Result := 0;

  FcsTransacao.Enter;
  try
    LblnEmVoo := FblnTransacaoEmAndamento;
    LdwPidEmVoo := FdwPidTransacaoEmAndamento;
  finally
    FcsTransacao.Leave;
  end;

  { CONSERTO de 2026-09-10, achado em campo as 10:12:31 - a coleta nunca rodou.

    Esta guarda quer dizer "codigo nativo pode estar lendo os globais agora".
    Mas no caminho da reconfiguracao a transacao em voo e, quase sempre, a
    RESERVA que o pTrataChamada acabou de fazer para a propria chamada que vai
    configurar a DLL: fPassarCartao e metodo de transacao, reserva na linha
    1918, e pGarantePinpadConfigurado so e chamado na 2052. Ou seja, a guarda
    media "EU estou ocupado" em vez de "OUTRO esta ocupado" - o mesmo erro que
    a guarda de thread tinha, e pelo mesmo motivo.

    Essa reserva ainda NAO encostou em codigo nativo (o despacho vem depois da
    guarda de posse). Transacao em voo de OUTRO pid continua barrando. }
  if LblnEmVoo then
  begin
    LblnEmVooEhDoChamador := AblnAntesDeReconfigurar and
                             (AdwPidChamador <> 0) and
                             (LdwPidEmVoo = AdwPidChamador);
    if not LblnEmVooEhDoChamador then
      Exit;
  end;

  LdwThreadPropria := GetCurrentThreadId;
  LlstEmUso := TList<TTefEstacaoSessaoAutcom>.Create;
  try
    { Duas coisas do mesmo mapa, tomadas juntas: quantas OUTRAS threads estao
      despachando (a guarda de concorrencia) e QUAIS sessoes elas estao usando
      (para nao destruir uma sessao que alguem ainda referencia). }
    FcsThreads.Enter;
    try
      LintOutrasThreads := 0;
      for LPar in FdictSessaoPorThread do
      begin
        if LPar.Key <> LdwThreadPropria then
          Inc(LintOutrasThreads);
        if not LlstEmUso.Contains(LPar.Value) then
          LlstEmUso.Add(LPar.Value);
      end;
    finally
      FcsThreads.Leave;
    end;

    { A guarda que protege de verdade (RN08): nenhuma OUTRA thread em codigo
      nativo. No caminho da reconfiguracao a propria thread nao conta - e ela
      quem vai repovoar os ponteiros logo em seguida. No caminho antigo,
      qualquer thread de despacho barra. }
    if AblnAntesDeReconfigurar then
    begin
      if LintOutrasThreads > 0 then
        Exit;
    end
    else if LlstEmUso.Count > 0 then
      Exit;

    SetLength(LarrColetar, 0);
    FcsInstancia.Enter;
    try
      if FlstOrfas.Count = 0 then
        Exit;

      { A contagem de sessoes so vale para o caminho antigo. Era ela que
        tornava a RF28 impossivel: a sessao do autcom novo ja esta no
        dicionario quando o login dele roda.

        MUDOU em 2026-09-10 (item 2 do Passo 8): conta sessoes ANEXADAS, nao
        FdictSessoes.Count. Depois da RF24 "existe sessao no dicionario"
        deixou de significar "alguem esta ativo" - uma DESANEXADA ficava la
        para sempre e bloqueava esta coleta inteira, e era isso que mantinha
        as 11 sessoes de pe em campo (10/09, 14:53). E a mesma classe de erro
        que este requisito ja cometeu duas vezes: guarda que devia dizer
        "outro esta ocupado" medindo outra coisa.

        Por que continua seguro: este metodo so destroi o que esta em
        FlstOrfas, e desanexada FRESCA nao esta la - quem a poe e
        fOrfanaDesanexadasVencidas, e so depois do prazo. Sessao sem
        FConexaoAtual tambem nao pode estar despachando (despacho roda na
        thread de uma conexao), e a guarda que protege de verdade
        (LlstEmUso/LintOutrasThreads, RN08) esta intacta acima. O conjunto do
        que pode ser destruido nao mudou - mudou quando este caminho desiste. }
      if not AblnAntesDeReconfigurar then
      begin
        LintAnexadas := 0;
        for LSessao in FdictSessoes.Values do
          if Assigned(LSessao.FConexaoAtual) then
            Inc(LintAnexadas);
        if LintAnexadas > 0 then
          Exit;
      end;

      for LSessao in FlstOrfas do
        if not LlstEmUso.Contains(LSessao) then
        begin
          SetLength(LarrColetar, Length(LarrColetar) + 1);
          LarrColetar[High(LarrColetar)] := LSessao;
        end;

      for LSessao in LarrColetar do
      begin
        FlstOrfas.Remove(LSessao);
        { FlstTodasSessoes tem OwnsObjects=True: e o Remove dela que de fato
          libera a sessao e, com ela, a ITefCitel. }
        FlstTodasSessoes.Remove(LSessao);
        Inc(Result);
      end;

      { CAUSA RAIZ do AV em 00000000 encontrado em campo em 2026-09-09
        (Req. 456190, Fase 5). O Remove acima destrui as instancias e, com
        elas, o UnLoadDLLFunctions ANULA os ponteiros globais das DLLs de
        terceiro (untScopeNCR.pas). Mas FstrConfigAplicada/FdwPidConfigAplicada
        continuavam apontando para a configuracao que acabou de ser
        descarregada - a estacao passava a AFIRMAR que a DLL estava configurada
        justamente depois de ter desfeito isso.

        Os dois caminhos de pGarantePinpadConfigurado confiam nessas variaveis,
        e os dois quebravam:
          - sessao que nunca mandou config: o ramo "seguindo com a configuracao
            atual da DLL" dava Exit, e o metodo caia num ponteiro nulo (esse
            ramo NAO existe mais desde 2026-09-11 - hoje a sessao sem login
            proprio e recusada sempre, ver pGarantePinpadConfigurado);
          - sessao que mandou: a impressao digital dela BATIA com a stale (no
            caso de campo era o MESMO pid, mesmo terminal, porque o autcom.exe
            sobreviveu a queda da sessao TS), entao o skip da RF20 tambem dava
            Exit, com o mesmo destino.

        Log de campo, na ordem: pColetaOrfasSeOcioso as 08:57:34.067, depois
        "sem nunca ter enviado fConfiguraTefCitel - seguindo com a configuracao
        atual da DLL (impressao digital ...do pid=120328)" as 08:58:49.499 e o
        Access violation 27 ms depois.

        Zerar aqui e o que restabelece a verdade: nao existe configuracao
        aplicada enquanto os ponteiros estiverem nulos.

        No caminho da reconfiguracao (RF28) quem regrava e o CHAMADOR, depois
        que o fConfiguraTefCitel voltar - e e por isso que zerar aqui continua
        certo mesmo com sessao viva no dicionario: se o configure estourar, o
        estado zerado e o honesto, e a proxima chamada de pinpad de qualquer
        sessao reaplica em vez de confiar numa configuracao que nao existe
        mais. }
      if Result > 0 then
      begin
        FstrConfigAplicada := '';
        FdwPidConfigAplicada := 0;
      end;
    finally
      FcsInstancia.Leave;
    end;
  finally
    LlstEmUso.Free;
  end;
end;

{ Item 2 do Passo 8 da Fase 5 (Req. 456190, 2026-09-10).

  A RF24 deixa a sessao DESANEXADA no dicionario para o mesmo processo
  reatar sem login - e esse e o conserto que fez a oscilacao de TS parar de
  quebrar o TEF. O efeito colateral: autcom que fecha NORMALMENTE nunca sai
  do dicionario, porque a RF28 coleta orfas e ele nao e orfao. Em campo,
  10/09 as 14:53: 11 sessoes no dicionario com um autcom ativo.

  Aqui o prazo fecha isso. Passado TEF_ESTACAO_DESANEXADA_MAX_MS sem o
  processo voltar, a sessao vai para o caminho de orfanamento de sempre
  (pOrfanaSessao) e passa a ser coletavel pela RF28.

  Junta a lista sob FcsInstancia e SO DEPOIS chama pOrfanaSessao, que toma o
  mesmo lock por conta propria - o padrao ja usado nos outros pontos que
  orfanam mais de uma. }
function TTefEstacaoRoteador.fOrfanaDesanexadasVencidas: Integer;
var
  LSessao: TTefEstacaoSessaoAutcom;
  LarrVencidas: TArray<TTefEstacaoSessaoAutcom>;
  LarrIdades: TArray<DWORD>;
  LdwAgora, LdwIdade: DWORD;
  LintInd: Integer;
begin
  Result := 0;
  LdwAgora := GetTickCount;
  SetLength(LarrVencidas, 0);
  SetLength(LarrIdades, 0);

  FcsInstancia.Enter;
  try
    for LSessao in FdictSessoes.Values do
    begin
      if Assigned(LSessao.FConexaoAtual) or (LSessao.FdwTickDesanexada = 0) then
        Continue;
      LdwIdade := LdwAgora - LSessao.FdwTickDesanexada;
      if LdwIdade < TEF_ESTACAO_DESANEXADA_MAX_MS then
        Continue;
      SetLength(LarrVencidas, Length(LarrVencidas) + 1);
      LarrVencidas[High(LarrVencidas)] := LSessao;
      SetLength(LarrIdades, Length(LarrIdades) + 1);
      LarrIdades[High(LarrIdades)] := LdwIdade;
    end;
  finally
    FcsInstancia.Leave;
  end;

  for LintInd := 0 to High(LarrVencidas) do
  begin
    pOrfanaSessao(LarrVencidas[LintInd], Format(
      'DESANEXADA ha %d s sem o processo voltar (prazo da RF24: %d s) - item 2 do ' +
      'Passo 8. A instancia continua viva ate a RF28 poder libera-la no ocioso',
      [LarrIdades[LintInd] div 1000, TEF_ESTACAO_DESANEXADA_MAX_MS div 1000]));
    Inc(Result);
  end;
end;

procedure TTefEstacaoRoteador.pColetaOrfasSeOcioso;
var
  LintColetadas, LintVencidas: Integer;
begin
  { Antes de tentar coletar, promove a orfa o que ja passou do prazo da RF24
    (item 2 do Passo 8) - senao a desanexada nunca chega a ser coletavel. }
  LintVencidas := fOrfanaDesanexadasVencidas;
  if LintVencidas > 0 then
    pLogaEstacao(Format(
      'pColetaOrfasSeOcioso: %d sessao(oes) DESANEXADA(s) passaram do prazo de %d s e ' +
      'foram orfanadas (item 2 do Passo 8) - seguem para a coleta abaixo.',
      [LintVencidas, TEF_ESTACAO_DESANEXADA_MAX_MS div 1000]));

  { Sem chamador: qualquer transacao em voo barra, e nenhuma sessao pode
    estar ANEXADA. Ninguem reconfigura depois deste caminho. }
  LintColetadas := fColetaOrfas(False, 0);
  if LintColetadas > 0 then
    pLogaEstacao(Format(
      'pColetaOrfasSeOcioso: nenhuma sessao ativa e nenhuma thread de despacho - ' +
      '%d instancia(s) orfa(s) liberada(s). Os ponteiros globais das DLLs de terceiro ' +
      'ficam anulados (o modulo em si continua carregado - UnLoadDLLFunctions faz ' +
      'LoadLibrary+FreeLibrary, saldo zero) e a impressao digital de configuracao foi ' +
      'ZERADA junto - sem instancia nao ha configuracao aplicada; o proximo ' +
      'fConfiguraTefCitel do login repovoa tudo via fLoadDLLFunctions.',
      [LintColetadas]));
end;

procedure TTefEstacaoRoteador.pVarreFilaNaSubida;
var
  LarrItens: TArray<TTefEstacaoItemFila>;
  LintAchados, LintDescartados: Integer;
begin
  { RF29 (Req. 456190, Passo 7). O que estiver na fila quando o processo sobe e
    resposta de uma instancia ANTERIOR do servico, e entregar aquilo seria pior
    do que perde-lo: o autcom registraria uma venda que ele nao consegue mais
    confirmar. O fFinalizarTransacao dele iria para ESTA instancia, cuja sessao
    Scope nunca soube daquela transacao - a venda ficaria gravada no autcom e
    pendente no TEF, que e exatamente o descasamento que a RN03 proibe.

    Descartar e a escolha honesta: a transacao segue pendente na estacao e o
    operador a resolve pelo relatorio de pendencias do TEF, que e o
    procedimento que ja existe. O log conta quantos, para que a perda seja
    audivel em vez de silenciosa. }
  LarrItens := FFila.fListaPendentes;
  LintAchados := Length(LarrItens);
  if LintAchados = 0 then
  begin
    pLogaEstacao(Format(
      'pVarreFilaNaSubida: fila local vazia na subida do servico (instancia "%s") - ' +
      'nada herdado de instancia anterior (RF29).', [FstrInstanciaServico]));
    Exit;
  end;

  LintDescartados := FFila.fDescartaTudo;
  pLogaEstacao(Format(
    'pVarreFilaNaSubida: %d item(ns) na fila local na SUBIDA do servico - %d descartado(s) ' +
    '(RF29). Sao respostas de uma instancia ANTERIOR (a desta subida e "%s"): entregar ' +
    'faria o autcom registrar uma venda que ele nao consegue mais confirmar, porque o ' +
    'fFinalizarTransacao dele viria para ESTA instancia, cuja sessao Scope nao sabe daquela ' +
    'transacao. As transacoes correspondentes seguem PENDENTES na estacao e devem ser ' +
    'resolvidas pelo relatorio de pendencias do TEF.',
    [LintAchados, LintDescartados, FstrInstanciaServico]));

  if LintDescartados < LintAchados then
    pLogaEstacao(Format(
      'pVarreFilaNaSubida: ATENCAO - %d item(ns) NAO puderam ser apagados (arquivo em uso ou ' +
      'permissao). Eles continuam na pasta e serao alcancados pelo descarte por idade, mas ' +
      'ate la um reata pode enxerga-los como "naFila".',
      [LintAchados - LintDescartados]));
end;

procedure TTefEstacaoRoteador.pColetaOrfasAntesDeReconfigurar(
  const AdwPidChamador: DWORD; const AstrPorQue: String);
var
  LintColetadas: Integer;
begin
  LintColetadas := fColetaOrfas(True, AdwPidChamador);
  if LintColetadas > 0 then
    pLogaEstacao(Format(
      'pColetaOrfasAntesDeReconfigurar (%s): %d instancia(s) orfa(s) liberada(s) - RF28. ' +
      'A contagem de sessoes NAO foi exigida (era ela que prendia a orfa quando um autcom ' +
      'novo entrava) e a propria thread foi ignorada na guarda de despacho. Os ponteiros ' +
      'globais das DLLs de terceiro estao anulados NESTE INSTANTE e vao ser repovoados na ' +
      'linha seguinte, pelo fLoadDLLFunctions que o fConfiguraTefCitel chama ' +
      'incondicionalmente - nenhuma outra thread de despacho existe para observa-los nulos.',
      [AstrPorQue, LintColetadas]));
end;

procedure TTefEstacaoRoteador.pEnviaOuEnfileira(AConexao: TTefEstacaoConexao;
  AEnvelope: TJSONObject; const ABlnPersistirSeFalhar: Boolean);
var
  LdwPidDestino: DWORD;
  LSessao: TTefEstacaoSessaoAutcom;
begin
  if Assigned(AConexao) then
  try
    AConexao.pEnviaFrame(TEncoding.UTF8.GetBytes(AEnvelope.ToJSON));
    Exit;
  except
    // conexao indisponivel - tenta a conexao ATUAL da sessao, abaixo
  end;

  { Segunda tentativa pela conexao atual da sessao (Req. 456190, Passo 3).
    Medido em campo em 2026-09-09 as 10:43:20: a resposta foi para a fila
    local mesmo havendo con=6 viva e do MESMO pid, porque AConexao e a
    conexao capturada no despacho (con=5, ja morta) e o mapa
    thread->conexao usado por fConexaoDeSaida foi registrado no mesmo
    momento. Com a sessao sobrevivendo a queda (RF24), o destino tem que ser
    resolvido na HORA DO ENVIO. }
  LSessao := fSessaoDaThread;
  if Assigned(LSessao) and Assigned(LSessao.FConexaoAtual) and
     (LSessao.FConexaoAtual <> AConexao) and LSessao.FConexaoAtual.blnConectado then
  try
    LSessao.FConexaoAtual.pEnviaFrame(TEncoding.UTF8.GetBytes(AEnvelope.ToJSON));
    pLogaEstacao(Format(
      'pEnviaOuEnfileira: a conexao do despacho estava morta, envelope id=%d tipo="%s" entregue ' +
      'pela conexao ATUAL da sessao (con=%d, pid=%d).',
      [fJsonInt(AEnvelope, 'id', 0), fJsonStr(AEnvelope, 'tipo'),
       LSessao.FConexaoAtual.intIdConexao, LSessao.FdwPid]));
    Exit;
  except
    // essa tambem caiu - cai para a fila abaixo se aplicavel
  end;

  if not ABlnPersistirSeFalhar then
    Exit;

  { O PID de destino e o que amarra o item ao autcom.exe certo no reenvio
    (Passo 8, RF21). Conexao nil ou PID ainda desconhecido gravam 0: o item
    so sera entregue a uma conexao tambem sem PID e, no limite, expira. Nao
    ha destino melhor a inventar - entregar "para quem chegar" e exatamente
    o defeito que este passo corrige. }
  LdwPidDestino := 0;
  if Assigned(AConexao) then
    LdwPidDestino := AConexao.dwPid;

  FFila.pEnfileira(AEnvelope, LdwPidDestino);
  pLogaEstacao(Format(
    'pEnviaOuEnfileira: envio falhou - envelope id=%d tipo="%s" persistido na fila ' +
    'local para o pid=%d (RF07/RF21).',
    [fJsonInt(AEnvelope, 'id', 0), fJsonStr(AEnvelope, 'tipo'), LdwPidDestino]));
end;

procedure TTefEstacaoRoteador.pEnviaResposta(AConexao: TTefEstacaoConexao; const AintId: Integer;
  ARespostaResult: TJSONObject; const ABlnPersistirSeFalhar: Boolean);
var
  LEnvelope: TJSONObject;
begin
  LEnvelope := TJSONObject.Create;
  try
    LEnvelope.AddPair('v', TJSONNumber.Create(1));
    LEnvelope.AddPair('id', TJSONNumber.Create(AintId));
    LEnvelope.AddPair('tipo', 'resposta');
    LEnvelope.AddPair('ok', TJSONBool.Create(True));
    if Assigned(ARespostaResult) then
      LEnvelope.AddPair('result', ARespostaResult.Clone as TJSONValue);

    pEnviaOuEnfileira(AConexao, LEnvelope, ABlnPersistirSeFalhar);
  finally
    LEnvelope.Free;
  end;
end;

{ Resposta da recusa CONTESTAVEL (Req. 456190, RF27, Passo 6).

  Forma deliberada: ok=TRUE, sem "result", com "motivo" e "detentor". Nao e
  erro - se fosse (ok=false), o fChamaRpc do autcom levantaria excecao e o
  operador veria o dialogo do madExcept, que e justamente o que se tirou da
  frente dele em 2026-09-09. E nao e a negativa comum tambem: nao vai evento
  500 junto, porque a mensagem que o operador precisa ver aqui nao e "o
  pinpad esta ocupado", e a PERGUNTA sobre assumir - e quem a faz e o autcom,
  depois de verificar o processo do detentor.

  So chega aqui autcom que declarou "suportaDisputa" no contexto; os demais
  nunca disputam e continuam recebendo a recusa seca de sempre. }
procedure TTefEstacaoRoteador.pEnviaRespostaContestavel(AConexao: TTefEstacaoConexao;
  const AintId: Integer; AErro: ETefEstacaoPinpadContestavel);
var
  LEnvelope, LDetentor: TJSONObject;
begin
  LEnvelope := TJSONObject.Create;
  try
    LEnvelope.AddPair('v', TJSONNumber.Create(1));
    LEnvelope.AddPair('id', TJSONNumber.Create(AintId));
    LEnvelope.AddPair('tipo', 'resposta');
    LEnvelope.AddPair('ok', TJSONBool.Create(True));
    LEnvelope.AddPair('motivo', 'pinpadContestavel');
    LEnvelope.AddPair('erro', AErro.Message);

    LDetentor := TJSONObject.Create;
    LDetentor.AddPair('pid', TJSONNumber.Create(Int64(AErro.FdwPidDetentor)));
    LDetentor.AddPair('inicioProcesso', AErro.FstrInicioProcessoDetentor);
    LDetentor.AddPair('terminal', AErro.FstrTerminalDetentor);
    LDetentor.AddPair('conexaoViva', TJSONBool.Create(AErro.FblnConexaoVivaDetentor));
    LEnvelope.AddPair('detentor', LDetentor);

    { Nao persiste na fila local: uma disputa e uma conversa em tempo real
      com o operador. Entregar isto minutos depois, numa reconexao, seria
      perguntar sobre um detentor que talvez nem exista mais. }
    pEnviaOuEnfileira(AConexao, LEnvelope, False);
  finally
    LEnvelope.Free;
  end;
end;

procedure TTefEstacaoRoteador.pEnviaRespostaErro(AConexao: TTefEstacaoConexao;
  const AintId: Integer; const AstrErro: String; const AstrMotivo: String);
var
  LEnvelope: TJSONObject;
begin
  LEnvelope := TJSONObject.Create;
  try
    LEnvelope.AddPair('v', TJSONNumber.Create(1));
    LEnvelope.AddPair('id', TJSONNumber.Create(AintId));
    LEnvelope.AddPair('tipo', 'resposta');
    LEnvelope.AddPair('ok', TJSONBool.Create(False));
    LEnvelope.AddPair('erro', AstrErro);
    { So vai quando ha motivo, para nao mudar o envelope das dezenas de
      chamadas antigas: um autcom que nao conheca o campo continua vendo
      exatamente a resposta de sempre (RF29, item 3 do Passo 8). }
    if AstrMotivo <> '' then
      LEnvelope.AddPair('motivo', AstrMotivo);
    pEnviaOuEnfileira(AConexao, LEnvelope, False); // erro nao precisa sobreviver a reconexao
  finally
    LEnvelope.Free;
  end;
end;

{ Negativa sintetica: monta um IRetornoTEFCitel so com o status 500 e o texto, e
  manda pelo mesmo caminho de qualquer evento do pinpad. Do lado autcom cai em
  AtualizaTefCitel -> strInfo500 -> pMsgInfo500, que preenche
  FstrMotivoTransacaoNegada e abre fMensagem('ATENCAO!', <texto>, ['&Ok']) -
  exatamente o dialogo da "NAO AUTORIZADA" (untTefCitelOperacoes.pas:1176). }
procedure TTefEstacaoRoteador.pEnviaEventoNegado(const AstrMensagem: String);
var
  LRetorno: IRetornoTEFCitel;
begin
  LRetorno := TRetornoTEFCitel.Create;
  LRetorno.StatusTEF.strStatus   := '500';
  LRetorno.StatusTEF.strMensagem := AstrMensagem;
  pEnviaEvento(LRetorno);
end;

procedure TTefEstacaoRoteador.pEnviaEvento(ARetorno: IRetornoTEFCitel);
var
  LEnvelope, LDados: TJSONObject;
  LConexao: TTefEstacaoConexao;
begin
  { Log de diagnostico (Req. 456190, 2026-09-02) - investigacao de mensagem
    de status reaparecendo na transacao seguinte (ver comentario espelhado
    em TTefCitelDvc.pTrataEvento/pNotifica, lado autcom). Registra toda vez
    que a instancia real notifica um status - se a MESMA transacao gerar o
    mesmo status/mensagem mais de uma vez aqui, e essa a origem da
    duplicacao (nao um bug de transporte). }
  pLogaEstacao(Format(
    'pEnviaEvento: enviando status="%s" mensagem="%s".',
    [ARetorno.StatusTEF.strStatus, ARetorno.StatusTEF.strMensagem]));

  LEnvelope := TJSONObject.Create;
  try
    LDados := TJSONObject.Create;
    LDados.AddPair('retorno', fJsonDeIRetornoTEFCitel(ARetorno));

    LEnvelope.AddPair('v', TJSONNumber.Create(1));
    LEnvelope.AddPair('id', TJSONNumber.Create(0));
    LEnvelope.AddPair('tipo', 'evento');
    LEnvelope.AddPair('dados', LDados);

    { notificacao de progresso em tempo real - best effort. A fonte de
      verdade do resultado final e a "resposta" do metodo de transacao
      (fPassarCartao/fCancelaTransacaoTerminal/fReimpressao), que essa sim
      e persistida na fila local se nao puder ser entregue (RF07). }
    LConexao := fConexaoDeSaida;
    if not Assigned(LConexao) then
      pLogaEstacao(Format(
        'pEnviaEvento: status="%s" DESCARTADO - sem conexao de destino (nenhum despacho em curso nesta thread).',
        [ARetorno.StatusTEF.strStatus]));
    pEnviaOuEnfileira(LConexao, LEnvelope, False);
  finally
    LEnvelope.Free;
  end;
end;

function TTefEstacaoRoteador.fEnviaHook(const AintId: Integer; const AstrHook: String;
  ADados: TJSONObject): Boolean;
var
  LEnvelope: TJSONObject;
  LConexao: TTefEstacaoConexao;
begin
  Result := False;
  LEnvelope := TJSONObject.Create;
  try
    LEnvelope.AddPair('v', TJSONNumber.Create(1));
    LEnvelope.AddPair('id', TJSONNumber.Create(AintId));
    LEnvelope.AddPair('tipo', 'hook');
    LEnvelope.AddPair('hook', AstrHook);
    if Assigned(ADados) then
      LEnvelope.AddPair('dados', ADados); // envelope passa a ser dono de ADados

    LConexao := fConexaoDeSaida;
    if not Assigned(LConexao) then
    begin
      { Devolve False em vez de levantar excecao: quem chama
        (fEnviaHookEAguarda) engole excecao e cairia na espera de 30s do
        TEF_ESTACAO_TIMEOUT_HOOK_MS - com o pinpad parado a toa, ja que
        ninguem vai responder um hook que nunca saiu. }
      pLogaEstacao(Format(
        'fEnviaHook: hook="%s" id=%d SEM conexao de destino (nenhum despacho em curso nesta thread) - nao enviado.',
        [AstrHook, AintId]));
      Exit;
    end;
    LConexao.pEnviaFrame(TEncoding.UTF8.GetBytes(LEnvelope.ToJSON));
    Result := True;
  finally
    LEnvelope.Free; // libera tambem ADados, aninhado
  end;
end;

function TTefEstacaoRoteador.fEnviaHookEAguarda(const AstrHook: String; ADados: TJSONObject): TJSONObject;
var
  LintId: Integer;
  LPendente: TTefEstacaoHookPendente;
  LdwInicio: DWORD;
  LblnEnviado, LblnRespondido: Boolean;
begin
  LintId := TInterlocked.Increment(FintProximoIdHook);
  LPendente := TTefEstacaoHookPendente.Create;
  { Mesma conexao que fEnviaHook vai usar - as duas chamadas rodam nesta
    thread de despacho, entao fConexaoDeSaida devolve a mesma. Ela tambem e o
    filtro que pOnDesconectado usa para acordar SO os hooks da conexao que
    caiu. }
  LPendente.Conexao := fConexaoDeSaida;

  FcsHooks.Enter;
  try
    FdictHooksPendentes.Add(LintId, LPendente);
  finally
    FcsHooks.Leave;
  end;

  { Log de diagnostico (Req. 456190, 2026-08-31) - investigando por que um
    hook grande especifico (~2.3KB, DepoisPassarCartao ou SucessoTefCartao)
    trava so no debito. So o tamanho do payload aparecia nos logs de
    transporte, sem o nome do hook - impossivel confirmar qual dos dois. }
  pLogaEstacao(Format('fEnviaHook: hook="%s" id=%d despachado.', [AstrHook, LintId]));
  LdwInicio := GetTickCount;

  LblnEnviado := False;
  try
    LblnEnviado := fEnviaHook(LintId, AstrHook, ADados);
  except
    { canal indisponivel no momento do envio - segue para o default
      abaixo; a transacao real continua rodando sozinha (RF07). }
  end;

  { So espera o que de fato saiu (Req. 456190, Passo 4). Esperar 30s por um
    hook que nunca foi enviado seria pinpad parado sem ninguem para
    responder. }
  LblnRespondido := False;
  if LblnEnviado then
    LblnRespondido := LPendente.Evento.WaitFor(TEF_ESTACAO_TIMEOUT_HOOK_MS) = wrSignaled;

  if not LblnRespondido then
  begin
    if LblnEnviado then
      pLogaEstacao(Format(
        'fEnviaHook: hook="%s" id=%d ESTOUROU o timeout de %d ms (esperado %d ms) - aplicando default seguro.',
        [AstrHook, LintId, GetTickCount - LdwInicio, TEF_ESTACAO_TIMEOUT_HOOK_MS]))
    else
      pLogaEstacao(Format(
        'fEnviaHook: hook="%s" id=%d nao foi entregue - aplicando default seguro NA HORA, sem esperar os %d ms.',
        [AstrHook, LintId, TEF_ESTACAO_TIMEOUT_HOOK_MS]));
    Result := TJSONObject.Create;
    Result.AddPair('ok', TJSONBool.Create(True));
  end
  else
  begin
    pLogaEstacao(Format('fEnviaHook: hook="%s" id=%d respondido em %d ms.',
      [AstrHook, LintId, GetTickCount - LdwInicio]));
    Result := LPendente.Resposta;
    LPendente.Resposta := nil; // transfere posse antes de liberar o pendente
    if not Assigned(Result) then
    begin
      { Acordado por pOnDesconectado (a conexao do destinatario caiu) - o
        evento foi sinalizado sem Resposta. Mesmo default seguro do estouro. }
      pLogaEstacao(Format(
        'fEnviaHook: hook="%s" id=%d foi acordado SEM resposta (a conexao de destino caiu) - ' +
        'aplicando default seguro.', [AstrHook, LintId]));
      Result := TJSONObject.Create;
      Result.AddPair('ok', TJSONBool.Create(True));
    end;
  end;

  FcsHooks.Enter;
  try
    FdictHooksPendentes.ExtractPair(LintId);
  finally
    FcsHooks.Leave;
  end;
  LPendente.Free;
end;

function TTefEstacaoRoteador.fPerguntaHookBooleano(const AstrHook: String; ADados: TJSONObject): Boolean;
var
  LResposta: TJSONObject;
begin
  LResposta := fEnviaHookEAguarda(AstrHook, ADados);
  try
    Result := fJsonBool(LResposta, 'ok', True);
  finally
    LResposta.Free;
  end;
end;

{ hooks ligados na instancia real }

function TTefEstacaoRoteador.fHookAntesPassarCartao: Boolean;
begin
  Result := fPerguntaHookBooleano('AntesPassarCartao', TJSONObject.Create);
end;

function TTefEstacaoRoteador.fHookAntesCancelarTransacao: Boolean;
begin
  Result := fPerguntaHookBooleano('AntesCancelarTransacao', TJSONObject.Create);
end;

function TTefEstacaoRoteador.fHookAntesReimpressao: Boolean;
begin
  Result := fPerguntaHookBooleano('AntesReimpressao', TJSONObject.Create);
end;

procedure TTefEstacaoRoteador.pHookGravaLogErr(const AblnGravarErro: Boolean; AstrMensagemErro: String;
  AstrRelatorio: String; AstrUltSQL: String);
var
  LDados: TJSONObject;
begin
  LDados := TJSONObject.Create;
  LDados.AddPair('gravarErro', TJSONBool.Create(AblnGravarErro));
  LDados.AddPair('mensagemErro', AstrMensagemErro);
  LDados.AddPair('relatorio', AstrRelatorio);
  LDados.AddPair('ultSql', AstrUltSQL);
  fEnviaHookEAguarda('GravaLogErr', LDados).Free;
end;

{ despacho de metodos RPC ("chamada") - mesmos nomes de metodo e campos de
  "dados" gerados por untTefCitelDvc.pas (lado AUTCOM); qualquer alteracao
  de protocolo precisa espelhar as duas unidades. }

function TTefEstacaoRoteador.fDespachaMetodo(const AstrMetodo: String; ADados: TJSONObject): TJSONObject;
begin
  Result := nil;
  if AstrMetodo = 'fConfiguraTefCitel' then
    Result := fMetodoFConfiguraTefCitel(ADados)
  else if AstrMetodo = 'fPassarCartao' then
    Result := fMetodoFPassarCartao(ADados)
  else if AstrMetodo = 'fFinalizarTransacao' then
    pMetodoFFinalizarTransacao(ADados)
  else if AstrMetodo = 'fCancelaTransacaoTerminal' then
    Result := fMetodoFCancelaTransacaoTerminal(ADados)
  else if AstrMetodo = 'fReimpressao' then
    Result := fMetodoFReimpressao(ADados)
  else if AstrMetodo = 'pSair' then
    pMetodoPSair(ADados)
  else if AstrMetodo = 'pInfo34' then
    pMetodoPInfo34(ADados)
  else if AstrMetodo = 'pInfo21' then
    pMetodoPInfo21(ADados)
  else if AstrMetodo = 'pInfo30' then
    pMetodoPInfo30(ADados)
  else if AstrMetodo = 'fObtemDadoPinPadDireto' then
    Result := fMetodoFObtemDadoPinPadDireto(ADados)
  else if AstrMetodo = 'pRetornaLog' then
    Result := fMetodoPRetornaLog(ADados)
  else if AstrMetodo = 'fConteudoLogErro' then
    Result := fMetodoFConteudoLogErro(ADados)
  else if AstrMetodo = 'pInfo30DebitoPreDatado' then
    pMetodoPInfo30DebitoPreDatado(ADados)
  else if AstrMetodo = 'pInfo30DebitoCredito1Minuto' then
    pMetodoPInfo30DebitoCredito1Minuto(ADados)
  else if AstrMetodo = 'pInfo30DebitoParcelado' then
    pMetodoPInfo30DebitoParcelado(ADados)
  else if AstrMetodo = 'fVerificaPresencaPinPad' then
    Result := fMetodoFVerificaPresencaPinPad(ADados)
  else if AstrMetodo = 'fObtemVersao' then
    Result := fMetodoFObtemVersao(ADados)
  else if AstrMetodo = 'fInfoPixCadastro' then
    Result := fMetodoFInfoPixCadastro(ADados)
  else if AstrMetodo = 'pEnviarQrCode' then
    pMetodoPEnviarQrCode(ADados)
  else if AstrMetodo = 'pLimpaQrCode' then
    pMetodoPLimpaQrCode(ADados)
  else if AstrMetodo = 'fTraduzirErro' then
    Result := fMetodoFTraduzirErro(ADados)
  else if AstrMetodo = 'fObtemInfoPinPad' then
    Result := fMetodoFObtemInfoPinPad(ADados)
  else if AstrMetodo = 'fAtuConsulta' then
    Result := fMetodoFAtuConsulta(ADados)
  else if AstrMetodo = 'pAtuAbre' then
    Result := fMetodoPAtuAbre(ADados)
  else if AstrMetodo = 'pAtuParte' then
    pMetodoPAtuParte(ADados)
  else if AstrMetodo = 'fAtuFecha' then
    Result := fMetodoFAtuFecha(ADados)
  else if AstrMetodo = 'fAtuAplica' then
    Result := fMetodoFAtuAplica(ADados)
  else
    raise ETefEstacaoRoteador.CreateFmt('Metodo RPC desconhecido: "%s".', [AstrMetodo]);
end;

function TTefEstacaoRoteador.fMetodoFConfiguraTefCitel(ADados: TJSONObject): TJSONObject;
var
  LintValor: Integer;
  LSessao: TTefEstacaoSessaoAutcom;
  LstrQuemDetem: String;
begin
  LSessao := fSessaoDaThread;

  { Os argumentos sao guardados ANTES de qualquer decisao: eles alimentam tanto a
    chamada nativa logo abaixo quanto a reaplicacao posterior de
    pGarantePinpadConfigurado, quando o login e adiado (Req. 456190, Passo 6). }
  LSessao.FstrCfgEnderecoIp := fJsonStr(ADados, 'enderecoIp');
  LSessao.FstrCfgCodigoLoja := fJsonStr(ADados, 'codigoLoja');
  LSessao.FstrCfgNumTerminal := fJsonStr(ADados, 'numTerminal');
  LSessao.FstrCfgParametrosAdicionais := fJsonStr(ADados, 'parametrosAdicionais');
  LSessao.FintCfgConfigResultado := fJsonInt(ADados, 'configResultado');
  LSessao.FblnCfgSomenteCarregarLib := fJsonBool(ADados, 'somenteCarregarLib');
  LSessao.FblnCfgRecebida := True;

  LintValor := 0;

  { FcsPinpad cobre o metodo INTEIRO - checagem de posse, chamada nativa e
    escrituracao. Ate 2026-09-08 ele so era tomado na escrituracao do final, e
    dois logins simultaneos (ou um login concorrente com a reaplicacao de
    pGarantePinpadConfigurado) entravam na DLL nativa sem serializacao nenhuma.
    Ordem FcsPinpad -> FcsTransacao/FcsInstancia (dentro de
    fOutroAutcomDetemPinpad), a mesma de pGarantePinpadConfigurado. }
  FcsPinpad.Enter;
  try
    { RF17 item 4 (Req. 456190, 2026-09-08) - LOGIN ADIADO.

      fConfiguraTefCitel nativo NAO e inofensivo. Com somenteCarregarLib=False
      ele termina em FechaSessaoTEF(1, 1) (untTefCitelNCR.pas:685), isto e
      SCO_CONFIRMA_TEF com bForcar=1. FechaSessaoTEF nao recebe identificador de
      transacao e a sessao Scope e UMA SO por processo (globais de unit
      FintSinc/FstrEmpresa/FstrFilial/FstrPdv, untScopeNCR.pas:474), entao esse
      confirm cai sobre a transacao pendente de QUEM ESTIVER la - que no DVC e
      outro autcom da mesma estacao.

      Comprovado em campo em 2026-09-08: o autcom A (term. 003, pid 71824)
      autorizou o Controle 09804893005 as 08:17:51 e nao finalizou; o login do
      autcom B (term. 004, pid 86276) as 08:18:40 confirmou a transacao do A. O
      login do B levou 1,25 s contra 4,4 s do login do A - a diferenca e o
      AbreSCOPE que nao rodou (INI_SESSAO ja estava setado pela sessao do A,
      untScopeNCR.pas:1025), sobrando so o confirm.

      As guardas de posse de pGarantePinpadConfigurado nao alcancavam este
      caminho: fConfiguraTefCitel esta fora de fMetodoUsaPinpad de proposito
      (ela E a configuracao). Por isso a guarda e repetida aqui.

      Recusar o login nao e opcao - o autcom precisa subir com o TEF habilitado.
      Entao o login e ADIADO: nao encosta na DLL, responde 0, e a configuracao
      real entra na primeira chamada de pinpad, pela reaplicacao de
      pGarantePinpadConfigurado, com os argumentos guardados acima. Enquanto o
      detentor nao resolver, essa primeira chamada e recusada pelo item 2 - que
      e o comportamento desejado.

      Adiar TUDO e mais seguro do que forcar somenteCarregarLib=True: naquele
      caminho as linhas 629-631 de untTefCitelNCR.pas ainda sobrescrevem
      FstrEmpresa/FstrFilial/FstrPdv com os do autcom novo, e a linha 688
      (FintSinc := 0) esta FORA do if - apagaria INI_SESSAO/INI_COMUNIC com a
      sessao Scope do detentor genuinamente aberta.

      A guarda cobre tambem a transacao EM VOO (RF17 item 1), nao so a pendencia:
      reconfigurar a DLL no meio de um fPassarCartao de outro autcom e pior
      ainda que confirmar a pendencia dele. }
    if fOutroAutcomDetemPinpad(LSessao.FdwPid, LstrQuemDetem) then
    begin
      pLogaEstacao(Format(
        'fConfiguraTefCitel do pid=%d ADIADO - %s (RF17 item 4). A DLL nativa NAO foi ' +
        'chamada: fConfiguraTefCitel termina em FechaSessaoTEF(SCO_CONFIRMA_TEF, forcado) ' +
        'e atropelaria a transacao do detentor. O autcom sobe com o TEF habilitado ' +
        '(retorno 0) e a configuracao dele entra na primeira chamada de pinpad, pela ' +
        'reaplicacao de pGarantePinpadConfigurado (que agora acontece mesmo com a impressao ' +
        'digital identica, porque este autcom ainda nao executou o proprio login).',
        [LSessao.FdwPid, LstrQuemDetem]));

      { FstrConfigAplicada/FdwPidConfigAplicada ficam intactos de proposito: a
        DLL continua, de fato, configurada para o detentor. E essa diferenca de
        impressao digital que faz pGarantePinpadConfigurado reaplicar depois. }
      Result := TJSONObject.Create;
      Result.AddPair('valor', TJSONNumber.Create(LintValor));
      Exit;
    end;

    { RF28 (Req. 456190, Passo 7) - a orfa morre AQUI, e nao numa janela de
      ociosidade que nunca chega.

      Este e o unico lugar seguro: a linha seguinte chama fConfiguraTefCitel,
      que repovoa os ponteiros globais das DLLs de terceiro antes de tocar em
      qualquer sessao (fLoadDLLFunctions incondicional,
      untTefCitelNCR.pas:649). Coletar em qualquer outro ponto do login
      deixaria os ponteiros nulos ate a proxima reconfiguracao - e os ~22
      fMetodo* que nao passam por pGarantePinpadConfigurado cairiam neles.
      Foi esse o mecanismo do Access violation em 00000000 de 2026-09-09.

      No ramo ADIADO acima nao se coleta de proposito: adiar significa que
      existe detentor vivo e que NAO vai haver reconfiguracao em seguida. }
    pColetaOrfasAntesDeReconfigurar(LSessao.FdwPid,
      Format('login do pid=%d', [LSessao.FdwPid]));

    { Ponto suspeito de travamento (Req. 456190, 2026-08-24): esta e a chamada
      que entra na DLL nativa do Scope/CliSiTef (fLoadDLLFunctions/deteccao de
      pinpad em untScopeNCR.pas/untTefCitelNCR.pas, arquivos que NAO podem ser
      alterados). Se o processo travar sem excecao, o log deve mostrar a linha
      "Chamando..." sem a linha "retornou" correspondente - confirma que o
      travamento e dentro dessa chamada nativa, nao no roteador/transporte. }
    pLogaEstacao(Format(
      'pid=%d: chamando fConfiguraTefCitel (DLL nativa do Scope/CliSiTef) - ' +
      'enderecoIp="%s", codigoLoja="%s", numTerminal="%s", parametrosAdicionais="%s", somenteCarregarLib=%s...',
      [LSessao.FdwPid,
       LSessao.FstrCfgEnderecoIp, LSessao.FstrCfgCodigoLoja, LSessao.FstrCfgNumTerminal,
       LSessao.FstrCfgParametrosAdicionais, BoolToStr(LSessao.FblnCfgSomenteCarregarLib, True)]));

    LintValor := fTefDaThread.fConfiguraTefCitel(
      PAnsiChar(AnsiString(LSessao.FstrCfgEnderecoIp)),
      PAnsiChar(AnsiString(LSessao.FstrCfgCodigoLoja)),
      PAnsiChar(AnsiString(LSessao.FstrCfgNumTerminal)),
      Smallint(LSessao.FintCfgConfigResultado),
      PAnsiChar(AnsiString(LSessao.FstrCfgParametrosAdicionais)),
      LSessao.FblnCfgSomenteCarregarLib);

    pLogaEstacao(Format('pid=%d: fConfiguraTefCitel retornou %d.',
      [LSessao.FdwPid, LintValor]));

    { Passa a ser o configurador corrente da DLL (Req. 456190, Passo 6) - e isto
      que permite reaplicar depois, quando outro autcom reconfigurar no meio. }
    FstrConfigAplicada := LSessao.fImpressaoDigitalConfig;
    FdwPidConfigAplicada := LSessao.FdwPid;
    LSessao.FblnCfgAplicadaNaInstancia := True; // o login desta instancia rodou de fato
  finally
    FcsPinpad.Leave;
  end;

  Result := TJSONObject.Create;
  Result.AddPair('valor', TJSONNumber.Create(LintValor));
end;

function TTefEstacaoRoteador.fMetodoFPassarCartao(ADados: TJSONObject): TJSONObject;
var
  LRetorno: IRetornoTEFCitel;
begin
  LRetorno := fTefDaThread.fPassarCartao(
    fJsonInt(ADados, 'operacao'),
    fJsonInt(ADados, 'qtdParcelas'),
    fJsonStr(ADados, 'modalidade'),
    fJsonStr(ADados, 'numDoc'),
    fJsonFloat(ADados, 'valor'),
    fJsonStr(ADados, 'codOperador'),
    fJsonBool(ADados, 'pagueFacil'),
    fJsonStr(ADados, 'codigoCarteiraDigital'),
    fJsonStr(ADados, 'jsonInfoAdicPix'));

  Result := TJSONObject.Create;
  Result.AddPair('retorno', fJsonDeIRetornoTEFCitel(LRetorno));
end;

procedure TTefEstacaoRoteador.pMetodoFFinalizarTransacao(ADados: TJSONObject);
begin
  fTefDaThread.fFinalizarTransacao(
    fJsonBool(ADados, 'confirma'),
    AnsiString(fJsonStr(ADados, 'dataStr')),
    AnsiString(fJsonStr(ADados, 'horaStr')),
    AnsiString(fJsonStr(ADados, 'documentoVinculado')),
    AnsiString(fJsonStr(ADados, 'paramAdic')));
end;

function TTefEstacaoRoteador.fMetodoFCancelaTransacaoTerminal(ADados: TJSONObject): TJSONObject;
var
  LRetorno: IRetornoTEFCitel;
begin
  LRetorno := fTefDaThread.fCancelaTransacaoTerminal(
    fJsonInt(ADados, 'funcao'),
    AnsiString(fJsonStr(ADados, 'codOpe')),
    fDataDeJsonStr(fJsonStr(ADados, 'data')),
    fHoraDeJsonStr(fJsonStr(ADados, 'hora')),
    AnsiString(fJsonStr(ADados, 'numDoc')),
    fJsonFloat(ADados, 'valor'),
    fJsonStr(ADados, 'modalidade'),
    fJsonStr(ADados, 'codigoCarteiraDigital'),
    fJsonStr(ADados, 'modoEntrada'));

  Result := TJSONObject.Create;
  Result.AddPair('retorno', fJsonDeIRetornoTEFCitel(LRetorno));
end;

function TTefEstacaoRoteador.fMetodoFReimpressao(ADados: TJSONObject): TJSONObject;
var
  LRetorno: IRetornoTEFCitel;
begin
  LRetorno := fTefDaThread.fReimpressao(
    fJsonInt(ADados, 'funcao'),
    AnsiString(fJsonStr(ADados, 'numDoc')),
    fDataDeJsonStr(fJsonStr(ADados, 'dtaTra')),
    AnsiString(fJsonStr(ADados, 'codOpe')),
    fJsonFloat(ADados, 'valTra'));

  Result := TJSONObject.Create;
  Result.AddPair('retorno', fJsonDeIRetornoTEFCitel(LRetorno));
end;

procedure TTefEstacaoRoteador.pMetodoPSair(ADados: TJSONObject);
begin
  fTefDaThread.pSair(fJsonBool(ADados, 'sair'));
end;

procedure TTefEstacaoRoteador.pMetodoPInfo34(ADados: TJSONObject);
begin
  fTefDaThread.pInfo34(fJsonFloat(ADados, 'valTra'));
end;

procedure TTefEstacaoRoteador.pMetodoPInfo21(ADados: TJSONObject);
begin
  fTefDaThread.pInfo21(fJsonStr(ADados, 'modalidade'));
end;

procedure TTefEstacaoRoteador.pMetodoPInfo30(ADados: TJSONObject);
begin
  fTefDaThread.pInfo30(fJsonStr(ADados, 'numDoc'), fDataDeJsonStr(fJsonStr(ADados, 'data')),
    fJsonInt(ADados, 'qtdParc'));
end;

function TTefEstacaoRoteador.fMetodoFObtemDadoPinPadDireto(ADados: TJSONObject): TJSONObject;
var
  LstrValor: AnsiString;
begin
  LstrValor := fTefDaThread.fObtemDadoPinPadDireto(
    fJsonInt(ADados, 'tipoDocumento'),
    AnsiString(fJsonStr(ADados, 'chaveAcesso')),
    AnsiString(fJsonStr(ADados, 'identificador')));

  Result := TJSONObject.Create;
  Result.AddPair('valor', String(LstrValor));
end;

function TTefEstacaoRoteador.fMetodoFConteudoLogErro(ADados: TJSONObject): TJSONObject;
begin
  { Nao toca o pinpad e nao esta em fMetodoUsaPinpad - de proposito: pode ser
    pedido justamente quando a configuracao falhou, que e quando o operador
    mais precisa ler o log. }
  Result := TJSONObject.Create;
  Result.AddPair('conteudo', fTefDaThread.fConteudoLogErro);
end;

function TTefEstacaoRoteador.fMetodoPRetornaLog(ADados: TJSONObject): TJSONObject;
var
  LLog: TStringList;
  LArr: TJSONArray;
  I: Integer;
begin
  LLog := fTefDaThread.pRetornaLog;
  LArr := TJSONArray.Create;
  if Assigned(LLog) then
    for I := 0 to LLog.Count - 1 do
      LArr.AddElement(TJSONString.Create(LLog[I]));

  Result := TJSONObject.Create;
  Result.AddPair('linhas', LArr);
end;

procedure TTefEstacaoRoteador.pMetodoPInfo30DebitoPreDatado(ADados: TJSONObject);
begin
  fTefDaThread.pInfo30DebitoPreDatado(fDataDeJsonStr(fJsonStr(ADados, 'dataPre')));
end;

procedure TTefEstacaoRoteador.pMetodoPInfo30DebitoCredito1Minuto(ADados: TJSONObject);
begin
  fTefDaThread.pInfo30DebitoCredito1Minuto(fJsonInt(ADados, 'parcelaCdc'));
end;

procedure TTefEstacaoRoteador.pMetodoPInfo30DebitoParcelado(ADados: TJSONObject);
begin
  fTefDaThread.pInfo30DebitoParcelado(
    fJsonInt(ADados, 'qtdParc'),
    fJsonInt(ADados, 'intervaloParc'),
    fJsonInt(ADados, 'primParcAvista'),
    fDataDeJsonStr(fJsonStr(ADados, 'primParcela')));
end;

function TTefEstacaoRoteador.fMetodoFVerificaPresencaPinPad(ADados: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('status', TJSONNumber.Create(Ord(fTefDaThread.fVerificaPresencaPinPad)));
end;

function TTefEstacaoRoteador.fMetodoFObtemVersao(ADados: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('valor', fTefDaThread.fObtemVersao);
end;

function TTefEstacaoRoteador.fMetodoFInfoPixCadastro(ADados: TJSONObject): TJSONObject;
var
  LArrInfo: TArrayInfoPix;
  LintValor: Longint;
  LArr: TJSONArray;
  LItem: TJSONObject;
  I: Integer;
begin
  LintValor := fTefDaThread.fInfoPixCadastro(LArrInfo);

  LArr := TJSONArray.Create;
  for I := 0 to Length(LArrInfo) - 1 do
  begin
    LItem := TJSONObject.Create;
    LItem.AddPair('codigoRede', LArrInfo[I].CodigoRede);
    LItem.AddPair('nomeRede', LArrInfo[I].NomeRede);
    LItem.AddPair('codigoBandeira', LArrInfo[I].CodigoBandeira);
    LItem.AddPair('nomeBandeira', LArrInfo[I].NomeBandeira);
    LArr.AddElement(LItem);
  end;

  Result := TJSONObject.Create;
  Result.AddPair('valor', TJSONNumber.Create(LintValor));
  Result.AddPair('lista', LArr);
end;

procedure TTefEstacaoRoteador.pMetodoPEnviarQrCode(ADados: TJSONObject);
var
  LstrBase64, LstrArquivo, LstrDiretorio, LstrCaminho: String;
  LbytConteudo: TBytes;
begin
  { QR-CODE PIX PELO CANAL (Req. 456190, 2026-09-12) - ver o comentario longo
    em TTefCitelDvc.pEnviarQrCode. Resumo: o PNG e gerado no autcom (VCL +
    DevExpress, impossivel aqui dentro) e chega em base64; a DLL do Scope le
    IMAGEM DO DISCO, entao aqui se grava um temporario local e se chama a
    mesma nativa de sempre. }
  LstrBase64 := fJsonStr(ADados, 'conteudoBase64');

  if LstrBase64 = '' then
  begin
    { Compatibilidade com autcom anterior a 12/09, que mandava o CAMINHO. So
      funciona se autcom e estacao forem a mesma maquina - ou seja, nunca no
      cenario DVC de verdade. Fica para um rollout desencontrado nao virar
      falha silenciosa e sim o comportamento antigo. }
    pLogaEstacaoNivel(TEF_LOG_NIVEL_NORMAL,
      'pEnviarQrCode: chegou SEM conteudoBase64 - autcom desatualizado. ' +
      'Tentando pelo caminho, que so funciona se o autcom estiver nesta maquina.');
    fTefDaThread.pEnviarQrCode(fJsonStr(ADados, 'diretorio'), fJsonStr(ADados, 'arquivo'));
    Exit;
  end;

  { ExtractFileName no nome que veio do outro lado: o campo e dado de rede e
    um "..\..\algo.exe" gravaria fora da pasta de trabalho. O nome nao e usado
    para nada alem de identificar o arquivo temporario. }
  LstrArquivo := ExtractFileName(Trim(fJsonStr(ADados, 'arquivo')));
  if LstrArquivo = '' then
    LstrArquivo := 'qrpix.png';

  { Ao lado do exe do servico, mesmo idioma da FilaTef (untTefEstacaoServiceMain).
    Nao em %TEMP%: o servico roda como LocalSystem e %TEMP% dele e candidato a
    Limpeza de Disco - e o Scope precisa do arquivo no instante da carga. }
  LstrDiretorio := IncludeTrailingPathDelimiter(
    TPath.Combine(ExtractFilePath(ParamStr(0)), 'TempQr'));
  if not TDirectory.Exists(LstrDiretorio) then
    TDirectory.CreateDirectory(LstrDiretorio);

  LstrCaminho := LstrDiretorio + LstrArquivo;
  LbytConteudo := TNetEncoding.Base64.DecodeStringToBytes(LstrBase64);
  TFile.WriteAllBytes(LstrCaminho, LbytConteudo);

  pLogaEstacaoNivel(TEF_LOG_NIVEL_DIAGNOSTICO, Format(
    'pEnviarQrCode: %d bytes de PNG gravados em "%s" - carregando no pinpad.',
    [Length(LbytConteudo), LstrCaminho]));

  try
    fTefDaThread.pEnviarQrCode(LstrDiretorio, LstrArquivo);
  finally
    { A nativa apaga o arquivo depois de carregar. Este finally cobre o caminho
      de erro, em que ela nem chega la - sem ele a pasta acumularia um PNG por
      falha, sem ninguem para limpar. }
    if TFile.Exists(LstrCaminho) then
      TFile.Delete(LstrCaminho);
  end;
end;

procedure TTefEstacaoRoteador.pMetodoPLimpaQrCode(ADados: TJSONObject);
begin
  fTefDaThread.pLimpaQrCode(AnsiString(fJsonStr(ADados, 'mensagem')));
end;

function TTefEstacaoRoteador.fMetodoFTraduzirErro(ADados: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('valor', (fTefDaThread as ITefCitelV2).fTraduzirErro(fJsonInt(ADados, 'sts')));
end;

{ Req. 456497 (r496193): le do pinpad os seis atributos que alimentam o
  TFT_PINPAD da TEFTRA. Chega ao pinpad fisico, entao esta em fMetodoUsaPinpad
  - diferente do fTraduzirErro acima, que e tabela estatica. }
function TTefEstacaoRoteador.fMetodoFObtemInfoPinPad(ADados: TJSONObject): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('valor', (fTefDaThread as ITefCitelV2).fObtemInfoPinPad);
end;

function TTefEstacaoRoteador.fEstacaoOciosa(out AstrMotivo: String): Boolean;
var
  LintOutrosDespachos: Integer;
  LstrQuem: String;
begin
  AstrMotivo := '';

  { 1 - ha despacho dentro da DLL nativa AGORA?

    O indicador exato e FdictConexaoPorThread.Count, e a regra de 2026-09-11
    manda consultar, nao presumir. Mas aqui ele e lido DESCONTANDO A THREAD
    CORRENTE, e este desconto e o ponto que engana: pDespachaChamadaEmThreadPropria
    registra TODA chamada neste dicionario, inclusive o proprio fAtuAplica
    que esta perguntando. Comparar com zero daria False sempre e a
    atualizacao nunca aconteceria - sem erro nenhum no log, so um
    "estacao ocupada" eterno. }
  FcsThreads.Enter;
  try
    LintOutrosDespachos := FdictConexaoPorThread.Count;
    if FdictConexaoPorThread.ContainsKey(GetCurrentThreadId) then
      Dec(LintOutrosDespachos);
  finally
    FcsThreads.Leave;
  end;

  if LintOutrosDespachos > 0 then
  begin
    AstrMotivo := Format('ha %d despacho(s) dentro da DLL nativa neste momento',
      [LintOutrosDespachos]);
    Exit(False);
  end;

  { 2 e 3 - transacao EM VOO de outro autcom (RF17 item 1) e transacao
    PENDENTE DE CONFIRMACAO (item 2). fOutroAutcomDetemPinpad ja cobre as
    duas e devolve a descricao pronta para o log.

    O pid passado e High(DWORD) porque aqui nenhum autcom pode ser isentado.
    Passar 0 seria erro sutil: 0 e o default de fJsonInt(contexto,'pid'), ou
    seja o pid de uma sessao de autcom anterior a Fase 3.5 - e ela sairia
    isenta justamente da checagem. Pid real nunca vale $FFFFFFFF. }
  if fOutroAutcomDetemPinpad(High(DWORD), LstrQuem) then
  begin
    AstrMotivo := LstrQuem;
    Exit(False);
  end;

  Result := True;
end;

function TTefEstacaoRoteador.fMetodoFAtuConsulta(ADados: TJSONObject): TJSONObject;
var
  LObjAplicado, LObjPreparado: TJSONObject;
  LstrPacote, LstrMotivo: String;
  LblnOciosa: Boolean;
begin
  LblnOciosa := fEstacaoOciosa(LstrMotivo);

  LObjAplicado := TJSONObject.Create;
  LObjPreparado := TJSONObject.Create;
  for LstrPacote in fTodosOsPacotes do
  begin
    LObjAplicado.AddPair(LstrPacote, FAtualizacao.fHashAplicado(LstrPacote));
    LObjPreparado.AddPair(LstrPacote, FAtualizacao.fHashPreparado(LstrPacote));
  end;

  Result := TJSONObject.Create;
  Result.AddPair('dirServico',
    ExcludeTrailingPathDelimiter(FAtualizacao.strDirServico));

  { O diretorio do servico no momento da ULTIMA aplicacao. Se ele divergir
    do de cima, o autcom reenvia os .ini mesmo com hash igual (RN19): o hash
    de origem nao muda quando o servico muda de pasta, e os caminhos dentro
    do .ini ficariam apontando para onde ele nao esta mais. }
  Result.AddPair('dirServicoAplicado', FAtualizacao.fDirServicoAplicado);
  Result.AddPair('ociosa', TJSONBool.Create(LblnOciosa));
  Result.AddPair('motivoOcupada', LstrMotivo);
  Result.AddPair('aplicado', LObjAplicado);
  Result.AddPair('preparado', LObjPreparado);

  { Identidade desta execucao do servico (RF29), na resposta de TODA
    consulta - e nao so no "reata" (achado de campo 2026-09-16).

    O "reata" nao serve para quem espera o reinicio da atualizacao: ele so
    e enviado quando o CANAL DVC cai, e no reinicio o canal nao cai. Quem
    cai e o socket plugin->servico, que o plugin reconecta sozinho e em
    silencio - do lado do autcom nada acontece. No log da bateria de 16/09
    isso aparece limpo: houve reinicio do servico as 08:36:16 e nenhum
    "reata"; os dois do dia foram da reconexao de sessao RDP, as 08:24.

    Com a instancia aqui, o fEsperaServicoVoltar compara sem depender de
    evento nenhum: se mudou, o processo e outro. }
  Result.AddPair('instanciaServico', FstrInstanciaServico);
end;

{ Nome do metodo no FIO continua "pAtuAbre" - o prefixo f aqui e do handler,
  que passou a DEVOLVER resposta (achado de campo 2026-09-17, caso B.1).

  Compativel nos dois sentidos, de proposito: autcom antigo ignora a resposta
  e se comporta como sempre; autcom novo contra estacao antiga nao recebe
  "aberto" nenhum e assume True por default, que e o comportamento de hoje.
  Nenhuma das duas pontas precisa subir junto com a outra. }
function TTefEstacaoRoteador.fMetodoPAtuAbre(ADados: TJSONObject): TJSONObject;
var
  LblnAberto: Boolean;
  LstrMotivo: String;
begin
  FAtualizacao.pAbre(fJsonStr(ADados, 'pacote'), fJsonStr(ADados, 'arquivo'),
    fJsonStr(ADados, 'hash'), fJsonInt(ADados, 'tamanho', 0),
    DWORD(fJsonInt(ADados, 'pid', 0)), LblnAberto, LstrMotivo);

  Result := TJSONObject.Create;
  Result.AddPair('aberto', TJSONBool.Create(LblnAberto));
  Result.AddPair('motivo', LstrMotivo);
end;

procedure TTefEstacaoRoteador.pMetodoPAtuParte(ADados: TJSONObject);
begin
  { seq com default -1 de proposito: ausente e diferente de zero, e a guarda
    de ordem de pParte precisa recusar o ausente em vez de trata-lo como a
    primeira parte. }
  FAtualizacao.pParte(fJsonStr(ADados, 'pacote'), fJsonInt(ADados, 'seq', -1),
    fJsonStr(ADados, 'conteudoBase64'));
end;

function TTefEstacaoRoteador.fMetodoFAtuFecha(ADados: TJSONObject): TJSONObject;
var
  LstrErro: String;
  LblnOk: Boolean;
begin
  LblnOk := FAtualizacao.fFecha(fJsonStr(ADados, 'pacote'), LstrErro);
  Result := TJSONObject.Create;
  Result.AddPair('ok', TJSONBool.Create(LblnOk));
  Result.AddPair('erro', LstrErro);
end;

function TTefEstacaoRoteador.fMetodoFAtuAplica(ADados: TJSONObject): TJSONObject;
var
  LstrMotivo: String;
begin
  Result := TJSONObject.Create;

  if not FAtualizacao.fTemPreparo then
  begin
    pLogaEstacao('fAtuAplica: nao ha pacote preparado - nada a aplicar.');
    Result.AddPair('aplicado', TJSONBool.Create(False));
    Result.AddPair('reiniciando', TJSONBool.Create(False));
    Result.AddPair('motivo', 'nao ha pacote preparado');
    Exit;
  end;

  if not fEstacaoOciosa(LstrMotivo) then
  begin
    { RN20: o preparo fica exatamente onde esta. A proxima carga de autcom
      encontra tudo transferido e conferido, e aplica em segundos sem
      mandar um byte pelo canal. }
    pLogaEstacao(Format(
      'fAtuAplica: RECUSADO por ocupacao - %s. O preparo continua em "%s" e a ' +
      'proxima carga de autcom aplica, sem transferir nada de novo.',
      [LstrMotivo, TEF_ATU_DIR_PREPARO]));
    Result.AddPair('aplicado', TJSONBool.Create(False));
    Result.AddPair('reiniciando', TJSONBool.Create(False));
    Result.AddPair('motivo', LstrMotivo);
    Exit;
  end;

  { A partir daqui nada mais e decidido aqui. O servico NAO troca arquivo
    nenhum: quem aplica e o TefEstacaoAtualizador.exe, com este servico
    PARADO - e so com ele parado o proprio TefEstacaoService.exe pode ser
    trocado, porque executavel em uso nao pode ser sobrescrito.

    A separacao existe por antivirus (decisao do Rafael, 2026-09-15): se o
    AV barrar o servico, a loja fica sem TEF; se barrar o atualizador, so a
    atualizacao para. Ver o cabecalho de untTefEstacaoAtualizacao.pas. }
  FAtualizacao.pMarcaPendente;

  { Daqui em diante o reinicio VAI acontecer - mas nao a partir daqui. Ver o
    comentario de FblnReiniciarAposResposta: a resposta precisa sair antes, e
    esta thread precisa deixar o FdictConexaoPorThread antes, senao o
    pParaComSeguranca espera por ela mesma ate o teto. }
  FblnReiniciarAposResposta := True;

  pLogaEstacao(
    'fAtuAplica: estacao OCIOSA e preparo pronto - respondendo ao autcom e ' +
    'reiniciando o servico logo em seguida. O autcom espera o servico voltar ' +
    'antes de seguir para o login.');

  Result.AddPair('aplicado', TJSONBool.Create(True));
  Result.AddPair('reiniciando', TJSONBool.Create(True));
  Result.AddPair('motivo', '');
end;

end.
