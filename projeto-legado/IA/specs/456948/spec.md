# Especificação — Req. 456948

**Título:** Porte das otimizações de gravação do Balanço de Estoque por Ajuste da versão .63 para a 150_c
**Objetivo:** reduzir o tempo de gravação do Balanço de Estoque por Ajuste e impedir que as tabelas principais (`ITEGER`, `CADLOT`, `CONDET`, `MOVDET`) fiquem em transação por tempo prolongado, trazendo para a `379.48.2.30.74.150_c` o conjunto de medidas já implementado e medido na `379.48.2.30.74.150.45.63`.
**Zona:** Legado (`padra_atualizado/fontes/`)
**Data:** 2026-08-27

## 1. Contexto / problema atual

> **Decisão de escopo (Willian, 2026-08-27):** a análise dos dados e a medição de desempenho **não são refeitas**. Foram feitas, medidas e aceitas na `.63`, e valem como fonte de verdade. Este requisito é **porte de código**: o que se prova aqui é que cada medida chegou íntegra ao `_c` e que nada que só existe no `_c` foi perdido. Consequência: sai a recaptura de baseline, saem as massas de 40 e 2.000 itens, sai o general log, saem `TOQUES_ITEGER` e o diff de colunas, sai a rodada sabotada.

O requisito 456948 foi desenvolvido, medido e fechado na versão `379.48.2.30.74.150.45.63`, em duas partes documentadas em `IA/456948/` (parte A) e `IA/456948-B/` (parte B) daquela versão. O destino `_c` está na revisão 491228 do trunk `379.48.2.30.74.150`; a `.63` fechou na revisão 491014 de um branch fechado.

**Nenhuma das medidas está presente no destino.** Verificação por busca dos símbolos introduzidos pelo requisito em `padra_atualizado/fontes/` do `_c`: `BALZER`, `pCarregaFotoBALZER`, `fVerificaIntegridadeRodada`, `AblnAtualizaIteger`, `fGravaConDetZeraLotesRodada`, `fZeraContagemLoteRodada`, `fGravaConDetZeraItensRodada`, `pAbreMoldesMovDet`, `PostOuAcumula`, `VS_objBatchSaldos`, `INT_DIAS_RETENCAO_BALZER`, `sltItensAtivados`, `pDesligaBatchSaldos`, `AintQuantidade` — todos com zero ocorrências.

### 1.1 Diagnóstico do problema original (herdado da .63)

- A métrica que dominava o tempo é o número de linhas de `ITEGER` tocadas: cada uma custa ~7 statements de trigger.
- `fZeraItens` percorria todas as linhas contadas, não apenas as divergentes, a ~8 round-trips e ~15 statements por linha.
- A gravação de `CONDET` linha a linha era o termo dominante do tempo de parede (~23 de ~24 min).
- `UPDATE CADITE SET ITE_ITEATI = 'S'` saía uma vez por linha em vez de uma por item: 5.677 execuções para 811 itens.
- `UPDATE` sem índice adequado em `ITE_DIGCON` / `LOT_DIGCON` fazia o InnoDB travar tudo que examinava — origem do incidente de 96.570 linhas travadas.
- Escala medida: maior rodada com 19.768 linhas contadas; `ITEGER` com 16.396 itens por empresa.

### 1.2 Por que o patch pronto não serve

O arquivo `C:\Users\willian.gama\Desktop\balanco\balanco150.patch` (6,3 MB, +89.939 / −88.675 linhas) foi gerado contra a revisão 490895 e **não é aplicável**:

| Problema | Evidência |
|---|---|
| Carrega a divergência entre os ramos, não o requisito | `untFuncoesSimples.pas`: 95.409 linhas na `.63` contra 61.629 no `_c`; o trecho desse arquivo ocupa 123 mil linhas do patch. `untFuncoesGenerica.pas`: 14.361 contra 49.799 |
| Inclui arquivos alheios ao requisito | `untDBUtils.pas`, `libFiscalCat42.dproj.local`, `libGNRE.dproj.local`, `MonitorContabil.dproj.local`, `opcoes.ini` |
| Apagaria funcionalidade que só existe no destino | O `untBalancoEstoqueGravar.pas` do `_c` tem o bloco de número de série (`fUsarSerie`, `pGravarProSer`, `pProcessarTmpSer`, `fValidarNumeroSerie`, `fValidarTmpSer`, `pDeletarTmpSer`, `pExcluirProSer`, `pInserirProSer`) que a `.63` não tem — e a `.63` ainda registrou uma edição `ed-13-remove-validacao-serie.json` |

Comparação de métodos de `TfrmBalancoEstoqueGravar` entre as duas versões: 55 comuns, 7 exclusivos da `.63` (`fAplicaAjusteCadLot`, `fAplicaAjusteIteger`, `fVerificaIntegridadeRodada`, `pCarregaBALZERZeramento`, `pCarregaCustoItens`, `pCarregaFotoBALZER`, `pNotificaSaldoAbaixMinimo`), 19 exclusivos do `_c`.

Portanto o porte é **medida por medida**, com os `ed-*.json` e `diffs/vs-baseline/*.diff` da `.63` lidos como especificação de intenção, nunca como patch aplicável.

## 2. Módulos e entidades envolvidos

Módulos: `util/operacoesrefitens`, `cadastros`, `faturamento`, `genericos`.

Units (todas em `padra_atualizado/fontes/`):

| Unit | Medidas a portar |
|---|---|
| `util/operacoesrefitens/untBalancoEstoqueGravar.pas` | M3, M5, M1b, B1, B2, B3, B4, B5, B8, B9, B10b, B11, B14, B15, B16 |
| `genericos/untFuncoesSimples.pas` | M6, M1b, B6 |
| `genericos/BatchSQL/untTBatchSQL.Helper.pas` | M9 (`pPostOuAcumula`) |
| `genericos/BatchSQL/untTBatchSQL.pas` | M11 |
| `faturamento/untMovGer.pas` | M4, B10a, B10b |
| `cadastros/untConDet.pas` | M8, M9, B2, B3 |
| `cadastros/untCadLote.pas`, `untICadLote.pas`, `untCadIte.pas` | B3, B4, B14 |
| `genericos/untConstantes.pas` | B16 |
| `genericos/untTypesSistema.pas` | M4 |
| `genericos/untFuncoesGenerica.pas` | M10 |

Tabelas e chaves:

| Tabela | Chave / campos relevantes |
|---|---|
| `ITEGER` | `ITE_CODEMP` + `ITE_CODITE`; `ITE_DIGCON`, `ITE_ITEATI`, `ITE_DIFERE`, `ITE_DIFGML`, `ITE_SALDOS`, `ITE_SALCON` |
| `CADLOT` | `LOT_CODEMP` + `LOT_CODITE` + `LOT_CODLOT`; `LOT_DIGCON`, `LOT_QTDAJU`, `LOT_SEQAJU`, `LOT_DTAAJU` |
| `CONDET` | detalhe da contagem |
| `MOVDET` / `MOVTRI` / `MOVAUX` | documento gerado; `DET_TIP_FC`, `DET_EMPORI`, `SIM_SEQFDO` |
| `BALZER` | **tabela nova** — foto da rodada; `ZER_CON_ID`, `ZER_DTACAD` |
| `LGCEST` | log da contagem; `PROINC` |
| `CADITE` | `ITE_ITEATI` |

## 3. Requisitos funcionais

- **RF01** — A gravação do Balanço por Ajuste deve produzir exatamente o mesmo resultado gravado que a versão atual do `_c`, para a mesma massa: mesmos documentos, mesmos saldos, mesmos ajustes de lote.
- **RF02** — O ganho de tempo é o já medido e aceito na `.63`, não é remedido aqui (referência registrada lá: rodada inteira de 231 s para 160 s só com B10b; laço de documentos de 201 s para 134 s). O que este requisito tem de garantir é que **cada medida chegou íntegra** ao `_c` — a equivalência de comportamento é o critério, não o cronômetro.
- **RF03** — As escritas em `ITEGER`, `CADLOT` e `CONDET` devem passar a ser em lote / set-based, reduzindo o tempo em que essas tabelas ficam sob lock de transação.
- **RF04** — A rodada deve ter verificação de integridade própria (B9), com rollback completo em caso de falha: zero documento gravado, saldo intocado, contagem preservada.
- **RF05** — A `BALZER` deve ter política de retenção, apagando foto com mais de `INT_DIAS_RETENCAO_BALZER` dias.
- **RF06** — Todas as funcionalidades que existem hoje só no `_c` devem continuar funcionando, em especial o bloco de número de série do balanço.
- **RF07** — As funções alteradas que são usadas fora do balanço (`fRetSequencial`, `fGravaMovDet`, cache do `@VS_ID_TRANSACAO`, batch de saldos) devem manter o comportamento atual quando chamadas pelos demais fluxos do ERP.

## 4. Regras de negócio

- **RN01 — `fRetSequencial` com bloco (B6):** `AintQuantidade: Integer = 1`; com o valor default o corpo executado é byte a byte o de hoje. O balanço reserva `intQtdDoc` números de `PRO_AJ` (e de `PRO_ML` quando `blnAjuGra`) em uma chamada e distribui em memória. Risco aceito e decidido: rodada abortada queima o bloco reservado — buraco na numeração não é problema fiscal, repetição seria.
- **RN02 — toque redundante em `ITEGER` (B4):** parâmetro `AblnAtualizaIteger: Boolean = True`; o balanço passa `False`. Os seis campos e os seis valores do ramo `blnLimpar = True` são idênticos aos que a Fase 1 grava em lote — conferir campo a campo no `_c` antes de suprimir.
- **RN03 — ordem das fases de `fZeraItens`:** Fase 0 antes da Fase 1; na Fase 2, a etapa 2a antes da 2b. A conversão para set-based não pode reordenar.
- **RN04 — `LOT_QTDAJU` / `LOT_SEQAJU` / `LOT_DTAAJU`:** somente `fAplicaAjusteCadLot` / `fAplicaAjusteIteger` escrevem nesses campos. O zeramento não escreve neles. Asserção mecânica sobre o diff final.
- **RN05 — retenção da `BALZER` (B16):** corte por `ZER_DTACAD < :DTALIM`, com `DTALIM = Int(fNow) - INT_DIAS_RETENCAO_BALZER`. **Nunca `CURRENT_DATE` do servidor** — é um `DELETE`, e relógio adiantado apagaria foto dentro da janela. Como `ZER_DTACAD` é `DATE` e a comparação é `<`, a janela efetiva é de 8 dias para retenção de 7.
- **RN06 — `pAtivaItem` (B14):** a ativação de item deve ocorrer uma vez por item, não por linha. Deduplicação por `TStringList` ordenada com `dupIgnore`, `Clear` por gravação e `FreeAndNil` no `FormDestroy`. A guarda lê `ITE_STATUS` do dataset já carregado.
- **RN07 — batch de `MOVDET` (M4):** com o lote ativo, nenhuma escrita em tabela filha de `MOVDET` pode ficar fora dele. Nem todo `Post` é inserção — classificar cada ponto antes de acumular.
- **RN08 — desarme do batch de saldos (review Achado 4):** `VS_objBatchSaldos` é variável **global**. Todos os pontos de saída de `fGravar`, inclusive os `Exit` antecipados (trava de outra estação; falha do log da contagem) e o `Except`, devem passar por `pDesligaBatchSaldos` (idempotente) no `Finally`. Sem isso, todo `UPDATE` de saldo do ERP inteiro passa a entrar num lote que nunca é executado.
- **RN09 — `fDeveZerarItem` (review Achado 1):** a função existe no `_c` e foi removida na `.63`. O gate deve ser predicado do próprio `UPDATE` em `fZeraContagemLoteRodada`, valendo só para o zeramento de contagem de lote — **não** para a pipeline inteira (Fase 0, Fase 1 e carga da `BALZER`). O critério original compara `strLocFis = ''`; a inversão para `<> ''` é defeito. Não aparece em teste em cliente com multi-localização desligada.
- **RN10 — leitura após `Cancel` (review Achado 2):** `TBatchHelper.PostOuAcumula` termina em `Cancel` quando o balanço está acumulando; leituras de campo do dataset depois desse ponto são inválidas e precisam vir de antes.
- **RN11 — `DisableControls` (B15):** `fVerificaSeTemDiferencasParaGravar` percorre o dataset com `First`/`Next` e roda antes do `DisableControls` do bloco seguinte. Exige `try..finally` — o `Exit` e o `Break` sairiam sem reabilitar. `FieldByName` fora do laço.
- **RN12 — guarda de chave vazia (B10a):** antes de consultar `MOVTRI.DET_EMPORI` e `FATSIM.SIM_SEQFDO`, testar chave vazia. Equivalente ao comportamento atual, porque a guarda que vem depois já descartava o resultado.
- **RN13 — molde de dataset (B10b):** os datasets reaproveitados de `untMovGer.pas` vivem apenas entre `pAbreMoldesMovDet` e `pFechaMoldesMovDet`; fora dessa janela ficam `Nil` e `fGravaMovDet` cria e abre os próprios datasets como hoje. O `Finally` libera só o que a própria chamada criou. `BRIDET` fora do escopo.
- **RN14 — `PROINC` da `LGCEST` (B11):** o `UPDATE PROINC + 1` embutido por linha sai; a reserva de bloco por `+ N` já é feita por `fRetAutoIncremFireDac`. Confirmar no `_c` qual caminho o cliente usa (`CFG_FDGINC`).
- **RN15 — cache de `fGetPesoEspecificoItemGranel` (M10):** armado somente na janela da gravação do balanço; desarmado em todos os pontos de saída.

## 5. Requisitos técnicos / não-funcionais

- **Encoding:** `untBalancoEstoqueGravar.pas` é latin-1 + CRLF; `untFuncoesSimples.pas` é UTF-8 com BOM. Conferir arquivo por arquivo antes de editar no `_c` — não assumir o encoding da `.63`. Editar por ferramenta byte-safe (`edita_pas.py`).
- **Transação:** o objetivo central é encurtar a janela de lock nas tabelas principais. Toda medida que trocar N escritas por uma em lote precisa ter o ponto de flush explícito definido, e o flush deve ocorrer antes de qualquer leitura que dependa do que foi escrito (caso conhecido: flush antes da auditoria de saldo aplicado).
- **DDL:** `BALZER` mais os índices `idx_balzer_dtacad`, `idx_iteger_digcon (ITE_CODEMP, ITE_DIGCON)` e `idx_cadlot_digcon (LOT_CODEMP, LOT_DIGCON)`. **DDL não replica pelo `LOGREP`** — tem de ser criada também na réplica, senão o `UPDATE ... JOIN BALZER` replicado falha lá. Bloqueia B2 e B3.
- **Escopo de risco:** M6 (cache do `@VS_ID_TRANSACAO`), B6 (`fRetSequencial`), M4/B10b (`fGravaMovDet`) e o batch de saldos afetam o ERP inteiro, não só o balanço.
- **Pre-commit SVN:** sem `StrToFloat`/`StrToFloatDef`, `Now()`, `.SetFocus`, `TBitBtn`/`TButton`, `Application.CreateForm`, `TDBGrid`, `TClientDataSet`, `dxSkin*`, `FOREIGN_KEY_CHECKS`. SQL por `ParamByName()`, nunca concatenação.
- **Compilação:** projeto `autcom.dproj`, só pelo Willian.

## 6. Critérios de aceitação

- [ ] Todos os 14 símbolos listados em §1 presentes no `_c`, nas units da tabela de §2.
- [ ] Os 19 métodos exclusivos do `_c` em `TfrmBalancoEstoqueGravar` continuam presentes e íntegros, com o bloco de número de série completo (`fUsarSerie`, `pGravarProSer`, `pProcessarTmpSer`, `fValidarNumeroSerie`, `fValidarTmpSer`, `pDeletarTmpSer`, `pExcluirProSer`, `pInserirProSer`).
- [ ] `autcom.dproj` compila sem erro nem novo warning nas units tocadas.
- [ ] Uma gravação de balanço concluída com sucesso no `_c` depois do porte, com o resultado conferido na tela: documentos gerados, saldos e ajustes de lote conforme esperado.
- [ ] Cada medida portada tem, no seu diff isolado, o símbolo esperado no lugar esperado, e o diff foi conferido contra a intenção registrada na `.63`.
- [ ] `LOT_QTDAJU` / `LOT_SEQAJU` / `LOT_DTAAJU` escritos somente por `fAplicaAjusteCadLot` / `fAplicaAjusteIteger` — asserção sobre o diff final.
- [ ] Fluxos fora do balanço validados: uma venda, uma devolução e uma compra gravadas com sucesso (cobre `fRetSequencial`, `fGravaMovDet` e o cache do `@VS_ID_TRANSACAO`).
- [ ] Grid responde normalmente depois de uma gravação e depois de uma saída por `Exit`.
- [ ] Diff final contém somente as units da tabela de §2 — nenhum `.dproj.local`, nenhum `opcoes.ini`, nenhum `rev.inc`, nenhum `untDBUtils.pas`.

## 7. Fora de escopo

- Medidas avaliadas e descartadas na `.63`, que não são portadas: **B7** (reaproveitar `qryGen` em `fGravaLogContagemEstoque` — os três conjuntos são disjuntos ou não coincidentes; a redundância real exigiria duplicar em Pascal um critério que hoje existe só em SQL, e não se faz sem medir antes), **`pAtualizaAutoincBalDet`** e **`pFinalizaMapDet`** (`CFG_UCCBEA = 'N'` e coletor desligado neste cliente — não executam, não há como validar), **`pAjustaITEGERSemContagemNaCADLOT` com `LEFT JOIN`** (depende do índice do B13 para valer a pena; reavaliar depois).
- **B12** — prova e blindagem de `LOT_QTDAJU`: ficou aberta na `.63` e continua aberta; a asserção sobre o diff entra, a prova em produção não.
- Remoção de qualquer validação de número de série. A edição `ed-13-remove-validacao-serie.json` da `.63` **não** é portada.
- Refatoração além das medidas — a zona é Legado, não se refatora proativamente.
- Correção de dados históricos de `LOT_QTDAJU`.
- Arquivos do patch que não pertencem ao requisito: `untDBUtils.pas`, `libFiscalCat42.dproj.local`, `libGNRE.dproj.local`, `MonitorContabil.dproj.local`, `opcoes.ini`.

## 8. Dependências e riscos

| Item | Natureza | Tratamento |
|---|---|---|
| DDL de `BALZER` e os três índices na base de teste do `_c` | dependência, bloqueia B2/B3/B9/B16 | criar antes da Fase 4; script vem de `banco/01_cria_BALZER.sql` da `.63` |
| DDL na **réplica** | dependência de infraestrutura | `LOGREP` não replica DDL; sem isso o `UPDATE ... JOIN BALZER` falha na réplica |
| DDL no pacote de atualização do cliente | pendência herdada da `.63` | incluir |
| Divergência de `untFuncoesSimples.pas` (95.409 contra 61.629 linhas) e `untFuncoesGenerica.pas` (14.361 contra 49.799) | risco alto | localizar a função no `_c` antes de editar; não confiar em offset, contexto ou linha da `.63` |
| Bloco de número de série exclusivo do `_c` | risco alto | auditoria explícita de preservação; nenhuma edição de remoção portada |
| M6, B6, M4/B10b e batch de saldos afetam o ERP inteiro | risco alto | portar M6 isolado e validar fora do balanço antes de seguir; testar venda, devolução e compra |
| `CFG_FDGINC`, `CFG_UCCBEA`, `CFG_USATMQ`, `CFG_ITEDOC` podem diferir entre as bases | risco médio | conferir o valor na base de teste do `_c` antes de assumir o caminho de código |
| Sem medição no `_c`, o ganho não é comprovado nesta versão | **risco aceito, decisão do Willian (2026-08-27)** | a análise e a medição da `.63` são fonte de verdade e não são refeitas. Em troca, a conferência se concentra em integridade do porte e equivalência funcional |
| Encoding dos fontes no `_c` pode diferir do da `.63` | risco médio | conferir BOM e terminador por arquivo antes de editar |
| Os 811 itens de `ITE_ITEATI` da réplica do cliente usados nas medições da `.63` | pendência herdada | conferir o zero no fim das medições |
