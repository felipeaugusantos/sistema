# Conhecimento acumulado — Req. 459132 (investigação, sem causa raiz fechada)

**Objetivo deste arquivo:** registrar tudo que foi mapeado nas units vasculhadas durante a investigação,
para permitir retomar o trabalho (inclusive simulando localmente com a base do cliente) sem precisar
reconstruir o raciocínio do zero. **A causa raiz NÃO foi confirmada** — três hipóteses foram levantadas e
todas caíram. Este documento é uma base de conhecimento de código/dados, não uma conclusão.

**Status da correção de código:** revertida. Nenhuma alteração de código ficou aplicada em nenhuma das três
working copies (`74.150.45`, `74.150`, `74.150.100`). `svn diff` limpo em todas.

---

## 1. Dados reais do incidente (para reprodução local)

| Item | Valor |
|---|---|
| Loja | SMF FERRAMENTAS LJ 001 |
| Empresa | `001` |
| Executável no chamado | `379.48.02.30` (04/08/2026) |
| Solicitante | Misael Lobo dos Santos da Silva |
| NF de entrada | `000000009771`, espécie `NF`, série `6`, fornecedor `00000847` (JSX IMPORTACAO E EXPORTACAO LTDA), `DET_CLAFIS = 2102` |
| NF — `MOVGER.AUTOINCREM` | `00100000001216315001` |
| NF — data/hora | `2026-08-28 15:55:14` a `15:55:17` (7 itens, horários levemente diferentes por item) |
| TA gerada (errada) | `000000010981`, espécie `TA` |
| TA — `MOVGER.AUTOINCREM` | `00100000001216448001` |
| TA — data/hora | `2026-08-28 15:55:14` a `15:55:17` (mesmo lote de horários da NF, TA gerada ~simultaneamente) |
| GERELE desta NF | `AUTOINCREM = 00100000000004295001` |
| Pedido de reserva (hoje em `DEL_FATGOR`) | `AUTOINCREM = 00100000000589742001` |
| `DEL_FATGOR.FGO_MEN001` | `"PEDIDO DE RESERVA DE ESTOQUE PRE-NOTA 000000009771-NF 6"` |
| `DEL_EXTGOR.FGO_DOCEND` | `"000000009771NF6  00100000847F"` (29 chars, formato decodificado abaixo) |
| Item exemplo (o mais citado no chamado) | `07888` — NF `217,0000` → TA gravada com `434,0000` (2×) |
| Todos os 7 itens do documento | `07888` (217), `07890` (150), `08014` (150), `08016` (150), `08519` (60), `08520` (100), `08521` (75) — **todos** com o mesmo padrão de duplicação (2× na TA e em `FDO_QTDBAI`) |

### Decodificação do formato `FGO_DOCEND` (29 caracteres, usado em várias queries do sistema)

| Posição (1-indexed) | Tamanho | Campo | Valor neste caso |
|---|---|---|---|
| 1-12 | 12 | NumDoc | `000000009771` |
| 13-14 | 2 | EspDoc | `NF` |
| 15-17 | 3 | Serie_ (padded) | `"6  "` (valor real em `MOVGER.GER_SERIE_` é só `"6"`, sem padding) |
| 18-20 | 3 | CodEmp | `001` |
| 21-28 | 8 | CliFor | `00000847` |
| 29 | 1 | Tip_FC | `F` |

### Configurações relevantes (`CFGSIS`, empresa `001`, confirmadas no banco em 2026-09-01)

| Config | Valor | O que faz |
|---|---|---|
| `CFG_COFEND` | `S` | Permite, na Conferência de Entrada, liberar itens já conferidos para Endereçamento mantendo a conferência em aberto |
| `CFG_TIPPNT` | `D` | Conferência realizada **depois** da entrada |
| `CFG_UDEVME` | `N` | Devolução de Mercadorias/Pré-nota — desligada |
| `CFG_CONEND` | `N` | **Config diferente de `CFG_COFEND`**, apesar do nome parecido — foi a config checada (erroneamente, como a relevante) na verificação inicial do chamado |

`blnCofEnd := (fCfgSis('COFEND', varBoolean)) And (fCfgSis('TIPPNT', varString) = 'D')` — com os valores acima,
`blnCofEnd = True` nesta loja. É essa combinação que muda o comportamento do sistema (ver seção 4).

### Queries de diagnóstico fornecidas no chamado original (reexecutáveis)

```sql
-- Verificação cruzada NF / Pedido / TA
SELECT
  '## NF: ', NF.DET_NUMDOC, NF.DET_CODEMP, NF.DET_NUMLOT, NF.DET_ESPDOC, NF.DET_FILKAR, NF.DET_QTDITE,
  NF.DET_DTAENT, NF.DET_HORENT, NF.DET_CLAFIS,
  '## PEDIDO: ', FDO_JAFATU, FDO_NUMLOT, FDO_CODITE, FDO_QTDITE, FDO_QTDBAI, FGO_DOCEND, FDO_DTAENT,
  FDO_HORENT, B.DTADEL,
  '## TA: ', TA.DET_NUMDOC, TA.DET_ESPDOC, TA.DET_CLAFIS, TA.DET_QTDITE, TA.DET_NUMLOT
FROM DEL_EXTGOR A
LEFT JOIN DEL_FATDOR B ON B.FDO_SEQGER = A.FGO_SEQFGO
LEFT JOIN MOVDET NF ON NF.DET_CODEMP = MID(FGO_DOCEND,18,3)
                AND IF(NF.DET_CODCLI IS NULL OR NF.DET_CODCLI = '', NF.DET_CODFOR, NF.DET_CODCLI) = MID(FGO_DOCEND,21,8)
                AND NF.DET_ESPDOC = MID(FGO_DOCEND,13,2)
                AND NF.DET_NUMDOC = LTRIM(RTRIM(MID(FGO_DOCEND, 01, 12)))
                AND NF.DET_CODITE = FDO_CODITE
INNER JOIN AUXMOV ON AUX_SEQDOR = NF.DET_SEQGER
INNER JOIN MOVDET TA ON TA.DET_SEQGER = AUX_SEQGER AND TA.DET_CODITE = NF.DET_CODITE
WHERE NF.DET_SEQGER = '00100000001216315001' AND FGO_DOCEND IS NOT NULL;

-- Log de replicação da transação (comprova geração ÚNICA da TA — ver seção 5.1)
SELECT LOG_CODIGO, LOG_DTACAD, LOG_HRACAD, LOG_TABELA, LOG_CODOPE, LOG_COMAND, LOG_CON_ID, LOG_IDTRAN
FROM LOGREP_ARQUIV_20260829
WHERE LOG_DTACAD = '2026-08-28' AND LOG_CON_ID = '5423076' AND LOG_IDTRAN = '2407890622297854116'
ORDER BY LOG_DTACAD, LOG_CODIGO, LOG_HRACAD;

-- Documento de entrada e transferência
SELECT DET_NUMDOC, DET_ESPDOC, DET_CODEMP, DET_SERIE_, DET_CODFOR, DET_CODCLI, DET_DTAENT, DET_CODITE,
       DET_QTDITE, DET_CLAFIS, DET_NUMLOT, DET_FILKAR
FROM MOVDET WHERE DET_DTAENT = '2026-08-28' AND DET_CODITE = '07888' AND DET_CODEMP = '001';

-- Pedido de reserva com quantidade baixada duplicada
SELECT * FROM DEL_FATGOR WHERE AUTOINCREM = '00100000000589742001';
SELECT FGO_DOCEND FROM DEL_EXTGOR WHERE FGO_SEQFGO = '00100000000589742001';
SELECT FDO_NUMDOC, FDO_ESPDOC, FDO_CODEMP, FDO_CODITE, FDO_QTDITE, FDO_QTDBAI
FROM DEL_FATDOR WHERE FDO_SEQGER = '00100000000589742001' AND FDO_CODITE = '07888';

-- Configs suspeitas de terem gerado o problema mesmo desligadas
SELECT * FROM CFGSIS WHERE SIS_CODCFG IN ('CFG_UDEVME','CFG_CONEND');
SELECT * FROM DIGCON WHERE DIC_MOVDET = '00100000001767372001';
```

### Queries adicionais criadas durante esta investigação (reexecutáveis)

```sql
-- CFG_COFEND / CFG_TIPPNT (a checagem que faltou no chamado original)
SELECT * FROM CFGSIS WHERE SIS_CODCFG IN ('CFG_COFEND','CFG_TIPPNT');

-- Triggers nas tabelas envolvidas (nenhum encontrado)
SHOW TRIGGERS WHERE `Table` IN ('DEL_FATDOR','FATDOR','MOVDET','DIGCON');

-- Contagem de operações por tabela na mesma transação da NF/TA
SELECT LOG_TABELA, LOG_CODOPE, COUNT(*) AS QTD FROM LOGREP_ARQUIV_20260829
WHERE LOG_DTACAD = '2026-08-28' AND LOG_CON_ID = '5423076' AND LOG_IDTRAN = '2407890622297854116'
GROUP BY LOG_TABELA, LOG_CODOPE ORDER BY QTD DESC;
-- Resultado: MOVGER=1, MOVDET=14 (7 itens x 2), FATDOR=14, DEL_FATDOR=7, DIGCON=7, AUXMOV=2,
-- DEL_FATGOR=1, DEL_EXTGOR=1, FATGOR=1, GERELE=1, entre outras.

-- MOVGER da TA e da NF (para obter AUTOINCREM exatos)
SELECT AUTOINCREM, GER_NUMDOC, GER_ESPDOC, GER_CODEMP, GER_SERIE_, GER_TIP_FC, GER_CODCLI, GER_CODFOR
FROM MOVGER WHERE GER_NUMDOC='000000010981' AND GER_ESPDOC='TA' AND GER_CODEMP='001';

SELECT AUTOINCREM, GER_NUMDOC, GER_ESPDOC, GER_CODEMP, GER_SERIE_, GER_TIP_FC, GER_CODFOR
FROM MOVGER WHERE GER_NUMDOC='000000009771' AND GER_ESPDOC='NF' AND GER_CODEMP='001';
-- (retorna 4 linhas — séries 003, 004, 005, 006 — a série 6 é a do fornecedor 00000847, TIP_FC='F')

-- GERELE desta NF
SELECT AUTOINCREM, GER_DOCENT, GER_ESPENT, GER_EMPENT, B07_SERIE, GER_CODFOR
FROM GERELE WHERE GER_DOCENT='000000009771' AND GER_ESPENT='NF' AND GER_EMPENT='001';

-- Reprodução da query de pValQtdEnderecada (qryQtdEnderecada) com os IDs reais
SELECT TAB.DET_CODITE, SUM(TAB.QTDITE) AS QTDITE FROM (
  SELECT DET_CODITE, SUM(DET_QTDITE) AS QTDITE FROM MOVDET
  WHERE DET_SEQGER = '00100000001216448001' AND DET_CLAFIS > '5000' GROUP BY DET_CODITE
  UNION ALL
  SELECT DET.DET_CODITE, SUM(DET.DET_QTDITE) AS QTDITE
  FROM MOVGER ENT
  INNER JOIN AUXMOV ON AUX_SEQDOR = ENT.AUTOINCREM
  INNER JOIN MOVGER TA ON TA.AUTOINCREM = AUX_SEQGER
  INNER JOIN MOVDET DET ON TA.AUTOINCREM = DET.DET_SEQGER
  WHERE ENT.GER_NUMDOC = '000000009771' AND ENT.GER_ESPDOC = 'NF' AND ENT.GER_CODEMP = '001'
    AND ENT.GER_CODFOR = '00000847' AND ENT.GER_TIP_FC = 'F' AND IFNULL(ENT.GER_SERIE_,'') = '6'
    AND DET.DET_CLAFIS > '5000' AND DET.DET_SEQGER <> '00100000001216448001' AND DET.DET_PROACA <> 'S'
    GROUP BY DET.DET_CODITE
) AS TAB GROUP BY TAB.DET_CODITE;
-- Resultado: 07888=434, 07890=300, 08014=300, 08016=300, 08519=120, 08520=200, 08521=150
-- (Sempre 2x a quantidade da NF, para todos os itens.)

-- Reprodução da 1ª query de pValQtdEnderecada (qryPedidoEnderecamento, achar pedidos por FGO_DOCEND)
SELECT DEL_FATGOR.AUTOINCREM, FGO_DOCEND, FGO_DTAENT
FROM DEL_FATGOR JOIN DEL_EXTGOR ON DEL_FATGOR.AUTOINCREM = DEL_EXTGOR.FGO_SEQFGO
WHERE FGO_DOCEND IS NOT NULL AND FGO_DTAENT >= DATE_SUB('2026-08-28', INTERVAL 12 MONTH)
  AND LOCATE('000000009771NF6  ', FGO_DOCEND) > 0;
-- Resultado: 1 linha, AUTOINCREM=00100000000589742001 (bate com o pedido de reserva)

-- Reprodução da 2ª query de pValQtdEnderecada (comparação item a item, SEM nenhuma alteração de código)
SELECT FDO_CODITE AS CODITEPEDIDO, SUM(IFNULL(FDO_QTDITE,0)) AS QTDAENDERECAR, FDO_ALTAMZ, FDO_ESPDOC
FROM DEL_EXTGOR INNER JOIN DEL_FATDOR ON DEL_EXTGOR.FGO_SEQFGO = DEL_FATDOR.FDO_SEQGER
LEFT JOIN DEL_EXTDOR ON DEL_EXTDOR.FDO_SEQFDO = DEL_FATDOR.AUTOINCREM
WHERE DEL_EXTGOR.FGO_SEQFGO IN ('00100000000589742001') AND FDO_ESPDOC='PD'
  AND SUBSTRING(FGO_DOCEND,1,12)='000000009771' AND SUBSTRING(FGO_DOCEND,13,2)='NF'
  AND SUBSTRING(FGO_DOCEND,15,3)='6  ' AND SUBSTRING(FGO_DOCEND,18,3)='001'
  AND SUBSTRING(FGO_DOCEND,21,8)='00000847' AND SUBSTRING(FGO_DOCEND,29,1)='F'
  AND IFNULL(FDO_ALTAMZ,'S')='S' GROUP BY FDO_CODITE;
-- Resultado: todos os 7 itens, com QTDAENDERECAR = quantidade ORIGINAL (não duplicada):
-- 07888=217, 07890=150, 08014=150, 08016=150, 08519=60, 08520=100, 08521=75

-- IMPORTANTE (achado que derrubou a 1ª hipótese de correção):
-- qryQtdEnderecada (434) != qryPedidoEnderecamento.QTDAENDERECAR (217) JÁ DIVERGIA na fórmula ORIGINAL
-- (sem nenhuma alteração de código). Ou seja, SE pValQtdEnderecada rodou, ela DEVERIA ter disparado a
-- exceção mesmo sem qualquer correção. Isso descarta a fórmula da query como causa raiz.

-- Query exata de TEnderecamentoProduto.pGetEnderecamentoByGERELE (2º ramo, EXTGOR/FATGOR PLANAS)
-- testada com o GERELE real desta NF — retornou 0 linhas contra o estado ATUAL do banco:
SELECT FATGOR.AUTOINCREM
FROM EXTGOR
INNER JOIN FATGOR ON FATGOR.AUTOINCREM = FGO_SEQFGO
LEFT JOIN CADCLI ON CLI_CODCLI = MID(FGO_DOCEND, 21, 8)
LEFT JOIN CADFOR ON FOR_CODFOR = MID(FGO_DOCEND, 21, 8)
LEFT JOIN MOVGER ON GER_NUMDOC = TRIM(MID(FGO_DOCEND, 01, 12))
  AND GER_ESPDOC = MID(FGO_DOCEND, 13, 2) AND GER_CODEMP = MID(FGO_DOCEND, 18, 3)
  AND ((GER_CODFOR = MID(FGO_DOCEND, 21, 8) AND GER_TIP_FC = MID(FGO_DOCEND, 29, 1))
    OR (GER_CODCLI = MID(FGO_DOCEND, 21, 8) AND GER_TIP_FC = MID(FGO_DOCEND, 29, 1)))
  AND GER_SERIE_ = MID(FGO_DOCEND, 15, 3)
LEFT JOIN GERELE ON GERELE.GER_DOCENT = MOVGER.GER_NUMDOC AND GERELE.GER_ESPENT = MOVGER.GER_ESPDOC
                AND GERELE.GER_EMPENT = MOVGER.GER_CODEMP AND GERELE.GER_CODFOR = MOVGER.GER_CODFOR
                AND IFNULL(GERELE.B07_SERIE, '')  = IFNULL(GER_SERIE_, '')
WHERE FGO_DOCEND IS NOT NULL AND MID(FGO_DOCEND, 18, 3) = '001'
  AND GERELE.AUTOINCREM =  '00100000000004295001';
-- ATENÇÃO: essa query foi rodada contra o estado ATUAL (pós-incidente) do banco. Segundo o usuário
-- (que conhece o sistema), o pedido de reserva só é MOVIDO para DEL_FATGOR/DEL_EXTGOR quando o
-- endereçamento é FINALIZADO — logo, no momento em que pGetEnderecamentoByGERELE de fato rodou (ANTES
-- da TA existir), o registro provavelmente ainda estava em EXTGOR/FATGOR (plana), e essa query teria
-- retornado normalmente. Rodar essa mesma query contra um snapshot ANTES do incidente (ou entender o
-- mecanismo de migração FATGOR→DEL_FATGOR) é necessário para saber se isso é ou não relevante.
```

---

## 2. Units vasculhadas — o que cada uma faz e o que foi encontrado

### 2.1 `padra_atualizado/fontes/movimentacaoitens/untEnderecamentoArmazem.pas`

Classe `TEnderecamentoArmazem`. Gerencia o client dataset `FArmaze` (armazéns/lotes candidatos para
endereçar um item) e aciona a geração da Transferência entre Armazéns.

- **`fGeraDocumentoTransfArmazens`** (linha ~1381): filtra `FArmaze` por `QTDITE > 0`, monta `FTransf`
  (`TTransferenciaArmazens`) com `strCodOpe`, `strSeqOri := strSeqDocOri` (parâmetro recebido de quem
  chamou — é isso que vira `strSeqOri`/`strSeqDocOri` em `TTransferenciaArmazens`), `endDocumento`,
  `objEnderecamentoProduto := AEnderecamentoProduto`, e chama `FTransf.fGeraTransferencia(False, False)`.
  **Chamado de** `untEntEnderecamentoProduto.pas:2794`, passando
  `objEnderecamento.endDocumento.strAutInc` como `strSeqDocOri` e `objEnderecamento` (não nil) como
  `AEnderecamentoProduto`.
- **`pInsereArmazem`** / **`pAtualizaArmazemItem`** / **`fAtualizaArmazemTodosItemPrg`** (linhas ~285-620):
  populam `FArmaze` a partir de queries sobre `CADLOT`/pedido, atribuindo `QTDITE` via a subrotina interna
  `pSetaQuantidade`. Investigado como possível ponto de duplicação (2 chamadas a `pSetaQuantidade` em
  ramos diferentes — "cross-dock" vs. "ARMORI=ARMDES") mas **não confirmado** como causa — ver seção 3.

### 2.2 `padra_atualizado/fontes/movimentacaoitens/untTransferenciaArmazens.pas`

Classe `TTransferenciaArmazens`. É quem efetivamente grava `MOVGER`/`MOVDET` da TA.

- **`fGeraTransferencia`** (linha 2231): função principal.
  - Linha ~2448-2457: decide `FblnEndLocal` — só fica `True` se `Not Assigned(objEnderecamentoProduto) And
    blnGerarReserva`. No fluxo do chamado (`objEnderecamentoProduto` = `objEnderecamento`, não nil),
    **`FblnEndLocal = False`** sempre, independente de `blnGerarReserva`.
  - Linha ~2496-2521: loop `While (Not Eof) And Result` sobre `FTransf` (= `FArmaze`), gravando saída
    (`STR_CLASAI`) e entrada (`STR_CLAENT`) via `fGravaMovDetTransf_Interna` — **um único loop, uma única
    passada**; não há duplicação de execução aqui.
  - Linha ~2531: `pValQuantidade` — valida `SUM(CLAFIS<5000)` vs `SUM(CLAFIS>=5000)` **dentro do mesmo
    documento TA** (entrada vs. saída internos). Não envolve o pedido de reserva; não tem o mesmo tipo de
    problema.
  - Linha ~2534: **`If Not FblnEndLocal And Not fEmptyStr(strSeqOri) Then pValQtdEnderecada;`** — só roda a
    validação contra o pedido de reserva se `FblnEndLocal=False` (confirmado, sempre nesse fluxo) **e**
    `strSeqOri` não vazio. Comentário no código: *"Sem strSeqOri o documento de origem foi cancelado (não
    existe mais em MOVGER), pula a validação"*.
  - Linha ~2538: se `intQtdRegEnt<>intQtdRegSai` OU `fltQtdEnderada<>fltQtdAEnderecar` (setados por
    `pValQuantidade`/`pValQtdEnderecada`), lança `Exception.Create('Houve inconsistência na gravação da
    TA...')`, com `fRollBack` no `except`.
- **`pValQtdEnderecada`** (procedure aninhada, linha ~2281-2425): a validação central desta investigação.
  - `qryQtdEnderecada` (linha ~2290-2331): soma `MOVDET.DET_QTDITE` (`CLAFIS>5000`) da própria TA
    (`DET_SEQGER = strAutInc`, onde `strAutInc` é o `AUTOINCREM` do `MOVGER` **desta própria TA**, setado
    por referência em `fGravaMovGer` na linha 788) `UNION ALL` com outras TAs do mesmo documento de origem
    (join `MOVGER ENT → AUXMOV → MOVGER TA → MOVDET`, filtrando por `NUMDOC/ESPDOC/CODEMP/CODFOR/TIP_FC/
    SERIE_` do documento de origem, e `DET_SEQGER <> strAutInc` para não contar a própria TA duas vezes).
    **Confirmado com dados reais: retorna 434 para o item 07888** — o valor já duplicado.
  - Se essa query não for vazia e `endDocumento.strNumdoc` não for vazio, monta `strDocEndIn` a partir de
    `DEL_FATGOR`/`DEL_EXTGOR` filtrando por `FGO_DOCEND` contendo o documento de origem (linha ~2337-2358).
    **Confirmado: encontra 1 linha (`00100000000589742001`).**
  - Refaz a query de pedido com `SUBSTRING` exatas + `DEL_EXTGOR`/`DEL_FATDOR`/`DEL_EXTDOR`, filtrando
    `FDO_ESPDOC="PD"` e `IFNULL(FDO_ALTAMZ,"S")="S"` (linha ~2360-2394). **Confirmado: retorna os 7 itens
    com `QTDAENDERECAR` = quantidade ORIGINAL (não duplicada) do pedido — 217 para o item 07888.**
  - Loop final (linha ~2398-2416): para cada item de `qryQtdEnderecada`, faz `Locate('CODITEPEDIDO', ...)`
    em `qryPedidoEnderecamento` e compara `RoundTo(QTDITE,-4) <> RoundTo(QTDAENDERECAR,-4)`. **Com os
    valores reais (434 vs 217), essa comparação já diverge na fórmula ORIGINAL, sem qualquer alteração de
    código** — ver hipótese descartada #1 na seção 3.
- **`pValQuantidade`** (procedure aninhada, linha ~2242-2280): valida `SUM(CLAFIS<5000)` = `SUM(CLAFIS>=5000)`
  **dentro do próprio `MOVDET` da TA que está sendo gerada** (`DET_SEQGER = strAutInc`) — não usa o pedido
  de reserva, não tem relação direta com a duplicação encontrada, mas é executada sempre (não condicional).

### 2.3 `padra_atualizado/fontes/movimentacaoitens/untEntEnderecamentoProduto.pas`

Provavelmente a unit da tela `TfrmEntEnderecamentoProduto` (a tela de Endereçamento de Entrada). Usa
extensivamente um campo/objeto `objEnderecamento: TEnderecamentoProduto`, mas **nunca atribui
`objEnderecamento.endDocumento` diretamente neste arquivo** — só lê (confirmado por grep exaustivo).

- Linha 557: `blnCofEnd := (fCfgSis('COFEND', varBoolean)) And (fCfgSis('TIPPNT', varString) = 'D');` —
  **este é o cálculo "canônico" de `blnCofEnd`** usado nesta unit (existe uma cópia idêntica dentro do
  construtor de `TEnderecamentoProduto`, linha 219 de `untEnderecamentoProduto.pas`).
- Linha 2780-2799: decide se chama `fGeraDocumentoTransfArmazens` — só chama se
  `(Not objEnderecamento.blnRastreamentoIndustrial) And ((tplTipLot=tplArmazem) Or blnUtiLot) And
  (blnSalvar)` e `Not objEnderecamento.SoTemProdutoAcabado`. Passa
  `objEnderecamento.endDocumento.strAutInc` como `strSeqDocOri`.
- Linha 2819-2836: depois de salvar, se `fConferenciaDepoisDaEntrada` (função global, ver seção 2.4) e
  `strAutInc` não vazio, chama `TDefineBaixaPedido.fGeraTERequisicao`/`ProcessaStatusPedidoRequisicao`.
- Linha 2855-2861: **só quando `blnCofEnd or blnUDEVME`**, chama
  `objEnderecamento.fConsulta(cdsConsulta).fGravarFatEnd.fGravarQuantidadeParcialEnderecamento` — é aqui
  que o fluxo de "conferência digital" (o gatilho de `CFG_COFEND`) entra em ação.
- Linha 1403: `If fConferenciaDepoisDaEntrada And (not fDocumentoConferido(...)) And (Not blnCofEnd) Then` —
  outro ponto que usa `blnCofEnd` como exceção a uma regra geral.

### 2.4 `padra_atualizado/fontes/movimentacaoitens/untEnderecamentoProduto.pas`

Classe `TEnderecamentoProduto` — o "model"/lógica de negócio por trás da tela de endereçamento (a tela em
si é `untEntEnderecamentoProduto.pas`).

- **Construtor** (linha 212-224): `blnCOFEND := (fCfgSis('COFEND', varBoolean)) And (fCfgSis('TIPPNT',
  varString) = 'D'); blnUDEVME := (fCfgSis('UDEVME', varBoolean));` — mesma fórmula usada em toda parte.
- **Property `endDocumento`** (linha 185): `property endDocumento: TEndDocumento read FDocume write
  pSetRecEnderecamento;`
  - **`pSetRecEnderecamento`** (linha 1344-1348): `FDocume := Value; pCarregarAutoIncremPedido;` — **NÃO
    recalcula `strAutInc`**, só copia o record recebido como está.
- **Property `strDocumento`** (linha 186, via `pSetStrEnderecamento`):
  - **`pSetStrEnderecamento`** (linha 1350-1368): `pEnderecamentoToDocumento(Value, FDocume);
    FDocume.strAutInc := fGetMovGerAutoinc(FDocume.strCodEmp, FDocume.strNumDoc, FDocume.strEspDoc,
    FDocume.strSerie_, FDocume.strCliFor, FDocume.strTip_FC); FDocume.strAutIncGerEle :=
    fGetGerEleAutoinc(FDocume.strAutInc); pCarregarAutoIncremPedido; pCarregaPedidosQueDevemHabilitarReserva;`
    — **este é o ÚNICO ponto de todo o `fontes/` que de fato calcula `strAutInc`** via `fGetMovGerAutoinc`
    (confirmado por grep exaustivo em `strEnderecamento :=` — nenhuma outra ocorrência real no projeto além
    de uma variável homônima e não relacionada em `untFluxoCompras.pas:1802`).
- **Property `strAutIncPed`**:
  - **`pSetAutIncPed`** (linha 1331-1337): `pLimpar; strDocumento := fCampoTabela('FGO_DOCEND', 'EXTGOR',
    ['FGO_SEQFGO'], [Value]); ...` — **começa chamando `pLimpar`, que ZERA `FDocume` inteiro** (via
    `strDocumento := ''`, que dispara `pSetStrEnderecamento('')`), antes de tentar repopular buscando
    `FGO_DOCEND` em `EXTGOR` (tabela **plana**, não `DEL_`) pela chave `Value` (o `AUTOINCREM` de FATGOR).
    Se `Value=''`, `fCampoTabela` provavelmente retorna `''`, e `FDocume` fica **totalmente vazio**.
- **`fGerarPedidoParaReservarEstoque`** (linha 1423-...): cria um NOVO pedido de reserva de estoque via
  `fGravaFatGor` (função global de `untFatGor.pas`, ver seção 2.6) — **só é chamado quando `FblnEndLocal`
  (em `TTransferenciaArmazens.fGeraTransferencia`) é `True`**, o que **não é o caso no fluxo do chamado**
  (`FblnEndLocal=False` sempre, pois `objEnderecamentoProduto` já vem atribuído). Monta `strMens01`/
  `strMens02` com templates que batem exatamente com o `FGO_MEN001` encontrado no banco para este
  incidente — mas ver ressalva na seção 3 (hipótese #3, ainda não resolvida) sobre como esse texto pode ter
  ido parar em `DEL_FATGOR` mesmo sendo `fGravaFatGor` (que só grava em `FATGOR`/`EXTGOR` planas, confirmado
  na seção 2.6).
- **`fGravarQuantidadeParcialEnderecamento`** (linha 3410-3451): `UPDATE FATDOR SET FDO_QTDBAI = FDO_QTDBAI
  + :QTDITE WHERE AUTOINCREM = :AUTOINCREM` para cada linha de `FcdsConsulta` com `dobQtdIte>0` (via
  `TEMLOT`/`ARMAZE`), e um `UPDATE DIGCON ... SET DIC_QTDEND = FDO_QTDBAI - ...`. **Grava em `FATDOR`
  plana, não em `DEL_FATDOR`** (confirmado: `SHOW TABLES` retorna `FATDOR` e `DEL_FATDOR` como tabelas
  fisicamente distintas). Chamada só quando `blnCofEnd or blnUDEVME` (via
  `untEntEnderecamentoProduto.pas:2861`).
- **`pGetEnderecamentoByGERELE`** (linha 2751-2832): usada no fluxo automático (ver seção 2.7). Escreve
  campos de `FDocume` **diretamente** (não via property `endDocumento`), sem nunca setar `strAutInc`
  diretamente — conta com a atribuição final a `strAutIncPed` (linha 2797 ou 2827) para disparar a cadeia
  que calcula `strAutInc`. Tem dois ramos:
  - Ramo `If (FSeqFgo = '') And (FDocume.strNumDoc = '')`: busca em `MOVGER` puro pelo `AUTOINCREM` do
    GERELE, repopula `FDocume.*` (de novo sem `strAutInc`), e `strAutIncPed := FSeqFgo` (resultado de
    `pCarregarAutoIncremPedido`, não investigado a fundo).
  - Ramo `Else`: query complexa com `EXTGOR INNER JOIN FATGOR` + `LEFT JOIN CADCLI/CADFOR/MOVGER/GERELE`,
    decodificando `FGO_DOCEND` via `MID(...)`, filtrando por `GERELE.AUTOINCREM = strAutoincremGERELE`.
    **Usa `EXTGOR`/`FATGOR` PLANAS, não `DEL_`.** `strAutIncPed := qryGERELE.FieldByName('AUTOINCREM').AsString;`
    — se a query não achar nada, fica `''`.
- **`pLimpar`**: não lido o corpo diretamente, mas confirmado por uso (`strDocumento := ''` dispara
  `pSetStrEnderecamento('')`) que zera `FDocume` por completo, incluindo tudo que tenha sido setado antes.

### 2.5 `padra_atualizado/fontes/cadastros/untTEnderecamentoConferenciaParcial.pas`

Classe `TEnderecamentoConferenciaParcial` — mecanismo de "liberar conferência parcial para
endereçamento", grava/lê `DIGCON`.

- **`Processa`** (linha 306-374): dispara **duas `TThread.CreateAnonymousThread` concorrentes** —uma lendo
  `DIGCON` (`AdicionarItemConferido`), outra lendo `FATDOR` (`AdicionarItemDocumento`+
  `AdicionarItemDocumentoSintetizado`) — **sem qualquer sincronização** entre elas, e espera o término com
  **busy-wait sem yield** (`while Not (blnTerminouDocumento) do;` / `while Not (blnTerminouDigCon) do;`).
  Ambas operam sobre `TUniQuery`s ligadas à mesma conexão de banco. **Candidato mais forte (não confirmado)
  para explicar duplicação de leitura/gravação não determinística** — mas nota: essa classe consulta
  `FATDOR` **plana**, enquanto a reserva do incidente está em `DEL_FATGOR`/`DEL_FATDOR` — a ligação entre
  os dois não foi fechada, e pode nem ser essa a classe usada neste fluxo específico.
- **`pInsereDigCon`** (linha 208-234): insere em `DIGCON` para itens com `QuantidadeSolicitada>0 And
  QuantidadeAtendida=0` — usa `DIC_QTDITE := i.QuantidadeSolicitada` (quantidade cheia do pedido, não uma
  fração).
- **`DistribuirQuantidadesConferidas`** (linha 59-84): distribui as quantidades já lidas de `DIGCON`
  (`ItensConferidos`) contra os itens do documento (`ItensDocumento`), calculando `QuantidadeAtendida`.
- **`JaTeveEnderecamento`** (linha 135-160): única função desta unit que consulta **tanto** `FATGOR/FATDOR`
  quanto `DEL_FATGOR/DEL_FATDOR` — sugere que a migração entre os dois conjuntos de tabelas é conhecida e
  tratada em pelo menos um ponto do sistema.
- **`pAjustaFatgor`** (linha 119-133): `UPDATE FATGOR INNER JOIN FATDOR ... SET FDO_QTDBAI = 0` — zera a
  baixa na tabela **plana**.

### 2.6 `padra_atualizado/fontes/faturamento/untFatGor.pas`

- **`fGravaFatGor`** (função global, linha 84 interface / 1421 implementação): função enorme (100+
  parâmetros) que monta e executa um `INSERT INTO EXTGOR (...)` (confirmado literal na linha 1775-1776:
  `strSQL := strSQL + 'INSERT INTO   '; strSQL := strSQL + '  EXTGOR      ';`) e usa
  `fRetAutoIncrem('FATGOR', strCodEmp)` (linha 2162) para gerar o próximo `AUTOINCREM`. **Confirmado via
  grep: nenhuma ocorrência de `DEL_` em todo o arquivo** — esta função **só grava nas tabelas planas**
  `EXTGOR`/`FATGOR`/`FATDOR`, nunca em `DEL_EXTGOR`/`DEL_FATGOR`/`DEL_FATDOR`. É a função chamada por
  `fGerarPedidoParaReservarEstoque` (`untEnderecamentoProduto.pas:1534`, via `uses untFatGor` na linha 206
  do mesmo arquivo) — **sem overloads conflitantes** (confirmado: só há uma declaração global com esse
  nome; `untIFatGor.pas`/`untTFatGor.pas` declaram apenas métodos de interface/classe, não usados aqui).

### 2.7 `padra_atualizado/fontes/movimentacaoitens/untProcessoCompras.pas`

- **`TProcessoEnderecamento.pOnRealizar`** (linha ~716-740): abre a tela de endereçamento no fluxo
  automático do "Processo de Compras":
  ```pascal
  pCriarFormularios(TfrmEntEnderecamentoProduto, form);
  form.strAutoincremGERELE := strAutoincrem;
  form.ShowModal;
  ```
  Esse é o único ponto encontrado em todo `padra_atualizado/fontes` que abre
  `TfrmEntEnderecamentoProduto` — não há outra chamada a
  `pCriarFormularios(TfrmEntEnderecamentoProduto, ...)` em lugar nenhum do projeto.

### 2.8 `padra_atualizado/fontes/movimentacaoitens/untEntEnderecamentoProduto.pas` — `FormActivate`

- Linha ~521-545: se `strAutoincremGERELE` não vazio, chama
  `objEnderecamento.pGetEnderecamentoByGERELE(strAutoincremGERELE)`; se `objEnderecamento.strAutIncPed`
  ficar vazio, marca `blnDocumentoNaoEncontrado := True` (não chegou a ser lido o tratamento completo desse
  flag). Caso contrário, `pCarregaEnderecamento`.

### 2.9 `padra_atualizado/fontes/movimentacaoitens/untRecTransfEstoque.pas` (tangencial — não confirmado como parte deste fluxo)

- **`fGerarPedidosReservaEstoque`** (linha 2878-...): monta um `TEndDocumento` local
  (`strNumDoc/strEspDoc/strSerie_/strCodEmp/strCliFor/strTip_FC`) **sem setar `.strAutInc`** e faz
  `objEnderecamento.endDocumento := endDocumento;` (via a property "burra" `pSetRecEnderecamento`, que não
  recalcula `strAutInc`). **Não confirmado se este `objEnderecamento` é o mesmo usado no fluxo do
  chamado** (esta unit é da tela de Entrada/Conferência — `TfrmRecTransfEstoque` — possivelmente um
  contexto/objeto diferente do `objEnderecamento` de `untEntEnderecamentoProduto.pas`). Registrado aqui
  como pista não fechada, não como conclusão.
- Nota lateral: esta mesma unit foi objeto de uma correção anterior (Req. 459072, ver
  `IA/specs/459072/devolucaoNaoAtualizaCadlotIteger_Req459072.md`) envolvendo `fZeraDataEntrada` vs.
  `fConferenciaDepoisDaEntradaLocal` — mesmo arquivo, tema relacionado (conferência depois da entrada),
  bug diferente.

---

## 3. Hipóteses de causa raiz levantadas e por que cada uma caiu

### Hipótese #1 — Fórmula de `pValQtdEnderecada` sem subtrair `FDO_QTDBAI` (DESCARTADA)

**Raciocínio original:** `pValQtdEnderecada` compara `fltQtdEnderada` (de `MOVDET`) contra
`QTDAENDERECAR = SUM(FDO_QTDITE)` (do pedido, sem subtrair `FDO_QTDBAI`) — pareceu uma falha de defesa
plausível quando `CFG_COFEND` altera o cálculo de quantidade a endereçar via `DIGCON.DIC_QTDITE`.

**Correção implementada e depois revertida:** tornar a subtração de `FDO_QTDBAI` condicional a
`(CFG_COFEND And fConferenciaDepoisDaEntrada) Or CFG_UDEVME`, aplicada nas 3 working copies e depois
**revertida por completo** (confirmado `svn diff` limpo).

**Por que caiu:** rodando a query ORIGINAL (sem nenhuma alteração) com os dados reais deste incidente —
`qryQtdEnderecada.QTDITE = 434` vs `qryPedidoEnderecamento.QTDAENDERECAR = 217` (SEM subtrair `FDO_QTDBAI`,
fórmula 100% original) — **os valores já divergem**. Ou seja, a validação **já deveria ter disparado a
exceção mesmo sem qualquer correção de fórmula**. O problema não está em como a comparação é calculada.

### Hipótese #2 — `pValQtdEnderecada` foi pulada porque `strSeqOri` veio vazio, por engano no ramo de
"documento cancelado" (PARCIALMENTE INVESTIGADA, NÃO CONFIRMADA)

**Raciocínio:** `pValQtdEnderecada` só roda se `Not fEmptyStr(strSeqOri)`, onde `strSeqOri =
objEnderecamento.endDocumento.strAutInc`. Se por algum motivo esse campo estivesse vazio (mesmo o
documento não estando cancelado), a validação inteira seria pulada silenciosamente, explicando por que a
divergência (434 vs 217, hipótese #1) nunca foi detectada.

**Sub-hipótese 2a (`pGetEnderecamentoByGERELE` busca no lugar errado — EXTGOR/FATGOR planas vs DEL_ —
DESCARTADA/INCONCLUSIVA):** testei a query exata de `pGetEnderecamentoByGERELE` (2º ramo) com o
`GERELE.AUTOINCREM` real deste incidente contra o banco **atual** — retornou 0 linhas. Isso pareceria
confirmar que a busca falha porque o registro está em `DEL_FATGOR`/`DEL_EXTGOR`, não em `FATGOR`/`EXTGOR`.
**Porém o usuário esclareceu que o registro só é MOVIDO para `DEL_FATGOR`/`DEL_EXTGOR` quando o
endereçamento é FINALIZADO** — ou seja, o teste foi feito contra o estado PÓS-incidente (o registro já
tinha sido arquivado, porque o endereçamento, mesmo errado, chegou a se completar). **Não é evidência
válida de causa raiz** tal como foi coletada — precisaria ser testada contra um snapshot do banco de
**antes** do incidente, ou entendendo exatamente quando/como ocorre essa migração `FATGOR→DEL_FATGOR`
(mecanismo ainda não localizado no código nesta sessão).

**Pendência real:** ainda não sabemos por que (ou se) `strSeqOri` chegou vazio neste incidente. A cadeia de
código que MOSTRA COMO isso PODERIA acontecer (`pSetAutIncPed` chamando `pLimpar` antes de repopular) está
mapeada e é real, mas não há evidência de que tenha realmente ocorrido neste caso.

### Hipótese #3 — Mecanismo de migração FATGOR→DEL_FATGOR ao finalizar endereçamento (NÃO INVESTIGADA)

Levantada pelo usuário ao final da sessão. Não foi localizado no código o mecanismo que move/arquiva
registros de `FATGOR`/`FATDOR`/`EXTGOR` para `DEL_FATGOR`/`DEL_FATDOR`/`DEL_EXTGOR` ao concluir um
endereçamento. Entender esse mecanismo é pré-requisito para validar (ou descartar) a hipótese #2, e pode
revelar uma causa raiz própria (ex.: se essa migração acontece **no meio** da geração da TA, antes de
`pValQtdEnderecada` rodar, isso explicaria tudo).

---

## 4. Perguntas em aberto para quem retomar a investigação

1. **Onde no código está o mecanismo de migração `FATGOR/FATDOR/EXTGOR → DEL_FATGOR/DEL_FATDOR/DEL_EXTGOR`?**
   Buscar por `INSERT INTO DEL_FATGOR`/`INSERT INTO DEL_FATDOR`/`INSERT INTO DEL_EXTGOR` com nome de
   tabela literal, ou por alguma rotina genérica que faça `SELECT ... FROM FATGOR` + `INSERT INTO
   DEL_FATGOR` + `DELETE FROM FATGOR` (padrão comum de "arquivamento"). Vale também procurar por
   `AnsiReplaceStr(strSQL, 'FATGOR', 'DEL_FATGOR')` — esse padrão de substituição de texto em SQL já foi
   encontrado em `untReimpressao.pas:1513-1515` e `untReimpressaoDocs.pas:857`, mas para outra finalidade
   (reimpressão de documentos já finalizados) — pode ser o MESMO mecanismo genérico usado para o
   arquivamento do pedido de reserva.
2. **Em que momento exato, dentro do fluxo de "salvar endereçamento" (`untEntEnderecamentoProduto.pas`,
   por volta da linha 2780-2861), essa migração acontece — antes ou depois de `fGeraDocumentoTransfArmazens`
   ser chamado (linha 2794)?** Se for ANTES, isso muda tudo: significa que a leitura de `pValQtdEnderecada`
   sobre `DEL_FATGOR`/`DEL_FATDOR` (que já é a tabela `DEL_`, olhando o código-fonte atual — ver seção 2.2)
   está correta/esperada, e o problema estaria em outro lugar.
3. **`objEnderecamento` em `untRecTransfEstoque.pas:2914` é o MESMO objeto (mesma instância) usado depois em
   `untEntEnderecamentoProduto.pas`, ou são dois objetos/telas diferentes no mesmo fluxo de negócio (entrada
   → depois endereçamento em tela separada)?** Isso não foi confirmado. Se forem o mesmo objeto persistido
   entre telas, o `TEndDocumento` sem `strAutInc` montado em `untRecTransfEstoque.pas:2899-2912` pode ser
   relevante; se forem instâncias diferentes, é irrelevante para este bug.
4. **Qual é a real função de `pCarregarAutoIncremPedido`?** Chamada em `pSetRecEnderecamento`,
   `pSetStrEnderecamento` e (duas vezes) em `pGetEnderecamentoByGERELE`, mas seu corpo não foi lido nesta
   sessão. Provavelmente é quem de fato seta `FSeqFgo`/`strAutIncPed` internamente — entender essa função é
   provavelmente o próximo passo mais direto.
5. **Reproduzir localmente:** com a base do cliente restaurada localmente, o caminho mais direto para
   reproduzir é repetir o fluxo real — conferência de entrada da NF (`CFG_COFEND='S'`, `CFG_TIPPNT='D'`
   nesta empresa) seguida do endereçamento automático via "Processo de Compras" (`untProcessoCompras.pas`,
   `TProcessoEnderecamento.pOnRealizar`) — e, com um debugger anexado, colocar breakpoint em:
   - `TEnderecamentoProduto.pGetEnderecamentoByGERELE` (`untEnderecamentoProduto.pas:2751`) — inspecionar
     `FDocume` completo (inclusive `strAutInc`) ao final da execução.
   - `TTransferenciaArmazens.fGeraTransferencia` (`untTransferenciaArmazens.pas:2231`) — inspecionar
     `strSeqOri` no momento da checagem da linha ~2534, e se `pValQtdEnderecada` chega a ser chamada.
   - Se `pValQtdEnderecada` for chamada, inspecionar `fltQtdEnderada`/`fltQtdAEnderecar` calculados,
     comparando com os valores reais das queries da seção 1.

---

## 5. Referências cruzadas

- Análise anterior (mesmo tema geral — conferência depois da entrada, mesmo arquivo tangencial
  `untRecTransfEstoque.pas`, bug diferente): `IA/specs/459072/devolucaoNaoAtualizaCadlotIteger_Req459072.md`.
- Documentação formal (spec/plan/tasks) desta investigação, **desatualizada quanto à causa raiz** (contém a
  Hipótese #1, hoje sabidamente descartada): `IA/specs/459132/spec.md`, `plan.md`, `tasks.md`,
  `validacaoDivergenciaEnderecamento_Req459132.md`. Recomenda-se, ao fechar a causa raiz de fato, atualizar
  esses arquivos para refletir a conclusão correta.
- **Mudança independente, NÃO revertida, atualmente aplicada nesta working copy (74.150.45):** troca do
  `LOCATE` pela igualdade direta em `FGO_DOCEND` na 1ª query de `pValQtdEnderecada`
  (`untTransferenciaArmazens.pas`) — tema à parte da Hipótese #1/`FDO_QTDBAI` acima (não mexe na fórmula de
  `QTDAENDERECAR`, só em como o pedido de reserva é localizado). Detalhes completos e a decodificação de
  `fMarcaDocumentoEnderecamento`/`fGetStrEnderecamento` (formato de `FGO_DOCEND`) em
  `IA/specs/459132/otimizacaoLocateFgoDocend_Req459132.md` e `investigacao_historico_Req459132.md` (Passo 6).
