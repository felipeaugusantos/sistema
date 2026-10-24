# untTBatchSQL.Helper

> Unit genérica compartilhada. Documenta apenas o que já foi tocado ou consumido por alguma rotina.

## Responsabilidade

Helper de `TBatchSQL` (`untTBatchSQL`): utilitários para acumular comandos em lote em vez de
executá-los um a um.

## Caminho

`padra_atualizado/fontes/genericos/BatchSQL/untTBatchSQL.Helper.pas`

## Rotinas que consomem

| Rotina | O que usa daqui |
|--------|-----------------|
| [balanço de estoque](balanco_de_estoque/balanco_de_estoque.md) | `TBatchHelper.PostOuAcumula` no caminho do `MOVDET` (via `untMovGer`) |

## Por que existe

`TBatchSQL.AddQueryAsCommand` extrai SQL de query montada com parâmetros. `fGravaMovDet` **não**
escreve por `ExecSQL`: escreve por dataset (`Insert` / `FieldByName` / `Post`). `AddQueryAsCommand`
não alcança esse idioma — daí o helper.

## Métodos

| Método | Tipo | O que faz | Efeito colateral |
|--------|------|-----------|------------------|
| `PostOuAcumula(ADataSet, AstrTabela, ABatch)` | class procedure | Com `ABatch = Nil`, faz `ADataSet.Post` — comportamento de hoje, intocado. Com `ABatch` atribuído, monta o `INSERT` a partir dos campos do dataset, acumula no lote e **cancela** a inserção | Acumula comando; o dataset não vai ao banco |
| `fFloatParaSQL(AValor)` | class function | Formata `Double` para SQL com ponto decimal, máscara `0.########` | Nenhum |

### Regras de montagem do `INSERT` — não alterar sem medir

1. **Campo nulo é OMITIDO do `INSERT`, não emitido como `NULL`.** O `Post` do UniDAC inclui só os
   campos **modificados**; coluna não tocada fica de fora e o MySQL aplica o `DEFAULT` da tabela.
   Emitir `NULL` sobrescreveria esse default — medido: 11 colunas do `MOVDET` vinham `0.00` ou `"N"`
   e passaram a vir `NULL` em 280 linhas.
2. **Exceção — `blob` e `memo` nunca são omitidos.** O Delphi mantém `IsNull = True` neles mesmo
   depois de receber string vazia, mas o UniDAC grava o campo porque foi modificado. Medido no
   `DET_DESNES` (`text`): a base gravava `''` e omitir passou a gravar `NULL` em 280 linhas.
3. Campo `ReadOnly` é ignorado.
4. `fFloatParaSQL` replica a máscara de `fDoubleToSQL` em vez de importar `untFuncoesGenerica`, que
   é enorme e traria dependência transitiva para esta unit.

## Pontos de atenção

- **Integridade referencial:** com o lote ativo, **nenhuma** escrita da função chamadora pode ficar
  fora dele. Se o pai (`MOVDET`) é adiado e uma filha (`MOVTRI`, `MOVAUX`, `MOVREF`, `BRIDET`)
  continua em `Post` imediato, o insert da filha falha na FK. Conversão parcial é incorreta, não
  apenas subótima.
- O helper passa a gerar **SQL literal** onde o UniDAC parametrizava. Erro de formatação — decimal,
  data, aspas, `NULL`, charset — é silencioso. O controle é diff coluna a coluna contra a versão
  base.
- A ordem é preservada quando o lote se parte em grupos de `BatchSize`, porque os grupos são
  executados em sequência na mesma transação.

## Alterações documentadas

| Data | Requisito/Revisão | O que mudou |
|------|-------------------|-------------|
| 2026-08-20 | Req. 456948 (Parte A) — alterações locais | Criados `TBatchHelper.PostOuAcumula` e `TBatchHelper.fFloatParaSQL` |
