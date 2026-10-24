# Registro — Req. 468382

**Assunto:** Reforma Tributária (CBS/IBS/IS) na entrada de mercadorias — grid do resumo fiscal, valor contábil,
tela Dados Fiscais e entrada automatizada.
**Período:** 07/10/2026 a 08/10/2026
**Zona:** Legado (`padra_atualizado/fontes/`)
**Relacionado:** Req. 410369 (r498960, caio.barbosa) — origem dos valores CBS/IBS/IS na entrada (XML → `DETERT`) e
gravação de `MOVREF`, `AUXFIS`, `AUXMOV` e `FIS_TOT*` em `untPcmGer`.

Documento de memória do requisito. `spec.md` é o contrato, `plan.md` o como, `tasks.md` o checklist; aqui fica o
porquê, a jornada e o que foi descartado.

---

## 1. Contexto de negócio

A Reforma Tributária (EC 132/LC 214) cria CBS (federal), IBS (estadual + municipal) e IS (seletivo). No XML da
NF-e de 2026 eles vêm no grupo `IBSCBS`/`IS` por item; o total da nota passa a ter `vNFTot` = `vNF` + CBS + IBS
(+ IS). O projeto Reforma da Citel foi dividido em partes: 396975 (cadastros), **410369 (suprimentos — entrada)**,
397800 (faturamento).

O 410369 (r498960) passou a importar as tags do XML para `DETERT` (filha de `DETELE`) e `GERERT` (filha de
`GERELE`), trazê-las para os itens da entrada (`untFuncoes.fSQLItensNotaEletronica`, LEFT JOIN `DETERT`, campos
`ENT_RF*`/`ENT_REFVBC`) e gravá-las em `MOVREF` (por item), `AUXFIS` (blocos do livro por classificação),
`AUXMOV` e `CADFIS.FIS_TOT*` (totais).

Este requisito cuidou do que faltava para a entrada ficar coerente com o livro fiscal e o faturamento:

1. **Etapa 1** — o resumo dos dados fiscais (`untEntDadosFiscaisResumo`) era uma grade de 132 edits; virou um
   `TcxDBVerticalGrid` com linhas para CBS/IBS/IS.
2. **Etapa 2** — CBS + IBS + IS passam a **compor o valor contábil** do item (quando a configuração manda) e a tela
   Dados Fiscais (`untEntDadosFiscais`) ganha os campos da Reforma no grid e na edição.
3. **Etapa 3** — a **entrada automatizada** (`frmEntMercadoriasAutomatizada`) recebe o mesmo tratamento: valor
   contábil, livro fiscal preenchido (para a gravação do 410369 funcionar) e guia Livro Fiscal com o mesmo grid.

### 1.1 A configuração que governa tudo

`untFuncoesGenerica.fSomarNovosImpostosDaReformaAoValorContabil` (há um wrapper de mesmo nome em
`untFuncoesSimples` que só delega):

```pascal
Result := False;
If fCfgSis('REFCIS', varString) = 'N' Then Exit;
If (fCfgSis('SIMPAU', varString) = 'S') And (fCfgSis('SIMHIB', varString) = 'N') Then Exit;
Result := True;
```

Decisão do usuário: **a mesma função** controla a soma no valor contábil e a visibilidade dos campos/linhas da
Reforma nas telas. Sem ela, tudo fica como antes.

---

## 2. Etapa 1 — grid do resumo (`untEntDadosFiscaisResumo`)

### 2.1 Problema

`pnlDetalhes` tinha 132 `TDBEditFocus` + 28 `TLabel` + 5 `TBevel` (22 atributos × 6 colunas: 1ª a 5ª
classificação + Total), ~4.100 linhas de DFM, `pAjustaTamahoCamposCadFis` com 120+ `pSetHeight`, código lendo
valor fiscal por `Edit.Text` e nenhum espaço para CBS/IBS/IS. O dataset (`cdsCadFis`) tem **um registro**; cada
célula é um campo `FIS_<atr><n>` / `FIS_<atr>T`.

### 2.2 Solução e decisões

- `TcxDBVerticalGrid` (`vgrDetalhes`) com `TcxDBMultiEditorRow` por atributo.
- `TcxDBMultiEditorRow` não tem título único de linha (o cabeçalho é repartido entre os editores) →
  `OptionsView.ShowHeaders = False` e o **editor 0 sem campo** mostra o título (`OnGetDisplayText` devolve o
  `Caption`).
- Com `ShowHeaders = False` o grid zera o divisor entre editores (`cxVGrid.pas`, `CalcLayoutGeneral`) → editor
  **espaçador** sem campo entre colunas (13 editores por linha). Larguras são proporcionais: título 1600 (depois
  1800, ver §6.2), valor 800, espaçador 20 (mínimo do DevExpress), `RowHeaderMinWidth = 0`.
- `pGetContentStyleDetalhes`: editor sem campo recebe `cxsTituloDetalhes` (negrito, cor do fundo).
- Tema: com skin (`AUTCOM_STYLE_NAME`, fora do modo clássico) o `TfrmPai` troca a cor `$00FFE4D5` só nos
  controles VCL; `pAjustarFundoTema` faz o mesmo no estilo do grid e em `GridLineColor`.
- Formato `#,##0.00` **só no grid** (`TcxCurrencyEditProperties`). `pFormataEditsValores` foi removida: rodava no
  `FormCreate`, antes de `dtsCadFis.DataSet` existir, e não tinha efeito (o formato real era `'##0.00'` de
  `pSetaClientCadFis`). Os campos do `cdsCadFis` compartilhado não mudam.
- Valor nulo aparece `0,00` (`pGetDisplayTextValor`) **só na tela**: o `cdsCadFis` vai para o `CADFIS` e lá
  nulo ≠ zero. Classificação vazia aparece `-` (`pGetDisplayTextClaFis`), centralizada.
- `pAjustaLinhasDetalhes` — mesma regra de `TfrmCadLivroFiscal.pJustaCamposImpostos`: linha de base sempre; linha
  de valor só se alguma classificação tiver base > 0. Bases CBS/IBS/IS só com a configuração; valores com a
  configuração **e** base > 0.
- Ordem das linhas = aba Documentos do `untCadLivroFiscal` (Desp. Acess. em posição definida pelo usuário).
- Leituras que usavam edits: `fRetClaFisCadFis(n)` e `fRetVlrContabilCadFis` (devolvem `''`/`0` sem dataset —
  Pré-Nota tem `dtsCadFis.DataSet = nil` e o `IIf` avalia os dois ramos).
- `FIS_VLCONT` ao pagamento antecipado: `fStrToFloat(FormatFloat('0.00', ...))`, **não** `RoundTo` — `RoundTo`
  diverge nos meios exatos (,125) e mudaria o centavo em relação à leitura antiga do texto formatado.

### 2.3 Merge com o r498960 (07/10)

O r498960 chegou durante o trabalho, alterando os mesmos arquivos (incluindo 18 edits de Valor CBS/IBS/IS no
`pnlDetalhes` do resumo). Resolução:

- Valem os campos e o **cálculo** do 410369 (a RN02 original — "linhas só estrutura, valor 0" — ficou superada).
- Este requisito só acrescentou os totais de base `FIS_BCCBST`/`FIS_BCIBST`/`FIS_BC_IST`, que o grid usa na coluna
  Total e o 410369 não criou.
- Os edits do 410369 no resumo foram substituídos pelo grid; a geometria dele fora do `pnlDetalhes` foi mantida.
- O r498960 deixou **LF solto** nas linhas que tocou (`untEntDadosFiscais.pas`: 29; `untEntradaAutomatizada.pas`:
  22). Preservados como estão na HEAD; as linhas deste requisito são CRLF.

---

## 3. Etapa 2 — valor contábil e tela Dados Fiscais

### 3.1 Valor contábil (`untFuncoes.pRateiaImpostos`)

`pRateiaImpostos` monta a `TMP_ENTMER`; a função local `pCalculaImpostosItens` é o **único ponto** que grava
`ENT_VLRCON` no rateio e cobre os três ramos (perfil aduaneiro, NF-e CFOP 3, normal).

- Flag lida uma vez no corpo: `blnSomaReforma := fSomarNovosImpostosDaReformaAoValorContabil`.
- Função local `fValorReformaItem` = `ENT_RFCVAL + ENT_RFIUFV + ENT_RFIMNV + ENT_RFSVLR` (com `FindField`, para
  chamadores sem os campos).
- Somada **depois** de `fRetornaValorOutras`: Outras/Isentas são apuradas sem a Reforma, como no livro fiscal
  (`untCadLivroFiscal`) — a Reforma é parcela somada ao valor contábil, não repartida em Outras.
- Decisão do usuário: o financeiro (total geral, contas a pagar, boleto, pagamento antecipado) **acompanha** o
  valor contábil.

### 3.2 Tela `untEntDadosFiscais`

- Grid `dbgItens`: 10 colunas após `Vr. Outras` (Base IBS/CBS; Alq./Vr. CBS; Alq./Vr. IBS Est.; Alq./Vr. IBS
  Mun.; Base/Alq./Vr. IS), visíveis só com a configuração.
- Edição: mesmos 10 campos, comportamento dos impostos existentes — base e alíquota editáveis, valor calculado e
  somente leitura. **Base IBS/CBS única** (`ENT_REFVBC`), como no XML e no `MOVREF.REF_BASCAL`; IS com base
  própria (`ENT_RFSBAS`).
- Alíquota exibida = **efetiva** (`*ALE`/`*UFE`/`*MNE`) quando > 0, senão a nominal; ao gravar volta para a mesma
  coluna de onde foi lida (`fCampoAlqReforma`, conjunto fixo de nomes — não é dado digitado). Alíquotas com 4
  casas (`DECIMAL(7,4)`).
- Valor recalculado (base × alíquota / 100) **só quando o campo foi digitado** (`Modified`), para não reescrever o
  valor do XML (IS com alíquota específica por unidade não é base × alíquota).
- `pRecalculaValoresReforma` aplica a diferença da Reforma ao `edtVlrCon` do item (RN14).
- `fValidaValorContabil` ganhou o parâmetro `fltReforma`, somado em todas as fórmulas.
- Gravação: `fAtualizaItem` (UPDATE na `TMP_ENTMER`); daí segue para `MOVREF` por
  `untPcmGer.pCarregaRefTribItemEntrada`, sem alteração.

### 3.3 Reorganização do `pnlValores` (feita pelo usuário no IDE)

O usuário dividiu o painel em `pnlCfop`, `pnlImpostos` e `pnlImpostosReforma` (alTop). Consequências tratadas:

- Visibilidade da Reforma só pelo `pnlImpostosReforma`.
- `pHabilitaCampos` do `TfrmPai` percorre **só filhos diretos** → `pHabilitaCamposValores` chama os três
  sub-painéis. `pEscapePressed` testa o `Parent` contra os três.
- O último campo editável deixa de ser `edtOutras`: com a Reforma visível passa a ser `edtAlq_Is`. O bloco que
  vivia na saída de `edtOutras` (conferência do valor contábil + validação de CST + `fAtualizaItem`) foi extraído
  para `fConfirmaItemEditado`, chamado pela saída do último campo.
- `pAjustaAlturaValores`: altura do `pnlValores` = soma dos sub-painéis visíveis + bordas; o form acompanha a
  diferença (o grid mantém a altura). Idempotente — o form é criado uma vez e reaberto pelo `pShow`.
- O IDE embaralhou os TabOrders na reorganização; foram restaurados.

### 3.4 Por que alterar a CBS não reprova a conferência (dúvida do usuário, 08/10)

Nos demais campos o valor contábil é **fixo** (vem do rateio, o campo é desabilitado) e a edição só
**redistribui** entre parcelas: mudar Base ICMS, ST, Isentas ou Outras sem compensar reprova a conferência
(`frmMsgValidacaoContabil`). Alíquota ICMS não reprova porque a conferência usa a base, não o valor.

A Reforma soma **por cima** do `vNF`. Se o valor contábil ficasse fixo, alterar a CBS sempre reprovaria e a única
forma de passar seria distorcer Outras, gravando o livro errado (RN10). Por isso a regra é o valor contábil do
item acompanhar (RN14). **Decisão confirmada pelo usuário.**

---

## 4. Etapa 3 — entrada automatizada

### 4.1 Diagnóstico

A automatizada (`TEntradaAutomatizada`, `untEntradaAutomatizada.pas`; tela `untEntMercadoriasAutomatizada`)
**não** usa `pRateiaImpostos`:

| Ponto | Onde | Situação encontrada |
|---|---|---|
| Itens | `cdsItens` ← `fSQLItensNotaEletronica` | já trazia `ENT_RF*`/`ENT_REFVBC` (r498960) |
| Cálculo do item | `pAjustaDadosFiscaisItem` | calcula `ENT_VLRCON` e Outras/Isentas próprios; sem Reforma |
| Agrupamento | `fMontaGrupoLivro` → `cdsGruLiv` (CFOP + alíquota ICMS) | sem colunas da Reforma |
| Livro | `fGeraLivroFiscal` → `cdsCadFis` | campos `FIS_VLCBS*` etc. existiam (`pCriaClientLivro`) mas ficavam **nulos** |
| Gravação | `untPcmGer.fConfirmaEntradaMercadorias` (mesma da entrada normal) | `MOVREF` já gravado; `FIS_TOT*`/`AUXFIS`/`AUXMOV` só gravam se `FIS_VLCBST + FIS_VLIBST + FIS_VL_IST > 0` → saíam zerados |
| Guia Livro Fiscal | `tbsLivro` → `pnlDetalhes` | 120 `TDBEditFocus` + 26 `TLabel` + 5 `TBevel`, 20 linhas |

Conclusão: bastava preencher o livro; **`untPcmGer` não precisou mudar**.

### 4.2 Solução

- `pAjustaDadosFiscaisItem(const AblnSomaReforma: Boolean)`: depois de Outras/Isentas, soma CBS + IBS UF + IBS Mun
  + IS ao `ENT_VLRCON`. A flag é calculada uma vez em `fMontaGrupoLivro` (`FindField('ENT_RFCVAL')` +
  configuração). Somar ali é **idempotente**: os dois ramos (CFOP 3 e normal) recalculam `ENT_VLRCON` do zero, e
  o livro é refeito sempre que os itens mudam (`pAfterPostItens`).
- `fCriaClientGruposFiscal`: 5 aliases `0.00` (`ENT_VLRCBS`, `ENT_VLRIBS`, `ENT_VLR_IS`, `ENT_BASRT`, `ENT_BAS_IS`);
  `fMontaGrupoLivro` acumula nos dois ramos (FindKey/Append). IBS = UF + Mun; a mesma base serve para CBS e IBS.
- `fGeraLivroFiscal`: zera os 6 campos nas 5 classificações, preenche por classificação e grava os totais `T`
  (mesma regra de `untEntDadosFiscais`).

### 4.3 Guia Livro Fiscal — "igual ao resumo, inclusive a ordem"

Requisito do usuário: o grid deve ser **o mesmo** do resumo (29 linhas, mesma ordem, estilos, espaçadores,
larguras, tema, `0,00`/`-`, regra de visibilidade). O bloco do DFM foi copiado do resumo por script e reindentado.

- **Monofásica**: o usuário primeiro escolheu não incluir; ao pedir "o mesmo do resumo, inclusive a ordem", as
  duas linhas entraram. A automatizada não calcula monofásica → Quantidade mostra `0,00` e Valor fica oculto (sem
  base).
- Grade de itens (`cxvItens`) sem colunas da Reforma — fora de escopo (decisão do usuário).

### 4.4 Eventos e validações dos componentes removidos (exigência do usuário: "não perder")

Inventário feito por script sobre o DFM antes de remover:

| Antes | Depois |
|---|---|
| `OnEnter = dbeClfSc1Enter` nos 6 edits `FIS_CLFSC1..5`/`T`: guarda `OldCfop`, `cdsCadFis.Edit`, libera edição | `vgrDetalhes.OnEditing`: se o campo começa com `FIS_CLFSC`, guarda `OldCfop` e `cdsCadFis.Edit` |
| `OnExit = dbeClfSc1Exit`: `fExisteCFOP` + `fCFOPPodeSerUtilizada` → `Post`, troca `ENT_CLAFIS` dos itens com o CFOP anterior, `pDefineSeGravaCTP`; senão `Cancel` + mensagem `CFG_CFEAAL` | `vgrDetalhes.OnEdited` → `pConfirmaTrocaCfop` (mesmo corpo; `Post` só se `dsEdit`) + `pAjustaLinhasDetalhes` |
| `ReadOnly = True` liberado só no Enter | editores do CFOP sem `ReadOnly`; os demais com `ReadOnly` |
| `CharCase = ecUpperCase`, `TipoTexto = ttNumerico` | `TcxMaskEditProperties`, `ecUpperCase`, `MaskKind = emkRegExpr`, `EditMask = '\d*'` |
| **12 edits FCP ST sem `ReadOnly`** (`FIS_BFCPS*`/`FIS_VFCPS*`): digitação ia ao `cdsCadFis` → `CADFIS` | editores FCP ST sem `ReadOnly`; `OnEdited` faz `Post` se `dsEdit` (antes o dataset ficava em edição até outro `Post`) |
| `Tag = 99`, `Requerido = False`, `OnKeyDown := pOnKeyDownEdits` (atribuído pelo `TfrmPai` a todo `TDBEditFocus`) | nada a preservar: `fValidaCampos` do form não tem ramo para esses edits e o `inherited` só barra `Requerido = True` |
| `PanelInfo = pnlInfo` nos 6 do CFOP, sem `Hint` | **a confirmar** — a unit do componente não está na working copy |
| `fStrToFloat(dbeVlConT.Text)` (pagamento antecipado) | `fRetVlrContabilCadFis` (mesmo critério do resumo) |

Mecânica do DevExpress verificada no fonte (`C:\Componentes\Seattle\...\cxInplaceContainer.pas`,
`TcxEditingController.DoHideEdit`): `PostEditingData` grava o valor digitado no campo **antes** de
`DoEdited`; `DoEdited` é chamado **também no Esc** (Accept = False). Consequência mantida de propósito: sair da
célula do CFOP sem alterar revalida o CFOP atual — numa classificação vazia aparece a mensagem `CFG_CFEAAL`, como
o Exit antigo fazia.

`pAjustaLinhasDetalhes` é chamado no **`OnShow` do `tbsLivro`** (não em `pgcAbasChange`, que só dispara por
clique — há troca de guia por código, ex.: Enter no último item em `cxvItensEditKeyDown`) e após a troca de CFOP.
`pAjustarFundoTema` no `FormCreate`.

---

## 5. Validação no banco (NF 52910668, schema `2_30_74_150_COM`)

Mesma nota gravada pelos dois caminhos.

### 5.1 Entrada normal — `MOVGER` 00100000000122439003, fornecedor 90490400

| Item | CFOP | Produto | IPI não cred. | Base IBS/CBS | CBS (0,9%) | IBS UF (0,1%) | Valor contábil | `vItem` XML |
|---|---|---|---|---|---|---|---|---|
| ABO 3 | 1403 | 122,68 | — | 111,34 | 1,00 | 0,11 | 123,79 | 123,79 |
| EDER | 1121 | 100,00 | 1,00 | 87,06 | 0,78 | 0,09 | 101,87 | 101,87 |
| RAFA | 1101 | 80,00 | 4,00 | 69,36 | 0,62 | 0,07 | 84,69 | 84,69 |

`GER_VLRCON` = `FIS_VLCONT` = `FIS_TOT_NF` = 310,35 = `vNFTot` (`vNF` 307,68 + CBS 2,40 + IBS 0,27).
`FIS_TOTCBS` 2,40, `FIS_TOTIBS` 0,27. Outras por classificação sem a Reforma (80 / 100 / 122,68). `AUXFIS`,
`AUXMOV` e `MOVREF` corretos (alíquotas nominais gravadas, efetivas 0 — XML sem redução; IBS municipal 0).

### 5.2 Entrada automatizada — `MOVGER` 00100000000122444003, fornecedor 10000228

Comparação tabela a tabela por script (`compara_nf.py`, campos de chave/data/hora ignorados):

- `MOVDET` (valores), `MOVREF`, `AUXMOV` (totais) e `FIS_TOT*`: **idênticos** à entrada normal.
- Diferenças só da operação: fornecedor do ES, material de uso e consumo → CFOP 2407/2556, item 06140, custo,
  CST, PIS/COFINS, data de entrada preenchida.
- Livro reagrupado em 2 classificações e somado corretamente:

| Classificação | Valor contábil | Outras | IPI não cred. | Base IBS/CBS | CBS | IBS |
|---|---|---|---|---|---|---|
| 2407 (ABO 3) | 123,79 | 122,68 | — | 111,34 | 1,00 | 0,11 |
| 2556 (EDER + RAFA) | 186,56 | 180,00 | 5,00 | 156,42 | 1,40 | 0,16 |

- `AUX_GRACTP = 'N'` (CFOP sem contas a pagar) → **financeiro não exercitado** (duplicatas, boleto, antecipado).

### 5.3 Observações da conferência (não são defeito desta alteração)

- `GER_DTAENT`/`FIS_DTAENT` nulos na entrada normal: `untPcmGer.fZeraDataEntrada` (conferência depois da entrada).
- `MOVDET.DET_VAEIPI` = 0 em toda a base (29.985 itens recentes): o IPI não creditado vive só no `CADFIS`.
- `CFGSIS` desta base não tinha `REFCIS`/`SIMPAU`/`SIMHIB` cadastrados (colunas `SIS_CODEMP`, `SIS_CODCFG`,
  `SIS_VALCFG`); a soma ocorreu, então o padrão de `fCfgSis` habilita.

---

## 6. Ajustes posteriores (08/10)

### 6.1 Total geral errado após editar um item

**Sintoma (usuário):** após o Calcula Impostos o total geral era 310,35; editar um item sem alterar nada mudava o
total.

**Causa:** dois cálculos de total em `untEntDadosFiscais`:

- `pCalculaTotaisCabecalho` — `SUM(ENT_VLRCON)` (− `ENT_DESESP` com desconto incondicional); usado ao fim do
  Calcula Impostos.
- `pCalculaTotalGeral` — fórmula do cabeçalho `TotLiq + TotIpi + DesAce + TotRet + ValFre`; chamada por
  `pRecalculaTotalGeral`, que `fConfirmaItemEditado` usava. A fórmula **não tem IPI não creditado
  (`ENT_VAEIPI`), FCP ST nem CBS/IBS/IS** → 302,68 nesta nota (5,00 de IPI não creditado + 2,67 da Reforma a
  menos). A falta do IPI não creditado e do FCP ST é **anterior** a este requisito; a Reforma só aumentou a
  diferença.

**Correção:** em `fConfirmaItemEditado`, depois de `pRecalculaTotalGeral` (que também atualiza IPI/ST do
cabeçalho), chamar `pCalculaTotaisCabecalho`.

**Descartado:** trocar `pRecalculaTotalGeral` inteira por `SUM(ENT_VLRCON)` — ela é usada também em caminhos
**antes** do Calcula Impostos (cancelar e restaurar `TMP_ENTTMP`, rateio de IPI), quando `ENT_VLRCON` ainda não
está calculado. A fórmula continua nesses caminhos (fora de escopo, registrado na spec §7).

### 6.2 Título "Base Fundo Combate a Pobreza ST" cortado

Coluna de títulos de 1600 → 1800 unidades (~+23 px) nas 29 linhas dos dois forms; `vgrDetalhes.Width` 757 → 780
(mantém as colunas de valor); no resumo `pnlCheckBox.Left` 764 → 787.

---

## 7. Arquivos alterados

| Arquivo | O quê |
|---|---|
| `genericos/untFuncoes.pas` | `pRateiaImpostos`: `blnSomaReforma`, `fValorReformaItem`, soma após Outras |
| `movimentacaoitens/untEntDadosFiscaisResumo.pas/.dfm` | `vgrDetalhes`; helpers; `pAjustaLinhasDetalhes`; tema |
| `movimentacaoitens/untEntDadosFiscais.pas/.dfm` | totais de base no livro; campos da Reforma no grid e na edição; painéis; `fConfirmaItemEditado`; total geral |
| `movimentacaoitens/untEntradaAutomatizada.pas` | `pCriaClientLivro` (aliases); valor contábil; `cdsGruLiv`; `fGeraLivroFiscal` |
| `movimentacaoitens/untEntMercadoriasAutomatizada.pas/.dfm` | guia Livro Fiscal em `vgrDetalhes`; CFOP/FCP ST editáveis; `fRetVlrContabilCadFis` |

`untPcmGer.pas` e `untPreNota.pas`: **sem alteração**. `opcoes.ini` e `rev.inc` aparecem modificados por ambiente
local e **não** vão no commit.

---

## 8. Achados colaterais não corrigidos

- Fórmula `pCalculaTotalGeral` sem IPI não creditado, FCP ST e Reforma nos caminhos anteriores ao Calcula Impostos.
- `MOVDET.DET_VAEIPI` nunca preenchido (IPI não creditado só no `CADFIS`).
- `pnlCheckBox` some junto com `pnlDetalhes` na Pré-Nota (herdado).
- Entrada automatizada: troca de CFOP pela grade numa classificação vazia mostra a mensagem `CFG_CFEAAL` ao sair
  (herdado do Exit antigo, mantido).
- Duplicatas do XML (`DUPELE`, soma de `vNF`) ficam menores que o valor do documento (`vNFTot`) com a configuração
  ativa — cai no fluxo de "parcelas menores que o documento" de `fPedeDuplicatas`; a testar.

---

## 9. Armadilhas e lições de processo

- **Encoding:** fontes cp1252; nunca Edit/Write. Todas as edições foram por script Python em bytes, com âncora
  única, conferência de não-ASCII e de LF solto antes/depois. `.md` em UTF-8/LF.
- **IDE sobrescreve edição externa:** com o form aberto no Delphi, salvar no IDE desfez a primeira redução de
  largura do grid. Fechar/recarregar o form antes de salvar.
- **Conferência estrutural de DFM:** a conta "objetos − ends + itens − `end>`" não fecha em zero no DFM da
  automatizada (deslocamento −2 de origem); comparar com o valor do arquivo original, não com zero.
- **Declarações no `.pas`** não ficam em bloco contíguo por painel (`dtsCadFis` no meio) — remover por nome, não
  por intervalo.
- **Bash heredoc** com script Python longo e aspas falha ("unexpected EOF"); gravar o script em arquivo.
- **Banco:** colunas reais descobertas via `information_schema` (não existem `GER_TOTITE`, `FIS_VLCONT` em
  `MOVGER`, `AUX_TOTPRO`, `CFG_CODCFG`, `DET_TIPMOV`). Chaves: `AUXFIS.FIS_SEQFIS` = `CADFIS.AUTOINCREM`;
  `AUXMOV.AUX_SEQGER` = `MOVGER.AUTOINCREM`; `MOVREF.REF_SEQGER` = `MOVDET.AUTOINCREM`; `MOVDET.DET_SEQGER` =
  `MOVGER.AUTOINCREM`.
- **Credencial:** a senha do banco foi colada no chat duas vezes. Usada só como variável de ambiente dentro do
  comando; recomendado trocar a senha e configurar com `autcom_db.py --configurar`.

---

## 10. Testes e pendências

Sem teste automatizado — dispensa registrada na spec §5 (a entrada depende de form, `TMP_ENTMER` e conexão; o
`AutcomTestesClientes` cobre faturamento). Validação manual + conferência no banco (§5).

Pendente em 08/10/2026 (ver `tasks.md`): compilar e salvar os forms no IDE; confirmar `PanelInfo`; testes de tela
da automatizada (troca de CFOP, FCP ST, configuração inativa); nota da automatizada com contas a pagar (duplicatas,
boleto, antecipado); teste do total geral após editar item; DelphAI e commit com `Req. 468382`.
