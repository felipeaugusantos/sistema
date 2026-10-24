# Req. 461523 — `POST /pedido/simular-emissao`

Endpoint que recebe do **Citel Sales** os preços negociados e devolve **como o AUTCOM gravaria o
pedido**, conforme a configuração `CFG_CNDVEN` da empresa.

**Status:** spec consolidada em 24/09/2026. Marcação por origem da afirmação:

- **[V]** verificado — experimento controlado com config conhecida, ou leitura direta de código
- **[D]** decisão registrada, com autor e data
- **[?]** aberto

> **Método.** O banco serve para **achar cenário** (que cliente, item e condição existem), **nunca**
> para provar comportamento. O histórico mistura anos de versões, cadastros alterados depois da
> emissão e caminhos de gravação distintos — ao longo desta investigação produziu **quatro**
> conclusões falsas, todas plausíveis. Comportamento se estabelece emitindo pedido controlado, com
> uma variável por linha. Ver §11.

---

## 1. Problema

O backend do **Citel Sales** grava o pedido de venda. Ele não conhece `CFG_CNDVEN`, que define se
juros e desconto da condição de pagamento entram **no início** (`'I'`, embutidos no preço) ou **no
final** (`'F'`, aplicados na totalização). **No Sales a condição é sempre no fim**, e os preços que
ele pratica vêm limpos — sem juros e sem desconto de condição.

Se gravar de forma inconsistente com o que o AUTCOM espera, ao reabrir o pedido os preços divergem do
negociado com o cliente.

---

## 2. Princípios de desenho

**[D]** **O endpoint não altera o preço informado.** Mesma regra da guarda de r496501. O que o Sales
negociou é o que vale — inclusive para tinta, que também é consultada e ajustada lá.

**[D]** **Onde há decisão, o consumidor decide; onde há derivação, nós derivamos.** O critério não é
quem conhece a informação, é se existe escolha a fazer:

| Fator | Natureza | Origem |
|---|---|---|
| Transportadora, tipo de frete | escolha | payload |
| Valor do frete | escolha (o AUTCOM sugere, o Sales decide) | payload |
| Promoção | escolha — o Sales pode ignorar | payload |
| Desconto do profissional | **derivação** — campo não editável na tela | `CADCLI.CLI_DESCON` |
| Juros e desconto da condição | derivação | cadastro da condição |

**[D]** **O retorno contém o que se grava.** Exceção declarada: PIS, COFINS e `cstIPI` ficam por
decisão, marcados como informativos (§5.4).

**[D]** **Ler `CFG_CNDVEN` é exceção consciente** à regra "API de cálculo não lê config". O Sales não
pode informá-la — o conceito não existe lá, e é essa ignorância que o endpoint existe para cobrir.

---

> **Explicação didática do mecanismo:** `IA/know/formacao_preco_pedido.md`. Esta spec é o contrato do
> endpoint; aquele documento é como o AUTCOM forma o preço, escrito para quem nunca viu o assunto.

## 3. A cadeia de preço

**[V]** Validada em experimento controlado: pedidos `977`, `978`, `888`, `979`, `980`, `3229`,
`3230`, `3231`, `3232`.

```
── entrada do Sales: preço limpo ──

modo 'I':  UNIDIG = preço × juros × (1 − DESCND%)      ← embutidos no preço
modo 'F':  UNIDIG = preço                               ← limpos

── daí em diante, igual nos dois modos ──

UNDIDE = UNIDIG × (1 − DESCON%)

base   = UNDIDE × (1 + TAXJUR%)   se modo 'F'
       = UNDIDE                   se modo 'I'   (juros já está no UNIDIG)

UNITAR = base × (1 − DESCND%)     se modo 'F'
                × (1 − PORDES%)   desconto do profissional, sempre
                + FRERAT          frete rateado
```

**Juros — a fórmula depende de `CFG_TIPJUR`** (`fGetUnitarioComJurosAplicado`):

```pascal
If fCfgSis('TIPJUR') = 'C' Then Result := fltUnitario * fltTaxaJuros            // FATOR
Else                            Result := fltUnitario + fltUnitario*fltTaxaJuros/100;  // PERCENTUAL
```

**[V]** Com `TIPJUR='C'` a taxa é **fator, não percentual** — validado na base de teste, empresas `071`
e `072` (que têm `TIPJUR='C'`; na base de programação as 100 empresas são `'S'`):

| emp | `UNIVIS` | `TAXJUR` | `UNIDIG` | conta |
|---|---|---|---|---|
| 071 | 1,10 | **1,06** | 1,16 | `1,10 × 1,06 = 1,166` |
| 071 | 1,10 | **1,05** | 1,15 | `1,10 × 1,05 = 1,155` |
| 071 | 1,10 | **1,00** | 1,10 | sem juros |

> **Armadilha de contrato: a coluna `FDO_TAXJUR` carrega duas unidades.** Com `TIPJUR='S'` é
> percentual (`9,33` = 9,33%); com `'C'` é fator (`1,06` = +6%). Quem exibir ou reprocessar o campo
> sem checar o `TIPJUR` mostra 6% como 1%. **Tem de constar no Swagger do campo.**

**[V]** E **trunca, não arredonda**: `1,10 × 1,06 = 1,166` foi gravado como `1,16`. A implementação
precisa reproduzir o truncamento.

### 3.1 Evidência

| Pedido | Emp | `CNDVEN` | `UNIDIG` | `DESCON` | `DESCND` | `TAXJUR` | `PORDES` | `FRERAT` | `UNITAR` |
|---|---|---|---|---|---|---|---|---|---|
| 978 | 321 | I | 928,09 | 0 | 0 | 9,33 | 0 | 9,27 | 937,36 |
| 978 | 321 | I | 8,00 | 5 | 0 | 9,33 | 0 | 0,08 | 7,68 |
| 888 | 543 | F | 0,60 | 0 | 3,00 | 0 | 0 | 0 | 0,58 |
| 888 | 543 | F | 8,00 | 5 | 3,00 | 0 | 0 | 0 | 7,37 |
| 979 | 321 | I | 848,89 | 0 | 0 | 0 | **5,00** | 0 | **806,45** |
| 3232 | 000 | F | 85,00 | 0 | 0 | **4,00** | 0 | 0 | **88,40** |

No `978` o `UNIDIG` de 928,09 é `848,89 × 1,0933` — juros embutido, **não** reaplicado.
No `3232` o `UNITAR` é `85,00 × 1,04` — juros **aplicado** sobre o `UNIDIG` limpo.

---

## 4. Payload de entrada

### 4.0 [D] Precondição — o preço enviado é limpo

> **`precoOriginal`, `precoDigitado` e `precoUnitario` são o preço praticado LIMPO** — sem juros de
> condição de pagamento e sem desconto de condição aplicados. O endpoint aplica ambos conforme o
> `CFG_CNDVEN` da empresa. **Consumidor que já os tenha aplicado produzirá preço duplicado.**

**Por que isto precisa estar escrito.** A precondição vale hoje porque o primeiro consumidor é o
Citel Sales, onde a condição de pagamento é **sempre no fim** — então o preço que ele pratica é
naturalmente limpo. Mas isso é característica **dele**, não verdade universal. O endpoint não é do
Sales: qualquer integração que grave pedido na FATDOR — marketplace, SFA mobile, e-commerce — tem o
mesmo problema e é consumidor plausível. Se um deles enviar preço já com juros numa empresa em modo
`'I'`, o juros é aplicado duas vezes, em silêncio.

**[D] Tem de constar no Swagger**, na descrição do endpoint e nos três campos de preço — não só aqui.
É a única precondição do contrato que o consumidor não consegue inferir do nome do campo.

**Porta de saída, se um dia houver consumidor que não a cumpra:** um campo declarando o que o preço já
contém (`precoContemJuros`, `precoContemDescontoCondicao`). Hoje seria complexidade sem cliente —
registrado para não precisar ser redescoberto.

### 4.1 Cabeçalho

`codigoCliente` · `codigoCondicaoPagamento` · `enderecoEntregaID` · `vendaPresencial` ·
`tipoOperacao` · `descontoEspecial` · `despesasAcessorias` · `valorFrete` · `tabPrecoGeral` ·
**`codigoTransportadora`** · **`tipoFrete`**

**[V]** Os três valores monetários vêm em **reais**, não percentual.

**[D]** `codigoTransportadora` e `tipoFrete` são acréscimos ao requisito original. **Sem
transportadora informada, nenhuma é assumida** — não se usa o `CFG_TRASUG`. Justificativa em §7.4.

**[V]** `vendaPresencial = true` **desliga DIFAL e FCP** — `fGravouDocumentoComDifal` exige não ser
presencial. **Medido em 28/09/2026**, empresa `022` (SP), cliente `00101519` (MG), item `49357` a
`193,36`, contra o gabarito do pedido `345399`:

| `vendaPresencial` | CFOP | `valorICMS` | `baseCalculoUFDestino` | `valorDifalDestino` | `valorFCP` |
|---|---|---|---|---|---|
| `true` | 5102 | 34,80 | 0 | 0 | 0 |
| `false` | 6108 | 23,20 | 193,36 | 11,60 | 3,87 |

Com `false` os dez campos batem o pedido `345399` na vírgula. É a chave de maior alcance do payload:
sozinha ela troca CFOP, alíquota e o bloco inteiro de partilha, **sem erro nenhum** — o `true` é venda
presencial, retirada na loja, e aí o CFOP interno está correto mesmo para cliente de outra UF. Um
payload errado aqui não falha, só cobra imposto diferente.

**Não entram no payload, por derivação:** vendedor e digitador (vêm do usuário do header da request),
espécie (sempre `'PD'`), datas (`VS_Date`), desconto do profissional (§7.3).

### 4.2 Item

`id` · `codigoItem` · `empresaItem` · `numeroLote` · `tabPreco` · `quantidade` · `precoOriginal` ·
`precoDigitado` · `descontoItem` · `precoUnitario` · `entregaRetira` · `entregaFutura` ·
`motivoEntregaFutura` · `brinde` · **`promocao`** · e os de tinta (`siglaTinta`,
`embalagemProduzida`, `volumeProduzido`, `modoVenda`, `codigoDiluente`, `percentualDiluicao`,
`codigoEmbalagem`, `hashMD5Tinta`)

**[D]** `descontoItem` é sempre **percentual**.

**[D]** `promocao` é acréscimo. Hoje a API resolve sozinha; passa a vir do consumidor (§7.5).

---

## 5. Retorno

### 5.1 Cabeçalho

| Campo | Destino |
|---|---|
| `totalProdutos` | `FGO_TOTPRO` |
| `descontoEspecial` | `FGO_DESESP` |
| `valorFrete` | `FGO_TOTFRE` — **zerado quando há rateio** (§7.4) |
| `despesasAcessorias` | `FGO_DESACE` |
| **`descontoProfissional`** | `FGO_PORDES` (aplicado) e `FGO_DESCON` (sugestão) |
| `baseCalculoICMS` / `valorICMS` | `FGO_BASICM` / `FGO_TOTICM` |
| `baseCalculoIPI` / `valorIPI` | `FGO_BASIPI` / `FGO_TOTIPI` |
| `baseCalculoST` / `valorST` | `FGO_BASRET` / `FGO_TOTRET` |
| `valorTotal` | `FGO_VLRCON` |
| `valorFCPST` | agregado `SUM(EXTDOR.FDO_VALFCP)` |
| `baseCalculoFCP` / `valorFCP` / `valorDifalDestino` | agregados `SUM(DORICD.*)` |

### 5.2 Item — cadeia de preço

| Campo | Destino |
|---|---|
| `precoOriginal` | `FATDOR.FDO_UNIORI` |
| `precoAVista` | `EXTDOR.FDO_UNIVIS` |
| `precoDigitado` | `FATDOR.FDO_UNIDIG` |
| `descontoItem` | `FATDOR.FDO_DESCON` (%) |
| `unitarioAntesRateio` | `EXTDOR.FDO_UNDIDE` — **obrigatório** e **derivado**, ver §7.6 |
| `descontoCondicao` | `EXTDOR.FDO_DESCND` (%) |
| `taxaJuros` | `EXTDOR.FDO_TAXJUR` (% **efetivo**, não cadastrado) |
| `freteRateado` | `EXTDOR.FDO_FRERAT` |
| `precoUnitario` | `FATDOR.FDO_UNITAR` |
| `totalProduto` | `FATDOR.FDO_TOTITE` |
| `descontoEspecial` / `valorFrete` / `despesaAcessoria` | `FDO_DESESP` / `FDO_TOTFRE` / `FDO_DESACE` |
| `valorTotal` | `FATDOR.FDO_VLRCON` — fórmula, ver §6.2 |

### 5.3 Item — marcações e fiscal

| Campo | Destino |
|---|---|
| `promocao` | `FATDOR.FDO_PROMOC` |
| `entregaFutura` / `motivoEntregaFutura` | `FDO_ENTFUT` / `FDO_MOTFUT` |
| `entregaRetira` | `EXTDOR.FDO_ENTRET` |
| `incidePIS` | `FATDOR.FDO_INCPIS` |
| `cfop` / `cstICMS` | `FDO_CLAFIS` / `FDO_CODFIS` |
| `baseCalculoICMS` / `aliquotaICMS` / `valorICMS` | `FDO_BASICM` / `FDO_ALQICM` / `FDO_VALICM` |
| `baseCalculoIPI` / `aliquotaIPI` / `valorIPI` | `FDO_BASIPI` / `FDO_ALQIPI` / `FDO_VALIPI` |
| `baseCalculoST` / `aliquotaST` / `valorST` | `FDO_BASRET` / `FDO_ALQRET` / `FDO_VALRET` |
| `valorFCPST` | `EXTDOR.FDO_VALFCP` |
| `baseCalculoFCP` / `aliquotaFCP` / `valorFCP` | `DORICD.ICD_BASFCP` / `ICD_PERFCP` / `ICD_VALFCP` |
| `valorDifalDestino` / `valorDifalOrigem` | `DORICD.ICD_VALDES` / `ICD_VALORI` |
| `baseCalculoUFDestino` | `DORICD.ICD_BCUFDE` |
| `aliquotaInternaDestino` / `aliquotaInterestadual` | `DORICD.ICD_ALQUFD` / `ICD_ALQINE` |
| `percentualPartilha` | `DORICD.ICD_PERPAR` |
| `fcpProduto` | `DORICD.ICD_FCPPRO` — `'S'` = item **sem ST** |

### 5.4 Item — informativo, não gravado no pedido

`cstIPI` · `cstPIS` · `baseCalculoPIS` · `aliquotaPIS` · `valorPIS` · `cstCOFINS` ·
`baseCalculoCOFINS` · `aliquotaCOFINS` · `valorCOFINS`

**[V]** A FATDOR não tem coluna de COFINS, e de PIS só o flag `FDO_INCPIS`. `cstIPI` deriva da
tributação do produto e só vira coluna no faturamento (`DETNOT.DET_CSTIPI`).

### 5.5 Acréscimos ao requisito original

`unitarioAntesRateio` · `freteRateado` · `descontoProfissional` · `incidePIS` · `entregaRetira` ·
`promocao` · `valorDifalOrigem` · `baseCalculoUFDestino` · `aliquotaInternaDestino` ·
`aliquotaInterestadual` · `percentualPartilha` · `fcpProduto` — **doze campos**, todos necessários
para gravar. `valorRT` foi **removido** (§7.7).

---

## 6. Escopo de gravação — quatro destinos

| Tabela | Chave | Conteúdo |
|---|---|---|
| `FATGOR` | — | totais e descontos do cabeçalho |
| `FATDOR` | `AUTOINCREM` | preço e ICMS/IPI/ST do item |
| `EXTDOR` | `FDO_SEQFDO = FATDOR.AUTOINCREM` | `UNIVIS`, `UNDIDE`, `DESCND`, `TAXJUR`, `FRERAT`, `VALFCP`, `ENTRET` |
| `DORICD` | `ICD_SEQFDO = FATDOR.AUTOINCREM` | DIFAL e FCP |

> **Correção ao texto do requisito:** ele mapeia `precoAVista`, `taxaJuros` e `descontoCondicao` como
> `FATDOR.FDO_*`. **Essas colunas não existem na FATDOR** — vivem na `EXTDOR`.

### 6.1 DORICD

**[V]** `ICD_SEQFDO` é PK sozinha → **uma linha por item, no máximo**. O `WHERE ICD_FCPPRO='S'` do
requisito é filtro sobre a linha única, não seleção entre várias.

**[V]** A linha é criada para **todo item**, mesmo sem DIFAL (valores zerados, alíquotas ainda
gravadas). Gate em `fGravouDocumentoComDifal`: exige `CFG_VALDIF`, `fAtendeRegrasDIFAL`, **não
presencial**, não multi-loja; pula item de serviço.

**[V]** O cálculo **já roda no caminho da API** — `pCalculaGravaICMSUFDestino` é chamada com
`strTabela` vazio de dentro do `pCalculaTotGerInterna`, e nesse modo só calcula. Falta expor.

**[V]** Conferido no pedido `979`: `806,45 × (18% − 12%) = 48,39` = `ICD_VALDES`, com
`ICD_PERPAR = 100%` mandando tudo ao destino.

### 6.2 `FDO_VLRCON` é fórmula

```pascal
(fltTotIte - fltDesEsp) + fltValFre + fltValIpi + fltValRet + fltDesAce
  + IIF((fltValRet > 0), recDifalFCP.fltValFcp, 0)
```

---

## 7. Regras por fator

### 7.1 Juros

**[V]** Taxa efetiva = `(CND_TXJURO / 30) × prazo_médio`, simples ou composta conforme `CFG_TIPJUR`.
Se `CND_TXJURO = 0`, cai em `CFGSIS.TAXJUR` da empresa.

**[V]** Três predicados distintos, todos exigindo `CNDVEN='I'`:

| Predicado | Definição |
|---|---|
| `fAplicarTaxaJurosPrecoSugestao` | `CNDVEN='I'`; e se ini `TXJCNI=S`, também `TXJCNI='1'` |
| `fAplicarTaxaJurosPrecoDigitado` | só com ini `TXJCNI=S`, e então `CNDVEN='I'` **e** `TXJCNI='2'` |
| `fAplicaTaxaJuros` | `not ((CND_JURPRO='N') and (promoção ou combo))` |

**[V]** `FDO_TAXJUR` grava a taxa **efetivamente aplicada**, não a cadastrada — nos pedidos `3229`
(barrado) e `3230` (aplicado), mesma condição de 20%, gravou `0,00` e `4,00` respectivamente.

### 7.1.1 [V] CORREÇÃO — quem liga o juros é a tela, não a config

Uma versão anterior desta spec afirmava que o disjunto `(blnTaxVpr) And (CNDVEN='F')` da guarda em
`pAplicaTaxaJurosUnitario` era **contradição lógica e inalcançável**, porque `blnTaxVpr` só é `True`
com `CNDVEN='I'`. **Errado, e descoberto exercitando o endpoint em 26/09/2026.**

Ele é inalcançável **pelo caminho da config**. Mas a tela de fechamento liga a flag **diretamente**
(`untFatDadosFechamentoPedido`, dentro do `If pnlCondicaoPagamento.Visible`):

```pascal
objVenda.pAtualizaInformacoesCondPagamento;
objVenda.pCalculaTaxVpr;        // calcula a taxa
objVenda.blnTaxVpr := True;     // liga sem passar pela config
objVenda.blnDeCndF := True;
```

**Consequência para o endpoint:** desligar a supressão (`fPreservaPrecoInformado = False`) **não
basta**. Sem `pCalculaTaxVpr`, o `fltTaxVpr` fica zero e o juros não existe no modo `'F'`, mesmo com a
condição tendo taxa cadastrada. O service tem de **replicar as quatro linhas da tela** antes de
totalizar.

> É a terceira vez que o mesmo padrão aparece: comportamento que parece vir da configuração vem, na
> verdade, da tela. Ver também §7.3 (desconto do profissional) e §4.10 (transportadora). **Numa API
> sem tela, "o que a config diz" e "o que o AUTCOM faz" são coisas diferentes.**

### 7.2 Desconto da condição

**[V]** No modo `'F'` é aplicado na totalização, lendo `CND_DESMAX` do cadastro. No modo `'I'` vem
embutido no preço, quando `CND_ABADES='S'` — `fVerificaAbateDescontoAutomaticamente`.

**[V]** Esse abatimento é **desligado** por `fAplicarTaxaJurosPrecoDigitado` (`TXJCNI='2'`) e por
`fUsandoF3PuroComCondicaoNoFinal`.

### 7.2.1 [V] O gross-up do `:925` é artefato de ordem, e a API tem que desfazê-lo

`TEmitirPedido.fInserirProduto:925` infla o `fltUniDig` por `1/(1 - fltPerDes/100)` quando a condição
já é conhecida **no momento em que o item entra**.

Na tela, no modo `'F'`, isso **nunca dispara** — e não por acaso: a tela **não tem como** perguntar a
condição antes, ela só aparece no fechamento. Quando o item entra,
`fRetPercentualDescontoCondPagamento` devolve necessariamente zero.

**Prova direta — pedido `351762`,** emitido no AUTCOM em 28/09/2026 exatamente para decidir isto:
empresa `022`, condição `245` (10% de juros + 10% de desconto automático), item `49357` digitado a
`193,36`.

| | AUTCOM | API antes da correção |
|---|---|---|
| `FDO_UNIORI` | 193,36 | 193,36 |
| `FDO_UNIDIG` | **193,36** | **214,84** |
| `FDO_UNITAR` | 191,42 | 191,42 |
| `FDO_TOTITE` | 191,42 | 191,42 |

O preço final e o total já batiam; só o `UNIDIG` divergia. **E ele é a semente do round-trip:**
recarregar `214,84` e reaplicar os dois fatores dá `212,69`, não os `191,42` gravados — o preço subiria
a cada reabertura.

**Por que a evidência precisou ser um pedido novo.** Não existe **um único** pedido na base com
`CND_ABADES='S'` e `CND_DESMAX>0` — o cenário nunca tinha sido exercitado. A consulta histórica não
podia responder nem que fosse bem feita.

**Cuidado ao ler o comentário do legado.** O bloco em `TEmitirPedido:921-925` afirma que gravar o
`UNIDIG` bruto é deliberado, "para não duplicar o desconto na alteração do pedido". Isso descreve o
fluxo de **alteração**, onde a condição de fato já é conhecida. Lido fora desse contexto, o comentário
diz o oposto do que o pedido `351762` mostra. Foi o que me fez, por um momento, concluir que 214,84
estaria certo.

**Correção:** `fPrecoDigitadoInformado` reconstrói o valor a partir do payload, aplicando a mesma
transformação da inserção (`fAplicarCondicaoNoPrecoQuandoModoInicio`, que só faz algo no modo `'I'`).
Não mexi no `TEmitirPedido` — a inflação é legítima onde ela foi escrita.

> **Desfazer na matriz não funciona, e a tentativa custou um ciclo inteiro.** Escrever em
> `fatVenda.arrMatItens[i].fltUniDig` depois do laço de inserção não tem efeito: a matriz é
> **recarregada do dataset temporário** durante a totalização (`TFatVendaBase:87423`, que repovoa
> `Itens[].intSeqInc` a partir de `ITE_SEQINC`), e a escrita em memória se perde. O valor de registro
> mora no dataset, não na matriz.

### 7.2.2 [V] O modo `'I'` não é o espelho do `'F'` — dois achados

**Prova — pedido `100990010`,** empresa `040` (`CNDVEN='I'`), condição `245`, item `49357`, tabela
`193,36`. O operador aceitou o preço que a tela sugeriu: `191,43`.

| | `'F'` — pedido `351762` (emp `022`) | `'I'` — pedido `100990010` (emp `040`) |
|---|---|---|
| `FDO_UNIORI` | 193,36 | **212,70** |
| `FDO_UNIDIG` | 193,36 | **191,43** |
| `FDO_UNITAR` | 191,42 | **191,43** |

**(a) O `UNIORI` muda de significado com o `CNDVEN`.** No modo `'I'` ele guarda o preço de tabela
**financiado** — `193,36 × 1,10 = 212,70` —, com os juros mas **sem** o desconto da condição. O
desconto é negociação sobre o preço praticado, não sobre a tabela. No modo `'F'` o `UNIORI` guarda a
tabela limpa.

Controle que fecha a leitura: na condição neutra (`001`) o endpoint devolve `precoOriginal = 193,36` na
mesma empresa `040` — ou seja, a tabela lá é 193,36 mesmo, e os 212,70 são juros, não outro preço.

**Consequência para a API:** o Sales manda `precoOriginal` e **não conhece `CNDVEN`**. Aplicar os dois
fatores ao `UNIORI` — que era o que o endpoint fazia — o derrubava para `191,43` e apagava a referência
do preço cheio. Corrigido: `fAplicarCondicaoNoPrecoQuandoModoInicio` ganhou
`AblnAplicarDescontoCondicao`, `False` só para o `UNIORI`.

**(a.1) [V, 29/09/2026] No modo `'I'` o desconto some do reporte, mas o JUROS continua reportado.**

| Pedido | Modo | `FDO_DESCND` | `FDO_TAXJUR` |
|---|---|---|---|
| `351762` (emp `022`) | `'F'` | 10,00 | 10,00 |
| `100990010` (emp `040`) | `'I'` | **0,00** | **10,00** |

O endpoint devolvia **zero nos dois** no modo `'I'`. O desconto estava certo; o juros, errado.

**Não é detalhe de exibição.** `FDO_TAXJUR` é entrada do `fUniDigDescontada` (§8), que recalcula o
preço quando o pedido é **reaberto**. Gravar zero onde o AUTCOM grava 10 faz o preço mudar na
reabertura — exatamente o defeito que este requisito existe para eliminar.

**Corrigido:** a taxa aplicada em `fAplicarCondicaoNoPrecoQuandoModoInicio` passa a ser guardada por
item e tem precedência no retorno; no modo `'F'` continua vindo da matriz.

> **Como apareceu:** o João perguntou se o caso de tinta usava juros ou desconto. Não usava — eu tinha
> escolhido a condição `171`, que é à vista. Ao refazer com a `245` e conferir contra a `EXTDOR`, a
> divergência saltou. A pergunta dele valeu um bug que nenhum dos 33 casos pegava.
>
> **Por que nenhum caso pegava:** todos afirmavam preço, e o preço estava certo. Nenhum afirmava
> `descontoCondicao` nem `taxaJuros`. A bateria passou a afirmar os dois nos dois modos — 33 → 37
> asserções.

**(a.2) [V, 29/09/2026] A tinta segue a mesma cadeia — validado nos DOIS modos.**

Mesma fórmula (`LAZ`, `ESP 00100012`, item `44540`), preço `77,10`, condição `245`:

| | `593` — emp `061`, modo `'I'` | `12195` — emp `060`, modo `'F'` |
|---|---|---|
| `FDO_UNIORI` | 84,81 | **77,10** |
| `FDO_UNIDIG` | 76,33 | **77,10** |
| `FDO_UNITAR` | 76,33 | 76,33 |
| `FDO_DESCND` | 0,00 | **10,00** |
| `FDO_TAXJUR` | 10,00 | 10,00 |

Os dois chegam ao mesmo preço praticado por caminhos diferentes: o `'I'` financia o `UNIORI`, o `'F'`
reporta os fatores. **Idêntico ao item comum** (`100990010` e `351762`) — a tinta não perturba a
cadeia.

**O `'F'` com tinta confirma que o gross-up também não dispara ali:** `UNIDIG` saiu `77,10` limpo, e
não `85,67` (`77,10 / 0,90`). Sem este pedido eu estaria assumindo que a correção do §7.2.1, feita
contra item comum, valia para preço vindo de fórmula.

**Endpoint conferido contra os dois: 10 de 10 campos.**

**(b) O centavo de diferença é a ordem do arredondamento, e os dois estão certos.**

| Modo | Caminho | Resultado |
|---|---|---|
| `'I'` | arredonda o intermediário: `193,36 × 1,10 = 212,70`, depois `× 0,90` | **191,43** |
| `'F'` | carrega a precisão: `193,36 × 1,10 × 0,90 = 191,4264`, trunca no fim | **191,42** |

Não é divergência a corrigir — é o AUTCOM se comportando diferente em cada modo, e o endpoint
reproduz os dois. **Um caso de aceitação que compare os modos pelo valor final vai reprovar
indevidamente** se esperar o mesmo centavo nos dois.

### 7.3 Desconto do profissional

**[V]** `CADCLI.CLI_DESCON`, rotulado "Desconto para Profissionais". Campo **não editável** na tela
de venda — logo é derivação, não decisão, e o endpoint deve aplicá-lo sempre.

**[V]** Gate: `fUsaDescontoProfissional = (CFG_CLIDES = 'S') And (Not fDocumentoParaFornecedor)`. A
config é lida **por empresa do item** (`GetEmpCfg(strEmpIte)`) — em pedido multi-empresa pode valer
para uns itens e não para outros.

**[V]** Gravado no cabeçalho: `FGO_PORDES` (aplicado) e `FGO_DESCON` (sugestão). Na carga o AUTCOM
relê **do pedido**, não do cadastro — então alterar o `CLI_DESCON` depois **não** faz o pedido
divergir.

### 7.4 Frete

> **[V, 28/09/2026] São DOIS mecanismos, não um — e a spec só descrevia o segundo.**
>
> | | Cabeçalho | Item | Quando |
> |---|---|---|---|
> | **Rateio comum** | `FGO_TOTFRE` **mantém** o valor | `FDO_TOTFRE` | transportadora sem `TRA_FREVEN='R'` |
> | **Rateio por transportadora** | `FGO_TOTFRE` **zera** | `EXTDOR.FDO_FRERAT` | `fDeveExecutarRateioFreteTransportadoraNosItens` |
>
> Medido no pedido `351768` (empresa `022`, transportadora `00140`, tipo de frete `1`, frete `10,00`):
> `FGO_TOTFRE = 10,00`, item de Entrega com `FDO_TOTFRE = 10,00`, item de Retira com `0,00`, e
> **`FDO_FRERAT = 0,00` nos dois**. Ou seja, o caminho comum.
>
> **O retorno cobre os dois, e está correto** — medido contra o `351768`: `valorFrete` do item devolveu
> `10,00` e `0,00` (o `FDO_TOTFRE` de cada), e `freteRateado` devolveu `0,00` nos dois, igual ao
> `FDO_FRERAT` gravado.
>
> **A armadilha é de leitura, não de cálculo.** Quem integrar e ler só `freteRateado` para gravar o
> frete escreve zero no caminho comum. Os dois campos precisam estar descritos no Swagger dizendo
> **quando** cada um é preenchido.

**[V]** Quando `fDeveExecutarRateioFreteTransportadoraNosItens`, o frete do cabeçalho é **movido**
para os itens (`FRERAT`) e **`FGO_TOTFRE` fica zero**.

```pascal
fRateiaFreteItensTransportadora := (CADTRA.TRA_FREVEN = 'R') And fTipoDeFreteEfetuaRateio(...)
fDeveExecutarRateio := fRateiaFreteItensTransportadora(strCodTra, strTipFre) And (fltValFre > 0)
```

`fTipoDeFreteEfetuaRateio` consulta `FRERAO` por transportadora; **sem linha lá, devolve `True`** — o
tipo de frete só é consultado quando há configuração.

> **Armadilha:** se o Sales ler `FGO_TOTFRE` para gravar o frete, grava zero e perde o valor.

**[V]** Rateado **apenas entre itens marcados para Entrega** — no pedido `980` a linha de Entrega
recebeu os 16,98 inteiros e a de Retira ficou com zero. Logo `entregaRetira` tem **efeito cruzado**:
mudar uma linha redistribui o frete de todas.

**[V] E se não houver nenhum item de entrega, rateia entre todos.** Não é config, é automático:

```pascal
blnRateiaFreSomItensEnt := False;
For intItem := 0 To Length(Itens)-1 Do
  If Not blnRateiaFreteDespAcessoriaSomenteItensNotaNormal And fItemEntrega(Itens[intItem]) Then
  Begin  blnRateiaFreSomItensEnt := True;  Break;  End;
```

A restrição "só itens de entrega" só liga quando **existe** ao menos um item de entrega. Com todos em
retira, o frete não se perde — é distribuído entre eles. O comentário no código explica o porquê: no
desmembramento da venda o frete vai só para o documento de entrega.

**[V]** Exceção: `CFG_ZERFRE='S'` **zera** o frete quando o pedido só tem itens de retira
(`fPossuiSomenteItensRetira`). Nesse caso o `valorFrete` enviado é descartado — e o retorno precisa
refletir isso, senão o Sales grava um frete que o AUTCOM não considerou.

### 7.4.2 [V] Desconto especial rateia por valor — e inclui a Retira

Pedido `351768`, desconto especial de `20,00` sobre dois itens:

| Item | Total | `FDO_DESESP` | Destino |
|---|---|---|---|
| `49357` | 193,36 | **11,69** | Entrega |
| `49358` | 137,44 | **8,31** | Retira |

`193,36 / 330,80 × 20 = 11,691` e `137,44 / 330,80 × 20 = 8,309`. Rateio proporcional ao valor.

**A diferença que importa:** o frete exclui o item de Retira; o desconto especial **não**. Duas regras
de rateio no mesmo pedido, e um caso de teste que só olhe o total não distingue as duas.

### 7.4.3 [D] Despesa acessória vem do payload

**Decisão do João, 28/09/2026:** o campo **permanece como entrada**. O consumidor informa o valor.

Chegamos a implementar a derivação e ela foi revertida — o registro fica porque o levantamento
continua válido e explica o comportamento da tela.

**Por que o campo aparece desabilitado na tela de venda:** o gate é `CADCLI.CLI_CODEAC = 'S'`
("Cobrar despesas acessórias do cliente"). Com `'N'`, o `Else` de
`untDadosFechamentoPedidoTransportadoraFrame` faz `edtDesAce.Enabled := False`. Havendo `'S'`, o valor
é **calculado** — `CND_VRDAUV` + `CND_PEDEAC`% sobre o total + prazo + `CFG_VLDEAC` — e o campo vira
`ReadOnly` se o resultado for maior que zero. O operador só digita quando a conta dá zero, e ainda
depende de `CFG_ALDAVF`.

**Conferido no pedido `351769`:** empresa `022`, cliente `00102841` (`CLI_CODEAC='S'`), condição `002`
(`CND_PEDEAC = 1,00` — a **única** da base com o campo preenchido), item `49357` a `193,36` →
`FGO_DESACE = 1,93`, exatamente 1%.

> **Consequência assumida:** o valor que o consumidor mandar é gravado como veio, e pode divergir do
> que a tela calcularia para o mesmo cliente e condição. Quem integra precisa saber disso — está no
> Swagger do campo.

A fórmula canônica é `fCalculaDesAceCndPagConfDocs`, em `untFuncoes`. **Essa unit não faz parte do
`FaturamentoServicesAPI`** — só o `ConsultarPagamentosPixService` a inclui entre os serviços Linux.
Se um dia a derivação voltar à mesa, a escolha é entre acrescentar a unit ao `.dpr` (15.523 linhas,
risco de sombreamento silencioso de nomes) ou duplicar a conta.

### 7.4.1 [D] Desconto de embalagem fechada — fora de escopo

`descontoEmbalagemFechada` aparece no retorno do endpoint de sugestão de preço, valor e percentual.
**[V]** É aplicado na **formação do preço** (`fVerificaEmbalagemFechadaItemPromocao`, chamada de dentro
do `fPegaPrecoVenda`), **não** na totalização — logo não há risco de dupla aplicação.

**[D, João 24/09/2026]** É regra do Sales: ele recebe o percentual do endpoint de sugestão e aplica ao
formar o preço, que chega aqui já ajustado. Fora do escopo deste endpoint.

### 7.5 Promoção

**[V]** O preço promocional **substitui** o de tabela em `UNIORI`, `UNIVIS` e `UNIDIG` — pedidos
`3231`/`3232`: tabela 100,00, promoção 85,00, e o 100,00 não aparece em lugar nenhum. O desconto da
promoção **não fica registrado**; o único vestígio é `FDO_PROMOC`.

**[V]** O juros incide sobre o preço promocional: `88,40 = 85,00 × 1,04`.

**[V]** `FDO_PROMOC` é porteira do juros — `fPermiteAplicarJurosNaPromocao = not ((CND_JURPRO='N')
and (promoc='S'))` — e do desconto da condição.

**[D]** Vem do payload. O Sales já consulta preço sugerido por endpoint nosso e pode ter regra própria
para ignorar a promoção; a decisão é dele. **Validação:** bloquear `promocao: true` em item que o
AUTCOM não considera promocional; **permitir** `false` em item promocional. Seguro porque AUTCOM e
Sales compartilham a mesma base e não há promoção que nasça no Sales.

**[V, 28/09/2026] O endpoint SUBSTITUI o `precoOriginal` pelo promocional — não ecoa o informado.**
Pedido `351765` (empresa `022`, item `24001`, tabela `59,00`, promoção `50,00`, condição `001`):
`FDO_UNIORI`, `FDO_UNIDIG` e `FDO_UNITAR` saíram **todos 50,00**. O preço de tabela não sobrevive em
campo nenhum.

Consequência: quem mandar `promocao: true` com o preço cheio recebe `50,00`, não `59,00` — senão o
pedido gravado divergiria do que o AUTCOM produz. Implementado via `fResolverPromocao`, que passou a
receber também o `fltProVen` do AUTCOM.

**A substituição só ocorre quando o consumidor afirma a promoção.** `promocao: false` em item que
*tem* promoção cadastrada devolve o preço de tabela — preserva o direito do Sales de ignorá-la, que é
a decisão registrada acima.

> **Armadilha de cadastro que custou uma manhã.** A promoção só é encontrada quando
> `ITEPRO.IPR_PRZMED` cobre o prazo médio da condição — `CFG_PRZPRO='S'` liga essa comparação. Uma
> promoção criada com `IPR_PRZMED = 0` **aparece na tela antes de a condição ser escolhida** e some
> depois, e a API — que sempre recebe condição — nunca a vê. Não é bug: é a mesma armadilha de ordem
> do §7.2.1. Ao montar cenário de promoção para teste, conferir o prazo médio do item da promoção.

**[D, 28/09/2026] Por que a promoção recusa e as outras marcações não.** O endpoint trata três
marcações incoerentes de formas diferentes, e a assimetria é deliberada:

| Marcação | Payload incoerente | Tratamento |
|---|---|---|
| `brinde` | preço maior que zero | **deriva** — zera, como a tela |
| `descontoItem` | — | **deriva** — o unitário é calculado |
| `promocao: true` | item sem promoção ativa | **recusa com 400** |

A diferença não é de gravidade, é de **quem tem a informação**. Em `brinde` e `descontoItem` o Sales
afirma algo sobre a **venda dele** — é dono do fato, e nós só traduzimos para a forma que o AUTCOM
gravaria. Em `promocao` ele afirma algo sobre o **AUTCOM**, e esse fato nós conferimos.

> Critério do João: *"nesse caso é melhor dizer pra ele que não está em promoção, alguém está
> mentindo, pode ser o Sales ou a API, então um vigia o outro"*.

Os dois lados leem a mesma base. Divergir significa que um dos dois está com leitura errada — devolver
200 com preço diferente do informado esconderia isso, e o Sales gravaria o pedido sem perceber.

**[V] Deficiência conhecida:** `fGetStatusPromocaoItem` passa `fltQtdJaDig` e `fltQtdJaEmPromoc`
fixos em zero. Promoção com **limite coletivo de quantidade** é avaliada por item como se nada mais
existisse no pedido. A API não tem condições de calcular promoção coletiva.

### 7.5.1 [V, 28/09/2026] `numeroLote` — recusa lote inexistente

**[D]** Lote informado que não existe para o item na empresa de cálculo devolve **400**. Lote vazio
passa.

Mesmo critério da promoção (§7.5): o lote é fato sobre o **AUTCOM**, não sobre a venda do consumidor —
a tela só oferece lotes existentes, e o Sales pode mandar qualquer texto. Antes disso,
`numeroLote: "LOTE QUE NAO EXISTE"` passava com 200 e seria gravado no `FDO_NUMLOT`.

**[D, 28/09/2026] Vale para os seis services**, não só para o `simular-emissao` — a validação ficou na
`TEmitirPedidoService`, junto de `pValidarUnitario`, `pValidarTabPreco` e `pValidarEmpresaItem`.
Decisão do João: *"se enviar um lote inválido deveria validar, isso vale para os outros endpoint"*, e
*"se quebrar é o teste que deve ser ajustado, pois não poderia aceitar um lote inválido"*.

Usa `fExisteLote` (`untFuncoesGenerica`) e resolve a empresa por `fGetEmpCalculoItem`, a mesma que o
AUTCOM usa para preço e promoção — `CFG_EMPPRC` decide entre a empresa logada e a do item.

**Exposição da suíte:** 248 dos 906 casos mandam `numeroLote`, com três valores distintos —
`A DEFINIR`, `LF1 - TA` e `TESTE PRECO VENDA`. Os três existem na `CADLOT`, então a expectativa é de
nenhuma quebra; o que pode falhar é combinação lote × item × empresa que não exista.

**[V]** Lote **sem preço próprio não altera o preço**: os três lotes do item `49368` na `022` têm
`LOT_PREVEN = 0`, e o AUTCOM só sobrepõe quando há preço maior que zero (`fCalculaPrecosLote`, com o
guarda `LPrecoVendaLote > 0`). Confere com o pedido `351309`.

> **Correção de uma afirmação minha.** Cheguei a registrar aqui que o caminho do lote **com** preço
> era inexercitável por falta de cenário. **Falso** — existe: item `21098`, empresa `022`, lote
> `TESTE PRECO VENDA`, com `LOT_PREVE1 = 47,00` contra preço de tabela `50,10`. Eu tinha olhado só os
> lotes do item que já vinha usando, em vez de procurar na `CADLOT` por preço preenchido.

### 7.5.2 [V, 28/09/2026] `tabPreco`, `tabPrecoGeral` e `empresaItem`

| Atributo | Validação | Efeito no preço |
|---|---|---|
| `tabPreco` | fora de 1..7 → **400** | **nenhum** |
| `tabPrecoGeral` | — | **nenhum** |
| `empresaItem` | empresa inexistente → **400** | nenhum observável nesta base |

**A tabela de preço não altera o preço, e isso está certo.** Este endpoint não *sugere* preço — ele
recebe `precoOriginal` e `precoDigitado` do consumidor. A tabela pesa noutro lugar: no filtro de
promoção (`fGetFiltroTabelaPrecoPromocao`, via `CADPRO.PRO_TABPRE`).

> **[?] Dois caminhos existem no código e não foram observados nesta base:**
>
> - **`empresaItem` × `CFG_EMPPRC`** — a config decide entre empresa logada e empresa do item.
>   Testado com `022`, `001` e `999`: preço, CFOP, CST, ICMS e IPI **idênticos** nos três. Nenhum item
>   tem `ITE_PREVE1` diferente entre `001` e `022` (consulta exaustiva, 190s), e a tributação também
>   coincide. O roteamento acontece; o resultado não muda, então não há como distinguir.
> - **`tabPreco` × promoção** — a única promoção ativa (`24001`) tem `PRO_TABPRE = 'SSSSSSS'`, as sete
>   tabelas liberadas. Qualquer valor de `tabPreco` passa igual.

### 7.5.3 [V, 28/09/2026] `motivoEntregaFutura`, `tipoOperacao` e `enderecoEntregaID`

**`motivoEntregaFutura` — correto.** O AUTCOM normaliza em `TEmitirPedido:741`:

```pascal
if not MatchStr(dadosProduto.strMotFut, ['F', 'A', 'P']) then
  dadosProduto.strMotFut := ENTREGA_FUTURA_MOTIVO_DEFAULT;   // = ''
```

Medido: `A`, `F` e `P` voltam intactos; `T` e vazio voltam `''`. Reproduz a normalização, inclusive o
default **vazio** — que é contraintuitivo, já que todo pedido real da base grava `FDO_MOTFUT = 'A'`.

> Cheguei a tratar o retorno vazio como bug. Não era: eu tinha mandado um motivo fora da lista.

**[?] `tipoOperacao` — sem efeito observável e sem validação.** Testados `V`, `B`, `C`, `A`, `E` e o
inválido `X`: **CFOP `5102`, CST `000` e ICMS `34,80` em todos**. A tela oferece
(V)enda / (B)onificação / (C)onta e Ordem / (A)mostra / (E)xportação, e o `pSetTipoOperacao` é
chamado — mas nada muda no que este endpoint devolve, e `X` passa calado.

**[?] `enderecoEntregaID` — sem efeito observável e sem validação.** `999999` inexistente passa com
200. No `TEmitirPedido:619` ele só liga `blnForcEndEnt`; o efeito seria trocar o endereço de entrega,
e com ele a UF de destino — mesmo eixo do `vendaPresencial` (§4.1).

> Os dois são **decisão pendente do João**: validar e recusar, como fizemos com lote e promoção, ou
> honrar. Ambos são fato sobre o AUTCOM (o tipo existe? o endereço é do cliente?), o que pelo critério
> de §7.5 apontaria para recusar.

### 7.5.4 [?] Tinta — os 8 atributos NÃO foram exercitados

`siglaTinta` · `hashMD5Tinta` · `embalagemProduzida` · `volumeProduzido` · `modoVenda` ·
`codigoDiluente` · `percentualDiluicao` · `codigoEmbalagem`

**Não é falta de cenário — é falta de biblioteca no ambiente.** A combinação existe e foi montada a
partir de pedidos reais: empresa `060` (`CFG_USATMQ='S'`), cliente `00101518`, condição `171`, e três
fórmulas gravadas —

| Item | Marca | Hash | Preço |
|---|---|---|---|
| `52444` | `SUV` | `ABF9A830C7068AE53EC7422C9B4FFD4F` | 22,28 |
| `54693` | `LEC` | `C4EED1B9A964568975278F23039E367E` | 30,10 → 24,08 |
| `44540` | `LAZ` | `01400084548` | 60,70 |

**[V, 29/09/2026] CORRIGIDO — o endpoint não passava pela infraestrutura de workers.**

`TPedidoServiceWorker.fSimularEmissao` chamava `TPedidoService.fSimularEmissao` **direto**, executando
no processo **pai**. Os outros 25 métodos do worker despacham para o **filho** via
`TFaturamentoWorkersManager.fExecuteTask`. O meu era o único fora do padrão.

Para item comum isso funciona e não dá sintoma — os 33 casos da bateria passaram assim o dia inteiro.
Para item de tinta o pai tenta carregar `libAutcomTinta.so` mais a `.so` da marca e **morre**.

**Faltavam duas coisas, ambas minhas:**

1. A sobrecarga tipada não usava `fExecuteTask`.
2. `AddMethod('TPedidoService.fSimularEmissao', ...)` **não existia** — sem o registro, mesmo
   despachando, o filho recusaria o método.

**Como o log fechou o diagnóstico:**

```
[Aguarde, Adicionando produto 52444 ...]
[Carregando Precos da Tinta [SUV-52444-39068BB3D48AE7EC1420656654502BC2]]
[TWorkerInfo.Destroy: kill -9 pid=19482 porta=51291]
```

Os `kill -9` são a **finalização** do processo, não exceção — por isso nunca apareceu erro tratado e o
`dmvcframework.log` sequer registrava a requisição: o buffer morria junto.

**O discriminador decisivo** foi mandar o mesmo payload de tinta para o `calcular-impostos`: respondeu
**200** e o serviço sobreviveu, porque ele passa pelo `fExecuteTask`. Isso refutou a hipótese de que o
defeito fosse do caminho compartilhado.

**Verificado após a correção:** `simular-emissao` com `SUV` + hash `39068BB3D48AE7EC1420656654502BC2`
na empresa `061` devolve **200** — CFOP `5405`, CST `060`, preço `22,40`, idênticos ao que o
`calcular-impostos` produz. Serviço de pé antes e depois.

> **Três conclusões minhas foram falsas no caminho, e registro porque o padrão é instrutivo:**
> *"faltam as bibliotecas de marca"* (olhei só a raiz do deploy — há 89 `.so` em `auttin/tintas/`);
> *"não houve queda, foi o João que encerrou"* (aceitei rápido demais); e *"derruba os seis endpoints
> em produção"* (o teste refutou). As três vieram de deduzir sem evidência. O log resolveu em uma
> leitura o que quatro hipóteses não resolveram.

### 7.6 `FDO_UNDIDE`

**[V]** Criado na Req. **295758** (r328579, 14/07/2023), refatoração da carga do pedido — é **cache**
do unitário para a carga não recalcular item a item (tempo caiu de ~4 min para ~1 min).

**[V]** Por isso o fallback `IF(IFNULL(FDO_UNDIDE,0)=0, FDO_UNIDIG, FDO_UNDIDE)`: pedidos anteriores a
julho/2023 não o têm.

> **Obrigatório no contrato.** O fallback cai no `UNIDIG`, que é o preço **antes** do desconto do
> item. Se o Sales não gravar o `UNDIDE`, todo item com desconto carrega no AUTCOM pelo preço
> **sem** desconto — em silêncio, porque o fallback é legítimo.

**[V]** É também o valor unitário que alimenta o cálculo de ICMS-ST
(`untCalculaImpostoPedido.pas:295`).

### 7.6.1 [V] O endpoint DERIVA este campo, não o lê

Descoberto na implementação, em 25/09/2026: **a matriz de itens em memória não carrega esse valor.**
O `TDadosFechamento` tem `fltUniDig`, `fltDesCon`, `fltUniTar` e `fltFreRat`, mas **não** um
`fltUndIde` — esse campo pertence a outro record, o do fator de serviço
(`untFuncFatTypes.pas:357`). O `FDO_UNDIDE` só passa a existir no momento da gravação.

Portanto o endpoint **calcula** `UNIDIG × (1 − DESCON%)`, com `fFormataFloat` e o `DECUNI` da empresa,
para reproduzir o truncamento do legado.

> **Isso muda o risco do campo.** Um valor copiado erra só se a leitura errar; um valor calculado erra
> se a nossa fórmula divergir do que o AUTCOM gravaria — e erra em silêncio, porque não há com o que
> comparar. Como é justamente o campo que, zerado ou errado, faz todo item com desconto carregar pelo
> preço cheio, **o caso de teste de round-trip deixa de ser desejável e passa a ser obrigatório**: é o
> único mecanismo que pega divergência aqui.

### 7.7 `FDO_VAL_RT` — fora de escopo

**[D, 24/09/2026] Removido do payload e do requisito.** `pRateiaValorRT` tem chamada única em todo o
repositório, de dentro do `fGravaArquivos` — rotina de **gravação**. A API calcula e nunca grava,
então o valor não existe no caminho dela. Some-se: 3 linhas em 90.690 na base, com percentual
inconsistente, e `cdsProfiss := nil` no service.

> Consequência: pedido do Sales nunca terá `VAL_RT`. Já é assim hoje; passa a estar documentado.

### 7.8 Brinde e entrega futura

**[V]** **Brinde** zera o preço praticado e preserva o de tabela — pedido `979`, item `09050`:
`UNIORI = 25,32`, `UNIDIG = 0`, `UNITAR = 0`, CFOP `6910`, CST `041`.

**[V]** **Entrega futura** muda a tributação: CFOP `6922`, CST `040`/`060`. Isolado no pedido `980`,
onde retirar a marcação devolveu CFOP `6108` e CST `010`.

**[V]** `entregaRetira` **não** muda a tributação — só a participação no rateio do frete (§7.4).

**[V]** **O retorno não ecoa `brinde`, e não é lacuna.** Não existe coluna de brinde na `FATDOR` nem na
`EXTDOR` — conferido no `INFORMATION_SCHEMA`. O brinde só se manifesta no preço zerado e no par
CFOP/CST, e os três já voltam. Ecoar a marcação seria devolver ao consumidor aquilo que ele mesmo
mandou, sem destino de gravação correspondente.

### 7.9 Alteração de pedido

**[V]** Não recalcula. Pedido `3232` alterado de quantidade 1 para 2: `UNIDIG`, `TAXJUR`, `PROMOC` e
`UNITAR` idênticos, só o total acompanhou. O item foi de fato reinserido (`FDO_INSALT` virou `'S'`).

---

## 8. Invariante e round-trip

**[V]** `pCarregaPedidoOrcamento` reconstrói o preço do item ao reabrir:

```pascal
fltUniDigDescontada := fUniDigDescontada(FDO_UNIDIG, FDO_TAXJUR, FDO_DESCON, FDO_DESCND, PROMOC);
```

e esse valor **é** o unitário e o total na carga. A releitura tem **duas etapas**: a reconstrução
acima, e a totalização, que reaplica o desconto da condição (de `CND_DESMAX`) e o do profissional (de
`FGO_PORDES`).

**[V]** Dentro da etapa 1, `pAplicaRegrasCondicoesDePagamentoOrigemF11` sai na primeira linha quando
`strOriF11 <> 'S'` — só é `'S'` em caixa e conferência de orçamento. Por isso a condição não é
aplicada duas vezes.

> **Critério de aceitação:** para todo item devolvido, o resultado da releitura tem de reproduzir o
> `precoUnitario` devolvido. Verificável por round-trip e deve ser caso de teste.

---

## 9. Precisão

**[V]** `CFG_DECUNI` varia por empresa — 2 casas em 68 empresas, 4 em 25, 3 em 5, 6 em 1, 10 em 2.
`fMaxDecUni = Max(DECUNI, 4)`. A fórmula arredonda em cada etapa; o endpoint tem de respeitar o
`DECUNI` da empresa.

**[V, João]** Quando o cliente precisa de mais casas, roda-se um `ALTER` no banco dele — a precisão da
coluna acompanha a config.

**[?]** Conferir se o `ALTER` alcança `FDO_UNDIDE` e `FDO_FRERAT`, hoje `decimal(12,2)` contra
`decimal(12,4)` dos unitários. `UNDIDE` é intermediário da fórmula; menos preciso que a entrada é
fonte de divergência de centavo.

---

## 10. A trava do `TXJCNI='2'`

**O problema.** A combinação `opcoes.ini [GERAL] TXJCNI=S` + `CFG_CNDVEN='I'` + `CFG_TXJCNI='2'` altera
**três** comportamentos ao mesmo tempo:

1. `fAplicarTaxaJurosPrecoDigitado` vira `True` → a releitura **readiciona** juros ao `UNIDIG`;
2. desabilita o abatimento automático do desconto da condição
   (`fVerificaAbateDescontoAutomaticamente` sai em `False`);
3. `TEmitirPedido:997` divide o `UNIDIG` por `(1 + taxa)` na inserção.

Os três se combinam, e **existem em um único cliente** — não há como testar aqui. Um erro nessa
configuração não levanta exceção: grava preço errado.

**[D, 24/09/2026] Recusar, não degradar.** Validação no início do service, antes de qualquer cálculo:

```pascal
procedure TSimularEmissaoService.pValidarConfiguracaoSuportada;
begin
  if fAplicarTaxaJurosPrecoDigitado then
    raise EConfiguracaoNaoSuportada.Create(
      'CFG_TXJCNI=2 com CFG_CNDVEN=I: nesta combinacao o AUTCOM grava o preco digitado ' +
      'sem juros e desabilita o abatimento automatico do desconto da condicao. ' +
      'Comportamento sem cobertura de teste - ver IA/specs/461523/spec.md secao 10.');
end;
```

Três decisões embutidas, todas aprovadas:

**a)** **Recusar em vez de avisar.** Devolver preço possivelmente errado é pior que não devolver — o
consumidor gravaria e ninguém saberia.

**b)** **Exceção própria, HTTP 422.** Os controllers mapeiam `EInvalidParams` para 400, que culpa o
cliente. Aqui a requisição está correta; o que não suportamos é a **configuração do servidor**.

**c)** **A mensagem aponta a spec**, para quem receber o erro achar o porquê sem abrir código.

**Custo aceito:** se aquele cliente usar o endpoint, recebe recusa. A alternativa — obter a config numa
base de teste e validar — remove a trava quando alguém quiser pagar esse preço.

**`CFG_TIPJUR='C'` NÃO entra na trava** — foi validado (§7.1) com as empresas `071`/`072` da base de
teste.

---

## 10.1 Pendências

**[?] 1.** Conferir se o `ALTER` de casas decimais alcança `FDO_UNDIDE` e `FDO_FRERAT`, hoje
`decimal(12,2)` contra `decimal(12,4)` dos unitários (§9).

**[?] 2.** Nome definitivo dos campos do retorno — a estrutura está aprovada (§5), a nomenclatura
final sai no plano.

**[?] 3.** Swagger: além da precondição de §4.0, os campos `taxaJuros` (unidade varia com `TIPJUR`),
`valorFrete` (zerado quando há rateio) e `unitarioAntesRateio` (obrigatório) precisam de descrição
própria. São as armadilhas que mais custaram tempo nesta investigação.

---

## 11. Nota de método

Ao longo desta investigação o dado histórico produziu quatro conclusões falsas, todas plausíveis à
leitura e todas derrubadas por experimento:

1. a regra de gravação do `UNIDIG` por `TXJCNI` — derrubada pelo pedido `978`;
2. a hipótese de que promoção discriminava a forma do `UNIDIG` — derrubada por contagem;
3. o significado do `FDO_UNDIDE` — derrubado pelo `svn log` da Req. 295758;
4. uma métrica de "97% de aderência" da fórmula — artefato da conclusão 3; com campos primários a
   aderência histórica é 41%.

A causa é sempre a mesma: a base mistura versões de código, cadastros alterados depois da emissão e
caminhos de gravação distintos. **Nada nesta spec marcado [V] se apoia em dado histórico** — apoia-se
em código lido ou em pedido controlado emitido em 24/09/2026 com config verificada.
