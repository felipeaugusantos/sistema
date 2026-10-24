unit untTefEstacaoServiceMain;

{ Servico Windows da estacao (Req. 456190) - hospeda o TTefEstacaoRoteador,
  que fica ouvindo o pipe local alimentado pelo plugin cliente DVC (grupo
  "Plugin cliente DVC") e roteando as chamadas RPC para a instancia real de
  ITefCitel (TTefCitelNCR/TTefCitel, sem nenhuma alteracao nelas).

  Ciclo de vida gerenciado pelo SCM (Vcl.SvcMgr) - independente da sessao
  RDP/TSPlus: o servico continua rodando mesmo que a sessao do operador caia
  e reconecte, o que e justamente o problema que motivou esta migracao. }

interface

uses
  Winapi.Windows, Vcl.SvcMgr, System.SysUtils, System.Classes, System.IOUtils,
  untTefEstacaoRoteadorMensagens, untTefEstacaoUpdateListener;

type
  TTefEstacaoService = class(TService)
  private
    FRoteador: TTefEstacaoRoteador;
    { Porta de volume da atualizacao (Fase 6.1). Vive aqui, e nao dentro do
      roteador, de proposito: o roteador cuida de ROTEAR mensagem da
      transacao, e quem abre o ServiceStart precisa enxergar num relance que
      existe um segundo canal de entrada nesta estacao. }
    FUpdateListener: TTefEstacaoUpdateListener;
  public
    constructor Create(AOwner: TComponent); override;
    function GetServiceController: TServiceController; override;
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  end;

var
  { Nome diferente do nome do programa (TefEstacaoService.dpr) de proposito -
    a chamada de registro do servico, no .dpr, recebe o TIPO e a VARIAVEL; com
    a variavel homonima ao nome do programa o parser do dcc32 se perdia
    (E2029 '.' expected but ')' found), pois o proprio nome do programa
    tambem ocupa esse identificador.

    O texto da chamada nao e citado aqui de proposito: a trava do pre-commit
    procura esse literal, e uma mencao em COMENTARIO viraria mais um item a
    justificar no gate sem ser chamada nenhuma. A chamada de verdade segue
    visivel no .dpr, onde ela precisa ser discutida. }
  Servico: TTefEstacaoService;

implementation

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  Servico.Controller(CtrlCode);
end;

function TTefEstacaoService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

constructor TTefEstacaoService.Create(AOwner: TComponent);
begin
  { Sem .dfm proposital - a IDE normalmente gera um recurso para um
    TService, mas Name/DisplayName/OnStart/OnStop nao dependem dele; fixar
    tudo aqui evita carregar um .dfm escrito a mao sem passar pela IDE.

    Por isso NAO se pode chamar "inherited Create(AOwner)" aqui:
    TDataModule.Create (herdado via TService) sempre exige um recurso
    RCDATA com o nome da classe compilado no exe e levanta
    EResNotFound se ele nao existir - erro so aparece em runtime (ao
    instalar/rodar o servico de verdade), nao no compilador, e foi
    exatamente o que aconteceu no primeiro teste manual em estacao real
    (Req. 456190, 2026-08-20). CreateNew (que TService ja sobrescreve com
    toda a inicializacao real - FDependencies, FParams, etc., ver
    Vcl.SvcMgr.TService.CreateNew) pula essa exigencia de recurso. }
  CreateNew(AOwner);
  Name := 'TefEstacaoService';
  DisplayName := 'Citel - TEF Estacao';
  OnStart := ServiceStart;
  OnStop := ServiceStop;
end;

procedure TTefEstacaoService.ServiceStart(Sender: TService; var Started: Boolean);
var
  LstrDiretorioFila: String;
begin
  { Log de ServiceStart/ServiceStop escrito de proposito ANTES/DEPOIS de
    qualquer outra coisa (Req. 456190, 2026-08-24): serve para confirmar,
    de forma independente de qualquer chamada RPC chegar ou nao, que o
    mecanismo de log (pLogaEstacao, grava ao lado do .exe) esta realmente
    funcionando nesta instalacao - se nem essa linha aparecer no arquivo,
    o problema e no proprio log (caminho/permissao), nao no fluxo RPC. }
  pLogaEstacao('ServiceStart chamado.');
  LstrDiretorioFila := TPath.Combine(ExtractFilePath(ParamStr(0)), 'FilaTef');
  FRoteador := TTefEstacaoRoteador.Create(LstrDiretorioFila);

  { Depois do roteador porque usa o TTefEstacaoAtualizacao que ele cria. Nao
    falha a subida do servico se nao conseguir: sem a porta de volume o
    autcom nao abre o canal rapido e cai no caminho lento (RF45), que e o que
    roda em producao hoje - o proprio listener registra o motivo no log. }
  FUpdateListener := TTefEstacaoUpdateListener.Create(FRoteador.Atualizacao);
  FUpdateListener.pInicia;

  Started := True;
  pLogaEstacao('ServiceStart concluido - servico pronto.');
end;

procedure TTefEstacaoService.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  pLogaEstacao('ServiceStop chamado.');

  { ANTES do roteador, e a ordem importa: o listener entrega blocos no
    TTefEstacaoAtualizacao que o roteador e dono. Liberar o roteador primeiro
    deixaria a thread de volume escrevendo num objeto morto. }
  FreeAndNil(FUpdateListener);

  FreeAndNil(FRoteador);
  Stopped := True;
  pLogaEstacao('ServiceStop concluido.');
end;

end.
