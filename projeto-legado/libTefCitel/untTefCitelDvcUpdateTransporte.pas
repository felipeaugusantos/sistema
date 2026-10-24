unit untTefCitelDvcUpdateTransporte;

{ Transporte do canal de volume da atualizacao, lado AUTCOM (Req. 456190,
  Fase 6.1). Abre o canal DVC "TefCitelUpd", manda um bloco, espera a
  resposta, repete. Nada mais.

  A PREMISSA QUE SUSTENTA TUDO, E QUE NAO PODE SER QUEBRADA

  Este canal e usado por UMA thread so, em pergunta-resposta estrita: escreve
  e so entao le. Nenhuma outra escrita acontece nele enquanto uma leitura
  esta pendente.

  Isso nao e detalhe de implementacao - e a razao de o bloco poder ser de
  centenas de KB aqui enquanto o canal da transacao fragmenta tudo em 1400
  bytes. A causa da perda que obrigou aqueles 1400 bytes e
  "WTSVirtualChannelWrite abortando o WTSVirtualChannelRead pendente"
  (untTefCitelDvcTransporte.pas:301) - ou seja, CONCORRENCIA, nao tamanho. A
  PoC DVC_v2 provou 1 MiB em 1.000 repeticoes justamente por ser serializada
  e sozinha no canal.

  Se alguem um dia mandar algo nao solicitado por este canal, ou usar duas
  threads nele, a premissa cai e os blocos grandes voltam a se perder. A RN37
  proibe: este canal nunca carrega metodo de transacao.

  POR QUE A REMONTAGEM E DUPLICADA AQUI

  O fProcessaChunkWts de untTefCitelDvcTransporte.pas faz a mesma coisa, mas
  e privado - e aquela unit e codigo validado que esta fase nao pode tocar.
  A logica foi reescrita aqui seguindo as DUAS licoes de campo que estao
  registradas la, e nao a versao "obvia":

  1. As flags FIRST/LAST do CHANNEL_PDU_HEADER **nao sao confiaveis** nesta
     combinacao (DVC dentro do mstsc.exe). Um dump forense de 2026-08-28
     pegou um chunk com flags=LAST declarando totalLength=2298 e trazendo
     1596 bytes. So o totalLength sempre bateu - e e so nele que se decide
     se a mensagem acabou. A PoC decide por flag, e por isso NAO foi copiada
     como estava.
  2. O canal as vezes entrega ruido no lugar do inicio de uma mensagem. A
     defesa e que um inicio de verdade sempre traz, logo apos o header WTS,
     o NOSSO prefixo de tamanho, e prefixo + 4 tem que bater com o
     totalLength do header. Nosso enquadramento e exatamente assim, entao a
     mesma validacao vale aqui sem adaptacao.

  ENQUADRAMENTO (identico nos tres pontos - aqui, plugin e servico):
    [4 bytes tamanho little-endian][N bytes JSON UTF-8]
  O objeto do PEDIDO tem as chaves "pacote", "seq" e "conteudoBase64"; o da
  RESPOSTA tem "ok" e, quando false, "erro". Escrito por extenso e nao
  transcrito porque chave de fechamento dentro de comentario Pascal fecha o
  comentario. }

interface

uses
  Winapi.Windows, System.SysUtils;

type
  TTefCitelDvcUpdateTransporte = class
  private
    FhndCanal: THandle;
    FarrParcial: TBytes;
    FdwTotalEsperado: UInt32;
    function fEscreveCanal(const AbytDados: TBytes): Boolean;
    function fProcessaChunk(ABuffer: PByte; const AdwBytesLidos: UInt32): TBytes;
    function fLeResposta(out AstrJson: String; out AstrErro: String): Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    { Abre o canal. False = indisponivel, e AstrMotivo diz por que. NAO
      levanta excecao: estacao sem a TefCitelDvcUpdate.dll registrada e caso
      ESPERADO (RF45), nao erro - quem chama cai no caminho lento. }
    function fAbre(out AstrMotivo: String): Boolean;

    { Manda um bloco e espera a resposta. False = recusado ou falhou. }
    function fEnviaBloco(const AstrPacote: String; const AintSeq: Integer;
      const AstrBase64: String; out AstrErro: String): Boolean;

    procedure pFecha;
  end;

implementation

uses
  System.JSON, System.NetEncoding,
  untTefCitelAtuComum, untTefCitelDvcTransporte;

const
  WTS_CURRENT_SESSION        = DWORD(-1);
  WTS_CHANNEL_OPTION_DYNAMIC = $00000001;

  { CHANNEL_PDU_HEADER: 4 bytes de totalLength + 4 de flags. }
  CHANNEL_HEADER_SIZE = 8;

  { Teto do que aceitamos remontar. O bloco de 256 KiB vira ~341 KiB de
    base64 mais envelope; 2 MiB da folga larga e barra totalLength absurdo
    vindo de header corrompido ANTES de tentar alocar. }
  TEF_UPD_TAMANHO_MAX = 2 * 1024 * 1024;

  { Buffer de uma leitura fisica. O canal entrega ~1600 bytes por chunk; 64 KB
    e folga confortavel e evita leitura curta por buffer pequeno. }
  TEF_UPD_BUFFER_LEITURA = 64 * 1024;

function WTSVirtualChannelOpenEx(SessionId: DWORD; VirtualName: PAnsiChar;
  Flags: DWORD): THandle; stdcall; external 'wtsapi32.dll';
function WTSVirtualChannelClose(ChannelHandle: THandle): BOOL; stdcall;
  external 'wtsapi32.dll';
function WTSVirtualChannelRead(ChannelHandle: THandle; TimeOut: ULONG;
  Buffer: PAnsiChar; BufferSize: ULONG; var BytesRead: ULONG): BOOL; stdcall;
  external 'wtsapi32.dll';
function WTSVirtualChannelWrite(ChannelHandle: THandle; Buffer: PAnsiChar;
  Length: ULONG; var BytesWritten: ULONG): BOOL; stdcall;
  external 'wtsapi32.dll';

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

function fJsonBool(AObj: TJSONObject; const AstrNome: String;
  const AblnPadrao: Boolean): Boolean;
var
  LstrValor: String;
begin
  LstrValor := fJsonStr(AObj, AstrNome);
  if LstrValor = '' then
    Exit(AblnPadrao);
  Result := SameText(LstrValor, 'true');
end;

constructor TTefCitelDvcUpdateTransporte.Create;
begin
  inherited Create;
  FhndCanal := 0;
  FdwTotalEsperado := 0;
  SetLength(FarrParcial, 0);
end;

destructor TTefCitelDvcUpdateTransporte.Destroy;
begin
  pFecha;
  inherited;
end;

function TTefCitelDvcUpdateTransporte.fAbre(out AstrMotivo: String): Boolean;
begin
  AstrMotivo := '';
  if FhndCanal <> 0 then
    Exit(True);

  FhndCanal := WTSVirtualChannelOpenEx(WTS_CURRENT_SESSION,
    PAnsiChar(TEF_UPD_CANAL), WTS_CHANNEL_OPTION_DYNAMIC);

  if FhndCanal = 0 then
  begin
    AstrMotivo := Format('canal "%s" nao abriu (erro %d) - estacao sem a ' +
      'TefCitelDvcUpdate.dll registrada, ou cliente RDP sem suporte',
      [String(TEF_UPD_CANAL), GetLastError]);
    Exit(False);
  end;

  FdwTotalEsperado := 0;
  SetLength(FarrParcial, 0);
  pLogaDiagnosticoDvc(Format('Atualizacao: canal de volume "%s" aberto.',
    [String(TEF_UPD_CANAL)]));
  Result := True;
end;

procedure TTefCitelDvcUpdateTransporte.pFecha;
begin
  if FhndCanal <> 0 then
  begin
    WTSVirtualChannelClose(FhndCanal);
    FhndCanal := 0;
    pLogaDiagnosticoDvc('Atualizacao: canal de volume fechado.');
  end;
  FdwTotalEsperado := 0;
  SetLength(FarrParcial, 0);
end;

function TTefCitelDvcUpdateTransporte.fEscreveCanal(const AbytDados: TBytes): Boolean;
var
  LdwEscrito: ULONG;
begin
  LdwEscrito := 0;
  Result := WTSVirtualChannelWrite(FhndCanal, PAnsiChar(@AbytDados[0]),
    Length(AbytDados), LdwEscrito);
end;

{ Espelha o fProcessaChunkWts de untTefCitelDvcTransporte.pas - ver as duas
  licoes de campo no cabecalho desta unit. Devolve vazio enquanto a mensagem
  nao estiver completa; o chamador so volta a ler. }
function TTefCitelDvcUpdateTransporte.fProcessaChunk(ABuffer: PByte;
  const AdwBytesLidos: UInt32): TBytes;
var
  LdwTotalLength, LdwDataLength, LdwCandidato: UInt32;
  LintTamAntigo: Integer;
begin
  Result := nil;

  if AdwBytesLidos < CHANNEL_HEADER_SIZE then
    Exit;

  Move(ABuffer[0], LdwTotalLength, SizeOf(LdwTotalLength));
  if (LdwTotalLength = 0) or (LdwTotalLength > TEF_UPD_TAMANHO_MAX) then
  begin
    pLogaDiagnosticoDvc(Format(
      'Atualizacao: chunk com totalLength invalido (%d) - descartado.', [LdwTotalLength]));
    Exit;
  end;

  LdwDataLength := AdwBytesLidos - CHANNEL_HEADER_SIZE;

  if FdwTotalEsperado = 0 then
  begin
    { Validacao de INICIO DE MENSAGEM (licao 2 do cabecalho): o comeco de
      verdade sempre traz o nosso prefixo de tamanho logo apos o header WTS,
      e prefixo + 4 tem de bater com o totalLength. Se nao bater, este chunk
      e ruido do canal no lugar do inicio - descarta so ele e espera o
      inicio real, sem sujar o acumulador. }
    if LdwDataLength >= SizeOf(UInt32) then
    begin
      Move(ABuffer[CHANNEL_HEADER_SIZE], LdwCandidato, SizeOf(UInt32));
      if LdwCandidato + SizeOf(UInt32) <> LdwTotalLength then
      begin
        pLogaDiagnosticoDvc(Format(
          'Atualizacao: chunk no lugar do inicio nao comeca com quadro valido ' +
          '(tamanho embutido=%d, esperado=%d) - descartado como ruido.',
          [LdwCandidato, LdwTotalLength - SizeOf(UInt32)]));
        Exit;
      end;
    end;
    FdwTotalEsperado := LdwTotalLength;
  end
  else if LdwTotalLength <> FdwTotalEsperado then
  begin
    { Mensagem anterior nunca completou e esta e outra. Nao da para remontar
      duas ao mesmo tempo: abandona a antiga e recomeca por esta. }
    pLogaDiagnosticoDvc(Format(
      'Atualizacao: mensagem de %d bytes abandonada no meio (%d acumulados) - ' +
      'chegou outra de %d bytes.',
      [FdwTotalEsperado, Length(FarrParcial), LdwTotalLength]));
    SetLength(FarrParcial, 0);
    FdwTotalEsperado := LdwTotalLength;
  end;

  LintTamAntigo := Length(FarrParcial);
  SetLength(FarrParcial, LintTamAntigo + Integer(LdwDataLength));
  if LdwDataLength > 0 then
    Move(ABuffer[CHANNEL_HEADER_SIZE], FarrParcial[LintTamAntigo], LdwDataLength);

  { Decidido SO pelo totalLength - as flags FIRST/LAST nao sao confiaveis
    aqui (licao 1 do cabecalho). }
  if UInt32(Length(FarrParcial)) < FdwTotalEsperado then
    Exit;

  Result := Copy(FarrParcial, 0, Integer(FdwTotalEsperado));
  SetLength(FarrParcial, 0);
  FdwTotalEsperado := 0;
end;

function TTefCitelDvcUpdateTransporte.fLeResposta(out AstrJson: String;
  out AstrErro: String): Boolean;
var
  LarrBuffer, LarrMensagem: TBytes;
  LdwLidos, LdwTamanhoJson: ULONG;
  LdwInicio, LdwRestante: DWORD;
begin
  AstrJson := '';
  AstrErro := '';
  SetLength(LarrBuffer, TEF_UPD_BUFFER_LEITURA);
  LdwInicio := GetTickCount;

  repeat
    { O teto e do BLOCO inteiro, nao de cada leitura fisica: uma mensagem
      multi-chunk nao pode ganhar teto novo a cada chunk. }
    if GetTickCount - LdwInicio >= TEF_UPD_TIMEOUT_BLOCO_MS then
    begin
      AstrErro := Format('sem resposta do bloco em %d ms', [TEF_UPD_TIMEOUT_BLOCO_MS]);
      Exit(False);
    end;
    LdwRestante := TEF_UPD_TIMEOUT_BLOCO_MS - (GetTickCount - LdwInicio);

    LdwLidos := 0;
    if not WTSVirtualChannelRead(FhndCanal, LdwRestante, PAnsiChar(@LarrBuffer[0]),
         Length(LarrBuffer), LdwLidos) then
    begin
      AstrErro := Format('WTSVirtualChannelRead falhou (erro %d)', [GetLastError]);
      Exit(False);
    end;

    if LdwLidos = 0 then
      Continue;

    LarrMensagem := fProcessaChunk(@LarrBuffer[0], LdwLidos);
  until Length(LarrMensagem) > 0;

  { A mensagem completa e o nosso quadro: 4 bytes de tamanho + JSON. }
  if Length(LarrMensagem) < SizeOf(UInt32) then
  begin
    AstrErro := 'resposta menor que o proprio cabecalho';
    Exit(False);
  end;

  Move(LarrMensagem[0], LdwTamanhoJson, SizeOf(UInt32));
  if UInt32(Length(LarrMensagem)) <> LdwTamanhoJson + SizeOf(UInt32) then
  begin
    AstrErro := Format('resposta com tamanho inconsistente (declarado %d, recebido %d)',
      [LdwTamanhoJson, Length(LarrMensagem) - SizeOf(UInt32)]);
    Exit(False);
  end;

  AstrJson := TEncoding.UTF8.GetString(LarrMensagem, SizeOf(UInt32), Integer(LdwTamanhoJson));
  Result := True;
end;

function TTefCitelDvcUpdateTransporte.fEnviaBloco(const AstrPacote: String;
  const AintSeq: Integer; const AstrBase64: String; out AstrErro: String): Boolean;
var
  LObjPedido: TJSONObject;
  LValorResp: TJSONValue;
  LbytJson, LbytQuadro: TBytes;
  LdwTamanho: UInt32;
  LstrJson: String;
begin
  AstrErro := '';
  if FhndCanal = 0 then
  begin
    AstrErro := 'canal de volume nao esta aberto';
    Exit(False);
  end;

  LObjPedido := TJSONObject.Create;
  try
    LObjPedido.AddPair('pacote', AstrPacote);
    LObjPedido.AddPair('seq', TJSONNumber.Create(AintSeq));
    LObjPedido.AddPair('conteudoBase64', AstrBase64);
    LbytJson := TEncoding.UTF8.GetBytes(LObjPedido.ToJSON);
  finally
    LObjPedido.Free;
  end;

  LdwTamanho := Length(LbytJson);
  SetLength(LbytQuadro, SizeOf(UInt32) + Integer(LdwTamanho));
  Move(LdwTamanho, LbytQuadro[0], SizeOf(UInt32));
  Move(LbytJson[0], LbytQuadro[SizeOf(UInt32)], Integer(LdwTamanho));

  if not fEscreveCanal(LbytQuadro) then
  begin
    AstrErro := Format('falha ao escrever no canal de volume (erro %d)', [GetLastError]);
    Exit(False);
  end;

  if not fLeResposta(LstrJson, AstrErro) then
    Exit(False);

  LValorResp := TJSONObject.ParseJSONValue(LstrJson);
  try
    if not (LValorResp is TJSONObject) then
    begin
      AstrErro := 'resposta do bloco nao e um objeto JSON valido';
      Exit(False);
    end;

    Result := fJsonBool(TJSONObject(LValorResp), 'ok', False);
    if not Result then
      AstrErro := fJsonStr(TJSONObject(LValorResp), 'erro');
  finally
    LValorResp.Free;
  end;
end;

end.
