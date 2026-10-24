# untCadLote

> Unit genérica compartilhada — `TCadLot` é usada por Garantia, cadastros, cancelamento,
> faturamento, financeiro, industrial, movimentacaoitens, relatorios e util. Documenta apenas o que
> já foi tocado ou consumido por alguma rotina.

## Responsabilidade

Classe `TCadLot`: manutenção de lote (`CADLOT`) — saldo, contagem, localização física (`LOTLOC`) e
histórico.

## Caminho

`padra_atualizado/fontes/cadastros/untCadLote.pas` — interface em
[untICadLote.md](untICadLote.md). Encoding **latin-1 + CRLF**.

## Rotinas que consomem

| Rotina | O que usa daqui |
|--------|-----------------|
| [balanço de estoque](balanco_de_estoque/balanco_de_estoque.md) | `fZeraContagemLote` (Fase 2 do zeramento), `fZeraContagemLoteRodada`, atualização de saldo de lote |

Outros chamadores de `fZeraContagemLote`: `untBalancoEstoqueZera`, `untBalancoEstoqueZerarSaldo` e
o overload interno — todos no caminho de hoje, sem alteração.

## Métodos

| Método | Tipo | O que faz | Efeito colateral |
|--------|------|-----------|------------------|
| `fZeraContagemLote(strArmazens, strCodIte, blnLimpar, strFilExt, event_Parametros, AblnAtualizaIteger)` | function overload | Zera a contagem de um lote via `UPDATE` conjugado `CADLOT ⋈ ITEGER ⋈ CADITE` | Grava `CADLOT` e, com `AblnAtualizaIteger = True`, também `ITEGER` |
| `fZeraContagemLoteRodada(AstrConId, AstrCodCon)` | function | Zeramento de **toda a rodada** numa passada, dirigido por `BALZER` | Grava `CADLOT` e `LOTLOC` |
| `fZeraContagemLocFis(ANumLot, ALocFis)` | function | Zera a contagem de uma localização | Grava |
| `fSaldoMLLote` | function | Saldo em g/ml do lote | Nenhum |
| `fTemDocumentoLote` | function | Diz se o lote tem documento | Nenhum |
| `fMontaSQLAtualizaCadLot` | function | Monta o `UPDATE` de saldo do lote | Nenhum |

### `AblnAtualizaIteger: Boolean = True`

`False` suprime a parte `G.ITE_*` do `SET` do `UPDATE` conjugado. Quem chama com o default não muda
em nada. Só o balanço passa `False`, porque a Fase 1 do zeramento já gravou os mesmos seis campos
(`ITE_SALCON`, `ITE_ORDCON`, `ITE_GMLCON`, `ITE_DIGCON`, `ITE_DIFSAL`, `ITE_DIF_ML`) com os mesmos
valores, em lote. Eram 216 toques em `ITEGER` por rodada — 34% do total — cada um custando statements
de trigger.

### `fZeraContagemLoteRodada` — o que ela faz e o que ela deliberadamente **não** faz

Dois `UPDATE` dirigidos por `BALZER` (`ZER_CON_ID` + `ZER_CODCON` + `ZER_ORIGEM = 'Z'`, com
`ZER_NUMLOT <> ''`):

1. `LOTLOC ⋈ CADLOT ⋈ BALZER` — `LLC_SALCON = 0`, `LLC_DIGCON = 'N'`. Só quando
   `fUsaMaisDeUmaLocalizacaoFisicaPorLote`.
2. `CADLOT ⋈ BALZER` — `LOT_SALCON`, `LOT_ML_CON`, `LOT_DIFSAL`, `LOT_DIF_ML`, `LOT_ORDCON` zerados e
   `LOT_DIGCON = 'N'`.

Os campos e valores são os do ramo `blnLimpar = True` do `UPDATE` conjugado — o único ramo que o
balanço usava.

| Não faz | Por quê |
|---------|---------|
| Não toca `ITEGER` | A Fase 1 já gravou os mesmos seis campos em lote |
| Não grava `CONDET` | Quem faz é `TConDet.fGravaConDetZeraLotesRodada`, chamada **antes** desta, porque precisa de `LOT_SALCON`/`LOT_DIGCON` pré-zeramento |
| Não limpa `HISBAL` | A Fase 1 já faz `DELETE FROM HISBAL` por item, superconjunto do por lote |

**Invariante:** nenhum comando de `fZeraContagemLoteRodada` escreve em `LOT_QTDAJU`, `LOT_SEQAJU` ou
`LOT_DTAAJU` — igual ao `UPDATE` conjugado. Só `fAplicaAjusteCadLot` escreve nesses campos.

### Lote de saldos

`fMontaSQLAtualizaCadLot` passou a oferecer o `UPDATE` ao lote de saldos antes de executar:

```pascal
If Not (fUsouBatchSaldosSQL(strSQL) Or
        (AUsarBatchSaldos And fUsouBatchReprocessarSaldo([strSQL], True))) Then
```

Fora do balanço, `VS_objBatchSaldos` é `Nil` e o caminho antigo vale.

## Pontos de atenção

- A assinatura anterior de `fZeraContagemLote` tinha `blnTableTmp`, removido junto com as tabelas
  temporárias de contagem. Não reintroduzir.
- `BALZER` precisa existir no banco do cliente para o caminho `*Rodada` funcionar.
- O `UPDATE` conjugado com `ITEGER` é caro: cada linha de `ITEGER` alterada dispara o trigger
  `BEFORE UPDATE` (~6 statements). Evitar tocá-la quando o estado já foi gravado.

## Alterações documentadas

| Data | Requisito/Revisão | O que mudou |
|------|-------------------|-------------|
| 2026-08-20 | Req. 456948 (Parte A) — alterações locais | `fMontaSQLAtualizaCadLot` passou a oferecer o `UPDATE` de saldo ao lote (`fUsouBatchSaldosSQL`) |
| 2026-08-20 | Req. 456948-B (Parte B) — alterações locais | `fZeraContagemLote` perdeu `blnTableTmp` e ganhou `AblnAtualizaIteger: Boolean = True`; criada `fZeraContagemLoteRodada` (zeramento set-based dirigido por `BALZER`) |
