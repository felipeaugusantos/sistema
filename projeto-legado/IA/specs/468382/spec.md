# Especificação — Req. 468382

**Título:** Resumo dos Dados Fiscais da entrada — `pnlDetalhes` em `TcxDBVerticalGrid` + linhas CBS/IBS/IS
**Objetivo:** Substituir a grade de `TDBEditFocus`/`TLabel`/`TBevel` do `pnlDetalhes` de `untEntDadosFiscaisResumo` por um `TcxDBVerticalGrid` e deixar preparadas (zeradas) as linhas da Reforma Tributária (CBS, IBS, IS).
**Zona:** Legado
**Data:** 07/10/2026

## 1. Contexto / problema atual

A tela `TfrmEntDadosFiscaisResumo` (Dados Fiscais - Resumo da entrada de mercadorias) exibe no `pnlDetalhes` o resumo do livro fiscal por classificação fiscal: 22 atributos × 6 colunas (1a a 5a Class. + Total).

Hoje isso é montado à mão no DFM com:

- 132 `TDBEditFocus` (`dbeClfSc1` … `DBEVALMOT`), todos `Enabled = False`, `Tag = 99`, ligados a `dtsCadFis`;
- 28 `TLabel` (títulos de linha e de coluna);
- 5 `TBevel` separadores;
- `pnlCheckBox` (depósito fechado / movimentação de saldo) posicionado dentro do mesmo painel.

Consequências: DFM com ~4.100 linhas só nesse painel, rotina `pAjustaTamahoCamposCadFis` com mais de 120 chamadas `pSetHeight`, código acessando valor fiscal via `Edit.Text` em vez do dataset e nenhum espaço para os novos tributos da Reforma (CBS/IBS/IS).

O dataset por trás (`cdsCadFis`) tem **um único registro**: cada célula é um campo `FIS_<atributo><n>` (n = 1..5) ou `FIS_<atributo>T` (total).

## 2. Módulos e entidades envolvidos

- Módulo: `movimentacaoitens` (entrada de mercadorias), com reflexo no livro fiscal.
- Units:
  - `padra_atualizado/fontes/movimentacaoitens/untEntDadosFiscaisResumo.pas` / `.dfm` — tela alterada
  - `padra_atualizado/fontes/movimentacaoitens/untEntradaAutomatizada.pas` — `TEntradaAutomatizada.pCriaClientLivro` (estrutura do `cdsCadFis`)
  - `padra_atualizado/fontes/movimentacaoitens/untEntDadosFiscais.pas` — preenchimento do `cdsCadFis` e ligação `dtsCadFis.DataSet := cdsCadFis` (linha ~3500)
  - `padra_atualizado/fontes/movimentacaoitens/untPreNota.pas` — usa `pnlDetalhes.Visible`, `pnlDetalhes.Height` e `pnlCheckBox.Height` (linhas 3310 e 3342-3343); **não é alterada**
- Entidades:
  - `cdsCadFis` (`TUniClientDataSet` em memória, 1 registro, estrutura vinda de `SELECT ... FROM CADFIS WHERE FALSE`)
  - `CADFIS` / `AUXFIS` — **não são alteradas** (nem estrutura, nem gravação)

## 3. Requisitos funcionais

- RF01 — O `pnlDetalhes` passa a exibir um `TcxDBVerticalGrid` (`vgrDetalhes`) ligado a `dtsCadFis`, declarado no DFM.
- RF02 — Cada atributo fiscal é uma `TcxDBMultiEditorRow` com 6 editores, na ordem 1a Class., 2a Class., 3a Class., 4a Class., 5a Class., Total.
- RF03 — A primeira linha do grid exibe os títulos das colunas: `1a Class.`, `2a Class.`, `3a Class.`, `4a Class.`, `5a Class.`, `Total`.
- RF04 — As 22 linhas atuais são mantidas, na mesma ordem e com os mesmos títulos e campos:

| # | Título | Campo (n = 1..5 / T) |
|---|--------|----------------------|
| 1 | Classificação. Fiscal | `FIS_CLFSC` |
| 2 | Valor Contábil | `FIS_VLCON` |
| 3 | Base ICMS | `FIS_BASIC` |
| 4 | Aliquota. ICMS | `FIS_ALQIC` |
| 5 | Valor ICMS | `FIS_VLRIC` |
| 6 | Isentas | `FIS_ISENT` |
| 7 | Base ICMS Subst. | `FIS_BCRET` |
| 8 | Valor ICMS Subst. | `FIS_RETID` |
| 9 | Base ICMS Antecip. | `FIS_BASAN` |
| 10 | Valor ICMS Antecip. | `FIS_ANTIC` |
| 11 | Desp. Acess. | `FIS_DACES` |
| 12 | Base IPI | `FIS_BASIP` |
| 13 | Valor IPI | `FIS_VLRIP` |
| 14 | Outras | `FIS_OUTRA` |
| 15 | Base ICMS Subst. Não Creditado | `FIS_BAERE` (total: `FIS_BAERET`) |
| 16 | Valor ICMS Subst. Não Creditado | `FIS_VAERE` (total: `FIS_VAERET`) |
| 17 | Base IPI Não Creditado | `FIS_BAEIP` (total: `FIS_BAEIPI`) |
| 18 | Valor IPI Não Creditado | `FIS_VAEIP` (total: `FIS_VAEIPI`) |
| 19 | Base Fundo Combate a Pobreza ST | `FIS_BFCPS` (total: `FIS_BFCPST`) |
| 20 | Valor Fundo Combate a Pobreza ST | `FIS_VFCPS` (total: `FIS_VFCPST`) |
| 21 | Quantidade tributada monofásica | `FIS_QBCMO` |
| 22 | Valor monofásica | `FIS_VALMO` |

  Os nomes exatos de cada campo (inclusive os totais com nomenclatura irregular) devem ser copiados do `DataField` dos `TDBEditFocus` atuais antes de removê-los.

  **Ordem de exibição implementada** (decisão de 07/10, igual à aba Documentos do `untCadLivroFiscal`): Classificação, Valor Contábil, Desp. Acess., Base/Alíquota/Valor ICMS, Outras, Isentas, ICMS Subst., ICMS Antecip., ICMS Subst. não creditado, IPI, IPI não creditado, FCP ST, CBS, IBS, IS, monofásica. A numeração das tabelas acima e abaixo identifica o campo, não a posição.

- RF05 — São incluídas 6 linhas novas, ao final, com nomes de campo espelhando os blocos de `AUXFIS`:

| # | Título | Campo (n = 1..5 / T) |
|---|--------|----------------------|
| 23 | Base CBS | `FIS_BCCBS` |
| 24 | Valor CBS | `FIS_VLCBS` |
| 25 | Base IBS | `FIS_BCIBS` |
| 26 | Valor IBS | `FIS_VLIBS` |
| 27 | Base IS | `FIS_BC_IS` |
| 28 | Valor IS | `FIS_VL_IS` |

- RF06 — Os 36 campos novos (6 atributos × 6 colunas) passam a existir no `cdsCadFis` (`pCriaClientLivro`). O preenchimento é o cálculo do Req. 410369 (r498960) em `untEntDadosFiscais` — soma por classificação de `ENT_RFCVAL`, `ENT_RFIUFV + ENT_RFIMNV`, `ENT_RFSVLR`, `ENT_REFVBC`, `ENT_RFSBAS`; classificações sem uso ficam 0. Este requisito acrescentou os totais de base `FIS_BCCBST`/`FIS_BCIBST`/`FIS_BC_IST`. Na entrada automatizada, ver seção 10.
- RF07 — No resumo o grid é somente leitura, mas permite focar/selecionar uma célula e copiar seu valor com Ctrl+C. Não participa do fluxo de Tab do form (`TabStop = False`). Na entrada automatizada, Classificação Fiscal e FCP ST continuam editáveis (seção 10, RF18).
- RF08 — `pnlCheckBox` continua dentro de `pnlDetalhes`, à direita do grid, com o comportamento atual de visibilidade.
- RF09 — Todo código que lia valor fiscal através dos edits passa a ler do dataset `dtsCadFis.DataSet`.

## 4. Regras de negócio

- RN01 — Nenhuma regra fiscal muda. O que é exibido em cada célula das 22 linhas atuais é exatamente o que é exibido hoje.
- RN02 — Linhas CBS/IBS/IS (revisada em 07/10, no merge com o r498960): exibem os valores calculados pelo Req. 410369 a partir do XML (`DETERT`). As bases só aparecem com `fSomarNovosImpostosDaReformaAoValorContabil`; cada linha de valor só aparece com essa configuração **e** alguma classificação com base > 0 (mesma regra base/valor das demais linhas — `pAjustaLinhasDetalhes`).
- RN03 — Colunas sem classificação continuam visíveis (as 6 sempre aparecem). Valor numérico nulo aparece `0,00` só na tela; o `cdsCadFis` continua nulo, porque vai para o `CADFIS`.
- RN04 — Formatação (revisada em 07/10): valores com `#,##0.00` aplicado no grid (`TcxCurrencyEditProperties`), sem mudar os campos do `cdsCadFis` compartilhado; Classificação Fiscal centralizada, vazia exibida como `-` (só exibição).
- RN05 — Retorno de consignação: a validação de mescla `RETCON` × `CLADSC` (hoje via `FindComponent('dbeClfSc'+N)`) continua idêntica, lendo `FIS_CLFSC1..5` do dataset.
- RN06 — Pagamento antecipado: o valor passado a `objPgoAnt.pSetarDocumentoEntrada` (hoje `fStrToFloat(dbeVlConT.Text)`, que vinha arredondado em 2 casas pela formatação) passa a ser `FIS_VLCONT` arredondado em 2 casas — sem diferença de centavo.
- RN07 — Contas a pagar / previsão de entrada: as condições que usam `dbeClfSc1.Text` (comparação com `VS_strClaCom`, `_1116_2116_1117_2117`, `fGravaContasPagar`) leem `FIS_CLFSC1` do dataset, com o mesmo resultado.
- RN08 — Pré-Nota (`FblnAcessadoViaPrenota`): `pnlDetalhes` continua oculto e o cálculo de altura do form em `untPreNota` continua funcionando sem alteração.

## 5. Requisitos técnicos / não-funcionais

- Encoding: `.pas`/`.dfm` são Windows-1252 — editar por bytes (cp1252), conferir padrão de quebra de linha antes, validar contagem de caracteres não-ASCII antes/depois. Nunca Edit/Write padrão nesses arquivos.
- Pre-commit: sem `TDBGrid`, `TButton`/`TBitBtn`, `dxSkin*`, `.SetFocus` direto, `StrToFloat`, `Now`.
- Nenhuma alteração em `.dpr`/`.dproj` (units DevExpress de vertical grid já são usadas no projeto — 71 units com `TcxDBVerticalGrid`).
- Sem transação, auditoria ou permissão envolvidas (tela de exibição).
- Impacto fiscal: a etapa 1 (grid) não muda gravação. As etapas 2 e 3 mudam o valor contábil (CBS + IBS + IS somados, com a configuração) e, na entrada automatizada, passam a gravar `FIS_TOT*`/`AUXFIS`/`AUXMOV` — ver seções 9 e 10.
- Testes: **sem teste automatizado** — dispensa registrada em 08/10/2026. A entrada de mercadorias (`pRateiaImpostos`, `TEntradaAutomatizada`, `fConfirmaEntradaMercadorias`) depende de form, tabela temporária `TMP_ENTMER` e conexão; não há infraestrutura para ela em `AutcomTestesClientes`, que cobre cálculo de impostos de faturamento. A validação é manual, com roteiro (`tasks.md`) e conferência no banco das tabelas gravadas (`MOVGER`, `MOVDET`, `MOVREF`, `CADFIS`, `AUXFIS`, `AUXMOV`) contra o XML — feita para a NF 52910668 pela entrada normal e pela automatizada.

## 6. Critérios de aceitação

- [ ] `pnlDetalhes` não contém mais nenhum `TDBEditFocus`, `TLabel` de grade nem `TBevel`; contém `vgrDetalhes` e `pnlCheckBox`.
- [ ] Nota com 1 classificação: 1a Class. e Total com os mesmos valores de antes; demais colunas com `0,00` (Classificação Fiscal `-`).
- [ ] Nota com 5 classificações: as 5 colunas + Total batem com a versão anterior, linha a linha (22 linhas).
- [ ] Linha de títulos mostra `1a Class.` … `5a Class.` `Total`.
- [ ] Com a configuração: bases CBS/IBS/IS visíveis com os valores do XML por classificação e no Total; linha de valor só se alguma base > 0. Sem a configuração: nenhuma linha CBS/IBS/IS.
- [ ] Valores com formato `#,##0.00`; Classificação Fiscal centralizada, `-` quando vazia.
- [ ] Resumo: não é possível alterar valor pelo grid; o dataset não entra em edição.
- [ ] Ctrl+C numa célula copia o valor para a área de transferência.
- [ ] Tab no form não passa pelo grid.
- [ ] Retorno de consignação com CFOPs `RETCON` e `CLADSC` misturados continua bloqueado com a mesma mensagem.
- [ ] Pagamento antecipado recebe o mesmo valor contábil total de antes.
- [ ] Geração de contas a pagar (`chkGraFin`) se comporta igual para CFOP da 1a classificação.
- [ ] Entrada via Pré-Nota abre com `pnlDetalhes` oculto e altura do form correta.
- [ ] Entrada automatizada (`frmEntMercadoriasAutomatizada`, que compartilha `cdsCadFis`) continua funcionando.
- [ ] Livro fiscal gravado (`CADFIS`) idêntico ao gerado antes da alteração para a mesma nota.
- [ ] `pnlCheckBox` visível à direita do grid quando `ETRAUT`/movimentação de saldo estiver ativa.

## 7. Fora de escopo

- Cálculo ou origem de valores CBS/IBS/IS na entrada de mercadorias — a origem (XML, `DETERT`) veio no Req. 410369 (r498960); a composição no valor contábil e a edição entram na etapa 2 (seção 9).
- Alterar a gravação de `AUXFIS` (blocos CBS/IBS/IS do livro) — feita pelo Req. 410369 em `untPcmGer`; a entrada automatizada passa a alimentá-la pela seção 10, sem mudar `untPcmGer`.
- Corrigir a fórmula do total geral do cabeçalho (`pCalculaTotalGeral`, sem IPI não creditado, FCP ST e Reforma) nos caminhos anteriores ao Calcula Impostos — anterior a este requisito. Após editar um item, o total passa a ser `SUM(ENT_VLRCON)` (tasks, Etapa 2).
- Ocultar colunas de classificação vazias.
- Alterar formatação por linha (ex.: alíquota com %, quantidade com 4 casas).
- Alterar `pnlCabecalho`, `pnlContasPagar`, `pnlBotoesEnt` ou `untPreNota`.
- Corrigir o comportamento herdado de `pnlCheckBox` ficar oculto junto com `pnlDetalhes` na Pré-Nota.

## 8. Dependências e riscos

- `cdsCadFis` é compartilhado com `frmEntMercadoriasAutomatizada` (`untEntradaAutomatizada`, linha ~829). Confirmado: nenhuma rotina copia todos os campos genericamente para `CADFIS` (`untPcmGer` grava campo a campo).
- Linha de títulos sem campo no `TcxDBVerticalGrid`: abordagem prevista via `OnGetDisplayText` dos editores; se não renderizar adequadamente, plano B é manter 6 labels de título acima do grid.
- Seleção + Ctrl+C com grid somente leitura: validar que editores `ReadOnly` não colocam `cdsCadFis` em `dsEdit`.
- Literal `0.00` como alias gera tipo de precisão pequena no MySQL; seguir exatamente o padrão dos aliases existentes, que já é tratado por `pSetaClient`.
- Os nomes de campo do RF05 são os mesmos usados pelo Req. 410369 em `untPcmGer` (AUXFIS).

## 9. Etapa 2 — Reforma no valor contábil e na tela Dados Fiscais (08/10/2026)

Os valores de CBS/IBS/IS por item já chegam na `TMP_ENTMER` pelo Req. 410369 (`untFuncoes.fSQLItensNotaEletronica`, LEFT JOIN `DETERT`): `ENT_REFVBC` (base IBS/CBS), `ENT_RFCALQ`/`ENT_RFCALE`/`ENT_RFCVAL` (CBS), `ENT_RFIUFA`/`ENT_RFIUFE`/`ENT_RFIUFV` (IBS estadual), `ENT_RFIMNA`/`ENT_RFIMNE`/`ENT_RFIMNV` (IBS municipal), `ENT_RFSBAS`/`ENT_RFSALQ`/`ENT_RFSVLR` (IS). Sem XML, ficam 0.

- RF10 — Com `fSomarNovosImpostosDaReformaAoValorContabil` = True, o valor contábil do item (`ENT_VLRCON`, calculado em `untFuncoes.pRateiaImpostos`) passa a somar CBS + IBS estadual + IBS municipal + IS. Sem a configuração, nada muda.
- RF11 — Grid `dbgItens` de `untEntDadosFiscais`: 10 colunas novas após `Vr. Outras` — Base IBS/CBS, Alq./Vr. CBS, Alq./Vr. IBS Est., Alq./Vr. IBS Mun., Base/Alq./Vr. IS. Visíveis só com a configuração.
- RF12 — Painel de edição `pnlValores`: os mesmos 10 campos, com o mesmo comportamento dos impostos existentes (base e alíquota editáveis, valor calculado e somente leitura). Visíveis só com a configuração; sem ela o painel e o form ficam com a altura atual.

Regras:

- RN09 — Valor contábil = cálculo atual + CBS + IBS (UF + Mun) + IS, quando a configuração estiver ativa (mesma regra do livro fiscal, `untCadLivroFiscal`, e do faturamento).
- RN10 — Outras/Isentas são apuradas **antes** da soma (`fRetornaValorOutras` sem a Reforma), como no livro fiscal. `fValidaValorContabil` soma a Reforma em todas as fórmulas de conferência.
- RN11 — Tudo que deriva do valor contábil acompanha: total geral, `FIS_VLCONT`, contas a pagar, pagamento antecipado, liberação de boleto, `MOVDET`, `GER_VLRCON`.
- RN12 — Base IBS/CBS única (`ENT_REFVBC`), como no XML e no `MOVREF` (`REF_BASCAL`). IS com base própria (`ENT_RFSBAS`).
- RN13 — Alíquota exibida = efetiva (`*_ALE`/`*_UFE`/`*_MNE`) quando > 0, senão a nominal; ao gravar, a alteração volta para a mesma coluna de onde foi lida. Alíquotas com 4 casas (colunas `DECIMAL(7,4)`).
- RN14 — Valor = base × alíquota / 100, recalculado só na saída dos campos da Reforma (não reescreve o valor do XML ao sair de outros campos). Como o valor contábil não é editável e a Reforma é parcela somada (não repartida como Outras), a diferença do valor recalculado é aplicada ao valor contábil do item na tela, mantendo a RN09.
- RN15 — Gravação em `fAtualizaItem` (UPDATE `TMP_ENTMER`); daí segue ao `MOVREF` por `untPcmGer.pCarregaRefTribItemEntrada`, sem alteração. Um novo "Calcula Impostos" refaz o rateio, como para os demais impostos.

Critérios de aceitação (etapa 2):

- [ ] Configuração ativa, nota com IBS/CBS/IS no XML: valor contábil do item = anterior + CBS + IBS Est. + IBS Mun. + IS; Outras/Isentas iguais às de antes.
- [ ] Total geral, resumo (Valor Contábil, Total) e contas a pagar acompanham.
- [ ] Configuração inativa: valores, grid e painel iguais aos de hoje.
- [ ] Alterar base ou alíquota recalcula o valor e o valor contábil do item; conferência `fValidaValorContabil` aceita.
- [ ] `MOVREF` gravado com o valor alterado.
- [ ] Item com redução: alíquota efetiva exibida; base × alíquota bate com o XML.

## 10. Etapa 3 — Entrada automatizada (`frmEntMercadoriasAutomatizada`) (08/10/2026)

A entrada automatizada (`TEntradaAutomatizada`, `untEntradaAutomatizada.pas`) não passa por `pRateiaImpostos`: calcula o item em `pAjustaDadosFiscaisItem`, agrupa em `cdsGruLiv` (`fMontaGrupoLivro`, por CFOP + alíquota ICMS) e monta o `cdsCadFis` em `fGeraLivroFiscal`. Os itens (`cdsItens`) já vêm de `fSQLItensNotaEletronica` com os campos `ENT_RF*`/`ENT_REFVBC` da `DETERT`, e a gravação é a mesma `untPcmGer.fConfirmaEntradaMercadorias` da entrada normal.

Situação antes da etapa 3:
- `MOVREF` já é gravado (r498960, `pCarregaRefTribItemEntrada` lê o `cdsItens`).
- `FIS_TOTCBS`/`FIS_TOTIBS`/`FIS_TOT_IS`/`FIS_TOT_NF`, `AUXFIS` e `AUXMOV` **não** são gravados: `fGeraLivroFiscal` deixa os campos `FIS_VLCBS*`/`FIS_BCCBS*`… do `cdsCadFis` nulos, e `fConfirmaEntradaMercadorias` só grava quando `FIS_VLCBST + FIS_VLIBST + FIS_VL_IST > 0`.
- O valor contábil do item não soma a Reforma.
- A guia Livro Fiscal (`tbsLivro` → `pnlDetalhes`) é a grade antiga de 120 `TDBEditFocus` + 26 `TLabel` + 5 `TBevel` (20 linhas, sem monofásica).

Requisitos:
- RF13 — Com `fSomarNovosImpostosDaReformaAoValorContabil` = True, `ENT_VLRCON` do item (em `pAjustaDadosFiscaisItem`, ramos CFOP 3 e normal) soma CBS + IBS estadual + IBS municipal + IS, **depois** de apuradas Outras/Isentas (RN09/RN10). Sem a configuração, nada muda.
- RF14 — `cdsGruLiv` ganha `ENT_VLRCBS`, `ENT_VLRIBS` (UF + Mun), `ENT_VLR_IS`, `ENT_BASRT` (base IBS/CBS) e `ENT_BAS_IS`, acumulados por grupo em `fMontaGrupoLivro`.
- RF15 — `fGeraLivroFiscal` preenche `FIS_VLCBS|VLIBS|VL_IS|BCCBS|BCIBS|BC_IS` 1..5 (0 nas classificações sem uso) e os totais `T`, como `untEntDadosFiscais`. Com isso a gravação existente passa a gravar `FIS_TOT*`, `AUXFIS` e `AUXMOV` (sem alterar `untPcmGer`).
- RF16 — `pnlDetalhes` da guia Livro Fiscal passa a ser um `vgrDetalhes` **idêntico ao do resumo** (`untEntDadosFiscaisResumo`): mesmas linhas, **mesma ordem** (títulos; Classificação Fiscal; Valor Contábil; Desp. Acess.; Base/Alíquota/Valor ICMS; Outras; Isentas; Base/Valor ICMS Subst.; Base/Valor ICMS Antecip.; Base/Valor ICMS Subst. Não Creditado; Base/Valor IPI; Base/Valor IPI Não Creditado; Base/Valor FCP ST; Base/Valor CBS; Base/Valor IBS; Base/Valor IS; Quantidade tributada/Valor monofásica), mesmos títulos, estilos, espaçadores, larguras, fundo do tema, `0,00` em valor nulo, `-` em CFOP vazio e mesma regra de visibilidade (`pAjustaLinhasDetalhes`).
- RF17 — Monofásica entra por igualdade com o resumo, mas a automatizada não a calcula: Quantidade aparece `0,00` e Valor fica oculto (sem base).
- RF18 — Comportamentos dos edits removidos que precisam sobreviver:

| Hoje | Na grade |
|------|----------|
| `dbeClfSc1Enter` (6 edits `FIS_CLFSC1..5`/`T`): guarda o CFOP anterior, `cdsCadFis.Edit`, libera edição | Linha Classificação Fiscal **editável** nas 6 colunas; início da edição guarda o CFOP anterior |
| `dbeClfSc1Exit`: `fExisteCFOP` + `fCFOPPodeSerUtilizada` → `Post`, troca `ENT_CLAFIS` dos itens com o CFOP anterior, `pDefineSeGravaCTP`; inválido → `Cancel` + mensagem `CFG_CFEAAL` | Mesma lógica em método do form, disparada ao concluir a edição da célula |
| 12 edits FCP ST (`FIS_BFCPS*`/`FIS_VFCPS*`, 1..5/`T`) **sem `ReadOnly`** — digitação vai ao `cdsCadFis`/`CADFIS` | Linhas Base/Valor FCP ST editáveis |
| `CharCase = ecUpperCase`, `TipoTexto = ttNumerico` no CFOP | Editor do CFOP em maiúsculas, só dígitos |
| `Tag = 99`, `Requerido = False`, `OnKeyDown := pOnKeyDownEdits` (TfrmPai) | Sem validação perdida (`fValidaCampos` não tem ramo para esses edits); Enter na célula conclui a edição |
| `PanelInfo = pnlInfo` nos 6 do CFOP, sem `Hint` | A confirmar na compilação (unit do componente fora da working copy) |
| `dbeVlConT.Text` (pagamento antecipado, linha ~1319) | `FIS_VLCONT` arredondado em 2 casas (mesmo critério do resumo) |

  Demais linhas somente leitura, `TabStop = False`, Ctrl+C na célula.

Regras:
- RN16 — Regras de soma/Outras/configuração idênticas às da etapa 2 (RN09, RN10, RN11).
- RN17 — Financeiro acompanha o valor contábil: `fltValorDocumento` (`pCalculaValorDocumento`), `fPedeDuplicatas` e `fLiberarValorBoleto` (`FIS_VLCONT`). As duplicatas do XML (`DUPELE`, soma de `vNF`) ficam menores que o documento (`vNFTot`) — fluxo já previsto de "parcelas menores que o documento".
- RN18 — Fora de escopo: colunas CBS/IBS/IS no grid de itens (`cxvItens`) e cálculo de monofásica na automatizada.

Critérios de aceitação (etapa 3):
- [ ] Mesma nota (ex.: NF 52910668) pela automatizada com a configuração: `ENT_VLRCON`/`MOVDET` por item, `FIS_VLCONT`/`GER_VLRCON`, `FIS_TOTCBS`/`FIS_TOTIBS`/`FIS_TOT_NF`, `AUXFIS` por classificação, `AUXMOV` e `MOVREF` iguais aos da entrada normal; Outras sem a Reforma.
- [ ] Configuração inativa: valores iguais aos de hoje; linhas da Reforma ocultas.
- [ ] Guia Livro Fiscal com as mesmas linhas, ordem e aparência do resumo.
- [ ] Troca de CFOP pela grade: CFOP válido propaga aos itens e redefine o contas a pagar; inválido é recusado com a mesma mensagem e volta o valor anterior.
- [ ] FCP ST continua editável na grade e o valor digitado chega ao `CADFIS`.
- [ ] Pagamento antecipado recebe o mesmo `FIS_VLCONT`.
- [ ] Duplicatas do XML menores que o documento: fluxo de duplicatas e liberação de boleto funcionam.
