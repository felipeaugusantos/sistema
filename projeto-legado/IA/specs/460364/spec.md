# Req. 460364 — Consulta de gerações de giro por status e período

**Sistema:** Suprimento.Services.API · **Envolvidos:** Wagner / Joãozinho · **Aberto em:** 04/09/2026

## Problema

Só existe `GET /api/cotacao/giro/{idProcessamento}` — consulta pontual por um id que o consumidor já
conhece. O REPOR+ precisa **descobrir** quais gerações estão rodando sem saber o id de antemão: para
retomar o acompanhamento depois de um reload de página, e para avisar na listagem de cotações que há
algo em andamento mesmo iniciado em outra aba.

O `idRascunho` é o dado mais crítico: hoje ele só existe nos parâmetros que o consumidor envia ao
disparar o giro, e **nunca volta**. Sem ele não há como saber a qual rascunho cada geração pertence.

## Contrato

```
GET /api/cotacao/giro?status=PENDENTE,PROCESSANDO&dataInicio=2026-09-01&dataFim=2026-09-04
Header Empresa: 022        obrigatório
```

| Parâmetro | Regra |
|---|---|
| `status` | Opcional. Um ou mais de `PENDENTE`, `PROCESSANDO`, `CONCLUIDO`, `ERRO`, separados por vírgula, case-insensitive. Vírgula sobrando é tolerada. Valor fora do conjunto → **400** citando os aceitos. Ausente traz todos |
| `dataInicio` | Opcional. `AAAA-MM-DD` ou ISO 8601. Filtra **`SST_DTAINS`** — a data de *solicitação*. Ausente assume `dataFim` menos 24 h |
| `dataFim` | Opcional. Mesmo formato. Data pura inclui o dia inteiro. Ausente assume o instante da consulta |

**Não existe `codigoEmpresa` na query.** O escopo é sempre o do header `Empresa`.

**Resposta:** array cru, ordenado por `SST_DTAINS` desc (desempate por `AUTOINCREM` desc), no máximo
**200** itens. Quando o teto corta, a resposta traz `X-Result-Truncated: true`.

Cada item tem o mesmo shape do `GET /giro/{id}`, acrescido de `idProcessamento` e `idRascunho` — que
passam a vir também no endpoint por id. `idRascunho` sai de `SST_PARAMS ->> '$.sequencialRascunho'`:
**nenhuma coluna nova, nenhum script de migração.**

## Decisões e o porquê

**`SST_DTAINS` e não `SST_DTAINI`.** O requisito pedia "data de início do processamento", mas
`SST_DTAINI` é **nula em `PENDENTE`** — um filtro por ela descartaria exatamente as gerações
enfileiradas que ainda não começaram. Os nomes `dataInicio`/`dataFim` foram mantidos como o Wagner
escreveu, com o Swagger declarando que filtram a data de solicitação. **Guardado pelo caso 19.**

**A cascata de status foi para o SQL.** O status é derivado de `_DTAINI`, `_DTAFIN`, `_RESULT`,
`_SUCESS` e `_TYPERR` numa cascata ordenada. Filtrar por ele exigiria a mesma regra escrita duas
vezes — uma em Delphi para montar a resposta, outra em SQL para o `WHERE`. Virou o `CASE` de
`fSqlStatusDerivado`, usado pelo `SELECT` e pelo `WHERE`.

**Tudo passa pelo worker.** Descoberto durante a revisão: `ConsultarAndamentoGiro` chamava o serviço
de consulta direto do controller — desvio não percebido, não decisão, e a lista foi escrita seguindo
ele. Corrigido para os dois, mais o pré-voo do POST. O controller não faz mais nenhum acesso a banco;
a ausência de `Cotacao.Consulta` e `Cotacao.Concorrencia` no `uses` é a verificação mais barata disso.

**O controller repassa o JSON do worker, não desserializa.** `TApiUtils.JsonAs<T>` não instancia
objeto aninhado que esteja nil — só preenche o que já existe. Desserializar perdia o `etapa` em 100%
dos itens (worker mandou 54, API entregou 0) e fazia o `GET` por id responder `200` com corpo `null`.
Pré-criar no construtor resolveria o caso preenchido e estragaria o vazio, onde nil **significa** "não
há etapa". Medido ao vivo em 05/09/2026.

**Header e não envelope.** O corpo é o array cru pedido. O envelope existe só entre worker e
controller.

**Teto de 200.** A `SSATSK` não tem expurgo.

## Units alteradas

| Unit | O quê |
|---|---|
| `fontes/genericos/untTypesSistema.pas` | `ECotacaoGiroContrato`, `ECotacaoGiroEmAndamento`, `ECotacaoGiroTetoAtingido` — precisam ser visíveis do `Services.Core.Worker` para atravessar |
| `Services/Core/Services.Core.Worker.pas` | as três na lista branca do `fExecuteTask` |
| `Services/Core/api/core/api.core.utils.pas` | `TApiUtils.DataDeParametro` e `TextoDeDataValidado` |
| `Core/suprimento/services/types/Suprimento.Services.Cotacao.Types.pas` | campos novos, catálogo de status, constantes, DTOs de transporte, aliases das exceções |
| `Core/suprimento/services/Suprimento.Services.Cotacao.Consulta.pas` | cascata para SQL, `fMontarAndamento`, `fListar` |
| `Core/suprimento/services/Suprimento.Services.Workers.pas` | `TCotacaoConsultaServiceWorker`, `fValidarSolicitacao`, `LoadMethods` |
| `Suprimento.Services.API/.../api.controller.cotacao.pas` | `ListarGiros`, pré-voo no worker, repasse do JSON |
| `Suprimento.Services.API/.../api.controller.cotacao.test.pas` | `ListarGirosTest` e o assert da lista |
| `Financeiro.Services.API/.../api.controller.cobranca.duplicatas.pas` | `ValidarData` e `ValidarPeriodo` pelo helper compartilhado |

## Cobertura

**Casos automatizados, todos verdes contra a `2_30_BELAT_TC` em 05/09/2026:**

| | |
|---|---|
| 17, 18 | contrato: status fora do catálogo, período invertido |
| 19 | `PENDENTE` aparece no filtro por período — guarda o `SST_DTAINS` |
| 26 | tarefa de outro serviço não vaza — guarda o `SST_SERVIC` |
| 27 | geração de outra empresa não vaza na lista |
| 2, 9, 10, 11, 12 | `GET` por id, os quatro status e o 404 — **sem regressão** após a cascata ir para SQL e o endpoint passar pelo worker |
| 13 | 429, com `ECotacaoGiroTetoAtingido` atravessando o worker |

**Verificado ao vivo, sem caso automatizado:**

- `409` com o lock preso numa conexão — `ECotacaoGiroEmAndamento` atravessa
- janela de data conferida por **conjunto de ids** contra `SELECT` direto (39 = 39)
- fidelidade da `etapa`: worker 93 → API 93
- `X-Result-Truncated` presente com 200 resultados e ausente com 2
- Financeiro: `dd/mm/aaaa` preservado, ISO recusado com `400`, período invertido `400`

**Não coberto, deliberado:** o corte em 200 linhas exige montar 201 linhas para conferir um header —
custa mais do que prova. Conferir à mão quando o teto mudar.

## Achados fora de escopo

- ~~`pEncerrarOrfas` não filtra por `SST_SERVIC`/`SST_METHOD`~~ — **corrigido em r493390**, ver abaixo.
- **`ValidarPeriodo` do Financeiro comparava com `StrToDate` cru**, usando o `FormatSettings` do
  processo: em máquina com locale diferente, `03/09/2026` seria lido como 9 de março e a comparação
  sairia errada sem erro nenhum. Corrigido de carona, por estar na rotina vizinha à que eu alterava.
- **`GET /contasareceber/cobranca/duplicatas` não tem teto de linhas.** Um cliente da base de teste
  tem 51 mil títulos e a consulta sem filtro de data estoura 90 s. Mesmo problema que o teto de 200
  resolve aqui.
- **`fConsultar` não filtra por `SST_SERVIC`/`SST_METHOD`**, ao contrário do `fListar`. Acrescentar
  transformaria em 404 um id que hoje responde 200 — mudança de comportamento em produção.

## r493390 — varredura de órfãs restrita às tarefas de giro

`TCotacaoGiroConcorrencia.pEncerrarOrfas` e `fProcessosAtivos` passaram a filtrar `SST_SERVIC` +
`SST_METHOD`. A `SSATSK` é compartilhada pelos três Services, e sem o par a linha alheia chegava ao
teste de lock.

**O efeito não era o que este documento afirmava até 05/09/2026.** A versão anterior dizia que a
varredura *encerrava como órfã uma tarefa viva do Faturamento*. Está errado, e o erro veio de supor
propagação de `NULL` sem executar:

> `IS_USED_LOCK(NULL)` **não devolve `NULL`** — levanta `ERROR 3057, Incorrect user-level lock name`.
> Com uma tarefa assíncrona alheia em voo, a query inteira estourava, o `except` do `pEncerrarOrfas`
> engolia e logava, e **a varredura deixava de rodar por completo**. Nenhuma tarefa alheia era
> tocada; o dano era órfã de giro nunca ser limpa — `GET` respondendo `PROCESSANDO` para sempre e o
> rascunho travado, que é justamente o que a varredura existe para evitar.

**Verificado ao vivo**, com duas linhas montadas no mesmo ciclo: uma alheia (`TPedidoCompraService`)
e uma órfã de giro real. Com o filtro, a alheia sai intacta e a órfã é encerrada com
`EProcessoOrfao`. A segunda linha é o que torna a prova conclusiva — "alheia intacta" sozinho seria
igualmente verdade se a varredura tivesse estourado e não feito nada.

**Sem caso automatizado.** O `json_validate` da suíte compara o banco pela procedure
`pProcessoCotacaoGiroResponse`, que lê a `SSATSK` do `idProcessamento` da resposta — não há como
afirmar sobre uma linha arbitrária que não aparece no fluxo. Cobrir exigiria estender a procedure, o
que é maior que o conserto.

**A exposição só existe a partir do Req. 455094.** Hoje `fEnqueueAsyncTask` é chamado de um lugar só,
o POST do giro, então não há tarefa assíncrona alheia. Aquele requisito enfileira exportação de
forma assíncrona — as 6 linhas de `TCotacaoExportacaoService` na base de teste já têm
`SST_ASSINC = 'S'`.

## Merge

O Req. 455094 (exportação de cotação) altera cinco dos arquivos deste e ainda não commitou. O conflito
que exige decisão é em `Cotacao.Consulta`: ele criou `TCotacaoExportacaoAndamentoService.fDerivarStatus`
duplicando a cascata em Delphi, com o motivo escrito no código — *"só se paga na terceira tarefa"*.
Este requisito é a terceira. O `fSqlStatusDerivado` não depende de nada do giro, só do prefixo `SST`,
e serve à exportação sem alteração. Aquele requisito também tem três consultas chamando o serviço
direto do controller, que precisam ir para o worker pelo mesmo motivo das duas daqui.
