# Especificação — Req. 456600

**Título:** Reduzir tempo de transação na gravação de MAPDET/ITEGER/CADLOT
**Objetivo:** Trocar `ExecSQL` imediato por acúmulo em `TBatchSQL`, executando o lote apenas ao final do loop de geração de mapa de inventário, para não segurar a transação aberta por muito tempo em CADLOT e ITEGER.
**Zona:** Legado
**Data:** 2026-09-03

## 1. Contexto / problema atual

`TfrmGeradorMapaDeInventarioParaColetores.fGeraMapDet` (unit
`untGeradorMapaDeInventarioParaColetores.pas`) é chamada uma vez por registro dentro do loop de
`fGeraInventario`, que roda inteiro dentro de uma única transação aberta por `fStartTransaction`
(linha 775) e fechada só no fim com `fCommit`/`fRollBack` (linhas 785/790).

A cada iteração, `fGeraMapDet` faz até 3 `ExecSQL` imediatos:
- `INSERT INTO MAPDET`
- `UPDATE ITEGER` (quando `LOT_NUMLOT` vazio)
- `UPDATE CADLOT` (quando `LOT_NUMLOT` preenchido)

Cada `ExecSQL` é um round-trip síncrono ao MySQL, dentro da transação. Com muitos registros
marcados, isso mantém a transação aberta por um tempo proporcional ao número de round-trips,
aumentando o risco de lock contention em `CADLOT`/`ITEGER` (tabelas concorridas por outras rotinas
do sistema).

Bug lateral identificado no `UPDATE ITEGER` atual (linhas 676-679): a coluna `ITE_GMLCON = 0` é
setada duas vezes, deixando de existir um segundo `SET`. Confirmado com o usuário: remover a
duplicidade no novo código (não é comportamento a preservar).

## 2. Módulos e entidades envolvidos

- Módulo: `Util_DLL/OpeRefProd` — geração de mapa de inventário para coletores
- Unit: `padra_atualizado/fontes/Util_DLL/OpeRefProd/untGeradorMapaDeInventarioParaColetores.pas`
- Unit de apoio: `padra_atualizado/fontes/genericos/BatchSQL/untTBatchSQL.pas` (`TBatchSQL`)
- Tabelas: `MAPDET` (chave `AUTOINCREM`), `ITEGER` (chave `ITE_CODITE` + `ITE_CODEMP`), `CADLOT`
  (chave `LOT_CODITE` + `LOT_CODEMP` + `LOT_NUMLOT`)

## 3. Requisitos funcionais

- RF01 — `fGeraMapDet` deixa de executar SQL diretamente; passa a **acumular** os comandos
  (INSERT MAPDET, UPDATE ITEGER, UPDATE CADLOT) em objetos `TBatchSQL`, sem tocar o banco.
  Renomeada para `fGeraScriptMapDet`.
- RF02 — INSERT em MAPDET acumula em `objBatchMapDet` (um `TBatchSQL` dedicado).
- RF03 — UPDATE em ITEGER e UPDATE em CADLOT acumulam em `objBatchItens` (um segundo `TBatchSQL`
  compartilhado entre as duas tabelas, já que são mutuamente exclusivos por registro).
- RF04 — Nova função `fExecutaScriptMapDet: Boolean` executa o lote de `objBatchMapDet` contra
  `qryComand`.
- RF05 — Nova função `fExecutaScriptItens: Boolean` executa o lote de `objBatchItens` contra
  `qryComand`.
- RF06 — `fGeraInventario` chama `fExecutaScriptMapDet` e, **por último**, `fExecutaScriptItens`,
  após o loop de acúmulo terminar e antes de retornar — a última execução antes do commit deve ser
  a de `fExecutaScriptItens`, para minimizar o tempo entre a última escrita e o fim da transação.
- RF07 — `UPDATE ITEGER` gerado não repete a coluna `ITE_GMLCON` (correção do bug identificado).

## 4. Regras de negócio

- RN01 — Regra de negócio de gravação (quais campos, quais condições `LOT_NUMLOT` vazio/preenchido)
  não muda — só a forma de execução (lote em vez de imediata).
- RN02 — A transação continua sendo controlada pelo chamador (`fGerarInventarioClick`), via
  `fStartTransaction`/`fCommit`/`fRollBack`; este requisito não altera esse controle, só reduz o
  número de round-trips dentro dela.
- RN03 — Se qualquer iteração do loop (`fGerenciaMapDetGravacao`/`fGeraScriptMapDet`) falhar, o
  loop já interrompe via `Exit` (comportamento existente, preservado); os `TBatchSQL` acumulados
  até ali são apenas liberados (não executados), e a transação externa faz rollback normalmente.
- RN04 — Todo `AddParam` de valor string usa `ftString` explícito — o `TBatchSQL.FormatValue` só
  aplica aspas quando o tipo é informado; omitir gera SQL inválido/sem aspas silenciosamente.

## 5. Requisitos técnicos / não-funcionais

- Objetos `objBatchMapDet` e `objBatchItens` (`TBatchSQL`) são locais a `fGeraInventario` — criados
  no início, liberados em `finally` (não viram campos do form).
- `uses` da unit ganha `untTBatchSQL`.
- Sem mudança de UI, permissão ou auditoria.

## 6. Critérios de aceitação

- [ ] Gerar inventário com item sem lote (`LOT_NUMLOT` vazio): MAPDET e ITEGER gravados
      corretamente, exatamente como antes (exceto a coluna duplicada removida).
- [ ] Gerar inventário com item com lote: MAPDET e CADLOT gravados corretamente, iguais ao
      comportamento anterior.
- [ ] Gerar inventário com múltiplos registros (lote e sem lote misturados): todos os registros
      batidos em `objBatchMapDet`/`objBatchItens` e executados corretamente ao final.
- [ ] Falha em um registro do meio do loop: transação inteira faz rollback (nenhum INSERT/UPDATE
      aplicado), como já acontece hoje.
- [ ] `fExecutaScriptItens` é a última chamada de execução antes do fim de `fGeraInventario`.

## 7. Fora de escopo

- Qualquer mudança na regra de quais campos são zerados/atualizados em ITEGER/CADLOT, além da
  remoção da duplicidade de `ITE_GMLCON`.
- Mudança no controle de transação externo (`fStartTransaction`/`fCommit`/`fRollBack`).
- Otimização de `fGeraMapger` (INSERT em MAPGER, executado uma única vez, fora do loop).

## 8. Dependências e riscos

- Depende de `untTBatchSQL.pas` (já existente e usado em outras rotinas, ex. balanço de estoque).
- Risco: `TBatchSQL` gera SQL literal (não parametrizado no protocolo) — erro de tipo/formatação em
  `AddParam` é silencioso. Mitigado por tipar explicitamente cada parâmetro (`ftString`/`ftFloat`).
- Risco: se `objBatchItens` ficar muito grande (muitos registros marcados), o `BatchSize` padrão
  (100) do `TBatchSQL` já particiona a execução em grupos — sem ação adicional necessária.
