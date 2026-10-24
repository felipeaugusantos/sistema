# Armadilhas que só aparecem executando

Três construções cujo comportamento real difere do que o nome ou a forma sugerem. As três passam
pelo compilador, passam por revisão de diff, e falham **em silêncio** — respondendo `200` com o
conteúdo errado, ou não fazendo nada.

Todas foram encontradas no Req. 460364, em 05/09/2026, e nenhuma foi encontrada lendo código.

**O alcance de cada uma é diferente**, e vale conferir antes de descartar por "isso é coisa de API":

| | Vale onde |
|---|---|
| 1. `TryISO8601ToDate` | **autcom inteiro.** `ISO8601ToDate` aparece em `untTGridConfigManagerDB`, `untBaseIntegracaoJSON`, nas units de link de pagamento e nos Services |
| 2. `JsonAs<T>` | **só nos Services.** `api.core.utils` não existe fora de `Services/` |
| 3. `IS_USED_LOCK(NULL)` | o **fato** vale onde houver lock — `untFuncoesGenerica`, `untFuncoesSimples`, `TFaturamentoAutomatico`, `untTFatReservaSaldo`, `untLibNfe`, `untDicSis`, além dos Services. A **forma** descrita aqui é dos Services; no autcom o risco análogo é parâmetro ligado a string vazia — ver a nota no fim da seção 3 |

---

## 1. `TryISO8601ToDate` — o `AReturnUTC` não decide "converter ou não"

```pascal
TryISO8601ToDate(const AISODate: string; out Value: TDateTime; AReturnUTC: Boolean = True)
```

O parâmetro diz **de que fuso a string vem**, não se deve converter:

| | String **sem** offset |
|---|---|
| `True` (default) | `AdjustDateTime` faz `Result := ADate` — **valor como escrito** |
| `False` | trata a entrada como UTC e aplica o bias local. Em `-03:00`, **subtrai 3 horas** |

Fonte: `System.DateUtils.AdjustDateTime`, ramo `else` — `BiasLocal := TZ.GetUTCOffset(...).Negate`,
depois `Result := Result - BiasDT`.

**Para data vinda de query string ou payload, passar `True` ou omitir.**

**O estrago observado.** Com `False`, cada ponta de um filtro de período recuou 3 h. E como
`EndOfTheDay` é aplicado **depois** do deslocamento, o dia final inteiro se perdia:
`dataInicio=2026-09-04&dataFim=2026-09-05` consultava de **03/09 21:00 a 04/09 23:59**. A resposta
voltava `200`, com as linhas erradas.

**Como foi pego.** Comparando o **conjunto de ids** devolvido contra um `SELECT` direto. Contar
linhas não pegaria — o total batia razoável e as linhas eram outras.

---

## 2. `TApiUtils.JsonAs<T>` — não instancia objeto aninhado

`JsonAs<T>` **preenche** o que já existe na instância; não cria. Property de classe que nasce `nil`
continua `nil` depois de desserializar, mesmo com o JSON trazendo o objeto completo.

Lista funciona **se o construtor a criar** — é por isso que `TCotacaoGiroGerarParams` cria o
`Ffiltros` no `Create`.

**O estrago observado.** No retorno de um worker, o campo `etapa` vinha `null` em **100%** dos itens
— o worker mandou 54 preenchidas de 189 e a API entregou zero. E o `GET` por id respondia `200` com
corpo `null`. O JSON gravado pelo worker estava correto; nada denunciava.

**Como resolver, para travessia worker → controller com aninhamento:** não desserializar. Ler do
JSON só o escalar necessário e repassar o nó interno **verbatim** com `Render(string)`. É o que
`ListarGiros` e `ConsultarAndamentoGiro` fazem desde r493389.

> Pré-criar os aninhados no construtor resolve o caso preenchido e **estraga o vazio**, quando `nil`
> significa ausência — em `etapa`, viraria objeto de campos nulos, que o Req. 459763 recusou
> explicitamente. O repasse não tem esse dilema, e não volta a acontecer quando alguém acrescentar
> mais um nível de aninhamento.

**Como foi pego.** Comparando o `SST_RESULT` gravado na `SSATSK` com o que a API devolveu.

---

## 3. `IS_USED_LOCK(NULL)` — levanta erro, não devolve `NULL`

```
ERROR 3057: Incorrect user-level lock name 'NULL'.
            The name is empty, NULL, or can not be expressed in the current character-set.
```

Vale para nome vazio também, e para `GET_LOCK` / `RELEASE_LOCK`.

Importa porque o nome do lock é montado **a partir do JSON da linha**:

```sql
CONCAT('COTGIRO:COTRES_', SST_PARAMS ->> '$.sequencialRascunho')
```

Em linha que não tem esse campo — tarefa de outro serviço na `SSATSK`, que é compartilhada pelos
três — o `->>` dá `NULL`, o `CONCAT` dá `NULL`, e a **query estoura** em vez de simplesmente não
casar.

**O estrago observado.** O `pEncerrarOrfas` tem `try/except` que loga e segue. Com uma tarefa
assíncrona alheia em voo, a query inteira estourava, o `except` engolia, e **a varredura deixava de
rodar por completo** — órfã de giro nunca limpa, `GET` respondendo `PROCESSANDO` para sempre e o
rascunho travado.

**Ao montar nome de lock a partir de coluna ou caminho JSON, restringir as linhas antes.** Corrigido
em r493390 filtrando `SST_SERVIC` + `SST_METHOD`.

> Desconfiar do raciocínio "o `NULL` propaga e o predicado fica falso". Em função de lock, não fica.

**No autcom a forma é outra.** Lá o nome do lock vem de variável Delphi ou de parâmetro —
`GET_LOCK("' + strLock + '", 2)`, `GET_LOCK(:CHAVE, 0)`,
`IS_USED_LOCK("PAINEL_NFE_' + VS_strCodEmp + '")` — e não de expressão SQL sobre coluna. O risco
equivalente é o parâmetro chegar **vazio**: `ERROR 3057` cita "empty" junto com "NULL". Concatenação
com prefixo, como o `PAINEL_NFE_`, protege por acidente; parâmetro puro como `:CHAVE` não.

---

## O que os três têm em comum

Em todos, o modelo mental estava errado e o código parecia certo. Compilação não pega, revisão de
diff não pega, e teste que conta linhas ou confere código HTTP não pega.

**O que pegou, nos três: comparar o que o sistema produziu com o que a fonte de verdade diz** — o
conjunto de ids contra o `SELECT`, o JSON da API contra o `SST_RESULT`, a linha alheia contra o que a
varredura deveria ter feito.

Quando a afirmação for sobre comportamento de runtime, **executar**. Reler não basta.
