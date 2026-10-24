# Req. 458948 — Juros de parcelamento em cartão por faixa de valor

| | |
|---|---|
| **Requisito** | 458948 |
| **Sistema** | API Service |
| **Envolvidos** | Felipe Carvalho Damacena |
| **Abertura** | 27/08/2026 |

> Necessidade registrada no requisito: *"Implementar para realizar o pagamento da duplicata com
> juros de parcelamento."*

## Contexto

O App Sales cobra duplicatas em atraso e oferece ao cliente pagamento no cartão parcelado. Hoje
ninguém sabe dizer, no atendimento, quanto fica em 3x ou em 6x — o número sai de planilha ou da
cabeça de quem atende, e cada um chega a um valor diferente.

Duas peças já existem e continuam válidas:

| Peça | Origem | Situação |
|------|--------|----------|
| Cadastro de faixa de valor para parcelamento (`FXCASA`) | Req. 454627 | Em produção |
| `GET /cartao/parcelamento/limite-parcelas` | Req. 458327 | Em produção, com testes |

O endpoint devolve hoje apenas o **teto** de parcelas da faixa. Falta o valor de cada opção.

## Escopo

Duas partes, entregues juntas:

**Parte A — simulação.** Acrescentar o percentual de juros ao cadastro de faixa e fazer o endpoint
existente devolver, na mesma chamada, a tabela de parcelamento já calculada.

**Parte B — baixa.** O app envia o juros escolhido na simulação para `/cobranca/baixa`, que passa a
gravá-lo em `CTR_VALJUR`, somado ao juros de atraso e ao juros sugerido.

**Decisão estruturante:** não haverá endpoint novo na Parte A. Buscar o limite numa chamada e os
valores em outra obrigaria o app a duas idas ao servidor para montar uma única tela. A alteração é
aditiva no contrato atual, então nenhum consumidor quebra.

### Fora de escopo

- Diferenciar faixa por empresa. A `FXCASA` é global por decisão do Req. 454627 e assim permanece.
- Alterar o cálculo de juros de atraso, multa ou desconto de pontualidade.
- Alterar o desktop. A baixa em cartão pelo `autcom.exe` não passa a oferecer parcelamento com
  juros; apenas o serviço REST muda.

---

## 1. Banco de dados

Uma coluna nova na `FXCASA`:

```sql
ALTER TABLE FXCASA
  ADD COLUMN FAI_PERJUR DECIMAL(5,2) DEFAULT NULL AFTER FAI_QTDPAR;
```

`DECIMAL(5,2)` comporta até 999,99%. Nulo por padrão: as faixas já cadastradas em produção
continuam válidas sem intervenção.

A tabela **não tem** `FAI_CODEMP`. O percentual, como a faixa, vale para todas as empresas da
instância. Isso é diferente de `CFG_JURATR`, que é por empresa e hoje assume sete valores distintos
entre as 35 empresas da base de desenvolvimento (9,9 / 10 / 6 / 5 / 1,5 / 1 / 0). **Consequência
aceita:** a política de juros de parcelamento passa a ser única, independente da política de mora
de cada loja.

## 2. Cadastro — Zona Legado

`padra_atualizado/fontes/cadastros/untCadFaixaParcelamentoCartao.pas` + `.dfm`
(herda `TfrmPaiCad`).

| Onde | O quê |
|------|-------|
| `stlCampos` | acrescentar `FAI_PERJUR` |
| `DisplayLabel` | `'% Juros a.m.'` |
| `DisplayFormat` | `'#,##0.00'` |
| `.dfm` | campo de edição de percentual, seguindo o padrão dos campos de valor já presentes |
| Validação | percentual negativo recusado na gravação |

A validação de sobreposição de faixas existente não muda — ela olha `FAI_VALINI`/`FAI_VALFIN`, e o
percentual não participa da chave da faixa.

## 3. Endpoint — Zona Moderna

Rota, método, autenticação e parâmetro de entrada **permanecem exatamente como estão**:

```
GET /cartao/parcelamento/limite-parcelas?valor=1000.00
Header: Empresa
JWT obrigatório
```

O nome `limite-parcelas` é mantido de propósito. Renomear para algo como `simulacao` quebraria o
consumidor atual sem ganho funcional.

Units afetadas:

- `Services/Core/financeiro/services/types/Financeiro.Services.ParcelamentoCartao.Types.pas`
- `Services/Core/financeiro/services/Financeiro.Services.ParcelamentoCartao.pas`
- `Services/Financeiro.Services.API/Source/api/controller/api.controller.parcelamentocartao.pas`

### Resposta

Campos existentes preservados; `percentualJurosMes` e `opcoesParcelamento` são novos.

```json
{
  "valorConsultado": 1000.00,
  "limiteParcelas": 6,
  "percentualJurosMes": 10.00,
  "faixa": { "valorInicial": 200.00, "valorFinal": 5000.00 },
  "opcoesParcelamento": [
    { "parcelas": 1, "juros": 100.00, "valorTotal": 1100.00, "valorParcela": 1100.00 },
    { "parcelas": 2, "juros": 200.00, "valorTotal": 1200.00, "valorParcela":  600.00 },
    { "parcelas": 3, "juros": 300.00, "valorTotal": 1300.00, "valorParcela":  433.33 },
    { "parcelas": 4, "juros": 400.00, "valorTotal": 1400.00, "valorParcela":  350.00 },
    { "parcelas": 5, "juros": 500.00, "valorTotal": 1500.00, "valorParcela":  300.00 },
    { "parcelas": 6, "juros": 600.00, "valorTotal": 1600.00, "valorParcela":  266.67 }
  ]
}
```

`opcoesParcelamento` vai de 1 até `limiteParcelas`, respeitada a guarda de 60 da regra R6. `limiteParcelas`
continua devolvendo o `FAI_QTDPAR` cadastrado, sem truncamento — é campo já consumido em produção e
não pode mudar de significado. Nas faixas cadastradas com sanidade, que são todas hoje, os dois
números coincidem.

---

## 4. Regras de cálculo

A fórmula parte de percentual diário aplicado sobre o prazo:

```
% juros total = (FAI_PERJUR / 30) x prazo_medio
prazo_medio   = n x 30
```

Que simplifica para:

```
% juros total = FAI_PERJUR x n
valorTotal    = arredonda(valor x (1 + % juros total / 100), 2)
juros         = valorTotal - valor
valorParcela  = arredonda(valorTotal / n, 2)
```

**R1 — Uma parcela tem juros.** Pela fórmula, `n = 1` corresponde a 30 dias de prazo e cobra
`FAI_PERJUR` cheio. Não há opção à vista sem juros. Esta regra foi confirmada explicitamente pelo
solicitante depois de a consequência ter sido apontada.

**R2 — Juros simples, nunca composto.** O percentual multiplica o número de parcelas; não há
capitalização. É o cálculo que o cobrador consegue explicar e o cliente consegue conferir na mão.

**R3 — O valor de entrada já vem corrigido.** O `valor` recebido é o total a cobrar, com juros de
atraso, multa e desconto de pontualidade já aplicados pelo endpoint de duplicatas. Este endpoint não
recalcula correção nenhuma.

**R4 — Sobra de centavos vai para a última parcela.** `valorParcela` é o valor das `n-1` primeiras.
A última é `valorTotal - valorParcela x (n-1)` e é dedutível pelo consumidor; não há campo próprio
para ela no contrato.

```
3x sobre 1.300,00  ->  433,33 + 433,33 + 433,34 = 1.300,00
6x sobre 1.600,00  ->  266,67 x 5 + 266,65      = 1.600,00
```

**A baixa pode distribuir o centavo em outra ponta, e isso é aceito.** O rateio das parcelas de
cartão é decidido por `CAR_ARRPAR`, no cadastro do cartão
(`fontes/financeiro/gerais/untArredondaParcelasCartoes.pas`):

| `CAR_ARRPAR` | Sobra vai para |
|---|---|
| `P` | primeira parcela |
| `U` | última parcela |
| `N` ou vazio | **depende do arredondamento**: para baixo, primeira; para cima, última |

Há ainda uma regra por nome — cartão cujo `CAR_DESCAR` contém "Cielo" usa o rateio da primeira —
mas o `CAR_ARRPAR` é lido depois e sobrescreve.

A simulação **não recebe `codigoCartao`** e portanto não tem como reproduzir essa decisão. Optou-se
por manter a regra única da R4 (última) em vez de amarrar a simulação ao cartão. Consequência
conhecida e aceita: com cartão configurado em `P`, ou no default com arredondamento para baixo, a
parcela maior aparece na primeira posição do extrato e não na última. O **total nunca diverge** —
apenas a posição do centavo. O consumidor deve exibir `valorParcela` como valor nominal, sem
prometer qual parcela carrega a diferença.

Verificado em 28/08/2026 no teste ponta a ponta: 617,51 em 9x pelo cartão `00018` (`ARRPAR = N`)
gerou 68,63 + 68,61 x 8 — sobra na primeira, porque 68,61 x 9 = 617,49 arredondou para baixo.

**R5 — Faixa sem percentual devolve juros zero.** `FAI_PERJUR` nulo ou zero produz a tabela
completa com `juros: 0.00` e `valorTotal` igual ao valor consultado. Escolha deliberada: recusar a
resposta quebraria em produção toda faixa ainda não atualizada, no dia do deploy.

**R6 — Guarda de sanidade em 60 parcelas.** Sendo o `FAI_QTDPAR` da faixa quem define o tamanho da
tabela, um cadastro equivocado (999, por exemplo) geraria uma resposta enorme. O serviço trunca em
60 opções.

## 5. Erros

| Situação | Resposta | Muda em relação a hoje? |
|----------|----------|------------------------|
| `valor` ausente | 400 | não |
| `valor` não numérico / mal formatado | 400 | não |
| `valor` negativo | 400 | não |
| Nenhuma faixa cadastrada para o valor | 404 | não |
| Sem JWT | 401 | não |
| Faixa encontrada, `FAI_PERJUR` nulo | 200, juros zero | comportamento novo (R5) |

Nenhuma condição de erro nova é introduzida.

---

## 6. Parte B — Baixa com juros de parcelamento

Units afetadas:

- `Services/Core/financeiro/services/types/Financeiro.Services.Cobranca.Baixa.Types.pas`
- `Services/Core/financeiro/services/Financeiro.Services.Cobranca.Baixa.pas`

### 6.1 Entrada

**O contrato das duplicatas não muda.** Nenhum campo novo em `duplicatas[]`, nenhum significado
alterado. `valorRecebido` continua sendo o que abate a dívida do título, sem juros de parcelamento.

A única adição é um campo **no movimento de cartão**, ao lado do `valor`:

```json
{
  "duplicatas": [ ... ],
  "movimentos": {
    "cartao": {
      "cartoes": [
        { "valor": 1400.00, "jurosParcelamento": 400.00, "quantidadeParcelas": 4, ... }
      ]
    }
  }
}
```

O campo vive no cartão, não no lote, porque **o juros é função da `quantidadeParcelas`, que é
atributo do cartão**. Um lote com dois cartões em parcelamentos diferentes tem dois juros
diferentes, e um único campo no lote não saberia representá-los.

`valor` **já inclui** o `jurosParcelamento` — é o que a operadora processa. O `jurosParcelamento`
diz quanto daquele valor é juros.

O rateio entre as duplicatas é feito **pelo serviço**, nunca pelo consumidor. Rateio de valor com
centavo sobrando é a conta que duas implementações fazem diferente; se o app arredondar por
duplicata e o serviço somar, divergem, e a divergência não degrada suavemente — vira 400 e a baixa
não acontece com o cliente no balcão.

Campo opcional. Ausente ou zero, o comportamento é exatamente o de hoje.

### 6.2 Fechamento do lote

A conferência é a que dá sentido ao campo: a diferença entre o que o cartão cobra e o que as
duplicatas abatem tem que ser exatamente o juros de parcelamento declarado.

```
soma(valor dos cartões) - soma(valorRecebido) == soma(jurosParcelamento dos cartões)

  duplicatas                    1.000,00
  jurosParcelamento dos cartões   400,00
  valor dos cartões             1.400,00      1.400,00 - 1.000,00 = 400,00   OK
```

Bateu, o serviço sabe que a diferença é juros e segue. Não bateu, 400 — o mesmo rigor que a
validação de hoje já aplica.

### 6.3 Rateio

O juros vem por cartão, mas o **rateio é do lote**: os cartões pagam as mesmas duplicatas, e não há
vínculo entre um cartão específico e um título específico. Então a base é a soma dos
`jurosParcelamento` de todos os cartões.

Proporcional ao `valorRecebido` de cada duplicata — o valor que efetivamente está sendo pago, não o
corrigido. Em baixa total os dois coincidem; em baixa parcial, não, e é o pago que importa: o juros
foi simulado sobre o que está sendo pago agora.

```
totalJuros = soma(jurosParcelamento de todos os cartões)
fator(i)   = valorRecebido(i) / soma(valorRecebido)
juros(i)   = arredonda(totalJuros x fator(i), 2)
```

**Duplicatas de crédito ficam fora do rateio.** Elas entram no lote com `valorRecebido` negativo —
o rateio proporcional produziria juros negativo nelas, isto é, um abatimento de juros por conta de
um crédito, que ninguém pediu. Só entram na base do rateio os itens com `valorRecebido` positivo,
e os demais recebem rateio zero. Se nenhum item do lote tiver valor positivo, 400.

A sobra de centavos vai para a última duplicata **com valor positivo**, de modo que a soma dos
rateios seja exatamente `jurosParcelamento`.

```
Recebido:   300,00 + 450,00 + 250,00 = 1.000,00
Juros 4x:                                400,00
Cartão:                                1.400,00

  300,00 (30%) -> juros 120,00
  450,00 (45%) -> juros 180,00
  250,00 (25%) -> juros 100,00
                       400,00  = soma dos jurosParcelamento
```

### 6.4 Gravação

O rateio é interno: entra na gravação, não no contrato.

```
CTR_VALJUR = juros do título (rateado, quando parcial) + juros de parcelamento rateado
CTR_VALREC = valorRecebido + juros de parcelamento rateado
```

`CTR_VALREC` recebe o juros somado por consistência com o que o Autcom já faz: na baixa comum o
`valorRecebido` é o `valorCorrigido`, que já embute o juros de atraso, e o `CTR_VALJUR` detalha
quanto daquele total era juros. O juros de parcelamento segue a mesma lógica.

### 6.5 Baixa parcial — o juros vai inteiro para a parte baixada

Na parcial o app consulta a faixa com o valor que vai baixar, não com o valor do título. Baixando
500,00 de uma duplicata de 1.000,00, o juros é simulado sobre os 500,00 — e é inteiro dessa parte.

**B1 — O juros de parcelamento nunca entra no `ValorPago` do `TCalculoBaixaParcial`.** Ele é somado
ao `JurosBaixaDuplicata` depois do cálculo, e o `JurosNovaDuplicata` nunca o enxerga.

```
LParcial   = TCalculoBaixaParcial.Calcular(ValorPago := LItem.valorRecebido)
CTR_VALJUR = LParcial.JurosBaixaDuplicata + jurosParcelamento rateado
```

O contrato de 6.1 garante isso de graça: `valorRecebido` chega limpo, então o valor passado ao
cálculo já é o certo, sem transformação nenhuma. **Foi a razão principal para manter o contrato das
duplicatas intocado** — e é por isso que somar o rateio antes de chamar `Calcular` seria um defeito,
não uma otimização:

```
Duplicata 1.000,00, baixa parcial de 500,00, juros de parcelamento 200,00, cartão cobra 700,00

  ValorPago = 700,00 (inflado)          ValorPago = 500,00 (como chega)
    FatorBaixa = 1.000/1.000 = 1          FatorBaixa = 1
    ValorBaixaDuplicata = 700,00          ValorBaixaDuplicata = 500,00
    ValorNovaDuplicata  = 300,00  ERRADO  ValorNovaDuplicata  = 500,00  correto
```

O `ValorPago` é divisor de todos os fatores do cálculo parcial. Inflado, o cliente abate 700,00 de
dívida tendo pago 500,00 de dívida e 200,00 de juros de cartão — some 200,00 do saldo devedor a cada
baixa parcelada, em silêncio.

**B2 — O título de saldo não herda juros de parcelamento.** O parcelamento já foi contratado e
cobrado integralmente no cartão; levá-lo ao saldo seria cobrança em duplicidade.

**B3 — A trava `BAIDUPJUR` não muda de alcance.** `fLiberaBaixaParcialComJuros` é acionada quando
`JurosTotal > 0`, `tipoBaixa = P` e `CFG_JURPAR = 'N'`. Essa avaliação continua olhando apenas o
juros do título; o juros de parcelamento não a dispara. Ampliar silenciosamente uma trava de direito
de operador seria efeito colateral, não requisito.

### 6.6 Validações existentes

Uma muda. As outras duas ficam intactas — consequência direta de manter `valorRecebido` limpo.

| Validação | Situação |
|-----------|----------|
| `ValidarSomaContraMovimentos` | **muda:** de `soma(valorRecebido) = soma(movimentos)` para `soma(valorRecebido) + jurosParcelamento = soma(movimentos)` |
| `ValidarItemDoLote` — teto do recebido | **inalterada.** `valorRecebido` nunca inclui o juros, então nunca excede o `valorCorrigido` por causa dele |
| Coerência do `valorCorrigido` | **inalterada.** `valorCorrigido` é a correção do título até hoje e não conhece meio de pagamento. O app envia o mesmo número de hoje |

### 6.7 Erros novos

Validados em `ValidarCartao`, junto das regras que já existem para o movimento.

| Situação | Resposta |
|----------|----------|
| `jurosParcelamento` negativo | 400 |
| `jurosParcelamento` ≥ `valor` do cartão | 400 — o juros está contido no valor; igual ou maior significaria que nada do que entrou abate duplicata |

Não há mais o erro "juros sem movimento de cartão": o campo vive dentro do cartão, então a situação
deixou de ser representável.

## 7. Critérios de aceitação

Conforme o CLAUDE.md, o entregável de quem implementa é esta lista; **os casos de teste são
escritos por analista humano**.

### Endpoint

| # | Caso | Esperado |
|---|------|----------|
| 1 | Valor em faixa com `FAI_PERJUR` = 10 e `FAI_QTDPAR` = 6 | 200, `opcoesParcelamento` com 6 itens, valores conforme a tabela da seção 3 |
| 2 | Valor em faixa com `FAI_PERJUR` nulo | 200, 6 itens, todos com `juros` = 0 e `valorTotal` = `valorConsultado` |
| 3 | Valor em faixa com `FAI_PERJUR` = 0 | idêntico ao caso 2 |
| 4 | 3x sobre total de 1.300,00 | `valorParcela` = 433,33 (última, deduzida, = 433,34) |
| 5 | 6x sobre total de 1.600,00 | `valorParcela` = 266,67 (última, deduzida, = 266,65) |
| 6 | Faixa com `FAI_QTDPAR` = 1 | 200, `opcoesParcelamento` com 1 item, com juros |
| 7 | Faixa com `FAI_QTDPAR` = 999 | 200, `limiteParcelas` = 999 e `opcoesParcelamento` truncada em 60 itens |
| 8 | Valor fora de qualquer faixa | 404, mensagem atual preservada |
| 9 | `valor` ausente | 400 |
| 10 | `valor` = `abc` | 400 |
| 11 | `valor` negativo | 400 |
| 12 | Requisição sem JWT | 401 |
| 13 | Retrocompatibilidade | `valorConsultado`, `limiteParcelas` e `faixa` idênticos aos devolvidos hoje para a mesma entrada |

### Cadastro

| # | Caso | Esperado |
|---|------|----------|
| 14 | Incluir faixa informando percentual | grava `FAI_PERJUR` |
| 15 | Alterar o percentual de faixa existente | grava o novo valor |
| 16 | Informar percentual negativo | recusa na gravação |
| 17 | Abrir faixa cadastrada antes da alteração | abre sem erro, campo vazio |
| 18 | Gravar faixa sem informar percentual | grava com `FAI_PERJUR` nulo |

### Baixa

| # | Caso | Esperado |
|---|------|----------|
| 19 | Baixa total, 3 duplicatas somando 1.000,00, um cartão com `valor` 1.400,00 e `jurosParcelamento` 400,00 | aceita; rateio 120/180/100 conforme 6.3; soma dos `CTR_VALJUR` acrescida em exatamente 400,00 |
| 20 | Baixa total sem `jurosParcelamento` | comportamento idêntico ao de hoje, byte a byte |
| 21 | Baixa total com `jurosParcelamento` = 0 | idêntico ao caso 20 |
| 21b | **Dois cartões**, um com juros 250,00 e outro com 150,00 | rateio usa a soma, 400,00, distribuída entre as duplicatas do lote |
| 22 | Rateio com sobra de centavos | soma dos rateios = `jurosParcelamento` exato; sobra na última duplicata |
| 23 | Baixa **parcial**: duplicata de 1.000,00, `valorRecebido` 500,00, cartão com `valor` 700,00 e `jurosParcelamento` 200,00 | `CTR_VALREC` = 700,00, `CTR_VALJUR` acrescido de 200,00, e **título de saldo = 500,00** (não 300,00) |
| 24 | Título de saldo da baixa parcial | `JurosNovaDuplicata` sem qualquer parcela do juros de parcelamento |
| 25 | Lote onde cartões − duplicatas ≠ soma dos `jurosParcelamento` | 400, mensagem apontando a diferença apurada |
| 26 | Lote onde cartões − duplicatas = soma dos `jurosParcelamento` | aceita e segue para a gravação |
| 27 | `jurosParcelamento` > 0 e `valor` do cartão = soma das duplicatas | 400 — a diferença é zero e não corresponde ao juros declarado |
| 28 | `jurosParcelamento` negativo | 400 |
| 29 | `jurosParcelamento` ≥ `valor` do cartão | 400 |
| 30 | Baixa parcial com `CFG_JURPAR` = `N`, operador sem `BAIDUPJUR`, título sem juros próprio, só juros de parcelamento | passa — a trava olha só o juros do título (B3) |
| 31 | Lote com duplicata de crédito (`valorRecebido` negativo) e `jurosParcelamento` > 0 | crédito recebe rateio zero; o juros é distribuído só entre os itens positivos, somando o total exato |
| 32 | Lote só com duplicatas de crédito e `jurosParcelamento` > 0 | 400 — não há base positiva para ratear |

---

## 8. Decisões registradas

Alternativas avaliadas e descartadas, para não serem reabertas sem motivo novo:

| Alternativa | Por que foi descartada |
|-------------|------------------------|
| Taxa vinda de `CFG_JURATR` | Foi a primeira direção do levantamento e chegou a ser desenhada. Descartada em favor do cadastro por faixa, que permite percentual diferente por valor. `CFG_JURATR` é taxa de **mora**, não de parcelamento |
| Taxa vinda de `CFG_JURAGR` | Conceitualmente mais próxima (agrupamento de débito), mas mesma limitação: é config, não faixa |
| Taxa enviada na requisição | Deixaria a política de juros na mão do consumidor |
| Endpoint novo e separado | Obrigaria o app a duas chamadas para montar uma tela |
| `prazo_medio` = média dos vencimentos reais do cartão | Foi a única leitura que reproduziu o exemplo numérico inicial do solicitante (65 dias, 21,6667%), mas ele confirmou `n x 30` depois de a divergência ter sido apontada |
| `prazo_medio` = 30 x (n+1)/2 | Prazo médio de parcelas mensais. Mesma decisão acima |
| Primeira parcela sem juros | Chegou a ser pedido, e é incompatível com `prazo_medio = n x 30`. Revogado pela confirmação da fórmula |
| Campo `valorUltimaParcela` no contrato | Removido a pedido do solicitante; a última parcela é dedutível |
| Campo `percentualJurosTotal` por opção | Removido a pedido do solicitante |
| `FAI_CODEMP` na `FXCASA` | Migração maior, atinge PK, índice, cadastro e o endpoint em produção. Escopo global confirmado |
| Rateio do juros feito pelo app | Divergência de centavo entre app e serviço vira 400 e derruba o lote inteiro. O serviço rateia (6.1) |
| Recusar juros de parcelamento em baixa parcial | Foi a recomendação inicial, por causa do vazamento para o título de saldo. Descartada: o app consulta a faixa com o valor que vai baixar, então o juros já é sobre a parte baixada e vai inteiro para ela (B1) |
| Juros de parcelamento dentro do `TCalculoBaixaParcial` | Infla o `ValorPago`, que é divisor de todos os fatores, e o principal passa a ser abatido com dinheiro de juros (B1) |
| Juros de parcelamento somado ao `valorCorrigido` | `valorCorrigido` é a correção do título até hoje e não conhece meio de pagamento. Mantê-lo limpo preserva a validação de coerência atual e o contrato do endpoint de duplicatas |
| Campo próprio na `CADREC` para o juros de parcelamento (`CTR_JURPAR`) | Avaliado em 28/08/2026 para rastreabilidade: hoje o juros de parcelamento é somado ao `CTR_VALJUR` e fica **indistinguível** do juros de mora — na baixa de teste, `CTR_VALJUR` 417,51 era 200,98 de mora + 216,53 de parcelamento, e nada na `CADREC` separa os dois. Há precedente para o campo (`CTR_PIXJUR`, `CTR_PIXREC`, `CTR_PIXDES` fazem isso para o Pix). **Descartado** porque só a API gravaria: o acerto de conta do desktop, que também gera juros de parcelamento, trabalha num campo só. Campo preenchido em um caminho e vazio no outro faz relatório mentir por omissão — pior que não existir. Reabrir só junto com a alteração equivalente no desktop |
| `codigoCartao` opcional na simulação, para distribuir o centavo conforme `CAR_ARRPAR` | Seria mais fiel ao extrato, e daria para reusar `TArredondaParCartaoPos`. Descartado: amarra a simulação ao cartão, que hoje ela desconhece, e o ganho é a posição de um centavo. Decisão de 28/08/2026 — manter a última, como a R4 já dizia |
| `jurosParcelamento` como campo do lote | Chegou a ser implementado assim. Não representa um lote com dois cartões em parcelamentos diferentes, que teriam juros diferentes. O campo pertence ao cartão porque o juros é função da `quantidadeParcelas`, que é do cartão |
| `valorRecebido` das duplicatas incluindo o juros de parcelamento | Chegou a ser desenhado assim. Obrigaria a alterar também a validação de teto do recebido, e exigiria descontar o rateio antes de chamar `TCalculoBaixaParcial` — passo fácil de esquecer, com o saldo da duplicata como vítima. Mantendo o contrato das duplicatas intocado, as duas coisas se resolvem sozinhas (6.5) |

## 9. Pendências

1. **Aval do financeiro sobre a taxa única.** Colocar o percentual na faixa torna a política de
   parcelamento igual para todas as lojas da instância. É decisão de negócio, não técnica, e ainda
   não foi levada a quem responde por ela.
2. **Valor de `FAI_PERJUR` para as faixas já cadastradas.** Alguém precisa preencher; até lá o
   endpoint devolve juros zero (R5).
3. **Contrato da Parte B com o Felipe.** Do lado do consumidor a mudança é pequena — um campo a
   mais no lote, `duplicatas[]` como está hoje — mas a regra de fechamento (6.2) precisa estar clara
   antes de ele codificar: o cartão tem que cobrar exatamente as duplicatas mais o
   `jurosParcelamento` declarado, senão o lote é recusado.
4. **Duplicata de crédito no lote parcelado.** A regra proposta em 6.3 — crédito com rateio zero — é
   decisão minha, não do levantamento. Faz sentido matemático, mas ninguém confirmou se cobrar
   juros de parcelamento sobre o débito bruto, sem abater o crédito, é o comportamento comercial
   desejado. O caminho alternativo seria o app já enviar o valor líquido.
