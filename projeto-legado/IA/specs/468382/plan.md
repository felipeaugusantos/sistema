# Plano de Execução — Req. 468382

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Troca de componente visual em form legado (`TfrmEntDadosFiscaisResumo`), sem alterar regra fiscal nem gravação.

- `TcxDBVerticalGrid` (`vgrDetalhes`) declarado no DFM, `DataController.DataSource = dtsCadFis`, dentro de `pnlDetalhes`, `Align = alLeft`, largura suficiente para 6 colunas; `pnlCheckBox` permanece à direita.
- Cada atributo fiscal é uma `TcxDBMultiEditorRow` com 6 editores (`Properties.Editors[0..5]`), cada editor com `DataBinding.FieldName` = `FIS_<attr>1..5` / `FIS_<attr>T`. Mesmo recurso já usado em `cadastros/untAtributosProduto.pas` (criado em runtime lá; aqui no DFM).
- Primeira linha (`rowTitulos`) sem campo: editores sem `FieldName`, texto vindo de `OnGetDisplayText` (`'1a Class.'` … `'Total'`), negrito.
- Somente leitura: editores com `Properties.ReadOnly = True` (permite foco, seleção e Ctrl+C nativo do inplace editor); grid com `TabStop = False`.
- Campos novos CBS/IBS/IS: aliases em `TEntradaAutomatizada.pCriaClientLivro`, preenchidos com 0 em `untEntDadosFiscais`.
- Código que lia `dbeXxx.Text` passa a ler `dtsCadFis.DataSet.FieldByName(...)`.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `untEntDadosFiscaisResumo.dfm` | `padra_atualizado/fontes/movimentacaoitens/` | alterar — remover 132 `TDBEditFocus`, 28 `TLabel`, 5 `TBevel` de `pnlDetalhes`; incluir `vgrDetalhes` com 29 linhas |
| `untEntDadosFiscaisResumo.pas` | `padra_atualizado/fontes/movimentacaoitens/` | alterar — declarações, `uses`, leitura via dataset, `pFormataEditsValores`, remover `pAjustaTamahoCamposCadFis` |
| `untEntradaAutomatizada.pas` | `padra_atualizado/fontes/movimentacaoitens/` | alterar — 36 aliases em `pCriaClientLivro` |
| `untEntDadosFiscais.pas` | `padra_atualizado/fontes/movimentacaoitens/` | alterar — `pAddValueByField` dos campos novos = 0 (classes em uso e Total) |
| `untPreNota.pas` | `padra_atualizado/fontes/movimentacaoitens/` | sem alteração — só validar (usa `pnlDetalhes` e `pnlCheckBox`, nomes mantidos) |

## 3. Sequência de implementação

1. **Levantamento do DFM atual** — extrair, de `untEntDadosFiscaisResumo.dfm`, a lista (nome do componente → `DataField`) dos 132 edits e os captions das 28 labels; servirá de gabarito para as 28 linhas do grid e para conferir que nenhum campo foi perdido (atenção aos totais com nome irregular: `FIS_BAERET`, `FIS_VAERET`, `FIS_BAEIPI`, `FIS_VAEIPI`, `FIS_BFCPST`, `FIS_VFCPST`).
2. **`untEntradaAutomatizada.pas` — `pCriaClientLivro`** — incluir, no mesmo padrão `SQL.Add(' 0.00 AS FIS_XXXXXN,')`, os campos `FIS_BCCBS`, `FIS_VLCBS`, `FIS_BCIBS`, `FIS_VLIBS`, `FIS_BC_IS`, `FIS_VL_IS` com sufixo `1..5` e `T` (antes do `AUTOINCREM`, que fecha a lista sem vírgula).
3. **`untEntDadosFiscais.pas`** — no laço por classificação (~linha 2770-2810): `pAddValueByField('FIS_BCCBS' + strContador, 0)` etc.; na seção de totais (~linha 2815-2835): `pAddValueByField('FIS_BCCBST', 0)` etc.
4. **`untEntDadosFiscaisResumo.pas` — leitura via dataset:**
   - linhas 1709, 2276, 2277, 4636, 4764, 4765: `dbeClfSc1.Text` → `dtsCadFis.DataSet.FieldByName('FIS_CLFSC1').AsString`
   - linhas 2021, 2024: `TDBEditFocus(FindComponent('dbeClfSc'+IntToStr(intIdx))).Text` → `dtsCadFis.DataSet.FieldByName('FIS_CLFSC'+IntToStr(intIdx)).AsString`
   - linha 3558: `fStrToFloat(dbeVlConT.Text)` → `RoundTo(dtsCadFis.DataSet.FieldByName('FIS_VLCONT').AsFloat, -2)`
5. **`pFormataEditsValores`** (linha 1846) — percorrer as linhas de `vgrDetalhes` (`TcxDBMultiEditorRow`) e, para cada editor com `DataBinding.Field` atribuído, aplicar a mesma regra de hoje (`TFloatField` → `DisplayFormat '#,##0.00'`; `TStringField` → `Alignment taRightJustify`). Manter a chamada na linha 730.
6. **Remover `pAjustaTamahoCamposCadFis`** (declaração ~linha 499, implementação ~linha 5684, chamada ~linha 3799 dentro de `If not FblnAcessadoViaPrenota`).
7. **DFM** — remover os 165 componentes de `pnlDetalhes` (preservando `pnlCheckBox` e filhos); incluir `vgrDetalhes` com `rowTitulos` + 28 `TcxDBMultiEditorRow`; títulos de linha iguais aos labels atuais (sem os dois-pontos, ou com — manter o texto atual), CBS/IBS/IS ao final; ajustar `TabOrder` de `pnlCheckBox`.
8. **`.pas` — declarações e `uses`** — remover declarações dos componentes excluídos; declarar `vgrDetalhes` e as rows; incluir no `uses` da interface as units exigidas pelo IDE (`cxVGrid`, `cxDBVGrid`, `cxInplaceContainer`, `cxTextEdit`, `cxStyles`, `cxEdit`…); remover `uses` que ficarem órfãos apenas se o IDE indicar.
9. **Handler `OnGetDisplayText`** da linha de títulos — método curto do form devolvendo o título pelo índice do editor.
10. **Compilar** `autcom.exe` via `autcom.groupproj` e executar o roteiro de validação manual (tasks.md, Fase 3).

## 4. Conformidade com padrões do projeto

- Zona Legado: Hungarian (`vgr` para o grid, `row` para linhas), prefixos `p`/`f` em métodos, sem refatoração além do necessário.
- Componentes: `TcxDBVerticalGrid` / `TcxDBMultiEditorRow` (DevExpress, já usado no projeto). Nenhum `TDBGrid`, `TButton`/`TBitBtn`, `dxSkin*` — conferir que o IDE não injeta unit `dxSkin*` no `uses` nem `LookAndFeel.SkinName` no DFM.
- Chamadas: nenhuma `StrToFloat` nova (a única ocorrência ligada aos edits é removida), nenhum `.SetFocus`, `Now`, `ActiveControl :=`.
- SQL: os aliases novos são literais fixos, sem dado externo — mesmo padrão já existente em `pCriaClientLivro`.
- Pre-commit DFM: sem `FillType = ftBrush` / `Outline =`.
- Encoding: `.pas`/`.dfm` em cp1252, edição por bytes, mesmo padrão de quebra de linha do arquivo original; conferir contagem de não-ASCII antes/depois.
- Comentários: só onde o porquê não é óbvio (ex.: arredondamento de `FIS_VLCONT`, campos CBS/IBS/IS zerados aguardando requisito de cálculo).

## 5. Estratégia de testes

- Suite: **nenhuma** — zona Legado sem infraestrutura de teste; validação manual com roteiro (tasks.md, Fase 3). Sem regra tributária nova, portanto sem exigência de teste em `AutcomTestesClientes` — registrar como ressalva no `/citel-aprovaRequisito`.
- Casos a cobrir:
  - nota com 1 classificação; com 5 classificações; comparar célula a célula com a versão anterior (print antes/depois);
  - linhas CBS/IBS/IS com 0,00 nas classes usadas e no Total;
  - retorno de consignação com mescla `RETCON` × `CLADSC` (deve bloquear);
  - pagamento antecipado: valor contábil total igual ao anterior;
  - `chkGraFin` / contas a pagar pela classificação da 1a coluna;
  - Pré-Nota: `pnlDetalhes` oculto, altura do form;
  - entrada automatizada (`frmEntMercadoriasAutomatizada`);
  - grid não editável, dataset não entra em `dsEdit`; Ctrl+C copia célula; Tab pula o grid;
  - `CADFIS` gravado idêntico ao anterior para a mesma nota.

## 6. Riscos e mitigação

- `cdsCadFis` compartilhado com entrada automatizada → `grep` por laços sobre `cdsCadFis.Fields` / cópia genérica para `CADFIS` antes de incluir os campos; validar a entrada automatizada no roteiro.
- Linha de títulos via `OnGetDisplayText` não renderiza bem → plano B: 6 `TLabel` de título num painel acima do grid, alinhados às colunas.
- Editores `ReadOnly` ainda colocam o dataset em edição → validar `dtsCadFis.DataSet.State`; se ocorrer, usar `OptionsData.Editing = False` e tratar Ctrl+C no `OnKeyDown` do grid copiando o valor da célula focada.
- Precisão dos aliases `0.00` → seguir exatamente o padrão existente (tratado por `pSetaClient`); validar valor alto (ex.: 1.234.567,89) num campo antigo e num novo.
- Perda de campo na migração do DFM → gabarito do passo 1 conferido contra as 28 linhas montadas (132 + 36 bindings).
- Corrupção de encoding/EOL → fluxo obrigatório de edição por bytes cp1252 e checagem de não-ASCII.

## 7. Etapa 2 — Reforma no valor contábil e na tela Dados Fiscais (08/10/2026)

Referência: spec.md, seção 9.

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `untFuncoes.pas` | `padra_atualizado/fontes/genericos/` | `pRateiaImpostos`: flag lida uma vez no corpo; função local `fValorReformaItem` (FindField + soma CBS + IBS UF + IBS Mun + IS); em `pCalculaImpostosItens`, depois de `fRetornaValorOutras` e antes do parâmetro `VLRCON`, `fltVlrCon := fltVlrCon + fValorReformaItem` — único ponto que grava `ENT_VLRCON` no rateio, cobre os três ramos (perfil aduaneiro, NF-e CFOP 3, normal) |
| `untEntDadosFiscais.pas` | `padra_atualizado/fontes/movimentacaoitens/` | `fValidaValorContabil` com parâmetro `fltReforma`; declarações; `pAtualizaTabela` (aliases de alíquota exibida e DisplayFormat); `pAtualizaEdits`; `pLimpaEdits`; `fValidaCampos` (≥ 0 + recálculo); `pRecalculaValoresReforma`; `fAtualizaItem` (UPDATE das colunas `ENT_RF*`); `pAjustaCamposReforma` (visibilidade e altura) chamado no `pShow` |
| `untEntDadosFiscais.dfm` | idem | 10 colunas no `dbgItens` após `ENT_OUTRAS`; 10 `TEditFocus` + labels no `pnlValores` (Top ≥ 148), TabOrder antes de `edtOutras` (a saída de `edtOutras` grava o item) |

Pontos de atenção:
- `pnlValores` reorganizado (08/10, no IDE) em `pnlCfop`, `pnlImpostos` e `pnlImpostosReforma` (alTop, nessa ordem de tabulação). A visibilidade da Reforma é só do `pnlImpostosReforma`; `pAjustaAlturaValores` recalcula a altura do `pnlValores` pela soma dos sub-painéis visíveis + bordas, e o form acompanha a diferença (grid mantém a altura).
- Último campo editável: `edtOutras` sem a Reforma; `edtAlq_Is` com o `pnlImpostosReforma` visível. A saída do último campo chama `fConfirmaItemEditado` (confere o valor contábil e grava — bloco que antes vivia no ramo de `edtOutras`).
- `pHabilitaCampos` percorre só filhos diretos: `pHabilitaCamposValores` chama os três sub-painéis. `pEscapePressed` testa o `Parent` contra os três.
- O nome da coluna de alíquota no UPDATE vem de um conjunto fixo (efetiva ou nominal), nunca de dado digitado.

## 8. Etapa 3 — Entrada automatizada (08/10/2026)

Referência: spec.md, seção 10. Os três arquivos são CRLF puro, cp1252.

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `untEntradaAutomatizada.pas` | `padra_atualizado/fontes/movimentacaoitens/` | `pAjustaDadosFiscaisItem`: depois de `fRetornaValorOutras` + Isentas/Outras, `ENT_VLRCON += CBS + IBS UF + IBS Mun + IS` se `fSomarNovosImpostosDaReformaAoValorContabil` (lida uma vez por montagem, não por item) e `FindField('ENT_RFCVAL')`. `fCriaClientGruposFiscal`: 5 aliases `0.00`. `fMontaGrupoLivro`: acumular nos dois ramos (FindKey/Append). `fGeraLivroFiscal`: zerar os 6 campos 1..5 antes do laço, preencher por classificação, acumular e gravar os totais `T` |
| `untEntMercadoriasAutomatizada.dfm` | idem | Remover de `pnlDetalhes` os 120 `TDBEditFocus`, 26 `TLabel`, 5 `TBevel`; incluir o `vgrDetalhes` copiado do resumo (linhas, editores, espaçadores, `cxsTituloDetalhes`, `OptionsView/Behavior/Data`), `Align = alClient` como o painel atual; `OptionsData.Editing` habilitado, editores `ReadOnly` exceto CFOP e FCP ST |
| `untEntMercadoriasAutomatizada.pas` | idem | Remover declarações dos 151 componentes e `dbeClfSc1Enter/Exit`; declarar grid, rows, style; `uses` `cxVGrid`, `cxDBVGrid`, `cxInplaceContainer`; copiar do resumo `pGetDisplayTextTitulo/Valor/ClaFis`, `pGetContentStyleDetalhes`, `pAjustarFundoTema`, `pAjustaLinhasDetalhes`; CFOP editável (abaixo); linha ~1319 |

CFOP editável na grade (preserva `dbeClfSc1Enter/Exit`):
- `OnEditing` do `vgrDetalhes` (linha `rowClfSc`): `FstrOldCfop := valor do campo do editor`.
- Validação em método do form `pConfirmaTrocaCfop(const AstrCfop: String)` com o corpo atual do Exit (`fExisteCFOP` + `objEntrada.fCFOPPodeSerUtilizada` → Post, laço nos itens, `pDefineSeGravaCTP`; senão `Cancel` + `pMensagemOk`), chamada no `OnEdited` da linha CFOP; em seguida `pAjustaLinhasDetalhes`.
- Editor do CFOP: `TcxTextEditProperties` com `CharCase = ecUpperCase`, `MaxLength` do campo, filtro numérico (`OnKeyPress` ou máscara).
- Plano B se o momento do `Post` do grid não casar com o Exit atual: validar no `OnValidate` do `TField` `FIS_CLFSC*` do `cdsCadFis` (Abort desfaz) e propagar no `AfterPost`.

Pontos de atenção:
- `pAjustaLinhasDetalhes` chamado no `OnShow` do `tbsLivro` (troca de guia pelo usuário ou por código) e após troca de CFOP — o livro é refeito pelo `pAfterPostItens` quando os itens mudam.
- `FIS_VLCONT` ao pagamento antecipado: `fStrToFloat(FormatFloat('0.00', ...))`, mesmo critério do resumo (tasks, decisões de 07/10).
- `untPcmGer` sem alteração; conferir por consulta, depois de gravar, `CADFIS`/`AUXFIS`/`AUXMOV`/`MOVREF` contra a NF 52910668 da entrada normal.
- Gabarito antes de remover: nome → `DataField` dos 120 edits (incl. totais irregulares `FIS_BAEIPI`, `FIS_VAEIPI`) conferido contra os bindings do grid.
- Conferir que o IDE não injeta `dxSkin*`/`LookAndFeel.SkinName` ao salvar o form.
