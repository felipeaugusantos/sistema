# Lentidão e travamento do AutCom na ativação de lote de preços da entrada de mercadorias (Req. 461662)

**Escopo:** correção de performance em `TLotePrecos.pAlterarPrecoMargem`/`pAtualizaCdsPrecos`/`pSetCDSGrids`/
`pCriaCdsPrecos`, causa raiz da demora de 3-4 minutos por tabela de preço e do eventual travamento/fechamento
do AutCom durante a ativação de lote de preços da entrada de mercadorias.

**Zona:** Legado (`padra_atualizado/fontes/movimentacaoitens/`).

**Continuação de:** Req. 460063 (mesma tela/fluxo, mesma classe `TLotePrecos`).

**Data:** 2026-09-11.

**Cliente/origem:** Moto Mais, contato Sebastião, Zendesk 1655410.

---

## 1. Contexto de negócio

A tela de "Ativação de Lote de Preços" (`untLotePrecosEfetivacaoCx.pas`, classe auxiliar `TLotePrecos` em
`untLotePrecos.pas`) permite ao usuário, durante a entrada de mercadoria, revisar e alterar em lote os valores
das quatro tabelas de preço de um conjunto de itens (preço de custo, três tabelas de margem/preço de venda —
`MARBR1`-`MARBR4`/`PREVE1`-`PREVE4` conforme configuração). Ao alterar o valor de uma tabela para um item e
marcar para replicar, o sistema propaga o mesmo valor para os demais itens do mesmo grupo de preço.

Cada item, ao ser alterado, atualiza uma grade interna de metadados de exibição (`FCdsPrecos`, um
`TUniClientDataSet` com exatamente 36 linhas fixas — uma por campo de preço exibido: "Preço de Custo", "Preço
de Venda 1" a "8", etc., cada linha trazendo valor anterior e valor atual lado a lado). Essa grade é dividida
em até 3 sub-grades (`FCdsPrecos1`, `FCdsPrecos2`, `FCdsPrecos3`) para exibição em até 3 colunas/painéis na
tela, via `pSetCDSGrids`.

## 2. Problema relatado

Continuação do Req. 460063 (que já havia corrigido o sintoma de tela "não responde" durante a replicação,
adicionando `TfrmGravando` + `Application.ProcessMessages` ao loop de `pReplicaPrecoParaItens`). Mesmo com
essa correção, o cliente relatou:

- Cada uma das quatro tabelas de preço levava 3-4 minutos para processar em lotes com muitos itens.
- A demora aumentava progressivamente de tabela para tabela, dentro da mesma sessão de uso.
- Em determinado momento, o AutCom travava com tela branca e fechava sozinho, sem o operador ter fechado.

Ou seja: a mitigação de UI (ProcessMessages) resolvia o sintoma de "tela não responde momentaneamente", mas
não o problema de fundo — o tempo real de processamento por item estava crescendo sem limite ao longo da
sessão, até ultrapassar o que a mitigação conseguia absorver.

## 3. Metodologia de investigação

Diagnóstico via instrumentação temporária (`TStopwatch`, `System.Diagnostics`) escrevendo um log local
(`temp\log_lotepreco_diag.txt`, nunca commitado, sempre fora do controle de versão) em `pAlterarPrecoMargem`,
`pAtualizaCdsPrecos` e `pSetCDSGrids`. A cada rodada de teste (lote real de 269 itens, tabelas `MARBR1` e
`MARBR4`), o log era analisado, uma hipótese era descartada ou confirmada, e um nível mais fino de
instrumentação era adicionado antes do próximo teste — até a causa raiz ficar isolada em código específico.

Versão do log incrementada a cada rodada (`Log: v1.1` a `v1.5`) para permitir confirmar visualmente qual
build gerou qual arquivo de log antes de analisar.

### 3.1 Rodada 1 — descoberta da chamada redundante

Split inicial em `pAlterarPrecoMargem`, separando o tempo de `pAtualizaCdsPrecos` do tempo da chamada
explícita de `pSetCDSGrids` no `Finally`:

| Métrica | Resultado |
|---|---|
| `ms_atucdsprecos` (dentro de `pAtualizaCdsPrecos`) | ~49% do tempo total por item |
| `ms_setcdsgrids_extra` (chamada explícita redundante) | **~47% do tempo total por item** |

Ambas cresciam ~4-5x ao longo de um lote de 269 itens.

### 3.2 Investigação da origem da chamada redundante (a pedido do usuário)

Antes de remover, foi verificado se a chamada explícita de `pSetCDSGrids` em `pAlterarPrecoMargem` havia sido
adicionada deliberadamente em algum momento para corrigir outro problema (hipótese explicitamente levantada
pelo usuário: "foi as vezes foi colocado ai para tratar algum outro problema").

```
svn blame -r489810 untLotePrecos.pas
```

Ambas as ocorrências de `pSetCDSGrids` (a chamada interna, dentro de `pAtualizaCdsPrecos`, e a externa, em
`pAlterarPrecoMargem`) apontaram para a mesma revisão de origem: **r207442** (autor `william.gama`,
16/01/2020, Req. 141958).

```
svn diff -c 207442 untLotePrecos.pas
```

Confirmou que esse único commit:
1. Criou a própria procedure `pSetCDSGrids`.
2. Adicionou sua chamada interna dentro de `pAtualizaCdsPrecos` (ao final do corpo).
3. Adicionou a chamada externa (redundante) em `pAlterarPrecoMargem`.

Tudo como parte da introdução da funcionalidade de exibição em 2-3 grids de preço (`FCdsPrecos1/2/3`).

A revisão seguinte que tocou o bloco (`r489811`, Req. 455251) apenas reindentou o código (mudança de
formatação, sem relação com a duplicação).

**Conclusão:** a chamada redundante foi uma duplicação por descuido no momento de criação da funcionalidade
(alguém, ao escrever `pAtualizaCdsPrecos` já chamando `pSetCDSGrids` internamente, também deixou uma chamada
solta em `pAlterarPrecoMargem`, possivelmente um resquício de uma versão anterior do código em que
`pAtualizaCdsPrecos` não chamava `pSetCDSGrids` sozinho) — não uma correção deliberada posterior para outro
bug. Segura de remover.

### 3.3 Rodada 2 — pós-remoção da chamada redundante

Com a chamada redundante removida, `ms_setcdsgrids_extra` foi a zero em todas as 538 chamadas do teste. Mas
`pAtualizaCdsPrecos` sozinho continuou crescendo (ex.: MARBR1 ~30ms→~63ms; MARBR4 ~65ms→~160ms), e o
crescimento parecia **cumulativo entre tabelas na mesma sessão** (MARBR4 começando aproximadamente onde
MARBR1 terminou) — indício inicial de que a causa não estava ligada ao volume de dados de uma tabela
específica, e sim a algo acumulando ao longo de toda a sessão de uso.

### 3.4 Rodada 3 — split dentro de `pAtualizaCdsPrecos`

Split fino separando o loop interno (percorre as 36 linhas de `FCdsPrecos` atualizando valores) da chamada
interna a `pSetCDSGrids`:

| Métrica | Resultado |
|---|---|
| `FCdsPrecos.RecordCount` | **constante em 36**, em 543 amostras — descarta crescimento de dataset |
| `ms_loop` (loop das 36 linhas) | custo desprezível, 0ms→26ms |
| `ms_pSetCDSGrids_interno` | **0ms→165ms; ~36 segundos de ~40,8 segundos combinados (~88%)** |

### 3.5 Rodada 4 — split dentro de `pSetCDSGrids`

Split em 4 blocos: o loop que atribui `USGRID`/`SEQUEN` a cada uma das 36 linhas, e cada um dos 3 blocos de
reatribuição (`FCdsPrecos1`/`FCdsPrecos2`/`FCdsPrecos3` — `.Data`/`.Filtered`/`.Filter`/`.IndexFieldNames`).

Resultado antes de qualquer correção nesta rodada: crescimento distribuído **igualmente** entre os 4 blocos —
inclusive o loop `USGRID`/`SEQUEN`, que não toca em nenhum grid. Isso descartou a hipótese inicial de "um
grid específico está causando o problema" e apontou para um custo cumulativo **por chamada**, independente de
qual bloco especificamente.

### 3.6 Correção intermediária — `DisableControls`/`EnableControls` (Nota 2)

Hipótese: os 3 blocos de reatribuição de `FCdsPrecos1/2/3` disparavam repaint completo dos 3 grids visíveis
(`dbgPrecos`/`dbgPrecos2`/`dbgPrecos3`, `TDBGridCitel`, ligados via `TDataSource` — confirmado em
`untLotePrecosEfetivacaoCx.pas` por `dbgPrecosDrawColumnCell` usando
`TDBGridCitel(Sender).DataSource.DataSet`) a cada chamada, sem suspensão.

Aplicado `DisableControls`/`EnableControls` ao redor de cada bloco. Resultado:

| Tabela | Antes | Depois | Redução |
|---|---|---|---|
| MARBR1 (269 itens) | 32.471ms | 25.303ms | -22% |
| MARBR4 (269 itens) | 77.086ms | 68.525ms | -11% |

Melhora real, mas **parcial** — e o bloco `ms_loop_usgrid` (não tocado por essa correção, `FCdsPrecos` já
estava com `DisableControls` ativo desde `pAtualizaCdsPrecos`) continuou crescendo **exatamente igual** nas
duas rodadas (0ms→25/26ms). Isso descartou repaint de grid como causa raiz do crescimento — só um custo fixo
por chamada, eliminado pelo fix, mas não a causa do crescimento cumulativo.

### 3.7 Causa raiz — `LogChanges` (Nota 3)

Como o crescimento persistia igualmente em um bloco que não envolve nenhum grid (o loop `USGRID`/`SEQUEN`
sobre `FCdsPrecos`, já com `DisableControls` ativo), a hipótese seguinte foi o **changelog interno** do
`TUniClientDataSet` `FCdsPrecos`.

Verificação: `FCdsPrecos := TUniClientDataSet.Create(Self); ... FCdsPrecos.CreateDataSet;` — criado 100% em
memória, sem `TUniQuery`/`TUniDataSetProvider` por trás. Busca (`Grep`) por `ApplyUpdates`, `CancelUpdates`,
`Delta`, `RevertRecord`, `ChangeLog` sobre `FCdsPrecos` em toda a unit `untLotePrecos.pas`: **zero
ocorrências**.

Por padrão, `TClientDataSet`/`TUniClientDataSet` mantêm `LogChanges := True`, registrando cada `Edit`/`Post`
num changelog interno usado para suportar `ApplyUpdates`/`CancelUpdates`/`RevertRecord`. Como esse dataset
nunca usa nenhum desses recursos, o changelog só crescia indefinidamente a cada `Post` ao longo da sessão —
cada `Post` subsequente ficava progressivamente mais lento por manter um changelog cada vez maior, sem
nenhum benefício.

**Correção:** `FCdsPrecos.LogChanges := False;`, logo após `FCdsPrecos.CreateDataSet;` em `pCriaCdsPrecos`.

**Resultado (validação completa, rodada final v1.5):**

| Métrica | v1.3 (antes de qualquer fix) | v1.4 (+DisableControls) | v1.5 (+LogChanges=False) |
|---|---|---|---|
| `ms_loop_usgrid` | 0→25ms (crescia) | 0→26ms (crescia) | **0→0ms (plano)** |
| `ms_cdsprecos1` avg | ~22,6ms | ~14,9ms | **~5,4ms (estável)** |
| `ms_cdsprecos2` avg | ~23,4ms | ~14,5ms | **~4,9ms (estável)** |
| `ms_cdsprecos3` avg | ~14,2ms | ~14,3ms | **~0,06ms (estável)** |
| Total MARBR1 (269 itens) | 32.471ms | 25.303ms | **14.511ms** |
| Total MARBR4 (269 itens) | 77.086ms | 68.525ms | **19.072ms** |

Nenhum bloco cresce mais ao longo da sessão. Custo total do lote de 269 itens caiu de ~77s (pior tabela, sem
nenhuma correção) para ~19s — mais de 4x, sem sinal de crescimento residual.

### 3.8 Verificação de segurança ampliada de `LogChanges := False` (pós-implementação, a pedido do usuário)

O usuário questionou explicitamente se desligar `LogChanges` poderia causar erro na hora de commitar dados no
banco. Busca ampliada, desta vez em **todo** `padra_atualizado/fontes/` (não só `untLotePrecos.pas`):

- `ApplyUpdates`/`CancelUpdates`/`Delta`/`RevertRecord`/`ChangeLog` sobre `FCdsPrecos` ou
  `cdsPrecos1`/`cdsPrecos2`/`cdsPrecos3` (propriedades públicas que expõem `FCdsPrecos1/2/3`) — **zero
  ocorrências em todo o projeto**.
- `Modified`/`ChangeCount`/`UpdateStatus` sobre os mesmos datasets — **zero ocorrências** (esses também
  dependeriam do changelog ativo para funcionar corretamente, ex.: para perguntar "há alterações não
  salvas?").
- Levantamento de **todos** os arquivos do projeto que referenciam `cdsPrecos1`/`cdsPrecos2`/`cdsPrecos3` —
  apenas 2 em todo o sistema: `untLotePrecos.pas` (onde são criados/populados) e
  `untLotePrecosEfetivacaoCx.pas`, onde o único uso é:
  - Atribuição a `TDataSource.DataSet` (`dtsPrecos.DataSet := objPreLotes.cdsPrecos1;` etc., linhas
    ~2118-2128 e ~2214-2216) — para alimentar os grids visuais.
  - Comparação de identidade `DataSet = objPreLotes.cdsPrecosN` dentro do handler de desenho de célula
    `dbgPrecosDrawColumnCell` (~linha 1609-1660) — só para decidir qual dos 3 grids está sendo desenhado.

**Conclusão:** `FCdsPrecos`/`cdsPrecos1/2/3` são datasets de exibição pura, que nunca saem da tela de
ativação de lote de preços — quem realmente grava no banco é o dataset de itens (`Dataset`/`cdsConsulta`),
através de `Dataset.Post` dentro de `pRecalculaDados`, não tocado por esta correção e com seu próprio
`LogChanges` inalterado. Risco de erro em commit no banco: descartado com confiança.

### 3.9 Achado colateral investigado e explicado (não é bug, não corrigido)

Um pico isolado de 17,4s (MARBR1) e 41,9s/38,2s (MARBR4, em rodadas diferentes) aparecia consistentemente no
`ms_prefinally` (tempo fora de `pAtualizaCdsPrecos`/`pSetCDSGrids`) do **último item de cada tabela**,
levantando a hipótese de uma quarta causa de lentidão.

Investigação: o item que gera o pico é sempre o item que **disparou** a replicação (`blnChamadaOriginal`),
não um item comum. Esse item entra no bloco:

```pascal
If blnReplicaValorItens Then
Begin
  ...
  frmGravando.ShowModal;   // bloqueia ate fReplicaPrecoParaItensPrg terminar
End;
```

`ShowModal` é síncrono — só retorna depois que `pReplicaPrecoParaItens` processa **todos os outros itens** do
grupo (cada um chamando `pAlterarPrecoMargem` recursivamente e logando sua própria linha de diagnóstico). O
cronômetro da chamada original, iniciado no início da procedure, permanece rodando durante todo esse tempo —
e só é lido (e logado) depois que `ShowModal` retorna, ou seja, **depois de todas as chamadas aninhadas
terem terminado**.

Confirmação numérica (soma de `ms_total_chamada` das demais chamadas da mesma tabela vs. valor do "outlier"):

| Tabela | Outlier (última chamada logada) | Soma das outras 268 chamadas | Diferença (overhead do próprio ShowModal + 268× ProcessMessages) |
|---|---|---|---|
| MARBR1 | 19.222ms | 13.249ms | ~5.973ms |
| MARBR4 | 41.899ms | 35.187ms | ~6.712ms |

**Conclusão:** não é uma quarta causa de lentidão real — é dupla contagem inerente à instrumentação de
diagnóstico, causada pela recursão síncrona via `ShowModal`. Não requer correção. Registrado aqui para não
ser confundido com um problema pendente em investigações futuras.

## 4. Soluções aplicadas

**Arquivo:** `padra_atualizado/fontes/movimentacaoitens/untLotePrecos.pas`, classe `TLotePrecos`.

### 4.1 Remoção da chamada redundante (Nota 1)

`pAlterarPrecoMargem`, bloco `Finally`:

```pascal
{pSetCDSGrids explicito removido - pAtualizaCdsPrecos (chamado logo abaixo) ja o chama
 internamente ao final de seu proprio corpo. A chamada explicita era redundante e chegou
 a consumir ~47% do tempo total desta procedure por item processado.
 Verificar Nota 1 - Req. 461662}
If intFlagUtilizarNovoPreco > - 1 Then
  pAtualizaCdsPrecos(Dataset, strCamAlt, AfltValAtu)
Else
  pAtualizaCdsPrecos(Dataset);

DataSetPrecos.EnableControls;
DataSetPrecos.RecNo := intRegPrc;
```

(a linha `pSetCDSGrids;` que existia entre `pAtualizaCdsPrecos(...)` e `DataSetPrecos.EnableControls;` foi
removida por completo).

### 4.2 `DisableControls`/`EnableControls` (Nota 2)

`pSetCDSGrids`, os 3 blocos de reatribuição:

```pascal
{DisableControls/EnableControls ao redor da reatribuicao - FCdsPrecos1/2/3 sao os datasets
 ligados aos grids visiveis (dbgPrecos/dbgPrecos2/dbgPrecos3); sem isso cada
 .Data/.Filtered/.Filter/.IndexFieldNames dispara repaint completo dos 3 grids a cada chamada.
 Verificar Nota 2 - Req. 461662}
FCdsPrecos1.DisableControls;
Try
  FCdsPrecos1.Data := FCdsPrecos.Data;
  FCdsPrecos1.Filtered := False;
  FCdsPrecos1.Filter := 'USGRID = 1';
  FCdsPrecos1.Filtered := True;
  FCdsPrecos1.IndexFieldNames := 'SEQUEN';
Finally
  FCdsPrecos1.EnableControls;
End;

FCdsPrecos2.DisableControls;
Try
  FCdsPrecos2.Data := FCdsPrecos.Data;
  FCdsPrecos2.Filtered := False;
  FCdsPrecos2.Filter := 'USGRID = 2';
  FCdsPrecos2.Filtered := True;
  FCdsPrecos2.IndexFieldNames := 'SEQUEN';
Finally
  FCdsPrecos2.EnableControls;
End;

FCdsPrecos3.DisableControls;
Try
  FCdsPrecos3.Data := FCdsPrecos.Data;
  FCdsPrecos3.Filtered := False;
  FCdsPrecos3.Filter := 'USGRID = 3';
  FCdsPrecos3.Filtered := True;
  FCdsPrecos3.IndexFieldNames := 'SEQUEN';
  FCdsPrecos.First;
Finally
  FCdsPrecos3.EnableControls;
End;
```

### 4.3 `LogChanges := False` (Nota 3 — causa raiz)

`pCriaCdsPrecos`, logo após `FCdsPrecos.CreateDataSet;`:

```pascal
{LogChanges desligado - FCdsPrecos e um dataset 100% em memoria (CreateDataSet), nunca
 gravado via ApplyUpdates/CancelUpdates - manter o changelog interno ligado so acumula
 deltas indefinidamente a cada Edit/Post ao longo da sessao, deixando cada novo Post
 progressivamente mais lento sem nenhum beneficio (nada usa o changelog aqui).
 Verificar Nota 3 - Req. 461662}
FCdsPrecos.LogChanges := False;
```

## 5. Decisões de escopo

**Incluído:**
- As três correções acima, todas dentro de `TLotePrecos` (`untLotePrecos.pas`).
- Investigação histórica via SVN da origem da chamada redundante (Seção 3.2), a pedido explícito do usuário.
- Verificação de segurança ampliada de `LogChanges` em todo o projeto (Seção 3.8), a pedido explícito do
  usuário, após a implementação.

**Excluído deliberadamente:**
- Qualquer alteração em `pAlteraPreco`, `pAjustaPrecos`, `pRecalculaDados`, `fValidaMargemDataSet` — nenhuma
  regra de cálculo de preço/margem foi tocada.
- Otimização de outros pontos do sistema que também usem `TUniClientDataSet`/`TClientDataSet` com
  `LogChanges` ligado sem necessidade — poderia ser um requisito técnico à parte, não investigado aqui.
- A mitigação de UI já aplicada no Req. 460063 (`TfrmGravando`/`ProcessMessages`) não foi alterada, apenas se
  beneficia da redução de tempo por chamada obtida aqui.
- O achado colateral da Seção 3.9 (pico no último item) — investigado e explicado, mas não corrigido, por
  não ser um problema real (ver conclusão da própria seção).

## 6. Ressalva de processo (ferramenta) — corrupção de encoding e recuperação

Durante a remoção final da instrumentação de diagnóstico (Fase 3 de `tasks.md`), a ferramenta de edição de
texto genérica (`Edit`) foi usada por engano num dos passos, em vez de Python com encoding explícito. Como o
arquivo é cp1252 (Windows-1252) e a ferramenta resalva o arquivo inteiro em UTF-8, isso corrompeu a acentuação
de **todo o arquivo** — 171 ocorrências de replacement character (`\xef\xbf\xbd`), não só o trecho editado.

Detectado imediatamente por checagem de bytes de corrupção logo após a edição, antes de qualquer outra
alteração. Recuperação, seguindo o protocolo do projeto para este tipo de incidente:

1. `svn cat -r BASE untLotePrecos.pas` (revisão 494230) — trouxe a revisão limpa do SVN.
2. Reconstrução completa do arquivo em cima dessa base limpa, num único script Python, reaplicando **as 4
   alterações pretendidas** (o fix de `TfrmGravando`/`Application.ProcessMessages` do Req. 460063 — que
   também é uma alteração local não commitada nesta working copy — mais as Notas 1, 2 e 3 deste requisito),
   sem tentar consertar manualmente os bytes já corrompidos (irrecuperáveis).
3. `svn diff` conferido depois, mostrando **exatamente e só** essas 4 mudanças, sem ruído de encoding
   remanescente (199 linhas de diff, 102 adições, 22 remoções, distribuídas nos pontos esperados).

Nenhuma alteração foi perdida — todas eram conhecidas e haviam sido documentadas/validadas antes do
incidente, permitindo reconstrução fiel. Lição registrada: mesmo com dezenas de edições bem-sucedidas via
Python ao longo de uma sessão longa, um único uso indevido da ferramenta `Edit` genérica é suficiente para
corromper o arquivo inteiro — a checagem de corrupção deve ser feita a cada edição, não só ao final.

## 7. Testes

Sem suite DUnit cobrindo este fluxo (`TLotePrecos`/tela de ativação de lote de preços). Validação realizada:

- Instrumentação de diagnóstico comparando tempo por item/bloco em rodadas sucessivas (antes/depois de cada
  correção), com o mesmo lote de 269 itens em 2 tabelas de preço (`MARBR1`, `MARBR4`) — Seções 3.1 a 3.7.
- Teste funcional do usuário no cenário original do cliente (Moto Mais, NF com alteração nas 4 tabelas de
  preço, Zendesk 1655410), após compilação com as 3 correções e sem nenhuma instrumentação de diagnóstico
  restante — **resultado: testado OK**, sem travamento/"não responde"/fechamento do AutCom, com valores de
  preço/margem calculados idênticos aos obtidos antes da correção.

## 8. Notas Referenciadas no Código-Fonte

### Nota 1

**Arquivo/Unit:** `padra_atualizado/fontes/movimentacaoitens/untLotePrecos.pas`
**Função:** `TLotePrecos.pAlterarPrecoMargem`, bloco `Finally`

**Explicação completa:** ver Seções 3.1, 3.2 e 4.1 acima. Resumo: a chamada explícita de `pSetCDSGrids` no
`Finally` de `pAlterarPrecoMargem` era redundante com a chamada interna já feita por `pAtualizaCdsPrecos`
(invocada na linha imediatamente anterior, dentro do mesmo `Finally`). Confirmado via `svn blame`/`svn diff`
de revisão (r207442, Req. 141958) que ambas as chamadas nasceram no mesmo commit, junto com a própria feature
de exibição em múltiplos grids — duplicação por descuido de criação, não correção deliberada posterior.
Consumia ~47% do tempo total de `pAlterarPrecoMargem` por item antes da remoção.

**Por que uma revisão futura não deve reintroduzir essa chamada "por segurança":** `pAtualizaCdsPrecos`
sempre chama `pSetCDSGrids` internamente ao final de seu próprio corpo (`With FCdsPrecos Do Begin ... First;
pSetCDSGrids; EnableControls; ... End`) — reintroduzir a chamada explícita voltaria a executar a mesma rotina
duas vezes por item, reintroduzindo o custo de ~47% eliminado por esta correção, sem nenhum ganho funcional
(o resultado final da exibição é idêntico com uma ou duas chamadas).

### Nota 2

**Arquivo/Unit:** `padra_atualizado/fontes/movimentacaoitens/untLotePrecos.pas`
**Função:** `TLotePrecos.pSetCDSGrids`

**Explicação completa:** ver Seções 3.5, 3.6 e 4.2 acima. Resumo: os três datasets `FCdsPrecos1`/
`FCdsPrecos2`/`FCdsPrecos3` são ligados, via `TDataSource` (`dtsPrecos`/`dtsPrecos2`/`dtsPrecos3`, em
`untLotePrecosEfetivacaoCx.pas`), aos três grids visíveis (`TDBGridCitel`) na tela de ativação de lote de
preços. Antes desta correção, cada reatribuição de `.Data`/`.Filter`/`.Filtered`/`.IndexFieldNames` disparava
um repaint completo desses três grids, a cada chamada de `pSetCDSGrids` — chamada uma vez por item
processado. `DisableControls`/`EnableControls` ao redor de cada bloco reduziu o tempo médio dessas
reatribuições entre 30% e 40% nas medições realizadas (não eliminou o crescimento progressivo entre itens —
essa parte foi resolvida pela Nota 3).

**Por que uma revisão futura não deve remover esses `DisableControls`/`EnableControls` achando
desnecessários:** embora o ganho medido seja menor que o da Nota 3, ele é real e mensurável (30-40% de
redução no custo desses blocos especificamente); removê-los reintroduziria repaints desnecessários dos 3
grids a cada item processado em lote.

### Nota 3

**Arquivo/Unit:** `padra_atualizado/fontes/movimentacaoitens/untLotePrecos.pas`
**Função:** `TLotePrecos.pCriaCdsPrecos`

**Explicação completa:** ver Seções 3.7 e 3.8 acima (causa raiz e verificação de segurança ampliada). Resumo:
`FCdsPrecos` é um `TUniClientDataSet` 100% em memória (`CreateDataSet`), nunca gravado via
`ApplyUpdates`/`CancelUpdates`/`Delta`/`RevertRecord` em nenhum ponto de todo o projeto (confirmado por busca
em `padra_atualizado/fontes/` inteiro, não só nesta unit). Por padrão, esses datasets mantêm `LogChanges :=
True`, registrando cada `Edit`/`Post` num changelog interno usado para suportar esses recursos. Como este
dataset nunca os usa, o changelog só crescia indefinidamente a cada `Post` ao longo da sessão, tornando cada
novo `Post` progressivamente mais lento sem nenhum benefício. Esta foi a causa raiz do crescimento
progressivo de tempo relatado pelo cliente ("de tabela para tabela, a demora vai aumentando").

**Por que uma revisão futura não deve reverter isso achando que "changelog desligado é sempre arriscado":**
o risco natural de desligar `LogChanges` é impedir `ApplyUpdates`/`CancelUpdates`/`RevertRecord` de
funcionarem corretamente — mas isso só importa se algum código realmente chamar esses métodos sobre este
dataset. Foi confirmado, por busca em **todo** o código-fonte do projeto (não só na unit alterada), que
nenhum ponto do sistema faz isso, nem depende de `Modified`/`ChangeCount`/`UpdateStatus` sobre
`FCdsPrecos`/`cdsPrecos1/2/3` — apenas 2 arquivos em todo o projeto referenciam esses datasets, e o único uso
fora da própria criação é vínculo a `TDataSource` para exibição em grid. O dataset que efetivamente grava no
banco (`Dataset`/`cdsConsulta`, os itens de fato) não foi tocado e mantém seu `LogChanges` original. Uma
reversão desta correção sem antes confirmar que essa análise ainda é válida (por exemplo, se uma alteração
futura passar a chamar `ApplyUpdates` sobre `FCdsPrecos` por algum motivo novo) reintroduziria a lentidão
progressiva original.

## 9. Referências cruzadas

- `spec.md`/`plan.md`/`tasks.md` (mesma pasta) — artefatos formais de análise/plano/tarefas deste requisito,
  gerados via skill `citel-IAArquitectDesenv` nesta mesma sessão, com Fases 1 a 4 já concluídas (Fase 5 —
  `/citel-aprovaRequisito`, gate DelphAI, commit — pendente, a critério do usuário).
- Req. 460063 (`IA/specs/460063/`) — correção anterior, mesma classe `TLotePrecos`, que introduziu
  `TfrmGravando`/`Application.ProcessMessages` para o sintoma de tela "não responde" durante replicação em
  massa; permanece intacta e é pré-requisito funcional para esta correção.
