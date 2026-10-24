# Req. 462621 — registro da sessão

**17/09/2026** — relato do Wagner Neves, API de Suprimentos.

## Item 1 — download da exportação falha com "Illegal mix of collations"

`GET /api/cotacao/exportacao/{id}/{fornecedor}` (Req. 455094) devolvia 400 em toda chamada.
Causa em `Suprimento.Services.Cotacao.Consulta.pas`, `fNumeroCotacaoDaTarefa`: o `INNER JOIN`
comparava `COTGER.AUTOINCREM` (`latin1_swedish_ci`) com `SST_PARAMS ->> '$.sequencialCotacao'`,
que o MySQL devolve em `utf8mb4_bin`.

Corrigido com `CONVERT(... USING latin1)` do lado do JSON. **Sem `COLLATE` explícito de
propósito** — explícito, ele passa a ser o lado forte e converte a *coluna*, amarrando a consulta
ao charset que a COTGER tem hoje. O motivo está no comentário da implementação.

Validação: a consulta montada foi executada nos três servidores disponíveis (5.7.35 `prg`,
5.7.44 dev do Wagner, 8.0.36 base da suíte) — passa nos três. No banco do Wagner, a tarefa de
download 39740, que havia falhado, referencia a geração 39736, e esta resolve para
`COT_NUMCOT = 000089` com o fix. As cinco linhas de `fDadosDownload` na SSATSK estavam todas com
`SST_SUCESS = 'N'` e `SST_TYPERR = 'EUniError'` guardando a mensagem — 100% de falha, como
relatado.

## Por que o caso de teste 51 não pegou — e o achado maior

A hipótese do relato era que o banco da suíte teria a COTGER em outro charset. **Não é isso**:
`COTGER.AUTOINCREM` é `latin1_swedish_ci` nas três bases. O que difere é a **versão do servidor**.

| Base | Host/porta | Versão | O JOIN original |
|------|------------|--------|-----------------|
| `2_30_BELAT_TC` (suíte de teste) | 10.0.0.35:53307 | **8.0.36** | passa |
| `AUTCOM` (dev do Wagner) | 64.181.184.234:62002 | 5.7.44 | **falha** |
| `AUTCOM_379_48_02_30` (`prg`) | 10.0.0.35:47306 | 5.7.35 | passa (sem dados que casem) |

O 8.0 tolera a comparação; o 5.7 recusa. O caso 51 está escrito certo — o ambiente é que não
exercita a regra.

**Consequência que ultrapassa este requisito e não tem dono:** a suíte automatizada inteira valida
contra MySQL 8.0 enquanto o alvo declarado do projeto é 5.7. Qualquer defeito exclusivo do 5.7 é
invisível para ela.

## Item 2 — `fListar` gravando na SSATSK (adiado)

Pedido: parar de gravar linha na SSATSK a cada `GET /cotacao/giro`, por ser consulta síncrona.

Duas objeções levantadas, com medição no banco do Wagner (38.244 linhas, 31 MB):

| Serviço | Método | Linhas | Período |
|---|---|---:|---|
| TCotacaoConsultaService | `fConsultarAndamento` | 37.721 | 10/09 a 16/09 |
| TPedidoCompraService | `fCalcularImpostos` | 1.615 | desde 26/01 |
| TCotacaoConsultaService | `fListar` | 156 | 10/09 a 17/09 |
| TCotacaoGiroService | `fGerar` | 110 | desde 27/08 |

1. **O alvo está errado por duas ordens de grandeza.** `fListar` responde por 0,4% das linhas.
   Quem enche a tabela é o *polling* do andamento — ~6.300 linhas/dia.
2. **A linha não é log removível.** É o canal de IPC: o `fExecuteTask`
   (`Services.Core.Worker.pas`) insere a linha, despacha o processo filho e lê a resposta de
   `SST_RESULT`. Sem ela não há como mandar `PARAMS` nem receber `RESULT`. Vale para todo método
   síncrono da API, Faturamento incluído.

A raiz é a falta de expurgo da SSATSK — já anotada no próprio código como motivo do teto de 200
linhas do `fListar`. Isso é outro requisito e resolve os 99%.

**Estado do pedido original:** não implementado, e não deve ser — ver acima.

### O que foi feito no lugar: cache de 5 s nas consultas de andamento

Decidido com o João em 17/09/2026, depois de medir a frequência do *polling*: uma chamada a cada
~2 s por processamento observado, enquanto a resposta só muda a cada ~5,5 s. Três em cada quatro
chamadas (77,5%) devolviam byte a byte o que a anterior já havia devolvido.

Simulação sobre os dados reais, aplicando a janela por processamento:

| TTL | Chamadas que chegariam ao worker | Absorvido |
|---|---:|---:|
| 5 s | 12.939 (de 37.721) | 65,7% |
| 10 s | 7.289 | 80,7% |
| 30 s | 3.108 | 91,8% |

Escolhido 5 s: é o piso que a natureza do dado justifica, e acima disso a barra de progresso
andaria aos saltos.

Alternativas descartadas, e por quê:

- **Mudar o intervalo no ReporMais+** — depende de outra equipe e não resolve as rajadas de até 8
  chamadas no mesmo segundo, porque cada aba tem o próprio relógio. O cache é servidor e colapsa
  todas.
- **Arquivo em disco com o progresso** — terceira cópia de um estado que já mora na linha da
  SSATSK, com limpeza e regra de validade próprias. Cache em memória é mais simples justamente
  porque pode ser perdido.
- **Serviço assíncrono / refresher em background** — não há nada a pré-calcular: a consulta já é um
  `SELECT` de uma linha por chave primária, mantida pelo próprio worker da geração. O custo é
  despacho, não consulta. E um refresher rodando como worker não alcançaria a memória do processo
  da API.
- **Long polling / SSE** — é a solução que acaba com o *polling* em vez de reduzi-lo, e o DMVC já
  traz `MVCFramework.SSEController`. Mas segura thread por observador e exige mudança no cliente.
  Projeto à parte.

Implementação, em três arquivos:

- `api.core.cache.pas` — `TApiCacheBase` ganhou TTL por instância em **segundos**
  (`Create(AName, ATtlSeconds)`, 0 = expiração global). Era o obstáculo real: o TTL global é em
  minutos, com piso de 1, e não conseguia expressar 5 s. Expiração isolada em `Expirou`.
- `Suprimento.Services.Cotacao.Types.pas` — `COTACAO_ANDAMENTO_CACHE_SEGUNDOS = 5`.
- `Suprimento.Services.Workers.pas` — `TConsultaAndamentoCache`, na frente do `fExecuteTask` dos
  dois `fConsultarAndamento` (giro e exportação). Chave por serviço + método + JSON de parâmetros;
  serviço e método entram porque giro e exportação dividem a sequência de ids da SSATSK.

Só o retorno é cacheado — exceção do `fExecuteTask` sobe sem ser gravada.

**Não compilado, não testado, não commitado.**

## Fechamento

Revisado e **baixado em 17/09/2026**, commit único para os quatro arquivos — correção e melhoria
foram tratadas como o mesmo requisito por decisão do João. Compilação e commit ocorreram fora desta
sessão; não os verifiquei.

## O que fica aberto, e não é deste requisito

- **A suíte automatizada roda em MySQL 8.0 e os clientes em 5.7.** Foi o que fez o caso 51 passar
  sobre um endpoint quebrado. Qualquer defeito exclusivo do 5.7 continua invisível para ela. Não
  tem dono; é decisão de infraestrutura, não caso de teste a escrever.
- **Expurgo da SSATSK.** O cache reduz o crescimento a um terço, não o elimina. O critério
  recomendado ao DBA é por **natureza**, e não por idade — foi o expurgo por idade que, em
  incidente anterior, apagou o dado de que uma investigação precisou. Medição que sustenta o
  recorte, no banco de desenvolvimento em 17/09/2026:

  | | Linhas | Texto | Falhas |
  |---|---:|---:|---:|
  | Consulta (`fConsultarAndamento`, `fListar`) — envelope de transporte | 37.938 | 14,1 MB | 21 |
  | Trabalho real (`fGerar`, `fCalcularImpostos`, `fDadosDownload`, `fBaixarPDF`, `fValidarSolicitacao`) | 1.863 | 1,8 MB | 32 |

  O que tem valor forense são 1.863 linhas e 1,8 MB — a tabela inteira desde janeiro. Sugestão:
  expurgar consulta com retenção curta (1 a 2 dias), reter trabalho por muito mais tempo, e
  **nunca apagar linha com `SST_SUCESS <> 'S'`** (53 no total). A investigação do bug de collation
  deste requisito se apoiou em cinco dessas linhas de falha.
- **TTL do cache de cálculo de impostos.** O `POST /pedido-compra/calcular-impostos` usa o
  `THttpResponseCache` com a expiração global de 30 minutos. Pode ser intencional, mas significa
  que mudança em configuração tributária leva até meia hora para aparecer. Agora existe a opção de
  dar TTL próprio a esse cache sem mexer no dos outros. Não alterado.
