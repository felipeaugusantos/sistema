unit untFuncoesLibTefCitel;

interface

uses
  Winapi.Windows, System.SysUtils, untInterfaceTefCitel, untTefCitel,
  untTefCitelNCR, untTefCitelDvc, untTefCitelDvcAtualizacao,
  untTefCitelDvcTransporte;

function fCriarTefCitel(const AstrPath, AstrOpcao: String; const AblnUsaDvc: Boolean = False): ITefCitel; stdcall;

{ Registra a funcao com que a DLL pergunta ao operador se ele quer assumir o
  pinpad de um AUTCOM que parou de responder (Req. 456190, RF27/RN16,
  Passo 6).

  Existe porque a libTefCitel.dll nao linka libFuncoes e, portanto, nao
  enxerga o fMensagem do projeto - a pergunta precisa sair pela mesma caixa
  de mensagem que o operador ve no resto do TEF, e essa caixa mora no host. O
  host chama isto uma vez, antes de criar a instancia (untTefCitelUtil.pas).

  Passar nil desliga a pergunta: sem ela nenhuma tomada de pinpad acontece
  por decisao humana, e a recusa segue como sempre foi. }
procedure pSetConfirmaTomadaPinpadTef(AFunc: TfuncConfirmaTomadaPinpadTef); stdcall;

{ Atualizacao de arquivos da estacao (Req. 456190, Fase 6).

  ATef e a MESMA instancia devolvida por fCriarTefCitel - ITefCitel ja
  atravessa esta fronteira de DLL hoje, entao nao ha novidade de
  marshalling. Instancia que nao seja TTefCitelDvc (modo classico,
  CFG_TEFDVC = N) devolve "nada a fazer" sem tocar em nada.

  O retorno e Integer e nunca excecao: excecao cruzando fronteira de
  modulo e onde este requisito ja se queimou uma vez. Ver os
  TEF_ATU_RET_* em untTefCitelDvcAtualizacao. }
function fAtualizaEstacaoTefDll(ATef: ITefCitel; const AstrDirAutcom,
  AstrOpcaoTefCit, AstrDirIniTerminal: String;
  out AstrMensagem: String): Integer; stdcall;

{ Registra em quem a DLL mostra o progresso da transferencia. A tela e do
  host: TfrmGravando e VCL com DevExpress e depende de Application.MainForm,
  mesma razao ja registrada para o fGerarQrCodeImagemPinPad do QR do Pix.

  Passar nil desliga a tela - a atualizacao continua acontecendo, so fica
  silenciosa. }
procedure pSetProgressoAtualizacaoTef(AProc: TprocProgressoAtualizacaoTef); stdcall;

{ Informa a DLL qual e a thread principal (VCL) do host.

  A libTefCitel.dll linka a PROPRIA copia da RTL: ela tem o seu
  System.MainThreadID e a sua fila de TThread.Queue, e o laco de mensagens do
  autcom.exe nao enxerga nenhum dos dois. Esse MainThreadID nasce no
  DLL_PROCESS_ATTACH - ou seja, na thread que disparar o primeiro import
  "delayed" (untTefCitelUtil.pas), que nao e necessariamente a principal:
  fInstanciaPixTef chega aqui de dentro de um TTask
  (TFatVendaBase.CarregaLibRequisicoesPix -> CarregaLibIntegracaoPixCitel ->
  TPixTefBridgeAutcom.Create) e corre contra o pIniciaTefCitel da carga do
  operador. Quem chegar primeiro define o MainThreadID do processo inteiro.

  Quando quem chega primeiro e o TTask, o unico dreno da fila - o
  CheckSynchronize de fChamaRpcUmaVez (untTefCitelDvc.pas) - fica atras de um
  teste que nunca mais e verdadeiro, e NENHUM evento de TEF chega a tela.
  Campo 2026-09-25: 2954 eventos enfileirados, zero entregues; a operadora
  nao viu o menu de parcelamento que o pinpad pedia e a venda travou ate o
  processo ser morto.

  O host chama isto no UNICO caminho que pode carregar a DLL fora da thread
  principal - fInstanciaPixTef, dentro do TTask do Pix -, antes de qualquer
  outra chamada a DLL naquele caminho, passando o MainThreadID DELE. Por isso
  pode ser chamado de qualquer thread: o valor certo vem no parametro, nao da
  thread que executa. Sem Pix, quem carrega a DLL e a carga do TEF, na thread
  principal, e nada precisa ser acertado. AdwThreadId = 0 usa a thread
  chamadora - so serve se ela for a principal. }
procedure pSetThreadPrincipalHost(AdwThreadId: Cardinal); stdcall;

implementation

function fCriarTefCitel(const AstrPath, AstrOpcao: String; const AblnUsaDvc: Boolean = False): ITefCitel; stdcall;
begin
  Result := Nil ;
  if AblnUsaDvc then
    { CFG_TEFDVC = S (Req. 456190): a execucao fisica do TEF (Scope/NCR ou
      SiTef Express, conforme AstrOpcao) passa a rodar no servico Windows da
      estacao; TTefCitelDvc so relay RPC pelo canal DVC. AstrOpcao viaja no
      "contexto" de cada chamada para a estacao saber qual ITefCitel real
      instanciar la, via a mesma fCriarTefCitel (reaproveitada, sem duplicar
      esta decisao). }
    Result := TTefCitelDvc.Create(AstrOpcao)
  else if AstrOpcao = OPCAO_CLISITEF then
    Result := TTefCitel.Create
  else if AstrOpcao = OPCAO_NCR then
    Result := TTefCitelNCR.Create
  else
    Exit ;

  Result.pSetPath(AstrPath);
end;

procedure pSetConfirmaTomadaPinpadTef(AFunc: TfuncConfirmaTomadaPinpadTef); stdcall;
begin
  VS_funcConfirmaTomadaPinpadTef := AFunc;
end;


function fAtualizaEstacaoTefDll(ATef: ITefCitel; const AstrDirAutcom,
  AstrOpcaoTefCit, AstrDirIniTerminal: String;
  out AstrMensagem: String): Integer; stdcall;
begin
  { Rede de seguranca da fronteira: fAtualizaEstacaoTef ja tem try/except
    proprio, mas uma excecao que escapasse daqui atravessaria a fronteira
    da DLL e cairia no madExcept do autcom no meio da carga. }
  try
    Result := fAtualizaEstacaoTef(ATef, AstrDirAutcom, AstrOpcaoTefCit,
      AstrDirIniTerminal, AstrMensagem);
  except
    on E: Exception do
    begin
      AstrMensagem := E.ClassName + ': ' + E.Message;
      Result := TEF_ATU_RET_FALHA;
    end;
  end;
end;

procedure pSetProgressoAtualizacaoTef(AProc: TprocProgressoAtualizacaoTef); stdcall;
begin
  pSetProgressoAtualizacao(AProc);
end;

procedure pSetThreadPrincipalHost(AdwThreadId: Cardinal); stdcall;
var
  LdwAnterior: Cardinal;
  LstrAviso: String;
begin
  if AdwThreadId = 0 then
    AdwThreadId := GetCurrentThreadId;

  LdwAnterior := MainThreadID;
  MainThreadID := AdwThreadId;
  VS_blnThreadPrincipalHostAcertada := True;

  LstrAviso := '';
  if LdwAnterior <> AdwThreadId then
    LstrAviso := ' A DLL havia sido carregada por OUTRA thread - sem este ' +
      'acerto nenhum evento de TEF chegaria a tela.';

  { A linha vale mesmo quando nada muda: ela prova, no log da estacao, que o
    host acertou o ponteiro. A AUSENCIA dela e que vira sintoma. }
  pLogaDiagnosticoDvc(Format(
    'pSetThreadPrincipalHost: MainThreadID da DLL %d -> %d (host).%s',
    [LdwAnterior, AdwThreadId, LstrAviso]));
end;
end.
