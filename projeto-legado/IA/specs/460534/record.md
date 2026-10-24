# Req. 460534 — Lentidão no Faturamento Automático

**Estado em 05/09/2026:** **Problema 1 (queima de CPU) resolvido e medido em produção.**
Problema 2 (falha de conexão) rastreado até a rede do cliente, com relatório próprio para a
infra.

**Atenção ao escopo:** o requisito foi aberto com quatro blocos, e a entrega cobre integralmente
apenas o primeiro. Ver seção 10.

**Cópia de trabalho:** `AUTPAS\379.48.2.30.74.150_DESENV`.
Migrado em 04/09 da `379.48.2.30.74.150`, que voltou a conter apenas o requisito de
Suprimento/exportação de cotação. Não misturar de novo.

**Artefatos irmãos nesta pasta:**
- [`rede-link-100mbps.md`](rede-link-100mbps.md) / `.html` / `.pdf` — o achado de rede,
  escrito para a infra do cliente. Separa fato medido de inferência de propósito.

**Método reutilizável extraído daqui:** `IA/know/profiling_servicos_linux/` — runbook e
script `perfilar.sh`. Usar antes de investigar lentidão de qualquer serviço Linux.

---

## 1. O problema

O robô de Faturamento Automático levava ~60 a 90 segundos por documento.

Ambiente de diagnóstico:

| | |
|---|---|
| Host da aplicação | `srvServicos` (192.168.0.249) |
| Caminho | `/ServicosCitel/robo_faturamento_automatico/` |
| Binário | `FaturamentoAutomatico`, Release **com símbolos de debug** |
| Banco | MySQL 8.0.46 em `srvPalacio001Local` (192.168.0.1) |

**São dois problemas independentes**, e confundi-los custou tempo:

- **Problema 1 — queima de CPU.** Em 100% dos documentos. **Resolvido.**
- **Problema 2 — falha de conexão.** `Cannot connect to server` em ~1/3 dos documentos,
  forçando retentativa completa. **Rastreado até a rede.** Aguardando ação da infra.

> **Ressalva sobre a premissa original:** o registro dizia que a lentidão acontecia "no Windows
> e no Linux". No Windows **nunca foi medida**. E a causa raiz que encontramos é em boa parte
> exclusiva de Linux (seção 3), então a lentidão no Windows, se existir, é outra coisa.

---

## 2. Causa raiz — dois degraus, e o segundo era o grande

### Degrau 1 — o laço de 900 iterações

```
CFG_CONEQU='S'
  → blnDesmembraServico = True
  → blnCarregaServicoComProdutoVinculado = True
  → desliga os DOIS guards de fMontaServicos
  → 30 × 30 = 900 iterações × ~40 GetPropValue/SetPropValue por nome
```

### Degrau 2 — o construtor, e era ele o dono

`TClassDadosServicos.Create` tinha um laço `1..30` com até 5 `SetPropValue` por volta, **todos
por nome**, sob a região "Limpar lixo de memoria". Rodava **antes** de qualquer guard, e a
inversão perversa: o teste era "slot vazio", então os **99,66% de pedidos sem serviço
percorriam o caminho máximo**.

Provado por `perf` em 05/09: **5,95 dos 6,23 pontos** de `InternalGetPropInfo` nasciam ali, por
três caminhos de chamada distintos.

### Por que Linux e não Windows

O corpo do construtor era `{$IFDEF LINUX}` — no Windows sempre foi só `FRecSer := servicos`.
E mesmo o degrau 1 custa muito menos no Windows: no Linux a busca por nome passa por
`TTypeInfoFieldAccessor::ToString` → `Utf8ToUnicode` → ICU, alocando `UnicodeString` a cada
nome comparado.

| | Windows | Linux |
|---|---|---|
| Laço de 900 iterações | existe, RTTI barato | existe, RTTI caro (ICU) |
| Laço do construtor | **não existe** | existe, e era o dominante |

> **Regra que vale além deste requisito:** `GetPropValue`/`SetPropValue` por nome em serviço
> Linux é armadilha. O mesmo código que passa despercebido no desktop vira gargalo no daemon.

---

## 3. O que foi feito

| Arquivo | Mudança |
|---|---|
| `untTypesSistema.pas` | `TDadosServicos.fTemServico` — irmã de `fTemCobranca`, 30 linhas |
| `untTypesSistema.pas` | **`TDadosServicos.pLimparSlotsVazios`** — 30 blocos, acesso direto a campo |
| `untFuncFatTypes.pas` | guard `If FServicosOri.fTemServico Then` antes do laço de `fMontaServicos` |
| `untFuncFatTypes.pas` | construtor perdeu o laço RTTI; chama `pLimparSlotsVazios` |

`pLimparSlotsVazios` usa `= ''` e não `fEmptyStr` pelo mesmo motivo de `fTemServico`:
`untTypesSistema` é unidade base e puxar `untFuncoesSimples` arrisca dependência circular. As
colunas de origem são `VARCHAR` e nunca chegam com espaço (seção 5), então é equivalente.

**O guard não foi inútil** — ele consertou o degrau 1, mas o degrau 2 era tão maior que o efeito
sumiu no ruído. Por isso a conclusão anterior de "sem efeito" estava errada.

---

## 4. Resultado medido em produção — 05/09/2026

Dois documentos de 1 item, os dois já com o guard; a única diferença é o construtor.

| Trecho | Antes (08:18) | Depois (10:12) |
|---|---|---|
| Recálculo fiscal duplicado | 2.402 ms | 618 ms |
| `Verificando Saldos` → `Iniciando Gravação` | 2.379 ms | 422 ms |
| `Clube do Pintor` → `Finalizando` | 2.533 ms | 259 ms |
| `Registrando gatilhos` → `Enviando NF-e` | 2.304 ms | 267 ms |
| **soma dos quatro buracos** | **9.618 ms** | **1.566 ms** |
| Trabalho local do documento | 17,84 s | **9,71 s** |
| Ponta a ponta (com espera da SEFAZ) | 29,6 s | **17,4 s** |

No perfil de CPU, `u_strFromUTF8WithSub_60`, `CompareText`, `InternalGetPropInfo`,
`Utf8ToUnicodeICU` e `TTypeInfoFieldAccessor::ToString` **saíram do top 19**. Amostras na mesma
janela de 60 s: 3K → 719. Ciclos: 63,5 G → 11,8 G.

O perfil ficou **plano** — nenhum mecanismo domina. O maior tema restante é cópia de record
(`_CopyRecord`, `_FinalizeRecord`, `_InitializeArray`), consequência de `TDadosServicos` ser um
record grande passado por valor. Alvo de um eventual próximo round, sem urgência.

---

## 5. Hipóteses descartadas — não reabrir sem fato novo

| Descartada | Por quê |
|---|---|
| Timeout de rota | rota direta, `nc -zv` conecta em 32 ms; `mtr` 1 salto, 0% de perda |
| `opcoes.ini` desatualizado | `fGetParametrosDaConexao` copia da conexão viva (`GetConnection`) |
| Servidor MySQL saturado | 574 de 2000 conexões; pico histórico 1356; todos os `Connection_errors_*` em zero |
| Fila de listen transbordando | `back_log` 2000, `somaxconn` 4096, `Recv-Q` 0, contadores de overflow **zero desde o boot** |
| Exaustão de porta efêmera | 1.210 `TIME_WAIT` de 28.232 portas = 4,3% |
| conntrack | módulo nem carregado no srvServicos; 2,8% no servidor de banco |
| Erro físico de rede | `ethtool -S` com todos os contadores em zero nas duas pontas |
| Lock na `PROINC` | `sys.innodb_lock_waits` e `data_locks` vazios |
| Laço de espera de 20 s em `pValidarProximoCodigo` | não é atingido |
| `fEnviarNotaEletronicaPainel` lento | 1 ms |
| `fCommit` dentro da janela D | 39 ms |
| Guard falhando por espaço em coluna `CHAR` | colunas são `VARCHAR(5)` e `NULL` em 99,66%; e a regra do `CHAR` é a inversa |
| `PROCOD` gerando conexão por chamada | `pValidarProCod` tem cache (`listValidaProcod`) — uma vez por tabela, por processo |
| `fMontaServicosVinculados` como suspeito | nunca é chamado: `pCarregaServicosVinculados` só roda sob `blnUtilizaServicoVinculado`, que exige `UTIOPS='S'`, e o cliente tem `'N'` |

**Correção importante de uma refutação anterior:** "placa de rede" estava listada como
descartada com a justificativa *"a thread está em CPU, não bloqueada em I/O"*. Isso vale para o
**Problema 1**. Para o **Problema 2** não vale — ali a thread está exatamente bloqueada em I/O.
A hipótese de rede foi descartada contra o problema errado, e quando finalmente testada contra o
certo, rendeu o achado da seção 6.

### Regras contraintuitivas que já custaram uma rodada cada

- **`CHAR` no MySQL não volta preenchido com espaço** por padrão — o padrão é remover o espaço à
  direita; é o `PAD_CHAR_TO_FULL_LENGTH` que faz manter. Supus o contrário e construí uma
  correção em cima disso.
- **Tabela vazia não é evidência** se a instrumentação pode estar desligada, e contador de
  servidor não registra pacote que nunca chegou até ele.
- **Percentual de função não é percentual de causa.** Somar os ramos e comparar com o total do
  pai; se não fecham, existe chamador fora do recorte.
- **Conferir `file /proc/$PID/exe`** antes de medir — já se concluiu que uma correção não pegou
  medindo o binário anterior.

---

## 6. Problema 2 — falha de conexão

Rastreado até a rede do cliente. O detalhamento, com evidência e separando fato de inferência,
está em [`rede-link-100mbps.md`](rede-link-100mbps.md).

**Resumo:** o srvServicos está ligado a **100 Mb/s** e o servidor de banco a **1000 Mb/s**. A
placa do srvServicos suporta e solicita gigabit; a porta do switch oferece apenas 10/100.
Nenhuma camada de software nega a conexão — o pacote se perde antes de chegar ao MySQL.

**Não está provado** que a assimetria é a causa. O pedido à infra é mover para porta gigabit,
que se justifica sozinho e é o experimento mais barato disponível.

### Mitigação aplicada do nosso lado

`fRetAutoIncremFireDac` abria **uma conexão FireDAC nova por autoincrem** — medimos ~20
conexões/s saindo do host. Agora reaproveita uma conexão por thread:

- `untProximoCodigo.pas` — `threadvar FConAutIncFireDac` + `fConexaoAutIncFireDac` +
  `pDescartarConexaoAutIncFireDac`, tudo `{$IFDEF LINUX}`
- `untTypesSistema.pas` + `Services.Core.Connection.Manager.pas` — a conexão guardada é solta
  no `EndThreadConnection`, porque `threadvar` de tipo gerenciado **não é finalizado na saída da
  thread** e ficaria aberta até o processo morrer
- a transação continua aberta e fechada dentro da função, separada da transação da venda — é
  isso que impede o rollback da venda de devolver um código já entregue

**Só FireDAC, só Linux.** O ramo UniDAC (`fRetAutoIncremInterno`) não foi tocado, e o cliente
usa FireDAC (`FDGINC='S'`). O `TFireDacConnection` **não liga pooling**.

> **CORRIGIDO EM 17/09/2026 — a justificativa acima estava errada e custou caro.**
>
> A versão original desta seção dizia que o ramo UniDAC dispensava correção porque "já tem
> pooling nativo do UniDAC (`TCriarConexao` configura `PoolingOptions`)". **Isso vale para o
> Windows, não para o Linux** — são duas classes distintas com o mesmo nome:
>
> | Plataforma | Onde | O que faz |
> |---|---|---|
> | Windows | `untModulo.pas:190` | `GetLocalConnection` → `CreateConnection`, que **configura `PoolingOptions` e liga `Pooling`** (`untThreadUtils.pas:822`) |
> | Linux | `Shared.Core.pas:812` | `BeginConnection(Random(999999))` → `TUniDacConnection.Create`, que configura **só** `LoginPrompt`, `ProviderName` e `Tag` — **nenhum pooling** |
>
> Consequência: depois do deploy de 05/09 o churn não acabou, **migrou de ramo**. Os
> `EUniError` de 16/09, os 967 sockets em `TIME_WAIT` no srvServicos e as conexões do
> `rb_fulfillment` com 8 segundos de vida vinham todos do ramo UniDAC, que esta seção dava
> como resolvido. Ver seção 11.

### Mensagens de erro que agora discriminam

Antes, qualquer falha saía como `Cannot connect to server` e não dava para saber onde nasceu.

| Mensagem | Onde falhou |
|---|---|
| `Falha ao abrir a conexão do autoincrem (PROINC)` | abrindo a conexão do autoincrem |
| `Não consegui pegar o proximo sequencial de X em PROINC` | usando a conexão do autoincrem |
| `Falha ao ABRIR conexão (host:porta/base)` | um dos ~50 outros pontos, na abertura |
| `Cannot connect...` cru | conexão já aberta que caiu em uso |

A terceira vem de `TFireDacConnection.Connect`, que é o ponto por onde **todos** os pontos de
abertura passam — um lugar cobre os 50.

---

## 7. Pendências

- **Pedido COM serviço.** O guard só desvia quando não há serviço; com serviço as 900 iterações
  continuam. Parado por decisão, a retomar depois do Problema 2.
- **`free(): invalid next size (fast)`** — corrupção de heap observada uma vez, em 05/09 08:20,
  logo após a cascata de erros de conexão. **Não foi verificado se é pré-existente.** Um `grep`
  nos logs anteriores ao deploy de 05/09 decide. A build seguinte levou uma correção candidata
  (soltar `qryGenCod` antes de descartar a conexão, em `untProximoCodigo`), então se sumir, era
  isso; se voltar, é outro problema.
- **Ação da infra do cliente** sobre o link de 100 Mb/s.
- Decidir se o build volta para Release sem símbolos. **Recomendação: manter os símbolos** —
  sem eles nada disto teria sido possível.
- Commit depende de token do DelphAI e `Req. 460534` na primeira linha.
- **Roteiro de validação — os casos são do analista.** A entrega de quem implementa é o contrato
  e a lista de casos:
  1. pedido sem serviço
  2. pedido com serviço com cobrança — **o caso de risco**
  3. pedido com serviço marcado como brinde
  4. pedido com entrega futura / imediata
  5. **pedido com serviço em alguns slots e vazio em outros** — o caso específico do
     `pLimparSlotsVazios`: ele tem de zerar exatamente os vazios e não encostar nos preenchidos

Achados menores anotados e não perseguidos: etiquetas Shopee falhando com "tente novamente em
alguns segundos" e reenfileirando (~13 s); um `EAccessViolation` em `libssl.so.1.1` visto uma
vez; um deadlock de `rb_fulfillment` em `ITEGER.ITE_REPAUD` / `ITE_REPAEF`; o recálculo fiscal
que roda duas vezes para o mesmo produto (hoje custa 618 ms, antes 2,4 s).

---

## 10. O que o requisito pede e o que foi entregue

O Req. 460534 foi aberto com quatro blocos. A investigação chegou a conclusões que mudam o que
faz sentido entregar, e isso precisa ser conciliado antes da baixa — não descoberto depois.

| Bloco do requisito | Situação |
|---|---|
| [ 1 ] Reduzir o tempo por documento | **Entregue e medido.** 17,84 s → 9,71 s de trabalho local |
| [ 2 ] Eliminar o reprocessamento total em falha de gravação, com checkpoint | **Não entregue** |
| [ 3 ] Fazer profiling e definir metas antes de refatorar | **Feito**, mas fora de ordem — o profiling levou direto à correção |
| [ 4 ] Revisar comportamento em alta concorrência | **Não feito** |

**Sobre o bloco [ 2 ], que é o mais importante desta conciliação.** Ele pede pontos de retomada
para não refazer o documento inteiro. A investigação mostrou que a falha de gravação não nasce
no código: é perda de pacote na rede do cliente, entre o servidor de aplicação a 100 Mb/s e o de
banco a 1000 Mb/s. Implementar checkpoint seria construir tolerância a uma falha de
infraestrutura em vez de corrigi-la — com custo alto, porque exigiria tornar retomável um fluxo
que hoje é transacional de ponta a ponta, e risco real de documento parcialmente gravado.

A recomendação é aguardar a ação da infra e remedir. Se as falhas cessarem, o bloco [ 2 ] perde
objeto. Se persistirem, aí sim se discute checkpoint, com o dado de que a causa é externa.

**Sobre o bloco [ 4 ].** Não foi investigado. O perfil mostrou 99,95% da CPU numa única thread,
o que sugere que o robô é serial por documento — mas isso é indício, não medição de
concorrência.

**Consequência prática:** ou o requisito é ajustado para refletir o escopo entregue, ou os
blocos [ 2 ] e [ 4 ] ficam explicitamente pendentes na baixa. O que não pode é a baixa sugerir
que os quatro foram atendidos.

---

## 8. Instrumentação — o que ficou e por quê

Toda a instrumentação de diagnóstico foi **removida** a pedido do usuário: `pLogTempo`,
`pLogSeparador`, `pLogEtapa`, os cinco contadores por chave, `pLogMedirDump` e o dicionário.

No lugar ficaram **mensagens `pInfoStatusGravacao('Aguarde... ...')` normais** — as marcas
`[C1]`–`[D2]` viraram texto legível, e ~25 mensagens novas foram espalhadas nos trechos que não
tinham nenhuma. Foram elas que localizaram os quatro buracos, e continuam servindo sem custo.

`WriteLog` passou a descartar linha vazia, num ponto só.

**A diretriz, na voz do usuário:** *"um WriteLog, um pInfoStatusGravacao já resolveria"*.
Mecanismo novo de log não passa. Buraco de mais de ~1 s entre duas mensagens se resolve
**acrescentando mensagem ali**, não criando contador.

Para descer de "trecho de 2,5 s" para "qual função", a ferramenta é `perf` com os símbolos de
debug — zero linha no código. O método está em `IA/know/profiling_servicos_linux/`.

---

## 11. Sessão de 16–17/09/2026 — o churn que sobrou, e o contexto no LOGERR

### 11.1 Por onde começou

Pergunta do João sobre gravação de erro nos robôs Linux: o `LOGERR` trazia só uma mensagem
concatenada, `LOG_RELERR` nulo, e não dava para saber qual dos 38 serviços havia falhado. Daí
saiu o bloco de contexto de execução — e foi ele que, dois dias depois, entregou o diagnóstico
do problema de conexão.

### 11.2 Erro meu, registrado para não se repetir

**Não abri esta pasta antes de investigar.** Passei a tarde de 16/09 levantando a hipótese de
tabela de conntrack saturada e pedindo ao João que rodasse `conntrack -C` e
`dmesg | grep conntrack` no srvServicos — sendo que `rede-link-100mbps.md`, escrito em 05/09,
já descartava exatamente isso com medição: módulo não carregado no srvServicos, 2,8% de
ocupação no servidor de banco, `dmesg` limpo nos dois. Quando os comandos voltaram vazios, li
como "host errado" em vez de "confirmação do que já estava escrito".

**Regra: requisito com pasta em `IA\specs\` — ler antes de investigar, não depois.**

### 11.3 A causa raiz continua sendo a de setembro

O link de 100 Mb/s do srvServicos. Nada nesta sessão contradiz `rede-link-100mbps.md`, e o
pedido à infra do cliente segue pendente. O que esta sessão fez foi **mitigação**, na mesma
linha da seção 6.

### 11.4 O que foi alterado

**Contexto de execução no log de erro** — spec própria em `IA\specs\460534-B\`.
`TDBUtils.fGetContextoExecucao` (`class var`, só no ramo `{$IFDEF LINUX}`) preenchido no
bootstrap do `Services.Core.Connection.Manager`; o bloco é montado em `Services.Core.Utils` e
prefixado ao `LOG_RELERR`. Traz executável, módulo, argumentos, host, PID/thread, banco
efetivo, empresa, operador e — quando o entry point publica — origem e payload. Também aplicado
ao `FULL_LOGERR` do fulfillment, inclusive no `pSalvaLogAvulso`, que é por onde saem os erros
de conexão e que não preenchia `LOG_RELERR` em sistema nenhum.

**Timeout de conexão.** `TUniDacConnection.Create` passou a definir
`SpecificOptions.Values['ConnectionTimeout']`. Antes valia o default do driver, que cai no
timeout de TCP do sistema — da ordem de 2 minutos. Parametrizável por
`--connection-timeout=N`, default 10, `0` desliga e volta ao comportamento anterior.

**Retentativa na abertura de conexão.** Em `TConnectionsManager.NewConnection`, que é o ponto
único por onde passa todo `Connect` físico. Duas tentativas extras, espera curta, e **não**
retenta `access denied` nem `unknown database`. O teto por tentativa acompanha o parâmetro: se
uma tentativa passar do timeout mais 5 s, o retry se desliga sozinho — proteção para o caso de
a chave do `SpecificOptions` não valer, já que ela é ignorada em silêncio. Registra no log de
arquivo, via `WriteLog`, quando repetiu e quando a repetição salvou a operação; **nunca** no
`LOGERR`, porque gravar erro abre conexão.

**Churn: heartbeat do fulfillment.** `GravaLogExecucaoRobo` criava um `TCriarConexao` — conexão
independente — a cada volta do laço, só para gravar uma linha em `FULL_LOGACE`. Com ciclo de
10 s e dez canais, era **uma conexão por segundo, constante, mesmo sem documento para
processar**. Passou a usar a conexão corrente. Isolado em `{$IFDEF LINUX}`; o Windows segue
com o `TCriarConexao`.

**Vazamento de conexão por item.** `fGDadMovDet` instancia um `TMovIte` **por item** do
documento, e o construtor abre conexão independente. O `objMovIte.Destroy` estava fora de
`try/finally`: exceção no `pGravaMovIte` deixava a conexão presa para sempre — e o vazamento
acumulava justamente quando havia erro. Corrigido com `try/finally` + `FreeAndNil`.
**Mantido sem guarda de plataforma por decisão do João**: no Windows a conexão vem de
`GetLocalConnection`, que a registra numa lista global e a devolve no `Destroy`, então o
vazamento existe lá também, e sobre um recurso que o pool tenta reciclar.

**Conexões FireDAC do `untProximoCodigo`.** `pValidaProCodFireDac` criava conexão nova **dentro
do `repeat`** — até 4 por chamada com o retry. Mais `fGetProximoCodigoEmTransacaoFireDac` e
`fRetornaSequencialEmTransacaoFiredac`, uma por chamada. Passaram a usar conexão guardada, com
**uma `threadvar` por papel, não uma por thread** — a distinção é o que protege a numeração:
`pValidaProCod` e `fAtualizaProCodGenerica` chamam `fRetAutoIncrem` **dentro** das próprias
transações, e compartilhar a conexão faria o `Commit` do autoincremento comitar a transação do
chamador no meio. Tudo sob `{$IFDEF LINUX}`, verificado por comparação da visão do
pré-processador: zero linhas de código mudam no Windows.

### 11.5 Resultado medido

| Janela | `Cannot connect` por hora |
|---|---|
| 16/09, das 5h às 17h | **35 a 59**, treze horas seguidas |
| 16/09 18h até 17/09 10h | **zero**, incluindo o pico das 7h, 8h e 9h |

Conexões do `rb_fulfillment`: a mais antiga passou de **8 segundos** para **1158**. No mesmo
instante, o `rb_saldoreserv` — que não passa pelo código alterado — seguia com 67 sessões e a
mais antiga com 3 segundos. O contraste separa o efeito da alteração do efeito do horário.

`Lost connection` sobreviveu, raro: dois em ~40 h. A retentativa **não** cobre esse caso, e não
deve cobrir — repetir comando não-idempotente cuja conexão caiu no meio pode gravar duas vezes.
A defesa correta é validar a conexão antes de usar.

### 11.6 O alvo que sobrou, e é o maior

`Services.Core.Connection.Manager.fRetAutoIncrem` — o do **Core**, registrado em
`TDBUtils.fRetAutoIncrem` no bootstrap do Linux, que é função diferente da do
`untProximoCodigo` corrigida em 05/09. Com `blnUsaTransacaoCorrente = False`, que é o default,
ela abre e fecha uma conexão **por chamada**. São **393 chamadas só em `fontes/faturamento`, e
nenhuma passa `True`**. Autoincremento é pedido para cada inserção — MOVGER, MOVDET, MOVITE,
Contas a Receber, Livro Fiscal —, então são dezenas por documento.

**Não corrigir passando `blnUsaTransacaoCorrente = True`.** Isso põe o autoincremento na
transação da venda, e um rollback devolveria número já entregue — exatamente o que a seção 6
diz que a separação existe para impedir. A correção certa é a mesma: conexão guardada por
thread.

### 11.7 Pendências desta sessão

- Build do `autcom.groupproj` e uma volta de gravação de documento antes de qualquer coisa ir
  para o desktop — o `try/finally` do `TMovIte` é a única mudança de comportamento lá.
- `fRetAutoIncrem` do Core, acima.
- Pool no Linux. Agora se sabe que **não é tecnologia nova**: é igualar o Linux ao que o
  Windows já faz, com as mesmas chaves `POO*` do CFGSIS. Cuidado a considerar: pool aumenta
  conexão em repouso, e são dezenas de processos.
- Validar a conexão antes de usar, para cobrir o `Lost connection`.
- Dois documentos presos em laço no fulfillment — `003339462-NF-001` e `001375338-NF-010`,
  "Nota de remessa não possui pedido de venda vinculado" — respondem hoje por quase todo o
  ruído do `FULL_LOGERR`, cada repetição gravando a lista completa de produtos. Problema de
  negócio, sem relação com conexão.
- Da spec do 460534-B: falta conferir por `general_log` que a montagem do contexto
  não emite query, provar a máscara com `senha`/`token` reais, e testar herança de origem entre
  requisições na mesma thread do Indy.
