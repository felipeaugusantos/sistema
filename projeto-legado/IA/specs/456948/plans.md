# Req. 456948 — Plano de Implementação

> **Para quem executa:** este plano é feito para ser executado tarefa a tarefa, com validação entre elas. Os passos usam checkbox (`- [ ]`). Leia `specs.md` na mesma pasta antes de começar — este documento assume que as decisões D1 a D7 já estão entendidas.

**Objetivo:** reduzir o tempo da gravação do Balanço de Estoque por Ajuste, hoje ~20 minutos para ~2.000 itens, atacando os três termos de custo medidos, sem alterar o resultado nem abrir fronteira de commit dentro do efeito.

**Arquitetura:** o custo se decompõe em três termos independentes — linhas tocadas em `ITEGER` (49%), round-trips e `INSERT INTO LOGREP` (12,5%), e SELECT de lookup por linha (13%). Cada um recebe um mecanismo próprio: tocar cada linha uma vez (agregar, deduplicar, tirar do laço de documentos), `TBatchSQL` no caminho do `MOVDET`, e pré-carga em dicionário. A transação do `AJ` permanece única e atômica.

**Stack:** Delphi Seattle (Object Pascal, VCL), UniDAC, MySQL 5.7.44, SVN.

---

## Adaptações deste plano ao ambiente

Três coisas que o formato padrão de plano assume e que **não existem aqui**. Ignorar isto leva a passos impossíveis de executar.

| Assunção padrão | Realidade deste projeto | O que fazer no lugar |
|---|---|---|
| `git commit` a cada tarefa | SVN. Commit exige `Req. 456948` na primeira linha e token do DelphAI. **Só o Willian commita** | Ao fim de cada tarefa, gerar `svn diff` para `IA/456948/diffs/NN-<passo>.diff`. É o ponto de retorno |
| Framework de teste unitário | Não há teste automatizado para esta zona do código | O ciclo de teste é: restaurar massa → Willian compila → Willian grava pela tela → conferir por SQL e pelo general log |
| O agente compila e roda | **Só o Willian compila.** Linha de comando falha com `E2202: Required package 'faturamento.impostos.interfaces' not found` | Toda tarefa de código termina em handoff. O bloco de conferência vai para `IA/456948/testes/tasks.md`, não para o chat |

---

## Global Constraints

Valem para **todas** as tarefas. Violá-las trava o commit ou corrompe o fonte.

**Encoding — obrigatório.** Os `.pas` não têm todos o mesmo encoding:

| Arquivo | Encoding |
|---|---|
| `untBalancoEstoqueGravar.pas` | **latin-1**, CRLF |
| `untCadLote.pas`, `untCadIte.pas`, `untMovGer.pas`, `untFuncoesGenerica.pas` | verificar antes de editar |
| `untFuncoesSimples.pas` | **UTF-8 com BOM** |

Usar as ferramentas de edição direto **corrompe os acentos** — numa sessão anterior destruiu 210 caracteres acentuados em 119 linhas. Editar sempre pelo `ferramentas/edita_pas.py` da Tarefa 2. Conferir depois: `U+FFFD == 0`, bytes acentuados iguais à base, CRLF preservado, `Try` = `Except` + `Finally`.

**Travas do pre-commit SVN.** Nunca gerar: `StrToFloat(` / `StrToFloatDef(` (usar `fStrToFloat` / `fStrToFloatDef`); `Now()` / `Now` em SQL ou código (usar `fNow()`); `.SetFocus` direto (usar `pSetFocus`); `TBitBtn` / `TButton` (usar `TBitBtnLocked`); `Application.CreateForm(` (usar `pCriarForm` / `pCriarFormularios`); `FOREIGN_KEY_CHECKS`; `TDataSetProvider` / `TClientDataSet`; `TDBGrid`; `dxSkin*`.

**Zona legado — manter o estilo, não refatorar.** Hungarian obrigatório (`str`, `bln`, `int`, `flt`, `qry`, `slt`, `obj`); prefixo `F` em campo privado, `A` em parâmetro, `p` em procedure, `f` em function; SQL embutido com `.SQL.Add` e `ParamByName`. Não introduzir interfaces, não converter para dot-notation, não reordenar units.

**Restrição 3.2 — intocável.** Não alterar o trigger `pSetaVariaveisPreAlt`, o `INSERT INTO LOGREP`, nem desligar `VS_blnGravaLogTransacao`.

**Banco.** MySQL 5.7 — sem CTE (`WITH`), sem window functions, sem `JSON_TABLE`. `ANSI_QUOTES` ativo em algumas sessões: **usar aspas simples** em scripts. `EXPLAIN UPDATE` dá erro 1792 em sessão read-only — usar o `SELECT` equivalente. Toda escrita no banco é entregue como **script pronto para o Willian executar**, sem marcador por preencher.

**Números de linha deslocam.** Todas as referências `:NNNN` neste plano são da **versão base**. Cada tarefa que insere código desloca as seguintes. Localizar as âncoras **por conteúdo**, não por número — os números servem para achar a região, o `edita_pas.py` garante a unicidade do trecho.

**Projeto a compilar:** `autcom.dproj`. `libOpeRefProd.dproj` não carrega `untBalancoEstoqueGravar.pas`.

---

## Estrutura de arquivos

### Criados

| Arquivo | Responsabilidade |
|---|---|
| `IA/456948/ferramentas/edita_pas.py` | Edição byte-safe de `.pas`. Preserva encoding e CRLF, exige `count == 1` por substituição, valida `U+FFFD == 0` |
| `IA/456948/testes/04_massa_multilote_40.sql` | Massa com 5–8 lotes contados por item, atravessando fronteira de documento |
| `IA/456948/testes/06_snapshot_BASE.sql` e `06_snapshot_NOVA.sql` | Capturam o estado final em `BALSNAP_<tabela>_BASE` e `_NOVA`. Duas versões prontas, sem marcador por preencher |
| `IA/456948/testes/07_diff.sql` | Compara `_BASE` × `_NOVA` coluna a coluna |
| `IA/456948/testes/08_metricas.sql` | Extrai statements, toques em `ITEGER` e comandos de aplicação do general log |
| `IA/456948/testes/tasks.md` | Blocos de conferência para o Willian, com valor esperado e espaço para o obtido |
| `IA/456948/diffs/NN-<passo>.diff` | Ponto de retorno de cada tarefa |

### Modificados

| Arquivo | O que muda | Tarefa |
|---|---|---|
| `padra_atualizado/fontes/genericos/untFuncoesSimples.pas` | Cache do `@VS_ID_TRANSACAO` | 4 |
| `padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas` | M3, M2, M5, M4 (chamada), M1 | 5, 6, 7, 10, 11 |
| `padra_atualizado/fontes/genericos/BatchSQL/untTBatchSQL.Helper.pas` | `pPostOuAcumula` | 9 |
| `padra_atualizado/fontes/faturamento/untMovGer.pas` | Parâmetro `ABatch` e conversão dos `Post` de `fGravaMovDet` | 10 |
| `padra_atualizado/fontes/genericos/untTypesSistema.pas` | Campo `ABatch` em `TMovDetParams` e `Init` — alterado pelo Willian ao encaixar o M4 | 10 |
| `padra_atualizado/fontes/cadastros/untConDet.pas` | M8: `fGravaConDetZeraContagemLote`/`fInserirRegistro` set-based; M9: `pSetValoresAntigos` lê `CADLOT` com lote | 13, 15 |
| `padra_atualizado/fontes/genericos/untFuncoesGenerica.pas` | M10: cache de `fGetPesoEspecificoItemGranel` | 14 |
| `padra_atualizado/fontes/genericos/BatchSQL/untTBatchSQL.pas` | M11: propriedade `OwnsQuery` | 13 |
| `padra_atualizado/fontes/cadastros/untCadIte.pas`, `untCadLote.pas` | Desvio para o lote de saldos (M1b), vindos do merge com o trunk | 4b |
| `padra_atualizado/fontes/cadastros/untICadLote.pas`, `padra_atualizado/fontes/genericos/untConstantes.pas` | Vieram do merge das 6 revisões do trunk | 4b |

---

## Mapa das tarefas

| # | Tarefa | Entrega | Depende de |
|---|---|---|---|
| 1 | Massa multi-lote | `04_massa_multilote_40.sql` | — |
| 2 | Ferramentas de medição e edição | `edita_pas.py`, `06_snapshot_BASE/NOVA`, `07_diff`, `08_metricas` | — |
| 3 | Baseline na versão base | Números em `testes/tasks.md` | 1, 2 |
| 4 | M6 — cache do `@VS_ID_TRANSACAO` | `untFuncoesSimples.pas` | 3 |
| 5 | M3 — `fMarcaAju*`/`fAjusteQtd*` fora do laço | `untBalancoEstoqueGravar.pas` | 4 |
| 6 | M2 — dedup de `pZeraItem` | `untBalancoEstoqueGravar.pas` | 5 |
| 6b | **M2b — `fZeraContagemLote` fora do laço** ⚠ | `untBalancoEstoqueGravar.pas` | 5, e decisão do Willian |
| 7 | M5 — pré-carga do `qryIteGer` | `untBalancoEstoqueGravar.pas` | 6 |
| 8 | **Gate Q2** — consumidor do `LOGREP` | Resposta do Willian | — |
| 9 | `pPostOuAcumula` + auditoria de Q6/Q7 | `untTBatchSQL.Helper.pas` | 8 |
| 10 | M4 — `ABatch` em `fGravaMovDet` | `untMovGer.pas`, `untBalancoEstoqueGravar.pas` | 9 |
| 11 | M1 — batch de saldos + flush antes da auditoria | `untBalancoEstoqueGravar.pas` | 7 |
| 4b | Integração das correções do trunk (6 revisões) | `untBalancoEstoqueGravar.pas` e mais 5 arquivos | 4-11 |
| 13 | M8 — `CONDET` em lote (456948-B) | `untConDet.pas`, `untTBatchSQL.pas` | 4b |
| 14 | M10 — cache de `fGetPesoEspecificoItemGranel` (456948-B) | `untFuncoesGenerica.pas`, chamada em `untBalancoEstoqueGravar.pas` | 4b |
| 15 | M9 — `pSetValoresAntigos` lê `CADLOT` com lote (D12) | `untConDet.pas` | 4b |
| 12 | Medição final e fechamento | `testes/tasks.md`, `specs.md` | 11, 13, 14, 15 |

A Tarefa 8 é um portão, não trabalho: se a resposta do Willian for desfavorável, as Tarefas 9 e 10 caem e o plano termina na 11 + 12.

---

## Tarefa 1 — Massa de teste multi-lote  ✅ CONCLUIDA (2026-08-19)

**Entregue:** `IA/456948/testes/04_massa_multilote_40.sql`

**O que mudou em relacao ao previsto.** O plano assumia que o numero `03` estava
livre e que a massa precisava ser escrita do zero. Ao explorar a pasta,
`03_massa_2000_itens.sql` **ja existia** e ja fazia massa multi-lote — 2.000 itens
x 7 lotes = 14.000 linhas, 700 documentos. Entao a tarefa virou criar a **variante
pequena** reaproveitando a logica ja provada, em vez de duplicar trabalho.

| Massa | Volume | Uso |
|---|---|---|
| `01_massa_60_itens.sql` | 60 itens x 1 lote = 60 linhas | legado; nao exercita M2 nem M3 |
| `03_massa_2000_itens.sql` | 2.000 itens x 7 lotes = 14.000 linhas / 700 docs | medicao de **volume** (bloco J.4) |
| `04_massa_multilote_40.sql` | **40 itens x 7 lotes = 280 linhas / 14 docs** | ciclo de validacao, blocos A a I |

**Numeros conferidos contra a base:** 280 linhas, 40 itens, 7 lotes por item,
**140 divergencias positivas e 140 negativas**, zero sem divergencia, zero contagem
negativa, e **os 40 itens com os dois sinais**.

**Uma correcao que a validacao pegou.** Com o criterio de selecao do `03`, os 40
primeiros itens elegiveis dao **240 de 280 lotes com saldo zero**. Como a regra do
delta forca divergencia positiva quando o saldo e menor que 1 (senao a contagem
negativaria), a massa sairia com **257 positivas contra 23 negativas** — praticamente
um sinal so, sem exercitar a compensacao item x lote, que e justamente o caso que o
M3 corrige. O `04` aperta o filtro para **nenhum lote valido com saldo abaixo de 1**;
ha 412 itens candidatos nessa condicao, folga suficiente para os 40. Com isso a
distribuicao ficou 140/140.

**Duas adicoes ao que o plano previa:**

- **Coluna `NUMLOT` no auxiliar `BALSELMULTI456948`.** O auxiliar do `03` guarda
  `LOTE_INC` (o `AUTOINCREM` da `CADLOT`), mas o `MOVDET` identifica o lote por
  `DET_NUMLOT`. Sem `NUMLOT` nao da para conferir a quantidade movimentada lote a
  lote depois da gravacao.
- **Marcador de rodada `BALRODADA456948`** (PASSO 6 do script). Guarda o maior
  `AUTOINCREM` de `MOVGER` de antes da gravacao. Sem ele, os snapshots nao
  conseguem separar os documentos desta rodada dos das anteriores — **filtrar por
  data nao serve**, porque ja existem documentos AJ da empresa 001 do mesmo dia
  (3848, 3849 e 3850 sao todos de 2026-08-19). O diff BASE x NOVA compararia
  conjuntos diferentes.

---

## Tarefa 2 — Ferramentas de edicao e medicao  ✅ CONCLUIDA (2026-08-19)

**Entregues:**

| Arquivo | Papel |
|---|---|
| `ferramentas/edita_pas.py` | Edicao byte-safe de `.pas` |
| `ferramentas/teste_edita_pas.py` | Suite de teste da ferramenta acima |
| `testes/05_marca_rodada.sql` | Marcador de rodada avulso, para usar com a massa `01` ou `03` |
| `testes/06_snapshot_BASE.sql` | Captura o estado final com sufixo `_BASE` |
| `testes/06_snapshot_NOVA.sql` | Idem com sufixo `_NOVA` (gerado a partir do BASE) |
| `testes/07_diff.sql` | Comparacao coluna a coluna |
| `testes/08_metricas.sql` | Extrai as tres metricas do general log |

**`edita_pas.py` — validada, nao so escrita.** A suite `teste_edita_pas.py` cobre
20 verificacoes em 5 cenarios: latin-1 com CRLF, UTF-8 com BOM, aborto quando o
trecho nao existe, aborto quando aparece mais de uma vez, e **atomicidade** (uma
edicao valida seguida de uma invalida nao pode gravar nada). Todas passam.

Dry-run contra os dois fontes reais do requisito confirmou o que o handoff dizia:

| Arquivo | Encoding | Bytes acentuados |
|---|---|---|
| `untBalancoEstoqueGravar.pas` | latin-1, sem BOM | **168** |
| `untFuncoesSimples.pas` | **UTF-8 com BOM** | 7.561 |

O dry-run em `untFuncoesSimples.pas` com a ancora `procedure pAfterRollback(...)`
**abortou corretamente** — a assinatura aparece duas vezes, na interface e na
implementacao. E o comportamento desejado: ancora ambigua nunca deve ser aplicada.
As edicoes das tarefas seguintes precisam de ancoras multi-linha que incluam corpo.

**Uso:**

```bash
python IA/456948/ferramentas/edita_pas.py <arquivo.pas> <edicoes.json> [--dry-run]
```

`edicoes.json` e uma lista de `{"de": "...", "para": "..."}`. Cada `de` tem que
casar **exatamente uma vez**; caso contrario aborta sem gravar nada. Use
`--dry-run` para conferir encoding e contagem de acentos antes de aplicar.

**Delimitacao da rodada.** Os snapshots resolvem os documentos uma vez em
`BALDOCS456948`, a partir do marcador:

```sql
INSERT INTO BALDOCS456948 (SEQGER)
SELECT G.AUTOINCREM FROM MOVGER G
 WHERE G.GER_CODEMP = '001' AND G.GER_ESPDOC = 'AJ'
   AND G.AUTOINCREM > (SELECT MARCADOR FROM BALRODADA456948);
```

`MOVDET`, `MOVTRI` e `MOVAUX` sao filtrados por `DET_SEQGER IN (BALDOCS456948)`.
**`MOVDET` nao tem `DET_DTALAN`** — a coluna nao existe; `MOVTRI` e `MOVAUX` nao
tem coluna de data nenhuma. Onde uma data e usada como filtro auxiliar, a coluna
certa e **`MOVGER.GER_DTAENT`**: e o `VS_Date` que `fGravaMovGer` recebe como Data
da Entrada.

**O diff e gerado, nao escrito a mao.** `MOVDET` tem 101 colunas; escrever a
comparacao manualmente seria inviavel e propenso a esquecer coluna — exatamente o
erro que faria o teste passar com defeito. O `07_diff.sql` gera o SQL de comparacao
a partir de `information_schema.COLUMNS` e usa `<=>` (null-safe), nunca `<>`:
`NULL <> NULL` da `NULL`, e colunas nulas passariam despercebidas.

---

## Tarefa 3 — Baseline na versão base

**Arquivos:**
- Modificar: `IA/456948/testes/tasks.md` (Bloco B)

**Interfaces:**
- Consome: `04_massa_multilote_40.sql` (Tarefa 1), `06_snapshot_BASE.sql` e `08_metricas.sql` (Tarefa 2)
- Produz: os três números de referência (`STATEMENTS`, `TOQUES_ITEGER`, `COMANDOS_APP`) e as tabelas `BALSNAP_*_BASE`, contra os quais toda tarefa seguinte é comparada

**Por que primeiro:** não existe nenhuma medição consolidada da versão base com massa multi-lote. Medir só no fim não diz de onde veio o ganho, e sem `BALSNAP_*_BASE` a prova de equivalência é impossível.

- [ ] **Passo 1: Confirmar que a cópia de trabalho está na versão base**

```bash
cd C:/Users/willian.gama/Documents/Autpas/Closed/379.48.2.30.74.150.45.63
svn status padra_atualizado/fontes/ | grep -v "^?" | grep -v "^X" | grep -v "^$"
```

Esperado: nenhuma linha `M`. Se houver, a baseline mediria código já alterado.

- [ ] **Passo 2: Escrever o Bloco B em `testes/tasks.md`**

Sequência que o Willian executa, com valor esperado em cada ponto:

1. Rodar `04_massa_multilote_40.sql`. Conferências 1, 2 e 3 do script: `40 / 240 / 12`, `40 / 40`, `40`.
2. Abrir a tela, gravar a contagem, anotar o horário de início e fim.
3. Rodar `08_metricas.sql` e anotar `STATEMENTS`, `TOQUES_ITEGER`, `COMANDOS_APP`, `SEGUNDOS`.
4. Rodar `06_snapshot_BASE.sql`.
5. Conferir que a gravação deu certo, com a asserção de estoque:

```sql
-- Estoque virou a contagem, por lote. Esperado: 240 / 240 / 0
SELECT COUNT(*) AS LOTES,
       SUM(ABS(L.LOT_SALDOS - (S.SALDO + S.DELTA)) < 0.001) AS SALDO_OK,
       SUM(L.LOT_DIGCON = 'S')                              AS AINDA_CONTADO
  FROM CADLOT L
 INNER JOIN BALSELMULTI456948 S ON S.CODITE = L.LOT_CODITE
                             AND S.NUMLOT = L.LOT_NUMLOT
 WHERE L.LOT_CODEMP = '001';
```

**Atenção na asserção:** depois da gravação, `LOT_SALCON` volta a `0` — a rotina zera a contagem no fim. Comparar `LOT_SALDOS` com `LOT_SALCON` dá falso negativo. Comparar com `BALSELMULTI456948.SALDO + DELTA`.

- [ ] **Passo 3: Handoff e registro**

O Willian executa e anota. Os números do passo 3 viram a linha "Base" da tabela de acompanhamento no fim de `testes/tasks.md`. Sem eles, as Tarefas 4 a 12 não têm contra o que comparar — **não seguir sem esses números**.

---

## Tarefa 4 — M6: cache do `@VS_ID_TRANSACAO`  ✅ CONCLUIDA (2026-08-19)

**Arquivos alterados:**
- `padra_atualizado/fontes/genericos/untFuncoesSimples.pas` — 4 edições
- `padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas` — 5 edições

**Diff:** `IA/456948/diffs/04-cache-idtran.diff`

**Desenho final difere do previsto.** O plano original trocava a lógica de `fGetIDTransacao` por um `TDictionary` sempre ligado, valendo para todo o ERP. Por decisão do Willian (D8), o cache passou a ser **armado pela rotina do balanço**: duas globais, um `If` no topo de `fGetIDTransacao`, e `pLigaCacheIDTransacao` / `pDesligaCacheIDTransacao`.

**O resultado mensurável dessa escolha:** o diff é **puramente aditivo** — 95 linhas inseridas, **zero linhas existentes alteradas ou removidas**. Desarmado, que é o estado de todo o resto do ERP, `fGetIDTransacao` executa exatamente o mesmo código de antes.

### O que foi alterado

| Arquivo | Onde | O quê |
|---|---|---|
| `untFuncoesSimples.pas` | interface `:2785` | declara `pLigaCacheIDTransacao` e `pDesligaCacheIDTransacao` |
| | globais `:5611` | `VS_objConexaoIDTran: TUniConnection` e `VS_intIDTransacaoCache: UInt64` |
| | `initialization` | inicializa as duas como `Nil` / `0` |
| | antes de `fGetIDTransacao` | as duas procedures novas |
| | topo de `fGetIDTransacao` | a guarda de três condições |
| `untBalancoEstoqueGravar.pas` | `:1941` | arma, após o `fStartTransaction` do `AJ` |
| | `:2677` e `:2696` | desarma na saída normal e no `Except` do `AJ` |
| | `:2720` | arma, no caminho "sem divergência" |
| | `:2734` e `:2742` | desarma nas duas saídas desse caminho |

Dois pontos armam, quatro desarmam — as duas saídas normais e os dois `Except`.

### Conferências da aplicação

| Conferência | `untFuncoesSimples.pas` | `untBalancoEstoqueGravar.pas` |
|---|---|---|
| encoding | UTF-8 com BOM, preservado | latin-1, preservado |
| bytes acentuados | 7.561 → 7.561 | 168 → 168 |
| LF solitários | 23 → 23 | 0 → 0 |
| `TRY` / `FINALLY` | inalterados | inalterados |

> Os **23 LF solitários** de `untFuncoesSimples.pas` são pré-existentes. A `edita_pas.py` foi
> alterada nesta tarefa para **não** normalizar quebras de linha — normalizar tocaria 23 linhas
> que não são da edição, sujando o diff que o DelphAI revisa. A ferramenta agora aborta se uma
> edição mudar a contagem, o que obriga o texto inserido a vir em CRLF.

> O contador de blocos acusa `EXCEPT +2` e `+1`, mas é a palavra "Except" **dentro dos comentários**
> inseridos. O código está balanceado: em `pLigaCacheIDTransacao` há um `Try…Except` envolvendo um
> `Try…Finally`.

### Pendente: validação pelo Willian

Bloco C de `testes/tasks.md`. Compilar, rodar a massa, gravar, e conferir o `LOGREP`.

---

## Tarefa 5 — M3: `fMarcaAju*` e `fAjusteQtd*` fora do laço  ✅ CONCLUIDA (2026-08-19)

**Arquivo:** `padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas`, 9 edições
**Diff:** `IA/456948/diffs/05-ajuste-fora-do-laco.diff` — 153 linhas inseridas, 12 removidas

As 12 removidas são exatamente as chamadas por documento. No lugar delas, o laço só acumula
`sltAutIncDocs.Add(strAutInc)`, e `fAplicaAjusteIteger` / `fAplicaAjusteCadLot` rodam **uma vez**
após o laço, derivando de `MOVDET` com `GROUP BY` — item para a `ITEGER`, item + lote para a
`CADLOT`.

As quatro funções antigas ficam declaradas e implementadas, sem chamadas. Código morto
deliberado: removê-las inflaria o diff que o DelphAI revisa e não é objetivo do requisito.

### Medição

| | M6 | M6 + M3 |
|---|---|---|
| Comandos em `ITEGER` | 590 | **562** |
| Comandos em `CADLOT` | 590 | **562** |
| Comandos totais | 2.624 | **2.568** |
| Duração | 22 s | **19 s** |

Os −56 comandos são exatamente os previstos: 14 marcações + 14 ajustes viram 1 + 1, em cada
uma das duas tabelas. As demais tabelas ficaram inalteradas.

Na massa de 40 itens o ganho é modesto. **Em produção é outra ordem**: ~700 documentos fazem
~2.800 comandos virarem 4, e o `fMarcaAjuCadLot` deixa de varrer todos os lotes contados da
empresa a cada documento.

### O achado que muda o enquadramento

O M3 **corrige um defeito de dados**, não só desempenho. Ver `specs.md` §2.5.

| | Base | Com M3 |
|---|---|---|
| `LOT_QTDAJU` igual ao movimento real | 238 de 280 | **280 de 280** |
| `ITE_QTDAJU` igual à somatória do item | 28 de 40 | **40 de 40** |

### Prova de equivalência

`roda_diff.py`, 559 colunas comparadas com `<=>` (null-safe):

| Tabela | Divergências |
|---|---|
| `ITEGER` | 1 — `ITE_QTDAJU`, 12 linhas (**a correção**) |
| `CADLOT` | 1 — `LOT_QTDAJU`, 42 linhas (**a correção**) |
| `MOVDET` | nenhuma |
| `LGCEST` | nenhuma |

`ITE_SEQAJU` e `LOT_SEQAJU` saíram da comparação de valor: guardam o `AUTOINCREM` do `MOVGER`,
que muda em toda rodada por natureza. Passaram na conferência **estrutural** — apontam para
documento real da rodada, 0 inválidos nas duas tabelas.

### Duas correções na ferramenta de diff, encontradas aqui

O `roda_diff.py` deu **falso negativo** duas vezes antes de ser confiável:

1. **`DIV` é palavra reservada no MySQL** (divisão inteira). Usada como alias de coluna, derruba
   o comando inteiro com erro 1064.
2. O parser tratava saída ilegível como "nenhuma divergência" — engolindo o erro acima e
   reportando sucesso.

Agora ele **falha alto**: saída com erro ou formato inesperado é reportada como resultado não
confiável, nunca como sucesso. Também passou a excluir `%HUL%` e `%HOR%` — `ITE_HULALT` e
`DET_HORENT` escaparam do filtro `%HRA%` e apareceram como falso positivo.

---

## Tarefa 6 — M2: deduplicação em `pZeraItem`  ✅ CONCLUIDA (2026-08-19)

**Arquivo:** `padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas`, 8 edições
**Diff acumulado:** `IA/456948/diffs/06-dedup-zeraitem-acumulado.diff`

Duas listas de guarda, `sltItensZerados` e `sltItensAtivados`, com o mesmo ciclo do
`sltAutIncDocs`: criadas em `FormCreate`, `Clear` no início de cada gravação, liberadas em
`FormDestroy`. Ambas `Sorted` + `dupIgnore`.

**Dentro da guarda**, em `pZeraItem`: o `UPDATE ITEGER SET ITE_ORDCON = 0, …`,
`THistoricoBalanco.pLimpaHistoricoSaldoProduto` e o `DELETE FROM LOCCON`.

**Fora da guarda, deliberadamente:** `TConDet.fGravaConDet` e o `fNextAutoIncrem` que o
acompanha — gravam uma linha de log por chamada, não estado constante. E
`fZeraContagemLote` / `fZeraContagemLocFis`, que dependem de lote e localização; a primeira é
a Tarefa 6b.

`pAtivaItem` recebeu a guarda dentro da própria procedure, com `Exit` antecipado, cobrindo
qualquer ponto de chamada.

O bloco de 25 linhas dentro do `If` **não foi re-indentado**, com comentário explicando:
re-indentar marcaria 25 linhas como alteradas e esconderia a mudança real do revisor.

### Medição

| Comando | +M3 | +M2 |
|---|---|---|
| Comandos em `ITEGER` | 562 | **322** |
| `DELETE FROM LOCCON` | 280 | **40** |
| Comandos totais | 2.568 | **2.088** |
| Duração | 19 s | **18 s** |

Os −240 em `ITEGER` são os 280 `UPDATE` do `pZeraItem` virando 40. `CADLOT` seguiu em 562
porque `fZeraContagemLote` ainda roda por linha — é o que a Tarefa 6b resolve.

### O risco específico do M2 não se materializou

`CONDET` **2.559 na BASE e 2.559 na NOVA**, `LGCEST` 280 e 280. O log de contagem não perdeu
nenhuma linha, confirmando que `fGravaConDet` ficou fora da guarda.

Diff: **nenhuma divergência nova**. Só `ITE_QTDAJU` (12) e `LOT_QTDAJU` (42), que são as
correções já conhecidas do M3. `MOVDET` e `LGCEST` limpos, `SEQAJU` válido nas duas tabelas.

### Limitação conhecida — o teste do `Clear` não é alcançável pela interface

O plano previa gravar duas vezes sem fechar a tela. **Não dá: a tela fecha sozinha após
gravar**, então `FormDestroy` libera as listas e `FormCreate` as recria. O vazamento entre
gravações que a guarda poderia introduzir não existe por esse caminho.

O `Clear` continua correto e **é executado toda gravação**: com `CFG_USATMQ = 'S'`, `fGravar`
chama `fConfirmaAjuste` duas vezes na mesma instância do form, `'AJ'` e depois `'ML'`, e o
`Clear` roda entre as duas.

Só que **o efeito dele não é observável com esta massa**: o passe `'ML'` sai cedo em
`fVerificaSeTemDiferencasParaGravar`, porque a massa monta divergência de saldo e não de
`ITE_DIFGML`. Para exercitar de verdade seria preciso massa com divergência de mercado livre.

Registrado como limitação, não como teste feito.

---

## Tarefa 6b — M2b: `fZeraContagemLote` fora do laço  ✅ CONCLUIDA (2026-08-19)

**Decisão D9:** aplicar apenas a deduplicação. Sem filtrar a `CONDET`, sem reordenar.

**Arquivo:** `untBalancoEstoqueGravar.pas`, 1 edição — `fZeraContagemLote` entra na guarda
`blnJaZerouItem` do M2. `fZeraContagemLocFis` fica fora: é de nível de lote e localização.

`blnJaZerouItem` é Boolean local calculado **antes** do bloco de guarda, e o
`sltItensZerados.Add` lá dentro não o altera — então `Not blnJaZerouItem` continua verdadeiro
exatamente na primeira chamada do item.

**Depende do M3, já aplicado:** chamada uma vez, ela zera `LOT_DIGCON` dos 7 lotes já na
primeira linha. O `fMarcaAjuCadLot` original filtrava por `LOT_DIGCON = 'S'` e deixaria de
enxergá-los; `fAplicaAjusteCadLot` deriva de `MOVDET` e não depende disso.

### A evidência que sustentou a decisão

O `CONDET` é log usado em relatório que mostra linha a linha de item + lote. Medido:
**360 pares (item, lote) com 7 linhas cada**. O lote não diferencia — para o mesmo item e o
mesmo lote existem sete registros, com as colunas de contagem idênticas e todas zero.

Deduplicar produz uma linha por par, que é o formato que o relatório espera.

### O que ficou fora, e por quê

Investigando a `CONDET` apareceu um defeito **anterior a este requisito**: o log de zeramento
não registra variação nenhuma, porque roda depois de a contagem já ter sido zerada. Ver
`specs.md` §2.7.

Consertar exigiria reordenar `pZeraItem` e alterar `untConDet.pas`, mudando conteúdo de log
visível em relatório — **decisão de negócio, não de desempenho**. Fora do escopo, registrado
para requisito próprio.

---

## Tarefa 7 — M5: pré-carga do `qryIteGer`  ✅ CONCLUIDA (2026-08-20)

**Arquivos:**
- Modificar: `padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas` — montagem em `:2309-2322`, uso em `:2378-2386`

**Interfaces:**
- Consome: nada das tarefas anteriores
- Produz: `dicCnvMlItem: TDictionary<String, Double>` (campo privado) e `procedure pCarregaCnvMlItens;`. Das 6 colunas que `qryIteGer` seleciona, só `ITE_CNV_ML` é efetivamente lida, então o dicionário guarda apenas esse valor — não é preciso record.

**O que está sendo eliminado.** `qryIteGer` seleciona 6 colunas e é reaberta **uma vez por linha de divergência** (`:2378-2381`). Das 6 colunas, o código lê **apenas `ITE_CNV_ML`** (`:2384`), e só quando `blnAjuGra` é verdadeiro — isto é, na espécie `ML`. Na espécie `AJ`, `fltCnv_Ml` recebe `1` sem consultar nada, mas a query é aberta assim mesmo.

Isso torna a otimização mais simples do que parece: no caminho `AJ` a consulta é **puro desperdício**.

- [ ] **Passo 1: Confirmar que só `ITE_CNV_ML` é lida**

```bash
grep -n "qryIteGer" padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas
```

Esperado: as ocorrências são a criação (`:2297`), a montagem do SQL (`:2309-2322`), o `Close`/`ParamByName`/`Open` (`:2378-2381`), a leitura de `ITE_CNV_ML` (`:2384`) e o `FreeAndNil` (`:2675`). **Se aparecer qualquer outra leitura de campo, esta tarefa muda** — o dicionário precisa guardar as colunas efetivamente lidas.

- [ ] **Passo 2: Declarar o dicionário**

```
de:
    sltItensZerados: TStringList;

para:
    sltItensZerados: TStringList;
    dicCnvMlItem: TDictionary<String, Double>;
```

Criar, liberar e limpar nos mesmos três pontos das tarefas anteriores:

```
de:
  sltItensZerados.Duplicates := dupIgnore;

para:
  sltItensZerados.Duplicates := dupIgnore;
  dicCnvMlItem := TDictionary<String, Double>.Create;
```

```
de:
  If Assigned(sltItensZerados) Then
    FreeAndNil(sltItensZerados);

para:
  If Assigned(sltItensZerados) Then
    FreeAndNil(sltItensZerados);

  If Assigned(dicCnvMlItem) Then
    FreeAndNil(dicCnvMlItem);
```

```
de:
    sltAutIncDocs.Clear;
    sltItensZerados.Clear;

para:
    sltAutIncDocs.Clear;
    sltItensZerados.Clear;
    dicCnvMlItem.Clear;
```

- [ ] **Passo 3: Escrever o procedimento de carga**

Declarar na seção `private` e implementar antes de `fConfirmaAjuste`:

```pascal
{***************************************************************}
{* Carrega ITE_CNV_ML de todos os itens da rodada numa passada. *}
{* Substitui a reabertura de qryIteGer por linha de divergencia.*}
{* Req. 456948                                                  *}
{***************************************************************}
procedure TfrmBalancoEstoqueGravar.pCarregaCnvMlItens;
  Var
    qryCnv: TUniQuery;
    sltCodIte: TStringList;
begin
  dicCnvMlItem.Clear;

  sltCodIte := TStringList.Create;
  Try
    sltCodIte.Sorted := True;
    sltCodIte.Duplicates := dupIgnore;

    qryGen.First;
    While Not qryGen.Eof Do
    Begin
      sltCodIte.Add(qryGen.FieldByName('ITE_CODITE').AsString);
      qryGen.Next;
    End;

    If sltCodIte.Count = 0 Then
      Exit;

    qryCnv := fCriaQuery;
    Try
      With qryCnv, SQL Do
      Begin
        Add(' SELECT G.ITE_CODITE, G.ITE_CNV_ML   ');
        Add('   FROM ITEGER G                     ');
        Add('  INNER JOIN CADITE C ON             ');
        Add('        C.ITE_CODITE = G.ITE_CODITE  ');
        Add('  WHERE G.ITE_CODEMP = :CODEMP       ');
        Add('    AND G.ITE_CODITE IN (' + fCommaText(sltCodIte, True) + ') ');

        ParamByName('CODEMP').AsString := VS_strCodEmp;
      End;

      qryCnv.Open;
      While Not qryCnv.Eof Do
      Begin
        dicCnvMlItem.AddOrSetValue(qryCnv.FieldByName('ITE_CODITE').AsString,
                                   qryCnv.FieldByName('ITE_CNV_ML').AsFloat);
        qryCnv.Next;
      End;
      qryCnv.Close;
    Finally
      FreeAndNil(qryCnv);
    End;
  Finally
    FreeAndNil(sltCodIte);
  End;
end;
```

O `INNER JOIN CADITE` é preservado da query original: ele restringe a itens cadastrados. Sem ele, um item órfão em `ITEGER` entraria no dicionário e mudaria o comportamento.

- [ ] **Passo 4: Chamar a carga e trocar o uso**

Chamar logo depois do `sltItensZerados.Clear`, **antes** do `fStartTransaction`, para que a leitura fique fora da transação:

```
de:
    dicCnvMlItem.Clear;

    fStartTransaction;

para:
    dicCnvMlItem.Clear;
    pCarregaCnvMlItens;

    fStartTransaction;
```

Trocar o uso em `:2378-2386`:

```
de:
                  qryIteGer.Close;
                  qryIteGer.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
                  qryIteGer.ParamByName('CODEMP').AsString := VS_strCodEmp;
                  qryIteGer.Open;

                  if blnAjuGra Then
                    fltCnv_Ml := qryIteGer.FieldByName('ITE_CNV_ML').AsFloat
                  Else
                    fltCnv_Ml := 1;

para:
                  If blnAjuGra Then
                  Begin
                    If Not dicCnvMlItem.TryGetValue(FieldByName('ITE_CODITE').AsString, fltCnv_Ml) Then
                      fltCnv_Ml := 0;
                  End
                  Else
                    fltCnv_Ml := 1;
```

O fallback é `0`, não `1`: hoje, se o item não existisse na query, `qryIteGer` viria vazio e `FieldByName('ITE_CNV_ML').AsFloat` devolveria `0`. Usar `1` mudaria o comportamento.

- [ ] **Passo 5: Aplicar, validar e conferir**

```bash
python IA/456948/ferramentas/edita_pas.py \
  padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas \
  IA/456948/ferramentas/ed-07-precarga-cnvml.json
```

Esperado: `OK  encoding=latin-1  bom=False  acentos: 168 -> 168`.

`qryIteGer` continua sendo criada e liberada — não remover, para manter o diff pequeno. O compilador vai avisar que ela não é mais usada; isso é esperado.

- [ ] **Passo 6: Escrever o Bloco F em `testes/tasks.md`**

1. Compilar, restaurar massa, gravar.
2. Perfil de statements. Esperado: `SELECT ITE_PRECUS, ITE_PREMED…` some (de 240 para 0) e aparece **1** `SELECT G.ITE_CODITE, G.ITE_CNV_ML`.
3. `07_diff.sql`. Esperado: **nenhuma** divergência nova.

**Nota sobre cobertura:** a espécie `AJ` não lê `ITE_CNV_ML`, então este teste não exercita o valor. Para cobrir, é preciso um cliente ou massa com `CFG_USATMQ` ligado, que dispara `fConfirmaAjuste('ML')`. Registrar como limitação conhecida em `testes/tasks.md` se `CFG_USATMQ` estiver desligado nesta base.

- [ ] **Passo 7: Checkpoint**

```bash
svn diff > IA/456948/diffs/07-precarga-cnvml.diff
```

---

### O Passo 1 reprovou a premissa do plano — a tarefa mudou

O plano previa `TDictionary<String, Double>` guardando só `ITE_CNV_ML`, afirmando que era a
única coluna lida. **São cinco**, e as outras quatro são lidas nas duas espécies, não só na
`ML`:

| Coluna | Onde é lida |
|---|---|
| `ITE_CNV_ML` | `fltCnv_Ml`, só quando `blnAjuGra` |
| `ITE_PRECUS` | `fltTotCus` e `fltTotCu2` |
| `ITE_PREMED` | `fltTotMed` |
| `ITE_PREULT` | `fltTotUlt` |
| `ITE_IMPULT` | `fltImpUlt` |

Por isso o dicionário guarda um record `TdtoCustoIteGer` com os cinco valores, e não um
`Double`. Com isso cai também a leitura do plano de que "na espécie `AJ` a consulta é puro
desperdício": no `AJ` ela é desperdício **apenas** de `ITE_CNV_ML` — os outros quatro campos
são usados.

### Por que congelar os valores é seguro

Pré-carga só é equivalente se nada alterar as colunas durante a rodada. Conferido dos dois
lados:

- **Aplicação:** dos 771 comandos do `LOGREP` da rodada, **nenhum** cita `ITE_PRECUS`,
  `ITE_PREMED`, `ITE_PREULT`, `ITE_IMPULT` ou `ITE_CNV_ML`.
- **Banco:** dos 8 triggers de `ITEGER`, os que citam `PRECUS` apenas o **copiam** para
  `REGPRE` (`PRO_PRECUS = NEW.ITE_PRECUS`). Nenhum escreve nas cinco colunas.

### Equivalência do caminho não encontrado

Hoje, item ausente deixa `qryIteGer` vazia e `FieldByName().AsFloat` devolve `0`.
`Default(TdtoCustoIteGer)` zera os cinco campos — mesmo comportamento. `fltCnv_Ml` continua
recebendo `1` na espécie `AJ`.

### `qryIteGer` foi removida, contrariando o plano

O plano mandava mantê-la "para o diff ficar pequeno", esperando aviso do compilador. Não
haveria aviso: ela continuaria sendo atribuída, montada e liberada — só nunca mais aberta.

E manter custava mais que remover: `qryIteGer := fCriaQuery(Self)` estava **dentro do laço de
documentos** e o `FreeAndNil` era único, depois do laço. Com 14 documentos sobravam 13 queries
presas ao dono até a tela fechar. Já era assim antes, mas antes a query servia para alguma
coisa.

### Medição — rodada de 2026-08-20 08:36, com general log ligado

Como previsto, **a contagem de comandos do `LOGREP` não muda**: `SELECT` não entra na
replicação. O ganho aparece no perfil de statements.

| Métrica | Baseline | Com M6+M3+M2+M2b+M4+M5 |
|---|---|---|
| Comandos no `LOGREP` | 2.680 | 775 |
| Statements no general log | 19.228 | 10.430 |
| Toques em `ITEGER` (`SET @ITE_PREALT`) | 922 | 400 |
| Consulta de custo por linha | 280 | 2 |

Os 775 comandos contra os 771 da rodada anterior são o `UPDATE LGCEST SET LOG_EFETIV = 1` e
o que vem com ele — esta rodada foi confirmada na tela, a anterior não.

O tempo de parede desta rodada, 25 s, **não é comparável** com os 12 a 21 s das anteriores:
o general log estava ligado, e foi ele que produziu o número de statements.

### Conferência funcional e equivalência

Diff coluna a coluna: `MOVDET`, `MOVTRI`, `MOVAUX` e `LGCEST` **sem divergência**; sobram
apenas `ITE_QTDAJU` (12 linhas) e `LOT_QTDAJU` (42), as correções conhecidas do M3. Nos 280
lotes: 280 saldos corretos, 280 contagens zeradas, 280 `LOT_QTDAJU` corretos.

### Dois erros meus na aplicação, corrigidos

**`TBookmarkStr` em vez de `TBookmark`** — `E2010 Incompatible types: 'AnsiString' and
'System.TArray<System.Byte>'`. Troquei `GetBookmark`/`FreeBookmark` pela propriedade
`Bookmark` para evitar aviso de *deprecated*, mas o aviso já estava desligado na linha de
comando do `dcc32` (`-W-SYMBOL_DEPRECATED`) e nesta versão a propriedade é `TBookmark`, um
array dinâmico. Ficou `bkmPosicao: TBookmark` com `Length(bkmPosicao) > 0` — sem liberação
manual.

**`G.ITE_CNV_ML`** — `Unknown column 'G.ITE_CNV_ML' in 'field list'`. Prefixei as cinco
colunas com o alias da `ITEGER`; `ITE_CNV_ML` é da **`CADITE`**. A consulta original não
qualificava nenhuma delas, e era por isso que cada nome caía na tabela certa sozinho. A
`CADITE` tem uma linha por item (16.396 de 16.396), então o join não duplica.

### Limitação de cobertura

A espécie `AJ` não lê `ITE_CNV_ML` — o teste não exercita esse campo. Cobrir exige base com
`CFG_USATMQ` ligado, que dispara `fConfirmaAjuste('ML')`. Nesta base não existe nem a coluna
`CFG_USATMQ`.

### Arquivos e edições

`untBalancoEstoqueGravar.pas`, 20 edições em quatro lotes: `ed-07-precarga-custo.json` (tipo,
campo, declaração, criação, liberação, chamada, método), `ed-07b-usos-precarga.json` (os
cinco usos), `ed-07c-remove-qryitger.json` (remoção) e `ed-07d-bookmark.json` (`Bookmark` em
vez de `GetBookmark`/`FreeBookmark`, marcados *deprecated* no Seattle).

---
## Tarefa 8 — Gate Q2: consumidor do `LOGREP`

**Arquivos:** nenhum. Esta tarefa é uma decisão, não código.

**A pergunta.** `TBatchSQL` concatena até 500 comandos num único `ExecSQL`. Como `fGravaLogRep` é acionado pelo SQL Monitor do UniDAC **por chamada de `ExecSQL`**, uma linha de `LOGREP` passa a conter até 500 comandos em vez de 1. A aplicação que consome a fila de replicação **não está na cópia de trabalho**, então isto não é verificável aqui.

**Precisa ser respondido:**

1. O consumidor aplica cada linha de `LOGREP` como um comando único, ou faz parsing e separa por `;`?
2. Se envolve a aplicação numa transação no destino, uma linha com 500 comandos vira uma transação de 500 comandos — isso é aceitável?
3. Há limite de tamanho no campo ou no transporte que 500 comandos concatenados estourariam?

**Evidência a favor, que não substitui a resposta.** `pInsertLoteLGCEST` (`untBalancoEstoqueGravar.pas:1062-1079`) **já concatena 500 `INSERT` num único `ExecSQL`** e está em produção. Portanto o consumidor já recebe hoje linhas de `LOGREP` com múltiplos comandos. Isso torna o risco pequeno, mas é inferência sobre um componente que não podemos ler — confirmar, não presumir.

- [ ] **Passo 1: Registrar a pergunta em `testes/tasks.md` como Bloco G, com as três perguntas acima**

- [ ] **Passo 2: Aguardar a resposta do Willian**

- [ ] **Passo 3: Decidir**

| Resposta | Consequência |
|---|---|
| Consumidor lida bem com comandos concatenados | Seguir para as Tarefas 9 e 10 |
| Consumidor exige 1 comando por linha | **Tarefas 9 e 10 caem.** O plano termina na 11 + 12. O termo de 12,5% do `LOGREP` fica sem solução dentro das restrições, e isso é registrado em `specs.md` como limitação |
| Há limite de tamanho | Reduzir `BatchSize` até caber e seguir, com o ganho proporcionalmente menor |

---

## Tarefa 9 — `pPostOuAcumula` e auditoria de Q6/Q7

**Arquivos:**
- Modificar: `padra_atualizado/fontes/genericos/BatchSQL/untTBatchSQL.Helper.pas`

**Interfaces:**
- Produz: `class procedure TBatchHelper.PostOuAcumula(ADataSet: TUniQuery; const AstrTabela: String; ABatch: TBatchSQL);` — com `ABatch = Nil` faz `ADataSet.Post`; com `ABatch` atribuído, monta o `INSERT` a partir dos campos, acumula no lote e faz `ADataSet.Cancel`.

**Depende de:** Tarefa 8 aprovada.

- [ ] **Passo 1: Auditar Q6 — algum campo é lido depois do `Post`?**

```bash
sed -n '2646,5476p' padra_atualizado/fontes/faturamento/untMovGer.pas | grep -n "Post\|FieldByName" | grep -A3 "Post"
```

Procurar qualquer `qryTblMovDet.FieldByName(...)` **depois** de um `Post` no mesmo bloco. Se existir, esse campo tem valor calculado pelo servidor (default ou trigger) e o `Cancel` o destrói.

Registrar o resultado. Se houver campos assim, `PostOuAcumula` precisa de tratamento específico e esta tarefa cresce — **não improvisar, reportar e decidir**.

- [ ] **Passo 2: Auditar Q7 — as 6 ocorrências de `ExecSQL` dentro de `fGravaMovDet`**

```bash
awk 'NR>=2646 && NR<=5476 && /ExecSQL/ {print NR": "$0}' padra_atualizado/fontes/faturamento/untMovGer.pas
```

Para cada uma, identificar a tabela de destino. **Se alguma escreve em filha de `MOVDET`** — a lista completa vem de:

```sql
SELECT DISTINCT TABLE_NAME
  FROM information_schema.KEY_COLUMN_USAGE
 WHERE TABLE_SCHEMA = 'AUTCOM' AND REFERENCED_TABLE_NAME = 'MOVDET';
```

— então ela cai no invariante de M4 e precisa ir para o lote também. Caso contrário, fica como está.

Verificar em especial o `UPDATE PROINC SET PRO_AUTINC = @AUTINC + 1`, medido a 1 por linha: se algo lê `@AUTINC` depois, mandá-lo para o lote deixa o valor defasado.

- [ ] **Passo 3: Escrever `PostOuAcumula`**

Acrescentar à declaração da classe, depois de `AddMultipleQueries`:

```
de:
    class procedure AddMultipleQueries(ABatch: TBatchSQL; AQueries: TArray<TUniQuery>);

para:
    class procedure AddMultipleQueries(ABatch: TBatchSQL; AQueries: TArray<TUniQuery>);
    class procedure PostOuAcumula(ADataSet: TUniQuery; const AstrTabela: String; ABatch: TBatchSQL);
```

Implementação:

```pascal
{***************************************************************}
{* Com ABatch = Nil faz Post normal (comportamento atual).      *}
{* Com ABatch atribuido, monta o INSERT a partir dos campos do  *}
{* dataset, acumula no lote e cancela a insercao.               *}
{* Req. 456948                                                  *}
{***************************************************************}
class procedure TBatchHelper.PostOuAcumula(ADataSet: TUniQuery;
  const AstrTabela: String; ABatch: TBatchSQL);
  Var
    intIdx: Integer;
    strCampos: String;
    strValores: String;
    objCampo: TField;
begin
  If Not Assigned(ABatch) Then
  Begin
    ADataSet.Post;
    Exit;
  End;

  strCampos  := '';
  strValores := '';

  For intIdx := 0 To ADataSet.FieldCount - 1 Do
  Begin
    objCampo := ADataSet.Fields[intIdx];

    If objCampo.ReadOnly Then
      Continue;

    If strCampos <> '' Then
    Begin
      strCampos  := strCampos + ', ';
      strValores := strValores + ', ';
    End;

    strCampos := strCampos + objCampo.FieldName;

    {Campo anulado explicitamente tem que emitir NULL, nao ser omitido:
     omitir aplicaria o default da tabela em vez de NULL.}
    If objCampo.IsNull Then
      strValores := strValores + 'NULL'
    Else
      Case objCampo.DataType Of
        ftSmallint, ftInteger, ftWord, ftLargeint, ftAutoInc:
          strValores := strValores + IntToStr(objCampo.AsLargeInt);

        ftFloat, ftCurrency, ftBCD, ftFMTBcd, ftSingle, ftExtended:
          strValores := strValores + fDoubleToSQL(objCampo.AsFloat);

        ftDate:
          strValores := strValores + QuotedStr(FormatDateTime('yyyy-mm-dd', objCampo.AsDateTime));

        ftTime:
          strValores := strValores + QuotedStr(FormatDateTime('hh:nn:ss', objCampo.AsDateTime));

        ftDateTime, ftTimeStamp:
          strValores := strValores + QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', objCampo.AsDateTime));

        ftBoolean:
          strValores := strValores + IIF(objCampo.AsBoolean, '1', '0');
      Else
        strValores := strValores + QuotedStr(objCampo.AsString);
      End;
  End;

  ABatch.BeginInsert(AstrTabela)
        .Fields(strCampos)
        .Values(strValores)
        .EndInsert;

  ADataSet.Cancel;
end;
```

`fDoubleToSQL` é a função do projeto que formata `Double` com ponto decimal — a mesma usada em `fAtualizaEstoqueCadIte` (`untCadIte.pas:192`). Usar `FloatToStr` produziria vírgula na configuração regional brasileira e quebraria o SQL.

Acrescentar `untFuncoesSimples` ou a unit que declara `fDoubleToSQL` e `IIF` ao `uses` da implementação de `untTBatchSQL.Helper.pas`, se não estiverem.

- [ ] **Passo 4: Teste isolado, sem tocar no balanço**

Antes de ligar isto em `fGravaMovDet`, provar que o SQL gerado é igual ao que o UniDAC produz. Escrever um teste descartável numa tela qualquer de desenvolvimento, ou um projeto console:

```pascal
// Abre MOVDET vazio, preenche 3 campos de tipos diferentes, gera o INSERT
// e escreve no ShowMessage em vez de executar.
qryTeste := fCriaQuery;
qryTeste.SQL.Text := 'SELECT * FROM MOVDET WHERE FALSE';
qryTeste.Open;
qryTeste.Insert;
qryTeste.FieldByName('DET_CODITE').AsString := 'TESTE01';
qryTeste.FieldByName('DET_QTDITE').AsFloat  := 1.5;
qryTeste.FieldByName('DET_DTADOC').AsDateTime := Date;
objBatch := TBatchHelper.CreateBatchSQL(fCriaQuery);
TBatchHelper.PostOuAcumula(qryTeste, 'MOVDET', objBatch);
fMensagem('', objBatch.FCommands.Text, ['&O K']);
```

Conferir manualmente: `DET_QTDITE` sai como `1.5` e não `1,5`; a data sai como `'2026-08-19'`; campos não preenchidos saem como `NULL`; nenhum campo aparece sem valor.

**Este passo não é opcional.** É o único ponto do plano onde o formato dos valores é verificado sem depender de o balanço inteiro rodar.

- [ ] **Passo 5: Checkpoint**

```bash
svn diff > IA/456948/diffs/09-postouacumula.diff
```

---

## Tarefa 10 — M4: `ABatch` em `fGravaMovDet`  ✅ CONCLUIDA (2026-08-20)

**Arquivos:**
- Modificar: `padra_atualizado/fontes/faturamento/untMovGer.pas` — assinatura de `fGravaMovDet` em `:2646`, `Post` em `:3499`, `:3972`, `:4118`, `:4181`, `:4628`, `:4789`, `:5067` (confirmar quais pertencem a `fGravaMovDet`)
- Modificar: `padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas` — criação do lote e chamada em `:2391`

**Interfaces:**
- Consome: `TBatchHelper.PostOuAcumula` (Tarefa 9)
- Produz: `fGravaMovDet(..., ABatch: TBatchSQL = Nil)` — com `Nil`, comportamento idêntico ao atual; `objBatchMovDet: TBatchSQL` (campo privado do form)

**Invariante desta tarefa — releia antes de começar.** `MOVTRI`, `MOVAUX` e `MOVREF` são **filhas de `MOVDET` por FK**. Se `MOVDET` for para o lote e uma filha continuar em `Post` imediato, o insert da filha **falha na FK** porque o pai ainda não existe. Portanto: **com o lote ativo, nenhuma escrita dentro de `fGravaMovDet` pode ficar fora dele.** Conversão parcial é incorreta, não apenas subótima. Isso inclui `MOVREF`, que não dispara nesta configuração mas dispararia em outra.

`fGravaMovGer` **não** entra nesta tarefa. Insere ~700 linhas contra 14.000 (2% do volume), e mantê-la em `Post` imediato garante que `MOVGER` — o pai — existe antes de qualquer filho batcheado.

- [ ] **Passo 1: Conferir a classificação dos `Post` — NÃO converter todos**

Nem todo `Post` na faixa de `fGravaMovDet` é inserção. Vários são edição de registro
em dataset já aberto, e convertê-los **corromperia dados**.

Critério de discriminação, aplicar a cada um:

| Padrão | Significado | Converter |
|---|---|---|
| `Insert;` ou `Append;` no mesmo bloco, antes do `Post` | inserção de linha nova | conforme a tabela |
| `Post; Next;` dentro de laço, com `First`/`Next` | edição de registro existente | **nunca** |

Classificação já levantada. As linhas são da versão base — **reconferir**, elas deslocam
com as edições das tarefas anteriores:

| Linha | Contexto | Tabela | Converter? |
|---|---|---|---|
| 3499 | `With qryTblMovDet` (3200) | `MOVDET` | **Sim** |
| 3972 | `With qryTblMovTri` (3503) | `MOVTRI` | **Sim** — filha de `MOVDET` |
| 4003 | `qryTblBriDet.Post`, após `Append` em 3994 | `BRIDET` | **Sim** — filha de `MOVDET` |
| 4118 | `With qryTblMovAux` (4051) | `MOVAUX` | **Sim** — filha de `MOVDET` |
| 4181 | `With fCriaQuery Do` **anônimo** (4125) | `MOVREF` | **Sim** — filha de `MOVDET`; exige nomear a query, ver Passo 3 |
| 4628 | `pDefineLocalizacaoFisica` (4571), `Post; Next;` em laço | — | **Não** — edição |
| 4789 | `pInsereItensSeparacao` (4635), `Post; Next;` em laço | — | **Não** — edição |
| 5014 | `qryMovInf.Post`, após `Insert` em 5009 | `MOVINF` | **Não** — filha de `MOVGER` |
| 5067 | `With qryMovObs` (5045) | `MOVOBS` | **Não** — filha de `MOVGER` |
| 5110 | `qryGerCnd.Post`, após `Insert` em 5106 | `GERCND` | **Não** — filha de `MOVGER` |

As três últimas são seguras fora do lote porque `MOVGER` **não** é batcheado — é inserido
de imediato por `fGravaMovGer`, então o pai delas já existe quando elas rodam.

FK confirmada em `information_schema.KEY_COLUMN_USAGE`: filhas de `MOVDET` são `BRIDET`,
`MOVAUX`, `MOVREF` e `MOVTRI`. Filhas de `MOVGER` são `GERCND`, `MOVINF` e `MOVOBS`.

Reconferir a classificação antes de editar:

```bash
awk 'NR>=2646 && NR<=5476 {
  if ($0 ~ /[Ww]ith +qry[A-Za-z]+/) { match($0,/qry[A-Za-z]+/); print NR"  WITH  "substr($0,RSTART,RLENGTH) }
  if ($0 ~ /^[ \t]*(qry[A-Za-z]+\.)?(Post|Insert|Append)[ \t]*;/) { print NR"  "$0 }
}' padra_atualizado/fontes/faturamento/untMovGer.pas
```

- [ ] **Passo 2: Acrescentar o parâmetro à assinatura**

Na declaração da interface e na implementação (`:2646`), acrescentar ao **fim** da lista de parâmetros:

```
;
                       ABatch: TBatchSQL = Nil
```

Acrescentar `untTBatchSQL` e `untTBatchSQL.Helper` ao `uses` de `untMovGer.pas`.

O default `Nil` é o que garante que os outros ~centenas de chamadores no ERP — venda, devolução, compra, transferência — não mudam de comportamento.

- [ ] **Passo 3: Converter cada `Post` mapeado**

Para cada um, a troca é da forma:

```
de:
        qryTblMovDet.Post;

para:
        TBatchHelper.PostOuAcumula(qryTblMovDet, 'MOVDET', ABatch);
```

Repetir para cada dataset da tabela do Passo 1, com o nome de tabela correspondente.

**`Post;` sem qualificador dentro de um `With`:** qualificar explicitamente na conversão, com o dataset que o `With` abriu. `PostOuAcumula` precisa da referência.

**O caso do `MOVREF` (`:4125-4184`) é diferente e exige refatoração.** O bloco usa `With fCriaQuery Do` — a query é **anônima**, não há variável para passar:

```pascal
With fCriaQuery Do
Try
  SQL.Text := 'SELECT * FROM MOVREF WHERE FALSE';
  Open;
  Insert;
  ...
  Post;
Finally
  Free;
End;
```

Trocar por uma variável nomeada, declarada junto das demais locais de `fGravaMovDet`:

```
de:
      If Not fEmptyStr(strRefCodCst) Then
      Begin
        With fCriaQuery Do
        Try
          SQL.Text := 'SELECT * FROM MOVREF WHERE FALSE';
          Open;
          Insert;

para:
      If Not fEmptyStr(strRefCodCst) Then
      Begin
        qryTblMovRef := fCriaQuery;
        With qryTblMovRef Do
        Try
          SQL.Text := 'SELECT * FROM MOVREF WHERE FALSE';
          Open;
          Insert;
```

```
de:
          Post;
        Finally
          Free;
        End;
      End;

para:
          TBatchHelper.PostOuAcumula(qryTblMovRef, 'MOVREF', ABatch);
        Finally
          FreeAndNil(qryTblMovRef);
        End;
      End;
```

Declarar `qryTblMovRef: TUniQuery;` na seção `Var` de `fGravaMovDet`. O `Free` vira `FreeAndNil` para acompanhar o idioma do resto da função.

**Atenção:** o `de` do segundo par (`Post;` seguido de `Finally` / `Free;` / `End;` / `End;`) precisa ser confirmado como único antes de aplicar. Se casar mais de uma vez, o `edita_pas.py` aborta — nesse caso, estender o `de` para trás incluindo as últimas linhas de `FieldByName` do bloco.

- [ ] **Passo 4: Criar e usar o lote no balanço**

Declarar o campo:

```
de:
    dicCnvMlItem: TDictionary<String, Double>;

para:
    dicCnvMlItem: TDictionary<String, Double>;
    objBatchMovDet: TBatchSQL;
```

Criar em `fConfirmaAjuste`, logo depois do `fStartTransaction`, e liberar no `Finally`. Não criar no `FormCreate`: o lote precisa da conexão da transação corrente.

```
de:
    pCarregaCnvMlItens;

    fStartTransaction;

para:
    pCarregaCnvMlItens;

    fStartTransaction;

    objBatchMovDet := TBatchHelper.CreateBatchSQL(fCriaQuery);
    objBatchMovDet.BatchSize := 500;
```

Passar na chamada (`:2391`), como último argumento:

```
de:
                                         FLOG_CODCON

para:
                                         FLOG_CODCON,
                                         objBatchMovDet
```

A chamada a `fGravaMovDet` começa em `:2391` e **fecha em `:2539` com `0);`**. Os últimos argumentos são quatro `0,` seguidos de `0);`, o que não é texto único no arquivo. Capturar a âncora real antes de montar o JSON:

```bash
sed -n '2530,2545p' padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas
```

Montar o `de` incluindo as linhas seguintes ao fechamento, até `If Not Result Then` / `Break;`, que tornam o trecho único. O `edita_pas.py` aborta se casar mais de uma vez, então a unicidade é verificada automaticamente — na dúvida, estender o `de`.

- [ ] **Passo 5: Descarregar o lote antes de qualquer leitura de `MOVDET`**

O flush vai imediatamente depois do laço de documentos, **antes** de `fAplicaAjusteIteger`, que lê `MOVDET`:

```
de:
      End; // For i:= 1 To intQtdDoc do

para:
      End; // For i:= 1 To intQtdDoc do

      {O lote tem que ir ao banco antes de qualquer leitura de MOVDET.
       fAplicaAjusteIteger e fAplicaAjusteCadLot derivam de MOVDET. Req. 456948}
      If Assigned(objBatchMovDet) Then
        objBatchMovDet.Execute;
```

**Se a Tarefa 5 não tiver sido feita, este passo está errado** — na versão original `fAjusteQtdIteger` roda dentro do laço e leria `MOVDET` antes do flush. É por isso que a Tarefa 5 vem antes.

Liberar o lote nos dois caminhos de saída, o normal e o `Except`, junto do `FreeAndNil(qryIteGer)`.

- [ ] **Passo 6: Aplicar e validar**

```bash
python IA/456948/ferramentas/edita_pas.py padra_atualizado/fontes/faturamento/untMovGer.pas \
  IA/456948/ferramentas/ed-10a-movger.json
python IA/456948/ferramentas/edita_pas.py \
  padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas \
  IA/456948/ferramentas/ed-10b-balanco.json
```

Conferir a contagem de acentos nos dois.

- [ ] **Passo 7: Escrever o Bloco H em `testes/tasks.md`**

1. **Teste de não-regressão primeiro.** Compilar e fazer uma venda, uma devolução e uma compra normais. Elas passam `ABatch = Nil` e têm que funcionar **exatamente** como antes. Conferir que os documentos foram gerados completos, com itens e impostos.
2. Restaurar massa, gravar o balanço.
3. `08_metricas.sql`. Esperado: `COMANDOS_APP` cai fortemente — os `INSERT INTO MOVDET`, `MOVTRI` e `MOVAUX` deixam de gerar uma linha de `LOGREP` cada. `TOQUES_ITEGER` **não muda**.
4. `07_diff.sql` com atenção especial a `MOVDET`, `MOVTRI` e `MOVAUX` — é aqui que o risco de formatação de valor aparece.

**Qualquer divergência de valor em `MOVDET`, `MOVTRI` ou `MOVAUX` é defeito de `PostOuAcumula`.** Reverter, corrigir o `Case` do tipo correspondente, repetir. Não seguir com divergência conhecida: são colunas fiscais.

5. Conferir que a quantidade movimentada continua batendo:

```sql
-- Quantidade movimentada = divergencia planejada, por lote. Esperado: 240 / 240
SELECT COUNT(*) AS LOTES,
       SUM(ABS(D.DET_QTDITE - ABS(S.DELTA)) < 0.001) AS QTD_OK
  FROM BALSELMULTI456948 S
 INNER JOIN MOVDET D ON D.DET_CODITE = S.CODITE
                    AND D.DET_NUMLOT = S.NUMLOT
                    AND D.DET_CODEMP = '001'
                    AND D.DET_ESPDOC = 'AJ'
                    AND D.DET_SEQGER IN (SELECT SEQGER FROM BALDOCS456948);
```

- [ ] **Passo 8: Checkpoint**

```bash
svn diff > IA/456948/diffs/10-batch-movdet.diff
```

---

### Medição

| Etapa | Comandos no `LOGREP` | Segundos |
|---|---|---|
| Antes do M4 (M6+M3+M2+M2b) | 1.608 | 17 |
| **Com o M4** | **771** | **12 a 21** |

Redução de 837 comandos, 52% do que restava. O tempo oscila entre rodadas com a carga da
estação — a contagem de comandos é a medida estável.

Efeito por tabela, em 280 linhas de movimento:

| Tabela | Comandos antes | Comandos depois |
|---|---|---|
| `MOVDET` | 280 | 1 |
| `MOVTRI` | 280 | 0 (entra no mesmo lote do `MOVDET`) |
| `MOVAUX` | 280 | 1 |

### Três defeitos encontrados pelo diff, todos corrigidos

Nenhum deles apareceu em erro de execução: a rotina rodava até o fim, gerava os 14
documentos e acertava os saldos. Só a comparação coluna a coluna com a BASE os revelou.

**1. Campo nulo emitido como `NULL` em vez de omitido** — 11 colunas do `MOVDET`, 280 linhas
cada. A BASE tinha `0.00` e `'N'`; a NOVA, `NULL`.

O `Post` do UniDAC inclui no `INSERT` apenas os campos **modificados**. Coluna nunca tocada
fica fora do comando e o MySQL aplica o `DEFAULT` da tabela. O helper montava o `INSERT` com
todas as colunas do dataset e escrevia `NULL` nas vazias, sobrescrevendo esses defaults.
Correção: campo nulo não entra no comando.

**2. Campo `blob`/`memo` omitido indevidamente** — `DET_DESNES`, 280 linhas. A BASE gravava
`''`; a NOVA passou a gravar `NULL`.

Para `TBlobField` o Delphi mantém `IsNull = True` mesmo depois de receber string vazia, mas
o UniDAC grava o campo porque ele foi modificado. A regra do item 1 o descartava. Correção:
blob e memo nunca são omitidos.

**3. `TMovDetParams` usado sem `Init`** — 8 colunas da `MOVTRI` e 1 da `MOVAUX`, 280 linhas
cada. A BASE tinha `'N'`, `'P'` e `1`; a NOVA, `''` e `0`.

Este é o mais sério dos três e **não é do helper**: é da chamada. Ao passar `TMovDetParams`
no lugar dos parâmetros posicionais, os defaults deixaram de vir da declaração da função e
passaram a vir do record. `MovDetParams` é campo do form (`untBalancoEstoqueGravar.pas:159`)
e record de campo nasce zerado — string vira `''`, Boolean vira `False`. Os posicionais
davam `strGnrOri = 'P'`, `strEntTri = 'N'`, `strPegou_ = 'N'`, `blnFilFul = True`;
`TMovDetParams.Init` (`untTypesSistema.pas:4957`) é quem estabelece esses mesmos valores.

Correção: `MovDetParams.Init` antes de cada chamada, **dentro do laço de itens** — o record é
reaproveitado entre itens e qualquer campo escrito em uma passagem vazaria para a seguinte.

> Vale para qualquer outro ponto do ERP que venha a migrar para `TMovDetParams`: sem `Init`,
> a migração silenciosamente troca os defaults por zeros. Não há erro de compilação nem de
> execução.

### Prova de equivalência — rodada de 2026-08-20 08:06, contagem `001000135`

| Tabela | Colunas comparadas | Divergências |
|---|---|---|
| `MOVDET` | 130 | nenhuma |
| `MOVTRI` | 203 | nenhuma |
| `MOVAUX` | 32 | nenhuma |
| `ITEGER` | 250 | `ITE_QTDAJU`, 12 linhas — **correção do M3**, a BASE é que estava errada |
| `CADLOT` | 159 | `LOT_QTDAJU`, 42 linhas — idem |
| `LGCEST` | 20 | `LOG_EFETIV`, 280 linhas — a gravação não foi confirmada na tela, ver abaixo |

Conferência funcional dos 280 lotes: **280 saldos corretos, 280 contagens zeradas, 280
`LOT_QTDAJU` corretos**. `ITE_SEQAJU` e `LOT_SEQAJU` apontam para documento real da rodada
nos 40 itens e 280 lotes.

### `LOG_EFETIV` não é regressão

Duas rodadas apareceram com `LOG_EFETIV = 0` nas 280 linhas. O `UPDATE LGCEST SET
LOG_EFETIV = 1` roda em `fGravar` somente com `Result = True`, e não chegou nem a ser
emitido — não está no `LOGREP` dessas rodadas. Causa: a confirmação na tela não foi dada.
Confirmando, o `UPDATE` roda e as 280 linhas ficam efetivadas.

Fica registrado porque custou investigação: a ausência do comando no `LOGREP` é o que separa
"não executou" de "executou e não teve efeito".

### Chave estável para comparar `MOVTRI` e `MOVAUX`

As duas não têm `DET_CODITE` — a primeira coluna é `DET_SEQGER`, que aponta para
`MOVDET.AUTOINCREM` e muda a cada rodada. Sem chave estável o `INNER JOIN` do diff falha com
`Unknown column 'N.DET_CODITE'`, e antes disso as duas simplesmente **não eram comparadas** —
foi assim que os defeitos 1 e 3 passaram despercebidos nas primeiras rodadas do M4.

`06_snapshot_NOVA.sql` passou a materializar `K_CODITE` e `K_NUMLOT` nos dois snapshots,
trazidos do `MOVDET` pelo próprio `DET_SEQGER`. O prefixo `K_` é proposital: como as colunas
não existem na tabela de produção, o `information_schema` não as devolve e elas ficam fora da
comparação sozinhas. `07b_chaves_movtri_movaux.sql` faz o mesmo nos snapshots BASE, que já
estavam capturados.

---
## Tarefa 11 — M1: batch de saldos com flush antes da auditoria

**Arquivos:**
- Modificar: `padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas` — chamada em `:2561-2565`, auditoria em `:2660-2665`

**Interfaces:**
- Consome: `objBatchReprocessarSaldo` (global, já existente em `untFuncoesSimples.pas:5611`); `fGetIDTransacao` (Tarefa 4)
- Produz: nada novo

**Depende de:** Tarefa 7. Independe das Tarefas 8, 9 e 10 — se o gate Q2 reprovar, esta tarefa acontece mesmo assim.

**O mecanismo.** `fAtualizaEstoqueCadIte` já tem o parâmetro `AUsarBatchSaldos` (`untCadIte.pas:152`) e o balanço usa o default `False`. Ligado, o `UPDATE ITEGER SET ITE_SALDOS = ...` entra em `objBatchReprocessarSaldo`, cujo `pUnifica` (`untFuncoesGenerica.pas:13760`) consolida os comandos por item e lote. Efeito: de 1 `UPDATE` por linha de divergência para 1 consolidado por item.

**O requisito que não pode ser esquecido.** O flush do batch acontece hoje dentro do `fCommit` (`untFuncoesSimples.pas:11217`) — ou seja, **depois** da auditoria de saldo (`:2660`). `objAuditoriaSaldo.fValidouTodas` chama a função de banco `F_AUDITORIA_GRAVACAO_SALDO`. Se ela confere saldo, leria o valor pré-ajuste, não bateria, e dispararia `fRollBack`: **o balanço passaria a falhar sempre**.

Neste banco a auditoria está inerte — `CFG_UTAUFA = 'N'` em todas as empresas e a função não existe no schema. Portanto **nenhum teste aqui pega esse defeito.** Ele apareceria na primeira gravação de um cliente com `CFG_UTAUFA = 'S'`.

- [ ] **Passo 1: Ligar o batch**

```
de:
                    Result := fAtualizaEstoqueCadIte(FieldByName('ITE_CODITE').AsString,
                                                     strEntSai,
                                                     fltQtdIte,
                                                     0.0,
                                                     FieldByName('ITE_NUMLOT').AsString, False);

para:
                    Result := fAtualizaEstoqueCadIte(FieldByName('ITE_CODITE').AsString,
                                                     strEntSai,
                                                     fltQtdIte,
                                                     0.0,
                                                     FieldByName('ITE_NUMLOT').AsString, False,
                                                     False,   // blnRetFalseSeNaoConseguirGerarNotificaoItensAbaixoMin
                                                     Nil,     // objReplTinta
                                                     '',      // AstrOpcaoDocumento
                                                     False,   // blnTravarSeSaldoFicarNegativo
                                                     '',      // strLocFis
                                                     '',      // strEmpIte
                                                     True);   // AUsarBatchSaldos - Req. 456948
```

Conferir a ordem exata dos parâmetros contra a assinatura em `untCadIte.pas:141-152` antes de aplicar. `AUsarBatchSaldos` é o **último**.

`blnTravarSeSaldoFicarNegativo` tem que continuar `False`: `fAtualizaEstoqueCadIte` levanta exceção explícita se ele for `True` junto com `AUsarBatchSaldos` (`untCadIte.pas:249`).

- [ ] **Passo 2: Descarregar o batch antes da auditoria**

```
de:
      If Result And (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
      Begin
        Result := False;
        fRollBack;
        pMostraErrosAuditoria(strCodErrosAuditoria);
      End;

para:
      {O batch de saldos so seria descarregado dentro do fCommit, DEPOIS da
       auditoria. F_AUDITORIA_GRAVACAO_SALDO leria o saldo pre-ajuste e
       dispararia rollback. Descarregar aqui, ainda na transacao, faz a
       auditoria ver o mesmo estado que ve hoje. Execute remove a entrada do
       dicionario, entao a chamada dentro do fCommit vira no-op. Req. 456948}
      If Result And Assigned(objBatchReprocessarSaldo) Then
        objBatchReprocessarSaldo.Execute(fGetIDTransacao(fGetConexao), fGetConexao);

      If Result And (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
      Begin
        Result := False;
        fRollBack;
        pMostraErrosAuditoria(strCodErrosAuditoria);
      End;
```

`fGetConexao` é a função usada por `fUsouBatchReprocessarSaldo` (`untFuncoesGenerica.pas:4265`) para obter a conexão corrente — usar a mesma, para garantir que a chave do dicionário é idêntica à usada na acumulação.

- [ ] **Passo 3: Aplicar e validar**

```bash
python IA/456948/ferramentas/edita_pas.py \
  padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas \
  IA/456948/ferramentas/ed-11-batch-saldos.json
```

- [ ] **Passo 4: Escrever o Bloco I em `testes/tasks.md`**

1. Compilar, restaurar massa, gravar.
2. `08_metricas.sql`. Esperado: `TOQUES_ITEGER` cai — os `UPDATE ITEGER SET ITE_SALDOS` deixam de ser 240 e viram ~40.
3. `07_diff.sql`. Esperado: **nenhuma** divergência nova. O saldo final tem que ser idêntico.
4. Asserção de saldo, que é o coração desta tarefa:

```sql
-- Saldo por lote. Esperado: 240 / 240
SELECT COUNT(*) AS LOTES,
       SUM(ABS(L.LOT_SALDOS - (S.SALDO + S.DELTA)) < 0.001) AS SALDO_OK
  FROM CADLOT L
 INNER JOIN BALSELMULTI456948 S ON S.CODITE = L.LOT_CODITE
                             AND S.NUMLOT = L.LOT_NUMLOT
 WHERE L.LOT_CODEMP = '001';
```

```sql
-- Saldo por item tem que bater com a soma dos lotes. Esperado: 40 / 40
SELECT COUNT(*) AS ITENS,
       SUM(ABS(G.ITE_SALDOS - T.SOMA) < 0.001) AS ITEM_BATE_LOTE
  FROM ITEGER G
 INNER JOIN (SELECT LOT_CODITE AS CODITE, SUM(LOT_SALDOS) AS SOMA
               FROM CADLOT
              WHERE LOT_CODEMP = '001'
                AND LOT_CODITE IN (SELECT DISTINCT CODITE FROM BALSELMULTI456948)
              GROUP BY LOT_CODITE) T ON T.CODITE = G.ITE_CODITE
 WHERE G.ITE_CODEMP = '001';
```

5. **Teste de rollback**, que valida o descarte do batch:

```
a) Rodar 04_massa_multilote_40.sql
b) Provocar falha na gravacao (ex.: derrubar a rede no meio, ou renomear
   temporariamente a tabela CONDET numa sessao paralela)
c) Conferir que NADA foi gravado:
```

```sql
-- Rollback total: saldo intacto e contagem preservada. Esperado: 240 / 240
SELECT COUNT(*) AS LOTES,
       SUM(ABS(L.LOT_SALDOS - S.SALDO) < 0.001) AS SALDO_INTACTO,
       SUM(L.LOT_DIGCON = 'S')                  AS AINDA_CONTADO
  FROM CADLOT L
 INNER JOIN BALSELMULTI456948 S ON S.CODITE = L.LOT_CODITE
                             AND S.NUMLOT = L.LOT_NUMLOT
 WHERE L.LOT_CODEMP = '001';
```

Se o saldo mudou apesar do rollback, o batch foi descarregado fora da transação — **defeito grave**, reverter imediatamente.

6. **Registrar como limitação conhecida** em `testes/tasks.md`: o caminho da auditoria (`CFG_UTAUFA = 'S'`) não é exercitável nesta base. O flush antecipado do Passo 2 é a proteção, e ela é por construção, não por teste.

- [ ] **Passo 5: Checkpoint**

```bash
svn diff > IA/456948/diffs/11-batch-saldos.diff
```

---

## Tarefa 12 — Medição final e fechamento

**Arquivos:**
- Modificar: `IA/456948/testes/tasks.md` (tabela de acompanhamento)
- Modificar: `IA/456948/specs.md` (§8.3, referência)

- [ ] **Passo 1: Rodada final completa**

Restaurar massa, gravar, medir. Preencher a última linha da tabela de acompanhamento.

- [ ] **Passo 2: Consolidar a tabela de acompanhamento**

| Versão | `STATEMENTS` | `TOQUES_ITEGER` | `COMANDOS_APP` | `SEGUNDOS` |
|---|---|---|---|---|
| Base (Tarefa 3) | | | | |
| + M6 (Tarefa 4) | | | | |
| + M3 (Tarefa 5) | | | | |
| + M2 (Tarefa 6) | | | | |
| + M5 (Tarefa 7) | | | | |
| + M4 (Tarefa 10) | | | | |
| + M1 (Tarefa 11) | | | | |

O piso teórico de `TOQUES_ITEGER` é **1 por item** — 40 nesta massa. Ler o número final contra esse piso, não contra a base.

- [ ] **Passo 3: Perfil final de statements**

Rodar o Passo 4 de `08_metricas.sql`. O que sobrou no topo da lista define se vale abrir M5 item 2 (os lookups por linha internos ao caminho do `MOVDET`: `SELECT NAT_DESCRI FROM NATCFO`, `SELECT SQL_NO_CACHE ITE_DESFAB…`, `SELECT SQL_NO_CACHE EMP_EXIAPP`, `SELECT COUNT(1) AS QTD FROM CADLOT`). Registrar a resposta de Q5 em `specs.md`.

- [ ] **Passo 4: Extrapolar para produção**

A massa funcional tem 40 itens × 7 lotes = 280 linhas / 14 documentos. Produção tem ~2.000 itens × ~7 lotes = ~14.000 linhas / ~700 documentos — que é exatamente o que a massa `03_massa_2000_itens.sql` reproduz. A extrapolação **não é linear** para o que era quadrático: o ganho de M3 cresce com o número de documentos (14 na massa funcional, ~700 em produção). Rodar o `03` no bloco J.4 e registrar as duas leituras separadamente, em vez de extrapolar da massa pequena.

- [ ] **Passo 5: Atualizar `specs.md`**

Substituir a baseline de §8.3 pelos números finais. Marcar Q3, Q5, Q6 e Q7 como respondidas com o que foi apurado. Se o gate Q2 tiver reprovado, registrar a limitação em §9.

- [ ] **Passo 6: Diff consolidado para o DelphAI**

```bash
svn diff > IA/456948/diffs/final-completo.diff
svn status | grep "^M"
```

Conferir que os arquivos modificados são exatamente: `untFuncoesSimples.pas`, `untBalancoEstoqueGravar.pas`, `untTBatchSQL.Helper.pas`, `untMovGer.pas`. Qualquer outro é acidente.

O commit é do Willian: primeira linha `Req. 456948`, token do DelphAI na mensagem.

---

## Tarefa 13 — M8: `CONDET` em lote (456948-B)  ✅ CONCLUÍDA (2026-08-20/25)

**Arquivos:** `untConDet.pas` (`fGravaConDetZeraContagemLote`/`fInserirRegistro`/`fSQLInsertItens` set-based, `blnUsaTemporaria` removido — B8), `untTBatchSQL.pas` (`OwnsQuery`, M11).

Absorveu o item 1 do "Pendente" abaixo: o log de contagem (`INSERT INTO CONDET`) passa de um `INSERT` por chamada para `INSERT ... SELECT` dirigido por `BALZER`, uma passada para a rodada. Era o termo dominante do tempo de parede (~23 dos ~24 minutos medidos com 2.100 linhas), maior que a gravação do documento `AJ` já reduzida 70% pelos mecanismos M1-M6.

Testado e validado pelo Willian (2026-08-25): decisão de trazer para o escopo do 456948 em vez de requisito próprio, registrada como D13 em `specs.md`.

## Tarefa 14 — M10: cache de `fGetPesoEspecificoItemGranel` (456948-B)  ✅ CONCLUÍDA (2026-08-25)

**Arquivo:** `untFuncoesGenerica.pas` — `pLigaCachePesoEspGranel`/`pDesligaCachePesoEspGranel`, dicionário `VS_dicCachePesoEspGranel` chaveado por `strCodIteGranel|strCodCor`. Armado só pela gravação do balanço, mesmo padrão de D8/M6. Não re-deriva a lógica para SQL (D4 continua valendo).

## Tarefa 15 — M9: `pSetValoresAntigos` lê `CADLOT` com lote (D12)  ✅ CONCLUÍDA (2026-08-25)

**Arquivo:** `untConDet.pas`. Achado do Willian: sem a branch `blnTemLote := Not fEmptyStr(FNumLot)`, o log de contagem gravava `DET_SALDOS`/`QTEF_*`/`SALFIS` a partir de `ITEGER` mesmo quando a divergência era de lote. Comportamento correto portado da cópia `.150`. Correção de dados, mesma classe do M3.

---

## Integração das correções do trunk  ⏳ EM ANDAMENTO (2026-08-20)

O Willian apontou 10 revisões do trunk `379.48.2.30.74.150` que precisavam estar nesta
refatoração. Conferi comparando as linhas adicionadas por cada revisão contra o `BASE` do
branch (`ferramentas/confere_revisoes.py`): **seis não estavam**.

| Revisão | Req | Antes da integração |
|---|---|---|
| 463674 | 430459 | Ausente — temporárias de contagem, `fZeraContagemLote` com filtro, `fGravaConDetZeraContagemLote` |
| 463916 | 430459 | Ausente |
| 478453 | 444280 | Ausente — 119 de 128 linhas; é a correção de performance desta mesma rotina |
| 478688 | 444280 | Ausente |
| 479006 | 445729 | Presente |
| 482822 | 449265 | Presente |
| 484029 | 445886 | Ausente |
| 484382 | 445886 | Ausente |
| 485345 | 452023 | Presente |
| 486400 | 452698 | Presente |

O branch nasceu de `.45.C@487690`, não do trunk — a data de cópia enganava.
`untBalancoEstoqueGravar.pas` tinha **3.340 linhas contra 3.842 do trunk**.

### Como foi integrado

`svn merge -c 463674` conflitou em três arquivos, dois deles (`untConDet.pas`,
`untCadLote.pas`) **sem nenhuma alteração minha** — prova de que a divergência é do branch,
não da refatoração.

- `untCadLote.pas` — 2 conflitos, ambos de recuo; o lado do branch já continha o do trunk e
  mais (ramo do `AUTINC`, checagem de `RowsAffected`). Ficou o do branch.
- `untConDet.pas` — o branch tinha tirado `untFuncoesGenerica` do `uses`; ficou a forma do
  trunk, com `untConstantes`, que as constantes `TMP_*` da r463674 exigem.
- `untBalancoEstoqueGravar.pas` — 9 conflitos, e não de recuo: a r463674 reestruturou
  `fGravar` e `pZeraItem`. Resolver por hunk produziria híbrido. **Adotada a versão do trunk
  por inteiro**, decisão do Willian, sustentada por duas medições: nada depois da r486400
  toca o arquivo no trunk, logo o HEAD é o acumulado das 10 revisões; e das 86 linhas
  exclusivas do branch, **todas** são formas antigas de linhas que o trunk reescreveu —
  nenhuma funcionalidade exclusiva.
- `untConDet.pas` precisou da r478688 aplicada à mão: o `svn merge --record-only` das cinco
  revisões restantes registra sem aplicar, e essa revisão também mexia nesse arquivo.

Conferência final: de 244 linhas ausentes para 15, todas superadas por revisão posterior e
verificadas uma a uma — as duas de `lblGravando.Caption` estão no arquivo (falso negativo de
acento), `AItem.FLocFis` está na forma da r484382 (`<>` e não `=`), e o
`LLC_LOCFIS AS LOCFIS` da r463674 foi reescrito depois. O arquivo é byte a byte igual ao
trunk.

### O que isso custa à refatoração

`untBalancoEstoqueGravar.pas` voltou ao estado do trunk, então **nenhum dos mecanismos está
aplicado nele**. Os outros quatro arquivos (`untMovGer.pas`, `untTypesSistema.pas`,
`untFuncoesSimples.pas`, `untTBatchSQL.Helper.pas`) mantêm as alterações — as 6 revisões não
os tocam.

O estado anterior está inteiro em `diffs/estado-antes-do-merge.diff`, em
`diffs/refatoracao-balanco.diff` (só este arquivo) e em `backup-pre-merge/`.

Todos os conjuntos de edição abortam contra a base nova, o que era esperado: as âncoras são
do código antigo. Reaplicar é refazer as âncoras mecanismo a mecanismo.

### O que muda nos mecanismos, já levantado

- **A chamada passou de `fGravaMovDetSimplificada` para `fGravaMovDet` direto.** O M4 fica
  mais simples: o `ABatch: TBatchSQL = Nil` já está em `fGravaMovDet`, então basta passá-lo.
  E o defeito do `TMovDetParams` sem `Init` **deixa de existir** — ele só aparecia porque a
  chamada passava pelo record.
- **`fConfirmaAjuste` não abre mais transação própria** — a r463674 subiu o
  `fStartTransaction` para `fGravar`. O M6 passa a ter um único ponto de armar e desarmar.
- **As exceções agora são relançadas** (`Raise Exception.Create(E.Message +
  ' [fConfirmaAjuste]')`) em vez de engolidas. O M7 precisa ser reavaliado: pode estar
  parcial ou totalmente resolvido pela r463674.
- **`pZeraItem` ganhou `AstrAutIncConDet`, `AblnOpLoteJaFeita` e `AblnSkipConDet`**, e passou
  a ser chamada por `fZeraItens` em fases. O M2 e o M2b precisam ser repensados contra esse
  desenho — parte do que eles faziam pode já estar lá.
- **A BASE do teste de equivalência perdeu a validade.** Ela foi capturada no código antigo;
  precisa ser recapturada nesta base antes de qualquer nova comparação.

---
## Estado ao encerrar — 2026-08-20

### Medições

Massa funcional, 280 linhas (40 itens x 7 lotes), `CFG_ITEDOC = 20`:

| Etapa | Comandos no `LOGREP` | vs BASE |
|---|---|---|
| BASE mesclada | 2.064 | — |
| +M6 +M3 | 2.010 | −3% |
| +M4 +M5 +Q8 | 1.172 | −43% |
| +M1b | **614** | **−70%** |

Massa de volume, 2.100 linhas (300 itens x 7 lotes), `CFG_ITEDOC = 500`, 5 documentos:
**4.373 comandos**, 2,08 por linha — mesma proporção da massa pequena, então os
mecanismos escalam.

Conferência funcional em ambas: **100%**. Na de volume, 2.100/2.100 em saldo, contagem
zerada e `LOT_QTDAJU`. Diff coluna a coluna sem divergência em `MOVDET`, `MOVTRI`,
`MOVAUX` e `LGCEST`; só `ITE_QTDAJU` e `LOT_QTDAJU`, que são as correções do M3.

### O achado que muda o enquadramento do requisito

**A rodada de 2.100 linhas levou 24 minutos — praticamente a queixa original — mesmo com
70% menos comandos. O gargalo nunca foi o número de comandos de gravação do documento.**

Medido na janela de 5 minutos no meio da rodada, só a conexão do ERP:

| | |
|---|---|
| Linhas de `CONDET` na rodada inteira | 4.485 |
| Transações abertas na janela | 491 |
| `INSERT INTO CONDET` na janela | 982 |
| Statements do ERP na janela | 10.802 |
| **Statements por transação** | **22, para 2 inserts úteis** |

Cada `fRetAutoIncrem` cai em `fRetAutoIncremFireDac`
(`untFuncoesSimples.pas:9520`), que abre **conexão e transação próprias**. Daí a
sequência que se repete 491 vezes: `SELECT CONNECTION_ID()`, `SET SQL_AUTO_IS_NULL`,
`SET SESSION TRANSACTION ISOLATION LEVEL`, `SHOW INDEX FROM PROINC`, `BEGIN`,
`UPDATE PROINC`, commit, mais o par `INSERT`/`DELETE` em `TRANSACOES` do log de
transação. O isolamento é correto por desenho — o contador não pode ficar preso na
transação longa — mas está sendo pago por linha em vez de por bloco.

A conta fecha sozinha: 2.242 transações x 22 statements x 28 ms ≈ 23 minutos, que é a
rodada inteira.

**Os 28 ms por ida também pesam.** A estação está em 10.249.2.216 e o banco em
10.0.0.44. Em rede local seriam ~1 ms e a rotina cairia sozinha. Confirmar se o cliente
tem a mesma separação antes de atribuir tudo ao código.

**Consequência para o requisito:** os 70% cortados são reais e estão na gravação do
documento AJ. Não são o que produz os 20 minutos. O tempo está no log de auditoria da
contagem.

### Mecanismos — estado final

| Mecanismo | Estado |
|---|---|
| M6 — cache do `@VS_ID_TRANSACAO` | Aplicado. 1.708 `SELECT @VS_ID_TRANSACAO` viraram 1 |
| M3 — `fMarcaAju*` e `fAjusteQtd*` fora do laço | Aplicado. Corrige 260 lotes e 11 itens |
| M4 — `TBatchSQL` no `MOVDET` | Aplicado. `MOVDET` de 280 comandos para 2 |
| M5 — pré-carga dos valores de `ITEGER` | Aplicado. 280 aberturas viraram 1 |
| Q8 — notificação de saldo mínimo adiada | Aplicado. ~840 statements a menos, e avalia o saldo final em vez de parciais |
| M1b — lote de saldos por `TBatchSQL` | Aplicado. 560 comandos viraram 4 |
| Descarga parcial dos lotes | Aplicado. Necessário com `CFG_ITEDOC` alto — o cliente usa 9999 |
| M2, M2b | **Superados pelo trunk.** `fZeraItens` Fase 1 já faz `UPDATE ITEGER` / `DELETE LOCCON` / `DELETE HISBAL` em blocos de 1.000 sobre lista deduplicada |
| M7 — atomicidade | **Resolvido pela r463674.** Transação única em `fGravar` com `Result` propagado |

### Por que o M1 virou M1b

O M1 ligava `AUsarBatchSaldos` e contava com o `objBatchReprocessarSaldo`. Medido: não
economizou **nada**. `TBatchReprocessarSaldo.Execute`
(`untFuncoesGenerica.pas:14022`) faz `for intIdx := 0 to LLisForExecute.Count - 1 do`
— um `ExecSQL` por comando. O ganho dependia do `pUnifica` colapsar 280 em 40, e ele
não colapsa porque a quantidade difere em cada linha.

**Isto vale além deste requisito:** quem usa `AUsarBatchSaldos` acreditando que agrupa —
o faturamento usa, em `untFuncFat.pas:10898` — não está ganhando nada.

### Arquivos alterados

| Arquivo | O quê |
|---|---|
| `util/operacoesrefitens/untBalancoEstoqueGravar.pas` | M6, M3, M4, M5, Q8, M1b, descarga parcial; versão do trunk adotada no merge |
| `genericos/untFuncoesSimples.pas` | Cache do ID de transação, lote de saldos, `fMascaraSaldoBalanco` |
| `faturamento/untMovGer.pas` | `ABatch` em `fGravaMovDet` e conversão dos cinco `Post` |
| `genericos/untTypesSistema.pas` | `ABatch` em `TMovDetParams` — alterado pelo Willian |
| `genericos/BatchSQL/untTBatchSQL.Helper.pas` | `PostOuAcumula` |
| `cadastros/untCadIte.pas` | Uma linha: desvio para o lote de saldos |
| `cadastros/untCadLote.pas` | Idem |
| `cadastros/untConDet.pas` | Vieram do merge das 6 revisões, **mais** M8 (Tarefa 13) e M9 (Tarefa 15) |
| `cadastros/untICadLote.pas`, `genericos/untConstantes.pas` | Vieram do merge das 6 revisões |
| `genericos/untFuncoesGenerica.pas` | M10 (Tarefa 14) |
| `genericos/BatchSQL/untTBatchSQL.pas` | M11 — `OwnsQuery` (Tarefa 13) |

**Não são deste requisito e precisam sair antes do commit:**
`financeiro/contasareceber/untBaixaReceber.pas` e `.dfm` aparecem modificados e não foram
tocados por este trabalho.

**No banco de teste:** `CFG_ITEDOC` da empresa 001 foi de 20 para 500 para a medição de
volume (`testes/10_itedoc_500.sql`). Reverter se a base for reaproveitada.

### Pendente

1. ~~`CONDET` em bloco~~ — **resolvido pela Tarefa 13 (M8), trazido para o escopo deste requisito (D13)**, 2026-08-25.
2. ~~`LOT_QTDAJU`~~ — **resolvido pelo M3** (Tarefa 5) na versão refatorada; a versão atual de produção continua com o defeito até este requisito ser commitado.
3. **`TBatchReprocessarSaldo` não agrupa** — avisar quem cuida do faturamento. Fora do escopo deste requisito, achado colateral.
4. **Statements com filtro por `thread_id`** — as contagens de statement registradas
   antes da rodada de volume estão contaminadas pelos scripts de snapshot, que rodam na
   mesma janela do general log. Só a contagem de comandos está confiável.
5. ~~`specs.md` ainda descreve a base anterior ao merge~~ — **atualizado em 2026-08-25** com D12, D13, M8-M11 e §8.4 (referência final).
6. Diff consolidado e mensagem de commit para o DelphAI — **ainda pendente**. Conferir antes de gerar: `padra_atualizado\opcoes.ini` e `padra_atualizado\rev.inc` aparecem modificados em `svn status` e não são deste requisito — excluir do diff final.

---
## Ordem de reversão

Se algo quebrar e for preciso voltar, os passos são independentes e reversíveis nesta ordem inversa: 11, 10, 9, 7, 6, 5, 4. Cada `IA/456948/diffs/NN-*.diff` é o ponto de retorno. Para reverter um passo isolado:

```bash
svn revert padra_atualizado/fontes/<arquivo>.pas
# reaplicar os diffs anteriores na ordem
```

M6 (Tarefa 4) é o único que afeta código fora do balanço. Se houver qualquer dúvida sobre `LOG_IDTRAN`, é o primeiro a reverter.
