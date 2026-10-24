# Req. 455155 — Diluente e percentual de diluição no POST /tintas/automotivas/precos

**Requisitante:** Caroline Oliva (07/08/2026)
**Envolvidos:** Ronaldo
**Módulo:** AUTCOM > Faturamento.Services.API > Tintas Automotivas

---

## 1. Objetivo

Acrescentar dois parâmetros ao contrato de `POST /tintas/automotivas/precos`:

| Campo | Tipo | Destino |
|-------|------|---------|
| `codigoDiluente` | string | `TINPRE_REQ.TPR_CODDIL` (coluna já existe, criada na Req. 432942) |
| `percentualDiluicao` | number | `TINPRE_REQ.TPR_PORDIL` (**coluna a criar**) |

`TINPRE_RES.TPR_PORDIL` já existe — é o percentual que o motor devolve após aplicar a
regra da marca. O que falta é a coluna de **entrada**, em `TINPRE_REQ`.

---

## 2. Contrato resultante

```json
{
  "codigoCliente": "string",
  "codigoEmpresa": "string",
  "idPro": "string",
  "hashesMd5": ["string"],
  "codigoEmbalagem": "string",
  "embalagemProduzida": "string",
  "volumeProduzido": 0,
  "modoVenda": "string",
  "codigoDiluente": "string",
  "percentualDiluicao": 0
}
```

O response **não muda**. Decisão da analista: não devolver o percentual aplicado.
Isso é coerente com a regra de validação abaixo — como valor fora da faixa é rejeitado,
o percentual aplicado é sempre o percentual enviado.

---

## 3. Regras de validação

### 3.1 `percentualDiluicao`

| `modoVenda` | Obrigatório | Validação |
|-------------|-------------|-----------|
| `D` (Diluído) | **Sim** | O valor precisa ser aceito pela fórmula da marca/linha — ver 3.1.1 |
| `C` (Concentrado) | Não | Nenhuma. Se enviado, é gravado e propagado sem crítica |

#### 3.1.1 Validação por confronto com a fórmula

A API **não replica** as faixas de diluição de cada marca. Ela alimenta
`Formula.PorDil` com o valor recebido, deixa o motor aplicar a própria regra
(`pAtualizaPorcentagem`) e **compara o valor devolvido com o enviado**:

- devolvido **igual** ao enviado → a fórmula aceitou → segue o cálculo
- devolvido **diferente** do enviado → a fórmula corrigiu → o item é recusado

O consumidor (Citel Sales) envia o percentual correto de cada linha, a partir de tabelas
estruturadas próprias. A API não confia cegamente nesse valor, mas também não duplica a
regra: quem julga é a própria fórmula.

Motivo do desenho: as faixas variam por marca **e** por produto/linha (§4). Uma constante no
endpoint bloquearia linhas legítimas e precisaria ser ressincronizada a cada marca nova ou
mudança de cadastro. O confronto acompanha o motor automaticamente.

Comparar com tolerância (`SameValue`), nunca com `=`: `Formula.PorDil` é `Double` e
`TPR_PORDIL` é `DECIMAL(8,4)`.

#### 3.1.2 Onde o erro aparece

**`mensagemErro` do item, não HTTP 400.** `hashesMd5` é array e cada hash pode cair num
produto diferente (ex.: POLIESTER e POLIURETANO na mesma requisição), então um mesmo
`percentualDiluicao` pode ser válido para um hash e inválido para outro — não existe
veredito de request inteira. Além disso, o confronto só é possível **depois** do cálculo.

Implementação: o worker grava `TPR_MSGERR`, e a infraestrutura existente já converte isso em
`mensagemErro` do item (`Faturamento.Services.Tintometrico.pas:435-436` → `:466-468`).
Mesma convenção da whitelist de marcas.

Custo aceito: um percentual inválido consome o cálculo completo daquele hash antes de ser
recusado. Não há como recusar antes — é preciso deixar o motor responder qual é a faixa.

### 3.2 `codigoDiluente`

Opcional, sem validação de conteúdo. Gravado em `TPR_CODDIL` e propagado até
`Formula.DilLinux` — pipeline já existente desde a Req. 432942, hoje alimentado com
`EmptyStr` de propósito (`Faturamento.Services.Tintometrico.pas:402`).

---

## 4. Faixas de diluição por marca — referência

Estas faixas **não são codificadas na API** (ver 3.1.1); estão aqui como documentação do
comportamento esperado e base para os casos de teste. Quem as aplica é a fórmula.

| Marca | Produto / Linha | Faixa real do motor | Fonte |
|-------|-----------------|---------------------|-------|
| AJT | POLIESTER | **50 fixo** | `untFormulaAutomotivaAnjoAutomotiva.pas:323-326` |
| AJT | POLIURETANO | **20 ou 30** | `untFormulaAutomotivaAnjoAutomotiva.pas:328-331` |
| AJT | POLIURETANO CONCENTRADO | livre (`arrMinMax` nunca inicializado) | `untFormulaAutomotivaAnjoAutomotiva.pas:315-334` |
| AJT | PU FLEET TECH | sem diluente (`Exit`) | `untFormulaAutomotivaAnjoAutomotiva.pas:342-343` |
| MZA | MLC | **100 fixo** | `untFormulaAutomotivaMazaAutomotiva.pas:276-277` |
| MZA | MHS, MPL | sem diluição (`Exit`) | `untFormulaAutomotivaMazaAutomotiva.pas:919-921` |
| MZA | demais linhas | **20 fixo** | `untFormulaAutomotivaMazaAutomotiva.pas:272` |
| MZD | todas | **20 fixo** | `untFormulaIndustrialMazaIndustrial.pas:884-885` |
| LAZ, DUX | — | sem lista de diluentes | `fGetDiluentes` base = nil |

Veredito resultante do confronto de 3.1.1, por combinação:

| Marca / produto | Enviado | Motor devolve | Resultado |
|---|---|---|---|
| AJT POLIURETANO | 20 | 20 | aceita |
| AJT POLIURETANO | 30 | 30 | aceita |
| AJT POLIURETANO | 25 | 30 | **recusa** |
| AJT POLIESTER | 50 | 50 | aceita |
| AJT POLIESTER | 20 | 50 | **recusa** |
| AJT POLIURETANO CONCENTRADO | qualquer | igual | aceita (sem faixa) |
| AJT PU FLEET TECH | qualquer | igual (`Exit`) | aceita |
| MZA MLC | 100 | 100 | aceita |
| MZA MLC | 20 | 100 | **recusa** |
| MZA demais | 20 | 20 | aceita |
| MZA demais | 30 | 20 | **recusa** |
| MZA MHS / MPL | qualquer | igual (`Exit`) | aceita |
| MZD | 20 | 20 | aceita |
| MZD | 30 | 20 | **recusa** |
| LAZ / DUX | qualquer | igual (bloco pulado) | aceita |

Nenhuma exceção codificada: onde existe faixa, ela é respeitada; onde não existe, o valor
passa livre.

### 4.1 Ressalva remanescente — `codigoDiluente` diverge entre tela e API

> **Esta seção descreve o comportamento ANTES desta req.** A decisão registrada mais abaixo
> ("Decidido em 25/08/2026") a supera: MZA e MZD passaram a honrar `codigoDiluente`, e na MZD o
> preço **varia** conforme o diluente. O levantamento fica aqui porque é o que justifica a
> decisão — não como estado atual.

**Via API, `codigoDiluente` não altera preço em nenhuma das 5 marcas da whitelist.**
Verificado por exaustão: `strCodDil` entra na fórmula em um único ponto
(`untDigDadosTintometricosAutomotiva.pas:101`, `Formula.DilLinux := strCodDil`), e `DilLinux`
tem 9 ocorrências em toda a `LibTintas/`, distribuídas em 5 arquivos:

| Arquivo | Ocorrências | Papel |
|---------|-------------|-------|
| `untAbstractFormulaAutomotiva.pas` | 2 | declaração da property |
| `untDigDadosTintometricosAutomotiva.pas` | 1 | a atribuição acima |
| `untFormulaAutomotivaColorPro.pas` | 4 | CPR — **consome** |
| `untFormulaAutomotivaDuxone2.pas` | 1 | DU2 — **consome** |
| `untFormulaAutomotivaFarbenAutomotiva.pas` | 1 | FAR — **consome** |

Nenhuma ocorrência em Lazzumix, Duxone, Anjo, Maza Automotiva ou Maza Industrial. Os três
consumidores reais (CPR, DU2, FAR) estão fora da whitelist da Req. 432942.

Reforços independentes: MZA deriva o diluente de `MZA_LINHA_`
(`untFormulaAutomotivaMazaAutomotiva.pas:1156-1160`), MZD de `MZD_LINHA_`
(`untFormulaIndustrialMazaIndustrial.pas:1112-1119`), AJT tem lista de item único
(`fGetDiluentes` com `WHERE BAS_CODBAS IN ("TH5003")`, linha 184) e LAZ não sobrescreve
`fGetDiluentes`, herdando o `Result := Nil` da base (`untAbstractFormulaAutomotiva.pas:818-821`).

#### Decidido em 25/08/2026 — a API passa a espelhar a tela

Premissa inegociável: **o que o operador faz na tela VCL, a API tem de reproduzir.**

| Situação | Comportamento definido |
|----------|------------------------|
| `codigoDiluente` **não** informado | primeiro item da lista — igual à tela recém-aberta |
| `codigoDiluente` informado | o diluente correspondente na lista da marca |
| `codigoDiluente` informado mas inexistente | primeiro item da lista (mesmo default) |

`codigoDiluente` transporta **código** (`BAS_CODBAS`), conforme o nome do campo.

Consequência: MZA e MZD deixam de derivar o diluente da linha do produto quando o campo não
vem. **Sem impacto retroativo** — a API ainda está em desenvolvimento e não há integração com
o Citel Sales, logo não existe consumidor em produção. Enquanto durar essa janela, corrigir
divergências tela ↔ API não custa migração.

#### O que havia de divergente antes desta decisão

`pReformulaNovo(strCodDil, ...)` da MZA busca `MZA_CADBAS` por `BAS_DESCRI = strCodDil` e
monta a base do diluente a partir do `BAS_CODITE` encontrado
(`untFormulaAutomotivaMazaAutomotiva.pas:1041-1055`). Diluente diferente → item diferente →
**custo diferente**. No path VCL quem alimenta esse parâmetro é
`cmbListaAdicional.Items[cmbListaAdicional.ItemIndex]`, ou seja, a escolha do operador
(`untAbstractDigTintaAutomotiva.pas:1539-1546`).

No path Linux o mesmo parâmetro vem de
`cmbListaAdicional[SetItemIndexLinuxDiluente(...)]`, e a MZA/MZD sobrescrevem esse método
para derivar da linha — descartando o que a API enviou.

Três divergências, todas corrigidas pela decisão acima:

| # | Divergência | Onde |
|---|-------------|------|
| D1 | Tela usa a escolha do operador; Linux usa `SetItemIndexLinuxDiluente`, que MZA/MZD sobrescrevem para derivar da linha, descartando `DilLinux` | `untAbstractDigTintaAutomotiva.pas:1522, 1536, 1543` |
| D2 | **Default divergente**: tela abre em `ItemIndex := 0`; Linux escolhe o diluente da linha | `untAbstractDigTintaAutomotiva.pas:2091-2092` |
| D3 | `IndiceAdicional := 0` fixo no Linux, mesmo quando o índice escolhido é outro | `untAbstractDigTintaAutomotiva.pas:1528` |

D2 **já existe hoje**, independente desta req: MZA/MZD via API podem precificar diferente da
tela recém-aberta mesmo sem ninguém informar diluente. Alcança o que a Req. 432942 homologou.

D3 não tem efeito prático na whitelist atual (MZA/MZD/AJT preenchem `arrMinMax` com valores
idênticos em todos os índices), mas vira preço errado assim que existir marca com faixa por
diluente.

#### Semântica da lista — por que a conversão é necessária

`fGetDiluentes` não guarda a mesma coisa em todas as marcas:

| Marca | `ListaAdicional` contém |
|-------|-------------------------|
| MZA | `BAS_DESCRI` — descrição (`untFormulaAutomotivaMazaAutomotiva.pas:225`) |
| MZD | `BAS_DESCRI` — descrição (`untFormulaIndustrialMazaIndustrial.pas:221`) |
| AJT | `BAS_CODBAS` — código (`untFormulaAutomotivaAnjoAutomotiva.pas:191`) |

Como o contrato transporta **código**, MZA e MZD precisam converter antes de casar. As duas
já têm `fRetornaDiluente` (descrição → código) — falta a inversa.

> **Verificar antes de liberar FAR, DU2 ou CPR:** as três já fazem
> `ListaAdicional.IndexOf(Self.DilLinux)` direto. Se as listas delas guardarem descrição, o
> contrato "código" as quebra.

---

## 5. Alcance — endpoints de pedido também recebem tinta

O requisito cita apenas `POST /tintas/automotivas/precos`, mas o fluxo de pedido
**recalcula o preço da tinta** em vez de confiar no valor recebido:
`TEmitirPedidoService.pInserirProduto` instancia o mesmo `TConsultarPrecoTinta` do worker
de preços e chama `pCarregarDadosTinta` (`Faturamento.Services.Pedido.pas:567-570`).

Se a consulta de preço calcular com percentual 30 e o pedido não transportar esse campo, o pedido
recalcula com o default clampado da marca e **fecha com preço diferente do apresentado ao
cliente**.

`codigoDiluente` já existe nos 5 DTOs de item de pedido. `percentualDiluicao` não existe em
nenhum:

| Serviço | Ponto | Situação |
|---------|-------|----------|
| `TEmitirPedidoService.pInserirProduto` | `Faturamento.Services.Pedido.pas:567-570` | recalcula preço; falta percentual |
| `TEmitirPedidoService.fCalcularPrecosSugestaoTinta` | `:750-760` | passa `codigoDiluente`; falta percentual |
| `TPedidoValidarUnitarioService.pInserirProduto` | `:2008-2013` | falta percentual |
| `TPedidoValidarPedidoService.pInserirProduto` | `:2166-2171` | falta percentual |
| `TPedidoCalcularTotalDesejadoProdutoService.pInserirProduto` | `:2278-2283` | falta percentual |
| `TPedidoTotalizadorService.pInserirProduto` | `:1867-1873` | **descarta 3 campos que já recebe** — ver §5.1 |

O record `recInfAut` **já possui** o campo `fltPorDil`, mas hoje só é preenchido como saída
do motor (`Faturamento.Services.Pedido.pas:594`), nunca como entrada — lacuna simétrica à da
API de preços.

### 5.1 Defeito pré-existente no Totalizador

`TPedidoTotalizadorItem` declara e documenta `codigoDiluente`, `volumeProduzido` e
`codigoEmbalagem` (`Faturamento.Services.Pedido.Types.pas:26-29, 62-65`), mas
`TPedidoTotalizadorService.pInserirProduto` copia apenas `embalagemProduzida` e `modoVenda`.
Os outros três são descartados em silêncio — quem chama o totalizador com tinta automotiva
já hoje recebe total divergente. **Independente desta req**; decidir se corrige junto.

---

## 6. Comportamento não alterado

Decisão explícita da analista: **não mudar regra de negócio das fórmulas**. O motor
continua clampando como hoje. A única mudança de comportamento é a crítica de entrada no
endpoint.

---

## 7. Critérios de aceitação

Casos a cobrir (escrita dos casos é do analista — ver CLAUDE.md, seção Testes):

Obrigatoriedade (verificável antes do cálculo → HTTP 400 de request):

1. `modoVenda = D` + `percentualDiluicao` ausente → HTTP 400
2. `modoVenda = C` + `percentualDiluicao` ausente → 200
3. `modoVenda = C` + `percentualDiluicao = 35` → 200, sem crítica

Confronto com a fórmula (→ `mensagemErro` do item, demais itens do array não afetados):

4. AJT POLIURETANO + 20 → 200, preço com 20
5. AJT POLIURETANO + 30 → 200, preço com 30, **diferente** do caso 4
6. AJT POLIURETANO + 25 → `mensagemErro`
7. AJT POLIESTER + 50 → 200
8. AJT POLIESTER + 20 → `mensagemErro`
9. MZA linha MLC + 100 → 200
10. MZA linha comum + 30 → `mensagemErro`
11. MZD + 20 → 200
12. Requisição com 2 hashes, um POLIESTER e um POLIURETANO, percentual 50 → item POLIESTER
    com preço, item POLIURETANO com `mensagemErro` (**prova que o erro é por item**)

Persistência e cache:

13. `TINPRE_REQ.TPR_PORDIL` gravado com o valor enviado
14. `TINPRE_RES.TPR_PORDIL` gravado com o valor aplicado pela fórmula
15. `codigoDiluente` informado → gravado em `TINPRE_REQ.TPR_CODDIL`
16. `codigoDiluente` diferente em MZD → preço **diferente**. É a prova de que o código enviado
    chegou até a fórmula. Os três diluentes da MZD são itens distintos, com preços que vão de
    R$ 33,64 (`12380`, THINNER P/ PU 5230) a R$ 443,50 (`10422`, THINNER SM 800)
16b. `codigoDiluente` diferente em MZA → preço **idêntico**, mas por ausência de cadastro, não
    por regra: `MZA_CADBAS` não tem nenhuma linha com `BAS_EFEITO = 'DILUENTE'`, então a lista
    sai vazia e não há o que escolher. **Este critério cai** se o diluente da MZA for cadastrado
17. Cache: mesma requisição com `percentualDiluicao` diferente **não** reaproveita
    `TPR_RES_ID` anterior

Casos do fluxo de pedido (§5):

18. Consulta de preço AJT POLIURETANO com 30 → pedido emitido com o mesmo item e percentual 30 →
    **preço do pedido igual ao da consulta**
19. Mesmo cenário sem enviar `percentualDiluicao` no pedido → **200, com preço recalculado pelo
    default da fórmula**. Não há crítica de obrigatoriedade nas rotas de pedido — ver §8.2. O
    caso serve para medir a divergência, não para exigir erro
20. `validar-pedido` / `validar-unitario` / `total-desejado` com percentual → mesmo preço
    dos demais fluxos
21. Totalizador com tinta automotiva → total coerente com o pedido emitido

### 7.1 Armadilha da massa de teste — sem diluente cadastrado o teste dá falso positivo

`pAtualizaPorcentagem`, que é quem aplica a faixa da marca, começa assim
(`untFormulaAutomotivaMazaAutomotiva.pas`):

```pascal
If Formula.ListaAdicional.Count <= 0 Then
  Exit;
```

Com a lista de diluentes vazia ele **sai antes de clampar**. O percentual enviado sobrevive
intacto, a API compara enviado com devolvido, acha igual e aceita. Resultado: mandar `30` numa
linha de faixa 20 devolve **200**, não `mensagemErro`.

O caso de teste passa quando deveria reprovar, e o sintoma aponta para a API quando a causa é
cadastro.

Vale para qualquer marca. Antes de escrever caso de confronto, conferir que a marca tem ao menos
uma linha com `BAS_EFEITO = 'DILUENTE'`, com `BAS_CODITE` apontando para item que exista em
`CADITE` **e** em `ITEGER` da empresa de teste — `fGetDiluentes` faz *inner join* nas duas,
filtrado por empresa.

Um diluente basta: `arrMinMax` é dimensionado por `ListaAdicional.Count` e preenchido com
`fRetMinMax`, que devolve o mesmo valor em todos os índices.

Em 26/08/2026 a MZA estava nessa condição — `MZA_CADBAS` só tinha `BAS_EFEITO` `BRILHANTE` (19)
e `BRILHANTE2` (1), nenhuma `DILUENTE`.

---

## 8. Fora de escopo

- Alterar faixas de diluição das fórmulas (seria mudança de regra de negócio + tela do
  autcom, requisito próprio)
- Habilitar marcas fora da whitelist LAZ/DUX/AJT/MZA/MZD
- Devolver percentual/diluente aplicado no response

Resolvidos durante a implementação — os dois foram **incluídos**:

- Bug de índice em `TFormulaAutomotivaMazaAutomotiva.SetItemIndexLinuxDiluente` — o laço ia de
  `0 To Count` em vez de `0 To Count - 1`. Custo marginal zero, o corpo do método foi reescrito
- Descarte de campos no `TPedidoTotalizadorService` (§5.1)

### 8.1 Consulta dentro de laço em `SetItemIndexLinuxDiluente` — medido e decidido não corrigir

A conversão descrição → código usa `fRetornaDiluente`, que consulta o banco **por item da
lista**. O override anterior era string pura. E o chamador invoca o método **4 vezes no mesmo
bloco** (`untAbstractDigTintaAutomotiva.pas:1522, 1528, 1536, 1543`).

Medido antes de decidir (26/08/2026):

| Marca | Custo real |
|-------|-----------|
| MZA | **zero** — sem linha `BAS_EFEITO='DILUENTE'` em `MZA_CADBAS`, sai antes do laço |
| MZD | 4 diluentes × 4 chamadas = **16 consultas**, ~1-4 ms cada, tabela de 61 linhas com índice |
| Outras 87 marcas | **zero** — usam a base, que faz `IndexOf` em memória |

Total ~30 ms, num cálculo assíncrono (fila → worker filho → tabela de tarefa → polling) que
leva segundos.

O conserto **seria correto**: içar a chamada para uma variável local nos 4 pontos é seguro,
porque nada entre `:1522` e `:1543` altera `ListaAdicional` nem `DilLinux` — o `Clear` só
acontece dentro do `fGetDiluentes`, que roda antes. Mas o arquivo é a classe abstrata que as
**89 marcas** compilam: recompilar e reimplantar todas para ganhar 30 ms em uma marca é troca
ruim.

**O que inverteria a decisão:** marca com lista de diluentes grande. Com 4 itens é ruído; com 40
não é.

### 8.2 Obrigatoriedade do percentual nas rotas de pedido — decidido não implementar

A crítica de `percentualDiluicao` obrigatório com `modoVenda = D` existe **só** na rota de preços
(`Faturamento.Services.Tintometrico.pas`). As cinco rotas de pedido transportam o campo mas não o
exigem.

Consequência: pedido sem o campo recalcula com o default da fórmula e **pode fechar com preço
diferente da consulta de preço**, em silêncio. É a mesma divergência que motivou o escopo estendido da §5 —
resolvida no transporte, não na exigência.

Decidido em 26/08/2026 documentar em vez de implementar. A descrição Swagger dos cinco DTOs passou
a dizer o que de fato acontece:

> Percentual de diluição (Tinta automotiva). O pedido recalcula o preço da tinta, então envie o
> mesmo valor usado na consulta de preço — omitido, recalcula com o default da fórmula e o
> divergir.

**O que inverteria a decisão:** integração real do Citel Sales com tinta automotiva. Enquanto não
existe consumidor em produção, a divergência não alcança ninguém; a partir daí, avisar no contrato
deixa de bastar. O `modoVenda` já está nos cinco DTOs e chega aos mapeadores, então implementar é
repetir a mesma condição da rota de preços em cinco pontos.
