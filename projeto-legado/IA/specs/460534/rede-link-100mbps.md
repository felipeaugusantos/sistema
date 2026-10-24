# Faturamento Automático — falhas de conexão com o banco

**Data da apuração:** 05/09/2026
**Ambiente:** srvServicos (192.168.0.249) → MySQL em srvPalacio001Local (192.168.0.1)

---

## Resumo

O robô de Faturamento Automático perde a conexão com o banco de dados em parte dos
documentos. Cada perda custa **~15 s de espera** mais o **refazimento completo** do documento.

Ao investigar, foi descartada uma lista de causas de banco, de sistema operacional e de
aplicação — todas com medição. O que sobrou como anomalia concreta é uma diferença de
velocidade de rede entre os dois servidores:

| Servidor | Função | Velocidade do link |
|---|---|---|
| srvPalacio001Local | Banco de dados MySQL | **1000 Mb/s** |
| srvServicos | Aplicação / robôs | **100 Mb/s** |

A placa do srvServicos **suporta e solicita** 1000 Mb/s. Quem não oferece gigabit é a porta
do switch em que ele está ligado.

**Pedido:** mover o srvServicos para uma porta de switch com gigabit.

---

## 1. O sintoma, medido

Duas ocorrências no log de 05/09/2026, no intervalo de dois minutos:

| Documento | Última operação com sucesso | Erro | Intervalo |
|---|---|---|---|
| 000004792622-PD | 08:18:13.807 | 08:18:29.255 | **15,4 s** |
| 000004781106-PD | 08:20:12.508 | 08:20:27.801 | **15,3 s** |

Mensagem: `Cannot connect to server on host '192.168.0.1': Connection timed out`.

O intervalo de ~15 s repetido é a assinatura de um pedido de conexão TCP que **não recebe
resposta**: o sistema operacional reenvia a solicitação em 1 s, 2 s, 4 s e 8 s, e a aplicação
desiste.

**Impacto:** o documento é refeito do zero. No documento 000004792622, o custo total foi de
~57 s, dos quais ~15 s de espera e ~11 s de trabalho descartado. Em regime de onda de
expedição isso se multiplica por documento afetado.

---

## 2. Causas descartadas — com a medição que descarta cada uma

Esta seção existe para deixar claro que a rede não foi escolhida por eliminação preguiçosa.

### 2.1 O MySQL não está recusando conexão

| Métrica | Valor | Conclusão |
|---|---|---|
| `Threads_connected` / `max_connections` | 574 / 2000 | 29% do limite |
| `Max_used_connections` | 1356 | pico histórico de 68% — nunca encostou no teto |
| `Connection_errors_max_connections` | **0** | nunca recusou por excesso de conexões |
| `Connection_errors_accept` | **0** | |
| `Connection_errors_internal` | **0** | |
| `Connection_errors_peer_address` | **0** | |
| `Connection_errors_select` | **0** | |
| `Connection_errors_tcpwrap` | **0** | |

Todos os contadores de recusa do MySQL estão zerados. **O banco não nega conexão a ninguém.**

### 2.2 A fila de conexões pendentes nunca transbordou

| Medida | Valor |
|---|---|
| `back_log` (MySQL) | 2000 |
| `net.core.somaxconn` (kernel) | 4096 |
| `Send-Q` da porta 3306 | 2000 — o kernel concedeu o solicitado |
| `Recv-Q` da porta 3306 | 0 — fila vazia |
| `times the listen queue of a socket overflowed` | ausente = **zero desde o boot** |
| `SYNs to LISTEN sockets dropped` | ausente = **zero desde o boot** |

Os dois últimos são contadores acumulados desde a inicialização do servidor. A ausência deles
vale também para os períodos de pico, não só para o momento da medição.

### 2.3 Não há esgotamento de portas no cliente

| Medida | Valor |
|---|---|
| Faixa de portas efêmeras | 32768–60999 = 28.232 disponíveis |
| Sockets em `TIME_WAIT` | 1.210 |
| Ocupação | **4,3%** |

### 2.4 Não há descarte por tabela de conexões (conntrack)

- srvServicos: módulo de conntrack **não carregado**
- srvPalacio001Local: 7.334 de 262.144 = **2,8%**
- `dmesg` sem qualquer registro de `table full` nos dois servidores

### 2.5 Não há erro físico de rede

`ethtool -S` nas duas pontas, todos zerados:

```
rx_fcs_errors: 0      rx_errors: 0       tx_errors: 0
rx_align_errors: 0    rx_discards: 0     tx_discards: 0
tx_carrier_sense_errors: 0
```

Não é cabo corrompendo sinal, não é conector oxidado, não é interferência.

### 2.6 Não há problema de rota ou de latência

`mtr` do srvServicos para 192.168.0.1, 200 pacotes:

```
HOST: srvServicos       Loss%   Snt   Last   Avg  Best  Wrst StDev
  1.        192.168.0.1   0.0%   200    0.2   0.5   0.2   7.1   0.8
```

Um único salto — os dois servidores estão no mesmo segmento de rede. Latência de 0,5 ms,
zero perda em tráfego leve.

### 2.7 Também foi descartado do lado da aplicação

A investigação começou no código. Foram verificados e afastados: parâmetros de conexão
desatualizados, laço de espera na geração de código sequencial, e bloqueio de registro no
banco. Uma otimização de reaproveitamento de conexão foi implementada e está em produção —
ela reduz o número de conexões abertas, mas **não elimina** as falhas.

---

## 3. O achado

### 3.1 A diferença de velocidade

```
srvPalacio001Local, interface eno8303:    Speed: 1000Mb/s   Duplex: Full
srvServicos,        interface eno1:       Speed:  100Mb/s   Duplex: Full
```

### 3.2 A limitação não está no servidor

A placa do srvServicos é capaz de gigabit e está pedindo gigabit:

```
Supported link modes:   10baseT/Half 10baseT/Full
                        100baseT/Half 100baseT/Full
                        1000baseT/Half 1000baseT/Full
Advertised link modes:  10baseT/Half 10baseT/Full
                        100baseT/Half 100baseT/Full
                        1000baseT/Half 1000baseT/Full
Auto-negotiation: on
```

E o equipamento do outro lado responde oferecendo **apenas 10 e 100**:

```
Link partner advertised link modes:  10baseT/Half 10baseT/Full
                                     100baseT/Half 100baseT/Full
```

Como a negociação automática ocorre nos pares 1-2 e 3-6 do cabo, um cabo com pares rompidos
ainda anunciaria `1000baseT` e só falharia depois. Não é o caso aqui: **a porta do switch não
oferece gigabit.**

### 3.3 Há retransmissão de rede acontecendo agora

Contadores medidos com 60 segundos de intervalo, em 05/09/2026 às 08:38:

| Servidor | Contador | Variação em 60 s |
|---|---|---|
| srvPalacio001Local | `fast retransmits` | **+588** |
| srvPalacio001Local | segmentos retransmitidos | +747 |
| srvServicos | `TCPSynRetrans` | +14 |
| srvServicos | segmentos retransmitidos | +329 |

`fast retransmit` ocorre quando o destinatário sinaliza que faltou um pacote. Cerca de **10
por segundo** num sábado pela manhã indica perda de pacotes em andamento.

### 3.4 O mecanismo

Quando um servidor a 1000 Mb/s envia dados para um a 100 Mb/s, o switch precisa enfileirar o
excesso. Um resultado de consulta de 1 MB sai do banco em ~8 ms, mas leva ~80 ms para ser
entregue ao destino mais lento. O switch precisa reter ~900 KB durante essa diferença.
O buffer típico de porta em switch de acesso fica entre 100 e 200 KB. **O excedente é
descartado.**

Se o pacote descartado for a resposta de abertura de conexão, o cliente não recebe nada,
reenvia, e após ~15 s desiste — exatamente o sintoma observado.

Isso também explica por que o MySQL não registra nada: o descarte ocorre na rede, antes de o
pedido chegar ao banco.

---

## 4. O que está provado e o que é inferência

Esta separação é deliberada.

**Fatos verificados:**

- o srvServicos opera a 100 Mb/s enquanto o servidor de banco opera a 1000 Mb/s;
- a placa do srvServicos suporta e solicita gigabit; a porta do switch oferece apenas 10/100;
- há retransmissão de pacotes ativa nos dois servidores;
- MySQL, fila de conexões, portas efêmeras, conntrack e camada física estão descartados,
  cada um com medição própria.

**Inferência, não comprovada:**

- que a diferença de velocidade seja **a causa** das falhas de conexão.

Duas ressalvas honestas contra a própria hipótese:

1. no momento da medição o link estava a ~8% de uso — não há saturação sustentada. A
   explicação depende de rajadas curtas, que a média de 10 segundos não captura;
2. `TCPSynRetrans` é um contador do servidor inteiro, não por destino. Parte dele pode ser
   tráfego de internet (SEFAZ, marketplaces), não do caminho até o banco.

---

## 5. O pedido

**Mover o srvServicos para uma porta de switch com suporte a 1000 Mb/s.**

A solicitação se justifica independentemente da comprovação de causalidade: um servidor de
aplicação a 100 Mb/s conversando com um servidor de banco a 1000 Mb/s é uma assimetria de
10 para 1 que não deveria existir num ambiente onde todo o tráfego do ERP passa por esse link.

O custo é de minutos e a mudança é reversível. É também o experimento mais barato disponível:
se as falhas cessarem, a causa está comprovada; se persistirem, a hipótese é eliminada e a
investigação segue com uma variável a menos.

Observações operacionais:

- a troca de porta interrompe a rede do servidor por alguns segundos — executar fora de
  janela de expedição;
- se não houver porta gigabit disponível nesse switch, o equipamento é 10/100 e a discussão
  passa a ser de capacidade de infraestrutura.

---

## 6. Como verificar se resolveu

**Confirmar a negociação:**

```bash
# no srvServicos
ethtool eno1 | grep -E 'Speed|Duplex'
```

Deve passar a exibir `Speed: 1000Mb/s`. Se permanecer em 100 numa porta comprovadamente
gigabit, aí sim o cabo entra na investigação.

**Medir o efeito, comparando janelas equivalentes de expedição:**

```bash
# no srvServicos
grep -c 'Cannot connect to server' /ServicosCitel/robo_faturamento_automatico/*.log
```

**Acompanhar a retransmissão:**

```bash
# nos dois servidores
netstat -s | grep -E 'TCPSynRetrans|fast retransmits'
```

Queda nesses contadores após a mudança é evidência direta de que o afunilamento era real.
