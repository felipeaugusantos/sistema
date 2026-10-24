# untCadIte

> Unit genérica compartilhada — serve venda, devolução, compra, transferência e ajuste. Documenta
> apenas o que já foi tocado ou consumido por alguma rotina.

## Responsabilidade

Cadastro e saldo de item: atualização de `ITEGER`/`CADITE`.

## Caminho

`padra_atualizado/fontes/cadastros/untCadIte.pas`

Usada por: Garantia, Util_DLL, cadastros, cancelamento, faturamento, genericos, movimentacaoitens,
util.

## Rotinas que consomem

| Rotina | O que usa daqui |
|--------|-----------------|
| [balanço de estoque](balanco_de_estoque/balanco_de_estoque.md) | `fAtualizaEstoqueCadIte` — atualização do saldo do item no laço de documentos |

## Métodos

| Método | Tipo | O que faz | Efeito colateral |
|--------|------|-----------|------------------|
| `fAtualizaEstoqueCadIte(..., AUsarBatchSaldos)` | function | Atualiza `ITE_SALDOS` e demais campos de saldo em `ITEGER` | Grava, ou acumula no lote de saldos |
| `fMontaSQLAtualizaIteGer` | function | Monta o `UPDATE ITEGER` de saldo | Nenhum |

### Lote de saldos

`fMontaSQLAtualizaIteGer` passou a oferecer o `UPDATE` ao lote antes de executar:

```pascal
If Not (fUsouBatchSaldosSQL(strSQL) Or
        (AUsarBatchSaldos And fUsouBatchReprocessarSaldo([strSQL], True))) Then
```

Fora do balanço, `VS_objBatchSaldos` é `Nil` e o caminho antigo (execução imediata) vale byte a
byte. O parâmetro `AUsarBatchSaldos` já existia e continua com o mesmo significado.

## Pontos de atenção

- **`fAtualizaEstoqueCadIte` engole a exceção** e devolve `Result := False` em vez de propagar.
  Quem chama precisa tratar o `False` explicitamente — chamador que ignora o retorno segue adiante
  com o estoque **não** movimentado. No balanço isso já produziu documento fiscal emitido com saldo
  intocado e contagem consumida; a defesa hoje é a conferência de integridade da rodada, que não
  depende do retorno sobreviver ao laço.
- A unit serve o ERP inteiro. Qualquer mudança de comportamento aqui tem que entrar por parâmetro
  com default igual ao de hoje.
- Toda linha de `ITEGER` alterada dispara o trigger `BEFORE UPDATE` (~6 statements). Em rotina de
  volume, agregue antes de gravar.

## Alterações documentadas

| Data | Requisito/Revisão | O que mudou |
|------|-------------------|-------------|
| 2026-08-20 | Req. 456948 (Parte A) — alterações locais | `fMontaSQLAtualizaIteGer` passou a oferecer o `UPDATE` de saldo ao lote (`fUsouBatchSaldosSQL`) antes de cair no caminho anterior |
