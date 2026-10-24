program TefEstacaoAtualizador;

{ Atualizador da estacao (Req. 456190, Fase 6).

  Executavel a parte, de proposito. A razao completa esta no cabecalho de
  untTefEstacaoAtualizacao.pas; em uma linha: concentra aqui o
  comportamento que antivirus olha torto - trocar o executavel de um
  servico, extrair .zip por cima de um diretorio de programa, parar e subir
  servico pelo SCM - para que o TefEstacaoService.exe, que e processo
  vital, nao carregue nada disso.

  Nao tem ShareMem: nao exporta nada e nao troca string com DLL nenhuma.
  Nao tem VCL: roda sem janela, sem sessao e sem interacao.

  E lancado pelo proprio servico (TTefEstacaoAtualizacao.fDisparaAtualizador),
  ja depois de o servico ter decidido que a estacao esta ociosa. Nao ha
  parametro nenhum: ele atua sempre no diretorio onde esta, que e o mesmo
  do servico - o pacote de instalacao da estacao e uma pasta unica e flat. }

{$APPTYPE CONSOLE}

uses
  Winapi.Windows,
  System.SysUtils,
  untTefEstacaoAplicacao in 'untTefEstacaoAplicacao.pas',
  untTefEstacaoAtualizacao in '..\untTefEstacaoAtualizacao.pas',
  untTefEstacaoLog in '..\untTefEstacaoLog.pas',
  untTefCitelAtuComum in '..\..\untTefCitelAtuComum.pas';

const
  { Dois atualizadores ao mesmo tempo trocariam arquivos um por cima do
    outro. Nao deveria acontecer - o servico so lanca um - mas "nao deveria"
    nao e garantia, e o custo de garantir e uma linha. Global\ para valer
    entre sessoes: o servico roda na sessao 0. }
  MUTEX_ATUALIZADOR = 'Global\TefEstacaoAtualizador_456190';

var
  GhndMutex: THandle;

begin
  { Nada aqui pode levantar excecao para fora: este processo nao tem quem
    leia o ExitCode e nao tem tela. O que conta e o log, que e o MESMO
    arquivo do servico - untTefEstacaoLog grava ao lado do proprio .exe, e
    os dois vivem na mesma pasta. }
  try
    GhndMutex := CreateMutex(nil, True, MUTEX_ATUALIZADOR);
    if (GhndMutex = 0) or (GetLastError = ERROR_ALREADY_EXISTS) then
    begin
      pLogaEstacaoNivel(TEF_LOG_NIVEL_NORMAL,
        'Atualizador: ja ha outro atualizador em execucao - saindo sem ' +
        'fazer nada.');
      Exit;
    end;

    try
      pLogaEstacaoNivel(TEF_LOG_NIVEL_NORMAL,
        'Atualizador: iniciado em "' + ExtractFilePath(ParamStr(0)) + '".');

      if fAplicaAtualizacao(ExtractFilePath(ParamStr(0))) then
        pLogaEstacaoNivel(TEF_LOG_NIVEL_NORMAL,
          'Atualizador: concluido - servico no ar.')
      else
        pLogaEstacaoNivel(TEF_LOG_NIVEL_NORMAL,
          'Atualizador: concluido SEM sucesso - ver as linhas acima.');
    finally
      ReleaseMutex(GhndMutex);
      CloseHandle(GhndMutex);
    end;
  except
    on E: Exception do
      try
        pLogaEstacaoNivel(TEF_LOG_NIVEL_NORMAL, Format(
          'Atualizador: excecao nao tratada (%s: %s). Nada garantido foi ' +
          'aplicado; conferir o estado do servico.', [E.ClassName, E.Message]));
      except
        // nem o log pode fazer este processo morrer sujo
      end;
  end;
end.
