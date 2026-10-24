unit untTefEstacaoLog;

{ Nucleo do log do servico da estacao (Req. 456190, RF22 - Passo 8 da Fase 5).

  Ate 2026-09-10 este projeto tinha DUAS funcoes de log com corpo proprio -
  pLogaEstacao (untTefEstacaoRoteadorMensagens.pas) e pLogaTcpEstacao
  (untTefEstacaoTcpTransporte.pas) - gravando no MESMO arquivo, sem lock
  entre elas e sem nenhum limite de tamanho. Esta unit centraliza o corpo:
  as duas continuam existindo com o mesmo nome e a mesma assinatura, so
  delegando para ca, e ganham o que a RF22 pedia:

    1. NIVEL configuravel (desligado / normal / diagnostico);
    2. LIMITE de tamanho com rotacao, para o arquivo nao crescer sem teto;
    3. carimbo de tempo montado por GetLocalTime, sem FormatDateTime;
    4. serializacao por secao critica.

  Os itens 3 e 4 nao sao enfeite. O lado autcom abandonou FormatDateTime em
  2026-08-28 depois de dois EAccessViolation em campo, ambos dentro de
  FormatDateTime/DateTimeToString e ambos lendo o MESMO endereco fixo -
  locale global da RTL (TFormatSettings) nao se comportando de forma
  thread-safe nesta versao do Delphi. Este processo tambem e multithread
  (uma thread por conexao de autcom, mais a espera de cada hook pendente) e
  as duas funcoes de log rodavam sem nenhuma protecao. Ver a secao
  "Deadlock TThread.Synchronize x ACK" e o "Bug 6" em IA\rules\tef-dvc.md.

  ONDE MORA A CONFIGURACAO. Num .ini ao lado do proprio .exe
  (TEF_LOG_INI_ARQUIVO), que e a MESMA pasta do TefCitelDvcPlugin.dll - o
  pacote de instalacao da estacao e uma pasta unica e flat (ver
  install\install-service.ps1). O plugin le o mesmo arquivo, com a mesma
  secao e as mesmas chaves, mas com COPIA PROPRIA deste codigo: os dois
  projetos tem search path diferente e nao compartilham unit. E a mesma
  decisao ja tomada para fCrc32 (ver IA\rules\tef-dvc.md) e vale a mesma
  regra - qualquer mudanca aqui precisa ser replicada em
  untTefCitelDvcPluginImpl.pas e em untTefCitelDvcTransporte.pas na MESMA
  sessao, senao os tres passam a se comportar diferente com o mesmo .ini.

  Se o .ini NAO existir ele e criado com os valores default e com comentario
  explicando cada chave - assim o suporte encontra o arquivo pronto para
  editar, em vez de ter que saber inventar o nome. Criado com CREATE_NEW de
  proposito: o servico e o plugin sobem em momentos diferentes e os dois
  tentam criar, entao quem chegar depois nao pode truncar o do outro.

  A configuracao e lida UMA VEZ, na primeira linha de log do processo, e
  fica em cache - alterar o .ini exige reiniciar o servico. Isso e
  deliberado: ler o .ini a cada linha poria uma abertura de arquivo extra no
  caminho de toda chamada TEF, e este subsistema ja teve corrupcao de heap
  por chamada concorrente intensa de log ("Bug 6", 2026-08-28). }

interface

const
  { Niveis. Uma linha e gravada quando o nivel DELA e menor ou igual ao
    nivel configurado - entao DESLIGADO nao grava nada e DIAGNOSTICO grava
    tudo. Toda chamada de log que ja existia antes do Passo 8 entrou como
    NORMAL, para o log em uso normal continuar exatamente o mesmo. }
  TEF_LOG_NIVEL_DESLIGADO   = 0;
  TEF_LOG_NIVEL_NORMAL      = 1;
  TEF_LOG_NIVEL_DIAGNOSTICO = 2;

  TEF_LOG_INI_ARQUIVO = 'TefCitelDvcLog.ini';
  TEF_LOG_INI_SECAO   = 'Log';
  TEF_LOG_ARQUIVO     = 'TefEstacaoService.log';

  TEF_LOG_NIVEL_DEFAULT          = TEF_LOG_NIVEL_NORMAL;
  TEF_LOG_TAMANHO_MAX_MB_DEFAULT = 10;
  TEF_LOG_ARQUIVOS_DEFAULT       = 3;

  { Conferir o tamanho do arquivo a cada linha custaria uma consulta de
    atributo por linha. A cada TEF_LOG_CHECAR_TAMANHO_CADA linhas o
    excedente maximo e de ~13 KB sobre o limite (64 linhas x ~200 bytes),
    irrelevante contra um teto de MB. A primeira linha do processo sempre
    confere, para um arquivo que ja estava grande ser rotacionado na
    subida em vez de esperar 64 linhas. }
  TEF_LOG_CHECAR_TAMANHO_CADA = 64;

{ Nivel efetivo deste processo (le o .ini na primeira chamada). }
function fNivelLogEstacao: Integer;
{ Para quem monta mensagem CARA (hex dump, JSON inteiro): conferir antes de
  montar, senao o custo e pago mesmo com o log desligado. }
function fLogEstacaoAtivo(const AintNivel: Integer): Boolean;
procedure pLogaEstacaoNivel(const AintNivel: Integer; const AstrMsg: String);

implementation

uses
  Winapi.Windows, System.SysUtils, System.SyncObjs;

var
  FcsLog: TCriticalSection;
  FblnConfigLida: Boolean;
  FintNivel: Integer;
  FintTamanhoMaxBytes: Int64;
  FintArquivos: Integer;
  FstrPastaLog: String;
  FdwLinhasDesdeChecagem: DWORD;

{ Ao lado do proprio .exe, e nao em %TEMP%, por um motivo medido em campo
  (2026-08-24): este processo roda como LocalSystem, e o %TEMP% dessa conta
  nao e obvio de achar nem de acessar de fora - nem C:\Windows\Temp nem
  C:\Windows\System32\config\systemprofile\...\Temp continham o arquivo.
  A pasta do .exe e a mesma pasta de instalacao flat de todo o resto
  (TefEstacaoService.exe, TefCitelDvcPlugin.dll, scripts, DLLs do
  Scope/CliSiTef), sempre gravavel pelo LocalSystem e facil de achar.

  Usa System.SysUtils/GetLocalTime e nao fNow de proposito: log de
  diagnostico local, nao dado de negocio nem de auditoria, e este projeto
  nao depende de libFuncoes. Ver a excecao de TTL/diagnostico no
  CLAUDE.md. }
function fPastaDoExe: String;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

{ Cria o .ini com os defaults e com comentario por chave. Best effort: se
  a pasta nao for gravavel, os defaults valem em memoria do mesmo jeito. }
procedure pCriaIniDefault(const AstrIni: String);
const
  MODELO =
    '; TefCitelDvcLog.ini - log do TEF pelo canal DVC (Req. 456190, RF22)'#13#10 +
    ';'#13#10 +
    '; Criado automaticamente com os valores default. Vale para os DOIS'#13#10 +
    '; processos desta pasta: o servico da estacao (TefEstacaoService.exe) e'#13#10 +
    '; o plugin do cliente RDP (TefCitelDvcPlugin.dll).'#13#10 +
    ';'#13#10 +
    '; A configuracao e lida UMA VEZ, na primeira linha de log de cada'#13#10 +
    '; processo. Depois de alterar este arquivo: reinicie o servico'#13#10 +
    '; (services.msc) e reconecte a sessao RDP, para o plugin recarregar.'#13#10 +
    ';'#13#10 +
    '[Log]'#13#10 +
    '; 0 = desligado, 1 = normal, 2 = diagnostico. O nivel 2 e MUITO'#13#10 +
    '; verboso (registra por quadro do canal) - ligar apenas durante uma'#13#10 +
    '; investigacao, a pedido do suporte, e voltar para 1 depois.'#13#10 +
    'Nivel=1'#13#10 +
    '; Tamanho maximo de cada arquivo de log, em MB. Ao passar deste'#13#10 +
    '; tamanho o arquivo e rotacionado (.log -> .1.log -> .2.log) e o mais'#13#10 +
    '; antigo e descartado.'#13#10 +
    'TamanhoMaxMB=10'#13#10 +
    '; Quantos arquivos manter no total, contando o atual. Com Arquivos=3 e'#13#10 +
    '; TamanhoMaxMB=10 o log ocupa no maximo ~30 MB por processo.'#13#10 +
    'Arquivos=3'#13#10 +
    '; Pasta onde gravar os logs. Vazio = a pasta padrao deste processo'#13#10 +
    '; (ao lado do .exe no servico; %TEMP% no plugin e no autcom, que'#13#10 +
    '; separa por usuario/sessao). Informe um caminho completo apenas se'#13#10 +
    '; precisar redirecionar - a pasta tem que existir e ser gravavel.'#13#10 +
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

{ Le o .ini uma unica vez. Chamada SEMPRE de dentro do FcsLog. }
procedure pCarregaConfig;
var
  LstrIni: String;
  LintMb: Integer;
  LarrPasta: array[0..MAX_PATH] of Char;
begin
  FblnConfigLida := True;
  FintNivel := TEF_LOG_NIVEL_DEFAULT;
  FintTamanhoMaxBytes := Int64(TEF_LOG_TAMANHO_MAX_MB_DEFAULT) * 1024 * 1024;
  FintArquivos := TEF_LOG_ARQUIVOS_DEFAULT;
  FstrPastaLog := fPastaDoExe;

  LstrIni := fPastaDoExe + TEF_LOG_INI_ARQUIVO;
  if not FileExists(LstrIni) then
    pCriaIniDefault(LstrIni);

  { GetPrivateProfileInt devolve o default quando o arquivo/chave nao
    existe, entao nao precisa de FileExists de novo - se a criacao acima
    falhou, os defaults continuam valendo. }
  FintNivel := GetPrivateProfileInt(TEF_LOG_INI_SECAO, 'Nivel',
    TEF_LOG_NIVEL_DEFAULT, PChar(LstrIni));
  if FintNivel < TEF_LOG_NIVEL_DESLIGADO then
    FintNivel := TEF_LOG_NIVEL_DESLIGADO;
  if FintNivel > TEF_LOG_NIVEL_DIAGNOSTICO then
    FintNivel := TEF_LOG_NIVEL_DIAGNOSTICO;

  LintMb := GetPrivateProfileInt(TEF_LOG_INI_SECAO, 'TamanhoMaxMB',
    TEF_LOG_TAMANHO_MAX_MB_DEFAULT, PChar(LstrIni));
  if LintMb < 1 then
    LintMb := 1;
  if LintMb > 1024 then
    LintMb := 1024;
  FintTamanhoMaxBytes := Int64(LintMb) * 1024 * 1024;

  FintArquivos := GetPrivateProfileInt(TEF_LOG_INI_SECAO, 'Arquivos',
    TEF_LOG_ARQUIVOS_DEFAULT, PChar(LstrIni));
  if FintArquivos < 1 then
    FintArquivos := 1;
  if FintArquivos > 20 then
    FintArquivos := 20;

  FillChar(LarrPasta, SizeOf(LarrPasta), 0);
  GetPrivateProfileString(TEF_LOG_INI_SECAO, 'Pasta', '', @LarrPasta[0],
    Length(LarrPasta), PChar(LstrIni));
  if (LarrPasta[0] <> #0) and DirectoryExists(String(PChar(@LarrPasta[0]))) then
    FstrPastaLog := IncludeTrailingPathDelimiter(String(PChar(@LarrPasta[0])));
end;

{ Tamanho atual do arquivo, pelo caminho - nao pelo handle. GetFileSize
  exige direito de leitura no handle, e o handle deste log e aberto so com
  FILE_APPEND_DATA; consultar pelo caminho nao tem essa restricao e nao
  depende de o arquivo existir (devolve 0 se nao existir). }
function fTamanhoArquivo(const AstrArquivo: String): Int64;
var
  LFad: TWin32FileAttributeData;
begin
  Result := 0;
  if not GetFileAttributesEx(PChar(AstrArquivo), GetFileExInfoStandard, @LFad) then
    Exit;
  Result := (Int64(LFad.nFileSizeHigh) shl 32) or Int64(LFad.nFileSizeLow);
end;

{ Rotacao: .log -> .1.log -> .2.log ..., descartando o mais antigo.
  Chamada SEMPRE de dentro do FcsLog.

  BEST EFFORT de proposito, e o motivo importa: o FcsLog serializa as
  threads DESTE processo, nao processos diferentes. No lado autcom dois
  autcom.exe da mesma sessao TS gravam no mesmo arquivo, e um MoveFile
  falha enquanto o outro processo tem o handle de append aberto. Falhar
  aqui e inofensivo - o arquivo passa do teto por algumas linhas e a
  rotacao acontece na proxima checagem, quando ninguem estiver escrevendo.
  Se o outro processo rotacionar primeiro, o OPEN_ALWAYS da escrita
  simplesmente cria um arquivo novo. Em nenhum dos casos ha perda de linha
  ja gravada nem arquivo corrompido - o que nao valeria a complexidade de
  um mutex nomeado entre processos. }
procedure pRotaciona(const AstrArquivo: String);
var
  LstrBase, LstrExt: String;
  LintInd: Integer;
begin
  if FintArquivos <= 1 then
  begin
    { Arquivos=1 significa "sem historico": nao ha para onde renomear, o
      atual e simplesmente descartado. }
    System.SysUtils.DeleteFile(AstrArquivo);
    Exit;
  end;

  LstrBase := ChangeFileExt(AstrArquivo, '');
  LstrExt := ExtractFileExt(AstrArquivo);

  System.SysUtils.DeleteFile(LstrBase + '.' + IntToStr(FintArquivos - 1) + LstrExt);
  for LintInd := FintArquivos - 2 downto 1 do
    System.SysUtils.RenameFile(
      LstrBase + '.' + IntToStr(LintInd) + LstrExt,
      LstrBase + '.' + IntToStr(LintInd + 1) + LstrExt);
  System.SysUtils.RenameFile(AstrArquivo, LstrBase + '.1' + LstrExt);
end;

function fNivelLogEstacao: Integer;
begin
  FcsLog.Enter;
  try
    if not FblnConfigLida then
      pCarregaConfig;
    Result := FintNivel;
  finally
    FcsLog.Leave;
  end;
end;

function fLogEstacaoAtivo(const AintNivel: Integer): Boolean;
begin
  Result := AintNivel <= fNivelLogEstacao;
end;

procedure pLogaEstacaoNivel(const AintNivel: Integer; const AstrMsg: String);
var
  LstrArquivo: String;
  LstrLinha: AnsiString;
  LhndArquivo: THandle;
  LintEscritos: DWORD;
  LSystemTime: TSystemTime;
  LblnChecar: Boolean;
begin
  FcsLog.Enter;
  try
    if not FblnConfigLida then
    begin
      pCarregaConfig;
      FdwLinhasDesdeChecagem := TEF_LOG_CHECAR_TAMANHO_CADA; // forca a 1a checagem
    end;

    if AintNivel > FintNivel then
      Exit;

    LstrArquivo := IncludeTrailingPathDelimiter(FstrPastaLog) + TEF_LOG_ARQUIVO;

    Inc(FdwLinhasDesdeChecagem);
    LblnChecar := FdwLinhasDesdeChecagem >= TEF_LOG_CHECAR_TAMANHO_CADA;
    if LblnChecar then
    begin
      FdwLinhasDesdeChecagem := 0;
      if fTamanhoArquivo(LstrArquivo) >= FintTamanhoMaxBytes then
        pRotaciona(LstrArquivo);
    end;

    { Mesmo formato de carimbo de sempre (yyyy-mm-dd hh:nn:ss.zzz), montado
      a mao a partir de GetLocalTime - ver o cabecalho desta unit. }
    GetLocalTime(LSystemTime);
    LstrLinha := AnsiString(Format('%.4d-%.2d-%.2d %.2d:%.2d:%.2d.%.3d  %s',
      [LSystemTime.wYear, LSystemTime.wMonth, LSystemTime.wDay,
       LSystemTime.wHour, LSystemTime.wMinute, LSystemTime.wSecond,
       LSystemTime.wMilliseconds, AstrMsg])) + AnsiString(#13#10);

    LhndArquivo := CreateFile(PChar(LstrArquivo), FILE_APPEND_DATA,
      FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_ALWAYS,
      FILE_ATTRIBUTE_NORMAL, 0);
    if LhndArquivo = INVALID_HANDLE_VALUE then
      Exit;
    try
      WriteFile(LhndArquivo, PAnsiChar(LstrLinha)^, Length(LstrLinha),
        LintEscritos, nil);
    finally
      CloseHandle(LhndArquivo);
    end;
  finally
    FcsLog.Leave;
  end;
end;

initialization
  FcsLog := TCriticalSection.Create;

finalization
  FcsLog.Free;

end.
