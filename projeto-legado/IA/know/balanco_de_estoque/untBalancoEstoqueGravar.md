# untBalancoEstoqueGravar

## Responsabilidade

Tela de gravação do Balanço de Estoque por Ajuste: filtra o conjunto contado, exibe a divergência
entre saldo e contagem e orquestra toda a gravação — documentos fiscais de ajuste, movimentação de
estoque, zeramento da contagem e conferência final — dentro de uma transação única.

## Caminho

`padra_atualizado/fontes/util/operacoesrefitens/untBalancoEstoqueGravar.pas` (~4.372 linhas) + `.dfm`

Encoding: **latin-1 + CRLF**. Editar por script byte-safe; conferir `U+FFFD == 0` depois.

## Comportamento

Form `TfrmBalancoEstoqueGravar`, herda de `TfrmPai`. Instanciado por
`untOpeProd.pas:452` com `pCriarFormularios`. Vive enquanto a tela estiver aberta — vários campos
de estado são criados em `FormCreate` e liberados em `FormDestroy`, e **precisam ser limpos no
início de cada gravação** porque a mesma instância pode gravar mais de uma vez.

A gravação inteira roda em **uma transação** aberta em `fGravar`, sob a trava global
`STR_TRAVA_CONDET`. Tudo que é gravado — documentos, saldos, contagem, log — cai junto no
`fRollBack` se qualquer etapa falhar.

## Configurações que impactam esta unit

| Código CFGSIS | Efeito |
|---------------|--------|
| `CFG_ITEDOC` | `intQtdItens` — quantos itens cabem em cada documento de ajuste. Lido em `FormCreate` |
| `CFG_CLIAJU` | Cliente do documento de ajuste |
| `CFG_FINAJU` | Finalidade gravada no `MOVGER` |
| `CFG_PREAJU` / `CFG_IMPAJU` | `strPreAju` / `strImpAju` — preço de gravação e de impressão |
| `CFG_USATMQ` | Liga a segunda passada `fConfirmaAjuste(..., 'ML')` e altera colunas visíveis no grid |
| `CFG_ESTAJU`, `CFG_ESTMAN`, `CFG_ESTEXT`, `CFG_ENTFUT`, `CFG_BEFTRG`, `CFG_EFTEST`, `CFG_EMPBAL` | Compõem o SQL de saldo em `fRetSQLItens` / `fGetFiltrosSQL` |
| `CFG_DDSGEF` | Com `CFG_ESTAJU = 2`, liga `blnAlteraCamposSemGarTela` |
| `CFG_CONACU` / `CFG_CONEST` | `blnConAcu` / `FintConEst` — acúmulo da digitação e momento do cálculo da diferença |
| `CFG_BEFOCD` | Exibe `grpFilCondet` (filtro por operador/data/hora) quando não usa WMS |
| `CFG_UCCBEA` | `blnUccBea` — controle de contagens |
| `CFG_CADLOC` | Guarda de `fLoteComLocalizacaoCritica`: sem ela, a função sai antes de consultar |
| `CFG_CCETRA` | `strCCETRA` — empresa de destino da transferência em ajuste negativo |
| `CFG_CCPVGC` | Cliente de "ped. venda garantia não coletada" |
| `CFG_LRGMIC` | `blnUtilizaMapaDeContagemColetor` |
| `CFG_MOVFUL` | `strMOVFUL` — controle de saldo em operação Fulfillment |
| `CFG_UTAUFA` | Fora desta unit, mas decide se `objAuditoriaSaldo.fValidouTodas` de fato valida |
| `CFG_UTINEM` | Fora desta unit; ligado, faz `pNotificaSaldoAbaixMinimo` rodar depois da gravação |

## Tabelas

| Tabela | L/G | Onde |
|--------|-----|------|
| `ITEGER` | L/G | `fRetSQLItens`, `pZeraItem`, Fase 1 de `fZeraItens`, `fAplicaAjusteIteger` |
| `CADLOT` | L/G | `fRetSQLItens`, Fase 2 de `fZeraItens` (via `TCadLot`), `fAplicaAjusteCadLot` |
| `BALZER` | L/G | `pCarregaFotoBALZER`, `pCarregaBALZERZeramento`, `fVerificaIntegridadeRodada` |
| `LGCEST` | G | `fGravaLogContagemEstoque`, `pInsertLoteLGCEST`, `UPDATE ... LOG_EFETIV = 1` |
| `MOVGER` / `MOVDET` | G | via `fGravaMovGer` / `fGravaMovDet` de `untMovGer` |
| `CONDET` | G | via `TConDet` |
| `LOCCON` | G | `DELETE` no zeramento |
| `HISBAL` | G | via `THistoricoBalanco` |
| `BALGER` / `BALDET` / `MAPDET` | G | `pAtualizaAutoincBalDet`, `pFinalizaMapDet` |
| `CADITE` | L/G | ativação de item inativo (`pAtivaItem`) |
| `PROINC` | G | `fRetAutoIncrem` |

## Métodos

### Orquestração

| Método | Tipo | O que faz | Efeito colateral |
|--------|------|-----------|------------------|
| `fGravar` | function | Roteiro completo da gravação: trava, log, foto, três passadas de `fConfirmaAjuste`, zeramento, conferência, commit | Grava tudo; abre e fecha a transação |
| `fConfirmaAjuste` | function | Laço de documentos e de linhas: monta o documento de ajuste, chama `fGravaMovGer`/`fGravaMovDet` e atualiza saldo de item e lote | Grava `MOVGER`, `MOVDET` e filhas; atualiza `ITEGER`/`CADLOT` |
| `fZeraItens` | function | Zera a contagem em três fases, em blocos de 1.000 (`CHUNK_SIZE_BATCH`) | Grava `CONDET`, `ITEGER`, `CADLOT`, `LOTLOC`, `LOCCON`, `HISBAL` |
| `pZeraItem` | procedure | Zeramento de uma linha (item, lote, localização) — caminho por linha, ainda usado onde o set-based não alcança | Grava `ITEGER`, `LOCCON`, `CONDET`, lote |
| `fVerificaIntegridadeRodada` | function | Cinco conferências `SELECT` antes do commit; devolve `False` e a lista de divergências | Nenhum — só leitura |
| `btnGravaAtivosClick` / `btnGravaTodosClick` | procedure | Definem `opcGravacao` (`opcAtivos` / `opcAtivar`) e chamam `fGravar` | Podem ativar itens inativos |
| `btnSemDivergenciaClick` | procedure | Efetiva as linhas contadas sem diferença | Consome contagem sem gerar documento |

#### `fZeraItens` — as três fases

| Fase | O que grava | Forma |
|------|-------------|-------|
| Fase 0 | `CONDET` de nível de **item** | 1 `INSERT ... SELECT` dirigido por `BALZER`. **Tem que rodar antes da Fase 1**, porque guarda o valor anterior de `ITE_SALCON`/`ITE_DIGCON` |
| Fase 1 | `ITEGER`, `LOCCON`, `HISBAL` | 3 comandos por bloco de 1.000 itens |
| Fase 2 | `CADLOT`, `LOTLOC`, `CONDET` de **lote** | 4 comandos por bloco, via `TCadLot.fZeraContagemLoteRodada`. **Não toca `ITEGER`** — a Fase 1 já gravou o mesmo estado |

Cada passada set-based reserva o próprio bloco de autoincremento de `CONDET`, dimensionado pelo
`COUNT` que ela mesma faz.

#### `fVerificaIntegridadeRodada` — as cinco conferências

| | Verificação | Base |
|---|-------------|------|
| V1 | `CADLOT.LOT_SALDOS` = `LGCEST.LOG_SALOLD` + Σ movimento de `MOVDET` da rodada, por lote | foto `LGCEST` |
| V2 | Idem em `ITEGER.ITE_SALDOS`, por item | foto `LGCEST` |
| V3 | `ITE_SALDOS` = Σ `LOT_SALDOS` do item | independente da foto |
| V4 | Nenhuma contagem residual (`DIGCON = 'S'`) nas linhas de `BALZER`; todo `MOVGER` da rodada tem `MOVDET` | independente da foto |
| V5 | Cobertura: linhas de `BALZER` sem par em `LGCEST` | mede o buraco de cobertura |

Qualquer contagem maior que zero acumula em `AstrErros`, devolve `False` e `fGravar` faz
`fRollBack`. Os parâmetros são atribuídos por `pSeta`, que checa `Params.FindParam` antes — nem
toda consulta usa `CONID`, `CODCON` e `CODEMP`, e `ParamByName` em parâmetro inexistente levanta
exceção.

**O que V1/V2 pegam que nada mais pegava:** `fAtualizaEstoqueCadIte` engole a exceção e devolve
`Result := False`, e o `Result` era sobrescrito no documento seguinte — documento fiscal emitido,
estoque não movimentado, contagem consumida. A conferência não depende de `Result` sobreviver ao
laço: compara o estado gravado com o esperado, no fim.

### Ajuste e foto da rodada

| Método | Tipo | O que faz |
|--------|------|-----------|
| `fAplicaAjusteIteger` | function | Uma passada, após o laço: `UPDATE ITEGER ⋈ (SELECT ... FROM MOVDET GROUP BY item)` gravando `ITE_DTAAJU`, `ITE_SEQAJU` (`MAX(DET_SEQGER)`) e `ITE_QTDAJU` (somatória) |
| `fAplicaAjusteCadLot` | function | Análogo por lote, agrupando por item + `DET_NUMLOT`, **com** restrição por item |
| `pCarregaFotoBALZER` | procedure | Grava em `BALZER` a foto do conjunto contado, antes de qualquer alteração — base de V1/V2 |
| `pCarregaBALZERZeramento` | procedure | Carga de `BALZER` que dirige as passadas set-based de `fZeraItens`; blocos de 500 `INSERT` concatenados |

`BALZER` é chaveada por `ZER_CON_ID` (o `CONNECTION_ID()` da sessão, gravado como literal) +
`ZER_CODCON` (a rodada) + item/lote, e é apagada no início e no fim da rodada, dentro da transação.

### Consulta e montagem de SQL

| Método | Tipo | O que faz |
|--------|------|-----------|
| `fRetSQLItens` | function | Monta o SELECT do conjunto contado; ramifica por `CFG_ESTAJU`, `CFG_ESTMAN`, `CFG_ESTEXT`, `CFG_ENTFUT`, `CFG_BEFTRG` e por localização física |
| `fGetFiltrosSQL` | function | Filtros do cabeçalho da tela |
| `fSQLItensSemNecessidadeCalculoEmpBal` | function | Itens sem divergência quando há `CFG_EMPBAL` |
| `fSqlTabelaQuantidadePendente` | function | Quantidade pendente (entrega futura) |
| `fTabPreco` / `fTabPrecoImp` | function | Campo de preço conforme `CFG_PREAJU` / `CFG_IMPAJU` |
| `fTrataCampoSalExt` | function | Tratamento do saldo reservado externo |
| `fCalcTotais` | function | Totaliza o documento e decide se gera `MOVGER` |

### Log e contagem

| Método | Tipo | O que faz |
|--------|------|-----------|
| `fGravaLogContagemEstoque` | function | Grava `LGCEST` com a foto da contagem (`LOG_EFETIV = 0`); devolve `LOG_CODCON` da rodada |
| `pInsertLoteLGCEST` | procedure | Insere `LGCEST` em blocos de `INSERT` concatenados |
| `pAtualizaAutoincBalDet` | procedure | Acumula (item, autoincremento) e aplica set-based por documento |
| `pFinalizaMapDet` | procedure | Finaliza o mapa de contagem do coletor |

### Estado e apoio

| Método | Tipo | O que faz |
|--------|------|-----------|
| `FormCreate` | procedure | Lê as configurações, cria `FItemZeraList`, `dicCustoItem`, as `TStringList` de estado e as queries |
| `FormDestroy` | procedure | Libera tudo que `FormCreate` criou |
| `pCarregaCustoItens` | procedure | Pré-carrega `ITE_PRECUS`, `ITE_PREMED`, `ITE_PREULT`, `ITE_IMPULT`, `ITE_CNV_ML` num `TDictionary<String, TdtoCustoIteGer>` — substitui a reabertura de `qryIteGer` por linha |
| `fLoteComLocalizacaoCritica` | function | Diz se o par (item, lote) está em localização crítica. Sai imediato se `CFG_CADLOC = 'N'`; usa `FintTemLocCritica` (−1 = não avaliado) e dicionário pré-carregado |
| `pNotificaSaldoAbaixMinimo` | procedure | Notificação de saldo mínimo, **adiada** para depois da gravação |
| `pAtivaItem` | procedure | Ativa item inativo (caminho F1) |
| `fGeraTransferenciaItem` | function | Ajuste negativo virando transferência, com `CFG_CCETRA` |
| `fIncluiPedido` | function | Pedido gerado a partir do ajuste |
| `fDeveZerarItem` | function | Filtro do que entra no zeramento |
| `pBuscaItens` | procedure | Carrega o grid |
| `fValidaCampos` | function (override) | Validação dos campos da tela |

### `TItemZeraList` (classe auxiliar na mesma unit)

Lista das linhas a zerar, preservando a ordem de inserção.

| Membro | O que faz |
|--------|-----------|
| `FIndice: TDictionary<String, Integer>` | Responde `Contains` em O(1). Chave: `CODITE\|NUMLOT\|LOCFIS` |
| `FItems: TArrItemZera` | Preserva a ordem de inserção, consumida pelas Fases 0 e 2 |
| `FQtd` | Tamanho lógico — `Length(FItems)` é a capacidade, que cresce dobrando |
| `AddItem` / `Contains` / `GetItems` / `Clear` | Interface pública, inalterada desde a versão com array linear |

**Por que importa:** a lista recebe uma entrada por linha **contada** (não por linha divergente) —
19.768 na maior rodada medida. Com busca linear eram ~2×10⁸ comparações de string por rodada, CPU
pura, invisível em qualquer métrica de statements.

## Tela associada (.dfm)

`TfrmBalancoEstoqueGravar` — "Balanço de Estoque - Gravação".

| Componente | Tipo | O que dispara |
|------------|------|---------------|
| `btnConfirma` | `TBitBtnLocked` | "[ F10 ] Confirma" — aplica filtros e carrega o grid |
| `btnGravaAtivos` | `TBitBtnLocked` | "[ F2 ] GRAVAR CONTAGEM PARA ATIVOS" — `opcAtivos` + `fGravar` |
| `btnGravaTodos` | `TBitBtnLocked` | "[ F1 ] ATIVAR ITENS INATIVOS E GRAVAR CONTAGEM" — `opcAtivar` + `fGravar` |
| `btnImprimeInativos` | `TBitBtnLocked` | "[ F3 ] IMPRIMIR INATIVOS" — só imprime |
| `btnSemDivergencia` | `TBitBtnLocked` | "Confirma Sem Divergencias" — efetiva o contado sem diferença |
| `dbgItens` | `TDBGridCitel` | Grid da divergência; colunas g/ml só com `CFG_USATMQ = 'S'` |
| `pgbItens` | `TProgressBar` | Progresso da gravação (atualizado a cada 50 linhas) |
| `mmoInativos` | `TMemoFocus` | Lista de itens inativos encontrados |
| `grpFilCondet` | `TGroupBox` | "Operador da Contagem" — visível só com `CFG_BEFOCD = 'S'` e sem WMS |
| `pnlCabecalho` | `TPanel` | Filtros: localização, linha/grupo, fornecedor, produto, marca, departamento, unidade, grupo |
| `pnlObservacao` | `TPanel` | Observação gravada no documento |

## Pontos de atenção

- **`FItemZeraList.Clear` no início de `fGravar` não é opcional.** A lista vive de `FormCreate` a
  `FormDestroy`; sem o `Clear`, a segunda gravação da mesma sessão pula o zeramento dos itens da
  primeira.
- **Ordem: saldos antes da auditoria.** `pDescarregaEDesligaBatchSaldos` tem que rodar antes de
  `objAuditoriaSaldo.fValidouTodas`, senão a auditoria lê o saldo pré-ajuste. Só quebra em cliente
  com `CFG_UTAUFA = 'S'` e a function instalada — não aparece em teste nesta base.
- **Ordem: Fase 0 antes da Fase 1** em `fZeraItens`.
- **`pCarregaCustoItens` fica fora da transação** de propósito: é leitura pura.
- **Cache do `@VS_ID_TRANSACAO`:** `pLigaCacheIDTransacao` é armado logo após `fStartTransaction` e
  **desarmado no `Finally`**, inclusive nos caminhos de exceção. Deixar armado contamina o resto do
  ERP na mesma conexão.
- **Trava global:** `STR_TRAVA_CONDET` serializa a rotina em toda a base. Uma gravação travada
  segura todas as outras estações.
- **Toque em `ITEGER` é o custo dominante** — o trigger cobra ~6 statements por linha alterada. Ao
  mexer aqui, a métrica a olhar é número de linhas tocadas, não número de comandos.
- **`fMarcaAjuIteger`, `fMarcaAjuCadLot`, `fAjusteQtdIteger` e `fAjusteQtdCadLot` foram removidas.**
  Eram a origem do defeito de `LOT_QTDAJU = 0`: `fMarcaAjuCadLot` carimbava `LOT_SEQAJU` sem
  restrição por item, então o `LEFT JOIN` seguinte não casava e o `IFNULL(..., 0)` gravava zero. Não
  reintroduzir.

## Alterações documentadas

| Data | Requisito/Revisão | O que mudou |
|------|-------------------|-------------|
| 2026-08-20 | Req. 456948 (Parte A) — alterações locais | Pré-carga de custos (`pCarregaCustoItens`, `dicCustoItem`); `fAplicaAjusteIteger`/`fAplicaAjusteCadLot` derivando de `MOVDET` numa passada após o laço, no lugar das quatro `fMarcaAju*`/`fAjusteQtd*` por documento; lote de saldos (`pLigaBatchSaldos` / `pDescarregaEDesligaBatchSaldos`) com flush antes da auditoria; `TBatchSQL` no caminho do `MOVDET`; cache do `@VS_ID_TRANSACAO`; notificação de saldo mínimo adiada; `sltAutIncDocs` com os autoincrementos dos `MOVGER` da rodada |
| 2026-08-20 | Req. 456948-B (Parte B) — alterações locais | `TItemZeraList` com `TDictionary` (O(1)); `fZeraItens` set-based em três fases dirigidas por `BALZER` (`pCarregaBALZERZeramento`); supressão do toque redundante em `ITEGER` na Fase 2; `fVerificaIntegridadeRodada` + `pCarregaFotoBALZER` (5 conferências antes do commit) e flag de falha determinística no laço de documentos; bloco de sequenciais por rodada; remoção de `pCriaTemporariasEmContagem`/`pRemoveTemporaria`; `FintTemLocCritica` e dicionário de lote crítico; progresso a cada 50 linhas; remoção das quatro `fMarcaAju*`/`fAjusteQtd*` sem chamador |
