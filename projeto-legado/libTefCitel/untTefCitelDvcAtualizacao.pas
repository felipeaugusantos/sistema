unit untTefCitelDvcAtualizacao;

{ Lado AUTCOM da atualizacao de arquivos da estacao (Req. 456190, Fase 6).
  Contrato em IA\specs\456190\specs.md secao 11; plano em plans.md secao 11.

  Roda dentro da libTefCitel.dll, no processo do autcom.exe, no SERVIDOR.
  Descobre os pacotes no disco daqui, calcula o SHA-256, pergunta a estacao
  o que ela ja tem e manda pelo canal DVC o que divergir. Nao aplica nada -
  aplicar e do TefEstacaoAtualizador.exe, la na estacao.

  ONDE ISSO E CHAMADO: uma vez, na carga do autcom, de dentro do
  pIniciaTefCitel (untTefCitelUtil.pas), ANTES do fConfiguraTefCitel. Vir
  antes do login e requisito, nao detalhe: estacao com DLL quebrada precisa
  poder ser consertada pela propria atualizacao, e nao ficar presa num
  login que falha por causa do arquivo que a atualizacao traria.

  O QUE ELE NUNCA FAZ: derrubar a carga do autcom. Todo desfecho ruim vira
  um retorno que o chamador registra e segue (RN23). A unica excecao e o
  servico nao voltar depois do reinicio, e mesmo ai quem decide desabilitar
  o TEF e o chamador, pelo mesmo caminho que ele ja usa para as outras
  causas. }

interface

uses
  System.SysUtils, System.JSON, untInterfaceTefCitel;

type
  { Espelhado em untTefCitelUtil.pas. As duas declaracoes precisam ser
    IDENTICAS, stdcall inclusive - diferenca de convencao de chamada aqui e
    corrupcao de pilha, nao erro de compilacao.

    AintTotal = 0 significa etapa sem progresso mensuravel (consulta,
    espera pelo servico voltar); o chamador mostra so o texto. }
  TprocProgressoAtualizacaoTef = procedure(const AstrEtapa: String;
    const AintFeito, AintTotal: Integer); stdcall;

const
  { Retornos. Integer em vez de excecao de proposito: isto atravessa a
    fronteira da DLL, e excecao cruzando fronteira de modulo e onde este
    requisito ja se queimou uma vez (o export novo com DLL antiga). }
  TEF_ATU_RET_NADA_A_FAZER = 0;  { nada divergiu - nem tela aparece        }
  TEF_ATU_RET_APLICADO     = 1;  { aplicado, servico reiniciou e voltou    }
  TEF_ATU_RET_ADIADO       = 2;  { transferido; estacao ocupada            }
  TEF_ATU_RET_FALHA        = -1; { falhou; chamador loga e SEGUE a carga   }
  TEF_ATU_RET_SEM_VOLTA    = -2; { servico nao voltou; chamador desabilita }

{ Registra em quem mostrar o progresso. nil desliga - a atualizacao
  continua acontecendo, so fica silenciosa. }
procedure pSetProgressoAtualizacao(AProc: TprocProgressoAtualizacaoTef);

{ AstrDirIniTerminal e o retorno de fDiretorioPorTerminal do lado autcom:
  vazio quando CFG_PTTFCT esta em branco, quando CFG_TEFCIT = 'T', ou
  quando a subpasta do terminal nao existe. Vazio faz cair para
  AstrDirAutcom, que e exatamente a cascata do RF33 - a funcao de la ja
  resolve os tres casos, e reproduzi-la aqui seria criar uma segunda regra
  para a mesma decisao. }

{ So a DESCOBERTA: o que esta maquina mandaria, e de onde tirou cada coisa.
  Uma linha por pacote, no formato "pacote|caminho de origem|sha256|bytes".

  Publico por duas razoes. E a parte que nao depende do canal, e por isso a
  unica exercitavel sem uma estacao de verdade. E "de onde veio este .ini?"
  e pergunta de suporte - com CFG_PTTFCT preenchida a resposta depende da
  cascata do RF33, e adivinhar custa mais que perguntar ao proprio codigo. }
function fDescreveOrigens(const AstrDirAutcom, AstrOpcaoTefCit,
  AstrDirIniTerminal: String): TArray<String>;
function fAtualizaEstacaoTef(ATef: ITefCitel; const AstrDirAutcom,
  AstrOpcaoTefCit, AstrDirIniTerminal: String;
  out AstrMensagem: String): Integer;

implementation

uses
  Winapi.Windows, System.Classes, System.StrUtils, System.IOUtils,
  System.NetEncoding, untTefCitelAtuComum, untTefCitelDvc,
  untTefCitelDvcTransporte, untTefCitelDvcUpdateTransporte;

{ Copias locais dos tres acessores de JSON.

  Os de untTefCitelDvc.pas sao da secao de implementacao dela e nao
  atravessam a fronteira da unit; os do lado estacao vivem em outro
  projeto. Sao dez linhas cada, e tirar qualquer um dos dois de onde esta
  para compartilhar aqui mexeria em codigo ja validado em campo por uma
  razao que nao justifica. }
function fJsonStr(AObj: TJSONObject; const AName: String): String;
var
  LValor: TJSONValue;
begin
  Result := '';
  if not Assigned(AObj) then
    Exit;
  LValor := AObj.GetValue(AName);
  if Assigned(LValor) and (not (LValor is TJSONNull)) then
    Result := LValor.Value;
end;

function fJsonBool(AObj: TJSONObject; const AName: String;
  const AblnDefault: Boolean): Boolean;
var
  LValor: TJSONValue;
begin
  Result := AblnDefault;
  if not Assigned(AObj) then
    Exit;
  LValor := AObj.GetValue(AName);
  if Assigned(LValor) and (LValor is TJSONBool) then
    Result := TJSONBool(LValor).AsBoolean;
end;

function fJsonObj(AObj: TJSONObject; const AName: String): TJSONObject;
var
  LValor: TJSONValue;
begin
  Result := nil;
  if not Assigned(AObj) then
    Exit;
  LValor := AObj.GetValue(AName);
  if Assigned(LValor) and (LValor is TJSONObject) then
    Result := TJSONObject(LValor);
end;

type
  TdtoPacoteLocal = record
    strPacote: String;
    strCaminho: String;
    strHash: String;
    intTamanho: Integer;
  end;
  TArrPacoteLocal = TArray<TdtoPacoteLocal>;

var
  GprocProgresso: TprocProgressoAtualizacaoTef = nil;

procedure pSetProgressoAtualizacao(AProc: TprocProgressoAtualizacaoTef);
begin
  GprocProgresso := AProc;
end;

procedure pProgresso(const AstrEtapa: String; const AintFeito: Integer = 0;
  const AintTotal: Integer = 0);
begin
  if Assigned(GprocProgresso) then
    try
      GprocProgresso(AstrEtapa, AintFeito, AintTotal);
    except
      { O host que mostra a tela nao pode derrubar a atualizacao. Se a tela
        dele quebrar, a transferencia segue calada. }
      on E: Exception do
        pLogaDiagnosticoDvc('pProgresso: o callback do host levantou ' +
          E.ClassName + ': ' + E.Message + '. Seguindo sem progresso.');
    end;
end;

function fTamanhoArquivo(const AstrArquivo: String): Int64;
var
  LStream: TFileStream;
begin
  LStream := TFileStream.Create(AstrArquivo, fmOpenRead or fmShareDenyNone);
  try
    Result := LStream.Size;
  finally
    LStream.Free;
  end;
end;

procedure pAdicionaSeExiste(var AarrPacotes: TArrPacoteLocal;
  const AstrPacote, AstrCaminho: String);
var
  LintQtd: Integer;
  LintTamanho: Int64;
begin
  if not TFile.Exists(AstrCaminho) then
    Exit;

  LintTamanho := fTamanhoArquivo(AstrCaminho);
  if LintTamanho <= 0 then
  begin
    pLogaDiagnosticoDvc(Format(
      'Atualizacao: "%s" existe mas esta VAZIO - ignorado. Conferir o ' +
      'arquivo de origem.', [AstrCaminho]));
    Exit;
  end;

  LintQtd := Length(AarrPacotes) + 1;
  SetLength(AarrPacotes, LintQtd);
  AarrPacotes[LintQtd - 1].strPacote := AstrPacote;
  AarrPacotes[LintQtd - 1].strCaminho := AstrCaminho;
  AarrPacotes[LintQtd - 1].intTamanho := LintTamanho;
  AarrPacotes[LintQtd - 1].strHash := fSha256DeArquivo(AstrCaminho);
end;

{ Origem dos .ini, pela cascata do RF33. Devolve o caminho completo do
  arquivo, ou vazio se ele nao existir em lugar nenhum. }
function fOrigemIni(const AstrDirAutcom, AstrDirIniTerminal,
  AstrNomeArquivo: String): String;
begin
  if AstrDirIniTerminal <> '' then
  begin
    Result := TPath.Combine(AstrDirIniTerminal, AstrNomeArquivo);
    if TFile.Exists(Result) then
    begin
      pLogaDiagnosticoDvc(Format('Atualizacao: "%s" veio da pasta do ' +
        'terminal ("%s").', [AstrNomeArquivo, AstrDirIniTerminal]));
      Exit;
    end;
  end;

  Result := TPath.Combine(AstrDirAutcom, AstrNomeArquivo);
  if not TFile.Exists(Result) then
    Exit('');

  if AstrDirIniTerminal <> '' then
    { RF33: a subpasta do terminal existe mas nao tem este arquivo. Cair
      para a raiz e o comportamento pedido, e registrar DE ONDE veio e o
      que evita a duvida na hora de diagnosticar. }
    pLogaDiagnosticoDvc(Format('Atualizacao: "%s" NAO estava na pasta do ' +
      'terminal - caiu para a pasta do autcom.exe ("%s").',
      [AstrNomeArquivo, AstrDirAutcom]));
end;

function fDescobrePacotes(const AstrDirAutcom, AstrOpcaoTefCit,
  AstrDirIniTerminal: String): TArrPacoteLocal;
var
  LstrOrigem: String;
begin
  SetLength(Result, 0);

  { Os .zip vao os que existirem, sem olhar CFG_TEFCIT. Custa a
    transferencia de um pacote que talvez nao seja usado, mas so uma vez, e
    cobre a loja que troca de adquirente sem ninguem lembrar de mexer na
    estacao. }
  pAdicionaSeExiste(Result, TEF_ATU_PACOTE_SCOPE,
    TPath.Combine(AstrDirAutcom, TEF_ATU_ZIP_SCOPE));
  pAdicionaSeExiste(Result, TEF_ATU_PACOTE_CLISITEF,
    TPath.Combine(AstrDirAutcom, TEF_ATU_ZIP_CLISITEF));
  pAdicionaSeExiste(Result, TEF_ATU_PACOTE_SERVICO,
    TPath.Combine(AstrDirAutcom, TEF_ATU_ZIP_SERVICO));

  { A libTefCitel.dll que vai para a estacao e A MESMA que este autcom esta
    rodando agora - ela sai do diretorio do autcom.exe, nao de um pacote
    montado a parte.

    Nao e conveniencia: servidor e estacao conversam pelos exports desta DLL,
    e manda-la de outra origem abriria a porta para a estacao rodar uma versao
    que ninguem testou contra este autcom. Vindo daqui, se o servidor foi
    atualizado a estacao acompanha na carga seguinte, e o hash cuida do resto.

    O arquivo esta ABERTO por este proprio processo (delay-load), e por isso a
    leitura usa fmShareDenyWrite la no fEnviaPacote - abrir para leitura um
    modulo carregado e permitido. }
  pAdicionaSeExiste(Result, TEF_ATU_PACOTE_LIB,
    TPath.Combine(AstrDirAutcom, TEF_ATU_DLL_LIB));

  { Os .ini, ao contrario, dependem do CFG_TEFCIT: os caminhos de origem
    sao diferentes e nao faz sentido mandar o .ini de uma pilha que a loja
    nao usa. }
  if AstrOpcaoTefCit = OPCAO_NCR then
  begin
    { 'T' - Scope. O scope.ini fica SEMPRE na pasta do autcom.exe. }
    pAdicionaSeExiste(Result, TEF_ATU_PACOTE_SCOPE_INI,
      TPath.Combine(AstrDirAutcom, TEF_ATU_INI_SCOPE));
  end
  else if AstrOpcaoTefCit = OPCAO_CLISITEF then
  begin
    LstrOrigem := fOrigemIni(AstrDirAutcom, AstrDirIniTerminal,
      TEF_ATU_INI_CLISITEF);
    if LstrOrigem <> '' then
      pAdicionaSeExiste(Result, TEF_ATU_PACOTE_CLISITEF_INI, LstrOrigem);

    LstrOrigem := fOrigemIni(AstrDirAutcom, AstrDirIniTerminal,
      TEF_ATU_INI_CONFITLS);
    if LstrOrigem <> '' then
      pAdicionaSeExiste(Result, TEF_ATU_PACOTE_CONFITLS_INI, LstrOrigem);
  end;
end;

function fEhPacoteIni(const AstrPacote: String): Boolean;
begin
  Result := SameText(AstrPacote, TEF_ATU_PACOTE_SCOPE_INI) or
            SameText(AstrPacote, TEF_ATU_PACOTE_CLISITEF_INI) or
            SameText(AstrPacote, TEF_ATU_PACOTE_CONFITLS_INI);
end;

{ Rotulo legivel do pacote, SO para a tela de carga (Req. 456190, revisao de
  textos de 2026-09-18).

  O nome do pacote e chave de protocolo - e o valor do campo "pacote" no RPC,
  a chave no arquivo de versao da estacao e o que aparece no log. Nao serve
  para o operador ler: "Enviando servico (3 de 7)..." nao diz nada a ele.
  Por isso a traducao vive AQUI e nao no nome do pacote, e o log continua
  com o nome cru - e por ele que se procura nos dois lados do canal.

  O "else" devolve o proprio nome de proposito: um pacote novo que entre no
  conjunto sem passar por aqui aparece como antes, nunca em branco. }
function fRotuloPacote(const AstrPacote: String): String;
begin
  if SameText(AstrPacote, TEF_ATU_PACOTE_SCOPE) then
    Result := 'o Scope'
  else if SameText(AstrPacote, TEF_ATU_PACOTE_CLISITEF) then
    Result := 'o CliSiTef'
  else if SameText(AstrPacote, TEF_ATU_PACOTE_SERVICO) then
    Result := 'o serviço do TEF'
  else if SameText(AstrPacote, TEF_ATU_PACOTE_LIB) then
    Result := 'a biblioteca do TEF'
  else if SameText(AstrPacote, TEF_ATU_PACOTE_SCOPE_INI) then
    Result := 'a configuração do Scope'
  else if SameText(AstrPacote, TEF_ATU_PACOTE_CLISITEF_INI) then
    Result := 'a configuração do CliSiTef'
  else if SameText(AstrPacote, TEF_ATU_PACOTE_CONFITLS_INI) then
    Result := 'a configuração de segurança'
  else
    Result := AstrPacote;
end;

{ Abre a recepcao do pacote na estacao. Chamada DUAS vezes quando o caminho
  rapido falha no meio: um pAtuAbre novo faz a estacao DESCARTAR a recepcao
  anterior (ela ja registra "Recepcao anterior do pacote ... DESCARTADA"), e
  e assim que o caminho lento recomeca do zero sem herdar bytes meio
  gravados. }
{ Devolve False quando a estacao RECUSOU porque outro autcom ja esta
  transferindo este pacote (achado de campo 2026-09-17, caso B.1). Nao e
  erro: este autcom simplesmente nao transfere nesta carga.

  Default True no "aberto": estacao anterior a esta correcao nao manda o
  campo, e ali o comportamento correto e o de sempre - abrir e transferir. }
function fAbrePacote(ATef: TTefCitelDvc; const APacote: TdtoPacoteLocal;
  out AstrMotivo: String): Boolean;
var
  LDados, LResp: TJSONObject;
begin
  AstrMotivo := '';

  LDados := TJSONObject.Create;
  LDados.AddPair('pacote', APacote.strPacote);
  LDados.AddPair('arquivo', ExtractFileName(APacote.strCaminho));
  LDados.AddPair('hash', APacote.strHash);
  LDados.AddPair('tamanho', TJSONNumber.Create(APacote.intTamanho));
  LDados.AddPair('pid', TJSONNumber.Create(Integer(GetCurrentProcessId)));

  LResp := ATef.fChamaRpcAtualizacao('pAtuAbre', LDados);
  try
    Result := fJsonBool(LResp, 'aberto', True);
    if not Result then
      AstrMotivo := fJsonStr(LResp, 'motivo');
  finally
    LResp.Free;
  end;
end;

{ Caminho LENTO - o que roda em producao desde a Fase 6, inalterado. Partes
  de TEF_ATU_TAMANHO_PARTE por pAtuParte, no canal da transacao, fragmentadas
  em 1400 bytes com ACK por fragmento. Continua sendo o fallback do RF45 e
  precisa seguir funcionando sozinho: estacao sem a TefCitelDvcUpdate.dll
  passa por aqui. }
procedure pEnviaPartesLento(ATef: TTefCitelDvc; const APacote: TdtoPacoteLocal;
  const AintIndice, AintTotalPacotes: Integer);
var
  LDados: TJSONObject;
  LStream: TFileStream;
  LbytParte: TBytes;
  LintSeq, LintLidos: Integer;
  LintEnviado: Int64;
begin
  LintSeq := 0;
  LintEnviado := 0;
  SetLength(LbytParte, TEF_ATU_TAMANHO_PARTE);

  { fmShareDenyNone, e nao DenyWrite: desde que a propria libTefCitel.dll virou
    pacote (2026-09-17), um dos arquivos lidos aqui esta CARREGADO neste mesmo
    processo por delay-load. Deny-write funciona na maioria dos casos com
    modulo carregado, mas nao ha por que apostar nisso - e o fTamanhoArquivo,
    nesta mesma unit, ja le estes mesmos arquivos com DenyNone.

    O que DenyNone abre mao (alguem escrever durante a leitura) ja e coberto:
    o sha256 foi tirado do arquivo e e conferido pelo fAtuFecha do outro lado,
    entao arquivo que mudar no meio e recusado la, nao aplicado errado. }
  LStream := TFileStream.Create(APacote.strCaminho, fmOpenRead or fmShareDenyNone);
  try
    repeat
      LintLidos := LStream.Read(LbytParte[0], TEF_ATU_TAMANHO_PARTE);
      if LintLidos <= 0 then
        Break;

      LDados := TJSONObject.Create;
      LDados.AddPair('pacote', APacote.strPacote);
      LDados.AddPair('seq', TJSONNumber.Create(LintSeq));
      LDados.AddPair('conteudoBase64',
        TNetEncoding.Base64.EncodeBytesToString(LbytParte, LintLidos));
      ATef.fChamaRpcAtualizacao('pAtuParte', LDados).Free;

      Inc(LintSeq);
      Inc(LintEnviado, LintLidos);

      pProgresso(Format('Enviando %s (%d de %d)...',
        [fRotuloPacote(APacote.strPacote), AintIndice, AintTotalPacotes]),
        LintEnviado, APacote.intTamanho);
    until LintLidos < TEF_ATU_TAMANHO_PARTE;
  finally
    LStream.Free;
  end;
end;

{ Caminho RAPIDO (Fase 6.1) - blocos grandes pelo canal DVC dedicado.

  Devolve False quando o canal nao abriu OU quando um bloco foi recusado no
  meio. Nos dois casos AstrMotivo explica, e quem chama recomeca pelo lento -
  nao ha tentativa de emendar. Emendar exigiria saber exatamente quantos
  bytes chegaram do outro lado, e a estacao ja sabe descartar e recomecar;
  a 7 s por pacote, refazer inteiro custa menos que acertar essa conta.

  O canal e fechado SEMPRE, inclusive no caminho de excecao: ele so existe
  durante a transferencia (RN35). }
function fEnviaPartesRapido(ATef: TTefCitelDvc; const APacote: TdtoPacoteLocal;
  const AintIndice, AintTotalPacotes: Integer; out AstrMotivo: String;
  out AintBlocosEnviados: Integer): Boolean;
var
  LobjCanal: TTefCitelDvcUpdateTransporte;
  LStream: TFileStream;
  LbytBloco: TBytes;
  LintSeq, LintLidos, LintBlocos: Integer;
  LintEnviado: Int64;
  LdwInicio: DWORD;
begin
  Result := False;
  AstrMotivo := '';
  AintBlocosEnviados := 0;

  LobjCanal := TTefCitelDvcUpdateTransporte.Create;
  try
    if not LobjCanal.fAbre(AstrMotivo) then
      Exit;

    LdwInicio := GetTickCount;
    LintSeq := 0;
    LintBlocos := 0;
    LintEnviado := 0;
    SetLength(LbytBloco, TEF_ATU_TAMANHO_BLOCO_RAPIDO);

    { DenyNone pelo mesmo motivo do caminho lento - ver o comentario la. }
    LStream := TFileStream.Create(APacote.strCaminho, fmOpenRead or fmShareDenyNone);
    try
      repeat
        LintLidos := LStream.Read(LbytBloco[0], TEF_ATU_TAMANHO_BLOCO_RAPIDO);
        if LintLidos <= 0 then
          Break;

        { Mesmo seq sequencial a partir de 0 do caminho lento: a guarda de
          ordem do pParte, na estacao, e a mesma para os dois caminhos. }
        if not LobjCanal.fEnviaBloco(APacote.strPacote, LintSeq,
             TNetEncoding.Base64.EncodeBytesToString(LbytBloco, LintLidos),
             AstrMotivo) then
        begin
          AstrMotivo := Format('bloco %d recusado - %s', [LintSeq, AstrMotivo]);
          Exit;
        end;

        Inc(LintSeq);
        Inc(LintBlocos);
        AintBlocosEnviados := LintBlocos;
        Inc(LintEnviado, LintLidos);

        pProgresso(Format('Enviando %s (%d de %d)...',
          [fRotuloPacote(APacote.strPacote), AintIndice, AintTotalPacotes]),
          LintEnviado, APacote.intTamanho);
      until LintLidos < TEF_ATU_TAMANHO_BLOCO_RAPIDO;
    finally
      LStream.Free;
    end;

    pLogaDiagnosticoDvc(Format(
      'Atualizacao: pacote "%s" enviado pelo canal RAPIDO (%d bloco(s), %d bytes, %d ms).',
      [APacote.strPacote, LintBlocos, LintEnviado, GetTickCount - LdwInicio]));
    Result := True;
  finally
    LobjCanal.Free;
  end;
end;

{ Manda um pacote inteiro: abre, N partes, fecha. Devolve False com
  AstrErro quando a estacao recusou.

  O pAtuAbre e o fAtuFecha ficam ONDE SEMPRE ESTIVERAM, no canal da
  transacao: e o fAtuFecha que confere o sha256 e promove o .parcial (RF44),
  e isso nao muda de lugar so porque os bytes passaram a viajar por outro
  cano. O caminho rapido entrega bytes e nada mais. }
function fEnviaPacote(ATef: TTefCitelDvc; const APacote: TdtoPacoteLocal;
  const AintIndice, AintTotalPacotes: Integer; out AstrErro: String;
  out AblnTransferiu: Boolean): Boolean;
var
  LDados, LResp: TJSONObject;
  LstrMotivo: String;
  LintBlocosRapidos: Integer;
begin
  AstrErro := '';
  AblnTransferiu := False;

  { Recusado = outro autcom esta transferindo este pacote agora. Sai como
    SUCESSO de propria vontade: nao ha erro nenhum, e a proxima carga vai
    encontrar o pacote pronto - mesmo desfecho do "ja esta PREPARADO". Sair
    como falha faria a carga registrar um erro que nao existe. }
  if not fAbrePacote(ATef, APacote, LstrMotivo) then
  begin
    pLogaDiagnosticoDvc(Format(
      'Atualizacao: pacote "%s" NAO sera transferido por este autcom - %s.',
      [APacote.strPacote, LstrMotivo]));
    { AblnTransferiu segue False de proposito: quem chama nao pode contar
      isto como pacote enviado nem concluir que ha algo a aplicar. Na
      primeira versao deste conserto ele contava, e o log de campo de 17/09
      16:08 saiu dizendo "1 pacote(s) transferido(s)" para um autcom que nao
      mandou um byte - e ainda chamava o fAtuAplica a toa, que respondia
      "nao ha pacote preparado". }
    Exit(True);
  end;

  if not fEnviaPartesRapido(ATef, APacote, AintIndice, AintTotalPacotes,
       LstrMotivo, LintBlocosRapidos) then
  begin
    { Uma linha por pacote dizendo qual cano foi usado. Sem ela nao ha como
      saber, num log de campo, se o caminho rapido atuou - e descobrir isso
      por deducao ja custou uma leitura inteira de log em 2026-09-16. }
    pLogaDiagnosticoDvc(Format(
      'Atualizacao: pacote "%s" vai pelo caminho LENTO - %s.',
      [APacote.strPacote, LstrMotivo]));

    { Reabre SO se o rapido chegou a gravar alguma coisa. Na implantacao a
      estacao comum e a que ainda nao tem a DLL de volume: ali o canal nem
      abre, nada foi gravado, e um pAtuAbre a mais so produziria uma linha
      de "recepcao anterior DESCARTADA" por pacote - ruido exatamente no log
      que vai ser usado para conferir o fallback. }
    if LintBlocosRapidos > 0 then
      { A recepcao ja e deste autcom, entao a estacao nao recusa - reabrir
        aqui e o mesmo dono recomecando, que continua permitido. O retorno e
        ignorado de proposito: se por algum motivo recusar, o pEnviaPartesLento
        abaixo falha em seguida com mensagem melhor que a daqui. }
      fAbrePacote(ATef, APacote, LstrMotivo);

    pEnviaPartesLento(ATef, APacote, AintIndice, AintTotalPacotes);
  end;

  AblnTransferiu := True;

  LDados := TJSONObject.Create;
  LDados.AddPair('pacote', APacote.strPacote);
  LResp := ATef.fChamaRpcAtualizacao('fAtuFecha', LDados);
  try
    Result := fJsonBool(LResp, 'ok', False);
    if not Result then
      AstrErro := fJsonStr(LResp, 'erro');
  finally
    LResp.Free;
  end;
end;

{ Mensagem final da tela, uma por desfecho. Curtas de proposito: o operador
  le isto de relance, e logo em seguida a carga do TEF segue para o login. }
function fEtapaFinal(const AintRetorno: Integer): String;
begin
  case AintRetorno of
    TEF_ATU_RET_APLICADO:  Result := 'Estação do TEF atualizada.';
    TEF_ATU_RET_ADIADO:    Result := 'Atualização adiada - a estação está ocupada. ' +
                                     'Será aplicada na próxima abertura.';
    TEF_ATU_RET_SEM_VOLTA: Result := 'O serviço de TEF da estação não voltou.';
    TEF_ATU_RET_FALHA:     Result := 'Atualização não concluída - o AUTCOM segue ' +
                                     'abrindo normalmente.';
  else
    { NADA_A_FAZER e o caso comum: nenhuma tela chegou a ser escrita por este
      fluxo, entao nao ha o que corrigir. Texto neutro para nao inventar
      etapa que nao aconteceu. }
    Result := 'Carregando o TEF...';
  end;
end;

{ Espera o servico REINICIAR - nao apenas responder.

  Cada tentativa e um fAtuConsulta de verdade: enquanto o servico esta
  parado ela levanta excecao, e e isso que se engole aqui. O custo de cada
  tentativa frustrada pode chegar aos ~30 s do teto de entrega do
  transporte - por isso o teto total e de 120 s (ver
  TEF_ATU_TETO_VOLTA_MS).

  DEFEITO QUE ISTO CONSERTA (campo, 2026-09-16)

  A versao anterior saia com Exit(True) na PRIMEIRA resposta. Parecia
  razoavel e nao era: o fMetodoFAtuAplica responde ANTES de derrubar o
  servico (FblnReiniciarAposResposta), entao a primeira pergunta e
  respondida pelo servico VELHO, ainda de pe - o log de campo mostrou o
  autcom concluindo "voltou" 16 ms depois do fAtuAplica, antes mesmo de o
  TefEstacaoAtualizador.exe ter sido lancado. Este laco nunca via o
  servico cair; so podia acertar por acidente.

  O estrago vinha depois: dado o "voltou", o autcom seguia para o login, e
  o fConfiguraTefCitel carregava a pilha nativa do Scope DENTRO do processo
  que estava parando. O UnLoadDLLFunctions do untScopeNCR nao devolve as
  referencias que o FunctionDetect toma (residuo conhecido - ver o
  record.md do 456190), entao scopeapi.dll e as dependencias dela so saiam
  da memoria quando o processo morria de fato. O atualizador, que comeca a
  gravar assim que o SCM diz STOPPED, pegava csmsg.dll travada. De quebra,
  aquele login de 4,5 s era jogado fora no reinicio e o operador levava um
  "loginNecessario" no cartao seguinte.

  Responder nao prova nada. O que prova reinicio e a IDENTIDADE da instancia
  (RF29): guarda-se a conhecida antes de aplicar e so se sai quando a
  estacao se apresentar com OUTRA.

  E ela vem na resposta do PROPRIO fAtuConsulta, nao do "reata" - detalhe
  que custou uma segunda volta nesta correcao. O "reata" so e enviado quando
  o CANAL DVC cai, e no reinicio da atualizacao o canal NAO cai: quem cai e
  o socket plugin->servico, que o plugin reconecta sozinho e em silencio. No
  log de 16/09 o servico reiniciou as 08:36:16 sem um unico "reata"; os dois
  do dia foram da reconexao de sessao RDP, as 08:24. Esperar pelo "reata"
  aqui teria queimado os 120 s do teto e devolvido "nao voltou a responder"
  com o servico no ar.

  Instancia vazia e "ainda nao sei", nunca prova de nada - inclusive quando
  a estacao e anterior a esta versao e nao manda o campo. Nesse caso a
  espera vai ate o teto e devolve False; e o lado seguro do erro, porque o
  autcom desiste da atualizacao em vez de seguir para o login cedo demais. }
function fEsperaServicoVoltar(ATef: TTefCitelDvc;
  const AstrInstanciaAntes: String): Boolean;
var
  LdwInicio: DWORD;
  LResp: TJSONObject;
  LstrAgora: String;
begin
  Result := False;
  LdwInicio := GetTickCount;

  repeat
    pProgresso('Aguardando o serviço de TEF da estação reiniciar...');
    try
      LResp := ATef.fChamaRpcAtualizacao('fAtuConsulta', TJSONObject.Create);
      try
        LstrAgora := fJsonStr(LResp, 'instanciaServico');
      finally
        LResp.Free;
      end;
      if (LstrAgora <> '') and (LstrAgora <> AstrInstanciaAntes) then
      begin
        pLogaDiagnosticoDvc(Format(
          'Atualizacao: o servico da estacao VOLTOU depois de %d ms - ' +
          'instancia "%s", diferente da "%s" de antes da aplicacao.',
          [GetTickCount - LdwInicio, LstrAgora, AstrInstanciaAntes]));
        Exit(True);
      end;

      { Respondeu com a mesma instancia (ou sem instancia conhecida ainda):
        e o servico velho terminando de parar, ou o "reata" da reconexao que
        ainda nao foi respondido. Nos dois casos a resposta certa e esperar
        mais - seguir daqui e o defeito que este laco conserta. }
      pLogaDiagnosticoDvc(Format(
        'Atualizacao: a estacao respondeu, mas a instancia continua "%s" - ' +
        'ainda nao e o servico novo. Esperando (%d ms de %d).',
        [LstrAgora, GetTickCount - LdwInicio, TEF_ATU_TETO_VOLTA_MS]));
    except
      on E: Exception do
        pLogaDiagnosticoDvc(Format(
          'Atualizacao: servico ainda nao respondeu (%s) - %d ms de %d.',
          [E.ClassName, GetTickCount - LdwInicio, TEF_ATU_TETO_VOLTA_MS]));
    end;
    Sleep(TEF_ATU_INTERVALO_VOLTA_MS);
  until GetTickCount - LdwInicio > TEF_ATU_TETO_VOLTA_MS;
end;


function fDescreveOrigens(const AstrDirAutcom, AstrOpcaoTefCit,
  AstrDirIniTerminal: String): TArray<String>;
var
  LarrPacotes: TArrPacoteLocal;
  I: Integer;
begin
  LarrPacotes := fDescobrePacotes(AstrDirAutcom, AstrOpcaoTefCit,
    AstrDirIniTerminal);
  SetLength(Result, Length(LarrPacotes));
  for I := 0 to High(LarrPacotes) do
    Result[I] := Format('%s|%s|%s|%d',
      [LarrPacotes[I].strPacote, LarrPacotes[I].strCaminho,
       LarrPacotes[I].strHash, LarrPacotes[I].intTamanho]);
end;
function fAtualizaEstacaoTef(ATef: ITefCitel; const AstrDirAutcom,
  AstrOpcaoTefCit, AstrDirIniTerminal: String;
  out AstrMensagem: String): Integer;
var
  LDvc: TTefCitelDvc;
  LarrPacotes: TArrPacoteLocal;
  LObjAplicado, LObjPreparado, LResp: TJSONObject;
  LstrDirServico, LstrDirAplicado, LstrErro, LstrMotivo: String;
  LstrInstanciaAntes: String;
  LintEnviados, I: Integer;
  LblnTemAlgo, LblnDirMudou, LblnDivergiu, LblnTransferiu: Boolean;
begin
  AstrMensagem := '';
  Result := TEF_ATU_RET_NADA_A_FAZER;

  { A TELA DO HOST FICA COM A ULTIMA MENSAGEM QUE RECEBEU, e este fluxo e o
    UNICO que escreve nela durante a carga do TEF - o untTefCitelUtil.pas
    passa o callback adiante e nao chama nenhuma vez por conta propria.

    Consequencia medida em campo (17/09, 14:35): a atualizacao de um autcom
    falhou no meio da transferencia, a carga seguiu normalmente e terminou o
    login, mas o splash ficou parado em "Enviando scope (1 de 2)... 67%" pelo
    resto da carga inteira. Da tela, parecia travado; do log, tinha acabado.

    Por isso o finally: TODA saida daqui deixa uma mensagem final. Nao e
    cosmetico - e a diferenca entre o operador esperar e o operador chamar o
    suporte. }
  try

  { RF38 - copia de homologacao nao atualiza nada.

    A trava mora AQUI, e nao no autcom.exe, de proposito: e o ponto que nao
    da para contornar por esquecimento de quem chama. ParamStr(0) dentro de
    uma DLL devolve o executavel do PROCESSO HOSPEDEIRO, entao o caminho
    conferido e mesmo o do autcom.exe. }
  if ContainsText(ParamStr(0), TEF_ATU_FRAGMENTO_HOM) then
  begin
    pLogaDiagnosticoDvc(Format(
      'Atualizacao BARRADA: o caminho do executavel ("%s") contem "%s" - ' +
      'esta e copia de homologacao e nao atualiza estacao (RF38).',
      [ParamStr(0), TEF_ATU_FRAGMENTO_HOM]));
    Exit(TEF_ATU_RET_NADA_A_FAZER);
  end;

  { SO ESTACAO CONFIGURADA PARA TEF (exigencia do Rafael, 2026-09-15).

    A guarda de verdade esta no CHAMADOR: a chamada fica DENTRO do
    "if not qryTefTra.IsEmpty" do pIniciaTefCitel, junto do proprio
    fConfiguraTefCitel - e so ali se sabe que ESTE terminal tem TEF
    configurado, porque quem sabe disso e a linha da tabela de terminal,
    que esta unit nao le nem deve ler.

    Esta linha e a segunda barreira, pelo mesmo raciocinio do HOM acima:
    CFG_TEFCIT fora de 'T'/'S' nao e TEF Citel, e nada pode sair daqui.
    Custa uma comparacao e fecha o caminho de alguem, um dia, mover a
    chamada para fora da guarda sem perceber o que ela protegia. }
  if (AstrOpcaoTefCit <> OPCAO_NCR) and (AstrOpcaoTefCit <> OPCAO_CLISITEF) then
  begin
    pLogaDiagnosticoDvc(Format(
      'Atualizacao: CFG_TEFCIT = "%s" nao e TEF Citel - esta estacao nao e ' +
      'tocada.', [AstrOpcaoTefCit]));
    Exit(TEF_ATU_RET_NADA_A_FAZER);
  end;


  if not (ATef is TTefCitelDvc) then
  begin
    { Sem DVC nao ha canal, e sem canal nao ha o que atualizar. Nao e erro:
      e o modo classico, em que o TEF roda dentro do proprio autcom. }
    Exit(TEF_ATU_RET_NADA_A_FAZER);
  end;
  LDvc := ATef as TTefCitelDvc;

  try
    LarrPacotes := fDescobrePacotes(AstrDirAutcom, AstrOpcaoTefCit,
      AstrDirIniTerminal);

    pProgresso('Verificando atualizações do TEF na estação...');
    LResp := LDvc.fChamaRpcAtualizacao('fAtuConsulta', TJSONObject.Create);
    try
      LstrDirServico  := fJsonStr(LResp, 'dirServico');
      LstrDirAplicado := fJsonStr(LResp, 'dirServicoAplicado');

      { Identidade do processo do servico ANTES de qualquer coisa. E com ela
        que o fEsperaServicoVoltar vai provar que o reinicio aconteceu.
        Vazia quando a estacao ainda nao manda o campo (servico anterior a
        esta versao): ai a espera cai no comportamento antigo, e esta dito
        no comentario de la. }
      LstrInstanciaAntes := fJsonStr(LResp, 'instanciaServico');
      LObjAplicado    := fJsonObj(LResp, 'aplicado');
      LObjPreparado   := fJsonObj(LResp, 'preparado');

      { RN19 - servico mudou de pasta. O hash de origem nao muda quando
        isso acontece, entao sem esta comparacao os .ini ficariam com os
        caminhos apontando para onde o servico nao esta mais. }
      LblnDirMudou := (LstrDirAplicado <> '') and
                      (not SameText(LstrDirAplicado, LstrDirServico));
      if LblnDirMudou then
        pLogaDiagnosticoDvc(Format(
          'Atualizacao: o servico da estacao mudou de pasta ("%s" -> "%s") - ' +
          'os .ini serao reenviados mesmo com hash igual (RN19).',
          [LstrDirAplicado, LstrDirServico]));

      LintEnviados := 0;
      LblnTemAlgo := False;

      for I := 0 to High(LarrPacotes) do
      begin
        LblnDivergiu :=
          (not SameText(LarrPacotes[I].strHash,
             fJsonStr(LObjAplicado, LarrPacotes[I].strPacote))) or
          (LblnDirMudou and fEhPacoteIni(LarrPacotes[I].strPacote));

        { Igual ao que ja esta PREPARADO: outro autcom mandou este mesmo
          pacote e a estacao ainda nao aplicou. Nao reenviar - e o que
          impede dois operadores abrindo o sistema ao mesmo tempo de
          duplicarem a transferencia inteira. }
        if SameText(LarrPacotes[I].strHash,
             fJsonStr(LObjPreparado, LarrPacotes[I].strPacote)) then
        begin
          pLogaDiagnosticoDvc(Format(
            'Atualizacao: pacote "%s" ja esta PREPARADO na estacao com o ' +
            'mesmo hash - outro autcom ja mandou. Nao reenviando.',
            [LarrPacotes[I].strPacote]));
          LblnTemAlgo := True;
          Continue;
        end;

        if not LblnDivergiu then
          Continue;

        pProgresso(Format('Enviando %s...',
          [fRotuloPacote(LarrPacotes[I].strPacote)]));
        if fEnviaPacote(LDvc, LarrPacotes[I], I + 1, Length(LarrPacotes),
             LstrErro, LblnTransferiu) then
        begin
          { Sucesso SEM ter transferido = outro autcom esta mandando este
            pacote agora. Nao conta como enviado e nao liga o LblnTemAlgo: o
            preparo ainda nao existe, e chamar o fAtuAplica aqui so renderia
            um "nao ha pacote preparado" do outro lado. Quem esta
            transferindo aplica; se nao der, a proxima carga aplica. }
          if not LblnTransferiu then
            Continue;

          Inc(LintEnviados);
          LblnTemAlgo := True;
          pLogaDiagnosticoDvc(Format(
            'Atualizacao: pacote "%s" enviado e conferido pela estacao ' +
            '(%d bytes, sha256 %s...).',
            [LarrPacotes[I].strPacote, LarrPacotes[I].intTamanho,
             Copy(LarrPacotes[I].strHash, 1, 12)]));
        end
        else
          { Pacote recusado nao derruba os outros: cada um e conferido por
            conta propria do lado de la, e um zip corrompido nao deveria
            impedir a atualizacao de um .ini que esta certo. }
          pLogaDiagnosticoDvc(Format(
            'Atualizacao: pacote "%s" RECUSADO pela estacao - %s. Seguindo ' +
            'com os outros.', [LarrPacotes[I].strPacote, LstrErro]));
      end;
    finally
      LResp.Free;
    end;

    { Alem do que foi enviado agora, pode haver preparo de uma carga
      anterior que ficou adiado por ocupacao - por isso fAtuAplica e
      chamado sempre que ha ALGO, nao so quando algo foi enviado. }
    if not LblnTemAlgo then
      Exit(TEF_ATU_RET_NADA_A_FAZER);

    pProgresso('Aplicando a atualização na estação...');
    LResp := LDvc.fChamaRpcAtualizacao('fAtuAplica', TJSONObject.Create);
    try
      if not fJsonBool(LResp, 'aplicado', False) then
      begin
        LstrMotivo := fJsonStr(LResp, 'motivo');
        AstrMensagem := LstrMotivo;
        pLogaDiagnosticoDvc(Format(
          'Atualizacao: %d pacote(s) transferido(s), mas a estacao ADIOU a ' +
          'aplicacao - %s. Fica preparado; a proxima carga aplica em ' +
          'segundos, sem transferir nada de novo.', [LintEnviados, LstrMotivo]));
        Exit(TEF_ATU_RET_ADIADO);
      end;
    finally
      LResp.Free;
    end;

    pLogaDiagnosticoDvc(Format(
      'Atualizacao: a estacao aceitou aplicar (%d pacote(s) enviados nesta ' +
      'carga). Aguardando o servico reiniciar.', [LintEnviados]));

    { ANTES de esperar, e nao depois: daqui em diante o proximo quadro que
      chegar pode ja ser do servico NOVO, com o messageId recomecando em 1.
      Sem este aviso o transporte descarta essa resposta como duplicata e o
      fEsperaServicoVoltar fica parado para sempre - o WaitFor do fChamaRpc
      e INFINITE de proposito e so o canal DVC caindo o solta, e o canal nao
      cai neste reinicio. Foi exatamente o travamento medido em 16/09 as
      11:00. }
    LDvc.pPreparaReinicioDaEstacao;

    if fEsperaServicoVoltar(LDvc, LstrInstanciaAntes) then
      Exit(TEF_ATU_RET_APLICADO);

    AstrMensagem :=
      'O serviço de TEF da estação foi reiniciado para aplicar uma ' +
      'atualização e não voltou a responder.';
    Exit(TEF_ATU_RET_SEM_VOLTA);
  except
    { Nada aqui pode subir para o pIniciaTefCitel: a atualizacao e um
      adicional na carga, nunca um motivo para ela falhar (RN23). }
    on E: Exception do
    begin
      AstrMensagem := E.ClassName + ': ' + E.Message;
      pLogaDiagnosticoDvc(Format(
        'Atualizacao: falhou (%s). A carga do autcom segue normalmente e a ' +
        'estacao continua com o que ja tinha instalado.', [AstrMensagem]));
      Exit(TEF_ATU_RET_FALHA);
    end;
  end;

  finally
    { 0/0 e a forma "so texto" que o resto deste fluxo ja usa (ver as chamadas
      de pProgresso sem numero acima) - aqui ela tambem serve para a barra
      nao ficar parada no percentual de onde a transferencia morreu. }
    pProgresso(fEtapaFinal(Result));
  end;
end;

end.
