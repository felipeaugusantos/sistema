# Tarefas — Req. 462714

**Referência:** spec.md, plan.md

## Fase 1 — Análise / preparação
- [x] Decidir valor × alíquota: **alíquota**, com base pela NT usando só os campos das telas (08/10)
- [x] Conferir a fórmula do `vBC` IBS/CBS na NT 2025.002-RTC vigente — v1.33, regra UB16-10 (rejeição 1104): soma `vIS`; bate com RN05/RN06. A NT 2026.008 remove a UB16-10 (homologação 10/2026) (08/10)
- [x] Decidir se a base é persistida: **não** (08/10)
- [x] Rodar `script_462714.sql` no banco da 150 (informado pelo usuário, 08/10)
- [x] Registrar o padrão de EOL dos `.pas` / `.dfm` da 150 — todos CRLF; `untPedidoCompra.pas` já tinha 6 LF soltos, preservados
- [x] Revisão da implementação da 150 (09/10): defeitos — prévia × item com fontes diferentes de ICMS desonerado; alíquota sem teto na cotação; soma decidida por visibilidade de controle; `rev.inc` modificado
- [x] Decidir o padrão (09/10): núcleo OO `untImpostosReformaCompra` (records + calculadora), idêntico nas 5 versões
- [x] Decidir a regra nos 7x (09/10): mesma `fSomarNovosImpostosDaReformaAoValorContabil` da 150; `CFG_SIMHIB` é dependência externa
- [x] Mapear o porte em 150.100, 150.45, 74.111 e 72 (09/10) — plan.md §4
- [x] 74.111: caminho `COTACAO_MODO_GRAVACAO_ANTIGA` fora de escopo (09/10)
- [ ] Conferir `SHOW COLUMNS` de `PCMDET`, `PCMGER`, `COTFOR` (e `_RES`) na 150

## Fase 2 — Primeira implementação na 150 (concluída em 08/10, será refatorada na Fase 4)
- [x] Pedido: campos, aggregates, `TOT_TOTGER`, adapter, `pAtualizaTotaisPedido`, `fBaixaPcmGer` / `fDesfaturaPedidoCompra`
- [x] `untGravacaoPedido`: params finais com default 0
- [x] `untPedidoCompra.dfm/.pas`: grid, `pnlReforma`, 2ª linha do rodapé, visibilidade, recálculos, digitação, carga, gravação simples e multi-loja
- [x] Multi-loja, importação, unificação, recuperação, distribuição por data, pasta de compra, valida valor mínimo
- [x] Cotação: SQL, `fSQLUpdateVlrTot`, BeforePost, gravação e cópias de `COTFOR`, diálogo de valores, grid/footer, `TIT_*`, exportar/importar
- [x] Cotação → Pedido (`untTPreparaPedidosCotacao` e leitura no `untFuncoesPedido`)
- [x] Impressão HTML e exportações (campos e somas)
- [ ] **Achado, fora do escopo:** o ramo cotação do `TValidaValorPedidoCompra` nunca roda (o `Exit` do r213184 avalia `FblnCotacao` antes de ele ser ligado). Tratar em requisito próprio

## Fase 3 — Núcleo
- [x] Criar `PedidoDeCompra\untImpostosReformaCompra.pas` (`TAliquotasReforma`, `TBaseReforma`, `TValoresReforma`, `TSQLValoresReforma`, `TCalculoReformaCompra`) em cp1252/CRLF (09/10)
- [x] Teste DUnit `TestesUnitarios\padra_atualizado\fontes\movimentacaoitens\TestuntImpostosReformaCompra.pas`, registrado em `AutcomTestes.dpr` (a pasta `TestCase/` não existe na 150): massa do CA01, importação, base negativa, alíquota zero, cotação sem arredondamento, `fAliquotaValida` nas bordas, `fSQLValores` (09/10)
- [x] Hash SHA-256 da unit (referência do CA16): `02175E2C4BC92EDCC5C0B8352CE6C20F4C48D6D2CA8F693FC03EE35F85C94AD1`
- [ ] Rodar `AutcomTestes` e confirmar os 8 testes verdes

## Fase 4 — Refatoração da 150
- [x] Incluir a unit nos 17 `.dpr` que compilam `untFuncoesPedidoSimples`: `autcom.dpr`, `libPedidoDeCompra.dpr` e 15 Services Linux (Citeldesk, Consulta.Preco.Tinta, Exporta.Tintometricos.Terceiros(.Automotiva), Faturamento.Services.API, FaturamentoAutomatico, Financeiro.Services.API, Fulfillment.Services, GatilhosImediatos, GatilhosInformacao, libGatIme, Obrarium, RD.Station.CRM, SFAMobileImportacao, Suprimento.Services.API) (09/10)
- [x] `untFuncoesPedidoSimples`: adapter via núcleo; removidas `fBaseImpostosReforma` / `pCalcularImpostosReforma`; criada `pCopiaAliquotasReforma` (09/10)
- [x] ICMS desonerado só não sai da base com Zona Franca **e** `ITE_CICMDE = 'S'` (decisão 09/10), no adapter do item e na prévia
- [x] Cópias repetidas trocadas por `pCopiaAliquotasReforma`: `untAjustaMultiLoja`, `untPedidoCompra` ×3, `untFuncoesPedido` ×2. As demais cópias não seguem o padrão "copia + recalcula" e ficaram como estão (09/10)
- [x] `pCalculaReformaTela` via `TBaseReforma` / núcleo. Revisão: prévia e item já usavam a mesma origem (`ITE_CICMDE` → `ParametrosCalcImpostos`); o defeito real era ignorar a Zona Franca (09/10)
- [x] Validação 0–100 via `TAliquotasReforma.fAliquotaValida` no pedido e no `untAlteraValorUnitario` (09/10)
- [x] Campo `FblnSomaReforma` no lugar de `.Visible` em `untPedidoCompraImportacao`, `untPedidoCompraResumoLojas`, `untPedidoCompraResumoLojasItem` (09/10)
- [x] Cotação: BeforePost via núcleo; `fSQLPrecosItemFornecedor` e `fSQLUpdateVlrTot` via `TCotacao.fSQLValoresReforma` → `TCalculoReformaCompra.fSQLValores` (09/10)
- [x] `untTPreparaPedidosCotacao.pCalculaImpostosReformaPcmDet` via núcleo (09/10)
- [x] Comentários redundantes removidos; mantidos só os de regra não óbvia e os de nome de parâmetro em chamada posicional (estilo local) (09/10)
- [x] `PedidoDeCompra\rev.inc` revertido (09/10)
- [x] Compilar `autcom.groupproj`, `AutcomTestes` e `Services.groupproj` (informado pelo usuário, 09/10)
- [ ] Commit: `svn add` de `TestesUnitarios\padra_atualizado\fontes\movimentacaoitens\TestuntImpostosReformaCompra.pas`; **não** levar `untPrincipal.dfm` (ruído da IDE) nem `cadastros\untTCadTabPrecoAutomatico.pas` (alteração alheia)

- [x] Correção pós-teste (09/10): `pCalculaImpostos` passa a calcular CBS/IBS/IS (`TAliquotasReforma` → `TValoresReforma`); diálogo `untAlteraValorUnitario` soma CBS/IBS/IS no "Total com Impostos" via callback `TCalculaReformaImp` / `TCotacao.fCalculaReformaImp` (antes só o BeforePost somava)
- [x] Decisão 09/10: na cotação CBS/IBS/IS sobre preço ÷ divisor (SQL `fSQLValoresReforma`, BeforePost e diálogo), na mesma unidade do `UNITOT`
- [x] Grids com CBS/IBS/IS igual IPI/ST/Frete (09/10, 150/150.100/150.45): aba 3 (colunas reposicionadas ao lado de IPI/ST/Frete, F2 replicar e Enter); aba 4 "Orçamentos do Produto" (% CBS/IBS/IS); troca de fornecedor (bandas "não venceu" e "vencedor"); itens do pedido de importação (alíquota e valor); unificação (totais + selecionados); resumo por loja/item (três colunas no lugar de "CBS+IBS+IS")
- [x] Fora (decisão 09/10): "Dados Atuais do Produto" e grid esquerda da aba 4 (cadastro do produto não tem alíquota CBS/IBS/IS); entrada de nota (`untEntSelPedidos`, `untEntConfPedidos`, `untNotaFiscalImport`) e relatório `untConsultaPedCom`
- [ ] Retestar o diálogo (massa 10 × 100,00; CBS 10 / IBS 1 / IS 1 → total 1.121,10)

## Fase 5 — 150.100 (plan §4.1)
- [ ] DDL no banco da 150.100 e `SHOW COLUMNS`
- [x] Unit núcleo criada (hash igual ao da 150) e teste DUnit copiado (09/10)
- [x] Unit incluída em `autcom.dpr`, `libPedidoDeCompra.dpr`, `AutcomTestes.dpr`, 11 Services e `TestesAutomatizadosFulfillment\TesteAutomatizadoFulfillment.dpr` (na 150.100 esse projeto compila `untFuncoesPedidoSimples`). Citeldesk, Financeiro.Services.API e Obrarium não existem na 150.100; RD.Station.CRM lá não usa a unit (09/10)
- [x] Diff da 150 refatorada aplicado (patch -F0); rejeitos resolvidos à mão (09/10)
- [x] `fGravaPcmDet`: params após `intImppla`; `fltValAdp`/`strTipAdp` retirados das chamadas posicionais (`untTPreparaPedidosCotacao`, `untUnificacaoPedidos`, `untTDistribuiPedidoCompraDataEntrega`, `untRecuperaPedido` ×2, `untPedidoCompra` ×2) (09/10)
- [x] Sem `fAplicarLinhaImportada`: pontos ligados a ela pulados (09/10)
- [x] `TIT_CBS/IBS/IS` em `untCotacao.pas` (bloco `const` da implementation) (09/10)
- [x] `pZeraQuantidadeDoItemAtualCasoNecessario`, `pnlReforma` no `.dfm`, `fValidaCampos`, `untPedidoCompraImportacao` sem antidumping (09/10)
- [x] Encoding/EOL iguais à BASE em todos os arquivos (09/10)
- [ ] Compilar `autcom.groupproj`, `AutcomTestes` e Services
- [ ] Commit: `svn add` de `untImpostosReformaCompra.pas` e `TestuntImpostosReformaCompra.pas`

## Fase 6 — 150.45 (plan §4.2)
- [ ] DDL no banco da 150.45 e `SHOW COLUMNS`
- [x] Unit núcleo (hash igual) e teste DUnit; `autcom.dpr`, `libPedidoDeCompra.dpr` e `AutcomTestes.dpr` (150.45 não tem Services) (09/10)
- [x] Pedido: patch + ajustes (`fCadEmp` no lugar de `fCadEmpresa`, sem `IMPPLA`/`intImppla`, rateio em `pAjustaMultiLoja`, sem `UPDATE PCMGER` por subselect) (09/10)
- [x] `untGravacaoPedido`: params após `fltUniLiq`; chamadas sem `strDiaUte`/`intImppla`/antidumping; `untTDistribuiPedidoCompraDataEntrega` com defaults intermediários; chamada multi-loja passa `fltUniLiq` 0 (default) (09/10)
- [x] Cotação reescrita sem `COT_QTDATE`/`blnMulCot` (gravação, ON DUPLICATE, emergencial, `_RES`, restauração, cópia de segurança, `COT_VLRTOT`), importação/exportação, `TIT_*` em `untCotacao` (09/10)
- [x] `TPreparaPedidosCotacao.Create` com `AcdsPrecosFornecedores` + chamador em `untCotacao` (09/10)
- [x] `untAlteraValorUnitario.dfm` (`pnlReforma` em layout plano) e footer do `untCadCotacaoGeralCX.dfm` (09/10)
- [x] `pCalculaImpostos` com CBS/IBS/IS, callback do diálogo e divisor, como na 150 (09/10)
- [x] Encoding/EOL iguais à BASE (09/10)
- [ ] Compilar `autcom.groupproj` e `AutcomTestes`
- [ ] Commit: `svn add` das duas units novas
## Fase 7 — 74.111 (plan §4.3)
- [ ] DDL no banco do 74.111 (conferir tabelas `_RES` existentes) e `SHOW COLUMNS`
- [x] `fSomarNovosImpostosDaReformaAoValorContabil` direto em `untFuncoesSimples` (corpo da 150) (09/10)
- [x] Unit núcleo (hash igual) e teste DUnit; `autcom.dpr`, `libPedidoDeCompra.dpr` e `AutcomTestes.dpr` (09/10)
- [x] Pedido: patch + ajustes (`fCadEmp`, `pAjustaMultiLoja`, `untPcmGer` baixa/desfaturamento, caudas de gravação após `strObs006`/`fltUniLiq`, tela sem handlers de alíquota, `pnlReforma` sem OnEnter/OnExit), grids de importação, unificação e resumo de lojas (09/10)
- [x] Cotação pivô: `ALQCBSnn/ALQIBSnn/ALQ_ISnn` e `TOTCBSnn/TOTIBSnn/TOT_ISnn` no SQL, `VALTOTnn`/`TOTESCnn` com a regra, BeforePost, `fAlterouItem`, zeragens, `COT_VLRTOT`, gravação `COTFOR` / ON DUPLICATE / `_RES` / herança / cópia de segurança, exportar/importar (colunas opcionais), `TIT_*`, `fCalculaReformaImp` sem arredondamento (09/10)
- [x] Diálogo de valores (`pnlReforma` alBottom, validação 0–100, total com CBS/IBS/IS); aba 3 com colunas `% CBS/% IBS/% IS` (ColIndex 6–8, F2 e Enter) e totais CBS/IBS/IS na linha de cima do `pnlTotFor` (09/10)
- [x] Cotação → Pedido: `untTPreparaPedidosCotacao` lendo `ALQ*nn` do `cdsItens`, totais, rateio e gravação com caudas do 74.111 (09/10)
- [x] Encoding/EOL iguais à BASE (`autcom.dpr`, `untFuncoesSimples` e `untPcmGer` já eram UTF-8 com BOM na BASE); `rev.inc` revertido (09/10)
- [ ] Compilar `autcom.groupproj` e `AutcomTestes`
- [ ] Commit: `svn add` das duas units novas

## Fase 8 — 72 (plan §4.4)
- [ ] DDL no banco do 72 (sem `COTFOR_RES`; conferir as demais `_RES`) e `SHOW COLUMNS`
- [x] `fSomarNovosImpostosDaReformaAoValorContabil` direto em `untFuncoesSimples` (corpo da 150) (09/10)
- [x] Unit núcleo (hash igual) e teste DUnit; `autcom.dpr`, `libPedidoDeCompra.dpr` e `AutcomTestes.dpr` (09/10)
- [x] Pedido: patch da 150 + ajustes (adapter sem desonerado, `fCadEmp`, `pAtualizaTotaisPedido` sem `fltSubFCP`, `pZeraMultiLojas`, rateio em `pAjustaMultiLoja`, `untPcmGer` sem FCP, caudas após `strIpiFre`/`dtaDatEdt` com defaults intermediários explícitos, tela sem handlers de alíquota, PDF com `blnSemPre`), grids de importação, unificação e resumo de lojas (09/10)
- [x] Cotação pivô com crédito de ICMS: `ALQ*nn` no SQL, `VALCBSnn/VALIBSnn/VAL_ISnn` por unidade no BeforePost (base preço + frete − crédito), `VALTOTnn` com a regra, somas `CBSTOT/IBSTOT/IS_TOT`, `fAlterouItem`, zeragens, `COT_VLRTOT`, gravação `COTFOR`, exportar/importar (colunas opcionais), `TIT_*`; herança sem mudança (colunas novas ficam com o default) (09/10)
- [x] Diálogo (`pnlReforma` alBottom, validação 0–100, total com CBS/IBS/IS calculado pelo núcleo: o 72 não tem callback nem crédito no diálogo) e aba 3 (colunas ColIndex 7–9 após `CREICM`, F2, Enter, totais no `pnlTotFor`) (09/10)
- [x] Cotação → Pedido dentro do `TCotacao`: `fIniciaPedidoCompra` (totais + cauda do `pGravaPcmGer`), `fGravaItemPedido` (novo parâmetro `AAliquotasReforma`, cauda do `fGravaPcmDet`), `fGravaPedidoCompra` (`pAtualizaTotaisPedido` com `PCG_VAL*`); desmembrado passa pelo mesmo caminho; multi-loja (PCDDET) sem campos de reforma (09/10)
- [x] Encoding/EOL iguais à BASE (`autcom.dpr` e `untFuncoesSimples` já eram UTF-8 com BOM) (09/10)
- [ ] Compilar `autcom.groupproj` e `AutcomTestes`; `svn add` das duas units novas
- [ ] Compilar `autcom.groupproj`; encoding/EOL

## Fase 8b — Unitário com impostos do pedido (revisão de 09/10, nas 5 versões)
- [x] `untFuncoesPedidoSimples`: nova `fSQLUnitarioImpostosReforma(APrefixo)`
- [x] `untPedidoCompra.pCalculaUniImp`: soma `fTotalImpostosReformaItem / quantidade`
- [x] `ITE_UNIIMP` nas cargas: `untPedidoCompra` (2 SQLs) e `untFuncoesPedido` (1 SQL)
- [ ] Retestar na 150 o pedido 000000006296 / emp 003. Pela carga do banco deve dar 135,52 (100 + 35,52, sem IPI gravado); com o IPI de 20% digitado na tela, 155,52.

## Fase 8c — Rodapé em linha corrida e `CFG_SIMHIB` (09/10)
- [x] `PedidoDeCompra\untRodapeFormatado.pas` (RF03a), aprovado pelo usuário na tela da 150 e replicado nas 5 versões
      (unit idêntica, `svn add`, `libPedidoDeCompra.dpr`, chamada no `FormCreate` depois do `pAjustaCamposReforma`)
- [x] `CFG_SIMHIB` no `untCfgRepositorio` do 74.111 e do 72 (`pAdicionarConfiguracao` + editor Sim/Não na mesma posição
      do grupo DADOS FISCAIS)
- [x] `/citel-aprovaRequisito` (09/10): B1 corrigido. No 72, os 3 métodos novos estavam no meio dos campos da seção
      `private` do `untPedidoCompra` (E2169) e foram para o fim da seção. B2 (SQL concatenado na cotação, no mesmo
      comando que o IPI/DIVISO já concatenava) foi mantido por decisão do usuário
- [x] `svn add` de `untImpostosReformaCompra.pas` (150.100, 150.45, 74.111, 72) e `TestuntImpostosReformaCompra.pas` (5)

## Fase 9 — Testes
Roteiro passo a passo, massas com valores esperados e tabela de resultado por versão: [testes.md](testes.md).
- [ ] DUnit do núcleo nas 5 versões
- [ ] CA16: hash da unit núcleo igual nas 5 versões
- [ ] CA01–CA04: massa da spec e combinações `REFCIS` / `SIMPAU` / `SIMHIB` — por versão
- [ ] CA05–CA07: recálculo por campo (prévia = gravado), ICMS desonerado, pedido de importação — por versão
- [ ] CA08–CA09: gravar e reabrir com conferência por SQL; multi-loja — por versão
- [ ] CA10–CA11: cotação (com e sem crédito; slots 01 e alto nos 7x) e geração de pedido — por versão
- [ ] CA10a: exportar com e sem a regra; importar planilha nova e antiga — por versão
- [ ] CA12–CA14: fluxos secundários, impressão/exportação, custo unitário e melhor fornecedor — por versão
- [ ] CA15: cp1252 e EOL em todos os arquivos alterados
- [ ] Avisar o usuário quais campos ficaram disponíveis para o `.fr3`

## Fase 10 — Revisão e commit
- [x] Revisão de regressão 150/150.100 e apontamentos do DelphAI (09/10):
  - `untRodapeFormatado`: não restaura `WindowProc` nem redesenha com o form em destruição (os campos já foram liberados pelo painel pai); 5 versões, hash `9a4af675…8b447d79`
  - `untPnlDadosPedCompra`: CBS/IBS/IS no PDF pelo alias `TOTREF`, proporcional ao saldo pendente; 5 versões
  - `Suprimento.Services.Pedido` (150, 150.100): `pCalculaImpostosReformaItem` antes do `Post` (sem isso o `TOT_TOTGER` da simulação REST ficava nulo com a regra ligada)
  - 150: `ProcessaGeracaoLinkPagamento.dpr` (serviço novo, r499352) com a unit núcleo; teste registrado no `AutcomTestes.dpr` e `svn add`
  - DelphAI 1 (`COT_ALQ*` fora do SELECT): falso positivo, o SELECT de `fSQLPedidoMultiloja` traz as colunas. DelphAI 3 (`FillChar` em `untRecuperaPedido`): pré-existente
  - Troca de fornecedor (150.x): `fGeraComparativo` soma CBS/IBS/IS do vencedor no `VALTOT` (cursor clonado sem o filtro), igual ao total do concorrente
  - Comparativo (150.x): visibilidade das colunas CBS/IBS/IS reaplicada depois do layout salvo (`CFGGRD`)
  - Importação de planilha da cotação (5 versões): alíquota fora de 0 a 100 não é importada e fica a atual (`TCotacao.fAliquotaImportada`)
  - Pedido de importação (5 versões): `pnlReforma` posicionado abaixo do `pnlImportacao`
  - DelphAI (09/10): handler da troca com `Assigned` (150.x); validação de valor mínimo não soma CBS/IBS/IS no ramo cotação (5 versões); diálogo do 72 com callback `fCalculaReformaUnitario` e base única `fValoresReformaUnitario` (igual ao BeforePost). Falsos positivos respondidos: `COT_ALQ*`/`PCD_ALQ*` no SELECT, `recPcmger.fltVal*` em `pAtualizaDadosCopiaSeg`, `TOTGER` com reforma no `pAtualizaTotaisPedido` do 72
  - Em aberto: multi-loja usa o ICMS da quantidade anterior na base da loja (ICMS desatualizado já existia; decisão do usuário)
- [x] Rodada de teste 20–21/10 (5 versões + cópias CONFE e FECHADAS `.C` da pasta `Reforma`):
  - Impressão do pedido (`untDocPedidoCompra.fSQLMovPcmGer`): `TOTGER` soma as despesas acessórias (`DESACE`); faltava em todos os layouts (pré-existente; pedido 8517 imprimia 383.022,92 contra 383.032,91 gravado)
  - Rodapé do pedido (`untRodapeFormatado`): rótulos em azul (`COR_ROTULO = clBlue`)
  - Importação Excel do pedido (`untLayoutImportacaoPedidoCompra`): campos `% CBS`, `% IBS`, `% IS` (IDs 27, 28 e 29 em todas as versões; 25 e 26 são Empresa e Dia útil na 150.x). Layout novo já traz; layout existente ganha os campos ao editar. Na digitação vão para `edtAlqCbs/Ibs/_Is` (alíquota fora de 0 a 100 é ignorada); os valores CBS/IBS/IS são calculados e não entram no layout. `TCamposLayoutUsados` passou a ser zerado antes da leitura (layout antigo sem as linhas novas)
  - Cotação 72/74.111: rótulo "Total IBS:" da aba 3 não sobrepõe mais o campo; tela "Exportar Arquivo" (`untCadCotEmail`) com os 4 checkboxes sem sobreposição (layout pré-existente)
  - Cadastro de produto 72/74.111 (REFTRI, Req. 466712): linhas da tabela de preços compactadas de 22 para 20 px no dfm para caber CBS/IBS/IS/Pr. Venda com Impostos com as abas da DLL
  - Fora deste requisito (decisão do usuário, 21/10): ST da tela na abertura do pedido (150.x) recalculado sem frete/despesa na base porque `strBStFre/strBStAce` só são lidos depois da carga dos itens (pré-existente)
- [ ] Executar `/citel-aprovaRequisito 462714`
- [ ] Rodar o gate DelphAI e obter o token
- [ ] Commit da 150 (com esta pasta): primeira linha `Req. 462714` + token DelphAI
- [ ] Commits de 150.100, 150.45, 74.111 e 72 com a mesma referência
