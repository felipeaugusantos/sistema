# Tarefas — Req. 468382

**Referência:** spec.md, plan.md

## Fase 1 — Análise / preparação

- [x] Conferir padrão de quebra de linha e contagem de não-ASCII (cp1252) de `untEntDadosFiscaisResumo.pas/.dfm`, `untEntradaAutomatizada.pas`, `untEntDadosFiscais.pas` — todos CRLF puro
- [x] Extrair do DFM o gabarito componente → `DataField` dos 132 `TDBEditFocus` e os captions das 28 labels de `pnlDetalhes` — conferido por script: 132 campos do DFM = 132 ligações das 22 linhas do grid
- [x] Confirmar que nenhuma rotina copia genericamente todos os campos de `cdsCadFis` para `CADFIS` (grep por laços sobre `.Fields`) — só o laço de `DisplayFormat` em `pSetaClientCadFis`; `untPcmGer` grava campo a campo
- [x] Tirar prints da tela atual (nota com 1 e com 5 classificações) para comparação

Merge com o r498960 e decisões de implementação da etapa 1: ver `record.md` §2.

## Fase 2 — Implementação

- [x] `untEntradaAutomatizada.pas` — `pCriaClientLivro`: 36 aliases `FIS_BCCBS|VLCBS|BCIBS|VLIBS|BC_IS|VL_IS` + `1..5`/`T`
- [x] `untEntDadosFiscais.pas` — `pAddValueByField` = 0 dos campos novos no laço por classificação e nos totais
- [x] `untEntDadosFiscaisResumo.pas` — `dbeClfSc1.Text` → `fRetClaFisCadFis(1)` (6 pontos)
- [x] `untEntDadosFiscaisResumo.pas` — `FindComponent('dbeClfSc'+N)` → `fRetClaFisCadFis(intIdx)` (2 pontos)
- [x] `untEntDadosFiscaisResumo.pas` — `fStrToFloat(dbeVlConT.Text)` → `fRetVlrContabilCadFis` (ver decisões)
- [x] `untEntDadosFiscaisResumo.pas` — `pFormataEditsValores` removida (ver decisões)
- [x] `untEntDadosFiscaisResumo.pas` — remover `pAjustaTamahoCamposCadFis` (declaração, implementação e chamada)
- [x] `untEntDadosFiscaisResumo.dfm` — remover 132 `TDBEditFocus`, 28 `TLabel`, 5 `TBevel` de `pnlDetalhes`; preservar `pnlCheckBox`
- [x] `untEntDadosFiscaisResumo.dfm` — incluir `vgrDetalhes` (`TcxDBVerticalGrid`, `dtsCadFis`, `alLeft`, `TabStop=False`) com `rowTitulos` + 22 linhas atuais + 6 CBS/IBS/IS, editores `ReadOnly`; `OptionsData` sem Appending/Deleting/Inserting
- [x] `untEntDadosFiscaisResumo.pas` — declarações do grid/rows, handlers `pGetDisplayTextTitulo` e `pGetContentStyleDetalhes` (títulos em negrito, cor do painel), `uses` das units cxVGrid
- [x] Conferir: nenhuma unit/propriedade `dxSkin*`, nenhum `TDBGrid`/`TButton`, nenhum `StrToFloat`/`.SetFocus`/`Now`
- [x] Conferir encoding (cp1252, não-ASCII antes/depois) e EOL de todos os arquivos alterados
- [x] Compilar `autcom.exe` via `autcom.groupproj`
- [x] Abrir o form no IDE uma vez e salvar — confirma que o DFM escrito à mão carrega e deixa o IDE acertar o `uses` (conferir que não injetou `dxSkin*`)

## Fase 3 — Testes (validação manual — legado sem infraestrutura de teste)

- [x] Nota com 1 classificação: 1a Class. + Total iguais aos prints; demais colunas vazias
- [x] Nota com 5 classificações: 22 linhas iguais aos prints, célula a célula
- [x] Linha de títulos `1a Class.` … `Total` visível
- [x] CBS/IBS/IS: com `REFCIS` habilitado (e regra SIMPAU/SIMHIB) aparecem as bases; valor só com base > 0. Sem a configuração, nenhuma linha CBS/IBS/IS
- [x] Colunas de classificação não usadas mostram 0,00 nos valores; Classificação Fiscal vazia
- [x] Nota sem ST/Antecip./IPI/não creditados/FCP ST/monofásica: só a linha da base aparece (0,00); valor oculto. ICMS sempre visível
- [x] Ordem das linhas igual à do livro fiscal (aba Documentos)
- [x] Base > 0 em só uma classificação: linha do valor visível para todas as colunas
- [x] Formato `#,##0.00`; Classificação Fiscal à direita
- [x] Grid não editável; `cdsCadFis` não entra em `dsEdit`; Ctrl+C copia célula; Tab pula o grid
- [x] Retorno de consignação com mescla `RETCON` × `CLADSC` bloqueia com a mesma mensagem
- [x] Pagamento antecipado recebe o mesmo valor contábil total
- [x] `chkGraFin` / contas a pagar igual ao comportamento anterior
- [x] Pré-Nota: `pnlDetalhes` oculto, altura do form correta
- [x] Entrada automatizada (`frmEntMercadoriasAutomatizada`) funciona
- [x] `pnlCheckBox` visível à direita com `ETRAUT` ativo
- [x] Fundo dos títulos igual ao da tela: com skin ativa e no modo clássico
- [x] Linhas horizontais e verticais das células na cor do fundo; espaçadores não recebem foco nem clique de edição
- [ ] `CADFIS` gravado idêntico ao anterior para a mesma nota

## Etapa 2 — Reforma no valor contábil e na tela Dados Fiscais (spec §9, plan §7)

- [x] `untFuncoes.pRateiaImpostos` — somar CBS + IBS (UF + Mun) + IS ao `fltVlrCon` depois de Outras/Isentas, só com `fSomarNovosImpostosDaReformaAoValorContabil`
- [x] `untEntDadosFiscais.fValidaValorContabil` — parâmetro `fltReforma` em todas as fórmulas
- [x] `untEntDadosFiscais.dfm` — 10 colunas no `dbgItens`; 10 campos + labels no `pnlValores`, TabOrder antes de `edtOutras`
- [x] `untEntDadosFiscais.pas` — declarações, `pAtualizaTabela`, `pAtualizaEdits`, `pLimpaEdits`, `fValidaCampos`, `pRecalculaValoresReforma`, `fAtualizaItem`, visibilidade/altura pela configuração
- [x] Conferir encoding (cp1252, não-ASCII) e EOL (`untEntDadosFiscais.pas` tem 29 LF soltos do r498960 — preservar)
- [x] Compilar no IDE; abrir o form uma vez e salvar (labels com AutoSize ajustam a largura); conferir a faixa da Reforma com a configuração ligada
- [x] Testes manuais: critérios de aceitação da etapa 2 (spec §9); entrada sem XML, Caixa 2 e `untEntMercadorias` (também chamam `pRateiaImpostos`)
- [x] `fConfirmaItemEditado` — total geral = `SUM(ENT_VLRCON)` após editar item (`pCalculaTotaisCabecalho`); ver `record.md` §6.1
- [ ] Teste: Calcula Impostos → 310,35; editar item sem alterar → 310,35; alterar alíquota CBS → total acompanha a diferença do item
- Decisão (08/10): alterar CBS/IBS/IS não reprova `fValidaValorContabil` — ver `record.md` §3.4

## Etapa 3 — Entrada automatizada (spec §10, plan §8)

- [x] Conferir EOL e não-ASCII (cp1252) de `untEntradaAutomatizada.pas`, `untEntMercadoriasAutomatizada.pas/.dfm`
- [x] Gabarito do `pnlDetalhes` da automatizada: 120 edits nome → `DataField`, eventos (`OnEnter/OnExit` nos 6 CFOP), `ReadOnly` (12 FCP ST sem), `CharCase`, `TipoTexto`, `PanelInfo`
- [x] `untEntradaAutomatizada.pas` — `pAjustaDadosFiscaisItem`: Reforma no `ENT_VLRCON` depois de Outras/Isentas, com a configuração
- [x] `untEntradaAutomatizada.pas` — `fCriaClientGruposFiscal` + `fMontaGrupoLivro`: 5 colunas da Reforma
- [x] `untEntradaAutomatizada.pas` — `fGeraLivroFiscal`: `FIS_VLCBS|VLIBS|VL_IS|BCCBS|BCIBS|BC_IS` 1..5 e totais
- [x] `untEntMercadoriasAutomatizada.dfm` — remover 120 edits/26 labels/5 bevels; `vgrDetalhes` igual ao resumo (ordem, estilos, espaçadores); CFOP e FCP ST editáveis
- [x] `untEntMercadoriasAutomatizada.pas` — declarações/`uses`; handlers do resumo; `pAjustaLinhasDetalhes` no `OnShow` do `tbsLivro` e após troca de CFOP; CFOP editável (`OnEditing`/`OnEdited` + `pConfirmaTrocaCfop`); remover `dbeClfSc1Enter/Exit`; linha ~1319 `FIS_VLCONT`
- [x] Conferir pre-commit (sem `dxSkin*`, `TDBGrid`, `StrToFloat`, `.SetFocus`, `Now`), encoding e EOL

Notas da implementação: ver `record.md` §4.

- [ ] Compilar; abrir o form no IDE e salvar; confirmar `PanelInfo` (A confirmar)
- [x] Teste: NF 52910668 pela automatizada × entrada normal (`MOVDET`, `MOVGER`, `CADFIS`, `AUXFIS`, `AUXMOV`, `MOVREF`) — consulta no banco (08/10: `MOVGER` 00100000000122444003 × 00100000000122439003; Reforma, valor contábil por item e totais iguais; livro reagrupado em 2407/2556 por ser fornecedor de uso e consumo; nota sem contas a pagar — financeiro não exercitado)
- [ ] Teste: configuração inativa; nota sem Reforma; aparência/ordem igual ao resumo; Ctrl+C; Tab pula o grid
- [ ] Teste: troca de CFOP válida (propaga aos itens, contas a pagar) e inválida (mensagem `CFG_CFEAAL`, volta valor); FCP ST editável chega ao `CADFIS`
- [ ] Teste: pagamento antecipado; duplicatas do XML menores que o documento; liberação de boleto

## Fase 4 — Revisão e commit

- [x] Executar `/citel-aprovaRequisito` (08/10: sem bloqueante de código; pendências de processo — testes manuais, spec desatualizada (corrigida), dispensa de teste automatizado (registrada no spec §5), `opcoes.ini`/`rev.inc` fora do commit)
- [ ] Não incluir `padra_atualizado/opcoes.ini` nem `padra_atualizado/rev.inc` no commit (ambiente local)
- [ ] Rodar o gate DelphAI e obter o token
- [ ] Commit: primeira linha `Req. 468382` + token DelphAI na mensagem
