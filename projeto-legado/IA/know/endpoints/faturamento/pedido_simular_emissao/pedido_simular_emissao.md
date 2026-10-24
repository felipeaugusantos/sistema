# Endpoint `POST /api/pedido/simular-emissao` — contrato e de-para

Serviço: **Faturamento.Services.API**. Requisito de origem: **461523**.

Para quem grava um pedido nas tabelas do AUTCOM a partir da resposta deste endpoint, sem que o preço
mude quando o pedido for reaberto. Hoje o consumidor é o backend do Citel Sales; o contrato não é
específico dele.

Este documento é o contrato. Ao lado dele, `formacao_preco.md` explica **por que** a cadeia de
preço é assim — é a leitura de quem vai manter, não de quem vai consumir.

O raciocínio que levou a cada regra está em `IA/specs/461523/spec.md`.

---

## O problema que o endpoint resolve

O AUTCOM tem a configuração `CFG_CNDVEN`, por empresa, que decide **onde** a condição de pagamento
entra no preço:

| `CFG_CNDVEN` | Quando juros e desconto entram |
|---|---|
| `'I'` | no **início** — já embutidos no preço de tabela que a tela sugere |
| `'F'` | no **fim** — aplicados na totalização, sobre o preço praticado |

No Sales a condição é **sempre no fim**. Gravar o pedido com a distribuição errada entre os campos
faz o preço **mudar quando o pedido é reaberto no AUTCOM** — os valores são recalculados a partir de
`UNIDIG`, `TAXJUR`, `DESCON` e `DESCND`.

O endpoint recebe o pedido como o Sales o pratica e devolve **como o AUTCOM o gravaria**.

---

## Cabeçalho da requisição

| Campo | Tipo | Obrigatório | Observação |
|---|---|---|---|
| `codigoCliente` | string | sim | |
| `codigoCondicaoPagamento` | string | sim | |
| `enderecoEntregaID` | string | não | `AUTOINCREM` da `ENTCLI`. **Precisa ser do cliente do pedido** — senão `400` |
| `vendaPresencial` | boolean | sim | ver a armadilha abaixo |
| `tipoOperacao` | string | não | vazio, `USO/CONSUMO`, `REVENDA` ou `INDUSTRIALIZAÇÃO`. Outro valor → `400` |
| `descontoEspecial` | número | não | em **reais** |
| `despesasAcessorias` | número | não | em **reais** |
| `valorFrete` | número | não | em **reais** |
| `codigoTransportadora` | string | não | não informada, nenhuma é assumida |
| `tipoFrete` | string | não | |
| `tabPrecoGeral` | string | não | 1 a 7; fora disso → `400` |
| `items` | lista | sim | |

> **`vendaPresencial` é a chave de maior alcance do payload.** `true` significa retirada na loja e
> produz CFOP **interno** mesmo para cliente de outra UF, sem DIFAL. `false` para o mesmo cliente
> muda CFOP, alíquota e o bloco inteiro de partilha. **Não há erro em nenhum dos dois** — o valor
> errado apenas cobra imposto diferente.
>
> Medido: cliente de MG comprando de empresa de SP, `true` → CFOP 5102 e ICMS 34,80; `false` → CFOP
> 6108, ICMS 23,20 e DIFAL 11,60.

## Item da requisição

| Campo | Tipo | Obrigatório | Observação |
|---|---|---|---|
| `id` | inteiro | sim | volta igual na resposta — é como se casam requisição e retorno |
| `codigoItem` | string | sim | |
| `empresaItem` | string | não | vazio = empresa do header. Inexistente → `400` |
| `numeroLote` | string | não | **tem de existir para o item e a empresa** — senão `400` |
| `tabPreco` | string | não | 1 a 7 |
| `quantidade` | número | sim | |
| `precoOriginal` | número | sim | preço de tabela **limpo**, sem juros nem desconto de condição |
| `precoDigitado` | número | sim | preço praticado **limpo** |
| `descontoItem` | número | não | em **percentual** |
| `entregaRetira` | string | não | `E` ou `R`. Define quem participa do rateio do frete |
| `entregaFutura` | boolean | não | |
| `motivoEntregaFutura` | string | não | `F`, `A` ou `P`. Outro valor vira **vazio**, sem erro |
| `brinde` | boolean | não | |
| `promocao` | boolean | não | ver abaixo |
| `siglaTinta` · `hashMD5Tinta` · `embalagemProduzida` · `volumeProduzido` · `modoVenda` · `codigoDiluente` · `percentualDiluicao` · `codigoEmbalagem` | | | tinta. Informando `siglaTinta`, a `embalagemProduzida` passa a ser **obrigatória** |

> **Não existe `precoUnitario` na requisição.** O unitário é **derivado** de
> `precoDigitado × (1 − descontoItem/100)` e devolvido na resposta. Mandar o preço final já calculado
> não é possível — e é proposital: a conta é do AUTCOM.

---

## De-para: resposta → onde gravar

### Cabeçalho → `FATGOR`

| Campo da resposta | Coluna |
|---|---|
| `totalProdutos` | `FGO_TOTPRO` |
| `descontoEspecial` | `FGO_DESESP` |
| `despesasAcessorias` | `FGO_DESACE` |
| `valorFrete` | `FGO_TOTFRE` |
| `descontoProfissional` | `FGO_PORDES` (aplicado) e `FGO_DESCON` (sugestão) |
| `baseCalculoICMS` / `valorICMS` | `FGO_BASICM` / `FGO_TOTICM` |
| `baseCalculoIPI` / `valorIPI` | `FGO_BASIPI` / `FGO_TOTIPI` |
| `baseCalculoST` / `valorST` | `FGO_BASRET` / `FGO_TOTRET` |
| `valorTotal` | `FGO_VLRCON` |

Os campos `valorFCPST`, `baseCalculoFCP`, `valorFCP` e `valorDifalDestino` do cabeçalho são
**agregados** dos itens — não têm coluna própria na `FATGOR`, servem para conferência.

### Item → `FATDOR`

| Campo da resposta | Coluna |
|---|---|
| `precoOriginal` | `FDO_UNIORI` |
| `precoDigitado` | `FDO_UNIDIG` |
| `precoUnitario` | `FDO_UNITAR` |
| `descontoItem` | `FDO_DESCON` (%) |
| `totalProduto` | `FDO_TOTITE` |
| `valorTotal` | `FDO_VLRCON` |
| `descontoEspecial` / `valorFrete` / `despesaAcessoria` | `FDO_DESESP` / `FDO_TOTFRE` / `FDO_DESACE` |
| `promocao` | `FDO_PROMOC` |
| `entregaFutura` / `motivoEntregaFutura` | `FDO_ENTFUT` / `FDO_MOTFUT` |
| `incidePIS` | `FDO_INCPIS` |
| `cfop` / `cstICMS` | `FDO_CLAFIS` / `FDO_CODFIS` |
| `baseCalculoICMS` / `aliquotaICMS` / `valorICMS` | `FDO_BASICM` / `FDO_ALQICM` / `FDO_VALICM` |
| `baseCalculoIPI` / `aliquotaIPI` / `valorIPI` | `FDO_BASIPI` / `FDO_ALQIPI` / `FDO_VALIPI` |
| `baseCalculoST` / `aliquotaST` / `valorST` | `FDO_BASRET` / `FDO_ALQRET` / `FDO_VALRET` |

### Item → `EXTDOR` — chave `FDO_SEQFDO = FATDOR.AUTOINCREM`

| Campo da resposta | Coluna |
|---|---|
| `precoAVista` | `FDO_UNIVIS` |
| `unitarioAntesRateio` | `FDO_UNDIDE` |
| `descontoCondicao` | `FDO_DESCND` (%) |
| `taxaJuros` | `FDO_TAXJUR` (%) |
| `freteRateado` | `FDO_FRERAT` |
| `valorFCPST` | `FDO_VALFCP` |
| `entregaRetira` | `FDO_ENTRET` |

> O texto original do requisito mapeia `precoAVista`, `taxaJuros` e `descontoCondicao` como
> `FATDOR.FDO_*`. **Essas colunas não existem na `FATDOR`** — vivem na `EXTDOR`.

### Item → `DORICD` — chave `ICD_SEQFDO = FATDOR.AUTOINCREM`

Uma linha por item, **sempre** — mesmo sem DIFAL, com valores zerados.

| Campo da resposta | Coluna |
|---|---|
| `baseCalculoFCP` / `aliquotaFCP` / `valorFCP` | `ICD_BASFCP` / `ICD_PERFCP` / `ICD_VALFCP` |
| `valorDifalDestino` / `valorDifalOrigem` | `ICD_VALDES` / `ICD_VALORI` |
| `baseCalculoUFDestino` | `ICD_BCUFDE` |
| `aliquotaInternaDestino` / `aliquotaInterestadual` | `ICD_ALQUFD` / `ICD_ALQINE` |
| `percentualPartilha` | `ICD_PERPAR` |
| `fcpProduto` | `ICD_FCPPRO` — `'S'` = item **sem ST** |

### Informativos — não gravar

`cstIPI` · `cstPIS` · `baseCalculoPIS` · `aliquotaPIS` · `valorPIS` · `cstCOFINS` ·
`baseCalculoCOFINS` · `aliquotaCOFINS` · `valorCOFINS`

A `FATDOR` não tem coluna de COFINS, e de PIS só o flag `FDO_INCPIS`. Vão na resposta para
conferência e para uso em tela.

---

## Armadilhas — ler antes de implementar

**Frete: dois mecanismos, duas colunas.** No rateio comum o valor por item vai em `FDO_TOTFRE` e o
`FGO_TOTFRE` do cabeçalho **mantém** o total. No rateio por transportadora (`CADTRA.TRA_FREVEN='R'`)
o cabeçalho **zera** e o valor vai para `EXTDOR.FDO_FRERAT`. **Ler só `freteRateado` grava zero no
caminho comum.** Gravar os dois campos como vierem.

**Frete exclui a retira; desconto especial, não.** O frete rateia só entre itens de entrega; o
desconto especial rateia entre todos, proporcional ao valor.

**`precoOriginal` muda de significado com o `CFG_CNDVEN`.** No modo `'F'` é a tabela limpa. No modo
`'I'` vem **financiado** — tabela × juros, sem o desconto. Não presuma: grave o que vier.

**No modo `'I'` o `descontoCondicao` volta zero e o `taxaJuros` não.** O desconto já está embutido no
preço; o juros continua reportado porque alimenta o recálculo na reabertura. Gravar os dois como
vierem, inclusive o zero.

**Brinde zera o preço.** Informando `brinde: true`, a resposta traz `precoDigitado` e `precoUnitario`
em zero e mantém o `precoOriginal` — qualquer que tenha sido o preço enviado. É o que o AUTCOM grava.

**Promoção substitui o preço.** Com `promocao: true` e promoção ativa, o `precoOriginal` volta com o
**preço promocional** — o de tabela não sobrevive em campo nenhum. Informar `true` em item sem
promoção ativa devolve `400`: os dois lados leem a mesma base, e divergir significa que um está com
leitura errada.

**Alterar pedido não recalcula.** O AUTCOM não refaz o preço ao alterar um pedido gravado. Se o
pedido mudar no Sales, chamar o endpoint de novo e regravar.

---

## Erros

| Situação | HTTP |
|---|---|
| Lote inexistente para o item/empresa | 400 |
| `promocao: true` sem promoção ativa | 400 |
| `tipoOperacao` fora da lista | 400 |
| `enderecoEntregaID` que não é do cliente | 400 |
| `empresaItem` inexistente | 400 |
| `tabPreco` / `tabPrecoGeral` fora de 1..7 | 400 |
| Tinta sem `embalagemProduzida` | 400 |
| Configuração da empresa não suportada | 422 |

O `422` é distinto de propósito: a requisição está correta, o que não suportamos é a configuração do
servidor. Culpar o consumidor por configuração nossa manda procurar erro onde não há.
