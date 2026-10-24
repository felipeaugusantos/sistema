unit untTefCitelDvc;

(* Implementacao de ITefCitel/ISubjectTEFCitel/ITefCitelV2 que substitui a
  execucao fisica local do TEF por chamadas RPC pelo canal RDP DVC, entregues
  ao servico Windows da estacao (Req. 456190, RF06).

  Cada metodo da interface e enviado como uma chamada RPC ("chamada") e
  aguarda a "resposta" correspondente. Os callbacks Antes*/Depois*/
  SucessoTefCartao e o mecanismo de Observer nunca sao serializados - ficam
  guardados localmente aqui e sao acionados quando a estacao envia um sinal
  de "hook" (sincrono) ou "evento" (Observer) pelo mesmo canal, mesmo com uma
  chamada RPC ainda pendente (por isso a leitura do canal, em
  untTefCitelDvcTransporte, roda numa thread dedicada e nunca bloqueia
  esperando uma resposta especifica).

  fConsultaTransacoesPendentesTerminal nao e usada pelo projeto (confirmado
  no levantamento do Req. 456190) e fica como stub "nao suportado".

  Protocolo (envelope JSON, framing por tamanho feito em
  untTefCitelDvcTransporte):
    chamada       (AUTCOM -> estacao)  {v, id, tipo:'chamada', metodo, dados, contexto}
    resposta      (estacao -> AUTCOM)  {v, id, tipo:'resposta', ok, erro?, result?}
    evento        (estacao -> AUTCOM)  {v, id, tipo:'evento', dados:{retorno}}
    hook          (estacao -> AUTCOM)  {v, id, tipo:'hook', hook, dados}
    hook_resposta (AUTCOM -> estacao)  {v, id, tipo:'hook_resposta', dados, contexto}

  "contexto" viaja em toda chamada/hook_resposta para que a estacao nao
  precise de um handshake separado: opcao/path (qual ITefCitel real
  instanciar, via fCriarTefCitel compartilhada), tefInfo (AddInfo) e
  dadosAdicionaisTefTra (pSetDadosAdicionaisTefTra) - sempre o valor mais
  recente, sem depender de ordem de chamadas anteriores. *)

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, System.SyncObjs, System.JSON,
  System.Generics.Collections, System.IOUtils, System.NetEncoding,
  UniClientDataSet, Vcl.Forms,
  untInterfaceTefCitel, untTefCitelComum, untTefCitelIntervalos,
  untTefCitelDvcTransporte;

type
  ETefCitelDvcRpc = class(Exception);
  { Queda de canal, separada das outras falhas de RPC (Req. 456190,
    2026-09-09). Existe para ser CAPTURADA nos metodos de transacao: queda de
    canal virou um desfecho conhecido - a estacao aborta a transacao no pinpad
    (pOnDesconectado) - e nao pode subir como excecao para a tela, porque
    (a) o operador via o dialogo do madExcept, e (b) subindo por cima do
    "if Assigned(FDepois...)" ela deixava a trava LCKATC presa. Erro real de
    RPC continua sendo ETefCitelDvcRpc e continua subindo. }
  ETefCitelDvcCanal = class(ETefCitelDvcRpc);
  { O quadro saiu no canal e o SERVICO da estacao nunca confirmou - ver o
    comentario extenso em fChamaRpcUmaVez (Req. 456190, 2026-09-12).

    DESCENDE DE ETefCitelDvcCanal, e isso nao e detalhe de hierarquia
    (corrigido em 2026-09-14, achado na bateria do dia). Nasceu irma e o
    resultado foi exatamente o que o comentario acima previa: os quatro
    handlers dos metodos de transacao capturam ETefCitelDvcCanal, a irma
    passou batido, o operador levou o dialogo do madExcept na cara e - pior,
    porque ninguem ve - a trava LCKATC ficou presa, porque a excecao subiu
    por cima do "if Assigned(FDepois...)" que a libera.

    Ser filha e o certo pelo CONTEUDO, nao so pela conveniencia: os dois
    casos tem o mesmo desfecho operacional - nada esta em curso no pinpad, a
    tela precisa de negativa e a trava precisa ser liberada. O que muda e so
    o TEXTO, e disso cuida pNotificaCanalCaiu.

    fConfiguraTefCitel continua SEM except (conferido), entao o login segue
    levantando e a degradacao da carga em untTefCitelUtil.pas nao muda. }
  ETefCitelDvcServicoIndisponivel = class(ETefCitelDvcCanal);
  { A estacao nao conhece o login do TEF deste autcom (RF29, Req. 456190,
    item 3 do Passo 8 da Fase 5). Chega com motivo="loginNecessario" no
    envelope - nao por comparacao de texto de mensagem.

    Existe porque a deteccao original da RF29 tem uma lacuna: o gatilho
    escolhido foi a resposta do "reata", que so acontece quando o CANAL DVC
    cai. Num reinicio PURO do servico o canal NAO cai - o plugin reconecta
    o socket sozinho (pLoopConectorELeitura) sem tocar no canal - e o autcom
    nunca compara a instancia nova. fChamaRpc captura esta classe, refaz o
    login e repete a chamada uma vez; se a repeticao voltar igual, a excecao
    sobe com a mensagem acionavel da estacao e o operador refaz, como antes. }
  ETefCitelDvcLoginNecessario = class(ETefCitelDvcRpc);

  { Recusa CONTESTAVEL vinda da estacao (Req. 456190, RF27, Passo 6). Nunca
    chega a tela: e capturada dentro do proprio fChamaRpc, que resolve a
    disputa e repete a chamada. Carrega os fatos que a estacao apurou sobre o
    detentor do pinpad. }
  ETefCitelDvcPinpadContestavel = class(ETefCitelDvcRpc)
  public
    FdwPidDetentor: DWORD;
    FstrInicioProcessoDetentor: String;
    FstrTerminalDetentor: String;
    FblnConexaoVivaDetentor: Boolean;
  end;

  { Pergunta ao operador, exigida pela RN16 antes de tomar o pinpad de um
    AUTCOM que nao respondeu a sonda de vivacidade.

    Mora no HOST e nao aqui porque a libTefCitel.dll nao linka libFuncoes -
    ela nao enxerga o fMensagem do projeto, e um dialogo VCL cru nao teria a
    cara das outras mensagens do TEF. O host registra a funcao por
    pSetConfirmaTomadaPinpadTef (untFuncoesLibTefCitel.pas), logo antes de
    criar a instancia; enquanto ninguem registrar, a disputa simplesmente nao
    pergunta e a recusa segue como sempre foi - degradacao segura, nao erro.

    Devolve True quando o operador autoriza assumir o pinpad. }
  TfuncConfirmaTomadaPinpadTef = function(const AstrMensagem: String): Boolean; stdcall;

var
  VS_funcConfirmaTomadaPinpadTef: TfuncConfirmaTomadaPinpadTef = nil;
  { True depois que o host chamou pSetThreadPrincipalHost - so para o
    diagnostico de thread de fChamaRpcUmaVez dizer QUEM definiu o
    MainThreadID. }
  VS_blnThreadPrincipalHostAcertada: Boolean = False;

type

  TTefCitelDvc = class(TInterfacedObject, ITefCitel, ISubjectTEFCitel, ITefCitelV2,
    ITefCitelFinalizacao)
  private
    FstrOpcao: String;
    FstrPath: String;

    { Identidade deste autcom.exe no protocolo (Req. 456190, Fase 3.5) - viaja
      no "contexto" de toda chamada/hook_resposta. Varios autcom.exe rodam na
      MESMA sessao TS da estacao, compartilhando um unico pinpad fisico: o
      servico da estacao mantem uma instancia ITefCitel POR PID e serializa o
      pinpad entre elas, em vez de uma instancia unica compartilhada (que
      misturava configuracao de empresa/terminal entre os autcom - ver
      IA\specs\456190\specs.md, secao 9).
      Todos os autcom.exe rodam no mesmo servidor, entao o PID ja e unico
      entre eles; FdwSessao e informativo, so aparece no log da estacao. }
    FdwPid: DWORD;
    FdwSessao: DWORD;
    { Identidade da INSTANCIA do processo (Req. 456190, RF23, Fase 5). O pid
      sozinho nao identifica processo: o Windows reusa numero, e a estacao
      passou a guardar a sessao entre quedas de conexao (RF24) - sem isto um
      autcom.exe novo que caisse no mesmo pid herdaria a sessao do anterior,
      com a loja/terminal de OUTRA empresa. E a mesma classe do bug de campo
      de 2026-09-04 (transacao do terminal 003 registrada no 004).

      Vai como string decimal do creation time do proprio processo
      (GetProcessTimes): valor estavel enquanto o processo vive, diferente
      quando ele reinicia, e sem precisar gerar nem guardar token nenhum.
      String, e nao numero, para nao depender de um leitor de Int64 no JSON -
      a estacao so compara. Vazia quando o GetProcessTimes falha: a estacao
      trata igual a um autcom anterior a esta versao. }
    FstrInicioProcesso: String;
    { Identidade da instancia do servico da estacao vista por ultimo
      (Req. 456190, RF29). Chega na resposta do "reata"; se mudar, o servico
      reiniciou e a sessao Scope daquela transacao morreu com o processo
      anterior - o TEF deste autcom precisa ser refeito. Vazia enquanto
      nenhum "reata" foi respondido. }
    FstrInstanciaServico: String;

    { Argumentos do proprio login, guardados para poder REFAZER o TEF quando o
      servico da estacao reiniciar (Req. 456190, RF29, Passo 7).

      Mesmo padrao que a estacao ja usa nos FstrCfg* da sessao para o login
      adiado da RF17 item 4 - e guardar aqui e o que evita um export novo na
      libTefCitel.dll so para avisar o host. Export novo chamado por exe novo
      contra DLL antiga foi exatamente o acoplamento de versao que o Passo 6
      criou sem perceber (pSetConfirmaTomadaPinpadTef); nao vale repetir. }
    FblnCfgGuardada: Boolean;
    FstrCfgEnderecoIp: String;
    FstrCfgCodigoLoja: String;
    FstrCfgNumTerminal: String;
    FintCfgConfigResultado: Smallint;
    FstrCfgParametrosAdicionais: String;
    FblnCfgSomenteCarregarLib: Boolean;

    { "O servico da estacao reiniciou desde a ultima conexao" (RF29).

      Integer e nao Boolean porque e escrito na thread de leitura do canal
      (pTrataReataResposta) e lido/consumido na thread do chamador
      (fChamaRpc) - InterlockedExchange resolve sem precisar de mais um lock
      nesta unit, que ja tem quatro. Os FstrCfg* acima nao cruzam thread: sao
      escritos e lidos so na thread do chamador. }
    FintServicoReiniciou: Integer;
    { Guarda de reentrancia do re-login: fChamaRpc chama fChamaRpcUmaVez para
      refazer o login e nao pode entrar nele de novo por dentro. }
    FblnRelogando: Boolean;
    { Re-logins feitos por pRefazTefSeServicoReiniciou (Req. 470363). So na
      thread do chamador, como os FstrCfg*. }
    FintQtdRelogins: Integer;
    { Documento -> FintQtdRelogins no momento da aprovacao (fPassarCartao).
      Mudou ate a finalizacao = a sessao Scope que tinha a transacao morreu,
      mesmo que o re-login tenha sido feito por OUTRA chamada (ex.: a
      autoconfirmacao). Protegido por FcsMetodosEmAndamento. }
    FdictGeracaoAprovacao: TDictionary<String, Integer>;
    FblnFinalizacaoNaoRealizada: Boolean;
    FblnFinalizacaoSeraReenviada: Boolean;
    { Confirmacao que nao chegou a estacao por queda de canal, a reenviar
      (Req. 470363) - argumentos da fFinalizarTransacao original. }
    FblnReenviarFinalizacao: Boolean;
    FintReenviandoFinalizacao: Integer;
    FblnReenvioConfirma: Boolean;
    FstrReenvioData: String;
    FstrReenvioHora: String;
    FstrReenvioDocumento: String;
    FstrReenvioParamAdic: String;
    FstrReenvioDescricao: String;
    { Aviso do reenvio descartado - entregue por pRefazTefSeServicoReiniciou
      no lugar do aviso generico de reinicio. }
    FstrAvisoReenvioDescartado: String;
    FstrAvisoReinicioGuardado: String;

    { Veredito de disputa a mandar no PROXIMO envelope (Req. 456190, RF27,
      Passo 6) - preenchido por fResolveDisputaPinpad.

      CORRIGIDO em 2026-09-10 (item 5 do Passo 8): este comentario dizia
      "uso unico", e nao e. pLimpaVereditoDisputa roda no FINALLY de
      fChamaRpc, entao o escopo real e "limpo no fim da chamada EXTERNA" -
      uma chamada aninhada (pInfo21 dentro de fPassarCartao, o padrao da
      Modalidade Dinamica) roda dentro daquele finally e CARREGA o veredito
      no proprio contexto.

      Na pratica e inerte: o fTomadaAutorizada da estacao casa o par (pid,
      inicioProcesso) do veredito com o detentor do momento, entao um
      veredito carregado a mais nao autoriza tomada de mais ninguem. A
      intencao do desenho continua valendo (um veredito autoriza UMA tomada
      e nao deve ficar grudado no contexto) - o que nao vale e afirmar que o
      codigo garante isso por si. Quem for construir alguma garantia sobre
      este campo precisa ler o finally de fChamaRpc primeiro. }
    FdwPidDisputa: DWORD;
    FstrInicioProcessoDisputa: String;
    FblnDisputaProcessoMorto: Boolean;
    FblnDisputaConfirmadaPeloOperador: Boolean;
    FTefInfo: TTefInfo;
    FobjDadosAdicionaisTefTra: IDadosAdicionaisTefTra;

    FTransporte: TTefCitelDvcTransporte;
    FcsChamadas: TCriticalSection;
    FdictChamadas: TObjectDictionary<Integer, TObject>;
    FintProximoId: Integer;

    { guard contra clique duplo/repetido - ver comentario em fChamaRpc }
    FcsMetodosEmAndamento: TCriticalSection;
    FdictMetodosEmAndamento: TDictionary<String, Boolean>;

    FObservers: TList<IObserverTEFCitel>;
    { Rede de seguranca do bug de evento atrasado (Req. 456190, 2026-09-03 -
      ver comentario completo em fChamaRpc e pTrataEvento): incrementa a cada
      troca de observer (uma tela de TEF fechando e outra abrindo). Um evento
      enfileirado numa geracao e descartado se rodar em outra - garante que a
      mensagem de uma transacao NUNCA apareca na tela da transacao seguinte,
      mesmo que a drenagem final do fChamaRpc nao tenha alcancado ele. }
    FintGeracaoObservers: Integer;
    { Aviso que nao tinha tela para receber, guardado para a proxima
      (Req. 456190, achado de campo 2026-09-11 - ver pAvisaOperadorOuGuarda).
      Vazio = nada pendente. A secao critica e propria e so cobre esta
      string: NAO virar lock em volta do FObservers nem da ITefCitel. }
    FstrAvisoGuardado: String;
    FcsAviso: TCriticalSection;
    FRetorno: IRetornoTEFCitel;
    FLog: TStringList;

    FAntesPassarCartao: TAntesTefCartaoEvent;
    FDepoisPassarCartao: TDepoisTefCartaoEvent;
    FDepoisFinalizarTransacao: TDepoisFinalizarTransacaoEvent;
    FAntesCancelarTransacao: TAntesTefCartaoEvent;
    FDepoisCancelarTransacao: TDepoisTefCartaoEvent;
    FAntesReimpressao: TAntesTefCartaoEvent;
    FDepoisReimpressao: TDepoisTefCartaoEvent;
    FSucessoTefCartao: TSucessoTefCartaoEvent;
    FProcLogErr: TprocGravaLogErr;

    procedure pOnFrameRecebido(const AbytFrame: TBytes);
    procedure pOnDesconectado;
    { Passo 3 (RF26). pOnConectado roda na thread de LEITURA do transporte,
      entao ele so despacha uma thread curta - quem escreve no canal e
      pEnviaReata, de fora dela. }
    procedure pOnConectado;
    { AdwAtrasoPartidaMs: quantos ms a thread anonima levou entre o .Start
      em pOnConectado e a sua PRIMEIRA instrucao (item 3 do Passo 8). }
    procedure pEnviaReata(const AdwAtrasoPartidaMs: DWORD);
    procedure pTrataReataResposta(AJson: TJSONObject);
    procedure pTrataResposta(AJson: TJSONObject);
    procedure pTrataEvento(AJson: TJSONObject);
    procedure pTrataHook(AJson: TJSONObject);
    procedure pNotifica(ARetorno: IRetornoTEFCitel);
    { Avisa a tela, pelo caminho que ela ja conhece, que a comunicacao caiu e
      a transacao foi cancelada (Req. 456190, 2026-09-09). }
    { AExcecao decide o TEXTO: servico parado e queda de canal sao desfechos
      diferentes para o operador, ainda que o tratamento seja o mesmo. }
    procedure pNotificaCanalCaiu(const AstrMetodo: String; AExcecao: Exception);
    { Mesmo caminho, texto livre: entrega uma NEGATIVA a tela como status
      "500", que e a forma que a estacao ja usa em pEnviaEventoNegado. }
    procedure pNotificaNegativa(const AstrMensagem: String);
    procedure pTrataQuedaEmChamadaAninhada(const AstrMetodo: String; AExcecao: ETefCitelDvcCanal);
    { Igual ao anterior, mas nao perde o aviso quando NAO ha tela aberta:
      guarda e entrega no proximo AdicionaObserver. }
    procedure pAvisaOperadorOuGuarda(const AstrMensagem: String);
    procedure pDespachaAvisoGuardado;
    { RF29 - refaz o login do TEF quando o servico da estacao reiniciou.
      Chamado no topo de fChamaRpc, antes de qualquer contabilidade de voo. }
    procedure pRefazTefSeServicoReiniciou(const AstrMetodo: String);
    procedure pReenviaFinalizacaoPendente;
    procedure pDescartaReenvioFinalizacao;
    function fSessaoDaAprovacaoMorreu(const AstrDocumento: String): Boolean;
    { Resolve TODA chamada pendente como "o canal caiu" e devolve quantas
      eram. Dois eventos diferentes chegam aqui e pedem o mesmo desfecho. }
    function fMataChamadasPendentes: Integer;

    function fJsonContexto: TJSONObject;
    { fEnviaEnvelope devolve False quando o servico da estacao nao confirmou a
      entrega. pEnviaEnvelope e a casca para quem nao precisa saber. }
    function fEnviaEnvelope(const AstrTipo: String; const AintId: Integer;
      const AstrMetodo: String; ADados: TJSONObject): Boolean;
    procedure pEnviaEnvelope(const AstrTipo: String; const AintId: Integer;
      const AstrMetodo: String; ADados: TJSONObject);
    function fChamaRpc(const AstrMetodo: String; ADados: TJSONObject): TJSONObject;
    { O RPC propriamente dito. fChamaRpc virou a casca que trata a disputa do
      pinpad e repete a chamada (Req. 456190, RF27, Passo 6). }
    function fChamaRpcUmaVez(const AstrMetodo: String; ADados: TJSONObject): TJSONObject;
    function fResolveDisputaPinpad(AErro: ETefCitelDvcPinpadContestavel;
      const AstrMetodo: String; out AstrNegativa: String): Boolean;
    procedure pLimpaVereditoDisputa;
  public
    constructor Create(const AstrOpcao: String);
    destructor Destroy; override;

    { Porta de entrada do RPC para untTefCitelDvcAtualizacao (Req. 456190,
      Fase 6).

      Vai direto em fChamaRpcUmaVez, e NAO em fChamaRpc, de proposito: a
      casca do fChamaRpc existe para a disputa de pinpad (RF27) e para o
      re-login da RF29, e nenhuma das duas cabe aqui - os metodos de
      atualizacao nao encostam no pinpad e rodam ANTES do login. Passar por
      ela so acrescentaria caminhos que nao podem acontecer.

      ADados e CONSUMIDO, como em toda chamada de fChamaRpcUmaVez. }
    function fChamaRpcAtualizacao(const AstrMetodo: String;
      ADados: TJSONObject): TJSONObject;

    { Avisa o transporte de que a estacao vai reiniciar agora, para ele nao
      descartar como duplicata a resposta do servico NOVO (Req. 456190,
      achado de campo 2026-09-16). Justificativa completa em
      TTefCitelDvcTransporte.pAgendaZeraDedupPorReinicioDaEstacao. }
    procedure pPreparaReinicioDaEstacao;

    { ITefCitel }
    function fConfiguraTefCitel(strEnderecoIp: PAnsiChar;
                                strCodigoLoja: PAnsiChar;
                                strNumTerminal: PAnsiChar;
                                strConfigResultado: Smallint;
                                strParametrosAdicionais: PAnsiChar;
                                blnSomenteCarregarLib: Boolean = False) : Integer;

    function fPassarCartao(intOperacao: Integer;
                           intQtdParcelas: Integer;
                           strModalidade: String;
                           strNumDoc: String;
                           fltValor: Double;
                           strCodOperador: String;
                           blnPagueFacil : Boolean;
                           strCodigoCarteiraDigital : string = '';
                           strJsonInfoAdicPix: String = '') : IRetornoTEFCitel;

    procedure fFinalizarTransacao(Confirma: Boolean;
                                  DataStr,
                                  HoraStr,
                                  DocumentoVinculado,
                                  ParamAdic: AnsiString);

    function fCancelaTransacaoTerminal(intFuncao: Integer;
                                       strCodOpe: AnsiString;
                                         dtaData: TDate;
                                         hraHora: TTime;
                                          numdoc: AnsiString;
                                        fltValor: Double;
                                   strModalidade: String;
                                   strCodigoCarteiraDigital : string;
                                   strModoEntrada: string) : IRetornoTEFCitel;

    function fConsultaTransacoesPendentesTerminal : TUniClientDataSet;

    function fReimpressao(intFuncao: Integer;
                          strNumDoc: AnsiString;
                          strDtaTra: TDate;
                          strCodOpe: AnsiString;
                          fltValTra: Double) : IRetornoTEFCitel;

    procedure pSair(blnSair : Boolean);

  	procedure pInfo34(fltValTra : Double);
    procedure pInfo21(strModalidade : String);
    procedure pInfo30(strNumDoc : String; dtaData : TDate; intQtdParc : Integer);
    function fObtemDadoPinPadDireto(AintTipoDocumento: Integer;
                                    AstrChaveAcesso: AnsiString;
                                    AstrIdentificador: AnsiString): AnsiString;
    procedure pSetPath(const AstrPath: String) ;
    function pRetornaLog: TStringList;
    function fConteudoLogErro: String;
    procedure pInfo30DebitoPreDatado(const AdtaDataPre: TDate);
    procedure pInfo30DebitoCredito1Minuto(const AintParcelaCdc: Integer);
    procedure pInfo30DebitoParcelado(const AintQtdParc, AintIntervaloParc, AintPrimParcAvista: Integer; const AdtaPrimParcela: TDate) ;
    procedure pSetValueAntesPassarCartao(const AValue: TAntesTefCartaoEvent) ;
    procedure pSetValueDepoisPassarCartao(const AValue: TDepoisTefCartaoEvent) ;
    procedure pSetValueDepoisFinalizarTransacao(const AValue: TDepoisFinalizarTransacaoEvent) ;
    function fGetValueAntesPassarCartao: TAntesTefCartaoEvent ;
    function fGetValueDepoisPassarCartao: TDepoisTefCartaoEvent ;
    function fGetValueDepoisFinalizarTransacao: TDepoisFinalizarTransacaoEvent ;
    function fGetValueAntesCancelarTransacao: TAntesTefCartaoEvent ;
    function fGetValueDepoisCancelarTransacao: TDepoisTefCartaoEvent ;
    procedure pSetValueAntesCancelarTransacao(const AValue: TAntesTefCartaoEvent) ;
    procedure pSetValueDepoisCancelarTransacao(const AValue: TDepoisTefCartaoEvent) ;
    function fGetValueAntesReimpressao: TAntesTefCartaoEvent ;
    function fGetValueDepoisReimpressao: TDepoisTefCartaoEvent ;
    procedure pSetValueAntesReimpressao(const AValue: TAntesTefCartaoEvent) ;
    procedure pSetValueDepoisReimpressao(const AValue: TDepoisTefCartaoEvent) ;
    function fVerificaPresencaPinPad: TStatusPinPad;
    property AntesPassarCartao: TAntesTefCartaoEvent read fGetValueAntesPassarCartao write pSetValueAntesPassarCartao ;
    property DepoisPassarCartao: TDepoisTefCartaoEvent read fGetValueDepoisPassarCartao write pSetValueDepoisPassarCartao ;
    property DepoisFinalizarTransacao: TDepoisFinalizarTransacaoEvent read fGetValueDepoisFinalizarTransacao write pSetValueDepoisFinalizarTransacao ;
    property AntesCancelarTransacao: TAntesTefCartaoEvent read fGetValueAntesCancelarTransacao write pSetValueAntesCancelarTransacao ;
    property DepoisCancelarTransacao: TDepoisTefCartaoEvent read fGetValueDepoisCancelarTransacao write pSetValueDepoisCancelarTransacao ;
    property AntesReimpressao: TAntesTefCartaoEvent read fGetValueAntesReimpressao write pSetValueAntesReimpressao ;
    property DepoisReimpressao: TDepoisTefCartaoEvent read fGetValueDepoisReimpressao write pSetValueDepoisReimpressao ;
    procedure pSetValueSucessoTefCartao(const AValue: TSucessoTefCartaoEvent) ;
    procedure pSetDadosAdicionaisTefTra(const aValue: IDadosAdicionaisTefTra) ;
    function fGetDadosAdicionaisTefTra: IDadosAdicionaisTefTra ;
    function fGetValueSucessoTefCartao: TSucessoTefCartaoEvent ;
    property SucessoTefCartao: TSucessoTefCartaoEvent read fGetValueSucessoTefCartao write pSetValueSucessoTefCartao ;
    procedure pSetLogErr(AProc: TprocGravaLogErr) ;
    function fObtemVersao: string;
    procedure AddInfo(const AMacAdress, AIPNumber, AUserName, AComputerName, ATerminalTEF: string);
    function fInfoPixCadastro(out AListaInfo: TArrayInfoPix): Longint;
    procedure pEnviarQrCode(const AstrDiretorio, AstrArquivo: String) ;
    procedure pLimpaQrCode(const AstrMensagem: AnsiString = '') ;

    { ISubjectTEFCitel }
    procedure AdicionaObserver(AObserver: IObserverTEFCitel);
    procedure RemoveObserver(AObserver: IObserverTEFCitel);
    procedure NotificaObservers();

    { ITefCitelV2 }
    function fTraduzirErro(const AintSts: Integer): String;
    function fObtemInfoPinPad: String;

    { ITefCitelFinalizacao }
    function fUltimaFinalizacaoNaoRealizada: Boolean;
    function fUltimaFinalizacaoSeraReenviada: Boolean;
    procedure pDescreveFinalizacaoPendente(const AstrDescricao: String);
  end;

implementation

type
  TTefCitelDvcChamadaPendente = class
  private
    FEvento: TEvent;
    FResposta: TJSONObject;
    FErroCanal: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    property Evento: TEvent read FEvento;
    property Resposta: TJSONObject read FResposta write FResposta;
    property ErroCanal: Boolean read FErroCanal write FErroCanal;
  end;

  TDadosAdicionaisTefTraDvc = class(TInterfacedObject, IDadosAdicionaisTefTra)
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

{ Helpers JSON - usam GetValue (publico) em vez de FindValue (protected em
  TJSONObject nesta versao do Delphi); ambos retornam nil se a chave nao
  existir, suficiente para nomes simples (sem path com ".") como usados aqui. }

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

function fJsonDeTefInfo(const ATefInfo: TTefInfo): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('macAdress', ATefInfo.MacAdress);
  Result.AddPair('ipNumber', ATefInfo.IPNumber);
  Result.AddPair('userName', ATefInfo.UserName);
  Result.AddPair('computerName', ATefInfo.ComputerName);
  Result.AddPair('terminalTEF', ATefInfo.TerminalTEF);
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
  LResult: TDadosAdicionaisTefTraDvc;
begin
  if not Assigned(AJson) then
    Exit(nil);
  LResult := TDadosAdicionaisTefTraDvc.Create;
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

{ TTefCitelDvcChamadaPendente }

constructor TTefCitelDvcChamadaPendente.Create;
begin
  inherited Create;
  FEvento := TEvent.Create(nil, True, False, '');
end;

destructor TTefCitelDvcChamadaPendente.Destroy;
begin
  FResposta.Free;
  FEvento.Free;
  inherited;
end;

{ TDadosAdicionaisTefTraDvc }

function TDadosAdicionaisTefTraDvc.PixS_N(const AstrValor: String): IDadosAdicionaisTefTra;
begin FstrPixS_N := AstrValor; Result := Self; end;
function TDadosAdicionaisTefTraDvc.PixS_N: String;
begin Result := FstrPixS_N; end;
function TDadosAdicionaisTefTraDvc.OpcDoc(const AstrValor: String): IDadosAdicionaisTefTra;
begin FstrOpcDoc := AstrValor; Result := Self; end;
function TDadosAdicionaisTefTraDvc.OpcDoc: String;
begin Result := FstrOpcDoc; end;
function TDadosAdicionaisTefTraDvc.ArrDocs(const AarrValor: TArrayInfoTraDoc): IDadosAdicionaisTefTra;
begin FArrDocs := AarrValor; Result := Self; end;
function TDadosAdicionaisTefTraDvc.ArrDocs: TArrayInfoTraDoc;
begin Result := FArrDocs; end;
function TDadosAdicionaisTefTraDvc.OpeRcx(const AstrValor: String): IDadosAdicionaisTefTra;
begin FstrOpeRcx := AstrValor; Result := Self; end;
function TDadosAdicionaisTefTraDvc.OpeRcx: String;
begin Result := FstrOpeRcx; end;
function TDadosAdicionaisTefTraDvc.NumDoc(const AstrValor: String): IDadosAdicionaisTefTra;
begin FstrNumDoc := AstrValor; Result := Self; end;
function TDadosAdicionaisTefTraDvc.NumDoc: String;
begin Result := FstrNumDoc; end;
function TDadosAdicionaisTefTraDvc.Valor(const AfltValor: Double): IDadosAdicionaisTefTra;
begin FfltValor := AfltValor; Result := Self; end;
function TDadosAdicionaisTefTraDvc.Valor: Double;
begin Result := FfltValor; end;
function TDadosAdicionaisTefTraDvc.Operacao(const AintValor: Integer): IDadosAdicionaisTefTra;
begin FintOperacao := AintValor; Result := Self; end;
function TDadosAdicionaisTefTraDvc.Operacao: Integer;
begin Result := FintOperacao; end;
function TDadosAdicionaisTefTraDvc.Modalidade(const AstrValor: String): IDadosAdicionaisTefTra;
begin FstrModalidade := AstrValor; Result := Self; end;
function TDadosAdicionaisTefTraDvc.Modalidade: String;
begin Result := FstrModalidade; end;
function TDadosAdicionaisTefTraDvc.QtdParcelas(const AintValor: Integer): IDadosAdicionaisTefTra;
begin FintQtdParcelas := AintValor; Result := Self; end;
function TDadosAdicionaisTefTraDvc.QtdParcelas: Integer;
begin Result := FintQtdParcelas; end;
function TDadosAdicionaisTefTraDvc.Status(const AstrValor: String): IDadosAdicionaisTefTra;
begin FstrStatus := AstrValor; Result := Self; end;
function TDadosAdicionaisTefTraDvc.Status: String;
begin Result := FstrStatus; end;
function TDadosAdicionaisTefTraDvc.PrePago(const AstrValor: String): IDadosAdicionaisTefTra;
begin FstrPrePago := AstrValor; Result := Self; end;
function TDadosAdicionaisTefTraDvc.PrePago: String;
begin Result := FstrPrePago; end;
function TDadosAdicionaisTefTraDvc.ParcAdm(const AstrValor: String): IDadosAdicionaisTefTra;
begin FstrParcAdm := AstrValor; Result := Self; end;
function TDadosAdicionaisTefTraDvc.ParcAdm: String;
begin Result := FstrParcAdm; end;

{ Creation time do processo atual como string decimal (Req. 456190, RF23).
  Fora da classe porque nao depende de estado nenhum dela. }
function fInicioDesteProcesso: String;
var
  LftCriacao, LftSaida, LftKernel, LftUsuario: TFileTime;
  LqwValor: UInt64;
begin
  Result := '';
  if not GetProcessTimes(GetCurrentProcess, LftCriacao, LftSaida, LftKernel, LftUsuario) then
    Exit;
  LqwValor := (UInt64(LftCriacao.dwHighDateTime) shl 32) or UInt64(LftCriacao.dwLowDateTime);
  Result := IntToStr(Int64(LqwValor));
end;

{ IsHungAppWindow e a mesma API que o Windows usa para decidir quando escrever
  "Nao Esta Respondendo" na barra de titulo: True quando a janela parou de
  processar mensagens. Nao esta declarada em Winapi.Windows do Seattle. }
function IsHungAppWindow(AhWnd: HWND): BOOL; stdcall; external user32 name 'IsHungAppWindow';

type
  { Estado da varredura de EnumWindows - ela nao aceita closure, so um LPARAM. }
  TTefDvcBuscaJanela = record
    dwPid: DWORD;
    hwndAchada: HWND;
    { Quantas janelas do processo passaram no filtro (Req. 456190, 2026-09-10).
      A varredura fica com a PRIMEIRA, mas continua contando: se vier mais de
      uma, a escolha foi um chute entre candidatas, e o log precisa dizer isso.
      E o unico jeito de o modo de falha silencioso desta abordagem - pegar a
      janela errada - virar visivel em producao, onde nao se pode reproduzir o
      cenario do autcom travado. }
    intCandidatas: Integer;
  end;
  PTefDvcBuscaJanela = ^TTefDvcBuscaJanela;

function fEnumJanelaPrincipal(AhWnd: HWND; AlParam: LPARAM): BOOL; stdcall;
var
  LBusca: PTefDvcBuscaJanela;
  LdwPid: DWORD;
begin
  Result := True; // continua enumerando - ver intCandidatas
  LBusca := PTefDvcBuscaJanela(AlParam);

  LdwPid := 0;
  GetWindowThreadProcessId(AhWnd, LdwPid);
  if LdwPid <> LBusca^.dwPid then
    Exit;
  if not IsWindowVisible(AhWnd) then
    Exit;
  if GetWindow(AhWnd, GW_OWNER) <> 0 then
    Exit; // janela de outra (dialogo, tooltip) - a principal nao tem dono

  Inc(LBusca^.intCandidatas);
  if LBusca^.hwndAchada = 0 then
    LBusca^.hwndAchada := AhWnd; // fica com a primeira, mas conta todas
end;

{ Titulo e classe da janela, para o log (Req. 456190, 2026-09-10). Sem eles,
  uma escolha errada de janela produz exatamente o mesmo log de uma escolha
  certa - e essa e a diferenca entre um log que serve em producao e um que
  nao serve. }
function fDescreveJanela(const AhWnd: HWND): String;
var
  LstrTitulo, LstrClasse: String;
  LintTam: Integer;
begin
  SetLength(LstrTitulo, 256);
  LintTam := GetWindowText(AhWnd, PChar(LstrTitulo), 256);
  SetLength(LstrTitulo, LintTam);
  if LstrTitulo = '' then
    LstrTitulo := '(sem titulo)';

  SetLength(LstrClasse, 256);
  LintTam := GetClassName(AhWnd, PChar(LstrClasse), 256);
  SetLength(LstrClasse, LintTam);
  if LstrClasse = '' then
    LstrClasse := '(sem classe)';

  Result := Format('titulo="%s" classe="%s"', [LstrTitulo, LstrClasse]);
end;

{ A janela principal do autcom detentor esta TRAVADA? (Req. 456190, RF27/RN16,
  Passo 6 - redesenho de 2026-09-09 17:28.)

  Substitui a sonda por hook, que nao funcionava para o unico caso que
  importa: a disputa so acontece contra o detentor por PENDENCIA, e um autcom
  com pendencia esta parado esperando o operador confirmar ou desfazer - fora
  de qualquer chamada de TEF, e portanto fora do laco de fChamaRpc que era o
  que garantia a drenagem do TThread.Queue. Em campo, um autcom saudavel nessa
  situacao ficou 5 s sem responder e foi classificado como travado.

  Aqui quem responde e o Windows, pelo mesmo criterio da barra de titulo. E o
  requisitante que pergunta, porque ele roda no MESMO servidor que o detentor
  (RN17) - a estacao continua sem ler processo alheio.

  Toda duvida responde NAO TRAVADO: janela nao encontrada, processo sem
  janela visivel, pid zero. Errar para "nao travado" apenas mantem o
  comportamento que ja existia antes do Passo 6 (recusa); errar para
  "travado" ofereceria tomar o pinpad de quem esta trabalhando. }
function fJanelaPrincipalTravada(const AdwPid: DWORD): Boolean;
var
  LBusca: TTefDvcBuscaJanela;
  LstrAviso: String;
begin
  Result := False;
  if AdwPid = 0 then
    Exit;

  LBusca.dwPid := AdwPid;
  LBusca.hwndAchada := 0;
  LBusca.intCandidatas := 0;
  EnumWindows(@fEnumJanelaPrincipal, LPARAM(@LBusca));

  if LBusca.hwndAchada = 0 then
  begin
    pLogaDiagnosticoDvc(Format(
      'fJanelaPrincipalTravada: nao achei janela principal visivel do pid=%d - concluindo NAO ' +
      'travado (na duvida, nao se toma o pinpad de ninguem).', [AdwPid]));
    Exit;
  end;

  { IfThen ficaria melhor aqui, mas exige System.StrUtils no uses - e este
    projeto ja tropecou nisso (Req. 456190, 2026-09-09). If explicito. }
  if LBusca.intCandidatas > 1 then
    LstrAviso := ' - ATENCAO: mais de uma, a escolha foi a primeira da enumeracao'
  else
    LstrAviso := '';

  Result := IsHungAppWindow(LBusca.hwndAchada);
  pLogaDiagnosticoDvc(Format(
    'fJanelaPrincipalTravada: pid=%d, janela 0x%x (%s) - IsHungAppWindow=%s. ' +
    'Candidatas no processo: %d%s.',
    [AdwPid, LBusca.hwndAchada, fDescreveJanela(LBusca.hwndAchada),
     BoolToStr(Result, True), LBusca.intCandidatas, LstrAviso]));
end;

{ O autcom que detem o pinpad ainda existe? (Req. 456190, RF27/RN17, Passo 6)

  Quem pergunta e o autcom REQUISITANTE, e nao o servico da estacao, por dois
  motivos que a RN17 registra: todos os autcom.exe rodam no MESMO servidor
  (entao o pid do detentor e um pid que este processo enxerga), e a decisao
  do levantamento de o servico nunca tocar processo alheio nem banco fica
  intacta.

  O par (pid, inicioProcesso) e conferido, nao so o pid: o Windows reusa
  numero de pid, e um processo novo que caisse no numero do detentor faria
  esta funcao dizer "vivo" sobre alguem que morreu - travando a tomada para
  sempre, que e o erro barato. O erro caro e o contrario, e por isso toda
  duvida responde VIVO: acesso negado, GetProcessTimes falhando, pid zero.
  Dizer "morto" sem certeza faria a estacao orfanar a sessao de um autcom
  saudavel, com transacao pendente de verdade. }
function fProcessoAutcomVivo(const AdwPid: DWORD; const AstrInicioProcesso: String): Boolean;
var
  LhProcesso: THandle;
  LftCriacao, LftSaida, LftKernel, LftUsuario: TFileTime;
  LqwValor: UInt64;
  LdwCodigoSaida, LdwErro: DWORD;
  LstrInicioReal: String;
begin
  if AdwPid = 0 then
    Exit(True); // sem pid nao ha o que verificar - nao afirmar morte

  LhProcesso := OpenProcess(PROCESS_QUERY_INFORMATION, False, AdwPid);
  if LhProcesso = 0 then
  begin
    LdwErro := GetLastError;
    { ERROR_INVALID_PARAMETER e a resposta do Windows para pid inexistente.
      Qualquer outro erro (tipicamente ERROR_ACCESS_DENIED) e ignorancia, nao
      prova de morte. }
    Result := LdwErro <> ERROR_INVALID_PARAMETER;
    pLogaDiagnosticoDvc(Format(
      'fProcessoAutcomVivo: OpenProcess(pid=%d) falhou com erro %d - concluindo vivo=%s.',
      [AdwPid, LdwErro, BoolToStr(Result, True)]));
    Exit;
  end;

  try
    { Handle aberto nao basta: um processo ja terminado continua abrivel
      enquanto alguem segurar handle dele (o "zumbi" do Windows). }
    if GetExitCodeProcess(LhProcesso, LdwCodigoSaida) and (LdwCodigoSaida <> STILL_ACTIVE) then
    begin
      pLogaDiagnosticoDvc(Format(
        'fProcessoAutcomVivo: pid=%d ja TERMINOU (codigo de saida %d).', [AdwPid, LdwCodigoSaida]));
      Exit(False);
    end;

    if AstrInicioProcesso = '' then
    begin
      { Detentor de versao anterior, que nao manda inicioProcesso. Sem o par
        nao da para descartar reuso de pid - fica no "vivo". }
      pLogaDiagnosticoDvc(Format(
        'fProcessoAutcomVivo: pid=%d existe e o detentor nao informou inicioProcesso - ' +
        'concluindo vivo (nao da para descartar reuso de pid).', [AdwPid]));
      Exit(True);
    end;

    if not GetProcessTimes(LhProcesso, LftCriacao, LftSaida, LftKernel, LftUsuario) then
    begin
      pLogaDiagnosticoDvc(Format(
        'fProcessoAutcomVivo: GetProcessTimes(pid=%d) falhou com erro %d - concluindo vivo.',
        [AdwPid, GetLastError]));
      Exit(True);
    end;

    LqwValor := (UInt64(LftCriacao.dwHighDateTime) shl 32) or UInt64(LftCriacao.dwLowDateTime);
    LstrInicioReal := IntToStr(Int64(LqwValor));
    Result := LstrInicioReal = AstrInicioProcesso;

    if not Result then
      pLogaDiagnosticoDvc(Format(
        'fProcessoAutcomVivo: o pid=%d existe, mas nasceu em "%s" e o detentor era "%s" - ' +
        'e OUTRO processo no mesmo numero de pid. O detentor morreu.',
        [AdwPid, LstrInicioReal, AstrInicioProcesso]));
  finally
    CloseHandle(LhProcesso);
  end;
end;

{ TTefCitelDvc }

constructor TTefCitelDvc.Create(const AstrOpcao: String);
begin
  inherited Create;
  FstrOpcao := AstrOpcao;

  { Req. 456190, Fase 3.5 - ver comentario na declaracao de FdwPid. }
  FdwPid := GetCurrentProcessId;
  if not ProcessIdToSessionId(FdwPid, FdwSessao) then
    FdwSessao := 0;
  FstrInicioProcesso := fInicioDesteProcesso;

  FintProximoId := 0;
  FcsChamadas := TCriticalSection.Create;
  FdictChamadas := TObjectDictionary<Integer, TObject>.Create([doOwnsValues]);
  FObservers := TList<IObserverTEFCitel>.Create;
  FLog := TStringList.Create;

  FcsMetodosEmAndamento := TCriticalSection.Create;
  FcsAviso := TCriticalSection.Create;
  FstrAvisoGuardado := '';
  FdictMetodosEmAndamento := TDictionary<String, Boolean>.Create;
  FdictGeracaoAprovacao := TDictionary<String, Integer>.Create;

  FTransporte := TTefCitelDvcTransporte.Create;
  FTransporte.OnFrameRecebido := pOnFrameRecebido;
  FTransporte.OnDesconectado := pOnDesconectado;
  FTransporte.OnConectado := pOnConectado;
end;

destructor TTefCitelDvc.Destroy;
begin
  FTransporte.Free;
  FdictChamadas.Free;
  FcsChamadas.Free;
  FdictMetodosEmAndamento.Free;
  FdictGeracaoAprovacao.Free;
  FcsMetodosEmAndamento.Free;
  FcsAviso.Free;
  FObservers.Free;
  FLog.Free;
  inherited;
end;

function TTefCitelDvc.fJsonContexto: TJSONObject;
var
  LObjDisputa: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('opcao', FstrOpcao);
  Result.AddPair('path', FstrPath);
  { Req. 456190, Fase 3.5 - Int64 explicito: TJSONNumber.Create tem sobrecarga
    para Integer e para Int64, e DWORD (Cardinal) e ambiguo entre as duas. }
  Result.AddPair('pid', TJSONNumber.Create(Int64(FdwPid)));
  Result.AddPair('sessao', TJSONNumber.Create(Int64(FdwSessao)));
  Result.AddPair('inicioProcesso', FstrInicioProcesso); // RF23 - ver o campo

  { RF27 (Passo 6) - declara que este autcom entende o fluxo de disputa do
    pinpad. Servico e libTefCitel.dll sao implantados separadamente, entao a
    versao de um nao diz nada sobre a do outro: sem esta marca, um servico
    novo devolveria uma resposta "contestavel" que um autcom antigo leria
    como sucesso vazio, e o operador ficaria sem mensagem nenhuma. Com ela, o
    servico so muda de comportamento para quem sabe lidar. }
  Result.AddPair('suportaDisputa', TJSONBool.Create(True));

  { Veredito da disputa, quando ha um pendente de envio (limpo no fim da
    chamada EXTERNA, nao a cada chamada - ver o comentario dos campos). Vai
    no contexto e nao nos "dados" porque a estacao decide a posse do pinpad
    em pGarantePinpadConfigurado, antes de olhar os dados do metodo. }
  if FdwPidDisputa <> 0 then
  begin
    LObjDisputa := TJSONObject.Create;
    LObjDisputa.AddPair('pid', TJSONNumber.Create(Int64(FdwPidDisputa)));
    LObjDisputa.AddPair('inicioProcesso', FstrInicioProcessoDisputa);
    LObjDisputa.AddPair('morto', TJSONBool.Create(FblnDisputaProcessoMorto));
    LObjDisputa.AddPair('confirmado', TJSONBool.Create(FblnDisputaConfirmadaPeloOperador));
    Result.AddPair('disputaPinpad', LObjDisputa);
  end;
  Result.AddPair('tefInfo', fJsonDeTefInfo(FTefInfo));
  if Assigned(FobjDadosAdicionaisTefTra) then
    Result.AddPair('dadosAdicionaisTefTra', fJsonDeDadosAdicionais(FobjDadosAdicionaisTefTra))
  else
    Result.AddPair('dadosAdicionaisTefTra', TJSONNull.Create);
end;

procedure TTefCitelDvc.pEnviaEnvelope(const AstrTipo: String; const AintId: Integer;
  const AstrMetodo: String; ADados: TJSONObject);
begin
  fEnviaEnvelope(AstrTipo, AintId, AstrMetodo, ADados);
end;

function TTefCitelDvc.fEnviaEnvelope(const AstrTipo: String; const AintId: Integer;
  const AstrMetodo: String; ADados: TJSONObject): Boolean;
var
  LEnvelope: TJSONObject;
begin
  LEnvelope := TJSONObject.Create;
  try
    LEnvelope.AddPair('v', TJSONNumber.Create(1));
    LEnvelope.AddPair('id', TJSONNumber.Create(AintId));
    LEnvelope.AddPair('tipo', AstrTipo);
    if AstrMetodo <> '' then
      LEnvelope.AddPair('metodo', AstrMetodo);
    if Assigned(ADados) then
      LEnvelope.AddPair('dados', ADados); // envelope passa a ser dono de ADados
    LEnvelope.AddPair('contexto', fJsonContexto);

    pLogaDiagnosticoDvc(Format('Enviando envelope tipo="%s" metodo="%s" id=%d...',
      [AstrTipo, AstrMetodo, AintId]));
    Result := FTransporte.fEnviaFrame(TEncoding.UTF8.GetBytes(LEnvelope.ToJSON));
    if Result then
      pLogaDiagnosticoDvc(Format('Envelope tipo="%s" metodo="%s" id=%d enviado com sucesso.',
        [AstrTipo, AstrMetodo, AintId]))
    else
      pLogaDiagnosticoDvc(Format(
        'Envelope tipo="%s" metodo="%s" id=%d saiu no canal SEM confirmacao do servico da ' +
        'estacao - se nenhuma resposta chegar, a chamada desiste em %d ms.',
        [AstrTipo, AstrMetodo, AintId, TEF_DVC_TIMEOUT_SEM_CONFIRMACAO_MS]));
  finally
    LEnvelope.Free; // libera tambem ADados e o contexto, aninhados
  end;
end;

{ Casca de fChamaRpc: trata a DISPUTA DO PINPAD e repete a chamada
  (Req. 456190, RF27/RN15/RN16, Passo 6).

  Quando o pinpad esta preso por um autcom que a estacao nao conseguiu provar
  vivo, a resposta nao e sucesso nem erro - e um pedido de veredito. Resolver
  isso AQUI, e nao em cada um dos metodos de transacao, e o que mantem
  untTefCitelUtil.pas e a tela do TEF sem saber que a disputa existe.

  Repetir e seguro: a recusa acontece em pGarantePinpadConfigurado, ANTES de
  qualquer despacho, entao nada foi executado no pinpad na primeira ida.

  Uma retentativa so. Se a segunda tambem voltar contestavel, o detentor
  mudou no meio (a estacao confere o par pid/inicioProcesso do veredito) e
  insistir viraria laco - o operador ve a negativa e tenta de novo quando
  quiser. }
{ RF29 (Req. 456190, Passo 7) - o servico da estacao reiniciou, entao a
  instancia nova nao sabe nada deste autcom: nem a configuracao, nem a
  pendencia da transacao anterior, que morreu com o processo antigo.

  Refazer o login aqui, e nao no reata, e deliberado: o reata chega na
  reconexao, quando pode nao haver nenhum operador em tela e nenhum observer
  registrado - o aviso iria para "0 observer(es)" e se perderia. Aqui existe
  operacao em curso, logo existe quem leia.

  O aviso NAO afirma que a transacao anterior falhou, porque nao se sabe: ela
  pode ter sido aprovada no pinpad e ficado pendente na estacao. Manda conferir
  o relatorio, que e o unico desfecho honesto (mesma escolha de
  pNotificaCanalCaiu). }
procedure TTefCitelDvc.pRefazTefSeServicoReiniciou(const AstrMetodo: String);
var
  LResult: TJSONObject;
  LDados: TJSONObject;
  LintValor: Integer;
  LintOrfas: Integer;
  LstrAviso: String;
begin
  if InterlockedExchange(FintServicoReiniciou, 0) = 0 then
    Exit;

  { A propria chamada de login nao se reaplica, e reentrancia nao existe. }
  if (AstrMetodo = 'fConfiguraTefCitel') or FblnRelogando then
    Exit;

  { Achado de campo 2026-09-11: o "fPassarCartao" id=6 do pid=88584 saiu as
    08:24:57 e estava DENTRO da DLL nativa quando o servico foi parado as
    08:25:25 - resposta nunca ia existir. Como o canal DVC nao cai no
    reinicio puro, pOnDesconectado nao roda e a chamada ficava pendente para
    sempre. O operador acionou o fechamento da tela OITO vezes (pSair id=10
    a 17, todos respondidos com sucesso pela estacao) com a chamada de fora
    presa embaixo: o pSair entra ANINHADO nela, e fechar a tela nunca
    termina. O "reata", que e o mecanismo desenhado pra resolver id em voo,
    e exatamente o que nao acontece aqui (ver a invariante 2 em
    IA\rules\tef-dvc.md).

    Vem ANTES do re-login de proposito: a tela recebe a negativa e a LCKATC
    sai da frente sem esperar os ~5 s do fConfiguraTefCitel nativo.

    A chamada CORRENTE ja saiu do dicionario (ExtractPair em
    fChamaRpcUmaVez, antes de levantar ETefCitelDvcLoginNecessario), entao
    isto alcanca so as orfas. Pelo outro detector (resposta do "reata") o
    canal caiu antes e pOnDesconectado ja limpou - aqui vira no-op, e e por
    isso que a contagem entra no log em vez de a linha sair sempre. }
  LintOrfas := fMataChamadasPendentes;
  if LintOrfas > 0 then
    pLogaDiagnosticoDvc(Format(
      'pRefazTefSeServicoReiniciou: %d chamada(s) estavam em voo quando o servico da ' +
      'estacao reiniciou - resolvida(s) como canal caido, porque a instancia nova nao ' +
      'conhece esses ids e resposta nunca viria. A tela recebe negativa e o callback ' +
      '"Depois*" libera a LCKATC.', [LintOrfas]));

  if not FblnCfgGuardada then
  begin
    { Sem argumentos guardados nao ha o que refazer - acontece se o reinicio
      for detectado antes de este autcom ter feito o proprio login. A estacao
      recusa com mensagem no pGarantePinpadConfigurado, que e o desfecho certo. }
    pLogaDiagnosticoDvc(Format(
      'pRefazTefSeServicoReiniciou: o servico reiniciou, mas este autcom ainda nao tinha ' +
      'feito o proprio fConfiguraTefCitel - nada a reaplicar antes de "%s". A estacao vai ' +
      'recusar com mensagem se "%s" precisar do pinpad.', [AstrMetodo, AstrMetodo]));
    Exit;
  end;

  { Contado na tentativa, e nao no sucesso: falhando ou nao, a instancia que
    vai responder a chamada ja nao e a que viu a transacao anterior. Quem le
    e fFinalizarTransacao (Req. 470363). }
  Inc(FintQtdRelogins);

  pLogaDiagnosticoDvc(Format(
    'pRefazTefSeServicoReiniciou: o servico da estacao REINICIOU (instancia atual "%s") - ' +
    'refazendo o login do TEF antes de "%s", com os argumentos do login original ' +
    '(terminal="%s"). A sessao Scope da transacao anterior morreu com o processo antigo do ' +
    'servico.', [FstrInstanciaServico, AstrMetodo, FstrCfgNumTerminal]));

  FblnRelogando := True;
  try
    try
      LDados := TJSONObject.Create;
      LDados.AddPair('enderecoIp', FstrCfgEnderecoIp);
      LDados.AddPair('codigoLoja', FstrCfgCodigoLoja);
      LDados.AddPair('numTerminal', FstrCfgNumTerminal);
      LDados.AddPair('configResultado', TJSONNumber.Create(FintCfgConfigResultado));
      LDados.AddPair('parametrosAdicionais', FstrCfgParametrosAdicionais);
      LDados.AddPair('somenteCarregarLib', TJSONBool.Create(FblnCfgSomenteCarregarLib));

      { fChamaRpcUmaVez direto, e nao fChamaRpc: aninhar a casca traria a
        maquinaria de disputa (e uma possivel pergunta ao operador) para dentro
        de uma chamada que ainda nem comecou. Se o login for recusado por posse,
        a excecao contestavel sobe e e tratada como falha de re-login abaixo -
        a chamada real segue e a estacao decide o que fazer com ela. }
      LResult := fChamaRpcUmaVez('fConfiguraTefCitel', LDados);
      try
        LintValor := fJsonInt(LResult, 'valor');
      finally
        LResult.Free;
      end;

      pLogaDiagnosticoDvc(Format(
        'pRefazTefSeServicoReiniciou: re-login concluido, retorno %d. Seguindo para "%s".',
        [LintValor, AstrMetodo]));
    except
      on E: Exception do
        { Nao pode derrubar a chamada real: se o re-login falhou, a estacao
          ainda tem a propria guarda (pGarantePinpadConfigurado recusa quem
          nunca enviou configuracao) e o operador recebe mensagem em vez de
          excecao. }
        pLogaDiagnosticoDvc(Format(
          'pRefazTefSeServicoReiniciou: o re-login FALHOU (%s: %s) - seguindo para "%s" ' +
          'mesmo assim. A estacao recusa com mensagem se precisar do pinpad sem ' +
          'configuracao.',
          [E.ClassName, E.Message, AstrMetodo]));
    end;
  finally
    { Fora de finally, uma excecao escapando do except acima (do proprio
      pLogaDiagnosticoDvc, por exemplo) deixaria a flag presa em True e
      desligaria o re-login para o resto da vida do processo. }
    FblnRelogando := False;
  end;

  { Reenvio descartado (pReenviaFinalizacaoPendente): este aviso diz QUAL
    transacao ficou pendente e substitui o generico abaixo (Req. 470363). }
  if FstrAvisoReenvioDescartado <> '' then
  begin
    FstrAvisoReenvioDescartado := ''; // ja entregue em pDescartaReenvioFinalizacao
    Exit;
  end;

  LstrAviso :=
    'O serviço de TEF da estação foi reiniciado e a conexão foi refeita ' +
    'automaticamente.' + #13#13 +
    'Se havia uma transação em andamento, confira no relatório do TEF se ela ficou ' +
    'pendente antes de repetir a operação.';

  { Na finalizacao este aviso e SEMPRE guardado, nunca mostrado na hora, e
    quem o descarta e o autcom que conhece ITefCitelFinalizacao
    (fUltimaFinalizacaoNaoRealizada), porque ele avisa por conta propria, com
    valor e Controle. Mostrado na hora, com tela aberta, sairia em dobro
    (apontamento do DelphAI, 16/10). O autcom sem o porte do Req. 470363 - que
    pega esta DLL pelo external ^/libTefCitel - nunca consulta a interface e
    continua recebendo este, que e o unico aviso que ele tem. }
  if AstrMetodo = 'fFinalizarTransacao' then
  begin
    FcsAviso.Enter;
    try
      FstrAvisoGuardado := 'Aviso da operacao anterior: ' + LstrAviso;
      FstrAvisoReinicioGuardado := FstrAvisoGuardado;
    finally
      FcsAviso.Leave;
    end;
    Exit;
  end;

  { pAvisaOperadorOuGuarda, e nao pNotificaNegativa: este aviso fala de uma
    transacao ANTERIOR e nao pode depender de haver tela aberta agora (achado
    de campo 2026-09-11, "para 0 observer(es)" - ver o comentario completo
    naquele metodo). }
  pAvisaOperadorOuGuarda(LstrAviso);
end;


{ Req. 470363 - a confirmacao que nao chegou a estacao porque o canal caiu.

  A sessao Scope da estacao e UMA so, e confirmar ou desfazer vale para tudo o
  que estiver aberto nela. Sem este reenvio, quem resolvia a transacao pendente
  era a proxima operacao, por tabela: um cartao seguinte desfeito desfazia
  junto a venda anterior, ja faturada (achado do Rafael no teste de 16/10).
  Por isso roda no INICIO de toda chamada, antes de qualquer coisa chegar ao
  pinpad.

  fChamaRpcUmaVez direto, e nao fChamaRpc: sem re-login. Se o servico
  reiniciou, a sessao que tinha a transacao morreu, e a estacao recusa com
  loginNecessario - reenviar nao confirmaria nada, entao descarta e deixa o
  re-login (com o aviso de reinicio) para a chamada real, logo em seguida. }
procedure TTefCitelDvc.pReenviaFinalizacaoPendente;
var
  LDados, LResult: TJSONObject;
  LblnFinalizacaoEmAndamento: Boolean;
begin
  if (not FblnReenviarFinalizacao) or FblnRelogando then
    Exit;
  if InterlockedCompareExchange(FintServicoReiniciou, 0, 0) <> 0 then
  begin
    pDescartaReenvioFinalizacao;
    pLogaDiagnosticoDvc(
      'pReenviaFinalizacaoPendente: o servico da estacao reiniciou - a confirmacao pendente ' +
      'nao sera reenviada (a sessao Scope que tinha a transacao morreu com ele).');
    Exit;
  end;

  { Atomica: fChamaRpc tem caminho fora da thread principal (Pix). Nenhum
    Exit entre esta linha e o try - o finally e quem a zera (uma saida ali
    no meio a deixava presa em 1 e desligava o reenvio ate o processo
    fechar: apontamento do DelphAI, 16/10). }
  if InterlockedCompareExchange(FintReenviandoFinalizacao, 1, 0) <> 0 then
    Exit;
  try
    { Ja ha um fFinalizarTransacao em andamento (thread do Pix, ou reentrada
      pelo ProcessMessages da espera): o guard de metodo duplicado de
      fChamaRpcUmaVez devolveria um JSON vazio, sem despachar nada, e isto o
      tomaria por sucesso - a confirmacao guardada se perderia em silencio
      (apontamento do DelphAI, 16/10). Fica guardada para a proxima chamada. }
    FcsMetodosEmAndamento.Enter;
    try
      LblnFinalizacaoEmAndamento := FdictMetodosEmAndamento.ContainsKey('fFinalizarTransacao');
    finally
      FcsMetodosEmAndamento.Leave;
    end;
    if LblnFinalizacaoEmAndamento then
    begin
      pLogaDiagnosticoDvc('pReenviaFinalizacaoPendente: ha um fFinalizarTransacao em andamento - ' +
        'reenvio adiado para a proxima chamada.');
      Exit;
    end;
    try
      LDados := TJSONObject.Create;
      LDados.AddPair('confirma', TJSONBool.Create(FblnReenvioConfirma));
      LDados.AddPair('dataStr', FstrReenvioData);
      LDados.AddPair('horaStr', FstrReenvioHora);
      LDados.AddPair('documentoVinculado', FstrReenvioDocumento);
      LDados.AddPair('paramAdic', FstrReenvioParamAdic);
      LResult := fChamaRpcUmaVez('fFinalizarTransacao', LDados);
      LResult.Free;
      FblnReenviarFinalizacao := False;
      pLogaDiagnosticoDvc(Format(
        'pReenviaFinalizacaoPendente: confirmacao reenviada com sucesso (confirma=%s, documento="%s").',
        [BoolToStr(FblnReenvioConfirma, True), FstrReenvioDocumento]));
    except
      on E: ETefCitelDvcLoginNecessario do
      begin
        pDescartaReenvioFinalizacao;
        InterlockedExchange(FintServicoReiniciou, 1);
        pLogaDiagnosticoDvc(
          'pReenviaFinalizacaoPendente: a estacao nao conhece mais este autcom (servico reiniciou) - ' +
          'confirmacao descartada: ' + E.Message);
      end;
      on E: ETefCitelDvcCanal do
      begin
        { Canal ainda fora: fica guardada, e a chamada corrente NAO segue -
          sobe como a queda que e. Seguir deixaria um cartao novo entrar na
          sessao Scope com a transacao anterior ainda sem confirmacao, se o
          canal voltasse entre as duas idas (apontamento do DelphAI, 16/10). }
        pLogaDiagnosticoDvc('pReenviaFinalizacaoPendente: canal ainda indisponivel - ' + E.Message);
        raise;
      end;
      on E: Exception do
      begin
        FblnReenviarFinalizacao := False;
        pLogaDiagnosticoDvc(Format(
          'pReenviaFinalizacaoPendente: reenvio falhou (%s: %s) - descartado.', [E.ClassName, E.Message]));
      end;
    end;
  finally
    InterlockedExchange(FintReenviandoFinalizacao, 0);
  end;
end;

{ Consome a anotacao: cada documento e finalizado uma vez. Sem anotacao
  (aprovado por outra instancia, ou antes desta versao) = nao se sabe, e
  vale so o re-login da propria chamada. }
function TTefCitelDvc.fSessaoDaAprovacaoMorreu(const AstrDocumento: String): Boolean;
var
  LintGeracao: Integer;
begin
  FcsMetodosEmAndamento.Enter;
  try
    Result := FdictGeracaoAprovacao.TryGetValue(AstrDocumento, LintGeracao) and
              (LintGeracao <> FintQtdRelogins);
    FdictGeracaoAprovacao.Remove(AstrDocumento);
  finally
    FcsMetodosEmAndamento.Leave;
  end;
end;

{ O servico reiniciou e a transacao guardada nao sera mais confirmada: o
  operador precisa saber QUAL, e nao so que "havia uma transacao em
  andamento" (teste de 16/10, R$ 3,00). }
procedure TTefCitelDvc.pDescartaReenvioFinalizacao;
var
  LstrTransacao: String;
begin
  FblnReenviarFinalizacao := False;
  if FstrReenvioDescricao <> '' then
    LstrTransacao := 'do cartão de ' + FstrReenvioDescricao
  else
    LstrTransacao := 'do cartão anterior';
  FstrAvisoReenvioDescartado :=
    'A confirmação ' + LstrTransacao + ' não pôde ser reenviada: o serviço de TEF da ' +
    'estação foi reiniciado. O faturamento foi concluído, mas a transação ficou PENDENTE ' +
    'no TEF.';

  { Entregue aqui, na hora, e nao no fim do re-login: pRefazTefSeServicoReiniciou
    tem saidas antecipadas, e o aviso ficaria preso ate um reinicio seguinte,
    falando de uma transacao antiga (apontamento do DelphAI, 16/10). O campo
    continua preenchido so para pRefazTefSeServicoReiniciou nao repetir o
    aviso generico nesta mesma chamada. }
  pAvisaOperadorOuGuarda(FstrAvisoReenvioDescartado);
end;

function TTefCitelDvc.fChamaRpcAtualizacao(const AstrMetodo: String;
  ADados: TJSONObject): TJSONObject;
begin
  Result := fChamaRpcUmaVez(AstrMetodo, ADados);
end;
function TTefCitelDvc.fChamaRpc(const AstrMetodo: String; ADados: TJSONObject): TJSONObject;
var
  LblnRetentar: Boolean;
  LstrNegativa: String;
begin
  Result := nil;
  LblnRetentar := False;
  FstrAvisoReenvioDescartado := ''; // marca so vale dentro desta chamada
  try
    pReenviaFinalizacaoPendente;
  except
    ADados.Free; // o try/finally que o libera comeca mais abaixo
    raise;
  end;
  pRefazTefSeServicoReiniciou(AstrMetodo);
  try
    try
      { O clone e que e consumido pelo envelope; o original fica de pe para a
        eventual retentativa e e liberado no finally la embaixo. }
      Result := fChamaRpcUmaVez(AstrMetodo, ADados.Clone as TJSONObject);
    except
      on E: ETefCitelDvcPinpadContestavel do
      begin
        LblnRetentar := fResolveDisputaPinpad(E, AstrMetodo, LstrNegativa);
        if not LblnRetentar then
        begin
          { Nao autorizado: vira negativa comum, do mesmo jeito que a recusa
            seca da estacao chega hoje - status 500 na tela e retorno vazio,
            que faz o metodo devolver nil e o callback "Depois*" rodar
            liberando a trava LCKATC. Nao pode subir como excecao: seria o
            dialogo do madExcept de volta na cara do operador.

            O texto vem de fResolveDisputaPinpad, e nao da estacao: so aqui se
            sabe se o detentor esta ativo ou travado, e a mensagem muda. }
          pNotificaNegativa(LstrNegativa);
          Result := TJSONObject.Create;
        end;
      end;
      on E: ETefCitelDvcLoginNecessario do
      begin
        { RF29, item 3 do Passo 8 (2026-09-10). Liga a MESMA flag que a
          resposta do "reata" liga e chama o MESMO metodo - sao dois
          detectores do mesmo desfecho, nao duas implementacoes. Todas as
          guardas de pRefazTefSeServicoReiniciou valem aqui: a propria chamada
          de login nao se reaplica, nao ha reentrancia, sem argumentos
          guardados ele so registra e sai, e um re-login que falhe nao derruba
          a chamada real.

          Se o re-login nao aconteceu (ou nao resolveu), a repeticao abaixo
          volta com loginNecessario de novo e a excecao sobe com a mensagem
          acionavel da estacao - exatamente o comportamento de antes deste
          patch, que era o unico que existia.

          Detalhe de leitura de log: o pRefazTefSeServicoReiniciou vai
          registrar a "instancia atual" com o valor que este autcom conhecia,
          que neste cenario e o da instancia ANTIGA - justamente porque
          nenhum "reata" trouxe a nova. A linha logada aqui em cima e que da
          o contexto certo. }
        pLogaDiagnosticoDvc(Format(
          'fChamaRpc("%s"): a estacao respondeu loginNecessario - ela nao conhece o ' +
          'login do TEF deste autcom. Refazendo o login e repetindo a chamada uma vez. ' +
          'Causa tipica: reinicio PURO do servico, em que o canal DVC nao cai e o ' +
          '"reata" nunca sai (lacuna da RF29, item 3 do Passo 8). Recusa da estacao: %s',
          [AstrMetodo, E.Message]));
        InterlockedExchange(FintServicoReiniciou, 1);
        pRefazTefSeServicoReiniciou(AstrMetodo);
        LblnRetentar := True;
      end;
    end;

    if LblnRetentar then
    try
      Result := fChamaRpcUmaVez(AstrMetodo, ADados.Clone as TJSONObject);
    except
      on E: ETefCitelDvcPinpadContestavel do
      begin
        pLogaDiagnosticoDvc(Format(
          'fChamaRpc("%s"): a retentativa com veredito voltou CONTESTAVEL de novo - o detentor ' +
          'mudou entre as duas idas. Tratando como negativa, sem insistir.', [AstrMetodo]));
        pNotificaNegativa(E.Message);
        Result := TJSONObject.Create;
      end;
      on E: ETefCitelDvcLoginNecessario do
      begin
        { UMA repeticao, nunca um laco (RF29, item 3 do Passo 8): se depois do
          re-login a estacao ainda diz que nao conhece este autcom, insistir
          nao muda nada e a excecao tem que chegar ao operador com a mensagem
          acionavel - que e o comportamento que existia antes deste patch. }
        pLogaDiagnosticoDvc(Format(
          'fChamaRpc("%s"): a repeticao apos o re-login voltou loginNecessario DE NOVO - ' +
          'nao insistindo. A recusa sobe para o operador: %s', [AstrMetodo, E.Message]));
        raise;
      end;
    end;
  finally
    pLimpaVereditoDisputa;
    ADados.Free;
  end;
end;

{ RF27/RN16 - o requisitante apura os fatos e, se preciso, pergunta.

  Devolve True quando ha veredito para mandar de volta a estacao. }
function TTefCitelDvc.fResolveDisputaPinpad(AErro: ETefCitelDvcPinpadContestavel;
  const AstrMetodo: String; out AstrNegativa: String): Boolean;
var
  LblnProcessoVivo, LblnConfirmou: Boolean;
  LstrPergunta: String;
  LdwInicioPergunta: DWORD;
begin
  Result := False;
  AstrNegativa := AErro.Message; // default: o texto neutro que a estacao mandou
  pLimpaVereditoDisputa;

  pLogaDiagnosticoDvc(Format(
    'fResolveDisputaPinpad: "%s" recusado de forma CONTESTAVEL - detentor pid=%d ' +
    '(terminal="%s", inicio="%s"), conexao viva=%s.',
    [AstrMetodo, AErro.FdwPidDetentor, AErro.FstrTerminalDetentor,
     AErro.FstrInicioProcessoDetentor, BoolToStr(AErro.FblnConexaoVivaDetentor, True)]));

  { 1) O processo ainda existe? Conexao aberta com a estacao ja prova que sim -
    nao ha o que verificar. }
  if AErro.FblnConexaoVivaDetentor then
    LblnProcessoVivo := True
  else
    LblnProcessoVivo := fProcessoAutcomVivo(AErro.FdwPidDetentor, AErro.FstrInicioProcessoDetentor);

  if not LblnProcessoVivo then
  begin
    { Processo morto dispensa confirmacao humana (RN16): nao ha ambiguidade
      nenhuma, e ninguem esta sendo interrompido. }
    pLogaDiagnosticoDvc(Format(
      'fResolveDisputaPinpad: o autcom pid=%d NAO EXISTE MAIS - assumindo o pinpad sem ' +
      'perguntar ao operador (RN16).', [AErro.FdwPidDetentor]));
    FdwPidDisputa := AErro.FdwPidDetentor;
    FstrInicioProcessoDisputa := AErro.FstrInicioProcessoDetentor;
    FblnDisputaProcessoMorto := True;
    Exit(True);
  end;

  { 2) Existe - mas esta TRAVADO ou apenas ocupado? (Req. 456190, redesenho
    de 2026-09-09 17:28.)

    Este era o buraco do desenho anterior. A estacao mandava um hook de
    vivacidade e tratava o silencio como "travado"; so que a disputa so
    acontece contra o detentor por PENDENCIA, e um autcom com pendencia esta
    parado esperando o operador confirmar ou desfazer - exatamente o estado em
    que ele nao esta dentro do laco de fChamaRpc que drenava o TThread.Queue.
    Resultado em campo: autcom saudavel classificado como travado, e o
    operador do outro caixa sendo convidado a tomar o pinpad dele.

    Quem responde agora e o Windows, pelo mesmo criterio da barra de titulo.
    Nao travado = recusa aqui mesmo, SEM incomodar o operador - que e o
    comportamento que existia antes do Passo 6. }
  if not fJanelaPrincipalTravada(AErro.FdwPidDetentor) then
  begin
    pLogaDiagnosticoDvc(Format(
      'fResolveDisputaPinpad: o autcom pid=%d esta vivo e RESPONDENDO - recusando sem perguntar ' +
      'nada ao operador. A pendencia e dele e so ele resolve (RF19/RN15).',
      [AErro.FdwPidDetentor]));
    AstrNegativa :=
      Format('Existe uma transação do TEF pendente no terminal %s, que continua aberto.' +
             #13#13 +
             'Conclua ou desfaça a transação naquele terminal antes de iniciar outra aqui.',
             [AErro.FstrTerminalDetentor]);
    Exit(False);
  end;

  { 3) Travado de verdade - e ai, e so ai, o operador decide (RN16). }
  if not Assigned(VS_funcConfirmaTomadaPinpadTef) then
  begin
    { Host que nao registrou o callback (versao anterior, ou um host que nao
      seja o autcom.exe). Sem quem perguntar, nao se assume nada. }
    pLogaDiagnosticoDvc(
      'fResolveDisputaPinpad: o detentor esta travado, mas nao ha funcao de confirmacao ' +
      'registrada pelo host - a tomada do pinpad NAO acontece (RN16 exige confirmacao humana).');
    Exit(False);
  end;

  { O PID saiu do TEXTO (revisao de 2026-09-18) e NAO da apuracao: ele
    continua em todas as linhas de log deste metodo, que e onde o suporte
    olha. Na tela ele so competia com a pergunta. }
  LstrPergunta :=
    Format('O pinpad está preso pelo terminal %s, que parou de responder.' + #13#13 +
           'Assumir o pinpad para este terminal?' + #13#13 +
           'A transação pendente do terminal %s continuará no relatório de pendências ' +
           'do TEF, e aquele AUTCOM não será fechado.',
           [AErro.FstrTerminalDetentor, AErro.FstrTerminalDetentor]);

  { Esta linha existe para o caso em que NAO vem nenhuma linha depois dela
    (Req. 456190, 2026-09-10). O cenario do autcom travado nao da para
    reproduzir em laboratorio, entao o log de producao e a unica evidencia -
    e sem esta marca havia silencio total entre o IsHungAppWindow=True e a
    resposta do operador. Se o log terminar aqui, a pergunta NAO foi
    respondida, e as duas explicacoes possiveis estao no proprio texto. }
  pLogaDiagnosticoDvc(Format(
    'fResolveDisputaPinpad: o autcom pid=%d esta vivo mas com a janela TRAVADA - PERGUNTANDO AO ' +
    'OPERADOR agora (RN16). Se nao houver mais nenhuma linha deste pid depois desta, a pergunta ' +
    'nao foi respondida: ou o operador saiu de perto, ou o proprio fMensagem ficou preso atras ' +
    'de outro modal na fila da thread principal.', [AErro.FdwPidDetentor]));

  { Com o humano no circuito, um eventual engano do IsHungAppWindow (uma
    janela que demorou a responder por um instante) vira um "nao", e nao uma
    transacao de outro caixa quebrada em silencio. }
  LdwInicioPergunta := GetTickCount;
  LblnConfirmou := VS_funcConfirmaTomadaPinpadTef(LstrPergunta);

  if LblnConfirmou then
  begin
    pLogaDiagnosticoDvc(Format(
      'fResolveDisputaPinpad: o operador CONFIRMOU a tomada do pinpad do pid=%d (respondeu em %d ms).',
      [AErro.FdwPidDetentor, GetTickCount - LdwInicioPergunta]));
    FdwPidDisputa := AErro.FdwPidDetentor;
    FstrInicioProcessoDisputa := AErro.FstrInicioProcessoDetentor;
    FblnDisputaConfirmadaPeloOperador := True;
    Exit(True);
  end;

  pLogaDiagnosticoDvc(Format(
    'fResolveDisputaPinpad: o operador RECUSOU assumir o pinpad do pid=%d (respondeu em %d ms) - ' +
    'a operacao segue como negativa.',
    [AErro.FdwPidDetentor, GetTickCount - LdwInicioPergunta]));
end;

procedure TTefCitelDvc.pLimpaVereditoDisputa;
begin
  FdwPidDisputa := 0;
  FstrInicioProcessoDisputa := '';
  FblnDisputaProcessoMorto := False;
  FblnDisputaConfirmadaPeloOperador := False;
end;

{ Uma vez POR THREAD - ver o porque no uso, em fChamaRpcUmaVez. threadvar
  nasce zerado em cada thread, entao nao precisa de lock nem de lista. }
threadvar
  FblnThreadDiagLogado: Boolean;

function TTefCitelDvc.fChamaRpcUmaVez(const AstrMetodo: String; ADados: TJSONObject): TJSONObject;
var
  LintId: Integer;
  LPendente: TTefCitelDvcChamadaPendente;
  LJsonResposta, LObjDetentor: TJSONObject;
  LValorResult: TJSONValue;
  LblnJaEmAndamento: Boolean;
  LErroDisputa: ETefCitelDvcPinpadContestavel;
  { Servico da estacao parado (Req. 456190, 2026-09-12) - ver o comentario
    do laco de espera. }
  LblnEntregaConfirmada, LblnDesistiuSemEntrega: Boolean;
  LblnEnvioConcluido: Boolean;
  LdwInicioEspera: DWORD;
  LstrDiag: String;
begin
  Result := nil; // Result so e de fato atribuido apos o try/finally abaixo (que pode "raise"); silencia W1035

  { Guard contra clique duplo/repetido no mesmo botao (Req. 456190, achado
    em campo 2026-08-28 - dois EAccessViolation reais no autcom, um clicando
    "Credito" duas vezes, outro clicando "a vista" varias vezes seguidas).
    Causa: fChamaRpc, na thread principal, bombeia Application.ProcessMessages
    enquanto espera (ver comentario mais abaixo) - um segundo clique no MESMO
    botao e processado de forma reentrante ANTES da resposta da primeira
    chamada chegar, disparando o MESMO metodo duas vezes em paralelo. Duas
    chamadas concorrentes do mesmo metodo (fPassarCartao ou pInfo21,
    confirmado nos dois casos) corrompem o transporte DVC o suficiente pra
    derrubar a thread de leitura (EAccessViolation em
    untTefCitelDvcTransporte.pExtraiFramesDisponiveis).

    Isso NAO impede o aninhamento legitimo entre METODOS DIFERENTES
    (fPassarCartao esperando enquanto pInfo21/pInfo30/etc. da Modalidade
    Dinamica precisam chegar durante essa espera) - so rejeita uma SEGUNDA
    chamada do MESMO metodo enquanto a primeira ainda nao terminou. Rejeicao
    e silenciosa (retorna um JSON vazio, sem lancar excecao) de proposito -
    um clique duplo e uma situacao esperada de operador, nao um erro real
    que mereca dialogo de excecao. }
  FcsMetodosEmAndamento.Enter;
  try
    LblnJaEmAndamento := FdictMetodosEmAndamento.ContainsKey(AstrMetodo);
    if not LblnJaEmAndamento then
      FdictMetodosEmAndamento.Add(AstrMetodo, True);
  finally
    FcsMetodosEmAndamento.Leave;
  end;

  if LblnJaEmAndamento then
  begin
    pLogaDiagnosticoDvc(Format(
      'fChamaRpcUmaVez("%s") IGNORADO: ja existe uma chamada deste mesmo metodo em andamento ' +
      '(provavel clique duplo/repetido) - nao despachando de novo.', [AstrMetodo]));
    { Quem consome ADados e o pEnviaEnvelope la embaixo, que nao vai rodar
      neste caminho - sem este Free o objeto vaza a cada clique duplo
      (pre-existente; visto de perto ao dividir este metodo no Passo 6). }
    ADados.Free;
    Exit(TJSONObject.Create);
  end;

  try

  LintId := TInterlocked.Increment(FintProximoId);
  LPendente := TTefCitelDvcChamadaPendente.Create;
  LblnEnvioConcluido := False;

  FcsChamadas.Enter;
  try
    FdictChamadas.Add(LintId, LPendente);
  finally
    FcsChamadas.Leave;
  end;

  { Da inscricao ate a retirada do FdictChamadas, qualquer excecao (envio
    com canal caido, ou uma closure drenada pelo CheckSynchronize da espera)
    tem de levar a chamada junto: sem isto ela ficava orfa no dicionario -
    o reata seguia pedindo por ela - e o LPendente vazava. Campo 2026-09-28.
    O caminho normal nao muda: a retirada e a liberacao continuam logo depois
    da espera, onde sempre estiveram. Sem reindentar, no estilo do try
    externo deste metodo. }
  try
  { Instrumentacao temporaria (Req. 456190, 2026-09-02): trava intermitente onde o
    fChamaRpc de fPassarCartao (ultimo cartao de uma venda com 2+) nunca retorna,
    mesmo com a resposta chegando completa e intacta pelo transporte (confirmado em
    campo 2026-09-02, 2281 bytes remontados dos dois lados) - pTrataResposta esta
    aparentemente nao encontrando o id na FdictChamadas quando a resposta chega.
    Log abaixo (aqui e em pTrataResposta) serve pra provar isso. Remover quando a
    causa raiz for confirmada e corrigida. }
  pLogaDiagnosticoDvc(Format('fChamaRpcUmaVez: registrado id=%d metodo="%s" em FdictChamadas.', [LintId, AstrMetodo]));

  LblnEntregaConfirmada := fEnviaEnvelope('chamada', LintId, AstrMetodo, ADados);
  LblnEnvioConcluido := True;
  LblnDesistiuSemEntrega := False;
  LdwInicioEspera := GetTickCount;

  { Uma chamada RPC (ex.: fPassarCartao) pode levar minutos (operador
    escolhendo parcelamento no pinpad) e, nesse meio tempo, a estacao pode
    precisar de um "hook" sincrono (Antes*/Depois*) que so pode ser
    executado na thread principal (toca callbacks de UI). O hook chega pela
    thread de leitura do transporte e usa TThread.Synchronize para isso. Se
    esta chamada estiver bloqueada na thread principal com um WaitFor puro,
    o Synchronize nunca seria processado - deadlock. Por isso, quando quem
    chamou esta na thread principal, o espera precisa bombear
    CheckSynchronize periodicamente em vez de bloquear direto.

    CheckSynchronize sozinho so drena a fila de TThread.Synchronize - ele
    NAO despacha a fila de mensagens do Windows. Na arquitetura classica
    (CFG_TEFDVC = N), o laco de polling local de untTefCitelNCR/untTefCitel
    ficava no mesmo processo e chamava Application.ProcessMessages durante a
    espera (efeito colateral de como aquele laco era escrito), o que mantinha
    os timers (tmrAtualizaMsg/tmrCenCar) e os cliques de
    TfrmTefCitelOperacoes (Credito/Debito/A vista/parcelado, incluindo o
    fluxo de Modalidade Dinamica) funcionando mesmo com a chamada ainda em
    andamento. A versao DVC perdeu esse bombeamento: eventos/hooks chegam e
    atualizam a tela via Synchronize (por isso "recebe mensagens do TEF"),
    mas cliques do operador ficam enfileirados sem serem despachados (tela
    "trava" para interacao) - bug real observado em campo em 2026-08-28.
    Corrigido bombeando tambem Application.ProcessMessages aqui, restaurando
    o mesmo comportamento da arquitetura classica. }
  { SERVICO DA ESTACAO PARADO (Req. 456190, 2026-09-12).

    A espera abaixo e INFINITA de proposito e continua sendo: uma chamada TEF
    pode levar minutos com o operador no pinpad, e IA\rules\tef-dvc.md proibe
    impor teto sobre esse tempo. A regra nao muda aqui e nao deve mudar.

    O caso que este bloco resolve e OUTRO, e a diferenca nao e de grau: o
    servico da estacao esta parado. O canal DVC continua de pe (o plugin vive
    dentro do mstsc/TSPlus, nao no servico), o envelope sai, e o plugin o
    enfileira num socket morto. Antes disto, o autcom esperava para sempre por
    uma resposta que nao viria - travando a carga ou a operacao do caixa.

    O QUE DISTINGUE OS DOIS CASOS E O ACK, e ele e evidencia, nao palpite:
    quem emite o ACK e o SERVICO da estacao. O plugin e relay burro - o
    cabecalho de untTefCitelDvcPluginImpl.pas diz, literalmente, que nenhuma
    logica de protocolo e interpretada la. Entao:

      - ACK chegou  -> o pedido ALCANCOU o servico. Pode estar no pinpad, pode
                       levar minutos. Espera infinita, como sempre.
      - ACK nao veio -> o pedido NAO passou do plugin. Nada foi executado no
                       pinpad, nao existe transacao em curso para proteger, e
                       desistir e constatar um fato - nao arbitrar um prazo.

    Isto tambem nao e uma invencao nova: pEnviaFrame ja registra, ha tempo,
    que ao esgotar as tentativas de ACK ele segue em "melhor esforco" porque
    "o proprio timeout de negocio (hook de 30s, ou o chamador RPC
    correspondente) ainda pega isso". No chamador RPC esse backstop nunca
    existiu. Este bloco e ele.

    A queda do CANAL ja tinha tratamento (ErroCanal / ETefCitelDvcCanal, logo
    abaixo) - o buraco era exatamente canal de pe com servico parado. }
  { Diagnostico de thread (Req. 456190, campo 2026-09-25 e 2026-09-28). O ramo
    logo abaixo e o UNICO dreno da fila de TThread.Queue desta DLL - ela
    linka a propria RTL, entao o laco de mensagens do autcom.exe nao a
    enxerga. Se o teste falhar na thread da tela, nenhum evento chega ao
    operador e o sintoma na loja e "o TEF travou", sem uma linha dizendo
    por que. Causa e correcao em pSetThreadPrincipalHost
    (untFuncoesLibTefCitel.pas).

    UMA VEZ POR THREAD, e nao por processo. A primeira versao logava so a
    primeira chamada do processo - e essa chamada vem, por construcao, da
    thread que carregou a DLL, que sempre "coincide" com o MainThreadID
    dela. Em 28/09 isso escondeu o defeito inteiro: a linha disse
    "coincidem" para o fConfiguraTefCitel do TTask do Pix e ficou muda
    quando a tela passou a chamar de OUTRA thread - 8 eventos, zero
    entregues, e o log afirmando que estava tudo bem. }
  if not FblnThreadDiagLogado then
  begin
    FblnThreadDiagLogado := True;

    if TThread.CurrentThread.ThreadID = MainThreadID then
      LstrDiag := 'coincidem - esta thread drena a fila de eventos.'
    else
      LstrDiag := 'NAO coincidem - esta thread espera SEM drenar a fila de ' +
        'eventos. Se for a thread da tela, nenhuma mensagem do pinpad chega ao ' +
        'operador.';

    if VS_blnThreadPrincipalHostAcertada then
      LstrDiag := LstrDiag + ' MainThreadID definido pelo host.'
    else
      LstrDiag := LstrDiag + ' Sem acerto do host: o MainThreadID e o da thread ' +
        'que carregou a DLL (normal sem Pix, quando quem carrega e a carga do TEF).';

    pLogaDiagnosticoDvc(Format(
      'Threads: MainThreadID da DLL=%d, thread que chama o RPC=%d (metodo "%s") - %s',
      [MainThreadID, TThread.CurrentThread.ThreadID, AstrMetodo, LstrDiag]));
  end;

  if TThread.CurrentThread.ThreadID = MainThreadID then
  begin
    while LPendente.Evento.WaitFor(20) = wrTimeout do
    begin
      CheckSynchronize(0);
      Application.ProcessMessages;

      if (not LblnEntregaConfirmada) and
         (GetTickCount - LdwInicioEspera >= TEF_DVC_TIMEOUT_SEM_CONFIRMACAO_MS) then
      begin
        LblnDesistiuSemEntrega := True;
        Break;
      end;
    end;

    { CAUSA RAIZ do bug de "mensagem da transacao anterior aparecendo no inicio
      da transacao seguinte" (Req. 456190, provado em campo 2026-09-03).

      O laco acima sai NA HORA em que o Evento e sinalizado (resposta chegou),
      sem drenar a fila de TThread.Queue uma ultima vez. So que o ULTIMO evento
      de uma transacao - justamente o status=500 com o motivo da negacao
      ("Cartao Debito / NAO AUTORIZADA") - chega alguns MILISSEGUNDOS ANTES da
      resposta RPC do proprio fPassarCartao (medido: 10 ms no log de
      2026-09-03, 07:30:58.172 vs 07:30:58.182). Ele e enfileirado por
      pTrataEvento via TThread.Queue, mas a resposta chega em seguida, o laco
      sai, a thread principal para de bombear e a closure fica ORFA na fila.

      Ela so roda quando a thread principal volta a bombear - isto e, no
      PROXIMO fChamaRpc, que ja e a transacao SEGUINTE. Ai pNotifica entrega a
      mensagem velha para o observer ATUAL (a tela nova), porque pNotifica so
      enxerga o FObservers do momento em que roda. Confirmado no log: evento
      enfileirado 07:30:58.172 (transacao 1) e despachado 07:32:47.116
      (transacao 2), 1min49s depois.

      Pior que exibir a mensagem errada: essa closure atrasada abre um
      fMensagem MODAL e, como esta na FRENTE da closure do hook
      "AntesPassarCartao" na fila FIFO, prende o hook ate o operador clicar OK -
      estourando o TEF_ESTACAO_TIMEOUT_HOOK_MS (30s) do lado da estacao e
      derrubando a transacao nova inteira ("Transacao cancelada" / "Erro
      Desconhecido (-1)" no mesmo log).

      Correcao: drenar a fila uma ultima vez ANTES de sair, para que o evento
      que chegou junto com a resposta seja processado ainda DENTRO da chamada
      que o originou - com o observer certo, na transacao certa. Se essa
      drenagem abrir um modal, a thread principal bloqueia aqui - o que e o
      comportamento correto: a estacao ja respondeu (nada do lado do pinpad
      esta esperando), e a mensagem aparece exatamente onde deveria.

      Nao viola IA\rules\tef-dvc.md - nao adiciona teto de tempo nenhum sobre a
      chamada TEF, so garante que a fila de notificacoes ja recebida seja
      drenada antes de devolver o controle.

      O guard de metodo duplicado (topo desta funcao) precisa ser liberado
      ANTES da drenagem: a resposta ja chegou, entao ele nao tem mais funcao
      aqui - e se a closure drenada despachar um evento que dispare o MESMO
      metodo (o padrao status="131" -> pInfo21 da Modalidade Dinamica, que
      aparece dezenas de vezes nos logs), o guard rejeitaria essa chamada
      legitima por engano, silenciosamente. O Remove no finally la embaixo
      continua existindo para os caminhos de excecao e e inofensivo aqui
      (TDictionary.Remove de chave inexistente nao levanta erro). }
    FcsMetodosEmAndamento.Enter;
    try
      FdictMetodosEmAndamento.Remove(AstrMetodo);
    finally
      FcsMetodosEmAndamento.Leave;
    end;

    CheckSynchronize(0);
  end
  else
  begin
    { Mesma regra fora da thread principal, sem o bombeamento (aqui nao ha
      fila da VCL para drenar). O WaitFor(INFINITE) de antes vira um laco so
      quando a entrega NAO foi confirmada - confirmada, segue infinito. }
    if LblnEntregaConfirmada then
      LPendente.Evento.WaitFor(INFINITE)
    else
      while LPendente.Evento.WaitFor(200) = wrTimeout do
        if GetTickCount - LdwInicioEspera >= TEF_DVC_TIMEOUT_SEM_CONFIRMACAO_MS then
        begin
          LblnDesistiuSemEntrega := True;
          Break;
        end;
  end;

  except
    FcsChamadas.Enter;
    try
      FdictChamadas.ExtractPair(LintId);
    finally
      FcsChamadas.Leave;
    end;
    LPendente.Free;
    { Falha de ENVIO - canal ja fora, ou caiu esperando o ACK de entrega - e
      a mesma queda que a espera trata com ErroCanal, so pega em outro
      instante. Como ETefCitelDvcTransporte ela passava por todos os
      tratamentos de queda (fPassarCartao, fFinalizarTransacao...): erro na
      tela, LOGERR e, na finalizacao, LCKATC presa (Req. 470363). }
    if (not LblnEnvioConcluido) and (ExceptObject is ETefCitelDvcTransporte) then
      raise ETefCitelDvcCanal.CreateFmt('Canal TEF DVC indisponivel ao enviar "%s": %s',
        [AstrMetodo, Exception(ExceptObject).Message]);
    raise;
  end;

  FcsChamadas.Enter;
  try
    FdictChamadas.ExtractPair(LintId); // remove sem liberar - liberamos abaixo, fora do lock
  finally
    FcsChamadas.Leave;
  end;

  try
    if LblnDesistiuSemEntrega then
    begin
      pLogaDiagnosticoDvc(Format(
        'fChamaRpcUmaVez("%s"): o servico da estacao nunca confirmou a entrega do envelope ' +
        'id=%d e nao respondeu em %d ms - desistindo. O canal DVC esta de pe (o plugin vive ' +
        'no cliente RDP, nao no servico), entao o pedido ficou enfileirado no plugin e NAO ' +
        'chegou ao pinpad: nao ha transacao em curso para proteger.',
        [AstrMetodo, LintId, TEF_DVC_TIMEOUT_SEM_CONFIRMACAO_MS]));
      raise ETefCitelDvcServicoIndisponivel.CreateFmt(
        'O servico de TEF da estacao nao respondeu em %d segundos. Verifique se o servico ' +
        'TefEstacaoService esta em execucao na estacao e tente novamente. (metodo "%s")',
        [TEF_DVC_TIMEOUT_SEM_CONFIRMACAO_MS div 1000, AstrMetodo]);
    end;

    if LPendente.ErroCanal then
      raise ETefCitelDvcCanal.CreateFmt(
        'Canal TEF DVC desconectado enquanto aguardava resposta de "%s".', [AstrMetodo]);

    LJsonResposta := LPendente.Resposta;
    if not Assigned(LJsonResposta) then
      raise ETefCitelDvcRpc.CreateFmt('Resposta vazia da estacao para "%s".', [AstrMetodo]);

    if not fJsonBool(LJsonResposta, 'ok', True) then
    begin
      { RF29, item 3 do Passo 8 (2026-09-10) - a estacao marca esta recusa
        especifica com motivo="loginNecessario". Nao e erro de aplicacao: e
        um pedido para refazer o login. Quem trata e a casca fChamaRpc.

        Um servico ANTIGO contra esta DLL nao manda o campo, cai no raise
        generico abaixo e o comportamento e o de antes deste patch - a
        mensagem acionavel da estacao chega ao operador. }
      if fJsonStr(LJsonResposta, 'motivo') = 'loginNecessario' then
        raise ETefCitelDvcLoginNecessario.CreateFmt(
          'A estacao nao conhece o login do TEF deste autcom em "%s": %s',
          [AstrMetodo, fJsonStr(LJsonResposta, 'erro', 'erro desconhecido')]);

      raise ETefCitelDvcRpc.CreateFmt('Estacao retornou erro em "%s": %s',
        [AstrMetodo, fJsonStr(LJsonResposta, 'erro', 'erro desconhecido')]);
    end;

    { Recusa CONTESTAVEL (Req. 456190, RF27, Passo 6). Vem com ok=true de
      proposito - nao e erro de aplicacao, e um pedido de veredito sobre o
      detentor do pinpad. Quem trata e a casca fChamaRpc; nunca chega a tela. }
    if fJsonStr(LJsonResposta, 'motivo') = 'pinpadContestavel' then
    begin
      LObjDetentor := fJsonObj(LJsonResposta, 'detentor');
      LErroDisputa := ETefCitelDvcPinpadContestavel.Create(
        fJsonStr(LJsonResposta, 'erro', 'O pinpad desta estacao esta preso por outro AUTCOM.'));
      LErroDisputa.FdwPidDetentor := DWORD(fJsonInt(LObjDetentor, 'pid', 0));
      LErroDisputa.FstrInicioProcessoDetentor := fJsonStr(LObjDetentor, 'inicioProcesso');
      LErroDisputa.FstrTerminalDetentor := fJsonStr(LObjDetentor, 'terminal');
      LErroDisputa.FblnConexaoVivaDetentor := fJsonBool(LObjDetentor, 'conexaoViva', False);
      raise LErroDisputa;
    end;

    LValorResult := LJsonResposta.GetValue('result');
    if Assigned(LValorResult) and (LValorResult is TJSONObject) then
      Result := LValorResult.Clone as TJSONObject
    else
      Result := TJSONObject.Create;
  finally
    LPendente.Free;
  end;
  finally
    FcsMetodosEmAndamento.Enter;
    try
      FdictMetodosEmAndamento.Remove(AstrMetodo);
    finally
      FcsMetodosEmAndamento.Leave;
    end;
  end;
end;

procedure TTefCitelDvc.pOnDesconectado;
begin
  fMataChamadasPendentes;
end;

{ O corpo saiu de pOnDesconectado em 2026-09-11, quando apareceu o segundo
  chamador (Req. 456190). As duas situacoes sao diferentes e o desfecho e o
  mesmo:

    - pOnDesconectado: o canal DVC caiu de verdade;
    - pRefazTefSeServicoReiniciou: o canal NAO caiu, mas o processo do
      servico morreu com as chamadas dentro dele. A instancia nova nao
      conhece id nenhum da antiga, entao resposta nunca vai vir.

  ErroCanal faz fChamaRpcUmaVez levantar ETefCitelDvcCanal, que as cascas
  (fPassarCartao e companhia) traduzem em pNotificaCanalCaiu: negativa 500
  na tela, retorno vazio, callback "Depois*" rodando e trava LCKATC
  liberada. Caminho ja validado em campo - o reinicio do servico reusa ele
  em vez de ganhar mecanismo proprio (mesmo principio do item 3 do Passo 8:
  dois detectores, uma implementacao). }
function TTefCitelDvc.fMataChamadasPendentes: Integer;
var
  LPendente: TObject;
begin
  Result := 0;
  FcsChamadas.Enter;
  try
    for LPendente in FdictChamadas.Values do
    begin
      TTefCitelDvcChamadaPendente(LPendente).ErroCanal := True;
      TTefCitelDvcChamadaPendente(LPendente).Evento.SetEvent;
      Inc(Result);
    end;
  finally
    FcsChamadas.Leave;
  end;
end;

procedure TTefCitelDvc.pOnConectado;
var
  LdwTickDespacho: DWORD;
begin
  { Thread curta so para sair da thread de leitura antes de escrever
    (Req. 456190, RF26). Ver o comentario em fReconectaCanal, do transporte:
    escrever daqui esperaria um ACK que somente a thread de leitura pode
    receber - e ela estaria presa neste handler. }
  { ITEM 3 DO PASSO 8 (Req. 456190, 2026-09-12). Na bateria de 11/09 o
    "reata" saiu 15-18 s depois do REABERTO em 5 dos 10 ciclos, e o log nao
    diz onde o tempo foi. O carimbo de hora do log NAO serve para medir
    isto: ele e tirado dentro do FcsLog, depois da gravacao da linha
    anterior (ver a secao do reata em IA\rules\tef-dvc.md). GetTickCount
    e imune a isso.

    A closure captura LdwTickDespacho por REFERENCIA, no frame de heap que
    ela mantem vivo - seguro aqui porque a variavel nunca e escrita depois
    do .Start. }
  LdwTickDespacho := GetTickCount;
  TThread.CreateAnonymousThread(
    procedure
    begin
      try
        pEnviaReata(GetTickCount - LdwTickDespacho);
      except
        on E: Exception do
          pLogaDiagnosticoDvc(Format(
            'pEnviaReata falhou (%s: %s) - a estacao so vai descobrir este autcom na primeira ' +
            'chamada, como antes do Passo 3. Nao e fatal.', [E.ClassName, E.Message]));
      end;
    end).Start;
end;

procedure TTefCitelDvc.pEnviaReata(const AdwAtrasoPartidaMs: DWORD);
var
  LDados: TJSONObject;
  LarrIds: TJSONArray;
  LintId, LintQtd: Integer;
  { Item 3 do Passo 8 - ver o comentario em pOnConectado. }
  LdwTickEntrada, LdwTickChamadas, LdwEsperaChamadas: DWORD;
begin
  LdwTickEntrada := GetTickCount;
  { "reata": primeiro frame de cada conexao NOVA (Req. 456190, RF26). Diz
    quem somos (o contexto, montado por pEnviaEnvelope, leva pid e
    inicioProcesso), qual instancia do servico conheciamos e quais ids de
    chamada ainda estao pendentes aqui.

    Sem ele a estacao so descobria o pid na primeira chamada depois de
    reconectar - e um autcom bloqueado esperando resposta nao faz chamada
    nova. Era o furo registrado no Passo 8. }
  LarrIds := TJSONArray.Create;
  LintQtd := 0;
  LdwTickChamadas := GetTickCount;
  FcsChamadas.Enter;
  try
    { A CHAVE do dicionario e o id da chamada (ver fChamaRpc), entao itera
      Keys - TTefCitelDvcChamadaPendente nao guarda o proprio id. }
    for LintId in FdictChamadas.Keys do
    begin
      LarrIds.Add(LintId);
      Inc(LintQtd);
    end;
  finally
    FcsChamadas.Leave;
  end;
  LdwEsperaChamadas := GetTickCount - LdwTickChamadas;

  LDados := TJSONObject.Create;
  LDados.AddPair('instanciaServico', FstrInstanciaServico);
  LDados.AddPair('ids', LarrIds); // LDados assume a posse

  { Os tres numeros separam, numa linha so, as tres unicas explicacoes
    possiveis para o "reata" atrasado (item 3 do Passo 8): partida = a
    thread anonima nao rodou; FcsChamadas = havia chamada RPC segurando o
    lock; total = o tempo foi na montagem/alocacao (gerenciador ShareMem
    compartilhado com o autcom.exe). Se os tres vierem baixos e o carimbo
    ainda estiver atrasado, a causa e o proprio log - e ai o campo
    gravAnterior= do prefixo aponta. Custo: 3 GetTickCount por reconexao. }
  pLogaDiagnosticoDvc(Format(
    'pEnviaReata: mandando "reata" com %d id(s) pendente(s) e instancia conhecida "%s". ' +
    'Atrasos: partida da thread %d ms, FcsChamadas %d ms, total ate aqui %d ms.',
    [LintQtd, FstrInstanciaServico, AdwAtrasoPartidaMs, LdwEsperaChamadas,
     GetTickCount - LdwTickEntrada]));

  pEnviaEnvelope('reata', 0, '', LDados); // pEnviaEnvelope assume a posse de LDados
end;

procedure TTefCitelDvc.pPreparaReinicioDaEstacao;
begin
  if Assigned(FTransporte) then
    FTransporte.pAgendaZeraDedupPorReinicioDaEstacao;
end;

procedure TTefCitelDvc.pTrataReataResposta(AJson: TJSONObject);
var
  LObjDados: TJSONObject;
  LarrEstados: TJSONArray;
  LValorEstados: TJSONValue;
  LstrInstancia, LstrEstados, LstrAviso: String;
  LintIdx: Integer;
  LblnReiniciou: Boolean;
begin
  LObjDados := fJsonObj(AJson, 'dados');
  LstrInstancia := fJsonStr(LObjDados, 'instanciaServico');

  LblnReiniciou := (FstrInstanciaServico <> '') and (LstrInstancia <> '') and
                   (FstrInstanciaServico <> LstrInstancia);

  LstrEstados := '';
  if Assigned(LObjDados) then
  begin
    { "is" e nao "as", pelo mesmo motivo do lado estacao: esta funcao roda na
      cadeia de leitura do canal, e excecao aqui e tratada como desconexao. }
    LarrEstados := nil;
    LValorEstados := LObjDados.GetValue('estados');
    if (LValorEstados <> nil) and (LValorEstados is TJSONArray) then
      LarrEstados := TJSONArray(LValorEstados);

    if Assigned(LarrEstados) then
      for LintIdx := 0 to LarrEstados.Count - 1 do
      begin
        if LstrEstados <> '' then
          LstrEstados := LstrEstados + ', ';
        LstrEstados := LstrEstados + LarrEstados.Items[LintIdx].ToJSON;
      end;
  end;

  { RF29, Passo 7 - agora AGE, e nao so registra.

    O que sobrou para agir e menos do que a RF29 previa, e vale dizer por que:
    "falhar a chamada pendente com esse motivo" ficou letra morta quando a
    RF25 parte 2 saiu de escopo em 09/09. Sem a espera pela reconexao, as
    chamadas pendentes ja morreram com ErroCanal muito antes de o reata
    chegar - nao existe chamada pendente para falhar.

    O que continua real, e e o que esta implementado: marcar que o TEF deste
    autcom precisa ser refeito. A sessao Scope da transacao anterior morreu
    com o processo antigo do servico, entao a instancia nova nao sabe nada
    deste autcom - inclusive nao sabe da pendencia. O re-login acontece na
    proxima chamada (fChamaRpc), que e o instante em que o operador esta de
    fato na tela para ler o aviso. }
  if LblnReiniciou then
  begin
    LstrAviso := ' - MUDOU, o servico da estacao reiniciou desde a ultima conexao';
    InterlockedExchange(FintServicoReiniciou, 1);
  end
  else
    LstrAviso := '';

  pLogaDiagnosticoDvc(Format(
    'pTrataReataResposta: instancia do servico "%s"%s. Estados dos ids: [%s].',
    [LstrInstancia, LstrAviso, LstrEstados]));

  FstrInstanciaServico := LstrInstancia;
end;

procedure TTefCitelDvc.pOnFrameRecebido(const AbytFrame: TBytes);
var
  LstrJson: String;
  LJson: TJSONObject;
  LstrTipo: String;
begin
  LstrJson := TEncoding.UTF8.GetString(AbytFrame);
  LJson := TJSONObject.ParseJSONValue(LstrJson) as TJSONObject;
  if not Assigned(LJson) then
    Exit; // frame corrompido/nao-JSON - descartado

  try
    LstrTipo := fJsonStr(LJson, 'tipo');
    if LstrTipo = 'resposta' then
      pTrataResposta(LJson)
    else if LstrTipo = 'evento' then
      pTrataEvento(LJson)
    else if LstrTipo = 'hook' then
      pTrataHook(LJson)
    else if LstrTipo = 'reata_resposta' then
      pTrataReataResposta(LJson);
  finally
    LJson.Free;
  end;
end;

procedure TTefCitelDvc.pTrataResposta(AJson: TJSONObject);
var
  LintId: Integer;
  LObj: TObject;
  LblnEncontrou: Boolean;
begin
  LintId := fJsonInt(AJson, 'id', -1);
  pLogaDiagnosticoDvc(Format('pTrataResposta: recebido id=%d (tamanho do json bruto=%d bytes).', [LintId, Length(AJson.ToJSON)]));
  FcsChamadas.Enter;
  try
    LblnEncontrou := FdictChamadas.TryGetValue(LintId, LObj);
    if not LblnEncontrou then
    begin
      { Duas causas, e a segunda virou ROTINA (Req. 456190, 2026-09-14).

        1) A chamada DESISTIU no teto de TEF_DVC_TIMEOUT_SEM_CONFIRMACAO_MS e
           o servico respondeu depois - esperado, benigno, e o que acontece
           sempre que o servico da estacao volta. Apareceu 5 vezes so na
           bateria de 14/09.
        2) O defeito de 2026-09-02, em que a resposta chegava com a chamada
           ainda viva no dicionario.

        Se a linha acima no log for uma desistencia por timeout deste mesmo
        id, e o caso 1 e nao ha o que investigar. }
      pLogaDiagnosticoDvc(Format(
        'pTrataResposta: id=%d NAO ENCONTRADO em FdictChamadas (Count=%d) - resposta ignorada. ' +
        'Normal se esta chamada ja desistiu pelo teto de %d ms (o servico respondeu tarde); ' +
        'se NAO houve desistencia deste id, e o defeito investigado em 2026-09-02.',
        [LintId, FdictChamadas.Count, TEF_DVC_TIMEOUT_SEM_CONFIRMACAO_MS]));
      Exit; // resposta de uma chamada desconhecida/ja expirada - ignora
    end;
    pLogaDiagnosticoDvc(Format('pTrataResposta: id=%d encontrado em FdictChamadas - sinalizando Evento.', [LintId]));
    TTefCitelDvcChamadaPendente(LObj).Resposta := AJson.Clone as TJSONObject;
    TTefCitelDvcChamadaPendente(LObj).Evento.SetEvent;
  finally
    FcsChamadas.Leave;
  end;
end;

procedure TTefCitelDvc.pNotificaCanalCaiu(const AstrMetodo: String;
  AExcecao: Exception);
begin
  { Mesma forma que a estacao usa para negar uma operacao
    (pEnviaEventoNegado): status "500" + mensagem. Do lado da tela isso cai em
    AtualizaTefCitel -> strInfo500 -> pMsgInfo500, que preenche o
    FstrMotivoTransacaoNegada de TfrmTefCitelOperacoes - e e ele que a tela
    mostra em vez do texto generico "Houve um problema com a transacao"
    (untTefCitelOperacoes.pas, pPassaCartao).

    A mensagem diz que foi cancelada porque, desde 2026-09-09, e o que de
    fato acontece: a estacao chama pSair no instante em que a conexao cai.
    Mas nao afirma que NADA foi aprovado - se a queda pegou a transacao ja
    fora da fase de coleta, o aborto chega tarde e e ignorado (specs.md 10.5,
    "residuo aceito"). Por isso manda conferir o relatorio. }
  pLogaDiagnosticoDvc(Format(
    'pNotificaCanalCaiu: "%s" terminou em %s - notificando a tela como negativa (status 500) e ' +
    'devolvendo sem retorno, para o callback "Depois*" rodar e liberar a trava LCKATC.',
    [AstrMetodo, AExcecao.ClassName]));

  { SERVICO PARADO e um desfecho MELHOR que queda de canal, e o texto tem de
    dizer isso (Req. 456190, 2026-09-14). Na queda de canal a transacao pode
    ter passado da fase de coleta e o aborto chegar tarde - por isso aquele
    texto manda conferir o relatorio. Aqui nao: se o servico nunca confirmou a
    entrega, o pedido nem saiu do plugin, NADA foi ao pinpad e repetir e
    seguro. Mandar conferir relatorio aqui seria alarme falso, e alarme falso
    repetido e o que faz o operador parar de ler a mensagem. }
  if AExcecao is ETefCitelDvcServicoIndisponivel then
  begin
    pNotificaNegativa(
      'O serviço de TEF da estação não respondeu. A operação não chegou ao pinpad ' +
      'e NADA foi cobrado.' + #13#13 +
      'Verifique se o serviço TefEstacaoService está em execução na estação e repita ' +
      'a operação.');
    Exit;
  end;

  pNotificaNegativa(
    'A comunicação com o TEF caiu e a transação foi cancelada no pinpad.' + #13#13 +
    'Passe o cartão novamente. Antes de repetir, confira no relatório do TEF se o valor ' +
    'chegou a ser aprovado.');
end;

procedure TTefCitelDvc.pNotificaNegativa(const AstrMensagem: String);
var
  LRetorno: IRetornoTEFCitel;
begin
  LRetorno := TRetornoTEFCitel.Create;
  LRetorno.StatusTEF.strStatus   := '500';
  LRetorno.StatusTEF.strMensagem := AstrMensagem;
  pNotifica(LRetorno);
end;

{ AVISO QUE SOBREVIVE A AUSENCIA DE TELA (Req. 456190, achado de campo
  2026-09-11 09:31:27).

  pNotificaNegativa entrega aos observers ATUAIS. Isso e o certo para uma
  negativa de chamada - ela pertence a chamada que esta voltando agora, e
  entregar depois seria mensagem velha na tela nova. Mas o aviso de
  reinicio do servico e outra coisa: ele fala de uma transacao ANTERIOR, e
  o re-login pode ser disparado por um metodo chamado fora da tela de
  transacao. Em campo foi o fFinalizarTransacao no fim da venda, depois do
  RemoveObserver:

    09:31:27.796  pNotifica: despachando status="500" mensagem="O servico de TEF
                  da estacao foi reiniciado..." para 0 observer(es).

  O aviso evaporou exatamente no caso em que ele mais importa: o Controle
  09102834016 ficou pendente no servidor do TEF (conferido pelo Rafael no
  relatorio) e o operador nao soube. O desfecho pendente e CORRETO - a
  sessao Scope morreu com o processo antigo do servico e alguem efetiva
  depois; o que faltava era a informacao.

  Por que nao consertar isso do lado da estacao recusando a confirmacao:
  fFinalizarTransacao e procedure SEM retorno (untInterfaceTefCitel.pas), e
  os dois pontos de chamada no autcom sao linha nua sem try/except
  (untTefCitelUtil.pas, pEstornaTransacaoPendente e pFinalizaTranscacao).
  O unico canal seria excecao, que abortaria o fecho de uma venda que hoje
  termina certa - e exigiria mexer em padra_atualizado\fontes\. Medido
  antes de propor, e a proposta mudou por causa da medicao. }
procedure TTefCitelDvc.pAvisaOperadorOuGuarda(const AstrMensagem: String);
begin
  if FObservers.Count > 0 then
  begin
    pNotificaNegativa(AstrMensagem);
    Exit;
  end;

  { O prefixo nao e enfeite: a mensagem vai aparecer numa tela que o
    operador abriu DEPOIS, e sem ele pareceria falar da operacao atual. }
  FcsAviso.Enter;
  try
    FstrAvisoGuardado := 'Aviso da operacao anterior: ' + AstrMensagem;
  finally
    FcsAviso.Leave;
  end;

  pLogaDiagnosticoDvc(
    'pAvisaOperadorOuGuarda: nao havia tela aberta (0 observers) - aviso GUARDADO para a ' +
    'proxima que registrar observer. Mensagem: ' + AstrMensagem);
end;

{ Chamado no fim do AdicionaObserver. Via TThread.Queue, e nao direto, pela
  mesma razao do pTrataEvento: entregar de dentro do AdicionaObserver
  reentraria na tela enquanto ela ainda esta se registrando, e a tela mostra
  status 500 com caixa de mensagem. Enfileirado, o aviso chega quando ela ja
  voltou ao laco de mensagens.

  Se a tela sair antes de a fila rodar, o aviso e guardado de novo em vez de
  ser perdido - nao ha laco, porque so um AdicionaObserver novo reenfileira. }
procedure TTefCitelDvc.pDespachaAvisoGuardado;
var
  LstrAviso: String;
begin
  FcsAviso.Enter;
  try
    LstrAviso := FstrAvisoGuardado;
    FstrAvisoGuardado := '';
  finally
    FcsAviso.Leave;
  end;

  if LstrAviso = '' then
    Exit;

  TThread.Queue(nil,
    procedure
    begin
      if FObservers.Count = 0 then
      begin
        FcsAviso.Enter;
        try
          if FstrAvisoGuardado = '' then
            FstrAvisoGuardado := LstrAviso;
        finally
          FcsAviso.Leave;
        end;
        pLogaDiagnosticoDvc(
          'pDespachaAvisoGuardado: a tela saiu antes de a fila rodar - aviso guardado de novo.');
        Exit;
      end;
      pLogaDiagnosticoDvc('pDespachaAvisoGuardado: entregando aviso guardado a tela que abriu agora.');
      { Guarda pelo mesmo motivo da closure de pTrataHook (ver la). }
      try
        pNotificaNegativa(LstrAviso);
      except
        on E: Exception do
          pLogaDiagnosticoDvc(Format(
            'pDespachaAvisoGuardado: a tela levantou %s ao receber o aviso: %s - aviso perdido.',
            [E.ClassName, E.Message]));
      end;
    end);
end;

procedure TTefCitelDvc.pNotifica(ARetorno: IRetornoTEFCitel);
var
  LObserver: IObserverTEFCitel;
begin
  { Log de diagnostico (Req. 456190, 2026-09-02) - investigacao de mensagem
    de status "cacheada"/reaparecendo na transacao seguinte (ver achado
    abaixo, em pTrataEvento). pNotifica so enxerga o FObservers ATUAL no
    momento em que roda - se essa closure (enfileirada via TThread.Queue)
    executar tarde, depois que o observer da transacao que originou o
    evento ja foi removido e um observer novo (proxima transacao) ja foi
    registrado, a entrega abaixo vai para o observer ERRADO. Logar
    Status/Mensagem e a contagem de observers no momento exato da entrega
    para confirmar isso. }
  pLogaDiagnosticoDvc(Format(
    'pNotifica: despachando status="%s" mensagem="%s" para %d observer(es).',
    [ARetorno.StatusTEF.strStatus, ARetorno.StatusTEF.strMensagem, FObservers.Count]));
  FRetorno := ARetorno;
  for LObserver in FObservers do
    LObserver.AtualizaTefCitel(FRetorno);
end;

procedure TTefCitelDvc.pTrataEvento(AJson: TJSONObject);
var
  LObjDados: TJSONObject;
  LRetorno: IRetornoTEFCitel;
  LintGeracao: Integer;
  LstrStatus, LstrMensagem: String;
begin
  LObjDados := fJsonObj(AJson, 'dados');
  if not Assigned(LObjDados) then Exit;

  LRetorno := fIRetornoTEFCitelDeJson(fJsonObj(LObjDados, 'retorno'));

  { Geracao de observer no momento do enfileiramento - ver comentario no campo
    FintGeracaoObservers e a causa raiz completa em fChamaRpc. A drenagem final
    do fChamaRpc resolve o caso comum (evento chegando junto com a resposta);
    esta checagem cobre o resto: um evento que chegue DEPOIS da chamada ja ter
    retornado nao pode ser entregue a tela da transacao seguinte. }
  LintGeracao := FintGeracaoObservers;
  LstrStatus := LRetorno.StatusTEF.strStatus;
  LstrMensagem := LRetorno.StatusTEF.strMensagem;

  { Log de diagnostico (Req. 456190, 2026-09-02) - achado de campo: mensagem
    de status de UMA transacao (ex.: "NAO AUTORIZADA" de um debito negado)
    reaparecendo no INICIO da transacao SEGUINTE (credito). Log aqui marca
    o instante em que o evento chega e e enfileirado (TThread.Queue,
    logo abaixo) - comparar com o instante em que pNotifica realmente
    despacha (log em pNotifica) revela o atraso real entre os dois. Se o
    mesmo status/mensagem aparecer chegando (pTrataEvento) mais de uma vez
    para a mesma transacao, ou se o atraso ate pNotifica atravessar o
    fechamento/reabertura de tela (RemoveObserver/AdicionaObserver, log em
    AdicionaObserver/RemoveObserver abaixo), confirma a hipotese de que o
    evento atrasado esta sendo entregue ao observer da transacao ERRADA. }
  pLogaDiagnosticoDvc(Format(
    'pTrataEvento: recebido status="%s" mensagem="%s" - enfileirando via TThread.Queue.',
    [LRetorno.StatusTEF.strStatus, LRetorno.StatusTEF.strMensagem]));

  { Deadlock real confirmado em campo (2026-08-28, teste de debito): usava
    TThread.Synchronize aqui, o que bloqueia esta thread (leitura do canal
    DVC) ate a thread principal terminar de processar o evento. Para
    debito sem Modalidade Dinamica (rede que nao exige escolha do
    operador), untTefCitelOperacoes.pMsgInfo131 despacha pInfo21 de forma
    SINCRONA, direto dentro do tratamento do evento (status="131") - e
    fChamaRpc('pInfo21', ...), rodando na thread principal, espera a
    resposta chegar... pela MESMA thread de leitura que esta bloqueada
    aqui esperando este Synchronize terminar. Espera circular, sem saida:
    confirmado com log de diagnostico (pTrataEvento entrava no
    Synchronize e nunca saia; TefEstacaoService.log mostra pInfo21
    despachado e retornado com sucesso do lado da estacao, mas a resposta
    nunca chegava no autcom porque a thread que a entregaria estava presa
    aqui). So acontece no fluxo DVC porque, na arquitetura classica
    (CFG_TEFDVC = N), pInfo21 e uma chamada direta em processo, sem
    round-trip de rede nem troca de thread - o mesmo codigo legado sempre
    foi seguro la.

    Trocado para TThread.Queue: nao bloqueia a thread de leitura (ela
    volta na hora para WTSVirtualChannelRead), entao fica livre pra
    entregar a resposta de qualquer chamada RPC que o processamento do
    evento venha a disparar. Evento e notificacao de progresso best-effort
    (ver comentario em pEnviaEvento, lado estacao) - nao ha garantia de
    ordem estrita contra uma "resposta"/"hook" que chegue quase junto,
    mas isso ja era verdade antes (Synchronize tambem so ordena relativo
    a fila de mensagens da thread principal). Nao viola IA\rules\tef-dvc.md -
    nao adiciona nenhum teto de tempo sobre a chamada TEF em si, so muda
    como a notificacao e entregue a thread principal. }
  TThread.Queue(nil,
    procedure
    begin
      if FintGeracaoObservers <> LintGeracao then
      begin
        pLogaDiagnosticoDvc(Format(
          'pNotifica: DESCARTADO status="%s" mensagem="%s" - evento de uma transacao ' +
          'anterior (geracao de observer %d, atual %d). Ver causa raiz em fChamaRpc.',
          [LstrStatus, LstrMensagem, LintGeracao, FintGeracaoObservers]));
        Exit;
      end;
      { Guarda pelo mesmo motivo da closure de pTrataHook (ver la): pNotifica
        desce em codigo de TELA (observer), e uma excecao dele estouraria
        dentro do fChamaRpcUmaVez que estiver bombeando a fila - derrubando
        a transacao por causa de uma mensagem de andamento. }
      try
        pNotifica(LRetorno);
      except
        on E: Exception do
          pLogaDiagnosticoDvc(Format(
            'pTrataEvento: a tela levantou %s ao receber status="%s" mensagem="%s": %s ' +
            '- evento perdido, transacao segue.',
            [E.ClassName, LstrStatus, LstrMensagem, E.Message]));
      end;
    end);
end;

procedure TTefCitelDvc.pTrataHook(AJson: TJSONObject);
var
  LstrHook: String;
  LintId: Integer;
  LObjDados: TJSONObject;
  LblnGravarErro: Boolean;
  LstrMensagemErro, LstrRelatorio, LstrUltSql: String;
begin
  LintId := fJsonInt(AJson, 'id', -1);
  LstrHook := fJsonStr(AJson, 'hook');
  LObjDados := fJsonObj(AJson, 'dados');

  { Log de diagnostico (Req. 456190, 2026-08-31) - so o tamanho do payload
    aparecia nos logs de transporte, sem o nome do hook - impossivel
    confirmar qual hook (DepoisPassarCartao/SucessoTefCartao/etc.) e o que
    trava so no debito. So chega aqui quando o frame foi remontado por
    completo - se um hook travar na remontagem, este log simplesmente nao
    aparece pra ele (evidencia por ausencia). }
  pLogaDiagnosticoDvc(Format('pTrataHook: hook="%s" id=%d recebido.', [LstrHook, LintId]));

  { Achado de campo (2026-08-31, Req. 456190): os hooks "Depois*"
    (DepoisPassarCartao/DepoisFinalizarTransacao/DepoisCancelarTransacao/
    DepoisReimpressao) e SucessoTefCartao pararam de ser enviados pela
    estacao (untTefEstacaoRoteadorMensagens.pas nao os liga mais na
    instancia real) - o payload de ~2.2KB do DepoisPassarCartao era a UNICA
    mensagem grande/multi-chunk deste protocolo, e a causa de toda a
    investigacao de corrupcao/duplicacao de chunk WTS desta sessao. Os
    callbacks correspondentes (FDepoisPassarCartao/etc.) agora sao chamados
    localmente, sem rede, direto em fPassarCartao/fFinalizarTransacao/
    fCancelaTransacaoTerminal/fReimpressao (mesmo arquivo, logo apos o RPC
    retornar) - o retorno que eles usavam ja vem da propria resposta RPC,
    entao nenhuma informacao se perde. SucessoTefCartao nao tem substituto
    AQUI porque, na linhagem 74.150, o callback do autcom
    (pSucessoTefCartaoEvent, untTefCitelUtil.pas) e um no-op: quem grava a
    TEFTRA e o proprio autcom, em pAtualizaTefTraComDadosAdicionais.
    CORRIGIDO em 2026-09-29: esta frase dizia que o callback "sempre foi um
    no-op", e isso e falso nas linhas 74.111 e 72 - la ele GRAVAVA a TEFTRA,
    chamado pela DLL antiga delas. As duas passaram a gravar pelo autcom:
    a 74.111 no modelo da 74.150 (tres gravacoes), a 72 numa gravacao so, no
    sucesso, como sempre foi la. So os hooks "Antes*" (que
    decidem algo que so o autcom sabe responder - trava de sessao) e
    GravaLogErr (dado real, nao redundante) continuam chegando aqui. }
  if LstrHook = 'GravaLogErr' then
  begin
    LblnGravarErro := fJsonBool(LObjDados, 'gravarErro');
    LstrMensagemErro := fJsonStr(LObjDados, 'mensagemErro');
    LstrRelatorio := fJsonStr(LObjDados, 'relatorio');
    LstrUltSql := fJsonStr(LObjDados, 'ultSql');
  end;

  { Deadlock identico ao ja corrigido em pTrataEvento (2026-08-28, ver
    comentario la): TThread.Synchronize bloqueava esta thread (leitura do
    canal DVC) ate a thread principal terminar de processar o hook E
    mandar "hook_resposta" de volta - mas o ACK dessa resposta so pode ser
    recebido por esta MESMA thread de leitura, presa aqui dentro do
    Synchronize. Resultado: hook_resposta esgotava as 5 tentativas de ACK
    (10s perdidos) em TODO hook, sempre - nao era "aleatorio", era garantido
    por esta espera circular. Trocado para TThread.Queue pelo mesmo motivo/
    padrao ja usado em pTrataEvento: a thread de leitura volta na hora para
    WTSVirtualChannelRead e fica livre pra receber o ACK quando a thread
    principal enviar a resposta. }
  TThread.Queue(nil,
    procedure
    var
      LObjResposta: TJSONObject;
      LblnOk: Boolean;
    begin
      LObjResposta := TJSONObject.Create;

      { As duas guardas desta closure existem pelo mesmo motivo (campo
        2026-09-28, transacao em voo + sessao do TS fechada): o que escapa de
        uma closure de TThread.Queue nao volta para quem enfileirou - estoura
        dentro de QUEM ESTIVER BOMBEANDO a fila. Aqui era o CheckSynchronize
        do fChamaRpcUmaVez do fPassarCartao: a excecao arrancou a espera pela
        metade, pulou a limpeza da chamada e a emulacao do DepoisPassarCartao
        (que libera a LCKATC) e virou tela do madExcept. Mesma familia da
        regra 3 de "Contrato binario EXE <-> libTefCitel.dll" em
        IA\rules\tef-dvc.md.

        Primeira guarda: o callback e codigo do autcom. Se ele falhar, a
        resposta e ok=False - o MESMO default seguro que a estacao aplica
        quando fica sem resposta. }
      try
      if LstrHook = 'AntesPassarCartao' then
      begin
        LblnOk := True;
        if Assigned(FAntesPassarCartao) then
          LblnOk := FAntesPassarCartao();
        LObjResposta.AddPair('ok', TJSONBool.Create(LblnOk));
      end
      else if LstrHook = 'AntesCancelarTransacao' then
      begin
        LblnOk := True;
        if Assigned(FAntesCancelarTransacao) then
          LblnOk := FAntesCancelarTransacao();
        LObjResposta.AddPair('ok', TJSONBool.Create(LblnOk));
      end
      else if LstrHook = 'AntesReimpressao' then
      begin
        LblnOk := True;
        if Assigned(FAntesReimpressao) then
          LblnOk := FAntesReimpressao();
        LObjResposta.AddPair('ok', TJSONBool.Create(LblnOk));
      end
      else if LstrHook = 'GravaLogErr' then
      begin
        if Assigned(FProcLogErr) then
          FProcLogErr(LblnGravarErro, LstrMensagemErro, LstrRelatorio, LstrUltSql);
        LObjResposta.AddPair('ok', TJSONBool.Create(True));
      end
      else
        LObjResposta.AddPair('ok', TJSONBool.Create(False));
      except
        on E: Exception do
        begin
          pLogaDiagnosticoDvc(Format(
            'pTrataHook: o callback do hook "%s" id=%d levantou %s: %s - respondendo ' +
            'ok=False (o mesmo default seguro da estacao).',
            [LstrHook, LintId, E.ClassName, E.Message]));
          LObjResposta.Free;
          LObjResposta := TJSONObject.Create;
          LObjResposta.AddPair('ok', TJSONBool.Create(False));
        end;
      end;

      { Segunda guarda: o envio. Canal caido e o caso real - a sessao do TS
        fecha enquanto o operador ainda esta dentro do callback. Nao ha o que
        fazer com a resposta: a estacao ja acordou o hook "SEM resposta" e
        aplicou o default seguro no instante da queda (pOnDesconectado, lado
        estacao), e a chamada em voo segue pelo reata/fila local. Logar e
        seguir e o desfecho correto; propagar e que derrubava a transacao. }
      try
        pEnviaEnvelope('hook_resposta', LintId, '', LObjResposta); // consome e libera LObjResposta
      except
        on E: Exception do
          pLogaDiagnosticoDvc(Format(
            'pTrataHook: hook_resposta do hook "%s" id=%d NAO enviado (%s: %s) - a ' +
            'estacao aplica o default seguro sozinha quando perde a conexao; seguindo.',
            [LstrHook, LintId, E.ClassName, E.Message]));
      end;
    end);
end;

{ ITefCitel }

function TTefCitelDvc.fConfiguraTefCitel(strEnderecoIp, strCodigoLoja, strNumTerminal: PAnsiChar;
  strConfigResultado: Smallint; strParametrosAdicionais: PAnsiChar; blnSomenteCarregarLib: Boolean): Integer;
var
  LDados, LResult: TJSONObject;
begin
  { RF29 - guardados ANTES da ida, e nao no sucesso: se o login falhar por
    canal caido, e justamente ai que a reaplicacao vai ser necessaria. }
  FstrCfgEnderecoIp := String(AnsiString(strEnderecoIp));
  FstrCfgCodigoLoja := String(AnsiString(strCodigoLoja));
  FstrCfgNumTerminal := String(AnsiString(strNumTerminal));
  FintCfgConfigResultado := strConfigResultado;
  FstrCfgParametrosAdicionais := String(AnsiString(strParametrosAdicionais));
  FblnCfgSomenteCarregarLib := blnSomenteCarregarLib;
  FblnCfgGuardada := True;

  LDados := TJSONObject.Create;
  LDados.AddPair('enderecoIp', FstrCfgEnderecoIp);
  LDados.AddPair('codigoLoja', FstrCfgCodigoLoja);
  LDados.AddPair('numTerminal', FstrCfgNumTerminal);
  LDados.AddPair('configResultado', TJSONNumber.Create(strConfigResultado));
  LDados.AddPair('parametrosAdicionais', FstrCfgParametrosAdicionais);
  LDados.AddPair('somenteCarregarLib', TJSONBool.Create(blnSomenteCarregarLib));

  { Um login novo torna irrelevante qualquer reinicio detectado antes dele. }
  InterlockedExchange(FintServicoReiniciou, 0);

  LResult := fChamaRpc('fConfiguraTefCitel', LDados);
  try
    Result := fJsonInt(LResult, 'valor');
  finally
    LResult.Free;
  end;
end;

function TTefCitelDvc.fPassarCartao(intOperacao, intQtdParcelas: Integer; strModalidade,
  strNumDoc: String; fltValor: Double; strCodOperador: String; blnPagueFacil: Boolean;
  strCodigoCarteiraDigital, strJsonInfoAdicPix: String): IRetornoTEFCitel;
var
  LDados, LResult: TJSONObject;
begin
  LDados := TJSONObject.Create;
  LDados.AddPair('operacao', TJSONNumber.Create(intOperacao));
  LDados.AddPair('qtdParcelas', TJSONNumber.Create(intQtdParcelas));
  LDados.AddPair('modalidade', strModalidade);
  LDados.AddPair('numDoc', strNumDoc);
  LDados.AddPair('valor', TJSONNumber.Create(fltValor));
  LDados.AddPair('codOperador', strCodOperador);
  LDados.AddPair('pagueFacil', TJSONBool.Create(blnPagueFacil));
  LDados.AddPair('codigoCarteiraDigital', strCodigoCarteiraDigital);
  LDados.AddPair('jsonInfoAdicPix', strJsonInfoAdicPix);

  try
    LResult := fChamaRpc('fPassarCartao', LDados);
  except
    on E: ETefCitelDvcCanal do
    begin
      { Queda de canal NAO sobe para a tela (Req. 456190, 2026-09-09). Ela
        era o dialogo do madExcept que o operador via, e - pior - subindo por
        cima do FDepoisPassarCartao la embaixo deixava a trava LCKATC presa,
        porque e o pDepoisPassarCartaoEvent com retorno nil que a libera
        (untTefCitelUtil.pas). Aqui o desfecho e conhecido: a estacao aborta
        a transacao no pinpad quando a conexao cai, entao devolver nil e
        dizer "cancelada" e a verdade. }
      pNotificaCanalCaiu('fPassarCartao', E);
      Result := nil;
      if Assigned(FDepoisPassarCartao) then
        FDepoisPassarCartao(nil); // libera a trava LCKATC
      Exit;
    end;
  end;

  try
    Result := fIRetornoTEFCitelDeJson(fJsonObj(LResult, 'retorno'));
  finally
    LResult.Free;
  end;

  { Geracao da sessao Scope em que esta transacao foi aprovada - lida por
    fFinalizarTransacao (fSessaoDaAprovacaoMorreu, Req. 470363). }
  FcsMetodosEmAndamento.Enter;
  try
    FdictGeracaoAprovacao.AddOrSetValue(strNumDoc, FintQtdRelogins);
  finally
    FcsMetodosEmAndamento.Leave;
  end;

  { Achado de campo (2026-08-31, Req. 456190): DepoisPassarCartao parou de
    ser enviado como hook pela estacao (era o unico payload grande/multi-
    chunk deste protocolo, causa da corrupcao de framing investigada nesta
    sessao) - o callback do autcom (pDepoisPassarCartaoEvent,
    untTefCitelUtil.pas) so olha pro retorno quando ele vem nil, e nunca
    vinha nil no sucesso; o unico dado que ele de fato usaria ja esta aqui
    em Result, vindo da propria resposta RPC. Chamado localmente, sem rede -
    ver comentario em pTrataHook. }
  if Assigned(FDepoisPassarCartao) then
    FDepoisPassarCartao(Result);
end;

procedure TTefCitelDvc.fFinalizarTransacao(Confirma: Boolean; DataStr, HoraStr, DocumentoVinculado,
  ParamAdic: AnsiString);
var
  LDados, LResult: TJSONObject;
  LintReloginsAntes: Integer;
  LblnSessaoDaAprovacaoMorreu: Boolean;
begin
  LblnSessaoDaAprovacaoMorreu := fSessaoDaAprovacaoMorreu(String(DocumentoVinculado));
  FblnFinalizacaoNaoRealizada := False;
  FblnFinalizacaoSeraReenviada := False;
  FstrAvisoReinicioGuardado := '';
  LintReloginsAntes := FintQtdRelogins;

  LDados := TJSONObject.Create;
  LDados.AddPair('confirma', TJSONBool.Create(Confirma));
  LDados.AddPair('dataStr', String(DataStr));
  LDados.AddPair('horaStr', String(HoraStr));
  LDados.AddPair('documentoVinculado', String(DocumentoVinculado));
  LDados.AddPair('paramAdic', String(ParamAdic));

  try
    LResult := fChamaRpc('fFinalizarTransacao', LDados);
  except
    on E: ETefCitelDvcCanal do
    begin
      { fFinalizarTransacao nao TOMA a trava (nao tem hook "Antes*"), mas e
        um dos pontos que a LIBERA: quem faz isso e o
        pDepoisFinalizarTransacaoEvent, sempre. Se a confirmacao morre por
        queda de canal, a trava tomada pelo fPassarCartao que teve retorno
        ficaria presa. }
      pNotificaCanalCaiu('fFinalizarTransacao', E);
      FblnFinalizacaoNaoRealizada := True;
      { Sem re-login nesta chamada, a sessao Scope que tem a transacao pode
        estar viva na estacao: guarda para reenviar (pReenviaFinalizacaoPendente). }
      if (FintQtdRelogins = LintReloginsAntes) and (not LblnSessaoDaAprovacaoMorreu) then
      begin
        { Ja havia uma guardada e esta pede o contrario: a sessao Scope e uma
          so e o reenvio vale para tudo nela. Confirmar vence - desfazer
          derrubaria junto a venda anterior, ja faturada (apontamento do
          DelphAI, 16/10). }
        if FblnReenviarFinalizacao and (FblnReenvioConfirma <> Confirma) then
        begin
          pLogaDiagnosticoDvc(Format(
            'fFinalizarTransacao: ja havia confirmacao guardada (confirma=%s) e esta pede ' +
            'confirma=%s - mantendo a CONFIRMACAO.',
            [BoolToStr(FblnReenvioConfirma, True), BoolToStr(Confirma, True)]));
          FblnReenvioConfirma := True;
        end
        else
          FblnReenvioConfirma := Confirma;
        FstrReenvioData := String(DataStr);
        FstrReenvioHora := String(HoraStr);
        FstrReenvioDocumento := String(DocumentoVinculado);
        FstrReenvioParamAdic := String(ParamAdic);
        FstrReenvioDescricao := ''; // o autcom informa logo em seguida
        FblnReenviarFinalizacao := True;
        FblnFinalizacaoSeraReenviada := True;
      end;
      if Assigned(FDepoisFinalizarTransacao) then
        FDepoisFinalizarTransacao(); // libera a trava LCKATC
      Exit;
    end;
  end;
  LResult.Free;

  { Houve re-login no meio desta chamada: o servico da estacao reiniciou
    depois da aprovacao. O "ok" veio da instancia nova, que nunca teve esta
    transacao - a sessao Scope que a tinha morreu com ela pendente. Gravar
    como efetuada seria o descompasso do Req. 470363 (TEFTRA efetuada, Scope
    pendente, operador sem saber). }
  if (FintQtdRelogins <> LintReloginsAntes) or LblnSessaoDaAprovacaoMorreu then
    FblnFinalizacaoNaoRealizada := True;

  { DepoisFinalizarTransacao parou de ser enviado como hook - ver
    comentario em fPassarCartao/pTrataHook. Chamado localmente aqui. }
  if Assigned(FDepoisFinalizarTransacao) then
    FDepoisFinalizarTransacao();
end;

function TTefCitelDvc.fCancelaTransacaoTerminal(intFuncao: Integer; strCodOpe: AnsiString;
  dtaData: TDate; hraHora: TTime; numdoc: AnsiString; fltValor: Double; strModalidade: String;
  strCodigoCarteiraDigital, strModoEntrada: string): IRetornoTEFCitel;
var
  LDados, LResult: TJSONObject;
begin
  LDados := TJSONObject.Create;
  LDados.AddPair('funcao', TJSONNumber.Create(intFuncao));
  LDados.AddPair('codOpe', String(strCodOpe));
  LDados.AddPair('data', fJsonDeData(dtaData));
  LDados.AddPair('hora', fJsonDeHora(hraHora));
  LDados.AddPair('numDoc', String(numdoc));
  LDados.AddPair('valor', TJSONNumber.Create(fltValor));
  LDados.AddPair('modalidade', strModalidade);
  LDados.AddPair('codigoCarteiraDigital', strCodigoCarteiraDigital);
  LDados.AddPair('modoEntrada', strModoEntrada);

  try
    LResult := fChamaRpc('fCancelaTransacaoTerminal', LDados);
  except
    on E: ETefCitelDvcCanal do
    begin
      { Mesmo motivo de fPassarCartao. Aqui quem libera a trava e o
        pDepoisCancelarTransacaoEvent, que libera sempre. }
      pNotificaCanalCaiu('fCancelaTransacaoTerminal', E);
      Result := nil;
      if Assigned(FDepoisCancelarTransacao) then
        FDepoisCancelarTransacao(nil); // libera a trava LCKATC
      Exit;
    end;
  end;
  try
    Result := fIRetornoTEFCitelDeJson(fJsonObj(LResult, 'retorno'));
  finally
    LResult.Free;
  end;

  { DepoisCancelarTransacao parou de ser enviado como hook - ver
    comentario em fPassarCartao/pTrataHook. Chamado localmente aqui. }
  if Assigned(FDepoisCancelarTransacao) then
    FDepoisCancelarTransacao(Result);
end;

function TTefCitelDvc.fConsultaTransacoesPendentesTerminal: TUniClientDataSet;
begin
  raise ENotSupportedException.Create(
    'fConsultaTransacoesPendentesTerminal nao e suportado via TEF DVC - ' +
    'nao e utilizado pelo projeto (confirmado no levantamento do Req. 456190).');
end;

function TTefCitelDvc.fReimpressao(intFuncao: Integer; strNumDoc: AnsiString; strDtaTra: TDate;
  strCodOpe: AnsiString; fltValTra: Double): IRetornoTEFCitel;
var
  LDados, LResult: TJSONObject;
begin
  LDados := TJSONObject.Create;
  LDados.AddPair('funcao', TJSONNumber.Create(intFuncao));
  LDados.AddPair('numDoc', String(strNumDoc));
  LDados.AddPair('dtaTra', fJsonDeData(strDtaTra));
  LDados.AddPair('codOpe', String(strCodOpe));
  LDados.AddPair('valTra', TJSONNumber.Create(fltValTra));

  try
    LResult := fChamaRpc('fReimpressao', LDados);
  except
    on E: ETefCitelDvcCanal do
    begin
      { Mesmo motivo de fPassarCartao. Quem libera a trava aqui e o
        pDepoisReimpressaoEvent, que libera sempre. }
      pNotificaCanalCaiu('fReimpressao', E);
      Result := nil;
      if Assigned(FDepoisReimpressao) then
        FDepoisReimpressao(nil); // libera a trava LCKATC
      Exit;
    end;
  end;
  try
    Result := fIRetornoTEFCitelDeJson(fJsonObj(LResult, 'retorno'));
  finally
    LResult.Free;
  end;

  { DepoisReimpressao parou de ser enviado como hook - ver comentario em
    fPassarCartao/pTrataHook. Chamado localmente aqui. }
  if Assigned(FDepoisReimpressao) then
    FDepoisReimpressao(Result);
end;

{ Req. 470363 (retorno do QA, 20/10) - queda numa chamada que roda aninhada
  no fPassarCartao: as Info* e o pSair do botao Encerra da tela de operacoes.
  Queda de canal: o fPassarCartao que a envolve ja avisa e libera a LCKATC,
  aqui so log. Servico da estacao parado: o fPassarCartao ja tinha chegado ao
  servico e espera sem prazo (IA\rules\tef-dvc.md) - so termina quando o
  servico volta. Subir daqui era erro tecnico na tela e LOGERR a cada clique,
  sem dizer ao operador o que fazer. }
procedure TTefCitelDvc.pTrataQuedaEmChamadaAninhada(const AstrMetodo: String;
  AExcecao: ETefCitelDvcCanal);
begin
  pLogaDiagnosticoDvc(AstrMetodo + ': ' + AExcecao.Message);
  if AExcecao is ETefCitelDvcServicoIndisponivel then
    pNotificaNegativa(
      'O serviço de TEF da estação não está respondendo. Verifique se o serviço ' +
      'TefEstacaoService está em execução na estação: a transação em andamento é ' +
      'encerrada assim que ele voltar.');
end;

procedure TTefCitelDvc.pSair(blnSair: Boolean);
var
  LDados, LResult: TJSONObject;
begin
  LDados := TJSONObject.Create;
  LDados.AddPair('sair', TJSONBool.Create(blnSair));
  try
    LResult := fChamaRpc('pSair', LDados);
  except
    on E: ETefCitelDvcCanal do
    begin
      pTrataQuedaEmChamadaAninhada('pSair', E);
      Exit;
    end;
  end;
  LResult.Free;
end;

procedure TTefCitelDvc.pInfo34(fltValTra: Double);
var
  LDados, LResult: TJSONObject;
begin
  LDados := TJSONObject.Create;
  LDados.AddPair('valTra', TJSONNumber.Create(fltValTra));
  try
    LResult := fChamaRpc('pInfo34', LDados);
  except
    on E: ETefCitelDvcCanal do
    begin
      pTrataQuedaEmChamadaAninhada('pInfo34', E);
      Exit;
    end;
  end;
  LResult.Free;
end;

procedure TTefCitelDvc.pInfo21(strModalidade: String);
var
  LDados, LResult: TJSONObject;
begin
  LDados := TJSONObject.Create;
  LDados.AddPair('modalidade', strModalidade);
  try
    LResult := fChamaRpc('pInfo21', LDados);
  except
    on E: ETefCitelDvcCanal do
    begin
      pTrataQuedaEmChamadaAninhada('pInfo21', E);
      Exit;
    end;
  end;
  LResult.Free;
end;

procedure TTefCitelDvc.pInfo30(strNumDoc: String; dtaData: TDate; intQtdParc: Integer);
var
  LDados, LResult: TJSONObject;
begin
  LDados := TJSONObject.Create;
  LDados.AddPair('numDoc', strNumDoc);
  LDados.AddPair('data', fJsonDeData(dtaData));
  LDados.AddPair('qtdParc', TJSONNumber.Create(intQtdParc));
  try
    LResult := fChamaRpc('pInfo30', LDados);
  except
    on E: ETefCitelDvcCanal do
    begin
      pTrataQuedaEmChamadaAninhada('pInfo30', E);
      Exit;
    end;
  end;
  LResult.Free;
end;

function TTefCitelDvc.fObtemDadoPinPadDireto(AintTipoDocumento: Integer; AstrChaveAcesso,
  AstrIdentificador: AnsiString): AnsiString;
var
  LDados, LResult: TJSONObject;
begin
  LDados := TJSONObject.Create;
  LDados.AddPair('tipoDocumento', TJSONNumber.Create(AintTipoDocumento));
  LDados.AddPair('chaveAcesso', String(AstrChaveAcesso));
  LDados.AddPair('identificador', String(AstrIdentificador));

  LResult := fChamaRpc('fObtemDadoPinPadDireto', LDados);
  try
    Result := AnsiString(fJsonStr(LResult, 'valor'));
  finally
    LResult.Free;
  end;
end;

procedure TTefCitelDvc.pSetPath(const AstrPath: String);
begin
  { AstrPath (calculado em fDiretorioPorTerminal, a partir de CFG_PTTFCT) e
    ignorado de proposito - decisao do Rafael (Req. 456190): quando
    CFG_TEFDVC = S, as DLLs do Scope/CliSiTef devem sempre acompanhar o
    TefEstacaoService.exe no mesmo diretorio, para simplificar suporte e
    manutencao (uma unica pasta por estacao, sem depender de CFG_PTTFCT
    por terminal). O path enviado a estacao (ver fJsonContexto) fica
    sempre vazio, e o roteador da estacao (untTefEstacaoRoteadorMensagens.pas)
    resolve para o diretorio do proprio TefEstacaoService.exe, do mesmo jeito
    que autcom.exe sempre resolveu quando o path vinha vazio.

    O modo classico (CFG_TEFDVC = N, TTefCitelNCR/TTefCitel direto dentro do
    autcom.exe) nao e afetado - continua respeitando CFG_PTTFCT exatamente
    como sempre funcionou, pois essa configuracao nunca chega a TTefCitelDvc
    nesse modo. }
  FstrPath := '';
end;

function TTefCitelDvc.fConteudoLogErro: String;
var
  LResult: TJSONObject;
begin
  { O arquivo mora na ESTACAO, ao lado da DLL que de fato carregou o TEF.
    Este e o unico jeito de o operador no servidor ver o motivo real. }
  LResult := fChamaRpc('fConteudoLogErro', TJSONObject.Create);
  try
    Result := fJsonStr(LResult, 'conteudo');
  finally
    LResult.Free;
  end;
end;

function TTefCitelDvc.pRetornaLog: TStringList;
var
  LResult: TJSONObject;
  LArr: TJSONArray;
  I: Integer;
begin
  LResult := fChamaRpc('pRetornaLog', TJSONObject.Create);
  try
    FLog.Clear;
    LArr := fJsonArr(LResult, 'linhas');
    if Assigned(LArr) then
      for I := 0 to LArr.Count - 1 do
        FLog.Add(LArr.Items[I].Value);
  finally
    LResult.Free;
  end;
  Result := FLog;
end;

procedure TTefCitelDvc.pInfo30DebitoPreDatado(const AdtaDataPre: TDate);
var
  LDados, LResult: TJSONObject;
begin
  LDados := TJSONObject.Create;
  LDados.AddPair('dataPre', fJsonDeData(AdtaDataPre));
  try
    LResult := fChamaRpc('pInfo30DebitoPreDatado', LDados);
  except
    on E: ETefCitelDvcCanal do
    begin
      pTrataQuedaEmChamadaAninhada('pInfo30DebitoPreDatado', E);
      Exit;
    end;
  end;
  LResult.Free;
end;

procedure TTefCitelDvc.pInfo30DebitoCredito1Minuto(const AintParcelaCdc: Integer);
var
  LDados, LResult: TJSONObject;
begin
  LDados := TJSONObject.Create;
  LDados.AddPair('parcelaCdc', TJSONNumber.Create(AintParcelaCdc));
  try
    LResult := fChamaRpc('pInfo30DebitoCredito1Minuto', LDados);
  except
    on E: ETefCitelDvcCanal do
    begin
      pTrataQuedaEmChamadaAninhada('pInfo30DebitoCredito1Minuto', E);
      Exit;
    end;
  end;
  LResult.Free;
end;

procedure TTefCitelDvc.pInfo30DebitoParcelado(const AintQtdParc, AintIntervaloParc,
  AintPrimParcAvista: Integer; const AdtaPrimParcela: TDate);
var
  LDados, LResult: TJSONObject;
begin
  LDados := TJSONObject.Create;
  LDados.AddPair('qtdParc', TJSONNumber.Create(AintQtdParc));
  LDados.AddPair('intervaloParc', TJSONNumber.Create(AintIntervaloParc));
  LDados.AddPair('primParcAvista', TJSONNumber.Create(AintPrimParcAvista));
  LDados.AddPair('primParcela', fJsonDeData(AdtaPrimParcela));
  try
    LResult := fChamaRpc('pInfo30DebitoParcelado', LDados);
  except
    on E: ETefCitelDvcCanal do
    begin
      pTrataQuedaEmChamadaAninhada('pInfo30DebitoParcelado', E);
      Exit;
    end;
  end;
  LResult.Free;
end;

procedure TTefCitelDvc.pSetValueAntesPassarCartao(const AValue: TAntesTefCartaoEvent);
begin FAntesPassarCartao := AValue; end;
procedure TTefCitelDvc.pSetValueDepoisPassarCartao(const AValue: TDepoisTefCartaoEvent);
begin FDepoisPassarCartao := AValue; end;
procedure TTefCitelDvc.pSetValueDepoisFinalizarTransacao(const AValue: TDepoisFinalizarTransacaoEvent);
begin FDepoisFinalizarTransacao := AValue; end;
function TTefCitelDvc.fGetValueAntesPassarCartao: TAntesTefCartaoEvent;
begin Result := FAntesPassarCartao; end;
function TTefCitelDvc.fGetValueDepoisPassarCartao: TDepoisTefCartaoEvent;
begin Result := FDepoisPassarCartao; end;
function TTefCitelDvc.fGetValueDepoisFinalizarTransacao: TDepoisFinalizarTransacaoEvent;
begin Result := FDepoisFinalizarTransacao; end;
function TTefCitelDvc.fGetValueAntesCancelarTransacao: TAntesTefCartaoEvent;
begin Result := FAntesCancelarTransacao; end;
function TTefCitelDvc.fGetValueDepoisCancelarTransacao: TDepoisTefCartaoEvent;
begin Result := FDepoisCancelarTransacao; end;
procedure TTefCitelDvc.pSetValueAntesCancelarTransacao(const AValue: TAntesTefCartaoEvent);
begin FAntesCancelarTransacao := AValue; end;
procedure TTefCitelDvc.pSetValueDepoisCancelarTransacao(const AValue: TDepoisTefCartaoEvent);
begin FDepoisCancelarTransacao := AValue; end;
function TTefCitelDvc.fGetValueAntesReimpressao: TAntesTefCartaoEvent;
begin Result := FAntesReimpressao; end;
function TTefCitelDvc.fGetValueDepoisReimpressao: TDepoisTefCartaoEvent;
begin Result := FDepoisReimpressao; end;
procedure TTefCitelDvc.pSetValueAntesReimpressao(const AValue: TAntesTefCartaoEvent);
begin FAntesReimpressao := AValue; end;
procedure TTefCitelDvc.pSetValueDepoisReimpressao(const AValue: TDepoisTefCartaoEvent);
begin FDepoisReimpressao := AValue; end;

function TTefCitelDvc.fVerificaPresencaPinPad: TStatusPinPad;
var
  LResult: TJSONObject;
  LintValor: Integer;
begin
  LResult := fChamaRpc('fVerificaPresencaPinPad', TJSONObject.Create);
  try
    LintValor := fJsonInt(LResult, 'status', Ord(sppNull));
    if (LintValor >= Ord(sppOperacional)) and (LintValor <= Ord(sppNull)) then
      Result := TStatusPinPad(LintValor)
    else
      Result := sppNull;
  finally
    LResult.Free;
  end;
end;

procedure TTefCitelDvc.pSetValueSucessoTefCartao(const AValue: TSucessoTefCartaoEvent);
begin FSucessoTefCartao := AValue; end;
function TTefCitelDvc.fGetValueSucessoTefCartao: TSucessoTefCartaoEvent;
begin Result := FSucessoTefCartao; end;

procedure TTefCitelDvc.pSetDadosAdicionaisTefTra(const aValue: IDadosAdicionaisTefTra);
begin
  FobjDadosAdicionaisTefTra := aValue; // viaja no "contexto" de toda chamada seguinte
end;

function TTefCitelDvc.fGetDadosAdicionaisTefTra: IDadosAdicionaisTefTra;
begin
  Result := FobjDadosAdicionaisTefTra;
end;

procedure TTefCitelDvc.pSetLogErr(AProc: TprocGravaLogErr);
begin
  FProcLogErr := AProc; // local - nunca serializado, so usado ao responder o hook "GravaLogErr"
end;

function TTefCitelDvc.fObtemVersao: string;
var
  LResult: TJSONObject;
begin
  LResult := fChamaRpc('fObtemVersao', TJSONObject.Create);
  try
    Result := fJsonStr(LResult, 'valor');
  finally
    LResult.Free;
  end;
end;

procedure TTefCitelDvc.AddInfo(const AMacAdress, AIPNumber, AUserName, AComputerName,
  ATerminalTEF: string);
begin
  { Local - viaja como "tefInfo" no contexto de toda chamada seguinte, sem
    round-trip proprio pela rede. }
  FTefInfo.MacAdress := AMacAdress;
  FTefInfo.IPNumber := AIPNumber;
  FTefInfo.UserName := AUserName;
  FTefInfo.ComputerName := AComputerName;
  FTefInfo.TerminalTEF := ATerminalTEF;
end;

function TTefCitelDvc.fInfoPixCadastro(out AListaInfo: TArrayInfoPix): Longint;
var
  LResult: TJSONObject;
  LArr: TJSONArray;
  LItem: TJSONObject;
  I: Integer;
begin
  SetLength(AListaInfo, 0);
  LResult := fChamaRpc('fInfoPixCadastro', TJSONObject.Create);
  try
    Result := fJsonInt(LResult, 'valor');
    LArr := fJsonArr(LResult, 'lista');
    if Assigned(LArr) then
    begin
      SetLength(AListaInfo, LArr.Count);
      for I := 0 to LArr.Count - 1 do
      begin
        LItem := LArr.Items[I] as TJSONObject;
        AListaInfo[I].CodigoRede := fJsonStr(LItem, 'codigoRede');
        AListaInfo[I].NomeRede := fJsonStr(LItem, 'nomeRede');
        AListaInfo[I].CodigoBandeira := fJsonStr(LItem, 'codigoBandeira');
        AListaInfo[I].NomeBandeira := fJsonStr(LItem, 'nomeBandeira');
      end;
    end;
  finally
    LResult.Free;
  end;
end;

procedure TTefCitelDvc.pEnviarQrCode(const AstrDiretorio, AstrArquivo: String);
var
  LDados, LResult: TJSONObject;
  LstrCaminho: String;
  LbytConteudo: TBytes;
begin
  { QR-CODE PIX PELO CANAL (Req. 456190, 2026-09-12). A assinatura recebe
    DIRETORIO e ARQUIVO porque e assim que o Scope carrega a imagem: o
    ScopePPMMFileLoad le um PNG do disco e o envia ao pinpad (ver
    TTefCitelNCR.pEnviarQrCode). Quem gera esse PNG e
    fGerarQrCodeImagemPinPad, em untTefCitelUtil.pas - VCL + DevExpress,
    com Application.MainForm de dono, entao ele roda no autcom.exe e em
    lugar nenhum mais; portar a geracao para dentro do servico da estacao
    nao e opcao.

    Com o TEF no servidor as duas pontas viam o mesmo disco e mandar o
    caminho bastava. Com o canal DVC a DLL do Scope esta na ESTACAO: o
    caminho do %TEMP% do servidor simplesmente nao existe la, e era isso
    que esta versao mandava. Entao o que viaja e o CONTEUDO do arquivo, em
    base64 - o teto de frame ja foi dimensionado prevendo base64 (ver
    TEF_DVC_TAMANHO_MAX_FRAME). O PNG do QR tem 220x220 e alguns KB, bem
    abaixo do teto; a fragmentacao propria do transporte cuida do resto.

    A estacao grava num temporario DELA e chama a mesma pEnviarQrCode
    nativa de sempre - nada muda do lado do Scope. }
  LstrCaminho := IncludeTrailingPathDelimiter(AstrDiretorio) + AstrArquivo;

  if not TFile.Exists(LstrCaminho) then
  begin
    { Sem excecao de proposito: o QR tambem e exibido na tela do Pix, entao
      a falha no visor do pinpad degrada a experiencia mas nao impede o
      pagamento. Derrubar a tela aqui seria pior que o sintoma. }
    pLogaDiagnosticoDvc(Format(
      'pEnviarQrCode: a imagem "%s" nao existe - nada enviado ao pinpad. O QR ' +
      'continua visivel na tela do Pix.', [LstrCaminho]));
    Exit;
  end;

  LbytConteudo := TFile.ReadAllBytes(LstrCaminho);
  try
    pLogaDiagnosticoDvcNivel(TEF_LOG_NIVEL_DIAGNOSTICO, Format(
      'pEnviarQrCode: enviando "%s" (%d bytes de PNG) para a estacao carregar no pinpad.',
      [AstrArquivo, Length(LbytConteudo)]));

    LDados := TJSONObject.Create;
    { So o NOME. O diretorio e do servidor e nao significa nada na estacao -
      mandar confundiria quem le o log. }
    LDados.AddPair('arquivo', ExtractFileName(AstrArquivo));
    LDados.AddPair('conteudoBase64',
      TNetEncoding.Base64.EncodeBytesToString(LbytConteudo));
    LResult := fChamaRpc('pEnviarQrCode', LDados);
    LResult.Free;
  finally
    { A versao nativa apaga o temporario depois de carregar no pinpad. Com o
      canal DVC quem tem de apagar e ESTE lado: o arquivo esta no disco do
      servidor e a estacao nunca o enxerga. Sem isto, um PNG por Pix ficaria
      para tras no %TEMP% do servidor, indefinidamente. }
    TFile.Delete(LstrCaminho);
  end;
end;

procedure TTefCitelDvc.pLimpaQrCode(const AstrMensagem: AnsiString);
var
  LDados, LResult: TJSONObject;
begin
  LDados := TJSONObject.Create;
  LDados.AddPair('mensagem', String(AstrMensagem));
  LResult := fChamaRpc('pLimpaQrCode', LDados);
  LResult.Free;
end;

{ ISubjectTEFCitel }

procedure TTefCitelDvc.AdicionaObserver(AObserver: IObserverTEFCitel);
begin
  { Log de diagnostico (Req. 456190, 2026-09-02) - ver comentario em
    pTrataEvento/pNotifica. Pointer(AObserver) so serve para identificar
    "e o mesmo observer de antes ou um novo" no log (endereco do objeto
    por tras da interface) - nao e usado para nenhuma logica. }
  pLogaDiagnosticoDvc(Format(
    'AdicionaObserver: observer=%p, total antes=%d.',
    [Pointer(AObserver), FObservers.Count]));
  TInterlocked.Increment(FintGeracaoObservers); // ver comentario no campo/pTrataEvento
  if FObservers.IndexOf(AObserver) < 0 then
    FObservers.Add(AObserver);

  { DEPOIS do Add, de proposito: o aviso guardado tem que encontrar este
    observer na lista quando a fila rodar (Req. 456190, E2). }
  pDespachaAvisoGuardado;
end;

procedure TTefCitelDvc.RemoveObserver(AObserver: IObserverTEFCitel);
begin
  pLogaDiagnosticoDvc(Format(
    'RemoveObserver: observer=%p, total antes=%d.',
    [Pointer(AObserver), FObservers.Count]));
  TInterlocked.Increment(FintGeracaoObservers); // ver comentario no campo/pTrataEvento
  FObservers.Remove(AObserver);
end;

procedure TTefCitelDvc.NotificaObservers;
begin
  pNotifica(FRetorno);
end;

{ ITefCitelV2 }

function TTefCitelDvc.fTraduzirErro(const AintSts: Integer): String;
var
  LDados, LResult: TJSONObject;
begin
  LDados := TJSONObject.Create;
  LDados.AddPair('sts', TJSONNumber.Create(AintSts));
  LResult := fChamaRpc('fTraduzirErro', LDados);
  try
    Result := fJsonStr(LResult, 'valor');
  finally
    LResult.Free;
  end;
end;

{ Req. 456497 (gabriel.mendes, r496193): o TFT_PINPAD da TEFTRA guarda os seis
  atributos lidos do pinpad. Quem le e a DLL nativa, e no caminho DVC ela esta
  na ESTACAO - entao aqui isto e RPC, como qualquer outra chamada que chega ao
  pinpad fisico.

  O autcom nao precisa saber disso: o fCapturaInfoPinPad (untTefCitelUtil.pas)
  resolve por Supports(objTefCitel, ITefCitelV2, ...), e o TTefCitelDvc declara
  a interface igual ao TTefCitel e ao TTefCitelNCR. Sem este metodo a DLL nem
  compilaria, e com ele o campo passa a ser preenchido tambem com CFG_TEFDVC.

  Do lado da estacao o metodo entra em fMetodoUsaPinpad - ao contrario do
  fTraduzirErro logo acima, que e tabela estatica e fica de fora. }
function TTefCitelDvc.fObtemInfoPinPad: String;
var
  LResult: TJSONObject;
begin
  LResult := fChamaRpc('fObtemInfoPinPad', TJSONObject.Create);
  try
    Result := fJsonStr(LResult, 'valor');
  finally
    LResult.Free;
  end;
end;

{ ITefCitelFinalizacao }

function TTefCitelDvc.fUltimaFinalizacaoNaoRealizada: Boolean;
begin
  Result := FblnFinalizacaoNaoRealizada;

  { Quem pergunta e o autcom novo, que mostra o proprio aviso: o generico de
    reinicio que esta finalizacao guardou sairia em dobro na tela seguinte.
    So apaga se o guardado ainda for AQUELE - se outro aviso o substituiu, ou
    se ja foi entregue, fica como esta. }
  if FstrAvisoReinicioGuardado <> '' then
  begin
    FcsAviso.Enter;
    try
      if FstrAvisoGuardado = FstrAvisoReinicioGuardado then
        FstrAvisoGuardado := '';
    finally
      FcsAviso.Leave;
    end;
    FstrAvisoReinicioGuardado := '';
  end;
end;

function TTefCitelDvc.fUltimaFinalizacaoSeraReenviada: Boolean;
begin
  Result := FblnFinalizacaoSeraReenviada;
end;

procedure TTefCitelDvc.pDescreveFinalizacaoPendente(const AstrDescricao: String);
begin
  FstrReenvioDescricao := AstrDescricao;
end;

end.
