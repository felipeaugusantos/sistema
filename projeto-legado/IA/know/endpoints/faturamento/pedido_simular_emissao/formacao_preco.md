# Endpoint `POST /api/pedido/simular-emissao` — formação do preço

Serviço: **Faturamento.Services.API**. Requisito de origem: **461523**.
Documento principal da pasta: `pedido_simular_emissao.md`, com o de-para dos campos.

Como o AUTCOM chega ao preço unitário gravado num item de pedido, e por que o mesmo produto pelo mesmo
valor final pode ser **escrito** de formas diferentes conforme a empresa. É o que este endpoint
reproduz.

> **A cadeia descrita aqui não é exclusiva deste endpoint.** É o comportamento do AUTCOM, que a tela
> de venda executa e que os outros services de pedido — `calcular-impostos`, `calcular-flex`,
> `validar-unitario`, `validar-pedido`, `validar-valor-minimo`, `calcular-total-desejado` — também
> percorrem, por herdarem do mesmo `TEmitirPedidoService`.
>
> A convenção do `know/` é documentar **por endpoint**, aceitando a cópia. Ao documentar um desses
> outros, copie a cadeia daqui em vez de apontar — e, ao corrigir uma regra, **procure as cópias**:
> `grep -l "UNDIDE" IA/know/`.

Escrito em 24/09/2026 a partir da investigação do Req. 461523. Tudo aqui foi verificado em código ou
em pedido emitido com configuração conhecida — ver §7.

---

## 1. A ideia central, sem código

Imagine duas lojas que vendem a mesma geladeira e cobram o mesmo no fim, mas escrevem o preço de
formas diferentes:

**Loja A — juros no início.** A etiqueta já diz **R$ 928**. O vendedor explica: "à vista sai 849, a
prazo é 928". O juros está **dentro** do preço.

**Loja B — juros no final.** A etiqueta diz **R$ 849**. No caixa o sistema soma o juros e fecha em
928. O juros está **fora** do preço, entra depois.

Mesma geladeira, mesmo valor final. Mas o que fica **escrito no pedido** é diferente: uma anota 928,
a outra anota 849.

É exatamente isso que a configuração **`CFG_CNDVEN`** decide:

| `CFG_CNDVEN` | Significado | O que vai no `FDO_UNIDIG` |
|---|---|---|
| `'I'` | condição no **início** | preço **com** juros e desconto da condição embutidos |
| `'F'` | condição no **final** | preço **limpo**; juros e desconto entram na totalização |

**Por que isso importa.** Quem grava um pedido precisa saber em qual modo está. Gravar 849 numa
empresa modo `'I'` faz o sistema entender que aquele já é o preço financiado — e some o juros. Ninguém
percebe até alguém conferir.

---

## 1.1 O que este documento cobre — e o que não

Cobre a cadeia **do preço praticado até o preço gravado**: o que acontece com um valor depois que
alguém decidiu vender por ele.

**Não cobre a formação do preço sugerido**, que é outra área inteira e maior: tabelas de preço 1 a 7,
custo e markup, margem mínima, preço de lote, desconto de embalagem fechada, regras de promoção,
preço por estrutura de produto, preço tintométrico. Tudo isso acontece **antes** e decide qual número
chega aqui.

Também não cobre faturamento — PIS, COFINS e CST de IPI só ganham colunas quando o pedido vira nota.

Se você está investigando "por que o sistema sugeriu este preço", este não é o documento. Se está
investigando "por que o preço mudou depois que salvei", é este.

## 2. A cadeia de preço

O preço unitário não é um número, é uma fila de fatores:

```
preço praticado                      849,00
  − desconto do item                 o vendedor deu 5%?
  × juros da condição                (embutido no preço se modo 'I'; aplicado aqui se 'F')
  − desconto da condição             boleto tem 3% de abatimento automático?
  − desconto do profissional         o cliente é arquiteto e tem percentual cadastrado?
  + frete rateado                    este item vai ser entregue?
  ────────────────────────────
preço unitário gravado (FDO_UNITAR)
```

Formalmente:

```
UNDIDE = UNIDIG × (1 − DESCON%)

base   = UNDIDE × juros            se CNDVEN = 'F'
       = UNDIDE                    se CNDVEN = 'I'   (juros já está no UNIDIG)

UNITAR = base × (1 − DESCND%)      se CNDVEN = 'F'
              × (1 − PORDES%)      desconto do profissional, sempre
              + FRERAT             frete rateado
```

---

## 3. Onde mora cada campo

O preço do item mora em **três** tabelas, não em uma:

| Tabela | Chave | O que guarda |
|---|---|---|
| `FATDOR` | `AUTOINCREM` | `UNIORI`, `UNIDIG`, `DESCON`, `UNITAR`, `TOTITE`, ICMS/IPI/ST |
| `EXTDOR` | `FDO_SEQFDO` | `UNIVIS`, `UNDIDE`, `DESCND`, `TAXJUR`, `FRERAT`, `VALFCP`, `ENTRET` |
| `DORICD` | `ICD_SEQFDO` | DIFAL e FCP |

E o desconto do profissional fica no **cabeçalho**, em `FATGOR.FGO_PORDES` (aplicado) e `FGO_DESCON`
(sugerido pelo cadastro do cliente).

**Erro comum:** procurar `FDO_UNIVIS`, `FDO_TAXJUR` ou `FDO_DESCND` na `FATDOR`. Não estão lá.

---

## 4. Os fatores, um a um

### Desconto do item — `FDO_DESCON`
Percentual. Aplicado direto sobre o `UNIDIG`, produzindo o `UNDIDE`.

### Juros — `FDO_TAXJUR`
Taxa efetiva = `(CND_TXJURO / 30) × prazo_médio`. Se `CND_TXJURO = 0`, usa `CFGSIS.TAXJUR`.

> **Armadilha: a mesma coluna carrega duas unidades.** Com `CFG_TIPJUR='S'` o `TAXJUR` é **percentual**
> (`9,33` = 9,33%). Com `'C'` é **fator** (`1,06` = +6%). Quem ler o campo sem checar o `TIPJUR`
> interpreta 6% como 1%.

O campo grava a taxa **efetivamente aplicada**, não a cadastrada — quando a promoção barra o juros,
grava zero.

### Desconto da condição — `FDO_DESCND`
Só existe se a condição tiver `CND_ABADES='S'`. No modo `'F'` é aplicado na totalização, lendo
`CND_DESMAX`. No modo `'I'` já vem embutido no preço.

### Desconto do profissional — `FGO_PORDES`
Vem de `CADCLI.CLI_DESCON`. **Campo não editável** na tela de venda — não é escolha do operador, é
propriedade do cliente. Habilitado por `CFG_CLIDES`, lida **por empresa do item**.

### Frete rateado — `FDO_FRERAT`
O frete do cabeçalho é **movido** para dentro dos itens e `FGO_TOTFRE` fica **zero**.

> **Armadilha:** quem ler `FGO_TOTFRE` para saber o frete do pedido lê zero. O valor está espalhado
> nos itens.

Só rateia se a transportadora tiver `TRA_FREVEN='R'` e houver frete digitado. Havendo ao menos um item
de entrega, rateia **só entre os de entrega**; não havendo nenhum, rateia entre todos.

### Promoção — `FDO_PROMOC`
O preço promocional **substitui** o de tabela em `UNIORI`, `UNIVIS` e `UNIDIG`. O preço de tabela
some do pedido, e o desconto da promoção não fica registrado em lugar nenhum — o único vestígio é a
marca `'S'`.

Além de preço, a promoção é **porteira**: com `CND_JURPRO='N'`, item em promoção não recebe juros.

### `FDO_UNDIDE` — cache, não regra
Criado na Req. **295758** (14/07/2023) para acelerar a carga de pedidos com muitos itens — o tempo
caiu de ~4 min para ~1 min. Guarda o unitário já líquido do desconto do item.

> **Obrigatório.** A carga usa `IF(IFNULL(FDO_UNDIDE,0)=0, FDO_UNIDIG, FDO_UNDIDE)`. Se estiver zerado,
> cai no `UNIDIG` — que é o preço **antes** do desconto. Todo item com desconto carrega pelo preço
> cheio, em silêncio.

Também é o valor unitário que alimenta o cálculo de ICMS-ST.

---

## 5. Releitura — por que o pedido pode "mudar sozinho"

Ao reabrir um pedido, o AUTCOM **recalcula** o preço em duas etapas:

1. `fUniDigDescontada(UNIDIG, TAXJUR, DESCON, DESCND, PROMOC)` reconstrói o unitário;
2. a totalização reaplica o desconto da condição (do cadastro) e o do profissional (do pedido).

Se os campos gravados forem inconsistentes entre si, o preço reconstruído difere do gravado. É a causa
raiz de "abri o pedido e o valor mudou".

**Alterar o pedido não recalcula o preço.** Verificado: alterar a quantidade de um item mantém
`UNIDIG`, `TAXJUR`, `PROMOC` e `UNITAR` idênticos.

---

## 6. Marcações que mudam a tributação

| Campo | Efeito |
|---|---|
| `FDO_ENTFUT = 'S'` | muda CFOP para `6922`/`5922` e o CST |
| `brinde` | zera `UNIDIG` e `UNITAR`, preserva `UNIORI`; CFOP `6910`/`5910` |
| `FDO_ENTRET` | **não** muda tributação — só define se o item participa do rateio do frete |
| `vendaPresencial` | desliga DIFAL e FCP (`fGravouDocumentoComDifal` exige não presencial) |

---

## 7. Como isto foi verificado

Tudo acima vem de código lido ou de pedidos emitidos em 24/09/2026 na base de programação, com
configuração conferida antes: `977`, `978`, `888`, `979`, `980`, `3229`, `3230`, `3231`, `3232` — e
documentos das empresas `071`/`072` da base de teste para o caso de juros composto.

> **O histórico do banco não serve para provar comportamento.** Ele mistura anos de versões de código,
> cadastros alterados depois da emissão e caminhos de gravação distintos. Durante esta investigação
> produziu **quatro** conclusões falsas, todas plausíveis à leitura. Use o banco para **achar cenário**
> — que cliente, item e condição existem — e estabeleça comportamento emitindo pedido controlado, com
> uma variável por vez.

---

## 8. Configurações que governam esta área

| Config | Efeito |
|---|---|
| `CFG_CNDVEN` | `'I'` ou `'F'` — onde juros e desconto da condição entram |
| `CFG_TIPJUR` | `'S'` juros simples (taxa em %) ou `'C'` composto (taxa como fator) |
| `CFG_TAXJUR` | taxa mensal padrão, quando a condição não tem a sua |
| `CFG_CLIDES` | habilita o desconto do profissional |
| `CFG_DECUNI` | casas decimais do unitário (2 a 10); o `ALTER` de precisão acompanha |
| `CFG_ZERFRE` | zera o frete quando só há itens de retira |
| `CFG_VALDIF` | habilita o cálculo de DIFAL |
| `CFG_TXJCNI` | `'1'` juros no preço sugerido, `'2'` juros no preço digitado |
| `opcoes.ini [GERAL] TXJCNI` | segunda tranca do `CFG_TXJCNI`; ausente, a config não vale |

`CFG_TXJCNI='2'` existe em **um único cliente** e altera três comportamentos ao mesmo tempo. Trate com
cuidado — ver `IA/specs/461523/spec.md` §10.
