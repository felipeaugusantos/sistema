unit untTefCitelDvcUpdateImpl;

{ Plugin cliente do canal DVC "TefCitelUpd" (Req. 456190, Fase 6.1).

  O QUE ELE FAZ, E SO ISSO: recebe um quadro do autcom pelo canal DVC,
  repassa byte a byte para a porta de volume do TefEstacaoService, espera a
  resposta e devolve byte a byte pelo mesmo canal. Nao interpreta o
  conteudo, nao grava em disco, nao tem fila e nao tem thread de escrita.

  POR QUE ELE E TAO MAIS SIMPLES QUE O untTefCitelDvcPluginImpl

  O plugin da transacao e um rele BIDIRECIONAL e assincrono: o servico pode
  mandar evento de pinpad a qualquer momento, sem ninguem ter pedido, e por
  isso ele precisa de loop de leitura, fila e worker de escrita. Aqui nao:
  este canal e estritamente PERGUNTA-RESPOSTA, uma de cada vez.

  E essa serializacao nao e economia de codigo - e o ponto inteiro do
  desenho. A perda de quadro medida em campo em 2026-08-31, que obrigou a
  fragmentar tudo em 1400 bytes no canal da transacao, tem como causa
  "WTSVirtualChannelWrite abortando o WTSVirtualChannelRead pendente" (ver
  untTefCitelDvcTransporte.pas:301). Com uma pergunta por vez e ninguem mais
  escrevendo neste canal, nunca ha escrita durante leitura pendente - e por
  isso bloco de centenas de KB passa inteiro aqui, como a PoC DVC_v2 provou
  em mais de 105.000 idas e voltas.

  Se algum dia alguem precisar mandar algo NAO solicitado por este canal, a
  premissa cai junto. Nao faca isso: abra outro canal (RN37).

  ENQUADRAMENTO (identico nos tres pontos - autcom, aqui e servico):
    [4 bytes tamanho little-endian][N bytes JSON UTF-8]
  Este plugin so le os 4 bytes de tamanho para saber quanto esperar do
  socket. O JSON e opaco para ele. }

interface

uses
  Winapi.Windows, Winapi.ActiveX, untTefCitelDvcUpdateApi;

type
  TTefCitelDvcUpdatePlugin = class(TInterfacedObject, IWTSPlugin, IWTSListenerCallback)
  private
    FListener: IWTSListener;

    { IWTSPlugin }
    function Initialize(const ChannelMgr: IWTSVirtualChannelManager): HRESULT; stdcall;
    function Connected: HRESULT; stdcall;
    function Disconnected(DisconnectCode: DWORD): HRESULT; stdcall;
    function Terminated: HRESULT; stdcall;

    { IWTSListenerCallback }
    function OnNewChannelConnection(const Channel: IWTSVirtualChannel;
      Data: PWideChar; Accept: PBOOL;
      out Callback: IWTSVirtualChannelCallback): HRESULT; stdcall;
  end;

implementation

uses
  Winapi.WinSock, System.SysUtils, System.Classes, System.SyncObjs;

const
  { Duplicada de proposito, como a do plugin da transacao faz com a 47991:
    sao .dproj diferentes e nao vale search-path entre eles. Tem de bater com
    TEF_UPD_PORTA de untTefCitelAtuComum.pas. }
  TEF_UPD_PORTA = 47992;

  { Teto de um quadro. Bloco de 256 KiB vira ~341 KiB de base64, mais o
    envelope JSON. 2 MiB da folga larga e barra tamanho absurdo vindo de um
    quadro corrompido antes de tentar alocar - mesma defesa que o
    "LintTamanhoFrame invalido" do transporte da transacao faz. }
  TEF_UPD_TAMANHO_MAX = 2 * 1024 * 1024;

  TEF_UPD_ARQUIVO_LOG = 'TefCitelDvcUpdate.log';

var
  { Log tem lock proprio: o cliente RDP pode abrir mais de um canal. }
  VcsLog: TCriticalSection;

function fPastaDoPlugin: String;
var
  LarrBuffer: array[0..MAX_PATH - 1] of Char;
begin
  SetString(Result, LarrBuffer, GetModuleFileName(HInstance, LarrBuffer, Length(LarrBuffer)));
  Result := ExtractFilePath(Result);
end;

{ Arquivo de log PROPRIO, separado do TefCitelDvcPlugin.log de proposito:
  misturar os dois faria o log do canal de volume (dezenas de linhas por
  atualizacao) se perder no meio das dezenas de milhares de linhas do canal
  da transacao, e foi justamente a legibilidade do log que resolveu os
  achados de campo desta fase. }
procedure pLogArquivo(const AstrMsg: String);
var
  LtxtArquivo: TextFile;
  LstrCaminho: String;
begin
  if not Assigned(VcsLog) then
    Exit;

  VcsLog.Enter;
  try
    LstrCaminho := fPastaDoPlugin + TEF_UPD_ARQUIVO_LOG;
    try
      AssignFile(LtxtArquivo, LstrCaminho);
      if FileExists(LstrCaminho) then
        Append(LtxtArquivo)
      else
        Rewrite(LtxtArquivo);
      try
        Writeln(LtxtArquivo, FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz', Now) +
          Format('  [pid=%d]  ', [GetCurrentProcessId]) + AstrMsg);
      finally
        CloseFile(LtxtArquivo);
      end;
    except
      { Log que falha nunca pode derrubar o plugin dentro do mstsc.exe. }
    end;
  finally
    VcsLog.Leave;
  end;
end;

type
  TTefCitelDvcUpdateCallback = class(TInterfacedObject, IWTSVirtualChannelCallback)
  private
    FChannel: IWTSVirtualChannel;
    FsckServico: TSocket;
    FintBlocos: Integer;
    function fGaranteSocket(out AstrErro: String): Boolean;
    procedure pFechaSocket;
    function fEnviaTudo(const AbytDados: TBytes): Boolean;
    function fRecebeTudo(var AbytDestino: TBytes; const AintQuantidade: Integer): Boolean;
    function fRepassaEEspera(const AbytPedido: TBytes; out AbytResposta: TBytes;
      out AstrErro: String): Boolean;
    procedure pRespondeErro(const AstrErro: String);
    procedure pEscreveNoCanal(const AbytDados: TBytes);
  public
    constructor Create(const AChannel: IWTSVirtualChannel);
    destructor Destroy; override;
    function OnDataReceived(Size: ULONG; Buffer: PByte): HRESULT; stdcall;
    function OnClose: HRESULT; stdcall;
  end;

constructor TTefCitelDvcUpdateCallback.Create(const AChannel: IWTSVirtualChannel);
var
  LobjWsaData: TWSAData;
begin
  inherited Create;
  FChannel := AChannel;
  FsckServico := INVALID_SOCKET;
  FintBlocos := 0;

  { Seguro chamar mais de uma vez; o Winsock so conta referencia. Sem
    WSACleanup correspondente, igual ao plugin da transacao: a DLL vive
    enquanto a sessao RDP viver. }
  WSAStartup($0202, LobjWsaData);
end;

destructor TTefCitelDvcUpdateCallback.Destroy;
begin
  pFechaSocket;
  FChannel := nil;
  inherited;
end;

{ Socket aberto na PRIMEIRA mensagem e mantido ate o canal fechar. Abrir por
  bloco custaria um connect a cada ~341 KB, e um connect vale mais que o
  proprio repasse. }
function TTefCitelDvcUpdateCallback.fGaranteSocket(out AstrErro: String): Boolean;
var
  LrecEndereco: TSockAddrIn;
begin
  AstrErro := '';
  if FsckServico <> INVALID_SOCKET then
    Exit(True);

  FsckServico := socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
  if FsckServico = INVALID_SOCKET then
  begin
    AstrErro := Format('socket() falhou com erro %d', [WSAGetLastError]);
    Exit(False);
  end;

  FillChar(LrecEndereco, SizeOf(LrecEndereco), 0);
  LrecEndereco.sin_family := AF_INET;
  LrecEndereco.sin_port := htons(TEF_UPD_PORTA);
  LrecEndereco.sin_addr.S_addr := inet_addr('127.0.0.1');

  if connect(FsckServico, TSockAddr(LrecEndereco), SizeOf(LrecEndereco)) <> 0 then
  begin
    AstrErro := Format('connect(127.0.0.1:%d) falhou com erro %d - servico sem a ' +
      'porta de volume (versao anterior a Fase 6.1) ou parado',
      [TEF_UPD_PORTA, WSAGetLastError]);
    pFechaSocket;
    Exit(False);
  end;

  pLogArquivo(Format('Conectado ao TefEstacaoService.exe (127.0.0.1:%d).', [TEF_UPD_PORTA]));
  Result := True;
end;

procedure TTefCitelDvcUpdateCallback.pFechaSocket;
begin
  if FsckServico <> INVALID_SOCKET then
  begin
    closesocket(FsckServico);
    FsckServico := INVALID_SOCKET;
  end;
end;

function TTefCitelDvcUpdateCallback.fEnviaTudo(const AbytDados: TBytes): Boolean;
var
  LintEnviado, LintAgora: Integer;
begin
  LintEnviado := 0;
  while LintEnviado < Length(AbytDados) do
  begin
    LintAgora := send(FsckServico, AbytDados[LintEnviado],
      Length(AbytDados) - LintEnviado, 0);
    if LintAgora <= 0 then
      Exit(False);
    Inc(LintEnviado, LintAgora);
  end;
  Result := True;
end;

function TTefCitelDvcUpdateCallback.fRecebeTudo(var AbytDestino: TBytes;
  const AintQuantidade: Integer): Boolean;
var
  LintLido, LintAgora: Integer;
begin
  SetLength(AbytDestino, AintQuantidade);
  LintLido := 0;
  while LintLido < AintQuantidade do
  begin
    LintAgora := recv(FsckServico, AbytDestino[LintLido], AintQuantidade - LintLido, 0);
    if LintAgora <= 0 then
      Exit(False);
    Inc(LintLido, LintAgora);
  end;
  Result := True;
end;

function TTefCitelDvcUpdateCallback.fRepassaEEspera(const AbytPedido: TBytes;
  out AbytResposta: TBytes; out AstrErro: String): Boolean;
var
  LbytTamanho, LbytCorpo: TBytes;
  LdwTamanho: UInt32;
begin
  AstrErro := '';
  SetLength(AbytResposta, 0);

  if not fEnviaTudo(AbytPedido) then
  begin
    AstrErro := Format('falha ao escrever no socket do servico (erro %d)', [WSAGetLastError]);
    Exit(False);
  end;

  if not fRecebeTudo(LbytTamanho, SizeOf(UInt32)) then
  begin
    AstrErro := Format('servico nao devolveu o tamanho da resposta (erro %d)', [WSAGetLastError]);
    Exit(False);
  end;

  Move(LbytTamanho[0], LdwTamanho, SizeOf(UInt32));
  if (LdwTamanho = 0) or (LdwTamanho > TEF_UPD_TAMANHO_MAX) then
  begin
    AstrErro := Format('tamanho de resposta invalido (%d bytes)', [LdwTamanho]);
    Exit(False);
  end;

  if not fRecebeTudo(LbytCorpo, Integer(LdwTamanho)) then
  begin
    AstrErro := Format('servico cortou a resposta no meio (erro %d)', [WSAGetLastError]);
    Exit(False);
  end;

  { Devolve o quadro COMPLETO - tamanho + corpo - porque quem espera do outro
    lado le exatamente o mesmo enquadramento. }
  SetLength(AbytResposta, SizeOf(UInt32) + Integer(LdwTamanho));
  Move(LbytTamanho[0], AbytResposta[0], SizeOf(UInt32));
  Move(LbytCorpo[0], AbytResposta[SizeOf(UInt32)], Integer(LdwTamanho));
  Result := True;
end;

procedure TTefCitelDvcUpdateCallback.pEscreveNoCanal(const AbytDados: TBytes);
var
  LhrRet: HRESULT;
begin
  if Length(AbytDados) = 0 then
    Exit;
  LhrRet := FChannel.Write(Length(AbytDados), @AbytDados[0], nil);
  if LhrRet <> S_OK then
    pLogArquivo(Format('IWTSVirtualChannel.Write devolveu 0x%.8x.', [Cardinal(LhrRet)]));
end;

{ Resposta de erro montada AQUI, no mesmo enquadramento, para que o autcom
  sempre receba algo. Sem isto ele ficaria esperando ate o teto do bloco por
  uma resposta que nunca viria - e um erro que se anuncia em milissegundos
  vale muito mais que um que se anuncia em 30 s. }
procedure TTefCitelDvcUpdateCallback.pRespondeErro(const AstrErro: String);
var
  LbytJson, LbytQuadro: TBytes;
  LdwTamanho: UInt32;
  LstrJson: String;
begin
  LstrJson := '{"ok":false,"erro":"' + StringReplace(AstrErro, '"', '''', [rfReplaceAll]) + '"}';
  LbytJson := TEncoding.UTF8.GetBytes(LstrJson);
  LdwTamanho := Length(LbytJson);

  SetLength(LbytQuadro, SizeOf(UInt32) + Integer(LdwTamanho));
  Move(LdwTamanho, LbytQuadro[0], SizeOf(UInt32));
  Move(LbytJson[0], LbytQuadro[SizeOf(UInt32)], Integer(LdwTamanho));

  pEscreveNoCanal(LbytQuadro);
end;

function TTefCitelDvcUpdateCallback.OnDataReceived(Size: ULONG; Buffer: PByte): HRESULT;
var
  LbytPedido, LbytResposta: TBytes;
  LstrErro: String;
begin
  { S_OK SEMPRE, e todo o corpo dentro de try/except: excecao escapando daqui
    sobe para dentro do mstsc.exe do cliente, que nao e nosso processo. O
    canal cair e recuperavel (o autcom cai no caminho lento); derrubar o
    cliente RDP do operador nao e. }
  Result := S_OK;
  try
    SetLength(LbytPedido, Size);
    if Size > 0 then
      Move(Buffer^, LbytPedido[0], Size);

    if not fGaranteSocket(LstrErro) then
    begin
      pLogArquivo('Sem conexao com o servico: ' + LstrErro);
      pRespondeErro(LstrErro);
      Exit;
    end;

    if not fRepassaEEspera(LbytPedido, LbytResposta, LstrErro) then
    begin
      pLogArquivo(Format('Repasse falhou depois de %d bloco(s): %s', [FintBlocos, LstrErro]));
      { Socket suspeito vai embora: o proximo bloco reconecta do zero em vez
        de herdar um fluxo possivelmente desalinhado. }
      pFechaSocket;
      pRespondeErro(LstrErro);
      Exit;
    end;

    Inc(FintBlocos);
    pEscreveNoCanal(LbytResposta);
  except
    on E: Exception do
    begin
      pLogArquivo(Format('OnDataReceived: %s: %s', [E.ClassName, E.Message]));
      try
        pFechaSocket;
        pRespondeErro(E.ClassName + ': ' + E.Message);
      except
        { nada: ja estamos no caminho de erro }
      end;
    end;
  end;
end;

function TTefCitelDvcUpdateCallback.OnClose: HRESULT;
begin
  pLogArquivo(Format('Canal de atualizacao fechado pelo autcom.exe apos %d bloco(s).',
    [FintBlocos]));
  pFechaSocket;
  Result := S_OK;
end;

function TTefCitelDvcUpdatePlugin.Initialize(
  const ChannelMgr: IWTSVirtualChannelManager): HRESULT;
var
  LCallback: IWTSListenerCallback;
begin
  LCallback := Self;
  Result := ChannelMgr.CreateListener(PAnsiChar(TEF_UPD_CANAL), 0, LCallback, FListener);
  if Result = S_OK then
    pLogArquivo('Listener "' + String(TEF_UPD_CANAL) + '" criado.')
  else
    pLogArquivo(Format('CreateListener falhou. HRESULT = 0x%.8x', [Cardinal(Result)]));
end;

function TTefCitelDvcUpdatePlugin.Connected: HRESULT;
begin
  pLogArquivo('Sessao RDP conectada.');
  Result := S_OK;
end;

function TTefCitelDvcUpdatePlugin.Disconnected(DisconnectCode: DWORD): HRESULT;
begin
  pLogArquivo(Format('Sessao RDP desconectada. Codigo = %d', [DisconnectCode]));
  Result := S_OK;
end;

function TTefCitelDvcUpdatePlugin.Terminated: HRESULT;
begin
  pLogArquivo('Plugin terminado.');
  FListener := nil;
  Result := S_OK;
end;

function TTefCitelDvcUpdatePlugin.OnNewChannelConnection(const Channel: IWTSVirtualChannel;
  Data: PWideChar; Accept: PBOOL; out Callback: IWTSVirtualChannelCallback): HRESULT;
begin
  if Assigned(Accept) then
    Accept^ := True;
  Callback := TTefCitelDvcUpdateCallback.Create(Channel);
  pLogArquivo('Conexao aceita no canal "' + String(TEF_UPD_CANAL) + '".');
  Result := S_OK;
end;

initialization
  VcsLog := TCriticalSection.Create;

finalization
  FreeAndNil(VcsLog);

end.
