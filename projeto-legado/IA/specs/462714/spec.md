# Especificação — Req. 462714

**Título:** CBS / IBS / IS no Pedido de Compra e na Cotação (rodapé e valor contábil)
**Objetivo:** Permitir que o operador informe, por item, a **alíquota** de CBS, IBS e IS no Pedido de Compra e na Cotação. O sistema calcula o valor sobre a base da Nota Técnica, limitada aos campos que existem em cada tela. Os totais aparecem no rodapé e são somados ao valor contábil (total geral) do documento somente quando a regra da Reforma estiver ativa.
**Zona:** Legado (`padra_atualizado/fontes/movimentacaoitens/`)
**Versões:** 150, 150.100, 150.45, 74.111, 72 (o requisito é commitado junto com a 150; esta pasta documenta todas)
**Data:** 08/10/2026. Revisões: 08/10 (modelo passou de valor digitado para alíquota); 09/10 (núcleo OO em unit própria, correções da revisão da 150, porte para as demais versões)

## 1. Contexto / problema atual

O Pedido de Compra (`TfrmPedidoDeCompra`) e a Cotação (`TfrmCadCotacaoGeralCX` / `TCotacao`) não têm nenhum tratamento de CBS/IBS/IS. Não há coluna, cálculo nem campo de tela.

O IPI é o imposto de referência nas duas telas:

- **Pedido:** o operador digita `% IPI` (`ITE_PERIPI`). `pCalculaTotalItemQtdGrid` calcula `ITE_TOTIPI = RoundTo(base × % / 100, -2)` sobre o total da linha. O valor vai para o aggregate `TOT_TOTIPI` (rodapé `dbeTotIpi`) e é somado em `TOT_TOTGER` (rodapé `edtTotGer`). É persistido em `PCMDET.PCD_PERIPI` / `PCD_TOTIPI` e em `PCMGER.PCG_TOTIPI` / `PCG_TOTGER`.
- **Cotação (150, 150.100, 150.45):** o operador digita `% IPI` por item e fornecedor (`COTFOR.COT_IPIENT`), no dataset de detalhe `cdsPrecosItemfornecedor`. O valor é calculado por unidade em `pCalculaImpostos` e `TOTAL_IPI = QTDTOT × valor unitário`. A soma aparece no footer do grid `cxvPrecosFornecedor`. Só o percentual é gravado.
- **Cotação (74.111, 72):** desenho pivô. Um único dataset `cdsItens` traz colunas por posição de fornecedor (`VALUNInn`, `IPIENTnn`, `VALTOTnn`, nn = 01..50), religadas ao grid em `pAfterScrollFornecedores`. Não existe `cdsPrecosItemfornecedor`.

O texto do requisito pede que, com a regra ligada, CBS/IBS/IS apareçam no rodapé e sejam somados no valor contábil. Com a regra desligada, não devem ser exibidos nem somados.

## 2. Módulos e entidades envolvidos

- Módulo: `movimentacaoitens` (Pedido de Compra: DLL `libPedidoDeCompra.dpr`; Cotação: `autcom.dpr`).
- Unit nova: `PedidoDeCompra\untImpostosReformaCompra.pas` — núcleo do cálculo, **idêntica nas 5 versões** (ver §5).
- Units principais: `PedidoDeCompra\untPedidoCompra.pas/.dfm`, `PedidoDeCompra\untFuncoesPedidoSimples.pas`, `PedidoDeCompra\untGravacaoPedido.pas`, `Cotacao\untCotacao.pas`, `Cotacao\untCadCotacaoGeralCX.pas/.dfm`, `Cotacao\untTPreparaPedidosCotacao.pas`. Lista completa e diferenças por versão no plan.md.
- Tabelas e colunas novas ([script_462714.sql](script_462714.sql), aplicar no banco de cada versão):

| Tabela | Coluna | Conteúdo | Papel equivalente no IPI |
|--------|--------|----------|--------------------------|
| `PCMDET` | `PCD_ALQCBS`, `PCD_ALQIBS`, `PCD_ALQ_IS` | Alíquota (%) informada | `PCD_PERIPI` |
| `PCMDET` | `PCD_VALCBS`, `PCD_VALIBS`, `PCD_VAL_IS` | Valor do imposto no **item** (linha) | `PCD_TOTIPI` |
| `PCMGER` | `PCG_VALCBS`, `PCG_VALIBS`, `PCG_VAL_IS` | Total do documento | `PCG_TOTIPI` |
| `COTFOR` | `COT_ALQCBS`, `COT_ALQIBS`, `COT_ALQ_IS` | Alíquota (%) por item × fornecedor | `COT_IPIENT` |

Na Cotação o valor não é gravado (calculado na hora, como o IPI).

As tabelas de restauração (`PCMDET_RES`, `PCMGER_RES`, `COTFOR_RES`) recebem as mesmas colunas onde existirem e forem copiadas por `INSERT ... SELECT`.

A base de cálculo **não** é persistida: é recalculada a partir dos campos do item.

## 3. Requisitos funcionais

- **RF01:** O Pedido de Compra permite informar, por item, a alíquota de CBS, IBS e IS no painel de item (`pnlReforma`, comum ao pedido normal e ao de importação). O grid de itens (`cxvItens`) exibe alíquotas e valores, sem edição, como o `% IPI`.
- **RF02:** O valor de cada imposto no item é calculado pela RN05/RN06 e recalculado em toda situação em que o IPI é recalculado: quantidade, preço, desconto, frete, despesas acessórias, ICMS e rateio multi-loja.
- **RF03:** O rodapé do Pedido de Compra (`Panel4`) exibe Total CBS, Total IBS e Total IS, antes do TOTAL.
  - **RF03a (revisão de 09/10, aprovada pelo usuário na 150):** o rodapé passa a ser uma linha corrida, "RÓTULO: valor"
    (rótulo em vermelho e negrito, valor em preto), desenhada por `TRodapeFormatado` (unit nova
    `PedidoDeCompra\untRodapeFormatado.pas`, idêntica nas 5 versões).
  - Os `TLabel` e edits do `Panel4` continuam existindo como fonte, num painel oculto, porque o form lê o texto deles,
    como `edtTotGer`.
  - A ordem é a da tela, com o `lblTotGer` sempre por último. Par com rótulo ou edit invisível não aparece.
  - A linha quebra quando não cabe, e a altura do `Panel4` fica só a das linhas usadas.
  - Redesenha quando um campo muda de texto ou de `Visible`, por um gancho no `WindowProc` que é desfeito antes de liberar
    os campos.
- **RF04:** O total geral do Pedido de Compra (`edtTotGer` / `TOT_TOTGER` / `PCG_TOTGER`) soma CBS + IBS + IS.
- **RF05:** A Cotação permite informar a alíquota de CBS, IBS e IS por item e fornecedor no diálogo de valores (`untAlteraValorUnitario`), gravada em `COTFOR.COT_ALQ*`. O grid exibe as alíquotas.
- **RF06:** O footer do grid da Cotação exibe a soma de CBS, IBS e IS.
- **RF07:** O valor total da Cotação (`VALTOT` / `VALTOTnn` e `COT_VLRTOT`) soma CBS + IBS + IS.
- **RF07a:** Botões **Exportar Arquivo** / **Importar Arquivo** da Cotação:
  - a planilha exportada traz as colunas `% CBS`, `% IBS` e `% I.S.` (só com a regra ligada);
  - a importação lê essas colunas e grava em `COT_ALQ*`.
- **RF08:** Ao gerar o Pedido de Compra a partir da Cotação, o pedido herda as alíquotas do fornecedor escolhido (`COT_ALQ*` → `PCD_ALQ*`) e recalcula os valores pela base do pedido.
- **RF09:** Os fluxos secundários que copiam itens ou recalculam o total do pedido propagam CBS/IBS/IS: multi-loja, unificação, recuperação, distribuição por data de entrega, pasta de compra e pedido de importação — onde existirem na versão.
- **RF10:** As impressões HTML (`untQckHTMLPedidoCompra`) e as exportações (Excel `untOpcoesExcelPedCompra`, `untPnlDadosPedCompra`) passam a trazer alíquotas e valores no SQL / dataset. **O layout (`.fr3` / `.dfm` de impressão) é editado pelo usuário.**

## 4. Regras de negócio

- **RN01: condição única.** "Regra ligada" é `fSomarNovosImpostosDaReformaAoValorContabil = True`: `REFCIS <> 'N'` e não (`SIMPAU = 'S'` e `SIMHIB = 'N'`). Não reimplementar a condição; chamar a função. Na tela, avaliar uma vez por abertura e guardar em campo do form/objeto. **Nenhuma decisão de soma pode depender da visibilidade de um controle.**
- **RN01a: versões 7x.** 72 e 74.111 não têm a função no ERP. Ela foi criada em `untFuncoesSimples`, com o
  **mesmo corpo** da 150.
  - A config `CFG_SIMHIB` ("Optante por simples nacional - Regime Híbrido?", padrão `N`, grupo DADOS FISCAIS) é criada
    nos 7x em `configuracoes\untCfgRepositorio.pas` (decisão do usuário, 09/10). Entram o `pAdicionarConfiguracao` e a
    linha do editor Sim/Não, na mesma posição relativa do grupo, como na 150.
  - As 150.x já têm a config.
- **RN02: regra ligada.** Campos de alíquota, rodapé e colunas de CBS/IBS/IS ficam visíveis. Os três impostos somam no total do item (`ITE_TOTGER`), no total do documento (`TOT_TOTGER`, `edtTotGer`, `PCG_TOTGER`) e no valor total da Cotação.
- **RN03: regra desligada.** Campos, rodapé e colunas ficam ocultos. **Não** somam em nenhum total. Um pedido já gravado com valores, aberto depois de a regra ser desligada, também não os soma nem exibe. Os valores gravados são preservados. O cálculo dos valores roda sempre; só exibição e soma dependem da regra.
- **RN04: custo unitário.** No pedido, CBS/IBS/IS entram no unitário com impostos (`ITE_UNIIMP`) do mesmo jeito que o IPI, quando a regra RN01 está ligada: `pCalculaUniImp` soma `(CBS + IBS + IS) / quantidade`, e as cargas do pedido usam `fSQLUnitarioImpostosReforma` (revisão de 09/10, pedido do usuário no teste da 150). Na cotação, `UNITOT` / `fCalculaPrecoImp` não mudam, e a comparação de preço entre fornecedores também não.
- **RN05: base de cálculo.** Segue o `vBC` do grupo IBS/CBS da NT 2025.002-RTC (v1.33, regra UB16-10), usando apenas os campos que existem em cada tela:

  ```
  NT:  vBC = vProd + vServ + vFrete + vSeg + vOutro + vII + vIS
             − vDesc − vPIS − vCOFINS − vICMS − vICMSUFDest − vFCP − vFCPUFDest − vICMSMono − vISSQN
  ```

  | Documento | Base (`TBaseReforma.fValor`, sem o vIS) |
  |-----------|------------------------------------------|
  | Pedido normal | `ITE_TOTITE + ITE_VALFRE + ITE_DESACE − ICMS` |
  | Pedido de importação | `ITE_TOTITE + ITE_VALFRE + ITE_DESACE + ITE_VALIMP − ITE_VALPIS − ITE_VALCOF − ICMS` |
  | Cotação (por unidade) | `(preço + frete − crédito de ICMS) / divisor` — mesma unidade do `UNITOT` (decisão 09/10) |

  - `ITE_TOTITE` já vem líquido de desconto (vProd − vDesc).
  - IPI e ICMS-ST **não** entram (LC 214/2025, art. 12, § 2º).
  - **Frete:** entra sempre, como o `vFrete` cobrado pelo fornecedor, independentemente de `IPIFre`.
  - **ICMS no pedido:** `RoundTo(ITE_BASICM × ITE_ALQICM / 100, -2)`. Quando o ICMS é **desonerado** — empresa em estado de Zona Franca (`fEhEstadoRegraZonaFranca`) **e** `ITE_CICMDE = 'S'`, mesma condição de `fCalcularSubstituicaoProduto` e do `TOT_TOTGER` —, não é subtraído. Vale igual para a prévia da tela e o item gravado. No 72 não existe ICMS desonerado: o ICMS sempre sai da base.
  - **ICMS na cotação:** o crédito de ICMS calculado na própria cotação, quando a versão tem crédito ativo. Sem crédito (ou versão sem `COT_CREICM`, como 74.111 e 72), subtrai 0.
  - Termos da NT sem campo na tela (vServ, vSeg, vISSQN, vICMSMono, DIFAL, FCP próprio) entram como 0.
  - Base negativa é tratada como 0.
- **RN06: ordem e valores.** O IS é calculado primeiro e **integra** a base do CBS/IBS (CF art. 153, § 6º, IV; LC 214/2025, art. 12, § 1º, V):
  - `ValorIS  = base × ALQ_IS / 100`
  - `ValorCBS = (base + ValorIS) × ALQCBS / 100`
  - `ValorIBS = (base + ValorIS) × ALQIBS / 100`
  - **Pedido:** calculado sobre a linha, `RoundTo(..., -2)` por item, como o IPI.
  - **Cotação:** calculado por unidade sem arredondar. `TOTAL_x = QTDTOT × valor unitário`, como o `TOTAL_IPI`.
- **RN07: alíquota.** Entre 0 e 100, **nas duas telas** (pedido e diálogo da cotação). Validação única em `TAliquotasReforma`. Duas casas na exibição.
- **RN08: rateio multi-loja.** Cada empresa recebe a mesma alíquota. O valor por empresa é recalculado sobre a base da parte da empresa.
- **RN09: parcelas.** Com a regra ligada, `PCG_TOTGER` inclui CBS/IBS/IS, então as parcelas geradas a partir dele também incluem. Consequência aceita de RF04.
- **RN10: valor mínimo do pedido.** `untTValidaValorPedidoCompra` soma CBS/IBS/IS (regra ligada), seguindo o IPI.
- **RN10a: importação de arquivo da cotação.**
  - As colunas `% CBS`, `% IBS` e `% I.S.` são **opcionais**: não invalidam planilhas já enviadas a fornecedores.
  - Coluna ausente: a alíquota atual do item × fornecedor é **preservada** (sentinela `-1` = "não informado", onde existe `pAtualizaUnitarioItemfornecedor`).
  - Coluna presente: grava o valor lido. Célula vazia vale 0.
  - Com a regra desligada, a importação ignora as colunas.
  - Os títulos das colunas são constantes `TIT_CBS`, `TIT_IBS`, `TIT_IS`, junto das demais `TIT_*` da versão.
- **RN11: cotação → pedido.** O pedido gerado recebe `PCD_ALQ* = COT_ALQ*` do fornecedor escolhido. O valor é recalculado pela RN05 com os campos do pedido (despesas acessórias e ICMS do item podem mudar a base).

## 5. Requisitos técnicos / não-funcionais

- **Núcleo OO — `untImpostosReformaCompra.pas`:**
  - `TAliquotasReforma` (record: `fltCbs`, `fltIbs`, `fltIs`; validação 0–100).
  - `TBaseReforma` (record com campos nomeados: `fltTotIte`, `fltValFre`, `fltDesAce`, `fltValIcm`, `fltValImp`, `fltValPis`, `fltValCof`; `fValor` aplica a RN05 e o piso 0).
  - `TValoresReforma` (record: `fltCbs`, `fltIbs`, `fltIs`; `fTotal`).
  - `TCalculoReformaCompra` (classe, `class function`): `fCalcular(ABase, AAliquotas, AblnArredonda): TValoresReforma` (RN06) e `fSQLValores(base, alíquotas)` (mesma fórmula em SQL para a cotação).
  - Sem dependência de genericos ou de banco: o arquivo é o mesmo nas 5 versões. Incluído em todo `.dpr` que compila `untFuncoesPedidoSimples`, inclusive os Services Linux (na 150: 17 `.dpr`).
- **Adapters** (ficam onde o dado está): dataset do item do pedido (`pCalculaImpostosReformaItem` em `untFuncoesPedidoSimples`), record `TPcmDet` da cotação→pedido, BeforePost/SQL da cotação. Eles só montam `TBaseReforma` / `TAliquotasReforma` e gravam `TValoresReforma`. A cópia de alíquotas entre datasets (multi-loja) é uma rotina única.
- `untGravacaoPedido`: parâmetros novos **ao final, com default 0** em `pGravaPcmGer`, `pAtualizaPcmGer` e `fGravaPcmDet`. Records não são usados nessas assinaturas porque o Delphi não aceita default em parâmetro record.
- Fluxos que recalculam por SQL no banco (`PCG_TOTGER = SUM(...)`) somam `PCD_VAL*`. O trecho é condicional à RN01.
- Código limpo: sem comentários que repetem o código ou citam RN. Comentário só onde há regra não óbvia (fórmula da base NT e IS integrando a base), no núcleo.
- Encoding: `.pas` / `.dfm` em Windows-1252, editados em bytes cp1252 preservando o EOL de cada arquivo (regra global do CLAUDE.md).
- Sem impacto fiscal direto: pedido e cotação não geram escrituração. Impacto financeiro em RN09.
- O motor `untReformaTributariaCalculo` **não** é usado.

## 6. Critérios de aceitação

Massa: item com `ITE_TOTITE` 1.000,00, frete 50,00, despesas acessórias 10,00, ICMS 12% sobre base 1.000,00 (= 120,00) e IPI 10%; alíquotas CBS 0,90 / IBS 0,10 / IS 1,00.

Conta esperada:
- base = 1.000 + 50 + 10 − 120 = **940,00**
- IS = 940,00 × 1% = **9,40**
- base CBS/IBS = 949,40
- CBS = 949,40 × 0,9% = **8,54**
- IBS = 949,40 × 0,1% = **0,95**

- [ ] CA00: DUnit do núcleo (`TestCase/`) passa: massa acima, base negativa → 0, alíquota fora de 0–100 rejeitada, cotação sem arredondamento.
- [ ] CA01: Regra ligada (`REFCIS = S`, `SIMPAU = N`), massa acima. O item mostra IS 9,40 / CBS 8,54 / IBS 0,95. O rodapé mostra os totais e `edtTotGer` soma os três.
- [ ] CA02: Regra ligada com `SIMPAU = S` e `SIMHIB = S`: igual ao CA01.
- [ ] CA03: `SIMPAU = S` e `SIMHIB = N`: campos e rodapé ocultos; total sem CBS/IBS/IS.
- [ ] CA04: `REFCIS = N`: campos e rodapé ocultos; total sem CBS/IBS/IS.
- [ ] CA05: Alterar quantidade, preço, desconto, frete ou despesas acessórias recalcula CBS/IBS/IS e o rodapé. O valor da prévia no painel é igual ao gravado no item.
- [ ] CA06: ICMS desonerado (onde existir): o ICMS **não** é subtraído da base.
- [ ] CA07: Pedido de importação: a base soma II e subtrai PIS/COFINS; digitação e totais funcionam, inclusive no `untPedidoCompraImportacao`.
- [ ] CA08: Ao gravar e reabrir o pedido, `PCD_ALQ*`, `PCD_VAL*` e `PCG_VAL*` estão gravados e coerentes. `PCG_TOTGER` inclui os três (regra ligada).
- [ ] CA09: Pedido multi-loja: valores por empresa e totais por empresa incluem CBS/IBS/IS.
- [ ] CA10: Cotação: alíquotas editáveis (0–100) e footer com as somas. `VALTOT` / `COT_VLRTOT` somam os impostos (regra ligada). Regra desligada: colunas ocultas e totais sem os impostos. Nos 7x, conferir slot 01 e um slot alto.
- [ ] CA10a: Exportar Arquivo com a regra ligada gera as colunas; desligada, não gera. Importar planilha nova grava as alíquotas; planilha antiga importa sem erro e preserva as alíquotas.
- [ ] CA11: A cotação gera pedido com as alíquotas herdadas e os valores recalculados pela base do pedido.
- [ ] CA12: Unificação, recuperação, distribuição por data e pasta de compra preservam alíquotas e valores e recalculam `PCG_VAL*` / `PCG_TOTGER` (onde o fluxo existir).
- [ ] CA13: Impressão HTML e exportações retornam os campos novos.
- [ ] CA14: Na cotação, o custo unitário com impostos e a escolha do melhor fornecedor ficam iguais antes e depois. No pedido, o unitário com impostos = unitário líquido + (IPI + ST + FCP + CBS + IBS + IS) / quantidade.
- [ ] CA15: Arquivos alterados continuam cp1252 (não UTF-8 válido) e sem flip de EOL fora das regiões editadas.
- [ ] CA16: `untImpostosReformaCompra.pas` é idêntico (mesmo hash) nas 5 versões.
- [ ] CA17: `autcom.groupproj` compila nas 5 versões; `Services.groupproj` compila na 150.

## 7. Fora de escopo

- Motor `TRefTribCalculo` / `pRefTribCalculaImpostosItens` e qualquer busca automática de alíquota.
- Termos da NT sem campo na tela (vServ, vSeg, vISSQN, vICMSMono, DIFAL, FCP próprio).
- Separação do IBS em UF e Município.
- Pré-nota (`untPreNota`).
- Importação de cotação pela API (`Suprimento.Services.Cotacao.Importacao.pas`, só na 150) e pelo portal (`Cotacao.ProcessaApi`): compilam com os defaults e preservam as alíquotas.
- 74.111: caminho antigo de gravação de pedido pela cotação (INI `COTACAO_MODO_GRAVACAO_ANTIGA=S`, `TCotacao.fIniciaPedidoCompra` / `fGravaItemPedido`). Pedido gerado nesse modo nasce sem CBS/IBS/IS.
- Importação de preços da tela antiga `untCadCotFornecedor`, PitStop e `untCadCotacao` / `untCadCotItensFornec` (fora de qualquer `.dpr`).
- Baixa de CBS/IBS/IS por entrada de nota (equivalente a `PCD_IPIBAI`).
- Layout das impressões (`.fr3` / `.dfm` de relatório).
- Inclusão de CBS/IBS/IS no custo unitário com impostos da cotação (`UNITOT`). No pedido elas entram (RN04).

## 8. Dependências e riscos

- **`CFG_SIMHIB` nos 7x:** criada neste requisito (RN01a). Empresa do Simples precisa ter a config gravada como `N` (o
  padrão) para não somar; sem a linha na `CFGSIS`, `fCfgSis` devolve vazio e soma.
- **NT:** fórmula conferida na NT 2025.002-RTC v1.33 (UB16-10). A NT 2026.008 remove a UB16-10 (homologação 10/2026); a base passa a ser só a da LC 214. A mudança fica restrita ao núcleo.
- **DDL:** aplicado no banco da 150. Falta aplicar e conferir (`SHOW COLUMNS`) nos bancos de 150.100, 150.45, 74.111 e 72.
- **Parcelas (RN09):** comunicar a mudança no valor das duplicatas com a regra ligada.
- **Superfície ampla:** cerca de 20 units por versão. Mitigação: núcleo único, rotina única de cópia de alíquotas, checklist por versão no tasks.md e o CA12.
- **Defaults posicionais:** as caudas de `pGravaPcmGer` / `pAtualizaPcmGer` / `fGravaPcmDet` diferem por versão. Chamadas que passam os defaults intermediários explicitamente precisam ser conferidas contra a assinatura local.
- **Cotação pivô (74.111, 72):** colunas por posição de fornecedor (01..50) multiplicam SQL e bindings. Mitigação: gerar no mesmo laço do `IPIENTnn`.
- **ICMS fora da tela:** a base depende do ICMS do item, que não é exibido. O valor CBS/IBS no painel serve de conferência.
- **Rodapé cheio:** `Panel4` sem espaço em todas as versões. Resolvido pelo rodapé em linha corrida (RF03a), que quebra
  linha e ajusta a altura sozinho.
