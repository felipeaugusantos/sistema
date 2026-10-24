# Req. 455155 — Plano técnico

## 1. Natureza da mudança

Dois parâmetros novos no endpoint. `codigoDiluente` só precisa deixar de ser zerado —
o pipeline inteiro já existe. `percentualDiluicao` precisa de **coluna nova + propagação
até o motor**, porque `Formula.PorDil` nunca é alimentado no path Linux (chega sempre 0).

O ponto de injeção é conhecido: `untDigDadosTintometricosAutomotiva.pas:100-102`, onde
`Formula.DilLinux := strCodDil` já roda sob `{$IFDEF LINUX}`. `Formula.PorDil` entra ao
lado, **antes** de `pAtualizaPorcentagem` ser chamado em
`untAbstractDigTintaAutomotiva.pas:1530`.

Padrão de assinatura: **parâmetro opcional no fim** (`fltPorDil: Double = 0`) — mesmo
recurso usado na Req. 432942 para `fltVolPro`/`strIteEmb`, que mantém todos os chamadores
existentes compilando sem alteração.

---

## 2. Cadeia de propagação

Cinco camadas. A ordem de implementação é de baixo para cima (motor primeiro), para que
cada passo compile isolado.

### Camada 5 — libTintas (recompilação em lockstep de **todas** as marcas)

São **duas** cadeias paralelas, não uma: `RetornaPreco` (lib → calculador) e
`fDigDadosTintometricos` (calculador → dig dados). Cada uma tem interface + abstract +
override, e todas precisam do parâmetro.

Cadeia `RetornaPreco`:

| Unit | Alteração |
|------|-----------|
| `Interfaces/untILibTinta.pas:38` | + `fltPorDil: Double = 0` |
| `Genericos/untAbstractLibTinta.pas:47` | + param na virtual abstract |
| `Genericos/untAbstractLibTintaAutomotiva.pas:83, 771` | + param na decl e impl |
| `Genericos/untAbstractLibTintaAutomotiva.pas:799` | repassar a `calculador.fRetornaPreco` |
| `Genericos/untAbstractLibTintaImobiliaria.pas:53, 408` | + param (só acompanhar assinatura) |

Cadeia `fDigDadosTintometricos`:

| Unit | Alteração |
|------|-----------|
| `Interfaces/untICalculadorPrecoTinta.pas:17` | + param — **obrigatório**: `TAbstractCalculadorPrecoTinta` implementa essa interface, alterar só a classe não compila |
| `Genericos/untAbstractCalculadorPrecoTinta.pas:25, 45` | + param em `fRetornaPreco` |
| `Genericos/untAbstractCalculadorPrecoTinta.pas:138` | repassar a `fDigDadosTintometricos` |
| `Interfaces/untIDigDadosTintometricos.pas:17` | + param |
| `Genericos/untAbstractDigDadosTintometricos.pas:54` | + param na virtual abstract |
| `Genericos/untDigDadosTintometricosAutomotiva.pas:29, 52` | + param no override |
| `Genericos/untDigDadosTintometricosAutomotiva.pas:100-105` | **`Formula.PorDil := fltPorDil;`** dentro do `{$IFDEF LINUX}` existente |
| `Genericos/untDigDadosTintometricosImobiliaria.pas:27, 50` | + param (só acompanhar assinatura) |

Não mudam:

- `Genericos/untAbstractConsultaComp.pas:61` — chama só com 2 argumentos, todos os demais por default
- `LibTintas/libTintasComum/velhos/` — hierarquia separada, assinatura antiga de 2 parâmetros
- Nenhuma lib de marca sobrescreve `RetornaPreco` — verificado por varredura
- `IAutcomTinta.fRetornaPreco` (`untTintaMaquina.pas:2483`) — path legado das tintas velhas
  (SAL, GLA), não transporta nem `strEmbPro` nem `strCodDil` hoje

### Camada 4 — hub AutcomTinta

| Unit | Local | Alteração |
|------|-------|-----------|
| `untTintaMaquina.pas:204-206` | `autcomtinta/` | + param na declaração de `fRetornaPrecoTintaSemTela` |
| `untTintaMaquina.pas:2404-2406` | idem | + param na implementação + repasse ao calculador |
| `untTintaMaquina.pas:199-202` | idem | avaliar `fRetornaPrecoTABSemExecutarConsulta` (mesma cadeia) |
| `AutcomTinta.dpr` | idem | conferir bloco `exports` |

### Camada 3 — ponteiro de função no autcom

| Unit | Local | Alteração |
|------|-------|-----------|
| `untFuncTinta.pas:42-43` | `padra_atualizado/fontes/genericos/` | + param no tipo de `fRetornaPrecoTintaSemTela` |

### Camada 2 — worker de consulta de preço

`padra_atualizado/Services/Consulta.Preco.Tinta/Source/Services.ConsultarPreco.Tinta.pas`

| Ponto | Alteração |
|-------|-----------|
| record de request (~linha 27-33) | novo campo `FPorDilReq: Double` — **distinto** de `FPorDil` (linha 64), que é o valor de **retorno** do motor |
| `Create` / `New` (linhas 175-186) | novo parâmetro `APorDil: Double = 0` |
| `pExecuteAll` (~linha 522-529) | ler `TPR_PORDIL` da query de pendentes |
| `pLocalizarCacheID` (linhas 839-865) | **+ `TPR_PORDIL` na chave de cache** (bloco `ttAutomotiva`), com `ROUND(IFNULL(...,0),4)` igual ao `TPR_VOLPRO` |
| chamada `fRetornaPrecoTintaSemTela` (linha 1090) | passar `FPorDilReq` |
| `fGetSQLConsultaPrecoTintaPendentes` | incluir `TPR_PORDIL` no SELECT |

### Camada 1 — API REST

| Unit | Alteração |
|------|-----------|
| `Faturamento.Services.Tintometrico.Types.pas:110-177` | 2 properties novas em `TTintasAutomotivasCarregarDadosParams` + atributos `MVCSwagJsonSchemaField` |
| `Faturamento.Services.Tintometrico.pas` (`fCarregarDadosAutomotivas`, ~linha 345-405) | validação 20/30 + gravar `TPR_CODDIL` (trocar `EmptyStr` da linha 402) e `TPR_PORDIL` |
| `Faturamento.Services.Tintometrico.pas:126-137` | `TConsultarPrecoTintaMonitor.New` — repassar `TPR_PORDIL` |

### Camada 1b — API REST de pedido (ver `spec.md` §5)

O construtor `TConsultarPrecoTinta.Create` é **compartilhado** entre o worker de preços e o
fluxo de pedido. Adicionar `APorDil: Double = 0` ali (Camada 2) atende os dois — o trabalho
restante é só transportar o campo pelos DTOs e mapeadores.

`Faturamento.Services.Pedido.Types.pas` — nova property `percentualDiluicao: Double` + Swagger
nos 5 DTOs de item, ao lado do `codigoDiluente` que já existe:

| DTO | Linha da classe | `codigoDiluente` em |
|-----|-----------------|---------------------|
| `TPedidoTotalizadorItem` | 13 | 28 / 62 |
| `TPedidoCalcularPrecosSugestaoItem` | 406 | 418 / 449 |
| `TPedidoValidarUnitarioItem` | 582 | 596 / 630 |
| `TPedidoValidarPedidoItem` | 769 | 783 / 817 |
| `TPedidoCalcularTotalDesejadoProdutoItem` | 984 | 998 / 1028 |

`Faturamento.Services.Pedido.pas` — mapeadores:

| Ponto | Alteração |
|-------|-----------|
| `:567-570` | passar `recInfAut.fltPorDil` a `TConsultarPrecoTinta.Create` |
| `:750-760` | passar percentual a `fGetPrecoSugestaoTinta` (+ assinatura da função) |
| `:1642-1648` | `LItem.percentualDiluicao := Item.percentualDiluicao` |
| `:2008-2013` | `recInfAut.fltPorDil := Item.percentualDiluicao` |
| `:2166-2171` | idem |
| `:2278-2283` | idem |
| `:1867-1873` | idem **+ ver §6** (mapeador incompleto) |

> `recInfAut.fltPorDil` já existe no record — hoje só recebe o retorno do motor
> (`:594`). Passa a ser entrada **e** saída, como `strCodDil` e `fltVolume` já são.

Cuidado de ordem: em `:567-570` o valor precisa estar em `recInfAut.fltPorDil` **antes** da
chamada; a linha `:594` sobrescreve com o retorno do motor **depois**. Não inverter.

---

## 3. Banco

`padra_atualizado/Services/Consulta.Preco.Tinta/Scripts/SCRIPT_001_CRIAR_TABELAS_E_FUNCOES.sql`

Acrescentar ao bloco de `ALTER` da Req. 432942 (linhas 39-47), seguindo o mesmo padrão de
comentário + `ALTER`:

```sql
# Req. 455155 - PERCENTUAL DE DILUICAO DE ENTRADA
# TPR_PORDIL: percentual enviado pelo consumidor (TINPRE_RES.TPR_PORDIL ja existe e guarda o aplicado)
ALTER TABLE TINPRE_REQ ADD COLUMN TPR_PORDIL DECIMAL(8,4) DEFAULT NULL;
```

Tipo `DECIMAL(8,4)` espelha `TINPRE_RES.TPR_PORDIL` (linha 103 do mesmo script).

---

## 4. Validação — duas críticas, em lugares diferentes

### 4.1 Obrigatoriedade — antes do cálculo, erro de request

Em `fCarregarDadosAutomotivas`, junto de `pValidarCliente` (antes do loop de hashes). Não
depende da marca, então cabe como HTTP 400:

```pascal
// Req. 455155 - com diluicao, o percentual e obrigatorio.
if SameText(dadosTinta.modoVenda.Trim, 'D') and
   IsZero(dadosTinta.percentualDiluicao) then
  raise EInvalidParams.Create('Percentual de dilui' + #231 + #227 + 'o deve ser informado.');
```

Atenção: `modoVenda` aceita `"C"`/`"Concentrado"`/`"D"`/`"Diluido"` (case-insensitive, com
ou sem acento) conforme Swagger da 432942. Usar a **mesma normalização** já aplicada ao
campo, não comparar a string crua.

### 4.2 Confronto com a fórmula — depois do cálculo, erro por item

A API **não codifica** as faixas de diluição (§5). Alimenta `Formula.PorDil`, deixa
`pAtualizaPorcentagem` aplicar a regra da marca e compara o devolvido com o enviado.

Local natural: o worker, em `Services.ConsultarPreco.Tinta.pas`, depois de `FPorDil` receber
`FDicTin['pordil']` (linha 1460):

```pascal
// Req. 455155 - formula corrigiu o percentual: valor enviado nao e aceito por esta linha.
if (FPorDilReq > 0) and (not SameValue(FPorDil, FPorDilReq, 0.0001)) then
  raise Exception.Create('Percentual de dilui' + #231 + #227 + 'o ' +
    FormatFloat('0.####', FPorDilReq) + ' nao e aceito para este produto.');
```

A exceção vira `TPR_MSGERR` pelo `pRegistrarErroConsultaPreco` já existente, e a camada API
converte em `mensagemErro` do item (`Faturamento.Services.Tintometrico.pas:435-436` →
`:466-468`). Nenhuma infraestrutura nova.

Pontos de atenção:

- **Tolerância obrigatória.** `Formula.PorDil` é `Double`, `TPR_PORDIL` é `DECIMAL(8,4)`.
  Comparar com `=` produz recusa falsa.
- **Verificado:** `dicRetorno['pordil'] := Formula.PorDil` está em
  `untDigDadosTintometricosAutomotiva.pas:527`, **fora** do `{$IFNDEF LINUX}` — o valor
  aplicado volta no path Linux.
- **Guarda `FPorDilReq > 0`.** Sem percentual enviado não há o que confrontar; o motor aplica
  o default da marca, como hoje.
- **O cálculo roda antes da recusa.** Não há como antecipar — é o motor que informa a faixa.
- **`TPR_PORDIL` de `TINPRE_RES`** passa a ter valor diagnóstico: quando difere do de
  `TINPRE_REQ`, mostra qual percentual a fórmula queria.

---

### 4.3 Endpoints de pedido

O confronto de 4.2 vive no worker, que o fluxo de pedido **também** atravessa
(`TConsultarPrecoTinta` compartilhado) — logo vale de graça nos dois. Falta só decidir como
cada serviço de pedido reporta: inconsistência por item ou exceção de request. Verificar
`pValidarUnitario` e `pValidarTabPreco` antes de escolher.

---

## 5.5 Alinhamento tela ↔ API do diluente (`spec.md` §4.1)

Três alterações. A do meio resolve D1, D2 e o bug de índice da MZA de uma vez.

**a) Base — passa a honrar `DilLinux`**

`untAbstractFormulaAutomotiva.pas:2409-2413`, hoje `Result := 0`:

```pascal
Result := ListaAdicional.IndexOf(Self.DilLinux);
If Result = -1 Then
  Result := 0;
```

Serve as marcas cuja `ListaAdicional` guarda código (AJT). Torna os overrides de FAR e DU2
redundantes — **não removê-los** nesta req.

**b) MZA e MZD — override que converte código → descrição**

Substitui a derivação por linha. Em `untFormulaAutomotivaMazaAutomotiva.pas:1142-1161` e
`untFormulaIndustrialMazaIndustrial.pas:1108-1126`:

```pascal
Result := 0;

If (ListaAdicional = Nil) Or (ListaAdicional.Count <= 0) Then
  Exit;

If TStrUtils.fEmptyStr(Self.DilLinux) Then
  Exit;                                    // sem escolha: primeiro item, igual a tela

// Req. 455155 - lista guarda BAS_DESCRI, contrato REST envia BAS_CODBAS.
For intContador := 0 To ListaAdicional.Count - 1 Do
  If fRetornaDiluente(ListaAdicional[intContador]) = Self.DilLinux Then
    Exit(intContador);
```

`Count - 1` mata o bug de índice (§6) no mesmo lugar.

**Custo a avaliar:** `fRetornaDiluente` abre uma query por item, e isso roda por hash. Se a
lista de diluentes for grande, preferir uma função inversa
`fRetornaDescricaoDiluente(strCodBas)` — uma query só, simétrica à existente — e então
`ListaAdicional.IndexOf(...)`.

**c) `IndiceAdicional` — parar de fixar zero**

`untAbstractDigTintaAutomotiva.pas:1528`:

```pascal
{$ELSE}
  Self.Formula.IndiceAdicional := Self.Formula.SetItemIndexLinuxDiluente(Self.dtsCadTin, cmbListaAdicional);
{$ENDIF}
```

Alinha com `cmbListaAdicional.ItemIndex` do VCL e com o índice já usado nas linhas 1522,
1536 e 1543.

**Sem regressão:** MZA/MZD sem `codigoDiluente` passam do diluente da linha para o primeiro
da lista, mas a API está em desenvolvimento e sem integração com o Citel Sales — não há
consumidor em produção para migrar.

---

## 6. Bug latente — decisão pendente

`TFormulaAutomotivaMazaAutomotiva.SetItemIndexLinuxDiluente`
(`untFormulaAutomotivaMazaAutomotiva.pas:1156`) itera
`For intContador := 0 To ListaAdicional.Count Do` e indexa `ListaAdicional[intContador]` →
`EStringListError` no índice `Count` quando o diluente da linha não está na lista. A MZD
não tem o problema (usa `IndexOf` + fallback `-1` → 0). Só alcançável no path Linux.

Correção: `Count - 1` no limite do loop. Quando nada casa, `Result` permanece `0` — valor já
atribuído na linha 1153 e exatamente o fallback que a MZD faz de propósito. Uma linha, sem
regra nova.

**Recomendação: incluir nesta req.** Esta req já recompila todas as libTintas em lockstep,
então o custo marginal é zero, e ela passa a exercitar esse caminho com dado vindo de fora.

---

## 7. Defeito pré-existente no Totalizador — entra nesta req

`TPedidoTotalizadorService.pInserirProduto` (`Faturamento.Services.Pedido.pas:1867-1873`)
copia apenas `embalagemProduzida` e `modoVenda`, descartando `codigoDiluente`,
`volumeProduzido` e `codigoEmbalagem` — que o DTO `TPedidoTotalizadorItem` declara e
documenta no Swagger. Os outros quatro mapeadores de item copiam os cinco.

O dano vem da linha seguinte, `inherited pInserirProduto(dadosProduto)`, que cai no
`TEmitirPedidoService.pInserirProduto` — o método que **recalcula o preço da tinta** e
consome exatamente os três campos não preenchidos (`:567-570`). Chegam vazios e zerados, o
recálculo cai nos defaults da fórmula, e o total devolvido **não bate com o pedido emitido**.

Correção: 3 linhas, mesmo formato dos irmãos. Entra porque essas linhas serão abertas de
qualquer forma para acrescentar `percentualDiluicao`.

**Rastreabilidade:** o commit leva `Req. 455155`, mas isto não está no texto do requisito.
Descrever em bloco próprio no `analysis.md`, marcado como defeito pré-existente encontrado no
caminho — senão o revisor lê como escopo vazando.

---

## 8. Riscos

| Risco | Mitigação |
|-------|-----------|
| Recompilação lockstep de todas as libTintas | Parâmetro opcional no fim mantém compatibilidade de fonte, mas **não** de binário — todas as `.so`/`.dll` precisam subir juntas. Ver `autpas-tinta-linux-linkagem-dinamica` |
| Cache devolvendo preço de percentual anterior | `TPR_PORDIL` na chave de `pLocalizarCacheID` — item obrigatório, não opcional |
| `FPorDil` (retorno) confundido com `FPorDilReq` (entrada) | Nomes distintos; `FPorDil` continua vindo de `FDicTin['pordil']` na linha 1460 |
| ANJO POLIESTER / MAZA MLC bloqueados | Aceito e registrado em `spec.md` seção 4 |
