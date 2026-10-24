# Plano de Execução — Req. 456600

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Substituir os 3 `ExecSQL` imediatos de `fGeraMapDet` (INSERT MAPDET, UPDATE ITEGER, UPDATE CADLOT)
por acúmulo em dois `TBatchSQL` — um para MAPDET, outro compartilhado por ITEGER/CADLOT — e
executar os lotes uma única vez cada, ao final do loop de geração, dentro da mesma transação já
existente (`fStartTransaction`/`fCommit` no `OnClick`). Isso reduz o número de round-trips ao MySQL
de até `3 * N registros` para `2` (um `Execute` por `TBatchSQL`, cada um particionado internamente
em grupos de `BatchSize`).

Fluxo novo dentro de `fGeraInventario`:
1. Cria `objBatchMapDet` e `objBatchItens` (`TBatchSQL.Create(Nil)`).
2. Loop existente continua chamando `fGerenciaMapDetGravacao` → `fGeraScriptMapDet`, que só
   acumula comandos nos dois `TBatchSQL` (sem tocar o banco).
3. Ao sair do loop com sucesso: `fExecutaScriptMapDet` (executa MAPDET), depois
   `fExecutaScriptItens` (executa ITEGER/CADLOT) — nessa ordem, porque `fExecutaScriptItens` deve
   ser a última operação de escrita antes do commit externo.
4. `finally`: `FreeAndNil(objBatchMapDet)` / `FreeAndNil(objBatchItens)`.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `untGeradorMapaDeInventarioParaColetores.pas` | `padra_atualizado/fontes/Util_DLL/OpeRefProd/` | alterar |

## 3. Sequência de implementação

1. Adicionar `untTBatchSQL` ao `uses` da interface.
2. Declarar campos privados novos na seção `var` local de `fGeraInventario` (não no form):
   `objBatchMapDet: TBatchSQL; objBatchItens: TBatchSQL;`.
3. Renomear a declaração e a implementação de `fGeraMapDet` para `fGeraScriptMapDet` (linha 133 na
   interface, linha 651 na implementation) — mesma assinatura
   (`strAutIncGer, strAutIncDet: String; qryFonteDados: TZClient`).
4. Reescrever o corpo de `fGeraScriptMapDet`:
   - INSERT MAPDET → `objBatchMapDet.BeginInsert('MAPDET').Fields(...).Values(...)
     .AddParam('AUTOINCREM', strAutIncDet, ftString)...EndInsert;`
     (mantém os mesmos 10 campos/valores do INSERT original).
   - `If qryFonteDados.FieldByname('LOT_NUMLOT').AsString = '' Then` → UPDATE ITEGER via
     `objBatchItens.BeginUpdate('ITEGER').SetClause('ITE_GMLCON = 0, ITE_DIFSAL = 0,
     ITE_DIF_ML = 0').WhereClause('ITE_CODITE = :ITE_CODITE AND ITE_CODEMP = :ITE_CODEMP')
     .AddParam(...).EndUpdate;` — **sem** a coluna `ITE_GMLCON` duplicada (correção do bug).
   - `If qryFonteDados.FieldByname('LOT_NUMLOT').AsString <> '' Then` → UPDATE CADLOT via
     `objBatchItens.BeginUpdate('CADLOT').SetClause('LOT_SALCON = 0, LOT_DIFSAL = 0,
     LOT_ML_CON = 0, LOT_STATUS = :LOT_STATUS, LOT_DIF_ML = 0').WhereClause('LOT_CODITE =
     :LOT_CODITE AND LOT_CODEMP = :LOT_CODEMP AND LOT_NUMLOT = :LOT_NUMLOT').AddParam(...)
     .EndUpdate;`
   - Todo `AddParam` de string usa `ftString` explícito; `MPD_QTDCON` usa `ftFloat`.
   - Mantém o `try/except` existente, chamando `pMensagensErro` com a tag
     `[TfrmGeradorMapaDeInventarioParaColetores.fGeraScriptMapDet]`.
5. Criar `fExecutaScriptMapDet: Boolean` (nova função privada) — chama
   `objBatchMapDet.Execute(qryComand)` dentro de `try/except`, log via `pMensagensErro` com tag
   `[...fExecutaScriptMapDet]`.
6. Criar `fExecutaScriptItens: Boolean` (nova função privada) — mesma estrutura, chamando
   `objBatchItens.Execute(qryComand)`, tag `[...fExecutaScriptItens]`.
7. Atualizar `fGerenciaMapDetGravacao` (2 pontos, linhas 611 e 627): troca chamada `fGeraMapDet` →
   `fGeraScriptMapDet` (passando `objBatchMapDet`/`objBatchItens` — únicas variáveis locais de
   `fGeraInventario`, então `fGeraScriptMapDet`/`fGerenciaMapDetGravacao` precisam receber esses 2
   objetos por parâmetro, já que não são mais campos do form).
8. Atualizar `fGeraInventario`: criar os 2 `TBatchSQL` no início do bloco `If result Then`
   (após `fGeraMapger`), passar por parâmetro para `fGerenciaMapDetGravacao`, e ao final do loop
   chamar `fExecutaScriptMapDet(objBatchMapDet)` e depois `fExecutaScriptItens(objBatchItens)` —
   ambos também recebendo o objeto por parâmetro. `finally` libera os dois.
9. Atualizar declarações na seção `private` do form (interface) para as 3 assinaturas alteradas/
   novas: `fGeraScriptMapDet`, `fExecutaScriptMapDet`, `fExecutaScriptItens`,
   `fGerenciaMapDetGravacao` (assinatura ganha os 2 parâmetros `TBatchSQL`).

## 4. Conformidade com padrões do projeto

- Zona Legado: Hungarian style mantido (`objBatchMapDet`, `objBatchItens` — prefixo `obj`),
  prefixo `unt` da unit preservado, prefixo `f`/`p` nos métodos mantido.
- `ParamByName` do UniDAC não se aplica mais aqui (SQL literal via `TBatchSQL`) — não é
  concatenação insegura porque os valores vêm de `AddParam` com escaping/formatação centralizados
  em `TBatchSQL.FormatValue`, mesmo padrão já usado em `untMovGer` (balanço de estoque).
- Sem uso de `Now()`, `StrToFloat`, `.SetFocus`, `Application.CreateForm`, `ActiveControl :=`.
- Sem alteração de `.dfm`/componentes visuais.

## 5. Estratégia de testes

- Não há suite DUnit cobrindo `Util_DLL/OpeRefProd` hoje (`TestesUnitarios/`, `TestCase/`,
  `testes unitarios/` não referenciam essa pasta) — validação manual obrigatória:
  - Gerar inventário com pelo menos 1 item sem lote → conferir `MAPDET` e `ITEGER` gravados.
  - Gerar inventário com pelo menos 1 item com lote → conferir `MAPDET` e `CADLOT` gravados.
  - Gerar inventário com lista mista (>10 registros, para exercitar o `mod 10` do
    `ProcessMessages` e o particionamento de `BatchSize`) → conferir todos os registros gravados
    e comparar contagem de linhas afetadas com a execução anterior (antes da mudança).
  - Forçar uma falha no meio do loop (ex. dado inválido) → conferir que nada foi gravado
    (rollback).

## 6. Riscos e mitigação

- SQL literal silencioso em erro de tipo → mitigado tipando `ftString`/`ftFloat` explicitamente em
  cada `AddParam`.
- Mudança de assinatura de `fGerenciaMapDetGravacao`/`fGeraScriptMapDet` (2 novos parâmetros) exige
  atualizar as 2 chamadas internas — sem chamadores externos à unit (funções `private`), risco
  baixo.
- Remoção da duplicidade `ITE_GMLCON` muda o SQL gerado (não mais no-op na segunda ocorrência) —
  comportamento já validado e aprovado com o usuário como correção intencional.
