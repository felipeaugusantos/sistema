# Req. 460229 — visibilidade e destravamento dos gatilhos de informação em modo fila

Contrato desta entrega. A investigação que a originou está em `record.md`, e os dois chamados
irmãos em `IA\specs\459428\` (MARCIUS) e `IA\specs\459481\` (BELATINTAS).

## Problema

Desde 25/08/2026 (r491154) 162 clientes passaram do envio síncrono para o modo fila sem que
ninguém decidisse migrá-los. No modo fila o gatilho **não envia**: enfileira na `GATIME_WPPEMA`,
e um consumidor entrega depois. A `GATINF` é carimbada no enfileiramento e **nada volta da fila
para ela** — `ExecutarEnvio` devolve sucesso sem olhar se o INSERT aconteceu.

Resultado: qualquer falha vira `"Gatilho enviado com sucesso!"`. Três clientes reclamaram com
sintomas diferentes; os outros 159 estão no mesmo escuro e a Citel não tem como saber quais.

## Escopo

Esta entrega **não corrige o carimbo na origem**. Ela torna o estado real visível e destrava o
caso em que a mensagem existe na fila mas ninguém a drena.

| Chamado | Esta entrega |
|---|---|
| 460229 MINAS BOMBAS — fila não drenada | **resolve** |
| 459428 MARCIUS — share UNC inacessível | reporta; conserto é do share |
| 459481 BELATINTAS — cadastro sem destino | reporta; conserto é do cadastro |
| Carimbo falso, nos 162 | reporta; correção fica para o update do robô |

## Topologia — o que é implantado onde

Quatro artefatos, com custos de implantação muito diferentes. É o eixo de todo o desenho.

| Artefato | Units / de `fontes/` | Build no ar | Custo de atualizar |
|---|---|---|---|
| `GatilhosInformacaoMonitor` | 4 / **0** | 25/08 (atual) | **baixo** — rotina |
| `libGatIme.so` | 845 / 808 | 02/06 | médio |
| `GatilhosInformacao_LibGatIme` | 832 / 791 | 02/06 | **alto** |
| `GatilhosInformacao` (síncrono) | — | 05/04 | não recompilável |

O monitor não linka `fontes/`: por isso tem 9 MB contra 346 MB e por isso foi atualizado em 25/08
sem incidente. Entre o build de 02/06 e a HEAD há **1607 revisões**, 1482 delas tocando `fontes/`.

**`GatilhosInformacao` não pode ser recompilado.** O fonte de hoje só sabe enfileirar — não existe
`IFDEF` nem parâmetro que escolha o envio síncrono. O binário de 05/04 que ainda atende 69
clientes é irreprodutível a partir da HEAD.

## Escopo de implantação: só o monitor

A entrega inteira cabe no `GatilhosInformacaoMonitor`. **Nada é implantado no robô nem na `.so`.**

### Atualizar a `libGatIme.so` foi considerado e descartado

A ideia era trazer `fValidaDisparo` (r481567, 30/06), que recusa disparo com mais de 24 h, para que
a drenagem provocada não enviasse mensagem velha. A verificação de compatibilidade reprovou o
caminho e, ao mesmo tempo, mostrou que ele não era necessário.

**Reprovou:** a interface `IGatIme` mudou entre a revisão implantada e a HEAD —
`fMonitorar` ganhou o parâmetro `AstrFluxo: String`. O executável de 02/06 tem o wrapper compilado
dentro dele chamando `fMonitorar` **sem argumento**, e `TDllGatime.fMonitorarGatilhosImediatos`
(`untDllGatIme.pas:143`) é justamente o caminho da drenagem. Trocar só a lib põe lixo no lugar do
parâmetro e mata o processo filho. A lista de exports e o record de parâmetros não mudaram — a
quebra está na vtable, onde o nome do export não denuncia.

*O nome do lock também mudou (`MONITOR_GATILHOS_IMEDIATOS_OPERACIONAL_%s`), mas para esse caso já
existe o bloco de compatibilidade `IdMonitorGatilhosImediatos_OLD`. Para a assinatura, não há
equivalente.*

**Não era necessário:** a trava contra mensagem velha vive melhor no monitor — o corte de 20 h
antes de provocar a subida do robô. Ela protege exatamente o que esta entrega causa. A guarda da
`.so` protegeria também as drenagens naturais, que hoje já acontecem sem proteção nenhuma e que
esta entrega não piora — ao contrário: destravando cedo, a linha nunca envelhece.

*Atualizar `.so` e robô juntos resolveria a assinatura, ao custo das 1482 revisões, sem entregar
nada que o corte de 20 h não entregue.*

### O que o monitor passa a fazer

Três responsabilidades novas, todas dentro do binário barato.

**2.1 — Escopo: quem é verificado.** Só faz sentido reconciliar cliente cuja versão **enfileira**.
Num cliente no `robo_velho` o envio é direto: não existe linha na `GATIME_WPPEMA`, e compará-lo
produziria `ID30` falso todo dia.

A pasta escolhida para o disparo é a mesma consultada para decidir se reconcilia — uma consulta,
dois consumidores. Quais pastas enfileiram vem do parâmetro `--pastas_sincronas`, com
`robo_velho` como padrão; é conjunto fechado, já que o binário síncrono não é recompilável.

*Critério separado para verificar e para executar seria um segundo lugar onde a mesma regra é
escrita, e as duas divergiriam na primeira alteração: o monitor reconciliaria um conjunto e
executaria outro, sem erro apontando para isso. É a mesma família de defeito que este requisito
conserta.*

*Escopo errado também produziria 69 falsos positivos no primeiro dia: nos clientes síncronos é
correto não haver linha na fila. Alarme que nasce errado não é lido depois.*

**2.2 — Reconciliação: o que é comparado.** Duas camadas.

*Camada agregada (o alarme).* Quantos gatilhos a `GATINF` carimbou na janela contra quantas linhas
de gatilho de informação a fila recebeu. Divergência = alguém sumiu. Não depende de correlação
linha a linha, então não é enganada por nome repetido nem por descrição editada. Teria acendido no
MARCIUS em 31/08 e no BELATINTAS desde sempre.

*Camada linha a linha (o detalhe).* Por gatilho: enfileirado quando, entregue quando. Chave de
correlação `(GAT_CODEMP, GAT_ASSUNT, destino, janela)`. Onde não fechar, o painel diz
**"não identificado"** — nunca infere.

#### Integração com a camada de monitoramento que já existe

Descoberto durante a implementação: a base central tem um catálogo de padrões de mensagem
(`gatilhos_informacao_tipo_erro`), silenciamento por par servidor+erro
(`gatilhos_informacao_blacklist`), controle de tickets do Zendesk
(`gatilhos_informacao_ticket_controle`) e a view `vw_monitoramento_gatilhos_informacao`. Algo — ao
que tudo indica um n8n, sem dono identificado — classificava `ultima_mensagem` por `LIKE` contra o
catálogo e **abria ticket sozinho**, quase todo dia até 21/08/2026. Está parado desde então.

`ID07 = "Gatilho enviado com sucesso!"` já estava no catálogo: alguém antes de nós esbarrou nessa
mensagem e precisou lhe dar uma gaveta. Hoje **86% das 2151 linhas** caem nela.

A reconciliação **não depende** dessa camada — tabela e alarme próprios funcionam sozinhos. Mas
escreve em formato que ela classifica, para voltar a funcionar sem retrabalho se alguém a religar:

| id_erro | descricao | Quando |
|---|---|---|
| `ID29` | `Pendente de envio na GATIME_WPPEMA` | há linha na fila, sem marca de entrega |
| `ID30` | `Nao gerou registro na GATIME_WPPEMA` | carimbado como enviado, sem linha nenhuma |

Separados porque pedem ações diferentes: ID29 costuma ser atraso e o destravamento resolve; ID30 só
sai com conserto de infraestrutura ou cadastro. Separados também para a blacklist ser útil — o
BELATINTAS ficará em ID30 por semanas, e dá para silenciar esse caso sem perder o alarme se ele
também passar a acumular fila.

**Havendo divergência, a mensagem do cliente é substituída, não concatenada.** Concatenar deixaria
o texto casando com ID07 e com ID29/ID30 ao mesmo tempo — a linha apareceria na gaveta de sucesso e
na de erro. Substituir assume que a reconciliação vale mais que a autodeclaração do cliente, que é
o que este requisito prova.

**2.3 — Ação: destravar.** Havendo linha nossa pendente e nenhum processo rodando para o cliente,
subir o robô. Sem gatilho vencido, o `pExecuteAll` vai direto ao passo final
(`pProcessarGatilhosImediatos`, r475101 — presente no binário de 02/06) e drena. É o mesmo efeito
que hoje acontece por acaso às 07:30.

**Corte em 20 h.** Linha mais velha que isso não provoca subida. Como o binário no ar não tem
`fValidaDisparo`, uma drenagem provocada num cliente com fila acumulada dispararia mensagem de
semanas atrás ao cliente final. A trava é do lado de quem provoca, já que quem executa não a tem.

## Identificação do gatilho de informação dentro da `GATIME_WPPEMA`

Não existe coluna que distinga, **e não é descuido**: os dois tipos são inseridos pela mesma
`fGravarGatilhoImediato`, com a mesma lista de colunas.

O discriminador é o próprio texto do assunto, que é o `GAT_DESCRI` da GATINF gravado literal:

```sql
FROM GATIME_WPPEMA w
WHERE w.GAT_DTAOCO >= <janela>
  AND EXISTS (SELECT 1 FROM GATINF g WHERE g.GAT_DESCRI = w.GAT_ASSUNT)
```

Verificado no BELATINTAS: separa 13 linhas de ~2.500 transacionais, sem falso positivo. `EXPLAIN`
confirma `range` em `IDX_GATIME_WPPEMA_01` pela data e `ref` em `IDX_GATINF_05` com `Using index`.

**`EXISTS`, não `JOIN`:** o BELATINTAS tem 389 gatilhos com a mesma descrição, e o `JOIN` multiplica
cada linha da fila por todos os homônimos (`rows=125` no `EXPLAIN`), distorcendo a contagem. O
semi-join para no primeiro acerto.

**`WHERE`, não `HAVING`:** `HAVING` roda após a agregação, não usa índice e obriga a materializar
tudo antes de descartar.

Falhas conhecidas do discriminador, a tratar como "não identificado": descrição editada após o
enfileiramento; título repetido sem destino que desempate; gatilho imediato batizado igual a um de
informação.

*Quando o robô for atualizado, isso deixa de ser heurística por uma linha: gravar `codigoGatilho`
no `GAT_INFJSN`, que já existe e já é preenchido nos dois tipos, dá a chave real.*

## Regras de estado

**Estado é derivado, nunca lembrado.** A pendência é recalculada do banco a cada ciclo — GATINF
carimbou, fila não tem marca de entrega. Queda do monitor custa um ciclo, não um caso.

*O monitor hoje faz o contrário e é onde o MINAS BOMBAS se perdeu em 02/09: falhou a conexão, o
`pRemoverItemFila(0)` tirou o item da fila do mesmo jeito e o `pLimparFilaIni` apagou o resto.
Memória de processo mente quando o processo morre.*

Decorre disso que a verificação precisa ser barata o bastante para rodar todo ciclo. Se virar
"roda uma vez por dia porque é cara", voltou a ser memória.

**A janela de data não pode ser precipício.** Deve ser maior que qualquer atraso plausível, e o que
cair fora dela aparece como **"fora da janela"** — nunca como resolvido.

**Divergência permanente precisa de estado próprio.** Os 389 do BELATINTAS não vão enfileirar sem
conserto de cadastro e seriam acusados em todo ciclo, para sempre. Separar "nova" de "já conhecida"
no painel. Não silenciar — alarme que grita todo dia deixa de ser lido.

## O papel da whitelist — dois papéis num arquivo só

`libgatime_clients.txt` tem 3 clientes (PRODESIVO, NACIONAL_MOTO_PECAS, FLUZAO). Desde a r491154 ele
é override do modo, e a detecção automática é o portão.

O arquivo acumulou dois significados incompatíveis:

- **piloto** — "quero validar uma versão nova neste cliente por alguns dias"
- **portão de modo** — "estes clientes usam fila"

Os 3 nomes chegaram lá como piloto. A r491154 os manteve como override de modo e promoveu a
detecção automática a portão — e foi assim que 162 clientes migraram sem decisão.

Como override de modo, o arquivo é quase inerte e o pouco que faz é nocivo: para cliente com marca
de entrega recente, ele e a detecção concordam; o único caso em que altera o resultado é o cliente
**sem** marca — exatamente aquele que pode não ter as tabelas da `GATIME_WPPEMA` no schema, onde o
INSERT falha e a mensagem se perde com carimbo de sucesso. **Ele só age quando está errado.**

**O arquivo também não consegue ser lista de piloto.** Ele não escolhe versão: escolhe entre dois
nomes compilados no código, `GatilhosInformacao_LibGatIme` e `GatilhosInformacao`. Pilotar uma
versão nova exigiria apontar um cliente para um terceiro binário, e não há como dizer isso ali.

### Decisão — versionar o robô por pasta

O arquivo, a whitelist e a própria ideia de "modo" saem. `FILA` e `SINCRONO` nunca foram modos:
são **qual build roda**. Generalizando, o problema muda de forma.

```
/ServicosCitel/GatilhosInformacaoEnviar/
├── GatilhosInformacaoMonitor
├── robo_velho/        GatilhosInformacao   — envio sincrono, build 05/04
├── robo_libgatime/    GatilhosInformacao   — enfileira, build 02/06
│                      libGatIme.so         — do MESMO build
└── robo_<nova>/       exe + .so casados
```

O binário chama-se `GatilhosInformacao` em todas; o que distingue é a pasta.

**Isso resolve o defeito de ABI que este requisito encontrou.** O robô carrega a `libGatIme.so` por
caminho relativo. Versionando a pasta inteira, exe e `.so` nunca se misturam — a incompatibilidade
da `IGatIme` que mataria o processo filho deixa de ser possível por construção, e não por alguém
lembrar.

**A tabela `gatilhos_informacao_robo` é de exceção, não de conjunto.** Cliente sem linha roda a
versão default, que vem do parâmetro `--pasta_default` do monitor. Isso mantém o princípio de que
**quem pode usar a versão corrente, usa** — e reserva a tabela para as três coisas que hoje não
existem:

| Uso | Como |
|---|---|
| **Piloto** | fixa 3 clientes na pasta nova, observa a divergência por dias, incrementa |
| **Reversão** | devolve cliente quebrado para a pasta anterior, editando uma linha |
| **Auditoria** | quem está fora do default, desde quando e por quê |

A reversão é o que falta hoje: **não há como devolver um cliente ao envio síncrono.** O MARCIUS
voltaria a funcionar imediatamente no `robo_velho`, porque o síncrono não passa pelo
`fRetBase64ParaArquivo`, que é onde ele morre.

**Não há carga inicial.** A tabela nasce vazia; todos rodam o default. Nenhuma varredura de 237
clientes, nenhuma migração em massa em qualquer direção.

**O default é explícito e versionado**, no parâmetro — nunca "o que estiver em tal lugar". Default
implícito é o defeito de origem deste requisito.

*A migração automática não era o risco — migrar às cegas era. Com a reconciliação no ar, quem ganha
capacidade pode usar a versão corrente sem que isso seja um salto no escuro.*

## Critérios de aceitação

1. Cliente em modo síncrono não gera nenhuma linha de divergência.
2. Gatilho carimbado na GATINF sem linha correspondente na fila aparece como divergência no mesmo
   dia. *Reproduzível hoje no BELATINTAS e no MARCIUS.*
3. Gatilho enfileirado e entregue não gera divergência. *Reproduzível no MINAS BOMBAS e nos 3 do
   C22 no BELATINTAS.*
4. Linha nossa parada na fila, sem processo rodando para o cliente, provoca uma subida do robô — e
   uma só, não uma por ciclo enquanto ela existir.
5. Linha pendente com mais de 20 h **não** provoca subida do robô. *É a única proteção contra
   disparo de mensagem velha: o binário no ar não tem a guarda de 24 h.*
6. Pendência anterior à janela aparece como "fora da janela", nunca ausente.
7. Divergência que persiste entre ciclos é distinguível de divergência nova.
8. Reinício do monitor no meio do ciclo não perde nenhuma divergência: o ciclo seguinte reencontra
   as mesmas.
9. Correlação linha a linha que não fecha aparece como "não identificado", e a divergência agregada
   continua sendo contada.
10. Com a `gatilhos_informacao_robo` vazia, todo cliente roda a pasta de `--pasta_default` — e o log
    registra `(default)` em cada disparo.
11. Fixar um cliente numa pasta faz o ciclo seguinte disparar dali, e o log registra `(FIXADO)`.
    *É o piloto e é a reversão; nenhuma outra intervenção.*
12. Pasta inexistente ou base central inacessível caem no default, com log — nunca deixam de
    disparar.
13. Ausência do `libgatime_clients.txt` não altera comportamento nenhum.
14. Divergência com linha na fila grava mensagem que casa com `ID29`; sem linha na fila, com
    `ID30`. *Conferível com o `LIKE` do catálogo — os dois padrões tinham zero ocorrência nas 2151
    linhas existentes antes desta entrega.*
15. Linha com divergência **não** casa mais com `ID07`: a mensagem é substituída, não concatenada.

## Fora de escopo

- **Carimbo na origem.** `ExecutarEnvio` continua devolvendo sucesso sem verificar o
  enfileiramento, e `ExecutarRelatorioParaEmail` continua abrindo com `Result := True`. Correção
  exige atualizar o robô — 1482 revisões — e fica para esse update, planejada.
- **`GatilhosInformacao` síncrono.** Não recompilável a partir da HEAD; qualquer mudança nele é
  outro requisito.
- **Share UNC do MARCIUS e cadastro do BELATINTAS.** Consertos de infraestrutura e de dado.

## Risco registrado

O binário no ar é de **~r476904** (02/06/2026) e a HEAD é r493393. A frase
`"Gatilho enviado com sucesso!"` está no binário e em nenhum fonte do ramo — prova de que o que
executa não é o que se lê. Todo trecho deste spec que descreve comportamento do robô ou da `.so`
foi conferido contra o binário ou contra dado de produção, não contra o fonte apenas.
