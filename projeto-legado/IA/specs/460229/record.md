# Req. 460229 — gatilhos de informação chegando fora do horário

Cliente MINAS BOMBAS (`MINAS_BOMBAS_LJ001`, empresa 003). Operador 002 configurou 8 gatilhos
entre 18:00 e 18:15 e alega receber na manhã seguinte. Zendesk 1652841.

## Sessão de 06/09/2026 — investigação, causa raiz parcial

### O que os anexos do chamado provam

Os 8 gatilhos saíram em **3min18s** — `GAT_ULTENV` de 06:51:26 a 06:54:43 em 03/09, ~40s cada.

**Não é lentidão.** O que atrasou foi o início: ~12h50 depois da janela configurada. Descartar a
leitura de "envio lento" que o título do chamado sugere — ela desvia a investigação para geração
de relatório, que não é onde está o problema.

Grid da tela (anexo `HORARIO_ENVIOS.png`): 8 gatilhos ativos, e-mail para lucas@minasbombas.com.br,
horários 18:00 / 18:05 / 18:06 / 18:07 / 18:08 / 18:09 / 18:12 / 18:15.

### Causa raiz do dia relatado — confirmada no log do monitor

```
02/09/2026 18:02:18 [main] - Cannot connect to server on host 'MINASBOMBAS-001.DDNS.NET':
                             System error: 71.  Socket Error Code: 113($71)
02/09/2026 18:02:18 [main] - item 5: Exception -> Cannot connect to server ...
02/09/2026 18:02:18 [main] - Execute.for: iteracao concluida item 5
```

Errno 113 = `EHOSTUNREACH`. Foi a **única** tentativa da noite de 02/09 — MINAS_BOMBAS não
reaparece no log até 06:51 do dia seguinte, que é exatamente o `GAT_ULTENV` do print.

Não houve segunda chance por desenho: em `MonitorarGatilhos/untGatilhos.pas`, o `except` do
`TEnviarGatilhos.Execute` só loga, e o `pRemoverItemFila(0)` seguinte roda **igual para sucesso e
para falha**; o `pLimparFilaIni` do fim do ciclo apaga o resto. Falha de conexão sai da fila como
se tivesse sido atendida.

**A falha é isolada:** varredura de exceções correlacionadas ao servidor em 17 dias de log
(21/08 a 06/09) devolve **uma única linha** — 02/09 18:02:18. Nos demais dias o processo filho
subiu dentro da janela.

### Padrão de cobertura da janela — vale olhar mesmo com a falha isolada

Spawns (`INICIANDO ...`) para MINAS_BOMBAS na janela da noite:

| Dia | Tentativas 18h |
|---|---|
| 24/08 – 01/09 | 18:02 e 18:45 — duas |
| 02/09 | 18:02 (falhou) — nenhuma outra |
| 03 e 04/09 | 18:02, 18:06, 18:08, 18:11, 18:13, 18:15 — seis |
| 05/09 | 18:00, 18:05 |

A varredura do monitor é serial sobre ~560 clientes, então a cobertura da janela depende de a vez
do cliente cair no minuto certo. Uma falha ali custa a noite inteira.

### Segundo defeito, independente e não confirmado no cliente

`untGatilhosInformacao.pas`, `TGatilhosInformacaoMonitor.pExecuteAll` (linha ~2033 na r493393):

```pascal
If LQuery.FieldByName('GAT_PROENV').AsDateTime < fRetDataServidor Then
Begin
  TGatilhosInformacao.AtualizarDataEnvio(...);   // NÃO envia — só carimba e reagenda
End
Else If LQuery.FieldByName('GAT_PROENV').AsDateTime < fRetDtaHraServidor Then
  ...pExecute();                                  // envia
```

Gatilho que perde a janela e atravessa a meia-noite cai no primeiro ramo: **não é enviado**, mas
recebe `GAT_ULTENV = agora` e reagendamento. Banco fica com carimbo de enviado e o painel de
status verde. Ou seja, o lote de 02/09 provavelmente nunca chegou — o que o cliente recebeu de
manhã foi outra coisa.

Consequência para a leitura do chamado: `GAT_ULTENV` **não** é prova de entrega.

### Contexto de arquitetura levantado

- Cliente está em **modo novo (LibGatIme)**, confirmado no log:
  `LibGatIme deteccao: ultima entrega em 02/09/2026 (0 dia(s) atras, janela=7) - modo novo`
- Nesse modo, `TGatilhoInformacao.EnviarRelatorioPorEmail` **não envia** — chama
  `TDllGatime.fGravarGatilhoImediato`, que enfileira na `GATIME_WPPEMA`. Quem entrega é o
  consumidor `fMonitorarGatilhosImediatos('OPERACIONAL')`. Não há variante condicional: é a única
  implementação do método no ramo.
- Portanto `GAT_ULTMSG`/`GAT_ULTENV` são carimbados no **enfileiramento**, não na entrega. A
  distância real entre os dois está em `GATIME_WPPEMA.GAT_D_EEMA`.

### Hipóteses levantadas e descartadas

- **"Req. 451546 (r491154) afrouxou o gate e jogou o cliente na fila LibGatIme."** Descartada: o
  diff mostra o contrário — o critério ficou *mais* estrito (antes qualquer linha em
  `GATIME_WPPEMA`; depois, marca de entrega ≤7 dias). O commit só tocou o monitor da Citel.
- **"Data global em cache fazia o guard da linha 2033 não disparar."** Descartada:
  `fRetDataServidor` e `fRetDtaHraServidor` consultam `CURRENT_DATE`/`CURRENT_TIMESTAMP` a cada
  chamada, sem cache.
- **"Atraso é a geração do relatório."** Descartada pelos 3min18s de `GAT_ULTENV`.

### Divergência de build — cuidado ao ler o fonte

`GAT_ULTMSG` do cliente diz `"Gatilho enviado com sucesso!"`. Essa string **não existe em nenhum
fonte** do ramo 150, nem do 150_DESENV, nem do 111 — o código atual grava
`MSG_SUCESSO_ENVIO = 'Mensagem enviada com sucesso!'`. Cliente roda build 491191; working copy
está em r493393. Ou vem da DLL libGatIme, ou de build anterior. Enquanto não fechar, tratar a
leitura do fonte como aproximação do que executa lá.

### Onde estão as evidências

- Logs do monitor: `\\citel-fileserve\USUARIOS\joao.catarino\logs\monitor_AAAAMMDD.log`
  (`pLog` do `MonitorarGatilhos`, ~30 MB/dia, um por dia, 21/08 em diante). Os subdiretórios
  por cliente guardam o log do processo filho (`--output=`), mas estão quase todos vazios —
  135 arquivos para 564 pastas.
- Anexos do chamado, baixados de `bucket.citelsoftware.com.br`.

## Sessão de 06/09/2026, parte 2 — causa raiz fechada com o banco do cliente

Acesso de leitura ao banco liberado. **A conclusão da parte 1 fica superada**: a falha de rede de
02/09 era real, mas incidental. O atraso é recorrente e tem outra causa.

### O atraso, medido

`GATIME_WPPEMA`, e-mails de lucas@minasbombas.com.br. Enfileiramento em `GAT_DTAOCO`/`GAT_HOROCO`,
entrega em `GAT_D_EEMA`/`GAT_H_EEMA`:

| Enfileirado | | Entregue | | Atraso |
|---|---|---|---|---|
| 20/08 qui | 15:44 | 20/08 qui | 15:44 | 0 — anterior à virada |
| 25/08 ter | 18:02 | 26/08 qua | 07:46 | **823 min** |
| 26/08 qua | 18:02 | 27/08 qui | 07:45 | **822 min** |
| 27/08 qui | 18:02 | 28/08 sex | 07:40 | **817 min** |
| 28/08 sex | 18:03 | 29/08 sáb | 07:45 | **822 min** |
| 29/08 sáb | 18:00 | **31/08 seg** | 07:45 | **2264 min** |
| 31/08 seg | 18:02 | 01/09 ter | 07:43 | **820 min** |
| 01/09 ter | 17:55 | 01/09 ter | 18:04 | 9 min |
| 04/09 sex | 18:02 | 05/09 sáb | 07:30 | **808 min** |
| 05/09 sáb | 18:00 | 05/09 sáb | 18:01 | 0 min |

**O enfileiramento está no horário.** Agendamento, monitor da Citel e geração do relatório estão
corretos. O atraso é inteiramente na drenagem da fila.

### Mecanismo

`pProcessarGatilhosImediatos` — o consumidor — só roda como passo final de `pExecuteAll`, que só
roda quando o monitor da Citel dispara o processo, e ele só dispara quando **algum gatilho está
vencido**. Como o último gatilho do dia é às 18:15, não há mais nada vencido naquela noite: a fila
espera até o próximo horário agendado, 07:30 da manhã seguinte. As entregas às 07:40–07:49 são esse
spawn das 07:30 chegando ao passo final.

**A fila é drenada pela execução seguinte, nunca pela que a encheu.** Quanto mais tarde o último
gatilho do dia, maior o atraso; no fim de semana vira 37h (29/08 → 31/08).

Os dois dias sem atraso confirmam: em 05/09 só 2 gatilhos rodaram, a passada terminou rápido e a
drenagem veio 18 segundos depois do enfileiramento.

### Gatilho da regressão — Req. 451546 (r491154, 25/08/2026)

**Corrige o que a parte 1 afirmou.** Aquele commit não "endureceu o gate empurrando para o modo
antigo". Ele trocou o gate inteiro:

```pascal
// antes: whitelist era o UNICO caminho para o modo novo
if fServidorUsaLibGatIme(ADadosConexao.servidor) then
  LExec := ... 'GatilhosInformacao_LibGatIme';

// depois: whitelist virou override, e quem esta fora cai na deteccao automatica
if fServidorUsaLibGatIme(...) then
  LUsaLibGatIme := True
else
  LUsaLibGatIme := GetClienteConsomeGatilhosImediatos(LConn);
```

MINAS_BOMBAS não está no `libgatime_clients.txt`. Antes, isso bastava para mantê-lo no envio
síncrono. Depois, passou pela detecção automática, que consulta a `GATIME_WPPEMA` — onde já havia
entregas desde 09/07, dos gatilhos imediatos de WhatsApp que ele já usava. Qualificou de imediato.

Três confirmações independentes apontando para 25/08:

1. O diff da r491154.
2. O binário escolhido, dia a dia, no `monitor_AAAAMMDD.log`:
   24/08 = `GatilhosInformacao`; 25/08 = os dois; 26/08 em diante = `_LibGatIme`.
   Em 25/08: `LibGatIme deteccao: ultima entrega em 25/08/2026 (0 dia(s) atras) - modo novo`.
3. A primeira entrega atrasada é a de 25/08. Antes disso não há nenhuma linha do lucas na fila.

**O cliente foi migrado para o modo novo sem que ninguém decidisse migrá-lo**, e a migração troca
envio síncrono por fila drenada só na execução seguinte.

### Descartado nesta sessão

- **Lock preso no consumidor** — `LCKATC` não tem nenhuma linha de gatilho.
- **`GAT_LIBENV` travado em `'P'`** — o `'P'` vira `'S'` no fim da própria
  `fGravarGatilhoImediato` (`GatilhosImediatos.Classes.pas:309`), depois de gravar os anexos. A
  linha nasce visível ao consumidor.
- **Corte por `-TL=1`** — `FTimeLimit` é em minutos e o teste roda *antes* de cada `pExecuteAll`
  (`Services.Core.Task.Monitor.pas:136`); não interrompe a passada em andamento.

### Acesso ao banco

Profile `minasbombas` em `%USERPROFILE%\.claude\db-config.local.json`. As variáveis
`MYSQL_MINASBOMBAS_USER`/`_PASS` estão em `HKCU\Environment`; processo que já estava rodando não as
enxerga — ler do registro e injetar no ambiente antes de chamar o `autcom_db.py`.

## Sessão de 06/09/2026, parte 3 — não é um cliente, são 162

Mais dois chamados chegaram na mesma sessão e são a **mesma regressão**, com manifestações
diferentes: `IA\specs\459428\record.md` (MARCIUS) e `IA\specs\459481\record.md` (BELATINTAS).
Nos três, o binário virou de `GatilhosInformacao` para `_LibGatIme` entre 24 e 26/08.

Contagem de `Binario escolhido para` no log do monitor:

| | 24/08 | 26/08 |
|---|---|---|
| `GatilhosInformacao` — síncrono | 237 | 69 |
| `GatilhosInformacao_LibGatIme` — fila | 3 | 168 |

**162 clientes migrados de uma vez**, em 25/08. Antes eram 3 — a whitelist.

Os três quebram em etapas diferentes do mesmo caminho, e todos gravam
`"Gatilho enviado com sucesso!"` na `GATINF`:

| Chamado | Onde quebra | Efeito |
|---|---|---|
| 460229 MINAS BOMBAS | drenagem da fila | chega ~13h40 atrasado; 37h no fim de semana |
| 459428 MARCIUS | materialização do anexo (share UNC) | nada chega desde 30/08 |
| 459481 BELATINTAS | `Exit` silencioso por cadastro do destino | 389 de 392 nunca saem |

### O contrato que falta entre gerar e enviar

A separação entre gerar e enviar é razoável; o protocolo entre as duas metades não veio junto.

- **Confirmação** — não existe. `ExecutarRelatorioParaEmail` abre com `Result := True` e devolve
  `True` em todos os caminhos de desistência. O carimbo na `GATINF` descreve intenção, não fato.
- **Retentativa** — existe por acidente de desenho: `pMarcaGatImeEnviado` só zera `GAT_LIBENV`
  quando os três canais têm marca, então a linha volta a cada passagem do consumidor. Não é
  visível em lugar nenhum.
- **Desistência** — existe (`fValidaDisparo`, >24h → `tpDisparoAtrasado24Hrs`), mas grava **nas
  mesmas colunas** da entrega real; a diferença fica só em `GAT_OBSEMA`/`GAT_OBSWPP`.
- **Falha visível** — não existe.

Diagnóstico desenhado, para conversa com terceiros:
https://claude.ai/code/artifact/91bdf3dd-a859-4cc0-bbf6-7c94dbff1358

### Divergência de build — agora com duas evidências

1. `"Gatilho enviado com sucesso!"` está gravado na `GATINF` dos três clientes e **não existe em
   nenhum fonte** do ramo; o código atual grava `"Mensagem enviada com sucesso!"`.
2. A guarda de 24h do `fValidaDisparo` **não agiu** num lote entregue com 37h de atraso
   (MINAS BOMBAS, 29/08 → 31/08), que saiu com `GAT_OBSEMA = "Enviado"`.

Build dos clientes é 491191; a working copy está em r493393. Fechar essa divergência **antes** de
escrever correção — o código que eu leio não é o que executa lá.

## Sessão de 06/09/2026, parte 4 — desenho fechado

`spec.md` e `plan.md` escritos. Duas decisões e uma verificação mudaram o rumo durante o desenho.

### A entrega cabe inteira no monitor

Descoberta a assimetria que sustenta tudo: o `GatilhosInformacaoMonitor` **não linka `fontes/`**
(4 units, 9 MB, contra ~800 units e 346 MB dos outros), e por isso é implantado sem risco — foi
atualizado em 25/08 sem incidente. O robô e a `.so` ficam intocados.

### Verificação de ABI reprovou atualizar a `libGatIme.so`

A ideia era trazer `fValidaDisparo` (guarda de 24 h, r481567). Conferido entre ~r476904 (build no
ar) e a HEAD:

- lista de exports do `GatIme.dpr`: **idêntica**
- `untDllGatImeParametros.pas`: **sem mudança**
- `IGatIme`: **mudou** — `fMonitorar` ganhou `AstrFluxo: String`

`TDllGatime.fMonitorarGatilhosImediatos` chama `DllGatIme.fMonitorar(AstrFluxo)`
(`untDllGatIme.pas:143`), que é o caminho da drenagem. O exe de 02/06 chama sem argumento; a `.so`
nova espera `String`. Trocar só a lib mata o processo filho.

**A quebra está na vtable, e o nome do export não a denuncia** — quem conferisse só a lista de
exports concluiria que era seguro.

E a verificação mostrou que o degrau era dispensável: a proteção contra mensagem velha fica melhor
no monitor, no corte de 20 h antes de provocar a drenagem. Protege exatamente o que a entrega
causa; a guarda da `.so` protegeria também as drenagens naturais, que já ocorrem sem proteção hoje
e que a entrega não piora.

### `libgatime_clients.txt` será removido

Ele acumulou dois papéis: piloto e portão de modo. E não consegue ser piloto — escolhe entre dois
nomes compilados no código, não entre versões. Como override de modo só altera o resultado para o
cliente **sem** marca de entrega, que é o mais arriscado de forçar: **só age quando está errado**.

Substituído por conjunto materializado na base central, que faz os dois trabalhos com auditoria.
A detecção automática é rebaixada a relatório de candidatos. Carga inicial reproduz o estado atual
— ninguém muda de modo na virada.

## Sessão de 06/09/2026, parte 5 — a camada de monitoramento que ninguém conhecia

Encontrada ao criar as tabelas na base central. **Nem eu nem o usuário sabíamos que existia.**

`gatilhos_informacao_tipo_erro` (catálogo de padrões de mensagem), `_blacklist` (silenciamento por
servidor+erro), `_ticket_controle` (71 tickets do Zendesk) e `vw_monitoramento_gatilhos_informacao`
(painel por cliente: pendente / com ticket / ok / total). Nada disso está no repositório Delphi, e
o `flyway_schema_history` só tem uma migration, de 2023 — foi tudo criado fora. Provavelmente n8n;
autor desconhecido.

Como funciona: o `TAtualizarStatus` copia o `GAT_ULTMSG` do cliente para
`gatilhos_informacao_status.ultima_mensagem`; algo cruza esse texto por `LIKE` contra o catálogo,
descobre o `id_erro` e **abre ticket no Zendesk sozinho**. A blacklist evita reabrir para o mesmo
par servidor+erro.

### Ela parou, e há sete clientes desassistidos

Tickets eram abertos quase todo dia — 16, 17, 20, 21, 22, 23, 24, 27, 28, 29, 30, 31/07, 03, 04/08
e 21/08. **Nada desde 21/08.** Não é dedup: hoje há sete pares com erro classificável e nenhum
ticket.

| Cliente | Erro |
|---|---|
| ATA_PECAS_001_MATRIZ | ID01 — não conecta |
| CM_MATERIAIS_CONSTRUCAO_LJ001 | ID01 |
| CASAS_JARDIM | ID01 |
| LEAO_TINTAS_001_MATRIZ | ID01 |
| UBERTINTAS_002_003_006_101 | ID13 — estrutura de dados não carregada |
| AUTOTINTAS_UNIAO_002_MATRIZ | ID28 — autenticação de e-mail |
| SANCHES_MARIN_001_COMERCIAL | ID28 |

**Isto é independente do requisito e vale hoje.** Antes de 21/08 cada um viraria ticket no dia
seguinte. Descobrir quem construiu e religar é ação de outra alçada.

### E a migração cegou o que sobrou

Das 2151 linhas de `gatilhos_informacao_status`, **1854 (86%) dizem
`"Gatilho enviado com sucesso!"`** — que é `ID07`, a gaveta de sucesso. Só 33 caem em erro real.
Mesmo que a automação fosse religada hoje, veria um mar de sucesso.

Isso também resolve o mistério da parte 1: a frase **existe** — está no catálogo desta base, e é
escrita pelo binário de 02/06. Alguém antes de nós já tinha esbarrado nela.

Os três chamados que originaram este trabalho não vieram da automação: vieram de pessoas.

### Decisão

Dois `id_erro` novos, inseridos no catálogo em 06/09/2026 — redação do usuário, que nomeia a tabela
para quem for investigar saber onde olhar:

| id_erro | descricao |
|---|---|
| `ID29` | `Pendente de envio na GATIME_WPPEMA` |
| `ID30` | `Nao gerou registro na GATIME_WPPEMA` |

A reconciliação não depende da automação — mas escreve no formato que ela classifica. Conferido:
zero falso positivo dos dois padrões contra as 2151 mensagens, e nenhum par do catálogo contém
outro.

## Sessão de 06→07/09/2026, parte 6 — versionamento no ar

O desenho mudou durante a execução, por proposta do usuário: em vez de tabela de modo
(FILA/SINCRONO), **versionar o robô por pasta**. Modo era caso particular de "qual build roda".

Isso resolve estruturalmente o defeito de ABI: cada pasta tem exe e `libGatIme.so` do mesmo build,
então a mistura que mataria o processo filho deixa de ser possível. E destrava o medo de atualizar
— dá para pilotar 3 clientes numa versão nova e ir incrementando.

A tabela `gatilhos_informacao_robo` é de **exceção**, não de conjunto: sem linha, roda a default.
Some a carga inicial de 237 clientes, some a whitelist, some a detecção automática. O princípio do
usuário fica valendo: quem pode usar a versão corrente, usa.

*"O risco não era a migração — era migrar às cegas."* Com a reconciliação no ar, migração
automática deixa de ser perigosa.

### No ar em 07/09/2026, 00:35

- `gatilhos_informacao_robo` e `_divergencia` criadas na base central, `utf8mb4_0900_ai_ci`
- `ID29` / `ID30` no catálogo `gatilhos_informacao_tipo_erro`, sem falso positivo
- Monitor compilado e rodando: `Robo default: robo_libgatime`, explícito no `enviar.sh`
- Pastas `robo_velho/` e `robo_libgatime/` montadas com exe, `.so`, `.fr3`, `.png` e libs
- MARCIUS fixado em `robo_velho` — 6 gatilhos, empresa 001

O filho passa a rodar **dentro** da pasta (`cd <pasta> && ./GatilhosInformacao`). Sem isso ele
herdaria o cwd do monitor e resolveria `.fr3`, `.png` e `libmysqlclient.so` da raiz — a versão
valeria só para o executável e o resto vazaria entre versões.

### A conferir na janela das 18h de 07/09

| Onde | Esperado |
|---|---|
| log, 18:00–18:15 | `Robo escolhido para MINAS_BOMBAS_LJ001: robo_libgatime (default)` |
| log, 18:29 | `... GRUPO_MARCIUS...: robo_velho (FIXADO)` |
| `WPPENV` do MARCIUS | registro novo — o primeiro desde 29/08, fecha o 459428 |

## Sessão de 07/09/2026 — requisito inteiro no ar

Tudo implantado. +723 linhas no `untGatilhos.pas`, duas tabelas e dois `id_erro` na base central.

### O que entrou

| Peça | Estado |
|---|---|
| Versionamento por pasta | **validado em produção** — MARCIUS entregou 6 pelo `robo_velho` |
| Reconciliação agregada | no ar, com filtro de não-envio legítimo |
| Detalhe por gatilho (`ID29`/`ID30`) | no ar |
| Destravamento, corte de 20 h | no ar, ainda não exercitado |

### 459428 fechado

O MARCIUS foi fixado em `robo_velho` e voltou a entregar **6 gatilhos de informação em 07/09,
20:01–20:02** — os primeiros desde 24/08. Confirmado na `WPPENV` do cliente, filtrando por
`WPP_NOMGAT LIKE '%DIRETORIA%'`: 6 por dia até 24/08, nada entre 25/08 e 06/09, 6 de novo em 07/09.

**Um chamado fechado com uma linha de `INSERT`**, e o mecanismo de versionamento validado no mesmo
ato.

### Defeitos meus corrigidos no caminho

Cada um teria custado um ciclo de compilação ou um alarme inútil:

- **`carimbados` contava não-envio legítimo.** Feriado, sem dados, sem relatório associado e GATPER
  vazia carimbam `GAT_ULTENV` sem enviar, e estão certos. No primeiro passe, em 07/09, foram **97
  falsos só no BELATINTAS** — todos "Gatilho nao executa em Feriados". Sem o filtro, o alarme
  acusaria todo cliente em todo feriado e morreria de ruído no primeiro mês.
- **Nomenclatura interna.** `carimbados`/`enfileirados`/`nao_identificados` eram vocabulário desta
  investigação. Viraram `deviam_enviar`/`chegaram_na_fila`/`entregues`/`sem_correlacao`, com
  `COMMENT` de coluna — que é o que aparece num BI, onde o comentário do script não chega.
- **Ordem de declaração.** `pDetalharDivergencia` chamava `pUpdateGatilhoStatus` declarado 300
  linhas depois.
- **389 conexões por passe.** O `pUpdateGatilhoStatus` abre uma `TConexao` por chamada; criado
  `pGravarMensagemGatilho`, que usa a já aberta.
- **`Now()` cru** em 4 pontos — trava do pre-commit. Trocado por `CURRENT_TIMESTAMP` da central; só
  o TTL em memória ficou, com `System.SysUtils.Now` qualificado, que é a exceção do `CLAUDE.md`.
- **Reconciliação no laço errado.** Estava dentro do laço do `TAtualizarStatus`, que filtra
  `ultima_mensagem NOT LIKE '%enviado com sucesso%'` — e 86% das linhas dizem exatamente isso.
  Rodaria em todo mundo menos em quem importa. Virou passe próprio.
- **Vazamento de `TQuery`** no destravamento.

### Grupo de controle para amanhã

Nove profiles em `%USERPROFILE%\.claude\db-config.local.json`, todos só-leitura, testados:

| Profile | Divergência de 07/09 | Papel |
|---|---|---|
| `palmares` | 87 / 52 / 52 | **controle negativo** — não pode acusar |
| `construart` | 34 / 1 | suspeito, padrão BELATINTAS |
| `ismafer` | 12 / 3 / 0 | fila não drenada — alvo do destravamento |
| `home_center_guanabara` | 12 / 3 / 3 | entregou o que enfileirou |
| `geracor`, `reimac` | — | acompanhar |
| `belatintas`, `marcius`, `minasbombas` | — | os três chamados |

### Desenhos

Para conversa com terceiros, os três publicados nesta investigação:

- **Fluxo como ficou** — https://claude.ai/code/artifact/784723e8-0a35-4374-952e-58a7bbcfb7a5
- Diagnóstico — https://claude.ai/code/artifact/91bdf3dd-a859-4cc0-bbf6-7c94dbff1358
- Plano — https://claude.ai/code/artifact/9eb99945-4f02-4957-9d69-ee72ee9feefd

O **fluxo** é o atual e substitui o plano como retrato do desenho: caminho do disparo, escolha da
versão por pasta, reconciliação e a linha do tempo da drenagem.

*O diagnóstico continua válido inteiro. O plano descreve o desenho anterior à virada para
versionamento por pasta — fala em conjunto materializado e carga inicial, que foram substituídos.*

### Nada commitado ainda

O working copy tem as alterações do `untGatilhos.pas` e o `.sql` novo, ambos sem commit. A mensagem
precisa de `Req. 460229` na primeira linha e do token do DelphAI. Há trabalho de outro requisito
(460364) na mesma cópia — conferir o `svn status` antes de montar o commit.

### Prévia no VIVA_COR, 07/09 21:30 — o filtro faltava no detalhe

Conferido o `VIVA_COR_004_..._PROD_CLOUD_BR65` (empresa 004, `10.0.1.60:60501`, profile `vivacor`).
A agregada apurou **16 / 9 / 0** com 7 sem correlação — leitura correta. O detalhe por gatilho, não:
gravou **19 ID30**, e os 19 são exatamente os 19 gatilhos de feriado.

O `SQL_POR_GATILHO` do `pDetalharDivergencia` filtrava só `GAT_STATUS = 'A'` e a data. **O filtro de
não-envio legítimo estava apenas na agregada** — o mesmo defeito que já tinha sido corrigido uma vez,
sobrevivendo na outra consulta porque a regra existia em duas cópias.

Escala do dia, na base central: **1822 ID30 gravados** para no máximo 693 possíveis
(`deviam_enviar − chegaram_na_fila` somados). Ou seja, ~⅔ falsos — e no primeiro dia útil o painel
apareceria vermelho sem motivo.

Correção aplicada: o filtro virou `SQL_SEM_NAO_ENVIO_LEGITIMO`, const de unit, usado pelas duas
consultas. A `GATINF` da agregada ganhou o alias `g` para casar. Simulado no VIVA_COR antes de
compilar: **9 ID29, 0 ID30, 7 sem correlação, 16 avaliados** — bate com a agregada.

As 1822 mensagens já gravadas se curam sozinhas: o texto não casa com
`'%enviado com sucesso%'`, então o laço do `TAtualizarStatus` recolhe a linha e reescreve com o
`GAT_ULTMSG` real do cliente.

**Precisa de recompilação.** É a razão de a prévia ter valido a pena.

### Varredura de 07/09 21:40 — mais três defeitos, todos meus

O VIVA_COR mostrou que valia varrer antes de compilar. Varri, e achou mais.

**2. Nenhuma consulta filtrava por empresa.** `GATINF` e `GATIME_WPPEMA` têm `GAT_CODEMP`, o banco
do cliente é um só, e as três consultas — apuração agregada, detalhe por gatilho e idade da fila no
destravamento — contavam o cliente inteiro. Cliente com N empresas recebia N linhas idênticas com o
total.

`PALACIO_FERRAMENTAS`, 07/09: quatro linhas dizendo **40 / 0 / 0**. A verdade por empresa é
006 = 39, 007 = 1, **001 e 002 = nada**. Duas das quatro linhas eram inteiramente inventadas.
São **24 clientes multi-empresa, 68 das 238 linhas** do dia.

Pior no detalhe: ele gravava a mensagem do gatilho de uma empresa **na chave de outra**.

Corrigido com `GAT_CODEMP` nas três consultas e nos `EXISTS`. Simulado antes de compilar: PALACIO
passa a 006 = 39/0/0, 007 = 1/0/0, e 001/002 somem da tabela (zeros não gravam). VIVA_COR, que tem
uma empresa só, não muda — 16/9.

*Checado o risco de o filtro cegar alguém:* as empresas ativas na `GATINF` do PALACIO (001, 006,
007) estão todas registradas na central. E o robô, note-se, **não** filtra por empresa — o
`SQL_GATILHOS_PENDENTES` usa `EMPRESAS_NESTE_SERVIDOR` + `CFG_GATINF`. O `-e` é contexto de conexão,
não recorte de trabalho. Consequência lateral, pré-existente: em cliente multi-empresa o monitor
sobe N robôs por ciclo que fazem o mesmo trabalho.

**3. `NOW()` cru no `SQL_IDADE`** — trava do pre-commit, escapou da limpeza anterior porque a
consulta nasceu depois. Trocado por `CURRENT_TIMESTAMP`.

**4. Critério de pendência do destravamento errado nas duas polaridades.** Era
`(GAT_D_EWPP IS NULL OR GAT_D_EEMA IS NULL)`: gatilho só de e-mail entrava **sempre**, porque a
coluna de WhatsApp nele é nula por natureza — o destravamento subiria robô para fila já drenada.
Trocar por `AND` erraria ao contrário, excluindo a linha entregue por um canal e pendente no outro,
que é exatamente a que precisa drenar. A condição saiu: quem sabe a resposta é o `GAT_LIBENV = 'S'`,
que o próprio consumidor só zera quando todos os canais têm marca.

### Conferido e correto

Não é só defeito. As invariantes da tabela passaram: **zero** linhas com `entregues > chegaram_na_fila`,
zero linhas todas zeradas, zero clientes fixados em pasta síncrona sendo apurados.

E o filtro de não-envio legítimo está completo. Confrontado com a cascata de
`untGatilhosInformacao.pas:1927-1992`, que é onde se decide o que carimba sem enviar: os quatro
caminhos filtrados são `MSG_GATINF_SEM_CODREL`, `MSG_GATPER_VAZIA`, `MSG_NAO_EXECUTA_FERIADOS` e
`MSG_SEM_DADOS_PARA_GERAR_RELATORIO` — e os demais ramos que carimbam são erro real, que **deve**
contar. `MSG_ERRO_NAO_ENVIAR` desativa o gatilho, então o `GAT_STATUS = 'A'` já o exclui.

Dois detalhes que valem a pena guardar:

- `AtualizarUltimaMsg` aplica `fRemoveAcento`, então o `GAT_ULTMSG` do cliente é sem acento. Mas
  mesmo se tivesse, a collation `latin1_swedish_ci` é accent-insensitive — testado: `LIKE` sem
  acento casa texto com acento. O filtro tem cinto e suspensório.
- **Cegueira conhecida:** o `Else` final (linha 1984) e o `Except` (2005) chamam
  `AtualizarUltimaMsg` **sem** `AtualizarDataEnvio`. Falha por esses caminhos não carimba, logo não
  entra em `deviam_enviar` e a reconciliação não a vê. Quem cobre isso é a classificação por
  mensagem que já existia (ID01, ID13, ID28).

### Validado em produção, 07/09 22:06

Recompilado, implantado e os dois processos reiniciados. A `gatilhos_informacao_divergencia` do dia
foi apagada para não misturar as duas apurações — o passe reconstruiu 214 linhas em ~3 min.

| Prova | Antes | Depois |
|---|---|---|
| PALACIO — linhas | 4, todas 40/0/0 | **2**: 006 = 39/0/0, 007 = 1/0/0 |
| VIVA_COR — ID30 | 19, todos falsos | **0** (e 9 ID29, como simulado) |
| ID30 na base × teto | 1822 contra 693 | **531 contra 524** |
| `sem_correlacao` do dia | 162 | 66 |
| `deviam_enviar` do dia | 1997 | 1363 |
| Invariantes | zeradas | zeradas |

Os 1363 ID30 que sobraram na `gatilhos_informacao_status` são **resíduo** do binário anterior,
congelados às 21:29 — separáveis por `ultima_atualizacao`. Curam sozinhos no laço do
`TAtualizarStatus`.

**Para forçar validação sem esperar:** reiniciar o monitor. `FDicRecon` e `FDicDestrava` são
dicionários em memória; sem a chave, o passe roda na primeira volta. O `fCarregarFilaIni` retoma a
fila persistida, então não se perde trabalho em andamento.

### O destravamento continua sem agir

56 candidatos às 22:06, e o VIVA_COR segue com as 9 linhas intactas — as 6 das 08:56 já com 13 h.
Nenhuma drenou nem depois do restart, que zera o corte de 10 min por cliente.

**Três suspeitos eliminados na bancada, sem o log:**

- `SQL_IDADE` rodada à mão contra o VIVA_COR devolve **9 pendentes** — o `EXISTS` por
  `GAT_DESCRI = GAT_ASSUNT` casa, o `GAT_LIBENV = 'S'` casa, e o corte de 20 h não corta as 6 linhas
  das 08:56.
- `SQL_CANDIDATOS` devolve 682 linhas, e o VIVA_COR está entre elas.
- `ExisteGatilhosInformacaoExecutando` **filtra por servidor** no `grep` — não é o veto global que eu
  suspeitava.

**Sobra a latência do ciclo.** O `DestravarFilas` roda no fim do `TEnviarGatilhos.Execute`, depois do
`for` inteiro sobre a fila e do `pLimparFilaIni` — e dentro daquele `for` há
`while QuantidadeGatilhosInformacaoExecutando >= MAX_THREADS do Sleep(5000)`. A duração do ciclo é
ilimitada, então a espera até o destravamento também é. Foi decisão minha pôr no fim, para não
competir por `MAX_THREADS` com o trabalho normal; o preço é esta latência, que eu não sei medir sem o
log. Se ela for grande demais, a saída é chamar o destravamento também no meio do `for`, a cada N
itens, e não trocá-lo de lugar.

### Achado lateral, anterior a este requisito

`CASA_DA_LAVOURA` e `CASA_LAVOURA` são o mesmo cliente cadastrado duas vezes na
`gatilhos_informacao`; `CIA_COR` tem três variantes do nome. Cada duplicata gera apuração própria
contra o mesmo banco. Não é defeito da reconciliação — é cadastro na central.

### 07/09 22:15, NACIONAL_MOTO_PECAS — o filtro por empresa validado sobre alvo em movimento

Seis empresas num banco só, 10 gatilhos agendados para 22:15. Acompanhado ao vivo, dos dois lados.

| empresa | 22:08 | 22:17 | Δ | agendado |
|---|---|---|---|---|
| 001 | 3/3/3 | 6/6/6 | +3 | 3 |
| 002 | 2/2/2 | 4/4/2 | +2 | 2 |
| 003 | 1/1/0 | 3/3/0 | +2 | 2 |
| 021 | 2/2/2 | 3/3/3 | +1 | 1 |
| 022 | 1/1/1 | 2/2/2 | +1 | 1 |
| 023 | 1/1/1 | 2/2/2 | +1 | 1 |

Cada delta bate com o agendamento. Antes da correção as seis linhas subiriam juntas para 10.

E a drenagem foi **imediata** — enfileirado 22:15:38, entregue no mesmo minuto — o que confirma que a
fila drena bem enquanto o cliente está sendo processado. Quem trava é quem não tem mais nada vencido.

### O carimbo de entrega também mente — e este cabe no monitor

A empresa 021 estava contada como entregue com `GAT_OBSWPP = 'HTTP/1.1 500 Internal Server Error'`.
A data de envio é gravada **mesmo quando o envio falha**. Vocabulário das observações neste cliente,
em três dias:

| canal | observação | qtd |
|---|---|---|
| mail | **Erro ao enviar E-mail** | 510 |
| mail | Enviado | 395 |
| mail | **Envio cancelado - Atraso(24h)** | 195 |
| wpp | Envio não previsto (canal não usado) | 906 |
| wpp | Envio cancelado - Atraso(24h) | 194 |
| wpp | Enviado | 35 |
| wpp | HTTP 500 / 503 / REST failed | 10 |

Mais erro que sucesso no e-mail, e tudo isso entrava em `entregues`. É o defeito de origem uma camada
abaixo: a coluna registra **tentativa**, não entrega.

**Corrigido no monitor** — `entregues` passa a exigir `GAT_OBSEMA = 'Enviado'` ou
`GAT_OBSWPP = 'Enviado'`. O literal vem do próprio consumidor: `untProcessaGatilhosImediatos.pas:581`
e `:615`, ramo `tpEnviadoOK`, e só nele. Extraído para `SQL_ENTREGUE`, usado pelas duas consultas.

**Decisão do usuário, 07/09/2026:** `Envio cancelado - Atraso(24h)` some no bolo de não-entregue, sem
coluna própria. É desistência deliberada do `fValidaDisparo`, mas para quem espera o relatório a
diferença não existe.

O `COMMENT` da coluna foi corrigido no `.sql` — precisa rodar o `ALTER`, senão a coluna descreve o
critério antigo num BI.

### Destravar só o que nunca foi tentado

O NACIONAL mostrou que o robô rodou às 22:15, drenou 5 das 10 e **pulou** as outras 5 — que ficaram
com `GAT_LIBENV = 'S'` e observação **vazia**. Linha que o consumidor alcançou e falhou tem observação
preenchida, e para essa subir o robô de novo só repete a falha.

Então o `SQL_IDADE` ganhou `COALESCE(GAT_OBSEMA,'') = '' AND COALESCE(GAT_OBSWPP,'') = ''`. O
destravamento existe para a fila que ninguém foi buscar; falha de envio é outro problema e vive na
mensagem por gatilho.

*Isto enfraquece a hipótese de latência do ciclo para o VIVA_COR — pode ser que lá também o consumidor
alcance e pule. O log do processo filho decide.*

### Simulado antes de compilar

| empresa | fila | entregues (antes) | entregues (depois) | nunca tentado |
|---|---|---|---|---|
| 001 | 6 | 6 | 6 | 0 |
| 002 | 4 | 2 | 2 | 2 |
| 003 | 3 | 0 | 0 | 3 |
| **021** | 3 | **3** | **0** | 0 |
| 022 | 2 | 2 | 2 | 0 |
| 023 | 2 | 2 | 2 | 0 |

A 021 deixa de mentir, as entregas reais não se mexem, e `nunca tentado` isola exatamente as 5 linhas
que o destravamento deve mirar.

### Anotação sem explicação ainda

O passe de reconciliação está reapurando a cada **~3,5 min** (22:17:44 → 22:21:08 → 22:24:12), e o
gate do `FDicRecon` é de 10. Ou há duas instâncias do `TAtualizarStatus` vivas depois do restart, ou o
dicionário está sendo recriado. Custa carga, não correção — mas quero entender.

### 07/09 22:45 — o log vivo chegou, e o destravamento não é o remédio

Logs trazidos para `\\citel-fileserve\USUARIOS\joao.catarino\GatilhosInformacaoEnviar\logs\` e
`...\GatilhosInformacaoAtualizar\logs\` — são **dois processos**, cada um com o seu
`monitor_20260907.log`. O que estava no share antes era cópia velha.

**O destravamento está vivo desde 21:08:46.** Ciclos de 1 a 2 minutos, 49 destravamentos até 22:40,
nenhum erro. *A hipótese de latência do ciclo estava errada* — o `Execute: for loop completo` aparece
a cada 1–2 min, não a cada hora.

**Mas só alcança dois clientes, e os repete:** ABRAFER 30×, AMAURI_TINTAS 19×, e mais ninguém — os
dois primeiros do alfabeto. Dois defeitos aí:

- o guard `MINUTOS_ENTRE_DESTRAVAMENTOS = 10` não segura (ABRAFER volta a cada 2–4 min);
- o laço não avança para o terceiro candidato, com 56 na lista. Sem exceção logada.

**E o que importa: destravar não resolve.** Depois de 30 subidas em 90 minutos, ABRAFER segue 4 na
fila / 1 entregue; AMAURI, 2 / 1. O robô sobe, roda e as linhas ficam.

Isso encaixa com o NACIONAL: aquelas 5 linhas têm `GAT_LIBENV = 'S'`, observação vazia e **zero
chamadas na `LOGAPI`** — nunca chegaram a chamar o gateway. São o mesmo formato. Existe uma classe de
linha que o consumidor alcança e não envia, e provocar drenagem só repete o nada.

**Consequência para o desenho:** o destravamento resolve o caso do MINAS BOMBAS — fila cheia porque
ninguém foi buscar — e não resolve este. Para este, o valor está em *tornar a falha visível*, que é o
que a correção do `entregues` faz. Consertar exige o robô, que hoje está fora de alcance.

### O ciclo de vida de uma falha de envio — lido no consumidor

Vale registrar, porque contradiz o que a parte 3 deste record afirmava sobre retentativa.

`pMarcaGatImeEnviado` zera `GAT_LIBENV` quando as **três** colunas de data estão preenchidas, sem
olhar se deu certo. E o ramo de erro é:

```pascal
tpEnviadoErro: pWhatsNaoEnviadoErro;
...
LErros := fRetErrosWhatsApp(AAutInc);   // ultimo LOGAPI com LOG_STATUS <> 200
if fEmptyStr(LErros) then
  Exit;                                  // nao carimba nada
```

Daí dois destinos:

| situação | carimbo | `GAT_LIBENV` | retentativa |
|---|---|---|---|
| erro **com** linha na `LOGAPI` | data + texto do erro | `'N'` | **nenhuma** — sai da fila, gatilho perdido no dia |
| erro **sem** linha na `LOGAPI` | nenhum | fica `'S'` | **infinita e silenciosa** — volta em toda passada |

Confirmado no NACIONAL de 07/09: empresa 021 tem 1 log com status ≠ 200 e ficou `'N'` com
`HTTP/1.1 500`; as 5 pendentes de 002 e 003 têm **zero** logs e seguem `'S'` com observação vazia.

**Onde a falha fica registrada:** `GATIME_WPPEMA.GAT_OBSWPP` é resumo; a fonte é a **`LOGAPI`**
(`LOG_LOGAPI = 'QUALIZAP'`, `LOG_SEQFGO` = `AUTOINCREM` da linha, `LOG_STATUS`, `LOG_RESULT`). A
`WPPENV` não tem coluna de status nem de erro — só ganha linha quando o envio dá certo, e por isso a
empresa 021 não aparece nela hoje.

### Caso para o suporte — NACIONAL_MOTO_PECAS, empresa 021

WhatsApp parou em 04/09 e falha para **todos** os destinos, inclusive os mesmos números que
funcionavam antes. Não é destinatário: é a instância ou credencial do QualiZap dessa empresa. As
empresas 022 e 023 seguem enviando normalmente para dezenas de destinos. Até esta correção, esses
envios contavam como **entregues**.

## Sessão de 08/09/2026 — primeiro dia útil com o alarme calibrado

### O que o dia mostrou

Deploy do `entregues` confirmado às 06:56:04: `NACIONAL_MOTO_PECAS` empresa 021 caiu de **2/2/1**
para **2/2/0**. As duas linhas dela são `HTTP/1.1 500`, e o WhatsApp da 021 falha desde 04/09 para
todos os destinos.

Dois clientes mudaram de lado só por causa do critério novo: `RITEC_FERRAMENTAS` estava 1/1/**1** e
`CONARA` estava 2/1/**1**; com a observação valendo, viraram **0**. Eram invisíveis ontem.

`palmares` não apareceu — o controle negativo passou.

### Caso a caso: CONARA, para medir se dá para responder um chamado

Estado às 07:05: **2 deviam / 1 na fila / 1 entregue**.

| Gatilho | Descrição | Destino | Desfecho |
|---|---|---|---|
| 000120 | ENTREGAS A RECEBER EM ABERTO | ricardoconara71@gmail.com | **Entregue** 07:03:53 (enfileirado 06:50:49) |
| 000011 | WAG PRODUTOS COM ST E TRIBUTAÇÃO | fiscal3@conara.com.br | **Não gerou linha na fila** — carimbou sucesso às 06:50:34 |

Isso já responde as duas perguntas que um chamado traz: *chegou?* e *se não, onde parou?* O que
ainda não responde é **por quê** o 000011 não gerou linha.

**Cuidado ao ler a tabela de divergência: ela é um instantâneo.** Às 06:58 o CONARA aparecia como
"nada entregue" porque a entrega saiu às 07:03. Comparar leituras de momentos diferentes gera falso
diagnóstico — foi o que eu fiz, e a apuração seguinte me corrigiu.

### `GAT_RELSTA` não é a flag de "enviar sem dados"

Hipótese levantada pelo usuário. Descartada: `GAT_RELSTA` ('Alerta' / 'Normal') só é passada para
`TfrmGatilhosInformacaoImagemAnexo.GetImagem`, que monta o cabeçalho da imagem do e-mail e do
WhatsApp. Não decide envio. A flag, se existe, está em outro lugar — vale perguntar em que tela o
usuário a viu antes de caçar.

### A cegueira que sobrou: o log do processo filho não existe

O monitor passa `--logsactive --output="logs/<SERVIDOR>/AAAAMMDD_HHNNSS_EMP.log"`, caminho absoluto e
correto. Mas em 08/09 a pasta do CONARA estava **vazia** mesmo depois do 000011 falhar. Na cópia de
07/09 22:40, das **565 pastas de cliente só 11 tinham algum arquivo**, e o maior tinha 90 bytes.

Quem escreve aquele arquivo é o robô, hoje fora de alcance. **O que o monitor podia fazer, e não
fazia: ele jogava a saída do filho em `> /dev/null`.** Exceção não tratada no Linux sai em stderr, e
era exatamente ela que se perdia.

### Duas peças novas no monitor, aguardando compilação

| Peça | O que faz |
|---|---|
| Captura da saída do filho | `>> logs/<SERVIDOR>/AAAAMMDD_EMP_stdout.log 2>&1` em vez de `/dev/null`. Um arquivo por cliente e por dia, em append — um por disparo daria milhares |
| `pExpurgarLogs` | Roda uma vez por dia em **cada** processo, limpando o próprio `logs/`. `--dias_log=`, default 15; `0` desliga. Remove `*.log` vencido e a pasta do cliente **só se ficar vazia** |

O expurgo tira a idade da **data no nome**, não do `mtime`: os dois formatos trazem `AAAAMMDD`, e o
`mtime` muda quando alguém copia a pasta para o share — com `mtime` o expurgo apagaria justamente o
que acabou de ser copiado. Arquivo sem data legível no nome não é tocado.

### Lição sobre o próprio `.sql`

Rodar o script inteiro às 06:54 esvaziou a `gatilhos_informacao_divergencia`: ele carregava um
`CHANGE carimbados …` de coluna que já não existia e um `DELETE … WHERE data_ref = '2026-09-07'`,
sobras de migração do dia anterior. A apuração é derivada e voltou no passe seguinte, mas a
`primeira_deteccao` do dia se perdeu. Os dois comandos saíram, o `COMMENT` correto foi para dentro do
`CREATE`, e o arquivo agora é seguro de rodar inteiro. **Migração de uma vez não mora em script de DDL
versionado.**

### 08/09 08:19 — o carimbo passou a dizer a verdade

Piloto do build novo no CONARA, gatilho 000011, executado à mão. Resultado:

```
GAT_ULTMSG = "08/09/2026 08:19:21 - Nao ha dados para gerar o relatorio!"
```

Contra `"Gatilho enviado com sucesso!"` do build de 02/06, para exatamente a mesma condição.

E o filtro de não-envio legítimo do monitor reconhece sozinho — `%dados para gerar o relat%` casa, e
o gatilho sai de `deviam_enviar`. **O falso positivo se resolve sem nenhuma mudança no monitor.**

Sem acento, por causa do `fRemoveAcento` do `AtualizarUltimaMsg`. É o motivo de os quatro `LIKE` do
filtro terem sido escritos sem acento desde o início; e a collation `latin1_swedish_ci` é
accent-insensitive, então casaria de qualquer jeito.

### A mudança que produziu isso

Dois pontos simétricos em `untGatilhosInformacao.pas` — `ExecutarRelatorioParaEmail` e
`ExecutarRelatorioParaWhatsApp`. Onde o robô gravava `'Arquivo PDF nao existe'`, passa a preferir o
`VS_UltimaMensagemAoUsuario`, que o `pMensagemOk` do gerador de relatório já tinha preenchido:

```pascal
procedure pMensagemOk(AMsg: string; ...);
begin
  WriteLog(AMsg);                                          // a linha do stdout
  AddOrSetGlobalVar('VS_UltimaMensagemAoUsuario', AMsg);   // e o valor, aqui
```

Sob `{$IFDEF LINUX}`: no Windows a tela já mostrou a mensagem, e mexer ali obrigaria a recompilar o
`autcom.exe` inteiro sem ganho.

Com um `AddOrSetGlobalVar('VS_UltimaMensagemAoUsuario', '')` antes de cada `pExecutaRelatorio` — a
global é do processo, não do gatilho, e sem zerar o próximo a desistir herdaria o motivo do anterior.

**A alternativa descartada foi raspar o texto do `_stdout.log`.** Correlacionar por horário funciona
(carimbo e log batem no mesmo segundo), mas é regra enunciada longe de onde nasce: muda o texto e
quebra. Proposta e recusada pelo usuário com o argumento certo — *"deveria estar lá no campo do
gatilho"*.

### Duas descobertas de bancada no caminho

- **`GATINF=<codigo>` é o atalho para testar um gatilho.** `untExecutarGatilhos.pas:104` desvia para
  `TGatilhosInformacaoMonitor.New(...).pExecute` e sai — ignora agendamento, `GAT_PROENV` e
  `GAT_ULTENV`. Não precisa mexer em data nenhuma para reproduzir um caso.
- **O deploy do PAServer em Release não leva todos os arquivos.** Buildar em Debug leva. É o que
  explica o binário de produção ter 331 MB e o primeiro build novo ter 84 MB — e por que rodar do
  scratch do PAServer morria calado: sem `libGatIme.so` ao lado, o `pLoadLibGatIme`, que é a primeira
  instrução do caminho do `GATINF=`, falha sem mensagem.

### 08/09 10:00 — o `opcoes.ini`, e a regressão foi minha

**O `cd <pasta>` que eu introduzi para versionar o robô deixou o `opcoes.ini` fora.**

O arquivo tem 28 bytes e uma linha que importa: `FORCAR_ENVIO_EMAIL=S`. Sem ele o valor volta ao
default `N`, e a `libGatIme` recusa o envio com **"Nao e permitido enviar e-mail nesse banco de
dados!"** — *antes* de qualquer chamada ao gateway. Logo: nenhuma linha na `LOGAPI`, nenhuma
observação na fila, `GAT_LIBENV` seguindo `'S'`.

Descoberto pelo usuário, que reparou na pasta e leu o arquivo. Eu não achei em um dia de
investigação porque a assinatura era indistinguível de "o consumidor alcança a linha e não envia" —
e eu tinha classificado exatamente assim, com confiança.

No comentário do `ShellExecute` eu havia listado o que o `cd` protegia: `.fr3`, `.png` e
`libmysqlclient.so`. **A lista estava incompleta, e a incompletude custou o dia.**

**Estrago medido:** ~1100 erros na `LOGERR` de **16 clientes** em 08/09 — MADESIL 375, GERACOR 232,
MANTELLI 139, e treze outros de 2 a 40. Mais as 28 filas cheias sem entrega, o ABRAFER destravado 30
vezes sem drenar e o AMAURI 19.

**Conserto:** link simbólico, não cópia — cópia diverge na primeira edição de um dos lados.

```sh
cd /ServicosCitel/GatilhosInformacaoEnviar
for D in robo_*; do ln -sfn ../opcoes.ini "$D/opcoes.ini"; done
```

**Efeito imediato**, no VIVA_COR: de 9 linhas paradas sem nenhuma tentativa para **zero sem
tentativa**; 206 linhas no dia, 162 entregues.

E o que sobrou é falha de verdade, agora visível:

| Canal | Desfecho | Qtd |
|---|---|---|
| WhatsApp | Enviado | 140 |
| WhatsApp | `{"message":"Header file required"}` | **39** |
| E-mail | Enviado | 22 |
| E-mail | Erro ao enviar E-mail | **5** |

Pelo critério antigo — data preenchida — essas 206 linhas contariam **206 entregues**. As 44 falhas
eram invisíveis, e os gatilhos correspondentes diriam "Gatilho enviado com sucesso!".

**Pendências que nascem daqui:**

- `{"message":"Header file required"}` é assinatura nova, 39 ocorrências num cliente só, fora do
  catálogo `gatilhos_informacao_tipo_erro`. Parece anexo faltando na API do QualiZap.
- Conferir se o backlog preso desde 07/09 00:35 passou de 24 h e foi cancelado pelo `fValidaDisparo`
  com `Envio cancelado - Atraso(24h)` — nesses casos a mensagem não chegou e não será reenviada.
- **Aviso acrescentado no monitor** (aguardando compilação): se a pasta escolhida não tiver
  `opcoes.ini`, o log grita com o comando do link. Grita e não impede — versão futura do robô pode
  não precisar do arquivo, e travar o disparo seria pior que o defeito.

### 08/09 11:30 — o guardrail de capacidade, restaurado

**Eu removi o guardrail que existia.** Ao criar o versionamento por pasta, apaguei o
`GetClienteConsomeGatilhosImediatos` e o `fServidorUsaLibGatIme` como código morto, e com eles o
único critério que decidia quem entrava na fila. De 07/09 até agora, **todos os 402 clientes rodavam
`robo_libgatime` sem nenhuma verificação** — nem a detecção automática que a r491154 tinha.

Foi o usuário quem lembrou. A regra, na ordem que ele definiu:

```
cliente tem condição de usar a libgatime?
  ├─ sim  → tabela gatilhos_informacao_robo diz qual pasta; sem linha, --pasta_default
  └─ não  → --pasta_sem_gatime (robo_velho), e a tabela nem é consultada
```

**A diferença em relação ao original.** A r491154 media `MAX(GAT_D_EWPP)` e `MAX(GAT_D_EEMA)` — as
colunas de **data**, que são carimbadas mesmo quando o envio falha. Ela respondia "sim, consome" para
cliente que só acumulava erro: detectava tentativa, não capacidade. Foi assim que 162 clientes
entraram de uma vez em 25/08. Agora o critério exige `GAT_OBSEMA = 'Enviado'` ou
`GAT_OBSWPP = 'Enviado'` — a frase do usuário, *"movimento na libgatime e inclusive enviados"*.

**Conta qualquer entrega, não só de gatilho — de propósito.** Eu propus restringir a gatilho de
informação com o semi-join da reconciliação, e o usuário derrubou: a pergunta é se a fila e o
consumidor funcionam no cliente, e boleto entregue responde isso igual. Restringir criaria porta de
mão única — cliente em modo síncrono não gera linha de gatilho na fila e nunca mais seria promovido.

**E a linha do MARCIUS não é redundante, é indispensável.** Eu disse que a regra a tornava
dispensável; medi e é o contrário. Ele tem **1852 entregas em 7 dias** — boleto, PIX, nota, cupom,
orçamento. Pela regra é apto, e sem a linha na tabela seria promovido de volta para uma pasta onde o
gatilho dele quebra por outro motivo (anexo no share UNC). Os dois mecanismos respondem perguntas
diferentes:

| | Responde |
|---|---|
| Aptidão | a fila funciona neste cliente? |
| Tabela | este cliente tem problema específico com gatilho? |

**O piso saiu de medição, não de palpite.** Nos 109 clientes com atividade em 08/09:

| Entregas em 7 dias | Clientes | | Piso | Rebaixados |
|---|---|---|---|---|
| 0 | 8 | | 1 | 8 (7%) |
| 1 a 9 | 7 | | 10 | 15 (14%) |
| 10 a 49 | 10 | | **20** | **20 (18%)** |
| 50 a 199 | 21 | | 30 | 21 (19%) |
| 200 ou mais | **63** | | 100 | 33 (30%) |

Distribuição bimodal, e entre 10 e 30 a curva é rasa — qualquer valor ali separa as duas populações
sem cortar nenhuma no meio. Escolhido **20** pelo usuário.

**Parâmetros novos**, aguardando compilação:

| Parâmetro | Default |
|---|---|
| `--dias_gatime=` | 7 — mesma janela da r491154; `0` desliga o guardrail |
| `--min_entregas_gatime=` | 20 |
| `--pasta_sem_gatime=` | `robo_velho` |

**Decisão de projeto:** na dúvida, versão corrente. Sem conexão com o cliente ou com erro na
consulta, devolve apto — rebaixar por dúvida manda cliente saudável para um binário de 05/04 que não
se recompila.

**Descartado, com o motivo:** rebaixar por *erro* em vez de por *capacidade*. Se essa regra
estivesse ativa na manhã de 08/09, teria rebaixado 23 clientes saudáveis por causa do `opcoes.ini`
que nós tiramos do lugar. Capacidade medida em sete dias não se deixa levar por um incidente de uma
manhã.

### 08/09 11:47 — guardrail no ar, 22 rebaixados

Monitor compilado e trocado nas duas instâncias. A varredura estabilizou em **88 de 110** linhas
reapuradas, e as **22 congeladas** são os rebaixados — cliente que vai para `robo_velho` sai da
reconciliação pelo `fVersaoEnfileira`, então a linha dele para de ser atualizada. A previsão da
medição era 20.

**Onze dos 22 entregam tudo que enfileiram** — COFER 3/3/3, EMIDIO 2/2/2, GRUPO_IRMAOS 2/2/2,
MARJO 2/2/2, QUIBAO 1/1/1, RITEC 1/1/1 e outros. Foram rebaixados por **volume**, não por falha:
entregam 2 ou 3 por dia e não somam 20 em sete dias.

Eu levantei isso propondo baixar o piso para 10, e o usuário manteve 20 com um argumento melhor:
*"se o cliente não enviou nem 20 pela GATIME_WPPEMA, deixa ele quieto na velha mesmo; time que está
ganhando não se mexe, ou se mexe de forma controlada."* Cliente de pouco tráfego tem **pouca
evidência** de que a fila funciona nele — promovê-lo é risco sem ganho, e a promoção controlada já
existe: um `INSERT` na tabela, com nome, data e motivo, um cliente por vez.

**Decisão registrada: `--min_entregas_gatime=20`.** E a lista dos 22 passa a ser a fila natural de
piloto do `robo_novo` — promover de `robo_velho` para uma versão viva, um por vez, em vez de deixá-los
presos num binário de 05/04.

**Dois casos na lista que não são do guardrail:**

- `AUTOTINTAS_UNIAO_002` (30 / 0 / 0) — rebaixado com razão, mas a causa é `ID28`, autenticação de
  e-mail. No síncrono vai continuar falhando.
- `BELATINTAS` 008 congelou às **08:06:54**, muito antes da troca das 11:43. Não é o guardrail —
  é outra coisa, e ficou para olhar.

## 08/09/2026, tarde — MARCIUS, e um AV no relatório de dashboard

### Onde parei: o AV

Executado à mão o gatilho 000001 do MARCIUS pelo `robo_novo`, com `--logssql`. O ponto exato:

```
SELECT COM_COMPOS, COM_FORMUL FROM COMCUS WHERE COM_DESCRI = 'CUSTO'
SELECT TRUE
DROP TABLE IF EXISTS `TMP_VENDA_GATILHO{ECD6907B-AAAB-F111-90D4-020017064C0E}`
DROP TABLE IF EXISTS `TMP_VENDA_ANOANT{38DB907B-AAAB-F111-90D4-020017064C0E}`
Access violation at address 0000000001C6F25B, accessing address 0000000000000000
```

Derruba as duas temporárias e **não cria nenhuma**. O mesmo par de `DROP` aparece duas vezes no log,
a segunda imediatamente antes do AV. Relatório **538892**, `REL_DESTIN = "Card  Dashboard"`,
`IMAGEM_CABECALHO` com valor vazio.

**E o AV é engolido, com carimbo de sucesso no mesmo segundo:**

```
Access violation ...
SHOW VARIABLES                                      <- conexão NOVA
UPDATE GATINF SET GAT_ULTMSG = "... - Gatilho enviado com sucesso!"
UPDATE GATINF SET GAT_ULTENV = CAST("2026-09-08 14:26:53" AS DATETIME)
```

O `SHOW VARIABLES` entre o AV e o `UPDATE` é abertura de conexão. Quem carimbou não é quem executava.

### O mistério da string, agora com pista

`"Gatilho enviado com sucesso!"` **não existe em nenhum código do ramo** — a única ocorrência hoje é
um comentário que eu escrevi. E o `robo_novo` foi compilado hoje, do fonte atual, e gravou essa
mensagem mesmo assim.

Logo: **quem grava não é o `GatilhosInformacao`.** Sai da `libGatIme.so` ou de outro binário. Isso
explica por que a correção de hoje de manhã (`VS_UltimaMensagemAoUsuario`) não teve efeito neste
caminho, e por que a string nunca apareceu nas buscas desde o primeiro dia.

**Próximo passo, decisivo e barato:** `strings libGatIme.so | grep -i "enviado com sucesso"`.

### O que caiu hoje, das minhas hipóteses sobre o MARCIUS

Registro porque cada uma custou tempo e eu afirmei antes de medir:

| Hipótese | Como caiu |
|---|---|
| "Quebra no enfileiramento por share UNC" | O enfileiramento funcionou; o e-mail saiu "Enviado" em 02, 03 e 04/09 |
| "O erro de `fRetBase64ParaArquivo` impede o WhatsApp" | É a **imagem do corpo do e-mail**; o e-mail foi entregue segundos depois, no mesmo instante do erro |
| "Ninguém pede bucket no enfileiramento" | A DLL **já sobe** para o bucket: `if not ArmazenadoNoBucket then fUploadFile(...)` |
| "O anexo viaja como caminho local" | `GAT_ARQBCK` e `GAT_PATARQ` estão **os dois vazios** — não há anexo nenhum |
| "Os PNGs faltam em `robo_novo`" | Estão lá, 104 KB e 39 KB |

### O que ficou estabelecido

- **Os 6 gatilhos do MARCIUS são WhatsApp** (`GAT_WPPENV='S'`); três também mandam e-mail.
- Em modo fila, 25/08 a 05/09: o **e-mail saiu**, o **WhatsApp não gerou linha**. O cliente recebe por
  WhatsApp — daí "não recebo desde 29/08" com `GAT_ULTENV` dizendo sucesso.
- O relatório é **dashboard**, caminho de código diferente do CONARA (que é PDF). O AV está aí.
- A drenagem da fila é disputada entre o robô Linux e as estações Windows do cliente
  (`CV1-VENDAS-04`, `CV2-VENDAS2`, `MC1-CAIXA3`). O atraso variou de **0 a 212 minutos** conforme qual
  máquina estava ligada; em 05/09 ninguém drenou e as linhas morreram com `Atraso(24h)`.
- **O consumidor que não alcança o arquivo não erra: desiste calado** (`Exit` na linha 1009,
  `tpTentarNovamente` no WhatsApp). Por isso funcionava de manhã, quando as estações voltavam.

### Efeitos colaterais do teste, para não assustar

O gatilho 000001 teve `GAT_ULTENV` carimbado às 14:18 e 14:26, e o `GAT_PROENV` foi para **09/09
18:29**. A execução normal de hoje às 18:29 não vai acontecer para ele.

### Ainda a confirmar no VIVA_COR

9 linhas na `GATIME_WPPEMA`, nenhuma entregue: 6 de 08:56–08:57 e 3 de 21:28. A divergência foi
gravada 21:15 e reapurada 21:29, então ele é candidato a destravamento (`chegaram_na_fila` 9 >
`entregues` 0, fila com ~12 h). O log disponível no share para em 20:02 — não dá para dizer se o
`DESTRAVANDO` disparou. **Primeira coisa a olhar no log de amanhã.**

Hoje foram **69 candidatos a destravamento** em 238 clientes com linha de divergência, e **28 deles
com fila cheia e zero entregue** — nenhum drenou até 21:45, meia hora depois da primeira apuração.
Pode ser o defeito 4 acima, pode ser o `ExisteGatilhosInformacaoExecutando` sempre verdadeiro, pode
ser só falta de ciclo. **Não dá para decidir sem o log vivo** — é o primeiro item de amanhã.

Amostra dos 28, para conferir depois do rebuild: `FENIOR` 011 (15/15/0), `TINTAS_MC_FRANQUIAS_LJ162`
(8/10/0 — a fila maior que o devido é a inflação por empresa), `VIVA_COR` 004 (16/9/0),
`MADEIREIRA_BEIRA_RIO` 001 (11/7/0), `REIMAC` 001 (32/4/0).

### Checklist de amanhã cedo

1. `gatilhos_informacao_divergencia` de 08/09 — poucas linhas e cada uma explicável significa alarme
   calibrado; tabela cheia significa mais caminho de não-envio legítimo a filtrar.
2. **`palmares` não pode aparecer.** Se aparecer, o defeito é do filtro, não do cliente.
3. `ismafer` — a fila drenou na mesma noite? É o teste do destravamento.
4. MINAS BOMBAS — enfileirou 18:00–18:15 e drenou em minutos, em vez de 07:30?
5. `gatilhos_informacao_status` — mensagens `ID29`/`ID30` gravadas por gatilho.
6. Log: `DESTRAVANDO`, `Robo escolhido ... (FIXADO)`, `Passe de reconciliacao concluido`.

## Pendente — execução

Ver `plan.md`. As tarefas marcadas **[USUÁRIO]** — compilar, implantar, aplicar DDL — não são
minhas. Os casos de teste são do analista; não há projeto de teste para o monitor.

Fora de escopo, e continua valendo: a correção do carimbo na origem, o defeito da linha ~2033, o
share do MARCIUS e o cadastro do BELATINTAS.

## Histórico — escopo antes do desenho

Diagnóstico fechado. O que falta é decisão, não investigação. O problema atinge **todo cliente
fora da whitelist que já usava gatilho imediato** — não é específico do MINAS_BOMBAS. Vale
levantar quantos são antes de escolher o caminho.

Caminhos possíveis, do mais contido ao mais amplo:

1. **Drenar a fila no fim da própria execução que a encheu.** Ataca a causa: hoje
   `pProcessarGatilhosImediatos` roda no fim do `pExecuteAll`, mas o processo que gerou os
   gatilhos das 18h termina antes de qualquer coisa nova vencer. Investigar por que o passo final
   não drenou naquelas noites — é a lacuna que sobrou.
2. **Desfazer a migração automática** de quem não está no `libgatime_clients.txt`, voltando a
   whitelist a ser o gate. Contém o estrago imediato sem tocar no consumidor, mas devolve o
   problema que a r491154 queria resolver.
3. **Disparo do consumidor independente do vencimento de gatilho** — o monitor da Citel só spawna
   quando há gatilho vencido, então a fila fica órfã fora dos horários agendados.

Ao decidir, considerar também o defeito independente da linha ~2033 descrito na parte 1
(gatilho que atravessa a meia-noite é descartado carimbando sucesso). Ele não causou este
chamado, mas produz o mesmo sintoma para o usuário e está no mesmo caminho de código.

`spec.md` e `plan.md` não existem por opção do usuário ("só investigar agora, spec depois").


### 08/09 15:30 - o AV: ponteiro de funcao nulo no TSafeThread

**Nao era do relatorio.** O relatorio de dashboard so e quem cria a thread.

```
untFuncoesSimples.pas:61612          <- assina os ponteiros no Windows
    TSafeThread.fGetEmpresaLogada := ...
    TSafeThread.pSetaEmpresaLogada := ...
       |
       nao esta no .dpr do robo -> a initialization nunca roda no Linux
       |
Services.Core.Connection.Manager.pas:5820   <- o substituto Linux
    assina TDBUtils.fGetEmpresaLogada   OK
    NAO assina TSafeThread.*            <- o buraco
       |
       v
TSafeThread.fGetEmpresaLogada = nil
       |
untThreadUtils.pas:933
    FThread.FInitCodEmp := fGetEmpresaLogada;   <- FInitCodEmp e String,
       |                                          entao a atribuicao CHAMA o ponteiro
       v
Access violation ... accessing address 0000000000000000
```

**Como se chegou la, e o que custou caro.** Duas voltas foram gastas concluindo sobre o binario
errado: o exe em `robo_novo` era de 02/07, e nao o build do dia. A string `Gatilho enviado com
sucesso!`, que nao existe em lugar nenhum do ramo, era o `MSG_SUCESSO_ENVIO` daquela versao - o
mistero que atravessou o requisito inteiro era so um binario velho. **Descoberto pelo usuario**, que
olhou a data do arquivo. A licao: antes de tracar fonte contra execucao, provar que o binario e o
fonte.

O que resolveu em uma linha, depois da troca do exe:

```
addr2line -e GatilhosInformacao -f -C -i 0x1A44651
-> Untthreadutils::TSafeThread::TSafeThread(bool)
```

O binario e buildado em Debug, entao tem DWARF. **`addr2line` no endereco do AV custa segundos e
dispensa instrumentar e recompilar** - vale como primeiro passo em qualquer AV de servico Linux.
(`strings` no binario precisa de `-e l`: literal Delphi e UnicodeString, UTF-16LE.)

**A confirmacao que fecha:** duas classes ja fogem do TSafeThread no Linux -

```pascal
TThreadSincronizaEmails = class({$IFDEF LINUX}TThread{$ELSE}TSafeThread{$ENDIF})
TThreadEnviaEmail       = class({$IFDEF LINUX}TThread{$ELSE}TSafeThread{$ENDIF})
```

Alguem ja bateu neste AV e contornou classe a classe, sem tocar na causa.

**Alcance.** Qualquer descendente de TSafeThread num servico Linux morre igual - TThreadRelatorio,
TExecucoes, TMonitorRep, TStartFatImpressao. Nao e bug do MARCIUS nem de gatilho.

**Correcao aplicada, dois pontos:**

1. `Services.Core.Connection.Manager.pas`, initialization: assina os dois ponteiros a partir de
   `Services.Core.Settings`. Restaura o comportamento - a thread herda a empresa de quem a criou.
   `untThreadUtils` entrou no uses da `implementation`; a referencia circular e legal porque a
   `interface` da untThreadUtils ja usa a Connection.Manager pelo services.core.uses.inc. Os
   ponteiros sao class var (zero-inicializados no load), entao a ordem de initialization nao importa.
2. `untThreadUtils.pas:933 e :1064`: guarda `Assigned`. Sozinha ela tiraria o AV mas deixaria a
   thread nascer com empresa vazia - erro silencioso, pior que o crash. Por isso as duas.

**O carimbo falso ficou provado no mesmo log**, e e defeito independente:

```
AV -> engolido em untRelatorio.pas:3033
   -> Result := ''
   -> 'Url Dashboard em branco' + Result := True   (untGatilhosInformacao.pas:1418-1421)
   -> ExecutarEnvio := True                        (:940)
   -> pExecute: AtualizarDataEnvio                 (:2014)
```

`GAT_ULTENV` avancou e `GAT_PROENV` foi para 09/09 18:29 - o gatilho falhou e sumiu do dia.
`Result := True` sai de "ja tratei" e chega como "enviei". Nao corrigido ainda.


### 08/09 15:45 - atras do AV havia um deadlock, e ele explica os blnConexaoIndependente := False

Corrigido o ponteiro nulo, o robo deixou de estourar e passou a **travar**. Backtrace do gdb no
processo vivo (`gdb -p PID -batch -ex "thread apply all bt"`):

```
Thread 2 (worker)  -> terminou o trabalho
   TThread.DoTerminate
   -> Synchronize(OnTerminate)
   -> TMonitor.Wait(Timeout = 4294967295)      <- INFINITO, esperando a main drenar a fila

Thread 1 (main)    -> untInterfaceRelatorio.fExecutaThread
   While Not objThread.blnTerminou Do
     Sleep(50)
    {$IFNDEF LINUX}
     Application.ProcessMessages                <- era ISTO que drenava no Windows
    {$ENDIF}
```

As duas se esperam. `blnTerminou` so e setado depois do `OnTerminate`, que nunca roda.

`TSafeThread.Create` atribui `FThread.OnTerminate` **sempre** (untThreadUtils.pas:942), e o
`TThread.DoTerminate` da RTL so chama `Synchronize` quando o evento esta atribuido. Logo: **qualquer
TSafeThread que chegue ao fim num processo Linux sem message pump trava** - nao e do relatorio.

**E isto explica os `blnConexaoIndependente := False` espalhados sob IFDEF LINUX.** Segundo o
usuario, foram postos em varios pontos sem nunca se descobrir a causa - so se sabia que resolvia.
Resolviam porque impedem a criacao da thread naquele caminho. Contorno, nao conserto: por isso
precisou de copia nova a cada caminho novo, e por isso este caminho (fLeDadosProgresso, com
blnConexaoIndependente True) continuou quebrado.

**Passo 1, aplicado:** `CheckSynchronize` no laco de espera do `fExecutaThread`, sob `{$IFDEF LINUX}`,
simetrico ao `ProcessMessages` que ja estava la. E o que o ProcessMessages chama por baixo. Nao muda
em qual thread nada roda.

**Passo 2, nao feito:** no `TSafeThread`, sob IFDEF LINUX, nao atribuir `OnTerminate` e chamar
`OnTerminateEvent` no fim do `Execute`. Mata a dependencia de message pump para todo TSafeThread e
permite remover os `blnConexaoIndependente := False` um a um, com teste. Ressalva: o
`FOnTerminateProp` passaria a rodar na worker em vez da main - no Linux os usuarios sao codigo de
servico sem VCL, mas confere-se caso a caso. Deploy separado.

**O que nao fazer:** cacar quem passa `True` e forcar `False`. Seria a enesima copia do contorno.

**Metodo que resolveu:** `gdb -p PID -batch -ex "thread apply all bt"` no processo travado deu a
resposta inteira em um comando. Antes dele, `cat /proc/PID/task/*/wchan` ja separava as hipoteses
(`futex_wait_queue_me` = espera por lock; `R` = laco de CPU). Vale como primeira parada em
travamento de servico Linux, do mesmo jeito que o `addr2line` vale para AV.


### 08/09 16:15 - a causa raiz do WhatsApp do MARCIUS, e o registro de conexao duplicado

Com o deadlock resolvido o robo voltou a travar, agora com **uma thread so** no gdb: a worker tinha
morrido, mas `blnTerminou` continuava False. Como `TThreadRelatorio.Execute` engole toda excecao e
**sempre** termina com `blnTerminou := True`, `False` prova que o `Execute` nunca rodou. Confirmado
com `grep -c "TThreadRelatorio.Execute" no log: 0`.

O que roda antes dele:

```
worker -> TSafeThread.Connections.GetThreadConnection
       -> CreateConnection  (untThreadUtils.pas:770, ramo LINUX)
       -> objConnectionsManager.CurrentConnection
       -> raise EThread "No current connection for thread"   (Connection.Manager:4781)
       -> ExecuteMethod nunca roda -> blnTerminou fica False
       -> quem espera gira em Sleep(50) para sempre
```

**Dois registros de conexao por thread competindo:** o `TThreadConnections` do TSafeThread e o
`FDicConn` do connections manager. No Linux o legitimo e o do manager, alimentado por
`BeginThreadConnection`. Mapeado quem depende do outro: no Linux, **so** o proprio
`TThreadExecute.Execute` - o unico outro consumidor, untDBUtils.pas:2780, ja estava sob `{$ELSE}`.
E o `LConn` que ele devolve so e lido no ramo Windows do except. Decisao (do usuario): no Linux nao
usar `TThreadConnections` de forma alguma, so `Begin/EndThreadConnection`. Cai de duas conexoes por
worker para uma.

### E quem passava True: um literal numa sobrecarga

`untRelatorio.pas:3067` - a sobrecarga `fRetornaUrlDashBoardGatilho(var AJsonDadosEnviaWhatsapp; ...)`
cria o TRelatorio com `blnConexaoIndependente` **True fixo, sem IFDEF**. Como o objRel chega pronto na
sobrecarga interna, `blnObjRelExterno` fica True e o `{$IFDEF LINUX}False{$ENDIF}` da linha 2968 e
calculado e descartado.

```
e-mail    -> untGatilhosInformacao:1138 -> sobrecarga SEM objRel -> IFDEF vale -> sincrono -> FUNCIONA
WhatsApp  -> untGatilhosInformacao:1395 -> sobrecarga COM objRel -> True fixo  -> thread  -> TRAVA
```

**E a explicacao do sintoma que abriu o caso**: no MARCIUS o e-mail entregava e o WhatsApp nunca
enfileirava. Nao era rede, nem bucket, nem estacao Windows concorrendo.

Escolha do usuario: **nao** trocar o True por False - consertar o `BeginThreadConnection` e deixar
conexao independente funcionar de verdade no Linux. Se funcionar, os `blnConexaoIndependente := False`
espalhados podem cair um a um.

**Correcao sobre o que eu havia afirmado.** Eu disse "nunca cacar quem passa True para forcar False".
Estava certo enquanto a causa era desconhecida - contorno cego se multiplica. Deixou de valer quando a
causa apareceu: a decisao de plataforma ja existia na linha 2968, e esta sobrecarga a contorna sem
querer. Alinhar as duas seria conserto. O usuario preferiu ir mais fundo, e melhor.

### Windows fica quieto

Pedido explicito do usuario. Estado final das cinco alteracoes:

| Alteracao | Windows |
|---|---|
| ponteiros do TSafeThread na Connection.Manager | nao compila - `autcom.groupproj` nao referencia nada de Services/ |
| guardas `Assigned` no untThreadUtils | sem efeito - untFuncoesSimples assina, `Assigned` sempre True |
| Begin/EndThreadConnection | ramo `{$ELSE}` e o codigo original; `var LConn` sob `{$IFNDEF LINUX}` |
| CheckSynchronize | sob `{$IFDEF LINUX}`; ProcessMessages intacto |
| saida por `objThread.Finished` | sob `{$IFDEF LINUX}` - o defeito existe no Windows tambem, mas o laco roda ha anos em producao |

### Anotado, nao corrigido

`TThreadConnections.GetThreadConnection(intThreadId: Cardinal)` recebe **Cardinal (32 bits)** e o
ThreadID do Linux x64 e 64. Truncava. Deixa de importar no Linux com a mudanca acima, mas e a mesma
familia de bug de ThreadID que ja mordeu este projeto antes.


### 08/09 16:45 - o erro de SQL, e um caso reproduzivel do bug de bind do UniDAC

Removidos o AV, o deadlock e a falta de conexao na worker, o gatilho chegou ao banco e falhou com
mensagem de verdade:

```
#42000 Incorrect number of arguments for FUNCTION AUTCOM.f_Rel_QtdDiaUtil; expected 3, got 1
```

A chamada gravada no relatorio esta correta, com tres argumentos. O que o servidor recebeu, visto no
`general_log` do cliente, veio **sem as virgulas** - o MySQL concatena literais adjacentes e le um
argumento so.

Causa: o ramo com thread vai direto ao `FDados.Open` e deixa o bind para o UniDAC, enquanto o ramo
sincrono passa por `pOpenQuery`, que no Linux chama `PrepareQueryFinalSQL` antes. **Foi o usuario
quem apontou** - eu estava investigando `fTiraCaracEspeciaisSQL` e o proprio
`PrepareQueryFinalSQL`, sem ter confirmado se esta query passava por ele. Nao passava.

**Registrado em `IA/know/unidac_linux_bind_offset.md`**: sintoma, receita de reproducao com cliente,
relatorio e comandos do general_log, e por onde comecar. Decisao do usuario: guardar o caso e abrir
investigacao depois, nao agora.

Duas anotacoes de bancada que sairam daqui:

- **A query da worker nao aparece no `--logssql`.** A conexao dela nasce do `BeginThreadConnection`
  e nao recebe o hook de log. Foi por isso que o statement que falhava nao estava no arquivo, e o
  `general_log` foi necessario.
- O erro acusa a **funcao**, o que manda quem investiga para o lado errado: funcao e chamada estao
  ambas corretas, so o texto que chegou ao servidor e que nao.

**Pendente:** aplicar `PrepareQueryFinalSQL(qryDados)` no `fExecutaThread`, antes do `objThread.Start`,
sob IFDEF LINUX - na main, nao dentro da worker, e cobrindo os quatro pontos de chamada de uma vez.


### 08/09 16:58 - MARCIUS entrega pela primeira vez

Com `pOpenQuery`/`pExecuteQuery` no `TThreadRelatorio.Execute`, o gatilho 000001 foi ate o fim:

```
GATIME_WPPEMA  00100000000051038001  16:58:49  emp 001  wpp 14974029330
               GAT_OBSWPP = Enviado
               DIRETORIA - RELATORIO DIARIO - DASHBOARD
```

O historico prova que e a primeira vez. Todas as linhas anteriores desse gatilho tem
`GAT_NUMWPP` **nulo** e `Envio nao previsto` no WhatsApp - eram linhas de e-mail:

```
2026-09-08 16:58:49   14974029330   Enviado
2026-09-05 18:32:26   NULL          Envio cancelado - Atraso(24h)
2026-09-04 18:33:38   NULL          Envio nao previsto
```

E exatamente o sintoma relatado na abertura do MARCIUS: no modo fila o e-mail entregava e o
WhatsApp nunca enfileirava.

### A pilha inteira, na ordem em que foi descascada

```
1. binario de 02/07 em robo_novo          -> achado pelo usuario, pela data do arquivo
2. AV: ponteiro de funcao nil no TSafeThread -> addr2line no endereco
3. deadlock: Synchronize sem message pump    -> gdb thread apply all bt
4. worker sem conexao: EThread no manager    -> grep -c "TThreadRelatorio.Execute" = 0
5. bind do UniDAC comendo virgula            -> general_log; apontado pelo usuario
```

Cada um escondia o seguinte. Nenhum era o que a mensagem no `GAT_ULTMSG` dizia, que era sempre
"Url Dashboard em branco" - o `except` de `untRelatorio.pas:3033` engole a causa e devolve string
vazia.

### Pendente para hoje 18:30

Cinco dos seis gatilhos do MARCIUS disparam ainda hoje (000002 18:35, 000004 18:30, 000005 18:31,
000006 e 000007 18:32). O 000001 foi para 09/09, consumido pelos testes. Todos sao dashboard, mesmo
caminho - entao e teste real com o monitor conduzindo, desde que o cliente saia do `robo_velho`:

```sql
UPDATE gatilhos_informacao_robo
SET    pasta = 'robo_novo', fixado_em = CURRENT_TIMESTAMP, fixado_por = 'joao.catarino',
       motivo = 'Req. 460229 - AV/deadlock/bind Linux corrigidos'
WHERE  servidor = 'GRUPO_MARCIUS_LJ001(MATRIZ)_002_003_004' AND empresa = '001';
```

**UPDATE, nao DELETE.** Sem linha o cliente cai na PASTA_DEFAULT, que e `robo_libgatime`
(`PASTA_DEFAULT_FALLBACK`, untGatilhos.pas:62) - e **as correcoes de hoje so existem em
`robo_novo`**. Apagar a fixacao mandaria o MARCIUS para um binario sem elas. Corrigido pelo usuario.

A fixacao datava de 07/09 com motivo "enfileiramento falha no share UNC 192.168.1.6" - uma das
hipoteses que caiu.

**Consequencia mais ampla, para depois:** os ~170 clientes rebaixados pelo guardrail e todos os que
rodam na default seguem sem as correcoes. Elas so chegam a eles quando o binario novo virar a
default - decisao de release, nao deste requisito.

### Ainda de pe, nao corrigido

- **`Result := True` carimbando envio em cima de erro** (untGatilhosInformacao.pas:1378/1388/1411/1421
  -> :940 -> :2014). Afeta todo gatilho que falha, em todos os clientes. Mudar isso muda comportamento
  de 500+ clientes na mesma subida: merece deploy proprio.
- **A query da worker nao aparece no `--logssql`** - conexao do BeginThreadConnection sem o hook.
- **`ExecSQL` cru no ramo sincrono** (untInterfaceRelatorio.pas:10608 e :11615) - mesmo bug de bind,
  latente. Registrado em `IA/know/unidac_linux_bind_offset.md`.


### 08/09 17:05 - vale remover os `blnConexaoIndependente := False` do Linux? Nao

Pergunta do usuario depois que o MARCIUS entregou. Resposta: nao, e nao neste deploy.

- Ha **um** caminho provado: relatorio 538892, um cliente, uma sobrecarga. Os outros `False` servem
  fluxos que nunca rodaram com thread no Linux, e hoje cada fluxo novo revelou um defeito de
  plataforma diferente - foram quatro em sequencia.
- O ganho e quase nada. A thread existe para a tela nao travar enquanto a query roda; no robo nao ha
  tela. Custa uma conexao e complexidade, e nao compra nada.
- Risco assimetrico: os `False` estao funcionando para 500+ clientes.

**Hipotese minha que caiu na verificacao.** Eu sugeri que o TSafeThread quebrado no Linux afetaria
outros servicos. Conferido:

| Classe | Instanciacao | Roda no Linux? |
|---|---|---|
| `TThreadRelatorio` | untInterfaceRelatorio.fExecutaThread | **sim** |
| `TStartFatImpressao` | untFatImpressao.pas:1582, dentro do `{$ELSE}` de um `{$IFDEF LINUX}` | nao |
| `TThreadProcessaAlpeBoleto` | nao e instanciada em lugar nenhum | nao |
| `TRTTIEngine` | untGeoSales e Sample, unidades de tela | nao |

`TThreadRelatorio` e o unico `TSafeThread` vivo em servico Linux. As demais estao linkadas, nao
instanciadas. Isso **reforca** a decisao de nao mexer: as correcoes tem um consumidor so, e ele ja
esta coberto e testado.

Se um dia for feito, e tarefa propria com um teste por fluxo, usando o roteiro de hoje: ponteiros do
TSafeThread, CheckSynchronize, BeginThreadConnection, e `pOpenQuery`/`pExecuteQuery` no lugar do
Open/ExecSQL cru.


### 08/09 17:09 - o porque que fecha a questao da conexao independente

Dito pelo usuario, e e o argumento que sobrevive: **a conexao independente existe para a tela nao
travar enquanto uma query pesada roda.** No Linux nao ha tela.

Isso reclassifica os `blnConexaoIndependente := False` sob IFDEF LINUX. Nao sao contorno - sao
decisao de plataforma correta, tomada pelo motivo certo. O que esta fora do padrao e o `True` fixo
da `untRelatorio.pas:3071`, que escapou da regra.

Registrar assim importa porque "quebrou" envelhece - alguem conserta e religa. "Nao tem funcao aqui"
nao envelhece.

**Argumento operacional que se somou hoje:** a query da worker nao aparece no `--logssql`, porque a
conexao dela nasce do `BeginThreadConnection` e nao recebe o hook. Foi por isso que foi preciso ligar
o `general_log` em producao do cliente para achar o bind do UniDAC. Rodando sincrono, o SQL volta a
ser visivel no log do proprio robo. Num robo que atende 500+ clientes e que se diagnostica por log,
isso vale mais que qualquer beneficio da thread - que no headless e zero.

**Plano acordado:**

1. Hoje 18:30 - deixar rodar como esta. O build no ar e o que foi validado ponta a ponta.
2. Depois - trocar o `True` da 3071 por `{$IFDEF LINUX}False{$ELSE}True{$ENDIF}`, alinhando com a
   linha 2968.
3. Os quatro consertos ficam. Nao sao condicionais ao `True`: sao corretos por si, e sao o que
   impede o problema de voltar calado se alguem religar a conexao independente algum dia.


### 08/09 17:12 - padronizacao aplicada e validada no mesmo cliente

Decisao do usuario: nao esperar as 18:30, colocar o `False` e revalidar. Havia folga de tempo e o
`GATINF=` reproduz o gatilho a hora que se quiser, entao o custo era baixo.

`untRelatorio.pas:3071` passou de `True` fixo para `{$IFDEF LINUX}False{$ELSE}True{$ENDIF}`, com o
porque no ponto: conexao independente serve para a tela nao travar, e no Linux nao ha tela.

```
16:58:21  com thread   -> enfileirou e entregou
17:12:21  sincrono     -> enfileirou e entregou em 12s
```

Linha `00100000000051048001`, `GAT_NUMWPP` preenchido, `GAT_OBSWPP = Enviado` as 17:12:33, imagem
nova no bucket e link de dashboard novo (`ae28aaa1...` contra `d0b19562...` da rodada anterior) -
prova de que o relatorio foi gerado de novo, e nao reaproveitado.

**Como se provou que o `False` pegou:** o `general_log` do cliente nao mostrou uma segunda conexao.
Uma conexao so significa que nao nasceu worker. Prova do lado do servidor, melhor que procurar o SQL
no log do robo - nao depende de o hook de log estar ativo. Sugerida pelo usuario.

Os quatro consertos do caminho com thread ficam no fonte. Nao sao condicionais ao `True`: seguram o
problema se alguem religar conexao independente algum dia, e sem eles ele voltaria calado.


#### A evidencia final, no general_log do cliente

```
17:12:16.747  thread 152992  SET @UTIMES := f_Rel_QtdDiaUtil('2026-09-08', '2026-09-08', '001');
17:12:16.748  thread 152992  SET @UTICOR := f_Rel_QtdDiaUtil('2026-09-08', @DIAATU, '001');
```

Contra o que o servidor recebia as 16:45, com a thread:

```
16:45:36.242  thread 149160  SET @UTIMES := f_Rel_QtdDiaUtil('2026-09-08' '2026-09-08' '001');
```

- As virgulas voltaram, e sao tres argumentos.
- **A segunda chamada executou.** Antes o script morria na primeira e `@UTICOR` nunca chegava ao
  banco. `@DIAATU` seguiu como variavel, sem virar literal.
- Uma conexao so (`152992`) fez as duas chamadas, as 7 das temporarias e as 16 do GATINF. Nao houve
  worker.

Agrupamento usado para isolar o robo no meio de 7067 linhas e 121 conexoes do servidor do cliente:

```sql
SELECT thread_id, COUNT(*) AS N, MIN(event_time), MAX(event_time),
       SUM(CONVERT(argument USING utf8mb4) LIKE '%f_Rel_QtdDiaUtil%') AS TEM_FUNC,
       SUM(CONVERT(argument USING utf8mb4) LIKE '%TMP_VENDA_GATILHO%') AS TEM_TMP,
       SUM(CONVERT(argument USING utf8mb4) LIKE '%GATINF%')           AS TEM_GATINF
FROM   mysql.general_log
GROUP  BY thread_id
HAVING TEM_FUNC>0 OR TEM_TMP>0 OR TEM_GATINF>0
ORDER  BY N DESC;
```

Vale reaproveitar: em general_log de cliente em producao, o robo se acha por essa combinacao, e a
contagem de `thread_id` distintos responde sozinha se houve thread ou nao.


## 08/09/2026, fim de tarde - da correcao para a populacao

Com o caminho corrigido, o trabalho virou descobrir quem sofria dele e mover esses clientes.

### A generalizacao, dita pelo usuario

**Todo dashboard enviado por WhatsApp passava `blnConexaoIndependente = True`.** Nao era MARCIUS nem
CONARA: era a categoria inteira, em todos os clientes.

```
dashboard por E-MAIL     -> untGatilhosInformacao:1138 -> sobrecarga sem objRel
                         -> IFDEF da 2968 -> False -> sincrono -> sempre funcionou
dashboard por WHATSAPP   -> untGatilhosInformacao:1395 -> sobrecarga com objRel
                         -> True fixo na 3071 -> thread -> quebrado
```

Medido em quatro clientes (`GATINF` x `CADREL.REL_DESTIN`):

| Cliente | Dashboard+WhatsApp | Resto | Lacuna do dia |
|---|---|---|---|
| BELATINTAS | **389** | 3 | 70 -> 3 |
| CONSTRUART | 13 | 29 | 11 -> 1 |
| PALMARES | 7 | 75 e-mail | 34 -> 16 |
| VIVA_COR | **0** | 40 e-mail | 26 -> 11 |

A tese explica BELATINTAS quase inteiro e parte do CONSTRUART. **Nao explica PALMARES nem VIVA_COR**,
que sao de e-mail e tem causa propria - VIVA_COR nem tem um dashboard cadastrado. O requisito se
parte em duas frentes, e a maior ja esta corrigida no codigo.

### O que `deviam_enviar` mede - e nao e o que parece

```sql
SELECT COUNT(*) FROM GATINF g
WHERE  g.GAT_STATUS='A' AND g.GAT_CODEMP=:EMPRESA
AND    DATE(g.GAT_ULTENV) = CURRENT_DATE      -- o robo CARIMBOU hoje
```

E **gatilho que o robo tocou hoje**, nao gatilho agendado para hoje. Descoberto quando o UPDATE de
reprocessamento do BELATINTAS afetou 7 linhas em vez de 70: os outros 63 sao semanais, e o
`AtualizarDataProximoEnvio` os jogou para 10/09 ou depois, nao para amanha. Para reprocessar, o
filtro e pelo carimbo (`DATE(GAT_ULTENV)=CURRENT_DATE AND GAT_PROENV > NOW()`), nao pela agenda.

Isso so e seguro em cliente cujo gateway nao entrega - forcar semanal fora da semana manda relatorio
em dia que o destinatario nao espera.

### A default e a menos validada da frota

Dito pelo usuario, e reorienta a decisao: o `robo_libgatime` **nunca foi validado**, rodava em dois
clientes de uma lista em txt, e foi promovido a default de toda a frota de uma vez - foi ai que os
problemas apareceram. A comparacao nao e "estavel contra novo", e **"nao validado contra
recem-validado"**.

A evidencia da tabela fecha com isso: dos 17 clientes com **zero** na fila em 08/09, **todos os 17
estavam na default**. Nenhum cliente fixado aparece na lista.

### Movimentos do dia

| Cliente | O que foi feito | Resultado |
|---|---|---|
| MARCIUS | fixado em robo_novo | 6 gatilhos, entregues |
| CONARA | ja era piloto | leva das 17h saiu apos a troca do binario |
| CONSTRUART | fixado + UPDATE de reprocessamento | 1 -> 12 na fila, 12 entregues em 98s |
| BELATINTAS | fixado + UPDATE pelo carimbo | 70 gatilhos soltos, medindo |
| +17 clientes | fixados em lote | medem amanha de manha |

Total: 22 clientes em `robo_novo`.

**Correcao registrada:** eu disse que o BELATINTAS nao entregaria por causa do HTTP 503 do gateway.
Errado - na rodada das 17:48 os envios sairam `Enviado`, sem um erro HTTP. O 503 de mais cedo era
transitorio.

### Ponto de checagem de amanha

```sql
SELECT SUM(deviam_enviar), SUM(chegaram_na_fila), SUM(entregues)
FROM   gatilhos_informacao_divergencia WHERE data_ref = CURRENT_DATE;
```

08/09 fechou em **740 / 627 / 578**. Com 22 clientes no robo novo, a razao fila/deviam tem de subir.

### Decisao em aberto: virar a default

A favor: a default nao e confiavel por historico proprio; `robo_novo` e superconjunto (build de hoje
do HEAD); a troca e um parametro `--pasta_default=`, reversivel em segundos; os rebaixados pelo
guardrail seguem no robo_velho de qualquer forma.

Contra: o build tem horas de producao e a maior leva do dia e entre 6h e 9h.

Encaminhamento proposto: virar hoje, com ponto de checagem as 7h30 e o comando de reversao escrito
antes de precisar dele.


## 08/09/2026, 18:10 - fechamento do dia

### A default virou

```
18:07:48 [main] - Robo default: robo_novo
18:09:58 [main] - Robo default: robo_novo
```

Trocado o `--pasta_default=` no shell de lancamento, no Linux. As duas linhas em dois minutos
mostram que o monitor e relancado a cada ciclo - o valor novo vale para todo arranque, nao depende
de um processo especifico ficar de pe.

**Reversao, se amanha exigir:** `--pasta_default=robo_libgatime`, explicito. Apagar o parametro
tambem reverte, mas volta a depender do fallback implicito, que e o defeito de origem deste
requisito.

**Alcance da troca:** os 22 fixados seguem pela tabela; os rebaixados pelo guardrail seguem no
`robo_velho`; o resto - apto e sem linha - passa a rodar `robo_novo`.

### Numeros do dia

```
manha    740 deviam / 627 fila / 578 entregues    fila 84,7%
17:59    787 / 754 / 695                          fila 95,8%
18:02    799 / 765 / 703                          fila 95,7%
```

O BELATINTAS sozinho saiu de 3 para 61 na fila: 70 gatilhos em 9 minutos, 63 linhas, 58 entregues,
zero erro de gateway.

**Duas leituras que nao sao erro, e ficam anotadas:**

- `fila > deviam` em CONSTRUART (12/11) e MARCIUS (2/1). As duas colunas tem **unidade diferente**:
  `deviam_enviar` conta gatilhos, `chegaram_na_fila` conta mensagens, e um gatilho de grupo gera uma
  linha por destinatario. No CONARA um gatilho virou 8 linhas.
- BELATINTAS fechou 61 de 70. Os 9 restantes podem ser gatilho sem destinatario, filtro sem dado ou
  correlacao por assunto falhando. Olhar amanha.

### Ponto de checagem de amanha, 7h30

```sql
SELECT SUM(deviam_enviar) AS DEVIAM, SUM(chegaram_na_fila) AS FILA,
       ROUND(100*SUM(chegaram_na_fila)/SUM(deviam_enviar),1) AS PCT
FROM   gatilhos_informacao_divergencia WHERE data_ref = CURRENT_DATE;
```

Hoje comecou em 84,7% e fechou em 95,8% movendo 22 clientes a mao. Amanha, com a default virada, o
numero nasce alto ou nao nasce - e a reversao e uma linha.

### Em aberto

- **Nada commitado no SVN.** Cinco arquivos alterados; precisa de `Req. 460229` na primeira linha e
  do token do DelphAI. Ha trabalho do 460364 na mesma copia.
- **`Result := True` carimbando envio em cima de erro** - untGatilhosInformacao.pas:1378/1388/1411/1421
  -> :940 -> :2014. Afeta todo cliente; deploy proprio.
- **PALMARES e VIVA_COR** - lacuna de e-mail, causa nao levantada. VIVA_COR nao tem dashboard nenhum.
- **BELATINTAS, os 9 de 70.**
- **Bind do UniDAC** - caso reproduzivel guardado em `IA/know/unidac_linux_bind_offset.md`.


### 08/09 18:25 - a apuracao media unidades diferentes

Investigando os "16 que ficaram para tras" no BELATINTAS e no CONARA, os dois se explicaram sem
defeito novo:

- **BELATINTAS, 9 faltando: artefato.** 70 gatilhos tocados no dia com apenas **3 descricoes
  distintas**. Pelo criterio correto - gatilho tocado hoje sem NENHUMA linha correlacionada - deu
  **zero**. Nada ficou para tras.
- **CONARA, 11 faltando: sao da manha.** Todas com "Gatilho enviado com sucesso!", a constante do
  binario de julho. O cliente foi fixado em robo_novo as 08:23, mas a pasta so recebeu o binario novo
  as ~15h. Falha do build velho, nao do novo.

**A causa: `deviam_enviar` contava GATINF e `chegaram_na_fila` contava GATIME_WPPEMA.** Um gatilho de
grupo gera uma linha por destinatario, e varios gatilhos compartilham GAT_DESCRI - entao o excedente
de um cliente compensava a falta de outro no total, e aparecia `fila > deviam`. O agregado do dia
(95,7%) estava inflado; somando so as lacunas reais por cliente, era **80,5%**.

**Corrigido:** as tres colunas passam a contar gatilho, sobre o mesmo universo.

```sql
SELECT COUNT(*)                   AS DEVIAM_ENVIAR,
       SUM(f.ASSUNTO IS NOT NULL) AS CHEGARAM_NA_FILA,
       IFNULL(SUM(f.ENTREGUE), 0) AS ENTREGUES
FROM   GATINF g
LEFT   JOIN (SELECT w.GAT_CODEMP AS EMP, w.GAT_ASSUNT AS ASSUNTO,
                    MAX(<SQL_ENTREGUE>) AS ENTREGUE
             FROM GATIME_WPPEMA w WHERE w.GAT_DTAOCO = CURRENT_DATE
             GROUP BY w.GAT_CODEMP, w.GAT_ASSUNT) f
       ON f.EMP = g.GAT_CODEMP AND f.ASSUNTO = g.GAT_DESCRI
WHERE  g.GAT_STATUS='A' AND g.GAT_CODEMP = :EMPRESA_D
AND    DATE(g.GAT_ULTENV) = CURRENT_DATE <filtros de nao-envio legitimo>
```

**Por que JOIN agregado e nao EXISTS por gatilho** - pergunta de performance levantada pelo usuario,
e ela mudou a solucao. A GATIME_WPPEMA so tem indice em GAT_DTAOCO, entao o EXISTS varre as linhas do
dia uma vez por gatilho. Medido no BELATINTAS:

| Forma | 70 gatilhos | 392 gatilhos |
|---|---|---|
| EXISTS correlacionado | 0,07s | 0,38s |
| JOIN agregado | abaixo do ruido | abaixo do ruido |

Mesmo resultado nas duas (70/70/70). O JOIN le a fila do dia uma vez; o custo deixa de ser `gatilhos x linhas_do_dia`.

`SQL_POR_GATILHO`, a consulta de detalhe, **nao muda**: ja devolve uma linha por gatilho e
correlaciona por destinatario (OPE_NUMWPP / OPE_E_MAIL), que e mais preciso que por assunto.

**Aviso de leitura:** a tabela e atualizada no lugar, entao no primeiro ciclo apos o deploy as linhas
de hoje sao recalculadas com a formula nova e o total sobe - BELATINTAS vai de 70/61 para 70/70.
**Isso e mudanca de regua, nao melhora.** Comparar so numeros produzidos pela mesma formula.


### 08/09 18:35 - o `cd <pasta> &&` serializou a frota inteira

Sintoma: o log do monitor "parando" na linha `INICIANDO ...`, e fila persistida de 37 itens drenando
um por vez.

`ShellExecute` (untUtils.pas) usa `popen` e le **ate o EOF do pipe**:

```pascal
Handle := popen(M.AsAnsi(PWideChar(AComand)).ToPointer, 'r');
While fgets(@Data[0], Sizeof(Data), Handle) <> Nil Do ...
```

O comando montado era:

```sh
cd <pasta> && ./GatilhosInformacao <params> >> "arquivo" 2>&1 &
```

Em `sh`, `A && B &` poe a **lista inteira** num subshell. O redirecionamento pertence ao `B`, nao ao
subshell - entao o subshell fica com stdout no pipe do `popen` durante toda a vida do robo. O pipe
nunca da EOF e o monitor espera cada cliente terminar. **O `&` virou enfeite.**

Visivel no `ps` de producao:

```
sh -c cd .../robo_novo && ./GatilhosInformacao ... >> "..." 2>&1 &
 └─ ./GatilhosInformacao ...
```

Medido localmente, com `| cat` no lugar do popen:

| Forma | Tempo |
|---|---|
| `cd X && prog >> arq 2>&1 &` | **4,095s** (espera o filho de 4s) |
| `( cd X && prog ) >> arq 2>&1 &` | **0,043s** |

**Defeito meu, introduzido em 08/09/2026** junto com o versionamento por pasta. Antes do `cd` o
comando era um so: o shell redirecionava, saia, e o EOF vinha na hora.

Corrigido com parenteses: `( cd ... && ./GatilhosInformacao ... ) >> "arquivo" 2>&1 &`. O subshell
inteiro nasce com stdout no arquivo e ninguem segura a ponta de escrita do pipe.

**Consequencia operacional:** o bloqueio funcionava como estrangulador acidental. Sem ele, dezenas de
robos podem subir quase juntos - vigiar load nos primeiros minutos apos o deploy.

### Duas instalacoes, nao uma

O `ps` revelou dois processos do mesmo binario, em pastas diferentes:

```
GatilhosInformacaoEnviar    -> ./GatilhosInformacaoMonitor send   --max_threads=20 --pasta_default=robo_novo
GatilhosInformacaoAtualizar -> ./GatilhosInformacaoMonitor update --max_threads=3  (SEM --pasta_default)
```

O `SQL_APURA` roda no modo **update**, entao trocar so no `Enviar` corrige a serializacao e deixa a
metrica errada. Mapeamento util:

```sh
for p in $(pgrep -f GatilhosInformacaoMonitor); do
  echo "$p  $(ls -l /proc/$p/cwd | sed 's/.*-> //')  $(tr '\000' ' ' < /proc/$p/cmdline)"
done
```

### Confirmacao da metrica corrigida

Apos a troca nas duas pastas, no primeiro ciclo:

```
apos a troca   40 clientes   0 casos de fila > deviam
antes          85 clientes  21 casos      (valores velhos, ainda nao reapurados)
```

`fila > deviam` e aritmeticamente impossivel na formula nova - e zerou nos clientes reapurados. Era o
teste que separava "binario novo no ar" de "binario novo copiado".


### 08/09 18:40 - fechamento com a regua nova

A formula corrigida alcancou toda a base em tres minutos:

```
18:38:16    65 de 125 reapurados   impossiveis: 15
18:39:16   101 de 125              impossiveis:  5
18:40:16   134 de 134              impossiveis:  0    1011 deviam / 796 fila
```

**Numero honesto de fechamento: 78,7%** (796 de 1011). Os 95,7% de antes eram compensacao entre
unidades diferentes. A base inteira reapurada em tres minutos tambem confirma que o `[main]` deixou
de ficar preso por cliente.

**Este numero nao mede o conserto.** 08/09 foi dia misturado: binario do robo trocado as 15h, default
virada as 18h, monitor trocado as 18h37, e 22 clientes movidos a mao durante a tarde. Serve de linha
de base para amanha, que e o primeiro dia inteiro com tudo no lugar.

### Correcao: o `--pasta_default` faltando no `update` nao quebra a metrica

Eu afirmei que sim; esta errado. `PASTAS_SINCRONAS` vale `robo_velho` por default, e
`fVersaoEnfileira` so pergunta se a pasta **nao e** `robo_velho`. Tanto `robo_libgatime` quanto
`robo_novo` passam, entao o cliente e reconciliado igual.

O parametro faltando afeta so: a linha `Robo default:` do log, que passa a mentir; e o dia em que
alguem acrescentar outra pasta ao `--pastas_sincronas=`.

**Dois rotulos enganosos ficaram pendentes**, ambos cosmeticos e ambos so visiveis depois que a
default mudou:

- `Robo escolhido para X: robo_velho (FIXADO)` quando o cliente foi rebaixado pelo **guardrail**, nao
  fixado na tabela. Vem de `IfThen(LPasta = PASTA_DEFAULT, ' (default)', ' (FIXADO)')` - com a default
  em `robo_novo`, tudo que nao e `robo_novo` imprime `(FIXADO)`.
- `Robo default:` no processo `update`, sem o parametro.

### Estado no fim do dia

| Item | Estado |
|---|---|
| Robo (`GatilhosInformacao`) | 5 defeitos corrigidos, validado em 4 clientes, em `robo_novo` |
| Default da frota | `robo_novo`, confirmado no log |
| Monitor (`GatilhosInformacaoMonitor`) | metrica por gatilho + `( cd ... )` no ShellExecute, nas duas pastas |
| Clientes fixados | 22 |
| Metrica de fechamento | 78,7% (1011 / 796) |
| SVN | **nada commitado** |


## 08/09/2026, noite - analise das pendencias e o fio aberto do DONATO

### Perfis novos no db-config.local.json

Acrescentados oito, reusando os mesmos placeholders `${MYSQL_MINASBOMBAS_USER}` / `_PASS` que todos
os outros usam (credencial unica da frota, o `gatilho_informacao` que aparece no log do monitor):
`tinbol`, `potencya`, `solvinil`, `heraldo`, `donato`, `vaptblue`, `morvillo`, `cmmateriais`.
Backup em `db-config.local.json.bak`.

### As 267 pendencias, por causa

| Causa | Clientes | Situacao |
|---|---|---|
| Rodaram de manha no binario de julho | POTENCYA 30, SOL_VINIL 25, CONARA 11, MORVILLO 5 | some sozinho amanha |
| Esquema do cliente atrasado | RELDRI: 6 de 18 amostrados; REL_FILLAT: 3 de 18 | script rodado em 6 deles |
| Causa escondida por mensagem generica | HERALDO 8, HOME_CENTER 3, BELATINTAS 4, SOL_VINIL 6 | corrigido a noite |
| Anomalia isolada | CM_MATERIAIS: GAT_ULTENV de hoje, GAT_ULTMSG de 05/09 | nao investigada |

**RELDRI** e a tabela do drill-down (`untDrillDownRelatorio.pas`, usada pelo
`untGraficosDashboard.pas`) - por isso quebra exatamente no dashboard. Estrutura e indices copiados do
CONARA; `REL_FILLAT` e `char(1) NULL DEFAULT 'N'`, posicao 192 do CADREL.

### A correcao da mensagem, provada em producao

Aplicado `VS_UltimaMensagemAoUsuario` nos **dois** ramos de dashboard de
`untGatilhosInformacao.pas` (e-mail e WhatsApp), com `AddOrSetGlobalVar(..., '')` antes de cada
chamada - a global e do processo, e sem zerar o proximo a falhar herdaria o motivo do anterior.

Resultado no DONATO, antes e depois do DDL, no mesmo binario:

```
20:33  sem DDL  "#42S02 Table 'AUTCOM.RELDRI' doesn't exist
                 - [[TGraficosDashboard.fMontaGrafico]] - [[TGeraFR3.fMontaGraficoDashboard]]
                 - [[TGeraFR3.fExecutaRelatorio]] - [[TInterfaceRelatorio.fExecutaRelatorio]] ..."
20:42  com DDL  "Preparando relatorio... Criando paginas..."  + 3 linhas na GATIME_WPPEMA
```

A cadeia `[[origem]]` vem do `pMensagensErro`, nao do `E.Message` - prova de que o caminho novo e o
que responde. O `GAT_ULTMSG` corta o fim da cadeia; a causa fica na frente, que e o que importa.

### Ticket Zendesk: risco identificado, nao ativo

`ID29 - Pendente de envio na GATIME_WPPEMA` e `ID30 - Nao gerou registro na GATIME_WPPEMA` **sao
tipos de erro cadastrados** e abririam ticket. Hoje nao abrem: a automacao esta parada desde
**21/08/2026** e nenhum ticket ID29/ID30 existe.

Se religarem como esta: **450 linhas casariam com ID29 e 303 com ID30, em 246 clientes.**

E o ID29 descreve **estado transitorio**, nao erro: "pendente de envio" e o normal entre o
enfileiramento e a passagem do consumidor. Proposta nao aplicada: so escrever a mensagem do ID29
quando a linha estiver pendente ha mais que um limite (1h, ou o mesmo corte de 20h do
`DestravarFilas`).

### Fio aberto: por que a fila do DONATO nao drena

Estado quando o cliente ficou inacessivel (21:30, `connection refused` - hospedado em terceiro):

- 4 linhas pendentes: 18:49 e as tres de 20:42. `GAT_LIBENV = 'S'`, observacoes vazias.
- **`GAT_LIBENV = 'S'` e PENDENTE**; o consumidor grava `'N'` ao processar. As 2 entregues de hoje
  (10:09 e 17:06) estao com `'N'`. Eu tinha suposto o contrario.
- As 2 entregues sao do operador **999**; as 4 paradas, do operador **020**.
- A consulta exata do consumidor (`GAT_LIBENV='S'` + filtro de fluxo OPERACIONAL, que testa
  `$.dadosGatilho.codigoGrupo NOT IN ("009")`) **devolve as 4 linhas**. O SQL nao as exclui.
- `DestravarFilas` passa nas quatro portas dele - conferido rodando o `SQL_IDADE` a mao: 4 pendentes.
- Rodada manual sem `GATINF=` (que forca o `pProcessarGatilhosImediatos`) **nao drenou**.

**Hipotese em aberto, NAO confirmada:** em `untProcessaGatilhosImediatos.pas:230-238`, a fila e a
chave nao vem da linha - vem do operador do `GATOPE`:

```pascal
LIDFila := fRetFilaEnvioWhatsAppOperador(fCfgSis('GATOPE'));
if LIDFila <> 0 then LApiKey := fCampoTabela('FIL_KEYAPI', 'CADFIL', ['FIL_IDFILA'], [LIDFila]);
pExecuteCliente(LIDFila, LApiKey);
```

Se o `GATOPE` do cliente nao resolver para uma fila com chave, o consumidor entra sem chave.

**Retratacao:** eu afirmei que o DONATO nao tinha `GATOPE/GATINF/GATURL` no CFGSIS. Estava errado -
consultei `SIS_CODCFG IN ('GATOPE',...)` e o codigo real leva prefixo (`CFG_GATOPE`), entao o zero
linhas era da chave errada, nao de configuracao ausente. Corrigido pelo usuario. Refazer a consulta
com `SIS_CODCFG LIKE '%GAT%'` quando o cliente voltar.

O DONATO tem 3 filas cadastradas (ids 10, 14, 13), todas com KEYAPI e APIOFI, e **nenhuma marcada
como principal** (`FIL_FILPRI = 'N'` nas tres) - pode ou nao ser relevante.


### Correcao de leitura: o `Result := True` e deliberado

Eu listei varias vezes como defeito a devolver "erro tratado" como `True`, fazendo o
`AtualizarDataEnvio` carimbar o gatilho. **Nao e defeito - e a protecao contra loop de tentativas.**
Dito pelo usuario em 08/09/2026.

`ExecutarEnvio` (untGatilhosInformacao.pas:906-925) repete tres vezes com `Sleep(30000)` quando ha
**excecao**. Devolver `True` nos ramos de erro tratado e o que distingue "nao adianta repetir" de
"transitorio, tenta de novo". Sem isso, cada falha viraria tres tentativas mais o LOGERR de cada uma,
em 500+ clientes.

O que resta, e nao e o mesmo problema:

- `AtualizarDataEnvio` carrega dois sentidos - "entreguei" e "nao repetir hoje". Para a metrica isso
  esta **correto**: o gatilho foi tocado, e e assim que o `deviam_enviar` o conta.
- O prejuizo real era a **causa se perder junto com o carimbo**. Resolvido na mesma noite: o
  `GAT_ULTMSG` agora traz a causa real. Carimbar sem repetir deixou de significar ficar cego.

Nao tratar como pendencia de conserto.


### Varredura de DDL na frota inteira - 08/09/2026 21:55

Corrige o numero que este registro trazia como "RELDRI: 6 de 18 amostrados; REL_FILLAT: 3 de 18".
Aquela amostra era viciada: os 21 clientes com perfil em `db-config.local.json` sao exatamente os que
tocamos durante a investigacao, e onde o script foi rodado. Medir neles e medir o proprio trabalho.

A central tem `num_ip`, `porta` e `banco` de cada servidor em `gatilhos_informacao`, e a credencial de
suporte abre a frota toda - entao da para conferir a estrutura de verdade, sem depender de perfil.
Script em `scratchpad/ddl_frota.py`, resultado em `ddl_frota.csv`. So leitura de `information_schema`.

```
frota   404 hosts  ->  398 alcancados, 6 fora do ar

                              hosts   com gatilho ativo
completos                      203          145
sem a tabela RELDRI            195          111
sem as 3 colunas do CADREL     114           58
```

As "3 colunas" sao `REL_MARESQ` (190), `REL_MARDIR` (191) e `REL_FILLAT` (192). O registro anterior so
citava a ultima; o MINASBOMBAS mostrou que elas vem juntas - a base dele parava em 189.

**A lacuna nao esta quebrando nada.** Taxa de sucesso por grupo, no mesmo instante:

```
completos          43,0%
sem as 3 colunas   57,6%
sem a RELDRI       55,6%
```

Quem esta incompleto vai *melhor* que quem esta completo. A explicacao e que a DDL so morde quando o
cliente tem relatorio que a use - dashboard para a `RELDRI`, layout novo para as colunas - e a maioria
nao tem. Nao e pendencia de 195 clientes; e deriva de esquema que dorme.

### O monitor sobrescreve a `ultima_mensagem` na central

Achado no meio da varredura acima, e vale por si.

Duas leituras do mesmo contador, com 2 minutos de diferenca, deram **55** e depois **1**. Nao foi erro
de query: entre elas passou uma rodada do monitor. Das 3.506 linhas de `gatilhos_informacao_status`,
**1.433 carregam texto do proprio monitor** (`Nao gerou registro na GATIME_WPPEMA: carimbado sem
linha`, `Pendente de envio na GATIME_WPPEMA: 1 de 2 sem confirmacao`), todas carimbadas 21:54-21:55.

```
robo   -> GATINF.GAT_ULTMSG no cliente        mensagem real do erro
monitor -> gatilhos_informacao_status.ultima_mensagem   diagnostico de reconciliacao
                                                        ^ apaga a de cima na copia central
```

Consequencia pratica: **procurar sintoma na central subestima.** Fleet-wide sobrou uma unica linha
citando DDL - o MINAS_BOMBAS das 18:26 - e mesmo essa ja estava resolvida as 21:46. Se eu tivesse
medido so por sintoma, teria concluido "frota inteira sem problema de esquema" com 114 clientes
incompletos.

A mensagem original nao se perde: continua no `GAT_ULTMSG` do cliente. Mas quem investiga pela central
- que e o caminho natural - ve o diagnostico do monitor no lugar do erro do robo. Confirmar se a
sobrescrita e intencional antes de mexer; pode ser exatamente o que o painel quer exibir.


### Guards de esquema no gerador de relatorio - 08/09/2026 22:05

Quatro pontos passaram a tolerar esquema atrasado. Motivo comum: **enriquecimento opcional derrubava
a saida inteira**.

| Arquivo | Onde | Estrutura | Sem ela, agora |
|---|---|---|---|
| `untGraficosDashboard.pas` | `pMontaDrillDown`, inicio | tabela `RELDRI` | painel sai sem drill-down |
| `untGeraFR3.pas` | ~2319 | `REL_MARESQ` / `REL_MARDIR` | margem 0/0 - o `Else` ja existia |
| `untGeraFR3.pas` | ~2834 | `REL_FILLAT` | filtro nao alinha a direita |
| `untGeraFR3.pas` | ~2884 | `REL_FILLAT` | idem |

A cadeia que justificava o conserto:

```
pMontaDrillDown -> qryConfig.Open -> RELDRI nao existe -> excecao
                                                            |
fMontaGrafico ..... Except ... Result := False <------------+
                                  |
                                  v
                       painel INTEIRO nao sai
```

No `untGeraFR3` o erro nem era do MySQL: `Field 'REL_FILLAT' not found` e do `FieldByName` sobre
dataset aberto com `SELECT *`. Por isso a ferramenta e outra - `FindField` antes, nao `fTabelaExiste`.

**A forma seguida ja era do projeto**, nao invencao: 26 `FindField` no proprio `untGeraFR3`, e o
idioma canonico `(FindField(X) <> nil) And (FieldByName(X)... )` aparece nas linhas 7230-7235 para
`REL_PDFWPP` / `REL_PDFEMA` / `REL_GATIMG`. Por isso **nao levaram comentario**: nesta base, o
`FindField` antes do `FieldByName` ja significa "coluna pode nao existir em base atrasada", e os 26
precedentes nao comentam. Comentar seria repetir o que o codigo diz.

Onde `fTabelaExiste` resolve, sem incluir unit nova - o `uses` da unit ja cobre os dois lados:

```
Linux    Services.Core.Connection.Manager   (via services.core.uses.inc)   DESC <tabela> em try/except
Windows  untFuncoesSimples -> TDBUtils -> fTabelaExisteFat
```

`blnUsarCache = True` importa: sem ele sai um `DESC RELDRI` por grafico do painel.

**Nao tratado, de proposito:** `untInterfaceRelatorio.pas:13990-13991` le as margens sem guard, mas
esta no ramo `{$ELSE}` do `pMoldura` - Windows. La binario e esquema sobem juntos; a defasagem que
morde e robo central novo contra base de cliente antiga.

### Por que nao houve teste, e por que isso basta

Procurei o caso que exercita o guard: cliente **sem** `RELDRI` com gatilho de dashboard ativo.
**Zero entre os 111 incompletos.** Faz sentido - dashboard se configura pelo editor, que so existe em
autcom novo, que traz a DDL junto. O DONATO foi a excecao que revelou o caso, e foi resolvido por DDL
as 20:42.

Entao medi a adocao das tres funcionalidades na frota:

```
tabela RELDRI existe em 203 clientes  ->  0 linhas em todos
REL_FILLAT = 'S'   em 284 clientes    ->  0 relatorios
margem <> 0        em 284 clientes    ->  0 relatorios
```

Adocao zero nas tres. Nenhum guard pode tirar nada de ninguem: o ramo protegido nao roda em lugar
nenhum hoje.

E o risco ja era nulo por construcao - com a coluna presente, `FindField <> nil` e verdadeiro e a
expressao restante e identica a anterior. So o caminho da ausencia muda, e muda de excecao para o
default.

**Consequencia para amanha:** o binario novo deve produzir resultado *identico* ao antigo em toda a
frota. Diferenca em 07h-08h (onde hoje passaram 386 gatilhos) e regressao, nao e o guard funcionando.

### Armadilha de leitura da central

`gatilhos_informacao_status.ultima_atualizacao` e a hora em que a central **sincronizou**, nao a do
evento. As 22:09 apareceram erros de `REL_FILLAT` do VAPTBLUE e de `RELDRI` do TINBOL que pareciam
pos-deploy; o carimbo dentro da mensagem dizia 19:01 e 18:36, ambos pre-DDL, e os dois clientes ja
constam completos na varredura estrutural.

Para separar evento de sincronizacao:

```sql
STR_TO_DATE(LEFT(ultima_mensagem,19),'%d/%m/%Y %H:%i:%s')
```

Erros de esquema por hora real do evento, em 08/09: 16h=1, 18h=82, 19h=14, 20h=0, 22h=0. A queda e
efeito da DDL, nao do deploy - o binario novo ainda nao foi exercitado quando isto foi escrito.


### DONATO nao drenava: lock orfao na LCKATC - 08/09/2026 22:30

A fila do DONATO estava parada desde 07/09 19:53. Antes de chegar no lock, tres hipoteses
morreram - vale registrar quais, porque cada uma parecia obvia:

| Hipotese | Como morreu |
|---|---|
| Consumidor nao roda no cliente | 67 entregas assincronas em 30 dias, a ultima em 07/09 |
| Falta `CFG_GATOPE` | Existe, vale `020`, resolve para a fila 13, que tem chave |
| Payload/filtro rejeita as linhas | A query exata do consumidor devolve as 4 linhas |

O que decidiu foi comparar entrega **sincrona** com **assincrona**. As duas que sairam hoje foram
2s e 4s depois de criadas - envio do ERP na autorizacao da NFe, nao do consumidor. Separando por
defasagem, o consumidor entregou todo dia ate 07/09 e **zero** em 08/09.

O `LOGERR` do cliente confirmou pela ausencia: 50 linhas hoje, **todas de operador humano** (46 sao
os erros de `RELDRI`/`REL_FILLAT` que os usuarios 003 e 010 tomavam clicando Imprimir, das 18:48 as
20:34, e param quando a DDL entra as 20:42). Nada do consumidor. Processo que morre gritando deixa
rastro; processo que nao roda nao deixa nada.

O lock, apontado pelo Joao:

```
LCK_CHAACE  AUTCOM.MONITOR_GATILHOS_IMEDIATOS_OPERACIONAL_001
LCK_CON_ID  3403      <- NAO existe na PROCESSLIST
LCK_PROCID  751031
LCK_HRALCK  22:03:21  <- fixo, nao se renova
LCK_TENTAT  144 -> 145 em 50s
```

As outras tres travas do cliente (`MONITOR_ENTFUT_001`, `MONITOR_AUDIT_001`,
`MONITOR_GATILHOS_INFORMACAO_001`) tinham dono vivo e `LCK_TENTAT = 0`.

### Por que nao da para testar se o dono vive

Duas tentativas descartadas, nesta ordem:

**Por conexao.** `information_schema.PROCESSLIST` so mostra as proprias conexoes sem o privilegio
`PROCESS`, e os usuarios dos robos nao tem:

```
monitor  NAO      rb_saldoreserv  NAO
envia    NAO      rb_entfutura    NAO
gera     NAO
```

Sem `PROCESS`, toda linha alheia pareceria morta e o robo apagaria lock vivo - o oposto do conserto.

**Por PID.** `LCK_PROCID` existe e `LckAtcEhDoMesmoPID` ja usa. Mas o dono da chave tanto pode ser
este robo quanto o `autcom.exe` de uma estacao Windows, e nao se sabe qual. `fProcessIDExiste` alias
e `CreateToolhelp32Snapshot`, Windows puro.

`GET_LOCK` - que solta sozinho quando a conexao cai, e ja e usado pelo robo de saldo - foi descartado
pelo Joao: a chave e disputada com o `autcom.exe`, e robo em `GET_LOCK` com desktop em `LCKATC`
deixa de excluir. Exigiria autcom atualizado em toda a base.

### Quanto dura um ciclo legitimo

Sobrou a idade, e o limiar precisava de medida. Proxy: rajada de envios com menos de 2 min entre si
(`scratchpad/ciclo_consumidor.py`), 45 clientes de maior volume, 14 dias, 3.184 rajadas:

```
mediana     44 s
p90        363 s   ( 6,0 min)
p99      1.952 s   (32,5 min)
maxima   4.598 s   (76,6 min)  NACIONAL_MOTO, 139 envios
```

Sugeri 4h (3,1x o pior caso). **Joao definiu 30 min**, ciente de que o p99 e 32 min - cerca de 1% dos
ciclos legitimos sera interrompido, nos clientes de volume. A troca e deliberada: fila destravando
dentro do turno vale mais que ciclo raro interrompido, e o ciclo interrompido volta na proxima leva.

### O patch

Um ponto so, `untGatilhosInformacao.pas:pProcessarGatilhosImediatos` - **por decisao do Joao**, nao
no `Services/GatilhosImediatos/Target/Linux/untExecutarGatilhos.pas`, que tem o mesmo padrao mas nao
e o binario que implantamos.

```pascal
if fGetTempoDuracaoLock(LIdMonitor, True) > EncodeTime(0, MinutosLockOrfao, 0, 0) then
  pDestravaLockForcado(LIdMonitor, -999);
```

`AUtilizaHoraServidor = True` porque relogio adiantado no robo mataria lock vivo. `-999` porque a
idade ja decidiu, `LCK_TENTAT` nao entra. `EncodeTime` em vez de `30/1440` porque a divisao esconde a
unidade.

### O que o lock NAO explica

Das 4 linhas paradas no DONATO, tres (20:42) tem a URL do dashboard preenchida - sao o resultado da
DDL de hoje chegando ate a fila. A quarta (18:49, `VENDEDOR - INADIMPLENCIA`) entrou com
`GAT_TEXINI` de **zero caractere** e sem anexo. Nao ha o que enviar. Defeito do produtor, sobrevive
ao destrave, e nao foi investigado.

E a parada nao e so do DONATO: hoje, 42 servidores tem fila > 0 e zero entregue, somando 203
mensagens - contra 101 que entregaram. Para o DONATO a lacuna de 26h esta provada dia a dia; para os
outros 41 nao. "Fila hoje, entrega zero hoje" tambem descreve cliente cujo gatilho rodou as 20:42 e
cuja entrega ainda vai sair.


### O AV que estava por tras de tudo - 08/09/2026 23:00

O guard de lock de 30 min entrou e funcionou no primeiro tiro (o `SELECT LCK_DTALCK, LCK_HRALCK`
aparece as 23:01:20:541 e o INSERT do lock logo depois). Mas o `--logssql` mostrou o que vinha em
seguida:

```
23:01:20:637  SELECT LCK_CON_ID ... IMEDIATOS_OPERACIONAL_001   lock adquirido
              Runtime error 216
23:01:21:462  EAccessViolation ... accessing address 0000000000000000
```

**O lock orfao era consequencia, nao causa.** O consumidor morria logo apos pegar o lock e deixava a
linha para tras.

A cadeia, em `untDllGatIme.pas`:

```
RetornarDllGatilhosImediatos   libGatIme.so ausente ou incompativel
pCarregaFuncoesDllGatilhoIme.  Handle = 0 -> Exit CALADO, fCarregarDllGatIme fica nil
TDllGatime.Create linha 217    DllGatIme := fCarregarDllGatIme(...)  -> AV em 0x0
```

O `Exit` da linha 162 engole a falha e entrega ponteiro nulo a quem vier depois. O `try/except` da
linha 222 nao pega: AV de chamada em endereco zero vira Runtime error 216 antes.

A lib em `robo_novo` era de **02/06** - mesma data ja citada no comentario do `MAX_HORAS_PARA_DRENAR`.
Trocada pela atual em 08/09 as ~23:08.

**Errei a hipotese:** apostei que o `GetProcAddress` devolvia nil por falta do simbolo. A lib nova
resolveu sem mais nada, entao a de junho carregava e exportava - o que estourava era a chamada contra
um contrato que mudou. Segunda hipotese, nao a primeira.

Efeito, medido na central em 33 minutos:

```
23:15  entregues=935   servidores com fila parada=38
23:28  entregues=1000                            29
23:40  entregues=1101                            20
23:48  entregues=1102                            20
```

+167 entregas. **A fila nao drenava em nenhum cliente rodando o robo_novo** - os 42 servidores
parados tinham a mesma causa, nao era caso do DONATO. A curva chapou nos ultimos 8 min; se os 20
restantes tem outra causa, so a leva de amanha diz.

### Andamento poluindo a GAT_ULTMSG, e virando pendencia na view

Levantado pelo Joao: apos os consertos, a `GAT_ULTMSG` passou a gravar

```
08/09/2026 20:42:32 - Preparando relatorio...
08/09/2026 20:42:34 - Criando paginas...
```

A intuicao dele - "quem audita no servidor central deve procurar por sucesso" - estava certa, e por um
caminho melhor do que os dois que tentei antes.

**Duas hipoteses minhas, ambas erradas:**

1. *Global so-de-erro.* Nao serve: o eixo nao e erro x ok. `pMensagemOk` e quem emite "Nao ha dados
   para gerar o relatorio!", desfecho legitimo que a view exclui de proposito.
2. *ID07 e a chave de sucesso.* Nao e. O `gatilhos_informacao_tipo_erro` alimenta ticket; quem decide
   `QTD_PENDENTE` e o `WHERE` da `vw_monitoramento_gatilhos_informacao`.

A view (trazida pelo Joao - a conta `atendimentoII` nao tem `SHOW VIEW`) exclui quem casa:

```sql
NOT LIKE '%Mensagem enviada com sucesso%'
NOT LIKE '%Nao ha dados para gerar o relatorio%'
NOT LIKE '%Gatilho nao executa em feriados%'
NOT LIKE '%Gatilho ja foi enviado%'
```

`QTD_OK` conta so o prefixo `^\[OK\]`, carimbo da triagem. Tudo que sobra e `QTD_PENDENTE`.

A cadeia:

```
andamento entra na Mensagens (AddLog)
  -> untGatilhosInformacao:2058 nao ve vazio, nao carimba MSG_SUCESSO_ENVIO
    -> GAT_ULTMSG sem "Mensagem enviada com sucesso"
      -> a linha nao e excluida pelo WHERE
        -> QTD_PENDENTE -> candidata a ticket
```

Medido: **167 gatilhos** com texto de andamento, e 659 de 3.506 sem casar com nenhum tipo.

**Conserto**, em `GatilhosInformacao/Target/Linux/untExecutarGatilhos.pas`: eram **quatro** ganchos no
`AddLog`, nao um. Os dois de desfecho ficam; os dois de andamento passam a `WriteLog`.

```
VS_OnMensagemAoUsuario   -> AddLog     desfecho    (mantido)
VS_OnMensagemDeErro      -> AddLog     desfecho    (mantido)
VS_OnMensagemAguarde     -> WriteLog   andamento   (mudou)
TfrmGravando.OnMensagem. -> WriteLog   andamento   (mudou)
```

Nao se perde nada: no caminho de falha todos os pontos usam `Mensagens.Text :=`, que substitui. E o
andamento nao ia para o stdout antes - passou a ir.

**Validado em producao**, DONATO gatilho 000013 (dashboard, `GAT_ULTMSG` era o proprio defeito), apos
`GAT_ULTENV` recuado um dia para escapar do `JaFoiEnviado`:

```
GAT_ULTMSG   08/09/2026 23:47:33 - Mensagem enviada com sucesso!
GATIME       00100000000000660001  23:47:33  obs=Enviado
```

**Ponta solta:** ninguem no fonte emite "Gatilho enviado com sucesso!", a frase de 1.329 linhas na
central - so aparece em comentario. Vem da libGatIme.so ou de binario anterior. Nao afeta o conserto
(a view aceita as duas), mas nao esta explicado.

### Situacao dos clientes do requisito, 08/09 23:49

```
Fila entregue por completo (12)
  BELATINTAS 70, CONARA 12+22, CONSTRUART 17, DONATO 4, MARCIUS 6,
  HOME_CENTER 8+1, PALMARES 23, POTENCYA 23, TINBOL 3, VIVA_COR 23

Parcial - deve cair sozinho, frota ainda drenando
  MINAS_BOMBAS 12/5, SOL_VINIL 36/10, MORVILLO(003) 1/0

Venceu e NAO gerou linha na fila - nao investigado
  CM_MATERIAIS 4, HERALDO 8, MORVILLO(001) 5, VAPTBLUE 6
```

O ultimo grupo e o unico que merece investigacao propria. Pode ser legitimo (relatorio sem dados),
mas o dia esta contaminado pelo defeito e nao da para distinguir. Medir amanha cedo.

### Para o commit de 09/09

`Req. 460229` na primeira linha, token do DelphAI. Dez arquivos:

| Arquivo | O que |
|---|---|
| `fontes/genericos/untThreadUtils.pas` | Linux sem TThreadConnections, so Begin/EndThreadConnection |
| `fontes/genericos/untTypesSistema.pas` | IThreadConnections sob IFNDEF LINUX |
| `fontes/editorRelatorios/untInterfaceRelatorio.pas` | CheckSynchronize, guarda de Finished, pOpenQuery/pExecuteQuery na interface |
| `fontes/editorRelatorios/untThreadRelatorio.pas` | usa pOpenQuery/pExecuteQuery |
| `fontes/editorRelatorios/untRelatorio.pas` | blnConexaoIndependente False no Linux |
| `fontes/editorRelatorios/untGraficosDashboard.pas` | guard fTabelaExiste('RELDRI') |
| `fontes/editorRelatorios/untGeraFR3.pas` | 3 FindField (REL_FILLAT x2, margens) |
| `fontes/util/untGatilhosInformacao.pas` | VS_UltimaMensagem nos 2 ramos + destrave de lock orfao 30min |
| `Services/GatilhosInformacao/.../MonitorarGatilhos/untGatilhos.pas` | metrica corrigida, parenteses no spawn, comentario do corte de 20h |
| `Services/GatilhosInformacao/Target/Linux/untExecutarGatilhos.pas` | andamento para WriteLog |

Validados em producao hoje: guard do RELDRI, os tres FindField, o destrave de lock, o andamento fora
da GAT_ULTMSG. Os cinco da madrugada dependem da leva de amanha.

Fora do commit: `Services/Core/gatilhos/untGatilhosInformacaoImagemAnexoDashboard.pas` foi tocado mas
nao revisado hoje - conferir antes de incluir.


### Correcao da lista de commit - svn status, 08/09 23:55

A lista da secao anterior tinha 10 arquivos. O `svn status` mostra **15** fontes modificados. Os
cinco que faltavam, classificados pelo diff:

| Arquivo | Veredito | Por que |
|---|---|---|
| `Services/Core/Services.Core.Connection.Manager.pas` | entra | acrescenta `untThreadUtils` ao uses - par da mudanca de thread |
| `Services/Core/gatilhos/untGatilhosInformacaoImagemAnexoDashboard.pas` | entra | `GetImagemResizeJPEG`; o comentario diz que o defeito ja estava na HEAD e nao e do requisito, mas sem ele o robo nao compila no Linux (E2003 em untGatilhosInformacao.pas:861) |
| `Services/GatilhosInformacao/Target/Linux/GatilhosInformacao.dpr` | entra | 3 units no uses, pedidas pelo compilador |
| `Services/libGatIme/Target/Linux/GatIme.dpr` | entra | as mesmas 3 units |
| `fontes/cadastros/untTCadForRepository.pas` | **FORA** | uma linha em branco (`+^M$`), nada mais - reverter |

Total do commit: **14 fontes**. Reverter o `untTCadForRepository.pas` antes.

Nota sobre o `untGatilhosInformacaoImagemAnexoDashboard.pas`: vale citar na mensagem de commit que
ele entra por dependencia de compilacao, nao por escopo. O comentario dentro dele levanta a hipotese
de que esse E2003 e a razao de o binario em producao ser de 02/06 - o que casa com a data da
libGatIme.so encontrada hoje. Se for isso, o requisito destravou um bloqueio de build que durava
tres meses.

### Estado ao fechar o dia

```
defeitos encontrados e corrigidos   8
fontes alterados, nada commitado   14 (+1 a reverter)
frota: entregues hoje             916 -> 1102
servidores com fila parada         42 -> 20
```

Validados em producao hoje: guard do RELDRI (DONATO), os tres FindField (MINASBOMBAS parou de
acusar), o destrave de lock orfao (log das 23:01), o andamento fora da GAT_ULTMSG (DONATO 000013,
"Mensagem enviada com sucesso!").

Sem validacao ainda: as cinco mudancas de thread/conexao da madrugada. Dependem da leva das 07h30.

Pendencias que sobrevivem ao dia:

- 20 servidores com fila parada - a curva chapou as 23:40, causa desconhecida
- 4 clientes do requisito com gatilho vencido e nenhuma linha na fila: CM_MATERIAIS, HERALDO,
  MORVILLO(001), VAPTBLUE
- ninguem no fonte emite "Gatilho enviado com sucesso!" - 1.329 linhas na central com essa frase
- ID29 abriria ticket para estado transitorio se a automacao (parada desde 21/08) voltar
- dois rotulos mentindo no log do monitor: `(FIXADO)` no cliente rebaixado, `Robo default:` sem
  `--pasta_default` no processo de update
- UniDAC bind offset - repro em `IA/know/unidac_linux_bind_offset.md`, investigacao adiada


### Medicao de 09/09 - as duas levas da manha

Janela de 76 min, 20 leituras a cada 4 min, cobrindo a leva das 07:30 e a das 08:00
(`scratchpad/watch_manha.py`).

```
07:31   deviam=122  fila=121  entregues=119   98,3%   parados=2
08:07   deviam=263  fila=261  entregues=251   96,2%   parados=6   <- pico de producao
08:47   deviam=494  fila=492  entregues=482   98,0%   parados=3
```

O indice ficou entre **96,2% e 98,9%** o tempo todo; o vale coincide com o pico, quando mais
servidores estao em voo. `andamento_hoje = 0` nas vinte leituras.

```
              deviam  fila   entreg    %     parados
08/09 (dia)    1527   1250    1102   88,2      20
09/09 (08:47)   494    492     482   98,0       3
```

O que mudou de natureza, nao so de numero: a distancia entre `deviam` e `fila` era **277** ontem e
hoje sao **2**. Era ela que virava divergencia no painel.

Comparar os totais (494 x 1527) nao vale - o dia nao acabou, e o de ontem estava inflado por gatilho
reprocessado. O que se compara e o percentual e o numero de parados.

**Armadilha que quase me pegou de novo:** contar `ultima_mensagem LIKE '%sucesso%'` na faixa das 08h
dava **zero**, com `Pendente de envio` subindo - parecia leva inteira falhando. E artefato: o monitor
sobrescreve a mensagem de todos, entao aquela coluna e cega para sucesso. A fonte que ele nao
sobrescreve e `entregues` na `gatilhos_informacao_divergencia`, vinda do `GAT_OBSWPP` do cliente.
Mesmo erro de leitura de 08/09 22:09, agora em outra roupa.

### Rename de pOpenQuery / pExecuteQuery

Levantado pelo Joao na revisao: nome generico demais para simbolo que subiu para a interface de uma
unit muito usada. Renomeados para `pOpenQueryRelatorio` / `pExecuteQueryRelatorio` - 10 ocorrencias em
3 arquivos, trocadas em bytes com fronteira de palavra para nao mexer em encoding nem EOL.

Ja existiam duas procedures locais `pOpenQuery` em `Faturamento.Classes.TFatVendaBase.pas:46076` e
`untPcmGer.pas:1589`. Sao locais a metodo, entao sombreavam sem quebrar nada, e as assinaturas
divergem (`TUniQuery` x `Boolean`) - uma chamada errada nao compilaria em vez de errar calada. Era
confusao de leitura, nao de comportamento, mas o nome novo diz a verdade: o que essas rotinas fazem e
especifico de relatorio (`PrepareQueryFinalSQL` + retry de collation).

### Conferido na revisao, sem alteracao

`WriteLog` **e thread-safe**: `FLockLog.SafeEnter` com `try/finally Leave`, e carimba
`TThread.CurrentThread.ThreadID` na linha - da para separar a saida da worker da principal. As duas
closures anonimas do item 7 estao seguras.

`fLockTaskMonitor` - o Joao enquadrou como "nao e o ideal mas e o possivel": enquanto a conta dos
robos nao enxerga a PROCESSLIST, idade e o unico sinal disponivel. Sem alteracao, decisao consciente.


### Rodada de revisao - 09/09/2026

Cinco achados. Um exigiu codigo, dois viraram comentario, dois foram argumentados sem mudanca.

| # | Achado | Desfecho |
|---|---|---|
| 1 | Destrave de lock em 30 min sem verificar dono | **codigo alterado** - duas condicoes |
| 2 | FDicDestrava populado antes do spawn | comentario; sem mudanca de comportamento |
| 3 | pSetaEmpresaLogada sob IFNDEF sem substituto | comentario; adiado com justificativa |
| 4 | Saida por Finished so no Linux | sem ajuste - ja documentado no ponto |
| 5 | SUM(IS NOT NULL) dependeria de sql_mode | falso positivo - testado |

### O item 1 e o que eu nao tinha visto

Eu vendi os 30 minutos dizendo que o pior caso era "ciclo interrompido, volta na proxima leva". O
revisor apontou **envio duplicado ao cliente final**, e ele estava certo sobre o mecanismo:

```
pExecuteCliente   SELECT ... WHERE GAT_LIBENV = 'S'   sem claim, sem FOR UPDATE
pMarcaGatImeEnviado libera LINHA A LINHA               (WHERE AUTOINCREM = :AUTINC)

A abre cursor com 50 linhas -> processa 1,2,3 e marca cada uma 'N'
B rouba o lock no minuto 30
B faz SELECT -> ve 4..50 ainda 'S'
A continua iterando o cursor DELE, que tambem tem 4..50
```

A sobreposicao nao e uma linha: e todo o resto do cursor.

**O que reduz a gravidade**, e que eu so descobri ao verificar em vez de argumentar: os dois fluxos
leem tabelas diferentes.

```
pExecuteCliente   -> GATIME_WPPEMA    tem guarda de PID por linha (untProcessaGatilhosImediatos:329)
pExecuteOperador  -> GATIME_ENVIOS    sem guarda nenhuma
```

E a `GATIME_ENVIOS` e rala: em 8 clientes medidos, 6 tem a tabela **vazia**; PALMARES tem 5 linhas
hoje e TINBOL 15; **zero pendentes** em todos. O `pExecuteOperador` roda primeiro e termina em
segundos - no minuto 30 a instancia esta quase certamente no `pExecuteCliente`, que e o protegido.

Registro do meu erro de percurso: cheguei a dizer "isso muda o que eu recomendo" e propor voltar
para 4 horas. Era correcao para o lado errado, feita antes de verificar qual tabela cada fluxo le.

### A solucao veio do Joao: idade E tentativas

Proposta dele: somar `LCK_TENTAT > X` a condicao de idade.

`LCK_TENTAT` **nao mede saude do dono** - conta quem tentou e falhou, e sobe igual para lock vivo e
morto. Como sinal de liveness e inutil. Mas discrimina por via indireta: lock vivo termina e solta
antes de a fila de pretendentes crescer; lock morto acumula.

Medido em 09/09/2026 nos **964 locks da chave OPERACIONAL** em 401 clientes:

```
              locks   tentativas          idade>30   idade>30 E tent>10
VIVO            878   mediana 0, max 14        2              0
ORFAO            86   mediana 12, max 59      71             42
```

Com as duas condicoes o falso positivo foi **zero** nos 878 vivos; idade sozinha derrubaria 2. O
custo e liberar 42 orfaos em vez de 71 - e os 29 que ficam tem `tent` baixo, ou seja, ninguem esta
bloqueado por eles.

Na amostra mais ampla (3.260 locks, todas as chaves) a mesma regra leva o falso positivo de 17 para
1.

**Armadilha descartada:** `LCK_TENTAT` pode nascer em **-999** quando o lock vem do
`pGatilhosImediatos`, que passa esse valor como `intTentatDefault`. Um lock assim precisaria de 1009
contendas para passar de 10. Verificado: **zero** locks negativos entre os 964 da chave OPERACIONAL -
essa origem usa outra chave. A regra e segura aqui, mas nao seria universal.

Contrapartida aceita e anotada no codigo: tentativa so acumula se alguem tentar, entao cliente onde o
robo sobe uma vez por hora demora mais para destravar. O `-f` forca quando se sabe o caso.

### Ponta aberta, deliberada

Guarda de PID no `pExecuteOperador` - unico ramo sem freio. **Nao aplicada.** O fluxo de envio ao
operador nao foi exercitado em nenhum momento destes dois dias, e acrescentar saida antecipada num
caminho sem observacao e o mesmo tipo de risco que fez o item 3 ser adiado. Exposicao medida e nula.


### Segunda rodada de revisao - 09/09/2026, VERDICT REJECTED

Cinco achados bloqueantes, todos em codigo meu. **Quatro procediam e foram corrigidos**; o quinto foi
contestado com evidencia.

| # | Achado | Desfecho |
|---|---|---|
| 1 | `SQL_CANDIDATOS`/`SQL_IDADE` presos em `= CURRENT_DATE` | **corrigido** |
| 2 | `FindField` como guarda em `untGeraFR3` | contestado |
| 3 | `pGravarMensagemGatilho` reusa `LQuery` sem `Close` | **corrigido** |
| 4 | `LCliente` fora do `try/finally` | **corrigido** (2 pontos) |
| 5 | `ShellExecute` sem quoting - command injection | **corrigido** |

**O item 1 era autodestrutivo.** O proprio comentario do mecanismo diz que ele existe para a janela
noturna - "ultimo gatilho as 18:15, fila cheia ate 07:30" - e o `= CURRENT_DATE` o desligava as 00:00,
no meio dessa janela. O filtro ainda era redundante: quem corta e o `TIMESTAMPDIFF(HOUR) < :MAXHORAS`.

**O item 5 tem duas cercas agora:** `fNomePastaValido` recusa caractere de shell no ponto que produz o
valor, e `fAspasShell` envolve em aspas simples no ponto que monta o comando.

**O item 2 foi contestado** porque a premissa - "anti-padrao explicito do projeto" - e falsa: sao 26
`FindField` no proprio `untGeraFR3`, a forma canonica esta em 7230-7235, e ha precedente identico em
`untInterfaceRelatorio:13982`. E `EDatabaseError` e justamente o defeito que o requisito corrige.

**Erro de percurso registrado:** o parecer que o Joao colou repetia os cinco achados, mas o
`review.diff` de 15:57:30 ja continha os quatro consertos (aplicados 15:52:12). Verifiquei antes de
mexer - reaplicar teria duplicado conserto.

### Deploy e validacao em producao

Tres artefatos, nao dois: **GatilhosInformacaoMonitor**, **GatilhosInformacao** e **libGatIme.so** - a
lib entra porque o `GatIme.dpr` inclui `untThreadUtils` e `untTypesSistema`, que mudaram.

`Services.Core.Connection.Manager.pas` saiu do commit: era so um `uses` de `untThreadUtils`, o Joao
reverteu e **o Linux compilou sem ele**.

Validacao, em ordem de contundencia:

```
TINBOL       51 gatilhos   51 na fila   51 entregues     ontem: 48x "RELDRI doesn't exist"
DONATO        8 gatilhos    8 na fila    8 entregues     ontem: 4x REL_FILLAT, 3x andamento
HOME_CENTER  12 gatilhos    9 na fila    9 entregues     ontem: 9x andamento, 2x "Url em branco"
CHUVEIRAO     4 gatilhos    4 na fila    4 entregues     16:30:35, contra 16:30:22 de ontem
```

**O TINBOL e a prova do guard do `fTabelaExiste`** - 48 gatilhos que morriam em sequencia passaram.

**O DONATO revelou defeito escondido:** dos 8, seis gravaram sucesso e **dois** passaram a acusar
`Erro interno. Estrutura de dados nao carregada!` (`ID13`). Nao e regressao - e o erro que estava
atras do `REL_FILLAT`, agora com nome. Comportamento correto do conserto.

**Ponta solta fechada:** ontem os gatilhos gravavam "Gatilho enviado com sucesso!", frase que nao
existe em nenhum `.pas`. Hoje gravam "Mensagem enviada com sucesso!", a constante `MSG_SUCESSO_ENVIO`.
Confirma que a frase antiga vinha da `libGatIme.so` de 02/06. Fleet-wide hoje: **zero** ocorrencias da
frase antiga.

### Numeros do dia

```
dia          serv  deviam  fila   entreg   %      parados
08/09        163   1527    1250   1102   88,2      20
09/09        166   1519    1508   1445   95,8       9
```

A distancia entre `deviam` e `fila` era **277** e virou **11** - e era ela que caracterizava o defeito
do requisito.

Dos 813 gatilhos que rodaram hoje: `RELDRI doesn't exist` = 0, `REL_FILLAT not found` = 0, rastro de
andamento = 0, "Gatilho enviado com sucesso" = 0.

E a `vw_monitoramento_gatilhos_informacao` **zerou** - de 33 linhas com `QTD_PENDENTE > 0` as 17:21
para nenhuma as 23:06. Nao por carimbo `[OK]`, mas porque passaram a gravar a frase que o `WHERE` da
view exclui.

### A descoberta da register - quem consome a nossa status

Levantado pelo Joao: ninguem sabia quem alimenta a `gatilhos_informacao_register`, e e dela que a view
do painel le. Resposta: **e retrato da nossa `gatilhos_informacao_status`**.

```
nosso monitor  ->  status.ultima_mensagem       (sobrescreve o desfecho do robo)
                        |
                        v   retrato DIARIO as 09:10, por id_origem
                    register                     <- a view do painel le DAQUI
                        |
                        v
                    analise do time cit_aderencia (observabilidade)
```

Medido: 3.967 de 3.972 linhas de ontem/hoje tem `id_origem` apontando para um `id` existente na
`status` - 99,9%. A tabela guarda 135 dias de `data_snapshot`, de 07/05 a hoje.

**Consequencia:** o retrato de 09/09 foi as 09:10, depois de o monitor ter passado por cima das
mensagens do robo na leva das 07:30. O time analisou o diagnostico do monitor, nao o desfecho do robo -
sem que nenhum dos dois lados soubesse. E eles estao sempre **um dia atras**.

Rastreamento ponta a ponta, com o erro novo do DONATO:

```
cliente   GATINF.GAT_ULTMSG   "Erro interno. Estrutura de dados nao carregada!"  18:21   OK
central   status              a MESMA mensagem, atualizada 23:00:51             OK - monitor NAO sobrescreveu
central   register            ainda com "REL_FILLAT" do dia 08                  so amanha as 09:10
```

**Decidido nao mexer** na `status` nem na `register` - ver a secao propria na spec
`IA/specs/pendencia-gatilhos/spec.md`, com o furo declarado em numeros.

### O teste da meia-noite - item 1 provado

```
23:58   [09/09] fila=1508 entr=1445 falta=63   apurou 23:58:25
00:01   [09/09] congelado (data_ref virou)     [10/09] fila=64 entr=64
```

O `falta=63` nao caiu, mas **isso nao refuta**: a maior parte dos 63 e falha de canal (`AUTH_018`,
`curl (22)`, `503`), e o `SQL_IDADE` exige observacao VAZIA justamente para nao insistir nelas.

A prova veio de rodar o proprio `SQL_IDADE` com as duas janelas, contra o banco do cliente, depois da
virada:

```
ITAPUA_ELETRO / e=001
   janela nova  ">= CURRENT_DATE - INTERVAL 1 DAY"  ->  1 candidato
   janela antiga "= CURRENT_DATE"                   ->  0 candidatos
```

Uma linha enfileirada ontem, observacao vazia, menos de 20h - exatamente o caso que o mecanismo existe
para resolver, e que ficaria invisivel das 00:00 as 07:30 com o codigo anterior.

Falta a segunda metade: o `DestravarFilas` eleger o ITAPUA e a linha sair. Acompanhamento em
`C:	mp\meianoite_09092026.log`. Se nao sair ate de manha, olhar `grep DESTRAVANDO` no log do monitor
no Linux - o share `\citel-fileserve` nao responde daqui.


---

## 10/09/2026 - o AV do ITAPUA, e o que ele revelou sobre o destrave

Fechamento do que ficou aberto na virada: a linha do ITAPUA nao saiu, e a causa nao era o destrave.

### O item 1 estava certo, o lock nunca foi orfao

O observador da meia-noite mostrou o `LCK_TENTAT` do `MONITOR_GATILHOS_IMEDIATOS_OPERACIONAL_001` indo
de `0` para `-999` as 02:27 e a linha sumindo sozinha depois das 04:17. Fui atras de quem escreve `-999`
e e codigo nosso, em `untProcessaGatilhosImediatos.pas:335` e `:498`:

```pascal
pZerarTentativasLock(LIdMonitor {$IFDEF LINUX}, -999{$ENDIF});
```

No Linux o robo carimba `-999` a cada iteracao **enquanto trabalha**. E heartbeat, nao abandono. O
destrave nao disparou porque nao havia o que destravar.

**Consequencia boa:** a segunda condicao (`tentativas > 10`) que o Joao pediu e o que impede matar um
robo Linux vivo. O `pZerarTentativasLock` nao mexe em `LCK_DTALCK`, entao o heartbeat nao rejuvenesce a
idade — um robo legitimo processando fila longa passa dos 30 minutos com o lock intacto. So o tempo
teria matado ele. O `-999 > 10` e falso e barra.

**Consequencia ruim, que se materializou no mesmo dia:** um dono que morre deixa a linha em `-999`. Cada
tentativa frustrada soma 1, entao sao 1010 incrementos para passar de 10. Sob o monitor de producao, que
sobe de hora em hora, seriam semanas. O destrave por idade+tentativas fica inerte no Linux.

Isso ficou pendente por decisao — o Joao conhecia o uso do `-999`. Mas foi exatamente o mecanismo que
transformou um bug de uma linha em 24 horas de cliente sem gatilho.

### O ITAPUA: seis hipoteses, cinco erradas

Ordem em que cairam, porque o caminho importa mais que o destino:

**(a) Filtro da query do consumidor.** Rodei o `SQL_ENVIO_GATILHOS` a mao com o filtro OPERACIONAL: as 8
linhas voltam. Nao era filtro.

**(b) Bloqueio de cabeca de fila.** A linha `4674001` tinha `GAT_D_EWPP` carimbado e `GAT_D_EEMA` nao —
achei que o processo morria no meio dela e, sendo FIFO sem claim, releria a mesma linha para sempre.
Explicava tudo. Estava errado: era resto de quando o consumidor ainda funcionava. Nao havia consumo
nenhum.

**(c) `fRetEmpresaFisica` divergindo do host.** O host formata a chave do lock com `fRetEmpresaFisica`
(`SELECT PRO_CODEMP FROM PROCOD WHERE PRO_NOMARQ = "MOVGER"`) e a DLL tambem. Conferi nos dois clientes:
`001` em ambos. Nao era descasamento de chave.

**(d) `CFG_GATURL` errada.** Comparei com a frota: 387 clientes com a mesma URL, ITAPUA entre eles.

**(e) `fCarregarDll` devolvendo nil.** O `except` dele e vazio no Linux (`{$IFNDEF LINUX}` sem `{$ELSE}`),
entao engoliria a falha e devolveria `Result` nao atribuido. Instrumentei. Nao disparou — a interface
estava assinada.

**(f) A `.so` estar desatualizada.** Minha propria conferencia por `strings` deu `0` para o literal novo,
e eu quase conclui que o build nao subiu. O comando estava errado: literal Delphi e `UnicodeString`,
gravado em UTF-16, e o `strings` padrao pula. Com `strings -el` deu `1` nos dois binarios. Fica a licao
de sempre usar um literal de controle que ja existia antes.

### O que realmente era

`gdb -batch -ex run -ex bt` deu a pilha. Em duas etapas, porque executavel e `.so` sao projetos
separados e so a config Debug emite DWARF (`DCC_DebugInfoInExe`) — na primeira rodada o executavel
resolveu e a `.so` ficou em `??`.

```
#0  System::TObject::Free()   Self=0x7fffce182715      System.pas:17586
#1  fEnviarEmail              untProcessaGatilhosImediatos.pas:851
#2  fExecutaClienteEmail      untProcessaGatilhosImediatos.pas:1036
#3  pExecuteCliente           untProcessaGatilhosImediatos.pas:363
#4  pExecuteAll               untProcessaGatilhosImediatos.pas:238
#5  TGatIme.fMonitorar        GatilhosImediatos.Classes.pas:72
```

`Self` em endereco impar. Objeto Delphi nunca fica em endereco nao alinhado — era lixo de pilha sendo
liberado.

```pascal
var
  mmsImaAss: TMemoryStream;          { local, sem inicializacao }
begin
  try
    if not fDadosPreenchidos then
      Exit;                          { pula a unica atribuicao }
    ...
    mmsImaAss := fCarregaImagemAssinatura(...);    { linha 790 }
  finally
    if Assigned(mmsImaAss) then      { le lixo de pilha }
      FreeAndNil(mmsImaAss);         { SIGSEGV }
  end;
```

`fDadosPreenchidos` exige e-mail, servidor SMTP, porta, limite de arquivos e senha (ou provedor OAuth2).
A configuracao de e-mail do ITAPUA e incompleta para parte dos destinatarios — o que combina com o
historico de `Erro ao enviar E-mail` na fila dele, de antes de hoje. Cliente com e-mail correto nunca
passa pelo `Exit`, logo nunca toca no lixo. E mesmo passando, so estoura se a pilha tiver nao-zero
naquele endereco — dai ter parecido intermitente.

Conserto em `untProcessaGatilhosImediatos.pas:720`: `mmsImaAss := nil`.

### A cadeia completa, para nao esquecer a forma

```
config de e-mail incompleta em alguns destinatarios
  -> Exit na linha 731
  -> finally libera lixo de pilha
  -> SIGSEGV: sinal mata sem desempilhar, nenhum finally do chamador roda
  -> lock fica em LCK_TENTAT = -999
  -> ciclos seguintes saem no Exit do lock, calados
  -> destrave por idade+tentativas nao pega (-999 nao passa de 10)
  -> parada permanente, sem erro em lugar nenhum
```

Cada destrave manual comprava exatamente um crash. Foi por isso que a fila ficou de 09/09 15:43 ate
10/09 11:46 com ninguem percebendo — o monitor reportava apenas `Pendente de envio na GATIME_WPPEMA`,
que e verdade e nao ajuda.

### Validacao

Com a correcao, o `GatIme.dproj` recompilado e o lock destravado a mao:

```
antes:  25 linhas com GAT_LIBENV = 'S'
depois: 0   (por LIBENV: {'N': 83})
LOGERR desde 11:35: nada
```

E entrega de verdade, nao so carimbo: 21 das 25 sairam. Os tres relatorios das 07:30, o das 08:04, o
`RELATORIO DIARIO` preso desde ontem 18:39, e 14 boletos por e-mail. As cinco que ficaram em
`Erro ao enviar E-mail` sao as do `fDadosPreenchidos` falso — agora **saem da fila** em vez de matar o
processo, que era o objetivo.

### Instrumentacao que ficou

Duas edicoes que nao sao o conserto, mas nasceram da investigacao e ficam de pe:

- `GatilhosImediatos.Classes.pas:409` — `WriteError` no `except` que era cego no Linux.
- `untDllGatIme.pas:143` — guarda de `DllGatIme` nil, para o AV nao levar junto o
  `TAtualizarGatilhosWebService.Execute`, que vem depois no mesmo bloco de `untGatilhosInformacao.pas`
  sem `try/except`. Esse efeito colateral nao estava no radar: enquanto o ITAPUA estourava, a
  sincronizacao dele com a central tambem nao rodava.

### O metodo virou documento

O caminho de diagnostico esta em `IA/know/depurar_av_linux.md` — a escada do mais barato ao mais caro, as
armadilhas (`strings -el`, ASLR, endereco impar, `SIGSEGV` e `finally`, `stripped` por config e nao por
deploy) e o padrao de bug a procurar. Foi pedido explicitamente para servir a outros desenvolvedores.

### Aberto

- **O `-999`.** Com este crash consertado o caminho para de gerar orfao, mas qualquer outra falha ali
  volta a travar permanentemente e calada.
- **A config de e-mail do ITAPUA**, que e a condicao que expoe o defeito.
- **O ALVES / relatorio 010523.** Gatilho `000009`, `VENDAS POR MARK-UP`, `GAT_DIAMES` nos dias 10/20/30
  — 10/09 foi a primeira data elegivel desde 30/08, e a mensagem antiga (`Gatilho enviado com sucesso`,
  contra `Mensagem enviada` dos outros) confirma que nunca renderizou sob o binario atual. AV localizado
  em `untGeraFR3.pas:7772`, `FFrxReport.PrepareReport`. Descartados: falta de `CADVAL` (os valores
  estavam la), sub-relatorio (o 010511 tem 10 e roda) e componente grafico (nenhum dos nove tem).
  Defeito real e independente no caminho: `VS_FLTPRECUS` chega ao `pRestauraValores` como `CUSTO` e sai
  do `fRetDado` vazio, porque tem `PAR_AUTOMA = 'S'` e o `Locate` e feito no dataset carregado com
  `PAR_AUTOMA NOT IN ("S","P")`. Aguarda o teste no autcom Windows com os mesmos parametros, para
  separar renderizacao Linux de dado.


---

## 15/09/2026 - o canario v2 e o mapa das causas de nao-envio

Dia com duas frentes: validar em producao as correcoes do ALVES, e mapear por que a frota
ainda nao entrega tudo.

### O canario

Criada a pasta `robo_novo_v2` e usada a fixacao por cliente que ja existia e estava vazia -
`gatilhos_informacao_robo (servidor, empresa, pasta)`. Dezesseis clientes fixados.

Duas armadilhas da fixacao, as duas pegas a tempo:

- **A chave e (servidor, empresa)**, e varios clientes tem mais de uma. O PINHAL rodou com
  `-e051`, o ILHA e empresa `014`, o CONARA `013`. Fixar so a `001` teria deixado metade do
  experimento no binario antigo, sem nada denunciando. O `INSERT ... SELECT DISTINCT` da
  propria `gatilhos_informacao` resolveu.
- **O guardrail roda ANTES da fixacao.** `fClienteDaContaDaFila` exige 20 entregas confirmadas
  em 7 dias; quem reprova vai para `robo_velho` e a linha fixada nunca e lida. TINTAS_PIG e
  SOLDAGE entraram na tabela e nunca rodaram o v2.

Resultado da noite: cinco clientes subiram para 100% (PINHAL 81,8; REIMAC 90,0; SOL_VINIL 88,9;
TLC_TINTAS 83,3; VISUAL_AUTOMOTIVA 85,0), nove mantiveram 100% com 253 gatilhos, nenhuma
regressao. O relatorio 010523 do ALVES foi validado pelo **artefato**: PDF extraido da LOGAPI
mostrando `TINTA: Coral Imobiliaria` - nome resolvido, nao o codigo `CIM` que a guarda
devolveria.

### O guardrail e circular

A regra mede **entrega** para decidir quem recebe o binario novo. Cliente que nao entrega e
julgado incapaz e mandado para o binario de **abril de 2025** - justamente o que tem menos
chance de conserta-lo. Quem cai ali nao sobe sozinho. MARINLOG com 0 de 62 em 7 dias e o
retrato.

O comentario do codigo defende medir capacidade e nao erro, e a defesa e boa: em 08/09 um
`opcoes.ini` faltando fez 23 clientes saudaveis falharem de uma vez, e uma regra por erro teria
rebaixado todos. Este e o outro chifre do dilema, e continua aberto.

### O mapa das causas

Varridos os 14 clientes com maior buraco. A populacao que falha e sempre a mesma: linhas com
`GAT_INFJSN` do tipo **`TDadosEnviaWhatsapp`**, que e o que o gatilho de informacao grava. O que
muda e o destino.

**1. Portao do templateId - DEFEITO DE CODIGO.** CONSTRUART (134 linhas) e MULTIVAREJO (25).

```pascal
// fExecutaClienteWhatsAppOficial
LEnqueueMessageToSend.templateId := StrToIntDef(ATemplateId, 0);
if LEnqueueMessageToSend.templateId = 0 then
  Exit;          // sai com tpNaoEnviado, SEM LOG
```

O cliente migrou a fila para a API oficial (`CADFIL.FIL_APIOFI = 'S'`) em 09/09; a API oficial
exige template; o JSON `TDadosEnviaWhatsapp` nao carrega `template.id`. Desde entao os seis
gatilhos diarios sao descartados em silencio.

A prova de controle: existe **uma** linha `TDadosEnviaGatilhoWhatsapp` com `template.id = 0` -
e ela tambem foi recusada. O discriminador e o template, nao o tipo.

O `Exit` e mudo em tres sentidos, e os tres custaram seis dias: nao grava `LOGERR`, nao
distingue "sem template" de "sem destino", e escolhe o rotulo **"Envio nao previsto"**, que le
como decisao de configuracao e nao como falha. Pior: `pMarcaGatImeEnviado` fecha a linha
(`GAT_LIBENV = 'N'`), e a reconciliacao so conta como entregue quem tem `obs = 'Enviado'`. A
linha some do fluxo e nunca mais e contada.

**2. Credencial da fila.** MARINLOG (50+19), GRUPO_REALEZA (25), ABRAFER (18) - todos com
`*curl: (22) ... 401` e `{"errorCode":"AUTH_018"}`. Chega na API e e recusado. Client-side, mas
so visivel no `GAT_OBSWPP`; nao ha linha no `LOGERR`.

**3. Gateway 502.** RWS_ELETRICA (45+3), `502 Bad Gateway`. Cronico: 43,8% de entrega na semana,
antes e depois do v2.

**4. FLUZAO - hipotese, nao concluido.** 47 linhas recusadas e 5 entregues sao **identicas** em
todo campo observavel: mesmo tipo, mesma fila (20, nao-oficial), template vazio nos dois, bucket
presente, sem texto, com numero. O que separa: as recusadas **nao produziram nenhuma chamada de
API** (`LOGAPI` vazia por `LOG_SEQFGO`), enquanto a entregue tem `uploadFile` + 
`enqueueMessageToSend`, ambas 200. Ou seja, o robo saiu antes de chamar a API, no unico ponto
possivel - `if not fEmptyStr(GAT_ARQUIV)`, sendo `GAT_ARQUIV = IF(GAT_ARQBCK<>'', GAT_ARQBCK,
GAT_PATARQ)`.

Hipotese: o FLUZAO roda no `robo_velho` (guardrail), e aquela versao nao conhece o campo de
bucket. **Nao verificada** - tentei comparar os literais nos binarios e o instrumento falhou
duas vezes: `strings` nao existe nesta maquina (os zeros iniciais eram do comando ausente), e a
busca em Python deu zero ate para `GAT_NUMWPP` no `robo_novo`, que comprovadamente usa o SQL -
porque `untProcessaGatilhosImediatos` e compilada na `libGatIme.so`, nao no executavel, e o
`robo_velho` nao tem `libGatIme.so` na pasta. Para fechar, rodar no proprio servidor Linux:
`strings -el robo_velho/libGatIme.so | grep -c GAT_ARQBCK`.

### O que fica para consertar

- O `Exit` mudo do `templateId` - gravar motivo, nao rotular como "nao previsto", nao fechar a
  linha como tratada.
- O mesmo vale para os outros pontos que devolvem `tpNaoEnviado` sem registrar.
- A circularidade do guardrail.
- Cliente em API oficial precisa de gatilho com template; hoje nada valida isso no cadastro.

### Correcao, mesma noite: o FLUZAO e o robo_velho

A hipotese ficou verificada, mas a caminho eu enunciei uma conclusao errada e vale registrar o
erro junto com o acerto.

Escrevi que "o robo_velho nao consegue entregar, por construcao", baseado em `GAT_ARQBCK`,
`GAT_PATARQ` e `pProcessarGatilhosImediatos` darem zero no executavel dele. A sonda estava
calibrada nos identificadores de HOJE: o robo_velho e de uma epoca em que a libGatIme nem
existia, entao a ausencia daqueles nomes so diz que o codigo la e outro. O Joao corrigiu.

Refeita a medicao com escopo maior:

```
literal                  robo_velho(exe)   robo_novo/libGatIme.so
GATIME_WPPEMA                  2                 22
uploadFile                     1                  1
enqueueMessageToSend           1                  1
GAT_ARQBCK / GAT_PATARQ        0                 19 / 5
GAT_ARQUIV / GAT_NOMARQ        0                 10 / 12
GAT_D_EWPP / GAT_OBSWPP        0                  5 / 2
```

Ele tem os dois endpoints - sabe enviar. Nao tem nenhum nome de coluna atual, incluindo o do
bucket. E as 47 linhas recusadas do FLUZAO tem `GAT_PATARQ` nulo e `GAT_ARQBCK` preenchido:
arquivo so no bucket. Binario anterior ao bucket nao acha arquivo, nao chama `uploadFile`, nao
envia - e e exatamente isso que a LOGAPI mostra, zero chamadas nas 47 contra duas na entregue.

Fica sem prova COMO aquele binario le a fila: tem o nome da tabela e nenhum nome de coluna, o
que sugere `SELECT *` ou montagem dinamica. Varredura de literal nao alcanca isso.

**Consequencia para o guardrail**, com o enunciado certo: quem e rebaixado vai para um binario
anterior ao armazenamento em bucket, que e como os anexos dos gatilhos sao guardados hoje. Quem
e rebaixado por entregar pouco passa a entregar menos. O criterio de saida e entregar, e o lugar
onde ele poe o cliente impede entregar.

Copiar a `libGatIme.so` para o `robo_velho` provavelmente nao resolve - aquele executavel nao foi
compilado para carrega-la. As saidas viaveis sao apontar `--pasta_sem_gatime` para uma pasta viva
ou aposentar o `robo_velho`.

**Licao de metodo:** sonda calibrada na versao nova mede mal a versao velha. Ausencia de literal
so vale como evidencia depois de um literal de controle que pertenca AQUELA epoca - e foi a
segunda vez no mesmo dia que confundi instrumento quebrado com resultado (antes, `strings` nem
existia na maquina e os zeros eram do comando ausente).

### As duas faixas, e por que copiar a DLL nao resolve

Corrigindo de novo, com o Joao: o `robo_velho` NAO e sobra a aposentar. E a faixa de
compatibilidade para cliente com AUTCOM antigo, que nao tem tabela nem configuracao de bucket.
Para esse cliente ele funciona como sempre funcionou. Minhas sugestoes de "aposentar o
robo_velho" e "apontar --pasta_sem_gatime para uma pasta viva" estavam erradas e foram riscadas.

Medicao que fecha a arquitetura:

```
literal                       robo_velho   robo_novo
libGatIme.so                       0            1
libGatIme                          0            2
pIniciarConexaoThreadGatIme        0            1
GatilhosImediatos                 30           50
fCarregarDll                       3            4
fMonitorar                         5            6
```

O exe antigo nao contem a string `libGatIme` - nunca chama LoadLibrary nela. Mas tem
`GatilhosImediatos` 30 vezes: **a esteira de envio esta compilada dentro dele**. E a foto de
antes de o envio ser extraido para a DLL.

| | onde mora o envio | conhece bucket |
|---|---|---|
| robo_velho | compilado no exe | nao |
| robo_novo | libGatIme.so | sim |

**Copiar a `libGatIme.so` para o `robo_velho` nao faz nada** - o exe dele nao a procura. Ele envia
pelo codigo proprio, anterior ao bucket, e e por isso que funciona para cliente antigo, que grava
o anexo em disco.

O FLUZAO e o caso fora da curva: grava no **bucket** (AUTCOM novo) e esta sendo processado pelo
exe que so sabe disco. Nao e o robo_velho estar quebrado - e o cliente estar na faixa errada.

### O que trava o FLUZAO: a fixacao nao vence o guardrail

`fPastaRoboDoCliente` (untGatilhos.pas:~700):

```pascal
{ 1. Tem condicao? }
if not fClienteDaContaDaFila(AConnCliente) then
  Exit(PASTA_SEM_GATIME);      // sai aqui; o passo 2 nunca roda
{ 2. A tabela diz qual pasta }
```

Prova ao vivo em 15/09: TINTAS_PIG e SOLDAGE foram inseridos na
`gatilhos_informacao_robo` e o log das 17:40 registrou `usando robo_velho`. Linha inerte.

A tabela tem `fixado_em`, `fixado_por` e `motivo` - e registro de decisao humana. Proposta: ler a
tabela primeiro e, havendo linha, usar e sair; o guardrail continua valendo para quem ninguem
fixou. Nao mexe em nenhuma das duas metades, so troca a ordem. NAO IMPLEMENTADO - falta entender
por que o criterio e volume de entrega, que o Joao conhece e eu nao.

### Estado ao compactar - 15/09 22:00

Mapa de causas dos clientes que nao entregam:

| Causa | Clientes | Situacao |
|---|---|---|
| `templateId = 0` com `Exit` mudo na API oficial | CONSTRUART (134), MULTIVAREJO (25) | causa nomeada, **conserto de codigo pendente** |
| `AUTH_018` / 401 no gateway | MARINLOG (69), GRUPO_REALEZA (25), ABRAFER (18) | credencial - chamado para suporte |
| `502 Bad Gateway` | RWS_ELETRICA (48) | gateway, cronico |
| Cliente novo na faixa antiga | FLUZAO (47) | precisa da inversao fixacao x guardrail |
| `Estrutura de dados nao carregada` | UBERTINTAS (8), COFERSOL, MANTELLI, RIBPECAS | **EM ABERTO** |

Sobre o `Estrutura de dados nao carregada`: a mensagem sai de `fCriaHorizo` e `fCriaHorizoLines`
(untInterfaceRelatorio.pas:9773 e :9854), na condicao
`(Not FQueryFiltros[i].Active) Or (FQueryFiltros[i].Fields.Count = 0)`. Hipotese de ser o caminho
de relatorio horizontal foi **descartada**: os sete relatorios envolvidos tem `REL_HORIZO = 'N'`.
Os relatorios sao 010502, 535315 e 535299 (Titulos Recebidos/Pagos). UBERTINTAS congelou em
10/09 23:44; os outros tres sao de 15/09 a tarde. Proximo passo seria entender por que
`FQueryFiltros` nao esta ativo no Linux - ha comentario em untGeraFR3.pas:6586 dizendo que no
Linux o `PrepareQueryFinalSQL` inlina os params e esvazia `qryDados.Params`, e que `FQueryFiltros`
tem o nome mas nunca recebe valor.

Motivos ainda nao investigados: `Url Dashboard em branco` (21 hoje), `Arquivo PDF nao existe`
(11), `Illegal mix of collations` (CONSTRUART e FLUZAO no mesmo dia 14/09).

Canario: 16 clientes fixados em `robo_novo_v2`, dos quais 14 efetivamente rodando (TINTAS_PIG e
SOLDAGE barrados pelo guardrail). Cinco subiram para 100%, nove mantiveram 100%, nenhuma
regressao. Falta o teste natural do gatilho 000009 do ALVES em **20/09**.


---

## Sessao de 23/09/2026 — as causas que sobraram, e duas hipoteses minhas que morreram

### Como a frota estava ao retomar

```
data        srv   deviam  fila   entr    %
2026-09-14  164   1761    1737   1679   96,7%
2026-09-15  161   1456    1441   1359   94,3%
2026-09-16   85    603     600    567   94,5%   (parcial, 11h)
```

O 94,5% de 16/09 engana para baixo: o lote das 11:01 tinha 129 gatilhos **em transito**. A prova e o
perfil por hora — de 6h as 10h, zero pendente; na hora 11, 40 pendentes e nenhum sucesso, tres minutos
depois da passada. A mensagem `Pendente de envio na GATIME_WPPEMA` e reconciliacao correndo atras do
envio assincrono, **nao veredito**. ILHA_TINTAS, GRUPO_ELO e NACIONAL_MOTO apareceram zerados na
tabela de buraco por isso, e nao por regressao.

O canario segurou: dos fixados em `robo_novo_v2`, tudo que rodou ficou em 100%, com duas excecoes de
causa ja nomeada — CONSTRUART (`templateId`) e RWS_ELETRICA (502 cronico). O ALVES fechou o primeiro
dia cheio em 100% (10/10/10), vindo de 7/5/5 e 8/6/6 antes da fixacao.

### O 404 do upload: causa achada, e duas hipoteses minhas refutadas no caminho

O motivo `Erro ao fazer upload: 404 - curl: (22) ... 404 page not found` nao estava no mapa de causas.
A constante e `MSG_ERRO_UPLOAD_ARQUIVO` (`untGatilhosInformacao.pas:168`) e o upload e o do QualiZap:
`TControllerUploadFile.fUpload` posta em `int/uploadFile` com `BaseURL` vindo de
`CFGSIS.SIS_VALCFG` onde `SIS_CODCFG = 'CFG_URLWPP'`, por empresa
(`untQualiZapUploadFile.pas:105` + `fConfigurarQualiZap`).

**Hipotese 1, refutada: os tres motivos formam cascata.** Eu tinha proposto que o 404 do upload
explicaria tambem `Url Dashboard em branco` e `Arquivo PDF nao existe` — sem o arquivo no bucket, o
resto cairia junto. O cruzamento por cliente mostrou **zero sobreposicao**: MONTANNA e SAMEACH so tem
upload; DEMO_SW, OXI_MAQ, BRASIL_COATING e PITSTOP so tem dashboard; BELLA-LUZ, GASPARZINHO e MILMART
so tem PDF. Sao tres causas independentes.

**Hipotese 2, refutada: o dominio `.citel.dev` e o defeito.** MONTANNA aponta para
`https://gatilhos-montanna.citel.dev` enquanto os clientes saudaveis apontam para
`citel.atenderbem.com` ou `<cliente>.citeldesk.com.br`, e eu li isso como host errado. A varredura de
`CFG_URLWPP` nos 169 clientes ativos derrubou: `.citel.dev` e padrao normal, 17 clientes usam, e o
ILHA_TINTAS usa um desses entregando 102 gatilhos por dia.

**A causa real** saiu de sondar a familia inteira no endpoint que o codigo chama:

```
POST /int/uploadFile
  gatilhos-ilhatintas.citel.dev        200      <- entrega 102/dia
  gatilhos-ouro-mil.citel.dev          200
  gatilhos-samech.citel.dev            200
  gatilhos-montanna.citel.dev          404      <- MONTANNA
  gatilhos-romani / rr-tintas /
  dvautopecas / nacionalautopecas      404
```

E a **rota do tenant nao publicada** no host do MONTANNA — infra, nao codigo nosso. Bate exato: todas
as falhas dele sao das empresas 001, 201 e 202, as unicas tres cujo `CFG_URLWPP` aponta para la.

Detalhe que corrige outro erro meu: os outros quatro hosts que dao 404 **entregam normalmente**, porque
mandam gatilho sem anexo e nunca chegam a chamar o upload. O raio real e **um cliente**, nao cinco.

E uma armadilha de metodo: a `gatilhos_informacao_status` e **snapshot por (servidor, gatilho)**,
reescrito a cada passada. A data de `ultima_atualizacao` nao e a data do erro — quem carrega a data
real e o texto da mensagem. Eu li a janela errada e conclui "comecou em 14/09" sobre linhas que so
ainda nao tinham sido revisitadas.

### O achado que vale mais que o 404: 20 clientes fora da apuracao

```
MONTANNA      status: 13 gatilhos hoje    divergencia: 0 linhas, sempre
SAMEACH       status:  6 gatilhos         divergencia: 0 linhas, sempre
CASAS_JARDIM  status: 10 gatilhos         divergencia: 0 linhas, sempre
```

Vinte clientes tem linha em `gatilhos_informacao_status` atualizada hoje e **nenhuma** linha em
`gatilhos_informacao_divergencia`. Um cliente 100% quebrado nao aparece nos 94,5% — ele simplesmente
nao e contado. E o mesmo buraco que a ideia de trocar o painel de monitoramento por um dashboard
atende, e e argumento para faze-lo.

### Corrupcao de dados na tabela central

Dez linhas com valor corrompido: `servidor = 'n'`, `gatilho = 'n'`, `MONTANNA_DIS???`,
`MONTANNA_DISTRIBUIDOQA` (Q no lugar do R). O MONTANNA ainda tem dois gatilhos cuja mensagem e
`#42000 You have an error in your SQL syntax ... near '"%GATILHOS_INFORMACAO%GATINF=n'` — o mesmo `n`
solto. Cheira a um unico ponto montando query por concatenacao com a variavel errada. **Sem causa
identificada**, nao investigado.

### GAT_KEY_ID: o que quase derrubou a atualizacao do robo_novo_v2

O update trouxe `GAT_KEY_ID` na `GATIME_WPPEMA` (Req. 462624, r495832), para o relatorio de PIX
correlacionar cobranca com envio. O campo foi parar no INSERT da libGatIme **sem guarda**, ao contrario
de `GAT_NUMWPP` e `GAT_EMAIL_`, que sao condicionais na mesma montagem
(`GatilhosImediatos.Classes.pas:259`).

Nao e caminho lateral: o robo de gatilhos de informacao enfileira por ali
(`untGatilhosInformacao.pas:815` e `:886` chamam `fGravarGatilhoObtendoId`).

```
libGatIme.so nova no robo_novo_v2
        v
INSERT ... GAT_KEY_ID  ->  Unknown column 'GAT_KEY_ID' in 'field list'
        v
fGravarGatilhoObtendoId = False  ->  zero entrega
```

Medicao: **0 de 174 clientes ativos tem a coluna.** Nenhum. A coluna irma da mesma feature,
`WPPENV.WPP_KEY_ID`, esta em **174 de 174** — o canal de distribuicao funciona, o `GAT_KEY_ID` so nao
saiu ainda. Inferencia que confirma: a `.so` que roda hoje no v2 e anterior ao r495832, porque senao a
frota ja estaria parada.

Ja haviam batido nisso: o comentario em `GatilhosImediatos.Classes.pas:409` registra o mesmo erro em
18/09 na suite de teste, e a resposta foi propagar melhor o motivo (`AstrMotivo`) e por a guarda de
"True sem id" na fronteira — o que torna a falha audivel, mas nao tolerante.

**Conserto aplicado:** `blnTemKeyId := fCampoExiste('GATIME_WPPEMA', 'GAT_KEY_ID', True)` no ponto da
decisao, condicionando coluna, placeholder e `ParamByName`. A virgula mudou de lado: `GAT_CODEMP`
passou a ser o ultimo incondicional sem virgula. O `fCampoExiste` ja estava linkado nos dois ramos —
Linux por `Services.Core.Connection.Manager` (vem no `services.core.uses.inc`), Windows por
`untFuncoesSimples` — entao nenhuma dependencia nova. Simulei o SQL nas 6 combinacoes de
`KEY_ID x NUMWPP x EMAIL_` conferindo colunas contra valores; nao compilei.

*
* A guarda NAO cobre o relatorio de PIX: untRelacaoPedidosPixGerados.pas le GAT_KEY_ID em 96 pontos,
* em SELECT, JOIN e GROUP BY, e segue quebrado nos mesmos 174 clientes ate o ALTER sair. E requisito
* de outra pessoa, mas e o mesmo campo e a mesma frota.
*

### Mapa de causas, atualizado

| Causa | Clientes | Situacao |
|---|---|---|
| `templateId = 0` com `Exit` mudo na API oficial | CONSTRUART, MULTIVAREJO | causa nomeada, **conserto pendente** |
| `AUTH_018` / 401 no gateway | MARINLOG, GRUPO_REALEZA, ABRAFER | credencial — chamado para suporte |
| `502 Bad Gateway` | RWS_ELETRICA | gateway, cronico |
| Cliente novo na faixa antiga | FLUZAO | precisa da inversao fixacao x guardrail |
| Rota do tenant nao publicada | MONTANNA | **causa achada** — infra, chamado |
| `Estrutura de dados nao carregada` | UBERTINTAS, COFERSOL, MANTELLI, RIBPECAS, MARINLOG | **EM ABERTO** |
| Corrupcao de `servidor`/`gatilho` = `'n'` | 10 linhas, varios clientes | **EM ABERTO**, nao investigado |
| Fora da apuracao | 20 clientes | **EM ABERTO** — nao e falha de envio, e cegueira de medicao |

### Runbook de AV consolidado

`IA/know/depurar_av_linux.md` foi reescrito (215 -> 537 linhas) juntando o que estava espalhado entre
ele, a memoria local e a skill `delphi-av-analyze`, que e de escopo de usuario e a equipe nao tem. Duas
correcoes importantes ao que eu mesmo havia escrito antes na sessao:

- **valgrind e Passo 0**, nao um degrau tardio. Em 22/09 a pergunta "da para rodar valgrind no host?"
  nao foi feita, e ela valia a investigacao inteira.
- **32 bits deixa o defeito latente, nao ausente.** Eu havia atribuido a largura do ponteiro; o correto
  e que frames menores deixam aquela posicao de pilha zerada com mais frequencia — e qualquer mudanca
  em funcao chamada **antes** desloca o residuo e faz o AV aparecer longe da alteracao. E o que explica
  "funciona ha anos e quebrou agora sem ninguem mexer nessa rotina".

### O que fica aberto

- `Estrutura de dados nao carregada` — unica causa sem nome. Caminho horizontal ja descartado
  (`REL_HORIZO = 'N'` nos sete relatorios). Pista: `untGeraFR3.pas:6586` diz que no Linux o
  `PrepareQueryFinalSQL` inlina os params e esvazia `qryDados.Params`, deixando `FQueryFiltros` com
  nome e sem valor.
- Conserto do `Exit` mudo do `templateId` — causa nomeada em 15/09, codigo nao tocado.
- Inversao fixacao x guardrail em `fPastaRoboDoCliente` — proposta, nao implementada, falta entender
  por que o criterio e volume de entrega.
- Corrupcao do `'n'` e os 20 clientes fora da apuracao — nenhum dos dois investigado.
- `Url Dashboard em branco` e `Arquivo PDF nao existe` — motivos independentes, confirmado hoje, sem
  causa.
