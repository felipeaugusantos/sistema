# Req. 458948 — Registro da sessão

Sessão de 28/08/2026. O que está aqui é o que **não** cabe na `spec.md`: o caminho até as decisões,
as hipóteses que morreram, e as armadilhas que custaram tempo. A spec diz o que ficou; isto diz por
quê, e o que quase aconteceu.

---

## O levantamento mudou de direção três vezes

**Primeira leitura, errada:** comecei achando que era continuação do App Sales — o endpoint irmão
`/limite-parcelas` (Req. 458327) e o cadastro de faixa (Req. 454627) apontavam para venda. Montei a
primeira pergunta em cima disso.

**Correção:** é **cobrança de duplicatas**, e a taxa viria da configuração de juros de atraso.
Investiguei `CFG_JURATR` e `CFG_JURAGR`, levantei que as 35 empresas usam sete percentuais
diferentes, e cheguei a desenhar a solução inteira em cima da CFG.

**Segunda correção:** a taxa passa a ser **por faixa de valor**, na própria `FXCASA`. Isso descartou
todo o desenho anterior e reconectou com o endpoint irmão — a mesma faixa passa a dar o teto de
parcelas e o percentual.

Fica o registro: `CFG_JURATR` é taxa de **mora**, `CFG_JURAGR` é de **agrupamento**. Nenhuma das
duas é usada por este requisito, apesar de as duas terem parecido a resposta certa em algum momento.

## A fórmula, e o exemplo que não fechava

O solicitante deu a fórmula e um exemplo:

```
( (perc.a.m)/30 ) * (qtd.parc. x 30) = % juros total
1000 -> 1216,67 em 4 parcelas
```

**O exemplo não fecha com a fórmula.** Com `prz = 4 x 30 = 120`, nenhuma taxa cadastrada em nenhuma
empresa produz 21,6667%. O que produz exatamente aquele número é **10% a.m. com prazo médio de 65
dias** — que é a média dos vencimentos reais de 4 parcelas começando em 20 dias (20+50+80+110)/4.
Encaixava com `primeiroVencimento` e `periodo` do cadastro do cartão, que o endpoint de baixa já usa.

Apontei a divergência com as três leituras possíveis e os números de cada uma. O solicitante
confirmou `n × 30`, a fórmula literal. **O exemplo dos 1216,67 nunca foi explicado** — ficou como
provável engano de origem, não como requisito.

Consequência aceita: `n × 30` faz 1x custar 30 dias de juros. Isso revogou um pedido anterior de
"primeira parcela sem juros", que é incompatível.

## O furo que quase entrou: o `ValorPago` inflado

Esta é a parte que mais importa se alguém for mexer na baixa.

O desenho inicial punha o juros dentro do `valorRecebido` de cada duplicata. Parecia natural — o
cartão cobra o total, então o recebido seria o total. **Está errado**, e o erro é silencioso.

O `TCalculoBaixaParcial` usa o `ValorPago` como divisor de todos os fatores. Com o juros embutido:

```
Duplicata 1.000,00, baixa parcial de 500,00, juros 200,00

  ValorPago = 700,00 (inflado)          ValorPago = 500,00 (limpo)
    ValorNovaDuplicata = 300,00  ERRADO   ValorNovaDuplicata = 500,00  correto
```

O cliente abateria 700,00 de dívida tendo pago 500,00 de dívida e 200,00 de juros de cartão. Sem
erro, sem log, sem sintoma — só o saldo devedor encolhendo 200,00 a cada baixa parcelada.

A correção veio do próprio solicitante, e é elegante: **manter o contrato das duplicatas intocado**.
O `valorRecebido` chega limpo, então o valor que entra no cálculo parcial já é o certo, sem nenhuma
transformação no meio. Isso também dispensou alterar a validação de teto do recebido — de duas
validações a mexer, sobrou uma.

O caso 46 da suíte existe só para afirmar isso, com o número errado documentado ao lado do certo.

## `jurosParcelamento`: de campo do lote para campo do cartão

Implementei primeiro no lote. O solicitante corrigiu para dentro do movimento de cartão, e o motivo
é bom: **o juros é função da `quantidadeParcelas`, que é atributo do cartão**. Um lote com dois
cartões em parcelamentos diferentes tem dois juros diferentes, e um campo no lote não representa
isso.

O rateio continua sendo do lote (`SomaJurosParcelamento` soma todos os cartões), porque os cartões
pagam as mesmas duplicatas — não há vínculo entre um cartão e um título específico.

## `CAR_ARRPAR`: a sobra de centavos tem dono, e não é a simulação

Descoberto ao conferir o ponta a ponta: as 9 parcelas do cartão vieram 68,63 + 68,61 × 8 — a
**primeira** levou o centavo, enquanto a regra R4 da spec diz que a **última** absorve.

Quem decide isso é o `CAR_ARRPAR`, no cadastro do cartão
(`fontes/financeiro/gerais/untArredondaParcelasCartoes.pas`):

| `CAR_ARRPAR` | Sobra vai para |
|---|---|
| `P` | primeira |
| `U` | última |
| `N` ou vazio | **depende do arredondamento**: para baixo, primeira; para cima, última |

Há ainda uma regra por nome — cartão com "Cielo" no `CAR_DESCAR` usa o rateio da primeira — mas o
`CAR_ARRPAR` é lido depois e sobrescreve.

A simulação não recebe `codigoCartao` e não tem como reproduzir isso. **Decisão: manter a R4
(última) e aceitar a divergência de posição** — o total nunca muda, só onde o centavo cai. Avaliada
e descartada a alternativa de passar o cartão para a simulação: amarraria a simulação ao cartão em
troca da posição de um centavo.

## Campo `CTR_JURPAR`: avaliado e descartado

Chegou a ser proposto um campo próprio na `CADREC` para rastrear o juros de parcelamento — hoje ele
some dentro do `CTR_VALJUR`, indistinguível do juros de mora (na baixa de teste, `CTR_VALJUR` 417,51
era 200,98 de mora + 216,53 de parcelamento).

Há precedente exato: `CTR_PIXJUR`, `CTR_PIXREC`, `CTR_PIXDES` fazem isso para o Pix.

**Descartado pelo solicitante, com o argumento certo:** o acerto de conta do desktop também gera
juros de parcelamento e grava num campo só. Campo preenchido por um caminho e vazio pelo outro faz
relatório mentir por omissão — pior que não existir. Reabrir só junto com a alteração no desktop.

---

# Armadilhas da infraestrutura

Nada disto é do requisito, mas tudo custou tempo nesta sessão.

## O hook de encoding não roda — e não é timeout

`.claude/hooks/delphi-encoding.ps1` está declarado no `settings.json` e o script está correto, mas
**não é executado**. Testado de forma controlada: `.pas` de 7 linhas com 2 acentos no scratchpad,
Edit numa linha ASCII, resultado `updated successfully` com 2 × `EF BF BD` no arquivo. Arquivo
minúsculo, edição trivial — a hipótese de `timeout: 15`, registrada em sessões anteriores, está
morta.

**Corrompi dois arquivos** nesta sessão antes de descobrir (`untCadFaixaParcelamentoCartao.pas` com
19 acentos e `api.controller.parcelamentocartao.pas` com 1). Recuperados por `svn revert` — os dois
estavam commitados e a única modificação pendente era minha.

Pior: minha primeira verificação **passou**, porque procurei `EF BB BF` (o BOM) em vez de
`EF BF BD` (o replacement char). Arquivo destruído não tem BOM, então a checagem deu zero e eu
declarei "encoding preservado" com o arquivo já perdido.

**A regra, sem exceção:** antes de tocar num `.pas`, contar bytes `>= 0x80`; havendo algum, editar
só por PowerShell/Python lendo e gravando em CP1252. Conferir depois `EF BF BD == 0` **e** que a
contagem de bytes altos bate com a de antes.

## O `007` apagaria a coluna nova

O `007_INFRA_FAIXA_CARTAO.sql` usa `REPLACE INTO`, que é delete+insert: **toda coluna omitida volta
a NULL**. A versão anterior não conhecia o `FAI_PERJUR`, então rodá-la depois do `ALTER` zeraria o
percentual das faixas e derrubaria todos os casos de juros — sem erro, sem sintoma óbvio, com os
testes reprovando por motivo aparentemente aleatório.

Corrigido no próprio arquivo, com o aviso no cabeçalho.

## A comparação de array na suíte é POSICIONAL

O caso 45 nasceu declarando a 1ª e a 6ª opção de parcelamento, achando que a DSL casaria por
conteúdo. Ela compara por **posição**: a 6ª declarada foi confrontada com `opcoesParcelamento[1]`,
que é a de 2 parcelas. Reprovou com `parcelas is [2] when [6] expected`.

Declarar um subconjunto **só funciona se for um prefixo**. O caso 44 passou porque declarei as três
primeiras em ordem — sorte, não critério.

## `CALL` pelo `autcom_db.py` reporta sucesso sem efeito

`CALL pTesteBaixaReset('592')` pelo modo master sai como "EXECUTADO E COMMITADO", `linhas afetadas:
0`, e **não altera nada**. Reproduzido duas vezes: 26 linhas antes, 26 depois.

Descartei: empresa fora da `FINTSTEMP` (está lá), retrato vazio (24 linhas), schema divergente no
`INSERT ... SELECT *` (`CADREC` e retrato têm 199 colunas cada), erro registrado (auditoria mostra
`erro=` vazio). O script classifica `CALL` como "NAO-DML (DDL/administrativo)" — a suspeita é que
por esse caminho o efeito da procedure se perca, mas **não confirmei lendo o script**.

Contorno: rodar o `CALL` por outro cliente MySQL.

## `svn add` de pasta pula arquivo em silêncio

`svn add IA\specs\458948` adicionou `spec.md`, `plan.md` e o `.sql`, mas **não o `tasks.md`** — sem
aviso. O `global-ignores` do config do cliente está comentado, então o filtro vem de outro lugar
(provavelmente a config do TortoiseSVN no registro). Resolvido com `svn add --no-ignore`.

**Conferir sempre o `svn status` depois de adicionar pasta nova de spec.**

---

# Performance da API — medido, e não é deste requisito

Medido a pedido: **~3,5 a 4 requisições por segundo**, e **não escala com concorrência**.

| Threads | req/s | Latência média |
|---|---|---|
| 1 | 3,7 | 267 ms |
| 4 | 4,0 | 979 ms |
| 8 | 3,4 | 2.294 ms |

Dobrar clientes dobra a espera e mantém o total constante — fila pura, zero erros em 120
requisições.

**O gargalo não é este requisito.** Uma rota inexistente (404, zero lógica) leva 349 ms, mais que o
endpoint real com 15 opções (326 ms). O `/api/login` serializa igual, e ele não passa pelo worker
manager. A rede são 17 ms.

O `.dpr` sobe com **20 workers** e `MaxConnections 100`, então o desenho não é serial. Hipóteses não
confirmadas, em ordem: processo iniciado com `--workers=1`; log de request/response do
`TApiController` com lock ou I/O síncrono; pool de conexão com uma conexão só.

## Como o worker funciona, já que foi levantado

Worker é **processo separado**, não thread. Cada um sobe um `TIdTCPServer` numa porta aleatória
(12000–65000) e grava PID em `/tmp`. O pool é por empresa.

**Os dados não passam pelo socket.** O TCP carrega só `DO FNATSK 12345` — nome da tabela e id da
linha. Parâmetros e resultado ficam na tabela de tarefas. O worker responde `DONE`, que é só um
sinal; o chamador então faz `SELECT` para buscar o resultado.

Uma chamada HTTP que faz uma query vira: `SELECT ... WHERE FALSE` (estrutura), `INSERT` na tarefa
(sob lock global), TCP, a query real no worker, `UPDATE` do resultado, `SELECT` de polling. Seis
idas ao banco e duas serializações JSON.

O polling usa `Sleep(1000)` com teto de 120 s. A primeira leitura acontece antes do primeiro sleep —
por isso 267 ms e não 1 s. Mas **não existe latência entre ~300 ms e 1 s**: quem não termina antes da
primeira leitura salta para um segundo.

Falha de worker: morreu antes da tarefa, o ping pega e troca de worker, transparente. Morreu durante,
a exceção sobe e vira erro na requisição — **não há reexecução**. Travado (vivo sem responder),
segura a requisição por 120 s.
