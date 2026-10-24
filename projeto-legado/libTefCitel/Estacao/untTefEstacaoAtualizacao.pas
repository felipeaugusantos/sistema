unit untTefEstacaoAtualizacao;

{ Atualizacao de arquivos na estacao (Req. 456190, Fase 6).

  Contrato em IA\specs\456190\specs.md secao 11; plano em plans.md secao 11;
  checklist em tasks.md, secao FASE 6.


  ESTADO: o servico faz a metade BENIGNA da Fase 6 - recebe pelo canal,
  confere o SHA-256, guarda em _Preparo\ e decide a ociosidade. Quem
  APLICA e o TefEstacaoAtualizador.exe, um executavel a parte
  (untTefEstacaoAplicacao.pas, no projeto Atualizador\).

  A SEPARACAO E DELIBERADA, e a razao e ANTIVIRUS - decisao do Rafael em
  2026-09-15, depois de o problema aparecer na propria implementacao.
  Trocar o proprio executavel, extrair .zip por cima de um diretorio de
  programa e parar/subir servico pelo SCM sao comportamentos que heuristica
  de antivirus olha torto, e um binario com essa combinacao foi barrado
  nesta maquina de desenvolvimento.

  O que decide e o modo de falha: se o antivirus barrar o
  TefEstacaoService.exe, a loja fica SEM TEF - ele e processo vital. Se
  barrar o atualizador, so a atualizacao para de acontecer e o TEF continua
  funcionando. Por isso nada aqui dentro pode voltar a mexer em executavel,
  em .zip ou no SCM: o perfil de comportamento deste binario e o mesmo que
  ja passou por todas as baterias de campo, e deve continuar sendo.

  POR QUE A REESCRITA E TEXTUAL, E NAO POR TIniFile (RN24).

  TMemIniFile.UpdateFile descarta comentario e reordena secao. O
  CliSiTef.ini real tem quatro comentarios escritos pela equipe de suporte -
  qual porta o pinpad usa, o limite de 32 posicoes da mensagem do display,
  o que significa o flag de codigo estendido. Gravar com TIniFile entregaria
  a estacao um arquivo funcionalmente identico e sem nenhuma dessas
  explicacoes.

  POR QUE EM TBytes, E NAO EM String (RN25).

  Os tres .ini sao Windows-1252 com acentuacao. Converter para UTF-16 e de
  volta e exatamente onde a acentuacao morre - e o conteudo chega aqui como
  bytes, vindo em base64 pelo canal, justamente para nao sofrer nenhuma
  transcodificacao no caminho. Latin-1 nao tem multibyte, entao quebrar
  linha por byte e seguro e a AnsiString interna preserva cada byte. }

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, System.SyncObjs,
  System.Generics.Collections;

type
  ETefEstacaoAtualizacao = class(Exception);

  { Uma recepcao de pacote em curso - vive so entre o pAbre e o fFecha.

    Se o autcom morrer no meio, ninguem chama fFecha e este objeto fica no
    dicionario ate o servico parar (o destrutor da classe dona fecha o
    stream) ou ate um pAbre novo do mesmo pacote descartar a tentativa
    anterior. O .parcial em disco e sempre sobrescrito pelo pAbre seguinte,
    entao nao ha lixo acumulando por retentativa. }
  TTefEstacaoRecepcao = class
  public
    strPacote: String;
    strArquivoOrigem: String;
    strHashEsperado: String;
    intTamanhoEsperado: Integer;
    intProximaSeq: Integer;
    stmDestino: TFileStream;

    { Dono e sinal de vida da recepcao (Req. 456190, achado de campo
      2026-09-17, caso B.1). Antes disto a recepcao nao tinha dono: dois
      autcom subindo juntos abriam o mesmo pacote e cada pAtuAbre descartava
      a recepcao do outro. Em campo os dois transferiram 9,7 MB, um deles
      escreveu dentro da recepcao aberta pelo outro, e so nao deu arquivo
      corrompido porque os dois mandavam o MESMO conteudo - o sha256 bateu
      por sorte, nao por desenho.

      dwTickUltimaParte e atualizado a cada pParte e serve para soltar o
      pacote quando o dono morre no meio - ver TEF_ATU_RECEPCAO_ABANDONADA_MS. }
    dwPidDono: DWORD;
    dwTickUltimaParte: DWORD;

    destructor Destroy; override;
  end;

  { Recepcao, conferencia e preparo dos pacotes de atualizacao na estacao
    (Req. 456190, Fase 6, Passo 1).

    Esta classe NAO aplica nada. Ela recebe, confere o SHA-256 e deixa o
    pacote em _Preparo\ com o hash anotado em [Preparado]. Quem aplica e o
    Passo 3, na subida do servico - e a separacao e deliberada (RN20/RN22):
    transferir nao toca em arquivo em uso e pode acontecer com a estacao
    ocupada; aplicar exige ociosidade e acontece quando nenhuma DLL nativa
    esta carregada.

    Os metodos publicos sao chamados das threads de despacho do roteador -
    uma por conexao de autcom - e, desde a Fase 6.1, TAMBEM da thread do
    TTefEstacaoUpdateListener, que recebe os blocos pelo canal de volume e
    chama pParte por fora do roteador. Por isso o dicionario e o arquivo de
    versao andam sob FcsAcesso, e por isso a lista de quem chama esta escrita
    aqui: uma thread nova que nao respeite o lock quebra a classe em
    silencio. A secao critica do Windows e recursiva, e isto e usado de
    proposito: fFecha ja detem o lock quando chama pGravaPreparado, que o
    toma de novo. }
  TTefEstacaoAtualizacao = class
  private
    FstrDirServico: String;
    FstrDirPreparo: String;
    FstrArqVersao: String;
    FcsAcesso: TCriticalSection;
    FdictRecepcoes: TObjectDictionary<String, TTefEstacaoRecepcao>;
    function fRecepcao(const AstrPacote: String): TTefEstacaoRecepcao;
    procedure pDescarta(const AstrPacote: String);
  public
    constructor Create(const AstrDirServico: String);
    destructor Destroy; override;

    property strDirServico: String read FstrDirServico;
    property strDirPreparo: String read FstrDirPreparo;

    { Hash do pacote JA APLICADO e do que esta apenas PREPARADO. String
      vazia quer dizer "nunca" - e e assim que uma estacao reinstalada
      volta a divergir sozinha e se reinstala (RN17). }
    function fHashAplicado(const AstrPacote: String): String;
    function fHashPreparado(const AstrPacote: String): String;

    { Diretorio do servico no momento da ultima aplicacao. Se ele divergir
      do atual, os .ini precisam ser reescritos mesmo com hash igual - o
      hash de origem nao muda quando o servico muda de pasta (RN19). }
    function fDirServicoAplicado: String;

    procedure pGravaPreparado(const AstrPacote, AstrHash: String);

    { Abre a recepcao de um pacote. AstrArquivo e o nome do arquivo de
      origem e serve SO para log - ver fNomeNoPreparo. }
    { AblnAberto False = outro autcom esta transferindo este pacote agora, e
      AstrMotivo explica. NAO e erro: quem chamou simplesmente nao transfere
      nesta carga (achado de campo 2026-09-17, caso B.1). }
    procedure pAbre(const AstrPacote, AstrArquivo, AstrHash: String;
      const AintTamanho: Integer; const AdwPidDono: DWORD;
      out AblnAberto: Boolean; out AstrMotivo: String);
    procedure pParte(const AstrPacote: String; const AintSeq: Integer;
      const AstrBase64: String);

    { Confere tamanho e SHA-256 do que chegou. Bateu: move para _Preparo\ e
      anota em [Preparado]; devolve True. Nao bateu: apaga o .parcial,
      nao anota nada e devolve False com AstrErro preenchido - a estacao
      segue funcionando com o que ja tinha (RN23). }
    function fFecha(const AstrPacote: String; out AstrErro: String): Boolean;

    { --- Arquivo de versao ---

      Publicos porque o TefEstacaoAtualizador.exe le e grava as MESMAS
      secoes, pela MESMA classe - e ter duas implementacoes do mesmo
      arquivo nos dois lados seria a forma mais facil de eles discordarem
      em silencio. String vazia sempre quer dizer "nunca". }
    function fLeVersao(const AstrSecao, AstrChave: String): String;
    procedure pGravaVersao(const AstrSecao, AstrChave, AstrValor: String);
    procedure pApagaVersao(const AstrSecao, AstrChave: String);

    { Caminho do arquivo que PROVA que o pacote esta onde a escrituracao
      diz. Devolve vazio quando nao da para provar com um arquivo so - e o
      caso do "aplicado" dos .zip, que viram varios arquivos soltos na pasta
      do servico. Ver o comentario de fHashAplicado. }
    function fArquivoQueProva(const AstrPacote: String;
      const AblnAplicado: Boolean): String;

    { Hash de um pacote que JA FALHOU em subir. Existe para quebrar o laco:
      sem isto, um .exe que nao sobe volta pelo rollback do atualizador, o
      autcom ve o hash divergente na carga seguinte, manda de novo, falha
      de novo - para sempre. }
    function fHashFalhou(const AstrPacote: String): String;

    { Ha algum pacote preparado esperando aplicacao? }
    function fTemPreparo: Boolean;

    { Marca que ha aplicacao pendente. Quem consome e o atualizador. }
    procedure pMarcaPendente;

    { Lanca o TefEstacaoAtualizador.exe DESTACADO e devolve.

      O atualizador para este servico pelo SCM, aplica tudo com ele parado
      - e so entao pode trocar o proprio TefEstacaoService.exe, que
      enquanto roda nao pode ser sobrescrito - sobe de novo, confere e
      reverte se o binario novo nao subir.

      QUANDO CHAMAR: depois de a resposta ao autcom ter saido e depois de a
      thread corrente ter deixado o FdictConexaoPorThread. As duas coisas
      importam, e o porque esta em FblnReiniciarAposResposta, no roteador.

      Devolve False com AstrErro preenchido quando nao conseguiu lancar -
      inclusive se o atualizador nao existir ou estiver bloqueado por
      antivirus. Esse caso PRECISA sair no log com todas as letras: sem
      isso o suporte procura no lugar errado, porque o sintoma e apenas
      "a atualizacao nao acontece". }
    function fDisparaAtualizador(out AstrErro: String): Boolean;
  end;

{ Os seis pacotes, na ordem em que sao aplicados. }
function fTodosOsPacotes: TArray<String>;

{ Carimbo de tempo local, montado a mao a partir de GetLocalTime.

  Nem fNow() nem FormatDateTime, e cada um tem motivo proprio. fNow() mora
  em libFuncoes e depende de conexao com o banco - este projeto nao linka
  libFuncoes e o servico nao tem conexao nenhuma; alem disso este carimbo e
  diagnostico, nunca data de negocio (a excecao esta no CLAUDE.md).
  FormatDateTime esta fora pela razao ja registrada no cabecalho de
  untTefEstacaoLog: dois EAccessViolation em campo dentro de
  FormatDateTime/DateTimeToString, locale global da RTL nao sendo
  thread-safe nesta versao do Delphi. }
function fCarimboLocal: String;

{ Nome do arquivo dentro de _Preparo\ para um pacote.

  DERIVADO DO NOME DO PACOTE, nunca do nome de arquivo que veio na rede - e
  esta e a diferenca que importa. O pacote e um conjunto FECHADO de seis
  valores conhecidos: um valor fora da lista devolve string vazia e o
  chamador recusa. Nenhum byte vindo do canal chega ao sistema de arquivos,
  entao nao ha "..\..\algo.exe" a sanitizar - a classe inteira de problema
  deixa de existir em vez de ser filtrada.

  Os .ini saem ja com o nome final (scope.ini, CliSiTef.ini, CONFITLS.ini) e
  os .zip com nome do pacote, para o _Preparo\ ser legivel por quem abrir a
  pasta para diagnosticar. }
function fNomeNoPreparo(const AstrPacote: String): String;

{ Reescreve as chaves de caminho de um .ini para AstrDirServico.

  AstrPacote e um dos TEF_ATU_PACOTE_*_INI de untTefCitelAtuComum. Pacote sem
  chave de caminho declarada (confitls.ini) devolve AbytConteudo intacto.

  Preserva comentario, ordem, espacamento em torno do '=' e o terminador de
  linha de cada linha. Chave declarada que nao existir e ACRESCENTADA ao fim
  da secao; secao que nao existir e acrescentada ao fim do arquivo. Nos dois
  casos o fato vai para o log - um .ini de origem sem a chave de caminho e
  sinal de arquivo desatualizado do lado do servidor, e quem for diagnosticar
  precisa ver isso. }
function fAjustaCaminhosIni(const AbytConteudo: TBytes;
  const AstrPacote, AstrDirServico: String): TBytes;

implementation

uses
  System.IOUtils, System.IniFiles, System.Hash,
  System.AnsiStrings, System.NetEncoding, untTefCitelAtuComum,
  untTefEstacaoLog;

type
  { Uma linha e o seu terminador, guardados separados justamente para que o
    terminador volte igual ao que veio. Arquivo com linha CRLF e linha LF
    misturadas continua misturado - nao e trabalho desta rotina normalizar
    o que o suporte gravou. }
  TdtoLinhaIni = record
    ansTexto: AnsiString;
    ansFim: AnsiString;
  end;
  TArrLinhaIni = TArray<TdtoLinhaIni>;

  TdtoChaveIni = record
    ansSecao: AnsiString;
    ansChave: AnsiString;
    blnAchou: Boolean;
    { Chave de caminho que vale em QUALQUER secao (Req. 456190, 2026-09-21).

      Duas diferencas em relacao a uma chave comum, e as duas importam:

      1. casa pelo NOME, sem olhar a secao - e por isso pode ser ajustada
         MAIS DE UMA VEZ no mesmo arquivo, uma por grupo onde aparecer;
      2. NUNCA e acrescentada quando falta. Uma chave comum ausente e
         sintoma de arquivo de origem velho e o conserto e cria-la; esta
         aqui nao tem secao declarada, entao nao ha onde criar - e inventar
         um grupo mudaria o comportamento do Scope por conta propria. }
    blnQualquerSecao: Boolean;
  end;
  TArrChaveIni = TArray<TdtoChaveIni>;

function fBytesParaAnsi(const AbytConteudo: TBytes): AnsiString;
begin
  Result := '';
  if Length(AbytConteudo) = 0 then
    Exit;
  SetLength(Result, Length(AbytConteudo));
  Move(AbytConteudo[0], Result[1], Length(AbytConteudo));
end;

function fAnsiParaBytes(const AansConteudo: AnsiString): TBytes;
begin
  SetLength(Result, Length(AansConteudo));
  if Length(AansConteudo) = 0 then
    Exit;
  Move(AansConteudo[1], Result[0], Length(AansConteudo));
end;

function fSeparaLinhas(const AansConteudo: AnsiString): TArrLinhaIni;
var
  LintPos, LintInicio, LintQtd: Integer;
  LansTexto: AnsiString;
begin
  SetLength(Result, 0);
  LintQtd := 0;
  LintInicio := 1;
  LintPos := 1;

  while LintPos <= Length(AansConteudo) do
  begin
    if AansConteudo[LintPos] = #10 then
    begin
      { O #13 pertence ao terminador, nao ao texto - senao ele sobreviveria
        no meio da linha quando a linha for reescrita. }
      if (LintPos > LintInicio) and (AansConteudo[LintPos - 1] = #13) then
        LansTexto := Copy(AansConteudo, LintInicio, LintPos - LintInicio - 1)
      else
        LansTexto := Copy(AansConteudo, LintInicio, LintPos - LintInicio);

      Inc(LintQtd);
      SetLength(Result, LintQtd);
      Result[LintQtd - 1].ansTexto := LansTexto;
      if (LintPos > LintInicio) and (AansConteudo[LintPos - 1] = #13) then
        Result[LintQtd - 1].ansFim := #13#10
      else
        Result[LintQtd - 1].ansFim := #10;

      LintInicio := LintPos + 1;
    end;
    Inc(LintPos);
  end;

  { Ultima linha sem quebra no fim do arquivo: entra com terminador vazio,
    para o arquivo voltar sem ganhar uma quebra que nao tinha. }
  if LintInicio <= Length(AansConteudo) then
  begin
    Inc(LintQtd);
    SetLength(Result, LintQtd);
    Result[LintQtd - 1].ansTexto := Copy(AansConteudo, LintInicio,
      Length(AansConteudo) - LintInicio + 1);
    Result[LintQtd - 1].ansFim := '';
  end;
end;

function fJuntaLinhas(const AarrLinhas: TArrLinhaIni): AnsiString;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to High(AarrLinhas) do
    Result := Result + AarrLinhas[I].ansTexto + AarrLinhas[I].ansFim;
end;

{ Terminador que o arquivo mais usa, para as linhas ACRESCENTADAS sairem no
  mesmo estilo do resto. Arquivo sem nenhuma quebra cai em CRLF, que e o que
  o Windows e a equipe de suporte usam. }
function fTerminadorDominante(const AarrLinhas: TArrLinhaIni): AnsiString;
var
  I, LintCrLf, LintLf: Integer;
begin
  LintCrLf := 0;
  LintLf := 0;
  for I := 0 to High(AarrLinhas) do
  begin
    if AarrLinhas[I].ansFim = #13#10 then
      Inc(LintCrLf)
    else if AarrLinhas[I].ansFim = #10 then
      Inc(LintLf);
  end;

  if LintLf > LintCrLf then
    Result := #10
  else
    Result := #13#10;
end;

function fEhComentario(const AansTexto: AnsiString): Boolean;
var
  LansTrim: AnsiString;
begin
  LansTrim := System.AnsiStrings.Trim(AansTexto);
  Result := (LansTrim <> '') and
            ((LansTrim[1] = ';') or (LansTrim[1] = '#'));
end;

function fEhSecao(const AansTexto: AnsiString; out AansSecao: AnsiString): Boolean;
var
  LansTrim: AnsiString;
begin
  AansSecao := '';
  LansTrim := System.AnsiStrings.Trim(AansTexto);
  Result := (Length(LansTrim) >= 2) and
            (LansTrim[1] = '[') and
            (LansTrim[Length(LansTrim)] = ']');
  if Result then
    AansSecao := System.AnsiStrings.Trim(Copy(LansTrim, 2, Length(LansTrim) - 2));
end;

{ Devolve a posicao do '=' e o nome da chave. Comentario nao conta - o
  CliSiTef.ini real tem "#DiretorioTrace=..." comentado em outras copias, e
  tratar isso como chave reescreveria o comentario e deixaria a chave de
  verdade intacta. }
function fEhChave(const AansTexto: AnsiString; out AansChave: AnsiString;
  out AintPosIgual: Integer): Boolean;
var
  I: Integer;
begin
  AansChave := '';
  AintPosIgual := 0;
  Result := False;

  if fEhComentario(AansTexto) then
    Exit;

  for I := 1 to Length(AansTexto) do
    if AansTexto[I] = '=' then
    begin
      AintPosIgual := I;
      Break;
    end;

  if AintPosIgual = 0 then
    Exit;

  AansChave := System.AnsiStrings.Trim(Copy(AansTexto, 1, AintPosIgual - 1));
  Result := AansChave <> '';
end;

{ Tabela do RF34. Uma linha por chave de caminho, por pacote. }
function fChavesDoPacote(const AstrPacote: String): TArrChaveIni;

  procedure pAdiciona(const AansSecao, AansChave: AnsiString);
  var
    LintQtd: Integer;
  begin
    LintQtd := Length(Result) + 1;
    SetLength(Result, LintQtd);
    Result[LintQtd - 1].ansSecao := AansSecao;
    Result[LintQtd - 1].ansChave := AansChave;
    Result[LintQtd - 1].blnAchou := False;
    Result[LintQtd - 1].blnQualquerSecao := False;
  end;

  { Chave de caminho que pode estar em qualquer grupo. Ajustada onde
    aparecer, quantas vezes aparecer, e nunca criada - ver o comentario de
    blnQualquerSecao. }
  procedure pAdicionaQualquerSecao(const AansChave: AnsiString);
  var
    LintQtd: Integer;
  begin
    LintQtd := Length(Result) + 1;
    SetLength(Result, LintQtd);
    Result[LintQtd - 1].ansSecao := '';
    Result[LintQtd - 1].ansChave := AansChave;
    Result[LintQtd - 1].blnAchou := False;
    Result[LintQtd - 1].blnQualquerSecao := True;
  end;

begin
  SetLength(Result, 0);

  if SameText(AstrPacote, TEF_ATU_PACOTE_SCOPE_INI) then
  begin
    pAdiciona('SCOPEAPI', 'ArqControlPath');
    pAdiciona('SCOPEAPI', 'ArqTracePath');

    { Preparado antes de o parametro existir (pedido do Rafael, 2026-09-21):
      o scope.ini vai ganhar parametros novos e alguns sao de caminho. O
      LogPath se comporta como o ArqControlPath - recebe o diretorio do
      servico da estacao -, mas pode aparecer em VARIOS grupos, e por isso
      entra por aqui e nao na tabela de secao fixa.

      Enquanto a tag nao existir no arquivo, esta linha nao faz nada: o
      ajuste so acontece onde a chave aparece. }
    pAdicionaQualquerSecao('LogPath');
  end
  else if SameText(AstrPacote, TEF_ATU_PACOTE_CLISITEF_INI) then
  begin
    pAdiciona('CliSiTef', 'DiretorioTrace');
    pAdiciona('SalvaEstado', 'DiretorioBase');
  end;

  { TEF_ATU_PACOTE_CONFITLS_INI nao tem chave de caminho - so
    TipoComunicacaoExterna, URLTLS e TokenRegistro. Copia pura, de
    proposito: devolver array vazio faz fAjustaCaminhosIni sair no atalho. }
end;

function fAjustaCaminhosIni(const AbytConteudo: TBytes;
  const AstrPacote, AstrDirServico: String): TBytes;
var
  LarrLinhas: TArrLinhaIni;
  LarrChaves: TArrChaveIni;
  LansValor, LansFim, LansSecaoAtual, LansSecao, LansChave: AnsiString;
  LintPosIgual, LintInicioValor, I, J: Integer;
begin
  Result := AbytConteudo;

  LarrChaves := fChavesDoPacote(AstrPacote);
  if Length(LarrChaves) = 0 then
    Exit;

  if Length(AbytConteudo) = 0 then
  begin
    pLogaEstacaoNivel(TEF_LOG_NIVEL_NORMAL,
      Format('fAjustaCaminhosIni: pacote "%s" chegou VAZIO - nada a ajustar. ' +
             'Conferir o arquivo de origem no diretorio do autcom.exe.',
             [AstrPacote]));
    Exit;
  end;

  { Os tres .ini de referencia gravam o caminho SEM delimitador no fim
    (ArqControlPath=C:\...\padra_atualizado). Manter esse formato: o Scope e
    o CliSiTef aceitam os dois, mas o arquivo tem que continuar parecido com
    o que o suporte conhece. }
  LansValor := AnsiString(ExcludeTrailingPathDelimiter(AstrDirServico));

  LarrLinhas := fSeparaLinhas(fBytesParaAnsi(AbytConteudo));
  LansFim := fTerminadorDominante(LarrLinhas);
  LansSecaoAtual := '';

  for I := 0 to High(LarrLinhas) do
  begin
    if fEhSecao(LarrLinhas[I].ansTexto, LansSecao) then
    begin
      LansSecaoAtual := LansSecao;
      Continue;
    end;

    if not fEhChave(LarrLinhas[I].ansTexto, LansChave, LintPosIgual) then
      Continue;

    for J := 0 to High(LarrChaves) do
    begin
      { Chave de qualquer secao nao para no primeiro achado: ela pode
        aparecer em varios grupos e todos tem de ser ajustados. }
      if LarrChaves[J].blnAchou and (not LarrChaves[J].blnQualquerSecao) then
        Continue;
      if (not LarrChaves[J].blnQualquerSecao) and
         (not System.AnsiStrings.SameText(LansSecaoAtual, LarrChaves[J].ansSecao)) then
        Continue;
      if not System.AnsiStrings.SameText(LansChave, LarrChaves[J].ansChave) then
        Continue;

      { Preserva o espacamento que havia entre o '=' e o valor antigo, para
        "Chave = x" nao virar "Chave =x". Tudo que vinha depois do '=' e
        substituido: estes campos sao caminho puro, sem comentario de fim de
        linha em nenhum dos tres arquivos de referencia. }
      LintInicioValor := LintPosIgual + 1;
      while (LintInicioValor <= Length(LarrLinhas[I].ansTexto)) and
            (CharInSet(LarrLinhas[I].ansTexto[LintInicioValor], [' ', #9])) do
        Inc(LintInicioValor);

      LarrLinhas[I].ansTexto :=
        Copy(LarrLinhas[I].ansTexto, 1, LintInicioValor - 1) + LansValor;

      { So a de qualquer secao e registrada: nela o grupo nao e conhecido de
        antemao, e saber EM QUAL grupo o caminho foi trocado e a unica forma
        de o suporte conferir o resultado. As de secao fixa ja estao
        declaradas na tabela e nao ganham ruido de log. }
      if LarrChaves[J].blnQualquerSecao then
        pLogaEstacaoNivel(TEF_LOG_NIVEL_NORMAL,
          Format('fAjustaCaminhosIni: "%s" - chave "%s" da secao "[%s]" ' +
                 'apontada para "%s".',
                 [AstrPacote, String(LarrChaves[J].ansChave),
                  String(LansSecaoAtual), String(LansValor)]));

      LarrChaves[J].blnAchou := True;
      Break;
    end;
  end;

  { CHAVE DECLARADA QUE NAO APARECEU: AVISA, NAO CRIA (decisao do Rafael,
    2026-09-22).

    Ate 21/09 este laco ACRESCENTAVA a chave. O sintoma que derrubou essa
    decisao: um scope.ini de loja que tinha "ArqControlPath" e NAO tinha
    "ArqTracePath" chegava na estacao com os dois - e o suporte, comparando
    origem e destino, encontrava uma tag que ninguem tinha escrito.

    O criterio antigo era incoerente com o do LogPath: chave com secao
    declarada era criada, chave sem secao nao era. Isso e detalhe de
    implementacao da tabela, nao razao de negocio - e as duas regras
    acabavam dizendo o oposto sobre a mesma coisa.

    O contrato passa a ser um so: **o .ini da estacao e o .ini da loja com
    os caminhos corrigidos, e nada mais**. O que a loja nao declarou, a
    estacao nao ganha - se o Scope precisa da chave, quem decide isso e o
    arquivo de origem, que e onde o suporte ja mexe.

    O AVISO fica: ele era metade do valor do codigo antigo, porque chave
    de caminho declarada e ausente tambem e sintoma de arquivo de origem
    velho. Agora ele avisa sem mudar o arquivo. }
  for J := 0 to High(LarrChaves) do
  begin
    if LarrChaves[J].blnAchou then
      Continue;

    { A de qualquer secao nao rende aviso: ausencia ali e o caso normal
      enquanto o parametro nao existir no arquivo de origem, e avisar em
      toda carga seria ruido. }
    if LarrChaves[J].blnQualquerSecao then
      Continue;

    pLogaEstacaoNivel(TEF_LOG_NIVEL_NORMAL,
      Format('fAjustaCaminhosIni: "%s" nao tem a chave "%s" na secao "[%s]" - ' +
             'NAO foi acrescentada (o .ini da estacao acompanha o da loja). ' +
             'Se o Scope precisar dela, a chave tem de entrar no arquivo de ' +
             'origem, no diretorio do autcom.exe.',
             [AstrPacote, String(LarrChaves[J].ansChave),
              String(LarrChaves[J].ansSecao)]));
  end;

  Result := fAnsiParaBytes(fJuntaLinhas(LarrLinhas));
end;

function fNomeNoPreparo(const AstrPacote: String): String;
begin
  if SameText(AstrPacote, TEF_ATU_PACOTE_SCOPE) then
    Result := TEF_ATU_PACOTE_SCOPE + '.zip'
  else if SameText(AstrPacote, TEF_ATU_PACOTE_CLISITEF) then
    Result := TEF_ATU_PACOTE_CLISITEF + '.zip'
  else if SameText(AstrPacote, TEF_ATU_PACOTE_SERVICO) then
    Result := TEF_ATU_PACOTE_SERVICO + '.zip'
  else if SameText(AstrPacote, TEF_ATU_PACOTE_LIB) then
    { Sem .zip: o nome no preparo e o nome final. Ver TEF_ATU_PACOTE_LIB. }
    Result := TEF_ATU_DLL_LIB
  else if SameText(AstrPacote, TEF_ATU_PACOTE_SCOPE_INI) then
    Result := TEF_ATU_INI_SCOPE
  else if SameText(AstrPacote, TEF_ATU_PACOTE_CLISITEF_INI) then
    Result := TEF_ATU_INI_CLISITEF
  else if SameText(AstrPacote, TEF_ATU_PACOTE_CONFITLS_INI) then
    Result := TEF_ATU_INI_CONFITLS
  else
    Result := '';
end;

{ TTefEstacaoRecepcao }

destructor TTefEstacaoRecepcao.Destroy;
begin
  { O stream pode ja ter sido fechado pelo fFecha - FreeAndNil la deixa nil
    e este Free nao faz nada. O caminho que importa aqui e o outro: servico
    parando com transferencia pela metade. }
  stmDestino.Free;
  inherited;
end;

{ TTefEstacaoAtualizacao }

constructor TTefEstacaoAtualizacao.Create(const AstrDirServico: String);
begin
  inherited Create;
  FstrDirServico := IncludeTrailingPathDelimiter(AstrDirServico);
  FstrDirPreparo := TPath.Combine(FstrDirServico, TEF_ATU_DIR_PREPARO);
  FstrArqVersao := TPath.Combine(FstrDirServico, TEF_ATU_ARQ_VERSAO);
  FcsAcesso := TCriticalSection.Create;
  FdictRecepcoes :=
    TObjectDictionary<String, TTefEstacaoRecepcao>.Create([doOwnsValues]);
end;

destructor TTefEstacaoAtualizacao.Destroy;
begin
  { doOwnsValues faz o Free de cada recepcao, e o destrutor dela fecha o
    stream. Transferencia interrompida por parada do servico nao deixa
    handle aberto - o que importa quando o proximo passo do requisito for
    justamente RENOMEAR arquivos nesta pasta. }
  FdictRecepcoes.Free;
  FcsAcesso.Free;
  inherited;
end;

function TTefEstacaoAtualizacao.fRecepcao(
  const AstrPacote: String): TTefEstacaoRecepcao;
begin
  if not FdictRecepcoes.TryGetValue(LowerCase(AstrPacote), Result) then
    raise ETefEstacaoAtualizacao.CreateFmt(
      'Pacote "%s" nao tem recepcao aberta - o pAtuAbre nao chegou, ou a ' +
      'recepcao ja foi fechada.', [AstrPacote]);
end;

procedure TTefEstacaoAtualizacao.pDescarta(const AstrPacote: String);
var
  LRecepcao: TTefEstacaoRecepcao;
  LstrParcial: String;
begin
  if not FdictRecepcoes.TryGetValue(LowerCase(AstrPacote), LRecepcao) then
    Exit;

  pLogaEstacaoNivel(TEF_LOG_NIVEL_NORMAL, Format(
    'Recepcao anterior do pacote "%s" DESCARTADA - chegou um pAtuAbre novo ' +
    'com %d parte(s) ja recebida(s). Transferencia interrompida do outro ' +
    'lado, ou dois autcom mandando o mesmo pacote.',
    [AstrPacote, LRecepcao.intProximaSeq]));

  { doOwnsValues: o Remove destroi a recepcao, e o destrutor dela fecha o
    stream. O TFile.Delete abaixo depende disso ter acontecido primeiro. }
  FdictRecepcoes.Remove(LowerCase(AstrPacote));

  LstrParcial := TPath.Combine(FstrDirPreparo,
    fNomeNoPreparo(AstrPacote) + '.parcial');
  if TFile.Exists(LstrParcial) then
    TFile.Delete(LstrParcial);
end;

function TTefEstacaoAtualizacao.fLeVersao(
  const AstrSecao, AstrChave: String): String;
var
  LIni: TMemIniFile;
begin
  FcsAcesso.Acquire;
  try
    { TMemIniFile com TEncoding.ANSI, e a escolha do encoding nao e
      detalhe: com TEncoding.UTF8 o UpdateFile grava BOM, e o
      GetPrivateProfileString do Windows - que e o que esta por tras do
      TIniFile - nao entende BOM. A primeira secao vira
      "EF BB BF + [Aplicado]" e some. Flagrado em 2026-09-15 com o
      harness do Passo 1: fHashPreparado lia certo e o TIniFile lia vazio
      do MESMO arquivo.

      Isto importa porque o TefEstacaoVersao.ini e material de diagnostico
      do suporte, e tem que abrir em qualquer ferramenta comum do Windows.
      ANSI tambem e coerente com o resto da pilha: Scope e CliSiTef sao
      ANSI, e um caminho que nao coubesse na codepage da estacao tambem
      nao funcionaria nas DLLs nativas. }
    LIni := TMemIniFile.Create(FstrArqVersao, TEncoding.ANSI);
    try
      Result := Trim(LIni.ReadString(AstrSecao, AstrChave, ''));
    finally
      LIni.Free;
    end;
  finally
    FcsAcesso.Release;
  end;
end;

procedure TTefEstacaoAtualizacao.pGravaVersao(
  const AstrSecao, AstrChave, AstrValor: String);
var
  LIni: TMemIniFile;
begin
  FcsAcesso.Acquire;
  try
    if not TDirectory.Exists(FstrDirServico) then
      TDirectory.CreateDirectory(FstrDirServico);

    LIni := TMemIniFile.Create(FstrArqVersao, TEncoding.ANSI);
    try
      LIni.WriteString(AstrSecao, AstrChave, AstrValor);
      LIni.UpdateFile;
    finally
      LIni.Free;
    end;
  finally
    FcsAcesso.Release;
  end;
end;

function TTefEstacaoAtualizacao.fArquivoQueProva(const AstrPacote: String;
  const AblnAplicado: Boolean): String;
var
  LstrNome: String;
begin
  Result := '';
  LstrNome := fNomeNoPreparo(AstrPacote);
  if LstrNome = '' then
    Exit;

  if not AblnAplicado then
  begin
    { No _Preparo TODO pacote e um arquivo so - inclusive os .zip, que so
      sao expandidos na aplicacao. }
    Result := TPath.Combine(FstrDirPreparo, LstrNome);
    Exit;
  end;

  { Ja APLICADO: os .zip viraram um conjunto de arquivos soltos na pasta do
    servico, e nao ha um nome unico que responda por eles. Conferir isso
    barato nao da; fica como estava. Para os de arquivo unico - a
    libTefCitel.dll e os tres .ini - o nome no preparo E o nome final. }
  if SameText(ExtractFileExt(LstrNome), '.zip') then
    Exit;

  Result := TPath.Combine(FstrDirServico, LstrNome);
end;

function TTefEstacaoAtualizacao.fHashAplicado(const AstrPacote: String): String;
var
  LstrArquivo: String;
begin
  Result := LowerCase(fLeVersao(TEF_ATU_SECAO_APLICADO, AstrPacote));
  if Result = '' then
    Exit;

  { A ESCRITURACAO NAO E PROVA (campo, 2026-09-20, teste V.15).

    Ate aqui esta funcao apenas lia o TefEstacaoVersao.ini. Apagada a
    libTefCitel.dll da pasta da estacao, o ini seguia dizendo que o pacote
    estava aplicado, o autcom concluia "estacao em dia" e nunca reenviava -
    e o fConfiguraTefCitel voltava a morrer com External exception
    C06D007E, sem saida a nao ser reinstalar.

    Isso e o impasse de bootstrap por outra porta, e contraria a RN51: a
    estacao tem de conseguir se reparar sozinha. E nao e cenario de
    laboratorio - o C.6/C.7 ja registrou antivirus levando o
    TefEstacaoAtualizador.exe; levar esta DLL e a mesma classe de evento,
    junto com gravacao que falhou depois de marcada e perfil/pasta mexidos
    a mao.

    Vazio quer dizer "nunca" em todo o arquivo de versao, entao devolver
    vazio aqui faz o autcom reenviar o pacote na carga seguinte - sem
    protocolo novo e sem nenhum caso especial do outro lado. }
  LstrArquivo := fArquivoQueProva(AstrPacote, True);
  if (LstrArquivo <> '') and (not FileExists(LstrArquivo)) then
  begin
    pLogaEstacaoNivel(TEF_LOG_NIVEL_NORMAL, Format(
      'fHashAplicado: o pacote "%s" consta como aplicado, mas "%s" NAO esta ' +
      'no disco - respondendo vazio para o autcom reenviar. Se isto se repetir, ' +
      'suspeitar de antivirus na pasta da estacao.',
      [AstrPacote, LstrArquivo]));
    Result := '';
  end;
end;

function TTefEstacaoAtualizacao.fHashPreparado(const AstrPacote: String): String;
var
  LstrArquivo: String;
begin
  Result := LowerCase(fLeVersao(TEF_ATU_SECAO_PREPARADO, AstrPacote));
  if Result = '' then
    Exit;

  { Mesmo motivo do fHashAplicado, e aqui vale para TODOS os pacotes: no
    _Preparo cada um e um arquivo so. Um preparo que sumiu antes de ser
    aplicado faria o autcom pular o envio e esperar uma aplicacao que nunca
    vai acontecer. }
  LstrArquivo := fArquivoQueProva(AstrPacote, False);
  if (LstrArquivo <> '') and (not FileExists(LstrArquivo)) then
  begin
    pLogaEstacaoNivel(TEF_LOG_NIVEL_NORMAL, Format(
      'fHashPreparado: o pacote "%s" consta como preparado, mas "%s" NAO esta ' +
      'no disco - respondendo vazio para o autcom reenviar.',
      [AstrPacote, LstrArquivo]));
    Result := '';
  end;
end;

function TTefEstacaoAtualizacao.fDirServicoAplicado: String;
begin
  Result := fLeVersao(TEF_ATU_SECAO_CONTEXTO, TEF_ATU_CHAVE_DIRSERVICO);
end;

procedure TTefEstacaoAtualizacao.pGravaPreparado(
  const AstrPacote, AstrHash: String);
begin
  pGravaVersao(TEF_ATU_SECAO_PREPARADO, AstrPacote, LowerCase(Trim(AstrHash)));
end;

procedure TTefEstacaoAtualizacao.pAbre(const AstrPacote, AstrArquivo,
  AstrHash: String; const AintTamanho: Integer; const AdwPidDono: DWORD;
  out AblnAberto: Boolean; out AstrMotivo: String);
var
  LRecepcao: TTefEstacaoRecepcao;
  LstrNome, LstrParcial, LstrHash: String;
  LdwParado: DWORD;
begin
  AblnAberto := False;
  AstrMotivo := '';
  LstrNome := fNomeNoPreparo(AstrPacote);
  if LstrNome = '' then
    raise ETefEstacaoAtualizacao.CreateFmt(
      'pAtuAbre: pacote desconhecido "%s".', [AstrPacote]);

  LstrHash := LowerCase(Trim(AstrHash));
  if LstrHash = '' then
    raise ETefEstacaoAtualizacao.CreateFmt(
      'pAtuAbre: pacote "%s" chegou sem hash - sem ele nao ha o que conferir ' +
      'no fim, e aplicar as cegas e pior que nao aplicar.', [AstrPacote]);

  if AintTamanho <= 0 then
    raise ETefEstacaoAtualizacao.CreateFmt(
      'pAtuAbre: pacote "%s" chegou com tamanho declarado %d.',
      [AstrPacote, AintTamanho]);

  FcsAcesso.Acquire;
  try
    { ARBITRAGEM ENTRE AUTCOM (achado de campo 2026-09-17, caso B.1).

      O pAtuAbre sempre descartou a recepcao anterior, e isso continua certo
      quando quem reabre e o MESMO autcom - e assim que uma transferencia
      interrompida recomeca, inclusive no fallback do canal rapido para o
      lento. Mas quando quem chega e OUTRO autcom, descartar destroi uma
      transferencia viva: em campo os dois mandaram 9,7 MB, um escreveu na
      recepcao do outro e o hash so bateu porque o conteudo era identico.

      Agora o segundo e recusado e nao transfere. Nao e erro, e o mesmo
      desfecho do "ja esta PREPARADO" que ele ja sabe tratar: a proxima carga
      encontra tudo pronto. Dono que parou de mandar parte ha mais de
      TEF_ATU_RECEPCAO_ABANDONADA_MS perde a vez - senao um autcom que morre
      no meio tranca o pacote para todo mundo ate o servico reiniciar. }
    if FdictRecepcoes.TryGetValue(LowerCase(AstrPacote), LRecepcao) then
    begin
      LdwParado := GetTickCount - LRecepcao.dwTickUltimaParte;
      if (LRecepcao.dwPidDono <> 0) and (LRecepcao.dwPidDono <> AdwPidDono) and
         (LdwParado < TEF_ATU_RECEPCAO_ABANDONADA_MS) then
      begin
        AstrMotivo := Format('o pid=%d esta transferindo este pacote agora ' +
          '(%d parte(s), ultima ha %d ms)',
          [LRecepcao.dwPidDono, LRecepcao.intProximaSeq, LdwParado]);
        pLogaEstacaoNivel(TEF_LOG_NIVEL_NORMAL, Format(
          'pAtuAbre: pacote "%s" RECUSADO para o pid=%d - %s. Ele nao transfere ' +
          'nesta carga; a proxima encontra o pacote pronto.',
          [AstrPacote, AdwPidDono, AstrMotivo]));
        Exit;
      end;
    end;

    pDescarta(AstrPacote);

    if not TDirectory.Exists(FstrDirPreparo) then
      TDirectory.CreateDirectory(FstrDirPreparo);

    LstrParcial := TPath.Combine(FstrDirPreparo, LstrNome + '.parcial');

    LRecepcao := TTefEstacaoRecepcao.Create;
    try
      LRecepcao.strPacote := AstrPacote;
      LRecepcao.strArquivoOrigem := AstrArquivo;
      LRecepcao.strHashEsperado := LstrHash;
      LRecepcao.intTamanhoEsperado := AintTamanho;
      LRecepcao.intProximaSeq := 0;
      LRecepcao.dwPidDono := AdwPidDono;
      LRecepcao.dwTickUltimaParte := GetTickCount;
      LRecepcao.stmDestino := TFileStream.Create(LstrParcial, fmCreate);
    except
      LRecepcao.Free;
      raise;
    end;

    FdictRecepcoes.Add(LowerCase(AstrPacote), LRecepcao);
    AblnAberto := True;
  finally
    FcsAcesso.Release;
  end;

  pLogaEstacaoNivel(TEF_LOG_NIVEL_NORMAL, Format(
    'pAtuAbre: recebendo pacote "%s" (origem "%s", %d bytes, sha256 %s...) ' +
    'em "%s".', [AstrPacote, AstrArquivo, AintTamanho,
    Copy(LstrHash, 1, 12), LstrParcial]));
end;

procedure TTefEstacaoAtualizacao.pParte(const AstrPacote: String;
  const AintSeq: Integer; const AstrBase64: String);
var
  LRecepcao: TTefEstacaoRecepcao;
  LbytParte: TBytes;
begin
  FcsAcesso.Acquire;
  try
    LRecepcao := fRecepcao(AstrPacote);

    { Parte fora de ordem e DEFEITO, nao caso a tratar. O transporte ja
      garante ordem por quadro logico, e aceitar em silencio produziria um
      arquivo embaralhado que so o hash pegaria la no fim - tarde, e sem
      dizer onde foi. }
    if AintSeq <> LRecepcao.intProximaSeq then
      raise ETefEstacaoAtualizacao.CreateFmt(
        'pAtuParte: pacote "%s" recebeu a parte %d esperando a %d.',
        [AstrPacote, AintSeq, LRecepcao.intProximaSeq]);

    LbytParte := TNetEncoding.Base64.DecodeStringToBytes(AstrBase64);
    if Length(LbytParte) > 0 then
      LRecepcao.stmDestino.WriteBuffer(LbytParte[0], Length(LbytParte));

    Inc(LRecepcao.intProximaSeq);
    LRecepcao.dwTickUltimaParte := GetTickCount;

    { Teto pelo tamanho declarado: sem ele, um emissor com defeito encheria
      o disco da estacao parte a parte, e o unico sintoma seria o servico
      morrendo por falta de espaco. }
    if LRecepcao.stmDestino.Size > LRecepcao.intTamanhoEsperado then
      raise ETefEstacaoAtualizacao.CreateFmt(
        'pAtuParte: pacote "%s" ja passou dos %d bytes declarados (esta com ' +
        '%d) - recepcao abortada.',
        [AstrPacote, LRecepcao.intTamanhoEsperado, LRecepcao.stmDestino.Size]);
  finally
    FcsAcesso.Release;
  end;
end;

function TTefEstacaoAtualizacao.fFecha(const AstrPacote: String;
  out AstrErro: String): Boolean;
var
  LRecepcao: TTefEstacaoRecepcao;
  LstrParcial, LstrDestino, LstrHash, LstrEsperado: String;
  LintTamanho, LintEsperado: Int64;
begin
  Result := False;
  AstrErro := '';

  FcsAcesso.Acquire;
  try
    LRecepcao := fRecepcao(AstrPacote);

    LstrParcial := TPath.Combine(FstrDirPreparo,
      fNomeNoPreparo(AstrPacote) + '.parcial');
    LstrDestino := TPath.Combine(FstrDirPreparo, fNomeNoPreparo(AstrPacote));
    LintTamanho := LRecepcao.stmDestino.Size;
    LintEsperado := LRecepcao.intTamanhoEsperado;
    LstrEsperado := LRecepcao.strHashEsperado;

    { Fechar o stream ANTES de ler o arquivo para o hash e antes de renomear:
      ele esta aberto em modo exclusivo por este mesmo processo, e tanto o
      fSha256DeArquivo quanto o TFile.Move falhariam. }
    FreeAndNil(LRecepcao.stmDestino);

    if LintTamanho <> LintEsperado then
      AstrErro := Format('tamanho recebido %d, declarado %d',
        [LintTamanho, LintEsperado])
    else
    begin
      LstrHash := fSha256DeArquivo(LstrParcial);
      if LstrHash <> LstrEsperado then
        AstrErro := Format('sha256 recebido %s, declarado %s',
          [LstrHash, LstrEsperado]);
    end;

    if AstrErro = '' then
    begin
      if TFile.Exists(LstrDestino) then
        TFile.Delete(LstrDestino);
      TFile.Move(LstrParcial, LstrDestino);

      { So depois de o arquivo estar no lugar. Anotar antes deixaria o
        [Preparado] prometendo um pacote que um erro de disco no Move nunca
        entregou - e o autcom, vendo o hash la, nunca mais reenviaria. }
      pGravaPreparado(AstrPacote, LstrEsperado);
      Result := True;
    end
    else if TFile.Exists(LstrParcial) then
      TFile.Delete(LstrParcial);

    FdictRecepcoes.Remove(LowerCase(AstrPacote));
  finally
    FcsAcesso.Release;
  end;

  if Result then
    pLogaEstacaoNivel(TEF_LOG_NIVEL_NORMAL, Format(
      'fAtuFecha: pacote "%s" conferido e PREPARADO (%d bytes, sha256 %s...). ' +
      'Sera aplicado na proxima subida do servico, com a estacao ociosa.',
      [AstrPacote, LintTamanho, Copy(LstrEsperado, 1, 12)]))
  else
    pLogaEstacaoNivel(TEF_LOG_NIVEL_NORMAL, Format(
      'fAtuFecha: pacote "%s" RECUSADO - %s. Nada foi preparado e a estacao ' +
      'segue com o que ja tinha.', [AstrPacote, AstrErro]));
end;

function fTodosOsPacotes: TArray<String>;
begin
  { Ordem de aplicacao: primeiro as DLLs de terceiro, depois a nossa, depois
    o servico, depois os .ini. Nada le nada enquanto o atualizador trabalha -
    o servico esta parado - entao a ordem nao muda o resultado; ela existe
    para o log ficar facil de seguir. A libTefCitel vem antes do servico so
    porque e dependencia dele, e ler o log na ordem da dependencia ajuda. }
  Result := TArray<String>.Create(
    TEF_ATU_PACOTE_SCOPE,
    TEF_ATU_PACOTE_CLISITEF,
    TEF_ATU_PACOTE_LIB,
    TEF_ATU_PACOTE_SERVICO,
    TEF_ATU_PACOTE_SCOPE_INI,
    TEF_ATU_PACOTE_CLISITEF_INI,
    TEF_ATU_PACOTE_CONFITLS_INI);
end;

function fCarimboLocal: String;
var
  LSystemTime: TSystemTime;
begin
  GetLocalTime(LSystemTime);
  Result := Format('%.4d-%.2d-%.2d %.2d:%.2d:%.2d',
    [LSystemTime.wYear, LSystemTime.wMonth, LSystemTime.wDay,
     LSystemTime.wHour, LSystemTime.wMinute, LSystemTime.wSecond]);
end;

procedure TTefEstacaoAtualizacao.pApagaVersao(const AstrSecao, AstrChave: String);
var
  LIni: TMemIniFile;
begin
  FcsAcesso.Acquire;
  try
    if not TFile.Exists(FstrArqVersao) then
      Exit;

    LIni := TMemIniFile.Create(FstrArqVersao, TEncoding.ANSI);
    try
      LIni.DeleteKey(AstrSecao, AstrChave);
      LIni.UpdateFile;
    finally
      LIni.Free;
    end;
  finally
    FcsAcesso.Release;
  end;
end;

function TTefEstacaoAtualizacao.fHashFalhou(const AstrPacote: String): String;
begin
  Result := LowerCase(fLeVersao(TEF_ATU_SECAO_FALHOU, AstrPacote));
end;

function TTefEstacaoAtualizacao.fTemPreparo: Boolean;
var
  LstrPacote: String;
begin
  Result := False;
  for LstrPacote in fTodosOsPacotes do
    if fHashPreparado(LstrPacote) <> '' then
      Exit(True);
end;

procedure TTefEstacaoAtualizacao.pMarcaPendente;
begin
  pGravaVersao(TEF_ATU_SECAO_PENDENTE, TEF_ATU_CHAVE_APLICAR, fCarimboLocal);
end;

function TTefEstacaoAtualizacao.fDisparaAtualizador(out AstrErro: String): Boolean;
const
  { Nao esta declarada em Winapi.Windows nesta versao do Delphi (Seattle).
    Valor da propria API do Windows. }
  CREATE_BREAKAWAY_FROM_JOB = $01000000;
var
  LstrExe, LstrLinha: String;
  LInfo: TStartupInfo;
  LProc: TProcessInformation;
begin
  AstrErro := '';
  LstrExe := FstrDirServico + TEF_ATU_EXE_ATUALIZADOR;

  if not TFile.Exists(LstrExe) then
  begin
    AstrErro := Format('"%s" nao existe em "%s" - a instalacao da estacao ' +
      'esta incompleta e NENHUMA atualizacao vai acontecer nela ate o ' +
      'arquivo ser copiado para la',
      [TEF_ATU_EXE_ATUALIZADOR, ExcludeTrailingPathDelimiter(FstrDirServico)]);
    pLogaEstacaoNivel(TEF_LOG_NIVEL_NORMAL,
      'fDisparaAtualizador: ' + AstrErro + '.');
    Exit(False);
  end;

  FillChar(LInfo, SizeOf(LInfo), 0);
  LInfo.cb := SizeOf(LInfo);
  LInfo.dwFlags := STARTF_USESHOWWINDOW;
  LInfo.wShowWindow := SW_HIDE;
  FillChar(LProc, SizeOf(LProc), 0);

  { Aspas em volta do caminho por causa de espaco; UniqueString porque
    CreateProcessW pode escrever no buffer da linha de comando. }
  LstrLinha := Format('"%s"', [LstrExe]);
  UniqueString(LstrLinha);

  { CREATE_BREAKAWAY_FROM_JOB para o atualizador nao morrer junto se este
    servico estiver num job object - e ele vai ser parado pelo proprio
    atualizador daqui a segundos. Job que nao permite breakaway faz o
    CreateProcess falhar com ERROR_ACCESS_DENIED; nesse caso a segunda
    tentativa sem a flag e o comportamento de sempre, melhor que nao
    lancar nada. }
  Result := CreateProcess(nil, PChar(LstrLinha), nil, nil, False,
    CREATE_NO_WINDOW or DETACHED_PROCESS or CREATE_BREAKAWAY_FROM_JOB,
    nil, PChar(FstrDirServico), LInfo, LProc);

  if not Result then
  begin
    UniqueString(LstrLinha);
    Result := CreateProcess(nil, PChar(LstrLinha), nil, nil, False,
      CREATE_NO_WINDOW or DETACHED_PROCESS, nil, PChar(FstrDirServico),
      LInfo, LProc);
  end;

  if Result then
  begin
    CloseHandle(LProc.hProcess);
    CloseHandle(LProc.hThread);
    pLogaEstacaoNivel(TEF_LOG_NIVEL_NORMAL, Format(
      'fDisparaAtualizador: "%s" lancado destacado. Ele vai parar este ' +
      'servico pelo SCM, aplicar o preparo e subir de novo.',
      [TEF_ATU_EXE_ATUALIZADOR]));
  end
  else
  begin
    { Este e o caso que o suporte precisa achar no log. Sem esta linha o
      sintoma seria apenas "a atualizacao nao acontece", sem nada apontando
      para o antivirus ou para permissao. }
    AstrErro := Format('CreateProcess de "%s" falhou com erro %d',
      [TEF_ATU_EXE_ATUALIZADOR, GetLastError]);
    pLogaEstacaoNivel(TEF_LOG_NIVEL_NORMAL, Format(
      'fDisparaAtualizador: %s. O preparo continua em "%s" e nada foi ' +
      'aplicado - o TEF segue funcionando normalmente. Conferir ANTIVIRUS e ' +
      'permissao de execucao na pasta do servico.',
      [AstrErro, TEF_ATU_DIR_PREPARO]));
  end;
end;

end.
