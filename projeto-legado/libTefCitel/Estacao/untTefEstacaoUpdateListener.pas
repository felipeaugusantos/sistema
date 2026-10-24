unit untTefEstacaoUpdateListener;

{ Porta de volume da atualizacao (Req. 456190, Fase 6.1).

  Recebe os blocos do pacote que o autcom manda pelo canal DVC "TefCitelUpd",
  repassados pela TefCitelDvcUpdate.dll, e entrega cada um ao
  TTefEstacaoAtualizacao.pParte - o MESMO metodo que o pAtuParte do roteador
  usa. O servico continua sendo o unico que escreve em _Preparo, e o sha256
  continua sendo conferido pelo fAtuFecha, no canal de controle. Aqui nao se
  valida hash, nao se promove .parcial e nao se decide nada.

  POR QUE UNIT PROPRIA, E NAO MAIS UM PEDACO DO untTefEstacaoTcpTransporte

  Aquela unit e o transporte validado em campo: quadro com messageId/CRC/ACK,
  dedup, multiplas conexoes de autcom, fragmentacao em 1400 bytes. Nada disso
  existe aqui, e misturar os dois apagaria a fronteira que a Fase 6.1 depende
  de manter visivel. Se um dia alguem for mexer no transporte da transacao,
  precisa conseguir ver num relance que este arquivo nao e afetado.

  O QUE ELE DELIBERADAMENTE NAO TEM

  - Sem CRC, ACK ou dedup proprios (RN36). A resposta de cada bloco e a
    confirmacao daquele bloco; a garantia ponta a ponta e o sha256 do
    fAtuFecha, que ja existe e ja foi validado. Dois protocolos de quadro na
    mesma base e exatamente o que esta fase evita.
  - Sem multiplas conexoes. So existe um remetente - a DLL de volume - e so
    durante a atualizacao. listen(1) basta, e nao ha razao para replicar a
    maquina de conexoes da 47991.
  - Sem participacao no pParaComSeguranca. Nao ha despacho de pinpad aqui;
    parar este listener e fechar socket, nada mais.

  ENQUADRAMENTO (identico nos tres pontos - autcom, plugin e aqui):
    [4 bytes tamanho little-endian][N bytes JSON UTF-8]

  O objeto do PEDIDO tem as chaves "pacote", "seq" e "conteudoBase64". O da
  RESPOSTA tem "ok" (booleano) e, quando false, "erro" com o motivo. O JSON
  esta descrito e nao transcrito de proposito: chave de fechamento dentro de
  comentario Pascal FECHA o comentario, e o compilador so reclama umas linhas
  adiante, onde o texto virou codigo. Custou um ciclo de compilacao aqui. }

interface

uses
  System.Classes, untTefEstacaoAtualizacao;

type
  TTefEstacaoUpdateListener = class
  private
    FAtualizacao: TTefEstacaoAtualizacao;
    FthdAceite: TThread;
  public
    { NAO assume a posse de AAtualizacao - o dono continua sendo o roteador. }
    constructor Create(AAtualizacao: TTefEstacaoAtualizacao);
    destructor Destroy; override;
    procedure pInicia;
    procedure pPara;
  end;

implementation

uses
  Winapi.Windows, Winapi.WinSock, System.SysUtils, System.JSON,
  untTefCitelAtuComum, untTefEstacaoLog;

const
  { Bloco de 256 KiB vira ~341 KiB de base64 mais o envelope. 2 MiB da folga
    larga e barra tamanho absurdo vindo de quadro corrompido ANTES de tentar
    alocar - mesma defesa do "LintTamanhoFrame invalido" do transporte da
    transacao. }
  TEF_UPD_TAMANHO_MAX = 2 * 1024 * 1024;

{ pLogaEstacaoNivel direto de untTefEstacaoLog, e nao o wrapper pLogaEstacao
  do roteador: o listener nao deve depender do roteador para nada. Prefixo
  "UPD:" para separar das linhas "TCP[con=" do canal da transacao no mesmo
  arquivo. }
procedure pLogaUpd(const AstrMsg: String);
begin
  pLogaEstacaoNivel(TEF_LOG_NIVEL_NORMAL, 'UPD: ' + AstrMsg);
end;

function fJsonStr(AObj: TJSONObject; const AstrNome: String): String;
var
  LValor: TJSONValue;
begin
  Result := '';
  if not Assigned(AObj) then
    Exit;
  LValor := AObj.GetValue(AstrNome);
  if Assigned(LValor) then
    Result := LValor.Value;
end;

function fJsonInt(AObj: TJSONObject; const AstrNome: String;
  const AintPadrao: Integer): Integer;
var
  LstrValor: String;
begin
  LstrValor := fJsonStr(AObj, AstrNome);
  if not TryStrToInt(LstrValor, Result) then
    Result := AintPadrao;
end;

type
  TTefEstacaoUpdateThread = class(TThread)
  private
    FAtualizacao: TTefEstacaoAtualizacao;
    FsckEscuta: TSocket;
    FsckCliente: TSocket;
    function fCriaEscuta: Boolean;
    function fRecebeTudo(var AbytDestino: TBytes; const AintQuantidade: Integer): Boolean;
    function fEnviaTudo(const AbytDados: TBytes): Boolean;
    procedure pResponde(const AblnOk: Boolean; const AstrErro: String);
    procedure pAtendeConexao;
  protected
    procedure Execute; override;
  public
    constructor Create(AAtualizacao: TTefEstacaoAtualizacao);
    procedure pDerruba;
  end;

constructor TTefEstacaoUpdateThread.Create(AAtualizacao: TTefEstacaoAtualizacao);
begin
  FAtualizacao := AAtualizacao;
  FsckEscuta := INVALID_SOCKET;
  FsckCliente := INVALID_SOCKET;
  FreeOnTerminate := False;
  inherited Create(False);
end;

{ Fecha os dois sockets de fora da thread para arrancar o accept/recv
  bloqueado. E o mesmo recurso que o transporte da transacao usa para parar:
  nao existe "cancelar accept" no Winsock, e um teto de tempo aqui so
  atrasaria o ServiceStop sem garantir nada. }
procedure TTefEstacaoUpdateThread.pDerruba;
begin
  Terminate;
  if FsckCliente <> INVALID_SOCKET then
    closesocket(FsckCliente);
  if FsckEscuta <> INVALID_SOCKET then
    closesocket(FsckEscuta);
end;

function TTefEstacaoUpdateThread.fCriaEscuta: Boolean;
var
  LrecEndereco: TSockAddrIn;
  LintReuso: Integer;
begin
  FsckEscuta := socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
  if FsckEscuta = INVALID_SOCKET then
  begin
    pLogaUpd(Format('socket() falhou com erro %d - porta de volume indisponivel; ' +
      'a atualizacao vai acontecer pelo caminho lento.', [WSAGetLastError]));
    Exit(False);
  end;

  LintReuso := 1;
  setsockopt(FsckEscuta, SOL_SOCKET, SO_REUSEADDR, @LintReuso, SizeOf(LintReuso));

  FillChar(LrecEndereco, SizeOf(LrecEndereco), 0);
  LrecEndereco.sin_family := AF_INET;
  LrecEndereco.sin_port := htons(TEF_UPD_PORTA);
  LrecEndereco.sin_addr.S_addr := inet_addr('127.0.0.1');

  if bind(FsckEscuta, TSockAddr(LrecEndereco), SizeOf(LrecEndereco)) <> 0 then
  begin
    pLogaUpd(Format('bind(127.0.0.1:%d) falhou com erro %d - a atualizacao vai ' +
      'acontecer pelo caminho lento.', [TEF_UPD_PORTA, WSAGetLastError]));
    closesocket(FsckEscuta);
    FsckEscuta := INVALID_SOCKET;
    Exit(False);
  end;

  { listen(1): so existe um remetente possivel. Ver o cabecalho da unit. }
  if listen(FsckEscuta, 1) <> 0 then
  begin
    pLogaUpd(Format('listen falhou com erro %d.', [WSAGetLastError]));
    closesocket(FsckEscuta);
    FsckEscuta := INVALID_SOCKET;
    Exit(False);
  end;

  pLogaUpd(Format('ouvindo em 127.0.0.1:%d (canal de volume da atualizacao).',
    [TEF_UPD_PORTA]));
  Result := True;
end;

function TTefEstacaoUpdateThread.fRecebeTudo(var AbytDestino: TBytes;
  const AintQuantidade: Integer): Boolean;
var
  LintLido, LintAgora: Integer;
begin
  SetLength(AbytDestino, AintQuantidade);
  LintLido := 0;
  while LintLido < AintQuantidade do
  begin
    if Terminated then
      Exit(False);
    LintAgora := recv(FsckCliente, AbytDestino[LintLido], AintQuantidade - LintLido, 0);
    if LintAgora <= 0 then
      Exit(False);
    Inc(LintLido, LintAgora);
  end;
  Result := True;
end;

function TTefEstacaoUpdateThread.fEnviaTudo(const AbytDados: TBytes): Boolean;
var
  LintEnviado, LintAgora: Integer;
begin
  LintEnviado := 0;
  while LintEnviado < Length(AbytDados) do
  begin
    LintAgora := send(FsckCliente, AbytDados[LintEnviado],
      Length(AbytDados) - LintEnviado, 0);
    if LintAgora <= 0 then
      Exit(False);
    Inc(LintEnviado, LintAgora);
  end;
  Result := True;
end;

procedure TTefEstacaoUpdateThread.pResponde(const AblnOk: Boolean; const AstrErro: String);
var
  LbytJson, LbytQuadro: TBytes;
  LdwTamanho: UInt32;
  LstrJson: String;
begin
  if AblnOk then
    LstrJson := '{"ok":true}'
  else
    LstrJson := '{"ok":false,"erro":"' +
      StringReplace(AstrErro, '"', '''', [rfReplaceAll]) + '"}';

  LbytJson := TEncoding.UTF8.GetBytes(LstrJson);
  LdwTamanho := Length(LbytJson);

  SetLength(LbytQuadro, SizeOf(UInt32) + Integer(LdwTamanho));
  Move(LdwTamanho, LbytQuadro[0], SizeOf(UInt32));
  Move(LbytJson[0], LbytQuadro[SizeOf(UInt32)], Integer(LdwTamanho));

  fEnviaTudo(LbytQuadro);
end;

procedure TTefEstacaoUpdateThread.pAtendeConexao;
var
  LbytTamanho, LbytCorpo: TBytes;
  LdwTamanho: UInt32;
  LObjDados: TJSONValue;
  LstrPacote: String;
  LintSeq: Integer;
begin
  while (not Terminated) and (FsckCliente <> INVALID_SOCKET) do
  begin
    if not fRecebeTudo(LbytTamanho, SizeOf(UInt32)) then
      Exit;

    Move(LbytTamanho[0], LdwTamanho, SizeOf(UInt32));
    if (LdwTamanho = 0) or (LdwTamanho > TEF_UPD_TAMANHO_MAX) then
    begin
      { Sem responder: com o tamanho fora de faixa nao da para confiar no
        alinhamento do fluxo, e responder manteria uma conversa que ja
        perdeu o sincronismo. Fechar forca o outro lado a recomecar. }
      pLogaUpd(Format('tamanho de quadro invalido (%d bytes) - fechando a conexao.',
        [LdwTamanho]));
      Exit;
    end;

    if not fRecebeTudo(LbytCorpo, Integer(LdwTamanho)) then
      Exit;

    try
      LObjDados := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetString(LbytCorpo));
      try
        if not (LObjDados is TJSONObject) then
          raise Exception.Create('quadro nao e um objeto JSON valido');

        LstrPacote := fJsonStr(TJSONObject(LObjDados), 'pacote');
        LintSeq := fJsonInt(TJSONObject(LObjDados), 'seq', -1);

        { pParte roda sob o FcsAcesso da propria TTefEstacaoAtualizacao, que
          existe justamente porque a classe e chamada de varias threads - ver
          o cabecalho dela. A guarda de ordem de seq tambem e de la: nao
          duplicar nada disso aqui. }
        FAtualizacao.pParte(LstrPacote, LintSeq,
          fJsonStr(TJSONObject(LObjDados), 'conteudoBase64'));

        pResponde(True, '');
      finally
        LObjDados.Free;
      end;
    except
      on E: Exception do
      begin
        pLogaUpd(Format('bloco RECUSADO (%s: %s).', [E.ClassName, E.Message]));
        pResponde(False, E.ClassName + ': ' + E.Message);
      end;
    end;
  end;
end;

procedure TTefEstacaoUpdateThread.Execute;
var
  LrecCliente: TSockAddrIn;
  LintTam: Integer;
begin
  { Falhar aqui NAO derruba o servico e nao impede a atualizacao: sem esta
    porta o autcom nao consegue abrir o canal rapido e cai no caminho lento
    (RF45), que e o que roda em producao hoje. }
  if not fCriaEscuta then
    Exit;

  try
    while not Terminated do
    begin
      LintTam := SizeOf(LrecCliente);
      FsckCliente := accept(FsckEscuta, @LrecCliente, @LintTam);
      if (FsckCliente = INVALID_SOCKET) or Terminated then
        Break;

      pLogaUpd('plugin de volume conectado.');
      try
        pAtendeConexao;
      finally
        if FsckCliente <> INVALID_SOCKET then
        begin
          closesocket(FsckCliente);
          FsckCliente := INVALID_SOCKET;
        end;
        pLogaUpd('plugin de volume desconectado.');
      end;
    end;
  except
    on E: Exception do
      pLogaUpd(Format('thread de aceite encerrada por %s: %s', [E.ClassName, E.Message]));
  end;

  if FsckEscuta <> INVALID_SOCKET then
  begin
    closesocket(FsckEscuta);
    FsckEscuta := INVALID_SOCKET;
  end;
end;

constructor TTefEstacaoUpdateListener.Create(AAtualizacao: TTefEstacaoAtualizacao);
begin
  inherited Create;
  FAtualizacao := AAtualizacao;
end;

destructor TTefEstacaoUpdateListener.Destroy;
begin
  pPara;
  inherited;
end;

procedure TTefEstacaoUpdateListener.pInicia;
var
  LobjWsaData: TWSAData;
begin
  if Assigned(FthdAceite) then
    Exit;

  WSAStartup($0202, LobjWsaData);
  FthdAceite := TTefEstacaoUpdateThread.Create(FAtualizacao);
end;

procedure TTefEstacaoUpdateListener.pPara;
begin
  if not Assigned(FthdAceite) then
    Exit;

  TTefEstacaoUpdateThread(FthdAceite).pDerruba;
  FthdAceite.WaitFor;
  FreeAndNil(FthdAceite);
  pLogaUpd('porta de volume encerrada.');
end;

end.
