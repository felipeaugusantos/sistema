# Análise de Requisito — Req. 459132

**Título:** Endereçamento de entrada gravando quantidade duplicada na Transferência entre Armazéns (TA), gerando
saldo negativo no lote "A DEFINIR"
**Solicitante:** Misael Lobo dos Santos da Silva — loja SMF FERRAMENTAS LJ 001 (empresa 001, base AUTCOM)
**Executável no chamado:** 379.48.02.30 (04/08/2026)
**Data da análise/implementação:** 2026-09-01

## 1. Contexto de negócio

A rotina de **endereçamento de entrada** (`untEntEnderecamentoProduto.pas` / `untEnderecamentoArmazem.pas` /
`untTransferenciaArmazens.pas`) é responsável por, após a conferência de uma nota fiscal de entrada, gerar uma
movimentação do tipo **Transferência entre Armazéns (TA)**, movendo a mercadoria do lote provisório "A DEFINIR"
para o lote/armazém físico definitivo escolhido pelo usuário.

Existe uma auditoria periódica que compara o saldo do lote "A DEFINIR" e aponta divergência quando esse saldo
fica negativo — sinal de que foi endereçada mais quantidade do que a que efetivamente entrou pela nota fiscal.

Duas configurações do sistema (`CFGSIS`) influenciam esse fluxo e são centrais nesta análise:

- **`CFG_COFEND`** — permite, na Conferência de Entrada, liberar itens já conferidos para a etapa de
  Endereçamento mantendo a conferência em aberto (fluxo de "conferência digital").
- **`CFG_TIPPNT`** — define se a empresa opera em conferência "depois da entrada" (valor `D`), isto é, o
  documento entra no sistema e o endereçamento físico definitivo do lote é feito depois.
- **`CFG_UDEVME`** — habilita o processo de Devolução de Mercadorias/Pré-nota quando a conferência indica
  divergência e a empresa não usa WMS.

Quando `CFG_COFEND='S'` **e** `CFG_TIPPNT='D'` (ou `CFG_UDEVME='S'`), o cálculo da quantidade a endereçar de
cada item passa a depender do registro de **conferência digital** (`DIGCON`), em vez de depender apenas da
quantidade do próprio pedido de reserva de estoque.

## 2. Problema e causa raiz

### 2.1 Sintoma relatado

A auditoria de saldo do lote "A DEFINIR" acusou saldo negativo. Na investigação, identificou-se que, no
endereçamento da NF `000000009771-NF-001` (empresa 001, CLAFIS `2102`), o item `07888` — quantidade `217,0000`
na nota — foi gravado na TA gerada (`000000010981`) com quantidade **`434,0000`**, exatamente o dobro. O mesmo
padrão de duplicação (quantidade gravada = 2× a quantidade correta) ocorreu nos **7 itens** do mesmo documento,
não apenas no item `07888`.

### 2.2 Investigação de causa raiz

**Descartado: geração duplicada da TA.** A hipótese inicial de que a rotina de geração da TA teria rodado duas
vezes foi descartada com evidência de log: na tabela de replicação (`LOGREP_ARQUIV_20260829`), filtrando pela
mesma transação (`LOG_CON_ID`/`LOG_IDTRAN`) do documento, `MOVGER` foi inserido **1 vez** e `MOVDET` **14 vezes**
— exatamente o esperado para 7 itens × 2 linhas (saída + entrada) de uma **única** geração de TA. Ou seja, a
quantidade **já chegava duplicada** na única execução, não é o processo rodando em duplicidade.

**Falha de defesa identificada e corrigida nesta sessão:** a validação `TTransferenciaArmazens.pValQtdEnderecada`
(chamada dentro de `fGeraTransferencia`, antes da TA ser efetivamente gravada) existe justamente para comparar
a quantidade já endereçada contra a quantidade pendente do pedido de reserva de estoque vinculado, e abortar a
gravação (com rollback) se houver divergência. Essa validação **não disparou** porque a quantidade do lado do
pedido era somada de forma bruta (`FDO_QTDITE`, quantidade total solicitada), **sem subtrair `FDO_QTDBAI`**
(quantidade já baixada do pedido) — ou seja, comparava "quanto já foi endereçado" contra "quanto o pedido pede
no total", não contra "quanto ainda falta endereçar agora". Essa é a causa raiz acionável, corrigida nesta
sessão.

**Configuração mal identificada na verificação inicial do chamado.** O e-mail do chamado verificou
`CFG_CONEND` e `CFG_UDEVME` (ambas `N`), concluindo que o fluxo de "conferência digital" estaria desligado. Só
que o código que efetivamente altera o cálculo da quantidade a endereçar usa a flag `blnCofEnd`
(`untEntEnderecamentoProduto.pas:557`), lida de **`CFG_COFEND`** — configuração diferente de `CFG_CONEND`,
apesar do nome parecido — combinada com `CFG_TIPPNT='D'`. Confirmado no banco de produção (leitura): para a
empresa 001, `CFG_COFEND='S'` e `CFG_TIPPNT='D'`. Ou seja, **esse fluxo está ativo** na loja, ao contrário do
que a checagem inicial concluiu.

**Origem exata da duplicação em `DIGCON.DIC_QTDITE` — não confirmada com 100% de certeza (fora de escopo desta
correção).** Com `CFG_COFEND` ativa, a quantidade a endereçar de cada linha passa a ser calculada como
`IFNULL(DIC_QTDITE, 0) + IFNULL(DIC_QTDLDE, 0) - @ITE_QTDEND_1` (`untEnderecamentoProduto.pas:2207`), em vez de
`FDO_QTDITE - FDO_QTDBAI`. O registro de `DIGCON` do item `07888` já apresentava `DIC_QTDTOT=217` (correto) mas
`DIC_QTDITE=DIC_QTDEND=434` (duplicado) **antes** da geração da TA — a duplicação entra pelo `DIGCON`, e só se
propaga para a gravação de endereçamento porque `CFG_COFEND` está ativa nessa loja. Não há triggers no banco
(`DEL_FATDOR`, `FATDOR`, `MOVDET`, `DIGCON` sem triggers) que expliquem a duplicação. O candidato mais forte
identificado — não confirmado — é `TEnderecamentoConferenciaParcial.Processa`
(`untTEnderecamentoConferenciaParcial.pas:306`), que dispara **duas threads concorrentes sem qualquer
sincronização** sobre `TUniQuery`s ligadas à mesma conexão de banco, com espera em busy-wait
(`while not X do;`, sem yield) — um padrão de risco real para leitura/gravação não determinística, mas cuja
confirmação exigiria reprodução instrumentada em ambiente de teste, não coberta nesta sessão.

### 2.3 Evidência coletada (banco de produção AUTCOM, consulta somente leitura)

| Fonte | Campo | Valor observado |
|---|---|---|
| `MOVDET` (NF `000000009771`, item `07888`) | `DET_QTDITE` | `217,0000` |
| `MOVDET` (TA `000000010981`, CLAFIS `5999`, lote `A DEFINIR`) | `DET_QTDITE` | `434,0000` |
| `MOVDET` (TA `000000010981`, CLAFIS `1999`, lote `EXTERNO AMERICO`) | `DET_QTDITE` | `434,0000` |
| `DEL_FATDOR` (pedido de reserva, item `07888`) | `FDO_QTDITE` | `217,0000` |
| `DEL_FATDOR` (pedido de reserva, item `07888`) | `FDO_QTDBAI` | `434,0000` |
| `DIGCON` (item `07888`) | `DIC_QTDTOT` | `217,0000` |
| `DIGCON` (item `07888`) | `DIC_QTDITE` / `DIC_QTDEND` | `434,0000` / `434,0000` |
| `CFGSIS` (empresa 001) | `CFG_COFEND` | `S` |
| `CFGSIS` (empresa 001) | `CFG_TIPPNT` | `D` |
| `CFGSIS` (empresa 001) | `CFG_CONEND` | `N` (checada no chamado, mas não é a config relevante) |
| `CFGSIS` (empresa 001) | `CFG_UDEVME` | `N` |
| `LOGREP_ARQUIV_20260829` (mesma transação) | `MOVGER` inserido | 1x |
| `LOGREP_ARQUIV_20260829` (mesma transação) | `MOVDET` inserido | 14x (7 itens × 2) |
| Triggers em `DEL_FATDOR`/`FATDOR`/`MOVDET`/`DIGCON` | — | Nenhum |

`DEL_FATGOR.FGO_MEN001` (pedido `00100000000589742001`) contém `"PEDIDO DE RESERVA DE ESTOQUE PRE-NOTA
000000009771-NF 6"`, criado às 15:55:14 (mesmo horário da NF) — confirma que o pedido de reserva foi criado por
`TEnderecamentoProduto.fGerarPedidoParaReservarEstoque` (`untEnderecamentoProduto.pas:1506`) no momento da
conferência/pré-nota da entrada, e não durante a geração da TA.

## 3. Investigação realizada

1. Leitura de `TEnderecamentoArmazem.fGeraDocumentoTransfArmazens` → `TTransferenciaArmazens.fGeraTransferencia`
   → `pValQtdEnderecada`, a partir da indicação do usuário no chamado.
2. Conexão ao banco de produção AUTCOM (leitura, `pymysql`, credenciais informadas no chamado) para reproduzir
   as queries de verificação fornecidas pelo solicitante e cruzar com o código.
3. Confirmado, via `LOGREP_ARQUIV_20260829` filtrado por `LOG_CON_ID`/`LOG_IDTRAN`, que a TA foi gerada uma
   única vez (contagem de `MOVGER`/`MOVDET` consistente com geração única) — descartando duplicidade de
   execução como causa.
4. Lida a `DIGCON` do item `07888` e comparado `DIC_QTDTOT` (correto, 217) com `DIC_QTDITE`/`DIC_QTDEND`
   (duplicado, 434) — evidência de que a duplicação entra pela conferência digital, antes da geração da TA.
5. Identificado que o gate real do cálculo alternativo (`blnCofEnd`) depende de `CFG_COFEND` + `CFG_TIPPNT='D'`,
   não de `CFG_CONEND` (config checada no chamado original) — consultado `CFGSIS` no banco para confirmar os
   valores reais na empresa 001.
6. Rastreada a fórmula alternativa de cálculo de quantidade a endereçar (`untEnderecamentoProduto.pas:2203-2210`)
   que passa a depender de `DIGCON.DIC_QTDITE` quando `blnCofEnd` está ativo.
7. Tentativa de localizar a instrução exata que grava `DIC_QTDITE=434` — não confirmada; identificado
   `TEnderecamentoConferenciaParcial.Processa` como candidato mais forte (threads concorrentes sem
   sincronização), mas descartada a continuidade do rastreio por decisão do usuário, em favor de uma correção
   defensiva imediata.
8. Confirmado, via `SHOW TABLES`, que `FATDOR` e `DEL_FATDOR` são tabelas fisicamente distintas — descartando a
   hipótese inicial de que `TEnderecamentoProduto.fGravarQuantidadeParcialEnderecamento` (que grava em
   `FATDOR`) fosse a origem da duplicação em `DEL_FATDOR.FDO_QTDBAI`.
9. Confirmado com o usuário, por leitura direta do código de `pValQtdEnderecada`
   (`untTransferenciaArmazens.pas:2373-2376`), que a validação lê `DEL_FATDOR` (não `FATDOR` plana) — e que o
   `FDO_QTDBAI` duplicado já estava presente em `DEL_FATDOR` no momento em que essa validação rodava.

## 4. Abordagens consideradas e descartadas

- **Continuar rastreando até confirmar 100% a origem exata da duplicação em `DIGCON.DIC_QTDITE`** — descartada
  por decisão do usuário, em favor de uma correção defensiva imediata que resolve o sintoma relatado (saldo
  negativo) independentemente da causa raiz completa ser fechada. A investigação da causa raiz em
  `TEnderecamentoConferenciaParcial` fica registrada como pendência (seção 7).
- **Corrigir a comparação de `pValQtdEnderecada` de forma incondicional** (sempre subtrair `FDO_QTDBAI`) — foi a
  primeira versão implementada, mas **descartada** por decisão do usuário: a mudança incondicional alteraria o
  comportamento da validação em todas as lojas/fluxos, mesmo naqueles onde `CFG_COFEND`/`CFG_UDEVME` nunca
  estiveram em jogo e o cálculo de quantidade nunca dependeu de `DIGCON`. Optou-se por restringir a correção
  exatamente ao cenário que expõe o risco.
- **Reescrever a condição usando `fCfgSis('TIPPNT') = 'D'` diretamente** — substituída, por pedido do usuário,
  pela função padrão do projeto `fConferenciaDepoisDaEntrada` (já usada em ~90 pontos do código, incluindo
  `untEntEnderecamentoProduto.pas`, de onde vem o `blnCofEnd` original), evitando duplicar a mesma regra de
  negócio com uma expressão literal.

## 5. Solução aplicada

Em `TTransferenciaArmazens.pValQtdEnderecada`, a expressão que calcula `QTDAENDERECAR` (quantidade pendente do
pedido de reserva de estoque, usada para comparar contra a quantidade já endereçada) passou a ser condicional:

- **Quando `CFG_COFEND='S'` e `fConferenciaDepoisDaEntrada` (`CFG_TIPPNT='D'`), ou `CFG_UDEVME='S'`** — cenário
  em que a quantidade a endereçar pode ter origem em `DIGCON.DIC_QTDITE` — a quantidade passa a ser calculada
  como `FDO_QTDITE - FDO_QTDBAI` (pendente real), em vez de `FDO_QTDITE` puro (total solicitado).
- **Fora desse cenário**, o cálculo permanece exatamente como era antes (`FDO_QTDITE` puro) — nenhuma mudança de
  comportamento para lojas/fluxos que não usam essa combinação de configuração.

Com isso, quando a quantidade endereçada exceder a quantidade pendente do pedido (como no caso do item
`07888`: `434` endereçado vs. `217-434=-217` pendente), a comparação passa a divergir e a exceção já existente
("Houve inconsistência na gravação da TA...") é disparada, com rollback — a TA deixa de ser gravada com
quantidade incorreta.

### Arquivos alterados (mesmo diff aplicado em todas as cópias)

| Working copy | Status |
|---|---|
| `379.48.2.30.74.150.45` (origem da correção) | Alterado |
| `379.48.2.30.74.150` | Alterado (mesmo diff, texto do trecho conferido antes de editar) |
| `379.48.2.30.74.150.100` | Alterado (mesmo diff, texto do trecho conferido antes de editar) |

Em todas: `padra_atualizado/fontes/movimentacaoitens/untTransferenciaArmazens.pas`,
`TTransferenciaArmazens.fGeraTransferencia` → procedure aninhada `pValQtdEnderecada`:

1. Adicionada variável local `strExprQTDAEnderecar: String`.
2. Antes do `qryPedidoEnderecamento.SQL.Add(...)` que monta a expressão `QTDAENDERECAR`, adicionado bloco
   condicional que monta a string da expressão SQL (com ou sem subtração de `FDO_QTDBAI`) conforme
   `(fCfgSis('COFEND', varBoolean) And fConferenciaDepoisDaEntrada) Or fCfgSis('UDEVME', varBoolean)`.
3. O `SQL.Add` passou a usar a variável montada (`strExprQTDAEnderecar`) em vez do literal fixo.

Cada arquivo foi editado via Python (`io.open(..., encoding='cp1252', newline='')`), nunca pela ferramenta de
edição de texto genérica, e validado após cada gravação (decodifica sem erro em cp1252, sem marcador de
corrupção `\xef\xbf\xbd`). Antes de editar `74.150` e `74.150.100`, o trecho de `pValQtdEnderecada` foi conferido
como idêntico ao estado original (não alterado previamente) em cada cópia.

### Validação pós-implementação

Validação por revisão de lógica, sem simulação em ambiente de homologação:

- Reproduzido manualmente o cálculo com os valores reais do item `07888` (`FDO_QTDITE=217`,
  `FDO_QTDBAI=434`, quantidade já endereçada `=434`): com a correção, `QTDAENDERECAR = 217 - 434 = -217`,
  que diverge de `434` → exceção disparada, rollback — comportamento correto.
- Confirmado que, fora do cenário `CFG_COFEND`+`CFG_TIPPNT='D'`/`CFG_UDEVME`, a expressão permanece idêntica à
  original (`SUM(IFNULL(FDO_QTDITE, 0))`) — sem risco de regressão em fluxos não afetados por esta causa raiz.
- Não foi possível confirmar, dentro desta sessão, se a expressão `434 <> -217` seria exatamente o par de
  valores avaliado no instante original do incidente (a ordem exata de execução entre a validação e o
  incremento de `FDO_QTDBAI` dentro da mesma transação não foi 100% rastreada) — mas qualquer valor real que
  `FDO_QTDBAI` tivesse nesse momento (0, 217 ou 434) resultaria em divergência contra a quantidade já
  endereçada (434), disparando a exceção em qualquer um dos cenários.

## 6. Decisões de escopo

**Incluído:** ajuste condicional em `pValQtdEnderecada`, aplicado nas três working copies listadas.

**Excluído deliberadamente** (decisões explícitas do usuário):

- **Encontrar e corrigir a causa raiz exata da duplicação de `DIGCON.DIC_QTDITE`** — candidato mais provável
  (`TEnderecamentoConferenciaParcial.Processa`, threads sem sincronização) não confirmado; requer reprodução
  instrumentada/log em ambiente de teste do cliente, fora do escopo desta sessão.
- **Correção da configuração `CFG_CONEND` vs. `CFG_COFEND`** mal identificada na checagem inicial do chamado —
  é uma correção de diagnóstico/processo, não de código.
- **Reprocessamento/estorno dos dados já gravados incorretamente** para a NF `000000009771` / TA
  `000000010981` — ação operacional, a cargo do time de suporte/negócio.
- **Simulação/reprodução em ambiente de homologação** — validação feita por revisão de lógica, sem reproduzir o
  cenário em ambiente real.

## 7. Achados colaterais (fora de escopo, registrados para não serem esquecidos)

1. **`TEnderecamentoConferenciaParcial.Processa`** (`untTEnderecamentoConferenciaParcial.pas:306`) dispara duas
   threads concorrentes (`TThread.CreateAnonymousThread`) sem qualquer sincronização, operando sobre
   `TUniQuery`s ligadas à mesma conexão de banco, e aguarda o término com busy-wait
   (`while Not (blnTerminouDocumento) do;`, sem `Sleep`/yield). Esse é um padrão de risco de concorrência real,
   independentemente de ser ou não a causa raiz confirmada deste chamado — recomenda-se avaliação futura
   dedicada (sincronização adequada, ex. `TEvent`/`TMonitor`, e substituição do busy-wait).
2. **`pValQuantidade`** (mesma unit, também dentro de `fGeraTransferencia`) compara `FDO_QTDITE` bruto de
   `MOVDET` (entrada vs. saída dentro do próprio documento da TA) — esse ponto **não** foi alterado, pois seu
   contexto de comparação é diferente (não envolve `FDO_QTDBAI` de pedido de reserva) e está fora do escopo
   desta causa raiz.
3. **Configuração `CFG_CONEND` mal identificada na checagem inicial** do chamado — recomenda-se alinhar com o
   solicitante (Misael) a diferença entre `CFG_CONEND` (checada, desligada) e `CFG_COFEND` (não checada,
   ligada), para evitar o mesmo engano em chamados futuros envolvendo esse fluxo.

## 8. Ressalvas e lições

- **Arquivo `.pas` em encoding legado (cp1252/Latin-1):** todas as edições foram feitas via Python
  (`io.open(..., encoding='cp1252', newline='')`), nunca pela ferramenta de edição de texto genérica — que
  resalva o arquivo inteiro e corrompe acentuação em arquivos de encoding não-UTF-8. Cada gravação foi validada
  decodificando o arquivo de volta e conferindo a ausência do marcador de corrupção (`\xef\xbf\xbd`).
- **Investigação de causa raiz em subsistema genérico compartilhado:** `DEL_FATGOR`/`DEL_FATDOR`/`DEL_EXTGOR`
  são um "clone" de `FATGOR`/`FATDOR`/`EXTGOR` usado por ~34 arquivos diferentes como mecanismo genérico de
  reserva de estoque, com o nome da tabela escolhido dinamicamente em runtime em alguns pontos
  (`untFuncoesGenerica.pas:7663` trata `'FATGOR'`/`'DEL_FATGOR'` como par intercambiável). Isso tornou inviável,
  dentro do tempo desta sessão, localizar por análise estática pura a instrução exata que incrementa
  `DEL_FATDOR.FDO_QTDBAI` — ficou registrado como investigação futura (achado colateral 1).
- **Correção condicional em vez de incondicional:** a primeira versão da correção subtraía `FDO_QTDBAI`
  incondicionalmente. Reavaliada e restringida para só se aplicar quando `CFG_COFEND`+`CFG_TIPPNT='D'` (ou
  `CFG_UDEVME`) estiverem ativos, minimizando o raio de impacto da mudança ao cenário que efetivamente expõe o
  risco (decisão do usuário).
- **Reutilizar função de negócio existente em vez de replicar a config literal:** `fCfgSis('TIPPNT') = 'D'` foi
  substituído por `fConferenciaDepoisDaEntrada` (`untFuncoesGenerica.pas:2662`), já usada amplamente no projeto
  para essa mesma checagem — evita duplicar a regra de negócio como literal espalhado pelo código.

## 9. Notas Referenciadas no Código-Fonte

### Nota 1

**Arquivo/Unit:** `padra_atualizado/fontes/movimentacaoitens/untTransferenciaArmazens.pas`
**Função:** `TTransferenciaArmazens.fGeraTransferencia`, procedure aninhada `pValQtdEnderecada`.

**Explicação completa:** essa validação compara a quantidade já endereçada de um item (calculada a partir de
`MOVDET`/TAs relacionadas) contra a quantidade a endereçar do pedido de reserva de estoque vinculado
(`DEL_FATDOR`), para decidir se a TA pode ser gravada. Até esta correção, o lado do pedido somava `FDO_QTDITE`
puro (a quantidade *total* solicitada no pedido), nunca subtraindo `FDO_QTDBAI` (quantidade já baixada) — ou
seja, comparava "quanto já foi endereçado" contra "quanto o pedido pede no total", não contra "quanto ainda
falta endereçar agora".

Isso é uma falha de defesa: quando a empresa opera com `CFG_COFEND='S'` e `CFG_TIPPNT='D'` (ou `CFG_UDEVME='S'`),
o cálculo da quantidade a endereçar de cada item passa a depender de `DIGCON.DIC_QTDITE`
(`untEnderecamentoProduto.pas:2207`) em vez de depender só do pedido — e, em um caso real investigado (Req.
459132), esse campo apareceu duplicado (434 em vez de 217), fazendo a TA ser gravada com o dobro da quantidade
da nota fiscal de entrada e gerando saldo negativo no lote "A DEFINIR". Como a comparação usava `FDO_QTDITE`
puro (que não decresce à medida que o pedido é atendido), ela não capturava esse tipo de divergência.

A correção restringe a subtração de `FDO_QTDBAI` exatamente ao cenário `CFG_COFEND`+`CFG_TIPPNT='D'`/
`CFG_UDEVME` — fora dele, o comportamento é idêntico ao original.

**Por que isso não é óbvio e por que uma revisão futura não deve remover a subtração de `FDO_QTDBAI` nem
tornar a comparação incondicional sem entender o contexto:** a query já compara contra `FDO_QTDITE` em outros
pontos do mesmo arquivo sem essa subtração (ex.: `pValQuantidade`, que valida entrada vs. saída dentro do
próprio documento da TA — contexto onde a subtração não se aplica, pois não envolve o pedido de reserva). A
ausência da subtração especificamente em `pValQtdEnderecada`, no cenário `CFG_COFEND` ativo, foi a causa raiz
confirmada da falha de detecção no Req. 459132. Tornar a subtração incondicional (aplicá-la sempre, mesmo fora
desse cenário) foi deliberadamente evitado, pois alteraria o comportamento de validação em lojas/fluxos onde
essa combinação de configuração nunca esteve em jogo — mudança de escopo maior do que o necessário para
resolver o defeito relatado. A causa raiz completa (por que `DIGCON.DIC_QTDITE` duplica) permanece em aberto —
ver seção "Achados colaterais" no arquivo de análise (`IA/specs/459132/validacaoDivergenciaEnderecamento_Req459132.md`).
