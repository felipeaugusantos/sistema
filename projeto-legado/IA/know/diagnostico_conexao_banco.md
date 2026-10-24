# "Cannot connect to server" — diagnosticar falha de conexão com o banco

Vale para qualquer serviço ou robô que fale com o MySQL. O sintoma típico é uma operação que
para por ~15 s e devolve `Cannot connect to server on host 'x.x.x.x': Connection timed out`,
em parte dos documentos e não em todos.

Continuação natural do caminho "espera" de [`profiling_servicos_linux`](profiling_servicos_linux/profiling_servicos_linux.md):
quando a triagem mostra que o processo está bloqueado e não queimando CPU, é aqui que se segue.

---

## A ordem importa

Vá **de dentro para fora**: aplicação, banco, sistema operacional, rede. Cada camada que você
descarta com medição estreita a próxima. Pular para "deve ser a rede" sem descartar as anteriores
é o que faz a infra do cliente devolver o problema — com razão.

| Passo | Camada | Pergunta |
|---|---|---|
| 1 | Aplicação | quantas conexões estamos abrindo, e por quê? |
| 2 | MySQL | ele está recusando? |
| 3 | Kernel do banco | a fila de conexões pendentes transborda? |
| 4 | Cliente | faltam portas? o conntrack está cheio? |
| 5 | Camada física | há erro de placa? qual a velocidade de cada ponta? |
| 6 | Caminho | há perda entre os dois? |

---

## 1. Aplicação — o volume é nosso?

Antes de acusar a infra, saber quanto tráfego de conexão nós geramos.

```sql
-- duas leituras, ~60 s de intervalo. A diferença dividida pelo intervalo é a taxa.
SELECT NOW(), VARIABLE_VALUE FROM performance_schema.global_status
 WHERE VARIABLE_NAME = 'Connections';
```

E do lado do cliente, quantas conexões estão fechando:

```bash
ss -tan state time-wait | wc -l
```

`TIME_WAIT` dura 60 s, então esse número dividido por 60 é a taxa de fechamento por segundo
daquele host.

> **Caso real:** ~20 conexões/s saindo de um único host, 20,9 milhões no contador acumulado. A
> causa era `fRetAutoIncremFireDac` abrindo conexão FireDAC nova a cada autoincrem. O ramo UniDAC
> não tinha o problema porque `TCriarConexao` configura `PoolingOptions`; o `TFireDacConnection`
> não liga pooling em nenhuma das duas implementações.

---

## 2. MySQL — ele está recusando?

```sql
SHOW GLOBAL VARIABLES LIKE 'max_connections';
SHOW GLOBAL STATUS    LIKE 'Threads_connected';
SHOW GLOBAL STATUS    LIKE 'Max_used_connections';
SHOW GLOBAL STATUS    LIKE 'Connection_errors_%';
SHOW GLOBAL STATUS    LIKE 'Aborted_connects';
```

| Leitura | Conclusão |
|---|---|
| `Connection_errors_max_connections` > 0 | recusa por teto — o erro seria "Too many connections", não timeout |
| qualquer `Connection_errors_*` > 0 e subindo | o MySQL viu e recusou; siga por aí |
| **todos em zero** | **o MySQL não recusou nada** — a conexão morre antes de chegar nele |

> **Armadilha:** contador zerado aqui não significa "está tudo bem". Significa que o MySQL não
> tomou conhecimento. Pacote descartado pelo kernel ou perdido na rede nunca aparece nesses
> contadores.

---

## 3. Kernel do servidor de banco — a fila de listen

O `back_log` do MySQL é um **pedido** ao kernel, limitado por `net.core.somaxconn`. Configurar
2000 no MySQL e ter 128 no kernel dá 128.

### ▶ No servidor de **banco**

```bash
cat /proc/sys/net/core/somaxconn
ss -ltn 'sport = :3306'
netstat -s | grep -Ei 'listen|overflow|SYN|backlog'
```

- em `ss -ltn`, o `Send-Q` da porta 3306 é o **limite efetivo** da fila; o `Recv-Q` é o uso atual
- em `netstat -s`, procure `times the listen queue of a socket overflowed` e
  `SYNs to LISTEN sockets dropped`

> **Leitura importante:** o `netstat -s` só imprime contador diferente de zero. **Ausência da
> linha significa zero desde o boot** — e isso vale também para os picos, não só para o momento
> da medição. É uma das poucas refutações que cobre o passado.

---

## 4. Cliente — portas efêmeras e conntrack

### ▶ No servidor de **aplicação**

```bash
cat /proc/sys/net/ipv4/ip_local_port_range
ss -tan state time-wait | wc -l
ss -s

cat /proc/sys/net/netfilter/nf_conntrack_max
cat /proc/sys/net/netfilter/nf_conntrack_count
dmesg -T | grep -i conntrack | tail -20
```

`nf_conntrack: table full, dropping packet` no `dmesg` fecha o caso na hora. Arquivo inexistente
em `/proc/sys/net/netfilter/` significa módulo não carregado — conntrack está fora do jogo.

---

## 5. Camada física e velocidade do link — **o passo mais esquecido**

Descubra a interface certa em cada ponta antes de olhar contador de placa errada:

### ▶ No servidor de **aplicação**

```bash
IFACE=$(ip route get <IP-DO-BANCO> | grep -oP 'dev \K\S+')
ethtool "$IFACE" | grep -E 'Speed|Duplex|Link detected'
ethtool "$IFACE" | grep -A8 'Supported link modes'
ethtool "$IFACE" | grep -A8 'Link partner advertised'
ethtool -S "$IFACE" | grep -Ei 'err|drop|discard|crc|carrier'
ip -s link show "$IFACE"
```

### ▶ No servidor de **banco**

```bash
# NAO use o IP do proprio banco aqui - devolve 'lo' e a medicao nao diz nada.
IFACE=$(ip route get <IP-DA-APLICACAO> | grep -oP 'dev \K\S+')
ethtool "$IFACE" | grep -E 'Speed|Duplex|Link detected'
```

| Achado | Conclusão |
|---|---|
| `crc`/`carrier errors` subindo | camada física: cabo, conector, porta |
| `Duplex: Half` em link gigabit | negociação errada |
| **velocidades diferentes entre as pontas** | **afunilamento no switch** — ver abaixo |
| a placa anuncia 1000baseT e o parceiro só 10/100 | a porta do switch é o limite |
| a placa e o parceiro anunciam 1000 mas o link ficou em 100 | o cabo é o limite (gigabit exige os 4 pares) |

> **Speed mismatch é a causa silenciosa.** Um servidor a 1000 Mb/s enviando para um a 100 Mb/s
> obriga o switch a enfileirar. Um resultado de 1 MB sai da origem em ~8 ms e leva ~80 ms para
> ser entregue: o switch precisa reter ~900 KB, e buffer de porta de switch de acesso costuma
> ter 100 a 200 KB. O excedente é descartado — e se o descartado for o SYN-ACK, o cliente espera
> e estoura no timeout.

---

## 6. Caminho — há perda?

### ▶ No servidor de **aplicação**

```bash
mtr -rwzbc 200 -i 0.2 <IP-DO-BANCO>

# retransmissao: duas leituras com 60 s de intervalo, nas DUAS pontas
date; netstat -s | grep -E 'TCPSynRetrans|segments retransmitted|fast retransmits'
```

| Contador | Onde interpretar |
|---|---|
| `TCPSynRetrans` | **no cliente** — SYN que ele mandou e não teve resposta |
| `fast retransmits` | **em quem envia dados** — perda no meio do fluxo |

> **`mtr` limpo não inocenta.** Ele manda ~1 pacote ICMP pequeno por segundo; perda por
> congestionamento acontece em rajada de milissegundos. Um filete de ICMP passa entre as rajadas.
> O que ele descarta é perda **constante** e problema de **roteamento** — não congestionamento.

> **`TCPSynRetrans` é do host inteiro, não por destino.** Um servidor que fala com SEFAZ e
> marketplaces tem retransmissão de internet misturada ali. Para atribuir ao banco:
> ```bash
> timeout 180 tcpdump -ni <IFACE> -ttt 'host <IP-DO-BANCO> and tcp[tcpflags] & (tcp-syn|tcp-ack) == tcp-syn'
> ```
> SYN repetido para o mesmo destino em ~1 s, 2 s, 4 s é retransmissão.

---

## 7. Antes de levar para a infra do cliente

O relatório precisa **separar fato medido de inferência**, e listar o que foi descartado com o
comando que descartou. Time de infra resiste — com razão — a "é a rede" sem prova, e a
credibilidade se perde no primeiro contra-argumento que você não tiver antecipado.

Inclua também os argumentos **contra** a própria hipótese. Exemplo real: o link estava a 8% de
uso médio no momento da medição, o que não sustenta saturação sustentada — a explicação dependia
de microrrajada. Dizer isso primeiro é mais forte do que ser confrontado com isso depois.

Modelo pronto: `IA/specs/460534/rede-link-100mbps.md`.

E quando o conserto for barato e reversível — trocar o servidor de porta de switch, por exemplo
—, ele costuma ser o experimento mais barato disponível: se o sintoma some, provou; se persiste,
elimina a variável.

---

## 8. Armadilhas, todas pagas com tempo

- **Ausência de dado não é evidência.** Contador zerado pode ser "não houve" ou "não foi visto".
- **Refutação aplicada ao problema errado.** "Placa de rede" foi descartada com o argumento de
  que a thread estava em CPU e não bloqueada em I/O — verdadeiro para o problema de CPU, e sem
  nenhuma relação com o de conexão. A hipótese ficou marcada como morta por um ano de sessão
  sem nunca ter sido testada contra o problema certo.
- **Média não vê rajada.** 10 segundos de média a 8% de uso convivem com fila cheia por 8 ms.
- **Medir fora do pico.** Se der tudo limpo, a conclusão é "não é isso *fora de onda*" — o que é
  diferente de "não é isso".
- **`ip route get` do próprio IP devolve `lo`.** No servidor de banco, use o IP da aplicação.

---

## Origem

Extraído da investigação do Req. 460534 (Faturamento Automático, 04-05/09/2026). O registro
completo, com as 13 hipóteses refutadas e o que refutou cada uma, está em
`IA/specs/460534/record.md`.
