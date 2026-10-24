# Registro — Req. 470578

**Assunto:** Rateio do frete no faturamento parcial pelo coletor (API `faturarpedidos`) — a nota levava o frete inteiro
do pedido e a Expedição bloqueava o restante; o coletor passa a gravar como a Expedição do desktop.
**Período:** 20 a 22/10/2026 (joao.catarino, com Claude Code / skill citel-devRequisito)
**Cliente de origem:** Bela Tintas, loja 008 — PD 000001265735, FF 000000819425 (01/10/2026)
**Versão:** 02.30.74.150 (r501556; custo de última compra no parcial em r501746 — seção 10). A 02.74.150.100 foi
retirada do `vepeal`: o FaturamentoServicesAPI sai da .150.
**Zona:** Legado (`padra_atualizado/fontes/faturamento/`), compilado no autcom.exe e no FaturamentoServicesAPI
**Decisão de negócio (João):** o coletor substitui a Expedição do desktop — na Bela ele já "matou" a tela de Expedição,
e outros clientes vêm em seguida, operando só com celular/coletor. Portanto o endpoint grava **igual à Expedição**.

Documento de memória do requisito. Aqui fica o porquê, a jornada, as decisões e o que ficou de fora.

---

## 1. Contexto de negócio

O pedido de e-commerce da Bela entra pela inclusão de pedidos com frete (CIF, transportadora 00140), rateado nos itens
(`FDO_TOTFRE`), e é pago antes por adiantamento (`ADTCLI`, condição 214 = cartão, forma 007, à vista). A separação e o
faturamento são feitos pelo **coletor**, que chama a API do Faturamento (`POST /faturamento/faturarpedidos`, registrada
na `FSATSK` como `TFaturamentoService.fFaturarPedidos`) com a lista dos itens separados. Quando nem todos os itens
saem, o faturamento é parcial e a nota sai como **FF** ("parcial somente em FF").

Dois controles de frete coexistem no sistema:

| Modelo | Quem usa | Frete da nota | `FGO_FREBAI` (frete baixado do pedido) |
|---|---|---|---|
| Confirmação de pedidos (CP) | tela de faturamento do desktop (opção CP) e, até este requisito, a API | `FGO_TOTFRE − FGO_FREBAI` (o pendente do pedido inteiro) | vira `FGO_TOTFRE` na gravação (`pAtualizaFreBai`) |
| Expedição | `untFatExpedicaoItens` (cria a venda como `'CP'`) | soma do frete proporcional dos itens expedidos (`fltValFreExp` = `FDO_TOTFRE / QTDTOT × QTDEXP`) | também vira `FGO_TOTFRE` (mesmo `pAtualizaFreBai`) |

## 2. O problema (Bela, PD 1265735)

Pedido com 5 itens e frete 15,00 (rateio 0,69 / 0,59 / 8,22 / 2,87 / 2,63). O coletor faturou 4 itens (FF 819425,
01/10 18:43, FSATSK 295164). A FF levou os **15,00 inteiros**, rateados só nos 4 itens (0,84 / 0,72 / 9,97 / 3,47):
valor 90,10 em vez de 87,47. O item pendente 48351 continuou com os 2,63 de frete no pedido (`FDO_VLRCON` 18,63).

- Adiantamento 106,10, débito da FF 90,10, saldo 16,00.
- A Expedição (`PRINCIPAL > FATURAMENTO > EMISSÃO DE FATURAMENTO > EXPEDIÇÃO - IMPRESSÃO E BAIXA DA SEPARAÇÃO`)
  compara o valor pendente dos itens (com o frete deles, `untFatExpedicao.fGetSQLPedidos`) com o saldo do adiantamento
  (`fSituacaoFinanceiraPedidoOk` → `fValidaSituacaoFinanceiraPedido`, tolerância 0,05): 18,63 > 16,00 → bloqueado.
- O cliente não pagava duas vezes (90,10 + 16,00 = 106,10, o total do pedido): o frete ficava **contado em dois
  lugares**. O contorno do cliente era cancelar a FF e refaturar o pedido inteiro; a Cris (N3) zerou o frete do item.

## 3. Causa raiz

`TFaturadorBase.CarregarItensParaFaturar` (`Faturamento.Classes.TFaturador.Base.pas`) remove do `cdsVenda` os itens
fora da lista do coletor e chama `TFatVendaBase.pCalculaFreteDespDescPagAntConfPedidos`, que põe em `fltValFre` o
`FGO_TOTFRE − FGO_FREBAI` do pedido inteiro — o modelo da confirmação de pedidos, sem olhar quais itens saem.

## 4. Jornada e achados

### 4.1 Primeiro diagnóstico errado (corrigido na mesma sessão)

Na Parada 1 escrevi que o frete era "cobrado duas vezes"; pelo total do pedido (90,10 + 16,00 = 106,10) não era —
era contado duas vezes. Corrigido antes da Parada 2.

### 4.2 Simulação na base da suíte (`2_30_BELAT_TC`, empresa 069)

- PD 658/069 adaptado para espelhar a Bela: frete 8,00 (5,00 / 3,00), condição 058 (cartão, `01001`, forma 007),
  adiantamento 16,80 (`ADTCLI` id `02200000000470578069`).
- Reproduzido com a API antiga: FF 807 com frete 8,00, `FGO_FREBAI` 8,00, saldo 3,30, Expedição com o X (bloqueado).
- A tela de Expedição só lista pedidos com a separação **não baixada** (`FGO_OPBXSE` nulo), mas o faturamento exige a
  separação **baixada** (`fExigirBaixaSeparacaoAntesDeFaturar`); por isso o preparo alterna `FGO_OPBXSE`.
- O filtro "Situação Financeira" da tela no X mostra só os bloqueados — o pedido "sumir" com o filtro no X é sinal
  de que liberou.

### 4.3 Segundo defeito no mesmo fluxo: a segunda nota era recusada

`TValidarFaturamento.fValidarSituacaoFinanceiraPedido` (`Faturamento.Classes.TValidarVenda.pas`) chama a
`fValidaSituacaoFinanceiraPedido` de 3 parâmetros, que compara o saldo do adiantamento com `FGO_VLRCON − FGO_TOTBRI`
(o **total do pedido**). Depois da primeira nota, o saldo só cobre o pendente: para forma 007 a diferença passa da
tolerância e a API devolve 400 "Pedido com forma de pagamento CARTAO com recebimento menor que o valor do documento".
Na Bela o coletor também não faturaria o item 48351 (16,00 contra 106,10) — explica o contorno de refaturar tudo.
A Expedição do desktop não passa por essa validação (`blnExpedi`).

### 4.4 Terceiro defeito: itens sem a marca de faturado em vários pedidos

No `fFaturaPedidosVenda`, a contagem de itens abertos de cada pedido (decide se chama `fMarcaOrcPed`) era filtrada por
`FDO_CODITE IN (fRetCodMatItens)` montado **uma vez antes do laço** (`intContador = -1`), com os produtos de todos os
pedidos. Com dois pedidos de mesmos produtos (PDs 470578/470579, cópias do 658), o 56337 pendente do 470578 contava como
aberto por causa do 56337 faturado do 470579, e nenhum item recebia `FDO_NUMFAT`/`FDO_JAFATU`.
Provado que era anterior: a mesma chamada com o executável da CI de 20/10 (r501106, porta 8476) — FF 816, frete
**16,00** (o inteiro dos dois pedidos) e itens também sem marca. Em produção (Bela, notas `FA` com vários pedidos) os
itens saíram marcados: o cruzamento de produtos é raro.

### 4.5 Quarto defeito: quantidade parcial sem o número da nota

A Expedição, no parcial, chama `fMarcaOrcPed` pelo ramo próprio (`blnExpedi And objExpedicao.blnExpParcial`): o item
recebe `FDO_NUMFAT` e só ganha `FDO_JAFATU` se saiu inteiro. A API não tinha esse ramo: o item faturado em parte conta
como aberto (`FDO_QTDBAI <> FDO_QTDITE`) e ficava sem a nota. Medido na Bela (outubro): itens faturados em parte —
Expedição (`EI`) 813, todos com o número; coletor (`FA`) 154, **23 sem o número**.

### 4.6 Ciclos com o DelphAI (o que foi tentado e desfeito)

| Ciclo | Proposta | Apontamento | Desfecho |
|---|---|---|---|
| 1 | frete proporcional + `pAtualizaFreBai` gravando o frete das quantidades baixadas + cancelamento descontando o frete da nota | frete pendente não limitado; cancelamento zera tudo; try/finally; inner join | limite por pedido, LEFT JOIN, cancelamento por `GER_TOTFRE` |
| 2 | idem | `FREBAI` podia diminuir; cancelamento tira o frete da nota inteira do último pedido; Exit pulava boleto | **mudança de rumo**: o João perguntou como a Expedição faz — alinhar ao modelo dela |
| 3 | não gravar `FREBAI` no coletor | CP depois do coletor cobraria o frete inteiro; SQL da contagem reaproveitado no ramo de alteração | descoberto que a **Expedição grava** `FREBAI = TOTFRE` (cria a venda como `'CP'`); `pAtualizaFreBai` voltou ao original, limite removido, `strSQLItensAbertos` |
| 4 | gravar igual à Expedição | CP depois do coletor não cobra o frete pendente | recusa aceita pelo DelphAI: é o comportamento da Expedição hoje → **APPROVED** |

A alteração em `untCancelaDocumentos.pas` (estorno do `FGO_FREBAI` pelo frete da nota) foi **revertida**: com o modelo
da Expedição ela deixou de ser necessária e mexia numa rotina sem cobertura de teste.

## 5. Solução final (r501556)

| Arquivo | O que mudou |
|---|---|
| `Faturamento.Classes.TFaturador.Base.pas` | novo `AplicarFreteDosItensParaFaturar`, chamado ao fim de `CarregarItensParaFaturar` (só com lista de itens): frete da nota = Σ `FDO_TOTFRE / FDO_QTDITE × qtd faturada` (+ `FDO_FRERAT` na mesma proporção quando `FGO_FRERAT > 0` e `fRateiaFreteItensTransportadora`); liga `blnFaturamentoPorListaDeItens` |
| `Faturamento.Classes.TFatVendaBase.pas` | campo `blnFaturamentoPorListaDeItens`; em `fFaturaPedidosVenda`, a contagem de itens abertos usa `strSQLItensAbertos` + `FDO_CODITE IN` **por pedido**; novo ramo `Else If (Not blnBaixou) And blnFaturamentoPorListaDeItens` chamando `fMarcaOrcPed` como a Expedição parcial |
| `Faturamento.Classes.TValidarVenda.pas` | `fValidarSituacaoFinanceiraPedido`: no faturamento automático, se o adiantamento cobre a nota (`FPedidoPossuiAdiantamentoTotal`) e não há boleto de adiantamento pendente (`fltBolAdt = 0` ou `blnBolVen`), dispensa a checagem pelo total do pedido |
| `FaturarPedidosTest.inc` + casos 1365–1368 | casos de teste (abaixo) |

`pAtualizaFreBai` e `pCalculaFreteDespDescPagAntConfPedidos` ficaram **inalterados**. Complexidade de
`fFaturaPedidosVenda` foi de 96 para 101 — aceito pelo João (método legado muito acima do limite).

## 6. Validação

| Teste (base `2_30_BELAT_TC`, API 10.0.0.205:8475, build 22/10 13:46:10Z) | Nota | Resultado |
|---|---|---|
| Caso 1365 — PD 658, só o 56334 | FF 821 | frete 5,00; item `JAFATU` 1; `FGO_FREBAI` 8,00 |
| Caso 1366 — PDs 470578 (56334) + 470579 (56337) | FF 822 | frete 8,00; `DET_NUM_PD` correto; itens marcados nos dois |
| Caso 1367 — 2 de 5 un do 56334 (separação parcial) | FF 823 | frete 2,00; item com nº da FF e `JAFATU` 0 |
| Caso 1368 — segunda nota do 658 com saldo 6,30 | FF 824 | aceita (antes 400); frete 3,00; pedido fechado |
| Tela de Expedição (PD 658 depois da FF 811) | — | situação financeira ✓ (print), saldo 6,30 |

Os casos foram rodados à mão (preparo + chamada + comparação com o `json_validate`), não pelo runner.
**Não testado na r501556:** frete rateado da transportadora (`FGO_FRERAT`) — testado depois, seção 10; Expedição do
desktop depois da mudança da contagem por pedido (mesmo trecho) — a Expedição faturou os pedidos da seção 10 sem erro.

## 7. Fora do escopo / pendências

1. **Expedição × Confirmação de Pedidos:** depois de uma expedição ou de um faturamento parcial pelo coletor,
   faturar o restante pela confirmação de pedidos não cobra o frete pendente (`TOTFRE − FREBAI = 0`). Anterior a este
   requisito; o DelphAI sugeriu requisito próprio.
2. **Frete rateado:** a Expedição soma o `FRERAT` também com `FParams.blnFreteRateado`; a API usa a condição da CP.
   Simulado na seção 10: com transportadora que rateia, API e Expedição gravam igual (total e parcial). Sobra só o caso
   de pedido gravado com rateio cuja transportadora deixou de ratear — não visto em produção.
3. **Cancelamento** (`untCancelaDocumentos.pAtualizaFreteBaixado`) zera `FGO_FREBAI` quando a nota cancelada tinha
   frete; queries sem `try/finally` em `pAtualizaFreBai` e `pAtualizaFreteBaixado` (apontados pelo DelphAI).
4. **Casos de teste:** o `.sql` do caso faz `INSERT ... ON DUPLICATE KEY UPDATE` — id repetido entre devs sobrescreve
   o caso alheio sem erro. **Feito em r501567:** o `validar_casos.py` (lib comum das três suítes) reprova id que já
   existe no HEAD com outro arquivo ou na base com outro `test_case`. Não feito: ON DUPLICATE condicionado ao `test_case`.
5. **Base da suíte:** aplicado o `SCRIPT_064` do Req. 455281 (`MOVTRI`/`DEL_MOVTRI.DET_VLGNRF`), que faltava depois do
   `svn update` (r501180).

## 8. Armadilhas e lições

- Para duplicar um PD na base de teste: FATGOR, EXTGOR, AUXGOR, **GORCND**, FATDOR, EXTDOR, DORICD, **FDOITE**, LOTDOR,
  SEPDOR, SEPDOR_AUTCOM (+ ADTCLI). Sem GORCND: "parcelas inconsistentes". Inserir em rodadas por causa das FKs.
- O faturamento apaga o `LOTDOR` do item (cópia em `DEL_LOTDOR`); o preparo do caso repõe por `REPLACE`.
- `FDO_NUMFAT` se repete entre empresas (FF 819 de 2022 da empresa 060): filtrar por `FDO_EMPFAT` e cliente.
- Reiniciar o serviço Linux pela porta (`sudo lsof -t -i :8475 | xargs -r sudo kill`) e conferir o `buildDate` do
  `/api/info` antes de testar — duas vezes o teste quase rodou contra o executável velho.
- `svn update` parcial (só duas units) deixou a cópia com revisões misturadas e a API não compilou (r501147 mexeu em
  25 units); resolvido com o update completo.
- A consideração de baixa colada com a mensagem inteira foi replicada pelo Diário na `vepeal` e na `conalt`;
  corrigida por UPDATE copiando da `movalt`.

## 9. Referências

- Commits: r501556 (frete), r501567 (validador de ids), r501746 (custo de última compra) —
  `svn://10.0.0.205/Padrao/027.18/27.18.379/379.48.2.30.74.150`.
- Diário: protocolo 470578 (Bruna / Cristiane), Zendesk 1709062.
- Base de teste: PDs 000000000658, 000000470578, 000000470579 (empresa 069, cliente 00105635).

---

## 10. Segunda rodada (22/10/2026, tarde): API × Expedição e custo de última compra (r501746)

Depois do commit do frete, o João pediu para medir **onde o endpoint ainda diverge da Expedição** — mesmo pedido
faturado pelas duas rotinas, comparado coluna a coluna (`MOVGER`, `MOVDET`, `AUXMOV`, `MOVTRI`, `MOVREF`, `GERCND`
e o lado do pedido `FATGOR`/`EXTGOR`/`FATDOR`/`EXTDOR`). Pedidos montados por SQL na base da suíte (PDs
470580–470587, cópias do 470579) com a transportadora 00010 marcada para ratear (`TRA_FREVEN = 'R'`).

### 10.1 Frete rateado — sem divergência

Pedido com frete rateado guarda o frete **dentro do preço do item** (`FDO_UNITAR = FDO_UNIORI + FDO_FRERAT/qtde`,
`FGO_TOTFRE = 0`, `EXTGOR.FGO_FRERAT = frete`) — formato copiado de um pedido real da base de desenvolvimento
(PD 3225/000, NF 2479/2480 pela Expedição). A suspeita era a API lançar o rateado como frete da nota **e** manter o
preço, cobrando duas vezes. Não acontece: o caminho comum desfaz e refaz o rateio, e as notas da API e da Expedição
saíram iguais (`GER_TOTFRE = 0`, `AUX_FRERAT` = rateado), no total (NF 35015717 × 35015718) e no parcial
(FF 827/828 × 826/829).

Contraprova com o binário de **20/10 (anterior à r501556)**: a nota parcial levava o rateado **inteiro** (8,00 em cada
nota, 16,00 num pedido de 8,00) e o item faturado inteiro na parcial não era marcado — o mesmo defeito do frete
comum, também resolvido pela r501556.

### 10.2 Divergências encontradas e decisão

| Divergência | Decisão |
|---|---|
| Separação depois do parcial: a Expedição reabre (`pDesmarcaSepImp`, em `TfrmFatExpedicao.pExpedirPedidos`, conforme `LMCBSE`/`LMCBTO`/`BAISEP`); a API deixa o pedido como separado | **Não mexer**: quem separa é o coletor; o controle do separado e do pendente é dele (João) |
| Liberação da expedição e quantidade/operador expedido | **Não é divergência na Bela**: lá as notas `FA` têm `GER_DTLBEX`/`GER_OPLBEX` ('AUT') e `DET_QTDEXP`. No teste faltou porque a 069 da suíte tem `CFG_EXPFAU = S` (o faturador deixa `GER_DTLBEX` nulo de propósito, `TFaturador.Base` → `untMovGer`) e porque chamamos só o `faturarpedidos`, sem as etapas do coletor |
| `AUX_OPFAEX` vazio nas notas do coletor | Sem efeito; não mexer |
| Volumes (`GER_VOLUME`) | Digitados no coletor; diferença esperada |
| `GER_ALQICM` / `DET_PERBAS` | Na Bela, item com ICMS sai igual pelas duas rotinas; o zero só aparece em item sem ICMS |

Observação: a loja 008 da Bela ainda emitiu 1.220 notas pela Expedição em outubro (contra 6.895 do coletor) — as
duas rotinas convivem.

### 10.3 Defeito corrigido: custo de última compra no parcial

Na segunda nota de um item já faturado em parte, a API gravava `MOVTRI.DET_TOTULT`/`DET_IMPULT` = **-3,00** (custo
de última compra 0 na suíte). Existia antes da r501556 (reproduzido no binário de 20/10). Dois defeitos:

1. **Precedência no SQL do pedido** (`Pedido\untSQLItensPedido.pas`, `fQuantidadeDoItem`, r328024): devolvia
   `FDO_QTDITE - <baixada>` sem parênteses e as colunas `ITE_TOTULT_QTDITE`/`ITE_TOTIMP_QTDITE` faziam
   `G.ITE_PREULT * FDO_QTDITE - <baixada>`. Com custo 10 e 3 de 5 baixadas: 47,00 em vez de 20,00. O SQL é comum a
   14 rotinas que carregam pedido por `pCarregaPedidoOrcamento` (API, Vendas, Confirmação de Pedidos, Romaneio…);
   a Expedição escapa porque monta os itens com SQL próprio e recalcula pela quantidade expedida
   (`untFatExpedicaoItens.pas` ~5712). **Correção:** os parênteses dentro da `fQuantidadeDoItem` (proposta do João,
   em vez de nas chamadas).
2. **A API não recalculava pelo faturado no parcial** (`TFaturador.Base.pas`, depois de `ITE_QTDITE := LQtdFaturar`):
   gravava o custo do pendente inteiro (3 de 5 → custo de 5). **Correção:** recalcular `ITE_TOTULT`/`ITE_TOTIMP` =
   `ITE_PREULT`/`ITE_IMPULT` × quantidade faturada, com a regra da Expedição (item `NOR` sem acabamento).

Na Bela não há valor negativo (custo real > 0), mas o valor gravado no restante e no parcial estava errado.

**Casos 1383–1387** (pedido 470587: 17064 × 5 com custo 10,00 / impostos 2,00 + 56337 × 3), todos passando à mão:
parcial 3 de 5 (30,00/6,00), restante 2 (20,00/4,00), parcial 1 de 5 (10,00/2,00), restante 4 (40,00/8,00),
total (50,00/10,00, espécie NF). Afirmam também `AUX_FRERAT` proporcional e o fechamento do pedido.

A versão final (parênteses dentro da função, r501746) foi recompilada e passou de novo nos dois casos de restante:
1384 (FF 839, 20,00/4,00) e 1386 (FF 840, 40,00/8,00).

**Não testado:** as telas do autcom que usam o SQL (Vendas etc.) — só a expressão foi provada no banco, o WMS da 069
bloqueou a tela de Vendas; os casos foram rodados à mão, não pelo runner.

### 10.4 Dependências e armadilhas desta rodada

- **Base da suíte:** os casos 1383–1387 dependem da transportadora **00010 com `TRA_FREVEN = 'R'`** (a API só soma o
  rateado se a transportadora rateia) e do item **17064** com lote `PICKING` e `A DEFINIR` em `CADLOT` (o preparo dos
  casos reforça custo, estoque e lote, mas não a transportadora). Não reverter a 00010.
- A suíte da 069 tem custo de última compra **zero em todos os 29.463 itens** e seis casos afirmam zero no 56334/56337:
  para testar custo, usar outro item.
- `CFG_EXFPFF`: com ela ligada, o restante só sai **FF** se houver nota anterior ligada ao pedido
  (`MOVDET.DET_NUM_PD`); o preparo que desliga tudo faz o restante sair NF. Pedido inteiro sem nota anterior sai NF.
- WMS (`fValidarDefinicaoLotesPedidoWMS`) exige `CADLOT` com o `FDO_NUMLOT` do item ("A DEFINIR").
- `AUTOINCREM` é `VARCHAR(20)`: chave montada com 23 caracteres foi cortada calada pelo MySQL.
- Consulta de medição por data (`GER_DTADOC`) na produção da Bela ficou pesada (sem índice) e foi derrubada com
  `KILL`; medir pela chave ou não medir na produção.
