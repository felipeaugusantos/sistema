# Balanço de Estoque por Ajuste

## Objetivo

Confrontar o saldo de estoque registrado no sistema com a contagem física feita pelo cliente e
gravar a diferença. O resultado da gravação é um conjunto de **documentos fiscais de ajuste**
(entrada ou saída, conforme a diferença seja positiva ou negativa), a movimentação de estoque
correspondente em item e lote, e a baixa da contagem (as marcações de "contado" são consumidas
para que o mesmo saldo não seja ajustado duas vezes).

A rotina é executada em bloco, no fim do inventário: uma rodada típica processa de 800 a 20.000
linhas contadas, e o maior caso já registrado nesta base é de 19.768 linhas.

## Zona e localização

- **Zona:** Legado
- **Tela de gravação:** `padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas` (+ `.dfm`)
- **Caminho no menu:** Útil > Operações Referentes a Produtos > Balanço de Estoque por Ajuste > Gravação da Contagem
- **Quem abre a tela:** `padra_atualizado/fontes/Util_DLL/OpeRefProd/untOpeProd.pas:452` — `pCriarFormularios(TfrmBalancoEstoqueGravar, frmBalancoEstoqueGravar)`
- **Compilação:** a unit é carregada pelo `autcom.dproj`. **Não** é carregada por `libOpeRefProd.dproj`.

### Units da rotina

| Unit | Papel | Documento |
|------|-------|-----------|
| `untBalancoEstoqueGravar` | Tela e orquestração da gravação | [untBalancoEstoqueGravar.md](untBalancoEstoqueGravar.md) |
| `untCadIte` | Atualização do saldo do item (`fAtualizaEstoqueCadIte`) | [../untCadIte.md](../untCadIte.md) |
| `untCadLote` | Zeramento da contagem de lote (`fZeraContagemLote*`) | [../untCadLote.md](../untCadLote.md) |
| `untICadLote` | Interface de `TCadLot` | [../untICadLote.md](../untICadLote.md) |
| `untConDet` | Log de contagem (`CONDET`) | [../untConDet.md](../untConDet.md) |
| `untMovGer` | Geração do documento fiscal (`fGravaMovGer` / `fGravaMovDet`) | [../untMovGer.md](../untMovGer.md) |
| `untFuncoesSimples` | Transação, autoincremento, lotes de saldo, cache de ID de transação | [../untFuncoesSimples.md](../untFuncoesSimples.md) |
| `untTBatchSQL.Helper` | `PostOuAcumula` — acumula insert de dataset em lote | [../untTBatchSQL.Helper.md](../untTBatchSQL.Helper.md) |
| `untTypesSistema` | Record `TMovDetParams` | [../untTypesSistema.md](../untTypesSistema.md) |
| `untConstantes` | Constantes de trava e de tabelas temporárias | [../untConstantes.md](../untConstantes.md) |

Units auxiliares somente-leitura no fluxo: `untHistoricoBalanco` (histórico de saldo),
`untAuditoriaGravacaoSaldo` (auditoria opcional), `untControleContagemBalancoEstoque`,
`untBalancoEstoqueManutencao`, `untRelBalancoEstoqueDiferenca` (relatório de diferença),
`untGeraTransferencia` (ajuste negativo virando transferência).

## Telas

| Tela (form) | Unit | Função |
|-------------|------|--------|
| `TfrmBalancoEstoqueGravar` — "Balanço de Estoque - Gravação" | `untBalancoEstoqueGravar` | Filtra o conjunto contado, exibe a divergência item a item e grava o ajuste |

Filtros do cabeçalho: localização inicial/final, linha/grupo, fornecedor, produto, marca,
departamento, unidade, grupo de produto. O grupo **Operador da Contagem** (operador, data/hora
início e fim) só aparece quando `CFG_BEFOCD = 'S'` e o cliente não usa WMS.

Grid `dbgItens`: Código, Descrição, Lote, Unid., Saldo, Contagem, Diferença, Saldo (G/ml),
Contagem (G/ml), Difer. (G/ml), Status, Loc. Física.

Botões:

| Botão | Atalho | O que faz |
|-------|--------|-----------|
| Confirma | F10 | Aplica os filtros e carrega o grid com as divergências |
| GRAVAR CONTAGEM PARA ATIVOS | F2 | Grava o ajuste apenas dos itens ativos (`opcAtivos`) |
| ATIVAR ITENS INATIVOS E GRAVAR CONTAGEM | F1 | Ativa os itens inativos encontrados e grava tudo (`opcAtivar`) |
| IMPRIMIR INATIVOS | F3 | Só imprime a lista de itens inativos, não grava |
| Confirma Sem Divergencias | — | Efetiva as linhas contadas **sem** diferença: consome a contagem sem gerar documento |

## Fluxo principal

1. Operador filtra e confirma (F10) — `pBuscaItens` monta o SQL de `fRetSQLItens` e carrega o grid.
2. Operador aciona F1 ou F2 — `btnGravaTodosClick` / `btnGravaAtivosClick` definem `opcGravacao`
   e chamam `fGravar`.
3. `fGravar`, na ordem:
   1. `FItemZeraList.Clear` — obrigatório; a lista vive de `FormCreate` a `FormDestroy` e sem o
      `Clear` a segunda gravação da mesma sessão pularia o zeramento da primeira.
   2. `pCarregaCustoItens` — pré-carrega custos de `ITEGER` (leitura pura, fora da transação).
   3. `pLigaBatchSaldos` — arma o lote de saldos.
   4. `fStartTransaction` + `pLigaCacheIDTransacao(fGetConexao)`.
   5. `fLock_Unlock(STR_TRAVA_CONDET)` — trava global da rotina. Se outra estação estiver gravando,
      aborta com mensagem informando o host que detém a trava.
   6. `fGravaLogContagemEstoque` — grava `LGCEST` (foto da contagem, `LOG_EFETIV = 0`).
   7. `pCarregaFotoBALZER` — foto do conjunto contado em `BALZER`, base da conferência final.
   8. `fConfirmaAjuste(False, 'AJ')` — laço de divergências: gera `MOVGER`/`MOVDET` de ajuste e
      atualiza saldo de item e lote.
   9. `fConfirmaAjuste(False, 'ML')` — só quando `CFG_USATMQ = 'S'` (tinta de máquina, saldo em g/ml).
   10. `fConfirmaAjuste(True, 'AJ')` — finaliza a contagem das linhas sem divergência.
   11. `UPDATE LGCEST SET LOG_EFETIV = 1` para os autoincrementos da rodada.
   12. `pDescarregaEDesligaBatchSaldos` — os saldos vão ao banco **antes** da auditoria.
   13. `objAuditoriaSaldo.fValidouTodas` — só efetiva se `CFG_UTAUFA = 'S'` e a function
       `F_AUDITORIA_GRAVACAO_SALDO` existir no schema.
   14. `fZeraItens` — zera a contagem em três fases (item, lote, localização) e grava `CONDET`.
   15. `fVerificaIntegridadeRodada` — cinco conferências; qualquer divergência derruba a rodada.
   16. `fCommit` e mensagem com os documentos de ajuste gerados.
4. `pDesligaCacheIDTransacao` e liberação da trava no `Finally`.

## Fluxos alternativos e exceções

- **Outra estação gravando:** a trava `STR_TRAVA_CONDET` é global. A segunda estação recebe
  "Uma tarefa de balanço está sendo feita em outra estação: `<host>`" e nada é gravado.
- **Falha no meio:** `fRollBack`. `LGCEST` fica com `LOG_EFETIV = 0` e as marcações de contagem
  (`ITE_DIGCON` / `LOT_DIGCON = 'S'`) permanecem — a rodada pode ser **reexecutada** sem recontar.
  O modelo é de reexecução idempotente, não de retomada: nada precisa ser desfeito à mão.
- **Conferência de integridade reprovada:** mensagem "A gravação foi desfeita porque a conferência
  de integridade acusou divergência" + lista dos itens. Rollback completo.
- **Ajuste negativo com transferência:** com `CFG_CCETRA` preenchido, a diferença negativa vira
  transferência para a empresa configurada em vez de ajuste puro.
- **Gravar duas vezes sem fechar a tela:** suportado — desde que `FItemZeraList.Clear` rode no
  início de cada gravação.

## Tabelas envolvidas

| Tabela | Uso | Papel na rotina |
|--------|-----|-----------------|
| `ITEGER` | L/G | Saldo e contagem por item e empresa (`ITE_SALDOS`, `ITE_SALCON`, `ITE_DIGCON`, `ITE_QTDAJU`, `ITE_SEQAJU`). Tem trigger `BEFORE UPDATE` caro: ~6 statements por linha alterada |
| `CADLOT` | L/G | Saldo e contagem por lote (`LOT_SALDOS`, `LOT_SALCON`, `LOT_DIGCON`, `LOT_QTDAJU`, `LOT_SEQAJU`). Sem o trigger de `ITEGER` |
| `LOTLOC` | G | Saldo por lote × localização física (só com mais de uma localização por lote) |
| `LOCCON` | G | Contagem por localização — apagada no zeramento |
| `MOVGER` | G | Cabeçalho do documento de ajuste |
| `MOVDET` | G | Item do documento de ajuste — fonte de verdade do que efetivamente movimentou |
| `MOVTRI`, `MOVAUX`, `MOVREF`, `BRIDET` | G | Filhas de `MOVDET` (tributos, auxiliares, referência) |
| `LGCEST` | G | Log da contagem: saldo anterior por lote, `LOG_CODCON` (identificador da rodada), `LOG_EFETIV` |
| `CONDET` | G | Log de alteração de contagem, por item e por lote |
| `BALZER` | L/G | **Tabela de trabalho da rodada** — foto do conjunto contado; usada pelo zeramento set-based e pela conferência de integridade |
| `BALGER` / `BALDET` / `MAPDET` | G | Mapa de contagem / coletor |
| `HISBAL` | G | Histórico de saldo do balanço |
| `CADITE` | L | Cadastro do produto |
| `PROINC` | G | Autoincrementos (`fRetAutoIncrem`). **Não replica** |
| `CFGSIS` | L/G | Configurações e sequenciais (`CFG_PRO_AJ`, `CFG_PRO_ML`) |
| `LOGREP` | G | Fila de replicação — alimentada pelo SQL Monitor a cada `ExecSQL` |

## Configurações (CFGSIS)

Grupo **AJUSTE DE ESTOQUE**:

| Código | Descrição | Efeito na rotina |
|--------|-----------|------------------|
| `CFG_CLIAJU` | Cliente para Ajuste de Estoque | Cliente usado no documento fiscal de ajuste |
| `CFG_FINAJU` | Finalidade do Ajuste de Estoque | Finalidade gravada no `MOVGER` |
| `CFG_PREAJU` | Preço para Gravação do Ajuste, quando opção pelo preço de venda | Define de qual campo de preço sai o valor do ajuste |
| `CFG_IMPAJU` | Preço para Impressão do Ajuste de Estoque | Preço mostrado na impressão (ex: `TOTCUS`) |
| `CFG_CONACU` | Procedimento quanto à digitação manual da quantidade contada | Contagem acumula ou substitui |
| `CFG_CONEST` | Momento de calcular a diferença de saldo | Define quando a diferença é apurada |
| `CFG_ESTAJU` | Contagem dos itens em garantia não enviados ao fornecedor | Valor 2 muda a composição do saldo comparado |
| `CFG_ESTMAN` | Contagem dos itens em manutenção/conserto | Valor 2 inclui `ITE_SALMAN`/`LOT_SALMAN` no saldo |
| `CFG_DDSGEF` | Com `CFG_ESTAJU = 2`, deduzir saldo de garantia do saldo físico | Combinado com `ESTAJU = 2`, habilita alteração de campos sem tela de garantia |
| `CFG_EMPBAL` | Empresas cujo estoque é somado no cálculo da diferença | Vazio = só a empresa corrente |

Grupo **PRODUTOS**:

| Código | Descrição | Efeito na rotina |
|--------|-----------|------------------|
| `CFG_BEFOCD` | Solicitar filtro adicional por operador, data e hora da contagem (quando WMS = N) | Exibe o grupo "Operador da Contagem" na tela |
| `CFG_UCCBEA` | Utilizar Controle de Contagens no Balanço de Estoque por Ajuste | Liga o controle de contagens |
| `CFG_CADLOC` | Utilizar cadastro de localizações físicas | Habilita a checagem de lote em localização crítica |
| `CFG_CCETRA` | Ajustes negativos — empresa de destino da transferência | Preenchido: a diferença negativa vira transferência |
| `CFG_CCPVGC` | Cliente para PED.VENDA GARANTIA NAO COLETADA | Usado no SQL de garantia não coletada |
| `CFG_LRGMIC` | Liberar geração de Mapa de Inventários para Coletores | Habilita o mapa de contagem por coletor |
| `CFG_ESTEXT` | Utilizar rotina de saldo reservado externo | Entra na composição do saldo comparado |
| `CFG_UTINEM` | Notificar produtos com saldo abaixo do mínimo | Ligado, a notificação roda **depois** da gravação (adiada, não suprimida) |

Grupo **FATURAMENTO**:

| Código | Descrição | Efeito na rotina |
|--------|-----------|------------------|
| `CFG_ITEDOC` | Quantidade máxima de itens por NF-e | Define quantos itens cabem em cada documento de ajuste. Valor baixo (ex: 20) gera centenas de documentos por rodada |
| `CFG_ENTFUT` | Utiliza Entrega Futura | Entra na composição do saldo |
| `CFG_BEFTRG` | Baixar estoque de entrega futura por trigger | Muda o cálculo do saldo de entrega futura |
| `CFG_EFTEST` | Entrega futura de item estrutura | Filtro adicional no saldo pendente |
| `CFG_UTAUFA` | Utilizar auditoria para gravação de dados | Ligado, chama `F_AUDITORIA_GRAVACAO_SALDO` e derruba a rodada se o saldo não bater |

Grupo **AUTTIN**: `CFG_USATMQ` — Usar tinta de máquina. Ligado, roda a segunda passada
`fConfirmaAjuste(..., 'ML')` para o saldo em g/ml.

Grupo **FULFILLMENT**: `CFG_MOVFUL` — tipo de controle de saldo em operação Fulfillment.

Sequenciais lidos de `CFGSIS` via `fRetSequencial`: `CFG_PRO_AJ` (documento de ajuste) e
`CFG_PRO_ML` (documento de tinta de máquina).

## Integrações e dependências

- **Replicação:** cada `ExecSQL` gera uma linha em `LOGREP` pelo SQL Monitor do UniDAC. Comandos
  concatenados são aceitos pelo consumidor da replicação. `PROINC` não replica.
- **Auditoria de saldo:** function de banco `F_AUDITORIA_GRAVACAO_SALDO`, opcional (`CFG_UTAUFA`).
- **Mapa de contagem / coletor:** `BALGER`, `BALDET`, `MAPDET`.
- **Tintométrico:** passada `'ML'` quando `CFG_USATMQ = 'S'`.

## Regras de negócio conhecidas

1. A diferença por lote é `LOT_SALDOS − LOT_SALCON`; positiva gera saída, negativa gera entrada
   (ou transferência, com `CFG_CCETRA` preenchido).
2. `ITE_QTDAJU` é a **somatória do item**; `ITE_SEQAJU` aponta para um dos documentos válidos da
   rodada (`MAX(DET_SEQGER)`). Em nível de lote valem `LOT_QTDAJU`/`LOT_SEQAJU`, derivados do
   próprio lote.
3. A contagem só é consumida quando o ajuste é efetivado — `LOG_EFETIV = 1` é gravado **dentro**
   da mesma transação do efeito.
4. Um item já efetivado não reaparece: a query de divergência só enxerga linhas com `DIGCON = 'S'`.
5. A rotina é exclusiva por trava global (`STR_TRAVA_CONDET`): uma gravação por vez em toda a base.
6. O documento de ajuste é quebrado a cada `CFG_ITEDOC` itens.

## Pontos de atenção

- **Trigger de `ITEGER`:** cada linha alterada dispara ~6 statements (leitura de `CFG_DECUNI`,
  `CALL pSetaVariaveisPreAlt` com 4 SELECT em `REGPRE`, e o log condicional em `ITEGER_LOG_SALDOS`).
  O custo da rotina é dominado por **linhas tocadas**, não por número de comandos. O piso teórico é
  1 toque por item.
- **`CFG_ITEDOC` baixo multiplica documentos** e, na versão anterior ao Req. 456948, multiplicava
  também o defeito de `LOT_QTDAJU` (ver histórico).
- **Ordem obrigatória:** o lote de saldos precisa ir ao banco (`pDescarregaEDesligaBatchSaldos`)
  **antes** da auditoria; caso contrário a auditoria lê o saldo pré-ajuste e derruba a rodada.
- **Ordem obrigatória:** a Fase 0 do zeramento (`CONDET` de item) roda **antes** da Fase 1, que zera
  `ITE_SALCON`/`ITE_DIGCON` — o log precisa do valor anterior.
- **`BALZER` precisa existir no cliente**: entra no pacote de atualização junto com os índices
  `(ITE_CODEMP, ITE_DIGCON)` e `(LOT_CODEMP, LOT_DIGCON)`.
- **Encoding:** `untBalancoEstoqueGravar.pas`, `untCadLote.pas` e `untConDet.pas` são **latin-1 +
  CRLF**; `untFuncoesSimples.pas` é **UTF-8 com BOM**. Editar sempre por script byte-safe.
- **Achado colateral em aberto:** o `CONDET` de zeramento por lote grava `old = 0` e `new = 0` —
  a variação já foi apagada quando ele roda. Corrigir exige mover a gravação para antes do
  zeramento; é requisito próprio, e o defeito é anterior ao Req. 456948.

## Histórico de alterações documentadas

| Data | Requisito/Revisão | Resumo |
|------|-------------------|--------|
| 2026-08-20 | Req. 456948 e 456948-B (alterações locais, não comitadas) | Otimização da gravação. Parte A: lote de saldos, dedup de zeramento por item, ajuste derivado de `MOVDET` fora do laço, `TBatchSQL` no caminho do `MOVDET`, pré-carga de custos, cache do `@VS_ID_TRANSACAO`. Parte B: `TItemZeraList` O(1), zeramento set-based via `BALZER`, supressão do toque redundante em `ITEGER`, bloco de sequenciais por rodada, remoção das temporárias de contagem, conferência de integridade da rodada (`fVerificaIntegridadeRodada`) e molde de dataset reaproveitado em `fGravaMovDet` |



[X] TESTE