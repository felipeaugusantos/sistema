# Req. 456948 — Otimização da gravação do Balanço de Estoque por Ajuste

**Data:** 2026-08-19
**Fonte principal:** `padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas`
**Tela:** Útil > Operações Referentes a Produtos > Balanço de Estoque por Ajuste > Gravação da Contagem
**Zona de código:** Legado

---

## 1. Problema

A gravação da contagem leva **~20 minutos para ~2.000 itens**, mantendo transação aberta o tempo todo. O faturamento fica em espera atrás dela. Um relatório de monitor de lock registrou 96.570 linhas travadas em `ITEGER` num incidente.

O objetivo é reduzir o tempo de processamento e gravação ao menor valor possível, preservando o resultado e a integridade dos dados.

---

## 2. Diagnóstico medido

Toda a análise anterior partia de contagem de *statements da aplicação*. A medição desta análise mostra que essa métrica esconde o termo dominante.

### 2.1 O custo por linha tocada em `ITEGER`

O trigger `BEFORE UPDATE` de `ITEGER` executa, **por linha alterada**:

| # | Statement |
|---|---|
| 1 | `SELECT COALESCE(MAX(CAST(SIS_VALCFG AS UNSIGNED)), 2) INTO vDecUni FROM CFGSIS WHERE SIS_CODCFG = 'CFG_DECUNI' AND SIS_CODEMP = NEW.ITE_CODEMP` |
| 2 | `SET @ITE_PREALT = NEW.ITE_PREALT` |
| 3–6 | `CALL pSetaVariaveisPreAlt(...)` → **4 SELECT em `REGPRE`** |
| 7 | `INSERT INTO ITEGER_LOG_SALDOS ...` (condicional a mudança de saldo, ~40 colunas ANT/ATU) |

**~6 a 7 statements por linha de `ITEGER` alterada**, quase todos SELECT. Confirmado no general log: a thread 22347 (script de massa) tocou 32.852 linhas de `ITEGER` e gerou 98.556 statements de trigger — 3 formas × 32.852, nada mais.

`CADLOT` **não** tem o trigger PREALT. É barata por linha.
`MOVDET` tem trigger próprio: `CALL pAtualizaSaldoEntFut(NEW.DET_CODEMP, ...)`, 1 por linha inserida.

Consequência: **um `UPDATE` que atinge 14.000 linhas conta como 1 comando e custa ~90.000 statements.** Contar comandos da aplicação subestima o custo real por um fator de ~7.

### 2.2 Baseline real

Gravação de 60 itens com 1 lote cada (massa `01_massa_60_itens.sql`), thread 22895, general log de 2026-08-19:

| Métrica | Valor | Por item |
|---|---|---|
| Statements totais na thread | 4.586 | 76,4 |
| Toques em `ITEGER` (`CALL pSetaVariaveisPreAlt`) | 320 | **5,33** |
| Comandos da aplicação (`INSERT INTO LOGREP`) | 572 | 9,5 |

Fator de expansão comando-da-aplicação → statement no servidor: **~8×**.

### 2.3 Decomposição do custo

| Termo | Statements | % | Natureza |
|---|---|---|---|
| Toques em `ITEGER` × ~6 de trigger | ~1.920 | 49% | por **linha tocada** |
| `INSERT INTO LOGREP` (1 por `ExecSQL`) | 572 | 12,5% | por **round-trip** |
| SELECT de metadado e lookup por linha | ~600 | 13% | por **leitura** |
| Trabalho útil de negócio | ~1.500 | 25,5% | irredutível |

**Três termos independentes exigem três mecanismos distintos.** Nenhum mecanismo isolado resolve o problema.

### 2.4 Onde estão os toques excedentes em `ITEGER`

Com 1 lote por item já são 5,33 toques. Com ~7 lotes por item (caso real) o número cresce, porque parte dos comandos é executada **por linha de divergência** apesar de gravar estado **de nível de item**:

| Origem | Frequência hoje | Deveria ser |
|---|---|---|
| `pZeraItem` → `UPDATE ITEGER SET ITE_ORDCON=0, ...` ([:1628-1644](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) | 1 por linha de divergência | 1 por item |
| `fZeraContagemLote` → parte `G.ITE_*` do UPDATE conjugado ([untCadLote.pas:5695-5719](../../padra_atualizado/fontes/cadastros/untCadLote.pas)) | 1 por linha de divergência | 1 por item |
| `fAtualizaEstoqueCadIte` → `UPDATE ITEGER SET ITE_SALDOS = ...` ([untCadIte.pas:166-188](../../padra_atualizado/fontes/cadastros/untCadIte.pas)) | 1 por linha de divergência | 1 por item, agregado |
| `fMarcaAjuIteger` ([:3095](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) | 1 por documento (~700) | 1 por rodada |
| `fAjusteQtdIteger` ([:3193](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) | 1 por documento (~700) | 1 por rodada |

E em `CADLOT`, `fMarcaAjuCadLot` ([:3145-3168](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) tem `WHERE` com apenas `LOT_CODEMP` e `LOT_DIGCON = 'S'` — **sem restrição por item**. Executada uma vez por documento, cada execução varre todos os lotes ainda contados da empresa. Como `pZeraItem` vai limpando `LOT_DIGCON` conforme processa, o escopo encolhe a cada documento e o total é **quadrático** (~n²/2 linhas tocadas). É também a origem das 96.570 linhas travadas: a primeira execução trava todo o conjunto contado.

### 2.5 O M3 corrige um defeito de dados, não só de desempenho

Medido em 2026-08-19 comparando a versão base com a versão M3, mesma massa e mesmo estado inicial:

| | Base | Com M3 |
|---|---|---|
| `LOT_QTDAJU` igual ao movimento real | **238 de 280** | **280 de 280** |
| `ITE_QTDAJU` igual à somatória do item | **28 de 40** | **40 de 40** |

A versão base grava **`LOT_QTDAJU = 0` em 42 lotes que efetivamente movimentaram**, e `ITE_QTDAJU` errado em 12 itens.

**O mecanismo é o próprio trabalho quadrático se voltando contra os dados.** `fMarcaAjuCadLot` não tem restrição por item: na marcação do documento 1 ela carimba `LOT_SEQAJU` de **todos** os lotes ainda contados, inclusive os que só serão processados no documento 7. Em seguida `fAjusteQtdCadLot(doc1)` roda com

```sql
LEFT JOIN MOVDET MD ON ... AND MD.DET_SEQGER = I.LOT_SEQAJU
SET I.LOT_QTDAJU = IFNULL(IF(MD.DET_CLAFIS = 1999, MD.DET_QTDITE, MD.DET_QTDITE * -1), 0)
WHERE I.LOT_SEQAJU = :SEQAJU
```

Não há `MOVDET` daquele lote no documento 1, o `LEFT JOIN` não casa e o `IFNULL(..., 0)` grava **zero**.

Quando o documento 7 chega, o lote já foi zerado por `pZeraItem` (`LOT_DIGCON = 'N'`), então `fMarcaAjuCadLot` não o enxerga mais e o `LOT_SEQAJU` permanece apontando para o documento 1. O `fAjusteQtdCadLot(doc7)` filtra `LOT_SEQAJU = doc7` e não o alcança. O zero fica gravado.

Quanto mais documentos, maior a chance de um lote ser carimbado cedo e processado tarde — ou seja, **o defeito piora com o volume**. Na massa de 14 documentos atingiu 15% dos lotes; com ~700 documentos em produção a proporção tende a ser bem maior.

O M3 elimina o defeito por construção: uma passada única derivando de `MOVDET`, sem depender de qual documento carimbou o quê.

---

### 2.8 A rotina não era atômica — falha em item podia commitar documento incompleto

**Entrou no escopo por decisão do Willian, 2026-08-19** (D10). Corrigido pelo M7.

Três peças que se combinam:

| # | Onde | O quê |
|---|---|---|
| 1 | [untCadIte.pas:313-319](../../padra_atualizado/fontes/cadastros/untCadIte.pas) | `fAtualizaEstoqueCadIte` **engole a exceção** e devolve `Result := False`. Nunca chega ao `Except` do `fConfirmaAjuste`, então o `fRollBack` de lá não dispara |
| 2 | `pZeraItem`, no laço de itens | roda **mesmo com `Result = False`** — a contagem é consumida sem o estoque ter movido |
| 3 | topo do laço de documentos | `Result` é **sobrescrito** por `fGravaMovGer`, ou pelo `Result := True` do ramo sem `MOVGER`. A falha do documento N some quando o N+1 começa |

Se o último documento der certo, `Result` termina `True` e a rotina **commita**, levando junto o documento incompleto.

**Evidência reproduzida no banco.** Uma gravação que falhou deixou os documentos 3921 e 3922
commitados, cada um com uma linha de `MOVDET` movimentando 4 unidades do lote `003` do item
`00018`. O saldo desse lote continuou em **490** — não moveu. A contagem dos 7 lotes do item foi
zerada. Documento fiscal gerado, estoque não movimentado, contagem consumida.

O call stack confirmou o caminho: `untCadIte:272` (o `Raise`) → `untBalancoEstoqueGravar:2634`
(a chamada) → `:1363` (`fGravar`).

**A correção (M7)** fica contida em `fConfirmaAjuste` — não toca em `untCadIte.pas`, que serve
venda, devolução, compra e transferência. Uma flag `blnFalhouGravacao` que **nenhum documento
seguinte sobrescreve**, verificada logo após a atualização de estoque e **antes** do `pZeraItem`,
com `Break` no laço de documentos e `fRollBack` garantido no fecho.

---

### 2.7 Achado colateral — o log de zeramento da `CONDET` não registra variação

**Fora do escopo deste requisito** (D9). Registrado com a evidência para não se perder.

Medido na rodada de 2026-08-19, 2.559 linhas de `CONDET` para 40 itens:

| Grupo | Linhas | `DET_DIGOLD` | `DET_DIGNEW` | `DET_SALOLD` | Origem | Granularidade |
|---|---|---|---|---|---|---|
| Sem variação | **2.520** | `N` | `0` | 0 | `fGravaConDetZeraContagem` | por **lote** |
| Com variação | **39** | `S` | `N` | > 0 | `fGravaConDet` | por **item** |

**A causa é ordem de execução.** Dentro de `pZeraItem` a sequência é:

1. `UPDATE ITEGER SET ITE_SALCON = 0, ITE_DIGCON = 'N'` — zera a contagem
2. `DELETE FROM LOCCON`
3. `fZeraContagemLote` → chama `fGravaConDetZeraContagem`

E o `fGravaConDetZeraContagem` monta o registro lendo da própria `ITEGER`
([untConDet.pas:272-278](../../padra_atualizado/fontes/cadastros/untConDet.pas)):

```
DET_SALOLD ← ITE_SALCON     ← já zerado no passo 1
DET_DIGOLD ← ITE_DIGCON     ← já 'N'
DET_SALNEW ← 0              ← literal
DET_DIGNEW ← 0              ← literal
```

Ele lê o valor "antigo" **depois** de ele já ter virado o novo. Grava `old = 0` e `new = 0`: a
variação que existe para registrar já foi apagada quando ele roda.

As 39 linhas que **têm** variação vêm do `fGravaConDet`, chamado no topo do `pZeraItem`, antes
do zeramento — mas essas são de nível de **item**, não de lote.

**Consequência:** nenhuma das duas fontes entrega o que o relatório espera. A que tem a
granularidade certa (por lote) não tem variação; a que tem variação é por item.

**O conserto** seria mover o `fGravaConDetZeraContagem` para antes do zeramento e então filtrar
por `ITE_SALCON > 0 AND ITE_DIGCON = 'S'` — resultando em ~280 linhas, uma por item + lote, com
variação real. Mexe em `untConDet.pas` e na ordem do `pZeraItem`, e altera conteúdo de log
visível em relatório. **Requisito próprio.**

O defeito é **anterior a este requisito**: a ordem é a mesma no código base.

---

### 2.6 O que o modelo anterior errou

O handoff concluiu que a rotina era lenta por número de round-trips, com piso de ~9 min para o processamento linha a linha. Isso está incompleto:

- O termo dominante (49%) é **linhas tocadas**, não round-trips.
- O trabalho quadrático de `fMarcaAjuCadLot` não aparece na contagem de comandos: são ~700 comandos que custam milhões de row-touches.
- O piso de 9 min foi projetado contra a versão com fatiamento, não contra a versão base (§11.4 do handoff registra que não existe baseline pós-alteração).

---

## 3. Decisões desta análise

| ID | Decisão | Justificativa |
|---|---|---|
| D1 | **Commit em mais de uma etapa é aceitável**, desde que a integridade seja garantida | Decisão do Willian. Reverte a restrição §3.1 do handoff. A rotina já opera assim: `fGravaLogContagemEstoque` commita ~96 mil INSERT em `LGCEST` antes ([:1139-1191](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)); `fConfirmaAjuste('AJ')` e `fConfirmaAjuste('ML')` são transações separadas; `UPDATE LGCEST SET LOG_EFETIV = 1` roda em autocommit depois ([:1347](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)). **D1 remove a proibição, não obriga o uso**: o desenho de §4.3 escolhe não precisar dela, porque os três mecanismos de §4.1 reduzem a duração sem abrir fronteira de commit dentro do efeito. D1 permanece disponível caso a medição mostre que não bastou |
| D2 | **Modelo de integridade: reexecução idempotente** | Falha no meio → reexecutar continua de onde parou, sem duplicar. Nada precisa ser desfeito, o que é compatível com replicação |
| D3 | **`ITE_QTDAJU` é a somatória do item; `ITE_SEQAJU` aponta para um dos documentos válidos** — **confirmado por medição, ver §2.6** | `MOVDET` é movimentação por `DET_CODITE` + `DET_NUMLOT`. Quando há lote, os campos que importam são `LOT_QTDAJU`/`LOT_SEQAJU`. O código per-documento de hoje desvia dessa semântica quando as linhas de um item caem em dois documentos; a versão agregada a implementa corretamente |
| D4 | **A lógica de negócio e fiscal de `fGravaMovGer`/`fGravaMovDet` permanece intocada** | Não haverá re-derivação fiscal nem mapeamento dos 10 ramos de configuração. `fGetPesoEspecificoItemGranel` (tintométrico, `CFG_UTIIND` ativo) continua em Delphi. As funções recebem um parâmetro novo (D7) e o ponto de gravação passa por `pPostOuAcumula`, mas **nenhuma regra que decide valor de coluna é alterada** — só o momento e a forma de envio ao banco |
| D5 | **`TBatchSQL` no caminho do `MOVDET`; set-based apenas em `ITEGER`/`CADLOT`/`LOCCON`** | Cada mecanismo aplicado ao termo de custo que ele realmente reduz |
| D6 | **Meta: menor tempo possível de processamento e gravação** | Não há corte de aceite fixo; a reestruturação vai até onde os três termos permitirem |
| D7 | **A adesão ao lote é por parâmetro `ABatch: TBatchSQL = Nil` em `fGravaMovDet`** | Decisão do Willian. Passar a instância, e não um boolean: o chamador é dono do ciclo de vida e do momento do flush, e `Nil` significa "não existe acumulador" em vez de "existe mas está desligado". Evita o acumulador global do modelo `objBatchReprocessarSaldo`, com dicionário chaveado por transação e o risco de ponteiro de conexão reaproveitado. É o idioma da base: `objReplTinta: IExecutaSQLReplicacaoTinta = Nil`, `event_Parametros: TSetaParametros = nil` |
| D8 | **M6 não altera o comportamento da lógica central**: o cache do `@VS_ID_TRANSACAO` é armado pela rotina do balanço e só vale para a mesma conexão, com transação aberta | Decisão do Willian. Descarta o dicionário sempre ligado. Desarmado — o estado de todo o resto do ERP — `fGetIDTransacao` executa exatamente o código de hoje. O diff da alteração é **puramente aditivo**: 95 linhas inseridas, zero linhas existentes alteradas. Troca um risco difuso sobre o ERP inteiro por um risco confinado à janela onde o ganho existe |
| D9 | **`fZeraContagemLote` entra na guarda de item (M2b), mas a `CONDET` não é filtrada nem reordenada** | Decisão do Willian, 2026-08-19. A deduplicação leva a `CONDET` de ~2.559 para ~400 linhas sem mudar semântica de log. O saneamento do conteúdo — filtrar linhas sem variação e reordenar para que elas passem a ter — é **decisão de negócio, não de desempenho**, e sai do escopo deste requisito. Registrado como achado colateral em §2.7 |
| D10 | **O defeito de atomicidade entra no escopo deste requisito** | Decisão do Willian, 2026-08-19. É integridade, não desempenho, e é mais grave que o problema original. Corrigido pelo M7, contido em `fConfirmaAjuste`. Ver §2.8 |
| D11 | **O consumidor do `LOGREP` aceita comandos concatenados** | Resposta do Willian ao Q2, 2026-08-19. Destrava o M4: `TBatchSQL` pode agrupar até 500 comandos por `ExecSQL` sem quebrar a replicação |
| D12 | **`TConDet.pSetValoresAntigos` entra no escopo: com lote (`FNumLot` preenchido), a leitura de valores antigos passa a ler `CADLOT`, não `ITEGER`** | Achado do Willian, 2026-08-25. Sem a branch `blnTemLote`, o `INSERT` gravava `DET_SALDOS`/`QTEF_*`/`SALFIS` a partir de `ITEGER` mesmo quando a divergência era de lote — defeito de dados, não de desempenho, na mesma classe do M3. Comportamento correto portado da cópia `.150` |
| D13 | **`CONDET` em lote entra no escopo** (referenciado nos comentários do código como sub-item **456948-B**) | A gravação linha a linha do log de contagem (`INSERT INTO CONDET`) era o item 1 da lista de pendências, registrado como "requisito próprio" em `plans.md`. Medição de 2026-08-20 mostrou que era o termo dominante do tempo de parede (~23 min de ~24), não a gravação do documento. Absorvido neste requisito por decisão do Willian, 2026-08-25, junto com os mecanismos que o sustentam: `fGravaConDetZeraContagemLote` set-based (B2/B3), remoção de `blnUsaTemporaria` (B8), cache de `fGetPesoEspecificoItemGranel` restrito à janela do balanço, e `TBatchSQL.OwnsQuery` |

---

## 4. Arquitetura da solução

### 4.1 Princípio

Cada termo de custo tem um mecanismo próprio:

| Termo | Mecanismo | Onde |
|---|---|---|
| Linhas tocadas em `ITEGER`/`CADLOT` | Tocar cada linha **uma vez**: agregar, deduplicar, tirar do laço | M1, M2, M3 |
| Round-trips e `INSERT INTO LOGREP` | `TBatchSQL` — 100 comandos por `ExecSQL` | M4 |
| SELECT de metadado e lookup por linha | Pré-carga em dicionário | M5 |
| Overhead por comando | Cache do `@VS_ID_TRANSACAO` | M6 |

### 4.2 Por que `TBatchSQL` e não `INSERT ... SELECT` no `MOVDET`

`TBatchSQL.ExecuteBatch` ([untTBatchSQL.pas:387-428](../../padra_atualizado/fontes/genericos/BatchSQL/untTBatchSQL.pas)) concatena os comandos acumulados com `; ` em grupos de `FBatchSize` (default 100, máximo 1000) e dispara **um `ExecSQL` por grupo**. `AddQueryAsCommand(AQuery: TUniQuery)` ([:235](../../padra_atualizado/fontes/genericos/BatchSQL/untTBatchSQL.pas)) converte uma query já montada com parâmetros em texto literal no lote.

Como `fGravaLogRep` é acionado pelo SQL Monitor do UniDAC **por chamada de `ExecSQL`**, agrupar 100 comandos em um `ExecSQL` reduz o `INSERT INTO LOGREP` em ~100×, sem alterar o trigger nem o `INSERT INTO LOGREP` em si — a restrição §3.2 do handoff é respeitada.

O ganho é o mesmo que `INSERT ... SELECT` traria no termo de round-trip, **sem** o custo de reproduzir as 101 colunas do `MOVDET` e os 10 ramos de configuração fora das funções que os implementam. O que `TBatchSQL` não reduz — statements executados no servidor e triggers por linha — não seria reduzido por `INSERT ... SELECT` no `MOVDET` de qualquer forma, porque o trigger `pAtualizaSaldoEntFut` dispara por linha independentemente da forma do comando.

### 4.3 Modelo transacional

```
fGravar
├── fLock_Unlock(STR_TRAVA_CONDET)          exclusividade da rotina, já existe
├── fGravaLogContagemEstoque                transação própria, commit  [inalterado]
│     grava LGCEST com LOG_EFETIV = 0
├── fConfirmaAjuste('AJ')                   transação única
│     ├── laço de documentos
│     │     ├── fGravaMovGer                  → Post imediato (pai)
│     │     ├── fGravaMovDet(..., ABatch)      → acumula no TBatchSQL
│     │     └── contagem/saldo por item      → acumulam em batch de saldos
│     ├── flush dos lotes
│     ├── UPDATE set-based ITEGER  (1 toque por item)
│     ├── UPDATE set-based CADLOT  (1 toque por lote)
│     ├── DELETE LOCCON restrito aos itens
│     ├── UPDATE LGCEST SET LOG_EFETIV = 1 WHERE LOG_CODCON = :CODCON
│     ├── objBatchReprocessarSaldo.Execute  flush dos saldos, AINDA na transação
│     ├── objAuditoriaSaldo.fValidouTodas   auditoria vê o saldo final  [ordem obrigatória]
│     └── fCommit
└── fConfirmaAjuste('ML')                   transação própria  [inalterado]
```

A transação do `AJ` permanece **única e atômica** — o que **não era verdade antes do M7**.

> **Correção de 2026-08-19.** Esta seção afirmava atomicidade que a rotina não tinha. Uma falha
> na atualização de estoque não provocava rollback: `fAtualizaEstoqueCadIte` engole a exceção e
> devolve `Result := False`, o `pZeraItem` roda mesmo assim consumindo a contagem, e o `Result`
> é sobrescrito no documento seguinte. Se o último documento desse certo, a rotina **commitava**
> com documento incompleto dentro. Reproduzido no banco: documentos com `MOVDET` gerado, saldo
> do lote intocado e contagem consumida. Ver §2.8 e a Tarefa 7 do plano.

### 4.4 Idempotência (D2)

Com a transação do `AJ` atômica, a reexecução é idempotente **por construção**, por dois mecanismos que já existem:

1. **`LGCEST.LOG_EFETIV`** passa a ser gravado **dentro** da transação do `AJ`, junto com o efeito, em vez de em autocommit depois ([:1347](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)). Assim `LOG_EFETIV = 1` significa exatamente "o ajuste desta contagem foi efetivado". Se a transação cai, o log da contagem sobrevive com `LOG_EFETIV = 0` e a contagem pode ser reprocessada sem recontar.
2. **A própria query de divergência filtra o que falta**: `pZeraItem` limpa `ITE_DIGCON`/`LOT_DIGCON` dos itens processados, e a query só seleciona itens contados. Um item já efetivado não reaparece.

Não é necessário nenhum protocolo de retomada adicional nem tabela de staging. A `BALPLA` da §9.5 do handoff **não** faz parte deste desenho.

---

## 5. Mudanças

### M1 — Batch de saldos em `fAtualizaEstoqueCadIte`

Passar `AUsarBatchSaldos := True` na chamada de [:2561-2565](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas).

O parâmetro já existe ([untCadIte.pas:152](../../padra_atualizado/fontes/cadastros/untCadIte.pas)) e o balanço usa o default `False`. Quando ligado, o `UPDATE ITEGER SET ITE_SALDOS = ...` não vai ao banco na hora: entra em `objBatchReprocessarSaldo`, cujo `pUnifica` ([untFuncoesGenerica.pas:13760](../../padra_atualizado/fontes/genericos/untFuncoesGenerica.pas)) consolida os comandos por item e lote, e é descarregado dentro do `fCommit`, na mesma transação, antes do commit ([untFuncoesSimples.pas:11217](../../padra_atualizado/fontes/genericos/untFuncoesSimples.pas)). No `fRollBack` é descartado ([untFuncoesSimples.pas:11172](../../padra_atualizado/fontes/genericos/untFuncoesSimples.pas)).

Efeito: os `UPDATE` de saldo deixam de ser 1 por linha de divergência e passam a ser 1 consolidado por item.

#### Requisito obrigatório: flush antes da auditoria

M1 abre uma janela entre o momento em que o Delphi considera o saldo gravado e o momento em que o `UPDATE` chega ao banco. Dentro dela, `ITE_SALDOS` no banco ainda é o valor **antigo**. Quem lê saldo nesse intervalo lê errado, e sem erro — só um número diferente.

O leitor crítico é a auditoria, em [:2660-2665](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas):

```pascal
If Result And (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
Begin
  Result := False;
  fRollBack;
  pMostraErrosAuditoria(strCodErrosAuditoria);
End;
```

`fValidouTodas` não valida em Delphi: chama a função armazenada `F_AUDITORIA_GRAVACAO_SALDO(tabela, autoincrem, modo_robo)`, uma vez por documento ([untAuditoriaGravacaoSaldo.pas:82-88](../../padra_atualizado/fontes/faturamento/untAuditoriaGravacaoSaldo.pas)). Se ela confere saldo, o encadeamento com M1 é: batch adia o saldo → auditoria roda antes do flush → lê o valor pré-ajuste → não bate → `fRollBack`. **O balanço passaria a falhar sempre.**

**A resolução — `fConfirmaAjuste` descarrega o lote explicitamente antes da auditoria**, ainda dentro da mesma transação:

```pascal
objBatchReprocessarSaldo.Execute(fGetIDTransacao(conexao), conexao);   // saldos vão ao banco
If Result And (Not objAuditoriaSaldo.fValidouTodas(...)) Then          // auditoria vê o valor final
```

A auditoria passa a enxergar exatamente o mesmo estado que enxerga hoje, e M1 fica seguro **sem depender de saber o que a função lê**. Sem efeito colateral: `Execute` remove a entrada do dicionário depois de rodar ([untFuncoesGenerica.pas:14010](../../padra_atualizado/fontes/genericos/untFuncoesGenerica.pas)), então a chamada posterior dentro do `fCommit` não acha nada e é no-op.

O mesmo flush antecipado cobre os outros leitores de saldo do laço — `fLoteComLocalizacaoCritica` ([:3270](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) e `ReprocessarItem`.

**Por que isso não podia ser resolvido por teste.** Neste banco a auditoria está inerte: `CFG_UTAUFA = 'N'` em todas as empresas (001 a 100), `F_AUDITORIA_GRAVACAO_SALDO` não existe no schema, e a medição da gravação de teste registra **zero** chamadas a ela. Um cliente com `CFG_UTAUFA = 'S'` e a função instalada roda esse caminho. Sem o flush antecipado, o defeito passaria em toda a validação e quebraria na primeira gravação em produção.

### M2 — Deduplicação do trabalho de nível de item em `pZeraItem`

`pZeraItem` ([:1615-1671](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) é chamada uma vez por linha de divergência (item, lote, locfis), mas três dos seus comandos gravam estado de nível de item, com valores constantes:

- `UPDATE ITEGER SET ITE_ORDCON=0, ITE_SALCON=0, ITE_GMLCON=0, ITE_DIFSAL=0, ITE_DIF_ML=0, ITE_DIGCON='N' WHERE ITE_CODITE=:CODITE`
- `THistoricoBalanco.pLimpaHistoricoSaldoProduto('', strCodIte, Nil)`
- `DELETE FROM LOCCON WHERE ITE_CODITE=:CODITE`

Executar uma ou sete vezes produz o mesmo estado final.

Guardar com uma `TStringList` (`Sorted := True`, `Duplicates := dupIgnore`) dos itens já zerados, campo da classe, criada em `FormCreate` e liberada em `FormDestroy`. **`Clear` obrigatório no início de cada gravação** — sem isso, gravar duas vezes sem fechar a tela faz a segunda pular o zeramento dos itens da primeira.

Os dois comandos restantes de `pZeraItem` — `fZeraContagemLote` e `fZeraContagemLocFis` — dependem de lote/localização e **não** entram na guarda.

### M3 — `fMarcaAju*` e `fAjusteQtd*` fora do laço de documentos

Hoje as quatro funções rodam a cada documento ([:2301-2304](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas) e [:2616-2619](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) e novamente após o laço ([:2654-2658](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)). Com ~700 documentos são ~2.800 execuções, das quais só o efeito da última sobrevive em cada item — as anteriores são sobrescritas.

Substituir por **uma execução após o laço**, derivando o resultado de `MOVDET`, que é a fonte de verdade:

```sql
UPDATE ITEGER G
 INNER JOIN (SELECT DET_CODITE, DET_CODEMP,
                    MAX(DET_SEQGER) AS SEQGER,
                    SUM(IF(DET_CLAFIS = 1999, DET_QTDITE, DET_QTDITE * -1)) AS QTDAJU
               FROM MOVDET
              WHERE DET_CODEMP = :CODEMP
                AND DET_SEQGER IN (<autoincrementos dos MOVGER desta rodada>)
              GROUP BY DET_CODITE, DET_CODEMP) T
    ON T.DET_CODITE = G.ITE_CODITE AND T.DET_CODEMP = G.ITE_CODEMP
   SET G.ITE_DTAAJU = :DTAAJU,
       G.ITE_SEQAJU = T.SEQGER,
       G.ITE_QTDAJU = T.QTDAJU
```

`CADLOT` é análogo, agrupando por `DET_CODITE` + `DET_NUMLOT` e **com** restrição por item.

Isto implementa D3: `ITE_QTDAJU` vira a somatória do item; `ITE_SEQAJU` recebe um dos documentos válidos (`MAX(DET_SEQGER)`); `LOT_QTDAJU`/`LOT_SEQAJU` preservam o do próprio lote.

Os autoincrementos dos `MOVGER` da rodada já são acumulados em `strDocsGerados` ([:1992](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)); será necessária uma lista equivalente com `strAutInc` de cada documento.

Efeito colateral desejado: resolve automaticamente o escopo de lock da §9.1 do handoff — `fMarcaAjuCadLot` deixa de varrer todos os lotes contados da empresa a cada documento.

### M4 — `TBatchSQL` no caminho do `MOVDET`

Acumular as escritas de `fGravaMovDet` num `TBatchSQL` em vez de executá-las uma a uma.

**A adesão é por parâmetro `ABatch: TBatchSQL = Nil`** (D7), acrescentado ao fim da lista de parâmetros de `fGravaMovDet`. Ela está em `untMovGer.pas` e serve todo o ERP — venda, devolução, compra, transferência. Com `Nil` como default, nenhum desses fluxos muda: nem o comportamento, nem o momento em que o documento passa a existir no banco. Só a gravação do balanço passa uma instância.

#### O mecanismo: interceptar o `Post`, não o `ExecSQL`

A função **não** escreve por `ExecSQL`. Escreve por dataset:

```pascal
qryTblMovDet.SQL.Text := 'SELECT * FROM MOVDET WHERE FALSE';
qryTblMovDet.Open;
...
Insert;
FieldByName('DET_SEQGER').AsString := strSeqGer;
...
Post;
```

([untMovGer.pas:3185-3202](../../padra_atualizado/fontes/faturamento/untMovGer.pas); `MOVGER` em [:1926-1928](../../padra_atualizado/fontes/faturamento/untMovGer.pas) e [:2400](../../padra_atualizado/fontes/faturamento/untMovGer.pas)). É esse `Open` que produz o `SELECT * FROM MOVDET WHERE FALSE` medido a 1 por linha no general log. Portanto `TBatchSQL.AddQueryAsCommand` **não serve** — ele extrai SQL de query com parâmetros, não de dataset em modo inserção.

A peça que falta é uma procedure única, que `untTBatchSQL.Helper.pas` ainda não tem:

```pascal
// ABatch = Nil  -> Post normal (comportamento atual, intocado)
// ABatch <> Nil -> monta o INSERT a partir dos campos do dataset,
//                  acumula no lote e cancela a inserção
procedure pPostOuAcumula(ADataSet: TUniQuery; const AstrTabela: String; ABatch: TBatchSQL);
```

Escrita uma vez, atende todos os datasets de `fGravaMovDet` — `MOVDET`, `MOVTRI`, `MOVAUX`, `MOVREF` — porque todos usam o mesmo idioma `Insert`/`FieldByName`/`Post`. A montagem do `INSERT` usa `ABatch.BeginInsert(...).Fields(...).Values(...).EndInsert`, com `fDoubleToSQL` e `QuotedStr` para formatação, no idioma do projeto.

Campos explicitamente anulados pelo código (`FieldByName('DET_CODDIV').Value := Null`) precisam emitir `NULL`, não ser omitidos da lista de colunas — omitir aplicaria o default da tabela em vez de `NULL`.

#### Escopo: `fGravaMovDet` inteira, `fGravaMovGer` nenhuma

Medido no general log (thread 22895, 60 linhas / 3 documentos), o que cada função insere:

| Tabela | Inserts | Frequência | Função |
|---|---|---|---|
| `MOVDET` | 60 | **por linha** | `fGravaMovDet` |
| `MOVTRI` | 60 | **por linha** | `fGravaMovDet` |
| `MOVAUX` | 60 | **por linha** | `fGravaMovDet` |
| `MOVGER` | 2–3 | por documento | `fGravaMovGer` |
| `MOVOBS` | 3 | por documento | `fGravaMovGer` |
| `AUXMOV` | 3 | por documento | `fGravaMovGer` |
| `BRIDET`, `MOVREF`, `MOVINF` | 0 | não disparam nesta configuração | — |

**Restrição de integridade referencial.** `MOVTRI`, `MOVAUX` e `MOVREF` são filhas de `MOVDET` por FK; `MOVOBS` e `MOVINF` são filhas de `MOVGER`. Se `MOVDET` for adiada para o lote e uma filha continuar em `Post` imediato, o insert da filha **falha na FK** — o pai ainda não existe. Portanto:

> **Invariante de M4:** com o lote ativo, **nenhuma escrita dentro de `fGravaMovDet` pode ficar fora dele**. Conversão parcial dessa função é incorreta, não apenas subótima.

Isso inclui `MOVREF`, que não dispara nesta configuração mas dispararia em outra — precisa ser convertida mesmo sem massa que a exercite. E exige auditar as **6 ocorrências de `ExecSQL`** dentro de `fGravaMovDet` ([untMovGer.pas:2646-5476](../../padra_atualizado/fontes/faturamento/untMovGer.pas)): se alguma escreve em filha de `MOVDET`, cai na mesma regra.

**`fGravaMovGer` fica fora de M4.** Insere ~700 linhas contra 14.000 — 2% do volume. Mantê-la em `Post` imediato não é omissão, é garantia: `MOVGER` é o pai, então passa a existir **antes** de qualquer filho batcheado. Converter traria 2% de ganho em troca de risco em `MOVOBS`, `AUXMOV` e `MOVINF`. O parâmetro `ABatch` (D7) é acrescentado apenas a `fGravaMovDet`.

A ordem é preservada mesmo quando o lote se parte em grupos de `BatchSize`, porque os grupos são executados em sequência na mesma transação.

#### Configuração

`BatchSize`: subir de 100 (default) para **500**. `max_allowed_packet` do servidor é 1 GB, portanto tamanho não restringe, e `pInsertLoteLGCEST` já opera com 500 em produção.

**Um único `TBatchSQL` para a rotina inteira**, criado em `fConfirmaAjuste` e não por documento — é o que preserva a ordem `MOVGER` → `MOVDET` → `MOVTRI`.

Flush obrigatório **antes** de qualquer leitura que dependa das linhas gravadas. Com M3 aplicado, `fAjusteQtd*` já lê `MOVDET` depois do laço, o que satisfaz a ordem naturalmente. Ainda assim, a implementação deve mapear explicitamente todo ponto do laço que lê `MOVGER`/`MOVDET` (Q3).

#### Alternativa registrada (plano B)

`CachedUpdates := True` no dataset + `ApplyUpdates` elimina a geração de SQL literal: o UniDAC continua parametrizando, e o risco R10 desaparece. Foi descartada como caminho primário porque **não há garantia de que o SQL Monitor dispare uma vez por `ApplyUpdates` em vez de uma por linha** — e é o gancho do Monitor que produz o `INSERT INTO LOGREP`. Se disparar por linha, o ganho de 12,5% evapora e a mudança de ciclo de vida do dataset sai de graça. Fica disponível caso R10 se mostre incontrolável na validação, condicionada a medir antes o comportamento do Monitor.

#### Ponto a confirmar antes de aplicar

O lote muda a granularidade do `LOGREP` — hoje 1 linha = 1 comando; com lote, 1 linha = até 500 comandos concatenados. Pela regra derivada da §3.1 do handoff, é preciso perguntar quem consome. A evidência é favorável: `pInsertLoteLGCEST` ([:1062-1079](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) já concatena 500 `INSERT` num único `ExecSQL` em produção, portanto o consumidor da replicação já recebe comandos concatenados hoje. Confirmar, não presumir.

#### Resultado medido — aplicado em 2026-08-20

771 comandos contra 1.608 antes do M4, redução de 52% do que restava. Por tabela, em 280
linhas de movimento: `MOVDET` de 280 para 1, `MOVTRI` de 280 para 0 (entra no mesmo lote do
`MOVDET`), `MOVAUX` de 280 para 1.

O consumidor do `LOGREP` aceita comandos concatenados — confirmado com o Willian, e
`pInsertLoteLGCEST` já o faz em produção. Q2 fechada.

O diff coluna a coluna revelou três defeitos que a execução não acusava, os três corrigidos.
Dois são do helper `PostOuAcumula` — campo nulo precisa ser **omitido** do `INSERT`, e não
emitido como `NULL`, para o MySQL aplicar o `DEFAULT` como o `Post` do UniDAC faz; e campo
`blob`/`memo` é a exceção, porque o Delphi mantém `IsNull = True` neles mesmo depois de
receber string vazia.

O terceiro não é do helper e importa além deste requisito: **`TMovDetParams` usado sem
`Init`**. Ao passar o record no lugar dos parâmetros posicionais, os defaults deixam de vir
da declaração da função e passam a vir do record — e record de campo nasce zerado, com string
`''` e Boolean `False`. Perderam-se `strGnrOri = 'P'`, `strEntTri = 'N'`, `strPegou_ = 'N'` e
`blnFilFul = True`, em 8 colunas da `MOVTRI` e 1 da `MOVAUX`. Não há erro de compilação nem
de execução: a rotina roda até o fim e grava valores errados. Qualquer outra chamada do ERP
que migre para `TMovDetParams` corre o mesmo risco.
### M5 — Pré-carga dos SELECT por linha

Duas classes de leitura repetida:

1. `qryIteGer` ([:2309-2322](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) abre um SELECT de 6 colunas (`ITE_PRECUS`, `ITE_PREMED`, `ITE_PREULT`, `ITE_IMPULT`, `ITE_CNV_ML`) uma vez por linha de divergência ([:2378-2381](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)). Carregar uma vez para todos os itens da rodada num `TDictionary<string, record>`.
2. Os lookups por linha internos ao caminho do `MOVDET`, medidos a 1 por linha cada: `SELECT NAT_DESCRI FROM NATCFO`, `SELECT SQL_NO_CACHE ITE_DESFAB, ...`, `SELECT SQL_NO_CACHE EMP_EXIAPP`, `SELECT COUNT(1) AS QTD FROM CADLOT`, e um `SET @EMPFIS = (SELECT PRO_CODEMP FROM ...)`. Estes vivem fora de `untBalancoEstoqueGravar.pas`; cada um exige avaliação individual de escopo de cache e de invalidação. **Não fazem parte do escopo inicial** — entram só se a medição mostrar que sobraram como termo relevante. O texto completo de cada um sai do general log com `SELECT CONVERT(argument USING utf8) FROM DBA_GENERAL_LOG_<janela> WHERE thread_id = <thread> AND argument LIKE '<prefixo>%' LIMIT 1`.

A §9.4 do handoff (consultas a `FATSIM` e `NATCFO` com parâmetro vazio, −3,2%) é caso particular de (2): guardar com um teste antes de executar.

### M6 — Cache do `@VS_ID_TRANSACAO`, armado pela rotina

**Decisão do Willian (D8):** a lógica central **não muda de comportamento**. Em vez de um cache sempre ligado para todo o ERP, o cache é **armado pela própria rotina do balanço** e só é consultado para a mesma instância de conexão, com transação aberta.

Duas globais em `untFuncoesSimples.pas`, ao lado de `objBatchReprocessarSaldo`:

```pascal
VS_objConexaoIDTran: TUniConnection;   // Nil = desarmado
VS_intIDTransacaoCache: UInt64;
```

`fGetIDTransacao` recebe **apenas um `If` no topo**; o corpo atual fica intacto:

```pascal
If Assigned(VS_objConexaoIDTran)        And
   (objConnection = VS_objConexaoIDTran) And
   (VS_intIDTransacaoCache > 0)          And
   fInTransaction(objConnection)         Then
Begin
  Result := VS_intIDTransacaoCache;
  Exit;
End;
```

Mais `pLigaCacheIDTransacao` (lê o ID uma vez e arma, engolindo exceção) e `pDesligaCacheIDTransacao`. `fConfirmaAjuste` arma depois de cada `fStartTransaction` e desarma em todas as saídas, inclusive nos `Except`.

**Por que a guarda tem as três condições.** O projeto cria conexão dinamicamente em 21 pontos com `TUniConnection.Create(Nil)`; um endereço liberado pode ser reaproveitado. Exigindo transação aberta, a entrada usada é necessariamente a que `pLigaCacheIDTransacao` gravou naquela mesma transação. `fInTransaction` só lê a propriedade, sem SQL.

**Por que casa a instância certa.** `fGravaLogRep` recebe a conexão de `frmModulo.GetCurrentConnection(Component.Tag)` ([untModuloReplicacao.pas:235](../../padra_atualizado/fontes/genericos/untModuloReplicacao.pas)). Na thread principal com `Tag = 0`, isso resolve para `Self.Database` — o mesmo objeto que `fGetConexao` devolve e que `fStartTransaction(Nil)` usa. Query em thread com conexão própria devolve outro objeto, a guarda falha e cai no fallback — o que é **correto**, porque é outra transação.

**O que isso troca em relação à alternativa descartada.** Um dicionário `TDictionary<TObject, UInt64>` sempre ligado daria o ganho também nas demais operações do ERP, mas colocaria todo o ERP sob o risco de `LOG_IDTRAN` errado. O ganho de que precisamos está inteiro dentro da janela do balanço. Mesmo padrão do `AUsarBatchSaldos` e do `ABatch: TBatchSQL = Nil` (D7).

### M8 — `TConDet` set-based (D13, sub-item 456948-B)

`fGravaConDetZeraContagemLote` e a montagem do log de nível de item (`TConDet.fInserirRegistro` / `fSQLInsertItens`) passam de um `INSERT` por chamada para `INSERT ... SELECT` dirigido por `BALZER`, uma passada para a rodada inteira. Elimina o termo que a medição de 2026-08-20 apontou como dominante do tempo de parede (~23 dos ~24 minutos da rodada de 2.100 linhas) — maior que a gravação do documento `AJ`, que os mecanismos M1–M6 já reduziram em 70%. `blnUsaTemporaria` sai de `fGravaConDetZeraContagemLote` (B8): o caminho que ele ligava lia de tabela temporária equivalente à leitura direta de `ITEGER`/`CADLOT`, sem ganho que justificasse a complexidade.

### M9 — Correção de leitura em `TConDet.pSetValoresAntigos` (D12)

Com `FNumLot` preenchido, a leitura de valores antigos passa a ler `CADLOT` (`LOT_SALDOS`/`LOT_QTEF_*`), não mais `ITEGER`. Sem isso o log de contagem por lote gravava o saldo do item inteiro em vez do saldo do lote. Correção de dados, portada da cópia `.150`, não desempenho — mesma classe de achado do M3 (§2.5).

### M10 — Cache de `fGetPesoEspecificoItemGranel` (D13, sub-item 456948-B)

Cache em dicionário chaveado por `strCodIteGranel|strCodCor`, armado por `pLigaCachePesoEspGranel` / desarmado por `pDesligaCachePesoEspGranel` (`untFuncoesGenerica.pas`). Mesmo padrão do M6 (D8): `Nil` por default, a função lê do banco normalmente fora da janela do balanço; só a gravação do balanço arma o cache. `GEIMAT`/`DEIMAT` e a estrutura de fórmula não mudam no meio de uma rodada, o que sustenta a validade do cache. Não confundir com D4: a lógica de `fGetPesoEspecificoItemGranel` continua em Delphi, sem re-derivação para SQL — só o resultado é memoizado.

### M11 — `TBatchSQL.OwnsQuery`

Propriedade nova em `TBatchSQL` (`untTBatchSQL.pas`), default `False`: com `True`, o destructor libera o `Query` interno. Necessária para o `TBatchSQL` criado internamente pelo M8 sem dono externo, sem alterar os chamadores existentes que já são donos do próprio `Query` (`untCadConcilBancNova.pas`, `untFuncAutban.pas`).

---

## 6. Riscos

| # | Risco | Como é resolvido |
|---|---|---|
| R1 | M1 adia o saldo para o commit; código que lê `ITE_SALDOS` dentro do laço passa a ver valor pré-ajuste. O leitor crítico é `objAuditoriaSaldo.fValidouTodas`, que dispara `fRollBack` se não bater | **Resolvido por desenho**, não por auditoria: `fConfirmaAjuste` chama `objBatchReprocessarSaldo.Execute(...)` explicitamente antes da auditoria, dentro da mesma transação (§5, M1). Cobre também `fLoteComLocalizacaoCritica` e `ReprocessarItem`. Não é bloqueante |
| R2 | M4 muda a granularidade do `LOGREP` (1 linha = até 100 comandos) | Confirmar o comportamento do consumidor da replicação. Precedente favorável: `pInsertLoteLGCEST` já concatena 500 em produção |
| R3 | M4 exige que nada leia `MOVGER`/`MOVDET` antes do flush | Mapear explicitamente todos os pontos de leitura no laço. M3 já move os principais para depois |
| R4 | M6 erra o `LOG_IDTRAN` e a replicação agrupa errado **em silêncio**, sem gerar erro | **Reduzido por desenho** (D8): o cache só é consultado enquanto a rotina do balanço o armou, na conexão que ela armou, com transação aberta. Fora disso o caminho é o de hoje, byte a byte. Continua valendo conferir o agrupamento do `LOGREP` depois da rodada |
| R5 | M2 sem `Clear` faz a segunda gravação na mesma sessão pular o zeramento | `Clear` no início de cada gravação; caso de teste dedicado: gravar duas vezes sem fechar a tela |
| R6 | M3 muda o resultado de `ITE_QTDAJU`/`ITE_SEQAJU` no item que atravessa fronteira de documento | Comportamento novo é o **pretendido** (D3). Documentado, e a massa multi-lote precisa exercitar o caso |
| R7 | A massa atual não exercita M2 nem M3 | `03_massa_multilote.sql` é pré-requisito da validação (§7) |
| R8 | Edição direta dos `.pas` corrompe acentuação | `untBalancoEstoqueGravar.pas` é **latin-1** com CRLF; `untFuncoesSimples.pas` é **UTF-8 com BOM**. Editar sempre por script Python byte-safe; conferir `U+FFFD == 0`, bytes acentuados iguais à base, CRLF, e `Try` = `Except` + `Finally` |
| R9 | M4 altera `fGravaMovDet`, de `untMovGer.pas`, que serve todo o ERP | Adesão por `ABatch: TBatchSQL = Nil` (D7). Com `Nil` como default, nenhum outro fluxo muda |
| R10 | `pPostOuAcumula` passa a gerar SQL literal onde hoje o UniDAC parametriza — decimal, data, aspas, `NULL`, charset latin-1 — nas 101 colunas do `MOVDET`, várias fiscais. Erro de formatação é **silencioso** | O risco é mecânico, não semântico: nenhuma regra de negócio é reinterpretada. O controle é o diff coluna a coluna de §7.3, que já estava previsto. Usar `fDoubleToSQL` e `QuotedStr`; campos anulados explicitamente têm que emitir `NULL`, não ser omitidos |
| R11 | Conversão parcial de `fGravaMovDet` quebra FK: filha em `Post` imediato não encontra o `MOVDET` adiado | Invariante de M4 (§5): com lote ativo, nenhuma escrita da função fica fora dele. Auditar os 6 `ExecSQL` internos e converter `MOVREF` mesmo sem massa que a exercite |

---

## 7. Massa de teste e equivalência

### 7.1 Massa existente — mantida

Em `IA/456948/testes/`:

| Arquivo | Papel |
|---|---|
| `00_backup_original.sql` | Ponto de restauração da empresa `001` inteira. **Roda uma vez só** — para com erro se as tabelas já existirem |
| `01_massa_60_itens.sql` | 60 itens, 1 lote contado cada, 60 linhas, 3 documentos com `CFG_ITEDOC = 20`. Re-executável. Cria `BALSEL456948` |
| `02_restaura_massa.sql` | Devolve saldo e contagem ao ponto de restauração e derruba `BALSEL456948` |

`BALSEL456948` é o que torna a asserção possível: após a gravação, o valor esperado de `ITE_SALDOS` é `BALSEL.SALDO + BALSEL.DELTA`. Comparar com `ITE_SALCON` dá falso negativo, porque a rotina zera a contagem no fim.

### 7.2 Massa nova — `03_massa_multilote.sql`

Pré-requisito de M2, M3 e R6. Requisitos:

- Itens com **5 a 8 lotes contados cada**, no padrão real da base (todo item tem 8 ou 9 lotes).
- Volume tal que, com `CFG_ITEDOC = 20`, pelo menos 3 itens tenham suas linhas **divididas entre dois documentos**.
- Mesma estrutura de elegibilidade de lote do `01`, para que a divergência seja exatamente `LOT_SALDOS − LOT_SALCON`: `LOT_SALDOS >= 30`; `LOT_NUMLOT NOT IN ('', 'A DEFINIR', 'GARANTIA')`; `LOT_SALEXT`, `LOT_SAL_ML`, `LOT_SALREG`, `LOT_QTEF_A`, `LOT_QTEF_P`, `LOT_QTEF_F`, `LOT_QTPDBF` = 0.
- Tabela auxiliar equivalente à `BALSEL456948`, com granularidade **item + lote**, para permitir asserção nos dois níveis.
- Divergências positivas e negativas em proporção equilibrada.
- Re-executável, sem backup interno.

Restrições de ambiente: MySQL 5.7 — sem CTE, sem window functions. Numeração de linhas com `(@r := @r + 1)` e `(SELECT @r := 0) ini`, com **`ORDER BY` + `LIMIT` numa derivada interna** (sem o `LIMIT` interno o MySQL pode ignorar o `ORDER BY` da derivada). `ANSI_QUOTES` ativo em algumas sessões — usar aspas simples. `CADLOT.AUTOINCREM` é `varchar(20)`; coluna auxiliar tem que acompanhar o tipo, senão o join perde índice.

### 7.3 Prova de equivalência

Único critério aceitável para "preserva comportamento":

1. Rodar `03_massa_multilote.sql`; gravar na **versão base**.
2. Capturar o estado final em tabelas `BALSNAP_<tabela>_BASE`: `ITEGER`, `CADLOT`, `LOTLOC`, `MOVGER`, `MOVDET`, `MOVTRI`, `LGCEST`, `CONDET`, `LOCCON`, restritas aos itens da massa.
3. Restaurar (`02` + `03`).
4. Gravar na **versão nova**; capturar em `BALSNAP_<tabela>_NOVA`.
5. Diff coluna a coluna. Divergência esperada: **apenas** `ITE_QTDAJU`/`ITE_SEQAJU` nos itens que atravessam fronteira de documento (D3/R6), e colunas de data/hora/autoincremento.

Toda escrita no banco é entregue como **script pronto para o Willian executar**, sem marcador por preencher e com checklist.

---

## 8. Medição

### 8.1 A métrica

O general log desta instância registra o corpo do trigger. Portanto:

```sql
SELECT COUNT(*)                                          AS STATEMENTS,
       SUM(argument LIKE 'CALL pSetaVariaveisPreAlt%')   AS TOQUES_ITEGER,
       SUM(argument LIKE 'INSERT INTO LOGREP%')          AS COMANDOS_APP,
       TIMESTAMPDIFF(SECOND, MIN(event_time), MAX(event_time)) AS SEGUNDOS
  FROM DBA_GENERAL_LOG_<AAAAMMDD_HHMMSS>
 WHERE thread_id = <thread da gravação>;
```

`TOQUES_ITEGER` é **exatamente** o número de linhas de `ITEGER` tocadas. É a variável que domina o custo e é medível direto, sem inferência.

As tabelas `DBA_GENERAL_LOG_AAAAMMDD_HHMMSS` cobrem janelas de 5 minutos, com o SQL completo na coluna `argument`. A retenção é curta — capturar os números logo após cada rodada.

### 8.2 Ordem de implementação

Cada passo é medido isoladamente contra a mesma massa. Medir só no fim não diz de onde veio o ganho, e não existe baseline pós-alteração anterior.

| Ordem | Passo | Razão da posição |
|---|---|---|
| 0 | Baseline na versão base com `03_massa_multilote.sql` | Sem isso nada é comparável |
| 1 | M6 — cache do `@VS_ID_TRANSACAO` | Já validado; o risco (R4) está **fora** do balanço. Testar em venda e devolução antes de seguir |
| 2 | M3 — `fMarcaAju*`/`fAjusteQtd*` fora do laço | Maior ganho isolado; elimina o quadrático; e estabelece a ordem de leitura de que M4 depende |
| 3 | M2 — dedup de `pZeraItem` | Só rende com massa multi-lote |
| 4 | M5 (item 1) — pré-carga do `qryIteGer` | Round-trip puro, risco baixo |
| 5 | M4 — `TBatchSQL` no `MOVGER`/`MOVDET` | Depende da ordem de leitura estabelecida por M3 e da confirmação de R2 |
| 6 | M1 — batch de saldos | Maior ganho unitário. Depende do flush antecipado de §5/M1 estar implementado; sem ele o balanço quebra em cliente com `CFG_UTAUFA = 'S'` |

### 8.3 Referência

Baseline medida em 2026-08-19, thread 22895, 60 itens de 1 lote (massa `01`):

| Métrica | Valor | Por item |
|---|---|---|
| Statements na thread | 4.586 | 76,4 |
| Toques em `ITEGER` | 320 | 5,33 |
| Comandos da aplicação | 572 | 9,5 |

O piso teórico de toques em `ITEGER` é **1 por item**. Toda medição intermediária deve ser lida contra esse piso.

### 8.4 Referência final — pós-merge com trunk, com M8–M11 (2026-08-20/25)

Massa funcional, 280 linhas (40 itens × 7 lotes), `CFG_ITEDOC = 20`:

| Etapa | Comandos no `LOGREP` | vs BASE |
|---|---|---|
| BASE mesclada com o trunk | 2.064 | — |
| +M6 +M3 | 2.010 | −3% |
| +M4 +M5 +Q8 | 1.172 | −43% |
| +M1b | 614 | −70% |

Massa de volume, 2.100 linhas (300 itens × 7 lotes), `CFG_ITEDOC = 500`: **4.373 comandos**, 2,08 por linha, mesma proporção da massa pequena — os mecanismos M1–M6 escalam.

O achado que motivou M8/M9/M10 (D12/D13): nessa mesma rodada de 2.100 linhas, o tempo de parede foi de 24 minutos — praticamente a queixa original — mesmo com 70% menos comandos na gravação do documento. O gargalo estava em `INSERT INTO CONDET` linha a linha (4.485 linhas na rodada, 491 transações próprias via `fRetAutoIncrem`, 22 statements por transação para 2 inserts úteis). M8 ataca esse termo.

Conferência funcional em ambas as massas: 100%. Diff coluna a coluna sem divergência em `MOVDET`, `MOVTRI`, `MOVAUX`, `LGCEST`; restam apenas `ITE_QTDAJU`/`LOT_QTDAJU`, as correções conhecidas do M3.

---

## 9. Fora de escopo

- Alterar o trigger `pSetaVariaveisPreAlt`, o `INSERT INTO LOGREP` ou desligar `VS_blnGravaLogTransacao` (restrição §3.2 do handoff).
- Re-derivar a lógica de `fGravaMovGer`/`fGravaMovDet`; mapear os 10 ramos de configuração ativos; traduzir `fGetPesoEspecificoItemGranel` para SQL (D4).
- Tabela de staging `BALPLA` e gerador de plano set-based da §9.5 do handoff (§4.4).
- Reduzir `CFG_ITEDOC` como alavanca — é questão de tamanho de documento fiscal e exigiria aval fiscal.
- Fatiamento transacional, commit por documento ou por bloco. A transação do `AJ` permanece atômica (§4.3).
- `fConfirmaAjuste('ML')` e o caminho "sem divergência" ([:2704-2735](../../padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas)) — inalterados.
- Refatoração não relacionada ao objetivo. Zona legado: manter Hungarian style, prefixos `unt`/`p`/`f`/`F`/`A`, SQL embutido com `ParamByName`.

---

## 10. Questões abertas

> **Q1 foi resolvida e removida** — a auditoria de saldo chama a função de banco `F_AUDITORIA_GRAVACAO_SALDO`, e a dependência foi eliminada por desenho com o flush antecipado do lote (§5, M1). A numeração das demais foi mantida para não invalidar as referências no texto.

| # | Questão | Impacto |
|---|---|---|
| Q2 | ~~O consumidor do `LOGREP` aceita comandos concatenados?~~ | **RESPONDIDA: sim** (D11). M4 destravado |
| Q3 | Quais pontos do laço de `fConfirmaAjuste` leem `MOVGER`/`MOVDET`? | Define os pontos de flush obrigatório de M4 (R3) |
| Q4 | `LGCEST`: a reexecução reinsere do zero? | Define se o log de contagem é idempotente e valida §4.4 |
| Q5 | Os lookups por linha do caminho do `MOVDET` (M5 item 2) sobram como termo relevante depois de M1–M4? | Decide se M5 item 2 entra em escopo |
| Q6 | Algum campo escrito por `Post` em `fGravaMovDet` tem default ou trigger cujo valor o código lê **depois** do `Post`? | Se sim, o `Cancel` de `pPostOuAcumula` quebra essa leitura e M4 precisa de tratamento específico nesse campo |
| Q8 | Com `CFG_UTINEM = 'S'` o batch de saldos fica desligado e o M1 não rende nada. Ignorar a notificação de saldo mínimo no balanço, ou **adiá-la** para depois do flush? | Vale **−480 comandos** e ~1.680 statements de trigger nesta massa; em produção, ~24.000 comandos. Adiar preserva comportamento e não toca em `untCadIte.pas`, mas exige mexer em global `VS_*` com `Try/Finally`. Ignorar é mais simples e auditável, mas é mudança de regra de negócio. **Adiado por decisão do Willian, 2026-08-19** |
| Q7 | O `UPDATE PROINC SET PRO_AUTINC = @AUTINC + 1`, medido a 1 por linha no caminho do `MOVDET`, pode ir para o lote? | Se algo lê `@AUTINC` depois, o valor fica defasado. No balanço o bloco já é reservado antes por `fRetAutoIncrem('MOVDET', VS_strCodEmp, qryGen.RecordCount)`, o que ajuda — confirmar dentro da função |

---

## 11. Restrições do projeto aplicáveis

Travas do pre-commit SVN que aparecem nesta rotina: `StrToFloat`/`StrToFloatDef` → `fStrToFloat`/`fStrToFloatDef`; `Now()` → `fNow()`; `.SetFocus` → `pSetFocus`; `TBitBtn`/`TButton` → `TBitBtnLocked`; `Application.CreateForm` → `pCriarForm`/`pCriarFormularios`.

Commit: primeira linha `Req. 456948`, token do DelphAI obrigatório na mensagem.

Compilação: apenas pelo Willian, projeto `autcom.dproj`. `libOpeRefProd.dproj` **não** carrega `untBalancoEstoqueGravar.pas`.
