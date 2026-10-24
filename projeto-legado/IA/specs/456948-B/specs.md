# Especificação — Req. 456948 Parte B

**Título:** Otimização máxima da gravação do Balanço de Estoque por Ajuste — segunda rodada
**Objetivo:** reduzir ao menor valor possível o tempo de `TfrmBalancoEstoqueGravar.fGravar`, preservando o resultado final, e provar por construção que o gravado está correto.
**Zona:** Legado
**Data:** 2026-08-20
**Fonte principal:** `padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas` (4.008 linhas)
**Referência:** `IA/456948/specs.md` e `IA/456948/plans.md` (Parte A)

---

## 1. Contexto

A Parte A atacou o laço de documentos de `fConfirmaAjuste` e entregou M1b, M2, M3, M4, M5, M6 e Q8, todos reaplicados sobre a base do trunk mesclada. O arquivo atual carrega 63 marcações `{Req. 456948}` distribuídas em 5 arquivos.

A Parte A terminou com uma lista de pendências própria, e duas delas são o núcleo desta Parte B:

> **"`CONDET` em bloco — é onde estão os 24 minutos. Reservar o autoincremento uma vez e concatenar os inserts, como o `MOVDET` já faz. Pelos números, levaria os ~23 minutos para menos de 1. Mexe em `untConDet.pas`, que serve outras rotinas: requisito próprio."**

> **"`LOT_QTDAJU` — na versão atual de produção, 260 de 280 lotes gravam zero. Defeito da versão, não efeito colateral desta refatoração: requisito próprio."**

Esta análise chegou ao mesmo ponto por outro caminho — inventário estatement a statement de tudo que `fGravar` executa — e encontrou mais seis termos que a Parte A não mediu, porque a métrica dela (statements no general log) não enxerga custo de CPU em memória nem round-trip de `Open` de dataset.

---

## 2. Diagnóstico

### 2.1 O termo dominante mudou de lugar

A Parte A media o laço de divergências: ~14.000 linhas em produção. Mas `fZeraItens` ([:1442](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) não processa as linhas divergentes — processa **todas as linhas contadas**.

O caminho é este: `fConfirmaAjuste(True, 'AJ')` chama `pSeparaItensSemNecessidadeCalc` ([:2270](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas), chamada em [:3224](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)), que reabre `fRetSQLItens` com `FblnEfetivandoApenasItensSemDivergencias = True` e enfileira em `FItemZeraList` **todas as linhas contadas sem divergência**. Depois `pAjustaITEGERSemContagemNaCADLOT` ([:2338](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) acrescenta os itens com `ITE_DIGCON = 'S'` que ficaram sem lote contado. Só então `fGravar` chama `fZeraItens` ([:1753](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)).

**Escala medida na base do cliente em 2026-08-20** (`testes/00_levantamento_base.md`): a maior rodada registrada em `LGCEST` tem **19.768 linhas contadas** (`LOG_CODCON` 001000121, 2026-08-18); as demais ficam entre 800 e 3.400. O teto absoluto na empresa 001 é 146.946, o total de lotes. `ITEGER` tem 16.396 itens por empresa.

As **96.570 linhas travadas em `ITEGER`** do relatório de monitor de lock **não são linhas contadas** — são varredura sem índice, ver §2.13.

### 2.2 O laço da Fase 2, statement por statement

Fase 1 de `fZeraItens` já é em lote (chunk de 1.000, 3 comandos por chunk). Fases 0 e 2 são laços por linha.

A Fase 2 chama `pZeraItem` com `AblnSkipConDet = True` e `AblnOpLoteJaFeita = True`, o que reduz a chamada a duas funções — e essas duas custam:

| # | Statement | Onde |
|---|---|---|
| 1 | `SELECT COUNT(1)` em `TMP_ITEGER_CONTAGEM ⋈ TMP_CADLOT_CONTAGEM ⋈ CADITE` | [untConDet.pas:432-465](../../padra_atualizado/fontes/cadastros/untConDet.pas) |
| 2 | `fRetAutoIncrem('CONDET', ...)` — `SELECT ... FOR UPDATE` + `UPDATE PROINC`, em conexão e transação próprias | [untConDet.pas:474](../../padra_atualizado/fontes/cadastros/untConDet.pas) |
| 3 | `SET @AUTINC = ...` | [untConDet.pas:475](../../padra_atualizado/fontes/cadastros/untConDet.pas) |
| 4 | `SET @EMPFIS = (SELECT PRO_CODEMP FROM PROCOD ...)` | [untConDet.pas:476](../../padra_atualizado/fontes/cadastros/untConDet.pas) |
| 5 | `INSERT INTO CONDET ... SELECT` — repete o mesmo join de três tabelas do item 1 | [untConDet.pas:478](../../padra_atualizado/fontes/cadastros/untConDet.pas) |
| 6 | `THistoricoBalanco.pLimpaHistoricoSaldoLote` | [untCadLote.pas:5745](../../padra_atualizado/fontes/cadastros/untCadLote.pas) |
| 7 | `UPDATE CADLOT ⋈ ITEGER ⋈ CADITE` — **toca `ITEGER`, dispara o trigger: +6 statements** | [untCadLote.pas:5636-5719](../../padra_atualizado/fontes/cadastros/untCadLote.pas) |
| 8 | `UPDATE LOTLOC` — só com `fUsaMaisDeUmaLocalizacaoFisicaPorLote` | [untCadLote.pas:5581](../../padra_atualizado/fontes/cadastros/untCadLote.pas) |

Mais 3 a 4 `fCriaQuery` por iteração. Total: **~8 round-trips e ~15 statements no servidor, por linha contada.**

Na maior rodada medida (19.768 linhas): **~158.000 round-trips e ~296.000 statements**, dentro de uma transação única, com o undo log e o conjunto de locks crescendo o tempo inteiro. A ~2 ms por round-trip são ~5 minutos só nesta fase — e a Parte A mediu, na massa de volume, que a `CONDET` por item responde por ~23 dos ~24 minutos. O número exato desta base sai da Tarefa 2.

A Fase 0 acrescenta 2 round-trips por linha: `pSetValoresAntigos` ([untConDet.pas:564](../../padra_atualizado/fontes/cadastros/untConDet.pas), 1 `SELECT SQL_NO_CACHE`) e `fInserirRegistro` ([untConDet.pas:629](../../padra_atualizado/fontes/cadastros/untConDet.pas), 1 `INSERT ... SELECT` condicional a variação).

### 2.3 O toque em `ITEGER` da Fase 2 é redundante

O item 7 da tabela acima grava, na parte `G.ITE_*` do `UPDATE` conjugado:

```
G.ITE_SALCON = 0, G.ITE_ORDCON = 0, G.ITE_GMLCON = 0,
G.ITE_DIGCON = 'N', G.ITE_DIFSAL = 0, G.ITE_DIF_ML = 0
```

Exatamente o mesmo conjunto que a **Fase 1** já gravou em lote, para os mesmos itens ([:1553-1560](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)). Trabalho 100% redundante que paga ~6 statements de trigger `pSetaVariaveisPreAlt` por linha contada.

Piso teórico de `TOQUES_ITEGER`: **1 por item**. Hoje a Fase 2 sozinha gasta 1 por **linha**.

### 2.4 `TItemZeraList` é quadrática

`Contains` ([:3965](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) é varredura linear sobre array dinâmico, comparando três strings por posição. `AddItem` ([:3992](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) chama `Contains` e faz `SetLength(Length + 1)` — realocação a cada inserção.

A lista recebe uma entrada por linha contada — 19.768 na maior rodada medida — em `pSeparaItensSemNecessidadeCalc`, e `Contains` é chamada também no laço de divergências ([:3117](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)), no ramo de transferência e em `pAjustaITEGERSemContagemNaCADLOT`.

Custo na rodada de 19.768 linhas: **~2×10⁸ comparações de string**, cada uma comparando três campos, mais 19.768 realocações de array. **CPU puro, zero statements** — invisível para a métrica da Parte A, e não medido até aqui.

### 2.5 Os `SELECT ... WHERE FALSE` por linha, em `fGravaMovDet`

O M4 da Parte A interceptou o `Post`, não o `Open`. Cada chamada de `fGravaMovDet` continua criando e abrindo três datasets ([untMovGer.pas:3186-3196](../../padra_atualizado/fontes/faturamento/untMovGer.pas)):

```pascal
qryTblMovDet := fCriaQuery;  qryTblMovDet.SQL.Text := 'SELECT * FROM MOVDET WHERE FALSE';  qryTblMovDet.Open;
qryTblMovTri := fCriaQuery;  ... 'SELECT * FROM MOVTRI WHERE FALSE';  Open;
qryTblMovAux := fCriaQuery;  ... 'SELECT * FROM MOVAUX WHERE FALSE';  Open;
```

Mais `qryTblBriDet` condicional, e as chamadas de `fCampoTabela` (`CADCLI`, `CADFOR`, `FATSIM`, `EXTDOR`), cada uma um round-trip.

São **3 a 4 round-trips por linha de divergência** só para obter estrutura de campos, que é idêntica em todas as linhas. Com o lote ativo o `Post` é cancelado por `pPostOuAcumula`, então o dataset serve **apenas de molde**.

### 2.6 `fRetSequencial` por documento

`fRetSequencial('PRO_AJ', ...)` ([:2471](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) e `('PRO_ML', ...)` ([:2475](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) rodam uma vez por documento. Cada chamada ([untFuncoesSimples.pas:21720](../../padra_atualizado/fontes/genericos/untFuncoesSimples.pas)) faz `SELECT SQL_NO_CACHE SIS_VALCFG FROM CFGSIS ... FOR UPDATE`, `pSetNaoReplicarConfig` e `fAtuCfgSis` — 3 a 4 round-trips.

Com ~700 documentos: ~2.800 round-trips, e a linha `CFG_PRO_AJ` de `CFGSIS` fica sob `FOR UPDATE` — outra estação emitindo `AJ` espera.

### 2.7 `LGCEST`: o autoincremento avança em dobro

`fRetAutoIncrem('LGCEST', VS_strCodEmp, qryLog.RecordCount)` ([:1280](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) já reserva o bloco inteiro num comando: `PRO_AUTINC = PRO_AUTINC + N` ([untFuncoesSimples.pas:9446-9456](../../padra_atualizado/fontes/genericos/untFuncoesSimples.pas)).

E `fGravaLogContagemEstoque` ainda concatena, por linha, `UPDATE PROINC SET PRO_AUTINC = PRO_AUTINC + 1 WHERE PRO_NOMARQ = "LGCEST"` ([:1315](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)).

Não corrompe dado — os `AUTOINCREM` gravados vêm do bloco reservado — mas a sequência da `LGCEST` anda ~2× o número de linhas contadas, e é um statement a mais por linha dentro do comando replicado. **`PROINC` não replica** (D-B4), então o `UPDATE` embutido não serve à réplica: é remoção limpa.

### 2.8 `LOT_QTDAJU = 0` em 260 de 280 lotes — causa raiz

Na versão de produção (trunk) o laço de documentos ainda chama `fMarcaAjuCadLot` e `fAjusteQtdCadLot` por documento. Duas peças se combinam:

**1.** `fMarcaAjuCadLot` ([:3765](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) carimba `LOT_SEQAJU` com `WHERE LOT_CODEMP = ... AND LOT_DIGCON = 'S'` — **sem restrição por item nem por documento**. A cada documento ela estampa o `SEQAJU` daquele documento em todos os lotes ainda contados.

**2.** `fAjusteQtdCadLot` ([:3846](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) roda em seguida:

```sql
LEFT JOIN MOVDET MD ON ... AND MD.DET_SEQGER = I.LOT_SEQAJU
   SET I.LOT_QTDAJU = IFNULL(IF(MD.DET_CLAFIS = 1999, MD.DET_QTDITE, MD.DET_QTDITE * -1), 0)
 WHERE I.LOT_SEQAJU = :SEQAJU
```

Os lotes cujo `MOVDET` não está naquele documento não casam no `LEFT JOIN`, e o `IFNULL(..., 0)` grava **zero**.

**A aritmética fecha exata.** A massa tem 280 lotes em 14 documentos = 20 lotes por documento. Na marcação do último documento os 280 recebem o `SEQAJU` dele; o `fAjusteQtdCadLot` seguinte acerta os 20 que realmente movimentaram ali e zera os outros **260**.

**Por que piorou de 42 para 260.** No código anterior ao merge, `pZeraItem` rodava dentro do laço e ia limpando `LOT_DIGCON`, então cada documento via um conjunto menor — só 42 lotes caíam na janela (medição da Parte A, §2.5). A r463674 tirou o zeramento do laço (virou `fZeraItens`, no fim), então **todos os 280 lotes permanecem visíveis em todas as 14 marcações**. O defeito não é da refatoração: é a mudança estrutural do trunk expondo o defeito latente do `fMarcaAjuCadLot`.

Vale igual para `ITE_QTDAJU`/`ITE_SEQAJU`, e o `LOT_SEQAJU` dos 260 também fica apontando para documento errado — não é só a quantidade.

**Medido na base do cliente em 2026-08-20** — e a medicao **reduz** o alcance do defeito em producao:

| Documento de ajuste | Lotes carimbados | `LOT_QTDAJU = 0` | % | Data |
|---|---|---|---|---|
| …292933001 | 20.728 | 18.909 | 91,2% | 2026-03-21 |
| …311294001 | 7.785 | 3.865 | 49,6% | 2026-08-18 |
| …311293001 | 9.752 | 1.433 | 14,7% | 2026-08-18 |
| pequenos (2026-06) | 53 | 41 | — | — |
| rodadas de 19 e 20/08, já com o M3 | 2.139 | **0** | 0% | — |

Total histórico: 42.047 lotes com `LOT_SEQAJU`, 24.248 com zero.

**Correção de leitura — e a inferência é inconclusiva nos dois sentidos.**

`CFG_ITEDOC` da empresa 001 valia **20** antes de a Parte A mexer (o script `10_itedoc_500.sql` registra "a 001 estava em 20"); as outras seis empresas estão em 9999. Com 20, uma rodada de 19.768 linhas gera ~990 documentos, e o defeito é severo.

Mas o histórico **não permite atribuir** os zeros. Duas razões:

1. **"Um documento distinto por rodada" é a assinatura do defeito, não de rodada com um documento só.** `fMarcaAjuCadLot` recarimba todos os lotes contados a cada documento, então ao final da rodada todos apontam para o último. Ver 20.728 lotes com o mesmo `LOT_SEQAJU` é compatível com uma rodada de centenas de documentos — e nesse caso os 91,2% de zeros **são** o defeito.
2. **Mas também é compatível com zero legítimo:** lote contado sem divergência não movimenta, e zero é o valor correto para ele. Não há como distinguir depois do fato — `LOT_SEQAJU` guarda só o último carimbo, `LGCEST` não se liga a `MOVGER` por coluna nenhuma, e vendas posteriores mudaram o `MOVDET`.

Verificado: nenhum lote tem `QTDAJU = 0` com movimento **no documento em que está carimbado** (`ZERO_MAS_MOVIMENTOU = 0`) — o que é exatamente o que os dois cenários preveem, e por isso não decide entre eles.

**Então a prova do defeito é a massa controlada**, onde os 280 lotes todos movimentam e o resultado é verificável: 260 zeros na versão de produção, 280 de 280 corretos com o M3. É o item 1 e o item 2 de `testes/02_aceite_b12.sql`. As rodadas de 19 e 20/08, já com o M3, deram **zero** zeros — o único sinal limpo que o histórico oferece.

Os dados históricos ficam como estão (D-B8).

**A correção já existe e já foi medida:** `fAplicaAjusteIteger` ([:3612](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) e `fAplicaAjusteCadLot` ([:3664](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) — o M3 da Parte A — derivam de `MOVDET` numa passada única: 280 de 280 corretos, 40 de 40 itens corretos.

Consequência: `fMarcaAjuIteger`, `fMarcaAjuCadLot`, `fAjusteQtdIteger` e `fAjusteQtdCadLot` estão **sem chamador** neste branch, e `strCodItens` ([:3304](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) só alimentava as duas primeiras — continua sendo concatenado por linha em `fCalcTotais`, para nada.

### 2.9 Defeito pré-existente de replicação: DML citando temporária

`fGravaConDetZeraContagemLote` com `blnUsaTemporaria = True` monta `INSERT INTO CONDET ... SELECT ... FROM TMP_ITEGER_CONTAGEM ⋈ TMP_CADLOT_CONTAGEM` ([untConDet.pas:521](../../padra_atualizado/fontes/cadastros/untConDet.pas), veio da r463674).

`fGravaLogRep` grava o texto do `ExecSQL` em `LOGREP` e a réplica o executa em outra sessão, onde a tabela temporária não existe. **Confirmado com o Willian, e quantificado em 2026-08-20:** dos 619 comandos que a rodada `001000143` gravou em `LOGREP`, **280 citam a temporária — 45%, exatamente 1 por linha contada**. O B8 deixa de ser só desempenho: é correção de replicação com impacto medido.

`blnTableTmp = True` é passado por **um único ponto no ERP**: `pZeraItem` ([:1183](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)). Os outros três chamadores de `fZeraContagemLote` — `untBalancoEstoqueZera.pas:184`, `untBalancoEstoqueZerarSaldo.pas:965` e o overload interno `untCadLote.pas:5578` — usam o default `False` e leem as tabelas reais.

As temporárias só existem porque o laço por linha vai zerando `LOT_DIGCON` conforme processa: a leitura da linha 500 já não encontraria o que a linha 1 encontrava. **Com uma passada única antes do zeramento, o problema desaparece** e a leitura volta a ser da tabela real.

### 2.10 Termos menores, confirmados

| Ponto | Custo | Onde |
|---|---|---|
| `Application.ProcessMessages` + `pgbProgresso.Position` por linha no laço de divergências | 1 bombeamento de fila de mensagens por linha; `fZeraItens` já usa intervalo de 50 | [:3130](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas) |
| `fLoteComLocalizacaoCritica` | 1 `SELECT COUNT(1)` com 2 joins por linha. `CFG_CADLOC = 'S'` neste cliente, e `CADLOC` tem 8.320 linhas com **zero** `LOC_CRITIC = 'S'`: paga o round-trip por linha para sempre devolver `False` | [:3099](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas) |
| `pAtualizaAutoincBalDet` | 1 `UPDATE BALGER ⋈ BALDET` por linha. `CFG_UCCBEA = 'N'` neste cliente: **o termo não existe aqui** | [:3102](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas) |
| `pFinalizaMapDet` | 2 `UPDATE` por linha, se coletor; a passada final já chama a versão global `('','')` | [:836](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas) |
| `pAjustaITEGERSemContagemNaCADLOT` | 2 subconsultas correlacionadas `COUNT(1) FROM CADLOT` por linha de `ITEGER` contada | [:2338](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas) |
| `pCriaTemporariasEmContagem` | 2 `CREATE TEMPORARY TABLE ... SELECT *` do conjunto contado inteiro + 2 `ALTER TABLE` (rebuild) | [:2131](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas) |
| `pRemoveTemporaria` usa `DROP TABLE`, não `DROP TEMPORARY TABLE` | um homônimo real seria alvo possível | [:2155](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas) |
| `fRetSQLItens` executada 3× por gravação | tela (`pBuscaItens`), log ([:1695](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) e `pSeparaItensSemNecessidadeCalc` — é a query mais caro da rotina, ~400 linhas com subconsultas | [:352](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas) |
| `pNotificaSaldoAbaixMinimo` | round-trip por item depois do flush; `sltItensSaldoAlterado` já é `Sorted`/`dupIgnore`, então ~2.000 itens e não 14.000 | [:1875](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas) |
| `fCalcTotais` | `First` desnecessário antes de `RecNo := PosRecNo`; concatenação de `strCodItens` por linha, para código morto | [:3251](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas) |

### 2.11 Achados colaterais — dono fora deste requisito

**`TBatchReprocessarSaldo` não agrupa nada.** Medido na Parte A: `Execute` ([untFuncoesGenerica.pas:14022](../../padra_atualizado/fontes/genericos/untFuncoesGenerica.pas)) faz um `ExecSQL` por comando, e o `pUnifica` não colapsa porque a quantidade difere em cada linha. Quem usa `AUsarBatchSaldos` acreditando que agrupa — o faturamento, em `untFuncFat.pas:10898` — **não ganha nada**. Foi por isso que o M1 virou M1b na Parte A. Avisar quem cuida do faturamento.

**Log de zeramento da `CONDET` sem variação.** Registrado na Parte A §2.7: `fGravaConDetZeraContagem` lê `ITE_SALCON`/`ITE_DIGCON` **depois** de o zeramento já ter acontecido, e grava `old = 0`, `new = 0`. A granularidade certa (por lote) não tem variação; a que tem variação é por item. Requisito próprio, decisão D9 da Parte A. **A Parte B não altera esse conteúdo** — a versão set-based reproduz linha a linha o que a versão por item grava hoje.

### 2.12 A auditoria de saldo não é termo real neste cliente

`objAuditoriaSaldo.fValidouTodas` ([:1746](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) chama a função de banco `F_AUDITORIA_GRAVACAO_SALDO` uma vez por documento, mais um `INSERT` em `AUDLOG` por chamada se `CFG_AUDLOG = 'S'`.

Medido em 2026-08-20: `CFG_UTAUFA = 'N'` nas **7** empresas da base, e `F_AUDITORIA_GRAVACAO_SALDO` **não existe** no schema. **O banco de teste é réplica real da base do cliente** (D-B5), então o cliente dos ~20 minutos tem a auditoria desligada: não é termo de custo aqui. Fica fora de escopo, e o B9 desta Parte B passa a ser a única verificação de integridade efetiva da rotina nesse cliente.

### 2.13 Não existe índice em `ITE_DIGCON` nem em `LOT_DIGCON`

Confirmado por consulta em `information_schema.STATISTICS`: **zero linhas**. `ITEGER` tem 37 índices e `CADLOT` tem 15, nenhum sobre a coluna de contagem.

Consequência: todo comando com `WHERE ... DIGCON = 'S'` varre a tabela inteira — e quando o comando é `UPDATE`, o InnoDB trava **todas as linhas examinadas**, não só as alteradas.

`ITEGER` tem 16.396 linhas por empresa e 114.772 no total. As **96.570 linhas travadas** do relatório de monitor de lock correspondem a varredura de `ITEGER`, e não ao número de linhas contadas — que na maior rodada medida foi 19.768. É a explicação do incidente de lock, e ela troca o mecanismo: não era volume de contagem, era ausência de índice.

Quem varre por `DIGCON`: `pAjustaITEGERSemContagemNaCADLOT` (`WHERE ITE_DIGCON = 'S'`, mais duas subconsultas correlacionadas em `CADLOT` por linha encontrada), `fRetSQLItens`, e — na versão de produção — `fMarcaAjuIteger` e `fMarcaAjuCadLot`.

### 2.14 Perfil de configuração do cliente

Medido em 2026-08-20, empresa 001. Define quais termos de custo existem de fato:

| Config | Valor | Efeito |
|---|---|---|
| `CFG_CADLOC` | **S** | `fLoteComLocalizacaoCritica` roda por linha, e sempre devolve `False` (§2.10) |
| `CFG_UCCBEA` | **N** | `pAtualizaAutoincBalDet` não roda |
| `CFG_EMPBAL` | vazio | `blnUsaEmpBal = False` |
| `CFG_UTINEM` | **S** | notificação de saldo mínimo ligada: `pNotificaSaldoAbaixMinimo` roda, 1 round-trip por item |
| `CFG_USATMQ` | **S** | a passada `fConfirmaAjuste('ML')` roda |
| `CFG_UTIIND` | **S** | tintométrico ativo no caminho do `MOVDET` |
| `CFG_FDGINC` | **S** | `fRetAutoIncrem` vai por `fRetAutoIncremFireDac`, que também reserva o bloco com `PRO_AUTINC + N` ([untProximoCodigo.pas:190-205](../../padra_atualizado/fontes/genericos/untProximoCodigo.pas)) — a premissa do B11 vale nos dois caminhos |
| `CFG_ITEDOC` | **20** na 001 (valor do cliente), 9999 nas outras 6 | a Parte A levou a 001 a 500 e voltou a 20 em 2026-08-20. Com 20, uma rodada de 19.768 linhas gera ~990 documentos: **os termos por documento (B6, `fRetSequencial`, `fCalcTotais`) são reais** |
| `CFG_UTAUFA` | **N** nas 7 empresas | auditoria inerte (§2.12) |
| `LOCCON`, `HISBAL`, `LOTLOC` | **0 linhas** | `fUsaMaisDeUmaLocalizacaoFisicaPorLote` desligado e `fDeveGravarHistorico` falso — dois ramos do zeramento não executam |

---

## 3. Decisões

| ID | Decisão | Origem |
|---|---|---|
| D-B1 | **Todos os arquivos necessários podem ser alterados.** A adesão a comportamento novo é sempre por parâmetro com default igual ao de hoje, ou por overload novo | Willian, 2026-08-20 |
| D-B2 | **O log `CONDET` pode passar a ser gravado por `INSERT ... SELECT` em lote, desde que o conteúdo final seja idêntico** — mesmas linhas, mesmos valores. É o que `fGravaConDetItens` já faz na passada sem divergência | Willian, 2026-08-20 |
| D-B3 | **A garantia é de que os dados serão gravados corretamente.** Traduzida em verificação set-based da rodada dentro da transação, com rollback se divergir (B9) — não em flag por documento | Willian, 2026-08-20 |
| D-B4 | **Nenhuma DML replicada pode ler de tabela temporária.** `fGravaLogRep` grava o texto do `ExecSQL` e a réplica o executa em sessão onde a temporária não existe | Willian, 2026-08-20 |
| D-B5 | **O driver da rodada é uma tabela física, `BALZER`**, criada no pacote de atualização do cliente. Chave `BIGINT AUTO_INCREMENT` própria — tabela nova, sem filhas e sem referência externa, portanto fora da convenção do `AUTOINCREM`/`PROINC`. Identificador de sessão obrigatório: `ZER_CON_ID` = `VS_ConnectionID`, gravado como literal pelo Delphi | Willian, 2026-08-20 |
| D-B6 | **`PROINC` não replica** — o `UPDATE PROINC + 1` embutido por linha na `LGCEST` não serve à réplica e é removido | Willian, 2026-08-20 |
| D-B7 | **A transação do `AJ` permanece única e atômica.** Com o tempo caindo para a casa dos segundos, o escopo de lock deixa de ser o problema, e a atomicidade que o B9 protege vale mais. O D1 da Parte A continua disponível se a medição mostrar que não bastou | Willian, 2026-08-20 |
| D-B8 | **Os dados históricos com `LOT_QTDAJU = 0` ficam como estão.** Corrigir só o problema, sem script retroativo | Willian, 2026-08-20 |
| D-B9 | **`pCriaTemporariasEmContagem`, `pRemoveTemporaria` e o caminho `blnTableTmp` são eliminados** — a passada única lê as tabelas reais | Willian, 2026-08-20 |

---

## 4. Arquitetura da solução

### 4.1 Princípio

Um só: **cada linha do banco é tocada uma vez, e cada comando cobre a rodada em vez de uma linha.** Nenhuma regra de negócio muda; muda quando e em que granularidade o comando sai do Delphi.

| Termo | Mecanismo | ID |
|---|---|---|
| Round-trip por linha contada | passada set-based com join em `BALZER` | B2, B3 |
| Linha tocada em `ITEGER` | suprimir o redundante — a Fase 1 já gravou | B4 |
| CPU O(n²) em memória | dicionário | B1 |
| Round-trip por linha divergente | molde de dataset reaproveitado, pré-carga, acumulação | B5, B10a, B10b |
| Round-trip por documento | bloco de sequencial por rodada | B6 |
| Statement por linha no log | um `+ N` por bloco | B11 |
| Cópia do conjunto contado | eliminar as temporárias | B8 |
| Garantia de correção | verificação set-based antes do commit | B9 |
| Defeito de `LOT_QTDAJU` | já corrigido pelo M3; provar e blindar | B12 |
| Varredura e lock por falta de índice em `DIGCON` | índice composto por empresa + contagem | B13 |
| `UPDATE` em `CADITE` por linha em vez de por item | deduplicação em memória do item já ativado | B14 |
| Grid repintando a cada `Next` | `DisableControls` na varredura de diferenças | B15 |

### 4.2 `BALZER` — tabela de trabalho da rodada

Script: `banco/01_cria_BALZER.sql`. As cinco colunas de chave de negócio **não têm largura declarada** — são derivadas do schema:

```sql
CREATE TABLE BALZER ENGINE = InnoDB AS
SELECT E.LOG_CODCON AS ZER_CODCON,
       L.LOT_CODEMP AS ZER_CODEMP,
       L.LOT_CODITE AS ZER_CODITE,
       L.LOT_NUMLOT AS ZER_NUMLOT,
       G.ITE_LOCFIS AS ZER_LOCFIS
  FROM CADLOT L
 INNER JOIN ITEGER G ON G.ITE_CODEMP = L.LOT_CODEMP AND G.ITE_CODITE = L.LOT_CODITE
 INNER JOIN LGCEST E ON E.LOG_CODEMP = L.LOT_CODEMP
 WHERE FALSE;

ALTER TABLE BALZER
  ADD COLUMN ZER_CODIGO BIGINT UNSIGNED NOT NULL AUTO_INCREMENT FIRST,
  ADD COLUMN ZER_CON_ID VARCHAR(20) NOT NULL DEFAULT '' AFTER ZER_CODIGO,
  ADD COLUMN ZER_DTACAD DATE NULL,
  ADD COLUMN ZER_HRACAD TIME NULL,
  ADD PRIMARY KEY (ZER_CODIGO),
  ADD KEY idx_balzer_sessao (ZER_CON_ID, ZER_CODCON, ZER_CODEMP),
  ADD KEY idx_balzer_item   (ZER_CODEMP, ZER_CODITE, ZER_NUMLOT);
```

`CREATE ... AS SELECT ... WHERE FALSE` herda tipo, charset e collation exatos das colunas de origem — mesmo idioma que `pCriaTemporariasEmContagem` usa hoje. **O que mata o índice do join não é o comprimento, é charset ou collation diferente**, e sem erro nenhum (R-B5); derivar do schema elimina isso por construção e elimina o marcador por preencher. O `SHOW CREATE TABLE` do bloco 3.1 do script produz o DDL explícito, com os tipos desta base, para o pacote de atualização do cliente.

Tipos já conferidos na base pela massa da Parte A: `LOT_CODITE`/`ITE_CODITE` `varchar(5)`, `LOT_NUMLOT` `varchar(20)`, `LOG_CODCON` `varchar(20)`, `AUTOINCREM` `varchar(20)`.

`ZER_CON_ID` recebe `VS_ConnectionID` — o `CONNECTION_ID()` da sessão, lido uma vez ([untFuncoesSimples.pas:44541](../../padra_atualizado/fontes/genericos/untFuncoesSimples.pas)) — gravado como **literal**, nunca `CONNECTION_ID()` dentro do comando: na réplica isso devolveria outro valor e o join deixaria de casar. `DEFAULT ''` porque a global só é preenchida quando `LOGREP` tem a coluna `LOG_CON_ID` ([:65289](../../padra_atualizado/fontes/genericos/untFuncoesSimples.pas)); vazio não quebra nada, já que `ZER_CODCON` sozinho identifica a rodada e o balanço roda sob a trava global `STR_TRAVA_CONDET`. O `CON_ID` é a segunda linha de defesa, não a primeira.

**Por que física e não temporária:** D-B4. Como `BALZER` é tabela real, tanto o `INSERT` de carga quanto o `UPDATE ... ⋈ BALZER` replicam e funcionam na réplica.

**Por que `AUTO_INCREMENT` próprio:** nada referencia `BALZER` de fora e as linhas são efêmeras. O id divergir entre base e réplica é irrelevante — todos os `JOIN` e `DELETE` usam `ZER_CON_ID` + `ZER_CODCON` + item/lote, nunca o id. Em troca: sem linha em `PROINC`, sem `fRetAutoIncrem`, sem lock na linha quente do autoincremento.

**Ciclo de vida:** `DELETE FROM BALZER WHERE ZER_CON_ID = :CONID AND ZER_CODCON = :CODCON` no início e no fim da rodada, dentro da transação. Carga em blocos de 500 `INSERT` concatenados — o padrão de `pInsertLoteLGCEST`. Para ~96.000 linhas: ~200 comandos.

### 4.3 Estrutura de `fGravar` — depois

```
fGravar
├── FItemZeraList.Clear                      dicionário                        B1
├── pCarregaCustoItens
├── pLigaBatchSaldos
├── fStartTransaction
├── pLigaCacheIDTransacao
├── fLock_Unlock(STR_TRAVA_CONDET)
├── fGravaLogContagemEstoque                 1 UPDATE PROINC por bloco         B11
├── pReservaSequenciaisDaRodada              1 bloco de intQtdDoc números      B6
├── fConfirmaAjuste(False,'AJ')
│     ├── fVerificaSeTemDiferencas...        DisableControls, FieldByName fora B15
│     ├── fCalcTotais                        sem First, sem strCodItens        B5
│     └── laço de linhas
│           ├── molde de dataset reaproveitado                               B10b
│           ├── guarda de chave vazia        2 consultas por linha a menos     B10a
│           ├── pAtivaItem                   1 por item, não por linha         B14
│           ├── dicLoteCritico               pré-carga única                   B5
│           ├── pAtualizaAutoincBalDet       acumulado, set-based após o laço  B5
│           └── ProcessMessages              a cada 50                         B5
├── fConfirmaAjuste(False,'ML')
├── fConfirmaAjuste(True,'AJ')               AddItem O(1)                      B1
├── pDescarregaEDesligaBatchSaldos
├── fZeraItens
│     ├── pCarregaBALZER                     blocos de 500 INSERT
│     ├── Fase 0: CONDET de item             1 INSERT ... SELECT ⋈ BALZER      B2
│     ├── Fase 1: ITEGER / LOCCON / HISBAL   3 comandos por chunk (inalterada)
│     └── Fase 2: CADLOT / LOTLOC / CONDET   4 comandos por chunk, sem ITEGER  B3+B4
├── fVerificaIntegridadeRodada               4 consultas; divergiu → fRollBack B9
├── fCommit
└── (sem pRemoveTemporaria)                                                    B8
```

A sequência de etapas é a mesma. A transação continua única (D-B7). O que muda é a granularidade dentro de cada etapa.

### 4.4 B9 — a garantia de gravação correta

Cinco verificações, todas `SELECT` (não entram no `LOGREP`), executadas antes do `fCommit`:

| | Verificação | Precisa da foto? |
|---|---|---|
| V1 | `CADLOT.LOT_SALDOS` = `LGCEST.LOG_SALOLD` + Σ movimento de `MOVDET` da rodada, por lote | sim |
| V2 | idem em `ITEGER.ITE_SALDOS`, por item | sim |
| V3 | `ITE_SALDOS` = Σ `LOT_SALDOS` do item | não |
| V4 | nenhuma contagem residual (`DIGCON = 'S'`) nas linhas de `BALZER`; todo `MOVGER` da rodada tem `MOVDET` | não |
| V5 | cobertura: linhas de `BALZER` sem par em `LGCEST` — quantas ficaram fora de V1/V2 | — |

A foto do saldo pré-ajuste vem de `LGCEST`, gravada no início da rodada com `LOG_SALOLD`, `LOG_NUMLOT` e `LOG_CODCON` — tabela real, persistida, auditável depois do fato.

**Assimetria de cobertura.** Linha sobrando em `LGCEST` (gravação só de ativos, por exemplo) é inofensiva: movimento zero, `esperado = antes = atual`. Linha faltando — item acrescentado por `pAjustaITEGERSemContagemNaCADLOT` ou pelo ramo de transferência — ficaria sem verificação; é buraco de cobertura, não falso alarme. V3, V4 e V5 fecham esse buraco: V5 mede o tamanho dele e V3/V4 verificam sem depender de foto.

Divergência em qualquer uma → `fRollBack` e mensagem com a lista dos itens divergentes.

**O que B9 resolve que hoje não é resolvido.** `fAtualizaEstoqueCadIte` engole a exceção e devolve `Result := False` ([untCadIte.pas:313-319](../../padra_atualizado/fontes/cadastros/untCadIte.pas)), e `Result` é sobrescrito no documento seguinte. B9 não depende de `Result` sobreviver ao laço: compara o estado gravado com o esperado, no fim. Junto com ele entra um `Break` determinístico no laço de documentos — flag que nenhum documento seguinte sobrescreve — para não continuar processando depois de uma falha.

---

## 5. Mudanças

### B1 — `TItemZeraList` O(1)

`TDictionary<String, Integer>` com chave `ZER_CODITE|ZER_NUMLOT|ZER_LOCFIS` para o lookup, mais array com `Capacity` pré-dimensionada para preservar a ordem de inserção. Interface pública inalterada (`AddItem`, `Contains`, `GetItems`, `Clear`) — nenhum chamador muda.

### B2 — Fase 0 set-based

Método novo em `untConDet.pas`, análogo a `fGravaConDetItens`: um `INSERT INTO CONDET ... SELECT ... ⋈ BALZER`, reproduzindo as colunas de `fInserirRegistro` ([untConDet.pas:629](../../padra_atualizado/fontes/cadastros/untConDet.pas)) e o filtro de variação (`FSalConOld <> FSalCon Or FGmlConOld <> FGmlCon Or FDigConOld <> FDigCon`), que em SQL vira o teste sobre os valores lidos de `ITEGER`.

Ordem obrigatória: **antes** da Fase 1, porque a Fase 1 zera `ITE_SALCON`/`ITE_DIGCON` e o registro precisa do valor anterior. É o mesmo motivo comentado no código hoje.

`AUTOINCREM` pela técnica `SET @AUTINC` + `@AUTINC := @AUTINC + 1` que `fSQLInsertItens` já usa em produção, com um `fRetAutoIncrem('CONDET', ..., n)` por rodada.

### B3 — Fase 2 set-based

Overload novo de `fZeraContagemLote` em `untCadLote.pas` recebendo a rodada (`ZER_CON_ID` + `ZER_CODCON`) em vez de item + lote. Por chunk:

1. `UPDATE CADLOT ⋈ BALZER` — `LOT_SALCON`, `LOT_ML_CON`, `LOT_DIFSAL`, `LOT_DIF_ML`, `LOT_DIGCON`, `LOT_ORDCON`
2. `UPDATE LOTLOC ⋈ BALZER` — quando `fUsaMaisDeUmaLocalizacaoFisicaPorLote`
3. `INSERT INTO CONDET ... SELECT ⋈ BALZER` — o `CONDET` de nível de lote, lendo `CADLOT` real
4. histórico de lote numa passada

**Invariante:** nenhum desses comandos escreve em `LOT_QTDAJU`, `LOT_SEQAJU` ou `LOT_DTAAJU` — igual ao `UPDATE` conjugado de hoje. Vai como asserção no diff de equivalência (ver B12).

A assinatura atual de `fZeraContagemLote` fica intocada: `untBalancoEstoqueZera`, `untBalancoEstoqueZerarSaldo` e o overload interno continuam byte a byte no caminho de hoje.

### B4 — Suprimir o toque redundante em `ITEGER`

Parâmetro `AblnAtualizaIteger: Boolean = True` em `fZeraContagemLote`. O balanço passa `False`, porque a Fase 1 já gravou o mesmo estado; os outros chamadores usam o default e não mudam.

Efeito medível direto: `TOQUES_ITEGER` da Fase 2 cai de ~1 por linha contada para **zero**.

### B5 — Residual do laço de divergências

- `Application.ProcessMessages` e `pgbProgresso.Position` a cada 50, como `fZeraItens` já faz
- `fLoteComLocalizacaoCritica`: pré-carga única dos pares (item, lote) com `LOC_CRITIC = 'S'` num dicionário, só se `CFG_CADLOC = 'S'`
- `pAtualizaAutoincBalDet`: acumular (item, autoincremento) e aplicar set-based por documento
- `pFinalizaMapDet` por linha: avaliar substituição pela chamada global `('','')` que a passada de finalização já faz
- `fCalcTotais`: remover o `First` e a construção de `strCodItens`
- Apagar `fMarcaAjuIteger`, `fMarcaAjuCadLot`, `fAjusteQtdIteger`, `fAjusteQtdCadLot` — sem chamador desde o M3
- `pAjustaITEGERSemContagemNaCADLOT`: as duas subconsultas correlacionadas viram `LEFT JOIN` + `GROUP BY`

### B6 — Bloco de sequencial por rodada

Parâmetro `AintQuantidade: Integer = 1` em `fRetSequencial`. Com o default, comportamento atual byte a byte. O balanço reserva `intQtdDoc` números numa chamada e distribui em memória, o que também tira a linha `CFG_PRO_AJ` do `FOR UPDATE` prolongado.

Último passo da sequência: é o único que sai do balanço e atinge o ERP inteiro, como foi o M6 da Parte A.

### B7 — `fGravaLogContagemEstoque`

Avaliar reaproveitar `qryGen` em vez da segunda abertura de `fRetSQLItens`, e alinhar o corte do lote de `sltInsert` ao `BatchSize` de 500 usado no `MOVDET`.

### B8 — Eliminar as temporárias de contagem

Remover `pCriaTemporariasEmContagem`, `pRemoveTemporaria`, as chamadas em [:1675](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas) e [:1785](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas), e o parâmetro `blnUsaTemporaria` de `fGravaConDetZeraContagemLote`. Deixa de copiar o conjunto contado inteiro duas vezes e de rodar 2 `ALTER TABLE`, e corrige o defeito de replicação de §2.9.

As constantes `TMP_ITEGER_CONTAGEM`/`TMP_CADLOT_CONTAGEM` em `untConstantes.pas` ficam sem uso — remover junto.

### B9 — Verificação de integridade da rodada

Método novo `fVerificaIntegridadeRodada`, chamado em `fGravar` depois de `fZeraItens` e antes do `fCommit`. As cinco verificações de §4.4. Mais a flag de falha determinística no laço de documentos.

### B10a — As duas consultas por linha com parâmetro vazio

Guarda de chave vazia antes de ir ao banco, em `MOVTRI.DET_EMPORI` e em `FATSIM.SIM_SEQFDO`. Nos dois casos a guarda que já existia **depois** da consulta descartava o resultado, então suprimir a ida ao banco não muda comportamento nenhum. Medido: 280 execuções de cada numa rodada de 280 linhas.

**Pendência de investigação:** a guarda do `FATSIM` está no lugar, não há outro ponto de chamada e não há `$BOOLEVAL` sobrescrito, mas as 280 execuções continuaram na medição seguinte. Falta uma parada no depurador em `strNum_Pd` / `strInc_Pd` para saber se os parâmetros chegam realmente vazios. Enquanto isso não fechar, o ganho do B10a vale só pelo `MOVTRI`.

### B10b — Molde de dataset reaproveitado em `fGravaMovDet`

`fGravaMovDet` cria e abre três datasets por chamada — `SELECT * FROM MOVDET WHERE FALSE` e os equivalentes de `MOVTRI` e `MOVAUX` ([untMovGer.pas:3195-3205](../../padra_atualizado/fontes/faturamento/untMovGer.pas)). Eles servem só como **molde**: o código faz `Insert` / `FieldByName` / `Post`, e com o lote ativo o `pPostOuAcumula` cancela a inserção. A estrutura de campos é a mesma em todas as linhas. Numa rodada de 14.000 linhas são 42.000 idas ao banco só para obter metadado.

**O desenho que ficou, e onde ele difere do previsto:**

- A adesão **não** é por `ABatch <> Nil`, como esta seção previa. São três variáveis de unit na `implementation`, ligadas e desligadas pelo par `pAbreMoldesMovDet` / `pFechaMoldesMovDet`. Fora dessa janela as variáveis são `Nil` e `fGravaMovDet` cria e abre os próprios datasets, byte a byte como hoje — venda, devolução, compra e transferência não mudam. É o mesmo padrão do cache de `@VS_ID_TRANSACAO` (D8 da Parte A).
- O motivo de não guardar o molde no `TMovDetParams`: o parâmetro é `const objParams` ([untMovGer.pas:1011](../../padra_atualizado/fontes/faturamento/untMovGer.pas)), e trocar para `var` mudaria a assinatura de uma função que serve quatro operações.
- O ciclo de vida é do **chamador**, como no `ABatch` (D7 da Parte A): o balanço abre junto com o `objBatchMovDet` e fecha nos dois pontos de saída — fim normal e `Except`. Molde aberto depois da rotina terminar seria estado global vazando para o resto do ERP.
- O `Finally` de `fGravaMovDet` libera **só o que aquela chamada criou** (`If qryTblMovDet <> objMoldeMovDet Then FreeAndNil(...)`). Liberar o molde ali deixaria ponteiro pendurado para a linha seguinte.
- `BRIDET` ficou de fora: não dispara nesta configuração e é aberta dentro de um ramo condicional, então não renderia e traria risco sem contrapartida.

**Por que o `Insert` reduz o risco, e por que não elimina:** `Insert` limpa o registro, então cada linha começa com os campos em `null`/default mesmo num dataset reaproveitado. O que sobra é código que **leia** um campo antes de atribuir, contando com o default de um dataset recém-aberto.

**Por isso o B10b não entra no commit sem o diff.** `testes/05_diff_b10b.sql`, gerado do schema real por `ferramentas/gera_diff_b10b.py`, compara **365 colunas** — 129 de 142 em `MOVDET`, 203 de 205 em `MOVTRI`, 33 de 34 em `MOVAUX` — entre duas rodadas da mesma massa, casando por `(DET_CODITE, DET_NUMLOT)`, que é único dentro da rodada (conferido: 14.000 linhas, 14.000 pares). Ficam fora autoincremento, número de documento, data e hora. Qualquer coluna com contagem maior que zero derruba o mecanismo.

**Resultado, 2026-08-21: aprovado.** Zero divergentes nas 365 colunas, e `LOGREP` idêntico nas duas rodadas — 1.149 comandos e 13 tabelas — o que é verificação e não coincidência, porque o B10b só elimina `SELECT`. **Medido:** laço de documentos de 201 s para 134 s, rodada inteira de 231 s para 160 s. Detalhe em `testes/tasks.md` Bloco I.

**Achado de schema, válido para qualquer consulta futura:** em `MOVTRI` e `MOVAUX`, `DET_SEQGER` **não é o documento** — é a chave primária dessas tabelas e aponta para `MOVDET.AUTOINCREM`, ou seja, para a linha. Elas não têm `AUTOINCREM`, nem `DET_SEQDET`, nem `DET_CODITE`/`DET_NUMLOT`: são extensões 1:1 de `MOVDET`, com 14.000 linhas em cada uma nas duas rodadas.

### B11 — `PROINC` da `LGCEST` uma vez

Remover o `UPDATE PROINC SET PRO_AUTINC = PRO_AUTINC + 1` concatenado por linha ([:1315](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)). O bloco já é reservado por `fRetAutoIncrem(..., RecordCount)`, e `PROINC` não replica (D-B6).

### B12 — `LOT_QTDAJU`: provar a causa e blindar

1. Reproduzir na base de produção (trunk) a aritmética de §2.8: 14 documentos × 20 lotes, 260 zeros.
2. Provar 280 de 280 e 40 de 40 na base mesclada com o M3 aplicado.
3. Asserção no diff de equivalência: nenhum comando de B3/B4 escreve em `LOT_QTDAJU`, `LOT_SEQAJU`, `LOT_DTAAJU`, `ITE_QTDAJU`, `ITE_SEQAJU` ou `ITE_DTAAJU` — só `fAplicaAjuste*` escreve nesses campos.
4. Sem script retroativo (D-B8).

### B13 — Índice em `ITE_DIGCON` e `LOT_DIGCON`

`(ITE_CODEMP, ITE_DIGCON)` em `ITEGER` e `(LOT_CODEMP, LOT_DIGCON)` em `CADLOT`. As tabelas são pequenas — 114.772 e ~1 milhão de linhas — e o custo de manutenção é baixo: `ITE_CODEMP` nunca muda e `ITE_DIGCON` só muda durante o balanço, então o índice só é tocado em `INSERT`/`DELETE` de item e no próprio zeramento.

O ganho não é só de tempo de consulta: **reduz o conjunto de linhas travadas**, porque o `UPDATE` deixa de examinar a tabela inteira. É o conserto direto do incidente de §2.13.

Entra no mesmo pacote de atualização do `BALZER`. **Ressalva:** `ITEGER` já tem 37 índices e é tabela quente de venda; a decisão de acrescentar mais um é do Willian (Q-B10).

### B16 — Limpeza da `BALZER` entre rodadas

**Encontrado em 2026-08-21**, ao conferir a foto para o aceite do B9: a `BALZER` tem **112.840 linhas de 6 rodadas**, nenhuma apagada.

`pCarregaFotoBALZER` limpa em dois passos ([untBalancoEstoqueGravar.pas:3850-3866](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)):

```
DELETE FROM BALZER WHERE ZER_CODCON = :CODCON                        -- a propria rodada
DELETE FROM BALZER WHERE ZER_CON_ID = :CONID AND ZER_CODCON <> :CODCON  -- sobra da mesma estacao
```

Os dois são corretos e nenhum dos dois alcança a rodada de **outra** sessão: `ZER_CON_ID` é o `VS_ConnectionID`, que muda a cada conexão. Então a foto de cada rodada fica na tabela para sempre. Aqui são 6 rodadas de teste; num cliente com uma contagem de 20.000 linhas por dia são ~40.000 linhas/dia acumulando — a tabela de trabalho vira tabela histórica sem que ninguém tenha pedido isso.

**Por que a foto não pode simplesmente ser apagada no fim da rodada:** ela é o que o `testes/01_aceite_b9.sql` compara de fora depois do commit, e é a única evidência do estado anterior se a rodada precisar ser auditada. Some no fim = perde a auditoria.

**Correção proposta:** um terceiro `DELETE` de faxina no `pCarregaFotoBALZER`, por data, com o corte calculado no Delphi:

```pascal
qryFoto.SQL.Text := ' DELETE FROM BALZER WHERE ZER_DTACAD < :DTALIM ';
qryFoto.ParamByName('DTALIM').AsDateTime := fNow() - INT_DIAS_RETENCAO_BALZER;
```

O corte vem de `fNow`, não de `CURRENT_DATE` do servidor. Aqui a regra do projeto tem motivo próprio além da convenção: é um `DELETE`, e estação com relógio adiantado apagaria foto dentro da janela. É **1 comando por rodada** no `LOGREP`.

**Aplicado em 2026-08-24, retenção de 7 dias** (`INT_DIAS_RETENCAO_BALZER` em `untConstantes.pas`). Como `ZER_DTACAD` é `DATE` e a comparação é `<`, a linha datada de exatamente 7 dias atrás sobrevive — a janela efetiva é de 8 dias.

**O índice não é opcional.** Sem índice em `ZER_DTACAD` o `DELETE` varre a tabela, e em `DELETE` o InnoDB trava tudo que **examina** — seria reproduzir dentro da `BALZER` o problema que o B13 descreve em `ITEGER`/`CADLOT`. Script para base existente: `banco/03_indice_balzer_dtacad.sql`; para instalação nova o índice já entrou no `ALTER TABLE` do `01_cria_BALZER.sql`, junto com `idx_balzer_origem`, que estava aplicado na base de teste mas faltava no script.

**Ordem de implantação:** índice primeiro, versão compilada depois. Na ordem inversa a primeira rodada executa o `DELETE` sem índice.

### B14 — `pAtivaItem` uma vez por item, não por linha

**Descoberto na medição de volume (rodada `001000145`, 14.000 linhas, 2026-08-20)**, e não previsto no diagnóstico original porque a massa funcional de 40 itens tinha todos os itens ativos:

```
UPDATE CADITE SET ITE_ITEATI = 'S' WHERE ITE_CODITE = ...     5.677 execuções
```

São **94% dos 6.015 comandos replicados** da rodada inteira — de longe o maior termo de round-trip que restou depois de B2, B3, B4, B8 e B11. E 5.677 / 7 = 811: eram 811 itens inativos, com 7 lotes cada, e o `UPDATE` saía uma vez por **linha**. Seis de cada sete são redundantes.

O mecanismo é o mesmo que o B2 corrigiu no `CONDET`: a guarda do chamador lê `ITE_STATUS` de `qryGen`, carregada **antes** da gravação. `pAtivaItem` grava em `CADITE`, mas `qryGen` continua dizendo INATIVO nas outras seis linhas do item, e o comando repete. Reler o dataset não é opção; deduplicar em memória é — `sltItensAtivados`, `TStringList` ordenada com `dupIgnore`, no mesmo padrão de `sltItensSaldoAlterado`.

O `Clear` no início de `fGravar` não é opcional: sem ele, gravar duas vezes sem fechar a tela faria a segunda pular a ativação.

**Só executa quando `opcGravacao = opcAtivar`** — o caminho "Gravar Todos" / "Ativar Inativos" da tela. Na gravação normal o termo não existe.

### B15 — `DisableControls` em `fVerificaSeTemDiferencasParaGravar`

**Apontado pelo Willian em 2026-08-20**, olhando o grid rolar durante a gravação.

`fVerificaSeTemDiferencasParaGravar` percorre `qryGen` com `First`/`Next` e **sem** `DisableControls`. Ela roda no topo de `fConfirmaAjuste`, **antes** do `qryGen.DisableControls` que está no bloco seguinte — então cada `Next` repinta o grid.

O custo depende da passada:

| `strEspDoc` | Campo | Comportamento |
|---|---|---|
| `AJ` | `ITE_DIFERE` | sai no primeiro registro com diferença — na massa de balanço é o registro 1, custo desprizível |
| `ML` | `ITE_DIFGML` | zero em todas as linhas quando não há divergência de gramatura, então **varre o dataset inteiro** repintando |

Com `CFG_USATMQ = 'S'`, o caso deste cliente, a passada `ML` roda sempre. Na massa de volume são 14.000 registros.

Duas correções no mesmo lugar: `DisableControls`/`EnableControls` com `try..finally` — obrigatório, porque o `Exit` do meio da função e o `Break` sairiam sem reabilitar e o grid ficaria morto pelo resto da sessão —, e o `FieldByName` fora do laço, que resolvia o campo por nome a cada iteração.

---

## 6. Requisitos técnicos e não funcionais

- Transação do `AJ` única e atômica (D-B7)
- Nenhuma DML replicada citando temporária (D-B4)
- Conteúdo gravado idêntico em `MOVGER`, `MOVDET`, `MOVTRI`, `MOVAUX`, `CONDET`, `LGCEST`, `HISBAL`, `CADLOT`, `ITEGER`, `LOTLOC`, `LOCCON`
- Adesão a comportamento novo sempre por parâmetro com default atual, ou overload novo
- `untBalancoEstoqueGravar.pas`, `untCadLote.pas`, `untConDet.pas` são **latin-1 + CRLF**; `untFuncoesSimples.pas` é **UTF-8 com BOM**; `untMovGer.pas` a conferir antes de editar
- `BALZER` criada no pacote de atualização do cliente

## 7. Critérios de aceitação

- [ ] `TOQUES_ITEGER` da rodada no piso: ~1 por item, contra ~1 por linha contada hoje
- [ ] Diff coluna a coluna sem divergência em `MOVGER`, `MOVDET`, `MOVTRI`, `MOVAUX`, `LGCEST`, `CONDET`, `CADLOT`, `ITEGER`, `LOTLOC`, `LOCCON`, `HISBAL` — nas massas `04_massa_multilote_40`, `04b_massa_multilote_300` e `03_massa_2000_itens`
- [ ] `LOT_QTDAJU` correto em 280 de 280 lotes e `ITE_QTDAJU` em 40 de 40 itens
- [ ] B9 aprova a rodada boa e **reprova** uma rodada sabotada (teste de falha induzida em `fAtualizaEstoqueCadIte`)
- [ ] Teste de rollback: saldo intacto e contagem preservada
- [ ] Gravar duas vezes sem fechar a tela não pula zeramento (regressão do `Clear`)
- [ ] Nenhum comando replicado citando `TMP_`
- [ ] `svn status` mostra só os arquivos previstos

## 8. Massa de teste e medição

Massas existentes em `IA/456948/testes/` seguem valendo: `04_massa_multilote_40.sql` (funcional), `04b_massa_multilote_300.sql`, `03_massa_2000_itens.sql` (volume), mais `06_snapshot_BASE/NOVA`, `07_diff`, `08_metricas`.

**A BASE precisa ser recapturada** — a da Parte A foi tirada antes do merge do trunk.

Métrica que domina, medida direto no general log:

```sql
SELECT COUNT(*)                                          AS STATEMENTS,
       SUM(argument LIKE 'CALL pSetaVariaveisPreAlt%')   AS TOQUES_ITEGER,
       SUM(argument LIKE 'INSERT INTO LOGREP%')          AS COMANDOS_APP,
       TIMESTAMPDIFF(SECOND, MIN(event_time), MAX(event_time)) AS SEGUNDOS
  FROM DBA_GENERAL_LOG_<AAAAMMDD_HHMMSS>
 WHERE thread_id = <thread da gravação>;
```

Ressalva registrada pela Parte A: contagens de statement por janela ficam contaminadas pelos scripts de snapshot que rodam na mesma janela. Filtrar por `thread_id` sempre, e tratar `COMANDOS_APP` como a leitura mais confiável.

**Ambiente:** `CFG_ITEDOC` da empresa 001 está em **500** no banco de teste (`testes/10_itedoc_500.sql`) — reverter se a base for reaproveitada para medição funcional.

## 9. Fora de escopo

- Alterar o trigger `pSetaVariaveisPreAlt`, o `INSERT INTO LOGREP` ou desligar `VS_blnGravaLogTransacao`
- Re-derivar a lógica de negócio ou fiscal de `fGravaMovGer`/`fGravaMovDet`
- Corrigir `TBatchReprocessarSaldo.pUnifica` (§2.11) — dono no faturamento
- Sanear o conteúdo do log de zeramento da `CONDET` (§2.11, D9 da Parte A)
- Script retroativo de `LOT_QTDAJU` (D-B8)
- `F_AUDITORIA_GRAVACAO_SALDO` e o caminho `CFG_UTAUFA = 'S'` (§2.12)
- Fronteira de commit dentro do `AJ` (D-B7)
- Reduzir `CFG_ITEDOC` como alavanca
- Refatoração não relacionada ao objetivo

## 10. Questões

| # | Questão | Estado |
|---|---|---|
| Q-B1 | Como o DDL de `BALZER` chega às réplicas e às bases dos clientes? | **Respondida:** no pacote de atualização do cliente |
| Q-B2 | `AUTOINCREM` convencionado em `BALZER`? | **Respondida:** não; `BIGINT AUTO_INCREMENT` próprio, com identificador de sessão |
| Q-B3 | O conjunto de `LGCEST` da rodada é igual ao de `BALZER`? | **RESPONDIDA por medição, 2026-08-20:** V5 = 0 na rodada `001000143` — as 280 linhas de `MOVDET` têm par na foto. Cobertura completa nesta configuração |
| Q-B4 | O `UPDATE PROINC + 1` por linha existe para a réplica? | **Respondida:** não, `PROINC` não replica |
| Q-B5 | O cliente dos ~20 min tem `CFG_UTAUFA = 'S'`? | **Respondida:** a base de teste é réplica real do cliente, e está `'N'` |
| Q-B6 | Manter transação única? | **Respondida:** sim |
| Q-B7 | Corrigir `LOT_QTDAJU` histórico? | **Respondida:** não, manter os dados |
| Q-B8 | Depois de B1–B12, o que sobra no topo do perfil de statements? | **Parcialmente respondida, 2026-08-20:** o perfil da rodada `001000143` está em `testes/tasks.md` §E. No topo estão exatamente B2, B3, B4, B10 e B11. Achado novo: `SELECT CURRENT_TIME` a 1 por linha na Fase 2, origem a rastrear |
| Q-B9 | Alguma leitura entre a Fase 0 e a Fase 1 depende de `ITEGER` já zerado? | **Aberta:** mapear antes de aplicar B2 |
| Q-B10 | Acrescentar índice em `(ITE_CODEMP, ITE_DIGCON)` e `(LOT_CODEMP, LOT_DIGCON)`? | **Respondida — APROVADO (2026-08-24).** Criados na base de teste. `ITEGER`: `rows` 31.496 e `filtered` 10% → `ref = const,const`, 100%. `CADLOT`: 69.142 e 10% → idem. Entram no `banco/ddl.sql`, bloco 2 |

## 11. Dependências e riscos

| # | Risco | Mitigação |
|---|---|---|
| R-B1 | B3/B4 alteram `untCadLote.pas`, usada por balanço zera, importar, ajuste e zerar saldo | Overload novo e parâmetro com default; assinatura atual intocada |
| R-B2 | B4 suprime gravação em `ITEGER` — se a Fase 1 não cobrir algum campo, sobra estado sujo | Diff coluna a coluna de `ITEGER`; V4 do B9 detecta contagem residual |
| R-B3 | B2 muda a fonte do `AUTOINCREM` da `CONDET` | Mesma técnica `SET @AUTINC` de `fSQLInsertItens`, já em produção |
| R-B4 | `BALZER` ausente na base de teste ou na réplica derruba a rotina | Tarefa bloqueada até a tabela existir; script entregue antes de qualquer edição de `.pas` |
| R-B5 | Larguras de coluna divergentes em `BALZER` matam o índice do join, sem erro | Conferir tipos contra `CADLOT`/`ITEGER` no script |
| R-B6 | B10b altera `fGravaMovDet`, que serve todo o ERP | Adesão pelo par `pAbreMoldesMovDet`/`pFechaMoldesMovDet`; fora da janela as variáveis são `Nil` e o caminho é o de hoje. Prova: `testes/05_diff_b10b.sql`, 365 colunas |
| R-B7 | B6 mexe em `fRetSequencial`, usada por todo o ERP | Último passo; testado em venda e devolução antes de seguir; reversível isolado |
| R-B8 | Ordem Fase 0 → Fase 1 invertida por acidente suprime o `CONDET` de item | Comentário no código e caso de teste dedicado (Q-B9) |
| R-B9 | Edição direta corrompe acentuação | Só por `IA/456948/ferramentas/edita_pas.py`; conferir `U+FFFD == 0`, CRLF e `Try` = `Except` + `Finally` |
| R-B10 | `financeiro/contasareceber/untBaixaReceber.pas` e `.dfm` aparecem modificados sem terem sido tocados por este trabalho | Reverter antes do commit; conferir `svn status` no fechamento |

## 12. Restrições do projeto aplicáveis

Travas do pre-commit que aparecem nesta rotina: `StrToFloat`/`StrToFloatDef` → `fStrToFloat`/`fStrToFloatDef`; `Now()` → `fNow()`; `.SetFocus` → `pSetFocus`; `TBitBtn`/`TButton` → `TBitBtnLocked`; `Application.CreateForm` → `pCriarForm`/`pCriarFormularios`; `FOREIGN_KEY_CHECKS` proibido em script.

Zona legado: manter Hungarian style, prefixos `unt`/`p`/`f`/`F`/`A`, SQL embutido com `ParamByName`.

Commit: primeira linha `Req. 456948`, token do DelphAI na mensagem. Só o Willian commita. Compilação só pelo Willian, projeto `autcom.dproj`.

## 7. Review de código pré-commit (2026-08-24)

`/review` sobre os 10 arquivos alterados pela Parte B (mais Parte A, todos do
Req. 456948) apontou 11 achados. Verificados um a um contra o fonte e, quando
aplicável, contra a `BASE` do SVN antes de corrigir — para separar regressão
desta requisição de defeito legado.

| # | Achado | Verificação | Decisão |
|---|---|---|---|
| 1 | `fDeveZerarItem` invertido, escopo largo | confirmado contra a `BASE` (`pZeraItem`) | corrigido — gate virou predicado do `UPDATE` de lote |
| 2 | leitura de `DET_TIP_FC` depois do `Cancel` | confirmado no corpo de `PostOuAcumula` | corrigido — usa `strTip_Fc` |
| 3 | bloco de ID do `CONDET` off-by-one | confirmado nos 4 pontos, 2 deles regressão da Parte A | corrigido nos 4 |
| 4 | batch de saldos armado após `Exit` | confirmado — 2 `Exit` sem desarme | corrigido |
| 5 | batch ignora `AUsarBatchSaldos` | confirmado — muda regra de negócio | **mantido, decisão do Willian** — garantia é do B9 |
| 6 | `FormatDateTime('hh:mm:ss', ...)` | **incorreto** — `mm` após `h`/`hh` é minuto em Delphi | não é defeito |
| 7 | build Linux, `untTypesSistema` fora do `{$IFDEF}` | confirmado, correcao depende do `.dproj` | **recusado, decisão do Willian** |
| 8 | `TBatchSQL.Query` vaza | confirmado — mas `Destroy` incondicional quebraria 2 chamadores externos | corrigido com `OwnsQuery` opcional |
| 9 | notificação antes do commit | confirmado, **não é regressão** (original já fazia igual) | **corrigido, decisão do Willian** — melhoria |
| 10 | `fRetEmpresaFisica` por linha | confirmado — 14.000 `SELECT` na massa de volume, invisível ao `LOGREP` | corrigido — içado do laço |
| 11 | `FreeAndNil` sobre local não inicializado | confirmado — variável local não nasce `Nil` em Delphi | corrigido |

### Achado 5 — por que fica como está

`fUsouBatchSaldosSQL(strSQL)` é avaliado antes de `AUsarBatchSaldos` em
`untCadIte.pas` e `untCadLote.pas`: com o lote de saldos armado (M1b), todo
`UPDATE` de `ITEGER`/`CADLOT` é acumulado, mesmo quando o chamador passou
`AUsarBatchSaldos = False`. No balanço isso significa que
`blnTravarSeSaldoFicarNegativo` lê o saldo **anterior** ao ajuste — o `UPDATE`
real ainda não foi ao banco — e a trava de saldo negativo por linha, durante a
gravação, não vale.

Gatear também por `AUsarBatchSaldos` devolveria a trava por linha, mas mudaria
o comportamento de todo chamador que hoje conta com o batch mesmo sem pedir
explicitamente — risco fora do escopo de uma correcão de review.

**Decisão do Willian (2026-08-24): manter.** A garantia de que a rodada não
termina com saldo inconsistente é a do **B9**
(`fVerificaIntegridadeRodada`, §4.4) — confere o estado da rodada **inteira**
antes do commit, e reprova com rollback completo se algo não casar. É uma
garantia de outro nível (pós-fato, rodada completa) em vez de por-linha
(durante a gravação), mas cobre o mesmo risco de fundo.

### Achado 7 — por que fica como está

`untTypesSistema.pas` declara `ABatch: TBatchSQL` na interface (usa
`untTBatchSQL`/`untTBatchSQL.Helper`, ambos fora de qualquer `{$IFDEF}`), e os
`.dproj` dos 29 serviços Linux desta cópia não listam `genericos\BatchSQL\*`
no `DCC_UnitSearchPath`. As duas units são RTL + UniDAC puro, sem dependência
de VCL, e deveriam compilar em Linux sem ajuste de código — só falta
acrescentá-las aos projetos que precisarem. **Willian decidiu não alterar.**
Registrado para quem compilar para Linux com este trecho no caminho.

## 8. Segunda rodada de review (2026-08-24)

Nova leitura direta apontou 7 achados adicionais, mais 1 reencontro do achado 5
da seção 7. Quatro corrigidos, três verificados e descartados (não se
confirmaram como bug nesta base), um já decidido.

| # | Achado | Verificação | Decisão |
|---|---|---|---|
| 33 | `LOTLOC` zera lote inteiro, não a localização | confirmado contra a `BASE` (`fZeraContagemLocFis`) | corrigido — `AND Z.ZER_LOCFIS = LL.LLC_LOCFIS` |
| 34 | guarda multi-localização removida sem comentário | confirmado contra a `BASE` | corrigido — guarda restaurada |
| 35 | flag de notificação não restaurada nos 2 `Exit` | confirmado por leitura | corrigido — movida para o `Finally` do achado 4 |
| 36 | `fRollback` duplo (auditoria/B9 + `Else` final) | confirmado por leitura (não pude inspecionar o corpo de `fRollback`, fora do checkout) | corrigido — guarda `blnJaRollback` |
| 37 | `QuotedStr` sem escapar `\` | **não é bug vivo** — `fSafeSQLValue` já cobre no `ExecuteBatch` | sem alteração |
| 38 | `NULL` explícito virando `DEFAULT` | **não é bug vivo nesta base** — todas as colunas afetadas já têm `DEFAULT NULL` | sem alteração |
| 39 | `CONDET`: `COUNT` + `INSERT` separados (TOCTOU) | risco teórico correto, não se materializa — mesma conexão/transação, `CODCON` único | sem alteração |
| 40 | `inherited;` sem ancestral com o mesmo nome | **não é erro** — bare `inherited` sem homônimo é no-op no Delphi | Willian remove por conta própria (limpeza, não correção) |
| 5 (reencontro) | batch ignora `AUsarBatchSaldos` | já decidido na seção 7 | mantido |

### Achados 37 e 38 — por que "confirmado por leitura" não bastou

Os dois olham `PostOuAcumula` isoladamente e concluem risco real. Nos dois
casos, seguir a cadeia de chamadas até onde o SQL realmente executa muda a
conclusão:

- **37**: `PostOuAcumula` monta o texto com `QuotedStr` puro, sem escapar `\`.
  Mas quem executa não é `PostOuAcumula` — é `TBatchSQL.ExecuteBatch`, que roda
  **depois**, sobre o texto do lote inteiro, e já tinha (antes desta
  requisição) `fSafeSQLValue`, cujo regex dobra qualquer barra invertida isolada.
  Toda chamada a `Execute`/`Execute(AQuery)` passa por `ExecuteBatch`.

- **38**: confirmado o mecanismo (`IsNull` → campo omitido → `DEFAULT` da
  coluna), mas ele é uma escolha deliberada documentada no próprio código, e o
  exemplo citado (`BRI_CODPAR`) — como as ~11 outras colunas que o código desta
  área explicitamente nula — tem `COLUMN_DEFAULT = NULL` no schema real
  (conferido via `information_schema.COLUMNS`). Omitir ou emitir chegam ao
  mesmo valor. **Fica registrado como padrão frágil em princípio**: se uma
  coluna futura, explícita e intencionalmente nulada pelo código, tiver
  `DEFAULT` diferente de `NULL`, o valor gravado vai divergir do que o código
  pediu, em silêncio.

### Achado 40 — por que a leitura textual sozinha não resolve

`inherited;` bare (sem nome explícito de método) e `inherited NomeMetodo;`
(explícito) têm regras diferentes no Delphi: a forma explícita exige que o
método exista em alguma ancestral, e falha a compilação se não existir; a forma
bare, quando não há homônimo em nenhuma ancestral, é simplesmente ignorada
pelo compilador. `pBuscaItens` usa a forma bare, e nenhuma ancestral de
`TfrmBalancoEstoqueGravar` (`TfrmPai` → `TForm`) declara esse nome — confirmado
por busca sem diferenciar maiúscula/minúscula na árvore inteira. Isso compila.
