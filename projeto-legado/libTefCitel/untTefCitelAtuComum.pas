unit untTefCitelAtuComum;

{ Vocabulario compartilhado da atualizacao de arquivos da estacao
  (Req. 456190, Fase 6). Contrato em IA\specs\456190\specs.md secao 11.

  POR QUE UMA UNIT SO PARA ISTO, E SEM NENHUM "uses".

  Tres projetos precisam destas constantes: libTefCitel.dll (lado autcom,
  que descobre e envia), TefEstacaoService.exe (que recebe e prepara) e
  TefEstacaoAtualizador.exe (que aplica). O lugar obvio seria
  untTefCitelComum, e foi la que elas nasceram - mas untTefCitelComum puxa
  untInterfaceTefCitel, que puxa UniDAC, e o ATUALIZADOR precisa ficar
  leve.

  Leve por dois motivos, e o segundo e o que decide. O primeiro e tamanho.
  O segundo: o atualizador existe justamente para concentrar o
  comportamento que antivirus olham torto - trocar o proprio executavel de
  um servico, extrair .zip por cima de um diretorio de programa, parar e
  subir servico pelo SCM. Um binario pequeno, com proposito unico e sem
  meio mundo de biblioteca dentro, e mais facil de analisar, de assinar e
  de liberar numa excecao de antivirus do que um de varios MB.

  Dependencias: so RTL, e so o minimo (SysUtils/Classes/Hash, por causa do
  fSha256DeArquivo). Nada de UniDAC, nada de VCL. Se alguem precisar
  acrescentar um "uses" fora dessa faixa, provavelmente o que esta sendo
  acrescentado nao pertence a esta unit. }

interface

uses
  System.SysUtils, System.Classes, System.Hash;

const
  { --- Nomes de pacote ---
    Chave no arquivo de versao e valor do campo "pacote" no RPC. Conjunto
    FECHADO: fNomeNoPreparo recusa qualquer valor fora desta lista, e e por
    isso que nenhum nome vindo do canal precisa ser sanitizado. }
  TEF_ATU_PACOTE_SCOPE        = 'scope';
  TEF_ATU_PACOTE_CLISITEF     = 'clisitef';
  TEF_ATU_PACOTE_SERVICO      = 'servico';

  { A propria libTefCitel.dll (Req. 456190, pedido do Rafael em 2026-09-17).

    O TefEstacaoService.exe a carrega por DELAY-LOAD a partir da pasta plana da
    estacao - foi para isso que o import virou "delayed" em 2026-08-28, e o
    comentario de untTefEstacaoRoteadorMensagens.pas ja dizia que "trocar o
    arquivo libTefCitel.dll na pasta plana da estacao passa a bastar, sem
    precisar recompilar/redistribuir o TefEstacaoService.exe inteiro". Este
    pacote e o que fecha essa promessa.

    Vai CRU, sem .zip (decisao do Rafael): e um arquivo so, e compactar um
    binario ja compactado nao paga o passo a mais na estacao. }
  TEF_ATU_PACOTE_LIB          = 'libtefcitel';
  TEF_ATU_PACOTE_SCOPE_INI    = 'scope.ini';
  TEF_ATU_PACOTE_CLISITEF_INI = 'clisitef.ini';
  TEF_ATU_PACOTE_CONFITLS_INI = 'confitls.ini';

  { --- Arquivos de origem, no diretorio do autcom.exe (RF30/RF31) --- }
  TEF_ATU_ZIP_SCOPE    = 'tef_scope.zip';
  TEF_ATU_ZIP_CLISITEF = 'tef_clisitef.zip';
  TEF_ATU_ZIP_SERVICO  = 'TefEstacaoService.zip';

  { --- Nomes dos .ini, como estao em disco (RF32/RF33) ---
    O Windows nao diferencia caixa, mas estes sao os nomes reais e e assim
    que devem aparecer no log. }
  TEF_ATU_INI_SCOPE    = 'scope.ini';
  TEF_ATU_INI_CLISITEF = 'CliSiTef.ini';
  TEF_ATU_INI_CONFITLS = 'CONFITLS.ini';

  { --- Binarios da estacao ---
    TEF_ATU_SERVICO_NOME e DUPLICADO por literal em tres lugares, de
    proposito: aqui, no constructor de TTefEstacaoService
    (untTefEstacaoServiceMain.pas) e em install\install-service.ps1. Mesma
    decisao ja tomada para a porta TCP e o nome do canal DVC - mudar aqui
    exige mudar nos outros dois na MESMA sessao. }
  TEF_ATU_SERVICO_NOME   = 'TefEstacaoService';
  TEF_ATU_EXE_SERVICO    = 'TefEstacaoService.exe';
  TEF_ATU_DLL_LIB        = 'libTefCitel.dll';
  TEF_ATU_EXE_ATUALIZADOR = 'TefEstacaoAtualizador.exe';

  { --- Registro do plug-in de canal, por usuario do Windows ---

    O plug-in DVC so tem registro POR USUARIO: a documentacao da Microsoft
    sobre DVC plug-in registration lista uma unica raiz, e e HKEY_CURRENT_USER
    (a hipotese de HKLM ja foi levantada, investigada e descartada - ver
    IA\specs\456190\plans.md secao 12.2).

    Estao aqui porque o TefEstacaoService.exe passou a precisar deles no
    switch /registraplugin (untTefEstacaoRegistroPlugin.pas), que e o que
    a tarefa de logon executa.

    DUPLICADOS de proposito, como o TEF_UPD_CANAL logo abaixo: os dois
    plug-ins declaram os mesmos literais nos .dpr deles
    (TefCitelDvcPlugin.dpr, TefCitelDvcUpdate.dpr) e o instalador os repete
    no [Code] do TefCitelEstacao.iss. Sao .dproj diferentes e nao vale
    search-path entre eles. Mudar aqui exige mudar nos outros na MESMA
    sessao. }
  TEF_ATU_CHAVE_ADDIN    = 'Software\Microsoft\Terminal Server Client\Default\AddIns';
  TEF_ATU_CANAL_TEF      = 'TefCitelCh';
  TEF_ATU_DLL_PLUGIN     = 'TefCitelDvcPlugin.dll';
  TEF_ATU_DLL_PLUGIN_UPD = 'TefCitelDvcUpdate.dll';

  { --- Layout em disco, no diretorio do TefEstacaoService.exe ---
    Pasta de trabalho do proprio servico, nunca %TEMP%: mesmo idioma do
    FilaTef e do TempQr, e pela mesma razao - para um servico rodando como
    LocalSystem, %TEMP% e candidato a Limpeza de Disco. }
  TEF_ATU_ARQ_VERSAO  = 'TefEstacaoVersao.ini';
  TEF_ATU_DIR_PREPARO = '_Preparo';
  TEF_ATU_DIR_FALHOU  = '_Falhou';

  { Nome do exe anterior enquanto o novo nao provou que sobe, e do novo
    enquanto ainda nao tomou o lugar. }
  TEF_ATU_SUFIXO_OLD  = '.old';
  TEF_ATU_SUFIXO_NOVO = '.novo';

  { --- Secoes e chaves do TefEstacaoVersao.ini ---
    [Aplicado] e o que esta instalado; [Preparado] o que ja chegou e foi
    conferido; [Pendente] existe entre a decisao de aplicar e a aplicacao;
    [Falhou] guarda hash de pacote que JA NAO SOBE - e o que impede o laco
    de um exe ruim voltando pelo rollback, sendo reenviado pelo autcom na
    carga seguinte e falhando de novo, para sempre. }
  TEF_ATU_SECAO_APLICADO   = 'Aplicado';
  TEF_ATU_SECAO_PREPARADO  = 'Preparado';
  TEF_ATU_SECAO_CONTEXTO   = 'Contexto';
  TEF_ATU_SECAO_PENDENTE   = 'Pendente';
  TEF_ATU_SECAO_FALHOU     = 'Falhou';
  TEF_ATU_CHAVE_DIRSERVICO = 'DirServico';
  TEF_ATU_CHAVE_DATAULTIMA = 'DataUltimaAplicacao';
  TEF_ATU_CHAVE_APLICAR    = 'Aplicar';

  { --- Transporte ---
    256 KB de base64 por pAtuParte (~192 KB binario).

    O fragmento fisico de 1400 bytes (TEF_DVC_TAMANHO_MAX_FRAGMENTO) e teto
    do chunk WTS e nao se mexe - mas o ACK do transporte e por quadro
    LOGICO, nao por fragmento, e o IWTSVirtualChannel.Write mediu 0 ms em
    centenas de amostras (bateria de 2026-09-14). Entao quadro logico
    grande amortiza o ACK: a leitura do QR-Code Pix (5.991 bytes, 7
    fragmentos, 95 ms) diz que o custo e ~95 ms de ida-e-volta quase
    independente do tamanho.

    ESTE NUMERO E ESTIMATIVA. Medir na primeira bateria de campo e ajustar
    (item D do roteiro da Fase 6 no tasks.md). Cabe folgado no
    TEF_DVC_TAMANHO_MAX_FRAME de 16 MB, cujo proprio comentario ja citava
    esta rotina ("cobre fragmentos base64 de DLL"). }
  TEF_ATU_TAMANHO_PARTE = 256 * 1024;

  { --- Canal de volume da atualizacao (Fase 6.1, Req. 456190) ---

    Canal DVC PROPRIO, separado do "TefCitelCh" da transacao. A separacao e o
    desenho inteiro: o payload so pode viajar em bloco grande porque neste
    canal nada mais escreve enquanto uma leitura esta pendente - que e a
    causa da perda medida em 2026-08-31 e o motivo dos 1400 bytes la
    (untTefCitelDvcTransporte.pas:301). Ver secao 12 de
    IA\specs\456190\specs.md.

    TEF_UPD_CANAL e TEF_UPD_PORTA sao DUPLICADOS na DLL do plugin de volume,
    de proposito: sao .dproj diferentes e nao vale search-path entre eles -
    mesma decisao ja registrada para o fCrc32 em IA\rules\tef-dvc.md. Se
    mudar aqui, mudar la na mesma sessao. }
  TEF_UPD_CANAL: AnsiString = 'TefCitelUpd';
  TEF_UPD_PORTA = 47992;

  { Lido do ARQUIVO; vira ~341 KiB de base64 no fio. A PoC DVC_v2 aprovou ate
    1 MiB em 1.000 repeticoes, entao ha folga larga. }
  TEF_ATU_TAMANHO_BLOCO_RAPIDO = 256 * 1024;

  { Teto de espera da resposta de UM bloco. Nao viola a regra do topo de
    IA\rules\tef-dvc.md: nao ha pinpad neste canal, e a RN37 proibe que
    passe a haver. E um sinal auxiliar entre transportes, igual ao ACK. }
  TEF_UPD_TIMEOUT_BLOCO_MS = 30000;

  { Tempo sem receber parte depois do qual uma recepcao em andamento e
    considerada ABANDONADA e pode ser tomada por outro autcom (achado de
    campo 2026-09-17, caso B.1).

    Sem este teto, um autcom que morresse no meio de uma transferencia
    bloquearia o pacote para todos os outros ate o servico reiniciar. Com
    ele, o pior caso e esperar 60 s. O numero e folgado de proposito contra
    o caminho LENTO, onde cada parte leva ~4 s; o rapido manda os 38 blocos
    em ~5 s no total. }
  TEF_ATU_RECEPCAO_ABANDONADA_MS = 60000;

  { --- Tempos ---
    Teto de espera pelo servico voltar depois do reinicio.

    120 s, e o numero tem razao de ser: enquanto o servico esta parado, CADA
    tentativa de consulta pode custar ate os ~30 s do teto de entrega do
    transporte (o ciclo de ACK do fChamaRpcUmaVez, que so desiste com PROVA
    de que o pedido nao chegou). Com 60 s caberiam duas tentativas; com 120 s
    cabem quatro, e o servico normalmente volta na primeira ou na segunda.

    NAO viola a regra do topo de IA\rules\tef-dvc.md. Nao ha pinpad
    envolvido: a ociosidade da estacao foi CONDICAO para chegar ate aqui, e
    o que se espera e o SCM subir um processo. Mesma natureza do teto de
    10 s do pParaComSeguranca, que ja tem essa justificativa escrita. }
  TEF_ATU_TETO_VOLTA_MS      = 120000;
  TEF_ATU_INTERVALO_VOLTA_MS = 1000;

  { --- Trava de homologacao (RF38) ---
    Comparado no caminho completo do autcom.exe, sem diferenciar caixa. O
    falso positivo existe (uma pasta de cliente "THOMAZ" barraria) e e o
    lado seguro do erro: deixa de atualizar, nunca atualiza indevidamente. }
  TEF_ATU_FRAGMENTO_HOM = 'HOM';

{ SHA-256 de um arquivo, lido em blocos.

  Mora aqui, e nao em cada lado, porque os TRES projetos precisam do MESMO
  numero: o autcom calcula o hash de origem, a estacao confere o que
  recebeu e o atualizador decide o que aplicar. Duas implementacoes do
  mesmo hash seria a forma mais facil de eles discordarem em silencio.

  THashSHA2.GetHashStringFromFile NAO existe neste Delphi - entrou em
  versao posterior ao Seattle. E mesmo que existisse, ler o pacote inteiro
  para memoria so para hashear seria carregar varios MB de uma vez sem
  necessidade nenhuma. }
function fSha256DeArquivo(const AstrArquivo: String): String;

implementation

function fSha256DeArquivo(const AstrArquivo: String): String;
const
  TAMANHO_BLOCO = 64 * 1024;
var
  LHash: THashSHA2;
  LStream: TFileStream;
  LbytBloco: TBytes;
  LintLidos: Integer;
begin
  LHash := THashSHA2.Create(THashSHA2.TSHA2Version.SHA256);
  SetLength(LbytBloco, TAMANHO_BLOCO);

  LStream := TFileStream.Create(AstrArquivo, fmOpenRead or fmShareDenyWrite);
  try
    repeat
      LintLidos := LStream.Read(LbytBloco[0], TAMANHO_BLOCO);
      if LintLidos > 0 then
        LHash.Update(LbytBloco, LintLidos);
    until LintLidos <= 0;
  finally
    LStream.Free;
  end;

  Result := LowerCase(LHash.HashAsString);
end;

end.
