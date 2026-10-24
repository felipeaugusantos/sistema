# untConDet

> Unit genérica compartilhada — usada por Util_DLL, cadastros e util. Documenta apenas o que já foi
> tocado ou consumido por alguma rotina.

## Responsabilidade

Classe `TConDet`: log de alteração de contagem em `CONDET` — quem mexeu na contagem, valor anterior
e valor novo, em nível de item e de lote.

## Caminho

`padra_atualizado/fontes/cadastros/untConDet.pas`. Encoding **latin-1 + CRLF**.

## Rotinas que consomem

| Rotina | O que usa daqui |
|--------|-----------------|
| [balanço de estoque](balanco_de_estoque/balanco_de_estoque.md) | `fGravaConDetZeraItensRodada` (Fase 0), `fGravaConDetZeraLotesRodada` (Fase 2), `fGravaConDetItens`, `fGravaConDetZeraContagemLote` |

## Métodos

| Método | Tipo | O que faz | Efeito colateral |
|--------|------|-----------|------------------|
| `fGravaConDetItens` | class function | Grava `CONDET` de itens em passada set-based | Grava `CONDET` |
| `fGravaConDetZeraItensRodada(AOwner, AstrConId, AstrCodCon, AstrCodEmp)` | class function | `CONDET` de nível de **item** para a rodada inteira: um `INSERT ... SELECT` lendo `ITEGER` dirigido por `BALZER` | Grava `CONDET` |
| `fGravaConDetZeraLotesRodada(AOwner, AstrConId, AstrCodCon, AstrCodEmp)` | class function | `CONDET` de nível de **lote** para a rodada inteira, dirigido por `BALZER`, lendo `CADLOT` real | Grava `CONDET` |
| `fGravaConDetZeraContagemLote(...)` | class function | Caminho por lote individual (sem temporária) | Grava `CONDET` |
| `fSQLInsertItensCount(...)` | function | Devolve o `SELECT COUNT` equivalente ao `INSERT ... SELECT`, usado para dimensionar o bloco de autoincremento da passada | Nenhum |
| `fSQLInsertItens` | function | Monta o `INSERT ... SELECT` com `SET @AUTINC` + `@AUTINC := @AUTINC + 1` | Nenhum |
| `pSetValoresAntigos` / `fInserirRegistro` | — | Caminho por linha: lê o valor anterior e insere condicionado a variação | Grava `CONDET` |

### Padrão das passadas `*Rodada`

1. `SELECT COUNT(...)` para dimensionar o bloco.
2. `fRetAutoIncrem('CONDET', ..., n)` — **um bloco por passada**, não um por linha.
3. `SET @AUTINC = <início do bloco>` e `SET @EMPFIS = (SELECT PRO_CODEMP FROM PROCOD WHERE PRO_NOMARQ = 'MOVGER')`.
4. `INSERT INTO CONDET (...) SELECT ... FROM ITEGER G ... WHERE (item, lote) IN (SELECT ... FROM BALZER ...)`, com `@AUTINC := @AUTINC + 1` por linha.

## Pontos de atenção

- **Ordem obrigatória:** o `CONDET` de item tem que ser gravado **antes** do zeramento de
  `ITE_SALCON`/`ITE_DIGCON`, e o de lote antes do zeramento de `LOT_SALCON`/`LOT_DIGCON` — o registro
  guarda o valor **anterior**. Inverter a ordem grava `old` já zerado.
- **Defeito conhecido, anterior a estes requisitos:** no caminho de zeramento por lote, o registro é
  montado lendo `ITEGER` **depois** de a contagem já ter sido zerada, então grava `DET_SALOLD = 0`,
  `DET_DIGOLD = 'N'`, `DET_SALNEW = 0`, `DET_DIGNEW = 0` — nenhuma variação. As linhas que **têm**
  variação vêm de `fGravaConDet`, mas são de nível de item. Consertar exige mover a gravação para
  antes do zeramento e filtrar por `ITE_SALCON > 0 AND ITE_DIGCON = 'S'`; altera conteúdo de log
  visível em relatório, então é **requisito próprio**.
- O parâmetro `blnUsaTemporaria` foi removido: o caminho que ele ligava lia as tabelas temporárias
  de contagem e gerava DML replicada citando tabela temporária — comandos que falhavam na réplica.

## Alterações documentadas

| Data | Requisito/Revisão | O que mudou |
|------|-------------------|-------------|
| 2026-08-20 | Req. 456948-B (Parte B) — alterações locais | Criadas `fGravaConDetZeraItensRodada` e `fGravaConDetZeraLotesRodada` (set-based por `BALZER`) e `fSQLInsertItensCount`; `fGravaConDetZeraContagemLote` perdeu `blnUsaTemporaria` |
