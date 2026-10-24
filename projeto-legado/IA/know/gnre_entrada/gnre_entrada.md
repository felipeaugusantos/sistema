# GNRE - Entrada

## Objetivo

Registra as guias de recolhimento de ICMS ligadas a uma nota de entrada de mercadorias — GNRE/GARE
de ST, GNRE de produto tributado (antecipação), TCIF e TS (Suframa). A guia é gravada com os itens
da nota que ela cobre; o valor de cada guia é distribuído pelos itens e entra no custo (preço médio,
custo de última compra, lote de preços), e opcionalmente gera o contas a pagar da guia, com baixa
imediata quando o vencimento é o dia.

A rotina tem três portas de entrada: a **prévia** na importação do XML (divergência de ST), os
**botões da tela de resumo da entrada** e a **digitação após a entrada** (manutenção da nota já gravada).

## Zona e localização

- Zona: **Legado**
- Módulo/pasta: `padra_atualizado/fontes/movimentacaoitens/`
- Units principais:
  - [untGNRE](untGNRE.md) — classes `TGNRE` (uma guia) e `TListGNRE` (guias de uma nota já gravada)
  - [untEntGNRE](untEntGNRE.md) — tela de digitação da guia (`TfrmEntGNRE`)
  - [untPreparaGNRE](untPreparaGNRE.md) — tela da prévia na importação do XML (`TfrmPreparaGNRE`)
  - [untEntDadosFiscaisResumo](untEntDadosFiscaisResumo.md) — **somente** os quatro botões de guia da tela de resumo da entrada
- Units relacionadas, não documentadas aqui: `untDigGNRE` (tela "Digitação de GNRE após Entrada de
  Mercadorias", consome `TListGNRE`), `untEntNFEDivergencias` (abre a prévia), `untPcmGer` (grava a
  entrada e a memória de cálculo da prévia), `untEspelhoNota`/`untRelEspNotaEnt` (espelho da nota
  lê `TGnre`), `untEntDadosCaixa2`, `untLotePrecosEfetivacaoCx`, `untFluxoCompras` (abre `TfrmDigGNRE`)
- Genéricas: [untFuncoesSimples](../untFuncoesSimples.md)

## Telas

| Tela (form) | Unit | Função |
|-------------|------|--------|
| `TfrmPreparaGNRE` ("Prepara GNRE") | `untPreparaGNRE` | Grid dos itens com divergência de ST na importação do XML; o operador ajusta o "Vr. GNRE" por item e confirma a prévia |
| `TfrmEntDadosFiscaisResumo` | `untEntDadosFiscaisResumo` | Resumo da entrada. Botões `[F3]GNRE Prod. ST`, `[F2]GNRE Prod. Tribut.`, `[F1]TCIF`, `[Alt+F1]TS` |
| `TfrmEntGNRE` ("GNRE" / "TCIF" / "TS") | `untEntGNRE` | Digitação de uma guia: aba 1 dados da guia e do contas a pagar, aba 2 itens que terão a guia |
| `TfrmDigGNRE` | `untDigGNRE` | Lista de guias de uma nota já gravada; incluir, alterar, excluir (só não gravadas) e confirmar |

## Tipos de guia (`TTipoChamada`)

| Tipo | Tabela | Campo de valor no item | `GNR_ORIGEM` | Quando |
|------|--------|------------------------|--------------|--------|
| `tcGnreST` | `CADGNR` | `ENT_VALGNR` | `S` | Botão ST do resumo, com `CFG_GNRTEM` ligada |
| `tcGnreTributado` | `CADGNR` | `ENT_VALGNR` | `T` | Botão Tributada do resumo; opção "Tributada" na digitação após entrada |
| `tcGnrePadrao` | `CADGNR` | `ENT_VALGNR` | `P` | Botão GNRE do resumo sem `CFG_GNRTEM`; opção "ST" (ou única) na digitação após entrada |
| `tcTCIF` | `GNRTCI` | `ENT_VLTCIF` | — | Suframa |
| `tcTS` | `GNR_TS` | `ENT_VAL_TS` | — | Suframa |

Atenção: a GNRE "ST" lançada **após** a entrada é gravada como `tcGnrePadrao` (origem `P`), não
`tcGnreST`. A origem `S` só nasce no resumo da entrada com `CFG_GNRTEM`.

## Campos que definem o comportamento

O valor da guia viaja por três lugares: **`DETELE`** (prévia da importação do XML) →
**`TMP_ENTMER`** (digitação da entrada, uma linha por item) → **`MOVTRI`** (nota gravada). Depois da
entrada, só `MOVTRI` vale.

```
Importação XML          Entrada (resumo)                    Confirmação              Após a entrada
DETELE.DET_VLRGNR ──► TMP_ENTMER.ENT_VLRGNR ─┐
                                              ├─► ENT_VALGNR ──► MOVTRI.DET_VLGNRE ◄── TListGNRE (pUpdateMovTri)
botão GNRE (fAtualizaValorGnre) ─────────────┘
DETELE.DET_CALGNR ──► ENT_CALGNR ───────────────────────────► CALGNR.CAL_MEMCAL ◄── pGravaMemoriaDeCalculo
GERELE.GER_PREGNR ──► ENT_PREGNR (cobra prévia; libera fGravaCALGNR)
"P" ────────────────► ENT_GNRORI ◄── botão (S/T/P) ─────────► MOVTRI.DET_GNRORI / PREENT.ENT_GNRORI
rateio de impostos ─► ENT_ITETRI / ENT_VALADB ──────────────► MOVTRI.DET_ENTTRI
```

### `TMP_ENTMER` — itens da entrada em digitação

Tabela temporária criada por `pCriaTabelaEntradaMercadorias` (`untFuncoes`). Carga do XML por
`fCarregaItensNotaEletronica` = `fSqlInsertEntMer(True)` + `fSQLItensNotaEletronica`.

| Campo | Tipo | Nasce com | Quem altera | Quem lê / efeito |
|-------|------|-----------|-------------|------------------|
| `ENT_VALGNR` | `NUMERIC(12,2)` default 0 | `0` em toda carga, inclusive XML (a prévia vai para `ENT_VLRGNR`) | `TGNRE.fAtualizaValorGnre` (botão ST/Tributada/Padrão do resumo), só nos itens **marcados** | **Valor da GNRE do item.** Vai para `MOVTRI.DET_VLGNRE` (`fConfirmaEntradaMercadorias` → `fGravaMovDet`); entra no custo de última compra, no preço médio, em `ENT_SUBSTI` (exceto origem `T`), na checagem de preço abaixo do médio e no preço de venda/margem; `fSQLItens` usa como valor da tela quando > 0 |
| `ENT_VLRGNR` | `NUMERIC(12,2)` | `DETELE.DET_VLRGNR` (prévia), só em carga de XML | — | Valor sugerido na tela das guias ST/Padrão quando `ENT_VALGNR = 0`. Não segue para `MOVTRI` |
| `ENT_VALADB` | `NUMERIC(12,2)` | — | Rateio de impostos (`pRateiaImpostos`, `untFuncoes`) com `CFG_ATUADB = D` ou `CFG_GNRTEM` | **GNRE tributada calculada**: com CST tributado no XML e no cadastro e `CFG_SIMPAU`, `Base ICMS XML × (Alíq. interna − Alíq. NF) × %redução / 100 / 100`; senão `0`. Valor sugerido na tela da guia Tributada quando `ENT_VALGNR = 0` |
| `ENT_ITETRI` | `CHAR(1)` | `'N'` | Mesmo rateio: `'S'` quando o item se enquadra na regra de `ENT_VALADB` | **Habilita o item na guia Tributada** (`fSQLItens`: `ENT_ITETRI = 'S'`). Vai para `MOVTRI.DET_ENTTRI` |
| `ENT_DESADB` | `NUMERIC(12,2)` | Cadastro | Mesmo rateio, só com `CFG_ATUADB = D` | Diferencial de alíquota do item. Fora do escopo desta rotina; citado porque nasce no mesmo bloco |
| `ENT_GNRORI` | `CHAR(1)` | `'P'` em toda carga | `fAtualizaValorGnre`: `S`, `T` ou `P` conforme a guia; **`P` se o valor do item ficou 0** | **Origem da GNRE no item.** `T` tira a GNRE do percentual de substituição do custo (`ENT_SUBSTI`, `LTP_SUBSTI`). Vai para `MOVTRI.DET_GNRORI` e `PREENT.ENT_GNRORI` |
| `ENT_CALGNR` | `TEXT` | `DETELE.DET_CALGNR` (XML) ou vazio | Rateio de impostos (memória da GNRE tributada, se `ENT_VALGNR ≤ 0`); `pRecalculaGNRE`; `fAtualizaValorGnre` troca por `MSG_VLR_GNR_MANUAL` quando o valor difere do número após o último `=` da memória | Memória de cálculo. Vai para `CALGNR.CAL_MEMCAL` (`fGravaCALGNR`) |
| `ENT_PREGNR` | `CHAR(1)` | `GERELE.GER_PREGNR` | — | `'S'` = prévia confirmada na importação. No resumo, guia ST zerada dispara `pVerificaPrevia`; na gravação, libera `fGravaCALGNR` |
| `ENT_COMGNR` | `VARCHAR(1)` | Vazio | **Ninguém grava em `TMP_ENTMER`** — a marcação vive só no conjunto em memória da tela | Marcação "Com GNRE". `fSQLItens` recalcula a cada abertura: com XML, `'S'` se CST do XML é tributado ou `TRI_GERGNR`, senão o gravado ou `'N'`; sem XML, o gravado ou `'S'` |
| `ENT_GNRFIX` | — (só no `SELECT`) | — | — | Trava a marcação: com XML, `'S'` nos mesmos casos acima |
| `ENT_GNRTSU` | `NUMERIC(12,6)` | `DETELE.DET_BASSUB` (base ST calculada pelo sistema na importação) | — | Soma vira a base de cálculo sugerida (`fRetTotalBasSTCalculado`) |
| `ENT_CALSTU` | inteiro | `DETELE.DET_CALSTU`; `-1` após a entrada sem XML | — | Fórmula de base ST que mais se aproximou do XML: `0` padrão, `1` produto, `2` produto com desconto, `3` produto com IPI, `4` IPI com desconto. **Só > 0 é recalculado** por CT-e (`pRecalculaGNRE`) |
| `ENT_FRECON` | `NUMERIC(12,2)` | Rateio do conhecimento de frete | — | `> 0` indica CT-e: dispara a pergunta de recálculo (`CFG_URSTCL`) |
| `ENT_SITXML` | — | CST do XML | — | Filtra os itens de cada guia (`:TRIBUT`, `:SUBSTI`, `CADTRI.TRI_GERGNR`) |
| `ENT_VLTCIF` / `ENT_CLTCIF` / `ENT_ALQTCI` | `NUMERIC` | `0` / calculado / `PRO_TCIFCU` | `fAtualizaValorGnre` (TCIF): valor e `ENT_ALQTCI = valor × 100 / ENT_VLRCON` | `MOVTRI.DET_VALTCI` / `DET_CALTCI`; custo. A tela usa `ENT_VLTCIF` se > 0, senão `ENT_CLTCIF` |
| `ENT_VAL_TS` / `ENT_ALQ_TS` | `NUMERIC` | `0` / `PRO_TSCUST` | `fAtualizaValorGnre` (TS) ou `fRateiaTS` | `MOVTRI.DET_VAL_TS`; custo |
| `ENT_AUTELE` / `ENT_DETELE` / `ENT_DETEL2` | — | Chaves de `GERELE`/`DETELE` | — | Base do recálculo (`pRecalculaGNRE`) e da comparação "manual" em `fGravaCALGNR` |
| `CAL_BASICM`, `CAL_VLICMS`, `CAL_ALQICM`, `CAL_VR_IVA`, `CAL_BAS_ST`, `CAL_VR_SUB`, `CAL_ALQINT`, `CAL_VFCPST` | `NUMERIC` | Cálculo da importação | `pRecalculaGNRE` (no conjunto em memória) | Gravados em `CALGNR` por `fGravaCALGNR`; base dos ajustes `FISAJD` |

### `DETELE` / `GERELE` — importação do XML

| Campo | Gravado por | Significado |
|-------|-------------|-------------|
| `DETELE.DET_VLRGNR` | `TNFeXml` na gravação da nota importada, só com prévia confirmada | Valor de GNRE do item na prévia (`TfrmPreparaGNRE`, coluna `VALGNR`) |
| `DETELE.DET_CALGNR` | Idem | Memória de cálculo; vira `MSG_VLR_GNR_MANUAL` se o operador mudou o valor sugerido (`VALGNR ≠ VALGNR_ORIGINAL`) |
| `DETELE.DET_CALSTU` | `TNFeXml` (validação dos dados fiscais) | Fórmula de base ST mais próxima do ST do XML (0–4) |
| `DETELE.DET_BASSUB` | `TNFeXml` | Base ST calculada pelo sistema |
| `GERELE.GER_PREGNR` | `TNFeXml.fGravarNotaFiscal(…, blnPreGnre)` | `'S'` quando `fPreparaGNRE` retornou confirmado |

### `MOVTRI` — itens da nota gravada

| Campo | Na entrada | Após a entrada | Efeito |
|-------|-----------|----------------|--------|
| `DET_VLGNRE` | `fGravaMovDet` ← `ENT_VALGNR` | `TListGNRE.pUpdateMovTri`; com `CFG_GNRTEM`, total de todas as guias do conjunto | Valor da GNRE do item na nota |
| `DET_GNRORI` | `fGravaMovDet` ← `ENT_GNRORI` | Não é alterado | Lido como `ORIGEM` (`''` vale `P`): filtra os itens de guia gravada e tira a GNRE `T` de `LTP_SUBSTI` |
| `DET_ENTTRI` | `fGravaMovDet` ← `ENT_ITETRI` | — | Item enquadrado na GNRE tributada |
| `DET_VALTCI` / `DET_CALTCI` / `DET_VAL_TS` | `fGravaMovDet` ← `ENT_VLTCIF` / `ENT_CLTCIF` / `ENT_VAL_TS` | `pUpdateMovTri` (TCIF/TS) | TCIF e TS do item |
| `DET_IMPULT` | Entrada | `pUpdateMovTri` | Custo de última compra com impostos |

### Outras tabelas

| Tabela.campo | Gravado por | Significado |
|--------------|-------------|-------------|
| `CALGNR.CAL_MEMCAL` (+ `CAL_*`) | Entrada: `fGravaCALGNR` (`untPcmGer`), **só com `ENT_PREGNR = 'S'`**; após: `TListGNRE.pGravaMemoriaDeCalculo` | Memória de cálculo por item (`DET_SEQDET`). Vazia quando nem `MOVTRI` nem `DETELE` têm valor; "manual" quando o valor difere dos dois |
| `PREENT.ENT_GNRORI` | `pGravaPreEnt` (`untPcmGer`) | Origem da GNRE guardada com a composição de preço da entrada; relida por `untEntOutrasDespesas` |
| `CADGNR.GNR_ORIGEM` | `TGNRE.fGravaCadGnr` | Tipo da guia (S/T/P); define o tipo ao recarregar (`pCarregaGnre`) e a chave de `pDeletaGnre` |
| `CADGNR.GNR_GRAFIN` | `TGNRE.fGravaCadGnr` | A guia gerou contas a pagar; vazio é lido como `'S'` |
| `CADGNR.GNR_AUTFIS` | `TGNRE.fGravaCadGnr` | Liga a guia ao `CADFIS`; é a chave da lista após a entrada |

## Fluxo principal

### A) Durante a entrada (resumo)

1. Importação do XML: se há divergência de ST (`VSTCAL`/`VSTXML`) em itens de nota eletrônica,
   `TfrmEntNFEDivergencias.fPreparaGNRE` pergunta "Deseja preparar automaticamente a GNRE?" e abre
   `TfrmPreparaGNRE`. Com `CFG_GNRETN`, só usuário liberado abre a tela. Confirmar grava a prévia;
   cancelar marca a prévia como suspensa.
2. No `FormCreate` do resumo nascem quatro objetos `TGnre` (`objGnreST`, `objGnreTributado`,
   `objGnreTCIF`, `objGnreTS`), cada um com o seu tipo. Sem `CFG_GNRTEM`, o botão Tributada some e o
   objeto ST vira `tcGnrePadrao`.
3. O operador aciona um botão: `pTelaGnre` monta o conjunto de itens da guia a partir de
   `TMP_ENTMER` (`fVerificaItens` + `fSQLItens`), e se `CFG_URSTCL` e houver CT-e pergunta se
   recalcula (`pRecalculaGNRE`); depois abre `TfrmEntGNRE`.
4. Na tela, o operador preenche guia (fornecedor órgão público, UF, IE, datas, valor recolhido,
   base de cálculo, banco/agência/autenticação, plano de contas, centro de custo, portador, tipo de
   guia/tributo) e marca os itens. Gravar exige soma do "Valor GNRE" dos itens marcados = valor
   recolhido (`fVerificaTotalGNRE`).
5. Ao fechar com OK, `fAtualizaValorGnre` grava em `TMP_ENTMER` o valor de cada item marcado
   (`ENT_VALGNR`/`ENT_VLTCIF`/`ENT_VAL_TS`), a origem (`ENT_GNRORI`) e a memória de cálculo (`ENT_CALGNR`).
6. Na confirmação da entrada, ainda no resumo, se a prévia foi marcada (`ENT_PREGNR = 'S'`) e a guia
   ST está zerada, `pVerificaPrevia` cobra a digitação. Em seguida os quatro `fGravaGnre` rodam na
   cadeia de gravação da entrada: apagam a guia anterior do mesmo documento/origem, gravam
   `CADGNR`/`GNRTCI`/`GNR_TS`, os ajustes `FISAJD` (Portaria CAT 54/2020) e o contas a pagar.
   O valor dos itens em `TMP_ENTMER` segue para a nota em `fConfirmaEntradaMercadorias`
   (`untPcmGer`) → `fGravaMovDet` (`untMovGer`): `ENT_VALGNR` → `MOVTRI.DET_VLGNRE`,
   `ENT_GNRORI` → `DET_GNRORI`, `ENT_ITETRI` → `DET_ENTTRI`, TCIF/TS → `DET_VALTCI`/`DET_VAL_TS`.
   A memória vai para `CALGNR` (`fGravaCALGNR`) — ver *Campos que definem o comportamento*.

### B) Após a entrada (`TfrmDigGNRE` + `TListGNRE`)

1. `TListGNRE.Create` abre as guias já gravadas da nota (`GNR_AUTFIS = CADFIS.AUTOINCREM`).
2. Incluir: com `CFG_GNRTEM` o operador escolhe ST ou Tributada; `fValidaDocumento` carrega os itens
   gravados da nota (`MOVDET`/`MOVTRI`, ou das notas ligadas por conhecimento de frete) e
   `pAdiciona` abre `TfrmEntGNRE` para a guia nova.
3. Alterar: `pEdita` → `fEncontraGNRE` liga a guia ao conjunto de itens do tipo dela e abre a tela em
   modo edição (só autenticação bancária editável, salvo `CFG_PAGGNR = 2`).
4. Confirmar: `fGravaGnre` abre `TfrmGravando`, que executa `fGravaGnreInterna` **em transação**:
   - guia nova → `TGNRE.fGravaGnre` (sem apagar as demais), guia existente → `fGravaCadGnr` +
     `fAtualizaAutBancaria`;
   - `fGravaValoresItens` consolida o valor dos itens e recalcula `MOVTRI`, `ITEGER`, preço médio,
     `LOTPRE`, lote de preços pré-pro, memória de cálculo (`CALGNR`) e última compra do lote;
   - `fCommit` se tudo deu certo, senão `fRollBack`.

## Fluxos alternativos e exceções

- **Sem itens**: `fVerificaItens`/`fValidaDocumento` avisam que não há itens com ST no estado (ou
  tributados/ST no XML) e a tela não abre; a guia fica com valor `0`.
- **Cancelar a tela da guia**: `FormClose` restaura os itens do backup (`cdsBackup`); se houve
  recálculo por CT-e, `fTelaGnre` volta `ENT_VALGNR`, base e totais aos valores anteriores.
- **Valor zero ou fornecedor vazio**: `TGNRE.fGravaGnre` sai com `True` sem gravar nada — é o caso
  normal dos botões não usados.
- **Exclusão**: só guias ainda não gravadas (`GNR_INSERT = 'S'`); guia gravada só sai com o
  cancelamento da nota. A exclusão marca `FExcluida`, ignorada na gravação.
- **Erro na gravação após entrada**: qualquer `Result = False` interrompe o laço e dá rollback de tudo.
- **Rateio**: com `CFG_GNRRAT = 1`, "Ratear Valor da GNRE" zera e distribui o valor recolhido pelos
  itens marcados, proporcional a `ENT_TOTITE` (o último item leva o resto). Na TS o rateio é
  oferecido ao sair do campo de valor.
- **Prévia suspensa**: cancelar `TfrmPreparaGNRE` não bloqueia a importação; a cobrança volta na
  confirmação da entrada (`pVerificaPrevia`).

## Tabelas envolvidas

| Tabela | Uso (L/G) | Papel na rotina |
|--------|-----------|-----------------|
| `CADGNR` | L/G | Guias GNRE/GARE (ST, Tributada, Padrão). `GNR_ORIGEM` S/T/P, `GNR_AUTFIS` liga ao `CADFIS` |
| `GNRTCI` | L/G | Guias TCIF |
| `GNR_TS` | L/G | Guias TS |
| `FISAJD` | G | Ajustes de apuração (SPED/GIA) da Portaria CAT 54/2020 — três por item marcado |
| `TMP_ENTMER` | L/G | Itens temporários da entrada: valor da guia por item, origem, memória de cálculo, marcação, prévia (`ENT_PREGNR`), base ST (`ENT_GNRTSU`) |
| `MOVDET` / `MOVTRI` | L/G | Itens da nota gravada. `MOVTRI.DET_VLGNRE`/`DET_VALTCI`/`DET_VAL_TS` e `DET_IMPULT` são regravados após a entrada |
| `CALGNR` | L/G | Memória de cálculo da GNRE por item (`DET_SEQDET`, `CAL_MEMCAL`) |
| `ITEGER` | G | `ITE_FORULT`, `ITE_IMPULT`, `ITE_PREMED` — só quando a nota é a última compra do item |
| `LOTPRE` | L/G | Lote de preços ainda não atualizado: `LTP_SUBSTI`/`LTP_TCIFCU`, custo e venda recalculados |
| `GERELE` / `DETELE` | L | Capa e itens do XML — base do recálculo e da prévia (`DET_VLRGNR`) |
| `CADFIS` / `MOVGER` / `CONFRE` | L | Documento fiscal; notas ligadas por conhecimento de frete |
| `ABFICM`, `CADTRI`, `CADITE`, `CADUNI`, `CADNCM`, `MOVICD`, `CADFOR`, `PREPRO` | L | Tributação, CST que gera GNRE (`TRI_GERGNR`), NCM com IPI (TS), FCP, fornecedor, IPI de entrada |
| `TIPTRI` / `GUITRI` | L | Tipos de tributo e guias (códigos 4, 5, 6, 7) |
| `CADPAG` / movimento bancário | G | Contas a pagar da guia e baixa imediata — via `fGravaCadPag` (`untCadPag`) e `fGravaMovBan` (`untMovBan`) |

## Configurações (CFGSIS)

| Código | Valores | Efeito na rotina |
|--------|---------|------------------|
| `GNRTEM` | Boolean | Separa GNRE de produto ST e de produto tributado: mostra o botão Tributada no resumo, oferece a escolha na digitação após entrada e mantém os dois conjuntos de itens separados em `TListGNRE` |
| `FORGNE` | Cód. fornecedor | Fornecedor (órgão público) sugerido para a guia. Inválido gera aviso no resumo |
| `SUFRAM` | Boolean | Mostra os botões TCIF e TS no resumo; com `FRMCUS = 4` TCIF/TS entram no custo |
| `PAGGNR` | 1 / 2 / outro | `1`: grava contas a pagar sempre (checkbox marcado e travado). `2`: proíbe pagamento antecipado e libera datas/base/valor na edição de guia gravada |
| `CTPAVI` | Boolean | Vencimento em branco ou hoje = guia paga na hora: grava movimento bancário e baixa o contas a pagar. Exige portador |
| `HISCTP` | Boolean | Monta histórico com nota/fornecedor no contas a pagar e na baixa |
| `URSTCL` | Boolean | Recalcula a GNRE quando há CT-e (`ENT_FRECON`) e o item tem tipo de cálculo `ENT_CALSTU`; usa redução de carga média da empresa |
| `FRETRI` / `FRETIP` | Boolean / `D` | Frete compõe base de ICMS/ST e de IPI no recálculo. `FRETIP = D` usa `FOR_FRETIP` do fornecedor |
| `GNRX90` | `S` | Inclui CST de antecipação de ICMS (x90) entre os itens que geram GNRE |
| `IFCPST` | Boolean | Soma a diferença de FCP-ST ao valor da GNRE e mostra as colunas de FCP |
| `AJUGIA` / `GIAINT` / `GIAPRO` | Boolean / cód. ajuste | Gera os ajustes `FISAJD` da Portaria CAT 54/2020. Ligada sem os dois códigos: aviso na tela e erro na gravação |
| `GNRPLC` | Cód. plano de contas | Plano de contas sugerido para a guia |
| `GNRCRF` | Cód. tributo | Tipo de tributo sugerido (posiciona guia e tributo no frame do contas a pagar) |
| `GNREVE` | Cód. centro de custo | Centro de custo (evento) sugerido |
| `GNRRAT` | `1` | Mostra o botão de rateio (oculto em nota com XML quando `VALELE`) |
| `VALELE` | Boolean | Com nota eletrônica, esconde o rateio |
| `GNRETN` | Boolean | Exige liberação de usuário para abrir a prévia na importação |
| `USACTF` | Boolean | Plano de contas filtrado pelo fornecedor da guia |
| `CTPOBE` | Boolean | Centro de custo obrigatório |
| `TIPABF` | `1` / outro | Tributação lida de `CADITE` (1) ou de `ITEGER` |
| `FRMCUS`, `REDTAR`, `ATPVMB`..`ATPVM7`, `MEDEMP`, `BASMED`, `ULTPIS`, `TRDPCI`, `CONIPI`, `COFENT`, `ATUNMD`, `INFMAT`, `INFFED`, `INFSAI`, `INFOPE`, `DECUNI`, `ATUPIS`, `ATUDIC`, `EFEIMP` | vários | Recálculo de custo, preço médio e preço de venda após a entrada — ver [untGNRE](untGNRE.md) |
| `ATUADB` | `D` | Mostra a coluna de origem na lista de guias após entrada |

## Integrações e dependências

- `untCadPag` — `fGravaCadPag`, `pInicializaImpressaoCP`, `pAdicionaImpressaoCP`, `pImprimeCPs` (contas a pagar e cópia de cheque/CP).
- `untMovBan` + `untTBanCtpRepository` — baixa imediata (`CTPAVI`).
- `untEntPagtoAntecipado` — pagamento antecipado do fornecedor da guia.
- `untPrecoProduto`, `untProAlt`, `untLotePrecosPrePro`, `untParCalculaPrecoCusto`, `untCalculoUltimaCompraImpostos` — custo e preço após a entrada.
- `ContaPagar.TFrameCtaPagar` / `untFrameCtaPagar` — frame do contas a pagar na tela da guia.
- `untFechamentoFinanceiro` — bloqueia data da guia em período financeiro fechado.
- Não confundir com `padra_atualizado/fontes/Util_DLL/Gnre/untGNRE.pas` (DLL `libGNRE`): **mesmo nome de unit**, outro código.

## Regras de negócio conhecidas

1. O fornecedor da guia não pode ser o fornecedor da nota — deve ser órgão público.
2. A soma do valor por item marcado tem que ser igual ao valor recolhido, e o valor tem que ser > 0.
3. Data de vencimento ≥ data da guia.
4. Itens com CST tributado no XML ou CST marcado em `CADTRI.TRI_GERGNR` vêm marcados e não podem ser desmarcados (`ENT_GNRFIX`).
5. Valor da GNRE por item (recálculo) = ICMS-ST calculado pelo sistema − ICMS-ST do XML (+ diferença de FCP-ST com `IFCPST`), nunca negativo.
6. GNRE de origem `T` (tributada) **não** entra no `LTP_SUBSTI`/percentual de substituição do custo; a de origem S/P entra.
7. Valor de item diferente da memória de cálculo (ou do gravado/XML, após entrada) é registrado como "VALOR GNRE FOI INSERIDO MANUALMENTE PELO USUÁRIO." (`MSG_VLR_GNR_MANUAL`).
8. Guia já gravada não é excluída pela tela; só com o cancelamento da nota.
9. TCIF grava tipo de guia "GRU SIMPLES", receita `20800-00`; TS grava "GRU SIMPLES", receita `11113-9`; ambas com código de guia 11 no contas a pagar.
10. **O item é ST ou Tributado, nunca os dois.** A classificação vem da tributação cadastral do item
    no estado da empresa (`ABFICM.ABF_CODSIT` do perfil do fornecedor): a guia ST exige CST de ST
    (ou de antecipação); a Tributada exige `ENT_ITETRI = 'S'`, que só é marcado com CST cadastral
    tributado. Por isso basta um `ENT_VALGNR`/`ENT_GNRORI` por item, e `ENT_GNRORI` diz a qual guia o
    valor pertence. Os dois conjuntos de itens de `TListGNRE` também nunca se sobrepõem.
11. Com `CFG_GNRTEM`, `MOVTRI.DET_VLGNRE` de um item é o **total** de todas as guias da nota daquele conjunto (ST ou Tributada): base gravada + parcela de cada guia nova da digitação.

## Pontos de atenção

- `TListGNRE.AtualizarLotePrecosPrePro` e `fUpdateLotePrecos` testam `tcTCIF` duas vezes: o ramo da
  TS nunca executa, e a TS cai no cálculo de `LTP_SUBSTI` de ST. Defeito pré-existente, não corrigido.
- No recálculo com tipo `tcsgiIPIComDesconto`, `N23_VICMSST` é calculado sobre
  `N23_VICMSST_IPIComDesconto` (valor e não base). O valor da GNRE usa `N23_VICMSST_GARE`, então o
  efeito fica restrito a esse campo intermediário. A confirmar se é intencional.
- `fGravaCadGnr` chama `fAtualizaProCod` também na **edição**: a guia regravada recebe novo
  `GNR_NUMGNR`. A confirmar o efeito na chave do contas a pagar (`GNRE` + número).
- `fGravaCadAjustes` usa o código de ajuste `SP41090203` fixo no código (terceiro lançamento).
- `pDeletaGnre` mostra o erro mas não falha a gravação.
- **Desmarcar não zera em `TMP_ENTMER`.** `fAtualizaValorGnre` só atualiza itens marcados, e
  `ENT_COMGNR` não é gravado. Item que tinha valor numa abertura e foi desmarcado depois mantém o
  `ENT_VALGNR` antigo, que vai para `MOVTRI`. A confirmar em caso real.
- `fSqlInsertEntMer` + `fSQLItensNotaEletronica` montam um `INSERT … SELECT` **posicional**: o
  `SELECT` apelida `DET_VLRGNR AS ENT_VALGNR`, mas a coluna de destino naquela posição é
  `ENT_VLRGNR`. O apelido engana; vale a posição. Mexer numa lista sem a outra desalinha a carga.
- `ENT_CALSTU = 0` (fórmula padrão) nunca é recalculado por CT-e — `pRecalculaGNRE` só roda com valor > 0.
- `TfrmEntGNRE.pCalculaBaseGnre` usa `StrToFloat` (trava do pre-commit): qualquer edição nessa linha bloqueia o commit até trocar por `fStrToFloat`.
- `TfrmEntGNRE.pSetaEdit` percorre a variável global `frmEntGNRE`, não `Self`.
- A rotina de recálculo (`pRecalculaGNRE`) roda item a item com várias consultas (`GERELE`, `DETELE`,
  fornecedor, tributação) — em nota grande, abrir a tela com CT-e é lento.

## Histórico de alterações documentadas

| Data | Requisito/Revisão | Resumo |
|------|-------------------|--------|
| 2026-10-16 | Correção do operador | Removida a suposta sobreposição ST × Tributada no mesmo item: o item é exclusivamente ST ou Tributado pela tributação cadastral (regra 10) |
| 2026-10-16 | Mapeamento de campos, base r500183 | Nova seção *Campos que definem o comportamento*: ciclo de vida de `ENT_VALGNR`, `ENT_VLRGNR`, `ENT_VALADB`, `ENT_ITETRI`, `ENT_GNRORI`, `ENT_CALGNR`, `ENT_PREGNR`, `ENT_COMGNR`, `ENT_GNRTSU`, `ENT_CALSTU`, TCIF/TS, e dos campos de `DETELE`, `GERELE`, `MOVTRI`, `CALGNR`, `PREENT`. Confirmada a passagem `TMP_ENTMER` → `MOVTRI` por `fGravaMovDet` |
| 2026-10-16 | Alteração local sobre r500183 — requisito ainda sem número | Mapeamento inicial completo (`untGNRE`, `untEntGNRE`, `untPreparaGNRE`, botões de guia do resumo). Documentada a separação dos conjuntos de itens ST × Tributada em `TListGNRE` com `CFG_GNRTEM`, a cópia própria de itens para guia nova e a consolidação do valor dos itens entre guias gravadas e novas |
