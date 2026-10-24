# Plano de Execução — Req. 456948

**Referência:** `spec.md`
**Zona:** Legado
**Origem do trabalho:** `379.48.2.30.74.150.45.63`, pastas `IA/456948/` (parte A) e `IA/456948-B/` (parte B)
**Destino:** `379.48.2.30.74.150_c` (trunk `379.48.2.30.74.150`, rev 491228)

## 1. Abordagem técnica

Porte **medida por medida**, não por aplicação de patch.

Os ramos divergiram o bastante para invalidar qualquer apply automático: `untFuncoesSimples.pas` tem 95.409 linhas na `.63` contra 61.629 no `_c`; `untFuncoesGenerica.pas` tem 14.361 contra 49.799. O patch `balanco150.patch` (6,3 MB, gerado contra a rev 490895) carrega essa divergência, inclui arquivos alheios ao requisito e apagaria o bloco de número de série que só existe no `_c`. Ele serve como **inventário do que foi tocado**, não como fonte de conteúdo.

Para cada medida, o procedimento é o mesmo:

1. Ler a intenção em `ferramentas/ed-*.json` e no `diffs/vs-baseline/<unit>.pas.diff` da `.63`, mais o registro da tarefa em `tasks.md` / `plans.md` de lá.
2. **Localizar o alvo no fonte do `_c`** pelo nome do símbolo, nunca por número de linha, offset ou contexto da `.63`.
3. Conferir se o `_c` já tem algo equivalente ou algo que conflita com a medida — em especial trechos que a `.63` não tinha.
4. Editar por ferramenta byte-safe, preservando encoding e terminador de linha do arquivo do `_c`.
5. Gerar o diff isolado da medida e conferir contagem de acentos e balanceamento de `try`/`finally`.

O código do `_c` continua no estilo Legado: Hungarian nas variáveis, prefixos `p`/`f` nos métodos, prefixo `F` nos campos, SQL embutido com `ParamByName()`, sem interfaces novas, sem refatoração além do necessário para a medida.

### Estratégia contra o risco principal

A `.63` adotou o `untBalancoEstoqueGravar.pas` **por inteiro** do trunk numa das etapas (tarefa 4b da parte A). Aqui esse atalho não existe: o `_c` tem 19 métodos que a `.63` não tem, e sete métodos da `.63` são novos. Por isso a preservação do que é exclusivo do `_c` é passo de auditoria explícito (§3, passo 12), não confiança.

## 2. Arquivos impactados

Todos em `padra_atualizado/fontes/`, ação **alterar**. Nenhum arquivo novo de fonte.

| Unit | Caminho | Medidas |
|---|---|---|
| `untBalancoEstoqueGravar.pas` | `util/operacoesrefitens/` | M3, M5, M1b, B1, B2, B3, B4, B5, B8, B9, B10b, B11, B14, B15, B16 |
| `untFuncoesSimples.pas` | `genericos/` | M6, M1b, B6 |
| `untTBatchSQL.Helper.pas` | `genericos/BatchSQL/` | M9 |
| `untTBatchSQL.pas` | `genericos/BatchSQL/` | M11 |
| `untMovGer.pas` | `faturamento/` | M4, B10a, B10b |
| `untConDet.pas` | `cadastros/` | M8, M9, B2, B3 |
| `untCadLote.pas` | `cadastros/` | B3, B4 |
| `untICadLote.pas` | `cadastros/` | B3, B4 |
| `untCadIte.pas` | `cadastros/` | B14, M1b |
| `untConstantes.pas` | `genericos/` | B16 |
| `untTypesSistema.pas` | `genericos/` | M4 |
| `untFuncoesGenerica.pas` | `genericos/` | M10 |

Banco (script, não fonte):

| Objeto | Origem |
|---|---|
| tabela `BALZER` | `IA/456948-B/banco/01_cria_BALZER.sql` da `.63` |
| `idx_balzer_dtacad` | `IA/456948-B/banco/03_indice_balzer_dtacad.sql` |
| `idx_iteger_digcon (ITE_CODEMP, ITE_DIGCON)` | `IA/456948-B/banco/02_indices_digcon.sql` |
| `idx_cadlot_digcon (LOT_CODEMP, LOT_DIGCON)` | `IA/456948-B/banco/02_indices_digcon.sql` |

**Fora do diff final, sem exceção:** `untDBUtils.pas`, `libFiscalCat42.dproj.local`, `libGNRE.dproj.local`, `MonitorContabil.dproj.local`, `opcoes.ini`, `rev.inc`.

## 3. Sequência de implementação

### Etapa 0 — Preparação

**Sem medição.** Por decisão do Willian (2026-08-27), a análise e a medição da `.63` são fonte de verdade e não são refeitas. Esta etapa não tem baseline, massa nem general log.

1. **Recortar o inventário do patch.** Confirmar que as 12 units da tabela de §2 cobrem tudo que o requisito precisa e que os cinco arquivos descartados não têm nenhuma medida dentro. Registrar a conferência.
2. **Trazer só a ferramenta de edição** — `edita_pas.py` da `.63`, para edição byte-safe. As ferramentas de medição e as massas não vêm.
3. **Ler as flags de configuração da base do `_c`** — `CFG_ITEDOC`, `CFG_FDGINC`, `CFG_UCCBEA`, `CFG_USATMQ`. Não é medição: é o que decide qual ramo de código cada medida vai atingir, e algumas decisões da `.63` (B11, B5) dependem desses valores.
4. **Conferir encoding** das 12 units no `_c`: BOM e terminador de linha, um por um.

### Etapa 1 — Medida de escopo global, isolada

5. **M6 — cache do `@VS_ID_TRANSACAO`** (`untFuncoesSimples.pas`). É a única medida que afeta o ERP inteiro e não tem relação com o balanço. Vai sozinha, e é validada fora do balanço antes de qualquer outra edição.

### Etapa 2 — Medidas sem dependência de DDL

Ordem escolhida para que cada medida seja conferível sozinha; B1 e B15 primeiro porque são as mais contidas.

6. **B1 — `TItemZeraList` O(1)**: `TDictionary<String, Integer>` para lookup, array de capacidade dobrada para a ordem, `FQtd` como tamanho lógico, `GetItems` devolvendo cópia. Interface pública inalterada — nenhum dos chamadores muda.
7. **B15 — `DisableControls` em `fVerificaSeTemDiferencasParaGravar`**, com `try..finally` e `FieldByName` fora do laço (RN11).
8. **B10a — guardas de chave vazia** em `MOVTRI.DET_EMPORI` e `FATSIM.SIM_SEQFDO` (`untMovGer.pas`, RN12).
9. **B11 — `PROINC` da `LGCEST` uma vez por rodada** (RN14). Confirmar antes qual caminho de autoincremento a base do `_c` usa.
10. **B14 — `pAtivaItem` uma vez por item** (RN06).
11. **B5 — residual do laço de divergências**: progresso e `ProcessMessages` a cada 50; curto-circuito em `fLoteComLocalizacaoCritica`; `fCalcTotais` sem o `First` e sem `strCodItens`; remoção das quatro funções `fMarcaAju*` / `fAjusteQtd*` mortas. **Atenção:** no `_c` essas quatro funções existem e é preciso provar que ficaram mortas *depois* de M3, não antes.
12. **M3 — `fMarcaAju*` / `fAjusteQtd*` fora do laço**. Elimina o trabalho quadrático de `fMarcaAjuCadLot` e estabelece a ordem de leitura de que M4 depende. Faz par com o passo anterior.
13. **M5 — pré-carga do `qryIteGer`** (`pCarregaCustoItens`), eliminando um round-trip por linha de divergência.
14. **M9 — `pPostOuAcumula`** (`untTBatchSQL.Helper.pas`) e **M11** (`untTBatchSQL.pas`), com o tratamento de `NULL` e de campo `BLOB`.
15. **M4 — `ABatch` em `fGravaMovDet`** (`untMovGer.pas`, `untTypesSistema.pas`, balanço). Aplicar a RN07: classificar cada `Post` antes de acumular; nenhuma escrita em filha de `MOVDET` pode escapar do lote.
16. **B10b — molde de dataset reaproveitado** (RN13), com o ciclo de vida amarrado ao do lote de `MOVDET`, fechando também no `Except`.
17. **M8 — `CONDET` em lote** (`untConDet.pas`) — era o termo dominante do tempo de parede.
18. **M9 (correção de dados) — `pSetValoresAntigos` lê `CADLOT` com lote** (`untConDet.pas`).
19. **M10 — cache de `fGetPesoEspecificoItemGranel`** (`untFuncoesGenerica.pas`, RN15). Unit com a maior divergência entre os ramos — localizar a função no `_c` e reavaliar se o cache ainda cabe onde cabia.
20. **M1b — batch de saldos por `TBatchSQL`** (`untFuncoesSimples.pas`, `untCadIte.pas`, `untCadLote.pas`, balanço), com flush explícito antes da auditoria de saldo aplicado, descarga parcial e notificação de saldo mínimo adiada (`pNotificaSaldoAbaixMinimo`).
21. **B6 — bloco de sequencial por rodada** (`fRetSequencial`, RN01). Segunda medida de escopo global; vai depois das do balanço para poder ser isolada no teste.

### Etapa 3 — DDL e medidas dependentes

22. **Criar `BALZER` e os três índices** na base de teste do `_c`. Conferir o `EXPLAIN`: `eq_ref` + `Using index` nos joins de `BALZER`; `ref = const,const` com `filtered = 100%` em `ITEGER` e `CADLOT` pelos índices de `DIGCON`; `type = range` + `Using index` no `idx_balzer_dtacad`.
23. **B9 — verificação de integridade da rodada** (`pCarregaFotoBALZER`, `fVerificaIntegridadeRodada`, flag `blnFalhouGravacao` em todos os pontos de saída por falha e no fecho do laço de documentos). Entra **antes** das medidas set-based: é a rede que prova que elas não mudaram o resultado.
24. **B4 — suprimir o toque redundante em `ITEGER`** (RN02), conferindo campo a campo no `_c`.
25. **B2 — Fase 0 de `fZeraItens` set-based** (`fGravaConDetZeraItensRodada`): um `COUNT` mais um `INSERT ... SELECT` por rodada, com o filtro de variação virando `WHERE`. Ordem antes da Fase 1 preservada (RN03).
26. **B3 — Fase 2 de `fZeraItens` set-based** (`pCarregaBALZERZeramento` em blocos de 500, `fGravaConDetZeraLotesRodada`, `fZeraContagemLoteRodada`). Ordem 2a antes de 2b preservada; nada escreve `LOT_QTDAJU` / `LOT_SEQAJU` / `LOT_DTAAJU` (RN04). O gate de zeramento é predicado do `UPDATE` (RN09).
27. **B8 — eliminar as temporárias de contagem**: `pCriaTemporariasEmContagem`, `pRemoveTemporaria`, `blnTableTmp`, `blnUsaTemporaria` e as duas constantes saem; o bloco de proteção que existia só para chamar a segunda é desmontado com reindentação do miolo. Conferir zero referência restante no `_c`.
28. **B16 — retenção da `BALZER`**: `INT_DIAS_RETENCAO_BALZER = 7` em `untConstantes.pas` e o terceiro `DELETE` em `pCarregaFotoBALZER` por `ZER_DTACAD < :DTALIM` (RN05).

### Etapa 4 — Fixes do review da .63

29. **Reaplicar os oito fixes** da Fase 4d da parte B (`ed-rev*`, `ed-rev2-*`), verificando um por um se a condição que os motivou existe no `_c`:
    - Achado 4 — `pDesligaBatchSaldos` no `Finally`, cobrindo os dois `Exit` antecipados de `fGravar` (RN08).
    - Achado 1 — `fDeveZerarItem`: **existe no `_c`**; remover e mover o gate para o `UPDATE`, com o critério na direção correta (RN09).
    - Achado 2 — leituras de `DET_TIP_FC` depois do `Cancel` (RN10).
    - Achados de `LOTLOC`, guarda, notificação, rollback, `EMPFISICA`, `CONDET` nil, `fNextAutoIncrem`, filtro da `BALZER`, `CONDET`/`EMPBAL`, `CONDET`/lote.
    - **Não portar:** o achado que estava errado, o que exige mudança de regra de negócio (decidido: manter) e o que depende de quem compila para Linux.

### Etapa 5 — Fechamento

30. **Auditoria de preservação**: provar que os 19 métodos exclusivos do `_c` continuam presentes e íntegros, com o bloco de número de série completo. Comparar o conjunto de métodos de `TfrmBalancoEstoqueGravar` antes e depois do porte — só os sete novos podem aparecer, nenhum pode desaparecer sem justificativa registrada.
31. **Conferência funcional** — uma gravação de balanço no `_c`, com o resultado conferido na tela. Sem medição comparativa: o ganho é o já aceito na `.63`.
32. **Diff final limpo**: só as 12 units de §2. Asserção mecânica da RN04 sobre esse diff.

## 4. Conformidade com padrões do projeto

- **Zona Legado.** Hungarian nas variáveis (`str`, `bln`, `int`, `flt`, `qry`, `slt`, `obj`), `F` em campo privado, `A` em parâmetro, `p` em procedure, `f` em function. Prefixo `unt` nas units. Nenhuma interface nova, nenhuma dot-notation introduzida.
- **Sem refatoração proativa** — só o que a medida exige.
- **Chamadas do projeto:** `fNow()` (nunca `Now`/`NOW()`), `fStrToFloat()` / `fStrToFloatDef()`, `fMensagem()`, `pSetFocus()`, `pCriarForm()` / `pCriarFormularios()`, `fRetAutoIncrem()`, `fCriaQuery(nil)`, `fStartTransactionGen` / `fCommitGen` / `fRollBackGen`.
- **Exceção estabelecida:** TTL de cache em memória pode usar `System.SysUtils.Now` qualificado. Aplica-se aos caches de M6 e M10. **Não se aplica** ao corte de retenção da `BALZER`, que é `DELETE` e usa `Int(fNow)` (RN05).
- **SQL:** sempre `ParamByName()`. Nenhum `FOREIGN_KEY_CHECKS` nos scripts de DDL.
- **Componentes:** nenhuma alteração de `.dfm` prevista; se houver, `TBitBtnLocked`, `TEditFocus`, `TcxGridCitel`, sem `FillType = ftBrush` e sem `Outline =`.
- **`try/finally`** em todo objeto alocado manualmente — vale para os datasets de molde de B10b e para as listas de B1 e B14.
- **Pre-commit SVN:** nada de `StrToFloat`, `Now()`, `.SetFocus`, `TBitBtn`, `TButton`, `Application.CreateForm`, `TDBGrid`, `TClientDataSet`, `TDataSetProvider`, `dxSkin*`, `frxSmartMemo`.

## 5. Estratégia de testes

Zona Legado: **não há infraestrutura de teste automatizado** nas units tocadas.

**Não há campanha de medição.** Decisão do Willian (2026-08-27): a análise dos dados e a medição de desempenho foram feitas e aceitas na `.63` e não são refeitas. Nada de baseline, massa de 40 ou 2.000 itens, general log, `TOQUES_ITEGER`, snapshot, diff de colunas ou rodada sabotada.

O que fica é o que **não** pode vir da `.63`, porque o código de destino é outro: compilação, equivalência funcional no `_c` e preservação do que só existe no `_c`. Os casos são escritos por analista; a entrega de quem implementa é o contrato e a lista de casos — os critérios de aceitação de `spec.md` §6.

**Casos a cobrir:**

1. Compilação de `autcom.dproj` sem erro nem novo warning nas 12 units.
2. Uma gravação de balanço no `_c`, conferida na tela: documentos gerados, saldos e ajustes de lote conforme esperado.
3. Balanço com número de série em uso — cobre a preservação do bloco exclusivo do `_c`. **Este é o caso mais importante do porte.**
4. Balanço com multi-localização, se a base permitir ligar — cobre a RN09, que nenhum teste do cliente atual exercita.
5. Fora do balanço: uma venda, uma devolução e uma compra — cobre `fRetSequencial` com bloco, `fGravaMovDet` com lote e molde, e o cache do `@VS_ID_TRANSACAO`. As quatro medidas de escopo global só se validam aqui.
6. Grid responsivo depois de uma gravação e depois de uma saída por `Exit`.
7. Uma gravação que falhe na verificação do B9 — confirmar que o rollback deixa zero documento, saldo intocado e contagem preservada. Se sabotar a base não estiver na mesa, ao menos conferir por leitura de código que os pontos de saída passam pelo rollback.

**Conferência por diff, no lugar da medição:** cada medida gera diff isolado, conferido contra a intenção registrada na `.63` (`ferramentas/ed-*.json`, `diffs/vs-baseline/*.diff`), com contagem de acentos e balanceamento de `try`/`finally`. É esta conferência que substitui o cronômetro.

## 6. Riscos e mitigação

| Risco | Mitigação |
|---|---|
| Apply automático do patch corromper o `_c` — apaga o bloco de número de série, arrasta divergência de ramo e cinco arquivos alheios | O patch não é aplicado. Serve só como inventário. Porte símbolo por símbolo |
| Alvo de M6 e M10 mudou no trunk (`untFuncoesSimples.pas` e `untFuncoesGenerica.pas` são as units mais divergentes) | Localizar e ler a função no `_c` antes de editar; nenhuma edição por offset ou contexto da `.63` |
| Perder funcionalidade exclusiva do `_c` | Etapa 5 passo 30 é auditoria mecânica do conjunto de métodos, antes e depois |
| M6, B6, M4/B10b e o batch de saldos afetam o ERP inteiro | M6 vai isolada na Etapa 1 e é validada fora do balanço; B6 vai por último na Etapa 2; caso 7 dos testes cobre os três |
| `VS_objBatchSaldos` é global e ficar armado após um `Exit` contamina todo `UPDATE` de saldo do ERP | RN08: `pDesligaBatchSaldos` idempotente no `Finally`, cobrindo os dois `Exit` e o `Except` |
| `BALZER` ou os índices ausentes na réplica fazem o `UPDATE ... JOIN` replicado falhar | Passo 22 e checagem explícita na réplica antes de liberar B2/B3; DDL entra no pacote de atualização do cliente |
| Corrupção de encoding no `.pas` bloqueia o commit ou perde acento | Passo 4 confere BOM e terminador por arquivo; edição byte-safe; contagem de acentos e balanceamento de `try`/`finally` conferidos por medida |
| Flags de configuração diferentes entre as bases levarem a medida a caminho de código que não executa | Passo 3 registra `CFG_ITEDOC`, `CFG_FDGINC`, `CFG_UCCBEA`, `CFG_USATMQ` antes de qualquer edição |
| Sem medição no `_c`, o ganho não é comprovado nesta versão | **Risco aceito** (Willian, 2026-08-27). A medição da `.63` vale como evidência. Em troca, a conferência por diff isolado de cada medida passa a ser obrigatória, não opcional |
| Sem diff de colunas, uma medida portada torto pode mudar o resultado gravado sem ninguém notar | O caso 2 e o caso 3 dos testes são a única rede — a gravação tem de ser conferida na tela, não só concluída sem erro |
| Rodada abortada queima o bloco de sequencial reservado (B6) | Risco aceito e decidido: buraco na numeração não é problema fiscal; repetição seria |
| Remover `fMarcaAju*` / `fAjusteQtd*` antes de M3 quebraria o fluxo | Passo 11 exige provar que ficaram mortas depois de M3, não antes |
