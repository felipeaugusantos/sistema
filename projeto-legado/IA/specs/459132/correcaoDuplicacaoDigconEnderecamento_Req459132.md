# Correção — Duplicação de quantidade em DIGCON e trava de endereçamento inerte (Req. 459132)

**Escopo:** causa raiz da duplicação de quantidade em `DIGCON.DIC_QTDITE` (origem do saldo negativo
no lote "A DEFINIR") e a correção da trava `pValQtdEnderecada`, que deveria ter impedido a
propagação dessa duplicação para a Transferência entre Armazéns (TA) e não impedia. Independente e
complementar à mudança já documentada em `otimizacaoLocateFgoDocend_Req459132.md` (Nota 1, troca de
`LOCATE` por igualdade em `FGO_DOCEND`, mesma procedure).

**Zona:** Legado (`padra_atualizado/fontes/genericos/`, `padra_atualizado/fontes/movimentacaoitens/`).

**Data:** 2026-09-03.

---

## 1. Contexto de negócio

O processo de entrada de mercadoria neste ERP passa por três etapas principais antes de o produto
ficar disponível fisicamente no depósito:

1. **Conferência da pré-nota** (`TfrmEntConferPreNota`): o usuário confere item a item a quantidade
   fisicamente recebida contra o pedido de compra/documento fiscal. Se o usuário **não conferir**
   algum item mas mesmo assim precisar liberar o documento (por trava/senha), o sistema grava o
   detalhe da conferência (`DIGCON`) e segue o fluxo.
2. **Efetivação fiscal da entrada** (`untEfetivaMovimentoFiscal.pas`): reprocessa a conferência para
   o documento fiscal definitivo, e é aqui que — no cenário do item 1 — o sistema detecta que o
   `DIGCON` gravado ficou inconsistente e tenta corrigi-lo automaticamente.
3. **Endereçamento do produto** (`TfrmEntEnderecamentoProduto`): distribui a quantidade recebida
   entre os endereços físicos (lotes) do depósito, gerando uma TA (Transferência entre Armazéns) do
   lote "A DEFINIR" para o lote físico definitivo.

O requisito relatava saldo negativo no lote "A DEFINIR" após o endereçamento — sintoma de que a TA
estava sendo gerada com quantidade maior do que a realmente recebida.

## 2. Causa raiz confirmada — duplicação em `DIGCON.DIC_QTDITE`

### 2.1 O que acontece na liberação sem conferência (etapa 1)

Ao liberar a pré-nota sem conferir nenhum item, `TDistribuicaoConferencia.fFinalizaConferencia`
(`untTDistribuicaoConferencia.pas`) grava, para cada item do documento, um registro em `DIGCON` com
a quantidade **cheia do pedido** (não a quantidade realmente conferida — comportamento à parte, já
descrito em `investigacao_historico_Req459132.md`, Passo 1) e `DIC_SEQDOR = ''` (vazio), porque
nesse momento o `FATDOR` (linha do pedido de reserva de estoque) **ainda não existe** — só é gerado
em uma etapa posterior do mesmo pipeline.

### 2.2 O que acontece na efetivação fiscal (etapa 2) — a duplicação

Minutos depois, `TEfetivaMovimentoFiscal` detecta (via
`TEnderecamentoConferenciaParcial.ConferenciaSemDigConCorretaPorDigEle`) que o `DIGCON` gravado na
etapa 1 está inconsistente, e reprocessa a conferência criando uma **nova instância** de
`TDistribuicaoConferencia` (`TDistribuicaoConferenciaFactory.CriarPorIDeDig`). Essa nova instância
recarrega os itens do zero e tenta restaurar, para cada item, "quanto já foi liberado
anteriormente" via `AdicionarConferenciaAnterior`, casando por `CodItem + SeqFatDor` — mas, neste
momento, o `FATDOR` **já existe** (foi criado entre as etapas 1 e 2), então `SeqFatDor` já vem
preenchido e **não bate mais** com o `SeqFatDor=''` lido de volta do `DIGCON` gravado na etapa 1. O
casamento falha silenciosamente, `QuantidadeLiberadaEnderecamento` fica em `0` (nunca é restaurada),
e o sistema recalcula a quantidade "do zero" — 100% do pedido novamente — que é então **somada**
(não substituída) ao valor já existente via
`UPDATE DIGCON SET DIC_QTDITE = DIC_QTDITE + :qtd`. Resultado: `DIC_QTDITE` fica em **dobro** do
`DIC_QTDTOT` (quantidade real do pedido) — confirmado em produção, ex.: item `07888`, pedido `217`,
gravado `434`.

Essa causa raiz é **determinística** (ocorre toda vez que a condição de gatilho se repete: liberar
sem conferir + `TEnderecamentoConferenciaParcial` detectar e reprocessar), e não a condição de
corrida entre threads que o `spec.md` original registrava como hipótese não confirmada — descartada
nesta investigação com evidência de `LOGREP` (duas transações sequenciais e determinísticas, não
concorrentes) e leitura de código.

### 2.3 Correção aplicada

`padra_atualizado/fontes/genericos/untTDistribuicaoConferencia.pas`:

1. **`AdicionarConferenciaAnterior`** — casamento trocado de `CodItem + SeqFatDor` para
   `CodItem + SeqMovDet`. `SeqMovDet` (o item de movimento de estoque, `MOVDET`) é estável desde a
   primeira gravação — ao contrário de `SeqFatDor`, nunca fica vazio nem muda de valor entre as
   duas etapas.
2. **`CarregarDadosDigCon`** — o filtro para localizar o `DIGCON` já gravado também usava uma chave
   instável (`DIC_SEQGER`, vazio pelo mesmo motivo que `DIC_SEQDOR`). Trocado para filtrar por
   `DIC_IDEDIG` (identificador da digitação de conferência, estável desde a primeira gravação) +
   `DIC_CODEMP`.
3. **`AtualizaDigCon` / `FQryUpdateDigCon`** — trava de segurança complementar:
   `DIC_QTDITE = LEAST(IFNULL(DIC_QTDITE, 0) + :DIC_QTDITE, :DIC_QTDTOT)`, garantindo que, mesmo que
   algum outro caminho ainda não mapeado some quantidade indevidamente, `DIC_QTDITE` nunca ultrapasse
   `DIC_QTDTOT` (a quantidade real do pedido).

## 3. Segunda falha — a trava de endereçamento não acusava a divergência

Mesmo com o `DIGCON` duplicado, o requisito original já previa uma trava defensiva em
`TTransferenciaArmazens.fGeraTransferencia` (procedure aninhada `pValQtdEnderecada`,
`untTransferenciaArmazens.pas`) que deveria comparar a quantidade a endereçar contra a quantidade
pendente do pedido de reserva de estoque e abortar a gravação da TA em caso de divergência. Essa
trava **não disparava** — investigação encontrou dois problemas independentes.

### 3.1 A trava só enxergava o pedido arquivado, não o vivo

A trava lê o pedido de reserva de estoque exclusivamente das tabelas de **histórico**
(`DEL_FATGOR`/`DEL_EXTGOR`/`DEL_FATDOR`/`DEL_EXTDOR`), que só são populadas quando o pedido é
totalmente processado e arquivado (via `fVerificaIntegridade`, em
`TEnderecamentoProduto.fApagaPedidoReservaEstoque`). Só que, em
`TfrmEntEnderecamentoProduto.btnConfirmaClick`, esse arquivamento é **pulado deliberadamente**
quando a configuração de conferência de entrada está ativa:

```pascal
If (Not blnCofEnd) and (Not blnUDEVME) then
  blnSalvar := blnSalvar And objEnderecamento.fApagaPedidoReservaEstoque;
```

Com `CFG_COFEND='S'` (ambiente confirmado desta base), essa condição nunca é satisfeita — o pedido
de reserva permanece nas tabelas **vivas** (`FATGOR`/`EXTGOR`/`FATDOR`/`EXTDOR`) no momento em que a
trava roda, e a trava, só enxergando as tabelas arquivadas, nunca encontra nada para comparar — a
comparação de quantidade simplesmente não acontece, e nenhuma exceção é levantada, mesmo com a TA
sendo gravada com o dobro da quantidade.

### 3.2 A trava comparava contra o total bruto, não contra o pendente

Já era sabido (planejado em `tasks.md`/`spec.md`, antes desta sessão) que a fórmula de
`QTDAENDERECAR` deveria subtrair `FDO_QTDBAI` (quantidade já baixada do pedido), comparando contra
o **pendente** real em vez do total bruto do pedido — mas essa correção, isolada, não teria efeito
neste ambiente, porque o problema do item 3.1 já impedia a query de encontrar qualquer dado.

### 3.3 Correção aplicada

`padra_atualizado/fontes/movimentacaoitens/untTransferenciaArmazens.pas`, `pValQtdEnderecada`:

1. Resolvidos localmente `blnCofEndLocal`/`blnUDEVMELocal` (mesma fórmula usada em
   `TfrmEntEnderecamentoProduto`), já que a classe não carregava esses flags.
2. **1ª query (existência do pedido):** adicionado `UNION ALL` contra as tabelas **vivas**
   (`FATGOR`/`EXTGOR`), condicionado a `blnCofEndLocal or blnUDEVMELocal` — agora a trava encontra o
   pedido tanto arquivado quanto ainda vivo.
3. **2ª query (soma `FDO_QTDITE`):** mesmo `UNION ALL` contra `EXTGOR`/`FATDOR`/`EXTDOR` vivos (sem
   isso, os `AUTOINCREM` de `FATGOR` vivo trazidos pela 1ª query não encontrariam nada no `JOIN`
   desta 2ª, que só olhava as tabelas arquivadas).
4. **`SUM(...) AS QTDAENDERECAR` condicional:** em ambientes `CFG_COFEND`/`CFG_UDEVME`, passa a
   comparar contra `FDO_QTDITE - FDO_QTDBAI` (pendente real) em vez do total bruto — retomando,
   agora efetivamente, a correção que a Fase 2 de `tasks.md` já previa.
5. **Bug encontrado durante a implementação e corrigido antes de aplicar:** com os dois `UNION ALL`
   acima, se um pedido estivesse **parcialmente** arquivado (alguns itens já em `DEL_*`, outros
   ainda vivos), cada ramo faz seu próprio `GROUP BY FDO_CODITE` e o `UNION ALL` geraria **2 linhas**
   para o mesmo item — o consumo (`Locate`, que só acha a primeira linha) perderia a quantidade da
   outra parte. Corrigido envolvendo a query inteira numa camada externa que soma de novo por
   `CODITEPEDIDO` (mesmo padrão já usado por `qryQtdEnderecada`, algumas linhas acima na mesma
   procedure).
6. Removidas 6 linhas `SUBSTRING(FGO_DOCEND, N, M) = :XXXX` da 2ª query (e os parâmetros
   correspondentes) — redundantes, já que `FGO_SEQFGO IN (strDocEndIn)` sozinho já restringe às
   linhas cujo `FGO_DOCEND` bateu exatamente com o documento na 1ª query.

`padra_atualizado/fontes/movimentacaoitens/untEntEnderecamentoProduto.pas`,
`TfrmEntEnderecamentoProduto.btnConfirmaClick`:

7. Incluído `blnSalvar` no `If` que grava `FATEND`/quantidade parcial
   (`If blnSalvar And (blnCofEnd or blnUDEVME) Then ...`) — sem isso, mesmo com a trava (item 3.3.4)
   abortando a TA, esse bloco ainda gravaria a quantidade duplicada em `FATEND`/`FATDOR.FDO_QTDBAI`
   antes do `fRollBack` da transação.

## 4. Validação end-to-end com caso real

Reproduzido o cenário do requisito na tela de Endereçamento do Produto — NF `000000009771`, série
6, fornecedor `00000847`, item `07888` (pedido real = 217, grid mostrando quantidade duplicada =
434, o mesmo padrão histórico do requisito). Ao confirmar (F10), a trava disparou corretamente:

```
Erro: Houve inconsistência na gravação da TA. Entre em contato com a Citel.
Quantidade Registros Endereçados: = 434,0000
Quantidade Registros A Endereçar: = 217,0000
Código Item: = 07888
```

A TA deixou de ser gravada com a quantidade duplicada — a trava bloqueou a inconsistência em vez de
deixá-la passar silenciosamente.

## 5. Hipóteses testadas e descartadas durante a investigação

- **Condição de corrida entre threads** (`TEnderecamentoConferenciaParcial.Processa`) — hipótese
  original do `spec.md`, "não confirmada". Descartada: a duplicação é determinística, reproduzida
  de forma independente em outro documento (NF `000000009881`), e o `LOGREP` mostra duas
  transações **sequenciais**, não concorrentes.
- **Pedido de reserva "nunca gerado"** para a NF do requisito — hipótese inicial (Passo 5 da
  investigação), baseada em `DEL_FATGOR`/`DEL_EXTGOR` retornando 0 linhas. Corrigida (com a ajuda do
  usuário): `DEL_*` são tabelas de **arquivo**, populadas só quando o pedido é totalmente
  processado e removido das tabelas vivas — não uma indicação de que o pedido nunca existiu. A
  investigação seguinte (seção 3.1 acima) mostrou a causa real: em ambientes `CFG_COFEND='S'`, o
  arquivamento nunca chega a acontecer neste ponto do fluxo.
- **`pValQtdEnderecada`'s primeira falha ("434 na tela") era um bug novo em `fAbreConsulta`** —
  investigado um caso (`FATGOR.AUTOINCREM='00100000000589742001'`, NF `000000009881`) que mostrava
  `DIGCON.DIC_QTDITE` duplicado (434 vs `DIC_QTDTOT`=217). Confirmado, via `FATGOR.FGO_DTAENT`
  (2026-08-28) e `DIC_IDEDIG='001422'` (anteriores aos testes desta sessão) e ausência de qualquer
  registro em `LOGREP` do dia da correção, que era **dado remanescente, corrompido antes da
  correção existir** — não uma falha nova na query de leitura da tela de endereçamento
  (`fAbreConsulta`), que apenas reflete fielmente o que está gravado em `DIGCON`. **Confirmado pelo
  usuário que este documento (`000000009881`) está fora do escopo do requisito** — o documento
  original é a NF `000000009771` (seção 4).

## 6. Decisões de escopo

**Incluído:** causa raiz da duplicação em `DIGCON` (Notas 2/3); correção completa da trava
`pValQtdEnderecada`, incluindo a subtração de `FDO_QTDBAI` já planejada em `tasks.md` (Nota 4);
ajuste do `blnSalvar` em `untEntEnderecamentoProduto.pas` (Nota 4).

**Excluído/pendente, registrado para não ser esquecido:**
- **Dados já corrompidos em produção antes desta correção** (ex.: o `DIGCON` do
  `FATGOR='00100000000589742001'`, seção 5) continuam com `DIC_QTDITE` em dobro — a correção
  impede duplicação **futura**, não corrige retroativamente o que já está errado no banco. Não foi
  levantado nesta sessão quantas outras linhas de `DIGCON` estão nesse estado; se necessário, um
  script de correção de dados é uma frente separada.
- **`Achado 1`/`Achado 2`** (Passo 1 de `investigacao_historico_Req459132.md`): ao liberar a
  pré-nota sem conferir, `DIGCON` é gravado com a quantidade cheia do pedido e `DIC_SEMCON='N'`
  (como se tivesse sido conferido de fato) — comportamento suspeito, não corrigido nesta sessão (a
  correção aplicada resolve a duplicação decorrente disso, não a gravação inicial em si).
- **Teste de regressão** (cenário sem divergência, TA gravada normalmente) não foi validado
  manualmente nesta sessão — só o cenário com divergência real (seção 4).
- Alinhamento com o solicitante sobre `CFG_CONEND` × `CFG_COFEND` (item já registrado em
  `tasks.md`, não retomado aqui).

## 7. Réplica em cópias de trabalho irmãs

A mesma correção (Notas 2, 3 e 4 — não a Nota 1, que já estava aplicada independentemente antes
desta sessão em algumas cópias) foi replicada, nos mesmos 3 arquivos, nas working copies:

- `379.48.2.30.74.150.100`
- `379.48.2.30.74.150`

**Diferença estrutural encontrada e adaptada:** em `untTransferenciaArmazens.pas`, nessas duas
cópias, as chamadas `qryQtdEnderecada := fCriaQuery` / `qryPedidoEnderecamento := fCriaQuery` estão
**antes** do `Try` (em `379.48.2.30.74.150.45` estão dentro dele) — divergência de formatação
histórica entre as cópias, sem efeito funcional. A declaração das novas variáveis locais
(`strDocEnd`, `blnCofEndLocal`, `blnUDEVMELocal`) e o cálculo de `blnCofEndLocal`/`blnUDEVMELocal`
foram adaptados para essa estrutura; o restante da correção (as duas queries de
`pValQtdEnderecada`, `untTDistribuicaoConferencia.pas`, `untEntEnderecamentoProduto.pas`) é
byte-idêntico ao aplicado em `379.48.2.30.74.150.45` (confirmado via `svn diff`/`patch --dry-run`
antes de aplicar).

Validado nas 3 cópias (9 arquivos = 3 arquivos × 3 cópias): sem marcador de corrupção
(`\xef\xbf\xbd`), decodifica sem erro em cp1252, CRLF preservado em 100% das linhas. Rodada também
a skill `corrigeUnitFlipCRLF-LF` em modo bulk nas 3 cópias — nenhum ruído de EOL/encoding
encontrado; `svn diff` mostra só as alterações pretendidas em cada arquivo.

## 8. Lições de ferramenta/processo

- **`patch`/`diff` genérico não deve ser usado para replicar a correção entre cópias** — o próprio
  `patch --dry-run` avisou "Stripping trailing CRs from patch" (risco de achatar CRLF→LF em um
  arquivo cp1252/CRLF, corrompendo o encoding silenciosamente da mesma forma que a ferramenta
  `Edit` genérica). Usado só como diagnóstico (`--dry-run`, para localizar divergências estruturais
  entre cópias antes de editar); a aplicação real sempre foi feita via Python com encoding e EOL
  explícitos, replay manual dos mesmos trechos.
- **`svn diff` da working copy inteira antes de replicar** é a forma mais confiável de obter o
  "antes/depois" exato de uma correção multi-arquivo já aplicada, para depois reconstruir os mesmos
  `old`/`new` em outra cópia — mais seguro do que tentar lembrar/reconstruir manualmente cada edição
  já feita em conversas longas.

## 9. Notas Referenciadas no Código-Fonte

> Numeração contínua a partir da Nota 1, já registrada em
> `otimizacaoLocateFgoDocend_Req459132.md` (mesmo requisito, arquivo dedicado à troca de `LOCATE`
> por igualdade em `FGO_DOCEND`, tema independente desta correção).

### Nota 2

**Arquivo/Unit:** `padra_atualizado/fontes/genericos/untTDistribuicaoConferencia.pas`
**Funções:** `TDistribuicaoConferencia.AdicionarConferenciaAnterior`,
`TDistribuicaoConferencia.CarregarDadosDigCon`.

**Explicação completa:** o casamento usado para "lembrar quanto já foi liberado/conferido
anteriormente" para um item, ao recarregar a conferência numa segunda passada (ex.: durante a
efetivação fiscal da entrada, `TEfetivaMovimentoFiscal`), era feito por `CodItem + SeqFatDor`
(`AdicionarConferenciaAnterior`) e a busca do `DIGCON` já gravado usava `DIC_SEQGER`
(`CarregarDadosDigCon`). Os dois campos (`DIC_SEQDOR`/`DIC_SEQGER`) ficam **vazios** na primeira
gravação do `DIGCON` (ao liberar uma pré-nota sem conferência completa), porque, nesse momento, o
`FATDOR`/`FATGOR` (linha/cabeçalho do pedido de reserva de estoque) ainda não existe — só é criado
em uma etapa posterior do mesmo pipeline de entrada. Quando a segunda passada roda (o `FATDOR` já
existe nesse ponto), o casamento por `SeqFatDor`/`DIC_SEQGER` **falha silenciosamente** (compara
valor preenchido contra o `''` lido de volta do banco), a quantidade "já liberada" nunca é
restaurada (fica em 0), e o sistema recalcula a quantidade do item do zero (100% do pedido) — que
depois é **somada** (não substituída) ao valor já existente em `DIGCON.DIC_QTDITE`, duplicando-o.

**Por que não é óbvio e por que uma revisão futura não deve reverter para `SeqFatDor`/`DIC_SEQGER`
achando que é "mais preciso":** `SeqFatDor`/`DIC_SEQGER` parecem, à primeira vista, a chave mais
natural (afinal, o item pertence a um `FATDOR`/pedido específico) — mas são instáveis justamente no
cenário que mais importa (liberação sem conferência completa), porque o `FATDOR` correspondente
ainda não existe no momento da primeira gravação. `SeqMovDet`/`DIC_MOVDET` (o item de movimento de
estoque físico, `MOVDET`) é estável desde a primeira gravação em ambos os casos, e `DIC_IDEDIG`
(identificador da digitação de conferência) também — por isso a troca. Reverter para a chave antiga
reintroduz a duplicação silenciosamente, sem qualquer erro visível até alguém notar a quantidade em
dobro em `DIGCON`/no endereçamento — ver detalhes completos e evidência de `LOGREP` em
`investigacao_historico_Req459132.md` (Passo 2) e neste arquivo, seção 2.

### Nota 3

**Arquivo/Unit:** `padra_atualizado/fontes/genericos/untTDistribuicaoConferencia.pas`
**Função:** `TDistribuicaoConferencia.AtualizaDigCon` (query `FQryUpdateDigCon`).

**Explicação completa:** o `UPDATE DIGCON` que atualiza `DIC_QTDITE` era estritamente aditivo
(`DIC_QTDITE = IFNULL(DIC_QTDITE, 0) + :DIC_QTDITE`), sem qualquer teto. Adicionada trava de
segurança complementar à correção da Nota 2: `DIC_QTDITE = LEAST(IFNULL(DIC_QTDITE, 0) +
:DIC_QTDITE, :DIC_QTDTOT)`, garantindo que, mesmo que algum outro caminho no sistema — hoje ainda
não mapeado, ou que venha a ser introduzido no futuro — some quantidade indevidamente sobre um
`DIGCON` já existente, o valor final nunca ultrapasse a quantidade real do pedido (`DIC_QTDTOT`).

**Por que não é óbvio e por que uma revisão futura não deve remover este `LEAST` achando-o
redundante com a correção da Nota 2:** a Nota 2 corrige a causa raiz **conhecida e confirmada** da
duplicação (reconciliação por chave instável). Este `LEAST` é uma **rede de segurança
independente**, que não depende de a Nota 2 estar correta ou completa — protege contra qualquer
outro caminho de código, presente ou futuro, que possa gravar em `DIGCON` de forma aditiva sem essa
mesma reconciliação. Removê-lo por parecer "código morto" (já que, com a Nota 2 aplicada, ele nunca
deveria efetivamente cortar nenhum valor em circunstâncias normais) elimina essa proteção
silenciosamente.

### Nota 4

**Arquivos/Units:**
`padra_atualizado/fontes/movimentacaoitens/untTransferenciaArmazens.pas`
(`TTransferenciaArmazens.fGeraTransferencia`, procedure aninhada `pValQtdEnderecada`) e
`padra_atualizado/fontes/movimentacaoitens/untEntEnderecamentoProduto.pas`
(`TfrmEntEnderecamentoProduto.btnConfirmaClick`).

**Explicação completa:** `pValQtdEnderecada` é a trava defensiva que compara a quantidade a
endereçar contra a quantidade pendente do pedido de reserva de estoque, abortando a gravação da TA
em caso de divergência. Ela lia o pedido **exclusivamente** das tabelas de histórico
(`DEL_FATGOR`/`DEL_EXTGOR`/`DEL_FATDOR`/`DEL_EXTDOR`), populadas só quando o pedido é totalmente
processado e arquivado (`fApagaPedidoReservaEstoque`, chamado em
`TfrmEntEnderecamentoProduto.btnConfirmaClick`). Esse arquivamento é **pulado deliberadamente**
quando `blnCofEnd or blnUDEVME` (`If (Not blnCofEnd) and (Not blnUDEVME) then ...
fApagaPedidoReservaEstoque`) — e, com `CFG_COFEND='S'` (configuração real desta base), essa condição
nunca é satisfeita: o pedido de reserva permanece nas tabelas **vivas**
(`FATGOR`/`EXTGOR`/`FATDOR`/`EXTDOR`) no momento em que a trava roda. Resultado: a trava nunca
encontrava o pedido, a comparação de quantidade nunca acontecia, e nenhuma exceção era levantada —
mesmo com a TA sendo gravada com o dobro da quantidade real.

Corrigido adicionando, nas duas queries de `pValQtdEnderecada`, um `UNION ALL` contra as tabelas
vivas (condicionado a `blnCofEndLocal or blnUDEVMELocal`, resolvidos localmente com a mesma fórmula
de `TfrmEntEnderecamentoProduto`), e trocando a comparação para a quantidade **pendente**
(`FDO_QTDITE - FDO_QTDBAI`) em vez do total bruto do pedido nesses mesmos ambientes — retomando,
agora efetivamente, a correção que a Fase 2 de `tasks.md` já previa (antes inócua, porque a query
nunca encontrava dado nenhum). Como consequência direta de somar duas fontes (arquivo + viva), a
query foi envolvida numa camada externa que soma novamente por item (`SUM(TAB.QTDAENDERECAR) ...
GROUP BY TAB.CODITEPEDIDO`), para não perder quantidade quando um pedido está **parcialmente**
arquivado (alguns itens já em `DEL_*`, outros ainda vivos) — sem essa camada, o consumo por `Locate`
(que só acha a primeira linha) contabilizaria só uma das duas partes. Por fim, incluído `blnSalvar`
no `If` que grava `FATEND`/quantidade parcial em `untEntEnderecamentoProduto.pas`, para que esse
efeito colateral não seja gravado quando a trava corrigida já tiver abortado a operação.

**Por que não é óbvio e por que uma revisão futura não deve simplificar removendo o `UNION ALL`
contra as tabelas vivas (achando-o desnecessário) nem revertendo o `blnSalvar`:** a ausência de
resultado da trava em ambientes `CFG_COFEND='S'` não gera nenhum erro nem log — é um silêncio
completo, indistinguível de "não havia divergência para relatar". Sem o contexto desta investigação
(rastreamento de `LOGREP`, leitura de `fApagaPedidoReservaEstoque`/`pValQtdEnderecada`), o
comportamento parece correto (a TA é gravada sem erro) quando na verdade a validação simplesmente
não rodou. Da mesma forma, remover o `blnSalvar` do segundo `If` (achando que a trava já garante
tudo, já que ela levanta exceção) reintroduz a gravação do efeito colateral em `FATEND`/`FDO_QTDBAI`
antes do `fRollBack` da transação, mesmo com a TA principal sendo corretamente abortada — validado
com caso real (seção 4 deste documento e Passo 8 de `investigacao_historico_Req459132.md`).

## 10. Referências cruzadas

- `investigacao_historico_Req459132.md` (Passos 1 a 8) — registro cronológico completo desta
  investigação, incluindo trechos de código, evidências de `LOGREP` e a validação com caso real.
- `otimizacaoLocateFgoDocend_Req459132.md` — Nota 1, troca de `LOCATE` por igualdade em
  `FGO_DOCEND`, mesma procedure `pValQtdEnderecada`, tema independente desta correção.
- `tasks.md` — atualizado com o status real da Fase 2 (implementação) e Fase 3 (testes) desta
  correção.
- `conhecimentoUnitsInvestigadas_Req459132.md`, `validacaoDivergenciaEnderecamento_Req459132.md`,
  `spec.md`, `plan.md` — documentação da frente de investigação anterior a esta sessão; ver Passo 3
  de `investigacao_historico_Req459132.md` para o comparativo entre o que esses arquivos já
  registravam e o que esta investigação confirmou/superou.
