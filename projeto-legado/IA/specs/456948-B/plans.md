# Plano de Execução — Req. 456948 Parte B

**Referência:** `specs.md` desta pasta; `IA/456948/specs.md` e `IA/456948/plans.md` (Parte A)
**Zona:** Legado

---

## 1. Abordagem técnica

Cada linha do banco tocada uma vez; cada comando cobrindo a rodada em vez de uma linha. Nenhuma regra de negócio alterada — só o momento e a granularidade do envio ao banco.

O driver da rodada é a tabela física `BALZER` (D-B5), porque tabela temporária não pode aparecer em DML replicada (D-B4). As passadas set-based fazem `INNER JOIN BALZER` filtrando por `ZER_CON_ID` + `ZER_CODCON`.

Toda adesão a comportamento novo é por **parâmetro com default igual ao de hoje** ou por **overload novo**. Nenhum outro fluxo do ERP muda de comportamento.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|---|---|---|
| `01_cria_BALZER.sql` | `IA/456948-B/banco/` | criar |
| `untBalancoEstoqueGravar.pas` | `padra_atualizado/fontes/util/operacoesrefitens/` | alterar |
| `untCadLote.pas` | `padra_atualizado/fontes/cadastros/` | alterar |
| `untConDet.pas` | `padra_atualizado/fontes/cadastros/` | alterar |
| `untConstantes.pas` | `padra_atualizado/fontes/genericos/` | alterar (remover as constantes `TMP_*`) |
| `untMovGer.pas` | `padra_atualizado/fontes/faturamento/` | alterar |
| `untFuncoesSimples.pas` | `padra_atualizado/fontes/genericos/` | alterar |
| `untICadLote.pas` | `padra_atualizado/fontes/cadastros/` | alterar (assinatura do overload novo) |

Qualquer arquivo além destes em `svn status` é acidente. Atenção especial a `financeiro/contasareceber/untBaixaReceber.pas` e `.dfm`, que já apareciam modificados sem terem sido tocados (R-B10).

## 3. Mapa das tarefas

| # | Tarefa | Mecanismo | Depende de |
|---|---|---|---|
| 1 | DDL de `BALZER` e criação na base de teste | — | — |
| 2 | Recapturar baseline na base mesclada | — | — |
| 3 | Verificação de integridade da rodada | B9 | 2 |
| 4 | `TItemZeraList` O(1) | B1 | 3 |
| 5 | Eliminar as temporárias de contagem | B8 | 3 |
| 6 | Suprimir o toque redundante em `ITEGER` | B4 | 5 |
| 7 | Fase 2 de `fZeraItens` set-based | B3 | 1, 6 |
| 8 | Fase 0 de `fZeraItens` set-based | B2 | 7 |
| 9a | Consultas por linha com parâmetro vazio | B10a | 8 |
| 9b | Molde de dataset reaproveitado | B10b | 9a |
| 10 | `PROINC` da `LGCEST` uma vez | B11 | 8 |
| 11 | Residual do laço de divergências | B5 | 9 |
| 12 | `fGravaLogContagemEstoque` | B7 | 10 |
| 13 | Bloco de sequencial por rodada | B6 | 11 |
| 14 | `LOT_QTDAJU`: prova e blindagem | B12 | 7 |
| 15 | Índice em `DIGCON` (condicionado a Q-B10) | B13 | 2 |
| 17 | `pAtivaItem` uma vez por item | B14 | 8 |
| 18 | `DisableControls` na varredura de diferenças | B15 | 11 |
| 16 | Medição final e fechamento | — | 13, 14, 15, 17, 18 |

Ordem de execução realizada: **1 → 2 → 3 → 4 → 5 → 6 → 7 → 8 → 9a → 10 → 11 → 13 → 17 → 18 → 9b → 12 → 14 → 15 → 16**.

As Tarefas 17 (B14) e 18 (B15) não estavam no mapa original: 17 saiu da medição de volume, que expôs um termo invisível na massa de 40 itens, e 18 foi apontada pelo Willian ao ver o grid rolar durante a gravação. A 9b ficou para o fim porque exige o ciclo completo de compilar e comparar coluna a coluna.

Cada passo é medido isolado contra a mesma massa e provado por diff coluna a coluna. Medir só no fim não diz de onde veio o ganho.

---

## Tarefa 1 — DDL de `BALZER`  ✅ CONCLUIDA (2026-08-20)

**Resultado:** tabela criada na base `AUTCOM` (10.0.0.44:47558), conferências 3.2/3.3/3.4 aprovadas, `EXPLAIN` com `eq_ref` + `Using index` em `CADLOT` (`UK_CADLOT_01`) e `ITEGER` (`UK_ITEGER_01`). Evidência e tipos reais em `testes/00_levantamento_base.md`. Dois palpites de largura do plano estavam errados — `LOT_NUMLOT` é `varchar(30)` e `LOG_CODCON` é `varchar(9)`; declarar à mão teria truncado número de lote. **Falta apenas** incluir o DDL no pacote de atualização e conferir a presença na réplica.

**Arquivos:** `IA/456948-B/banco/01_cria_BALZER.sql` — **escrito, pronto para executar**

**Como o script resolve o tipo das colunas.** Em vez de declarar largura, as cinco colunas de chave de negócio são criadas por `CREATE TABLE BALZER ENGINE = InnoDB AS SELECT ... WHERE FALSE` sobre `CADLOT`, `ITEGER` e `LGCEST`. Isso herda **tipo, charset e collation exatos** das colunas de origem — mesmo idioma que `pCriaTemporariasEmContagem` usa hoje. Depois um `ALTER TABLE` acrescenta `ZER_CODIGO` (`BIGINT UNSIGNED AUTO_INCREMENT`), `ZER_CON_ID`, as duas colunas de data e os dois índices.

O que mata o índice do join não é o comprimento — é charset ou collation diferente, e silenciosamente (R-B5). Derivar do schema elimina o risco por construção, e elimina o marcador por preencher.

**Blocos do script**

| Bloco | O quê |
|---|---|
| 1 | Conferência do schema — só leitura; registra os tipos reais desta base |
| 2 | Criação: `DROP` + `CREATE ... AS SELECT ... WHERE FALSE` + `ALTER` |
| 3 | Conferência da criação. **O `SHOW CREATE TABLE` do passo 3.1 produz o DDL explícito para o pacote de atualização do cliente** — já com os tipos desta base |
| 4 | `EXPLAIN` dos dois joins que B2 e B3 vão usar; rodar com a tabela carregada, na primeira gravação de teste. Esperado `type = ref`/`eq_ref` em `CADLOT` e `ITEGER`; `ALL` em `CADLOT` significa índice perdido — conferir o passo 3.3 antes de qualquer outra hipótese |
| 5 | Reversão (`DROP TABLE`, comentado) |

Sem linha em `PROINC` e sem `PROCOD`: a chave é `AUTO_INCREMENT` próprio (D-B5). `ZER_CON_ID` recebe `VS_ConnectionID`, que é o `CONNECTION_ID()` da sessão lido uma vez ([untFuncoesSimples.pas:44541](../../padra_atualizado/fontes/genericos/untFuncoesSimples.pas)), gravado como literal. `DEFAULT ''` porque `VS_ConnectionID` só é preenchido quando `LOGREP` tem a coluna `LOG_CON_ID` ([:65289](../../padra_atualizado/fontes/genericos/untFuncoesSimples.pas)) — vazio não quebra nada, já que `ZER_CODCON` sozinho identifica a rodada e o balanço roda sob a trava global `STR_TRAVA_CONDET`.

**Entrega.** O checklist está no fim do script. **As Tarefas 7 e 8 ficam bloqueadas** até ele estar todo marcado, incluindo `BALZER` presente na **réplica** (R-B4) — sem ela, o `UPDATE ... JOIN BALZER` replicado falha lá.

---

## Tarefa 2 — Recapturar baseline

**Arquivos:** `IA/456948-B/testes/tasks.md` (criar, tabela de acompanhamento)

A BASE da Parte A foi capturada antes do merge do trunk e perdeu validade.

**Passos**

1. Reverter `CFG_ITEDOC` da empresa 001 para 20 se a medição for funcional; manter 500 na de volume. Registrar qual valor foi usado em cada linha da tabela.
2. Restaurar massa: `02_restaura_massa.sql` + `04_massa_multilote_40.sql`.
3. Gravar na versão atual do branch (M1b–M6 aplicados). Capturar `06_snapshot_BASE.sql`.
4. `08_metricas.sql` filtrando por `thread_id`. Registrar `STATEMENTS`, `TOQUES_ITEGER`, `COMANDOS_APP`, `SEGUNDOS`.
5. Repetir com `04b_massa_multilote_300.sql` e `03_massa_2000_itens.sql`.
6. Medir também a **versão de produção (trunk)** na massa funcional — é o número que a Tarefa 14 precisa para provar a causa do `LOT_QTDAJU`.

Tabela de acompanhamento a preencher:

| Versão | `STATEMENTS` | `TOQUES_ITEGER` | `COMANDOS_APP` | `SEGUNDOS` |
|---|---|---|---|---|
| Trunk (produção) | | | | |
| Branch, antes da Parte B | | | | |
| + B9 | | | | |
| + B1 | | | | |
| + B8 | | | | |
| + B4 | | | | |
| + B3 | | | | |
| + B2 | | | | |
| + B10 | | | | |
| + B11 | | | | |
| + B5 | | | | |
| + B7 | | | | |
| + B6 | | | | |

Piso de `TOQUES_ITEGER`: **1 por item**. Ler o resultado contra esse piso, não contra a base.

---

## Tarefa 3 — B9: verificação de integridade da rodada  ✅ CÓDIGO APLICADO (2026-08-20)

**Resultado:** 11 edições aplicadas em `untBalancoEstoqueGravar.pas` por `ferramentas/ed-b9-integridade.json`; diff isolado em `diffs/03-b9-integridade.diff` (+312 / −2). O SQL das quatro conferências e das duas passadas da foto foi executado contra a base real — sintaxe e colunas válidas. Falta compilar e rodar `testes/01_aceite_b9.sql`.

**Mudança de desenho durante a implementação — a foto não sai da `LGCEST`.** `LOG_SALOLD` não é o saldo do lote: é `SOMASALDO(LOT_SALDOS) + ITE_ENTFUT`, e `SOMASALDO` é substituído por `SUM` ou por string vazia conforme `CFG_EMPBAL` ([:745-748](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)). A álgebra muda de cliente para cliente, e a conferência passaria a reprovar gravação boa. Além disso `MOVGER` não guarda o `LOG_CODCON`, então a fórmula não seria verificável depois do fato.

A foto passou a ser gravada em `BALZER` pelo próprio `pCarregaFotoBALZER`, lendo `CADLOT`/`ITEGER` em **duas passadas set-based** — sem laço em Delphi. Isso exigiu três colunas novas na tabela, já aplicadas: `ZER_ORIGEM` ('C' = linha contada, 'Z' = linha processada no zeramento), `ZER_SALANT` (saldo do lote antes) e `ZER_SALITE` (saldo do item antes), mais o índice `idx_balzer_origem`.

**V5 saiu do Delphi:** cobertura é medição, não guarda de execução. Está em `testes/01_aceite_b9.sql`.

**Ressalva registrada no código:** V1 e V2 comparam com o movimento desta rodada. Se outra estação movimentar um item contado durante a gravação, a diferença aparece como divergência e derruba a gravação — falso positivo. A janela é a duração da transação, que é justamente o que está encolhendo, e o balanço é feito com a operação parada. A mensagem de erro diz o que conferir.

**Arquivos:** `untBalancoEstoqueGravar.pas` — método novo; chamada em `fGravar` entre `fZeraItens` ([:1753](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) e o `fCommit`

**Interfaces:** consome `LGCEST` (`FLOG_CODCON`), `MOVDET` (`sltAutIncDocs`), `CADLOT`, `ITEGER`. Produz `Boolean` + string com a lista de divergências.

**Depende de:** Tarefa 2. Vem antes de tudo por ser a rede de segurança das demais.

**Passo 1: a flag de falha determinística**

No laço de documentos de `fConfirmaAjuste`, uma variável local que **nenhum documento seguinte sobrescreve**:

```pascal
{Req. 456948-B - fAtualizaEstoqueCadIte engole a excecao e devolve Result :=
 False (untCadIte.pas:313-319), e o Result e sobrescrito pelo fGravaMovGer do
 documento seguinte. Esta flag nao volta atras: uma vez marcada, o laco para e
 a rotina cai em rollback.}
If Not Result Then
Begin
  blnFalhouGravacao := True;
  Break;
End;
```

Verificada logo depois da atualização de estoque, e o fecho de `fConfirmaAjuste` devolve `Result And (Not blnFalhouGravacao)`.

**Passo 2: `fVerificaIntegridadeRodada`**

Cinco consultas, todas `SELECT` — não entram no `LOGREP`. Cada uma devolve a contagem de divergências e, quando houver, os primeiros N itens para a mensagem.

V1 — saldo por lote:

```sql
SELECT COUNT(*) AS DIVERGENCIAS
  FROM CADLOT L
 INNER JOIN LGCEST E ON E.LOG_CODEMP = L.LOT_CODEMP
                    AND E.LOG_CODITE = L.LOT_CODITE
                    AND E.LOG_NUMLOT = L.LOT_NUMLOT
  LEFT JOIN (SELECT DET_CODEMP, DET_CODITE, DET_NUMLOT,
                    SUM(IF(DET_CLAFIS = 1999, DET_QTDITE, DET_QTDITE * -1)) AS MOV
               FROM MOVDET
              WHERE DET_CODEMP = :CODEMP
                AND DET_SEQGER IN (<sltAutIncDocs>)
              GROUP BY DET_CODEMP, DET_CODITE, DET_NUMLOT) M
         ON M.DET_CODEMP = L.LOT_CODEMP
        AND M.DET_CODITE = L.LOT_CODITE
        AND M.DET_NUMLOT = L.LOT_NUMLOT
 WHERE E.LOG_CODCON = :CODCON
   AND ABS(L.LOT_SALDOS - (E.LOG_SALOLD + IFNULL(M.MOV, 0))) > 0.001
```

V2 — idem em `ITEGER`, agrupando `MOVDET` por item e usando a linha de `LGCEST` de nível de item.

V3 — invariante sem foto:

```sql
SELECT COUNT(*) AS DIVERGENCIAS
  FROM ITEGER G
 INNER JOIN (SELECT LOT_CODEMP, LOT_CODITE, SUM(LOT_SALDOS) AS SOMA
               FROM CADLOT
              WHERE LOT_CODEMP = :CODEMP
                AND LOT_CODITE IN (SELECT ZER_CODITE FROM BALZER
                                    WHERE ZER_CON_ID = :CONID AND ZER_CODCON = :CODCON)
              GROUP BY LOT_CODEMP, LOT_CODITE) T
    ON T.LOT_CODEMP = G.ITE_CODEMP AND T.LOT_CODITE = G.ITE_CODITE
 WHERE ABS(G.ITE_SALDOS - T.SOMA) > 0.001
```

V4 — contagem residual e documento vazio:

```sql
SELECT SUM(L.LOT_DIGCON = 'S') AS LOTES_AINDA_CONTADOS
  FROM CADLOT L
 INNER JOIN BALZER Z ON Z.ZER_CODEMP = L.LOT_CODEMP
                    AND Z.ZER_CODITE = L.LOT_CODITE
                    AND Z.ZER_NUMLOT = L.LOT_NUMLOT
 WHERE Z.ZER_CON_ID = :CONID AND Z.ZER_CODCON = :CODCON;

SELECT COUNT(*) AS DOCS_SEM_ITEM
  FROM MOVGER G
 WHERE G.AUTOINCREM IN (<sltAutIncDocs>)
   AND NOT EXISTS (SELECT 1 FROM MOVDET D WHERE D.DET_SEQGER = G.AUTOINCREM);
```

V5 — cobertura:

```sql
SELECT COUNT(*) AS SEM_FOTO
  FROM BALZER Z
  LEFT JOIN LGCEST E ON E.LOG_CODCON = :CODCON
                    AND E.LOG_CODEMP = Z.ZER_CODEMP
                    AND E.LOG_CODITE = Z.ZER_CODITE
                    AND E.LOG_NUMLOT = Z.ZER_NUMLOT
 WHERE Z.ZER_CON_ID = :CONID AND Z.ZER_CODCON = :CODCON
   AND E.LOG_CODCON IS NULL
```

V5 **não reprova a rodada** — só registra quantas linhas ficaram fora de V1/V2 (Q-B3). V1 a V4 reprovam: `fRollBack` e mensagem com a lista.

**Nota de ordem:** V1 a V5 dependem de `BALZER` (Tarefa 1) e da Fase 2 já executada. Até a Tarefa 7 entrar, V3/V4 usam a lista em memória (`FItemZeraList`) em vez de `BALZER`; depois passam a usar a tabela.

**Passo 3: validar**

1. Rodada boa: as cinco verificações passam, `SEM_FOTO` registrado.
2. **Rodada sabotada:** forçar `fAtualizaEstoqueCadIte` a devolver `False` num item do meio (patch temporário local, revertido depois). Esperado: B9 reprova, `fRollBack`, saldo intacto, contagem preservada.
3. Sem a sabotagem e sem B9, a mesma rodada **commita** com documento incompleto — é a evidência de que a verificação vale.

**Passo 4:** `svn diff > IA/456948-B/diffs/03-b9-integridade.diff`

---

## Tarefa 4 — B1: `TItemZeraList` O(1)  ✅ CÓDIGO APLICADO (2026-08-20)

**Resultado:** 4 edições, diff em `diffs/04-b1-itemzeralist.diff` (+55 / −19). Falta compilar e medir.

**Detalhe da implementação:** `FQtd` é o tamanho lógico e `Length(FItems)` passou a ser a **capacidade** — por isso `GetItems` devolve `Copy(FItems, 0, FQtd)`, senão os chamadores (que fazem `Length()` no resultado) veriam posições vazias. `Clear` zera `FQtd` e o dicionário mas **não** devolve a capacidade ao sistema: a rodada seguinte tem tamanho parecido. Chave do dicionário separada por `#1`, que não ocorre em código de item, lote ou localização — com `|` um lote chamado `A|B` poderia colidir com outro par.

**Arquivos:** `untBalancoEstoqueGravar.pas` — [:3944-4008](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)

**Depende de:** Tarefa 3.

**Passo 1: estrutura**

```pascal
TItemZeraList = class
  private
    FItems: TArrItemZera;
    FIndice: TDictionary<String, Integer>;   {Req. 456948-B}
    FQtd: Integer;                            {Req. 456948-B - Length nao serve com Capacity}
    function fChave(const ACodite, ANumLot, ALocFis: String): String;
  public
    ...
```

`Contains` consulta `FIndice.ContainsKey`. `AddItem` só cresce o array quando `FQtd = Length(FItems)`, dobrando a capacidade. `GetItems` devolve `Copy(FItems, 0, FQtd)` — preserva a ordem de inserção, que é o que a Fase 0 e a Fase 2 consomem hoje. `Clear` zera `FQtd` e o dicionário.

Interface pública inalterada: nenhum dos quatro chamadores muda.

**Passo 2: medir**

O ganho é de CPU e não aparece em `STATEMENTS`. Medir com `SEGUNDOS` na massa de volume (`03_massa_2000_itens.sql`) — é a única em que a diferença é visível. Registrar antes e depois.

**Passo 3:** `svn diff > IA/456948-B/diffs/04-b1-itemzeralist.diff`

---

## Tarefa 5 — B8: eliminar as temporárias de contagem

**Arquivos:** `untBalancoEstoqueGravar.pas` ([:214-215](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas), [:1675](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas), [:1785](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas), [:2131-2177](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)), `untConDet.pas`, `untCadLote.pas`, `untConstantes.pas`

**Depende de:** Tarefa 3.

**Passo 1: remover o caminho `blnTableTmp`**

- `pZeraItem` ([:1183](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) passa `True` no último parâmetro de `fZeraContagemLote` — passa a não passar nada.
- `fZeraContagemLote` ([untCadLote.pas:5622](../../padra_atualizado/fontes/cadastros/untCadLote.pas)) repassa `blnTableTmp` para `fGravaConDetZeraContagemLote` — parâmetro removido.
- `fGravaConDetZeraContagemLote` ([untConDet.pas:422](../../padra_atualizado/fontes/cadastros/untConDet.pas)) perde `blnUsaTemporaria` e os dois ramos condicionais ([:437-438](../../padra_atualizado/fontes/cadastros/untConDet.pas) e [:521-522](../../padra_atualizado/fontes/cadastros/untConDet.pas)), ficando só com a leitura de `ITEGER`/`CADLOT` reais.

Conferir os outros três chamadores de `fZeraContagemLote` — `untBalancoEstoqueZera.pas:184`, `untBalancoEstoqueZerarSaldo.pas:965`, `untCadLote.pas:5578` — que já usam o default e não mudam.

**Passo 2: remover a criação e a remoção**

Apagar `pCriaTemporariasEmContagem`, `pRemoveTemporaria`, as declarações e as duas chamadas em `fGravar`. O `try ... finally pRemoveTemporaria` de `fGravar` perde o `finally`; conferir que o `Try`/`Finally` restante continua balanceado.

**Passo 3: constantes**

`TMP_ITEGER_CONTAGEM` e `TMP_CADLOT_CONTAGEM` em `untConstantes.pas:99-100` ficam sem uso — remover, e conferir que nenhum outro `.pas` do repositório as referencia.

**Passo 4: validar**

1. Diff coluna a coluna: **nenhuma divergência**. A leitura muda de fonte, não de conteúdo — enquanto o zeramento continuar por linha (até a Tarefa 7), a ordem de visibilidade é a mesma que a temporária preservava para a **primeira** linha de cada item; conferir especificamente `CONDET` nesta rodada, porque é o consumidor da leitura.
2. Nenhum comando no `LOGREP` da rodada citando `TMP_` — corrige §2.9:

```sql
SELECT COUNT(*) AS CITA_TEMPORARIA
  FROM LOGREP
 WHERE LOG_COMAND LIKE '%TMP_ITEGER_CONTAGEM%'
    OR LOG_COMAND LIKE '%TMP_CADLOT_CONTAGEM%';
```

**Passo 5:** `svn diff > IA/456948-B/diffs/05-b8-remove-temporarias.diff`

---

## Tarefa 6 — B4: suprimir o toque redundante em `ITEGER`

**Arquivos:** `untCadLote.pas` ([:5622-5786](../../padra_atualizado/fontes/cadastros/untCadLote.pas)), `untICadLote.pas`, `untBalancoEstoqueGravar.pas`

**Depende de:** Tarefa 5.

**Passo 1: provar a redundância antes de remover**

A Fase 1 grava, para os itens da rodada ([:1553-1560](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)):
`ITE_ORDCON=0, ITE_SALCON=0, ITE_GMLCON=0, ITE_DIFSAL=0, ITE_DIF_ML=0, ITE_DIGCON='N'`.

A parte `G.ITE_*` do `UPDATE` conjugado grava o mesmo conjunto ([untCadLote.pas:5695-5719](../../padra_atualizado/fontes/cadastros/untCadLote.pas)), com um ramo por `blnLimpar` e `intConEst`. **Conferir campo a campo os dois ramos**: com `blnLimpar = True` — o que o balanço usa — os valores são os mesmos. Se algum campo aparecer só no conjugado, ele entra na Fase 1 antes de B4 ser aplicado (R-B2).

**Passo 2: parâmetro**

```pascal
Function fZeraContagemLote(strArmazens: string; strCodIte: String;
                           blnLimpar: Boolean = True; strFilExt: string = '';
                           event_Parametros: TSetaParametros = nil;
                           AblnAtualizaIteger: Boolean = True): Boolean; overload;
```

Com `False`, o `SET` sai sem o bloco `G.ITE_*` e o `INNER JOIN ITEGER G` só permanece se algum filtro depender dele — conferir; se não depender, o join também sai, e aí o comando deixa de sequer ler `ITEGER`.

O balanço passa `False` em `pZeraItem`. Os demais chamadores usam o default.

**Passo 3: medir**

`TOQUES_ITEGER` esperado: cai para o número de chunks da Fase 1 (~1 por item), contra 1 por linha contada. É a medição mais expressiva desta Parte B junto com a Tarefa 7.

**Passo 4:** diff coluna a coluna de `ITEGER` — **nenhuma divergência**, e `svn diff > IA/456948-B/diffs/06-b4-iteger-redundante.diff`

---

## Tarefa 7 — B3: Fase 2 de `fZeraItens` set-based

**Arquivos:** `untBalancoEstoqueGravar.pas` ([:1442-1620](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)), `untCadLote.pas`, `untConDet.pas`, `untICadLote.pas`

**Depende de:** Tarefas 1 e 6.

**Passo 1: carga de `BALZER`**

Método novo `pCarregaBALZER`, chamado no início de `fZeraItens`:

```
DELETE FROM BALZER WHERE ZER_CON_ID = :CONID AND ZER_CODCON = :CODCON
INSERT INTO BALZER (...) VALUES (...),(...),...   -- 500 por comando
```

`ZER_CON_ID` recebe `VS_ConnectionID` como **literal** — nunca `CONNECTION_ID()`, que na réplica devolveria outro valor e faria os joins deixarem de casar. Só as linhas que passam por `fDeveZerarItem` entram.

**Passo 2: overload set-based de `fZeraContagemLote`**

```pascal
Function fZeraContagemLoteRodada(const AstrConId, AstrCodCon: String;
                                 blnLimpar: Boolean = True;
                                 AblnAtualizaIteger: Boolean = False): Boolean;
```

Por chunk:

```sql
UPDATE CADLOT L
 INNER JOIN BALZER Z ON Z.ZER_CODEMP = L.LOT_CODEMP
                    AND Z.ZER_CODITE = L.LOT_CODITE
                    AND Z.ZER_NUMLOT = L.LOT_NUMLOT
   SET L.LOT_SALCON = 0, L.LOT_ML_CON = 0,
       L.LOT_DIFSAL = 0, L.LOT_DIF_ML = 0,
       L.LOT_DIGCON = 'N', L.LOT_ORDCON = 0
 WHERE Z.ZER_CON_ID = :CONID AND Z.ZER_CODCON = :CODCON
```

Mais o `UPDATE LOTLOC ⋈ BALZER` quando `fUsaMaisDeUmaLocalizacaoFisicaPorLote`, substituindo `fZeraContagemLocFis` por linha.

**Invariante de B3, verificada no diff:** nenhum comando escreve `LOT_QTDAJU`, `LOT_SEQAJU` ou `LOT_DTAAJU` — igual ao conjugado de hoje (ver Tarefa 14).

**Passo 3: `CONDET` de lote set-based**

Método novo em `untConDet.pas`, derivado de `fGravaConDetZeraContagemLote`, com `INNER JOIN BALZER` no lugar do filtro `LOT_CODITE = :CODITE AND LOT_NUMLOT IN (...)`. Mesmas colunas, mesmos valores, mesma técnica `SET @AUTINC` / `@AUTINC := @AUTINC + 1`, com **um** `fRetAutoIncrem('CONDET', ..., n)` por rodada em vez de um por linha.

Ordem obrigatória: o `INSERT` do `CONDET` roda **antes** do `UPDATE` do Passo 2, porque lê `LOT_SALCON`/`LOT_DIGCON` pré-zeramento — é a mesma ordem interna de `fZeraContagemLote` hoje.

**Passo 4: histórico**

`THistoricoBalanco.pLimpaHistoricoSaldoLote` por linha vira uma passada com join em `BALZER`. Conferir a assinatura e se há variante set-based já existente.

**Passo 5: medir e provar**

- Round-trips esperados na Fase 2: de ~8 por linha para ~4 por chunk.
- `TOQUES_ITEGER` na Fase 2: **zero** (com a Tarefa 6 aplicada).
- Diff coluna a coluna de `CADLOT`, `LOTLOC`, `CONDET`, `HISBAL`: **nenhuma divergência**. O `CONDET` é o mais sensível — comparar linha a linha, incluindo `DET_SALOLD`/`DET_DIGOLD`, que é onde o achado §2.7 da Parte A vive (e que **não** deve mudar).
- Contagem de linhas de `CONDET` por rodada tem que ser **idêntica** à da versão anterior.

**Passo 6:** `svn diff > IA/456948-B/diffs/07-b3-fase2-setbased.diff`

---

## Tarefa 8 — B2: Fase 0 de `fZeraItens` set-based

**Arquivos:** `untConDet.pas`, `untBalancoEstoqueGravar.pas`

**Depende de:** Tarefa 7.

**Passo 1: mapear o que lê `ITEGER` entre Fase 0 e Fase 1** (Q-B9)

A Fase 0 grava o `CONDET` de nível de item lendo `ITE_SALCON`/`ITE_GMLCON`/`ITE_DIGCON` **antes** de a Fase 1 zerar. Confirmar que nada mais no intervalo depende desses valores, e deixar o comentário no código.

**Passo 2: método set-based**

```pascal
Class function fGravaConDetZeraItensRodada(AOwner: TComponent;
                                           const AstrConId, AstrCodCon,
                                                 AstrCodEmp: String): Boolean;
```

Um `INSERT INTO CONDET (...) SELECT ...` com `INNER JOIN BALZER` por item (linhas distintas de `ZER_CODITE`), reproduzindo as colunas de `fInserirRegistro` ([untConDet.pas:629](../../padra_atualizado/fontes/cadastros/untConDet.pas)) e o filtro de variação, que em SQL fica:

```sql
WHERE (G.ITE_SALCON <> 0 OR G.ITE_GMLCON <> 0 OR G.ITE_DIGCON <> 'N')
```

— equivalente ao teste `FSalConOld <> FSalCon Or FGmlConOld <> FGmlCon Or FDigConOld <> FDigCon` com `FSalCon = 0`, `FGmlCon = 0`, `FDigCon = 'N'`, que são os valores que a Fase 0 passa hoje.

Manter o ramo `blnUsaEmpBal` (`JOIN ITEGER X` com `SUM`), que existe em `fInserirRegistro` e vale igual aqui.

**Passo 3: medir e provar**

Round-trips: de 2 por linha para ~2 por rodada. Diff de `CONDET` sem divergência; contagem de linhas idêntica.

**Passo 4:** `svn diff > IA/456948-B/diffs/08-b2-fase0-setbased.diff`

---

## Tarefa 9 — B10: as consultas por linha de `fGravaMovDet`

**Arquivos:** `untMovGer.pas` ([:2647-4255](../../padra_atualizado/fontes/faturamento/untMovGer.pas)), `untBalancoEstoqueGravar.pas` (só o ciclo de vida dos moldes)

**Depende de:** Tarefa 8.

**Status (2026-08-20):**

- **9a — guarda de chave vazia: código aplicado.** Duas guardas antes de ir ao banco, em `MOVTRI.DET_EMPORI` e em `FATSIM.SIM_SEQFDO`. Pendência aberta: a guarda do `FATSIM` não reduziu as 280 execuções na medição seguinte, sem explicação ainda — falta parada no depurador em `strNum_Pd` / `strInc_Pd`.
- **9b — molde reaproveitado: código aplicado, prova pendente.** 8 edições por `ferramentas/ed-b10b-movger.json` e `ed-b10b-balanco.json`. O desenho final está em `specs.md` §B10b e difere do previsto nos Passos 2 e 3 abaixo: a adesão é pelo par `pAbreMoldesMovDet` / `pFechaMoldesMovDet` e não por `ABatch <> Nil`, e `BRIDET` ficou de fora. **Provado em 2026-08-21:** `testes/05_diff_b10b.sql` aprovado — 365 colunas, zero divergentes, nas 14.000 linhas da massa de volume; `LOGREP` idêntico nas duas rodadas. Ganho medido: laço de documentos 201 s → 134 s, rodada inteira 231 s → 160 s. Falta só o teste fora do balanço (uma venda e uma devolução).

**Passo 1: inventário**

Confirmar no general log a contagem de `SELECT * FROM MOVDET WHERE FALSE`, `MOVTRI`, `MOVAUX` e `BRIDET` numa rodada — esperado 1 por linha cada. Listar também as chamadas de `fCampoTabela` do corpo e classificar: dependem da **linha** ou do **documento**.

**Passo 2: cache de molde**

Com `ABatch <> Nil`, os quatro datasets são abertos na primeira chamada e reaproveitados nas seguintes, liberados quando o lote é liberado. Com `ABatch = Nil`, o caminho é o de hoje, byte a byte — venda, devolução, compra e transferência não mudam.

Cuidado: o dataset é usado em modo inserção com `Insert`/`FieldByName`/`Post`, e `pPostOuAcumula` cancela a inserção. Conferir que o estado do dataset após o `Cancel` permite a inserção seguinte sem reabrir — se não permitir, o reaproveitamento é do **objeto** e do metadado, com `Close`/`Open` evitados por `CachedUpdates` ou por `Insert` direto.

**Passo 3: as leituras que dependem só do documento**

As `fCampoTabela` classificadas como "por documento" saem do caminho por linha: valor calculado uma vez e passado adiante, ou dicionário como no M5 da Parte A.

**Passo 4: medir e provar**

`SELECT ... WHERE FALSE` esperado: de ~3 por linha para ~3 por rodada. Diff coluna a coluna de `MOVDET`, `MOVTRI`, `MOVAUX`, `MOVREF`, `BRIDET` — **nenhuma divergência**. Este é o passo com maior risco de defeito silencioso: o molde carrega os defaults dos campos, e reaproveitá-lo sujo levaria valor de uma linha para outra. Comparar as 101 colunas do `MOVDET` linha a linha.

**Passo 5: testar fora do balanço** — uma venda e uma devolução, porque a função é a mesma.

**Passo 6:** `svn diff > IA/456948-B/diffs/09-b10-molde-dataset.diff`

---

## Tarefa 10 — B11: `PROINC` da `LGCEST` uma vez

**Arquivos:** `untBalancoEstoqueGravar.pas` ([:1315](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas))

**Depende de:** Tarefa 8.

**Passo 1: remover**

```
de:
        strInsert := strInsert + 'UPDATE PROINC SET  PRO_AUTINC = PRO_AUTINC + 1 WHERE PRO_NOMARQ = "LGCEST";';

para:
        {Req. 456948-B - removido. O bloco inteiro ja e reservado por
         fRetAutoIncrem('LGCEST', VS_strCodEmp, qryLog.RecordCount) em :1280,
         que faz PRO_AUTINC = PRO_AUTINC + N num comando so
         (untFuncoesSimples.pas:9446). Este UPDATE por linha avancava a
         sequencia uma segunda vez. PROINC nao replica, entao nao servia a
         replica tambem.}
```

**Passo 2: provar**

```sql
-- antes da gravação
SELECT PRO_AUTINC INTO @antes FROM PROINC WHERE PRO_NOMARQ = 'LGCEST';
-- depois
SELECT PRO_AUTINC - @antes AS AVANCO, COUNT(*) AS LINHAS
  FROM PROINC, LGCEST
 WHERE PRO_NOMARQ = 'LGCEST' AND LOG_CODCON = '<codcon>';
```

Esperado depois: `AVANCO = LINHAS`. Antes: `AVANCO ≈ 2 × LINHAS`.

Conferir também que os `AUTOINCREM` gravados na `LGCEST` continuam contíguos e sem colisão.

**Passo 3:** `svn diff > IA/456948-B/diffs/10-b11-proinc-lgcest.diff`

---

## Tarefa 11 — B5: residual do laço de divergências

**Arquivos:** `untBalancoEstoqueGravar.pas`

**Depende de:** Tarefa 9.

Seis edições independentes, cada uma medida:

- [ ] **Progresso:** `pgbProgresso.Position` e `Application.ProcessMessages` ([:3130](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) a cada 50, com atualização garantida na última linha — mesmo padrão de `PROG_INTERVALO` que `fZeraItens` já usa.
- [ ] **`fLoteComLocalizacaoCritica`** ([:3099](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)): pré-carga única, só se `fCfgSis('CADLOC', varBoolean)`, num `TDictionary<String, Boolean>` chaveado por `codite|numlot`, carregado com uma consulta restrita aos itens da rodada.
      **Medido:** `CADLOC` tem 8.320 linhas e **zero** com `LOC_CRITIC = 'S'`. Com `CFG_CADLOC = 'S'`, a função paga um round-trip por linha para sempre devolver `False`. O curto-circuito é mais simples que a pré-carga: uma consulta por rodada apurando se existe alguma localização crítica; se não existir, nem consultar por linha.
- [ ] **`pAtualizaAutoincBalDet`** ([:3102](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)): acumular os pares (item, `strAutInc`) e aplicar um `UPDATE` por documento com `BLD_CODITE IN (...)`, ou entrar no `objBatchMovDet`. Só se `blnUccBea` — e **`CFG_UCCBEA = 'N'` neste cliente**, então é prioridade baixa e não exercitável aqui.
- [ ] **`pFinalizaMapDet`** ([:836](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)): avaliar se as chamadas por linha são dispensáveis, dado que a passada de finalização já chama `pFinalizaMapDet('','')` global. Se sim, remover; se não, agrupar por documento. **Requer massa com coletor** — se não houver, manter como está e registrar como não exercitável.
- [ ] **`fCalcTotais`** ([:3251](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)): remover o `First` antes de `RecNo := PosRecNo` e a construção de `strCodItens`.
- [ ] **Código morto:** apagar `fMarcaAjuIteger`, `fMarcaAjuCadLot`, `fAjusteQtdIteger`, `fAjusteQtdCadLot` e a variável `strCodItens`. Confirmar antes, por grep, que não há chamador — inclusive fora deste arquivo.
- [ ] **`pAjustaITEGERSemContagemNaCADLOT`** ([:2338](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)): as duas subconsultas correlacionadas `COUNT(1) FROM CADLOT` viram `LEFT JOIN` + `GROUP BY` numa passada. Conferir que o conjunto devolvido é idêntico — comparar as duas versões lado a lado na massa antes de trocar.

`svn diff > IA/456948-B/diffs/11-b5-residual-laco.diff`

---

## Tarefa 19 — B16: limpeza da `BALZER`  ✅ CONCLUÍDA (2026-08-24)

**Arquivos:** `untBalancoEstoqueGravar.pas` (e `untConstantes.pas`, se a retenção virar constante)

**Depende de:** Tarefa 1. Achado de 2026-08-21, não estava no mapa.

A `BALZER` acumula: 112.840 linhas de 6 rodadas na base de teste, nenhuma apagada. Os dois `DELETE` de `pCarregaFotoBALZER` cobrem a própria rodada e a sobra da mesma estacão (`ZER_CON_ID`), e nenhum dos dois alcança rodada de outra sessão — o `VS_ConnectionID` muda a cada conexão. Diagnóstico e correção proposta em `specs.md` §B16.

**Retenção decidida pelo Willian: 7 dias.**

**O que foi feito:**

1. `INT_DIAS_RETENCAO_BALZER = 7` em `untConstantes.pas` (`ferramentas/ed-b16-constantes.json`).
2. Terceiro `DELETE` em `pCarregaFotoBALZER`, por `ZER_DTACAD < :DTALIM`, com o corte de `Int(fNow) - INT_DIAS_RETENCAO_BALZER` (`ferramentas/ed-b16-balanco.json`). Encoding conferido nos dois: acentos e blocos `TRY`/`EXCEPT`/`FINALLY` inalterados.
3. `banco/03_indice_balzer_dtacad.sql` — índice em `ZER_DTACAD` para base existente, com `EXPLAIN` antes e depois e o aceite que não exige esperar 7 dias (contagem por faixa de idade).
4. `banco/01_cria_BALZER.sql` — `idx_balzer_dtacad` e `idx_balzer_origem` acrescentados ao `ALTER TABLE`, para instalação nova nascer completa. O `origem` estava aplicado na base de teste e faltava no script.

**Pendente:**

- [ ] rodar `banco/03_indice_balzer_dtacad.sql` na base de teste — **DDL, sem ensaio nem rollback no MySQL 5.7**
- [ ] índice também na **réplica** — DDL não replica pelo `LOGREP`
- [ ] compilar e conferir na primeira gravação: **1 comando** no `LOGREP` e foto da rodada corrente intacta (bloco 6 do script)
- [ ] duas gravações seguidas: a segunda não pode apagar a foto da primeira dentro da janela

**Ordem de implantação, e não é detalhe:** índice primeiro, versão compilada depois. Invertido, a primeira rodada roda o `DELETE` varrendo a tabela e travando tudo que examina.

---

## Tarefa 12 — B7: `fGravaLogContagemEstoque`

**Arquivos:** `untBalancoEstoqueGravar.pas` ([:1220-1350](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas))

**Depende de:** Tarefa 10.

- [ ] Avaliar reaproveitar `qryGen` em vez da segunda abertura de `fRetSQLItens(False)`. **Conferir antes** se o conjunto é o mesmo: `qryGen` vem de `fRetSQLItens(True)` e pode estar filtrada (`opcAtivos`), enquanto o log usa `(False)` sem filtro. Se os conjuntos diferirem, a otimização não se aplica e fica registrada como avaliada e descartada.
- [ ] Alinhar o corte de `sltInsert` (hoje `> 500`) ao `BatchSize` de 500 do `MOVDET`, e conferir se `> 500` deveria ser `>= 500`.

`svn diff > IA/456948-B/diffs/12-b7-log-contagem.diff`

---

## Tarefa 13 — B6: bloco de sequencial por rodada

**Arquivos:** `untFuncoesSimples.pas` ([:21720](../../padra_atualizado/fontes/genericos/untFuncoesSimples.pas)), `untBalancoEstoqueGravar.pas` ([:2471](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas), [:2475](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas))

**Depende de:** Tarefa 11. **Último passo — é o único que sai do balanço.**

**Passo 1: parâmetro**

```pascal
function fRetSequencial(strNomCam: String; strCodEmp: String = '';
                        intTamanho: Integer = 6;
                        blnApenasObterValorSequencial: Boolean = False;
                        objConexao: TUniConnection = Nil;
                        AintQuantidade: Integer = 1): String;
```

Com `AintQuantidade = 1`, o corpo é o de hoje byte a byte. Com `> 1`, o `fAtuCfgSis` grava `valor + AintQuantidade` e a função devolve o primeiro número do bloco.

**Passo 2: `pReservaSequenciaisDaRodada`**

Reserva `intQtdDoc` números de `PRO_AJ` (e de `PRO_ML` quando `blnAjuGra`) antes do laço, e distribui em memória. Isso também tira a linha `CFG_PRO_AJ` do `FOR UPDATE` prolongado.

**Passo 3: testar fora do balanço**

Uma venda, uma devolução e uma compra, conferindo que o número do documento continua sequencial e sem buraco. Se houver qualquer dúvida sobre numeração fiscal, **este passo é o primeiro a reverter**.

**Passo 4:** `svn diff > IA/456948-B/diffs/13-b6-sequencial-bloco.diff`

---

## Tarefa 14 — B12: `LOT_QTDAJU`, prova e blindagem

**Arquivos:** nenhum `.pas` novo — a correção é o M3 da Parte A, já aplicado. Esta tarefa é prova e asserção.

**Depende de:** Tarefa 7.

**Passo 1: provar a causa na versão de produção**

Na medição da versão trunk da Tarefa 2, contar:

```sql
SELECT COUNT(*)                                     AS LOTES,
       SUM(L.LOT_QTDAJU = 0)                        AS QTDAJU_ZERO,
       COUNT(DISTINCT L.LOT_SEQAJU)                 AS DOCS_DISTINTOS
  FROM CADLOT L
 INNER JOIN BALSELMULTI456948 S ON S.CODITE = L.LOT_CODITE
                               AND S.NUMLOT = L.LOT_NUMLOT
 WHERE L.LOT_CODEMP = '001';
```

Esperado, confirmando §2.8: `LOTES = 280`, `QTDAJU_ZERO = 260`, `DOCS_DISTINTOS = 1` — todos os lotes carimbados com o `SEQAJU` do **último** documento, e só os 20 daquele documento com quantidade correta.

**Passo 2: provar o 280/280 na base mesclada**

```sql
SELECT COUNT(*) AS LOTES,
       SUM(ABS(L.LOT_QTDAJU - IFNULL(M.MOV, 0)) < 0.001) AS QTDAJU_OK
  FROM CADLOT L
 INNER JOIN BALSELMULTI456948 S ON S.CODITE = L.LOT_CODITE AND S.NUMLOT = L.LOT_NUMLOT
  LEFT JOIN (SELECT DET_CODITE, DET_NUMLOT,
                    SUM(IF(DET_CLAFIS = 1999, DET_QTDITE, DET_QTDITE * -1)) AS MOV
               FROM MOVDET
              WHERE DET_CODEMP = '001' AND DET_SEQGER IN (<docs da rodada>)
              GROUP BY DET_CODITE, DET_NUMLOT) M
         ON M.DET_CODITE = L.LOT_CODITE AND M.DET_NUMLOT = L.LOT_NUMLOT
 WHERE L.LOT_CODEMP = '001';
```

Esperado: `280 / 280`. E `ITE_QTDAJU` em `40 / 40`.

**Passo 3: asserção de blindagem**

Nenhum comando introduzido por B3, B2 ou B5 escreve em `LOT_QTDAJU`, `LOT_SEQAJU`, `LOT_DTAAJU`, `ITE_QTDAJU`, `ITE_SEQAJU` ou `ITE_DTAAJU`. Verificação mecânica no diff:

```bash
grep -nE "LOT_(QTDAJU|SEQAJU|DTAAJU)|ITE_(QTDAJU|SEQAJU|DTAAJU)" IA/456948-B/diffs/*.diff
```

Só `fAplicaAjusteIteger` e `fAplicaAjusteCadLot` podem aparecer escrevendo nesses campos.

**Passo 4: registrar** em `specs.md` que o defeito era latente no `fMarcaAjuCadLot` e foi exposto pela r463674, e que os dados históricos ficam como estão (D-B8).

---

## Tarefa 15 — B13: índice em `DIGCON`  (condicionada a Q-B10)

**Arquivos:** criar `IA/456948-B/banco/02_indices_digcon.sql`

**Depende de:** Tarefa 2. Independente das demais.

**O problema.** Não existe índice em `ITE_DIGCON` nem em `LOT_DIGCON` (`specs.md` §2.13). Todo comando com `WHERE ... DIGCON = 'S'` varre a tabela, e em `UPDATE` o InnoDB trava todas as linhas examinadas. `ITEGER` tem 16.396 linhas por empresa e 114.772 no total: é a explicação das 96.570 linhas travadas do incidente.

**Passo 1: medir antes**

```sql
EXPLAIN SELECT COUNT(*) FROM ITEGER WHERE ITE_CODEMP='001' AND ITE_DIGCON='S';
EXPLAIN SELECT COUNT(*) FROM CADLOT WHERE LOT_CODEMP='001' AND LOT_DIGCON='S';
```

Esperado antes: `type = ALL` ou `index`, `rows` na casa das dezenas de milhares.

**Passo 2: criar**

```sql
ALTER TABLE ITEGER ADD KEY idx_iteger_digcon (ITE_CODEMP, ITE_DIGCON);
ALTER TABLE CADLOT ADD KEY idx_cadlot_digcon (LOT_CODEMP, LOT_DIGCON);
```

**Passo 3: medir depois** — mesmo `EXPLAIN`, esperado `type = ref`. E, com uma contagem em andamento, conferir o escopo de lock pelo monitor.

**Ressalva que sustenta a Q-B10:** `ITEGER` já tem 37 índices e é tabela quente de venda. O custo de manutenção deste índice específico é baixo — `ITE_CODEMP` nunca muda e `ITE_DIGCON` só muda no balanço — mas a decisão de acrescentar é do Willian. Se reprovar, a tarefa cai e o `pAjustaITEGERSemContagemNaCADLOT` continua varrendo.

---

## Tarefa 17 — B14: `pAtivaItem` uma vez por item

**Arquivos:** `untBalancoEstoqueGravar.pas`

**Depende de:** Tarefa 8. Descoberta na medição de volume, não estava no mapa original.

**Status (2026-08-20): código aplicado.** 4 edições por `ferramentas/ed-b14-ativaitem.json` — o campo `sltItensAtivados`, a criação com `Sorted` + `dupIgnore`, o `Clear` por gravação, o `FreeAndNil` no `FormDestroy` e a guarda no topo de `pAtivaItem`.

**Medido:** `UPDATE CADITE` de 5.677 para 811 na massa de volume; `LOGREP` da rodada de 6.015 para 1.149 comandos.

**A massa que exercita:** itens **inativos**. Item ativo não chama `pAtivaItem`, e a própria gravação devolve `ITE_ITEATI = 'S'`, então a massa se consome a cada rodada. São 811 itens (`SEQ` 1 a 5.677 de `BALSELMULTI456948`, 7 lotes cada), remarcados como inativos antes de cada medição e devolvidos a `'S'` no fechamento.

**Aceite:** contagem de `UPDATE CADITE` igual ao número de itens inativos distintos, e **todos** eles ativos ao fim da rodada — a deduplicação não pode deixar item sem ativar.

---

## Tarefa 18 — B15: `DisableControls` na varredura de diferenças

**Arquivos:** `untBalancoEstoqueGravar.pas`

**Depende de:** Tarefa 11. Apontada pelo Willian, não estava no mapa original.

**Status (2026-08-20): código aplicado.** 1 edição por `ferramentas/ed-b15-disablecontrols.json`: `DisableControls`/`EnableControls` com `try..finally` em `fVerificaSeTemDiferencasParaGravar`, e o `FieldByName` fora do laço.

**Por que rende:** com `CFG_USATMQ = 'S'` a passada `ML` varre o dataset inteiro, porque `ITE_DIFGML` é zero em todas as linhas quando não há divergência de gramatura — 14.000 registros repintando o grid na massa de volume. Detalhe em `specs.md` §B15.

**Aceite:** o retorno da função não muda em nenhuma das duas passadas, e o grid continua respondendo depois de uma gravação **e** depois de uma saída pelo `Exit` do meio da função — é o caminho que o `finally` protege.

---

## Tarefa 16 — Medição final e fechamento

- [ ] Rodada final completa nas três massas; preencher a tabela de acompanhamento da Tarefa 2
- [ ] Perfil final de statements: o que sobrou no topo define Q-B8 (`pNotificaSaldoAbaixMinimo` e a terceira execução de `fRetSQLItens` entram ou não)
- [ ] Ler `TOQUES_ITEGER` contra o piso de 1 por item
- [ ] Extrapolação: registrar as leituras da massa funcional e da massa de volume **separadamente**; o que era quadrático não extrapola linear
- [ ] Reverter `CFG_ITEDOC` da empresa 001 se a base for reaproveitada
- [ ] `svn status` — só os arquivos da §2 desta plans; reverter `untBaixaReceber.pas` e `.dfm`
- [ ] `svn diff > IA/456948-B/diffs/final-completo.diff`
- [ ] `/review` antes de submeter
- [ ] Gate DelphAI; commit do Willian com `Req. 456948` na primeira linha e o token

---

## 4. Conformidade com padrões do projeto

- **Zona legado:** Hungarian style (`str`, `bln`, `int`, `flt`, `qry`, `slt`, `dic`), prefixos `p`/`f` em métodos, `F` em campos, `A` em parâmetros; SQL embutido com `ParamByName`
- **Componentes:** nenhum componente novo de tela nesta Parte B
- **Chamadas:** `fNow()`, `fStrToFloat()`, `fMensagem()`, `pSetFocus()`, `pCriarForm()`, `ParamByName()`
- **Pre-commit:** sem `StrToFloat`, `Now()`, `.SetFocus`, `TBitBtn`, `Application.CreateForm`, `FOREIGN_KEY_CHECKS`
- **Encoding:** `untBalancoEstoqueGravar.pas`, `untCadLote.pas`, `untConDet.pas` em latin-1 + CRLF; `untFuncoesSimples.pas` em UTF-8 com BOM; `untMovGer.pas` e `untConstantes.pas` a conferir antes de editar. Edição só por `IA/456948/ferramentas/edita_pas.py`, com verificação de `U+FFFD == 0`, bytes acentuados iguais à base, CRLF preservado e `Try` = `Except` + `Finally`

## 5. Estratégia de testes

| Nível | O quê |
|---|---|
| Equivalência | `06_snapshot_BASE/NOVA` + `07_diff` nas massas `04_massa_multilote_40`, `04b_massa_multilote_300`, `03_massa_2000_itens` |
| Desempenho | `08_metricas.sql` por `thread_id`, passo a passo |
| Integridade | B9 aprova rodada boa e reprova rodada sabotada; teste de rollback |
| Regressão fora do balanço | venda, devolução e compra após as Tarefas 9a, 9b e 13 |
| Regressão de sessão | gravar duas vezes sem fechar a tela (o `Clear` de `FItemZeraList` e a limpeza de `BALZER`) |
| Replicação | nenhum comando do `LOGREP` da rodada citando `TMP_`; `BALZER` presente na réplica |

Casos que **não** são exercitáveis nesta base e ficam registrados como limitação conhecida: `CFG_UTAUFA = 'S'` (auditoria de saldo), coletor (`blnUtilizaMapaDeContagemColetor`), e as configurações que este cliente não usa. A base de teste é réplica real do cliente (D-B5), então o que está desligado aqui está desligado lá.

## 6. Riscos e mitigação

Ver `specs.md` §11. Os três que mais pesam na execução:

- **R-B2** (B4 suprime gravação em `ITEGER`) → conferência campo a campo dos dois ramos do `UPDATE` conjugado **antes** de aplicar, e diff de `ITEGER` depois.
- **R-B6** (B10b altera `fGravaMovDet`) → adesão pelo par `pAbreMoldesMovDet`/`pFechaMoldesMovDet`, e comparação das 365 colunas de `MOVDET`/`MOVTRI`/`MOVAUX` por `testes/05_diff_b10b.sql`, porque molde sujo levaria valor de uma linha para outra sem erro nenhum.
- **R-B7** (B6 altera `fRetSequencial`) → último passo, teste fora do balanço, primeiro a reverter.

## 7. Ordem de reversão

Inversa da execução: 9b, 18, 17, 13, 12, 11, 10, 9a, 8, 7, 6, 5, 4, 3. Cada `IA/456948-B/diffs/NN-*.diff` é ponto de retorno. B6 (Tarefa 13) e B10 (Tarefa 9) são os únicos que afetam código fora do balanço — são os primeiros a reverter em caso de dúvida.
