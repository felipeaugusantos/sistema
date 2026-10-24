unit untTefEstacaoAplicacao;

{ Aplicacao da atualizacao na estacao (Req. 456190, Fase 6, Passo 3).

  Roda dentro do TefEstacaoAtualizador.exe, NUNCA dentro do servico. Esta
  separacao e o ponto inteiro deste projeto - ver o cabecalho de
  untTefEstacaoAtualizacao.pas para a razao completa. Em uma linha: se o
  antivirus barrar o servico, a loja fica sem TEF; se barrar o atualizador,
  so a atualizacao para.

  O QUE ELE FAZ, NESTA ORDEM

    1. Toma um mutex nomeado - dois atualizadores ao mesmo tempo trocariam
       arquivos um por cima do outro.
    2. Para o TefEstacaoService pelo SCM e ESPERA ele parar de verdade.
    3. Com o servico parado, aplica tudo o que esta em _Preparo\ - e so
       agora o proprio TefEstacaoService.exe pode ser trocado, porque
       executavel em uso nao pode ser sobrescrito. O anterior fica em .old.
    4. Sobe o servico e confere que ele ficou RUNNING.
    5. Nao subiu: restaura o .old, sobe de novo e marca o pacote em
       [Falhou], para o autcom nao reenviar o mesmo binario para sempre.

  O QUE ELE NUNCA FAZ

    Decidir SE pode atualizar. Ociosidade - transacao em voo, pendencia de
    confirmacao, despacho dentro da DLL nativa - e decisao do servico, que
    e quem enxerga sessoes e pinpad, e ja foi tomada antes de ele ser
    lancado. O atualizador chega depois da decisao.

  ENCERRAMENTO: sempre 0. Este processo nao tem quem leia o ExitCode, e
  falhar aqui nunca pode parecer com falha do servico. O que conta e o log,
  que e o MESMO arquivo do servico - ele grava ao lado do proprio .exe, e
  os dois vivem na mesma pasta. }

interface

uses
  untTefEstacaoAtualizacao;

{ Executa a atualizacao inteira. Devolve False quando nada foi aplicado. }
function fAplicaAtualizacao(const AstrDirServico: String): Boolean;

{ Aplica o que estiver em _Preparo sobre o diretorio do servico.

  Publico de proposito: e a parte que NAO depende do SCM, e por isso a
  unica que da para exercitar fora de uma estacao de verdade. O chamador
  normal e fAplicaAtualizacao, com o servico ja parado - chamar isto com o
  servico rodando nao faz sentido e vai esbarrar em arquivo em uso. }
procedure pAplicaPacotes(AAtu: TTefEstacaoAtualizacao;
  const AstrDirServico: String; out AblnTrocouExe: Boolean);

implementation

uses
  Winapi.Windows, Winapi.WinSvc, System.SysUtils, System.Types,
  System.IOUtils, System.Zip, untTefCitelAtuComum, untTefEstacaoLog;

const
  { Parar pode levar ate ~10 s so no pParaComSeguranca, que espera despacho
    dentro da DLL nativa, mais o que o SCM levar. 120 s da folga larga.

    Nao viola a regra do topo de IA\rules\tef-dvc.md: nao ha pinpad nisto -
    a ociosidade foi condicao para o servico ter lancado este processo. }
  TEF_APL_TETO_PARAR_MS  = 120000;
  TEF_APL_TETO_SUBIR_MS  = 60000;
  TEF_APL_INTERVALO_MS   = 500;

  { Quanto ainda se espera o PROCESSO sair depois de o SCM dizer STOPPED.
    Em campo foram ~25 ms; 30 s e folga de sobra para qualquer maquina
    carregada. Nao viola a regra do topo de IA\rules\tef-dvc.md pelo mesmo
    motivo dos tetos acima: nao ha pinpad nisto. }
  TEF_APL_TETO_SAIR_MS   = 30000;

  { Retentativa de gravacao. Existe para o caso que o teto acima nao cobre:
    algo FORA do servico segurando o arquivo - antivirus varrendo a pasta,
    Explorer com a pasta aberta, outro autcom em RDP na mesma estacao. 5 x
    300 ms e mais do que qualquer varredura de AV leva num arquivo, e no
    pior caso atrasa a aplicacao em 1,5 s por arquivo travado. }
  TEF_APL_TENTATIVAS_GRAVA = 5;
  TEF_APL_ESPERA_GRAVA_MS  = 300;

  TEF_APL_MUTEX = 'Global\TefEstacaoAtualizador';

procedure pLoga(const AstrMsg: String);
begin
  pLogaEstacaoNivel(TEF_LOG_NIVEL_NORMAL, 'Atualizador: ' + AstrMsg);
end;

{ --- SCM --- }

function fEstadoServico(const AhndSvc: SC_HANDLE): DWORD;
var
  LStatus: TServiceStatus;
begin
  Result := 0;
  if QueryServiceStatus(AhndSvc, LStatus) then
    Result := LStatus.dwCurrentState;
end;

function fEsperaEstado(const AhndSvc: SC_HANDLE; const AdwEstado: DWORD;
  const AdwTetoMs: DWORD): Boolean;
var
  LdwInicio: DWORD;
begin
  LdwInicio := GetTickCount;
  repeat
    if fEstadoServico(AhndSvc) = AdwEstado then
      Exit(True);
    Sleep(TEF_APL_INTERVALO_MS);
  until GetTickCount - LdwInicio > AdwTetoMs;

  Result := fEstadoServico(AhndSvc) = AdwEstado;
end;

{ Handle SYNCHRONIZE do processo do servico, ou 0.

  Aberto ANTES do ControlService de proposito. Depois de parar, o SCM zera
  o dwProcessId e o numero pode ser reciclado pelo Windows para outro
  processo - segurar o handle desde quando o servico ainda esta vivo e o
  que torna a espera imune a isso. }
function fAbreProcessoServico(const AhndSvc: SC_HANDLE): THandle;
var
  LStatus: SERVICE_STATUS_PROCESS;
  LdwPrecisa: DWORD;
begin
  Result := 0;

  if not QueryServiceStatusEx(AhndSvc, SC_STATUS_PROCESS_INFO,
       LPBYTE(@LStatus), SizeOf(LStatus), LdwPrecisa) then
  begin
    pLoga(Format('QueryServiceStatusEx falhou com erro %d - seguindo sem ' +
      'esperar o processo sair.', [GetLastError]));
    Exit;
  end;

  { Sem log este caminho era MUDO, e isso custou uma leitura de log em
    16/09: o "processo do servico saiu" nao apareceu na bateria das 11:38 e
    nao havia como saber, so pelo log, se o atualizador da estacao era o
    antigo ou se era o novo tendo passado por aqui em silencio. Nenhum
    caminho desta funcao pode terminar sem dizer o que decidiu. }
  if LStatus.dwProcessId = 0 then
  begin
    pLoga('QueryServiceStatusEx devolveu dwProcessId=0 com o servico ainda ' +
      'no ar - seguindo sem esperar o processo sair.');
    Exit;
  end;

  Result := OpenProcess(SYNCHRONIZE, False, LStatus.dwProcessId);
  if Result = 0 then
    pLoga(Format('OpenProcess(pid=%d) falhou com erro %d - seguindo sem ' +
      'esperar o processo sair.', [LStatus.dwProcessId, GetLastError]))
  else
    pLoga(Format('handle do processo do servico (pid=%d) em maos antes do ' +
      'STOP - a espera pela saida dele esta armada.', [LStatus.dwProcessId]));
end;

{ Espera o PROCESSO do servico sair, depois de o SCM ja ter dito STOPPED.

  DEFEITO QUE ISTO CONSERTA (campo, 2026-09-16)

  O SCM diz STOPPED quando o servico MUDA DE ESTADO, nao quando o processo
  morre. Entre uma coisa e outra mediram-se ~25 ms em campo, e foi dentro
  dessa fresta que a gravacao de csmsg.dll bateu em "arquivo ja esta sendo
  usado por outro processo": a imagem antiga ainda estava mapeada, com a
  pilha nativa do Scope dentro dela.

  Por que a fresta importa mesmo com o servico "descarregando" a DLL: o
  UnLoadDLLFunctions do untScopeNCR nao devolve as referencias que o
  FunctionDetect toma (residuo conhecido - ver o record.md do 456190), de
  modo que scopeapi.dll e toda a arvore de dependencias dela so saem da
  memoria na saida do processo. Esperar o processo e o unico ponto em que
  isso deixa de ter importancia - e por isso o conserto mora aqui, e nao
  no untScopeNCR.

  Estourar o teto nao aborta: a essa altura o servico ja esta parado e nao
  aplicar deixaria a estacao sem atualizacao nenhuma. O pExtraiZip tenta de
  novo arquivo por arquivo, e o que nao entrar fica registrado no log. }
procedure pEsperaProcessoSair(const AhndProc: THandle);
var
  LdwInicio, LdwRet: DWORD;
begin
  if AhndProc = 0 then
    Exit;

  LdwInicio := GetTickCount;
  LdwRet := WaitForSingleObject(AhndProc, TEF_APL_TETO_SAIR_MS);

  if LdwRet = WAIT_OBJECT_0 then
    pLoga(Format('processo do servico saiu %d ms depois do SCM dizer ' +
      'STOPPED - agora nenhum arquivo dele esta mapeado.',
      [GetTickCount - LdwInicio]))
  else
    pLoga(Format('ATENCAO: o processo do servico NAO saiu em %d ms mesmo ' +
      'com o SCM dizendo STOPPED (WaitForSingleObject devolveu %d). ' +
      'Seguindo com a aplicacao: arquivo que ainda estiver mapeado vai ' +
      'falhar a gravacao e sera registrado nome por nome.',
      [TEF_APL_TETO_SAIR_MS, LdwRet]));
end;

function fParaServico(const AhndSvc: SC_HANDLE): Boolean;
var
  LStatus: TServiceStatus;
  LhndProc: THandle;
begin
  if fEstadoServico(AhndSvc) = SERVICE_STOPPED then
  begin
    pLoga('o servico ja estava parado.');
    Exit(True);
  end;

  LhndProc := fAbreProcessoServico(AhndSvc);
  try
    if not ControlService(AhndSvc, SERVICE_CONTROL_STOP, LStatus) then
    begin
      pLoga(Format('ControlService(STOP) falhou com erro %d - nada sera ' +
        'aplicado e o servico segue como esta.', [GetLastError]));
      Exit(False);
    end;

    Result := fEsperaEstado(AhndSvc, SERVICE_STOPPED, TEF_APL_TETO_PARAR_MS);
    if Result then
    begin
      pLoga('servico parado.');
      pEsperaProcessoSair(LhndProc);
    end
    else
      pLoga(Format('o servico NAO parou em %d ms - nada sera aplicado. ' +
        'Trocar arquivo de um processo que ainda roda e o caminho mais curto ' +
        'para deixar a estacao num estado misturado.', [TEF_APL_TETO_PARAR_MS]));
  finally
    if LhndProc <> 0 then
      CloseHandle(LhndProc);
  end;
end;

function fSobeServico(const AhndSvc: SC_HANDLE): Boolean;
begin
  if not StartService(AhndSvc, 0, PChar(nil^)) then
    if GetLastError <> ERROR_SERVICE_ALREADY_RUNNING then
    begin
      pLoga(Format('StartService falhou com erro %d.', [GetLastError]));
      Exit(False);
    end;

  Result := fEsperaEstado(AhndSvc, SERVICE_RUNNING, TEF_APL_TETO_SUBIR_MS);
end;

{ --- aplicacao dos pacotes --- }

procedure pMoveParaFalhou(const AstrDirServico, AstrArquivo: String);
var
  LstrDir, LstrDestino: String;
begin
  try
    LstrDir := TPath.Combine(AstrDirServico, TEF_ATU_DIR_FALHOU);
    if not TDirectory.Exists(LstrDir) then
      TDirectory.CreateDirectory(LstrDir);

    LstrDestino := TPath.Combine(LstrDir, ExtractFileName(AstrArquivo));
    if TFile.Exists(LstrDestino) then
      TFile.Delete(LstrDestino);
    TFile.Move(AstrArquivo, LstrDestino);
  except
    on E: Exception do
      pLoga(Format('nao consegui mover "%s" para %s (%s) - apagando, para o ' +
        'preparo nao ser reaplicado.',
        [ExtractFileName(AstrArquivo), TEF_ATU_DIR_FALHOU, E.Message]));
  end;

  if TFile.Exists(AstrArquivo) then
    try
      TFile.Delete(AstrArquivo);
    except
      // nada: [Falhou] ja barra o pacote do servico
    end;
end;

{ Grava insistindo. Devolve False so depois de esgotar as tentativas, e ai
  AstrErro traz a ultima falha - e a dela que vale no log, porque e a que
  sobreviveu a todas as esperas. }
function fGravaComRetentativa(const AstrDestino: String;
  const AbytDados: TBytes; const AstrNome: String;
  out AstrErro: String): Boolean;
var
  LintTent: Integer;
begin
  Result := False;
  AstrErro := '';

  for LintTent := 1 to TEF_APL_TENTATIVAS_GRAVA do
    try
      TFile.WriteAllBytes(AstrDestino, AbytDados);
      if LintTent > 1 then
        pLoga(Format('"%s" gravado na tentativa %d - estava travado e ' +
          'soltou.', [AstrNome, LintTent]));
      Exit(True);
    except
      on E: Exception do
      begin
        AstrErro := E.ClassName + ': ' + E.Message;
        if LintTent < TEF_APL_TENTATIVAS_GRAVA then
        begin
          pLoga(Format('"%s" travado na tentativa %d de %d (%s) - de novo ' +
            'em %d ms.', [AstrNome, LintTent, TEF_APL_TENTATIVAS_GRAVA,
            AstrErro, TEF_APL_ESPERA_GRAVA_MS]));
          Sleep(TEF_APL_ESPERA_GRAVA_MS);
        end;
      end;
    end;
end;

procedure pExtraiZip(const AstrZip, AstrDirServico: String;
  out AintFalhas: Integer);
var
  LZip: TZipFile;
  LarrNomes: TArray<String>;
  LstrNome, LstrDestino, LstrErro: String;
  LbytDados: TBytes;
  I: Integer;
begin
  AintFalhas := 0;

  LZip := TZipFile.Create;
  try
    LZip.Open(AstrZip, zmRead);
    LarrNomes := LZip.FileNames;

    for I := 0 to High(LarrNomes) do
    begin
      LstrNome := StringReplace(LarrNomes[I], '/', '\', [rfReplaceAll]);

      { Entrada com caminho e ignorada. O pacote de instalacao da estacao e
        uma pasta UNICA E FLAT (ver install\install-service.ps1), entao
        subpasta nao tem uso legitimo - e aceitar uma abriria, por dentro
        do .zip, a travessia de diretorio que fNomeNoPreparo fechou do lado
        do canal. }
      if Pos('\', LstrNome) > 0 then
      begin
        pLoga(Format('entrada "%s" IGNORADA - o pacote da estacao e uma ' +
          'pasta unica e flat.', [LarrNomes[I]]));
        Continue;
      end;

      if SameText(LstrNome, TEF_ATU_ARQ_VERSAO) then
      begin
        pLoga(Format('entrada "%s" IGNORADA - o arquivo de versao e da ' +
          'estacao, nao do pacote.', [LstrNome]));
        Continue;
      end;

      { O proprio atualizador pode vir dentro do pacote do servico, e e
        assim que ELE se atualiza: quem esta rodando agora e ele, entao o
        arquivo esta em uso e nao pode ser sobrescrito. Fica para a proxima
        rodada, quando quem estiver rodando sera o servico. }
      if SameText(LstrNome, TEF_ATU_EXE_ATUALIZADOR) then
      begin
        pLoga(Format('entrada "%s" ADIADA - e este processo, que esta em ' +
          'uso agora. Sera aplicada na proxima atualizacao.', [LstrNome]));
        Continue;
      end;

      LstrDestino := TPath.Combine(AstrDirServico, LstrNome);

      { Ler do zip nao encosta no destino: se falhar aqui e pacote
        corrompido, nao arquivo travado, e retentar nao mudaria nada. }
      try
        LZip.Read(I, LbytDados);
      except
        on E: Exception do
        begin
          Inc(AintFalhas);
          pLoga(Format('FALHOU ao ler "%s" de dentro do pacote (%s: %s) - ' +
            'seguindo com os outros.', [LstrNome, E.ClassName, E.Message]));
          Continue;
        end;
      end;

      { Arquivo travado, permissao, disco cheio: loga o NOME e continua com
        os outros. Abortar o pacote inteiro por causa de um arquivo deixaria
        a estacao meio-atualizada sem ninguem saber qual metade. }
      if fGravaComRetentativa(LstrDestino, LbytDados, LstrNome, LstrErro) then
        pLoga(Format('"%s" gravado (%d bytes).', [LstrNome, Length(LbytDados)]))
      else
      begin
        Inc(AintFalhas);
        pLoga(Format('FALHOU em "%s" depois de %d tentativas (%s) - ' +
          'seguindo com os outros.',
          [LstrNome, TEF_APL_TENTATIVAS_GRAVA, LstrErro]));
      end;
    end;
  finally
    LZip.Free;
  end;
end;

{ Guarda o exe atual em .old antes de o pacote do servico sobrescreve-lo.
  Com o servico PARADO isto e uma copia comum - nao ha mais a danca de
  renomear executavel em uso que o desenho anterior precisava fazer. }
function fGuardaExeAtual(const AstrDirServico: String): Boolean;
var
  LstrExe, LstrOld: String;
begin
  Result := False;
  LstrExe := TPath.Combine(AstrDirServico, TEF_ATU_EXE_SERVICO);
  if not TFile.Exists(LstrExe) then
    Exit;

  LstrOld := LstrExe + TEF_ATU_SUFIXO_OLD;
  try
    TFile.Copy(LstrExe, LstrOld, True);
    Result := True;
  except
    on E: Exception do
      pLoga(Format('nao consegui guardar o exe atual em "%s" (%s) - a ' +
        'atualizacao segue, mas SEM rede de seguranca para reverter.',
        [ExtractFileName(LstrOld), E.Message]));
  end;
end;

{ Guarda a libTefCitel.dll atual em .old antes de troca-la.

  SEM reversao automatica, e isso e deliberado (decisao do Rafael, 2026-09-17):
  DLL com delay-load nao falha na subida do servico, e sim na PRIMEIRA chamada
  RPC - que acontece depois de este processo ja ter terminado. Nao ha como o
  atualizador detectar. O .old existe para o suporte ter um caminho de volta de
  um comando, nao para prometer uma rede que nao funcionaria.

  Falhar aqui nao impede a troca: e o mesmo criterio do fGuardaExeAtual. }
procedure pGuardaLibAtual(const AstrDirServico: String);
var
  LstrLib, LstrOld: String;
begin
  LstrLib := TPath.Combine(AstrDirServico, TEF_ATU_DLL_LIB);
  if not TFile.Exists(LstrLib) then
    Exit;

  LstrOld := LstrLib + TEF_ATU_SUFIXO_OLD;
  try
    TFile.Copy(LstrLib, LstrOld, True);
  except
    on E: Exception do
      pLoga(Format('nao consegui guardar a "%s" atual em "%s" (%s) - a troca ' +
        'segue, mas SEM copia para o suporte voltar a mao.',
        [TEF_ATU_DLL_LIB, ExtractFileName(LstrOld), E.Message]));
  end;
end;

procedure pAplicaPacotes(AAtu: TTefEstacaoAtualizacao;
  const AstrDirServico: String; out AblnTrocouExe: Boolean);
var
  LstrPacote, LstrArquivo, LstrHash, LstrDestino, LstrErroGrava: String;
  LarrParciais: TStringDynArray;
  LbytConteudo, LbytOriginal: TBytes;
  LintFalhas: Integer;
begin
  AblnTrocouExe := False;

  { .parcial e recepcao ABORTADA, nunca pacote pronto: nao passou por
    conferencia de hash nenhuma. Aplicar um deles seria o unico caminho por
    onde um .zip truncado chegaria ao diretorio do servico. }
  LarrParciais := TDirectory.GetFiles(AAtu.strDirPreparo, '*.parcial');
  for LstrArquivo in LarrParciais do
  begin
    pLoga(Format('"%s" e recepcao abortada (sem conferencia de hash) - ' +
      'APAGADO, nunca aplicado.', [ExtractFileName(LstrArquivo)]));
    try
      TFile.Delete(LstrArquivo);
    except
      // nada: o proximo pAbre sobrescreve
    end;
  end;

  for LstrPacote in fTodosOsPacotes do
  begin
    LstrArquivo := TPath.Combine(AAtu.strDirPreparo, fNomeNoPreparo(LstrPacote));
    if not TFile.Exists(LstrArquivo) then
      Continue;

    LstrHash := AAtu.fHashPreparado(LstrPacote);

    { Pacote ja reprovado nao volta. E o que quebra o laco do binario ruim:
      sem isto ele seria reenviado pelo autcom e reaplicado a cada carga. }
    if (LstrHash <> '') and (LstrHash = AAtu.fHashFalhou(LstrPacote)) then
    begin
      pLoga(Format('pacote "%s" RECUSADO - o mesmo hash ja falhou antes e ' +
        'esta em [Falhou]. So um pacote diferente sera aceito.', [LstrPacote]));
      pMoveParaFalhou(AstrDirServico, LstrArquivo);
      AAtu.pApagaVersao(TEF_ATU_SECAO_PREPARADO, LstrPacote);
      Continue;
    end;

    try
      if SameText(ExtractFileExt(LstrArquivo), '.zip') then
      begin
        if SameText(LstrPacote, TEF_ATU_PACOTE_SERVICO) then
          AblnTrocouExe := fGuardaExeAtual(AstrDirServico);

        pExtraiZip(LstrArquivo, AstrDirServico, LintFalhas);
        if LintFalhas > 0 then
          pLoga(Format('pacote "%s" aplicado com %d arquivo(s) que FALHARAM ' +
            '- ver as linhas acima. O pacote conta como aplicado mesmo ' +
            'assim: o que entrou, entrou.', [LstrPacote, LintFalhas]));
      end
      else if SameText(LstrPacote, TEF_ATU_PACOTE_LIB) then
      begin
        { BINARIO CRU - grava byte a byte, sem interpretar nada.

          Este ramo existe porque ate 17/09 tudo o que nao era .zip caia no
          ramo do .ini abaixo e passava pelo fAjustaCaminhosIni. Para um .ini
          sem chave de caminho isso e inofensivo (volta intacto); para uma DLL
          seria corrupcao silenciosa.

          O servico carrega esta DLL por delay-load e a mantem mapeada ate o
          processo sair - e por isso que o pEsperaProcessoSair, ali em cima,
          e o que torna esta gravacao possivel. Mesmo caso do csmsg.dll. }
        pGuardaLibAtual(AstrDirServico);

        LbytConteudo := TFile.ReadAllBytes(LstrArquivo);
        LstrDestino := TPath.Combine(AstrDirServico, fNomeNoPreparo(LstrPacote));
        if not fGravaComRetentativa(LstrDestino, LbytConteudo,
             fNomeNoPreparo(LstrPacote), LstrErroGrava) then
          raise Exception.CreateFmt('nao consegui gravar "%s" (%s)',
            [fNomeNoPreparo(LstrPacote), LstrErroGrava]);

        pLoga(Format('"%s" gravado (%d bytes) - a anterior ficou em "%s".',
          [fNomeNoPreparo(LstrPacote), Length(LbytConteudo),
           fNomeNoPreparo(LstrPacote) + TEF_ATU_SUFIXO_OLD]));
      end
      else
      begin
        { .ini: o ajuste de caminho e feito AQUI, na estacao, porque e aqui
          que se conhece o diretorio de destino. O que veio pelo canal esta
          intacto, e e do intacto que o hash de origem foi tirado (RN18). }
        LbytOriginal := TFile.ReadAllBytes(LstrArquivo);
        LbytConteudo := fAjustaCaminhosIni(LbytOriginal, LstrPacote, AstrDirServico);
        LstrDestino := TPath.Combine(AstrDirServico, fNomeNoPreparo(LstrPacote));
        TFile.WriteAllBytes(LstrDestino, LbytConteudo);

        { Duas mensagens, e nao uma (achado na bateria CliSiTef de 18/09): o
          CONFITLS.ini nao declara chave de caminho nenhuma e o
          fAjustaCaminhosIni devolve o conteudo INTACTO - mas o log dizia
          "gravado com os caminhos apontando para C:\TEF_Citel", prometendo
          uma reescrita que nao aconteceu. Quem fosse diagnosticar um .ini
          errado iria procurar no lugar errado. A comparacao e byte a byte:
          barata, e diz o que de fato foi feito. }
        if (Length(LbytConteudo) <> Length(LbytOriginal)) or
           ((Length(LbytConteudo) > 0) and
            (not CompareMem(@LbytConteudo[0], @LbytOriginal[0], Length(LbytConteudo)))) then
          pLoga(Format('"%s" gravado com os caminhos reescritos para "%s".',
            [fNomeNoPreparo(LstrPacote),
             ExcludeTrailingPathDelimiter(AstrDirServico)]))
        else
          pLoga(Format('"%s" gravado SEM ajuste - o arquivo nao declara chave ' +
            'de caminho, entao foi gravado exatamente como veio.',
            [fNomeNoPreparo(LstrPacote)]));
      end;

      if LstrHash <> '' then
        AAtu.pGravaVersao(TEF_ATU_SECAO_APLICADO, LstrPacote, LstrHash);
      AAtu.pApagaVersao(TEF_ATU_SECAO_PREPARADO, LstrPacote);

      { Pacote novo que entrou limpa a marca de reprovado: o defeito era do
        anterior. }
      AAtu.pApagaVersao(TEF_ATU_SECAO_FALHOU, LstrPacote);

      if TFile.Exists(LstrArquivo) then
        TFile.Delete(LstrArquivo);
    except
      on E: Exception do
      begin
        pLoga(Format('pacote "%s" FALHOU (%s: %s) - movido para "%s". Os ' +
          'outros seguem.', [LstrPacote, E.ClassName, E.Message,
          TEF_ATU_DIR_FALHOU]));
        pMoveParaFalhou(AstrDirServico, LstrArquivo);
        AAtu.pApagaVersao(TEF_ATU_SECAO_PREPARADO, LstrPacote);
      end;
    end;
  end;
end;

{ Desfaz a troca do exe quando o servico novo nao sobe. }
procedure pReverteExe(AAtu: TTefEstacaoAtualizacao; const AstrDirServico: String);
var
  LstrExe, LstrOld, LstrHash: String;
begin
  LstrExe := TPath.Combine(AstrDirServico, TEF_ATU_EXE_SERVICO);
  LstrOld := LstrExe + TEF_ATU_SUFIXO_OLD;

  LstrHash := AAtu.fLeVersao(TEF_ATU_SECAO_APLICADO, TEF_ATU_PACOTE_SERVICO);
  if LstrHash <> '' then
  begin
    AAtu.pGravaVersao(TEF_ATU_SECAO_FALHOU, TEF_ATU_PACOTE_SERVICO, LstrHash);
    AAtu.pApagaVersao(TEF_ATU_SECAO_APLICADO, TEF_ATU_PACOTE_SERVICO);
    pLoga(Format('pacote de servico (sha256 %s) marcado em [Falhou] - NAO ' +
      'sera tentado de novo, so um pacote diferente sera aceito.',
      [Copy(LstrHash, 1, 12)]));
  end;

  if not TFile.Exists(LstrOld) then
  begin
    pLoga('ATENCAO: nao ha "' + ExtractFileName(LstrOld) + '" para restaurar. ' +
      'O servico pode ficar fora do ar ate alguem reinstalar a estacao.');
    Exit;
  end;

  try
    TFile.Copy(LstrOld, LstrExe, True);
    pLoga('exe anterior RESTAURADO a partir de "' + ExtractFileName(LstrOld) + '".');
  except
    on E: Exception do
      pLoga('FALHOU ao restaurar o exe anterior (' + E.Message +
        '). A estacao precisa de atendimento.');
  end;
end;

function fAplicaAtualizacao(const AstrDirServico: String): Boolean;
var
  LhndScm, LhndSvc: SC_HANDLE;
  LAtu: TTefEstacaoAtualizacao;
  LblnTrocouExe, LblnSubiu: Boolean;
  LstrExe, LstrOld: String;
begin
  Result := False;

  LhndScm := OpenSCManager(nil, nil, SC_MANAGER_CONNECT);
  if LhndScm = 0 then
  begin
    pLoga(Format('OpenSCManager falhou com erro %d - sem acesso ao SCM nao ' +
      'ha como parar o servico, e nada sera aplicado.', [GetLastError]));
    Exit;
  end;

  try
    LhndSvc := OpenService(LhndScm, PChar(TEF_ATU_SERVICO_NOME),
      SERVICE_START or SERVICE_STOP or SERVICE_QUERY_STATUS);
    if LhndSvc = 0 then
    begin
      pLoga(Format('OpenService("%s") falhou com erro %d.',
        [TEF_ATU_SERVICO_NOME, GetLastError]));
      Exit;
    end;

    try
      if not fParaServico(LhndSvc) then
        Exit;

      LAtu := TTefEstacaoAtualizacao.Create(AstrDirServico);
      try
        pAplicaPacotes(LAtu, AstrDirServico, LblnTrocouExe);

        LAtu.pGravaVersao(TEF_ATU_SECAO_CONTEXTO, TEF_ATU_CHAVE_DIRSERVICO,
          ExcludeTrailingPathDelimiter(AstrDirServico));
        LAtu.pGravaVersao(TEF_ATU_SECAO_CONTEXTO, TEF_ATU_CHAVE_DATAULTIMA,
          fCarimboLocal);
        LAtu.pApagaVersao(TEF_ATU_SECAO_PENDENTE, TEF_ATU_CHAVE_APLICAR);

        LblnSubiu := fSobeServico(LhndSvc);

        if (not LblnSubiu) and LblnTrocouExe then
        begin
          pLoga(Format('o servico NAO subiu em %d ms depois da troca do exe ' +
            '- REVERTENDO.', [TEF_APL_TETO_SUBIR_MS]));
          pReverteExe(LAtu, AstrDirServico);
          LblnSubiu := fSobeServico(LhndSvc);
          if LblnSubiu then
            pLoga('servico de volta no ar com a versao ANTERIOR.')
          else
            pLoga('ATENCAO: o servico nao subiu nem com a versao anterior. ' +
              'A estacao esta SEM TEF e precisa de atendimento.');
        end
        else if not LblnSubiu then
          pLoga('ATENCAO: o servico nao subiu, e nao houve troca de exe para ' +
            'reverter. A estacao esta SEM TEF e precisa de atendimento.')
        else
        begin
          { Subiu com a versao nova: o .old ja nao serve para nada. }
          LstrExe := TPath.Combine(AstrDirServico, TEF_ATU_EXE_SERVICO);
          LstrOld := LstrExe + TEF_ATU_SUFIXO_OLD;
          if TFile.Exists(LstrOld) then
            try
              TFile.Delete(LstrOld);
            except
              // nada: so ocupa disco
            end;
          pLoga('servico de volta no ar com a versao NOVA.');
        end;

        Result := LblnSubiu;
      finally
        LAtu.Free;
      end;
    finally
      CloseServiceHandle(LhndSvc);
    end;
  finally
    CloseServiceHandle(LhndScm);
  end;
end;

end.
