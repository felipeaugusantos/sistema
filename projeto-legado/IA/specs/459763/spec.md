# Req. 459763 — Padronizar o JSON de andamento do giro e nomear a cotação no aviso

**Sistema:** API de Suprimento (`Suprimento.Services.API`), versão do executável 1.2.0
**Envolvidos:** Wagner (solicitante) / Joãozinho
**Endpoints afetados:** `POST /api/cotacao/giro/gerar`, `GET /api/cotacao/giro/{idProcessamento}`
**Documento de origem:** `<WAGNER 02/09/2026 10:57:18 Req: 459763>`

---

## 1. Contexto — o que já existe

A geração de itens por giro é assíncrona. O `POST` enfileira uma linha em `SSATSK` e devolve
202 com o `idProcessamento`; o cálculo roda em processo separado (`TCotacaoGiroService.fGerar`),
que pode levar minutos. O consumidor acompanha pelo `GET`.

Três peças já implementadas e que **não** são criadas por este requisito:

| Peça | Onde | Estado |
|------|------|--------|
| Os 4 status `PENDENTE / PROCESSANDO / CONCLUIDO / ERRO` | `TCotacaoGiroAndamentoService.fDerivarStatus` — `Suprimento.Services.Cotacao.Consulta.pas:85` | Já existem, já com estes nomes, derivados em cascata ordenada de `SST_DTAINI / SST_DTAFIN / SST_SUCESS / SST_TYPERR` |
| Publicação de andamento em `SST_STATUS` | `TWorkerServerBase.pGravarAndamento` — `Services.Core.Worker.pas:1733`, JSON montado por `fJsonAndamento` — `Services.Core.Utils.pas:1209` | Já grava, amostrando a cada 3 s (12 passos de 250 ms) |
| `progresso.percentual` calculado na resposta | `pPreencherProgresso` — `Consulta.pas:115` | Já calculado, nunca persistido |

O JSON que hoje vai para `SST_STATUS`:

```json
{"etapa":"Calculando giro de estoque...","progresso":{"posicao":3856,"total":117996}}
```

E o corpo que hoje sai do `GET`:

```json
{
  "status": "PROCESSANDO",
  "etapa": "Calculando giro de estoque...",
  "progresso": { "posicao": 3856, "total": 117996, "percentual": 3.27 },
  "dataInicio": "2026-09-02T10:15:00",
  "dataFim": "",
  "qtdItensGerados": 0,
  "mensagem": ""
}
```

## 2. O problema

Duas lacunas, uma por alteração pedida.

**2.1 — O JSON de andamento não é previsível.** `etapa` é texto solto: não há como o frontend
saber em que ponto da sequência o processo está, nem quantos pontos existem. E campo ausente sai
como `""` ou `0`, que o consumidor não distingue de "vazio de verdade" — `qtdItensGerados: 0`
significa hoje tanto "ainda não terminou" quanto "terminou e gerou zero itens".

**2.2 — O aviso na MENREP não diz de qual cotação se trata.** O texto gravado em `MEN_MENSAG`
(`Suprimento.Services.Cotacao.Notificacao.pas:116`) é genérico. Com mais de um rascunho, o
operador recebe dois avisos idênticos e não sabe a qual pertence cada um.

## 3. A dificuldade de fundo — as etapas não são um conjunto fechado

Isto é o ponto que o documento de origem não resolve e que define a solução.

O andamento chega ao `TWorkerTaskProgress` por **quatro** caminhos, não um:

| Caminho | Onde | Natureza |
|---------|------|----------|
| `pEtapa` do próprio giro | `Suprimento.Services.Cotacao.Giro.pas` — 11 chamadas | Nossas, texto conhecido |
| `VS_OnMensagemAguarde` | gancho plugado em `Services.Core.Worker.pas:1668` | Texto **arbitrário** do motor legado |
| `TfrmGravando.OnMensagemAguarde` | gancho plugado em `Services.Core.Worker.pas:1673` | Texto **arbitrário** do motor legado |
| `TcxProgressBar.OnProgresso` | gancho plugado em `Services.Core.Worker.pas:1678` | Só números (posição/total) |

Os dois ganchos de texto publicam mensagens que o `fCalculaGiroEstoque` emite em laço, em
quantidade que ninguém conhece de antemão e que varia com os filtros. Contar cada mensagem como
uma etapa faria `etapa.numero` passar de `etapa.totalEtapas` — exatamente a imprevisibilidade que
o requisito quer eliminar.

**Decisão (Joãozinho, 03/09/2026): catálogo fixo.** `numero` e `totalEtapas` vêm apenas das
etapas que o `fGerar` declara; mensagem do motor legado atualiza só `etapa.descricao` e **não**
mexe no número. `totalEtapas` é derivado do tamanho do catálogo, não escrito à mão.

## 4. O catálogo de etapas

Oito etapas, na ordem de execução. As três linhas abaixo do catálogo são mensagens que existem
hoje e que **não** são etapas — atualizam a descrição dentro da etapa corrente.

| # | Texto | Onde é emitida hoje |
|---|-------|---------------------|
| 1 | `Abrindo o rascunho...` | `Giro.pas:899` |
| 2 | `Validando filtros...` | `Giro.pas:705` |
| 3 | `Preparando o calculo do giro...` | `Giro.pas:712` |
| 4 | `Calculando giro de estoque...` | `Giro.pas:723` |
| 5 | `Copiando o resultado...` | `Giro.pas:756` |
| 6 | `Convertendo embalagens...` | `Giro.pas:767` |
| 7 | `Abrindo os itens do rascunho...` | `Giro.pas:930` |
| 8 | `Gravando os itens no rascunho...` | `Giro.pas:945` |

Mensagens sem número (só descrição):

| Texto | Onde | Papel |
|-------|------|-------|
| `Giro calculado.` | `Giro.pas:784` | Fecha a etapa 6 |
| `O giro nao retornou itens para os filtros informados.` | `Giro.pas:918` | Condicional; já também vira aviso em `avisos` |
| `Itens gravados no rascunho.` | `Giro.pas:970` | Fecha a etapa 8 — **é esta que vira a `mensagem` do `CONCLUIDO`** |
| qualquer mensagem do motor legado | ganchos | Detalhe interno da etapa corrente |

O número 8 do documento de origem confere: as oito etapas acima são exatamente as chamadas
sequenciais e incondicionais do fluxo.

## 5. Contrato de saída — `GET /api/cotacao/giro/{idProcessamento}`

Campo ausente sai como `null` de verdade, não `""` nem `0`
(decisão de Joãozinho, 03/09/2026).

### PENDENTE — processo aceito, ainda não começou

```json
{
  "status": "PENDENTE",
  "etapa": null,
  "dataInicio": null,
  "dataFim": null,
  "qtdItensGerados": null,
  "mensagem": null
}
```

### PROCESSANDO — em andamento

`progresso` só aparece quando a etapa tem medição; sem medição é `null`, e o consumidor deve
exibir a etapa **sem barra**, não uma barra em 0%.

```json
{
  "status": "PROCESSANDO",
  "etapa": {
    "numero": 4,
    "totalEtapas": 8,
    "descricao": "Calculando giro de estoque...",
    "progresso": { "posicao": 3856, "total": 117996, "percentual": 3.27 }
  },
  "dataInicio": "2026-09-02T10:15:00",
  "dataFim": null,
  "qtdItensGerados": null,
  "mensagem": null
}
```

### CONCLUIDO — terminado com sucesso

`descricao` e `progresso` zeram: o resultado já está em `qtdItensGerados` e `mensagem`.
`numero` e `totalEtapas` **permanecem**, para o frontend fechar a barra de etapas em 8/8.

```json
{
  "status": "CONCLUIDO",
  "etapa": { "numero": 8, "totalEtapas": 8, "descricao": null, "progresso": null },
  "dataInicio": "2026-09-02T10:15:00",
  "dataFim": "2026-09-02T11:18:00",
  "qtdItensGerados": 1745,
  "mensagem": "Itens gravados no rascunho."
}
```

### ERRO — terminado com falha

Diferente do `CONCLUIDO`: `descricao` e `progresso` **mantêm o último valor conhecido**, para
mostrar onde travou. `mensagem` traz a causa real, de `SST_RESULT`.

```json
{
  "status": "ERRO",
  "etapa": {
    "numero": 4,
    "totalEtapas": 8,
    "descricao": "Calculando giro de estoque...",
    "progresso": { "posicao": 12000, "total": 117996, "percentual": 10.17 }
  },
  "dataInicio": "2026-09-02T10:15:00",
  "dataFim": "2026-09-02T10:22:00",
  "qtdItensGerados": null,
  "mensagem": "O calculo do giro de estoque falhou. Mensagem do motor: ..."
}
```

## 6. Contrato de saída — `MENREP.MEN_MENSAG`

Nome da cotação entre aspas duplas, lido de `COTGER_RES.COT_DESCRI` (`varchar(100)`).
`MEN_MENSAG` é `varchar(500)`: não há risco de truncamento.

**Sucesso:**
```
Geração de itens por giro de "Reposição semanal - Loja 12" concluída. 685 itens gerados.
```

**Falha:**
```
A geração de itens por giro de "Reposição semanal - Loja 12" não foi concluída. Consulte o andamento para ver o motivo.
```

**Rascunho sem nome** (`COT_DESCRI` nulo ou em branco): cai no texto atual, sem o trecho
`de "..."`. Emitir `de ""` seria pior que não nomear.

## 7. Regras de negócio

| RN | Regra |
|----|-------|
| **RN01** | `etapa.numero` e `etapa.totalEtapas` derivam do catálogo da seção 4. Mensagem que não está no catálogo — inclusive toda mensagem do motor legado — atualiza `etapa.descricao` e **preserva** o número corrente. |
| **RN02** | `etapa.totalEtapas` é derivado do tamanho do catálogo em tempo de compilação. Acrescentar uma etapa nova ao catálogo move o total sozinho; nenhum literal `8` no código. |
| **RN03** | `etapa` é `null` — o objeto inteiro — enquanto `PENDENTE`. Publicar objeto com números e `descricao: null` afirmaria que o processo está na etapa 1, o que é falso: ele não começou. |
| **RN04** | Em `CONCLUIDO`, `etapa.descricao` e `etapa.progresso` saem `null`; `etapa.numero` vai para `etapa.totalEtapas`; e `mensagem` é a constante de desfecho. **Nenhum dos três pode ser derivado do que o andamento publicou** — ver RN13. |
| **RN13** | O andamento em `_STATUS` **atrasa** em relação ao status derivado. O `Services.Core.Worker` grava `_DTAFIN` na thread da tarefa e só depois o amostrador, na thread principal, faz a colheita final; existe uma janela em que o status já é `CONCLUIDO` e o `_STATUS` ainda é o penúltimo. O consumidor cai nela quase sempre, porque consulta em laço e a **primeira** resposta `CONCLUIDO` é a de antes da colheita. Logo, em `CONCLUIDO` a `mensagem` é constante e o `numero` é forçado ao total — os dois por definição, não por leitura. Medido em 03/09/2026: sem isso vinha `mensagem: "Gravando os itens no rascunho..."` e `numero: 7` de 8. |
| **RN05** | Em `ERRO`, `etapa.descricao` e `etapa.progresso` mantêm o último valor publicado em `SST_STATUS`. `mensagem` vem de `SST_RESULT`, que em erro é a mensagem da exceção em texto puro — comportamento já existente. |
| **RN06** | `qtdItensGerados` só é preenchido em `CONCLUIDO`. Nos outros três status é `null`, nunca `0`: `0` é resposta legítima de um giro que concluiu sem achar item. |
| **RN07** | `progresso` é `null` — não `{posicao:0,total:0,percentual:0}` — quando a etapa não tem medição. `total = 0` é o caso comum, não a exceção. |
| **RN14** | `progresso.percentual` sai arredondado a **duas casas**, a forma que este documento ilustra. Sem isso vai a divisão crua — 70 de 88 devolvia `79.5454545454545` —, e quinze dígitos num campo que existe só para exibição ficam à mercê de como cada consumidor formata; dois clientes arredondando por conta mostrariam valores diferentes do mesmo dado. |
| **RN08** | As novas chaves `numero` e `totalEtapas` em `SST_STATUS` são **omitidas** quando não informadas. `FSATSK` e `FNATSK` também têm coluna `_STATUS` e usam o mesmo `fJsonAndamento`; o JSON delas não pode mudar de forma. |
| **RN09** | Falha ao publicar andamento continua não derrubando a tarefa — o `try/except` com `WriteLog` de `pGravarAndamento` permanece. O andamento é informativo; a fonte autoritativa do resultado é `SST_SUCESS` / `SST_RESULT`. |
| **RN10** | O throttle de 3 s da publicação não muda. `numero` e `totalEtapas` entram no mesmo porta-valores e são amostrados junto, sem gravação extra. |
| **RN11** | O nome da cotação no aviso vem de `COTGER_RES.COT_DESCRI`. Vazio ou em branco cai no texto sem nome (seção 6). Falha ao **ler** o nome não impede o aviso: grava sem o nome e registra em log. |
| **RN12** | `pNotificarConclusao` continua não levantando exceção nunca. Falhar em avisar não pode derrubar — nem marcar como erro — uma geração que concluiu. |

## 8. Mudança de contrato — não há consumidor na forma antiga

O corpo do `GET` muda de forma:

- `etapa` deixa de ser `String` e passa a ser objeto (ou `null`)
- `progresso` sai da raiz e passa a viver dentro de `etapa`
- `dataInicio`, `dataFim`, `mensagem` passam a poder ser `null` em vez de `""`
- `qtdItensGerados` passa a poder ser `null` em vez de `0`

**Nenhum consumidor em produção depende da forma atual.** O REPOR+ é o único consumidor e ainda
está *implementando* a integração — foi justamente ao construir o front end que o Wagner
identificou as duas melhorias deste requisito (confirmado por Joãozinho, 03/09/2026). Não há
janela de incompatibilidade a coordenar, e o endpoint **não** precisa ganhar versão: a forma
nova substitui a antiga direto.

O `POST` **não** muda: corpo de entrada, 202, 400, 404, 409 e 429 ficam como estão.

## 9. Critérios de aceitação

| # | Critério |
|---|----------|
| **CA01** | `GET` de tarefa recém-enfileirada (`SST_DTAINI` nula) devolve `status: "PENDENTE"` e `etapa: null`, com `dataInicio`, `dataFim`, `qtdItensGerados` e `mensagem` todos `null` — literalmente `null` no JSON, não `""` nem `0`. |
| **CA02** | `GET` durante o cálculo devolve `etapa.numero` entre 1 e 8 e `etapa.totalEtapas = 8`, com `etapa.descricao` igual à última mensagem publicada. |
| **CA03** | Enquanto o motor legado publica mensagens pelos ganchos, `etapa.numero` **não muda** e `etapa.descricao` acompanha a mensagem do motor. |
| **CA04** | Em etapa sem medição (`total = 0`), `etapa.progresso` é `null`. Em etapa com medição, traz `posicao`, `total` e `percentual = posicao/total*100`. |
| **CA05** | `GET` de tarefa concluída devolve `etapa.numero = 8`, `etapa.totalEtapas = 8`, `etapa.descricao: null`, `etapa.progresso: null`, `qtdItensGerados` com a contagem real e `mensagem: "Itens gravados no rascunho."`. |
| **CA06** | Giro que concluiu sem achar item devolve `qtdItensGerados: 0` (não `null`) e `status: "CONCLUIDO"`. |
| **CA07** | `GET` de tarefa que falhou devolve `etapa.descricao` e `etapa.progresso` com o último valor conhecido, `qtdItensGerados: null` e `mensagem` com a causa real. |
| **CA08** | `GET` de tarefa órfã encerrada por `pEncerrarOrfas` devolve `ERRO` com a mensagem do processo órfão e a etapa em que parou. |
| **CA09** | Aviso de sucesso em `MENREP.MEN_MENSAG` traz o nome da cotação entre aspas duplas e a quantidade de itens. |
| **CA10** | Aviso de falha em `MEN_MENSAG` traz o nome da cotação entre aspas duplas e não traz o motivo técnico. |
| **CA11** | Rascunho com `COT_DESCRI` em branco gera aviso com o texto sem o trecho `de "..."`, sem aspas vazias. |
| **CA12** | O JSON gravado em `FSATSK.FST_STATUS` e `FNATSK.FNT_STATUS` por tarefas de outros serviços continua sem as chaves `numero` e `totalEtapas`. |
| **CA13** | Tabela de tarefa **sem** a coluna `_STATUS` continua executando a tarefa normalmente, apenas sem publicar andamento. |

## 10. Fora de escopo

- Alterar o corpo ou os códigos de resposta do `POST /api/cotacao/giro/gerar`
- Numerar as mensagens internas do motor legado (`fCalculaGiroEstoque`)
- Acrescentar coluna à `SSATSK` ou à `MENREP`
- Estender a padronização às tarefas de pedido de compra (`TPedidoCompraService`), que respondem
  na própria requisição e não publicam andamento
- Suporte a cotação multiloja, que o gravador continua recusando

## 11. Riscos

| Risco | Mitigação |
|-------|-----------|
| Serialização de `null` pelo DMVCFramework | Verificado: `MVCSerializeNulls = True` por padrão (`MVCFramework.Commons.pas:628`); `TryNullableToJSON` grava `null` para `Nullable*` vazio e propriedade de objeto `nil` sai como `null`. Nenhum serializador precisa ser registrado. |
| A suíte de teste **desserializa** o DTO (`TApiUtils.JsonAs<TCotacaoGiroAndamento>`, `api.controller.cotacao.test.pas:348`) | O DTO tem de fazer ida e volta. Verificar em runtime que `"etapa": null` desserializa em propriedade de objeto sem AV, e que `TApiUtils.CompareJson` compara `null` corretamente. É item de tarefa, não suposição. |
| `.dcu` reaproveitado da `Services/tmp` compartilhada entre os 38 serviços | **Build**, nunca Compile — `Services.Core.Worker.pas` e `Services.Core.Utils.pas` são infra comum. |
| Encoding dos literais acentuados novos em `Notificacao.pas` | Windows-1252 obrigatório, garantido pelo hook `.claude/hooks/delphi-encoding.ps1`. |
