# Req. 458138 — Tabela de preço geral informada pelo consumidor nos endpoints de cálculo do pedido

**Requisitante:** Ronaldo
**Envolvidos:** Felipe Damacena (24/08/2026)
**Módulo:** AUTCOM > Faturamento.Services.API > Pedido
**Zona:** Moderna (`padra_atualizado/Services/`)

---

## 1. Objetivo

Permitir que o consumidor informe, no cabeçalho da requisição, a tabela de preço a ser
usada no cálculo — em vez de a API sempre derivá-la das regras internas do AUTCOM.

Motivador: o Citel Sales passou a decidir a tabela de preço por conta própria, através de
configurações novas do lado dele (`CFG_OPTPSL`, `CFG_TABSAL`). Para que os preços exibidos
no Sales e os calculados pela API coincidam, o Sales precisa poder dizer qual tabela usar.

---

## 2. Divisão de responsabilidade

Esta é a decisão que estrutura todo o requisito.

| Responsabilidade | Dono |
|------------------|------|
| Decidir **qual** tabela de preço usar (ler `CFG_OPTPSL`, `CFG_TABSAL`, `CFG_TABPRC`, `CLI_TABPRE`, `OPE_TABPRE`) | Citel Sales |
| Calcular o preço **dada** a tabela | Faturamento.Services.API |

A API **não conhece** `CFG_OPTPSL` nem `CFG_TABSAL`, e não deve passar a conhecer. São
configurações de um consumidor específico. Se a API precisasse embutir a regra de escolha
de cada consumidor, cada novo cliente exigiria alteração no serviço compartilhado.

A API recebe a tabela, valida se é um valor possível, e a respeita. Não questiona se foi
uma boa escolha.

---

## 3. Contrato

### 3.1 Campo novo

| Atributo | Valor |
|----------|-------|
| Nome | `tabPrecoGeral` |
| Tipo | string |
| Obrigatório | Não |
| Valores | `"1"` a `"7"` |
| Posição | Cabeçalho da requisição (irmão de `codigoCliente`) |

### 3.2 Nomenclatura — por que não `tabPreco`

O item já expõe `tabPreco` (`TPedidoTotalizadorItem`, entre outros). No vocabulário do
AUTCOM o par é `strTabPre` (geral) e `strTabPreItem` (item) — ou seja, o nome *sem* sufixo
designa a geral, o inverso do que a API fez ao batizar o campo do item de `tabPreco`.

Renomear o campo do item para alinhar com o AUTCOM seria quebra de contrato para os
consumidores atuais. Optou-se por `tabPrecoGeral` no cabeçalho, mantendo `tabPreco` no
item. A divergência de vocabulário com o AUTCOM fica registrada aqui e na descrição
Swagger do campo.

### 3.3 Exemplo

```json
{
  "codigoCliente": "000123",
  "codigoCondicaoPagamento": "001",
  "tabPrecoGeral": "3",
  "items": [
    { "id": 1, "codigoItem": "ABC", "tabPreco": "5" },
    { "id": 2, "codigoItem": "DEF" }
  ]
}
```

Item 1 usa a tabela 5. Item 2 usa a tabela 3.

### 3.4 Rotas que passam a aceitar o campo

| # | Rota (POST) | DTO do body |
|---|-------------|-------------|
| 1 | `/api/pedido/calcular-impostos` | `TPedidoTotalizadorParams` |
| 2 | `/api/pedido/calcular-precos` | `TPedidoCalcularPrecosSugestaoParams` |
| 3 | `/api/pedido/calcular-precos-sugeridos` | `TPedidoCalcularPrecosSugestaoParams` |
| 4 | `/api/pedido/calcular-precos-condicao-pagamento` | `TPedidoCalcularPrecosCondPagamentoParams` |
| 5 | `/api/pedido/validar-unitario` | `TPedidoValidarUnitarioParams` |
| 6 | `/api/pedido/validar-pedido` | `TPedidoValidarPedidoParams` |
| 7 | `/api/pedido/validar-valor-minimo` | `TPedidoValidarPedidoParams` |
| 8 | `/api/pedido/calcular-total-desejado-item` | `TPedidoCalcularTotalDesejadoProdutoParams` |

8 rotas sobre 6 DTOs — as rotas 2/3 e 6/7 compartilham contrato.

### 3.5 Rota que já recebia a tabela e não muda

`POST /api/pedido/calcular-valor-promocional` já expõe `tabPreco` no cabeçalho, e já é
**obrigatório** (`TPedidoCalcularValorPromocionalParams`). É endpoint de item único, sem
lista de itens e sem cabeçalho de pedido. Nada a alterar.

### 3.6 Emissão de pedido — fora de escopo

A inserção do pedido de venda é feita pelo próprio Sales, não pela API. Esta API é um
helper que fornece ao Sales o conhecimento de regra de negócio do AUTCOM que ele não tem;
a gravação não passa por ela.

---

## 4. Regras

### 4.1 Precedência

```
tabPreco do item  >  tabPrecoGeral do cabeçalho  >  regra interna do AUTCOM
```

1. Item com `tabPreco` preenchido usa esse valor.
2. Item sem `tabPreco` herda o `tabPrecoGeral`.
3. `tabPrecoGeral` ausente ou vazio → a API resolve pela regra interna do AUTCOM.

**O degrau 1 não existe em todas as rotas.** O `tabPreco` de item só está no contrato de 4
dos 6 DTOs de item — nas outras duas rotas o único controle é o `tabPrecoGeral` do
cabeçalho, e um `tabPreco` enviado dentro do item é campo desconhecido, descartado na
desserialização sem erro:

| Rota | Classe do item | `tabPreco` no item |
|------|----------------|--------------------|
| `/calcular-impostos` | `TPedidoTotalizadorItem` | sim |
| `/calcular-precos` e `/calcular-precos-sugeridos` | `TPedidoCalcularPrecosSugestaoItem` | **não** |
| `/calcular-precos-condicao-pagamento` | `TPedidoCalcularPrecosCondPagamentoItem` | **não** |
| `/validar-unitario` | `TPedidoValidarUnitarioItem` | sim |
| `/validar-pedido` | `TPedidoValidarPedidoItem` | sim |
| `/calcular-total-desejado-item` | `TPedidoCalcularTotalDesejadoProdutoItem` | sim |

Situação anterior a esta requisição — nenhuma dessas duas classes ganhou nem perdeu campo
aqui. Acrescentar `tabPreco` a elas seria ampliação de escopo e não foi feito.

Os dois primeiros degraus já eram implementados antes deste requisito, em
`Faturamento.Services.Pedido.pas:542-543`:

```pascal
if dadosProduto.strTabIte.IsEmpty then
  dadosProduto.strTabIte := objEmitirPedido.objFatVenda.strTabPre;
```

O terceiro degrau também, em `Faturamento.Classes.TEmitirPedido.pas:503-504`:

```pascal
if dadosPedido.strTabPre.IsEmpty then
  dadosPedido.strTabPre := fRetTabelaPrecoSugestao(dadosPedido.strCodCli, dadosPedido.strCodVen);
```

O motor já tratava `strTabPre` como "respeite se vier, resolva se não vier". O requisito
consiste em **alimentar** esse campo a partir do JSON — nenhuma regra de cálculo muda.

### 4.2 Regra interna do AUTCOM (comportamento quando o campo é omitido)

`fRetTabelaPrecoSugestao` (`untFuncoesGenerica.pas:16738`), na ordem:

1. `CFG_UTAPTB` ≠ `'0'` → usa `CFG_UTAPTB`
2. `CFG_SUGTBP = 'S'` e `CFG_TBPSUG` ≠ `'0'` → usa `CFG_TBPSUG`
3. `CADCLI.CLI_TABPRE` preenchido → usa a tabela do cliente
4. Vazio e `CFG_HIETAB = 'S'` → tabela do vendedor (`fRetornaTabelaPrecoVendedor`)
5. `CFG_TBPRPD` preenchido → usa `CFG_TBPRPD`
6. Nada → `'1'`

Corresponde ao `CFG_OPTPSL = 1` descrito no requisito ("mesmas regras utilizadas no
AUTCOM"). Documentado aqui apenas como referência do comportamento default — a API não
foi alterada neste ponto.

### 4.3 Validação

Faixa `1` a `7`. Fora dela, HTTP 400:

> `A tabela de preço geral deve ser um valor entre 1 e 7.`

`""` e campo ausente **não** são erro — significam "resolva pela regra do AUTCOM".
`"0"` **é** erro, por estar fora da faixa.

A validação roda antes de qualquer acesso a banco em `pPreValidacoesPedido`, espelhando a
validação já existente para a tabela do item (`pValidarTabPreco`,
`Faturamento.Services.Pedido.pas:677`).

### 4.4 O que deliberadamente não é validado

Existem no AUTCOM duas funções que julgam se uma tabela é *permitida*:
`fSistemaUsaEssaTabelaPreco` e `fFaturamentoUsaEssaTabelaPreco`
(`untFuncoesSimples.pas:34565`), que testam `CFG_TABPRC` e `CFG_TABVEN`.

Elas **não** foram incorporadas, por duas razões:

1. São chamadas hoje exclusivamente de telas VCL — nenhum consumidor nos Services. Trazê-las
   seria mudança de comportamento além do escopo do requisito.
2. São exatamente as validações que recusariam a tabela que o consumidor escolheu de
   propósito. A decisão do requisito é respeitar a tabela informada.

---

## 5. Pontos de impacto

### 5.1 `Services/Core/faturamento/services/types/Faturamento.Services.Pedido.Types.pas`

Campo `FtabPrecoGeral` + propriedade `tabPrecoGeral` com `MVCSwagJsonSchemaField` nas 6
classes de parâmetros: `TPedidoTotalizadorParams`, `TPedidoCalcularPrecosSugestaoParams`,
`TPedidoValidarUnitarioParams`, `TPedidoValidarPedidoParams`,
`TPedidoCalcularTotalDesejadoProdutoParams`, `TPedidoCalcularPrecosCondPagamentoParams`.

### 5.2 `Services/Core/faturamento/services/Faturamento.Services.Pedido.pas`

Repasse nos 6 overloads de `pIniciarPedido`:

```pascal
dadosPedido.strTabPre := Pedido.tabPrecoGeral;
```

Validação de faixa em `pPreValidacoesPedido`, antes da consulta de `CLI_BENREI`.

### 5.3 `Services/Core/faturamento/services/Faturamento.Services.Pedido.Cache.pas`

Três campos acrescentados à chave de `TPrecoSugestaoCache`: `tabPrecoGeral` (via parâmetro
novo `ATabPrecoGeral` em `GetKey` / `TryGetCache` / `AddOrSetCache`), `codigoEmbalagem` e
`volumeProduzido`. Ver seção 9.

### 5.4 Não alterados

`Faturamento.Classes.TEmitirPedido.pas` e `Faturamento.Classes.TFatVendaBase.pas` — o
mecanismo de precedência e a regra de resolução já existiam e foram reaproveitados.
`api.controller.pedido.pas` — o binding do body é por `BodyAs<T>`, o campo novo é
desserializado sem alteração no controller.

---

## 6. Compatibilidade retroativa

`fGetDadosPedidoDef` (`Faturamento.Services.Pedido.pas:492`) inicializa o record com
`FillChar(Result, SizeOf(Result), #0)` e **nunca** atribuía `strTabPre`. O campo portanto
já chegava vazio ao motor, e a resolução sempre passou por `fRetTabelaPrecoSugestao`.

Com a alteração, consumidor que não envia `tabPrecoGeral` produz `strTabPre = ''` —
idêntico ao estado anterior. Não há caminho de regressão para consumidores existentes.

---

## 7. Critérios de aceitação

> Os **casos** de teste são escritos pelo analista. Abaixo está a lista de cenários que a
> implementação se compromete a atender — é o entregável de quem implementou.

### 7.1 Regressão (prioritário)

| # | Cenário | Esperado |
|---|---------|----------|
| 1 | Request **sem** `tabPrecoGeral`, cliente com `CLI_TABPRE` preenchido | Mesmos preços de antes da alteração |
| 2 | Request com `tabPrecoGeral: ""` | Idêntico ao caso 1 |
| 3 | Caso 1 com `CFG_UTAPTB` ≠ `'0'` | Prevalece `CFG_UTAPTB`, como hoje |

### 7.2 Campo em uso

| # | Cenário | Esperado |
|---|---------|----------|
| 4 | `tabPrecoGeral: "3"`, itens sem `tabPreco` | Todos os itens precificados pela tabela 3 |
| 5 | `tabPrecoGeral: "3"`, cliente com `CLI_TABPRE = 5` | Tabela 3 — o informado vence o cadastro do cliente |
| 6 | `tabPrecoGeral: "3"`, item com `tabPreco: "5"` | Aquele item na tabela 5, os demais na 3 |
| 7 | Caso 4 repetido nas 8 rotas da seção 3.4 | Mesma tabela aplicada em todas |

### 7.3 Validação

| # | Cenário | Esperado |
|---|---------|----------|
| 8 | `tabPrecoGeral: "0"` | HTTP 400, mensagem da seção 4.3 |
| 9 | `tabPrecoGeral: "8"` | HTTP 400 |
| 10 | `tabPrecoGeral: "abc"` | HTTP 400 |
| 11 | `tabPrecoGeral` inválido **e** cliente inexistente | Erro da tabela de preço primeiro (valida antes do banco) |

### 7.4 Consistência entre rotas

| # | Cenário | Esperado |
|---|---------|----------|
| 12 | Mesmo `tabPrecoGeral` em `calcular-precos` e `validar-pedido` | Valores coerentes entre as duas respostas |

### 7.5 Cache de preço sugerido (ver seção 9)

Duas chamadas **em sequência**, idênticas exceto pela tabela. A ordem importa: a primeira
popula o cache, a segunda é a que prova.

| # | Cenário | Esperado |
|---|---------|----------|
| 13 | `POST /calcular-precos-sugeridos`, item com `PREVE2` ≠ `PREVE3`, `tabPrecoGeral=2`; depois a **mesma** requisição com `tabPrecoGeral=3` | Segunda resposta traz o preço da tabela 3, não o da 2 |
| 14 | Item de tinta, mesmo hash e mesma `embalagemProduzida`, variando `volumeProduzido` | Cada volume devolve seu próprio preço |
| 15 | Item de tinta, mesmo hash, variando `codigoEmbalagem` | Cada embalagem devolve seu próprio preço |

Caso 13 verificado como **falhando** antes da correção: cliente `00001010`, condição `001`,
item `54693`, empresa `061`, quantidade `1.37` — `tabPrecoGeral=2` devolveu 13,05 (correto) e
a chamada seguinte com `tabPrecoGeral=3` devolveu **13,05** em vez de 13,98.

---

## 8. Riscos e observações

### 8.1 `CFG_TABPRC` — o "+1" descrito no requisito

O texto do requisito diz, para os casos `CFG_OPTPSL` 2/3/4: *"Se ela contiver a letra 'S',
o sistema usa a posição da letra 'S' **+ 1** como a tabela de preço"*.

No AUTCOM não existe esse deslocamento. `CFG_TABPRC` é uma máscara de 7 caracteres `S`/`N`
onde **a posição é o próprio número da tabela** — `pAtuVarGlobaisSimples`
(`untFuncoesSimples.pas:9815`) preenche com `'N'` até completar 7 posições, e
`fRetornaNumeroPrimeiraTabelaPrecoAtiva` (`untFuncoesGenerica.pas:16779`) resolve com
`IntToStr(intIndice)`, sem somar.

Se o Sales aplicar `posição + 1`, enviará uma tabela deslocada em um. Como qualquer valor
de 1 a 7 é aceito, **não haverá erro** — apenas preço divergente. Consequência: a validação
da API não protege contra isso, e a conferência tem de ser feita no cálculo do Sales.

Registrado para o Felipe. Não é alteração na API.

### 8.2 Consistência entre chamadas é responsabilidade do consumidor

O `tabPrecoGeral` precisa ser o mesmo nas várias rotas de uma sessão de venda. Se o Sales
enviar tabelas diferentes entre `calcular-precos` e `validar-pedido`, os números não fecham,
e a divergência só aparece no pedido gravado.

### 8.3 Chave do cache montada à mão — mecanismo frágil

A correção da seção 9 resolve os três campos que faltavam **hoje**, mas não o mecanismo: a
chave continua sendo uma lista escrita à mão, e campo novo no DTO continua entrando fora dela
sem qualquer aviso.

O projeto tem os dois padrões lado a lado. `THttpResponseCache`
(`api.core.cache.pas:156`) chaveia `empresa + uri + corpo cru da requisição` e é imune por
construção — foi por isso que `/calcular-impostos` e `/validar-valor-minimo`, que passam por
ele, nunca sofreram deste defeito. `TPrecoSugestaoCache` lista campos.

O `README.md` de `Scripts/testes/` descreve a mesma forma de defeito em outro contexto: o
`pProcessoCotacaoGiroResponse` lista colunas a partir do `information_schema` e "coluna nova
na tabela aparece sozinha no dump", enquanto as procedures escritas à mão deixam "coluna
acrescentada fora da prova até alguém editar a procedure, e a falta não aparece em lugar
nenhum".

**Proposta para requisito separado:** montar a chave por RTTI sobre as propriedades
`published` do DTO, com lista explícita de exclusão (`id`). O ganho é a direção da falha —
esquecer de **incluir** hoje produz preço errado por até 30 minutos; esquecer de **excluir**
com RTTI produz apenas um cache miss.

Não entrou nesta requisição por dois motivos. O modo de falha de uma chave RTTI mal
construída é cache miss de 100%, silencioso: todas as respostas continuam corretas e nenhum
teste funcional acusa. Fechar com segurança exige asserção de taxa de acerto, que a suíte não
tem hoje. E misturar troca de mecanismo com correção de defeito no mesmo diff prejudica o
julgamento das duas coisas no review.

Dois detalhes de implementação para o requisito novo: `TValue.ToString` em `Double` usa
formatação de locale e precisa de `TFormatSettings.Invariant` explícito; e a ordem das
propriedades por RTTI é a de declaração na prática, mas não é garantida em contrato — ordenar
por nome remove a dúvida.

### 8.4 `/api/pedido/calcular-precos` sem cobertura de teste

Das 8 rotas, essa é a única sem caso na suíte de testes da API (`api.controller.pedido.test.pas`
não tem constante para ela). Situação anterior a este requisito; anotado para quando a
cobertura for ampliada.

---

## 9. Defeito encontrado em teste: chave do cache de preço sugerido

Descoberto ao exercitar o campo novo contra a API. Registrado aqui porque a correção faz
parte desta requisição.

### 9.1 O sintoma

`POST /api/pedido/calcular-precos-sugeridos` parecia ignorar `tabPrecoGeral`: o preço não
mudava para nenhum valor de 1 a 7.

### 9.2 A causa raiz

`TPrecoSugestaoCache.GetKey` compõe a chave com 14 atributos que influenciam o preço, e a
tabela não estava entre eles.

Isso era inofensivo antes desta requisição, e o motivo importa: a tabela era sempre
**derivada** de `(cliente, condição de pagamento)`, e os dois estão na chave. A chave
identificava o cálculo unicamente porque nada externo podia alterar a tabela.

A Req. 458138 quebrou essa invariante. Ao permitir que o consumidor informe a tabela, duas
requisições idênticas exceto pela tabela passaram a colidir na mesma chave, e a segunda
recebia o preço da primeira por até 30 minutos
(`DEFAULT_CACHE_EXPIRATION_MINUTES = 30`, ajustável por `--cache-minutes=`).

**O defeito é desta alteração, não pré-existente.** O cache estava correto sob a invariante
antiga; a requisição removeu a invariante sem tocar no cache.

### 9.3 Dois campos que já faltavam

A auditoria da chave contra o contrato inteiro encontrou outros dois ausentes:
`codigoEmbalagem` e `volumeProduzido`. Ambos são argumentos diretos de
`fGetPrecoSugestaoTinta` (`Faturamento.Services.Pedido.pas:754-762`) — dos 8 atributos do
item que aquele cálculo consome, 6 estavam na chave.

Esses dois **são anteriores** à requisição e afetam apenas tinta: mesmo hash e mesma
embalagem produzida, variando volume ou código de embalagem, devolvia o preço do outro.

`brinde` também está fora da chave e **não** é defeito — é copiado da requisição e nunca
usado no cálculo. `id` é omitido corretamente: é identificador de correlação, e incluí-lo
levaria a taxa de acerto a zero.

### 9.4 Escopo da correção

Os três campos entram na chave. `tabPrecoGeral` chega por parâmetro novo `ATabPrecoGeral`
em `GetKey`, `TryGetCache` e `AddOrSetCache`; os dois chamadores em `fCalcularPrecosSugestao`
(`Faturamento.Services.Pedido.pas:884` e `:897`) passam `FPedido.tabPrecoGeral`.

`TPrecoSugestaoCache` é o único `TApiCacheBase` do serviço, então não há um segundo cache
com a mesma lacuna.

O mecanismo que permitiu o defeito continua em pé — ver seção 8.3.

### 9.5 Confirmação experimental

O campo funciona; era o cache respondendo. Com chave nova (quantidade inédita a cada
chamada), empresa 061, item 54693, `PREVE1=12,23` `PREVE2=13,05` `PREVE3=13,98`:

| quantidade | `tabPrecoGeral` | `precoTabela` |
|---|---|---|
| 1,37 | 2 | 13,05 |
| 2,41 | 3 | 13,98 |
| 3,53 | 1 | 12,23 |

E a colisão, repetindo quantidade já usada com outra tabela: `1,37` com tabela 3 devolveu
13,05, e `2,41` com tabela 1 devolveu 13,98 — o preço da chamada anterior.

### 9.6 Duas afirmações corrigidas durante a investigação

- **`/calcular-precos-sugeridos` respeita a tabela.** A leitura inicial de "campo inerte"
  era o cache.
- **O `tabPreco` do item não é ignorado ali por defeito.**
  `TPedidoCalcularPrecosSugestaoItem` não tem essa propriedade — enviá-la é campo
  desconhecido, descartado na desserialização. Não existe bug antigo nesse ponto.

### 9.7 Armadilha de bancada

A empresa 061 tem `CFG_TABPRC = SSSNNNN`: só as tabelas 1, 2 e 3 estão habilitadas. Testar
com tabela 4 a 7 ali não prova nada — e se o item escolhido tiver `PREVE1..3` iguais, como
o `34301` (1,10 nas três), o resultado parece "campo sem efeito" quando é "tabela recusada
mais preços idênticos".

Quem escrever caso de teste precisa de item com preço distinto **dentro** das tabelas
habilitadas da empresa.
