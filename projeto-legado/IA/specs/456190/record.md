# Registro de sessões — Req. 456190 (TEF via canal DVC)

Retrospectiva das investigações: a jornada, as hipóteses que foram descartadas e por quê, e as
decisões que não cabem no texto curto do `analysis.md` nem no checklist do `tasks.md`.

Regra técnica permanente do subsistema: `IA\rules\tef-dvc.md` (indexada no `CLAUDE.md`).
Histórico cronológico detalhado da implementação: `tasks.md`.

---

## 2026-09-02 / 09-03 — "Mensagem de uma transação aparecendo na transação seguinte"

### Como o problema chegou

Rafael relatou como "bug de cache de mensagens": numa transação de débito negada pela adquirente, a
mensagem aparecia corretamente para o operador; ao iniciar a transação seguinte (crédito), **a
mensagem do débito reaparecia logo no começo dela**. O operador dava OK e a nova transação seguia.

Detalhe que só ficou claro depois, e que foi decisivo: na primeira transação apareciam DUAS mensagens
diferentes — a genérica ("Houve um problema com a transação. Verifique no relatório do TEF...") e a
específica com o motivo ("Cartao Debito / NAO AUTORIZADA"). O operador via só a primeira; **a segunda
é que atrasava** e ia parar na transação seguinte.

### Hipóteses levantadas e descartadas

1. **"Cache" literal de mensagens** (o nome que o problema recebeu). Existe um
   `FdictMensagensDePara` em `untTefCitelNCR.pas`, mas é tabela estática de normalização de texto,
   carregada no início — não guarda estado de transação. Descartada por leitura de código.

2. **Observer vazando entre transações** — a tela `TfrmTefCitelOperacoes` é criada, registrada como
   observer, exibida com `ShowModal` e destruída a cada tentativa de cartão
   (`TfrmRcxDigCartoesController.fChamaTelaDeOperacoes`). A hipótese era que o `RemoveObserver` não
   estivesse removendo, deixando uma referência pendurada para um form já liberado — agravado pelo
   fato de o Delphi reaproveitar o mesmo endereço de memória na instância seguinte. **Descartada com
   prova**: a instrumentação mostrou `AdicionaObserver`/`RemoveObserver` sempre pareados, com
   `total antes=0` e `total antes=1` alternando corretamente, e `pNotifica` sempre despachando para
   exatamente 1 observer.

3. **Reordenação de quadro no transporte** (`quadro duplicado descartado (messageId=73, ultimo
   aceito=74)`). Levou à descoberta de um gap real — `pEnviaAck` atribuía o `messageId` e enviava o
   quadro em dois passos sem lock, o mesmo padrão já corrigido em `pEnviaUmFragmento` no dia anterior.
   **Foi corrigido nos dois lados, mas NÃO era a causa**: perder ou reordenar um ACK é benigno por si
   só (o remetente reenvia o quadro DADO, o receptor deduplica e reenvia o ACK). Ficou registrado no
   código e na regra que esse fix não explica a trava, justamente para não induzir a erro quem ler
   depois.

### A causa raiz (provada com log em 2026-09-03)

`pTrataEvento` entrega os eventos à thread principal via `TThread.Queue` — assíncrono por necessidade
(entregar de forma síncrona causava o deadlock já documentado na regra). Só que essa fila **só é
drenada enquanto a thread principal bombeia**, e ela só bombeia dentro do laço de espera de
`fChamaRpc`. Esse laço saía no instante em que o `Evento` era sinalizado, **sem uma última drenagem**.

O último evento de uma transação — justamente o status=500 com o motivo da negação — chega alguns
milissegundos ANTES da resposta RPC do próprio `fPassarCartao`:

```
07:30:58.172  pTrataEvento: status="500" "Cartao Debito NAO AUTORIZADA" - enfileirando
07:30:58.182  pTrataResposta: recebido id=3   <-- 10 ms depois; destrava fChamaRpc, para de bombear
              (nenhum pNotifica correspondente - closure ORFA)
07:32:47.116  pNotifica: despachando status="500" ...  <-- 1min49s depois, na transacao SEGUINTE
```

Como `pNotifica` só enxerga o `FObservers` do momento em que roda, a entrega atrasada ia para a tela
nova. E, por ser um `fMensagem` MODAL na frente da closure do hook `AntesPassarCartao` na fila FIFO,
prendia o hook até o operador clicar OK — estourando os 30s de `TEF_ESTACAO_TIMEOUT_HOOK_MS` na
estação e derrubando a transação nova inteira ("Transacao cancelada"/"Erro Desconhecido (-1)").

### O que mais aprendi no caminho

- **A instrumentação foi o que virou o jogo.** O caminho de "evento" era o único do protocolo sem log
  nenhum (`resposta` e `hook` já logavam). Enquanto ele foi cego, três hipóteses plausíveis
  concorreram sem desempate; assim que passou a logar chegada, despacho e contagem de observers, a
  causa apareceu em um único par de linhas.
- **Errei ao descartar cedo demais.** Num teste intermediário o `pNotifica` do status=500 apareceu
  normalmente, e eu tratei isso como refutação da hipótese — quando na verdade era só a corrida
  caindo do lado bom naquela execução. Bug de corrida não se refuta com uma execução boa.
- **Revisar a própria correção pegou um bug que ela teria introduzido**: a drenagem final rodava
  antes do `finally` que libera o guard de método duplicado. Um `status="131"` drenado ali dispararia
  `pInfo21` — o padrão da Modalidade Dinâmica, dezenas de vezes em qualquer log — e o guard rejeitaria
  essa chamada legítima em silêncio. Por isso o `Remove` do `FdictMetodosEmAndamento` foi antecipado.

### Encoding: armadilha recorrente desta sessão

O hook `.claude/hooks/delphi-encoding.ps1` não dispara na extensão VSCode. **Toda** edição via Edit em
`.pas` desta sessão corrompeu acentuação pré-existente em pontos distantes da linha tocada — duas
vezes virando `C3 B3` (UTF-8 no meio de um arquivo Windows-1252) e uma vez virando `EF BF BD`
(U+FFFD, perda irreversível; só deu para restaurar porque a palavra era conhecida: "propósito").

**Procedimento que passou a ser aplicado, e que vale manter:** depois de cada Edit num `.pas`,
escanear os bytes ≥ 0x80 e corrigir via PowerShell (`ReadAllBytes`/`WriteAllBytes`), nunca via Edit.
Descoberta paralela: 5 arquivos novos da feature estavam com LF puro em vez de CRLF — provado
pré-existente porque 3 deles (os do ClientPlugin) não foram tocados em nenhuma sessão. Os 2 editados
foram normalizados; os 3 do plugin ficaram pendentes, por decisão de não mexer em arquivo fora do
escopo sem combinar.

### Validação

Bateria aprovada em campo por Rafael (2026-09-03): débito + crédito; débito negado seguido de outro
cartão que autoriza (o cenário original); cancelamento de transação; desfazimento de transação.
No log: `pNotifica` do status=500 saindo no mesmo milissegundo da resposta, hook respondendo em 47 ms
em vez de estourar 30s, e nenhuma linha `pNotifica: DESCARTADO` — a rede de segurança por geração de
observer não precisou entrar em ação em nenhum momento.

---

## 2026-09-04 — A trava de `fChamaRpc` aninhada tinha uma segunda causa

### Como chegou

Testando o Passo 6 (reaplicação de configuração por PID), Rafael reportou como regressão: a tela
não fechou numa transação negada. Sintoma idêntico ao bug fechado em 02/09 — e que estava marcado
como RESOLVIDO, investigação encerrada.

### O que os logs mostraram

O `fPassarCartao` respondeu certinho (id=3, 15:04:41.984). Quem ficou preso foi um `pInfo21`
**aninhado** (id=7), cuja resposta — `messageId=23` — nunca chegou. O serviço retransmitiu 2 s
depois por falta de ACK, e aí:

```
15:04:32.355  quadro duplicado descartado (messageId=23, ultimo aceito=24) - reenviando ACK mesmo assim.
```

O dedup por ordem estrita confundiu **retransmissão legítima** com duplicata. Pior: re-ACKou, então
o emissor deu por entregue e parou de retransmitir. Resposta perdida pra sempre; a `fChamaRpc` de
dentro nunca desenrolou e a de fora, abaixo dela na mesma pilha reentrante, também não.

### Por que o quadro se perdeu — e por que a conclusão de 02/09 estava incompleta

A corrida de ordenação **estava mesmo corrigida**: no log, o 23 foi escrito antes do 24 nos dois
lados (o worker FIFO do plugin prova). A perda é outra coisa.

Contando os `erro 996` do log, o padrão é de 13 em 13: todo 996 que **não** estava a 15000 ms
exatos da leitura anterior caiu entre o `Enviando envelope` e o `enviado com sucesso` da thread
principal, sempre a ~1 ms da escrita. A conexão do segundo AUTCOM, que não escreveu nada depois do
login, só teve os de 15 s — grupo de controle perfeito.

`WTSVirtualChannelRead` e `WTSVirtualChannelWrite` compartilham o estado overlapped do mesmo handle,
e nada serializa escrita contra leitura (`FcsEscrita` só protege escritor contra escritor). Toda
escrita aborta a leitura pendente, que volta com `ERROR_IO_INCOMPLETE` (996) — exatamente o código
que o transporte trata como "timeout". Quase sempre os bytes sobrevivem para a leitura seguinte;
naquele caso, não. Isto também explica o "chunk WTS duplicado" que já tinha contorno em
`fProcessaChunkWts`: mesma raiz, sintoma espelhado.

### Hipótese descartada

**"É regressão do Passo 6."** Foi a leitura inicial, e está errada: o Passo 6 só mexeu no roteador
(despacho de método no serviço), nada no transporte. O mecanismo da perda existe desde que o
transporte foi escrito, e a janela fatal desde o protocolo v2 (dedup por ordem estrita, 31/08).
O log de 996 está dentro de `$IFDEF DEBUG` — em build de produção nada disso apareceria.

### Correção

Dedup por **conjunto dos últimos 512 ids aceitos** (`fAceitaMessageId`) nos dois lados, no lugar da
marca d'água. `FdwUltimoIdRecebido` continua, mas só como diagnóstico. Novo log
"quadro ATRASADO aceito", fora da diretiva DEBUG, para que cada perda fique visível em campo.

Perda no trecho DVC passa a custar ~2 s de atraso em vez de trava permanente. A **causa da perda
continua aberta**: o conserto certo é uma thread única dona do handle (leitura com timeout curto +
fila FIFO de escrita drenada no mesmo laço, igual ao `pLoopEscritaWorker` do plugin), e isso é
reescrita do núcleo do transporte — decisão separada, com o dedup consertado a perda deixou de
ser fatal.

### Lição

### Validação em campo (2026-09-04, 15:42–15:49)

O teste reproduziu a falha e provou a correção no mesmo ponto exato: `messageId=23`, resposta do
`pInfo21` id=7 — o mesmíssimo quadro do log de 15:04. Sequência completa:

```
15:45:11.594  [servico]  sem ACK do messageId=23 apos 2000 ms (tentativa 1/5) - reenviando.
15:45:11.646  [autcom]   quadro ATRASADO aceito (messageId=23, maior aceito=25) - primeira
                         entrega perdida no canal, recuperado pela retransmissao do emissor.
15:45:11.647  [autcom]   pTrataResposta: id=7 encontrado em FdictChamadas - sinalizando Evento.
15:45:20.718  [autcom]   pTrataResposta: recebido id=3   (fPassarCartao desenrolou)
15:45:21.844  [autcom]   RemoveObserver                  (a tela fechou)
```

Segunda recuperação idêntica no `messageId=33` (`pInfo21` id=9), às 15:45:19.855. Zero
`quadro duplicado descartado` no log inteiro — o dedup por conjunto não gerou falso positivo.

Depois disso, três transações completas sem perda nenhuma: A autorizada (`Controle 09404183005`,
resposta fragmentada de 2203 bytes remontada corretamente) + `fFinalizarTransacao` id=16; B negada
e B autorizada (`Controle 09402114002`) + `fFinalizarTransacao` id=17.

**Taxa de perda medida:** 2 quadros em ~90 na conexão do AUTCOM A, zero nas demais. Alta o bastante
para justificar atacar a causa, e é o argumento que faltava para a decisão da thread única.

Como subproduto, o Passo 6 ficou validado nas **duas direções** — 003→004 e 004→003:

```
15:44:51.752  "fPassarCartao" do pid=50264, DLL esta no pid=58520 (004) - REAPLICANDO (003)
15:47:59.533  "fPassarCartao" do pid=58520, DLL esta no pid=50264 (003) - REAPLICANDO (004)
```

E o `pOnDesconectado` por conexão apareceu no fechamento das duas conexões, com `0 hook(s)` em
ambas — o filtro está observável em log, mesmo quando não tem nada a fazer.

### Lição

Em 02/09 o Rafael sugeriu justamente o dedup por conjunto de ids já vistos, e eu descartei como
"desnecessário, corrigir na origem é suficiente e mais simples". Estava errado: havia uma segunda
origem que eu não tinha mapeado, e o dedup tolerante teria absorvido as duas. Quando o protocolo
já traz um mecanismo de recuperação (retransmissão), **não anular esse mecanismo confiando que a
única causa conhecida é a única causa** — ele existe para as causas que ainda não se conhece.

---

## 2026-09-04 — O Passo 7 funcionou e estava errado

### O que o teste mostrou

Cenário: A (terminal 003) autoriza e não finaliza; trava `LCKATC` fora do caminho; B (terminal 004,
**outra empresa**) inicia transação. O log do serviço é impecável — orfanou o A com
`Transacao pendente de confirmacao: True`, marcou, reaplicou para o B, e depois recusou o
`fFinalizarTransacao` tardio do A com a mensagem da RF19.

Só que a transação pendente do A **foi resolvida pela transação do B**. Recusar o A depois não
adianta se o que ele iria confirmar já foi confirmado por outro.

### Por que não tem contorno do nosso lado

Leitura das units de terceiro (off-limits, mas legíveis):

- `FechaSessaoTEF(SCO_CONFIRMA_TEF)` **não recebe identificador de transação** — confirma o que
  estiver pendente na sessão global. Chamado por `fFinalizarTransacao`
  (`untTefCitelNCR.pas:980`), por `fVerificaPresencaPinPad` (`:2013` — uma *verificação de
  presença* confirma pendência alheia) e por `AbreSCOPE` com `_Desligou=True`
  (`untScopeNCR.pas:867`).
- `FintSinc`, `FstrEmpresa`, `FstrFilial`, `FstrPdv` são globais de unit (`untScopeNCR.pas:474`):
  uma sessão Scope por processo.
- `AbreSCOPE` só chama `ScopeOpen` quando `(FintSinc and INI_COMUNIC) = 0` (`:852`) — a sessão fica
  aberta com os dados do primeiro AUTCOM que configurou.

**Não existe endereçamento de "a transação do AUTCOM A".** Há um slot de pendência para o processo
inteiro. Logo, tomar o pinpad de um AUTCOM vivo nunca é seguro, por mais cuidado que se tenha com o
objeto Delphi dele. O desenho da RF17 item 2 estava errado desde a origem; o Passo 7 só o executou
fielmente o bastante para isso aparecer.

### A brecha que o Rafael identificou

A `LCKATC` é **por empresa**. Dois AUTCOM de empresas diferentes nunca foram serializados por ela —
e é exatamente o caso do teste. Ou seja: não havia nenhuma proteção nesse cenário, nem antes da
Fase 3.5.

### Correção (aprovada em 2026-09-04)

RF17 item 2 inverte: **AUTCOM vivo com pendência bloqueia; AUTCOM ido libera.** O critério de "vivo"
é a conexão TCP, e sai de graça — desde o Passo 7 a sessão é removida do `FdictSessoes` na
desconexão, então tudo que está no dicionário pertence a uma conexão aberta.

Isso é a `LCKATC` implementada onde ela pode de fato ser cumprida: o serviço é o único ponto do
sistema que enxerga todos os AUTCOM da estação independentemente de empresa.

A marca de pendência abandonada (RF19 antiga) saiu — 73 linhas. Ficou inalcançável: um AUTCOM só
perde a instância desconectando, e volta com PID novo.

### Dois furos abertos pela própria correção, fechados na revisão

1. O early-exit "nunca mandou `fConfiguraTefCitel`" estava no topo de `pGarantePinpadConfigurado`,
   antes dos itens 1 e 2 — um AUTCOM sem config furaria as duas guardas de posse. Só o item 3
   depende da config da própria sessão; o early-exit desceu para junto dele.
2. Com a recusa valendo para todo método de pinpad, o `pSair` do B passaria a ser recusado enquanto
   o A detém o pinpad, prendendo o operador na tela do TEF do B
   (`TfrmTefCitelOperacoes.pEncerrar` chama `pSair` sem `try/except` e só faz `Self.Close` depois).
   Deixar passar seria pior — `pSair` fecha sessão/pinpad na DLL compartilhada. Resolvido
   respondendo `pSair` como no-op quando outro AUTCOM detém o pinpad.

### O que continua não protegido, por decisão

A com pendência é **morto** e B transaciona → a pendência do A pode ser resolvida pelo B. Não há
como impedir com um slot único. É a perda que o Rafael já havia aceito em 2026-09-03 ("não tem
importância se alguma transação TEF ficar pendente, pois isso já ocorre caso o autcom trave") e não
é regressão. A correção protege o caso evitável, que é o do AUTCOM **vivo**.

### Encerramento da sessão de 2026-09-04

Entregue e validado em campo: correção da perda de quadro (dedup por conjunto), Passo 6
(reaplicação de configuração por PID, nas duas direções) e Passo 7 na forma revista (recusa por
AUTCOM vivo, orfanamento só na desconexão, coleta no ocioso).

Entregue **sem** validação: a apresentação da recusa como negativa (evento 500), pedida no fim do
dia. É o primeiro item da próxima sessão.

O dia teve duas reprovações de desenho em campo, ambas úteis: o dedup por ordem estrita anulando a
retransmissão, e o orfanamento de AUTCOM vivo. As duas tinham a mesma forma — uma premissa sobre o
código de terceiro que só o teste real desmentiu. O que sobrou disso está na seção 9.3 da
`specs.md`, que hoje é o lugar onde essas restrições ficam registradas antes de virarem desenho.

## 2026-09-08 — O login do AUTCOM B confirmava a transação pendente do AUTCOM A

### Como apareceu

Não apareceu num teste. O Rafael descreveu o cenário que ia rodar — "A com transação pendente, subo
o B, quero ver o B carregar com TEF habilitado e a trava pegar na transação" — e a leitura do
`fConfiguraTefCitel` nativo, feita **antes** do teste para saber o que esperar, mostrou um terceiro
efeito que nenhum dos dois pontos observava.

`untTefCitelNCR.pas:618`, com `blnSomenteCarregarLib = False`:

| Linha | O quê | Efeito com A pendente |
|---|---|---|
| 629–631 | grava `FstrEmpresa`/`FstrFilial`/`FstrPdv` | sobrescreve os do A (globais de unit) |
| 663 | `AbreSessaoTEF(True)` | **não faz nada** — `untScopeNCR.pas:1025` sai fora, `INI_SESSAO` já setado |
| **685** | **`FechaSessaoTEF(1, 1)`** | `SCO_CONFIRMA_TEF` + `bForcar=1`; a guarda de `:890` passa pelo `bForcar` e **confirma a pendência do A** |
| 688 | `FintSinc := 0` | apaga `INI_SESSAO`/`INI_COMUNIC`, **fora** do `if` |

### O teste confirmou, e o relógio provou

- 08:16:00 — A (term. 003, pid 71824) loga. `fConfiguraTefCitel`: **4,4 s**
- 08:17:57 — A autoriza o `Controle 09804893005`, não finaliza
- **08:18:40 — B (term. 004, pid 86276) loga. `fConfiguraTefCitel`: 1,25 s**
- 08:19:38 — B tenta transacionar → trava atua corretamente
- 08:20:03 — A finaliza, confirmando algo que já não existia

A diferença **4,4 s × 1,25 s** é a assinatura do diagnóstico: no login do B o `AbreSCOPE` foi pulado
e sobrou só o confirm. O extrato do adquirente fechou a prova — o Controle do A autorizado às
08:17:51, antes de o operador ter clicado em qualquer coisa no A.

### Por que as guardas do Passo 7 não pegavam

`fConfiguraTefCitel` está fora de `fMetodoUsaPinpad` **de propósito** — o comentário diz "ela É a
configuração". Como `pGarantePinpadConfigurado` só roda para métodos daquela lista, nem o item 1
(em voo) nem o item 2 (pendência) eram consultados no login.

O detalhe incômodo: a **RF16 já dizia** que `fConfiguraTefCitel` com `blnSomenteCarregarLib = False`
passa pela sequência da RF17. A spec estava certa desde o começo; foi a implementação que abriu a
exceção. Vale como lição de revisão: uma exclusão justificada por um bom motivo ("ela É a
configuração") escondeu que o mesmo método faz uma segunda coisa, sem relação com configurar.

### A premissa da 9.3 que estava errada

A seção 9.3 trazia, desde 09-03, este bullet:

> No caminho do login, `fValidouPinPad` sai na primeira linha quando a trava está tomada […] Logo,
> **o login de um AUTCOM com o TEF em uso por outro não toca o pinpad.**

A frase é verdadeira e a conclusão é perigosa. Não tocar o **pinpad** não é não interferir: o login
não mexe no pinpad e ainda assim confirma a transação do outro. O bullet ficou, marcado como
refutado, junto do novo — errado apagar, porque o raciocínio que levou até ele volta a acontecer.

### A correção (RF17 item 4)

Recusar o login não era opção: o AUTCOM precisa subir com o TEF habilitado. Então o login é
**adiado** — o serviço guarda os argumentos em `FstrCfg*`, marca `FblnCfgRecebida`, **não chama a
DLL nativa**, deixa `FstrConfigAplicada`/`FdwPidConfigAplicada` intactos (a DLL de fato continua do
detentor) e responde `0`. A configuração real entra na primeira chamada de pinpad, pela reaplicação
do item 3 — que, enquanto o detentor não resolver, é recusada pelo item 2.

**Descartado: forçar `somenteCarregarLib = True`.** Reduz o dano e não zera. As linhas 629–631 ainda
sobrescrevem loja/filial/PDV com os do AUTCOM novo, e a linha 688 está fora do `if` — apagaria
`INI_SESSAO`/`INI_COMUNIC` com a sessão Scope do detentor genuinamente aberta, e a próxima chamada
do detentor reabriria sessão com a loja/PDV errados. Adiar tudo não toca em nada.

### Duas coisas que entraram junto

1. **A guarda cobre também a transação EM VOO**, não só a pendência — por isso usa
   `fOutroAutcomDetemPinpad` e não `fSessaoVivaComPendencia`. Reconfigurar a DLL no meio de um
   `fPassarCartao` alheio é pior que confirmar a pendência dele. Esse caso nunca foi testado e
   também nunca esteve protegido.
2. **`FcsPinpad` passou a cobrir `fMetodoFConfiguraTefCitel` inteiro.** Até hoje ele só era tomado
   na escrituração do final: dois logins simultâneos, ou um login concorrente com a reaplicação,
   entravam na DLL nativa sem serialização nenhuma. Ordem `FcsPinpad` → `FcsTransacao`/`FcsInstancia`,
   a mesma de `pGarantePinpadConfigurado` — conferido que nenhuma seção de `FcsInstancia` toma
   `FcsPinpad`, então não há inversão.

### Efeito colateral aceito

Entre o adiamento e a reaplicação, o AUTCOM novo é uma sessão viva cuja configuração a DLL nunca
viu. Métodos fora de `fMetodoUsaPinpad` que ainda assim entram na DLL — `pRetornaLog`,
`fObtemVersao`, `fTraduzirErro`, `fInfoPixCadastro` — rodam com a configuração do detentor. São os
que a própria função classifica como "não tocam o pinpad": o risco é de rótulo em log, não de
transação.

### Padrão que se repete

Terceira vez no requisito que uma premissa sobre o código de terceiro só cai no teste real
(dedup por ordem estrita, orfanamento de AUTCOM vivo, e agora o login). A diferença desta é que a
leitura de código chegou **antes** do teste — o teste virou confirmação de um diagnóstico, não
descoberta de um sintoma. Vale repetir o método: quando o cenário envolve um caminho novo entrando
na DLL de terceiro, ler o caminho inteiro antes de rodar, mesmo quando o objetivo declarado do teste
é outro.

### Estado ao fim da manhã

`TefEstacaoService.exe` recompilado 08/09 09:09, 0 erros (sobra o `W1002` da linha 310, pré-existente,
do `DELAYED`). **Não testado** — é o primeiro item da próxima sessão, com o roteiro no
`PONTO DE PARADA` do `tasks.md`. A `libTefCitel.dll` do AUTCOM não mudou.

### Validação da RF17 item 4 e o achado que veio junto (2026-09-08, meio-dia)

O teste de 09:28–09:33 confirmou o login adiado nos três sinais: linha `ADIADO` às 09:29:59.808,
login do AUTCOM B em **3 ms** (09:29:59.805 recv → .808 resposta, contra 4,44 s de um login real e
1,25 s do caminho nocivo) e a transação do A preservada.

**Ganho que ninguém tinha previsto:** o `fFinalizarTransacao` do A às 09:30:48 **não precisou de
reaplicação de configuração** — não há linha de `pGarantePinpadConfigurado` antes dele, e ele levou
1,23 s. No teste da manhã o mesmo passo custou 4,4 s de reaplicação (08:20:03→08:20:08). Como o B
nunca sobrescreveu a configuração da DLL, a impressão digital do A continuou casando. Adiar o login
tirou uma reconfiguração inteira do caminho crítico de confirmar a transação.

#### O achado: a marca de pendência era incondicional

O Rafael estendeu o teste e o log mostrou outra coisa. A marca `FblnTransacaoPendenteConfirmacao`
era escrita em dois lugares só, pelo **nome do método**, sem olhar o resultado: `True` depois de
`fPassarCartao`/`fCancelaTransacaoTerminal`, `False` só depois de `fFinalizarTransacao`.

Três fatos que se somam:

1. **O AUTCOM não finaliza uma negativa.** O log prova duas vezes: negativa às 09:29:06 seguida
   direto de outro `fPassarCartao` às 09:29:11, e negativa às 09:31:24 seguida de `fPassarCartao`
   às 09:32:11. Nenhum `fFinalizarTransacao` no meio.
2. **O nativo já desfaz sozinho.** Os caminhos de falha de `fPassarCartao` chamam
   `FechaSessaoTEF(SCO_DESFAZ_TEF)` (`untTefCitelNCR.pas:1814` e mais cinco pontos). Depois de uma
   negativa ou cancelamento não há nada pendente no Scope.
3. Logo, a marca ficava `True` **sem pendência real**, até o AUTCOM fechar.

Consequência: **um cartão negado no terminal 003 bloqueava o 004** pelas RF17 itens 2 e 4. Apareceu
no log às 09:33:35 — o aviso RN09 de `pOrfanaSessao` disparou para o pid 93700 cuja última
transação tinha sido **cancelada** no pinpad (`Transacao cancelada` + `Erro Desconhecido (-1)` às
09:33:25-27). Não havia o que avisar.

Vale registrar o sentido do erro: bloqueava demais, nunca de menos. Problema de disponibilidade, não
de dinheiro — por isso não era urgente, mas em produção, com cartão negado sendo rotina, travaria o
outro terminal com frequência.

#### A correção, e por que o critério é o retorno

`untTefCitelNCR.pas:1720` inicia `Result := Nil` e só atribui `Result := FRetorno` na linha 1834,
dentro do `else` de `if LintRet <> SCO_SUCESSO`. `fCancelaTransacaoTerminal` (`:484`) segue o mesmo
padrão. **Retorno preenchido é sinônimo de transação autorizada** — não é heurística, é a estrutura
da função. O log já dizia isso pelos tamanhos: resposta de 54 bytes numa negativa e 55 num
cancelamento, contra 2203 numa autorizada.

**Sem retorno a marca não é tocada — nem posta, nem limpada.** Limpar seria o lado perigoso, e há um
caso real que depende disso: no fluxo de múltiplos cartões o nativo **pula** o `DESFAZ` quando já
havia sessão aberta (`FblnMultCartoes`, `:1781` e `:1813`), justamente porque o cartão anterior
continua pendente. Lá o primeiro cartão já marcou `True` e o segundo, que falhou, tem que deixar a
marca como está.

#### Duas confirmações menores do mesmo log

- O `pSair` do A às 09:33:24 foi **despachado de verdade**, não no-op — correto, o A detinha o
  pinpad, e cancelou a própria transação dele. É o FURO 2 exercitado pelo lado que ainda não tinha
  sido testado.
- Sem perda de quadro em nenhuma das três conexões (`messageId` contíguos).

#### Curiosidade em aberto

O envelope de evento cresceu **248 bytes** entre a primeira e a segunda rodada do mesmo AUTCOM na
mesma conexão: `Aguarde... /` com 271 bytes às 09:29:14 e 519 bytes às 09:33:21; `Aproxime, Insira
ou Passe o Cartao` de 292 para 540. Constante, sempre +248. Entre os dois momentos o outro AUTCOM
logou, transacionou e saiu, e o A passou por uma reaplicação. Suspeita: acúmulo no `contexto`
(`AddInfo` / `pSetDadosAdicionaisTefTra`). Anotado para o Passo 9.

### A pendência condicional funcionou, e a bateria de testes achou a segunda metade dela (2026-09-08, tarde)

O Rafael rodou uma bateria das 10:23 às 10:35 com dois AUTCOM. A 1ª revisão da RN06 apareceu **seis
vezes** no log, todas corretas: negativa às 10:24:51; cancelamento no pinpad às 10:27:28, 10:28:59 e
10:29:26; e em `fCancelaTransacaoTerminal` às 10:31:19 e 10:35:03. Nenhuma delas marcou pendência, e
o `pOrfanaSessao` do pid 131636 às 10:29:33 saiu com `Transacao pendente de confirmacao: False` —
antes teria saído `True` e disparado o `ATENCAO` da RN09 em falso.

#### O que o último teste pegou

Cenário do Rafael: cancelar no A (cancelou no pinpad), depois cancelar no B (deu certo), voltar ao A
e tentar cancelar → **trava**. Só liberou quando ele fechou o AUTCOM B.

A trava estava **certa** pelo desenho de então:

- 10:33:39 — o pid **118320** (terminal 004) cancelou **com sucesso**: `Controle 09802524008`,
  "Transacao completa", resposta de 1945 bytes. Marca → `True`.
- 10:33:58 — o pid **93852** (terminal 003) tentou cancelar e foi recusado, nomeando o 004.
- 10:34:33 — o 004 fechou, órfão com `pendencia True` e o `ATENCAO` da RN09.
- 10:34:52 — o 003 conseguiu cancelar ("Transacao Ja Cancelada").

O erro não estava na trava e sim na premissa: **um cancelamento bem-sucedido não deixa pendência.**

#### A leitura que fechou a questão

Comparando os três métodos que devolvem `IRetornoTEFCitel` no sucesso:

| Método | No caminho de sucesso | Deixa pendência? |
|---|---|---|
| `fPassarCartao` (`untTefCitelNCR.pas:1834`) | `Result := FRetorno`, **sem** `FechaSessaoTEF` | **sim** |
| `fCancelaTransacaoTerminal` (`:576`) | `FechaSessaoTEF(SCO_CONFIRMA_TEF)` e **só então** `Result := FRetorno` | não |
| `fReimpressao` | idem cancelamento | não |

E a confirmação independente veio do lado do AUTCOM: `TfrmTefCitelAdministracao` — a tela do print
do Rafael — chama `fCancelamentoNormal` e, no sucesso, só exibe "Transação cancelada com sucesso!"
(linha 837). A unit **não tem uma única referência** a `fFinalizarTransacao`. Ela não precisa
confirmar porque não há o que confirmar. Duas leituras independentes, mesma conclusão.

#### O critério, agora enunciado direito

Não é "esta chamada gera transação?" nem "devolveu retorno?". É: **devolveu retorno deixando a
sessão Scope aberta?** Só o `fPassarCartao` faz isso. Qualquer método novo que entre na lista tem de
ser lido até o `FechaSessaoTEF` antes de decidir.

#### Padrão do requisito, agora com quatro casos

Quatro premissas sobre o código de terceiro caíram aqui, sempre da mesma forma — o que parecia
óbvio pela assinatura do método não era o que ele fazia lá dentro:

1. dedup por ordem estrita anulando a retransmissão (04/09);
2. orfanar AUTCOM vivo, com `FechaSessaoTEF` sem identificador de transação (04/09);
3. `fConfiguraTefCitel` do login carregando um confirm embutido (08/09 manhã);
4. `fCancelaTransacaoTerminal` confirmando a si mesmo (08/09 tarde).

Das quatro, só a terceira foi apanhada por leitura antes do teste. As outras três precisaram de
campo. Vale como método para o que resta: quando o desenho depende de o que um método de terceiro
faz, ler até o fim dele — em especial até onde ele fecha (ou não fecha) a sessão.

### Fase 3.5 fechada — validação final e uma hipótese minha que caiu (2026-09-08, tarde)

A bateria das 10:51–10:58 validou a 2ª revisão da RN06 nos três critérios:

- **O teste que motivou a correção:** o B cancelou com sucesso às 10:57:13 (`Controle 09802724004`,
  resposta de 1945 bytes) e, **sem fechar o B**, o A cancelou às 10:57:51 — passou, com reaplicação
  normal e **sem recusa**. Ontem à noite esse mesmo cenário travava até o B fechar.
- **Regressão 1 (o que não podia quebrar):** às 10:54:37 o `fPassarCartao` do pid 133272 foi
  **RECUSADO** porque o pid 36612 estava vivo com pendência real de 10:54:24. A trava continua de pé
  para o caso que importa.
- **Regressão 2:** o A foi negado às 10:53:00 e a marca ficou em `False`; o login do B às 10:53:31
  rodou **completo** (4,45 s, sem adiamento), prova de que uma negativa não bloqueia mais nada.

As duas desconexões saíram com `Transacao pendente de confirmacao: False`, sem o `ATENCAO` da RN09.

#### A hipótese dos 248 bytes estava errada

Eu tinha registrado que o envelope de evento "cresce 248 bytes por alternância" e que, acumulando,
um dia bateria no limite de fragmentação. **Não é acúmulo.** É um **degrau único**, ligado ao
histórico da própria sessão: os eventos daquele AUTCOM passam de ~270 para ~516 bytes depois que ele
completa **uma transação com sucesso** — o `contexto` passa a carregar os dados adicionais dela.

Os números da bateria de 10:51 separam as duas explicações de forma limpa:

| AUTCOM | Momento | Histórico até ali | Tamanho do evento |
|---|---|---|---|
| A (pid 133272) | 10:52:36 | nada | 270 bytes |
| A | 10:55:11 | só uma negativa (10:53:00) | 270–271 bytes |
| A | 10:57:59 | sucesso em 10:55:33 | 516 bytes |
| B (pid 36612) | 10:54:01 | nada | 270 bytes |
| B | 10:56:51 | sucesso em 10:54:24 | 516 bytes |

Se fosse acúmulo por alternância, o A às 10:55:11 já estaria maior — havia passado por uma
alternância completa com o B no meio. Ficou em 270. O que muda o tamanho é ter havido um **sucesso**
antes, não quantas vezes o pinpad trocou de dono.

Sai da lista de riscos do Passo 9 e fica como característica documentada. Vale como lembrete de
método: eu tinha dois pontos de medida e inferi uma tendência; com cinco pontos a tendência virou
outra coisa. Diferença de 248 bytes explicada por uma causa categórica, não por um contador.

#### Estado

Fase 3.5 concluída. Cinco sessões de teste em 08/09, nenhuma com perda de quadro (`messageId`
contíguos em todas as conexões). Próximo: Passo 8 (fila local por `pidDestino`, RF21).

---

## 2026-09-08, tarde — Passo 8: a premissa do gatilho não sobreviveu à leitura

### O que o checklist mandava fazer, e por que um dos itens estava errado

O Passo 8 chegou com quatro itens e um "ponto de entrada" levantado na sessão anterior. Três
itens eram diretos. O terceiro — *"disparo do reenvio quando o PID da conexão fica conhecido"* —
tinha uma premissa que não se sustenta, e só apareceu ao seguir a cadeia inteira em vez de olhar
só o roteador.

A cadeia é `autcom.exe ←DVC→ plugin ←TCP→ serviço`, três saltos, e a confusão vem de tratar os
dois links como um. Quando o socket entre plugin e serviço cai:

- o plugin **mantém o canal DVC vivo** e reconecta só o socket
  (`pLoopConectorELeitura`, `untTefCitelDvcPluginImpl.pas:442` — *"Socket desconectado do
  TefEstacaoService.exe - tentando reconectar"*, com `FlstPendente` esperando a reconexão);
- logo o `pOnDesconectado` do lado AUTCOM **não dispara** — ele é do transporte DVC, não do
  socket — e o `fChamaRpc` segue no `WaitFor` (`untTefCitelDvc.pas:989`);
- AUTCOM bloqueado **não emite chamada nova**. Sem chamada nova, `pAtualizaContexto` não roda.
  Sem `pAtualizaContexto`, o PID nunca fica conhecido na conexão reconectada.

Ou seja: o gatilho da primeira chamada só dispara para o AUTCOM que **já desistiu** — exatamente
quando a resposta guardada na fila não serve mais para ninguém. O comentário de cabeçalho do
roteador já registrava o limite da garantia do RF07 ("funciona enquanto o `TTefCitelDvc` do lado
AUTCOM ainda estiver com aquela chamada pendente"); o que faltava era notar que, no caminho em
que ele ainda está pendente, não existe evento que revele o PID.

O quarto item — *"descarte dos itens de PID com pendência abandonada"* — referenciava uma marca
que a revisão da RF19 em 04/09 **removeu**. O `specs.md:246` diz com todas as letras que ela não
existe mais, porque um AUTCOM encerrado volta com PID novo e a marca seria inalcançável. Ficou
sem critério de descarte.

### As três saídas, e a escolhida

| Saída | Custo |
|---|---|
| Só o roteamento (4 itens como estão) | não fecha a entrega; o furo fica registrado |
| Frame de identificação vindo do plugin | plugin deixa de ser relay cego de bytes, contra o objetivo declarado de mantê-lo leve |
| Serviço pergunta "quem é você" no accept | mexe no `untTefCitelDvc.pas`; a DLL do AUTCOM, parada desde 04/09, voltaria a mudar e a exigir revalidação |

**Rafael escolheu a primeira.** A razão é boa e vale registrar: o defeito que o Passo 8 existia
para fechar era o de **roteamento** — `pReenviaFilaLocal` despejava a fila inteira na primeira
conexão que chegasse, entregando ao AUTCOM B uma resposta do A, e resposta de método de transação
é o que menos pode errar de dono. Esse fechou. O furo de entrega é outro defeito, mais antigo,
que mora no protocolo e precisa de bateria de campo própria.

Descarte passou a ser **por idade** (`TEF_ESTACAO_FILA_VALIDADE_MINUTOS = 60`). Não é timeout
sobre o pinpad e não conflita com a regra do `IA\rules\tef-dvc.md`: quando o item é gravado a
transação já terminou e o resultado já está em mãos — o prazo mede só quanto tempo um resultado
sem destinatário ocupa disco.

### Duas escolhas de implementação que o checklist não pedia

**O PID vai no nome do arquivo**, não dentro do envelope. Três ganhos: o envelope entregue ao
AUTCOM continua byte a byte o que era (nada novo para o outro lado ignorar ou estranhar), o
filtro do reenvio não precisa abrir o JSON, e a ordem de reenvio não muda porque o sufixo `_pid`
vem **depois** do sequencial. Item de versão anterior, sem o sufixo, cai em `pidDestino = 0` e é
tratado como AUTCOM sem `contexto.pid`.

**O test-and-set do gatilho é atômico** (`TInterlocked.Exchange`), não um `if not flag`. Isso não
foi zelo preventivo: o comentário de `pEnviaUmFragmento` no
`untTefEstacaoTcpTransporte.pas:747` documenta o Bug 2 de 28/08 — *"duas threads despachando
chamadas concorrentemente"* na mesma conexão. Com `if not flag then flag := True` entre as duas,
o mesmo item da fila sairia duas vezes, e duplicidade de resposta de método de transação é
justamente o que a RN03 não admite.

O disparo ficou dentro de `try/except` com log. A fila é escrituração, não parte do pedido de
quem chamou: um tropeço no diretório dela (permissão, disco, arquivo em uso) não pode derrubar a
chamada que só passou por ali — menos ainda um `fPassarCartao`.

### Colateral: os quatro `Now` nus

Levantados de passagem, porque um deles estava na função que eu ia reescrever
(`fProximoNomeArquivo`). São quatro (fila, roteador, transporte TCP, plugin), todos em timestamp,
e o comentário do roteador (`:335`) já **dizia** usar `System.SysUtils.Now` — só que o código
usava `Now` nu, que é o que a trava do pre-commit lê. O `plans.md:88` pedia `fNow()` de verdade
na fila, o que arrastaria libFuncoes/UniDAC para dentro do serviço e criaria dependência de banco
num caminho que hoje é puro arquivo. Rafael decidiu qualificar os quatro: zero mudança de
comportamento, e passa a trava.

### Estado

Passo 8 implementado, `TefEstacaoService.dproj` e `TefCitelDvcPlugin.dproj` compilando limpo em
Debug/Win32, encoding latin-1/CRLF conferido. Falta validação em campo (caso 6 do roteiro).
A DLL do AUTCOM não foi tocada — continua a de 04/09 15:27.

### Roteiro para evidenciar o Passo 8

Levantado em 08/09 junto com a implementação. Não é caso de teste escrito (isso é do analista) —
é o procedimento e o critério de aceitação, que são entregáveis de quem implementa.

#### Onde ficam as coisas

| O quê | Onde |
|---|---|
| Fila local | `<pasta do TefEstacaoService.exe>\FilaTef\` (`untTefEstacaoServiceMain.pas:82`) |
| Log do serviço | `<pasta do TefEstacaoService.exe>\TefEstacaoService.log` |
| Log do plugin | `%TEMP%\TefCitelDvcPlugin.log` (TEMP da sessão RDP) |
| Log do lado AUTCOM | `%TEMP%\TefCitelDvcTransporte.log` (TEMP do usuário do autcom.exe) |
| PID de cada AUTCOM | linha `Instancia ITefCitel real criada para o pid=<N>` no log do serviço |

#### Duas decisões de método, e o porquê

**Plantar arquivo na fila em vez de provocar a queda.** A fila só enche quando o `pEnviaFrame`
falha no instante exato em que um método de transação retorna — janela de milissegundos que não
se produz sob comando. Plantar arquivo exercita o mesmo código de drenagem
(`pReenviaFilaLocal`), de forma determinística e com todos os ramos cobertos.

**Reiniciar o serviço, não fechar o AUTCOM.** A drenagem dispara **uma vez por conexão**
(`fMarcaFilaLocalReenviada`). Se o AUTCOM já está conectado, plantar depois não dispara nada
naquela conexão: precisa de conexão nova **sem trocar o PID**. Reiniciar o serviço faz exatamente
isso — o plugin reconecta o socket e o autcom.exe segue vivo com o mesmo PID. Fechar e reabrir o
AUTCOM não serve: ele volta com PID novo e o item plantado deixa de ter dono.

#### Fila a plantar (5 arquivos)

`<PID_A>` e `<PID_B>` são os PIDs reais lidos no log. Conteúdo de cada arquivo, uma linha, UTF-8
**COM BOM** (`id` alto de propósito: o contador de `fChamaRpc` começa em 0, então 99xxx nunca
colide com chamada real, e a resposta cai em "id não encontrado", sem efeito colateral).

> **CORRIGIDO EM 2026-09-09** — este roteiro dizia "sem BOM", e estava errado de um jeito que
> teria feito o teste falhar pelo motivo errado. O `TFile.DoReadAllText` da RTL **não detecta
> BOM**: ele pula cegamente `Length(Encoding.GetPreamble)` bytes (3, para UTF-8). Arquivo sem BOM
> perderia os 3 primeiros caracteres (`{"v` viraria `":1`), o `ParseJSONValue` devolveria nil e o
> item seria descartado como corrompido, em silêncio. A partir de 09/09 o `fCarregaEnvelope`
> **detecta** o BOM em vez de presumir, então hoje os dois formatos funcionam — mas plantar com
> BOM é o que reproduz exatamente o que o serviço grava.

```json
{"v":1,"id":99001,"tipo":"resposta","ok":true,"result":{}}
```

| Nome do arquivo | `id` | Exercita |
|---|---|---|
| `20260908_143000000_0001_pid<PID_A>.json` | 99001 | entrega ao dono |
| `20260908_143000000_0002_pid<PID_A>.json` | 99002 | entrega do 2º item do mesmo dono, em ordem |
| `20260908_143000000_0003_pid<PID_B>.json` | 99003 | **o defeito do passo**: fica na fila, não vai para o A |
| `20260101_080000000_0004_pid<PID_A>.json` | 99004 | descarte por idade (data velha) |
| `lixo.json` | 99005 | descarte por nome ilegível |

Ajustar a data dos três primeiros para o dia do teste — com mais de 60 min
(`TEF_ESTACAO_FILA_VALIDADE_MINUTOS`) eles expiram e o teste mede outra coisa.

#### Execução

1. `CFG_TEFDVC = S` nas duas empresas (RN12). Dois AUTCOM na mesma sessão TS, os dois logados no
   TEF. Anotar `PID_A` e `PID_B` no log do serviço.
2. Parar o serviço.
3. Plantar os 5 arquivos em `FilaTef\`. Guardar o `dir` de antes.
4. Subir o serviço.
5. No AUTCOM **A**, qualquer operação que gere chamada (abrir a tela de TEF já serve — o
   `fConfiguraTefCitel` do login é uma chamada com contexto).

#### Critério de aceitação

**(a) Uma linha no `TefEstacaoService.log`** — os cinco números são o critério:

```
pReenviaFilaLocal: con=<N> (pid=<PID_A>) - fila tinha 5 item(ns): 2 entregue(s),
1 de outro autcom mantido(s), 2 descartado(s) por expiracao (> 60 min) ou nome ilegivel,
0 com conteudo corrompido, 0 que falharam no envio.
```

Esperado: **2 / 1 / 2 / 0 / 0**.

**(b) `dir FilaTef\` depois:** sobrou **só** `20260908_143000000_0003_pid<PID_B>.json`.

**(c) Em seguida, uma operação de TEF no AUTCOM B:** nova linha com `(pid=<PID_B>)` e
`1 entregue(s)`, e a fila fica vazia. Isto é o que separa "ficou guardado para o dono" de
"foi descartado" — sem este passo, (b) não distingue os dois.

**(d) Corroboração no lado AUTCOM** (`%TEMP%\TefCitelDvcTransporte.log`):
`pTrataResposta: id=99001 NAO ENCONTRADO em FdictChamadas (Count=<n>) - resposta ignorada`.
**Ressalva:** se os dois AUTCOM rodam com o mesmo usuário Windows, os dois escrevem no MESMO
arquivo, e a linha tem `[seq= tid=]` mas **não tem PID** — serve para provar que a resposta
chegou, não em qual processo. A prova de dono são (a), (b) e (c).

#### Regressão A/B — a evidência mais forte

Repetir os passos 3 a 5 com o exe **anterior** ao Passo 8, que está no backup:

```
..\..\..\_backups\456190_20260908_1117\arquivos\libTefCitel\Estacao\Win32\Debug\TefEstacaoService.exe
```

Ele entrega os **5** itens ao AUTCOM A — inclusive o do B — e deixa a fila vazia. É o defeito
acontecendo, lado a lado com a correção, na mesma fila plantada.

#### O que este roteiro NÃO evidencia

O furo de **entrega** da RF07, que ficou aberto. Aqui a drenagem só dispara porque o AUTCOM faz
uma chamada nova depois do reconnect. No cenário real — socket cai com o `fPassarCartao` em voo —
o AUTCOM fica bloqueado no `fChamaRpc` e não faz chamada nenhuma; o item espera até expirar.
Evidenciar isso depende do frame de identificação, que não foi feito.
---

## 2026-09-09 — O debate da oscilação: como uma dúvida virou o pilar do requisito

### De onde veio

O Passo 8 estava compilado e o Rafael perguntou uma coisa aparentemente lateral: *"se eu tiver uma
transação pendente e fechar e abrir a sessão do TS, isso afeta a transação em andamento?"*

A resposta curta era tranquilizadora — a transação no pinpad não é afetada, porque o serviço da
estação é independente da sessão TS e conclui sozinho (RF07). Mas ao seguir a cadeia inteira em vez
de olhar só o roteador, apareceu o que estava errado, e não era pouco.

### O que a leitura mostrou

**O AUTCOM registra CANCELADA numa transação aprovada.** O `fPassaCartao` grava
`TRANSACAO_INICIADA` no TEFTRA **antes** de passar o cartão e, no `finally`, grava
`TRANSACAO_PENDENTE` se veio retorno ou `TRANSACAO_CANCELADA` se não veio. Queda de canal faz o
`fPassarCartao` estourar com `Result` nil — então o TEFTRA registra CANCELADA numa transação que a
adquirente aprovou. Isso não estava em nenhuma spec.

**A estação joga fora estado que não devia.** O `pOnDesconectado` orfana a sessão na queda da
conexão e o `fGaranteSessao` **nunca** consulta `FlstOrfas`. O AUTCOM que volta com o mesmo PID
recebe sessão nova e perde a pendência e a digital de configuração. O log do `pOrfanaSessao`
justifica a perda com *"o mesmo já acontece quando o autcom trava"* — justificativa que pressupõe um
AUTCOM que foi embora. Na oscilação ele não foi. **O código documenta a própria premissa errada.**

**E o re-login do próprio AUTCOM mata a própria pendência.** O `fOutroAutcomDetemPinpad` isenta o
próprio PID de propósito (`:1833`), então o `fConfiguraTefCitel` do re-login cai no
`FechaSessaoTEF(1, 1)` embutido e atropela a pendência que ele mesmo deixou.

### O ponto do Rafael, que reordenou tudo

Ele leu o diagnóstico e foi direto ao gatilho: *"somente o TS caiu e voltou, o serviço está ativo e o
autcom também, com o mesmo PID — nessa situação não deveria ficar órfão. Deveria ficar órfão se o PID
deixasse de existir."*

Está certo, e o orfanamento estava amarrado ao evento errado. Meu contra-argumento inicial — que "o
PID deixar de existir" não é observável da estação, porque o `autcom.exe` roda no servidor e o
serviço na estação — era verdadeiro mas incompleto: **quem pode observar é o AUTCOM que chega**, que
roda no mesmo servidor que o detentor. A pergunta vai para o Windows, não para o banco.

Depois ele trouxe a variável que mudou a prioridade da coisa: *"isso vai acontecer também na
reconexão do TS, e acontece demais em clientes com oscilação de internet."* Confirmado no código —
`OnClose` → `Destroy` → `pFechaConexaoJaTravada`, e na volta um `OnNewChannelConnection` novo. A
reconexão percorre o mesmo caminho de fechar e reabrir, com uma diferença: ali o `autcom.exe`
**sempre** sobrevive, porque é disconnect e nunca logoff. O caso "mesmo PID volta" deixa de ser
exceção e passa a ser a regra.

### O deadlock que descartou metade das saídas

Para o AUTCOM recuperar a venda dentro da chamada original, o `fChamaRpc` tinha que continuar
esperando. Mas o canal só volta quando o `pIniciaTefCitel` cria um `TTefCitelDvc` novo — e isso só
acontece depois que o `fChamaRpc` retorna. Um espera o outro.

Daí a conclusão que definiu a abordagem: **a espera não pode ficar no `fChamaRpc` enquanto o canal
for aberto uma única vez no construtor do transporte.** O canal precisa se reabrir por conta própria,
o que é exatamente a premissa que o comentário do `pOnDesconectado` dizia não existir (*"do lado
autcom NAO existe reconexao"*). Com reconexão, a espera passa a ser o comportamento **correto** pela
regra do `tef-dvc.md` — a transação real está viva na estação e vai responder.

E isso explicou por que o Passo 8 tinha ficado sem uso prático: ele já estava pronto para esse mundo.
Faltava a reconexão e a identidade.

### O ping-pong: a intuição certa, o instrumento errado

O Rafael propôs um ping-pong para saber se o AUTCOM está vivo, atrelado à LCKATC, argumentando que
um processo travado não conseguiria responder.

Sobre o canal DVC, não serve: durante a oscilação o canal está caído, então o ping falha igual para
AUTCOM morto e para AUTCOM vivo esperando — e `WTSVirtualChannelWrite` aborta o
`WTSVirtualChannelRead` pendente, causa raiz do quadro perdido de 04/09, então um ping periódico
tornaria essa exposição permanente.

Mas a metade dele estava exata: **um processo travado não responde.** O que faltava era achar o canal
certo e o momento certo. E o canal certo já existia:

`pTrataHook` despacha via `TThread.Queue(nil, ...)` — o corpo do hook roda na **thread principal**.
Um AUTCOM travado nunca drena essa fila. E um AUTCOM saudável responde **mesmo dentro de um
`fPassarCartao`**, porque o `fChamaRpc` bombeia `CheckSynchronize`/`Application.ProcessMessages` no
laço de espera. Discriminador exato entre travado e saudável, já existente, e caro só quando alguém
disputa o pinpad — sonda sob demanda, não ping periódico.

### A LCKATC: por onde passei e por que saiu

Fui ao MySQL porque foi de onde a ideia veio, e achei algo bom: `LCK_CON_ID` é o `CONNECTION_ID()`
(`fGetConnectionID`), então a morte do processo derruba a conexão e o id sai do process list — o
banco mantém o heartbeat de graça. Cheguei a propor mandar a chave LCKATC no `contexto`.

O Rafael cortou certo: *"não ficou claro como enviar minha chave LCKATC resolve dois autcom de
empresas diferentes."* Não resolve, e eu tinha misturado dois problemas. **Serialização entre
empresas diferentes nunca foi da LCKATC** — é da estação, que é o único ponto que vê todos os AUTCOM
independentemente de empresa (`specs.md:248`). A LCKATC só servia para vivacidade, e ali
`OpenProcess` no mesmo servidor é mais direto.

E a LCKATC teria falhado justamente onde dói: a chave depende de `TIPTER`
(`fRetornaChaveLockTefCitel`, `untTefCitelUtil.pas:447`). Em `TIPTER = 3` ela inclui `VS_strCodEmp`,
então dois AUTCOM de empresas diferentes usam chaves **diferentes** e a trava não serializa nada — o
cenário exato da premissa 9.1, e o motivo de a RF19 existir.

### O zumbi, e a regressão operacional que a mudança introduz

Propus que o AUTCOM recusado oferecesse derrubar o processo travado (`TerminateProcess`). O Rafael
recusou de imediato: *"não posso depender de outro processo derrubar um autcom zumbi"*, e descreveu o
fluxo que já funciona — AUTCOM trava, operador abre outro, remove a trava na LCKATC, continua
trabalhando. O zumbi fica lá, e ninguém o mata.

Isso desenterrou algo que eu não tinha visto: **hoje "fechar a sessão TS" libera as coisas justamente
porque a desconexão orfana.** No desenho novo isso deixa de valer — disconnect não mata o
`autcom.exe`. O remédio que o operador usa hoje para de funcionar, e a entrega tem que trazer o
substituto. Não é detalhe; é regressão operacional introduzida pela mudança, e foi a pergunta dele
que a expôs.

A saída ficou em três portas independentes, nenhuma na mão de quem quer o pinpad: a estação verifica
(sonda), o operador confirma, e **nada é morto**. A garantia que ele pediu — A não derruba B e
vice-versa — vem de o veto ser da estação, que o requisitante não tem como falsificar.

### Onde eu construí demais, e a correção

A partir de *"outro autcom não pode resolver transação de outro autcom"* eu montei uma regra grande:
pendência promovida a fato da estação, transação nova de outra identidade interrompida, operador
avisado, e uma porta seletiva liberando o caminho de resolução para o caixa não trancar.

O Rafael cortou: *"se o autcom travou e um novo foi aberto, a transação do travado precisaria ficar
pendente (destruir a instância no serviço), e o que precisa ficar claro é que um autcom travado não
segura o pinpad para ele."*

Ou seja: **a RN09 fica como está.** A pendência do travado é perda aceita, como sempre foi, e o
AUTCOM novo trabalha. O que a Fase 5 tira da RN09 é o caso 1 — a oscilação — que nunca deveria ter
caído nela. Saíram do desenho o fato de estação, a interrupção do AUTCOM novo e a porta seletiva.

Vale como lembrete de método: eu peguei uma frase de uma mensagem e a levei ao limite lógico sem
verificar se o limite era desejado. A frase era sobre não resolver **em silêncio**, não sobre bloquear
o caixa.

### A trava no "destruir a instância"

A instrução de destruir colidia com duas coisas já no código: a RN08 (*"orfanar, nunca destruir
enquanto houver instância ativa"*, porque os destrutores anulam ponteiros globais compartilhados) e o
`pColetaOrfasSeOcioso`, que exige nenhuma thread de despacho **e** `FdictSessoes.Count = 0`. Essa
segunda condição nunca vale no caso 2 — quando o AUTCOM novo faz login, a sessão dele já está no
dicionário. Com o código de hoje, a instância do travado simplesmente **não é destruída**.

Resolvido mantendo a condição que protege de verdade (nenhuma thread de despacho — sem operação
ativa, não há global compartilhado em uso) e descartando a contagem de sessões, com a destruição
acontecendo **no caminho do login do AUTCOM novo, antes de tocar a DLL**. Ordenado, em vez de
depender de uma janela de ociosidade que nunca chega.

### A premissa que ficou como premissa

Levantei que destruir a instância antes do login **talvez** seja o que impede o login de confirmar a
pendência alheia, e propus tratar como spike, porque a evidência de campo de 08/09 mostra o login do
B confirmando a transação do A **com a sessão do A ainda aberta** (`INI_SESSAO` já setado).

O Rafael respondeu: *"com certeza impede."* Registrada como **premissa P1**, atribuída e datada, em
`specs.md` 10.6 — não como fato de código, pelo mesmo critério das outras premissas de terceiro deste
requisito. Quatro já caíram; a proveniência de cada uma é o que permite achar a quinta rápido se ela
cair.

Ficou **um** spike: a reabertura do canal com `WTSVirtualChannelOpen` depois de reconexão de sessão
TSPlus. Metade já está provada — o lado cliente recebe `OnNewChannelConnection` novo. Falta o lado
servidor, e se falhar a abordagem cai inteira e volta para o plano B.

### Estado

Design fechado e aprovado seção por seção. `specs.md` seção 10, `plans.md` seção 9, `tasks.md`
Fase 5. Nada de código antes do spike. O Passo 8 e a Fase 4 (revisão/commit do que já existe)
continuam válidos e independentes — o Passo 8 não é retrabalho, só muda o ponto de chamada do
gatilho.

---

## 2026-09-09, manhã — O Access violation que não era onde parecia

### O relato e a primeira suspeita

Primeiro teste do Passo 2 em campo: *"deu access violation no autcom, quando fechei e abri o TS com
o autcom aberto, sem nenhuma transação tef iniciada"*.

Cenário aponta para o código novo de reconexão, que é o único caminho que aquela sequência
exercita. A tentação era ler o meu próprio diff procurando o ponteiro solto. Fui buscar evidência
primeiro, e ela desmontou a suspeita em dois passos.

### O log do transporte: a reconexão funcionou

```
08:57:34.220  WTSVirtualChannelRead falhou com erro 233 ... desconexao real do canal.
08:57:34.221  fReconectaCanal: tentativa 1 ... erro 2250 (Esta conexao de rede nao existe)
08:58:02.314  fReconectaCanal: tentativa 15 ... erro 2250
08:58:04.333  fReconectaCanal: canal "TefCitelCh" REABERTO na tentativa 16, 30109 ms depois
```

E depois dela: leituras normais, um `fPassarCartao` completo com hook respondido, resposta em 57 ms.
O AV é às 08:59:01 — **12 s depois dessa resposta** — e a thread de leitura seguiu viva, logando
08:59:04, :19 e :34. Não estourou no caminho novo.

### O bugreport: o AV não era no autcom

```
exception class   : Exception
exception message : Estacao retornou erro em "fPassarCartao": Access violation at address
                    00000000 in module 'TefEstacaoService.exe'. Read of address 00000000.
```

O AV estava **dentro da mensagem**. A pilha do autcom é o caminho normal
`btnCreditoClick → pPassaCartao → fPassaCartao`, e o `Exception` é o diálogo de erro do
`TfrmPai.pOnBitBtnErro`. O autcom se comportou certo: reportou o que a estação devolveu. Endereço
00000000 com leitura de 00000000 é chamada através de ponteiro de função nulo.

Detalhe de leitura que confirmou o resto sem sair do log: os ids do RPC foram de `id=10` (08:56)
para `id=11` (08:58:49) — contador **não** reiniciou, logo o `TTefCitelDvc` era o mesmo objeto, o
`pIniciaTefCitel` não rodou e nenhum `fConfiguraTefCitel` foi enviado entre o reconnect e o cartão.

### A causa raiz, e a contabilidade desonesta

O log da estação fechou a cadeia:

```
08:57:34.067  pColetaOrfasSeOcioso: ... 1 instancia(s) orfa(s) liberada(s).
              Os ponteiros globais das DLLs de terceiro ficam anulados ...
08:58:04.259  TCP[con=2]: cliente (plugin) conectado.
08:58:49.489  Frame "chamada" recebido: metodo="fPassarCartao"
08:58:49.499  pGarantePinpadConfigurado: ... sem nunca ter enviado fConfiguraTefCitel -
              seguindo com a configuracao atual da DLL (impressao digital
              "T||172.30.96.233|69690001|003|ComPort=COM6;..." do pid=120328)
08:58:49.526  Metodo "fPassarCartao" (id=11) lancou excecao: Access violation ... 00000000
```

Com um AUTCOM só, a queda da conexão satisfaz as **duas** condições do coletor (`FdictSessoes`
vazio e nenhuma thread de despacho), então a órfã é coletada e o `UnLoadDLLFunctions` anula os
ponteiros. Mas `FstrConfigAplicada` **não** é zerado: a estação passa a afirmar que a DLL está
configurada logo depois de ter desfeito isso. E o `TTefCitelNCR.Create` não carrega ponteiro nenhum
— só `FblnDllCarregada := False`; quem carrega é o `fConfiguraTefCitel` (`untTefCitelNCR.pas:649`),
que não veio.

**O agravante que só o log mostrou:** a impressão digital que o guarda imprimiu era a da sessão
recém-coletada — **mesmo pid, mesmo terminal 003**, porque o `autcom.exe` sobreviveu à queda da
sessão TS. Ou seja, os **dois** caminhos do `pGarantePinpadConfigurado` estavam quebrados: o "nunca
mandou config" (o do campo) e o skip de impressão digital da RF20, que teria dado `Exit` igual se a
sessão tivesse mandado config. Isso mudou a correção de precaução para essencial.

### O que a minha mudança fez, exatamente

Nada além de tornar o defeito alcançável. Antes, o canal ficava morto, o `fPassarCartao` nunca
chegava à estação, e o próximo passo do operador passava pelo `pIniciaTefCitel` — que recria o
`objTefCitel` e refaz o `fConfiguraTefCitel`, recarregando os ponteiros. Esse acidente de proteção
era o que escondia o furo. A reconexão o removeu.

Vale registrar como padrão: **este é o segundo defeito latente que a Fase 5 desenterra ao remover um
acidente de proteção** (o primeiro foi o `TRANSACAO_CANCELADA` gravado em transação aprovada). Não é
sinal de que o desenho está errado; é sinal de que o comportamento antigo dependia de o canal morrer.

### A correção

Duas mudanças no roteador, as duas de raiz:

1. `pColetaOrfasSeOcioso` zera `FstrConfigAplicada`/`FdwPidConfigAplicada` ao coletar — sem
   instância não há configuração aplicada. Conserta os dois caminhos de uma vez, e faz uma sessão
   **com** login recuperar sozinha: a digital deixa de bater, o `fConfiguraTefCitel` é reaplicado e
   os ponteiros voltam.
2. `pGarantePinpadConfigurado` recusa com mensagem acionável quando a sessão não mandou config e não
   há config aplicada. Nenhuma condição de fluxo justifica chamar a DLL nativa sem
   `fLoadDLLFunctions` ter rodado.

A #2 é rede de segurança e continua valendo depois que a Fase 5 entregar o `reata` (RF26/RF29), que
é quem vai avisar o AUTCOM para refazer o TEF sozinho. Até lá, quem refaz é o operador — e ao menos
sabe disso, em vez de ver um Access violation.

### E o spike foi respondido de graça

Plugin: `Plugin terminado` 08:57:34.184 → `Listener "TefCitelCh" criado` 08:57:49.898 →
`Sessao RDP conectada` 08:58:01.990 → `Conexao aceita no canal` 08:58:04.259.
Servidor: `REABERTO na tentativa 16` 08:58:04.333.

**O canal reabre depois de uma reconexão de sessão TSPlus.** A pergunta do Passo 0 está respondida
em campo, com marca de tempo dos dois lados, usando o código de produção em vez de um app
descartável. A abordagem A está de pé e o plano B não é necessário.

---

## 2026-09-09, meio da manhã — A correção certa era a que o Rafael apontou

### O teste seguinte: o AV virou mensagem, e o problema continuou

A correção de contabilidade fez o que prometia. Log da estação às 09:58:46 e 09:59:19:

```
Metodo "fPassarCartao" (id=8) lancou excecao: A estacao nao tem o TEF configurado para o
autcom pid=99196: ... Saia e entre novamente na rotina de TEF do AUTCOM ...
Metodo "pSair" (id=9) lancou excecao: ... mesma mensagem
```

Nenhum Access violation. A mensagem apareceu na tela do operador, inclusive no `pSair` do
"Encerra". Mas o Rafael leu além do crash: *"o problema persistiu na reconexão, acredito que o
problema está quando deixa órfão, está desalocando a instância sem necessidade na estação"*.

Ele está certo, e eu tinha tratado o sintoma. O crash era o sintoma; **desalocar a instância na
queda da conexão é a causa**. A minha correção anterior só trocou "derruba o serviço" por "recusa
com mensagem" — o TEF continuava inutilizável até o operador sair e entrar na rotina.

### A premissa que o Passo 2 matou, e que estava escrita no código

O comentário que justificava o orfanamento dizia, com todas as letras:

> *"do lado autcom NAO existe reconexao - TTefCitelDvc.pOnDesconectado so falha as chamadas
> pendentes com ErroCanal, e o canal WTS e aberto uma unica vez no construtor do transporte. Um
> autcom que volta chega como conexao NOVA e refaz o fConfiguraTefCitel do login."*

Cada afirmação ali era verdadeira até o Passo 2. Depois dele, o autcom volta com o **mesmo
processo**, o mesmo `objTefCitel`, e **não refaz login nenhum** — ele nem soube que a sessão TS
caiu. O código documentava a própria premissa, e foi por isso que ficou fácil ver o que havia
mudado. Vale como argumento a favor de comentar o *porquê*, não o *quê*.

### A correção, e por que ela é pequena

`fGaranteSessao` já procurava a sessão em `FdictSessoes` pelo PID e devolvia a existente. Ou seja,
**a reatação era automática** — bastava parar de tirar a sessão do dicionário. O conserto do fluxo
é uma mudança de uma linha de efeito: `pOnDesconectado` **desanexa** em vez de orfanar. A sessão
fica, com a `ITefCitel` viva, a digital de configuração e a marca de pendência.

Mas não fui só nisso, e a razão importa: com a sessão sobrevivendo, **PID passa a ser chave de
longa duração**, e o Windows recicla número de processo. Um `autcom.exe` novo que caísse no mesmo
PID herdaria a sessão do anterior — com a loja e o terminal de **outra empresa**. É exatamente a
classe do bug de campo de 04/09 (transação do terminal 003 registrada no 004). Então a RF23
(identidade por creation time do processo) entrou no mesmo pacote: não é escopo a mais, é o mínimo
seguro. E ela dá ao orfanamento um gatilho novo e correto — identidade diferente no mesmo PID
significa que o AUTCOM morreu de verdade.

Detalhe de implementação: a identidade viaja como **string decimal**, não número, para não
precisar de um leitor de Int64 no JSON. A estação só compara.

### O que fica em aberto, com nome

1. **AUTCOM travado agora segura a sessão** — a queda de conexão deixou de liberá-la. É a tensão
   que eu levantei na Seção 1 do desenho e que a sonda de vivacidade (RF27, Passo 6) resolve. O
   alcance real é mais estreito do que parece: só atrapalha outro AUTCOM se o travado deixou
   **pendência de confirmação**, porque é isso que `fSessaoVivaComPendencia` olha. Sem pendência,
   sessão desanexada não barra ninguém.
2. **Coleta** — sessão de AUTCOM morto fica no dicionário até um PID novo reusar o número, e as
   órfãs por reuso não são liberadas enquanto houver sessão viva. É a RF28, Passo 7.

A recusa com mensagem da correção anterior **fica** como rede de segurança. Ela deixa de ser o
caminho comum, mas nenhuma condição de fluxo justifica chamar a DLL nativa sem `fLoadDLLFunctions`
ter rodado, e agora é ela que garante isso.

---

## 2026-09-09, 10:31–10:33 — A pendência que sobreviveu, e o valor de nomear o que o teste não cobre

O Rafael foi testar a reconexão em voo e trouxe o resultado com a ressalva certa: *"vamos dizer que
em semi-voo funcionou"*. A leitura dele estava correta e vale registrar por quê, porque a diferença
entre "em voo" e "semi-voo" decide qual passo foi validado.

**Não foi em voo.** O `fPassarCartao` retornou às 10:32:27.660, a resposta de 2202 bytes foi
entregue em dois fragmentos (o log do plugin confirma o repasse de 1417+819 bytes) e o AUTCOM ainda
mandou dois `pRetornaLog`. A queda veio 9,5 s depois, com o canal vazio. Nada pendente, nada
enfileirado — a fila do Passo 8 **segue sem exercício em campo**, e nenhuma das cinco previsões que
eu tinha listado para o teste em voo foi verificada.

**Mas a bateria validou a peça que faltava da RF24, e é mais forte que a das 10:14.** Na queda:
`marca de pendencia (True)` — a pendência sobreviveu. Na volta, o `fFinalizarTransacao` chegou,
**sem** `Instanciando ITefCitel real`, e retornou com sucesso. O operador desfez a transação
normalmente, no próprio AUTCOM.

Antes da RF24 isso não teria funcionado, e o caminho é conhecido: a sessão seria orfanada e
coletada, a marca de pendência se perderia, e o `fFinalizarTransacao` cairia numa sessão sem
configuração — o Access violation na primeira versão do dia, a recusa depois da correção. A
transação ficaria pendente e insolúvel pelo AUTCOM, para ser confirmada em silêncio por um login
qualquer: exatamente a perda que a RN09 aceita. A RF24 transformou uma perda aceita num
desfazimento limpo. Isso não estava escrito como critério de aceitação da RF24 e apareceu de
brinde — vale como lembrete de que o valor de uma mudança às vezes se revela num caminho que não
foi o motivador dela.

**E o resíduo do RF28 apareceu em campo, sem estrago:** `2 sessao(oes) no dicionario`, sendo a
segunda a do pid=20564 da bateria anterior, cujo AUTCOM foi fechado. Inofensiva porque a marca dela
é `False`. Fica como primeira medição concreta do acúmulo que o Passo 7 tem de resolver.

**Nota de método.** Eu havia escrito cinco previsões antes do teste, com a frase *"se algum desses
cinco não bater, é achado novo — e aí a previsão estava errada, não o teste"*. Nenhuma foi
exercitada, e isso também é informação: não porque a previsão falhou, mas porque o cenário não foi
o previsto. Registrar a previsão antes serviu para perceber isso rápido, em vez de ler o sucesso do
desfazimento como se o Passo 4 estivesse pronto.

---

## 2026-09-09, 10:41–10:43 — O teste em voo, a fila estreando, e o BOM que quase nos custou uma caçada

### O cenário, finalmente em voo

Terceira bateria, pid=126164. O `fPassarCartao` (id=3) foi despachado às 10:42:31.505 e a queda
veio às **10:42:38.309** — 2,7 s depois do `Aproxime, Insira ou Passe o Cartao`, com o pinpad
esperando o cartão. Este é o cenário do Passo 4, pela primeira vez.

O que aconteceu, na ordem:

```
10:42:38.317  DESANEXADA ... marca de pendencia (False)          <- RF24
10:42:57.339  TCP[con=6]: cliente (plugin) conectado
10:43:18.213  Frame "chamada" ... "pSair" (id=4) -> sucesso
10:43:18.972  pEnviaEvento: "Transacao cancelada"
10:43:20.995  fPassarCartao (id=3) retornou SEM retorno
10:43:20.995  pEnviaOuEnfileira: envio falhou - envelope id=3 tipo="resposta"
              persistido na fila local para o pid=126164 (RF07/RF21)
```

**A fila local estreou em campo.** O nome saiu exatamente como desenhado:
`20260909_104320995_0001_pid126164.json`, com o timestamp ordenável, o sequencial e o `_pid` no
fim. Até aqui ela só existia no roteiro com arquivo plantado.

### O que a bateria NÃO cobriu, e por um motivo instrutivo

**O reenvio não foi exercitado.** O `pSair` das 10:43:18 é uma chamada, então disparou o
`pReenviaFilaLocal` pelo `pAtualizaContexto` — mas a fila estava **vazia** naquele instante: o item
só foi gravado 2,8 s depois. E o `fMarcaFilaLocalReenviada` é one-shot por conexão, então a con=6
nunca drenaria de novo. Ela caiu às 10:43:48 com o arquivo ainda lá.

Isso expõe uma consequência real do gatilho atual: **item enfileirado DEPOIS de a drenagem já ter
rodado naquela conexão espera pela conexão seguinte.** Aqui não fez mal (a resposta já era inútil,
o id tinha saído do `FdictChamadas`), mas é mais um motivo para o `reata` do Passo 3, que troca o
gatilho por um que roda no accept.

### O achado que vale mais que a bateria: o BOM

O arquivo que o Rafael anexou começa com `ï»¿` — BOM de UTF-8. Fui verificar se o reenvio saberia
lê-lo e o fonte da RTL (`System.IOUtils.pas`, `TFile.DoReadAllText`) mostrou algo pior do que eu
esperava:

```pascal
Buff := DoReadAllBytes(Path);
BOMLength := Length(Encoding.GetPreamble);   // 3, para UTF8
Result := Encoding.GetString(Buff, BOMLength, Length(Buff) - BOMLength);
```

**Ele não detecta BOM — pula 3 bytes sempre.** Com o arquivo que o `pEnfileira` grava dá certo por
acidente, porque o `TFile.WriteAllText` escreve o preâmbulo. Mas arquivo **sem** BOM perde os 3
primeiros caracteres, o `ParseJSONValue` devolve nil, e o item é descartado como corrompido **em
silêncio**.

E o roteiro que eu escrevi para evidenciar o Passo 8 mandava plantar os arquivos **"UTF-8 sem
BOM"**. Se alguém tivesse seguido, os cinco arquivos plantados seriam engolidos, o log mostraria
"descartado por nome ilegível ou conteúdo corrompido", e nós iríamos caçar um bug de filtro por PID
que não existe. O roteiro estava errado de um jeito que produz um falso negativo convincente.

Duas correções: o roteiro passou a dizer **com BOM**, e o `fCarregaEnvelope` passou a **detectar** o
BOM em vez de presumir. A segunda não é só zelo — para uma fila que guarda resposta de transação de
cartão, perder calado é o pior desfecho, e o arquivo pode chegar sem BOM por caminhos banais
(recuperado de backup, salvo por um editor, plantado num teste).

Lição de método: eu tinha escrito o roteiro sem verificar essa afirmação no fonte da RTL. "UTF-8 sem
BOM" soa como a escolha limpa e cuidadosa; era o oposto. Afirmação sobre comportamento de
biblioteca precisa do mesmo tratamento que a gente já dá a comportamento de terceiro neste
requisito — é a quinta premissa a cair, só que desta vez de biblioteca própria, não do Scope.

### Um achado novo: o `pSair` abortou a transação em voo do próprio AUTCOM

Às 10:43:18.213 o `pSair` foi despachado **com o `fPassarCartao` do mesmo pid ainda rodando** na
estação. Logo depois: `Transacao cancelada`, `Erro Desconhecido (-1)` e o `fPassarCartao` voltando
sem retorno. Ou seja: **o `pSair` derrubou a transação em voo.**

Nesta bateria foi conveniente — era o que o Rafael queria, sair da tela, e nenhum cartão tinha sido
passado, então não houve estrago. Mas o caminho está aberto: o `pSair` está em `fMetodoUsaPinpad` e
**não** é método de transação, então o single-flight não o barra; e o `fOutroAutcomDetemPinpad`
isenta o próprio PID. A RF17 item 5b cobriu o `pSair` de OUTRO autcom (respondido como no-op); o
caso do MESMO autcom não tem guarda.

Se a transação já estivesse autorizada, um `pSair` concorrente atropelaria uma transação real.
Decisão pendente com o Rafael: barrar o `pSair` enquanto há transação em voo do próprio PID, ou
tratá-lo como cancelamento explícito e deliberado do operador.

### As cinco previsões, conferidas

Eu havia escrito cinco previsões antes deste teste. Placar honesto:

| Previsão | Resultado |
|---|---|
| 1. Erro de canal no AUTCOM | **confirmada** (o Rafael viu erro na tela) |
| 2. Transação termina na estação | **parcial** — terminou, mas como cancelamento provocado pelo `pSair`, não como autorização |
| 3. TEFTRA grava CANCELADA em transação aprovada | **não exercitada** — a transação foi de fato cancelada, então CANCELADA está correto aqui |
| 4. Pendência sobrevive | **não aplicável** — nenhuma pendência foi criada (`marca False`) |
| 5. Fila recebe e depois ignora | **metade** — enfileirou (confirmado); a entrega e o descarte não rodaram |

O item 3 continua sem evidência, e é o que mais importa: precisa de uma transação **autorizada**
interrompida, não cancelada.

### Estado

`3 sessao(oes) no dicionario` — o acúmulo do resíduo RF28 subiu de 2 para 3, como previsto.
Serviço recompilado com a correção do BOM às 10:48:57.

---

## 2026-09-09 — A linha da TEFTRA: quando o valor certo é a melhor evidência do defeito

O Rafael mandou a linha gravada pela bateria em voo:

```
TFT_STATUS = TRN CANCEL   TFT_HRATRA = 10:42:47   TFT_NUMNSU = 0   TFT_CONTRO = (vazio)
TFT_VALTRA = 1.00         TFT_DESTRA = CREDITO    TFT_NUMTER = 003
```

`TRN CANCEL` é o `TRANSACAO_CANCELADA` de `untInterfaceTefCitel.pas:23`. E o valor **está correto**:
nenhum cartão foi passado, a estação concluiu "SEM retorno", não há NSU nem Controle. Cancelada é o
desfecho verdadeiro.

A tentação era arquivar isso como "não exercitou o defeito" e seguir. Mas o carimbo de hora conta
outra história:

| | |
|---|---|
| AUTCOM gravou o status final | **10:42:47** |
| Estação concluiu o `fPassarCartao` | **10:43:20.995** |

**34 segundos de diferença.** O AUTCOM decidiu o desfecho antes de ele existir. Ele escreveu a
partir de "meu canal caiu", não de "a transação foi cancelada" — e acertou por coincidência, porque
o operador ainda não tinha passado o cartão. Com o cartão autorizado antes da queda, a mesma linha
de código (`untTefCitelUtil.pas:2189`) grava `TRN CANCEL` numa transação aprovada.

Isso é evidência **melhor** do que um valor errado seria. Um valor errado provaria que aconteceu; o
carimbo de hora prova *por que* acontece, e prova por aritmética, sem depender de interpretação: o
AUTCOM não tinha como saber. Vale como lembrete de que "o resultado está certo" não é o mesmo que
"o caminho está certo", e que às vezes a evidência mais forte de um defeito é uma execução em que
ele não causou dano.

### Um efeito colateral bom: confirma a escolha da abordagem A

Com o Passo 4, o `fChamaRpc` continua esperando, o `finally` do `fPassaCartao` não roda na queda, e
a linha fica em `TRN INICIADA` até o desfecho real chegar — virando `PENDENTE` (com retorno) ou
`TRN CANCEL` (sem). **Nenhum status novo é necessário.** O status "indeterminada" que eu tinha
previsto para a abordagem B (a estação empurra, o AUTCOM completa por fora) é dispensável na A. Um
argumento a favor da A que só apareceu agora, olhando uma linha de banco.

### E um furo na minha própria implementação da RF24

A resposta foi para a fila **mesmo com a con=6 viva e do mesmo PID**. O motivo é meu: o
`pEnviaResposta` usa o `AConexao` capturado no despacho, e o `fConexaoDeSaida` resolve pelo mapa
thread→conexão registrado também no despacho. Os dois apontavam para a con=5, morta.

Eu escrevi no `plans.md` 9.3 que *"a sessão passa a saber sua conexão atual (ou nil)"* e, no patch,
só parei de orfanar e logei — o campo não existe. Passou nos cenários validados porque eles só
precisavam de reatação por PID, e a diferença não aparece até alguém tentar **entregar** algo pela
conexão nova. É o primeiro item do Passo 3, e é bom que tenha aparecido num teste e não numa
suposição: eu tinha marcado o Passo 5 como feito lendo a minha própria intenção no plano, não o
código.

---

## 2026-09-09, 11:15 — Passo 3: o `reata`, e um deadlock que o compilador não pegaria

### O que entrou

Três peças, e a primeira era dívida minha.

**A conexão atual da sessão.** O furo que a bateria das 10:41 mediu: a resposta foi para a fila com
a con=6 viva e do mesmo PID, porque tanto o `AConexao` do despacho quanto o mapa thread→conexão do
`fConexaoDeSaida` foram capturados no início da chamada, e apontavam para a con=5. Agora o
`pEnviaOuEnfileira` tem segunda tentativa pela `FConexaoAtual` da sessão, resolvida na hora do
envio. É a diferença entre "a conexão que existia quando eu comecei" e "a conexão que existe agora
que eu terminei" — e, com a sessão sobrevivendo à queda (RF24), as duas deixaram de ser a mesma
coisa.

**O frame `reata`.** Enviado a cada reconexão, com pid, `inicioProcesso`, a instância do serviço que
o AUTCOM conhecia e os ids que ele ainda tem pendentes. A estação reata a sessão, responde
`emVoo`/`naFila`/`desconhecido` por id e drena a fila. Fecha o furo do Passo 8: a drenagem volta ao
accept, sem depender de uma chamada nova que um AUTCOM bloqueado nunca faria.

Duas decisões de escopo, para o passo ser verificável sozinho: o reata só é enviado na
**reconexão** (na primeira conexão sempre vem uma chamada, e o `pAtualizaContexto` continua servindo
— e serve de fallback para AUTCOM anterior a esta versão); e o AUTCOM **registra** a resposta sem
agir sobre ela, porque agir é o Passo 4. Logar antes de ligar o comportamento permite conferir o
protocolo em campo sem mudar nada de sensível.

### O deadlock

Depois de os dois projetos compilarem limpo, fui reler o que escrevi perguntando em qual thread cada
coisa roda. O `pTrataReata` escreve no socket. O `pOnFrameRecebido` da estação roda na thread de
leitura da conexão. O `pEnviaFrame` espera ACK. E o ACK só pode ser recebido pela thread de leitura
— a que estaria presa dentro do meu handler. Espera circular.

O mais desconfortável é que essa lição já estava escrita **duas vezes** nesta base, com narrativa de
campo: `pTrataEvento` e `pTrataHook` do `untTefCitelDvc.pas` foram os dois trocados de
`TThread.Synchronize` para `TThread.Queue` por exatamente isso, e o comentário do
`pDespachaChamadaEmThreadPropria` diz que `chamada` roda em thread própria pelo mesmo motivo. Eu li
esses comentários nesta sessão, citei um deles ao justificar a thread curta do `pOnConectado` no lado
AUTCOM — e não apliquei o mesmo raciocínio ao lado estação, onde eu estava adicionando um handler que
escreve.

O que salvou foi a pergunta "em qual thread isto roda?" feita como item de revisão, não como
intuição. Vale como regra para os passos seguintes: **todo handler novo que escreve no transporte
precisa dessa pergunta respondida por escrito antes de ser considerado pronto.**

Na mesma revisão saíram dois ajustes menores da mesma natureza: a consulta à fila foi para antes da
criação do `TJSONArray` (ela faz I/O, pode levantar, e o array fica sem dono até entrar no envelope),
e os dois `GetValue(...) as TJSONArray` viraram teste com `is` — um frame malformado levantaria
`EInvalidCast` dentro da cadeia de leitura, e o transporte trata exceção nessa cadeia como
desconexão, então um campo torto derrubaria a conexão.

### Estado

`TefEstacaoService.exe` 11:15:20 e `libTefCitel.dll` 11:15:22, os dois compilando limpo, encoding
conferido nas quatro units. Falta validar em campo: o que olhar é a linha `pTrataReata: ... Ids
pedidos: X emVoo, Y naFila, Z desconhecido(s)` na estação e `pEnviaReata`/`pTrataReataResposta` no
AUTCOM. Depois disso, o Passo 4 — que é onde o comportamento realmente muda.

---

## 2026-09-09, 11:25–11:28 — O Passo 3 entregou mais do que prometia, e mediu o peso do Passo 4

### O que se esperava, e o que veio a mais

Esperava-se ver o `pTrataReata` no log e a drenagem da fila acontecer no accept. Veio isso, e veio
uma coisa que eu não tinha antecipado: **a `FConexaoAtual` manteve a transação em voo conversando
com o operador através da reconexão.** Todos os eventos do pinpad — dezenas deles, o fluxo inteiro
de `Aguarde...`, `SELECIONADO: MASTERCARD`, `Escolha uma Opção` — foram entregues pela con=2, e no
fim a própria resposta do `fPassarCartao` (id=6) também. Nada foi para a fila.

Isso reordena a importância das peças: a fila local, que era o mecanismo central da RF07, passa a
ser o último recurso. Ela só entra quando não há **nenhuma** conexão viva daquele pid. Entregar é
melhor que enfileirar, e a `FConexaoAtual` entrega.

### O deadlock que eu corrigi, validado por acidente

```
11:27:35.775  TCP[con=2]: sem ACK do messageId=2 apos 2000 ms (tentativa 1/5) - reenviando.
11:27:36.691  TCP[con=2]: recebidos 21 bytes.
```

`messageId=2` é o `reata_resposta`. Ele esperou ACK, não recebeu em 2 s, retransmitiu e foi
confirmado. É a prova de que a escrita rodou de uma thread que **podia** esperar: se o
`pTrataReata` tivesse ficado inline no `pOnFrameRecebido`, essa espera travaria a própria thread de
leitura que precisava receber o ACK, e a conexão penduraria ali.

Não foi sorte, mas também não foi por eu ter previsto este log: eu corrigi por raciocínio, e o
campo confirmou que o raciocínio estava certo. Vale registrar porque é o tipo de bug que, se
tivesse escapado, apareceria como "a reconexão às vezes trava" — dificílimo de atribuir depois.

### O achado que mede o Passo 4

Entre a queda (11:27:02) e o `pSair` (11:28:17) passaram **75 segundos** em que o pinpad ficou
repetindo `Escolha uma Opção` / `1:2:3::` e o serviço reenviando o evento a cada poll, sem ninguém
para responder: o AUTCOM já havia estourado com `ErroCanal` e fechado a tela.

Isso muda como eu descrevia o Passo 4. Eu vinha dizendo que ele serve para "recuperar a venda" —
registrar o que a estação concluiu. O log mostra algo mais imediato: **o operador não consegue
terminar a transação.** O pinpad está no meio de um menu, esperando a escolha de parcelamento, e a
tela que faria essa escolha não existe mais. Com a chamada esperando (Passo 4), a tela continua e o
fluxo fecha sozinho, sem pendência nenhuma.

Ou seja, o Passo 4 é menos sobre contabilidade e mais sobre a transação **poder ser concluída**. É
um argumento mais forte do que o que estava na spec, e vem de medir 75 s num log.

### Estado

Passo 3 validado em campo. O `pSair` deliberado logou pela primeira vez (11:28:17.268), com o texto
completo da decisão do Rafael. O reenvio da fila continua sem exercício — e agora importa menos.

---

## 2026-09-09, tarde — O Passo 4 que virou três linhas, e por que verificar o nativo mudou a resposta

### A proposta

Depois de ver o log das 11:27, o Rafael propôs simplificar: *"quando acontecer essa instabilidade
durante o voo, apresenta a mensagem para o operador e aborta a transação (pSair) para o operador
tentar novamente"*.

A elegância dela não é óbvia de primeira: hoje o AUTCOM grava `TRN CANCEL` **sem saber** se a
transação foi cancelada — foi o achado do carimbo de hora, 34 s antes de a estação decidir.
Abortando de verdade, o `TRN CANCEL` **passa a ser verdade**. O defeito se resolve tornando o valor
correto, não mudando o valor. Isso é melhor que a RF25 parte 2 em simplicidade e igual em
honestidade do registro.

### A pergunta que decidia se era seguro

Antes de concordar eu precisava saber: **o que o `pSair` faz numa transação já autorizada?** Se ele
chamasse `FechaSessaoTEF` com confirmação — como o `fConfiguraTefCitel` do login faz, e que já
causou o incidente de 08/09 — abortar depois da autorização confirmaria a venda enquanto o AUTCOM a
registra como cancelada. Dinheiro capturado, nada registrado: o pior desfecho possível, e o inverso
exato do defeito atual.

Fui ao nativo, e a resposta desarmou o risco:

```pascal
procedure TTefCitelNCR.pSair(blnSair: Boolean);
begin
  FblnSaiu := blnSair;
  pUsuarioEncerraTransacao;   // FintContinua := -1
end;
```

`pSair` **não** chama `FechaSessaoTEF`. Ele levanta uma flag, e essa flag é lida num callback que a
DLL do Scope consulta enquanto coleta — o comentário do próprio código diz *"pega a tecla 9 da
aplicação"*. Abortar equivale ao operador apertar cancelar no pinpad, pelo caminho nativo normal.

E há proteção por construção: o laço só consulta a flag enquanto `iRet = SCO_TRN_EM_ANDAMENTO`.
Passada a coleta, ela não é mais lida. **Não existe o risco de abortar transação já autorizada** —
no pior caso o aborto chega tarde e é ignorado.

Vale como método: a mesma pergunta ("o que este método faz por baixo?") já derrubou quatro
premissas neste requisito. Aqui ela fez o oposto — confirmou que a ideia era segura, e transformou
uma objeção séria numa ressalva estreita.

### Uma terceira opção, que dominou a proposta original

Se o aborto é a decisão, quem está em melhor posição de executá-lo é a **estação**: ela sabe da
queda no instante em que acontece, enquanto o AUTCOM só poderia mandar o `pSair` depois de o canal
voltar — 23 s na medição das 11:27. E abortar cedo é o que importa, porque a flag só é lida
enquanto a coleta durar.

Ficou em três linhas dentro do `pOnDesconectado`, sem protocolo novo, **sem tocar na DLL do
AUTCOM**. O Passo 4, que era "a mudança de comportamento mais sensível da fase", virou o passo mais
barato dela.

### E a alternativa que ficou barata sem ninguém planejar

Registrado na spec porque é informação perecível: a bateria das 11:27 mostrou que o lado da estação
de "continuar a transação" **já funciona**. Com a `FConexaoAtual` do Passo 3, todos os eventos do
pinpad e a própria resposta atravessaram a reconexão. Faltava só o `fChamaRpc` não desistir.

O Rafael escolheu o aborto de qualquer forma, por simplicidade do processo — retentativa em vez de
continuação. É decisão dele e está registrada como tal. Mas a alternativa está a poucas linhas de
distância, e a spec diz isso, para o caso de a operação pedir depois: perder 75 s de menu e refazer
a venda é pior que continuar, se continuar custar pouco.

### Resíduo

Queda com a transação já fora da coleta → aborto ignorado, desfecho igual ao de hoje: aprovada na
adquirente, `TRN CANCEL` no AUTCOM, pendência pela RN09. A janela é estreita — autorização dura
segundos, coleta dura o tempo do operador — e fechá-la exigiria exatamente a RF25 parte 2 que saiu
de escopo.

---

## 2026-09-09, 12:11 — O aborto funcionou, a fila estreou, e a trava vazava por um caminho que a Fase 5 abriu

### As duas estreias

O aborto pela estação levou **5 ms** para ser decidido e **625 ms** para o pinpad responder
`Transacao cancelada`. O `pSair` foi lido enquanto a DLL ainda coletava, exatamente como o desenho
previa — a proteção por construção (a flag só é lida enquanto `iRet = SCO_TRN_EM_ANDAMENTO`) não
precisou ser exercitada, porque a queda pegou a fase certa.

E o **reenvio da fila local rodou em campo pela primeira vez**, às 12:12:37.990, com as cinco
contagens que o roteiro previa. Era o último item do Passo 8, pendente desde 08/09 — e ele só
aconteceu porque a resposta não tinha para onde ir na hora (a con=3 só chegou 18 s depois), o que é
justamente o cenário para o qual a fila existe. O gatilho foi o `reata`, no accept, sem o operador
fazer nada.

O TEFTRA fechou o círculo: `TRN CANCEL` às 12:12:12, **depois** de a estação ter cancelado de fato
às 12:12:04. Na bateria das 10:32 o AUTCOM escrevia o desfecho 34 s **antes** de ele existir. O
valor não mudou; passou a ser consequência de um fato.

### A trava LCKATC, e por que ela vazava agora

O Rafael apontou o que importava: *"esse erro está deixando uma trava na LCKATC"*.

A cadeia é curta e cada elo já existia:

1. A LCKATC é tomada no hook `fAntesPassarCartaoEvent`.
2. Ela é liberada no `pDepoisPassarCartaoEvent` — e **só quando o retorno vem nil**.
3. Sob DVC, os hooks `Depois*` deixaram de trafegar em 31/08 (eram o único payload grande do
   protocolo, causa da corrupção de framing daquela investigação) e passaram a ser chamados
   **localmente**, na linha seguinte ao RPC.
4. Quando o `fChamaRpc` estoura, a exceção sobe **por cima** dessa linha. O callback não roda. A
   trava fica.

Nenhum desses quatro passos é novo, mas a combinação só se tornou alcançável de forma rotineira
quando a Fase 5 fez a queda de canal virar um evento comum em vez de uma catástrofe rara. É o
**terceiro** defeito latente que esta fase desenterra ao remover um acidente de proteção — depois do
AV em ponteiro descarregado e do `TRANSACAO_CANCELADA` em transação aprovada. O padrão já estava
anotado; agora tem três casos.

### A correção, e por que ela usa o caminho que já existia

Em vez de inventar tratamento de erro, a queda de canal passou a ser **um desfecho conhecido**:

- `ETefCitelDvcCanal`, classe própria, separada de `ETefCitelDvcRpc` — erro real de RPC continua
  subindo como antes. Isso importa: capturar tudo esconderia "Estacao retornou erro em X".
- Os quatro métodos que tomam ou liberam a trava capturam essa classe, chamam o `Depois*` com nil
  (que é o valor que **libera** a trava) e devolvem nil.
- A tela é avisada pelo caminho que ela já conhece: status **500**, a mesma forma que a estação usa
  no `pEnviaEventoNegado`. Do lado da tela isso cai em `pMsgInfo500`, que mostra um `fMensagem`
  normal do projeto e preenche o `FstrMotivoTransacaoNegada`. Resultado: o diálogo do madExcept
  desaparece, e o texto genérico "Houve um problema com a transação" não sobrepõe o motivo real.

O texto da mensagem foi escrito com cuidado para não mentir: diz que foi cancelada — o que agora é
verdade, porque a estação aborta — mas manda conferir o relatório, porque o resíduo de 10.5
(queda fora da fase de coleta) ainda pode deixar uma transação aprovada.

### O que fica para a mão

A trava deixada pela bateria das 12:11 **continua no banco**. A correção previne novas, não limpa a
existente. Removê-la pelo relatório de travas, uma vez.

---

## 2026-09-09, 15:44–15:51 — A bateria estendida: o desenho do Rafael validado ponta a ponta

### O que mudou de qualitativo

As baterias anteriores provaram peças. Esta provou o **fluxo**: quatro ciclos alternando queda em
voo e retentativa, nos dois métodos de transação que o operador de fato dispara, com a fila
drenando nas duas vezes que precisou e uma pendência sobrevivendo a duas reconexões antes de ser
confirmada.

O aborto ficou em 10 ms e 23 ms da queda até a decisão, e o pinpad respondeu `Transacao cancelada`
em 1,2 s e 438 ms. E as duas retentativas seguintes foram autorizadas normalmente — o que é o ponto
inteiro da simplificação que o Rafael propôs: não recuperar a venda, deixar o operador refazê-la
rápido.

### Duas coisas que só apareceram por acumular baterias

**A identidade do serviço fez round-trip.** No primeiro reata o AUTCOM mandou
`instanciaServico=""`; nos dois seguintes mandou o GUID correto. Isso não estava sendo testado de
propósito — é consequência de a bateria ter tido três reconexões em vez de uma. Prova que o
`pTrataReataResposta` guarda e o `pEnviaReata` devolve, que é o mecanismo do RF29 (detectar
reinício do serviço) funcionando antes de ter consumidor.

**O dedup por conjunto enfrentou a primeira rajada real.** O plugin aceitou o canal 27 s antes de o
serviço subir; nesses 28 s o AUTCOM retransmitiu o mesmo `fConfiguraTefCitel` cinco vezes por ACK
timeout, e ao conectar tudo chegou junto: `recebidos 2710 bytes`, 1 aceito e **4 duplicados
descartados**. É exatamente o cenário da correção de 04/09 — dedup por conjunto dos últimos 512
ids em vez de ordem estrita — e nunca tinha sido exercitado com uma rajada. Um efeito colateral de
testar com o serviço parado.

### Uma latência que eu prefiro anotar do que deixar passar

O ACK do `reata_resposta` demorou 4–6 s e precisou de 1 a 2 retransmissões em **3 dos 4** reatas
desta bateria. Nada falha — a retransmissão cobre — mas é um padrão, não um acaso.

Hipótese, e é só hipótese: o `pEnviaReata` roda numa thread própria (foi assim que eu evitei o
deadlock) e segura o `FcsEscrita` do transporte enquanto espera o ACK do próprio reata; o ACK do
`reata_resposta`, que a thread de leitura precisa enviar, disputa esse mesmo lock. Se for isso, são
4 s de latência gratuita em cada reconexão, e o conserto é pequeno.

Anotado para o Passo 8 (fechamento). Registro aqui porque é o tipo de coisa que, sem nome, vira
"às vezes a reconexão demora um pouco" e nunca é investigada.

### O que a evidência NÃO cobre

A ausência de trava na LCKATC e a ausência do diálogo do madExcept vêm do **relato do Rafael**
(*"funcionou perfeitamente"*), não do log: as duas são do lado AUTCOM e do banco, e o log da estação
não as enxerga. Registrado como ressalva de evidência, não como dúvida sobre o relato — mas se
alguém for reauditar isso meses depois, precisa saber onde olhar.

### Estado

Passos 0 a 5 da Fase 5 prontos e validados. Restam o Passo 6 (sonda para o AUTCOM travado), o
Passo 7 (coleta de órfãs e varredura de subida) e o Passo 8 (fechamento). A Fase 4 continua
esperando, e começa pelo `svn revert` do `untTefEstacaoPipeTransporte.pas`.

---

## 2026-09-09, Passo 6 — A sonda de vivacidade: como a estação passou a perguntar em vez de supor

### O que o Passo 5 deixou na mesa

A RF24 fez a sessão sobreviver à queda da conexão. Foi ela que fez a transação atravessar a
oscilação de TS, e é o pilar do requisito. Mas ela derrubou uma equivalência que o código todo
usava sem dizer: **até a Fase 5, estar no `FdictSessoes` era o mesmo que estar vivo**, porque
`pOnDesconectado` removia a sessão. Dois comentários no roteador afirmavam isso em voz alta —
*"'vivo' sai de graça"* — e os dois ficaram falsos no instante em que o Passo 5 entrou.

O sintoma prático: um AUTCOM travado, ou um cuja conexão nunca mais volta, segura o pinpad para
sempre. Antes a queda de conexão liberava; agora não libera mais nada.

### Por que a sonda funciona, e por que ela é exata

O discriminador não está na estação — está em como o outro lado do canal processa hooks.
`pTrataHook` despacha o corpo por `TThread.Queue`, ou seja: o corpo roda na **thread principal**
do AUTCOM. Isso dá as duas metades de uma vez:

- um AUTCOM travado nunca drena essa fila, então nunca responde;
- um AUTCOM saudável responde **mesmo no meio de um `fPassarCartao`**, porque o laço de espera de
  `fChamaRpc` bombeia `CheckSynchronize` e `Application.ProcessMessages` — bombeamento que existe
  desde a correção de 28/08, por outro motivo inteiramente.

Nada disso foi construído para a sonda. A sonda só usa o que já estava lá, e é por isso que ela
não custa tráfego periódico: só é perguntada quando alguém disputa.

### Uma correção que a sonda exigiu, e que eu não tinha previsto

`fEnviaHookEAguarda` devolve `ok=true` em **três** desfechos diferentes: o hook foi respondido, o
prazo estourou, ou a conexão de destino caiu no meio (`pOnDesconectado` sinaliza o evento sem
`Resposta`). Para os hooks `Antes*` isso é o *default seguro* e está correto — deixar a transação
seguir é o desfecho certo quando não se sabe.

Para a sonda seria o desastre silencioso: ler "o detentor está vivo" de um AUTCOM que acabou de
desaparecer, e recusar o requisitante para sempre. Foi preciso um `out AblnRespondido` que separa
*sinalizado* de *respondido*, e exigir um campo `vivo` explícito na resposta em vez do `ok`
genérico. Duas defesas para a mesma coisa, de propósito: o `ok` é ambíguo por design e não vale a
pena tentar desambiguá-lo.

### O ponto mais delicado: quem tem direito de derrubar quem

Esta é a parte que o Rafael cravou no debate de desenho — *"o autcom A não pode derrubar o autcom
B e vice-versa, acredito que esse é o ponto mais crítico"* — e a implementação tem três travas
para ela:

1. **A sonda é o veto, e o requisitante não a controla.** Detentor que responde recusa o
   requisitante, e nem removendo a trava LCKATC na mão ele passa. É mudança de comportamento em
   relação a hoje, na direção segura.
2. **O veredito é conferido contra o detentor atual.** O requisitante volta dizendo "o pid N,
   nascido em T, está morto" — e a estação só aceita se N e T forem o detentor **daquele
   instante**. Sem isso, um veredito emitido sobre A autorizaria tomar o pinpad de B, que pode ser
   de outra empresa e estar perfeitamente saudável.
3. **"Morto" só vale com a conexão caída.** Conexão aberta é prova de que o processo existe;
   aceitar um relato de morte contra ela seria preferir o relato ao fato.

E do lado do requisitante, `fProcessoAutcomVivo` responde **vivo em toda dúvida**: acesso negado,
`GetProcessTimes` falhando, pid zero, detentor de versão antiga que não manda `inicioProcesso`. O
erro barato é travar a tomada; o caro é orfanar a sessão de quem estava trabalhando. A função
também confere o par (pid, criação) e olha o `GetExitCodeProcess`, porque handle abrível não é
prova de processo vivo — o zumbi do Windows continua abrível enquanto alguém segurar um handle.

### Onde a pergunta ao operador ficou morar, e o preço disso

A RN16 exige confirmação humana no caso "travado", por um falso positivo que o próprio `record.md`
já tinha registrado: a closure do hook pode ficar atrás de um `fMensagem` **modal** na fila FIFO,
e aí um AUTCOM saudável não responde a sonda no prazo.

O problema é que a `libTefCitel.dll` não linka `libFuncoes` — ela não enxerga o `fMensagem` do
projeto. Duas saídas: um diálogo VCL cru dentro da DLL (barato, mas com outra cara e fora do
padrão do CLAUDE.md) ou um callback registrado pelo host. **O Rafael escolheu o callback.**

O preço é concreto e vale registrar: até aqui a Fase 5 tinha mudado **só o serviço e a DLL**; a
partir do Passo 6 o `autcom.exe` também muda, e são três binários a implantar no teste. Pior: o
`autcom.dproj` **não compila por linha de comando nesta máquina** — falta o `.dcp` do pacote
`faturamento.impostos.interfaces`, que não existe em lugar nenhum do disco nem está no
`autcom.groupproj`. Problema pré-existente, mas que só apareceu agora porque é a primeira vez
nesta fase que o host precisa ser recompilado. A compilação do `autcom.exe` fica com a IDE.

### O que eu deliberadamente não fiz

**Transação em voo não dispara disputa.** Tomar o pinpad significa orfanar a sessão do detentor, e
a RN08 proíbe destruir instância com thread de despacho rodando. Mas o argumento decisivo é outro:
"em voo" é transitório — se a conexão do detentor cair, o Passo 4 aborta com `pSair` em
milissegundos. Não há detentor em voo permanente para disputar.

**Método que não é de transação também não.** A disputa custa até 5 s de sonda e pode acabar em
pergunta ao operador. Um `pInfo21` da Modalidade Dinâmica roda dezenas de vezes por venda, e o
operador nem sabe que ele existe.

**O login continua adiado, sem sonda.** A disputa acontece na primeira chamada de pinpad, que é
quando o operador de fato quis usar o TEF — e portanto o momento certo de perguntar. Sondar no
login incomodaria em toda subida de AUTCOM.

### Um resíduo de desenho que eu não vou implementar sem rediscutir

A RN13 diz que `fOutroAutcomDetemPinpad` e `fSessaoVivaComPendencia` devem isentar só a **conexão
atual**, não o PID, para que *"o re-login do próprio AUTCOM não confirme a pendência que ele mesmo
deixou"*. Está desmarcada no Passo 5 e continua desmarcada.

Dois motivos. O primeiro é que hoje ela é inócua: `FdictSessoes` é indexado por PID, `fGaranteSessao`
reata por identidade, e um PID reusado orfana a sessão anterior — não existe o caso de duas
conexões concorrentes do mesmo PID que a regra descreve. O segundo é mais sério: **"o re-login do
próprio AUTCOM não confirma a própria pendência" colide de frente com o caso 1.** Na oscilação, o
AUTCOM volta com o mesmo processo e a pendência preservada, e confirmar essa pendência é
exatamente o desfecho exigido — foi o que a bateria das 15:51 validou (`fFinalizarTransacao` id=16
com sucesso após duas reconexões).

Pode ser que a RN13 tenha sido escrita pensando num terceiro cenário que eu não estou vendo. Mas
implementá-la pela letra, hoje, ou não muda nada ou quebra o pilar do requisito. Fica para
conversa.

### Um vazamento pré-existente que apareceu de perto

Dividir `fChamaRpc` em casca e núcleo (`fChamaRpcUmaVez`) expôs que o guard de clique duplo dava
`Exit(TJSONObject.Create)` **sem liberar o `ADados`** — quem consome esse objeto é o
`pEnviaEnvelope`, que naquele caminho não roda. Um `TJSONObject` por clique duplo, desde 28/08.
Corrigido de passagem, uma linha.

### Estado

Passos 0 a 6 da Fase 5 implementados; 0 a 5 validados em campo, o 6 **não**. Restam o Passo 7
(coleta de órfãs RF28 e varredura de subida RF29) e o Passo 8 (fechamento). A Fase 4 continua
esperando, e começa pelo `svn revert` do `untTefEstacaoPipeTransporte.pas`.

---

## 2026-09-09, 17:08 — "Não passou pela trava LCKATC": a guarda certa estava atrás da errada

### A pergunta do Rafael

Primeira bateria com dois AUTCOM depois do Passo 6. A (pid 20816) com `fPassarCartao` em voo, B
(pid 167760) tenta passar cartão e leva o diálogo do madExcept. A observação: *"achei estranho que
não passou pela trava lckatc do próprio autcom"*.

### A resposta está numa linha que não existe no log

O log prova por **ausência**. `fEnviaHook: hook="AntesPassarCartao"` aparece na chamada do A
(17:07:47.970, respondido em 47 ms) e na chamada do B que passou depois (17:09:47.923, 32 ms). Na
chamada do B que falhou, às 17:08:36, essa linha simplesmente não existe.

E é lá dentro que a trava vive: a LCKATC é tomada em `fAntesPassarCartaoEvent`
(`untTefCitelUtil.pas:3208`), que sob DVC só roda quando a **estação** manda o hook. Recusa antes
do despacho = hook não sai = `fLockUnlockTefCitel` nunca é chamado no AUTCOM que chegou.

**A ordem se inverteu, e isso é estrutural da migração.** Na arquitetura clássica o nativo rodava
dentro do próprio processo, então a trava era a primeira coisa consultada e o operador via
*"Concluir o recebimento pelo TEF da outra sessão do Autcom"*. Sob DVC a guarda da estação vem
primeiro e responde sem perguntar nada ao AUTCOM.

Vale dizer o que isso **não** é: não é perda de proteção. A guarda da estação é mais forte que a
LCKATC — a LCKATC é por empresa (`fRetornaChaveLockTefCitel`) e nunca alcançou dois AUTCOM de
empresas diferentes, que é justamente o caso que motivou a Fase 3.5 inteira.

### O defeito real: uma guarda boa escondida atrás de uma ruim

Quem barrou o B foi o **single-flight** de `pTrataChamada` (linha 1891), que responde com
`pEnviaRespostaErro` → `ok=false` → `ETefCitelDvcRpc` → madExcept.

Três linhas depois, em `pGarantePinpadConfigurado` (linha 1972, guarda na 2212), a **RF17 item 1**
barra exatamente o mesmo caso — outro PID com transação em voo — e já respondia do jeito certo:
evento 500 + resposta sem retorno, que do lado da tela é um `fMensagem` normal do projeto.

Ela nunca era alcançada. A guarda boa estava atrás da ruim, e por isso ninguém tinha percebido que
a ruim ainda existia.

### A correção não é duplicar a mensagem

A tentação era copiar a negativa para dentro do single-flight. O certo é mais simples: o
single-flight só precisa proteger contra o **mesmo** PID reentrando. O caso cruzado é trabalho da
RF17 item 1, e ela faz melhor.

Então, para PID diferente, o single-flight não responde nada — não reserva o slot, não despacha,
deixa seguir. Três linhas adiante a chamada é recusada com a mensagem certa, sem nunca encostar na
DLL. E ganha-se um efeito colateral bom: o intervalo entre as duas checagens deixa passar o caso
legítimo em que a transação do outro terminou nesse meio-tempo.

Para o mesmo PID nada muda — e ali o erro cru é adequado, porque não é negativa de negócio, é uma
chamada que não deveria existir. Na prática o operador nem vê: o `FdictMetodosEmAndamento` do lado
AUTCOM barra o segundo clique antes de ele virar frame.

### O padrão, agora com quatro casos

Este é o **quarto** caminho de recusa que respondia como erro de RPC em vez de negativa — depois
do `pRecusaSePendenciaDeAutcomVivo` (corrigido em 04/09), da queda de canal (09/09, manhã) e do
`pGarantePinpadConfigurado` sem config. Vale como regra ao mexer nesta unit: **toda recusa que o
operador possa provocar deve sair como negativa; erro de RPC é para o que ele não causou.**

Não é regressão do Passo 6 — o single-flight é de 28/08. Só ficou visível agora porque foi a
primeira bateria com dois AUTCOM disputando o pinpad desde então.

### Nenhuma trava vazou

O B nunca pegou a LCKATC (o hook não saiu) e o A pegou às 17:07:48 e soltou no
`fFinalizarTransacao` das 17:09:31. E o Passo 6 não foi exercitado nesta bateria: a marca de
pendência ficou `False` nas duas sessões, então a disputa nunca teve motivo para rodar.

---

## 2026-09-09, 17:28 — A sonda nasceu e morreu no mesmo dia, e um login que nunca acontecia

### O que o Rafael viu

*"Fiz a transação no A e deixei pendente, fui no autcom B e tentei fazer a transação: apareceu a
pergunta para o operador se ele queria o pinpad para ele (achei errado, pois o autcom A estava vivo
só aguardando eu desfazer/confirmar a transação)."*

Ele está certo. E o erro não é de calibragem de prazo — é estrutural, e é meu.

### O furo do desenho, em uma frase

**A disputa só acontece contra o detentor por PENDÊNCIA. E um AUTCOM com pendência está, por
definição, fora de qualquer chamada de TEF.**

Eu escrevi, no comentário da sonda e na spec, que o discriminador era exato porque *"um AUTCOM
saudável responde mesmo dentro de um `fPassarCartao`, já que o `fChamaRpc` bombeia
`CheckSynchronize` e `ProcessMessages`"*. A frase é verdadeira. Ela também é completamente
irrelevante, porque o único caso que chega à sonda é o caso em que o detentor **não** está dentro
de chamada nenhuma — está parado esperando o operador decidir. Eu validei a propriedade no estado
errado.

Varrendo todas as baterias do requisito: **todo hook já respondido neste projeto foi respondido com
o AUTCOM dentro do laço de bombeamento do `fChamaRpc`.** Não existe um único caso, em nenhum log,
de hook respondido com o AUTCOM ocioso. O dado estava lá o tempo todo; eu não tinha olhado para
ele com essa pergunta.

### A evidência de campo, que é limpa

- `17:28:00.211 fEnviaHook: hook="Vivacidade" id=2 despachado`
- `17:28:00.233 TCP[con=1]: recebidos 21 bytes` — o ACK do A, em **22 ms**. O transporte dele
  estava perfeitamente vivo.
- `17:28:05.242 ESTOUROU o timeout de 5031 ms`

O quadro chegou e foi confirmado; o corpo do hook, que está na fila do `TThread.Queue`, não rodou.

### O que ficou no lugar

Quem responde "está travado?" passou a ser o **Windows**, por `IsHungAppWindow` — a mesma API que
decide quando escrever "Não Está Respondendo" na barra de título. Quem pergunta é o AUTCOM
**requisitante**, que já verificava o processo do detentor pela RN17 e roda no mesmo servidor, então
não há dependência nova.

Três degraus, em `fResolveDisputaPinpad` do lado AUTCOM:

| Detentor | Desfecho |
|---|---|
| Processo morto | Tomada automática, sem perguntar (RN16) |
| Processo vivo, **respondendo** | Recusa **sem incomodar o operador**, com mensagem própria |
| Processo vivo, **travado** | Pergunta ao operador |

E `fJanelaPrincipalTravada` responde **NÃO TRAVADO em toda dúvida** (janela não encontrada, pid
zero). Errar para "não travado" apenas devolve o comportamento anterior ao Passo 6; errar para
"travado" ofereceria tomar o pinpad de quem está trabalhando.

### O que isso custou, e por que aceitei

A RN15 dizia que *"o veto é a sonda, e o requisitante não tem como falsificar nem contornar"*. Sem
sonda, o veto passa a depender do relato do requisitante. A trava real vira a confirmação humana,
somada às duas guardas que a estação ainda faz sozinha: o par (pid, inicioProcesso) tem que bater
com o detentor **daquele instante**, e "morto" só é aceito com a conexão caída.

Na direção que importa, porém, o comportamento **melhorou**: um detentor que está trabalhando é
recusado sem que ninguém seja perguntado — que é exatamente o que o Rafael esperava e o que a
sonda, na prática, não entregava.

### Limpeza que veio junto

Sem a sonda, nenhum hook precisa de destino ou prazo próprios. Reverti `fEnviaHookEm` /
`fEnviaHookEAguardaEm` para o `fEnviaHook` / `fEnviaHookEAguarda` de antes, e apaguei
`TEF_ESTACAO_TIMEOUT_SONDA_MS` e `fSondaVivacidade`. Deixar uma generalização com um único chamador
é pior do que revertê-la — e o CLAUDE.md é explícito sobre não refatorar proativamente na zona
legado. Ficou só a guarda que era um conserto de verdade: `fEnviaHookEAguarda` devolvendo objeto
em vez de `nil` quando o evento é sinalizado por queda de conexão.

### O segundo achado: um login que nunca acontecia

Depois que o A desfez a transação, o B passou a falhar com **"Erro Desconhecido (64004)"** em
~140 ms, sem chegar ao pinpad. A cadeia está inteira no log:

1. **17:27:08.658** — login do B **ADIADO** pela RF17 item 4, porque o A estava em voo. A DLL não
   foi chamada.
2. A configuração do B deveria entrar na primeira chamada de pinpad, pela reaplicação de
   `pGarantePinpadConfigurado`. **Nunca entrou** — não existe uma linha `REAPLICANDO` para o
   pid=105100 no log inteiro.
3. O motivo estava escrito no comentário do próprio `fImpressaoDigitalConfig`, desde 04/09:
   *"Dois autcom da MESMA empresa e MESMO terminal produzem a mesma impressão digital - e aí a
   reaplicação é pulada."* Os dois AUTCOM do teste são terminal 003, mesma loja.
4. **17:28:50.774** — `status="64004"`, sem nenhum evento de pinpad.

O contraste fecha o caso: na bateria das 17:07 o login do B **rodou nativamente** e a transação
dele chegou ao pinpad normalmente.

**A causa raiz é uma confusão de escopo que eu não tinha visto.** A impressão digital responde *"a
DLL está configurada assim?"* — um fato de **processo**. Mas o login é também um fato de
**instância**: é o `fConfiguraTefCitel` que monta o estado dentro da `ITefCitel` daquela sessão.
Uma sessão com login adiado tem a digital igual à de quem está na DLL e mesmo assim nunca executou
o próprio login. A sessão ganhou `FblnCfgAplicadaNaInstancia`, e a saída antecipada por digital
passa a exigir as duas coisas.

Pré-existente da RF17 item 4 (08/09), e só alcançável com dois AUTCOM da **mesma empresa e mesmo
terminal** — a combinação que faz as duas digitais colidirem, e que ainda não tinha sido testada.

### O padrão do dia

Dois defeitos, e os dois pela mesma raiz: **eu tratei um fato de instância como se fosse um fato
de processo.** A sonda mediu "o processo responde?" quando a pergunta era "esta instância de UI
está drenando a fila?". A impressão digital mediu "a DLL está configurada?" quando a pergunta era
"esta instância fez o login dela?". Vale como alerta ao mexer nesta unit: o serviço tem UM processo
e VÁRIAS sessões, e quase todo estado interessante mora numa das duas camadas, nunca nas duas.

### Estado

Passo 6 reimplementado sem a sonda, mais a correção do login adiado. Serviço e `libTefCitel.dll`
compilam limpo; o `autcom.exe` continua precisando da IDE. Nada validado em campo ainda — o
roteiro no `tasks.md` ganhou o caso do login adiado e teve os três primeiros casos reescritos.

---

## 2026-09-10, 07:23–07:27 — O redesenho passou, e o log mostra por que a sonda nunca podia passar

### O veredito

*"Funcionou perfeito"*. Dois casos provados, e os dois eram exatamente os dois defeitos de ontem.

**Caso 1 — o detentor saudável.** A autoriza às 07:24:23 e não finaliza; B tenta passar cartão às
07:25:14. Desfecho: `CONTESTAVEL` → `IsHungAppWindow=False` → `recusando sem perguntar nada ao
operador` → `status="500"`. **Nenhuma pergunta apareceu**, que é o que o Rafael tinha apontado como
errado. B tentou de novo às 07:25:27 e teve o mesmo desfecho.

**Caso 6 — o 64004.** A finaliza às 07:25:59. No primeiro cartão do B, às 07:26:06:
`o pid=70668 nunca executou o proprio fConfiguraTefCitel ... aplicando agora` → `REAPLICANDO` →
pinpad → `Controle 09005933014` → venda concluída, com `fFinalizarTransacao` às 07:26:50.

### O detalhe do log que fecha o argumento de ontem

A linha da reaplicação traz as duas impressões digitais no mesmo `Format`:

```
a DLL esta configurada para o pid=146628 ("T||172.30.96.233|69690001|003|ComPort=COM6;MsgPP=...")
- REAPLICANDO a configuracao do pid=70668  ("T||172.30.96.233|69690001|003|ComPort=COM6;MsgPP=...")
```

São **byte a byte iguais**. É a colisão que fazia a saída antecipada pular a reaplicação, e a
reaplicação aconteceu mesmo assim — que é precisamente o que o `FblnCfgAplicadaNaInstancia` existe
para garantir. Não é inferência: é a evidência direta do fato de instância vencendo o fato de
processo.

### Duas coisas que só o campo podia responder, e responderam bem

**O `EnumWindows` acha a janela principal dentro da sessão TS.** `fJanelaPrincipalTravada:
pid=146628, janela 0x330B7E`. Era o risco silencioso da abordagem — se não achasse a janela, a
função responderia "não travado" por conservadorismo e a tomada nunca aconteceria, sem erro
nenhum aparecendo. Achou.

**O `IsHungAppWindow` respondeu em 1 ms.** O ciclo inteiro do lado AUTCOM — receber a resposta
contestável, verificar a janela, decidir, notificar a tela — levou **12 ms** (07:25:14.826 →
.850). A sonda gastava 5 s para chegar à conclusão errada. O contraste é a medida do erro de
ontem.

### O que ainda não tem prova, e é a parte que mais precisa

Os casos 2 a 5. **O caminho de tomada do pinpad nunca rodou nesta bateria** — nem a pergunta ao
operador, nem o `pSetConfirmaTomadaPinpadTef` (o export novo e o callback no host seguem com zero
execuções), nem `fTomadaAutorizada`, nem o orfanamento disparado pela disputa.

Vale registrar a assimetria com clareza: o caminho **validado** é o de recusa, que é o comum e o
inofensivo. O caminho **não validado** é o que tira o pinpad de outro AUTCOM — o mais perigoso do
requisito, e o único que a RN16 protege com confirmação humana. Ele está escrito, compila, e não
tem uma linha de log provando que funciona.

### Um erro de texto que a bateria expôs

`A impressao digital True a da DLL` — eu passei um `BoolToStr` para um `%s` que pedia uma frase.
Cosmético, mas é log de diagnóstico, e log de diagnóstico que não se lê direito é log que não
serve. Trocado por `BATE com` / `NAO bate com`.

### Resíduo esperado

`2 sessao(oes) no dicionario` depois de os dois AUTCOM desconectarem (07:26:59 e 07:27:03) — é a
RF28, do Passo 7, que ainda não existe.

### Estado

Passo 6 parcialmente validado: casos 1 e 6 provados, casos 2 a 5 em aberto. Restam o Passo 7
(coleta de órfãs RF28 + varredura de subida RF29) e o Passo 8 (fechamento).

---

## 2026-09-10, 07:36 — O backup achou três coisas que valem mais que o backup

Backup de rotina do marco do Passo 6. A parte útil não foi o backup: foi conferir o resultado
**arquivo a arquivo contra o backup de 09/09 16:12** antes de declarar pronto. Sem essa
conferência, três problemas passariam.

### 1. `svn diff` de árvore inteira trunca em silêncio quando existe um item `!`

O `svn diff` no `libTefCitel` saiu com **72 KB**. O patch do backup anterior tinha 428 KB. A
diferença não era conteúdo novo — era conteúdo **perdido**.

Causa: `svn diff` percorre em ordem alfabética e **aborta** ao encontrar
`Estacao/untTefEstacaoPipeTransporte.pas`, que está agendado para `add` mas ausente do disco
(status `!`):

```
svn: E720002: Can't open file '...untTefEstacaoPipeTransporte.pas'
```

Sai com código 1, escreve isso no stderr, e o **stdout fica cortado ali**. Como `untTefEstacao`**`P`**`ipe`
vem antes de `untTefEstacao`**`R`**`oteador`, o patch ficava sem as três units centrais do requisito:
`untTefEstacaoRoteadorMensagens.pas`, `untTefCitelDvc.pas` e `untTefCitelDvcTransporte.pas`.

Um patch truncado é pior que um patch ausente: ele *parece* completo. E o meu primeiro script
escrevia o stdout sem olhar o código de saída — exatamente o erro que a mensagem de erro estava
tentando evitar.

Gerado arquivo por arquivo, com verificação por arquivo, o patch vai para **459 KB** e a única
falha (o `!`) fica registrada em `diff-avisos.txt`. **Consequência para trás:** o
`diff-libTefCitel.patch` dos três backups anteriores provavelmente está truncado no mesmo ponto. A
cópia física em `arquivos\` deles está íntegra — ela é o artefato primário e não depende do
`svn diff` —, mas quem for reaplicar por patch precisa saber.

### 2. O `tasks.md` é invisível para o `svn status`

Ele estava fora do backup. Status **`I`** — ignorado, por uma propriedade **herdada do
repositório**: `svn:global-ignores = tasks.md` em `IA/specs`, que só aparece com
`svn propget --show-inherited-props`.

Isso significa que `svn status` **não lista o arquivo**, e portanto nenhum filtro por status
alcança ele. O backup de 09/09 o pegou por acidente: o script antigo copiava diretórios com status
`A` recursivamente, e o `tasks.md` veio de carona. Ao trocar por uma cópia dirigida pelo status —
que é o certo, e foi o que evitou repetir o acidente de 7,9 GB de 08/09 — o arquivo sumiu sem
aviso.

O ignore é **intencional**: alguém marcou a propriedade, e o `CLAUDE.md` descreve o `tasks.md` como
artefato de trabalho ("eu, durante a implementação"), não entregável de commit. Não há nada a
consertar na Fase 4 por causa dele. O que muda é a conclusão prática: **o `tasks.md` só existe na
máquina e nos backups.** É o arquivo que carrega o PONTO DE PARADA, com 322 KB de estado. Agora ele
entra no backup por nome, explicitamente.

### 3. Havia uma quinta working copy com modificação

A raiz tem **22 externals**. Os backups anteriores varriam quatro (raiz, `IA`, `libTefCitel`,
`libDominioSistemas`) — número que veio de olhar quais tinham mudança *naquele dia*, e virou
constante no script. Varrendo os 22, apareceu `libIntegracaoPixCitel` com `rev.inc` e `.stat`
modificados (carimbos de revisão do build, não trabalho meu, mas modificação não commitada
mesmo assim).

### O que a comparação disse no fim

Zero arquivos de fonte ou documentação do backup de 09/09 ficaram de fora deste. A diferença de
contagem (80 contra 168 arquivos) é quase toda `.dcu`/`.dll`/`.rsm` de `Win32\Debug` e
`Win64\Debug`, que o script antigo arrastava junto. E este tem dois que aquele não tinha:
`record.md` e `IA\rules\tef-dvc.md`, os dois com status `?`.

### A lição que fica no script

Três defeitos, e os três da mesma família: **confiar num resumo em vez do fato**. Confiar no
stdout sem olhar o código de saída; confiar no `svn status` como se ele listasse tudo; confiar num
número de working copies que alguém contou uma vez. A conferência contra o backup anterior foi o
que transformou os três de invisíveis em achados — vale repetir a cada backup, não só quando dá
tempo.

---

## 2026-09-10, 07:41–07:45 — O caminho perigoso passou, e a latência do ACK trocou de causa

### O caso 4, ponta a ponta

Cenário do Rafael: pendência no A, tentativa no B, **A encerrado pelo gerenciador de tarefas**,
volta no B. Veredito dele: *"esse fluxo ficou muito bom"*.

O log tem a cadeia inteira num intervalo de 17 milissegundos, às 07:44:00:

```
.869  conexao viva=False
.869  fProcessoAutcomVivo: pid=98392 ja TERMINOU (codigo de saida 99)
.869  NAO EXISTE MAIS - assumindo o pinpad sem perguntar ao operador (RN16)
.886  VEREDITO de disputa sobre o pid=98392 ...: morto=True, confirmadoPeloOperador=False
.886  TOMADA DO PINPAD concedida ao pid=3836
.886  pOrfanaSessao: ... Transacao pendente de confirmacao: True
.886  pOrfanaSessao: ATENCAO - o pid=98392 saiu com transacao passada e NAO confirmada
.886  o pid=3836 nunca executou o proprio fConfiguraTefCitel ... A impressao digital dele BATE
.886  REAPLICANDO a configuracao do pid=3836
.888  Despachando metodo "fPassarCartao" (id=7)
```

Isto é o caminho que eu tinha declarado explicitamente **não validado** ontem, e que eu chamei de
"o mais perigoso do requisito e o único protegido pela RN16". Ele passou — na variante que dispensa
a confirmação humana, que é justamente a que a RN16 libera.

**A retentativa automática funcionou pela primeira vez.** O id=6 voltou contestável, o AUTCOM
apurou e o id=7 saiu com o veredito, tudo dentro de **uma única ação do operador** — ele só viu a
tela do TEF abrir. É a casca `fChamaRpc` sobre `fChamaRpcUmaVez` fazendo exatamente o que foi
desenhada para fazer.

**E a LCKATC fechou o desenho.** O A morreu segurando a trava; quem barrou o B foi a trava do
projeto, com a mensagem do projeto (`AntesPassarCartao respondido em 6406 ms` — os 6,4 s são o
operador lendo o `fMensagem`). O Rafael removeu pelo procedimento que já existia e seguiu. As duas
camadas — guarda da estação e LCKATC — funcionaram cada uma no seu papel, e vale registrar: a
guarda da estação **não substitui** a trava, ela cobre o que a trava não alcança (empresas
diferentes).

Desfecho conferido no relatório do TEF: **A pendente, B confirmada.** Que é o contrato da RN09.

### A latência do ACK: minha hipótese estava errada, e a causa certa já estava documentada

Em 09/09 eu registrei que o ACK do `reata_resposta` demorava 4–6 s e levantei a hipótese de disputa
do `FcsEscrita` entre o `pEnviaReata` (que roda em thread própria) e a thread de leitura.

Esta bateria mostrou outra causa, e mostrou **duas vezes**, com os três logs alinhados:

| | primeira ocorrência | segunda |
|---|---|---|
| estação envia a resposta | 07:44:07.294 | 07:44:17.326 |
| leitura do AUTCOM **expira** | 07:44:07.317 (23 ms depois) | 07:44:17.343 (17 ms depois) |
| estação retransmite por falta de ACK | 07:44:09.295 | 07:44:19.349 |
| AUTCOM finalmente **lê** | 07:44:09.317 | 07:44:19.370 |

O quadro foi escrito no canal **dezenas de milissegundos antes** de o `WTSVirtualChannelRead`
expirar, e a expiração o **descartou**. Isso não é novidade: está escrito no comentário do
`TEF_DVC_TIMEOUT_LEITURA_MS`, em `untTefCitelDvcTransporte.pas`, desde 31/08 — *"um
WTSVirtualChannelRead que expira com erro ERROR_IO_INCOMPLETE parece descartar dados que estavam
prestes a chegar"*. Foi por isso que o timeout subiu de 2 s para 15 s.

Ou seja: **a mitigação já existe e está fazendo o trabalho dela.** A janela de colisão é de ~20 ms
em 15 000, a retransmissão cobre, e o custo é os 2 s de um ciclo de ACK. Não há o que consertar —
há o que **parar de investigar**. Substituí a hipótese do `FcsEscrita` no `tasks.md`; se alguém
tentasse "otimizar o lock" para resolver os 4–6 s, mexeria no lugar errado.

O que sobra como pergunta legítima é se 15 s é o melhor valor, e essa é uma pergunta de medição,
não de desenho.

### Uma incógnita que eu prefiro deixar marcada como incógnita

Às 07:44:00.886 a reaplicação chamou `fConfiguraTefCitel` nativo com `somenteCarregarLib=False` — e
é essa chamada que *"termina em `FechaSessaoTEF(SCO_CONFIRMA_TEF, forcado)`"*, que é a justificativa
inteira da RF17 item 4. A pendência do A estava aberta naquele instante.

**Pela teoria, esse confirm deveria ter resolvido a pendência do A.** O slot de pendência é único
por processo (specs.md 9.3), e foi exatamente esse mecanismo que produziu o bug de campo de
08/09, quando o login do B confirmou a transação do A.

Não aconteceu: o relatório mostra o A pendente e o B confirmado. Não sei por quê. Pode ser porque o
A já estava morto, pode ser a ordem em que as globais do `untScopeNCR` ficaram — e o nativo é
off-limites para investigar (specs.md 9.3).

Registro como **incógnita, não como garantia**. O desfecho observado é o desejado; o mecanismo não
está entendido; e quem ler isto depois não deve concluir que a reaplicação é inofensiva sobre uma
pendência viva. Se alguém precisar dessa garantia, ela ainda não existe.

### O que continua sem prova

Casos 2, 3 e 5 — os três que passam pela **pergunta ao operador**. O export
`pSetConfirmaTomadaPinpadTef` e o `VS_funcConfirmaTomadaPinpadTef` seguem com **zero execuções**.
Para exercitá-los é preciso um AUTCOM **travado**: processo vivo com a janela sem responder, o que
não é o mesmo que morto — e é o caso em que o `IsHungAppWindow` precisa dizer `True`.

### Estado

Passo 6 validado nos casos 1, 4 e 6. Restam os casos 2, 3 e 5, o Passo 7 (coleta de órfãs RF28 —
e a órfã do A está lá, `Restam 1 sessao(oes) ativa(s) e 1 orfa(s)` — mais a varredura RF29) e o
Passo 8 (fechamento).

---

## 2026-09-10 — O log como substituto do teste que não vai existir

### A pergunta certa

*"Referente ao autcom travado será muito difícil de simular, nesse ponto o log em produção será
muito importante para identificar bugs nesse cenário e futuras correções, o log que temos hoje será
suficiente?"*

É a pergunta certa, e ela reconhece uma coisa desconfortável: **três dos oito casos do roteiro não
vão ser validados antes de entrar em produção.** Quando o teste não vai existir, o log deixa de ser
diagnóstico e passa a ser o instrumento de validação. Aí ele precisa de um padrão mais alto.

Auditei os dois logs no código em vez de responder de memória. A resposta era não, por três
lacunas — e as três só apareceriam em produção, no pior momento possível.

### Lacuna 1: a linha não tem dono

`%TEMP%` é por usuário/sessão, e os dois `autcom.exe` da mesma sessão TS gravam no **mesmo**
`TefCitelDvcTransporte.log`. A evidência estava no log que o Rafael tinha acabado de mandar:

```
07:43:05  [seq=269 tid=78272]   ...
07:43:30  [seq=1   tid=28480]   ...   ← outro processo, contador reiniciando
07:43:33  [seq=271 tid=130636]  ...
```

Duas sequências intercaladas. Para atribuir uma linha, só agrupando `tid` na mão. E o cenário que
mais precisa deste log — a disputa do pinpad — é **por definição** sobre dois AUTCOM ao mesmo
tempo.

Junto com o pid, corrigi um comentário que estava mentindo: ele afirmava que o `seq=` narra "a
ordem real em que as chamadas entraram nesta função, mesmo vindas de threads diferentes". Isso vale
**dentro de um processo** — o contador é global de unit, protegido pelo `FcsLog` daquele processo.
Entre processos, a única ordenação é o carimbo de tempo. Comentário que promete mais do que entrega
custa tempo de quem lê depois.

### Lacuna 2: uma linha que existe para quando não vem a próxima

Entre `IsHungAppWindow=True` e a resposta do operador não havia nada. Se o operador saísse de
perto, ou se o `fMensagem` ficasse preso atrás de outro modal — **o falso positivo exato pelo qual
a RN16 existe** — o log mostraria `travado` e depois silêncio.

A linha nova é de um tipo incomum: ela existe para o caso em que **não vem nenhuma linha depois
dela**, e por isso carrega no próprio texto as duas explicações possíveis. Quem for ler o log em
produção não vai ter ninguém para perguntar.

### Lacuna 3: o modo de falha silencioso da abordagem

`fJanelaPrincipalTravada` registrava o handle e o resultado. Se o `EnumWindows` pegasse a janela
errada, o log ficaria **idêntico** ao caso correto — e é o único modo de falha que o laboratório
não descarta, porque lá ele acertou (`janela 0x330B7E`, `0x1A0A52`).

Agora a varredura **conta todas** as candidatas em vez de parar na primeira, e o log traz título,
classe e a contagem, com um aviso explícito quando há mais de uma. Uma escolha errada passa a ser
visível sem reproduzir nada.

### O que eu não fiz, e por quê

Nenhum dos dois logs tem rotação, limite de tamanho ou chave de desligar. O do AUTCOM registra por
quadro: ~100 linhas por transação de cartão, da ordem de 3 MB/dia numa estação movimentada, sem
nada que apare — e em `%TEMP%`, que a Limpeza de Disco pode varrer justamente quando a evidência
importa. O log do plugin tem a mesma falta de identificação, com um arquivo só para os dois canais
DVC da sessão.

Isso é endurecimento para produção, mexe em três binários e pede revalidação. O Rafael escolheu
manter o escopo nas três lacunas do travado e mandar o resto para o Passo 8 (RF22, "log
consolidado") — o que está certo: são problemas de natureza diferente, e misturá-los agora
atrasaria o que já está validado.

### A lição

Quando um caso de teste é declarado inviável, isso não é o fim da conversa — é o começo de outra:
**o que o log precisa ter para que a produção faça o papel do teste?** Vale como pergunta padrão
para os próximos resíduos deste requisito, e há dois esperando (a incógnita do
`FechaSessaoTEF` sobre pendência viva, e a coleta de órfãs da RF28).

---

## 2026-09-10, 08:36–08:44 — A regressão que protegia os Passos 0 a 5, e uma explicação que ficou pela metade

### O teste que eu pedi, e o teste que aconteceu

Pedi a regressão de um AUTCOM só com uma oscilação de TS durante o `fPassarCartao`, porque o Passo
6 mexeu em três pontos do caminho de um AUTCOM sozinho (single-flight, `pGarantePinpadConfigurado`,
`fChamaRpc`) e era o que protegia o que já estava validado.

O que o Rafael rodou foi bem mais: **duas** quedas de TS, aborto em voo, fila local persistindo e
drenando, `reata` com round-trip de identidade, e a pendência confirmada no fim. Todos os Passos 0
a 5 num único log de cinco minutos, com o código do Passo 6 no lugar. Nada regrediu.

O detalhe que eu gostei: às 08:39:32.954 apareceu `quadro ATRASADO aceito (messageId=27, maior
aceito=28) - primeira entrega perdida no canal, recuperado pela retransmissao do emissor`. É a
aceitação de quadro fora de ordem, da correção de 04/09, sendo exercitada — e agora o log diz o que
aconteceu em vez de deixar deduzir.

### O single-flight, nos dois sentidos

Isso eu não tinha pedido e vale mais que o pedido: 08:42:53 o B tenta com o A em voo, 08:43:24 o A
tenta com o B em voo. Mesma sequência nos dois, e a nova:

```
chegou com o pid=N EM VOO no pinpad - seguindo para a guarda de posse (RF17 item 1),
que responde como negativa em vez de erro. Nada foi reservado nem despachado.
```

E o lado AUTCOM fecha o argumento: `pTrataEvento: status="500"` → `pNotifica ... para 1
observer(es)` → `pTrataResposta: id=3 encontrado`. A chamada RPC **voltou normalmente, sem
exceção**. Sem exceção não existe caminho para o madExcept — o que era o ponto do conserto.

### A explicação de ontem estava incompleta, e o log de hoje mostra onde

Ontem eu troquei a hipótese do `FcsEscrita` pela colisão com a expiração do
`WTSVirtualChannelRead`, e disse que a causa estava "documentada e já mitigada". A primeira metade
continua certa — hoje de novo: `reata_resposta` escrito 08:40:18.322, leitura expirando
08:40:18.336, **14 ms depois**, quadro descartado.

A segunda metade não fecha. A cópia retransmitida às 08:40:20.328 levou **3 s** para aparecer numa
leitura que já estava em curso, e o quadro só foi lido às 08:40:23.387 — depois de duas
retransmissões. A colisão explica a perda do primeiro quadro; **não explica os 3 s da segunda.**
Há latência de entrega no canal DVC que não vem do nosso código.

Corrigi o registro: a colisão é uma causa, não *a* causa. E a consequência prática é a que
interessa — o orçamento de retransmissão é 5 tentativas × 2 s ≈ 10 s, e hoje foram consumidos 5 s.
**Margem de 2×, mais estreita do que eu supunha ao dizer que "a retransmissão cobre".** Medir antes
de mexer, e medir antes de confiar.

### Uma latência de 10 s que ninguém vê, e que ainda assim é real

Cronologia da primeira queda:

| Hora | O quê |
|---|---|
| 08:38:27.262 | `WTSVirtualChannelRead falhou com erro 233` — canal morto, detectado |
| 08:38:43.685 | **a sessão RDP já voltou** |
| 08:38:44.131 | `pNotificaCanalCaiu` — 17 s depois da detecção |
| 08:38:53.441 | primeira tentativa de reconexão — **26 s** depois da queda |
| 08:38:55.457 | canal reaberto |

O `pNotificaDesconexao` é chamado na hora, na thread de leitura (linha 903 de
`untTefCitelDvcTransporte.pas`), e a reconexão vem imediatamente depois, na mesma thread. Então os
26 s estão *dentro* de um dos dois. A primeira tentativa aconteceu **10 s depois de a sessão já
estar de volta** — a reconexão poderia ter sido 10 s mais cedo.

Hipótese mais provável: a thread principal e/ou o `WTSVirtualChannelClose` bloqueando enquanto a
sessão TS está desconectada. **Não medi, e por isso não afirmo.** É invisível ao operador — a
sessão está fora do ar nessa janela — mas são 10 s de indisponibilidade a mais no pilar do
requisito, e vale um olhar no Passo 8.

### O padrão, de novo

Ontem: "a mitigação já existe, não há o que consertar". Hoje: a mitigação existe, cobre, e a margem
é 2×. As duas frases são verdadeiras, e a segunda é a útil. **Declarar um assunto encerrado é uma
afirmação que também precisa de evidência** — e a evidência de que "está coberto" não é a mesma
coisa que a evidência de "está coberto com folga".

### Estado

Passo 6 com os casos 1, 2, 4, 6 e 7 validados em campo. Falta o caso 8 (`CFG_TEFDVC = N`) e o
rebuild do `autcom.exe` pela blindagem do import. Os casos 2, 3 e 5 do roteiro (pergunta ao
operador) seguem por decisão fora de simulação, com o log reforçado para a produção.

---

## 2026-09-10 — Passo 6 encerrado

O caso 8 (`CFG_TEFDVC = N`) passou — *"fiz o teste e funcionou normalmente"* — e o rebuild ficou
confirmado por timestamp, não por lembrança: `untTefCitelUtil.pas` (a blindagem do import) é de
**08:27:41** e o `autcom.exe` é de **08:35:53**. Posterior, logo o `.exe` que rodou a bateria das
08:36 tem a blindagem dentro. A `libTefCitel.dll` é de 08:31:47, e o log daquela bateria já traz o
prefixo `pid=` novo — evidência independente da mesma coisa, vinda do próprio artefato que eu queria
validar.

O caso 8 era o menos glamouroso do roteiro e ganhou importância na última hora, por um motivo que
não estava no plano: a blindagem do import roda **incondicionalmente**, inclusive quando o
`CFG_TEFDVC` está desligado. Uma regressão de cortesia virou o único teste de código novo naquele
caminho.

### O que o Passo 6 entregou

O ponto de partida era um resíduo do Passo 5. A RF24 fez a sessão sobreviver à queda da conexão —
que é o que faz a transação atravessar a oscilação de TS, e é o pilar do requisito — mas o preço foi
que um AUTCOM travado, ou um cuja conexão nunca volta, passou a segurar o pinpad para sempre.

O desfecho passou a depender do estado do detentor:

| Detentor | Desfecho | Validado |
|---|---|---|
| Processo morto | Tomada automática, sem perguntar nada | Sim — 07:44 |
| Vivo e respondendo | Recusa **sem incomodar o operador** | Sim — 07:25 e 08:43 |
| Vivo e travado | Pergunta ao operador | **Não** — vai vir da produção |

E três defeitos apareceram no caminho, dois deles pré-existentes: o single-flight de
`pTrataChamada` sombreando a RF17 item 1 (e por isso entregando o madExcept em vez de um
`fMensagem`), o login adiado nunca aplicado quando as duas instâncias tinham o mesmo terminal (o
erro 64004), e o acoplamento de versão que **eu mesmo criei** ao adicionar um export novo chamado
antes do `fCriarTefCitel`.

Os dois defeitos de 09/09 tinham a mesma raiz, e vale guardar a formulação: **tratar um fato de
instância como fato de processo.** A impressão digital da configuração responde "a DLL está
configurada assim?", que é do processo; o login também constrói estado dentro do `ITefCitel`
daquela sessão, que é da instância. Confundir os dois produziu o 64004.

### O que eu erraria de novo se não anotasse

**A sonda por hook.** Projetada, implementada, testada e descartada no mesmo dia, depois de o
Rafael dizer *"achei errado, pois o autcom A estava vivo só aguardando eu desfazer/confirmar"*. Ele
estava certo, e o problema não era calibragem — era estrutural. Eu validei a propriedade no estado
errado: provei que um AUTCOM saudável responde ao hook *dentro* de um `fPassarCartao`, quando o
único detentor que chega à disputa é o que está parado esperando o operador, **fora** de qualquer
chamada, e portanto sem drenar `TThread.Queue`. Em todos os logs do requisito, **todo hook já
respondido foi respondido de dentro do laço de bombeamento do `fChamaRpc`** — não existe um único
caso de hook respondido com o AUTCOM ocioso. A pergunta que faltou fazer era simples: *em que
estado está o detentor quando esta função roda?*

**Duas declarações de encerramento apressadas.** "A mitigação já existe, não há o que consertar"
virou, no dia seguinte, "a mitigação cobre, e a margem é 2×". As duas frases são verdadeiras; a
segunda é a útil. Declarar um assunto fechado é uma afirmação que precisa de evidência igual a
qualquer outra.

**Confiar em resumo em vez de fato**, três vezes no mesmo backup: usar o stdout do `svn diff` sem
olhar o código de saída (e perder o roteiro e duas units inteiras do patch), tratar `svn status`
como se listasse tudo (e perder o `tasks.md`, que é `I` por propriedade herdada), e aceitar um
número de working copies que alguém contou uma vez (eram cinco, não quatro).

### O que fica em aberto, dito como aberto

A reaplicação do login chama `FechaSessaoTEF(SCO_CONFIRMA_TEF, forçado)` e, pela teoria da própria
RF17 item 4, deveria ter resolvido a pendência do detentor morto. **Não resolveu** — ela ficou
pendente no relatório, que por acaso é o desfecho desejado. Não entendi o mecanismo, o código
nativo está fora de alcance, e por isso isto está registrado como incógnita e não como garantia.

### Estado

Passos 0 a 6 da Fase 5 encerrados e validados em campo. Restam o **Passo 7** (coleta de órfãs RF28
+ varredura de subida RF29 — o resíduo já aparece crescendo no log, `2 sessao(oes)` → `3
sessao(oes)`) e o **Passo 8** (fechamento: log consolidado com rotação, limite e chave de desligar;
seção na `IA\rules\tef-dvc.md`; `analysis.md`). Depois a Fase 4, que começa pelo `svn revert` do
`untTefEstacaoPipeTransporte.pas`.

---

## 2026-09-10 — Passo 7, e um receio do Rafael que refez o desenho

### A frase que mudou o passo

*"Meu maior receio é a coleta perder os ponteiros da DLL das instâncias ativas, precisamos garantir
que isso não acontece; ao meu ver o simples desalocar memória dos órfãos deve resolver."*

O receio estava certo — é o mecanismo exato do Access violation em 00000000 de 09/09. A solução
proposta não era alcançável, e descobrir **por que** foi o trabalho útil do dia:

| Caminho | Onde morre |
|---|---|
| Não disparar o `UnLoadDLLFunctions` | Está dentro de `TTefCitelNCR.Destroy`, guardado por `FblnDllCarregada` — privado, sem setter, unit intocável |
| Repovoar do roteador | Os globais moram na `libTefCitel.dll`; o roteador está no `.exe`. Um `uses untScopeNCR` daria uma **segunda cópia** e repovoaria a errada |
| Export novo na DLL | Repetiria o acoplamento de versão que eu criei no Passo 6 |

**A saída veio da ordem, não de uma restauração avulsa.** `fConfiguraTefCitel` chama
`fLoadDLLFunctions` incondicionalmente, antes de tocar em qualquer sessão. Colando a coleta
imediatamente antes dele, os ponteiros ficam nulos só dentro de um trecho onde nenhuma outra thread
de despacho existe — e saem povoados na linha seguinte. O que a spec pedia ("coleta no caminho do
login") virou algo mais estreito e mais defensável: "coleta colada na reconfiguração".

### O achado que valeu mais que a implementação

**A RF28, como estava escrita, seria um no-op.** Ela dizia para tirar a condição
`FdictSessoes.Count = 0`. Mas a guarda que sobrava é `FdictSessaoPorThread.Count > 0 → Exit`, e o
`pAtualizaContexto` **registra a própria thread de despacho nesse dicionário** antes de o método
rodar. A thread do login que chamasse a coleta se veria como ocupada e sairia sem coletar nada.

Tirar uma condição não bastava; a outra precisava passar a ignorar a própria thread. Isso só
apareceu porque fui ler o registro da thread em vez de confiar no texto da spec — e é o terceiro
passo seguido em que o texto do requisito estava certo na intenção e errado no mecanismo.

### Quatro premissas conferidas em vez de assumidas

Cinco já caíram neste requisito, então virou hábito:

1. **`UnLoadDLLFunctions` não fecha a sessão Scope.** Só anula ~25 ponteiros — nada de
   `FechaSessaoTEF`, nada de `ScopeClose`. Era a preocupação maior (a vaga única de pendência) e
   caiu.
2. **`NcrFunctionDetect` só age se o ponteiro estiver nulo.** Logo `fLoadDLLFunctions` é idempotente
   e custa zero quando já está povoado.
3. **`FunctionDetect` faz `LoadLibrary` sem `FreeLibrary`** — ~50 no refcount do módulo por
   repovoamento, para sempre. Pré-existente, e é o motivo de o módulo nunca descarregar. Anotado
   para não ser "descoberto" como vazamento depois.
4. **Ordem de locks.** Os seis `FcsThreads.Enter` da unit são blocos curtos que liberam sem tomar
   outro lock, então a ordem nova `FcsPinpad → FcsThreads` não fecha ciclo. Verifiquei antes de
   escrever, e não depois de o campo travar.

### Uma frase da minha própria spec que me custou tempo

`specs.md` §10.5: *"Some a varredura de subida do serviço (RF29)"*. Em português isso lê como
*sumir* ou *somar* — e decide metade do passo. Resolvi por evidência (o texto da RF29 e o
`plans.md` §9.5 mandam implementar), mas o custo foi real e o próximo leitor pagaria igual.
**Ambiguidade que muda escopo não é questão de estilo.**

### RF29: metade da regra já era letra morta

A RF29 dizia *"falha a chamada pendente com esse motivo, refaz o TEF por inteiro e direciona ao
relatório"*. A primeira parte morreu quando a RF25 parte 2 saiu de escopo em 09/09: sem a espera
pela reconexão, as chamadas pendentes já estouraram com `ErroCanal` muito antes de o `reata`
chegar. O comentário do Passo 3 no código **já dizia isso** — eu tinha escrito e não tinha ligado
os pontos ao ler a RF29 de novo.

Implementei o que sobrou, e mudei o momento: o re-login acontece na **próxima chamada**, não no
`reata`. O `reata` chega na reconexão, quando pode não haver operador em tela nem observer
registrado — o aviso iria para `0 observer(es)` e se perderia. Na próxima chamada existe operação
em curso, logo existe quem leia.

Para isso o `TTefCitelDvc` passou a guardar os argumentos do próprio login. Foi a escolha que
evitou um **segundo** export novo na DLL — e essa é a lição do Passo 6 sendo aplicada de fato, não
só registrada.

### Um bug meu, achado na minha própria revisão

`FblnRelogando := False` estava **fora** do `finally`. Uma exceção escapando do `except` — do
próprio `pLogaDiagnosticoDvc`, por exemplo — deixaria a flag presa em `True` e **desligaria o
re-login para o resto da vida do processo**. Silencioso, e só apareceria como "às vezes o TEF não
se refaz". Segundo passo seguido em que a revisão do próprio código achou algo que o compilador não
acha (o primeiro foi o deadlock do Passo 3).

### Estado

Passo 7 implementado, compilando limpo nos três projetos, **sem nenhuma validação de campo**. O
caso de maior risco é a regressão de um AUTCOM só: o `pRefazTefSeServicoReiniciou` roda no topo de
**toda** chamada RPC. Roteiro de 7 casos no `tasks.md`.

Falta o Passo 8 (fechamento) e a Fase 4.

---

## 2026-09-10, 10:09–10:13 — o mesmo erro, duas vezes no mesmo método

### A coleta não rodou, e a causa era a terceira guarda

Primeira bateria do Passo 7. Conferi os binários antes de analisar qualquer coisa:
`TefEstacaoService.exe` de 09:54:54, posterior às edições de 09:41–09:47, bateria às 10:09 — o
código novo estava rodando. Ainda assim, **nenhuma linha de coleta no log**, e o resíduo ficou
visível no fim: `Restam 1 sessao(oes) ativa(s) e 1 orfa(s)`.

`fPassarCartao` é método de transação, então o `pTrataChamada` reserva
`FblnTransacaoEmAndamento := True` na linha 1918 e só chama `pGarantePinpadConfigurado` na 2052.
Minha coleta abre com `if FblnTransacaoEmAndamento then Exit` — saía na primeira linha, com zero, e
por isso não logava nada.

### O padrão, que importa mais que o conserto

`fColetaOrfas` tem três guardas, e eu errei a mesma coisa em duas delas com um dia de diferença:

| Guarda | O que quer dizer | O que media |
|---|---|---|
| Threads de despacho | "outro está em código nativo" | "existe alguma thread" — inclusive a minha |
| Transação em voo | "outro está em código nativo" | "existe reserva" — inclusive a minha |
| Contagem de sessões | "não há instância viva" | correto, e por isso ficou só no caminho antigo |

A primeira eu achei lendo o código antes de escrever, e me achei cuidadoso por isso. A segunda
passou, e o campo cobrou.

**A lição não é "olhar as guardas".** É que mover uma chamada para um contexto novo invalida
**toda** premissa de quem ela chama, não só a que eu lembrei de conferir. A coleta nasceu para rodar
de um caminho ocioso (`pOnDesconectado`); reusei-a de dentro de uma chamada ativa e conferi uma das
três condições. Quando o contexto muda, a pergunta certa é *"quais premissas esta função tinha?"* —
todas, listadas —, não *"esta condição ainda vale?"*.

### O roteiro que eu escrevi apontava para o lugar errado

Pior que o defeito. O caso 1 do roteiro pedia a linha de coleta **no login**, e isso nunca poderia
acontecer naquele cenário. Dois motivos, os dois visíveis no log e nenhum deles traçado por mim
antes de escrever o roteiro:

1. Quando o A é morto, a sessão dele fica `DESANEXADA, nao orfanada (RF24)` — **não existe órfã no
   login**. Ela nasce às 10:12:31, na tomada.
2. O login do B foi **ADIADO** pela RF17 item 4, e o ramo adiado não coleta, por desenho meu.

Escrevi um roteiro cujo caso principal era impossível. Se o Rafael tivesse concluído "não coletou,
então está quebrado" pelo motivo errado, a culpa seria minha; se tivesse concluído "passou" por ver
outra linha, pior ainda. **Roteiro de teste também tem que ser derivado do fluxo real, não da
intenção da regra.**

### O que a bateria provou de positivo

Todo o Passo 6 continua de pé com o código do Passo 7 no lugar: tomada automática com processo morto
(`codigo de saida 99`), orfanamento sem tocar o processo, reaplicação do login adiado com as duas
impressões digitais idênticas, venda do B concluída (`Controle 09005753016`) e `fFinalizarTransacao`
com sucesso. Isso é resultado de regressão, e é o que protege os Passos 0 a 6.

### Uma observação que conferi antes de chamar de defeito

Às 10:12:46 o `pInfo21` chegou carregando o veredito de disputa outra vez, apesar de o veredito ser
"de uso único". O `pLimpaVereditoDisputa` roda no `finally` do `fChamaRpc` **externo**, e o
`pInfo21` acontece com o `fPassarCartao` ainda em voo.

Fui ler o `fTomadaAutorizada` antes de concluir qualquer coisa: ele **casa o par (pid,
inicioProcesso)** com o detentor atual e ignora veredito que não bate, e "morto" só vale com a
conexão do detentor caída. Então o vazamento é **inerte** — não autoriza tomada contra outro
detentor. Fica como comentário a ajustar no Passo 8, não como bug: "uso único" na verdade é "limpo
no fim da chamada externa".

### O que ficou sem verificar

A varredura de subida (RF29) não pôde ser conferida: o log entregue começa às 10:09:46, no meio de
uma transação, e as linhas de subida do serviço ficaram fora. Precisa do começo do arquivo ou de um
restart do serviço com item na fila.

---

## 2026-09-10, 10:25–10:31 — a garantia por ordem, medida em 2 ms

O conserto da guarda de transação em voo funcionou, e a coleta apareceu onde o roteiro corrigido
dizia: entre o `REAPLICANDO` e o `reaplicacao ... concluida`, às 10:30:44.301, liberando 1 órfã.

**Mas o que me interessa registrar não é essa linha.** O receio do Rafael era *"a coleta perder os
ponteiros da DLL das instâncias ativas"*, e a linha da coleta não prova nada sobre isso — ela só diz
que a órfã morreu. A prova está no que veio **depois**: `Aproxime, Insira ou Passe o Cartao`,
`SELECIONADO: MASTERCARD`, um `pInfo21` (chamada nativa), `Controle 09005953012`,
`Transacao completa`, o `fPassarCartao` retornando com sucesso e o `fFinalizarTransacao` OK.

Dezenas de chamadas nativas, com os ponteiros repovoados **2 ms** depois de serem anulados. A
garantia por ordem — coleta colada no `fConfiguraTefCitel`, que chama `fLoadDLLFunctions`
incondicionalmente — entregou o que prometia, e agora tem evidência em vez de argumento.

### O acúmulo terminou, e isso é verificável

| Momento | Estado |
|---|---|
| 10:27:13 | 1 sessão ativa |
| 10:29:39 | 2 sessões ativas |
| 10:30:44 | 1 ativa + **1 órfã** |
| 10:30:44 | coleta: 1 órfã liberada |
| 10:31:37 | 1 sessão, **zero órfãs** |

A bateria anterior terminava com `1 ativa e 1 orfa`. Era esse resíduo — `2 sessao(oes)` →
`3 sessao(oes)` no log de 09/09 — que motivou a RF28.

### Uma distinção que quase deixei passar

A varredura de subida (RF29) **rodou**: `pVarreFilaNaSubida: fila local vazia na subida do servico
(instancia "{1BD16EEF-...}")`. É tentador marcar a RF29 como validada e seguir. Mas o que foi
exercitado é o caminho da **fila vazia** — o `fDescartaTudo`, que é a parte que de fato pode dar
errado (arquivo em uso, permissão, contagem), **não rodou nenhuma vez**.

"A função foi chamada" e "o comportamento foi validado" são afirmações diferentes, e confundi-las é
o mesmo erro que declarei duas vezes nos últimos dias em outra forma. Ficou registrado como
**parcial**, com o caso do descarte separado no roteiro.

### Um sinal de regressão fraco, mas que vale nomear

O `pRefazTefSeServicoReiniciou` roda no topo de **toda** chamada RPC — é o ponto de maior risco do
Passo 7. Nesta bateria ele saiu na primeira linha em todas as ~16 chamadas de cada AUTCOM, porque
nenhuma troca de instância foi detectada (cada AUTCOM conectou **depois** do restart, e na primeira
resposta de `reata` a instância conhecida ainda está vazia).

Isso valida o caminho de no-op, não o caminho útil: o re-login segue com **zero execuções**. Dito
assim para não virar "o Passo 7 está validado" na leitura de quem chegar depois.

---

## 2026-09-10, 10:45–10:48 — a regressão passou, e o log corrigiu duas coisas que eu tinha afirmado

O caso que mais me preocupava no Passo 7 passou: um AUTCOM só, duas quedas de TS (uma ociosa, uma
com transação em voo), aborto pelo `pSair`, fila local persistida e drenada, `reata` nas duas,
`Controle 09005063010` e `fFinalizarTransacao` OK.

### O que valida o Passo 7 aqui é um NÃO-evento

O `pRefazTefSeServicoReiniciou` roda no topo de **toda** chamada RPC — era o ponto de maior risco da
alteração. Ele rodou ~10 vezes e **não fez nada em nenhuma**, o que é exatamente o certo:

- 1ª `reata`: instância conhecida `""` → não dispara, porque a condição exige **as duas** não-vazias.
  Sem esse detalhe, **toda primeira reconexão** dispararia um re-login e jogaria um aviso na cara do
  operador sem motivo.
- 2ª `reata`: instância **igual** → não dispara.

Vale nomear: a evidência que mais importava nesta bateria é a **ausência** de duas linhas. Um
roteiro que só procura linhas presentes não pega esse tipo de erro — e o falso positivo aqui seria
pior que o defeito que a regra conserta, porque atingiria todo mundo em toda oscilação de TS.

### Correção 1: não é "latência do canal", é a leitura que fica retida

Em 09/09 eu escrevi que *"há latência de entrega no canal DVC que não vem do nosso código"*. Os
números de hoje dizem outra coisa:

| | Reconexão 1 | Reconexão 2 |
|---|---|---|
| Estação escreve a resposta | 10:46:00.930 | 10:47:28.931 |
| Leitura do AUTCOM expira (15 s) | 10:46:00.960 | 10:47:28.946 |
| Retransmissões consumidas | 3 de 5 | 3 de 5 |
| AUTCOM lê | 10:46:07.464 | 10:47:35.546 |
| Atraso | **6,5 s** | **6,6 s** |

O que muda a conclusão: as **três cópias chegaram em 2 ms uma da outra** (dois `quadro duplicado
descartado` seguidos, nas duas reconexões). Latência por quadro as entregaria espaçadas de 2 s.
Chegando juntas, elas ficaram **retidas e foram liberadas em rajada** — o problema é a leitura não
retornar, não a entrega demorar.

A perda do primeiro quadro continua explicada (colisão com a expiração da leitura, 30 ms depois da
escrita). **O atraso das retransmissões segue sem explicação**, e agora sei que a explicação que eu
tinha dado estava no lugar errado.

### Correção 2: a margem é 1,5×, não 2×

Registrei 2× em 09/09 a partir de **uma** amostra de 5 s. Hoje foram 6,5 s **duas vezes, com
assinatura idêntica** — e o orçamento é 5 × 2 s ≈ 10 s. É a segunda vez neste requisito que uma
margem que eu declarei confortável encolheu ao ser medida de novo. A diferença entre 2× e 1,5× não
é grande; o hábito de derivar margem de uma amostra é.

### Um número que ninguém tinha: 47–53 s para reatar

Da queda de TS até o `reata` completo: 47 s na primeira, 53 s na segunda. Decomposto em ~26–32 s
para reabrir o canal, ~14,5 s até o `reata` sair e ~6,5 s do atraso acima.

Os ~14,5 s apareceram **iguais nas duas vezes**, e são suspeitosamente próximos do timeout de
leitura de 15 s — o que sugere que o `reata` espera o ciclo da thread de leitura. **Hipótese, não
medida.** Anotada porque, somada aos ~10 s já vistos em 08:38, é o tipo de coisa que some no meio de
um log e não some numa reclamação de operador.

### Um resíduo que a RF28 não resolve, com a severidade conferida

`2 sessao(oes) no dicionario` do começo ao fim da bateria, com **um** AUTCOM ativo. A sobra é do
pid=94948 da bateria anterior, que fechou normalmente.

Sessão de AUTCOM que fecha normalmente **nunca** sai do `FdictSessoes`: a RF24 a deixa `DESANEXADA`
esperando o processo voltar, e a RF28 coleta **órfãs**, não desanexadas.

Antes de chamar isso de vazamento, fui ler o `fGaranteSessao`: ele **valida o par (pid,
inicioProcesso)** e orfana a sessão velha quando o Windows recicla o número (RF23) — e daí a RF28 a
coleta. Então não há risco de o AUTCOM novo herdar loja/terminal do velho, e o crescimento é
limitado pela reciclagem de PID. **Crescimento de memória não limitado no pior caso, não defeito de
correção.** Decisão para o Passo 8.

Registro isso do jeito que registro porque a tentação era escrever "achei um vazamento de sessões" —
que soa melhor e é impreciso nos dois sentidos que importam.

---

## 2026-09-10, 14:53–15:00 — RF29 fechada, e uma margem que encolheu pela terceira vez

Os dois casos que faltavam passaram, pelo roteiro combinado. O descarte da fila na subida
(`1 item(ns) ... 1 descartado(s)`) e o re-login por troca de instância, com a venda concluindo
depois (`Controle 09005273015`).

Duas coisas me agradaram por serem confirmação de aposta, não de sorte:

- **Os argumentos do login guardados no `TTefCitelDvc` funcionaram** — foi a escolha que evitou um
  **segundo** export novo na DLL, aplicando a lição do Passo 6 em vez de só a registrar.
- **O one-shot do `InterlockedExchange` funcionou**: houve dois `pRetornaLog` seguidos e o re-login
  aconteceu **uma vez**.

E a fila mostrou os **dois** destinos na mesma bateria, em sequência: o item da 1ª queda foi
entregue na reconexão e descartado pelo AUTCOM como resposta atrasada; o da 2ª foi descartado na
subida, porque o serviço reiniciou antes de a sessão voltar. É a RF21 e a RF29 se encontrando, e
cada uma fez a sua parte.

### A terceira medição da mesma margem, e as três discordam

| Quando | Amostras | Atraso | Retransmissões | Margem |
|---|---|---|---|---|
| 09/09 | 1 | 5 s | — | 2× |
| 10/09 manhã | 2 | 6,5 s | 3 de 5 | 1,5× |
| **10/09 tarde** | **3** | **9,0 / 9,1 / 9,7 s** | **4 de 5** | **1,03×** |

O orçamento é 5 × 2 s ≈ 10 s. Na pior das três de hoje à tarde, a mitigação cobriu por **300 ms**.

**O erro não é nenhum dos três números — é o método.** Três vezes eu escrevi "margem medida em N×"
a partir de uma, duas e três amostras, e três vezes a medição seguinte foi pior. Uma margem derivada
de poucas amostras de um fenômeno cuja causa eu **não** conheço não é uma medida, é uma
extrapolação. O jeito honesto de escrever era "observado até N×, causa desconhecida, amostra
pequena" — e isso teria mudado a prioridade do item duas rodadas antes.

Reclassifiquei de observação para **risco**. Consequência prática de esgotar as 5 tentativas: não é
queda (desde 31/08 esgotar ACK loga alto e segue como melhor esforço) e o quadro chega de qualquer
jeito, porque as cópias sempre surgem juntas. Mas o log passaria a acusar entrega não confirmada em
**toda** reconexão, e aí a linha para de distinguir o normal do anormal — que é o pior efeito
possível num log que é o instrumento de validação dos casos que não vamos simular.

### O acúmulo de sessões saiu de hipótese para 11

`Instancia ITefCitel real criada para o pid=68800 (11 sessao(oes) ativa(s))`. Onze sessões vivas de
AUTCOM que fecharam ao longo do dia, cada uma segurando uma `ITefCitel` e a instância nativa.

Depois do reinício do serviço: `1 sessao(oes)`. **Hoje, o que limpa isso é reiniciar o serviço.**

Ontem eu descrevi isso como "crescimento de memória não limitado no pior caso" e resisti a chamar de
vazamento, porque o `fGaranteSessao` valida o par (pid, inicioProcesso) e não há risco de correção.
Mantenho a classificação — mas com 11 medidos em meio dia de testes, o "pior caso" deixou de ser
teórico. Vale dizer as duas coisas juntas: **não é bug, e precisa ser resolvido.**

### Estado do Passo 7

Cinco dos sete casos validados, incluindo os dois de maior risco (regressão de um AUTCOM só e
re-login por troca de instância). Faltam a coleta no login com órfã pré-existente e o
`CFG_TEFDVC = N`, os dois de baixo risco.

---

## Sessão de 2026-09-10, tarde — Passo 8 da Fase 5 implementado

**Entrada:** o handoff que a sessão da manhã deixou no `PONTO DE PARADA`, com uma agenda de seis
itens priorizada. **Saída:** cinco deles implementados e compilando, nenhum validado em campo.

### As três decisões que mudaram o rumo, e por que foram levadas ao Rafael

Os itens 1, 2 e 3 estavam registrados no handoff como *decisão pendente* — não por falta de
opção técnica, mas porque cada um tinha mais de uma saída razoável com custos diferentes. Foram
perguntados antes de escrever qualquer linha.

**Item 1 — margem do ACK.** As opções eram instrumentar, aumentar o orçamento, fazer os dois, ou
só corrigir o texto da spec. Escolha: **instrumentar antes de mexer**. O argumento que pesou está
no próprio histórico do requisito — essa margem foi declarada errada três vezes (2× → 1,5× →
1,03×), sempre por generalizar amostra pequena, e escolher um número novo sem causa seria a
quarta.

**Item 2 — acúmulo de sessões.** As opções eram coletar desanexada por idade, encerrar a sessão
no fechamento limpo, ou só logar. Escolha: **coletar por idade**, preservando o propósito da
RF24.

**Item 3 — lacuna da RF29.** As opções eram mover o gatilho para a chamada normal, o plugin
fechar o canal DVC ao reconectar o socket, ou não mexer. Escolha: **gatilho na chamada normal** —
a segunda opção custaria os 47–53 s de reatamento a cada reinício de serviço.

E uma quarta, do item 4: **a chave do log mora num `.ini` ao lado de cada binário, criado com os
defaults se não existir.** O "criar se não existir" foi acréscimo do Rafael à opção proposta, e
mudou o desenho para melhor: o suporte encontra o arquivo pronto, com um comentário por chave,
em vez de precisar saber inventar o nome.

### A ordem de implementação não foi a ordem da agenda, e havia motivo

A agenda priorizava o item 1 (o risco). Comecei pelo **item 4**, e a razão é estrutural: a
instrumentação do item 1 precisa de linha de log **por leitura do canal** — em uso normal, com o
operador no pinpad, isso acontece a cada poucos segundos por minutos seguidos. Sem um gate de
nível, essa instrumentação seria inutilizável em produção (ou inundaria o arquivo). O item 4 era
pré-requisito do item 1, não um item paralelo de prioridade menor.

O sintoma disso já estava no código antes de mim: a linha de timeout de leitura vivia sob
`{$IFDEF DEBUG}`, ou seja, **não existia no binário de Release** — e era exatamente a linha que o
item 1 precisava ler em campo. Trocar o IFDEF pelo nível resolve as duas pontas.

### A hipótese do item 1 estava escrita no código desde 04/09, e ninguém ligou os pontos

Isto é o achado da sessão, e não veio de medição nova: veio de **ler um comentário antigo com
uma pergunta nova**.

O comentário de `pLoopLeitura` diz, desde 2026-09-04, que leitura e escrita compartilham o estado
overlapped do **mesmo** handle, que toda escrita da thread chamadora aborta a leitura em curso
devolvendo `ERROR_IO_INCOMPLETE` (996), e que isso bateu **13 de 13 vezes** naquele log. Ele foi
escrito para explicar **perda de quadro** — e aí parou.

A pergunta que faltava: *e se isso valer também durante a espera do ACK?* Então cada retransmissão
de 2 em 2 s aborta a leitura que traria o próprio ACK, o quadro fica retido, e só é lido quando
as escritas param. Isso explica, de uma vez, as **duas** coisas que estavam medidas e sem
explicação: o atraso **proporcional ao número de tentativas** (9,0 / 9,1 / 9,7 s com 4
retransmissões) e as cópias chegando **juntas, em 2 ms** — que é a assinatura de rajada liberada,
não de latência por quadro.

**Segue hipótese, não conclusão**, e o Passo 8 não a trata como conclusão: o que foi entregue é o
log que a decide, com duração de cada leitura e contagem de escritas nossas no intervalo. Se
confirmar, o conserto **não é aumentar o orçamento** — é a thread única dona do handle que o
mesmo comentário de 04/09 já propõe, e que segue como decisão pendente com o Rafael.

A lição: **o comentário que explica um bug pode conter a causa de outro.** Aquele texto foi
escrito para justificar o dedup e a retransmissão; o que ele descreve é uma propriedade do
handle, e propriedade não tem escopo de sintoma.

### A terceira guarda do `fColetaOrfas` caiu, e pelo mesmo motivo das duas primeiras

O handoff da manhã registrava como lição que duas guardas daquele método já tinham sido
corrigidas por medirem *"eu estou ocupado"* querendo dizer *"outro está ocupado"*. Ao implementar
o item 2 apareceu a terceira, e ela é de uma variedade um pouco diferente e mais desagradável.

`if (not AblnAntesDeReconfigurar) and (FdictSessoes.Count > 0) then Exit;` — essa guarda estava
**correta quando foi escrita**. O que aconteceu é que a RF24, meses depois, passou a deixar
sessão `DESANEXADA` **dentro** do dicionário: daí em diante `FdictSessoes.Count > 0` deixou de
significar "alguém está ativo" e passou a significar "algum autcom já rodou nesta instância do
serviço" — que é quase sempre verdade. **A guarda não mudou; o significado do que ela media
mudou debaixo dela.**

E o efeito era exatamente o número medido em campo: **uma** sessão desanexada bastava para
bloquear a coleta inteira, para sempre. As 11 sessões das 14:53 não eram o acúmulo de desanexadas
sendo tolerado — eram a coleta **inteira** desligada por uma delas.

Isso muda a leitura do item 2 no handoff, que dizia *"sem risco de correção; não é bug"*.
Continua verdade quanto à **correção** (o `fGaranteSessao` casa o par pid+início e nenhum autcom
herda loja/terminal de outro), mas o mecanismo não era "a RF28 não olha desanexadas" — era "a
RF28 não roda". Duas causas, e só uma estava no handoff.

Por isso a mudança tem duas metades, e a segunda é **o único ponto do Passo 8 que mexe em guarda
validada em campo**: o prazo de 30 min orfana a desanexada vencida, e a guarda passa a contar
sessões **anexadas**. O argumento de segurança está no código, na spec e na rules, e o resumo é:
o conjunto do que pode ser destruído não mudou (só `FlstOrfas`, e desanexada fresca não está lá);
mudou quando o caminho ocioso desiste. **Se algo regredir no Passo 8, é aqui que se olha
primeiro.**

### O item 3 ficou pequeno porque não escrevi caminho novo

A tentação era escrever um re-login próprio para o gatilho novo. O `pRefazTefSeServicoReiniciou`
carrega quatro guardas que já foram pensadas uma vez — a própria chamada de login não se
reaplica, não há reentrância, sem argumentos guardados ele registra e sai, e um re-login que
falhe não derruba a chamada real. Um caminho paralelo perderia as quatro, uma por uma, e
descobrir isso levaria uma bateria de campo cada.

A implementação do gatilho novo virou, no fim, **três linhas**: ligar a mesma flag que a resposta
do `reata` liga, chamar o mesmo método, marcar para repetir. **Dois detectores para o mesmo
desfecho, não duas implementações** — e isso virou regra na `IA\rules\tef-dvc.md`.

Um detalhe que vale para quem for ler o log depois: naquele cenário o
`pRefazTefSeServicoReiniciou` registra a *"instância atual"* com o valor que o autcom conhecia,
que é o da instância **antiga** — justamente porque nenhum `reata` trouxe a nova. É confuso lido
solto, e por isso o ramo novo loga uma linha de contexto **antes** de chamar.

### Dois erros meus nesta sessão, os dois de ferramenta

**1. O heredoc do bash colapsou barras invertidas duplas.** Um script Python passado por
`<<'EOF'` chegou com `\n` virado em `\n` literal e `\456190` interpretado como escape octal —
o caminho do backup no `MEMORY.md` foi gravado como `..\_backupsĮ190_...`. Pior: no mesmo comando
o script seguinte rodou **sem** os dois ajustes que eu acabara de fazer, e patchou o plugin de
forma incompleta. Recuperado do backup de 15:22 com sha256 conferido — que é exatamente para isso
que o backup foi feito primeiro.

**Regra que ficou:** conteúdo com barra invertida ou acento vai para arquivo pelo Write, nunca por
heredoc. Todos os patches seguintes foram assim.

**2. `{$IFDEF DEBUG}` dentro de um comentário `{ }`.** O `}` da diretiva fechou o comentário, e o
compilador leu texto em português como código (12 erros, o primeiro `Undeclared identifier:
'ate'`). Pego no primeiro build. Em comentário, escrever *"compilado sob IFDEF DEBUG"* sem as
chaves.

### O que eu NÃO consegui, e não vou dizer que consegui

O `CLAUDE.md` orienta `tasks.md` de ~10 KB. Saí de **360 KB para 110 KB** — 59 seções narrativas
datadas migradas para este arquivo, verbatim, com conferência programática de que cada uma chegou
aqui e saiu de lá. O que restou são os checklists de seis fases mais as seções de desenho dos
Passos 6 e 7. **Descer de 110 KB exigiria mexer no checklist**, que é o que aquele arquivo é.
Registrado como está, sem arredondar para cima.

### Dois achados de commit que não estavam em lista nenhuma

**`TefEstacaoService.dpr` tem `Application.CreateForm(` e está com status `A`** — vai ser varrido
pelo pre-commit, que barra o padrão. E **não dá para trocar por `pCriarForm`**: aqui é o
`Application` do `Vcl.SvcMgr`, e o `pCriarForm` vive em `untFuncoesSimples.pas`, unit que este
projeto deliberadamente não referencia (o `.dpr` explica o porquê). Descoberto por acidente, ao
registrar a unit de log nova no `.dpr`. Precisa de decisão de quem cuida do hook.

**`untTefCitelDvcPluginImpl.pas` está com LF puro**, 0 CRLF em 622 linhas, contra o
`.editorconfig`. Preservado de propósito — normalizar agora inflaria o diff em 600+ linhas e
esconderia o que o Passo 8 mudou de verdade.

---

## Sessão de 2026-09-10, fim da tarde — primeira bateria do Passo 8, AV e duas conclusões viradas

**Bateria do Rafael com `Nivel=2`, 17:04–17:17.** Interrompida por um `EAccessViolation`. Rendeu
mais do que a validação que ela ia fazer: derrubou a hipótese central do item 1 e a causa
registrada do "Bug 6". As duas estão na `IA\rules\tef-dvc.md`; aqui fica a jornada.

### A regressão de `Nivel=1` passou, e mostrou que eu tinha rebaixado a camada errada

Antes da bateria o Rafael mandou uma venda em `Nivel=1`. Transação completa, zero retransmissão,
plugin caindo de ~100 para **6 linhas**. Mas o log do autcom ficou em **101 linhas** e o da estação
em **~130** — praticamente o volume de antes.

Eu tinha rebaixado as linhas **por quadro do transporte** e declarado o volume resolvido. O volume
não está no transporte: 60 das 101 linhas do autcom são pares `pTrataEvento`/`pNotifica` de
`untTefCitelDvc.pas` (duas por atualização de tela do pinpad, e a Modalidade Dinâmica repete
`"Escolha uma Opção"` nove vezes idênticas); e na estação eu troquei o corpo das duas funções de
log por delegação **sem reclassificar um único call site**. Fica como pendência com proposta
escrita: descer para nível 2 os pares de status 20/21 e o triplo de bookkeeping de RPC (~101 → 35)
e, na estação, `recebidos N bytes` / `quadro aceito` / `pEnviaEvento` de 20/21 (~130 → 30).

**A lição:** "rebaixei as linhas por quadro" e "resolvi o volume" pareciam a mesma frase. Contar as
linhas de uma transação real custava um minuto e eu não contei antes de afirmar.

### O AV: o instrumento virou o ponto de crash

`EAccessViolation` no pid=80288, 17:13:37.816, na queda de TS. Três exceções aninhadas; a mais
profunda é `@LStrSetLength` lendo `C00000A8` na linha do carimbo de tempo — **código anterior ao
Passo 8**, chamado do log de desconexão real do canal, que também é anterior. O heap de strings já
estava corrompido. O outro AUTCOM passou pela mesma queda 28 ms antes e não estourou.

O que me fez olhar para volume em vez de para a função: as baterias de 09/09 e 10/09 tiveram várias
quedas de TS **no mesmo caminho de código** e nunca estouraram, com o volume de nível 1. E a venda
das 16:47, também em nível 1, passou limpa. O que mudou foi ~5× mais chamadas de log.

Aí veio a parte desconfortável: isso é a assinatura do "Bug 6", e a causa registrada em
2026-08-28 (`FormatDateTime` / locale global) **nunca tinha sido provada**. Naquela sessão duas
coisas mudaram juntas — saiu o `FormatDateTime` e saiu o log incondicional de
`pAcumulaBytesRecebidos`, o de maior frequência. O crash sumiu e o crédito foi para o primeiro.
Ficou 13 dias no registro, e na `rules`, como causa resolvida.

**O padrão vale além deste ponto:** duas mudanças na mesma sessão e um sintoma que desaparece não
identificam causa. Este requisito já tinha o método certo escrito para outra coisa (*"o critério é
o método deixa a sessão Scope aberta?, não o que ele diz que faz"*) — e mesmo assim aceitei uma
causa por coincidência temporal.

### A hipótese do item 1 caiu com a própria instrumentação que eu escrevi para confirmá-la

Eu tinha escrito, no comentário de `pLoopLeitura` e no `PONTO DE PARADA`, que os 9 s vinham das
nossas próprias retransmissões abortando a leitura que traria o ACK. A instrumentação mostrou que
o aborto **acontece sempre** e **não custa nada**: o ACK volta em 0–16 ms, mais de cem vezes.

E mostrou onde o tempo está: a resposta do `reata` levou 3,9–4,9 s para ser lida com **zero
escritas nossas** no intervalo. Ou seja latência de entrega — que eu havia descartado de manhã, com
a frase *"não é latência de entrega, é a leitura que fica retida"*. Errado.

**É bom para o plano:** o conserto que essa hipótese pedia era uma thread única dona do handle —
refactor no coração do transporte já validado em campo, que teria consertado um mecanismo benigno.
A instrumentação custou uma bateria e evitou isso. Foi exatamente para isso que ela existia, e é o
argumento a favor de "instrumentar antes de mexer" ter sido a escolha certa em vez de "aumentar o
orçamento".

**É neutro para o entendimento:** os dois mecanismos que sobraram — latência de entrega e o canal
truncando uma mensagem WTS (21 de 60 bytes) — estão **fora do nosso código**. O item 1 deixa de ser
"temos um conserto a fazer" e passa a ser "temos um comportamento do canal a monitorar, com as
defesas funcionando" — e elas funcionaram: única retransmissão da bateria, quadro recuperado como
`quadro ATRASADO aceito`.

### O conserto escolhido, e o que ele não é

Opção (a) do Rafael: **o log do lado autcom para de alocar no caminho quente.** Carimbo, prefixo e
mensagem escritos dígito por dígito num buffer de pilha de 4 KB; caminho do arquivo montado uma vez
por processo; escrita direto do buffer.

**Não é o conserto da corrupção.** Ela existe com ou sem este log. E não cobre o `Format` do
chamador, que monta o texto da mensagem e continua alocando — se o heap estiver corrompido, o
estouro pode só mudar de endereço. O que se ganha é tirar a thread de leitura de cima do problema e
devolver a bateria. Se estourar de novo, o stack vai apontar o `Format` do chamador, e isso também
é informação.

Achar a corrupção de verdade (FastMM4 em FullDebugMode no `autcom.exe` + DLL) ficou fora do Passo 8
por escopo: é investigação de heap num executável de 445 MB com DLLs de terceiro.

---

## Sessão de 2026-09-11, manhã — a segunda bateria, e o item 3 travado por uma camada abaixo dele

### O que o Rafael relatou, e a parte dele que estava certa

Bateria em `Nivel=1`: cinco quedas de TS com dois autcom abertos, mais um teste com transação em
voo seguido de **reinício do serviço da estação**. As duas transações ficaram paradas na tela; ele
finalizou os dois autcom, removeu a trava LCKATC na volta e continuou normalmente. E escreveu:
*"não vejo isso como bug"*.

A recuperação manual, não é. O **motivo** das telas paradas é — e é o defeito mais grave achado
nesta fase. Vale registrar que o relato dele descreve o sintoma com precisão suficiente para
achar a causa, e que o instinto de que "algo aqui é normal" apontava para a parte certa (a
recuperação) enquanto escondia a parte errada (o que levou a ela).

### O item 3 disparou, e a resposta dele morreu no caminho

A estação fez exatamente o que o Passo 8 pediu — `motivo="loginNecessario"` nas duas, às 07:35:55
e 07:36:31. No autcom, nos dois pids, o log termina na mesma linha:

```
quadro duplicado descartado (messageId=2, maior aceito=14) - reenviando ACK mesmo assim
```

65 ms e 14 ms depois de a chamada sair. Nenhum `pTrataResposta`, nenhum `pRefazTefSeServicoReiniciou`,
nenhuma repetição. No `TefCitelAutcomTeftra.log` o rastro para em
`fPassaCartao: antes de LTefCitel.fPassarCartao - numDoc=0000000020` e **não há linha depois** —
com a linha da TEFTRA já gravada como `TRN INICIADA`.

### A causa: duas invariantes certas, escopos diferentes

O contador de `messageId` da estação zera **por conexão TCP**; o dedup do autcom zera **por canal
DVC**. Os dois comentários de código dizem "monotônico dentro de um mesmo X" — e o X é diferente.
O canal sobrevive a N conexões, porque o plugin reconecta o socket sem tocar no canal.

Detalhe completo, com o conserto, na seção nova da `IA\rules\tef-dvc.md`.

### Como eu separei os nove descartes benignos dos dois fatais

Isto é o que vale guardar. **Todos os dez descartes do log são `messageId=2`**, com texto
idêntico. Oito deles são duplicata de verdade — retransmissão da estação por ACK lento, e os três
de 07:32:10 casam um a um com o `tentativa 4/5` do lado estação no mesmo minuto. O discriminador
foi a **idade**: retransmissão cabe no orçamento de 5 × 2 s; nos dois casos fatais o `id=2`
anterior tinha sido aceito 77 s e ~41 s antes, e o contador da conexão velha já estava em ≥3 e
≥14 — não há de onde vir um `id=2` daquela conexão.

Quase caí na leitura oposta: os dois primeiros descartes que eu vi (07:35:14, **antes** do
reinício) são benignos, e se eu tivesse parado ali teria concluído "comportamento normal do
protocolo" e devolvido a bateria como limpa. O que forçou a olhar de novo foi o **horário**: um
descarte 14 ms depois de uma chamada sair não é retransmissão de nada.

E daí sai a correção de processo: a idade entrou na linha de log. Descarte silencioso sem o dado
que o discrimina de um descarte legítimo é um descarte que ninguém vai conseguir ler em produção.

### O que esta bateria validou, e o que ela não testou

Validado: cinco quedas de TS com dois autcom (reata nas duas, 18–28 s), RF21 filtrando por PID
(`1 de outro autcom mantido(s)` e depois `1 entregue(s)`), RF17/RF19/RN15 no caminho contestável,
`pNotificaCanalCaiu` liberando a LCKATC, aborto em voo, e uma venda limpa depois (MASTERCARD
crédito parcelado, resposta de 2202 bytes em 2 fragmentos).

Não testado, e eu disse isso em vez de deixar passar: o **AV não voltou, mas em `Nivel=1`** —
volume muito menor, então não é teste do conserto sem alocação; o **item 2** nunca foi
exercitado (terminou com 3 sessões no dicionário, o prazo de 30 min não venceu); a **rotação**
não aconteceu.

### Um número novo, e ele piora o risco aberto

Retransmissão de ACK **zero** na direção autcom → estação em todo o log; as que apareceram, até
`tentativa 4/5`, são todas estação → autcom. A margem apertada que está registrada como risco é
**unidirecional** — o que é ao mesmo tempo uma restrição útil do problema e a medição mais
apertada até agora (4 de 5).

### O item 3 continua sem validação

O conserto desobstrui o teste; não prova o item 3. A cadeia `fChamaRpcUmaVez` → `ETefCitelDvcLoginNecessario` → `fChamaRpc` → `pRefazTefSeServicoReiniciou` nunca teve chance de
rodar. Refazer o mesmo caso é o próximo teste.

## Sessão de 2026-09-11, 08:18–08:29 — o item 3 rodou inteiro, e mostrou que ele era um terço do problema

### O que a terceira bateria provou

O conserto de época funcionou **duas vezes** (`messageId=2 repetido 67078 ms` no pid=88584 e
`83344 ms` no pid=86700, os dois com `quadro ACEITO`) e — o que importa igual — **classificou certo
o lado benigno**: quatro descartes saíram como `id ja aceito ha 0 ms, dentro do orcamento de
30000 ms`, todos casando com `tentativa 1/5`…`4/5` da estação no mesmo segundo. Zero falso positivo
nos dois sentidos. O discriminador de idade era a escolha certa.

E o item 3 rodou ponta a ponta pela primeira vez, com os três carimbos na ordem: `loginNecessario`
→ `pRefazTefSeServicoReiniciou` → `re-login concluido, retorno 0` → `pSair` repetido com sucesso.

### E então: o item 3 era um terço do trabalho

O Rafael relatou "apareceu uma mensagem informativa, porém não deixou fechar a tela e no outro
autcom deu erro de carregamento". Duas frases, dois defeitos distintos, nenhum deles onde eu
esperava.

**A tela que não fecha.** `fPassarCartao` id=6 saiu às 08:24:57 e estava dentro da DLL nativa quando
o serviço parou às 08:25:25. Não existe resposta possível. E `pOnDesconectado` — o único lugar do
código que resolvia chamadas pendentes — **só roda na queda do canal**, que não aconteceu. Os oito
`pSair` seguintes (id=10 a 17), todos respondidos com sucesso pela estação, são o operador tentando
fechar a tela: o `pSair` entra aninhado na chamada presa, é atendido, e o fechamento nunca termina
porque a chamada de fora nunca retorna.

O que fecha o argumento é uma ausência: entre 08:25:02 e 08:25:39 **não há uma linha** do pid=88584
no log do transporte. Nenhum erro de canal, nenhum `pNotificaCanalCaiu`. O canal estava de pé o
tempo todo — e era justamente isso que impedia o único mecanismo de limpeza de rodar.

**O 64004 no outro autcom.** A guarda da estação era condicional a `FstrConfigAplicada = ''`. Quem
chamou primeiro foi recusado e, ao refazer o login, **preencheu** essa variável; quem chamou depois
emprestou a configuração do primeiro e foi despachado com o terminal errado. Loteria pela ordem das
chamadas.

### A lição que eu levo desta bateria

Eu tinha declarado o item 3 "implementado" em 10/09 e "pendente de validação". As duas coisas eram
verdade e nenhuma era suficiente: o item estava implementado *como especificado*, e a especificação
cobria um terço do que um reinício exige. A RF29 pedia "detectar e refazer o login" — e um reinício
puro precisa de **três** desfechos independentes (resposta chegar, login refazer, chamada em voo
morrer), cada um com um dono diferente no código.

**O sinal que eu deveria ter lido antes:** toda vez que um mecanismo desta migração dependia do
`reata`, ele tinha um buraco no reinício puro. Isso já estava escrito na invariante 2 da
`IA\rules\tef-dvc.md` desde 10/09 — *"o serviço reiniciar não implica o canal cair"* — e eu apliquei
essa invariante ao gatilho do login e não ao resto. A pergunta certa, e que agora está na regra, é
**"o que acontece com isto quando o `reata` não sai?"**.

### Dois consertos que reusam caminho validado em vez de criar caminho novo

`fMataChamadasPendentes` nasceu de extrair o corpo do `pOnDesconectado` — quatro linhas — quando
apareceu o segundo chamador. Isso dá de graça a cadeia inteira que já foi validada em campo:
`ErroCanal` → `ETefCitelDvcCanal` → `pNotificaCanalCaiu` → negativa 500 + retorno vazio + callback
`Depois*` + **LCKATC liberada**. Era essa trava que o Rafael tirou à mão na bateria anterior.

Na estação, apertar a guarda exigia provar que o login adiado não seria atingido. `FblnCfgRecebida`
é marcado no **topo** de `fMetodoFConfiguraTefCitel`, antes de qualquer decisão de adiar: a sessão
adiada sempre chega com `True`. Verificado **antes** de mexer, e é o que autorizou tocar numa guarda
validada em campo.

### Um número e uma mentira

O ACK da estação chegou a **4/5** de novo (con=6, 08:24:39–08:24:45), segunda bateria seguida, e
continua **zero** no sentido oposto. A margem é unidirecional e a medição mais apertada se repetiu.

E `pRefazTefSeServicoReiniciou` logou `instancia atual "{BA2FD1F9-…}"` — a instância **velha**; a
nova era `{76D1B195-…}`. O autcom só aprende o GUID pela resposta do `reata`, que não sai aqui.
Hoje é inofensivo (o detector do `loginNecessario` não compara GUID), mas a linha mente e o autcom
segue acreditando numa instância morta. Proposto como item C e **deixado de fora por decisão** —
fica registrado como resíduo conhecido, não como esquecimento.

## Sessão de 2026-09-11, 09:12–09:32 — a bateria que fechou os dois consertos e achou o terceiro AV

### O que ficou provado

Quarta bateria do dia, `Nivel=1`, cinco reinícios do serviço e cinco quedas de TS com dois autcom.
Os dois consertos da manhã passaram, com número:

- **época nova**: 4 disparos (167500, 207110, 166843, 177937 ms), todos `quadro ACEITO`, e as **6**
  duplicatas benignas classificadas certo (`ha 0 ms`, `ha 3578 ms`). Três baterias, zero falso
  positivo nos dois sentidos;
- **conserto A**: `1 chamada(s) estavam em voo quando o servico da estacao reiniciou` duas vezes,
  cada uma seguida de `pNotificaCanalCaiu` → 500 → `Depois*` → LCKATC. **Um `pSair`, não oito.** A
  tela fechou e a venda seguinte rodou completa;
- **conserto B**: **zero** ocorrências de `64004` no log inteiro, e `loginNecessario` para os
  **dois** pid — na bateria anterior o segundo a chamar levava 64004;
- **a previsão escrita no comentário do A se confirmou**: no caminho do `reata` a linha de órfãs
  não apareceu, porque o `pOnDesconectado` já havia limpado. Predição registrada em código e
  conferida em campo.

### O terceiro AV, e por que ele sobreviveu tanto tempo

`ServiceStop` → `Destroy` → `FlstTodasSessoes.Free` descarrega a DLL nativa **com a thread de
despacho ainda dentro dela**. Detalhe e conserto na seção nova da `IA\rules\tef-dvc.md`.

O que vale guardar é por que ninguém viu antes: **é corrida.** Na outra parada da mesma bateria
com chamada em voo (09:25:44, id=31) o processo saiu antes de a thread acordar e não houve AV. Um
defeito que aparece em metade das execuções do mesmo cenário não é achado por repetição — foi
achado porque a linha do AV caiu no mesmo milissegundo do `ServiceStop concluido`, e o log tem
milissegundo.

E o conserto trouxe um ganho que eu não tinha previsto ao propor: esperar **antes** do
`FTransporte.Free` faz a resposta da chamada abortada chegar ao autcom, coisa que hoje se perde.
Eu ia colocar a espera depois do `Free` — foi ao escrever o comentário que o problema apareceu.
Mais um caso em que escrever o *porquê* achou um defeito no *quê*.

### A confirmação que não confirmava: o Rafael reclassificou, e ele está certo

Eu reportei como defeito o `fFinalizarTransacao` que voltou `ok` em 31 ms (contra 1654 e 1628 ms
das duas confirmações reais da bateria) depois de um re-login, para o Controle **09102834016**. O
Rafael verificou no relatório do TEF: **ficou pendente** — o que confirma o diagnóstico técnico — e
respondeu que esse é o desfecho **correto**: o serviço foi reiniciado, a sessão Scope morreu, a
transação fica pendente para alguém efetivar depois, e o autcom seguiu até o fim sem problema.

Então o defeito não é o resultado, é a **informação**: o protocolo respondeu "confirmei" para algo
que não confirmou, e o aviso ao operador foi `pNotifica ... para 0 observer(es)` — a tela já havia
fechado. Registrado como item E, com o custo medido (abaixo) em vez de estimado.

### O custo do E, medido antes de propor

`fFinalizarTransacao` é **procedure**, sem retorno (`untInterfaceTefCitel.pas:317`), e os dois call
sites são uma linha nua sem `try/except` (`untTefCitelUtil.pas:1632` e `:1680`). Consequência: fazer
a estação recusar não informa ninguém — o único canal seria **exceção**, que subiria pelo
`pFinalizaTranscacao` e abortaria o fecho de uma venda que hoje termina certo. Ou seja, a versão
"recusar" do E **piora** o caso que o Rafael acabou de classificar como correto, e exigiria mexer
em `padra_atualizado\fontes\` → `autcom.exe` na IDE.

A medição mudou a proposta: o que sobra é (i) a estação **registrar** que a confirmação não tinha o
que confirmar, e (ii) o aviso ao operador ganhar destino quando não há observer — este cabe
inteiro no `untTefCitelDvc.pas`, dentro da DLL, sem tocar no `autcom.exe`.

**Lição de processo:** eu propus o E com a palavra "recusar" antes de olhar a assinatura do método.
Uma consulta de dois minutos à interface e aos dois call sites trocou a proposta inteira. Medir o
custo é parte de propor, não de implementar.

### O E2, e a parte que eu ia errar de novo

O Rafael escolheu só o E2 — *"pelo menos o operador fica informado"* — e isso está certo: o E1
(estação logar que a confirmação não tinha o que confirmar) só ajuda quem lê log depois do fato,
enquanto o E2 chega em quem pode agir.

Duas decisões de implementação que não eram óbvias quando propus:

**`TThread.Queue`, não entrega direta.** Minha primeira ideia era despachar o aviso no fim do
`AdicionaObserver`. Só que status 500 abre caixa de mensagem na tela, e entregar dali reentraria
na tela enquanto ela ainda está se registrando — em VCL isso é forma de travar num form
meio-construído. A unit já tinha a resposta: o `pTrataEvento` usa `TThread.Queue` por um motivo
vizinho (o deadlock de 2026-08-28), e o comentário dele explica tudo. Usei o mesmo caminho.

**Não unificar com o `pNotificaNegativa`.** É tentador fazer "toda negativa sem observer fica
guardada". Errado: a negativa de uma chamada pertence à chamada que está voltando agora — guardá-la
faria a mensagem de um cartão negado aparecer na transação seguinte, que é literalmente o bug de
2026-09-03 que este requisito passou dias caçando. Só o aviso que fala de operação **anterior**
pode ser adiado, e por isso são dois métodos e não um com flag.

O prefixo "Aviso da operação anterior:" existe pelo mesmo motivo: sem ele a frase pareceria falar
da venda que o operador acabou de começar.

### O número que virou risco concreto

O orçamento do ACK **estourou**, duas vezes: `tentativa 5/5` seguido de
`socket NAO confirmou a entrega do messageId=2 apos 5 tentativas - seguindo sem confirmacao`. Nas
duas a entrega aconteceu depois, mas com 16–17 s. E a medição nova é a assimetria:

| pid | REABERTO → `pEnviaReata` (5 reconexões) |
|---|---|
| 163036 | 0,0 / 0,0 / 0,0 / 0,0 / 0,0 s |
| **65752** | **16,5 / 1,5 / 9,0 / 15,9 / 12,1 s** |

Cinco de cinco atrasadas num processo, zero de cinco no outro. Valores em torno de 15–16 s, que é
a ordem do timeout de leitura. Casa com a correção de 10/09 (*"não é latência do canal, é a leitura
que fica retida"*). Não vou consertar por hipótese — a instrumentação do item 1 mede exatamente
isto e pede uma bateria `Nivel=2`.

> **Correção (bateria das 10:15):** eu escrevi aqui que o eixo era *"por que só num dos
> processos?"*. Errado — na bateria seguinte um **terceiro** processo (pid=169460) atrasou 16,9 s.
> Não é identidade de processo. O que sobrevive é outra correlação, mais estreita e ainda sem
> mecanismo: **as seis observações lentas são todas do terminal "003" e as cinco rápidas todas do
> "004"**. E não pode ser a configuração do terminal em si, porque o `reata` sai **antes** de
> qualquer interação com a estação. Correlação anotada, causa não; o `Nivel=2` mede.

## Sessão de 2026-09-11, 10:15–10:27 — F e E2 validados, e uma conclusão minha corrigida

### Os dois consertos, com as duas metades de cada um exercitadas

Bateria curta e bem desenhada: ela pegou **os dois ramos** de cada conserto.

**F, ramo sem chamada em voo** (10:20:25): `pParaComSeguranca: nenhum despacho em voo depois de
**0 ms**`. Custo zero quando não há o que esperar — era o risco de "agora toda parada demora".

**F, ramo com chamada em voo** (10:26:12): `ABORTANDO pelo pSair antes do teardown` → os eventos do
pinpad seguiram (`Transacao cancelada`, `-1`) → `Metodo "fPassarCartao" (id=3) retornou com sucesso`
→ `nenhum despacho em voo depois de **2782 ms**` → `ServiceStop concluido`. **Zero Access
violation.** E o ganho que eu não tinha previsto ao propor se confirmou: o autcom **recebeu a
resposta** (`pTrataResposta: recebido id=3 ... encontrado em FdictChamadas`), porque a espera roda
antes do `FTransporte.Free`. Antes essa resposta se perdia.

2782 ms contra o teto de 10 s — 3,6× de folga, e a estimativa de "~2 s" escrita no comentário da
constante estava certa.

**E2, ramo guardado** (10:21:29 → 10:22:00): `aviso GUARDADO para a proxima que registrar observer`,
e **31 s depois**, na tela seguinte, `entregando aviso guardado a tela que abriu agora` +
`pNotifica ... "Aviso da operacao anterior: O servico de TEF..." para 1 observer(es)`.

**E2, ramo imediato** (10:26:53): mesma mensagem **sem** prefixo, `para 1 observer(es)` — porque
havia tela aberta. Os dois caminhos na mesma bateria, cada um com o texto certo.

### A conclusão que eu tinha tirado errado

Ontem eu escrevi que o atraso do `reata` era uma **assimetria por processo** — "5 de 5 num, 0 de 5
no outro". Hoje um **terceiro** processo (pid=169460) atrasou **16,9 s**. Não é identidade de
processo.

Olhando as onze observações juntas, o que sobra é mais estreito: **as seis lentas são todas do
terminal "003"; as cinco rápidas, todas do "004"**. E isso não pode ser a configuração do terminal
causando, porque o `reata` é a **primeira** coisa que sai no canal novo, antes de qualquer
interação com a estação. Ou seja: correlaciona com *qual instalação de autcom é*, não com o que ela
manda. Anotei como correlação e deixei o mecanismo em aberto — é exatamente o tipo de conclusão que
eu fecharia rápido demais se não tivesse mais uma bateria.

**Lição:** "5 de 5 contra 0 de 5" parece forte e não é, com dois sujeitos. O terceiro sujeito
derrubou o eixo inteiro.

### Dois dados novos que vêm de graça

**A instrumentação do item 1 disparou pela primeira vez no sentido autcom → estação** — e a favor
da refutação:

```
10:26:17.721  pEnviaFrame: sem ACK do messageId=16 apos 2000 ms (tentativa 1/5;
              2000 ms e 0 escrita(s) nossa(s) no canal desde a 1a escrita deste quadro)
```

**Zero escritas nossas.** Não foi o nosso próprio tráfego abortando a leitura do ACK. A causa está
no log da estação: o serviço estava parado nesse intervalo, e o plugin **segurou** os quadros —
quando o socket voltou às 10:26:19.712 a estação recebeu **1104 bytes de uma vez** (o original mais
as duas retransmissões) e o dedup dela aceitou um e descartou dois. Retransmissão fazendo o
trabalho dela através de um reinício de serviço; nada a corrigir.

**A época nova salvou mais uma:** `messageId=4 repetido 41062 ms ... Maior id aceito na epoca
anterior=15`. Era a resposta do `pRetornaLog` vinda da instância nova. Sem o conserto de 08:08 ela
seria descartada (id 4 ≤ 15, já no dedup) e o `pRetornaLog` ficaria pendurado.

### O resíduo C piorou de forma útil

`pRefazTefSeServicoReiniciou: o servico da estacao REINICIOU (instancia atual "")` — **vazia**, não
só velha. O pid=70292 nasceu depois do reinício e nunca recebeu resposta de `reata` (o canal dele
não caiu, só o socket), então nunca aprendeu GUID nenhum. A linha agora não informa nada nesse
caminho. Continua inerte para a lógica, e continua registrado como resíduo recusado por decisão.

## Narrativa migrada do tasks.md (2026-09-10, item 5 do Passo 8)

As 54 secoes abaixo vinham do `tasks.md`, **sem uma palavra alterada**. Elas sao o registro
cronologico da investigacao - teste de campo por teste de campo, bug por bug - e e aqui que o
`CLAUDE.md` diz que esse genero mora. O `tasks.md` ficou com o checklist e um ponteiro para ca.

A ordem e a mesma em que estavam la, que e cronologica.


### PARADA PARA O FIM DE SEMANA (2026-08-20) — retomar aqui na segunda-feira

**Estado exato:** com a correção do erro 996 aplicada, o teste seguinte (mesma sessão, `CFG_TEFDVC = S`, `fConfiguraTefCitel`) **não deu mais o erro de desconexão — mas ficou travado** (Rafael: "ficou travado"). Não houve exceção nem mensagem nova; o `autcom.exe` (e presumivelmente a chamada RPC) simplesmente não retornou. Isso é uma mudança real de sintoma, não o mesmo bug: antes tínhamos um falso positivo de desconexão (interrompia rápido, com erro); agora, sem esse falso positivo, alguma coisa está genuinamente demorando/travando sem nunca responder nem dar erro.

**Hipótese a verificar primeiro na segunda-feira:** a estação de teste (`CTLDSDEVRP2470`) tem um **pinpad físico de verdade conectado**? Esse risco já estava mapeado em `plans.md` (seção 6: "Necessário hardware real (pinpad) em homologação, sem mock possível"). É plausível que `fConfiguraTefCitel` da instância real (`TTefCitelNCR`/`TTefCitel`, agora rodando dentro do `TefEstacaoService.exe`) esteja bloqueada dentro da própria DLL nativa do Scope/CliSiTef, tentando se comunicar com um pinpad que não existe fisicamente — travamento sem exceção é o comportamento típico de I/O de hardware sem timeout, não necessariamente um bug nosso.

**Lacuna de diagnóstico ainda aberta, útil resolver primeiro na segunda:** `TefEstacaoService.exe`/`untTefEstacaoRoteadorMensagens.pas` **não tem nenhum log próprio** hoje (nem arquivo, nem Log de Eventos) — só o plugin (`%TEMP%\TefCitelDvcPlugin.log`, na estação) e agora o transporte DVC do lado autcom (`%TEMP%\TefCitelDvcTransporte.log`, no servidor) logam algo. Se o travamento for dentro do roteador/instância real, hoje não sobra nenhum rastro de ONDE ele trava (em `pGaranteInstanciaReal`/`fCriarTefCitel`? dentro do método `fMetodoFConfiguraTefCitel`? dentro da própria `TTefCitelNCR.fConfiguraTefCitel`, já na DLL nativa?). **Foi cogitado durante a sessão adicionar esse log** (mesmo padrão `pLogArquivo`/`pLogaDiagnosticoDvc` já usado nos outros dois componentes) mas não foi implementado ainda — bom primeiro passo de segunda-feira, antes de mais tentativas de teste manual, para não repetir o ciclo de "tenta, trava, sem pista nenhuma".

**Roteiro sugerido para segunda-feira:**
1. Confirmar se há pinpad físico conectado na estação de teste; se não houver, isso pode já explicar o travamento (não é bug, é limitação de ambiente de teste sem hardware).
2. Adicionar log em arquivo no `TefEstacaoService`/roteador (antes de mexer em mais nada), pra próxima tentativa já sair com rastro de onde parou.
3. Repetir o teste com `CFG_TEFDVC = S` e usar os 3 logs (plugin/estação, transporte DVC/servidor, roteador/estação — o novo) junto pra localizar exatamente o ponto de travamento.

---


### Retomado em 2026-08-24

Logs do teste de 2026-08-20 analisados: `TefCitelDvcTransporte.log` (servidor) mostra o timeout de 996 sendo corretamente reconhecido em loop, por mais de um minuto seguido, sem nunca receber resposta — a correção do erro 996 está funcionando, mas a estação nunca respondeu de fato. `TefCitelDvcPlugin.log` (estação) mostra canal aceito + pipe conectado com sucesso às 11:03:48, sem nenhuma desconexão depois — o relay plugin↔pipe está saudável. Rafael também confirmou porta serial `COM6` configurada localmente (19200 baud, 8N1) — **há pinpad físico/porta serial real configurada** nessa estação, então a hipótese de "sem hardware" fica mais fraca; input do Rafael: "acredito que deve ter algo errado na hora de carregar as libs do scope".

**Log implementado em `untTefEstacaoRoteadorMensagens.pas`** (item 2 do roteiro acima, feito): nova função `pLogaEstacao`, grava em `%TEMP%\TefEstacaoService.log` **na estação** (mesmo padrão dos outros dois logs — `System.SysUtils.Now`, não `fNow`, mesma justificativa). Instrumentados:
- `pOnFrameRecebido` — loga o método de cada frame `"chamada"` recebido do pipe (confirma se o roteador está de fato recebendo o pedido).
- `pGaranteInstanciaReal` — loga antes/depois de `fCriarTefCitel` (instanciação de `TTefCitelNCR`/`TTefCitel` — rápido, não deveria travar, mas serve de checkpoint).
- `pTrataChamada` — loga antes/depois de `fDespachaMetodo`, e a mensagem de qualquer exceção capturada (hoje só ia para a resposta JSON de erro ao autcom, sem rastro local).
- **`fMetodoFConfiguraTefCitel` — o ponto mais suspeito**: loga imediatamente antes e depois de `FRealInstance.fConfiguraTefCitel(...)`, a chamada que entra de fato na DLL nativa do Scope/CliSiTef (`untScopeNCR.pas`/`untTefCitelNCR.pas` — arquivos que não podem ser alterados, por isso a instrumentação fica só ao redor, no roteador). Se travar sem exceção, o log vai mostrar a linha "Chamando..." sem a linha "retornou" correspondente — confirma travamento dentro da DLL nativa (ex.: tentando falar com o pinpad na porta serial configurada, sem timeout do lado da DLL) em vez de no roteador/transporte.

Recompilado (`TefEstacaoService.dproj`, MSBuild, 0 erros).

**Próximo passo**: repetir o teste com `CFG_TEFDVC = S` usando o `TefEstacaoService.exe` recompilado, e mandar o conteúdo de `%TEMP%\TefEstacaoService.log` (na estação) junto com os outros dois logs — isso deve mostrar exatamente onde para.

**Ajuste em 2026-08-24 — local do log corrigido**: o log não aparecia em nenhuma das duas pastas candidatas de `%TEMP%` do `LocalSystem` (`C:\Windows\Temp`, `C:\Windows\System32\config\systemprofile\...\Temp`) — confirmado com `Get-Content -ErrorAction Stop`, erro "não é possível localizar o caminho" (não é permissão, é mesmo "não existe"). Em vez de continuar tentando adivinhar o `%TEMP%` do `LocalSystem`, `pLogaEstacao` agora grava direto ao lado do próprio `.exe` (`ExtractFilePath(ParamStr(0))` — mesma pasta de instalação flat, sempre gravável pelo `LocalSystem`, fácil de achar). Recompilado (`TefEstacaoService.dproj`, 0 erros). Log agora fica em `C:\TEF_Citel\TefEstacaoService.log` (mesma pasta do `.exe`).

**Checklist pra próxima tentativa**: (1) trocar o `.exe` na pasta; (2) `Stop-Service`/`Start-Service TefEstacaoService` (trocar o arquivo sozinho não recarrega o código já em memória do processo rodando); (3) só então repetir o teste de `CFG_TEFDVC = S` no `autcom.exe` — sem isso, mesmo com o log no lugar certo, não vai ter nada escrito porque nenhuma chamada nova foi feita.

**Log continuou não aparecendo mesmo depois do ajuste de pasta — instrumentado Start/Stop do serviço para isolar a causa (2026-08-24, sugestão do Rafael)**: adicionado `pLogaEstacao('ServiceStart chamado.')`/`'ServiceStart concluido...'`/`'ServiceStop chamado.'`/`'ServiceStop concluido.'` em `untTefEstacaoServiceMain.pas` (`ServiceStart`/`ServiceStop`) — esses dois pontos disparam garantidamente ao parar/iniciar o serviço, **independente** de qualquer chamada RPC chegar. `pLogaEstacao` precisou ser exposta na `interface` de `untTefEstacaoRoteadorMensagens.pas` (antes só existia na `implementation`, invisível a outras units). Recompilado (`TefEstacaoService.dproj`, 0 erros).

**Teste mais simples pra isolar o problema**: trocar o `.exe`, dar `Stop-Service`/`Start-Service TefEstacaoService`, e checar `C:\TEF_Citel\TefEstacaoService.log` — **nem precisa repetir o teste do `autcom.exe` ainda**. Se essas 4 linhas aparecerem, o mecanismo de log funciona e o problema está mesmo no fluxo RPC (não chega nenhuma chamada até o roteador). Se **nem essas linhas aparecerem**, o problema é o próprio log (permissão de escrita na pasta, ou o `.exe` rodando não é o novo, ou outra coisa impedindo a escrita) — precisa investigar por aí antes de voltar ao RPC.

**Confirmado (2026-08-24)**: log de Start/Stop funciona. Rodou o teste de TEF no `autcom.exe` de novo e **nada mudou no log do roteador** — a mensagem não chega até lá. `TefCitelDvcTransporte.log` (servidor) só mostra o loop de timeout 996 continuando, o que **não prova** que algum envelope foi de fato enviado (esse loop de leitura roda desde a criação do transporte, independente de qualquer RPC ser chamado ou não — só a leitura é logada até agora, nunca o envio).

**Instrumentado o envio para fechar essa lacuna**: `TTefCitelDvc.pEnviaEnvelope` (`untTefCitelDvc.pas`) agora loga antes/depois de `FTransporte.pEnviaFrame` — `pLogaDiagnosticoDvc` precisou ser exposta na `interface` de `untTefCitelDvcTransporte.pas` (mesmo ajuste que fizemos com `pLogaEstacao`). Recompilado (`libTefCitel.dproj` + `TefEstacaoService.dproj`, MSBuild, 0 erros) — sobrescreveu `padra_atualizado\libTefCitel.dll` de novo.

**Próximo passo**: como a máquina onde compilamos É o servidor (`CITEL-TSDELPHIS` — mesmo caminho `padra_atualizado\` do `autcom.exe`), **não precisa copiar nada pro lado do autcom** — só reiniciar o `autcom.exe` pra carregar o `libTefCitel.dll` novo e repetir o teste de TEF. Depois, checar `%TEMP%\TefCitelDvcTransporte.log` (no servidor): se aparecer "Enviando envelope.../enviado com sucesso", confirma que o autcom mandou o pedido e o problema está entre o plugin/pipe/roteador (nesse caso, olhar de novo o log do plugin, que pode estar desconectado silenciosamente); se **não aparecer nem isso**, o autcom nem está tentando chamar `fConfiguraTefCitel` — aí o problema é anterior a tudo isso (ex.: `CFG_TEFDVC` não está realmente `S` nessa sessão, ou o fluxo de inicialização do TEF nem está sendo disparado).

**Confirmado (2026-08-24)**: `libTefCitel.dll` novo mostrou "Enviando envelope tipo="chamada" metodo="fConfiguraTefCitel" id=1..." e "...enviado com sucesso" — o `autcom.exe` **envia** o pedido de verdade. Mesmo assim, `TefEstacaoService.log` (roteador) continua **sem nenhuma linha nova** — a mensagem nunca chega no roteador, apesar do plugin mostrar canal aceito + pipe conectado no mesmo horário. O elo que falta rastrear é exatamente o meio do caminho: plugin recebendo do canal DVC → escrevendo no pipe → serviço da estação lendo do pipe → extraindo o frame.

**Instrumentado para fechar essa lacuna (2026-08-24)**:
- `untTefEstacaoPipeTransporte.pas` (lado estação, servidor do pipe) — não tinha NENHUM log; agora loga (no mesmo `TefEstacaoService.log`, ao lado do `.exe`, propositalmente no mesmo arquivo do roteador pra intercalar em ordem cronológica): conexão do cliente (plugin) aceita, bytes recebidos por leitura, frame completo extraído, e qualquer exceção ao processar bytes recebidos. **Corrigido de quebra junto**: uma exceção dentro de `pAcumulaBytesRecebidos`/`pExtraiFramesDisponiveis` (ex.: frame maior que o máximo suportado — sintoma clássico de um bug de enquadramento) **não era capturada** — derrubava essa thread em silêncio, sem fechar o pipe nem avisar o outro lado, deixando o plugin escrevendo pro vácuo achando que a conexão seguia normal. Agora vira um log + desconexão tratada normalmente (o loop externo reabre o pipe do zero).
- `untTefCitelDvcPluginImpl.pas` (plugin) — `OnDataReceived` agora loga quantos bytes chegam do canal DVC e se foram repassados ao pipe com sucesso ou enfileirados (pipe indisponível/escrita falhou).

Recompilado (`TefEstacaoService.dproj` Win32 + `TefCitelDvcPlugin.dproj` Win64, MSBuild, 0 erros nos dois).

**Próximo passo**: substituir os DOIS binários na estação — `TefEstacaoService.exe` (parar/iniciar o serviço) **e** `TefCitelDvcPlugin.dll` (fechar/reabrir a sessão RDP/TSPlus pra recarregar o plugin, igual da primeira vez). Repetir o teste e mandar `TefCitelDvcPlugin.log` + `TefEstacaoService.log` atualizados — agora dá pra ver exatamente até onde os bytes chegam.

**Achado crítico (2026-08-24)**: com os 3 logs alinhados no mesmo teste, o `autcom.exe` mandou o envelope (467 bytes, "enviado com sucesso"), o plugin recebeu ("`OnDataReceived: 467 bytes do canal DVC.`") — **mas nenhuma das duas linhas seguintes que a instrumentação deveria gerar apareceu** (nem "repassados ao pipe com sucesso", nem "NAO repassados... enfileirando"). E do lado do roteador/pipe da estação, depois de "Pipe: cliente (plugin) conectado.", **não apareceu nem uma linha de "recebidos X bytes"**. Ou seja: a execução trava dentro do próprio `OnDataReceived`, entre o log de entrada e o de saída — ou travando pra obter a critical section (`FcsEstado`), ou dentro da própria escrita no pipe (`WriteFile`, em `fEscreveNoPipe`).

**Instrumentado ainda mais fino em `OnDataReceived`** (`untTefCitelDvcPluginImpl.pas`): loga antes de entrar na critical section, loga logo após obtê-la (confirma que não travou ali) junto com o estado de `FblnPipeConectado`, e loga o resultado explícito de `fEscreveNoPipe` (True/False + `GetLastError` se falhar) antes de decidir o que fazer. Recompilado (`TefCitelDvcPlugin.dproj` Win64, 0 erros).

**Também vale checar em paralelo**: `Get-Process TefEstacaoService` na estação — se aparecer **mais de um processo**, pode haver uma instância antiga/zumbi do serviço ainda viva (de um teste anterior antes da correção do `CancelSynchronousIo`) competindo pela mesma instância do named pipe, o que explicaria o cliente conectando em uma instância que ninguém está lendo de verdade.

**Próximo passo**: só precisa trocar o `TefCitelDvcPlugin.dll` dessa vez (fechar/reabrir a sessão RDP) — o `.exe` do serviço não mudou nesta rodada. Repetir o teste, checar `Get-Process TefEstacaoService` (contagem de processos), e mandar o `TefCitelDvcPlugin.log` atualizado — a nova instrumentação deve mostrar exatamente onde para dentro do `OnDataReceived`.

**Bug real de raiz encontrado e corrigido em 2026-08-24**: confirmado com a instrumentação fina — trava exatamente em `WriteFile` (dentro de `fEscreveNoPipe`), depois de obter a critical section (`FblnPipeConectado=True`, log "chamando fEscreveNoPipe..." é a última linha). Só 1 processo `TefEstacaoService` rodando (`Get-Process` confirmou, PID único) — descartada a hipótese de zumbi. **Causa**: `WriteFile` síncrono num named pipe (sem `FILE_FLAG_OVERLAPPED`) não tem timeout embutido na API — pode bloquear indefinidamente mesmo com os dois lados aparentemente conectados (razão exata do bloqueio nesse ambiente não fechada — pode ser interferência de EDR/AV no I/O do pipe entre sessões, dado o histórico do Bitdefender nesta mesma investigação, ou outra particularidade do named pipe cruzando sessão do serviço/usuário; não investigado a fundo, mas a correção abaixo torna o sistema resiliente independente da causa exata).

**Correção**: novo método `TTefCitelDvcCanalCallback.fEscreveNoPipeComTimeout` (`untTefCitelDvcPluginImpl.pas`) — roda o `WriteFile` de fato numa thread auxiliar dedicada, espera até `TEF_PLUGIN_PIPE_TIMEOUT_ESCRITA_MS` (5000 ms) e, se não retornar a tempo, chama `CancelSynchronousIo` nessa thread auxiliar (mesma técnica já usada pra resolver o travamento do Stop do serviço) — força o `WriteFile` pendente a retornar, o resultado vira "falhou", e o código que já existia (fechar o pipe, enfileirar o frame, deixar a thread de relay reconectar) assume dali. Troca aplicada nos dois call sites de `fEscreveNoPipe` (`OnDataReceived` e `pEsvaziaFilaPendenteJaTravado`) — `fEscreveNoPipe` em si não mudou, só passou a ser chamado de dentro dessa thread auxiliar em vez de diretamente. Recompilado (`TefCitelDvcPlugin.dproj`, Win32 e Win64, MSBuild, 0 erros nos dois).

**Próximo passo**: trocar `TefCitelDvcPlugin.dll` na estação, fechar/reabrir a sessão RDP, repetir o teste de `CFG_TEFDVC = S` no `autcom.exe` de ponta a ponta. Se a escrita ainda travar, agora deve se recuperar sozinha em ~5s (log vai mostrar "forcando cancelamento") e o roteador deve começar a receber o frame na próxima tentativa de reenvio/reconexão; se a escrita não trava mesmo, deve ir direto pra frente e finalmente aparecer "Frame chamada recebido" no `TefEstacaoService.log`.

**Confirmado em campo (2026-08-24)**: o cancelamento disparou ("WriteFile nao retornou em 5000 ms - forcando cancelamento"), mas **depois disso nada mais aconteceu** por >1 minuto (nem reconexão do pipe, nem chegada no roteador) — indício de que `CancelSynchronousIo` pode não estar destravando essa escrita específica de verdade (reforça a suspeita de algo interceptando o I/O do pipe num nível que não responde a cancelamento padrão do Windows — ex.: EDR/AV, o mesmo Bitdefender já visto nesta investigação). O `LthrEscrita.WaitFor` (sem timeout) logo depois do cancelamento também podia travar pelo mesmo motivo.

**Corrigido**: `fEscreveNoPipeComTimeout` agora nunca espera incondicionalmente pela thread auxiliar. Depois do `CancelSynchronousIo`, dá só mais 2s de tolerância; se ainda não terminou, **abandona a thread** (`FreeOnTerminate := True`, ela se limpa sozinha se/quando terminar um dia) em vez de ficar presa esperando. Isso limita `OnDataReceived` a no máximo ~7s no pior caso, garantindo que o plugin nunca trave de verdade — mas **não garante que a mensagem chegue** se essa condição for persistente (não transitória): se toda tentativa de reenvio bater na mesma trava, o `autcom.exe` continua esperando resposta pra sempre do mesmo jeito, só que agora sem travar o plugin internamente. Recompilado (`TefCitelDvcPlugin.dproj`, Win32+Win64, 0 erros).

**Risco residual a observar no próximo teste**: se essa trava se repetir a cada tentativa (não for um glitch isolado), threads abandonadas vão se acumular (vazamento) e a mensagem nunca chega de verdade — nesse caso o próximo passo é tratar como suspeita de EDR/AV de novo (igual à quarentena do `.exe`), pedindo pra infra investigar se o Bitdefender está interceptando/inspecionando esse named pipe especificamente. Se for um glitch isolado (só essa primeira escrita depois de reconectar o pipe), a próxima tentativa deve simplesmente funcionar.

**Próximo passo**: trocar `TefCitelDvcPlugin.dll` de novo na estação, fechar/reabrir a sessão RDP, repetir o teste, e observar se — depois de um possível primeiro travamento/recuperação — uma tentativa seguinte consegue de fato entregar a mensagem (ver "Frame chamada recebido" no `TefEstacaoService.log`) ou se trava sempre.

**Confirmado em campo (2026-08-24)**: a proteção funcionou — `OnDataReceived` não travou mais, abandonou a thread a tempo e seguiu em frente ("enfileirando"). Mas depois disso, **a thread de relay nunca tentou reconectar** (nenhuma linha nova de "tentando reconectar"/"Pipe local conectado" depois do abandono). Causa: **o mesmo padrão de bug já corrigido do lado do serviço também existia no plugin, sem correção** — `pFechaPipeJaTravado` (chamado por `OnDataReceived`, numa thread diferente de `FthrRelay`) fechava o handle do pipe direto, sem `CancelSynchronousIo` antes; isso não garante desbloquear um `ReadFile` pendente na thread de relay, que ficava presa pra sempre e nunca detectava a desconexão pra reconectar.

**Corrigido**: `pFechaPipeJaTravado` agora chama `CancelSynchronousIo(FthrRelay.Handle)` antes de fechar o handle (inofensivo quando chamado da própria `FthrRelay`, sem I/O pendente nela mesma para cancelar). E, pela mesma razão que já vimos o cancelamento nem sempre destravar de verdade neste ambiente, o `Destroy` também não espera mais `FthrRelay.WaitFor` incondicionalmente — dá até 5s e abandona a thread se necessário, em vez de travar a destruição do objeto. Recompilado (`TefCitelDvcPlugin.dproj`, Win32+Win64, 0 erros).

**Próximo passo**: trocar `TefCitelDvcPlugin.dll` de novo, reconectar a sessão RDP, repetir o teste. Agora, mesmo que a primeira escrita trave (like antes), a thread de relay deve conseguir reconectar sozinha depois — o que importa observar é se uma tentativa de reenvio *consegue* entregar a mensagem (chegando "Frame chamada recebido" no `TefEstacaoService.log`) ou se **toda** tentativa trava do mesmo jeito. Se travar sempre, é sinal de condição persistente (não transitória) — aí sim vira caso de investigar interferência de EDR/AV nesse named pipe especificamente, com a infra.

**RESULTADO POSITIVO (2026-08-24) — fluxo completo funcionou de ponta a ponta pela primeira vez**: com os 3 logs alinhados no mesmo teste, confirmado que o dado chegou nos dois casos (`fConfiguraTefCitel` id=1 e `fObtemVersao` id=2) — `Pipe: recebidos 467 bytes` no roteador aconteceu no MESMO instante em que o plugin achou que a escrita tinha "falhado" (timeout de 5s). O `autcom.exe` avançou de `fConfiguraTefCitel` pra `fObtemVersao` — só faria isso recebendo a resposta de verdade. **Conclusão**: a escrita no pipe não trava para sempre — ela é só **lenta na primeira vez logo após o pipe conectar** (~7s), e as escritas seguintes no mesmo pipe já saem quase instantâneas (visto nos reenvios, que completaram em poucos ms). Padrão clássico de uma inspeção de segurança feita uma vez por conexão nova (reforça a suspeita de EDR/AV, mas agora sem ser trava permanente). Como nosso timeout (5s) era menor que essa demora real, cancelávamos a escrita cedo demais e reenviávamos achando que tinha falhado — resultado: `fConfiguraTefCitel` e `fObtemVersao` foram processados 2x cada do lado da estação (não é problema de corretude aqui — os métodos observados são idempotentes — mas é desperdício e mascarava o diagnóstico).

**Ajuste final**: `TEF_PLUGIN_PIPE_TIMEOUT_ESCRITA_MS` subiu de 5000 para **15000 ms** — margem confortável acima da demora observada (~7s), pra parar de classificar como "falha" uma escrita que só está lenta mas vai completar sozinha. Recompilado (`TefCitelDvcPlugin.dproj`, Win32+Win64, 0 erros).

**Próximo passo**: trocar `TefCitelDvcPlugin.dll` uma última vez, reconectar a sessão RDP, repetir o teste completo de `CFG_TEFDVC = S` (crédito/débito de verdade, não só o `fConfiguraTefCitel`/`fObtemVersao` de inicialização). Com a margem maior, a expectativa é processamento único (sem duplicação) e sem nenhuma desconexão/reconexão no meio — se isso se confirmar, dá pra seguir pro roteiro de teste completo (seção Fase 3, critérios de aceitação de specs.md).

---


### PARADA EM 2026-08-24 — retomar aqui em nova sessão

Rafael vai mandar um log maior (teste mais completo, crédito/débito de verdade) numa sessão nova, pra não pesar esta. **Estado exato ao pausar**: `TefCitelDvcPlugin.dll` recompilado com `TEF_PLUGIN_PIPE_TIMEOUT_ESCRITA_MS = 15000` (Win32+Win64, 0 erros) — ainda **não testado** com essa margem nova; o teste anterior (com 5000ms) já tinha funcionado de ponta a ponta (`fConfiguraTefCitel` + `fObtemVersao`, ver achado "RESULTADO POSITIVO" logo acima), só com duplicação por causa do timeout curto.

**Ao retomar**: pedir o log grande que o Rafael for mandar (provavelmente os 3 de sempre — `TefCitelDvcPlugin.log`/estação, `TefCitelDvcTransporte.log`/servidor, `TefEstacaoService.log`/estação) e conferir: (1) se sumiu a duplicação de `fConfiguraTefCitel`/`fObtemVersao`; (2) se o roteiro de crédito/débito completo (`CFG_TEFDVC = S`, seção 6 de specs.md) passa sem cair; (3) se aparecer qualquer novo travamento, o padrão já estabelecido nesta sessão é: instrumentar com log no ponto exato, depois corrigir com `CancelSynchronousIo`/thread auxiliar com timeout (já usado 3x: Stop do serviço, escrita no pipe do plugin, fechamento do pipe do plugin) — não reinventar, seguir o mesmo molde se aparecer mais um caso parecido.

- [ ] Executar a suite de validação manual (roteiro descrito a partir dos critérios de aceitação de specs.md, seção 6):
  - [x] `CFG_TEFDVC = N` — regressão zero em Scope/NCR e SiTef Express. — testado por Rafael em 2026-08-20: TEF funcionando normalmente com a flag desligada (branch `TTefCitelDvc` nem é exercitado nesse caminho, mas confirma que a alteração de assinatura de `fCriarTefCitel`/leitura de `CFG_TEFDVC` em `untTefCitelUtil.pas` não introduziu regressão).
  - [ ] `CFG_TEFDVC = S` — crédito à vista/parcelado loja/parcelado administradora/débito (comum e Banrisul, cobrindo o sub-wizard à vista/pré-datado/parcelado/crédito 1 minuto) via serviço da estação, sem redirecionamento de porta COM.
  - [ ] Fluxo Pix via PinPad com serviço local.
  - [ ] Queda de canal DVC durante transação em andamento — resultado preservado e sincronizado sem duplicidade.
  - [ ] Atualização de `scope.zip`/`sitef.zip` aplicada corretamente na estação, sem interromper transação ativa.
  - [ ] Estação sem mudança nos `.zip` não sofre ação alguma (idempotência por hash).


### Retomado em 2026-08-24 (sessão nova) — log completo de crédito/débito analisado

Recebidos os 4 logs do teste completo (`TefCitelDvcPlugin.log`/estação, `TefEstacaoService.log`/estação-roteador+pipe, `TefCitelDvcTransporte.log`/servidor-autcom, e o log nativo do Scope/CliSiTef) da janela 15:47–15:58. Achados, cruzando os 4:

**1) A duplicação NÃO sumiu com o timeout de 15000ms — e agora atinge `fPassarCartao` também.** Nos 3 métodos observados (`fConfiguraTefCitel` id=1, `fObtemVersao` id=2, `fPassarCartao` id=3), a escrita no pipe local (lado plugin) bateu o teto de 15000ms e foi cancelada nas 3 vezes (`15:50:30.208→15:50:45.208`, `15:52:41.844→15:52:56.846`, `15:55:43.143→15:55:58.152` — sempre ~15000ms exatos), forçando reenvio e reconexão. Cada reenvio chegou à estação como uma SEGUNDA chamada com o mesmo `id`, e o roteador despachou de novo (visível como "Despachando... (id=N)" duplicado no `TefEstacaoService.log`).

Isso invalida a hipótese anterior ("~7s, custo único por conexão nova, 15000ms de margem é suficiente") — aqui a demora bateu o teto nas 3 tentativas, não só na primeira depois de reconectar. Como o design fecha e reabre o pipe a cada mensagem (uma conexão por chamada), TODA escrita é "primeira depois de reconectar" — se a causa (suspeita de EDR/AV) demora ≥15s de forma consistente (não ~7s como no teste anterior), o ciclo se realimenta: timeout → fecha/reconecta → próxima escrita sofre a mesma penalidade → timeout de novo. Isso explica a lentidão e o reenfileiramento reportados pelo Rafael.

**2) Risco novo, mais sério: `fPassarCartao` foi duplicado igual aos outros — mas ele NÃO é idempotente como `fConfiguraTefCitel`/`fObtemVersao`.** O log do roteador mostra `fPassarCartao` (id=3) despachado e concluído duas vezes de ponta a ponta (`15:52:58.859→15:55:41.086`, depois `15:55:43.090→15:58:25.225` — ~2m40s cada), e o log nativo do Scope confirma DUAS chamadas `ScopeOpen` completas e independentes (`15:53:28`/`15:56:13`), cada uma tentando o ciclo completo de transação. A suposição registrada acima ("não é problema de corretude, os métodos observados são idempotentes") não se sustenta para este método — repetir uma transação de cartão de verdade não é seguro do mesmo jeito que repetir `fObtemVersao`. Precisa de uma trava de deduplicação por `id` do lado do roteador da estação (ou equivalente) antes deste método rodar em produção, independente da causa raiz do atraso.

**3) Achado separado, ainda não investigado: as duas tentativas de `ScopeOpen` FALHARAM.** O log nativo do Scope/CliSiTef mostra, nas duas vezes, `ConectaServidorScope`/`RecebeDadosServidor` retornando `65280 (0xFF00)` — a biblioteca não conseguiu se conectar ao servidor da adquirente/TEF a partir da porta COM6 configurada. Isso é independente do bug de duplicação do pipe (a causa de `fPassarCartao` demorar ~2m40s por tentativa é essa falha de conexão, tentando e desistindo, não o canal DVC) e pode ser um problema de rede/ambiente da estação de teste, não do código desta feature. Não investigado ainda.

**Próximo passo, a decidir com o Rafael:** (a) atacar a causa raiz do timeout de 15s primeiro — aumentar ainda mais a margem não resolve se a demora real também crescer; considerar reprojetar para não fechar/reabrir o pipe a cada mensagem (conexão persistente, só o framing por tamanho separando as mensagens); (b) adicionar deduplicação por `id` no roteador da estação como rede de segurança, independente da causa raiz do atraso (mitiga o risco do item 2 mesmo que o atraso do pipe nunca seja 100% eliminado); e/ou (c) investigar com a equipe de rede/infra por que `ConectaServidorScope` falhou nas duas tentativas (item 3 — pode nem ser bug desta feature).

**Decisão do Rafael:** atacar primeiro o item (a) — reprojetar o pipe para não fechar/reabrir a cada mensagem.

**Reprojetado em 2026-08-24 — `untTefCitelDvcPluginImpl.pas` (plugin cliente)**: removido por completo o mecanismo de timeout sobre o `WriteFile` (thread auxiliar + `CancelSynchronousIo` + abandono após 15s, introduzido na sessão anterior). Causa de tê-lo removido: mesmo com a margem em 15000ms, as 3 chamadas do teste completo (`fConfiguraTefCitel`/`fObtemVersao`/`fPassarCartao`) bateram o teto nas 3 vezes — a demora real não é um custo fixo de ~7s como a sessão anterior concluiu, e qualquer timeout artificial sobre uma escrita que só está lenta (não morta) continua gerando reenvio duplicado, agora confirmado inclusive em `fPassarCartao` (não idempotente).

Substituído por uma thread dedicada de escrita (`FthrEscritaWorker`), criada uma única vez no construtor (não a cada reconexão, ao contrário de `FthrRelay`) e viva por toda a vida do callback: consome `FlstPendente` em ordem, uma escrita de cada vez, sem timeout nenhum sobre o `WriteFile` em si — só avança pro próximo frame depois que a escrita atual retorna (nunca dois `WriteFile` simultâneos no mesmo handle). `OnDataReceived` não escreve mais nada diretamente — só enfileira o frame recebido do canal DVC e sinaliza um `TEvent` (`FevtNovoFramePendente`) para acordar o worker; a thread do callback do canal DVC nunca mais bloqueia em I/O de pipe. Uma escrita lenta agora só atrasa quem está atrás dela na fila — nunca mais é tratada como falha. Só um erro de verdade devolvido pelo `WriteFile` (não demora) aciona `pFechaPipeJaTravado` (desconexão real → fila local + reconexão via `FthrRelay`, mecanismo RF07 inalterado). `pFechaPipeJaTravado` ganhou um segundo `CancelSynchronousIo` (para `FthrEscritaWorker`, além do já existente para `FthrRelay`) para o caso de precisar desbloquear uma escrita realmente travada durante uma desconexão forçada (`Destroy`/`OnClose`). `TEF_PLUGIN_PIPE_TIMEOUT_ESCRITA_MS` e o método `fEscreveNoPipeComTimeout`/`pEsvaziaFilaPendenteJaTravado` foram removidos (não fazem mais sentido no novo design). Escopo da mudança: só esta unit — lado servidor (`untTefEstacaoPipeTransporte.pas`) e `autcom.exe` (`untTefCitelDvcTransporte.pas`) não foram tocados.

**Recompilado em 2026-08-24** (`TefCitelDvcPlugin.dproj`, Win32+Win64, MSBuild + `dcc32`/`dcc64` de `Studio\17.0` = Seattle, `Config=Debug`): 1 erro encontrado e corrigido — `GetTickCount64` não é declarada em `Winapi.Windows` nesta versão do Delphi (mesma situação já conhecida de `CancelSynchronousIo` na mesma unit); declarada externamente (`external 'kernel32.dll'`) junto dela. Recompilado limpo nas duas plataformas: **0 erros, 0 avisos** em Win32 e Win64. Ainda **não testado em campo** — só compilação verificada.

**Testado em campo em 2026-08-24 — resultado misto.** Primeiro achado bom: **sem duplicação de despacho** — `fConfiguraTefCitel` (id=1) rodou uma única vez na estação na primeira tentativa. O redesenho do worker de escrita se comportou como projetado.

Achado novo, mais preocupante: a escrita no pipe demorou **77,6s** nessa tentativa (medida limpa, sem interrupção) — bem pior que os ~7s da sessão de sexta. O Rafael, sem nenhum feedback visual na tela de "Verificando exigências do TEF..." por mais de um minuto, reiniciou o `autcom.exe` manualmente achando que tinha travado (confirmado por ele) — o que fechou o canal DVC e recriou `TTefCitelDvc`/`TTefCitelDvcTransporte` do zero (`pIniciaTefCitel` em `untTefCitelUtil.pas`, linha ~748: `objTefCitel := Nil` antes de criar de novo), reenviando o mesmo `fConfiguraTefCitel` (id=1 de novo, contador reiniciado). Essa segunda tentativa (91s, erro 233/pipe desconectado) foi contaminada pelo próprio reinício no meio — não é uma medida confiável da demora real. **Não há nenhum watchdog automático de tempo no código** nessa cadeia (`fChamaRpc` continua esperando `INFINITE`, conforme a regra `IA\rules\tef-dvc.md`) — a causa da reconexão foi 100% ação manual do operador.

**Conclusão prática**: o bug de duplicação está corrigido, mas o sintoma de campo (operador reiniciando por parecer travado) continua, porque a demora real da escrita no pipe (suspeita de EDR/AV, ainda não confirmada com a infra) segue sem teto conhecido e sem nenhum feedback de progresso na tela durante a espera — exatamente o cenário que `IA\rules\tef-dvc.md` já previa: a chamada não pode ter timeout, então a UX precisa tolerar a espera em vez de brigar com ela.

Próximo passo, a decidir: (a) adicionar feedback visual de progresso durante `pIniciaTefCitel`/`fConfiguraTefCitel` (ex.: "Aguardando resposta da estação...") para o operador não sentir necessidade de reiniciar no meio de uma chamada que ainda vai responder; e/ou (b) investigar com a infra a causa da demora de 77s+ na escrita do pipe (suspeita de EDR/AV, já sinalizada em plans.md seção 6).

**Repetido em 2026-08-24, ~17:02 — demora subiu pra 234s, e o Rafael notou um padrão que muda a análise**: "só destrava quando eu fecho o autcom.exe, não está com cara de antivírus bloqueando". Investigado: descartada a hipótese de o roteador da estação estar ocupado antes de começar a ler (`pOnConectado`/`pReenviaFilaLocal` só reenvia fila local de transação pendente, vazia neste teste — não explicava a demora).

**Bug real de raiz encontrado, corrigido em 2026-08-24**: `pFechaPipeJaTravado` (chamado por `Destroy`, de outra thread) fechava `FhndPipe` mesmo com um `WriteFile` ainda pendente em `FthrEscritaWorker`. Fechar um handle com I/O síncrono pendente em OUTRA thread é comportamento indefinido no Win32 — era exatamente isso que fazia a escrita presa "completar com sucesso" bem no instante em que o `autcom.exe` era fechado (o `CloseHandle` concorrente forçava o retorno do `WriteFile`, não a escrita terminando sozinha). Confirma a leitura do Rafael: não tem cara de antivírus porque não era — era uma corrida no nosso próprio código.

**Correção** (`untTefCitelDvcPluginImpl.pas`): `fEscreveNoPipe` passou a receber o handle por parâmetro (captura local, imune a `FhndPipe` mudar de valor embaixo dela). Novo flag `FblnEscritaEmAndamento`, marcado antes de soltar o lock pra bloquear no `WriteFile`. `pFechaPipeJaTravado` agora **nunca** fecha um handle que `FthrEscritaWorker` possa estar usando — só abandona a referência (handle real continua aberto, sem `CloseHandle`). O próprio `FthrEscritaWorker` fecha o handle antigo sozinho, no único momento seguro: quando seu `WriteFile` finalmente devolve o controle pra ele. Custo aceito, documentado no cabeçalho da unit: se uma escrita nunca retornar, o handle vaza pelo resto da vida do processo, e nenhum frame novo sai por esse canal até o objeto ser recriado — o worker é uma única thread (não dá pra paralelizar escritas no mesmo pipe em modo byte sem risco de intercalar bytes), então uma escrita presa trava a fila inteira até a próxima reconexão de canal.

Recompilado (`TefCitelDvcPlugin.dproj`, MSBuild, Win32+Win64): **0 erros, 0 avisos** nas duas plataformas.

**Causa raiz da demora em si (77s → 234s, crescendo) ainda em aberto** — a corrida acima explicava por que a escrita "completava" só ao fechar o autcom.exe, mas não explica por que o `WriteFile` trava tanto tempo pra começo de conversa. Combinado com o Rafael: próxima vez que travar, capturar Procmon (Sysinternals) filtrado no processo do plugin (`mstsc.exe`/TSPlus) e no `TefEstacaoService.exe`, olhando o `WriteFile`/`ReadFile` em `\Device\NamedPipe\TefCitelCh`, **antes** de fechar o `autcom.exe` — évidência direta em vez de inferência pelos logs.

**Investigação com Procmon (2026-08-24) — sem sucesso direto, mas achados úteis:**
- Filtro por `Path contains TefCitelCh` não capturou nada, mesmo confirmado que a captura geral funcionava na estação certa (o pipe é local à estação, `TefEstacaoService.exe`/pinpad/COM6). Trocado para filtro por `Process Name` (`TefEstacaoService.exe` / `mstsc`) — mesmo assim, **nenhuma operação no pipe apareceu na janela inteira de captura (~2 min)**, apesar de atividade clara do plugin (log em `%TEMP%\TefCitelDvcPlugin.log` gravando normalmente) e de um par de threads (`2488`/`11192`) criado e destruído em ~32s dentro dessa janela — coerente com `FthrRelay`+`FthrEscritaWorker` de uma tentativa de conexão nova. **Explicação**: o Procmon clássico só lista uma operação quando ela COMPLETA — uma operação genuinamente presa (sem nunca retornar) fica invisível, nunca aparece nem como "pendente". Reforça que a trava não é uma demora limitada, é possivelmente sem fim.
- **Achado à parte, não relacionado à trava**: `Process Explorer` mostrou **3 DLLs de plugin DVC diferentes carregadas ao mesmo tempo** dentro do `mstsc.exe` da estação: a nossa (`C:\TEF_Citel\TefCitelDvcPlugin.dll`), e duas sobras de protótipos de sessões anteriores (`C:\TEFCitel\CitelTefDvcPlugin.dll` — canal `"CITELTEF"` — e `C:\TEFCitel\DVC\DVC\bin\Win64\Debug\TefDvcClient.dll` — canal antigo `"TefVitelCh"`). **Confirmado que não há conflito de nome de canal** com o nosso (`"TefCitelCh"`) — descarta a hipótese de disputa direta pela conexão. Ainda assim, orientado o Rafael a desregistrar os dois (`regsvr32 /u` nos dois caminhos) por higiene — três DLLs sem assinatura mexendo em pipe/canal virtual no mesmo processo é ruído desnecessário.
- **Process Explorer, pilha de thread travada ao vivo (2026-08-24)** — capturado nas duas direções ao mesmo tempo numa mesma trava: `FthrRelay` preso dentro de `ReadFile` e `FthrEscritaWorker` preso dentro de `WriteFile`, ambos genuinamente bloqueados no kernel (cadeia de símbolos de espera/lock: `KeWaitForMutexObject`/`ExAcquirePushLockSharedEx`/`ExReleaseFastMutex`) — **as duas direções do pipe emperradas ao mesmo tempo**, não só uma. Símbolos do Process Explorer não estavam configurados corretamente (deslocamentos gigantes tipo `+0x7d66`, um quadro `0x0000000000000000` — pilha quebrada) — não dá pra confiar nos nomes de função do meio da pilha nem confirmar/descartar um driver de terceiro (ex.: Bitdefender) por essa via ainda.

**Próximo passo combinado**: em vez de insistir em symbolizar localmente, pedir à infra o log/console do Bitdefender GravityZone para essa estação nos horários exatos das travas (temos timestamps precisos nos 3 logs da aplicação) — mais rápido e definitivo que continuar via Process Explorer. Em paralelo, testar deixando travado por bem mais tempo (10+ min) sem mexer em nada, pra distinguir "muito lento" de "realmente sem fim".

**Solicitação enviada à infra (2026-08-24)**: pedido de exclusão temporária nos módulos comportamentais do Bitdefender (Advanced Threat Control/ATC e HyperDetect) para `TefCitelDvcPlugin.dll`, `TefEstacaoService.exe` e o processo `mstsc.exe`, só na estação `CTLDSDEVRP2470`, para teste controlado.

**2026-08-27 — infra removeu o Bitdefender da estação por completo** (não só exclusão pontual). Teste controlado ideal: se a demora no pipe sumir agora, confirma o Bitdefender como causa; se persistir, descarta o Bitdefender por completo e a investigação precisa mudar de direção (ex.: limitação genuína do Windows com named pipe cruzando sessão 0/sessão interativa, sem EDR nenhum envolvido). Rafael vai repetir o teste — próximo passo é conferir os 3 logs de sempre (tempo de escrita no `pLoopEscritaWorker`, se `fConfiguraTefCitel`/`fObtemVersao`/`fPassarCartao` completam sem duplicação e em tempo normal) e reportar.

**Bitdefender removido, trava idêntica (2026-08-27)**: 175047 ms pra escrever 468 bytes (`fConfiguraTefCitel`) — dentro da mesma faixa errática de sempre (77s/91s/234s). Descarta o Bitdefender como causa única — a demora é a mesma sem ele.

**Eliminação sistemática de causas externas nesta mesma estação (`CTLDSDEVRP2470`), todas com sessão RDP fechada e reaberta do zero entre cada mudança (confirmado pelo Rafael)**:
- Windows Defender com proteção em tempo real desligada (print do Segurança do Windows confirmando) — trava igual.
- Sensor MDE (`Sense`) parado, sem processo `MsSense` rodando — trava igual.
- Serviço "USB Redirector TS Edition" (SimplyCore LLC, também mexe em canal virtual de RDP) parado — trava igual.
- RDP Shortpath/UDP — `netstat -p udp | findstr :3389` sem nenhuma linha (não está em uso nessa conexão) — descartado.

**Teste decisivo (2026-08-27): pipe isolado, fora do `mstsc.exe`.** Script PowerShell simples (`NamedPipeClientStream` direto no `TefCitelCh`, sem passar pelo plugin nem pelo `autcom.exe`) — conectou em 27ms, escreveu em 51ms. **O pipe, o `TefEstacaoService.exe` e o SO estão saudáveis** — não existe nada travando o pipe de forma genérica (se existisse, esse teste também teria travado). O problema está especificamente em como o *nosso código* faz essa chamada dentro do `mstsc.exe`.

**Build de diagnóstico temporário criado (2026-08-27, `untTefCitelDvcPluginImpl.pas`, marcado com comentário "DIAGNOSTICO TEMPORARIO ... REMOVER apos o teste")**: única variável ainda não isolada — se a demora é específica de threads que *nós* criamos (`FthrEscritaWorker`, via `TThread.CreateAnonymousThread`) rodando dentro do `mstsc.exe`, ou se acontece igual numa escrita síncrona direto na própria thread de callback do canal DVC (fornecida pelo framework do `mstsc.exe`, não criada por nós). `OnDataReceived` agora tenta a escrita direta, síncrona, nessa thread de callback (só quando pipe conectado + worker ocioso + fila vazia — que é sempre o caso no cenário de teste de uma chamada isolada) e loga: `"[DIAGNOSTICO] tentando escrita direta..."` / `"...concluida em X ms"` / `"...FALHOU apos X ms"`. Recompilado (Win32+Win64, MSBuild, 0 erros/0 avisos). **Ainda não testado em campo.**

Próximo passo: Rafael troca a DLL na estação, reabre a sessão RDP, repete o teste do `fConfiguraTefCitel`, e manda o `TefCitelDvcPlugin.log` — se a escrita direta (`[DIAGNOSTICO] escrita direta concluida em X ms`) for rápida (poucos ms), confirma que o problema é específico de thread criada por nós; se demorar igual (minutos), o problema é do `mstsc.exe`/canal DVC em geral, não das nossas threads. Reverter esse trecho de diagnóstico depois do teste (não é pra produção).

**Testado em 2026-08-27 — escrita direta na thread de callback também travou** ("ficou travada", confirmado pelo Rafael). Descarta de vez a hipótese de "thread criada por nós" — o mesmo travamento acontece na própria thread de callback do canal DVC, fornecida pelo `mstsc.exe`. O denominador comum que sobra é só rodar dentro do `mstsc.exe`.

**Segundo diagnóstico acrescentado (2026-08-27, mesma unit)**: teste auto-contido com `CreatePipe` (pipe anônimo, sem nome, sem `TefEstacaoService.exe`, sem cruzar sessão) — chamado uma vez no início de `OnDataReceived`, antes de qualquer coisa relacionada ao pipe real (`TefCitelCh`). Separa duas hipóteses: (a) é **qualquer** I/O de pipe de dentro do `mstsc.exe` que sofre isso, não importa o alvo (aponta pra solução arquitetural — tirar o I/O de dentro do `mstsc.exe`, delegar pra um processo auxiliar separado); ou (b) é especificamente esse pipe cruzando sessão 0/sessão interativa (aponta pra investigar essa fronteira específica). Loga `[DIAGNOSTICO] pipe anonimo: escrita concluida em X ms` (ou `FALHOU`) — resultado sai quase na hora, não precisa esperar a trava real completar. Recompilado (Win32+Win64, MSBuild, 0 erros/0 avisos). **Ainda não testado em campo.**

**Testado em 2026-08-27 — resultado decisivo**: pipe anônimo (auto-contido, dentro do próprio `mstsc.exe`, sem `TefEstacaoService.exe`, sem cruzar sessão) **escreveu em 0 ms**. Na sequência, a escrita direta no pipe real (`TefCitelCh`, cruzando pra sessão 0) travou de novo ("ficou travado"). **Descarta "qualquer I/O de pipe dentro do mstsc.exe" como causa** — só trava quando cruza pra fora do processo, especificamente pra sessão 0/LocalSystem.

**Terceiro diagnóstico acrescentado (2026-08-27, mesma unit)**: separa se é especificamente cruzar pra sessão 0 (LocalSystem), ou se é qualquer pipe nomeado indo pra **outro processo**, mesmo que esse processo esteja na mesma sessão do `mstsc.exe` (não seja serviço). Depende de um script PowerShell rodando como servidor de um pipe de teste (`TefDiagTeste`) na sessão interativa **antes** do teste disparar:
```powershell
$pipeServer = New-Object System.IO.Pipes.NamedPipeServerStream("TefDiagTeste", [System.IO.Pipes.PipeDirection]::InOut)
Write-Host "Aguardando conexao..."
$pipeServer.WaitForConnection()
Write-Host "Conectado! Aguardando dados..."
$buffer = New-Object byte[] 1024
$bytesRead = $pipeServer.Read($buffer, 0, $buffer.Length)
Write-Host "Recebeu $bytesRead bytes."
$pipeServer.Close()
```
Se o script não estiver rodando quando o teste disparar, só loga a falha do `CreateFile` (esperado, sem travar nada) — precisa rodar o script primeiro, deixar esperando ("Aguardando conexao..."), só então disparar o teste do `fConfiguraTefCitel`. Loga `[DIAGNOSTICO] pipe nomeado (mesma sessao): escrita concluida em X ms` (ou `FALHOU`). Recompilado (Win32+Win64, MSBuild, 0 erros/0 avisos). **Ainda não testado em campo.**

**Testado em 2026-08-27 — resultado definitivo**: pipe nomeado, mesma sessão, `mstsc.exe → PowerShell` (script corrigido com ACL explícita via SID `WorldSid`, já que `"Everyone"` como string não resolveu nesse ambiente — `IdentityNotMappedException`) — **escreveu em 0 ms**, confirmado dos dois lados (nosso log + PowerShell recebendo os 16 bytes). Triangulação final, juntando os três testes:

| Cliente | Servidor | Resultado |
|---|---|---|
| Processo externo (PowerShell) | `TefEstacaoService.exe` (sessão 0/LocalSystem) | Rápido (dezenas de ms) |
| `mstsc.exe` | pipe anônimo/nomeado, mesma sessão | Rápido (0 ms) |
| `mstsc.exe` | `TefEstacaoService.exe` (sessão 0/LocalSystem) | Trava (minutos, sempre) |

Nenhum fator isolado explica — só a combinação exata "`mstsc.exe` como cliente cruzando pra sessão 0" trava. Causa raiz exata (por que o `mstsc.exe` sofre isso) não identificada — provavelmente interno ao framework de canal DVC/RDP do Windows nessa combinação especifica, fora do nosso controle de código.

**Decisão de arquitetura (2026-08-27, Rafael)**: seguir com processo relay de sessão, opção (a) — plugin sobe o relay sob demanda via `CreateProcess`. Desenho completo em `plans.md`, seção 7.

**Cogitado e descartado**: trocar pipe por memória compartilhada — a sincronização cross-sessão exigiria objetos `Global\` (Event/Mutex) sujeitos, em princípio, à mesma categoria de travamento (nunca testado, mas sem motivo pra achar que seria diferente), além de superfície de segurança maior (parsing manual de buffer bruto em vez do framing já validado). Ver `plans.md` seção 7 para o racional completo.

**Diagnóstico revertido (2026-08-27)**: as 3 instrumentações temporárias em `untTefCitelDvcPluginImpl.pas` (`pTesteDiagnosticoPipeAnonimo`, `pTesteDiagnosticoPipeNomeadoMesmaSessao`, e o desvio de escrita direta em `OnDataReceived`) foram removidas — `OnDataReceived` voltou a ser só "enfileira e acorda o worker", com um comentário novo documentando o achado (aponta pra `plans.md` seção 7 em vez de reexplicar). Recompilado (Win32+Win64, MSBuild, 0 erros/0 avisos) — este é o estado limpo, sem diagnóstico, que a próxima sessão vai encontrar.

---


### PARADA EM 2026-08-27 — retomar aqui em nova sessão, iniciando a implementação

**Não é mais investigação — é implementação.** Desenho já fechado e aprovado pelo Rafael: `plans.md`, seção 7 ("Redesenho da comunicação plugin↔estação: processo relay de sessão"), opção (a) confirmada (plugin sobe o relay sob demanda).

**Ao retomar, ler primeiro**: `plans.md` seção 7 inteira (desenho, diagrama de dois saltos, os 5 pontos já decididos). Depois quebrar em tarefas concretas neste arquivo (novo grupo, ex. "Processo relay de sessão"), cobrindo pelo menos:
- Nova unit(s)/`.dpr` do relay (`TefCitelDvcRelay.exe`) — lado servidor (aceita o plugin em `TefCitelChRelay`, reaproveitando o formato de `untTefEstacaoPipeTransporte.pas`) + lado cliente (conecta em `TefCitelCh` de verdade — avaliar se precisa da mesma engenharia de "geração abandonada" do plugin, ou se um cliente síncrono simples basta, já que esse salto especificamente não é o `mstsc.exe` iniciando).
- Ajuste no plugin (`untTefCitelDvcPluginImpl.pas`) — trocar o alvo de `TefCitelCh` para `TefCitelChRelay`; adicionar a lógica de subir o relay sob demanda (`CreateProcess` se `CreateFile` falhar com `ERROR_FILE_NOT_FOUND`); avaliar se `FthrEscritaWorker`/lógica de geração abandonada ainda se justifica nesse novo salto (mesma sessão, já provado rápido) ou pode simplificar.
- Scripts de instalação — confirmar se o `TefCitelDvcRelay.exe` entra na mesma pasta flat já estabelecida (`libTefCitel\Estacao\install\`), sem novo item de registro (opção (a) não precisa).
- Build — novo grupo no `autcom.groupproj`/projeto próprio do relay, a definir.
- Teste manual — roteiro completo de novo (`CFG_TEFDVC = S`, `fConfiguraTefCitel`/`fObtemVersao`/`fPassarCartao`), confirmando que a demora sumiu.

Antes desse achado, o próximo passo era: trocar a DLL na estação, fechar/reabrir a sessão RDP, repetir o teste completo de crédito/débito (`CFG_TEFDVC = S`) e conferir nos 3 logs de sempre: (1) `fConfiguraTefCitel`/`fObtemVersao` despachados uma única vez cada (sem duplicação); (2) `fPassarCartao` despachado uma única vez; (3) se alguma escrita realmente demorar bastante, o log deve mostrar `pLoopEscritaWorker: escrita de N bytes concluida em X ms` (sem fechar/reconectar o pipe no meio) em vez do padrão antigo de timeout+reenvio. Itens (b) deduplicação por `id` no roteador e (c) investigação do `ConectaServidorScope`/erro 65280 continuam em aberto, não descartados — só não atacados nesta rodada.


### Processo relay de sessão (implementado em 2026-08-27, ainda não testado em campo)

Desenho de `plans.md` seção 7, opção (a). Código novo:

- [x] `libTefCitel\Estacao\Relay\untTefCitelDvcRelayImpl.pas` — classe `TTefCitelDvcRelay`: lado servidor aceita o plugin em `\\.\pipe\TefCitelChRelay` (padrão de loop aceitar/reconectar de `untTefEstacaoPipeTransporte.pas`, sem a extração de frame — relay puro de bytes); lado cliente conecta em `\\.\pipe\TefCitelCh` de forma síncrona simples (sem a engenharia de fila/geração abandonada do plugin — este salto já foi comprovado rápido). Bombeamento bidirecional em duas threads dedicadas (`pBombeiaServidorParaCliente`/`pBombeiaClienteParaServidor`), com desligamento coordenado via `CancelSynchronousIo` (`pEncerraRodada`) quando um lado cai. Sem mecanismo de parada graciosa do processo em si (Ctrl+C/SCM) — decisão de escopo desta sessão, ver nota no cabeçalho da unit: processo comum, sem estado a persistir além do log, sem script de instalação próprio, encerra com a sessão interativa. Log em `TefCitelDvcRelay.log`, ao lado do próprio exe.
- [x] `libTefCitel\Estacao\Relay\TefCitelDvcRelay.dpr`/`.dproj` — `AppType=Console`, `FrameworkType=None` (mesmo padrão de leveza do `TefCitelDvcPlugin.dproj`), plataforma única Win32 (não precisa casar bitness com o `mstsc.exe` — é um processo separado, não uma DLL carregada nele). **Ainda não aberto/compilado na IDE** — pendente de verificação de compilação (Passo 6 da skill de implementação).
- [x] `libTefCitel\Estacao\ClientPlugin\untTefCitelDvcPluginImpl.pas` — `TEF_PLUGIN_PIPE_NOME` trocado de `TefCitelCh` para `TefCitelChRelay`; nova `fSobeRelaySobDemanda` (via `CreateProcess`, `CREATE_NO_WINDOW` redeclarada localmente pela mesma cautela de sempre nesta unit) chamada de `fTentaConectarPipe` quando `CreateFile` falha com `ERROR_FILE_NOT_FOUND`. `FthrEscritaWorker`/fila de pendentes **mantidos sem alteração** — o cenário que motivou essa engenharia (escrita presa cruzando pra sessão 0) não afeta mais este salto (mesma sessão), mas `plans.md` item 5 deixou a simplificação como "avaliar sem pressa", não decisão fechada; ver nota adicionada no cabeçalho da unit. Cabeçalho e comentários atualizados para refletir a arquitetura de dois saltos.
- [ ] **Não avaliado ainda**: scripts de instalação (`Estacao\install\*.ps1`) — opção (a) não precisa de novo item de registro, mas falta confirmar se `TefCitelDvcRelay.exe` precisa ser mencionado em algum script (ex.: nenhum, já que sobe sob demanda) ou só precisa estar fisicamente na mesma pasta flat.
- [ ] **Não avaliado ainda**: `padra_atualizado\autcom.groupproj` — nem `TefEstacaoService.dproj` nem `TefCitelDvcPlugin.dproj` estão incluídos nele hoje (confirmado nesta sessão, `grep` sem resultado) — item já estava em aberto antes deste grupo de tarefas (ver "Build" acima); `TefCitelDvcRelay.dproj` não foi adicionado por ora, mesma situação dos dois projetos irmãos.
- [ ] Compilar os 3 projetos (`TefCitelDvcRelay.dproj`, `TefCitelDvcPlugin.dproj`, `TefEstacaoService.dproj` — este último não muda, mas usa `fCriarTefCitel`/units compartilhadas do mesmo diretório) na IDE e corrigir os gotchas de compilação que aparecerem (seguir o padrão já mapeado em memória: `CancelSynchronousIo`/`GetTickCount64` não declaradas, etc.).
- [ ] Copiar `TefCitelDvcRelay.exe` para a pasta de instalação flat da estação (`C:\TEF_Citel\`) junto com o `TefCitelDvcPlugin.dll` atualizado.
- [x] Teste manual de ponta a ponta (2026-08-27, Rafael) — **funcionou parcialmente**. Ver achado abaixo.

**Achado do primeiro teste de campo (2026-08-27): pedido rápido, resposta nunca chegou.** Com os 3 componentes compilados (plugin/relay em Win64, service em Win32 — sem problema, comunicação é só por named pipe, agnóstico a bitness) e `CFG_TEFDVC = S`, `fConfiguraTefCitel`:

- Pedido percorreu autcom.exe → plugin → relay → serviço em ~730ms (log do plugin: `pLoopEscritaWorker: escrita de 468 bytes concluida em 0 ms`).
- `FRealInstance.fConfiguraTefCitel` (DLL nativa do Scope) rodou de verdade contra o pinpad físico e retornou sucesso em ~3s (`TefEstacaoService.log` + `ScopeTrc.txt` batem no horário).
- Depois de `Metodo "fConfiguraTefCitel" (id=1) retornou com sucesso.`, **silêncio total** nos 4 logs por ~1m36s, até o autcom.exe desistir, fechar o canal DVC, e a cadeia inteira cair em cascata (erro 109/pipe quebrado).

**Diagnóstico**: `untTefEstacaoPipeTransporte.pas`, `pEnviaFrame` (linha ~320) faz um `WriteFile` **síncrono, sem timeout, sem thread dedicada**, chamado direto na mesma thread que lê o pipe (`pLoopServidor` → `pOnFrameRecebido` → ... → `pEnviaFrame`) — exatamente a mesma classe de problema já corrigida 3x do lado do plugin (`FthrEscritaWorker`), nunca replicada para o lado do envio de resposta do serviço. Hipótese: a mesma lentidão de I/O cruzando sessão (causa raiz nunca fechada, Bitdefender já descartado) pode afetar a direção reversa (LocalSystem escrevendo para fora), nunca isolada nos testes de triangulação anteriores (que só testaram request, não response).

**Não confirmado 100% pelos logs desta rodada** - `pEnviaFrame` nunca logou nada (nem sucesso nem duração), e os saltos seguintes (relay lendo de `TefCitelCh`/escrevendo em `TefCitelChRelay`; plugin lendo do relay/escrevendo no canal DVC) só logavam falha, nunca sucesso - um repasse rápido e uma trava silenciosa ficavam indistinguíveis no log.

**Instrumentado (2026-08-27, sem alterar comportamento nenhum)** para o próximo teste apontar o ponto exato:
- `untTefEstacaoPipeTransporte.pas`, `pEnviaFrame` - loga antes de enviar, e depois (sucesso com duração em ms, ou falha com duração+erro).
- `untTefCitelDvcRelayImpl.pas`, `pBombeiaServidorParaCliente`/`pBombeiaClienteParaServidor` - agora logam também o caminho de SUCESSO (antes só logavam falha), com duração de cada repasse.
- `untTefCitelDvcPluginImpl.pas`, `pLoopConectorELeitura` - loga antes/depois de `FChannel.Write` (bytes lidos do relay, repassados ao canal DVC).

**Em aberto, decisão para depois de confirmar o ponto exato**: se `pEnviaFrame` for de fato o gargalo, o fix natural é replicar o mesmo padrão já estabelecido (`FthrEscritaWorker`: fila + thread dedicada, sem timeout artificial sobre o `WriteFile` em si) para o lado do envio de resposta do serviço - mas isso tem uma implicação de correção que meiece decisão consciente: `pEnviaOuEnfileira` hoje captura exceção de `pEnviaFrame` (síncrona) para cair no fallback de fila local em arquivo (RF07); se o envio virar assíncrono (enfileira e retorna na hora), uma falha que só aparece DEPOIS (dentro do worker) precisa de um caminho novo para acionar esse mesmo fallback - não é só trocar `WriteFile` de lugar. Não implementado ainda - aguardando o resultado do próximo teste com os logs de duração acima para confirmar se é mesmo aqui antes de desenhar esse ponto.


### Segundo teste de campo (2026-08-27) — achado mais grave: travamento vira permanente

**Resultado**: desta vez a chamada **nem chegou no pinpad** (`ScopeTrc.txt` vazio). Log do plugin mostra `pLoopEscritaWorker: escrita de 467 bytes concluida em 115047 ms` — o MESMO salto plugin→relay que tinha sido `0 ms` no teste anterior, desta vez levou 115s. Log do relay não mostra **nenhuma** linha de bombeamento (nem sucesso, nem falha) — os dados nunca chegaram até lá de fato. A "conclusão" da escrita bate no mesmo milissegundo exato de `"Canal DVC fechado pelo lado autcom.exe."` — sugere fortemente artefato de corrida (mesmo padrão já visto uma vez nesta investigação: um `CloseHandle`/cancelamento concorrente faz uma escrita presa "completar com sucesso" sem o dado ter sido entregue de verdade), não uma medição real de 115s de I/O.

**Conclusão que reformula toda a investigação**: a premissa da triangulação original ("mesma sessão do mstsc.exe = sempre rápido") não se sustentou — o mesmo tipo de trava sem teto pode acontecer em QUALQUER salto desta cadeia, não só cruzando pra sessão 0. E mais grave: **nenhuma camada tem hoje um mecanismo de "esperar minha própria thread até um limite, e seguir vivo se ela não voltar"** — cada `.WaitFor`/callback síncrono é incondicional. Isso significa que UMA trava, uma vez, não é "uma chamada lenta" — é a morte permanente do componente que a fez, exigindo reinício manual (exatamente por isso cada teste precisou de `ServiceStop`/`ServiceStart` + reconectar a sessão RDP).

**Bug concreto identificado e corrigido no relay (2026-08-27)**: `pRodaBombeamento` (antigo) esperava as duas threads de bombeamento com `.WaitFor` incondicional, sem timeout. Se uma travasse de vez (e `CancelSynchronousIo` não conseguisse destravar — já documentado como pouco confiável neste ambiente), a thread principal do relay nunca voltava pro loop de aceitar conexão, e `nMaxInstances = 1` no `CreateNamedPipe` bloqueava qualquer conexão futura (`ERROR_FILE_NOT_FOUND`/`ERROR_PIPE_BUSY` permanente) — bate com o `PID 8752` sendo criado no lugar do `PID 6592` antigo no teste 2.

**Corrigido**: `untTefCitelDvcRelayImpl.pas` reestruturado — nova classe `TTefCitelDvcRelayRodada` encapsula uma conexão/rodada inteira (conecta ao serviço, bombeia nos dois sentidos). `TTefCitelDvcRelay.pDisparaRodada` dispara cada rodada aceita em sua PRÓPRIA thread "dona" (fogo-e-esquece, `FreeOnTerminate`), e o loop principal (`pExecuta`) **nunca espera uma rodada terminar** — volta direto a aceitar a próxima conexão. Se as duas threads de bombeamento de uma rodada travarem pra sempre, só a thread dona dessa rodada fica presa (vazamento aceito, mesma filosofia já usada no resto do projeto) — não afeta mais a capacidade do relay de aceitar novas conexões. `nMaxInstances` do `CreateNamedPipe` mudou de `1` para ilimitado (`PIPE_UNLIMITED_INST`, mesmo valor já usado em `untTefEstacaoPipeTransporte.pas`) para permitir mais de uma instância viva ao mesmo tempo nesse cenário de exceção. **Ainda não recompilado/testado em campo.**

**Mesmo bug ainda presente no lado do serviço (`untTefEstacaoPipeTransporte.pas`) — NÃO corrigido ainda, mais grave**: `TTefEstacaoPipeTransporte` usa uma ÚNICA thread (`FthrServidor`) tanto para ler o pipe quanto (via `pOnFrameRecebido` síncrono) para despachar o método E mandar a resposta (`pEnviaFrame`). Se esse `WriteFile` travar, essa thread nunca mais volta nem pro próximo `ReadFile` nem pra aceitar nova conexão — o **serviço inteiro** fica surdo, exigindo `ServiceStop`/`ServiceStart` manual (exatamente o que aconteceu entre os dois testes). Diferente do relay, aqui não dá só para "disparar em thread própria por conexão", porque `nMaxInstances` já é ilimitado mas só existe UMA thread fazendo tudo — precisa separar leitura de envio de resposta (mesma discussão já registrada acima sobre mover `pEnviaFrame` para um worker dedicado, e a mesma implicação em aberto sobre `pEnviaOuEnfileira`/RF07). **Próxima tarefa, ainda não implementada.**


### Terceiro teste de campo (2026-08-27) — confirma trava permanente, não medição real

Repetiu exatamente o padrão do segundo teste: `pLoopEscritaWorker: escrita de 468 bytes concluida em 100016 ms`, no mesmo salto plugin→relay, e de novo **no mesmo milissegundo exato** de `"Canal DVC fechado pelo lado autcom.exe."`. Desta vez o log também mostrou `"handle antigo (geracao abandonada) fechado com seguranca apos a escrita retornar."` — confirma que a "conclusão" só aconteceu porque `Destroy` (disparado pelo fechamento do canal) chamou `CancelSynchronousIo` sobre a escrita presa; não foi o SO completando uma escrita lenta. Contas batem: 100016ms antes de 16:33:14.628 dá ~16:31:34.612, coincidindo com o instante exato em que o pipe plugin→relay conectou (16:31:34.600) — a escrita ficou travada **do começo ao fim da conexão**, nunca avançou sozinha.

**Decisão do Rafael (2026-08-27), com concordância**: antes de investir numa reescrita grande de transporte (named pipe → TCP loopback), rodar um teste isolado e barato primeiro — mesma disciplina já usada nesta investigação (pipe anônimo, pipe nomeado mesma sessão). Se um socket TCP loopback sofrer a mesma trava, não é especifico de named pipe (não vale a pena reescrever); se for instantâneo, é evidência forte de driver/filtro especifico de named pipe (`\Device\NamedPipe\*`), e migrar o transporte plugin↔relay pra TCP passa a ser justificado.

**Instrumentado (2026-08-27)**:
- `untTefCitelDvcRelayImpl.pas` — novo `pIniciaDiagnosticoTcpListener`/`pDiagnosticoTcpListener`: sobe um listener TCP loopback mínimo (porta `TEF_DIAG_TCP_PORTA = 47990`, sem framing/protocolo) numa thread separada, em paralelo ao funcionamento normal do relay. Chamado uma vez no `TefCitelDvcRelay.dpr`, antes de `pExecuta`.
- `untTefCitelDvcPluginImpl.pas` — novo `pDiagnosticoTcpCliente`, chamado de `OnDataReceived` só na primeira mensagem de cada canal (`FblnDiagnosticoTcpFeito`), em thread própria (nunca bloqueia a thread de callback do canal DVC) — conecta em `127.0.0.1:47990` e manda os mesmos bytes recebidos do autcom.exe, medindo `connect`/`send` em ms. Roda em paralelo ao fluxo real (enfileiramento pro pipe) - não substitui nem atrasa nada.
- Ambos usam `Winapi.Winsock2` (unit padrão do RTL, sem dependência nova).
- **Marcado como DIAGNOSTICO TEMPORARIO nos dois lados - remover depois do teste**, mesmo padrão já usado nas 3 instrumentações anteriores desta investigação (pipe anônimo, pipe nomeado mesma sessão, escrita direta na thread de callback).

**Ainda não compilado/testado em campo.** Próximo passo: recompilar plugin + relay (Win64), copiar na estação, reconectar sessão RDP, repetir o teste de `fConfiguraTefCitel`, e conferir `TefCitelDvcPlugin.log`/`TefCitelDvcRelay.log` pelas linhas `[DIAGNOSTICO TCP]` — decide entre reescrever o transporte pra TCP ou não.


### Resultado do diagnóstico TCP (2026-08-27) — decisivo, migração feita

Dois testes seguidos: socket TCP loopback conectou e enviou em `0 ms` nas duas vezes (`connect`/`send`/`recv` todos instantâneos, incluindo o `recv` do lado do relay). O named pipe real, na mesma mensagem, no mesmo instante, travou do jeito de sempre (`29609ms`/`52781ms`, de novo "concluindo" exatamente no fechamento do canal DVC — mesmo artefato de corrida já identificado). **Conclusão confirmada**: o problema é específico do driver de named pipe (NPFS, `\Device\NamedPipe\*`) usado a partir de thread hospedada dentro do `mstsc.exe` — não é "qualquer I/O bloqueante dentro do mstsc.exe" (isso descarta a hipótese genérica; nunca tinha sido testado contra outro driver de transporte antes).

**Decisão (Rafael, 2026-08-27)**: migrar o transporte plugin↔relay de named pipe para socket TCP loopback (`127.0.0.1:47990`). O transporte relay↔`TefEstacaoService.exe` **não muda** — continua named pipe (`TefCitelCh`) — esse hop nunca mostrou o problema quando dados de fato trafegaram por ele (parte de um processo comum, não do `mstsc.exe`).

**Implementado (2026-08-27)**:
- `untTefCitelDvcPluginImpl.pas` — reescrita: `FhndPipe: THandle` → `FsckRelay: TSocket`; `fTentaConectarPipe`/`fEscreveNoPipe`/`pFechaPipeJaTravado` → `fTentaConectarSocket`/`fEscreveNoSocket`/`pFechaConexaoJaTravada`, usando `socket`/`connect`/`send`/`recv`/`shutdown`/`closesocket` (`Winapi.Winsock2`, unit padrão do RTL). `fSobeRelaySobDemanda` (spawn do relay) mantido sem alteração — só o alvo de conexão mudou (porta TCP em vez de nome de pipe); `ERROR_FILE_NOT_FOUND` (pipe) virou `WSAECONNREFUSED` (socket) como sinal de "relay ainda não subiu". `shutdown(SD_BOTH)` substitui `CancelSynchronousIo` para destravar `recv`/`send` pendente de outra thread — mais confiável que o equivalente de named pipe para este caso (documentado, seguro de chamar de qualquer thread a qualquer momento). Mesmo padrão de posse do handle (`FblnEscritaEmAndamento`) mantido por segurança extra, mesmo não sendo estritamente necessário com socket. Diagnóstico temporário removido (função cumprida).
- `untTefCitelDvcRelayImpl.pas` — lado que aceita o plugin (`TTefCitelDvcRelay`/`TTefCitelDvcRelayRodada.FsckServidor`) migrado pra socket TCP (`fCriaSocketOuvinte` com `bind`/`listen`/`accept`, backlog `SOMAXCONN` — mais simples que named pipe, sem limite de instância). Lado que fala com `TefEstacaoService.exe` (`FhndPipeCliente`) **inalterado** — `fConectaPipeCliente`/`fEscreveTudoPipe` continuam named pipe. Bombeamento agora usa `fEscreveTudoPipe`/`fEscreveTudoSocket` separados (cada direção mistura os dois transportes: lê de um, escreve no outro). Diagnóstico temporário removido (função cumprida, virou o transporte real).
- Porta `47990` fixa, duplicada por literal nas duas units (mesmo motivo de sempre — leveza, sem dependência cruzada).

**Ainda não compilado/testado em campo** — mudança grande, sem acesso a IDE Delphi aqui para verificar. Próximo passo: compilar os dois projetos (Win64), copiar na estação, reconectar sessão RDP, repetir o roteiro de teste completo (`fConfiguraTefCitel`/`fObtemVersao`/`fPassarCartao`, `CFG_TEFDVC = S`) e conferir os 4 logs de sempre — expectativa é que a demora/travamento no salto plugin→relay desapareça de vez.


### Teste de campo pós-migração TCP (2026-08-27) — plugin→relay resolvido, trava reaparece um passo adiante

**Bom sinal**: `pLoopEscritaWorker: escrita de 467 bytes concluida em 0 ms` — o salto plugin→relay (agora TCP) ficou instantâneo, confirmado em 2 tentativas seguidas. A migração resolveu exatamente o que se propôs a resolver.

**Mas a trava reapareceu um passo adiante**: nos dois testes, o relay loga `"Rodada: conectado ao TefEstacaoService (TefCitelCh)"` e depois **nada mais** — nenhuma linha de bombeamento (nem sucesso, nem falha) em nenhuma das duas direções, apesar do plugin ter enviado com sucesso 8s depois (primeiro teste) / instantaneamente (segundo teste). Como o log só registrava sucesso *depois* dos dois passos de cada direção (receber + repassar), não dava pra saber se travou no `recv()` do socket (child novo, nunca testado sob essa exata sequência de threads) ou no `WriteFile` do pipe `TefCitelCh` (suspeito mais forte, dado o histórico do named pipe nesta investigação inteira) - com apenas `CreateFile` (conectar) confirmado rápido nos dois casos.

**Instrumentado (2026-08-27)**: `untTefCitelDvcRelayImpl.pas` - log adicionado logo após `recv()`/`ReadFile` sucederem, ANTES da escrita no outro lado, nas duas direções (`pBombeiaServidorParaCliente`/`pBombeiaClienteParaServidor`) - fecha esse ponto cego especificamente.

**Hipótese de trabalho, a confirmar no próximo teste**: dado que TCP se provou confiável em toda tentativa até agora (diagnóstico isolado 2x, e agora o próprio plugin→relay 2x) e named pipe segue sendo o único componente comum a todas as travas desta investigação inteira (praticamente 2 semanas), é bem provável que o `WriteFile` para `TefCitelCh` (relay→serviço) sofra do mesmo problema, nunca visto antes porque nunca foi exercitado sob estresse real (só funcionou 1x, no teste original, antes de toda essa saga). Se confirmado, o próximo passo natural é migrar TAMBÉM o lado `TefEstacaoService.exe` de named pipe para TCP loopback (`untTefEstacaoPipeTransporte.pas`) - mudança maior, pois mexe no código de produção do serviço, não só nos processos auxiliares (plugin/relay). Não implementado ainda - aguardando confirmação do log instrumentado.


### Confirmação (2026-08-28) e decisão final de arquitetura

Log instrumentado confirmou: `"467 bytes recebidos do plugin, repassando ao pipe TefCitelCh..."` seguido de silêncio total — o `WriteFile` para o named pipe `TefCitelCh` (relay→`TefEstacaoService.exe`) trava exatamente como a hipótese previa. Named pipe é a única constante em ~2 semanas de investigação, em toda combinação de processos testada; TCP nunca falhou uma única vez.

**Decisão do Rafael (2026-08-28)**: eliminar named pipe por completo **e o processo relay de sessão junto** (perde a razão de existir — só fazia ponte pro named pipe). Plugin passa a conectar **direto** em `TefEstacaoService.exe` via socket TCP loopback (`127.0.0.1:47991`). Topologia simplifica de 3 processos (autcom→plugin→relay→serviço) para 2 (autcom→plugin→serviço).

**Implementado (2026-08-28)**:
- `untTefEstacaoTcpTransporte.pas` (NOVO, substitui `untTefEstacaoPipeTransporte.pas`, removida) — mesma interface pública (`Create`/`pEnviaFrame`/`blnConectado`/`OnFrameRecebido`/`OnConectado`/`OnDesconectado`) da classe antiga, agora sobre socket TCP (`bind`/`listen`/`accept`/`recv`/`send`) em vez de named pipe. Contrato síncrono-com-exceção-em-falha de `pEnviaFrame` preservado — `pEnviaOuEnfileira`/RF07 no roteador não precisou de nenhuma alteração.
- `untTefEstacaoRoteadorMensagens.pas` — troca de 3 linhas (`uses`, tipo do campo `FTransporte`, chamada `.Create`). Toda a lógica de despacho/hooks/observer/fila local ficou intocada.
- `TefEstacaoService.dpr`/`.dproj` — referência de unit trocada.
- `untTefCitelDvcPluginImpl.pas` — reescrita: removida toda a lógica de subir o relay sob demanda (`fSobeRelaySobDemanda`, `fCaminhoRelayExe`, `CREATE_NO_WINDOW_C`, `TEF_PLUGIN_RELAY_EXE_NOME`) — não tem mais nada para o plugin criar, `TefEstacaoService.exe` já é um serviço Windows sempre de pé. `fTentaConectarSocket` simplificado para só conectar/tentar de novo, sem `WaitNamedPipe`/spawn equivalente. Campo renomeado `FsckRelay` → `FsckEstacao` (reflete o alvo real).
- **Pasta `libTefCitel\Estacao\Relay\` removida por completo** (`.dpr`/`.dproj`/unit/binários) — não tem mais papel na arquitetura.
- Porta `47991` fixa (distinta da `47990` que era do relay, evita qualquer confusão se sobrar alguma instalação antiga rodando).

**Segurança**: risco já documentado em specs.md seção 5 ("canal sem autenticação/autorização, precisa de validação mínima antes de produção") continua idêntico com TCP loopback — não piora nem resolve, mesma superfície (qualquer processo local pode conectar). Loopback (127.0.0.1) não é exposto na rede da estação; Firewall do Windows não filtra tráfego de loopback por padrão, então não deveria precisar de regra nova — vale confirmar na estação de teste mesmo assim.

**Ainda não compilado/testado em campo** — mudança grande (troca de transporte de produção do serviço), sem acesso a IDE Delphi aqui. Próximo passo: compilar `TefEstacaoService.dproj` + `TefCitelDvcPlugin.dproj` (Win32/Win64 respectivamente), instalar o `.exe` novo do serviço na estação (`Stop-Service`/copiar/`Start-Service`), copiar a `.dll` nova do plugin, reconectar sessão RDP, repetir o roteiro completo. Scripts de instalação (`Estacao\install\*.ps1`) não precisam de alteração — nunca referenciaram o relay nem o pipe por nome.


### PRIMEIRO CICLO COMPLETO BEM-SUCEDIDO ponta a ponta (2026-08-28)

Com a arquitetura TCP direta (plugin↔serviço, sem relay, sem named pipe), `fConfiguraTefCitel` (id=1, `somenteCarregarLib=True`) e `fObtemVersao` (id=2) rodaram em sequência, cada um com ciclo completo autcom.exe→serviço→autcom.exe em **dezenas de milissegundos**, sem duplicação, sem timeout, sem trava:

- Envio (plugin→serviço): `0 ms` nos dois casos.
- Processamento no serviço: `fConfiguraTefCitel` ~37ms, `fObtemVersao` ~23ms.
- Resposta (serviço→plugin→canal DVC): imediata, log confirma "bytes repassados ao autcom.exe" nos dois casos.
- **Prova indireta mais forte até agora**: o autcom.exe emendou a chamada de `fObtemVersao` logo depois de `fConfiguraTefCitel` retornar — só acontece se a resposta anterior chegou de verdade no autcom.exe (não há reenvio/timeout do lado dele). `ScopeTrc.txt` confirma `ScopeVersao` executado com sucesso, coerente com o `fObtemVersao` despachado no mesmo instante.

Esta é a primeira vez em toda a investigação (~2 semanas) que se observa um ciclo de ida e volta completo, rápido e sem duplicação. A mudança de named pipe para socket TCP loopback, em ambos os hops, resolveu a instabilidade de transporte que motivou toda essa investigação.

**Ainda faltando testar** (critérios de aceitação, specs.md seção 6): `fPassarCartao` (crédito/débito reais, incluindo o fluxo de Observer/eventos de progresso durante o parcelamento — ainda não exercitado com a nova arquitetura), fluxo Pix via PinPad, queda de canal DVC durante transação em andamento (reconexão/RF07), e o roteiro completo com `CFG_TEFDVC = N` (regressão zero, não deveria ser afetado por nada disso mas vale confirmar).


### Teste de campo de `fPassarCartao` (2026-08-28) — achado novo, lado AUTCOM: tela trava para interação

**Sintoma reportado por Rafael:** `fConfiguraTefCitel`/`fObtemVersao` ok (arquitetura TCP confirmada). No teste de `fPassarCartao` (crédito), a tela do TEF em `autcom.exe` recebe as mensagens/eventos do TEF normalmente, mas não deixa o operador clicar para escolher crédito à vista/parcelado — TEF ficou esperando uma resposta que nunca chegou (o `TefEstacaoService.log` mostra `fPassarCartao` (id=3) despachado e nunca retornando; `TefCitelDvcTransporte.log`, do lado autcom, mostra o `fPassarCartao` enviado, um `hook_resposta` respondido rápido, e depois só o loop de timeout 996 continuando por minutos; `TefCitelDvcPlugin.log` mostra um fluxo constante de bytes sendo repassados ao `autcom.exe` a cada ~200-450ms por mais de 90s, até o canal ser fechado pelo lado autcom).

**Investigação (leitura de código, sem instrumentação nova — sintoma é do lado AUTCOM/UI, não do transporte, que já está confirmado saudável)**:
- `libTefCitel\untTefCitelDvc.pas`, `fChamaRpc` — quando chamada da thread principal, o espera bombeia só `CheckSynchronize(0)` em loop (comentário já explicava a razão: liberar hooks `Antes*`/`Depois*` via `TThread.Synchronize` sem deadlock). `CheckSynchronize` drena a fila de `Synchronize`, mas **não despacha a fila de mensagens do Windows** — nem `WM_TIMER` nem cliques de mouse.
- `padra_atualizado\fontes\tef\TefCitel\untTefCitelOperacoes.pas` (`TfrmTefCitelOperacoes`, a tela real de crédito/débito/parcelado) — implementa `IObserverTEFCitel.AtualizaTefCitel`, atualizado via `pTrataEvento`'s `TThread.Synchronize` (por isso o operador *vê* as mensagens do TEF chegando — isso não depende de mensagens do Windows, só de `CheckSynchronize`). `btnCreditoClick`/`btnDebitoClick` chamam `pPassaCartao` (→ `fPassarCartao`, a chamada RPC) **direto no handler do clique, com a tela ainda aberta** (ao contrário de `btnAVistaClick`/`btnConfirmaClick`, que só setam `ModalResult` e fecham a tela para o chamador externo decidir depois). Ou seja, para o fluxo de "Crédito"/"Débito" com **Modalidade Dinâmica** (`FobjModalidadeDinamica`, `pMontaListaFormsPagto`, `pOnClickModalidadeDinamica` — modalidade decidida em tempo real pela adquirente, não pré-selecionada), a mesma tela continua aberta e precisa que o operador clique num botão dinâmico **enquanto** o `fChamaRpc` do `fPassarCartao` já disparado ainda está bloqueando a thread principal.
- `tmrAtualizaMsgTimer`/`tmrCenCarTimer` (mesma unit) chamam `Application.ProcessMessages` explicitamente, com comentário do código legado: "ESTE TIMER FOI COLOCADO PARA MANTER SINCRONIZADO AS MENSAGENS DO PINPAD JUNTO COM AS MENSAGENS PAINEL DE MSG" — confirma que a arquitetura clássica (`CFG_TEFDVC = N`) **já dependia** de bombeamento de `Application.ProcessMessages` durante a chamada bloqueante de `fPassarCartao` (lá, em processo, dentro do laço de polling local de `untTefCitelNCR`/`untTefCitel` — arquivos que `IA\rules\tef-dvc.md`/tarefas anteriores confirmam não terem sido tocados). A versão DVC preservou o bombeamento de `Synchronize` (por isso eventos/hooks continuam funcionando) mas **não** reproduziu o bombeamento de `Application.ProcessMessages` — perda de paridade, não decisão deliberada.

**Causa raiz**: `fChamaRpc`, quando chamada na thread principal, nunca despacha a fila de mensagens do Windows enquanto espera a resposta — apenas `CheckSynchronize(0)`. Cliques do operador na tela de crédito/débito/parcelado (incluindo os botões de Modalidade Dinâmica) ficam enfileirados e nunca são processados enquanto uma chamada RPC (`fPassarCartao`) estiver pendente na mesma thread, mesmo que a tela continue recebendo/exibindo atualizações via `TThread.Synchronize` (que não depende da fila de mensagens). Não é falha do transporte (já confirmado rápido/saudável nesta mesma rodada) nem violação da regra de "nunca impor timeout artificial" de `IA\rules\tef-dvc.md` — a chamada continua esperando indefinidamente pelo pinpad/estação, só passa a também bombear a UI enquanto espera.

**Corrigido (2026-08-28)**: `libTefCitel\untTefCitelDvc.pas`, `fChamaRpc` — loop de espera na thread principal agora chama `Application.ProcessMessages` a cada iteração, além de `CheckSynchronize(0)` (restaura a paridade com o bombeamento que a arquitetura clássica já fazia via `tmrAtualizaMsg`/laço de polling local). `Vcl.Forms` adicionado ao `uses` (necessário para `Application`; unit já é exclusiva do lado AUTCOM/VCL, nunca usada pelo `TefEstacaoService.exe`, então não há impacto de plataforma). Nenhum timeout novo introduzido — `WaitFor(20)` continua sendo só o intervalo de poll, e o loop `while` não tem teto.

**Ainda não recompilado/testado em campo** — mudança pequena e localizada (2 trechos na mesma unit), mas ainda pendente: recompilar `libTefCitel.dproj` (atenção à ressalva de sempre: config Debug/Win32 sobrescreve `padra_atualizado\libTefCitel.dll` direto), reiniciar `autcom.exe` para carregar a DLL nova, repetir o teste completo de crédito com escolha de modalidade (à vista e parcelado, se possível também o fluxo de Modalidade Dinâmica especificamente) e confirmar que os botões respondem normalmente durante a chamada pendente.


### Teste de campo seguinte (2026-08-28) — trava de UI resolvida, achado novo: comando não chega na estação durante transação em andamento

**Confirmado por Rafael**: com o fix de `Application.ProcessMessages` em campo, "a sensação de travamento parou". Repetiu o teste de crédito, clicou para escolher à vista/parcelado (fluxo de Modalidade Dinâmica) — o clique registrou (log do autcom mostra `pInfo21` id=4 enviado com sucesso), mas **o comando não chegou no `TefEstacaoService.log`** — nenhuma linha nova depois de `Despachando metodo "fPassarCartao" (id=3)...`.

**Causa raiz (achada por leitura de código, sem precisar instrumentar)**: `libTefCitel\Estacao\untTefEstacaoTcpTransporte.pas`, `pLoopServidor` — uma ÚNICA thread (`FthrServidor`) faz `accept`/`recv`/extrai frame E despacha o método (`FOnFrameRecebido` → `untTefEstacaoRoteadorMensagens.pTrataChamada` → `fDespachaMetodo`), tudo síncrono, tudo na mesma chamada. Enquanto essa thread está parada dentro de `FRealInstance.fPassarCartao` (nativo, esperando o pinpad), ela nunca volta pro `recv()` — o `pInfo21` fica nos buffers do socket, recebido pelo Windows mas nunca lido pela estação, até `fPassarCartao` terminar. É o MESMO bug de arquitetura já mapeado em 2026-08-27 para o `TTefEstacaoPipeTransporte` (seção "Mesmo bug ainda presente no lado do serviço... NÃO corrigido ainda, mais grave") — nunca corrigido na migração pro TCP, e só apareceu na prática agora porque a Modalidade Dinâmica depende de mandar `pInfo21`/`pInfo30`/`pInfo34` **enquanto** `fPassarCartao` já está rodando.

**Decisões do Rafael (2026-08-28), antes de implementar:**
1. **Despachar TODA chamada em thread própria** (não só as 3 de transação) — mais simples, e a UI só dispara uma chamada por vez em condições normais.
2. **Trocar `TefEstacaoService.exe` de compilação direta do fonte (`untTefCitelNCR`/`untScopeNCR`/`untTefCitel`/`untFuncoesLibTefCitel`) para carregar `libTefCitel.dll` dinamicamente**, num padrão de singleton — motivação dupla: (a) evitar a lentidão percebida por ele no momento inicial de passar o cartão; (b) preparar terreno pra rotina de atualização remota de DLL (`scope.zip`/`sitef.zip`, RF10, ainda **não desenhada** — fica pra sessão futura, "vamos discutir mais adiante"). **Achado ao investigar**: não precisa de loader customizado — `padra_atualizado\fontes\tef\TefCitel\untTefCitelUtil.pas` (linha 179) já importa `fCriarTefCitel` de `libTefCitel.dll` via `external '...' delayed` (delay-load do próprio Delphi/linker: só chama `LoadLibrary`/`GetProcAddress` na primeira chamada real, e mantém carregado dali em diante — singleton de graça, sem código extra). Bastou replicar o mesmo padrão no lado da estação.

**Implementado (2026-08-28), ainda não compilado/testado em campo:**
- `libTefCitel\Estacao\untTefEstacaoRoteadorMensagens.pas`:
  - `fCriarTefCitel` agora é `external 'libTefCitel.dll' delayed` (mesma assinatura de sempre), declarado localmente na unit — `uses untFuncoesLibTefCitel` removido.
  - Nova `pDespachaChamadaEmThreadPropria` — `pOnFrameRecebido` agora clona o JSON e dispara uma `TThread.CreateAnonymousThread` (`FreeOnTerminate := True`, fogo-e-esquece) por "chamada" recebida, em vez de chamar `pTrataChamada` direto na thread de leitura do transporte. Isso libera `pLoopServidor` pra voltar ao `recv()` imediatamente, mesmo com uma chamada anterior (`fPassarCartao`) ainda rodando numa thread separada.
  - Nova `FcsInstancia: TCriticalSection`, protegendo só a criação/troca de `FRealInstance` dentro de `pGaranteInstanciaReal` (agora pode ser chamada por mais de uma thread de despacho ao mesmo tempo) — **não** protege chamadas inteiras a `FRealInstance` (isso devolveria o mesmo travamento que este fix corrige). Comentário no código avisando para não reintroduzir um lock global por engano numa sessão futura.
  - **Risco aceito conscientemente (decisão do Rafael)**: `FRealInstance` passa a ser acessado por mais de uma thread genuinamente em paralelo (ex.: `pInfo21` numa thread enquanto `fPassarCartao` roda em outra) — `untTefCitelNCR.pas`/`untTefCitel.pas`/`untScopeNCR.pas` (off-limits, não alteráveis) nunca foram desenhados para isso, só para reentrância na MESMA thread (modelo clássico, via bombeamento de mensagens). Não instrumentado/testado sob concorrência real ainda.
- `libTefCitel\Estacao\TefEstacaoService.dpr`: `ShareMem` virou a primeira unit (exigido pelo import `delayed` cruzando a fronteira da DLL com strings). Removidas do projeto: `untFuncoesLibTefCitel`, `untTefCitel`, `untTefCitelNCR`, `untScopeNCR`, `untTefCitelDvc`, `untTefCitelDvcTransporte` (as duas últimas só entravam por import transitivo de `untFuncoesLibTefCitel`, já documentado como "nunca exercitado aqui" antes desta mudança — confirmado seguro remover junto). Mantidas: `untInterfaceTefCitel`, `untTefCitelComum`, `untTefCitelIntervalos`, `untFormatarMensagemErro` (conferido que nenhuma delas depende das units removidas).
- `.dproj` **não foi tocado** (regra do projeto: só editar `.dpr`, a IDE sincroniza o `.dproj` ao abrir/compilar).

**Ainda não avaliado**: se `libTefCitel.dproj` (a DLL) precisa de algum ajuste — deve continuar compilando exatamente como está (já exporta `fCriarTefCitel`, já é a DLL que o autcom.exe consome); só o consumidor (`TefEstacaoService.exe`) mudou.

**Próximo passo**: abrir `TefEstacaoService.dproj` na IDE (deve sincronizar a lista de units a partir do `.dpr`), compilar (`libTefCitel.dproj` não precisa recompilar — nenhuma mudança nele), copiar `TefEstacaoService.exe` novo pra estação (`Stop-Service`/copiar/`Start-Service`), repetir o teste completo de crédito com Modalidade Dinâmica e confirmar: (1) `pInfo21`/`pInfo30`/etc. aparecem no `TefEstacaoService.log` mesmo com `fPassarCartao` ainda em andamento; (2) nenhuma regressão em `fConfiguraTefCitel`/`fObtemVersao` (ainda síncronos na mesma thread de leitura, mas agora cada um numa thread de despacho própria, fogo-e-esquece); (3) primeira chamada depois do delay-load (`fConfiguraTefCitel`) não fica visivelmente mais lenta que antes.

**Bug de deploy encontrado e corrigido em 2026-08-28, ao trocar o `.exe` pela primeira vez**: serviço não iniciava (`Erro 1053: O serviço não respondeu à requisição de início ou controle em tempo hábil`), **sem nenhuma linha nova no log** — nem `ServiceStart chamado.`. Causa: `ShareMem` (adicionado como primeira unit de `TefEstacaoService.dpr` nesta mesma sessão, necessário pro `external 'libTefCitel.dll' delayed` passar `String` com segurança pela fronteira da DLL) depende de `BORLNDMM.DLL` estar presente na pasta do `.exe` — nunca foi necessário na estação antes (o serviço não cruzava fronteira de DLL até esta sessão). Sem o arquivo, a inicialização do `ShareMem` lança excecao **antes** de `Application.Initialize`/`ServiceStart` rodarem (explica log vazio); como é um servico Windows (Session 0, sem desktop interativo), a caixa de dialogo de erro que o runtime tentaria mostrar fica invisivel e nunca e fechada — processo trava esperando um clique que nunca vem, SCM estoura o timeout (1053), processo pode ficar preso no Gerenciador de Tarefas mesmo com o servico marcado como parado.

**Correção — item de deploy, não de código**: copiar `padra_atualizado\borlndmm.dll` (já existe ali, é o mesmo `BORLNDMM.DLL` que o `autcom.exe` usa, mesmo motivo) para a pasta flat da estação (`C:\TEF_Citel\`, ao lado de `TefEstacaoService.exe`/`libTefCitel.dll`), e finalizar manualmente qualquer `TefEstacaoService.exe` travado no Gerenciador de Tarefas antes de tentar iniciar o serviço de novo. **Registrar em qualquer checklist/script de instalação futuro** (`libTefCitel\Estacao\install\*.ps1`) — a pasta flat da estação agora tem uma dependência nova (`borlndmm.dll`) que não existia antes desta sessão.

**Confirmado por Rafael (2026-08-28)**: com `BORLNDMM.DLL` copiado pra pasta da estação, o serviço subiu normalmente. Diagnóstico do erro 1053 fechado.

**Próximo passo**: repetir o teste completo de crédito com Modalidade Dinâmica (o cenário que expôs o Bug 2) e conferir nos 2 logs de sempre: (1) `pInfo21`/`pInfo30`/etc. aparecendo no `TefEstacaoService.log` mesmo com `fPassarCartao` ainda em andamento (objetivo do fix da thread-por-chamada); (2) `fConfiguraTefCitel`/`fObtemVersao`/`fPassarCartao` completando sem erro nem duplicação, confirmando que o delay-load de `libTefCitel.dll` (novo caminho de carregamento da instância real na estação) não introduziu regressão.


### Bug 3 encontrado e corrigido em 2026-08-28 — EAccessViolation no autcom (crash) causado por duplo-clique + concorrência real em fPassarCartao

**Sintoma**: no primeiro teste após o Bug 2, ao clicar em "Crédito" (Modalidade Dinâmica), `autcom.exe` derrubou com `EAccessViolation` (madExcept). Relatório completo do madExcept analisado — crash na thread de leitura do canal DVC (`libTefCitel\untTefCitelDvcTransporte.pas`, `pExtraiFramesDisponiveis`), logo após despachar um envelope `"evento"` (confirmado pelo dump de pilha, que mostra o JSON literal do envelope sendo processado). O disassembly mostra `Self` (o `TTefCitelDvcTransporte`) lido como nulo ao tentar reler `FarrBuffer` para continuar o laço de extração de frames, logo depois de `FOnFrameRecebido` retornar (esse envelope evento passa por `TThread.Synchronize`, que bloqueia a thread de leitura até a thread principal processar). A thread principal, no instante do crash, estava fundo numa pilha de `ShowModal` aninhados (Resumo de Caixa → Digitação de Cartões → Operações TEF) dentro do `Application.ProcessMessages` do Bug 1 (`fChamaRpc`).

**Impacto de negócio observado**: a transação **completou de verdade na estação** (`TefEstacaoService.log` mostra `fPassarCartao (id=3) retornou com sucesso` >30s **depois** do crash) — mas como a thread que leria essa resposta no autcom já tinha morrido, ela nunca chegou. Resultado: transação ficou pendente no autcom e inicialmente não gerou TEFTRA (ver observação do Rafael logo abaixo sobre o comportamento de completude do registro nesse cenário de órfão). `fiz o fluxo de cancelamento da transação e funcionou normalmente` (Rafael) — confirma que `autcom.exe` sobreviveu ao crash (só a thread de leitura morreu; madExcept intercepta por thread) e que uma nova instância de `TTefCitelDvc`/transporte funcionou bem depois.

**Causa raiz, confirmada por Rafael**: ele clicou **duas vezes** no botão "Crédito" (`"acredito que quando deu erro e cliquei mais de uma vez no botão"`) — repetiu o teste clicando uma única vez e funcionou normalmente, em mais de uma tentativa. Isso despachou **duas chamadas `fPassarCartao` concorrentes** (ids diferentes) contra o **mesmo `FRealInstance`** na estação.

Antes do Bug 2, isso era (acidentalmente) inofensivo: a estação, de thread única, processava uma "chamada" de cada vez — a segunda `fPassarCartao` ficaria parada no buffer do socket até a primeira terminar (exatamente o bug que o Bug 2 corrigiu). **A correção do Bug 2 (thread-por-chamada) removeu essa serialização acidental** — agora as duas `fPassarCartao` rodam genuinamente em paralelo, em threads diferentes, contra a MESMA instância nativa do Scope/CliSiTef (mesma porta serial/pinpad físico) — algo que `untTefCitelNCR.pas`/`untScopeNCR.pas` (off-limits, não alteráveis) nunca foram desenhados para tolerar. A corrupção resultante na comunicação nativa/porta serial explica o tráfego "evento" que acabou derrubando a thread de leitura do canal DVC do lado autcom.

Isso é exatamente o risco já registrado (não implementado) na jornada de 2026-08-24: `"Dedup por id no roteador da estação — fPassarCartao foi visto duplicado... método não é idempotente... a rede de segurança em si nunca foi implementada."` A correção do Bug 2 tornou essa lacuna ativa (antes só causava duplicação de transação em cenários raros de timeout/reenvio; agora qualquer duplo-clique aciona o mesmo risco, imediatamente).

**Corrigido (2026-08-28)** — `untTefEstacaoRoteadorMensagens.pas`, `pTrataChamada`: novo single-flight (`FcsTransacao`/`FblnTransacaoEmAndamento`) que rejeita uma SEGUNDA chamada de método de transação (`fPassarCartao`/`fCancelaTransacaoTerminal`/`fReimpressao`) enquanto uma primeira ainda está em andamento — responde com erro claro ("Já existe uma transação de cartão em andamento nesta estação...") em vez de despachar concorrentemente. **Escopo estritamente os 3 métodos de transação** — `pInfo21`/`pInfo30`/`pInfo34`/`fConfiguraTefCitel`/`fObtemVersao`/etc. continuam livres para chegar e serem despachados em paralelo com uma transação em andamento (não reintroduz a trava que a thread-por-chamada corrigiu — só impede DUAS transações reais simultâneas na mesma instância nativa).

**Ainda não avaliado / não implementado nesta sessão**: hardening complementar do lado AUTCOM (desabilitar o botão "Crédito"/proteção contra duplo-clique em `TfrmTefCitelOperacoes`) — o guard da estação já é a rede de segurança autoritativa (protege a chamada nativa em si, independente do que a UI permitir), então isso ficaria como defesa em profundidade, não correção obrigatória. Não atacado por ora.

**Ainda não recompilado/testado em campo.** Próximo passo: recompilar `TefEstacaoService.dproj`, reinstalar na estação, tentar reproduzir de propósito um duplo-clique em "Crédito" e confirmar que a segunda chamada é rejeitada com erro claro (em vez de rodar concorrente) — depois repetir o roteiro normal (clique único) pra confirmar que nada regrediu.

**Observação do Rafael (mid-sessão) a triar**: `"corrigindo gerou teftra mas não atualizou com os dados para deixar como pendente"` — ao investigar o caso órfão do crash acima, uma TEFTRA foi gerada mas não foi atualizada com os dados que a deixariam marcada como pendente corretamente. Ainda não investigado por mim — é um problema de completude de dados na lógica de negócio do autcom (fora do escopo dos arquivos desta sessão), possivelmente ligado a como o fluxo trata uma resposta de `fPassarCartao` que nunca chega (canal caiu/thread morreu) vs. uma que chega normalmente. Aguardando decisão do Rafael se quer que isso seja investigado agora ou registrado para depois.


### Bug 3 (continuação, 2026-08-28) — segundo crash confirma: qualquer método clicado 2x, não só fPassarCartao

**Achado por Rafael**: reproduziu o mesmo `EAccessViolation` clicando várias vezes em **"à vista"** (não só "Crédito") — segundo relatório completo do madExcept anexado, callstack e disassembly idênticos ao primeiro (mesmo ponto de crash, `pExtraiFramesDisponiveis`, mesmo padrão `Self` lido como nulo). Isso muda o diagnóstico: não é especificamente "duas `fPassarCartao` concorrentes" — é **qualquer método RPC clicado duas vezes rápido demais**, porque o fix do Bug 1 (`Application.ProcessMessages` dentro do `fChamaRpc`) faz um segundo clique no mesmo botão ser processado de forma reentrante antes da resposta do primeiro chegar, disparando o mesmo método duas vezes em paralelo (`fPassarCartao` no caso do "Crédito", `pInfo21` no caso do "à vista").

**Pedido do Rafael**: guard no autcom para evitar múltiplos cliques.

**Corrigido (2026-08-28)** — `libTefCitel\untTefCitelDvc.pas`, `fChamaRpc`: em vez de caçar/corrigir cada handler de botão espalhado em `untTefCitelOperacoes.pas` (zona legada, muitos pontos de entrada, `blnPermiteSelecionarOpcao`/`blnPermiteSelecionarMenu` já existem mas claramente não bastam), o guard entrou no **único ponto por onde toda chamada RPC passa**: novo `FcsMetodosEmAndamento`/`FdictMetodosEmAndamento` (dicionário de nomes de método em andamento). Uma segunda chamada do **mesmo método** enquanto a primeira ainda não terminou é **ignorada silenciosamente** (loga e retorna um JSON vazio, sem lançar exceção — clique duplo é situação esperada de operador, não erro real que mereça diálogo). Aninhamento entre métodos **diferentes** continua permitido (`fPassarCartao` esperando enquanto `pInfo21`/`pInfo30`/etc. da Modalidade Dinâmica precisam chegar durante essa espera) — só uma repetição do mesmo método é bloqueada.

**Efeito colateral aceito conscientemente**: para `fPassarCartao` especificamente, se a rejeição silenciosa devolver um JSON vazio, o chamador (`pPassaCartao` em `untTefCitelOperacoes.pas`) trata a ausência de `retorno` como se a transação tivesse tido problema (`fMensagem('Houve um problema com a transação...')`) — mensagem um pouco enganosa pro clique duplicado especificamente, mas segura (sem crash) e não foi endereçada nesta sessão; considerar revisar se incomodar no uso real.

**Ainda não recompilado/testado em campo.** Próximo passo: recompilar `libTefCitel.dproj`, sobrescrever `padra_atualizado\libTefCitel.dll`, reiniciar `autcom.exe`, tentar reproduzir de propósito clique duplo/repetido em "Crédito" E em "à vista" — esperado: sem crash, clique extra simplesmente ignorado (log mostra "IGNORADO"). Depois repetir o roteiro normal de clique único.


### Bug 3 (continuação 2, 2026-08-28) — clique rápido resolvido, mas botão "à vista" nunca se autodesabilita

**Confirmado por Rafael**: o guard de `fChamaRpc` (single-flight por nome de método) resolveu o clique rápido/duplo — `"referente ao clique rapido funcionou a trava"`. Mas achado novo, visual, direto do teste em campo: `"temos um problema no autcom o botão a vista fica o tempo todo habilitado, se o operador for persistente em querer ficar apertando o botão o problema acontece novamente"` — terceiro relatório completo do madExcept anexado, mesmo padrão de crash de sempre (`pExtraiFramesDisponiveis`, `Self` nulo). A diferença deste caso: não é sobreposição (o guard de `fChamaRpc` já bloqueia isso) — é clique **repetido ao longo do tempo**, cada um esperando o anterior terminar antes de disparar de novo, então cada clique é uma chamada nova e legítima do ponto de vista do guard (que só protege contra chamadas *simultâneas* do mesmo método, não contra repetição sequencial).

**Causa raiz (achada por leitura de código, `untTefCitelOperacoes.pas`)**: comparando os 5 handlers de botão da tela de operações TEF —
- `btnCreditoClick`/`btnDebitoClick`: desabilitam a si mesmos **e** os irmãos (`btnCredito.Enabled := False`, `btnDebito.Enabled := False`, `btnPix.Enabled := False`, etc.) antes de disparar `pPassaCartao`.
- `btnConfirmaClick` (parcelado): desabilita a si mesmo (`btnConfirma.Enabled := False`) antes de `pInfo21`/`pInfo30`/`pInfo34`.
- `pOnClickModalidadeDinamica`: desabilita TODOS os botões dinâmicos via `FobjModalidadeDinamica.pHabilitaBotoesModalidade(False)` antes de qualquer outra coisa — conferido, este caminho está correto.
- **`btnAVistaClick` é o único que não desabilita a si mesmo** — desabilita `btnParcAdm`/`btnParcEstab` (os irmãos), mas nunca `btnAVista.Enabled := False`. Inconsistência pontual de cópia/colagem entre handlers irmãos, não um problema de arquitetura ou de `blnPermiteSelecionarOpcao` (a flag em si está correta — o botão em si é que nunca fica fisicamente desabilitado, ficando sempre clicável visualmente e sujeito a qualquer janela de reentrância na flag).

**Corrigido (2026-08-28)** — `padra_atualizado\fontes\tef\TefCitel\untTefCitelOperacoes.pas`, `btnAVistaClick`: adicionada a linha `btnAVista.Enabled := False;` junto das outras (`btnParcAdm.Enabled := False; btnParcEstab.Enabled := False;`), mesmo padrão já usado em `btnCreditoClick`/`btnDebitoClick`/`btnConfirmaClick`. Fix mínimo e cirúrgico — só a linha faltante, sem tocar mais nada no handler.

**Ainda não recompilado/testado em campo.** Próximo passo: recompilar `autcom.exe` (ou o pacote/DLL que contém `untTefCitelOperacoes.pas` — confirmar em qual `.dproj` essa unit compila, provavelmente o próprio `autcom.exe`), reiniciar, repetir o teste clicando "à vista" persistentemente (vários cliques ao longo de alguns segundos, não só rápido) e confirmar que o botão fica visualmente desabilitado após o primeiro clique e não aceita mais cliques.

**Ainda em aberto, não investigado**: se os outros botões estáticos (`btnCredito`/`btnDebito`) e o fluxo de Modalidade Dinâmica realmente cobrem 100% dos casos (já conferido acima que sim, pelo código lido) — mas vale o Rafael confirmar em campo que nenhum outro botão da tela tem o mesmo tipo de lacuna, já que este bug já apareceu 2x por handlers "quase iguais" com uma diferença sutil de cópia/colagem.


### Teste de campo de débito (2026-08-28) — trava a tela, transação fica pendente na estação

**Sintoma reportado por Rafael**: "a questão do crédito foi resolvido" (guard de clique duplo confirmado funcionando). Mas ao testar **débito**, a tela do `autcom.exe` trava e a transação segue seu fluxo normal na estação até ficar pendente — sem crash/madExcept desta vez (diferente do Bug 3), sugerindo travamento real (hang), não corrupção de memória.

**Reconstrução da linha do tempo pelos 3 logs anexados** (`TefCitelDvcPlugin.log`, `TefEstacaoService.log`, `TefCitelDvcTransporte.log` — os dois primeiros no relógio da estação, o terceiro no relógio do servidor, sem sincronismo entre si):
- `fPassarCartao` (débito, id=8) despachado na estação; hook `AntesPassarCartao` respondido em ~40ms (frame de 261 bytes que não aparece logado como "chamada" no `TefEstacaoService.log` é justamente esse `hook_resposta` — tipo sem log próprio no roteador, não é bug, é ausência de log por design).
- Modalidade Dinâmica: operador clica, `pInfo21` (id=9) despachado e respondido com sucesso em ~11ms.
- Tráfego de "evento" (progresso do pinpad) continua chegando em rajadas normais por mais ~22s depois disso — consistente com o SDK nativo (Scope/SiTef) ainda processando de verdade a transação de débito (não é sintoma de travamento, e sim de atividade real).
- Depois da última rajada, ~19.7s de silêncio total nos 3 logs, e então o canal DVC é fechado "pelo lado autcom.exe" — e só NESSE EXATO INSTANTE o `TefEstacaoService.log` registra `fPassarCartao (id=8) retornou com sucesso` — mesmo padrão de "conclusão por artefato de fechamento", já visto antes nesta investigação (a resposta não é uma conclusão nativa real, é o efeito colateral do canal caindo).

**Hipóteses investigadas e descartadas** (leitura de código, sem instrumentação nova):
- Timeout artificial em alguma camada de transporte/hook: descartado — `IA\rules\tef-dvc.md` confirma que nenhuma camada tem teto sobre a chamada TEF em si (`fChamaRpc` usa `WaitFor(INFINITE)`; `TEF_ESTACAO_TIMEOUT_HOOK_MS = 30000` é só para o hook síncrono auxiliar, não fecha o canal).
- `ModalResult := mrOk` setado de forma aninhada (dentro de `pOnClickModalidadeDinamica`, `btnConfirmaClick`, `pOnClickConfirmarOpcoes`) enquanto o `fPassarCartao` externo ainda está pendente: **descartado após reanálise** — o loop `DoModal` do `ShowModal` só reage ao `ModalResult` quando `Application.HandleMessage`/`btnDebitoClick` retornar de verdade (mesmo aninhado várias camadas de `Application.ProcessMessages`/`fChamaRpc`), então não fecha o form prematuramente. Padrão idêntico já é usado com sucesso no fluxo de crédito com parcelamento.
- `objTefCitel` sendo destruído/recriado no meio da transação: descartado — o reset em `untTefCitelUtil.pas` (`pIniciaTefCitel`, linha ~748-750) só roda uma vez por login/sessão, não por swipe.
- Hooks (`SucessoTefCartao`, `DepoisPassarCartao` etc.) fazendo alguma chamada reentrante que travaria a thread de leitura via `TThread.Synchronize`: descartado — `TImplEventosTefCitel.pSucessoTefCartaoEvent` está vazio, `pDepoisPassarCartaoEvent` só chama `fLockUnlockTefCitel`, nada reentrante.

**Instrumentado (2026-08-28)** — log antes/depois de cada `TThread.Synchronize` em `pTrataEvento`/`pTrataHook`, e log de todo frame recebido/casado (`pOnFrameRecebido`/`pTrataResposta`), em `libTefCitel\untTefCitelDvc.pas` — sem mudar comportamento. Repetido o teste de débito com essa instrumentação: **causa raiz confirmada de forma decisiva pelo próprio log**.

**Causa raiz confirmada — deadlock real, não crash**: sequência exata capturada no `TefCitelDvcTransporte.log` instrumentado —
```
pTrataEvento: status="131" - entrando no Synchronize...
Enviando envelope tipo="chamada" metodo="pInfo21" id=10...
Envelope tipo="chamada" metodo="pInfo21" id=10 enviado com sucesso.
[... silêncio total, nunca aparece "pTrataEvento: Synchronize retornou." ...]
```
`untTefCitelOperacoes.pas`, `pMsgInfo131` (comentário no próprio código: "somente operação de débito") — quando a rede não exige Modalidade Dinâmica, despacha `pInfo21` de forma **síncrona, direto dentro do tratamento do evento** (`strModalidade := '1'; ...; pInfo21(strModalidade);`). Esse `pMsgInfo131` é chamado por `AtualizaTefCitel` ← `pNotifica` ← `TThread.Synchronize` dentro de `pTrataEvento` — ou seja, roda **em nome da própria thread de leitura do canal DVC**, que fica bloqueada esperando essa chamada terminar. `pInfo21` (via `fChamaRpc`, na thread principal) manda o envelope e **espera a resposta chegar pela mesma thread de leitura que está presa esperando ele terminar** — espera circular, sem saída possível. Confirmado pelo `TefEstacaoService.log`: `pInfo21` (id=10) foi despachado e retornou com sucesso do lado da estação em 6ms — a resposta simplesmente nunca conseguiu chegar de volta no autcom, porque quem a entregaria estava paralisado. A tela trava para sempre (não é crash — bate com o print anexado pelo Rafael mostrando "Aguarde... /" congelado); só ~44s depois, quando o RDP desiste do canal por inatividade total do autcom (não por decisão do nosso código — confirmado, nenhuma camada chama `WTSVirtualChannelClose` por timeout), tudo é derrubado e `fPassarCartao` "retorna com sucesso" na estação (artefato do fechamento, não conclusão nativa real) — daí a transação "ficar pendente".

**Por que só débito**: no fluxo clássico (`CFG_TEFDVC = N`), `pInfo21` é uma chamada direta em processo, sem round-trip de rede nem troca de thread — o mesmo código legado sempre foi seguro. Só a arquitetura DVC introduz uma thread de leitura separada cuja cooperação vira necessária para `pInfo21` completar, criando a reentrância perigosa. Crédito (neste ambiente de teste) sempre passou pela sub-tela de parcelamento/Modalidade Dinâmica (clique do operador, mensagem Windows separada, sem aninhamento) — nunca exercitou este caminho específico.

**Corrigido (2026-08-28)** — `libTefCitel\untTefCitelDvc.pas`, `pTrataEvento`: trocado `TThread.Synchronize` por `TThread.Queue`. A notificação de evento deixa de bloquear a thread de leitura — ela volta na hora para `WTSVirtualChannelRead`, livre para entregar a resposta de qualquer chamada RPC que o processamento do evento venha a disparar. Evento já era documentado como "notificação de progresso best-effort" (sem persistência/retry, ao contrário de "resposta") — mudar a entrega para assíncrona é consistente com essa natureza. Não viola `IA\rules\tef-dvc.md` — não adiciona teto de tempo sobre a chamada TEF em si, só muda como a notificação chega na thread principal. `pTrataHook` continua com `Synchronize` (precisa do resultado síncrono do hook pra montar a resposta, e os handlers de hook são triviais/não-reentrantes — sem o mesmo risco). Logs de diagnóstico temporários removidos (função cumprida).

**Ainda não recompilado/testado em campo.** Próximo passo: recompilar `libTefCitel.dproj`, sobrescrever `padra_atualizado\libTefCitel.dll`, reiniciar `autcom.exe`, repetir o teste de débito (rede sem Modalidade Dinâmica, o cenário exato do bug) e confirmar que a tela não trava mais e a transação completa normalmente — depois repetir crédito e débito com Modalidade Dinâmica pra confirmar zero regressão.


### Teste de débito seguinte (2026-08-28) — deadlock resolvido, novo bug: framing corrompe com payload grande, tela nunca fecha

**Confirmado por Rafael**: o fix do `TThread.Queue` funcionou — sem mais travamento tipo deadlock, a mensagem final ("Transacao completa") apareceu na tela. Mas a tela **não fechou** e a operação não seguiu adiante — precisou encerrar o `autcom.exe` manualmente. TEFTRA não foi atualizada com os dados da transação.

**Reconstrução pelos 3 logs anexados** (nova sessão, ids reiniciados): `fPassarCartao` (débito, id=3) dispara, hook `AntesPassarCartao` ok, e o `pMsgInfo131` (rede sem Modalidade Dinâmica) chama `pInfo21` repetidamente a cada novo evento de status 131 (ids 4 a 10, sete vezes ao longo de ~21s — cada uma respondendo em poucos ms, sem mais deadlock, confirma o fix anterior). Em seguida, o hook `DepoisPassarCartao` chega (payload grande, carrega os dados da transação) e é respondido; a estação loga `"Metodo fPassarCartao (id=3) retornou com sucesso."` às 14:38:40.315 e o plugin confirma repassar **dois frames grandes ao autcom** (2297 e depois 2284 bytes — o hook `DepoisPassarCartao` e a resposta final de `fPassarCartao`, ambos carregando o mesmo payload de retorno: cupom, dados do cartão etc.). **A partir daí, silêncio total** no log do autcom (só `WTSVirtualChannelRead expirou` a cada 2s, sem nenhum "frame recebido"/"resposta") por quase 3 minutos, até o Rafael clicar em "9-Encerra" (dispara `pSair`, id=11 — despachado e respondido do lado da estação, mas a resposta **também nunca chegou** de volta no autcom) e finalmente encerrar o `autcom.exe` manualmente.

**Causa raiz — bug real de enquadramento no transporte, não da aplicação**: `libTefCitel\untTefCitelDvcTransporte.pas`, `fExtraiPayloadWts` — o comentário original do arquivo (desde o início desta investigação) já avisava: a heurística de remoção do `CHANNEL_PDU_HEADER` do prototipo **nunca foi validada com payloads maiores** que o PING/PONG de 4 bytes original. Até agora (2026-08-28), nenhuma mensagem trafegada excedia o tamanho de um único chunk do canal DVC — a resposta de `fPassarCartao`/hook `DepoisPassarCartao` (2000+ bytes, carregando cupom e dados do cartão) foi a **primeira vez** que um payload precisou de múltiplos chunks. A heurística antiga só removia o header quando o chunk tinha a flag `CHANNEL_FLAG_FIRST` ou `CHANNEL_FLAG_LAST` — um chunk do **meio** (payload grande o bastante pra 3+ chunks) tem `Flags=0` e caía no fallback que trata o buffer inteiro (incluindo os 8 bytes do header) como payload puro — corrompendo o enquadramento por tamanho (`pExtraiFramesDisponiveis`) dali em diante: o próximo `LintTamanhoFrame` lido virava lixo, o código ficava esperando pra sempre um número de bytes que nunca completaria, e **nenhum frame seguinte nunca mais era entregue** — nem a própria resposta de `fPassarCartao`, nem `pSair` depois. Sem crash, sem timeout — silêncio permanente, exigindo intervenção manual. Bate exatamente com os logs: a thread de leitura não trava (continua logando "expirou" normalmente, ao contrário do Bug 4), só nunca mais entrega nenhum frame reconhecido.

**Corrigido (2026-08-28)** — `fExtraiPayloadWts`: removida a exigência das flags `FIRST`/`LAST` — `WTSVirtualChannelRead` sempre devolve exatamente um `CHANNEL_PDU` por chamada (contrato documentado da API do Windows, não uma suposição nossa), então **todo** read que passa no teste de sanidade de `LTotalLength` começa com um header de verdade, tenha ele FIRST, LAST ou nenhuma das duas (chunk do meio) — o header deve ser removido sempre, não só quando uma das flags de borda está presente. Adicionado log leve (`pLogaDiagnosticoDvc`) só para chunks grandes (>32 bytes de dados), mostrando tamanho lido/`LTotalLength`/flags/dados extraídos — ajuda a confirmar em campo que a remontagem está correta desta vez.

**Ainda não recompilado/testado em campo.** Próximo passo: recompilar `libTefCitel.dproj`, sobrescrever a DLL, repetir o teste de débito (mesmo cenário, rede sem Modalidade Dinâmica) e confirmar: (1) a tela fecha sozinha ao final (`ModalResult := MrOk` executando de verdade); (2) TEFTRA atualizada corretamente; (3) o log mostra a mensagem `fExtraiPayloadWts: chunk grande...` para os payloads grandes, confirmando que a remontagem multi-chunk funciona.


### Teste de débito seguinte (2026-08-28) — fix do framing insuficiente, exceção real capturada

**Resultado**: o fix anterior (remover exigência das flags FIRST/LAST em `fExtraiPayloadWts`) **não resolveu por completo** — desta vez apareceu uma exceção real e controlada (não mais silêncio permanente): `ETefCitelDvcTransporte: "Frame recebido no canal DVC excede o tamanho maximo suportado (538976288 bytes)."`. **538976288 = 0x20202020 = quatro bytes ASCII de espaço** — confirma que o enquadramento por tamanho (`pExtraiFramesDisponiveis`) leu o prefixo de 4 bytes de um ponto no meio do texto do cupom (que tem bastante espaço de preenchimento, visível no dump da pilha do madExcept), ou seja, o alininhamento do stream ainda desanda em algum ponto ao lidar com o payload grande (2297/2284 bytes) de `fPassarCartao`/hook `DepoisPassarCartao`.

**Reanálise da hipótese anterior**: o log instrumentado (novo, desta rodada) mostrou o único chunk grande logado tinha `flags=1` (FIRST) — que **já passava no teste antigo** (`flags and (FIRST|LAST) <> 0`) mesmo antes do meu fix. Ou seja, a teoria de "chunk do meio com flags=0" não se aplica necessariamente a este caso específico (seria só 2 chunks: FIRST+LAST, nunca um chunk do meio) — o fix aplicado está correto em princípio (é mais fiel ao contrato da API), mas não foi o suficiente pra este cenário. Log parou de aparecer logo após o primeiro chunk (1604 bytes lidos, 1596 de dados) — o segundo chunk (resto da mensagem de 2297 bytes) nunca apareceu logado antes da exceção, e o buffer só ficou "maduro" pra estourar mais tarde, ao processar o payload seguinte (2284 bytes) — não há visibilidade suficiente no log anterior pra confirmar exatamente onde o desalinhamento aconteceu.

**Hipótese em aberto, não confirmada**: `WTSVirtualChannelRead` pode devolver, numa única chamada, **mais de um `CHANNEL_PDU` concatenado** (contrariando a suposição "uma leitura = um PDU" usada no fix anterior) — se isso acontecer, o código só removeria o header do PRIMEIRO PDU dentro do buffer, deixando um header de um PDU seguinte intacto no meio dos dados repassados. Não confirmado ainda — precisa do próximo teste com o log completo pra decidir.

**Instrumentado (2026-08-28), sem alterar mais nenhum comportamento** — `libTefCitel\untTefCitelDvcTransporte.pas`:
- `pLoopLeitura` — loga TODA leitura bem-sucedida (bytes lidos), não só as grandes.
- `fExtraiPayloadWts` — loga TODO chunk (removido o filtro de "só grande"), incluindo o caminho antigo "sem remoção de header" (antes silencioso) — se esse caminho aparecer no meio de uma sequência de chunks grandes, é sinal forte de desalinhamento.
- `pExtraiFramesDisponiveis` — antes de lançar a exceção de tamanho inválido, loga um dump forense (hex dos primeiros 64 bytes do buffer acumulado + tamanho total) — próxima vez que estourar, dá contexto completo pra decidir a causa exata sem precisar de outro round-trip de teste.

**Ainda não recompilado/testado em campo.** Próximo passo: recompilar `libTefCitel.dproj`, sobrescrever a DLL, repetir o teste de débito (mesmo cenário) e mandar o `%TEMP%\TefCitelDvcTransporte.log` completo — com a nova instrumentação, a sequência inteira de chunks (tamanho lido, totalLength, flags, dados extraídos) ficará visível, permitindo confirmar ou descartar a hipótese de "múltiplos PDUs numa mesma leitura" de forma definitiva.


### Bug 6 encontrado e corrigido em 2026-08-28 — pLogaDiagnosticoDvc não era thread-safe (achado auto-infligido pela própria instrumentação)

**Sintoma**: reteste do débito produziu um crash **diferente** do anterior — `EAccessViolation` (não mais `ETefCitelDvcTransporte`), com o próprio Rafael notando corretamente que o log parava exatamente em "pLoopLeitura: WTSVirtualChannelRead retornou 1604 bytes." sem a linha seguinte, mesmo depois de confirmar (via `Get-Item`/`Get-Content` direto do PowerShell, sem cache de editor) que o arquivo realmente parou de ser escrito naquele exato instante.

**Causa raiz, confirmada pelo relatório madExcept**: exceção `EAccessViolation` dentro de `@UStrClr` (rotina interna do Delphi que decrementa refcount de uma `String` ao sair de escopo), chamada de dentro do próprio `pLogaDiagnosticoDvc` (`untTefCitelDvcTransporte.pas`), chamada de `pLoopLeitura` na linha exata do log "retornou 1604 bytes". `pLogaDiagnosticoDvc` é chamada tanto pela thread de leitura do canal (`pLoopLeitura`, nesta unit) quanto pela thread principal (via `fChamaRpc`/`pEnviaEnvelope` em `untTefCitelDvc.pas`, quando um clique dispara uma chamada RPC) — **sem nenhuma proteção contra chamada concorrente**. Isso sempre foi um risco latente, mas só virou problema real quando, na mesma sessão, a frequência de chamadas aumentou muito (logando todo chunk/read, não só os grandes) para investigar o Bug 5 — aumentando a chance de duas threads chamarem a função ao mesmo tempo, corrompendo a alocação de string sob o gerenciador `ShareMem`/`BORLNDMM.DLL` (exigido pelo import `delayed` desta DLL).

**Importante**: isso explica por que o log "parava impossivelmente" sem nenhuma linha depois — não é um bug de lógica no meu código de parsing, é a própria função de log travando o processo antes de conseguir escrever a linha seguinte. A causa raiz do Bug 5 (framing corrompendo com payload grande) continua **não confirmada nem descartada** — a instrumentação para investigá-la é que introduziu esse bug novo, que precisa ser corrigido primeiro.

**Corrigido**: `untTefCitelDvcTransporte.pas` — nova `FcsLog: TCriticalSection` (global, criada/liberada em `initialization`/`finalization` da unit) protegendo o corpo inteiro de `pLogaDiagnosticoDvc`. A instrumentação detalhada do Bug 5 (log de todo chunk/read/frame) foi mantida — agora está segura contra chamada concorrente.

**Ainda não recompilado/testado em campo.** Próximo passo: recompilar `libTefCitel.dproj`, sobrescrever a DLL, repetir o teste de débito de novo — com o log agora seguro contra concorrência, a próxima tentativa deve finalmente revelar (sem mascarar com um crash de logging) se o Bug 5 (framing com payload grande) ainda existe ou não.


### Bug 6, continuação (2026-08-28) — critical section não bastou, causa real era FormatDateTime

**Reteste com a `FcsLog` protegendo `pLogaDiagnosticoDvc`**: crash aconteceu de novo, `EAccessViolation`, **mesmo endereço de leitura inválido** (`000002BE`) que o crash anterior — não é coincidência, indica corrupção de estado compartilhado, não simplesmente falta de lock local. Desta vez o callstack aponta para dentro de `FormatDateTime`/`DateTimeToString`/`@UStrAsg`, chamado por `pLogaDiagnosticoDvc` — **mesmo já estando dentro da `FcsLog`**. Isso prova que a causa não era (só) chamada concorrente à própria função de log — é que `FormatDateTime`/`Now` usam configurações de locale globais (`TFormatSettings`) que podem não ser thread-safe nesta versão do Delphi quando chamadas concorrentemente de QUALQUER outro ponto do `autcom.exe` (código legado extenso, fora do nosso controle) ao mesmo tempo que a thread de leitura chama a mesma rotina via log.

**Corrigido**: `pLogaDiagnosticoDvc` não usa mais `FormatDateTime`/`Now` — monta o carimbo de data/hora manualmente a partir de `GetLocalTime` (API do Windows, sem estado compartilhado da RTL do Delphi). Também reduzida a frequência de log de volta para só os chunks/frames grandes (>32 bytes) em `pLoopLeitura`/`fExtraiPayloadWts`/`pExtraiFramesDisponiveis` — os chunks pequenos (eventos/pInfo21) já foram exaustivamente confirmados corretos em múltiplos testes de campo, não precisam mais de log a cada ocorrência, e reduzir a frequência diminui a exposição a qualquer risco remanescente não identificado.

**Ainda não recompilado/testado em campo.** Próximo passo: recompilar `libTefCitel.dproj`, sobrescrever a DLL, repetir o teste de débito novamente. Se o crash persistir mesmo assim, o problema é mais fundamental que logging (possível corrupção de heap genuína na própria `fExtraiPayloadWts`/`pExtraiFramesDisponiveis` do Bug 5, manifestando em qualquer alocação de string subsequente) — nesse caso, considerar remover a instrumentação de diagnóstico por completo e investigar via outra estratégia (ex.: dump de memória, revisão linha a linha do parsing de multi-chunk sem depender de logs em campo).


### Bug 5, causa raiz confirmada e corrigida de vez (2026-08-28) — flags FIRST/LAST não são confiáveis neste canal

**Com o fix do Bug 6 (log sem `FormatDateTime`) e o dump forense já instrumentado, o próximo teste finalmente capturou a evidência decisiva**, sem mais crash mascarando o problema:

```
fProcessaChunkWts: chunk lido=1604 bytes, totalLength=2298 flags=2, acumulado=1596/... bytes.
pExtraiFramesDisponiveis: LintTamanhoFrame invalido (538976288 bytes). FarrBuffer tem 1596 bytes...
```

**Achado decisivo**: esse chunk chegou com `flags=2` (`CHANNEL_FLAG_LAST`, só essa) declarando `totalLength=2298` — mas só trouxe 1596 bytes de dados, e o buffer estava **vazio antes dele** (confirmado pelo log anterior, "restante no buffer=0 bytes" na última extração bem-sucedida). Ou seja: isso não era o segundo pedaço de nada acumulado — era o **primeiro** chunk desta mensagem, mesmo vindo marcado como "último". **As flags `CHANNEL_FLAG_FIRST`/`CHANNEL_FLAG_LAST` do `CHANNEL_PDU_HEADER` simplesmente não têm o significado que o padrão MS-RDPBCGR sugere nesta combinação específica (canal DVC dentro do `mstsc.exe`)** — não dá pra usar como sinal de "chunk completa a mensagem". Minhas duas tentativas anteriores (exigir a flag / não exigir a flag) estavam ambas presas nessa premissa errada.

**Corrigido de vez** — `libTefCitel\untTefCitelDvcTransporte.pas`: reescrita a lógica de remontagem (`fExtraiPayloadWts` renomeada para `fProcessaChunkWts`). Em vez de decidir "mensagem completa" pelas flags, agora acumula os dados de cada chunk em `FarrPayloadWtsParcial` e só entrega a mensagem pra frente quando o total acumulado atinge `FdwTotalWtsEsperado` — esse valor vem do campo `totalLength` do **primeiro** chunk visto de uma mensagem nova, e esse campo (ao contrário das flags) **sempre bateu com o tamanho real do payload em todos os testes de campo desta investigação**, mesmo quando as flags não faziam sentido nenhum. As flags continuam sendo logadas (útil pra diagnóstico), mas não influenciam mais nenhuma decisão do código.

**Ainda não recompilado/testado em campo.** Próximo passo: recompilar `libTefCitel.dproj`, sobrescrever a DLL, repetir o teste de débito mais uma vez — esta é a correção da causa raiz de verdade (não mais um paliativo em cima de uma suposição errada sobre as flags), então a expectativa agora é que o payload grande finalmente reassemble corretamente, a tela feche sozinha, e a TEFTRA seja atualizada.

**Correção (2026-08-28): o título acima ("corrigida de vez") foi precipitado — o teste de campo seguinte revelou uma falha nova dentro do próprio `fProcessaChunkWts`.** Ver seção seguinte.


### Bug 5, 3a causa — fProcessaChunkWts misturava bytes de duas mensagens diferentes (2026-08-28)

**Log do teste seguinte** (mesma exceção de sempre, `ETefCitelDvcTransporte`, "538976288 bytes" = espaços ASCII no meio do texto do cupom):

```
16:22:32.228  fProcessaChunkWts: chunk lido=1604 bytes, totalLength=2298 flags=2, acumulado=1596/2298 bytes.
[~30s só "WTSVirtualChannelRead expirou", nada mais]
16:23:02.229  fProcessaChunkWts: chunk lido=1604 bytes, totalLength=2284 flags=1, acumulado=3192/2298 bytes.
16:23:02.229  pExtraiFramesDisponiveis: LintTamanhoFrame invalido (538976288 bytes)...
```

**Achado decisivo**: o segundo chunk grande declara `totalLength=2284` — **diferente** do `totalLength=2298` do chunk anterior. Não são dois pedaços da mesma mensagem: são **duas mensagens diferentes**. A primeira (totalLength=2298, quase certamente o hook `DepoisPassarCartao`) nunca recebeu o resto dos seus bytes — ficou para sempre em 1596/2298, "abandonada". `fProcessaChunkWts` não tinha nenhuma forma de perceber isso: só zera `FdwTotalWtsEsperado`/`FarrPayloadWtsParcial` quando uma mensagem *completa*, então o chunk da mensagem nova (totalLength=2284) foi colado em cima do resto pendente da mensagem abandonada (1596+1596=3192), e como 3192 ≥ 2298 (o alvo velho, nunca atualizado), o código achou que a mensagem "completou" — entregando pra frente uma mistura de bytes de duas mensagens sem relação nenhuma, que `pExtraiFramesDisponiveis` então lê como lixo.

**Por que a mensagem 1 nunca completou — encaixa com o timeout do hook do lado da estação**: o gap de ~30s entre os dois chunks bate em cima do valor documentado `TEF_ESTACAO_TIMEOUT_HOOK_MS = 30000` (30s) do lado da estação — plausível que a estação tenha esperado o `hook_resposta` de `DepoisPassarCartao` (que o autcom nunca conseguiu montar/enviar de volta, porque nunca reassemblou o hook corretamente por causa deste mesmo bug), desistido com o "default seguro" já documentado em outro ponto do projeto, e seguido adiante mandando a resposta final de `fPassarCartao` (a mensagem 2, totalLength=2284) de qualquer jeito. Ou seja: este bug corrompe tanto o hook `DepoisPassarCartao` quanto a resposta final — o hook falha silenciosamente (timeout, sem crash), a resposta final é que estoura a exceção visível.

**Corrigido (2026-08-28)** — `fProcessaChunkWts`: ao ver um chunk cujo `totalLength` **não bate** com `FdwTotalWtsEsperado` já em andamento, o código agora reconhece que a mensagem anterior foi abandonada — descarta `FarrPayloadWtsParcial` acumulado e recomeça do zero com o `totalLength` do chunk novo. Loga a ocorrência (útil pra confirmar em campo que isso realmente foi o que aconteceu). Residual conhecido, aceito por ora: se os bytes restantes da mensagem abandonada chegarem *depois* de já termos começado a acumular a mensagem nova, eles vão corromper a mensagem nova em vez da antiga — mas esse cenário é bem menos provável que o observado (mensagem abandonada tende a nunca mais mandar nada, não a mandar atrasada), e o novo comportamento já é estritamente melhor que o anterior (que corrompia *todas* as mensagens seguintes para sempre, não só uma).

**Ainda não recompilado/testado em campo.** Próximo passo: recompilar `libTefCitel.dproj`, sobrescrever a DLL, repetir o teste de débito (mesmo cenário, rede sem Modalidade Dinâmica) e confirmar: (1) sem exceção `ETefCitelDvcTransporte`; (2) tela fecha sozinha; (3) TEFTRA atualizada corretamente; (4) se a mensagem "abandonada" (log "mensagem anterior abandonada...") aparecer, decidir se vale investigar por que o hook `DepoisPassarCartao` não completa antes do timeout da estação, ou se isso é aceitável como está.


### Teste de débito seguinte (2026-08-28) — SUCESSO ponta a ponta pela primeira vez; demora de ~30s isolada e diagnosticada (não corrigida — retomar segunda-feira)

**Confirmado por Rafael**: transação de débito completou do início ao fim sem exceção, sem crash, tela fechou e diálogo "transação autorizada" apareceu. Log mostra o fix do item anterior atuando corretamente: `fProcessaChunkWts: mensagem anterior abandonada (totalLength=2298, so chegou 1596 bytes) - descartando e iniciando nova mensagem com totalLength=2285.` — descartou a mensagem travada e remontou a nova certinho.

**Achado novo, relatado por Rafael**: demora perceptível de ~30s entre a tela mostrar "Transação completa" e o diálogo final de "transação autorizada" aparecer — só no débito, crédito não tem essa demora.

**Investigação (2026-08-28), cruzando os 3 logs do mesmo teste (autcom + plugin + estação):**

- Estação: `fPassarCartao (id=19)` despachado às 16:48:22.046, só retorna sucesso às 16:49:15.956 — ~54s de duração real da chamada nativa.
- Plugin (`untTefCitelDvcPluginImpl.pas`, `pLoopLeituraSocketWorker` ou equivalente): às 16:48:45.953 um único `recv()` trouxe os 2298 bytes **completos** de uma vez (sem fragmentação — confirmado pelo log, um `recv()` = 2298 bytes), e uma única chamada a `FChannel.Write` (API `IWTSVirtualChannel.Write`, lado cliente do RDP, código do Windows dentro do `mstsc.exe`, fora do nosso controle) repassou tudo de uma vez, retornando sucesso.
- autcom (`untTefCitelDvcTransporte.pas`): só recebeu 1596 desses 2298 bytes no primeiro (e único) `WTSVirtualChannelRead` — os ~700 bytes restantes nunca chegaram nos 30s seguintes (só timeouts "expirou"), até que uma mensagem **completamente diferente** (2285 bytes, a resposta final de `fPassarCartao`) apareceu.

**Conclusão**: nem o plugin (leu e escreveu tudo corretamente, log confirma) nem o autcom (ficou pacientemente tentando ler, sem desistir, sem timeout artificial — não viola `IA\rules\tef-dvc.md`) têm bug aqui. A perda dos ~700 bytes acontece **dentro da própria pilha RDP do `mstsc.exe`** (`IWTSVirtualChannel.Write` não entrega tudo a tempo ao lado servidor) — mesma família de instabilidade do canal DVC já mapeada nesta sessão (flags que não significam o que deveriam), agora aparecendo como demora (o hook `DepoisPassarCartao` nunca chega completo, autcom nunca manda `hook_resposta`, a estação espera os 30s do `TEF_ESTACAO_TIMEOUT_HOOK_MS` já documentado, desiste e segue em frente) em vez de corrupção — o fix desta sessão já evita a corrupção; a demora é um efeito colateral remanescente do mesmo problema de fundo.

**Achado adicional, relevante pra retomada de segunda-feira**: revendo o log completo do plugin desta mesma sessão, **toda vez que o débito foi testado hoje** (pelo menos 4 vezes, em janelas de conexão diferentes) apareceu o **mesmo par exato** de mensagens grandes (2298 bytes seguido de ~30s de silêncio, depois 2284/2285 bytes) — ou seja, isso não é flakiness aleatória de rede, é **determinístico para este hook específico no débito**. Ao mesmo tempo, o mesmo log do plugin mostra OUTRAS mensagens de tamanho parecido ou maior (2221, 2208, 1968, 1949 bytes, em outros pontos do fluxo) sendo repassadas sem nenhum sinal de demora — mas não temos o `TefCitelDvcTransporte.log` completo (só a partir de 16:48:10) pra confirmar se essas outras também precisaram de 2+ leituras (só que ambas chegaram rápido) ou se de fato couberam num único `WTSVirtualChannelRead`. **Essa é a lacuna de evidência a fechar primeiro na retomada**: pegar o `TefCitelDvcTransporte.log` completo (desde o início da sessão de testes, não só a partir de 16:48) e comparar diretamente a sequência de chunks dessas outras mensagens grandes contra a do hook problemático — se elas também exigem 2 leituras mas sempre entregam tudo rápido, o problema é específico deste hook/timing, não do tamanho em si.

**Pedido do Rafael**: documentar e retomar na segunda-feira (2026-08-31) — investigar especificamente **por que só no débito** isso acontece (crédito, no fluxo testado até agora, não exercitou hook de tamanho comparável — não confirmado se o hook do crédito é menor por natureza, ou se simplesmente nunca foi testado sob as mesmas condições).

**Não fazer sem re-confirmar primeiro (evitar retrabalho)**: não presumir que reduzir o payload do hook resolve — a evidência de mensagens de ~2200 bytes passando bem em outros pontos do mesmo log torna isso incerto; validar com o log completo antes de mexer no conteúdo do hook.


### Causa raiz da demora de 30s encontrada (2026-08-31) — timeout de leitura curto demais, comparado com DVC_v2

Rafael trouxe `DVC_v2\` — uma nova versão do protótipo de teste, com estatísticas de troca de dados em vários tamanhos de pacote (1 byte a 1 MiB) e um relatório (`DVC_v2\relatorio-teste-viabilidade-dvc.md`). Resultado: **105.600 mensagens de ida e volta, zero falhas**, inclusive em 256 KiB e 1 MiB, usando a mesma API (`WTSVirtualChannelRead`/`Write`) e o mesmo tipo de canal DVC.

**Diferença encontrada, comparando `DVC_v2\src\server\TefDvcServer.dpr` com `libTefCitel\untTefCitelDvcTransporte.pas`**: o protótipo usa `READ_TIMEOUT_MS = 15000` (15s) por chamada de `WTSVirtualChannelRead`; produção usava `TEF_DVC_TIMEOUT_LEITURA_MS = 2000` (2s) — a mesma chamada, timeout 7,5x menor.

**Hipótese, bem apoiada pela comparação**: quando `WTSVirtualChannelRead` expira com `ERROR_IO_INCOMPLETE` (996, já confirmado em campo como o erro real de timeout neste ambiente), a leitura pendente aparentemente descarta os dados que estavam prestes a chegar — não é "nada chegou ainda", é "chegou, mas foi perdido no cancelamento". Com timeout de 2s, qualquer chunk que demore mais que 2s (mas bem menos que 15s) pra chegar — como visto no hook `DepoisPassarCartao` no débito — cai nessa janela de perda; o protótipo, com 15s, nunca chegou perto desse limite mesmo em 1 MiB, por isso nunca expôs o problema em 105.600 tentativas.

**Corrigido**: `TEF_DVC_TIMEOUT_LEITURA_MS` subido de `2000` para `15000` (igual ao valor comprovado no `DVC_v2`). Confirmado seguro: `IA\rules\tef-dvc.md` já documenta esse timeout como "só o intervalo de poll" (o loop nunca desiste de verdade, só re-chama `WTSVirtualChannelRead`) — subir não viola a regra. O `Destroy` já desbloqueia uma leitura pendente na hora via `WTSVirtualChannelClose` direto (comentário no código: "desbloqueia o WTSVirtualChannelRead em espera") — não depende do timeout configurado pra encerrar rápido, então não há regressão de shutdown.

**Ainda não recompilado/testado em campo.** Próximo passo: recompilar `libTefCitel.dproj`, sobrescrever a DLL, repetir o teste de débito (mesmo cenário) e confirmar: (1) a mensagem "mensagem anterior abandonada" não aparece mais no log (ou aparece muito menos); (2) a demora de ~30s entre "Transação completa" e o diálogo final desaparece; (3) zero regressão em crédito, `fConfiguraTefCitel` e no encerramento normal do `autcom.exe` (não deve demorar mais pra fechar).


### Teste de campo (2026-08-31) — timeout de 15s NÃO resolveu; achado mais preciso comparando crédito x débito no mesmo teste

**Correção do item anterior**: a hipótese "timeout de leitura curto causa descarte de dado em trânsito" está **refutada por teste real**. Com `TEF_DVC_TIMEOUT_LEITURA_MS` já em 15000ms, o mesmo teste de débito reproduziu o **mesmo gap de ~30s, byte a byte igual** ao de antes (chunk 1 de uma mensagem `totalLength=2298` chega com 1596 bytes, depois nada por exatamente ~30s, depois uma mensagem *diferente* `totalLength=2285` aparece). O valor do timeout não é a causa. Mantido em 15000ms (não fez mal, só não foi suficiente) — não reverter sem motivo novo.

**Achado mais preciso, com o par de logs desta vez (crédito testado primeiro, débito depois, mesma sessão/canal DVC aberto o tempo todo)**:

- **Crédito**: `fPassarCartao (id=3)` despachado 07:46:48.140, retorna sucesso 07:47:20.580 (~32s, transação real). Nesse momento, **duas** mensagens grandes chegam em sequência **instantânea** (mesmo milissegundo, 07:47:20.549-591): 2219 bytes (2 chunks: 1604+631, ambos lidos no mesmo instante) e 2206 bytes (2 chunks: 1604+618, idem). **Ambas** disparam `Enviando envelope tipo="hook_resposta"` no log do autcom — ou seja, são dois **hooks** grandes (prováveis `DepoisPassarCartao` + `SucessoTefCartao`, que serializam o mesmo `IRetornoTEFCitel` completo, daí o tamanho parecido) e os dois se remontam perfeitamente, sem gap algum.
- **Débito**: `fPassarCartao (id=8)` despachado 07:47:51.086, retorna sucesso 07:48:49.444 (~58s). Só **uma** mensagem grande (`totalLength=2298`) começa a chegar (chunk de 1596/2298), e trava — nenhum `hook_resposta` é enviado pra ela (autcom nunca viu o payload completo, nunca processou o hook). ~30s depois (exatamente quando `fPassarCartao` retorna no log da estação), chega uma mensagem **diferente** (`totalLength=2285`) — sem `hook_resposta` nenhum associado a ela também. Isso bate com o formato da **resposta RPC** de `fPassarCartao` (não é hook, é `tipo="resposta"`, tratada por `pTrataResposta`, que não responde nada de volta) — confirmado lendo `fMetodoFPassarCartao` (`untTefEstacaoRoteadorMensagens.pas:1416-1428`): ela serializa o `IRetornoTEFCitel` inteiro no campo `result.retorno`, daí o tamanho parecido com os hooks.

**Conclusão até aqui**: o canal e a lógica de remontagem (`fProcessaChunkWts`) **funcionam corretamente** quando testados com crédito — duas mensagens do mesmo tamanho/natureza, no mesmo teste, entregues sem falha. O problema é **específico de um hook do débito** (`DepoisPassarCartao` ou `SucessoTefCartao` — ainda não confirmado qual dos dois, ambos enviam ~2.3KB) que trava e nunca completa, fazendo a estação esperar os 30s de `TEF_ESTACAO_TIMEOUT_HOOK_MS` e seguir com o "default seguro" (`untTefEstacaoRoteadorMensagens.pas:1220-1224`).

**Achado potencialmente importante, ainda não confirmado — ligação com a pendência antiga "TEFTRA sem dados"**: `pHookSucessoTefCartao` (`untTefEstacaoRoteadorMensagens.pas:1301-1316`) manda o `IRetornoTEFCitel` atual pro autcom via hook `SucessoTefCartao` e espera de volta um `retorno` (possivelmente atualizado) que substitui `ADadosTransacao` — só se a resposta trouxer o campo `retorno`. No autcom (`untTefCitelDvc.pas:1111-1118`), o handler desse hook mesmo chama `FSucessoTefCartao(LRetorno)` (callback de negócio registrado por `untTefCitelOperacoes.pas`, ainda não lido) antes de responder. **Se for esse o hook que trava, `FSucessoTefCartao` NUNCA executa no débito** — o que pode explicar diretamente a pendência já registrada (TEFTRA sem os dados que a marcariam como pendente). Ainda não confirmado qual dos dois hooks é o que trava, nem o que `FSucessoTefCartao` faz de fato — **não presumir e não implementar nada em cima disso sem confirmar primeiro** (risco de retrabalho já visto nesta investigação).

**Instrumentado (2026-08-31)**, aguardando novo teste de campo:
- `libTefCitel\Estacao\untTefEstacaoRoteadorMensagens.pas`, `fEnviaHookEAguarda` — loga `hook="<nome>" id=<n> despachado`, depois `respondido em <ms>` OU `ESTOUROU o timeout de <ms> ... aplicando default seguro`, com o nome do hook em todos os casos.
- `libTefCitel\untTefCitelDvc.pas`, `pTrataHook` — loga `hook="<nome>" id=<n> recebido` logo que o frame chega completo e é parseado (antes do `Synchronize`) — se o hook travar na remontagem do canal, este log simplesmente não aparece pra ele (evidência por ausência: comparar a lista de hooks despachados do lado estação com a lista de hooks recebidos do lado autcom vai apontar exatamente qual um falta).

**Próximo passo**: recompilar `libTefCitel.dproj` (unit compartilhada entre `TefEstacaoService.exe` e `autcom.exe`/DLL), redistribuir os dois lados, repetir o teste de débito e trazer os 3 logs de novo. Vai confirmar: (1) qual hook especificamente trava; (2) se ele também dispara em crédito (só que sem travar) ou se é exclusivo do débito; (3) — cruzando com `pHookSucessoTefCartao`/`FSucessoTefCartao` — se esse callback de negócio realmente fica sem rodar no débito, fechando ou descartando a hipótese da pendência de TEFTRA.


### Hook identificado (2026-08-31): `DepoisPassarCartao` — mas SEM ligação com a pendência de TEFTRA (hipótese descartada)

**Confirmado pelo teste com a instrumentação nova**: `TefEstacaoService.log` mostra exatamente `pEnviaHook: hook="DepoisPassarCartao" id=5 despachado.` às 08:19:42.547, seguido 30016ms depois por `... ESTOUROU o timeout de 30016 ms (esperado 30000 ms) - aplicando default seguro.` às 08:20:12.561 — o hook que trava no débito é o `DepoisPassarCartao`, sempre este mesmo (bate com o `totalLength=2298` já visto nos dois testes anteriores).

**Hipótese da pendência de TEFTRA descartada, com evidência**: lido `padra_atualizado\fontes\tef\TefCitel\untTefCitelUtil.pas:3085-3092` — o callback registrado pro autcom (`TImplEventosTefCitel.pDepoisPassarCartaoEvent`) é:
```pascal
class procedure TImplEventosTefCitel.pDepoisPassarCartaoEvent(AobjRetorno: IRetornoTEFCitel);
begin
  if not Assigned(AobjRetorno) then
    fLockUnlockTefCitel(False);
end;
```
Só libera um lock (multi-sessão) quando `AobjRetorno` vem **nil** — no caminho de sucesso (que é o caso aqui: a transação real termina bem, só o hook que trava), `AobjRetorno` sempre vem preenchido, então esse `if` nunca dispararia de qualquer jeito, mesmo que o hook completasse normalmente. **Ou seja: pular esse hook inteiro no débito não tem NENHUMA consequência funcional além dos 30s perdidos** — não mexe em TEFTRA, não deixa lock preso (o unlock de verdade do caminho de sucesso acontece no hook `DepoisFinalizarTransacao`, que completou normalmente nos dois testes de hoje). A pendência antiga ("TEFTRA sem dados") continua **sem explicação encontrada** — não é isto.

**Curiosidade secundária encontrada, NÃO investigada, não bloqueia nada**: no teste de crédito de hoje, o log do autcom mostra `pTrataHook: hook="DepoisPassarCartao" id=2 recebido.` **duas vezes** (08:18:54.593 e 08:18:54.628) — a segunda ocorrência aparece no meio da remontagem AINDA INCOMPLETA da segunda mensagem grande (chunk `totalLength=2206`, só 1596/2206 acumulado nesse instante) e loga `frame extraido (tamanho=2215)` — um tamanho que só bate com a PRIMEIRA mensagem (2219-4=2215), não com a segunda (2206-4=2202 seria o esperado). Parece um artefato de log duplicado (a estação só despachou e recebeu resposta UMA vez, `pEnviaHook`/`pTrataHookResposta` confirmam isso, então não teve efeito funcional real) — mas vale investigar depois com calma, não durante esta sessão focada no débito.

**Estado**: causa do hook travar continua a mesma de antes (perda dentro da pilha RDP/DVC do Windows, fora do nosso código — confirmado outra vez hoje, canal e reassembly funcionam bem quando o mesmo tipo de payload chega em crédito). Impacto real, agora confirmado: **só os 30 segundos de demora, nada mais** — sem risco de dado incompleto ou lock preso. Combinado com o Rafael: decidir se vale investir em diagnóstico de nível RDP/OS (captura de rede, ETW) pra entender por que só esse hook falha no débito, ou aceitar a demora como está, dado que não corrompe nada.


### Achado adicional (2026-08-31) — hook duplicado no crédito, suspeita de bug próprio (não do canal)

**Rafael discordou de aceitar a demora** — apontou dois motivos fortes pra não aceitar: (1) não faz sentido travar sempre no débito e nunca no crédito; (2) o `DVC_v2` (protótipo com 105.600 idas-e-voltas testadas, várias cargas até 1 MiB) nunca reproduziu nada parecido — o que sugere bug na NOSSA estrutura de empacotamento/desempacotamento, não limitação do canal em si.

**Achado que sustenta essa suspeita**: no log de crédito de hoje, `pTrataHook: hook="DepoisPassarCartao" id=2 recebido.` aparece **duas vezes** (08:18:54.593 e 08:18:54.628), cada uma seguida de um envio real de `hook_resposta` (efeito colateral de rede, não só log duplicado). A estação, porém, só despachou e recebeu resposta **uma vez** (confirmado no `TefEstacaoService.log` — a segunda resposta chegou lá e foi ignorada silenciosamente, id já resolvido). Ou seja: o autcom processa o MESMO hook duas vezes — um bug real, do nosso lado, que o `DVC_v2` (teste simples de eco, sem essa camada de hooks/RPC aninhado) nunca poderia expor.

**Hipótese líder, ainda não confirmada**: `fChamaRpc` (`untTefCitelDvc.pas:889-895`) bombeia `CheckSynchronize(0)` E `Application.ProcessMessages` no mesmo laço enquanto espera qualquer RPC (inclusive a própria `fPassarCartao`, pendente pelos minutos inteiros da transação) — misturar os dois é padrão conhecido problemático em Delphi (o `ProcessMessages` já processa a fila de `Synchronize` internamente; o `CheckSynchronize` explícito pode fazer o mesmo item da fila ser despachado duas vezes sob certas condições de corrida). Bate com "só no débito": o débito dispara muitas chamadas `pInfo21` aninhadas *dentro* da espera de `fPassarCartao`, multiplicando a janela de corrida; o crédito aninha bem menos.

**Instrumentado (2026-08-31), sem alterar comportamento** — `libTefCitel\untTefCitelDvcTransporte.pas`, `pLogaDiagnosticoDvc`: adicionado `FdwSeqLog: DWORD` (contador monotônico, incrementado dentro da seção crítica `FcsLog` — narra a ORDEM REAL de entrada nesta função, não sujeita à resolução de milissegundo do `GetLocalTime`) e `tid=<ThreadId>` em toda linha de log (`[seq=N tid=T]` antes da mensagem). Isso deve provar, sem ambiguidade, se `pTrataHook` do hook duplicado roda de fato duas vezes na MESMA thread (main) ou se há outra explicação, e mostrar a ordem exata de entrelaçamento entre a thread de leitura e a principal ao redor do hook problemático.

**Não fazer ainda**: não mexer em `fChamaRpc` (remover `CheckSynchronize`) sem essa prova — já são 2 tentativas de fix que não resolveram nesta sessão (timeout de leitura, framing por flag/totalLength); seguir o combinado com o Rafael de confirmar o mecanismo antes de tocar no código de novo.

**Próximo passo**: recompilar `libTefCitel.dproj`, redistribuir, repetir o teste de débito (e se possível crédito de novo, pra capturar outro caso do hook duplicado com a nova instrumentação) e trazer os logs. Examinar especificamente: a sequência `seq=`/`tid=` ao redor de QUALQUER hook, e principalmente ao redor do hook que trava no débito e do hook duplicado no crédito.


### Teste com seq=/tid= (2026-08-31) — duplicidade PROVADA real, mecanismo exato ainda em aberto

**Resultado decisivo**: o `seq=` (contador monotônico, não sujeito a resolução de milissegundo) prova que a duplicidade do hook `DepoisPassarCartao` no crédito **não é artefato de log** — é uma segunda chamada real e sequencial:
```
[seq=109 tid=103092]  pLoopLeitura: WTSVirtualChannelRead retornou 1604 bytes.
[seq=110 tid=103092]  fProcessaChunkWts: chunk lido=1604 bytes, totalLength=2206 flags=1, acumulado=1596/2206 bytes.
[seq=111 tid=103092]  pExtraiFramesDisponiveis: frame extraido (tamanho=2215), restante no buffer=0 bytes.
[seq=112 tid=103092]  pTrataHook: hook="DepoisPassarCartao" id=2 recebido.
```
O seq=110 mostra `acumulado=1596/2206` — **incompleto** (1596 < 2206, `fProcessaChunkWts` deveria retornar vazio, `pLoopLeitura` não deveria chamar `pAcumulaBytesRecebidos`/`pExtraiFramesDisponiveis`). Mas o seq=111 mostra que rodou mesmo assim, extraindo um frame de tamanho 2215 — que não bate com a mensagem atual (2206-4=2202 seria o esperado) e SIM com a extração anterior (seq=105, mensagem #1, 2219-4=2215).

**Duas hipóteses em aberto, ainda não decididas**:
1. **Replay/retransmissão no canal RDP** (fora do nosso código): o Windows entrega os MESMOS bytes da mensagem #1 uma segunda vez, e nosso código, sem deduplicação, reprocessa.
2. **Bug de indexação no nosso lado**: alguma leitura de `FarrBuffer` fora de ordem/contexto produz um "frame" com conteúdo que não é da mensagem atual nem uma cópia exata da anterior, só coincide em tamanho.

**Instrumentado (2026-08-31), sem alterar comportamento** — `libTefCitel\untTefCitelDvcTransporte.pas`:
- `pAcumulaBytesRecebidos` — loga `recebidos %d bytes pra acumular (buffer tinha %d bytes antes)` logo na entrada. Esta é a ÚNICA porta de entrada pra `FarrBuffer` crescer — se aparecer um log daqui bem no meio de uma acumulação "incompleta" (como o cenário seq=110→111 acima), prova que `fProcessaChunkWts` REALMENTE devolveu um payload não-vazio ali (não é bug de reentrância em outro lugar).
- `pExtraiFramesDisponiveis` — a linha `frame extraido` ganhou `inicio (hex): <24 bytes>` do conteúdo do frame extraído. Vai permitir comparar byte a byte se a "duplicata" é uma cópia EXATA do conteúdo da extração anterior (aponta pra hipótese 1, replay do canal) ou conteúdo diferente/lixo que só coincide em tamanho (aponta pra hipótese 2, bug nosso).

**Ainda não fazer**: não mexer em `fChamaRpc` (a suspeita de `CheckSynchronize`+`ProcessMessages`) nem em mais nada até esse próximo teste separar as duas hipóteses — já são 2 tentativas de fix que não resolveram nesta sessão, aguardando prova antes de tentar a 3ª.

**Próximo passo**: recompilar, redistribuir, repetir débito (e crédito se possível, pra pegar outro caso do hook duplicado) e trazer os logs. Examinar especificamente: o log `pAcumulaBytesRecebidos: recebidos...` aparece ou não entre seq=110 e seq=111 (ou equivalente na nova rodada)? E o hex do `frame extraido` da "duplicata" bate byte a byte com o hex da extração anterior?


### Protocolo de quadro v2 implementado (2026-08-31) — Fase 1: messageId + CRC32 + deduplicação

**Decisão do Rafael**: em vez de continuar só investigando se a duplicidade é replay do canal RDP ou bug próprio, reformular a camada de transporte pra ter rastreabilidade e segurança independente da causa exata — pedido explícito: "ACK de aplicação após commit, messageId, hash persistido, deduplicação ou retomada após reconexão" (os mesmos itens do `DVC_v2\relatorio-teste-viabilidade-dvc.md`, seção 13). Combinado fazer em fases: **Fase 1 agora** (messageId + CRC32 + dedup), Fase 2 (ACK de transporte + retry) e Fase 3 (retomada após reconexão) ficam pra depois, só se a Fase 1 não for suficiente.

**Implementado, nos dois lados (formato de quadro tem que ser byte a byte idêntico — o plugin só repassa bytes crus, sem reencapsular)**:

Novo layout de quadro: `[4 bytes tamanho total][4 bytes messageId][4 bytes CRC32][N bytes payload JSON]` — antes era só `[4 bytes tamanho][N bytes payload]`.

- `libTefCitel\untTefCitelDvcTransporte.pas` (AUTCOM): `TEF_DVC_FRAME_METADATA_SIZE=8`, `FintProximoMessageId`/`FdwUltimoIdRecebido` novos campos, `fCrc32` (CRC-32 IEEE 802.3, bit a bit, sem tabela), `pEnviaFrame` grava messageId+CRC no quadro, `pExtraiFramesDisponiveis` valida CRC e deduplica por messageId ANTES de repassar ao `FOnFrameRecebido` — quadro inválido é descartado e logado (`Continue`), nunca mais processado nem levanta exceção (a exceção de "tamanho de frame inválido" continua existindo só pro caso do PRÓPRIO prefixo de 4 bytes vir corrompido — cenário mais raro que antes, já que agora o CRC pega corrupção no meio do payload sem precisar do prefixo estar certo).
- `libTefCitel\Estacao\untTefEstacaoTcpTransporte.pas` (estação): espelho exato — `TEF_ESTACAO_FRAME_METADATA_SIZE`, mesmos campos, mesma `fCrc32` (duplicada de propósito, não extraída pra unit compartilhada, pra evitar mexer em search-path de dois `.dproj` diferentes — ver nota em `IA\rules\tef-dvc.md`). `FintProximoMessageId`/`FdwUltimoIdRecebido` resetam a cada `accept()` novo (o objeto persiste entre conexões de plugin, ao contrário do lado autcom que é recriado por sessão).
- `IA\rules\tef-dvc.md` ganhou uma seção nova documentando o contrato do quadro v2 e a regra de nunca mudar um lado sem o outro.

**O que isso resolve, independente da causa raiz do hook duplicado (ainda não confirmada)**: um quadro repetido (seja por replay do canal RDP ou por reprocessamento indevido do nosso lado) agora é detectado pelo `messageId` e descartado silenciosamente, em vez de disparar `pTrataHook`/`hook_resposta` duas vezes. Um quadro corrompido no meio do payload (CRC não bate) também é descartado e logado, em vez de virar `ETefCitelDvcTransporte`/exceção. A instrumentação anterior (`seq=`/`tid=`, hex dump manual) fica obsoleta pra essa investigação específica — o log novo já mostra `messageId` e o motivo do descarte diretamente.

**Ainda não implementado (fica pra Fase 2/3 se necessário)**: ACK de transporte separado do `hook_resposta`/`resposta` de negócio (hoje a detecção de perda ainda depende do timeout de 30s do hook do lado estação); retomada de quadros não confirmados após reconexão do canal (hoje `messageId`/dedup são por conexão, não persistem — um quadro perdido continua perdido, só não é mais reprocessado incorretamente se reaparecer).

**Ainda não recompilado/testado em campo.** Próximo passo: recompilar `libTefCitel.dproj` (afeta tanto a DLL do autcom quanto o `TefEstacaoService.exe`, já que ambos compartilham a pasta `libTefCitel\`), redistribuir os dois lados, repetir débito e crédito. Confirmar: (1) zero regressão (tudo que funcionava continua funcionando, incluindo os quadros grandes multi-chunk); (2) se a duplicidade do hook `DepoisPassarCartao` no crédito ainda aparece nos LOGS como "quadro duplicado descartado" (prova que a Fase 1 neutralizou o sintoma, mesmo sem ter confirmado a causa raiz exata); (3) se a demora de 30s no débito muda de alguma forma (não devia mudar ainda — só será atacada na Fase 2).


### Fase 1 confirmada em campo (2026-08-31) — hook duplicado neutralizado; demora do débito inalterada (esperado)

**Resultado**: crédito e débito testados de novo. **Sucesso na Fase 1** — o hook `DepoisPassarCartao` do crédito, que antes disparava `pTrataHook`/`hook_resposta` duas vezes, agora aparece assim no log do autcom:
```
pExtraiFramesDisponiveis: quadro duplicado descartado (messageId=29, ultimo aceito=29).
...
pExtraiFramesDisponiveis: quadro aceito (messageId=30, tamanho=2215)
pTrataHook: hook="DepoisPassarCartao" id=2 recebido.
```
Só uma execução do hook, confirmado também no `TefEstacaoService.log` (só uma linha "respondido em 31 ms", não duas). O dedup por `messageId` está funcionando exatamente como desenhado.

**Achado adicional**: o mesmo padrão de "reaparecimento de dado antigo" (que causava o hook duplicado) também apareceu numa mensagem PEQUENA e comum (messageId=60, fora do contexto de hooks grandes) — `pAcumulaBytesRecebidos: recebidos 519 bytes` reaparecendo bem no meio da acumulação incompleta da mensagem seguinte, com o mesmo tamanho exato da mensagem messageId=60 já processada um ciclo antes. Isso reforça que o mecanismo de fundo (ainda não explicado com certeza) não é exclusivo de payloads grandes — mas como o dedup pega de qualquer jeito, deixa de ser urgente entender o mecanismo exato pra manter a comunicação segura.

**Demora do débito**: inalterada, como esperado — `DepoisPassarCartao id=5` despachado, estourou o timeout de 30016ms igual antes. A Fase 1 não ataca isso (só integridade/duplicidade); precisa da Fase 2 (ACK de transporte + retry) pra reduzir essa demora.

**Decisão pendente com o Rafael**: avançar pra Fase 2 (ACK de transporte, separado do hook_resposta/resposta de negócio, com retry curto ~2-3s reenviando o MESMO messageId — seguro porque o dedup do receptor garante que o reenvio não duplica processamento) para atacar a demora de 30s, ou pausar aqui e validar mais a Fase 1 primeiro.


### Fase 2 implementada (2026-08-31) — ACK de transporte + retry

**Decisão do Rafael**: avançar direto pra Fase 2.

**Desenho**: quadro ganhou um campo `tipo` (1 byte, `DADO`=0 ou `ACK`=1) além de `messageId`+`CRC32` da Fase 1. Ao aceitar um quadro `DADO` (ou reconhecer como duplicata), o receptor manda de volta um quadro `ACK` (seu próprio `messageId`, payload = 4 bytes do `messageId` sendo confirmado) — **antes** de repassar ao roteador, pra não esperar o processamento de negócio (hook/RPC) terminar. `pEnviaFrame` registra um `TEvent` por `messageId` pendente (`FdictAcksPendentes`, protegido por `FcsAcks`), escreve o quadro, espera o ACK por `TEF_*_ACK_TIMEOUT_MS=2000ms`; se não chegar, reenvia o MESMO quadro (mesmo messageId/CRC) até `TEF_*_ACK_MAX_TENTATIVAS=5` vezes (~10s no pior caso) antes de desistir com uma exceção — tratada exatamente como as falhas de escrita que já existiam antes (todo ponto de chamada já tolera isso).

**Implementado nos dois lados** (`untTefCitelDvcTransporte.pas` e `untTefEstacaoTcpTransporte.pas`), espelhado byte a byte:
- `fMontaFrame` (monta o quadro completo, usado tanto pra DADO quanto ACK), `pEnviaFrameBruto` (só escreve bytes, sem esperar ACK — usado pelos reenvios E pelo próprio envio de ACK, que nunca espera ACK de volta), `pEnviaAck` (monta e envia um quadro ACK referenciando um messageId).
- `pExtraiFramesDisponiveis`: quadro `tipo=ACK` só sinaliza o `TEvent` correspondente (se ainda existir — um ACK atrasado de um messageId já desistido é ignorado); quadro `tipo=DADO` aceito OU duplicado manda um ACK de volta (duplicado também, porque o emissor pode estar reenviando exatamente por não ter visto o ACK original); CRC inválido não manda ACK (não dá pra confiar no messageId ali).
- Cuidado de concorrência: enviar o ACK dentro de `pExtraiFramesDisponiveis` (thread de leitura) está envolvido em try/except — uma falha ao mandar o ACK não pode derrubar a thread de leitura, só fica sem confirmar (o emissor vai reenviar sozinho).
- Cuidado de shutdown: `Destroy` sinaliza todo `TEvent` pendente antes de liberar (senão um `pEnviaFrame` em espera ficaria preso até o timeout de cada tentativa restante) — mas confere `FblnConectado` de novo depois de acordar, pra não confundir "acordado por desconexão" com "ACK de verdade".
- Cuidado extra do lado estação (não existe no autcom, que não tem esse conceito de reconexão dentro do mesmo objeto): `pLoopServidor` aceita conexões em loop no MESMO objeto `TTefEstacaoTcpTransporte` — ao aceitar uma conexão NOVA, precisa sinalizar/descartar qualquer ACK pendente da conexão ANTERIOR **antes** de marcar `FblnConectado := True` de novo (ordem importa: senão um `pEnviaFrame` preso da conexão morta acordaria vendo `FblnConectado=True` da conexão nova e acharia, errado, que seu quadro antigo foi confirmado).

**Ainda não implementado**: retomada de quadros não confirmados após reconexão (Fase 3) — se o canal cair no meio de um retry, o quadro é considerado perdido, não fica em fila pra reenviar quando o canal reconectar.

**Ainda não recompilado/testado em campo.** Próximo passo: recompilar `libTefCitel.dproj`, redistribuir os dois lados, repetir débito e crédito. Confirmar: (1) zero regressão; (2) a demora do hook `DepoisPassarCartao` no débito cai de ~30s pra ~10s no pior caso (5 tentativas x 2s) — ou, no caso melhor (a maioria), o retry consegue entregar o dado que antes travava, e a demora desaparece quase por completo; (3) logs mostram os novos eventos (`TCP:`/`pEnviaFrame:` "sem ACK do messageId=X ... reenviando").


### Regressão real encontrada e corrigida (2026-08-31) — exaurir tentativas de ACK não pode ser fatal

**Rafael reportou**: "passou a dar um erro aleatório" — anexou `ERRO.txt` (crash real do madExcept) e os 3 logs do mesmo teste.

**Crash confirmado**: `ETefCitelDvcTransporte: Canal TEF DVC nao confirmou a entrega do messageId=2 apos 5 tentativas.` — na thread principal, callstack `pEnviaFrame` ← `pEnviaEnvelope` ← `fChamaRpc` ← **`fConfiguraTefCitel`** ← `pIniciaTefCitel` ← `TfrmPrincipal.fIniciarTefCitel` (a PRIMEIRA chamada TEF da sessão, no startup). Nenhum ponto da cadeia de chamada captura essa exceção — ela sobe até o loop principal da VCL.

**Confirmado nos logs do mesmo teste que isso NÃO é exclusivo de payload grande**: o log do autcom mostra o fluxo inicial (`fConfiguraTefCitel`, `fObtemVersao`, `fPassarCartao`, hook `AntesPassarCartao`) funcionando perfeitamente — ACKs chegando quase instantaneamente. Só depois, no `hook_resposta` do `AntesPassarCartao` (messageId=7 do autcom), a estação confirma ter recebido o quadro (`TCP: quadro aceito (messageId=7...)`) e reenviar ACK a cada duplicata (`TCP: quadro duplicado descartado (messageId=7...) - reenviando ACK mesmo assim`) **quatro vezes**, mas o autcom nunca vê nenhum desses ACKs chegar — esgota as 5 tentativas e lançaria a mesma exceção fatal. Ao MESMO TEMPO, do lado estação, o PRÓPRIO envio dela (`messageId=10`, depois `messageId=13`) também não recebe ACK do autcom. Ou seja: **os dois lados ficam presos simultaneamente esperando ACK um do outro**, bem na mesma janela crítica de sempre (troca de hook) — a mesma instabilidade de canal já mapeada, agora batendo em quadros pequenos também, não só no hook grande.

**Causa raiz do bug (nosso, não do canal)**: a Fase 2, como implementada, tratava "esgotou as tentativas de ACK" como uma condição FATAL (`raise`). Isso é **pior** que o comportamento de antes da Fase 2 — antes, uma escrita "bem sucedida" (sem erro do `WTSVirtualChannelWrite`) nunca tinha garantia de entrega mesmo assim, e ninguém tratava isso como erro fatal; agora, ao ADICIONAR uma forma de detectar a falta de confirmação, também introduzimos uma forma NOVA de crash que não existia antes — pior ainda, capaz de disparar em qualquer quadro (até no handshake inicial), tornando o sintoma "aleatório" do ponto de vista do Rafael.

**Corrigido**: `pEnviaFrame` (nos dois lados) não lança mais exceção ao esgotar `TEF_*_ACK_MAX_TENTATIVAS` tentativas sem confirmação — loga um aviso bem visível e **segue normalmente**, tratando como o mesmo "melhor esforço" que já existia antes da Fase 2. O retry continua valendo a pena (a maioria dos casos confirma na 1ª ou 2ª tentativa, e às vezes o reenvio consegue entregar onde a 1ª tentativa não conseguiu) — só não pode mais ser fatal quando TODAS as tentativas falham. Se o dado realmente não chegou, o timeout de negócio correspondente (hook de 30s, etc.) continua sendo o backstop final, exatamente como sempre foi. As únicas exceções que continuam sendo lançadas são as de desconexão REAL do canal/socket (`not FblnConectado`), que já existiam antes e já são tratadas em todo ponto de chamada.

**Ainda não recompilado/testado em campo.** Próximo passo: recompilar, redistribuir, repetir o teste — confirmar que não crasha mais mesmo quando aparecem várias linhas "sem ACK ... reenviando" seguidas, e que o log mostra a nova linha "NAO confirmou a entrega ... seguindo sem confirmacao" em vez de derrubar a sessão.


### Regressão do item anterior confirmada corrigida; achado novo e mais importante (2026-08-31) — deadlock real em pTrataHook

**Teste seguinte**: a exceção fatal não apareceu mais (fix do item anterior funcionou) — mas Rafael reportou "o erro persiste" e anexou `erro2.txt` (crash NOVO, diferente) + os 3 logs.

**`erro2.txt` é um bug DIFERENTE, ainda em aberto**: `EAccessViolation` lendo endereço `0x00000011`, dentro de `System.@UStrClr` (limpeza de uma `string` local), chamado a partir de `TTefCitelDvcTransporte.pAcumulaBytesRecebidos`, na thread de leitura, 45s depois do processo subir — ou seja, na primeira chamada da sessão. O registrador `edx` no crash mostra `0x19` (não nil, não um ponteiro válido de heap) sendo lido como se fosse o header de refcount de uma `UnicodeString` — sintoma clássico de variável de string não inicializada/corrompida, não uma exceção de negócio nossa. **Não investigado a fundo ainda** — não confundir com o achado abaixo, que é uma causa separada e mais explicativa do sintoma relatado ("o erro persiste").

**Achado principal, root-caused via leitura de código (não só log)**: Rafael observou, corretamente em espírito, que o ACK deveria confirmar só a CHEGADA do quadro, não o fim do PROCESSAMENTO do comando. Conferido em `pExtraiFramesDisponiveis` (`untTefCitelDvcTransporte.pas:678-697`): o ACK já É mandado (`pEnviaAck`) ANTES de repassar ao `FOnFrameRecebido` — isso já estava correto por design. O bug real é outro, mais sutil: **`TTefCitelDvc.pTrataHook` (`untTefCitelDvc.pas`) ainda usa `TThread.Synchronize`** para processar o hook e mandar `hook_resposta` de volta — o MESMO padrão de deadlock que o próprio projeto já tinha encontrado e corrigido em `pTrataEvento`, 2026-08-28 (comentário em `untTefCitelDvc.pas:1013-1029`), mas o fix nunca foi replicado em `pTrataHook`.

**Mecanismo do deadlock**: `TThread.Synchronize` bloqueia a thread de LEITURA do canal até a thread principal terminar de processar o hook e mandar `hook_resposta`. Mas o ACK dessa resposta só pode ser recebido pela MESMA thread de leitura — que está presa dentro do `Synchronize`. Resultado: **todo** `hook_resposta` esgota as 5 tentativas de ACK (10s perdidos), sempre — não é "aleatório", é garantido por uma espera circular. Bate exatamente com os logs anexados (`TCP: sem ACK do messageId=1/2/8 apos 2000 ms (tentativa 1..5/5)` se repetindo de forma determinística logo após cada resposta).

**Corrigido**: `pTrataHook` trocado de `TThread.Synchronize` para `TThread.Queue` (mesmo padrão já validado em campo em `pTrataEvento`). Cuidado adicional que `pTrataEvento` não precisou: `pOnFrameRecebido` libera o `TJSONObject` (`LJson.Free`) logo depois que `pTrataHook` retorna (`untTefCitelDvc.pas:973-975`) — com `Queue` isso acontece ANTES do bloco adiado rodar, então os dados de `LObjDados` (retorno do hook, campos de `GravaLogErr`) agora são extraídos do JSON ANTES do `TThread.Queue`, e só os valores já extraídos (não a referência ao JSON) são usados dentro do bloco adiado — evita um use-after-free que a troca ingênua introduziria.

**Ainda não recompilado/testado em campo.** Próximo passo: recompilar `libTefCitel.dproj`, redistribuir os dois lados, repetir débito e crédito. Observar: (1) `hook_resposta` deixa de esgotar as 5 tentativas de ACK na maioria dos casos (deve confirmar rápido agora que a thread de leitura fica livre); (2) a demora do hook no débito cai de fato; (3) nenhuma regressão nos hooks que chamam callback síncrono (`AntesPassarCartao`/`AntesCancelarTransacao`/`AntesReimpressao` — o valor de retorno `ok` ainda precisa chegar à estação a tempo de decidir prosseguir ou não com a operação; `TThread.Queue` não muda ISSO, porque quem espera a resposta é a estação via `fEnviaHookEAguarda`, não a thread de leitura do autcom). O crash de `erro2.txt` (`pAcumulaBytesRecebidos`/`@UStrClr`) continua **sem causa raiz confirmada** — precisa de investigação própria se reaparecer depois deste fix (pode ou não estar relacionado à mesma janela de instabilidade do canal).


### Causa raiz do crash `@UStrClr`/`pAcumulaBytesRecebidos` encontrada (2026-08-31) — teste de crédito após o fix do deadlock

**Rafael reportou**: "tivemos uma regressão no crédito, no final do passacartao deu o erro em anexo" — anexou um NOVO `ERRO.TXT` (mesma assinatura do `erro2.txt` anterior: `EAccessViolation` em `System.@UStrClr`, chamado do epílogo de `TTefCitelDvcTransporte.pAcumulaBytesRecebidos`, thread de leitura, ~2min de sessão) + os 3 logs do mesmo teste (após o fix de `pTrataHook`/`TThread.Queue` do item anterior).

**Desta vez os logs mostram a causa física, direto**: cruzando `TefCitelDvcTransporte.log` com o crash, o hook `DepoisPassarCartao` (payload grande, 2228 bytes) chega em 2 chunks WTS de 1604 bytes cada (multi-chunk, `flags=2`). O PRIMEIRO chunk acumula corretamente `1596/2228` (incompleto, como esperado). O SEGUNDO chunk, em vez de completar a mensagem (1596+632=2228), soma outros **1596** bytes — `acumulado=3192/2228` — ou seja, **o canal DVC entregou o MESMO chunk físico de 1604 bytes duas vezes seguidas**, byte a byte (achado novo: replicação/duplicação no nível do `WTSVirtualChannelRead`, ABAIXO do nosso protocolo de quadro lógico — o dedup por `messageId` da Fase 1 não alcança esse nível, porque ali a mensagem ainda nem foi remontada). `fProcessaChunkWts` não tinha nenhuma proteção contra esse overshoot: aceitou os 3192 bytes como "completos" (>= 2228) e repassou o buffer inteiro, agora desalinhado, pra frente. `pExtraiFramesDisponiveis` leu um `LintTamanhoFrame` de dentro do meio de um payload de cupom (`0x20202020`, mesma assinatura já vista em 2026-08-28) e levantou `ETefCitelDvcTransporte`. **Essa exceção nunca era capturada em `pLoopLeitura`** (só a versão do lado estação tinha esse try/except, portada de `untTefEstacaoTcpTransporte.pas` — assimetria não notada até agora) — matava a thread de leitura, e o crash de `@UStrClr` é o resultado dessa exceção não tratada subindo através do epílogo de `pAcumulaBytesRecebidos`.

**Ligação com os crashes anteriores (`erro2.txt` da sessão passada, e o `ERRO.txt` da regressão fatal do ACK, já corrigido)**: todos os 3 crashes têm a MESMA assinatura exata (`@UStrClr`, chamado de `pAcumulaBytesRecebidos`, thread de leitura, cedo na sessão) — reforça a suspeita de que a causa não é só a falta de try/except (que explica o crash ATUAL), mas também o próprio log de diagnóstico adicionado em `pAcumulaBytesRecebidos` nesta sessão: era a ÚNICA chamada de log deste arquivo sem gate de "só loga se grande", disparando em TODA leitura (inclusive chunks pequenos e frequentes) — o comentário já existente no arquivo sobre "Bug 6" (2026-08-28, corrupção de heap sob chamada concorrente intensa de log) já alertava especificamente contra esse padrão.

**Corrigido, 3 mudanças em `libTefCitel\untTefCitelDvcTransporte.pas`** (autcom-side; não replicado no lado estação — `fProcessaChunkWts`/`CHANNEL_PDU_HEADER` só existe no canal DVC, a estação usa TCP puro sem esse nível de remontagem):
1. `fProcessaChunkWts` — detecta overshoot (`Length(FarrPayloadWtsParcial) > FdwTotalWtsEsperado`) logo após acumular cada chunk; se acontecer, descarta o acumulado inteiro e reinicia (não dá pra separar com segurança duplicata de dado novo dentro do overshoot) em vez de repassar um buffer desalinhado pra frente.
2. `pLoopLeitura` — `pAcumulaBytesRecebidos` agora roda dentro de `try/except`, espelhando o padrão que já existia do lado estação (`pLoopServidor`): uma exceção de framing loga e é tratada como desconexão do canal (`pNotificaDesconexao` + `Break`), nunca mais mata a thread em silêncio.
3. `pAcumulaBytesRecebidos` — removido o log de diagnóstico incondicional adicionado mais cedo nesta sessão (já tinha provado o que precisava — o hook duplicado, já neutralizado pela Fase 1); era a única chamada de log deste arquivo sem o gate "só se grande" que todas as outras já usam por causa do Bug 6.

**Ainda não recompilado/testado em campo.** Próximo passo: recompilar, redistribuir (só o lado autcom/`libTefCitel.dll` muda aqui — mas como os dois lados compartilham o mesmo `.dproj`/pasta, redistribuir os dois de qualquer forma), repetir crédito e débito. Observar: (1) o overshoot pode continuar acontecendo (é um comportamento do canal DVC, não eliminado, só agora tratado com segurança) — deve aparecer no log como "overshoot na remontagem WTS ... descartando e reiniciando" em vez de crashar; (2) se aparecer, o hook grande que estava em andamento nesse momento provavelmente precisa ser reenviado do zero pela camada de negócio (ainda não avaliado o que acontece pro usuário nesse caso específico — a mensagem se perde e não há retry automático no nível de mensagem completa, só no nível de quadro/ACK já confirmado); (3) nenhum crash `@UStrClr` deve mais aparecer.


### Teste seguinte (2026-08-31) — crash sumiu, mas o hook grande continua falhando; Rafael pediu prova, não suposição

**Resultado**: recompilado só o lado autcom, testado de novo. **O crash sumiu** — em vez de `EAccessViolation`, apareceu uma `Exception` comum e tratada (`"Canal TEF DVC desconectado enquanto aguardava resposta de fPassarCartao"`, capturada normalmente por `TfrmPai.pOnBitBtnErro`, sessão do autcom não caiu). Confirma que o `try/except` novo em `pLoopLeitura` funcionou como projetado: a exceção de framing vira desconexão limpa, não crash.

**Mas a transação de crédito falhou** — o hook `DepoisPassarCartao` (2228 bytes) nunca conseguiu ser entregue com sucesso, e Rafael apontou (com razão) que eu estava caminhando pra aceitar "é o canal/infra" sem ter provado isso de verdade — só tinha provado que os TAMANHOS de dois chunks bateram, nunca que o CONTEÚDO (bytes) era idêntico.

**Achado que corrige minha leitura anterior**: cruzando `TefCitelDvcPlugin.log` (lado servidor) com precisão, as "múltiplas entregas de 2228 bytes" ao longo de ~10s **não são duplicação do canal** — são o **nosso próprio mecanismo de retry da Fase 2 funcionando exatamente como projetado**: a estação reenvia a mensagem inteira a cada ~2s (57.250, 59.257, 01.264, 03.278, 05.291 — batendo com `TEF_ESTACAO_ACK_TIMEOUT_MS`) porque nunca recebe o ACK de volta do autcom. Isso **não é bug** — é o comportamento pretendido quando o receptor não confirma. A pergunta real, ainda sem resposta: **por que o autcom nunca consegue processar com sucesso NENHUMA das 5 tentativas**, cada uma delas uma entrega completa e correta (2228 bytes) do ponto de vista da estação/plugin?

**Instrumentação adicionada (2026-08-31) para fechar a dúvida de verdade, antes de suspeitar do canal de novo** — `libTefCitel\untTefCitelDvcTransporte.pas`:
- `fProcessaChunkWts`: hex dump dos primeiros 16 bytes do DADO de cada chunk grande (mesmo gate de tamanho de sempre, sem aumentar frequência) — permite comparar byte a byte se duas leituras de mesmo tamanho realmente carregam o mesmo conteúdo ou não.
- `fProcessaChunkWts`: log explícito de `Length(Result)` no retorno (MENSAGEM COMPLETA vs incompleto) — fecha a ambiguidade que a leitura anterior dos logs não resolveu (uma sequência de campo mostrou um chunk logado como incompleto seguido IMEDIATAMENTE por um log que só pode vir de dentro de `pExtraiFramesDisponiveis` — contraditório com a leitura de que `Result` teria ficado vazio; ainda não explicado).
- `pAcumulaBytesRecebidos`: reintroduzido um log de entrada, mas agora COM gate de tamanho (só quando o payload é grande) — a versão anterior (removida por suspeita de Bug 6) era incondicional; esta prova sem ambiguidade toda vez que a função roda com payload grande, sem repetir o risco de frequência.
- Corrigido de passagem: o comentário anterior afirmava "byte a byte idêntico" para o achado de duplicação de chunk — isso nunca foi verificado, só o tamanho. Comentário corrigido pra não afirmar o que não foi provado.

**Ainda não recompilado/testado em campo.** Próximo passo: recompilar, redistribuir, repetir crédito (só precisa reproduzir o hook grande) e trazer os 3 logs de novo. O log novo deve mostrar, sem ambiguidade: (1) se os hex dumps de duas leituras "do mesmo tamanho" batem byte a byte (confirma duplicação física real) ou diferem (aponta bug nosso de indexação/estado, não do canal); (2) se `Length(Result)` realmente bate com os números de "acumulado/esperado" já logados, ou se há uma contradição real aí (o que apontaria pra reentrância ou estado inesperado, não investigado ainda). **Não aceitar "é o canal" como conclusão até esses dois pontos serem respondidos pelo log.**


### Teste seguinte (2026-08-31) — nova contradição no log, e mudança de direção: eliminar o hook grande em vez de caçar o bug de framing

**A instrumentação revelou uma contradição própria, ainda mais clara**: no chunk que inicia a mensagem do hook, o log mostrou `acumulado=1596/2228` (incompleto, por definição — 1596 < 2228) imediatamente seguido de `retornando com Length(Result)=272 (MENSAGEM COMPLETA)`. Pelo código escrito, isso é logicamente impossível (`Result` só é atribuído quando `Length(FarrPayloadWtsParcial) >= FdwTotalWtsEsperado`, o que não é o caso aqui) — e "272" bate exatamente com o `totalLength` da mensagem ANTERIOR (mensagem 36), sugerindo leitura de estado obsoleto/corrompido, não um bug de lógica simples de se apontar. Isso é evidência de um problema mais profundo (possivelmente ligado ao "Bug 6" de corrupção de heap, nunca de fato resolvido) que NÃO foi investigado a fundo, porque o rumo da conversa mudou.

**Rafael propôs uma saída melhor**: "os hooks estão no lugar errado, eles deveriam ficar no autcom... a camada do autcom deveria emular o funcionamento deles" — em vez de continuar caçando o bug de framing do payload de 2,2KB, eliminar esse payload do canal por completo.

**Verificação que confirmou a proposta, com evidência de código (não só intuição)**: todos os callbacks "Depois*" do lado autcom (`untTefCitelUtil.pas`) ou ignoram o retorno recebido, ou é um no-op:
```pascal
pDepoisPassarCartaoEvent(AobjRetorno) — só age "if not Assigned(AobjRetorno)", nunca verdadeiro no sucesso
pDepoisCancelarTransacaoEvent(AobjRetorno) — fLockUnlockTefCitel(False), ignora AobjRetorno
pDepoisReimpressaoEvent(AobjRetorno) — fLockUnlockTefCitel(False), ignora AobjRetorno
pDepoisFinalizarTransacaoEvent — nem recebe parametro
pSucessoTefCartaoEvent(var ADadosTransacao) — corpo vazio ("/////")
```
E o dado que `DepoisPassarCartao` carregava (a causa do payload de 2,2KB) é **o mesmo** `IRetornoTEFCitel` que `TTefCitelDvc.fPassarCartao` já recebe pela própria resposta RPC (`fChamaRpc('fPassarCartao', ...)` → `Result := fIRetornoTEFCitelDeJson(fJsonObj(LResult, 'retorno'))`) — um canal pequeno e confiável que nunca falhou em nenhum teste desta sessão. Confirmado também em `untTefCitelNCR.pas`/`untTefCitel.pas` (as duas implementações reais) que todo hook já é chamado com guarda `Assigned()` (`pDepoisEvento`, e checagens inline nas outras) — deixar de atribuir o hook do lado estação é seguro, não precisa de nenhum tratamento novo lá.

**Implementado**:
- `libTefCitel\untTefCitelDvc.pas`: `fPassarCartao`, `fFinalizarTransacao`, `fCancelaTransacaoTerminal`, `fReimpressao` agora chamam `FDepoisPassarCartao`/`FDepoisFinalizarTransacao`/`FDepoisCancelarTransacao`/`FDepoisReimpressao` localmente (se atribuídos), logo após o RPC retornar — usando o retorno que a própria resposta RPC já trouxe, sem rede nenhuma. `pTrataHook` não trata mais os hooks `DepoisPassarCartao`/`DepoisFinalizarTransacao`/`DepoisCancelarTransacao`/`DepoisReimpressao`/`SucessoTefCartao` (removidos, nunca mais chegam) — só restam `AntesPassarCartao`/`AntesCancelarTransacao`/`AntesReimpressao` (decidem algo real — trava de sessão multi-Autcom, `fLockUnlockTefCitel(True)`, que só o autcom sabe responder) e `GravaLogErr` (dado real).
- `libTefCitel\Estacao\untTefEstacaoRoteadorMensagens.pas`: removidas as 5 linhas que ligavam `FRealInstance.DepoisPassarCartao`/`DepoisFinalizarTransacao`/`DepoisCancelarTransacao`/`DepoisReimpressao`/`SucessoTefCartao` aos respectivos `pHookXxx`, e os 5 procedimentos `pHookDepoisPassarCartao`/`pHookDepoisFinalizarTransacao`/`pHookDepoisCancelarTransacao`/`pHookDepoisReimpressao`/`pHookSucessoTefCartao` (ficaram sem nenhuma chamada, removidos por completo, declaração e corpo). Mantidos `fHookAntesPassarCartao`/`fHookAntesCancelarTransacao`/`fHookAntesReimpressao`/`pHookGravaLogErr`.

**Efeito esperado**: o payload de 2,2KB (o único multi-chunk deste protocolo, e a causa de toda a investigação de corrupção/duplicação de chunk WTS desta sessão) nunca mais é montado nem trafega pelo canal. Isso não é só "tratar o sintoma com segurança" (como o overshoot/try-except da rodada anterior) — a mensagem problemática deixa de existir.

**Ainda não recompilado/testado em campo.** Próximo passo: recompilar os dois lados, repetir crédito e débito. Observar: (1) nenhuma mensagem de ~2,2KB deve mais aparecer nos logs de transporte; (2) a demora do hook grande no débito (que motivou a Fase 2) deixa de existir, já que o hook nem é mais enviado; (3) o retorno da transação (recibo/NSU/etc.) continua chegando certo na UI do autcom, via a emulação local — validar visualmente que o comportamento pós-venda (o que `pDepoisPassarCartaoEvent`/etc. costumavam disparar) continua correto. A contradição do instrumentation (`Length(Result)=272` indevido) fica sem explicação própria por ora — só deixa de ser alcançável, já que o payload que a expunha não é mais enviado; se aparecer de novo em outro contexto (payload grande futuro, ex.: atualização de DLL via RF10), retomar a investigação a partir daqui.


### CAUSA RAIZ ENCONTRADA (2026-08-31) — não era o canal, nem os hooks; era `Result` não limpo em `fProcessaChunkWts`

**Rafael reportou**: mesmo depois de remover os hooks "Depois*", o problema persistiu — e um payload de ~2,2KB continuou aparecendo (agora é a própria resposta RPC de `fPassarCartao`, que sempre precisou carregar o mesmo `IRetornoTEFCitel` grande com o texto do recibo — remover o hook só parou de duplicar o envio, não eliminou a mensagem grande em si, como eu tinha previsto errado). Rafael perguntou: **"nossa rotina faz alguma fragmentação quando fica além de algum limite de bytes?"**

**Resposta, e causa raiz de toda a investigação desta sessão (incluindo o achado original do hook duplicado, dias atrás)**: analisando o log linha a linha, `fProcessaChunkWts: retornando com Length(Result)=272` aparecia **em TODO chunk incompleto/overshoot**, sempre com o MESMO valor (272) — que bate exatamente com o tamanho da mensagem ANTERIOR já aceita (messageId=32). A função tem múltiplos caminhos que devem devolver "mensagem incompleta" (`Result` vazio) — o `Exit` do overshoot, e o "cai no fim da função sem completar" do caso normal — **nenhum dos dois zera `Result` explicitamente**, contando com a inicialização implícita de `Result` em Delphi. Essa inicialização não estava se comportando de forma confiável aqui: `Result` (que corresponde a `LarrPayload` do lado do chamador, `pLoopLeitura`) ficava com o CONTEÚDO DA ÚLTIMA MENSAGEM QUE REALMENTE COMPLETOU, e `pLoopLeitura` reenviava esse conteúdo velho pra `pAcumulaBytesRecebidos` toda vez que um chunk chegava incompleto — que, corretamente, reconhecia como "duplicado" (porque, byte a byte, ERA a mensagem anterior) e descartava.

**Isso explica tudo, desde o início**: o achado original ("hook `DepoisPassarCartao` processado 2x no crédito") nunca foi o canal replicando nada, nem um problema de reentrância — era exatamente este bug: toda vez que uma mensagem grande vinha em múltiplos chunks WTS, cada chunk intermediário incompleto reenviava a mensagem ANTERIOR como se fosse nova. O dedup por `messageId` da Fase 1 mascarou o sintoma (descartando como duplicado em vez de processar 2x), e o overshoot/try-except da rodada anterior tratou o CRASH resultante com segurança — mas a causa raiz, a própria função nunca devolvendo "vazio" de verdade quando devia, nunca tinha sido encontrada até agora.

**Corrigido**: `libTefCitel\untTefCitelDvcTransporte.pas`, `fProcessaChunkWts` — adicionado `Result := nil;` explícito logo na entrada da função, garantindo que qualquer caminho que não atribua `Result` de propósito devolva vazio de verdade, independente de qualquer comportamento implícito do compilador.

**Ainda não recompilado/testado em campo.** Próximo passo: recompilar (só lado autcom — a estação não tem essa função, usa TCP puro sem chunking), redistribuir, repetir crédito e débito. Observar: (1) as linhas "quadro duplicado descartado" e "overshoot" devem parar de aparecer para a resposta grande do `fPassarCartao` — ela deve ser aceita normalmente, uma única vez; (2) `Length(Result)` só deve aparecer como não-zero quando a mensagem realmente completar; (3) nenhum crash, nenhuma desconexão inesperada. Se isso se confirmar, a Fase 1 (dedup)/Fase 2 (ACK+retry)/try-except do overshoot continuam válidas como camadas de segurança, mas deixam de ser necessárias para o caso comum — o dado deve fluir limpo já na primeira tentativa.


### Teste seguinte (2026-08-31) — `Result := nil` funcionou, mas achado NOVO e real: canal entrega repetidamente um pedaço de dado que não é o início da mensagem

**Resultado do fix anterior confirmado**: `fProcessaChunkWts: retornando com Length(Result)=0 (incompleto...)` agora aparece corretamente nos chunks intermediários — a contradição do `Result` obsoleto sumiu. Mas o crash/desconexão persistiu, com o mesmo `538976288` (`0x20202020` = 4 bytes `' '` ASCII lidos como inteiro).

**Achado novo, desta vez com prova byte a byte de verdade**: três leituras físicas seguidas (`seq=154`, `159`, `164`) mostraram o **mesmo hex exato** `20 20 20 20 20 20 20 20 20 20 20 20 20 20 5C 6E` — todas ocorrendo bem no ponto onde `FdwTotalWtsEsperado` tinha acabado de voltar a `0` (ou seja, no lugar onde deveria vir o **início** de uma mensagem nova). Esse conteúdo não é o início de um quadro nosso (não tem cara de tamanho+messageId+CRC+tipo) — é meio de payload (texto de comprovante, cheio de espaço/`\n` escapado). O header WTS (`totalLength`) bate certinho (2215) — só o DADO que vem junto, nessas três tentativas, não é o começo de verdade. Quando finalmente chega o chunk certo (`A3 08 00 00 21 00 00 00...7B 22 76` — tamanho+messageId+CRC+tipo+`{"v`, formato correto), ele é tratado como CONTINUAÇÃO do que sobrou de uma tentativa anterior (619 bytes de lixo), em vez de reinício — resultado: `FarrPayloadWtsParcial` acumula `[619 bytes de lixo] + [1596 bytes reais]` = 2215 bytes (bate o total por coincidência), e os primeiros 4 bytes desse buffer (que `pExtraiFramesDisponiveis` lê como o NOSSO próprio prefixo de tamanho) são `20 20 20 20` — daí o `538976288`.

**Corrigido**: `fProcessaChunkWts` agora valida, especificamente no ponto onde `FdwTotalWtsEsperado` ainda está em `0` (o que deveria ser o início de uma mensagem nova): os primeiros 4 bytes do DADO do chunk (nosso próprio prefixo de tamanho embutido) precisam somar `+4` e bater exatamente com o `totalLength` que o header WTS já informou. Se não bater, o chunk não é um início de verdade — é descartado sozinho (sem acumular, sem setar `FdwTotalWtsEsperado`), aguardando a próxima leitura trazer o início real.

**Ainda não recompilado/testado em campo.** Próximo passo: recompilar, redistribuir, repetir crédito/débito. Observar: (1) a nova linha de log "chunk recebido no lugar do INICIO... descartando como ruido do canal" deve aparecer nas tentativas de lixo, em vez de "overshoot"/"duplicado"; (2) a mensagem real deve, por fim, ser aceita corretamente assim que o chunk verdadeiro chegar, sem nunca misturar lixo com dado real; (3) nenhum crash/desconexão para essa mensagem. **Nota honesta**: mesmo com essa validação, a causa física de por que o canal entrega esse "ruído" repetido continua desconhecida — isso só evita que o ruído contamine a remontagem; não impede o canal de continuar entregando ruído indefinidamente (nesse caso a mensagem ainda se perderia, só que sem corromper nada).


### Teste seguinte (2026-08-31) — validação funcionou no crédito, mas o débito mostrou que o canal pode simplesmente NUNCA entregar o chunk real

**Crédito**: sucesso completo. A nova validação descartou 3 chunks de "ruído" (log "descartando como ruido do canal"), e quando o chunk real chegou, foi aceito corretamente — `pExtraiFramesDisponiveis: quadro aceito (messageId=31, tamanho=2202)`, sem crash, sem corrupção.

**Débito**: pior resultado possível — o canal entregou o MESMO ruído 5 vezes seguidas (mesma assinatura `538976288`/`esperado=2290`) e depois **nunca mais entregou nada** - só timeout de 15s se repetindo indefinidamente. A transação ficou travada (sem crash, mas sem progresso). Rafael concluiu, corretamente: já são 6 tentativas de defesa em cima da mesma camada (dedup, CRC, ACK, overshoot, `Result:=nil`, validação de início) sem eliminar a causa física - hora de mudar a arquitetura. Proposta: "partir da origem com no máximo 1.5K... remontar no destino".

**Implementado — fragmentação própria, nos dois lados** (substitui a dependência da remontagem multi-chunk do canal WTS para qualquer payload grande):
- `TEF_DVC_TAMANHO_MAX_FRAGMENTO` / `TEF_ESTACAO_TAMANHO_MAX_FRAGMENTO = 1400` bytes de payload por quadro - margem confortável abaixo do ~1604 observado como teto de 1 chunk físico WTS. Nenhuma mensagem acima disso é mais enviada como um write só - `pEnviaFrame` agora fragmenta na origem e `pEnviaUmFragmento` (novo, o antigo corpo de `pEnviaFrame`) envia cada pedaço como um quadro independente, com ACK+retry próprios (Fase 2 continua valendo, por fragmento).
- `TEF_DVC_FRAME_METADATA_SIZE`/`TEF_ESTACAO_FRAME_METADATA_SIZE` cresceram de 9 para 13 bytes - 2 campos novos (`numFragmento`, `totalFragmentos`, `Word` cada) no quadro, entre `tipo` e o payload.
- Envio sequencial, ACK-gated: um fragmento só é enviado depois do anterior confirmar (ou esgotar tentativas) - garante que o receptor sempre veja os fragmentos em ordem, sem precisar de lógica de reordenação.
- `pExtraiFramesDisponiveis` (nos dois lados): quando `totalFragmentos <= 1`, comportamento idêntico ao de sempre. Quando `> 1`, acumula os fragmentos (`FarrPayloadFragmentado`/`FwProximoFragmentoEsperado`) e só despacha ao roteador quando o ÚLTIMO fragmento chegar - a mensagem completa nunca mais precisa de mais de 1 chunk físico do canal pra ser recebida, porque cada fragmento individual cabe sempre em 1 chunk.
- Dedup por `messageId` (Fase 1) e ACK+retry (Fase 2) continuam funcionando sem nenhuma mudança - cada fragmento é só mais um quadro independente pro resto do protocolo.

**Efeito esperado**: como cada quadro fica sempre abaixo do teto de 1 chunk WTS, a remontagem multi-chunk problemática (`fProcessaChunkWts`'s `FarrPayloadWtsParcial`) deixa de ser exercitada para mensagens de aplicação - só continuaria entrando em jogo pra RF10 (atualização de DLL, ainda não implementada) se um dia usar payloads maiores que `TEF_DVC_TAMANHO_MAX_FRAME`. Isso deve eliminar a classe inteira de bug perseguida nesta sessão (duplicação, overshoot, ruído no início), não só mais uma camada de defesa em cima dela.

**Ainda não recompilado/testado em campo.** Próximo passo: recompilar os dois lados (mudança de protocolo, PRECISA dos dois atualizados juntos - um lado velho não entende o quadro de 13 bytes de metadado do outro), redistribuir, repetir crédito e débito. Observar: (1) o log deve mostrar "payload de X bytes excede 1400 - fragmentando em N pedacos" e depois "fragmento K/N aceito" pro lado que recebe, terminando em "mensagem fragmentada completa"; (2) nenhuma linha de "overshoot"/"ruido do canal"/"duplicado" deve mais aparecer pra essas mensagens (cada fragmento é pequeno, deve chegar limpo num unico chunk); (3) o débito, que antes travava, deve completar normalmente. Se o canal AINDA assim corromper um fragmento individual (mais improvável, já que cada um é bem menor), o CRC por quadro já pega isso e o retry da Fase 2 reenvia o mesmo fragmento - a diferença é que agora seria só ESSE pedaço pequeno reenviado, não a mensagem inteira.


### CONFIRMADO EM CAMPO (2026-08-31) — crédito e débito funcionando, investigação de framing encerrada

**Rafael reportou**: "ficou perfeito, funcionou no crédito e débito" — log de uma sessão com os dois fluxos completos, ponta a ponta.

**Conferido linha a linha, não só de ouvido**:
- Crédito: a resposta grande de `fPassarCartao` (2281 bytes) chegou fragmentada em exatamente 2 pedaços — `fragmento 1/2 aceito` (1400 bytes) → `fragmento 2/2 aceito` (881 bytes) → `mensagem fragmentada completa (2 fragmentos, 2281 bytes no total)`. Zero "overshoot", zero "ruído do canal", zero "duplicado", zero "sem ACK"/retry.
- Débito: a mesma coisa, resposta de 2203 bytes em 2 fragmentos (1400 + 803), remontada limpa, sem nenhuma linha de erro.
- Hooks: só `AntesPassarCartao` aparece no log (2 vezes, uma por transação) — nenhum `DepoisPassarCartao`/`DepoisFinalizarTransacao`/`DepoisCancelarTransacao`/`DepoisReimpressao`/`SucessoTefCartao` cruzou o canal, confirmando que a emulação local (item anterior) está funcionando e esses hooks realmente pararam de ser transmitidos.
- Fluxo completo, sem travar: `fConfiguraTefCitel` → `fObtemVersao` → `fPassarCartao` (crédito) → hook `AntesPassarCartao` → vários `pInfo21`/eventos → resposta grande fragmentada → `pRetornaLog` x2 → `fFinalizarTransacao` → (segunda transação) `fPassarCartao` (débito) → mesma sequência → resposta grande fragmentada → `fFinalizarTransacao`. Nenhum timeout de negócio disparado, nenhuma desconexão.

**Conclusão**: a investigação desta sessão (iniciada com o achado de hook duplicado no crédito, dias atrás) está encerrada. A causa raiz real era dupla - (1) `Result` não zerado em `fProcessaChunkWts` causando reprocessamento de mensagem antiga, já corrigido; (2) dependência da remontagem multi-chunk do canal WTS, que se mostrou não confiável acima de ~1,6KB neste ambiente - eliminada com fragmentação própria (protocolo v3) em vez de mais uma camada de defesa em cima da causa física.

**Pendente, não bloqueante**: rodar o restante do checklist de aceitação da Fase 3 (specs.md seção 6) - Pix via PinPad, queda de canal DVC durante transação, atualização de DLL (RF10) - que não foram o foco desta investigação de framing mas continuam no checklist original.


### Achado novo (2026-08-31) — trava na tela do autcom em transação com mais de um cartão

**Rafael reportou**: "quando faz uma transação com mais de um cartão, quando passa o último cartão fica travado na tela do autcom." Achado durante o mesmo teste de campo que confirmou o fix de framing acima (item anterior) — não é a mesma causa raiz (framing já confirmado funcionando, ver conclusão acima), é um problema separado, na sessão de **cartão múltiplo** (split de pagamento entre 2+ cartões numa única venda).

**Pistas originais para começar a investigar** (mantidas por histórico — ver conclusão abaixo, que já refuta a primeira):
- O código já tem um conceito de "sessão multi-cartão" (`pFechaSessaoMultCartao`, visto em `libTefCitel\untTefCitelNCR.pas`) — mas isso é o estado NATIVO do Scope/pinpad (`FblnMultCartoes` reflete o bit `INI_SESSAO` devolvido pelo próprio SDK), não algo controlado pelo nosso código de rede.
- Suspeitar de algo que só dispara na finalização da sessão multi-cartão — ex. um hook/RPC que só é chamado nesse momento.
- Reproduzir com os 3 logs de sempre e localizar o ÚLTIMO evento antes da trava.
- Verificar se acontece também em `CFG_TEFDVC = N` (clássico).

**Reprodução real feita (2026-08-31), com os 4 logs (`TefCitelDvcTransporte.log`, `TefCitelDvcPlugin.log`, `TefEstacaoService.log`, `ScopeTrc.txt`) + print da tela travada**: venda com crédito (R$3,00, id=8) seguido de débito (R$4,00, id=12, o último cartão). Cruzando os 4 logs:

- **O transporte DVC está inocentado, com prova byte a byte.** O `fPassarCartao` do débito (id=12) completa normal: hook `AntesPassarCartao` respondido (11625 ms — atribuível ao operador escolhendo "Débito" no menu entre um cartão e outro, não é bug), vários `pInfo21`/Modalidade Dinâmica trocando certo (inclusive um retry de ACK por `messageId` e um quadro duplicado descartado corretamente — Fases 1/2 funcionando como projetado), resposta final de 2282 bytes chega **fragmentada em 2 pedaços e remontada limpa** no autcom às 17:15:40.507 (`TefCitelDvcTransporte.log`), no mesmo instante em que a estação loga `Metodo "fPassarCartao" (id=12) retornou com sucesso` (`TefEstacaoService.log`). **Depois desse instante: silêncio total nos três logs de rede** — nenhuma chamada nova, nenhum erro, só o poll de `WTSVirtualChannelRead` continuando pra sempre. `ScopeTrc.txt` também termina exatamente ali (extração dos campos do cartão do débito concluída).
- **Conclusão: a trava não é mais no canal/protocolo DVC** — é em código do autcom que roda DEPOIS que a resposta de `fPassarCartao` já chegou por completo, ANTES de qualquer nova atividade aparecer nos logs de transporte. **Este achado muda o Req. 456190 de suspeito para inocentado nesta investigação específica** — não é mais uma questão de "DVC x clássico", é um bug em código que roda igual nas duas arquiteturas.
- **Achado extra do Rafael, corrobora a hipótese**: "a segunda transação não gera TEFTRA". Rastreando o código do lado autcom (`untTefCitelDvc.pas` → `untTefCitelUtil.pas` → `untTefCitelOperacoes.pas`): `TTefCitelDvc.fPassarCartao` chama `FDepoisPassarCartao(Result)` logo após o RPC retornar — isso cai em `TImplEventosTefCitel.pDepoisPassarCartaoEvent`, que é no-op quando `Result` não é nil (sucesso, confirmado no código) — não deveria travar aí. Depois disso o controle volta pra `TfrmTefCitelOperacoes.pPassaCartao` (`untTefCitelOperacoes.pas:850`), que deveria seguir pra gravar o TEFTRA via `pAtualizaTefTraComDadosAdicionais` → `pGravaTransacaoPendente` → `fRetAutoIncrem('TEFTRA', ...)`. Essa gravação é exatamente o que nunca aconteceu pro cartão 2 — bate com o sintoma relatado.
- **Hipótese líder, NÃO confirmada ainda**: algo em `fRetAutoIncrem('TEFTRA', ...)` (ou na gravação em si) trava especificamente na SEGUNDA chamada de uma venda com múltiplos cartões — candidato natural é contenção de lock no banco (MySQL) se a venda inteira estiver dentro de uma transação externa (`fStartTransactionGen`) ainda aberta e alguma parte do mecanismo de autoincremento (`fRetAutoIncremFireDac`, que usa conexão separada via FireDAC, com timeout de query de 20s) esperar por um lock que só seria liberado no commit da venda — mas isso teria estourado um erro em ~20s, e a tela ficou travada sem diálogo de erro por bem mais tempo que isso, o que enfraquece essa hipótese específica (pode ser `fRetAutoIncremInterno`, a variante sem FireDAC, sendo usada em vez disso — comportamento de timeout ainda não verificado).
- **Pendente pra próxima reprodução — capturar ANTES de matar o processo**: (a) anexar debugger/Process Explorer no `autcom.exe` travado e pegar a call stack da thread principal — prova em uma linha exata onde o código está parado; (b) rodar `SHOW PROCESSLIST`/`SHOW ENGINE INNODB STATUS` no MySQL nesse momento — se for lock de banco, aparece uma conexão do autcom em espera. Desta vez o processo já tinha sido encerrado antes dessa pergunta ser feita — reproduzir de novo capturando um dos dois antes de fechar.
- **NÃO REPRODUZIU (2026-09-02, manhã)**: Rafael repetiu o teste - débito+crédito, crédito+débito, reiniciou o autcom, crédito+débito de novo - nenhuma combinação travou. Nenhuma linha de código foi alterada, então não era "corrigido" - via de fato, reforçado pelo que segue.
- **Instrumentação adicionada (2026-09-02)**: log `%TEMP%\TefCitelAutcomTeftra.log` (lado autcom) em volta de `fPassaCartao`/`pAtualizaTefTraComDadosAdicionais`/`fRetAutoIncrem('TEFTRA',...)` em `untTefCitelUtil.pas` - ver bloco de comentário "Instrumentacao temporaria (Req. 456190...)" no início da unit, junto de `pGravaTransacaoPendente`.
- **REPRODUZIU DE NOVO no mesmo dia (2026-09-02, tarde), com o log novo + achado crítico do Rafael: "a aplicação não trava, simplesmente não fecha a janela".** Isso muda a natureza do problema - não é deadlock de UI, é uma RPC (`fChamaRpc('fPassarCartao', ...)`) que nunca retorna, mas como ela roda na thread principal bombeando `Application.ProcessMessages` enquanto espera (fix do Bug 1, 2026-08-28), a tela continua respondendo a cliques - só a call stack real (dentro de `pPassaCartao`/`fPassaCartao`) nunca desenrola, então o código que fecharia a janela nunca executa.
  - Cruzando os 4 logs (`TefCitelAutcomTeftra.log` novo + os 3 de sempre + `ScopeTrc.txt`): o segundo `fPassarCartao` (débito, id=9) teve sua resposta entregue **completa e intacta** pelo transporte - `TefEstacaoService.log`: "Metodo fPassarCartao (id=9) retornou com sucesso" às 10:54:10.374; `TefCitelDvcTransporte.log`: "mensagem fragmentada completa (2 fragmentos, 2281 bytes no total)" às 10:54:10.426, e a thread de leitura volta pro loop normal de poll logo em seguida (sem crash, sem exceção). **Mas o log novo (`TefCitelAutcomTeftra.log`) nunca mostra "fPassaCartao: depois de LTefCitel.fPassarCartao" para numDoc=11** - ou seja, a chamada `fChamaRpc`/`TTefCitelDvc.fPassarCartao` nunca retornou, apesar do byte completo já estar em memória do lado autcom.
  - **Achado corroborante**: 7 chamadas RPC `pSair` em sequência (ids 13-19), cada uma bem-sucedida individualmente - bate com Rafael clicando "9 - Encerra" repetidamente porque a janela não fechava; `pEncerrar` (`untTefCitelOperacoes.pas:781`) chama `ObjTefCitel.pSair(True)` (RPC independente, sempre funciona) seguido de `Self.Close`, mas o `Self.Close` nunca "vinga" porque a call stack real está presa várias camadas acima, dentro do `fPassaCartao` do débito que nunca retornou.
  - **Causa raiz mais provável, ainda NÃO confirmada**: `TTefCitelDvc.pTrataResposta` (`untTefCitelDvc.pas`) faz `FdictChamadas.TryGetValue(LintId, LObj)` e, se não encontrar, só dá `Exit` silencioso - sem log, sem erro. Se por algum motivo a resposta chegar com um `id` que não bate com a entrada pendente (ou a entrada já não existe mais em `FdictChamadas` por qualquer razão), o `Evento.SetEvent` nunca é chamado e `fChamaRpc` fica esperando pra sempre (sem crash, sem timeout - exatamente o padrão "silêncio = alguém espera algo que nunca chega" já visto nesta investigação inteira). Instrumentado agora (não corrigido - causa raiz exata ainda não provada): `fChamaRpc` loga quando registra um id em `FdictChamadas`; `pTrataResposta` loga o `id` recebido, o tamanho do JSON, e explicitamente se o `TryGetValue` falhou (com o `Count` atual do dicionário) - tudo em `TefCitelDvcTransporte.log`, mesmo log de sempre. Ainda não recompilado/testado em campo.
  - **Padrão notável**: só falhou no card MAIOR (respostas de 2281+ bytes, fragmentadas), nunca em chamadas pequenas (`fConfiguraTefCitel`, `pInfo21`, `pSair`) - reforça a suspeita de que o bug está ligado especificamente ao caminho de mensagens grandes/fragmentadas, não ao roteamento de resposta em geral.
- **Reteste (2026-09-02, mais tarde) com a instrumentação de `pTrataResposta`/`fChamaRpc` ativa: fluxo completo funcionou 100%** - crédito+débito+`fFinalizarTransacao`×2, canal fechado limpo no final. O log prova que, quando dá certo, `pTrataResposta` sempre encontra o `id` em `FdictChamadas` (inclusive nas duas respostas grandes fragmentadas, 2353 e 2282 bytes) - nunca reproduziu a condição "NAO ENCONTRADO". **Não fecha a causa raiz** (só prova que o caminho feliz funciona), mas revela uma diferença concreta comparando os dois logs lado a lado:
  - **Na sessão que travou (10:52-10:54)**: durante o `pInfo21` do débito, o guard de clique duplo (`fChamaRpc`) rejeitou 4 chamadas "IGNORADO" em ~9s (10:53:58 a 10:54:07) e um quadro chegou fisicamente duplicado no wire ("quadro duplicado descartado, messageId=71, ultimo aceito=74") - ou seja, `pInfo21` estava dis­parando/reentrando MUITO mais rápido que o round-trip da rede, empilhando chamadas sobrepostas, bem na janela imediatamente anterior ao silêncio fatal do `fPassarCartao`.
  - **Na sessão que funcionou (11:19-11:22)**: nenhum "IGNORADO", nenhum quadro duplicado - cada `pInfo21` do débito disparou e voltou de forma limpa e sequencial (7 chamadas, ids 11-17, uma de cada vez, sem sobreposição).
  - **Nova hipótese, ainda não confirmada**: o gatilho pode estar ligado a essa sobreposição/reentrância pesada de `fChamaRpc` (várias chamadas na pilha ao mesmo tempo, todas bombeando `Application.ProcessMessages`/`CheckSynchronize` simultaneamente no mesmo thread) - não o tamanho da mensagem em si. Precisa reproduzir de novo, IDEALMENTE numa rede/cartão que force mais trocas de Modalidade Dinâmica (mais `pInfo21` seguidos rápido), com a instrumentação de `pTrataResposta` ainda ativa, pra confirmar se a resposta do `fPassarCartao` chega a ser recebida pelo transporte e simplesmente não casa o `id`, ou se nem chega a ser processada (dedup por `messageId` descartando por engano na janela de sobrecarga).
- **CAUSA RAIZ CONFIRMADA e CORRIGIDA (2026-09-02)**: Rafael reproduziu de novo com a instrumentação ativa, desta vez com **3 cartões**. O log provou que `pTrataResposta` encontrou e sinalizou corretamente a resposta do `fPassarCartao` do 3º cartão (id=27) — mas a tela continuou sem fechar (mais 4 `pSair` em sequência, mesmo padrão de antes). Investigando mais fundo: a chamada `pInfo21` id=34 (a última aninhada dentro do `fPassarCartao`, antes de sua resposta grande chegar) nunca teve resposta processada, e o log mostrou `"quadro duplicado descartado (messageId=202, ultimo aceito=205)"` — 202 sendo MENOR que 205, ou seja, chegou depois de ids maiores já aceitos.
  - **Causa raiz confirmada por código** (não só correlação de log): em `pEnviaUmFragmento` (`untTefEstacaoTcpTransporte.pas` e, espelhado, `untTefCitelDvcTransporte.pas`), a atribuição do `messageId` (`TInterlocked.Increment`) e a escrita física do quadro (`pEnviaFrameBruto`) eram dois passos separados, sem lock cobrindo os dois juntos. Como toda chamada roda em thread própria (Bug 2, 28/08), duas threads podiam pegar `messageId` em ordem mas escrever fora de ordem — o `messageId` mais antigo chegando DEPOIS de ids maiores já aceitos, sendo descartado pelo dedup por ordem estrita (`LdwMessageId <= FdwUltimoIdRecebido`) mesmo sendo a primeira entrega real. A `fChamaRpc` correspondente (aninhada dentro da `fChamaRpc` do `fPassarCartao`, mesma pilha reentrante) ficava esperando pra sempre, travando a UI por tabela mesmo com a resposta do `fPassarCartao` externo já tendo chegado.
  - **Verificado antes de corrigir**: o worker de escrita do plugin (`pLoopEscritaWorker`, `untTefCitelDvcPluginImpl.pas`) é FIFO estrito (confirmado no código) — não introduz desordem própria. A corrida no lado estação/autcom é a ÚNICA fonte de desordem em todo o caminho, então corrigi-la na origem é suficiente (não foi preciso trocar o dedup por um mecanismo tolerante a desordem, como um conjunto de ids já vistos, que Rafael sugeriu como alternativa e foi avaliada e descartada por não ser necessária).
  - **Corrigido, nos dois lados** (`untTefEstacaoTcpTransporte.pas` e `untTefCitelDvcTransporte.pas`): `FcsEscrita` (já existia, `TCriticalSection` reentrante por thread) agora também protege a atribuição do `messageId` junto com o primeiro envio do quadro, garantindo que a ordem de atribuição bata com a ordem real no socket/canal. Retentativas de ACK continuam fora do lock de propósito (mesmo `messageId`, sem ordem nova a preservar, e pra não serializar todas as chamadas concorrentes durante os até 2s de espera por tentativa). Detalhes completos em `IA\rules\tef-dvc.md`, seção "Corrida entre atribuição de messageId e escrita no socket/canal".
- **CONFIRMADO EM CAMPO (2026-09-02)**: Rafael recompilou e reproduziu de novo o mesmo roteiro (venda com 3 cartões, incluindo um cancelamento de negócio no meio - card recusado/timeout no pinpad, caminho normal, não bug). **Funcionou 100%** - 4 chamadas `fPassarCartao` (incluindo a cancelada), todas com resposta corretamente casada por `pTrataResposta`; vários `pInfo21` aninhados, todos batendo; **zero ocorrências de "quadro duplicado descartado" no log inteiro** (a assinatura exata do bug); `fFinalizarTransacao` disparado 3 vezes no fechamento, todas OK; sem nenhum `pSair` repetido no final (janela fechou na primeira tentativa, ao contrário das sessões anteriores que mostravam 4-7 `pSair` em sequência).
- **Status: RESOLVIDO.** Causa raiz confirmada por código (corrida entre atribuição de `messageId` e escrita no socket/canal) e correção validada em campo com reprodução do cenário exato que travava antes. Investigação encerrada - ver `IA\rules\tef-dvc.md`, seção "Corrida entre atribuição de messageId e escrita no socket/canal", para detalhes técnicos permanentes.
- **Confirmação final (2026-09-02)**: Rafael rodou "muitos testes" adicionais depois da correção - **nenhuma recorrência**. Encerrando esta sessão para tratar outro bug numa sessão nova (contexto limpo).
- **Pendência de limpeza, ainda aberta**: a instrumentação temporária desta investigação (log `TefCitelAutcomTeftra.log` em `untTefCitelUtil.pas`, e o par `fChamaRpc`/`pTrataResposta` em `untTefCitelDvc.pas` logando em `TefCitelDvcTransporte.log`) **ainda está no código** - Rafael pediu pra manter até o fim do dia 2026-09-02 como registro extra, não foi removida ainda nesta sessão. Se uma sessão futura (nova, sem este contexto) encontrar isso, **perguntar ao Rafael se já pode remover** antes de mexer - os comentários no código já dizem onde e porquê (procurar "Instrumentacao temporaria" nos dois arquivos). Não remover sem confirmar, já que ele pode ainda estar testando.


### Mensagem de uma transação aparecendo na transação seguinte (2026-09-03) — RESOLVIDO

Narrativa completa (hipóteses descartadas, jornada) em `record.md`. Detalhe técnico permanente em
`IA\rules\tef-dvc.md`, seção "Evento enfileirado que fica órfão na fila do TThread.Queue".

- [x] Instrumentar o caminho de evento/observer, até então sem log nenhum (`pTrataEvento`, `pNotifica`,
      `AdicionaObserver`/`RemoveObserver` no autcom; `pEnviaEvento` na estação).
- [x] Causa raiz provada com log: `fChamaRpc` saía do laço de espera sem drenar a fila do
      `TThread.Queue`, deixando o último evento da transação (status=500, o motivo da negação) órfão
      até o próximo `fChamaRpc` — já na transação seguinte, com outro observer registrado.
- [x] Corrigido em `libTefCitel\untTefCitelDvc.pas`: drenagem final no `fChamaRpc`; guard de método
      duplicado liberado antes dela; descarte por geração de observer como rede de segurança.
- [x] Corrigido de quebra, por consistência, o mesmo gap de "atribuir messageId + enviar sem lock" em
      `pEnviaAck` dos dois lados (não era a causa da trava — ver ressalva no código e na regra).
- [x] **Bateria de aceitação aprovada em campo (Rafael, 2026-09-03)**: débito + crédito; débito negado
      seguido de outro cartão que autoriza; cancelamento de transação; desfazimento de transação.

**Pendências de limpeza que atravessam para a próxima sessão:**

- [ ] Remover a instrumentação temporária, **perguntando ao Rafael antes** (mesma ressalva do item de
      2026-09-02): `TefCitelAutcomTeftra.log` em `untTefCitelUtil.pas`, o par `fChamaRpc`/`pTrataResposta`
      e agora também `pTrataEvento`/`pNotifica`/`AdicionaObserver`/`RemoveObserver` em `untTefCitelDvc.pas`,
      e `pEnviaEvento` em `untTefEstacaoRoteadorMensagens.pas`. Procurar "Instrumentacao temporaria" e
      "Log de diagnostico (Req. 456190".
- [ ] Normalizar para CRLF (convenção do `.editorconfig`) 3 arquivos novos que estão com LF puro:
      `TefCitelDvcPlugin.dpr`, `untTefCitelDvcPluginApi.pas`, `untTefCitelDvcPluginImpl.pas`. Os demais
      `.pas` da feature já foram normalizados em 2026-09-03.


### VALIDADO EM CAMPO — 2026-09-09, 12:11–12:12 (aborto em voo + a fila estreando o reenvio)

pid=150472. `fPassarCartao` (id=3) despachado 12:11:55.675; `Aproxime, Insira ou Passe o Cartao` às
12:11:59.975; queda às **12:12:03.638**, com o pinpad **coletando**.

| Hora | Evento |
|---|---|
| 12:12:03.643 | **`o pid=150472 caiu com a chamada id=3 EM VOO no pinpad - ABORTANDO pelo pSair`** — 5 ms depois da queda |
| 12:12:04.268 | **`Transacao cancelada`** — 625 ms depois do aborto |
| 12:12:06.305 | `fPassarCartao` voltou SEM retorno; `marca de pendencia` continua False |
| 12:12:06.305 | resposta para a fila local (não havia conexão viva: a con=3 só chegou às 12:12:24) |
| 12:12:33.126 | `pTrataReata: con=3 pid=150472 ... reatou a sessao existente` |
| **12:12:37.990** | **`pReenviaFilaLocal: con=3 (pid=150472) - fila tinha 1 item(ns): 1 entregue(s), 0 de outro autcom mantido(s), 0 descartado(s)...`** |

**Duas estreias nesta bateria:**

1. **O aborto funciona, e é rápido:** 2,3 s da queda até a transação cancelada no pinpad. O
   `pSair` foi lido enquanto a DLL ainda coletava, exatamente como o desenho previa.
2. **O reenvio da fila local rodou em campo pela primeira vez** — o único item que faltava do
   Passo 8, pendente desde 08/09. Entregue no accept, pelo gatilho do `reata`, sem o operador fazer
   nada. As cinco contagens do log saíram como o roteiro previa.

**E o TEFTRA passou a dizer a verdade:** `TRN CANCEL` gravado às 12:12:12, **depois** de a estação
ter cancelado de fato às 12:12:04. Antes o AUTCOM escrevia o desfecho 34 s antes de ele existir
(bateria das 10:32); agora o valor é consequência de um cancelamento real.


### VALIDADO EM CAMPO — 2026-09-09, 15:44–15:51 (bateria estendida: aborto + retentativa)

pid=23468, instância do serviço `{FAF78135-01C2-408A-80D4-2CECA352BD50}`. Quatro ciclos.

| Ciclo | O quê | Resultado |
|---|---|---|
| 1 | queda em voo num **`fCancelaTransacaoTerminal`** (15:46:25.291) | abortado em **10 ms**, `Transacao cancelada` em 1,2 s, resposta → fila, **fila drenada** 15:46:56.095 |
| 2 | **retentativa** do cancelamento (15:47:19) | `Controle 09905033006`, `Transacao completa`, resposta de 1945 bytes entregue |
| 3 | queda em voo num **`fPassarCartao`** (15:49:36.570) | abortado em **23 ms**, `Transacao cancelada` em 438 ms, **fila drenada** 15:50:10.388 |
| 4 | **retentativa** do cartão (15:50:18) | autorizado, `Controle 09905133004`; queda; pendência **True** preservada; **`fFinalizarTransacao` (id=16) com sucesso** 15:51:44.870 |

**Cinco coisas novas, além da repetição do aborto:**

1. **O aborto vale para `fCancelaTransacaoTerminal`** — segundo dos três métodos de transação, não
   só o `fPassarCartao`.
2. **A retentativa está validada ponta a ponta, duas vezes.** Até aqui só o aborto tinha evidência;
   agora o fluxo inteiro que o Rafael desenhou — abortar, operador tenta de novo, dá certo — está
   provado.
3. **A fila local drenou em 2 de 2 ocasiões.**
4. **A identidade do serviço fez round-trip completo:** ciclo 1 com `conhecida pelo autcom=""`,
   ciclos 3 e 4 com `{FAF78135-...}` igual à atual. Prova que o `pTrataReataResposta` guardou e o
   `pEnviaReata` devolveu — é o mecanismo que vai detectar reinício do serviço (RF29).
5. **Ciclo completo de pendência:** autorizada → queda → desanexada com `marca (True)` → reconexão
   → reata → `fFinalizarTransacao` com sucesso, com **duas** reconexões no meio.

**Brinde no começo do log — o dedup por conjunto enfrentou a primeira rajada real.** O plugin
aceitou o canal às 15:44:45 mas só conseguiu o socket às 15:45:13, porque o serviço subiu às
15:45:12. Nesses 28 s o AUTCOM retransmitiu o mesmo `fConfiguraTefCitel` **5 vezes** por ACK
timeout, e ao conectar tudo chegou junto: `recebidos 2710 bytes` → 1 quadro aceito + **4 duplicados
descartados**. É exatamente o cenário para o qual a correção de 04/09 (dedup por conjunto dos
últimos 512 ids, em vez de ordem estrita) foi feita, e é a primeira vez que ele pega uma rajada de
verdade.

**Observação para o Passo 8 — HIPÓTESE SUBSTITUÍDA em 2026-09-10, ver abaixo.** O ACK do
`reata_resposta` demora consistentemente ~4–6 s e precisa de 1 a 2 retransmissões — aconteceu em
3 dos 4 reatas desta bateria (15:50:07/09, 15:51:20/22, e 15:47:21 no hook). A hipótese registrada
aqui era disputa do `FcsEscrita` entre o `pEnviaReata` e a thread de leitura. **A bateria de 10/09
07:44 mostrou outra causa, documentada e já mitigada** — colisão com a expiração do
`WTSVirtualChannelRead`. Ver o bloco de 10/09 07:41–07:45.


### VALIDADO EM CAMPO — 2026-09-09, 10:14–10:16

Bateria única, um AUTCOM (pid=20564, terminal 003), sessão TS fechada e reaberta no meio.

| Hora | Evento |
|---|---|
| 10:14:08 | `fConfiguraTefCitel` → sessão criada, config aplicada |
| 10:14:48.253 | socket cai (sessão TS fechada) |
| 10:14:48.275 | **`sessao do pid=20564 (terminal="003") DESANEXADA, nao orfanada (RF24)`** |
| 10:15:10.433 | `TCP[con=2]: cliente (plugin) conectado` |
| 10:16:01.623 | `fPassarCartao` (id=6) despachado — **sem `Instanciando ITefCitel real` e sem linha do `pGarantePinpadConfigurado`** |
| 10:16:32 | `Controle 09905623004` / `Transacao completa` |
| 10:16:33.860 | `fPassarCartao` retornou com sucesso (2202 bytes, 2 fragmentos) |
| 10:16:40.809 | **`fFinalizarTransacao` (id=10) retornou com sucesso** |

**A prova da reatação é a ausência daquelas duas linhas:** a sessão foi reaproveitada em silêncio,
com a `ITefCitel` viva e os ponteiros carregados. A transação passou e foi **confirmada**. Nenhum
AV, nenhum login, nenhuma reconfiguração, nenhuma mensagem ao operador.

Colateral confirmado na mesma bateria: a RN06 refinada funcionou no cartão cancelado das 10:14:44 —
*"voltou SEM retorno... marca de pendencia NAO alterada. Marca continua em False."*

**O que esta bateria NÃO valida:** a transação foi iniciada 51 s **depois** da reconexão, e no
instante da queda não havia chamada pendente (o `fPassarCartao` anterior tinha retornado às
10:14:44). Então o **Passo 4** segue sem validação — chamada em voo no momento da queda ainda morre
com `ErroCanal`, por desenho. É o próximo.

**Binários validados nesta bateria:** `TefEstacaoService.exe` de **09/09 10:10:56** e
`padra_atualizado\libTefCitel.dll` de **09/09 10:11:25** — recompilados pelo Rafael na IDE a
partir dos mesmos fontes (o build de linha de comando às 10:06/10:07 foi substituído; um rebuild
Delphi não é byte-reproduzível, daí o tamanho diferente). Os dois estão preservados byte a byte no
backup `..\..\..\_backups\456190_20260909_1024\`.


### VALIDADO EM CAMPO — 2026-09-09, 10:31–10:33 (pendência sobrevive à queda)

Segunda bateria, um AUTCOM (pid=20876, terminal 003). O Rafael chamou de "semi-voo", e está certo:
**não foi em voo.** O `fPassarCartao` (id=7) retornou com sucesso às 10:32:27.660, a resposta de
2202 bytes foi entregue (o plugin repassou os 1417+819 bytes) e o AUTCOM ainda processou dois
`pRetornaLog`. A queda veio às 10:32:37.155 — 9,5 s depois, com o canal vazio.

| Hora | Evento |
|---|---|
| 10:32:27.660 | `fPassarCartao` (id=7) retornou com sucesso, resposta entregue |
| 10:32:37.171 | `sessao do pid=20876 ... DESANEXADA ... marca de pendencia (True)` |
| 10:33:11.381 | `TCP[con=4]: cliente (plugin) conectado` |
| 10:33:45.747 | `fFinalizarTransacao` (id=11) — **sem `Instanciando ITefCitel real`** |
| 10:33:48.113 | **retornou com sucesso** — desfazimento/confirmação normal |

**É a evidência mais forte da RF24 até aqui**, mais do que a bateria das 10:14. Antes desta mudança
o desfazimento **não** funcionaria: a sessão seria orfanada e coletada, a marca de pendência se
perderia, e o `fFinalizarTransacao` chegaria numa sessão sem configuração — o Access violation na
primeira versão, a recusa depois. A transação ficaria pendente e insolúvel pelo AUTCOM, para ser
confirmada em silêncio por um login qualquer (a perda que a RN09 aceita). Aqui ela foi resolvida
limpa, pelo próprio operador, no próprio AUTCOM.

**O que esta bateria NÃO valida:**

- **Passo 4** — segue sem teste. Nada estava pendente no canal no instante da queda.
- **A fila local do Passo 8 continua sem exercício em campo.** Nada foi enfileirado (a resposta
  chegou antes da queda): não há linha de `pEnviaOuEnfileira` nem de `pReenviaFilaLocal` no log.

**Achado colateral — o resíduo do RF28 apareceu em campo:** `2 sessao(oes) no dicionario`. A
segunda é a do pid=20564 da bateria das 10:14, cujo AUTCOM foi fechado. Inofensiva aqui porque a
marca dela é `False`, então não barra ninguém via `fSessaoVivaComPendencia` — mas confirma que
sessão de AUTCOM morto fica acumulando até um PID novo reusar o número ou o serviço reiniciar.

**Para o teste em voo de verdade:** a janela é entre `Aproxime, Insira ou Passe o Cartao` e
`Transacao completa` — nestes logs, ~25 s. Fechar o TS com o pinpad esperando o cartão, ou durante
os `Aguarde...` seguintes, é o que exercita o Passo 4 e a fila.


### TESTE EM VOO — 2026-09-09, 10:41–10:43 (fila local estreia; Passo 4 confirmado ausente)

pid=126164. `fPassarCartao` (id=3) despachado 10:42:31.505; queda às **10:42:38.309**, 2,7 s depois
do `Aproxime, Insira ou Passe o Cartao` — **em voo de verdade**.

- [x] **A fila local do Passo 8 rodou em campo pela primeira vez.** Nome exatamente como desenhado:
      `20260909_104320995_0001_pid126164.json`; log
      `pEnviaOuEnfileira: envio falhou - envelope id=3 tipo="resposta" persistido na fila local
      para o pid=126164 (RF07/RF21)`
- [x] RF24 funcionou de novo: `DESANEXADA ... marca de pendencia (False)`
- [x] Passo 4 **confirmado ausente**: a chamada pendente morreu com `ErroCanal` e o operador viu
      erro na tela, como previsto
- [ ] **O reenvio da fila continua sem exercício.** O `pSair` das 10:43:18 disparou a drenagem, mas
      a fila estava vazia (o item foi gravado 2,8 s depois) e o `fMarcaFilaLocalReenviada` é
      one-shot por conexão. Consequência do gatilho atual: **item enfileirado depois da drenagem
      daquela conexão espera pela conexão seguinte** — mais um motivo para o `reata` do Passo 3
- [x] **Linha da TEFTRA conferida (Rafael, 09/09).** `TFT_STATUS = TRN CANCEL`
      (`TRANSACAO_CANCELADA`, `untInterfaceTefCitel.pas:23`), sem NSU e sem Controle, valor 1.00,
      CREDITO, terminal 003, `TFT_HRATRA = 10:42:47`.
      **O valor está CORRETO nesta bateria** — nenhum cartão foi passado e a estação concluiu "SEM
      retorno", então cancelada é o desfecho verdadeiro.
      **Mas a linha prova o mecanismo do defeito, e prova melhor que um valor errado provaria:** o
      AUTCOM gravou o status final às **10:42:47** e a estação só concluiu às **10:43:20.995** —
      34 s depois. Ou seja, ele escreveu a partir de *"meu canal caiu"*, não de *"a transação foi
      cancelada"*. Acertou por coincidência. Com o cartão autorizado antes da queda, a mesma linha
      de código grava `TRN CANCEL` numa transação aprovada. O carimbo de hora torna a causa
      inequívoca — não é interpretação, é aritmética
- [x] **Confirma uma escolha do desenho:** com o Passo 4 o `fChamaRpc` continua esperando, o
      `finally` não roda na queda, e a linha fica em `TRN INICIADA` até o desfecho real chegar
      (virando `PENDENTE` com retorno, ou `TRN CANCEL` sem). **Nenhum status novo é necessário** — o
      "indeterminada" que a abordagem B exigiria é dispensável na A
- [ ] Continua sem evidência **direta** o valor errado (CANCELADA em transação aprovada); precisa de
      uma transação autorizada interrompida. Mas o mecanismo já está provado pela aritmética acima


### Deadlock evitado no Passo 3 (2026-09-09)

Achado em revisão do meu próprio código, antes de considerar o passo pronto — não pelo compilador.

O `pTrataReata` **escreve** no socket (a resposta do reata e a drenagem da fila), e o
`pOnFrameRecebido` da estação roda na **thread de leitura da conexão**. O `pEnviaFrame` espera ACK,
e o ACK só pode ser recebido por essa mesma thread: espera circular. É a mesma classe já documentada
duas vezes no lado AUTCOM (`pTrataEvento` e `pTrataHook`, ambos trocados para `TThread.Queue` por
causa disso), e é exatamente por isso que `chamada` sempre foi despachada em thread própria e
`hook_resposta` pode ficar inline — ele não escreve.

- [x] `reata` passou a ser despachado em thread própria (`pDespachaReataEmThreadPropria`)
- [x] No lado AUTCOM, o `pOnConectado` roda na thread de leitura do transporte, então ele **só**
      despacha uma thread curta; quem escreve é o `pEnviaReata`, de fora dela
- [x] Dois outros ajustes da mesma revisão: a consulta à fila passou para **antes** de criar o
      `TJSONArray` (ela faz I/O e pode levantar, e o array não tem dono até entrar no envelope), e
      os dois `GetValue(...) as TJSONArray` viraram teste com `is` — um frame malformado levantaria
      `EInvalidCast` dentro da cadeia de leitura, e o transporte trata exceção nessa cadeia como
      **desconexão**: derrubaria a conexão por causa de um campo torto


### VALIDADO EM CAMPO — 2026-09-09, 11:25–11:28 (Passo 3)

pid=108656. `fPassarCartao` (id=6) despachado às 11:26:51 na con=1; queda às 11:27:02, com o pinpad
em `Aproxime, Insira ou Passe o Cartao`. Reconexão às 11:27:25 (con=2).

**1. O reata funcionou.**
```
11:27:33.763  pTrataReata: con=2 pid=108656 (inicio="134334374653130505") reatou a sessao
              existente. Instancia do servico: conhecida pelo autcom="",
              atual="{323AC9C5-A1E4-4188-9B04-7BB67E572D89}".
              Ids pedidos: 0 emVoo, 0 naFila, 0 desconhecido(s).
```
Reatou pela identidade e o `inicioProcesso` trafegou como string decimal. `Ids pedidos: 0` é o
esperado — o `ErroCanal` já havia matado a chamada pendente antes de o reata sair (Passo 4).

**2. A `FConexaoAtual` entregou tudo, inclusive a resposta.** Mais do que se esperava desta etapa:
a transação em voo continuou e **todos** os eventos dela foram entregues pela con=2, e no fim a
própria resposta:
```
11:27:42.944  pEnviaOuEnfileira: a conexao do despacho estava morta, envelope id=0 tipo="evento"
              entregue pela conexao ATUAL da sessao (con=2, pid=108656).      [dezenas de vezes]
11:28:18.601  ... envelope id=6 tipo="resposta" entregue pela conexao ATUAL da sessao (con=2)
```
**Nada foi para a fila local nesta bateria** — nenhum `persistido na fila local`. Entrega ganha de
enfileiramento, e é por isso que a fila deixou de ser o caminho provável.

**3. O deadlock corrigido está validado por acidente.**
```
11:27:35.775  TCP[con=2]: sem ACK do messageId=2 apos 2000 ms (tentativa 1/5) - reenviando.
11:27:36.691  TCP[con=2]: recebidos 21 bytes.
```
`messageId=2` é o `reata_resposta`: ele **esperou ACK, retransmitiu e foi confirmado**. Se o
`pTrataReata` tivesse ficado na thread de leitura, essa espera travaria a thread que precisava
receber o ACK. O log mostra o caminho de escrita funcionando de dentro da thread própria.

**4. Achado que muda o peso do Passo 4.** Entre a queda e o `pSair` passaram **75 segundos** com o
pinpad em `Escolha uma Opção` / `1:2:3::` repetindo, o serviço reenviando o evento a cada poll, e
**ninguém podendo responder** — o AUTCOM havia abandonado a chamada e fechado a tela. Então o
Passo 4 não é só sobre registrar a venda: é sobre **o operador conseguir terminar a transação**. Com
a chamada esperando, a tela dele continua lá, ele escolhe a parcela e o fluxo fecha. Sem ele, o
pinpad pede resposta para uma tela que não existe e a saída é o `pSair`.

**5. O log do `pSair` deliberado estreou** (11:28:17.268), com o texto completo da decisão.

**Ainda sem exercício:** o reenvio da fila. E agora ele importa menos — com a `FConexaoAtual`, a
fila só entra quando não existe **nenhuma** conexão viva daquele pid.


### VALIDADO EM CAMPO — 2026-09-10, 08:36–08:44 (regressão de um AUTCOM + single-flight nos dois sentidos)

#### Caso 7 — um AUTCOM só, duas quedas de TS (pid 162632)

| Hora | O quê |
|---|---|
| 08:38:23 | `fPassarCartao` id=3 no pinpad (`Aproxime, Insira ou Passe o Cartao`) |
| **08:38:27.126** | **`Sessao RDP desconectada`** — queda com o pinpad coletando |
| 08:38:27.150 | `o pid=162632 caiu com a chamada id=3 EM VOO no pinpad - ABORTANDO pelo pSair` (Passo 4) |
| 08:38:28.126 | `Transacao cancelada` — 976 ms depois do aborto |
| 08:38:30.217 | `pEnviaOuEnfileira: envio falhou - envelope id=3 persistido na fila local` (RF21) |
| 08:38:55.457 | `canal REABERTO na tentativa 2, 28187 ms depois da queda` |
| 08:38:57.353 | `pTrataReata: con=3 reatou a sessao existente` (identidade `""` → serviço) |
| **08:38:57.439** | **`pReenviaFilaLocal: fila tinha 1 item(ns): 1 entregue(s)`** |
| 08:39:41 | transação completa: `Controle 09005543011`, resposta de 2202 bytes em 2 fragmentos |
| **08:39:48.907** | **segunda queda de TS**, agora com `marca de pendencia (True)` |
| 08:40:09.111 | `REABERTO na tentativa 11, 20078 ms depois` |
| 08:40:18.322 | `reata`: `conhecida pelo autcom="{B40C3BDD...}", atual="{B40C3BDD...}"` — round-trip completo |
| **08:40:46.400** | **`fFinalizarTransacao` com sucesso** — pendência confirmada após duas reconexões |

**A regressão que importava passou:** o Passo 6 mexeu no single-flight, no
`pGarantePinpadConfigurado` e no `fChamaRpc`, e os três estão no caminho de um AUTCOM sozinho. Os
Passos 0 a 5 continuam intactos.

**Brinde:** às 08:39:32.954 apareceu `quadro ATRASADO aceito (messageId=27, maior aceito=28) -
primeira entrega perdida no canal, recuperado pela retransmissao do emissor`. É a aceitação de
quadro fora de ordem (dedup por conjunto, correção de 04/09) sendo exercitada de novo, e agora com
o nome certo do que aconteceu.

#### Caso 2 — single-flight, nos dois sentidos

| Hora | Quem tenta | Quem detém |
|---|---|---|
| **08:42:53.040** | pid=18280 | pid=162632 em voo |
| **08:43:24.490** | pid=162632 | pid=18280 em voo |

Nos dois, a sequência é a mesma e é a nova:

```
chegou com o pid=N EM VOO no pinpad - seguindo para a guarda de posse (RF17 item 1),
que responde como negativa em vez de erro. Nada foi reservado nem despachado.
→ pGarantePinpadConfigurado: recusado - o pid=N esta com transacao EM VOO (RF17 item 1)
→ RECUSADO por posse do pinpad - respondendo como negativa (evento 500 + resposta sem retorno)
```

E o lado AUTCOM fecha a prova: `pTrataEvento: recebido status="500" mensagem="O pinpad esta em uso
por outro AUTCOM..."` seguido de `pNotifica: despachando status="500" ... para 1 observer(es)`, e
o `pTrataResposta: id=3 encontrado` — ou seja, **a chamada RPC voltou normalmente, sem exceção**.
Sem exceção não há como o madExcept aparecer; a mensagem sai pelo `pMsgInfo500` → `fMensagem`.

#### Três observações que ficam para o Passo 8 (nenhuma é defeito)

1. **Acúmulo de sessões, agora visível crescendo:** `2 sessao(oes)` no começo, `3 sessao(oes)` no
   fim. É a RF28, do Passo 7.
2. **Margem do ACK mais estreita do que eu supunha.** Às 08:40:18 o `reata_resposta` precisou de
   **duas** retransmissões e só foi lido às 08:40:23 — **5 s**. O orçamento é 5 tentativas × 2 s =
   ~10 s, então a margem observada é de 2×. E isto **muda em parte a explicação de 10/09 07:44**: a
   colisão com a expiração da leitura explica a perda do primeiro quadro (escrito 08:40:18.322,
   leitura expirou 08:40:18.336, 14 ms depois), mas **não** explica a cópia escrita às 08:40:20.328
   ter levado 3 s para aparecer numa leitura já em curso. Há latência de entrega no canal DVC que
   não vem do nosso código, e a retransmissão está cobrindo. Medir antes de mexer.
3. **17 s entre o canal morrer e o operador ser avisado.** `WTSVirtualChannelRead falhou com erro
   233` às 08:38:27.262 e `pNotificaCanalCaiu` só às 08:38:44.131. O `pNotificaDesconexao` é
   chamado na hora, na thread de leitura (linha 903 de `untTefCitelDvcTransporte.pas`), e a
   primeira tentativa de reconexão só foi registrada às 08:38:53.441 — 26 s depois da queda, e
   **10 s depois de a sessão RDP já ter voltado** (08:38:43.685). Ou seja, a reconexão poderia ter
   acontecido ~10 s mais cedo. **Causa não estabelecida** — a hipótese mais provável é a thread
   principal e/ou o `WTSVirtualChannelClose` bloqueando enquanto a sessão TS está desconectada,
   mas não medi. Invisível ao operador (a sessão está fora do ar nessa janela), porém são 10 s de
   indisponibilidade a mais no pilar do requisito.


### VALIDADO EM CAMPO — 2026-09-10, 07:41–07:45 (caso 4: processo morto → tomada automática)

Cenário do Rafael: pendência no A, tentativa no B, **A encerrado pelo gerenciador de tarefas**,
volta no B. Relato: *"esse fluxo ficou muito bom"*. A (pid 98392) e B (pid 3836), os dois no
terminal 003.

| Hora | O quê | Resultado |
|---|---|---|
| 07:43:03 | A autoriza (`Controle 09005043012`) e não finaliza | pendência do A |
| 07:43:30 | login do B | ADIADO (RF17 item 4) |
| 07:43:45 | B tenta passar cartão | `conexao viva=True` → `IsHungAppWindow=False` → **recusa sem perguntar nada** (caso 1 de novo) |
| **07:43:51** | **Rafael mata o A pelo gerenciador** | sessão DESANEXADA com `marca de pendencia (True)` |
| **07:44:00.869** | B tenta de novo | `conexao viva=False` → `fProcessoAutcomVivo: pid=98392 ja TERMINOU (codigo de saida 99)` → **`assumindo o pinpad sem perguntar ao operador (RN16)`** |
| **07:44:00.886** | **retentativa automática, dentro da mesma ação do operador** | `VEREDITO de disputa ... morto=True, confirmadoPeloOperador=False` → `TOMADA DO PINPAD concedida` → `pOrfanaSessao` (+ o aviso da RN09) → `A impressao digital dele BATE com a da DLL` → `REAPLICANDO` → despacho |
| 07:44:07 | `AntesPassarCartao respondido em 6406 ms` | **a trava LCKATC do A, órfã**, com o `fMensagem` do projeto. B volta sem retorno |
| 07:44:14 | B tenta (trava ainda lá) | `respondido em 3078 ms`, sem retorno |
| **07:44:59** | B tenta depois de o Rafael remover a trava | `respondido em 47 ms` → pinpad → `Controle 09005143010` → `Transacao completa` |
| 07:45:42 | B finaliza | **venda do B confirmada** |

**Conferido no relatório do TEF pelo Rafael:** transação do **A pendente**, do **B confirmada**.

**O que esta bateria provou, e nenhuma outra tinha provado:**

1. **O caminho de TOMADA do pinpad, ponta a ponta** — o mais perigoso do requisito. `morto=True`
   verificado por `GetExitCodeProcess` (código 99), par (pid, inicioProcesso) conferido pela
   estação, `pOrfanaSessao` com o aviso da RN09, e o requisitante trabalhando em seguida.
2. **A retentativa automática do `fChamaRpc`** (a casca sobre `fChamaRpcUmaVez`): id=6 volta
   contestável, o AUTCOM resolve, id=7 sai com o veredito — **tudo dentro de uma única ação do
   operador**, que só viu a tela do TEF abrir.
3. **A LCKATC fez o trabalho dela**, e é a peça que fecha o desenho: o A morreu segurando a
   trava, e quem barrou o B foi a trava do projeto com a mensagem do projeto — não a estação.
   O operador removeu pelo procedimento que já existe e seguiu. A guarda da estação e a LCKATC
   são camadas diferentes e as duas funcionaram no papel de cada uma.
4. **A correção do texto do log** (`BATE com`, no lugar do `True` solto).

**Uma pergunta que a bateria abriu e eu não sei responder.** Às 07:44:00.886 a reaplicação chamou
`fConfiguraTefCitel` nativo com `somenteCarregarLib=False`, e é ela que *"termina em
`FechaSessaoTEF(SCO_CONFIRMA_TEF, forcado)`"* — a justificativa inteira da RF17 item 4. A pendência
do A estava aberta naquele instante. **Pela teoria, esse confirm deveria ter resolvido a pendência
do A** (o slot é único por processo, specs.md 9.3). Não resolveu: o relatório mostra o A pendente.
Não sei por quê — talvez porque o A já estava morto, talvez pela ordem das globais do
`untScopeNCR`. **Não concluir que é impossível:** o desfecho observado é o desejado, o mecanismo
não está entendido, e o nativo é off-limites para investigar. Registrado como incógnita, não como
garantia.

**Resíduo esperado, do Passo 7:** `Restam 1 sessao(oes) ativa(s) e 1 orfa(s)` — a órfã do A só sai
quando a RF28 existir.


### VALIDADO EM CAMPO — 2026-09-10, 07:23–07:27 (casos 1 e 6 do Passo 6)

A (pid 146628) e B (pid 70668), **os dois no terminal 003 e na mesma loja** — a combinação que faz
as duas impressões digitais colidirem, e que era o cenário do 64004.

| Hora | O quê | Resultado |
|---|---|---|
| 07:24:23 | A autoriza (`Controle 09005833016`) e **não finaliza** | A fica com pendência |
| 07:24:49 | login do B | **ADIADO** — e o log já traz o texto novo, "que agora acontece mesmo com a impressão digital idêntica" |
| **07:25:14** | **B tenta passar cartão** | `CONTESTAVEL` → `IsHungAppWindow=False` → **`recusando sem perguntar nada ao operador`** → `status="500"` com a mensagem nova. **Nenhuma pergunta apareceu** |
| 07:25:27 | B tenta de novo | desfecho idêntico, sem incomodar o operador |
| 07:25:59 | A finaliza (`fFinalizarTransacao`) | pendência resolvida |
| **07:26:06** | **primeiro cartão do B** | **`o pid=70668 nunca executou o proprio fConfiguraTefCitel ... aplicando agora`** → `REAPLICANDO` → `reaplicacao concluida` → chega ao pinpad, `Controle 09005933014`, `Transacao completa` |
| 07:26:50 | B finaliza | venda inteira do B concluída |

**Caso 1 — o que o Rafael tinha apontado como errado agora está certo.** Detentor saudável com
pendência: recusa direta, sem pergunta. E rápido: o ciclo inteiro no lado AUTCOM levou **12 ms**
(07:25:14.826 → .850), contra os 5 s que a sonda gastava para chegar à conclusão errada.

**Caso 6 — o 64004 morreu.** O log mostra as duas impressões digitais **idênticas** no mesmo
Format (`"T||172.30.96.233|69690001|003|ComPort=COM6;MsgPP=HOMOLOGAÇÃO TEF"` para os dois pids) e
a reaplicação acontecendo **mesmo assim** — que é exatamente o que o `FblnCfgAplicadaNaInstancia`
foi feito para garantir.

**Duas coisas que só o campo podia responder:**

1. **O `EnumWindows` acha a janela principal dentro da sessão TS.** `fJanelaPrincipalTravada:
   pid=146628, janela 0x330B7E` — era o risco não verificado da abordagem, e ele caiu.
2. **O `IsHungAppWindow` respondeu em 1 ms.** Sem round-trip, sem prazo, sem espera.

**O que esta bateria NÃO cobre — e é a parte protegida pela RN16:** os casos 2 a 5. O caminho de
**tomada** do pinpad nunca rodou — nem a pergunta ao operador, nem o
`pSetConfirmaTomadaPinpadTef` (o export novo e o callback no host **seguem sem uma única
execução**), nem `fTomadaAutorizada`, nem o orfanamento pela disputa. O que está provado é o
caminho de **recusa**, que é o mais frequente; o de tomada é o mais perigoso e continua no papel.

**Resíduo esperado, do Passo 7:** `2 sessao(oes) no dicionario` depois de os dois desconectarem
(07:26:59 e 07:27:03) — é a RF28, que ainda não foi implementada.

#### Redesenho da detecção de "travado" — 2026-09-09, 17:28 (primeiro teste de campo)

Relato do Rafael: *"apareceu a pergunta para o operador se ele queria o pinpad para ele (achei
errado, pois o autcom A estava vivo só aguardando eu desfazer/confirmar a transação)"*. Ele está
certo, e o erro é de desenho, não de calibragem.

**O furo.** A disputa só dispara contra o detentor por **pendência**. E um AUTCOM com pendência
está, por definição, **fora de qualquer chamada de TEF** — parado esperando o operador confirmar
ou desfazer. A justificativa que sustentava a sonda (*"um AUTCOM saudável responde mesmo dentro de
um `fPassarCartao`, porque o `fChamaRpc` bombeia `CheckSynchronize`"*) é verdadeira e
**irrelevante**: o único caso que chega à sonda é o caso em que ele não está dentro de chamada
nenhuma. Varrendo todas as baterias do requisito, **todo hook já respondido neste projeto foi
respondido com o AUTCOM dentro do laço de bombeamento do `fChamaRpc`** — não há um só caso de hook
respondido com o AUTCOM ocioso.

**Evidência de campo.** 17:28:00.211 sonda despachada; 17:28:00.233 `TCP[con=1]: recebidos 21
bytes` (o ACK do A, em 22 ms — o transporte dele estava vivo); 17:28:05.242 estouro dos 5 s. O
quadro chegou, o corpo do hook não rodou.

**O que ficou.** Quem responde "está travado?" passou a ser o **Windows**, via `IsHungAppWindow`,
consultado pelo AUTCOM **requisitante** — que já verifica o processo do detentor pela RN17 e roda
no mesmo servidor. A estação continua garantindo o que consegue garantir sozinha: o veredito só
vale se o par (pid, inicioProcesso) bater com o detentor daquele instante, "morto" só é aceito com
a conexão caída, e a tomada de processo vivo exige confirmação humana.

**Custo assumido:** a RN15 dizia que *"o veto é a sonda, que o requisitante não tem como
falsificar"*. Sem sonda, o veto passa a depender do relato do requisitante. A trava real vira a
confirmação humana — e, na direção que importa, o comportamento **melhorou**: um detentor
respondendo agora é recusado **sem incomodar ninguém**, que é exatamente o que o Rafael esperava.

#### Correção fora de passo — login adiado nunca aplicado (erro 64004, 2026-09-09 17:28)

Segundo achado da mesma bateria: depois que o A desfez a transação, o B passou a falhar com
**"Erro Desconhecido (64004)"** em ~140 ms, sem chegar ao pinpad.

Cadeia, toda no log:

1. **17:27:08.658** — login do B **ADIADO** (RF17 item 4), o A estava em voo. A DLL não foi chamada.
2. O desenho previa que a configuração do B entraria na primeira chamada de pinpad, pela
   reaplicação de `pGarantePinpadConfigurado`. **Nunca entrou** — não há nenhuma linha
   `REAPLICANDO` para o pid=105100 no log inteiro.
3. Por quê: a reaplicação era decidida só pela impressão digital, e o comentário do próprio
   `fImpressaoDigitalConfig` diz o que aconteceu — *"Dois autcom da MESMA empresa e MESMO terminal
   produzem a mesma impressão digital - e aí a reaplicação é pulada."* Os dois AUTCOM do teste são
   terminal 003, mesma loja.
4. **17:28:50.774** — primeiro cartão do B: `status="64004"`, sem evento de pinpad.

Contraste que fecha: na bateria das 17:07 o login do B **rodou nativamente** e a transação dele
chegou ao pinpad normalmente.

**Causa raiz.** A impressão digital responde *"a DLL está configurada assim?"* — um fato de
**processo**. O login é também um fato de **instância**: é o `fConfiguraTefCitel` que monta o
estado dentro da `ITefCitel` daquela sessão. Uma sessão com login adiado tem a digital igual à de
quem está na DLL e mesmo assim nunca executou o próprio login.

- [x] `TTefEstacaoSessaoAutcom.FblnCfgAplicadaNaInstancia` — distingue "recebi os argumentos"
      (`FblnCfgRecebida`) de "o `fConfiguraTefCitel` nativo rodou para esta sessão"
- [x] A saída antecipada por impressão digital passa a exigir **as duas** condições
- [x] `TefEstacaoService.dproj` compila limpo
- [x] **VALIDADO EM CAMPO — 2026-09-10, 07:26:06.** Ver o bloco abaixo
- [x] Corrigido um erro de texto no log novo que a bateria expôs: `A impressao digital True a da
      DLL` — eu passei um `BoolToStr` para um `%s` que pedia uma frase. Agora sai `BATE com` /
      `NAO bate com`

Pré-existente da RF17 item 4 (08/09). Só aparecia com dois AUTCOM da **mesma empresa e mesmo
terminal** — combinação que ainda não tinha sido testada.

#### PASSO 6 ENCERRADO — 2026-09-10

Implementação, build e testes de campo concluídos. **Os três testes que faltavam passaram**, e o
build está conferido por timestamp.

- [x] **`autcom.exe` recompilado na IDE e `libTefCitel.dll` reimplantada — CONFERIDO por
      timestamp:** `untTefCitelUtil.pas` (a blindagem do import) é de **08:27:41** e o
      `autcom.exe` é de **08:35:53** — posterior, portanto o rebuild pegou a blindagem. A
      `libTefCitel.dll` é de 08:31:47 (as três melhorias de log) e o `TefEstacaoService.exe` de
      08:12:05. A bateria das 08:36–08:44 rodou com os três, e o log do AUTCOM de lá já traz o
      prefixo `pid=` novo — prova independente de que a DLL em uso era a nova, e não a de 07:17
- [x] **Caso 7 — regressão de um AUTCOM só — VALIDADO 10/09, 08:36–08:41.** Ver o bloco abaixo.
      Exercitou muito mais que a regressão pedida: **duas** quedas de TS, aborto em voo, fila local
      persistindo e drenando, `reata` com round-trip de identidade, e a pendência confirmada no
      fim
- [x] **Caso 2 do single-flight — VALIDADO 10/09, 08:42:53 e 08:43:24**, e **nos dois sentidos**.
      Ver o bloco abaixo
- [x] **Caso 8 — regressão com `CFG_TEFDVC = N` — VALIDADO 10/09** (*"fiz o teste e funcionou
      normalmente"*). Este caso ganhou motivo novo com a blindagem: o registro do callback é
      **incondicional**, então o `try/except` novo roda também na arquitetura clássica — deixou de
      ser regressão de cortesia e passou a exercitar código novo. Sem regressão

**Cinco dos oito casos do roteiro validados em campo** — 1 (detentor saudável), 4 (processo morto →
tomada automática), 6 (login adiado / fim do 64004), 7 (um AUTCOM só sob oscilação de TS) e 8
(`CFG_TEFDVC = N`) — mais o caso do single-flight, nos dois sentidos.

**Fica fora por decisão registrada em 10/09:** os casos 2, 3 e 5 — os três que passam pela
**pergunta ao operador**. Exercitá-los exige um AUTCOM **travado** (processo vivo, janela que não
responde), que não é simulável aqui; a validação vai vir do log de produção, e é por isso que o log
desse caminho foi reforçado antes (bloco "Log para diagnosticar o AUTCOM travado em produção"). O
`pSetConfirmaTomadaPinpadTef` e o `VS_funcConfirmaTomadaPinpadTef` seguem com **zero execuções** —
está dito, não escondido.

**Resíduos que NÃO são do Passo 6** (cada um já registrado no seu lugar): a incógnita do
`FechaSessaoTEF` sobre pendência viva; os ~10 s de reconexão desperdiçados (08:38, causa não
medida); a margem de 2× no orçamento de retransmissão; o acúmulo de sessões (RF28, Passo 7); a RN13
a rediscutir; e o que é Passo 8 (`analysis.md`, seção na `IA\rules\tef-dvc.md`, log consolidado
RF22 com rotação, limite de tamanho e chave de desligar).

#### Roteiro de validação do Passo 6 (casos — a escrita formal é do analista)

Todos com dois AUTCOM na mesma estação, A detendo o pinpad por **pendência de confirmação**.

1. [x] **A saudável (o caso que falhou em 17:28) — VALIDADO 10/09 07:25.** Falta só a variante
   "nem removendo a trava LCKATC o B consegue", que não foi exercitada.
2. **A travado.** Travar A (breakpoint na thread principal, ou um modal preso). B tenta passar
   cartão. Esperado: `IsHungAppWindow=True` no log do AUTCOM, a pergunta aparece no B, operador
   responde **Sim**, log `TOMADA DO PINPAD concedida`, B trabalha, **A não é morto** e a transação
   dele fica pendente no relatório do TEF.
3. **A travado, operador responde Não.** Mesma preparação. Esperado: B recebe a negativa comum
   (status 500, sem diálogo do madExcept) e **A segue intacto**.
4. [x] **A morto pelo gerenciador de tarefas — VALIDADO 10/09 07:44.** `pid=98392 ja TERMINOU
   (codigo de saida 99)` → tomada automática sem pergunta, B trabalhou e concluiu, e a transação
   do A ficou **pendente** no relatório do TEF. Passou pela trava LCKATC órfã do A no caminho,
   com o `fMensagem` do projeto — que é o procedimento que já existia.
5. **A com a sessão TS derrubada mas o processo vivo.** Conexão caída e processo existente:
   esperado o caminho da pergunta (caso 2), não o automático.
6. [x] **Login adiado com terminal igual** (o 64004) — **VALIDADO 10/09 07:26:06**, com as duas
   impressões digitais idênticas no log e a reaplicação acontecendo mesmo assim.
7. [x] **Regressão: um AUTCOM só, oscilação de TS — VALIDADO 10/09 08:36–08:41**, com duas quedas
   e a pendência confirmada no fim. A disputa não apareceu no log, como esperado.
8. [x] **Regressão: `CFG_TEFDVC = N` — VALIDADO 10/09**, sem mudança de comportamento. Exercita a
   blindagem nova do import, que é registrada incondicionalmente.

### Analises de bateria de campo do Passo 7 da Fase 5 (2a passada da migracao)

Vinham de dentro da secao *"Passo 7 da Fase 5"* do `tasks.md`, que sozinha tinha 30 KB. Sem
uma palavra alterada, na mesma ordem.


#### CAMPO 2026-09-10, 10:09-10:13 — a coleta NAO rodou, e o defeito era meu

Primeira bateria do Passo 7. Binários conferidos: `TefEstacaoService.exe` 09:54:54, posterior às
edições (09:41–09:47), e a bateria foi 10:09–10:13 — **o código novo estava rodando**.

**Resultado: a coleta da órfã não aconteceu.** Nenhuma linha
`pColetaOrfasAntesDeReconfigurar` no log, e o resíduo ficou visível no fim:
`Restam 1 sessao(oes) ativa(s) e 1 orfa(s)`.

##### A causa

`fPassarCartao` **é método de transação**, então o `pTrataChamada` reserva
`FblnTransacaoEmAndamento := True` na linha 1918 — e só chama
`pGarantePinpadConfigurado` na linha 2052. Minha coleta começa com
`if FblnTransacaoEmAndamento then Exit`, então saía na primeira linha, com zero, e por isso não
logava nada.

**É o mesmo erro da guarda de thread, que eu tinha acabado de consertar no mesmo método:** uma
guarda que quer dizer *"outro está em código nativo"* estava medindo *"eu estou ocupado"*. A
transação em voo ali é a reserva da própria chamada que vai configurar a DLL, e ela **ainda não
encostou em código nativo** — o despacho vem depois da guarda de posse.

- [x] **Conserto:** a guarda passa a ignorar a transação em voo **do próprio chamador** no caminho
      da reconfiguração (`fColetaOrfas` e `pColetaOrfasAntesDeReconfigurar` ganharam
      `AdwPidChamador`). Transação de **outro** pid continua barrando. Compila limpo

**As três guardas de `fColetaOrfas` agora são consistentes** — todas medem "outro", nenhuma mede
"eu": contagem de sessões (só no caminho antigo), threads de despacho (ignora a própria) e
transação em voo (ignora a do próprio pid).

##### O roteiro que eu escrevi apontava para o lugar errado

O caso 1 dizia: *"B faz login e passa cartão. Esperado: `pColetaOrfasAntesDeReconfigurar (login do
pid=N)`"*. **Isso nunca poderia acontecer nesse cenário**, por dois motivos que eu não tracei antes
de escrever o roteiro:

1. **No login não existe órfã ainda.** Quando A é morto pelo gerenciador, a sessão dele fica
   `DESANEXADA, nao orfanada (RF24)` — continua no `FdictSessoes`. A órfã só nasce às 10:12:31,
   quando a tomada acontece (`pOrfanaSessao`).
2. **O login do B foi ADIADO** (RF17 item 4), porque A ainda constava vivo e com pendência. E o
   ramo adiado **não coleta**, por desenho.

Logo, a única janela possível era a **reaplicação** — e é lá que a guarda me barrou. O caso 1 do
roteiro foi corrigido abaixo.

##### O que a bateria PROVOU, e é resultado de regressão

Todo o fluxo do Passo 6 continua de pé com o código do Passo 7 no lugar:

| Hora | O quê |
|---|---|
| 10:10:18 | A (pid=162736) conclui `Controle 09005653018` e **não** finaliza → pendência |
| 10:10:26 | A morto pelo gerenciador; sessão `DESANEXADA, nao orfanada (RF24)` |
| 10:11:20 | Login do B (pid=64196) **ADIADO** pela RF17 item 4 |
| 10:12:11 | `fPassarCartao` do B devolvido **CONTESTAVEL** |
| 10:12:31.790 | `fProcessoAutcomVivo: pid=162736 ja TERMINOU (codigo de saida 99)` |
| 10:12:31.782 | `TOMADA DO PINPAD concedida` → `pOrfanaSessao` |
| 10:12:31.782 | Reaplicação do login adiado, com as duas impressões digitais **idênticas** |
| 10:12:53 | `Controle 09005753016` — venda do B |
| 10:13:19 | `fFinalizarTransacao` com sucesso |

##### Duas observações que não são defeito

1. **O veredito "de uso único" vaza para chamadas aninhadas.** Às 10:12:46.570 o `pInfo21` chegou
   carregando o veredito outra vez (`morto=True`). O `pLimpaVereditoDisputa` roda no `finally` do
   `fChamaRpc` **externo**, e o `pInfo21` acontece com o `fPassarCartao` ainda em voo. **É inerte:**
   o `fTomadaAutorizada` casa o par (pid, inicioProcesso) com o detentor atual e ignora veredito que
   não bate, e "morto" só vale com a conexão do detentor caída. Mas "uso único" na verdade é
   "limpo no fim da chamada externa" — vale ajustar o comentário do campo no Passo 8.
2. **A varredura de subida (RF29) não pôde ser verificada.** O log entregue começa às 10:09:46, no
   meio de uma transação; as linhas de subida do serviço ficaram fora. **Precisa do começo do
   arquivo, ou de um restart do serviço com item na fila** (caso 4 do roteiro).


#### VALIDADO EM CAMPO — 2026-09-10, 10:25-10:31 (RF28 + varredura de subida)

Segunda bateria, depois do conserto da guarda de transação em voo.

##### RF28 — a coleta rodou, no ponto exato

```
10:30:44.301  pGarantePinpadConfigurado: ... REAPLICANDO a configuracao do pid=94948
10:30:44.301  pColetaOrfasAntesDeReconfigurar (reaplicacao para o pid=94948):
              1 instancia(s) orfa(s) liberada(s) - RF28
10:30:44.303  pGarantePinpadConfigurado: reaplicacao para o pid=94948 concluida
```

Entre o `REAPLICANDO` e o `concluida`, como previsto no roteiro corrigido. **Janela de ponteiro nulo:
2 ms**, dentro do `FcsPinpad`, sem nenhuma outra thread de despacho.

##### A prova de que o receio do Rafael está coberto não é a linha da coleta

É o que veio **depois** dela: `Aproxime, Insira ou Passe o Cartao`, `SELECIONADO: MASTERCARD`,
`pInfo21` (chamada nativa), `Controle 09005953012`, `Transacao completa`, `fPassarCartao` retornando
com sucesso às 10:31:07 e `fFinalizarTransacao` OK às 10:31:30. **Dezenas de chamadas nativas
rodaram com os ponteiros repovoados**, 2 ms depois de serem anulados — exatamente o que a garantia
por ordem prometia.

##### O resíduo desapareceu

| Momento | Estado |
|---|---|
| 10:27:13 | `1 sessao(oes) ativa(s)` — A entra |
| 10:29:39 | `2 sessao(oes) ativa(s)` — B entra |
| 10:30:44 | `Restam 1 sessao(oes) ativa(s) e 1 orfa(s)` — A orfanado |
| 10:30:44 | **coleta: 1 órfã liberada** |
| 10:31:37 | `1 sessao(oes) no dicionario` — **e zero órfãs** |

Na bateria anterior isto terminava com `1 ativa e 1 orfa`. É o fim do acúmulo que motivou a RF28.

##### RF29 — varredura de subida rodou, mas só o caminho da fila VAZIA

```
10:25:43.934  ServiceStop chamado.
10:26:20.360  ServiceStart chamado.
10:26:20.360  pVarreFilaNaSubida: fila local vazia na subida do servico
              (instancia "{1BD16EEF-A074-4F54-B64E-88EBB52C6EFB}") - nada herdado (RF29)
```

- [x] A varredura é chamada na subida, antes de qualquer conexão, e a identidade da instância aparece
- [ ] **O caminho do DESCARTE segue sem exercitar** — precisa de item na fila no momento do restart
      (caso 4 do roteiro). Não confundir uma coisa com a outra

##### O ramo adiado não coletou, como desenhado

Às 10:29:39.921 o login do B foi `ADIADO` e **não há linha de coleta** ali — correto por desenho, e
naquele instante também não havia órfã (a sessão do A estava `DESANEXADA`, não órfã).

##### O caminho quente do Passo 7 rodou ~16 vezes sem incidente

O `pRefazTefSeServicoReiniciou` roda no topo de **toda** chamada RPC. Nesta bateria ele saiu na
primeira linha em todas elas (nenhuma troca de instância foi detectada: cada AUTCOM conectou depois
do restart, e na primeira resposta de `reata` a instância conhecida ainda está vazia). São ~16
chamadas por AUTCOM passando pelo código novo sem efeito — sinal de regressão fraco, mas real, e
o caso 6 do roteiro continua obrigatório.

##### O vazamento do veredito repetiu, e segue inerte

Às 10:30:58.844 o `pInfo21` chegou com o veredito outra vez, pelo mesmo motivo já apurado (o
`pLimpaVereditoDisputa` roda no `finally` do `fChamaRpc` externo). Continua sem consequência: o
`fTomadaAutorizada` casa o par (pid, inicioProcesso) e "morto" só vale com a conexão caída.


#### VALIDADO EM CAMPO — 2026-09-10, 10:45-10:48 (regressao de um AUTCOM so, o caso de maior risco)

Um AUTCOM (pid=52860), **duas quedas de TS**: a primeira ociosa, a segunda com transação **em voo**.
É o caso que protege os Passos 0 a 6, e o que mais me preocupava no Passo 7 — o
`pRefazTefSeServicoReiniciou` roda no topo de **toda** chamada RPC.

| Hora | O quê |
|---|---|
| 10:45:01 | Login **não** adiado, `fConfiguraTefCitel` nativo, retorno 0 |
| **10:45:20.143** | **1ª queda de TS**, sem transação |
| 10:45:46.597 | `canal REABERTO na tentativa 14, 26312 ms depois da queda` |
| 10:46:00 | `reata` com instância conhecida `""` → resposta `{1BD16EEF...}` |
| 10:46:21 | `fPassarCartao` id=3, pinpad coletando |
| **10:46:42.219** | **2ª queda, com a chamada EM VOO** |
| 10:46:42.237 | `caiu com a chamada id=3 EM VOO no pinpad - ABORTANDO pelo pSair` (Passo 4) |
| 10:46:42.740 | `Transacao cancelada` |
| 10:46:44.786 | `voltou SEM retorno` → `envelope id=3 persistido na fila local` (RF21) |
| 10:47:02.199 | AUTCOM: `pNotificaCanalCaiu` → status 500 na tela do operador |
| 10:47:14.251 | `REABERTO na tentativa 7, 31890 ms depois` |
| 10:47:28 | `reata` com instância conhecida `{1BD16EEF...}` → **igual** |
| 10:47:35.533 | `pReenviaFilaLocal: fila tinha 1 item(ns): 1 entregue(s)` |
| 10:47:35.561 | AUTCOM: `id=3 NAO ENCONTRADO em FdictChamadas` — resposta atrasada descartada, como documentado |
| 10:48:16 | `Controle 09005063010`, `Transacao completa` |
| 10:48:23.808 | `fFinalizarTransacao` com sucesso |

##### O que isso prova sobre o Passo 7, e é o ponto

**O `pRefazTefSeServicoReiniciou` não deu falso positivo em nenhuma das duas reconexões.**

- 1ª `reata`: instância conhecida `""` → `LblnReiniciou` é False porque exige **as duas** não-vazias.
  Sem isso, **toda primeira reconexão** dispararia um re-login e um aviso ao operador
- 2ª `reata`: instância conhecida **igual** à atual → nada disparado

Ele rodou no topo de ~10 chamadas RPC e saiu na primeira linha em todas. O caminho de no-op está
validado; o caminho útil (troca real de instância) segue com **zero execuções**.

##### Duas medições que REFINAM coisas que eu já havia afirmado

**1. O atraso do ACK não é "latência de entrega do canal" — é um travamento da LEITURA, e é
reproduzível.** Em 09/09 eu escrevi que *"há latência de entrega no canal DVC"*. Os números de hoje
mostram outra coisa, e a diferença importa para o Passo 8:

| | Reconexão 1 | Reconexão 2 |
|---|---|---|
| Estação escreve a resposta do `reata` | 10:46:00.930 | 10:47:28.931 |
| Leitura do AUTCOM **expira** (15 s) | 10:46:00.960 | 10:47:28.946 |
| Retransmissões (de 5 possíveis) | 3 | 3 |
| AUTCOM finalmente lê | 10:46:07.464 | 10:47:35.546 |
| **Atraso total** | **6,5 s** | **6,6 s** |

As **três cópias** chegaram em 2 ms uma da outra (`quadro duplicado descartado` duas vezes, nas duas
reconexões). Se fosse latência por quadro, elas chegariam espaçadas de 2 s. Chegando juntas, o
quadro ficou **retido e liberado em rajada** — é a leitura que não retorna, não a entrega que
demora.

A perda do **primeiro** quadro tem causa conhecida (a colisão com a expiração da leitura: escrito
`.930`, leitura expirou `.960`, 30 ms depois). O atraso das retransmissões **não está explicado**.

**2. A margem do orçamento de retransmissão é 1,5×, não 2×.** O orçamento é 5 tentativas × 2 s ≈
10 s, e hoje foram consumidos **6,5 s, duas vezes, com a mesma assinatura**. Registrei 2× em 09/09
com base numa amostra de 5 s; a medição de hoje é mais apertada **e reproduzível**.

##### Tempo total de reatamento, medido

Da queda de TS até o `reata` completo: **47 s** (1ª) e **53 s** (2ª). Composto de ~26–32 s para
reabrir o canal, ~14,5 s até o `reata` sair (as duas vezes ~14,5 s — suspeitamente igual ao timeout
de leitura de 15 s, **hipótese não medida**) e ~6,5 s do atraso acima. A transação seguinte do
operador funcionou normalmente; é indisponibilidade, não perda.

##### Um resíduo que a RF28 NÃO resolve

`2 sessao(oes) no dicionario` do começo ao fim, com **um único AUTCOM ativo**. A sessão sobrando é
do pid=94948, da bateria das 10:30, que fechou normalmente.

**Sessão de AUTCOM que fecha normalmente nunca sai do `FdictSessoes`.** A RF24 a deixa
`DESANEXADA` esperando o mesmo processo voltar, e a RF28 coleta **órfãs**, não desanexadas. Cada
AUTCOM fechado deixa uma `ITefCitel` viva.

**Severidade conferida no código, não estimada:** o `fGaranteSessao` **valida o par (pid,
inicioProcesso)** e orfana a sessão velha quando o Windows recicla o número (RF23) — então a órfã
resultante é coletada pela RF28. Não há risco de o processo novo herdar loja/terminal do velho, e o
crescimento é limitado pela reciclagem de PID. **Não é defeito de correção; é crescimento de memória
não limitado no pior caso.** Fica como decisão para o Passo 8, não como conserto agora.


#### LACUNA da RF29: reinício puro do serviço NÃO dispara a detecção (2026-09-10)

Achado ao montar o roteiro do teste de re-login, lendo o plugin.

**O plugin reconecta o socket sozinho e nunca toca no canal DVC.** O
`pLoopConectorELeitura` (`untTefCitelDvcPluginImpl.pas:375`) tem um laço que refaz o
`fTentaConectarSocket` e loga `Socket desconectado do TefEstacaoService.exe - tentando reconectar`
(linha 442); o `FChannel` fica intacto.

Consequência: **se apenas o serviço reinicia, o canal DVC entre o `autcom.exe` e o plugin continua
de pé.** O `fReconectaCanal` do AUTCOM não dispara, **nenhum `reata` é enviado**, e a troca de
instância nunca é comparada. O gatilho que a RF29 escolheu (a resposta do `reata`) só existe quando
o **canal** cai — isto é, numa oscilação de TS.

**O que o operador vê hoje nesse caso, e não é silencioso:** a instância nova do serviço tem
`FstrConfigAplicada = ''`, então a primeira chamada do AUTCOM cai no ramo de
`pGarantePinpadConfigurado` que **levanta erro com mensagem acionável** — *"Saia e entre novamente na
rotina de TEF do AUTCOM para refazer o login, e repita a operacao"*. O comentário daquele ramo já
antecipava exatamente isto: *"Enquanto a Fase 5 nao entrega o 'reata' (RF26/RF29), que avisa o
autcom para refazer o TEF por conta propria, e o operador que refaz"*.

Ou seja: a RF29 automatizaria justamente essa mensagem, mas o gatilho dela não alcança o cenário
que a motivou. **O re-login automático só acontece se houver uma oscilação de TS DEPOIS do reinício
do serviço.**

- [ ] **Decisão pendente do Rafael.** Duas saídas possíveis, nenhuma implementada:
      1. **O AUTCOM refaz o login quando a estação disser que não o conhece** — mover o gatilho da
         resposta do `reata` para o caminho da chamada normal. É a intenção da RF29 aplicada onde o
         cenário realmente passa, e não depende do canal cair
      2. **O plugin fechar o canal DVC ao reconectar o socket** — forçaria o `reata`. Mais simples,
         mas transforma um reinício de serviço em uma queda de canal para o AUTCOM, com os 47–53 s
         de reatamento medidos em 10:45 como custo

      Enquanto isso não é decidido, o desfecho é o de hoje: mensagem acionável e o operador refaz o
      TEF. **Não é regressão** — é o comportamento que já existia antes do Passo 7.


#### VALIDADO EM CAMPO — 2026-09-10, 14:53-15:00 (RF29 completa: descarte da fila + re-login)

Bateria pelo roteiro combinado. **Os dois casos que faltavam passaram**, e o log trouxe um número
que reclassifica um resíduo.

##### Caso 4 — descarte da fila na subida: VALIDADO

```
14:57:54.549  pEnviaOuEnfileira: envio falhou - envelope id=6 ... persistido na fila local
14:57:56.540  ServiceStop chamado.
14:57:59.185  pVarreFilaNaSubida: 1 item(ns) na fila local na SUBIDA do servico -
              1 descartado(s) (RF29) ... (a desta subida e "{73D056F4-...}")
```

O `fDescartaTudo` rodou de verdade, achou 1 e descartou 1. **É o caminho que faltava** — em
10:26:20 só a fila vazia tinha sido exercitada.

**Os dois destinos da fila saíram na mesma bateria, em sequência:** o item da **1ª** queda
(id=3) foi **entregue** na reconexão (`pReenviaFilaLocal: 1 entregue(s)`, 14:57:03) e o
AUTCOM o descartou como resposta atrasada (`id=3 NAO ENCONTRADO em FdictChamadas`); o item da **2ª**
queda (id=6) foi **descartado na subida**, porque o serviço reiniciou antes de a sessão TS voltar.

##### Caso 5 — re-login por troca de instância: VALIDADO

| Hora | O quê |
|---|---|
| 14:58:37.296 | estação: `reatou SEM sessao ... conhecida="{1BD16EEF...}", atual="{73D056F4...}" - SERVICO REINICIOU` |
| 14:58:47.021 | AUTCOM: `instancia do servico "{73D056F4...}" - MUDOU, o servico da estacao reiniciou` |
| 14:58:50.546 | `pRefazTefSeServicoReiniciou: ... refazendo o login do TEF antes de "pRetornaLog", com os argumentos do login original (terminal="003")` |
| 14:58:59.782 | estação: `fConfiguraTefCitel retornou 0` (9 s no nativo) |
| 14:58:59.831 | `re-login concluido, retorno 0` + aviso status 500 ao operador, `para 1 observer(es)` |
| 14:59:44 | `Controle 09005273015` |
| 14:59:52.692 | `fFinalizarTransacao` com sucesso |

**Os argumentos guardados funcionaram** — era a aposta que evitou um segundo export novo na DLL. E
o **one-shot** funcionou: houve dois `pRetornaLog` seguidos (id=8 e id=9) e o re-login aconteceu
**uma vez só**, porque o `InterlockedExchange` consome a marca.

Duas observações, nenhuma defeito:

1. **O gatilho é "primeira chamada", não "primeira chamada de pinpad".** Aqui caiu num
   `pRetornaLog`, que é inofensivo. Refazer o login o mais cedo possível é o desejável; só vale
   saber que o aviso ao operador pode aparecer num momento que não é o início de uma venda.
2. **9 s no `fConfiguraTefCitel` nativo** durante o re-login. É o custo normal do login (o de
   14:53:21 levou 4,5 s; o de 14:58:50, 9 s), não algo introduzido aqui.

##### O número que reclassifica um resíduo: a margem do ACK está em 1,03×

O atraso da resposta do `reata` até ser lida pelo AUTCOM, medido nas **três** reconexões desta
bateria — e nas três foram **4 das 5** retransmissões, não 3:

| Escrita | Leitura | Atraso | Margem |
|---|---|---|---|
| 14:55:30.372 | 14:55:39.337 | 9,0 s | 1,12× |
| 14:56:54.185 | 14:57:03.320 | 9,1 s | 1,09× |
| 14:58:37.296 | 14:58:47.020 | **9,7 s** | **1,03×** |

O orçamento é 5 × 2 s ≈ 10 s. **Uma retransmissão a mais e o `pEnviaFrame` esgota as tentativas.**

- [ ] **RECLASSIFICADO de observação para RISCO.** Não é mais "a mitigação cobre com folga": ela
      cobriu por 300 ms na pior das três. O desfecho de esgotar não é queda (desde 31/08 esgotar
      ACK loga alto e segue como melhor esforço, não levanta exceção) e o quadro **chega** de
      qualquer forma — mas o log passaria a acusar entrega não confirmada em toda reconexão, e a
      folga real desapareceu. **Endereçar no Passo 8**, com a causa ainda não explicada em mãos

**E é a terceira vez que eu declaro essa margem com amostra insuficiente:** 2× (1 amostra, 09/09),
1,5× (2 amostras, 10/09 manhã), **1,03× (3 amostras, 10/09 tarde)**. Cada medição nova foi pior que
a anterior. O erro não é o número — é derivar margem de poucas amostras e chamar de "medido".

##### O acúmulo de sessões, agora com número: 11

`Instancia ITefCitel real criada para o pid=68800 (11 sessao(oes) ativa(s))` às 14:53:21, e
`11 sessao(oes) no dicionario` em todas as desconexões seguintes. **Onze** sessões vivas, de AUTCOM
que fecharam ao longo do dia, cada uma com uma `ITefCitel` e a instância nativa dentro.

Depois do reinício do serviço, volta a `1 sessao(oes)`. **Ou seja: hoje o que limpa isso é reiniciar
o serviço.** Continua sem risco de correção (o `fGaranteSessao` valida o par (pid, inicioProcesso)),
mas o número deixou de ser hipotético — sobe uma casa por AUTCOM fechado e só cai no reinício ou na
reciclagem de PID. **Decisão para o Passo 8**, agora com dado.



---

## Registros migrados do `tasks.md` em 2026-09-12

O `tasks.md` tinha chegado a 139 KB carregando o histórico das baterias dentro do bloco
`PONTO DE PARADA`. Pelo CLAUDE.md isso é narrativa e o lugar dela é aqui — o `tasks.md` é
checklist. O bloco abaixo é o que estava lá, na íntegra, incluindo o `PONTO DE PARADA` de
11/09 e o registro da bateria de 11/09 15:10–15:42. Nada foi resumido nem editado.

## PONTO DE PARADA — 2026-09-11, fim da tarde (bateria `Nivel=2` analisada)

**Fase 5 com os Passos 0 a 8 IMPLEMENTADOS.** Passos 0 a 6 encerrados e validados em campo;
Passo 7 com 5 dos 7 casos; **Passo 8 com cinco consertos VALIDADOS em campo em 11/09** — época
nova no dedup, A (chamadas em voo), B (recusa incondicional), F (parada ordenada) e E2 (aviso
guardado) — **mais o conserto do `TEvent` de ACK**, feito em 11/09 à tarde e já rodado na
bateria das 15:10. Nada commitado.

**A bateria `Nivel=2` foi rodada e ANALISADA** (11/09 15:10–15:42). Resultado completo na
seção "SEXTA BATERIA" abaixo e em três seções novas da `IA\rules\tef-dvc.md`.

### PRÓXIMA SESSÃO — começar aqui

Os quatro itens que a sessão anterior deixou para a análise estão **respondidos**:

- **Item 1 (latência):** respondido e **fora do nosso código**. São ~9–11 s de retenção do
  canal DVC, provados pelo cruzamento com o log do plugin (ele escreve, o autcom só recebe
  9,5 s depois, com **zero** escritas nossas no intervalo). Detalhe e tabela na `rules`.
- **Item 2 (correlação 003 × 004):** **derrubada**. O eixo não é o terminal — na bateria de
  11/09 o pid 186332 (terminal 004) foi rápido nas 8 vezes e o pid 83708 (terminal 003) foi
  lento em 5, mas o pid 156012 (terminal 003) teve tanto 641 ms quanto 34.563 ms. O que
  separa rápido de lento ainda não foi isolado.
- **Item 3 (AV):** **não reproduziu** em 32 minutos, 10 reconexões, 3 processos autcom, em
  `Nivel=2`. Ausência de reprodução, não prova.
- **Item 4 (volume):** segue como estava; não foi mexido.

**O que fazer agora, em ordem:**

1. **Build pela IDE e commit.** O conserto do `TEvent` está compilando limpo por `msbuild`
   (176.540 linhas, exit 0), mas o binário de referência aqui é o da IDE — ver a seção
   "IDE e `msbuild` não produzem o mesmo binário aqui" na `rules`. **Só a
   `libTefCitel.dll` muda**; plugin e serviço não precisam de redeploy.
2. ~~**Instrumentar as três medidas que faltam**~~ — **FEITO em 2026-09-12.** As três
   entraram e compilam limpo (`libTefCitel.dll` 176.614 linhas e
   `TefCitelDvcPlugin.dll` 1.116 linhas, os dois exit 0). **A próxima bateria precisa de
   redeploy dos DOIS binários**; o `TefEstacaoService.exe` não foi tocado. O que procurar
   no log está na seção "A retenção só acontece no primeiro diálogo de um canal
   recém-aberto" da `rules`. Era, originalmente:
   a. tick count entre o `.Start` em `pOnConectado` e a primeira instrução do corpo da
      thread anônima, reportado na linha do `pEnviaReata` — separa "a thread não rodou"
      de "`pEnviaReata` travou";
   b. tick count em volta do `CreateFile`/`WriteFile`/`CloseHandle` de
      `pLogaDiagnosticoDvcNivel`, emitido na linha seguinte — o custo do próprio log já
      está provado passar de 14 s com três `autcom.exe` no mesmo arquivo;
   c. no **plugin**, marca de tempo na entrada e no retorno do `WTSVirtualChannelWrite`,
      para separar "o plugin demorou a escrever" de "o canal segurou depois de escrito".
      O log atual do plugin registra o repasse, não o retorno da API.

   **Cuidado ao ler qualquer log deste subsistema daqui em diante:** o carimbo de hora é
   tirado dentro do `FcsLog`, depois da gravação da linha anterior — ele mede aquisição de
   lock, não instante do evento. Diferença entre carimbos **não** é duração.
3. **Bateria dirigida do 64004.** Cancelamento que conclui → segunda operação **sem**
   `fFinalizarTransacao` no meio. Ver a seção do 64004 na `rules` para o que logar.
4. **FastMM4 em FullDebugMode** no `autcom.exe` + DLL — segue aberto, e agora com um alvo
   mais estreito: o AV de 11/09 10:54 foi corrupção de **pilha**, não de heap.

### SEXTA BATERIA DO PASSO 8 — 2026-09-11, 15:10–15:42 (`Nivel=2`, 10 reconexões; nenhum AV)

**A mais dura até aqui:** 32 minutos, 3 processos autcom (156012, 186332, 83708), 10 quedas
e reconexões de canal, 4 reinícios do `TefEstacaoService`, `Nivel=2` ligado o tempo todo.
A `libTefCitel.dll` usada é de 15:08 — já com o conserto do `TEvent`.

- [x] **Nenhum AV.** Nem o de pilha (`@DynArrayClear`, 10:54) nem os de heap. Thread de
      leitura viva nos três processos até o fim
- [x] **Transporte sem falha própria** — reconexão, dedup, época nova, fragmentação,
      `reata`, fila local, disputa de pinpad e parada ordenada, todos corretos nos 10 ciclos
- [x] **Item 1 respondido: retenção do canal DVC de ~9–11 s**, com 1 caso de 34,5 s. Provado
      fora do nosso código pelo cruzamento com o plugin. Seção nova na `rules`
- [x] **A dúvida da "duplicação de chunk físico" está ENCERRADA** — o canal **não** duplica.
      As cópias são retransmissões legítimas da estação; o hex dump que o Rafael mandou
      incluir provou byte a byte (mesmo `messageId`, mesmo CRC). Era retenção
- [x] **ACK engolido pelo canal: 8 ocorrências, 2 s cada.** Assinatura
      `mensagem anterior abandonada (totalLength=N, so chegou 21 bytes)` — 21 = tamanho de um
      frame ACK. Uma delas atrasou um `fPassarCartao` em 2 s
- [x] **Conserto do `TEvent` de ACK aplicado** em `untTefCitelDvcTransporte.pas`: dicionário
      deixa de ser dono, `try` único cobrindo a vida do evento, remoção por identidade,
      `pZeraEstadoDoCanal` esvaziando o registro. **Lado estação não tem o defeito** — o
      reset do contador lá só existe no construtor
- [ ] **64004 em `AbreSessaoTEF` — variante NOVA, sem causa provada.** Três falhas seguidas
      (`fCancelaTransacaoTerminal` id=76 e id=79, `fPassarCartao` id=82), todas depois de um
      cancelamento que concluiu sem `fFinalizarTransacao` no meio, e todas nas chamadas em
      que `pGarantePinpadConfigurado` tomou a saída antecipada. Pista: `FintSinc` é global de
      unidade em `untScopeNCR.pas`
- [ ] **Gatilho da retenção do canal** não isolado — instrumentação aplicada em 12/09,
      falta a bateria
- [x] **Serviço da estação parado não trava mais o autcom (12/09)** — a espera de
      `fChamaRpcUmaVez` ganha teto de 30 s **só quando o serviço não confirmou a entrega**
      (o ACK vem do serviço; o plugin é relay burro). Entrega confirmada segue com espera
      **infinita** — a regra do pinpad não foi tocada e não deve ser. Na carga, reaproveita o
      bloco de degradação que já existia em `untTefCitelUtil.pas` (`VS_strUsaTef := 'N'`):
      avisa e abre sem TEF. **Compilado pela IDE em 12/09** (service, DLL e
      `autcom.exe`, os três OK). Nota de ambiente que continua valendo: o `autcom.exe` **não**
      builda por `msbuild` aqui (`error E2202: Required package 'faturamento.impostos.interfaces'
      not found`, falha anterior a qualquer unit), então alteração em
      `padra_atualizado\fontes\` só é verificável pela IDE. Seção nova na `rules`
- [x] **QR-Code Pix pelo canal (12/09)** — o proxy mandava o CAMINHO do PNG, que só existe no
      disco do servidor; passa a mandar o CONTEÚDO em base64, e a estação grava um temporário
      dela antes de chamar a nativa. Fecha também um vazamento: o `%TEMP%` do servidor
      acumulava um PNG por Pix, porque quem apagava era a estação, que nunca viu o arquivo.
      Compila limpo nos dois lados. Seção nova na `rules`
- [x] **A via `IPinPadCitel` do Pix SAIU do escopo (decisão do Rafael, 12/09)** — vai para
      requisito próprio. `PinPad.Classes.Scope` e `.Gertec` não têm nenhuma referência em
      `libTefCitel\`; num terminal Gertec o QR não chega ao pinpad, e num Scope a limpeza do
      visor (`pLimpaQrCodeInterno`, via `FPinPad`) fala com um pinpad que não está naquela
      máquina. O critério de aceitação em `specs.md` foi partido em dois para refletir isso —
      o 456190 não fica mais com um critério que ele não pode fechar. O levantamento já feito
      está na seção "QR-Code Pix" da `rules`
- [x] **Observação do Rafael confirmada e quantificada** (12/09): a retenção acontece
      **6 de 6** dentro de 60 s de uma reabertura, contra 1 de 19 nas esperas longas
      legítimas de pinpad (controle). Mais estreito ainda: as 6 leituras retidas têm 146 ou
      179 bytes — o tamanho da resposta do `reata`. A retenção **nunca** pegou resposta de
      operação real, só o primeiro diálogo do canal novo. O ACK engolido é outro problema e
      é do caminho feliz (1 de 8 perto de reabertura)
- [x] **Atraso de 15–18 s no `reata`** medido e separado da retenção do canal: são dois
      atrasos independentes (há reata atrasado com resposta em 95 ms). Descartados como
      causa: `FOnConectado` lento, lock em volta da leitura, `FcsChamadas` preso por
      chamada em voo, ordem de reabertura. O atraso é **por processo** (186332 sempre 0,0 s;
      83708 sempre 15–26 s) e a causa **não está provada**
- [x] **O carimbo de hora do log é aquisição de `FcsLog`, não instante do evento** — dois
      trechos de 14,9 s e 8,3 s gastos dentro do log, provados pela contradição
      `leitura encerrada em 0 ms` com 14.930 ms de relógio de parede. Seção nova na `rules`
- [x] **Item 2 (correlação terminal 003 × 004) derrubado** — o pid 156012, terminal 003,
      teve 641 ms numa reconexão e 34.563 ms em outra

### PRIMEIRA BATERIA DO PASSO 8 — 2026-09-10, 17:04–17:17, interrompida por AV

**Resultado: o item 1 está respondido e a hipótese dele caiu; o `Nivel=2` está inseguro.** Detalhe
completo nas duas seções novas da `IA\rules\tef-dvc.md` e na retrospectiva do `record.md`.

- [x] **Item 1 respondido.** O aborto da leitura pelas nossas escritas **acontece sempre e não
      atrasa o ACK** (0–16 ms, +100 amostras). A cadeia dos 9 s estava **errada**. O conserto que
      ela pedia — thread única dona do handle — **NÃO deve ser feito**: atacaria mecanismo
      benigno. Sobrou latência de entrega (3,9–4,9 s no `reata`, com **0** escritas nossas) e o
      canal truncando mensagem WTS (21 de 60 bytes). Os dois fora do nosso código
- [x] **A margem de 1,03× não reproduziu** — 3 quedas de TS, 6 transações, **1** retransmissão, e
      o quadro foi recuperado (`quadro ATRASADO aceito`). As defesas funcionaram
- [x] **AV em 17:13:37 (pid=80288), na queda de TS**, dentro do log — `@LStrSetLength` lendo
      `C00000A8`. Heap já corrompido; o log é a vítima. **Corrige o registro do "Bug 6"**: a causa
      atribuída a `FormatDateTime` em 2026-08-28 nunca foi provada (duas mudanças na mesma
      sessão). O que discrimina é volume
- [x] **Opção (a) aplicada** (decisão do Rafael): caminho quente do log do autcom **sem
      alocação** — buffer de pilha de 4 KB, caminho do arquivo uma vez por processo. **Só a
      `libTefCitel.dll` mudou**; plugin e serviço não precisam de redeploy
- [ ] **A corrupção de heap segue sem causa** — requisito próprio, fora do Passo 8: FastMM4 em
      FullDebugMode no `autcom.exe` + DLL. Até lá, `Nivel=2` é modo de investigação com risco
      conhecido, não de operação
- [ ] **O corte de volume do item 4 ficou pela metade** — só o plugin caiu (~100 → 6). Autcom
      segue em **101 linhas/transação** e estação em **~130**: o volume está nos pares
      `pTrataEvento`/`pNotifica` de `untTefCitelDvc.pas` e nos call sites da estação, que eu
      **não reclassifiquei**. Proposta: status 20/21 e bookkeeping de RPC para nível 2 (101 → 35);
      `recebidos N bytes` / `quadro aceito` / `pEnviaEvento` de 20/21 na estação (130 → 30).
      Custo a decidir: o bug de 03/09 (evento na transação seguinte) foi diagnosticado com esses
      carimbos
- [ ] **Retomar a bateria em `Nivel=1`** pelos itens 3 (reinício só do serviço), 2 (sessões) e
      rotação — nenhum deles precisa de nível 2

### SEGUNDA BATERIA DO PASSO 8 — 2026-09-11, 07:20–07:41 (achou o defeito mais grave da fase)

**Resultado: o item 3 disparou na estação e a resposta dele foi descartada pelo dedup do autcom.**
As duas transações paradas na tela que o Rafael relatou são esse defeito. Mecanismo, conserto e a
lição de log na seção nova da `IA\rules\tef-dvc.md`; leitura completa no `record.md`.

- [x] **Defeito achado e corrigido: escopo do `messageId` diferente nos dois lados.** Estação zera
      **por conexão TCP**, autcom zera **por canal DVC** — e o canal sobrevive a N conexões (o
      plugin reconecta o socket sem tocar no canal). No reinício do serviço a estação volta
      numerando de 1 e o autcom descartava as primeiras respostas como duplicata, **reenviando
      ACK** — perda silenciosa, chamada síncrona presa para sempre (sem timeout, por regra da
      unit). Janela = maior id aceito antes: **2** num autcom, **14** no outro
- [x] **Conserto C aplicado** (`fAceitaMessageId`, `untTefCitelDvcTransporte.pas`): `FdictIdsAceitos`
      passou a guardar o `GetTickCount` do aceite; repetido dentro de `TEF_DVC_DEDUP_EPOCA_MS`
      (30 s, derivado do orçamento do ACK) é duplicata e descarta; acima é época nova → esvazia o
      dedup, zera a marca d'água e **aceita**. **Só a `libTefCitel.dll` mudou** — compilada limpa
      em 11/09 08:08
- [x] **A linha do descarte agora diz a idade do aceite.** Os nove descartes benignos da bateria e
      os dois fatais saíam com texto **idêntico** — só a hora da chamada os separava
- [x] **Validado nesta bateria:** 5 quedas de TS com dois autcom (reata nas duas, 18–28 s), RF21
      filtrando por PID, RF17/RF19/RN15 no caminho contestável, `pNotificaCanalCaiu` liberando a
      LCKATC, aborto em voo, e uma venda limpa depois (crédito parcelado, 2202 bytes em 2
      fragmentos)
- [x] **Número novo:** retransmissão de ACK **zero** no sentido autcom → estação em todo o log. As
      que houve (até **4/5**, a mais apertada já medida) são todas estação → autcom — a margem de
      risco é **unidirecional**
- [ ] **O item 3 CONTINUA sem validação.** O conserto desobstrui o teste, não o substitui: a cadeia
      `ETefCitelDvcLoginNecessario` → `fChamaRpc` → `pRefazTefSeServicoReiniciou` nunca rodou.
      **Refazer o mesmo caso é o próximo teste**
- [ ] **O AV não voltou, mas em `Nivel=1`** — volume muito menor. Não é teste da opção (a)
- [ ] **Item 2 e rotação continuam sem exercício** — terminou com 3 sessões no dicionário (o prazo
      de 30 min não venceu) e o arquivo não chegou a 10 MB

### TERCEIRA BATERIA DO PASSO 8 — 2026-09-11, 08:18–08:29 (item 3 rodou inteiro; dois defeitos novos, corrigidos)

**Resultado: a RF29 pedia um desfecho e um reinício puro precisa de TRÊS.** Tabela dos três e o
raciocínio na seção nova da `IA\rules\tef-dvc.md`; leitura completa no `record.md`.

- [x] **Conserto de época VALIDADO em campo, nos dois sentidos.** Disparou duas vezes
      (`messageId=2 repetido 67078 ms` e `83344 ms`, as duas com `quadro ACEITO`) e classificou
      certo os quatro descartes benignos (`id ja aceito ha 0 ms, dentro do orcamento`), todos
      casando com `tentativa N/5` da estação no mesmo segundo. **Zero falso positivo**
- [x] **Item 3 rodou ponta a ponta, os três carimbos na ordem:** `loginNecessario` →
      `pRefazTefSeServicoReiniciou` → `re-login concluido, retorno 0` → `pSair` repetido com
      sucesso (pid=88584, 08:25:39–08:25:52)
- [x] **Defeito A corrigido — a tela que não fechava.** `fPassarCartao` id=6 estava DENTRO da DLL
      nativa quando o serviço parou; o canal não caiu, então `pOnDesconectado` (único lugar que
      resolvia pendentes) não rodou e a chamada ficou pendente **para sempre**. Os oito `pSair`
      (id=10 a 17) são o operador tentando fechar, cada um aninhado na chamada presa. Conserto:
      `fMataChamadasPendentes` (corpo extraído do `pOnDesconectado`) chamado em
      `pRefazTefSeServicoReiniciou` **antes** do re-login → negativa 500 + `Depois*` +
      **LCKATC liberada**, pelo caminho já validado
- [x] **Defeito B corrigido — o 64004 no outro autcom.** A recusa por falta de login era
      condicional a `FstrConfigAplicada = ''`: o 1º autcom era recusado e ao refazer o login
      **preenchia** a variável; o 2º emprestava a configuração dele e ia com o terminal errado.
      Agora é incondicional. **Verificado que não atinge o login adiado (RF17 item 4)**:
      `FblnCfgRecebida` é marcado no topo de `fMetodoFConfiguraTefCitel`, antes de adiar
- [x] **Item C recusado por decisão**, registrado como resíduo: `pRefazTefSeServicoReiniciou` loga
      a instância **velha** (`{BA2FD1F9}` em vez de `{76D1B195}`) porque o GUID só chega pela
      resposta do `reata`, que não sai no reinício puro. Inofensivo hoje; a linha mente
- [x] **ACK da estação em 4/5 de novo** (con=6), segunda bateria seguida, e **zero** no sentido
      autcom → estação. Margem unidirecional, confirmada duas vezes
- [ ] **REFAZER o caso do item 3 com os dois consertos** — é o próximo teste, roteiro no caso 4
      abaixo (agora com cinco carimbos)
- [ ] **Item 2, rotação e a opção (a) do log (AV) continuam sem exercício real**

### QUARTA BATERIA DO PASSO 8 — 2026-09-11, 09:12–09:32 (consertos A e B validados; 3º AV achado e corrigido)

**Resultado: os três desfechos do reinício agora funcionam.** Cinco reinícios do serviço, cinco
quedas de TS, dois autcom. Detalhe no `record.md`; a regra do AV na `IA\rules\tef-dvc.md`.

- [x] **Época nova VALIDADA** — 4 disparos, todos `quadro ACEITO`; **6** duplicatas benignas
      classificadas certo. Três baterias, **zero falso positivo** nos dois sentidos
- [x] **Conserto A VALIDADO** — `1 chamada(s) estavam em voo…` duas vezes, `pNotificaCanalCaiu` +
      LCKATC liberada, **um `pSair` em vez de oito**, tela fechou, venda seguinte completa
- [x] **Conserto B VALIDADO** — **zero `64004`** no log inteiro e `loginNecessario` para os **dois**
      pid, não só para o primeiro a chamar
- [x] **Predição do comentário do A conferida**: no caminho do `reata` a linha de órfãs **não sai**
      (o `pOnDesconectado` já limpou)
- [x] **Conserto F aplicado — 3º AV da migração, mesmo `UnLoadDLLFunctions`, gatilho novo.**
      `ServiceStop` descarregava a DLL com a thread de despacho dentro dela (09:21:41.468, AV em
      `00000000`). `pParaComSeguranca` aborta a transação em voo, espera `FdictConexaoPorThread.Count`
      zerar (teto 10 s) e roda **antes do `FTransporte.Free`** — com o transporte de pé a resposta
      ainda chega ao autcom. **É corrida:** na outra parada com chamada em voo (09:25:44) não houve AV
- [x] **Controle 09102834016 conferido pelo Rafael: ficou pendente** — diagnóstico confirmado, e ele
      classificou o desfecho como **correto** (serviço reiniciou, alguém efetiva depois). O defeito é
      só de **informação**: o protocolo disse "confirmei" (31 ms, contra 1654/1628 ms das reais) e o
      aviso saiu `para 0 observer(es)`
- [x] **Custo do E medido:** `fFinalizarTransacao` é **procedure** sem retorno
      (`untInterfaceTefCitel.pas:317`) e os dois call sites são linha nua sem `try/except`
      (`untTefCitelUtil.pas:1632` e `:1680`). **Recusar exigiria `fontes\` + `autcom.exe` na IDE, e
      abortaria o fecho de uma venda que hoje termina certo.** Proposta reduzida a duas partes, as
      duas sem tocar no `autcom.exe` — ver abaixo
- [ ] **E1 (estação) — NÃO feito, por decisão:** registrar em log que a confirmação chegou sem
      pendência nesta instância. Só ajuda quem lê log depois do fato; fica disponível se algum dia
      a produção precisar
- [x] **E2 APLICADO** (`untTefCitelDvc.pas`, só a DLL): `pAvisaOperadorOuGuarda` entrega se houver
      tela e **guarda** se não houver; `pDespachaAvisoGuardado` no fim do `AdicionaObserver`
      despacha via `TThread.Queue`. Se a tela sair antes da fila, guarda de novo. **Não** foi
      unificado com o `pNotificaNegativa`: negativa de chamada em curso não pode ser adiada — seria
      o bug de 03/09 (mensagem na transação seguinte) de volta
- [ ] **RISCO ESCALOU: o orçamento do ACK ESTOUROU, duas vezes** (`5/5` +
      `seguindo sem confirmacao`), com 16–17 s de latência. **CORREÇÃO da leitura de 09:12:** eu
      registrei como "assimetria por processo" (5 de 5 num pid contra 0 de 5 no outro) — e na
      bateria das 10:15 um **terceiro** processo (pid=169460) atrasou 16,9 s. Não é identidade de
      processo. O que sobra: **as 6 observações lentas são todas do terminal "003" e as 5 rápidas
      todas do "004"** — e não pode ser a config do terminal, porque o `reata` sai ANTES de
      qualquer interação com a estação. Correlação anotada, mecanismo em aberto. **Pede bateria
      `Nivel=2`**, não conserto por hipótese
- [ ] **Resíduo C confirmado 2×** (GUID velho no caminho do reinício puro; no `reata` sai certo)
- [ ] **Item 2, rotação e a opção (a) do log continuam sem exercício** — cada `ServiceStop` zera as
      sessões, então o prazo de 30 min nunca chegou perto

### QUINTA BATERIA DO PASSO 8 — 2026-09-11, 10:15–10:27 (F e E2 VALIDADOS em campo)

**Resultado: os dois ramos de cada conserto foram exercitados na mesma bateria.** Leitura completa
no `record.md`.

- [x] **F VALIDADO, ramo sem chamada em voo** (10:20:25): `nenhum despacho em voo depois de **0 ms**`
      — custo zero quando não há o que esperar
- [x] **F VALIDADO, ramo com chamada em voo** (10:26:12): `ABORTANDO pelo pSair antes do teardown` →
      eventos do pinpad seguiram → `fPassarCartao (id=3) retornou com sucesso` →
      `nenhum despacho em voo depois de **2782 ms**` → `ServiceStop concluido`. **Zero Access
      violation**, e o autcom **recebeu a resposta** (`pTrataResposta: recebido id=3`) — o ganho de
      esperar antes do `FTransporte.Free`. 2782 ms contra teto de 10 s: 3,6× de folga
- [x] **E2 VALIDADO, ramo guardado** (10:21:29 → 10:22:00, 31 s depois): `aviso GUARDADO` e depois
      `entregando aviso guardado a tela que abriu agora` + `"Aviso da operacao anterior: ..."` para
      **1** observer
- [x] **E2 VALIDADO, ramo imediato** (10:26:53): mesma mensagem **sem** prefixo, para 1 observer —
      porque havia tela aberta
- [x] **Época nova**: 2 disparos (207390 e 41062 ms). O segundo salvou a resposta de um
      `pRetornaLog` (id 4 contra maior aceito 15) que teria ficado pendurada
- [x] **Item 1, primeiro dado no sentido autcom → estação:** `tentativa 1/5; 2000 ms e **0
      escrita(s) nossa(s)**`. Não foi o nosso tráfego. Causa no log da estação: o serviço estava
      parado, o plugin segurou os quadros e a estação recebeu **1104 bytes de uma vez** na volta (o
      dedup dela aceitou 1 e descartou 2). Retransmissão funcionando através de um reinício
- [x] **Resíduo C piorou de forma útil:** `instancia atual ""` — **vazia**, não só velha, num autcom
      que nasceu depois do reinício e nunca recebeu resposta de `reata`. Continua inerte e recusado
      por decisão
- [ ] **Próxima bateria: `Nivel=2`** (combinada com o Rafael) — é o que mede a latência de 16 s e
      fecha o item 1. Conferir `leitura encerrada em N ms ... escritas NOSSAS` nas reconexões, e
      anotar o **terminal** de cada autcom, que é a correlação em aberto

### O estado dos binários

| Arquivo | mtime | Tamanho | Fonte mais novo dele |
|---|---|---|---|
| `padra_atualizado\libTefCitel.dll` | **11/09 10:11:17** | 21.987.047 | `untTefCitelDvc.pas` 10:02:28 |
| `libTefCitel\Estacao\Win32\Debug\TefEstacaoService.exe` | **11/09 10:11:02** | 2.661.888 | `untTefEstacaoRoteadorMensagens.pas` 09:54:12 |
| `...\ClientPlugin\Win32\Debug\TefCitelDvcPlugin.dll` | 10/09 16:30:02 | 1.037.312 | `untTefCitelDvcPluginImpl.pas` 10/09 15:57:31 |
| `...\ClientPlugin\Win64\Debug\TefCitelDvcPlugin.dll` | 10/09 16:39:09 | 1.717.248 | idem |
| `padra_atualizado\autcom.exe` | **11/09 08:27:49** | 445.247.640 | nada em `fontes\` mudou depois de 10/09 |

**Os dois binários de 10:11 foram gerados pela IDE, não pelo `msbuild` desta sessão** (confirmado
pelo Rafael). O `msbuild` produziu 09:54:21 e 10:02:47, com **tamanhos diferentes** — 2.663.936 e
21.540.933. Mesmos fontes (nada mudou depois de 10:02:28), toolchain diferente.

**Isto importa para a Fase 4:** os binários **validados em campo** na bateria das 10:15–10:27 são os
da IDE. Se o commit for acompanhado de binário, ou se alguém for reproduzir, o build de referência é
o da IDE — não presumir que `msbuild` e IDE produzem a mesma coisa aqui, porque não produziram.

**Sobre o `autcom.exe`, dito com precisão:** o **Passo 8 não mudou nenhum fonte** em
`padra_atualizado\fontes\` (o mais novo lá é de 10/09 08:27:41). Mas o **binário** foi regerado em
11/09 08:27:49, pegando as mudanças das fases anteriores (Passos 6/7). A frase certa é "o Passo 8
não mudou código do autcom", não "o autcom.exe não mudou".

### Backup

**`..\_backups\456190_20260911_1415\` + `.zip`** — 84 arquivos, **84/84 sha256 conferidos lendo
de dentro do zip**, `svn status` reconferido depois (o backup não alterou a working copy), e
`README.txt` com o estado do requisito e os 17 ausentes esperados.

**O script ganhou uma trava, e ela já pagou:** `untTefEstacaoLog.pas` está em estado `?` e a
regra antiga só admitia `?` dentro de `IA\` — a unit nova do log da estação **ficaria fora em
silêncio**. Agora qualquer `?` com extensão de fonte (`.pas .dpr .dproj .inc .dfm`) que não
esteja capturado **aborta** o backup. Nesta execução: 29.109 não capturados, nenhum deles fonte.


`..\..\..\_backups\456190_20260910_1522\` (+ `.zip`, 10,1 MB), 82 arquivos conferidos por
sha256. **É anterior a todo o código do Passo 8** — congela o marco do Passo 7. Fazer backup novo
antes de mexer. O script consolidado, com as três armadilhas contornadas (diff por arquivo,
`tasks.md` por nome, varredura das 22 externals), está descrito no `README.md` daquele backup.

### O que o Passo 8 entregou, e as três decisões do Rafael que o guiaram

**Item 4 — log consolidado (RF22).** Os três logs (autcom, serviço, plugin) ganharam **nível
configurável, limite de tamanho com rotação e identificação**. Configuração num
`TefCitelDvcLog.ini` ao lado de cada binário, **criado com os defaults e um comentário por
chave se não existir** (decisão do Rafael). Chaves: `Nivel` (0 desligado / 1 normal / 2
diagnóstico), `TamanhoMaxMB` (10), `Arquivos` (3, contando o atual — teto de ~30 MB por
processo), `Pasta` (vazio = padrão do processo). Lido **uma vez** por processo e mantido em
cache: mudar exige reiniciar. As linhas **por quadro** desceram para nível 2 — eram elas que
faziam as ~100 linhas por transação de cartão. O log do plugin ganhou `[pid=N canal=N]` e saiu
de `%TEMP%` para a pasta de instalação (com volta para `%TEMP%` se ela não for gravável). O do
autcom **fica em `%TEMP%`** de propósito: ali ele separa por usuário/sessão, e num servidor TS
isso é desejado — quem quiser tirar de lá usa a chave `Pasta`.

**Item 1 — margem do ACK: instrumentar antes de mexer** (decisão do Rafael). O orçamento de
retransmissão **não foi alterado**. Em vez disso o log passa a permitir cruzar, com `Nivel=2`:
duração de **cada** leitura do canal e **quantas escritas nossas** ocorreram durante ela; ms
decorridos desde a 1ª escrita do quadro em cada retransmissão; e ms totais mais escritas no
intervalo quando o ACK chega.

> **A hipótese que essa instrumentação existe para confirmar ou refutar — e ela não é nova, está
> num comentário de `pLoopLeitura` desde 2026-09-04:** leitura e escrita compartilham o estado
> overlapped do **mesmo** handle, e toda escrita aborta a leitura em curso com
> `ERROR_IO_INCOMPLETE` (996) — bateu 13 de 13 vezes naquele log. Se isso vale também durante a
> espera do ACK, **cada retransmissão de 2 em 2 s aborta a leitura que traria o próprio ACK**, e o
> quadro só é lido quando as escritas param. Isso explicaria as duas coisas medidas em
> 14:53–15:00 e não explicadas: o atraso **proporcional ao número de tentativas** e as cópias
> chegando **juntas, em 2 ms**. Se o log confirmar, o conserto não é aumentar o orçamento — é a
> thread única dona do handle que aquele mesmo comentário já propõe, e que segue como decisão
> pendente com o Rafael.

**Item 2 — acúmulo de sessões: coletar DESANEXADA por idade** (decisão do Rafael). Passado
`TEF_ESTACAO_DESANEXADA_MAX_MS` (**30 min**, escolha por ordem de grandeza — uma oscilação de TS
reata em 47–53 s, duas ordens abaixo) sem o processo voltar, `fOrfanaDesanexadasVencidas` orfana
a sessão pelo caminho normal e a RF28 a coleta no ocioso.

> **A segunda metade desta mudança precisa ser lida com atenção, e é o único ponto do Passo 8 que
> mexe em guarda validada.** A guarda do caminho ocioso do `fColetaOrfas` era
> `FdictSessoes.Count > 0`, e ela passou a contar sessões **ANEXADAS**. Sem isso o item não
> resolveria nada: **uma** desanexada no dicionário já fazia `Count > 0` e bloqueava a coleta
> inteira — era isso que mantinha as 11 sessões de pé. O argumento de que continua seguro: o
> método só destrói o que está em `FlstOrfas`, e desanexada **fresca** não está lá; sessão sem
> `FConexaoAtual` não pode estar despachando; e a guarda que protege de verdade
> (`LlstEmUso`/`LintOutrasThreads`, RN08) está intacta. **O conjunto do que pode ser destruído não
> mudou — mudou quando o caminho ocioso desiste.** É também a mesma classe de erro que este
> requisito já cometeu duas vezes (guarda que devia dizer *"outro está ocupado"* medindo outra
> coisa), então **este é o ponto para desconfiar primeiro** se algo regredir no Passo 8.

**Item 3 — lacuna da RF29: gatilho na chamada normal** (decisão do Rafael). A estação passa a
marcar a recusa por falta de login com `motivo="loginNecessario"` (mesmo mecanismo do
`pinpadContestavel`, via classe `ETefEstacaoLoginNecessario`), e o `fChamaRpc` do autcom refaz o
login e **repete a chamada uma vez**. Reusa o `pRefazTefSeServicoReiniciou` que já existe,
ligando a mesma flag que a resposta do `reata` liga — **dois detectores para o mesmo desfecho,
não duas implementações**, e todas as guardas daquele método valem de graça. Se a repetição
voltar igual, a exceção sobe com a mensagem acionável de sempre e o operador refaz — o
comportamento de antes. Serviço antigo contra DLL nova, e vice-versa, continuam funcionando: o
campo `motivo` só vai quando existe.

**Item 5 — higiene.** O `tasks.md` saiu de **360 KB para 104 KB**: 59 seções narrativas datadas
foram para o `record.md` **verbatim** (nada resumido, nada apagado; ponteiro com todos os títulos
no fim deste arquivo). Os títulos repetidos ganharam a fase: *Passo 7 da Fase 3.5* /
*Passo 7 da Fase 5*, idem Passo 8. O comentário do veredito de disputa deixou de prometer *"uso
único"* e diz *"limpo no fim da chamada externa"*, com o porquê de ser inerte.

**Não cheguei aos ~10 KB que o `CLAUDE.md` orienta, e não vou fingir que cheguei.** O que restou
são os checklists de seis fases mais as seções de desenho dos Passos 6 e 7 — descer de 104 KB
exigiria mexer no checklist, que é justamente o que este arquivo é.

### O que o Passo 8 NÃO fez

- **Nenhuma validação em campo.** Roteiro no `specs.md` §10.9 e no fim deste arquivo.
- **Não mexeu no orçamento de retransmissão** (decisão do item 1). A margem segue em
  **1,03× observado, amostra de três reconexões** — e desta vez a spec diz exatamente isso, em
  vez de afirmar uma margem. Foi declarada errada três vezes neste requisito (2× → 1,5× →
  1,03×); não repetir o método.
- **RN13 continua não implementada**, pendente de rediscussão: pela letra colide com o caso da
  oscilação, onde confirmar a própria pendência é o desfecho exigido.
- **Os dois casos de baixo risco do Passo 7** seguem abertos: coleta **no login** com órfã
  pré-existente (exige órfã já na lista e login **não** adiado) e `CFG_TEFDVC = N`.
- **Os três casos da pergunta ao operador** (2, 3 e 5 do Passo 6) seguem com **zero execuções**,
  por decisão de 10/09 — exigem AUTCOM travado de verdade. A validação vem do log de produção,
  e o log daquele caminho foi reforçado para isso.

### O que validar primeiro no Passo 8, em ordem

1. **Regressão simples**, antes de qualquer coisa: uma venda com cartão de ponta a ponta com o
   `.ini` **inexistente** (para ver o arquivo ser criado com os defaults) e depois com
   `Nivel=1`. O log em uso normal tem que ficar **igual ao de antes**, sem as linhas por quadro.
2. **`Nivel=2` numa reconexão de TS** — é o teste do item 1. Procurar no log do autcom:
   `leitura encerrada em N ms ... escritas NOSSAS no canal durante esta leitura: N`. Se as
   leituras curtas coincidirem com escritas nossas, a hipótese está confirmada.
3. **Rotação**: baixar `TamanhoMaxMB` para 1, gerar movimento, conferir `.1.log`/`.2.log` e o
   descarte do mais antigo. Conferir também com **dois autcom** na mesma sessão TS (os dois
   gravam no mesmo arquivo; a rotação é best effort e não pode perder linha).
4. **Item 3 — REFAZER (tentativas 1 e 2 travaram por outros defeitos, corrigidos em 11/09)**:
   com **dois autcom abertos** e uma **transação em voo**, reiniciar **só o serviço**
   (`services.msc`), sem oscilar TS. Depois passar um cartão em **cada** autcom. Antes: erro
   pedindo para sair e entrar na rotina. Agora: a tela em voo recebe negativa e **fecha**, o
   re-login é automático nos dois e as duas vendas seguem. Conferir os **cinco** carimbos —
   eles estão em cadeia, e sem o anterior o seguinte não acontece:
   1. autcom: `messageId=N repetido … o outro lado zerou o contador … quadro ACEITO`. Se
      vier `quadro duplicado descartado`, a resposta morreu de novo e o resto não vale;
   2. autcom: `N chamada(s) estavam em voo quando o servico da estacao reiniciou` — e a tela
      da transação em voo tem que **fechar**, sem `pSair` repetido e **sem a LCKATC presa**;
   3. estação: `motivo="loginNecessario"` para **os dois** pid, não só o primeiro a chamar;
   4. autcom: `pRefazTefSeServicoReiniciou` + `re-login concluido, retorno 0` nos dois;
   5. **nenhum** `status="64004"` e **nenhum** `seguindo com a configuracao atual da DLL` no
      log da estação — esse ramo deixou de existir.
   Conferir também, no fim, se a contagem de `sessao(oes) ativa(s)` não ficou presa.
5. **E2 — aviso guardado**: com **um** autcom, iniciar e concluir uma venda, deixar a tela do TEF
   fechar, e **só então** reiniciar o serviço. Na volta, a primeira tela de TEF que o operador
   abrir tem que mostrar a mensagem começando com **"Aviso da operacao anterior:"**. No log do
   autcom, em ordem: `aviso GUARDADO para a proxima que registrar observer` e depois
   `entregando aviso guardado a tela que abriu agora`. Se aparecer `para 0 observer(es)` e nenhuma
   das duas linhas, o E2 não pegou.
6. **F — parada ordenada**: com uma transação **em voo**, parar o serviço (`net stop`). No log da
   estação: `pParaComSeguranca: o servico esta parando com a chamada id=N ... ABORTANDO pelo pSair`
   e depois `nenhum despacho em voo depois de N ms - seguro descarregar a DLL nativa`. **Não** pode
   aparecer `Access violation at address 00000000`. Se sair a linha `ATENCAO - N despacho(s) ainda
   dentro da DLL`, o teto de 10 s foi curto — registrar o número.
7. **Item 2**: abrir e fechar o autcom várias vezes e conferir que a contagem de
   `sessao(oes) ativa(s)` **para de crescer** — e que uma oscilação de TS continua reatando sem
   login (o prazo de 30 min não pode atrapalhar o caso que a RF24 existe para resolver).

### Achados novos para a Fase 4 (não estavam na lista)

1. **`libTefCitel\Estacao\TefEstacaoService.dpr` tem `Application.CreateForm(` na linha 31 e está
   com status `A`** — ou seja, vai ser varrido pelo pre-commit, que barra esse padrão. **Não dá
   para trocar por `pCriarForm`**: aqui é o `Application` do `Vcl.SvcMgr` (aplicação de serviço),
   e o `pCriarForm` vive em `untFuncoesSimples.pas`, que este projeto deliberadamente não
   referencia. **Conferir se o hook varre `.dpr`**; se varrer, precisa de exceção de quem cuida
   do hook. Descoberto ao registrar a unit nova no `.dpr`.
2. **`untTefCitelDvcPluginImpl.pas` está com LF puro**, sem nenhum CRLF, contra o
   `.editorconfig` do projeto. Preservado como estava de propósito — normalizar agora inflaria o
   diff em 600+ linhas e esconderia as mudanças reais do Passo 8. Decidir antes ou depois do
   commit, mas decidir.

### Resíduos técnicos que atravessam o requisito

- **~10 s de reconexão desperdiçados.** Em 08:38 a primeira tentativa de reabrir o canal
  aconteceu 26 s depois da queda e **10 s depois de a sessão RDP já ter voltado**. Hipótese não
  medida: a thread principal e/ou o `WTSVirtualChannelClose` bloqueando enquanto a sessão TS
  está desconectada.
- **Reatar leva 47–53 s** da queda de TS até o `reata` completo (~26–32 s para reabrir o canal,
  ~14,5 s até o `reata` sair — igual em todas as medições, suspeitosamente próximo do timeout de
  leitura de 15 s, hipótese não medida — e o atraso do ACK).
- **Incógnita do `FechaSessaoTEF`:** a reaplicação do login chama
  `FechaSessaoTEF(SCO_CONFIRMA_TEF, forçado)` e, pela teoria da própria RF17 item 4, deveria ter
  resolvido a pendência do detentor morto. **Não resolveu** — ficou pendente no relatório, que
  por acaso é o desfecho desejado. Mecanismo não compreendido; código nativo fora de alcance
  (`specs.md` §9.3).
- **Trava LCKATC** deixada pelas baterias de 10/09, a remover pelo relatório de travas.

### Fase 4 (depois de validar o Passo 8), na ordem

1. `svn revert libTefCitel\Estacao\untTefEstacaoPipeTransporte.pas` — status `!`, **bloqueia o
   commit e trunca o `svn diff`**
2. `svn add` em `IA\specs\456190\record.md`, `IA\rules\tef-dvc.md` e
   `libTefCitel\Estacao\untTefEstacaoLog.pas` (os três com status `?`)
3. Conferir o `Now()` em `libTefCitel\untScopeNCR.pas:592` — pode ser pré-existente e intocável
   (`specs.md` §9.3)
4. Os dois achados novos acima: `Application.CreateForm` no `.dpr` e o LF do plugin
5. `/review`, gate DelphAI, commit com `Req. 456190` na primeira linha + token

### Três lições que valem para quem continuar

**Mover uma chamada para um contexto novo invalida TODA premissa de quem ela chama.** O
`fColetaOrfas` tem três guardas e eu errei a mesma coisa em duas delas, com um dia de
diferença: guardas que significavam *"outro está ocupado"* estavam medindo *"eu estou ocupado"*.
No Passo 8 uma terceira guarda do mesmo método caiu pelo mesmo motivo — `FdictSessoes.Count`
deixou de significar "alguém ativo" no dia em que a RF24 passou a deixar sessão desanexada no
dicionário. **A guarda não mudou; o significado do que ela media mudou debaixo dela.**

**Quatro premissas sobre o código de terceiro caíram neste requisito**, sempre do mesmo jeito: o
que parecia óbvio na assinatura do método não era o que ele fazia lá dentro. A pergunta que se
mostrou certa: *o que este método deixa aberto quando retorna?* — não *o que ele diz que faz*.

**Comentário que promete garantia mais forte do que o código entrega é pior que comentário
nenhum.** O do veredito de disputa dizia "uso único" e o escopo real é a chamada externa;
ninguém tinha construído nada sobre a promessa, mas era questão de tempo.

---

### PRIMEIRA BATERIA DA FASE 6 — 2026-09-16, 08:15–08:44 (dois ciclos de atualização; 1 DLL travada)

Logs em `\citel-fileserve\dados\Publica_Geral\rafael.bizio\` — `TefEstacaoService.log` (2,9 MB,
31.162 linhas) e `TefCitelDvcPlugin.log` (4,0 MB, 31.130 linhas). Analisados por histograma de
formatos normalizados (12 formatos distintos no plugin, 138 no serviço) e recorte por janela de
tempo; os arquivos não foram lidos inteiros.

**Os dois ciclos completaram — o serviço voltou no ar com a versão nova nas duas vezes.**

| | Rodada 1 — 08:15:44 | Rodada 2 — 08:36:10 |
|---|---|---|
| Pacote | `scope.ini`, 437 B, 1 parte | `scope` / `tef_scope.zip`, 9.749.414 B, 39 partes (`pAtuParte`) |
| Transferência | instantânea | 08:33:36 → 08:36:10 = 154 s (~63 KB/s pelo canal DVC) |
| SHA256 conferido no `fAtuFecha` | ok (`3b13f3cd48d1…`) | ok (`0ce5411deb24…`) |
| Aplicação | 1/1 gravado | **31/32 gravados, 1 falhou** |
| Serviço de volta | 08:15:50.497 | 08:36:16.593 |

#### O defeito: `csmsg.dll` travada por refcount que sobrou do login feito durante o teardown

```
08:36:15.426  Atualizador: FALHOU em "csmsg.dll" (EInOutError: Cannot create file
              "C:\TEF_Citel\csmsg.dll". O arquivo já está sendo usado por outro processo)
```

Não é intermitência. A cadeia inteira está no log, e ela começa antes do atualizador:

```
08:36:10.834  fAtuAplica: estacao OCIOSA ... "O autcom espera o servico voltar antes de seguir para o login"
08:36:10.856  fDisparaAtualizador: TefEstacaoAtualizador.exe lancado destacado
08:36:10.870  ServiceStop chamado
08:36:10.925  Frame "chamada" recebido: metodo="fConfiguraTefCitel"     <-- 55 ms DEPOIS do ServiceStop
08:36:10.925  pid=168800: chamando fConfiguraTefCitel (DLL nativa do Scope/CliSiTef)...
08:36:15.366  pid=168800: fConfiguraTefCitel retornou 0                 <-- 4.441 ms carregando o Scope
08:36:15.396  pParaComSeguranca: nenhum despacho em voo depois de 4516 ms - seguro descarregar
08:36:15.398  ServiceStop concluido
08:36:15.407  Atualizador: servico parado
08:36:15.411  Atualizador: "CMC7.dll" gravado / "ComVerifone.dll" gravado
08:36:15.426  Atualizador: FALHOU em "csmsg.dll"                        <-- 28 ms depois do UnLoadDLLFunctions
08:36:15.432 … 08:36:15.992   as outras 29 DLLs gravaram normalmente
```

**O autcom não espera.** Ele dispara o login (`fConfiguraTefCitel`) logo depois que o `fAtuAplica`
retorna — o contrário exato do que a mensagem do próprio `fAtuAplica` afirma. Isso recarrega a
pilha nativa do Scope/CliSiTef dentro do processo que está morrendo. O `pParaComSeguranca` fez o
certo (esperou os 4,5 s do despacho em voo em vez de arrancar a DLL debaixo da thread), mas
quando o `UnLoadDLLFunctions` rodou, a `csmsg.dll` continuou mapeada.

O mesmo padrão está na rodada 1 — `fConfiguraTefCitel` do pid=135012 em voo, `pParaComSeguranca`
esperou 4766 ms. **Lá não houve conflito só porque o pacote era um `.ini`, não DLL.** Ou seja: a
rodada 1 não valida nada sobre isso; ela apenas não exercitou a gravação de DLL.

**Consequência colateral, confirmada nas duas rodadas:** o login feito durante o teardown é
descartado no restart e o operador bate em `loginNecessario` no cartão seguinte — 08:18:01
(pid=135012) e 08:37:49 (pid=168800). O trabalho de 4,5 s do `fConfiguraTefCitel` é jogado fora
todas as vezes.

#### Três defesas ausentes, na ordem em que deveriam existir

1. **Causa raiz — lado autcom.** Emite `fConfiguraTefCitel` sem aguardar o serviço voltar. É o que
   abre a janela inteira. Sem isso, nada do resto acontece.
2. **Por que dói — lado serviço.** O serviço aceita e despacha uma chamada *que carrega DLL
   nativa* depois de `ServiceStop` sinalizado. Não existe porta fechando novos despachos durante
   o teardown; o `pParaComSeguranca` só sabe esperar o que já está em voo, não recusar o que
   chega depois.
3. **Rede de segurança — lado atualizador.** Começa a gravar 9 ms depois de `servico parado`, isto
   é, confia no status do SCM. Não espera o handle do processo morrer e não tem retry em sharing
   violation.

#### O que o log NÃO prova (hipótese a confirmar no fonte)

Por que **só** a `csmsg.dll` ficou presa. As 31 irmãs — inclusive `scopeapi.dll` (9,3 MB) e
`scopelib.dll` — gravaram sem erro nos 580 ms seguintes. Isso aponta para **refcount vazado**
(`csmsg.dll` entra como dependência do Scope e o `UnLoadDLLFunctions` não a libera) e não para o
processo ainda estar saindo — se fosse saída de processo, várias teriam falhado. Confirmar lendo
`UnLoadDLLFunctions` / `pParaComSeguranca` e o laço de gravação do `TefEstacaoAtualizador`.

#### Achados fora da Fase 6, vistos na mesma sessão

- **08:44:25 — última linha do log.** `pParaComSeguranca: ATENCAO - 1 despacho ainda dentro da DLL
  nativa depois de 10047 ms (teto 10000 ms)`. O teto estourou e o teardown seguiu; a própria
  mensagem avisa que um AV pode aparecer logo abaixo. O log termina aí — **não se sabe se
  apareceu**. Primeira vez que esse teto estoura em campo.
- **08:24:45–08:24:53.** `con=4`, `messageId=2` sem ACK nas 5 tentativas (10 s), caiu para melhor
  esforço. Ocorrência única na sessão.
- **08:25:26 e 08:25:50.** Dois `Erro Desconhecido (-1)` do CliSiTef em `fPassarCartao`. Sem
  relação com a atualização.

Resto limpo: 3 sessões RDP com o plugin subindo e caindo junto, reconexões de socket tratadas
(08:15:50 e 08:36:16), 2 quadros duplicados descartados corretamente, 10.363 repasses
socket→canal DVC sem um único erro de `IWTSVirtualChannel.Write`.

### CONSERTO DA BATERIA DE 2026-09-16 — a espera que nunca via o serviço cair

Três arquivos, todos ainda `A` no SVN (a Fase 6 inteira segue sem commit). O `untTefCitelDvc.pas` chegou a ser tocado na primeira tentativa e foi revertido byte a byte — ver o item 2.

**1. `untTefCitelDvcAtualizacao.pas` — `fEsperaServicoVoltar` (a causa raiz).**
Passou a receber `AstrInstanciaAntes` e só sai quando a estação se apresentar com uma
instância DIFERENTE. Antes saía com `Exit(True)` na primeira resposta — e a primeira resposta
sempre vinha do serviço velho, porque o `fMetodoFAtuAplica` responde antes de derrubar o
serviço (`FblnReiniciarAposResposta`). O laço nunca observava a queda; só podia acertar por
acidente. A instância "antes" é colhida do `fAtuConsulta` que a rotina já fazia no começo.

**2. `untTefEstacaoRoteadorMensagens.pas` — `fMetodoFAtuConsulta` devolve `instanciaServico`.**

**Esta foi a segunda volta do conserto, e vale registrar o erro.** A primeira tentativa leu a
instância de `TTefCitelDvc.FstrInstanciaServico`, que já existia e já estava validada em campo —
parecia reaproveitamento óbvio. **Não funcionaria:** aquele campo só é atualizado pelo `reata`,
e o `reata` só é enviado quando o **canal DVC** cai. No reinício da atualização o canal NÃO cai —
quem cai é o socket plugin→serviço, que o plugin reconecta sozinho e em silêncio, sem o autcom
saber de nada. O log de 16/09 mostra isso sem margem: o serviço reiniciou às 08:36:16 e **não
houve um único `reata`**; os dois do dia (08:24:32 e 08:24:43) foram da reconexão de sessão RDP.
A espera teria queimado os 120 s do teto e devolvido "não voltou a responder" com o serviço no ar.

Por isso a identidade passou a viajar na resposta de **toda** consulta. O `FstrInstanciaServico`
e o `reata` ficaram intocados, e o `FintServicoReiniciou` também — aquele é sinal de consumo
único do `pRefazTefSeServicoReiniciou`, e quem o lesse aqui roubaria o re-login da RF29.

*Lição, e é a mesma do Passo 8 com outra roupa:* o mecanismo existia, estava validado, e mesmo
assim não servia — porque o que o validou em campo foi um gatilho (queda de canal) que este
cenário não dispara. **Reaproveitar mecanismo exige conferir o gatilho, não só o dado.**

**3. `untTefEstacaoAplicacao.pas` — o atualizador espera o PROCESSO, não o SCM.**
`fAbreProcessoServico` pega o handle `SYNCHRONIZE` **antes** do `ControlService(STOP)` — depois
de parar o SCM zera o `dwProcessId` e o número pode ser reciclado; segurar o handle enquanto o
serviço ainda vive é o que torna a espera imune a isso. `pEsperaProcessoSair` então faz
`WaitForSingleObject` com teto de 30 s (`TEF_APL_TETO_SAIR_MS`) depois do STOPPED. Estourar o
teto **não** aborta: a essa altura o serviço já parou, e não aplicar deixaria a estação sem
atualização nenhuma. Com isso o item 2 do cabeçalho da unit — *"Para o TefEstacaoService pelo
SCM e ESPERA ele parar de verdade"* — passou a ser verdade; até aqui era promessa.

**4. `untTefEstacaoAplicacao.pas` — `fGravaComRetentativa`, 5 × 300 ms.**
Cobre o que a espera do processo não cobre: algo FORA do serviço segurando o arquivo — antivírus
varrendo a pasta, Explorer aberto, outro autcom em RDP na mesma estação. A leitura do zip saiu
de dentro do `try` da gravação: falha ao ler é pacote corrompido, não arquivo travado, e
retentar não mudaria nada.

**5. `untTefEstacaoRoteadorMensagens.pas` — a mensagem que mentia.**
`"seguro descarregar a DLL nativa"` virou `"seguro chamar o UnLoadDLLFunctions. (Os arquivos da
DLL seguem mapeados até o processo sair.)"`. Ver o resíduo abaixo.

#### Verificação feita, e a que NÃO foi feita

Os três projetos compilam sem erro — `TefEstacaoAtualizador`, `TefEstacaoService` e
`libTefCitel`. Dois avisos, **ambos pré-existentes**: `W1002 DELAYED` em
`untTefEstacaoRoteadorMensagens.pas:543` e `H2077` em `untTefCitelDvcAtualizacao.pas:435`.

**Armadilha, para quem repetir a checagem:** `msbuild` **sobrescreve o binário na working copy mesmo com `/p:DCC_ExeOutput` apontando para outro lugar** — o `.dproj` ganha da linha de comando. Nesta sessão isso trocou o `Estacao\Win32\Debug\TefEstacaoService.exe` da bateria de campo por um build Berlin; foi detectado pela tabela de frescor do próprio `backup-req.ps1` (passou de DESATUALIZADO para OK sem ninguém ter compilado pela IDE) e restaurado do backup das 10:20, com hash conferido. Também viraram saída Berlin o `TefEstacaoAtualizador.exe` e vários `.dcu`/`.identcache`/`.stat` — esses são cache de IDE e o rebuild regenera, mas **conferir a tabela de binários do backup depois de qualquer msbuild** virou parte do procedimento. Nenhum `.res` nem fonte versionado foi alterado.

**Ressalva importante:** a compilação foi feita com o **Berlin (17.0)**, não com o Seattle. O
Seattle instalado nesta máquina **não tem `System.Hash`** — unit que só aparece no 10.1 Berlin e
que `untTefEstacaoAtualizacao.pas:216` já usava antes deste conserto. Isso vale como verificação
de sintaxe e de tipos, **não** como o build oficial. Nada aqui foi exercitado em estação.

#### Resíduo técnico: `UnLoadDLLFunctions` não devolve referência nenhuma

Decisão de 2026-09-16: **não mexer agora** — é o núcleo legado do TEF, no caminho de toda
transação de cartão, e o item 3 acima torna o vazamento irrelevante para o atualizador.

O que está lá, para quem for decidir depois:

```pascal
// untScopeNCR.pas:615 - FunctionDetect
if LoadLibrary(PChar(LibName)) = 0 then ... exit;
LibHandle := GetModuleHandle(PChar(LibName));   // LoadLibrary, nunca FreeLibrary

// untScopeNCR.pas:784 - UnLoadDLLFunctions
LibHandle := LoadLibrary(PChar(LibName + scope));  // +1
if LibHandle <> 0 then FreeLibrary(LibHandle);     // -1  => saldo ZERO
ScopeVersao := Nil; ...                            // anula 51 ponteiros
```

`fLoadDLLFunctions` chama `NcrFunctionDetect` 51 vezes, uma por ponteiro ainda `nil` → refcount
de `scopeapi.dll` = 51. O `UnLoadDLLFunctions` anula os ponteiros e não devolve **uma única**
referência. `scopeapi.dll` e toda a árvore de dependências dela só saem da memória na saída do
processo. Corrigir isso de verdade (guardar o handle no load e liberar no unload) deixaria o
`pParaComSeguranca` honesto, mas exige bateria de campo completa, não só teste da Fase 6.

#### Achado NOVO, de tabela: o re-login da RF29 nunca dispara na atualização

Sai da mesma descoberta do item 2 e **não foi corrigido** — é defeito próprio, não parte deste
conserto.

O `FintServicoReiniciou` só é levantado em dois lugares, e ambos dependem de o **canal DVC**
cair. No reinício provocado pela atualização o canal não cai. Logo: depois de uma atualização o
autcom **não sabe** que o serviço é outro, o `pRefazTefSeServicoReiniciou` nunca roda, e a sessão
Scope que morreu com o processo antigo não é refeita.

É exatamente o que o log mostra nas duas rodadas: o operador levou `loginNecessario` no cartão
seguinte — 08:18:01 (pid=135012) e 08:37:49 (pid=168800) — em vez de um re-login automático. A
maquinaria da RF29 existe e está certa; só nunca é acionada neste caminho.

O conserto do item 1 **reduz** o sintoma (o login desperdiçado durante o teardown deixa de
acontecer), mas não resolve este: depois da atualização o TEF daquele autcom continua precisando
ser refeito, e continua sendo o operador quem descobre isso. Com o `instanciaServico` agora na
resposta do `fAtuConsulta`, o caminho para resolver ficou curto — mas é mudança no re-login, que
mexe no fluxo de transação, e por isso não entrou junto.

#### Achado aberto: o `ATENCAO` das 08:44:25

```
pParaComSeguranca: ATENCAO - 1 despacho(s) ainda dentro da DLL nativa depois de
10047 ms (teto 10000 ms). Seguindo com o teardown...
```

Última linha do log da bateria — **não se sabe se o AV previsto apareceu**. Primeira vez que
esse teto estoura em campo. Fica mais interessante à luz do resíduo acima: o `UnLoadDLLFunctions`
anula os ponteiros debaixo de uma thread que ainda está dentro da DLL, e a DLL **continua
mapeada** — o AV seria por ponteiro nulo, não por código desmapeado. Para retomar isto é preciso
o log da estação a partir das 08:44:25, ou um bugreport.

#### O que validar na próxima bateria, em ordem

1. **A espera passou a esperar.** No log do autcom, procurar
   `"a estacao respondeu, mas a instancia continua"` pelo menos uma vez, seguido de
   `"o servico da estacao VOLTOU depois de N ms - instancia X, diferente da Y"`. Se o primeiro
   nunca aparecer, ou o `VOLTOU` sair em menos de ~4 s, a espera continua saindo cedo.
2. **Nenhum `fConfiguraTefCitel` entre `ServiceStop chamado` e `ServiceStart concluido`.** É o
   sintoma direto da causa raiz; se aparecer, o conserto 1 não pegou.
3. **`processo do servico saiu N ms depois do SCM dizer STOPPED`.** Em campo foram ~25 ms; anotar
   o número real, é a primeira medida que teremos dele.
4. **Zero `FALHOU em` no pacote `scope`.** E se houver, conferir se veio depois das 5 tentativas
   — a linha `"travado na tentativa N de 5"` diz se o retry entrou em ação.
5. **Nenhum `loginNecessario`** logo após a atualização. O login desperdiçado era consequência da
   mesma causa raiz e deve ter sumido junto.

### SEGUNDA BATERIA DA FASE 6 — 2026-09-16, 10:45–11:02 (o conserto pegou; um defeito mais fundo apareceu)

**O que foi validado, e é o que importa:** o pacote `scope` (9.743.516 bytes, 39 partes) aplicou
**32 de 32 arquivos, zero falhas**. `csmsg.dll` gravado (3.445.248 bytes). Os cinco itens da lista
de validação da seção anterior:

| # | Item | Resultado |
|---|------|-----------|
| 1 | A espera passou a esperar | **OK** — `"a estacao respondeu, mas a instancia continua {9BC276C9-…}"` às 11:00:07.801 |
| 2 | Nenhum `fConfiguraTefCitel` no teardown | **OK** — a janela ficou limpa |
| 3 | `processo do servico saiu N ms depois do STOPPED` | **OK** — `0 ms` |
| 4 | Zero `FALHOU em` no pacote | **OK** — 32/32, retry nunca precisou entrar |
| 5 | Nenhum `loginNecessario` após a atualização | **OK** |

**E mesmo assim o autcom travou**, parado em "Aguardando o servico da estacao voltar..." até o
operador fechar. A atualização já tinha terminado — a estação ficou correta, só a tela congelou.

#### O defeito: as duas pontas discordam do que é "uma conexão"

```
11:00:08.802  [autcom]   Enviando envelope "fAtuConsulta" id=4
11:00:09.307  [estacao]  Metodo "fAtuConsulta" (id=4) retornou com sucesso
11:00:09.516  [autcom]   pExtraiFramesDisponiveis: quadro duplicado descartado
                         (messageId=2, maior aceito=6, id ja aceito ha 1781 ms,
                          dentro do orcamento de 30000 ms)
11:00:24.517  [autcom]   pLoopLeitura: leitura encerrada em 15000 ms ... (e assim para sempre)
```

A resposta chegou e **foi para o lixo**. A regra do subsistema diz que `messageId` "reinicia a cada
conexão nova" — só que conexão significa coisas diferentes de cada lado: para a estação é o socket
TCP, que morre com o processo; para o autcom é o **canal DVC**, que neste reinício não cai. Quem
cai é o socket plugin→serviço, que o plugin reconecta sozinho e em silêncio.

O `fAceitaMessageId` já sabia reconhecer época nova — mas **pelo tempo**
(`TEF_DVC_DEDUP_EPOCA_MS`, 30 s). O reinício do atualizador leva ~1,5 s, indistinguível de
retransmissão. E o travamento é permanente porque o `fChamaRpc` espera com `WaitFor(INFINITE)` e
só é solto quando o **canal** cai — que é exatamente a regra do topo de `IA\rules\tef-dvc.md`, e
por isso **pôr timeout ali está fora de questão**: o mesmo caminho carrega `fPassarCartao`.

**Honestidade sobre a origem:** o defeito do dedup é anterior e estava escondido. O código velho
saía da espera antes de o reinício terminar, então nunca chegava a falar com o serviço novo. O
conserto da rodada 1 trocou uma corrupção silenciosa por um travamento visível e destapou este.

#### O conserto (opção A, decidida em 16/09) — reset determinístico do dedup

`pAgendaZeraDedupPorReinicioDaEstacao` no `TTefCitelDvcTransporte`, exposta por
`TTefCitelDvc.pPreparaReinicioDaEstacao` e chamada de `fAtualizaEstacaoTef` **antes** do
`fEsperaServicoVoltar` — no instante em que o autcom acabou de receber `aplicado=true` e portanto
*sabe*, sem heurística, que a estação vai reiniciar.

**A primeira versão estava errada e o erro vale mais que o conserto.** Ela zerava o dedup no
primeiro quadro que chegasse depois do pedido. Só que entre o pedido e o reinício ainda chegam
respostas do serviço **velho**, com o id subindo normal — o reset seria gasto ali e a marca d'água
estaria alta de novo bem a tempo de descartar o serviço novo. O pedido agora **fica de pé até o id
andar para trás** (`AdwMessageId <= FdwUltimoIdRecebido`), que é o único momento em que o contador
do outro lado só pode ter recomeçado.

*É a terceira vez neste requisito que o mesmo tipo de erro aparece:* uma guarda certa disparando
no instante errado. Passo 8 (`fColetaOrfas`), rodada 1 (o `reata` que não dispara), e agora esta.

**Risco aceito:** entre o pedido e o reinício, uma retransmissão legítima da época velha seria
aceita duas vezes. Janela de ~1,5 s, e a estação estar OCIOSA foi condição para o `fAtuAplica` ter
aceitado — não há transação em voo para duplicar.

#### Pendente: opção B — quadro de controle do plugin

A opção A **só cobre o caminho da atualização**. Qualquer reconexão do socket plugin→serviço sem
queda de canal reproduz o mesmo descarte e o mesmo travamento permanente — e o log do plugin mostra
que essas reconexões acontecem por outros motivos.

O conserto geral: o plugin é o único que enxerga o socket cair e voltar (ele já loga isso). Ganha
um **tipo de quadro novo**, na mesma forma do `TEF_DVC_FRAME_TIPO_ACK` acrescentado na Fase 2,
emitido na reconexão; o autcom zera o dedup ao recebê-lo. Determinístico e sem heurística de tempo.
**Custo:** mexe no layout/semântica do quadro, e a regra exige alterar `untTefCitelDvcTransporte.pas`
e `untTefEstacaoTcpTransporte.pas` na MESMA sessão/commit, com o `fCrc32` duplicado mantido idêntico.

#### Procedimento de build (não repetir o erro de hoje)

`msbuild` **sobrescreve o binário na working copy** — o `.dproj` traz
`<DCC_ExeOutput>.\$(Platform)\$(Config)` e ganha do `/p:` da linha de comando. Nesta sessão isso
destruiu duas vezes o `Estacao\Win32\Debug\TefEstacaoService.exe`, inclusive o build de IDE feito
para esta bateria. **Antes de qualquer msbuild: guardar o hash dos binários; depois: conferir e
restaurar.** A tabela de frescor do `backup-req.ps1` é o detector — binário que passa de
DESATUALIZADO para OK sem ninguém ter aberto a IDE é sinal de que isso aconteceu.

#### O que validar na próxima bateria

1. **`fAceitaMessageId: dedup ZERADO - messageId=N veio ABAIXO da marca d'agua M`** no log do
   autcom, uma vez, logo depois do reinício. É a prova de que a opção A atuou.
2. **A atualização conclui e a tela sai do "Aguardando o servico da estacao voltar..."** — o
   sintoma que trouxe esta rodada.
3. Nenhum `quadro duplicado descartado` no minuto seguinte ao reinício.
4. Os cinco itens da rodada 1 continuam valendo — em especial 32/32 arquivos e zero `FALHOU em`.

### TERCEIRA BATERIA DA FASE 6 — 2026-09-16, 11:32–11:48 (dois ciclos limpos; mas metade do conserto não rodou)

Dois ciclos completos, com **troca de pacote nos dois sentidos** — bom teste de ida e volta:

| | Ciclo 1 | Ciclo 2 |
|---|---|---|
| Pacote | 9.749.414 B, sha `0ce5411deb24` | 9.743.516 B, sha `9bff541eb988` |
| Janela | 11:35:56 → 11:38:10 | 11:40:46 → 11:46:34 |
| Arquivos | **68 gravados nos dois ciclos, `FALHOU` = 0** | idem |
| Serviço de volta | 11:38:10.284 | 11:46:34.720 |

**O travamento acabou** e o `fConfiguraTefCitel` agora acontece no lugar certo: 11:38:10.150,
**depois** do `ServiceStart concluido` das 11:38:09.784 — não mais dentro do teardown. Nos dois
ciclos. `ATENCAO` = 0, nenhum `quadro duplicado descartado` nas janelas de reinício.

Em 11:41:42 uma transferência foi interrompida no meio (12 partes recebidas) e recomeçou:
`"Recepcao anterior do pacote scope DESCARTADA - chegou um pAtuAbre novo"`. Tratado sem sobra.

#### O que esta bateria NÃO validou — e é metade do trabalho

**A linha `"processo do servico saiu N ms depois do SCM dizer STOPPED"` não aparece uma única vez**
neste log, contra uma ocorrência na bateria das 11:00. O conjunto de mensagens do atualizador aqui
é exatamente o antigo: `iniciado` / `servico parado` / `de volta no ar` / `concluido`.

**A estação está rodando o `TefEstacaoAtualizador.exe` ANTIGO.** O serviço é novo (a mensagem
corrigida do `pParaComSeguranca` está lá), mas o atualizador não — ele não viaja no pacote `scope`,
só no pacote do serviço. Portanto:

- **Validado nesta bateria:** o conserto 1 (a espera pela troca de instância) e o conserto da
  opção A (reset do dedup). São eles que explicam o sucesso: sem login durante o teardown, nada do
  Scope fica mapeado, e nenhum arquivo trava.
- **NÃO exercitado:** o conserto 2 (esperar o processo sair) e o 3 (retry na gravação). Continuam
  sem uma única execução em campo. São justamente a rede de segurança para o dia em que algo
  *fora* do serviço segurar um arquivo — antivírus, Explorer, outro autcom em RDP.

**Ressalva de leitura:** o `TefCitelDvcTransporte.log` (lado autcom) não veio nesta entrega, então
a linha `fAceitaMessageId: dedup ZERADO` não pôde ser conferida diretamente. A evidência do conserto
A aqui é comportamental — a tela saiu da espera e a sessão seguiu para o login.

#### Corrigido nesta sessão: um caminho mudo que custou a leitura acima

`fAbreProcessoServico` saía sem logar nada quando `dwProcessId = 0`. Com isso, olhando só o log,
não dava para distinguir "o atualizador da estação é o antigo" de "é o novo e passou por aqui em
silêncio" — foram necessárias três verificações cruzadas para desempatar. Agora **nenhum caminho
da função termina calado**: loga o `dwProcessId=0`, loga a falha do `OpenProcess`, e loga o
sucesso (`"handle do processo do servico (pid=N) em maos antes do STOP"`). Na próxima bateria a
resposta é uma linha.

*Lição, e é irmã da regra do comentário que promete demais:* função de diagnóstico com caminho
silencioso é pior que função sem log — a ausência da linha vira ambígua, e ambiguidade em log de
campo custa horas.

#### Sintoma esperado que apareceu: `loginNecessario` às 11:47:44

`fPassarCartao` do pid=175316 recusado por falta de login, ~1 min depois do reinício do ciclo 2.
É o **achado aberto da RF29** já registrado (o re-login nunca dispara depois de uma atualização,
porque depende do `reata` e o canal não cai). Comportou-se exatamente como previsto. Não é
regressão; é o defeito conhecido esperando conserto.

#### O que validar na próxima bateria

1. **`handle do processo do servico (pid=N) em maos antes do STOP`** seguido de
   **`processo do servico saiu N ms depois do SCM dizer STOPPED`** — prova de que o atualizador
   novo chegou à estação e de que o conserto 2 rodou. Se em vez disso aparecer `dwProcessId=0`,
   o conserto está lá e o problema é outro.
2. **Mandar junto o `TefCitelDvcTransporte.log`**, para conferir o `dedup ZERADO` de frente.
3. Continuar em zero: `FALHOU`, `ATENCAO`, `quadro duplicado descartado` nas janelas de reinício.

### TRAVAMENTO DE 2026-09-16, 12:13:56 — NÃO é regressão da Fase 6; o Scope nativo não voltou

Suspeita levantada na hora: regressão. **O log diz que não**, e a evidência é direta.

#### Primeiro, o conserto da opção A ficou provado de frente (faltava isso)

```
12:11:40.890  [pid=131016] pAgendaZeraDedupPorReinicioDaEstacao — armado, marca d'agua 10022
12:11:40.927  [pid=131016] "a estacao respondeu, mas a instancia continua {9109B702…}"
12:11:42.606  [pid=131016] fAceitaMessageId: dedup ZERADO - messageId=2 veio ABAIXO da marca 10022
12:11:42.606  [pid=131016] VOLTOU depois de 1719 ms - instancia {638A1AD5…}, diferente da {9109B702…}
```

Disparou **uma vez**, no instante certo, e **não** foi consumido pela resposta do serviço velho —
que era exatamente o erro da primeira versão. `quadro duplicado descartado` no lado autcom em toda
a sessão: **zero**.

#### Por que o travamento não é nosso

- O autcom que travou é o **pid=77596**, aberto às 12:13:28, **depois** da atualização. Ele nunca
  entrou no caminho de atualização: seu transporte jamais teve o flag de dedup armado, e o
  `fEsperaServicoVoltar` não rodou nele. Os dois consertos da sessão são, por construção, inertes
  nesse processo.
- **Nenhum `fPassarCartao` duplicado** — um por autcom, conferido nos dois logs.

#### O que realmente aconteceu

```
12:13:56.813  fPassarCartao (pid=77596, id=4) despachado na DLL nativa
12:14:02.422  pinpad: "Aproxime, Insira ou Passe o Cartao"      <- estagio de COLETA
12:14:04.672  pSair #1  -> despachado, retornou em 0 ms
12:14:04.788  pinpad: "Aproxime, Insira ou Passe o Cartao"      <- ignorou o cancelamento
12:14:08 … 12:14:21   mais 12 pSair, todos despachados e retornando em 0 ms, nenhum efeito
12:14:33.404  operador mata o autcom -> "ABORTANDO pelo pSair" (RF24)
12:15:16.559  fConfiguraTefCitel do pid=109292 ADIADO - pid=77596 EM VOO (RF17 item 4)
12:15:48 e 12:15:56   fPassarCartao do pid=109292 RECUSADO por posse do pinpad  <- a "trava de uso"
12:16:30.995  pParaComSeguranca: ATENCAO - 1 despacho ainda dentro da DLL nativa depois de 10062 ms
```

**O `fPassarCartao` entrou na DLL nativa às 12:13:56 e continuava lá às 12:16:31 — 2min34s depois**,
atravessando 13 cancelamentos e a morte do próprio processo que o pediu. A transação estava no
estágio de coleta, que é justamente onde a flag do `pSair` *deveria* ser lida.

Tudo o que o operador viu depois disso é o comportamento **projetado** diante de uma chamada nativa
que não volta: a tela congelada é o `WaitFor(INFINITE)` do `fChamaRpc` (regra do topo de
`IA\rules\tef-dvc.md` — não pode ter teto); a "trava de uso" do autcom seguinte é a RF17 itens 1 e
4 protegendo o pinpad de quem ainda o detém. A `lckatc` é outra trava, do lado autcom, e não tem
relação com esta.

#### O suspeito, e o que ainda não está provado

A única coisa que mudou nessa estação pouco antes: **o pacote `scope` foi trocado às 12:11:41**
(`0ce5411deb24`, 9.749.414 bytes). O `fPassarCartao` de 12:08:21, **antes** da troca, retornou
normal às 12:09:55. O de 12:13:56, **depois** da troca, não voltou.

Correlação, não prova — uma única ocorrência. Para fechar: repetir com o outro pacote
(`9bff541eb988`) e ver se o `fPassarCartao` volta a honrar o `pSair`.

#### Achado de tabela: a TRANSFERÊNCIA não é barrada por ocupação, só a APLICAÇÃO

`fMetodoFAtuAplica` chama `fEstacaoOciosa` antes de aplicar. `pMetodoPAtuAbre`/`pAtuParte` **não
checam nada** — repassam direto para `FAtualizacao`. Consequência medida nesta sessão: os 9,7 MB
foram empurrados entre 12:09:05 e 12:11:40, **por cima de uma transação de cartão viva** iniciada
às 12:08:21; às 12:09:13 o pinpad deu `"Esgotado o Tempo de Resposta"`.

**Não afirmo causalidade:** 52 s sem cartão apresentado é timeout normal de pinpad, e a transação
retornou bem. Mas o desenho permite empurrar 9,7 MB pelo mesmo canal durante uma coleta, e isso
merece decisão explícita — hoje é omissão, não escolha registrada.

**Hipótese do Rafael (2026-09-16, depois da análise acima): é a DLL do Scope, e só na versão mais
recente.** Com isso o mapeamento dos dois pacotes que vinham sendo alternados nas baterias fica
registrado — não dá para deduzir do código nem do log:

| sha256 do pacote | tamanho | versão do Scope |
|---|---|---|
| `0ce5411deb24` | 9.749.414 B | **mais recente** — é a que estava aplicada no travamento de 12:13:56 |
| `9bff541eb988` | 9.743.516 B | anterior |

Plano: voltar para `9bff541eb988` e repetir o teste. **O que torna o teste conclusivo** é reproduzir
o mesmo roteiro: iniciar `fPassarCartao`, deixar chegar em "Aproxime, Insira ou Passe o Cartao" e
clicar em encerrar **sem apresentar cartão**. Se o `pSair` for honrado e o `fPassarCartao` voltar
sem retorno, a versão do Scope está confirmada como causa e a Fase 6 segue sem pendência nesta
frente.

Vale notar para quem retomar: **este caminho só ficou visível agora porque a Fase 6 passou a trocar
a DLL do Scope em campo.** O defeito é de terceiro e é anterior, mas a rotina de atualização é o
que o coloca na mão do operador — trocar de versão de Scope deixou de ser evento de instalação e
virou evento de rotina.

### CONFIRMADO: é a DLL do Scope — teste A/B de 2026-09-16, 14:21 vs 15:10

Teste controlado do Rafael, mesmo roteiro nas duas versões (iniciar `fPassarCartao`, esperar
"Aproxime, Insira ou Passe o Cartao", clicar encerrar **sem apresentar cartão**). Logs com sufixo
`_versao_nova_com_problema`. **A hipótese está confirmada e o mecanismo, isolado.**

| | Scope **anterior** | Scope **nova** |
|---|---|---|
| 1ª transação: `pSair` → retorno | 15:11:02.5 → 15:11:05.3 (2,8 s) ✔ | 14:21:19.5 → 14:21:20.9 (1,4 s) ✔ |
| 2ª transação: `pSair` → retorno | 15:11:15.2 → 15:11:18.2 (3,0 s) ✔ | **nunca** — 33 `pSair`, ainda na DLL 42 s depois ✘ |

Ambas reportam `ScopeOpen -> Versao = 4.1.2`: **a string de versão não distingue as duas**. Só o
comportamento distingue.

#### O mecanismo, pelo `ScopeTrc.txt`

**Versão anterior** — o cancelamento encerra:
```
15:11:15  ScopeResumeParam -> Botao Pressionado = Cancelar (C)   -> Retorno 0
15:11:16  ScopeResumeParam -> Botao Pressionado = Cancelar (C)
15:11:16  ScopeResumeParam -> Retorno: 65028 (0xFE04) [RCS_NAO_EXISTE_TRN_SUSPENSA]
15:11:16  ScopeMTEFFechaSessao / ScopeFechaSessaoTEF -> 0
15:11:17  ScopePPClose -> 0        15:11:18  ScopeClose -> RCS_SUCESSO
```

**Versão nova** — o cancelamento **muda de estado em vez de encerrar**:
```
14:21:48  ScopeResumeParam -> Botao Pressionado = Cancelar (C)   -> Retorno 0 (aceito)
14:21:48  DeveColetarCartaoDigitado -> EC_COLETA_CARTAO_EM_ANDAMENTO
14:21:48  ScopeStatus -> 64645 (0xFC85)
14:21:49  ScopeGetParam -> TipoParam = 0xFC85, MsgOp2 = "Digite o Cartao"
14:21:49  ScopeResumeParam -> Dados = (vazio), Botao = Proximo (P) -> Retorno 65296 (0xFF10)
14:21:49  ScopeStatus -> 0xFC85 ... e repete 106 vezes ate o log acabar
```

Contagem de `TipoParam` no trace com problema: **antes** do cancelamento, 24× `0xFCFC` (coleta de
cartão pela leitora) e 2× `0xFCFE`; **depois**, 106× `0xFC85` e nada mais. `0xFC85` é
`SCO_CARTAO_DIGITADO` (`untScopeNCR.pas:340`) — digitação manual do cartão.

**Em uma frase:** ao receber "Cancelar" durante a coleta pela leitora, a versão nova do Scope não
aborta a transação — ela cai em **digitação manual de cartão** e fica repetindo o pedido. O cliente
responde com dado vazio + "Proximo", o Scope recusa com `0xFF10` e pede de novo. **Livelock**, sem
saída por tempo nem por sinal.

Isso explica o caso das 12:13:56 sem precisar de hipótese nova: lá o travamento também veio na
transação seguinte a um cancelamento.

#### Nada a consertar na Fase 6 — mas há uma mitigação possível, e é decisão do Rafael

Nossa camada fez tudo certo nos dois casos: despachou os 33 `pSair`, cada um retornando em 0 ms; a
tela congelada é o `WaitFor(INFINITE)` que a regra exige; a "trava de uso" é a RF17 protegendo o
pinpad de quem ainda o detém.

A mitigação possível fica em `untTefCitelNCR.pas:1101`, o ramo `Integer(SCO_CARTAO_DIGITADO)`: ele
chama `pIniciaColetaCartao` **sem olhar se um cancelamento já foi pedido**. O sinal existe —
`pSair` → `pUsuarioEncerraTransacao` → `FintContinua := -1`. Recusar iniciar coleta manual quando
`FintContinua = -1`, e seguir injetando Cancelar, quebraria o livelock.

**Não é timeout, então não esbarra na regra do topo de `IA\rules\tef-dvc.md`** — é detectar que o
outro lado está repetindo o mesmo pedido depois de um cancelamento aceito. Mas mora no núcleo
legado do TEF, no caminho de toda transação de cartão: exige bateria completa, não só teste da
Fase 6. **Não implementado** — aguardando decisão.

*Resíduo visto de passagem:* `FblnSaiu` (`untTefCitelNCR.pas:32`) é atribuído em dois pontos e
**nunca lido**. Quem cancela de verdade é o `FintContinua := -1`. Campo morto, confunde a leitura.

#### O que isto significa para a Fase 6

O defeito é de terceiro e é anterior a tudo. Mas **quem o colocou na mão do operador foi a Fase 6**:
trocar versão de Scope deixou de ser evento de instalação e virou rotina. Vale decidir se a
atualização precisa de uma lista de versões conhecidas-ruins — hoje ela aplica o que mandarem.

### MITIGAÇÃO aplicada em `untTefCitelNCR.pas` — cancelamento tem precedência sobre coleta digitada

Provisória, pedida pelo Rafael em 16/09 enquanto o suporte do Scope não retorna.

#### A parte do problema que É nossa

O defeito é do Scope (ver a seção anterior), mas **o laço não saía sozinho por causa daqui**:

```
pIniciaColetaCartao  -> poe AbyteAux := 1 quando ha buffer
pTrataMensagemRetornadaScope(bAux, ...)  -> `if (AbyteAux <> 1)` — corpo INTEIRO pulado
```

E é dentro desse corpo que mora a decisão de botão, inclusive
`if (FintContinua = -1) ... FintSinc := FintSinc or ACAO_CANCELAR`. Ou seja: **entrar na coleta de
cartão digitado pula a decisão de botão inteira**, e o cancelamento que o operador já pediu deixa de
ser considerado. O trace mostrava o resultado — `COLETA_PROXIMO_ESTADO` com `Digitos = 0`, 106 vezes.

#### O que mudou

No ramo `Integer(SCO_CARTAO_DIGITADO)`, com `FintContinua = -1` (e fora do PIX, mesmo critério
já usado nas linhas 433 e 2999), não se entra mais na coleta digitada: zera `bAux`, mantém a
mensagem do operador e deixa o `pTrataMensagemRetornadaScope` rodar — que então escolhe
`COLETA_CANCELAR`.

**`bAux := 0` explícito, e não apenas "não setado":** ele vem por referência do `fAnaliseParalela`
do laço interno (`SCO_COLETA_CARTAO_EM_ANDAMENTO`) e pode chegar ao ramo já em 1. Deixá-lo em 1
manteria o `pTrataMensagemRetornadaScope` calado e a guarda não valeria nada. Foi o erro que quase
entrou.

#### Por que funciona nas duas versões

Não por acaso: **`TipoParam = 0xFC85` não aparece uma única vez no trace da versão anterior** depois
de um cancelamento — ela devolve `RCS_NAO_EXISTE_TRN_SUSPENSA` e encerra. A guarda é **inerte** lá.
E `pIniciaColetaCartao` tem **um único chamador** em toda a unit, então o alcance da mudança é
exatamente este ramo.

**Não é timeout** — não há teto de tempo nenhum. Só devolve precedência a um cancelamento já pedido,
então não esbarra na regra do topo de `IA\rules\tef-dvc.md`.

#### Risco residual, que NÃO está coberto

Sabemos o que a versão nova faz com `COLETA_CANCELAR` em `0xFCFC` (muda para `0xFC85` em vez de
abortar). **Não sabemos o que ela faz com `COLETA_CANCELAR` em `0xFC85`** — nunca foi enviado, porque
o código sempre mandou `Proximo` ali. Se ela também ignorar, o livelock continua, só que injetando
Cancelar em vez de Proximo. Nesse caso o passo seguinte seria um detector de repetição (não um
timeout): N envios de `COLETA_CANCELAR` no mesmo estado sem o estado mudar → `FechaSessaoTEF(SCO_DESFAZ_TEF)`
e sair. Não implementado — depende do que o próximo teste mostrar.

#### Como validar

No `ScopeTrc.txt`, no estado `0xFC85`, deve passar a aparecer **`Botao Pressionado = Cancelar (C)`**
no lugar de `Proximo (P)`. E no log da estação, o `fPassarCartao` deve **retornar** depois do `pSair`,
como já acontece na versão anterior. Compila limpo (só o `H2077` pré-existente).

*Resíduo já anotado e ainda de pé:* `FblnSaiu` (`untTefCitelNCR.pas:32`) é atribuído e nunca lido.

### VELOCIDADE DA TRANSFERÊNCIA — o que a PoC `DVC_v2` prova (e o que ela prova ALÉM do pedido)

Reclamação: 9,7 MB levam ~154 s, inviável para produção. Pedido inicial: aumentar o chunk do DVC.

#### Por que o chunk é o botão errado

`TEF_DVC_TAMANHO_MAX_FRAGMENTO = 1400` não é valor de tuning — é o conserto de 2026-08-31. O teto
físico observado é ~1604 bytes; acima disso volta a remontagem multi-chunk do WTS. Ganho máximo
abaixo do teto: ~14%. E a constante é compartilhada com o caminho da transação, com a regra
exigindo alterar os dois transportes no mesmo commit.

#### Onde o tempo vai (medido)

```
9,7 MB -> base64 -> ~13 MB no fio  /  1400 bytes  =  ~9.300 fragmentos
envio SEQUENCIAL ACK-gated (fEnviaFrame:2122) + RTT ~16 ms  =  ~150 s   (medido: 154 s)
```
Limitado por latência. O caminho de envio não tem sleep nem desperdício.

#### O que a PoC mostra

`DVC_v2` (`relatorio-teste-viabilidade-dvc.md`): matriz de 1 byte a 1 MiB, baterias de 20, 1.000 e
10.000 repetições — **mais de 105.000 idas e voltas, zero divergência de tamanho ou conteúdo**,
incluindo 1 MiB × 1.000. **O RTT é praticamente constante (~158 ms) de 1 byte até 100 KiB**; 256 KiB
= 175 ms; 1 MiB = 366 ms. O custo é por MENSAGEM, não por byte.

#### E o que ela prova além disso — o ponto que decide o desenho

A PoC faz remontagem multi-chunk (`CHANNEL_FLAG_FIRST/LAST`, laço de `WTSVirtualChannelRead`) e
**não falha nunca**. Isso parece contradizer o achado de 31/08 — e não contradiz. A diferença está
no comentário que já estava no nosso código, em `untTefCitelDvcTransporte.pas:301`:

> *"Isto NAO conserta a causa da perda, que continua de pe - ver o comentario em pLoopLeitura sobre
> **WTSVirtualChannelWrite abortando o WTSVirtualChannelRead pendente**."*

**A perda nunca foi do tamanho: é da CONCORRÊNCIA.** Uma escrita aborta a leitura pendente, e se
essa leitura estava no meio da remontagem de uma mensagem multi-chunk, a mensagem se perde. A
fragmentação em 1400 é *mitigação* — com mensagem de um chunk só, uma leitura abortada perde no
máximo um quadro pequeno, que o ACK/retry recupera.

A PoC é estritamente serializada (escreve, depois lê o eco, thread única, nada mais escrevendo no
canal) — por isso 1 MiB passa sem arranhão. **Não é que o canal mudou; é que ninguém escreve durante
a leitura.**

#### Consequência de desenho

Um caminho de alta velocidade é viável **exatamente porque a atualização é pontual**: basta garantir
que, durante a transferência, nada mais escreva no canal usado. A forma que garante isso sem tocar
em nada testado é um **canal DVC separado, dedicado ao volume**, no mesmo padrão da PoC — request/
response serializado, thread única, mensagens grandes, bytes crus (sem base64, economizando outros
25%). O `TefCitelCh`, o protocolo de quadro, o ACK, a dedup e os consertos validados ficam
**byte a byte intocados**.

Ordem de grandeza pelos números da própria PoC: 9,7 MB crus em mensagens de 256 KiB ≈ 38 mensagens
× 175 ms ≈ **7 s**; em 1 MiB ≈ 10 × 366 ms ≈ **4 s**. Contra 154 s hoje.

**Custo honesto, que não dá para esconder:** o plug-in do cliente precisa atender o segundo canal.
Ou ganha um listener novo (aditivo, mas mexe num binário testado em campo), ou vira uma **segunda
DLL de plug-in** — que é o que a PoC já é (`TefDvcClient.dll`, canal `TefVitelCh`) e deixaria o
`TefCitelDvcPlugin.dll` intocado. A segunda DLL custa mais um registro no cliente e mais uma
superfície para o antivírus, que é justamente a razão pela qual o atualizador virou executável à
parte (decisão do Rafael, 2026-09-15).

### FASE 6.1 IMPLEMENTADA — canal DVC dedicado à atualização (2026-09-16)

Seis tarefas do plano executadas inline. **Tudo compila; nada foi exercitado em estação.**

#### Arquivos

**Novos** (todos em `svn add`):

| Arquivo | Papel |
|---|---|
| `libTefCitel\Estacao\UpdatePlugin\TefCitelDvcUpdate.dpr` + `.dproj` + `.res` | DLL do plug-in do canal `TefCitelUpd` |
| `libTefCitel\Estacao\UpdatePlugin\untTefCitelDvcUpdateApi.pas` | interfaces WTS (duplicadas de propósito) |
| `libTefCitel\Estacao\UpdatePlugin\untTefCitelDvcUpdateImpl.pas` | relé DVC → socket, pergunta-resposta |
| `libTefCitel\Estacao\untTefEstacaoUpdateListener.pas` | porta 47992 no serviço, alimenta `FAtualizacao.pParte` |
| `libTefCitel\untTefCitelDvcUpdateTransporte.pas` | lado autcom: abre canal, manda bloco, lê resposta |

**Alterados:** `untTefCitelAtuComum.pas` (4 constantes), `untTefEstacaoServiceMain.pas` (sobe/desce o
listener), `TefEstacaoService.dpr` e `libTefCitel.dpr` (uses), `untTefEstacaoRoteadorMensagens.pas`
(uma propriedade só-leitura + um comentário corrigido), `untTefEstacaoAtualizacao.pas` (comentário),
`untTefCitelDvcAtualizacao.pas` (o caminho rápido), `register-plugin.ps1` e `unregister-plugin.ps1`.

**Não tocados, como a spec exigia:** `TefCitelDvcPlugin.dll` (nem recompilado),
`untTefCitelDvcTransporte.pas`, `untTefEstacaoTcpTransporte.pas`, protocolo de quadro, ACK, dedup.

#### Três decisões que divergiram do plano, e por quê

**1. O laço de remontagem NÃO foi copiado da PoC.** O plano mandava copiar
`DVC_v2\src\server\TefDvcServer.dpr:62-89`. Seria regressão: aquele laço decide o fim da mensagem
pela flag `CHANNEL_FLAG_LAST`, e o comentário de `fProcessaChunkWts` registra um dump forense de
2026-08-28 provando que **as flags FIRST/LAST não têm o significado esperado** nesta combinação —
um chunk chegou com `flags=LAST` declarando `totalLength=2298` e trazendo 1596 bytes. A PoC só
funciona com elas porque sempre sabe o tamanho esperado de antemão; aqui não se sabe o tamanho da
resposta. Seguiu-se o caminho de produção: decidir **só pelo `totalLength`**.

De brinde veio a segunda lição registrada lá — a validação de início de mensagem contra ruído do
canal (o prefixo de 4 bytes logo após o header WTS tem de bater com `totalLength - 4`). Nosso
enquadramento é exatamente assim, então a defesa entrou sem adaptação.

**2. As constantes entraram na Tarefa 2, não na 3.** O plano dizia que as Tarefas 1–3 eram
independentes. Não eram: a Tarefa 2 precisa de `TEF_UPD_PORTA`. `untTefCitelAtuComum.pas` é o
contrato dos dois lados.

**3. Nada foi adicionado a groupproj nenhum.** O plano mandava registrar o projeto novo. Mas nem o
`TefCitelDvcPlugin.dproj` nem o `TefEstacaoService.dproj` estão em groupproj algum — os projetos da
estação são abertos individualmente na IDE, e só o `libTefCitel.dproj` entra no `autcom.groupproj`.
Colocar o plug-in novo lá faria o build do ERP depender de artefato de estação. A DLL de volume
segue o padrão do irmão.

E um item do plano que era simplesmente falso: `install-service.ps1` **não copia arquivo nenhum** —
o pacote já chega flat. Nada a mudar lá.

#### Contrato de validação — o que olhar em cada log

| # | Critério (spec 12.3) | Onde | O que procurar |
|---|---|---|---|
| 1 | Transferência < 20 s | `TefCitelDvcTransporte.log` | `pacote "scope" enviado pelo canal RAPIDO (N bloco(s), N bytes, N ms)` |
| 2 | sha256 confere, tudo aplicado | `TefEstacaoService.log` | `fAtuFecha: pacote ... conferido e PREPARADO` + 32 linhas `gravado`, zero `FALHOU em` |
| 3 | Estação sem a DLL nova | `TefCitelDvcTransporte.log` | `pacote "X" vai pelo caminho LENTO - canal "TefCitelUpd" nao abriu (erro ...)` |
| 4 | Serviço sem a porta nova | idem | mesmo `caminho LENTO`, motivo citando o `connect` recusado |
| 5 | Canal derrubado no meio | ambos | `bloco N recusado`, depois `caminho LENTO`, e a carga do TEF **não** falha |
| 6 | Pacote corrompido | `TefEstacaoService.log` | `fAtuFecha` recusando — o `.parcial` não é promovido |
| 7 | Transação de cartão depois | `TefEstacaoService.log` | `fPassarCartao` completa normal |
| 8 | Canal de transação intacto | `TefCitelDvcTransporte.log` | **nenhum** `quadro duplicado descartado` nem `sem ACK` novo |

Linhas novas que passam a existir no `TefEstacaoService.log`, todas com prefixo `UPD:`:
`ouvindo em 127.0.0.1:47992`, `plugin de volume conectado`, `bloco RECUSADO (...)`,
`plugin de volume desconectado`, `porta de volume encerrada`.

E um arquivo de log novo **na máquina cliente**, ao lado da DLL: `TefCitelDvcUpdate.log`.

#### Roteiro da bateria, nesta ordem

1. **Primeiro sem a DLL nova** — é o que protege produção. Registrar só o `TefCitelDvcPlugin.dll`
   como hoje e rodar uma atualização inteira. Tem de funcionar exatamente como antes, com a linha
   `caminho LENTO` explicando o motivo. **Se este passo falhar, nada mais importa.**
2. **Depois com a DLL nova** — `register-plugin.ps1` agora registra as duas. Rodar a mesma
   atualização e medir: comparar com os 154 s de 2026-09-16.
3. **`fAtuFecha` conferindo o mesmo sha256**, pacote aplicado com todos os arquivos.
4. **Uma transação de cartão completa logo depois.** É o critério 7, e existe por causa do risco
   que não dá para eliminar no papel: escrita num canal DVC abortando leitura pendente em OUTRO
   canal. A PoC roda sozinha e não cobre isso.
5. **Conferir o critério 8** no log do autcom — é a prova de que o canal da transação não sentiu.

#### O que continua pendente da Fase 6

Os consertos 2 (esperar o processo sair) e 3 (retry na gravação) do `TefEstacaoAtualizador.exe`
**seguem sem execução em campo** — a estação ainda roda o atualizador antigo, porque ele não viaja
no pacote `scope`.

### PRIMEIRA BATERIA DA FASE 6.1 — 2026-09-17, 11:24–11:35 (canal rápido funcionou)

**4.875 ms contra 154.000 ms. 31 vezes mais rápido.**

```
11:29:33.327  [autcom]  Atualizacao: canal de volume "TefCitelUpd" aberto.
11:29:33.294  [plugin]  Conexao aceita no canal "TefCitelUpd".
11:29:33.369  [plugin]  Conectado ao TefEstacaoService.exe (127.0.0.1:47992).
11:29:33.369  [servico] UPD: plugin de volume conectado.
11:29:38.205  [plugin]  Canal de atualizacao fechado pelo autcom.exe apos 38 bloco(s).
11:29:38.216  [autcom]  pacote "scope" enviado pelo canal RAPIDO (38 bloco(s), 9743516 bytes, 4875 ms).
```

As três pontas contam a mesma história, com os mesmos 38 blocos. O `TefCitelDvcUpdate.log` nasceu
na máquina cliente, como previsto.

#### Critérios da spec 12.3

| # | Critério | Resultado |
|---|---|---|
| 1 | Transferência < 20 s (alvo ~9 s) | **4,9 s** ✔ |
| 2 | sha256 confere, pacote aplicado inteiro | `fAtuFecha ... PREPARADO (9743516 bytes, sha256 9bff541eb988...)`, **34 gravados, 0 FALHOU** ✔ |
| 3 | Estação **sem** a DLL nova → caminho lento | **NÃO TESTADO** |
| 4 | Serviço **sem** a porta nova → caminho lento | **NÃO TESTADO** |
| 5 | Canal derrubado no meio | **NÃO TESTADO** |
| 6 | Pacote corrompido barrado pelo checksum | **NÃO TESTADO** |
| 7 | Transação de cartão completa depois | duas — 11:30:21→11:30:44 e 11:30:48→11:31:10 ✔ |
| 8 | Canal da transação intacto | ✔ — ver abaixo |

**O critério 3 é o que falta, e é o mais importante dos quatro.** Ele é o que protege produção
durante a implantação: a estação comum, por um bom tempo, vai ser a que ainda não tem a
`TefCitelDvcUpdate.dll`. O roteiro do plano mandava começar por ele justamente por isso. Enquanto
não for testado, não se sabe se o fallback do RF45 funciona — só que o caminho rápido funciona.

#### Critério 8, em detalhe

Quatro eventos de canal na sessão inteira — 1 `quadro duplicado descartado`, 2 `sem ACK` e 1
`quadro ATRASADO aceito` — **todos às 11:28:21**, ou seja **72 s ANTES** de a transferência
começar, durante uma transação de cartão, e todos recuperados pela retransmissão (o
`quadro ATRASADO aceito` é justamente a prova de que o retry devolveu o quadro perdido).

**Zero eventos durante ou depois da transferência.** É a evidência que faltava sobre o risco que
não dava para eliminar no papel: escrita no canal de volume **não** atrapalhou leitura pendente no
canal da transação. Uma bateria não encerra o assunto, mas é o primeiro dado real a favor.

#### De brinde: os consertos 2 e 3 do atualizador finalmente rodaram em campo

A estação recebeu o `TefEstacaoAtualizador.exe` novo, e as duas linhas que faltavam desde 16/09
apareceram:

```
11:29:38.534  Atualizador: handle do processo do servico (pid=5544) em maos antes do STOP - a espera pela saida dele esta armada.
11:29:39.047  Atualizador: processo do servico saiu 0 ms depois do SCM dizer STOPPED - agora nenhum arquivo dele esta mapeado.
```

O conserto do caminho mudo (`fAbreProcessoServico`) provou o valor dele aqui: a primeira linha diz,
sem ambiguidade, que o atualizador novo está na estação. Em 16/09 isso custou três verificações
cruzadas. O retry de gravação (`travado na tentativa`) não precisou entrar — nenhum arquivo travou.

#### E o conserto do dedup disparou de novo, no momento certo

```
11:29:40.187  fAceitaMessageId: dedup ZERADO - messageId=2 veio ABAIXO da marca d'agua 10 logo depois do reinicio anunciado da estacao.
11:29:40.188  Atualizacao: o servico VOLTOU depois de 1828 ms - instancia "{6AA05120-...}", diferente da "{4D1E5797-...}"
```

#### Sobre o achado aberto da RF29

`loginNecessario`: **zero**. Mas isso **não** significa que o re-login da RF29 foi corrigido. O que
aconteceu aqui é outra coisa: o `fConfiguraTefCitel` das 11:29:40.242 é o login NORMAL da carga do
TEF, que acontece logo depois de o `fEsperaServicoVoltar` retornar. A atualização roda antes de o
operador ter sessão, então não há sessão para refazer.

O achado da RF29 continua de pé para o caso em que o serviço reinicia **depois** de o autcom já ter
feito login — que não é este fluxo. Não riscar da lista.

### CASO B.1 REPRODUZIDO E CORRIGIDO — dois autcom, uma recepção só (2026-09-17, 14:35)

Bateria com dois autcom subindo em sequência. Um mostrou o splash parado em **67%**; o outro
atualizou e abriu normal. Os demais testes da bateria passaram.

#### O que o log conta

```
14:35:18.782  [A pid=155084] pAtuAbre "scope"  -> abre recepcao, manda blocos 0..24
14:35:21.943  [B pid=110836] pAtuAbre "scope"  -> DESCARTA a recepcao de A (25 partes)
14:35:21.997  [A]            pAtuAbre "scope"  -> DESCARTA a de B (fallback) e reabre
14:35:22.067  [B]            manda 38 blocos ... dentro da recepcao que A abriu
14:35:27.653  [B]            fAtuFecha -> PREPARADO, FECHA a recepcao
14:35:27.653  [A]            pAtuParte -> "Pacote scope nao tem recepcao aberta"
14:35:44.255  [A]            fConfiguraTefCitel retornou 0
```

**O autcom A não travou.** O login do TEF voltou 0 às 14:35:44 e a carga terminou — a RN23 fez o
que promete. **Travada ficou só a tela**, parada nos 67% (26 de 38 blocos) da última chamada de
progresso.

#### O defeito

A estação rastreava `[Preparado]` (terminado) mas **não quem está recebendo agora**. Dois autcom
subindo juntos veem os dois "não preparado", os dois transferem, e cada `pAtuAbre` descarta a
recepção do outro.

É defeito da **Fase 6**, não da 6.1 — e a 6.1 até *reduziu* a janela, de 154 s para 5 s. O caso
B.1 existia no checklist exatamente para isto, e provou o valor de exigir o teste simultâneo: a
evidência "parcial" que eu tinha anotado (segundo autcom em carga posterior vendo `[Preparado]`)
não cobria nada disto.

**Duas agravantes que são minhas:**

1. O fallback do canal rápido refaz o `pAtuAbre` quando já mandou blocos — e foi ele, às
   14:35:21.997, que destruiu a recepção que B tinha acabado de abrir.
2. **O sucesso de B foi sorte.** Ele escreveu os 38 blocos dentro da recepção que **A** abriu, e o
   sha256 bateu só porque os dois mandavam o arquivo idêntico. Com pacotes diferentes seria arquivo
   cruzado — pego pelo hash, mas depois de 9,7 MB à toa.

#### O conserto (decisão do Rafael: a estação arbitra)

A estação é o único ponto que enxerga todos os autcom — mesmo papel que ela já tem no `fAtuAplica`
recusando por ocupação.

- `TTefEstacaoRecepcao` ganhou **`dwPidDono`** e **`dwTickUltimaParte`**.
- `pAbre` recusa quando existe recepção **viva de outro pid**. Reabrir do **mesmo** pid continua
  permitido — é assim que uma transferência interrompida recomeça, inclusive no fallback rápido→lento.
- **`TEF_ATU_RECEPCAO_ABANDONADA_MS = 60000`**: dono que parou de mandar parte há mais de 60 s
  perde a vez. Sem isso, um autcom que morre no meio trancaria o pacote para todos até o serviço
  reiniciar. 60 s é folgado contra o caminho lento (~4 s por parte) e o rápido faz os 38 blocos em
  ~5 s.
- O autcom manda o `pid` no `pAtuAbre` e, ao ser recusado, **sai como sucesso**: não transfere
  nesta carga, e a próxima encontra o pacote pronto — mesmo desfecho do `[Preparado]`. Sair como
  falha registraria um erro que não existe.

**Compatível nos dois sentidos, de propósito.** O handler `pAtuAbre` passou a devolver resposta
(`aberto` + `motivo`), mas o nome no fio não mudou: autcom antigo ignora a resposta; autcom novo
contra estação antiga não recebe `aberto` e assume `True`, que é o comportamento de hoje. Nenhuma
das pontas precisa subir junto com a outra.

#### Aberto: o splash congelado

Quando a atualização falha, ninguém chama `pProgresso` de novo e a tela fica no último valor. Com a
arbitragem o **sintoma some neste cenário** (o segundo autcom nem transfere), mas o defeito
continua de pé para qualquer outra falha no meio da transferência. Não foi corrigido — é da camada
de UI do autcom, que esta sessão não abriu.

### A BATERIA DE 2026-09-17 POR INTEIRO — quatro rodadas, e o critério 3 caiu

O `TefCitelDvcUpdate.log` só começa às **14:24:34** (`Listener "TefCitelUpd" criado`). Ou seja: as
três primeiras rodadas correram **sem o plug-in de volume carregado** — foi o teste do fallback,
sem ninguém precisar desregistrar nada.

| Rodada | Hora | Pacote | Caminho | Desfecho |
|---|---|---|---|---|
| 1 | 14:17:07 | `0ce5411deb24` | LENTO (`erro 31`) | abortada às 14:17:31 — canal DVC caiu |
| 2 | 14:18:59 → 14:21:28 | `0ce5411deb24` | LENTO | **149,1 s**, PREPARADO; aplicação ADIADA por ocupação |
| 3 | 14:22:59 | `0ce5411deb24` | nenhum | outro autcom viu `[Preparado]` e pulou; **aplicou** |
| 4 | 14:35:18 | `9bff541eb988` | RÁPIDO | **4,9 s**; colisão B.1 (seção anterior) |

Duas aplicações completas no dia, **68 arquivos gravados, zero `FALHOU`**, as duas com
`handle do processo ... em maos antes do STOP` e `processo saiu 0 ms`.

#### Critério 3 da spec 12.3 — VALIDADO, e era o que faltava

`Atualizacao: pacote "scope" vai pelo caminho LENTO - canal "TefCitelUpd" nao abriu (erro 31) -
estacao sem a TefCitelDvcUpdate.dll registrada, ou cliente RDP sem suporte`

Aconteceu duas vezes (14:17:07 e 14:18:59), e na segunda a transferência **completou inteira pelo
caminho antigo**, com `fAtuFecha` conferindo o sha256. É a prova de que estação sem a DLL nova
continua atualizando — o que protege a implantação.

**E de brinde saiu o A/B mais limpo possível**, mesma estação, mesmo dia, mesmo arquivo de 9,7 MB:

| | Caminho LENTO | Caminho RÁPIDO |
|---|---|---|
| Rodada | 2 (14:18:59 → 14:21:28) | 4 (14:35:22 → 14:35:27) |
| Tempo | **149,1 s** | **4,9 s** |

**30 vezes.** Não é mais estimativa da PoC: são as duas medidas lado a lado.

#### Critério B.2 do Passo 6 — VALIDADO, de manual

```
14:19:23.567  [pid=163180] fPassarCartao          <- transacao viva no pinpad
14:18:59 ... 14:21:28  [pid=48568] transfere 9,7 MB pelo caminho lento, POR CIMA da transacao
14:21:28.906  fAtuAplica: RECUSADO por ocupacao - ha 1 despacho(s) dentro da DLL nativa
14:21:28.939  fConfiguraTefCitel do pid=48568 ADIADO - o pid=163180 esta com transacao EM VOO (RF17 item 4)
14:21:28.961  [pid=48568] fObtemVersao            <- carga seguiu normal
14:21:55.315  [pid=48568] fPassarCartao RECUSADO por posse do pinpad
```

Segundo AUTCOM subiu no meio da transação do primeiro: aplicação recusada por ocupação, login
adiado pela RF17 item 4, carga normal, e a transação do primeiro **não** foi interrompida. É
exatamente o que o caso pede.

**Observação, não conclusão:** entre 14:20:19 e 14:21:55 o pinpad deu
`Esgotado o Tempo de Resposta` três vezes, enquanto os 9,7 MB atravessavam o mesmo canal. Ninguém
apresentou cartão, e timeout de pinpad sem cartão é normal — então isso **não** prova interferência.
Mas é a segunda vez que o par "transferência longa + timeout de pinpad" aparece junto (a primeira
foi 16/09, 12:09), e o desenho de fato permite empurrar 9,7 MB durante uma coleta: o `fAtuAplica`
exige ociosidade, o `pAtuAbre`/`pAtuParte` não. Com o canal rápido a janela caiu de 149 s para 5 s,
o que reduz muito a chance — mas a assimetria continua sendo omissão, não escolha registrada.

#### Rodada 1: abortada, não reprovada

Às 14:17:31, com duas partes já entregues, o canal DVC do pid=37308 caiu
(`Canal TEF DVC desconectou enquanto aguardando confirmacao de entrega`). No mesmo instante o
serviço registrou a queda da conexão de **outro** pid (163180) e orfanou duas sessões que estavam
DESANEXADAS havia ~9.820 s. Tem cara de reinício de ambiente no meio do teste, não de defeito do
fluxo — a RN23 fez o que promete e a carga seguiu. **Não conta como caso reprovado nem aprovado.**

### SPLASH CONGELADO — corrigido (2026-09-17)

**A causa é mais simples e mais séria do que parecia:** o `untTefCitelUtil.pas` passa o callback de
status adiante e **nunca o chama por conta própria** — não há uma única chamada de `AprocStatus`
no host. Ou seja, o fluxo de atualização é a **única** coisa que escreve naquele splash durante a
carga do TEF.

Consequência: qualquer saída do `fAtualizaEstacaoTef` deixava a tela com a última mensagem dita, e
ela ficava assim pelo **resto da carga inteira** — incluindo os ~4 s do `fConfiguraTefCitel` e tudo
o que vem depois. Em 17/09 às 14:35 o autcom A falhou a atualização, seguiu a carga e terminou o
login às 14:35:44; o operador viu "Enviando scope (1 de 2)... 67%" o tempo todo. Da tela parecia
travado; do log tinha acabado.

**Conserto:** `try/finally` em volta do corpo do `fAtualizaEstacaoTef`, e no `finally` uma mensagem
final por desfecho (`fEtapaFinal`):

| Retorno | Tela |
|---|---|
| `APLICADO` | `Estacao do TEF atualizada.` |
| `ADIADO` | `Atualizacao adiada - estacao ocupada.` |
| `SEM_VOLTA` | `O servico de TEF da estacao nao voltou.` |
| `FALHA` | `Atualizacao nao concluida - seguindo a carga.` |
| `NADA_A_FAZER` | `Carregando o TEF...` (caso comum — nenhuma tela chegou a ser escrita) |

Usa a forma "só texto" (`0/0`) que o resto do fluxo já usava, o que também tira a barra do
percentual onde a transferência morreu.

*Efeito colateral bem-vindo:* o `H2077` que acompanhava `untTefCitelDvcAtualizacao.pas` desde o
início **desapareceu** — com o `try/finally`, o `Result` atribuído na entrada passou a ser usado de
verdade. O aviso estava correto; era sintoma de que toda saída era por `Exit`.

**Não é cosmético.** É a diferença entre o operador esperar e o operador ligar para o suporte.

### BATERIA DE 2026-09-17, 16:02–16:23 — arbitragem validada, serviço trocado, e um defeito meu

Três rodadas, **todas concluíram**. O que caiu nesta bateria:

#### B.1 CORRIGIDO E VALIDADO — a arbitragem disparou duas vezes, com a mensagem exata

```
16:08:09.222  [pid=162248] pacote "scope" NAO sera transferido por este autcom -
              o pid=155608 esta transferindo este pacote agora (11 parte(s), ultima ha 7x ms)
16:16:52.811  [pid=116040] ... o pid=160700 esta transferindo este pacote agora (7 parte(s), ...)
```

Dois autcom subindo juntos, o segundo recusado, os dois seguiram a carga. Nenhum
`Recepcao anterior DESCARTADA`, nenhum `nao tem recepcao aberta`, nenhum splash congelado.

#### A.4 VALIDADO — o próprio `TefEstacaoService.exe` trocado em operação

```
16:21:51.460  pacote "servico" enviado pelo canal RAPIDO (5 bloco(s), 1058415 bytes, 531 ms)
16:21:52.292  Atualizador: "TefEstacaoService.exe" gravado (2775040 bytes)
16:21:52.359  ServiceStart chamado  ->  16:21:52.363  TCP: ouvindo em 127.0.0.1:47991
16:21:52.861  Atualizador: servico de volta no ar com a versao NOVA
16:23:33.487  Metodo "fPassarCartao" (id=9) retornou com sucesso
```

1 MB em **531 ms**. O serviço se substituiu em operação e uma transação de cartão completou 100 s
depois. O `handle do processo ... em maos antes do STOP` apareceu nas três rodadas.

#### Defeito INTRODUZIDO por mim no conserto do B.1 — corrigido

```
16:08:09.256  [pid=162248] Atualizacao: 1 pacote(s) transferido(s), mas a estacao ADIOU
              a aplicacao - nao ha pacote preparado.
```

O autcom recusado **não mandou um byte**, e o log dizia "1 pacote(s) transferido(s)". Causa: eu fiz
o `fEnviaPacote` devolver `True` na recusa (correto — não é erro), mas quem chama contava isso como
envio e ligava o `LblnTemAlgo`, o que ainda fazia ele chamar o `fAtuAplica` à toa — daí o
`nao ha pacote preparado`.

Corrigido com um `out AblnTransferiu`: sucesso **sem** ter transferido não conta como enviado, não
liga o `LblnTemAlgo` e não chama o `fAtuAplica`. Quem está transferindo aplica; se não der, a
próxima carga aplica.

*A lição é velha nesta sessão:* "não é erro" e "aconteceu" são coisas diferentes, e colapsar as
duas num `Boolean` produz log que mente.

#### O ANTIVÍRUS DETECTOU O ATUALIZADOR — e a separação se provou

Evento do console do AV (Bitdefender GravityZone), **17/09 16:21**:

> **Antimalware** — O Controle Avançado de Ameaças detectou um processo malicioso. **Nenhuma ação
> tomada.** Caminho do processo: `C:\TEF_Citel\TefEstacaoAtualizador.exe`. Nome da ameaça:
> `ATC.SuspiciousBehavior.BED937AA792DFDB0`. Para bloquear processos maliciosos, contate o seu
> administrador do sistema.

Três coisas, e a ordem importa:

**1. A separação do atualizador funcionou exatamente como projetada.** O AV apontou para o
`TefEstacaoAtualizador.exe` — **não** para o `TefEstacaoService.exe`. Foi para isto que a decisão
do Rafael de 2026-09-15 tirou a aplicação de dentro do serviço: se esse código ainda morasse lá, o
que estaria marcado como suspeito seria o processo que a loja **não pode perder**. A hipótese que
motivou a separação deixou de ser teorica.

**2. A detecção é COMPORTAMENTAL, e o horário diz de quê.** `ATC` é o Advanced Threat Control, que
olha comportamento e não assinatura; `SuspiciousBehavior` sem nome de família confirma. E 16:21 é
exatamente a terceira rodada — a única que **parou um serviço pelo SCM, sobrescreveu um `.exe` em
diretório de programa e subiu o serviço de novo**. É o perfil de comportamento descrito no C.6
palavra por palavra.

**3. O TEF não parou porque o AV NÃO AGIU — e essa diferença é o que importa para produção.**
"Nenhuma ação tomada" significa que esta política está em modo de **relato**, e a própria mensagem
diz como mudar isso ("contate o seu administrador para bloquear"). Numa loja com ATC em modo de
bloqueio, o `TefEstacaoAtualizador.exe` é morto. **Então o C.6 continua sem evidência:** não se
observou o AV barrando, só alertando. O comportamento previsto para o bloqueio real (log terminando
em `fDisparaAtualizador`, nada aplicado, TEF seguindo — RN31/C.7) **segue não exercitado**.

**Encaminhamento:** levar `ATC.SuspiciousBehavior.BED937AA792DFDB0` e o caminho do executável para
o fornecedor do AV como falso positivo, e/ou assinar o `TefEstacaoAtualizador.exe`. Enquanto isso
não acontecer, a implantação precisa assumir que em parte das lojas o atualizador será bloqueado —
e é por isso que o C.7 (atualizador ausente/bloqueado, TEF seguindo normal) deixou de ser um caso
de bateria e virou **requisito de produção a provar antes do rollout**.

### A `libTefCitel.dll` virou pacote de atualização (2026-09-17)

Buraco apontado pelo Rafael: a `libTefCitel.dll` **também vive na pasta plana da estação** — o
`TefEstacaoService.exe` a carrega por **delay-load** — e até agora era o único arquivo que precisava
ser copiado à mão quando mudava.

O próprio código já prometia isso. O comentário do `untTefEstacaoRoteadorMensagens.pas`, de
2026-08-28, ao justificar a troca do import para `delayed`:

> *"prepara terreno pra rotina de atualizacao remota de DLL (...): trocar o arquivo libTefCitel.dll
> na pasta plana da estacao passa a bastar, sem precisar recompilar/redistribuir o
> TefEstacaoService.exe inteiro."*

#### O que foi feito

| Onde | Mudança |
|---|---|
| `untTefCitelAtuComum.pas` | `TEF_ATU_PACOTE_LIB = 'libtefcitel'`, `TEF_ATU_DLL_LIB` |
| `untTefEstacaoAtualizacao.pas` | entra no `fTodosOsPacotes` **antes** do `servico` (é dependência dele); `fNomeNoPreparo` mapeia para `libTefCitel.dll` |
| `untTefCitelDvcAtualizacao.pas` | origem = a DLL do **diretório do próprio autcom** |
| `untTefEstacaoAplicacao.pas` | **terceira via** no `pAplicaPacotes` + `pGuardaLibAtual` |

**Sem `.zip`** (decisão do Rafael): é um arquivo só, e compactar binário já compactado não paga o
passo a mais na estação.

#### Três decisões que valem o registro

**1. A origem é a DLL que o autcom está rodando**, não um pacote montado à parte. Servidor e estação
conversam pelos exports dessa DLL; mandá-la de outra origem abriria a porta para a estação rodar
uma versão que ninguém testou contra aquele autcom. Vindo dali, atualizar o servidor faz a estação
acompanhar na carga seguinte, e o hash cuida do resto.

**2. A terceira via era obrigatória, não estética.** Até aqui o `pAplicaPacotes` tinha duas: `.zip`
extrai, e **tudo o mais caía no ramo do `.ini`** e passava pelo `fAjustaCaminhosIni`. Para um `.ini`
sem chave de caminho isso é inofensivo — volta intacto —, mas para uma DLL seria **corrupção
silenciosa**. O ramo novo grava byte a byte, pelo `fGravaComRetentativa` que já existia.

**3. `.old` sem reversão automática**, decidido explicitamente. DLL com delay-load **não falha na
subida do serviço**, e sim na primeira chamada RPC — depois de o atualizador já ter terminado. Não
há como ele detectar. O `.old` dá ao suporte um caminho de volta de um comando; prometer rede
automática seria prometer o que não funciona.

#### Um risco que o conserto trouxe junto

Os dois laços de envio abriam o arquivo com `fmShareDenyWrite`. Agora um dos arquivos lidos está
**carregado neste mesmo processo**. Deny-write costuma funcionar com módulo carregado (o `CopyFile`
do Windows usa o mesmo share), mas não havia por que apostar — ainda mais porque o
`fTamanhoArquivo`, na mesma unit, já lê **estes mesmos arquivos** com `DenyNone`. Os dois laços
passaram a usar `DenyNone`. O que se abre mão (alguém escrever durante a leitura) já está coberto
pelo sha256 conferido no `fAtuFecha`.

#### Efeito colateral bom para a implantação

A partir da próxima carga, **a `libTefCitel.dll` deixa de ser item de deploy manual**. A lista de
arquivos a levar à mão passa a ser só o `TefEstacaoService.exe`, o `TefEstacaoAtualizador.exe` e a
`TefCitelDvcUpdate.dll` — e mesmo esses dois primeiros já viajam pelo pacote `servico`.

**Confirmado em campo pelo Rafael em 17/09** (relato, sem log analisado deste ciclo): a
`libTefCitel.dll` passou a ser atualizada pelo mesmo fluxo, junto com os demais pacotes.

### BATERIA CLISITEF — 2026-09-18, 11:17 e 11:23

Primeira vez que o ramo `OPCAO_CLISITEF` roda. Tudo o que havia de inédito caiu de uma vez.

#### Rodada 1 (11:17:41 → 11:17:51) — três pacotes numa carga só

| Pacote | Tamanho | Blocos | Tempo |
|---|---|---|---|
| `clisitef` (`tef_clisitef.zip`) | 11.529.365 B | 44 | **7.171 ms** |
| `clisitef.ini` | 868 B | 1 | 31 ms |
| `confitls.ini` | 114 B | 1 | 16 ms |

Os três com sha256 conferido no `fAtuFecha`. Aplicados: `libemv.dll`, `QREncode32.dll`,
`RechargeRPC.dll`, `CliSiTef32I.dll` (11 MB), `libcurl32.dll`, mais os dois `.ini`. Serviço de volta
no ar em 11:17:51, e `fPassarCartao` completando às 11:18:19 — a pilha CliSiTef funcionando depois
da troca.

#### Rodada 2 (11:23:47) — a granularidade por hash, demonstrada

Só o `CONFITLS.ini` tinha mudado (sha `6dc1b83f95e0` contra `7e58c11475b1` da rodada anterior), e
**só ele atravessou**: 114 bytes, 1 bloco, 16 ms. Os 11,5 MB do `clisitef` não foram reenviados.
É a RN19/RN20 fazendo exatamente o que prometem.

#### O pacote `libtefcitel` também rodou em campo (17/09 17:13)

85 blocos, **22.082.032 bytes em 9.328 ms**. O maior pacote do requisito até agora, e o mais rápido
por byte.

#### Corrigido aqui: o log do `.ini` prometia reescrita que não aconteceu

```
Atualizador: "CONFITLS.ini" gravado com os caminhos apontando para "C:\TEF_Citel".
```

Só que o `CONFITLS.ini` **não declara chave de caminho nenhuma** — o `fAjustaCaminhosIni` devolve o
conteúdo intacto, por desenho. A mensagem afirmava uma reescrita que não houve, e quem fosse
diagnosticar um `.ini` errado procuraria no lugar errado.

Agora são duas mensagens, escolhidas por comparação byte a byte do antes e depois:
`gravado com os caminhos reescritos para "..."` ou
`gravado SEM ajuste - o arquivo nao declara chave de caminho, entao foi gravado exatamente como veio.`

*É a quarta vez neste requisito que um comentário ou log promete mais do que o código entrega.*

#### O que a bateria NÃO cobriu

- **C.5 / cascata do RF33**: zero linhas `pasta do terminal` no log — o `CFG_PTTFCT` estava vazio,
  então os `.ini` vieram da pasta do autcom pelo caminho simples. A cascata
  `<CFG_PTTFCT>\<TFC_NUMTER>\` → queda para a raiz **continua sem teste**, e é o ramo que tem as
  duas linhas de log feitas sob medida para o diagnóstico.
- **A.2 / os quatro comentários preservados**: não dá para verificar por log. Precisa abrir o
  `CliSiTef.ini` gravado na estação e comparar com o de origem.

### CASCATA DO RF33 VALIDADA — 2026-09-18, 12:04:59

```
12:04:59.338  Atualizacao: "CliSiTef.ini" veio da pasta do terminal ("C:\Users\rafael.bizio\RB001001\").
12:04:59.339  Atualizacao: "CONFITLS.ini" veio da pasta do terminal ("C:\Users\rafael.bizio\RB001001\").
```

`CFG_PTTFCT` preenchida e a subpasta do terminal existindo: os dois `.ini` saíram de
`<CFG_PTTFCT>\<TFC_NUMTER>\`, e a linha de log que existe justamente para tirar a dúvida no
diagnóstico apareceu para os dois.

**E a granularidade por hash trabalhou junto, de um jeito que só este teste mostraria:** o
`CliSiTef.ini` da pasta do terminal tem **846 bytes**, contra os **868** da pasta do autcom usados
na bateria anterior — é outro arquivo. O sistema detectou a divergência e transferiu **só ele**
(1 bloco, 15 ms); o `CONFITLS.ini`, cujo hash batia com o já aplicado, não atravessou. Ciclo
completo: `fAtuFecha` conferindo `e306fdbc55a7`, aplicado, serviço reiniciado, `dedup ZERADO`
disparando no momento certo e instância nova confirmada em 1.469 ms.

#### O que esta rodada NÃO cobriu

- **A outra metade da cascata**: os dois arquivos ESTAVAM na pasta do terminal, então a queda para
  a pasta do autcom (`"NAO estava na pasta do terminal - caiu para..."`) segue sem teste. É o ramo
  que cobre a loja que tem `CFG_PTTFCT` mas não criou a subpasta de algum terminal — provavelmente
  o caso mais comum em campo, e o mais fácil de testar: basta apagar um dos `.ini` da subpasta.
- **A.2, comentários preservados**: continua não verificável por log. Fecha comparando o
  `CliSiTef.ini` de origem com o gravado em `C:\TEF_Citel` — só as linhas de caminho podem diferir.
- **Critérios 4, 5 e 6 da spec 12.3** e o **C.7** (atualizador ausente/bloqueado), que virou
  requisito de produção depois do evento do antivírus.

## PONTO DE PARADA — 2026-09-18, meio-dia (Fases 6 e 6.1 validadas; instalador é o próximo)

> **Superado em 2026-09-18 16:05 quanto a build e backup** — ver o `PONTO DE PARADA — 2026-09-18, 16:05` no fim deste arquivo. As pendências de teste e os resíduos técnicos desta seção continuam valendo.

### PRÓXIMA SESSÃO — começar aqui

**Nada está commitado.** Toda a Fase 6 + 6.1 está como `A`/`?` na working copy, por decisão: commit
único no fim, com `Req. 456190` na primeira linha e token do DelphAI. Backup a cada marco —
o último é `_backups\456190_20260918_1208\`.

**O que precisa de rebuild antes da próxima bateria:** só o **`TefEstacaoAtualizador.exe`**. O
último build do Rafael foi 17/09 17:07-17:08; depois dele o único fonte alterado foi o
`untTefEstacaoAplicacao.pas` (18/09 11:47, a mensagem do `.ini` que prometia reescrita que não
acontecia), e essa unit só entra no atualizador. **`libTefCitel.dll` e `TefEstacaoService.exe`
estão em dia.**

### O que está pronto e validado em campo

| Item | Evidência |
|---|---|
| Canal DVC dedicado (Fase 6.1) | **149,1 s → 4,9 s**, mesmo arquivo de 9,7 MB, mesma estação (17/09) |
| Fallback sem a DLL nova | `caminho LENTO - canal "TefCitelUpd" nao abriu (erro 31)`, transferência completa |
| Arbitragem entre dois autcom | `NAO sera transferido por este autcom - o pid=N esta transferindo` (17/09 16:08 e 16:16) |
| Troca do `TefEstacaoService.exe` | 1 MB em 531 ms, serviço de volta, transação OK 100 s depois |
| Pacote `libtefcitel` | 22 MB em 9,33 s (17/09 17:13) |
| Pilha CliSiTef | `clisitef` 11,5 MB em 7,17 s + os dois `.ini`, transação OK depois (18/09 11:17) |
| Granularidade por hash | só o `CONFITLS.ini` de 114 bytes atravessou quando só ele mudou |
| Cascata do RF33 | os dois `.ini` vindos de `<CFG_PTTFCT>\<TFC_NUMTER>\` (18/09 12:04) |
| Espera do processo sair | `processo do servico saiu 0 ms depois do SCM dizer STOPPED`, em toda bateria |
| Mitigação do Scope | `pSair` honrado, `fPassarCartao` voltando (16/09 15:10) |

### PENDÊNCIAS DE TESTE, em ordem de importância

1. **C.7 — atualizador ausente ou bloqueado.** Deixou de ser item de bateria e virou **requisito de
   produção**: em 17/09 16:21 o Bitdefender detectou o `TefEstacaoAtualizador.exe` como
   `ATC.SuspiciousBehavior.BED937AA792DFDB0`, mas com **"Nenhuma ação tomada"** (política em modo de
   relato). Numa loja com ATC bloqueando, o processo morre. Teste: renomear o `.exe`, subir o
   autcom, confirmar que o serviço registra a instalação incompleta, nada é aplicado e **o TEF opera
   normalmente** (RN31). É o que garante a loja, e é barato.
2. **A outra metade da cascata do RF33.** Em 18/09 os dois `.ini` estavam na subpasta do terminal.
   Falta o ramo `"NAO estava na pasta do terminal - caiu para a pasta do autcom.exe"` — que é
   provavelmente o caso mais comum em campo (loja com `CFG_PTTFCT` que não criou a subpasta de algum
   terminal). Teste: apagar um dos `.ini` da subpasta e subir o autcom.
3. **A.2 — os quatro comentários preservados no `.ini`.** Não é verificável por log. Fecha
   comparando o `CliSiTef.ini` de origem com o gravado em `C:\TEF_Citel`: só as linhas de caminho
   podem diferir. O `fAjustaCaminhosIni` promete preservar comentário, ordem, espaçamento em torno
   do `=` e o terminador de cada linha, inclusive arquivo com CRLF e LF misturados — é a parte mais
   delicada do requisito e nunca foi conferida byte a byte.
4. **Critérios 4, 5 e 6 da spec §12.3**: serviço sem a porta 47992 (cai no lento), canal derrubado
   no meio da transferência, pacote corrompido barrado pelo checksum.
5. **Itens do Passo 6 ainda intocados**: A.1, A.5, B.3, C.1, C.2, C.3, C.4.

### RESÍDUOS TÉCNICOS que atravessam o requisito

- **`UnLoadDLLFunctions` não devolve referência nenhuma** (`untScopeNCR.pas:784`). O
  `FunctionDetect` faz `LoadLibrary` 51 vezes sem `FreeLibrary`; o unload faz um par
  `LoadLibrary`/`FreeLibrary`, saldo zero. Decisão de 16/09: **não tocar** — é o núcleo legado do
  TEF, e a espera pelo processo sair tornou o vazamento irrelevante para o atualizador.
- **O re-login da RF29 nunca dispara depois de uma atualização.** O `FintServicoReiniciou` só é
  levantado pelo `reata`, e o `reata` só é enviado quando o **canal DVC** cai — o que não acontece
  no reinício do serviço. Com o `instanciaServico` agora na resposta do `fAtuConsulta`, o caminho
  para resolver ficou curto, mas mexe no fluxo de transação.
- **`FblnSaiu`** (`untTefCitelNCR.pas:32`) é atribuído em dois pontos e **nunca lido**. Quem cancela
  de verdade é o `FintContinua := -1`. Campo morto que atrapalha a leitura.
- **A mitigação do Scope é PROVISÓRIA** (`untTefCitelNCR.pas`, ramo `SCO_CARTAO_DIGITADO`). Sai
  quando o suporte do Scope corrigir a versão nova, que ao receber Cancelar durante a coleta cai em
  digitação manual (`0xFC85`) em vez de abortar a transação. Detalhe para o chamado com o
  fornecedor no `record.md` (seção do teste A/B de 16/09), com a sequência do `ScopeTrc.txt`. **As
  duas versões reportam `ScopeOpen -> Versao = 4.1.2`** — quem abrir o chamado não vai conseguir
  identificar a build pelo que o próprio Scope informa.

- **Falso positivo do antivírus** a levar ao fornecedor:
  `ATC.SuspiciousBehavior.BED937AA792DFDB0` em `C:\TEF_Citel\TefEstacaoAtualizador.exe`.
- **A transferência não é barrada por ocupação**, só a aplicação. O `fAtuAplica` exige estação
  ociosa; o `pAtuAbre`/`pAtuParte` não. Já foi observado 9,7 MB atravessando durante uma coleta de
  cartão (16/09 e 17/09). Com o canal rápido a janela caiu de 149 s para 5 s, mas a assimetria
  continua sendo omissão, não escolha registrada.

### PARA O INSTALADOR — o que já se sabe

O material existe em `libTefCitel\Estacao\install\`: `install-service.ps1`, `register-plugin.ps1`,
`unregister-plugin.ps1`, `uninstall-service.ps1`. O pacote é uma **pasta única e flat** — o
`pExtraiZip` ignora entrada com subpasta, de propósito.

Três coisas que devem entrar no desenho desde o começo, todas aprendidas nesta sessão:

1. **Bitness.** A DLL de plug-in precisa casar com o processo do cliente RDP: Win64 no `mstsc`
   padrão do Windows moderno, Win32 se a estação usar cliente de 32 bits. Valem para as **duas**
   DLLs (`TefCitelDvcPlugin.dll` e `TefCitelDvcUpdate.dll`).
2. **Antivírus.** O `TefEstacaoAtualizador.exe` é detectado por comportamento (para serviço pelo
   SCM, sobrescreve `.exe` em diretório de programa, sobe serviço). Num instalador distribuído,
   **assinar o executável provavelmente deixa de ser opcional**, e vale abrir o falso positivo com
   o fornecedor.
3. **O que ainda é cópia manual.** Só `TefEstacaoService.exe`, `TefEstacaoAtualizador.exe` e
   `TefCitelDvcUpdate.dll` — e os dois primeiros já viajam pelo pacote `servico`. A
   `libTefCitel.dll` saiu dessa lista em 17/09.

**Atenção na virada:** o registro do plug-in de volume é **opcional** por desenho
(`register-plugin.ps1` avisa e segue se a DLL faltar), e a sessão RDP precisa ser **reconectada**
para o plug-in carregar. Sem isso tudo cai no caminho lento — que funciona, só é lento.

---

## Sessão de 2026-09-18, tarde — a revisão dos textos das mensagens ao usuário

### Por que esta sessão existiu

Antes de entrar no instalador — que era o próximo tema no `PONTO DE PARADA` do meio-dia — o Rafael
pediu uma coisa que não estava em nenhuma fase do plano: **revisar todas as mensagens que o
requisito coloca na frente de alguém**, mirando dois leitores ao mesmo tempo, o operador leigo e o
próprio suporte.

O pedido é pequeno em diff e grande em alcance: as mensagens são a única parte deste requisito que
a loja realmente vê. Todo o resto — canal DVC, arbitragem de pinpad, atualização de arquivos — só
aparece para o usuário quando dá errado, e o que ele lê nesse instante decide se ele repete a
operação, chama o suporte ou faz as duas coisas erradas.

### O inventário: onde cada mensagem realmente aparece

Levantar isso foi metade do trabalho, porque "mensagem" neste requisito tem quatro caminhos
diferentes até a tela, e eles não se parecem no código:

| Caminho | Como chega | Onde nasce |
|---|---|---|
| Barra de progresso da carga | `pProgresso` → callback `stdcall` → `pStatusCargaTefCitel` (untPrincipal) → a MESMA `pgbProgresso` da carga do TEF | `untTefCitelDvcAtualizacao.pas` |
| Modal que desabilita o TEF | `pMensagemOk` com `VS_ExibirMensagemStayOnTop` | `untTefCitelUtil.pas` (+ 1ª linha vinda da DLL) |
| Negativa no meio da venda | `pNotificaNegativa` monta um `IRetornoTEFCitel` com `strStatus='500'` → observer → `pMsgInfo500` → `fMensagem('ATENÇÃO!', ..., ['&Ok'])` | `untTefCitelDvc.pas` |
| Exceção crua | sobe até o diálogo de erro genérico | `untTefCitelDvc.pas`, `untTefCitelDvcTransporte.pas` |

**O detalhe que só aparece lendo o `except`:** apenas `ETefCitelDvcCanal` e sua descendente
`ETefCitelDvcServicoIndisponivel` são convertidas em negativa amigável (em `pNotificaCanalCaiu`).
`ETefCitelDvcRpc`, `ETefCitelDvcLoginNecessario` e `ETefCitelDvcTransporte` **escapam com o texto
técnico**, incluindo o nome do método RPC entre aspas. São 11 textos nessa situação, listados no
bloco F do arquivo de trabalho.

### O achado que mudou o alcance: acentuação

Tudo que nasce dentro da `libTefCitel.dll` estava **sem acento** — resíduo de como as units foram
escritas (a acentuação em `.pas` é perigosa nesta base, ver a lição de ferramenta abaixo). Isso
passava despercebido no log, mas não na tela: o modal B1 emenda uma frase da DLL com uma do
autcom, e o operador lia

> O servico de TEF da estacao foi reiniciado ... **O AUTCOM vai abrir com o TEF DESABILITADO.
> Verifique se o serviço TefEstacaoService está em execução na estação**

metade quebrada, metade certa, no mesmo balão.

### A pergunta que precisava de resposta antes de acentuar

Duas das mensagens (D1 e D3) **nascem na estação** e atravessam o canal DVC como JSON. Antes de
pôr acento nelas eu precisava saber se sobreviviam à viagem — e aqui havia motivo real para
desconfiar, porque `TJSONAncestor.ToJSON` (System.JSON.pas do Seattle, linha 1033) faz:

```pascal
SetLength(LBytes, ToBytes(LBytes, 0));
result := TEncoding.Default.GetString(LBytes);   // <- ANSI sobre o que ToBytes produziu
```

Se `ToBytes` emitisse UTF-8, isso seria a armadilha clássica de dupla codificação: os bytes UTF-8
seriam lidos como Windows-1252 e "estação" viraria "estaÃ§Ã£o" antes mesmo de o transporte chamar
`TEncoding.UTF8.GetBytes`.

**Não é o caso, e o motivo está em `TJSONString.ToBytes` (linha 1471):** todo caractere `< 32` ou
`> 127` sai escapado como `\uXXXX`. O JSON gerado é **ASCII puro**, então o `TEncoding.Default`
acima é inofensivo, o `TEncoding.UTF8.GetBytes` do transporte não muda nada, e o
`ParseJSONValue` do outro lado remonta o caractere certo.

Fica registrado porque é exatamente o tipo de dúvida que alguém vai levantar de novo ao mexer em
mensagem que atravessa o canal — e a resposta não está em lugar nenhum além do fonte da RTL.

### O método de trabalho: um arquivo de perguntas, respondido pelo Rafael

Em vez de decidir a redação sozinho, gerei um `mensagens-revisao.md` com as 22 mensagens
inventariadas, cada uma com o texto de hoje, uma sugestão minha e três caixas de decisão, mais uma
seção de **5 decisões gerais** que valiam para blocos inteiros. O Rafael respondeu o arquivo e
devolveu.

Decisões gerais (são elas que mandam):

| # | Pergunta | Decisão |
|---|---|---|
| 1 | Acentuação | **Corrigir todas** as mensagens de tela |
| 2 | "terminal" ou "caixa"? | **"terminal 003"** |
| 3 | PID na tela | **Tirar da tela, manter no log** |
| 4 | Como citar o serviço | **Manter o nome técnico** `TefEstacaoService` |
| 5 | Verbo para o operador | **Manter "Verifique se o serviço..."** |

Por bloco: A1–A8 e B1–B2 e C1–C3 e D1–D4 e E1 seguiram a sugestão; A9 e G2 mantidos; G1 sem
marcação, tratado como mantido pela regra do próprio arquivo; **bloco F: deixar como está**.

### Os dois conflitos entre aprovação de bloco e decisão geral

Aconteceu o que o arquivo previa: o Rafael aprovou sugestões minhas que contradiziam as gerais que
ele próprio marcou. Resolvi **sempre a favor da geral** — é o que o documento declarava que elas
fazem — e avisei:

1. **D1–D4 diziam "caixa"** nas sugestões aprovadas, mas a geral 2 escolheu "terminal". Ficou
   "terminal".
2. **B1, B2 e C1 trocavam "Verifique se o serviço..." por "Acione o suporte..."**, mas a geral 5
   mandou manter. Consequência concreta: **`untTefCitelUtil.pas` não foi tocado**, e o B2 ficou
   idêntico ao que já era. O B1 melhorou mesmo assim, porque a 1ª linha (que vem da DLL) ganhou
   acento e parou de emendar com a segunda.

Um desvio meu, deliberado: onde a sugestão aprovada trazia travessão (`—`), gravei hífen. O
travessão existe no cp1252 (`0x97`), mas é o tipo de caractere que quebra se alguma máquina
compilar com outra codepage ANSI, e ali não muda o sentido.

### O que foi alterado, ponto a ponto

18 substituições, 4 units:

| Unit | O quê |
|---|---|
| `libTefCitel\untTefCitelDvcAtualizacao.pas` | `fEtapaFinal` (4 desfechos), os 3 `pProgresso` de texto fixo, os 3 pontos de "Enviando ...", a mensagem `TEF_ATU_RET_SEM_VOLTA`, e a **nova `fRotuloPacote`** |
| `libTefCitel\untTefCitelDvc.pas` | `pRefazTefSeServicoReiniciou` (C3), `pNotificaCanalCaiu` (C1 e C2), `fResolveDisputaPinpad` (D2 e a pergunta D4) |
| `libTefCitel\Estacao\untTefEstacaoRoteadorMensagens.pas` | `pGarantePinpadConfigurado` (D1), o `raise ETefEstacaoPinpadOcupado` de pendência (D3a), o `raise ETefEstacaoPinpadContestavel` (D3b) |
| `padra_atualizado\fontes\configuracoes\untCfgRepositorio.pas` | descrição do `CFG_TEFDVC` |

**`fRotuloPacote`** é a única mudança que não é texto: o nome do pacote (`scope`, `clisitef`,
`servico`, `libtefcitel`, `*.ini`) é **chave de protocolo** — valor do campo `"pacote"` no RPC,
chave no arquivo de versão da estação e o termo pelo qual se procura no log dos dois lados. Ele
não podia virar rótulo bonito. A tradução vive só na borda da tela, e o `else` devolve o nome cru,
para que um pacote novo apareça como antes e nunca em branco.

**Os PIDs saíram do texto e não da apuração:** `FdwPidDetentor` continua sendo transportado no erro
estruturado e continua em todas as linhas de log dos dois lados. Conferi, antes de remover, que os
dois `raise` da estação já registram o pid via `pLogaEstacao` logo acima — nenhuma informação de
suporte se perdeu.

### Lição de ferramenta: como se escreve acento em `.pas` nesta base

O hook de encoding não dispara na extensão do VSCode, e Edit/Write já corromperam acentuação
pré-existente em pontos distantes da linha tocada (registrado em 2026-09-08). Acentuar 18 pontos
em 4 arquivos com Edit seria repetir o erro em escala.

**O que funcionou:** um script Python que opera em **bytes**, codificando cada literal em cp1252
antes de procurar e substituir. Nenhum byte fora do trecho trocado é decodificado, então não há
como corromper o que não se está mexendo. Cada par exigia **exatamente uma ocorrência**; qualquer
divergência abortava tudo **antes** de escrever qualquer arquivo — o que também prova que nenhuma
dessas mensagens estava duplicada em outro ponto.

Isso vale para qualquer acerto de texto acentuado nesta working copy, não só para este.

### Verificação (o que foi conferido, e como)

- Os 4 arquivos continuam decodificáveis em cp1252, **zero** byte indefinido (`0x81 0x8D 0x8F 0x90
  0x9D`), **zero** LF solto — CRLF preservado.
- Não-ASCII: `0 → 42`, `0 → 43`, `1 → 15` nas units novas (exatamente os acentos inseridos) e
  `18344 → 18341` no `untCfgRepositorio.pas`.
- `svn diff` do `untCfgRepositorio.pas` (2,7 MB): **2 linhas**, e as linhas vizinhas acentuadas
  ("Habilitar PIX...", "verificação inicial...", "Mensagem Padrão...") intactas.
- As três units novas são `A` no SVN, então `svn diff` mostra o arquivo inteiro e não serve. Foram
  conferidas por `diff` contra o backup `456190_20260918_1555`, feito minutos antes da alteração:
  **só os trechos pretendidos**.
- As 77 linhas novas têm aspas balanceadas; contagem de `%s`/`%d` conferida contra a lista de
  argumentos em cada `Format`/`CreateFmt` alterado.
- **Não foi compilado.** O rebuild é do Rafael, pela IDE.

### O que ficou deliberadamente de fora

- **Bloco F — as 11 exceções técnicas que chegam à tela.** Decisão do Rafael: deixar como está.
  Continuam subindo com o texto de desenvolvedor, nome do método RPC incluído. Se um dia incomodar,
  o ponto de entrada já é conhecido: `pNotificaCanalCaiu` hoje só trata `ETefCitelDvcCanal`;
  ampliar o `except` de `fPassarCartao` e companhia para `ETefCitelDvcRpc` cobriria o grosso.
- **`untTefCitelUtil.pas`** — intocado, por consequência da decisão geral 5.
- **G1** ficou sem marcação no arquivo respondido e foi mantido.

---

## PONTO DE PARADA — 2026-09-18, 16:05 (textos revisados; instalador segue sendo o próximo)

> **Superado em 2026-09-19 09:10 quanto a build e backup** — ver o `PONTO DE PARADA — 2026-09-19, 09:10` no fim deste arquivo.

> Substitui o `PONTO DE PARADA — 2026-09-18, meio-dia` **apenas quanto a build e backup**. As
> pendências de teste, os resíduos técnicos e o que já se sabe sobre o instalador continuam
> válidos lá e **não** foram duplicados aqui.

### PRÓXIMA SESSÃO — começar aqui

**Nada continua commitado.** Commit único no fim, `Req. 456190` na primeira linha e token do
DelphAI. Último backup: **`_backups\456190_20260918_1602\`** (sha256 sem divergência; o de
`..._1555` é o estado imediatamente ANTES da revisão de textos, e serve de baseline para conferir
o que mudou).

**O rebuild deixou de ser só o atualizador.** A revisão de textos tocou units de três binários
diferentes:

| Binário | Por causa de | Estava |
|---|---|---|
| `autcom.exe` | `untCfgRepositorio.pas` (descrição do `CFG_TEFDVC`) | em dia |
| `libTefCitel.dll` | `untTefCitelDvc.pas`, `untTefCitelDvcAtualizacao.pas` | **em dia — não está mais** |
| `TefEstacaoService.exe` | `untTefEstacaoRoteadorMensagens.pas` | **em dia — não está mais** |
| `TefEstacaoAtualizador.exe` | `untTefEstacaoAplicacao.pas` (pendência que veio do meio-dia) | já estava desatualizado |

**Misturar versões é inofensivo aqui**: uma estação com o `TefEstacaoService.exe` antigo e um
autcom novo só devolve as mensagens D1/D3 no texto velho, sem acento. Não quebra protocolo — o
formato do envelope não mudou, só o conteúdo de campos de texto.

**Detalhe bom:** `libTefCitel.dll` viaja no pacote `libtefcitel` e o `TefEstacaoService.exe` no
pacote `servico`. Depois do rebuild, os textos novos chegam às estações **pelo próprio mecanismo
de atualização da Fase 6** — é a primeira vez que ele distribui uma mudança que não é dele.

### O que esta sessão fechou

- As 22 mensagens do requisito inventariadas, revisadas com o Rafael e aplicadas (18 substituições,
  4 units). Ver a seção `Sessão de 2026-09-18, tarde` logo acima para o inventário completo, as 5
  decisões gerais, os dois conflitos resolvidos e o que ficou de fora.
- Confirmado no fonte da RTL que acento **atravessa o canal DVC** intacto
  (`TJSONString.ToBytes` escapa tudo acima de 127 como `\uXXXX`).
- Registrado o método seguro de acentuar `.pas` nesta working copy (script em bytes, cp1252, nunca
  Edit/Write).

### O que NÃO mudou

O instalador continua sendo o próximo tema, com tudo o que o `PONTO DE PARADA` do meio-dia já
levantou sobre ele. A pendência de teste mais importante segue sendo a **C.7 — atualizador
bloqueado pelo antivírus**.

---

## Sessão de 2026-09-19 — três campos novos no TEFCFG, e o primeiro teste de estação sem DVC

### 1. TFC_VERDVC / TFC_UPTDVC / TFC_USODVC

O Rafael criou três colunas em `TEFCFG` e pediu que fossem gravadas **só quando o operador
estiver de fato usando `CFG_TEFDVC = 'S'`**:

| Coluna | O que guarda |
|---|---|
| `TFC_VERDVC` VARCHAR(35) | versão do `TefEstacaoService.zip` usado na última atualização |
| `TFC_UPTDVC` DATETIME | quando foi a última atualização de arquivo para a estação |
| `TFC_USODVC` DATETIME | quando foi o último acesso usando o TEF na estação |

A referência indicada foi o `TFC_VERDLL`, e ela resolveu o desenho: aquele campo é gravado em
`pIniciaTefCitel` por `Edit`/`Post` direto no `qryTefTra`, que é a linha do TEFCFG deste terminal,
carregada no topo do procedure e **aberta durante toda a carga**. Os três campos novos couberam no
mesmo lugar — a atualização DVC roda algumas dezenas de linhas antes, no mesmo procedure.

**Três decisões que valem mais que o código:**

**a) A data/hora do zip é lida no autcom, não devolvida pela DLL.** O `TefEstacaoService.zip` mora
na pasta do `autcom.exe` — a mesma origem que o `fDescobrePacotes` usa do lado de lá. Criar um
export novo para um dado que o host já tem na mão seria mais um acoplamento de versão entre
`autcom.exe` e `libTefCitel.dll`, e o `try/except` do `fAtualizaEstacaoNaCarga` existe justamente
porque dois exports novos já criaram esse acoplamento antes. A função nova é
`fVersaoZipServicoEstacao`, formato `yyyy-mm-dd hh:nn:ss`.

Fica registrado o que ela **não** é: o hash. A identidade de versão de um pacote no protocolo
continua sendo o SHA-256 — 64 caracteres, que não caberiam no VARCHAR(35). O campo é para o
suporte ler, e a data/hora do arquivo responde à pergunta que ele faz.

**b) Só `TEF_ATU_RET_APLICADO` conta como atualização.** `ADIADO` transferiu bytes mas não trocou
arquivo nenhum na estação — o preparo fica para a próxima carga. Datar isso como atualização faria
o `TFC_UPTDVC` mentir sobre o que a estação tem instalado.

**c) `TFC_USODVC` é gravado na CARGA, não a cada transação.** Decisão do Rafael: o campo responde
"esta estação ainda é usada?", e para isso um `UPDATE` em TEFCFG dentro do fluxo de venda seria
caro à toa. Uma gravação por login de operador.

**Onde a gravação foi parar, e por quê:** `TFC_VERDVC` e `TFC_UPTDVC` são escritos **logo após a
atualização voltar**, não junto do `TFC_VERDLL` lá embaixo. Se o `fConfiguraTefCitel` falhar depois,
os arquivos na estação continuam sendo os novos — prender o registro ao sucesso do login do TEF
faria o suporte procurar uma atualização que de fato ocorreu e não está em lugar nenhum.

**Uma nuance do comportamento**, para ninguém estranhar: se numa carga o pacote `servico` não
precisou ser enviado (o hash já batia) mas outra coisa foi aplicada, o `TFC_VERDVC` é gravado
mesmo assim com a data do zip atual. Está correto — a estação **está** com aquele zip, e foi o
hash que confirmou.

### 2. O SELECT escopado, e por que isso não é detalhe

As três colunas precisam estar no `SELECT` de `pCarregaDadosTerminal` para o `Edit`/`Post`
alcançá-las. A primeira versão as pôs lá incondicionalmente, e isso estava errado por um motivo
que só aparece pensando em campo: **uma base que ainda não rodou o `ALTER TABLE` deixaria de
carregar o TEF em TODO terminal** — inclusive os que nem usam DVC, que hoje são a maioria.

Ficou dentro de `if fCfgSis('TEFDVC', varString) = 'S'`. Assim a exigência do ALTER acompanha
exatamente quem ligou a configuração nova, e é a mesma `fCfgSis` que decide gravar — as duas
pontas não têm como divergir.

**Pendência:** o DDL que o Rafael passou traz `DATATIME`, que não existe no MySQL. Se os ALTER
rodaram como escrito, falharam. O tipo é `DATETIME`. Não deu para conferir no banco: as variáveis
`MYSQL_PRG_USER`/`MYSQL_PRG_PASS` não estão definidas nesta máquina (conferidos os dois escopos,
ambos vazios) e a skill de banco manda parar nesse caso, não pedir credencial no chat.

### 3. O crash da estação sem DVC — que não era access violation

O Rafael testou de propósito numa máquina **sem o plug-in DVC instalado**, com o terminal
configurado, e trouxe o relatório do madExcept descrevendo-o como access violation. Não era:

```
exception class   : ETefCitelDvcTransporte
exception message : Nao foi possivel abrir o canal DVC "TefCitelCh" (erro 31)...
main thread:
  untTefCitelDvcTransporte  1058  TTefCitelDvcTransporte.pAbreCanal
  untTefCitelDvcTransporte  1009  TTefCitelDvcTransporte.Create
  untTefCitelDvc            1196  TTefCitelDvc.Create
  untFuncoesLibTefCitel       58  fCriarTefCitel
  untTefCitelUtil           1050  pIniciaTefCitel
```

Era o **item 6 do bloco F** da revisão de mensagens de 18/09 — o bloco que o Rafael decidiu deixar
como está. O campo cobrou o preço em menos de um dia.

**Por que o guarda existente não pegou.** Logo abaixo do `fCriarTefCitel` sempre houve um
`if not Assigned(objTefCitel)` com mensagem e saída limpa. Ele nunca teve chance: com
`CFG_TEFDVC = 'S'` o canal é aberto **dentro do construtor**, então a exceção sobe por cima de um
guarda que só existiria para um retorno nulo. Erro 31 é o Windows dizendo que o canal não existe
naquela sessão — plug-in cliente não registrado.

**A correção** é a mesma degradação que a unit já aplica para CNPJ do Scope divergente, DLL sem o
evento TEFTRA e serviço da estação parado: `try/except` em volta do `fCriarTefCitel`, TEF
desabilitado, mensagem ao operador mandando acionar o suporte.

Duas coisas deliberadamente **fora** da correção:

- **O caminho clássico (`CFG_TEFDVC = 'N'`) não mudou** — ali o `except` faz `raise` e a exceção
  sobe como sempre subiu. Engolir falha em código que roda em toda loja esconderia defeito para
  não ganhar nada.
- **Não há queda para o TEF em processo.** O pinpad está fisicamente na estação; rodar dentro do
  autcom falaria com a porta COM do SERVIDOR. Sem canal não há TEF, e dizer isso é melhor que
  fingir.

**Irmão do mesmo defeito, NÃO corrigido:** `fInstanciaPixTef` chama o mesmo `fCriarTefCitel` sem
proteção e vai estourar igual numa estação sem plug-in. Ficou de fora porque o contrato daquela
função é propagar (o `except` dela faz `Result := nil; raise;`) e quem trata é o
`untTPixTefBridgeAutcom` — mudar isso é decisão de desenho do caminho PIX, não consequência
automática deste conserto.

### 4. O balão cortado, e o que ele ensina sobre `pMensagemOk`

A mensagem nova apareceu **cortada em cima e embaixo**: o operador leu o miolo, sem a primeira
linha (escondida atrás da barra de título "AVISO") e sem o `Detalhe:`. A hipótese do Rafael era um
`#13#10` a mais.

Não era. `pMensagemOk` chama `fMensagem` com **`blnAutosize = False`** — altura fixa. Uma mensagem
de três blocos rende ~9 linhas e o balão padrão comporta ~3, então corta dos dois lados. O sinal
que separa uma coisa da outra é o `Detalhe:` ter sumido inteiro: um Enter a menos não explicaria
isso.

O projeto já resolve passando tamanho explícito (`pMensagemOk(strErro, 600, 250)` e vários
outros). Dimensionadas as **três** mensagens de degradação do TEF DVC, porque todas têm a mesma
estrutura de três blocos e o mesmo defeito latente:

| Mensagem | Tamanho |
|---|---|
| Canal DVC ausente | `700, 320` |
| Serviço parado no login | `700, 320` |
| Serviço não voltou da atualização | `700, 260` |

Os números são estimativa por largura de linha e contagem — não há como renderizar o balão fora do
autcom. Confirmados em tela pelo Rafael no mesmo dia ("ficou ótimo").

### 5. Teste validado

**Estação sem o canal DVC instalado, terminal configurado** → o AUTCOM abre com o TEF
DESABILITADO e uma mensagem que diz ao operador para acionar o suporte, em vez do diálogo do
madExcept. Registrado como **C.8** no `tasks.md`.

É um caso que não estava na lista de pendências e deveria estar desde o começo: é exatamente o que
acontece numa loja onde o instalador rodou pela metade — e o instalador é o próximo tema.

### 6. O PIX cobrou o C.9 no mesmo dia

Poucas horas depois de o C.9 ser aberto, o Rafael foi testar PIX na mesma máquina sem plug-in e
trouxe duas coisas.

**A primeira, um crash** — de novo descrito como access violation, e de novo não era: a mesma
`ETefCitelDvcTransporte` erro 31, agora por

```
btnAssocChavePixScopeClick -> fConsultaDadosPixScope (untCadCCa:1200)
  -> fRetornaDadosBandeiraRedePixScope (untTefCitelUtil:2508)
    -> fInstanciaPixTef (untTefCitelUtil:1479) -> fCriarTefCitel
```

Exatamente o C.9. **Corrigido** fazendo `fInstanciaPixTef` devolver `nil` + `AMensagem` em vez de
propagar, no caminho DVC. Não foi preciso tocar em mais nada: `fRetornaDadosBandeiraRedePixScope`
já sai pelo `AMensagemErro`, o `untCadCCa` já registra em log e exibe, e
`TPixTefBridgeAutcom.fInstanciaTefCitel` cai no MESMO `Exit(False)` de antes. A correção usa o
contrato que a função já tinha para "Código Loja não informada" e afins.

**Detalhe que mudou o texto:** quem exibe essa mensagem é um `fMensagem` comum, sem tamanho
explícito — e `fMensagem` também nasce com `blnAutosize = False`. Uma mensagem de três blocos
apareceria cortada, como o balão da carga apareceu horas antes. Por isso o texto foi curto e o
detalhe técnico foi para `pGravarErroTef`.

**A segunda, uma mensagem genérica no Resumo de Caixa:** *"O recebimento do Pix por QR Code não
foi realizado. Assim o registro do Pix não foi gerado."* Essa não é crash — o caminho da venda
sempre teve `try/except` (`TPixTefBridgeAutcom.fInstanciaTefCitel`). O que se investigou e vale
registrar:

- a ponte **captura** a razão e guarda em `FMensagemErro` (constructor, linha 84);
- `FMensagemErro` **é lido** (linhas 144 e 304) e vai para `ARetorno.Mensagem`;
- em `untRcxResumoCaixa` a mensagem genérica só aparece no ramo em que
  `VerificaPixComStatusConcluidoEComValorPago` devolve False **sem** erro de requisição — o ramo de
  erro levanta `ExceptionAutcom` com o texto de verdade.

Ou seja: a razão existe e trafega, mas naquele desfecho específico ela não é o que decide a
mensagem. Onde exatamente ela se perde entre `ARetorno.Mensagem` e o
`RetornaMensagemErroRequisicao` **não foi determinado** — exige o JSON de retorno daquela
tentativa, que não está no relatório do madExcept. Fica como ponta solta, e deliberadamente sem
palpite: o caminho do PIX é subsistema de outro requisito.

**Reteste — VALIDADO em 19/09 pelo reteste.** O botão "Assoc. Chave Pix Scope" na estação sem plug-in
passou a mostrar a mensagem pedindo para acionar o suporte, sem madExcept. Com isso os
dois caminhos que instanciam o TEF — a carga do operador (`pIniciaTefCitel`) e o PIX via
Scope (`fInstanciaPixTef`) — degradam do mesmo jeito quando o canal da estação não está
instalado.

**Lição de processo desta sessão:** o script que registrou a sessão no `record.md` e no `tasks.md`
foi reexecutado por engano dentro de um comando composto e duplicou as duas seções. O estrago foi
desfeito restaurando os dois arquivos do backup `456190_20260919_0918`, tirado minutos antes — e
a partir daí os scripts de registro passaram a checar uma marca do próprio conteúdo antes de
escrever. Script que edita arquivo versionado precisa ser idempotente, não só correto na primeira
execução.

---

## PONTO DE PARADA — 2026-09-19, 09:10 (campos do TEFCFG + estação sem DVC; PIX em teste)

> **Superado em 2026-09-19 10:10** — ver o `PONTO DE PARADA — 2026-09-19, 10:10` no fim deste arquivo.

> Substitui os dois anteriores de 18/09 **quanto a build e backup**. As pendências de teste, os
> resíduos técnicos e o que já se sabe sobre o instalador seguem no `PONTO DE PARADA` do
> **meio-dia de 18/09** e não foram duplicados aqui.

### PRÓXIMA SESSÃO — começar aqui

**Nada commitado.** Commit único no fim, `Req. 456190` na primeira linha e token do DelphAI.
Último backup: **`_backups\456190_20260919_0908\`**.

**Rebuild pendente: só o `autcom.exe`.** Tudo desta sessão está em
`padra_atualizado\fontes\tef\TefCitel\untTefCitelUtil.pas`. `libTefCitel.dll`,
`TefEstacaoService.exe` e o plug-in Win64 foram recompilados pelo Rafael em 18/09 à noite e estão
em dia — os textos revisados já estão neles. O plug-in **Win32** segue desatualizado desde 10/09;
o que roda é o Win64.

**O caminho do PIX foi testado e fechado no mesmo dia.** O C.9 — `fInstanciaPixTef`
chamando o mesmo `fCriarTefCitel` sem proteção — apareceu em campo às 09:21 pelo botão
"Assoc. Chave Pix Scope", foi corrigido e **validado no reteste**. Os dois caminhos que
instanciam o TEF degradam igual agora.

**Ponta solta que sobrou do PIX:** no Resumo de Caixa, a mensagem genérica "O recebimento do
Pix por QR Code não foi realizado" não carrega a razão, embora a razão exista e trafegue até
`ARetorno.Mensagem`. Fechar isso exige o JSON de retorno de uma tentativa — ver a seção 6 da
sessão de 19/09.

### O que esta sessão fechou

- **Três campos novos no TEFCFG** (`TFC_VERDVC`, `TFC_UPTDVC`, `TFC_USODVC`), gravados na carga
  somente com `CFG_TEFDVC = 'S'`. Desenho, decisões e nuances na seção
  `Sessão de 2026-09-19` logo acima.
- **C.8 validado** — estação sem o canal DVC instalado agora degrada com mensagem em vez de
  madExcept.
- **Os três balões de degradação do TEF DVC dimensionados** (`pMensagemOk` não faz autosize).

### Pendência que nasceu hoje

**O DDL precisa ser conferido no banco.** O que foi passado traz `DATATIME`, que não existe no
MySQL — o tipo é `DATETIME`. Se os `ALTER TABLE` rodaram como escritos, falharam, e a falha só
aparece na primeira carga com `CFG_TEFDVC = 'S'`:

```sql
ALTER TABLE TEFCFG ADD TFC_VERDVC VARCHAR(35);
ALTER TABLE TEFCFG ADD TFC_UPTDVC DATETIME;
ALTER TABLE TEFCFG ADD TFC_USODVC DATETIME;
```

Não deu para conferir daqui: `MYSQL_PRG_USER`/`MYSQL_PRG_PASS` não estão definidas nesta máquina.
Para habilitar, o Rafael roda no PowerShell dele e reinicia o Claude Code:
`python ".claude\scripts\autcom_db.py" --profile prg --configurar`.

### O que NÃO mudou

O instalador continua sendo o próximo tema, e a pendência de teste mais importante segue sendo a
**C.7 — atualizador bloqueado pelo antivírus**.

---

## Sessão de 2026-09-19, fim da manhã — o desenho do instalador da estação

Entrada: o instalador era o próximo tema desde 18/09. O Rafael pediu o **desenho** agora e a
implementação depois, e deu cinco pontos de partida — sem trava de sistema operacional mas
preparado para ela, pasta sugerida `C:\Tef_Citel`, opção de desabilitar o UDP do RDP (desmarcada
por padrão, porque o processo será feito pelo servidor), exclusão da pasta no Defender, e o
instalador deixando "o básico funcionando" para o primeiro login do autcom trazer o resto.

**O desenho vive em `IA\specs\456190\instalador-desenho.md`** — arquivo de trabalho, não é um dos
cinco gêneros, e **não foi apagado**: ele é o que falta dobrar em seção do `specs.md` (contrato) e
do `plans.md` (plano técnico), com checklist no `tasks.md`. Era o passo seguinte quando a sessão
acabou.

### Decisões do Rafael

| Tema | Decisão |
|---|---|
| Tecnologia | **Inno Setup** |
| Usuários Windows na estação | **pode haver vários** |
| Modo de execução | **atendido, com tela** (silencioso é secundário) |
| Antivírus | **exclusão no Defender sim**; assinatura digital e detecção de AV de terceiro, não agora |

### Quatro achados do fonte, todos levantados antes de desenhar

1. **O registro do plug-in é UM valor de registro.** `DllRegisterServer`
   (`TefCitelDvcPlugin.dpr:63`) não registra CLSID nem type library — escreve
   `AddIns\TefCitelCh\Name = <caminho da DLL>` e mais nada. **`regsvr32` é dispensável**: o Inno
   grava direto. Um processo a menos para o antivírus olhar e um código de erro a menos para
   traduzir.
2. **Os dois listeners da estação são loopback** (`127.0.0.1`, em
   `untTefEstacaoTcpTransporte.pas:915` e `untTefEstacaoUpdateListener.pas:162`). **Não há regra
   de firewall** no instalador — e isso precisa estar escrito, porque "instalou serviço, logo
   precisa de exceção" é o reflexo de quem revisa.
3. **O cliente TSPlus é de 32 bits** (`TSPLClient.dll` em `Program Files (x86)`). Isso derruba o
   default `Win64` dos `.ps1` atuais: bitness virou decisão automática do instalador, com TSPlus
   detectado na frente da regra do `mstsc`.
4. **Windows 7 RTM tem PowerShell 2.0**, onde `Add-MpPreference` não existe. Um instalador
   apoiado nos `.ps1` atuais não cumpriria o piso pedido — foi o argumento decisivo para o Inno
   Setup, cujo runtime não depende de PowerShell nem de .NET.

### A correção que mais importa registrar: HKLM não serve

Eu afirmei, com a palavra "decisivo", que o multiusuário se resolveria gravando em HKLM, apoiado
no que existe nesta máquina:

```
HKLM\...\Terminal Server Client\Default\AddIns
    webauthn    -> C:\Windows\System32\webauthn.dll
    TSPLClient  -> C:\Program Files (x86)\...\TSPLClient.dll
```

**Era indício, não prova.** A documentação da Microsoft sobre registro de plug-in DVC lista uma
única raiz, e é `HKEY_CURRENT_USER` — HKLM não aparece em nenhum ponto do texto. As duas entradas
acima podem estar sendo carregadas pelo `IMsTscAdvancedSettings::put_PluginDlls`, que a mesma
página descreve como método alternativo e que um cliente próprio usaria com naturalidade.

Fonte: <https://learn.microsoft.com/en-us/windows/win32/termserv/dvc-plug-in-registration>

**Não repetir essa hipótese.** E vale a lição de método: presença de chave no registro prova que
alguém escreveu ali, nunca que o consumidor lê dali.

### O segundo motivo, que sobrevive à correção

Enquanto eu apostava em HKLM não tinha visto isto: **o setup roda elevado**. Se o técnico elevar
com uma conta de administrador diferente da do operador, o `HKCU` do instalador é o da conta do
administrador. A chave nasce no hive errado, **sem erro nenhum**, e o TEF não sobe depois de
reconectar — o modo de falha mais caro que este instalador poderia ter, porque parece sucesso.

Por isso o instalador **não grava em `HKCU`**. Ele resolve o usuário da sessão interativa
(`WTSGetActiveConsoleSessionId` → `WTSQuerySessionInformation` → `LookupAccountName`) e grava em
`HKEY_USERS\<SID>`. Funciona sem montar hive: o de quem está logado já está carregado.

**Efeito prático: logoff nunca é necessário.** Depois de instalar, só reconectar a sessão RDP — que
já era obrigatório, porque o cliente RDP lê o registro ao iniciar.

### O desenho final do multiusuário: duas camadas

| Quem | Como | Quando |
|---|---|---|
| Quem está na sessão em que o suporte instalou | grava em `HKEY_USERS\<SID>` | imediato |
| **Usuário N** e qualquer um que logue depois; perfil recriado; registro apagado | tarefa agendada oculta, gatilho "ao logon de qualquer usuário", rodando `reg add` | no logon dele |

A tarefa usa `reg.exe`, que existe desde o Windows 2000 — **nada de binário novo**, num requisito
que já tem problema de antivírus. Roda como quem logou, então o HKCU é sempre o certo, e é
auto-reparável.

### Duas coisas adiadas conscientemente, e por quê

Ambas nasceram de premissas **minhas** que o Rafael corrigiu com conhecimento de campo. Ficam aqui
porque quem reler o desenho vai se perguntar por que não estão lá.

**1. `reg load` do `NTUSER.DAT` de perfis deslogados.** Eu propus varrer o `ProfileList` e montar
o hive de cada usuário para registrar todos na hora da instalação. Justificativa: uma corrida
entre a tarefa de logon e o cliente RDP — *"se o cliente RDP estiver no Startup dele, pode ler o
registro antes de a tarefa gravar"*. **A premissa do Startup era minha, não do campo.** O fluxo
real é: o usuário loga na máquina local e **depois clica num atalho na área de trabalho** para
abrir o RDP. Segundos ou minutos de folga; a tarefa ganha com sobra.

E o preço era alto: `reg load` sem o `reg unload` correspondente **impede o logon daquele
usuário** — era o único passo do instalador capaz de deixar a máquina pior do que encontrou. Risco
concreto contra cenário hipotético é troca ruim. **Não deve voltar sem que o cenário apareça de
verdade.**

**2. Varrer os SIDs já carregados em `HKEY_USERS`.** Meia medida da anterior, essa sem risco
nenhum (escrita comum em hive já montado). Cobriria o usuário que está logado e **não vai logar de
novo** — troca rápida de usuário, ou sessão desconectada e depois reconectada, que **não** gera
evento de logon e portanto não dispara a tarefa. Adiado por ser improvável nesta operação.

> **Sintoma, se algum dia acontecer:** a estação tem TEF para uns usuários e não para outros, e o
> afetado volta a funcionar sozinho depois de um logoff/logon. O remédio de campo é exatamente
> esse, e é o que o suporte deve tentar **antes** de reinstalar.

### O que o instalador não faz, de propósito

Nada que mude de versão com frequência. DLLs do Scope e do CliSiTef, os três `.ini` e a
`libTefCitel.dll` chegam na **primeira carga do autcom** pelo mecanismo da Fase 6 — que é
justamente para isso que ela existe. Consequência boa para o suporte: estação com o instalador de
seis meses atrás fica em dia sozinha no primeiro login.

### Pontos em aberto, nenhum bloqueante

1. Confirmar `fClientDisableUDP` como nome do valor — fecha na primeira instalação de teste.
2. Onde o `setup.exe` é compilado, e se o `.iss` entra em algum `.groupproj`.
3. Versionamento do instalador para o Adicionar/Remover Programas — proposto: a mesma revisão do
   SVN que o `rev.inc` já carrega.
4. A tarefa agendada e heurística de antivírus de terceiro.
5. **Teste obrigatório do caminho do usuário N**: instalar logado como A, fazer logon como N,
   conferir a chave no HKCU do N, abrir o RDP pelo atalho e passar um cartão. Com a tarefa sozinha
   nesse papel, conferir que ela foi criada não prova nada.

Estimativa de implementação: **450–600 linhas** de `.iss`, **sem nenhuma mudança em Delphi**.

---

## PONTO DE PARADA — 2026-09-19, 10:10 (instalador desenhado; falta dobrar na spec e implementar)

> Substitui o de 09:10 do mesmo dia. As pendências de teste do TEF, os resíduos técnicos e o
> histórico das fases seguem no `PONTO DE PARADA` do **meio-dia de 18/09**.

### PRÓXIMA SESSÃO — começar aqui

**Primeira ação, e é barata:** dobrar o `IA\specs\456190\instalador-desenho.md` em seção do
`specs.md` (contrato) e do `plans.md` (plano técnico), com o checklist no `tasks.md`, e apagar o
arquivo de trabalho. O desenho está **fechado e aprovado em conversa**; o que falta é o registro
nos gêneros certos. Depois disso, implementar o `.iss`.

**Ler antes:** a seção `Sessão de 2026-09-19, fim da manhã` logo acima. Ela tem as decisões, os
quatro achados do fonte, a correção do HKLM (**não repetir aquela hipótese**) e as duas coisas
adiadas com o motivo — que são exatamente as perguntas que alguém refaria.

**Nada commitado.** Commit único no fim, `Req. 456190` na primeira linha e token do DelphAI.

### Pendências que atravessam o dia

| O quê | Estado |
|---|---|
| **Rebuild do `autcom.exe`** | pendente. Tudo de 19/09 está em `untTefCitelUtil.pas`; `libTefCitel.dll`, `TefEstacaoService.exe` e o plug-in Win64 foram recompilados em 18/09 à noite e estão em dia |
| **`DATATIME` → `DATETIME`** nos três `ALTER TABLE` do TEFCFG | não conferido no banco (credenciais do `autcom_db.py` não configuradas nesta máquina) |
| **Resumo de Caixa** — a mensagem genérica do PIX não carrega a razão | ponta solta; exige o JSON de retorno de uma tentativa. Ver a seção 6 da sessão de 19/09 |
| **C.7 — atualizador bloqueado pelo antivírus** | segue sendo a pendência de teste mais importante do TEF |

### Estado da máquina do Rafael

Ele quer a máquina física **limpa** para testar o instalador como primeira instalação de verdade.
Nada deve ser pedido a ele em termos de alteração manual de registro ou de serviço antes disso — o
desenho foi fechado sem depender de nenhum teste prévio, de propósito.

---

## Sessão de 2026-09-20 e 2026-09-21 — a Fase 7 do papel ao campo

Dois dias que começaram com um desenho aprovado e terminaram com o instalador validado numa
estação de verdade, incluindo venda com cartão. No caminho apareceram **sete defeitos**, e nenhum
deles era achável sem instalar em máquina limpa. Esta seção existe para que quem reabrir isto
saiba **por que** cada coisa está como está — o texto curto dos outros arquivos diz o quê.

### O ponto de partida

20/09 de manhã: dobrar o `instalador-desenho.md` em `specs.md` §13 e `plans.md` §12, com checklist
no `tasks.md`, e apagar o arquivo de trabalho. Feito sem novidade. O `.iss` saiu em ~1.100 linhas
e compilou no Inno Setup 6.4.2 da máquina.

Três coisas do desenho não sobreviveram ao encontro com a ferramenta, e estão em `specs.md` §13.8:
`MinVersion=0` (o Inno 6 recusa: ele próprio não roda abaixo do Windows 7 — e 6.1 é exatamente o
piso do canal DVC, então não houve perda), os códigos de saída (o Inno reserva 1/2/3/5/6, e o
"2 = precisa reconectar" do desenho não distinguiria nada porque reconectar é *sempre* necessário),
e o `LookupAccountName` (trocado por casar o nome contra `Volatile Environment\USERNAME` de cada
SID em `HKEY_USERS` — **estritamente mais forte**, porque achar o SID ali prova que o hive está
carregado, que é a condição de que a gravação depende).

### Os sete defeitos, e o que cada um ensina

**1. O impasse de bootstrap do `libTefCitel.dll`** (`specs.md` §13.10). O `pAtualizaContexto`
instanciava a `ITefCitel` real — delay-load de `libTefCitel.dll` — **antes** de despachar qualquer
método. Numa estação recém-instalada essa DLL não existe: por desenho ela chega pelo pacote
`libtefcitel`, que é o `fAtuConsulta` que pede. Então o `fAtuConsulta` morria com
`External exception C06D007E` antes de chegar no próprio handler, e a única chamada capaz de trazer
a DLL precisava dela.

O sintoma apontava para o lado errado: o AUTCOM dizia *"Não foi possível falar com o serviço de TEF
da estação"* e a leitura natural foi falha do atualizador — que nunca chegou a rodar. O
`C06D007E` é o código que o Delphi levanta quando um `external ... delayed` não acha o módulo, e foi
ele que resolveu o caso.

**Nunca apareceu antes porque até a Fase 7 o `libTefCitel.dll` era copiado à mão no preparo.** O
instalador é a primeira coisa que cria uma estação de verdade vazia — revelou o defeito, não o
causou.

Consertado nos dois lados: `fMetodoDispensaTefCitel` no roteador (os cinco métodos da Fase 6 não
instanciam a `ITefCitel`; conferi antes que nenhum deles usa sessão nem `fTefDaThread`, e que todos
os usos pós-despacho estão dentro de ramos de `fPassarCartao`/`fFinalizarTransacao`) e semente do
`libTefCitel.dll` no instalador, com `onlyifdoesntexist`.

**2. Reinstalação por cima** (§13.11). `/install` com o serviço já registrado devolve `1073` e o
`Vcl.SvcMgr` mostra o erro numa **caixa própria**, apesar do `/silent` — que só cala a mensagem de
sucesso. Agora o instalador checa `fServicoExiste` e, existindo, pula o `/install` e reaponta o
`binPath` — sem isso, reinstalar noutra pasta deixaria o SCM apontando para a antiga.

**3. O `libTefCitelErro.log` vinha do servidor** (§13.11). Com DVC quem carrega a DLL é o serviço da
estação, e é lá que o `pLogError` escreve. O AUTCOM lia `CFG_PTTFCT\<TFC_NUMTER>` ou a pasta do
`autcom.exe` — dois caminhos do servidor. RPC novo `fConteudoLogErro`, seis units, espelhado nos
dois lados na mesma sessão.

**4. A estação não se reparava** (§13.13). Teste V.15: apagar o `libTefCitel.dll` e subir o AUTCOM.
O `fAtuConsulta` respondeu (a correção 1 funcionou) mas o AUTCOM **não reenviou** — o
`fHashAplicado` lia só o `TefEstacaoVersao.ini`, escrituração e não observação. Arquivo em
quarentena por antivírus, gravação que falhou depois de marcada, pasta mexida à mão: tudo isso
deixava o ini afirmando que estava lá.

Consertado com `fArquivoQueProva`: a declaração passa a ser conferida contra o disco, e vazio
(que significa "nunca" em todo o arquivo de versão) faz o AUTCOM reenviar — sem protocolo novo e
sem caso especial do outro lado. **Validado em campo: reparação completa em 12 segundos.**

**5. A tarefa de logon piscava console** (§13.15). `.cmd` e `reg.exe` são subsistema CONSOLE;
tarefa na sessão interativa abre janela. Virou o switch `/registraplugin` no
`TefEstacaoService.exe`, que é subsistema GUI e não abre console. A alternativa `wscript` + `.vbs`
oculto foi descartada: um `.vbs` que escreve no registro a cada logon é a forma exata do que
heurística de antivírus procura, e o C.7 está aberto.

O argumento que antes segurava isso — "a Fase 7 não mexe em Delphi" — já tinha caído: mexemos em
sete units ao longo do dia 20.

**6. A tarefa rodava como quem instalou** (§13.17). Este é o mais instrutivo. O
`schtasks /sc onlogon` sem principal cria o **gatilho** para qualquer usuário, mas mantém o
**principal** de quem criou. No logon do usuário N a tarefa disparou, rodou como o instalador e
reescreveu a chave no HKCU **dele**. O usuário N nunca teve o plug-in, e o AUTCOM deu erro 31.

**E a tarefa registrou `LastTaskResult = 0`.** O diagnóstico óbvio dizia "deu certo" enquanto
apontava para o lado errado. Virou a **RN61**: código 0 prova que o processo terminou bem em
*algum* contexto, não que a coisa aconteceu no contexto certo.

Recriada por **XML** com principal = grupo Usuários pelo **SID** `S-1-5-32-545` (o SID não depende
do idioma do Windows) e `LogonTrigger` sem `UserId`. Três coisas vieram junto, e uma importa muito:
`DisallowStartIfOnBatteries`, que o `schtasks` cria como **true** — numa estação que seja notebook,
no primeiro logon fora da tomada a tarefa não rodaria.

**7. O `schtasks /xml` não aceita UTF-8** (`plans.md` §12.24). O `SaveStringsToUTF8File` grava com
BOM e o parser tropeça no primeiro byte. Medido nas quatro formas: UTF-8 com BOM falha em `(1,2)`,
UTF-8 sem BOM falha em "não é possível alternar codificação", **UTF-16LE com BOM** funciona e
**ASCII sem atributo `encoding`** funciona. O Inno não tem helper para UTF-16 e o XML é ASCII puro
— ficou a quarta.

### Hipóteses minhas que estavam erradas, e por que registrá-las

- **O gatilho da tarefa.** Suspeitei que o `/sc onlogon` sem `/ru` amarrasse o **disparador** a um
  usuário. O relatório mostrou o oposto: o disparador estava certo (`sem UserId`) e o **principal**
  é que estava errado. Sem o dado, eu teria "consertado" o lado certo.
- **O `TFC_UPTDVC` em outro fuso.** Levantei que o `fNow()` pudesse estar devolvendo hora de outro
  fuso, porque `20:38:51` estava 3h à frente da atividade que eu conhecia. Era só uma instalação às
  20:35 numa máquina cujos logs eu ainda não tinha visto. **Descartada.**
- **`SWbemObjectSet.ItemIndex`** para enumerar o antivírus por COM: compila e devolve **nulo**.
  Pior: o `except` engolia e a função devolvia vazio — resultado indistinguível de "não há
  antivírus de terceiro". Teria ido para produção parecendo pronta. Trocado por PowerShell
  gravando arquivo, que dá para conferir de fora.
- **`DCC_DllOutput`** — tentei redirecionar a saída de build de DLL **duas vezes** (os plug-ins em
  20/09, a `libTefCitel.dll` em 21/09) e nas duas o artefato foi para a pasta normal do projeto
  assim mesmo. `DCC_ExeOutput` funciona; `DCC_DllOutput` não. Nas duas vezes sobrescrevi artefato
  da IDE com artefato de msbuild.

A hipótese do **UDP** (do Rafael, para o erro 31) foi descartada por um dado e não por argumento:
não havia nenhum `Listener "TefCitelCh" criado` para a sessão nova no log do plug-in. O cliente RDP
lê o HKCU e carrega o plug-in **antes** de qualquer negociação de transporte — sem chave, não há
listener, com ou sem UDP.

### Decisões que não aparecem no texto curto

**Assinatura: certificado autoassinado, e assim fica** (§13.14, opção 3, decisão do Rafael em
21/09). O mecanismo funciona — sete arquivos em SHA-256 carimbados — mas o `mycert.pfx` é
autoassinado (`Subject = Issuer`, válido até 2045). Consequências que precisam ser lembradas antes
de alguém "consertar" o que não está quebrado: **"Editor desconhecido" no UAC é ESPERADO**,
`signtool verify /pa` terminar em "root not trusted" é **esperado**, e **não há ganho de reputação
para antivírus/SmartScreen**. Trocar para CA pública um dia é apontar `CITEL_ASSINA_PFX` para o
novo `.pfx` — nada mais muda.

**A exclusão do Defender não alcança a frota** (§13.16, RN59). Em campo o `Add-MpPreference`
devolveu 1: a estação tem **Bitdefender corporativo**, e com AV de terceiro registrado o Defender
fica passivo. Ou seja: *onde o problema de AV existe, a exclusão do instalador não funciona; onde
ela funciona, o problema não existe.* A RF54 foi desenhada como a mitigação de antivírus do
instalador e é letra morta justamente na frota que tem o problema.

**Isso reformula o C.7.** Ele deixa de ser "testar se o AV bloqueia o atualizador" e passa a ter
ordem: (1) pedir à infra a exclusão de `C:\Tef_Citel` na **política do GravityZone**; (2) confirmar
que chegou na estação; (3) só então testar. Sem o passo 1, o teste mede o AV *sem* exclusão — outra
informação, e pior.

O instalador passou a **detectar** o AV de terceiro (reabrindo, só para a mensagem, o que a §13.5
tinha deixado fora de escopo) e a dizer isso ao técnico em vez de deixar um aviso enigmático.

### Duas lições de método que valem além deste requisito

**Engolir a saída de um programa externo cujo resultado é fatal** troca dez segundos de diagnóstico
por uma viagem à estação. As duas tentativas de criar a tarefa falharam com código 1 e o log só
tinha o número; o motivo estava na saída do `schtasks`, descartada. Virou o `fRodaSchtasks`, que
joga cada linha no `instalacao.log` com prefixo `schtasks:`.

**Mensagem escrita para um cenário acusa defeito noutro.** Aconteceu três vezes com o
`conferir-instalacao.ps1`: `recuperacao NAO configurada` (o `sc qfailure` imprime `REINICIAR` em
pt-BR, não `RESTART`), `Tarefa: NAO EXISTE` (usuário comum não enxerga a tarefa — e isso apareceu
justamente no relatório que **provava** o critério 4), e `plug-in AUSENTE - isto e defeito` num
plug-in corretamente removido pela desinstalação. Os três corrigidos; o terceiro fez o coletor
passar a **reconhecer o estado desinstalado**.

### O que foi validado em campo

Instalação em máquina limpa, reinstalação por cima, atualização pela Fase 6 (dois pacotes numa
carga), TEF carregando (`fConfiguraTefCitel retornou 0`), **cartão passando e finalizando**,
auto-reparação em 12 s quando o `libTefCitel.dll` some, assinatura, detecção do Bitdefender, e o
**V.4**: instalado como `rafael.bizio`, `gislene.nemoto` logou, a tarefa registrou o plug-in no
HKCU dela sozinha, o canal abriu e um cartão passou. **V.9** (desinstalação) confirmado exceto dois
itens que dependem de rodar o coletor elevado.

### Ajuste pontual do fim do dia 21

O `TefCitelDvcTransporte.log` saiu do `%TEMP%` para `<pasta do autcom.exe>\TefLog`, com o **nome da
estação** no nome do arquivo (§13.19). O sufixo é consequência de tirar do `%TEMP%`: numa pasta
única, sem ele, todas as estações gravariam no mesmo arquivo. O nome vem de `CLIENTNAME` — não de
`COMPUTERNAME`, que devolveria o TS. Se o `TefLog` não puder ser criado, o log volta para o
`%TEMP%` em vez de deixar de existir.

---

## PONTO DE PARADA — 2026-09-21, fim do dia

### PRÓXIMA SESSÃO — começar aqui

**Rebuild pela IDE, obrigatório antes de qualquer teste:**

- `libTefCitel.dll` (mudou o `untTefCitelDvcTransporte.pas` — TefLog) **e copiar para
  `padra_atualizado\`**;
- `libTefCitel\Win32\Release\libTefCitel.dll` foi sobrescrito por artefato de **msbuild** — o
  rebuild pela IDE também conserta isso;
- depois, `build-setup.cmd` (com `CITEL_ASSINA_SENHA` definida, se for para publicar assinado).

**Pendências de teste:**

- **V.24** — conferir `<autcom>\TefLog\TefCitelDvcTransporte_<estação>.log`, com o nome da máquina
  do operador no sufixo, e dois arquivos com duas estações;
- **TEFCFG na empresa, com o TEF carregando** — é o que fecha o `TFC_USODVC`. Na máquina sem VPN
  ele fica vazio e **isso está correto**: o `fConfiguraTefCitel` devolve -2, o fluxo sai no
  `pMensagemLogErroTef` (`untTefCitelUtil:1363`) e nunca alcança o bloco que grava o campo;
- **V.9, dois itens** — rodar o `conferir-instalacao.ps1` **elevado** na máquina pessoal já
  desinstalada: confirma a remoção da tarefa e a permanência de `_Preparo`/`_Falhou`;
- **C.7** — depende da infra criar a exclusão no GravityZone.

**Para o comitê e a entrega aos Testers:**

- **nada commitado** — 84 `A` e 2 `M` pendentes, e o commit exige o token do DelphAI;
- o **`analysis.md` está de 10/09** — é o texto que o revisor humano lê, e não acompanhou as Fases
  6.1 e 7;
- os **24 critérios de aceitação estão espalhados** por `specs.md` §13.4, §13.8, §13.9, §13.11,
  §13.13, §13.15, §13.17, §13.18 e §13.19, alguns reescritos no caminho (13 e 14 pelo certificado
  autoassinado, 23 pelo switch). Consolidar numa lista única, com o estado de cada um, é o que a
  entrega aos Testers pede — pelo CLAUDE.md, o entregável de quem implementa é **o contrato e a
  lista de casos**, não os casos.

**Não repetir:** a hipótese de HKLM para o plug-in (`plans.md` §12.2), `DCC_DllOutput` como rede de
segurança em projeto de DLL (§12.25), e `SWbemObjectSet.ItemIndex` para enumerar WMI no Inno
(§12.22).

---

## A trava de 31/08 provavelmente já tem explicação — e não é a que foi registrada (2026-09-21)

Ao remover a instrumentação `TefCitelAutcomTeftra.log`, ficou a pergunta do Rafael: a causa raiz
nunca foi confirmada, e isso incomoda. Vale registrar o que a releitura dos próprios documentos
mostra, porque muda o tipo de conclusão que dá para levar ao comitê.

### O sintoma, como foi anotado em 31/08

Trava **intermitente** numa venda com **2+ cartões**, no **último cartão**, ficando **presa na tela
do autcom sem gerar o TEFTRA**. Hipótese registrada na época: `fRetAutoIncrem('TEFTRA', ...)`
segurando lock de banco — e foi por isso que a instrumentação cercou justamente essa chamada.

### O que a própria instrumentação disse, e que enfraquece a hipótese

O comentário dela registra: *"Log confirmado do lado DVC prova que a resposta de `fPassarCartao`
chega completa - a suspeita é que a trava seja depois disso"*. Ou seja: a chamada ao pinpad
terminou e a resposta chegou inteira. O que ficou preso estava **do lado autcom, depois do RPC
retornar**.

`fRetAutoIncrem` é um caminho de banco. Ele é plausível em abstrato, mas a instrumentação rodou de
02/09 em diante e **nunca produziu uma linha** mostrando a trava entre o "antes de fRetAutoIncrem"
e o "depois de fRetAutoIncrem". A hipótese nunca ganhou evidência.

### O candidato que explica o sintoma, e foi corrigido DEPOIS

O bug de **2026-09-03** — *evento enfileirado que fica órfão na fila do `TThread.Queue`*
(`IA\rules\tef-dvc.md`) — encaixa em cada pedaço do sintoma:

| Sintoma de 31/08 | O bug de 03/09 |
|---|---|
| venda com **2+ cartões**, no **último** | cenário confirmado em campo: *"débito negado seguido de outro cartão que autoriza"* |
| **intermitente** | depende de o evento chegar **10 ms antes** da resposta RPC — corrida, não determinismo |
| **presa na tela do autcom** | um `fMensagem` **MODAL** órfão na frente da closure do hook, prendendo o fluxo até alguém clicar OK |
| **sem gerar o TEFTRA** | o hook preso estoura o `TEF_ESTACAO_TIMEOUT_HOOK_MS` e a transação nova morre antes de gravar |
| trava **depois** da resposta do `fPassarCartao` | é exatamente onde o bug mora: a fila da thread principal só é drenada enquanto `fChamaRpc` bombeia, e ele parava de bombear no instante da resposta |

O deadlock `TThread.Synchronize` × ACK, do mesmo 31/08, **não** serve de explicação: ele é descrito
como *"não é aleatório, é espera circular garantida"*, e o sintoma era intermitente.

### O que isso permite afirmar, e o que não

**Permite:** que existe um mecanismo concreto, documentado e **corrigido em 03/09**, que produz
exatamente este sintoma — e que a correção foi confirmada em campo com o cenário exato (débito
negado + outro cartão que autoriza), mais bateria de aceitação aprovada no mesmo dia.

**Não permite:** dizer que está provado. Ninguém reproduziu a trava de 31/08 e depois verificou que
o conserto a eliminou. O que há é **coincidência de mecanismo** somada a não-recorrência em muitas
baterias desde então — o que é bem mais forte que ausência de recorrência sozinha, e bem mais fraco
que prova.

### Consequência prática, para quem pegar isso depois

Se a trava voltar, **não comece pelo banco**. A hipótese do `fRetAutoIncrem` nunca teve evidência, e
o caminho a olhar primeiro é a fila da thread principal:

1. procurar `pNotifica: DESCARTADO` no log do lado autcom — é a rede de segurança da geração de
   observers, e ela dizendo que descartou significa que um evento chegou depois do dono sair de
   cena;
2. conferir se a última drenagem (`CheckSynchronize(0)` ao sair do laço de `fChamaRpc`) continua lá;
3. só depois suspeitar de lock de banco.

---

## A documentação de entrega, refeita para o commit (2026-09-22)

O requisito estava pronto e a documentação que sai dele, não. Vale registrar por que essas duas
coisas divergiram, porque a causa é estrutural e vai acontecer de novo.

### O `analysis.md` estava quatro fases atrás

Ele é o texto de entrega do DelphAI — o único artefato que o **revisor humano** lê. A última
escrita foi 10/09, no fim da Fase 5 Passo 8. De lá para cá vieram a Fase 6, a Fase 6.1, a Fase 7
inteira, a assinatura digital e sete defeitos de campo. **O revisor receberia menos da metade do
requisito, sem saber que era menos da metade.**

A causa é o incentivo: `specs.md`, `plans.md`, `tasks.md` e `record.md` são atualizados *durante*
o trabalho porque eu mesmo os releio na sessão seguinte. O `analysis.md` não serve a ninguém dentro
da sessão — só na saída. Então ele só é escrito quando alguém lembra dele, e ninguém lembra
enquanto há código para escrever.

**Consequência prática para quem retomar:** o `analysis.md` não é um documento incremental. Ele é
uma foto, e uma foto velha é pior que nenhuma, porque parece atual. Quando a próxima fase entrar,
ele tem de ser reescrito inteiro, não emendado.

### Os 26 critérios estavam em dez seções

Cada revisão de contrato acrescentou critérios no fim da sua própria seção — o que é certo
enquanto se escreve, e inútil na hora de testar. A equipe de testes receberia "leia dez seções do
`specs.md` e junte". Pior: três critérios foram **reescritos** no caminho (13 e 14 pelo certificado
autoassinado, 23 pela tarefa que rodava como quem instalou), e a versão antiga continuava lá,
legível, sem nada dizendo que não valia mais.

A §13.23 resolve isso sem apagar história: as seções originais ficam onde estão, com o raciocínio
que produziu cada critério, e a §13.23 é a lista única com o estado de cada um.

**E o `tasks.md` não vai para o SVN** (`svn:global-ignores`), então ele não podia ser o veículo —
isso é fácil de esquecer justamente porque o `tasks.md` é onde o estado dos testes foi sendo
anotado durante meses.

### O que a conferência achou, e que só uma conferência acharia

Ao validar arquivo por arquivo que toda unit citada nas tabelas existia, três estavam com o caminho
errado: `untInterfaceTefCitel.pas`, `untTefCitel.pas` e `untTefCitelNCR.pas` foram listadas em
`padra_atualizado\fontes\tef\TefCitel\` quando vivem em `libTefCitel\`. **Elas migraram para o
módulo novo e eu escrevi de memória o lugar antigo.** Num documento de entrega isso manda o revisor
procurar num diretório onde o arquivo não está — e o erro é invisível na leitura, porque o caminho
é plausível.

Fica a regra: **em documento de entrega, todo caminho de arquivo se confere contra o disco.** Custa
um comando e pega exatamente a classe de erro que a releitura não pega.

### O estado honesto, que é o que o texto passou a dizer

19 dos 26 critérios exercitados em campo. Os sete que faltam não são defeitos conhecidos — são
casos que não apareceram nas baterias. O mais caro deles é o **critério 5** (instalação elevada com
credencial de outro administrador), e ele está em primeiro na lista de pendentes pelo motivo que a
RN42 já dizia: **parece sucesso**. A chave nasce no hive errado, sem erro nenhum, e o sintoma só
aparece depois de reconectar a sessão — longe o bastante da causa para mandar o suporte procurar no
lugar errado.
