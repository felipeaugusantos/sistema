# TEF / DVC (Req. 456190) — nunca impor timeout artificial sobre o tempo do pinpad

As funções do TEF (Scope/CliSiTef, `libTefCitel\untTefCitelNCR.pas`/`untTefCitel.pas`) bloqueiam
pelo tempo que o pinpad e a transação em andamento precisarem — esse tempo varia (de
milissegundos a minutos: escolha de parcelamento, digitação de senha, autorização com a
adquirente) e **não tem teto conhecido**, mas a chamada sempre retorna alguma coisa
eventualmente (sucesso, erro, cancelamento) — nunca trava para sempre por conta própria.

Confirmado pelo Rafael (2026-08-24, na investigação de lentidão/reenfileiramento do fluxo
DVC): qualquer camada de transporte/RPC que carregue essas chamadas precisa respeitar a mesma
regra — **nunca tratar "está demorando" como "falhou"**. Um timeout artificial nessas camadas
não acelera nada; só corta uma chamada que ainda ia responder, e — pior — pode disparar reenvio
duplicado de um método não-idempotente (`fPassarCartao`, `fCancelaTransacaoTerminal`,
`fReimpressao` repetem a transação de cartão de verdade; ao contrário de `fObtemVersao`/
`fConfiguraTefCitel`, que são seguros de repetir).

## Onde essa regra já está aplicada (não regredir)

- `libTefCitel\untTefCitelDvc.pas`, `fChamaRpc` — espera a resposta da estação com
  `WaitFor(INFINITE)` (ou bombeando `CheckSynchronize` quando chamado da thread principal, para
  não travar hooks síncronos — mas sem desistir sozinho). Só libera a espera quando
  `pOnDesconectado` marca `ErroCanal := True`, ou seja, quando o canal DVC realmente caiu — nunca
  por decurso de tempo.
- `libTefCitel\Estacao\untTefEstacaoRoteadorMensagens.pas`, `fDespachaMetodo` — chama
  `FRealInstance.fPassarCartao`/`fConfiguraTefCitel`/etc. direto e síncrono, sem nenhum wrapper
  de timeout ao redor da DLL nativa do Scope/CliSiTef.
- `libTefCitel\untTefCitelDvcTransporte.pas`, `pLoopLeitura` — o timeout de
  `WTSVirtualChannelRead` (`TEF_DVC_TIMEOUT_LEITURA_MS`) é só o intervalo de poll; ao reconhecer
  o erro como timeout, o loop simplesmente continua esperando, para sempre.
- `libTefCitel\Estacao\ClientPlugin\untTefCitelDvcPluginImpl.pas`, `pLoopEscritaWorker` —
  reprojetado em 2026-08-24 (era a exceção a esta regra: um timeout de 15s sobre o `WriteFile`
  do pipe local tratava escrita lenta como falha, causando dispatch em dobro de todo método,
  incluindo `fPassarCartao`). Agora a escrita não tem teto: uma escrita lenta só atrasa a fila,
  nunca é tratada como desconexão. Só um erro **real** devolvido pelo `WriteFile` (não demora)
  conta como pipe morto.

## Exceção deliberada, que NÃO viola esta regra

- `libTefCitel\Estacao\untTefEstacaoRoteadorMensagens.pas`, `TEF_ESTACAO_TIMEOUT_HOOK_MS = 30000`
  — teto de espera para o **AUTCOM responder um "hook" síncrono** (`Antes*`/`Depois*`) enquanto a
  transação já está rodando no pinpad. Não é timeout sobre a chamada TEF em si (o pinpad continua
  seu ciclo normalmente) — é sobre um sinal auxiliar entre estação e AUTCOM; se estourar, assume
  um default seguro (continuar) em vez de bloquear o pinpad indefinidamente por um AUTCOM
  desconectado. Reavaliar apenas se o próprio mecanismo de hook (não o transporte DVC/pipe) virar
  suspeito de reenfileiramento/perda de resposta.

## Como aplicar

Antes de adicionar qualquer `timeout`/`WaitFor(N)`/`WaitForSingleObject(handle, N)` em código que
fica no caminho de uma chamada TEF (transporte DVC, pipe local, roteador da estação, `TTefCitelDvc`
no lado AUTCOM): perguntar se esse tempo limite está esperando o **pinpad/transação** (não pode
ter teto) ou um **sinal auxiliar entre processos que não seja a resposta final da transação**
(pode ter teto, com fallback seguro documentado, como o hook acima).

## Protocolo de quadro v2 (messageId + CRC32) — os dois lados têm que concordar sempre

`libTefCitel\untTefCitelDvcTransporte.pas` (lado AUTCOM) e
`libTefCitel\Estacao\untTefEstacaoTcpTransporte.pas` (lado estação) implementam o **mesmo formato
de quadro**, byte a byte: `[4 bytes tamanho][4 bytes messageId][4 bytes CRC32][N bytes payload
JSON]`. O plugin cliente (`untTefCitelDvcPluginImpl.pas`) só repassa bytes crus entre o socket TCP
e o canal DVC — **não reencapsula nada** — então uma mudança de formato num lado sem a mesma
mudança no outro quebra a comunicação inteira silenciosamente (quadros passam a ser rejeitados por
CRC ou parseados errado).

**Regra**: qualquer alteração no layout do quadro (tamanho dos campos, ordem, algoritmo de CRC,
semântica do `messageId`) precisa ser replicada nos dois arquivos na MESMA sessão/commit — nunca
um de cada vez. `fCrc32` está duplicada propositalmente nos dois arquivos (em vez de extraída para
uma unit compartilhada) para evitar problemas de search-path entre os dois `.dproj` diferentes —
as duas cópias precisam ficar idênticas.

`messageId` é monotônico por remetente e reinicia a cada conexão nova (não persiste entre
reconexões) — deduplicação (`messageId <= último aceito` descarta) e CRC (`payload corrompido`
descarta) evitam que um quadro repetido ou corrompido seja processado duas vezes ou derrube a
thread de leitura.

**Fase 2 (2026-08-31) — ACK de transporte + retry**: todo quadro carrega um byte de `tipo`
(`DADO` ou `ACK`) além de `messageId`+`CRC32`. Ao aceitar (ou reconhecer como duplicata de) um
quadro `DADO`, o receptor manda de volta um quadro `ACK` referenciando aquele `messageId` — **antes**
de repassar ao roteador, então a confirmação de transporte não espera o processamento de negócio
terminar. `pEnviaFrame` (nos dois lados) espera esse ACK por `TEF_*_ACK_TIMEOUT_MS` (2s) e reenvia
o **mesmo** quadro (mesmo `messageId`, mesmo CRC) até `TEF_*_ACK_MAX_TENTATIVAS` (5) vezes. Reenviar
é seguro porque o receptor sempre deduplica por `messageId` — na pior das hipóteses o dado chega
fisicamente duas vezes, mas só é processado uma.

**Achado de campo crítico (2026-08-31)**: a 1ª versão desta fase lançava exceção
(`ETefCitelDvcTransporte`/`ETefEstacaoTcpTransporte`) ao esgotar as tentativas sem ACK — e essa
exceção **não é capturada em nenhum ponto da cadeia de chamada** (`fChamaRpc`/`pEnviaEnvelope`),
propagando até o loop principal da VCL e derrubando a sessão inteira. Aconteceu de verdade em
campo, inclusive na 1ª chamada da sessão (`fConfiguraTefCitel`) — a mesma instabilidade de canal
que já afetava mensagens grandes também atinge quadros pequenos, então isso podia disparar em
qualquer ponto, tornando o sintoma "aleatório". **Corrigido**: esgotar as tentativas não lança mais
exceção — loga um aviso e segue como melhor esforço, exatamente como o comportamento de antes da
Fase 2 (uma escrita bem-sucedida nunca teve garantia de entrega, e isso nunca foi tratado como erro
fatal). Só continuam sendo exceção os casos de desconexão REAL do canal/socket (`not FblnConectado`),
que já existiam antes da Fase 2 e já são tratados em todo ponto de chamada. Isso **não viola a regra
do topo deste arquivo**: é um teto sobre um sinal auxiliar de entrega entre os dois transportes (não
sobre a chamada TEF/pinpad em si), com o mesmo padrão já aceito para `TEF_ESTACAO_TIMEOUT_HOOK_MS` —
e ao esgotar, o comportamento cai de volta pro mesmo "melhor esforço" que sempre existiu, não trava
nem falha a chamada TEF em si.

**Ainda não implementado**: retomada de quadros não confirmados após reconexão do canal (`messageId`
e os ACKs pendentes são todos por conexão — se o canal cair no meio de um retry, o quadro é
considerado perdido, não fica em fila pra reenviar quando reconectar).

## Corrida entre atribuição de messageId e escrita no socket/canal (2026-09-02) — atribuir e escrever precisam ser atômicos juntos

Achado de campo (venda com 3 cartões, `pInfo21` aninhado dentro de `fPassarCartao`): a tela do
autcom parava de fechar sem travar de verdade (UI continuava respondendo, porque `fChamaRpc`
bombeia `Application.ProcessMessages` enquanto espera) — porque uma chamada RPC aninhada nunca
recebia resposta, mesmo com a resposta do `fPassarCartao` externo já tendo chegado certinha.

**Causa raiz**: em `pEnviaUmFragmento` (`untTefEstacaoTcpTransporte.pas` e
`untTefCitelDvcTransporte.pas`, espelhados), atribuir o `messageId` (`TInterlocked.Increment`) e
escrever o quadro no socket/canal (`pEnviaFrameBruto`, que só protegia a escrita em si via
`FcsEscrita`) eram dois passos separados. Como toda chamada roda em thread própria (ver seção
"Bug 2" no `tasks.md`/memória do Req. 456190), duas threads podiam pegar `messageId` em ordem
(ex.: 202, depois 203/204/205 de outra thread) mas escrever fora de ordem (203-205 primeiro) —
fazendo o `messageId` mais antigo chegar no destino DEPOIS de ids maiores já aceitos. O dedup por
ordem estrita (`LdwMessageId <= FdwUltimoIdRecebido` → descarta como "duplicado", seção acima)
descartava esse quadro mesmo sendo a primeira entrega real, deixando o `Evento.SetEvent`
correspondente nunca sinalizado — a `fChamaRpc` daquela chamada específica ficava esperando pra
sempre, e por estar aninhada na mesma pilha reentrante de uma chamada externa (`fPassarCartao`),
travava a UI por tabela mesmo com a resposta externa já processada.

Verificado que essa é a ÚNICA fonte de desordem no caminho inteiro: o worker de escrita do plugin
(`pLoopEscritaWorker`, `untTefCitelDvcPluginImpl.pas`) é FIFO estrito (confirmado no código — uma
única thread, consome a fila em ordem), e tanto o canal DVC quanto o socket TCP preservam ordem de
byte stream uma vez escritos corretamente. Por isso não foi necessário trocar o dedup por um
mecanismo mais tolerante a desordem (ex.: conjunto de ids já vistos) — bastou fechar a única janela
de corrida existente.

**Corrigido**: `FcsEscrita` (já existia, `TCriticalSection` reentrante por thread) agora também
protege a atribuição do `messageId` e o primeiro envio do quadro, garantindo que a ordem de
atribuição bata com a ordem real no socket/canal. Retentativas de ACK (mesmo `messageId`)
continuam fora do lock de propósito — não introduzem uma ordem nova que precise ser preservada, e
manter o lock preso durante os até 2s de espera por tentativa serializaria desnecessariamente
todas as outras chamadas concorrentes (`pInfo21`/`pInfo30`/etc.), reintroduzindo o mesmo tipo de
travamento que o Bug 2 corrigiu ao tirar tudo de uma thread só.

**Regra para qualquer alteração futura em `pEnviaUmFragmento`/`pEnviaFrame` (nos dois lados)**:
nunca separar "obter o próximo `messageId`" da "primeira escrita física desse quadro" sem alguma
forma de sincronização entre as duas — é exatamente essa janela que causou este bug. Retentativas
do mesmo `messageId` já confirmado como enviado uma vez não precisam da mesma proteção.

## Deadlock TThread.Synchronize x ACK de transporte (2026-08-31) — nunca despachar hook/evento de forma síncrona-bloqueante na thread de leitura

`libTefCitel\untTefCitelDvc.pas`, `pTrataHook` usava `TThread.Synchronize` para processar o hook
(`Antes*`/`Depois*`/`SucessoTefCartao`/`GravaLogErr`) e mandar `hook_resposta` de volta. Isso bloqueia
a thread de LEITURA do canal DVC até a thread principal terminar — mas o ACK (Fase 2, seção acima)
dessa própria `hook_resposta` só pode ser recebido pela MESMA thread de leitura, presa dentro do
`Synchronize`. Resultado: todo `hook_resposta` esgotava as 5 tentativas de ACK (10s perdidos),
sempre, de forma determinística — não é "aleatório", é espera circular garantida. Já tinha sido
diagnosticado e corrigido para `pTrataEvento` em 2026-08-28 (mesmo arquivo, comentário em
`pTrataEvento`), mas o fix nunca foi replicado em `pTrataHook`. Corrigido do mesmo jeito: trocado
para `TThread.Queue` (não bloqueia a thread de leitura, que volta na hora para
`WTSVirtualChannelRead`/fica livre pra receber o ACK quando a thread principal enviar a resposta).

**Cuidado ao aplicar esse padrão em qualquer callback futuro que rode na thread de leitura**: se o
callback recebe um objeto (ex.: `TJSONObject`) cujo dono libera a memória logo após o callback
retornar (`pOnFrameRecebido` faz `LJson.Free` num `finally` logo depois de chamar `pTrataHook`/
`pTrataEvento`/`pTrataResposta`), trocar `Synchronize` (bloqueante, seguro) por `Queue` (assíncrono)
sem cuidado extra vira use-after-free na primeira vez que o bloco adiado rodar depois do objeto já
ter sido liberado. Regra: extrair todo dado necessário do objeto (JSON, etc.) **antes** de chamar
`TThread.Queue`, e só usar os valores já extraídos dentro do bloco adiado — nunca a referência ao
objeto original. Já aplicado em `pTrataHook` (extrai `LRetorno`/campos de `GravaLogErr` antes do
`Queue`) e já era o padrão em `pTrataEvento` (extrai `LRetorno` antes do `Queue`).

**Como reconhecer este padrão de bug pelos logs**: um envio de resposta (`hook_resposta`/`resposta`/
evento) que esgota SEMPRE as `TEF_*_ACK_MAX_TENTATIVAS` tentativas de ACK, de forma 100%
reproduzível (não intermitente), é sinal forte de que o thread que deveria receber o ACK está
bloqueado esperando a própria resposta ser processada — procurar `TThread.Synchronize` no caminho
de despacho antes de suspeitar do canal/transporte em si.

## Duplicação de chunk físico no canal WTS (2026-08-31) — nível ABAIXO do protocolo de quadro lógico

Achado de campo distinto do dedup por `messageId` da Fase 1 (que só cobre o quadro lógico JÁ
remontado): num teste de crédito, `WTSVirtualChannelRead` entregou dois chunks físicos de MESMO
TAMANHO (1604 bytes) seguidos, dentro da remontagem de uma mensagem multi-chunk
(`fProcessaChunkWts`, `libTefCitel\untTefCitelDvcTransporte.pas`). **Atenção**: só o tamanho foi
confirmado igual — o conteúdo (bytes) nunca foi comparado até 2026-08-31 (correção registrada
abaixo), então "duplicação física do canal" ainda é hipótese, não fato provado. Sem proteção, o acumulado
(`FarrPayloadWtsParcial`) ultrapassava `FdwTotalWtsEsperado` (overshoot) e o excesso virava lixo
prefixado a um "próximo quadro" inexistente — `pExtraiFramesDisponiveis` lia um tamanho de quadro
de dentro do meio de um payload de cupom, levantava `ETefCitelDvcTransporte`, e essa exceção — sem
try/except em `pLoopLeitura` (só o lado estação tinha essa proteção, portada de
`untTefEstacaoTcpTransporte.pas`) — matava a thread de leitura, causando um `EAccessViolation` em
`System.@UStrClr` (mesma assinatura vista em 2 crashes anteriores nesta investigação: `erro2.txt` e o
`ERRO.txt` da regressão do ACK fatal, já corrigida).

**Corrigido, só no lado AUTCOM** (`fProcessaChunkWts`/`CHANNEL_PDU_HEADER` não existe no lado
estação, que usa TCP puro sem esse nível de remontagem):
1. `fProcessaChunkWts` detecta o overshoot e descarta o acumulado inteiro, reiniciando — não dá pra
   separar com segurança duplicata de dado novo dentro do overshoot.
2. `pLoopLeitura` agora envolve `pAcumulaBytesRecebidos` em `try/except` (espelhando o padrão que já
   existia do lado estação) — qualquer exceção de framing vira log + desconexão tratada, nunca mais
   mata a thread em silêncio.
3. Removido o log de diagnóstico incondicional em `pAcumulaBytesRecebidos` (obsoleto — já tinha
   provado o achado do hook duplicado, neutralizado pela Fase 1) — era a única chamada de log deste
   arquivo sem o gate "só loga se grande" que todas as outras já usam por causa do "Bug 6" (comentário
   de 2026-08-28: corrupção de heap sob chamada concorrente intensa de log).

**Ainda em aberto**: o overshoot em si (duplicação de chunk físico pelo canal DVC) não foi eliminado,
só passou a ser detectado e tratado com segurança — a causa exata (RDP Shortpath, mstsc.exe, EDR/AV
interceptando o canal — mesmo suspeito de outros achados desta investigação) continua desconhecida.
Quando isso acontecer, a mensagem em andamento se perde (sem retry automático no nível de mensagem
completa, só no nível de quadro/ACK já confirmado) — ainda não avaliado o impacto de negócio exato
desse caso específico.

**Correção importante (2026-08-31, teste seguinte)**: Rafael apontou, com razão, que eu estava indo
na direção de aceitar "é o canal/infra" sem prova — só o tamanho dos chunks tinha sido comparado,
nunca o conteúdo. Achado que corrige a leitura anterior: cruzando `TefCitelDvcPlugin.log`, as
"múltiplas entregas completas de 2228 bytes" ao longo de ~10s **não são duplicação do canal** — são
o retry da Fase 2 funcionando como projetado (a estação reenvia a mensagem inteira a cada ~2s por
não receber ACK). Isso não é bug. A pergunta real (por que o autcom nunca processa nenhuma das 5
tentativas com sucesso, sempre travando no mesmo ponto — a fronteira entre os dois chunks WTS de UMA
única entrega) continua sem resposta. Instrumentação adicionada em `untTefCitelDvcTransporte.pas`
para fechar isso com prova byte a byte: hex dump do conteúdo de cada chunk grande (não só o tamanho),
log explícito de `Length(Result)` no retorno de `fProcessaChunkWts` (MENSAGEM COMPLETA vs
incompleto), e log de entrada em `pAcumulaBytesRecebidos` (com gate de tamanho, para não repetir o
risco do Bug 6). **Regra para quem continuar esta investigação**: não concluir "canal duplica
fisicamente" nem "é infra" até o hex dump confirmar ou refutar isso byte a byte — tamanho igual não
é prova de conteúdo igual.

## DepoisPassarCartao/DepoisFinalizarTransacao/DepoisCancelarTransacao/DepoisReimpressao/SucessoTefCartao removidos do fio (2026-08-31) — emulados localmente no autcom

**Mudança de direção**: em vez de seguir caçando o bug de framing acima (a instrumentação revelou uma
contradição própria — `Length(Result)` batendo com o `totalLength` da mensagem ANTERIOR, nunca
explicada), Rafael propôs eliminar o payload grande (`DepoisPassarCartao`, ~2,2KB, o único multi-chunk
deste protocolo) em vez de continuar tratando o sintoma. Confirmado com código que isso é seguro:

- `untTefCitelUtil.pas` (lado autcom) — TODOS os callbacks `Depois*` ou ignoram o retorno recebido
  (`pDepoisCancelarTransacaoEvent`/`pDepoisReimpressaoEvent` chamam só `fLockUnlockTefCitel(False)`,
  parâmetro nem é lido; `pDepoisFinalizarTransacaoEvent` nem recebe parâmetro) ou só agem quando o
  retorno vem **nil** (`pDepoisPassarCartaoEvent` — nunca acontece no sucesso). `pSucessoTefCartaoEvent`
  tem corpo vazio **— na linha 74.150.** *Corrigido em 2026-09-29: nas linhas 74.111 e 72 ele GRAVAVA a
  TEFTRA (o pendente com modalidade, operação, parcelas e a TRADOC), chamado pela DLL antiga delas. Ver
  a seção "O mesmo callback não faz a mesma coisa em todas as linhas", no fim deste arquivo.*
- O dado que `DepoisPassarCartao` carregava é o MESMO `IRetornoTEFCitel` que `TTefCitelDvc.fPassarCartao`
  já recebe pela própria resposta RPC (`fChamaRpc('fPassarCartao', ...)` → já tem o retorno completo).
- `untTefCitelNCR.pas`/`untTefCitel.pas` (as duas implementações reais de `ITefCitel`) já guardam TODO
  hook com `Assigned()` antes de chamar (`pDepoisEvento` em NCR; checagens inline em `TTefCitel`) — não
  atribuir o hook do lado estação é seguro, não precisa de nenhum tratamento novo lá.

**Implementado**:
- `libTefCitel\untTefCitelDvc.pas`: `fPassarCartao`/`fFinalizarTransacao`/`fCancelaTransacaoTerminal`/
  `fReimpressao` agora chamam `FDepoisPassarCartao`/`FDepoisFinalizarTransacao`/
  `FDepoisCancelarTransacao`/`FDepoisReimpressao` (se atribuídos) localmente, logo após o RPC retornar —
  usando o retorno que a própria resposta RPC já trouxe, sem nenhuma chamada de rede adicional.
  `pTrataHook` não trata mais `DepoisPassarCartao`/`DepoisFinalizarTransacao`/`DepoisCancelarTransacao`/
  `DepoisReimpressao`/`SucessoTefCartao` (removidos — nunca mais chegam). Só restam `Antes*` (decidem
  algo real — `fLockUnlockTefCitel(True)`, trava de sessão multi-Autcom, que só o autcom sabe responder)
  e `GravaLogErr` (dado real, não redundante).
- `libTefCitel\Estacao\untTefEstacaoRoteadorMensagens.pas`: removidas as 5 linhas de wiring
  (`FRealInstance.DepoisPassarCartao := ...` etc.) e os 5 procedimentos `pHookDepoisPassarCartao`/
  `pHookDepoisFinalizarTransacao`/`pHookDepoisCancelarTransacao`/`pHookDepoisReimpressao`/
  `pHookSucessoTefCartao` por completo (declaração e corpo — ficaram sem nenhuma chamada).

**Regra para o futuro**: qualquer hook novo (ou qualquer payload grande futuro, ex.: RF10/atualização de
DLL) que precise cruzar o canal deve primeiro responder: o callback do autcom realmente usa o dado que
está sendo enviado, ou esse mesmo dado já chega por outro caminho (resposta RPC do próprio método que
disparou o hook)? Um hook "Depois*" que só sinaliza "terminou" sem decisão nenhuma do autcom é candidato
a ser emulado localmente, do mesmo jeito, em vez de round-trip pelo canal.

**Ainda em aberto (à época)**: a contradição de instrumentação (`Length(Result)` obsoleto) nunca tinha
sido explicada — resolvida logo a seguir, ver seção abaixo.

## CAUSA RAIZ de toda a investigação de "duplicação"/corrupção desta sessão (2026-08-31) — `Result` não zerado em `fProcessaChunkWts`

**Não era o canal, não eram os hooks.** Depois de remover os hooks "Depois*" (seção acima), o problema
persistiu — a resposta RPC de `fPassarCartao` também carrega o `IRetornoTEFCitel` grande (o mesmo dado
que o hook carregava; remover o hook só parou de duplicar o envio, não eliminou o payload grande em si).
Rafael perguntou: "nossa rotina faz alguma fragmentação quando fica além de algum limite de bytes?" —
essa pergunta levou à causa raiz de verdade.

`fProcessaChunkWts` (`libTefCitel\untTefCitelDvcTransporte.pas`) tem múltiplos caminhos que devem
devolver "mensagem incompleta" (`Result` vazio) - o `Exit` do overshoot, e o caminho normal que "cai no
fim da função" sem completar - **nenhum dos dois zerava `Result` explicitamente**, contando com a
inicialização implícita de `Result` em Delphi. Essa inicialização não estava se comportando de forma
confiável aqui: `Result` (que corresponde a `LarrPayload` do lado do chamador, `pLoopLeitura`) ficava
com o CONTEÚDO DA ÚLTIMA MENSAGEM QUE REALMENTE COMPLETOU, e `pLoopLeitura` reenviava esse conteúdo
velho pra `pAcumulaBytesRecebidos` toda vez que um chunk chegava incompleto - que, corretamente,
reconhecia como "duplicado" (porque, byte a byte, ERA a mensagem anterior) e descartava.

**Isso explica TUDO, desde o início desta investigação**: o achado original ("hook `DepoisPassarCartao`
processado 2x no crédito", que deu origem à Fase 1/messageId/CRC) nunca foi o canal replicando nada -
era exatamente este bug. Toda vez que uma mensagem grande vinha em múltiplos chunks WTS, cada chunk
intermediário incompleto reenviava a mensagem ANTERIOR como se fosse nova. O dedup por `messageId` da
Fase 1 mascarou o sintoma (descartando como duplicado em vez de processar 2x); o overshoot/try-except
tratou o CRASH resultante com segurança - mas a causa raiz (a função nunca devolvendo "vazio" de
verdade quando devia) só foi encontrada agora.

**Corrigido**: `Result := nil;` explícito logo na entrada de `fProcessaChunkWts`, garantindo que
qualquer caminho que não atribua `Result` de propósito devolva vazio de verdade, independente de
qualquer comportamento implícito do compilador. Só lado AUTCOM - a estação usa TCP puro, sem essa
função/sem chunking a esse nível.

**Se isso se confirmar em campo**: Fase 1 (dedup)/Fase 2 (ACK+retry)/try-except do overshoot continuam
válidas como camadas de segurança (nenhuma foi removida), mas devem deixar de ser exercitadas no caso
comum - o dado deve fluir limpo já na primeira tentativa, sem "duplicado"/"overshoot" nos logs.

## Validação do início de mensagem em `fProcessaChunkWts` (2026-08-31) — o canal entrega "ruído" no lugar do início real

**Teste seguinte ao fix do `Result := nil` acima**: o fix funcionou (log passou a mostrar
`Length(Result)=0 incompleto` corretamente nos chunks intermediários), mas o crash persistiu com o
mesmo `538976288` (`0x20202020` = 4 bytes `' '` ASCII lidos como inteiro de 32 bits). Desta vez com
prova byte a byte real (não só tamanho): 3 leituras físicas seguidas mostraram o MESMO hex exato
(`20 20 20 20 20 20 20 20 20 20 20 20 20 20 5C 6E`), sempre bem no ponto onde `FdwTotalWtsEsperado`
tinha acabado de voltar a `0` (o lugar onde deveria vir o INÍCIO de uma mensagem nova). Esse conteúdo
não tem cara de início de quadro nosso (tamanho+messageId+CRC+tipo) - é meio de payload (texto de
comprovante, cheio de espaço/`\n` escapado). O header WTS (`totalLength`) vem correto; só o DADO que
acompanha, nessas tentativas, não é o começo de verdade. Quando o chunk certo finalmente chega
(formato correto: tamanho+messageId+CRC+tipo+`{"v`), ele é tratado como CONTINUAÇÃO do lixo acumulado
de uma tentativa anterior, não como reinício - o total bate por coincidência, mas o conteúdo fica
`[lixo] + [dado real]`, e o prefixo de tamanho do NOSSO protocolo cai em cima do lixo.

**Corrigido**: `fProcessaChunkWts` agora valida, especificamente quando `FdwTotalWtsEsperado = 0`
(início de mensagem nova), que os primeiros 4 bytes do DADO do chunk (nosso próprio prefixo de
tamanho embutido) somem `+4` e batam exatamente com o `totalLength` que o header WTS já informou. Se
não bater, o chunk não é um início de verdade - é descartado sozinho (sem acumular, sem setar
`FdwTotalWtsEsperado`), aguardando a próxima leitura trazer o início real.

**Ainda em aberto**: por que o canal entrega esse "ruído" (dado de outro ponto do payload, com header
WTS válido) repetidamente no lugar do início real continua desconhecido - essa validação só evita que
o ruído contamine a remontagem; não impede o canal de continuar entregando ruído indefinidamente (a
mensagem se perderia sem nunca completar, mas sem corromper nada).

## Fragmentação própria (2026-08-31) — nunca mais depender da remontagem multi-chunk do WTS

**O que aconteceu no teste seguinte à validação acima**: no crédito, funcionou (ruído descartado,
mensagem aceita certinho). No débito, o canal entregou só ruído 5 vezes seguidas e NUNCA entregou o
chunk real - a transação travou de vez (sem crash, mas sem progresso, presa em `WaitFor(INFINITE)` do
lado autcom). Essa foi a 6ª tentativa de defesa na mesma camada (dedup, CRC, ACK, overshoot,
`Result:=nil`, validação de início) - critério de "3+ tentativas falharam, questionar a arquitetura"
(`superpowers:systematic-debugging`) claramente atingido. Rafael propôs a saída certa: "partir da
origem com no máximo 1.5K... remontar no destino" - parar de depender da remontagem multi-chunk do
canal (que provou ser genuinamente não confiável neste ambiente para pedaços acima de ~1,6KB) e
remontar usando o PRÓPRIO protocolo de quadro, que já tem tudo que precisa (messageId, CRC, ACK).

**Implementado, nos dois lados** (`untTefCitelDvcTransporte.pas` e `untTefEstacaoTcpTransporte.pas`,
espelhado - qualquer mudança aqui precisa ir para os dois juntos, protocolo incompatível se só um
lado atualizar):
- `TEF_DVC_TAMANHO_MAX_FRAGMENTO`/`TEF_ESTACAO_TAMANHO_MAX_FRAGMENTO = 1400` bytes de payload por
  quadro - margem confortável abaixo do ~1604 observado como teto de 1 chunk físico WTS. Nenhum quadro
  acima disso é mais enviado como um write só.
- Layout do quadro cresceu: `TEF_*_FRAME_METADATA_SIZE` de 9 para 13 bytes - 2 campos novos
  (`numFragmento`, `totalFragmentos`, `Word` cada, 2 bytes) entre `tipo` e o payload. **Protocolo v3**
  - incompatível com o layout anterior, os dois lados precisam recompilar juntos.
- `pEnviaFrame` virou um wrapper: se o payload cabe em `TAMANHO_MAX_FRAGMENTO`, comportamento idêntico
  a sempre (`numFragmento=0, totalFragmentos=1`). Se não cabe, fragmenta e chama `pEnviaUmFragmento`
  (novo - é o antigo corpo de `pEnviaFrame`) uma vez por pedaço, **sequencialmente e ACK-gated**: só
  envia o fragmento seguinte depois que o anterior confirma (ou esgota as tentativas da Fase 2) -
  garante que o receptor sempre veja os fragmentos em ordem, sem precisar de reordenação.
- `pExtraiFramesDisponiveis`: quando `totalFragmentos <= 1`, despacha direto, igual sempre. Quando
  `> 1`, acumula (`FarrPayloadFragmentado`/`FwProximoFragmentoEsperado`) e só chama
  `FOnFrameRecebido` quando o ÚLTIMO fragmento (`numFragmento = totalFragmentos - 1`) chegar. Um
  fragmento fora de ordem é descartado com log, sem mexer na reassemblagem em andamento; uma NOVA
  mensagem fragmentada (`numFragmento=0`) chegando com uma reassemblagem anterior incompleta descarta
  a anterior (mesmo padrão já usado para "mensagem abandonada" no nível WTS).
- Dedup por `messageId` (Fase 1) e ACK+retry (Fase 2) continuam funcionando SEM NENHUMA mudança - cada
  fragmento é só mais um quadro independente pro resto do protocolo (um reenvio por falta de ACK reusa
  o mesmo messageId+CRC do fragmento, dedup já cobre reprocessamento duplo).

**Efeito esperado**: como nenhum quadro de aplicação passa de ~1,4KB, a remontagem multi-chunk do WTS
(`fProcessaChunkWts`'s `FarrPayloadWtsParcial`) deixa de ser exercitada no caso comum - só voltaria a
importar se um dia RF10 (atualização de DLL, ainda não implementada) precisar de payloads que nem a
fragmentação de 1,4KB reduza o suficiente (nesse caso, fragmentação + a remontagem WTS já validada
convivem sem conflito, já que cada fragmento de 1,4KB sempre cabe em 1 chunk WTS de qualquer forma).
Isso deve eliminar a classe inteira de bug perseguida nesta sessão - duplicação, overshoot, ruído no
início - não é mais uma defesa em cima dela, é remover a situação (multi-chunk) que a expõe.

**Se o canal ainda assim corromper um fragmento individual** (mais improvável, cada um é bem menor): o
CRC por quadro já pega isso, e o retry da Fase 2 reenvia só ESSE fragmento pequeno - não a mensagem
inteira.

**CONFIRMADO EM CAMPO (2026-08-31) [framing]**: crédito e débito completos, ponta a ponta, sem nenhum erro. As
duas respostas grandes de `fPassarCartao` (2281 e 2203 bytes) chegaram fragmentadas em exatamente 2
pedaços cada (`fragmento 1/2`/`fragmento 2/2`), remontadas certinho - zero "overshoot"/"ruído do
canal"/"duplicado"/"sem ACK" em todo o log. Só `AntesPassarCartao` apareceu como hook, confirmando que
os hooks "Depois*"/`SucessoTefCartao` de fato pararam de cruzar o canal. **Esta investigação de
framing está encerrada** - a causa raiz real era dupla: `Result` não zerado em `fProcessaChunkWts`
(já corrigido) + dependência da remontagem multi-chunk do canal WTS (eliminada pela fragmentação
própria acima). Pendente, não bloqueante: resto do checklist de aceitação da Fase 3 (Pix, queda de
canal, atualização de DLL RF10) - fora do escopo desta investigação especificamente.

## Evento enfileirado que fica órfão na fila do TThread.Queue (2026-09-03) — drenar a fila antes de `fChamaRpc` retornar

**Sintoma em campo**: numa transação negada, a mensagem com o motivo real da negação
("Cartao Debito / NAO AUTORIZADA", status=500) **não aparecia na transação que a originou** —
aparecia no INÍCIO da transação SEGUINTE, sobre a tela nova. Pior: como é um `fMensagem` MODAL e
estava na FRENTE da closure do hook `AntesPassarCartao` na fila FIFO, prendia o hook até o operador
clicar OK, estourando o `TEF_ESTACAO_TIMEOUT_HOOK_MS` (30s) do lado da estação e derrubando a
transação nova inteira ("Transacao cancelada"/"Erro Desconhecido (-1)").

**Causa raiz (provada com log, 2026-09-03)**: `pTrataEvento` entrega os eventos via `TThread.Queue`
(assíncrono — necessário, ver a seção do deadlock com `Synchronize` acima). Só que essa fila **só é
drenada enquanto a thread principal bombeia**, e ela só bombeia de forma confiável dentro do laço de
espera de `fChamaRpc`. Esse laço saía NA HORA em que o `Evento` era sinalizado, **sem uma última
drenagem** — e o ÚLTIMO evento de uma transação (justamente o status=500 com o motivo da negação)
chega alguns MILISSEGUNDOS ANTES da resposta RPC do próprio `fPassarCartao`:

```
07:30:58.172  pTrataEvento: status="500" "Cartao Debito NAO AUTORIZADA" - enfileirando
07:30:58.182  pTrataResposta: recebido id=3   <-- 10 ms depois; destrava fChamaRpc, para de bombear
              (nenhum pNotifica correspondente - closure ORFA)
07:32:47.116  pNotifica: despachando status="500" ...  <-- 1min49s depois, na transacao SEGUINTE
```

`pNotifica` só enxerga o `FObservers` do momento em que roda — por isso a entrega atrasada vai para o
observer ERRADO (a tela nova). Não era transporte: `AdicionaObserver`/`RemoveObserver` estavam
sempre corretamente pareados (1 observer por vez), e o quadro chegou íntegro e no tempo certo.

**Corrigido** em `libTefCitel\untTefCitelDvc.pas` (só lado autcom — a estação não tem fila de UI):
1. `fChamaRpc` — `CheckSynchronize(0)` uma última vez ao sair do laço de espera, para o evento que
   chegou junto com a resposta ser processado ainda DENTRO da chamada que o originou. Se essa
   drenagem abrir um modal, a thread principal bloqueia ali — comportamento correto: a estação já
   respondeu, nada do pinpad está esperando, e a mensagem aparece exatamente onde deveria.
2. **O guard de método duplicado precisa ser liberado ANTES dessa drenagem** (o `Remove` do
   `FdictMetodosEmAndamento` foi antecipado; o do `finally` continua lá, inofensivo). Sem isso, um
   `status="131"` drenado dispararia `pInfo21` — o padrão da Modalidade Dinâmica, que aparece
   dezenas de vezes em qualquer log — e o guard rejeitaria essa chamada legítima em silêncio.
3. Rede de segurança: `FintGeracaoObservers` incrementa a cada `AdicionaObserver`/`RemoveObserver`;
   `pTrataEvento` captura a geração ao enfileirar e a closure **descarta com log** se rodar em outra
   geração. Cobre o caso de um evento chegar depois da chamada já ter retornado — uma mensagem
   perdida é muito melhor que travar a transação seguinte.

**CONFIRMADO EM CAMPO (2026-09-03)**: 3 transações seguidas (2 débitos negados + 1 crédito aprovado).
O `pNotifica` do status=500 passou a sair no MESMO milissegundo da resposta (`07:54:13.484`) ou até
antes dela (`07:54:49.398` vs `.399`); hook `AntesPassarCartao` respondendo em 47 ms em vez de estourar
30s; crédito completo com Modalidade Dinâmica e resposta de 2203 bytes fragmentada/remontada certinha;
**nenhuma linha `pNotifica: DESCARTADO`** (a drenagem sozinha cobriu todos os casos).

**BATERIA DE ACEITAÇÃO APROVADA (2026-09-03, Rafael)**, rodada logo em seguida, todos os cenários OK:
débito + crédito na mesma venda; débito negado seguido de outro cartão que autoriza (o cenário exato
que originou este bug); cancelamento de transação; desfazimento de transação. Com isso a classe de bug
"mensagem/evento aparecendo na transação errada" está encerrada, junto com a de framing (seção acima).

**Regra para o futuro**: qualquer coisa entregue à thread principal por `TThread.Queue` neste
subsistema é entregue "quando der" — e o "quando der" depende de alguém estar bombeando. Se o dado
tem dono (uma tela, uma transação), ou ele é drenado antes do dono sair de cena, ou precisa carregar
alguma marca de a quem pertence. Não confiar em ordem/tempo de entrega da fila.

## `pEnviaAck` sem lock cobrindo atribuição de messageId + envio (2026-09-02, corrigido por consistência)

`pEnviaAck` (nos DOIS lados, `untTefCitelDvcTransporte.pas` e `untTefEstacaoTcpTransporte.pas`) tinha
o mesmo gap já corrigido em `pEnviaUmFragmento`: `TInterlocked.Increment` e `pEnviaFrameBruto` como
passos separados, sem lock cobrindo os dois juntos. Roda na thread de LEITURA (ACK de todo quadro
DADO recebido), concorrente com a thread que despacha o método — se pegar o messageId e for
preemptada antes de enviar, o ACK atrasado chega depois de um id maior já aceito e é descartado como
"duplicado" (visto em campo: `quadro duplicado descartado (messageId=73, ultimo aceito=74)`).

**Corrigido** com `FcsEscrita` cobrindo os dois passos, igual a `pEnviaUmFragmento`. **Atenção para
não induzir a erro**: perder/reordenar um ACK é benigno por si só (o remetente reenvia o quadro DADO,
o receptor deduplica e reenvia o ACK). Este fix **não era** a causa da trava investigada naquele dia —
a causa real é a da seção anterior (evento órfão na fila), e só foi encontrada no dia seguinte.

## `fConfiguraTefCitel` nativo carrega um confirm embutido (2026-09-08) — nunca chamá-lo com outro AUTCOM detendo o pinpad

**A regra:** nenhum caminho do serviço pode chamar `fConfiguraTefCitel` na DLL nativa enquanto outro AUTCOM vivo da estação estiver com o pinpad — transação em voo ou pendência de confirmação.

**Por quê.** `fConfiguraTefCitel` não é uma função de configuração inofensiva. Com `somenteCarregarLib=False` ela termina assim (`untTefCitelNCR.pas:618`):

| Linha | O que faz |
|---|---|
| 629–631 | grava `FstrEmpresa` / `FstrFilial` / `FstrPdv` — globais de unit, compartilhadas por todas as instâncias |
| 663 | `AbreSessaoTEF(True)` — **não faz nada** se `INI_SESSAO` já estiver setado (`untScopeNCR.pas:1025`) |
| **685** | **`FechaSessaoTEF(1, 1)`** = `SCO_CONFIRMA_TEF` com `bForcar=1`. A guarda de `untScopeNCR.pas:890` passa pelo `bForcar`, e o `ScopeFechaSessaoTEF(1, …)` **confirma a transação pendente na sessão global** |
| 688 | `FintSinc := 0` — apaga `INI_SESSAO`/`INI_COMUNIC`, **fora** do `if not blnSomenteCarregarLib` |

`FechaSessaoTEF` não recebe identificador de transação e a sessão Scope é uma só por processo (`FintSinc`/`FstrEmpresa`/`FstrFilial`/`FstrPdv` são globais de unit, `untScopeNCR.pas:474`). No mundo de um AUTCOM por processo a linha 685 é limpeza de sobra de execução anterior travada — legítima. Sob DVC, com os dois AUTCOM no mesmo processo, ela vira confirmação da transação alheia.

**Comprovado em campo (2026-09-08).** AUTCOM A (term. 003, pid 71824) autorizou o `Controle 09804893005` às 08:17:51 e não finalizou. O login do AUTCOM B (term. 004, pid 86276) às 08:18:40 confirmou a transação do A. O tempo denuncia: **1,25 s** no login do B contra **4,4 s** no do A — a diferença é o `AbreSCOPE` que não rodou, sobrando só o confirm.

**Os dois caminhos e como cada um está fechado:**

| Caminho | Guarda |
|---|---|
| Reaplicação (`pGarantePinpadConfigurado`) | `pRecusaSePendenciaDeAutcomVivo` roda **antes** da reaplicação (RF17 itens 1 e 2) |
| Login (`fMetodoFConfiguraTefCitel`) | **RF17 item 4** — login adiado: `fOutroAutcomDetemPinpad` no topo, a DLL não é tocada, responde 0 |

**Login adiado, em detalhe.** Recusar o login não é opção — o AUTCOM precisa subir com o TEF habilitado. Então o serviço guarda os argumentos em `FstrCfg*`, marca `FblnCfgRecebida`, **não** mexe em `FstrConfigAplicada`/`FdwPidConfigAplicada` (a DLL de fato continua do detentor) e responde `valor = 0`. A configuração real entra na primeira chamada de pinpad, pela reaplicação — que enquanto o detentor não resolver é recusada pelo item 2, o comportamento desejado.

**Não trocar por `somenteCarregarLib=True`.** Reduz o dano mas não zera: as linhas 629–631 ainda sobrescrevem loja/filial/PDV com os do AUTCOM novo, e a linha 688 está fora do `if` — apagaria `INI_SESSAO`/`INI_COMUNIC` com a sessão Scope do detentor genuinamente aberta, e a próxima chamada do detentor reabriria sessão com a loja/PDV errados.

**`FcsPinpad` cobre o método inteiro.** Até 2026-09-08 ele só era tomado na escrituração do final de `fMetodoFConfiguraTefCitel`: dois logins simultâneos, ou um login concorrente com a reaplicação, entravam na DLL nativa sem serialização. Ordem obrigatória: `FcsPinpad` → `FcsTransacao`/`FcsInstancia`, a mesma de `pGarantePinpadConfigurado`. Nenhuma seção de `FcsInstancia` pode tomar `FcsPinpad`.

**Como verificar numa regressão:** o login do segundo AUTCOM tem que cair para o tempo de um `fLoadDLLFunctions` (bem abaixo de 1 s), aparecer no log como `ADIADO`, e o Controle do detentor tem que continuar **não confirmado** no adquirente até ele mesmo finalizar.

## A marca de pendência tem que olhar o retorno, não o nome do método (2026-09-08)

**A regra:** só marca transação pendente de confirmação quando `fPassarCartao` / `fCancelaTransacaoTerminal` devolvem **retorno preenchido**. Sem retorno, a marca **não é tocada** — nem posta, nem limpada.

**Por que não basta o nome do método.** `untTefCitelNCR.pas:1720` inicia `Result := Nil` e só atribui `Result := FRetorno` na linha 1834, dentro do `else` de `if LintRet <> SCO_SUCESSO`. `fCancelaTransacaoTerminal` (`:484`) segue o mesmo padrão. Ou seja: **retorno preenchido é sinônimo de transação autorizada**. Negativa do adquirente, cancelamento no pinpad e aborto antes de transacionar devolvem nil — e cada um desses caminhos já desfez a sessão sozinho com `FechaSessaoTEF(SCO_DESFAZ_TEF)` (`:1814` e mais cinco pontos). Não há o que confirmar.

**O que a marca incondicional causava.** O AUTCOM **não** chama `fFinalizarTransacao` depois de uma negativa — comprovado duas vezes no log de 2026-09-08: negativa às 09:29:06 seguida direto de outro `fPassarCartao` às 09:29:11, e negativa às 09:31:24 seguida de `fPassarCartao` às 09:32:11. Com a marca posta pelo nome do método, ela ficava presa em `True` até o AUTCOM fechar, e as RF17 itens 2 e 4 passavam a bloquear o outro AUTCOM da estação. **Um cartão negado no terminal 003 travava o 004.** O aviso RN09 de `pOrfanaSessao` também disparava em falso — no log das 09:33:35 ele acusou pendência de um `fPassarCartao` que tinha sido **cancelado** no pinpad.

**Por que não limpar a marca quando o retorno vem nil.** Existe um caso real que depende de não limpar: no fluxo de **múltiplos cartões** o nativo pula o `DESFAZ` de propósito quando já havia sessão aberta (`FblnMultCartoes`, `:1781` e `:1813`), justamente porque o cartão **anterior** continua pendente. Nesse cenário o primeiro cartão já marcou `True` e o segundo, que falhou, tem que deixar a marca como está. Errar para o lado de não marcar é o lado perigoso; errar para o lado de marcar demais só trava a estação.

**Como verificar numa regressão:** passar um cartão que seja negado no terminal 003 e, **sem fechar o AUTCOM 003**, transacionar no 004. Tem que passar. No log do serviço a linha `voltou SEM retorno (negativa, cancelamento ou aborto...) - marca de pendencia NAO alterada` aparece no lugar da marca.

### Correção da regra acima (mesmo dia, 2026-09-08): só o `fPassarCartao` marca

A regra anterior — "marca quando devolve retorno preenchido" — estava **incompleta**. O critério correto é **"devolveu retorno DEIXANDO A SESSÃO ABERTA"**:

| Método | No caminho de sucesso | Marca pendência? |
|---|---|---|
| `fPassarCartao` (`untTefCitelNCR.pas:1834`) | `Result := FRetorno`, **sem** `FechaSessaoTEF` | **sim** |
| `fCancelaTransacaoTerminal` (`:576`) | `FechaSessaoTEF(SCO_CONFIRMA_TEF)` e **só então** `Result := FRetorno` | **não** — já confirmado |
| `fReimpressao` | idem cancelamento | **não** |

**A confirmação de que isso está certo vem do próprio AUTCOM:** `TfrmTefCitelAdministracao` (a tela "Administração do TEF") chama `fCancelamentoNormal` e, no sucesso, só exibe "Transação cancelada com sucesso!" — a unit **não tem uma única referência** a `fFinalizarTransacao`. Ela não precisa: o nativo já confirmou.

**O que a versão incompleta causava.** Um cancelamento **bem-sucedido** no AUTCOM A marcava pendência que ninguém iria limpar, e o AUTCOM B ficava travado até o A fechar. Visto em campo em 2026-09-08: o pid 118320 (terminal 004) cancelou com sucesso às 10:33:39 (`Controle 09802524008`), e às 10:33:58 o pid 93852 (terminal 003) foi recusado ao tentar cancelar a própria transação dele. Só liberou quando o AUTCOM 004 fechou, às 10:34:33.

**A lição, que vale além deste ponto:** a pergunta certa nunca foi "esta chamada gera transação?" e sim "esta chamada deixa a sessão Scope aberta esperando confirmação?". Os três métodos devolvem `IRetornoTEFCitel` no sucesso; só um deles deixa pendência. Qualquer método novo que entre nessa lista precisa ser lido até o `FechaSessaoTEF` antes de decidir.
## Sessão, log e detecção de reinício — quatro invariantes do Passo 7/8 (2026-09-10)

**Procedencia:** as duas primeiras vieram de achado de campo em 10/09 e estão **validadas**; as
duas últimas são do Passo 8, **implementadas e ainda não validadas em campo** — estão aqui
porque são invariantes de quem for mexer no código, não afirmações sobre comportamento medido.

### 1. `FdictSessoes.Count` NÃO significa "alguém ativo" (validado)

Depois da RF24, sessão de autcom que fecha **normalmente** fica `DESANEXADA` **dentro** do
`FdictSessoes`, sem conexão, esperando o mesmo processo voltar. A RF28 coleta **órfãs**, que é
outra lista (`FlstOrfas`). Consequência medida em campo (10/09, 14:53): **11 sessões no
dicionário com um autcom ativo**, e o número só volta a 1 quando o serviço reinicia.

**Regra:** qualquer guarda que queira dizer *"ninguém está usando o pinpad/a DLL"* tem que olhar
**sessões anexadas** (`FConexaoAtual <> nil`) ou as threads de despacho
(`LlstEmUso`/`FdictSessaoPorThread`), **nunca a contagem do dicionário**. Esta é a **terceira**
guarda do `fColetaOrfas` a cair pelo mesmo motivo neste requisito — as duas primeiras mediam
*"eu estou ocupado"* querendo dizer *"outro está ocupado"* (contagem de threads e transação em
voo). O padrão é sempre o mesmo: **a guarda não mudou, o significado do que ela media mudou
debaixo dela**, quando outra regra alterou o ciclo de vida do que ela contava.

### 2. Reinício do serviço NÃO derruba o canal DVC (validado, por leitura de código e por campo)

O plugin cliente reconecta o socket TCP sozinho (`pLoopConectorELeitura`,
`untTefCitelDvcPluginImpl.pas`) e **nunca toca no `FChannel`**. Então:

| O que caiu | O canal DVC cai? | O autcom manda `reata`? |
|---|---|---|
| Sessão de TS oscilou | **sim** | sim — e aí a troca de instância é comparada |
| Somente o serviço reiniciou | **não** | **não** |

**Regra:** nenhum mecanismo pode usar "o canal caiu" como sinônimo de "o serviço reiniciou", nem
o contrário. São eventos independentes, e o segundo não implica o primeiro. Foi por essa
premissa que a detecção original da RF29 — que escolheu a resposta do `reata` como gatilho —
nasceu com uma lacuna.

**Terceira consequência, achada em campo em 2026-09-11 às 08:24:57:** quem estava **em voo**
durante o reinício nunca recebe resposta — a instância nova não conhece id nenhum da antiga — e
como o canal não cai, `pOnDesconectado` não roda para resolver as pendentes. Ver a seção
*"Reinício do serviço: TRÊS coisas…"* no fim deste arquivo.

**Segunda consequência, achada em campo em 2026-09-11 e mais grave que a primeira:** essa
independência também quebra o dedup do transporte, porque os dois lados zeram o contador de
`messageId` em escopos diferentes. Ver a seção *"O escopo em que o `messageId` é monotônico…"*
no fim deste arquivo. Sempre que aparecer um mecanismo que dependa de "estado zerado dos dois
lados", conferir **os dois** gatilhos de reset, não um.

### 3. O núcleo do log está TRIPLICADO, e as três cópias leem o mesmo `.ini` (Passo 8)

`libTefCitel\Estacao\untTefEstacaoLog.pas` (serviço), `untTefCitelDvcPluginImpl.pas` (plugin) e
`untTefCitelDvcTransporte.pas` (autcom) têm **cópia própria** do mesmo núcleo de log: nível,
rotação por tamanho, leitura do `.ini` e carimbo por `GetLocalTime`. É a mesma decisão já tomada
para o `fCrc32` e pelo mesmo motivo — os três `.dproj` têm search path diferente e não
compartilham unit.

**Regra:** mudança numa cópia precisa ser replicada nas **três na mesma sessão/commit**. Como as
três leem um `TefCitelDvcLog.ini` com a **mesma seção e as mesmas chaves** (`[Log]`: `Nivel`,
`TamanhoMaxMB`, `Arquivos`, `Pasta`), divergir faz os processos se comportarem diferente diante
do mesmo arquivo de configuração — e isso aparece como "o log de um lado sumiu", não como erro.

Três detalhes desse núcleo que **não** são arbitrários:

- **O `.ini` é lido uma vez por processo e fica em cache.** Ler a cada linha poria uma abertura
  de arquivo extra no caminho de toda chamada TEF, e este subsistema já teve corrupção de heap
  por chamada concorrente intensa de log (o "Bug 6", seção própria acima). Mudar o `.ini` exige
  reiniciar o processo, e isso está escrito no comentário do próprio arquivo gerado.
- **O tamanho é conferido pelo caminho, não pelo handle.** O handle do log é aberto só com
  `FILE_APPEND_DATA` e `GetFileSize` exige direito de leitura; `GetFileAttributesEx` não tem essa
  restrição.
- **A rotação é best effort de propósito.** A seção crítica serializa as threads de **um**
  processo, e no lado autcom os **dois** autcom.exe de uma sessão TS gravam no mesmo arquivo (é
  para isso que existe o `pid=` no prefixo). Um `MoveFile` falha enquanto o outro processo tem o
  handle de append aberto — e falhar ali só deixa o arquivo passar do teto por algumas linhas,
  sem perder linha gravada nem corromper nada. **Não "consertar" isso com mutex nomeado** sem um
  motivo novo.

**Nível 2 (diagnóstico) é modo de investigação, não de operação.** Ele restabelece exatamente o
volume de chamada de log que expôs o "Bug 6". O `FcsLog` corrigiu a falta de lock, mas ligar
nível 2 em produção é decisão consciente e temporária.

**Mensagem cara precisa de guarda antes de ser montada.** `fLogDvcAtivo(nivel)` /
`fLogEstacaoAtivo(nivel)` existem para isso: o argumento de um `Format` é avaliado **antes** da
chamada, então um hex dump ou um JSON inteiro custa o mesmo com o log desligado se não houver
guarda. Onde há cópia de buffer envolvida (o hex dump de chunk em `fProcessaChunkWts`), a guarda
tem que vir **antes do `SetLength`/`Move`**, não antes só do log.

### 4. Dois detectores para o mesmo desfecho, nunca duas implementações (Passo 8)

O re-login automático do autcom tem **dois gatilhos**: a resposta do `reata` (RF29 original,
oscilação de TS) e a recusa `motivo="loginNecessario"` da estação na chamada normal (Passo 8,
reinício puro do serviço). Os dois ligam a **mesma** flag (`FintServicoReiniciou`) e chamam o
**mesmo** método (`pRefazTefSeServicoReiniciou`).

**Regra:** um gatilho novo para esse desfecho entra ligando a flag, **nunca** escrevendo um
caminho de re-login próprio. Aquele método carrega quatro guardas que já foram pensadas uma vez
— a própria chamada de login não se reaplica, não há reentrância (`FblnRelogando`), sem
argumentos guardados ele só registra e sai, e um re-login que falhe **não derruba a chamada
real**. Um caminho paralelo perderia todas as quatro, uma por uma.

**E o campo `motivo` é a forma de distinguir recusa, não o texto da mensagem.** Já há dois usos
(`pinpadContestavel`, `loginNecessario`) e a propriedade que faz o esquema funcionar é o campo
**só ir quando existe**: um lado que não conheça o motivo cai no comportamento anterior, com a
mensagem acionável de sempre. Recusa nova segue o mesmo padrão — classe de exceção própria do
lado estação, `motivo` no envelope, classe correspondente do lado autcom — e **jamais**
comparação de `E.Message`.
## O log é a vítima, não o culpado — e a causa do "Bug 6" nunca foi provada (2026-09-10)

**Achado de campo, AV às 17:13:37 no `autcom.exe` pid=80288**, na queda de sessão TS, dentro de
`pLogaDiagnosticoDvcNivel`. Três exceções aninhadas; a primeira é um `@LStrSetLength` lendo
`C00000A8`, na linha do carimbo de tempo (`AnsiString(Format(...))`). **O heap de strings já
estava corrompido quando a função rodou.** O outro AUTCOM da mesma sessão passou pela mesma
queda 28 ms antes, logou a mesma linha e não estourou.

**Isto corrige o registro de 2026-08-28.** A causa atribuída ao "Bug 6" — `FormatDateTime` e o
locale global da RTL — **nunca foi provada**: naquela sessão tirou-se o `FormatDateTime` **e**
tirou-se o log incondicional de `pAcumulaBytesRecebidos`, que era o de maior frequência, ao mesmo
tempo. O volume caiu junto, e o crash sumiu. Em 2026-09-10 o volume voltou (`Nivel=2`, ~5× mais
chamadas) e o crash voltou **com a mesma assinatura e sem `FormatDateTime` em lugar nenhum do
caminho**. O que discrimina é **volume de alocação**.

**Regra:** neste subsistema, um AV dentro de uma operação de string na função de log **não é
diagnóstico da função de log**. Ela é a maior alocadora da thread de leitura, então é onde
corrupção de heap de qualquer origem aparece primeiro. Antes de acusar a função, perguntar: o
que mudou no **volume**? E não declarar causa resolvida quando duas coisas mudaram na mesma
sessão — foi exatamente isso que deixou o "Bug 6" com uma causa errada no registro por 13 dias.

**Mitigação aplicada (decisão do Rafael, 2026-09-10):** o caminho quente do log do **lado autcom**
não aloca mais nada — carimbo, prefixo e mensagem são escritos dígito por dígito num buffer de
pilha de 4 KB, o caminho do arquivo é montado uma vez por processo, e a escrita sai direto do
buffer. **Não conserta a corrupção** — ela existe com ou sem o log — e **não cobre o `Format` do
CHAMADOR**, que monta o texto da mensagem e continua alocando. O que se ganha é tirar a thread de
leitura do canal de cima do problema.

**As cópias do plugin e do serviço NÃO receberam a mudança, de propósito**, e isso não viola a
regra de replicar as três: o que a regra exige igual é o **contrato do `.ini`** (seção, chaves,
semântica de nível e rotação), e ele continua idêntico. Nenhum dos dois crashou, os dois são
processos pequenos, e nenhum divide o gerenciador de memória com um `autcom.exe` de 445 MB com
ShareMem/BORLNDMM e DLLs de terceiro.

## O que a instrumentação do ACK provou — e o que ela refutou (2026-09-10)

O `Nivel=2` respondeu o item 1 do Passo 8 em uma bateria. Os dois resultados importam, e o segundo
é contra a hipótese que estava escrita no código.

**CONFIRMADO — toda escrita nossa aborta a leitura pendente.** Dezenas de ocorrências com a mesma
assinatura: `leitura encerrada em 47 ms com erro 996 ... escritas NOSSAS: 1`, sempre muito abaixo
do timeout de 15000 ms. O mecanismo descrito no comentário de `pLoopLeitura` desde 2026-09-04
passou de inferido a **medido**.

**REFUTADO — esse aborto não atrasa o ACK.** Em **todas** essas ocorrências a leitura seguinte traz
o ACK em **0–16 ms** (`ACK do messageId=N confirmado em 15 ms (tentativa 1/5)`, mais de cem vezes).
A leitura reinicia na hora. **A cadeia "cada retransmissão aborta a leitura que traria o ACK, daí os
9 s" está errada.**

**Consequência de plano:** o conserto que essa hipótese sugeria — **uma thread única dona do
handle**, leitura com timeout curto e fila FIFO de escrita no mesmo laço — atacaria um mecanismo
**benigno**. Não fazer. Era um refactor no coração do transporte já validado em campo, sem ganho.

**O que sobrou, e está fora do nosso código:**

1. **Latência de entrega.** A resposta do `reata` levou 3875 / 4657 / 4860 ms para ser lida nas três
   reconexões, com **`escritas NOSSAS: 0`** no intervalo. Sem nenhuma escrita nossa interferindo.
   Isto reabre o que a análise de 10/09 de manhã havia descartado (*"não é latência de entrega, é a
   leitura que fica retida"*) — aquela conclusão estava errada.
2. **O canal trunca uma mensagem WTS.** `fProcessaChunkWts: mensagem anterior abandonada
   (totalLength=60, so chegou 21 bytes)` — 21 de 60 bytes entregues, resto nunca chegou. Foi a
   **única** retransmissão da bateria, e as defesas funcionaram: a estação reenviou e o quadro
   entrou como `quadro ATRASADO aceito`. No mesmo instante a estação também perdeu o nosso ACK — o
   canal perdeu bytes **nos dois sentidos** naquela janela.

**A margem de 1,03× não reproduziu.** Em ~20 minutos, 3 quedas de TS e 6 transações de cartão:
**uma** retransmissão. O receio registrado — "o log passaria a acusar entrega não confirmada em
toda reconexão" — não se materializou. A margem segue **observada, não explicada**, e agora com
mais razão para a spec dizer exatamente isso.

## O escopo em que o `messageId` é monotônico não é o mesmo nos dois lados (2026-09-11)

Achado de campo 2026-09-11, log das 07:35:55 e 07:36:31: **duas transações travadas na tela, sem
erro nenhum em log nenhum.** O item 3 (RF29) havia disparado corretamente do lado da estação —
`motivo="loginNecessario"` nas duas — e a resposta **nunca chegou ao autcom**: foi descartada pelo
dedup do transporte, uma camada abaixo de onde o item 3 mora.

| Lado | O contador zera | Onde está escrito |
|---|---|---|
| Estação | **por conexão TCP** | `TTefEstacaoConexao.Create` — `FintProximoMessageId := 0` |
| AUTCOM | **por canal DVC** | `pZeraEstadoDoCanal` |

Um canal DVC sobrevive a **N** conexões da estação: o plugin tem um socket **por canal**
(`FsckEstacao` é campo de `TTefCitelDvcCanalCallback`) e o reconecta sozinho — *"Socket
desconectado do TefEstacaoService.exe - tentando reconectar"* — **sem tocar no canal**. Os dois
comentários de código estavam certos, cada um no seu escopo, e é justamente por isso que ninguém
viu: eles descrevem invariantes diferentes com a mesma frase.

**Por que nunca apareceu nas quedas de TS.** Nelas o mstsc morre, o plugin morre e o socket cai
junto: os dois contadores zeram ao mesmo tempo. Simétrico. Cinco quedas de TS nesta mesma bateria
passaram limpas. **O reinício do serviço é o caso assimétrico** — o canal fica de pé, a estação
volta numerando de 1, e o dedup do autcom já tem esses ids.

**O agravante é o ACK.** O caminho do descarte reenvia o ACK (certo para duplicata de verdade: o
emissor pode estar retransmitindo porque o ACK se perdeu). Aqui isso faz a estação considerar
**entregue** e nunca retransmitir. Perda **silenciosa**, nos dois lados, e como esta regra proíbe
timeout artificial sobre tempo de pinpad, a chamada síncrona fica presa **para sempre** — a única
saída é matar o autcom.

Janela do defeito = maior id aceito na época anterior: **2** num autcom, **14** no outro. Mas o
tamanho quase não importa: a primeira resposta depois do reinício é exatamente a que cai.

### O conserto (2026-09-11): idade do aceite como discriminador

`fAceitaMessageId` passou a guardar o `GetTickCount` de cada id aceito (o valor do
`FdictIdsAceitos` era um `Boolean` sem uso). Id repetido **dentro** de
`TEF_DVC_DEDUP_EPOCA_MS` = retransmissão legítima, descarta como antes; **acima** = o outro lado
zerou o contador, então esvazia o dedup e **aceita** o quadro. A constante é derivada do orçamento
do ACK (`3 × TEF_DVC_ACK_MAX_TENTATIVAS × TEF_DVC_ACK_TIMEOUT_MS` = 30 s) de propósito — se o
orçamento mudar, o prazo acompanha.

Três coisas que não são óbvias no diff:

1. **A marca d'água `FdwUltimoIdRecebido` também volta a zero.** Sem isso todo quadro da época
   nova sairia como `quadro ATRASADO aceito` contra a marca velha — falsa evidência de perda no
   canal, justamente a linha que existe para provar o contrário.
2. **O contador de SAÍDA (`FintProximoMessageId`) NÃO é zerado.** O dedup do outro lado acabou de
   nascer vazio e aceita nossos ids altos. Zerar criaria a colisão espelhada.
3. **Só o autcom precisa do conserto.** O espelho não existe: o canal DVC não cai sem o socket
   cair com ele, então nunca há época nova no sentido autcom → estação.

### A linha de log que faltava, e que custou a leitura

Os nove descartes benignos da bateria e os dois fatais saíram com **texto idêntico** — só a hora
da chamada que acabara de sair os separou. A linha agora diz **há quantos ms** o id colidente foi
aceito, e o caso de época nova tem linha própria em nível normal. Regra: **todo descarte silencioso
tem que registrar o que o discrimina de um descarte legítimo**, senão a produção não distingue e
a próxima leitura é feita à mão outra vez.

## Reinício do serviço: TRÊS coisas têm que acontecer, não uma (2026-09-11)

A RF29 nasceu pedindo "detectar o reinício e refazer o login". A bateria de 2026-09-11 (08:18–08:29)
mostrou que isso é **um terço** do trabalho. Num reinício puro — o canal DVC de pé, o socket do
plugin reconectando — o autcom precisa de três desfechos independentes, e cada um falhava por conta
própria:

| # | O que precisa acontecer | Quem faz | Faltava porque |
|---|---|---|---|
| 1 | A resposta da estação **chegar** | dedup do transporte | escopo do `messageId` diferente nos dois lados (corrigido 11/09 08:08) |
| 2 | O login ser **refeito** | `fChamaRpc` ← `motivo="loginNecessario"` | a guarda da estação era **condicional** (corrigido 11/09 08:45) |
| 3 | As chamadas **em voo** morrerem | `pRefazTefSeServicoReiniciou` | ninguém resolvia `FdictChamadas` (corrigido 11/09 08:45) |

Faltar **qualquer** um deixa a tela presa, e os três produzem sintomas parecidos. Se aparecer
"transação parada na tela" depois de um reinício, conferir os três, nesta ordem.

### 3 — A chamada em voo (a tela que não fecha)

`fPassarCartao` saiu às 08:24:57 e estava **dentro da DLL nativa** quando o serviço parou às
08:25:25. `pOnDesconectado` — o único lugar que resolvia pendentes — só roda na queda do canal, e o
canal não caiu. Resultado: a chamada ficou pendente para sempre, e como o `pSair` do operador entra
**aninhado** nela, fechar a tela nunca termina. Foram **oito** `pSair` (id=10 a 17), todos
respondidos com sucesso pela estação, com a chamada de fora presa embaixo.

**O `reata` é o mecanismo desenhado exatamente para resolver id em voo — e é o que não acontece no
reinício puro.** Toda vez que um mecanismo desta migração depender do `reata`, perguntar o que
acontece quando ele não sai.

O conserto reusa o caminho validado em vez de criar outro: `ErroCanal := True` →
`ETefCitelDvcCanal` → `pNotificaCanalCaiu` → negativa 500, retorno vazio, callback `Depois*`,
**LCKATC liberada de graça**. O corpo saiu de `pOnDesconectado` para `fMataChamadasPendentes`
quando apareceu o segundo chamador. Vem **antes** do re-login: a tela não espera os ~5 s do
`fConfiguraTefCitel` nativo.

### 2 — A guarda condicional, e a loteria pela ordem das chamadas

`pGarantePinpadConfigurado` recusava por falta de login **só quando `FstrConfigAplicada = ''`**.
Com dois autcom, o reinício virava loteria pela ordem:

1. o **primeiro** a chamar era recusado (nada aplicado na DLL ainda), refazia o login e
   **preenchia** `FstrConfigAplicada`;
2. o **segundo** já achava configuração lá, caía no ramo *"seguindo com a configuração atual da
   DLL"* e era despachado com o terminal do primeiro → **erro 64004 do Scope**.

Em campo: `pid=86700` despachado com o terminal `"004"` do `pid=88584`, e
`sessao do pid=86700 (terminal="")` no desligamento — a sessão nunca teve configuração.

**O código já sabia.** O comentário da RF17 item 3 registra que aproveitar a impressão digital sem
o login *da instância* dá exatamente 64004 (campo, 2026-09-09 17:28:50). O ramo emprestado era a
mesma falha pelo outro caminho, e era também por onde passava o AV de 2026-09-09.

A recusa passou a ser incondicional. **Não atinge o login adiado (RF17 item 4):**
`FblnCfgRecebida` é marcado no **topo** de `fMetodoFConfiguraTefCitel`, antes de qualquer decisão de
adiar — a sessão adiada chega com `True`. `FblnCfgRecebida = False` significa uma coisa só: *esta
sessão nunca mandou login*. Essa foi a verificação que autorizou apertar uma guarda validada em
campo, e é o tipo de checagem que precisa ser feita antes, não depois.

**Terceiro caso do padrão "guarda boa escondida atrás de uma ruim"** neste requisito (os outros:
2026-09-09 17:08 e 2026-09-10 10:09). Em todos, a guarda certa existia e uma condição a mais na
frente dela decidia o resultado.

## Descarregar a DLL nativa é sempre por último, e nunca sem contar quem está dentro (2026-09-11)

Terceiro AV desta migração com a mesma assinatura — **ponteiro nulo depois do `UnLoadDLLFunctions`** —
e o terceiro gatilho diferente:

| Quando | Quem descarregou | Registro |
|---|---|---|
| 2026-09-09 08:58 | `pColetaOrfasSeOcioso` destruindo instâncias órfãs | AV em `00000000`, causa raiz no comentário daquele método |
| 2026-09-11 08:26 | *(não foi AV)* a estação **emprestou** a configuração de outro autcom | erro 64004 do Scope |
| 2026-09-11 09:21 | `ServiceStop` → `Destroy` → `FlstTodasSessoes.Free` | `Metodo "fPassarCartao" (id=21) lancou excecao: Access violation at address 00000000` |

```
09:21:41.464  pOnDesconectado: o pid=163036 caiu com a chamada id=21 EM VOO no pinpad
09:21:41.468  ServiceStop concluido.
09:21:41.468  Metodo "fPassarCartao" (id=21) lancou excecao: Access violation at address 00000000
```

**Regra:** nenhum caminho pode liberar uma `ITefCitel` sem antes garantir que **nenhuma thread de
despacho está dentro da DLL nativa**. O indicador exato é `FdictConexaoPorThread.Count` —
`pOnFrameRecebido` registra a thread antes de despachar e baixa num `finally`, então o `Count` é
literalmente "quantos despachos estão dentro da DLL agora". Quem for escrever um caminho novo de
teardown ou de coleta consulta esse `Count`, não presume.

É **corrida, não certeza**: na outra parada com chamada em voo da mesma bateria (09:25:44, id=31) o
processo saiu antes de a thread acordar e não houve AV. Por isso o defeito sobreviveu tanto tempo.

### O conserto: `pParaComSeguranca`, e por que a ordem é essa

1. **Aborta** a transação em voo pelo `pSair(True)` — o mesmo caminho do aborto por queda de
   conexão, cujo veredito de segurança já está escrito ali. Sem isso a espera duraria o tempo do
   pinpad.
2. **Espera** o `Count` chegar a zero, com teto de 10 s (`TEF_ESTACAO_PARADA_TETO_MS`).
3. **Antes do `FTransporte.Free`**, e este é o ponto que não é óbvio: com o transporte de pé a
   thread que termina ainda **entrega a resposta** ao autcom, ou a persiste na fila local (que só é
   liberada no fim do `Destroy`). Esperar *depois* do `Free` reproduziria o bug por outro caminho —
   a resposta sairia por cima de um transporte destruído.

O teto **não** viola a regra do topo deste arquivo: o serviço está parando, a transação acabou de
receber o aborto, e passado o teto o teardown segue de qualquer forma. Ninguém fica esperando
pinpad — o oposto do que havia antes, que era não esperar nada.

Quando o teto estoura, a linha `pParaComSeguranca: ATENCAO - N despacho(s) ainda dentro da DLL` sai
**antes** do AV. Um AV solto vira um AV com causa nomeada uma linha acima.

## Aviso ao operador não pode depender de haver tela aberta (2026-09-11)

`pNotificaNegativa` entrega aos observers **atuais**, e isso é o certo para a negativa de uma
chamada: ela pertence à chamada que está voltando agora, e entregá-la depois seria mensagem velha
em tela nova. Mas há avisos que falam de uma operação **anterior**, e esses não podem depender de
quem está na tela agora:

```
09:31:27.796  pNotifica: despachando status="500" mensagem="O servico de TEF da estacao foi
              reiniciado..." para 0 observer(es).
```

O re-login da RF29 é disparado pelo **primeiro método** que chega depois do reinício — e esse
método pode ser um `fFinalizarTransacao` no fecho da venda, depois de a tela já ter feito
`RemoveObserver`. O aviso evaporou exatamente no caso em que mais importava: o Controle
**09102834016** ficou pendente no servidor do TEF (conferido no relatório) e o operador não soube.

**Regra:** aviso sobre operação anterior usa `pAvisaOperadorOuGuarda` — entrega se houver tela,
guarda se não houver, e o próximo `AdicionaObserver` despacha. Negativa de chamada em curso
continua com `pNotificaNegativa`; não unificar os dois, porque o desfecho certo é diferente.

Três detalhes que o diff não entrega:

1. **O prefixo "Aviso da operação anterior:" não é enfeite.** A mensagem aparece numa tela que o
   operador abriu depois; sem o prefixo ela pareceria falar da operação atual.
2. **`TThread.Queue`, não entrega direta.** Despachar de dentro do `AdicionaObserver` reentraria na
   tela enquanto ela ainda se registra, e status 500 abre caixa de mensagem. Mesma razão do
   `pTrataEvento` — e o gatilho fica **depois** do `Add`, para o aviso encontrar o observer novo.
3. **Se a tela sair antes de a fila rodar, o aviso é guardado de novo.** Não há laço: só um
   `AdicionaObserver` novo reenfileira.

### O desfecho pendente é correto — o defeito era só a informação

Decisão do Rafael em 2026-09-11, e ela vale como regra de leitura: **transação que fica pendente
depois de um reinício do serviço não é falha.** A sessão Scope morreu com o processo antigo, alguém
efetiva depois, e o autcom segue a venda até o fim. O que era defeito é o protocolo responder
"confirmei" (31 ms, contra 1654 e 1628 ms das confirmações reais da mesma bateria) e ninguém
avisar.

**E por que não consertar recusando do lado da estação:** `fFinalizarTransacao` é `procedure` sem
retorno (`untInterfaceTefCitel.pas`), e os dois pontos de chamada no autcom são linha nua sem
`try/except` (`untTefCitelUtil.pas`, `pEstornaTransacaoPendente` e `pFinalizaTranscacao`). O único
canal seria exceção, que abortaria o fecho de uma venda que hoje termina certa — e exigiria mexer
em `padra_atualizado\fontes\`, logo `autcom.exe` na IDE. **Medir a assinatura e os call sites antes
de propor trocou a proposta inteira**; a versão "recusar" foi descartada por piorar o caso.

## IDE e `msbuild` não produzem o mesmo binário aqui (2026-09-11)

Fato medido, não suposição. Os mesmos fontes, sem nenhuma alteração entre os dois builds:

| Binário | `msbuild` Debug/Win32 | IDE |
|---|---|---|
| `libTefCitel.dll` | 21.540.933 bytes | **21.987.047** |
| `TefEstacaoService.exe` | 2.663.936 bytes | **2.661.888** |

Os dois compilam e os dois funcionaram em campo, mas **não são o mesmo artefato**. Consequência
prática: ao registrar "binário validado em campo", dizer **qual toolchain** o gerou. A bateria que
validou F e E2 (11/09 10:15–10:27) rodou com os binários da **IDE**.

Para o `autcom.exe` a questão não se coloca — ele só compila na IDE. Para a DLL e o serviço, o
`msbuild` é conveniente durante o desenvolvimento (não abre IDE, é rápido), e é essa conveniência
que cria a chance de confundir os dois. Conferir o mtime **e o tamanho** antes de afirmar que o
binário em disco é o que você compilou.

## O `TEvent` de ACK nunca pode ser propriedade do dicionário (2026-09-11) — a reconexão reemite o `messageId` e o dono errado libera

`FdictAcksPendentes` era um `TObjectDictionary<UInt32, TEvent>` com `doOwnsValues`, nos
**dois** lados. Nessa forma, quem libera o `TEvent` é o dicionário — em `Remove`, em
`AddOrSetValue` sobre chave existente e no `Destroy`. Isso é seguro enquanto a chave for
única na vida do objeto. **No lado autcom ela não é**: `pZeraEstadoDoCanal` zera
`FintProximoMessageId` a **cada reconexão de canal**, e a bateria de 11/09 teve 10
reconexões em 32 minutos.

A janela é esta:

1. `pEnviaUmFragmento` registra `messageId=7` e entra em `LobjEventoAck.WaitFor` — até
   5 × 2000 ms.
2. O canal cai e volta. `fReconectaCanal` chama `pAcordaAcksPendentes` (que **só sinaliza**)
   e `pZeraEstadoDoCanal`, que zera o contador.
3. O `reata` sai na época nova e volta a ser `messageId=1`; a sequência avança e chega de
   novo em `7`.
4. O `AddOrSetValue` da espera **nova** encontra a chave ocupada e **destrói o `TEvent` em
   que a thread antiga ainda está parada dentro do `WaitFor`**.
5. O `finally` da thread antiga faz `Remove(7)` — e agora libera o `TEvent` da thread
   **nova**. Cascata.

O comentário que existia na unidade previa a reemissão do id e escolhia como mitigação
proteger o reset com `FcsEscrita`. **Isso não fecha a janela**: o lock cobre quem
*atribui* o id, não quem já está esperando. E `pAcordaAcksPendentes` acorda, mas não
espera ninguém sair do dicionário.

**A regra:** o `TEvent` de ACK pertence a **quem espera**. Quem cria libera; o dicionário
só aponta. Quatro coisas andam juntas e nenhuma sozinha resolve:

1. `TDictionary` em vez de `TObjectDictionary` com `doOwnsValues`.
2. O `TEvent` nasce **antes** de qualquer coisa que possa levantar, e um único
   `try..finally` cobre da criação até o fim do método. Sem isso, um `raise` em
   `pEnviaFrameBruto` (a escrita levanta quando o canal cai no meio) deixa a entrada
   pendurada — o que antes o `Destroy` do dicionário resolvia e agora vazaria de verdade.
3. A remoção é **por identidade**: `TryGetValue` + comparação de ponteiro antes do
   `Remove`. Se o id já foi reemitido, a entrada daquela chave é de outra thread e
   removê-la mataria a espera dela.
4. `pZeraEstadoDoCanal` esvazia o registro de esperas junto com o contador — sem liberar
   nada, porque `pAcordaAcksPendentes` já acordou todo mundo. Sem isso, um ACK de mesmo
   número na época nova acordaria a espera errada.

**O lado estação não tem o defeito e não deve ser mexido:** lá `FintProximoMessageId := 0`
só existe no construtor de `TTefEstacaoConexao`, e o dicionário nasce junto. Sem reset
dentro da vida do objeto não há reemissão de id, e portanto não há a corrida. Plugin e
serviço seguem sem redeploy.

**Relação com os AVs:** este é um use-after-free de **heap** em objeto de sincronização,
disparado por reconexão. O AV de 11/09 10:54 corrompeu um slot de **pilha** — coisa que
corrupção de heap não faz. São defeitos distintos, e o conserto do `TEvent` não é conserto
do AV de pilha. A bateria de 11/09 15:10–15:42 (10 reconexões, 3 processos autcom,
`Nivel=2`) não reproduziu nenhum dos dois; isso é ausência de reprodução, não prova.

---

## O canal DVC retém a entrega por ~10 s — e isso encerra a dúvida da "duplicação de chunk físico" (2026-09-11)

A latência que estava em aberto desde o item 1 do Passo 8 tem, agora, medida e prova de
que **está fora do nosso código**. Bateria de 11/09 15:10–15:42, `Nivel=2`, 10 reconexões.

Latência da resposta do `reata`, medida pelo `WTSVirtualChannelRead retornou N bytes em M ms`:

| ocorrências | latência |
|---|---|
| 8 (pid 186332, todas) | 0–16 ms |
| 1 (pid 83708, 15:22:13) | 78 ms |
| 1 (pid 156012, 15:13:13) | 641 ms |
| **5** (pid 83708) | **9.157 / 9.453 / 9.812 / 10.141 / 11.328 ms** |
| 1 (pid 156012, 15:15:23) | **34.563 ms** |

Os cinco agrupados em **~9–11 s** não são dispersão: é regularidade demais para ser acaso.

**A prova de que não é nosso** vem do cruzamento com o log do plugin (15:29:38):

```
plugin  15:29:38.470  Socket->canal DVC: 138 bytes repassados ao autcom.exe.
autcom  15:29:47.973  WTSVirtualChannelRead retornou 146 bytes em 9453 ms
```

O plugin escreveu no canal imediatamente. O autcom estava parado **dentro** do
`WTSVirtualChannelRead`, sem nenhuma escrita nossa no intervalo
(`escritas NOSSAS no canal durante esta leitura: 0`), e só recebeu 9,5 s depois. No meio,
a estação retransmitiu de 2 em 2 s e chegou a desistir
(`socket NAO confirmou a entrega ... seguindo sem confirmacao`). Quando o canal solta,
entrega tudo em rajada.

**Isso encerra a dúvida registrada na própria unidade** (`untTefCitelDvcTransporte.pas`, o
comentário longo antes da checagem de overshoot): *"a hipótese de o canal duplicar um chunk
físico ainda não está provada"*. **O canal não duplica.** As cópias que chegam juntas são
retransmissões **legítimas da estação**, que loga cada uma. O hex dump que o Rafael mandou
incluir exatamente para essa dúvida fechou byte a byte: as 4 cópias de 15:29:47 têm o mesmo
`messageId=2` e o mesmo CRC `82 64 C5 CA`. Era retenção, não duplicação.

A checagem de overshoot continua necessária — ela protege contra o que chega **depois** de
uma rajada, não contra duplicação.

### O ACK engolido pelo canal — 2 s de custo, 8 ocorrências

Assinatura no log:

```
fProcessaChunkWts: mensagem anterior abandonada (totalLength=464, so chegou 21 bytes)
```

Sempre **21 bytes** — exatamente o tamanho de um frame ACK — e sempre logo depois de
`pEnviaFrame: sem ACK do messageId=X apos 2000 ms`. Do lado da estação a assinatura é
sempre a mesma: um ACK e uma mensagem maior saindo no **mesmo milissegundo**.

O que o canal entrega é um chunk de 29 bytes com o `totalLength` da mensagem **grande** e
apenas 21 bytes de dado. O ACK original **não chega por nenhum outro caminho** — o que
destrava é o re-ACK da retransmissão, 2 s depois (a estação loga
`quadro duplicado descartado (messageId=X) - reenviando ACK mesmo assim`).

Ocorrências em 11/09: 15:16:17 (354), 15:18:43 (368), 15:23:01 (71), 15:28:16 (84),
15:40:16 (464), 15:40:40 (464), 15:41:08 (464), 15:41:13 (352). Em 15:28:16 o ACK perdido
atrasou um `fPassarCartao` em 2 s — latência que o operador sente.

**O ramo "mensagem anterior abandonada" de `fProcessaChunkWts` se comporta certo** (detecta
a incoerência, descarta e recomeça); o custo é do canal. Não tentar consertar isso no
transporte sem antes instrumentar o lado do plugin.

---

## 64004 em `AbreSessaoTEF` depois de um cancelamento que concluiu (2026-09-11) — variante que a guarda atual não pega

O 64004 do Scope já estava documentado nesta base como **operação despachada sem o login
DA INSTÂNCIA** (RF17 item 3, campo de 2026-09-09 17:28), e a guarda
`FblnCfgAplicadaNaInstancia` em `pGarantePinpadConfigurado` foi criada para isso.

**A ocorrência de 11/09 15:40 é outra coisa.** O `GravaLogErr` que a DLL nativa mandou
gravar diz, nas três vezes, exatamente:

```
Term. TEF: 004 - Problemas em [AbreSessaoTEF] retorno: Erro Desconhecido (64004)
```

E aqui o autcom **tinha** o login próprio aplicado (`fConfiguraTefCitel` id=70, 15:38:24,
com a DLL nativa chamada de verdade). A guarda tomou a saída antecipada — digital batendo
e `FblnCfgAplicadaNaInstancia` verdadeiro — e não houve reaplicação. Foi aí que deu 64004.

O discriminador empírico da bateria é limpo:

| chamada | reaplicou configuração? | resultado |
|---|---|---|
| `fCancelaTransacaoTerminal` id=73, 15:38:53 | não | **OK** (Controle 09102054011) |
| `fCancelaTransacaoTerminal` id=76, 15:40:14 | não | **64004** |
| `fCancelaTransacaoTerminal` id=79, 15:40:38 | não | **64004** |
| `fPassarCartao` id=82, 15:41:05 | não | **64004** |
| `fCancelaTransacaoTerminal` id=52, 15:41:47 (pid 83708) | **sim** | **OK** |
| `fPassarCartao` id=85, 15:42:26 (pid 186332) | **sim** | **OK** |

As três falhas são exatamente as três chamadas que vieram **depois de um cancelamento que
concluiu** (id=73, às 15:39:34, devolvendo 1946 bytes de dados reais) **sem
`fFinalizarTransacao` no meio**. E o que cura é a reaplicação — que passa por
`FechaSessaoTEF(SCO_CONFIRMA_TEF, forçado)`, como o próprio log da estação diz.

**A pista mais forte, não provada:** `FintSinc` em `untScopeNCR.pas` é variável **global da
unidade** — compartilhada por todas as sessões dentro do serviço. `AbreSessaoTEF` pula
`AbreSCOPE` + `ScopeAbreSessaoTEF` inteiros quando `INI_SESSAO` já está setado, e
`FechaSessaoTEF` só limpa o bit se `INI_SESSAO` estiver setado **ou** com `bForcar = 1`.
Um cancelamento que conclui e não é finalizado deixa esse bit num estado que a próxima
`AbreSessaoTEF` interpreta errado.

**Enquanto não estiver provado, não consertar por palpite.** O que falta é uma bateria
dirigida: cancelamento que conclui → segunda operação **sem** `fFinalizarTransacao` no
meio, com o valor de `FintSinc` logado antes e depois de cada `AbreSessaoTEF` /
`FechaSessaoTEF`.

---

## O `reata` sai 15–18 s depois da reabertura — e o carimbo de hora do log não é o instante do evento (2026-09-11)

Achado colateral da análise do item 1, e o mais importante deles: **o carimbo de hora deste
log mede quando a linha conseguiu o `FcsLog`, não quando o evento aconteceu.** Em
`pLogaDiagnosticoDvcNivel` o `GetLocalTime` é chamado *dentro* do lock, depois do
`Inc(FdwSeqLog)`, e o `CreateFile`/`WriteFile`/`CloseHandle` da linha **anterior** também
roda dentro do lock. Quem entra atrasado é carimbado atrasado.

Isso não é teoria: o log se contradiz sozinho e a contradição é a prova.

```
15:12:57.740  [pid=156012 seq=34 tid=98596]  leitura encerrada em 19937 ms ... escritas NOSSAS: 0
15:13:12.669  [pid=156012 seq=35 tid=56600]  pEnviaReata: mandando "reata" ...
15:13:12.670  [pid=156012 seq=37 tid=98596]  leitura encerrada em   0 ms ... escritas NOSSAS: 1
```

A leitura de `seq=37` durou **0 ms** pelo `GetTickCount` e **14.930 ms** pelo relógio de
parede. Os dois não podem estar certos. O `GetTickCount` cerca só a chamada
`WTSVirtualChannelRead`; o relógio de parede cobre também o rabo da gravação de `seq=34`.
A thread de leitura ficou 14,9 s **fora** da leitura — dentro do `FcsLog`, gravando a linha
anterior no arquivo — e a thread do `reata` ficou esse tempo todo parada no
`FcsLog.Enter`, entrando 1 ms antes dela.

Varrendo as 5.608 linhas, **só há dois trechos** em que o tempo de parede excede o tempo
medido de leitura em mais de 1 s:

| linha | pid | parede | medido | perdido fora da leitura |
|---|---|---|---|---|
| 15:13:12.670 | 156012 | 14.930 ms | 0 ms | **14.930 ms** |
| 15:22:13.019 | 83708 | 8.338 ms | 0 ms | **8.338 ms** |

23,3 s perdidos em 32 minutos de `Nivel=2`, com três `autcom.exe` gravando no **mesmo
arquivo** em `%TEMP%` (que é por sessão TS), abrindo e fechando o handle a cada linha. O
`FcsLog` serializa só as threads do próprio processo — a disputa pelo arquivo entre os três
processos não é serializada por nada.

**E esses dois trechos são exatamente os dois contraexemplos** que não fechavam: 15:13:12
(`reata` 34,9 s depois da reabertura, resposta em 673 ms) e 15:22:13 (`reata` 25,8 s depois,
resposta em 95 ms). Nos dois, parte do atraso do `reata` era o log, não o canal.

### O que sobra sem explicação

Nos outros quatro ciclos retidos o relógio fecha: a thread de leitura estava dentro de uma
leitura longa de verdade e o `GetTickCount` dela cobre todo o tempo de parede. Mesmo assim
o `reata` sai **no milissegundo exato** em que a leitura termina:

| reabriu | pid | `reata` | leitura que estava correndo |
|---|---|---|---|
| 15:14:30.361 | 156012 | +18,9 s | durou 18.844 ms, acabou no mesmo ms |
| 15:25:19.713 | 83708 | +16,5 s | durou 16.531 ms, acabou no mesmo ms |
| 15:27:18.170 | 83708 | +16,4 s | durou 16.344 ms, acabou no mesmo ms |
| 15:29:19.985 | 83708 | +18,5 s | durou 18.531 ms, acabou no mesmo ms |
| 15:37:58.824 | 83708 | +15,7 s | durou 15.687 ms, acabou no mesmo ms |

O que já foi **descartado** como causa:

- **`FOnConectado()` demorar a voltar** — não: o `LdwInicioLeitura := GetTickCount` da
  leitura seguinte bate com o carimbo do `REABERTO` a menos de 1 ms em todos os ciclos.
  A thread anônima é criada e iniciada na hora.
- **`pLoopLeitura` segurar algum lock em volta da leitura** — não: a chamada
  `WTSVirtualChannelRead` está nua, sem nenhum `Enter` em volta.
- **`FcsChamadas` preso por uma chamada RPC em voo** — não: às 15:27:18.171 o pid 186332
  entrou no `FcsChamadas` na hora **com `ids=1`** (havia chamada pendente), e três dos
  ciclos retidos tinham `ids=0`. Chamada pendente nem causa nem evita o atraso.
- **Ordem de reabertura entre os dois autcom** — não: em 15:37:58 o primeiro a reabrir
  (186332) foi rápido e o segundo (83708) foi retido; em 15:12:37 foi o contrário.

**O atraso do `reata` é por processo, não por ciclo:** o pid 186332 mandou o `reata` em
0,0 s nas **oito** vezes; o 83708 levou 15–26 s nas cinco; o 156012, 18–35 s nas duas. Não
há nada no log que diga o que esses processos têm de diferente. **Não consertar por palpite.**

### A instrumentação que fecha isso (barata, e a próxima a entrar)

1. `LdwTickStart := GetTickCount` em `TTefCitelDvc.pOnConectado`, **antes** do `.Start`,
   capturado pela closure; `GetTickCount - LdwTickStart` como **primeira** instrução do
   corpo da thread anônima, reportado na linha do `pEnviaReata`. Mede o atraso com tick
   count, imune à disputa do `FcsLog` — separa "a thread não rodou" de "`pEnviaReata`
   travou".
2. `GetTickCount` em volta do `CreateFile`/`WriteFile`/`CloseHandle` de
   `pLogaDiagnosticoDvcNivel`, acumulado numa global e emitido na linha **seguinte**.
   Mede o custo do próprio log — que já está provado passar de 14 s.
3. Do lado do plugin, marca de tempo na entrada e no retorno do `WTSVirtualChannelWrite`,
   para separar "o plugin demorou a escrever" de "o canal segurou depois de escrito"
   (item 1, retenção de ~10 s).

**Consequência imediata para quem for ler qualquer log deste subsistema:** diferença entre
carimbos de duas linhas **não** é duração de evento. Onde houver medida própria
(`em N ms`, `GetTickCount`), ela é que vale; onde não houver, o carimbo é um limite
superior contaminado pelo custo do log. Em `Nivel=2`, com mais de um `autcom.exe`, a
contaminação chega a dezenas de segundos.

---

## A retenção só acontece no primeiro diálogo de um canal recém-aberto (2026-09-12) — e o ACK engolido não

Observação de campo do Rafael ("essas instabilidades ocorrem mais quando tem as reconexões;
no caminho feliz parece ser mais estável"), medida contra a bateria de 11/09. Para cada
falha, distância até a reabertura mais recente **do mesmo processo**:

| fenômeno | dentro de 60 s de uma reabertura |
|---|---|
| **retenção do canal** (leitura longa + cópias em rajada) | **6 de 6** |
| ACK engolido (`mensagem anterior abandonada`) | 1 de 8 |
| esperas longas legítimas de pinpad (controle) | 1 de 19 |

O controle é o que dá peso ao número: nas 19 esperas longas legítimas, só uma caiu perto de
uma reabertura. Não é que tudo aconteça perto de reconexão — **só a retenção acontece.**

E o recorte é ainda mais estreito do que "perto de uma reabertura": as seis leituras retidas
são de **146 ou 179 bytes**, que é o tamanho da resposta do `reata`. Ou seja, a retenção
nunca pegou uma resposta de operação real — pegou sempre o **primeiro diálogo do canal
novo**. Os 25,8–28,0 s que aparecem na coluna de distância em cinco dos seis casos não são
um período independente: são os 15–18 s de atraso do `reata` mais os 9–11 s de retenção da
resposta dele. Não confundir os dois com um terceiro número.

**Hipótese que isso levanta (não provada):** o canal DVC recém-reaberto ainda não está
pronto para entregar, e segura os bytes até completar alguma coisa do lado do RDP. A medida
que decide é a duração do `IWTSVirtualChannel.Write` no plugin — se ele voltar na hora e o
autcom só receber 9 s depois, a retenção é do canal e não do plugin.

**O ACK engolido é outro problema e é do caminho feliz** (1 de 8 perto de reabertura). Não
esperar que consertar a reconexão resolva aquilo.

**Um dado que não tem explicação:** os dois modos de falha se separam por processo. Das 6
retenções, 5 são do pid 83708; dos 8 ACKs engolidos, 7 são do pid 186332 — que é justamente
o processo que mandou o `reata` em 0,0 s nas oito vezes. Registrado como fato, sem teoria.

### Instrumentação aplicada em 2026-09-12 (o que procurar no próximo log)

Três medidas novas, todas com `GetTickCount` — deliberadamente **não** com o carimbo de
hora, que mede aquisição do `FcsLog` e não o instante do evento.

1. **`untTefCitelDvc.pas`, `pOnConectado` + `pEnviaReata`.** A linha do `reata` passa a
   trazer `Atrasos: partida da thread N ms, FcsChamadas N ms, total ate aqui N ms`. Os três
   números separam as únicas explicações possíveis do `reata` atrasado: a thread anônima não
   rodou / havia chamada RPC segurando o `FcsChamadas` / o tempo foi na montagem e alocação
   (gerenciador ShareMem compartilhado com o `autcom.exe`). **Se os três vierem baixos e o
   carimbo ainda estiver atrasado, a causa é o próprio log** — e aí o campo do item 2
   aponta. Nível NORMAL: é uma linha por reconexão, custa 3 `GetTickCount`.

2. **`untTefCitelDvcTransporte.pas` e `untTefCitelDvcPluginImpl.pas`, a função de log.**
   Mede o `CreateFile`/`WriteFile`/`CloseHandle` e emite o resultado no prefixo da linha
   **seguinte**, como ` gravAnterior=Nms` (transporte) ou `[gravAnterior=Nms]` (plugin),
   **só acima de `TEF_LOG_GRAVACAO_LENTA_MS = 100`**. Em operação normal o formato da linha
   não muda em nada; quando o campo aparece, ele diz quantos milissegundos daquele carimbo
   são atraso do próprio log. O começo da medida é **depois** do carimbo de propósito: o que
   desloca o carimbo da próxima linha é exatamente o que vem dali para baixo (a rotação, que
   é anterior, desloca o carimbo da própria linha e por isso não entra nesta conta).

3. **`untTefCitelDvcPluginImpl.pas`, `pLoopConectorELeitura`.** A linha
   `bytes repassados ao autcom.exe` passa a trazer
   `IWTSVirtualChannel.Write levou N ms e devolveu 0x########`. É a medida que fecha o item
   1. De quebra, **o `HRESULT` era descartado desde sempre** — um `Write` que falhava em
   silêncio era indistinguível, no log, de um que deu certo. Nível DIAGNÓSTICO (2), como a
   linha já era.

Os dois lados precisam de redeploy nesta bateria: `libTefCitel.dll` **e**
`TefCitelDvcPlugin.dll`. O `TefEstacaoService.exe` não foi tocado.

---

## QR-Code Pix: o que viaja pelo canal é o PNG, não o caminho (2026-09-12)

O Scope não recebe o QR como texto. Ele carrega **um arquivo PNG do disco** no pinpad:
`TTefCitelNCR.pEnviarQrCode` monta um `TAbecs_PPFile_Iinfo` com diretório e nome de arquivo,
chama `ScopePPMMFileLoad`, depois `ScopePPMMDisplayImage` e por fim apaga o arquivo dos dois
lados. Daí a assinatura `pEnviarQrCode(AstrDiretorio, AstrArquivo)` em toda a cadeia.

Quem gera esse PNG é `fGerarQrCodeImagemPinPad`, em
`padra_atualizado\fontes\tef\TefCitel\untTefCitelUtil.pas`: um `TdxBarCode` com
`TdxBarCodeQRCodeSymbology`, pintado com `cxPaintToBitmap` num painel de 220×220 e salvo com
`TdxPNGImage`. **É VCL com DevExpress e precisa de um form dono (`Application.MainForm`).**
Isso decide o desenho inteiro: a geração roda no `autcom.exe` e em lugar nenhum mais —
portá-la para dentro do serviço da estação não é opção.

Com o TEF no servidor as duas pontas viam o mesmo disco e mandar o caminho bastava. **Com o
canal DVC a DLL do Scope está na estação, e o caminho do `%TEMP%` do servidor não existe
lá.** O proxy mandava as strings de caminho — um endereço inválido. O Pix funcionava (o QR
aparece na tela), mas o visor do pinpad ficava vazio.

**A correção:** o proxy lê o PNG, manda o conteúdo em **base64** no campo `conteudoBase64`
(mais o nome do arquivo, sem o diretório — que não significa nada do outro lado), e a
estação grava um temporário **dela** e chama a mesma `pEnviarQrCode` nativa de sempre. Nada
muda do lado do Scope.

O teto de frame já tinha sido dimensionado prevendo base64 (`TEF_DVC_TAMANHO_MAX_FRAME`
= 16 MB, com o comentário "cobre fragmentos base64 de DLL (RF10)"). Este é o **primeiro**
payload base64 do protocolo — o RF10 ainda não foi implementado. O PNG de 220×220 tem
alguns KB, ou seja 2 a 5 fragmentos de 1400 bytes: nada perto do teto.

**Um vazamento que a mesma mudança fecha.** A versão nativa apaga o temporário depois de
carregar. Com o canal DVC quem apagava era a estação — um arquivo que ela nunca viu. O
`%TEMP%` do servidor acumulava **um PNG por Pix**, para sempre. Agora quem lê é quem apaga,
num `finally`; e a estação também apaga o dela num `finally`, para cobrir o caminho de erro
em que a nativa não chega a apagar.

**Duas decisões que parecem detalhe e não são:**

1. **Arquivo inexistente não levanta exceção** — loga e sai. O QR continua visível na tela do
   Pix, então a falha no visor degrada a experiência mas não impede o pagamento. Derrubar a
   tela seria pior que o sintoma.
2. **A estação passa `ExtractFileName` no nome recebido.** O campo vem da rede; um
   `..\..\algo.exe` gravaria fora da pasta de trabalho. O nome não serve para mais nada além
   de identificar o temporário.

O temporário da estação fica em `<pasta do exe do serviço>\TempQr`, mesmo idioma do
`FilaTef` — e **não** em `%TEMP%`, que para um serviço rodando como LocalSystem é candidato
a Limpeza de Disco.

### O outro caminho de QR, que NÃO passa pelo canal

Existe uma segunda via, independente desta, e ela continua inteiramente fora do DVC:
`IPinPadCitel` (`PinPad\PinPad.Interfaces.pas`), com duas implementações —
`TPinPadCitelScope`, que repete o mesmo `ScopePPMMFileLoad`, e `TPinPadCitelGertec`, que fala
serial direto (`COM6`, `gertecQRCode`). A escolha é por configuração do terminal
(`fObtemFabricantePinPad`: `'Scope'` ou `'Gertec'`).

`untExibicaoQRCodePix.pas` usa **as duas**: manda o QR por `objBridgeTef` (a via do TEF, que
agora funciona) e limpa por `FPinPad` (`pLimpaQrCodeInterno`), que é a via direta. O serviço
da estação **não conhece `IPinPadCitel`** — zero referências em `libTefCitel\`. Enquanto isso
não for resolvido, num terminal Gertec o QR não chega ao pinpad de jeito nenhum, e mesmo num
terminal Scope a limpeza do visor tenta falar com um pinpad que não está naquela máquina.

**Decisão do Rafael, 2026-09-12: essa via sai do 456190 e vai para requisito próprio.** O
critério de aceitação do fluxo Pix em `IA\specs\456190\specs.md` foi partido em dois para
refletir a decisão — a via do TEF está fechada, a via `IPinPadCitel` está marcada como fora
de escopo. RF04 continua descrevendo o alvo final.

**Para quem abrir o requisito novo, o que já está levantado e não precisa ser refeito:**

- A escolha entre as duas implementações é `fObtemFabricantePinPad`, em
  `libIntegracaoPixCitel\fontes\genericos\untFuncoesSimples.pas`, lendo a configuração do
  terminal: `'Scope'` → `TPinPadCitelScope`, qualquer outra coisa → `TPinPadCitelGertec`.
- `TPinPadCitelScope.pEnviarQrCode` é **cópia** de `TTefCitelNCR.pEnviarQrCode` — mesmo
  `TAbecs_PPFile_Iinfo`, mesmo `ScopePPMMFileLoad`, mesmo `ARQ00001`. Então a solução de
  transporte é a mesma já feita aqui: mandar o PNG em base64 e gravar um temporário do lado
  da estação. O que falta é o serviço **expor** `IPinPadCitel`, que ele hoje não conhece.
- `TPinPadCitelGertec` é outro problema: fala serial direto (`COM6`, `gertecQRCode`), sem
  arquivo nenhum. Para essa, o que tem de ir para a estação é a porta, não a imagem.
- Cuidado com a assinatura: `PinPad.Interfaces.pas` declara
  `pEnviarQrCode(AstrTextoQrCode, AstrTituloInformativo)` e `PinPad.Classes.Scope.pas`
  implementa o mesmo par posicional como `(AstrDiretorio, AstrArquivo)`. Os nomes mentem em
  uma das duas pontas — conferir o que o chamador realmente passa antes de mexer.

---

## Serviço da estação parado não pode travar o autcom (2026-09-12) — e por que isso NÃO fura a regra do pinpad

**A regra continua valendo integralmente e não deve ser alterada:** nunca impor timeout
artificial sobre o tempo do pinpad/transação TEF. O que segue é um caso diferente, e a
diferença não é de grau.

### O sintoma

Serviço da estação parado, operador abre o autcom ou inicia uma operação TEF → **o autcom
fica parado até alguém subir o serviço**. Na carga, sem tela e sem mensagem.

### Por que travava, e por que não era a queda de canal

Queda do canal DVC **já tinha tratamento**: `pNotificaDesconexao` marca as chamadas pendentes
com `ErroCanal` e `fChamaRpcUmaVez` levanta `ETefCitelDvcCanal`. O autcom não trava nesse
caso.

O buraco era **canal de pé com serviço parado**. O plugin vive dentro do `mstsc.exe`/TSPlus,
**não** dentro do serviço: o canal abre normalmente, o autcom escreve, e o plugin enfileira
os bytes num socket morto (`FlstPendente`, até 500). A espera de `fChamaRpcUmaVez` é infinita
por desenho, então nunca terminava.

Isso já tinha acontecido em campo antes, por outra causa. O cabeçalho de
`untTefEstacaoTcpTransporte.pas` registra 04/09: *"mandou `fConfiguraTefCitel` e ficou 5
retentativas de ACK sem resposta — o serviço nunca chegou ao `accept()` seguinte, e o login
do B só completou quando o AUTCOM A foi fechado"*. Aquela causa foi corrigida; **a classe de
sintoma ficou sem backstop.**

### O discriminador é o ACK — e é evidência, não palpite

**Quem emite o ACK é o SERVIÇO da estação.** O plugin é relay burro: o cabeçalho de
`untTefCitelDvcPluginImpl.pas` diz, literalmente, que nenhuma lógica de protocolo RPC/JSON é
interpretada nele. Portanto:

| situação | o que se sabe | o que se faz |
|---|---|---|
| **ACK chegou** | o pedido **alcançou** o serviço; pode estar no pinpad, pode levar minutos | espera **infinita**, como sempre |
| **ACK nunca veio** | o pedido **não passou do plugin**; nada foi executado no pinpad | desiste em 30 s |

No segundo caso não existe transação em curso para proteger. Desistir ali é **constatar um
fato**, não arbitrar um prazo — que é exatamente a diferença que a regra protege.

E isso nem é conceito novo nesta base: `pEnviaFrame` já registrava, ao esgotar as tentativas
de ACK, que seguia em "melhor esforço" porque *"o próprio timeout de negócio (hook de 30s, ou
o chamador RPC correspondente) ainda pega isso"*. **No chamador RPC esse backstop nunca
existiu.** O que foi feito aqui é ele.

### O que mudou, mecanicamente

- `TTefCitelDvcTransporte`: `pEnviaUmFragmento` e `pEnviaFrame` viraram
  `fEnviaUmFragmento`/`fEnviaFrame`, devolvendo **se o serviço confirmou**. `pEnviaFrame`
  continua existindo como casca que ignora a confirmação — o nome público é espelho do
  `TTefEstacaoConexao.pEnviaFrame` e essa simetria é proposital.
- `TTefCitelDvc`: `pEnviaEnvelope` ganhou a irmã `fEnviaEnvelope`, que propaga a confirmação.
- `fChamaRpcUmaVez`: os dois caminhos de espera (thread principal, com bombeamento; e outra
  thread) só ganham teto **quando a entrega não foi confirmada**. Confirmada, seguem
  infinitos, sem nenhuma mudança de comportamento.
- Exceção nova `ETefCitelDvcServicoIndisponivel`, irmã de `ETefCitelDvcCanal`, com mensagem
  acionável (diz que é o serviço **da estação** — sem isso o operador não tem o que pedir ao
  suporte).
- `TEF_DVC_TIMEOUT_SEM_CONFIRMACAO_MS = 30000` — **3× o orçamento de ACK** (5 × 2000 ms). A
  folga é deliberada: um reinício do serviço leva alguns segundos e não pode virar erro na
  cara do operador. Foi o número pedido pelo Rafael.

### O desfecho na carga do autcom

`untTefCitelUtil.pas` **já tinha** o padrão de degradação — `AblnEscondeMenuAdmTef := True;
VS_strUsaTef := 'N'; FIniciado := False; pMensagemOk(...)`, usado quando o CNPJ do Scope não
bate e quando a DLL não tem o evento TEFTRA. O `fConfiguraTefCitel` da carga passou a rodar
dentro de um `try..except` que reaproveita **esse mesmo bloco**. Não é degradação nova: é a
que existe, aplicada a mais uma causa.

**Consequência que precisa estar escrita:** com o TEF desabilitado assim, ele só volta
**reabrindo o autcom** — não há tentativa automática de reconexão depois da carga. É o mesmo
comportamento das outras causas e foi decisão do Rafael em 12/09. Se um dia isso incomodar, o
lugar de mexer é aqui, e a alternativa (manter o menu e tentar reconectar na primeira
operação) foi considerada e descartada nesta data.

### O que NÃO mudou, e não deve mudar

- Chamada cuja entrega **foi confirmada**: espera infinita. Um `fPassarCartao` com o operador
  escolhendo parcelamento continua podendo levar o tempo que levar.
- Serviço que morre **depois** de aceitar a chamada: continua sendo problema do `ErroCanal` +
  `reata` + fila local (RF07/RF29), não deste teto.
- Métodos não idempotentes (`fPassarCartao`, `fCancelaTransacaoTerminal`, `fReimpressao`)
  continuam sem reenvio automático. Este bloco **desiste**, nunca repete.

---

## Bateria de 2026-09-14: as três mudanças validadas, e o que a instrumentação nova mostrou

Bateria de 07:29–07:48, `Nivel=2`, 3 processos autcom (18816, 22560, 23624), 3 reinícios do
serviço, 1 queda de canal. As três mudanças de 12/09 funcionaram.

### QR-Code Pix pelo canal — validado ponta a ponta

```
autcom   07:35:30.385  pEnviarQrCode: enviando "tmp4719.png" (5991 bytes de PNG)
autcom   07:35:30.386  pEnviaFrame: payload de 8918 bytes excede 1400 - fragmentando em 7 pedacos
estacao  07:35:30.477  mensagem fragmentada completa (7 fragmentos, 8918 bytes no total)
estacao  07:35:30.484  pEnviarQrCode: 5991 bytes de PNG gravados em "C:\TEF_Citel\TempQr\tmp4719.png"
estacao  07:35:42.338  Metodo "pEnviarQrCode" (id=4) retornou com sucesso
```

O transporte custou **95 ms** para os 7 fragmentos, todos ACKados na 1ª tentativa. Os 12 s
seguintes são o Scope carregando a imagem no pinpad — não são nossos e não têm o que otimizar
no transporte.

### O teto de 30 s disparou duas vezes, nos dois cenários

| hora | método | o que era |
|---|---|---|
| 07:40:21 | `fConfiguraTefCitel` | carga do autcom com o serviço parado |
| 07:44:08 | `fPassarCartao` | operação com o serviço parado |

Nos dois, a assinatura completa: 5 tentativas de ACK (10 s), a linha
`saiu no canal SEM confirmacao do servico da estacao`, e a desistência em 30 s. **O
contra-teste também passou:** em 07:45:31–07:45:58 um `fPassarCartao` ficou 24 s com o pinpad
esperando o operador ("Aproxime, Insira ou Passe o Cartao" repetido) e **não** houve timeout —
a entrega tinha sido confirmada, então a espera seguiu infinita. A regra está de pé.

### O defeito que sobrou: a exceção nasceu IRMÃ em vez de FILHA

`ETefCitelDvcServicoIndisponivel` foi declarada `class(ETefCitelDvcRpc)` — irmã de
`ETefCitelDvcCanal`. Os quatro métodos de transação (`fPassarCartao`, `fFinalizarTransacao`,
`fCancelaTransacaoTerminal`, `fReimpressao`) capturam **`ETefCitelDvcCanal`**, então a irmã
passou batido e subiu até o **diálogo do madExcept**, na cara do operador.

O comentário da própria `ETefCitelDvcCanal` já dizia por que ela existe, e previa os **dois**
efeitos — o segundo é o que ninguém vê:

> *"nao pode subir como excecao para a tela, porque (a) o operador via o dialogo do madExcept,
> e (b) subindo por cima do `if Assigned(FDepois...)` ela deixava a trava LCKATC presa"*

Ou seja: além do diálogo, **a trava LCKATC ficou presa** nas duas vezes que o teto disparou em
`fPassarCartao`. Quem só olha a tela não percebe.

**Conserto (14/09):** `ETefCitelDvcServicoIndisponivel = class(ETefCitelDvcCanal)`. Não é
conveniência de hierarquia — é o conteúdo: os dois casos têm o mesmo desfecho operacional
(nada em curso no pinpad, tela precisa de negativa, trava precisa ser liberada). O que muda é
só o texto.

**`fConfiguraTefCitel` não tem `except`** (conferido), então o login continua levantando e a
degradação da carga em `untTefCitelUtil.pas` não muda — foi por isso que o cenário da carga
funcionou enquanto o da tela quebrou.

**O texto agora distingue os dois casos**, e a diferença é real:

| | queda de canal | serviço parado |
|---|---|---|
| chegou ao pinpad? | pode ter chegado, e o aborto pode chegar tarde | **não**, nem saiu do plugin |
| o que a mensagem manda fazer | passar de novo **e conferir o relatório** | repetir, **nada foi cobrado** |

Mandar conferir relatório no caso do serviço parado seria alarme falso — e alarme falso
repetido é o que faz o operador parar de ler a mensagem.

### O que a instrumentação nova mediu

**1. O atraso do `reata` está na PARTIDA DA THREAD, não em lock nem em alocação.** Única
reconexão da bateria, às 07:47:33:

```
pEnviaReata: ... Atrasos: partida da thread 2172 ms, FcsChamadas 0 ms, total ate aqui 0 ms.
```

Os três números separam as três explicações possíveis, e o veredito é limpo: **100% do atraso
está entre o `.Start` e a primeira instrução da thread anônima.** `FcsChamadas` e a montagem
custaram zero — as duas hipóteses que sobravam morrem aqui. Foram 2,1 s e não os 15–18 s de
11/09 (uma reconexão só, amostra de um), mas o *lugar* está isolado. O que falta é descobrir
por que uma `TThread.CreateAnonymousThread(...).Start` demora segundos para entrar no corpo.

**2. O custo do próprio log é real e foi flagrado.** Uma ocorrência, às 07:37:49:
` gravAnterior=469ms` — 469 ms daquele carimbo são atraso do log, não do evento. Abaixo do que
se viu em 11/09 (14,9 s), mas confirma o instrumento funcionando e a distorção existindo.

**3. `IWTSVirtualChannel.Write` nunca demora e nunca falha.** Em ~100 ocorrências, **todas**
`levou 0 ms e devolveu 0x00000000`. Não houve retenção de ~10 s nesta bateria para cruzar, mas
já está estabelecido que, quando ela acontecer, **não é o `Write` do plugin** — o instrumento
está posto e a metade do cruzamento que faltava existe agora.

### Resíduo conhecido: o plugin entrega depois da desistência

Às 07:45:06, quando o serviço voltou, o plugin entregou o `fPassarCartao` (messageId=43) que o
autcom **já tinha desistido** às 07:44:08 — a fila `FlstPendente` do plugin guardou o quadro e
as 4 retransmissões:

```
TCP[con=1]: recebidos 2345 bytes
TCP[con=1]: quadro duplicado descartado (messageId=43, maior aceito=43) - reenviando ACK  (x4)
Metodo "fPassarCartao" (id=8) recusado por FALTA DE LOGIN do pid=23624
```

**Nesta bateria o login salvou:** o serviço tinha reiniciado, era instância nova, não conhecia
o login do pid e recusou antes de tocar o pinpad. Isso não é sorte — é estrutural: o teto só
dispara quando não houve ACK, e "sem ACK por 30 s" na prática significa serviço fora do ar;
quando ele volta, volta sem o login. Se fosse só o socket do plugin que caiu, com o serviço
vivo e o login intacto, a reconexão em 2 s traria o ACK e não haveria desistência.

Não é prova de impossibilidade, é o mecanismo que torna o caso improvável. **Registrado como
resíduo aceito, não como problema resolvido.**

### Uma linha de log que agora mente

Quando o teto dispara, a resposta que chega atrasada cai em:

```
pTrataResposta: id=8 NAO ENCONTRADO em FdictChamadas (Count=0) - resposta ignorada.
Isto e a causa provavel da trava pos-fPassarCartao investigada em 2026-09-02.
```

O comportamento está certo (a chamada desistiu, a resposta não tem dono), mas **o texto acusa
uma causa que não é mais a única** — quem ler esse log daqui a meses vai procurar um bug de
02/09 que não está ali. Ajustar o texto para mencionar as duas possibilidades.

---

## Bateria grande de 2026-09-14 (08:15–09:03): o conserto fechado, e o `reata` isolado

Bateria de 08:15:52 a 09:03:27, `Nivel=2`, **dois `autcom.exe` simultâneos** — pid **72316**
(terminal 003, Emp 543) e pid **85624** (terminal 004, Emp 544) —, 4 instâncias de serviço e
**6 ciclos de queda/reabertura de canal**. Nenhum problema observado pelo operador.

### O conserto de 14/09 passou, e passou pelos DOIS ramos

`pNotificaCanalCaiu` rodou 5 vezes, e o texto saiu certo nos dois desfechos:

| hora | pid | método | exceção | texto entregue à tela |
|---|---|---|---|---|
| 08:50:01.587 | 85624 | `fCancelaTransacaoTerminal` | `ETefCitelDvcCanal` | canal caiu — confira o relatório |
| 08:54:01.466 | 72316 | `fPassarCartao` | **`ETefCitelDvcServicoIndisponivel`** | **nada foi cobrado** |
| 08:54:23.245 | 85624 | `fPassarCartao` | **`ETefCitelDvcServicoIndisponivel`** | **nada foi cobrado** |
| 08:55:01.646 | 72316 | `fPassarCartao` | `ETefCitelDvcCanal` | canal caiu — confira o relatório |
| 08:59:36.491 | 72316 | `fPassarCartao` | `ETefCitelDvcCanal` | canal caiu — confira o relatório |

**Nenhum diálogo do madExcept em 43 minutos** — era esse o sintoma de 07:44. O discriminador
de texto está exercitado dos dois lados, e um **segundo** dos quatro handlers
(`fCancelaTransacaoTerminal`) entrou em cena.

O teto de 30 s disparou **duas vezes**, as duas em `fPassarCartao` (08:53:52.431 no 72316,
id=20; 08:54:23.245 no 85624, id=28), cada uma precedida do ciclo completo de 5 × 2 s de ACK e
da linha `saiu no canal SEM confirmacao do servico da estacao`.

**A trava LCKATC foi liberada — prova indireta, mas é a única que o log pode dar.** Nenhuma
linha diz "trava liberada": o que se grava é a intenção. O que o log mostra é o efeito, e o
efeito está lá — depois de cada timeout o **mesmo pid** abriu outra tela de TEF e a operação
foi aceita, o que só acontece com a trava livre:

| desistiu | pid | próxima operação aceita | intervalo |
|---|---|---|---|
| 08:54:01.466 | 72316 | `AdicionaObserver` 08:54:43.306 → `fPassarCartao` id=23 às 08:54:45.215 | 44 s |
| 08:54:23.245 | 85624 | `AdicionaObserver` 08:56:41.536 → `fPassarCartao` id=32 às 08:56:43.608 | 2min20 |

Reforçando: logo após o timeout do 72316 vêm `pRetornaLog` (id=21, id=22) e
`RemoveObserver: total antes=1` às 08:54:34.895 — a tela fechou pelo caminho normal, que é o
`FDepois*` rodando. O `SELECT ... LIKE 'TEF_CITEL%'` continua sendo a prova direta, mas com
esse encadeamento a hipótese de trava presa não se sustenta.

**Contra-teste do pinpad, com folga:** duas transações passaram de 30 s com o pinpad esperando
o operador e **não** sofreram timeout, porque a entrega tinha ACK:

- `fPassarCartao` id=29 do **72316**: enviado 08:56:32.848, ACK em 15 ms, resposta
  08:57:11.884 → **39,0 s**;
- `fPassarCartao` id=46 do **85624**: enviado 09:02:24.917, ACK em 16 ms, resposta
  09:03:01.713 → **36,8 s**, com Modalidade Dinâmica completa no meio (`pInfo21`, `pInfo30`,
  `pInfo34`, "1-Adm 2-Loja", "Numero de Parcelas ?").

**A regra do pinpad está de pé:** quem tem ACK espera o tempo que for.

**Cobertura parcial, para constar:** `fFinalizarTransacao` rodou 7 vezes na bateria, sempre com
sucesso, e `fReimpressao` não foi chamado — os dois usam o mesmo código e a mesma exceção, mas
não há evidência de campo deles. A degradação da carga também não foi reexercitada (passou em
07:40; o caminho não foi tocado desde então).

### O atraso do `reata` é DETERMINÍSTICO POR PROCESSO — 12 amostras, zero ambiguidade

Seis reconexões × dois processos, e o resultado não deixa margem:

| reconexão | pid 85624 | pid 72316 |
|---|---|---|
| 08:22 | **0 ms** | 4.515 ms |
| 08:41 | **0 ms** | 1.859 ms |
| 08:43 | **0 ms** | 6.125 ms |
| 08:50 | **0 ms** | 5.078 ms |
| 08:55 | **0 ms** | 4.110 ms |
| 08:59 | **0 ms** | 5.984 ms |

`FcsChamadas 0 ms, total ate aqui 0 ms` em **todas as 12** — as duas hipóteses alternativas
(lock e montagem) morrem em definitivo. Todo o atraso está entre o `.Start` e a primeira
instrução da thread anônima. Um processo **nunca** atrasa; o outro **sempre**, 1,9 a 6,1 s,
média 4,6 s. Seis de seis para cada lado, no mesmo minuto, na mesma máquina.

**Não é ordem de reabertura.** Na reconexão das 08:43 o **72316 reabriu primeiro** (tentativa
17 às 08:43:56.863, 4 ms antes do 85624) e mesmo assim levou 6.125 ms contra 0 do outro. Nas
outras cinco o 85624 reabriu primeiro. A variável é o processo, não a corrida.

Isto reproduz e afia o padrão notado em 11/09 (pid 186332 sempre 0,0 s; pid 83708 15–26 s),
que tinha amostras sujas e de baterias diferentes.

**Um cuidado de leitura, para não repetir o erro:** o `pLoopLeitura` logo abaixo mostra
`leitura encerrada em N ms` com **o mesmo N**. Isso não é corroboração, é tautologia — a
leitura termina com erro 996 justamente porque o `reata` escreveu no canal.

### As três anomalias são do MESMO processo — agora conferido

| anomalia | pid 72316 | pid 85624 |
|---|---|---|
| atraso na partida da thread do `reata` | **6 de 6** | 0 de 6 |
| ` gravAnterior=` (custo do log) | **7 de 8** | 1 de 8 |
| hook `AntesPassarCartao` lento | **11.188 ms** (id=5, 08:59:19.923 → 08:59:31.098) | — (15 a 47 ms) |

O hook de 11,2 s é o dado mais sério: o orçamento da estação é `TEF_ESTACAO_TIMEOUT_HOOK_MS`
= 30 s, e ele consumiu **37% dele** — estourar significa a estação derrubar a transação
inteira. Durante esses 11 s o pid 72316 não logou **nada**: a thread principal estava parada.
Os outros sete hooks da bateria responderam em 15–47 ms.

Três sintomas independentes — escalonamento de thread, I/O de arquivo e thread principal —
concentrados no mesmo processo e ausentes no vizinho. Isso desloca a suspeita de "bug no
`.Start`" para **contenção dentro daquele autcom**: o que segura a thread principal por 11 s é
candidato natural a também atrasar a partida de uma thread nova.

**O instrumento que decide é barato:** medir dentro de `pOnConectado` quanto o `.Start` **em
si** leva para retornar, separado do tempo até o corpo rodar. `.Start` lento → criação de
thread (loader lock, `DLL_THREAD_ATTACH` das DLLs carregadas). `.Start` rápido e corpo tardio
→ escalonamento/contenção. Dois números, um `if`.

### Instrumentação: números da bateria

- **`IWTSVirtualChannel.Write`:** centenas de medições, **todas** `0 ms` e `0x00000000`. Duas
  baterias, nenhuma exceção. Quando a retenção de ~9–11 s reaparecer, o plugin já está
  descartado como causa.
- **` gravAnterior=`:** 8 ocorrências (671, 282, 407, 188, 562, 235, 110, 860 ms) — mais que em
  07:29 porque dois autcom gravam o mesmo arquivo.
- **Retenção de ~9–11 s: não apareceu.** As leituras longas desta bateria têm explicação: a de
  9.438 ms às 08:54:29 é o intervalo de serviço parado (08:52:55 → 08:54:29), e a rajada de
  ACKs logo depois é o serviço novo confirmando os 5 reenvios. Item segue aberto.

### Resíduo conhecido: recorrente, e barrado por DUAS guardas diferentes

A entrega tardia do plugin apareceu 5 vezes (08:50:19.673, 08:54:29.959, 08:54:29.973,
08:55:25.146, 08:59:58.824). O caso mais instrutivo é 08:54:29, quando o serviço voltou e o
plugin despejou os dois `fPassarCartao` que os autcom já tinham desistido — e **cada um
esbarrou numa guarda diferente**:

```
08:54:29.947  Metodo "fPassarCartao" (id=20) recusado por FALTA DE LOGIN do pid=72316
08:54:29.949  Metodo "fPassarCartao" (id=28) RECUSADO por posse do pinpad (RF17 item 1)
```

Nenhum chegou ao pinpad. São duas barreiras independentes, e o acaso escolheu uma para cada.
Reforça o argumento de que o resíduo é improvável por construção — **sem virar prova de
impossibilidade**. Continua registrado como resíduo aceito.

É também esse caminho que produz a linha de log que **mente** — `pTrataResposta: id=N NAO
ENCONTRADO ... Isto e a causa provavel da trava pos-fPassarCartao investigada em 2026-09-02`.
A causa que ela acusa já não é a única: agora também acontece quando o teto de 30 s desiste.
**Ajuste de texto pendente.**

### O que rodou sozinho e se comportou

Exercitados em volume e sem intervenção: guarda de posse do pinpad (RF17 item 1, 3×), disputa
com `fResolveDisputaPinpad` + `fJanelaPrincipalTravada` (RF19/RN15, 5× — todas resolvidas sem
perguntar ao operador, `IsHungAppWindow=False`), reaplicação do `pGarantePinpadConfigurado` na
troca entre os terminais 003 e 004 (6×), login adiado (RF17 item 4 — adiado às 08:56:41 e
aplicado às 08:57:30, antes do `fPassarCartao`), fila local do serviço (RF07/RF21, 3 respostas
persistidas e reentregues, com o roteamento certo: às 08:55:17 o item do 72316 foi **mantido**
na fila até ele reconectar às 08:55:25) e o par `pAvisaOperadorOuGuarda` /
`pDespachaAvisoGuardado` (RF29 — aviso guardado às 08:46:00 sem tela aberta e entregue às
08:51:41, **5min41s depois**, prefixado com "Aviso da operacao anterior:").

## Os dois lados discordam do que é "uma conexão" (achado de campo 2026-09-16)

`messageId` reinicia "a cada conexão nova" — mas **conexão** não significa a mesma coisa nas duas
pontas, e é aí que mora um travamento permanente:

- **Estação** (`untTefEstacaoTcpTransporte.pas`): a conexão é o **socket TCP**, que morre junto
  com o processo. Reiniciou o serviço, o contador volta a 1.
- **AUTCOM** (`untTefCitelDvcTransporte.pas`): a marca d'água de dedup é do **canal DVC**, que no
  reinício do serviço **não cai**. Quem cai é o socket plugin→serviço, e o plugin reconecta
  sozinho e em silêncio — do lado do AUTCOM não acontece nada.

Resultado medido: serviço novo respondeu com `messageId=2`, o AUTCOM estava com a marca em 6, e a
resposta foi **descartada como duplicata**. Como o `fChamaRpc` espera com `WaitFor(INFINITE)` e só
é solto quando o canal cai (regra do topo deste arquivo — e o mesmo caminho carrega
`fPassarCartao`, então **não pode ganhar timeout**), o AUTCOM ficou parado para sempre.

O `fAceitaMessageId` já reconhecia "época nova", mas **pelo tempo** (`TEF_DVC_DEDUP_EPOCA_MS`,
30 s). O reinício do `TefEstacaoAtualizador.exe` leva ~1,5 s: indistinguível de retransmissão.
**Heurística de tempo não resolve esta classe de problema** — o que resolve é um sinal
determinístico de que a outra ponta recomeçou.

**Aplicado hoje (parcial):** `pAgendaZeraDedupPorReinicioDaEstacao`, chamada do fluxo de
atualização quando o `fAtuAplica` devolve `aplicado=true`. O pedido fica pendente até o
`messageId` **andar para trás**, e só então zera o dedup — não pode ser consumido pelo primeiro
quadro que chegar, porque entre o pedido e o reinício ainda chegam respostas do serviço velho com
o id subindo.

**Ainda aberto:** reconexão do socket plugin→serviço por qualquer outro motivo continua exposta ao
mesmo descarte e ao mesmo travamento. O conserto geral é um **tipo de quadro novo** emitido pelo
plugin na reconexão (mesma forma do `TEF_DVC_FRAME_TIPO_ACK` da Fase 2) — e aí vale a regra de
protocolo acima: os dois transportes alterados na MESMA sessão/commit, `fCrc32` idêntico nos dois.

**Regra prática:** ao mexer em dedup, retransmissão ou reconexão neste subsistema, perguntar *o que
exatamente reiniciou* — processo, socket TCP ou canal DVC — porque os três têm tempos de vida
diferentes e nenhum deles implica os outros.

## Contrato binário EXE ↔ `libTefCitel.dll` (2026-09-23) — três regras que o compilador não verifica

`libTefCitel.dll` não é biblioteca de terceiro: é binário interno, compilado da mesma árvore. Mas
ela **atravessa duas fronteiras de processo em duas máquinas** — `autcom.exe` no servidor e
`TefEstacaoService.exe` na estação — e nada no compilador garante que as pontas concordem.

### 1. Assinatura de export é contrato. `stdcall` não perdoa aridade

`fCriarTefCitel` é `stdcall`: **quem limpa a pilha é o callee**. Acrescentar parâmetro — mesmo com
default — muda o `ret N` da DLL. Default de Delphi é resolvido **no chamador**, em tempo de
compilação; não existe parâmetro opcional na convenção binária.

Consequência: um `.exe` que empilha 3 argumentos contra uma DLL que desempilha 8 bytes corrompe a
pilha **na primeira chamada**, sem exceção inteligível. `delayed` **não protege** — ele só cobre
export ausente, não aridade errada.

**Os consumidores são exatamente dois**, e os dois vivem nesta árvore:

| Consumidor | Onde declara |
|---|---|
| `autcom.exe` | `padra_atualizado\fontes\tef\TefCitel\untTefCitelUtil.pas` |
| `TefEstacaoService.exe` | `libTefCitel\Estacao\untTefEstacaoRoteadorMensagens.pas` |

**`autcom.exe` + `libTefCitel.dll` são um artefato de release indivisível** — a DLL é construída
pelo `autcom.groupproj` para dentro de `padra_atualizado\`, e sai junto.

**Na estação a coisa é mais frágil, e é onde o risco mora de verdade:** a Fase 6 entrega
`libTefCitel.dll` e `TefEstacaoService.zip` como **pacotes SEPARADOS, com hashes próprios**. Uma
carga pode aplicar um sem o outro. **Se a assinatura de qualquer export mudar, os dois pacotes têm
de ir na mesma leva** — publicar só a DLL deixa a estação com o serviço chamando com a aridade
velha.

### 2. Método novo em interface vai SEMPRE no fim

Método de interface ocupa slot ordinal na VMT. Inserir no meio desloca todos os posteriores em +1,
e um consumidor não recompilado passa a chamar **a rotina errada, sem erro** — o pior desfecho
possível. `QueryInterface` continua devolvendo o ponteiro sem reclamar.

Já aconteceu: o `fConteudoLogErro` nasceu no meio da `ITefCitel`, deslocando **28** métodos.
Corrigido antes do commit 1 (apontamento do DelphAI, 2026-09-22) — hoje ele é o **último** da
declaração.

Vale para `ITefCitel`, `ITefCitelV2` e para os **records** que cruzam a fronteira (`TCartao`,
`TDadosCartao`, `TInfoRequisicao`): campo novo no meio muda o layout e corrompe leitura.

### 3. Callback que a DLL chama de volta precisa de guarda própria

`pSetConfirmaTomadaPinpadTef` e `pSetProgressoAtualizacaoTef` registram callbacks `stdcall` que a
DLL invoca. Quem escreve o callback **não controla de qual thread ele vem** — e a DLL evolui sem
revisar o `.exe`.

`fConfirmaTomadaPinpadTefEvent` abre modal de VCL. Ganhou guarda de thread em 2026-09-23
(apontamento do DelphAI) que **recusa e registra** quando não está na thread principal.

**Recusar, e não sincronizar nem levantar**, por dois motivos já documentados aqui:

- `TThread.Synchronize` é a seção "Deadlock TThread.Synchronize x ACK" acima — se a chamada vier da
  thread de leitura, sincronizar prende quem entregaria o ACK. Espera circular, vista duas vezes;
- exceção cruzando a fronteira EXE/DLL é onde este requisito já se queimou, e `Assert` desaparece
  com `$ASSERTIONS OFF`.

Devolver `False` é o desfecho seguro: o pinpad **não** é tomado, que é o mesmo do botão padrão.

## O `MainThreadID` da DLL não é o do autcom (campo 2026-09-25) — quem carrega a DLL define quem drena a fila

`libTefCitel.dll` **não usa runtime packages**: ela linka a própria cópia da RTL. Logo ela tem o
*seu* `System.MainThreadID` e a *sua* lista de `TThread.Queue`, e o laço de mensagens do
`autcom.exe` não enxerga nenhum dos dois.

Esse `MainThreadID` nasce no `DLL_PROCESS_ATTACH` — ou seja, **na thread que disparar o primeiro
import `delayed`** (`untTefCitelUtil.pas`). E há duas portas, sem ordem garantida entre elas:

| Porta | Thread |
|---|---|
| `pIniciaTefCitel` — carga do operador | principal |
| `fInstanciaPixTef` — `TFatVendaBase.CarregaLibRequisicoesPix` → `CarregaLibIntegracaoPixCitel` → `TPixTefBridgeAutcom.Create` | **`TTask` de pool** |

Quem chega primeiro define o `MainThreadID` do processo inteiro.

### O estrago quando o `TTask` chega primeiro

O único dreno da fila de eventos é o `CheckSynchronize` de `fChamaRpcUmaVez`
(`untTefCitelDvc.pas`), atrás de `ThreadID = MainThreadID`. Com o valor errado esse teste nunca
mais é verdadeiro — e `CheckSynchronize` **levanta exceção** se chamado de outra thread, então não
existe como bombear de fora. A fila enche e nunca esvazia.

Campo, estação CTLDSDEVHB0922: **2954 eventos enfileirados, zero entregues**, nas duas sessões do
log. O pinpad pediu a escolha de parcelamento (`status="20" "Escolha uma Opção"` +
`status="21" "1:2:3::"`), a operadora nunca viu o menu, o Scope reperguntou **1436 vezes em 7
minutos** e o processo foi morto. Nas outras cinco linhas, nove logs, duas estações: **100% de
entrega**. O que mudava não era configuração — era qual thread tinha carregado a DLL.

### A regra

**Nunca presumir que o `MainThreadID` de dentro da DLL é a thread VCL do host.** O host informa —
e informa **no caminho que pode carregar a DLL fora da thread principal**, e só nele:

- export `pSetThreadPrincipalHost` (`untFuncoesLibTefCitel.pas`) atribui `System.MainThreadID`;
- o autcom chama no início de **`fInstanciaPixTef`**, antes de qualquer outra chamada à DLL naquele
  caminho, **só com `CFG_TEFDVC = 'S'` e `CFG_PIXSCP = 'S'`**. Como o import é `delayed`, a chamada
  carrega e acerta no mesmo passo;
- passa o `MainThreadID` **do EXE** — que é a thread da tela seja qual for a thread que executa. Por
  isso é seguro chamar de dentro do `TTask`, e não há guarda de thread;
- **não há chamada no login.** Sem Pix, quem carrega a DLL é a carga do TEF, já na thread principal,
  e nada precisa ser acertado. Máquina sem Pix e sem TEF nunca toca na DLL. A `.72`, que não tem o
  caminho Pix, não tem chamada nenhuma;
- a falha é **silenciosa** (`pGravaLogErro`). O `pSetConfirmaTomadaPinpadTef` logo abaixo já
  reporta DLL ausente com a mensagem própria dele.

**Duas versões erradas antes desta, as duas registradas para não voltarem:**

1. Chamada no login (`pInicializaVariavelGlobalPixScope`), **sem condição**: todo autcom passou a
   carregar a DLL, e quem não a tinha recebeu tela de `ELoadLibrary` sem ter pedido TEF.
2. Mesma chamada no login, **condicionada ao `VS_blnTefCitel`**: naquele ponto a global ainda não
   estava confiável, a chamada não aconteceu, e o defeito voltou em campo em 28/09 (8 eventos, 0
   entregues). Além disso amarrava o Pix à configuração de TEF de cartão, que não é dele.

Vale para **qualquer** DLL deste projeto que use `TThread.Queue`/`Synchronize` e não linke runtime
packages — não é uma particularidade do TEF.

### O que faz a regra não envelhecer sozinha

Não há infraestrutura de teste na zona legado, então o guardião é uma linha de log: na primeira
chamada RPC **de cada thread** (`threadvar`), `fChamaRpcUmaVez` grava
`MainThreadID da DLL=%d, thread que chama o RPC=%d (metodo "%s")`, diz em texto se coincidem e se
o host fez o acerto. **Foi a ausência exata desses números que transformou o diagnóstico de 25/09
numa manhã inteira.** Uma corrida que só aparece em uma máquina entre dez não se confirma por
leitura de código.

**Por thread, e não por processo** — a primeira versão era por processo, e isso a tornava cega por
construção: a primeira chamada do processo vem da thread que carregou a DLL, que sempre "coincide".
Em 28/09 ela disse `coincidem` para o `fConfiguraTefCitel` do `TTask` do Pix e ficou muda quando a
tela passou a chamar de outra thread.

**Como ler, com Pix ligado:** a thread da tela deve dizer `coincidem`; a do `TTask` do Pix diz
`NAO coincidem` — **e isso é esperado**: ela não tem tela, e esperar sem drenar é o certo para ela.
A prova final é sempre a contagem: `pNotifica` igual a `pTrataEvento`.

## Closure de `TThread.Queue` guarda as próprias exceções (campo 2026-09-28)

**O que escapa de uma closure enfileirada não volta para quem a enfileirou. Estoura dentro de quem
estiver bombeando a fila** — e neste subsistema quem bombeia é o `CheckSynchronize` da espera do
`fChamaRpcUmaVez`, ou seja, **uma transação em andamento que não tem nada a ver com a closure**.

### O caso

Transação em voo com outra pendente; hook `AntesPassarCartao` enfileirado; o callback do autcom
ficou ~17 s na tela; nesse meio-tempo a sessão do TS foi fechada e o canal caiu. Quando o callback
voltou, a closure mandou `hook_resposta` pelo canal morto — `ETefCitelDvcTransporte` *"Canal TEF DVC
nao esta conectado"*. Sem `try/except`, ela atravessou o `CheckSynchronize` e arrancou o
`fChamaRpcUmaVez` do `fPassarCartao` do meio da espera:

- a chamada ficou **órfã no `FdictChamadas`** (o `reata` seguiu pedindo por ela) e o `LPendente` vazou;
- a emulação local do `DepoisPassarCartao` não rodou — **a `LCKATC` não foi liberada**;
- a fila parou de ser drenada; o resto virou tela do madExcept.

A estação fez tudo certo: acordou o hook "SEM resposta" com o default seguro no instante da queda,
abortou pelo `pSair` e guardou a resposta na fila local.

### A regra

1. **Toda closure de `TThread.Queue` em `untTefCitelDvc.pas` tem `try/except` próprio, logando por
   `pLogaDiagnosticoDvc` e seguindo.** Hoje são três: `pTrataHook`, `pTrataEvento` e
   `pDespachaAvisoGuardado`. Closure nova entra na lista.
2. **No hook, as guardas são duas e separadas**: callback do autcom que falha responde `ok=False`
   (o mesmo default seguro da estação); envio que falha só loga — a estação já aplicou o default ao
   perder a conexão, então não há resposta a salvar.
3. **O `fChamaRpcUmaVez` protege a janela entre inscrever e retirar a chamada**: exceção nesse
   trecho retira do `FdictChamadas`, libera o `LPendente` e repropaga. Defesa em profundidade — com
   as closures guardadas isso não deveria mais disparar, mas a espera é o lugar que não pode vazar
   estado quando algo novo escapar.

Engolir exceção de código de tela parece esconder defeito. Não esconde: ela fica no log com classe e
mensagem. O que a regra impede é o contrário — uma mensagem de andamento derrubar uma transação.

## O mesmo callback não faz a mesma coisa em todas as linhas (campo 2026-09-29)

O external `^/libTefCitel` é **um só**; o autcom que o usa **não é**. Cada linha trouxe sua própria DLL
antiga, e o contrato entre a DLL e o autcom daquela linha não era o mesmo.

### O caso

Em 31/08 o `SucessoTefCartao` saiu do fio porque *"o callback do autcom é um no-op"* — lido na `.150`.
Na **`.74.111`** e na **`.72`** ele **gravava a TEFTRA**: a DLL antiga completava o
`IDadosAdicionaisTefTra` (modalidade, operação, parcelas, pré-pago) e chamava o callback, que gravava o
pendente e a TRADOC. Ao convergir para o external, que não faz isso, a linha da TEFTRA passou a nascer
só no `pGravaTransacaoFinalizada`, com operação vazia: `TFT_DESTRA`, `TFT_TIPOPE`, `TFT_MODALI`,
`TFT_QTDPAR`, `TFT_NUMCCD` e os comprovantes em branco, TRADOC sem vínculo. A tester viu o `TFT_DESTRA`.

### O conserto — no autcom de cada linha, no modelo DAQUELA linha

| Linha | Quem grava | Modelo |
|---|---|---|
| `.150`, `.150.100`, `.150.45` | `pAtualizaTefTraComDadosAdicionais` (já existia) | três gravações: INICIADA / PENDENTE / CANCELADA, e a tela grava a cada escolha de modalidade |
| `.74.111` | `pAtualizaTefTraComDadosAdicionais` (portado) | o da `.150`, mas **TRADOC só na gravação com retorno** — `pGravaDocumentosTefTra` insere sem conferir |
| `.72` | `pGravaTefTraDaTransacao` (novo) | **uma** gravação, no sucesso — como sempre foi lá; a tela só guarda a escolha no objeto |

A `.72` não recebeu o modelo de três gravações de propósito: o `pGravaTransacaoPendente` dela nem tem
parâmetro de status. Uniformizar teria sido introduzir comportamento que a linha nunca teve.

### A regra

**Antes de tirar, emular ou "simplificar" qualquer callback ou hook entre a DLL e o autcom, ler o
callback em TODAS as linhas que usam o external — não só na que se tem aberta.** "No-op" é afirmação
sobre um arquivo, não sobre o contrato.

E o corolário para convergência: **ao trocar a DLL de uma linha pelo external, listar o que a DLL
antiga daquela linha fazia e o external não faz** (`svn cat` da pasta apagada, na revisão anterior à
exclusão). Na `.74.111` isso estava anotado como risco desde a propagação, e a conferência da TEFTRA
ficou para depois — foi a tester que achou.

**Ainda por conferir:** na `.150` a TRADOC é gravada em todas as passagens (3 a 4 por transação) sem
checar se o vínculo existe. Pode estar duplicando. Um faturamento de orçamento na `.150` e uma consulta
na TRADOC pelo `TRD_NUMDOC` respondem.
