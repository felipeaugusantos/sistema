{ ******************************************************************************
  unit untFormatarMensagemErro

  Data: 23/07/2026
  Autor: Gabriel Ferreira Mendes
  E-mail: gabriel.mendes@citelsoftware.com.br

  Descricao Geral:
  ================
  Esta unit e responsavel por traduzir codigos de erro retornados por integradores
  de TEF (TefCitel e NCR/Scope) em mensagens amigaveis e padronizadas para o
  usuario final ou para logs do sistema.

  A classe principal TFormatarMensagemErro atua como um orquestrador que, dado um
  codigo de erro e sua origem (TefCitel ou NCR), retorna uma string no formato:
    "Erro[codigo]: mensagem"

  Como funciona:
  ==============
  1. O parametro TParametroErro e recebido, contendo o codigo, a origem e flags
     contextuais (ex: documento invalido, conexao perdida, transacao ativa).
  2. A classe tenta primeiro resolver casos especiais (codigos -2 e 65280) que
     dependem de flags para decidir a mensagem exata.
  3. Se nao for um caso especial, delega a traducao para um tradutor especifico
     da origem (TTradutorTefCitel ou TTradutorNCR), que possui um dicionario
     interno com as mensagens pre-cadastradas.
  4. Se o codigo nao for encontrado, usa uma mensagem de fallback generica.
  5. Por fim, a mensagem pura e formatada com o prefixo "Erro[codigo]: " e retornada.

  Por que foi feito assim (motivacoes/arquitetura):
  =================================================
  - Encapsulamento: Cada origem de erro possui sua propria classe tradutora,
    isolando as mensagens e regras de negocio especificas de cada integrador.
  - Polimorfismo: A interface ITradutorErro permite que novas origens sejam
    adicionadas sem modificar o orquestrador (principio Aberto/Fechado).
  - Colecao de primeira classe: Os dicionarios internos sao inicializados uma
    unica vez (class constructor), garantindo performance e centralizando a
    manutencao das mensagens.
  - Separacao de responsabilidades: A classe principal apenas orquestra o fluxo;
    cada tradutor e responsavel por seu proprio acervo de mensagens.
  - Evita repeticao de codigo e facilita testes unitarios, pois cada tradutor
    pode ser testado isoladamente.

  Conceitos utilizados:
  =====================
  - Object Calisthenics (metodos pequenos, remocao de else, encapsulamento de
    primitivos)
  - Injecao de dependencia (via registro dos tradutores no dicionario)
  - Padrao Strategy (cada tradutor e uma estrategia de traducao)
  - Programacao orientada a interfaces
  - Inicializacao estatica (class constructor/destructor)
  - Uso de record com construtores sobrecarregados para criacao contextual

  Historico de alteracoes:
  ========================
  23/07/2026 - Criacao da unit com arquitetura baseada em dicionarios e
               tradutores especializados, substituindo o antigo case.
  23/07/2026 - Remocao da diretiva 'static' dos metodos da classe principal para
               compatibilidade com versoes antigas do Delphi.
  23/07/2026 - Manutencao da diretiva 'static' no metodo de classe do record
               TParametroErro, conforme exigencia do compilador.
  24/07/2026 - Adicao de fEhCodigoConhecido: permite que fVerificaMsgTefCitel
               opere sobre codigo inteiro em vez de texto de mensagem, eliminando
               o acoplamento entre logica de fluxo e string de exibicao.
  24/07/2026 - Correcao do class constructor: FreeAndNil + re-raise em caso de
               falha parcial na inicializacao, evitando leak e estado indefinido.
  24/07/2026 - Guarda Assigned(FTradutores) em fTraduzirErro e fEhCodigoConhecido
               para tolerancia a falha na inicializacao da unit.
  28/07/2026 - Removido FormatarMensagem e fEhCodigoConhecido: simplificacao da
               interface publica; mensagens ja carregam prefixo do codigo quando
               necessario, tornando a formatacao separada desnecessaria.
  28/07/2026 - TraduzirCasoEspecial simplificado: parametro ABlnAplicarFormato
               removido; cada ramo define diretamente o texto final retornado.
  28/07/2026 - InicializarMensagens (TTradutorTefCitel): mensagens passaram a
               incluir o codigo numerico como prefixo ('-N texto'), alinhando ao
               padrao historico do projeto (revertendo introducao de Erro[N]:).
  28/07/2026 - fTraduzirErro simplificado: retorna a string do dicionario
               diretamente, sem etapa adicional de formatacao.
  28/07/2026 - Fallback NCR alterado para 'Erro Desconhecido (N)', restaurando
               compatibilidade com o padrao historico do integrador Scope.
  28/07/2026 - Guard Assigned(FTradutores) removido de fTraduzirErro: dispensavel
               apos class constructor garantir inicializacao completa ou propagar
               excecao via re-raise.
****************************************************************************** }

unit untFormatarMensagemErro;

interface

uses
  System.Generics.Collections;

type
  TOrigemErro = (oeTefCitel, oeNCR);

  // ========== Interface do tradutor ==========
  ITradutorErro = interface
    function Traduzir(const AIntCodigo: Integer; out AStrMensagem: string): Boolean;
  end;

  // ========== Tradutor para TefCitel ==========
  TTradutorTefCitel = class(TInterfacedObject, ITradutorErro)
  private
    FMensagens: TDictionary<Integer, string>;
    procedure InicializarMensagens;
  public
    constructor Create;
    destructor Destroy; override;
    function Traduzir(const AIntCodigo: Integer; out AStrMensagem: string): Boolean;
  end;

  // ========== Tradutor para NCR ==========
  TTradutorNCR = class(TInterfacedObject, ITradutorErro)
  private
    FMensagens: TDictionary<Integer, string>;
    procedure InicializarMensagens;
  public
    constructor Create;
    destructor Destroy; override;
    function Traduzir(const AIntCodigo: Integer; out AStrMensagem: string): Boolean;
  end;

  // ========== Parâmetro de erro ==========
  TParametroErro = record
  private
    class function Create: TParametroErro; static;  // <-- static obrigatório em record
  public
    FIntCodigoErro: Integer;
    FOrigem: TOrigemErro;
    FBoolDocumentoInvalido: Boolean;
    FBoolSemConexaoServidor: Boolean;
    FBoolTransacaoAtiva: Boolean;

    constructor CreateComContextoTefCitel(const AIntCodigoErro: Integer;
      const ABoolDocumentoInvalido: Boolean; const ABoolSemConexaoServidor: Boolean ); overload;

    constructor CreateComContextoNCR(const AIntCodigoErro: Integer;
      const ABoolTransacaoAtiva: Boolean); overload;
  end;

  // ========== Classe principal ==========
  TFormatarMensagemErro = class
  strict private
    class var FTradutores: TDictionary<TOrigemErro, ITradutorErro>;
    class constructor Criar;
    class destructor Destruir;

    class function TraduzirCasoEspecial(const AObjParametro: TParametroErro;
      out AStrMensagem: string): Boolean;

  public
    class function fTraduzirErro(const AObjParametro: TParametroErro): string;
  end;

implementation

uses
  SysUtils, StrUtils;

const
  CFallbackPositivo: array[TOrigemErro] of string = (
    'Negada pelo autorizador',               // oeTefCitel
    'Erro desconhecido do integrador Scope'  // oeNCR
  );

{ TTradutorTefCitel }

constructor TTradutorTefCitel.Create;
begin
  inherited;
  InicializarMensagens;
end;

destructor TTradutorTefCitel.Destroy;
begin
  FMensagens.Free;
  inherited;
end;

procedure TTradutorTefCitel.InicializarMensagens;
var
  LIntCodigo: Integer;
  LArrCodigos: array of Integer;
begin
  FMensagens := TDictionary<Integer, string>.Create;

  // Mensagens que contêm o código como prefixo
  FMensagens.Add(-1,   '-1 Módulo não inicializado');
  FMensagens.Add(-3,   '-3 Fornecido um código de função inválido');
  FMensagens.Add(-4,   '-4 Falta de memória para rodar a função');
  FMensagens.Add(-6,   '-6 Operação cancelada!');
  FMensagens.Add(-40,  '-40 Transação negada pelo SiTef');
  FMensagens.Add(-43,  '-43 Falha no pinpad');
  FMensagens.Add(-50,  '-50 Transação não segura');
  FMensagens.Add(-100, '-100 Result interno do módulo');

  // Mensagem especial (sem prefixo de código)
  FMensagens.Add(-999, 'Houve erro de comunicação com a operadora de cartão.' + #13 +
                        'Verificar o relatório do TEF e refazer a transação.');

  // Códigos que recebem "Erro: " + número
  LArrCodigos := [-7, -8, -9, -10, -12, -13, -15, -20, -21, -25, -30, -41, -42];
  for LIntCodigo in LArrCodigos do
    FMensagens.Add(LIntCodigo, Concat('Erro: ', IntToStr(LIntCodigo)));
end;

function TTradutorTefCitel.Traduzir(const AIntCodigo: Integer; out AStrMensagem: string): Boolean;
begin
  // Código -2 é tratado como caso especial na camada superior
  if AIntCodigo = -2 then
    Exit(False);

  Result := FMensagens.TryGetValue(AIntCodigo, AStrMensagem);
end;

{ TTradutorNCR }

constructor TTradutorNCR.Create;
begin
  inherited;
  InicializarMensagens;
end;

destructor TTradutorNCR.Destroy;
begin
  FMensagens.Free;
  inherited;
end;

procedure TTradutorNCR.InicializarMensagens;
begin
  FMensagens := TDictionary<Integer, string>.Create;

  FMensagens.Add(31,     'Problemas ao carregar o PIN PAD');
  FMensagens.Add(65024,  'A transação em andamento – a aplicação deve aguardar');
  FMensagens.Add(65025,  'SCOPE API não foi inicializada corretamente');
  FMensagens.Add(65026,  'SCOPE API já foi inicializada corretamente');
  FMensagens.Add(65033,  'Servidor não configurado no arquivo scope.ini');
  FMensagens.Add(64264,  'Erro no arquivo de controle utilizado finalização no ciclo multi-TEF');
  FMensagens.Add(65030,  'Logon duplicado');
  FMensagens.Add(65431,  'PIN PAD não encontrado');
  FMensagens.Add(65535,  'Erro genérico');
  FMensagens.Add(-5,     'PIN Pad em modo exclusivo, reverter');
  FMensagens.Add(64259,  'Dados do PIX incompletos. Por gentileza, validar com a integradora TEF.');
end;

function TTradutorNCR.Traduzir(const AIntCodigo: Integer; out AStrMensagem: string): Boolean;
begin
  // Código 65280 tratado como especial na camada superior
  if AIntCodigo = 65280 then
    Exit(False);

  Result := FMensagens.TryGetValue(AIntCodigo, AStrMensagem);
end;

{ TParametroErro }

class function TParametroErro.Create: TParametroErro;
begin
  Result.FIntCodigoErro           := 0;
  Result.FOrigem                  := oeTefCitel;
  Result.FBoolDocumentoInvalido   := False;
  Result.FBoolSemConexaoServidor  := False;
  Result.FBoolTransacaoAtiva      := False;
end;

constructor TParametroErro.CreateComContextoTefCitel(const AIntCodigoErro: Integer;
  const ABoolDocumentoInvalido: Boolean; const ABoolSemConexaoServidor: Boolean);
begin
  Self := Create;

  FOrigem                    := oeTefCitel;
  FIntCodigoErro             := AIntCodigoErro;
  FBoolDocumentoInvalido     := ABoolDocumentoInvalido;
  FBoolSemConexaoServidor    := ABoolSemConexaoServidor;
end;

constructor TParametroErro.CreateComContextoNCR(const AIntCodigoErro: Integer;
  const ABoolTransacaoAtiva: Boolean);
begin
  Self := Create;

  FOrigem                := oeNCR;
  FIntCodigoErro         := AIntCodigoErro;
  FBoolTransacaoAtiva    := ABoolTransacaoAtiva;
end;

{ TFormatarMensagemErro }

class constructor TFormatarMensagemErro.Criar;
begin
  FTradutores := TDictionary<TOrigemErro, ITradutorErro>.Create;
  try
    FTradutores.Add(oeTefCitel, TTradutorTefCitel.Create);
    FTradutores.Add(oeNCR,      TTradutorNCR.Create);
  except
    FreeAndNil(FTradutores);
    raise;
  end;
end;

class destructor TFormatarMensagemErro.Destruir;
begin
  FTradutores.Free;
end;

class function TFormatarMensagemErro.TraduzirCasoEspecial(const AObjParametro: TParametroErro;
  out AStrMensagem: string): Boolean;
begin
  // Caso especial TefCitel: código -2 com flags
  if (AObjParametro.FOrigem = oeTefCitel) and (AObjParametro.FIntCodigoErro = -2) then
  begin
    AStrMensagem       := '-2 Operação cancelada pelo operador.';

    if AObjParametro.FBoolDocumentoInvalido then
      AStrMensagem       := 'Documento Invalido';

    if AObjParametro.FBoolSemConexaoServidor then
      AStrMensagem       := 'Sem conexão com o serviço de TEF, verifique sua internet!';

    Exit(True);
  end;

  // Caso especial NCR: código 65280 com flag
  if (AObjParametro.FOrigem = oeNCR) and (AObjParametro.FIntCodigoErro = 65280) then
  begin
    AStrMensagem := 'ScopeSrv off-line ou o IP configurado no arquivo scope.ini está apontando para a máquina errada';

    if AObjParametro.FBoolTransacaoAtiva then
      AStrMensagem := 'Perda de conexão momentânea com o servidor TEF';

    Exit(True);
  end;

  Result := False;
end;

class function TFormatarMensagemErro.fTraduzirErro(const AObjParametro: TParametroErro): string;
var
  LTradutor: ITradutorErro;
  LStrMensagem: string;
  LStrFallback: string;
begin
  // 1. Tenta casos especiais (com lógica condicional)
  if TraduzirCasoEspecial(AObjParametro, LStrMensagem) then
    Exit(LStrMensagem);

  // 2. Tenta o tradutor específico da origem
  if FTradutores.TryGetValue(AObjParametro.FOrigem, LTradutor) then
  begin
    if LTradutor.Traduzir(AObjParametro.FIntCodigoErro, LStrMensagem) then
      Exit(LStrMensagem);
  end;

  // 3. Fallback generico indexado por origem
  LStrFallback := CFallbackPositivo[AObjParametro.FOrigem];
  case AObjParametro.FOrigem of
    oeNCR:
      LStrFallback := Concat('Erro Desconhecido (', IntToStr(AObjParametro.FIntCodigoErro), ')');

    oeTefCitel:
    begin
      if AObjParametro.FIntCodigoErro < 0 then
        LStrFallback := 'Erros detectados internamente pela rotina';
    end;
  end;

  Result := LStrFallback;
end;

end.